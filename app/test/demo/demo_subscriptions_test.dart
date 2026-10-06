import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  late DemoMailRepository repo;
  setUp(() => repo = DemoMailRepository.instant(clock: () => DateTime(2026, 10, 4, 16)));
  tearDown(() => repo.dispose());

  test('newsletters, lists and notifications, never-read mail first', () async {
    final subs = await repo.watchSubscriptions().first;
    final byKey = {for (final s in subs) s.key: s};
    expect(subs.first.key, 'from:deals@megamart.example');
    expect(subs.first.neverRead, isTrue);
    // Every way to unsubscribe is in the demo.
    expect(byKey['from:hello@striderun.example']!.unsubscribe.first, isA<OneClickUnsubscribe>());
    final deals = byKey['from:deals@megamart.example']!.unsubscribe.single as MailtoUnsubscribe;
    expect(deals.subject, 'Unsubscribe daily deals');
    expect(byKey['from:tracker@issues.northwind.example']!.unsubscribe.single, isA<WebUnsubscribe>());
    final kestrel = byKey['list:dev.lists.example.org']!;
    expect(kestrel.name, 'Kestrel developers');
    expect(kestrel.senderCount, greaterThan(1));
    expect(kestrel.unsubscribe.first, isA<MailtoUnsubscribe>());
    // The user's own posts to the list don't count.
    final kestrelMail = await repo.watchSubscriptionEmails(kestrel.key).first;
    expect(kestrelMail.any((e) => e.sender!.email.startsWith('lists@rivera')), isFalse);
    expect(kestrelMail, hasLength(kestrel.messageCount));
    // Personal mail and receipts aren't subscriptions.
    expect(byKey.keys.where((k) => k.contains('harborcoffee') || k.contains('jordan')), isEmpty);
  });

  test('newsletters from bulk-mail services: one per sender, named after it', () async {
    final subs = await repo.watchSubscriptions().first;
    final byKey = {for (final s in subs) s.key: s};
    // Three campaigns, three base64 List-Ids: one newsletter.
    final nordlicht = byKey['from:news@nordlicht.example']!;
    expect(nordlicht.name, 'Nordlicht Books');
    expect(nordlicht.messageCount, 3);
    expect(nordlicht.listIds, hasLength(3));
    expect(nordlicht.kind, SubscriptionKind.newsletter);
    expect(byKey['from:hello@tidepool.example']!.name, 'Tidepool');
    expect(byKey['from:offers@mail.lumenbank.example']!.name, 'Lumen Bank');
    // A new address for every campaign.
    final northline = byKey['sender:northline.example/northline rail']!;
    expect((northline.name, northline.messageCount), ('Northline Rail', 2));
    expect([for (final s in subs) s.name].where(looksMachineMade), isEmpty);
    // The discussion lists.
    expect([
      for (final s in subs)
        if (s.isDiscussion) s.key,
    ], unorderedEquals(['list:dev.lists.example.org', 'list:open-garden.lists.opengarden.example']));
    final mail = await repo.watchSubscriptionEmails(nordlicht.key).first;
    expect(mail, hasLength(3));
  });

  test('Treat as Newsletter, and back', () async {
    const kestrel = 'list:dev.lists.example.org';
    await repo.setListKind(['dev.lists.example.org'], SubscriptionKind.newsletter);
    var subs = await repo.watchSubscriptions().first;
    expect(subs.firstWhere((s) => s.key == kestrel).kind, SubscriptionKind.newsletter);
    await repo.setListKind(['dev.lists.example.org'], null);
    subs = await repo.watchSubscriptions().first;
    expect(subs.firstWhere((s) => s.key == kestrel).kind, SubscriptionKind.discussion);
  });

  test('archiving and reading change the counts', () async {
    const key = 'from:hello@striderun.example';
    final before = (await repo.watchSubscriptions().first).firstWhere((s) => s.key == key);
    final inbox = await repo.watchSubscriptionEmails(key, inboxOnly: true).first;
    expect(inbox, hasLength(before.inboxCount));
    await repo.archive([for (final e in inbox) e.id]);
    await repo.setKeywords([for (final e in inbox) e.id], add: {Keywords.seen});
    final after = (await repo.watchSubscriptions().first).firstWhere((s) => s.key == key);
    expect(after.inboxCount, 0);
    expect(after.readCount, after.messageCount);
    expect(after.messageCount, before.messageCount);
  });
}
