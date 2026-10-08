# Loupe

A mail app for Android and iOS: as simple as Apple Mail on the surface, with Thunderbird-desktop power underneath.
"Loupe" is a working name.

Status: **early development**, used daily by its owner on Android. iOS is prepared and waits on an Apple Developer account.

- What's new: [CHANGELOG.md](CHANGELOG.md)
- Plan: [docs/plan/PLAN.md](docs/plan/PLAN.md) (background research in [docs/plan/research/](docs/plan/research/))
- Architecture and package contracts: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- iOS: what is set up and the checklist to TestFlight: [docs/ios.md](docs/ios.md)
- Sign in with Google and Microsoft: registering the OAuth clients, and testing: [docs/oauth-setup.md](docs/oauth-setup.md)

## What it does

- **Reading:** Readable mode rebuilds HTML mail to fit the screen, with footers as fine print, image carousel and gallery, and dark-mode colour fixes. Original and Plain (Sans/Mono) views are one tap away. Developer mode shows patches with diff highlighting, and discussion lists as forum-style threads.
- **Search:** pull-down search with chips or typed expressions (`f:alice and (s:invoice or b:"PO 123")`). Results from the phone appear at once and the server's stream in after. Smart Mailboxes are stored on your mail server (IMAP METADATA or a folder), so they follow you to other devices.
- **Organising:** swipes with Undo, Filter button, tags compatible with Thunderbird, folder subscriptions, snooze that works across clients (a `Snoozed` folder plus a keyword), and Subscriptions: newsletters by sender with an on-device unsubscribe centre, and the discussion lists you write to.
- **Saving and exporting:** a message as an `.eml` file (Save as File…, Share as File…), and a folder as an mbox archive (Export Folder…), written to storage as it downloads, never held in memory.
- **Rules:** device rules, and server rules as Sieve (over ManageSieve, or JMAP for JMAP accounts); any search can become a rule.
- **Writing:** identities with reply-from-recipient and catch-all aliases, draft autosave, undo send, scheduled send with an Outbox.
- **Calendar invitations:** Accept, Maybe or Decline from the message, with updates, cancellations and the event's time zone beside yours.
- **Notifications:** background sync every 15 minutes, notification actions (Archive, Mark as Read, Reply), app icon badge, and optional instant delivery (experimental).
- **Security and privacy:** encrypted local database; optional App Lock (fingerprint, face or screen lock); no telemetry or servers of our own; remote images blocked; tracking-redirect unwrapping; an explainable phishing check; OpenPGP (compatible with Thunderbird, with Autocrypt) and S/MIME.
- **Accounts:** IMAP/SMTP with autoconfig, JMAP (Stalwart, Fastmail), import from Thunderbird's "Export for Mobile" QR codes, and Google/Microsoft sign-in once client IDs are configured ([docs/oauth-setup.md](docs/oauth-setup.md)).
- **Tablets and keyboards:** three-pane layout, keyboard shortcuts, command palette (Ctrl/⌘+K), drag and drop.

Manual test plan for a device: [docs/device-test-checklist.md](docs/device-test-checklist.md).

## Try it on Android

Every push to `main` builds signed APKs and attaches them to the rolling **Nightly** pre-release on GitHub:

- `loupe-<version>-arm64.apk` for phones
- `loupe-<version>-x86_64.apk` for emulators

Install the APK; newer builds install over older ones. The release notes show what's new, from [CHANGELOG.md](CHANGELOG.md). On first start, choose **Try with demo mail** to explore the UI without an account.

## Develop

Requirements: Flutter 3.47 (Dart 3.13). The repo is a [pub workspace](https://dart.dev/tools/pub/workspaces).

```sh
flutter pub get          # resolves all packages at once
dart analyze             # must be clean
tool/ci/test.sh          # tests of every package
cd app && flutter run    # on a device or emulator
```

| Path | What |
|---|---|
| `app/` | The Flutter app: screens, design system, demo repository, wiring |
| `packages/mail_model` | Shared types and interfaces (the contract between all packages) |
| `packages/expr_search` | Search language: parser, formatter, local matcher, IMAP/Gmail/JMAP compilers |
| `packages/readable` | Readable HTML reader, Original and Plain views, image gallery |
| `packages/mail_imap` | IMAP/SMTP transport (enough_mail), MIME composing, account discovery, the mbox writer |
| `packages/mail_store` | Encrypted local store: drift, SQLite FTS5, sqlite3mc |
| `packages/mail_sync` | Sync engine, offline queue, the live `MailRepository` |
| `packages/mail_platform` | Keychain credential store, OAuth sign-in |
| `packages/mail_jmap` | JMAP transport: sync, search, sending, push |
| `packages/mail_sieve` | Rules: device rule runner, Sieve generation, ManageSieve client |
| `packages/mail_crypto` | OpenPGP (PGP/MIME, Autocrypt) and S/MIME |
| `packages/mail_calendar` | Calendar invitations: iCalendar, time zones, iMIP replies |

## Licence

[MPL-2.0](LICENSE).
