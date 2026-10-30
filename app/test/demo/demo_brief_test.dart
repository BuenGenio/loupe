import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:mail_ai/mail_ai.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);
  final seed = DemoSeed.build(now);
  final story = seed.messages.where((m) => DemoPrivateAi.threadIds.contains(m.summary.threadId)).toList();

  BriefInput input(DemoMessage m) => BriefInput(
    subject: m.summary.subject,
    from: '${m.summary.from.first.name} <${m.summary.from.first.email}>',
    date: m.summary.receivedAt,
    text: m.text!,
    attachments: [for (final a in m.attachments) a.attachment.filename ?? ''],
  );

  Future<Brief> brief(DemoMessage m) async {
    final run = await AiRunner(DemoAiProvider(now: () => now)).run(BriefTask(input(m), now: now));
    if (run is AiFailure<Brief>) fail('${m.summary.subject}: ${run.message}');
    return (run as AiSuccess<Brief>).value;
  }

  test('every storyline message gets a Brief that passes the task’s own checks', () async {
    for (final m in story) {
      final b = await brief(m);
      expect(b.summary, isNot(contains(DemoPrivateAi.password)), reason: m.summary.subject);
      for (final item in b.items) {
        expect(item.text, isNot(contains(DemoPrivateAi.password)));
        expect(item.evidence.quote, isNot(contains(DemoPrivateAi.password)));
      }
    }
  });

  test('the adviser’s requests: five things, the app-only check kept, the timing conditional', () async {
    final b = await brief(story.first);
    final mine = b.items.where(
      (i) => i.owner == BriefOwner.me && (i.kind == BriefItemKind.action || i.kind == BriefItemKind.document),
    );
    expect(mine, hasLength(5));
    expect(mine.where((i) => i.channel == 'in the Harbour app').single.text, contains('ID check'));
    expect(mine.where((i) => i.kind == BriefItemKind.document).map((i) => i.text).join(' | '), contains('2024/25'));
    final caseManager = b.items.singleWhere((i) => i.evidence.quote.contains('case manager'));
    expect(caseManager.kind, BriefItemKind.next);
    expect(caseManager.due.kind, DueKind.conditional);
    expect(caseManager.due.date, isNull);
  });

  test('the revised illustration asks for a confirmation by a stated date; the promise is the adviser’s', () async {
    final revised = await brief(story.firstWhere((m) => m.text!.contains('revised illustration')));
    final confirm = revised.items.singleWhere((i) => i.owner == BriefOwner.me);
    expect(confirm.due.kind, DueKind.explicit);
    expect(confirm.due.date, isNotNull);

    final promise = await brief(story.firstWhere((m) => m.text!.contains('I will send you the valuation booking')));
    final next = promise.items.singleWhere((i) => i.kind == BriefItemKind.next);
    expect(next.owner, BriefOwner.them);
    expect(next.due.kind, DueKind.conditional);
  });

  test('“please find attached” and a bank-details warning are not requests', () async {
    final solicitor = await brief(story.firstWhere((m) => m.summary.from.first == DemoPrivateAi.solicitor));
    expect(solicitor.items.map((i) => i.evidence.quote), isNot(anyElement(contains('find our client care letter'))));
    expect(solicitor.items.map((i) => i.evidence.quote), isNot(anyElement(contains('never change'))));
    expect(solicitor.items.where((i) => i.owner == BriefOwner.me), hasLength(3));
  });

  test('never fails the parser on any message of the demo mailbox', () async {
    final provider = DemoAiProvider(now: () => now);
    for (final m in [...seed.messages, ...seed.older.values.expand((l) => l)]) {
      final text = m.text ?? (m.html == null ? null : htmlToPreviewText(m.html!));
      if (text == null || text.trim().isEmpty) continue;
      final task = BriefTask(
        BriefInput(
          subject: m.summary.subject,
          from: m.summary.from.first.email,
          date: m.summary.receivedAt,
          text: text,
        ),
        now: now,
      );
      final run = await AiRunner(provider).run(task);
      expect(
        run,
        isA<AiSuccess<Brief>>(),
        reason: '${m.summary.subject}: ${run is AiFailure<Brief> ? run.message : ''}',
      );
    }
  });
}
