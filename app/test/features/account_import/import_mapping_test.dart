import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/account_import/import_mapping.dart';
import 'package:loupe/features/account_import/thunderbird_qr.dart';
import 'package:loupe/features/account_setup/setup_text.dart' show SecretKind;
import 'package:mail_model/mail_model.dart';

import 'tb_payloads.dart';

ImportCandidate candidateFrom(List<Object?> account) =>
    ImportCandidate.fromThunderbird(parseThunderbirdQr(tbPayload(accounts: [account])).accounts.single);

void main() {
  test('maps a plain IMAP account to account setup', () {
    final c = candidateFrom(
      tbAccount(
        incoming: tbIncoming(password: 'secret'),
        outgoingPassword: 'secret',
      ),
    );
    expect(c.email, 'jane@example.com');
    expect(c.provider, ProviderKind.generic);
    // Thunderbird's default name (the address) becomes Loupe's default.
    expect(c.name, 'Example');
    expect(c.senderName, 'Jane Doe');
    expect(c.canImport, isTrue);
    expect(c.needsPassword, isFalse);
    expect(c.unencrypted, isFalse);

    final setup = c.toSetup();
    expect(setup.email, 'jane@example.com');
    expect(setup.displayName, 'Example');
    expect(setup.senderName, 'Jane Doe');
    expect((setup.credentials as PasswordCredentials).password, 'secret');
    final incoming = setup.incoming;
    expect(incoming.protocol, ServerProtocol.imap);
    expect((incoming.host, incoming.port, incoming.security), ('imap.example.com', 993, ConnectionSecurity.tls));
    // A username equal to the address means "use the address".
    expect(incoming.username, isNull);
    final outgoing = setup.outgoing!;
    expect(outgoing.protocol, ServerProtocol.smtp);
    expect((outgoing.host, outgoing.port, outgoing.security), ('smtp.example.com', 465, ConnectionSecurity.tls));
  });

  test('keeps a renamed account’s name and a separate username', () {
    final c = candidateFrom(
      tbAccount(
        incoming: tbIncoming(name: 'Work', username: 'jdoe'),
      ),
    );
    expect(c.name, 'Work');
    expect(c.incoming.username, 'jdoe');
    expect(c.outgoing.username, isNull);
  });

  test('maps connection security and flags plain text', () {
    final c = candidateFrom(tbAccount(incoming: tbIncoming(security: 2, port: 143), smtpSecurity: 0, smtpPort: 25));
    expect((c.incoming.security, c.incoming.port), (ConnectionSecurity.startTls, 143));
    expect((c.outgoing.security, c.outgoing.port), (ConnectionSecurity.none, 25));
    expect(c.unencrypted, isTrue);
  });

  test('detects the provider by the server’s host', () {
    expect(providerForHost('imap.gmail.com'), ProviderKind.gmail);
    expect(providerForHost('imap.googlemail.com'), ProviderKind.gmail);
    expect(providerForHost('outlook.office365.com'), ProviderKind.microsoft);
    expect(providerForHost('imap-mail.outlook.com'), ProviderKind.microsoft);
    expect(providerForHost('imap.mail.me.com'), ProviderKind.icloud);
    expect(providerForHost('imap.mail.yahoo.com'), ProviderKind.yahoo);
    expect(providerForHost('imap.aol.com'), ProviderKind.yahoo);
    expect(providerForHost('imap.fastmail.com'), ProviderKind.fastmail);
    expect(providerForHost('mail.messagingengine.com'), ProviderKind.fastmail);
    expect(providerForHost('mail.example.com'), ProviderKind.generic);
    expect(providerForHost('imap.gmail.com.evil.example'), ProviderKind.generic);
    expect(providerForHost('notgmail.com'), ProviderKind.generic);
  });

  test('Gmail with OAuth asks for an app password', () {
    final c = candidateFrom(
      tbAccount(
        incoming: tbIncoming(host: 'imap.gmail.com', auth: 6, username: 'jane@gmail.com', name: 'jane@gmail.com'),
        smtpHost: 'smtp.gmail.com',
        smtpAuth: 6,
        identities: [
          ['jane@gmail.com', 'Jane'],
        ],
      ),
    );
    expect(c.provider, ProviderKind.gmail);
    expect(c.name, 'Gmail');
    expect(c.usesOAuth, isTrue);
    expect(c.canImport, isTrue);
    expect(c.needsPassword, isTrue);
    expect(c.secretKind, SecretKind.appPassword);
    expect(() => c.toSetup(), throwsStateError);
    expect((c.toSetup(password: 'abcd efgh').credentials as PasswordCredentials).password, 'abcd efgh');
  });

  test('Microsoft with OAuth waits for Microsoft sign-in; with a password it can be added', () {
    final oauth = candidateFrom(tbAccount(incoming: tbIncoming(host: 'outlook.office365.com', auth: 6)));
    expect(oauth.provider, ProviderKind.microsoft);
    expect(oauth.block, ImportBlock.microsoftSignIn);
    expect(oauth.canImport, isFalse);
    final password = candidateFrom(
      tbAccount(
        incoming: tbIncoming(host: 'outlook.office365.com', password: 'pw'),
      ),
    );
    expect(password.canImport, isTrue);
  });

  test('blocks what Loupe can’t do yet', () {
    expect(candidateFrom(tbAccount(incoming: tbIncoming(protocol: 1, port: 995))).block, ImportBlock.pop3);
    expect(candidateFrom(tbAccount(incoming: tbIncoming(auth: 3))).block, ImportBlock.kerberos);
    expect(candidateFrom(tbAccount(incoming: tbIncoming(auth: 4))).block, ImportBlock.ntlm);
    expect(candidateFrom(tbAccount(smtpAuth: 5)).block, ImportBlock.clientCertificate);
    expect(candidateFrom(tbAccount(incoming: tbIncoming(auth: 2))).block, isNull);
  });

  test('uses the outgoing password when only that one was exported', () {
    final c = candidateFrom(tbAccount(outgoingPassword: 'smtp-secret'));
    expect(c.includedPassword, 'smtp-secret');
    expect(c.needsPassword, isFalse);
  });

  test('a typed password wins, and trusted certificates are pinned by host', () {
    final c = candidateFrom(tbAccount(incoming: tbIncoming(password: 'old')));
    final setup = c.toSetup(password: 'new', trustedCertificates: {'imap.example.com': 'ab' * 32});
    expect((setup.credentials as PasswordCredentials).password, 'new');
    expect(setup.incoming.trustedCertificateSha256, 'ab' * 32);
    expect(setup.outgoing!.trustedCertificateSha256, isNull);
  });

  test('keeps further identities for later', () {
    final c = candidateFrom(
      tbAccount(
        identities: [
          ['jane@example.com', ''],
          ['support@example.com', 'Support'],
        ],
      ),
    );
    expect(c.senderName, isNull);
    expect(c.otherIdentities.single.email, 'support@example.com');
  });

  test('never shows the password in its description', () {
    final c = candidateFrom(tbAccount(incoming: tbIncoming(password: 'hunter2')));
    expect(c.toString(), isNot(contains('hunter2')));
  });
}
