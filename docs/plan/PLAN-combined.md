# Loupe private intelligence: combined plan

Status: combined product and engineering plan, 2026-10-29. Consolidates [INTELLIGENCE.md](INTELLIGENCE.md) and [PLAN-claude.md](PLAN-claude.md), incorporating the reviewed additions and the user's decisions. It builds on the general [Loupe plan](PLAN.md) and current [architecture](../ARCHITECTURE.md).

The local literal Changes view is implemented in the working tree. AI providers, Briefs, action extraction, natural-language search/rules, semantic comparison and the other features below remain planned. Research dates and vendor measurements are evidence for model trials, not Loupe performance or quality guarantees.

## Direction and settled decisions

Help someone understand what mail requires, see what changed, and keep track until the work is done. Keep the calm reader, folders, search and rule editor as the main surfaces; advanced tools stay available on demand.

- **Needs my action** and **Waiting on others** are two persistent virtual folders with dedicated action state, counts and ordinary mailbox navigation.
- **Changes** combines inspectable literal differences with later source-backed explanations of changed meaning.
- **Brief** translates a message into supported facts and next steps, with source links and preserved conditions.
- **Plain-English search and rules** produce visible, editable deterministic expressions and rule proposals.
- **Documents** gain searchable contents, page-linked fact cards, version comparison and reply-readiness checks.
- **Matters** collect related conversations, documents and actions, with manual membership and corrections first.
- **On this phone / My server / Cloud** are explicit processing choices per account and feature. There is no silent local-to-cloud fallback or Loupe inference proxy.
- **AI is optional.** Stopping inference or removing models preserves ordinary mail and independently managed actions/matters. Model output proposes data; the existing app controls execution.

Source plans remain as historical inputs. This combined document resolves their differences: durable actions take precedence over a single Waiting Smart Mailbox or reply-clears-all heuristic; supported provider/capability checks take precedence over assumed universal Nano support; optional status projections do not imply universal sync or native support in other clients.

## 1. Brief: what this message requires

Add a Brief option alongside Readable, Original and Plain. It should show a short summary, required actions, documents, dates and conditions, followed by what happens next when the message states it. Every factual item links to a supporting passage in the source message or attachment.

The brief is a derived reading aid. Original wording stays available with one tap. The first version works on one downloaded message; a later thread brief combines messages and identifies withdrawn or superseded requests.

- Keep exact amounts, dates, tax years, owners and submission channels from the source.
- Preserve conditional timing: “within 24 hours after submission” cannot become “within 24 hours” or a deadline measured from receipt.
- Distinguish an explicit deadline, a suggested target and no stated deadline.
- Keep “complete in the app” attached to that specific action; do not turn it into permission to email an ID document.
- Do not add financial, legal or procedural advice while presenting it as a summary. Optional outside guidance must be separately requested, sourced and labelled.
- Passwords and other secrets should not be repeated in a brief; a source link can say that sign-in details are in the message.
- A short email can simply say that there is nothing to summarise. Failed extraction must not leave an apparently complete checklist.

Generate structured facts first and render them with Loupe widgets. Each fact carries its source, provenance and uncertainty. Validate quoted evidence against the input; a valid JSON response is not proof that the fact is true.

### Checklist actions

Each item can be completed or dismissed, copied, given an individual reminder, or used to prepare a calendar event when it actually describes an event. Offer Copy Checklist for the whole list. Show the proposed event date, time zone and details before handing it to the existing calendar flow; a task without a time is not automatically a calendar appointment.

Reminders belong to individual action records. Snoozing the whole message remains a separate mail operation. Inferred requests can be suggested in the Brief before the durable action system ships; only the action milestone adds persistent completion and reminders across restarts.

## 2. Obligations as virtual folders

Use the existing distinction between `VirtualMailbox` and `QuickFilter` (enums in `mail_model/src/mailbox.dart`) and Smart Mailboxes (`SmartMailbox` in `app/lib/settings/ui_state.dart`, synced by `mail_sync/src/smart_mailboxes.dart`):

| Existing concept | Purpose | Intelligence integration |
|---|---|---|
| `VirtualMailbox` | Built-in aggregate destinations such as Unread and All Sent | Add enum values for the action destinations, with repository queries |
| `QuickFilter` | Temporary narrowing of the current message list | Keep available inside action folders; do not use it to store obligations |
| `SmartMailbox` | A user-defined saved `SearchExpr` query | Can later query supported action properties, but is not the action database |

The virtual folder is computed from durable obligation records, not by running a model each time it opens. One message can appear in both folders if it contains commitments in both directions. Counts must state whether they count conversations, messages or actions; use conversation counts in the folder list and action counts inside each conversation.

