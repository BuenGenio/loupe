# Projects and the Tiles view: plan

Status: agreed 2026-11-21; phases 1–4 built the same day. What differs from the first plan is marked **As built**.

A project groups the conversations about one thing (a mortgage, a client, a house move) across folders and accounts.
The Inbox gets a **Tiles** view: one tile per project, and suggested tiles for topics Loupe notices in the mail.

## Decisions

| Question | Decision |
|---|---|
| Where membership lives | On the mail server, as a keyword on each message, so it syncs and other apps keep it. |
| Finding topics | On the device. An optional AI pass names and merges them, through an OpenAI-compatible server the user chooses (address, key, model). Off by default. |
| What the tiles cover | Projects and suggestions, plus an **Everything Else** tile for the rest. Everything Else can be turned off. |
| Accounts | A project spans every account. Mail from any account, and sent from any identity, can be in it. |

## The model

- **A project** is `{id, name, colour, done, rule?, modifiedAt}`. `rule` is a search in the Loupe search language
  (phase 4). Projects are listed in a server document, `projects`, kept like Smart Mailboxes
  (docs/smart-mailboxes-format.md): IMAP METADATA `/private/vendor/loupe/projects`, else the `Loupe Settings` folder,
  in the home account (the one Settings › Smart Mailboxes › Sync via names). The same per-entry merge applies: the later
  `modifiedAt` wins and deletions leave tombstones for 30 days. With Sync via › Off, or only Gmail accounts, projects
  stay on the device.
- **Membership** is the keyword `$loupe-project-<id>` on each message. It works on IMAP (PERMANENTFLAGS `\*`) and JMAP.
  Thunderbird keeps the keyword. It shows a tag for it once the user defines one with that key. A server that refuses
  keywords (no `\*` in PERMANENTFLAGS; rare) loses membership the way it loses tags. A device-only fallback like
  snooze's can come later if that turns out to matter.
- **Conversations follow:** "Add to Project…" on a conversation tags all of its messages. A message that arrives later
  in a tagged conversation (a reply, or your own message in Sent) gets the same keyword during sync, the way new mail in
  a muted conversation arrives read.
- **Lists:** a project is a mailbox list of its own, `KeywordMailboxRef(keyword)`: the conversations whose messages
  carry the keyword, in every account, apart from Trash and Junk. Threads, quick filters, swipe actions and unread counts
  all work as in any other mailbox.

## Phases

### 1. Projects

- `mail_model`: `Projects` keyword helpers, `KeywordMailboxRef`, `watchKeywordUnread`, document name `projects`.
- `mail_store`: the list and count queries, an index on keywords (schema 9), the query for conversations to follow.
- `mail_sync`: the `projects` document and its sync, project keywords following conversations on arrival.
- App:
  - a Projects section on the Mailboxes screen (unread counts, New Project), and a project's list with an Edit menu
    (name, colour, Done, Delete);
  - "Add to Project…" on a conversation, a message and a selection;
  - project names on tagged rows;
  - the demo.
- Docs: docs/projects-format.md (the document and the keyword, for other apps), ARCHITECTURE.md, README, CHANGELOG,
  device checklist.

### 2. The Tiles view

- A List | Tiles switch on the Inbox and All Inboxes (remembered per device).
- One tile per active project, most recent activity first. A tile shows its name and colour, unread count, the latest
  sender and subject, and when it last moved. Tapping a tile opens the project's list.
- **Everything Else**: the Inbox mail in no project, as a tile of its own (Settings › Projects › Show Everything Else,
  on by default).
- Projects marked Done drop out of the tiles and stay on the Mailboxes screen.
- On wide screens the tiles fill the list pane.
- **As built:** the switch is a button in the title bar of All Inboxes and of each Inbox. Everything Else opens the
  Inbox list without the conversations that are in projects; in the two-pane layout it opens the whole list for now.

### 3. Suggested topics

- **On the device**, after a sync, at most once an hour. Clusters of conversations from the last 90 days that the user
  took part in, from:
  - the sender's organisation (domain minus free-mail providers: gmail.com, outlook.com and the like);
  - recurring correspondents (the same few people across conversations);
  - subject words that recur here but are rare in the rest of the mail (TF-IDF over subjects and previews);
  - mailing-list ids for discussion lists (newsletters stay in Subscriptions).
- A topic needs at least 3 conversations over at least 2 weeks, and none of them in a project yet. It is named after
  the organisation ("Harbourline") or its top word ("Mortgage").
- Suggestions appear as dashed tiles with **Make Project** (creates it and tags its conversations) and **Not a Topic**
  (remembered on the device).
- **Optional AI pass** (Settings › Projects › Suggestions with AI): sends the subjects, senders and dates of the
  candidate conversations, not the bodies, to an OpenAI-compatible `chat/completions` server. The server names topics,
  merges near-duplicates and drops noise. The key lives in secure storage. Loupe talks only to the server the user enters
  (for example a LocalAI on their own network); nothing goes anywhere by default.
- **As built:**
  - Recurring correspondents are not a signal of their own. Instead, mail from machines (`noreply@`, `statements@`,
    `receipts@`…) counts like a newsletter unless the user wrote in the conversation, so bank alerts and receipts
    don't become topics.
  - An organisation is named by a sender's display name when it spells the domain ("Harbor Coffee" for
    harborcoffee.example).
  - The AI pass sends at most the 120 newest open conversations: subject, the other people's names and organisation
    domains, first and last date; no addresses, previews or bodies. It runs at most once an hour (Test Server, or a
    change of server or model, asks again).
  - Make Project on an organisation or word suggestion also makes a rule (`from:<domain>`, `subject:<word>`).

### 4. Rules

- A project's rule (a search, `from:@lender.example or subject:mortgage`) tags matching mail as it arrives, and **Apply
  to Existing Messages** tags what is already there.
- Where the account has ManageSieve, the rule also goes to the server as a Sieve `addflag`, so it applies while Loupe is
  closed (through mail_sieve, like device rules today).
- **As built:** a project's rules are ordinary rules (Settings › Rules) whose action adds the project's keyword, so
  device rules, server rules (Sieve), Check the Condition and Apply to Existing Messages all come from the rule editor.
  The project's editor lists them and has Add Rule…, which opens the rule editor with that action filled in. The rule
  list reads them as "Add to Mortgage". The document's `query` field stays reserved.

## Out of scope for now

- Notes, files or tasks attached to a project.
- Sharing a project with other people.
- Projects for Gmail labels (Gmail keeps the keyword; a label mirror can come later).
