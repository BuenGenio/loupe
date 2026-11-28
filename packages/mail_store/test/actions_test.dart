import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  late MailStore store;
  final at = DateTime.utc(2026, 9, 2, 9);

  // The adviser's request, the user's reply in Sent, and an unrelated message.
  final request = mail(1, subject: 'Documents', messageId: 'req@harbour.example', minutes: 0);
  final reply = mail(
    1,
    path: 'Sent',
    subject: 'Re: Documents',
    from: 'me@example.com',
    messageId: 'rep@example.com',
    inReplyTo: 'req@harbour.example',
    references: ['req@harbour.example'],
    minutes: 10,
  );
  final other = mail(2, subject: 'Invoice', messageId: 'inv@removals.example', minutes: 20);

  ActionRecord action(
    String id,
    EmailSummary source,
    ActionOwner owner, {
    ActionState state = ActionState.needsAction,
  }) => ActionRecord(
    id: id,
    owner: owner,
    kind: owner == ActionOwner.me ? ActionKind.document : ActionKind.promise,
    source: MessageRef.of(source),
    quote: 'Quote of $id',
    originalRequest: 'Request $id',
    currentRequest: 'Request $id',
    state: state,
    createdAt: at,
    updatedAt: at.add(Duration(minutes: id.codeUnitAt(1))),
    history: [ActionEvent(at: at, change: ActionChange.created, state: state)],
  );

  Future<List<String>> folder(VirtualMailbox kind, {bool threaded = true}) async => [
    for (final t in await store.watchList(VirtualMailboxRef(kind), threaded: threaded).first) t.latest.subject,
  ];

  Future<Map<VirtualMailbox, int>> counts() => store.watchVirtualCounts().first;

  setUp(() async {
    store = await seededStore();
    await addMails(store, [request, reply, other]);
  });
  tearDown(() => store.close());

  test('saves, reads back and replaces actions', () async {
    expect(await store.watchActions().first, isEmpty);
    final mine = action('a1', request, ActionOwner.me);
    await store.putActions([mine, action('a2', request, ActionOwner.them)]);
    var all = await store.watchActions().first;
    expect(all.map((a) => a.id), ['a2', 'a1'], reason: 'the most recently changed first');
    expect(all.last.currentRequest, 'Request a1');
    expect(all.last.source.threadId, isNotNull, reason: 'the conversation it is in now');

    await store.putActions([mine.withText('September bank statement', at.add(const Duration(hours: 1)))]);
    all = await store.watchActions().first;
    expect(all.first.id, 'a1');
    expect(all.first.currentRequest, 'September bank statement');
    expect(all.first.originalRequest, 'Request a1');
    expect(all.first.overridden, {ActionField.text});
    expect(all, hasLength(2));
  });

  test('the folders list conversations with open actions, newest activity first, and count them', () async {
    expect(await folder(VirtualMailbox.needsMyAction), isEmpty);
    expect((await counts())[VirtualMailbox.needsMyAction], 0);

    await store.putActions([
      action('a1', request, ActionOwner.me),
      action('a2', request, ActionOwner.them),
      action('a3', other, ActionOwner.me, state: ActionState.done),
    ]);
    // One conversation in both folders; its newest message is the user's reply.
    expect(await folder(VirtualMailbox.needsMyAction), ['Re: Documents']);
    expect(await folder(VirtualMailbox.waitingOnOthers), ['Re: Documents']);
    expect(await folder(VirtualMailbox.needsMyAction, threaded: false), ['Re: Documents', 'Documents']);
    var c = await counts();
    expect((c[VirtualMailbox.needsMyAction], c[VirtualMailbox.waitingOnOthers]), (1, 1));

    // A done action shows nowhere until it is reopened.
    final reopened = (await store.watchActions().first).firstWhere((a) => a.id == 'a3');
    await store.putActions([reopened.withState(ActionState.needsAction, at.add(const Duration(hours: 2)))]);
    expect(await folder(VirtualMailbox.needsMyAction), ['Invoice', 'Re: Documents']);
    c = await counts();
    expect(c[VirtualMailbox.needsMyAction], 2);

    // Sent is settled; waiting for an acknowledgement is waiting on others.
    final sent = reopened.withState(ActionState.sent, at.add(const Duration(hours: 3)));
    await store.putActions([sent]);
    expect(await folder(VirtualMailbox.needsMyAction), ['Re: Documents']);
    await store.putActions([sent.withState(ActionState.waitingForAcknowledgement, at.add(const Duration(hours: 4)))]);
    expect(await folder(VirtualMailbox.waitingOnOthers), ['Invoice', 'Re: Documents']);
    expect((await counts())[VirtualMailbox.waitingOnOthers], 2);

    // Other mailboxes don't change.
    expect(await folder(VirtualMailbox.allInboxes), ['Invoice', 'Documents']);
  });

  test('a moved message keeps its actions; Trash and Junk take them out of the folders', () async {
    await store.putActions([action('a1', request, ActionOwner.me), action('a3', other, ActionOwner.me)]);
    final archived = eid('Archive', 7);
    await store.renameEmails({request.id: archived});
    final actions = {for (final a in await store.watchActions().first) a.id: a};
    expect(actions['a1']!.source.emailId, archived);
    expect(await folder(VirtualMailbox.needsMyAction), ['Invoice', 'Re: Documents']);

    await store.renameEmails({other.id: eid('Trash', 3)});
    expect(await folder(VirtualMailbox.needsMyAction), ['Re: Documents']);
    expect((await counts())[VirtualMailbox.needsMyAction], 1);
  });

  test('a message found again by its Message-ID after the mailbox was reset', () async {
    await store.putActions([action('a3', other, ActionOwner.me)]);
    await store.applySync(
      mbox('INBOX'),
      added([mail(41, validity: 2, subject: 'Invoice', messageId: 'inv@removals.example', minutes: 20)]),
    );
    await store.applySync(
      mbox('INBOX'),
      MailboxSyncResult(state: const MailboxSyncState({'v': 3}), vanishedIds: [other.id]),
    );
    final a3 = (await store.watchActions().first).single;
    expect(a3.source.emailId, eid('INBOX', 41, validity: 2));
    expect(await folder(VirtualMailbox.needsMyAction), ['Invoice']);

    // Another message reusing the Message-ID with another subject is not it.
    await store.applySync(
      mbox('INBOX'),
      MailboxSyncResult(
        state: const MailboxSyncState({'v': 4}),
        vanishedIds: [eid('INBOX', 41, validity: 2)],
        added: [mail(42, validity: 2, subject: 'Newsletter', messageId: 'inv@removals.example', minutes: 30)],
      ),
    );
    expect(await folder(VirtualMailbox.needsMyAction), isEmpty);
  });

  test('deleted actions are kept but shown nowhere; forgetting removes them; so does removing the account', () async {
    final waiting = action('a2', request, ActionOwner.them);
    await store.putActions([action('a1', request, ActionOwner.me), waiting]);
    await store.putActions([waiting.withDeleted(true, at.add(const Duration(hours: 1)))]);
    expect((await store.watchActions().first).map((a) => a.id), ['a1']);
    expect((await store.watchActions(includeDeleted: true).first).map((a) => a.id), ['a2', 'a1']);
    expect(await folder(VirtualMailbox.waitingOnOthers), isEmpty);
    expect((await counts())[VirtualMailbox.waitingOnOthers], 0);

    await store.deleteActions(['a2']);
    expect((await store.watchActions(includeDeleted: true).first).map((a) => a.id), ['a1']);

    await store.deleteAccount(accountId);
    expect(await store.watchActions(includeDeleted: true).first, isEmpty);
  });

  test('watchers hear about changes', () async {
    final seen = <int>[];
    final sub = store.watchVirtualCounts().listen((c) => seen.add(c[VirtualMailbox.needsMyAction]!));
    addTearDown(sub.cancel);
    await pumpEventQueue();
    await store.putActions([action('a1', request, ActionOwner.me)]);
    await pumpEventQueue();
    expect(seen, [0, 1]);
  });
}
