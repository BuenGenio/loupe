import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

/// What came of asking the user to prove it's them.
enum AuthResult {
  success,

  /// They closed the prompt, or the system did (Loupe went to the
  /// background).
  cancelled,

  /// The prompt ended without recognising them.
  failed,

  /// Too many attempts; the phone makes them wait.
  lockedOut,

  /// The phone has no screen lock and no fingerprint or face to check.
  unavailable,

  /// The prompt couldn't be shown.
  error,
}

/// The phone's own check of who is holding it: fingerprint or face, or the
/// screen lock's PIN, pattern or password. Behind an interface so tests can
/// answer for the system prompt.
abstract interface class DeviceAuthenticator {
  /// Whether there is anything to check against: an enrolled fingerprint or
  /// face, or a screen lock.
  Future<bool> isAvailable();

  /// Shows the system prompt with [title], and [reason] below it. Never
  /// throws.
  Future<AuthResult> authenticate({required String title, required String reason});
}

/// [DeviceAuthenticator] on `local_auth`: Android's BiometricPrompt (which
/// needs MainActivity to be a FlutterFragmentActivity), iOS's
/// LocalAuthentication. Biometrics or the screen lock, whichever the user
/// picks in the prompt.
final class LocalAuthAuthenticator implements DeviceAuthenticator {
  LocalAuthAuthenticator([LocalAuthentication? auth]) : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  @override
  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } on Object catch (e) {
      // No plugin on this platform, or the platform failed to answer.
      debugPrint('Device authentication unavailable: ${e.runtimeType}');
      return false;
    }
  }

  @override
  Future<AuthResult> authenticate({required String title, required String reason}) async {
    try {
      return await _prompt(title, reason);
    } on LocalAuthException catch (e) {
      if (e.code != LocalAuthExceptionCode.authInProgress) return _result(e.code);
      // A prompt of ours that never ended (Android drops one asked for at
      // the wrong moment, and the plugin waits for it forever): end it and
      // ask again.
      try {
        await _auth.stopAuthentication();
        return await _prompt(title, reason);
      } on LocalAuthException catch (e) {
        return _result(e.code);
      } on Object catch (e) {
        debugPrint('Authentication failed: ${e.runtimeType}');
        return AuthResult.error;
      }
    } on Object catch (e) {
      debugPrint('Authentication failed: ${e.runtimeType}');
      return AuthResult.error;
    }
  }

  Future<AuthResult> _prompt(String title, String reason) async {
    final ok = await _auth.authenticate(
      localizedReason: reason,
      // The PIN, pattern or password too, not only biometrics.
      biometricOnly: false,
      // No extra "Confirm" tap after a face is recognised.
      sensitiveTransaction: false,
      // An empty hint hides Android's "Verify identity" line under the title.
      authMessages: [AndroidAuthMessages(signInTitle: title, signInHint: '')],
    );
    return ok ? AuthResult.success : AuthResult.failed;
  }

  static AuthResult _result(LocalAuthExceptionCode code) => switch (code) {
    LocalAuthExceptionCode.userCanceled ||
    LocalAuthExceptionCode.systemCanceled ||
    LocalAuthExceptionCode.timeout ||
    LocalAuthExceptionCode.userRequestedFallback ||
    LocalAuthExceptionCode.authInProgress => AuthResult.cancelled,
    // With the screen lock allowed, these only come when there's no screen
    // lock either.
    LocalAuthExceptionCode.noCredentialsSet ||
    LocalAuthExceptionCode.noBiometricsEnrolled ||
    LocalAuthExceptionCode.noBiometricHardware => AuthResult.unavailable,
    LocalAuthExceptionCode.temporaryLockout || LocalAuthExceptionCode.biometricLockout => AuthResult.lockedOut,
    _ => AuthResult.error,
  };
}

/// Overridden in tests.
final deviceAuthenticatorProvider = Provider<DeviceAuthenticator>((ref) => LocalAuthAuthenticator());

/// Opens Android's screen lock settings (choose a PIN, pattern or password),
/// for "Set Up a Screen Lock". Tests replace it.
final openScreenLockSettingsProvider = Provider<Future<void> Function()>(
  (ref) =>
      () => AppSettings.openAppSettings(type: AppSettingsType.lockAndPassword),
);
