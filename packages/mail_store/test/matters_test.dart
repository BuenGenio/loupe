import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  final t0 = DateTime(2026, 10, 20, 9);
  DateTime later(int minutes) => t0.add(Duration(minutes: minutes));

  /// The adviser's thread (two messages), the solicitor's, and an unrelated one.
  Future<MailStore> house() async {
    final store = await seededStore();
    await addMails(store, [
      mail(1, subject: 'Your application', from: 'rhea@harbour.example', messageId: 'a1@harbour.example'),
      mail(
        2,
        subject: 'Re: Your application',
        from: 'rhea@harbour.example',
        messageId: 'a2@harbour.example',
        inReplyTo: 'a1@harbour.example',
        references: ['a1@harbour.example'],
        minutes: 60,
      ),
      mail(3, subject: 'Client care letter', from: 'owen@marsh.example', messageId: 's1@marsh.example', minutes: 30),
      mail(4, subject: 'Book club', from: 'club@books.example', messageId: 'b1@books.example', minutes: 90),
    ]);
    return store;
  }

  Future<EmailSummary> email(MailStore store, int uid, {String path = 'INBOX'}) async =>
      (await store.getEmail(eid(path, uid)))!;

  Future<Matter> houseMatter(MailStore store) async => Matter.create(id: 'm1', name: 'Buying a house', at: t0)
      .adding(MatterMember.of(await email(store, 1), at: later(1)), subject: 'Your application')
      .adding(MatterMember.of(await email(store, 3), at: later(2)), subject: 'Client care letter');

  test('matters round-trip: members in order, reasons, exclusions and history', () async {
    final store = await house();
    addTearDown(store.close);
    const reason = MatterReason(MatterReasonKind.mentions, '14 Quay Street');
    final book = await email(store, 4);
    final m = (await houseMatter(store))
        .declining(
          MatterExclusion(accountId: accountId, threadId: book.threadId!, at: later(3), ref: MessageRef.of(book)),
        )
        .renamed('14 Quay Street', at: later(4));
    final other = Matter.create(id: 'm2', name: 'Book club', at: later(5)).adding(
      MatterMember.of(book, at: later(6), reason: reason),
      subject: 'Book club',
    );
    await store.writeMatters(save: [m, other]);

    final back = await store.watchMatters().first;
    expect(back.map((x) => x.id), ['m1', 'm2']);
    final first = back.first;
    expect(first.name, '14 Quay Street');
    expect(first.members.map((x) => x.ref.subject), ['Your application', 'Client care letter']);
    expect(first.members.first.ref.messageIdHeader, 'a1@harbour.example');
    expect(first.members.first.addedAt, later(1));
    expect(first.exclusions.single.ref?.emailId, book.id);
    expect(first.excludes(book), isTrue);
    expect(first.history.map((e) => e.kind), [
      MatterEventKind.created,
      MatterEventKind.added,
      MatterEventKind.added,
      MatterEventKind.renamed,
    ]);
    expect(first.history[1].text, 'Your application');
    expect(first.history[1].accountId, accountId);
    expect(back.last.members.single.source, MatterSource.suggested);
    expect(back.last.members.single.reason, reason);

    // Merging: one write saves the result and deletes the other.
    await store.writeMatters(
      save: [first.merging(back.last, at: later(10))],
      delete: ['m2'],
    );
    final merged = await store.watchMatters().first;
    expect(merged.single.members, hasLength(3));
    expect(merged.single.exclusions, isEmpty, reason: 'a member wins over an exclusion');
  });

  test('a matter’s messages: every message of its conversations, oldest first, none in Trash', () async {
    final store = await house();
    addTearDown(store.close);
    await store.writeMatters(save: [await houseMatter(store)]);
    final messages = store.watchMatterMessages('m1');
    expect((await messages.first).map((e) => e.subject), [
      'Your application',
      'Client care letter',
      'Re: Your application',
    ]);
    expect(await store.watchMatterActivity().first, {'m1': base.add(const Duration(minutes: 60))});

    // Filing a message keeps it in the matter; Trash takes it out of view.
    await store.moveLocally([eid('INBOX', 3)], mbox('Archive'));
    expect((await messages.first).map((e) => e.subject), contains('Client care letter'));
    await store.moveLocally([eid('INBOX', 2)], mbox('Trash'));
    expect((await messages.first).map((e) => e.subject), ['Your application', 'Client care letter']);
    expect(await store.watchMatterActivity().first, {'m1': base.add(const Duration(minutes: 30))});
    // The mail itself is untouched by matters.
    await store.writeMatters(delete: ['m1']);
    expect(await store.watchMatters().first, isEmpty);
    expect(await store.getEmail(eid('Archive', 3)) ?? await store.getEmail(eid('INBOX', 3)), isNotNull);
  });

  test('locating a message after a move here, a move elsewhere and a UIDVALIDITY reset', () async {
    final store = await house();
    addTearDown(store.close);
    final ref = MessageRef.of(await email(store, 1));

    // A move this device made: the server gave a new id, the old one is an alias.
    await store.renameEmails({eid('INBOX', 1): eid('Archive', 7)});
    expect((await store.locateMessage(ref))?.id, eid('Archive', 7));

    // Another client moved it: only the Message-ID finds it.
    await store.deleteEmails([eid('Archive', 7)]);
    await addMails(store, [
      mail(8, path: 'Work', subject: 'Your application', from: 'rhea@harbour.example', messageId: 'a1@harbour.example'),
    ]);
    expect((await store.locateMessage(ref))?.id, eid('Work', 8));

    // UIDVALIDITY reset: every id of the mailbox is new.
    await store.applySync(
      mbox('Work'),
      MailboxSyncResult(
        state: const MailboxSyncState({'v': 2}),
        resetAll: true,
        added: [
          mail(
            8,
            path: 'Work',
            validity: 2,
            subject: 'Your application',
            from: 'rhea@harbour.example',
            messageId: 'a1@harbour.example',
          ),
        ],
      ),
    );
    final found = (await store.locateMessage(ref))!;
    expect(found.id, eid('Work', 8, validity: 2));
    expect(found.threadId, ref.threadId, reason: 'threads are kept by Message-ID');
  });

  test('a reused Message-ID with another subject is another message; a Trash copy comes last', () async {
    final store = await house();
    addTearDown(store.close);
    final ref = MessageRef.of(await email(store, 3));
    await store.deleteEmails([eid('INBOX', 3)]);
    await addMails(store, [
      mail(9, path: 'Work', subject: 'Something else', from: 'owen@marsh.example', messageId: 's1@marsh.example'),
    ]);
    expect(await store.locateMessage(ref), isNull);
    await addMails(store, [
      mail(10, path: 'Trash', subject: 'Client care letter', messageId: 's1@marsh.example', minutes: 30),
      mail(11, path: 'Archive', subject: 'Client care letter', messageId: 's1@marsh.example', minutes: 30),
    ]);
    expect((await store.locateMessage(ref))?.id, eid('Archive', 11));
  });

  test('removing an account takes its conversations and their history out of every matter', () async {
    final store = await seededStore(
      accounts: [
        account(),
        account(id: 'acc2', email: 'me@home.example'),
      ],
    );
    addTearDown(store.close);
    await addMails(store, [
      mail(1, subject: 'Work thing', messageId: 'w@x'),
      mail(1, account: 'acc2', subject: 'Home thing', messageId: 'h@x'),
    ]);
    final work = (await store.getEmail(eid('INBOX', 1)))!;
    final home = (await store.getEmail(eid('INBOX', 1, account: 'acc2')))!;
    final m = Matter.create(id: 'm1', name: 'Both', at: t0)
        .adding(MatterMember.of(work, at: later(1)), subject: work.subject)
        .adding(MatterMember.of(home, at: later(2)), subject: home.subject)
        .declining(MatterExclusion(accountId: 'acc2', threadId: 'x', at: later(3)));
    await store.writeMatters(save: [m]);
    final watched = store.watchMatters();
    expect((await watched.first).single.members, hasLength(2));

    await store.deleteAccount('acc2');
    final after = (await watched.first).single;
    expect(after.members.map((x) => x.accountId), [accountId]);
    expect(after.exclusions, isEmpty);
    expect(after.history.map((e) => e.text), ['', 'Work thing'], reason: 'the entry naming its mail went too');

    // A matter saved from a value read before the removal doesn't bring it back.
    await store.writeMatters(save: [m.renamed('Work only', at: later(4))]);
    expect((await watched.first).single.members.map((x) => x.accountId), [accountId]);
  });
}
