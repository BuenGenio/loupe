import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/router.dart';

import '../../helpers.dart';

/// Settings › account › Incoming, Outgoing or Sign-in: the Server Settings
/// screen, and the IDLE switch next to it.
void main() {
  const host = ValueKey('imap-host');

  /// Scrolls the account screen until [key]'s row is wholly on screen.
  Future<void> reveal(WidgetTester tester, Key key) async {
    await tester.scrollTo(find.byKey(key));
    await tester.ensureVisible(find.byKey(key));
    await tester.pumpAndSettle();
  }

  Future<void> openServers(WidgetTester tester, String accountId) async {
    await goTo(tester, Routes.accountSettings(accountId));
    await reveal(tester, const Key('account-incoming'));
    await tester.tap(find.byKey(const Key('account-incoming')));
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key('servers-save')));
    await tester.pumpAndSettle();
  }

  bool idleSwitch(WidgetTester tester) => tester
      .widget<CupertinoSwitch>(
        find.descendant(of: find.byKey(const Key('account-idle')), matching: find.byType(CupertinoSwitch)),
      )
      .value;

  testWidgets('a password account: the server, security and password change after a check', (tester) async {
    await pumpLoupe(tester);
    await openServers(tester, 'fastmail');
    expect(find.text('Server Settings'), findsOneWidget);
    expect(find.text('App Password'), findsOneWidget);
    expect(find.text('Unchanged'), findsOneWidget);
    expect(tester.widget<TextField>(find.byKey(host)).controller!.text, 'imap.fastmail.com');
    expect(find.byKey(const ValueKey('smtp-host')), findsOneWidget);

    await tester.enterText(find.byKey(host), 'mail.rivera.example');
    await tester.ensureVisible(find.byKey(const ValueKey('imap-security')));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byKey(const ValueKey('imap-security')), matching: find.text('STARTTLS')));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byKey(const ValueKey('imap-port'))).controller!.text, '143');

    // The demo server refuses this password: the error shows, nothing is saved.
    await tester.enterText(find.byKey(const Key('servers-password')), 'wrong');
    await save(tester);
    expect(textContaining('Password rejected'), findsOneWidget);
    expect(find.text('Server Settings'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('servers-password')), 'new-app-password');
    await save(tester);
    expect(find.text('Server Settings'), findsNothing);
    await reveal(tester, const Key('account-incoming'));
    expect(find.text('IMAP · mail.rivera.example:143 · STARTTLS'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('an unreachable server is reported and Cancel keeps the old settings', (tester) async {
    await pumpLoupe(tester);
    await openServers(tester, 'fastmail');
    await tester.enterText(find.byKey(host), 'unreachable.example');
    await save(tester);
    expect(textContaining('Can\'t reach server'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await reveal(tester, const Key('account-incoming'));
    expect(find.text('IMAP · imap.fastmail.com:993 · TLS'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('the Sign-in row opens the same screen; Save without changes just closes it', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('fastmail'));
    await reveal(tester, const Key('account-sign-in'));
    await tester.tap(find.byKey(const Key('account-sign-in')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('servers-password')), findsOneWidget);
    await save(tester);
    expect(find.text('Server Settings'), findsNothing);
  });

  testWidgets('OAuth accounts keep their provider’s servers', (tester) async {
    await pumpLoupe(tester);
    await openServers(tester, 'personal');
    expect(find.text('Server Settings'), findsNothing);
    expect(find.text('IMAP · imap.gmail.com:993 · TLS'), findsOneWidget);
  });

  testWidgets('IDLE switches off and on for one account', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.accountSettings('personal'));
    await reveal(tester, const Key('account-idle'));
    expect(find.text('IDLE'), findsOneWidget);
    expect(textContaining('one connection fewer'), findsOneWidget);
    expect(idleSwitch(tester), isTrue);

    await tester.tap(find.byKey(const Key('account-idle')));
    await tester.pumpAndSettle();
    expect(idleSwitch(tester), isFalse);

    // Another account keeps it.
    await goTo(tester, Routes.accountSettings('fastmail'));
    await reveal(tester, const Key('account-idle'));
    expect(idleSwitch(tester), isTrue);
    await goTo(tester, Routes.accountSettings('personal'));
    await reveal(tester, const Key('account-idle'));
    expect(idleSwitch(tester), isFalse);
  });
}
