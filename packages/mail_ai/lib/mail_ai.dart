/// Private AI for Loupe (docs/plan/PLAN-combined.md, "Shared architecture").
///
/// A feature describes what it wants as an [AiTask]: instructions, a bounded
/// input, an output schema and a parser that turns the model's text into a
/// typed value or rejects it. An [AiRunner] sends the task to one
/// [AiProvider], validates the answer, allows one repair attempt with the
/// rejection fed back, and then fails cleanly. Models only ever return data;
/// nothing here moves, sends or deletes mail, and nothing is uploaded unless
/// the chosen provider is a network one.
///
/// [FakeProvider] runs tasks without a model, for tests and the demo.
/// [AnthropicProvider] and [OpenAiCompatibleProvider] are the network
/// adapters: a cloud the user chose, or a server they run.
/// [SearchTranslationTask] is the first consumer: a sentence becomes an
/// expression of the search language, checked by its parser. [BriefTask]
/// reads one message for what it requires of the reader, every item tied to
/// a passage that is really there. [ChangeExplanationTask] explains what
/// changed between two messages of a conversation, each change tied to both
/// passages, with the literal line diff as its evidence. [RuleProposalTask]
/// turns a sentence into a typed rule draft for the rule editor, with what
/// rules can't do left visibly unresolved. [MatterStatusTask] says where a matter
/// stands from its latest messages, each statement quoting one of them.
library;

export 'src/fake_provider.dart' show FakeProvider;
export 'src/provider.dart'
    show
        AiCancelled,
        AiCompletion,
        AiProvider,
        AiProviderException,
        AiRequest,
        CancelToken,
        ProviderCapabilities,
        ProviderLocation;
export 'src/providers/anthropic_provider.dart' show AnthropicProvider;
export 'src/providers/openai_compatible_provider.dart' show OpenAiCompatibleProvider;
export 'src/runner.dart' show AiFailure, AiFailureReason, AiRun, AiRunRecord, AiRunner, AiSuccess, inputHash;
export 'src/task.dart' show AiTask, Parsed, Rejected, TaskParse, TaskSize, parseJsonObject, unfence;
export 'src/tasks/brief.dart'
    show Brief, BriefDue, BriefEvidence, BriefInput, BriefItem, BriefItemKind, BriefOwner, BriefTask, DueKind;
export 'src/tasks/change_explanation.dart'
    show ChangeExplanation, ChangeExplanationTask, ChangeKind, ChangePassage, ChangeSide, ChangeSource, ExplainedChange;
export 'src/tasks/rule_proposal.dart' show RuleProposal, RuleProposalTask, UnsupportedRulePart, UnsupportedRuleReason;
export 'src/tasks/matter_status.dart' show MatterStatus, MatterStatusMessage, MatterStatusStatement, MatterStatusTask;
export 'src/tasks/search_translation.dart' show SearchTranslation, SearchTranslationTask;
