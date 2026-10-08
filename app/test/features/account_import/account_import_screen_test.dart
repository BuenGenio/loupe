import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/account_import/account_import_screen.dart';
import 'package:loupe/features/account_import/qr_scanner.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart' show testNow;
import '../conversation/fake_mail_repository.dart';
import 'tb_payloads.dart';

/// Stands in for the camera: tests "scan" codes through [scan].
class FakeScanner {
  ValueChanged<String>? _onPayload;
  ScannerProblem? problem;
  int builds = 0;

  Widget build(
    BuildContext context, {
    required ValueChanged<String> onPayload,
    required Widget Function(BuildContext context, ScannerProblem problem) problem,
  }) {
    builds++;
    _onPayload = onPayload;
    final p = this.problem;
    return p == null
        ? const Center(
            child: Text('camera', style: TextStyle(color: Colors.white)),
          )
        : problem(context, p);
  }

  void scan(String payload) => _onPayload!(payload);
}

/// The import screen alone, against [repo], with a fake camera.
Future<(GoRouter, ProviderContainer)> pumpImport(
  WidgetTester tester,
  FakeMailRepository repo,
  FakeScanner scanner, {
  Future<void> Function()? openSettings,
  List<Override> overrides = const [],
}) async {
  tester.view
    ..physicalSize = const Size(390, 844) * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Center(child: Text('home'))),
      ),
      GoRoute(path: Routes.importAccounts, builder: (_, _) => const AccountImportScreen()),
    ],
  );
  addTearDown(router.dispose);
  final container = ProviderContainer(
    overrides: [
      repositoryProvider.overrideWithValue(repo),
      setupRepositoryProvider.overrideWith((ref) async => repo),
      sharedPreferencesProvider.overrideWithValue(prefs),
      qrScannerProvider.overrideWithValue(scanner.build),
      openAppSettingsProvider.overrideWithValue(openSettings ?? () async {}),
      ...overrides,
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        localizationsDelegates: loupeLocalizationsDelegates,
        theme: LoupeTheme.light(),
        routerConfig: router,
      ),
    ),
  );
  unawaited(router.push(Routes.importAccounts));
  await tester.pumpAndSettle();
  return (router, container);
}

Future<void> scan(WidgetTester tester, FakeScanner scanner, String payload) async {
  scanner.scan(payload);
  await tester.pumpAndSettle();
}

Future<void> tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Android's back (title bars have no back button there).
Future<void> goBack(WidgetTester tester) async {
  await tester.binding.handlePopRoute();
  await tester.pumpAndSettle();
}

String account({
  String host = 'imap.example.com',
  String email = 'jane@example.com',
  String password = 'secret',
  int auth = 1,
  int protocol = 0,
  String smtpHost = 'smtp.example.com',
  int security = 3,
}) => tbPayload(
  accounts: [
    tbAccount(
      incoming: tbIncoming(
        protocol: protocol,
        host: host,
        auth: auth,
        username: email,
        name: email,
        password: password,
        security: security,
      ),
      smtpHost: smtpHost,
      smtpAuth: auth,
      identities: [
        [email, 'Jane Doe'],
      ],
    ),
  ],
);

