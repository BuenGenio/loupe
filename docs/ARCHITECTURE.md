# Architecture

```
app (UI, Riverpod, go_router)
 ├─ readable ─────────────┐
 ├─ expr_search ──────────┤
 └─ MailRepository  ◄─────┼── demo repository (app/lib/demo, fake data)
        ▲                 │
        └── mail_sync (LiveMailRepository: sync engine, offline queue)
              ├─ mail_store (drift + FTS5 + sqlite3mc)
              └─ TransportFactory ◄── mail_imap (enough_mail; IMAP, SMTP, MIME, discovery)
                                  ◄── mail_jmap (Phase 3)
mail_platform: CredentialStore (keychain), OAuth sign-in
mail_crypto: OpenPGP (dart_pg, vendored in third_party/): keys, keyring,
             PGP/MIME reading and writing, Autocrypt; the app wraps loadContent
             with it and hands its composer to mail_imap
mail_model: every type and interface above; no I/O, no dependencies
```

## Contracts

The packages are developed in parallel. These are the seams:

| Contract | Defined in | Implemented by | Used by |
|---|---|---|---|
| `MailRepository` | mail_model `src/repository.dart` | app demo repository; mail_sync `LiveMailRepository` | app |
| `MailTransport`, `MailSender`, `MessageComposer`, `TransportFactory` | mail_model `src/transport.dart` | mail_imap | mail_sync |
| `CredentialStore` | mail_model `src/transport.dart` | mail_platform | mail_sync (through the app) |
| `SearchExpr` (search syntax tree) | mail_model `src/search.dart` | expr_search (parser) | app, mail_store (SQL), mail_imap (IMAP), mail_sync |
| `parseQuery`, `formatQuery`, `describeTerm`, `suggest`, `matchesEmail`, `widenForServer`, `compileImap`, `compileGmailRaw`, `compileJmapFilter` | expr_search `lib/src/api.dart` | expr_search | app, mail_imap, mail_sync |
| `ReadableMessageView`, `ReaderSettings`, `showImageGallery`, `analyzeContent` (link and privacy findings), `unwrapRedirect`, `inspectHost` | readable `lib/src/api.dart` | readable | app |
| `PgpBackend` (swappable OpenPGP engine), `Keyring`, `PgpMimeReader`, `PgpMessageComposer` (a `MessageComposer` around another), `OutgoingMessage.security` | mail_crypto `lib/mail_crypto.dart`, mail_model `src/outgoing.dart` | mail_crypto (`DartPgBackend`) | app (reader, compose, settings, live composer) |

Rules:

- **Ids are deterministic** (`MailIds`): transports produce final local ids, so the store needs no mapping table.
  - IMAP email ids include the mailbox path, UIDVALIDITY and UID.
- **Keywords are lower-case JMAP keywords** (`$seen`, `$flagged`, …). The IMAP adapter maps `\Seen` and the other system flags to them.
- **Search:** the app parses the query (expr_search) and passes a `SearchExpr` in a `SearchRequest`.
  - The store translates it to SQL/FTS5.
  - The transport compiles it for the server via expr_search and widens what the server can't do.
  - mail_sync post-filters server hits with `matchesEmail`.
- **Message bodies in the app** come from `contentLoaderProvider` (`ContentLoader.loadContent` and
  `loadAttachment`), not the repository directly: it decrypts and verifies OpenPGP mail and learns
  Autocrypt keys. Decrypted attachments have `pgp:` part ids.
- **Changing a contract:** edit mail_model (or the API file) in its own commit, run `dart analyze` on the whole workspace, and fix every user in the same change.

## Conventions

- Dart 3.13, `dart analyze` clean with the root `analysis_options.yaml`; 120-column lines.
- Pure Dart packages test with `dart test`, Flutter packages with `flutter test`; `tool/ci/test.sh` runs them all.
- Generated code (drift) is committed, so CI needs no build_runner step.
- No network access in unit tests. Integration tests against real IMAP servers are tagged `integration` and need `LOUPE_TEST_IMAP_HOST`; see `tool/test-servers/`.
- No analytics or tracking code, ever. Remote content stays blocked by default.
