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

  group('folder roles', () {
    const listed = [
      RemoteMailbox(path: 'INBOX', name: 'Inbox', role: MailboxRole.inbox),
      RemoteMailbox(path: 'Sent', name: 'Sent', role: MailboxRole.sent),
      RemoteMailbox(path: 'INBOX.Sent Items', name: 'Sent Items', parentPath: 'INBOX'),
      RemoteMailbox(path: 'Drafts', name: 'Drafts', role: MailboxRole.drafts),
      RemoteMailbox(path: 'Trash', name: 'Trash', role: MailboxRole.trash),
      RemoteMailbox(path: 'Archive', name: 'Archive', role: MailboxRole.archive),
      RemoteMailbox(path: 'Old', name: 'Old', isSelectable: false),
    ];
    Map<String, MailboxRole> roles(List<RemoteMailbox> boxes) => {for (final m in boxes) m.path: m.role};

    test('round-trip through JSON; an account saved before them has none', () {
      final picked = _account.withFolderRole(MailboxRole.sent, 'INBOX.Sent Items');
      expect(MailAccount.fromJson(picked.toJson()).folderRoles, {MailboxRole.sent: 'INBOX.Sent Items'});
      expect(_account.toJson().containsKey('folderRoles'), isFalse);
      expect(MailAccount.fromJson(_account.toJson()).folderRoles, isEmpty);
    });

    test('a picked folder takes the role from the server’s; the server’s choice is kept for the rest', () {
      final a = _account.withFolderRole(MailboxRole.sent, 'INBOX.Sent Items');
      expect(roles(a.applyFolderRoles(listed)), {
        'INBOX': MailboxRole.inbox,
        'Sent': MailboxRole.none,
        'INBOX.Sent Items': MailboxRole.sent,
        'Drafts': MailboxRole.drafts,
        'Trash': MailboxRole.trash,
        'Archive': MailboxRole.archive,
        'Old': MailboxRole.none,
      });
      expect(_account.applyFolderRoles(listed), same(listed));
    });

    test('a folder holds one role: picking it gives up its own, and unpicks it for another role', () {
      final a = _account.withFolderRole(MailboxRole.trash, 'Archive').withFolderRole(MailboxRole.drafts, 'Archive');
      expect(a.folderRoles, {MailboxRole.drafts: 'Archive'});
      final applied = roles(a.applyFolderRoles(listed));
      expect(applied['Archive'], MailboxRole.drafts);
      expect(applied['Drafts'], MailboxRole.none);
      expect(applied['Trash'], MailboxRole.trash);
      expect(applied.values.where((r) => r == MailboxRole.archive), isEmpty);
    });

    test('null goes back to the server’s choice', () {
      final a = _account.withFolderRole(MailboxRole.sent, 'INBOX.Sent Items').withFolderRole(MailboxRole.sent, null);
      expect(a.folderRoles, isEmpty);
    });

    test('a folder that’s gone, can’t hold mail or is the Inbox changes nothing', () {
      for (final path in ['Gone', 'Old', 'INBOX']) {
        final a = _account.withFolderRole(MailboxRole.trash, path);
        expect(roles(a.applyFolderRoles(listed)), roles(listed), reason: path);
      }
    });
  });
}
