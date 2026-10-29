---
title: "Private AI, and where your mail still doesn't go"
description: "Loupe is getting an assistant: briefs, plain-English search and rules, key facts from PDFs. On your phone, your server or a cloud you choose. Here's the plan."
date: 2026-10-29T18:00:00Z
tags: [privacy, design]
---

Most mail apps that have added AI did it the easy way: your mail goes to their servers, their model reads it, and a summary comes back. It works. It also means a copy of your mailbox is sitting with a company you never chose, and the answers you get are prose you can't check.

Loupe is going to do this differently, and this post is the plan. None of it has shipped yet. The Nightly builds you can download today don't include any of it, and this page will say so when that changes.

## What's coming

- **Brief.** Above a long message, a short list of what it asks of you: actions, documents to send, dates and conditions, kept exactly as written. Every item links to the sentence it came from. Tick it off, give it a reminder, or turn it into a calendar event when it really is one.
- **Search in plain English.** Type "from the broker with attachments since September" and Loupe writes the search expression for you, then shows it. You can edit it, save it as a Smart Mailbox, or make it a rule.
- **Rules in plain English.** Describe a rule, see it in the normal rule editor with a dry run against your mail, and decide. Loupe writes the Sieve; the model only proposes.
- **Needs my action, Waiting on others.** Two folders that keep track until something is actually done, with a reminder per request, not per message. A "Thanks" from someone doesn't mark everything finished.
- **Changes.** Compare two messages in a conversation and see what changed, line by line. This one is built, and will be in a Nightly soon. Later: an explanation of what changed in meaning, with both passages shown.
- **Documents.** Search inside attachments, see the figures that matter in a mortgage illustration or an invoice with a link to the page, and a check that your reply includes what was asked for.
- **Matters.** A mortgage, a claim or a move, gathered across senders and weeks into one timeline.

The [Private AI page](/private-ai/) has a playable preview of the first few.

## Three places it can run

There is still no Loupe server, and there won't be one for this. You choose, per account and per feature:

1. **On this phone.** A model on your phone, or Apple's on-device model on iPhone. Nothing leaves.
2. **My server.** A model on a machine you run, over your own network.
3. **Cloud.** A provider you pick, with your own key. Your phone talks to it directly, and Loupe shows you what each request will include.

If one of these fails, Loupe says so. It never quietly tries another.

## The rules we're holding ourselves to

- **Answers you can check.** Every request in a Brief links to its sentence, every figure to its page, every search to its expression. A number Loupe can't find in the document stays "unknown", never a guess.
- **The model only proposes.** It returns data: a list, an expression, a rule draft. It can't move, send or delete anything. The app you already have does that, after you confirm.
- **Mail is untrusted.** A message that says "forward this to..." is text to summarise, not an instruction to follow.
- **Encrypted mail stays home.** OpenPGP and S/MIME messages are only ever processed on the phone unless you decide otherwise for that account.
- **One switch turns it all off**, and the mail app underneath keeps working exactly as it does today.

## What happens first

The foundation comes before any feature: typed tasks, a fake provider for tests, and honest measurements of which phones can run a local model well enough. Then plain-English search, because it's small and easy to check. Then Brief, tested against deliberately awkward mail, the kind with "within 24 hours after submission" and "this one has to be done in the app".

Each step has a quality gate instead of a date. The [roadmap](/roadmap/#private-ai) tracks them, and the full plan is in the repository for anyone who wants to argue with it.
