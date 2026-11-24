---
title: "Search your mail like you mean it"
description: "Search Loupe with words, filters and expressions today. Coming next: describe what you want in plain English and check the search Loupe proposes."
date: 2026-10-29T22:41:04Z
tags: [search, guide]
---

Most phone mail apps give you a search box and hope for the best. Loupe gives you a search box too, and if you type a few words, that's all you need. But underneath sits a complete search language, the same one you may know from the Thunderbird add-on Expression Search Reloaded.

## Start simple

Pull down on any message list and type. `invoice` finds invoices; `electric bill` finds that exact phrase; `electric and bill` finds both words anywhere. Results from your phone show up as you type; a moment later, results from your server stream in for anything older than what's stored locally.

## Search in plain English

**Coming soon with Private AI.** Choose **Ask in Plain English** and describe what you want:

> Unread mail from Dana or Ben

Loupe will turn that into filters you can check and edit: **From: Dana or Ben**, **Unread**. The expression behind them will be available too:

```text
f:(dana or ben) -is:read
```

Once you've checked it, the same search that powers typed expressions will find your messages on the phone and the server. You will be able to save it as a Smart Mailbox or use it to start a rule. If a name, account or date is unclear, Loupe will ask you to clarify it.

This will need a configured model: on a compatible phone, on your own server, or with a cloud provider you choose. Translating a search won't require sending message bodies to the model. Ordinary word search, chips and expressions will keep working without one.

The translator is planned and isn't in the Nightly yet. See the [search preview](/features/#search) and the [Private AI plan](/private-ai/). The rest of this guide covers the search tools available today.

## Add fields

Prefix a word with a field to say where to look:

```text
from:alice
subject:invoice
body:"tracking number"
to:team
```

Every field has a short form for fast typing on a phone keyboard: `f:` for from, `s:` for subject, `b:` for body, `t:` for to.

## Combine and group

Terms next to each other must all match. Use `or` and parentheses for alternatives, and negate anything with `-` or `not`:

```text
from:alice and (subject:invoice or body:"PO 123")
is:unread and -tag:newsletter
```

As you type, each part shows up as a chip in plain words ("From: alice", "Unread") that you can tap to change.

## Time and state

Dates can be exact or relative, and status is one word away:

```text
after:2026-03-01 before:2026-04-01
newer_than:7d
older_than:1y and attachment:yes
is:flagged is:unreplied
```

## One query, four engines

When you press search, Loupe parses your query once into a syntax tree. Then:

1. The phone's encrypted index answers first, using SQLite full-text search.
2. The same tree is compiled for your server: IMAP SEARCH, Gmail's own search syntax for Gmail accounts, or a JMAP filter.
3. Where a server can't express part of the query, Loupe asks it for a wider set and filters the results on the phone, so what you see always matches what you typed.

## Keep it

Two things make a good search last:

- **Save it as a Smart Mailbox.** It's stored on your mail server and shows up on your other devices.
- **Turn it into a rule.** Run it on the phone, or as a Sieve script on your server so it works while your phone is off.

The full list of operators, with every short form, is in the [search language reference](/docs/search-language/). Happy hunting.
