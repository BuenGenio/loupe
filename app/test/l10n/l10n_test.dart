import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const supported = [Locale('en'), Locale('de'), Locale('nb'), Locale('pt'), Locale('lb')];

  group('resolveLocale', () {
    test('takes the first device language Loupe speaks', () {
      expect(resolveLocale(const [Locale('ja'), Locale('de', 'AT'), Locale('en')], supported), const Locale('de'));
    });

    test('matches by language alone', () {
      expect(resolveLocale(const [Locale('pt', 'BR')], supported), const Locale('pt'));
    });

    test('reads Norwegian and Nynorsk as Bokmål', () {
      expect(resolveLocale(const [Locale('no')], supported), const Locale('nb'));
      expect(resolveLocale(const [Locale('nn', 'NO')], supported), const Locale('nb'));
    });

    test('falls back to English', () {
      expect(resolveLocale(const [Locale('ja')], supported), const Locale('en'));
      expect(resolveLocale(null, supported), const Locale('en'));
    });
  });

  group('formatLocale', () {
    setUpAll(initializeDateFormatting);

    test("keeps the device's region for its language", () {
      expect(formatLocale(const Locale('en'), const [Locale('en', 'GB')]), 'en_GB');
      expect(formatLocale(const Locale('de'), const [Locale('ja'), Locale('de', 'CH')]), 'de_CH');
    });

    test('uses the language when the device has another one or no region', () {
      expect(formatLocale(const Locale('en'), const [Locale('ja', 'JP')]), 'en');
      expect(formatLocale(const Locale('de'), const [Locale('de')]), 'de');
    });

    test('formats Luxembourgish as German, which intl has data for', () {
      expect(formatLocale(const Locale('lb'), const [Locale('lb', 'LU')]), 'de');
    });
  });

  group('Settings › Language', () {
    tearDown(() => appLanguage = null);

    test('is loaded for text made outside the widget tree', () async {
      SharedPreferences.setMockInitialValues({'settings.language': 'en'});
      expect(AppSettingsController.loadLanguage(await SharedPreferences.getInstance()), 'en');
      expect(appLanguage, 'en');
    });

    test('counts as none for a language Loupe no longer has', () async {
      SharedPreferences.setMockInitialValues({'settings.language': 'tlh'});
      expect(AppSettingsController.loadLanguage(await SharedPreferences.getInstance()), isNull);
      expect(appLanguage, isNull);
    });

    test('names every language Loupe has', () {
      for (final l in AppLocalizations.supportedLocales) {
        expect(languageNames, contains(l.languageCode));
      }
    });
  });

  group('Flutter texts', () {
    Future<String> backTooltip(WidgetTester tester, Locale locale) async {
      late String tooltip;
      await tester.pumpWidget(
        MaterialApp(
          // Loupe's own strings aren't in every language yet.
          localizationsDelegates: [
            for (final d in loupeLocalizationsDelegates)
              if (d.type != AppLocalizations) d,
          ],
          supportedLocales: [locale],
          locale: locale,
          home: Builder(
            builder: (context) {
              tooltip = MaterialLocalizations.of(context).backButtonTooltip;
              CupertinoLocalizations.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      return tooltip;
    }

    testWidgets("are the language's own", (tester) async {
      expect(await backTooltip(tester, const Locale('de')), 'Zurück');
    });

    testWidgets('are English where Flutter has none', (tester) async {
      expect(await backTooltip(tester, const Locale('lb')), 'Back');
      expect(await backTooltip(tester, const Locale('mt')), 'Back');
    });
  });
}
