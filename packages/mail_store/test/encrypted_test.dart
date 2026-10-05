import 'dart:async';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late MailStore store;
  setUp(() async => store = await seededStore());
  tearDown(() => store.close());

  EmailSummary secret(int uid, {String path = 'INBOX', int size = 4242, int minutes = 0}) => mail(
    uid,
    path: path,
    subject: '...',
    messageId: 'secret@example.com',
    size: size,
    isEncrypted: true,
    minutes: minutes,
  );

  Future<List<String>> search(String subject) async => [
    for (final e in await store.search(TextTerm(SearchField.subject, subject))) e.id,
  ];

  test('encrypted messages say so; a protected subject is not known until remembered', () async {
    await addMails(store, [secret(1), mail(2, subject: 'Plain')]);
    final e = (await store.getEmail(eid('INBOX', 1)))!;
    expect((e.isEncrypted, e.hasDecryptedSubject, e.subject), (true, false, '...'));
    expect((await store.getEmail(eid('INBOX', 2)))!.isEncrypted, isFalse);
  });

  test('a remembered protected subject shows in the list, its copies and search', () async {
    await addMails(store, [
      secret(1),
      secret(1, path: 'Archive'),
      // The same Message-ID, but not the same message (another size).
      secret(2, size: 99),
      mail(3, subject: 'Unrelated'),
    ]);
    final list = StreamIterator(store.watchList(RealMailboxRef(mbox('INBOX')), threaded: false));
    addTearDown(list.cancel);
    expect(await list.moveNext(), isTrue);

    await store.rememberProtectedSubject(eid('INBOX', 1), 'Quarterly secrets');

    expect(await list.moveNext(), isTrue, reason: 'the list hears of it');
    final rows = {for (final t in list.current) t.latest.id: t.latest};
    expect((rows[eid('INBOX', 1)]!.subject, rows[eid('INBOX', 1)]!.hasDecryptedSubject), ('Quarterly secrets', true));
    expect(rows[eid('INBOX', 2)]!.subject, '...');
    expect((await store.getEmail(eid('Archive', 1)))!.subject, 'Quarterly secrets', reason: 'the same message');
    expect(await search('quarterly'), unorderedEquals([eid('INBOX', 1)]), reason: 'copies merge in search');
    expect((await store.search(const TextTerm(SearchField.subject, 'quarterly'))).single.subject, 'Quarterly secrets');
  });

  test('it stays through syncs and moves, and a copy synced later inherits it', () async {
    await addMails(store, [secret(1)]);
    await store.rememberProtectedSubject(eid('INBOX', 1), 'Quarterly secrets');
    // The server sends the summary again (a resync): the outer subject is unchanged.
    await addMails(store, [
      secret(1).copyWith(keywords: {Keywords.seen}),
    ]);
    expect((await store.getEmail(eid('INBOX', 1)))!.subject, 'Quarterly secrets');
    // Moved by Loupe: the row is renamed.
    await store.moveLocally([eid('INBOX', 1)], mbox('Work'));
    await store.renameEmails({eid('INBOX', 1): eid('Work', 7)});
    expect((await store.getEmail(eid('Work', 7)))!.subject, 'Quarterly secrets');
    // Copied by another client: the new copy inherits it.
    await addMails(store, [secret(8, path: 'Archive')]);
    final copy = (await store.getEmail(eid('Archive', 8)))!;
    expect((copy.subject, copy.hasDecryptedSubject), ('Quarterly secrets', true));
    expect(await search('quarterly'), hasLength(1));
  });

  test('a summary restored after a delete keeps its protected subject', () async {
    await addMails(store, [secret(1)]);
    await store.rememberProtectedSubject(eid('INBOX', 1), 'Quarterly secrets');
    final deleted = await store.deleteEmails([eid('INBOX', 1)]);
    expect(await search('quarterly'), isEmpty);
    await store.restoreEmails(deleted);
    final back = (await store.getEmail(eid('INBOX', 1)))!;
    expect((back.subject, back.hasDecryptedSubject), ('Quarterly secrets', true));
    expect(await search('quarterly'), [eid('INBOX', 1)]);
  });

  group('decrypted text', () {
    Future<List<String>> body(String text) async => [
      for (final e in await store.search(TextTerm(SearchField.body, text))) e.id,
    ];

    test('is found by body and by any text, until it is all taken out again', () async {
      await addMails(store, [secret(1), mail(2, subject: 'Plain', preview: 'nothing secret')]);
      expect(await body('lighthouse'), isEmpty, reason: 'encrypted mail is found by its headers only');
      await store.putDecryptedText(eid('INBOX', 1), 'The offsite is at Lighthouse Lodge.');
      await store.rememberProtectedSubject(eid('INBOX', 1), 'Offsite venue');
      expect(await body('lighthouse'), [eid('INBOX', 1)]);
      expect([for (final e in await store.search(const TextTerm(SearchField.any, 'lodge'))) e.id], [eid('INBOX', 1)]);

      expect(await store.deleteDecryptedTexts(), 1);
      expect(await body('lighthouse'), isEmpty);
      expect(await search('offsite'), [eid('INBOX', 1)], reason: 'the protected subject stays');
    });

    test('stays when the outer body is cached, and through a move; goes with the message', () async {
      await addMails(store, [secret(1)]);
      await store.putDecryptedText(eid('INBOX', 1), 'Lighthouse Lodge');
      await store.putContent(EmailContent(emailId: eid('INBOX', 1), text: 'This is an OpenPGP/MIME encrypted message'));
      expect(await body('lighthouse'), [eid('INBOX', 1)]);
      expect(await body('openpgp'), isEmpty, reason: 'the decrypted text stands in for the encrypted body');
      await store.moveLocally([eid('INBOX', 1)], mbox('Work'));
      await store.renameEmails({eid('INBOX', 1): eid('Work', 7)});
      expect(await body('lighthouse'), [eid('Work', 7)]);
      await store.deleteEmails([eid('Work', 7)]);
      expect(await body('lighthouse'), isEmpty);
      expect(await store.deleteDecryptedTexts(), 0, reason: 'deleted with the message');
    });

    test('is capped, replaced when indexed again, and ignored for unknown messages', () async {
      await addMails(store, [secret(1)]);
      await store.putDecryptedText(eid('INBOX', 1), 'first');
      await store.putDecryptedText(eid('INBOX', 1), 'second ${'x' * MailStore.maxDecryptedTextChars} tailword');
      expect(await body('first'), isEmpty);
      expect(await body('second'), [eid('INBOX', 1)]);
      expect(await body('tailword'), isEmpty, reason: 'beyond the cap');
      await store.putDecryptedText(eid('INBOX', 99), 'ghost');
      expect(await body('ghost'), isEmpty);
    });
  });
}
