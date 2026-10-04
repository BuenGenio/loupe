# expr_search

The Loupe search language. It parses what the user types into a `SearchExpr`
(mail_model) and works with the result in these ways:

- writes it back as text (`formatQuery`);
- labels its chips (`describeTerm`);
- suggests completions (`suggest`);
- evaluates it on a message (`matchesEmail`);
- compiles it for IMAP, Gmail and JMAP.

It is pure Dart, with no dependencies besides mail_model.

The language follows the Expression Search add-on for Thunderbird, so desktop
users can type what they already know. This is an independent implementation,
written from the add-on's user documentation.

## Syntax

```
f:alice and (s:invoice or b:"PO 123") after:2026-01-01 -is:read
```

- **AND:** terms next to each other must all match. Writing `and` between them is optional.
- **OR and NOT:** `or` gives alternatives. `not` or a leading `-` negates a term (`-f:spam`, `f:-spam`, `-(a or b)`).
  - Precedence: not > and > or.
  - The upper-case forms `AND`, `OR` and `NOT` work too.
- **Grouping:** parentheses group terms.
  - An operator in front of a group applies inside it: `to:(alice -bob)`, `from:(amazon or ebay)`.
- **Operators:** an operator is a lower-case name followed by a colon. `Re: lunch` is plain text.
- **Phrases:** consecutive bare words form one phrase, also after a text operator: `s:electric bill`.
  - A value that isn't free text ends at its own word: `is:unread invoice` is two terms.
  - Dates and tag names take as many words as form a date or a tag name: `before:1 Mar 2026 report`.
- **Quotes:** `"…"` makes text literal, with `\"` and `\\` as escapes. The smart quotes `“…”` and `„…“` from mobile keyboards also work.
- **Patterns:** `/pattern/` or `/pattern/i` works after any text operator (`s:/^\[jira\]/i`). On its own, a pattern searches all text.
  - A `/pattern/` is case-sensitive unless the `i` flag is given. A pattern written without slashes after `regex:` and the other pattern operators ignores case.

| Operator | Aliases | Matches messages… | Example |
|---|---|---|---|
| *(bare words)*, `all` | `al` | with the text in From, To, Cc, Subject or the body | `weekend plans` |
| `from` | `f` | whose sender contains the text | `from:alice` |
| `to` | `t`, `toorcc` | with the text in To or Cc | `to:bob` |
| `tonocc` | `tn` | with the text in To (not Cc) | `tn:bob` |
| `cc` / `bcc` | `c` / `bc` | with the text in Cc / Bcc | `cc:carol` |
| `recipients`¹ | | with the text in To, Cc or Bcc | `recipients:team` |
| `fromto` | `ft`, `ftc`, `fromtocc`, `alladdresses` | with the text in any address | `ft:tom` |
| `only` | `o` | whose To recipients are exactly these people, comma-separated | `only:(tom,jerry)` |
| `subject` | `s` | whose subject contains the text | `s:invoice` |
| `simple` | | whose subject contains the rest of the input, case-sensitive | `simple:Re: (urgent)` |
| `body` | `b` | whose body contains the text | `b:"tracking number"` |
| `filename` | `fi`, `fn`, `file` | with an attachment whose name or type contains the text | `fi:pdf` |
| `attachment` | `a` | `yes`/`y`/`1`: with attachments; `no`/`n`/`0`: without; anything else works like `filename` | `a:yes` |
| `has`¹ | | with attachments | `has:attachment` |
| `is` | `status`, `i`, `u` | read, unread, flagged (starred, marked), unflagged, replied (answered), unreplied, forwarded, draft, junk, attachment; `new` means unread | `is:unread` |
| `tag` | `l`, `label` | with a tag: an exact label, else every label containing the text; `#2` is the second tag, `na` means no tag; any other value is a raw keyword | `tag:work` |
| `keyword`¹ | `kw` | with this raw IMAP/JMAP keyword | `kw:$label1` |
| `before` / `after` | `be` / `af` | received before / strictly after a day, month or year | `after:2026-02-28` |
| `date` | `d` | received on a day, or in a month or year | `d:2026-03` |
| `older_than` | `days`, `age`, `ag`, `da`, `ot` | older than an age; `today`, `yesterday` | `older_than:2w` |
| `newer_than` | `n`, `nt` | newer than an age | `n:7` |
| `larger` / `smaller` | `size`, `si` / `sm` | larger / smaller than a size, in KB by default | `larger:2M` |
| `account` | `acc` | whose account name or address contains the text | `acc:work` |
| `regex` | `re`, `r`, `subre` | whose subject matches a pattern² | `re:/^\[jira\]/i` |
| `bodyre` / `fromre` / `tore` | `br` / `fr` / `tr` | whose body / sender / any recipient matches a pattern² | `tr:^team-` |
| `headerre` | `h`, `hr` | that have a header (`h:List-Id`), or whose header contains text (`h:List-Id=dev`)² | `h:list-id` |
| `header`¹ | | whose header contains the text | `header:"List-Id=dev"` |

¹ A Loupe addition.
² Takes the rest of the input, up to the end or to the `)` that closes its group, unless the value is quoted or a `/pattern/`.

Values for the date and size operators:

- **Dates:**
  - Full dates: `2026-03-01`, `2026/03/01`, `2026.3.1`, `1 Mar 2026`, `Mar 1, 2026`, `1-Mar-2026`. A time after the date is ignored.
  - A month (`2026-03`) or a year (`2026`).
  - Relative days: `today`, `yesterday`, `tomorrow`, and `7d`, `2w`, `3m`, `1y` (that long ago).
