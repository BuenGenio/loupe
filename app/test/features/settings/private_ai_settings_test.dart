import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:loupe/features/ai/ai_settings.dart';
import 'package:loupe/features/ai/ai_usage.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

ProviderContainer _container(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

/// Scrolls the page to [finder] and taps it.
Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.scrollTo(finder);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

bool _switchOf(WidgetTester tester, Finder row) =>
    tester.widget<CupertinoSwitch>(find.descendant(of: row, matching: find.byType(CupertinoSwitch))).value;

/// Anthropic's Messages API answering one search translation.
MockClient _anthropic({void Function(http.Request request)? onRequest, Map<String, Object>? usage}) =>
    MockClient((request) async {
      onRequest?.call(request);
      return http.Response(
        jsonEncode({
          'model': 'claude-sonnet-5-5',
          'content': [
            {'type': 'text', 'text': '{"expression":"is:unread newer_than:7d","interpretation":"x","questions":[]}'},
          ],
          'stop_reason': 'end_turn',
          'usage': usage ?? {'input_tokens': 380, 'output_tokens': 22},
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

void main() {
  testWidgets('Settings › Private AI: the switch is off at first, and on means the built-in demo', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, Routes.settings);
    final row = find.byKey(const Key('private-ai'));
    await tester.scrollTo(row);
    expect(find.descendant(of: row, matching: find.text('Off')), findsOneWidget);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(find.text('Provider'.toUpperCase()), findsNothing);
    await tester.tap(find.byKey(const Key('ai-assist')));
    await tester.pumpAndSettle();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('settings.aiAssist'), isTrue);
    expect(find.text('Provider'.toUpperCase()), findsOneWidget);
    expect(_container(tester).read(aiProviderProvider)?.id, 'demo');

    // On This Phone is listed, and can't be picked yet.
    await _tap(tester, find.byKey(const Key('ai-provider-onThisPhone')));
    expect(_container(tester).read(aiConfigProvider).kind, AiProviderKind.demo);

    await systemBack(tester);
    expect(
      find.descendant(of: find.byKey(const Key('private-ai')), matching: find.text('Built-in Demo')),
      findsOneWidget,
    );
  });

  testWidgets('feature and account switches persist, and a local-only account gets no network model', (tester) async {
    // An Anthropic key is there, for the second launch to use.
    final store = MemoryCredentialStore();
    await store.write(AiKeys.credentialId(AiProviderKind.anthropic), const PasswordCredentials('sk-ant-test'));
    await pumpLoupe(
      tester,
      prefs: {'settings.aiAssist': true},
      overrides: [aiCredentialStoreProvider.overrideWithValue(store)],
    );
    await goTo(tester, Routes.privateAi);
    final brief = find.byKey(const Key('ai-feature-brief'));
    await _tap(tester, brief);
    expect(_switchOf(tester, brief), isFalse);
    final local = find.byKey(const Key('ai-local-personal'));
    await _tap(tester, local);
    expect(_switchOf(tester, local), isTrue);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList(AiFeatureSettings.key), ['brief']);
    expect(prefs.getStringList(AiLocalOnlySettings.key), ['personal']);
    var c = _container(tester);
    expect(c.read(aiFeaturesProvider), isNot(contains(AiFeature.brief)));
    expect(c.read(aiServiceForProvider((AiFeature.brief, 'work'))), isNull);
    // The demo runs on the phone: a local-only account may still use it.
    expect(c.read(aiServiceForProvider((AiFeature.search, 'personal'))), isNotNull);

    // Launch again with what was saved, and Anthropic picked.
    await pumpLoupe(
      tester,
      prefs: {for (final k in prefs.getKeys()) k: prefs.get(k)!, AiConfigController.kindKey: 'anthropic'},
      overrides: [aiCredentialStoreProvider.overrideWithValue(store)],
    );
    await goTo(tester, Routes.privateAi);
    await tester.scrollTo(find.byKey(const Key('ai-feature-brief')));
    expect(_switchOf(tester, find.byKey(const Key('ai-feature-brief'))), isFalse);
    c = _container(tester);
    expect(c.read(aiServiceForProvider((AiFeature.search, 'work')))?.provider.location, ProviderLocation.cloud);
    expect(c.read(aiServiceForProvider((AiFeature.search, 'personal'))), isNull);
    expect(c.read(aiServiceForProvider((AiFeature.search, null))), isNotNull);
  });

  testWidgets('Anthropic: the key goes to the secure store, never to preferences; Test Connection uses it', (
    tester,
  ) async {
    final store = MemoryCredentialStore();
    final sent = <http.Request>[];
    await pumpLoupe(
      tester,
      prefs: {'settings.aiAssist': true},
      overrides: [
        aiCredentialStoreProvider.overrideWithValue(store),
        aiHttpClientProvider.overrideWithValue(_anthropic(onRequest: sent.add)),
      ],
    );
    await goTo(tester, Routes.privateAi);
    await _tap(tester, find.byKey(const Key('ai-provider-anthropic')));
    // Picked without a key, it asks for one.
    expect(find.text('Anthropic API Key'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('ai-key-field')), '  sk-ant-test  ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final saved = await store.read(AiKeys.credentialId(AiProviderKind.anthropic));
    expect((saved! as PasswordCredentials).password, 'sk-ant-test');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(AiConfigController.kindKey), 'anthropic');
    for (final key in prefs.getKeys()) {
      expect('${prefs.get(key)}', isNot(contains('sk-ant-test')), reason: key);
    }
    expect(find.descendant(of: find.byKey(const Key('ai-api-key')), matching: find.text('Saved')), findsOneWidget);
    expect(find.text('sk-ant-test'), findsNothing);
    expect(find.descendant(of: find.byKey(const Key('ai-model')), matching: find.text('claude-sonnet-5-5')), findsOne);
    expect(textContaining('api.anthropic.com'), findsWidgets);

    // Nothing is sent until Test Connection is tapped.
    expect(sent, isEmpty);
    await _tap(tester, find.byKey(const Key('ai-test-connection')));
    expect(textContaining('claude-sonnet-5-5 answered in'), findsOneWidget);
    expect(sent.single.headers['x-api-key'], 'sk-ant-test');
    expect(sent.single.body, isNot(contains('sk-ant-test')));
    final ledger = _container(tester).read(aiLedgerProvider);
    final record = ledger.records.single;
    expect((record.providerId, record.inputTokens, record.outputTokens), ('anthropic:claude-sonnet-5-5', 380, 22));
    // A test is usage, not a result worth keeping.
    expect(ledger.resultCount, 0);

    // Another model from the list.
    await _tap(tester, find.byKey(const Key('ai-model')));
    await tester.tap(find.text('claude-haiku-5-5'));
    await tester.pumpAndSettle();
    expect(_container(tester).read(aiProviderProvider)?.id, 'anthropic:claude-haiku-5-5');
    await drainTimers(tester);
  });

  testWidgets('a failed test shows the provider\'s reason, and nothing goes to another provider', (tester) async {
    final store = MemoryCredentialStore();
    await store.write(AiKeys.credentialId(AiProviderKind.anthropic), const PasswordCredentials('sk-ant-bad'));
    var requests = 0;
    final client = MockClient((request) async {
      requests++;
      return http.Response(
        jsonEncode({
          'type': 'error',
          'error': {'type': 'authentication_error', 'message': 'invalid x-api-key'},
        }),
        401,
      );
    });
    await pumpLoupe(
      tester,
      prefs: {'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'},
      overrides: [aiCredentialStoreProvider.overrideWithValue(store), aiHttpClientProvider.overrideWithValue(client)],
    );
    await goTo(tester, Routes.privateAi);
    await _tap(tester, find.byKey(const Key('ai-test-connection')));
    expect(find.text('Test Failed'), findsOneWidget);
    expect(find.text('Anthropic did not accept the API key.'), findsOneWidget);
    expect(requests, 1);
    expect(_container(tester).read(aiProviderProvider)?.id, 'anthropic:claude-sonnet-5-5');
  });

  testWidgets('Remove Key deletes it from the store, stops requests and offers to delete what it made', (tester) async {
    final store = MemoryCredentialStore();
    await store.write(AiKeys.credentialId(AiProviderKind.anthropic), const PasswordCredentials('sk-ant-test'));
    await pumpLoupe(
      tester,
      prefs: {'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'},
      overrides: [
        aiCredentialStoreProvider.overrideWithValue(store),
        aiHttpClientProvider.overrideWithValue(_anthropic()),
      ],
    );
    await goTo(tester, Routes.privateAi);
    // A result Anthropic made, as Ask in Plain English would keep it.
    final c = _container(tester);
    await c.read(aiServiceProvider)!.run(SearchTranslationTask('unread mail from last week', now: testNow));
    expect(c.read(aiLedgerProvider).resultCount, 1);

    await _tap(tester, find.byKey(const Key('ai-remove-key')));
    expect(find.text('Remove the Anthropic API key?'), findsOneWidget);
    await tester.tap(find.text('Remove Key').last);
    await tester.pumpAndSettle();
    expect(await store.read(AiKeys.credentialId(AiProviderKind.anthropic)), isNull);
    expect(c.read(aiProviderProvider), isNull);
    // Still Anthropic, not set up: no other provider took over.
    expect(c.read(aiConfigProvider).kind, AiProviderKind.anthropic);

    expect(find.text('Also delete the result it made?'), findsOneWidget);
    await tester.tap(find.text('Delete Results'));
    await tester.pumpAndSettle();
    expect(c.read(aiLedgerProvider).resultCount, 0);
    expect(
      find.text('This provider isn’t set up yet, so the features show no AI parts.', skipOffstage: false),
      findsOneWidget,
    );
    expect(find.descendant(of: find.byKey(const Key('ai-api-key')), matching: find.text('Not Set')), findsOneWidget);
  });

  testWidgets('My Server: address and model make it, labelled as network processing', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    await goTo(tester, Routes.privateAi);
    await _tap(tester, find.byKey(const Key('ai-provider-myServer')));
    // Picked without an address, it asks for one; a bad one is refused.
    expect(find.text('Server Address'), findsOneWidget);
    await tester.enterText(find.byType(CupertinoTextField), 'pi.local');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('That isn’t an http:// or https:// address.'), findsOneWidget);
    await drainTimers(tester);

    await _tap(tester, find.byKey(const Key('ai-server-address')));
    await tester.enterText(find.byType(CupertinoTextField), 'http://pi.local:11434/v1');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final c = _container(tester);
    expect(c.read(aiProviderProvider), isNull);
    await _tap(tester, find.byKey(const Key('ai-server-model')));
    await tester.enterText(find.byType(CupertinoTextField), 'llama3.2');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final provider = c.read(aiProviderProvider)!;
    expect((provider.id, provider.location), ('pi.local:llama3.2', ProviderLocation.myServer));
    expect(textContaining('network processing'), findsWidgets);
    expect(textContaining('isn’t encrypted (http)'), findsOneWidget);

    await _tap(tester, find.byKey(const Key('ai-remove-server')));
    await tester.tap(find.text('Remove Server').last);
    await tester.pumpAndSettle();
    expect(c.read(aiProviderProvider), isNull);
    expect(c.read(aiConfigProvider).kind, AiProviderKind.myServer);
    expect(c.read(aiConfigProvider).serverUrl, isEmpty);
  });

  testWidgets('Usage & Estimated Cost: requests and tokens by model, unknown as unknown, prices with their date', (
    tester,
  ) async {
    AiRunRecord record(String provider, String? model, int? input, int? output, {Duration ago = Duration.zero}) =>
        AiRunRecord(
          taskType: 'brief.message',
          taskVersion: 1,
          providerId: provider,
          inputHash: '',
          startedAt: testNow.subtract(ago),
          finishedAt: testNow.subtract(ago),
          attempts: 1,
          model: model,
          inputTokens: input,
          outputTokens: output,
        );
    await pumpLoupe(
      tester,
      prefs: {
        AiLedger.recordsKey: [
          encodeRunRecord(record('anthropic:claude-sonnet-5-5', 'claude-sonnet-5-5', 4000, 800)),
          encodeRunRecord(record('anthropic:claude-sonnet-5-5', 'claude-sonnet-5-5', null, null)),
          encodeRunRecord(record('anthropic:claude-opus-5-5', 'claude-opus-5-5', null, null)),
          encodeRunRecord(record('demo', 'demo', null, null)),
          encodeRunRecord(record('pi.local:llama3.2', 'llama3.2', 120, 30, ago: const Duration(days: 90))),
        ],
      },
    );
    await atTestNow(() async {
      // Off: usage and Delete Derived Results are still there.
      await goTo(tester, Routes.privateAi);
      await _tap(tester, find.byKey(const Key('ai-usage')));
      expect(find.text('Usage & Estimated Cost'), findsWidgets);

      final sonnet = find.byKey(const ValueKey('ai-usage-anthropic:claude-sonnet-5-5-claude-sonnet-5-5'));
      expect(
        find.descendant(of: sonnet, matching: textContaining('4,000 tokens in, 800 out; 1 request not reported')),
        findsOneWidget,
      );
      // 4,000 × $2 + 800 × $10 per million, and more for the unreported request.
      expect(find.descendant(of: sonnet, matching: find.text('At least \$0.0160')), findsOneWidget);
      final opus = find.byKey(const ValueKey('ai-usage-anthropic:claude-opus-5-5-claude-opus-5-5'));
      expect(find.descendant(of: opus, matching: textContaining('Tokens not reported')), findsOneWidget);
      expect(find.descendant(of: opus, matching: find.text('Unknown')), findsOneWidget);
      expect(find.descendant(of: opus, matching: find.text('\$0.0000')), findsNothing);
      expect(
        find.descendant(of: find.byKey(const ValueKey('ai-usage-demo-demo')), matching: find.text('No Cost')),
        findsOne,
      );
      expect(find.text('pi.local:llama3.2'), findsNothing);
      expect(
        find.descendant(of: find.byKey(const Key('ai-usage-total')), matching: find.text('At least \$0.0160')),
        findsOneWidget,
      );

      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
      expect(find.text('pi.local:llama3.2'), findsOneWidget);

      await tester.scrollTo(find.text('claude-haiku-5-5'));
      expect(find.text('\$0.10 in, \$0.50 out'), findsOneWidget);
      expect(textContaining('Anthropic’s list prices on October 6, 2026'), findsOneWidget);
      expect(textContaining('estimates, not a bill'), findsOneWidget);
    });
  });

  testWidgets('Delete Derived Results clears what Private AI kept, after asking', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    await goTo(tester, Routes.privateAi);
    final c = _container(tester);
    await tester.runAsync(
      () => c.read(aiServiceProvider)!.run(SearchTranslationTask('unread from dana', now: testNow)),
    );
    await tester.pumpAndSettle();
    final row = find.byKey(const Key('ai-delete-results'));
    await tester.scrollTo(row);
    expect(find.descendant(of: row, matching: find.text('1')), findsOneWidget);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 result?'), findsOneWidget);
    await tester.tap(find.text('Delete Results'));
    await tester.pumpAndSettle();
    expect(c.read(aiLedgerProvider).resultCount, 0);
    expect(find.descendant(of: row, matching: find.text('None')), findsOneWidget);
    // The record of the request stays: it is usage, not a result.
    expect(c.read(aiLedgerProvider).records, hasLength(1));
  });

  testWidgets('turning Private AI off takes the AI parts away and cancels what runs', (tester) async {
    await pumpLoupe(tester, prefs: {'settings.aiAssist': true});
    final c = _container(tester);
    final service = c.read(aiServiceProvider)!;
    await goTo(tester, Routes.privateAi);
    await tester.tap(find.byKey(const Key('ai-assist')));
    await tester.pumpAndSettle();
    expect(c.read(aiServiceForProvider((AiFeature.search, null))), isNull);
    expect(find.text('Features'.toUpperCase()), findsNothing);
    final run = await service.run(SearchTranslationTask('unread from dana', now: testNow));
    expect((run as AiFailure).reason, AiFailureReason.cancelled);
    expect(c.read(aiLedgerProvider).records, isEmpty);
  });

  for (final lang in ['de', 'ga']) {
    testWidgets('Private AI fits a small phone in $lang', (tester) async {
      addTearDown(() => appLanguage = null);
      final store = MemoryCredentialStore();
      await store.write(AiKeys.credentialId(AiProviderKind.anthropic), const PasswordCredentials('k'));
      await pumpLoupe(
        tester,
        size: const Size(360, 640),
        prefs: {'settings.language': lang, 'settings.aiAssist': true, AiConfigController.kindKey: 'anthropic'},
        overrides: [aiCredentialStoreProvider.overrideWithValue(store)],
      );
      await goTo(tester, Routes.privateAi);
      await tester.scrollUntilVisible(
        find.byKey(const Key('ai-delete-results')),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await goTo(tester, Routes.aiUsage);
      expect(tester.takeException(), isNull);
    });
  }
}
