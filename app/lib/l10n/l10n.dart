/// The app's languages and strings (docs/localisation.md).
///
/// Loupe speaks the language picked in Settings › Language ([appLanguage]),
/// or else the device's when it has it (the first one, in the order the user
/// put them in the system settings), or else English. The strings are in
/// `app_<lang>.arb` next to this file.
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
/// With a language picked in Settings, [preferred] is only that one; the
/// device's languages still give the region where they match it.
Locale loupeLocaleResolution(List<Locale>? preferred, Iterable<Locale> supported) {
  final locale = resolveLocale(preferred, supported);
  Intl.defaultLocale = formatLocale(locale, [...?preferred, ...PlatformDispatcher.instance.locales]);
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
/// work), in the language the app shows: Settings › Language, else the
/// device's.
AppLocalizations deviceL10n() => lookupAppLocalizations(
  resolveLocale([?_picked, ...PlatformDispatcher.instance.locales], AppLocalizations.supportedLocales),
);

/// The language picked in Settings › Language (a code from
/// [AppLocalizations.supportedLocales]), or null for the device's. The app's
/// settings keep it here, in the background isolates too (see
/// AppSettingsController.loadLanguage), so text made outside the widget tree
/// follows it.
String? appLanguage;

Locale? get _picked => appLanguage == null ? null : Locale(appLanguage!);

/// Each language by its own name, for Settings › Language.
const languageNames = {
  'bg': 'Български',
  'bs': 'Bosanski',
  'ca': 'Català',
  'cs': 'Čeština',
  'cy': 'Cymraeg',
  'da': 'Dansk',
  'de': 'Deutsch',
  'el': 'Ελληνικά',
  'en': 'English',
  'es': 'Español',
  'et': 'Eesti',
  'eu': 'Euskara',
  'fi': 'Suomi',
  'fr': 'Français',
  'ga': 'Gaeilge',
  'gl': 'Galego',
  'hr': 'Hrvatski',
  'hu': 'Magyar',
  'is': 'Íslenska',
  'it': 'Italiano',
  'lb': 'Lëtzebuergesch',
  'lt': 'Lietuvių',
  'lv': 'Latviešu',
  'mk': 'Македонски',
  'mt': 'Malti',
  'nb': 'Norsk bokmål',
  'nl': 'Nederlands',
  'pl': 'Polski',
  'pt': 'Português',
  'ro': 'Română',
  'sk': 'Slovenčina',
  'sl': 'Slovenščina',
  'sq': 'Shqip',
  'sr': 'Српски',
  'sv': 'Svenska',
  'tr': 'Türkçe',
  'uk': 'Українська',
};

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
