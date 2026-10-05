import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_imap/mail_imap.dart' show MimeMessageComposer;
import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';

/// OpenPGP in the demo: Sam's key (no passphrase, so nothing is asked),
/// Dana's accepted and verified key, and two messages: one from Dana,
/// encrypted and signed with a protected subject and an attachment, and
/// one from Leo, signed, whose Autocrypt header brings in his key.
///
/// The messages are written by the same PGP/MIME composer Loupe sends
/// with, when first opened, dated like the demo mailbox around them.
/// Throwaway keys made for the demo; never use them for anything else.
extension DemoOpenPgpCases on DemoSeed {
  void openPgpCases() {
    const me = DemoPeople.work;
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(2, 8, 47),
      from: DemoPeople.dana,
      to: const [me],
      subject: '...',
      text: '',
      encrypted: true,
      raw: (summary) => _write(
        from: _danaSecret,
        fromAddress: DemoPeople.dana,
        known: [_samSecret],
        summary: summary,
        subject: 'Offsite venue (confidential)',
        text:
            'Hi Sam,\n\nThe offsite is confirmed: Lighthouse Lodge, 14 to 16 November. Please keep the venue '
            'to yourself until the announcement on Friday.\n\nThe budget sheet is attached, encrypted like this '
            'message.\n\nDana',
        attachments: [
          OutgoingAttachment(
            filename: 'offsite-budget.csv',
            mimeType: 'text/csv',
            data: Uint8List.fromList(utf8.encode('Item,Cost\nVenue,4200\nTravel,1850\nCatering,1320\nWorkshops,600\n')),
          ),
        ],
        security: const OutgoingSecurity(encrypt: true, sign: true),
      ),
    );
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(3, 17, 12),
      from: DemoPeople.leo,
      to: const [me],
      subject: 'Sync phase 2 estimate',
      text: _leoText,
      raw: (summary) => _write(
        from: _leoSecret,
        fromAddress: DemoPeople.leo,
        known: const [],
        summary: summary,
        subject: 'Sync phase 2 estimate',
        text: _leoText,
        security: const OutgoingSecurity(sign: true),
        preferEncrypt: true,
      ),
    );
  }

  static const _leoText =
      'Sam,\n\nPhase 2 needs about three weeks once the storage migration lands. I sign my mail with OpenPGP '
      'now: same key as in Thunderbird, and it comes along with this message.\n\nLeo';
}

/// Puts Sam's key, Dana's key and Sam's settings into the demo keyring.
Future<void> seedDemoKeyring(Keyring keyring, PgpBackend backend) async {
  if (keyring.state.hasOwnKeys) return;
  final sam = backend.readKeys(_bytes(_samSecret)).single;
  await keyring.addOwnKey(secret: sam, public: backend.publicKey(sam));
  await keyring.addPublicKeys([
    backend.publicKey(backend.readKeys(_bytes(_danaSecret)).single),
  ], acceptance: KeyAcceptance.verified);
  await keyring.setIdentity(DemoPeople.work.email, IdentityPgp(keyFingerprint: sam.fingerprint, preferEncrypt: true));
}

/// Content and parts of a demo message that has raw source ([DemoMessage.raw]),
/// as an IMAP server would describe it: [transport] headers (Received,
/// Authentication-Results) plus the message's own.
EmailContent demoRawContent(DemoMessage m, List<(String, String)> transport) {
  final entity = MimeEntity.parse(m.raw!());
  return contentFromEntity(
    entity,
    emailId: m.id,
    partPrefix: '',
    keepPgpParts: true,
    headers: [...transport, ...entity.headers],
  );
}

/// The bytes of part [partId] of a demo message with raw source.
Uint8List? demoRawPart(DemoMessage m, String partId) =>
    partOf(MimeEntity.parse(m.raw!()), partId, partPrefix: '')?.decodedBody;

Uint8List _bytes(String s) => Uint8List.fromList(utf8.encode(s));

final class _Sender implements PgpSendKeys {
  _Sender(this.state, this.signer);

  @override
  final KeyringState state;
  final PgpKey signer;

  @override
  PgpKey? unlockedKey(String fingerprint) => fingerprint == signer.fingerprint ? signer : null;
}

