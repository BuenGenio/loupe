// The language examples from the desktop add-on's documentation, written
// as test vectors for this package.
import 'package:mail_model/mail_model.dart';

import 'terms.dart';

/// Each language example from the desktop add-on's documentation, as this
/// package reads it. Desktop-only features are marked with their mobile
/// meaning.
final helpExamples = <(String, SearchExpr)>[
  // Quick start
  ('weekend plans', any('weekend plans')),
  ('from:fred to:tom a:yes', and([from('fred'), toOrCc('tom'), hasAttachment])),
  ('f:fred t:tom a:yes', and([from('fred'), toOrCc('tom'), hasAttachment])),
  (
    's:invoice t:(alice -bob)',
    and([
      subject('invoice'),
      and([toOrCc('alice'), not(toOrCc('bob'))]),
    ]),
  ),
  (
    'f:(amazon or ebay) older_than:1y',
    and([
      or([from('amazon'), from('ebay')]),
      before(2025, 10, 4),
    ]),
  ),
  // Operator table
  ('from:mike', from('mike')),
  ('t:bill', toOrCc('bill')),
  ('tn:bill', toOnly('bill')),
  ('cc:tom', cc('tom')),
  ('bcc:riddle', bcc('riddle')),
  ('acc:work', const AccountTerm('work')),
  ('-acc:private', not(const AccountTerm('private'))),
  ('ft:tom', participants('tom')),
  ('only:tom', and([toOnly('tom'), not(re(TextField.to, '^(?!.*(?:tom))'))])),
  ('only:(tom,jerry)', and([toOnly('tom'), toOnly('jerry'), not(re(TextField.to, '^(?!.*(?:tom|jerry))'))])),
  ('s:electric bill', subject('electric bill')),
  (
    'simple:Re: (urgent) - call me',
    and([subject('Re: (urgent) - call me'), re(TextField.subject, RegExp.escape('Re: (urgent) - call me'), cs: true)]),
  ),
  (r're:/^\[jira\]/i', re(TextField.subject, r'^\[jira\]')),
  ('b:tracking number', body('tracking number')),
  (r'bodyre:/order #\d{6}/i', re(TextField.body, r'order #\d{6}')),
  ('all:weekend plans', any('weekend plans')),
  (r'fr:/@example\.(com|org)>$/', re(TextField.from, r'@example\.(com|org)>$', cs: true)),
  ('tr:^team-', re(TextField.recipients, '^team-')),
  ('h:list-id', const HeaderTerm('list-id', '')),
  ('h:List-Id=/all-test/i', const HeaderTerm('List-Id', 'all-test')),
  ('a:yes', hasAttachment),
  ('a:pdf', attachment('pdf')),
  ('fi:invoice.pdf', attachment('invoice.pdf')),
  ('fn:msword', attachment('msword')),
  ('is:unread', unread),
  ('is:unreplied', not(kw(Keywords.answered))),
  ('tag:important', kw(Keywords.label1)),
  ('tag:na', and([for (final t in TagDefinition.thunderbirdDefaults) not(kw(t.keyword))])),
  ('af:2024/03/01', since(2024, 3, 2)),
  ('d:2024/03', and([since(2024, 3, 1), before(2024, 4, 1)])),
  ('older_than:2w', before(2026, 9, 20)),
  ('days:(3 -5)', and([before(2026, 10, 1), not(before(2026, 9, 29))])),
  ('n:7', since(2026, 9, 28)),
  ('nt:1y', since(2025, 10, 5)),
  ('size:500', larger(500 * kb)),
  ('si:(0.5M -2M)', and([larger(mb ~/ 2), not(larger(2 * mb))])),
  ('sm:10', smaller(10 * kb)),
  ('g:weather', any('weather')),
  // Dates in the text
  ('af:(2024/03/01 -2024/03/09)', and([since(2024, 3, 2), not(since(2024, 3, 10))])),
  ('be:"2024-03-01 14:30"', before(2024, 3, 1)),
  ('be:"Mon, 25 Dec 1995 13:30:00 GMT"', before(1995, 12, 25)),
  // Combining
  ('f:bob s:report', and([from('bob'), subject('report')])),
  ('f:bob and s:report', and([from('bob'), subject('report')])),
  ('f:bob or f:dave', or([from('bob'), from('dave')])),
  ('-f:spam', not(from('spam'))),
  ('f:-spam', not(from('spam'))),
  ('-(s:a or s:b)', not(or([subject('a'), subject('b')]))),
  ('t:(alice or bob)', or([toOrCc('alice'), toOrCc('bob')])),
  ('f:(-foo -bar)', and([not(from('foo')), not(from('bar'))])),
  ('s:"this or that"', subject('this or that')),
  // Operators are lower case, so subjects like "Re: …" stay text.
  ('Re: lunch', any('Re: lunch')),
  // The desktop calculator is not supported; arithmetic is plain text.
  ('3*(4+5)', and([any('3*'), any('4+5')])),
];

/// Examples whose desktop meaning (time of day, partial date text) has no
/// mobile equivalent: they report an error and match everything.
final unsupportedExamples = ['af:(9:00 -17:00)', 'af:9:00', 'd:" 13:"'];
