/// End-to-end encryption for Loupe.
///
/// - OpenPGP: keys, PGP/MIME (RFC 3156) reading and writing, and Autocrypt,
///   on a swappable [PgpBackend] (dart_pg by default).
/// - S/MIME (RFC 8551): certificates and PKCS #12, CMS signing and
///   encryption, chain validation against Mozilla's email roots, on a
///   swappable [SmimeBackend] (pure Dart on pointycastle by default).
library;

export 'src/autocrypt.dart';
export 'src/keyring/keyring.dart';
export 'src/keyring/plan.dart';
export 'src/keyring/session.dart';
export 'src/mime/codecs.dart' show HeaderValue, decodeEncodedWords, decodeCharset, decodeTransfer, canonicalLineEnds;
export 'src/mime/content.dart' show contentFromEntity, partOf;
export 'src/mime/entity.dart' show MimeEntity, splitMultipart;
export 'src/pgp/armor.dart' show hasArmor, dearmorAll, encodeArmor, ArmorBlock, splitCleartext, CleartextParts;
export 'src/pgp/dart_pg_backend.dart' show DartPgBackend;
export 'src/pgp/types.dart';
export 'src/pgp_mime/reader.dart' show PgpMimeReader, PgpReadResult, detectProtection, headerIn;
export 'src/pgp_mime/status.dart';
export 'src/pgp_mime/writer.dart';
export 'src/smime/backend.dart';
export 'src/smime/certificate.dart';
export 'src/smime/cms.dart'
    show SmimeContentCipher, SmimeDecrypted, SmimeRecipientId, SmimeSignedData, SmimeSignerCheck, smimeCapabilities;
export 'src/smime/pkcs12.dart' show SmimeBundle, SmimeKeyEntry;
export 'src/smime/primitives.dart' show SmimePrivateKey;
