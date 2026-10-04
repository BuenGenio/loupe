import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/src/summary_json.dart';
import 'package:test/test.dart';

void main() {
  test('summaries round-trip through JSON, list headers included', () {
    final e = EmailSummary(
      id: 'acc|INBOX|1|7',
      accountId: 'acc',
      mailboxId: 'acc|INBOX',
      receivedAt: DateTime.fromMillisecondsSinceEpoch(1700000000000),
      subject: '[PATCH 1/2] x',
      from: const [EmailAddress('a@example.org', 'A')],
      keywords: const {Keywords.seen},
      listId: 'dev.lists.example.org',
      listName: 'Developers',
      listPost: '<mailto:dev@lists.example.org>',
      listUnsubscribe: '<https://lists.example.org/u>',
      listUnsubscribePost: 'List-Unsubscribe=One-Click',
    );
    final back = summaryFromJson(summaryToJson(e));
    expect(back.id, e.id);
    expect(back.from, e.from);
    expect(
      [back.listId, back.listName, back.listPost, back.listUnsubscribe, back.listUnsubscribePost],
      [e.listId, e.listName, e.listPost, e.listUnsubscribe, e.listUnsubscribePost],
    );
    expect(
      summaryToJson(EmailSummary(id: 'x', accountId: 'a', mailboxId: 'm', receivedAt: DateTime(2026))),
      isNot(contains('listId')),
    );
  });
}
