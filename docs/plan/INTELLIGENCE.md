# Loupe intelligence: understanding mail and following it through

Status: product and engineering plan, 2026-10-29. The first working slice, a local literal message Changes view with attachment metadata comparison, is implemented in the working tree. All model providers, semantic comparison, task extraction and other intelligence features below are planned unless stated otherwise.

The aim is to help someone understand what a message requires, see what changed, and keep track until the work is done. The reader, folders, search and rule editor remain the main surfaces. A general chat assistant is optional later, rather than a prerequisite for these features.

## Product decisions

- **Needs my action** and **Waiting on others** are virtual folders in Mailboxes. They have stable destinations, counts and ordinary message-list navigation. They are not temporary quick filters.
- **Changes** brings the useful part of a text diff to a conversation: the previous position, the new position and the passages supporting both.
- A natural-language rule helper builds an ordinary editable Loupe rule, previews its effect and lets the user save it through the existing editor.
- People choose processing on their phone, on their own server, or through a cloud provider. Configuration and permissions are per account; local failures never silently switch to a network provider.
- Features must explain their evidence and uncertainty. Reading a message, replying, sending a document and having that document acknowledged are different events.

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

## 2. Living case files

A case groups related conversations, documents, requests and updates even when their subjects and senders differ. Examples include a mortgage application, an insurance claim or arranging repairs.

The case screen shows the latest supported position, open actions, what is waiting on another person, relevant documents and a chronological history. Users can create, rename, merge and split cases and correct membership. Suggested grouping must be reversible; sharing a sender or subject is not sufficient evidence that two cases are the same.

Start with manual case membership and suggested candidates. Add model-assisted grouping only after identity, evidence and corrections work. Case state is separate from the physical mail folder, so filing a message does not remove it from the case.

## 3. Obligations as virtual folders

Use the existing distinction in `mail_model/src/mailbox.dart`:

| Existing concept | Purpose | Intelligence integration |
|---|---|---|
| `VirtualMailbox` | Built-in aggregate destinations such as Unread and All Sent | Add dedicated action destinations and repository queries |
| `QuickFilter` | Temporary narrowing of the current message list | Keep available inside action folders; do not use it to store obligations |
| `SmartMailbox` | A user-defined saved `SearchExpr` query | Can later query supported action properties, but is not the action database |

The virtual folder is computed from durable obligation records, not by running a model each time it opens. One message can appear in both folders if it contains commitments in both directions. Counts must state whether they count conversations, messages or actions; use conversation counts in the folder list and action counts inside each conversation.

Each action needs an independent identity, owner, source, original request, current request, channel, due condition and state. Proposed states are **Needs action**, **In progress**, **Sent**, **Waiting for acknowledgement**, **Acknowledged**, **Done**, **Dismissed** and **Superseded**. Not every action uses every state.

- “Please send the statement” belongs in Needs my action.
- “I will send the revised offer tomorrow” belongs in Waiting on others.
- A sent reply can support “Sent”; it cannot prove the recipient accepted the attachment.
- An external form or ID check can be completed manually. Absence of an email reply is not proof it remains incomplete.
- A vague reply such as “Thanks” must not silently complete every action in a conversation.
- A new request for a different period or document creates or revises the relevant action; it must not revive all completed items.
- Snooze, dismiss and manual completion belong to the action, with visible undo.

Store actions in a dedicated table. Keep extracted suggestions separate from user overrides, so re-extraction, a model change or a new message cannot erase a correction or reopen a manually completed task. Changes to the underlying request should appear as reviewable updates.

## 4. Find the document itself

Search the text of downloaded attachments, then add OCR for scans and photographed documents. Results show the document, message, page and matching passage. Natural-language retrieval may rank results, but opening a result must show why it matched.

Begin with bounded PDF/text extraction and exact search. Record extraction failures, password protection and unindexed pages. Never claim to have searched the whole account when only downloaded content is indexed. Encrypted content can be indexed only after normal decryption permission and under the same cache policy.

Keep document identity separate from filename. A replacement `illustration.pdf` may contain different terms; two differently named files may contain the same bytes. Use content hashes when bytes are available, with explicit “not downloaded” status otherwise.

Semantic embeddings can later support “the statement I sent to the broker” or “the illustration with a lower arrangement fee”. They do not establish the authenticity or correctness of a document. Local extraction and ranking should remain useful without a generative model.

