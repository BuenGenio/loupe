import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/terms.dart';

final email = EmailSummary(
  id: '1',
  accountId: 'acc',
  mailboxId: 'inbox',
  receivedAt: DateTime(2026, 3, 1, 23, 30),
  from: const [EmailAddress('alice@example.com', 'Alice Example')],
  to: const [EmailAddress('bob@example.org', 'Bob')],
  cc: const [EmailAddress('carol@example.net')],
  bcc: const [EmailAddress('dave@example.com')],
  subject: 'Invoice  March',
  preview: 'Please find the invoice attached',
  size: 600 * 1024,
  keywords: const {r'$seen', r'$label2'},
  hasAttachment: true,
  messageIdHeader: 'abc@example.com',
);

const content = EmailContent(
  emailId: '1',
  html: '<p>Order <b>#123</b>456&amp;co</p><style>.invoice{}</style><div>Thanks,&nbsp;Alice</div>',
  attachments: [Attachment(partId: '2', mimeType: 'application/pdf', filename: 'invoice-03.pdf')],
  headers: [('List-Id', '<dev.lists.example.com>'), ('X-Mailer', 'Loupe 1.0')],
);

bool m(SearchExpr e, {EmailContent? c, String? account, Map<String, String> headers = const {}, EmailSummary? on}) =>
    matchesEmail(e, on ?? email, content: c, accountLabel: account, headers: headers);

