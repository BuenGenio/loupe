import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/shared/sheets.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  const mailboxes = [
    Mailbox(id: 'a|INBOX', accountId: 'a', name: 'Inbox', path: 'INBOX', role: MailboxRole.inbox),
    Mailbox(id: 'a|Projects', accountId: 'a', name: 'Projects', path: 'Projects'),
    Mailbox(id: 'a|Old', accountId: 'a', name: 'Old', path: 'Old', isSubscribed: false),
  ];

  Future<void> open(WidgetTester tester, {required bool showAll}) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: LoupeTheme.light(),
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showMailboxPicker(context, mailboxes: mailboxes, accountId: 'a', showAllFolders: showAll),
            child: const Text('Move'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Move'));
    await tester.pumpAndSettle();
  }

  testWidgets('Move picker hides unsubscribed folders', (tester) async {
    await open(tester, showAll: false);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Old'), findsNothing);
  });

  testWidgets('Move picker shows every folder with Show All Folders', (tester) async {
    await open(tester, showAll: true);
    expect(find.text('Old'), findsOneWidget);
  });
}
