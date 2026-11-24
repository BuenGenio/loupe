---
title: "Search language reference"
description: "Every search operator in Loupe with its short form, plus quoting, dates, sizes, tags, patterns, and/or/not and grouping, with examples."
section: "Reference"
order: 170
---

This page describes everything you can type into a Loupe search field. The same language is used by [Smart Mailboxes](/docs/smart-mailboxes/) and by the conditions of [rules](/docs/rules/), and it follows the language of the Thunderbird add-on Expression Search Reloaded.

For how searching works in the app (chips, suggestions, results from your phone and from the server), see [Search](/docs/search/).

## Quick examples

```text
weekend plans
from:fred to:tom a:yes
f:alice and (s:invoice or b:"PO 123")
s:invoice t:(alice -bob)
f:(amazon or ebay) older_than:1y
is:unread from:@example.com newer_than:7d
has:attachment larger:5M before:2026
tag:work -is:read
```

## Words and phrases

Text without an operator searches the sender and recipients, the subject and the message text.

- **Several words in a row form one phrase.** `weekend plans` finds messages where "weekend plans" appears, those words together and in that order.
- **To find words that aren't next to each other,** make them separate terms: `weekend and plans`, or quote each word: `"weekend" "plans"`.
- **Case doesn't matter.** `Invoice` and `invoice` find the same messages.
- **A word also finds longer words that start with it** in the mail on your phone: `invoice` finds "invoices". Results that come from the server may also match inside a word.

`all:` does the same as text without an operator: `all:weekend plans`.

## Operators

An operator is a name followed by a colon and a value, such as `from:alice`. Most operators have a short form: `f:alice` is the same as `from:alice`.

- Operators are always lower case. That is why `Re: lunch` searches for the text "Re: lunch".
- You can put a space after the colon: `from: alice` works.
- A value can be several words. It runs until the next operator, `and`, `or`, `not`, `-` or parenthesis: `s:electric bill s:march` is two terms. To be safe, quote values with spaces: `s:"electric bill"`.

### People and addresses

