/// Added by Loupe to its vendored copy of dart_pg (BSD-3-Clause, as the
/// rest of this package).

library;

import 'dart:typed_data';
import 'package:pointycastle/api.dart';

/// Cipher feedback (CFB) mode with full-block feedback, as OpenPGP uses it
/// (RFC 9580, 5.13.1 and 5.5.3): the IV is zeros unless given, and only
/// the forward cipher is used.
///
/// It takes the place of pointycastle's CFBBlockCipher, which copies the
/// rest of its input (or output) for every block it processes, so a message
/// took quadratic time: about 12 s to encrypt and 17 s to decrypt 1 MB.
final class CfbBlockCipher implements BlockCipher {
  CfbBlockCipher(this._cipher)
      : _iv = Uint8List(_cipher.blockSize),
        _register = Uint8List(_cipher.blockSize),
        _keystream = Uint8List(_cipher.blockSize);

  final BlockCipher _cipher;
  final Uint8List _iv;

  /// The previous ciphertext block (the IV at first).
  final Uint8List _register;
  final Uint8List _keystream;
  bool _encrypting = true;

  @override
  int get blockSize => _cipher.blockSize;

  @override
  String get algorithmName => '${_cipher.algorithmName}/CFB-${blockSize * 8}';

  @override
  void init(bool forEncryption, CipherParameters? params) {
    _encrypting = forEncryption;
    if (params is ParametersWithIV) {
      final iv = params.iv;
      // A short IV is prepended with zeros (FIPS PUB 81), as pointycastle does.
      final offset = iv.length < _iv.length ? _iv.length - iv.length : 0;
      _iv.fillRange(0, offset, 0);
      _iv.setRange(offset, _iv.length, iv);
      reset();
      if (params.parameters != null) _cipher.init(true, params.parameters);
    } else {
      _iv.fillRange(0, _iv.length, 0);
      reset();
      _cipher.init(true, params);
    }
  }

  @override
  void reset() {
    _register.setAll(0, _iv);
    _cipher.reset();
  }

  @override
  Uint8List process(Uint8List data) {
    final out = Uint8List(blockSize);
    final length = processBlock(data, 0, out, 0);
    return out.sublist(0, length);
  }

  /// Processes one block of [inp] at [inpOff] into [out] at [outOff]; they
  /// may be the same buffer.
  @override
  int processBlock(Uint8List inp, int inpOff, Uint8List out, int outOff) {
    final size = blockSize;
    if (inpOff + size > inp.length) throw ArgumentError('Input buffer too short');
    if (outOff + size > out.length) throw ArgumentError('Output buffer too short');
    _cipher.processBlock(_register, 0, _keystream, 0);
    if (_encrypting) {
      for (var i = 0; i < size; i++) {
        final c = _keystream[i] ^ inp[inpOff + i];
        out[outOff + i] = c;
        _register[i] = c;
      }
    } else {
      for (var i = 0; i < size; i++) {
        final c = inp[inpOff + i];
        out[outOff + i] = _keystream[i] ^ c;
        _register[i] = c;
      }
    }
    return size;
  }
}
