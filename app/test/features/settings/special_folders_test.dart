import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/router.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _detail(String role, String text) =>
    find.descendant(of: find.byKey(Key('account-folder-$role')), matching: find.text(text));

Future<Map<String, MailboxRole>> _roles(DemoMailRepository repo) async => {
  for (final m in await repo.watchMailboxes(accountId: 'work').first)
    if (m.role != MailboxRole.none) m.path: m.role,
};

Future<MailAccount> _work(DemoMailRepository repo) async =>
    (await repo.watchAccounts().first).firstWhere((a) => a.id == 'work');

void main() {
  testWidgets('an IMAP account picks its Trash folder, and goes back to Automatic', (tester) async {
    final repo = await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('work'));
    await tester.ensureVisible(find.byKey(const Key('account-special-folders')));
    await tester.pumpAndSettle();
    expect(_detail('sent', 'Sent Items'), findsOneWidget);
    expect(_detail('drafts', 'Drafts'), findsNWidgets(2), reason: 'the row’s title, and the folder');
    expect(_detail('trash', 'Deleted Items'), findsOneWidget);

    await _tap(tester, find.byKey(const Key('account-folder-trash')));
    // Automatic is chosen, showing the folder it found.
    expect(
      find.descendant(of: find.byKey(const Key('folder-role-automatic')), matching: find.text('Deleted Items')),
      findsOneWidget,
    );
    // The Inbox can't be picked.
    await _tap(tester, find.byKey(const ValueKey('folder-role-INBOX')));
    expect(find.byKey(const Key('folder-role-automatic')), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('folder-role-Team')));
    expect(find.byKey(const Key('folder-role-automatic')), findsNothing, reason: 'back on the account');
    expect(_detail('trash', 'Team'), findsOneWidget);
    expect((await _work(repo)).folderRoles, {MailboxRole.trash: 'Team'});
    expect((await _roles(repo))['Team'], MailboxRole.trash);
    expect((await _roles(repo)).containsKey('Deleted Items'), isFalse);

    await _tap(tester, find.byKey(const Key('account-folder-trash')));
    await _tap(tester, find.byKey(const Key('folder-role-automatic')));
    expect(_detail('trash', 'Deleted Items'), findsOneWidget);
    expect((await _work(repo)).folderRoles, isEmpty);
    expect((await _roles(repo))['Deleted Items'], MailboxRole.trash);
    expect((await _roles(repo)).containsKey('Team'), isFalse);
  });
}