## 5. Reply readiness

Compare the source requests with the current draft and selected attachments. Show a compact, dismissible review near the attachments: included, possibly wrong period, missing, or requires an external step.

The check must inspect actual selected files when it makes a document-content claim. A filename alone can support only a tentative match. A tax calculation for a different year must not pass because its filename contains the right keyword. Unreadable or protected attachments remain unknown.

Start with ordinary attachment reminders and user-selected request lists. Add extraction-driven suggestions after Brief and action records pass evaluation. Sending remains the user's decision; this feature neither blocks sending on a model guess nor attaches or emails private documents automatically.

## 6. Changes: a diff for email

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

## 7. Natural-language rules

Example intent: “Keep this company's newsletters quiet, but still notify me about invoices.” Convert supported parts into a typed `Rule` and `SearchExpr`, then open the existing `RuleEditorScreen` with an explanation and preview.

The preview shows the exact account and mailbox scope, representative matching and non-matching messages, proposed actions, and whether the rule runs on the device or server. Unsupported conditions or actions stay unresolved and cannot be silently approximated.

The current `RuleAction` contract includes move, tags, flag, read, junk, keep-in-inbox and forward. It has no notification-only action. The newsletter example therefore needs an explicit notification-policy design before its full intent can be saved. Marking messages read or moving them is not an acceptable substitute for “quiet”.

Likewise, “invoice” is not currently a guaranteed semantic predicate. A deterministic subject/body keyword expression must be described as such. Offer the user explicit wording or conditions to choose; do not pretend a keyword rule identifies every invoice. A future semantic classifier requires its own saved version, evaluation and execution policy.

The model proposes a typed rule only. Parse and validate expressions with `expr_search`, resolve folders/tags against the selected account, reject unknown actions, and preview using the same evaluator that will execute the saved rule. Existing deterministic Sieve compilation can follow the normal server-rule flow after user review.

Never accept model-generated Sieve as executable output and never install a generated rule automatically. A suggestion to forward, delete or mark messages read must be as visible in the editor and preview as any other action.

## Shared architecture

### Evidence and identity

Introduce plain contracts in `mail_model` for Brief facts, evidence references, obligations, case membership, comparison checkpoints and provider capabilities. Keep inference and extraction implementations behind interfaces so the app and demo repository can exercise them without loading a model.

Evidence needs the account, logical message identity, current local location, body/attachment content hash, normalisation version and passage/page location. Preserve enough context to relocate a passage; normalised text offsets alone are fragile after parser changes.

Current `MailIds` are location-dependent: IMAP IDs include mailbox path, UIDVALIDITY and UID, and JMAP has a local copy per mailbox. Moving mail can change local IDs. Add an explicit logical identity/reconciliation layer before durable actions or review checkpoints depend on an email ID. Use provider stable identity where available, move mappings where known, and guarded RFC Message-ID/content matching where necessary. A Message-ID alone is neither unique nor always present.

Extraction runs should record input hashes, prompt/schema/model versions, provider and date. Reuse valid results, invalidate changed inputs, and preserve manual overrides. Distinguish no requests found, not analysed, partially analysed and failed.

### Storage and sync

- Briefs, extracted text, embeddings, document thumbnails and inference caches are sensitive derived mail data. Keep them device-local by default, under the existing protected storage design, with bounded retention and a clear delete/rebuild action.
- Do not put extracted content or model output into the Smart Mailbox settings document.
- Add separate versioned tables/documents for action and case state. If state sync is offered later, make it opt-in and minimise it to identities, manual states, timestamps and required conflict-resolution data.
- Inspect what that minimal state reveals before choosing a mail-server document format; titles and task descriptions can themselves expose sensitive content.
- Existing server settings documents have provider limits. Gmail is unsupported by the current document mechanism; keep state local unless a separate supported route is designed. See [Smart Mailboxes format](../smart-mailboxes-format.md).
- Reconcile edits deterministically, preserve manual completion/dismissal, and retain deletion tombstones long enough to prevent ordinary offline devices restoring removed items.
- Removing an account must remove its derived data. Revoking a provider stops new requests and offers deletion of its local results without deleting original mail.

### Processing and permissions

Mail bodies, attachments, OCR text, links and quoted instructions are untrusted source data. They cannot change model instructions, enable providers, call mail actions, fetch arbitrary URLs or request extra messages. Expose extraction and proposal tools rather than live send/move/delete tools to the model.

