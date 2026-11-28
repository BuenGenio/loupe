import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_brief.dart';
import 'package:loupe/features/ai/ai_providers.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

Finder _key(String key) => find.byKey(Key(key));

final _now = DateTime(2026, 10, 4, 12);

/// The demo's rules behind a provider of the given kind.
FakeProvider _provider({String id = 'fake', ProviderLocation location = ProviderLocation.onThisPhone}) =>
    FakeProvider.scripted((r) => demoBrief(r, _now), id: id, location: location, model: 'model-7');

Future<void> _open(
  WidgetTester tester,
  FakeMailRepository repo, {
  required String id,
  AiProvider? provider,
  Set<String> localOnly = const {},
}) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    overrides: [
      aiProviderProvider.overrideWithValue(provider ?? _provider()),
      aiLocalOnlyAccountsProvider.overrideWithValue(localOnly),
    ],
  );
  unawaited(router.push('/message/$id'));
  await tester.pumpAndSettle();
}

FakeMailRepository _one(EmailContent content, {Set<String> keywords = const {}, String mailboxId = 'acc|INBOX'}) =>
    FakeMailRepository(
      emails: [
        testEmail(content.emailId, keywords: {Keywords.seen, ...keywords}, mailboxId: mailboxId),
      ],
      contents: {content.emailId: content},
    );

void main() {
  testWidgets('HTML mail is read as text with its link destinations, and the passage is found in it', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await _open(
      tester,
      _one(
        const EmailContent(
          emailId: 'h1',
          html:
              '<html><body><div><p>Hi Sam,</p><ul><li>Please fill in <a href="https://forms.example/a/1">the form</a> '
              'by Friday 6 November.</li></ul><p>Thanks,<br>Alice</p></div></body></html>',
        ),
      ),
      id: 'h1',
    );
    await tester.tap(_key('brief-button'));
    await tester.pumpAndSettle();
    expect(find.textContaining('the form <https://forms.example/a/1> by Friday 6 November'), findsOneWidget);
    expect(find.text('Deadline: by Friday 6 November'), findsOneWidget);

    await tester.tap(_key('brief-source-0'));
    await tester.pumpAndSettle();
    final text = tester.widget<Text>(
      find.descendant(
        of: _key('brief-evidence'),
        matching: find.byWidgetPredicate((w) => w is Text && w.textSpan != null),
      ),
    );
    final spans = (text.textSpan! as TextSpan).children!.cast<TextSpan>();
    expect(spans[1].text, 'Please fill in the form <https://forms.example/a/1> by Friday 6 November.');
    expect(spans[0].text, 'Hi Sam,\n\n');
  });

  testWidgets('a long message says the Brief covers only its beginning', (tester) async {
    final long = 'Please send the signed contract.\n\n${'Some more words about the move. ' * 600}';
    await _open(
      tester,
      _one(EmailContent(emailId: 'l1', text: long)),
      id: 'l1',
    );
    await tester.tap(_key('brief-button'));
    await tester.pumpAndSettle();
    expect(_key('brief-partial'), findsOneWidget);
    expect(find.textContaining('covers only its beginning'), findsOneWidget);
  });

  testWidgets('an item from an attachment’s name points to the attachment', (tester) async {
    final answer = FakeProvider(
      answers: [
        '{"summary": "The illustration is attached.", "nothing_to_summarise": false, "items": [{"kind": "document", '
            '"text": "The mortgage illustration is attached", "quote": "Mortgage illustration.pdf", "channel": null, '
            '"owner": "them", "due": {"kind": "none", "text": null, "date": null}}]}',
      ],
    );
    await _open(
      tester,
      _one(
        const EmailContent(
          emailId: 'a1',
          text: 'Hi Sam, here it is.',
          attachments: [Attachment(partId: '2', mimeType: 'application/pdf', filename: 'Mortgage illustration.pdf')],
        ),
      ),
      id: 'a1',
      provider: answer,
    );
    await tester.tap(_key('brief-button'));
    await tester.pumpAndSettle();
    expect(_key('brief-section-otherDocuments'), findsOneWidget);
    await tester.tap(_key('brief-source-0'));
    await tester.pumpAndSettle();
    expect(find.textContaining('the name of an attached file'), findsOneWidget);
    expect(
      find.descendant(of: _key('brief-evidence'), matching: find.text('Mortgage illustration.pdf')),
      findsOneWidget,
    );
  });

  testWidgets('a network provider names itself and where it runs', (tester) async {
    await _open(
      tester,
      _one(const EmailContent(emailId: 'c1', text: 'Please send the signed contract by Friday 6 November.')),
      id: 'c1',
      provider: _provider(id: 'anthropic:model-7', location: ProviderLocation.cloud),
    );
    await tester.tap(_key('brief-button'));
    await tester.pumpAndSettle();
    expect(find.text('Made in the cloud by anthropic:model-7.'), findsOneWidget);
  });

  group('not offered', () {
    testWidgets('for a draft', (tester) async {
      await _open(
        tester,
        _one(
          const EmailContent(emailId: 'd1', text: 'Please send it.'),
          keywords: {Keywords.draft},
        ),
        id: 'd1',
      );
      expect(find.text('Please send it.'), findsOneWidget);
      expect(_key('brief-button'), findsNothing);
    });

    testWidgets('for an account whose mail stays on the phone, with a network provider', (tester) async {
      final repo = _one(const EmailContent(emailId: 'p1', text: 'Please send it.'));
      await _open(
        tester,
        repo,
        id: 'p1',
        provider: _provider(location: ProviderLocation.cloud),
        localOnly: {'acc'},
      );
      expect(find.text('Please send it.'), findsOneWidget);
      expect(_key('brief-button'), findsNothing);
    });

    testWidgets('for a message with no text', (tester) async {
      await _open(
        tester,
        _one(const EmailContent(emailId: 'e1', text: '  ')),
        id: 'e1',
      );
      expect(_key('brief-button'), findsNothing);
    });
  });
}
