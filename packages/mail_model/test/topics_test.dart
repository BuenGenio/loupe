import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

const me = 'sam@home.example';
final _start = DateTime.utc(2026, 8, 1);
var _n = 0;

EmailSummary _mail(
  String subject, {
  required int day,
  String from = 'someone@example.org',
  String? name,
  List<String> to = const [me],
  String? thread,
  Set<String> keywords = const {},
  String? listUnsubscribe,
  String? listId,
}) {
  final n = _n++;
  return EmailSummary(
    id: 'acc|INBOX|1|$n',
    accountId: 'acc',
    mailboxId: 'acc|INBOX',
    threadId: thread ?? 't$n',
    receivedAt: _start.add(Duration(days: day)),
    subject: subject,
    from: [EmailAddress(from, name)],
    to: [for (final t in to) EmailAddress(t)],
    keywords: keywords,
    listUnsubscribe: listUnsubscribe,
    listId: listId,
  );
}

List<TopicSuggestion> _suggest(List<EmailSummary> mail, {Set<String> dismissed = const {}, Set<String> names = const {}}) =>
    suggestTopics(topicThreads(mail, myAddresses: {me}), myAddresses: {me}, dismissed: dismissed, projectNames: names);

void main() {
  test('subjects lose their prefixes; organisations their subdomains', () {
    expect(topicSubject('Re: Fwd: [Atlas] AW: Berth booking'), 'Berth booking');
    expect(organisationDomain('ops@mail.harbourline.com'), 'harbourline.com');
    expect(organisationDomain('a@x.example.co.uk'), 'example.co.uk');
  });

  test('an organisation and a recurring subject word become suggestions; noise does not', () {
    final mail = [
      _mail('Invoice 113', day: 0, from: 'ops@harbourline.com', name: 'Harbourline Ops'),
      _mail('Berth booking', day: 20, from: 'dock@mail.harbourline.com'),
      _mail('Re: meeting notes', day: 40, from: 'ops@harbourline.com'),
      _mail('Your mortgage offer', day: 3, from: 'lender@gmail.com'),
      _mail('Mortgage valuation', day: 12, from: 'surveyor@outlook.com'),
      _mail('Re: mortgage documents', day: 30, from: me, to: ['broker@yahoo.com']),
      // Only twice: not enough.
      _mail('Garden shed', day: 1, from: 'ana@gmail.com'),
      _mail('Garden shed plans', day: 25, from: 'ana@gmail.com'),
      // A newsletter the user never answered.
      for (var d = 0; d < 60; d += 7) _mail('Weekly digest', day: d, from: 'news@shop.example', listUnsubscribe: '<x>'),
      // Filler, so the words above are rare.
      for (var i = 0; i < 12; i++) _mail('Hello number $i', day: i * 3, from: 'p$i@gmail.com'),
    ];
    final topics = _suggest(mail);
    expect([for (final t in topics) (t.key, t.label, t.threads.length)], [
      ('org:harbourline.com', 'Harbourline', 3),
      ('word:mortgage', 'Mortgage', 3),
    ]);
    expect(topics.first.query, 'from:harbourline.com');
    expect(topics.first.threads.first.subject, 'meeting notes', reason: 'newest first, prefix gone');

    expect(_suggest(mail, dismissed: {'org:harbourline.com'}).map((t) => t.key), ['word:mortgage']);
    expect(_suggest(mail, names: {'mortgage'}).map((t) => t.key), ['org:harbourline.com']);
  });

  test('conversations already in a project, or over less than two weeks, are not suggested', () {
    final house = Projects.keyword('house');
    final mail = [
      _mail('Kitchen quote', day: 0, from: 'a@builders.example', keywords: {house}),
      _mail('Kitchen tiles', day: 10, from: 'b@builders.example', keywords: {house}),
      _mail('Kitchen sink', day: 20, from: 'c@builders.example', keywords: {house}),
      _mail('Boat trip', day: 0, from: 'x@sail.example'),
      _mail('Boat trip times', day: 2, from: 'y@sail.example'),
      _mail('Boat trip photos', day: 5, from: 'z@sail.example'),
    ];
    expect(_suggest(mail), isEmpty);
  });

  test('one suggestion that mostly repeats a stronger one is dropped', () {
    final mail = [
      for (var i = 0; i < 4; i++) _mail('Harbourline berth $i', day: i * 10, from: 'ops@harbourline.com'),
      for (var i = 0; i < 20; i++) _mail('Other $i', day: i, from: 'p$i@gmail.com'),
    ];
    // "Harbourline" as a word holds the same conversations as the organisation.
    expect(_suggest(mail).map((t) => t.key), ['org:harbourline.com']);
  });
}
