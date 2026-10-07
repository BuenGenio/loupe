import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/compose/identity_selection.dart';
import 'package:mail_model/mail_model.dart';

MailAccount _account(String id, String email, List<Identity> identities) => MailAccount(
  id: id,
  email: email,
  displayName: id,
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
  identities: identities,
);

/// The owner's setup: a custom domain with a catch-all, and a Gmail account.
final acme = _account('acme', 'alex@acme.example', const [
  Identity(id: 'acme/alex', email: 'alex@acme.example', name: 'Alex', signature: 'E.'),
  Identity(id: 'acme/shop', email: 'shop@acme.example', name: 'Acme Shop'),
  Identity(id: 'acme/lists', email: 'lists@acme.example', replyPatterns: ['*@lists.acme.example']),
]);
final gmail = _account('gmail', 'loupe.test.user@gmail.com', const [
  Identity(id: 'gmail/me', email: 'loupe.test.user@gmail.com', name: 'Alex D'),
  Identity(id: 'gmail/work', email: 'alex@work.example', replyPatterns: ['*@team.example']),
]);
final accounts = [acme, gmail];

EmailSummary _message({
  String account = 'acme',
  String from = 'shop@store.example',
  List<String> to = const [],
  List<String> cc = const [],
}) => EmailSummary(
  id: 'm',
  accountId: account,
  mailboxId: '$account|INBOX',
  receivedAt: DateTime(2026),
  from: [EmailAddress(from)],
  to: [for (final a in to) EmailAddress(a)],
  cc: [for (final a in cc) EmailAddress(a)],
);

typedef _Case = ({
  String name,
  EmailSummary message,
  List<(String, String)> headers,
  String identity,
  IdentityMatch match,
  String? alias,
});

