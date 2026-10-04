// Mailing lists: the List-* headers (RFC 2369, RFC 2919, RFC 8058) and the
// `[PATCH v2 3/7]` tags of `git format-patch` subjects.

import 'address.dart';

/// The parts of a List-Id header: the identifier, lower-cased and without
/// angle brackets, and the phrase before it, if any.
typedef ListIdParts = ({String id, String? name});

final _bracketed = RegExp(r'<([^<>]*)>');

/// Parses a List-Id header value (`Example developers <dev.lists.example.org>`).
///
/// Lists that leave out the angle brackets (`dev.lists.example.org`) are
/// accepted when the value is a single dotted word. Returns null for an empty
/// or unusable value.
ListIdParts? parseListId(String? header) {
  if (header == null) return null;
  final value = header.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (value.isEmpty) return null;
  final m = _bracketed.allMatches(value).lastOrNull;
  if (m == null) {
    final bare = value.toLowerCase();
    return RegExp(r'^[^\s<>"]+\.[^\s<>"]+$').hasMatch(bare) ? (id: bare, name: null) : null;
  }
  final id = m[1]!.trim().toLowerCase();
  if (id.isEmpty) return null;
  var name = value.substring(0, m.start).trim();
  // Comments in parentheses aren't part of the phrase.
  name = name.replaceAll(RegExp(r'\([^()]*\)'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  if (name.length >= 2 && name.startsWith('"') && name.endsWith('"')) {
    name = name.substring(1, name.length - 1).replaceAll(r'\"', '"').replaceAll(r'\\', r'\').trim();
  }
  return (id: id, name: name.isEmpty ? null : name);
}

/// The URIs of a List-Unsubscribe, List-Post, List-Help… header (RFC 2369):
/// angle-bracketed and comma-separated, in order of preference. Folding
/// whitespace inside a URI is removed; values that aren't URIs are skipped.
List<Uri> parseListUris(String? header) {
  if (header == null) return const [];
  final out = <Uri>[];
  for (final m in _bracketed.allMatches(header)) {
    final raw = m[1]!.replaceAll(RegExp(r'\s+'), '');
    final uri = Uri.tryParse(raw);
    if (uri != null && uri.scheme.isNotEmpty) out.add(uri);
  }
  return out;
}

/// The address of the first `mailto:` URI of a List-Post header, or null
/// when there is none (or the list says `NO`: posting isn't allowed).
EmailAddress? listPostAddress(String? header) {
  for (final uri in parseListUris(header)) {
    if (uri.scheme.toLowerCase() != 'mailto') continue;
    final address = Uri.decodeComponent(uri.path).trim();
    if (address.contains('@')) return EmailAddress(address);
  }
  return null;
}

/// True when List-Unsubscribe-Post asks for one-click unsubscription
/// (RFC 8058: `List-Unsubscribe=One-Click`). It also needs an `https` URI
/// in List-Unsubscribe to POST to.
bool isOneClickUnsubscribe(String? listUnsubscribePost) =>
    listUnsubscribePost != null &&
    listUnsubscribePost.replaceAll(RegExp(r'\s+'), '').toLowerCase() == 'list-unsubscribe=one-click';

// ---------------------------------------------------------------------------
// git format-patch subjects

final _replyPrefix = RegExp(r'^\s*(re|fwd?|aw|wg|sv|vs|antw|tr|r)(\s*\[\d+\])?\s*[:：]\s*', caseSensitive: false);
final _tag = RegExp(r'\[([^\[\]]*)\]');
final _version = RegExp(r'^v(\d{1,3})$', caseSensitive: false);
final _counter = RegExp(r'^(\d{1,4})/(\d{1,4})$');

/// The `[PATCH …]` tag of a `git format-patch` / `git send-email` subject:
/// `[PATCH]`, `[PATCH v2 3/7]`, `[RFC PATCH net-next v3 00/12]`.
final class PatchTag {
  const PatchTag({this.prefix = 'PATCH', this.version = 1, this.index, this.total, this.isReply = false});

  /// The words of the tag other than the version and the counter, as sent:
  /// `PATCH`, `RFC PATCH`, `PATCH net-next`.
  final String prefix;

  /// The revision of the series (`v2`); 1 when the tag doesn't say.
  final int version;

  /// Position in the series, 0 for the cover letter; null for a lone patch.
  final int? index;

  /// Number of patches in the series; null for a lone patch.
  final int? total;

  /// The subject is a reply or forward (`Re: [PATCH 2/3] …`): a review, not
  /// the patch itself.
  final bool isReply;

  bool get isCoverLetter => index == 0;

  /// "PATCH v2 3/7", "RFC PATCH", "PATCH 0/3".
  String get label =>
      [prefix, if (version > 1) 'v$version', if (index != null && total != null) '$index/$total'].join(' ');

  /// The tag of [subject], or null when it has none. List tags before it
  /// (`[dev] [PATCH 1/2] …`) and reply prefixes are skipped.
  static PatchTag? parse(String subject) {
    var s = subject;
    var reply = false;
    // Reply prefixes and list tags, in any order, before the patch tag.
    for (var guard = 0; guard < 8; guard++) {
      final r = _replyPrefix.firstMatch(s);
      if (r != null) {
        reply = true;
        s = s.substring(r.end);
        continue;
      }
      final t = _tag.matchAsPrefix(s.trimLeft());
      if (t == null) return null;
      final parsed = _parseTag(t[1]!, reply);
      if (parsed != null) return parsed;
      s = s.trimLeft().substring(t.end);
    }
    return null;
  }

  static PatchTag? _parseTag(String inside, bool reply) {
    final words = inside.trim().split(RegExp(r'\s+'));
    // "PATCHv2" is common enough to accept.
    final expanded = <String>[];
    for (final w in words) {
      final glued = RegExp(r'^(PATCH)(v\d{1,3})$', caseSensitive: false).firstMatch(w);
      if (glued != null) {
        expanded.addAll([glued[1]!, glued[2]!]);
      } else {
        expanded.add(w);
      }
    }
    if (!expanded.any((w) => w.toUpperCase() == 'PATCH')) return null;
    var version = 1;
    int? index;
    int? total;
    final prefix = <String>[];
    for (final w in expanded) {
      final v = _version.firstMatch(w);
      final c = _counter.firstMatch(w);
      if (v != null) {
        version = int.parse(v[1]!);
      } else if (c != null) {
        index = int.parse(c[1]!);
        total = int.parse(c[2]!);
      } else if (w.isNotEmpty) {
        prefix.add(w);
      }
    }
    return PatchTag(prefix: prefix.join(' '), version: version, index: index, total: total, isReply: reply);
  }

  @override
  bool operator ==(Object other) =>
      other is PatchTag &&
      other.prefix == prefix &&
      other.version == version &&
      other.index == index &&
      other.total == total &&
      other.isReply == isReply;

  @override
  int get hashCode => Object.hash(prefix, version, index, total, isReply);

  @override
  String toString() => 'PatchTag($label${isReply ? ', reply' : ''})';
}
