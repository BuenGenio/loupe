# Mobile mail client in Flutter: plan

Status: draft 1, 2026-10-04. The app name is not final (see [NAMING.md](NAMING.md)); this document says "the app".
Facts and sources are in [research/mobile-client-2026-10.md](research/mobile-client-2026-10.md) and
[research/plugin-system-2026-10.md](research/plugin-system-2026-10.md).

## Contents

1. [Summary](#1-summary)
2. [Positioning: why build this at all](#2-positioning-why-build-this-at-all)
3. [UX: Apple Mail on the surface, Thunderbird underneath](#3-ux-apple-mail-on-the-surface-thunderbird-underneath)
4. [Readable HTML: the message reader](#4-readable-html-the-message-reader)
5. [Search](#5-search)
6. [Protocols and accounts (and JMAP)](#6-protocols-and-accounts-and-jmap)
7. [Architecture](#7-architecture)
8. [Security and privacy](#8-security-and-privacy)
9. [Phases](#9-phases)
10. [Plugins: Thunderbird add-on support or our own system](#10-plugins-thunderbird-add-on-support-or-our-own-system)
11. [Risks](#11-risks)
12. [Licensing](#12-licensing)
13. [Open decisions](#13-open-decisions)

---

## 1. Summary

A single Flutter codebase for iOS and Android. It looks and feels like Apple Mail: calm, few buttons, gestures.
Thunderbird-desktop power features sit one tap or long-press away.

- **Readable mode is the default message view.**
  - HTML mail is rebuilt from a strict allowlist and rendered natively, with no WebView and no JavaScript.
  - It keeps structure, colours, highlights, bold/italic and images, all scaled to the screen width.
  - Several images become a swipeable gallery.
  - One button switches to Original HTML or Plain text (Sans or Mono).
- **Search** is an Apple-Mail-style bar that slides down from the top.
  - Local results appear at once; server results (IMAP SEARCH, Gmail `X-GM-RAW`, JMAP `Email/query`) stream in after.
  - Power users can type the Expression Search language from the desktop add-on.
- **Protocols:** IMAP/SMTP in v1, because almost every user needs it.
  - JMAP is a first-class second protocol (Phase 3). The internal data model follows JMAP from day one.
- **Plugins:** running Thunderbird add-ons is not realistic, and v1 doesn't need plugins.
  - If we open the app to third parties later, plugins should be TypeScript running in a sandboxed QuickJS engine, with declarative UI.
  - Node.js is for the developer tooling only. See [§10](#10-plugins-thunderbird-add-on-support-or-our-own-system).
- **Rough timeline** with 1–2 full-time Flutter developers: about 6 weeks of spikes, then about 5 months to a public beta (MVP).
  The power-user layer and JMAP follow within about a year.

## 2. Positioning: why build this at all

**What exists (October 2026):**
- **Thunderbird for Android** (K-9 based, Kotlin) is at 23.1. It supports no add-ons, and the team said in 2024 that add-ons are unlikely "within the next two years".
- **Thunderbird for iOS** is a native Swift/SwiftUI app. Community testing is expected "in the next few months", and JMAP is not on its 2026 roadmap.
- Both are good, conventional, platform-specific apps.

**Trademark:** the app must not have "Thunderbird" in its name or icon. Mozilla's policy allows true statements in words
such as "works with Thunderbird tags and filters", but not names like "X for Thunderbird". Marketing wording needs legal review.

**Where we differ:**

| | Official TB mobile | Apple Mail / Gmail | This app |
|---|---|---|---|
| Badly formatted HTML mail | Rendered as sent (zoom and pan) | Rendered as sent | Readable mode rebuilds it to fit the screen |
| Search | Basic | Good, but no boolean logic | Instant local results plus server results, with the full boolean expression language |
| Power features (tags, rules, raw source, identities, saved searches) | Some | Few | All of them, behind progressive disclosure |
| JMAP | No | No | Yes (Phase 3) |
| Codebase | Two native apps | — | One Flutter app; tablets and foldables included |
| Tracking protection | Remote images blockable | Mail Privacy Protection (proxy) | Blocked by default, tracking pixels removed, link checks |

This is not a Thunderbird replacement. It's a mobile companion for people who use Thunderbird or another desktop client and want the same power on the phone.

## 3. UX: Apple Mail on the surface, Thunderbird underneath

**Principle:** *simple by default, powerful on demand.*
- Every screen should feel like Apple Mail on first use.
- Power features are hidden in four places:
  - long-press menus;
  - the "…" menu;
  - the search language;
  - Settings › Advanced.
- No power feature may add a permanent button to the main surfaces.

**Visual design:**
- One custom design system for both platforms, close to Apple Mail:
  - system fonts (San Francisco / Roboto);
  - generous whitespace and hairline separators;
  - the system accent colour;
  - large collapsing titles.
- Behaviour follows each platform: back gestures, page transitions, haptics, share sheets and the system keyboard.
- Thunderbird touches:
  - account colour stripes;
  - tag colours (defaults match TB: Important red, Work orange, Personal green, To Do blue, Later purple);
  - a nested folder tree;
  - a density setting (Comfortable or Compact).
- Light and dark mode, plus Dynamic Type and font scaling everywhere.

### Screens

1. **Mailboxes** (Apple Mail's first screen).
   - All Inboxes, VIP, Flagged, Unread, then each account's folders (collapsible tree).
   - Then *Smart Mailboxes* (saved searches) and *Tags*.
   - "Edit" reorders the list and hides items.
2. **Message list.**
   - Large title, with the search bar hidden above the list ([§5](#5-search)).
   - Rows show sender, subject, 2-line preview, date, unread dot, VIP star, paperclip, tag dots and thread count.
   - Configurable swipes: leading = read/unread; trailing = archive or delete plus "More"; long swipe = default action.
   - Bottom toolbar:
     - a **Filter** button, as in Apple Mail. Tap it to toggle; tap its label to pick criteria: Unread, Flagged, To me, CC me, With attachments, **Unreplied**, From VIPs, Tag….
       This is Thunderbird's quick filter bar presented the Apple Mail way.
     - an "Updated just now" status line;
     - Compose.
   - Multi-select through Edit or a two-finger swipe.
3. **Message / conversation.**
   - The header shows avatar, sender, date and the short recipient list; tap it to expand all addresses and the authentication result (DKIM/SPF/DMARC from `Authentication-Results`).
   - Body in Readable mode ([§4](#4-readable-html-the-message-reader)), with an **Aa** button for view options.
   - Conversations stack the messages and collapse quoted text.
   - Bottom toolbar: flag, move, archive/delete, reply (long-press for Reply All / Forward), compose.
4. **Compose.**
   - Plain or simple rich text, an identity picker, attachments and photo picker, and signatures.
   - **Undo send:** a local delay of 5–30 s.
   - Scheduled send (Phase 2).
   - Drafts are saved to the server.
5. **Power layer** (only reachable through menus):
   - **Raw source**, all headers, and "Save as .eml".
   - **"Search from this message"** (the add-on's feature): long-press a sender, subject or date to search for it.
   - Rules: local rules, plus server-side Sieve via ManageSieve or JMAP Sieve.
   - Tags: IMAP keywords compatible with TB's `$label1…5` and custom keywords.
   - Junk / Not junk: moves the message and sets TB's `Junk`/`NonJunk` keywords.
   - Multiple identities per account; "Reply from the address it was sent to".
   - Per-folder sync settings, offline download window, and showing folder sizes.
   - On tablets: a 3-pane layout like TB desktop, keyboard shortcuts, and a command palette (⌘K / Ctrl+K).
6. **Settings:** two levels.
   - **Essentials:** accounts, notifications, swipes, appearance, signature.
   - **Advanced:** sync, server details, privacy, search, developer (protocol log export).

## 4. Readable HTML: the message reader

**Goal:** any message, however badly built, can be read at a comfortable text size without zooming or horizontal scrolling.
It should still look like the sender intended: emphasis, colours, highlights, images and links.

### View modes

The **Aa** button opens a sheet with these options:

| Mode | What it is | Default |
|---|---|---|
| **Readable** | HTML rebuilt from an allowlist and rendered natively. | Yes |
| **Original** | The sender's HTML in a locked WebView: JavaScript off, a strict CSP, remote loads blocked unless allowed. | Fallback |
| **Plain text** | The `text/plain` part, or text generated from the HTML. Font: **Sans** or **Mono**. | Per sender |

The sheet also has text size and "Remember for this sender".
The setting is stored per sender and per domain, so a newsletter can always open as plain text.

### Pipeline

The pipeline runs in a background isolate, with limits on size, nesting depth and time.

1. **Pick the parts.**
   - Use `text/html` if present, otherwise `text/plain`.
   - Resolve `cid:` references in `multipart/related` and decode `data:` URIs.
2. **Parse** with `package:html`, an html5lib port that recovers from broken markup the way browsers do.
3. **Clean.**
   - Remove these elements: `script`, `style`, `head`, `meta`, `link`, `iframe`, `object`, `embed`, `svg`, `form` controls (their text is kept) and comments.
   - Remove hidden content: `display:none`, `visibility:hidden`, `opacity:0`, `font-size:0`, `max-height:0`, `mso-hide:all`.
     This catches preheaders and spam padding.
   - Remove **tracking pixels**: images of 1–2 px, invisible images, and images from known tracker hosts.
   - Before step 4, inline simple `<style>` rules (tag, class and id selectors only), so that class-based colours and bold text survive. (Phase 2)
4. **Rebuild layout.**
   - **Layout tables** (a `role="presentation"` attribute, nesting, cells containing blocks, no `th`) are linearised into blocks in reading order.
   - **Data tables** (`th` cells, a regular grid, short cells) stay tables and scroll horizontally on their own.
   - Multi-column newsletters become a single column.
   - `center`, `font`, `div` and `span` keep only allowed styles.
5. **Allowlist.**
   - Elements: `p br hr h1–h6 blockquote pre code ul ol li dl dt dd a b strong i em u s del sub sup small mark img table tr td th span`.
   - Styles:
     - `color` and `background-color` on text, which carries highlights;
     - `font-weight`, `font-style` and `text-decoration`;
     - `text-align` (centre and right, for short blocks only);
     - monospace detection (Courier, Consolas, Menlo, `monospace`) → code style;
     - `font-size` mapped to a few relative steps between 0.85× and 1.5×, so large text becomes a heading.
   - Dropped: widths and heights (images keep their aspect ratio), positioning, floats, margins and padding (our own spacing is used), font families, line height, letter spacing and background images.
6. **Links.**
   - Long-press shows the real target.
   - If the link text is a domain that differs from the target, the user gets a warning.
   - Stripping tracking parameters (`utm_*`, …) is optional.
   - Links open in the in-app browser (SFSafariViewController or Custom Tabs).
   - "Button" links (anchors with a background colour) render as button chips.
7. **Images.**
   - Inline images (`cid:` and `data:`) show immediately.
   - **Remote images are blocked by default.**
     - A banner offers "Load images" plus "Always for this sender / domain".
     - There is no proxy, so loading reveals the IP address. The UI says so.
   - Every image is **scaled to fit** the screen width and keeps its aspect ratio. Spacer images are dropped; small icons stay inline.
   - **Two or more consecutive images** become an inline **carousel**, a swipeable strip with page dots.
   - Tapping any image opens a **full-screen gallery** (PageView plus pinch-zoom).
     It covers all images in the message, including image attachments, and offers share and save.
8. **Colour and dark mode.**
   - Check the contrast of every text/background pair.
   - In dark mode, flip the lightness of colours (in OKLCH, keeping the hue) wherever contrast against the app background would fall below WCAG 4.5:1.
     Highlights keep their hue, so a yellow highlight stays recognisable.
   - The option "Keep original colours" turns this off.
9. **Render.**
   - The sanitised DOM is converted into a small document model (blocks plus styled inline spans), which is rendered with native Flutter widgets.
     Rendering is lazy: a sliver list of blocks, so long messages stay smooth.
   - Nothing executes, and text selection, accessibility and Dynamic Type come for free.
   - Phase 0 decides whether to write the renderer ourselves or build on `flutter_widget_from_html` (MIT, active). `flutter_html` is stalled.
10. **Fallback.**
    - If the result looks wrong (for example most of the content was removed, or the message is an image-only newsletter), show the hint "This message may look better in Original view". Never switch automatically.

### Plain text view

- Prefer the sender's `text/plain` part. Otherwise generate text from the HTML, with links as numbered footnotes.
- Reflow `format=flowed` text (RFC 3676).
- Show quotes as coloured bars per level, as in TB and Apple Mail, and dim signatures (`-- `).
- Make URLs and addresses clickable.
- **Sans / Mono toggle.** Mono keeps ASCII tables and code aligned. Long lines wrap; horizontal scrolling is optional in Mono.

### Original view (WebView)

- Use `flutter_inappwebview`, because its content blockers can stop remote loads. `webview_flutter` can't intercept subresources.
- Inject `Content-Security-Policy: default-src 'none'; img-src cid: data: [https: once allowed]; style-src 'unsafe-inline'`.
- Inject a viewport meta tag and `img{max-width:100%}`.
- Turn JavaScript off.
- Send navigation to the in-app browser.

### Quality bar

- Build a **corpus of about 200 real-world messages**, anonymised: newsletters, receipts, Outlook and Gmail forwards, Apple Mail mail, mailing lists, broken HTML, image-only mail and RTL text.
- Run golden tests on both the sanitiser output (DOM snapshot) and the rendered widgets.
- A sanitiser change ships only if it improves the corpus without regressions.

## 5. Search

### Interaction (Apple Mail style)

- The search field sits **hidden above the message list** and slides into view when the list is pulled down; tapping the title area also shows it.
  - Flutter's `CupertinoSliverNavigationBar.search` covers this pattern on recent Flutter versions. Check it in Phase 0; the fallback is a custom sliver.
- **When focused:**
  - a scope control appears: **All Mailboxes | This Mailbox**;
  - below it, suggestions: recent searches, people, "Unread", "Flagged", "With attachments", tags and Smart Mailboxes.
- **While typing:**
  - suggestions turn into **chips** ("From: Alice", "Subject: invoice", "Has attachment");
  - chips can be combined, and long-pressing a chip negates it or turns it into OR.
- **Power users** can type the **Expression Search language** directly, for example `f:alice and (s:invoice or b:"PO 123") and after:2026-01-01 and not is:read`.
  - Chips and text are two views of the same AST, so either can be edited.
  - Long-pressing the field opens the **advanced search builder**, similar to TB's search dialog.
- Results show highlighted matches.
- "Save as Smart Mailbox" turns a query into a saved search.

### Execution: local first, server in parallel

1. **Local (under 50 ms):**
   - SQLite FTS5 over cached headers, previews and downloaded bodies.
   - Results appear while the user types (debounced at about 150 ms).
2. **Server (streamed):**
   - Starts after about 300 ms, or on Return, with one task per account.
   - Results are merged and de-duplicated by Message-ID and UID.
   - "From server" rows appear with a subtle marker, and each account shows a spinner.
   - Only header and preview are fetched for result rows; the body loads when a message opens.
3. **Cancel on change.**
   - IMAP can't cancel a running command, so search runs on a separate pooled connection that is dropped when the query changes.

### One AST, four compilers

The `expr_search` package ports the parser of the Expression Search Reloaded add-on (see [§12](#12-licensing) for licensing).
The add-on and the app share **one JSON file of test vectors**, so the language stays identical.

| Target | How |
|---|---|
| Local SQLite | FTS5 `MATCH` for text terms and SQL `WHERE` for flags, dates, size and tags. Regex is evaluated in Dart. |
| IMAP | `UID SEARCH` keys. IMAP has `OR`, `NOT` and parentheses, so **the whole boolean tree maps directly**, unlike TB's quick filter. Use `ESEARCH RETURN (ALL COUNT)` and `CHARSET UTF-8` / `UTF8=ACCEPT` when available. Searches run across folders in parallel, with at most 2–3 connections per account. |
| Gmail | **`X-GM-RAW`** with Gmail's own syntax, run once against "All Mail". This is fast and matches the web UI. enough_mail lacks it: send it as a raw command, or contribute it upstream. |
| JMAP | `Email/query` with a nested `FilterOperator` tree, back-referenced `Email/get`, and `SearchSnippet/get` for highlights. **One HTTP round-trip.** |

**Terms the server can't evaluate** (regex, `simple:`, time-of-day and similar):
- The compiler works on the negation normal form, which is monotone in its literals. Replacing an unsupported literal with TRUE therefore always gives a *superset*.
- The server runs that broader query, and the client post-filters the results locally. Results stay correct; they just take a little longer.

**Server speed:** it depends on the server's full-text index.
- Fast: Gmail, Fastmail, Dovecot with `fts_flatcurve`/Solr, Stalwart.
- Without an index, `BODY` search over large folders can be slow. In that case, search headers first, then bodies, and show progress.

## 6. Protocols and accounts (and JMAP)

### "JMAP?" Yes, first-class, but second in line

- **Why not first:**
  - Gmail, Outlook/M365, iCloud and Yahoo offer only IMAP.
  - JMAP servers are Fastmail, Stalwart, Cyrus, Apache James / Twake, atmail and similar.
  - An app without IMAP has almost no users.
- **Why first-class:**
  - It syncs efficiently (`*/changes` with state strings) and supports full boolean search in one round-trip.
  - It returns snippets, and sends mail through `EmailSubmission` (no separate SMTP).
  - It has Sieve over JMAP (RFC 9661) and push that needs no persistent connection (RFC 8620/8887).
  - JMAP is the better protocol for mobile.
- **How:**
  - The internal **data model follows JMAP** from day one: mailboxes with roles, emails with keywords, threads and identities.
  - IMAP is an adapter that maps to it (flags → keywords, SPECIAL-USE → roles).
  - Adding JMAP in Phase 3 then means adding a transport, not rewriting the app.
  - If your own mail is on Fastmail or Stalwart, JMAP can move earlier, in parallel with Phase 2.

### Libraries

| Need | Choice | Note |
|---|---|---|
| IMAP, SMTP, MIME | **enough_mail** (MPL-2.0) | Supports IDLE, CONDSTORE, QRESYNC, ESEARCH, MOVE, UIDPLUS, METADATA and more. **Effectively one maintainer.** Wrap it behind our own `MailTransport` interface, contribute fixes upstream, and budget for maintaining a fork. |
| JMAP | **jmap-dart-client** (MIT, Linagora) | A git dependency pinned to a commit. JMAP is plain JSON over HTTPS, so our own small client is a cheap fallback. |
| OAuth | flutter_appauth (PKCE, system browser) | |
| Secrets | flutter_secure_storage 11 | Keychain on iOS, Keystore on Android. |

### Account setup

1. The user enters an email address.
2. Look up the **ISPDB** (`autoconfig.thunderbird.net/v1.1/`, sending a descriptive User-Agent as Thunderbird's developers asked), then the domain's own autoconfig and MX-based guesses.
3. Look up JMAP through `.well-known/jmap` and SRV records.
4. Fall back to manual setup.

| Provider | Method | Prerequisite |
|---|---|---|
| Gmail | OAuth (`https://mail.google.com/`, a **restricted** scope) | **Google verification.** As long as no server of ours touches mail data, CASA is not required. Unverified apps are capped at 100 users. **Start in Phase 0**, because of the lead time. |
| Microsoft 365 / Outlook.com | OAuth: `IMAP.AccessAsUser.All`, `SMTP.Send`, `offline_access` | A multi-tenant Microsoft Entra app plus publisher verification (free). SMTP Basic auth ends in December 2026, so OAuth is mandatory. |
| iCloud | App-specific password | Explain it in onboarding, with a link. |
| Yahoo / AOL | OAuth (needs approval) or an app password | |
| Fastmail | JMAP (Phase 3), or IMAP with an app password | |
| Generic IMAP | Password or app password | TLS required ([§8](#8-security-and-privacy)). |

**Not in v1:** POP3, Exchange EWS/ActiveSync, Microsoft Graph mail. M365 works over IMAP with OAuth.

## 7. Architecture

### Stack

- **App framework:** Flutter stable, Dart 3, using pub workspaces.
- **State:** Riverpod. **Navigation:** go_router.
- **Storage:** drift on SQLite through `sqlite3` build hooks, with **FTS5** and encryption via **sqlite3mc** (or SQLCipher).
  - The old `sqlite3_flutter_libs` and `sqlcipher_flutter_libs` packages are end-of-life; don't use them.
  - The database key lives in the Keychain or Keystore.
- **Isolates:** one sync isolate per account, plus a parsing isolate for MIME and HTML. The UI isolate does no I/O parsing.

### Packages (monorepo)

```
packages/
  mail_model/     JMAP-shaped domain model, value types, no I/O
  mail_imap/      IMAP/SMTP transport (wraps enough_mail)
  mail_jmap/      JMAP transport (wraps jmap-dart-client)          Phase 3
  mail_store/     drift schema, FTS5, migrations, encryption
  mail_sync/      sync engine, offline operation queue, conflict rules
  expr_search/    expression language: parser, AST, compilers (SQL / IMAP / X-GM-RAW / JMAP)
  readable/       MIME part selection, sanitiser, layout linearisation, document model, renderer
  mail_crypto/    OpenPGP / S/MIME                                  Phase 4
  plugins/        plugin host (see §10)                             Phase 5, only if needed
app/              UI, design system, platform glue
relay/            optional push relay, separate deployable          Phase 3
```

### Sync

- **Download on sync:** headers, envelope, flags, `BODYSTRUCTURE` and the first few KB of text (for previews and search).
  Full bodies and attachments load on demand.
  The "Keep recent mail offline" option (default 30 days) downloads more ahead of time.
- **Incremental resync:**
  - With CONDSTORE/QRESYNC: `MODSEQ` for flags and `VANISHED` for deletions.
  - Without them: a UID range diff.
- **Offline operations** (flag, move, delete, send) are queued, applied optimistically in the UI, and replayed in order.
  Conflicts resolve as "server wins, but never lose a draft or an outgoing message".
- **Threading:**
  - Gmail: `X-GM-THRID`. JMAP: `threadId`.
  - Everyone else: `References`/`In-Reply-To` (the JWZ algorithm), with subject fallback.

### Background and notifications

**Android:**
- WorkManager polls every 15 minutes by default.
- An optional "real-time" toggle runs a foreground service holding IMAP IDLE (type `specialUse`, which needs a Play Console justification; `dataSync` is capped at 6 h a day on Android 15+).
- This is what Thunderbird for Android does.

**iOS:**
- **A persistent IDLE connection is impossible on iOS.**
- `BGAppRefreshTask` gives occasional runs of about 30 seconds, at times the system chooses, and the app syncs when opened.
- Real-time notifications need a push relay.

**Optional push relay (Phase 3, a decision for you):**
- A **stateless** service that receives provider change notifications and forwards **content-free** "sync now" pushes through APNs/FCM:
  - JMAP PushSubscription;
  - Microsoft Graph change notifications;
  - Gmail `users.watch` through Pub/Sub, whose payload is only the email address and a history ID.
- The relay never stores credentials and never sees mail content.
- **UNCONFIRMED:** whether Google treats the Gmail Pub/Sub route as "server access to restricted data", which would require CASA. Ask Google before building it.
- Generic IMAP servers have no standard push. Dovecot's Apple-push plugin and Delta Chat's METADATA approach are niche.
- Spark's model (its servers hold your tokens and poll) is ruled out for privacy reasons.

### Testing and CI

- Unit tests: parser, compilers, sanitiser and sync state machine.
- Golden tests: the corpus from [§4](#4-readable-html-the-message-reader).
- Integration tests against servers in containers: Dovecot (IMAP, with and without FTS), Stalwart (IMAP and JMAP) and GreenMail.
- GitHub Actions: `dart analyze`, tests, goldens, and Android and iOS builds; TestFlight and Play internal track from Phase 1.
- Manual smoke tests against real Gmail, M365, iCloud and Fastmail test accounts before each release.

## 8. Security and privacy

- **No servers in v1.**
  - The device talks directly to the mail providers.
  - No telemetry; crash reporting is opt-in only.
  - A privacy policy is still needed for Google verification and the store listings.
- **Credentials and data:**
  - Tokens and passwords are kept in the Keychain or Keystore.
  - The database is encrypted with sqlite3mc.
  - Attachment caches are protected by iOS Data Protection (complete) and Android's app-private storage.
  - Optional biometric app lock, and app-switcher blur.
- **TLS only.**
  - Implicit TLS or STARTTLS, with no silent downgrade.
  - Self-signed certificates only through explicit trust-on-first-use with the fingerprint shown. No certificate pinning (it would break self-hosted servers).
- **Remote content:**
  - Blocked by default, tracking pixels removed.
  - Link-mismatch warnings; tracking-parameter stripping is optional.
  - Readable mode has no JavaScript and no WebView at all.
- **Hostile input:** MIME and HTML are parsed in isolates, with size, depth and time limits (deep nesting, zip-bomb-like structures).
- **Supply chain:**
  - Pinned dependencies, a pub.dev verified-publisher preference, Dependabot, an SBOM per release and reproducible CI builds.
  - Minimal permissions.

## 9. Phases

Estimates assume **1–2 full-time Flutter developers** plus part-time design help. Double them for one part-time developer.

### Phase 0: spikes and decisions (4–6 weeks)

- **Name and trademark checks** ([NAMING.md](NAMING.md)); reserve the bundle IDs, domain and store names.
- **Readable spike:** our own renderer vs `flutter_widget_from_html`, tested on 50 corpus messages.
  - Measure readability, performance on long newsletters, and text selection.
- **Sync spike:** enough_mail against Gmail, M365, iCloud, Fastmail and Dovecot.
  - Cover CONDSTORE/QRESYNC, IDLE, and `X-GM-RAW` as a raw command.
- **Storage spike:** drift, FTS5 and sqlite3mc on both platforms (build hooks, binary size).
- **OAuth:** Gmail and Microsoft. **Create the Google Cloud project and start restricted-scope verification now.**
- Port the **expression parser** to Dart, sharing JSON test vectors with the add-on.
- Set up the CI skeleton and choose a licence ([§12](#12-licensing)).
- **Exit criteria:** the rendering approach is chosen, sync works on the big four providers, and the name is chosen.

### Phase 1: MVP and public beta (about 4–5 months)

- **Accounts:** IMAP/SMTP for Gmail, M365, iCloud, Fastmail and generic servers; OAuth; autoconfig.
- **Reading:**
  - unified inbox, folder tree, message list with swipes, conversation view;
  - Readable, Original and Plain (Sans/Mono) views, with the per-sender memory;
  - remote-image blocking and the image gallery and carousel.
- **Writing:**
  - compose, reply and forward; attachments; drafts;
  - undo send; outbox with offline queue.
- **Search:** the pull-down bar, local FTS5 plus server search, basic chips, recent searches.
- **Filter button:** Unread, Flagged, Attachments, Unreplied, To me.
- **Background:** notifications (Android WorkManager plus the IDLE option; iOS background refresh).
- **Security:** encrypted store, app lock, dark mode, accessibility.
- **Release:** beta on TestFlight and the Play open testing track.

### Phase 2: the power layer (about 3 months)

- **Search:** the full expression language with the chip ↔ text round-trip; the advanced search builder; Smart Mailboxes.
- **Tags** (TB-compatible), rules and Sieve, multiple identities.
- **Message tools:** raw source and headers, "Search from this message", the DKIM/SPF/DMARC display.
- **Tablets:** 3-pane layout, keyboard shortcuts, command palette.
- **Sending and reading:** scheduled send, `<style>` inlining in Readable mode.

### Phase 3: JMAP and push (about 2–3 months)

- **JMAP accounts:** Fastmail and Stalwart, using `Email/query` search, `EmailSubmission` and Sieve.
- **Push relay** (if you choose to run one): JMAP and Graph first; Gmail only after Google confirms.

### Phase 4: encryption (about 2–3 months)

- **OpenPGP:** compatible with Thunderbird, plus Autocrypt.
  - Implementation: `dart_pg` (pure Dart), or RNP/Sequoia over FFI. RNP is what TB desktop uses.
- **S/MIME** through the platform keychains.

### Phase 5: plugins (only if justified)

See [§10](#10-plugins-thunderbird-add-on-support-or-our-own-system).

## 10. Plugins: Thunderbird add-on support or our own system

### 10.1 Can the app run Thunderbird add-ons? No, not realistically

1. **The API surface is huge and desktop-shaped.**
   - Thunderbird's MV3 docs list **61 API entries** (51 namespaces plus 10 sub-namespaces).
   - Many depend on the desktop UI: tabs, windows, spaces, compose windows, message display scripts that inject into the message DOM, toolbar buttons and menus.
   - Even a perfect implementation would show buttons that make no sense on a phone.
2. **Half of popular add-ons can't be ported at all.**
   - **49% of the top 100** add-ons, covering **67% of users** (and **9 of the top 10**), use **Experiments**. These are privileged Gecko/XPCOM code that call Thunderbird internals directly.
   - Without the Gecko engine they can't run. Expression Search Reloaded is one of them.
3. **Thunderbird's own mobile apps don't support add-ons** and won't for years, so there is no mobile add-on ecosystem to be compatible with.
4. **The app stores restrict it.**
   - Apple 2.5.2 and 4.7 allow downloaded JavaScript "plug-ins" only under conditions:
     - no native APIs exposed without Apple's permission (4.7.2);
     - user consent for each data share (4.7.3);
     - no store-like catalogue (3.2.2(i)).
   - Google Play allows interpreted JavaScript, but no native code.

**The most that is realistic:** a thin "MailExtension-lite" **porting shim** — a `messenger.*` polyfill for a small subset (`messages.query/get/getFull/update`, `folders`, `accounts` read, `storage.local`, a message-context action).
- Few existing add-ons would run unchanged; most that avoid Experiments still use compose, tabs or display scripts.
- Its value is making ports *easier* for authors, not compatibility.
- It only makes sense after our own plugin system exists (10.3).

### 10.2 Is a plugin system needed? Not for v1

Most popular TB add-ons fill gaps in desktop Thunderbird. On mobile, the better answer is to build these features in:

| Popular add-on | Need | In the app |
|---|---|---|
| Expression Search (ours), Conversations, QuickFolders | Search, threads, favourite folders | Native (§3, §5) |
| Send Later, Quicktext | Scheduled send, templates | Native (Phase 2) |
| DKIM Verifier | Show authentication results | Native: parse `Authentication-Results` (Phase 2) |
| FiltaQuilla | More rule actions | Native rules plus Sieve |
| ImportExportTools NG | Export and import | "Save as .eml", share, export a folder as mbox (later) |
| CardBook, Provider for Google Calendar, TbSync, Owl | Contacts, calendar, Exchange | Use the OS contacts and calendar; Exchange is out of scope |

**Recommendation:**
- v1 ships **"batteries included"** and **no third-party plugins**.
- From day one, design **internal extension points** as Dart interfaces and implement the built-in features against them:
  - message actions;
  - message-view decorators (banners and cards);
  - search operators;
  - compose helpers;
  - rule actions;
  - account and transport providers.
- That keeps the code modular, and it tests the future plugin API with real features before outsiders depend on it.
- **Open to third parties** only when there's real demand that native features can't cover: CRM and ticketing integrations, AI assistants, company workflows, custom rule actions.

### 10.3 If we build our own: TypeScript in a QuickJS sandbox

**Language and runtime:** plugins are written in **TypeScript** and compiled to JavaScript, which runs in an **embedded QuickJS engine**.

| Option | Verdict |
|---|---|
| **TypeScript → JS in QuickJS** | **Recommended.** <ul><li>The largest developer pool, and the same language as Thunderbird and Firefox WebExtensions, so porting is easy.</li><li>It fits Apple 4.7 (JavaScript plug-ins) and Google Play's interpreter exception.</li><li>QuickJS is small, embeddable and actively maintained (quickjs-ng). It can limit memory and interrupt runaway scripts.</li><li>Flutter bindings: `fjs` (Rust + QuickJS, active) or `flutter_js`. Spike both, or write our own FFI to quickjs-ng.</li><li>Interpreted only (no JIT on iOS), which is fine for event-driven mail plugins.</li></ul> |
| **Node.js** | **Tooling only, not at runtime.** <ul><li>nodejs-mobile is a stale community fork (Node 18, which is end-of-life) with no Flutter support.</li><li>It has no sandbox (full file system and network), adds tens of MB, and carries App Store risk.</li><li>Use Node for the **developer kit** instead: `create-<app>-plugin`, the `@<app>/plugin-api` TypeScript types, an esbuild bundler, a local test harness, and packaging and signing.</li></ul> |
| JS in a hidden WebView (Obsidian, Joplin) | Fast (WKWebView has JIT) and fine for UI panels. As a *logic* sandbox it is harder to control (memory, network, lifecycle). Use it only for optional UI panels (below). |
| WebAssembly | Later, for compute-heavy plugins (spam scoring, crypto). It is interpreter-only on iOS (Wasmtime's Pulley interpreter, wasm3), so slow. QuickJS compiled to Wasm (Figma's approach) is an option for stronger isolation. |
| Dart | **Impossible.** AOT release builds can't load Dart code, and Dart's experimental "Dynamic Modules" are explicitly not meant for untrusted code. |
| Lua | Embeddable and sandboxable, but a small ecosystem and no porting path from Thunderbird. |

**Runtime design:**
- **Isolation:**
  - Each plugin gets its own QuickJS context in a background isolate.
  - Limits on memory, CPU time (interrupt handler) and message size.
  - **No ambient APIs:** no `fetch`, file system or timers unless granted. Everything goes through an async host bridge that checks capabilities.
- **Manifest:** a WebExtension-style `manifest.json` with **fine-grained permissions**, shown at install and revocable:
  - `messages.read:headers`, `messages.read:body`;
  - `messages.modify:flags|tags`, `messages.move`;
  - `compose.read`, `compose.modify` (shown with the strongest warning: outgoing mail);
  - `network:https://api.example.com/*` (explicit host list);
  - `storage`.
- **UI is declarative first:**
  - Plugins contribute actions (message and list menus, toolbar), message-view **cards and banners** (JSON → native widgets, like Gmail's card add-ons), search operators, rule actions and a settings schema that generates its own UI.
  - An **optional sandboxed WebView panel** is the escape hatch for rich UIs (CSP, no network unless granted, `postMessage` bridge), like Outlook and Joplin.
- **Distribution and trust** (lessons from real incidents):
  - **Signed, immutable packages with all code bundled.** Never load remote code.
    - In AgreeToSteal (2026), a reviewed Outlook add-in's hosting URL was taken over later, and it served phishing.
  - Publisher accounts need 2FA, and signing keys stay offline.
    - In Cyberhaven (2024), a phished developer account pushed a malicious update.
  - Updates are reviewed, with a remote **block list / kill switch**.
  - Show network destinations and changes to outgoing mail visibly.
    - In postmark-mcp (2025), a plugin silently BCC'd every sent message.
  - **iOS:** a **curated list of reviewed plugins**, not a store-like marketplace, as Joplin does on iOS. Per-plugin consent prompts satisfy 4.7.3.
  - **Android:** the same list, plus sideloading in developer mode.
- **Effort:** about 3–4 months for the runtime, bridge, permissions, card UI, SDK, docs, 5–8 sample plugins and review tooling.
  After that there is a **permanent review and maintenance cost**, which is the main reason to wait until demand is clear.

### 10.4 Verdict

| Question | Answer |
|---|---|
| Run Thunderbird add-ons? | **No.** Half of popular add-ons depend on Gecko internals, and the rest assume a desktop UI. A porting shim is possible later. |
| Plugins needed for v1? | **No.** Build the top add-on features natively, and design internal extension points. |
| Our own system later? | **Yes, if there is demand**, after v1 is stable. |
| Language? | **TypeScript** compiled to JS, in a **QuickJS sandbox**, with declarative UI and an optional sandboxed WebView. |
| Node? | **For tooling only** (SDK, CLI, bundling, tests). Not on the device. |

## 11. Risks

| Risk | Impact | Mitigation |
|---|---|---|
| enough_mail has one maintainer | High | A `MailTransport` interface, upstream contributions, budget to maintain a fork. JMAP lowers the dependency. |
| iOS background limits mean no instant notifications | High | Be honest in onboarding; background refresh; push relay via provider webhooks (Phase 3). |
| Gmail verification is slow or rejected | High | Start in Phase 0; minimal scope; clear privacy policy; no server touches mail data. |
| Readable mode mangles some messages | Medium | Corpus and goldens; one-tap Original view; the "looks better in Original" hint. |
| Performance on very large mail and folders | Medium | Isolates, lazy rendering, size caps, paging. |
| Official TB iOS/Android apps improve fast | Medium | Differentiate: Readable mode, search, power layer, JMAP, tablets. |
| Naming or trademark conflict | Medium | No "Thunderbird"; checks in Phase 0 ([NAMING.md](NAMING.md)). |
| Store review (background modes, plugins) | Medium | Standard modes only; no plugins in v1. |
| Licence contamination | Medium | Don't copy GPL/AGPL code from Maily or Twake Mail ([§12](#12-licensing)). |
| Scope creep or burnout | High | Strict phase gates; v1 = §9 Phase 1 and nothing more. |

## 12. Licensing

- **Recommended:** **MPL-2.0** for the app, the same as Thunderbird.
  - It is compatible with enough_mail (MPL-2.0), jmap-dart-client (MIT) and the ISPDB data (MPL-2.0).
  - It causes no App Store friction; Firefox for iOS is MPL.
  - Its copyleft is per file, so contributors can reuse code freely.
- **GPL-3.0** would allow borrowing code from **Maily** (GPL-3.0). Code from **Twake Mail** is AGPL-3.0 and would make the app AGPL.
  - GPL apps on the App Store work only if all copyright holders agree: a CLA, or an App Store exception, as Signal does.
  - **Recommendation:** borrow ideas from both, but no code.
- **Expression parser:** the Expression Search Reloaded add-on is **GPL-3.0**, and its parser builds on earlier GPL work. Under MPL-2.0 there are two options:
  - **write `expr_search` from scratch in Dart** from the documented syntax (the help page), sharing only behavioural test vectors (inputs and expected outputs);
  - or get permission from the earlier copyright holders.
  - Don't translate the JavaScript line by line.
  - If you choose GPL-3.0 for the app instead, the port is straightforward.

## 13. Open decisions

1. **Name** — see [NAMING.md](NAMING.md). Recommendation: **Kestrel**, or **Loupe** for continuity with the add-on's magnifier logo.
2. **Licence** — MPL-2.0 (recommended) or GPL-3.0 ([§12](#12-licensing)).
3. **Team and time budget** — the phases assume 1–2 full-time developers.
4. **Push relay** — run one (hosting costs, privacy trust, Google's view) or accept delayed notifications on iOS?
5. **JMAP timing** — Phase 3, or in parallel with Phase 2 if your own mail is on Fastmail or Stalwart?
6. **Money** — free and open source with donations, or paid extras? Costs include developer accounts and domains, and CASA if any server ever touches Gmail data.
7. **Platforms** — iOS and Android from day one (recommended); desktop Flutter builds are a non-goal.