void main() {
  final cases = <_Case>[
    (
      name: 'exact To',
      message: _message(to: ['bob@example.org', 'Shop@Acme.example']),
      headers: const [('Delivered-To', 'alex@acme.example')],
      identity: 'acme/shop',
      match: IdentityMatch.recipient,
      alias: null,
    ),
    (
      name: 'exact Cc beats the envelope',
      message: _message(to: ['team@other.example'], cc: ['shop@acme.example']),
      headers: const [('X-Original-To', 'alex@acme.example')],
      identity: 'acme/shop',
      match: IdentityMatch.recipient,
      alias: null,
    ),
    (
      name: 'my own message keeps its sender',
      message: _message(from: 'shop@acme.example', to: ['bob@example.org']),
      headers: const [],
      identity: 'acme/shop',
      match: IdentityMatch.recipient,
      alias: null,
    ),
    (
      name: 'Delivered-To (Bcc, list)',
      message: _message(to: ['announce@news.example']),
      headers: const [('Delivered-To', '<shop@acme.example>')],
      identity: 'acme/shop',
      match: IdentityMatch.envelope,
      alias: null,
    ),
    (
      name: 'X-Original-To',
      message: _message(to: ['undisclosed-recipients:;']),
      headers: const [('X-Original-To', 'alex@acme.example')],
      identity: 'acme/alex',
      match: IdentityMatch.envelope,
      alias: null,
    ),
    (
      name: 'Envelope-To',
      message: _message(to: ['announce@news.example']),
      headers: const [('Envelope-To', 'lists@acme.example')],
      identity: 'acme/lists',
      match: IdentityMatch.envelope,
      alias: null,
    ),
    (
      name: 'plus-address in To, offered as an alias',
      message: _message(to: ['alex+store@acme.example']),
      headers: const [],
      identity: 'acme/alex',
      match: IdentityMatch.plusAddress,
      alias: 'alex+store@acme.example',
    ),
    (
      name: 'plus-address on a public domain is still mine',
      message: _message(account: 'gmail', to: ['loupe.test.user+Receipts@gmail.com']),
      headers: const [],
      identity: 'gmail/me',
      match: IdentityMatch.plusAddress,
      alias: 'loupe.test.user+receipts@gmail.com',
    ),
    (
      name: 'plus-address in Delivered-To is the server\'s tag, not an alias',
      message: _message(to: ['announce@news.example']),
      headers: const [('Delivered-To', 'alex+catchall@acme.example')],
      identity: 'acme/alex',
      match: IdentityMatch.plusAddress,
      alias: null,
    ),
    (
      name: 'pattern',
      message: _message(to: ['garden@lists.acme.example']),
      headers: const [],
      identity: 'acme/lists',
      match: IdentityMatch.pattern,
      alias: null,
    ),
    (
      name: 'catch-all: unknown alias at my domain, delivered to a plus-address',
      message: _message(to: ['store-17@acme.example']),
      headers: const [('Delivered-To', 'alex+catchall@acme.example'), ('X-Original-To', 'alex@acme.example')],
      identity: 'acme/alex',
      match: IdentityMatch.envelope,
      alias: 'store-17@acme.example',
    ),
    (
      name: 'catch-all without headers: the default, offering the alias',
      message: _message(to: ['store-17@acme.example']),
      headers: const [],
      identity: 'acme/alex',
      match: IdentityMatch.fallback,
      alias: 'store-17@acme.example',
    ),
    (
      name: 'catch-all alias only in X-Original-To',
      message: _message(to: ['announce@news.example']),
      headers: const [('X-Original-To', 'newsletters@acme.example')],
      identity: 'acme/alex',
      match: IdentityMatch.fallback,
      alias: 'newsletters@acme.example',
    ),
    (
      name: 'a colleague at the sender\'s domain is no alias',
      message: _message(from: 'dana@acme.example', to: ['ben@acme.example']),
      headers: const [('Delivered-To', 'alex@acme.example')],
      identity: 'acme/alex',
      match: IdentityMatch.envelope,
      alias: null,
    ),
    (
      name: 'someone else at a public domain is no alias',
      message: _message(account: 'gmail', to: ['friend@gmail.com']),
      headers: const [('Delivered-To', 'loupe.test.user@gmail.com')],
      identity: 'gmail/me',
      match: IdentityMatch.envelope,
      alias: null,
    ),
    (
      name: 'multiple accounts: an identity of another account',
      message: _message(account: 'acme', to: ['loupe.test.user@gmail.com']),
      headers: const [('Delivered-To', 'alex@acme.example')],
      identity: 'gmail/me',
      match: IdentityMatch.recipient,
      alias: null,
    ),
    (
      name: 'multiple accounts: the message\'s own account first',
      message: _message(account: 'gmail', to: ['alex+x@acme.example', 'loupe.test.user+y@gmail.com']),
      headers: const [],
      identity: 'gmail/me',
      match: IdentityMatch.plusAddress,
      alias: 'alex+x@acme.example',
    ),
    (
      name: 'multiple accounts: a pattern of another account',
      message: _message(account: 'acme', to: ['ops@team.example']),
      headers: const [],
      identity: 'gmail/work',
      match: IdentityMatch.pattern,
      alias: null,
    ),
    (
      name: 'nothing matches: the default of the message\'s account',
      message: _message(account: 'gmail', to: ['someone@else.example']),
      headers: const [],
      identity: 'gmail/me',
      match: IdentityMatch.fallback,
      alias: null,
    ),
  ];

  group('choosing the identity of a reply', () {
    for (final c in cases) {
      test(c.name, () {
        final choice = IdentitySelection.choose(accounts: accounts, source: c.message, headers: c.headers)!;
        expect(choice.identity.id, c.identity);
        expect(choice.account.id, c.identity.split('/').first);
        expect(choice.match, c.match);
        expect(choice.alias?.email, c.alias);
      });
    }
  });

  test('an alias takes the default identity\'s name and signature of its account', () {
    final choice = IdentitySelection.choose(
      accounts: accounts,
      source: _message(to: ['store-17@acme.example']),
    )!;
    expect(choice.aliasAccount, acme);
    expect(choice.alias!.name, 'Alex');
    expect(choice.alias!.signature, 'E.');
    expect(acme.isAliasIdentity(choice.alias!), isTrue);
    expect(choice.suggestsAlias, isTrue);
  });

  test('the multiple-accounts alias belongs to the account owning its address', () {
    final choice = IdentitySelection.choose(
      accounts: accounts,
      source: _message(account: 'gmail', to: ['alex+x@acme.example', 'loupe.test.user+y@gmail.com']),
    )!;
    expect(choice.aliasAccount, acme);
  });

  test('a pattern match offers the alias only in the picker', () {
    final withPattern = _account('p', 'me@p.example', const [
      Identity(id: 'p/me', email: 'me@p.example', replyPatterns: ['*@p.example']),
    ]);
    final choice = IdentitySelection.choose(
      accounts: [withPattern],
      source: _message(account: 'p', to: ['x@p.example']),
    )!;
    expect(choice.match, IdentityMatch.pattern);
    expect(choice.alias?.email, 'x@p.example');
    expect(choice.suggestsAlias, isFalse);
  });

  test('no accounts, no choice; an account without identities uses its address', () {
    expect(IdentitySelection.choose(accounts: const [], source: _message()), isNull);
    final bare = _account('bare', 'me@bare.example', const []);
    final choice = IdentitySelection.choose(
      accounts: [bare],
      source: _message(account: 'bare', to: ['me@bare.example']),
    )!;
    expect(choice.identity.email, 'me@bare.example');
    expect(choice.match, IdentityMatch.recipient);
  });

  test('patterns', () {
    expect(IdentitySelection.normalizePattern(' *@Acme.example '), '*@acme.example');
    expect(IdentitySelection.normalizePattern('@acme.example'), '*@acme.example');
    expect(IdentitySelection.normalizePattern('acme.example'), '*@acme.example');
    expect(IdentitySelection.normalizePattern('alex+*@acme.example'), 'alex+*@acme.example');
    expect(IdentitySelection.normalizePattern(''), isNull);
    expect(IdentitySelection.normalizePattern('not a pattern'), isNull);
    expect(IdentitySelection.normalizePattern('me@localhost'), isNull);
    expect(IdentitySelection.matchesPattern('*@acme.example', 'X@ACME.example'), isTrue);
    expect(IdentitySelection.matchesPattern('*@acme.example', 'x@sub.acme.example'), isFalse);
    expect(IdentitySelection.matchesPattern('alex+*@acme.example', 'alex+shop@acme.example'), isTrue);
    expect(IdentitySelection.matchesPattern('alex+*@acme.example', 'alex@acme.example'), isFalse);
    expect(IdentitySelection.matchesPattern('a.b@x.example', 'axb@x.example'), isFalse, reason: 'dots are literal');
  });

  test('envelope addresses and plus-addresses', () {
    expect(
      IdentitySelection.envelopeAddresses(const [
        ('Received', 'from x by y for <nope@acme.example>'),
        ('Delivered-To', 'Alex+Catchall@acme.example'),
        ('x-original-to', '<shop@acme.example>'),
      ]),
      ['alex+catchall@acme.example', 'shop@acme.example'],
    );
    expect(IdentitySelection.stripPlus('A+b+c@X.example'), 'a@x.example');
    expect(IdentitySelection.stripPlus('+a@x.example'), '+a@x.example');
    expect(IdentitySelection.isPlusAddressOf('me+tag@x.example', 'Me@x.example'), isTrue);
    expect(IdentitySelection.isPlusAddressOf('me@x.example', 'me@x.example'), isFalse);
  });

  test('owned domains leave out public ones and pattern domains', () {
    expect(IdentitySelection.ownedDomains(acme), {'acme.example'});
    expect(IdentitySelection.ownedDomains(gmail), {'work.example'});
  });
}
