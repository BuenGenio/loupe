import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:mail_model/mail_model.dart' hide TextField;

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

final toField = find.byKey(const ValueKey('recipients-To:'));
final sendButton = find.byKey(const Key('compose-send'));

bool sendEnabled(WidgetTester tester) => tester.widget<IconButton>(sendButton).onPressed != null;

Future<GoRouter> openCompose(
  WidgetTester tester,
  FakeMailRepository repo, [
  ComposeArgs args = const ComposeArgs(),
  Map<String, Object> prefs = const {},
]) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    prefs: prefs,
    composeBuilder: (args) => ComposeScreen(args: args),
  );
  unawaited(router.push('/compose', extra: args));
  await tester.pumpAndSettle();
  return router;
}

/// The text a [TextField] holds, without the recipient field's sentinel.
String fieldText(WidgetTester tester, Finder finder) =>
    tester.widget<TextField>(finder).controller!.text.replaceAll('​', '');

void main() {
  testWidgets('Send is enabled only with a valid recipient; backspace removes the last chip', (tester) async {
    await openCompose(tester, FakeMailRepository());
    expect(find.text('New Message'), findsOneWidget);
    expect(find.text('Cc/Bcc, From: me@example.com'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);

    await tester.enterText(toField, 'nope,');
    await tester.pump();
    expect(find.text('nope'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);

    await tester.enterText(toField, 'bob@example.com,');
    await tester.pump();
    expect(find.text('bob'), findsOneWidget);
    expect(sendEnabled(tester), isTrue);

    // Backspace in the empty field: the sentinel disappears.
    await tester.enterText(toField, '');
    await tester.pump();
    expect(find.text('bob'), findsNothing);
    expect(find.text('nope'), findsOneWidget);
    expect(sendEnabled(tester), isFalse);
  });

  testWidgets('autocomplete adds a chip', (tester) async {
    await openCompose(tester, FakeMailRepository());
    await tester.enterText(toField, 'ali');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('suggestion-alice@example.com')));
    await tester.pumpAndSettle();
    expect(find.text('Alice Example'), findsOneWidget);
    expect(sendEnabled(tester), isTrue);
  });

  testWidgets('send queues with the undo delay, and Undo cancels and reopens', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo, const ComposeArgs(), {'settings.undoSendSeconds': 7});
    await tester.enterText(toField, 'alice@example.com');
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Hello');
    await tester.enterText(find.byKey(const Key('compose-body')), 'Hi Alice');
    await tester.pump();

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(repo.log, contains('send Hello undo=7'));
    final sent = repo.sent.single;
    expect(sent.to.single.email, 'alice@example.com');
    expect(sent.text, startsWith('Hi Alice'));
    expect(sent.identityId, 'acc/me');
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Sending…'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(repo.cancelled, ['outbox-1']);
    expect(find.byType(ComposeScreen), findsOneWidget);
    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Hello');
    expect(find.text('Alice Example'), findsNothing);
    expect(find.text('alice'), findsOneWidget);
  });

  testWidgets('warns about an empty subject', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo, const ComposeArgs(to: [bob]));
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    expect(find.text('No Subject'), findsOneWidget);
    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();
    expect(repo.sent, isEmpty);

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send'));
    await tester.pumpAndSettle();
    expect(repo.sent, hasLength(1));
  });

  testWidgets('closing with content offers Save Draft', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo);
    await tester.enterText(find.byKey(const Key('compose-subject')), 'Plans');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    expect(find.text('Delete Draft'), findsOneWidget);
    await tester.tap(find.text('Save Draft'));
    await tester.pumpAndSettle();
    expect(repo.drafts.single.subject, 'Plans');
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Draft saved'), findsOneWidget);
  });

  testWidgets('closing an untouched message asks nothing; Delete Draft discards', (tester) async {
    final repo = FakeMailRepository();
    await openCompose(tester, repo);
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);

    await openCompose(tester, repo);
    await tester.enterText(find.byKey(const Key('compose-body')), 'Draft text');
    await tester.pump();
    await tester.tap(find.byKey(const Key('compose-cancel')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Draft'));
    await tester.pumpAndSettle();
    expect(repo.drafts, isEmpty);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('Reply All quotes the source and excludes my address', (tester) async {
    final repo = FakeMailRepository(
      emails: [
        testEmail('m3', to: [me, bob], cc: [const EmailAddress('carol@example.org', 'Carol')]),
      ],
      contents: {'m3': const EmailContent(emailId: 'm3', text: 'See you at noon.')},
    );
    await openCompose(tester, repo, const ComposeArgs(mode: ComposeMode.replyAll, sourceEmailId: 'm3'));

    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Re: Lunch plans');
    expect(find.text('Alice Example'), findsOneWidget);
    expect(find.text('Bob Builder'), findsOneWidget);
    expect(find.text('Carol'), findsOneWidget, reason: 'Cc is shown expanded');
    expect(find.text('Me Myself'), findsNothing);
    final body = fieldText(tester, find.byKey(const Key('compose-body')));
    expect(body, startsWith('\n\n-- \nCheers,\nMe\n\nOn '));
    expect(body, endsWith('Alice Example wrote:\n> See you at noon.'));

    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    final sent = repo.sent.single;
    expect(sent.mode, ComposeMode.replyAll);
    expect(sent.inReplyTo, 'm3@example.com');
    expect(sent.references, ['m3@example.com']);
    expect(sent.sourceEmailId, 'm3');
    expect(sent.cc.single.email, 'carol@example.org');
  });

  testWidgets('Forward prefixes the subject once and adds the header block', (tester) async {
    final repo = FakeMailRepository(emails: [testEmail('m3', subject: 'Fwd: Lunch plans')]);
    await openCompose(tester, repo, const ComposeArgs(mode: ComposeMode.forward, sourceEmailId: 'm3'));
    expect(fieldText(tester, find.byKey(const Key('compose-subject'))), 'Fwd: Lunch plans');
    expect(fieldText(tester, find.byKey(const Key('compose-body'))), contains('---------- Forwarded message'));
    expect(sendEnabled(tester), isFalse);
  });

  testWidgets('the From picker switches identity and signature', (tester) async {
    final repo = FakeMailRepository(
      accounts: [
        testAccount,
        testAccount.copyWith(
          identities: const [Identity(id: 'home/me', email: 'me@home.test', name: 'Me', signature: 'From home')],
        ),
      ],
    );
    await openCompose(tester, repo);
    await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('compose-from')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('identity-home/me')));
    await tester.pumpAndSettle();
    expect(find.text('From: Me <me@home.test>', findRichText: true), findsOneWidget);
    expect(fieldText(tester, find.byKey(const Key('compose-body'))), '\n\n-- \nFrom home');
  });
}
