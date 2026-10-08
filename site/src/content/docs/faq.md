---
title: "Frequently asked questions"
description: "Answers about Loupe: cost, open source, privacy, Gmail and Outlook, iOS, Thunderbird, Exchange and POP3, and why you install it from an APK."
section: "Reference"
order: 190
---

Short answers to the questions people ask most about Loupe. If yours isn't here, see [Troubleshooting](/docs/troubleshooting/) or ask on [GitHub](https://github.com/BuenGenio/loupe/issues).

### Is Loupe free?

Yes. Loupe is free to download and use, and it has no ads.

### Is Loupe open source?

Yes. Loupe's source code is public on [GitHub](https://github.com/BuenGenio/loupe) under the Mozilla Public License 2.0 (MPL-2.0), the same licence Thunderbird uses. Anyone can read it, build it and check what it does.

### Does Loupe collect any data about me?

No. Loupe has no analytics, no telemetry, no crash reporting and no advertising, and it has no servers of its own to send anything to. Your mail goes directly between your phone and your mail provider. See [Privacy and security](/docs/privacy-security/).

### Is my mail stored on Loupe's servers?

No, there are none. Your mail stays on your mail server, and Loupe keeps a copy in an encrypted database on your phone. A few things Loupe needs on every device, such as your Smart Mailboxes, snoozed messages and server rules, are kept on your own mail server.

### Does Loupe work with Gmail?

Yes. Builds of Loupe that are registered with Google offer **Sign in with Google**. In a build without it, you can connect Gmail with an app password, which needs 2-Step Verification on your Google account. See [Accounts](/docs/accounts/#google-and-microsoft-sign-in).

### Does Loupe work with Outlook.com, Hotmail and Microsoft 365?

Yes, over IMAP, in builds of Loupe that offer **Sign in with Microsoft**. Microsoft no longer accepts passwords from mail apps, so in a build without Microsoft sign-in these accounts can't be added.

### Does Loupe support Exchange, ActiveSync or POP3?

No. Loupe uses IMAP and SMTP, or JMAP. It doesn't support Exchange ActiveSync, Exchange Web Services or POP3. Microsoft 365 mailboxes work over IMAP with Microsoft sign-in.

### Can I use Loupe with my own mail server?

Yes. Loupe works with any IMAP and SMTP server and with JMAP servers such as Stalwart, and it can trust a self-signed certificate after showing you its fingerprint. Server rules work with servers that offer Sieve (ManageSieve, or JMAP), such as Dovecot, mailcow and Stalwart.

### Is there an iPhone version?

Not yet. Loupe is built for both Android and iOS, and the iOS version is prepared, but it waits for an Apple Developer account before it can be tested and released. For now, Loupe is Android only.

### Why do I install Loupe from an APK instead of an app store?

Loupe is in early development and isn't in an app store yet. The APK on [loupe.mx/download](https://loupe.mx/download/) is the current Nightly build, made automatically from the latest code. The plan is a public beta on Google Play's testing track and on Apple's TestFlight; there is no date yet. F-Droid isn't part of the current plan.

### How do I update Loupe?

Download the newest APK and install it over the old one. Your accounts, mail and settings stay. Loupe doesn't update itself. See [Getting started](/docs/getting-started/#updating).

### Is Loupe made by Mozilla or the Thunderbird team?

No. Loupe is an independent project and isn't affiliated with or endorsed by Mozilla or Thunderbird. It is designed to work well alongside Thunderbird: it imports accounts from Thunderbird's "Export for Mobile" QR codes, uses the same tags, reads and sends OpenPGP mail that Thunderbird understands, and its search language follows the Thunderbird add-on Expression Search Reloaded.

### Does Loupe support encrypted email?

Yes. Loupe reads and sends OpenPGP mail (compatible with Thunderbird, with Autocrypt) and S/MIME mail (compatible with Outlook and Thunderbird), including certificates installed on your Android phone. See [End-to-end encryption](/docs/encryption/).

### Can I write formatted (HTML) email?

Not yet. Loupe writes plain-text messages. It reads formatted mail, of course, in the Readable or Original view.

### Does Loupe sync my contacts and calendars?

No. Loupe suggests addresses from your mail, and it can add a calendar invitation to your phone's calendar app with **Add to Calendar**, but it doesn't sync contacts or calendars itself.

### Is Loupe available in my language?

Not yet. Loupe is in English only for now.

### Does Loupe work on tablets?

Yes. On a tablet or an unfolded foldable, Loupe shows mailboxes, messages and the conversation side by side, and it supports keyboard shortcuts, a command palette and drag and drop. See [Tablets and keyboards](/docs/tablets-and-keyboards/).
