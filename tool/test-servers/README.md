# Test mail servers

mail_imap's integration tests (`packages/mail_imap/test/integration/`, tag
`integration`) run against a real server. They are skipped unless
`LOUPE_TEST_IMAP_HOST` is set. Each run creates its own mailboxes
(`Loupe<timestamp>`) and deletes them afterwards.

Everything these scripts write (jar, pid, log, certificates) stays in
`tool/test-servers/data/`, which is gitignored.

## Without Docker: GreenMail on Java

Needs Java 11 or later and curl. This is how the tests run on the dev laptop,
where Docker isn't available.

```sh
tool/test-servers/greenmail.sh start          # downloads the jar once (checksum-verified)
eval "$(tool/test-servers/greenmail.sh env)"
(cd packages/mail_imap && dart test test/integration)
tool/test-servers/greenmail.sh stop
```

GreenMail covers SMTP (3025, SMTPS 3465) and simple IMAP (3143, IMAPS 3993)
with IDLE, MOVE and UIDPLUS, but no CONDSTORE/QRESYNC or SPECIAL-USE, so it
exercises the UID-diff sync path. Its TLS ports use a self-signed
certificate, which the trust-on-first-use tests rely on. Users:
`alice@example.test` and `bob@example.test`, password `secret`.

## With Docker: Dovecot and GreenMail

`docker-compose.yml` runs both servers (multi-arch images, linux/arm64 included).
Dovecot 2.4 adds CONDSTORE, QRESYNC, IDLE, SPECIAL-USE, MOVE and ESEARCH, so it
covers the incremental-sync paths GreenMail can't.

```sh
tool/test-servers/make-cert.sh                # self-signed cert for Dovecot; prints its SHA-256
docker compose -f tool/test-servers/docker-compose.yml up -d

# Dovecot (IMAP only; its submission service has no relay configured):
cd packages/mail_imap
LOUPE_TEST_IMAP_HOST=127.0.0.1 LOUPE_TEST_IMAP_PORT=31143 LOUPE_TEST_IMAP_SECURITY=none \
LOUPE_TEST_IMAPS_PORT=31993 dart test test/integration

# GreenMail (IMAP + SMTP), same ports as the Java run:
eval "$(../../tool/test-servers/greenmail.sh env)" && dart test test/integration
cd ../..

docker compose -f tool/test-servers/docker-compose.yml down
```

Dovecot accepts any user name with the password `secret`. To test STARTTLS
or TLS with the self-signed certificate, set `LOUPE_TEST_IMAP_SECURITY` to
`startTls` (port 31143) or `tls` (31993) and `LOUPE_TEST_IMAP_SHA256` to the
fingerprint `make-cert.sh` printed.

Note: the compose file couldn't be run on the machine it was written on (no
Docker access there); the GreenMail tests were run with `greenmail.sh`.

## JMAP: Stalwart

mail_jmap's integration tests (`packages/mail_jmap/test/integration/`, tag `integration`) start their own
throwaway Stalwart 0.16 (a single binary, no Docker) when it is there: at `~/development/roost-deps/stalwart`, or
wherever `LOUPE_TEST_STALWART` points (`LOUPE_TEST_STALWART=off` skips them). Each test file gets a fresh server in
a temporary directory, deleted afterwards (kept with `LOUPE_TEST_STALWART_KEEP=1`, for its logs).

```sh
cd packages/mail_jmap && dart test test/integration
```

`stalwart/stalwart.dart` does the setup, the way Roost does it: bootstrap mode writes the configuration and the
admin login; recovery mode turns off outside fetching (ASN and geo data, spam rules, the web admin) and creates the
listeners, all on 127.0.0.1 and free ports (HTTP for JMAP, IMAP, SMTP, submission and ManageSieve, none with TLS),
so Stalwart never binds its defaults; normal mode then creates `alice@example.test` and `bob@example.test` with
random passwords. Plain-text logins are allowed on IMAP and submission, and the SMTP listener takes local mail
without one. Run it on its own to try the app or curl against it; it prints the environment and stops on Ctrl-C:

```sh
dart tool/test-servers/stalwart/stalwart.dart --seed 20   # 20 sample messages for alice
```

The session resource names `https://mail.example.test/…` URLs (Stalwart builds them from its host name, which
can't carry a port); the tests' HTTP client sends those to the local listener (`StalwartHttpClient`).

## Sample data

`seed.sh [imap-url] [user] [password] [count]` appends sample messages with
curl, e.g. for trying the app against a local server:

```sh
tool/test-servers/seed.sh imap://127.0.0.1:3143/INBOX alice@example.test secret 50
tool/test-servers/seed.sh imaps://127.0.0.1:31993/INBOX anyone secret 50
```

## Environment variables

| Variable | Default | Meaning |
|---|---|---|
| `LOUPE_TEST_IMAP_HOST` | (unset: skip) | IMAP host; also the SMTP host unless `LOUPE_TEST_SMTP_HOST` is set |
| `LOUPE_TEST_IMAP_PORT` | `143` | IMAP port |
| `LOUPE_TEST_IMAP_SECURITY` | `none` | `none`, `startTls` or `tls` |
| `LOUPE_TEST_IMAP_SHA256` | | Trusted certificate fingerprint (lower-case hex) |
| `LOUPE_TEST_IMAP_USER` / `_USER2` | `alice@example.test` / `bob@example.test` | Logins (user 2 receives Bcc) |
| `LOUPE_TEST_IMAP_PASSWORD` | `secret` | Password for both |
| `LOUPE_TEST_SMTP_HOST` / `_PORT` / `_SECURITY` | IMAP host / (unset: skip SMTP) / `none` | SMTP submission |
| `LOUPE_TEST_IMAPS_PORT`, `LOUPE_TEST_SMTPS_PORT` | (unset: skip) | TLS ports with an untrusted certificate, for the trust tests |
