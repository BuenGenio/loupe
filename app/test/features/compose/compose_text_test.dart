import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/compose_text.dart';
import 'package:loupe/features/compose/identity_selection.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';

bool isMe(String email) => email.toLowerCase() == 'me@example.com';

void main() {
  test('subject prefixes are added once', () {
    expect(ComposeText.replySubject('Lunch'), 'Re: Lunch');
    expect(ComposeText.replySubject('RE: Lunch'), 'RE: Lunch');
    expect(ComposeText.replySubject('Aw: Lunch'), 'Aw: Lunch');
    expect(ComposeText.forwardSubject('Re: Lunch'), 'Fwd: Re: Lunch');
    expect(ComposeText.forwardSubject('FW: Lunch'), 'FW: Lunch');
    expect(ComposeText.baseSubject('Re: Fwd: RE[2]: Lunch'), 'Lunch');
  });

  test('quotes lines with "> "', () {
    expect(ComposeText.quote('Hi\n\n> earlier\nBye\n'), '> Hi\n>\n>> earlier\n> Bye');
    final block = ComposeText.replyBlock(testEmail('m1'), 'Hello');
    expect(block, startsWith('On '));
    expect(block, contains('Alice Example wrote:\n> Hello'));
  });

  test('forward block lists the original header fields', () {
    final block = ComposeText.forwardBlock(testEmail('m1', cc: [bob]), 'Body');
    expect(block, contains('---------- Forwarded message ----------'));
    expect(block, contains('From: Alice Example <alice@example.com>'));
    expect(block, contains('Cc: Bob Builder <bob@example.com>'));
    expect(block, endsWith('\n\nBody'));
  });

  test('reply all excludes own addresses and duplicates', () {
    final source = testEmail('m1', to: [me, bob, alice], cc: [const EmailAddress('ME@example.com'), bob]);
    final r = ComposeText.replyRecipients(source, all: true, isOwn: isMe);
    expect(r.to.map((a) => a.email), ['alice@example.com', 'bob@example.com']);
    expect(r.cc, isEmpty);

    final single = ComposeText.replyRecipients(source, all: false, isOwn: isMe);
    expect(single.to.map((a) => a.email), ['alice@example.com']);
  });

  test('reply all leaves out identities, aliases, plus-addresses and pattern matches', () {
    final accounts = [
      testAccount.copyWith(
        identities: const [
          Identity(id: 'acc/me', email: 'me@example.com'),
          Identity(id: 'acc/shop', email: 'shop@acme.example', replyPatterns: ['*@acme.example']),
        ],
      ),
      testAccount.copyWith(
        identities: const [Identity(id: 'home/me', email: 'me@home.example')],
      ),
    ];
    final own = OwnAddresses(accounts, extra: const ['alex+catchall@relay.example']);
    final source = testEmail(
      'm1',
      to: const [
        EmailAddress('ME+lists@example.com'),
        EmailAddress('orders-17@acme.example'),
        alice,
        EmailAddress('me@home.example'),
      ],
      cc: const [EmailAddress('alex+catchall@relay.example'), bob, EmailAddress('shop@acme.example')],
    );
    final r = ComposeText.replyRecipients(source, all: true, isOwn: own.contains);
    expect(r.to.map((a) => a.email), ['alice@example.com']);
    expect(r.cc.map((a) => a.email), ['bob@example.com']);
    expect(own.contains('someone@example.com'), isFalse);
    expect(own.contains('me@example.org'), isFalse);
  });

  test('replying to my own message goes to its recipients', () {
    final source = testEmail('m2', from: me, to: [alice]);
    final r = ComposeText.replyRecipients(source, all: false, isOwn: isMe);
    expect(r.to.single, alice);
  });

  test('references append the source Message-ID', () {
    final source = EmailSummary(
      id: 'x',
      accountId: 'acc',
      mailboxId: 'acc|INBOX',
      receivedAt: DateTime(2026),
      messageIdHeader: 'b@x',
      references: const ['a@x'],
    );
    expect(ComposeText.replyReferences(source), ['a@x', 'b@x']);
  });

  test('signatures are inserted after "-- " and swapped', () {
    expect(ComposeText.signatureBlock('Me'), '-- \nMe');
    const body = 'Hello\n\n-- \nOld sig\n\nOn …';
    expect(ComposeText.replaceSignature(body, 'Old sig', 'New sig'), 'Hello\n\n-- \nNew sig\n\nOn …');
    expect(ComposeText.replaceSignature('Hello', null, 'Sig'), 'Hello\n\n-- \nSig');
    expect(ComposeText.replaceSignature('Hi\n\n-- \nOld', 'Old', null), 'Hi');
  });

  group('swapping signatures', () {
    const quote = 'On 4 October 2026 at 14:05, Alice wrote:\n> Lunch?\n>\n> -- \n> Alice';
    const forward = '---------- Forwarded message ----------\nFrom: Alice\n\nText\n-- \nAlice';

    test('keeps the user\'s text before and after an untouched signature', () {
      expect(
        ComposeText.replaceSignature('Hi Bob,\n\n-- \nWork Sig\n\n$quote', 'Work Sig', 'Home'),
        'Hi Bob,\n\n-- \nHome\n\n$quote',
      );
      expect(
        ComposeText.replaceSignature('Hi\n\n-- \nWork Sig\nPS: see below\n\n$quote', 'Work Sig', 'Home'),
        'Hi\n\n-- \nHome\nPS: see below\n\n$quote',
      );
    });

    test('replaces a signature the user edited, up to the quoted original', () {
      expect(
        ComposeText.replaceSignature('Hi\n\n-- \nWork Sig, edited\nline 2\n\n$quote', 'Work Sig', 'Home'),
        'Hi\n\n-- \nHome\n\n$quote',
      );
      expect(
        ComposeText.replaceSignature('Hi\n\n-- \nEdited\n\n$forward', 'Work Sig', 'Home'),
        'Hi\n\n-- \nHome\n\n$forward',
      );
    });

    test('never touches the quoted or forwarded original\'s signature', () {
      expect(ComposeText.replaceSignature('\n\n$quote', null, 'Home'), '\n\n-- \nHome\n\n$quote');
      expect(ComposeText.replaceSignature('Hi\n\n$forward', 'Alice', 'Home'), 'Hi\n\n-- \nHome\n\n$forward');
      expect(ComposeText.replaceSignature('Hi\n\n$quote', 'Alice', null), 'Hi\n\n$quote');
    });

    test('removing a signature leaves the user\'s text and the quote', () {
      expect(ComposeText.replaceSignature('\n\n-- \nWork\n\n$quote', 'Work', null), '\n\n$quote');
      expect(ComposeText.replaceSignature('Thanks!\n\n-- \nWork\n\n$quote', 'Work', ''), 'Thanks!\n\n$quote');
    });

    test('adds one where there was none', () {
      expect(ComposeText.replaceSignature('', null, 'Home'), '\n\n-- \nHome');
      expect(ComposeText.replaceSignature('Hi', null, 'Home'), 'Hi\n\n-- \nHome');
      expect(ComposeText.replaceSignature('Hi', null, null), 'Hi');
    });

    test('finds where the original starts', () {
      expect(ComposeText.quoteStart('Hi\n\n$quote'), 4);
      expect(ComposeText.quoteStart('Hi\n\n$forward'), 4);
      expect(ComposeText.quoteStart('Hi\n> no attribution'), 3);
      expect(ComposeText.quoteStart('Hi'), 2);
      expect(ComposeText.signatureRange('Hi\n\n-- \nSig\n\n$quote'), (4, 11));
      expect(ComposeText.signatureRange('Hi\n\n$quote'), isNull);
    });
  });

  test('parses address lists and validates addresses', () {
    final list = ComposeText.parseAddresses('Alice <alice@example.com>, "Doe, J" <j@x.org>; bob@example.com, nope');
    expect(list.map((a) => a.email), ['alice@example.com', 'j@x.org', 'bob@example.com', 'nope']);
    expect(list[1].name, 'Doe, J');
    expect(ComposeText.isValidEmail('bob@example.com'), isTrue);
    expect(ComposeText.isValidEmail('nope'), isFalse);
    expect(ComposeText.isValidEmail('a b@example.com'), isFalse);
  });

  test('html to text keeps paragraphs and decodes entities', () {
    expect(
      ComposeText.htmlToText('<p>Hi&nbsp;there &amp; you</p><p>Line<br>two</p><style>x{}</style>'),
      'Hi there & you\nLine\ntwo',
    );
  });

  test('html to text survives numeric entities that are no characters', () {
    expect(ComposeText.htmlToText('a&#65;b'), 'aAb');
    expect(ComposeText.htmlToText('&#1114112;'), '\uFFFD', reason: 'beyond U+10FFFF');
    expect(ComposeText.htmlToText('&#55357;'), '\uFFFD', reason: 'a lone surrogate half');
    expect(ComposeText.htmlToText('&#123456789012345678901234;'), '\uFFFD', reason: 'too big for an int');
  });
}