| Operator | Short forms | Finds messages where |
|---|---|---|
| `from:` | `f:` | the sender contains the text |
| `to:` | `t:`, `toorcc:` | To or Cc contains the text |
| `tonocc:` | `tn:` | To contains the text (Cc doesn't count) |
| `cc:` | `c:` | Cc contains the text |
| `bcc:` | `bc:` | Bcc contains the text (you only know the Bcc of mail you sent) |
| `recipients:` | | To, Cc or Bcc contains the text |
| `fromto:` | `ft:`, `ftc:`, `fromtocc:`, `alladdresses:` | any address (From, To, Cc or Bcc) contains the text |
| `only:` | `o:` | the people you name are the only To recipients |
| `account:` | `acc:` | the message is in an account whose name or address contains the text |

An address matches by its name and by its address, so `from:alice`, `from:"Alice Smith"`, `from:alice@example.com` and `from:@example.com` all work.

`only:` takes one or more people separated by commas: `only:tom`, `only:tom, jerry` or `only:(tom,jerry)`. Each person must be in To, and every To address must belong to one of them.

### Subject and text

| Operator | Short forms | Finds messages where |
|---|---|---|
| `subject:` | `s:` | the subject contains the text |
| `simple:` | | the subject contains exactly this text, with upper and lower case as typed |
| `body:` | `b:` | the message text contains the text |
| `all:` | `al:` | the sender, the recipients, the subject or the message text contain the text |

`simple:` takes the rest of the query as its value, so parentheses and dashes in it are just text: `simple:Re: (urgent) - call me`. Put it last, or inside parentheses.

> **Note:** A search of the message text needs the text. Loupe searches the text of messages downloaded to your phone, and asks the server for the rest.

### Status

`is:` (short forms `status:`, `i:`, `u:`) finds messages by their state. Case doesn't matter.

| Value | Other spellings | Finds |
|---|---|---|
| `is:unread` | `unseen`, `new` | unread messages |
| `is:read` | `seen` | read messages |
| `is:flagged` | `starred`, `marked` | flagged messages |
| `is:unflagged` | `unstarred`, `unmarked` | messages without a flag |
| `is:replied` | `answered` | messages you replied to |
| `is:unreplied` | `unanswered` | messages you haven't replied to |
| `is:forwarded` | | messages you forwarded |
| `is:draft` | | drafts |
| `is:junk` | `spam` | messages marked as junk |
| `is:attachment` | | messages with attachments |

`is:deleted` isn't supported: deleted mail is in the Trash.

### Attachments

| Operator | Short forms | Finds messages |
|---|---|---|
| `has:attachment` | | with attachments (`has:attachments`, `has:att` and `has:a` work too) |
| `attachment:yes` | `a:yes`, `a:y`, `a:1` | with attachments |
| `attachment:no` | `a:no`, `a:n`, `a:0` | without attachments |
| `attachment:` *text* | `a:` | with an attachment whose name or type contains the text, such as `a:pdf` |
| `filename:` | `fi:`, `fn:`, `file:` | with an attachment whose name or type contains the text, such as `fi:invoice.pdf` or `fn:msword` |

### Tags

`tag:` (short forms `l:`, `label:`) finds messages with a tag. Loupe uses Thunderbird's tags, so tags set in Thunderbird are found too.

| Value | Finds messages |
|---|---|
| `tag:work` | with the tag named Work (case doesn't matter) |
| `tag:"to do"` | with the tag named To Do. A name with a space also works without quotes: `tag:to do invoice` |
| `tag:o` | with any tag whose name contains "o", when no tag is named exactly that |
| `tag:#2` | with the second tag in the list (Work, in Thunderbird's default order) |
| `tag:na` | without any tag |
| `tag:projectx` | with the keyword `projectx`, when no tag name contains the text |

The standard tags are Important, Work, Personal, To Do and Later, in that order.

`keyword:` (short form `kw:`) finds a raw IMAP or JMAP keyword as it is stored on the server, for example `keyword:$label1` (Thunderbird's Important tag).

### Dates

Dates compare whole days, in your phone's time zone, by the day a message was received.

| Operator | Short forms | Finds messages received |
|---|---|---|
| `date:` | `d:` | on that day, in that month or in that year |
| `before:` | `be:` | before that day, month or year |
| `after:` | `af:` | after that day, month or year (not on it) |
| `newer_than:` | `n:`, `nt:` | within that age, today included |
| `older_than:` | `ot:`, `age:`, `ag:`, `days:`, `da:` | before that age |

`date:`, `before:` and `after:` take a day, a month or a year:

| You type | Means |
|---|---|
| `2026-03-01`, `2026/03/01`, `2026.3.1` | 1 March 2026 |
| `1 Mar 2026`, `1-Mar-2026`, `"March 1, 2026"` | 1 March 2026 |
| `2026-03`, `2026/03` | March 2026 |
| `2026` | the year 2026 |
| `today`, `yesterday`, `tomorrow` | that day |
| `7d`, `2w`, `3m`, `1y` | the day that many days, weeks, months or years ago |

So `after:2026` means from 1 January 2027, and `before:2026-03` means before 1 March 2026. A time after a full date is ignored (`be:"2024-03-01 14:30"` is the same as `be:2024-03-01`). A time of day on its own isn't supported.

`newer_than:` and `older_than:` take an age: a number with `d` (days, the default), `w` (weeks), `m` (months) or `y` (years), or `today` or `yesterday`.

| You type | Finds messages received |
|---|---|
| `newer_than:7d` (or `n:7`) | in the last 7 days, today included |
| `newer_than:today` | today |
| `older_than:1y` | before the day one year ago |
| `older_than:2w` | before the day two weeks ago |

### Size

| Operator | Short forms | Finds messages |
|---|---|---|
| `larger:` | `size:`, `si:` | larger than the size |
| `smaller:` | `sm:` | smaller than the size |

A size without a unit is in KB, as in Thunderbird: `size:500` means larger than 500 KB. Units are `B`, `K` or `KB`, `M` or `MB`, and `G` or `GB`, in any case: `larger:2M`, `smaller:100K`, `larger:1.5kb`.

### Headers

| Operator | Short forms | Finds messages where |
|---|---|---|
| `header:Name=text` | | the header field *Name* contains the text, such as `header:"List-Id=dev"` |
| `header:Name` | | the message has a header field *Name*, such as `header:X-Mailer` |
| `headerre:` | `h:`, `hr:` | the same, written the desktop way: `h:list-id`, `h:List-Id=/all-test/i` |

`headerre:` accepts a value written as a pattern, but only plain text in it is supported: `h:X-Spam=/a.*b/` is reported as a problem. It takes the rest of the query as its value unless the value is quoted.

### Patterns (regular expressions)

A pattern between slashes, such as `/inv(oice)?/`, matches text by a regular expression. Patterns are written the way JavaScript writes them.

| Operator | Short forms | The pattern is matched against |
|---|---|---|
| `regex:` | `re:`, `r:`, `subre:` | the subject |
| `bodyre:` | `br:` | the message text |
| `fromre:` | `fr:` | the sender |
| `tore:` | `tr:` | each recipient (To, Cc and Bcc) |

These operators take the rest of the query (or of the parenthesis around them) as the pattern, unless the value is between slashes or quotes. So `re: x y` is the pattern "x y", and `(re:a(b)c) f:x` limits it with parentheses.

- **Case:** a pattern between slashes is case-sensitive; add `i` after the closing slash to ignore case: `re:/^\[jira\]/i`. A pattern written without slashes, such as `tr:^team-`, ignores case.
- **Flags:** only `i` is supported. `g` is accepted and has no effect.
- **A slash** inside a pattern is written `\/`; inside square brackets it needs no backslash.
- **Addresses** are matched as `Name <address>`, or just the address when there is no name. So `fr:/@example\.(com|org)>$/` finds senders at either domain.

The text operators accept a pattern too: `from:/^al/`, `to:/x/i`, `a:/\.pdf$/i`. A pattern without an operator searches the addresses, the subject and the text: `/inv(oice)?/i`.

> **Note:** Mail servers can't evaluate patterns, so Loupe asks the server for a broader search and checks the pattern on your phone. A pattern search can take a little longer.

## Combining terms

| Write | Means |
|---|---|
| `f:bob s:report` or `f:bob and s:report` | both terms (a space means *and*) |
| `f:bob or f:dave` | either term |
| `-f:spam` or `not f:spam` | not this term |
| `( … )` | a group |

- **Order of operations:** *not* first, then *and*, then *or*. So `f:a or f:b s:c` means `f:a or (f:b and s:c)`. Use parentheses when in doubt.
- **Keywords** are `and`, `or` and `not`, written all in lower case or all in upper case (`AND`, `OR`, `NOT`). `Or` is an ordinary word.
- **Negating a value:** `f:-spam` is the same as `-f:spam`.
- **An operator in front of a group** applies to each value in it:

```text
f:(amazon or ebay)          from amazon or from ebay
t:(alice -bob)              to alice, and not to bob
f:(-foo -bar)               from neither foo nor bar
is:(unread flagged)         unread and flagged
si:(0.5M -2M)               larger than 0.5 MB, and not larger than 2 MB
af:(2024/03/01 -2024/03/09) received from 2 to 9 March 2024
days:(3 -5)                 between 3 and 5 days old
```

- **Negating a group:** `-(s:a or s:b)`.

## Quoting

- **Double quotes** keep text together and make operator words plain text: `s:"this or that"`, `"from: me"`.
- **Curly quotes** from phone keyboards work too: `“smart quotes”` and `„German quotes“`.
- **A backslash** inside quotes escapes a quote or a backslash: `"say \"hi\""`.
- **Quoted text ends a value.** `alice "smith"` is two terms, while `alice smith` is one phrase.

## Values that take one word

Some operators take a single word as their value, so a word after it starts a new term:

- `is:`, `has:`, `keyword:`, `larger:`, `smaller:`, `newer_than:` and `older_than:` take one word: `is:unread invoice` means unread messages that contain "invoice".
- `attachment:yes` and `attachment:no` take one word: `a:yes invoice`. Any other `attachment:` value takes the whole phrase: `a:my file`.
- `date:`, `before:` and `after:` take as many words as make a date: `before:1 Mar 2026 invoice`.
- `tag:` takes as many words as make a tag name: `tag:to do invoice`.
- `only:` continues after commas: `only:tom, jerry invoice`.

## Mistakes and partly typed searches

You don't have to finish a search for it to work. While you type, Loupe searches with the parts that make sense and underlines the parts that don't, such as an unclosed parenthesis or quote, an operator without a value, an unknown `is:` value or a date it can't read. In the rule editor, the problem is also explained in words.

## Compatibility with Expression Search Reloaded

The language matches the desktop add-on, with these differences:

- A `g:` at the start of a query (the add-on's global search) is ignored.
- Times of day (`af:9:00`) aren't supported, because Loupe compares whole days.
- The add-on's calculator isn't supported: `3*(4+5)` is searched as text.
- Thunderbird's `is:new` means unread.
