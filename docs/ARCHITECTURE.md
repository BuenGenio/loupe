# Architecture

```
app (UI, Riverpod, go_router)
 ├─ readable ─────────────┐
 ├─ expr_search ──────────┤
 └─ MailRepository  ◄─────┼── demo repository (app/lib/demo, fake data)
        ▲                 │
        └── mail_sync (LiveMailRepository: sync engine, offline queue, device rules)
              ├─ mail_sieve (rules: Sieve generation, ManageSieve client, rule runner)
              ├─ mail_store (drift + FTS5 + sqlite3mc)
              └─ TransportFactory ◄── mail_jmap CompositeTransportFactory (IMAP or JMAP by account)
                                       ├─ mail_imap (enough_mail; IMAP, SMTP, MIME, discovery, mbox)
                                       └─ mail_jmap (JMAP client and transport, EmailSubmission,
                                                     JMAP discovery, Sieve over JMAP)
mail_platform: CredentialStore (keychain), OAuth sign-in (AppAuth) and token refresh (HTTPS)
mail_crypto: OpenPGP (dart_pg, vendored in third_party/): keys, keyring,
             PGP/MIME reading and writing, Autocrypt; S/MIME (pure Dart on
             pointycastle): certificates, PKCS #12, CMS, chain validation;
             the app wraps loadContent with both and hands their composers
             to mail_imap
mail_calendar: iCalendar (RFC 5545) reading and writing, time zones (IANA database
               through the timezone package, Outlook's Windows names, VTIMEZONE),
               recurrences, iMIP replies; pure Dart, used by the app
mail_model: every type and interface above; no I/O, no dependencies
```

## Contracts

The packages are developed in parallel. These are the seams:

