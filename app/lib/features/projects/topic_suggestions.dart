import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import 'project_settings.dart';
import 'projects_state.dart';
import 'topic_ai.dart';

/// The suggested projects, and how the AI pass went.
@immutable
final class TopicState {
  const TopicState({this.suggestions = const [], this.thinking = false, this.aiError});

  final List<TopicSuggestion> suggestions;

  /// The AI server is being asked.
  final bool thinking;

  /// Why the last AI pass failed; the suggestions are the device's own then.
  final TopicAiException? aiError;
}

/// Suggestions for the Tiles view, found on this device in the conversations
/// of the last [window] (see `suggestTopics`), and named and grouped by the AI
/// server when one is set up (Settings › Projects). Found again after mail
/// syncs and when projects change; the AI is asked at most every [aiInterval].
final topicSuggestionsProvider = NotifierProvider<TopicSuggestions, TopicState>(TopicSuggestions.new);

class TopicSuggestions extends Notifier<TopicState> {
  static const window = Duration(days: 90);
  static const aiInterval = Duration(hours: 1);
  static const maxAiThreads = 120;
  static const limit = 6;

  Timer? _timer;
  int _run = 0;

  /// The AI's last answer, kept across rounds: when, for which settings.
  List<AiTopic> _aiTopics = const [];
  DateTime? _aiAt;
  Object? _aiFor;

  @override
  TopicState build() {
    final settings = ref.watch(projectSettingsProvider);
    ref.watch(projectsProvider);
    ref.watch(dismissedTopicsProvider);
    ref.onDispose(() => _timer?.cancel());
    if (!settings.suggest) return const TopicState();
    String syncs(AsyncValue<List<AccountSyncStatus>> s) => [
      for (final x in s.value ?? const <AccountSyncStatus>[]) '${x.accountId}@${x.lastSuccess?.millisecondsSinceEpoch}',
    ].join(',');
    ref.listen(syncStatusProvider.select(syncs), (_, _) => _schedule(const Duration(seconds: 5)));
    _schedule(Duration.zero);
    return stateOrNull ?? const TopicState();
  }

  /// Finds them again now, asking the AI again too.
  Future<void> refresh() {
    _aiAt = null;
    return _compute();
  }

  void _schedule(Duration delay) {
    _timer?.cancel();
    _timer = Timer(delay, () => unawaited(_compute()));
  }

  Future<void> _compute() async {
    final run = ++_run;
    final settings = ref.read(projectSettingsProvider);
    if (!settings.suggest) return;
    final repo = ref.read(repositoryProvider);
    final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
    final mine = {
      for (final a in accounts) ...[a.email.toLowerCase(), for (final i in a.identities) i.email.toLowerCase()],
    };
    final dismissed = ref.read(dismissedTopicsProvider);
    final names = {for (final p in ref.read(projectsProvider)) p.name};
    final List<EmailSummary> emails;
    try {
      final since = clock.now().subtract(window);
      final results = await repo
          .search(
            SearchRequest(
              expr: DateTerm(DateComparison.onOrAfter, since),
              scope: const AllMailboxesScope(),
              includeServer: false,
              limit: 3000,
            ),
          )
          .first;
      emails = results.items;
    } on Object catch (e) {
      debugPrint('Topic suggestions failed: $e');
      return;
    }
    if (!ref.mounted || run != _run) return;
    final threads = topicThreads(emails, myAddresses: mine);
    final found = suggestTopics(threads, myAddresses: mine, dismissed: dismissed, projectNames: names, limit: limit);
    final ai = settings.aiReady;
    final aiFor = (settings.aiServer, settings.aiModel);
    final fresh = _aiAt != null && _aiFor == aiFor && clock.now().difference(_aiAt!) < aiInterval;
    state = TopicState(
      suggestions: _merge(fresh ? _aiTopics : const [], found, dismissed, names),
      thinking: ai && !fresh,
    );
    if (!ai || fresh) return;

    final open = [
      for (final t in threads)
        if (t.tookPart && t.projectIds.isEmpty) t,
    ]..sort((a, b) => b.last.compareTo(a.last));
    try {
      final key = await ref.read(projectSecretsProvider).read(projectAiKeySecret);
      final topics = await TopicAi(
        server: settings.aiServer,
        model: settings.aiModel,
        apiKey: key,
      ).group(open.take(maxAiThreads).toList());
      if (!ref.mounted || run != _run) return;
      _aiTopics = topics;
      _aiAt = clock.now();
      _aiFor = aiFor;
      state = TopicState(suggestions: _merge(topics, found, dismissed, names));
    } on TopicAiException catch (e) {
      if (!ref.mounted || run != _run) return;
      state = TopicState(suggestions: found, aiError: e);
    }
  }

  /// The AI's topics first (those still open and not dismissed), then the
  /// device's own that don't repeat them.
  static List<TopicSuggestion> _merge(
    List<AiTopic> ai,
    List<TopicSuggestion> found,
    Set<String> dismissed,
    Set<String> names,
  ) {
    final lower = {for (final n in names) n.toLowerCase()};
    final out = <TopicSuggestion>[
      for (final t in ai)
        if (!dismissed.contains(aiKey(t.name)) && !lower.contains(t.name.toLowerCase()))
          TopicSuggestion(key: aiKey(t.name), label: t.name, kind: TopicKind.named, threads: t.threads),
    ];
    for (final s in found) {
      if (out.length >= limit) break;
      final keys = {for (final t in s.threads) t.key};
      final repeats = out.any((o) => o.threads.where((t) => keys.contains(t.key)).length >= keys.length * 0.6);
      if (!repeats) out.add(s);
    }
    return out.take(limit).toList();
  }

  static String aiKey(String name) => 'ai:${name.trim().toLowerCase()}';
}

/// Make Project on a suggestion: the project, its conversations (all their
/// messages) in it, and, when the suggestion has a search, a rule that adds
/// its future mail. Returns the project.
Future<Project> makeProjectFrom(MailRepository repo, ProjectsNotifier projects, TopicSuggestion s) async {
  final project = await projects.add(s.label);
  final ids = <String>{};
  for (final t in s.threads) {
    for (final e in await repo.watchConversation(t.latest.id).first) {
      ids.add(e.id);
    }
  }
  if (ids.isNotEmpty) await repo.setKeywords(ids.toList(), add: {project.keyword});
  if (s.query.isNotEmpty) {
    try {
      await repo.rules.saveRule(
        Rule(
          id: 'project-${project.id}',
          name: project.name,
          condition: s.query,
          actions: [AddTagAction(project.keyword)],
        ),
      );
    } on Object catch (e) {
      // The project stands without its rule; one can be added in its editor.
      debugPrint('Project rule not saved: $e');
    }
  }
  return project;
}
