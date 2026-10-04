import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/mailboxes/mailboxes_screen.dart';
import 'package:loupe/features/panes/message_drag.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'fake_app.dart';

const wide = Size(1280, 800);
const split = Size(900, 1200);

Finder rowText(String subject) => find.descendant(of: find.byType(MessageRow), matching: find.text(subject));

Finder mailbox(String name) => find.descendant(of: find.byType(MailboxesScreen), matching: find.text(name));

/// Long-presses [from], drags to [to] and lets go; [whileOver] runs over the target.
Future<void> dragAndDrop(WidgetTester tester, Finder from, Finder to, {Future<void> Function()? whileOver}) async {
  final gesture = await tester.startGesture(tester.getCenter(from));
  await tester.pump(kLongPressTimeout + const Duration(milliseconds: 100));
  await gesture.moveBy(const Offset(20, 20));
  await tester.pump();
  // The split layout's sidebar slides in.
  await tester.pumpAndSettle();
  await gesture.moveTo(tester.getCenter(to));
  await tester.pump();
  await whileOver?.call();
  await gesture.up();
  await tester.pumpAndSettle();
}

Future<void> drain(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('dropping a message on a mailbox moves it, with Undo', (tester) async {
    final repo = threeConversations();
    await pumpAppOn(tester, repo, size: wide);
    await dragAndDrop(tester, rowText('Lunch plans'), mailbox('Receipts'));
    expect(repo.log, contains('move [m1] acc|Receipts'));
    expect(rowText('Lunch plans'), findsNothing);
    expect(find.text('Moved 1 message to Receipts'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(repo.log, contains('move [m1] acc|INBOX'));
    expect(rowText('Lunch plans'), findsOneWidget);
    await drain(tester);
  });

  testWidgets('the mailbox under a dragged message lights up', (tester) async {
    await pumpAppOn(tester, threeConversations(), size: wide);
    await dragAndDrop(
      tester,
      rowText('Lunch plans'),
      mailbox('Receipts'),
      whileOver: () async {
        final ink = tester.widget<Ink>(find.ancestor(of: mailbox('Receipts'), matching: find.byType(Ink)).first);
        expect((ink.decoration as BoxDecoration?)?.color, isNotNull);
      },
    );
    await drain(tester);
  });

  testWidgets('dragging a selection carries all of it, with its count', (tester) async {
    final repo = threeConversations();
    await pumpAppOn(tester, repo, size: wide);
    await tester.tap(find.text('Edit').last);
    await tester.pumpAndSettle();
    await tester.tap(rowText('Lunch plans'));
    await tester.tap(rowText('Quarterly report'));
    await tester.pumpAndSettle();
    await dragAndDrop(
      tester,
      rowText('Quarterly report'),
      mailbox('Receipts'),
      whileOver: () async {
        expect(find.byKey(const Key('drag-count')), findsOneWidget);
        expect(find.text('2 Messages'), findsOneWidget);
      },
    );
    expect(repo.log, contains('move [m1, m2] acc|Receipts'));
    expect(find.text('Moved 2 messages to Receipts'), findsOneWidget);
    // Out of Edit mode.
    expect(find.text('Select Messages'), findsNothing);
    await drain(tester);
  });

  testWidgets('a long press put back where it started opens More, as on a phone', (tester) async {
    final repo = threeConversations();
    await pumpAppOn(tester, repo, size: wide);
    await tester.longPress(rowText('Garden party'));
    await tester.pumpAndSettle();
    expect(find.text('Move Message…'), findsOneWidget);
    expect(repo.log.where((l) => l.startsWith('move')), isEmpty);
  });

  testWidgets('in the split layout the sidebar comes out for the drop and goes away after', (tester) async {
    final repo = threeConversations();
    await pumpAppOn(tester, repo, size: split);
    expect(mailbox('Receipts').hitTestable(), findsNothing);
    await dragAndDrop(tester, rowText('Lunch plans'), mailbox('Receipts'));
    expect(repo.log, contains('move [m1] acc|Receipts'));
    expect(mailbox('Receipts').hitTestable(), findsNothing);
    await drain(tester);
  });

  group('MessageDrag', () {
    ThreadSummary row(EmailSummary e) => ThreadSummary(threadId: e.id, latest: e, messageCount: 1, unreadCount: 0);
    const receipts = Mailbox(id: 'acc|Receipts', accountId: 'acc', name: 'Receipts', path: 'Receipts');

    test('goes to a mailbox of its account other than where it is', () {
      MessageDrag drag(List<EmailSummary> emails) => MessageDrag(
        rows: [for (final e in emails) row(e)],
        scope: const VirtualMailboxRef(VirtualMailbox.allInboxes),
        threaded: true,
      );
      expect(drag([testEmail('a')]).canMoveTo(receipts), isTrue);
      expect(drag([testEmail('a', mailboxId: 'acc|Receipts')]).canMoveTo(receipts), isFalse);
      final other = EmailSummary(
        id: 'b',
        accountId: 'other',
        mailboxId: 'other|INBOX',
        receivedAt: DateTime(2026),
        subject: 'x',
      );
      expect(drag([testEmail('a'), other]).canMoveTo(receipts), isFalse);
      expect(
        drag([testEmail('a')]).canMoveTo(
          const Mailbox(id: 'acc|Lists', accountId: 'acc', name: 'Lists', path: 'Lists', isSelectable: false),
        ),
        isFalse,
      );
    });
  });
}