Each action needs an independent identity, owner, source, original request, current request, channel, due condition and state. Proposed states are **Needs action**, **In progress**, **Sent**, **Waiting for acknowledgement**, **Acknowledged**, **Done**, **Dismissed** and **Superseded**. Not every action uses every state.

- “Please send the statement” belongs in Needs my action.
- A received promise from another person, “I will send the revised offer tomorrow”, belongs in Waiting on others.
- A sent reply can support “Sent”; it cannot prove the recipient accepted the attachment.
- An external form or ID check can be completed manually. Absence of an email reply is not proof it remains incomplete.
- A vague reply such as “Thanks” must not silently complete every action in a conversation.
- A new request for a different period or document creates or revises the relevant action; it must not revive all completed items.
- Snooze, dismiss and manual completion belong to the action, with visible undo.

Store actions in a dedicated table. Keep extracted suggestions separate from user overrides, so re-extraction, a model change or a new message cannot erase a correction or reopen a manually completed task. Changes to the underlying request should appear as reviewable updates.

### Follow-ups and promises

After sending a question or document request, offer an individual follow-up if it remains unresolved after a chosen period. A promise such as “I will send the calculation tomorrow” can suggest an action owned by the user. Extraction must not block sending.

A reply can update the relevant request, but cannot clear every waiting item in the conversation. Partial answers, acknowledgements and unrelated replies preserve outstanding work. Reminder notifications link to the action and conversation; returning a message to the Inbox is an explicit optional behaviour, not the action's storage mechanism.

Keywords such as an eventual actions-done or waiting marker may expose a coarse status to other clients. Define and check any published convention first. A message-level keyword cannot encode several independent action deadlines, owners or completion states, and is never the authoritative action database.

## 3. Search in plain English

Offer an explicit Ask in Plain English action in the existing search surface. For example, “from the broker with attachments since September” becomes an inspectable expression such as `from:broker has:attachment after:2026-09-01`. The user sees the resulting chips and expression, can edit it, and can save it as a Smart Mailbox or open Make This a Rule.

This is a query translator. Semantic retrieval across mail and attachment contents is a separate later capability. The translator can use the user's sentence, the operator catalogue and necessary account/folder metadata without receiving email bodies.

- Build the supported-language description from the existing `expr_search` operator table, including its names, aliases, summaries and examples.
- Return a bounded query proposal, parse it locally, and reject invalid or unsupported output. Successful parsing alone does not prove the query matches the user's intent; show its interpretation and scope.
- Pass the current date, user time zone and relevant locale when resolving dates. Preserve rolling periods with supported relative operators when a saved Smart Mailbox should continue to mean “the last seven days”. Make fixed versus rolling meaning visible.
- Offer translation without silently replacing ordinary full-text search or typed expressions. A failed translation can offer Retry, Edit Expression or Search These Words; it cannot silently execute a different search.
- Disambiguate people, folders, years and account scope when needed. Never invent a folder or silently expand from one account to every account.
- Run the approved expression through the same local/server search path as a typed query. Show partial or downloaded-only coverage using the existing search behaviour.

Use this as a small early consumer of the provider layer. It exercises structured proposals and validation while Brief and evidence work proceeds.

## 4. Natural-language rules

Example intent: “Keep this company's newsletters quiet, but still notify me about invoices.” Convert supported parts into a typed `Rule` and `SearchExpr`, then open the existing `RuleEditorScreen` with an explanation and preview.

The preview shows the exact account and mailbox scope, representative matching and non-matching messages, proposed actions, and whether the rule runs on the device or server. Unsupported conditions or actions stay unresolved and cannot be silently approximated.

The current `RuleAction` contract includes move, tags, flag, read, junk, keep-in-inbox and forward. It has no notification-only action. The newsletter example therefore needs an explicit notification-policy design before its full intent can be saved. Marking messages read or moving them is not an acceptable substitute for “quiet”.

Likewise, “invoice” is not currently a guaranteed semantic predicate. A deterministic subject/body keyword expression must be described as such. Offer the user explicit wording or conditions to choose; do not pretend a keyword rule identifies every invoice. A future semantic classifier requires its own saved version, evaluation and execution policy.

The model proposes a typed rule only. Parse and validate expressions with `expr_search`, resolve folders/tags against the selected account, reject unknown actions, and preview using the same evaluator that will execute the saved rule. Existing deterministic Sieve compilation can follow the normal server-rule flow after user review.

