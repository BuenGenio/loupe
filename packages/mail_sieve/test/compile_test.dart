import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

final _now = DateTime(2026, 10, 4, 12);

SieveTest _compile(String query, {Set<String>? extensions}) =>
    compileSieve(parseQuery(query, now: _now).expr, extensions: extensions);

void main() {
  group('compileSieve compiles exactly', () {
    // query → (test, requires)
    final table = <String, (String, Set<String>)>{
      'from:alice@example.com': ('address :all :is "from" "alice@example.com"', {}),
      'from:@example.com': ('address :domain :is "from" "example.com"', {}),
      'from:example.com': ('address :all :contains "from" "example.com"', {}),
      'from:"Alice Smith"': ('header :contains "from" "Alice Smith"', {}),
      'from:alice': ('header :contains "from" "alice"', {}),
      'tn:bob': ('header :contains "to" "bob"', {}),
      'to:bob': ('anyof(header :contains "to" "bob", header :contains "cc" "bob")', {}),
      'cc:carol bcc:dave': ('allof(header :contains "cc" "carol", header :contains "bcc" "dave")', {}),
      'recipients:team@x.org': ('address :all :is ["to", "cc", "bcc"] "team@x.org"', {}),
      'ft:tom': ('header :contains ["from", "to", "cc", "bcc"] "tom"', {}),
      's:invoice': ('header :contains "subject" "invoice"', {}),
      r's:"say \"hi\" \\ bye"': (r'header :contains "subject" "say \"hi\" \\ bye"', {}),
      'b:"tracking number"': ('body :text :contains "tracking number"', {'body'}),
      'weekend': (
        'anyof(header :contains ["from", "to", "cc", "subject"] "weekend", body :text :contains "weekend")',
        {'body'},
      ),
      'header:"List-Id=dev"': ('header :contains "List-Id" "dev"', {}),
      'h:List-Id': ('exists "List-Id"', {}),
      '-h:List-Id': ('not exists "List-Id"', {}),
      'larger:2M': ('size :over 2097152', {}),
      'smaller:500': ('size :under 512000', {}),
      r're:/^\[jira\]/i': (r'header :regex "subject" "^\\[jira\\]"', {'regex'}),
      r'fr:/^Alice/': (r'header :regex :comparator "i;octet" "from" "^Alice"', {'regex'}),
      'br:invoice [0-9]+': ('body :text :regex "invoice [0-9]+"', {'body', 'regex'}),
      'tag:work': (r'hasflag "$label2"', {'imap4flags'}),
      'is:flagged': (r'hasflag "\\Flagged"', {'imap4flags'}),
      '-tag:work': (r'not hasflag "$label2"', {'imap4flags'}),
      'has:attachment': ('header :mime :anychild :contains "Content-Disposition" "attachment"', {'mime'}),
      'after:2026-02-28': ('currentdate :value "ge" "date" "2026-03-01"', {'date', 'relational'}),
      'before:2027-01-01': ('currentdate :value "lt" "date" "2027-01-01"', {'date', 'relational'}),
      'date:2026-12-24': ('currentdate :is "date" "2026-12-24"', {'date'}),
      'f:alice or f:bob': ('anyof(header :contains "from" "alice", header :contains "from" "bob")', {}),
      '-(f:alice s:x)': ('not allof(header :contains "from" "alice", header :contains "subject" "x")', {}),
      '': ('true', {}),
    };
    for (final MapEntry(key: query, value: (expected, requires)) in table.entries) {
      test(query.isEmpty ? '(empty)' : query, () {
        final r = _compile(query);
        expect(r.problems, isEmpty);
        expect(r.test, expected);
        expect(r.requires, requires);
        expect(r.ok, isTrue);
      });
    }

    test('long groups are split over lines', () {
      final r = _compile('from:alice@example.com s:"quarterly report" b:"see attached" larger:1M');
      expect(r.test, '''
allof(
  address :all :is "from" "alice@example.com",
  header :contains "subject" "quarterly report",
  body :text :contains "see attached",
  size :over 1048576
)''');
    });

    test('attachment names look at every MIME part', () {
      final r = _compile('fi:pdf');
      expect(r.test, contains('header :mime :anychild :param "filename" :contains "Content-Disposition" "pdf"'));
      expect(r.test, contains(':contenttype :contains "Content-Type" "pdf"'));
      expect(r.requires, {'mime'});
    });
  });

  group('compileSieve reports what it can’t do', () {
    final table = <String, String>{
      'is:unread': '“Unread”: new mail has no read, replied or junk state when it arrives',
      'is:replied': 'new mail has no read, replied or junk state',
      'acc:work': '“Account: work”: a server only sees its own account’s mail',
      'older_than:7d': 'dates relative to today change every day',
      r'tr:/^(?!.*tom)/': 'look-arounds',
      r're:/\d{4}/': r'shorthands like \d',
    };
    for (final MapEntry(key: query, value: message) in table.entries) {
      test(query, () {
        final expr = parseQuery(query, now: _now).expr;
        // Relative dates are those that change with "now".
        final shifted = parseQuery(query, now: _now.add(const Duration(days: 40))).expr;
        final r = compileSieve(expr, isRelativeDate: (_) => expr != shifted);
        expect(r.ok, isFalse);
        expect(r.test, isNull);
        expect(r.problems.map((p) => p.message).join('\n'), contains(message));
      });
    }

    test('missing extensions are named, every problem is listed', () {
      final r = _compile('b:x and re:/y/ and tag:work and has:attachment and s:fine', extensions: {'fileinto'});
      final messages = r.problems.map((p) => p.message).toList();
      expect(messages, hasLength(4));
      expect(messages[0], contains('no body extension'));
      expect(messages[1], contains('no regex extension'));
      expect(messages[2], contains('no imap4flags extension'));
      expect(messages[3], contains('no mime extension'));
      expect(r.requires, isEmpty);
    });

    test('a server with the extensions compiles the same query', () {
      final r = _compile('b:x and tag:work', extensions: {'body', 'imap4flags', 'fileinto'});
      expect(r.ok, isTrue);
      expect(r.requires, {'body', 'imap4flags'});
    });

    test('problems point at their terms', () {
      final r = _compile('s:ok -is:read');
      expect(r.problems.single.term, const SearchNot(KeywordTerm(Keywords.seen)));
    });
  });

  test('posixIssue accepts POSIX ERE and names Perl-only syntax', () {
    expect(posixIssue(r'^\[jira\] (bug|task)+ [a-z]{2,3}$'), isNull);
    expect(posixIssue(r'a\sb'), contains(r'\s'));
    expect(posixIssue(r'(a)\1'), 'back-references');
    expect(posixIssue('a+?'), 'lazy quantifiers');
    expect(posixIssue('(?:a)'), contains('groups'));
  });
}