void main() {
  testWidgets('scans one code, adds its account, and finishes in live mode', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    final (_, container) = await pumpImport(tester, repo, scanner);
    expect(find.text('Import from Thunderbird'), findsOneWidget);
    expect(find.text('camera'), findsOneWidget);
    expect(find.textContaining('Tools › Export for Mobile'), findsOneWidget);

    await scan(tester, scanner, account());
    expect(find.text('Found 1 Account'), findsOneWidget);
    expect(find.text('jane@example.com'), findsOneWidget);
    expect(find.text('Example · imap.example.com'), findsOneWidget);
    // The password came with the code.
    expect(find.byKey(const ValueKey('import-password-0')), findsNothing);

    await tapKey(tester, 'import-add');
    expect(repo.log, contains('addAccount jane@example.com'));
    final setup = repo.setups.single;
    expect((setup.credentials as PasswordCredentials).password, 'secret');
    expect(setup.senderName, 'Jane Doe');
    expect(find.text('Added'), findsOneWidget);

    await tapKey(tester, 'import-done');
    expect(find.text('home'), findsOneWidget);
    expect(container.read(appModeProvider), AppMode.live);
  });

  testWidgets('collects a multi-code export in any order, ignoring repeats', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    String part(int i) => tbPayload(
      part: i,
      total: 3,
      accounts: [
        tbAccount(
          incoming: tbIncoming(password: 'pw'),
          identities: [
            ['user$i@example.com', 'User $i'],
          ],
        ),
      ],
    );

    await scan(tester, scanner, part(2));
    expect(find.text('Scanned 1 of 3'), findsOneWidget);
    expect(find.text('1 account so far'), findsOneWidget);
    await scan(tester, scanner, part(2));
    expect(find.text('Scanned 1 of 3'), findsOneWidget);
    await scan(tester, scanner, part(3));
    expect(find.text('Scanned 2 of 3'), findsOneWidget);
    await scan(tester, scanner, part(1));

    expect(find.text('Found 3 Accounts'), findsOneWidget);
    final emails = tester.widgetList<Text>(find.textContaining(RegExp(r'^user\d@'))).map((t) => t.data).toList();
    expect(emails, ['user1@example.com', 'user2@example.com', 'user3@example.com']);
    expect(find.text('Add 3 Accounts'), findsOneWidget);
  });

  testWidgets('continues with some codes, then scans the rest', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, tbPayload(part: 1, total: 2, accounts: [tbAccount()]));
    await tapKey(tester, 'import-continue');
    expect(find.textContaining('Code 2 of 2 wasn’t scanned'), findsOneWidget);

    await tapKey(tester, 'import-scan-more');
    expect(find.text('Scanned 1 of 2'), findsOneWidget);
    // Back from the list returned to the camera; the system back still leaves.
    await goBack(tester);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('says what’s wrong with codes it can’t use', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, 'WIFI:S:home;T:WPA;P:secret;;');
    expect(find.text("This isn't a Thunderbird account code."), findsOneWidget);
    await scan(tester, scanner, specSingleAccount.replaceFirst('[1,', '[2,'));
    expect(find.textContaining('newer Thunderbird'), findsOneWidget);

    // A new export (different number of codes) replaces the old one.
    await scan(tester, scanner, tbPayload(part: 1, total: 3, accounts: [tbAccount()]));
    await scan(tester, scanner, tbPayload(part: 1, total: 2, accounts: [tbAccount()]));
    expect(find.text('Scanned 1 of 2'), findsOneWidget);
    expect(find.textContaining('from a new export'), findsOneWidget);

    await tapKey(tester, 'import-start-over');
    expect(find.text('Point the camera at the QR code Thunderbird shows.'), findsOneWidget);
  });

  testWidgets('pasting the text works without a camera', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner()..problem = ScannerProblem.unavailable;
    await pumpImport(tester, repo, scanner);
    expect(find.text('No Camera'), findsOneWidget);

    await tapKey(tester, 'import-paste');
    await tester.enterText(find.byKey(const Key('import-paste-field')), specSingleAccount);
    await tester.tap(find.byKey(const Key('import-paste-add')));
    await tester.pumpAndSettle();
    expect(find.text('user@domain.example'), findsOneWidget);
  });

  testWidgets('a denied camera offers Settings and restarts on return', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner()..problem = ScannerProblem.permissionDenied;
    var opened = 0;
    await pumpImport(tester, repo, scanner, openSettings: () async => opened++);
    expect(find.text('Camera Access Is Off'), findsOneWidget);

    await tapKey(tester, 'import-open-settings');
    expect(opened, 1);
    final builds = scanner.builds;
    scanner.problem = null;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(scanner.builds, greaterThan(builds));
    expect(find.text('camera'), findsOneWidget);
  });

  testWidgets('asks for a password the export left out', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, account(password: ''));
    expect(find.byKey(const ValueKey('import-password-0')), findsOneWidget);

    await tapKey(tester, 'import-add');
    expect(repo.setups, isEmpty);
    expect(find.text('Enter the password.'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('import-password-0')), 'typed');
    await tapKey(tester, 'import-add');
    expect((repo.setups.single.credentials as PasswordCredentials).password, 'typed');
  });

  testWidgets('shows progress and errors per account, and retries the failed ones', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    final gate = Completer<void>();
    var calls = 0;
    repo.onAddAccount = (setup) async {
      calls++;
      if (calls == 1) await gate.future;
      if (calls == 2) throw const MailException(MailErrorKind.authentication, 'LOGIN failed');
      return MailAccount(
        id: 'id$calls',
        email: setup.email,
        displayName: setup.displayName,
        provider: setup.provider,
        authKind: AuthKind.password,
        incoming: setup.incoming,
      );
    };
    await pumpImport(tester, repo, scanner);
    await scan(
      tester,
      scanner,
      tbPayload(
        accounts: [
          tbAccount(incoming: tbIncoming(password: 'one')),
          tbAccount(
            incoming: tbIncoming(host: 'imap.other.example', password: 'two'),
            identities: [
              ['jane@other.example', 'Jane'],
            ],
          ),
        ],
      ),
    );
    await tester.tap(find.byKey(const Key('import-add')));
    await tester.pump();
    expect(find.text('Adding 1 of 2…'), findsOneWidget);
    gate.complete();
    await tester.pumpAndSettle();

    expect(find.text('Added'), findsOneWidget);
    expect(find.text('Password rejected. Check it and try again.'), findsOneWidget);
    expect(find.text('Add 1 Account'), findsOneWidget);
    expect(find.byKey(const Key('import-finish')), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('import-password-1')), 'better');
    await tapKey(tester, 'import-add');
    expect(find.text('Added'), findsNWidgets(2));
    expect((repo.setups.last.credentials as PasswordCredentials).password, 'better');
    expect(find.byKey(const Key('import-done')), findsOneWidget);
  });

  testWidgets('choosing accounts: unchecked ones are skipped, existing ones start unchecked', (tester) async {
    final repo = FakeMailRepository(accounts: [testAccount]);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(
      tester,
      scanner,
      tbPayload(
        accounts: [
          tbAccount(
            incoming: tbIncoming(password: 'pw'),
            identities: [
              [testAccount.email, 'Me'],
            ],
          ),
          tbAccount(
            incoming: tbIncoming(host: 'imap.a.example', password: 'pw'),
            identities: [
              ['a@a.example', 'A'],
            ],
          ),
          tbAccount(
            incoming: tbIncoming(host: 'imap.b.example', password: 'pw'),
            identities: [
              ['b@b.example', 'B'],
            ],
          ),
        ],
      ),
    );
    expect(find.text('An account with this address is already in Loupe.'), findsOneWidget);
    expect(find.text('Add 2 Accounts'), findsOneWidget);
    await tapKey(tester, 'import-toggle-2');
    expect(find.text('Add 1 Account'), findsOneWidget);
    await tapKey(tester, 'import-add');
    expect(repo.setups.map((s) => s.email), ['a@a.example']);
  });

  testWidgets('OAuth and unsupported accounts explain themselves', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(
      tester,
      scanner,
      tbPayload(
        accounts: [
          tbAccount(
            incoming: tbIncoming(host: 'imap.gmail.com', auth: 6, username: 'jane@gmail.com', name: ''),
            smtpHost: 'smtp.gmail.com',
            smtpAuth: 6,
            identities: [
              ['jane@gmail.com', 'Jane'],
            ],
          ),
          tbAccount(
            incoming: tbIncoming(host: 'outlook.office365.com', auth: 6, username: 'jane@outlook.com'),
            identities: [
              ['jane@outlook.com', 'Jane'],
            ],
          ),
          tbAccount(
            incoming: tbIncoming(protocol: 1, host: 'pop.example.com', port: 995),
            identities: [
              ['pop@example.com', 'Jane'],
            ],
          ),
        ],
      ),
    );
    expect(find.textContaining('“Sign in with Google” arrives in a later build'), findsOneWidget);
    expect(find.text('How to Create an App Password'), findsOneWidget);
    expect(find.text('App Password'), findsOneWidget);
    expect(find.textContaining('Microsoft sign-in arrives in a later build'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('POP3 accounts aren’t supported'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    // Only Gmail can be selected.
    expect(find.text('Add 1 Account'), findsOneWidget);
    await tapKey(tester, 'import-toggle-1');
    expect(find.text('Add 1 Account'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('import-password-0')), 'abcd efgh ijkl mnop');
    await tapKey(tester, 'import-add');
    final setup = repo.setups.single;
    expect(setup.provider, ProviderKind.gmail);
    expect(setup.displayName, 'Gmail');
    expect((setup.credentials as PasswordCredentials).password, 'abcd efgh ijkl mnop');
  });

  testWidgets('accounts without encryption need the usual confirmation', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, account(security: 0));
    expect(find.textContaining('Connects without encryption'), findsOneWidget);

    await tapKey(tester, 'import-add');
    expect(find.text('Connect Without Encryption?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.setups, isEmpty);

    await tapKey(tester, 'import-add');
    await tester.tap(find.text('Use Without Encryption'));
    await tester.pumpAndSettle();
    expect(repo.setups.single.incoming.security, ConnectionSecurity.none);
  });

  testWidgets('offers to trust a self-signed certificate', (tester) async {
    final fp = List.filled(32, 'ab').join(':');
    final repo = FakeMailRepository(accounts: [])
      ..onAddAccount = (setup) async {
        if (setup.incoming.trustedCertificateSha256 == null) {
          throw MailException(MailErrorKind.certificate, 'imap.example.com presented an unknown certificate $fp');
        }
        return testAccount;
      };
    final scanner = FakeScanner();
    await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, account());
    await tapKey(tester, 'import-add');
    expect(find.textContaining("certificate isn't trusted"), findsOneWidget);
    await tapKey(tester, 'import-trust-0');
    expect(repo.setups.last.incoming.trustedCertificateSha256, 'ab' * 32);
    expect(find.text('Added'), findsOneWidget);
  });

  testWidgets('leaving after adding an account finishes like Done', (tester) async {
    final repo = FakeMailRepository(accounts: []);
    final scanner = FakeScanner();
    final (_, container) = await pumpImport(tester, repo, scanner);
    await scan(tester, scanner, account());
    await tapKey(tester, 'import-add');
    await goBack(tester);
    expect(find.text('home'), findsOneWidget);
    expect(container.read(appModeProvider), AppMode.live);
  });

  group('in the app', () {
    Future<DemoMailRepository> pumpApp(WidgetTester tester, FakeScanner scanner, {required AppMode mode}) async {
      tester.view
        ..physicalSize = const Size(390, 844) * 3
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({if (mode != AppMode.none) AppModeController.key: mode.name});
      final prefs = await SharedPreferences.getInstance();
      final repo = DemoMailRepository.instant(clock: () => testNow);
      addTearDown(repo.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            demoRepositoryProvider.overrideWithValue(repo),
            liveRepositoryProvider.overrideWith((ref) async => repo),
            repositoryProvider.overrideWith(repositoryForMode),
            qrScannerProvider.overrideWithValue(scanner.build),
          ],
          child: const LoupeApp(),
        ),
      );
      await tester.pumpAndSettle();
      return repo;
    }

    testWidgets('demo mode: Add Account › Import from Thunderbird adds a demo account', (tester) async {
      final scanner = FakeScanner();
      final repo = await pumpApp(tester, scanner, mode: AppMode.demo);
      final router = ProviderScope.containerOf(tester.element(find.byType(LoupeApp))).read(routerProvider);
      unawaited(router.push(Routes.addAccount));
      await tester.pumpAndSettle();
      await tapKey(tester, 'setup-import-thunderbird');
      await scan(tester, scanner, account(email: 'imported@example.com'));
      await tapKey(tester, 'import-add');
      expect((await repo.watchAccounts().first).map((a) => a.email), contains('imported@example.com'));
      await tapKey(tester, 'import-done');
      expect(find.text('Import from Thunderbird'), findsNothing);
    });

    testWidgets('first launch: the welcome screen imports and switches to live mode', (tester) async {
      final scanner = FakeScanner();
      final repo = await pumpApp(tester, scanner, mode: AppMode.none);
      await tapKey(tester, 'welcome-import');
      expect(find.text('Import from Thunderbird'), findsOneWidget);
      await scan(tester, scanner, account(email: 'first@example.com'));
      await tapKey(tester, 'import-add');
      await tapKey(tester, 'import-done');
      final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
      expect(container.read(appModeProvider), AppMode.live);
      expect((await repo.watchAccounts().first).map((a) => a.email), contains('first@example.com'));
    });
  });
}
