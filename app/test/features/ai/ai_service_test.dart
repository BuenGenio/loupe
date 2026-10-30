import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/ai/ai_settings.dart';
import 'package:loupe/features/ai/ai_usage.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  test('closing the service cancels the run in flight, and a closed one sends nothing', () async {
    final ledger = AiLedger();
    final provider = FakeProvider(answers: ['{"expression":"from:dana","interpretation":"","questions":[]}'])
      ..delay = const Duration(milliseconds: 20);
    final service = AiService(provider, ledger, now: () => now);
    final first = service.run(SearchTranslationTask('unread from dana', now: now));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    service.close();
    final run = await first;
    expect((run as AiFailure).reason, AiFailureReason.cancelled);
    // The request had gone out, so it counts; its answer is dropped.
    expect(ledger.records.single.attempts, 1);
    expect(ledger.resultCount, 0);

    final later = await service.run(SearchTranslationTask('flagged mail', now: now));
    expect((later as AiFailure).reason, AiFailureReason.cancelled);
    expect(provider.requests, hasLength(1));
    expect(ledger.records, hasLength(1));
  });

  test('the ledger keeps run records across restarts, the last thousand, never what was asked', () async {
    final old = AiRunRecord(
      taskType: 'brief.message',
      taskVersion: 1,
      providerId: 'anthropic:claude-sonnet-5-5',
      inputHash: 'h',
      startedAt: now.subtract(const Duration(days: 40)),
      finishedAt: now.subtract(const Duration(days: 40)),
      attempts: 1,
    );
    SharedPreferences.setMockInitialValues({
      AiLedger.recordsKey: [for (var i = 0; i < AiLedger.maxRecords; i++) encodeRunRecord(old)],
    });
    final prefs = await SharedPreferences.getInstance();
    final ledger = AiLedger(prefs: prefs);
    expect(ledger.records, hasLength(AiLedger.maxRecords));
    // Missing token counts stay missing, never 0.
    expect(ledger.records.first.inputTokens, isNull);

    final service = AiService(DemoAiProvider(now: () => now), ledger, now: () => now);
    await service.run(SearchTranslationTask('unread from dana', now: now));
    final stored = prefs.getStringList(AiLedger.recordsKey)!;
    expect(stored, hasLength(AiLedger.maxRecords));
    expect(stored.last, isNot(contains('dana')));
    expect(stored.last, isNot(contains(inputHash(SearchTranslationTask('unread from dana', now: now)))));

    final again = AiLedger(prefs: prefs);
    expect(again.records.last.providerId, 'demo');
    expect(again.records.last.taskType, 'search.translate');
    expect(again.records.last.startedAt, now);
    // Results are derived mail data: in memory only.
    expect(again.resultCount, 0);
    expect(ledger.resultCount, 1);
  });

  group('the configured provider', () {
    Future<ProviderContainer> container(
      Map<String, Object> prefs, {
      Map<String, String> keys = const {},
      http.Client? client,
    }) async {
      SharedPreferences.setMockInitialValues(prefs);
      final store = MemoryCredentialStore();
      for (final MapEntry(:key, :value) in keys.entries) {
        await store.write(key, PasswordCredentials(value));
      }
      final c = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),
          aiCredentialStoreProvider.overrideWithValue(store),
          if (client != null) aiHttpClientProvider.overrideWithValue(client),
        ],
      );
      addTearDown(c.dispose);
      // Keys are read from the store once, before a network provider exists.
      await c.read(aiKeysProvider.future);
      return c;
    }

    test('is none while Private AI is off, and the demo once it is on', () async {
      expect((await container({})).read(aiProviderProvider), isNull);
      expect((await container({'settings.aiAssist': true})).read(aiProviderProvider), isA<DemoAiProvider>());
    });

    test('is Anthropic with the key from the credential store, sent only in its header', () async {
      late http.Request sent;
      final client = MockClient((request) async {
        sent = request;
        return http.Response(
          jsonEncode({
            'model': 'claude-sonnet-5-5',
            'content': [
              {'type': 'text', 'text': '{"expression":"is:unread","interpretation":"Unread","questions":[]}'},
            ],
            'stop_reason': 'end_turn',
            'usage': {'input_tokens': 410, 'output_tokens': 25},
          }),
          200,
        );
      });
      final c = await container(
        {'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'},
        keys: {AiKeys.credentialId(AiProviderKind.anthropic): 'sk-ant-test'},
        client: client,
      );
      final provider = c.read(aiProviderProvider)!;
      expect(provider, isA<AnthropicProvider>());
      expect(provider.id, 'anthropic:claude-sonnet-5-5');
      expect(provider.location, ProviderLocation.cloud);

      final run = await c.read(aiServiceProvider)!.run(SearchTranslationTask('unread mail', now: now));
      expect(run, isA<AiSuccess<SearchTranslation>>());
      expect(sent.headers['x-api-key'], 'sk-ant-test');
      expect(sent.body, isNot(contains('sk-ant-test')));
      final record = c.read(aiLedgerProvider).records.single;
      expect((record.model, record.inputTokens, record.outputTokens), ('claude-sonnet-5-5', 410, 25));
    });

    test('is none, not another provider, while the one picked is not set up', () async {
      // Anthropic without a key.
      expect(
        (await container({'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'}))
            .read(aiProviderProvider),
        isNull,
      );
      // A server without its model, then with it.
      final server = {
        'settings.aiAssist': true,
        AiConfigController.kindKey: 'myServer',
        AiConfigController.serverUrlKey: 'http://pi.local:11434/v1',
      };
      expect((await container(server)).read(aiProviderProvider), isNull);
      final ready = (await container({...server, AiConfigController.serverModelKey: 'llama3.2'}))
          .read(aiProviderProvider);
      expect(ready, isA<OpenAiCompatibleProvider>());
      expect(ready!.location, ProviderLocation.myServer);
      // The phone's own model isn't there yet.
      expect(
        (await container({'settings.aiAssist': true, AiConfigController.kindKey: 'onThisPhone'}))
            .read(aiProviderProvider),
        isNull,
      );
    });

    test('removing the key stops the provider and closes its service', () async {
      final c = await container(
        {'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'},
        keys: {AiKeys.credentialId(AiProviderKind.anthropic): 'sk-ant-test'},
      );
      final service = c.read(aiServiceProvider)!;
      await c.read(aiKeysProvider.notifier).remove(AiProviderKind.anthropic);
      expect(c.read(aiProviderProvider), isNull);
      expect(c.read(aiServiceProvider), isNull);
      expect(c.read(aiConfigProvider).kind, AiProviderKind.anthropic);
      final run = await service.run(SearchTranslationTask('unread mail', now: now));
      expect((run as AiFailure).reason, AiFailureReason.cancelled);
      expect(await c.read(aiCredentialStoreProvider).read(AiKeys.credentialId(AiProviderKind.anthropic)), isNull);
    });
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
