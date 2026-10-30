import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/ai/ai_settings.dart';
import 'package:loupe/features/ai/ai_usage.dart';
import 'package:mail_ai/mail_ai.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);

  AiRunRecord record(
    String providerId, {
    String? model,
    int? input,
    int? output,
    int attempts = 1,
    Duration ago = const Duration(hours: 1),
  }) => AiRunRecord(
    taskType: 'brief.message',
    taskVersion: 1,
    providerId: providerId,
    inputHash: 'h',
    startedAt: now.subtract(ago),
    finishedAt: now.subtract(ago),
    attempts: attempts,
    model: model,
    inputTokens: input,
    outputTokens: output,
  );

  test('groups requests by provider and model, for today, this month or all of them', () {
    final records = [
      record('anthropic:claude-sonnet-5-5', model: 'claude-sonnet-5-5', input: 1000, output: 200),
      // A repair attempt is a second request.
      record('anthropic:claude-sonnet-5-5', model: 'claude-sonnet-5-5', input: 3000, output: 600, attempts: 2),
      record('demo', model: 'demo', ago: const Duration(days: 3)),
      record('pi.local:llama3.2', model: 'llama3.2', input: 50, output: 5, ago: const Duration(days: 60)),
    ];
    final today = usageIn(records, AiUsagePeriod.today, now: now);
    expect(today, hasLength(1));
    expect((today.single.requests, today.single.inputTokens, today.single.outputTokens), (3, 4000, 800));

    expect(usageIn(records, AiUsagePeriod.thisMonth, now: now).map((u) => u.providerId), [
      'anthropic:claude-sonnet-5-5',
      'demo',
    ]);
    expect(usageIn(records, AiUsagePeriod.all, now: now), hasLength(3));
  });

  test('an estimate from list prices; the demo costs nothing; an unpriced model is unknown', () {
    final [sonnet] = usageIn(
      [record('anthropic:claude-sonnet-5-5', model: 'claude-sonnet-5-5', input: 1000000, output: 100000)],
      AiUsagePeriod.all,
      now: now,
    );
    final cost = sonnet.cost as AiEstimatedCost;
    expect(cost.dollars, closeTo(2 + 1, 1e-9));
    expect(cost.atLeast, isFalse);

    // A dated snapshot has its model's price.
    expect(AiPrices.of('anthropic:claude-haiku-5-5', 'claude-haiku-5-5-20261001')?.input, 0.10);
    expect(AiPrices.of('anthropic:claude-opus-5-5', null)?.output, 20);
    // The same name served elsewhere costs what that server charges: unknown.
    expect(AiPrices.of('proxy.example:claude-sonnet-5-5', 'claude-sonnet-5-5'), isNull);

    expect(usageIn([record('demo', model: 'demo')], AiUsagePeriod.all, now: now).single.cost, isA<AiNoCost>());
    final [server] = usageIn(
      [record('pi.local:llama3.2', model: 'llama3.2', input: 50, output: 5)],
      AiUsagePeriod.all,
      now: now,
    );
    expect(server.cost, isA<AiUnknownCost>());
  });

  test('missing token counts are unknown, never zero, and make a cost "at least"', () {
    final [nothing] = usageIn(
      [record('anthropic:claude-opus-5-5', model: 'claude-opus-5-5')],
      AiUsagePeriod.all,
      now: now,
    );
    expect(nothing.anyReported, isFalse);
    expect(nothing.cost, isA<AiUnknownCost>());

    final [partly] = usageIn(
      [
        record('anthropic:claude-opus-5-5', model: 'claude-opus-5-5', input: 1000000, output: 0),
        record('anthropic:claude-opus-5-5', model: 'claude-opus-5-5', input: 500),
      ],
      AiUsagePeriod.all,
      now: now,
    );
    expect(partly.unreportedRequests, 1);
    final cost = partly.cost as AiEstimatedCost;
    expect(cost.atLeast, isTrue);
    // The half-reported request's 500 tokens are counted; nothing is made up.
    expect(cost.dollars, closeTo(4 * 1000500 / 1000000, 1e-9));
  });

  test('a total is at least the estimates when part of it is unknown', () {
    final usage = usageIn(
      [
        record('anthropic:claude-sonnet-5-5', model: 'claude-sonnet-5-5', input: 1000000, output: 0),
        record('pi.local:llama3.2', model: 'llama3.2', input: 50, output: 5),
        record('demo', model: 'demo'),
      ],
      AiUsagePeriod.all,
      now: now,
    );
    final total = totalCost(usage) as AiEstimatedCost;
    expect((total.dollars, total.atLeast), (2.0, true));
    expect(totalCost(usageIn([record('demo')], AiUsagePeriod.all, now: now)), isA<AiNoCost>());
    expect(totalCost(usageIn([record('x:y')], AiUsagePeriod.all, now: now)), isA<AiUnknownCost>());
  });

  test('a kept record holds no input hash, and unknown counts stay unknown', () {
    final kept = decodeRunRecord(encodeRunRecord(record('demo', model: 'demo', input: 12)))!;
    expect(encodeRunRecord(record('demo')), isNot(contains('"h"')));
    expect(kept.inputHash, isEmpty);
    expect((kept.providerId, kept.model, kept.inputTokens, kept.outputTokens), ('demo', 'demo', 12, null));
    expect(kept.startedAt, now.subtract(const Duration(hours: 1)));
    expect(decodeRunRecord('not json'), isNull);
    expect(decodeRunRecord('{"task":"x"}'), isNull);
  });

  test('a provider id belongs to the kind that made it', () {
    expect(AiProviderKind.of('demo'), AiProviderKind.demo);
    expect(AiProviderKind.of('anthropic:claude-opus-5-5'), AiProviderKind.anthropic);
    expect(AiProviderKind.of('pi.local:llama3.2'), AiProviderKind.myServer);
  });
}