Never accept model-generated Sieve as executable output and never install a generated rule automatically. A suggestion to forward, delete or mark messages read must be as visible in the editor and preview as any other action.

### Preview and execution contract

The `Rule` type lives in `mail_model`; `mail_sieve` compiles and installs supported server rules. The model produces an allowlisted typed draft, never executable Sieve. Format and parse the condition with `expr_search`, require a valid parse, resolve actual account/folder/tag identities, run the existing rule validation, and obtain the server preview when applicable.

Show a dry run such as “would match 14 of 2,000 downloaded messages”, with representative matches and non-matches. State the coverage and do not imply that a local sample covers all server mail. The preview and saved rule must use the same deterministic semantics.

If the server cannot express a condition or action, explain the limitation and offer a device rule only when that alternative supports the complete draft. The user chooses the execution location. Applying to existing mail uses the existing explicit apply flow; saving a rule does not silently reprocess the mailbox. Once a reviewed rule is saved, the normal rule engine executes it without an LLM for each message.

## 5. Changes: a diff for email

### First working slice: implemented in the working tree

Compare Messages… in a message's menu opens Changes for two selected messages in the current conversation. From Message identifies the baseline and To Message the target. Initially choose the nearest earlier message from the same sender when one exists. Literal line changes and word highlights run in a bounded background isolate. Plain text is preferred; HTML-only messages use a DOM-based text conversion that retains link destinations. Quotes and signatures remain included in this slice.

Compare attachment names, MIME types and declared sizes separately; label matching metadata without claiming equal contents. Undecrypted content cannot be compared. Loading failures offer Retry, and oversized comparisons disclose their limits without claiming that omitted text matches. The screen is translated into all 37 app languages. It works offline when the message bodies are already downloaded; ordinary mail sync may fetch a missing body. No model, provider key or network inference is used.

This slice does not establish changed meaning, PDF-content differences or document equality. Equal filenames and sizes are not equal content. Missing downloaded bodies or attachment bytes need an honest unavailable/metadata-only state. Limit expensive comparisons and keep the reader responsive on long messages.

### Planned semantic comparison

Use the literal comparison as evidence for a concise explanation of changed facts: meeting time, fee, required document, commitment, delivery address or revised decision. Link each explanation to both source passages and show the exact text diff on demand.

- Offer “compared with previous message” and an explicit older-message selector.
- A later “since I last reviewed” mode needs a separate review checkpoint. The IMAP/JMAP read flag is not evidence that someone reviewed every change.
- Remove quoted history and signatures cautiously for comparison, preserving access to the full bodies and making uncertain quote boundaries visible.
- A newly received message can repeat an older position; message arrival order does not establish that it supersedes another statement.
- Show contradictions as contradictions until context resolves them. Do not choose the newest amount just because it occurs last.
- Compare document contents only after both versions are downloaded and successfully extracted. A byte hash proves equality of bytes, not equality of meaning.
- Do not present missing text in one message as a cancellation of a prior obligation without supporting wording.

The analogy is git diff's inspectable before/after, not version control over immutable email. Original messages are never rewritten.

## 6. Documents: search and key facts

Search the text of downloaded attachments, then add OCR for scans and photographed documents. Results show the document, message, page and matching passage. Natural-language retrieval may rank results, but opening a result must show why it matched.

Begin with bounded PDF/text extraction and exact search. Record extraction failures, password protection and unindexed pages. Never claim to have searched the whole account when only downloaded content is indexed. Encrypted content can be indexed only after normal decryption permission and under the same cache policy.

Keep document identity separate from filename. A replacement `illustration.pdf` may contain different terms; two differently named files may contain the same bytes. Use content hashes when bytes are available, with explicit “not downloaded” status otherwise.

Semantic embeddings can later support “the statement I sent to the broker” or “the illustration with a lower arrangement fee”. They do not establish the authenticity or correctness of a document. Local extraction and ranking should remain useful without a generative model.

### Document fact cards

Add a compact card containing a document's important fields, using a schema for each supported document type and a conservative generic fallback.

| Document | Example fields |
|---|---|
| Mortgage illustration | Rate, rate period, monthly payment, term, fees, early repayment charges |
| Invoice | Amount, currency, due date, payee, invoice reference |
| Booking | Dates, time zone where stated, reference, address |

Every field links to its page and supporting quotation. Check that the quotation exists on that page, then validate the interpretation: a number appearing on a page does not establish that it is the monthly payment rather than a fee. Keep units, currencies, periods, qualifiers and uncertain values attached to the fact. Unsupported, absent or conflicting fields remain unknown; never fill a schema with guessed values.