| Contract | Defined in | Implemented by | Used by |
|---|---|---|---|
| `MailRepository` | mail_model `src/repository.dart` | app demo repository; mail_sync `LiveMailRepository` | app |
| `MailingLists` (a list's forum threads by List-Id, muted threads) | mail_model `src/lists.dart` | app demo repository; mail_sync `LiveMailRepository` | app (`repository is MailingLists`) |
| `MailSubscriptions` (newsletters by sender and discussion lists by List-Id, read rates, the user's "Treat as…"), `groupSubscriptions`, `unsubscribeMethods`, `unsubscribeMessage`; `looksMachineMade` | mail_model `src/subscriptions.dart`, `src/bulk_names.dart` | app demo repository; mail_sync `LiveMailRepository` | app (`repository is MailSubscriptions`) |
| `MailTransport`, `MailSender`, `MessageComposer`, `TransportFactory` | mail_model `src/transport.dart` | mail_imap (IMAP, SMTP, the MIME composer); mail_jmap (JMAP, and `CompositeTransportFactory` for both) | mail_sync |
| `CredentialStore` | mail_model `src/transport.dart` | mail_platform | mail_sync (through the app) |
| `SignInRenewal` ("Sign in again" after a revoked OAuth grant), `SignInRequiredException` | mail_model `src/sign_in.dart` | mail_sync `LiveMailRepository` | app (`repository is SignInRenewal`); mail_platform throws the exception |
| `SearchExpr` (search syntax tree) | mail_model `src/search.dart` | expr_search (parser) | app, mail_store (SQL), mail_imap (IMAP), mail_sync |
| `parseQuery`, `formatQuery`, `describeTerm`, `suggest`, `matchesEmail`, `widenForServer`, `compileImap`, `compileGmailRaw`, `compileJmapFilter` | expr_search `lib/src/api.dart` | expr_search | app, mail_imap, mail_sync |
| `ReadableMessageView`, `ReaderSettings`, `showImageGallery`, `analyzeContent` (link and privacy findings), `unwrapRedirect`, `inspectHost` | readable `lib/src/api.dart` | readable | app |
| `Rule`, `RuleAction`, `MailRules` (`MailRepository.rules`) | mail_model `src/rules.dart` | app `DemoRules`; mail_sync `LiveRules` | app |
| `compileSieve`, `generateLoupeScript`, `parseLoupeScript`, `planInclude`, `SieveConnector`, `ServerRules`, `RuleRunner` | mail_sieve `lib/mail_sieve.dart` | mail_sieve (ManageSieve); mail_jmap `JmapSieveConnector` (RFC 9661) | mail_sync, app demo |
| `PgpBackend` (swappable OpenPGP engine), `Keyring`, `PgpMimeReader`, `PgpMessageComposer` (a `MessageComposer` around another), `OutgoingMessage.security` | mail_crypto `lib/mail_crypto.dart`, mail_model `src/outgoing.dart` | mail_crypto (`DartPgBackend`) | app (reader, compose, settings, live composer) |
| `OutgoingMessage.calendar` (`OutgoingCalendar`: an iCalendar object sent as the text's `text/calendar` alternative), `CalendarRecords` (what the device remembers about invitations) | mail_model `src/outgoing.dart`, `src/calendar_records.dart` | mail_imap `MimeMessageComposer`; mail_store + mail_sync `LiveMailRepository`, app demo repository | app (invitation card) |
| `Calendar`, `CalendarEvent`, `ZoneResolver`, `eventSpan`, `eventOccurrences`, `describeRule`, `buildReply`, `InvitationRecord` | mail_calendar `lib/mail_calendar.dart` | mail_calendar | app |
| `SmimeBackend` (swappable S/MIME engine), `SmimeStore`, `SmimeReader`, `checkTrust`, `planSmime`, `chooseTechnology`, `SmimeMessageComposer` (around the OpenPGP one), `OutgoingSecurity.technology` | mail_crypto `lib/mail_crypto.dart`, mail_model `src/outgoing.dart` | mail_crypto (`DartSmimeBackend`) | app (reader, compose, settings, live composer) |
| `SmimeKeyHandle`, `SmimePlatformKeys` (keys that stay in the platform's keystore) | mail_crypto `src/smime/key_handle.dart` | app (`KeyChainCertificates`, Android); mail_crypto (`SoftwareSmimeKeystore`, tests) | mail_crypto (CMS), app (reader, live composer) |

Rules:

- **Ids are deterministic** (`MailIds`): transports produce final local ids, so the store needs no mapping table.
  - IMAP email ids include the mailbox path, UIDVALIDITY and UID.
  - JMAP email ids include the mailbox path and the JMAP id (`jmapEmailIn`): one copy per mailbox (see JMAP below).
- **Keywords are lower-case JMAP keywords** (`$seen`, `$flagged`, …). The IMAP adapter maps `\Seen` and the other system flags to them.
- **Snooze lives on the server** ([snooze-convention.md](snooze-convention.md)): a top-level `Snoozed` folder and a
  `$snoozed-<UTC minutes>` keyword; mail_sync wakes due messages after every sync, so any client following the
  convention can wake them.
- **Search:** the app parses the query (expr_search) and passes a `SearchExpr` in a `SearchRequest`.
  - The store translates it to SQL/FTS5.
  - The transport compiles it for the server via expr_search and widens what the server can't do.
  - mail_sync post-filters server hits with `matchesEmail`.
- **Settings on the server:** `MailTransport.readDocuments`/`writeDocument` keep small app documents on the user's
  mail server (an IMAP METADATA annotation, else a message in the `Loupe Settings` folder). Smart Mailboxes use them;
  see [smart-mailboxes-format.md](smart-mailboxes-format.md).
- **Message bodies in the app** come from `contentLoaderProvider` (`ContentLoader.loadContent` and
  `loadAttachment`), not the repository directly: it decrypts and verifies OpenPGP and S/MIME mail,
  learns Autocrypt keys and collects S/MIME certificates. Decrypted attachments (both standards) have
  `pgp:` part ids.
- **Changing a contract:** edit mail_model (or the API file) in its own commit, run `dart analyze` on the whole workspace, and fix every user in the same change.

## S/MIME

Issue #21. Reading, certificates, signing and encrypting, next to OpenPGP and in the same places (content
loading, the header, compose, Settings › End-to-End Encryption).

- **Engine** (`DartSmimeBackend`, swappable through `SmimeBackend` like `PgpBackend`): pure Dart, so it runs in
  isolates and background work, and tests run without a device. Primitives come from pointycastle (MIT, the
  Bouncy Castle port, already in the tree under dart_pg): RSA, ECDSA, ECDH, AES (CBC, GCM), 3DES, RC2, the
  PKCS #12 and PBKDF2 key derivations. The ASN.1 (BER in, DER out), X.509, CMS and PKCS #12 structures are
  mail_crypto's own (`lib/src/smime`, about 2,400 lines): no maintained Dart package does CMS enveloping
  (`pkcs7` only signs, for PDFs; `basic_utils` only writes PKCS #12; `pkcs12_parser` had one release). A
  platform engine (iOS `CMSDecoder`) can come later behind the same interface; certificates and keys cross it as
  DER. Keys in Android's KeyChain are used through key handles (below), the CMS work staying in Dart.
- **Key handles** (`SmimeKeyHandle`, issue #26): a private key is in the app (`SmimePrivateKey`, PKCS #8) or stays
  in the platform's keystore (`SmimePlatformKey`, an alias). The backend does everything in Dart except what only
  the key can do: signing the signed attributes, decrypting a content key (RSA PKCS #1 v1.5 or OAEP), ECDH's
  shared secret. For a platform key it throws `SmimeKeyRequired` with a `SmimeKeyRequest` (plain data), the
  caller has the platform answer (`SmimePlatformKeys.perform`), and runs the same work again with the answer
  (`SmimePlatformKey.answers`, by request id). Keys in the app are tried first. Reading: `SmimeReader` reports
  the request (`SmimeMessageStatus.keyRequest`) and `SmimeService.read` answers and reads again (a round per
  layer). Sending: `SmimeMessageComposer.begin` composes up to the signature (`SmimeSignaturePending`, the inner
  composer's bytes kept, so the signed attributes are the same again), `finish` puts the signature in;
  `IsolateComposer.composeAsync` runs both steps in another isolate and the platform call in between. A
  signature from the platform is checked against the certificate before anything goes out; ECDH peers are
  checked on the curve before the platform sees them; a padding the platform refuses fails like a wrong key.
  `SoftwareSmimeKeystore` does the platform's part in Dart (the reference, and the tests' stand-in).
- **Certificates on the device** (Android): Settings › End-to-End Encryption › Use a Certificate from This
  Device… opens `KeyChain.choosePrivateKeyAlias` (certificates installed by device management or in Android's
  settings; picking grants Loupe the key). The store keeps the certificate, its chain and the alias
  (`SmimeOwnCertificate.deviceAlias`), never the key. `KeyChainChannel.kt` (the app's own channel
  `io.github.buengenio.loupe/keychain`, no plugin) does `getCertificateChain` and, with `getPrivateKey`,
  `Signature` (SHA-xxxwithRSA/ECDSA), `Cipher` (RSA/ECB/PKCS1Padding, OAEPPadding) and `KeyAgreement` (ECDH) on a
  worker thread. Only the app's engine has the channel: background work can't use these keys, so such mail is
  signed when it is queued (see "Signed when queued" below), and composing it in the background fails into the
  Outbox ("open Loupe"). iOS: not yet (`NoDeviceCertificates`; managed identities need an MDM profile installing
  them into a keychain access group shared with Loupe, see [ios.md](ios.md)).
- **Keys and certificates** (`SmimeStore`, keychain entries `loupe.smime.*` next to the OpenPGP keyring): the
  user's certificates with their CA chain, each private key in an entry of its own (PKCS #8, protected by the
  keychain: the PKCS #12 password just unlocks the import, as on Android and in Thunderbird without a primary
  password); correspondents' certificates, collected from good signatures by the sender (not from
  drafts or junk) or imported; the authorities the user trusts; per-address settings (the certificate,
  "Prefer S/MIME"). PKCS #12 import reads OpenSSL 3's defaults (PBES2 with AES), the legacy algorithms of
  older Windows exports (3DES, RC2-40, SHA-1 MAC) and PBMAC1.
- **Passphrases** (optional, off by default; #26): the certificate's screen sets, changes or removes one. The key
  entry then holds the PKCS #8 key encrypted with AES-256-GCM (bound to the certificate's fingerprint as
  associated data) under a key from Argon2id (`key_protection.dart`, a JSON entry carrying its cost; on top of
  the keychain). Argon2id comes from pointycastle (maintained, pure Dart, checked against RFC 9106's test
  vector) with RFC 9106's choice for devices with little memory: 64 MiB, 3 passes, 4 lanes, about a second
  here and a few on a phone, off the UI isolate. PBKDF2-SHA256 was the fallback; it resists GPUs less, and
  pointycastle's takes six seconds for 600,000 iterations. Unlocked keys follow OpenPGP's rules
  (`StoreSmimeKeys`): Remember Passphrases keeps them until Loupe closes, otherwise each is locked two minutes
  after its last use; Lock Keys Now locks both. Reading mail encrypted to a locked key asks for the passphrase
  (`SmimeService.unlock`, once however many wait; cancelled, the message says the certificate is locked);
  Send asks before the message is queued, so it is signed then (see "Signed when queued"); the Outbox asks
  before Send Now, Reschedule or the Retry of mail that waited. Background work never has these keys.
- **Trust** (`checkTrust`): a chain through the message's and known certificates to a trusted root, every
  signature checked, then validity (at the signing time for signatures), CA flags, path length, rfc822 name
  constraints, unknown critical extensions, key usage (digitalSignature for signing; keyEncipherment for RSA or
  keyAgreement for EC recipients; emailProtection) and the address in the SAN or the subject.
  - Roots: Mozilla's, with the email trust bit, as Thunderbird uses them (`mozilla_roots.dart`, generated from
    NSS's certdata.txt by `tool/update_mozilla_roots.dart`), plus certificates the user trusts (a company CA,
    offered when importing a .p12 that came with one, or a single certificate). Not the platform store:
    Android's holds TLS roots without email trust bits, and isn't readable from Dart without a plugin.
  - Revocation isn't part of the trust check (see Revocation below: opt-in, asynchronous). Policies aren't
    processed (as most mail clients); SHA-1 certificates aren't accepted.
- **Revocation** (opt-in, off by default; #26; `revocation.dart`, the app's `smime_revocation.dart`): Settings ›
  End-to-End Encryption › Check Certificate Revocation Online. It is a network request outside the mail protocols
  when signed mail is read, telling the CA who reads whose mail and when; the footer says so. The signer's
  certificate is checked with OCSP (RFC 6960 as RFC 5019 profiles it: a SHA-1 CertID, no nonce, POST) at its
  authorityInfoAccess responder, or, when it names none, with its issuer's complete CRL (cRLDistributionPoints
  without reasons or another issuer); the issuer is the one the trust check found. Only valid signatures by
  certificates that chain to a trusted root are checked: any other certificate (spam's) could name a server of its
  own, which would learn when the message is opened. `SmimeRevocationChecker` runs
  one check per certificate however many ask, after the message is shown (`signerRevocationProvider`): the header
  turns to "Signed by … · certificate revoked" (no ✓) when the answer comes, and the sheet says what was asked,
  when, and why there is no answer. Answers are kept until their nextUpdate (an hour without one, ten minutes for
  no answer) in the keychain (`loupe.smime.revocation`). Strict limits: 5 s to connect, 10 s per request, 15 s per
  check, 64 KB per OCSP response and 16 MB per CRL (parsed off the UI isolate), redirects for CRLs only.
  Responses are hostile input, read by the bounded ASN.1 reader: the responder must be the issuer or a
  certificate the issuer made for OCSP signing (extendedKeyUsage, valid, signed by it), every signature checked
  (SHA-1 accepted for responses, which leave no room for a collision; not MD5 or RSA under 2048 bits), the answer
  about exactly this CertID, within thisUpdate and nextUpdate (5 minutes of skew), no unknown critical extension;
  a CRL must be the issuer's (name, cRLSign, signature), complete (no delta, no partition), and current. The
  fuzzer covers both parsers (`ocsp`, `crl` targets). The revocation time isn't compared with the backdatable
  signing time: a revoked certificate is shown as revoked.
- **Demo mode** (`demo/demo_smime.dart`): the Northwind demo CA (trusted), Sam's certificate with its key, and in
  the Work inbox a signed message, a signed and encrypted one with a protected subject, and one signed with a
  certificate the CA revoked, all written by `SmimeMessageComposer` when first opened. Revocation answers come from
  OCSP responses made with the demo CA in advance (`DemoRevocationFetcher`); the demo never goes online. Keys and
  certificates were made with OpenSSL for the demo (EC P-256).
- **Hostile input** (reviewed in issue #26): every parse ends in `Asn1Exception` or `SmimeException`, never
  another error, and bounded work: nesting 48 deep, INTEGERs of 2049 octets, 32 certificates and 16 signers
  per SignedData, 1000 recipients per envelope, 64 signature checks per path search, RSA keys of 2048 to 16384
  bits with exponents of at most 64 bits, PKCS #12 derivations of 1,000,000 iterations (3,000,000 per file).
  Primitives are strict: one encoding per OID, times by their type's format, PKCS #1 v1.5 signatures compared
  as whole encodings, EC points on their curve. A multipart/signed shows exactly its verified first part (two
  parts, or the signature is bad); remote content of CBC-decrypted mail loads only when asked for (EFAIL). The
  mutation fuzzer (`test/smime/fuzz_harness.dart`, long runs with `tool/fuzz_smime.dart`) covers each parser.
- **Reading** (`SmimeReader`): `application/pkcs7-mime` (enveloped, authEnveloped, opaque signed; also without
  `smime-type` or as an octet-stream `.p7m`) and `multipart/signed` with `application/(x-)pkcs7-signature`,
  nested as Thunderbird (multipart/signed inside) and Outlook (opaque inside) send them. Decryption: RSA
  (PKCS #1 v1.5, OAEP) and ECDH (X9.63 KDF with SHA-1 to SHA-512, AES key wrap); AES-CBC, AES-GCM, 3DES, RC2.
  Thunderbird's rules, checked against its NSS-made test messages: SHA-1 signatures aren't accepted; a
  signature around encrypted data doesn't count; a signature's embedded content must be the signed part; a
  signing time more than an hour from the Date header isn't good. The header says "Encrypted (S/MIME)" and
  "Signed by Alice ✓ (Issuer)", or what is wrong; the sheet can trust the issuing CA after showing its
  fingerprint. A key that is locked, or on the device and unavailable, says "Encrypted (S/MIME) · locked" and why.
- **Sending** (`SmimeMessageComposer` around `PgpMessageComposer` around `MimeMessageComposer`): signed as
  multipart/signed (SHA-256, RSA PKCS #1 v1.5 or ECDSA) carrying the certificate, its intermediates, the
  SMIMECapabilities and which certificate to encrypt to (RFC 8551's attribute and Outlook's). Encrypted: signed
  first, then EnvelopedData to every recipient and the sender with AES-256-CBC, which Outlook, Apple Mail and
  Thunderbird all read; AuthEnvelopedData (AES-256-GCM) only when every recipient's signed mail announced
  AES-GCM. RSA recipients get the key with PKCS #1 v1.5 (OAEP isn't read everywhere), EC recipients by
  ephemeral-static ECDH (SHA-256 KDF, AES-256 wrap). Bcc recipients get copies of their own (see below); drafts
  are encrypted to the sender only.
- **Protected headers** (#26; `mime/header_protection.dart`): RFC 9788 (the published
  draft-ietf-lamps-header-protection), not RFC 7508's signed attribute, which no client reads. The message's
  header fields are copied into the cryptographic payload (signed, and encrypted), marked `hp="cipher"` (or
  `hp="clear"` for signed-only mail, whose Subject and From the signature then covers) and also
  `protected-headers="v1"`, the OpenPGP scheme Thunderbird and Loupe's OpenPGP use. Encrypted mail goes out with
  `Subject: ...`, the outer fields recorded inside as `HP-Outer`. Thunderbird reads protected headers only for
  OpenPGP (its RFC 9788 support is bug 1991625) and Outlook not at all, so for them the main body parts begin with a
  legacy display, `Subject: …` and a blank line (an HTML `div.header-protection-legacy-display`), marked
  `hp-legacy-display="1"` (base64 UTF-8 text); Loupe hides it in decrypted mail (`contentFromEntity`
  `hideLegacyDisplay`, OpenPGP mail too) and shows the inner Subject (`SmimeMessageStatus.protectedHeaders`).
  Messages from other clients without protected headers read as before.
- **Choosing the standard** (`chooseTechnology`): the address's preference (OpenPGP unless "Prefer S/MIME"),
  unless only the other one has a key or trusted certificate for every recipient, or the message replies to
  mail encrypted with the other. Compose shows which, and switches when both are set up. The sending settings
  (Encrypt Automatically, Always Encrypt, Sign Unencrypted Mail) apply to both.

## Encrypted mail (both standards)

Issue #24, after OpenPGP (#20) and S/MIME (#21).

- **Bcc** (`OutgoingMessage.deliveries`): an encrypted message names the keys it is encrypted to (OpenPGP's PKESK
  key ids, S/MIME's RecipientInfos), and its Autocrypt-Gossip names addresses, so one message for everyone would
  show every recipient who was in Bcc. Encrypted mail with Bcc recipients goes out as one copy encrypted to To, Cc
  and the sender, sent to To and Cc and filed in Sent, and for each Bcc recipient a copy encrypted to them and the
  sender only (`OutgoingMessage.bccCopy`, `encryptionRecipients`), sent to them alone. Every copy has the same
  headers (To, Cc, Message-ID; no Bcc header, as plain mail), and the copies are all made before any goes out.
  A copy that fails after another went out leaves its recipient in the Outbox like a refused recipient. KMail
  does the same; Thunderbird instead warns that Bcc recipients aren't hidden. Signed-only mail stays one message.
- **What shows as signed** is exactly what the signature covers, for both standards. A PGP/MIME `multipart/signed`
  shows its signed first part as `PgpMimeReader` parsed it from the raw message, never the server's view of the
  whole message; RFC 3156 allows the signed part and the signature and nothing else, so another part next to them
  makes the signature bad ("parts the signature doesn't cover"), at the top or inside decrypted content. A
  `multipart/signed` wrapped in other content isn't verified, so nothing shows as signed. Inline PGP shows the
  signed (or decrypted) text first and every other text of its part below an "Unsigned content" line
  (`outsideMarker`), so nothing outside the block can pass for part of it; that text, or other parts of the message
  (an HTML alternative, attachments), make it "Signed in part" (no ✓).
- **Protected subjects** (OpenPGP and S/MIME send the real subject inside, `...` outside): summaries say whether a message is
  encrypted (`EmailSummary.isEncrypted`, from its BODYSTRUCTURE; schema version 6, `emails.is_encrypted`). Once
  `ContentLoader` decrypted a message, its protected subject is kept in the encrypted store
  (`DecryptedMail.rememberProtectedSubject`, `emails.protected_subject`), for the message and its copies (same
  account, Message-ID, size and outer subject; copies synced later inherit it). Summaries then carry it as their
  subject (`hasDecryptedSubject`), so the list, search (the full-text index has it) and replies show it; syncs
  never overwrite it. Notifications say "Encrypted message" for encrypted mail unless its subject was decrypted
  on the device, and nothing more with Hide Content.
  - Settings › End-to-End Encryption › On This Device › Decrypt Subjects in the Background (off by default):
    `SubjectDecryptor` decrypts the subjects of encrypted mail nobody opened yet, with keys stored without a
    passphrase only (it never asks; S/MIME keys kept in the app, not on the device), messages up to 1 MB (the whole
    message is downloaded). Background
    work does it for new mail before notifying (`NewMailCheck.subjects`, at most 15 s); the app, while it runs, for
    the newest 100 messages of the inboxes (`ProtectedSubjectsWatcher`, off the UI isolate).
- **Signed when queued**: signed or encrypted mail needs the key unlocked, and background work only has keys
  stored without a passphrase. So `LiveMailRepository.send` composes it at once, while the user is there (compose
  unlocked the key), dated for when it goes out (the end of the undo window, the scheduled time), and keeps the
  copies in the Outbox (`outbox_copies`, schema version 6; `OutboxItem.composedFor`); whichever process sends it
  sends them as they are, with the same Message-ID on every attempt. Rescheduling composes it again for the new
  time, Send Now before that time for now (a Retry keeps them); when the key is locked then, the copies are
  dropped and it is composed as it goes out. Taking it back to edit (or Undo) deletes them with the entry. The
  Outbox asks for the passphrase before Send Now, Reschedule or the Retry of a message that waited for the key.
  Plain mail is composed as it goes out, as before.
- **Searching encrypted mail**: by default encrypted messages are found by their headers only (sender,
  recipients, the protected subject once known); the cached body of an encrypted message is its encrypted form.
  Settings › End-to-End Encryption › Index Decrypted Messages for Search (off by default) puts the text (and
  attachment names) of each message `ContentLoader` decrypts, OpenPGP or S/MIME, into the full-text index
  (`DecryptedMail.indexDecryptedText`): the `decrypted_texts` table (schema version 6, up to 64 KB per message,
  deleted with the message) stands in for the cached body in `email_fts`. Background subject decryption indexes
  the text too while both are on. Turning the setting off deletes every row (`forgetDecryptedText`); the index
  follows by triggers. The database is encrypted (SQLite3MultipleCiphers), so this keeps decrypted text only
  where the protected subjects and every plain message already are.

## Encrypted mail: speed

OpenPGP and S/MIME are pure Dart (dart_pg and mail_crypto's CMS on pointycastle), so their work stays off the UI
isolate: reading (`OpenPgpService.read`, `SmimeService.read`: decrypting, verifying, MIME) and unlocking keys run
through `pgpRunnerProvider` (`Isolate.run`); composing goes through `IsolateComposer.composeAsync`
(`AsyncMessageComposer`), which hands a snapshot of the keys to another isolate, when a message is queued, sent
or saved as a draft; subjects decrypted in the background too. Background isolates (sync, Instant Delivery) do
their own work inline.

`packages/mail_crypto/tool/benchmark.dart` times it (`dart compile exe`, as the app's release build is AOT). On
the development machine (an Apple M1 Max under Asahi Linux, AOT; a phone is several times slower), before → after the
dart_pg fixes of 2.1.0+loupe.2:

| | before | after |
|---|---|---|
| Unlock a key exported by Thunderbird (Ed25519, S2K SHA-256 × 62 MiB, two key packets) | 5.4 s | 1.2 s |
| Unlock a GnuPG 2.4 key (S2K SHA-1 × 62 MiB) | 2.6 s | 0.8 s |
| Unlock a key made by Loupe | 1.4 s | 0.3 s |
| Read (decrypt + verify) an 8 KB message | 22 ms | 18 ms |
| … with 100 KB attached | 154 ms | 66 ms |
| … with 1 MB attached | 15.5 s | 0.5 s |
| … with 5 MB attached | minutes | 2.4 s |
| Compose signed + encrypted with 1 MB attached | 14.6 s | 0.4 s |
| Verify a multipart/signed with 1 MB attached | 0.52 s | 0.08 s |

Unlocking stays near a second: the iteration count Thunderbird and GnuPG choose is meant to take that long.

## JMAP

Issue #17. JMAP accounts (`ServerProtocol.jmap`; Stalwart first, then Fastmail and Cyrus) next to IMAP ones, in
mail_jmap. `CompositeTransportFactory` picks the transport and sender by `account.incoming.protocol`; both protocols
share the MIME composer (with OpenPGP and S/MIME around it in the app), the body and attachment selection on a
`BodyNode` tree, the documents format and the snooze convention (mail_imap's `lib/mime.dart`).

- **Client** (`JmapClient`, about 400 lines on package:http) instead of jmap-dart-client: that package needs Flutter,
  pins Dart < 3, dio and a build_runner model layer, and has neither EventSource nor import helpers. The session comes
  from `https://<host>[:port]/.well-known/jmap` (redirects followed, never to plain HTTP; `/jmap/session` when the
  well-known URL is missing); `ServerConfig.host`/`port` name that host, `security: none` means plain HTTP (local
  servers only). Passwords go as Basic credentials and, refused, once as a bearer token (Fastmail API tokens,
  Stalwart API keys; `fmu1-…` tokens go as bearer at once); OAuth tokens as bearer, refreshed once when refused.
  Certificates are pinned by SHA-256 like IMAP's. Errors keep their JMAP type (`JmapException`) and map to
  `MailErrorKind`s.
- **Copies, one per mailbox.** A JMAP email can be in several mailboxes (Fastmail labels, or an IMAP client's COPY on
  Stalwart). The store keeps one row per (email, mailbox), as for IMAP folders and Gmail labels, with the id
  `<account>|<path>|jmap|<id>`. So everything built on IMAP semantics holds: a mailbox's sync reports what is in it,
  moving a copy takes the email out of that mailbox only (a `mailboxIds/<source>: null` patch) and gives it a new id,
  deleting a copy for good destroys the email only when no other mailbox has it, a search hit in all mail shows its
  Inbox copy (else a folder's, Archive, Sent, Drafts, then Junk and Trash). Keywords belong to the email, so a
  change shows on every copy at its mailbox's next sync. Primary-mailbox semantics (one row per email) were
  rejected: a mailbox's sync and another's would move or delete each other's row.
- **Mailbox paths** are a mailbox's name and its parents' joined with `/` (`Inbox`, `Archive/2024`), the delimiter
  Stalwart, Fastmail and Cyrus show over IMAP: the Snoozed and Loupe Settings folders, Smart Mailbox scopes and
  Sieve's `fileinto` work with names. The transport maps paths to JMAP ids. Renaming a mailbox on the server makes it
  a new one here, as over IMAP.
- **Sync.** `Email/changes` is per account, so each mailbox's `MailboxSyncState` holds the account's `Email` state at
  its last sync and the JMAP ids of its window. The first sync is `Email/query` (in the mailbox, newest `receivedAt`
  first, the initial window) and `Email/get` of the list-row properties (threadId, keywords, mailboxIds, preview, the
  body structure for attachments and encryption, the threading and list headers fetched raw), taking the state
  before the query. Later syncs follow `Email/changes` (several rounds while `hasMoreChanges`) and fetch `mailboxIds`
  and `keywords` of what changed: new in the mailbox → added, gone or moved out → vanished, the rest → keywords.
  `cannotCalculateChanges` (or a state the server can't read) checks the window against the server instead, keeping
  stored rows and cached bodies; no reset. `Mailbox/changes` spares listing mailboxes when only counts changed. Older
  pages anchor on the oldest known email. JMAP threadIds are kept (`<account>|jmthread|<id>`).
- **Content** comes from `Email/get` with body values; parts without one are downloaded (blob) and decoded, inline
  `cid:` images are downloaded, and `Attachment.partId` is the part's blob id. The raw message is the email's blob.
- **Sending** (`JmapSender`): the composed message is uploaded, imported into Drafts and submitted
  (`EmailSubmission/set`) from the identity matching the envelope sender. `MailSender.send(fileInSent: true)` marks
  the copy for Sent: it moves there as it goes out (`onSuccessUpdateEmail`: Sent, `$seen`, no `$draft`) and the
  receipt says `filed`, so mail_sync appends no copy and syncs Sent instead (as for Gmail). Other copies (encrypted
  Bcc copies) are destroyed once sent. `invalidRecipients` leaves those recipients in the Outbox while the others get
  the message.
- **Documents** (Smart Mailboxes): JMAP has no METADATA, so the documents are messages in the `Loupe Settings`
  mailbox, in the IMAP format; an account used over both protocols shares them. (Stalwart's FileNode storage would be
  JMAP-native, but Stalwart-only and invisible to IMAP clients.)
- **Snooze** works unchanged: `$snoozed-…` keywords are JMAP keywords, and `createMailbox('Snoozed')` makes the
  mailbox (an existing one is fine). `canStoreKeywords` is always true.
- **Push.** `watch` opens the session's EventSource (`types=Email`, a ping every 60 s; silence for three pings ends
  the stream, and the sync engine reconnects) and reports `Email` state changes; without an EventSource URL it polls
  the state every minute. `supportsIdle` is true for JMAP, so the sync engine watches the Inbox as with IDLE.
- **Discovery** (`JmapDiscoverer`) runs before IMAP's: Fastmail addresses (and custom domains IMAP discovery places
  at Fastmail) get `api.fastmail.com` and a note asking for an API token; otherwise
  `https://<domain>/.well-known/jmap`, probed while IMAP discovery runs, then the IMAP host IMAP discovery found
  (Stalwart publishes IMAP in autoconfig and serves JMAP on the same host). No credentials, HTTPS only, no SRV lookup
  (it would need a DNS client and tell resolvers which provider the user signs in to).
- **Setup:** manual settings switch the incoming server between IMAP and JMAP (the server may be a URL; no SMTP
  form for JMAP). Settings › account shows `JMAP · host:port`.
- **Server rules** go over JMAP (`JmapSieveConnector`, RFC 9661 `SieveScript`) when the server offers it, as Stalwart
  does; Roost's gateway forwards no ManageSieve port. Otherwise, and for IMAP accounts, ManageSieve on the account's
  host.
- **No schema change:** JMAP rows, states and documents fit the existing tables (the store is still at version 7).
- **Tests:** unit tests against a scripted server answering with exchanges recorded from Stalwart 0.16
  (`test/fixtures/stalwart/`); integration tests (tag `integration`) against a throwaway local Stalwart
  (`tool/test-servers/stalwart/stalwart.dart`), for the transport and for the whole live repository.
- **Not yet:** OAuth for Fastmail (the client takes bearer tokens; the sign-in flow is missing), JMAP identities in
  Loupe's identity list (sending matches them by address), shared accounts and mailboxes, push while the app is in
  the background (a push relay with JMAP PushSubscription, PLAN §7), WebSocket (RFC 8887).

## Background work (Android)

Besides the app, three kinds of isolates open the database, each through `openLiveStore` (`app/lib/data/live.dart`):

| Who | When | Entry point |
|---|---|---|
| Periodic sync | WorkManager, every 15 minutes, and one-off wake-ups (`BackgroundScheduler`) | `backgroundTaskDispatcher` |
| Notification buttons | Archive, Mark as Read (flutter_local_notifications' background isolate) | `onNotificationAction` |
| Instant Delivery | Experimental `specialUse` foreground service holding IMAP IDLE | `startInstantDelivery` |

Rules (`app/lib/platform/`):

- **One syncer at a time.** Whoever syncs keeps a lease file fresh (`SyncLeases`). The app always wins: background work starts only without the app's lease and stops when the app comes back; the app waits briefly for it. A lease goes stale after 45 s, so a dead process never blocks the others.
- **Hand work to whoever syncs.** A notification button goes to the app's main isolate, then to Instant Delivery (`ForegroundBridge`), and only otherwise opens the database itself.
- **A message is sent by whoever claimed it.** Any process may send the outbox; `claimOutbox` marks a due entry as sending with the time of the claim, and the others leave it alone until the claim is older than `SyncConfig.sendClaimTimeout` (15 min, much longer than a send), when it counts as left by a process that died and is queued again. Every attempt uses the same Message-ID.
- **A refusal for good waits for Retry.** The SMTP sender throws `PermanentMailException` for 5xx replies (and a login refused after an OAuth refresh); the entry is marked failed and *held* (`outbox_items.held`), which no process claims until the user's Retry (`sendNow`). 4xx replies, network errors and timeouts back off and retry. When the server refuses some recipients but takes others, the others get the message and the refused ones stay in the Outbox as a message of their own (held unless a refusal was temporary).
- **Read, then write, in one transaction.** Every connection waits up to 10 s for another one's lock (busy timeout),
  and store transactions take the write lock when they begin (`BEGIN IMMEDIATE`), so a transaction that reads and then
  writes never fails with `SQLITE_BUSY_SNAPSHOT` because another process wrote in between. Decisions made from a read
  belong in the same transaction as their write: outbox claims, the rules watermark (`advanceRuleWatermark` moves it
  only from where it was read), device-only snoozes, the Snoozed folder, and schema upgrades (two processes opening
  the file after an update migrate it once). Never wait for the network inside one.
- **The database key is never replaced.** A new key is made only when there is no database file; a keychain that can't give the key back shows the recovery screen (`DatabaseKeyUnavailable`), and only the user's explicit reset deletes the database.
- **New mail is what passed a watermark.** `detectNewMail` remembers the newest arrival per inbox (and VIP mail elsewhere) in `new_mail.json`; a list seen for the first time only sets its watermark. The app moves the watermarks silently when it goes to the background.

## Mailing lists

- **Headers:** every summary fetch asks for List-Id, List-Post, List-Unsubscribe and List-Unsubscribe-Post next to
  the threading headers; `EmailSummary` carries them (the List-Id as identifier and phrase, the others as sent) and
  mail_model parses them (`parseListId`, `parseListUris`, `listPostAddress`, `isOneClickUnsubscribe`).
- **Store:** schema version 3 added the columns (index on `list_id`), `muted_threads`, and `stale_headers` on sync
  states. The upgrade marks every synced mailbox, and the sync engine fetches its stored summaries once more to fill
  the new fields. It goes newest first in batches of 200 and saves how far it got with each one
  (`headers_done_at`/`_seq`, schema version 5), so a refetch cut short goes on where it stopped.
- **Mute is local to the device** (the `muted_threads` table), not a `$muted` keyword: custom keywords are lost on
  servers without `\*` in PERMANENTFLAGS, no other client honours one, and a per-thread state would still need every
  new message tagged. Muting marks the conversation read; later mail of a muted thread is marked read (locally and on
  the server) in the transaction that stores it, so it never shows unread or notifies (notifications skip read mail),
  like Thunderbird's ignored threads. Muted threads leave the mailing-list view; mailboxes still show them.
- **Which lists there are** is Subscriptions' business: a list people write to is a discussion there (see below),
  opening the forum-style view (`watchListThreads`, by List-Id); a newsletter that comes with a List-Id is a
  newsletter.
- **Patches:** readable recognises `git format-patch` diffs, diffstats and quoted hunks in text bodies
  (`pipeline/patch.dart`) and renders them as diffs (`render/diff.dart`).

## Subscriptions: newsletters and discussion lists

Mailboxes › Subscriptions (a row next to Unread, Snoozed and Outbox, counting unread discussion mail) has two tabs.
Newsletters ranks newsletters and other bulk mail by how much of it goes unread: the unsubscribe centre. Discussions
lists the mailing lists people write to, most recent activity first; each opens forum style, and the user can pin
it to Mailboxes (a Lists section, while one is pinned) or open its mail as plain text in Mono (Technical Lists).
Everything is counted on the device; services that do this elsewhere read the mail on their servers.

- **Bulk mail** (`subscriptionKeyOf`, a message's *source*): a List-Id, a List-Unsubscribe header, or a Message-ID of
  a bulk-mail service (`bulkMessageIdDomains`: Mailchimp, SendGrid, Amazon SES…). Sources are `list:<List-Id>`, else
  `from:<address>`. A sender found only by its Message-ID needs two messages. `Precedence: bulk` isn't fetched (such
  mail nearly always has List-Unsubscribe too), and when a message was opened isn't known: the read rate (`$seen`)
  stands in for it.
- **Kinds** (`SubscriptionSource.autoKind`, `isDiscussionList`): a list is a *discussion* when it takes posts
  (List-Post has a `mailto:`, not `NO`) and two addresses wrote to it in the year before its newest message, or its
  mail answers its own (In-Reply-To, else the last References entry, is the Message-ID of a stored message with the
  same List-Id). Everything else is a *newsletter*. The user overrides it per List-Id ("Treat as Newsletter",
  "Treat as Discussion": `MailSubscriptions.setListKind`, the store's `list_kinds`, local to the device).
- **Grouping** (`groupSubscriptions`): a discussion is one subscription, `list:<List-Id>`. Newsletters go under their
  sender (`newsletterKeyOf`): `from:` the address, lower-cased without a `+tag`; or, when the address changes with
  every campaign (`isPerCampaignAddress`: a machine-made local part or subdomain, a VERP `=`), `sender:` the
  registrable domain and display name. So a sender's per-campaign List-Ids and its mail without one are one
  newsletter; a newsletter list with several senders stays one of its own. `Subscription.sourceKeys` lists the sources.
- **Names** (`subscriptionName`) are never machine-made (`looksMachineMade`: bulk-mail services' hosts such as
  `*.sparkpostmail.com`, `*.mcsv.net`, `*.list-manage.com`, `*.ct.sendgrid.net`, `*.broadcast`, `*.sendsay`,
  Mailchimp's `<hex>mc list`; base64; 12 or more hex digits; no letters; long numbers): the List-Id phrase; for a
  newsletter, else the newest From display name; for a discussion, else the List-Id or the list's address (or its one
  sender's name); else the sender's registrable domain. The second line is the sender's address (its domain when the
  address changes), or a discussion's address.
- **Counting** (`subscriptionSources` is the reference): copies in several mailboxes count once; Junk, Sent, Drafts
  and the user's own addresses are left out (Trash counts: deleting unread is not reading; but unread mail that is
  only in Trash isn't "unread" for a discussion). Messages a month and the read rate use the last 90 days (the read
  rate over all mail when fewer than three came then). The ranking is unread mail a month.
- **Store** (schema version 5; the classification's inputs since version 7): `emails.sub_key` is each message's source
  (a generated column, indexed where set); `subscription_messages` (one row per bulk message, copies merged) and
  `subscription_details` (per source: mailboxes, senders, the newest name, List-Post and List-Unsubscribe, the posters
  of the last year, replies within the list) hold them. Triggers on `emails`, `mailboxes` and `accounts` mark the
  messages a change touches (any process's), and `MailStore.watchSubscriptions` redoes only those, and their sources,
  before it reads; Dart then fills in what SQL can't (`auto_kind`, the newsletter key, whether names are human), so the
  sources of one newsletter are added up in SQL, and `groupSubscriptions` gets about one row per subscription. The
  counts of the last 90 days are summed at read time. At 40,000 messages (450 subscriptions, a sender with an address
  per campaign among them) opening the screen takes about 12 ms here, after 200 messages were read about 45 ms; the
  first time after the upgrade groups everything once (about 200 ms). Version 7 made the cache's tables again and
  rebuilds them on the next read.
- **Records** stay on the device (SharedPreferences `subscriptions.unsubscribed`: date and method, by subscription
  key; records under a source's key from before move to its subscription). Mail arriving more than seven days later
  marks the row "Still sending". Pins are `subscriptions.pinnedLists` (List-Ids), the last tab `subscriptions.tab`.
- **Links:** `/subscriptions?tab=`; `/subscriptions/<key>` of a source leads to its subscription, a discussion's to its
  forum view (`/mailing-list/<List-Id>`); `/mailing-lists` to the Discussions tab.
- **Unsubscribing** (`unsubscribeMethods`), in this order:
  1. RFC 8058 one-click (List-Unsubscribe-Post and an `https` URI): a POST of exactly `List-Unsubscribe=One-Click`
     (`application/x-www-form-urlencoded`) without cookies, user agent, referrer or languages; 2xx or 303 means done;
     other redirects are followed with the same POST on the same host only (three at most); 20 s timeout; the answer's
     page isn't read. IP addresses and local names (`.local`, `localhost`…) are refused. Besides account setup
     (autoconfig, OAuth), it is the only request Loupe makes outside the mail protocols, and only when the user taps
     Unsubscribe; the first time, the confirmation explains it. The demo pretends.
  2. `mailto:` through the normal send path (`unsubscribeMessage`): from the identity the mail was addressed to, to
     the URI's recipients only (its `cc=`/`bcc=` are ignored), with its subject and body (RFC 6068: `+` is a plus).
  3. The web page, in the in-app browser, after showing its host (homographs flagged).
- **Follow-ups** reuse what exists: Archive All moves the Inbox copies through `MailActions` (with Undo); Create Rule
  opens the rule editor with the condition (`from:` the sender, its name and domain when the address changes, or the
  List-Id of a list with several senders), the name and Move to Archive filled in; Block Sender saves a device rule
  that moves to Junk (rules made for one of its List-Ids before count as blocking it).

## Calendar invitations

Issue #27. An invitation shows as a card above the message body (`InvitationCard`, `app/lib/features/calendar/`).

- **Which part:** the invitation's `text/calendar` alternative (iMIP, RFC 6047: it carries the method), else an
  `.ics` file attached, up to 1 MB (`invitationPart`). IMAP lists the alternative among the attachments (it was
  plumbing before; no paperclip for it), and so does `contentFromEntity` for decrypted or verified mail; the
  attachment list leaves it out. Schema version 8 drops cached contents of invitations from before (Outlook's
  `Content-Class: …calendarmessage`), so they are fetched again.
- **Reading** (mail_calendar, pure Dart): content lines unfolded and folded at 75 octets, parameters and TEXT
  escapes; a lenient, bounded component parser (nesting 12, 5,000 components, 50,000 properties); VALARM and
  X-ALT-DESC stay out. Times: TZIDs go to the IANA database (the `timezone` package's full data, ~450 KB,
  loaded on first use), also with Lightning's path prefix and Outlook's Windows names and display names (CLDR's
  windowsZones, generated by `tool/update_windows_zones.dart`); else the calendar's VTIMEZONE rules; else the
  time shows as written ("time zone unknown"). Skipped and repeated wall-clock times follow RFC 5545 (the offset
  before the gap; the first of the two). RRULE expansion covers RFC 5545's examples, with bounded work.
- **The card:** title; when, in local time, with the event's own times and zone when its offset differs; the
  recurrence in words and the next occurrence; the location with Map (geo: on Android, Apple Maps on iOS); the
  meeting link (CONFERENCE, Google's and Microsoft's properties, known hosts in LOCATION and DESCRIPTION) with
  Join after showing the host; the organizer; the guests, collapsed, with their answers; your answer. Replies
  (METHOD:REPLY) show "Wren declined: “comment”", proposals and refresh requests a line each. Likely phishing
  turns Map, Join and the answers off, like links.
- **Updates and cancellations** (`InvitationRecord`, through `CalendarRecords` in the encrypted store's
  `calendar_records`, by UID and RECURRENCE-ID): the latest version seen and the one before it, so an update
  says what changed (time, location, title, repeat) and the original shows as out of date; cancellations; the
  user's answer, to which version. Only shown invitations are recorded; an update whose original was never shown
  just says "Updated invitation".
- **Answering** (`buildInvitationReply`, `sendInvitationReply`): only on a tap, never on its own. An iTIP REPLY
  (one ATTENDEE with PARTSTAT, the UID, SEQUENCE and RECURRENCE-ID, DTSTAMP, an optional COMMENT, DTSTART/DTEND
  and the VTIMEZONEs they use) to the organizer, from the identity the invitation names as the attendee
  (`IdentitySelection` with the attendee as the recipient, so plus-addresses and unsaved aliases answer as
  themselves), as `multipart/alternative`: a text ("Sam has accepted: …", in the event's zone) and
  `text/calendar; method=REPLY; charset=UTF-8`. It goes through the Outbox with the Undo delay, protected as
  compose would protect it by default (`ComposeSecurityController`: usually plain, as organizers seldom have a
  key); signed or encrypted, the alternative is what OpenPGP and S/MIME wrap. Undo takes it back and restores
  the record. Requests and additions are answered; a calendar file attached by someone other than the
  organizer only goes to the phone's calendar.
- **Add to Calendar** (`DeviceCalendar`, a seam; `add_2_calendar`, MIT): Android's insert intent (no calendar
  permission; the manifest declares the INSERT query), iOS's EventKit sheet (no access asked from iOS 17); the
  RRULE goes along (Android as written, iOS its frequency, interval and end).
- **Privacy:** nothing an invitation links to is fetched (no ATTACH, no images, no URL); Map and Join open only
  on a tap.

## Wide screens and keyboards

The `/` route is `MailHome`: Mailboxes on a phone, mail panes from 840 dp. In the panes `mailSelectionProvider` says
what is shown and the route stack stays at `/`; crossing the breakpoint converts one into the other. Keyboard
shortcuts and the command palette act on the screen on top through `MailCommands`. See
[tablet-and-keyboard.md](tablet-and-keyboard.md).

## App Lock

Opt-in (Settings › Security; `settings.appLock`, `settings.lockAfter`), in `app/lib/features/app_lock/`:

- **Where:** `AppLockGate` sits in MaterialApp's builder, above the live gate, so it covers every route, dialog and
  the account error screen. Locked, the app stays mounted under it (`Offstage`, tickers off, `ExcludeFocus`), so
  nothing is painted, read out or typed into, and unlocking returns to the same place. `AppLockBackButton` wraps
  MaterialApp so its `didPopRoute` comes before the router's: Back on the lock screen leaves the app.
- **When** (`AppLockController`): locked from the first frame of a cold start (the setting is read synchronously
  from the preloaded SharedPreferences). Going out of sight (`AppLifecycleListener.onHide`) with Lock After at
  Immediately locks at once, so the first frame back is the lock; with a delay it puts up a cover and decides on
  `onShow` from the time away (`clock.now()`, a clock turned back counts as expired). `inactive` alone (notification
  shade, the prompt itself) never locks. The prompt shows by itself once each time the lock comes into view, on
  `onResume` (Android can't show it from the background); not again after the prompt's own PIN screen (Android 10 and
  earlier) hid the app, or closing it would reopen it.
- **Who checks:** `DeviceAuthenticator` (`local_auth`, `biometricOnly: false`: biometrics or the screen lock's
  credential); tests fake it. Turning App Lock on authenticates first, and refuses without a screen lock. If the
  screen lock is removed later, App Lock turns itself off at the next unlock (removing it takes the credential).
- **Android:** `MainActivity` is a `FlutterFragmentActivity` (BiometricPrompt needs a FragmentActivity); its
  themes are AppCompat ones (the biometric dialog of Android 8 and earlier needs them), with the old colours
  pinned. `RecentsChannel.kt` (`io.github.buengenio.loupe/recents`) turns off the Recent Apps screenshot while the
  setting is on (`setRecentsScreenshotEnabled`, Android 13+), without FLAG_SECURE.
- **Background work** never sees the lock: sync, Instant Delivery and notification buttons run in their own isolates.

## Conventions

- Dart 3.13, `dart analyze` clean with the root `analysis_options.yaml`; 120-column lines.
- Pure Dart packages test with `dart test`, Flutter packages with `flutter test`; `tool/ci/test.sh` runs them all.
- Generated code (drift) is committed, so CI needs no build_runner step.
- No network access in unit tests. Integration tests against real servers are tagged `integration`: IMAP ones need
  `LOUPE_TEST_IMAP_HOST`, JMAP ones a Stalwart binary (`LOUPE_TEST_STALWART`); see `tool/test-servers/`.
- No analytics or tracking code, ever. Remote content stays blocked by default. Besides account setup, the only
  network request outside the mail protocols is the one-click unsubscribe the user taps (see Subscriptions).
