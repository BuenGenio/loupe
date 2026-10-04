import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/live.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

void main() {
  /// The app in live mode, where opening the database fails with [errors]
  /// one after the other (then succeeds with a demo repository).
  Future<({List<String> resets, ProviderContainer container})> pumpFailing(
    WidgetTester tester,
    List<Object> errors,
  ) async {
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({AppModeController.key: AppMode.live.name});
    final prefs = await SharedPreferences.getInstance();
    final repo = DemoMailRepository.instant(clock: () => testNow);
    addTearDown(repo.dispose);
    final resets = <String>[];
    var attempt = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          demoRepositoryProvider.overrideWithValue(repo),
          liveRepositoryProvider.overrideWith((ref) async {
            if (attempt < errors.length) throw errors[attempt++];
            return repo;
          }),
          repositoryProvider.overrideWith(repositoryForMode),
          localMailDataResetProvider.overrideWithValue(() async => resets.add('reset')),
        ],
        child: const LoupeApp(),
      ),
    );
    await tester.pumpAndSettle();
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    return (resets: resets, container: container);
  }

  testWidgets('a keychain that fails to read offers Try Again, which recovers', (tester) async {
    // Retried twice on its own first.
    final (:resets, :container) = await pumpFailing(tester, [
      for (var i = 0; i < 3; i++) DatabaseKeyUnavailable(cause: Exception('KeyStoreException')),
    ]);
    expect(find.text('Your accounts couldn’t be opened'), findsOneWidget);
    expect(textContaining('often temporary'), findsOneWidget);
    expect(textContaining('KeyStoreException'), findsNothing, reason: 'no exception details on screen');

    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();
    expect(find.text('Your accounts couldn’t be opened'), findsNothing);
    expect(container.read(appModeProvider), AppMode.live);
    expect(resets, isEmpty);
  });

  testWidgets('Try Again that fails again keeps the buttons working', (tester) async {
    const missing = DatabaseKeyUnavailable(missing: true);
    await pumpFailing(tester, [missing, missing]);
    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();
    expect(textContaining('restoring a backup'), findsOneWidget);
    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();
    expect(find.text('Your accounts couldn’t be opened'), findsNothing);
  });

  testWidgets('reset deletes nothing until confirmed, then starts over', (tester) async {
    final (:resets, :container) = await pumpFailing(tester, [const DatabaseKeyUnavailable(missing: true)]);
    await tester.tap(find.text('Reset Mail on This Phone…'));
    await tester.pumpAndSettle();
    expect(resets, isEmpty);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Try Again'), findsOneWidget);

    await tester.tap(find.text('Reset Mail on This Phone…'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete and Start Over'));
    await tester.pumpAndSettle();
    expect(resets, ['reset']);
    expect(container.read(appModeProvider), AppMode.none);
    expect(find.text('Your accounts couldn’t be opened'), findsNothing);
    // Setting up an account opens a new database.
    expect(await container.read(liveRepositoryProvider.future), isA<MailRepository>());
  });
}
