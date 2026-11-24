# Projects on the mail server

A project groups the conversations about one thing, such as a house move or a client, across folders and accounts.
Loupe keeps projects on the user's own mail server, so they follow the user to every device with no server of ours.
This page is the contract for any app that reads or writes them.

There are two parts:

- **Which messages are in a project:** a keyword on each message.
- **The projects themselves** (name, colour, done): one JSON document in the home account.

## Membership: the keyword

A message is in project `<id>` when it has the keyword `$loupe-project-<id>`, for example `$loupe-project-lq3k2x1a9b`.

- `<id>` is 1 to 64 characters from `a`–`z`, `0`–`9`, `_` and `-`. That makes the keyword a valid IMAP atom and a
  valid JMAP keyword. Compare keywords without regard to case. JMAP lowercases them, and Loupe writes lowercase.
- A message can be in several projects.
- The keyword is ordinary IMAP flag or JMAP keyword state, so any client can set or clear it. Thunderbird keeps it.
  Thunderbird shows it as a tag once the user defines a tag with that key (`$loupe-project-lq3k2x1a9b`).
- Copies of a conversation's messages in different accounts are tagged on their own.
- Loupe adds the keyword to every message of the conversation when the user chooses **Add to Project…**, and removes
  it from all of them when they take the conversation out.
- **Conversations follow:** when a new message arrives (a reply, or the user's own message in Sent) and another
  message of its conversation has a project keyword, Loupe adds that keyword to the new message too. Other apps should
  do the same. Otherwise a reply they file lands outside the project until a Loupe device syncs it.
- A project's list shows the messages with its keyword from every mailbox of every account, apart from Trash and Junk.
- A keyword whose project isn't in the document (deleted, or written by another app) is ignored. Deleting a project
  removes the keyword from the messages the deleting device has. Copies elsewhere may keep it, unused.

Servers that don't store custom keywords (no `\*` in PERMANENTFLAGS) can't keep membership, any more than they can
keep tags.

## The document

The document is named `projects`. It is stored like the Smart Mailboxes document: in IMAP METADATA under
`/private/vendor/loupe/projects`, else as a message in the `Loupe Settings` folder with `X-Loupe-Document: projects`.
[smart-mailboxes-format.md](smart-mailboxes-format.md) describes both places, how copies are found, written and
replaced, and why Gmail can't keep the document.

It lives in the **home account** only: the account that Settings › Smart Mailboxes › Sync via names (by default the
first account that isn't Gmail). Sync via › Off keeps the projects on the device.

```json
{
  "format": "loupe.projects",
  "version": 1,
  "entries": [
    {
      "id": "lq3k2x1a9b",
      "name": "House move",
      "color": "#ff9500",
      "modifiedAt": "2026-11-21T09:12:44.123Z"
    },
    {
      "id": "lq3m0c7f2d",
      "name": "Tax 2025",
      "color": "#34c759",
      "done": true,
      "query": "from:@accountant.example",
      "modifiedAt": "2026-11-20T18:00:00.000Z"
    },
    { "id": "lq2z9y8x7w", "modifiedAt": "2026-11-19T07:45:00.000Z", "deleted": true }
  ]
}
```

| Field | Meaning |
|---|---|
| `format` | Always `loupe.projects`. Anything else is not this document. |
| `version` | `1`. A change that version-1 readers would misread bumps it. Never write over a document whose version is newer than you understand; leave it alone. |
| `entries[].id` | The project id of the keyword (rules above): unique and stable. Loupe uses the creation time in microseconds, in base 36. |
| `entries[].name` | The name shown. |
| `entries[].color` | `#rrggbb`. Absent: the reader picks one. |
| `entries[].done` | `true`: finished. Loupe lists it after the others and leaves it out of the Tiles view. Absent means `false`. |
| `entries[].query` | Reserved: a search in the Loupe / Expression Search query language whose matches join the project. Loupe keeps it as it is but files new mail with rules instead (below). |
| `entries[].modifiedAt` | The last change, in ISO 8601 UTC with milliseconds. |
| `entries[].deleted` | `true` marks a tombstone, which carries only `id`, `modifiedAt` and `deleted`. |
| other fields | Allowed. Readers ignore fields they don't know and write them back unchanged. |

Entries a reader can't use (no valid `id` or `modifiedAt`) are kept as they are when the document is rewritten.

## Rules

Loupe files new mail into a project with its rules (Settings › Rules): ordinary rules whose action adds the project's
keyword (`{"type": "addTag", "keyword": "$loupe-project-<id>"}`). As device rules they run on new Inbox mail. As server
rules they are compiled to Sieve (`addflag "$loupe-project-<id>"`), so any client sees the result. Make Project on a
suggested topic makes one (`from:<domain>` or `subject:<word>`).

## Merging

Merging works exactly as for Smart Mailboxes:

- The later `modifiedAt` wins per entry. On a tie a tombstone wins, then the larger canonical JSON.
- Tombstones are dropped after 30 days.
- A change gets `modifiedAt` = now, or the entry's current time plus 1 ms if that is later.
- A writer reads and merges before it writes.

See [smart-mailboxes-format.md › Merging](smart-mailboxes-format.md#merging).

The order of `entries` carries no meaning. Loupe shows active projects by name, then the done ones.
