// Translated text is longer than English (German by a third, and more in
// places), so a row that just fits in English can overflow in another
// language. This opens the screens with the most text in the languages whose
// text grows the most, on a small phone, and fails on an overflow.
//
// A failure here is a layout to fix, not a translation: let the text wrap or
// ellipsize, or give the row more room.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/router.dart';

import '../helpers.dart';

/// The screens with the most text, and the narrowest ones.
const _routes = <String, String>{
  'Mailboxes': Routes.mailboxes,
  'Settings': Routes.settings,
  'Swipe actions': Routes.swipeSettings,
  'Notifications': Routes.notificationSettings,
  'Advanced': Routes.advancedSettings,
  'Encryption': Routes.encryption,
  'Rules': Routes.rules,
  'Subscriptions': Routes.subscriptions,
  'Compose': Routes.compose,
  'Outbox': Routes.outbox,
  'Snoozed': Routes.snoozed,
};

/// A small phone: 4.7", which is as narrow as Android gets in practice.
const _small = Size(360, 640);

/// How much longer than English each language's text is, and which languages
/// grow the most. Measured, not guessed: the translations change.
({List<String> worst, Map<String, double> ratios}) _expansion({int take = 4}) {
  final en = _arb('en');
  final ratios = <String, double>{};
  for (final file in Directory('lib/l10n').listSync().whereType<File>()) {
    final match = RegExp(r'app_([a-z]{2,3})\.arb$').firstMatch(file.path);
    if (match == null || match[1] == 'en') continue;
    final arb = _arb(match[1]!);
    final shared = en.keys.where(arb.containsKey);
    if (shared.isEmpty) continue;
    final english = shared.fold(0, (sum, k) => sum + en[k]!.length);
    final other = shared.fold(0, (sum, k) => sum + arb[k]!.length);
    ratios[match[1]!] = other / english;
  }
  final worst = ratios.keys.toList()..sort((a, b) => ratios[b]!.compareTo(ratios[a]!));
  return (worst: worst.take(take).toList(), ratios: ratios);
}

Map<String, String> _arb(String lang) {
  final json = jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map<String, Object?>;
  return {
    for (final MapEntry(:key, :value) in json.entries)
      if (!key.startsWith('@') && value is String) key: value,
  };
}

void main() {
  final expansion = _expansion();
  // English too: a layout that overflows for everyone should say so here.
  final languages = ['en', ...expansion.worst];

  for (final lang in languages) {
    group('$lang (text ${(expansion.ratios[lang] ?? 1).toStringAsFixed(2)}× English)', () {
      for (final MapEntry(key: name, value: route) in _routes.entries) {
        testWidgets('$name fits a small phone', (tester) async {
          await pumpLoupe(tester, size: _small, prefs: {if (lang != 'en') 'settings.language': lang});
          addTearDown(() => appLanguage = null);
          if (route != Routes.mailboxes) await goTo(tester, route);
          // pumpLoupe's pumpAndSettle would have thrown already; this is the
          // same check with a clearer reason.
          expect(tester.takeException(), isNull, reason: '$name overflows in $lang');
        });
      }
    });
  }
}
