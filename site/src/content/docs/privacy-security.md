---
title: "Privacy and security"
description: "What Loupe stores and who it talks to: an encrypted database, optional App Lock, no telemetry or servers of its own, blocked trackers and an explainable phishing check."
section: "Accounts & security"
order: 150
---

Loupe has no servers of its own and collects nothing about you. Your mail goes directly between your phone and your mail provider. On the phone, Loupe protects your mail with encryption (and, if you like, your fingerprint or screen lock), checks every message for trackers and phishing, and explains what it found.

## No telemetry, no servers

- Loupe has no analytics, no tracking, no advertising and no crash reporting.
- Loupe has no servers, so there is nowhere your mail, contacts or settings could be sent to. Your settings stay on the phone, except Smart Mailboxes, which you can [keep in your own mailbox](/docs/smart-mailboxes/) on your mail server.
- Loupe is open source (MPL-2.0), so anyone can check what it does: [github.com/BuenGenio/loupe](https://github.com/BuenGenio/loupe).

### Who Loupe connects to

| Connection | When |
|---|---|
| Your mail servers (IMAP and SMTP, JMAP, and ManageSieve for server rules) | To sync, send and search your mail |
| Thunderbird's settings database (autoconfig.thunderbird.net), and your mail domain's own configuration address | When you add an account. The database learns your mail domain; your domain's own server learns your address. |
| Google or Microsoft | When you sign in with them, and to renew that sign-in |
| A newsletter's unsubscribe address | Only when you tap Unsubscribe and the newsletter offers one-click unsubscribing |
| The authority that issued an S/MIME certificate | Only if you turn on [revocation checking](/docs/encryption/#revocation-checking) |
| Websites and maps | Only links, meeting links and map buttons you tap |
| Senders' image servers | Only when you load remote images |

## Your mail on the phone

- **An encrypted database.** Your messages, folders and the address book Loupe builds from your mail (for address suggestions) are kept in an encrypted database in Loupe's private storage. Its key is kept in Android's Keystore. Attachments you open are kept in Loupe's private cache until the next time you start the app.
- **Passwords and sign-in tokens** are kept in the Android Keystore too. They only ever go to your own mail provider (or to Google or Microsoft, to renew a sign-in).
- **No backups to the cloud.** Loupe is excluded from Android's backups and device-to-device transfers. On a new phone, add your accounts again: your mail is on your server.
- **Removing an account** deletes its mail, settings and sign-in from the phone. Uninstalling Loupe deletes everything it stored.

> **Note:** If the Keystore can't give back the database key (this can happen after restoring a phone from a backup), Loupe shows "Your accounts couldn't be opened". Tap **Try Again** first, and restart the phone if needed. Loupe never replaces the key by itself. Only if the key is gone for good, **Reset Mail on This Phone…** deletes the local copy so you can add your accounts again. Mail on your servers isn't affected, but messages still waiting in the Outbox are lost.

## App Lock

App Lock keeps your mail from anyone else who picks up your phone while it's unlocked. It's off by default: turn it on in Settings › Security › **App Lock**.

- **Your phone's own lock.** Loupe asks with Android's own prompt: your fingerprint or face, or your screen lock's PIN, pattern or password. Loupe never sees them.
- **Turning it on** asks once, so you know it works before it locks anything. If the phone has no screen lock, Loupe explains that App Lock needs one and stays off: **Open Settings** takes you to Android's screen lock settings.
- **When it asks.** When Loupe starts, and when you come back after it has been in the background for the **Lock After** time: Immediately (the default), 1 Minute, 5 Minutes, 15 Minutes or 1 Hour. Pulling down the notification shade doesn't count as leaving.
- **The lock screen** shows Loupe's icon and name and **Unlock**. The prompt opens by itself when the lock screen appears; if you close it, tap **Unlock**. Back leaves Loupe. Nothing of your mail shows before the lock does, and what you had open is still there when you unlock.
- **Recent Apps** shows a blank card for Loupe instead of your mail while App Lock is on (Android 13 and later; earlier versions still show a screenshot). Taking screenshots inside Loupe keeps working.
- **In the background** nothing changes while Loupe is locked: it checks for new mail, notifications arrive, and their **Archive** and **Mark as Read** buttons work. **Reply** and tapping a notification open the lock screen first. To keep senders and subjects out of notifications too, turn on **Hide Content** in Settings › Notifications.
- **If you remove the phone's screen lock** later, App Lock turns itself off the next time you open Loupe, and tells you.

## Remote images and tracking pixels

Many senders put invisible images (tracking pixels) and remote pictures in their mail to learn when, where and on which device you read it.

- **Remote images are blocked by default.** Load them per message, always for one sender, or for everyone in Settings › Reading › **Load Remote Images**. See [Remote images](/docs/reading/#remote-images).
- **Tracking pixels are removed**, even when you load images.
- **Readable mode runs nothing.** It rebuilds the message from plain building blocks: no scripts, no web view. The Original view shows the sender's design with scripts off and nothing loading from the internet until you allow images.

## Click trackers

Links in newsletters often lead through a tracking service that records your click before sending you on. Loupe recognises the common ones (Mailchimp, SendGrid, HubSpot, Amazon SES and others), and the redirects of big platforms.

- **Open Links Directly** (Settings › Reading, on by default) opens the real destination when it is written in the tracker's link, and removes tracking parameters such as `utm_source` and `fbclid`.
- **Long-press any link** to see where it really goes, which trackers it passes through, and to choose **Open directly** or **Open original**.
- Loupe leaves link protection that your company or provider added alone (such as Microsoft Safe Links, Proofpoint or Mimecast), since it is there to protect you.

Loupe works this out from the link itself. It never contacts a tracker to find out where a link goes.

## The phishing check

Loupe checks every message on your phone for signs of phishing and tells you what it found and why. Nothing is sent anywhere to do this.

### The badge

Next to the sender's name:

| Badge | Meaning |
|---|---|
| **Possible phishing** (red) | Several signs, or one strong sign, say the message isn't what it claims to be. |
| **Be careful** (amber) | Something deserves a second look. |
| **Verified** (green) | Your mail server confirmed the sender, and nothing looks suspicious. |
| A shield with a number | How many trackers Loupe found (tracking pixels and tracked links). |

Tap the badge to see the explanation.

### Likely phishing

When a message looks like phishing, Loupe turns off its links and images and shows a red banner: "This message looks like phishing", with the main reason. **Why?** explains; **Show Anyway** shows the message normally. Until then, tapping a link shows where it goes but doesn't open it.

### What Loupe looks for

The explanation sheet lists its findings, worst first, each with advice. Among them:

- **The sender isn't verified:** your mail server couldn't confirm the message comes from the domain it claims.
- **Look-alike addresses:** a sender's or a link's address uses letters from another alphabet that look like Latin ones, or a domain that imitates a well-known brand, a bank, or your own organisation.
- **A name that shows a different address,** or replies that would go to another address than the sender's.
- **Someone using your name, or a VIP's name,** from a new address.
- **Links that hide where they go:** link text showing one website while the link opens another, links to bare IP addresses, disguised links, and shortened links.
- **A password field** in the message (Loupe removes it), and links that would run code (Loupe disables them).
- **Lots of hidden text,** a trick to fool spam filters.
- **A first message** from a sender you have never had mail from.

The sheet also has a **Privacy** section (tracking pixels removed, remote images, tracked links) and **Technical Details** with the raw evidence, such as the server's authentication results and where the links lead.

The check uses your mail server's sender verification, your history with the sender, your VIPs and the message itself. It is a guide, not a guarantee: when in doubt, contact the sender another way.

## Encryption

Loupe reads and sends OpenPGP and S/MIME encrypted and signed mail. See [End-to-end encryption](/docs/encryption/).
