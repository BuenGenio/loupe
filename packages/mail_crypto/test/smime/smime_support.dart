import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';

const smime = DartSmimeBackend();

/// The day the tests pretend it is: every test certificate but Carol's is valid.
final today = DateTime.utc(2026, 10, 4, 12);

Uint8List smimeFixture(String name) => File('test/fixtures/smime/$name').readAsBytesSync();

SmimeCertificate cert(String name) => readCertificates(smimeFixture(name)).single;

final testRoot = cert('root.crt');
final testCa = cert('intermediate.crt');
final evilRoot = cert('evil.crt');

final aliceBundle = smime.readPkcs12(smimeFixture('alice.p12'), 'alice-pass');
final bobBundle = smime.readPkcs12(smimeFixture('bob-3des.p12'), 'bob-pass');

SmimeKeyPair pair(SmimeBundle b) => SmimeKeyPair(b.keys.single.certificate, b.keys.single.key);

final alice = pair(aliceBundle);
final bob = pair(bobBundle);

/// A test message (`.eml`).
Uint8List smimeMail(String name) => smimeFixture(name);

/// Runs openssl in a throwaway directory under .dart_tool; null when it
/// isn't installed.
final class Openssl {
  Openssl._(this.dir);

  final Directory dir;

  static Openssl? create() {
    try {
      if (Process.runSync('openssl', ['version']).exitCode != 0) return null;
    } on ProcessException {
      return null;
    }
    final base = Directory('.dart_tool/openssl-test')..createSync(recursive: true);
    return Openssl._(base.createTempSync('run-'));
  }

  /// Writes [bytes] to a file in the directory and returns its path.
  String file(String name, List<int> bytes) {
    final f = File('${dir.path}/$name')..writeAsBytesSync(bytes);
    return f.path;
  }

  ProcessResult run(List<String> args) => Process.runSync('openssl', args, stdoutEncoding: null);

  void dispose() => dir.deleteSync(recursive: true);
}
