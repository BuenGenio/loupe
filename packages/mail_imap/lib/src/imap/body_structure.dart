/// IMAP BODYSTRUCTURE: model, parser and part selection.
library;

import 'package:mail_model/mail_model.dart';

import '../mime/encoded_words.dart';
import 'protocol.dart';
import 'values.dart';

/// One node of a message's MIME tree.
final class BodyNode {
  BodyNode({
    required this.type,
    required this.subtype,
    required this.section,
    this.params = const {},
    this.id,
    this.encoding,
    this.size = 0,
    this.disposition,
    this.dispositionParams = const {},
    List<BodyNode>? children,
  }) : children = children ?? [];

  /// Lower-cased top-level type, e.g. `text`, `multipart`.
  final String type;

  /// Lower-cased subtype, e.g. `plain`, `alternative`.
  final String subtype;

  /// IMAP section ("1", "2.1"); empty for a multipart root.
  final String section;

  /// Content-Type parameters (lower-cased keys, decoded values).
  final Map<String, String> params;

  /// Content-ID as sent (usually with angle brackets).
  final String? id;

  /// Lower-cased Content-Transfer-Encoding.
  final String? encoding;

  /// Size in bytes in its transfer encoding.
  final int size;

  /// Lower-cased Content-Disposition type (`inline`, `attachment`).
  final String? disposition;
  final Map<String, String> dispositionParams;
  final List<BodyNode> children;

  bool get isMultipart => type == 'multipart';
  bool get isText => type == 'text';
  bool get isMessage => type == 'message' && (subtype == 'rfc822' || subtype == 'global');
  String get mimeType => '$type/$subtype';
  String? get charset => params['charset'];
  String? get filename => _nonEmpty(dispositionParams['filename']) ?? _nonEmpty(params['name']);
  bool get isAttachmentDisposition => disposition == 'attachment';
  bool get isFlowed => (params['format'] ?? '').toLowerCase() == 'flowed';
  bool get isDelSp => (params['delsp'] ?? '').toLowerCase() == 'yes';

  /// Content-ID without angle brackets.
  String? get contentId {
    final raw = id?.trim();
    if (raw == null || raw.isEmpty) return null;
    return raw.startsWith('<') && raw.endsWith('>') ? raw.substring(1, raw.length - 1) : raw;
  }

  /// Estimated decoded size.
  int get decodedSize => encoding == 'base64' ? size * 3 ~/ 4 : size;

  /// All nodes, depth first.
  Iterable<BodyNode> get all sync* {
    yield this;
    for (final c in children) {
      yield* c.all;
    }
  }

  /// The node with [section], if any.
  BodyNode? find(String section) {
    for (final n in all) {
      if (n.section == section && !n.isMultipart) return n;
    }
    for (final n in all) {
      if (n.section == section) return n;
    }
    return null;
  }

  @override
  String toString() => '$section:$mimeType${children.isEmpty ? '' : children.toString()}';
}

String? _nonEmpty(String? s) => s == null || s.trim().isEmpty ? null : s.trim();

String _childSection(String parent, int index) => parent.isEmpty ? '${index + 1}' : '$parent.${index + 1}';

/// Parses the elements of a BODYSTRUCTURE (the children of the
/// `BODYSTRUCTURE` value).
BodyNode parseBodyStructure(List<ImapValue> elements) => _parseNode(elements, '', root: true);

