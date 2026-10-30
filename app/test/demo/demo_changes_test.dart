import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:loupe/features/conversation/changes/email_diff.dart';
import 'package:loupe/features/conversation/changes/what_changed.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);
  final seed = DemoSeed.build(now);
  final story = seed.messages.where((m) => m.summary.threadId == DemoPrivateAi.threadId('harbour')).toList()
    ..sort((a, b) => a.summary.receivedAt.compareTo(b.summary.receivedAt));

  EmailContent content(DemoMessage m) => EmailContent(
    emailId: m.summary.id,
    text: m.text,
    html: m.html,
    attachments: [for (final a in m.attachments) a.attachment],
  );

  Future<AiRun<ChangeExplanation>> explain(DemoMessage from, DemoMessage to) {
    final diff = compareEmailContent(content(from), content(to));
    return AiRunner(DemoAiProvider(now: () => now)).run(explainChangesTask(diff, from: from.summary, to: to.summary));
  }

  Future<ChangeExplanation> explained(DemoMessage from, DemoMessage to) async {
    final run = await explain(from, to);
    if (run is AiFailure<ChangeExplanation>) fail('${from.summary.subject} → ${to.summary.subject}: ${run.message}');
    return (run as AiSuccess<ChangeExplanation>).value;
  }

  test(
    'the revised illustration: three figures changed with both quotes, a new request, the term not listed',
    () async {
      final first = story.first;
      final revised = story.singleWhere((m) => m.text!.contains('revised illustration'));
      final e = await explained(first, revised);

      final changed = {for (final c in e.changes.where((c) => c.kind == ChangeKind.changed)) c.label: c};
      expect(changed.keys, ['Initial rate', 'Arrangement fee', 'Monthly payment']);
      expect(
        (changed['Initial rate']!.before, changed['Initial rate']!.after),
        ('4.29% fixed for 5 years', '4.19% fixed for 5 years'),
      );
      expect((changed['Arrangement fee']!.before, changed['Arrangement fee']!.after), ('£999', '£1,499'));
      expect((changed['Monthly payment']!.before, changed['Monthly payment']!.after), ('£1,408.72', '£1,392.01'));
      for (final c in changed.values) {
        expect(c.beforePassage!.side, ChangeSide.before);
        expect(c.afterPassage!.side, ChangeSide.after);
        expect(c.beforePassage!.quote, startsWith('${c.label}: '));
      }

      final confirm = e.changes.singleWhere((c) => c.kind == ChangeKind.added);
      expect(confirm.afterPassage!.quote, startsWith('Please confirm by'));
      expect(confirm.beforePassage, isNull);
      expect(e.changes.map((c) => c.label), isNot(contains('Term')));

      final gone = e.changes.where((c) => c.kind == ChangeKind.removed).toList();
      expect(gone.map((c) => c.label), containsAll(['ID check', 'SA302 tax calculation', 'Tax year overview']));
      expect(gone.every((c) => c.afterPassage == null), isTrue);
      expect(e.summary, contains('no longer mentioned'));
      expect(e.noChangeInMeaning, isFalse);
    },
  );

  test('never repeats the password, and never calls a missing request cancelled', () async {
    final run = await DemoAiProvider(now: () => now).complete(
      explainChangesTask(
        compareEmailContent(content(story.first), content(story.last)),
        from: story.first.summary,
        to: story.last.summary,
      ).toRequest(),
    );
    expect(run.text, isNot(contains(DemoPrivateAi.password)));
    expect(run.text.toLowerCase(), isNot(contains('cancel')));
    expect(jsonDecode(run.text), isA<Map<String, Object?>>());
  });

  test('the default pair, the adviser’s previous message, passes the parser too', () async {
    final e = await explained(story[2], story[3]);
    expect(e.changes, isNotEmpty);
    expect(e.changes.map((c) => c.kind), isNot(contains(ChangeKind.changed)));
  });

  test('never fails the parser on any pair of messages in a demo conversation', () async {
    final threads = <String, List<DemoMessage>>{};
    for (final m in seed.messages) {
      if (m.summary.threadId case final id?) (threads[id] ??= []).add(m);
    }
    var pairs = 0;
    for (final messages in threads.values) {
      final readable = messages.where((m) => (m.text ?? m.html) != null).toList()
        ..sort((a, b) => a.summary.receivedAt.compareTo(b.summary.receivedAt));
      for (var i = 0; i + 1 < readable.length; i++) {
        for (final (from, to) in [(readable[i], readable[i + 1]), (readable[i + 1], readable[i])]) {
          final diff = compareEmailContent(content(from), content(to));
          if (!diff.body.hasChanges) continue;
          pairs++;
          await explained(from, to);
        }
      }
    }
    expect(pairs, greaterThan(10));
  });
}
