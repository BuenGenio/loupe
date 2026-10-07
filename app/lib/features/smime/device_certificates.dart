/// S/MIME certificates installed on the device (by a company's device
/// management, or by the user in Android's settings): picked from Android's
/// KeyChain and used through it. Their private keys never leave the
/// platform; Loupe asks it for signatures, content keys and ECDH secrets
/// ([SmimePlatformKey], [SmimeKeyRequest]). The Android side is
/// `android/app/src/main/kotlin/…/KeyChainChannel.kt`.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_crypto/mail_crypto.dart';

/// The device's certificate store.
abstract interface class DeviceCertificates implements SmimePlatformKeys {
  /// Whether this platform offers its certificates to Loupe.
  bool get supported;

  /// Lets the user pick a certificate with its private key (the system's
  /// own dialog, which can also install one); its alias, or null when they
  /// cancelled. Picking it grants Loupe the use of its key.
  Future<String?> choose({String? alias});

  /// The certificate of [alias] and its issuers (DER), the certificate first.
  /// Throws [SmimeException] ([SmimeErrorKind.locked]) when it is gone.
  Future<List<Uint8List>> chain(String alias);
}

/// Android's KeyChain, through the app's `io.github.buengenio.loupe/keychain` channel.
///
/// Only the app's own engine has the channel: background work (WorkManager,
/// Instant Delivery) can't use these keys, so signed mail is signed when
/// it is queued, while the user is there (`LiveMailRepository.send`).
final class KeyChainCertificates implements DeviceCertificates {
  KeyChainCertificates({MethodChannel? channel}) : _channel = channel ?? const MethodChannel(channelName);

  static const channelName = 'io.github.buengenio.loupe/keychain';

  final MethodChannel _channel;

  @override
  bool get supported => true;

  @override
  Future<String?> choose({String? alias}) => _call(() => _channel.invokeMethod<String>('choose', {'alias': alias}));

  @override
  Future<List<Uint8List>> chain(String alias) async {
    final list = await _call(() => _channel.invokeListMethod<Uint8List>('chain', {'alias': alias}));
    if (list == null || list.isEmpty) throw _unavailable;
    return list;
  }

  @override
  Future<Uint8List> perform(SmimeKeyRequest request) async {
    final out = await _call(
      () => _channel.invokeMethod<Uint8List>('perform', {
        'alias': request.alias,
        'operation': request.operation.name,
        'input': request.input,
        'keyType': request.keyType.name,
        'digest': request.digest,
        'mgfDigest': request.mgfDigest,
      }),
    );
    if (out == null) throw _unavailable;
    return out;
  }

  static const _unavailable = SmimeException(
    SmimeErrorKind.locked,
    'The certificate isn’t on this device anymore, or Loupe may no longer use it. Choose it again in '
    'Settings › End-to-End Encryption.',
  );

  /// Platform errors as [SmimeException]s, worded for the UI.
  static Future<T> _call<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on MissingPluginException {
      throw const SmimeException(
        SmimeErrorKind.locked,
        'The certificate on this device can only be used while Loupe is open.',
      );
    } on PlatformException catch (e) {
      throw switch (e.code) {
        'unavailable' => _unavailable,
        'badPadding' => const SmimeException(SmimeErrorKind.malformed, 'The encrypted key is damaged.'),
        'unsupported' => SmimeException(
          SmimeErrorKind.unsupported,
          'The certificate on this device can’t do this: ${e.message ?? 'not supported'}.',
        ),
        _ => SmimeException(SmimeErrorKind.failed, 'The certificate on this device failed: ${e.message ?? e.code}.'),
      };
    }
  }
}

/// No certificates from the platform (iOS, desktop, tests).
///
/// TODO(ios): managed certificates on iOS. An app can't read the system's
/// configuration-profile identities; it needs a device management (MDM)
/// profile that installs the identity into a keychain access group shared
/// with Loupe (`com.apple.security.application-groups` / keychain-access-groups
/// entitlement), then `SecItemCopyMatching` (kSecClassIdentity) to find it and
/// `SecKeyCreateSignature` / `SecKeyCreateDecryptedData` /
/// `SecKeyCopyKeyExchangeResult` for the operations, behind this same
/// interface. See docs/ios.md.
final class NoDeviceCertificates implements DeviceCertificates {
  const NoDeviceCertificates();

  @override
  bool get supported => false;

  @override
  Future<String?> choose({String? alias}) async => null;

  @override
  Future<List<Uint8List>> chain(String alias) => throw KeyChainCertificates._unavailable;

  @override
  Future<Uint8List> perform(SmimeKeyRequest request) => throw KeyChainCertificates._unavailable;
}

/// The device's certificates: Android's KeyChain, nothing elsewhere. Tests override it.
final deviceCertificatesProvider = Provider<DeviceCertificates>(
  (ref) => !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? KeyChainCertificates()
      : const NoDeviceCertificates(),
);
