import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

const _account = MailAccount(
  id: 'acc',
  email: 'eugene@anthill.example',
  displayName: 'Anthill',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.anthill.example', port: 993),
  identities: [
    Identity(
      id: 'acc/default',
      email: 'eugene@anthill.example',
      name: 'Eugene',
      signature: 'E.',
      replyTo: 'replies@anthill.example',
      autoBcc: 'archive@anthill.example',
    ),
    Identity(id: 'acc/shop', email: 'shop@anthill.example', name: 'Anthill Shop'),
  ],
);

void main() {
  test('identities round-trip through JSON, new fields included', () {
    const identity = Identity(
      id: 'acc/x',
      email: 'x@anthill.example',
      name: 'X',
      signature: 'Sig',
      replyTo: 'r@anthill.example',
      autoCc: 'cc@anthill.example',
      autoBcc: 'bcc@anthill.example',
      replyPatterns: ['*@anthill.example', 'x+*@anthill.example'],
    );
    final back = Identity.fromJson(identity.toJson());
    expect(back.autoCc, 'cc@anthill.example');
    expect(back.autoBcc, 'bcc@anthill.example');
    expect(back.replyPatterns, ['*@anthill.example', 'x+*@anthill.example']);
    expect(back.replyTo, 'r@anthill.example');
  });

  test('identities saved before the new fields still load', () {
    final old = Identity.fromJson(const {'id': 'a', 'email': 'a@b.example', 'name': null, 'signature': null});
    expect(old.replyPatterns, isEmpty);
    expect(old.autoCc, isNull);
    final account = MailAccount.fromJson(_account.toJson());
    expect(account.identities.first.autoBcc, 'archive@anthill.example');
  });

  test('alias identities take the default name and signature and survive by id', () {
    final alias = _account.aliasIdentity('shop-xyz@anthill.example');
    expect(alias.email, 'shop-xyz@anthill.example');
    expect(alias.name, 'Eugene');
    expect(alias.signature, 'E.');
    expect(alias.replyTo, isNull, reason: 'replies come back to the alias');
    expect(alias.autoBcc, isNull);
    expect(_account.isAliasIdentity(alias), isTrue);
    expect(_account.isAliasIdentity(_account.defaultIdentity), isFalse);

    final back = _account.identityById(alias.id);
    expect(back.email, 'shop-xyz@anthill.example');
    expect(back.id, alias.id);
  });

  test('identityById finds saved identities and falls back to the default', () {
    expect(_account.identityById('acc/shop').email, 'shop@anthill.example');
    expect(_account.identityById('gone').id, 'acc/default');
    expect(_account.identityById('acc/alias:').id, 'acc/default');
    expect(_account.identityById('other/alias:x@y.example').id, 'acc/default');
  });
}
