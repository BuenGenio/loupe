# Snooze over plain IMAP

Version 1. Loupe implements it; any IMAP client can. There is no vendor cloud and no server extension: the
state lives in the mailbox, so a message snoozed on one device comes back on whichever device syncs first
after its time (Loupe on a phone, Thunderbird with an add-on on a desktop).

The key words MUST, SHOULD and MAY are used as in RFC 2119.

## In short

| What | How |
|---|---|
| Where a snoozed message waits | A mailbox named `Snoozed` at the top level |
| When it wakes | A keyword `$snoozed-<minutes>`: the wake time in whole minutes since 1970-01-01 00:00 UTC |
| Where it goes back to | The account's `INBOX` |
| How it comes back | Unread, with the RFC 9979 keyword `$new`, snooze keywords removed |

Example: a message to wake on 23 May 2025 at 18:00 UTC carries `$snoozed-29133720` and sits in `Snoozed`.

## The Snoozed mailbox

- The mailbox is named `Snoozed` and lives at the top level of the personal namespace.
- Clients find it by name, ignoring case. On servers whose personal namespace is `INBOX.` or `INBOX/`, the
  mailbox `INBOX.Snoozed` (or `INBOX/Snoozed`) counts too.
- A client that snoozes a message and finds no such mailbox creates it with `CREATE Snoozed` and then
  `SUBSCRIBE`s to it (where every folder lives under the Inbox, it creates `INBOX.Snoozed` or `INBOX/Snoozed`
  instead). A `NO [ALREADYEXISTS]` reply means another client was faster; that is success.
- No special-use attribute is required. RFC 9979 registers `\Snoozed` for a mailbox like this one; a client MAY
  set it (`CREATE Snoozed (USE (\Snoozed))` where CREATE-SPECIAL-USE is offered) but MUST NOT depend on it.
  Loupe creates the mailbox without it.
- Clients SHOULD hide the mailbox from ordinary folder lists and show a "Snoozed" view instead (soonest wake
  time first), and SHOULD keep its messages out of unified views such as Unread, Flagged and VIP. Loupe does
  both; its Snoozed mailbox spans all accounts.

### Over JMAP

The convention carries over to JMAP (RFC 8621) unchanged: `Snoozed` is a top-level mailbox of that name (created
with `Mailbox/set`; `alreadyExists` means another client was faster), the wake time is the same keyword in the
email's `keywords`, and moving is a `mailboxIds` patch (`mailboxIds/<Snoozed id>: true`, `mailboxIds/<source>: null`).
An email that is in other mailboxes too keeps those. Loupe does it this way for JMAP accounts.

## The wake-time keyword

```
snooze-keyword = "$snoozed-" 1*10DIGIT   ; whole minutes since 1970-01-01T00:00:00Z
```

- The number is decimal, without sign, fraction or leading `+`, and SHOULD have no leading zeros. Writers round
  the wake time **up** to the next whole minute so a message never wakes early.
- Keywords are case-insensitive (RFC 9051 and JMAP lower-case them); writers use lower case.
- The keyword is a valid IMAP `flag-keyword` (an atom: no spaces, parentheses, braces, `%`, `*`, quotes,
  backslashes or `]`) and a valid JMAP keyword, and is far below Dovecot's 50-character limit.
- Anything else starting with `$snoozed-` is not a valid snooze keyword. Clients ignore it for waking, leave
  it alone, and don't show it as a tag.
- Only messages in `Snoozed` are snoozed. A snooze keyword on a message elsewhere (moved out by hand) means
  nothing; clients ignore it and MAY remove it.
- If a message carries more than one valid snooze keyword (two clients changed the time at the same moment),
  the **earliest** wins. Whoever changes the time removes all of them before adding the new one.

### Servers that can't store keywords

A client checks the `PERMANENTFLAGS` response code when it selects the Inbox or the Snoozed mailbox. Without
`\*` in it, new keywords are not stored permanently (Outlook.com and Exchange behave like this). Such an
account can't hold snooze times on the server. Loupe then still moves the message to `Snoozed`, keeps the
wake time on the device only (in its offline queue), and tells the user that the snooze works on that device
alone. Other clients see
a message in `Snoozed` without a time and leave it there (they MAY offer to wake it).

