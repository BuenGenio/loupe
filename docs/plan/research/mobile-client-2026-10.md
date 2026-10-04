# Research: Flutter mail client landscape (as of 2026-10-04)

Desk research for [PLAN.md](../PLAN.md): web, official docs, GitHub and pub.dev APIs, and live IMAP `CAPABILITY` probes.
Items that could not be confirmed are marked **UNCONFIRMED**. Re-check versions before relying on them.

## 1. Official Thunderbird mobile apps

- **Thunderbird for Android**
  - Built on the K-9 codebase: repo `thunderbird/thunderbird-android`, mostly Kotlin, Apache-2.0.
  - Latest stable is 23.1 (2026-09-22); latest beta is 24.0b2 (2026-09-14).
    <https://github.com/thunderbird/thunderbird-android/releases>
- **Add-ons on mobile**
  - April 2024 statement: add-ons are wanted, but "rather unlikely within the next two years". K-9's codebase differs, and add-ons are built for desktop.
    <https://heise.de/en/news/Thunderbird-for-Android-No-add-ons-for-now-but-Exchange-support-9689667.html>,
    <https://blog.thunderbird.net/2024/04/team-thunderbird-answers-your-most-frequently-asked-questions/>
  - The 2026 progress reports and the mobile roadmaps contain no add-on items.
- **Thunderbird for iOS**
  - Not released. It is a native app written from scratch in Swift/SwiftUI, MPL-2.0. <https://github.com/thunderbird/thunderbird-ios>
  - April 2026 progress report: "target is still end of the year". Planned backend: IMAP, SMTP, MIME, OAuth, encryption. JMAP is not on the 2026 roadmap.
    <https://blog.thunderbird.net/2026/04/mobile-progress-report-april-2026/>
  - 1 October 2026: "first version ready for community testing in the next few months".
    <https://blog.thunderbird.net/2026/10/thunderbird-for-ios-a-first-look-at-the-native-iphone-email-app-in-development/>
  - A TestFlight page exists. **UNCONFIRMED** whether it is open.

## 2. Trademark

- "Thunderbird" is a Mozilla trademark. <https://www.mozilla.org/en-US/foundation/trademarks/list/>
- The policy says: "Don't use Mozilla trademarks in the name of your business, product, service, app, domain name…".
  It allows stating in words that a product "works with" or "is compatible with" a Mozilla product, if that is true.
  Any other use needs written permission (trademark-permissions@mozilla.com).
  <https://www.mozilla.org/en-US/foundation/trademarks/policy/>
- The "X Extension for Firefox" naming exception covers add-ons only.
- So a standalone app may not be called "X for Thunderbird". "Thunderbird-like" in marketing copy: **UNCONFIRMED**, needs legal review.

## 3. Dart mail libraries and Flutter clients

