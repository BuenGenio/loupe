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
mail_model: every type and interface above; no I/O, no dependencies
```

## Contracts

The packages are developed in parallel. These are the seams:

| Contract | Defined in | Implemented by | Used by |
|---|---|---|---|
| `MailRepository` | mail_model `src/repository.dart` | app demo repository; mail_sync `LiveMailRepository` | app |
| `MailingLists` (lists by List-Id, forum threads, muted threads) | mail_model `src/lists.dart` | app demo repository; mail_sync `LiveMailRepository` | app (`repository is MailingLists`) |
| `MailTransport`, `MailSender`, `MessageComposer`, `TransportFactory` | mail_model `src/transport.dart` | mail_imap | mail_sync |
| `CredentialStore` | mail_model `src/transport.dart` | mail_platform | mail_sync (through the app) |
| `SignInRenewal` ("Sign in again" after a revoked OAuth grant), `SignInRequiredException` | mail_model `src/sign_in.dart` | mail_sync `LiveMailRepository` | app (`repository is SignInRenewal`); mail_platform throws the exception |
| `SearchExpr` (search syntax tree) | mail_model `src/search.dart` | expr_search (parser) | app, mail_store (SQL), mail_imap (IMAP), mail_sync |
| `parseQuery`, `formatQuery`, `describeTerm`, `suggest`, `matchesEmail`, `widenForServer`, `compileImap`, `compileGmailRaw`, `compileJmapFilter` | expr_search `lib/src/api.dart` | expr_search | app, mail_imap, mail_sync |
| `ReadableMessageView`, `ReaderSettings`, `showImageGallery`, `analyzeContent` (link and privacy findings), `unwrapRedirect`, `inspectHost` | readable `lib/src/api.dart` | readable | app |
| `Rule`, `RuleAction`, `MailRules` (`MailRepository.rules`) | mail_model `src/rules.dart` | app `DemoRules`; mail_sync `LiveRules` | app |
| `compileSieve`, `generateLoupeScript`, `parseLoupeScript`, `planInclude`, `SieveConnector`, `ServerRules`, `RuleRunner` | mail_sieve `lib/mail_sieve.dart` | mail_sieve | mail_sync, app demo |

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

## Mailing lists

- **Headers:** every summary fetch asks for List-Id, List-Post, List-Unsubscribe and List-Unsubscribe-Post next to
  the threading headers; `EmailSummary` carries them (the List-Id as identifier and phrase, the others as sent) and
  mail_model parses them (`parseListId`, `parseListUris`, `listPostAddress`, `isOneClickUnsubscribe`).
- **Store:** schema version 3 added the columns (index on `list_id`), `muted_threads`, and `stale_headers` on sync
  states. The upgrade marks every synced mailbox, and the sync engine fetches its stored summaries once more to fill
  the new fields.
- **Mute is local to the device** (the `muted_threads` table), not a `$muted` keyword: custom keywords are lost on
  servers without `\*` in PERMANENTFLAGS, no other client honours one, and a per-thread state would still need every
  new message tagged. Muting marks the conversation read; later mail of a muted thread is marked read (locally and on
  the server) in the transaction that stores it, so it never shows unread or notifies (notifications skip read mail),
  like Thunderbird's ignored threads. Muted threads leave the mailing-list view; mailboxes still show them.
- **Patches:** readable recognises `git format-patch` diffs, diffstats and quoted hunks in text bodies
  (`pipeline/patch.dart`) and renders them as diffs (`render/diff.dart`).

## Conventions

- Dart 3.13, `dart analyze` clean with the root `analysis_options.yaml`; 120-column lines.
- Pure Dart packages test with `dart test`, Flutter packages with `flutter test`; `tool/ci/test.sh` runs them all.
- Generated code (drift) is committed, so CI needs no build_runner step.
- No network access in unit tests. Integration tests against real IMAP servers are tagged `integration` and need `LOUPE_TEST_IMAP_HOST`; see `tool/test-servers/`.
- No analytics or tracking code, ever. Remote content stays blocked by default.
