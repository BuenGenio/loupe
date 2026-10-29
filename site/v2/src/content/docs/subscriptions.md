---
title: "Subscriptions"
description: "See which newsletters you never read, unsubscribe in one tap, block senders, and keep the mailing lists you write to in one place, all on your phone."
section: "Using Loupe"
order: 80
---

Subscriptions gathers your bulk mail in one place. **Newsletters** ranks newsletters and other bulk mail by how much of it you leave unread, so you can unsubscribe from what you never read. **Discussions** lists the mailing lists people write to. Everything is counted on your phone.

Open it from **Subscriptions** on the Mailboxes screen. Its number counts unread mail in your discussion lists. Subscriptions opens on the tab you used last.

## Newsletters

Each newsletter is one row, named after its sender, with how much it sends and how much of it you read, for example "≈ 24 / month · read 3%". The newsletters you leave unread most come first.

- **Never Read**, **Rarely Read** and **All** narrow the list. Rarely Read means you read less than a quarter of it.
- **Filter** finds a newsletter by name.
- Tap a row to see its details and latest messages.

Loupe recognises bulk mail by the headers bulk senders add (a List-Id or List-Unsubscribe header) and by the message IDs of bulk-mail services. A sender that uses a new address for every campaign is still one row. Read rates use the last 90 days.

### Unsubscribe

Tap **Unsubscribe** on a row, or in its details. Loupe uses the best method the sender offers:

| Method | What happens |
|---|---|
| One click | Loupe asks "Unsubscribe from *name*?" and names the website it will contact. It sends only the standard unsubscribe request ("List-Unsubscribe=One-Click"), without cookies or anything else about you, and doesn't open the page. |
| By email | Loupe sends the unsubscribe email the sender asks for, from the address the newsletter came to. It goes through the Outbox like any message. |
| Web page | Loupe shows the website's address first and warns about look-alike letters, then opens the page in its browser. You finish there. |

The row then says "Unsubscribed on *date*". If mail keeps arriving more than a week later, it says **Still sending**, and you can block the sender instead.

If one-click unsubscribing fails, Loupe offers to try again, send an unsubscribe email or open the website, when the sender offers them. If a sender gives no way to unsubscribe, the row offers **Block**.

> **Note:** One-click unsubscribing is the only time Loupe contacts a sender's website, and only when you tap Unsubscribe. The first time, Loupe explains this before it sends anything.

### More actions

Long-press a newsletter:

- **Archive N in Inbox** archives its mail in your Inbox at once, with Undo.
- **Create Rule…** opens a new [rule](/docs/rules/) for its future mail, filled in with the sender and the action "Move to Archive". Change it as you like and save.
- **Block Sender** makes a device rule that moves its new mail to Junk. Loupe then offers to move the mail you already have there too. You can change or delete the rule in Settings › Rules.
- **Treat as Discussion** moves a mailing list to the Discussions tab, if it is one people write to.

## Discussions

Discussions lists the mailing lists that people write to, most recent activity first, with the list's address and its unread count. Loupe treats a list as a discussion when it accepts posts and more than one person has written to it in the past year, or when its messages reply to each other.

Tap a list to read it as forum-style threads. Long-press it for:

- **Pin to Mailboxes**, which adds it to a **Lists** section on the Mailboxes screen;
- **Unsubscribe**;
- **Open as Plain Text (Mono)**, for technical lists with code and patches;
- **Treat as Newsletter**, if Loupe got it wrong.

See [Mailing lists and patches](/docs/mailing-lists/) for reading lists.

## Private by design

Mail services that offer an unsubscribe centre usually read your mail on their servers to build it. Loupe counts on your phone, from the mail it has downloaded, and sends nothing anywhere to work this out. What you unsubscribed from, and which lists you pinned, stay on this phone.
