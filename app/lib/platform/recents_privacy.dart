import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether Android's Recent Apps shows a screenshot of Loupe. App Lock turns
/// it off, so the switcher (and the preview Android shows while Loupe comes
/// back) is a blank card instead of mail. Screenshots inside the app are
/// still allowed: this isn't FLAG_SECURE.
abstract interface class RecentsPrivacy {
  /// Hides Loupe's content in Recent Apps, or shows it again. Never throws.
  Future<void> hideContent(bool hide);
}

/// Android 13 and later (`Activity.setRecentsScreenshotEnabled`), through the
/// app's `io.github.buengenio.loupe/recents` channel (`RecentsChannel.kt`).
/// Earlier Android versions and other platforms keep the screenshot.
final class ChannelRecentsPrivacy implements RecentsPrivacy {
  const ChannelRecentsPrivacy();

  static const channelName = 'io.github.buengenio.loupe/recents';
  static const _channel = MethodChannel(channelName);

  @override
  Future<void> hideContent(bool hide) async {
    try {
      await _channel.invokeMethod<bool>('setRecentsScreenshotEnabled', {'enabled': !hide});
    } on MissingPluginException {
      // Not Android: nothing to do.
    } on PlatformException catch (e) {
      debugPrint('Recent Apps screenshot: ${e.code}');
    }
  }
}

/// Overridden in tests.
final recentsPrivacyProvider = Provider<RecentsPrivacy>((ref) => const ChannelRecentsPrivacy());
