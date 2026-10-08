/// The app's languages and strings (docs/localisation.md).
///
/// Loupe speaks the device's language when it has it (the first one, in the
/// order the user put them in the system settings), else English. The
/// strings are in `app_<lang>.arb` next to this file.
library;

import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

extension L10nContext on BuildContext {
  /// The strings in the language Loupe shows: `context.l10n.commonCancel`.
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// For MaterialApp: Loupe's strings, Flutter's own (Material, Cupertino and
/// widgets), and English ones for the languages Flutter has none for
/// (Luxembourgish and Maltese), so their screens still have a back button's
/// tooltip and a date picker.
const List<LocalizationsDelegate<dynamic>> loupeLocalizationsDelegates = [
  ...AppLocalizations.localizationsDelegates,
  _EnglishMaterial(),
  _EnglishCupertino(),
  _EnglishWidgets(),
];

/// MaterialApp's localeListResolutionCallback: [resolveLocale], and dates
/// and numbers formatted (intl) for it from then on ([formatLocale]).
Locale loupeLocaleResolution(List<Locale>? preferred, Iterable<Locale> supported) {
  final locale = resolveLocale(preferred, supported);
  Intl.defaultLocale = formatLocale(locale, preferred);
  return locale;
}

/// The first of [preferred] (the device's languages, in order) that Loupe
/// speaks, matched by language alone (Brazilian Portuguese reads Portuguese);
/// else English.
Locale resolveLocale(List<Locale>? preferred, Iterable<Locale> supported) {
  final byLanguage = {for (final l in supported) l.languageCode: l};
  for (final locale in preferred ?? const <Locale>[]) {
    final match = byLanguage[_language(locale)];
    if (match != null) return match;
  }
  return byLanguage['en'] ?? supported.first;
}

String _language(Locale locale) => _aliases[locale.languageCode] ?? locale.languageCode;

/// Codes that devices report for a language Loupe has under another one.
const _aliases = {
  'no': 'nb', // Norwegian: Bokmål
  'nn': 'nb', // Nynorsk readers read Bokmål more easily than English
  'sh': 'sr', // Serbo-Croatian, on old devices
};

/// The intl locale for dates and numbers while Loupe shows [locale]: the
/// device's own for that language when intl knows it, so the region still
/// counts (en_GB has a 24-hour clock, de_CH its own numbers); else the
/// language's; else the closest one intl has (German for Luxembourgish, as in
/// Luxembourg); else English.
String formatLocale(Locale locale, [List<Locale>? preferred]) {
  final device = preferred?.where((l) => _language(l) == locale.languageCode).firstOrNull;
  final candidates = [
    if (device != null && device.countryCode != null) Intl.canonicalizedLocale(device.toLanguageTag()),
    locale.languageCode,
    ?_formatFallback[locale.languageCode],
  ];
  for (final tag in candidates) {
    if (DateFormat.localeExists(tag) && NumberFormat.localeExists(tag)) return tag;
  }
  return 'en';
}

const _formatFallback = {'lb': 'de'};

/// Loupe's strings outside the widget tree (notifications, background
/// work), in the device's language as the app would pick it.
AppLocalizations deviceL10n() =>
    lookupAppLocalizations(resolveLocale(PlatformDispatcher.instance.locales, AppLocalizations.supportedLocales));

const _english = Locale('en');

class _EnglishMaterial extends LocalizationsDelegate<MaterialLocalizations> {
  const _EnglishMaterial();

  @override
  bool isSupported(Locale locale) => !GlobalMaterialLocalizations.delegate.isSupported(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) => GlobalMaterialLocalizations.delegate.load(_english);

  @override
  bool shouldReload(_EnglishMaterial old) => false;
}

class _EnglishCupertino extends LocalizationsDelegate<CupertinoLocalizations> {
  const _EnglishCupertino();

  @override
  bool isSupported(Locale locale) => !GlobalCupertinoLocalizations.delegate.isSupported(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => GlobalCupertinoLocalizations.delegate.load(_english);

  @override
  bool shouldReload(_EnglishCupertino old) => false;
}

class _EnglishWidgets extends LocalizationsDelegate<WidgetsLocalizations> {
  const _EnglishWidgets();

  @override
  bool isSupported(Locale locale) => !GlobalWidgetsLocalizations.delegate.isSupported(locale);

  @override
  Future<WidgetsLocalizations> load(Locale locale) => GlobalWidgetsLocalizations.delegate.load(_english);

  @override
  bool shouldReload(_EnglishWidgets old) => false;
}
