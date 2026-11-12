---
title: "Rules"
description: "Sort new mail automatically in Loupe with rules that run on your phone or on your mail server as Sieve, written as searches, with a live preview."
section: "Using Loupe"
order: 90
---

Rules file, tag and flag new mail for you. A rule's condition is a search, written in the same language as the search field, so anything you can find you can also sort. A rule runs either on your phone or on your mail server.

## Device rules and server rules

| | This Device | Server |
|---|---|---|
| Runs | On new Inbox mail, each time Loupe checks for mail | On the mail server, as mail arrives |
| While your phone is off | No; it catches up at the next check | Yes |
| Needs | Nothing | A server with Sieve, over ManageSieve (Dovecot, mailcow) or JMAP (Stalwart) |
| Forwarding | No | Yes |

Gmail and Microsoft accounts don't offer server rules; rules for them run on the device.

## Create a rule

1. Open Settings › **Rules** and tap the compose button (**New Rule**).
2. Under **When a New Message Matches**, write the condition as you would search, for example `from:@shop.example.com` or `s:invoice has:attachment`. Leave it empty to match every message.
3. Under **Accounts**, choose which accounts' mail the rule handles. **All Accounts** also covers accounts you add later.
4. Under **Then**, tap **Add Action** and choose what to do (see below). A rule can have several actions.
5. Under **Run On**, choose **This Device** or **Server**.
6. Give it a **Name** if you like (Loupe suggests one from the condition), and tap **Save**.

While you write the condition, Loupe shows the messages from the last 30 days that it would match, so you can check it before saving. If the condition has a mistake, Loupe explains it under the field.

### Actions

| Action | What it does |
|---|---|
| **Move to Folder…** | Moves the message to a folder. In a rule for several accounts, mail of the other accounts goes to the folder with the same name there. |
| **Add Tag…**, **Remove Tag…** | Adds or removes Important, Work, Personal, To Do or Later |
| **Flag** | Flags the message |
| **Mark as Read** | Marks it read |
| **Move to Junk** | Marks it as junk and moves it to Junk |
| **Keep in Inbox** | Leaves it in the Inbox and stops: later rules don't touch it. Put such a rule first for exceptions, such as "my manager always stays in the Inbox". |
| **Forward To…** | Server rules only. Sends every matching message on to another address, keeping a copy or not. |

**Stop Processing More Rules** keeps later rules from acting on a message this rule matched.

### Make a rule from a search or a sender

- **From a search:** search for what you want, tap the **⋯** button above the results, and choose **Make This a Rule**. The rule editor opens with your search as the condition.
- **From a newsletter:** in [Subscriptions](/docs/subscriptions/), long-press it and choose **Create Rule…**, or **Block Sender**.

## Your rules list

- Rules run **from top to bottom**. Touch and hold a rule to move it.
- Each rule shows **Device** or **Server**, its condition and its actions, and a switch to turn it off without deleting it.
- Tap a rule to edit it, or to delete it with **Delete Rule**.

### Apply a rule to mail you already have

Rules only act on new mail. To run one on existing messages, open it and tap **Apply to Existing Messages…**, choose **Inboxes** or **All Mailboxes**, and confirm. Forwarding is left out when applying to existing mail.

## Server rules

Server rules keep working when your phone is off or out of battery. Loupe writes them into a Sieve script named "loupe" on your server.

The **Server Rules** section of the rules list shows each account's state:

| State | Meaning |
|---|---|
| On | The server runs Loupe's rules. |
| Off | Another script is active on the server (see below), or none is. Saving a server rule turns Loupe's on when no other script is active. |
| Not Available | The server offers no Sieve, over ManageSieve or JMAP. |
| Unknown | Loupe couldn't ask the server. |

### If you already have a Sieve script

Many servers' webmail (SOGo on mailcow, for example) keeps its filters in a Sieve script of its own. Loupe never replaces it. Instead, the **Turn On Server Rules** sheet shows the line it would add to your script so that the server runs Loupe's rules after your own: tap **Add to "*script*"**. Nothing else in your script changes.

If the webmail later rewrites its script without that line, the Server Rules section shows Loupe's rules as off again. Tap the account to add the line back.

### What can't run on the server

A server rule is fixed when you save it, and a server sees mail as it arrives. So some conditions can't run there. Loupe tells you which and why, and offers **Run on This Device Instead**:

- read, replied, forwarded, draft or junk state (new mail has none yet);
- dates relative to today, such as `newer_than:7d` or `after:yesterday` (fixed dates like `after:2026-03-01` work);
- `account:` (choose the rule's accounts instead);
- patterns that use features the server's regular expressions don't have, such as `\d`;
- anything that needs a Sieve extension your server lacks, such as searching the message text.

You can see the exact script with **Show Script** in the editor.
