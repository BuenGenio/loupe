/// Writing OpenPGP mail: RFC 3156 PGP/MIME around any [MessageComposer],
/// with protected headers, Autocrypt and Autocrypt-Gossip, as Thunderbird
/// writes it.
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import '../autocrypt.dart';
import '../keyring/keyring.dart';
import '../keyring/plan.dart';
import '../mime/split.dart';
import '../pgp/types.dart';

/// What the composer needs at send time, synchronously: the keyring and
/// the unlocked secret keys.
abstract interface class PgpSendKeys {
  KeyringState get state;

  /// The unlocked secret key of [fingerprint], or null when it is locked.
  PgpKey? unlockedKey(String fingerprint);
}

/// The header that keeps a draft's choices: `encrypt; sign; attach-key`,
/// and `smime` for S/MIME.
const draftSecurityHeader = 'X-Loupe-Security';

/// The choices stored in a draft's [draftSecurityHeader], or null.
OutgoingSecurity? draftSecurityFrom(List<(String, String)> headers) {
  for (final (k, v) in headers) {
    if (k.toLowerCase() != draftSecurityHeader.toLowerCase()) continue;
    final words = {for (final w in v.split(';')) w.trim().toLowerCase()};
    return OutgoingSecurity(
      encrypt: words.contains('encrypt'),
      sign: words.contains('sign'),
      attachPublicKey: words.contains('attach-key'),
      technology: words.contains('smime') ? SecurityTechnology.smime : SecurityTechnology.openPgp,
    );
  }
  return null;
}

/// Wraps [inner]'s output: encrypts (`multipart/encrypted`, the real
/// subject protected inside, `...` outside), signs (`multipart/signed`),
/// attaches the public key, and adds the `Autocrypt` header whenever the
/// sender has a key. A plain message without a key passes through as is.
///
/// Throws [MailException] when it can't do what [OutgoingMessage.security]
/// asks (no key for a recipient, the sender's key is locked): it never
/// sends in the clear instead.
final class PgpMessageComposer implements MessageComposer {
  PgpMessageComposer(this.inner, this.keys, {required this.backend, Random? random, DateTime Function()? clock})
    : _random = random ?? Random.secure(),
      _clock = clock ?? DateTime.now;

  final MessageComposer inner;
  final PgpSendKeys keys;
  final PgpBackend backend;
  final Random _random;
  final DateTime Function() _clock;

