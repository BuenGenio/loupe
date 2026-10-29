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
/// [SearchTranslationTask] is the first consumer: a sentence becomes an
/// expression of the search language, checked by its parser. [BriefTask]
/// reads one message for what it requires of the reader, every item tied to
/// a passage that is really there.
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
export 'src/runner.dart' show AiFailure, AiFailureReason, AiRun, AiRunRecord, AiRunner, AiSuccess, inputHash;
export 'src/task.dart' show AiTask, Parsed, Rejected, TaskParse, TaskSize, parseJsonObject, unfence;
export 'src/tasks/brief.dart'
    show Brief, BriefDue, BriefEvidence, BriefInput, BriefItem, BriefItemKind, BriefOwner, BriefTask, DueKind;
export 'src/tasks/search_translation.dart' show SearchTranslation, SearchTranslationTask;
