---
title: "Mailing lists and patches"
description: "Read mailing lists as forum-style threads in Loupe, mute threads, reply to the list, use plain text for technical lists, and read patches as diffs."
section: "Using Loupe"
order: 120
---

Loupe has features for people who live on mailing lists, such as open-source developers: lists shown as forum-style threads, muting, replies to the list, and patches drawn as coloured diffs. They are always available; there is no special mode to turn on.

## Lists as forum threads

Discussion lists (the lists people write to, rather than newsletters) are gathered in Subscriptions › **Discussions**. See [Subscriptions](/docs/subscriptions/) for how Loupe tells them apart.

Tap a list to open it as threads, newest activity first. Each row shows:

- the thread's title, without "Re:", the list's `[tag]` and `[PATCH …]` prefixes;
- a badge such as "PATCH v2 3/3" for patch series;
- up to three participants, the number of replies and the last activity;
- an unread dot.

Tap a thread to read it as a conversation.

### Pin a list to Mailboxes

Long-press the list in Discussions (or use **List Options** at the bottom left of the list) and choose **Pin to Mailboxes**. Pinned lists appear in a **Lists** section on the Mailboxes screen, with their unread counts.

### Write to the list

- **New Message to List** (bottom right in the list) starts a message to the list's posting address.
- **Reply to List** replies to the list rather than to the sender. Long-press Reply in a conversation, or use **Reply List** in a message's ⋯ menu. It appears on mail from lists that accept posts.

## Mute a thread

Long-press a thread in the list and choose **Mute Thread** (or use **Mute Thread** in a message's ⋯ menu). Loupe marks it read, and new messages in it arrive already read, so they don't notify you or show as unread. This works like Thunderbird's "Ignore Thread".

- Muted threads are hidden from the list. **List Options** › **Show Muted Threads** shows them again.
- **Unmute Thread** brings a thread back.

Muting is kept on this phone only: other devices and mail apps don't know about it.

## Technical lists: plain text in Mono

Lists about code read best as plain text in a monospaced font, so that code, tables drawn with characters and patches stay aligned.

- **For one list:** long-press it in Discussions, or open **List Options**, and choose **Open as Plain Text (Mono)**. **Open in Default View** undoes it.
- **In Settings:** Settings › Reading › **Technical Lists** lists your discussion lists, with a switch for each.

Messages from these lists then open in Plain view with the Mono font. The **Aa** button still switches any message, and a view you saved with "Remember for this sender" takes precedence.

## Patches as diffs

When a message contains a patch, as made by `git format-patch` or pasted into a reply, Loupe draws it as a coloured diff, in Readable and Plain view:

- each file has a header with its path, how many lines were added and removed, and whether it is new, deleted, renamed or binary;
- added and removed lines are coloured;
- a diffstat ("3 files changed") is folded into one line; tap it to see every file;
- a very long change shows its first 400 lines and a **Show all … lines** button.

Patches quoted in replies are drawn as diffs too, so you can follow a review.
