import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('app starts on the mailboxes screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], child: const LoupeApp()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Mailboxes'), findsWidgets);
  });
}
