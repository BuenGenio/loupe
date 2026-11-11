# SQLite3 Multiple Ciphers

The encrypted SQLite that `mail_store` opens its database with, compiled from
this source by `package:sqlite3`'s build hook (`hooks: user_defines: sqlite3:`
in the workspace `pubspec.yaml`). Building from source keeps the app free of
downloaded binaries, which F-Droid requires.

- Version: SQLite3 Multiple Ciphers 2.5.0, SQLite 3.53.4
- Source: <https://github.com/utelle/SQLite3MultipleCiphers/releases/tag/v2.5.0>,
  `sqlite3mc-2.5.0-sqlite-3.53.4-amalgamation.zip`
  (sha256 `cd3a598b667dea206b6c5319d4ecb9d687ee40565f9fd2ba280d0c2f93790f58`,
  as GitHub lists it for that release asset)
- Files kept: `sqlite3mc_amalgamation.c`, `sqlite3mc_amalgamation.h`, unchanged
- Licence: MIT ([LICENSE](LICENSE)); SQLite itself is in the public domain

## Matching `package:sqlite3`

This is the same source `package:sqlite3` 3.7.0 builds its own sqlite3mc
binaries from (its `tool/download_sqlite.dart`), and the hook compiles it with
the same default options, so databases move between the two unchanged.

When `package:sqlite3` is upgraded, check which release its
`tool/download_sqlite.dart` names at the new version's tag, and update with:

```sh
tool/update_sqlite3mc.sh 2.5.0 3.53.4 cd3a598b667dea206b6c5319d4ecb9d687ee40565f9fd2ba280d0c2f93790f58
```

(the sqlite3mc version, the SQLite version, and the zip's sha256 from the
release page). Then run `packages/mail_store`'s tests.