- **Ages:** a number of days, or a number with `d`, `w`, `m` or `y`.
  - `newer_than:7d` means today and the 6 days before.
  - `older_than:7d` means before the day a week ago.
- **Sizes:** a number with an optional unit, `B`, `K`, `M` or `G`. The default unit is K (desktop compatible). Examples: `500`, `0.5M`, `1536B`.

## How it maps onto `SearchExpr`

| Text | Expression |
|---|---|
| `to:bob` | `Or(Text(to, bob), Text(cc, bob))` |
| `is:unread` | `Not(Keyword($seen))` |
| `tag:work` | `Keyword($label2)` (via `TagDefinition`) |
| `after:2026-02-28` | `Date(onOrAfter, 2026-03-01)` |
| `date:2026-03` | `And(Date(onOrAfter, 2026-03-01), Date(before, 2026-04-01))` |
| `only:tom,jerry` | `And(Text(to, tom), Text(to, jerry), Not(Regex(to, ^(?!.*(?:tom\|jerry)))))` |
| `simple:Re: x` | `And(Text(subject, Re: x), Regex(subject, escaped, caseSensitive))` |
| `tag:na` | `And(Not(Keyword(tag)) for each known tag)` |

- `formatQuery` writes the canonical form, using full operator names, `to:`/`only:` where those shapes appear, and ISO dates.
- `parseQuery(formatQuery(e)).expr == e` holds for every expression the parser can produce. This is property-tested.

## Differences from the desktop add-on

- **Global search and the calculator:** `g:` (global search) is accepted and ignored. Arithmetic such as `3*(4+5)` is plain text.
- **Bare words:** they also search the body, as on the desktop with `all:`.
- **Times of day:** these are not supported (`after:9:00`, `date:" 13:"`). Such terms report an error and are dropped. Partial date text (`date:03/05`) is not supported either.
- **Statuses:** `is:new` means unread. `is:deleted` reports an error, because deleted mail lives in the trash on mobile.
- **Header patterns:** `headerre` handles plain text only, because `HeaderTerm` is a substring match.
  - A real pattern (`h:X-Spam=/a.*b/`) matches every message that has the header, and reports an error.
- **Tags:** labels come from the `tags:` parameter (Thunderbird's five defaults unless the account has its own). `tag:na` covers the known tags only.
- **Pattern flags:** only `i` is supported. Other flags report an error.
- **"To me only":** there is no `me` value. Write `only:me@example.com`.
- **Dates:** dates compare the local calendar day of `receivedAt`.

## Local evaluation

`matchesEmail` evaluates every node with three-valued logic. A term without the data it needs is *unknown*, and an unknown result counts as a match. Terms that can be unknown:

- the body without `content` (a hit in the preview still counts);
- an unknown header;
- the account without `accountLabel`;
- a zero size.

Unknown stays unknown under `not`, so `-b:x` without the body doesn't exclude the message. The result is always a superset of the true matches.

Details:

- **Addresses:** each address is one text, `Name <address>` (just the address when there is no name), for text and patterns alike.
- **Body:** the text part is used, or else the HTML stripped to text, with whitespace collapsed.
- **Attachment names:** these need `content`. Without it, messages without attachments don't match.
- **Headers:** they come from `headers`, from `content.headers`, and from what the summary knows (subject, addresses, Message-ID).

## Using it from other packages

**mail_imap.** `compileImap` widens internally; there is no need to call `widenForServer` first.

```dart
final q = compileImap(bindAccountTerms(expr, accountLabel));
final command = q.useUtf8 ? 'UID SEARCH CHARSET UTF-8 ${q.criteria}' : 'UID SEARCH ${q.criteria}';
```

- **UTF-8:** after `ENABLE UTF8=ACCEPT`, leave out `CHARSET`.
- **Non-ASCII values** are sent as quoted strings. If a server only takes 8-bit text as literals, send those strings as literals.
- **CR/LF:** values containing CR or LF are widened.
- **Post-filtering:** when `exact` is false, post-filter with `matchesEmail`.
- **Nothing to narrow:** `ALL` from a non-trivial query means the server can't narrow the search.
- **Headers first:** `supported:` widens more terms. For example, pass a predicate that rejects body text for a quick headers-only pass on servers without a full-text index.
- **Dates:** IMAP compares the date of INTERNALDATE in the server's time zone. Near midnight this can differ from the local day.

**Gmail.**

```dart
final raw = compileGmailRaw(expr) ?? compileGmailRaw(widenForServer(expr, gmailSupports))!;
```

- An empty string means everything.
- Gmail matches words, not substrings, and its dates follow Gmail's own time zone. Always post-filter with `matchesEmail`.

**JMAP.**

- `compileJmapFilter` widens patterns, attachment names and accounts by itself.
- Day bounds are local midnights converted to UTC.
- Post-filter unless every term passes `jmapSupports`.

**mail_sync.**

- Resolve account terms per account with `bindAccountTerms`. Skip the server when `matchesNothing` is true.
- Post-filter server hits with `matchesEmail`.

## API additions beyond the original contract

- Tags and the time anchor:
  - optional `tags:` on `parseQuery`, `formatQuery`, `describeTerm` and `suggest`;
  - optional `now:` on `suggest`.
- `QuerySuggestion.replaceStart` and `replaceEnd`: the range that the completion replaces.
- `compileImap(supported:)`.
- `simplifyQuery`, `bindAccountTerms`, `matchesNothing`, `gmailSupports` and `jmapSupports`.
