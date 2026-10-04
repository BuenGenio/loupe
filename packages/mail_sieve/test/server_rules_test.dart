import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

const _account = MailAccount(
  id: 'a',
  email: 'me@example.org',
  displayName: 'Mailcow',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'mail.example.org', port: 993),
);

void main() {
  late SimulatedSieveServers servers;
  late List<Rule> rules;
  late ServerRules server;
  final errors = <MailException>[];

  setUp(() {
    servers = SimulatedSieveServers();
    rules = [];
    errors.clear();
    server = ServerRules(
      connector: servers,
      accounts: () async => [_account],
      mailboxes: () async => const [],
      rules: () async => rules,
      importRules: (found) async => rules.addAll(found),
      credentials: (_) =>
          ({bool forceRefresh = false}) async => const PasswordCredentials('x'),
      now: () => DateTime(2026, 10, 4),
      reportError: errors.add,
    );
  });

  const rule = Rule(
    id: 'r',
    name: 'Boss',
    condition: 'from:boss@example.org',
    actions: [FlagAction()],
    location: RuleLocation.server,
  );

  test('the first server rule makes Loupe’s script the active one', () async {
    rules = withRule(rules, rule);
    await server.install(rule, next: rules);
    expect(servers['a'].active, loupeScriptName);
    expect((await server.status('a')).state, ServerRulesState.active);
  });

  test('a server without include can’t take Loupe’s rules next to another script', () async {
    servers['a']
      ..extensions = {'fileinto', 'imap4flags'}
      ..scripts['sogo'] = 'keep;'
      ..active = 'sogo';
    rules = withRule(rules, rule);
    await server.install(rule, next: rules);
    expect(servers['a'].active, 'sogo');
    await expectLater(
      server.proposeInclude('a'),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('no Sieve include extension'))),
    );
  });

  test('a quota that is full is said so before uploading', () async {
    servers['a'].quota = 10;
    rules = withRule(rules, rule);
    await expectLater(
      server.install(rule, next: rules),
      throwsA(isA<MailException>().having((e) => e.message, 'message', contains('quota'))),
    );
    expect(servers['a'].scripts, isEmpty);
  });

  test('server errors come back with the server’s words', () async {
    servers['a'].extensions = {'fileinto', 'imap4flags', 'body'};
    // A script the checker rejects: a rule needing an extension the server
    // dropped after Loupe last asked.
    final s = await servers.connect(_account, ({bool forceRefresh = false}) async => const PasswordCredentials('x'));
    await expectLater(
      s.checkScript('require "regex";'),
      throwsA(isA<SieveException>().having((e) => e.message, 'message', contains("unknown Sieve capability 'regex'"))),
    );
  });

  test('withRule replaces in place or appends', () {
    final a = rule.copyWith(order: 0);
    final b = const Rule(id: 'b', name: 'b', condition: '').copyWith(order: 1);
    expect(
      [
        for (final r in withRule([a, b], rule.copyWith(name: 'x'))) (r.id, r.order),
      ],
      [('r', 0), ('b', 1)],
    );
    expect(
      [
        for (final r in withRule([a], b.copyWith(order: 9))) (r.id, r.order),
      ],
      [('r', 0), ('b', 1)],
    );
  });
}
