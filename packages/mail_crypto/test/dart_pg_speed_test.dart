// Loupe's speed fixes in its copy of dart_pg (third_party/dart_pg): CFB in
// place of pointycastle's quadratic one, partial body lengths written by
// offset, and the iterated S2K hashed as it streams. The same bytes as
// before, in linear time and memory.
// ignore_for_file: implementation_imports
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_pg/src/cryptor/symmetric/buffered_cipher.dart';
import 'package:dart_pg/src/common/generic_s2k.dart';
import 'package:dart_pg/src/cryptor/symmetric/cfb.dart';
import 'package:dart_pg/src/enum/hash_algorithm.dart';
import 'package:dart_pg/src/enum/s2k_type.dart';
import 'package:dart_pg/src/packet/base_packet.dart';
import 'package:dart_pg/src/enum/symmetric_algorithm.dart';
import 'package:pointycastle/export.dart';
import 'package:test/test.dart';

import 'support.dart';

Uint8List _bytes(Random r, int n) => Uint8List.fromList([for (var i = 0; i < n; i++) r.nextInt(256)]);

/// Encrypts or decrypts [data] in one go, as dart_pg does (BufferedCipher).
Uint8List _run(BlockCipher mode, bool encrypt, Uint8List key, Uint8List iv, Uint8List data) {
  final cipher = BufferedCipher(mode)..init(encrypt, ParametersWithIV(KeyParameter(key), iv));
  return cipher.process(data);
}

/// Upstream's iterated and salted S2K, which built the repeated input in memory.
Uint8List _upstreamS2k(HashAlgorithm hash, int count, Uint8List data, int length) {
  var iterated = data;
  if (data.length <= count) {
    final result = Uint8List((count / data.length).ceil() * data.length);
    for (var pos = 0; pos < result.length; pos += data.length) {
      result.setAll(pos, data);
    }
    iterated = result.sublist(0, count);
  }
  var key = Digest(hash.digestName).process(iterated);
  while (key.length < length) {
    key = Uint8List.fromList([
      ...key,
      ...Digest(hash.digestName).process(Uint8List.fromList([0, ...iterated])),
    ]);
  }
  return key.sublist(0, length);
}

void main() {
  test('gives the same bytes as pointycastle’s CFB, for every cipher OpenPGP uses', () {
    final r = Random(24);
    for (final algorithm in SymmetricAlgorithm.values.where((a) => a != SymmetricAlgorithm.plaintext)) {
      final key = _bytes(r, algorithm.keySizeInByte);
      final size = algorithm.blockSize;
      for (final iv in [Uint8List(size), _bytes(r, size), _bytes(r, size - 2)]) {
        for (final length in [0, 1, size - 1, size, size + 1, 3 * size, 1000]) {
          final plain = _bytes(r, length);
          final theirs = _run(CFBBlockCipher(algorithm.cipherEngine, size), true, key, iv, plain);
          final ours = _run(CfbBlockCipher(algorithm.cipherEngine), true, key, iv, plain);
          expect(ours, theirs, reason: '$algorithm, ${iv.length}-byte IV, $length bytes');
          expect(_run(CfbBlockCipher(algorithm.cipherEngine), false, key, iv, ours), plain);
          expect(algorithm.cfbCipherEngine, isA<CfbBlockCipher>());
        }
      }
    }
  });

  test('processes in place, and restarts from the IV after reset', () {
    final r = Random(7);
    final key = _bytes(r, 32);
    final iv = _bytes(r, 16);
    final plain = _bytes(r, 64);
    final mode = CfbBlockCipher(AESEngine())..init(true, ParametersWithIV(KeyParameter(key), iv));
    final expected = _run(CFBBlockCipher(AESEngine(), 16), true, key, iv, plain);
    final buffer = Uint8List.fromList(plain);
    for (var off = 0; off < 64; off += 16) {
      mode.processBlock(buffer, off, buffer, off);
    }
    expect(buffer, expected);
    mode.reset();
    expect(mode.process(Uint8List.sublistView(plain, 0, 16)), expected.sublist(0, 16));
  });

  test('a 2 MB message encrypts and decrypts in linear time (it took minutes)', () {
    final r = Random(3);
    final data = _bytes(r, 2 * 1024 * 1024);
    final watch = Stopwatch()..start();
    final armored = pgp.encrypt(data, recipients: [bobPublic]);
    final back = pgp.decrypt(bytes(armored), keys: [bobSecret]);
    expect(back.data, data);
    // Before: about 50 s for encrypting and 70 s for decrypting this here;
    // after, a few seconds. Generous for slow machines.
    expect(watch.elapsed, lessThan(const Duration(seconds: 30)));
  });

  test('gpg reads a large message we encrypt, and we read one gpg encrypts', () {
    final gpg = Gpg.create();
    if (gpg == null) {
      markTestSkipped('gpg is not installed');
      return;
    }
    addTearDown(gpg.dispose);
    gpg
      ..import(pgp.armor(bobSecret))
      ..import(pgp.armor(alicePublic));
    final data = _bytes(Random(11), 300 * 1024 + 5);
    final ours = gpg.run(['--decrypt'], stdin: utf8.encode(pgp.encrypt(data, recipients: [bobPublic])));
    expect(ours.exitCode, 0, reason: '${ours.stderr}');
    expect(ours.stdout, data);
    // gpg's own (SEIPD v1 to Alice's v4 key, AES-256, uncompressed).
    final theirs = gpg.run([
      '--trust-model', 'always', '--output', '-', '--encrypt', '--compress-algo', 'none', '--cipher-algo', 'AES256', //
      '--recipient', 'alice@openpgp.example',
    ], stdin: data);
    expect(theirs.exitCode, 0, reason: '${theirs.stderr}');
    expect(pgp.decrypt(Uint8List.fromList(theirs.stdout as List<int>), keys: [aliceSecret]).data, data);
  });

  test('the iterated S2K gives upstream’s keys', () {
    final r = Random(5);
    for (final hash in [HashAlgorithm.sha1, HashAlgorithm.sha256, HashAlgorithm.sha512]) {
      for (final itCount in [0, 1, 96, 150]) {
        for (final passphrase in ['', 'x', 'correct horse battery staple', 'Grüße ✓' * 9]) {
          final salt = _bytes(r, 8);
          final s2k = GenericS2k(salt, S2kType.iterated, hash, itCount);
          for (final length in [16, 24, 32]) {
            expect(
              s2k.produceKey(passphrase, length),
              _upstreamS2k(hash, s2k.count, Uint8List.fromList([...salt, ...utf8.encode(passphrase)]), length),
              reason: '$hash, count ${s2k.count}, "$passphrase", $length bytes',
            );
          }
        }
      }
    }
  });

  test('partial body lengths: whole chunks by offset, the rest with a plain length', () {
    final r = Random(9);
    for (final length in [0, 100, 511, 512, 1023, 1024, 1025, 5000, 70000]) {
      final body = _bytes(r, length);
      final encoded = LiteralDataPacket(body).encode();
      final back = PacketList.decode(encoded).single as LiteralDataPacket;
      expect(back.binary, body, reason: '$length bytes');
    }
  });
}
