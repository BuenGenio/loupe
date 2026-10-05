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
              └─ TransportFactory ◄── mail_imap (enough_mail; IMAP, SMTP, MIME, discovery)
                                  ◄── mail_jmap (Phase 3)
mail_platform: CredentialStore (keychain), OAuth sign-in (AppAuth) and token refresh (HTTPS)
mail_crypto: OpenPGP (dart_pg, vendored in third_party/): keys, keyring,
             PGP/MIME reading and writing, Autocrypt; S/MIME (pure Dart on
             pointycastle): certificates, PKCS #12, CMS, chain validation;
             the app wraps loadContent with both and hands their composers
             to mail_imap
mail_model: every type and interface above; no I/O, no dependencies
```

## Contracts

The packages are developed in parallel. These are the seams:

| Contract | Defined in | Implemented by | Used by |
|---|---|---|---|
| `MailRepository` | mail_model `src/repository.dart` | app demo repository; mail_sync `LiveMailRepository` | app |
| `MailingLists` (lists by List-Id, forum threads, muted threads) | mail_model `src/lists.dart` | app demo repository; mail_sync `LiveMailRepository` | app (`repository is MailingLists`) |
| `MailSubscriptions` (bulk mail by List-Id or sender, read rates), `unsubscribeMethods`, `unsubscribeMessage` | mail_model `src/subscriptions.dart` | app demo repository; mail_sync `LiveMailRepository` | app (`repository is MailSubscriptions`) |
| `MailTransport`, `MailSender`, `MessageComposer`, `TransportFactory` | mail_model `src/transport.dart` | mail_imap | mail_sync |
| `CredentialStore` | mail_model `src/transport.dart` | mail_platform | mail_sync (through the app) |
| `SignInRenewal` ("Sign in again" after a revoked OAuth grant), `SignInRequiredException` | mail_model `src/sign_in.dart` | mail_sync `LiveMailRepository` | app (`repository is SignInRenewal`); mail_platform throws the exception |
| `SearchExpr` (search syntax tree) | mail_model `src/search.dart` | expr_search (parser) | app, mail_store (SQL), mail_imap (IMAP), mail_sync |
| `parseQuery`, `formatQuery`, `describeTerm`, `suggest`, `matchesEmail`, `widenForServer`, `compileImap`, `compileGmailRaw`, `compileJmapFilter` | expr_search `lib/src/api.dart` | expr_search | app, mail_imap, mail_sync |
| `ReadableMessageView`, `ReaderSettings`, `showImageGallery`, `analyzeContent` (link and privacy findings), `unwrapRedirect`, `inspectHost` | readable `lib/src/api.dart` | readable | app |
| `Rule`, `RuleAction`, `MailRules` (`MailRepository.rules`) | mail_model `src/rules.dart` | app `DemoRules`; mail_sync `LiveRules` | app |
| `compileSieve`, `generateLoupeScript`, `parseLoupeScript`, `planInclude`, `SieveConnector`, `ServerRules`, `RuleRunner` | mail_sieve `lib/mail_sieve.dart` | mail_sieve | mail_sync, app demo |
| `PgpBackend` (swappable OpenPGP engine), `Keyring`, `PgpMimeReader`, `PgpMessageComposer` (a `MessageComposer` around another), `OutgoingMessage.security` | mail_crypto `lib/mail_crypto.dart`, mail_model `src/outgoing.dart` | mail_crypto (`DartPgBackend`) | app (reader, compose, settings, live composer) |
| `SmimeBackend` (swappable S/MIME engine), `SmimeStore`, `SmimeReader`, `checkTrust`, `planSmime`, `chooseTechnology`, `SmimeMessageComposer` (around the OpenPGP one), `OutgoingSecurity.technology` | mail_crypto `lib/mail_crypto.dart`, mail_model `src/outgoing.dart` | mail_crypto (`DartSmimeBackend`) | app (reader, compose, settings, live composer) |

Rules:

- **Ids are deterministic** (`MailIds`): transports produce final local ids, so the store needs no mapping table.
  - IMAP email ids include the mailbox path, UIDVALIDITY and UID.
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
  platform engine (Android KeyChain with MDM-installed certificates, iOS `CMSDecoder`) can come later behind the
  same interface; certificates and keys cross it as DER.
- **Keys and certificates** (`SmimeStore`, keychain entries `loupe.smime.*` next to the OpenPGP keyring): the
  user's certificates with their CA chain, each private key in an entry of its own (PKCS #8, protected by the
  keychain only: the PKCS #12 password just unlocks the import, as on Android and in Thunderbird without a
  primary password); correspondents' certificates, collected from good signatures by the sender (not from
  drafts or junk) or imported; the authorities the user trusts; per-address settings (the certificate,
  "Prefer S/MIME"). PKCS #12 import reads OpenSSL 3's defaults (PBES2 with AES), the legacy algorithms of
  older Windows exports (3DES, RC2-40, SHA-1 MAC) and PBMAC1.
- **Trust** (`checkTrust`): a chain through the message's and known certificates to a trusted root, every
  signature checked, then validity (at the signing time for signatures), CA flags, path length, rfc822 name
  constraints, unknown critical extensions, key usage (digitalSignature for signing; keyEncipherment for RSA or
  keyAgreement for EC recipients; emailProtection) and the address in the SAN or the subject.
  - Roots: Mozilla's, with the email trust bit, as Thunderbird uses them (`mozilla_roots.dart`, generated from
    NSS's certdata.txt by `tool/update_mozilla_roots.dart`), plus certificates the user trusts (a company CA,
    offered when importing a .p12 that came with one, or a single certificate). Not the platform store:
    Android's holds TLS roots without email trust bits, and isn't readable from Dart without a plugin.
  - No revocation checks (OCSP, CRLs): they would be network requests outside the mail protocols, telling a CA
    who reads whose mail. Policies aren't processed (as most mail clients); SHA-1 certificates aren't accepted.
- **Reading** (`SmimeReader`): `application/pkcs7-mime` (enveloped, authEnveloped, opaque signed; also without
  `smime-type` or as an octet-stream `.p7m`) and `multipart/signed` with `application/(x-)pkcs7-signature`,
  nested as Thunderbird (multipart/signed inside) and Outlook (opaque inside) send them. Decryption: RSA
  (PKCS #1 v1.5, OAEP) and ECDH (X9.63 KDF with SHA-1 to SHA-512, AES key wrap); AES-CBC, AES-GCM, 3DES, RC2.
  Thunderbird's rules, checked against its NSS-made test messages: SHA-1 signatures aren't accepted; a
  signature around encrypted data doesn't count; a signature's embedded content must be the signed part; a
  signing time more than an hour from the Date header isn't good. The header says "Encrypted (S/MIME)" and
  "Signed by Alice ✓ (Issuer)", or what is wrong; the sheet can trust the issuing CA after showing its
  fingerprint.
- **Sending** (`SmimeMessageComposer` around `PgpMessageComposer` around `MimeMessageComposer`): signed as
  multipart/signed (SHA-256, RSA PKCS #1 v1.5 or ECDSA) carrying the certificate, its intermediates, the
  SMIMECapabilities and which certificate to encrypt to (RFC 8551's attribute and Outlook's). Encrypted: signed
  first, then EnvelopedData to every recipient and the sender with AES-256-CBC, which Outlook, Apple Mail and
  Thunderbird all read; AuthEnvelopedData (AES-256-GCM) only when every recipient's signed mail announced
  AES-GCM. RSA recipients get the key with PKCS #1 v1.5 (OAEP isn't read everywhere), EC recipients by
  ephemeral-static ECDH (SHA-256 KDF, AES-256 wrap). Unlike OpenPGP mail, the outer Subject isn't hidden. Bcc
  recipients get copies of their own (see below); drafts are encrypted to the sender only.
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
- **Protected subjects** (OpenPGP sends the real subject inside, `...` outside): summaries say whether a message is
  encrypted (`EmailSummary.isEncrypted`, from its BODYSTRUCTURE; schema version 6, `emails.is_encrypted`). Once
  `ContentLoader` decrypted a message, its protected subject is kept in the encrypted store
  (`DecryptedMail.rememberProtectedSubject`, `emails.protected_subject`), for the message and its copies (same
  account, Message-ID, size and outer subject; copies synced later inherit it). Summaries then carry it as their
  subject (`hasDecryptedSubject`), so the list, search (the full-text index has it) and replies show it; syncs
  never overwrite it. Notifications say "Encrypted message" for encrypted mail unless its subject was decrypted
  on the device, and nothing more with Hide Content.
  - Settings › End-to-End Encryption › On This Device › Decrypt Subjects in the Background (off by default):
    `SubjectDecryptor` decrypts the subjects of encrypted mail nobody opened yet, with keys stored without a
    passphrase only (it never asks), OpenPGP only, messages up to 1 MB (the whole message is downloaded). Background
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
- **Patches:** readable recognises `git format-patch` diffs, diffstats and quoted hunks in text bodies
  (`pipeline/patch.dart`) and renders them as diffs (`render/diff.dart`).

## Subscriptions (the unsubscribe centre)

Mailboxes › Tools › Subscriptions ranks newsletters and other bulk mail by how much of it goes unread. Everything is
counted on the device; services that do this elsewhere read the mail on their servers.

- **Bulk mail** (`subscriptionKeyOf`): a List-Id, a List-Unsubscribe header, or a Message-ID of a bulk-mail service
  (`bulkMessageIdDomains`: Mailchimp, SendGrid, Amazon SES…). It groups by List-Id, else by sender address. A sender
  found only by its Message-ID needs two messages. `Precedence: bulk` isn't fetched (such mail nearly always has
  List-Unsubscribe too), and when a message was opened isn't known: the read rate (`$seen`) stands in for it.
- **Counting** (`summarizeSubscriptions` is the reference): copies in several mailboxes count once; Junk, Sent, Drafts
  and the user's own addresses are left out (Trash counts: deleting unread is not reading). Messages a month and the
  read rate use the last 90 days (the read rate over all mail when fewer than three came then). The ranking is unread
  mail a month.
- **Store** (schema version 5): `emails.sub_key` is each message's key (a generated column, indexed where set);
  `subscription_messages` (one row per bulk message, copies merged) and `subscription_details` (per key) hold the
  groups. Triggers on `emails`, `mailboxes` and `accounts` mark the messages a change touches (any process's), and
  `MailStore.watchSubscriptions` redoes only those, and their keys, before it reads; the counts of the last 90 days
  are summed at read time. At 40,000 messages (420 groups) opening the screen takes about 5 ms, after 200 messages
  were read about 20 ms; the first time after the upgrade groups everything once (about 120 ms).
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
- **Records** stay on the device (SharedPreferences `subscriptions.unsubscribed`: date and method). Mail arriving more
  than seven days later marks the row "Still sending".
- **Follow-ups** reuse what exists: Archive All moves the Inbox copies through `MailActions` (with Undo); Create Rule
  opens the rule editor with the condition (`from:` the sender, or the List-Id of a list with several senders), the
  name and Move to Archive filled in; Block Sender saves a device rule that moves to Junk.

## Wide screens and keyboards

The `/` route is `MailHome`: Mailboxes on a phone, mail panes from 840 dp. In the panes `mailSelectionProvider` says
what is shown and the route stack stays at `/`; crossing the breakpoint converts one into the other. Keyboard
shortcuts and the command palette act on the screen on top through `MailCommands`. See
[tablet-and-keyboard.md](tablet-and-keyboard.md).

## Conventions

- Dart 3.13, `dart analyze` clean with the root `analysis_options.yaml`; 120-column lines.
- Pure Dart packages test with `dart test`, Flutter packages with `flutter test`; `tool/ci/test.sh` runs them all.
- Generated code (drift) is committed, so CI needs no build_runner step.
- No network access in unit tests. Integration tests against real IMAP servers are tagged `integration` and need `LOUPE_TEST_IMAP_HOST`; see `tool/test-servers/`.
- No analytics or tracking code, ever. Remote content stays blocked by default. Besides account setup, the only
  network request outside the mail protocols is the one-click unsubscribe the user taps (see Subscriptions).
