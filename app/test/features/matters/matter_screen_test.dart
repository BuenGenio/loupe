import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_matters.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/matters/matter_providers.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

void main() {
  Future<Matter> house(DemoMailRepository repo) async =>
      (await repo.watchMatters().first).singleWhere((m) => m.id == DemoMatters.quayStreet);

  Future<Set<String>> mailIds(DemoMailRepository repo) async => {
    for (final b in await repo.watchMailboxes().first)
      for (final t in await repo.watchList(RealMailboxRef(b.id), threaded: false, limit: 1000).first) t.latest.id,
  };

  Future<EmailSummary> inboxMessage(DemoMailRepository repo, String subject) async {
    final inbox = MailIds.mailbox(DemoAccounts.personal, 'INBOX');
    final list = await repo.watchList(RealMailboxRef(inbox), threaded: false, limit: 1000).first;
    return list.map((t) => t.latest).firstWhere((e) => e.subject == subject);
  }

  Finder inSection(String key, Finder finder) => find.descendant(of: find.byKey(Key(key)), matching: finder);

  testWidgets('the matter lists its open actions and what it waits for, from the action folders', (tester) async {
    final repo = await pumpLoupe(tester, size: const Size(390, 2400));
    final matter = (await repo.watchMatters().first).single;
    await goTo(tester, Routes.matter(matter.id));
    expect(find.text('OPEN ACTIONS'), findsOneWidget);
    expect(find.text('WAITING ON OTHERS'), findsOneWidget);
    expect(find.textContaining('tax year overview for 2025'), findsOneWidget);
    expect(find.textContaining('valuation booking'), findsWidgets);
  });

  testWidgets('Mailboxes › Matters › Buying 14 Quay Street: four senders in the history, both illustrations', (
    tester,
  ) async {
    await pumpLoupe(tester);
    await tester.scrollTo(find.text('Buying 14 Quay Street'));
    // Clear of the bottom bar, which the list scrolls under.
    await tester.ensureVisible(find.text('Buying 14 Quay Street'));
    await tester.pumpAndSettle();
    expect(inSection('matters-section', find.text('4 conversations')), findsOneWidget);
    expect(inSection('matters-section', find.text('New Matter…')), findsOneWidget);
    await tester.tap(find.text('Buying 14 Quay Street'));
    await tester.pumpAndSettle();

    expect(inSection('matter-conversations', find.text('Your mortgage application: what we need next')), findsNothing);
    expect(
      inSection('matter-conversations', find.text('Re: Your mortgage application: what we need next')),
      findsOneWidget,
    );
    expect(inSection('matter-conversations', find.text('Valuation booked: 14 Quay Street')), findsOneWidget);
    expect(find.text('Where Things Stand'), findsNothing, reason: 'Private AI is off');

    await tester.scrollTo(find.byKey(const Key('matter-documents')));
    await tester.scrollTo(inSection('matter-documents', find.text('INV-2207.pdf')));
    expect(inSection('matter-documents', find.text('Mortgage illustration.pdf')), findsNWidgets(2));
    expect(inSection('matter-documents', find.text('Client care letter.pdf')), findsOneWidget);

    await tester.scrollTo(find.byKey(const Key('matter-history')));
    await tester.scrollTo(inSection('matter-history', find.text('Invoice INV-2207: deposit for your move')));
    for (final sender in [
      DemoPrivateAi.adviser,
      DemoPrivateAi.solicitor,
      DemoPrivateAi.lender,
      DemoPrivateAi.removals,
    ]) {
      expect(inSection('matter-history', find.text(sender.name!)), findsWidgets);
    }
    await tester.scrollTo(find.byKey(const Key('matter-activity')));
    expect(inSection('matter-activity', find.text('Matter created')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('suggestions say why; Not This One is remembered and Add makes it a member', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));
    await tester.scrollTo(find.byKey(const Key('matter-suggestions')));
    expect(inSection('matter-suggestions', find.text('Your buildings insurance quote')), findsOneWidget);
    expect(inSection('matter-suggestions', find.text('Mentions “14 Quay Street”')), findsOneWidget);
    await tester.scrollTo(inSection('matter-suggestions', find.text('Thank you for the introduction')));
    expect(
      inSection(
        'matter-suggestions',
        find.text('Also from Rhea Patel. A shared sender alone doesn’t mean it belongs.'),
      ),
      findsOneWidget,
    );
    expect(find.textContaining('Order #10482'), findsNothing);

    final referral = find
        .ancestor(of: find.text('Thank you for the introduction'), matching: find.byType(InkWell))
        .first;
    await tester.ensureVisible(find.descendant(of: referral, matching: find.text('Not This One')));
    // Clear of the title bar, which the list scrolls under.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 300));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: referral, matching: find.text('Not This One')));
    await tester.pumpAndSettle();
    expect(find.text('Thank you for the introduction'), findsNothing);

    final quote = find.ancestor(of: find.text('Your buildings insurance quote'), matching: find.byType(InkWell)).first;
    // Clear of the title bar, which the list scrolls under.
    await tester.ensureVisible(find.descendant(of: quote, matching: find.text('Add')));
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 300));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: quote, matching: find.text('Add')));
    await tester.pumpAndSettle();
    final m = await house(repo);
    expect(m.members, hasLength(5));
    expect(m.members.last.reason, const MatterReason(MatterReasonKind.mentions, '14 Quay Street'));
    await tester.scrollUntilVisible(
      inSection('matter-conversations', find.text('Your buildings insurance quote')),
      -200,
      scrollable: find.byType(Scrollable).first,
    );

    // Leaving and coming back: the declined one stays out.
    await systemBack(tester);
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));
    expect(find.text('Thank you for the introduction'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('rename, split, merge and delete from the ⋯ menu; the mail stays', (tester) async {
    final repo = await pumpLoupe(tester);
    final before = await mailIds(repo);
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));

    Future<void> menu(String item) async {
      await tester.tap(find.byKey(const Key('matter-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(item));
      await tester.pumpAndSettle();
    }

    await menu('Rename…');
    await tester.enterText(find.byType(CupertinoTextField), '14 Quay Street');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect((await house(repo)).name, '14 Quay Street');
    expect(find.text('14 Quay Street'), findsWidgets);

    await menu('Split…');
    expect(find.text('Choose Conversations'), findsOneWidget);
    await tester.tap(inSection('matter-conversations', find.text('Invoice INV-2207: deposit for your move')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('matter-split-move')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(CupertinoTextField), 'The move');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Moved 1 conversation to “The move”'), findsOneWidget);
    var all = await repo.watchMatters().first;
    expect(all.map((m) => (m.name, m.members.length)), [('14 Quay Street', 3), ('The move', 1)]);

    // Merge the new one back.
    await goTo(tester, Routes.matter(all.last.id));
    await menu('Merge Into…');
    await tester.tap(find.text('14 Quay Street').last);
    await tester.pumpAndSettle();
    expect(find.text('Merged into “14 Quay Street”'), findsOneWidget);
    all = await repo.watchMatters().first;
    expect(all.map((m) => (m.name, m.members.length)), [('14 Quay Street', 4)]);
    expect(inSection('matter-conversations', find.text('Invoice INV-2207: deposit for your move')), findsOneWidget);

    await menu('Delete Matter');
    await tester.tap(find.text('Delete Matter').last);
    await tester.pumpAndSettle();
    expect(await repo.watchMatters().first, isEmpty);
    expect(await mailIds(repo), before);
    await drainTimers(tester);
  });

  testWidgets('a conversation links to its matter; Add to Matter… and Remove from Matter from its ⋯ menu', (
    tester,
  ) async {
    final repo = await pumpLoupe(tester);
    final valuation = await inboxMessage(repo, 'Valuation booked: 14 Quay Street');
    await goTo(tester, Routes.message(valuation.id));
    expect(find.byKey(const ValueKey('matter-link-${DemoMatters.quayStreet}')), findsOneWidget);

    final quote = await inboxMessage(repo, 'Your buildings insurance quote');
    await goTo(tester, Routes.message(quote.id));
    expect(find.byKey(const ValueKey('matter-link-${DemoMatters.quayStreet}')), findsNothing);
    await tester.tap(find.byKey(ValueKey('more-${quote.id}')));
    await tester.pumpAndSettle();
    expect(find.text('Remove from Matter'), findsNothing);
    await tester.tap(find.text('Add to Matter…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buying 14 Quay Street'));
    await tester.pumpAndSettle();
    expect(find.text('Added to “Buying 14 Quay Street”'), findsOneWidget);
    expect(find.byKey(const ValueKey('matter-link-${DemoMatters.quayStreet}')), findsOneWidget);
    expect((await house(repo)).members.last.source, MatterSource.manual);

    // Filed into another folder, it stays in the matter.
    final archive = (await repo.watchMailboxes().first).firstWhere(
      (b) => b.accountId == DemoAccounts.personal && b.role == MailboxRole.all,
    );
    await repo.move([quote.id], archive.id);
    await tester.pumpAndSettle();
    expect((await repo.watchMatterMessages(DemoMatters.quayStreet).first).map((e) => e.id), contains(quote.id));

    await tester.tap(find.byKey(ValueKey('more-${quote.id}')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove from Matter'));
    await tester.pumpAndSettle();
    expect(find.text('Removed from “Buying 14 Quay Street”'), findsOneWidget);
    expect(find.byKey(const ValueKey('matter-link-${DemoMatters.quayStreet}')), findsNothing);
    expect((await house(repo)).excludes(quote), isTrue);

    // A new matter from the menu.
    await tester.tap(find.byKey(ValueKey('more-${quote.id}')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Matter…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New Matter…'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(CupertinoTextField), 'Home insurance');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final matters = await repo.watchMatters().first;
    expect(matters.last.name, 'Home insurance');
    expect(matters.last.members.single.threadId, quote.threadId);
    await drainTimers(tester);
  });

  testWidgets('Where Things Stand: written on a tap by the demo, each statement linked to its message', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));
    expect(find.text('A few lines on the latest position, each from a message here.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('matter-status')));
    await tester.pumpAndSettle();
    expect(textContaining('Quayside Removals: Amount due: £450.00'), findsOneWidget);
    expect(textContaining('booked the valuation of 14 Quay Street'), findsOneWidget);
    expect(find.text('Written by the built-in demo, not a model.'), findsOneWidget);
    expect(textContaining(DemoPrivateAi.password), findsNothing);

    // Back again: the same messages, so the same status, without asking.
    await systemBack(tester);
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));
    expect(textContaining('Quayside Removals: Amount due: £450.00'), findsOneWidget);
    expect(find.text('New messages have come in since this was written.'), findsNothing);

    await tester.tap(textContaining('Quayside Removals: Amount due: £450.00'));
    await tester.pumpAndSettle();
    expect(find.text('Invoice INV-2207: deposit for your move'), findsWidgets);
    await drainTimers(tester);
  });

  testWidgets('open actions and waits show when the action folders provide them', (tester) async {
    final repo = DemoMailRepository.instant(clock: () => testNow);
    final source = (await repo.watchMatterMessages(DemoMatters.quayStreet).first).last;
    await pumpLoupe(
      tester,
      repository: repo,
      overrides: [
        matterOpenItemsProvider(DemoMatters.quayStreet).overrideWithValue([
          MatterOpenItem(text: 'Pay the £450 deposit', source: MessageRef.of(source)),
          MatterOpenItem(
            text: 'Valuation report from the lender',
            source: MessageRef.of(source),
            waitingOnOthers: true,
          ),
        ]),
      ],
    );
    await goTo(tester, Routes.matter(DemoMatters.quayStreet));
    expect(find.text('OPEN ACTIONS'), findsOneWidget);
    expect(find.text('Pay the £450 deposit'), findsOneWidget);
    expect(find.text('WAITING ON OTHERS'), findsOneWidget);
    await tester.tap(find.text('Valuation report from the lender'));
    await tester.pumpAndSettle();
    expect(find.text(source.subject), findsWidgets);
    await drainTimers(tester);
  });
}
