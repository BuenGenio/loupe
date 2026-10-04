import 'keywords.dart';
import 'mailbox.dart';

/// The snooze convention shared with other clients (see
/// `docs/snooze-convention.md`): a snoozed message waits in a top-level
/// `Snoozed` folder with a `$snoozed-<UTC epoch minutes>` keyword, and the
/// first client to sync after that time moves it back to the Inbox, unread
/// and with `$new` ([Keywords.newAgain]).
abstract final class Snooze {
  /// Name of the folder snoozed messages wait in, at the top level.
  static const folderName = 'Snoozed';

  /// Keywords holding a wake time start with this; the rest is the time in
  /// whole minutes since 1970-01-01 00:00 UTC, in decimal.
  static const keywordPrefix = r'$snoozed-';

  static final _keyword = RegExp(r'^\$snoozed-(\d{1,10})$');

  /// The keyword for waking at [wakeAt]: whole minutes since the epoch in
  /// UTC, rounded up so a message never wakes early.
  static String keyword(DateTime wakeAt) {
    final ms = wakeAt.millisecondsSinceEpoch;
    final minutes = (ms + Duration.millisecondsPerMinute - 1) ~/ Duration.millisecondsPerMinute;
    return '$keywordPrefix$minutes';
  }

  /// The wake time [keyword] holds (UTC), or null if it isn't a valid
  /// snooze keyword: another keyword, or a foreign `$snoozed-…` spelling
  /// (signs, fractions, more than ten digits). Case doesn't matter.
  static DateTime? parseKeyword(String keyword) {
    final m = _keyword.firstMatch(Keywords.normalize(keyword));
    if (m == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(int.parse(m[1]!) * Duration.millisecondsPerMinute, isUtc: true);
  }

  /// Whether [keyword] is in the snooze namespace (valid or not). These are
  /// state, never shown as tags.
  static bool isSnoozeKeyword(String keyword) => Keywords.normalize(keyword).startsWith(keywordPrefix);

  /// The valid snooze keywords among [keywords]: what waking or changing
  /// the time removes.
  static Set<String> keywordsIn(Iterable<String> keywords) => {
    for (final k in keywords)
      if (parseKeyword(k) != null) Keywords.normalize(k),
  };

  /// When a message with [keywords] wakes: the earliest valid snooze
  /// keyword (two clients changing the time at once can leave two), or
  /// null if there is none.
  static DateTime? wakeAtOf(Iterable<String> keywords) {
    DateTime? earliest;
    for (final k in keywords) {
      final t = parseKeyword(k);
      if (t != null && (earliest == null || t.isBefore(earliest))) earliest = t;
    }
    return earliest;
  }

  /// Whether [path] is the snooze folder: `Snoozed` at the top level (any
  /// case), or right under the Inbox on servers whose folders all live
  /// there (`INBOX.Snoozed`, `INBOX/Snoozed`).
  static bool isFolderPath(String path) {
    final lower = path.toLowerCase();
    const name = 'snoozed';
    if (lower == name) return true;
    return lower.length == 'inbox'.length + 1 + name.length &&
        lower.startsWith('inbox') &&
        lower.endsWith(name) &&
        const {'.', '/'}.contains(lower['inbox'.length]);
  }

  /// Whether [mailbox] is its account's snooze folder.
  static bool isFolder(Mailbox mailbox) => mailbox.isSelectable && isFolderPath(mailbox.path);
}
