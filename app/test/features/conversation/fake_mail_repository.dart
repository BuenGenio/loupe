import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

/// A small in-memory [MailRepository] that records the calls it gets.
class FakeMailRepository implements MailRepository {
  FakeMailRepository({
    List<MailAccount>? accounts,
    List<Mailbox>? mailboxes,
    List<EmailSummary>? emails,
    Map<String, EmailContent>? contents,
  }) : accounts = accounts ?? [testAccount],
       mailboxes = [...mailboxes ?? testMailboxes],
       emails = [...?emails],
       contents = {...?contents};

  final List<MailAccount> accounts;
  final List<Mailbox> mailboxes;
  final List<EmailSummary> emails;
  final Map<String, EmailContent> contents;
  final vips = <String>{};

  /// Server documents: account id → name → content.
  final serverDocuments = <String, Map<String, String>>{};

  /// Thrown by the server document calls while set (e.g. offline).
  MailException? serverDocumentsError;

  /// Every call, as "method args" strings, in order.
  final log = <String>[];
  final keywordCalls = <({List<String> ids, Set<String> add, Set<String> remove})>[];
  final sent = <OutgoingMessage>[];
  final drafts = <OutgoingMessage>[];
  final cancelled = <String>[];
  final setups = <AccountSetup>[];

  /// Overrides for discovery and account creation.
  Future<AccountDiscovery> Function(String email)? onDiscover;
  Future<MailAccount> Function(AccountSetup setup)? onAddAccount;

  /// Thrown by loadContent when set.
  Object? contentError;

  /// Raw sources by email id; others get a small generated message.
  final rawSources = <String, String>{};

  final _changes = StreamController<void>.broadcast();

  void _changed() => _changes.add(null);

  /// Emits [read] now and after every change; subscribes synchronously so no
  /// change is missed.
  Stream<T> _watch<T>(T Function() read) {
    late final StreamController<T> controller;
    StreamSubscription<void>? sub;
    controller = StreamController<T>(
      onListen: () {
        controller.add(read());
        sub = _changes.stream.listen((_) => controller.add(read()));
      },
      // Returns nothing: a cancel future would complete outside fake async.
      onCancel: () {
        sub?.cancel();
      },
    );
    return controller.stream;
  }

  EmailSummary? _byId(String id) => emails.where((e) => e.id == id).firstOrNull;

  void _update(List<String> ids, EmailSummary Function(EmailSummary e) change) {
    for (var i = 0; i < emails.length; i++) {
      if (ids.contains(emails[i].id)) emails[i] = change(emails[i]);
    }
    _changed();
  }

  // Accounts -----------------------------------------------------------------

  @override
  Stream<List<MailAccount>> watchAccounts() => _watch(() => List.of(accounts));

  @override
  Future<AccountDiscovery> discover(String email) async {
    log.add('discover $email');
    if (onDiscover case final f?) return f(email);
    return AccountDiscovery(
      email: email,
      provider: ProviderKind.generic,
      authKind: AuthKind.password,
      incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
      outgoing: const ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.com', port: 465),
      source: 'ISPDB',
    );
  }

  @override
  Future<MailAccount> addAccount(AccountSetup setup) async {
    log.add('addAccount ${setup.email}');
    setups.add(setup);
    final account = onAddAccount != null
        ? await onAddAccount!(setup)
        : MailAccount(
            id: 'new',
            email: setup.email,
            displayName: setup.displayName,
            provider: setup.provider,
            authKind: AuthKind.password,
            incoming: setup.incoming,
            outgoing: setup.outgoing,
            identities: [Identity(id: 'new/default', email: setup.email, name: setup.senderName)],
          );
    accounts.add(account);
    _changed();
    return account;
  }

  @override
  Future<void> updateAccount(MailAccount account) async {
    log.add('updateAccount ${account.id} ${account.displayName} ${account.colorIndex}');
    final i = accounts.indexWhere((a) => a.id == account.id);
    if (i >= 0) accounts[i] = account;
    _changed();
  }

  @override
  Future<void> removeAccount(String accountId) async => log.add('removeAccount $accountId');

  // Mailboxes and lists ------------------------------------------------------

  @override
  Stream<List<Mailbox>> watchMailboxes({String? accountId}) => _watch(
    () => [
      for (final m in mailboxes)
        if (accountId == null || m.accountId == accountId) m,
    ],
  );