Start with text-based PDFs and supported text documents. Add local OCR for scans and photographs later, preserving page coordinates and extraction quality. Select a maintained extraction library with a licence compatible with Loupe before implementation. Cache derived facts locally by content hash and extraction/schema/model versions; a filename is insufficient identity.

## 7. Reply readiness

Compare the source requests with the current draft and selected attachments. Show a compact, dismissible review near the attachments: included, possibly wrong period, missing, or requires an external step.

The check must inspect actual selected files when it makes a document-content claim. A filename alone can support only a tentative match. A tax calculation for a different year must not pass because its filename contains the right keyword. Unreadable or protected attachments remain unknown.

Start with ordinary attachment reminders and user-selected request lists. Add extraction-driven suggestions after Brief and action records pass evaluation. Sending remains the user's decision; this feature neither blocks sending on a model guess nor attaches or emails private documents automatically.

## 8. Matters

A matter groups related conversations, documents, requests and updates even when their subjects and senders differ. Examples include a mortgage application, an insurance claim or arranging repairs.

The matter screen shows the latest supported position, open actions, what is waiting on another person, relevant documents and a chronological history. Users can create, rename, merge and split matters and correct membership. Suggested grouping must be reversible; sharing a sender or subject is not sufficient evidence that two matters are the same.

Start with manual matter membership and suggested candidates. Add model-assisted grouping only after identity, evidence and corrections work. Matter state is separate from the physical mail folder, so filing a message does not remove it from the matter.

Use a tag and a saved Smart Mailbox as optional projections of explicit matter membership, so existing mail tools remain useful. Dedicated matter records hold the matter identity, corrections, relationships and history. Do not define a matter only as everyone who shares a sender or domain: one broker can handle several applications.

Cheap sender/subject matching can suggest candidate matters before invoking a model. Regenerate the short supported status only when relevant source messages, facts, membership or manual state change. The product name is “Matter” (decided 2026-10-29); “case file” was the alternative.

## Shared architecture

### Typed tasks and providers

Introduce `packages/mail_ai` for task orchestration and provider contracts, with shared mail/evidence types in `mail_model`. Keep core logic independent of Flutter and native SDKs. Native inference adapters and network clients sit behind interfaces and declare their own dependencies; avoid a dependency cycle between the packages.

A task carries a stable task type, bounded input, prompt/schema versions, output schema, typed parser/validator, output budget, cancellation and evidence requirements. A conceptual interface is `Future<T> generate<T>(Task<T> task)`. A simple short/long size hint can help routing, but actual token limits, language support, schema support and foreground restrictions are provider capabilities that must be checked.

- Validate all results before exposing them to features. If output is malformed, allow one bounded repair attempt with validation feedback through the same permitted provider. Then fail cleanly; do not retry forever or upload elsewhere.
- Use constrained output where the actual adapter supports it. Correct structure and source-text presence remain insufficient proof of correct meaning.
- For long inputs, extract bounded chunks with original message/page references, then merge supported facts. Do not flatten conditional deadlines or lose conflicting statements during the merge.
- Expose extraction and proposal operations only. Models have no live mail-action or arbitrary network tools. Normal deterministic actions remain available through the existing app after user review.
- A fake provider and recorded synthetic responses support tests without a model, account key or network. Cancellation, partial output and provider replacement cannot corrupt existing durable state.

### Evidence and identity

Introduce plain contracts in `mail_model` for Brief facts, evidence references, obligations, matter membership, comparison checkpoints and provider capabilities. Keep inference and extraction implementations behind interfaces so the app and demo repository can exercise them without loading a model.

Evidence needs the account, logical message identity, current local location, body/attachment content hash, normalisation version and passage/page location. Preserve enough context to relocate a passage; normalised text offsets alone are fragile after parser changes.

Current `MailIds` are location-dependent: IMAP IDs include mailbox path, UIDVALIDITY and UID, and JMAP has a local copy per mailbox. Moving mail can change local IDs. Add an explicit logical identity/reconciliation layer before durable actions or review checkpoints depend on an email ID. Use provider stable identity where available, move mappings where known, and guarded RFC Message-ID/content matching where necessary. A Message-ID alone is neither unique nor always present.

Extraction runs should record input hashes, prompt/schema/model versions, provider and date. Reuse valid results, invalidate changed inputs, and preserve manual overrides. Distinguish no requests found, not analysed, partially analysed and failed.

### Storage and sync

