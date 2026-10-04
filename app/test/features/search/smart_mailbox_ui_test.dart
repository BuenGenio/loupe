import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/ui_state.dart';
import 'package:loupe/shared/mailbox_ref_codec.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

/// Smart Mailboxes saved before syncing existed (the migration path).
Map<String, Object> _saved(List<Map<String, Object?>> boxes) => {SmartMailboxes.legacyKey: jsonEncode(boxes)};

final _unified = {'id': 'lq3k2x1a9b', 'name': 'Invoices', 'query': 'invoice', 'scope': null};
final _workFolder = {
  'id': 'lq3k2x1a9c',
  'name': 'Work inbox',
  'query': 'is:unread',
  'scope': MailboxRefCodec.encode(RealMailboxRef(MailIds.mailbox('work', 'INBOX'))),
};

/// Lets the debounced sync round run.
Future<void> _syncRound(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a Smart Mailbox says where it is kept', (tester) async {
    final repo = await pumpLoupe(tester, prefs: _saved([_unified]));
    await goTo(tester, Routes.smartMailbox('lq3k2x1a9b'));
    await _syncRound(tester);
    expect(find.text('Synced to Work'), findsOneWidget);
    expect(repo.serverDocuments['work']?[ServerDocuments.smartMailboxes], contains('Invoices'));
  });

  testWidgets('Settings › Smart Mailboxes › Sync via Off keeps them on this device', (tester) async {
    await pumpLoupe(tester, prefs: _saved([_unified]));
    await goTo(tester, Routes.settings);
    await tester.scrollTo(find.text('Smart Mailboxes'));
    await tester.tap(find.text('Smart Mailboxes'));
    await tester.pumpAndSettle();
    expect(find.text('Sync via'), findsOneWidget);
    expect(find.text('Work'), findsWidgets);

    await tester.tap(find.text('Sync via'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Off'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(LoupeIcons.back).last);
    await tester.pumpAndSettle();
    expect(find.text('Smart Mailboxes stay on this device.'), findsOneWidget);

    await goTo(tester, Routes.smartMailbox('lq3k2x1a9b'));
    expect(find.text('On this device only'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('the Loupe Settings folder is hidden on Mailboxes and explained in Manage Folders', (tester) async {
    await pumpLoupe(
      tester,
      prefs: {
        ..._saved([_workFolder]),
        'mailboxes.showAllFolders': ['work'],
      },
    );
    await _syncRound(tester);
    // The work account's demo server has no METADATA: the folder exists now.
    await tester.scrollTo(find.text('Work inbox'));
    expect(find.text('Work inbox'), findsOneWidget);
    expect(find.text(ServerDocuments.folderName), findsNothing);

    await goTo(tester, Routes.manageFolders('work'));
    await tester.scrollTo(find.text(ServerDocuments.folderName));
    expect(find.text(ServerDocuments.folderName), findsOneWidget);
    expect(textContaining('Keeps your Smart Mailboxes'), findsOneWidget);
    await drainTimers(tester);
  });
}
