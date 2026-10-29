---
title: "Troubleshooting"
description: "Fix common Loupe problems: accounts that won't connect, app passwords, certificate errors, late notifications, unsent mail, and how to report a bug."
section: "Reference"
order: 200
---

Most problems show up in one of two places: the line at the bottom of Mailboxes and every message list, which says when Loupe last checked for mail or what went wrong, and the **Outbox**, which shows messages that couldn't be sent. Start there.

## Adding an account fails

### "Password rejected"

- **"Password rejected. Use an app password, not your account password."** Gmail (without Google sign-in), iCloud, Yahoo, AOL and Fastmail don't accept your normal password from mail apps. Create an app password in your account's security settings (the sign-in screen links to instructions) and paste it.
- **"API token rejected."** Fastmail over JMAP needs an API token for JMAP with access to email. See [JMAP accounts](/docs/accounts/#jmap-accounts).
- **"Password rejected. Check it and try again."** Check the password, and the **Username** under Server Settings › Edit Settings. Some servers want the full address, others only the part before the @.

### "Can't reach server"

Loupe couldn't connect. Check your internet connection, then the server name, port and security under **Server Settings** › **Edit Settings**. Your provider's help pages list the right values. Common ports are 993 for IMAP and 465 or 587 for SMTP.

### "Couldn't find settings"

Loupe found no settings for your domain. Enter them by hand: see [Enter settings by hand](/docs/accounts/#enter-settings-by-hand). This is common for custom domains hosted by Google or Microsoft, because Loupe doesn't look up your domain's mail servers in DNS, for privacy.

### "The server's certificate isn't trusted"

The server uses a certificate your phone doesn't trust, often a self-signed one on a home server. Compare the SHA-256 fingerprint Loupe shows with your server's, then tap **Trust This Certificate**. If you don't run the server, don't trust it: ask your provider.

### Gmail or Outlook can't be added

- If there is no **Sign in with Google** button, your build of Loupe doesn't have Google sign-in. Use **Use an App Password** instead.
- If Loupe says Microsoft sign-in "arrives in a later build", your build doesn't have it, and Outlook, Hotmail and Microsoft 365 accounts can't be added with it.
- **"Your organisation must approve Loupe"**: your work or school account needs an administrator to allow Loupe.
- **"…signed you in, but the mail server refused access"**: choose the same account when signing in. Some work and school accounts have IMAP turned off by their administrator.

## An account stops syncing

- **A banner says Google or Microsoft no longer accepts Loupe's sign-in.** Tap **Sign In Again**.
- **The bottom line shows "*account*: *error*".** The text is the server's answer. If your password changed, remove the account and add it again (passwords can't be changed in Loupe yet).
- **It says "Offline".** Loupe has no connection. It catches up by itself once you are back online.

Pull down on Mailboxes or a list to check for mail at once.

## Notifications don't arrive

1. In Settings › **Notifications**, tap **Send Test Notification**. If nothing appears, Android blocks Loupe's notifications: tap **Open Android Settings** and allow them.
2. Check that the account's switch under **New Mail** is on, and **VIP Only** is off.
3. In Android's settings, open Apps › Loupe › Battery and choose **Unrestricted**. Many phones stop the background work of "optimised" apps.
4. Don't use **Force stop** on Loupe; it cancels background checks until you open the app again.
5. Give it time: without [Instant Delivery](/docs/notifications/#instant-delivery), Loupe checks about every 15 minutes, and Android can delay that when the phone is idle.

Also remember that Loupe doesn't notify you of mail that is already read (by a rule, or on another device), or of mail outside your inboxes unless it is from a VIP.

## Scheduled mail or snoozed messages are late

They depend on the same background work as notifications, so the steps above apply. With Loupe closed, expect up to about 15 minutes' delay. The phone must be on and online at that time.

If snoozing says "on this device only", your server (for example Outlook.com) can't store the wake-up time, so only this phone can wake the message.

## A message wasn't sent

Open **Outbox** on Mailboxes. Under **Not Sent**, each message shows the server's reason.

- **A temporary problem** (no connection) is retried by itself.
- **A refusal** (an unknown address, a message too large, a sender address the server doesn't allow) waits for you. Tap the message to fix it, then send it again, or tap **Retry**.

See [When sending fails](/docs/writing/#when-sending-fails).

## Server rules aren't available

- Gmail and Microsoft accounts don't offer server rules. Use device rules.
- Other servers need Sieve over ManageSieve (port 4190) or JMAP. If the Server Rules section says "Not Available", your server doesn't offer it; ask your provider, or run the rule on this device.
- If your server already has an active Sieve script (for example your webmail's filters), Loupe's rules stay off until you let Loupe add a line to that script. See [If you already have a Sieve script](/docs/rules/#if-you-already-have-a-sieve-script).

## Smart Mailboxes don't appear on my other device

- Set Settings › Smart Mailboxes › **Sync via** to the same account on both devices.
- Gmail can't keep Smart Mailboxes; choose another account.
- If **On the Server** says "Couldn't sync", tap **Sync Now**.

## A message looks wrong

Tap **Aa** and try **Original**, or **Plain**. If a message looks wrong in Readable view, please [report it](#report-a-bug): describe what you see, or share the message's source if it contains nothing private.

## An encrypted message can't be read

- **"Encrypted · no key"**: the message wasn't encrypted to a key or certificate on this phone. Import the key you use elsewhere, for example your [Thunderbird key](/docs/encryption/#add-your-key).
- **"Encrypted · locked"**: your key has a passphrase. Tap **Unlock**, or open the message again.

## "Your accounts couldn't be opened"

Loupe couldn't read the key that protects its database, usually for a moment after a system update.

1. Tap **Try Again**.
2. If that doesn't help, restart the phone and open Loupe again.
3. Only if Loupe says the key is gone (for example after restoring the phone from a backup), use **Reset Mail on This Phone…**. It deletes your accounts and the mail stored on the phone, including messages waiting in the Outbox. Mail on your servers isn't affected; add your accounts again afterwards.

Please [report](#report-a-bug) this screen if you see it.

## Report a bug

Report problems and ideas on GitHub: [github.com/BuenGenio/loupe/issues](https://github.com/BuenGenio/loupe/issues). Search the existing issues first; someone may have reported it already.

A good report includes:

- **Loupe's version**, from Settings › Advanced › About › **Version**;
- **your phone** and its Android version;
- **the kind of account**: Gmail, Outlook, iCloud, Fastmail, a self-hosted Dovecot or Stalwart server, and IMAP or JMAP;
- **what you did, what you expected, and what happened instead**, step by step;
- **the exact error text**, from the bottom line, the Outbox or the sign-in screen, or a screenshot.

> **Note:** Issues on GitHub are public. Never include passwords, app passwords or tokens, and remove addresses and message content you don't want to share. Only attach a message's source (View Source › Share) if it contains nothing private.

If you are comfortable with Android's developer tools, a log helps with crashes and background problems: `adb logcat -v time | grep -iE 'flutter|loupe'`.