- Briefs, extracted text, embeddings, document thumbnails and inference caches are sensitive derived mail data. Keep them device-local by default, under the existing protected storage design, with bounded retention and a clear delete/rebuild action.
- Do not put extracted content or model output into the Smart Mailbox settings document.
- Add separate versioned tables/documents for action and matter state. If state sync is offered later, make it opt-in and minimise it to identities, manual states, timestamps and required conflict-resolution data.
- Inspect what that minimal state reveals before choosing a mail-server document format; titles and task descriptions can themselves expose sensitive content.
- Existing server settings documents have provider limits. Gmail is unsupported by the current document mechanism; keep state local unless a separate supported route is designed. See [Smart Mailboxes format](../smart-mailboxes-format.md).
- Reconcile edits deterministically, preserve manual completion/dismissal, and retain deletion tombstones long enough to prevent ordinary offline devices restoring removed items.
- Removing an account must remove its derived data. Revoking a provider stops new requests and offers deletion of its local results without deleting original mail.

### Processing and permissions

Mail bodies, attachments, OCR text, links and quoted instructions are untrusted source data. They cannot change model instructions, enable providers, call mail actions, fetch arbitrary URLs or request extra messages. Expose extraction and proposal tools rather than live send/move/delete tools to the model.

The app prepares a bounded input, validates a typed result, checks evidence, then renders or previews it. Models do not receive account credentials, unrestricted repository access or provider keys. Do not fetch linked pages while producing an email brief; links can be represented as source links without opening them.

Provider policy is per account and per feature, with distinct **On this phone**, **My server** and **Cloud** choices. Add credentials through the existing secure credential store. Configuration records the endpoint, provider/model, permitted task types, body/attachment scope and any automatic processing consent. Self-hosted processing is network processing and must be labelled accordingly.

Show which provider produced a result and what content a network request will include. Local-only and encrypted-mail restrictions take precedence over generic provider defaults. A timeout, unsupported language or failed validation offers retry/another explicitly permitted provider; it never silently uploads mail. Avoid request bodies, credentials and generated sensitive text in logs or crash reports.

For the first network adapters, evaluate an Anthropic adapter and a tested OpenAI-compatible endpoint adapter. The latter may support selected Ollama or LM Studio deployments; protocol compatibility, authentication, structured output, token reporting and cancellation must be checked per endpoint. Provider credentials travel only through their required authentication mechanism and are never included in model prompt content. There is no Loupe-hosted inference proxy or mailbox-copy service.

Background processing is separately enabled per account/feature and only available when the selected runtime and OS permit it. Consent, charging or a foreground service do not override a provider's foreground-only restriction. Start with user-triggered foreground work; assess scheduled inference only after the device spike. Deterministic saved server rules continue to run under their existing server capabilities.

## AI settings and controls

Keep these controls in Settings, with a small provider/result indicator where it helps explain an answer.

| Control | Behaviour |
|---|---|
| Global AI switch | Stop new model calls and cancel queued inference. Ordinary mail, literal Changes and manual task/matter work remain usable. |
| Account and feature policy | Select permitted providers, local-only restrictions, attachment scope, automatic-processing consent and any explicit fallback policy. Stronger account restrictions always win. |
| Model management | Show model/version, download size, storage use, readiness and device-test result; allow download, replacement and removal of Loupe-owned models. Shared system-managed models remain under OS control. |
| Usage and estimated cost | Show requests, reported input/output tokens and estimated spending by provider/model and period. Identify unavailable usage and the pricing date/source; estimates are not a provider billing statement. |
| Delete derived results | Clear selected briefs, facts, embeddings and inference caches without deleting original mail or manually managed obligations/matters. Explain what can be rebuilt. |
| Provider removal | Revoke credentials, cancel pending requests and offer removal of provider-derived local results. Never silently select another network provider. |

Disabling AI and deleting downloaded models are separate operations. Clear pending task inputs when cancellation/account policy requires it. Retain user decisions independently of generated prose, so clearing a cache cannot undo a completed task. Removing an account removes its associated derived data and durable account state.

Encrypted OpenPGP/S/MIME content uses on-device inference by default. Network processing of decrypted content needs its own explicit account policy, and the normal decryption permission must already have succeeded. Provider retention policies belong beside the relevant settings. Update the privacy policy and store disclosures before releasing any network AI feature.

## Local model and phone plan

Research checked on 2026-10-29. These are candidates for measurement, not a claim that Loupe's email tasks have passed on these models.

