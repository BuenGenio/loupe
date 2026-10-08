import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';
import 'app_mode.dart';

enum Density { comfortable, compact }

enum SwipeAction { none, toggleRead, toggleFlag, archive, trash, move, snooze, more }

/// What the number on the app icon counts (Settings › Notifications).
enum BadgeCount { off, inboxes, vip }

/// User preferences. Persisted in SharedPreferences under `settings.*`.
@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.density = Density.comfortable,
    this.defaultReaderMode = ReaderMode.readable,
    this.plainFont = PlainTextFont.sans,
    this.loadRemoteImages = false,
    this.swipeLeading = SwipeAction.toggleRead,
    this.swipeTrailing = SwipeAction.archive,
    this.undoSendSeconds = 10,
    this.threaded = true,
    this.appIconBadge = BadgeCount.inboxes,
    this.language,
  });

  final ThemeMode themeMode;
  final Density density;
  final ReaderMode defaultReaderMode;
  final PlainTextFont plainFont;

  /// Default for senders without a per-sender choice.
  final bool loadRemoteImages;
  final SwipeAction swipeLeading;
  final SwipeAction swipeTrailing;

  /// 0 disables undo send.
  final int undoSendSeconds;

  /// Group the message list by conversation.
  final bool threaded;

  /// The count on the app icon, like Apple Mail's Badge App Icon.
  final BadgeCount appIconBadge;

  /// The language Loupe shows (Settings › Language), as a language code; null
  /// for the phone's.
  final String? language;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Density? density,
    ReaderMode? defaultReaderMode,
    PlainTextFont? plainFont,
    bool? loadRemoteImages,
    SwipeAction? swipeLeading,
    SwipeAction? swipeTrailing,
    int? undoSendSeconds,
    bool? threaded,
    BadgeCount? appIconBadge,
    Object? language = _unchanged,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    density: density ?? this.density,
    defaultReaderMode: defaultReaderMode ?? this.defaultReaderMode,
    plainFont: plainFont ?? this.plainFont,
    loadRemoteImages: loadRemoteImages ?? this.loadRemoteImages,
    swipeLeading: swipeLeading ?? this.swipeLeading,
    swipeTrailing: swipeTrailing ?? this.swipeTrailing,
    undoSendSeconds: undoSendSeconds ?? this.undoSendSeconds,
    threaded: threaded ?? this.threaded,
    appIconBadge: appIconBadge ?? this.appIconBadge,
    language: identical(language, _unchanged) ? this.language : language as String?,
  );

  /// copyWith's default for [language], which null would set.
  static const _unchanged = Object();
}

/// Overridden in main() with the loaded instance (and in tests with a mock).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final appSettingsProvider = NotifierProvider<AppSettingsController, AppSettings>(AppSettingsController.new);

class AppSettingsController extends Notifier<AppSettings> {
  static const _prefix = 'settings.';
  static const _languageKey = '${_prefix}language';

  /// Settings › Language for text made outside the widget tree ([appLanguage]):
  /// the app's settings do it, and background isolates call this when they
  /// start. A language Loupe no longer has counts as none.
  static String? loadLanguage(SharedPreferences prefs) {
    final code = prefs.getString(_languageKey);
    return appLanguage = AppLocalizations.supportedLocales.any((l) => l.languageCode == code) ? code : null;
  }

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() {
    ref.watch(prefsEpochProvider);
    final p = ref.watch(sharedPreferencesProvider);
    T pick<T extends Enum>(List<T> values, String key, T fallback) {
      final name = p.getString('$_prefix$key');
      return values.where((v) => v.name == name).firstOrNull ?? fallback;
    }

    const d = AppSettings();
    return AppSettings(
      themeMode: pick(ThemeMode.values, 'themeMode', d.themeMode),
      density: pick(Density.values, 'density', d.density),
      defaultReaderMode: pick(ReaderMode.values, 'defaultReaderMode', d.defaultReaderMode),
      plainFont: pick(PlainTextFont.values, 'plainFont', d.plainFont),
      loadRemoteImages: p.getBool('${_prefix}loadRemoteImages') ?? d.loadRemoteImages,
      swipeLeading: pick(SwipeAction.values, 'swipeLeading', d.swipeLeading),
      swipeTrailing: pick(SwipeAction.values, 'swipeTrailing', d.swipeTrailing),
      undoSendSeconds: p.getInt('${_prefix}undoSendSeconds') ?? d.undoSendSeconds,
      threaded: p.getBool('${_prefix}threaded') ?? d.threaded,
      appIconBadge: pick(BadgeCount.values, 'appIconBadge', d.appIconBadge),
      language: loadLanguage(p),
    );
  }

  Future<void> update(AppSettings Function(AppSettings current) change) async {
    final next = change(state);
    state = next;
    appLanguage = next.language;
    await Future.wait([
      _prefs.setString('${_prefix}themeMode', next.themeMode.name),
      _prefs.setString('${_prefix}density', next.density.name),
      _prefs.setString('${_prefix}defaultReaderMode', next.defaultReaderMode.name),
      _prefs.setString('${_prefix}plainFont', next.plainFont.name),
      _prefs.setBool('${_prefix}loadRemoteImages', next.loadRemoteImages),
      _prefs.setString('${_prefix}swipeLeading', next.swipeLeading.name),
      _prefs.setString('${_prefix}swipeTrailing', next.swipeTrailing.name),
      _prefs.setInt('${_prefix}undoSendSeconds', next.undoSendSeconds),
      _prefs.setBool('${_prefix}threaded', next.threaded),
      _prefs.setString('${_prefix}appIconBadge', next.appIconBadge.name),
      if (next.language case final code?) _prefs.setString(_languageKey, code) else _prefs.remove(_languageKey),
    ]);
  }
}