BodyNode _parseNode(List<ImapValue> e, String section, {bool root = false}) {
  if (e.isNotEmpty && isList(e.first)) {
    final children = <BodyNode>[];
    var i = 0;
    while (i < e.length && isList(e[i])) {
      children.add(_parseNode(e[i].children!, _childSection(section, children.length)));
      i++;
    }
    final subtype = (i < e.length ? stringOf(e[i]) : null)?.toLowerCase() ?? 'mixed';
    i++;
    final params = i < e.length ? _params(e[i]) : const <String, String>{};
    i++;
    final (disposition, dispositionParams) = i < e.length ? _disposition(e[i]) : (null, const <String, String>{});
    return BodyNode(
      type: 'multipart',
      subtype: subtype,
      section: section,
      params: params,
      disposition: disposition,
      dispositionParams: dispositionParams,
      children: children,
    );
  }
  // A single part. A non-multipart root is part "1".
  final own = root ? '1' : section;
  String? at(int i) => i < e.length ? stringOf(e[i]) : null;
  final type = (at(0) ?? 'text').toLowerCase();
  final subtype = (at(1) ?? 'plain').toLowerCase();
  final params = e.length > 2 ? _params(e[2]) : const <String, String>{};
  final id = at(3);
  final encoding = at(5)?.toLowerCase();
  final size = int.tryParse(at(6) ?? '') ?? 0;
  var ext = 7;
  final children = <BodyNode>[];
  if (type == 'text') {
    ext = 8;
  } else if (type == 'message' && (subtype == 'rfc822' || subtype == 'global')) {
    if (e.length > 8 && isList(e[8])) {
      // The encapsulated body: its parts are numbered below this section.
      final inner = _parseNode(e[8].children!, own);
      children.add(inner.isMultipart ? inner : _renumber(inner, '$own.1'));
    }
    ext = 10;
  }
  final (disposition, dispositionParams) = ext + 1 < e.length
      ? _disposition(e[ext + 1])
      : (null, const <String, String>{});
  return BodyNode(
    type: type,
    subtype: subtype,
    section: own,
    params: params,
    id: id,
    encoding: encoding,
    size: size,
    disposition: disposition,
    dispositionParams: dispositionParams,
    children: children,
  );
}

BodyNode _renumber(BodyNode n, String section) => BodyNode(
  type: n.type,
  subtype: n.subtype,
  section: section,
  params: n.params,
  id: n.id,
  encoding: n.encoding,
  size: n.size,
  disposition: n.disposition,
  dispositionParams: n.dispositionParams,
  children: n.children,
);

Map<String, String> _params(ImapValue v) {
  final list = v.children;
  if (!isList(v) || list == null) return const {};
  final raw = <String, String>{};
  for (var i = 0; i + 1 < list.length; i += 2) {
    final k = stringOf(list[i]);
    final val = stringOf(list[i + 1]);
    if (k != null && val != null) raw[k] = val;
  }
  return normalizeParameters(raw);
}

(String?, Map<String, String>) _disposition(ImapValue v) {
  final list = v.children;
  if (!isList(v) || list == null || list.isEmpty) return (null, const {});
  final type = stringOf(list.first)?.toLowerCase();
  return (type, list.length > 1 ? _params(list[1]) : const {});
}

/// Parts that are signatures or similar plumbing, never shown as attachments.
bool _isPlumbing(BodyNode n) =>
    n.mimeType == 'application/pgp-signature' ||
    n.mimeType == 'application/pkcs7-signature' ||
    n.mimeType == 'application/x-pkcs7-signature' ||
    n.mimeType == 'application/pgp-keys' && n.filename == null ||
    n.mimeType == 'application/ms-tnef' ||
    n.mimeType == 'text/calendar' && n.filename == null && n.disposition != 'attachment';

/// Whether a leaf is a body text candidate (inline text without a file name).
bool _isBodyText(BodyNode n) =>
    n.isText && (n.subtype == 'plain' || n.subtype == 'html') && !n.isAttachmentDisposition && n.filename == null;

/// What the reader shows as the message body.
final class DisplayParts {
  const DisplayParts(this.html, this.text);

  /// text/html parts to concatenate.
  final List<BodyNode> html;

  /// text/plain parts to concatenate.
  final List<BodyNode> text;

  Iterable<BodyNode> get all => {...html, ...text};
}

/// Chooses the body parts (Thunderbird-like): in multipart/alternative the
/// richest HTML and the plain part; in multipart/related the root; in
/// multipart/mixed the first part plus further inline text parts.
DisplayParts selectDisplayParts(BodyNode root) {
  final html = <BodyNode>[];
  final text = <BodyNode>[];
  _select(root, html, text);
  return DisplayParts(html, text);
}

