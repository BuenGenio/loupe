/// Writing S/MIME mail (RFC 8551) around any [MessageComposer]: signed
/// as `multipart/signed` with a detached signature carrying the signer's
/// certificates, encrypted as `application/pkcs7-mime` (signed first,
/// then encrypted, as Thunderbird does).
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import '../mime/split.dart';
import '../pgp_mime/writer.dart' show draftSecurityHeader;
import 'backend.dart';
import 'certificate.dart';
import 'cms.dart' show SmimeContentCipher;
import 'plan.dart';
import 'primitives.dart' show SmimePrivateKey;
import 'store.dart';

/// What the composer needs at send time, synchronously: the certificate
/// store and the private keys.
abstract interface class SmimeSendKeys {
  SmimeState get smimeState;

  /// The private key of the user's certificate [fingerprint], or null when it isn't loaded.
  SmimePrivateKey? smimeKey(String fingerprint);
}

/// Wraps [inner]'s output in S/MIME when [OutgoingSecurity.technology] is
/// S/MIME; hands everything else to [inner] unchanged.
///
/// Throws [MailException] when it can't do what is asked (no certificate,
/// a recipient without a usable one): it never sends in the clear instead.
final class SmimeMessageComposer implements MessageComposer {
  SmimeMessageComposer(this.inner, this.keys, {required this.backend, Random? random, DateTime Function()? clock})
    : _random = random ?? Random.secure(),
      _clock = clock ?? DateTime.now;

  final MessageComposer inner;
  final SmimeSendKeys keys;
  final SmimeBackend backend;
  final Random _random;
  final DateTime Function() _clock;

  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) {
    final security = message.security;
    if (!security.isSmime) return inner.compose(message, from, messageId: messageId, date: date);
    final plain = inner.compose(
      message.copyWith(security: OutgoingSecurity.none),
      from,
      messageId: messageId,
      date: date,
    );
    final split = SplitMessage.parse(plain);
    final now = _clock();
    final recipients = {
      for (final a in [...message.to, ...message.cc, ...message.bcc]) a.email.trim().toLowerCase(),
    };
    final plan = planSmime(
      keys.smimeState,
      from: from.email,
      recipients: recipients,
      now: now,
      signedBy: backend.certificateSignedBy,
    );
    final own = plan.own;
    if (security.draft) return _draft(split, security, own);
    if (security.isPlain) return plain;
    if (own == null) {
      throw MailException(
        MailErrorKind.unsupported,
        'There is no valid S/MIME certificate for ${from.email}. Add one in Settings › End-to-End Encryption.',
      );
    }

    var content = split.content;
    if (security.sign) {
      final key = keys.smimeKey(own.fingerprint);
      if (key == null) {
        throw const MailException(
          MailErrorKind.unsupported,
          'The private key of your S/MIME certificate isn’t available.',
        );
      }
      final SmimeSignature signature;
      try {
        signature = backend.sign(
          content,
          SmimeKeyPair(own.certificate, key),
          chain: own.chain,
          // The signing time is the message's date, as readers compare them.
          now: date ?? now,
          encryptionCertificate: own.certificate.canEncrypt ? own.certificate : null,
        );
      } on SmimeException catch (e) {
        throw MailException(MailErrorKind.unsupported, 'Signing failed: ${e.message}', e);
      }
      content = _signed(content, signature);
    }

    if (security.encrypt) {
      if (plan.missing.isNotEmpty) {
        throw MailException(
          MailErrorKind.unsupported,
          'Can’t encrypt: there is no valid S/MIME certificate for ${plan.missing.join(', ')}.',
        );
      }
      if (!own.certificate.canEncrypt) {
        throw const MailException(
          MailErrorKind.unsupported,
          'Can’t encrypt: your S/MIME certificate is for signing only, so you couldn’t read the message yourself.',
        );
      }
      return _encrypted(split, content, plan.recipientCertificates, plan.cipher);
    }
    return split.withContent(content, const []);
  }

  /// A draft: encrypted (when asked) to the sender only, never signed, the choices kept in a header.
  Uint8List _draft(SplitMessage split, OutgoingSecurity security, SmimeOwnCertificate? own) {
    final choices = ['smime', if (security.encrypt) 'encrypt', if (security.sign) 'sign'];
    final extra = ['$draftSecurityHeader: ${choices.join('; ')}'];
    if (!security.encrypt || own == null || !own.certificate.canEncrypt) return split.withHeaders(extra);
    return _encrypted(split, split.content, [own.certificate], SmimeContentCipher.aes256Cbc, extra: extra);
  }

  /// `multipart/signed` around [content], the detached signature as `smime.p7s`.
  Uint8List _signed(Uint8List content, SmimeSignature signature) {
    final boundary = _boundary();
    final out = BytesBuilder(copy: false)
      ..add(ascii.encode('This is a cryptographically signed message in MIME format.\r\n\r\n--$boundary\r\n'))
      ..add(content)
      ..add(
        ascii.encode(
          '\r\n--$boundary\r\n'
          'Content-Type: application/pkcs7-signature; name="smime.p7s"\r\n'
          'Content-Transfer-Encoding: base64\r\n'
          'Content-Disposition: attachment; filename="smime.p7s"\r\n'
          'Content-Description: S/MIME Cryptographic Signature\r\n\r\n'
          '${_base64Lines(signature.data)}'
          '\r\n--$boundary--\r\n',
        ),
      );
    return assembleEntity([
      'Content-Type: multipart/signed; protocol="application/pkcs7-signature";\r\n'
          ' micalg=${signature.micalg}; boundary="$boundary"',
    ], out.takeBytes());
  }

  Uint8List _encrypted(
    SplitMessage split,
    Uint8List content,
    List<SmimeCertificate> recipients,
    SmimeContentCipher cipher, {
    List<String> extra = const [],
  }) {
    final Uint8List envelope;
    try {
      envelope = backend.encrypt(content, recipients, cipher: cipher);
    } on SmimeException catch (e) {
      throw MailException(MailErrorKind.unsupported, 'Encryption failed: ${e.message}', e);
    }
    final type = cipher == SmimeContentCipher.aes256Gcm ? 'authEnveloped-data' : 'enveloped-data';
    return assembleEntity([
      ...split.outer,
      'MIME-Version: 1.0',
      ...extra,
      'Content-Type: application/pkcs7-mime; smime-type=$type; name="smime.p7m"',
      'Content-Transfer-Encoding: base64',
      'Content-Disposition: attachment; filename="smime.p7m"',
      'Content-Description: S/MIME Encrypted Message',
    ], ascii.encode(_base64Lines(envelope)));
  }

  static String _base64Lines(Uint8List data) {
    final b64 = base64.encode(data);
    final lines = [for (var i = 0; i < b64.length; i += 76) b64.substring(i, min(i + 76, b64.length))];
    return lines.join('\r\n');
  }

  String _boundary() =>
      '------------ms${List.generate(24, (_) => 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'[_random.nextInt(62)]).join()}';
}
