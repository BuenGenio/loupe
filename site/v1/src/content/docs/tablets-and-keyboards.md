---
title: "Tablets and keyboards"
description: "Use Loupe on a tablet or foldable: the three-pane layout, resizable columns, drag and drop to folders, keyboard shortcuts and the command palette."
section: "Using Loupe"
order: 130
---

On a wide screen Loupe shows your mailboxes, the message list and the conversation side by side, much like a desktop mail client. With a hardware keyboard you can do most things without touching the screen.

## The layout changes with the width

Loupe picks its layout from the width of the window, so the same device can change layout when you rotate it, unfold it or resize the app.

| Window width | What you see |
|---|---|
| Less than 840 dp (phones) | Mailboxes, then the list and the conversation as separate pages. |
| 840 to 1100 dp | The list and the conversation side by side. Mailboxes slides in over the list when you tap the sidebar button in the list's title bar. |
| 1100 dp and wider | Mailboxes, the list and the conversation in three columns. The sidebar button hides and shows the Mailboxes column. |

When the layout changes, what you had open stays open. If you were reading a message on a phone-width layout and widen the window, the list and the message move into their panes. If you narrow it again, they become pages again and Back works as it does on a phone.

Settings, Compose, Search and the message source open over the panes, as they do on a phone.

### Resize the columns

- Drag a divider to resize the column next to it. Mailboxes can be 220 to 420 dp wide and the list 300 to 560 dp; the conversation always keeps at least 380 dp.
- Double-tap a divider to return to the default width.

Loupe remembers the widths, and whether you hid the Mailboxes column.

### After Archive or Delete

When you archive or delete the conversation you are reading, the next one in the list opens (or the one before it, at the end of the list), as in Apple Mail and Thunderbird.

## Drag messages to a folder

In the panes, you can move messages by dragging them:

1. Long-press a message in the list until it lifts.
2. Drag it onto a folder in the Mailboxes pane and let go.

The message moves, and you can undo the move. If the Mailboxes column is hidden or closed, it comes out while you drag and goes away again afterwards.

- In Edit mode, dragging one of the selected messages carries the whole selection. The card shows how many messages you are moving.
- If you put the message back where you picked it up, the More sheet opens instead, so a long press still does what it does on a phone.
- You can drop messages only on folders of the same account, and not on the folder they are already in. Moving between accounts isn't supported.

Phones don't have drag and drop: there is nowhere to drop.

## Keyboard shortcuts

Ctrl and ⌘ both work everywhere, so an Apple keyboard on an Android tablet works too. Press **Ctrl/⌘+/** or **?** to see the list in the app.

| Keys | What they do |
|---|---|
| Ctrl/⌘+N | New message |
| Ctrl/⌘+K | Command palette |
| / or Ctrl/⌘+F | Search: the list's search field, else the Mailboxes search field, else the search screen |
| Ctrl/⌘+/ or ? | Show the keyboard shortcuts |
| Esc | Back: leaves search or Edit, closes the sidebar, the conversation (on a wide screen) or the page. In Compose, it asks whether to save or delete the draft. |
| J or ↓ | Next conversation |
| K or ↑ | Previous conversation |
| Enter | Open the highlighted conversation (in a phone-width list) |
| R (or Ctrl/⌘+R) | Reply |
| Shift+R (or Ctrl/⌘+Shift+R) | Reply All |
| F (or Ctrl/⌘+Shift+F, Ctrl/⌘+L) | Forward |
| E | Archive |
| Delete, Backspace (or Ctrl/⌘+Backspace) | Move to Trash |
| Shift+U (or Ctrl/⌘+Shift+U) | Mark as read or unread |
| S (or Ctrl/⌘+Shift+L) | Flag or unflag |
| Ctrl/⌘+Enter (or Ctrl/⌘+Shift+D) | Send (in Compose) |

On a wide screen, J and K open the next or previous conversation in its pane. In a phone-width list they move a highlight, and Enter opens it. In a conversation on a phone-width layout, they go to the neighbouring conversation of the list you came from.

### How shortcuts behave

- **While you type,** plain-letter shortcuts are off. Ctrl/⌘ combinations always work, and so does Esc where it means something (Compose, a search field).
- **Under a dialog or sheet,** nothing fires. Esc closes the dialog or sheet.
- **On a focused button,** Enter and the arrow keys are left to the button, for keyboard navigation.
- **Shortcuts act on the screen on top:** the conversation you are reading first, then the list (in Edit mode, on the selected messages), then Mailboxes.

### If you know Gmail, Thunderbird or Apple Mail

Where these apps disagree, the plain letters follow Gmail, and the Ctrl/⌘ forms add Apple Mail's and Thunderbird's keys where they don't clash.

- **F** forwards, as in Gmail. Thunderbird's F (next message) is J here; Thunderbird's Ctrl+L forward works too.
- **E** archives, as in Gmail. Thunderbird's A isn't used, because it is Reply All in Gmail.
- **Shift+U** toggles read, as in Gmail, and so does Apple Mail's ⇧⌘U. Thunderbird's M isn't used, because it is Mute in Gmail.
- **S** flags, as in Thunderbird and Gmail (star). Apple Mail's ⇧⌘L works too.
- **Ctrl/⌘+K** opens the command palette. / and Ctrl/⌘+F search.
- **Ctrl/⌘+F** searches the list. Loupe can't find text inside a message yet.
- **Ctrl/⌘+Enter** sends, as in Thunderbird. Apple Mail's ⇧⌘D works too.
- **Esc** in Compose asks whether to save or delete the draft. It never throws your text away.

## The command palette

The command palette finds actions, places and settings by typing a few letters.

- **With a keyboard:** press **Ctrl/⌘+K** anywhere.
- **On a phone:** long-press the search field on Mailboxes or in a message list.

It lists:

- actions on what is on screen, such as Reply, Archive, Snooze…, Move to Mailbox…, Mark All as Read and Get New Mail (only those the current screen can do), plus New Message and Keyboard Shortcuts;
- every mailbox (nested folders show where they are, for example "Work › Projects"), the unified mailboxes, Snoozed, Outbox, Subscriptions and its Discussions tab, your Smart Mailboxes, discussion lists and tags;
- the settings pages, and each account's settings and folders;
- your recent searches;
- Search mail for “…”, with what you typed.

Matching is forgiving: type the letters in order, and case, accents and spaces don't matter. The starts of words count most, so initials work: "mar" finds Mark All as Read. Entries you used recently come first.

Use ↑ and ↓ to choose, Enter to run and Esc to close. Shortcuts are shown next to the actions that have one.
