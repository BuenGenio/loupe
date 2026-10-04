import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:loupe/features/keyboard/shortcut_sheet.dart';
import 'package:loupe/features/message_list/message_list_screen.dart';
import 'package:loupe/features/panes/mail_home.dart';
import 'package:loupe/features/panes/mail_selection.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:mail_model/mail_model.dart';

import '../panes/fake_app.dart';

const wide = Size(1280, 800);
const phone = Size(390, 844);

ProviderContainer containerOf(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

String? shownMessage(WidgetTester tester) => containerOf(tester).read(mailSelectionProvider).messageId;

Finder conversationShowing(String subject) =>
    find.descendant(of: find.byType(ConversationScreen), matching: find.text(subject));

MessageRow rowOf(WidgetTester tester, String subject) =>
    tester.widget<MessageRow>(find.ancestor(of: find.text(subject), matching: find.byType(MessageRow)).first);

Future<void> openRow(WidgetTester tester, String subject) async {
  await tester.tap(find.descendant(of: find.byType(MessageRow), matching: find.text(subject)));
  await tester.pumpAndSettle();
}

void main() {
  group('reading in the panes', () {
    testWidgets('E archives the conversation shown, and the next one takes its place', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.keyE);
      expect(repo.log, contains('archive [m1]'));
      expect(shownMessage(tester), 'm2');
      expect(conversationShowing('Quarterly report'), findsOneWidget);
      await drain(tester);
    });

    testWidgets('holding E archives once; holding J keeps moving', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Lunch plans');
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyE);
      await tester.sendKeyRepeatEvent(LogicalKeyboardKey.keyE);
      await tester.sendKeyRepeatEvent(LogicalKeyboardKey.keyE);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyE);
      await tester.pumpAndSettle();
      expect(repo.log.where((l) => l.startsWith('archive')), ['archive [m1]']);

      await press(tester, LogicalKeyboardKey.keyK);
      expect(shownMessage(tester), 'm1');
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyJ);
      await tester.pumpAndSettle();
      await tester.sendKeyRepeatEvent(LogicalKeyboardKey.keyJ);
      await tester.pumpAndSettle();
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyJ);
      await tester.pumpAndSettle();
      expect(shownMessage(tester), 'm3');
      await drain(tester);
    });

    testWidgets('Delete and Backspace move to Trash', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Garden party');
      await press(tester, LogicalKeyboardKey.delete);
      expect(repo.log, contains('trash [m3]'));
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.backspace);
      expect(repo.log, contains('trash [m1]'));
      await drain(tester);
    });

    testWidgets('Shift+U toggles read and S toggles the flag', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Garden party');
      repo.keywordCalls.clear();
      await press(tester, LogicalKeyboardKey.keyU, shift: true);
      expect(repo.keywordCalls.single.remove, {Keywords.seen});
      expect(repo.keywordCalls.single.ids, ['m3']);
      await press(tester, LogicalKeyboardKey.keyS);
      expect(repo.keywordCalls.last.add, {Keywords.flagged});
      await press(tester, LogicalKeyboardKey.keyS);
      expect(repo.keywordCalls.last.remove, {Keywords.flagged});
    });

    testWidgets('R, Shift+R and F open Compose as a reply, a reply to all and a forward', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await openRow(tester, 'Quarterly report');
      for (final (key, shift, mode) in [
        (LogicalKeyboardKey.keyR, false, ComposeMode.reply),
        (LogicalKeyboardKey.keyR, true, ComposeMode.replyAll),
        (LogicalKeyboardKey.keyF, false, ComposeMode.forward),
      ]) {
        await press(tester, key, shift: shift);
        final compose = tester.widget<ComposeScreen>(find.byType(ComposeScreen));
        expect(compose.args.mode, mode);
        expect(compose.args.sourceEmailId, 'm2');
        // Esc closes it like Cancel.
        await press(tester, LogicalKeyboardKey.escape);
        expect(find.byType(ComposeScreen), findsNothing);
      }
    });

    testWidgets('Ctrl+Enter sends from Compose, even while typing', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.keyR);
      await tester.showKeyboard(find.byKey(const Key('compose-body')));
      await press(tester, LogicalKeyboardKey.enter, ctrl: true);
      expect(repo.sent.single.subject, 'Re: Lunch plans');
      expect(find.byType(ComposeScreen), findsNothing);
      await drain(tester);
    });

    testWidgets('J and the down arrow open the next conversation, K and up the previous one', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await press(tester, LogicalKeyboardKey.keyJ);
      expect(shownMessage(tester), 'm1');
      await press(tester, LogicalKeyboardKey.keyJ);
      expect(shownMessage(tester), 'm2');
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(shownMessage(tester), 'm3');
      expect(rowOf(tester, 'Garden party').selected, isTrue);
      await press(tester, LogicalKeyboardKey.keyK);
      expect(shownMessage(tester), 'm2');
      await press(tester, LogicalKeyboardKey.arrowUp);
      expect(shownMessage(tester), 'm1');
    });

    testWidgets('Esc closes the conversation', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.escape);
      expect(shownMessage(tester), isNull);
      expect(find.byType(NoMessageSelected), findsOneWidget);
    });

    testWidgets('Back closes the conversation before leaving the app', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await openRow(tester, 'Lunch plans');
      final handled = await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(handled, isTrue);
      expect(shownMessage(tester), isNull);
    });

    testWidgets('/ focuses the list’s search field, letters then type, and Esc leaves search', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.slash);
      final field = find.descendant(of: find.byType(MessageListScreen), matching: find.byType(EditableText));
      expect(tester.widget<EditableText>(field).focusNode.hasFocus, isTrue);
      expect(find.text('Cancel'), findsOneWidget);
      // E is a letter of the query now, not Archive.
      await press(tester, LogicalKeyboardKey.keyE);
      expect(repo.log.where((l) => l.startsWith('archive')), isEmpty);
      await press(tester, LogicalKeyboardKey.escape);
      expect(find.text('Cancel'), findsNothing);
      expect(shownMessage(tester), 'm1');
    });
  });

  group('everywhere', () {
    testWidgets('Ctrl+N opens a new message', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: phone);
      await press(tester, LogicalKeyboardKey.keyN, ctrl: true);
      final compose = tester.widget<ComposeScreen>(find.byType(ComposeScreen));
      expect(compose.args.mode, ComposeMode.newMessage);
    });

    testWidgets('Ctrl+/ shows the shortcuts', (tester) async {
      await pumpAppOn(tester, threeConversations(), size: wide);
      await press(tester, LogicalKeyboardKey.slash, ctrl: true);
      expect(find.byType(ShortcutSheet), findsOneWidget);
      expect(find.text('Reply All'), findsOneWidget);
      await press(tester, LogicalKeyboardKey.escape);
      expect(find.byType(ShortcutSheet), findsNothing);
    });

    testWidgets('keys do nothing under a sheet', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: wide);
      await openRow(tester, 'Lunch plans');
      await press(tester, LogicalKeyboardKey.slash, ctrl: true);
      await press(tester, LogicalKeyboardKey.keyE);
      expect(repo.log.where((l) => l.startsWith('archive')), isEmpty);
    });
  });

  group('on a phone', () {
    testWidgets('J highlights a row, Enter opens it, J in the conversation shows the next one, Esc goes back', (
      tester,
    ) async {
      await pumpAppOn(tester, threeConversations(), size: phone);
      await tester.tap(find.text('All Inboxes'));
      await tester.pumpAndSettle();
      expect(rowOf(tester, 'Lunch plans').selected, isFalse);

      await press(tester, LogicalKeyboardKey.keyJ);
      expect(rowOf(tester, 'Lunch plans').selected, isTrue);
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(rowOf(tester, 'Quarterly report').selected, isTrue);
      expect(rowOf(tester, 'Lunch plans').selected, isFalse);

      await press(tester, LogicalKeyboardKey.enter);
      expect(conversationShowing('Quarterly report'), findsOneWidget);

      await press(tester, LogicalKeyboardKey.keyJ);
      expect(conversationShowing('Garden party'), findsOneWidget);
      await press(tester, LogicalKeyboardKey.keyK);
      expect(conversationShowing('Quarterly report'), findsOneWidget);

      await press(tester, LogicalKeyboardKey.escape);
      expect(find.byType(ConversationScreen), findsNothing);
      expect(find.text('Garden party'), findsOneWidget);
    });

    testWidgets('E on the highlighted row archives it', (tester) async {
      final repo = threeConversations();
      await pumpAppOn(tester, repo, size: phone);
      await tester.tap(find.text('All Inboxes'));
      await tester.pumpAndSettle();
      await press(tester, LogicalKeyboardKey.keyJ);
      await press(tester, LogicalKeyboardKey.keyE);
      expect(repo.log, contains('archive [m1]'));
      await drain(tester);
    });
  });
}

Future<void> drain(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 12));
  await tester.pumpAndSettle();
}