The app prepares a bounded input, validates a typed result, checks evidence, then renders or previews it. Models do not receive account credentials, unrestricted repository access or provider keys. Do not fetch linked pages while producing an email brief; links can be represented as source links without opening them.

Provider policy is per account, with distinct **On this phone**, **My server** and **Cloud** choices. Add credentials through the existing secure credential store. Configuration records the endpoint, provider/model, permitted task types, body/attachment scope and any automatic processing consent. Self-hosted processing is network processing and must be labelled accordingly.

Show which provider produced a result and what content a network request will include. Local-only and encrypted-mail restrictions take precedence over generic provider defaults. A timeout, unsupported language or failed validation offers retry/another explicitly permitted provider; it never silently uploads mail. Avoid request bodies, credentials and generated sensitive text in logs or crash reports.

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

| Milestone | Deliverable | Exit condition |
|---|---|---|
| A: local Changes, implemented in working tree | Literal message comparison, attachment metadata differences, reader entry point | Clear source selection; meaningful diff and empty states; unavailable data handled; no model/network inference |
| B: evidence and provider spike | Typed contracts, bounded canonical text, fake provider, local model trial, per-account policy | No silent network path; evidence validation; cancellation; device report and email evaluation results |
| C: Brief | Single-message supported summary and requests, source navigation | Mortgage and adversarial fixtures pass; original remains accessible; unknown/failed states explicit |
| D: action virtual folders | Dedicated obligation tables, manual actions, stable identity reconciliation, folder counts | Manual overrides survive moves, re-extraction, reconnect and restart; sent differs from acknowledged |
| E: rule helper | Typed proposal, capability checks, existing editor and deterministic preview | Saved rule matches preview; unsupported invoice/notification intent remains unresolved; no direct Sieve generation |
| F: semantic Changes and checkpoints | Source-backed changed facts, explicit review checkpoint, document-version extraction | No false cancellations; conflicting statements visible; read/unread changes do not advance review |
| G: documents and reply readiness | Bounded indexing/OCR, cited retrieval, request/attachment check | Partial index coverage visible; wrong-year files flagged; unavailable contents remain unknown |
| H: case files and optional state sync | Manual grouping first, suggestions later, versioned minimal state | Correctable membership, account isolation, conflict tests, Gmail limitation and opt-in state exposure explained |

A is the first working slice; it does not include the model-backed roadmap. B and C establish quality before automatic extraction feeds D. E can reuse a fake/provider abstraction in parallel, but only supported deterministic actions can ship. F–H depend on durable identity and the earlier evidence contracts.

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
| Move, duplicate Message-ID, multi-label copies, UIDVALIDITY reset | Actions/cases/checkpoints retain the correct logical source without attaching to an unrelated message |
| Mark unread after reviewing / automatic mark read | Review checkpoint does not move as a side effect of either flag change |
| Rule requesting invoice-only alerts | Unsupported notification action and semantic predicate are surfaced; no substitute action silently saved |
| Unsupported rule fields, invalid folder, unknown action | Reject before preview/save; deterministic validation remains the authority |
| Hostile mail asking the assistant to forward secrets or enable cloud | Treat as source text; no execution, provider change or extra data fetch |
| Local failure while cloud is unconfigured or prohibited | Remain local, show failure/retry; zero cloud request |
| Protected/large attachment, missing body, partial index | Show bounded, partial or unavailable state; do not render a complete-result claim |
| Multilingual mail, mixed languages, RTL, locale dates | Evaluate extraction and display separately; preserve source ambiguity and unsupported-language status |
| Manual complete/dismiss then model upgrade/re-extraction | Preserve overrides and expose genuinely changed requests for review |

Track request precision/recall, unsupported factual additions, source-link correctness, condition preservation, wrong-document matches and rule-preview equivalence separately. A pleasant summary cannot compensate for a missed app-only requirement or invented deadline. Establish and publish acceptance thresholds on a held-out synthetic/anonymised corpus before selecting a shipping model; run the same task fixtures for local, self-hosted and cloud providers.

Measure cold and warm performance on the actual S23 Ultra and at least one constrained Android tier before recommending local support. Test offline, memory pressure, cancellation, background restrictions, account removal and cache deletion. Keep first-slice deterministic diff tests separate from model evaluation; passing them proves comparison behaviour, not semantic reliability.
