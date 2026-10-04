import 'dart:async';

import 'package:mail_model/mail_model.dart';

/// A repository with exactly the mail a test puts in: accounts, mailboxes,
/// messages and VIPs. Lists behave like the store's (newest first, VIP mail
/// outside Trash and Junk).
class FakeMail implements MailRepository {
  final accounts = <MailAccount>[];
  final mailboxes = <Mailbox>[];
  final emails = <String, EmailSummary>{};
  final vips = <String>{};
  final archived = <String>[];

  static int _seq = 0;

  MailAccount account(String id, {String? name, ProviderKind provider = ProviderKind.generic}) {
    final account = MailAccount(
      id: id,
      email: '$id@example.com',
      displayName: name ?? id[0].toUpperCase() + id.substring(1),
      provider: provider,
      authKind: AuthKind.password,
      incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
      identities: [Identity(id: '$id/default', email: '$id@example.com')],
    );
    accounts.add(account);
    for (final (path, role) in const [
      ('INBOX', MailboxRole.inbox),
      ('Archive', MailboxRole.archive),
      ('Lists', MailboxRole.none),
      ('Junk', MailboxRole.junk),
    ]) {
      mailboxes.add(Mailbox(id: MailIds.mailbox(id, path), accountId: id, name: path, path: path, role: role));
    }
    return account;
  }

  String box(String accountId, String path) => MailIds.mailbox(accountId, path);

  /// Delivers a message to [path] of [accountId].
  EmailSummary deliver(
    String accountId,
    DateTime at, {
    String path = 'INBOX',
    String from = 'alice@example.com',
    String? fromName = 'Alice',
    String subject = 'Hello',
    String preview = 'How are you?',
    Set<String> keywords = const {},
  }) {
    final e = EmailSummary(
      id: MailIds.imapEmail(accountId, path, 1, ++_seq),
      accountId: accountId,
      mailboxId: box(accountId, path),
      receivedAt: at,
      from: [EmailAddress(from, fromName)],
      subject: subject,
      preview: preview,
      keywords: keywords,
    );
    emails[e.id] = e;
    return e;
  }

  Mailbox? _mailbox(String id) => mailboxes.where((m) => m.id == id).firstOrNull;

  @override
  Stream<List<MailAccount>> watchAccounts() => Stream.value([...accounts]);

  @override
  Stream<List<Mailbox>> watchMailboxes({String? accountId}) => Stream.value([
    for (final m in mailboxes)
      if (accountId == null || m.accountId == accountId) m,
  ]);

  @override
  Stream<Set<String>> watchVipAddresses() => Stream.value({...vips});

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) {
    bool inScope(EmailSummary e) {
      final role = _mailbox(e.mailboxId)?.role;
      return switch (ref) {
        RealMailboxRef(:final mailboxId) => e.mailboxId == mailboxId,
        VirtualMailboxRef(kind: VirtualMailbox.allInboxes) => role == MailboxRole.inbox,
        VirtualMailboxRef(kind: VirtualMailbox.vip) =>
          e.from.any((a) => vips.contains(a.email.toLowerCase())) &&
              role != MailboxRole.trash &&
              role != MailboxRole.junk,
        VirtualMailboxRef() => true,
      };
    }

    final list = [
      for (final e in emails.values)
        if (inScope(e) && (!filters.contains(QuickFilter.unread) || !e.isSeen)) e,
    ]..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
    return Stream.value([
      for (final e in list.take(limit))
        ThreadSummary(threadId: e.id, latest: e, messageCount: 1, unreadCount: e.isSeen ? 0 : 1),
    ]);
  }

  @override
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() => Stream.value({
    VirtualMailbox.allInboxes: emails.values
        .where((e) => !e.isSeen && _mailbox(e.mailboxId)?.role == MailboxRole.inbox)
        .length,
    VirtualMailbox.vip: emails.values
        .where((e) => !e.isSeen && e.from.any((a) => vips.contains(a.email.toLowerCase())))
        .length,
  });

  @override
  Future<EmailSummary?> getEmail(String emailId) async => emails[emailId];

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) async {
    for (final id in emailIds) {
      final e = emails[id];
      if (e != null) emails[id] = e.copyWith(keywords: {...e.keywords.difference(remove), ...add});
    }
  }

  @override
  Future<void> archive(List<String> emailIds) async {
    for (final id in emailIds) {
      final e = emails.remove(id);
      if (e == null) continue;
      archived.add(id);
      final moved = MailIds.imapEmail(e.accountId, 'Archive', 1, ++_seq);
      emails[moved] = EmailSummary(
        id: moved,
        accountId: e.accountId,
        mailboxId: box(e.accountId, 'Archive'),
        receivedAt: e.receivedAt,
        from: e.from,
        subject: e.subject,
        preview: e.preview,
        keywords: e.keywords,
      );
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName}');
}

/// Completes once the microtasks and timers queued so far have run.
Future<void> flush() => Future<void>.delayed(Duration.zero);
