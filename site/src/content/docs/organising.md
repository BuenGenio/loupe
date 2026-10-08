---
title: "Organising mail"
description: "Swipes and Undo, the Filter button, flags, VIPs, Thunderbird-compatible tags, folders, archiving, junk, and snooze that works across mail apps."
section: "Using Loupe"
order: 60
---

Loupe keeps everyday actions one swipe away and puts the rest in a long-press menu. Almost everything you do can be undone, and whatever you change is changed on your mail server, so your other mail apps see it too.

## The Mailboxes screen

Mailboxes is the first screen. From top to bottom:

- **Unified mailboxes** that gather mail from all your accounts: **All Inboxes**, **VIP**, **Flagged**, **Unread**, **All Drafts** and **All Sent**. **Snoozed** appears while something is snoozed, and **Outbox** while something waits to be sent. **Subscriptions** leads to your newsletters and discussion lists.
- **Each account** with its folders. Tap an account's name to collapse or expand it. Folders with subfolders have an arrow.
- **Lists:** discussion lists you pinned (see [Subscriptions](/docs/subscriptions/)).
- **Smart Mailboxes:** your [saved searches](/docs/smart-mailboxes/).
- **Tags:** tap a tag to see the messages that have it.

### Show and hide mailboxes

Tap **Edit**, then tap rows to show or hide them, and tap **Done**. All Drafts and All Sent are hidden until you show them. The Outbox can't be hidden: it only appears when something needs your attention or is about to go out.

You can't reorder mailboxes.

## Conversations

Settings › **Organize by Conversation** (on by default) groups a message and its replies into one row. A number on the row shows how many messages it holds. Turn it off to list every message on its own.

## Swipes

| Swipe a message | Default |
|---|---|
| To the right | Mark as read or unread |
| To the left | Archive |

- **A short swipe** reveals buttons and leaves them open. Swiping left shows your chosen action, then **Flag** and **More**.
- **A full swipe**, past about half the row, runs the first action at once. You feel a tick when it is ready.

To change them, go to Settings › **Swipe Actions** and choose an action for **Swipe Left** and **Swipe Right**: None, Mark as Read / Unread, Flag, Archive, Trash, Move Message, Snooze or More. Flag and More always stay one short swipe away on the left.

