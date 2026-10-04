# Smart Mailboxes on the mail server

Loupe keeps Smart Mailboxes (saved searches) on the user's own mail server, so they follow the user to every device
with no server of ours. This page is the contract for any app that reads or writes them, in particular the Thunderbird
add-on Expression Search Reloaded.

## Where the document lives

Each IMAP account holds one document.

1. **IMAP METADATA (RFC 5464), preferred.** It is the private server annotation `/private/vendor/loupe/smart-mailboxes`
   on the empty mailbox name `""`:

   ```
   C: a1 GETMETADATA (MAXSIZE 1048576) "" /private/vendor/loupe/smart-mailboxes
   S: * METADATA "" (/private/vendor/loupe/smart-mailboxes {123}
   S: {"format":"loupe.smart-mailboxes","version":1,"entries":[...]})
   S: a1 OK GETMETADATA completed
   C: a2 SETMETADATA "" (/private/vendor/loupe/smart-mailboxes {125}
   S: + Ready
   C: {"format":"loupe.smart-mailboxes",...})
   S: a2 OK SETMETADATA completed
   ```

   This route is used when the server announces `METADATA` or `METADATA-SERVER` and accepts the command. Dovecot
   needs `imap_metadata = yes` and a `mail_attribute_dict`. Without the dict, Dovecot still announces METADATA but
   answers `NO`.

2. **The `Loupe Settings` folder, the fallback.** It is a top-level folder, or `INBOX<delimiter>Loupe Settings` on
   servers that keep every folder under INBOX. It is created unsubscribed. Loupe hides it on the Mailboxes screen and
   lists it in Manage Folders with an explanation. Each copy of the document is one message:

   ```
   From: Loupe <me@example.com>
   Subject: Loupe settings: smart-mailboxes (kept in sync by Loupe, please keep)
   X-Loupe-Document: smart-mailboxes
   MIME-Version: 1.0
   Content-Type: text/plain; charset=utf-8
   Content-Transfer-Encoding: base64

   eyJmb3JtYXQiOiJsb3VwZS5zbWFydC1tYWlsYm94ZXMiLC...
   ```

   Readers find copies by the `X-Loupe-Document` header, not by the subject. They decode any transfer encoding and
   read the body as UTF-8 JSON. Writers APPEND a new message (flagged `\Seen`) first, then delete the copies they
   merged into it. They never delete copies they haven't read: two devices writing at the same moment leave two
   messages, and the next reader merges them.

Gmail can't keep the document: it has no METADATA, and deleting a message from a Gmail label leaves it in All Mail,
so every folder copy would pile up there. Gmail accounts keep their Smart Mailboxes on the device.

Readers read both places. A server may hold a METADATA value and folder copies at the same time, for example copies
written before an administrator enabled METADATA. Readers merge every copy they find. After a write, writers remove
the copies they merged. If a value is too large for METADATA (`NO [METADATA MAXSIZE n]`), the writer stores it in the
folder and clears the annotation (`SETMETADATA "" (/private/vendor/loupe/smart-mailboxes NIL)`).

## The document

```json
{
  "format": "loupe.smart-mailboxes",
  "version": 1,
  "entries": [
    {
      "id": "lq3k2x1a9b",
      "name": "Invoices",
      "query": "subject:invoice has:attachment",
      "scope": null,
      "modifiedAt": "2026-10-04T09:12:44.123Z"
    },
    {
      "id": "lq3m0c7f2d",
      "name": "Receipts this year",
      "query": "after:2026-01-01",
      "scope": { "mailbox": "INBOX/Receipts" },
      "modifiedAt": "2026-10-03T18:00:00.000Z",
      "icon": "receipt"
    },
    { "id": "lq2z9y8x7w", "modifiedAt": "2026-09-30T07:45:00.000Z", "deleted": true }
  ]
}
```

| Field | Meaning |
|---|---|
| `format` | Always `loupe.smart-mailboxes`. Anything else is not this document. |
| `version` | `1`. A change that version-1 readers would misread bumps it. Never write over a document whose version is newer than you understand; leave it alone. |
| `entries[].id` | A unique, stable string. Loupe uses the creation time in microseconds, in base 36; a UUID is fine too. |
| `entries[].name` | The name shown in the mailbox list. |
| `entries[].query` | The search, in the Loupe / Expression Search query language (`from:`, `subject:`, `is:unread`, `has:attachment`, `tag:`, `before:`/`after:`, `OR`, `-`…). |
| `entries[].scope` | Where it searches. See the next table. |
| `entries[].modifiedAt` | The last change, in ISO 8601 UTC with milliseconds. |
| `entries[].deleted` | `true` marks a tombstone. Tombstones carry only `id`, `modifiedAt`, `deleted` and optionally `scope`. Absent means `false`. |
| other fields | Allowed, such as `icon`, `color` or add-on data. Readers ignore fields they don't know and write them back unchanged. |

| Scope | Searches |
|---|---|
| `null` or absent | Every mailbox of every account |
| `{"mailbox": "<path>"}` | One folder of the account whose server holds this document. The path is the decoded server path with the server's hierarchy delimiter, such as `INBOX/Receipts` or `INBOX.Receipts`. |
| `{"virtual": "<kind>"}` | A unified mailbox: `allInboxes`, `unread`, `flagged`, `vip`, `allDrafts` or `allSent` |

Entries a reader can't parse (no `id`, no valid `modifiedAt`) are kept as they are when the document is rewritten.

## Which account holds which Smart Mailbox

- A Smart Mailbox of one folder (`{"mailbox": …}`) lives in the document of the account that owns the folder. Folder
  paths are only meaningful on their own server, which keeps them portable.
- Smart Mailboxes of every account (no scope, or a virtual scope) live in the **home account's** document. In Loupe
  the home account is the first account that isn't Gmail, and the user can change it under Settings › Smart Mailboxes
  › Sync via. Pick the same account on every device. Unified entries found in another account's document, such as one left on a
  former home, are left untouched.
- Sync via › Off keeps every Smart Mailbox on the device only.

## Merging

Every writer reads, merges and then writes.

1. Collect the entries of every copy on the server and the local ones.
2. Per `id`, the entry with the later `modifiedAt` wins. When the times are equal, a tombstone wins. Otherwise the
   larger canonical JSON (sorted keys) wins, so that every device picks the same entry.
3. Drop tombstones older than 30 days.
4. Write the result if it differs from what the server holds, replacing the copies you read.

When you change an entry, set its `modifiedAt` to now. If the entry already carries a later time, written by a device
whose clock runs ahead, use that time plus 1 ms instead. This way the edit wins over the version it replaces. Edits to
different entries on two devices both survive. An edit and a deletion of the same entry resolve by time.

Known limit: a device that was offline for more than 30 days can bring back an entry that was deleted elsewhere in
the meantime, because the tombstone has expired.

## Checking a server

```
openssl s_client -quiet -crlf -connect mail.example.com:993
a1 LOGIN user@example.com password
a2 CAPABILITY                      (look for METADATA or METADATA-SERVER)
a3 GETMETADATA "" /private/vendor/loupe/smart-mailboxes
a4 LOGOUT
```

`* METADATA "" (/private/vendor/loupe/smart-mailboxes NIL)` with `OK` means METADATA works and nothing is stored yet.
A `NO` answer (Dovecot: `Mailbox attributes not enabled`) means Loupe uses the `Loupe Settings` folder. To enable
METADATA on Dovecot 2.3:

```
mail_attribute_dict = file:%h/dovecot-attributes
protocol imap {
  imap_metadata = yes
}
```
