import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:mail_ai/mail_ai.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);

  test('reuses a result for the same task on the same provider and records only requests sent', () async {
    final ledger = AiLedger();
    final service = AiService(DemoAiProvider(now: () => now), ledger, now: () => now);
    final first = await service.run(SearchTranslationTask('unread from dana', now: now));
    final second = await service.run(SearchTranslationTask('unread from dana', now: now));
    expect(first, isA<AiSuccess<SearchTranslation>>());
    expect(identical(first, second), isTrue);
    expect(ledger.records, hasLength(1));
    expect(ledger.resultCount, 1);

    await service.run(SearchTranslationTask('unread from dana', now: now), reuse: false);
    expect(ledger.records, hasLength(2));

    ledger.clearResults();
    expect(ledger.resultCount, 0);
    expect(service.cached(SearchTranslationTask('unread from dana', now: now)), isNull);
  });

  test('a run refused before sending is not recorded as usage', () async {
    final ledger = AiLedger();
    final service = AiService(DemoAiProvider(now: () => now), ledger);
    final run = await service.run(SearchTranslationTask('x' * 80000, now: now));
    expect((run as AiFailure).reason, AiFailureReason.tooLarge);
    expect(ledger.records, isEmpty);
  });

  test('the storyline is in the personal inbox, and only its first message has the password', () {
    final seed = DemoSeed.build(now);
    final story = seed.messages.where((m) => DemoPrivateAi.threadIds.contains(m.summary.threadId)).toList();
    expect(story, hasLength(7));
    expect({for (final m in story) m.summary.accountId}, {DemoAccounts.personal});
    final withPassword = story.where((m) => m.text!.contains(DemoPrivateAi.password));
    expect(withPassword.map((m) => m.summary.subject), ['Your mortgage application: what we need next']);
    expect(
      story.expand((m) => m.attachments).map((a) => a.attachment.filename),
      containsAll(['Mortgage illustration.pdf', 'SA302 2024-25.pdf', 'INV-2207.pdf', 'Valuation booking.pdf']),
    );
  });

  test('a feature gets no service when Private AI or the feature is off, or the account keeps mail local', () {
    ProviderContainer container({
      required bool on,
      Set<AiFeature>? features,
      Set<String> local = const {},
      AiProvider? provider,
    }) {
      final c = ProviderContainer(
        overrides: [
          aiProviderProvider.overrideWithValue(on ? provider ?? DemoAiProvider() : null),
          if (features != null) aiFeaturesProvider.overrideWithValue(features),
          aiLocalOnlyAccountsProvider.overrideWithValue(local),
        ],
      );
      addTearDown(c.dispose);
      return c;
    }

    expect(container(on: false).read(aiServiceForProvider((AiFeature.brief, 'personal'))), isNull);
    expect(container(on: true).read(aiServiceForProvider((AiFeature.brief, 'personal'))), isNotNull);
    expect(
      container(on: true, features: {AiFeature.search}).read(aiServiceForProvider((AiFeature.brief, null))),
      isNull,
    );
    // The demo runs on the phone, so a local-only account may still use it.
    expect(
      container(on: true, local: {'personal'}).read(aiServiceForProvider((AiFeature.brief, 'personal'))),
      isNotNull,
    );
    final cloud = container(on: true, local: {'personal'}, provider: _CloudStandIn());
    expect(cloud.read(aiServiceForProvider((AiFeature.brief, 'personal'))), isNull);
    expect(cloud.read(aiServiceForProvider((AiFeature.brief, 'work'))), isNotNull);
  });
}

final class _CloudStandIn implements AiProvider {
  @override
  String get id => 'cloud-stand-in';
  @override
  ProviderLocation get location => ProviderLocation.cloud;
  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(maxInputTokens: 1000, maxOutputTokens: 100);
  @override
  Future<AiCompletion> complete(AiRequest request, {CancelToken? cancel}) async => const AiCompletion('');
}