  @override
  Future<void> setMailboxSubscribed(String mailboxId, {required bool subscribed}) async {
    log.add('setMailboxSubscribed $mailboxId $subscribed');
    final i = mailboxes.indexWhere((m) => m.id == mailboxId);
    if (i < 0) throw const MailException(MailErrorKind.notFound, 'No such mailbox');
    mailboxes[i] = mailboxes[i].copyWith(isSubscribed: subscribed);
    _changed();
  }

  @override
  Stream<Map<VirtualMailbox, int>> watchVirtualCounts() => _watch(() => const {});

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) => _watch(() => const []);

  @override
  Future<bool> loadOlder(MailboxRef ref) async => false;

  @override
  Future<void> refresh({MailboxRef? ref}) async {}

  @override
  Stream<List<AccountSyncStatus>> watchSyncStatus() => _watch(() => const []);

  // Messages -----------------------------------------------------------------

  @override
  Stream<List<EmailSummary>> watchConversation(String emailId) {
    final thread = _byId(emailId)?.threadId;
    return _watch(
      () => [
        for (final e in emails)
          if (e.id == emailId || (thread != null && e.threadId == thread)) e,
      ]..sort((a, b) => a.receivedAt.compareTo(b.receivedAt)),
    );
  }

  @override
  Future<EmailSummary?> getEmail(String emailId) async => _byId(emailId);

  @override
  Future<EmailContent> loadContent(String emailId) async {
    log.add('loadContent $emailId');
    if (contentError case final e?) throw e;
    return contents[emailId] ?? EmailContent(emailId: emailId, text: 'Body of $emailId');
  }

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async => Uint8List.fromList([1, 2, 3]);

  @override
  Future<Uint8List> loadRawSource(String emailId) async {
    log.add('loadRawSource $emailId');
    final raw = rawSources[emailId] ?? 'From: alice@example.com\r\nSubject: Hello\r\n\r\nRaw body of $emailId\r\n';
    return Uint8List.fromList(utf8.encode(raw));
  }

  // Actions ------------------------------------------------------------------

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) async {
    log.add('setKeywords $emailIds +$add -$remove');
    keywordCalls.add((ids: emailIds, add: add, remove: remove));
    _update(emailIds, (e) => e.copyWith(keywords: {...e.keywords, ...add}.difference(remove)));
  }

  @override
  Future<void> move(List<String> emailIds, String targetMailboxId) async {
    log.add('move $emailIds $targetMailboxId');
    _update(emailIds, (e) => e.copyWith(mailboxId: targetMailboxId));
  }

  @override
  Future<void> archive(List<String> emailIds) async => log.add('archive $emailIds');

  @override
  Future<void> trash(List<String> emailIds) async => log.add('trash $emailIds');

  @override
  Future<void> markJunk(List<String> emailIds, {required bool junk}) async => log.add('markJunk $emailIds $junk');

  // Search -------------------------------------------------------------------

  @override
  Stream<SearchResults> search(SearchRequest request) => _watch(() => const SearchResults(items: []));

  // Compose ------------------------------------------------------------------

  @override
  Future<String> send(
    OutgoingMessage message, {
    Duration undoDelay = const Duration(seconds: 10),
    DateTime? sendAt,
  }) async {
    log.add(
      'send ${message.subject} ${sendAt == null ? 'undo=${undoDelay.inSeconds}' : 'at=${sendAt.toIso8601String()}'}',
    );
    sent.add(message);
    final id = 'outbox-${sent.length}';
    outbox.add(
      OutboxItem(
        id: id,
        message: message,
        sendAt: sendAt ?? DateTime(2026, 10, 4, 12).add(undoDelay),
        status: sendAt == null ? OutboxStatus.queued : OutboxStatus.scheduled,
      ),
    );
    _changed();
    return id;
  }

  /// What [watchOutbox] shows; tests may add items directly.
  final outbox = <OutboxItem>[];

  @override
  Stream<List<OutboxItem>> watchOutbox() => _watch(() => List.of(outbox));

  @override
  Future<OutgoingMessage?> cancelSend(String outboxId) async {
    log.add('cancelSend $outboxId');
    cancelled.add(outboxId);
    final item = outbox.where((o) => o.id == outboxId).firstOrNull;
    outbox.remove(item);
    _changed();
    return item?.message ?? sent.lastOrNull;
  }

  @override
  Future<void> sendNow(String outboxId) async {
    log.add('sendNow $outboxId');
    outbox.removeWhere((o) => o.id == outboxId);
    _changed();
  }

  @override
  Future<void> rescheduleSend(String outboxId, DateTime sendAt) async {
    log.add('rescheduleSend $outboxId ${sendAt.toIso8601String()}');
    final i = outbox.indexWhere((o) => o.id == outboxId);
    if (i < 0) throw const MailException(MailErrorKind.notFound, 'This message was already sent.');
    final o = outbox[i];
    outbox[i] = OutboxItem(id: o.id, message: o.message, sendAt: sendAt, status: OutboxStatus.scheduled);
    _changed();
  }

  /// While set, saveDraft waits for it (a slow connection).
  Completer<void>? holdSaves;

  @override
  Future<String> saveDraft(OutgoingMessage message) async {
    log.add('saveDraft ${message.subject}');
    await holdSaves?.future;
    drafts.add(message);
    return 'draft-${drafts.length}';
  }

  @override
  Future<void> deleteDraft(String draftEmailId) async => log.add('deleteDraft $draftEmailId');

  @override
  Future<List<EmailAddress>> suggestAddresses(String prefix, {int limit = 8}) async {
    const known = [
      EmailAddress('alice@example.com', 'Alice Example'),
      EmailAddress('bob@example.com', 'Bob Builder'),
      EmailAddress('carol@example.org', 'Carol'),
    ];
    final p = prefix.toLowerCase();
    return [
      for (final a in known)
        if (a.email.startsWith(p) || (a.name?.toLowerCase().startsWith(p) ?? false)) a,
    ].take(limit).toList();
  }

  // Documents on the server -------------------------------------------------

  @override
  Future<List<ServerDocument>> readServerDocuments(String accountId, String name) async {
    log.add('readServerDocuments $accountId $name');
    if (serverDocumentsError case final e?) throw e;
    final content = serverDocuments[accountId]?[name];
    return [if (content != null) ServerDocument(content: content, storage: ServerStorage.metadata)];
  }

  @override
  Future<ServerStorage> writeServerDocument(
    String accountId,
    String name,
    String content, {
    List<ServerDocument> replaces = const [],
  }) async {
    log.add('writeServerDocument $accountId $name');
    if (serverDocumentsError case final e?) throw e;
    (serverDocuments[accountId] ??= {})[name] = content;
    return ServerStorage.metadata;
  }

  // People -------------------------------------------------------------------

  @override
  Stream<Set<String>> watchVipAddresses() => _watch(() => {...vips});

  @override
  Future<void> setVip(String email, {required bool vip}) async {
    log.add('setVip $email $vip');
    vip ? vips.add(email.toLowerCase()) : vips.remove(email.toLowerCase());
    _changed();
  }
}

