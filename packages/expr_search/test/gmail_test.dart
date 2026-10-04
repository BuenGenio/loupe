import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

import 'support/generators.dart';
import 'support/terms.dart';

String? g(String input) => compileGmailRaw(parseQuery(input, now: testNow).expr);

void main() {
  group('compileGmailRaw', () {
    final cases = <(String, String)>[
      ('', ''),
      ('f:alice', 'from:alice'),
      ('f:alice@example.com', 'from:alice@example.com'),
      ('f:"alice smith"', 'from:"alice smith"'),
      ('tn:bob', 'to:bob'),
      ('t:bob', 'to:bob OR cc:bob'),
      ('cc:x', 'cc:x'),
      ('bcc:x', 'bcc:x'),
      ('s:"electric bill"', 'subject:"electric bill"'),
      ('s:Grüße', 'subject:Grüße'),
      ('invoice', 'invoice'),
      ('-invoice', '-invoice'),
      ('"weekend plans"', '"weekend plans"'),
      ('b:tracking', 'tracking'),
      ('f:a s:b', 'from:a subject:b'),
      ('f:a or s:b', 'from:a OR subject:b'),
      ('f:a (s:b or s:c)', 'from:a (subject:b OR subject:c)'),
      ('(f:a s:b) or s:c', '(from:a subject:b) OR subject:c'),
      ('-(f:a or s:b)', '-from:a -subject:b'),
      ('-(f:a s:b)', '-from:a OR -subject:b'),
      ('-f:a', '-from:a'),
      ('is:unread', 'is:unread'),
      ('is:read', 'is:read'),
      ('-is:unread', 'is:read'),
      ('is:flagged', 'is:starred'),
      ('-is:flagged', '-is:starred'),
      ('a:yes', 'has:attachment'),
      ('a:no', '-has:attachment'),
      ('a:pdf', 'filename:pdf'),
      ('fi:"my file.pdf"', 'filename:"my file.pdf"'),
      ('before:2026-03-01', 'before:2026/03/01'),
      ('after:2026-02-28', 'after:2026/03/01'),
      ('-after:2026-02-28', 'before:2026/03/01'),
      ('date:2026-03-05', 'after:2026/03/05 before:2026/03/06'),
      ('-date:2026-03-05', 'before:2026/03/05 OR after:2026/03/06'),
      ('date:2026-12-31 or f:a', '(after:2026/12/31 before:2027/01/01) OR from:a'),
      ('larger:2M', 'larger:2097152'),
      ('smaller:10', 'smaller:10240'),
      ('-larger:1K', '-larger:1024'),
      ('recipients:x', 'to:x OR cc:x OR bcc:x'),
      ('-recipients:x', '-to:x -cc:x -bcc:x'),
      ('f:a recipients:x', 'from:a (to:x OR cc:x OR bcc:x)'),
      ('ft:x', 'from:x OR to:x OR cc:x OR bcc:x'),
      ('header:"List-Id=dev.example.com"', 'list:dev.example.com'),
      ('"OR"', '"OR"'),
      ('"-x"', '"-x"'),
      ('f:(x)', 'from:x'),
      ('"a(b)"', '"a(b)"'),
    ];
    for (final (input, expected) in cases) {
      test(input.isEmpty ? '(empty)' : input, () => expect(g(input), expected));
    }

    for (final input in [
      're:/x/',
      'f:a re:/x/',
      'acc:work',
      'h:X-Mailer',
      'h:List-Id',
      'is:replied',
      'is:draft',
      'tag:work',
      r'f:"say \"hi\""',
      'f:""',
      'only:tom',
      'simple:x',
    ]) {
      test('$input → null', () => expect(g(input), isNull));
    }

    test('nothing can not be expressed', () => expect(compileGmailRaw(const SearchNot(MatchAll())), isNull));

    test('widening first always gives a query', () {
      expect(compileGmailRaw(widenForServer(parseQuery('f:a re:/x/').expr, gmailSupports)), 'from:a');
      expect(compileGmailRaw(widenForServer(parseQuery('f:a or re:/x/').expr, gmailSupports)), '');
      final gen = ExprGen(21);
      for (var i = 0; i < 500; i++) {
        final e = gen.root();
        final direct = compileGmailRaw(e);
        final widened = compileGmailRaw(widenForServer(e, gmailSupports));
        expect(widened, isNotNull, reason: '$e');
        if (direct != null) expect(widened, direct, reason: '$e');
      }
    });

    test('gmailSupports', () {
      expect(gmailSupports(from('a')), isTrue);
      expect(gmailSupports(read), isTrue);
      expect(gmailSupports(kw(Keywords.answered)), isFalse);
      expect(gmailSupports(re(TextField.subject, 'x')), isFalse);
      expect(gmailSupports(const AccountTerm('x')), isFalse);
      expect(gmailSupports(subject('')), isFalse);
    });
  });
}
