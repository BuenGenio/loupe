---
title: "Smart Mailboxes"
description: "Save any search as a Smart Mailbox in Loupe. It is stored on your own mail server, so it appears on your other devices with no account or cloud service."
section: "Using Loupe"
order: 50
---

A Smart Mailbox is a saved search that looks and works like a mailbox: Unread from your team, invoices with attachments, anything from this year's conference. Loupe keeps Smart Mailboxes on your own mail server, so they follow you to your other devices without any account or service of Loupe's.

## Create a Smart Mailbox

1. [Search](/docs/search/) for what you want, for example `s:invoice has:attachment`.
2. Above the results, tap **Save as Smart Mailbox**.
3. Give it a name and tap **Save**.

The Smart Mailbox appears in the **Smart Mailboxes** section of the Mailboxes screen.

A Smart Mailbox keeps the scope of the search it came from. If you searched one mailbox (for example your Work Inbox), it shows matches from that mailbox only; if you searched **All Mailboxes**, it searches everything.

Because a Smart Mailbox is a search, it always shows what matches now: new mail appears in it, and mail that no longer matches (because you read it, for instance) leaves it. Pull down to refresh it.

## Rename, change or delete

Open the Smart Mailbox and tap the **⋯** button:

- **Rename** gives it a new name.
- **Edit Search** opens the search with its query, so you can change it. Save the changed search as a new Smart Mailbox, then delete the old one.
- **Delete Smart Mailbox** removes it at once, without asking.

You can also delete Smart Mailboxes, or hide them, from the Mailboxes screen: tap **Edit**, then the red button next to one to delete it, or the row itself to hide it.

## Sync to your other devices

Loupe stores Smart Mailboxes in your own mailbox on your mail server. Another phone or tablet with Loupe and the same account picks them up at its next check for mail, including names you change and Smart Mailboxes you delete.

The line under a Smart Mailbox's title says where it is kept:

| Line | Meaning |
|---|---|
| Synced to *account* | It is stored on that account's server. |
| Waiting to sync to *account* | It will be stored at the next sync. |
| On this device only | Syncing is off, or there is no account to keep it. |
| On this device only: *account* can't keep it | The server can't store it (Gmail can't, for example). |
| Not synced: *account* has a newer format | A newer version of Loupe wrote the server's copy. Update Loupe. |

### Choose where they are kept

Go to Settings › **Smart Mailboxes**.

- **Sync via** chooses the account that keeps Smart Mailboxes that search every account. It starts on your first account that isn't Gmail. **Choose the same account on every device.**
- A Smart Mailbox that searches a single folder is always kept on that folder's account, since folder names only mean something on their own server.
- **Off** keeps all Smart Mailboxes on this device only.

The **On the Server** section shows, for each account, how the server keeps them, and **Sync Now** syncs at once.

| Status | Meaning |
|---|---|
| Server metadata | Stored as server metadata (IMAP METADATA), which no mail app shows. |
| Loupe Settings folder | The server has no metadata support, so Loupe keeps one message in a folder named "Loupe Settings". Loupe hides that folder on the Mailboxes screen. |
| Nothing stored | Nothing has been saved to this account yet. |
| Waiting, Syncing… | A sync is due or under way. |
| Couldn't sync | The last attempt failed. Try **Sync Now**. |
| Not supported | This account can't keep Smart Mailboxes. |
| Newer format | A newer version of Loupe wrote the server's copy. |

> **Note:** Gmail accounts can't keep Smart Mailboxes, because Gmail has no metadata support and every message in a folder would also pile up in All Mail. If Gmail is your only account, your Smart Mailboxes stay on the device.

> **Tip:** The "Loupe Settings" folder is listed in Settings › *account* › Manage Folders with an explanation. Other mail apps may show it. Leave it and its message in place: they hold your synced Smart Mailboxes.

If two devices change Smart Mailboxes at the same time, Loupe merges the changes: edits to different Smart Mailboxes both survive, and for the same one the later change wins.

## For other apps

The way Loupe stores Smart Mailboxes is open and documented, so other apps can read and write them too. The search text uses the same language as the Thunderbird add-on Expression Search Reloaded. If you write software, see the [Smart Mailboxes format](https://github.com/BuenGenio/loupe/blob/main/docs/smart-mailboxes-format.md).
