---
title: "Search"
description: "Find mail in Loupe: pull down to search, use suggestions and chips, get instant results from your phone and more from the server, and save searches."
section: "Using Loupe"
order: 40
---

Loupe searches the mail on your phone as you type, and then asks your mail servers for anything older. You can search with a few words, tap suggestions, or type precise searches such as `f:alice and (s:invoice or b:"PO 123")`.

## Start a search

- **In a message list:** pull the list down. The search field appears above the first message.
- **On Mailboxes:** tap the search field at the top. This searches every mailbox.
- **With a keyboard:** press **/** or **Ctrl/⌘+F**.

Tap **Cancel**, or press **Esc**, to leave the search.

### All Mailboxes or this one

When you search from inside a mailbox, a switch at the top chooses where to look: **All Mailboxes**, or the mailbox you came from (shown by its name). It starts on the mailbox you came from.

## Before you type: suggestions

With an empty search field, Loupe offers:

- **Recent Searches**, your last searches. **Clear** forgets them.
- **Suggestions:** Unread Messages, Flagged Messages, Messages with Attachments and Unreplied Messages.
- **Tags:** Important, Work, Personal, To Do and Later.
- **People** you write with.
- **Smart Mailboxes** you saved.

Tap one to add it to the search. You can combine several: tap **Unread Messages**, then a person, to find their unread mail.

## As you type

- **Completions** appear for the word you are typing. Type `fr` and Loupe offers `from:`; type `is:` and it offers `unread`, `flagged` and the other states; type `after:` and it offers ranges such as "the last 7 days".
- **People** matching what you typed appear as "From: name". Tap one to search for their mail.
- **Colours** show how Loupe reads your search: operators, quoted text and `and`, `or` and `not` are coloured. A part it can't understand, such as an unclosed parenthesis, gets a wavy underline, and the rest of the search still runs.

### Chips

When your search has more than one part, or uses an operator, each part shows as a chip above the results, in plain words: "From: alice", "Unread", "Before 1 Mar 2026".

Tap a chip to change it:

- **Negate** turns it into its opposite, such as "Not tagged Work". **Don't Negate** turns it back.
- **Remove** takes it out of the search.

Chips are combined with *and*. To combine terms with *or*, type it: see [Combining terms](/docs/search-language/#combining-terms).

## Results: phone first, then the server

1. **Results from your phone** appear almost at once while you type. They come from the mail Loupe has already downloaded, including the text of messages you opened.
2. **Results from your mail servers** follow a moment later. A line such as "Searching Work on the server…" shows each account that is still working. Messages that only the server found are marked with a small server icon.

If a server can't be reached, Loupe says "Couldn't search *account* on the server" and keeps the results it has.

You can swipe results and long-press them, as in any message list.

> **Note:** Encrypted messages are found by their sender, recipients and subject. To find them by their text too, see [Search inside encrypted mail](/docs/encryption/#search-inside-encrypted-mail).

## Search from a message

In a conversation, you can search for mail related to a message:

- **Tap a sender's or recipient's name**, then **Search Messages from** *name*.
- **Use Search from This Message** in the message's menu to search by its sender, its recipients or its subject.

## Do more with a search

Above the results:

- **Save as Smart Mailbox** keeps the search as a mailbox on the Mailboxes screen. See [Smart Mailboxes](/docs/smart-mailboxes/).
- **The ⋯ button** (Search Menu) offers **Make This a Rule**, which opens a new [rule](/docs/rules/) with your search as its condition, and Save as Smart Mailbox.

## Search tips

| To find | Type |
|---|---|
| A phrase anywhere | `weekend plans` |
| Two words anywhere, not next to each other | `weekend and plans` |
| Mail from someone | `from:alice` or `f:alice` |
| Mail from a whole domain | `from:@example.com` |
| A subject | `s:invoice` |
| Text in the message | `b:"tracking number"` |
| Unread mail with attachments | `is:unread has:attachment` |
| Mail from the last week | `newer_than:7d` |
| Mail from March 2026 | `date:2026-03` |
| Big messages | `larger:5M` |
| Tagged Work, not yet read | `tag:work is:unread` |
| Either of two senders | `f:(amazon or ebay)` |
| Everything except one sender | `-f:newsletter` |

Several words in a row are searched as one phrase. The [search language reference](/docs/search-language/) lists every operator, with dates, sizes, tags, patterns and grouping.
