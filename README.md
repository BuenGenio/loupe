# Loupe

A mail app for Android and iOS: as simple as Apple Mail on the surface, with Thunderbird-desktop power underneath.
"Loupe" is a working name.

Status: **early development** (Phase 1). Android builds first.

- Plan: [docs/plan/PLAN.md](docs/plan/PLAN.md) (background research in [docs/plan/research/](docs/plan/research/))
- Architecture and package contracts: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- iOS: what is set up and the checklist to TestFlight: [docs/ios.md](docs/ios.md)
- Sign in with Google and Microsoft: registering the OAuth clients, and testing: [docs/oauth-setup.md](docs/oauth-setup.md)

## Try it on Android

Every push to `main` builds signed APKs and attaches them to the rolling **Nightly** pre-release on GitHub:

- `loupe-<version>-arm64.apk` for phones
- `loupe-<version>-x86_64.apk` for emulators

Install the APK; newer builds install over older ones. On first start, choose **Try with demo mail** to explore the UI without an account.

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
| `packages/mail_imap` | IMAP/SMTP transport (enough_mail), MIME composing, account discovery |
| `packages/mail_store` | Encrypted local store: drift, SQLite FTS5, sqlite3mc |
| `packages/mail_sync` | Sync engine, offline queue, the live `MailRepository` |
| `packages/mail_platform` | Keychain credential store, OAuth sign-in |

## Licence

[MPL-2.0](LICENSE).
