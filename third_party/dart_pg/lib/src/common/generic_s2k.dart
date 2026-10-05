/// Copyright 2024-present by Dart Privacy Guard project. All rights reserved.
/// For the full copyright and license information, please view the LICENSE
/// file that was distributed with this source code.

library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/api.dart' show Digest;

import '../enum/hash_algorithm.dart';
import '../enum/s2k_type.dart';
import '../type/s2k.dart';
import 'helpers.dart';

/// Implementation of the string-to-key specifier
/// See https://www.rfc-editor.org/rfc/rfc9580#section-3.7
final class GenericS2k implements S2kInterface {
  /// Default salt length
  static const saltLength = 8;

  /// Exponent bias
  static const _expbias = 6;

  /// Default iteration count byte
  static const _defaultItCount = 224;

  /// Hash function identifier
  final HashAlgorithm hash;

  /// s2k iteration count
  final int itCount;

  // s2k iteration count byte
  final int count;

  @override
  final Uint8List salt;

  @override
  final S2kType type;

  GenericS2k(
    this.salt, [
    this.type = S2kType.iterated,
    this.hash = HashAlgorithm.sha256,
    this.itCount = _defaultItCount,
  ]) : count = (16 + (itCount & 15)) << ((itCount >> 4) + _expbias);

  /// Parsing function for a string-to-key specifier
  factory GenericS2k.fromBytes(final Uint8List bytes) {
    var pos = 0;
    final type = S2kType.values.firstWhere(
      (type) => type.value == bytes[pos],
    );
    pos++;
    final hash = HashAlgorithm.values.firstWhere(
      (hash) => hash.value == bytes[pos],
    );
    pos++;

    var itCount = 0;
    final Uint8List salt;
    switch (type) {
      case S2kType.salted:
        salt = bytes.sublist(pos, pos + saltLength);
        break;
      case S2kType.iterated:
        salt = bytes.sublist(pos, pos + saltLength);
        itCount = bytes[pos + saltLength];
        break;
      default:
        salt = Uint8List(0);
        break;
    }
    return GenericS2k(
      salt,
      type,
      hash,
      itCount,
    );
  }

  @override
  produceKey(final String passphrase, final int length) {
    switch (type) {
      case S2kType.simple:
        return _hashDigest(passphrase.toBytes(), length);
      case S2kType.salted:
        return _hashDigest(
          Uint8List.fromList([
            ...salt,
            ...passphrase.toBytes(),
          ]),
          length,
        );
      case S2kType.iterated:
        return _iteratedKey(
          Uint8List.fromList([
            ...salt,
            ...passphrase.toBytes(),
          ]),
          length,
        );
      default:
        throw UnsupportedError('S2k type not supported.');
    }
  }

  @override
  get length => type.length;

  @override
  get toBytes {
    final bytes = [type.value, hash.value];
    switch (type) {
      case S2kType.simple:
        return Uint8List.fromList(bytes);
      case S2kType.salted:
        return Uint8List.fromList([...bytes, ...salt]);
      case S2kType.iterated:
        return Uint8List.fromList([...bytes, ...salt, itCount]);
      case S2kType.gnu:
        return Uint8List.fromList([...bytes, ...utf8.encode('GNU'), 1]);
      case S2kType.argon2:
        throw UnsupportedError('Argon2 s2k type not supported.');
    }
  }

  /// Loupe: the iterated and salted key, hashing the repeated salt and
  /// passphrase as they stream past instead of building them in memory:
  /// upstream allocated the whole count twice (up to 2 × 62 MiB, which
  /// Thunderbird's and GnuPG's keys use) for every unlock. The same bytes
  /// are hashed, so the same key comes out.
  Uint8List _iteratedKey(final Uint8List data, final int length) {
    // The whole salt and passphrase is hashed even when the count is smaller.
    final total = data.length > count ? data.length : count;
    // A chunk of whole repetitions, so every chunk starts with the salt.
    final repeats = data.isEmpty ? 1 : (64 * 1024 ~/ data.length).clamp(1, 1 << 20);
    final chunk = Uint8List(data.length * repeats);
    for (var pos = 0; pos < chunk.length; pos += data.length) {
      chunk.setAll(pos, data);
    }
    final result = BytesBuilder(copy: false);
    // Each further context is preloaded with one more zero octet (RFC 9580,
    // 3.7.1.1); upstream's _hashDigest preloads one, the same for the two
    // contexts any key length needs.
    for (var round = 0; result.length < length; round++) {
      final preload = Uint8List(round);
      final fast = hash.fastHash;
      if (fast != null) {
        // package:crypto, several times faster (SHA-1: four times).
        final digest = _DigestSink();
        final input = fast.startChunkedConversion(digest)..add(preload);
        for (var remaining = total; remaining > 0; remaining -= chunk.length) {
          input.add(remaining < chunk.length ? Uint8List.sublistView(chunk, 0, remaining) : chunk);
        }
        input.close();
        result.add(digest.value!.bytes);
        continue;
      }
      final digest = Digest(hash.digestName)..update(preload, 0, preload.length);
      for (var remaining = total; remaining > 0; remaining -= chunk.length) {
        digest.update(chunk, 0, remaining < chunk.length ? remaining : chunk.length);
      }
      final out = Uint8List(digest.digestSize);
      digest.doFinal(out, 0);
      result.add(out);
    }
    return result.takeBytes().sublist(0, length);
  }

  Uint8List _hashDigest(final Uint8List data, final int length) {
    var result = Helper.hashDigest(data, hash);
    while (result.length < length) {
      result = Uint8List.fromList([
        ...result,
        ...Helper.hashDigest(
          Uint8List.fromList([0, ...data]),
          hash,
        ),
      ]);
    }
    return result.sublist(0, length);
  }
}

/// Receives the digest of a chunked package:crypto hash.
final class _DigestSink implements Sink<crypto.Digest> {
  crypto.Digest? value;

  @override
  void add(crypto.Digest data) => value = data;

  @override
  void close() {}
}
