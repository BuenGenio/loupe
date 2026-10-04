import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/compose_text.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';

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
    final r = ComposeText.replyRecipients(source, all: true, own: {'me@example.com'});
    expect(r.to.map((a) => a.email), ['alice@example.com', 'bob@example.com']);
    expect(r.cc, isEmpty);

    final single = ComposeText.replyRecipients(source, all: false, own: {'me@example.com'});
    expect(single.to.map((a) => a.email), ['alice@example.com']);
  });

  test('replying to my own message goes to its recipients', () {
    final source = testEmail('m2', from: me, to: [alice]);
    final r = ComposeText.replyRecipients(source, all: false, own: {'me@example.com'});
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
    expect(ComposeText.replaceSignature('Hi\n\n-- \nOld', 'Old', null), 'Hi\n\n');
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
}
