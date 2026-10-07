import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

const _account = MailAccount(
  id: 'acc',
  email: 'alex@acme.example',
  displayName: 'Acme',
  provider: ProviderKind.generic,
  authKind: AuthKind.password,
  incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.acme.example', port: 993),
  identities: [
    Identity(
      id: 'acc/default',
      email: 'alex@acme.example',
      name: 'Alex',
      signature: 'E.',
      replyTo: 'replies@acme.example',
      autoBcc: 'archive@acme.example',
    ),
    Identity(id: 'acc/shop', email: 'shop@acme.example', name: 'Acme Shop'),
  ],
);

void main() {
  test('identities round-trip through JSON, new fields included', () {
    const identity = Identity(
      id: 'acc/x',
      email: 'x@acme.example',
      name: 'X',
      signature: 'Sig',
      replyTo: 'r@acme.example',
      autoCc: 'cc@acme.example',
      autoBcc: 'bcc@acme.example',
      replyPatterns: ['*@acme.example', 'x+*@acme.example'],
    );
    final back = Identity.fromJson(identity.toJson());
    expect(back.autoCc, 'cc@acme.example');
    expect(back.autoBcc, 'bcc@acme.example');
    expect(back.replyPatterns, ['*@acme.example', 'x+*@acme.example']);
    expect(back.replyTo, 'r@acme.example');
  });

  test('identities saved before the new fields still load', () {
    final old = Identity.fromJson(const {'id': 'a', 'email': 'a@b.example', 'name': null, 'signature': null});
    expect(old.replyPatterns, isEmpty);
    expect(old.autoCc, isNull);
    final account = MailAccount.fromJson(_account.toJson());
    expect(account.identities.first.autoBcc, 'archive@acme.example');
  });

  test('alias identities take the default name and signature and survive by id', () {
    final alias = _account.aliasIdentity('shop-xyz@acme.example');
    expect(alias.email, 'shop-xyz@acme.example');
    expect(alias.name, 'Alex');
    expect(alias.signature, 'E.');
    expect(alias.replyTo, isNull, reason: 'replies come back to the alias');
    expect(alias.autoBcc, isNull);
    expect(_account.isAliasIdentity(alias), isTrue);
    expect(_account.isAliasIdentity(_account.defaultIdentity), isFalse);

    final back = _account.identityById(alias.id);
    expect(back.email, 'shop-xyz@acme.example');
    expect(back.id, alias.id);
  });

  test('identityById finds saved identities and falls back to the default', () {
    expect(_account.identityById('acc/shop').email, 'shop@acme.example');
    expect(_account.identityById('gone').id, 'acc/default');
    expect(_account.identityById('acc/alias:').id, 'acc/default');
    expect(_account.identityById('other/alias:x@y.example').id, 'acc/default');
  });
}
