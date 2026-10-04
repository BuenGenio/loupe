# Tablets, foldables and keyboards

## Layout

`MailHome` (the `/` route, `app/lib/features/panes/`) picks the layout from the width:

| Width | Layout |
|---|---|
| < 840 dp | Phone: Mailboxes, then the list and the conversation as pages. Unchanged. |
| 840–1100 dp | List \| conversation. Mailboxes slides in over the list from the sidebar button in the list's title bar. |
| ≥ 1100 dp | Mailboxes \| list \| conversation. The sidebar button hides and shows Mailboxes. |

- **Dividers:** drag to resize (Mailboxes 220–420 dp, list 300–560 dp, the conversation keeps at least 380 dp);
  double-tap for the default width. The widths and the hidden Mailboxes column are kept in the preferences
  (`layout.*`).
- **Selection:** in the panes, `mailSelectionProvider` says which list and conversation are shown; on a phone the
  route stack does. It lives above the widgets, so rotating and resizing keep it.
- **Crossing the breakpoint** converts one into the other:
  - Widening (unfolding, rotating a tablet) takes the list and conversation pages above `/` into the panes and pops
    them.
  - Narrowing pushes them again (`/list/…`, All Inboxes if no list was picked, then `/message/…`), so Back works as
    on a phone. If another page is on top (Settings, Compose), that waits until it closes.
- **Pushes over the panes:** while wide, a list or conversation route pushed right above `/` opens in its pane. The
  push and the pop happen before the next frame, so the page never shows. This covers a mailbox tapped in the
  Mailboxes pane, search results, the Snoozed and mailing-list screens in the list pane, and notification taps.
  Other routes (Settings, Compose, Search, Source) cover the panes as on a phone. Deep links (`Routes.message`) work
  everywhere.
- **Snack bars** show once, across the width: the panes sit in one outer Scaffold.
- **After Archive or Delete** the next conversation of the list opens (the one before at the end), as in Apple Mail
  and Thunderbird.
- **Mailboxes pane** highlights the list shown beside it.

## Drag and drop

In the panes, a long press on a row lifts it; drop it on a folder in the Mailboxes pane to move it there
(`MailActions.move`, with Undo). In Edit mode a selected row carries the whole selection, and the card shows the
count. A row put back where it was lifted opens the More sheet, so the long press still does what it does on a
phone. While dragging, a closed sidebar (840–1100 dp) or a hidden Mailboxes column comes out and goes away after the
drop. Folders take messages of their own account only (moves between accounts aren't supported), and not the
folder they are in. Phones are unchanged: there is nowhere to drop.

## Keyboard shortcuts

`app/lib/features/keyboard/`. Ctrl and ⌘ both work everywhere (an Apple keyboard on an Android tablet); the
cheat sheet shows ⌘ on Apple platforms and Ctrl elsewhere.

| Keys | Does |
|---|---|
| Ctrl/⌘+N | New message |
| Ctrl/⌘+K | Command palette |
| / or Ctrl/⌘+F | Search: the list's field, else the Mailboxes field, else the search screen |
| Ctrl/⌘+/ or ? | This list |
| Esc | Back: leaves search or Edit, closes the sidebar, the conversation (wide) or the page; in Compose, Cancel |
| J or ↓, K or ↑ | Next and previous conversation (opens it in the panes; moves a highlight in a phone's list; in a phone's conversation, the neighbour in the list it came from) |
| Enter | Open the highlighted conversation (phone list) |
| R, Shift+R, F | Reply, Reply All, Forward (also Ctrl/⌘+R, Ctrl/⌘+Shift+R, Ctrl/⌘+Shift+F, Ctrl+L) |
| E | Archive |
| Delete, Backspace | Move to Trash (also Ctrl/⌘+Backspace) |
| Shift+U | Mark as read or unread (also Ctrl/⌘+Shift+U) |
| S | Flag or unflag (also Ctrl/⌘+Shift+L) |
| Ctrl/⌘+Enter | Send (also Ctrl/⌘+Shift+D) |

Rules:

- **Typing:** plain keys never fire while a text field has the focus. Ctrl/⌘ combinations always do, and so does
  Esc where something takes it (Compose, a search field).
- **Focus:** Enter and the arrows leave a focused button alone, for keyboard navigation.
- **Sheets:** nothing fires under a dialog or sheet; Esc closes it.
- **Who acts:** the screen on top, through `MailCommands`. The conversation shown comes first, then the list (in Edit
  mode, row actions apply to the selection), then Mailboxes; `AppShortcuts` handles the rest.

Where Gmail, Thunderbird and Apple Mail disagree, the plain letters follow Gmail (as the issue asked), and the
modified forms add Apple Mail's and Thunderbird's where they don't clash:

- **F** forwards, as in Gmail. Thunderbird's F (next message) is J here; its Ctrl+L forward works.
- **E** archives, as in Gmail. Thunderbird's A isn't mapped: it is Reply All in Gmail.
- **Shift+U** toggles read, as in Gmail, and so does Apple Mail's ⇧⌘U. Thunderbird's M isn't mapped: it is Mute in
  Gmail.
- **S** flags, as in Thunderbird and Gmail (star). Apple Mail's ⇧⌘L works too.
- **Ctrl/⌘+K** opens the command palette. Thunderbird uses it for its search field; / and Ctrl/⌘+F search here.
- **Ctrl/⌘+F** searches the list. In Thunderbird and Apple Mail it finds text in the message; Loupe has no
  find-in-message yet.
- **Ctrl/⌘+Enter** sends, as in Thunderbird; Apple Mail's ⇧⌘D works too.
- **Esc** in Compose asks Save or Delete Draft, like Cancel, rather than discarding anything.

## Command palette

`app/lib/features/palette/`. Ctrl/⌘+K anywhere; on a phone, a long press on the search field of Mailboxes or a list.

- **Entries:** actions on what is on screen (Reply, Archive, Snooze…, Move to Mailbox…, Mark All as Read, Get New
  Mail; only those the screen can do), New Message and Keyboard Shortcuts; every mailbox (nested folders say where
  they are: Work › Projects), the unified mailboxes, Snoozed, Outbox, Smart Mailboxes, mailing lists and tags; the
  settings pages and each account's; recent searches; and "Search mail for '…'" for what was typed.
- **Matching** (`fuzzyScore`): the typed letters in order, ignoring case, accents and spaces. Word starts and runs of
  letters score more, so initials work ("mar" finds Mark All as Read); a prefix beats a word inside, which beats
  scattered letters. Keywords ("compose") and the subtitle ("work inbox") count a little less.
- **Recently used** entries (`palette.recent`, the last 12) come first without a query and get a boost with one.
- **Keys:** ↑ and ↓ choose, Enter runs, Esc closes. Shortcuts are shown beside the actions.
