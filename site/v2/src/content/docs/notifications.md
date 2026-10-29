---
title: "Notifications"
description: "How Loupe checks for new mail in the background on Android, what notifications show, their actions, the app icon badge, and experimental Instant Delivery."
section: "Using Loupe"
order: 100
---

Loupe tells you about new mail with notifications, also while the app is closed. By default it checks for mail in the background about every 15 minutes. If you want mail within seconds, there is an experimental Instant Delivery option.

## Background sync

When Loupe isn't open, Android wakes it about every 15 minutes to check for mail, as long as the phone has a network connection. Android decides the exact moment: when the phone is idle (Doze), checks can come later.

The same background work also sends [scheduled messages](/docs/writing/#send-later), brings back [snoozed messages](/docs/organising/#snooze) and runs [device rules](/docs/rules/).

There is no setting for the interval. While Loupe is open, it keeps the Inbox up to date by itself.

> **Note:** Don't use **Force stop** on Loupe in Android's app settings. It cancels Loupe's background work until you open the app again. Swiping Loupe away from the recent apps is fine.

## What you are told about

Loupe notifies you of new messages in your inboxes, and of messages from your [VIPs](/docs/organising/#vips) in any folder. It doesn't notify you of:

- mail that is already read (for example by a rule, or because you read it on another device);
- drafts, junk, and mail from your own addresses;
- the mail that is already there when you add an account.

A notification shows the sender, the subject and the start of the message. Encrypted mail says "Encrypted message", unless its subject was already decrypted on your phone (see [End-to-end encryption](/docs/encryption/)).

### Notification actions

Each notification has three buttons:

- **Archive** archives the message (when the account has an Archive folder);
- **Mark as Read** marks it read;
- **Reply** opens Loupe to reply.

Archive and Mark as Read work without opening Loupe. Tapping the notification itself opens the message.

## Notification settings

Go to Settings › **Notifications**.

| Setting | What it does |
|---|---|
| **New Mail** | One switch per account. All accounts notify by default. |
| **VIP Only** | Only messages from your VIPs notify. Off by default. |
| **Hide Content** | Notifications only say "New message from" and the account, not who wrote or what about. Off by default. |
| **Instant Delivery** | Experimental. See below. Off by default. |
| **Push** | Lets new mail wake Loupe at once, where your mail service supports it. See below. On by default. |
| **Send Test Notification** | Shows a notification for the newest message in your inboxes, so you can see how they look. |
| **App Icon Badge** | The number on Loupe's icon: **Off**, **Unread in Inboxes** (the default) or **Unread in VIP** |

Loupe also creates a notification channel in Android for each account and one for VIPs. You can set their sound and importance in Android's settings for Loupe.

The badge updates whenever Loupe checks for mail, also in the background. Some home screens don't show numbers on app icons; Loupe tells you when yours doesn't.

## Instant Delivery

> **Experimental:** Instant Delivery is new and may not work on every phone. It uses more battery than the 15-minute schedule.

Instant Delivery keeps a connection to your inboxes open, so new mail notifies you within seconds. While it is on, a quiet notification says "Watching for new mail". It starts again by itself after the phone restarts.

1. Go to Settings › **Notifications**.
2. Turn on **Instant Delivery**.
3. If Loupe shows **Allow Unrestricted Battery Use**, tap it and allow it. Otherwise Android may stop Instant Delivery to save battery.

Instant Delivery watches the inboxes of the accounts whose **New Mail** switch is on. Other folders, such as VIP mail elsewhere, still follow the 15-minute schedule.

## Push

Push lets new mail wake Loupe the moment it arrives, without keeping a connection open. It goes through Google's push service (Firebase Cloud Messaging). A push carries no mail, only "check now": Loupe then fetches your new mail directly from your mail server.

- Push is on by default once you add an account. Turn it off in Settings › **Notifications** › **Push**; that deletes this phone's push address at Google.
- Push needs Google Play services. On phones without them, Loupe says so and checks every 15 minutes as usual.
- Pushes only come where something sends them for your mail service. Until then, Push changes nothing, and the 15-minute schedule and Instant Delivery work as before.

## If notifications don't arrive

1. Tap **Send Test Notification**. If nothing appears, notifications are off for Loupe: Loupe shows **Open Android Settings** to turn them on.
2. Check that the account's switch under **New Mail** is on, and that **VIP Only** is off.
3. In Android's settings, open Apps › Loupe › Battery and choose **Unrestricted**. Some phones stop background work of apps that are "optimised" or "restricted".
4. Remember the schedule: without Instant Delivery, new mail can take 15 minutes or more to notify.

More help is in [Troubleshooting](/docs/troubleshooting/#notifications-dont-arrive).

## On iOS

Loupe for iOS isn't released yet. On iOS, apps can't keep a connection open in the background, so there will be no Instant Delivery there: new mail arrives when iOS lets Loupe check, which can be hours apart.
