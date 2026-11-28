import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

void main() {
  final mortgage = DemoPrivateAi.threadId(DemoPrivateAi.mortgageThread);

  /// The tile of [title] on the Mailboxes screen.
  Finder tile(String title) => find.ancestor(of: find.text(title), matching: find.byType(InkWell)).first;

  Future<List<EmailSummary>> conversation(DemoMailRepository repo, String threadId) async {
    final rows = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes)).first;
    return repo.watchConversation(rows.firstWhere((r) => r.threadId == threadId).latest.id).first;
  }

  /// Scrolls the open details sheet to [key] and taps it.
  Future<void> pick(WidgetTester tester, String key) async {
    final row = find.byKey(ValueKey(key));
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.tap(row);
    await tester.pumpAndSettle();
  }

  Future<ActionRecord> action(DemoMailRepository repo, String words) async =>
      (await repo.watchActions(includeDeleted: true).first).singleWhere((a) => a.quote.contains(words));

  testWidgets('the two folders sit with the other mailboxes and count conversations', (tester) async {
    await pumpLoupe(tester);
    expect(find.descendant(of: tile('Needs My Action'), matching: find.text('3')), findsOneWidget);
    expect(find.descendant(of: tile('Waiting on Others'), matching: find.text('1')), findsOneWidget);

    await tester.tap(find.text('Needs My Action'));
    await tester.pumpAndSettle();
    // Newest activity first, each row with its open actions and the next due.
    final subjects = [
      'Invoice INV-2207: deposit for your move',
      'Re: Your mortgage application: what we need next',
      '14 Quay Street: client care letter and next steps',
    ];
    final tops = [for (final s in subjects) tester.getTopLeft(find.text(s)).dy];
    expect(tops, orderedEquals([...tops]..sort()));
    expect(find.text('1 to do'), findsOneWidget);
    expect(find.text('4 to do'), findsOneWidget);
    expect(find.text('3 to do'), findsOneWidget);
    expect(textContaining('Due '), findsWidgets);

    await systemBack(tester);
    await tester.tap(find.text('Waiting on Others'));
    await tester.pumpAndSettle();
    // The mortgage conversation is in both folders.
    expect(find.text('Re: Your mortgage application: what we need next'), findsOneWidget);
    expect(find.text('1 waiting'), findsOneWidget);
  });

  testWidgets('a conversation’s actions: complete one with Undo, change its state, reword it, remind, delete', (
    tester,
  ) async {
    final repo = await pumpLoupe(tester);
    final messages = await conversation(repo, mortgage);
    await goTo(tester, Routes.message(messages.last.id));
    expect(find.text('4 to do'), findsOneWidget);
    expect(find.text('1 waiting'), findsOneWidget);
    await tester.tap(find.byKey(const Key('conversation-actions')));
    await tester.pumpAndSettle();
    expect(find.text('NEEDS MY ACTION'), findsOneWidget);
    expect(find.text('WAITING ON OTHERS'), findsOneWidget);
    expect(find.text('SETTLED'), findsOneWidget);
    expect(find.text('in the Harbour app'), findsOneWidget, reason: 'the ID check’s channel');

    // Done from the mark, and back with Undo.
    final overview = await action(repo, 'tax year overview');
    await tester.tap(find.byKey(ValueKey('action-mark-${overview.id}')));
    await tester.pumpAndSettle();
    expect((await action(repo, 'tax year overview')).state, ActionState.done);
    expect(find.text('Marked as done'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect((await action(repo, 'tax year overview')).state, ActionState.needsAction);
    expect((await action(repo, 'tax year overview')).history, hasLength(1));

    // The details: the passage it quotes, where it came from; a state from the list.
    await tester.tap(find.text(overview.currentRequest));
    await tester.pumpAndSettle();
    expect(find.text('“${overview.quote}”'), findsOneWidget);
    expect(find.text('Suggested by the built-in demo: rules, no model'), findsOneWidget);
    await pick(tester, 'action-state-sent');
    expect(find.text('Marked as sent'), findsOneWidget);
    expect((await action(repo, 'tax year overview')).state, ActionState.sent);

    // Reworded: the original stays.
    await tester.tap(find.text(overview.currentRequest));
    await tester.pumpAndSettle();
    await pick(tester, 'action-edit');
    await tester.enterText(find.byKey(const ValueKey('action-text-field')), 'Tax year overview 2025 (HMRC)');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    var record = await action(repo, 'tax year overview');
    expect(record.currentRequest, 'Tax year overview 2025 (HMRC)');
    expect(record.originalRequest, overview.currentRequest);
    expect(record.overridden, containsAll([ActionField.text, ActionField.state]));
    expect(find.text('Tax year overview 2025 (HMRC)'), findsOneWidget);

    // A reminder of its own.
    await tester.tap(find.text('Tax year overview 2025 (HMRC)'));
    await tester.pumpAndSettle();
    await pick(tester, 'action-remind');
    await tester.tap(find.byKey(const ValueKey('snooze-tomorrow')));
    await tester.pumpAndSettle();
    record = await action(repo, 'tax year overview');
    final today = clock.now();
    expect(record.remindAt, DateTime(today.year, today.month, today.day + 1, 8), reason: 'Tomorrow, 08:00');
    expect(textContaining('Reminder set for'), findsOneWidget);

    // Deleted, and back.
    await tester.tap(find.text('Tax year overview 2025 (HMRC)'));
    await tester.pumpAndSettle();
    await pick(tester, 'action-delete');
    expect((await action(repo, 'tax year overview')).deleted, isTrue);
    expect(find.text('Tax year overview 2025 (HMRC)'), findsNothing);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect((await action(repo, 'tax year overview')).deleted, isFalse);
    expect(find.text('Tax year overview 2025 (HMRC)'), findsOneWidget);

    // The history, newest first.
    await tester.tap(find.text('Tax year overview 2025 (HMRC)'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('HISTORY'));
    expect(find.text('Reworded'), findsOneWidget);
    expect(find.text('Reminder changed'), findsOneWidget);
    await drainTimers(tester);
  });
}
