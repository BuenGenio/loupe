import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime(2026, 10, 4, 16);
  late DemoMailRepository repo;

  setUp(() => repo = DemoMailRepository.instant(clock: () => now));
  tearDown(() => repo.dispose());

  Future<List<EmailSummary>> all() async {
    final boxes = await repo.watchMailboxes().first;
    final lists = [
      for (final b in boxes) await repo.watchList(RealMailboxRef(b.id), threaded: false, limit: 1000).first,
    ];
    return [for (final l in lists) ...l.map((t) => t.latest)];
  }

  test('seeds three accounts with role mailboxes and a nested folder', () async {
    final accounts = await repo.watchAccounts().first;
    expect(accounts.map((a) => a.provider), [ProviderKind.gmail, ProviderKind.microsoft, ProviderKind.fastmail]);
    final boxes = await repo.watchMailboxes().first;
    for (final a in accounts) {
      final roles = boxes.where((b) => b.accountId == a.id).map((b) => b.role).toSet();
      expect(roles, containsAll([MailboxRole.inbox, MailboxRole.sent, MailboxRole.drafts, MailboxRole.trash]));
    }
    expect(boxes.any((b) => b.path == 'Projects/Atlas/Design Reviews' && b.parentId != null), isTrue);
  });

  test('has a realistic mailbox: ~150 messages, a long thread, tags, flags, VIPs', () async {
    final emails = await all();
    expect(emails.length, inInclusiveRange(130, 190));
    expect(emails.every((e) => now.difference(e.receivedAt).inDays <= 45), isTrue);
    final threads = <String, int>{};
    for (final e in emails) {
      threads[e.threadId!] = (threads[e.threadId!] ?? 0) + 1;
    }
    expect(threads.values.reduce((a, b) => a > b ? a : b), greaterThanOrEqualTo(8));
    for (final tag in [Keywords.label1, Keywords.label2, Keywords.label3, Keywords.label4, Keywords.label5]) {
      expect(emails.any((e) => e.keywords.contains(tag)), isTrue, reason: tag);
    }
    expect(emails.where((e) => e.isFlagged).length, greaterThan(3));
    expect(emails.where((e) => !e.isSeen).length, inInclusiveRange(10, 40));
    expect(emails.where((e) => e.hasAttachment).length, greaterThan(3));
    final counts = await repo.watchVirtualCounts().first;
    expect(counts[VirtualMailbox.vip], greaterThan(0));
  });

  test('every message has content, headers and raw source', () async {
    for (final e in (await all()).take(60)) {
      final content = await repo.loadContent(e.id);
      expect(content.html != null || content.text != null, isTrue);
      expect(content.headers.any((h) => h.$1 == 'Authentication-Results'), isTrue);
      final raw = String.fromCharCodes(await repo.loadRawSource(e.id));
      expect(raw, contains('Message-ID:'));
    }
  });

  test('the photo message carries inline images for the carousel', () async {
    final photos = (await all()).firstWhere((e) => e.subject.startsWith('Photos from Sunday'));
    final content = await repo.loadContent(photos.id);
    expect(content.inlineData.length, greaterThanOrEqualTo(3));
    expect(content.html, contains('cid:'));
  });

  test('the phishing message fails authentication', () async {
    final phish = (await all()).firstWhere((e) => e.subject.contains('PP-88213-US'));
    final content = await repo.loadContent(phish.id);
    final auth = content.headers.firstWhere((h) => h.$1 == 'Authentication-Results').$2;
    expect(auth, contains('dmarc=fail'));
  });

  test('actions are immediate and lists re-emit', () async {
    final inbox = const VirtualMailboxRef(VirtualMailbox.allInboxes);
    final stream = repo.watchList(inbox, threaded: false);
    final first = await stream.first;
    final target = first.first.latest;
    await repo.archive([target.id]);
    final after = await repo.watchList(inbox, threaded: false).first;
    expect(after.any((t) => t.latest.id == target.id), isFalse);
    final archived = await repo.getEmail(target.id);
    final boxes = await repo.watchMailboxes().first;
    final role = boxes.firstWhere((b) => b.id == archived!.mailboxId).role;
    expect(role, anyOf(MailboxRole.archive, MailboxRole.all));
  });

  test('conversation is the whole thread, oldest first', () async {
    final lisbon = (await all()).where((e) => e.subject.contains('Lisbon in November')).toList();
    final conversation = await repo.watchConversation(lisbon.first.id).first;
    expect(conversation.length, greaterThanOrEqualTo(8));
    for (var i = 1; i < conversation.length; i++) {
      expect(conversation[i].receivedAt.isAfter(conversation[i - 1].receivedAt), isTrue);
    }
  });

  test('search answers locally first, then adds server-only hits', () async {
    final results = <SearchResults>[];
    await for (final r in repo.search(
      const SearchRequest(expr: TextTerm(SearchField.any, 'photos'), scope: AllMailboxesScope()),
    )) {
      results.add(r);
      if (r.isComplete) break;
    }
    expect(results.first.pendingAccountIds, isNotEmpty);
    expect(results.first.fromServerIds, isEmpty);
    expect(results.first.items, isNotEmpty);
    expect(results.last.pendingAccountIds, isEmpty);
    expect(results.last.fromServerIds, isNotEmpty);
    expect(results.last.items.length, greaterThan(results.first.items.length));
  });

  test('local-only search does not wait for the server', () async {
    final r = await repo
        .search(
          const SearchRequest(
            expr: TextTerm(SearchField.any, 'photos'),
            scope: AllMailboxesScope(),
            includeServer: false,
          ),
        )
        .first;
    expect(r.isComplete, isTrue);
    expect(r.fromServerIds, isEmpty);
  });

  test('send lands in Sent after the undo delay; cancelSend returns the message', () async {
    const message = OutgoingMessage(
      accountId: DemoAccounts.personal,
      identityId: 'personal/default',
      to: [EmailAddress('jordan.lee@example.com', 'Jordan Lee')],
      subject: 'Hello from the test',
      text: 'Hi!',
    );
    final cancelled = await repo.send(message, undoDelay: const Duration(milliseconds: 50));
    expect(await repo.cancelSend(cancelled), same(message));

    await repo.send(message, undoDelay: const Duration(milliseconds: 10));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final sent = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allSent), threaded: false).first;
    expect(sent.any((t) => t.latest.subject == 'Hello from the test'), isTrue);
  });

  test('Send Later waits in the outbox; sendNow, reschedule, cancel; .invalid recipients fail', () async {
    const message = OutgoingMessage(
      accountId: DemoAccounts.personal,
      identityId: 'personal/default',
      to: [EmailAddress('jordan.lee@example.com', 'Jordan Lee')],
      subject: 'Later, please',
      text: 'Hi!',
    );
    final draft = await repo.saveDraft(message);
    final id = await repo.send(message.copyWith(draftId: draft), sendAt: now.add(const Duration(hours: 1)));
    final scheduled = (await repo.watchOutbox().first).single;
    expect(scheduled.status, OutboxStatus.scheduled);
    expect(scheduled.sendAt, now.add(const Duration(hours: 1)));
    expect(scheduled.message.draftId, isNull);
    expect(await repo.getEmail(draft), isNull, reason: 'the outbox holds it now');

    await repo.rescheduleSend(id, now.add(const Duration(days: 1)));
    expect((await repo.watchOutbox().first).single.sendAt, now.add(const Duration(days: 1)));
    await repo.sendNow(id);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(await repo.watchOutbox().first, isEmpty);
    final sent = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allSent), threaded: false).first;
    expect(sent.any((t) => t.latest.subject == 'Later, please'), isTrue);
    await expectLater(repo.sendNow(id), throwsA(isA<MailException>()));

    final bad = await repo.send(
      message.copyWith(to: const [EmailAddress('someone@nowhere.invalid')]),
      undoDelay: Duration.zero,
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final failed = (await repo.watchOutbox().first).single;
    expect(failed.status, OutboxStatus.failed);
    expect(failed.error, contains('someone@nowhere.invalid'));
    expect((await repo.cancelSend(bad))!.subject, 'Later, please');
    expect(await repo.watchOutbox().first, isEmpty);
  });

  test('drafts save, replace and delete', () async {
    const draft = OutgoingMessage(accountId: DemoAccounts.work, identityId: 'work/default', subject: 'Draft one');
    final id = await repo.saveDraft(draft);
    final again = await repo.saveDraft(draft.copyWith(subject: 'Draft two', draftId: id));
    expect(again, id);
    expect((await repo.getEmail(id))!.subject, 'Draft two');
    expect((await repo.loadContent(id)).text, isNotNull);
    await repo.deleteDraft(id);
    expect(await repo.getEmail(id), isNull);
  });

  test('loadOlder pages in older mail', () async {
    const inbox = VirtualMailboxRef(VirtualMailbox.allInboxes);
    final before = (await repo.watchList(inbox, threaded: false, limit: 1000).first).length;
    expect(await repo.loadOlder(inbox), isTrue);
    final after = (await repo.watchList(inbox, threaded: false, limit: 1000).first).length;
    expect(after, greaterThan(before));
  });

  test('discover knows the big providers', () async {
    expect((await repo.discover('a@gmail.com')).authKind, AuthKind.oauth2);
    expect((await repo.discover('a@outlook.com')).provider, ProviderKind.microsoft);
    final icloud = await repo.discover('a@icloud.com');
    expect(icloud.authKind, AuthKind.password);
    expect(icloud.notes, contains('app-specific password'));
    expect((await repo.discover('a@nowhere.invalid')).incoming, isNull);
  });

  test('addAccount adds folders; a wrong password fails', () async {
    const imap = ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.org', port: 993);
    await expectLater(
      repo.addAccount(
        const AccountSetup(
          email: 'x@example.org',
          displayName: 'X',
          provider: ProviderKind.generic,
          incoming: imap,
          credentials: PasswordCredentials('wrong'),
        ),
      ),
      throwsA(isA<MailException>()),
    );
    final account = await repo.addAccount(
      const AccountSetup(
        email: 'x@example.org',
        displayName: 'X',
        provider: ProviderKind.generic,
        incoming: imap,
        credentials: PasswordCredentials('secret'),
      ),
    );
    final boxes = await repo.watchMailboxes(accountId: account.id).first;
    expect(boxes.map((b) => b.role), contains(MailboxRole.inbox));
  });

  test('suggestAddresses ranks frequent correspondents', () async {
    final people = await repo.suggestAddresses('jo');
    expect(people.first.email, 'jordan.lee@example.com');
  });
}
