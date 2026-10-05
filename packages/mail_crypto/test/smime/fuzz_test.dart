import 'dart:io';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:test/test.dart';

import 'fuzz_harness.dart';
import 'smime_support.dart';

/// Damaged input never throws anything but a typed error out of the S/MIME
/// parsers, and never takes long. A few iterations per target here (set
/// LOUPE_FUZZ_ITERATIONS for more); tool/fuzz_smime.dart runs many.
void main() {
  final iterations = int.tryParse(Platform.environment['LOUPE_FUZZ_ITERATIONS'] ?? '') ?? 400;

  for (final target in fuzzTargets()) {
    test('${target.name}: $iterations mutated inputs', () {
      final stats = fuzz(targets: [target], iterations: iterations, slow: const Duration(seconds: 5));
      for (final f in stats.failures) {
        saveFailure(f);
      }
      expect(stats.failures, isEmpty, reason: stats.failures.join('\n'));
    }, timeout: const Timeout(Duration(minutes: 5)));
  }

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
