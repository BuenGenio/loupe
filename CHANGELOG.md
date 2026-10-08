# Changelog

What's new in Loupe, newest first. Every merge to `main` ships in the next
[Nightly](https://github.com/BuenGenio/loupe/releases/tag/nightly), and the
Nightly's release notes repeat the newest section below.

<!--
Each pull request with a user-visible change adds one line under today's date,
creating the heading if it isn't there yet. Say what changed for the person
using the app, in a line or two; leave out internals, refactors and tests.
-->

## 2026-10-08

- **Push** (Settings › Notifications, on by default): new mail can now wake Loupe through Google's push service, carrying no mail, only "check now". Nothing sends pushes yet; the push relay will. Needs Google Play services.
- **App Lock** (Settings › Security, off by default): your fingerprint, face or screen lock before your mail shows, when Loupe starts and when you come back after a while you choose. Recent Apps doesn't show your mail meanwhile (Android 13 and later).
- **Sign in with Google and Microsoft** is switched on in the Nightly.
- This changelog. The Nightly's release notes show its newest section.
- **Search** says so when a query can't match anything (`from:alice and not from:alice`), and doesn't ask the server.
- **Saving and exporting:** Save as File… and Share as File… in a message's ⋯ menu give you the message as an `.eml` file, and Export Folder… (long-press a folder) saves a whole folder as an mbox file.

## 2026-10-07

- **JMAP accounts** (Stalwart, Fastmail): mail, search and sending over JMAP, server rules over JMAP Sieve, and instant updates.
- **Calendar invitations:** a card with Accept, Maybe and Decline that handles updates, cancellations and replies, and shows the event's time zone next to yours.
- **S/MIME:** certificates from Android's certificate store, passphrase-protected certificates, protected headers, and opt-in revocation checks (OCSP, then CRL). The Subject stays readable to other mail apps unless you choose to hide it.
- **Reading:** while you scroll, the sender and subject move into a frosted top bar, and Aa moved to the bottom bar.
- **Navigation:** back arrows are back, with titles centred on pushed screens.
- **Subscriptions:** Mailing Lists and Subscriptions are now one screen (Newsletters | Discussions) that shows senders' names, not list ids.

## 2026-10-05

- **S/MIME:** import a `.p12` certificate, then sign, encrypt, decrypt and verify mail, checked by a security review of the new code.
- **OpenPGP:** Bcc recipients stay private, encrypted subjects are remembered for the message list, searching encrypted bodies is opt-in, and signed PGP/MIME messages display correctly.
- **Reliability:** a message the server permanently rejects stops retrying and tells you why, app upgrades are safe while syncing, and Subscriptions opens faster.

## 2026-10-04

The first Nightlies.

- **Reading:** Readable mode fits HTML mail to the screen, with footers as fine print and centred buttons, plus Original and Plain views, an attachment viewer and the message source. Developer mode adds diff highlighting, mailing-list threads, mute and reply to list.
- **Search:** pull-down search with chips or typed expressions. Results from the phone show at once and the server's follow. Smart Mailboxes are stored on your mail server.
- **Organising:** swipes with Undo, Thunderbird-compatible tags, folder subscriptions, an unread badge, snooze that works across mail apps, and an unsubscribe centre with one-click unsubscribe.
- **Rules:** device rules, server rules (Sieve over ManageSieve), and Make This a Rule from any search.
- **Writing:** identities, replies from the address a message was sent to, catch-all aliases, draft autosave, undo send, and scheduled send with an Outbox.
- **Notifications:** background sync, Archive, Mark as Read and Reply actions, an app icon badge, and experimental instant delivery.
- **Security and privacy:** an encrypted local store, remote images blocked, tracking links unwrapped, an explainable phishing check, a privacy report, and OpenPGP that works with Thunderbird (Autocrypt).
- **Accounts:** IMAP/SMTP with autoconfig, and import from Thunderbird's "Export for Mobile" QR codes.
- **Tablets and keyboards:** a three-pane layout, keyboard shortcuts, a command palette and drag and drop.
- **Look:** titles on the top line, Fluent UI icons, and the Loupe app icon.
- **Hardening:** 28 fixes, among them lost keys, duplicate sends, lost drafts and login storms. Smooth with 40,000 messages.

<!--
Reading the source of a changelog? You'd make a fine loupe.
Next clue: search for mail that is both read and unread.
-->
