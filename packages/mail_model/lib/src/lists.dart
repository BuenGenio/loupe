// Mailing lists: the List-* headers (RFC 2369, RFC 2919, RFC 8058) and the
// `[PATCH v2 3/7]` tags of `git format-patch` subjects.

import 'address.dart';
import 'email.dart';

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

// ---------------------------------------------------------------------------
// Mailing lists and muted threads

/// A mailing list the user gets mail from: the messages that share a List-Id,
/// across accounts, outside Trash and Junk.
final class MailingList {
  const MailingList({
    required this.id,
    required this.name,
    this.postAddress,
    this.messageCount = 0,
    this.unreadCount = 0,
    this.lastActivity,
    this.accountIds = const [],
  });

  /// The List-Id identifier, lower-cased: `dev.lists.example.org`.
  final String id;

  /// The List-Id phrase of the newest message that has one, else [id].
  final String name;

  /// Where to post (List-Post), if the list allows posting.
  final EmailAddress? postAddress;
  final int messageCount;

  /// Unread messages outside muted threads.
  final int unreadCount;
  final DateTime? lastActivity;

  /// The accounts that receive the list.
  final List<String> accountIds;

  @override
  bool operator ==(Object other) =>
      other is MailingList &&
      other.id == id &&
      other.name == name &&
      other.postAddress == postAddress &&
      other.messageCount == messageCount &&
      other.unreadCount == unreadCount &&
      other.lastActivity == lastActivity &&
      _listEquals(other.accountIds, accountIds);

  @override
  int get hashCode => Object.hash(id, name, messageCount, unreadCount, lastActivity);
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// One conversation of a mailing list, as the forum-style list view shows
/// it. Only the conversation's messages that came through the list count.
final class ListThread {
  const ListThread({
    required this.threadId,
    required this.first,
    required this.latest,
    required this.messageCount,
    this.unreadCount = 0,
    this.participants = const [],
    this.patchCount = 0,
    this.isMuted = false,
  });

  final String threadId;

  /// The oldest message: its subject names the thread, its sender started it.
  final EmailSummary first;

  /// The newest message: the last activity.
  final EmailSummary latest;
  final int messageCount;
  final int unreadCount;

  /// Distinct senders, in the order they first wrote.
  final List<EmailAddress> participants;

  /// Patches of the series [patch] names that arrived (`[PATCH v2 2/3]`
  /// subjects that aren't replies; the cover letter doesn't count).
  final int patchCount;
  final bool isMuted;

  int get replyCount => messageCount > 0 ? messageCount - 1 : 0;
  DateTime get lastActivity => latest.receivedAt;

  /// The patch tag of the thread's first message, if it is a patch or a
  /// cover letter.
  PatchTag? get patch {
    final tag = PatchTag.parse(first.subject);
    return tag == null || tag.isReply ? null : tag;
  }

  /// How many patches of a series arrived among [subjects]: distinct
  /// positions of `[PATCH …]` subjects that aren't replies (cover letters
  /// don't count), of [series]'s version when it is given.
  static int countPatches(Iterable<String> subjects, {PatchTag? series}) {
    final positions = <int>{};
    for (final s in subjects) {
      final tag = PatchTag.parse(s);
      if (tag == null || tag.isReply || tag.isCoverLetter) continue;
      if (series != null && !series.isReply && tag.version != series.version) continue;
      positions.add(tag.index ?? 1);
    }
    return positions.length;
  }

  /// "PATCH v2 3/3" for a series (patches arrived / announced), else the
  /// tag's own label ("PATCH", "RFC PATCH 2/5"); null for a discussion.
  String? get patchBadge {
    final tag = patch;
    if (tag == null) return null;
    final total = tag.total;
    if (total == null || (!tag.isCoverLetter && total <= 1)) return tag.label;
    if (!tag.isCoverLetter && patchCount <= 1) return tag.label;
    final head = [tag.prefix, if (tag.version > 1) 'v${tag.version}'].join(' ');
    return '$head ${patchCount.clamp(0, total)}/$total';
  }
}

/// Mailing lists (grouped by List-Id) and muted threads. The repositories
/// implement it next to `MailRepository`; check with `repository is
/// MailingLists`. All `watch*` streams emit the current value at once and
/// again whenever it changes.
///
/// Muting is local to the device: a muted conversation leaves the list
/// view, its unread messages are marked read, and later messages of it
/// arrive read, so they never notify.
abstract interface class MailingLists {
  /// Lists with mail outside Trash and Junk, most recent activity first.
  Stream<List<MailingList>> watchMailingLists();

  /// The conversations of list [listId], most recent activity first. Muted
  /// ones only with [includeMuted].
  Stream<List<ListThread>> watchListThreads(String listId, {bool includeMuted = false, int limit = 200});

  /// Ids of the muted conversations, of all accounts.
  Stream<Set<String>> watchMutedThreads();

  /// Mutes or unmutes the conversation [emailId] belongs to.
  Future<void> setThreadMuted(String emailId, {required bool muted});
}
