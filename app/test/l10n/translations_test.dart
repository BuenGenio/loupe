// The translations (lib/l10n/app_<lang>.arb) against app_en.arb, and the
// language lists Android and iOS show (docs/localisation.md).

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, Object?> _arb(String lang) =>
    jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync())
        as Map<String, Object?>;

/// The languages there are ARB files for, English first.
List<String> _languages() {
  final found = [
    for (final f in Directory('lib/l10n').listSync().whereType<File>())
      if (RegExp(r'app_([a-z]{2,3})\.arb$').firstMatch(f.path) case final m?)
        m[1]!,
  ]..sort();
  return ['en', ...found.where((l) => l != 'en')];
}

/// Languages whose plural category `one` holds other numbers than 1 (21 in
/// Ukrainian, 0 in French): a `one` form there must show the number.
const _oneIsNotJustOne = {
  'bs',
  'fr',
  'hr',
  'is',
  'lt',
  'lv',
  'mk',
  'pt',
  'sl',
  'sr',
  'uk',
};

/// The branches of each plural in [message], as `{variable: {form: text}}`.
Map<String, Map<String, String>> plurals(String message) {
  final result = <String, Map<String, String>>{};
  for (final m in RegExp(r'\{\s*(\w+)\s*,\s*plural\s*,').allMatches(message)) {
    final forms = <String, String>{};
    var i = m.end;
    while (i < message.length) {
      while (i < message.length && message[i] == ' ') {
        i++;
      }
      if (i >= message.length || message[i] == '}') break;
      final open = message.indexOf('{', i);
      if (open < 0) break;
      final form = message.substring(i, open).trim();
      var depth = 0;
      var close = open;
      for (; close < message.length; close++) {
        if (message[close] == '{') depth++;
        if (message[close] == '}' && --depth == 0) break;
      }
      forms[form] = message.substring(open + 1, close);
      i = close + 1;
    }
    result[m[1]!] = forms;
  }
  return result;
}

void main() {
  final en = _arb('en');
  final keys = {
    for (final k in en.keys)
      if (!k.startsWith('@')) k,
  };
  Iterable<String> placeholders(String key) =>
      (((en['@$key'] as Map?)?['placeholders'] as Map?)?.keys ?? const [])
          .cast<String>();

  for (final lang in _languages().skip(1)) {
    group('app_$lang.arb', () {
      final arb = _arb(lang);
      final messages = {
        for (final k in arb.keys)
          if (!k.startsWith('@')) k,
      };

      test('has every string of app_en.arb, and no others', () {
        expect(keys.difference(messages), isEmpty, reason: 'Missing');
        expect(messages.difference(keys), isEmpty, reason: 'Not in app_en.arb');
      });

      test('keeps the placeholders', () {
        final wrong = [
          for (final key in keys.intersection(messages))
            for (final p in placeholders(key))
              if (!RegExp('\\{\\s*$p\\s*[,}]').hasMatch(arb[key]! as String))
                '$key: {$p}',
        ];
        expect(wrong, isEmpty);
      });

      test('has an other form in every plural, and the number where one means more than 1', () {
        final wrong = <String>[];
        for (final key in messages) {
          for (final MapEntry(key: variable, value: forms) in plurals(
            arb[key]! as String,
          ).entries) {
            if (!forms.containsKey('other')) wrong.add('$key: no other');
            final one = forms['one'] ?? forms['=1'];
            if (_oneIsNotJustOne.contains(lang) &&
                one != null &&
                !one.contains('{$variable}')) {
              wrong.add('$key: one without {$variable}');
            }
          }
        }
        expect(wrong, isEmpty);
      });
    });
  }

  test('Android and iOS list the languages there are strings for', () {
    final languages = _languages()..sort();
    final android = File('android/app/src/main/res/xml/locales_config.xml')
        .readAsStringSync();
    expect(
      [
        for (final m in RegExp(r'android:name="([^"]+)"').allMatches(android))
          m[1],
      ]..sort(),
      languages,
    );
    final plist = File('ios/Runner/Info.plist').readAsStringSync();
    final array = RegExp(
      r'<key>CFBundleLocalizations</key>\s*<array>(.*?)</array>',
      dotAll: true,
    ).firstMatch(plist)![1]!;
    expect(
      [
        for (final m in RegExp(r'<string>([^<]+)</string>').allMatches(array))
          m[1],
      ]..sort(),
      languages,
    );
  });

  test('plurals', () {
    expect(plurals('{count, plural, =1{1 message} other{{count} messages}}'), {
      'count': {'=1': '1 message', 'other': '{count} messages'},
    });
    expect(plurals('Hello'), isEmpty);
  });
}