  /// The outer subject of encrypted mail, as Thunderbird writes it.
  static const hiddenSubject = '...';

  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) {
    // S/MIME is another composer's job (SmimeMessageComposer, around this one).
    if (message.security.isSmime && !message.security.isPlain) {
      throw const MailException(
        MailErrorKind.unsupported,
        'This message is to be protected with S/MIME, which isn’t available.',
      );
    }
    final plain = inner.compose(
      message.copyWith(security: OutgoingSecurity.none),
      from,
      messageId: messageId,
      date: date,
    );
    final security = message.security;
    final state = keys.state;
    final settings = state.identity(from.email);
    final now = _clock();
    final chosen = state.ownKeyFor(from.email, now: now);
    final own = chosen != null && chosen.isValidAt(now) ? chosen : null;
    final split = SplitMessage.parse(plain);

    if (security.draft) return _draft(split, security, own);

    final extra = <String>[];
    if (own != null && settings.autocrypt) {
      try {
        final minimal = backend.minimalKey(own, from.email);
        extra.add(
          'Autocrypt: ${AutocryptHeader(addr: from.email.trim().toLowerCase(), keydata: minimal.data, preferMutual: settings.preferEncrypt).toValue()}',
        );
      } on PgpException {
        // A key that can't be minimised just isn't advertised.
      }
    }
    if (security.isPlain) return split.withHeaders(extra);
    if (own == null) {
      throw MailException(
        MailErrorKind.unsupported,
        'There is no OpenPGP key for ${from.email}. Add one in Settings › End-to-End Encryption.',
      );
    }

    var content = split.content;
    if (security.attachPublicKey) content = _withKey(content, own);

    if (security.encrypt) {
      // A Bcc recipient's copy names only their key (OutgoingMessage.deliveries).
      final recipients = {for (final a in message.encryptionRecipients) a.email.trim().toLowerCase()};
      final plan = planEncryption(state, from: from.email, recipients: recipients, now: now);
      if (plan.missing.isNotEmpty) {
        throw MailException(
          MailErrorKind.unsupported,
          'Can’t encrypt: there is no OpenPGP key for ${plan.missing.join(', ')}.',
        );
      }
      final signer = security.sign ? _signer(own) : null;
      final gossip = recipients.length > 1
          ? [
              for (final MapEntry(:key, :value) in plan.keys.entries)
                if (value != null) _gossip(key, value.key),
            ]
          : const <String>[];
      final protectedPart = _protect(content, split, gossip);
      final String armored;
      try {
        armored = backend.encrypt(protectedPart, recipients: plan.recipientKeys, signer: signer, now: now);
      } on PgpException catch (e) {
        throw MailException(MailErrorKind.unsupported, 'Encryption failed: ${e.message}', e);
      }
      return _encrypted(split, armored, extra);
    }

    if (security.sign) {
      final signer = _signer(own);
      final PgpDetachedSignature signature;
      try {
        signature = backend.signDetached(content, signer, now: now);
      } on PgpException catch (e) {
        throw MailException(MailErrorKind.unsupported, 'Signing failed: ${e.message}', e);
      }
      return _signed(split, content, signature, extra);
    }

    // Only the key attached.
    return split.withContent(content, extra);
  }

  PgpKey _signer(PgpKey own) {
    final unlocked = keys.unlockedKey(own.fingerprint);
    if (unlocked == null) {
      throw const MailException(
        MailErrorKind.unsupported,
        'Your OpenPGP key is locked. Unlock it in Settings › End-to-End Encryption, then send again.',
      );
    }
    return unlocked;
  }

  /// A draft: encrypted to the sender only, never signed, choices kept in a header.
  Uint8List _draft(SplitMessage split, OutgoingSecurity security, PgpKey? own) {
    final choices = [
      if (security.encrypt) 'encrypt',
      if (security.sign) 'sign',
      if (security.attachPublicKey) 'attach-key',
    ];
    final extra = ['$draftSecurityHeader: ${choices.isEmpty ? 'none' : choices.join('; ')}'];
    if (!security.encrypt || own == null) return split.withHeaders(extra);
    final String armored;
    try {
      armored = backend.encrypt(_protect(split.content, split, const []), recipients: [own], now: _clock());
    } on PgpException catch (e) {
      throw MailException(MailErrorKind.unsupported, 'Encryption failed: ${e.message}', e);
    }
    return _encrypted(split, armored, extra);
  }

  String _gossip(String addr, PgpKey key) {
    final minimal = backend.minimalKey(key, addr);
    return 'Autocrypt-Gossip: ${AutocryptHeader(addr: addr, keydata: minimal.data).toValue()}';
  }

  /// The content entity with the protected headers (RFC draft
  /// "protected headers", as Thunderbird) and any gossip.
  Uint8List _protect(Uint8List content, SplitMessage split, List<String> gossip) {
    final entity = SplitMessage.parse(content);
    final lines = <String>[];
    var marked = false;
    for (final h in entity.headers) {
      if (!marked && h.toLowerCase().startsWith('content-type:')) {
        lines.add('$h;\r\n protected-headers="v1"');
        marked = true;
      } else {
        lines.add(h);
      }
    }
    if (!marked) lines.insert(0, 'Content-Type: text/plain; charset=us-ascii;\r\n protected-headers="v1"');
    const names = {'from', 'to', 'cc', 'reply-to', 'subject', 'date', 'message-id', 'in-reply-to', 'references'};
    for (final h in split.headers) {
      if (names.contains(headerName(h))) lines.add(h);
    }
    lines.addAll(gossip);
    return assembleEntity(lines, entity.body);
  }

  Uint8List _withKey(Uint8List content, PgpKey own) {
    final armored = backend.armor(backend.publicKey(own)).replaceAll('\r\n', '\n').replaceAll('\n', '\r\n');
    final name = 'OpenPGP_0x${own.keyId}.asc';
    final keyPart = assembleEntity([
      'Content-Type: application/pgp-keys; name="$name"',
      'Content-Disposition: attachment; filename="$name"',
      'Content-Description: OpenPGP public key',
      'Content-Transfer-Encoding: 7bit',
    ], ascii.encode(armored));
    return _multipart('mixed', [content, keyPart]);
  }

  Uint8List _encrypted(SplitMessage split, String armored, List<String> extra) {
    final boundary = _boundary();
    final body = StringBuffer()
      ..write('This is an OpenPGP/MIME encrypted message (RFC 4880 and 3156)\r\n')
      ..write('--$boundary\r\n')
      ..write('Content-Type: application/pgp-encrypted\r\n')
      ..write('Content-Description: PGP/MIME version identification\r\n\r\n')
      ..write('Version: 1\r\n\r\n')
      ..write('--$boundary\r\n')
      ..write('Content-Type: application/octet-stream; name="encrypted.asc"\r\n')
      ..write('Content-Description: OpenPGP encrypted message\r\n')
      ..write('Content-Disposition: inline; filename="encrypted.asc"\r\n\r\n')
      ..write(armored.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n'))
      ..write('\r\n--$boundary--\r\n');
    final headers = [
      for (final h in split.outer) headerName(h) == 'subject' ? 'Subject: $hiddenSubject' : h,
      'MIME-Version: 1.0',
      ...extra,
      'Content-Type: multipart/encrypted;\r\n protocol="application/pgp-encrypted";\r\n boundary="$boundary"',
    ];
    return assembleEntity(headers, ascii.encode(body.toString()));
  }

  Uint8List _signed(SplitMessage split, Uint8List content, PgpDetachedSignature signature, List<String> extra) {
    final boundary = _boundary();
    final out = BytesBuilder(copy: false)
      ..add(ascii.encode('This is an OpenPGP/MIME signed message (RFC 4880 and 3156)\r\n--$boundary\r\n'))
      ..add(content)
      ..add(ascii.encode('\r\n--$boundary\r\n'))
      ..add(
        ascii.encode(
          'Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"\r\n'
          'Content-Description: OpenPGP digital signature\r\n'
          'Content-Disposition: attachment; filename="OpenPGP_signature.asc"\r\n\r\n'
          '${signature.armored.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n')}'
          '\r\n--$boundary--\r\n',
        ),
      );
    final headers = [
      ...split.outer,
      'MIME-Version: 1.0',
      ...extra,
      'Content-Type: multipart/signed; micalg=pgp-${signature.hashAlgorithm};\r\n'
          ' protocol="application/pgp-signature";\r\n boundary="$boundary"',
    ];
    return assembleEntity(headers, out.takeBytes());
  }

  Uint8List _multipart(String subtype, List<Uint8List> parts) {
    final boundary = _boundary();
    final out = BytesBuilder(copy: false);
    for (final p in parts) {
      out
        ..add(ascii.encode('--$boundary\r\n'))
        ..add(p)
        ..add(ascii.encode('\r\n'));
    }
    out.add(ascii.encode('--$boundary--\r\n'));
    return assembleEntity(['Content-Type: multipart/$subtype;\r\n boundary="$boundary"'], out.takeBytes());
  }

  String _boundary() =>
      '------------${List.generate(24, (_) => 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'[_random.nextInt(62)]).join()}';
}