void main() {
  group('truth table (with content, without content)', () {
    final cases = <(SearchExpr, bool, bool)>[
      (const MatchAll(), true, true),
      // Text anywhere: addresses, subject, body.
      (any('alice'), true, true),
      (any('ALICE example'), true, true),
      (any('invoice march'), true, true),
      (any('order #123456'), true, true),
      (not(any('order #123456')), false, true),
      (any('zzz'), false, true),
      (not(any('zzz')), true, true),
      (not(any('carol')), false, false),
      // Addresses.
      (from('alice@'), true, true),
      (from('Alice Example <alice'), true, true),
      (from('bob'), false, false),
      (toOnly('bob'), true, true),
      (toOrCc('carol'), true, true),
      (cc('carol'), true, true),
      (bcc('dave'), true, true),
      (recipients('dave'), true, true),
      (recipients('alice'), false, false),
      (participants('alice'), true, true),
      // Subject and body.
      (subject('march'), true, true),
      (subject('order'), false, false),
      (body('#123456'), true, true),
      (body('zzz'), false, true),
      (not(body('zzz')), true, true),
      (not(body('invoice')), true, false),
      (body('thanks, alice'), true, true),
      (body('.invoice'), false, true),
      // Attachments.
      (attachment('pdf'), true, true),
      (attachment('INVOICE-03'), true, true),
      (attachment('docx'), false, true),
      (hasAttachment, true, true),
      (not(hasAttachment), false, false),
      // Patterns.
      (re(TextField.subject, '^invoice'), true, true),
      (re(TextField.subject, '^invoice', cs: true), false, false),
      (re(TextField.from, r'@example\.(com|org)>$', cs: true), true, true),
      (re(TextField.recipients, '^bob'), true, true),
      (re(TextField.to, '^Bob <'), true, true),
      (re(TextField.body, r'#\d{6}'), true, true),
      (re(TextField.body, r'^\d+$'), false, true),
      (re(TextField.any, 'carol@'), true, true),
      (re(TextField.attachment, r'\.pdf$'), true, true),
      (re(TextField.subject, '('), false, false),
      (not(re(TextField.subject, '(')), true, true),
      // Headers.
      (const HeaderTerm('list-id', 'dev.lists'), true, true),
      (const HeaderTerm('List-Id', 'zzz'), false, true),
      (const HeaderTerm('X-Mailer', ''), true, true),
      (not(const HeaderTerm('X-Nope', '')), true, true),
      (const HeaderTerm('X-Nope', ''), false, true),
      (const HeaderTerm('Subject', 'march'), true, true),
      (const HeaderTerm('message-id', 'abc@'), true, true),
      (const HeaderTerm('cc', 'carol'), true, true),
      // Keywords.
      (read, true, true),
      (unread, false, false),
      (kw(Keywords.label2), true, true),
      (kw(r'$LABEL2'), true, true),
      (not(kw(Keywords.label2)), false, false),
      (flagged, false, false),
      // Dates, by local day (received 1 March, 23:30).
      (before(2026, 3, 2), true, true),
      (before(2026, 3, 1), false, false),
      (since(2026, 3, 1), true, true),
      (since(2026, 3, 2), false, false),
      (on(2026, 3, 1), true, true),
      (on(2026, 2, 28), false, false),
      (DateTerm(DateComparison.on, DateTime.utc(2026, 3, 1)), true, true),
      // Sizes (600 KB).
      (larger(500 * kb), true, true),
      (larger(600 * kb), false, false),
      (smaller(600 * kb), false, false),
      (smaller(601 * kb), true, true),
      // Compounds.
      (and([from('alice'), subject('march')]), true, true),
      (and([from('alice'), subject('april')]), false, false),
      (or([from('bob'), subject('march')]), true, true),
      (or([from('bob'), subject('april')]), false, false),
      (and([body('zzz'), from('alice')]), false, true),
      (and([body('zzz'), from('bob')]), false, false),
      (or([body('zzz'), from('bob')]), false, true),
      (not(or([body('zzz'), from('alice')])), false, false),
      (const SearchAnd([]), true, true),
      (const SearchOr([]), false, false),
      (const SearchNot(MatchAll()), false, false),
    ];
    for (final (expr, withContent, withoutContent) in cases) {
      test('$expr', () {
        expect(m(expr, c: content), withContent, reason: 'with content');
        expect(m(expr), withoutContent, reason: 'without content');
      });
    }
  });

  group('parsed queries', () {
    final cases = <(String, bool)>[
      ('f:alice s:invoice', true),
      ('f:alice -s:invoice', false),
      ('t:bob is:read tag:work', true),
      ('t:(bob -carol)', false),
      ('only:bob', true),
      ('only:(bob,carol)', false),
      ('simple:Invoice', true),
      ('simple:invoice', false),
      ('larger:500 smaller:1M', true),
      ('date:2026-03 a:pdf', true),
      ('h:List-Id', true),
      ('b:"order #123456"', true),
      ('bodyre:/order #\\d{6}/i', true),
      ('is:unread or is:flagged', false),
    ];
    for (final (input, expected) in cases) {
      test(input, () => expect(m(parseQuery(input, now: testNow).expr, c: content), expected));
    }
  });

  group('missing data', () {
    test('attachment names without content: no attachments means no match', () {
      final plain = email.copyWith();
      final noAttachments = EmailSummary(id: '2', accountId: 'a', mailboxId: 'i', receivedAt: plain.receivedAt);
      expect(m(attachment('pdf'), on: noAttachments), isFalse);
      expect(m(attachment('pdf')), isTrue);
    });

    test('unknown size matches either way', () {
      final unsized = EmailSummary(id: '2', accountId: 'a', mailboxId: 'i', receivedAt: DateTime(2026));
      expect(m(larger(1), on: unsized), isTrue);
      expect(m(not(larger(1)), on: unsized), isTrue);
    });

    test('account terms need the label', () {
      const work = AccountTerm('work');
      expect(m(work, account: 'Work <me@work.example>'), isTrue);
      expect(m(work, account: 'Home'), isFalse);
      expect(m(not(work), account: 'Home'), isTrue);
      expect(m(work), isTrue);
      expect(m(not(work)), isTrue);
    });

    test('extra headers', () {
      const received = HeaderTerm('Received', 'mx1');
      expect(m(received, headers: {'received': 'from mx1.example'}), isTrue);
      expect(m(received, headers: {'received': 'from mx2.example'}), isFalse);
      expect(m(received, headers: {'Received': 'from mx1.example'}), isTrue);
      expect(m(received), isTrue);
    });

    test('a text body is preferred over HTML', () {
      const both = EmailContent(emailId: '1', text: 'plain words', html: '<p>html words</p>');
      expect(m(body('plain'), c: both), isTrue);
      expect(m(body('html'), c: both), isFalse);
      const htmlOnly = EmailContent(emailId: '1', text: '  ', html: '<p>html&#32;&#x77;ords &lt;tag&gt;</p>');
      expect(m(body('html words <tag>'), c: htmlOnly), isTrue);
      const empty = EmailContent(emailId: '1');
      expect(m(body('x'), c: empty), isFalse);
    });
  });
}
