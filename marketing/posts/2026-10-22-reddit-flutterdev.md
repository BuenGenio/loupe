---
id: 2026-10-22-reddit-flutterdev
date: '2026-10-22T16:00:00Z'
status: scheduled
campaign: launch
platforms:
- reddit
link: https://loupe.mx/development/
reddit:
  subreddit: FlutterDev
  title: 'I built a full mail client in Flutter: 11 packages, an encrypted SQLite store, IMAP + JMAP, pure-Dart S/MIME. Notes on what worked'
  text: |
    Loupe is an open-source (MPL-2.0) mail app for Android, written in Flutter. Some notes that might be useful to other Flutter devs:

    - **Pub workspace monorepo**: 11 packages with a contracts-only `mail_model` at the bottom, so packages could be built in parallel and tested without a device.
    - **Storage**: drift + SQLite FTS5 for search, sqlite3mc for encryption.
    - **Search**: one parser produces a syntax tree that compiles to SQL, IMAP SEARCH, Gmail's raw search and JMAP filters; server results are post-filtered with the same matcher.
    - **Rendering**: Readable mode rebuilds HTML mail from plain widgets: no web view, no scripts.
    - **Crypto**: OpenPGP via dart_pg; S/MIME (CMS, PKCS #12, chain validation) in pure Dart on pointycastle, with Android KeyChain keys used through a small platform channel.
    - **Marketing screenshots** are rendered from widget tests with real fonts.

    Architecture and build steps: {link} · Source: https://github.com/BuenGenio/loupe

    Happy to go deeper on any of it.
---
Loupe {link}
