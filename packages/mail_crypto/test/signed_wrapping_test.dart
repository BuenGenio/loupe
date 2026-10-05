// Wrapping attacks on signed OpenPGP mail: Alice's genuinely signed message,
// with content added around it by someone else. What is shown as signed is
// exactly what the signature covers; anything else makes the signature bad
// or is shown apart from it.
import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support.dart';

final class _Keys implements PgpSendKeys {
  _Keys(this.state);
  @override
  final KeyringState state;
  @override
  PgpKey? unlockedKey(String fingerprint) => fingerprint == aliceSecret.fingerprint ? aliceSecret : null;
}

const _evilHtml = 'Content-Type: text/html; charset=utf-8\r\n\r\n<p>Please pay the new account: EVIL</p>\r\n';
const _evilPdf =
    'Content-Type: application/pdf; name="invoice.pdf"\r\n'
    'Content-Disposition: attachment; filename="invoice.pdf"\r\n\r\n%PDF-1.4 EVIL\r\n';
const _evilText = 'Content-Type: text/plain; charset=utf-8\r\n\r\nPlease pay the new account: EVIL\r\n';

void main() {
  const reader = PgpMimeReader(pgp);
  final verifiers = [alicePublic];
  final state = KeyringState(
    ownKeys: [alicePublic],
    publicKeys: [PublicKeyEntry(key: bobPublic, acceptance: KeyAcceptance.verified, added: DateTime(2026))],
  );
  final composer = PgpMessageComposer(MimeMessageComposer(), _Keys(state), backend: pgp);

  /// Alice's signed (and, with [encrypt], encrypted) message to Bob.
  Uint8List aliceSends({bool encrypt = false}) => composer.compose(
    OutgoingMessage(
      accountId: 'a',
      identityId: 'a',
      to: const [EmailAddress('bob@openpgp.example')],
      subject: 'Lunch',
      text: 'See you at noon. Alice',
      security: OutgoingSecurity(sign: true, encrypt: encrypt),
    ),
    const Identity(id: 'a', email: 'alice@openpgp.example', name: 'Alice'),
    messageId: 'wrap@openpgp.example',
    date: DateTime.utc(2026, 10, 4, 12),
  );

  /// [raw] (a multipart) with [part] put before the delimiter at [index]
  /// (1: before the second part; parts.length: before the end).
  Uint8List withPart(Uint8List raw, String part, int index) {
    final text = latin1.decode(raw);
    final boundary = MimeEntity.parse(raw).contentType['boundary']!;
    final at = RegExp('^--${RegExp.escape(boundary)}', multiLine: true).allMatches(text).elementAt(index).start;
    return latin1.encode('${text.substring(0, at)}--$boundary\r\n$part\r\n${text.substring(at)}');
  }

  /// [inner] in a multipart/encrypted to Bob, as anyone with his public key can make one.
  Uint8List encryptedToBob(Uint8List inner) {
    final armored = pgp.encrypt(inner, recipients: [bobPublic]);
    return latin1.encode(
      'From: alice@openpgp.example\r\nTo: bob@openpgp.example\r\nSubject: ...\r\nMIME-Version: 1.0\r\n'
      'Content-Type: multipart/encrypted; protocol="application/pgp-encrypted"; boundary="b1"\r\n\r\n'
      '--b1\r\nContent-Type: application/pgp-encrypted\r\n\r\nVersion: 1\r\n\r\n'
      '--b1\r\nContent-Type: application/octet-stream\r\n\r\n$armored\r\n--b1--\r\n',
    );
  }

  String shownText(PgpReadResult r) => contentFromEntity(r.entity!, emailId: 'm').text ?? '';

  test('the untouched message is signed, and what is shown is the signed part', () {
    final r = reader.read(aliceSends(), verifiers: verifiers);
    expect(r.status.signature!.status, PgpSignatureStatus.good);
    expect(shownText(r), contains('See you at noon.'));
  });

  group('PGP/MIME multipart/signed', () {
    test('a part added after the signature (an HTML body, an attachment) makes it bad', () {
      for (final evil in [_evilHtml, _evilPdf]) {
        final raw = withPart(aliceSends(), evil, 2);
        expect(MimeEntity.parse(raw).parts, hasLength(3));
        final r = reader.read(raw, verifiers: verifiers);
        expect(r.status.signature!.status, PgpSignatureStatus.bad);
        expect(r.status.signature!.detail, PgpMimeReader.extraPartsProblem);
        expect(r.status.signature!.signerFingerprint, alicePublic.fingerprint, reason: 'whose signature it was');
        // Only the signed part is shown, from these bytes.
        final content = contentFromEntity(r.entity!, emailId: 'm');
        expect(content.text, contains('See you at noon.'));
        expect('${content.text} ${content.html}', isNot(contains('EVIL')));
        expect(content.attachments.map((a) => a.filename), isNot(contains('invoice.pdf')));
      }
    });

    test('a part put between the signed part and the signature makes it bad', () {
      final r = reader.read(withPart(aliceSends(), _evilHtml, 1), verifiers: verifiers);
      expect(r.status.signature!.status, PgpSignatureStatus.bad);
      expect(shownText(r), isNot(contains('EVIL')));
    });

    test('wrapped in a multipart/mixed with more content, it isn’t signed at all', () {
      final signed = aliceSends();
      final wrapper = latin1.encode(
        'From: alice@openpgp.example\r\nSubject: Lunch\r\nMIME-Version: 1.0\r\n'
        'Content-Type: multipart/mixed; boundary="w1"\r\n\r\n'
        '--w1\r\n${latin1.decode(signed)}\r\n--w1\r\n$_evilText\r\n--w1--\r\n',
      );
      final root = MimeEntity.parse(wrapper);
      expect(
        detectProtection(root.headers, text: 'See you at noon. Alice\nPlease pay the new account: EVIL'),
        PgpProtection.none,
      );
      final r = reader.read(wrapper, verifiers: verifiers);
      expect(r.status.signature, isNull);
      expect(r.status.protection, PgpProtection.none);
    });
  });

  group('encrypted, then the signed content inside', () {
    test('Alice’s signed+encrypted message decrypts as signed', () {
      final r = reader.read(aliceSends(encrypt: true), keys: [bobSecret], verifiers: verifiers);
      expect((r.status.decrypted, r.status.signature!.status), (true, PgpSignatureStatus.good));
    });

    test('a multipart/signed with a part added, encrypted to Bob anew: bad, and the part isn’t shown', () {
      final signed = withPart(aliceSends(), _evilText, 2);
      final r = reader.read(encryptedToBob(signed), keys: [bobSecret], verifiers: verifiers);
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature!.status, PgpSignatureStatus.bad);
      expect(r.status.signature!.detail, PgpMimeReader.extraPartsProblem);
      expect(shownText(r), contains('See you at noon.'));
      expect(shownText(r), isNot(contains('EVIL')));
    });

    test('a multipart/mixed holding Alice’s signed message and more, encrypted to Bob: not signed', () {
      final signed = aliceSends();
      final inner = latin1.encode(
        'Content-Type: multipart/mixed; boundary="w2"\r\n\r\n'
        '--w2\r\n${latin1.decode(signed)}\r\n--w2\r\n$_evilText\r\n--w2--\r\n',
      );
      final r = reader.read(encryptedToBob(inner), keys: [bobSecret], verifiers: verifiers);
      expect(r.status.decrypted, isTrue);
      expect(r.status.signature, isNull, reason: 'nothing vouches for the whole');
    });
  });

  group('inline PGP', () {
    final clearsigned = _clearsign('See you at noon. Alice');

    Uint8List plainMessage(String text, {String contentType = 'text/plain; charset=utf-8'}) => latin1.encode(
      'From: alice@openpgp.example\r\nSubject: Lunch\r\nMIME-Version: 1.0\r\nContent-Type: $contentType\r\n\r\n$text',
    );

    test('the signed block alone is signed', () {
      final r = reader.read(plainMessage(clearsigned), verifiers: verifiers);
      expect((r.status.protection, r.status.signature!.status), (PgpProtection.inlineSigned, PgpSignatureStatus.good));
      expect(r.status.partial, isFalse);
      expect(r.text, 'See you at noon. Alice');
      expect(r.outsideText, isEmpty);
    });

    test('text after the block is shown below the “Unsigned content” line, never as part of it', () {
      final r = reader.read(
        plainMessage('$clearsigned\r\nPS: please pay the new account: EVIL\r\n'),
        verifiers: verifiers,
      );
      expect(r.status.signature!.status, PgpSignatureStatus.good);
      expect(r.status.partial, isTrue);
      expect(r.protectedText, isNot(contains('EVIL')));
      final marker = outsideMarker(signed: true, encrypted: false);
      expect(marker, contains('Unsigned content'));
      expect(r.text!.indexOf(marker), lessThan(r.text!.indexOf('EVIL')));
      expect(r.text!.indexOf('See you at noon.'), lessThan(r.text!.indexOf(marker)));
    });

    test('text before the block also goes below the line, after the signed text', () {
      final r = reader.read(
        plainMessage('URGENT, from the CFO: pay EVIL now.\r\n\r\n$clearsigned'),
        verifiers: verifiers,
      );
      expect(r.status.partial, isTrue);
      final marker = outsideMarker(signed: true, encrypted: false);
      expect(r.text!.indexOf('See you at noon.'), lessThan(r.text!.indexOf(marker)));
      expect(r.text!.indexOf(marker), lessThan(r.text!.indexOf('EVIL')));
      expect(r.protectedText, 'See you at noon. Alice');
    });

    test('a second, altered signed block after the first is outside the signature', () {
      final forged = clearsigned.replaceFirst('noon', 'EVIL');
      final r = reader.read(plainMessage('$clearsigned\r\n$forged'), verifiers: verifiers);
      expect(r.status.partial, isTrue);
      expect(r.protectedText, isNot(contains('EVIL')));
    });

    test('other parts of the message (an attachment, an HTML alternative) make it signed in part', () {
      for (final (type, extra) in [('mixed', _evilPdf), ('alternative', _evilHtml)]) {
        final raw = latin1.encode(
          'From: alice@openpgp.example\r\nSubject: Lunch\r\nMIME-Version: 1.0\r\n'
          'Content-Type: multipart/$type; boundary="i1"\r\n\r\n'
          '--i1\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n$clearsigned\r\n--i1\r\n$extra\r\n--i1--\r\n',
        );
        final r = reader.read(raw, verifiers: verifiers);
        expect(r.status.signature!.status, PgpSignatureStatus.good);
        expect(r.status.partial, isTrue, reason: type);
        expect(r.text, isNot(contains('EVIL')));
      }
    });

    test('an encrypted block between plain text: the plain text is below the “Not encrypted” line', () {
      final armored = pgp.encrypt(bytes('Secret: the code is 1234.'), recipients: [bobPublic], signer: aliceSecret);
      final r = reader.read(
        plainMessage('Forged note: EVIL\r\n$armored\r\nFooter'),
        keys: [bobSecret],
        verifiers: verifiers,
      );
      expect((r.status.decrypted, r.status.partial), (true, true));
      final marker = outsideMarker(signed: true, encrypted: true);
      expect(r.text!.startsWith('Secret: the code is 1234.'), isTrue);
      expect(r.text!.indexOf(marker), lessThan(r.text!.indexOf('EVIL')));
      expect(r.outsideText, contains('Footer'));
    });
  });
}

/// [text] clear-signed by Alice.
String _clearsign(String text) {
  final signature = pgp.signDetached(utf8.encode(text), aliceSecret);
  return '-----BEGIN PGP SIGNED MESSAGE-----\r\nHash: ${signature.hashAlgorithm.toUpperCase()}\r\n\r\n'
      '$text\r\n${signature.armored.replaceAll('\r\n', '\n').replaceAll('\n', '\r\n')}';
}
