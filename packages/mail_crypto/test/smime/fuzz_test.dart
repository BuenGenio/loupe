import 'dart:math';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'smime_support.dart';

/// Damaged input never throws out of the S/MIME readers: it reads as damaged.
void main() {
  final random = Random(21);

  Uint8List mutate(Uint8List input) {
    final out = Uint8List.fromList(input);
    for (var n = 1 + random.nextInt(4); n > 0; n--) {
      out[random.nextInt(out.length)] = random.nextInt(256);
    }
    return out;
  }

  test('CMS blobs with random bytes changed', () {
    for (final name in ['enveloped-rsa.eml', 'enveloped-ec.eml', 'authenveloped.eml', 'signed-opaque.eml']) {
      final der = MimeEntity.parse(smimeMail(name)).decodedBody;
      for (var i = 0; i < 150; i++) {
        final bad = mutate(der);
        try {
          smime.decrypt(bad, [alice, bob]);
        } on SmimeException {
          // Expected.
        }
        try {
          smime.verify(bad);
        } on SmimeException {
          // Expected.
        }
      }
    }
  });

  test('whole messages, certificates and PKCS #12 files with random bytes changed', () {
    const reader = SmimeReader(smime);
    for (final name in ['signed-detached.eml', 'signed-enveloped.eml', 'opaque-enveloped.eml']) {
      for (var i = 0; i < 60; i++) {
        reader.read(mutate(smimeMail(name)), keys: [alice, bob], anchors: testAnchors, now: today);
      }
    }
    for (var i = 0; i < 200; i++) {
      try {
        readCertificates(mutate(testCa.der));
      } on SmimeException {
        // Expected.
      }
    }
    for (var i = 0; i < 40; i++) {
      try {
        smime.readPkcs12(mutate(smimeFixture('alice.p12')), 'alice-pass');
      } on SmimeException {
        // Expected.
      }
    }
  });

  test('truncated input', () {
    final der = MimeEntity.parse(smimeMail('signed-enveloped.eml')).decodedBody;
    for (var n = 0; n < der.length; n += 37) {
      try {
        smime.decrypt(Uint8List.sublistView(der, 0, n), [alice, bob]);
      } on SmimeException {
        // Expected.
      }
    }
  });
}
