import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readable/readable.dart';

import '../../settings/app_settings.dart';

/// Per-sender reader preferences: the remembered "Aa" settings and the
/// remote-image allowlist; and the technical mailing lists, read as plain
/// text in Mono by default. Addresses and list ids are stored lower-cased.
@immutable
class ReaderPrefs {
  const ReaderPrefs({this.senderSettings = const {}, this.remoteAllowlist = const {}, this.technicalLists = const {}});

  /// Settings remembered with "Remember for this sender".
  final Map<String, ReaderSettings> senderSettings;

  /// Senders whose remote images always load.
  final Set<String> remoteAllowlist;

  /// The remembered settings for [address], if any.
  ReaderSettings? settingsFor(String? address) => address == null ? null : senderSettings[address.toLowerCase()];

  /// Whether remote content from [address] is always allowed.
  bool allowsRemote(String? address) => address != null && remoteAllowlist.contains(address.toLowerCase());

  /// List-Ids of the lists marked technical (Settings › Reading).
  final Set<String> technicalLists;

  /// The default view of a message of list [listId]: Plain text in Mono
  /// for a technical list, else null (the app's default view applies).
  ReaderSettings? listSettings(String? listId) => listId != null && technicalLists.contains(listId.toLowerCase())
      ? const ReaderSettings(mode: ReaderMode.plain, plainFont: PlainTextFont.mono)
      : null;

  ReaderPrefs _with({
    Map<String, ReaderSettings>? senderSettings,
    Set<String>? remoteAllowlist,
    Set<String>? technicalLists,
  }) => ReaderPrefs(
    senderSettings: senderSettings ?? this.senderSettings,
    remoteAllowlist: remoteAllowlist ?? this.remoteAllowlist,
    technicalLists: technicalLists ?? this.technicalLists,
  );
}

final readerPrefsProvider = NotifierProvider<ReaderPrefsController, ReaderPrefs>(ReaderPrefsController.new);

/// Loads and persists [ReaderPrefs] in SharedPreferences under `reader.*`.
class ReaderPrefsController extends Notifier<ReaderPrefs> {
  static const _sendersKey = 'reader.senders';
  static const _remoteKey = 'reader.remoteAllow';
  static const _technicalKey = 'reader.technicalLists';

  @override
  ReaderPrefs build() {
    final p = ref.watch(sharedPreferencesProvider);
    final senders = <String, ReaderSettings>{};
    final raw = p.getString(_sendersKey);
    if (raw != null) {
      try {
        final map = (jsonDecode(raw) as Map).cast<String, Object?>();
        for (final MapEntry(:key, :value) in map.entries) {
          if (value is Map) senders[key] = _decode(value.cast<String, Object?>());
        }
      } on FormatException {
        // Corrupt value: start over rather than crash the reader.
      }
    }
    return ReaderPrefs(
      senderSettings: senders,
      remoteAllowlist: {...?p.getStringList(_remoteKey)},
      technicalLists: {...?p.getStringList(_technicalKey)},
    );
  }

  /// Remembers [settings] for [address]; null forgets it.
  Future<void> setSenderSettings(String address, ReaderSettings? settings) async {
    final key = address.toLowerCase();
    final next = {...state.senderSettings};
    if (settings == null) {
      next.remove(key);
    } else {
      next[key] = settings;
    }
    state = state._with(senderSettings: next);
    await ref
        .read(sharedPreferencesProvider)
        .setString(_sendersKey, jsonEncode({for (final e in next.entries) e.key: _encode(e.value)}));
  }

  /// Always (or no longer) loads remote content from [address].
  Future<void> setRemoteAllowed(String address, {required bool allowed}) async {
    final key = address.toLowerCase();
    final next = {...state.remoteAllowlist};
    allowed ? next.add(key) : next.remove(key);
    state = state._with(remoteAllowlist: next);
    await ref.read(sharedPreferencesProvider).setStringList(_remoteKey, next.toList()..sort());
  }

  /// Marks list [listId] technical (Plain text in Mono by default) or not.
  Future<void> setTechnicalList(String listId, {required bool technical}) async {
    final key = listId.toLowerCase();
    final next = {...state.technicalLists};
    technical ? next.add(key) : next.remove(key);
    state = state._with(technicalLists: next);
    await ref.read(sharedPreferencesProvider).setStringList(_technicalKey, next.toList()..sort());
  }

  static Map<String, Object?> _encode(ReaderSettings s) => {
    'mode': s.mode.name,
    'plainFont': s.plainFont.name,
    'textScale': s.textScale,
    'keepOriginalColors': s.keepOriginalColors,
  };

  static ReaderSettings _decode(Map<String, Object?> json) {
    const d = ReaderSettings();
    T pick<T extends Enum>(List<T> values, Object? name, T fallback) =>
        values.where((v) => v.name == name).firstOrNull ?? fallback;
    return ReaderSettings(
      mode: pick(ReaderMode.values, json['mode'], d.mode),
      plainFont: pick(PlainTextFont.values, json['plainFont'], d.plainFont),
      textScale: (json['textScale'] as num?)?.toDouble().clamp(0.8, 1.6) ?? d.textScale,
      keepOriginalColors: json['keepOriginalColors'] as bool? ?? d.keepOriginalColors,
    );
  }
}