| Project | What it is | License | Status |
|---|---|---|---|
| [enough_mail](https://github.com/Enough-Software/enough_mail) | IMAP4rev1, POP3, SMTP, MIME | MPL-2.0 | See details below. |
| enough_mail_flutter, enough_mail_html | Flutter widgets and HTML helpers | MPL-2.0 | 2.1.2 / 2.0.2 (2025-08) |
| [enough_mail_app](https://github.com/Enough-Software/enough_mail_app) | Base mail components | GPL-3.0 | Last commit 2026-04 |
| [Maily](https://github.com/Enough-Software/maily) | Full Flutter IMAP client | GPL-3.0 | Early access on Play and TestFlight; last commit 2026-05 |
| [Twake Mail](https://github.com/linagora/tmail-flutter) (Linagora) | Flutter, JMAP-only client | AGPL-3.0 | Very active: v0.37.1, 2026-09-22 |
| [jmap-dart-client](https://github.com/linagora/jmap-dart-client) | JMAP client library | MIT | Not on pub.dev (git dependency); last push 2026-06 |
| mailer | SMTP only | MIT | 7.2.0 (2026-07) |
| imap_client | IMAP | — | Abandoned since 2020 |
| Sterna Mail (`app.sterna`, F-Droid) | JMAP + IMAP/SMTP client, Android | — | Exists (not further researched) |

enough_mail details:
- Releases: 2.1.7 (2025-08-19); the one before was 2.1.6 (2023-12). Fixes have been merged since but are unreleased (up to 2026-10).
- Effectively one maintainer, with 54 open issues.
- Supported extensions: IDLE, CONDSTORE, QRESYNC, ESEARCH, SORT/THREAD, ESORT/PARTIAL, MOVE, UIDPLUS, METADATA, QUOTA, UTF-8.
- **Not supported:** X-GM-RAW, MULTISEARCH, FUZZY.

## 4. Flutter building blocks (pub.dev, checked 2026-10)

- **OAuth:** flutter_appauth 12.1.0 (2026-08), BSD-3. Native AppAuth, with PKCE.
- **Secrets:** flutter_secure_storage 11.2.0 (2026-09), BSD-3.
  v11 removed the EncryptedSharedPreferences backend, so users must be migrated via v10 first.
- **SQLite:**
  - drift 2.35.1 (2026-09-30), MIT; FTS5 via the `sqlite_module` option. <https://drift.simonbinder.eu/sql_api/extensions/>
  - sqlite3 3.7.0 uses build hooks and bundles SQLite with `SQLITE_ENABLE_FTS5`. Encryption is chosen with `source: sqlite3mc | sqlcipher`.
    <https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md>
  - `sqlite3_flutter_libs` and `sqlcipher_flutter_libs` are **end-of-life** (0.x+eol, 2026-02).
  - sqflite 2.4.4 (BSD-2) and sqflite_sqlcipher 3.4.1 (MIT) are alternatives.
- **HTML:**
  - package:html (html5lib port) 0.15.7 (2026-08), MIT-style.
  - sanitize_html 2.2.0 (Apache-2.0) strips all CSS, which is too strict for email. A custom allowlist is needed.
  - flutter_widget_from_html 0.17.4 (2026-09), MIT, active. It renders without a WebView.
  - flutter_html is stalled: last release March 2025, 161 open issues.
  - webview_flutter 4.14.1, BSD-3. `onNavigationRequest` does not see subresources such as images.
  - flutter_inappwebview has content blockers that can block remote images. Last stable is 6.1.5 (2024-10); a beta came out in 2026-02. Apache-2.0.
    <https://inappwebview.dev/docs/webview/content-blockers/>
- **OpenPGP:**
  - dart_pg 2.1.0 (2025-04), BSD-3, pure Dart, RFC 9580.
  - openpgp (jerson) 3.10.7 (2025-10), MIT, wraps Go.
  - Via FFI: RNP (C++, BSD-2, used by Thunderbird desktop) or Sequoia (Rust, LGPL-2.0+) through flutter_rust_bridge. No maintained Dart binding exists for either.
- **Background:**
  - workmanager 0.10.10 (2026-09), MIT.
  - background_fetch 1.7.0, MIT. On iOS it runs at most every 15 minutes and stops if the app is terminated or unused.

## 5. Background sync and push

- **iOS:**
  - BGAppRefreshTask gives "up to 30 seconds" of runtime, at a time the system chooses.
  - BGProcessingTask runs only while the device is idle.
  - Silent pushes are low priority; Apple says "don't try to send more than two or three per hour".
  - **A long-lived IMAP IDLE connection is not possible on iOS.** Real-time mail needs a server that sends APNs pushes.
  - <https://developer.apple.com/documentation/backgroundtasks/choosing-background-strategies-for-your-app>,
    <https://developer.apple.com/documentation/usernotifications/pushing-background-updates-to-your-app>
- **How others do push:**
  - Spark stores OAuth tokens (and passwords for other providers) on its own AWS servers, which poll mail and send pushes.
    <https://readdle.com/blog/how-we-handle-your-account-information-in-spark>
  - Delta Chat stores a device token in IMAP METADATA (`XDELTAPUSH`); a notification proxy forwards to APNs/FCM. <https://github.com/deltachat/notifiers>
  - iCloud IMAP advertises a proprietary `XAPPLEPUSHSERVICE`.
- **Android:**
  - Thunderbird/K-9 keeps IMAP IDLE open in a foreground service declared as `dataSync|specialUse`.
  - `dataSync` is capped at 6 hours per 24 hours on Android 15+.
  - `specialUse` has no cap, but needs a written justification that the Play Console reviews.
  - <https://developer.android.com/develop/background-work/services/fgs/service-types>,
    <https://developer.android.com/develop/background-work/services/fgs/timeout>

## 6. Gmail and Microsoft OAuth

- **Gmail:**
  - `https://mail.google.com/` is a **Restricted** scope and covers IMAP, SMTP and POP.
  - Restricted-scope verification is always required (exceptions: personal or internal use).
  - Unverified apps are capped at 100 users.
  - **The CASA security assessment is required only if restricted-scope data is stored or transmitted on servers.**
    An on-device-only client needs verification but not CASA. A push relay that touches mail data would trigger CASA.
  - CASA uses assurance levels AL1/AL2 and must be revalidated every year.
    Vendor prices (old tier terms): roughly $540–1,500+ for Tier 2 and about $3,600 for Tier 3.
    How these map to AL1/AL2: **UNCONFIRMED**.
  - <https://developers.google.com/workspace/gmail/api/auth/scopes>,
    <https://developers.google.com/identity/protocols/oauth2/production-readiness/restricted-scope-verification>,
    <https://support.google.com/cloud/answer/13465431>
- **Microsoft:**
  - Register the app in Microsoft Entra.
  - Scopes: `https://outlook.office.com/IMAP.AccessAsUser.All`, `SMTP.Send`, `offline_access`, using SASL XOAUTH2.
  - Publisher verification is free and matters for multi-tenant consent.
  - Exchange Online turns SMTP Basic auth off by default at the end of December 2026 (secondary source).
  - <https://learn.microsoft.com/en-us/exchange/client-developer/legacy-protocols/how-to-authenticate-an-imap-pop-smtp-application-by-using-oauth>

## 7. Autoconfig (ISPDB)

- The ISPDB data is MPL-2.0. <https://github.com/thunderbird/autoconfig>
- A Thunderbird developer said other clients are "welcome to use it", but should send a proper User-Agent ("we see a lot of abuse").
  <https://gitlab.gnome.org/GNOME/evolution/-/issues/44>
- IETF draft-ietf-mailmaint-autoconfig-06 lists implementers: Thunderbird, K-9, FairEmail, Evolution, KMail, Nextcloud Mail and Delta Chat.
  It also names the public database `https://v1.ispdb.net/`. <https://www.ietf.org/archive/id/draft-ietf-mailmaint-autoconfig-06.txt>
- thunderbird-android, FairEmail and enough_mail all query `autoconfig.thunderbird.net/v1.1/`.
- No formal terms of service were found.

## 8. JMAP

- Servers: Stalwart, Cyrus, Apache James / tmail-backend, atmail and others; Fastmail. <https://jmap.io/software/index.html>
- Gmail and Outlook offer no JMAP; no explicit statement was found.
- Push:
  - RFC 8620 PushSubscription has the server POST to a client-supplied URL, encrypted per RFC 8291. EventSource is also defined. <https://www.rfc-editor.org/rfc/rfc8620#section-7.2>
  - A mobile app needs a relay that turns those POSTs into APNs/FCM pushes.
  - Twake Mail's backend adds a Firebase push extension instead. <https://github.com/linagora/tmail-backend>

## 9. Server-side search over IMAP

- **Dovecot:**
  - Supports ESEARCH, SEARCHRES, CONDSTORE/QRESYNC, FUZZY (RFC 6203) and CONTEXT=SEARCH. MULTISEARCH (RFC 7377) is not listed.
  - Full-text search via fts_flatcurve (Xapian) or fts_solr.
  - <https://doc.dovecot.org/main/core/summaries/rfc.html>, <https://doc.dovecot.org/main/core/plugins/fts.html>
- **Gmail:** `X-GM-RAW` accepts Gmail web search syntax; also `X-GM-MSGID`, `X-GM-THRID`, `X-GM-LABELS`.
  <https://developers.google.com/workspace/gmail/imap/imap-extensions>
- **Live pre-auth probes** (lists may change after login, **UNCONFIRMED**):

  | Server | Advertised |
  |---|---|
  | Fastmail | CONDSTORE, QRESYNC, IMAP4rev2 |
  | Outlook | No CONDSTORE, no ESEARCH |
  | Purelymail | ESEARCH, SEARCHRES, QRESYNC |
  | Zoho | ESEARCH, CONDSTORE |
