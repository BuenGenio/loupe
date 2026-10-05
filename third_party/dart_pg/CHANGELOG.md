## 2.1.0+loupe.1 (vendored by Loupe, 2026-10-04)
Upstream 2.1.0 plus fixes for leading zero octets, which broke about one in
a hundred Ed25519 signatures from Thunderbird and GnuPG (also when reading
their keys) and one in 256 Ed25519 secret keys:
- EdDSA (legacy) verification reads R and S by their MPI bit counts and
  left-pads them to 32 octets.
- EdDSA (legacy) signing pads the secret seed to 32 octets and writes
  minimal MPIs for R and S.
- ECDH pads the Curve25519 secret scalar to 32 octets and NIST shared
  secrets to the field size before the KDF.
- The Signature Expiration Time subpacket counts seconds after creation
  (0 means never): upstream read it as a date, so every Thunderbird (RNP)
  signature, which carries a 0, was "expired". Signatures dated up to a day
  in the future (clock skew) are accepted.
Only lib/ is vendored (no tests or examples).

## 2.1.0+loupe.2 (2026-10-05)
Speed, without changing a byte of what is read or written (mail_crypto's
test/dart_pg_speed_test.dart compares with upstream's and pointycastle's):
- CFB mode is our own `CfbBlockCipher`: pointycastle's CFBBlockCipher copies
  the rest of its input for every block, so encrypting and decrypting took
  quadratic time (1 MB: 15 s; now 0.4 s).
- Partial body lengths are written by offset; upstream copied the rest of the
  body for every 1 KiB chunk (quadratic). `PacketList.encode` concatenates
  bytes instead of going byte by byte through a `List<int>`.
- The iterated and salted S2K hashes the repeated salt and passphrase as it
  streams, instead of building them twice in memory (2 × 62 MiB for the
  keys Thunderbird and GnuPG make).
- SHA-1 and SHA-2 come from package:crypto (`Helper.hashDigest`, the S2K):
  several times faster than pointycastle's (SHA-1 4×, SHA-512 20×), so a
  GnuPG key unlocks in 0.8 s instead of 2.6 s.

## 1.0.0 (2023-03-21)
- Allows to encrypt and sign data.
- Support key management: key generation, key reading, key decryption.
- Support public-key algorithms: RSA, DSA, ElGamal, ECDSA, EdDSA and ECDH.
- Support symmetric ciphers: 3DES, IDEA (for backward compatibility), CAST5, Blowfish, Twofish, AES-128, AES-192, AES-256, Camellia-128, Camellia-192, Camellia-256.
- Support hash algorithms: MD5, SHA-1, RIPEMD-160, SHA-256, SHA-384, SHA-512, SHA-224.
- Support compression algorithms: Uncompressed, ZIP, ZLIB.
- Support ECC curves: secP256k1, secP384r1, secP521r1, brainpoolP256r1, brainpoolP384r1, brainpoolP512r1, curve25519, ed25519, prime256v1.

## 1.0.1 (2023-03-23)
- Remove Crc24 class
- Refactor & format code by Dart formatter

## 1.0.2 (2023-03-23)
- Update pointycastle to 3.7.1
- Use Pointy Castle DESede engine for SymmetricAlgorithm.tripledes
- Use Pointy Castle PKCS1Encoding for RSA & Elgamal session key encryption

## 1.1.0 (2023-04-05)
- Add Camellia key wrapper for ECDH algorithm
- Refactor KeyGenerationType enum

## 1.1.1 (2023-04-24)
- Fix s2k iterated produce key

## 1.1.2 (2023-05-11)
- Pass ParametersWithIV to cipher in SKESK packet
- Refactor session key encryption

## 1.1.3 (2023-05-12)
- Fix decrypt session key in SKESK

## 1.1.4 (2023-05-13)
- Remove cryptor dependency
- Fix old format packet reading

## 1.1.5 (2023-06-09)
- Change homepage url
- Fix lower 3 bits of the secret key are not cleared of curve25519 key generation

## 1.2.0 (2024-01-03)
- Support AEAD algorithms: EAX, OCB, GCM

## 1.3.0 (2024-09-13)
- Require version 3.2.0 sdk
- Update pinenacl to version 0.6.0
- Update pointycastle to version 3.9.1
- Fix packet reader
- Fix AEAD crypt

## 1.4.0 (2024-10-15)
- Support partial body length
- Support signature salt notation

## 1.5.0 (2024-10-17)
- Add checksum to un-encrypted secret key packet 
- Remove fixnum package

## 1.5.1 (2024-11-14)
- Fix aead adata encrypted session key

## 1.5.2 (2024-11-15)
- Fix encode SKESK packet to bytes

## 1.5.3 (2024-11-18)
- Refactor AEAD crypt

## 1.5.4 (2024-11-27)
- Fix ecdh ephemeral key for curve 25519

## 1.5.5 (2024-12-6)
- Fix read public key list ignore last index

## 2.0.0 (2024-12-11)
- Release to major version 2

## 2.1.0 (2025-04-08)
- Update pointycastle to version 4.0.0
- Remove Blowfish, Camellia, Twofish cipher engines
