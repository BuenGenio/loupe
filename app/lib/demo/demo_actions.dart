import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../features/actions/brief_actions.dart';
import 'demo_brief.dart';
import 'demo_data.dart';
import 'demo_private_ai.dart';

/// The actions the demo starts with: the Private AI storyline as Sam would
/// have it a few days in, as if Sam had accepted Suggest Actions on each
/// message. Each one comes from the demo's Brief rules run through
/// BriefTask's own parser, so it quotes its message exactly and Suggest
/// Actions finds it tracked.
///
/// - Needs My Action: the ID check (in the Harbour app), the tax year
///   overview for 2025, the affordability form (in progress), confirming the
///   revised product by its date, the solicitor's three requests, the
///   removals deposit by its date.
/// - Settled: the bank statement and the SA302, sent with Sam's reply, then
///   acknowledged when the adviser confirmed she has them.
/// - Waiting on Others: the adviser's promise to send the valuation booking.
///   The lender's booking arrived since; only Sam can say it settles it.
extension DemoActionCases on DemoSeed {
  List<ActionRecord> seedActions() {
    final story = [
      for (final m in messages)
        if (DemoPrivateAi.threadIds.contains(m.summary.threadId)) m,
    ]..sort((a, b) => a.summary.receivedAt.compareTo(b.summary.receivedAt));
    DemoMessage message(bool Function(DemoMessage m) test) => story.firstWhere(test);
    final request = message((m) => m.summary.subject == 'Your mortgage application: what we need next');
    final reply = message((m) => m.summary.from.first == DemoPeople.personal);
    final receipt = message((m) => m.text!.contains('have arrived'));
    final revised = message((m) => m.text!.contains('revised illustration'));
    final solicitor = message((m) => m.summary.from.first == DemoPrivateAi.solicitor);
    final removals = message((m) => m.summary.from.first == DemoPrivateAi.removals);

    final out = <ActionRecord>[];
    var n = 0;

    /// The actions of [m] whose passage contains each of [quotes], in that
    /// state, with a history going through [steps] (state, when).
    void track(DemoMessage m, Map<String, List<(ActionState, DateTime)>> quotes) {
      final (brief, run) = _brief(m);
      final source = MessageRef.of(m.summary);
      final fromMe = m.summary.from.first == DemoPeople.personal;
      for (final MapEntry(key: words, value: steps) in quotes.entries) {
        final item = brief.items.firstWhere((i) => i.evidence.quote.contains(words));
        final suggestion = suggestionFromBriefItem(item, fromMe: fromMe)!;
        final accepted = m.summary.receivedAt.add(const Duration(minutes: 40));
        var record = ActionRecord.suggested(
          id: 'demo-action-${++n}',
          source: source,
          suggestion: suggestion,
          origin: actionOriginOf(run),
          at: accepted,
        );
        for (final (state, at) in steps) {
          record = record.withState(state, at);
        }
        out.add(record);
      }
    }

    DateTime after(DemoMessage m, [int minutes = 5]) => m.summary.receivedAt.add(Duration(minutes: minutes));
    final sent = [(ActionState.sent, reply.summary.receivedAt), (ActionState.acknowledged, after(receipt, 50))];
    track(request, {
      'bank statement': sent,
      'ID check': const [],
      'SA302': sent,
      'tax year overview': const [],
      'affordability form': [(ActionState.inProgress, reply.summary.receivedAt)],
    });
    track(receipt, {'I will send you the valuation booking': const []});
    track(revised, {'Please confirm by': const []});
    track(solicitor, {'Sign and return': const [], 'Pay £300': const [], 'mortgage offer': const []});
    track(removals, {'Amount due': const []});
    return out;
  }

  /// The demo's Brief of [m], parsed by BriefTask, and the run it stands for.
  (Brief, AiRunRecord) _brief(DemoMessage m) {
    final task = BriefTask(
      briefInputOf(m.summary, m.text!, attachments: [for (final a in m.attachments) a.attachment.filename ?? '']),
      now: now,
    );
    final parsed = task.parse(demoBrief(task.toRequest(), now));
    final brief = switch (parsed) {
      Parsed(:final value) => value,
      Rejected(:final reason) => throw StateError('The demo Brief of "${m.summary.subject}" failed: $reason'),
    };
    final at = m.summary.receivedAt.add(const Duration(minutes: 39));
    return (
      brief,
      AiRunRecord(
        taskType: task.type,
        taskVersion: task.version,
        providerId: 'demo',
        model: 'demo',
        inputHash: inputHash(task),
        startedAt: at,
        finishedAt: at,
        attempts: 1,
      ),
    );
  }
}