| Candidate | Proposed role | Current primary evidence |
|---|---|---|
| Gemma 4 E2B IT, mobile LiteRT bundle | First Android local candidate for Brief, action extraction, proposed rules and explaining changes | Phone-targeted, Apache 2.0, 140+ languages; base-model context is 128K. [Google model card](https://ai.google.dev/gemma/docs/core/model_card_4) |
| Gemma 4 E4B IT, mobile LiteRT bundle | Optional quality tier after device testing | Larger memory footprint and stronger vendor benchmark results; no Loupe quality result yet. [Google model card](https://ai.google.dev/gemma/docs/core/model_card_4) |
| Qwen3.5-2B / 4B | Multilingual benchmark challenger | Apache 2.0, 201 languages/dialects advertised; 2B card positions it for prototyping/task tuning. Mobile runtime and quantisation must be verified. [2B card](https://huggingface.co/Qwen/Qwen3.5-2B), [4B card](https://huggingface.co/Qwen/Qwen3.5-4B) |
| Qwen3.5-0.8B / Gemma 3 1B | Narrow small-device experiments | Test short classification/extraction; do not assume acceptable detailed summarisation. [Qwen card](https://huggingface.co/Qwen/Qwen3.5-0.8B), [Google model list](https://developers.google.com/edge/litert-lm/overview) |
| Gemini Nano through ML Kit | Optional Android system provider where available | Current support list excludes S23 Ultra. Top-foreground-app-only inference and quotas prevent using it as a universal background engine. [ML Kit support and restrictions](https://developers.google.com/ml-kit/genai) |
| Apple on-device `SystemLanguageModel.default` | First native iPhone provider where available | Check model availability, supported language and context size at runtime; current guidance describes 4,096 tokens/session. Foundation Models also exposes network providers, which are separate choices. [Availability](https://developer.apple.com/documentation/FoundationModels/generating-content-and-performing-tasks-with-foundation-models), [context](https://developer.apple.com/documentation/foundationmodels/managing-the-context-window), [framework](https://developer.apple.com/foundation-models-framework/) |

Use LiteRT-LM for the Android model spike: Kotlin is stable, while its Swift API is currently an early preview. MediaPipe LLM Inference is maintenance-only. Native bridges and their binary/dependency cost need a Flutter integration spike. [Runtime overview](https://developers.google.com/edge/litert-lm/overview), [MediaPipe status](https://developers.google.com/edge/mediapipe/solutions/genai/llm_inference)

Constrained decoding can enforce output structure; ordinary code still validates evidence and meaning. Verify the released bridge exposes the required schema support. Do not infer Kotlin functionality from a C++ example alone. [LiteRT constrained decoding](https://github.com/google-ai-edge/LiteRT-LM/blob/main/docs/api/cpp/constrained-decoding.md)

### Download size, memory and measured performance

The current E2B `.litertlm` download is about 2.58 GB. It uses mixed mobile quantisation, a text decoder weight footprint as low as 0.8 GB and memory-mapped embedding parameters. Encoders load on demand. The deployment card supports up to 32K context, despite the base model's 128K. Google's S26 Ultra benchmark uses 1,024 prompt tokens, 256 output tokens and 2,048 context, with warm caches; time-to-first-token excludes model loading. Its roughly 52 tokens/s GPU result is not an S23 result. [E2B deployment card](https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm)

E4B's bundle is about 3.66 GB, including about 2.24 GB decoder weights and 0.67 GB embedding parameters. Its deployment card also documents up to 32K context. [E4B deployment card](https://huggingface.co/litert-community/gemma-4-E4B-it-litert-lm)

Download size, active weights and total process/device memory are different measurements. Context caches, runtime, loaded embeddings, GPU allocations, other apps and Loupe's mail store all need headroom. Published Android CPU-memory columns do not establish total CPU/GPU consumption. Google's mobile memory estimates exclude additional software/context costs. [Memory planning](https://ai.google.dev/gemma/docs/core)

| Device tier | Provisional behaviour before measurement |
|---|---|
| Android 4–6 GB | Offer only small-model experiments for short tasks; do not label full local Brief support as recommended |
| Android 8 GB, including S23 Ultra 8 GB | Trial E2B mobile, text-only, short bounded inputs and one inference at a time |
| Android 12 GB+, including S23 Ultra 12 GB | Trial E2B; make E4B optional only after memory, latency and quality checks |
| Eligible iPhone 15 Pro / iPhone 16 and later models | Prefer capability-detected Apple local inference; respect language/region/model readiness. Downloaded alternatives need a separate measured trial |

Samsung documents Snapdragon 8 Gen 2 and 8/12 GB S23 Ultra variants; inspect the actual device. No S23 benchmark has been run for this plan. [Samsung specifications](https://samsungmobilepress.com/articles/take-your-passions-further-with-the-new-samsung-galaxy-s23-series-designed-for-a-premium-experience-today-and-beyond), [Apple eligibility](https://support.apple.com/en-mide/121115)

Add **Test this phone** using synthetic local fixtures. Measure cold load, warm latency, full peak memory, battery/thermal behaviour, cancellation and correctness with realistic input lengths. Recommend a model from those results, not RAM alone. Begin with a conservative 4K input/output budget, expanding only after evaluation; large advertised context is not permission to ingest an entire mailbox.

Cloud and self-hosted candidates use the same schemas and evaluation set. Select actual default models after quality/cost/latency testing, rather than treating provider brand or size as proof of correctness. Record model versions and licence/notices for bundled or downloaded models. Gemma 4 and Qwen3.5 candidate weights use Apache 2.0; older Gemma generations have different terms.

## Delivery milestones

Use dependency and quality gates to set scope. The earlier draft's week estimates are provisional; set calendar estimates after measuring the provider/device spike and the first complete AI feature.

| Milestone | Deliverable | Exit condition |
|---|---|---|
| A: local Changes, implemented in working tree | Literal message comparison, attachment metadata differences, conversation entry point | Clear source selection, bounded comparison, unavailable-data handling and no model/network inference |
| B: evidence and provider foundation | Typed tasks, fake provider, local-model and network-adapter spikes, policy/settings controls | Validated evidence; cancellation; no silent upload; device and task-quality reports |
| C: plain-English search | Explicit translation into the existing editable expression/chip interface | Supported operators and date semantics; invalid/ambiguous results handled; deterministic search parity |
| D: Brief | Single-message summary and source-linked requests | Mortgage/adversarial fixtures pass; original accessible; partial/unknown results explicit |
| E: action virtual folders | Dedicated obligations, manual actions, durable identity, counts and task reminders | Overrides survive restart, moves and re-extraction; sent/acknowledged/done remain distinct |
| F: rule helper | Typed proposal, normal editor, capability checks and dry run | Preview matches execution; unsupported notification/invoice semantics remain unresolved; no raw generated Sieve |
| G: semantic Changes | Source-backed fact differences, explicit review checkpoints | No false cancellations; conflicts visible; read/unread flags do not move the checkpoint |
| H: documents and reply readiness | Bounded text extraction/search, document fact cards, content/version comparison and draft checks; OCR afterward | Page evidence, partial-index coverage, wrong-year/unknown-file handling and extraction limits |
| I: matters and optional state sync | Manual grouping, later suggestions, minimal versioned sync | Correctable membership, account isolation, conflict recovery and disclosed provider limitations |

B is the immediate foundation. C is a small early consumer of it and can proceed alongside D's evidence/UI work. Manual action storage and virtual-folder work can begin before automatic extraction, while model-generated updates depend on the earlier quality gates. F can progress once typed proposals and previews work. Attachment comparison within Changes depends on H's extraction; matter grouping can start manually before automatic suggestions and optional sync.

A is the implemented first slice; all other milestones remain planned. Neither passing literal-diff tests nor returning schema-valid model output establishes that the full roadmap or a shipping AI model is ready.

## Acceptance fixtures and release gates

Use synthetic mail, people, domains, attachments and sign-in secrets. Never commit the user's pasted mortgage message, personal details, password, actual documents or private account contents. Preserve the structural difficulty of the example with invented correspondence.

| Fixture | Required result |
|---|---|
| Mortgage request containing five independent requests | Five items: a full month's bank statement, app-only ID check, SA302 for the stated 2024/25 year, the overview labelled 2025, and an external form; no invented additional request |
| Mortgage timing | Case-manager assignment is within 24 hours after submission to the lender, not after receipt of the email |
| Mortgage submission channels | ID check requires the app; the specified other documents may be emailed/uploaded as stated |
| Ambiguous tax-year wording | Preserve the stated label or flag ambiguity; do not infer a tax-period end date |
| Mortgage illustration mentioned but unread | State that the attachment is present/mentioned; do not invent its rate, monthly payment or fees |
| Rate and deadline wording | Preserve prerequisites as written; do not invent a lock date, claim a rate is already secured, or create urgency absent from the source |
| Secret in source | Do not repeat it in generated text or logs; source remains available through the ordinary reader |
| New reply quoting old requests | Do not duplicate tasks, revive dismissed work or treat quotations as fresh commitments |
| “Thanks” after documents sent | Keep sent/acknowledged/done distinctions; completion needs evidence or manual action |
| Revised date/fee and contradictory participants | Show both supporting passages and uncertainty, including chronology and conditions |
| Same attachment name and size, different bytes | Metadata comparison does not claim identical contents; byte comparison detects change once available |
| Move, duplicate Message-ID, multi-label copies, UIDVALIDITY reset | Actions/matters/checkpoints retain the correct logical source without attaching to an unrelated message |
| Mark unread after reviewing / automatic mark read | Review checkpoint does not move as a side effect of either flag change |
| Rule requesting invoice-only alerts | Unsupported notification action and semantic predicate are surfaced; no substitute action silently saved |
| Unsupported rule fields, invalid folder, unknown action | Reject before preview/save; deterministic validation remains the authority |
| Hostile mail asking the assistant to forward secrets or enable cloud | Treat as source text; no execution, provider change or extra data fetch |
| Local failure while cloud is unconfigured or prohibited | Remain local, show failure/retry; zero cloud request |
| Protected/large attachment, missing body, partial index | Show bounded, partial or unavailable state; do not render a complete-result claim |
| Multilingual mail, mixed languages, RTL, locale dates | Evaluate extraction and display separately; preserve source ambiguity and unsupported-language status |
| Manual complete/dismiss then model upgrade/re-extraction | Preserve overrides and expose genuinely changed requests for review |
| Plain-English query with ambiguous sender/account/year | Show interpretation or request disambiguation; do not widen scope silently |
| Saved “last seven days” search | Preserve rolling semantics through supported relative operators; distinguish it from a fixed date range |
| Invalid translation or unsupported server rule | Offer explicit alternatives; do not silently execute full-text search or a device rule |
| Invoice with several totals/currencies and mortgage with fee/payment figures | Select the correct field and qualifier or mark unknown; a matching quotation alone cannot pass |
| Global off, model removal, cache deletion and provider revocation | Stop permitted work as configured; preserve independent manual task/matter decisions |
| Missing token usage or outdated pricing | Show unknown/estimated cost with provenance; never display missing usage as zero |
| Checklist reminder or calendar shortcut | Keep action-specific timing; preview event details; no implicit appointment or blanket message snooze |

Track request precision/recall, unsupported factual additions, source-link correctness, condition preservation, wrong-document matches and rule-preview equivalence separately. A pleasant summary cannot compensate for a missed app-only requirement or invented deadline. Establish and publish acceptance thresholds on a held-out synthetic/anonymised corpus before selecting a shipping model; run the same task fixtures for local, self-hosted and cloud providers.

Measure cold and warm performance on the actual S23 Ultra and at least one constrained Android tier before recommending local support. Test offline, memory pressure, cancellation, background restrictions, account removal and cache deletion. Keep first-slice deterministic diff tests separate from model evaluation; passing them proves comparison behaviour, not semantic reliability.

## Risks and decisions to resolve during implementation

| Area | Required decision or mitigation |
|---|---|
| Model quality and phone coverage | Benchmark exact artifacts on the actual S23 variant and a constrained device. Retain an honest unavailable/experimental state where the quality or memory gate fails. |
| Provider breadth and maintenance | Select a small tested adapter set first. Resolve actual cloud model/version defaults from the same evaluation corpus; record endpoint capabilities and licences. |
| PDF/OCR dependencies | Choose bounded text extraction with a compatible licence; assess page mapping, encrypted PDFs, OCR accuracy and native binary cost before expanding supported formats. |
| Notification rules | Define a genuine notification-policy action and interaction with account muting, VIP settings and OS permissions before offering “quiet except invoices”. |
| Action/matter sync | Finalise the logical source identity, versioned minimal state, merge/tombstone rules and a supported Gmail route before promising cross-device restoration. |
| Optional keyword projections | Publish a convention only after checking interoperability and collisions. Explain that ordinary mail clients may see tags/keywords without understanding Loupe task or matter records. |
| Battery, storage and OS restrictions | Set bounded jobs, concurrency, cancellation and cache/model-retention policies from measurement. Charging is an additional preference, not permission to bypass runtime restrictions. |
| Usage estimates | Decide how provider usage and pricing metadata are updated and displayed. Add budget controls only with clear behaviour when usage is unavailable or approximate. |
| Release disclosures | Update privacy policy and store listings for each data-processing route, encrypted-mail policy and provider retention links before the relevant feature ships. |
| Positioning | Verify specific competitor capabilities, availability and pricing from primary sources before marketing. Do not inherit the draft comparison table's memory-based claims or imply that every competitor lacks citations/actions. |

Keep each delivery slice reviewable and useful without completing every later feature. The reader, mailboxes, existing search/rules and manual workflows must remain dependable when no model is configured.
