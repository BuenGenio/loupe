---
title: "Introducing Loupe: a calm mail app with serious tools underneath"
description: "Loupe is a free, open-source mail app for Android: simple enough for every day, powerful enough for people who live in their inbox, and private by design."
date: 2026-10-20T13:00:00Z
tags: [announcement]
---

Phone mail apps tend to make you choose. The simple ones are lovely until you need to find a message from two years ago or handle a mailing list. The powerful ones bury the inbox under toolbars and settings. And a surprising number of popular apps route your mailbox through their own servers to make features like snooze and push work.

Loupe is my attempt at not choosing. It's a mail app for Android that stays quiet for everyday reading and replying, keeps desktop-class tools within reach, and talks to your mail server and nobody else.

## Calm on the surface

Open Loupe and you get a clean message list, gestures you already know, and messages that are pleasant to read.

That last part takes more work than it sounds. Most HTML mail is designed for a wide desktop window, so on a phone you pinch and scroll sideways. Loupe's **Readable mode** rebuilds each message for the screen in your hand: text at a size you can read, footers shrunk to fine print, photo grids turned into a swipeable carousel, and colours fixed so dark mode doesn't swallow dark text. The sender's original design and a plain-text view are one tap away, and Loupe can remember your choice per sender.

## Serious underneath

When you need more, it's there:

- **Search with a real language.** Pull down and type `from:alice and (subject:invoice or body:"PO 123")`, or just a few words. Results from the phone appear at once; your server's results stream in after.
- **Smart Mailboxes** save a search, and are stored on your own mail server, so they appear on your other devices.
- **Rules** on the phone, or as Sieve scripts on your server, so they run even when your phone is off. Any search can become a rule.
- **Subscriptions** groups newsletters by sender, shows how many you actually read, and unsubscribes in one tap.
- **Snooze, undo send, scheduled send**, tags that match Thunderbird's, and keyboard shortcuts with a three-pane layout on tablets.
- **OpenPGP and S/MIME**, with Autocrypt for painless OpenPGP and support for certificates installed on the device.
- **IMAP and JMAP**: any standard provider, plus native JMAP for Fastmail and Stalwart.

## Your server is the source of truth

Here is the idea I care about most. Loupe has no servers, so everything that needs to outlive your phone lives on your mail server, in the open:

- Snoozed mail goes to a `Snoozed` folder with a keyword that says when it wakes up. Any client that follows the convention can wake it.
- Smart Mailboxes are stored in your own mailbox.
- Server rules are standard Sieve.

Switch phones, use another client on your laptop, or stop using Loupe: nothing is trapped.

## Private by design

Loupe collects nothing. There's no account to create, no analytics, no crash reporter and no ads. Your mail is kept in an encrypted database on the phone, remote images are blocked until you allow them, tracking redirects are unwrapped so you see where a link really goes, and a phishing check explains, in plain words, why a message looks suspicious. [More on that in the privacy guide](/docs/privacy-security/).

## What it isn't (yet)

Being honest about the edges:

- Loupe is **Android only** for now. The iOS version is prepared and waits for an Apple Developer account.
- It speaks **open standards** (IMAP, SMTP, JMAP, Sieve), not Exchange ActiveSync or POP3.
- **Sign in with Google and Microsoft** works, but Google is still reviewing Loupe's access to Gmail, so for now Google may show an "unverified app" warning (an app password works too).
- Builds are **nightly**: every change becomes a new version. They're used every day, but expect rough edges and tell me about them.

## Try it

[Download Loupe](/download/) and choose **Try with demo mail** to look around without adding an account. When you're ready, add your own; the [getting started guide](/docs/getting-started/) walks you through it.

Loupe is free and open source under the MPL-2.0. If it earns a place on your phone, you can pay what you want when you download. It funds the work and keeps Loupe independent.

Bugs, ideas and questions are all welcome: [open an issue](https://github.com/BuenGenio/loupe/issues), start a [discussion](https://github.com/BuenGenio/loupe/discussions), or simply [write to me](/contact/). It's a mail app, after all.
