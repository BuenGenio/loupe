import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_changes.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:loupe/features/conversation/changes/change_passages_sheet.dart';
import 'package:loupe/features/conversation/changes/email_changes_sheet.dart';
import 'package:loupe/router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import 'fake_mail_repository.dart';
import 'test_app.dart';

/// The adviser's thread of the Private AI storyline, oldest first.
final _story =
    DemoSeed.build(testNow).messages
        .where((m) => m.summary.threadId == DemoPrivateAi.threadId(DemoPrivateAi.mortgageThread))
        .toList()
      ..sort((a, b) => a.summary.receivedAt.compareTo(b.summary.receivedAt));
final _firstId = _story.first.summary.id;
final _revisedId = _story.singleWhere((m) => m.text!.contains('revised illustration')).summary.id;

const _on = {'settings.aiAssist': true};

/// Native compute runs outside the widget test's fake event loop.
Future<void> _finishComparison(WidgetTester tester) async {
  await tester.runAsync(() async {
    for (var attempt = 0; attempt < 100; attempt++) {
      await tester.pump();
      if (find.byType(CircularProgressIndicator).evaluate().isEmpty) return;
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  });
  await tester.pumpAndSettle();
  expect(find.byType(CircularProgressIndicator), findsNothing);
}

/// The demo path: the mortgage thread › the revised illustration's ⋯ ›
/// Compare Messages…, then From Message › the adviser's first message.
Future<void> _compareStoryline(WidgetTester tester) async {
  await goTo(tester, Routes.message(_revisedId));
  final more = find.byKey(ValueKey('more-$_revisedId'));
  await tester.ensureVisible(more);
  await tester.tap(more);
  await tester.pumpAndSettle();
  final action = find.text('Compare Messages…');
  await tester.ensureVisible(action);
  await tester.tap(action);
  await _finishComparison(tester);
  await tester.tap(find.byKey(const ValueKey('changes-from')));
  await tester.pumpAndSettle();
  await tester.tap(find.byWidgetPredicate((w) => w is DropdownMenuItem<String> && w.value == _firstId).last);
  // The demo repository loads a message's content on a (fake) timer; the
  // comparison itself then runs in an isolate.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await _finishComparison(tester);
}

/// Scrolls the Changes sheet so [finder] is in the middle, then taps it.
/// (Aligned to the top edge, What Changed would scroll out of view as soon
/// as it shrinks to its progress line.)
Future<void> _tapInSheet(WidgetTester tester, Finder finder) async {
  await tester.runAsync(() => Scrollable.ensureVisible(tester.element(finder), alignment: 0.5));
  await tester.pump();
  await tester.tap(finder);
}

Future<void> _tapExplain(WidgetTester tester) => _tapInSheet(tester, find.byKey(const ValueKey('explain-changes')));

Finder _inChange(int index, Finder matching) =>
    find.descendant(of: find.byKey(ValueKey('change-$index')), matching: matching);

/// The passages a message pane highlights, in order.
List<String> _highlighted(WidgetTester tester, Finder pane) => [
  for (final text in tester.widgetList<Text>(find.descendant(of: pane, matching: find.byType(Text))))
    for (final child in (text.textSpan as TextSpan?)?.children ?? const <InlineSpan>[])
      if (child is TextSpan && child.style?.backgroundColor != null) child.text!,
];

FakeProvider _demoBehindFake() => FakeProvider.scripted((request) => demoChangeExplanation(request, testNow));

void main() {
  testWidgets('with Private AI off, Compare Messages is as before: no What Changed', (tester) async {
    await pumpLoupe(tester);
    await _compareStoryline(tester);
    expect(find.byType(EmailChangesSheet), findsOneWidget);
    expect(find.text('What Changed'), findsNothing);
    expect(find.byKey(const ValueKey('explain-changes')), findsNothing);
    expect(find.text('Message Text'), findsOneWidget);
    expect(find.textContaining('Arrangement fee: £1,499', findRichText: true), findsOneWidget);
  });

  testWidgets('explains the revised illustration: the figures changed, the confirmation new, the term not listed', (
    tester,
  ) async {
    await pumpLoupe(tester, prefs: _on);
    await _compareStoryline(tester);
    expect(find.text('What Changed'), findsOneWidget);
    expect(find.text('Explains the changed facts, each linked to its passages in both messages.'), findsOneWidget);
    await _tapExplain(tester);
    await tester.pumpAndSettle();

    expect(find.textContaining('Initial rate, arrangement fee and monthly payment differ'), findsOneWidget);
    expect(find.text('Changed'), findsNWidgets(3));
    expect(_inChange(0, find.text('Initial rate')), findsOneWidget);
    expect(_inChange(0, find.text('4.29% fixed for 5 years → 4.19% fixed for 5 years')), findsOneWidget);
    expect(_inChange(1, find.text('£999 → £1,499')), findsOneWidget);
    expect(_inChange(2, find.text('£1,408.72 → £1,392.01')), findsOneWidget);
    expect(_inChange(3, find.text('New')), findsOneWidget);
    expect(_inChange(3, find.textContaining('Please confirm by')), findsOneWidget);
    expect(find.text('No longer mentioned'), findsNWidgets(7));
    expect(find.text('Term'), findsNothing);
    expect(find.textContaining(RegExp('cancel', caseSensitive: false)), findsNothing);
    expect(find.text('Each passage was found in its message. Read them before relying on a change.'), findsOneWidget);
    expect(
      find.text('Only the message text is explained. Attachments are compared by name, type and size only.'),
      findsOneWidget,
    );
    expect(find.text('Made by the built-in demo, not a model.'), findsOneWidget);
    expect(find.textContaining(DemoPrivateAi.password, findRichText: true), findsNothing);

    // The exact line diff is still right below, and the explanation survives scrolling to it and back.
    final list = find.descendant(of: find.byType(EmailChangesSheet), matching: find.byType(Scrollable)).first;
    await tester.scrollUntilVisible(find.text('Message Text'), 300, scrollable: list);
    expect(find.textContaining('Arrangement fee: £1,499', findRichText: true), findsOneWidget);
    await tester.scrollUntilVisible(find.text('What Changed'), -300, scrollable: list);
    expect(find.byKey(const ValueKey('explain-changes')), findsNothing);
    expect(find.text('£999 → £1,499'), findsOneWidget);
  });

  testWidgets('a change opens both passages, highlighted in their messages and scrolled to', (tester) async {
    await pumpLoupe(tester, prefs: _on);
    await _compareStoryline(tester);
    await _tapExplain(tester);
    await tester.pumpAndSettle();

    await _tapInSheet(tester, find.byKey(const ValueKey('change-1')));
    await tester.pumpAndSettle();
    expect(find.byType(ChangePassagesSheet), findsOneWidget);
    final from = find.byKey(const ValueKey('passages-from'));
    final to = find.byKey(const ValueKey('passages-to'));
    expect(find.descendant(of: from, matching: find.textContaining('From Message · Rhea Patel · ')), findsOneWidget);
    expect(find.descendant(of: to, matching: find.textContaining('To Message · Rhea Patel · ')), findsOneWidget);
    expect(_highlighted(tester, from), ['Arrangement fee: £999']);
    expect(_highlighted(tester, to), ['Arrangement fee: £1,499']);
    await tester.tap(find.descendant(of: find.byType(ChangePassagesSheet), matching: find.text('Done')));
    await tester.pumpAndSettle();
    expect(find.byType(ChangePassagesSheet), findsNothing);

    // "Next steps" is far down the first message: its pane scrolls to it, and
    // the revised message, which doesn't mention it, highlights nothing.
    final nextSteps = find.ancestor(of: find.text('Next steps'), matching: find.byType(InkWell));
    await _tapInSheet(tester, nextSteps);
    await tester.pumpAndSettle();
    expect(find.text('No longer mentioned'), findsWidgets);
    expect(_highlighted(tester, from).single, startsWith('Next steps: once the case has been submitted'));
    expect(_highlighted(tester, to), isEmpty);
    expect(find.descendant(of: to, matching: find.text('No passage highlighted in this message.')), findsOneWidget);
    final line = find.descendant(
      of: from,
      matching: find.byWidgetPredicate(
        (w) => w is Text && (w.textSpan?.toPlainText().startsWith('Next steps') ?? false),
      ),
    );
    final scrollable = find.descendant(of: from, matching: find.byType(Scrollable));
    expect(tester.getRect(scrollable).overlaps(tester.getRect(line)), isTrue);
    expect(tester.state<ScrollableState>(scrollable).position.pixels, greaterThan(0));
  });

  testWidgets('a failure says why and offers Retry; nothing is asked anywhere else', (tester) async {
    final fake = _demoBehindFake()..failWith = const AiProviderException('The model isn’t downloaded yet.');
    await pumpLoupe(tester, prefs: _on, overrides: [aiProviderProvider.overrideWithValue(fake)]);
    await _compareStoryline(tester);
    await _tapExplain(tester);
    await tester.pumpAndSettle();
    expect(find.text('Loupe couldn’t explain these changes.'), findsOneWidget);
    expect(find.text('The model didn’t answer.'), findsOneWidget);
    expect(find.text('The model isn’t downloaded yet.'), findsOneWidget);
    expect(find.text('Initial rate'), findsNothing);
    expect(fake.requests, hasLength(1));

    fake.failWith = null;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Loupe couldn’t explain these changes.'), findsNothing);
    expect(find.text('£999 → £1,499'), findsOneWidget);
    expect(find.text('Made by fake · fake-1'), findsOneWidget);
    expect(fake.requests, hasLength(2));
  });

  testWidgets('an answer that fails the checks twice is not shown', (tester) async {
    final fake = FakeProvider(
      answers: ['{"summary": "The fee was cancelled.", "no_change_in_meaning": true, "changes": []}'],
    );
    await pumpLoupe(tester, prefs: _on, overrides: [aiProviderProvider.overrideWithValue(fake)]);
    await _compareStoryline(tester);
    await _tapExplain(tester);
    await tester.pumpAndSettle();
    expect(find.text('The answer didn’t pass Loupe’s checks, so none of it is shown.'), findsOneWidget);
    expect(find.text('The fee was cancelled.'), findsNothing);
    expect(fake.requests, hasLength(2));
  });

  testWidgets('explaining can be cancelled, and a result is reused next time', (tester) async {
    final fake = _demoBehindFake()..delay = const Duration(seconds: 5);
    await pumpLoupe(tester, prefs: _on, overrides: [aiProviderProvider.overrideWithValue(fake)]);
    await _compareStoryline(tester);
    await _tapExplain(tester);
    await tester.pump();
    expect(find.text('Explaining the changes…'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(find.text('Explaining the changes…'), findsNothing);
    expect(find.byKey(const ValueKey('explain-changes')), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
    expect(find.text('Initial rate'), findsNothing);

    fake.delay = Duration.zero;
    await _tapExplain(tester);
    await tester.pumpAndSettle();
    expect(find.text('£999 → £1,499'), findsOneWidget);
    expect(fake.requests, hasLength(2));

    await tester.tap(find.descendant(of: find.byType(EmailChangesSheet), matching: find.text('Done')));
    await tester.pumpAndSettle();
    await _compareStoryline(tester);
    expect(find.byKey(const ValueKey('explain-changes')), findsNothing);
    expect(find.text('£999 → £1,499'), findsOneWidget);
    expect(fake.requests, hasLength(2));
  });

  testWidgets('What Changed and its passages fit a narrow phone with large text', (tester) async {
    tester.view.physicalSize = const Size(360 * 3, 740 * 3);
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final pair = [_story.first, _story.singleWhere((m) => m.summary.id == _revisedId)];
    await pumpTestApp(
      tester,
      repository: FakeMailRepository(),
      overrides: [aiProviderProvider.overrideWithValue(DemoAiProvider(now: () => testNow))],
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => unawaited(
              showEmailChangesSheet(
                context,
                messages: [for (final m in pair) m.summary],
                initialEmailId: _revisedId,
                loadContent: (message) async {
                  final m = pair.singleWhere((m) => m.summary.id == message.id);
                  return EmailContent(emailId: message.id, text: m.text);
                },
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await _finishComparison(tester);
    await _tapExplain(tester);
    await tester.pumpAndSettle();
    expect(find.text('£999 → £1,499'), findsOneWidget);
    expect(tester.takeException(), isNull);
    for (final index in [0, 3, 4]) {
      await _tapInSheet(tester, find.byKey(ValueKey('change-$index')));
      await tester.pumpAndSettle();
      expect(find.byType(ChangePassagesSheet), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.descendant(of: find.byType(ChangePassagesSheet), matching: find.text('Done')));
      await tester.pumpAndSettle();
    }
  });
}