Uint8List _write({
  required String from,
  required EmailAddress fromAddress,
  required List<String> known,
  required EmailSummary summary,
  required String subject,
  required String text,
  required OutgoingSecurity security,
  List<OutgoingAttachment> attachments = const [],
  bool preferEncrypt = false,
}) {
  const backend = DartPgBackend();
  final secret = backend.readKeys(_bytes(from)).single;
  final public = backend.publicKey(secret);
  final state = KeyringState(
    ownKeys: [public],
    publicKeys: [
      for (final k in known)
        PublicKeyEntry(
          key: backend.publicKey(backend.readKeys(_bytes(k)).single),
          acceptance: KeyAcceptance.verified,
          added: summary.receivedAt,
        ),
    ],
    identities: {fromAddress.email: IdentityPgp(keyFingerprint: public.fingerprint, preferEncrypt: preferEncrypt)},
  );
  final composer = PgpMessageComposer(
    MimeMessageComposer(),
    _Sender(state, secret),
    backend: backend,
    clock: () => summary.sentAt ?? summary.receivedAt,
  );
  return composer.compose(
    OutgoingMessage(
      accountId: 'demo',
      identityId: 'demo',
      to: summary.to,
      subject: subject,
      text: text,
      attachments: attachments,
      security: security,
    ),
    Identity(id: 'demo', email: fromAddress.email, name: fromAddress.name),
    messageId: summary.messageIdHeader ?? '${summary.id}@demo.example',
    date: summary.sentAt ?? summary.receivedAt,
  );
}

// Sam Rivera (the demo user), ED8A6081E8A06DE9FCF843271458F4941D3C5E28
const _samSecret = '''
-----BEGIN PGP PRIVATE KEY BLOCK-----

xVgEaQhvEBYJKwYBBAHaRw8BAQdAobpWqhtiWix7Q6ovvfsWYMfu1s+5/cVQBCLs
QtTgM04AAQDEpmmpfjP2D261ZqskbAWD1BgcnG4priV0aYOjlVM2VA4CzSlTYW0g
Uml2ZXJhIDxzYW0ucml2ZXJhQG5vcnRod2luZC5leGFtcGxlPsLAGAQTFgoAigUC
aQhvEBYhBO2KYIHooG3p/PhDJxRY9JQdPF4oCRAUWPSUHTxeKAIbAwQLCQgHBRUK
CQgLBBYCAQACHgECGQEFCQWjmoBDFAAAAAAAGgAgc2FsdEBub3RhdGlvbnMuZGFy
dC1wZy5vcmdJakxaYHQuUi1EdHB9Z3wsajZIe2JTRXQyMSpxZTw+PQAAUCsBAInG
4fFLZToQAjSzMRxBQXrZVvfwZvFsMqMopfe6lLNPAQC53a03YswVZqd0ac9LZ+wN
/aOd9d/iu43l5jG5DehVDMddBGkIbxASCisGAQQBl1UBBQEBB0AwQptZiqKN3ZZ5
z8gdCzqFhmU5HgJLQbJ9vszco5cqewMBCAcAAP9RT4ZbjiAyAZbNT0byzxvGtgta
nUO+Iz9fHKBIHf1UMA4XwsACBBgWCgB0BQJpCG8QFiEE7Ypggeigben8+EMnFFj0
lB08XigJEBRY9JQdPF4oBQkFo5qAAhsMQxQAAAAAABoAIHNhbHRAbm90YXRpb25z
LmRhcnQtcGcub3JnVD5LQyhmVTdRZVJuQix7TVpnR2kuP08rT3lQNCxpRmcAAOFH
AP9lvQcBMBOexKnzlk+QCeBRNXWCrSg8JYAUCK4A23hV5AD/Qco390cb9KBHmAvI
By0OoVq872ZQSARJ5jIy670acg0=
=DVzU
-----END PGP PRIVATE KEY BLOCK-----
''';

