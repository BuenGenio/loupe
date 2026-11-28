import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

void main() {
  const ai = {'settings.aiAssist': true};
  final mortgage = DemoPrivateAi.threadId(DemoPrivateAi.mortgageThread);

  Future<List<EmailSummary>> conversation(DemoMailRepository repo, String threadId) async {
    final rows = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes)).first;
    return repo.watchConversation(rows.firstWhere((r) => r.threadId == threadId).latest.id).first;
  }

  /// Opens [m] and its ⋯ menu.
  Future<void> openMenu(WidgetTester tester, EmailSummary m) async {
    await goTo(tester, Routes.message(m.id));
    final more = find.byKey(ValueKey('more-${m.id}'));
    await tester.scrollUntilVisible(more, 200, scrollable: find.byType(Scrollable).first);
    await tester.tap(more);
    await tester.pumpAndSettle();
  }

  Future<void> suggest(WidgetTester tester, EmailSummary m) async {
    await openMenu(tester, m);
    await tester.tap(find.text('Suggest Actions'));
    await tester.pumpAndSettle();
  }

  testWidgets('Add Action… without Private AI: no Suggest Actions; a manual action, with Undo', (tester) async {
    final repo = await pumpLoupe(tester);
    final valuation = (await conversation(repo, DemoPrivateAi.threadId(DemoPrivateAi.valuationThread))).single;
    await openMenu(tester, valuation);
    expect(find.text('Suggest Actions'), findsNothing);
    await tester.tap(find.text('Add Action…'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('action-owner-them')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('action-add-text')), 'Valuer confirms the time');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('action-add-save')));
    await tester.pumpAndSettle();
    expect(find.text('Action added'), findsOneWidget);
    final added = (await repo.watchActions().first).firstWhere((a) => a.currentRequest == 'Valuer confirms the time');
    expect(
      (added.owner, added.kind, added.folder),
      (ActionOwner.them, ActionKind.promise, VirtualMailbox.waitingOnOthers),
    );
    expect(added.origin.isSuggested, isFalse);
    expect(added.source.emailId, valuation.id);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.waitingOnOthers], 2);
    // The conversation shows it at once.
    expect(find.text('1 waiting'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect((await repo.watchActions(includeDeleted: true).first).where((a) => a.id == added.id), isEmpty);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.waitingOnOthers], 1);
    await drainTimers(tester);
  });

  testWidgets('Suggest Actions: what is tracked already is marked; quoted mail adds nothing', (tester) async {
    final repo = await pumpLoupe(tester, prefs: ai);
    final messages = await conversation(repo, mortgage);
    final before = await repo.watchActions(includeDeleted: true).first;

    // The adviser's requests: all five tracked, nothing new.
    await suggest(tester, messages.first);
    expect(find.text('Suggested Actions'), findsOneWidget);
    expect(find.text('By the built-in demo: rules, no model. Nothing leaves this phone.'), findsOneWidget);
    expect(find.text('Tracked'), findsNWidgets(5));
    expect(find.byKey(const Key('suggestion-add')), findsNothing);
    await systemBack(tester);

    // Her confirmation quotes Sam's question (in a "> " line): only her promise, tracked.
    final receipt = messages.firstWhere((m) => m.preview.contains('have arrived'));
    await suggest(tester, receipt);
    expect(find.text('Tracked'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(BottomSheet), matching: textContaining('should the tax year')),
      findsNothing,
    );
    await systemBack(tester);
    expect(await repo.watchActions(includeDeleted: true).first, hasLength(before.length));
    await drainTimers(tester);
  });

  testWidgets('Suggest Actions on mail Sam sent: his question is a follow-up, his promise his own; Add Both', (
    tester,
  ) async {
    final repo = await pumpLoupe(tester, prefs: ai);
    final reply = (await conversation(repo, mortgage)).firstWhere((m) => m.from.first == DemoPeople.personal);
    await suggest(tester, reply);
    expect(find.text('They Will'), findsOneWidget);
    expect(find.text('I Need To'), findsOneWidget);
    expect(textContaining('should the tax year overview be for 2024/25 or for 2025?'), findsWidgets);
    await tester.tap(find.byKey(const Key('suggest-add-all')));
    await tester.pumpAndSettle();
    expect(find.text('Tracked'), findsNothing, reason: 'just added here: Undo instead');
    expect(find.byKey(const Key('suggestion-undo')), findsNWidgets(2));

    final added = [
      for (final a in await repo.watchActions().first)
        if (a.source.emailId == reply.id) a,
    ];
    expect(added, hasLength(2));
    final followUp = added.singleWhere((a) => a.owner == ActionOwner.them);
    expect((followUp.kind, followUp.folder), (ActionKind.followUp, VirtualMailbox.waitingOnOthers));
    expect(followUp.origin.providerId, 'demo');
    final promise = added.singleWhere((a) => a.owner == ActionOwner.me);
    expect((promise.kind, promise.folder), (ActionKind.promise, VirtualMailbox.needsMyAction));
    expect(promise.quote, contains("I'll do the ID check"));

    // Undo one; the other stays.
    await tester.tap(find.byKey(const Key('suggestion-undo')).first);
    await tester.pumpAndSettle();
    expect([
      for (final a in await repo.watchActions().first)
        if (a.source.emailId == reply.id) a,
    ], hasLength(1));
    await drainTimers(tester);
  });

  testWidgets('running it again never changes what the user changed; a new model’s wording is offered as an update', (
    tester,
  ) async {
    // A provider that words the adviser's requests differently from the demo.
    String answer(AiRequest request) {
      final text = (jsonDecode(request.input) as Map)['text'] as String;
      const quote = 'Your tax year overview for 2025.';
      if (!text.contains(quote)) return jsonEncode({'summary': 'Nothing.', 'nothing_to_summarise': true, 'items': []});
      return jsonEncode({
        'summary': 'Rhea asks for documents.',
        'nothing_to_summarise': false,
        'items': [
          {
            'kind': 'document',
            'text': 'HMRC tax year overview, 2025',
            'quote': quote,
            'channel': 'by email or upload',
            'owner': 'me',
            'due': {'kind': 'none', 'text': null, 'date': null},
          },
        ],
      });
    }

    final repo = await pumpLoupe(
      tester,
      prefs: ai,
      overrides: [aiProviderProvider.overrideWithValue(FakeProvider.scripted(answer, id: 'cloud', model: 'm2'))],
    );
    final messages = await conversation(repo, mortgage);
    final overview = (await repo.watchActions().first).singleWhere((a) => a.quote.contains('tax year overview'));
    // The user settles it and rewords it first.
    await repo.saveActions([
      overview.withText('Overview (2025, not 2024/25)', testNow).withState(ActionState.done, testNow),
    ]);

    await suggest(tester, messages.first);
    expect(find.text('By cloud, on this phone'), findsOneWidget);
    await tester.tap(find.byKey(const Key('suggestion-update')));
    await tester.pumpAndSettle();
    final updated = (await repo.watchActions().first).singleWhere((a) => a.id == overview.id);
    expect(updated.currentRequest, 'Overview (2025, not 2024/25)');
    expect(updated.state, ActionState.done);
    expect(updated.channel, 'by email or upload');
    expect(updated.suggestion?.text, 'HMRC tax year overview, 2025');
    expect(updated.origin.model, 'm2');
    expect(updated.originalRequest, overview.originalRequest);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.needsMyAction], 3);
    await drainTimers(tester);
  });

  testWidgets('a reply saying “Thanks” settles nothing', (tester) async {
    final repo = await pumpLoupe(tester, prefs: ai);
    final messages = await conversation(repo, mortgage);
    final before = await repo.watchActions().first;
    await repo.send(
      OutgoingMessage(
        accountId: DemoAccounts.personal,
        identityId: 'personal/default',
        to: const [DemoPrivateAi.adviser],
        subject: 'Re: Your mortgage application: what we need next',
        text: 'Thanks!\n\nSam',
        mode: ComposeMode.reply,
        sourceEmailId: messages.last.id,
      ),
      undoDelay: Duration.zero,
    );
    await tester.pumpAndSettle();
    final after = await repo.watchActions().first;
    expect([for (final a in after) (a.id, a.state)], [for (final a in before) (a.id, a.state)]);
    final thanks = (await conversation(repo, mortgage)).singleWhere((m) => m.preview.startsWith('Thanks!'));
    await suggest(tester, thanks);
    expect(find.byKey(const Key('suggest-none')), findsOneWidget);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.needsMyAction], 3);
    await drainTimers(tester);
  });
}
