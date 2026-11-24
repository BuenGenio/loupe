import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

/// Projects in the store: a project's list (`KeywordMailboxRef`), its unread
/// count, and the keywords new mail takes from its conversation.

final house = Projects.keyword('house');
final garden = Projects.keyword('garden');

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  late MailStore store;
  setUp(() async {
    store = await seededStore(
      accounts: [
        account(),
        account(id: 'acc2', email: 'me@home.test', name: 'Home'),
      ],
    );
  });
  tearDown(() => store.close());

  test('a project lists its conversations from every account and folder, not from Trash or Junk', () async {
    await addMails(store, [
      mail(1, subject: 'Survey', messageId: 's@x', keywords: {house}),
      mail(
        2,
        path: 'Sent',
        subject: 'Re: Survey',
        messageId: 's2@x',
        inReplyTo: 's@x',
        keywords: {house, Keywords.seen},
      ),
      mail(3, path: 'Work', subject: 'Quote', minutes: 5, keywords: {house, Keywords.seen}),
      mail(4, account: 'acc2', subject: 'Mortgage offer', minutes: 10, keywords: {house}),
      mail(5, path: 'Trash', subject: 'Old', minutes: 20, keywords: {house}),
      mail(6, path: 'Junk', subject: 'Spam', minutes: 20, keywords: {house}),
      mail(7, subject: 'Roses', minutes: 30, keywords: {garden}),
      mail(8, subject: 'Unrelated', minutes: 40),
    ]);
    final threads = await store.watchList(KeywordMailboxRef(house)).first;
    expect([for (final t in threads) t.latest.subject], ['Mortgage offer', 'Quote', 'Re: Survey']);
    expect(threads.last.messageCount, 2, reason: 'the Inbox message and the reply in Sent');

    final unread = await store.watchList(KeywordMailboxRef(house), filters: {QuickFilter.unread}).first;
    expect([for (final t in unread) t.latest.subject], ['Mortgage offer', 'Survey']);
  });

  test('a message in two folders is listed and counted once', () async {
    await addMails(store, [
      mail(1, subject: 'Survey', messageId: 's@x', keywords: {house}),
      mail(1, path: 'Work', subject: 'Survey', messageId: 's@x', keywords: {house}),
    ]);
    final rows = await store.watchList(KeywordMailboxRef(house), threaded: false).first;
    expect(rows, hasLength(1));
    expect(await store.watchKeywordUnread({house, garden}).first, {house: 1, garden: 0});
  });

  test('unread counts follow keyword and read changes', () async {
    await addMails(store, [
      mail(1, keywords: {house}),
      mail(2, minutes: 1, keywords: {house, garden}),
      mail(3, minutes: 2, keywords: {garden, Keywords.seen}),
    ]);
    final counts = store.watchKeywordUnread({house, garden});
    expect(await counts.first, {house: 2, garden: 1});
    await store.updateKeywords([eid('INBOX', 1)], add: {Keywords.seen});
    await store.updateKeywords([eid('INBOX', 2)], remove: {garden});
    expect(await store.watchKeywordUnread({house, garden}).first, {house: 1, garden: 0});
    expect(await store.watchKeywordUnread(const {}).first, isEmpty);
  });

  test('new mail in a conversation of a project gets its keyword', () async {
    await addMails(store, [
      mail(1, subject: 'Survey', messageId: 's@x', keywords: {house, garden, Keywords.seen}),
      mail(2, subject: 'Other', messageId: 'o@x', keywords: {Keywords.seen}),
    ]);
    await addMails(store, [
      mail(3, subject: 'Re: Survey', messageId: 'r@x', inReplyTo: 's@x', minutes: 5),
      mail(4, path: 'Sent', subject: 'Re: Survey', messageId: 'r2@x', inReplyTo: 'r@x', minutes: 6, keywords: {garden}),
      mail(5, subject: 'Re: Other', messageId: 'o2@x', inReplyTo: 'o@x', minutes: 7),
    ]);
    final follow = await store.projectKeywordsToFollow([eid('INBOX', 3), eid('Sent', 4), eid('INBOX', 5)]);
    expect(follow, {
      eid('INBOX', 3): {house, garden},
      eid('Sent', 4): {house},
    });
  });
}