When `PERMANENTFLAGS` isn't sent at all, RFC 9051 says all flags can be changed permanently; clients assume
keywords work.

## Snoozing

To snooze a message until time *T*:

1. Remove every snooze keyword it has and add `$snoozed-T` (`UID STORE … +FLAGS ($snoozed-T)`).
2. Move it to `Snoozed` (`UID MOVE`, or `UID COPY` + `\Deleted` + `UID EXPUNGE`).

Setting the keyword first means the message never sits in `Snoozed` without a time, even if the client is
interrupted between the two commands. A message already in `Snoozed` only gets step 1 ("change time").

Loupe runs both steps through its offline queue: the message leaves the Inbox at once on the device and the
server catches up when it can.

## Waking

At or after *T*, the first client that sees the message does this:

1. Remove every snooze keyword, remove `\Seen`, and add `$new`.
2. Move the message back to `INBOX`.

The order again keeps a message from reaching the Inbox with a stale time on it. The message keeps its date
(INTERNALDATE), so it returns to its place in a date-sorted list; `$new` and the unread state make it stand out
(RFC 9979: `$new` asks clients to show a message as new "due to a recent system action"). Loupe shows a small
"Snoozed" marker on unread messages with `$new` and removes `$new` when the message is read.

"Wake now" is the same thing done before *T*.

Clients check for due messages whenever they sync the `Snoozed` mailbox (Loupe: every sync, a timer for the
next due message while running, and background wake-ups on Android). Before waking, a client SHOULD bring its
view of `Snoozed` up to date, so a time another device just changed is respected.

### The original mailbox

Version 1 always wakes messages into `INBOX`. Snoozing from another folder is possible, but the message comes
back to the Inbox. (A later version may add a keyword naming the original mailbox; clients MUST ignore
keywords they don't know.)

## Two clients at once

Waking is safe to race. If two clients wake the same message at the same moment:

- Setting and removing the same flags twice is idempotent.
- The second `UID MOVE` (or `UID STORE`) names a UID that is no longer in `Snoozed`; servers answer `OK` and
  do nothing, or `NO`. Either way the client drops the operation and re-syncs both mailboxes.
- The message ends up in `INBOX` exactly once, unread, with `$new` and no snooze keyword.

A client that changes the time while another wakes the message may leave it either woken or re-snoozed,
depending on which command the server sees first; nothing is lost.

## Send Later

Not part of version 1: Loupe keeps scheduled messages in its own outbox on the device. RFC 9979's `\Scheduled`
mailbox attribute is the obvious place for a cross-client form later.

## Notes for servers

- **Dovecot with Maildir** (mailcow's default) stores at most 26 keywords per mailbox in file names. Further
  keywords still work but live only in Dovecot's index files, which survive normal use; they are lost only if
  the indexes are deleted and rebuilt. Snooze keywords collect in `Snoozed` over time (one per distinct wake
  time). mdbox, sdbox and Cyrus have no such limit.
- **Gmail** stores keywords; `Snoozed` becomes a label, and waking removes it and adds the Inbox label back.
  Gmail's own snooze is separate and not visible over IMAP.
- **Fastmail** has its own server-side snooze. Messages snoozed by this convention wake through the clients,
  not through Fastmail; how Fastmail's own snooze treats a message moved into its Snoozed mailbox over IMAP
  hasn't been tested.

## IMAP example

Snooze UID 4321 in the Inbox until 2026-10-05 08:00 UTC (minute 29853120):

```
C: a1 SELECT INBOX
S: * OK [PERMANENTFLAGS (\Answered \Flagged \Deleted \Seen \Draft $Forwarded \*)] Flags permitted.
C: a2 UID STORE 4321 +FLAGS.SILENT ($snoozed-29853120)
C: a3 UID MOVE 4321 Snoozed
S: * OK [COPYUID 1700000000 4321 17] Moved
```

Wake it (another device, after 08:00 UTC):

```
C: b1 SELECT Snoozed
C: b2 UID STORE 17 +FLAGS.SILENT ($new)
C: b3 UID STORE 17 -FLAGS.SILENT (\Seen $snoozed-29853120)
C: b4 UID MOVE 17 INBOX
```
