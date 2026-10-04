import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/compose/compose_screen.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';

final _body = find.byKey(const Key('compose-body'));
final _send = find.byKey(const Key('compose-send'));
final _suggestion = find.byKey(const Key('compose-alias-suggestion'));

const _store = EmailAddress('orders@store.test', 'Store');

final _account = testAccount.copyWith(
  identities: const [
    Identity(id: 'acc/me', email: 'me@example.com', name: 'Me Myself', signature: 'Cheers,\nMe'),
    Identity(
      id: 'acc/shop',
      email: 'shop@example.com',
      name: 'Example Shop',
      signature: 'The Shop',
      replyTo: 'help@example.com',
      autoBcc: 'archive@example.com',
    ),
  ],
);

Future<void> _open(WidgetTester tester, FakeMailRepository repo, ComposeArgs args) async {
  final router = await pumpTestApp(
    tester,
    repository: repo,
    composeBuilder: (args) => ComposeScreen(args: args),
  );
  unawaited(router.push('/compose', extra: args));
  await tester.pumpAndSettle();
}

String _text(WidgetTester tester, Finder finder) => tester.widget<TextField>(finder).controller!.text;

Future<void> _pick(WidgetTester tester, String key) async {
  if (find.byKey(const Key('compose-ccbcc-from')).evaluate().isNotEmpty) {
    await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.byKey(const Key('compose-from')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(ValueKey(key)));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a reply goes out from the identity in Delivered-To', (tester) async {
    final repo = FakeMailRepository(
      accounts: [_account],
      emails: [
        testEmail('m1', from: _store, to: const [EmailAddress('announce@store.test')]),
      ],
      contents: {
        'm1': const EmailContent(emailId: 'm1', text: 'Your order', headers: [('Delivered-To', 'shop@example.com')]),
      },
    );
    await _open(tester, repo, const ComposeArgs(mode: ComposeMode.reply, sourceEmailId: 'm1'));
    expect(find.text('From: Example Shop <shop@example.com>', findRichText: true), findsOneWidget);
    expect(find.text('Reply-To: help@example.com'), findsOneWidget);
    expect(find.text('archive'), findsOneWidget, reason: 'the identity Bccs its archive');
    expect(_text(tester, _body), startsWith('\n\n-- \nThe Shop\n\nOn '));
    expect(_suggestion, findsNothing);

    await tester.tap(_send);
    await tester.pumpAndSettle();
    final sent = repo.sent.single;
    expect(sent.identityId, 'acc/shop');
    expect(sent.bcc.single.email, 'archive@example.com');
  });

  testWidgets('switching identity swaps the signature, keeps my text, and swaps the automatic Bcc', (tester) async {
    final repo = FakeMailRepository(accounts: [_account]);
    await _open(tester, repo, const ComposeArgs(to: [bob]));
    await tester.enterText(_body, 'Hello Bob,\n\n-- \nCheers,\nMe, edited\n');
    await tester.pump();

    await _pick(tester, 'identity-acc/shop');
    expect(_text(tester, _body), 'Hello Bob,\n\n-- \nThe Shop\n');
    expect(find.text('archive'), findsOneWidget);
    expect(find.text('Reply-To: help@example.com'), findsOneWidget);

    await _pick(tester, 'identity-acc/me');
    expect(_text(tester, _body), 'Hello Bob,\n\n-- \nCheers,\nMe\n');
    expect(find.text('archive'), findsNothing);
    expect(find.text('Reply-To: help@example.com'), findsNothing);

    // Autosave uses the identity chosen last.
    await tester.pump(ComposeScreen.autosaveDelay);
    await tester.pumpAndSettle();
    expect(repo.drafts.last.identityId, 'acc/me');
  });

  group('catch-all', () {
    FakeMailRepository repo() => FakeMailRepository(
      accounts: [_account],
      emails: [
        testEmail('m1', from: _store, to: const [EmailAddress('store-17@example.com')], cc: [bob]),
      ],
      contents: {
        'm1': const EmailContent(
          emailId: 'm1',
          text: 'Your order',
          headers: [('Delivered-To', 'me+catchall@example.com'), ('X-Original-To', 'me@example.com')],
        ),
      },
    );

    testWidgets('offers to reply from the alias; it keeps the default name and signature', (tester) async {
      final r = repo();
      await _open(tester, r, const ComposeArgs(mode: ComposeMode.replyAll, sourceEmailId: 'm1'));
      expect(find.text('From: Me Myself <me@example.com>', findRichText: true), findsOneWidget);
      expect(find.text('Reply from store-17@example.com?'), findsOneWidget);
      // Reply All: the delivery address isn't a recipient; the alias still is until chosen.
      expect(find.text('store-17'), findsOneWidget);
      expect(find.text('Bob Builder'), findsOneWidget);

      await tester.tap(_suggestion);
      await tester.pumpAndSettle();
      expect(_suggestion, findsNothing);
      expect(find.text('From: Me Myself <store-17@example.com>', findRichText: true), findsOneWidget);
      expect(find.text('store-17'), findsNothing, reason: 'replying from the alias takes it out of the recipients');
      expect(_text(tester, _body), startsWith('\n\n-- \nCheers,\nMe\n\nOn '));

      await tester.tap(_send);
      await tester.pumpAndSettle();
      final sent = r.sent.single;
      expect(sent.identityId, _account.aliasIdentity('store-17@example.com').id);
      expect(_account.identityById(sent.identityId).email, 'store-17@example.com');
      expect(_account.identityById(sent.identityId).name, 'Me Myself');
      expect(sent.to.map((a) => a.email), ['orders@store.test']);
      expect(sent.cc.map((a) => a.email), ['bob@example.com']);
    });

    testWidgets('the suggestion can be waved away', (tester) async {
      await _open(tester, repo(), const ComposeArgs(mode: ComposeMode.reply, sourceEmailId: 'm1'));
      await tester.tap(find.byKey(const Key('compose-alias-dismiss')));
      await tester.pumpAndSettle();
      expect(_suggestion, findsNothing);
      expect(find.text('Cc/Bcc, From: me@example.com'), findsOneWidget);
    });

    testWidgets('the From picker groups by account and saves the alias as an identity', (tester) async {
      final r = repo();
      r.accounts.add(
        const MailAccount(
          id: 'home',
          email: 'me@home.test',
          displayName: 'Home',
          provider: ProviderKind.generic,
          authKind: AuthKind.password,
          incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.home.test', port: 993),
          identities: [Identity(id: 'home/me', email: 'me@home.test')],
        ),
      );
      await _open(tester, r, const ComposeArgs(mode: ComposeMode.reply, sourceEmailId: 'm1'));
      await tester.tap(find.byKey(const Key('compose-ccbcc-from')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('compose-from')));
      await tester.pumpAndSettle();
      expect(find.text('Reply from store-17@example.com'), findsOneWidget);
      expect(find.text('WORK'), findsOneWidget);
      expect(find.text('HOME'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('identity-save-alias')));
      await tester.pumpAndSettle();
      final saved = r.accounts.first.identities;
      expect(saved.map((i) => i.email), ['me@example.com', 'shop@example.com', 'store-17@example.com']);
      expect(saved.last.name, 'Me Myself');
      expect(saved.last.signature, 'Cheers,\nMe');
      expect(find.text('From: Me Myself <store-17@example.com>', findRichText: true), findsOneWidget);
      expect(find.text('store-17@example.com is saved as an identity.'), findsOneWidget);

      // Saved, it is an ordinary identity: no more offer.
      await tester.tap(find.byKey(const Key('compose-from')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('identity-alias')), findsNothing);
      expect(find.byKey(ValueKey('identity-${saved.last.id}')), findsOneWidget);
    });
  });

  testWidgets('a draft written from an alias reopens with it', (tester) async {
    final repo = FakeMailRepository(
      accounts: [_account],
      emails: [
        testEmail(
          'd1',
          from: const EmailAddress('store-17@example.com', 'Me Myself'),
          to: const [_store],
          subject: 'Re: Order',
          mailboxId: 'acc|Drafts',
        ),
      ],
      contents: {'d1': const EmailContent(emailId: 'd1', text: 'Thanks')},
    );
    await _open(tester, repo, const ComposeArgs(mode: ComposeMode.editDraft, sourceEmailId: 'd1'));
    expect(find.text('Cc/Bcc, From: store-17@example.com'), findsOneWidget);
    await tester.tap(_send);
    await tester.pumpAndSettle();
    expect(repo.sent.single.identityId, 'acc/alias:store-17@example.com');
  });
}
