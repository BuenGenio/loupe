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
- **Changing a contract:** edit mail_model (or the API file) in its own commit, run `dart analyze` on the whole workspace, and fix every user in the same change.

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
- **New mail is what passed a watermark.** `detectNewMail` remembers the newest arrival per inbox (and VIP mail elsewhere) in `new_mail.json`; a list seen for the first time only sets its watermark. The app moves the watermarks silently when it goes to the background.

## Conventions

- Dart 3.13, `dart analyze` clean with the root `analysis_options.yaml`; 120-column lines.
- Pure Dart packages test with `dart test`, Flutter packages with `flutter test`; `tool/ci/test.sh` runs them all.
- Generated code (drift) is committed, so CI needs no build_runner step.
- No network access in unit tests. Integration tests against real IMAP servers are tagged `integration` and need `LOUPE_TEST_IMAP_HOST`; see `tool/test-servers/`.
- No analytics or tracking code, ever. Remote content stays blocked by default.
