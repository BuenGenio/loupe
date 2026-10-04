import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:loupe/features/mailboxes/mailboxes_screen.dart';
import 'package:loupe/features/message_list/message_list_screen.dart';
import 'package:loupe/features/panes/mail_home.dart';
import 'package:loupe/features/panes/mail_selection.dart';
import 'package:loupe/features/panes/pane_layout.dart';
import 'package:loupe/router.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

const phone = Size(390, 844);
const split = Size(900, 1200);
const wide = Size(1280, 800);

const hike = 'Photos from Sunday’s hike';
const allInboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);

ProviderContainer containerOf(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

GoRouter routerOf(WidgetTester tester) => containerOf(tester).read(routerProvider);

/// The locations of the pages on the stack, bottom up.
List<String> stackOf(WidgetTester tester) => [
  for (final m in routerOf(tester).routerDelegate.currentConfiguration.matches)
    if (m is ImperativeRouteMatch) m.matches.uri.toString() else m.matchedLocation,
];

Future<void> resize(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size * 3;
  await tester.pumpAndSettle();
}

Finder get conversationTitle => find.descendant(of: find.byType(ConversationScreen), matching: find.text(hike));

void main() {
  group('pane structure', () {
    testWidgets('a phone shows Mailboxes alone, as before', (tester) async {
      await pumpLoupe(tester, size: phone);
      expect(find.byType(MailboxesScreen), findsOneWidget);
      expect(find.byType(MessageListScreen), findsNothing);
      expect(find.byType(NoMessageSelected), findsNothing);
      expect(find.byKey(const Key('sidebar-toggle')), findsNothing);
    });

    testWidgets('at 900 dp the list and the conversation share the screen; Mailboxes slides in', (tester) async {
      await pumpLoupe(tester, size: split);
      expect(find.byType(MessageListScreen), findsOneWidget);
      expect(find.byType(NoMessageSelected), findsOneWidget);
      expect(find.text('Mailboxes').hitTestable(), findsNothing);

      await tester.tap(find.byKey(const Key('sidebar-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('Mailboxes').hitTestable(), findsOneWidget);

      // Picking a mailbox shows it and closes the sidebar.
      await tester.tap(find.text('Flagged').hitTestable());
      await tester.pumpAndSettle();
      expect(find.text('Mailboxes').hitTestable(), findsNothing);
      expect(
        containerOf(tester).read(mailSelectionProvider).list,
        const MailboxTarget(VirtualMailboxRef(VirtualMailbox.flagged)),
      );
      expect(stackOf(tester), [Routes.mailboxes]);
    });

    testWidgets('from 1100 dp Mailboxes, the list and the conversation sit side by side', (tester) async {
      await pumpLoupe(tester, size: wide);
      expect(find.byType(MailboxesScreen), findsOneWidget);
      expect(find.text('Mailboxes').hitTestable(), findsOneWidget);
      expect(find.byType(MessageListScreen), findsOneWidget);
      expect(find.byType(NoMessageSelected), findsOneWidget);
      final mailboxes = tester.getRect(find.byType(MailboxesScreen));
      final list = tester.getRect(find.byType(MessageListScreen));
      expect(mailboxes.right, lessThan(list.left + 1));
      expect(list.width, PaneWidths.defaultList);
    });

    testWidgets('the sidebar button hides the Mailboxes column, and it stays hidden', (tester) async {
      await pumpLoupe(tester, size: wide);
      await tester.tap(find.byKey(const Key('sidebar-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('Mailboxes'), findsNothing);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(PaneWidthsController.hiddenKey), isTrue);
    });

    testWidgets('dragging a divider resizes the list and remembers it', (tester) async {
      await pumpLoupe(tester, size: wide);
      final before = tester.getRect(find.byType(MessageListScreen));
      await tester.timedDragFrom(Offset(before.right, 400), const Offset(80, 0), const Duration(milliseconds: 300));
      await tester.pumpAndSettle();
      final after = tester.getRect(find.byType(MessageListScreen));
      expect(after.width, closeTo(before.width + 80, 1));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble(PaneWidthsController.listKey), closeTo(before.width + 80, 1));
    });
  });

  group('selection', () {
    testWidgets('a row opens in the conversation pane and stays highlighted', (tester) async {
      await pumpLoupe(tester, size: wide);
      await tester.tap(find.text(hike));
      await tester.pumpAndSettle();
      expect(conversationTitle, findsOneWidget);
      expect(find.byType(NoMessageSelected), findsNothing);
      final row = tester.widget<MessageRow>(find.ancestor(of: find.text(hike), matching: find.byType(MessageRow)));
      expect(row.selected, isTrue);
      expect(stackOf(tester), [Routes.mailboxes]);
    });

    testWidgets('a mailbox tapped in the Mailboxes pane opens in the list pane, not as a page', (tester) async {
      await pumpLoupe(tester, size: wide);
      await tester.tap(find.text('Flagged'));
      await tester.pumpAndSettle();
      expect(stackOf(tester), [Routes.mailboxes]);
      final list = tester.widget<MessageListScreen>(find.byType(MessageListScreen));
      expect(list.mailboxRef, const VirtualMailboxRef(VirtualMailbox.flagged));
    });

    testWidgets('a message route pushed over the panes (a notification) opens in its pane', (tester) async {
      final repo = await pumpLoupe(tester, size: wide);
      final rows = await repo.watchList(allInboxes, threaded: false).first;
      final email = rows.firstWhere((r) => r.latest.subject == hike).latest;
      await goTo(tester, Routes.message(email.id));
      expect(stackOf(tester), [Routes.mailboxes]);
      expect(conversationTitle, findsOneWidget);
    });
  });

  group('resizing keeps the message', () {
    testWidgets('unfolding while reading lands in the panes; folding returns to the same page', (tester) async {
      await pumpLoupe(tester, size: phone);
      await tester.tap(find.text('All Inboxes'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(hike));
      await tester.pumpAndSettle();
      expect(stackOf(tester), hasLength(3));

      await resize(tester, wide);
      expect(stackOf(tester), [Routes.mailboxes]);
      expect(find.byType(MailboxesScreen), findsOneWidget);
      expect(conversationTitle, findsOneWidget);
      expect(containerOf(tester).read(mailSelectionProvider).list, const MailboxTarget(allInboxes));

      await resize(tester, phone);
      expect(stackOf(tester), [Routes.mailboxes, Routes.list(allInboxes), startsWith('/message/')]);
      expect(conversationTitle, findsOneWidget);
      expect(find.byType(NoMessageSelected), findsNothing);

      // Back goes to the list, then to Mailboxes, as on a phone.
      routerOf(tester).pop();
      await tester.pumpAndSettle();
      expect(find.text(hike), findsOneWidget);
      expect(conversationTitle, findsNothing);
      routerOf(tester).pop();
      await tester.pumpAndSettle();
      expect(find.text('Mailboxes'), findsWidgets);
      expect(stackOf(tester), [Routes.mailboxes]);
    });

    testWidgets('rotating between 900 and 1280 dp keeps the list and the message', (tester) async {
      await pumpLoupe(tester, size: split);
      await tester.tap(find.text(hike));
      await tester.pumpAndSettle();
      await resize(tester, wide);
      expect(conversationTitle, findsOneWidget);
      expect(find.text('Mailboxes').hitTestable(), findsOneWidget);
      await resize(tester, split);
      expect(conversationTitle, findsOneWidget);
      final row = tester.widget<MessageRow>(find.ancestor(of: find.text(hike), matching: find.byType(MessageRow)));
      expect(row.selected, isTrue);
    });

    testWidgets('a mailbox chosen in the panes is the list page after folding', (tester) async {
      await pumpLoupe(tester, size: wide);
      await tester.tap(find.text('Flagged'));
      await tester.pumpAndSettle();
      await resize(tester, phone);
      expect(stackOf(tester), [Routes.mailboxes, Routes.list(const VirtualMailboxRef(VirtualMailbox.flagged))]);
    });

    testWidgets('folding with nothing chosen shows the list the panes showed', (tester) async {
      await pumpLoupe(tester, size: wide);
      await resize(tester, phone);
      expect(stackOf(tester), [Routes.mailboxes, Routes.list(allInboxes)]);
      expect(find.byType(MessageListScreen), findsOneWidget);
    });

    testWidgets('a page over the panes waits: folding under Settings rebuilds the stack after it', (tester) async {
      await pumpLoupe(tester, size: wide);
      await tester.tap(find.text(hike));
      await tester.pumpAndSettle();
      await goTo(tester, Routes.settings);
      await resize(tester, phone);
      expect(stackOf(tester), [Routes.mailboxes, Routes.settings]);
      routerOf(tester).pop();
      await tester.pumpAndSettle();
      expect(stackOf(tester), [Routes.mailboxes, Routes.list(allInboxes), startsWith('/message/')]);
      expect(conversationTitle, findsOneWidget);
    });
  });
}
