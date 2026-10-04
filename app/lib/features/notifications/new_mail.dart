import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mail_model/mail_model.dart';

/// A message that arrived since the last check.
@immutable
final class NewMail {
  const NewMail(this.email, {required this.fromVip});

  final EmailSummary email;

  /// The sender is a VIP.
  final bool fromVip;
}

/// The newest arrival seen in one list: its time, and the ids received at
/// that very time (servers store seconds, so several can share it).
@immutable
final class Watermark {
  const Watermark(this.newest, [this.idsAtNewest = const {}]);

  final DateTime newest;
  final Set<String> idsAtNewest;

  bool isNewer(EmailSummary e) =>
      e.receivedAt.isAfter(newest) || (e.receivedAt == newest && !idsAtNewest.contains(e.id));

  /// This mark moved up to the newest of [emails].
  Watermark advancedTo(Iterable<EmailSummary> emails) {
    var newest = this.newest;
    var ids = idsAtNewest;
    for (final e in emails) {
      if (e.receivedAt.isAfter(newest)) {
        newest = e.receivedAt;
        ids = {e.id};
      } else if (e.receivedAt == newest && !ids.contains(e.id)) {
        ids = {...ids, e.id};
      }
    }
    return Watermark(newest, ids);
  }

  Map<String, Object?> toJson() => {'t': newest.millisecondsSinceEpoch, 'ids': idsAtNewest.toList()};

  static Watermark fromJson(Map<String, Object?> j) => Watermark(DateTime.fromMillisecondsSinceEpoch(j['t']! as int), {
    for (final id in j['ids'] as List<Object?>? ?? const []) id! as String,
  });
}

/// What the detector remembers between checks: a watermark per inbox, one
/// for VIP mail anywhere, and when the last check started.
@immutable
final class NewMailState {
  const NewMailState({this.lastCheck, this.marks = const {}});

  final DateTime? lastCheck;

  /// By mailbox id, and [vipKey] for VIP mail in any mailbox.
  final Map<String, Watermark> marks;

  static const vipKey = 'vip';

  Map<String, Object?> toJson() => {
    'lastCheck': lastCheck?.millisecondsSinceEpoch,
    'marks': {for (final MapEntry(:key, :value) in marks.entries) key: value.toJson()},
  };

  static NewMailState fromJson(Map<String, Object?> j) => NewMailState(
    lastCheck: switch (j['lastCheck']) {
      final int t => DateTime.fromMillisecondsSinceEpoch(t),
      _ => null,
    },
    marks: {
      for (final MapEntry(:key, :value) in (j['marks'] as Map<String, Object?>? ?? const {}).entries)
        key: Watermark.fromJson((value! as Map).cast<String, Object?>()),
    },
  );
}

/// Where [NewMailState] lives between checks: a JSON file, read fresh each
/// time because the app and background isolates take turns writing it.
abstract interface class NewMailStateStore {
  Future<NewMailState> read();
  Future<void> write(NewMailState state);
}

/// `new_mail.json` in [directory] (the app support directory).
final class FileNewMailStateStore implements NewMailStateStore {
  FileNewMailStateStore(this.directory);

  final Future<Directory> directory;

  Future<File> get _file async => File('${(await directory).path}/new_mail.json');

  @override
  Future<NewMailState> read() async {
    try {
      final text = await (await _file).readAsString();
      return NewMailState.fromJson((jsonDecode(text) as Map).cast<String, Object?>());
    } on Object {
      // Missing or unreadable: every list starts over, quietly.
      return const NewMailState();
    }
  }

  @override
  Future<void> write(NewMailState state) async {
    final file = await _file;
    await file.parent.create(recursive: true);
    final temp = File('${file.path}.tmp');
    await temp.writeAsString(jsonEncode(state.toJson()), flush: true);
    await temp.rename(file.path);
  }
}

/// Keeps the state in memory (tests).
final class MemoryNewMailStateStore implements NewMailStateStore {
  NewMailState state = const NewMailState();

  @override
  Future<NewMailState> read() async => state;

  @override
  Future<void> write(NewMailState state) async => this.state = state;
}

/// The result of [detectNewMail]: what to notify about, oldest first, and
/// the state to remember.
typedef Detection = ({List<NewMail> mail, NewMailState state});

/// Finds mail that arrived since [state] was taken: unread messages in the
/// inboxes, and from VIPs in any mailbox.
///
/// - An inbox (or the VIP list) seen for the first time only sets its
///   watermark: the first sync of a new account never notifies.
/// - A message counts if it is newer than its list's watermark and arrived
///   after the previous check started, less [grace] (late syncs, clock
///   drift). Older mail that turns up later (loaded on scroll, moved back
///   to the inbox, a folder synced for the first time) stays quiet.
/// - Read messages, drafts, junk and mail from the user's own addresses
///   never count; the watermarks move past them all the same.
///
/// Each list is looked at down to its [depth] newest messages.
Future<Detection> detectNewMail(
  MailRepository repository,
  NewMailState state, {
  required DateTime now,
  Duration grace = const Duration(hours: 1),
  int depth = 50,
}) async {
  final accounts = await repository.watchAccounts().first;
  final mailboxes = await repository.watchMailboxes().first;
  final vips = await repository.watchVipAddresses().first;
  final own = {
    for (final a in accounts) ...[a.email.toLowerCase(), for (final i in a.identities) i.email.toLowerCase()],
  };
  final floor = state.lastCheck?.subtract(grace);
  final marks = <String, Watermark>{};
  final found = <String, NewMail>{};

  bool isVip(EmailSummary e) => e.from.any((a) => vips.contains(a.email.toLowerCase()));
  bool counts(EmailSummary e) =>
      !e.isSeen &&
      !e.isDraft &&
      !e.keywords.contains(Keywords.junk) &&
      !e.from.any((a) => own.contains(a.email.toLowerCase())) &&
      (floor == null || e.receivedAt.isAfter(floor));

  final inboxes = [
    for (final m in mailboxes)
      if (m.role == MailboxRole.inbox && m.isSelectable) m.id,
  ];

  Future<void> scan(String key, MailboxRef ref, {bool Function(EmailSummary e)? where}) async {
    final list = [for (final t in await repository.watchList(ref, threaded: false, limit: depth).first) t.latest];
    final mark = state.marks[key];
    if (mark == null) {
      // First sight: remember where it stands. An empty list starts now, so
      // its first sync later stays quiet too.
      marks[key] = list.isEmpty ? Watermark(now) : Watermark(list.first.receivedAt).advancedTo(list);
      return;
    }
    for (final e in list) {
      if (mark.isNewer(e) && counts(e) && (where?.call(e) ?? true)) {
        found[e.id] = NewMail(e, fromVip: isVip(e));
      }
    }
    marks[key] = mark.advancedTo(list);
  }

  for (final id in inboxes) {
    await scan(id, RealMailboxRef(id));
  }
  // VIP mail in the inboxes is the inboxes' business (a sender who just
  // became a VIP doesn't notify again); this finds it in other mailboxes.
  if (vips.isNotEmpty || state.marks.containsKey(NewMailState.vipKey)) {
    await scan(
      NewMailState.vipKey,
      const VirtualMailboxRef(VirtualMailbox.vip),
      where: (e) => !inboxes.contains(e.mailboxId),
    );
  }
  final mail = found.values.toList()..sort((a, b) => a.email.receivedAt.compareTo(b.email.receivedAt));
  // Marks of inboxes that are gone are dropped with them.
  return (mail: mail, state: NewMailState(lastCheck: now, marks: marks));
}
