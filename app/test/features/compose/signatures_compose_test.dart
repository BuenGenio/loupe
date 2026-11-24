import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/compose_args.dart' show ComposeArgs;
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'compose_screen_test.dart' show fieldText, openCompose, sendButton, toField;

/// Several signatures per identity in compose: drawn formatted, chosen by
/// signature.cc's rules, sent as HTML with their images.

const _png = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';

final _work = Signature(
  id: 'work',
  name: 'Work',
  content: jsonEncode([
    {
      'insert': 'Me Myself',
      'attributes': {'bold': true},
    },
    {'insert': '\n'},
    {
      'insert': 'Example',
      'attributes': {'link': 'https://example.com'},
    },
    {'insert': '\n'},
  ]),
);

final _copied = Signature(
  id: 'copied',
  name: 'Copied',
  content: jsonEncode([
    {
      'insert': {'loupe-field': 'name'},
    },
    {'insert': ' · copied\n'},
  ]),
  rule: const SignatureRule(whenCopied: true),
);

final _logo = Signature(
  id: 'logo',
  name: 'Logo',
  content: jsonEncode([
    {
      'insert': {'image': 'data:image/png;base64,$_png'},
      'attributes': {'width': '40'},
    },
    {'insert': ' Me\n'},
  ]),
);

FakeMailRepository _repo(List<Signature> signatures) => FakeMailRepository(
  accounts: [
    testAccount.copyWith(
      identities: [Identity(id: 'acc/me', email: 'me@example.com', name: 'Me Myself', signatures: signatures)],
    ),
  ],
);

final _body = find.byKey(const Key('compose-body'));
final _cc = find.byKey(const ValueKey('recipients-Cc:'));

String _text(WidgetTester tester) => fieldText(tester, _body);

Future<void> _showCc(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
  await tester.pumpAndSettle();
}

Future<void> _send(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('compose-subject')), 'Hello');
  await tester.pump();
  await tester.tap(sendButton);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('signature.cc: a "when copied" signature follows Cc; the formatted one goes out as HTML', (tester) async {
    final repo = _repo([_work, _copied]);
    await openCompose(tester, repo);
    // Shown with its link as text; the plain part gets the address.
    expect(_text(tester), '\n\n-- \nMe Myself\nExample');

    await _showCc(tester);
    await tester.enterText(_cc, 'ana@client.example');
    await tester.pump();
    expect(_text(tester), '\n\n-- \nMe Myself · copied', reason: 'the field is the sender’s name');
    await tester.enterText(_cc, '');
    await tester.pump();
    expect(_text(tester), '\n\n-- \nMe Myself\nExample');

    await tester.enterText(toField, 'bo@example.org');
    await tester.enterText(_body, 'Hi Bo${_text(tester)}');
    await tester.pump();
    await _send(tester);
    final sent = repo.sent.single;
    expect(sent.text, 'Hi Bo\n\n-- \nMe Myself\nExample <https://example.com>');
    expect(sent.html, contains('Hi Bo'));
    expect(sent.html, contains('<div class="moz-signature">'));
    expect(sent.html, contains('<b>Me Myself</b>'));
    expect(sent.html, contains('<a href="https://example.com">Example</a>'));
    expect(sent.inline, isEmpty);
  });

  testWidgets('an image signature shows its image and goes out as a cid: part', (tester) async {
    final repo = _repo([_logo]);
    await openCompose(tester, repo);
    expect(_text(tester), '\n\n-- \n￼ Me');
    expect(find.descendant(of: _body, matching: find.byType(Image)), findsOneWidget);

    await tester.enterText(toField, 'bo@example.org');
    await _send(tester);
    final sent = repo.sent.single;
    expect(sent.text, '\n\n-- \n Me');
    final part = sent.inline.single;
    expect(part.mimeType, 'image/png');
    expect(part.data, base64Decode(_png));
    expect(sent.html, contains('<img src="cid:${part.contentId}" alt="" width="40"'));
  });

  testWidgets('an edited signature is plain text; its image goes', (tester) async {
    final repo = _repo([_logo]);
    await openCompose(tester, repo);
    await tester.enterText(_body, '\n\n-- \n￼ Me, edited');
    await tester.pump();
    expect(_text(tester), '\n\n-- \n Me, edited');
    expect(find.descendant(of: _body, matching: find.byType(Image)), findsNothing);
    await tester.enterText(toField, 'bo@example.org');
    await _send(tester);
    expect(repo.sent.single.html, isNull);
    expect(repo.sent.single.inline, isEmpty);
  });

  testWidgets('the Signature button switches or removes it, and Cc no longer changes it', (tester) async {
    final repo = _repo([_work, _copied]);
    await openCompose(tester, repo);
    await tester.tap(find.byKey(const Key('compose-signature')));
    await tester.pumpAndSettle();
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Copied'), findsOneWidget);
    await tester.tap(find.text('No Signature'));
    await tester.pumpAndSettle();
    expect(_text(tester), '');

    await tester.tap(find.byKey(const Key('compose-signature')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copied'));
    await tester.pumpAndSettle();
    expect(_text(tester), '\n\n-- \nMe Myself · copied');
    await _showCc(tester);
    await tester.enterText(_cc, 'ana@client.example');
    await tester.enterText(_cc, '');
    await tester.pump();
    expect(_text(tester), '\n\n-- \nMe Myself · copied', reason: 'picked by hand');
  });

  testWidgets('a message brought back gets its formatted signature again', (tester) async {
    final repo = _repo([_work]);
    await openCompose(
      tester,
      repo,
      const ComposeArgs.restore(
        OutgoingMessage(
          accountId: 'acc',
          identityId: 'acc/me',
          to: [EmailAddress('bo@example.org')],
          subject: 'Hello',
          text: 'Hi\n\n-- \nMe Myself\nExample <https://example.com>',
        ),
      ),
    );
    expect(_text(tester), 'Hi\n\n-- \nMe Myself\nExample');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(repo.sent.single.html, contains('<b>Me Myself</b>'));
  });
}