void _select(BodyNode n, List<BodyNode> html, List<BodyNode> text) {
  if (!n.isMultipart) {
    if (_isBodyText(n) || (n.isText && n.section == '1' && !n.isAttachmentDisposition)) {
      (n.subtype == 'html' ? html : text).add(n);
    }
    return;
  }
  if (n.children.isEmpty) return;
  switch (n.subtype) {
    case 'alternative':
      BodyNode? htmlChoice;
      BodyNode? textChoice;
      for (final c in n.children) {
        if (c.isMultipart || (c.isText && c.subtype == 'html')) {
          if (_containsHtml(c)) htmlChoice = c;
          if (c.isMultipart && !_containsHtml(c) && _containsPlain(c)) textChoice ??= c;
        } else if (c.isText && c.subtype == 'plain') {
          textChoice ??= c;
        }
      }
      if (htmlChoice != null) {
        final t = <BodyNode>[];
        _select(htmlChoice, html, t);
        if (textChoice == null) text.addAll(t);
      }
      if (textChoice != null) _select(textChoice, <BodyNode>[], text);
    case 'related':
      final start = n.params['start'];
      final root = start == null
          ? n.children.first
          : n.children.firstWhere((c) => c.id?.trim() == start.trim(), orElse: () => n.children.first);
      _select(root, html, text);
    case 'signed':
      _select(n.children.first, html, text);
    case 'encrypted':
      return;
    default:
      _select(n.children.first, html, text);
      // Further inline text parts (list footers, Apple Mail's split HTML).
      for (final c in n.children.skip(1)) {
        final h = <BodyNode>[];
        final t = <BodyNode>[];
        if (_isBodyText(c)) {
          (c.subtype == 'html' ? h : t).add(c);
        } else if (c.isMultipart && c.subtype == 'alternative') {
          _select(c, h, t);
        }
        if (html.isNotEmpty) html.addAll(h);
        text.addAll(t);
      }
  }
}

bool _containsHtml(BodyNode n) => n.all.any((x) => x.isText && x.subtype == 'html' && !x.isAttachmentDisposition);
bool _containsPlain(BodyNode n) => n.all.any((x) => x.isText && x.subtype == 'plain' && !x.isAttachmentDisposition);

/// The part a preview is made from: the first inline text/plain body part,
/// else the first text/html one.
BodyNode? selectPreviewPart(BodyNode root) {
  final parts = selectDisplayParts(root);
  if (parts.text.isNotEmpty) return parts.text.first;
  if (parts.html.isNotEmpty) return parts.html.first;
  return null;
}

/// Attachments and inline parts (everything that is not a body part), as the
/// mail model describes them. message/rfc822 parts are one attachment.
List<Attachment> listAttachments(BodyNode root) {
  final body = selectDisplayParts(root).all.toSet();
  final result = <Attachment>[];
  void visit(BodyNode n, {required bool inRelated}) {
    if (n.isMultipart) {
      if (n.subtype == 'encrypted') return;
      for (final c in n.children) {
        visit(c, inRelated: inRelated || n.subtype == 'related');
      }
      return;
    }
    if (body.contains(n) || _isPlumbing(n)) return;
    final cid = n.contentId;
    var name = n.filename;
    if (name == null && n.isMessage) name = 'message.eml';
    result.add(
      Attachment(
        partId: n.section,
        mimeType: n.mimeType,
        filename: name,
        size: n.decodedSize,
        contentId: cid,
        isInline: !n.isAttachmentDisposition && (inRelated || n.disposition == 'inline') && cid != null,
      ),
    );
  }

  visit(root, inRelated: false);
  return result;
}

/// Whether the message is encrypted: PGP/MIME (`multipart/encrypted`), or
/// S/MIME enveloped data (`application/pkcs7-mime` that isn't signed-data or
/// certificates only, also as `x-pkcs7-mime` or an octet-stream `.p7m`).
/// Inline PGP inside a text part can't be told from the structure.
bool isEncryptedStructure(BodyNode root) {
  if (root.isMultipart) return root.subtype == 'encrypted';
  final smimeType = (root.params['smime-type'] ?? '').toLowerCase();
  if (root.mimeType == 'application/pkcs7-mime' || root.mimeType == 'application/x-pkcs7-mime') {
    return smimeType != 'signed-data' && smimeType != 'certs-only';
  }
  return root.mimeType == 'application/octet-stream' && (root.filename ?? '').toLowerCase().endsWith('.p7m');
}

/// Whether the list should show a paperclip: any attachment the user would
/// see (inline images referenced from HTML don't count).
bool hasVisibleAttachment(BodyNode root) => listAttachments(root).any((a) => !a.isInline || a.contentId == null);
