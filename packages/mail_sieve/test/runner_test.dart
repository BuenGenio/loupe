import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

Mailbox _box(String account, String path, [MailboxRole role = MailboxRole.none]) =>
    Mailbox(id: MailIds.mailbox(account, path), accountId: account, name: path, path: path, role: role);

final _mailboxes = [
  _box('a', 'INBOX', MailboxRole.inbox),
  _box('a', 'Lists'),
  _box('b', 'INBOX', MailboxRole.inbox),
  _box('b', 'Lists'),
  _box('a', 'Receipts'),
];

EmailSummary _mail({
  String account = 'a',
  String from = 'ann@lists.example',
  String subject = 'Hi',
  Set<String> keywords = const {},
}) => EmailSummary(
  id: '$account|INBOX|1|1',
  accountId: account,
  mailboxId: MailIds.mailbox(account, 'INBOX'),
  receivedAt: DateTime(2026, 10, 1),
  from: [EmailAddress(from)],
  subject: subject,
  preview: 'short preview',
  size: 2048,
  keywords: keywords,
);

Rule _rule(
  String id,
  String condition,
  List<RuleAction> actions, {
  int order = 0,
  bool stop = false,
  Set<String> accounts = const {},
}) => Rule(
  id: id,
  name: id,
  condition: condition,
  actions: actions,
  order: order,
  stopProcessing: stop,
  accountIds: accounts,
);

void main() {
  Future<(RuleOutcome, int)> run(List<Rule> rules, EmailSummary email, {EmailContent? content}) async {
    var loads = 0;
    final out = await RuleRunner(rules, mailboxes: _mailboxes, now: DateTime(2026, 10, 4)).run(
      email,
      accountLabel: 'Work ${email.accountId}@example.org',
      loadContent: () async {
        loads++;
        return content;
      },
    );
    return (out, loads);
  }

  test('rules run in order; later rules see earlier tags; stop ends the run', () async {
    final rules = [
      _rule('tagger', 'from:lists.example', [const AddTagAction(r'$label2')], order: 0),
      _rule('mover', 'tag:work', [MoveToMailboxAction(MailIds.mailbox('a', 'Lists'))], order: 1, stop: true),
      _rule('never', '', [const FlagAction()], order: 2),
    ];
    final (out, loads) = await run(rules.reversed.toList(), _mail());
    expect(out.matched, ['tagger', 'mover']);
    expect(out.add, {r'$label2'});
    expect(out.moveTo, MailIds.mailbox('a', 'Lists'));
    expect(loads, 0);
  });

  test('content is loaded once, only when a condition needs it', () async {
    final content = const EmailContent(emailId: 'x', text: 'Your tracking number is 42');
    final rules = [
      _rule('subject', 's:hello', [const FlagAction()]),
      _rule('body1', 'b:"tracking number"', [const MarkReadAction()], order: 1),
      _rule('body2', 'b:missing', [const AddTagAction('x')], order: 2),
    ];
    final (out, loads) = await run(rules, _mail(subject: 'Hello there'), content: content);
    expect(out.matched, ['subject', 'body1']);
    expect(out.add, {Keywords.flagged, Keywords.seen});
    expect(loads, 1);

    // A body term decided by the preview needs nothing more, nor does a
    // message another term already rules out.
    final (_, none) = await run([
      _rule('p', 'b:preview', [const FlagAction()]),
      _rule('q', 's:nope b:x', []),
    ], _mail());
    expect(none, 0);
  });

  test('an undecidable condition never acts', () async {
    final (out, loads) = await run([
      _rule('b', 'b:secret', [const FlagAction()]),
    ], _mail());
    expect(loads, 1);
    expect(out.matched, isEmpty);
    expect(out.hasActions, isFalse);
  });

  test('accounts: rule scope, account terms, and the same folder in another account', () async {
    final rule = _rule('lists', 'from:lists.example', [MoveToMailboxAction(MailIds.mailbox('a', 'Lists'))]);
    final (inB, _) = await run([rule], _mail(account: 'b'));
    expect(inB.moveTo, MailIds.mailbox('b', 'Lists'));
    final receipts = _rule('r', '', [MoveToMailboxAction(MailIds.mailbox('a', 'Receipts'))]);
    final (noFolder, _) = await run([receipts], _mail(account: 'b'));
    expect(noFolder.matched, ['r']);
    expect(noFolder.moveTo, isNull);
    final (scoped, _) = await run([
      rule.copyWith(accountIds: {'a'}),
    ], _mail(account: 'b'));
    expect(scoped.matched, isEmpty);
    final (byLabel, _) = await run([
      _rule('acc', 'acc:b@example', [const FlagAction()]),
    ], _mail(account: 'b'));
    expect(byLabel.matched, ['acc']);
  });

  test('junk replaces moves, keep cancels them and stops, first move wins, tags toggle', () async {
    final lists = MoveToMailboxAction(MailIds.mailbox('a', 'Lists'));
    final receipts = MoveToMailboxAction(MailIds.mailbox('a', 'Receipts'));
    var (out, _) = await run([
      _rule('1', '', [lists, receipts, const AddTagAction('x'), const RemoveTagAction('X')]),
    ], _mail());
    expect(out.moveTo, lists.mailboxId);
    expect(out.add, isEmpty);
    expect(out.remove, {'x'});
    (out, _) = await run([
      _rule('1', '', [lists, const MarkJunkAction()]),
    ], _mail());
    expect((out.junk, out.moveTo), (true, null));
    (out, _) = await run([
      _rule('1', '', [lists]),
      _rule('2', '', [const KeepInInboxAction()], order: 1),
      _rule('3', '', [const FlagAction()], order: 2),
    ], _mail());
    expect(out.moveTo, isNull);
    expect(out.matched, ['1', '2']);
  });

  test('rules that are off, server rules and broken conditions don’t run', () async {
    final rules = [
      _rule('off', '', [const FlagAction()]).copyWith(enabled: false),
      _rule('server', '', [const FlagAction()]).copyWith(location: RuleLocation.server),
      _rule('broken', 'before:notadate', [const FlagAction()]),
    ];
    expect(RuleRunner(rules).isEmpty, isTrue);
  });

  test('decideMatch is three-valued', () {
    final email = _mail();
    expect(decideMatch(const TextTerm(SearchField.subject, 'hi'), email), isTrue);
    expect(decideMatch(const TextTerm(SearchField.subject, 'zz'), email), isFalse);
    expect(decideMatch(const TextTerm(SearchField.body, 'zz'), email), isNull);
    expect(decideMatch(const SearchNot(TextTerm(SearchField.body, 'zz')), email), isNull);
  });
}