// Dana Okafor, 31E9764D39020A7805784C565014B24B6C2D1AF9
const _danaSecret = '''
-----BEGIN PGP PRIVATE KEY BLOCK-----

xVgEaQhvEBYJKwYBBAHaRw8BAQdA8n6cP/xXfewV6NcEXO2fVi6M6yKAgpsfVZz+
RQ7UfUEAAQDJP62GmrBSqJkdkAlg/3mO9akUJAOlphrgkziIY7866w/tzStEYW5h
IE9rYWZvciA8ZGFuYS5va2Fmb3JAbm9ydGh3aW5kLmV4YW1wbGU+wsAYBBMWCgCK
BQJpCG8QFiEEMel2TTkCCngFeExWUBSyS2wtGvkJEFAUsktsLRr5AhsDBAsJCAcF
FQoJCAsEFgIBAAIeAQIZAQUJBaOagEMUAAAAAAAaACBzYWx0QG5vdGF0aW9ucy5k
YXJ0LXBnLm9yZ2B0ay8tNnRSZCtYRHFxYi56WjBlRkdcWCteWjg0OjhvAAAmBAEA
3UnSTPp0F0E3OLHh8jnegawCTgIYwctH6MT4pKiC6BoA/3D7/rz9lEyyjRGC+i3C
IsEiHGnhrlSmG16brn57f7IOx10EaQhvEBIKKwYBBAGXVQEFAQEHQEL+01BNCkwT
EoEN6jlsbC7UysnFAaKIfCvGhO+suDlCAwEIBwAA/2asPtERESjvNCZUFH2raUcp
EXp5oDXeLhKH5AUdi7vIDa7CwAIEGBYKAHQFAmkIbxAWIQQx6XZNOQIKeAV4TFZQ
FLJLbC0a+QkQUBSyS2wtGvkFCQWjmoACGwxDFAAAAAAAGgAgc2FsdEBub3RhdGlv
bnMuZGFydC1wZy5vcmdNNmxGRkJwOlZjclAvTD1iL0hFfS1lPDdeZm45TDErLgAA
4CMA/3fwbMBtc3fBkCHBZ2vXJ3ps3mB7jgEF9PuJjXNCkVCjAQCBxiTchHU33AAY
eQXXJiKf1gVbyBvmNyvT1V2loNycBg==
=a64Y
-----END PGP PRIVATE KEY BLOCK-----
''';

// Leo Martins, 1D02437E89EECE0CC006A5E9CCEEB4DE0C17E43D
const _leoSecret = '''
-----BEGIN PGP PRIVATE KEY BLOCK-----

xVgEaQhvEBYJKwYBBAHaRw8BAQdAchZvtt1kiUqq+CL4WDE4SE5b9nIoMISge5h6
WKxdyx8AAQD/CyaYp1p57gNVwF16kkzu36Kjn1nmJMHT8Gw9rbN5cxGLzStMZW8g
TWFydGlucyA8bGVvLm1hcnRpbnNAbm9ydGh3aW5kLmV4YW1wbGU+wsAYBBMWCgCK
BQJpCG8QFiEEHQJDfonuzgzABqXpzO603gwX5D0JEMzutN4MF+Q9AhsDBAsJCAcF
FQoJCAsEFgIBAAIeAQIZAQUJBaOagEMUAAAAAAAaACBzYWx0QG5vdGF0aW9ucy5k
YXJ0LXBnLm9yZztIVj0+QVd0PFlafTpRLWl9RGtILUBHL2ZufU1FNGp8AABqiAEA
9qcgVY9ekDyGvUVzMUlwuvRm5+MUgIJf+EgP8xckZtYA/RfZquaeIruNGydj7dIo
YFwHYQ6tSZtJZa4bJZwWQvgNx10EaQhvEBIKKwYBBAGXVQEFAQEHQMUG1GBsrOQV
FHGiXTh3G/AXM5YC2/ch0IlM9ngcQEckAwEIBwAA/1aC2WvLzuGei6W0FmeIEZJ/
zf17e04+sNk2GeknQYgIEUPCwAIEGBYKAHQFAmkIbxAWIQQdAkN+ie7ODMAGpenM
7rTeDBfkPQkQzO603gwX5D0FCQWjmoACGwxDFAAAAAAAGgAgc2FsdEBub3RhdGlv
bnMuZGFydC1wZy5vcmdHP2tfKG8uQi5NT3A3QEt0WV9XemFZYHhGUG5YUDxIMAAA
3SIBANoklApFXvsR+7t4L2fdLrm65aXiVLepcvbBQtaKHMKsAQDmScR4y+sRNljC
nbnReJWwUaqx7Vop2SCSvHHeK8mhAg==
=BxmG
-----END PGP PRIVATE KEY BLOCK-----
''';