const testAccount = MailAccount(
  id: 'acc',
  email: 'me@example.com',
  displayName: 'Work',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
  outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.com', port: 465),
  identities: [Identity(id: 'acc/me', email: 'me@example.com', name: 'Me Myself', signature: 'Cheers,\nMe')],
);

const testMailboxes = [
  Mailbox(id: 'acc|INBOX', accountId: 'acc', name: 'Inbox', path: 'INBOX', role: MailboxRole.inbox),
  Mailbox(id: 'acc|Archive', accountId: 'acc', name: 'Archive', path: 'Archive', role: MailboxRole.archive),
  Mailbox(id: 'acc|Trash', accountId: 'acc', name: 'Trash', path: 'Trash', role: MailboxRole.trash),
  Mailbox(id: 'acc|Receipts', accountId: 'acc', name: 'Receipts', path: 'Receipts'),
];

const alice = EmailAddress('alice@example.com', 'Alice Example');
const bob = EmailAddress('bob@example.com', 'Bob Builder');
const me = EmailAddress('me@example.com', 'Me Myself');

/// A message in the test inbox.
EmailSummary testEmail(
  String id, {
  String thread = 't1',
  EmailAddress from = alice,
  List<EmailAddress> to = const [me],
  List<EmailAddress> cc = const [],
  String subject = 'Lunch plans',
  Set<String> keywords = const {},
  int minutesAgo = 0,
  String mailboxId = 'acc|INBOX',
}) => EmailSummary(
  id: id,
  accountId: 'acc',
  mailboxId: mailboxId,
  threadId: thread,
  messageIdHeader: '$id@example.com',
  receivedAt: DateTime(2026, 10, 4, 12).subtract(Duration(minutes: minutesAgo)),
  from: [from],
  to: to,
  cc: cc,
  subject: subject,
  preview: 'Preview of $id',
  keywords: keywords,
);
