---
title: "Reading mail"
description: "Read any message comfortably in Loupe: Readable, Original and Plain views, text size, dark mode colours, images, links, attachments and message details."
section: "Using Loupe"
order: 30
---

Loupe's Readable view rebuilds every message to fit your screen: no zooming, no sideways scrolling, and colours that work in dark mode. When you want the message exactly as the sender designed it, or just its text, the **Aa** button switches views.

## Conversations

Tapping a row opens its conversation: the messages stacked from oldest to newest. The one you opened, newer ones and unread ones are open; older ones are folded to a line with the sender, date and a preview. Tap a folded message to open it, and tap the sender's picture of an open message to fold it again.

As you scroll, the top bar turns to frosted glass and shows the sender and subject. Tap it to go back to the top.

### The toolbar

| Button | What it does |
|---|---|
| **Aa** | Reading options: view, text size and colours (see below) |
| Flag | Flags or unflags the conversation |
| Move | Moves it to another folder |
| Archive | Archives it (or moves it to the Trash, when the account has no Archive folder) |
| Reply | Replies. Long-press for Reply All, Reply to List and Forward. |
| Compose | Writes a new message |

After Archive, Move or Delete, the conversation closes and a bar offers **Undo**.

### The message header

- **Tap the line under the sender** ("to …") to see all addresses (From, To, Cc, Bcc, Reply-To), the date, and the **Security** line: whether your mail server verified the sender (**Verified sender** or **Unverified sender**) with the results of its checks, such as "DKIM pass · SPF pass · DMARC pass". It appears when your server records these checks.
- **Tap a name** for **VIP**, **New Message**, **Copy Address** and **Search Messages from** that person.
- **The ⋯ button** of each message has: Reply, Reply All, Reply List and Forward; Mark as Read or Unread, Flag, Tags…, Mute Thread; Snooze…, Move…, Archive, Move to Trash, Move to Junk; and **Show All Headers**, **View Source**, **Save as File…**, **Share as File…** and **Search from This Message…**.

Tags show as coloured chips under the header. A badge next to the sender shows the result of the [phishing check](/docs/privacy-security/#the-phishing-check).

## Three ways to view a message

Tap **Aa** in the toolbar to choose:

| View | What you get |
|---|---|
| **Readable** | The message rebuilt to fit the screen, with the sender's emphasis, colours and images. Nothing in the message runs. |
| **Original** | The sender's own design, in a locked-down view: no scripts, and nothing loads from the internet unless you allow images. |
| **Plain** | Just the text, in **Sans** or **Mono**. Mono keeps tables and code drawn with characters aligned. |

The **Aa** sheet also has:

- **A text size slider**, from 80% to 160%, in all three views.
- **Keep original colours**, in Readable: turns off Loupe's colour adjustments (below).
- **Remember for this sender**: uses these choices for every message from this sender from now on. A newsletter can always open as plain text, for example.

Without "Remember", your choice applies while the conversation is open.

To change the view every message starts in, go to Settings › Reading › **Default View** (Readable, Original or Plain Text) and **Plain Text Font** (Sans Serif or Monospaced).

### What Readable does

- **Fits the screen.** Newsletters built from layout tables become a single column. Real tables of data stay tables and scroll sideways on their own when they are wide.
- **Footers become fine print.** Legal notices, unsubscribe lines and other small print at the end of a message show smaller and lighter, so the content stands out. A paragraph with a real call to action keeps its size.
- **Images fit the width.** Two or more images in a row become a swipeable strip. Tap any image to open a full-screen gallery of all the message's images and image attachments, where you can swipe between them and pinch to zoom.
- **Buttons stay buttons.** Links styled as buttons become tappable buttons.
- **Colours stay readable.** Loupe keeps the sender's colours unless text would be hard to read against its background. Then it changes only the colour's lightness, so a red stays red. In dark mode, dark text turns light and bright highlights are toned down.
- **Hidden text is removed**: preview text, spam padding and anything else meant to be invisible, as well as tracking pixels.

If a message doesn't come out well, Loupe says **Looks better in Original view** above it, with a **Show Original** button. It never switches by itself.

### Plain text

Plain shows the text part the sender included, or text Loupe makes from the design. Links become numbered notes at the end, and quoted replies keep their coloured bars. With **Mono**, patches and code stay aligned; see [Mailing lists and patches](/docs/mailing-lists/).

### Quotes and signatures

Quoted text shows with a coloured bar for each level of quoting. Signatures are shown dimmed. Loupe doesn't fold quoted text away.

## Remote images

Images that load from the internet are blocked until you allow them, because loading them tells the sender when and where you opened the message. A banner above the message says "Images from *domain* are blocked to protect your privacy" and offers:

- **Load images**, for this message only;
- **Always for this sender**, for every message from this sender.

Images inside the message itself always show.

To load remote images for every sender, turn on Settings › Reading › **Load Remote Images**. Tracking pixels are removed either way.

> **Note:** Loupe doesn't have a list of the senders you allowed yet, so "Always for this sender" can't be undone in the app.

## Links

Tap a link to open it in Loupe's browser. `mailto:` links open a new message.

- **Long-press a link** to see where it really goes before you open it. When the link goes through a click tracker, Loupe shows the destination ("Opens: …"), the trackers it passes through, and buttons to **Open directly** or **Open original**, and to **Copy** the clean address.
- **If the text of a link names one website but the link goes to another,** Loupe asks first: "Check this link", with the real address and **Open anyway**.
- **Open Links Directly** (Settings › Reading, on by default) skips known click trackers when the destination is in the link, and removes tracking parameters such as `utm_source`. It leaves your company's own link protection (such as Outlook Safe Links) alone.

See [Privacy and security](/docs/privacy-security/) for how this works.

## Attachments

Attachments are listed under the message, with their size.

- **Tap** an attachment to open it in Loupe: images open in the gallery; PDFs, text and code files, CSV tables, calendar files and attached messages open in a viewer.
- **Long-press**, or tap its ⋯ button, for **Open in…** (another app), **Save to Files** and **Share…**. The viewer has the same buttons at the top: Share, Open in… and Save.

| File | The viewer shows |
|---|---|
| Images | Zoomable, in the gallery |
| PDF | Pages to scroll and zoom; password-protected PDFs can't be shown |
| Text, code, logs, JSON | The text in a monospaced font, with line wrapping and Copy All |
| CSV and TSV | A table, or the text |
| Calendar files (.ics) | A summary of the event |
| Attached messages (.eml) | The message, or its source |
| Anything else | Its name, type and size, with Open in… and Share |

On mobile data, Loupe asks before downloading an attachment of 25 MB or more. Pictures that are part of the message's design show in place and aren't listed as attachments.

[Calendar invitations](/docs/calendar-invitations/) show as a card above the message instead of an attachment.

## Message source and headers

In a message's ⋯ menu:

- **Show All Headers** lists every header line, with Copy All.
- **View Source** shows the raw message. **Share** there saves or sends it as a `message.eml` file, which other mail apps can open.

## Saving a message as a file

In a message's ⋯ menu:

- **Save as File…** saves the message as an `.eml` file named after its subject, such as `Quarterly report.eml`. Android asks where to put it. Other mail apps, Thunderbird among them, open the file.
- **Share as File…** sends the same file to another app, such as Drive or a chat.

The file is the whole message as your server keeps it, with its attachments. An encrypted message stays encrypted in the file, so only you can read it.

To save a whole folder, see [Export a folder](/docs/organising/#export-a-folder).

## Reading offline

Messages you opened before stay readable without a connection. A message Loupe hasn't downloaded yet says so and loads when you are back online.