In the Archive (or Gmail's All Mail), the Archive button becomes **Inbox** and moves mail back. In the Trash, Trash becomes **Delete**.

## Undo

After you archive, delete, move, snooze or mark junk, a bar at the bottom says what happened, such as "Archived 1 message", with an **Undo** button. It stays for a few seconds.

Deleting from the Trash is permanent. Loupe asks first, and it can't be undone.

## The More menu

Long-press a message (or swipe left and tap **More**) for:

- Reply, Reply All and Forward;
- Flag or Unflag, Mark as Read or Mark as Unread;
- Snooze… (or Wake Now and Change Snooze Time… for a snoozed message);
- Tag…;
- Move Message…;
- Move to Junk (or Not Junk, in the Junk folder);
- Archive;
- Trash (or Delete Permanently, in the Trash).

In a conversation, the **⋯** button on each message has the same actions and a few more: Mute Thread, Show All Headers, View Source and Search from This Message…. See [Reading mail](/docs/reading/).

## Select several messages

1. In a message list, tap **Edit**.
2. Tap the messages you want, or **Select All**.
3. Use the buttons at the bottom:
   - **Mark**: Mark as Read or Unread, Flag or Unflag, Snooze…, Move to Junk;
   - **Move**;
   - **Archive** (or Trash, or Delete, depending on your swipe setting and the folder).
4. Tap **Done**.

To mark a whole list as read, open the [command palette](/docs/tablets-and-keyboards/#the-command-palette) (long-press the search field, or Ctrl/⌘+K) and choose **Mark All as Read**.

## The Filter button

The Filter button at the bottom left of a message list shows only the messages that match what you choose. It works like Thunderbird's quick filter.

- **Tap it** to turn the filter on or off. The bar then says "Filtered by:" and what you chose.
- **Tap "Filtered by:"** to change what it filters by: **Unread**, **Flagged**, **To: Me**, **CC: Me**, **With Attachments**, **Unreplied** and **From VIPs**.

With several choices, a message must match all of them. Loupe remembers your choice; the first time, it filters by Unread.

## Flags

Flag a message to mark it for later. Swipe left and tap **Flag**, use the More menu, tap the flag button in a conversation, or press **S**. Flagged mail from every account is in the **Flagged** mailbox.

In a conversation of several messages, the flag goes on the newest one.

## VIPs

Mail from a VIP gets a star instead of the unread dot and appears in the **VIP** mailbox.

- **Make someone a VIP:** in a message, tap their name and turn on **VIP**.
- **Manage the list:** tap the ⓘ button on the VIP row of Mailboxes. **Add VIP…** adds an address by hand, and the remove buttons take people off.

Notifications can be limited to VIPs: see [Notifications](/docs/notifications/).

## Tags

Loupe uses Thunderbird's five standard tags, stored on the server as the same keywords, so tags you set in Thunderbird show in Loupe and the other way round.

| Tag | Colour |
|---|---|
| Important | Red |
| Work | Orange |
| Personal | Green |
| To Do | Blue |
| Later | Purple |

- **Tag a message:** long-press it, choose **Tag…**, and tick the tags. In a conversation, use **Tags…** in a message's ⋯ menu.
- **See tagged mail:** tap a tag in the Tags section of Mailboxes, or search with `tag:work`.

Tags show as coloured dots in the list and as chips in the message. Other keywords on a message, set by other apps, show in grey.

You can't create, rename or recolour tags in Loupe yet.

## Move, archive and delete

- **Move:** choose Move Message… (or the Move button), then a folder of the same account. Messages can't be moved between accounts.
- **Archive** moves mail to the account's Archive folder. On Gmail it removes the Inbox label, so the mail stays in All Mail. If an account has no Archive folder, Loupe says so and leaves the message where it is.
- **Trash** moves mail to the Trash folder. In the Trash, **Delete Permanently** removes it for good.
- **Move to Junk** marks the message as junk and moves it to the Junk folder. **Not Junk** marks it as not junk and moves it back to the Inbox.

## Folders

Loupe shows and syncs the folders you subscribe to, as Thunderbird does. Inbox, Drafts, Sent, Junk, Trash and Archive always show.

- **Choose folders:** Settings › *account* › **Manage Folders**, then turn folders on or off. Other mail apps on the same account usually follow these subscriptions too.
- **Show everything:** Settings › *account* › **Show All Folders** shows every folder, subscribed or not.

You can't create, rename or delete folders in Loupe yet. Use your provider's webmail or a desktop client for that.

## Snooze

Snooze hides a message until a time you choose. Then it comes back to the Inbox, unread, so you see it again.

1. Long-press the message (or use the ⋯ menu in a conversation) and choose **Snooze…**.
2. Pick a time:

| Choice | When |
|---|---|
| Later Today | In about three hours, rounded up to the half hour (only while it is still today) |
| This Evening | 18:00 (offered before 17:00) |
| Tomorrow | 08:00 tomorrow |
| This Weekend | Saturday at 09:00 (offered Monday to Friday) |
| Next Week | Monday at 08:00 (not offered on Sundays) |
| Pick Date & Time… | Any time up to a year ahead, in 5-minute steps |

Loupe says "Snoozed 1 message until …", with Undo.

### The Snoozed mailbox

**Snoozed** on Mailboxes lists everything that is snoozed, soonest first, across all accounts.

- Swipe right for **Wake Now**, which brings the message back at once.
- Swipe left for **Change Time**.

A message that comes back keeps its original date, so it returns to its place in the list rather than the top. It shows a small **Snoozed** label until you read it.

### Snooze that works across apps and devices

Snoozing doesn't depend on Loupe or on a cloud service. Loupe moves the message to a folder named **Snoozed** on your server and writes the wake-up time onto the message. Whichever device checks mail first after that time brings it back: Loupe on your phone, Loupe on a tablet, or any other app that follows the same [open convention](https://github.com/BuenGenio/loupe/blob/main/docs/snooze-convention.md).

Loupe creates the Snoozed folder the first time you snooze, and hides it from the folder list in favour of the Snoozed mailbox. Snoozed messages come back to the Inbox, also when you snoozed them from another folder.

> **Note:** Some servers, such as Outlook.com and Exchange, can't store the wake-up time. Loupe then still moves the message to Snoozed, keeps the time on this device only, and tells you: "Snoozed until … on this device only: the server can't store snooze times."

> **Tip:** With Loupe closed, Android runs the check about every 15 minutes, so a snoozed message can come back a few minutes late. See [Notifications](/docs/notifications/#background-sync).
