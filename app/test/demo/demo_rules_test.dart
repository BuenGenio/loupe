import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/demo/demo_rules.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime(2026, 10, 4, 16);
  late DemoMailRepository repo;

  setUp(() => repo = DemoMailRepository.instant(clock: () => now));
  tearDown(() => repo.dispose());

  Future<List<EmailSummary>> inbox(String account) async => [
    for (final t in await repo.watchList(RealMailboxRef(MailIds.mailbox(account, 'INBOX')), threaded: false).first)
      t.latest,
  ];

  test('starts with rules for each kind of account', () async {
    final rules = await repo.rules.watchRules().first;
    expect(
      [for (final r in rules) (r.name, r.location)],
      [
        ('Issue tracker', RuleLocation.device),
        ('Receipts', RuleLocation.device),
        ('Open Garden list', RuleLocation.server),
      ],
    );
  });

  test('device rules act on arriving mail, after the server rules of serving accounts', () async {
    final mail = (await inbox(DemoAccounts.work)).firstWhere((e) => !e.isFlagged);
    await repo.rules.saveRule(
      Rule(id: 'flag', name: 'Flag', condition: 'from:${mail.from.first.email}', actions: const [FlagAction()]),
    );
    await repo.rules.runOnArrivals([mail]);
    expect((await repo.getEmail(mail.id))!.isFlagged, isTrue);

    // Fastmail's server rules apply to its arrivals once its server runs them.
    final list = (await inbox(DemoAccounts.fastmail)).first;
    await repo.rules.saveRule(
      Rule(
        id: 'server',
        name: 'Server',
        condition: 's:"${list.subject}"',
        actions: [MoveToMailboxAction(MailIds.mailbox(DemoAccounts.fastmail, 'Lists'))],
        accountIds: const {DemoAccounts.fastmail},
        location: RuleLocation.server,
      ),
    );
    await repo.rules.runOnArrivals([list]);
    expect((await repo.getEmail(list.id))!.mailboxId, MailIds.mailbox(DemoAccounts.fastmail, 'INBOX'));
    await repo.rules.applyInclude((await repo.rules.proposeInclude(DemoAccounts.fastmail))!);
    await repo.rules.runOnArrivals([list]);
    expect((await repo.getEmail(list.id))!.mailboxId, MailIds.mailbox(DemoAccounts.fastmail, 'Lists'));
  });

  test('Gmail has no server rules; Fastmail’s own script stays active until Loupe is included', () async {
    final gmail = await repo.rules.serverStatus(DemoAccounts.personal);
    expect(gmail.state, ServerRulesState.unavailable);
    expect(gmail.message, contains('Gmail'));

    var status = await repo.rules.serverStatus(DemoAccounts.fastmail, refresh: true);
    expect((status.state, status.activeScript), (ServerRulesState.inactive, 'filters'));
    final proposal = (await repo.rules.proposeInclude(DemoAccounts.fastmail))!;
    expect(proposal.before, demoFiltersScript);
    expect(proposal.addedLines.last, 'include :personal "loupe";');
    await repo.rules.applyInclude(proposal);
    status = await repo.rules.serverStatus(DemoAccounts.fastmail);
    expect((status.state, status.viaInclude), (ServerRulesState.active, true));
    expect(repo.rules.servers[DemoAccounts.fastmail].active, 'filters');
  });

  test('saving a server rule installs it; Gmail refuses one', () async {
    final rule = Rule(
      id: 'new',
      name: 'Felix',
      condition: 'from:brandt.example',
      actions: const [FlagAction()],
      accountIds: const {DemoAccounts.fastmail},
      location: RuleLocation.server,
    );
    await repo.rules.saveRule(rule);
    final script = repo.rules.servers[DemoAccounts.fastmail].scripts[loupeScriptName]!;
    expect([for (final r in parseLoupeScript(script)) r.id], ['demo-open-garden', 'new']);
    await expectLater(
      repo.rules.saveRule(rule.copyWith(accountIds: {DemoAccounts.personal})),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('Gmail'))),
    );
    final previews = await repo.rules.previewServerRule(rule.copyWith(condition: 'is:unread'));
    expect(previews.single.problems.single, contains('Unread'));
  });

  test('apply to existing messages moves what matches', () async {
    final rule = (await repo.rules.watchRules().first).firstWhere((r) => r.name == 'Receipts');
    final matches = await repo.rules.findMatches(rule, const AllMailboxesScope());
    expect(matches, isNotEmpty);
    expect(matches.every((e) => e.accountId == DemoAccounts.personal), isTrue);
    final moved = await repo.rules.applyRule(rule, [for (final e in matches) e.id]);
    expect(moved, matches.length);
    for (final e in matches) {
      expect((await repo.getEmail(e.id))!.mailboxId, MailIds.mailbox(DemoAccounts.personal, 'Receipts'));
    }
  });
}
