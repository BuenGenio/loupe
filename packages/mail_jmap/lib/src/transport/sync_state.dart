/// What a JMAP mailbox sync remembers ([MailboxSyncState] data).
library;

import 'package:mail_model/mail_model.dart';

/// The state of one mailbox's sync.
///
/// JMAP's `Email/changes` is per account, not per mailbox: each mailbox
/// keeps the account's `Email` state string from its last sync, and the
/// emails it holds in the synced window (newest first), to tell what moved
/// in or out since.
final class JmapSyncState {
  const JmapSyncState({
    required this.accountId,
    required this.mailboxId,
    required this.emailState,
    required this.ids,
    this.total = 0,
  });

  static const _version = 1;

  /// The JMAP account and mailbox the state belongs to: another one at the
  /// same path (a mailbox deleted and made again) starts over.
  final String accountId;
  final String mailboxId;

  /// The `Email` state the window is at.
  final String emailState;

  /// JMAP ids of the window's emails, newest first (arrivals since the first
  /// sync at the front, older pages at the end).
  final List<String> ids;

  /// How many emails the mailbox had at the last sync.
  final int total;

  /// More, older emails exist on the server.
  bool get olderExist => total > ids.length;

  static JmapSyncState? fromState(MailboxSyncState? state) {
    final d = state?.data;
    if (d == null || d['jmap'] != _version) return null;
    final account = d['account'];
    final mailbox = d['mailbox'];
    final emailState = d['emailState'];
    if (account is! String || mailbox is! String || emailState is! String) return null;
    return JmapSyncState(
      accountId: account,
      mailboxId: mailbox,
      emailState: emailState,
      ids: [
        for (final id in d['ids'] as List? ?? const [])
          if (id is String) id,
      ],
      total: (d['total'] as num?)?.toInt() ?? 0,
    );
  }

  MailboxSyncState toState() => MailboxSyncState({
    'jmap': _version,
    'account': accountId,
    'mailbox': mailboxId,
    'emailState': emailState,
    'ids': ids,
    'total': total,
  });

  JmapSyncState copyWith({String? emailState, List<String>? ids, int? total}) => JmapSyncState(
    accountId: accountId,
    mailboxId: mailboxId,
    emailState: emailState ?? this.emailState,
    ids: ids ?? this.ids,
    total: total ?? this.total,
  );
}
