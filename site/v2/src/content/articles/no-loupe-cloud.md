---
title: "There is no Loupe cloud, and that's the point"
description: "Many mail apps sync your mailbox through their own servers. Loupe doesn't have any. Here's how snooze, Smart Mailboxes and notifications work without them."
date: 2026-10-27T13:00:00Z
tags: [privacy, design]
---

A common way to build a modern mail app is to put a server in the middle. The app's company logs in to your mailbox from its own machines, watches it around the clock, and pushes changes to your phone. It makes some features easy: instant notifications, snooze that works everywhere, a fast first sync.

It also means a company you've never met holds a key to your mailbox, and a copy of what's in it.

Loupe doesn't do that. There is no Loupe server, no Loupe account, and nothing in between your phone and your mail provider. This post explains how the features that usually need a server work without one, and what it costs.

## Snooze without a snooze server

When you snooze a message in Loupe, it moves to a folder called `Snoozed` on your mail server and gets a keyword that encodes when it should come back, in UTC minutes. After each sync, Loupe looks for messages whose time has come and moves them back to the inbox.

Because the state lives on your server, it doesn't depend on Loupe at all. Another device running Loupe will wake the message too, and any other client can follow the same [documented convention](https://github.com/BuenGenio/loupe/blob/main/docs/snooze-convention.md). If a server can't store keywords, Loupe still moves the message and tells you the time is kept on this device only.

## Smart Mailboxes that follow you

A Smart Mailbox is a saved search. Loupe stores the list of them in your own mailbox: as an IMAP METADATA annotation where the server supports it, otherwise as a small message in a `Loupe Settings` folder. Set one up on your phone and it appears on your tablet. The [format is documented](https://github.com/BuenGenio/loupe/blob/main/docs/smart-mailboxes-format.md), too.

## Rules that run while you sleep

Device rules run on the phone when mail arrives. Server rules are compiled to **Sieve**, the standard filtering language most mail servers understand, and uploaded with ManageSieve (or JMAP). They then run on the server, even when your phone is switched off, and keep running if you stop using Loupe.

## Notifications: the honest trade-off

This is where a middleman server genuinely helps, so here is what Loupe does instead:

- By default, Android wakes Loupe about **every 15 minutes** to check for mail. Android decides the exact moment, and it may be later when the phone is idle.
- **Instant Delivery** (experimental) keeps a connection to your inboxes open, so new mail notifies you within seconds. It costs some battery, and Android needs permission to let it run.
- **JMAP accounts** get changes pushed straight from your server.

Notifications can be a little slower than in an app with a server farm behind it. In return, nobody but you and your provider ever touches your mail.

## Nothing to breach, nothing to sell

On the phone, mail and the search index are stored in an encrypted database. Passwords and tokens sit in Android's keystore. Loupe has no analytics or crash reporting, so the only way I learn about a bug is when someone tells me, and I'm fine with that.

The [privacy policy](/privacy/) lists every server Loupe ever contacts. It's short, because there isn't much to list.
