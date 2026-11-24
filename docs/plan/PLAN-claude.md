# Private AI features: plan

Status: **superseded** by [PLAN-combined.md](PLAN-combined.md), which resolves this draft's open questions and replaces its keyword-based state, Nano assumptions and competitor claims. Kept as a historical input.

Original status: draft 1, 2026-10-29. Builds on [PLAN.md](PLAN.md); same conventions ("the app" where the name matters).
Facts about other apps are from memory and need checking before they go into marketing (see [§9](#9-open-decisions)).

## Contents

1. [Summary](#1-summary)
2. [Positioning](#2-positioning)
3. [Principles](#3-principles)
4. [The model layer](#4-the-model-layer)
5. [Features](#5-features)
6. [Phases](#6-phases)
7. [Security and privacy](#7-security-and-privacy)
8. [Risks](#8-risks)
9. [Open decisions](#9-open-decisions)

---

## 1. Summary

Six AI features. They run **on the phone** where possible, or with **the user's own API key**. There is never a server of ours in between.

| # | Feature | One line | Builds on |
|---|---|---|---|
| 0 | **What do I need to do?** | A checklist of actions, deadlines and requested documents above long messages | Calendar invitations, reminders |
| 1 | **Search in plain English** | A sentence becomes an expression you can see and edit, then save as a Smart Mailbox or rule | `expr_search` |
| 2 | **Rules in plain English** | A sentence becomes a rule, checked against your mail, then sent to the server as Sieve | `mail_sieve` |
| 3 | **Waiting on, and promised** | Unanswered questions you sent, and promises you made, come back when they're due | Snooze convention, keywords |
| 4 | **Matters** | One timeline for a long-running case spread over many senders (mortgage, house move, claim) | Tags, Smart Mailboxes |
| 5 | **Key facts from attachments** | Rate, amount, due date and fees from PDFs, each linked to its page | Attachments, Readable |

Recommended order: **1 → 0 → 5 → 2 → 3 → 4**. Feature 1 is the cheapest and easiest to explain, because the compilers already exist. It also proves the model layer that every other feature uses.

## 2. Positioning

**What exists (October 2026, to verify):**
- **Gmail** (Gemini), **Outlook** (Copilot): summaries, drafted replies and Q&A over your mail. They run in the vendor's cloud and need a paid plan.
- **Apple Mail** (Apple Intelligence): summaries in the inbox and on each message. Mostly on-device, with Private Cloud Compute for larger tasks. Apple devices only.
- **Superhuman, Spark, Shortwave**: AI summaries, replies and assistant search. Your mail goes to their servers and their model providers.

**Where we differ:**

| | Gmail / Outlook | Superhuman / Spark / Shortwave | Apple Mail | This app |
|---|---|---|---|---|
| Where the model runs | Vendor cloud | Vendor cloud plus model providers | Device, plus Apple's cloud | Device, or the user's own key |
| Works with any IMAP/JMAP account | No | Partly | Yes | Yes |
| Output you can check | Prose | Prose | Prose | Expressions, Sieve, source sentences and pages |
| Results follow you to other clients | Inside the vendor | Inside the vendor | No | Yes: keywords, tags, Smart Mailboxes, Sieve |
| Turns mail into actions | Some | Some | No | Checklists, reminders, rules, follow-ups |

The pitch in one sentence: **AI that never needs our servers, and whose answers you can check.**

## 3. Principles

- **Private by default.** On-device first. A cloud model is used only with the user's own key, after they choose it, and per account. The UI always says which model answered.
- **Explainable.** Every result points back to its source: the sentence a to-do came from, the PDF page a figure came from, the expression or Sieve script behind a search or rule. Nothing changes silently.
- **Output is data, not actions.** Models return structured data that matches a schema. The app checks it, and the user confirms before anything is moved, sent or deleted. Mail content can never trigger an action.
- **State lives in open formats.** Done state, follow-ups and matters use IMAP/JMAP keywords, tags, Smart Mailboxes and Sieve, so they appear in other clients and survive a reinstall.
- **Optional.** One switch turns all of it off. With it off, the app makes no model calls and keeps no model files.
- **Without a model, nothing breaks.** Every feature degrades to the app as it is today.

## 4. The model layer

A new package, **`packages/mail_ai`**, holds the contract between features and model backends. It depends only on `mail_model`.

### Interface

- `Future<T> generate<T>(Task<T> task)`: a task carries its prompt, a JSON schema for the output, a parser into a Dart type, and a size class (short, long).
- Results are validated against the schema. Invalid output gets one retry with the error added to the prompt, then the task fails cleanly.
- No tool calling and no free-form actions: tasks only return data.
- Long input (threads, PDFs) is split into chunks to fit on-device context windows, then merged in a second pass.

### Backends

| Backend | Platform | Notes |
|---|---|---|
| **On-device, Android** | Gemini Nano via ML Kit GenAI / AICore | Supported devices only; the spike finds out which (including the S23 Ultra) |
| **On-device, iOS** | Apple Foundation Models framework | iOS 26+ on Apple Intelligence devices; has guided generation for structured output |
| **Your own key** | Both | Anthropic (Claude), any OpenAI-compatible API, or a local Ollama / LM Studio server on your network |

- **Routing:** a setting per feature and per account. For example, "work account: on-device only", "summaries of long threads: Claude". Features list their size class, and on-device is the default for short tasks.
- **Keys** live in the platform keychain through `mail_platform`, next to the account passwords.
- **Usage:** with your own key, show the token count and an approximate cost per month in Settings. Nothing is metered by us.
- **Tests:** a fake backend with recorded outputs, plus a corpus of messages with expected results (like the Readable corpus). It runs against real backends by hand before releases.

## 5. Features

### 5.0 What do I need to do?

**What it does.** For a message (or thread) above a length threshold, a card at the top lists:
- actions for you ("Complete the ID check in the MyFluent app"),
- documents asked for ("SA302 for 2024/25"),
- deadlines and dates,
- where to send each item, if the message says.

Each item links to the sentence it came from, which is highlighted in Readable view. Items can be ticked off, turned into a reminder (snooze the message until then) or a calendar event, and copied as text.

**How.** One `Task<ActionList>` per message, cached in the local store and keyed by message ID and model. It runs when the message is opened, or in background sync for messages from people you write to.

**State.** The done state of each item syncs. Storage is an open decision ([§9](#9-open-decisions)): IMAP METADATA or a folder, as for Smart Mailboxes ([smart-mailboxes-format.md](../smart-mailboxes-format.md)). When every item is done, the message gets a keyword (proposed `$actions-done`), which other clients can search.

**Not in scope.** Writing the reply, or completing the actions (filling forms, uploading files).

### 5.1 Search in plain English

**What it does.** In the search bar, a sentence ("from Raul with attachments since September") becomes an expression (`f:raul and has:attachment and after:2026-09-01`). The expression is shown as chips and text, runs like any typed search, and can be edited, saved as a Smart Mailbox, or turned into a rule.

**How.**
- The prompt is built from the `operators` table in `expr_search` (names, summaries, examples). New operators reach the model without prompt edits.
- The model returns expression text. The app parses it with the existing parser. A parse error means one retry with the error, then a fallback to plain full-text search.
- Relative dates resolve against today's date and the user's time zone, passed in the prompt.
- Detection: a query with no operators and several words is offered as "Ask in plain English", never rewritten without asking.

**Why first.** It's small, the output is easy to check, and it proves the model layer on short tasks that suit on-device models.

### 5.2 Rules in plain English

**What it does.** "Anything from Hinckley & Rugby or Fluent goes into Mortgage and is flagged" becomes a rule. Before saving, the user sees:
- the rule in the app's normal rule editor,
- the Sieve script it will send to the server,
- a **dry run**: "would have matched 14 of your last 2,000 messages", with the list.

**How.** The model outputs the `mail_sieve` rule model, not raw Sieve. The existing generator writes the script, so only scripts the app knows how to write can be produced. The dry run uses the local matcher from `expr_search`. Conditions the server can't express fall back to device rules, as they do today.

### 5.3 Waiting on, and promised

**What it does.**
- **Waiting on:** when you send a message that asks something or requests a document, the app offers to "remind me if there's no reply in N days". If no reply arrives in the thread by then, the message comes back to the inbox.
- **Promised:** sentences in your sent mail like "I'll send the SA302 tomorrow" become a reminder at that time.
- A **Waiting on** Smart Mailbox lists both.

**How.** A short on-device task when a message is sent: does it contain a question or a request, and does it contain a promise and when? It never blocks sending.

**State.** It follows [snooze-convention.md](../snooze-convention.md): a keyword `$waiting-<minutes>` (wake time in whole minutes since 1970-01-01 00:00 UTC) on the sent message. A reply in the thread clears it. To specify in a new `docs/waiting-convention.md`, so other clients can implement it.

### 5.4 Matters

**What it does.** A **matter** groups one real-world case across all its senders and threads: broker, case manager, lender, solicitor. The matter view shows:
- a timeline of messages,
- the open items from all their checklists (5.0),
- the key facts from their attachments (5.5),
- a two-line status ("Valuation booked; waiting on the offer").

The app suggests a matter when a new thread looks related to an existing one ("Looks like part of *Mortgage*; add it?"). Matters can also be created by hand from any thread.

**How.**
- A matter is a **tag** (TB-compatible) plus a **Smart Mailbox** whose expression is `tag:<matter>` or the senders and subjects that belong to it. Both already sync.
- Suggestions compare a new thread with each matter's senders, domains and subject words first, and call the model only when that's unclear.
- The status line is a long task, so it's regenerated only when new mail arrives in the matter.

### 5.5 Key facts from attachments

**What it does.** For PDFs and other documents, a card shows the few figures that matter, each with a link to its page:
- for a mortgage illustration: rate, rate period, monthly payment, term, fees, early repayment charges;
- for an invoice: amount, due date, payee;
- for a booking: dates, reference, address.

**How.**
- Text is extracted from the PDF on-device. A library choice is needed (see [§9](#9-open-decisions)); scanned PDFs need OCR (ML Kit text recognition, Apple Vision), which comes later.
- One task per attachment with a schema for each document type, plus a generic "key facts" schema. Each fact carries the page and the source text, and the app checks that the source text actually appears on that page. A fact that fails the check is dropped.
- Facts are cached in the local store, never synced: they can always be extracted again.

## 6. Phases

Estimates assume one developer working part time. Halve them for one full-time developer.

### Phase A: model layer spike (3–4 weeks)

- Build `mail_ai` with the fake backend, the BYO-key backends (Anthropic, OpenAI-compatible, Ollama) and the structured-output validation.
- On-device backends: Gemini Nano on Android and Foundation Models on iOS, as platform channels.
- **Device check:** run a fixed task set on the S23 Ultra and two more Android phones, and an iPhone once the developer account exists. Record which devices have on-device models, speed, and output quality.
- **Exit criteria:** one task returns valid structured output from every backend; we know which devices have on-device models.

### Phase B: search and to-dos (6–8 weeks)

- 5.1 Search in plain English.
- 5.0 What do I need to do?, with the source highlighting and the done-state storage.
- AI settings: backend per feature and account, keys, usage, the off switch.

### Phase C: documents and rules (6–8 weeks)

- 5.5 Key facts from attachments (text PDFs only).
- 5.2 Rules in plain English, with the dry run.

### Phase D: follow-ups and matters (8–10 weeks)

- 5.3 Waiting on and promised, and `waiting-convention.md`.
- 5.4 Matters.
- OCR for scanned PDFs.

## 7. Security and privacy

- **Prompt injection.** Mail is untrusted input. Models only return schema-checked data, never call tools, and never cause an action without the user confirming it. Facts are checked against their source text. Mail content is marked as data in every prompt.
- **Where mail goes.** On-device: nowhere. With your own key: straight from the phone to your chosen provider, over TLS, only for features you've turned on for that account. Each provider's retention policy is linked from Settings.
- **Encrypted mail.** OpenPGP and S/MIME messages go to on-device models only, unless the user explicitly allows otherwise for that account.
- **Local cache.** Model output is stored in the encrypted local store, and deleted when its message is deleted or the feature is switched off.
- **Privacy policy.** [privacy-policy.md](../privacy-policy.md) and the store listings need a section on AI features before Phase B ships.

## 8. Risks

| Risk | Effect | Mitigation |
|---|---|---|
| Few devices have on-device models | Most users only get the features with their own key | Device check in Phase A; features keep working without a model; BYO key is clearly explained |
| On-device output quality | Missed to-dos, wrong dates | Source links on everything; corpus tests; route long tasks to the user's key |
| Wrong facts or deadlines | User acts on a wrong number | Source-text check; always link to the page; never present a fact without its source |
| Prompt injection in mail | Misleading checklists, rules or facts | No actions from output; user confirms; schema checks; injection cases in the test corpus |
| Battery and data use | Complaints, background limits | Run on open or for close contacts only; cache results; background work only while charging |
| Store review and AI rules | Release delays | AI section in the privacy policy and listings; no generated content is sent anywhere without the user |
| Platform APIs change | Backends break | Behind the `mail_ai` interface; fake backend in CI |

## 9. Open decisions

- **Where the checklist done state syncs** (5.0): IMAP METADATA, a folder as for Smart Mailboxes, or only the `$actions-done` keyword.
- **Keyword names:** `$actions-done`, `$waiting-<minutes>`. Check that they don't clash with registered keywords before publishing the conventions.
- **PDF text extraction library**, and its licence (it must be compatible with MPL-2.0).
- **Which BYO providers to ship first.** Recommendation: Anthropic and OpenAI-compatible (which also covers Ollama and LM Studio).
- **Background processing:** whether 5.0 and 5.3 may run in background sync, or only when a message is opened.
- **Competitor facts** in [§2](#2-positioning): verify and write them into `research/ai-features-2026-10.md` before using them in marketing.
