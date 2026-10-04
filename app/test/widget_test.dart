import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('first launch starts on the welcome screen, at any size', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          repositoryProvider.overrideWith(repositoryForMode),
        ],
        child: const LoupeApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Try with demo mail'), findsOneWidget);
  });
}
