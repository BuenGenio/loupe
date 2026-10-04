import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/account_import/import_controller.dart';
import 'package:loupe/features/account_import/qr_sequence.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'tb_payloads.dart';

void main() {
  late FakeMailRepository repo;
  late AccountImportController controller;

  setUp(() {
    repo = FakeMailRepository(accounts: []);
    controller = AccountImportController(repository: () async => repo);
  });

  tearDown(() => controller.dispose());

  String code({int part = 1, int total = 1, String host = 'imap.example.com', String password = 'secret'}) => tbPayload(
    part: part,
    total: total,
    accounts: [
      tbAccount(
        incoming: tbIncoming(host: host, password: password),
        identities: [
          ['jane@$host', 'Jane'],
        ],
      ),
    ],
  );

  test('reports what each payload did, and ignores a repeated bad one', () {
    expect(controller.addPayload(code(part: 1, total: 2)), isA<ScanAccepted>());
    expect((controller.addPayload(code(part: 1, total: 2))! as ScanAccepted).result, QrSequenceResult.duplicate);
    final rejected = controller.addPayload('https://example.com');
    expect((rejected! as ScanRejected).message, contains("isn't a Thunderbird"));
    // The camera keeps seeing the same code: say it once.
    expect(controller.addPayload('https://example.com'), isNull);
    expect(controller.sequence.scanned, 1);
  });

  test('pasted text may hold several codes, one per line', () {
    final feedback = controller.addPasted(
      '${code(part: 1, total: 2, host: 'one.example')}\n\n${code(part: 2, total: 2, host: 'two.example')}\n',
    );
    expect(feedback, isA<ScanAccepted>());
    expect(controller.sequence.isComplete, isTrue);
    // Pretty-printed JSON (as in the format's examples) is one code.
    controller.startOver();
    controller.addPasted(specSingleAccount.replaceAll(',', ',\n  '));
    expect(controller.sequence.accounts.single.email, 'user@domain.example');
  });

  test('marks accounts already in Loupe and leaves them unselected', () {
    controller
      ..addPayload(
        tbPayload(
          accounts: [
            tbAccount(),
            tbAccount(incoming: tbIncoming(host: 'imap.other.example')),
          ],
        ),
      )
      ..review(existing: {'JANE@example.com'});
    expect(controller.rows, hasLength(2));
    expect(controller.rows.every((r) => r.alreadyAdded), isTrue);
    expect(controller.selected, isEmpty);
  });

  test('adds selected accounts one by one, with their other identities', () async {
    controller
      ..addPayload(
        tbPayload(
          accounts: [
            tbAccount(
              incoming: tbIncoming(password: 'secret', name: 'Work'),
              identities: [
                ['jane@example.com', 'Jane'],
                ['help@example.com', 'Help Desk'],
              ],
            ),
          ],
        ),
      )
      ..review();
    await controller.importSelected();
    final setup = repo.setups.single;
    expect(setup.email, 'jane@example.com');
    expect(setup.displayName, 'Work');
    expect((setup.credentials as PasswordCredentials).password, 'secret');
    expect(controller.rows.single.status, ImportStatus.added);
    expect(controller.anyAdded, isTrue);
    expect(controller.selected, isEmpty);
    final identities = repo.accounts.single.identities;
    expect(identities.map((i) => i.email), ['jane@example.com', 'help@example.com']);
    expect(identities.last.name, 'Help Desk');
  });

  test('asks for missing passwords before adding anything', () async {
    controller
      ..addPayload(code(password: ''))
      ..review();
    final row = controller.rows.single;
    expect(row.asksPassword, isTrue);
    await controller.importSelected();
    expect(repo.setups, isEmpty);
    expect(row.error, 'Enter the password.');

    row.password.text = 'typed';
    await controller.importSelected();
    expect((repo.setups.single.credentials as PasswordCredentials).password, 'typed');
    expect(row.password.text, isEmpty, reason: 'typed passwords are cleared once used');
  });

  test('a rejected password asks for it again; other errors use setup’s wording', () async {
    var attempt = 0;
    repo.onAddAccount = (setup) async {
      attempt++;
      if (attempt == 1) throw const MailException(MailErrorKind.authentication, 'LOGIN failed');
      if (attempt == 2) throw const MailException(MailErrorKind.connection, 'refused');
      return testAccount;
    };
    controller
      ..addPayload(code())
      ..review();
    final row = controller.rows.single;
    expect(row.asksPassword, isFalse);
    await controller.importSelected();
    expect(row.status, ImportStatus.failed);
    expect(row.error, startsWith('Password rejected'));
    expect(row.asksPassword, isTrue);

    row.password.text = 'better';
    await controller.importSelected();
    expect(row.error, startsWith("Can't reach server"));
    await controller.importSelected();
    expect(row.status, ImportStatus.added);
    expect((repo.setups.last.credentials as PasswordCredentials).password, 'better');
  });

  test('trusting a certificate pins it on the server it names', () async {
    final fp = List.filled(32, 'cd').join(':');
    repo.onAddAccount = (setup) async {
      if (setup.incoming.trustedCertificateSha256 == null) {
        throw MailException(MailErrorKind.certificate, 'imap.example.com presented an unknown certificate $fp');
      }
      return testAccount;
    };
    controller
      ..addPayload(code())
      ..review();
    final row = controller.rows.single;
    await controller.importSelected();
    expect(row.fingerprint, 'cd' * 32);
    await controller.trustCertificate(row);
    expect(row.status, ImportStatus.added);
    expect(repo.setups.last.incoming.trustedCertificateSha256, 'cd' * 32);
    expect(repo.setups.last.outgoing!.trustedCertificateSha256, isNull);
  });

  test('an unexpected error fails only that account, without details', () async {
    repo.onAddAccount = (setup) async =>
        setup.email.startsWith('jane@one') ? throw StateError('secret details') : testAccount;
    controller
      ..addPasted('${code(part: 1, total: 2, host: 'one.example')}\n${code(part: 2, total: 2, host: 'two.example')}')
      ..review();
    await controller.importSelected();
    final [one, two] = controller.rows;
    expect(one.status, ImportStatus.failed);
    expect(one.error, isNot(contains('secret')));
    expect(two.status, ImportStatus.added);
  });

  test('disposing (leaving the screen) forgets everything too', () {
    final own = AccountImportController(repository: () async => repo)
      ..addPayload(code())
      ..review();
    own.dispose();
    expect(own.sequence.isEmpty, isTrue);
    expect(own.rows, isEmpty);
  });

  test('clear forgets the codes, the accounts and typed passwords', () {
    controller
      ..addPayload(code(password: ''))
      ..review();
    controller.rows.single.password.text = 'typed';
    controller.clear();
    expect(controller.sequence.isEmpty, isTrue);
    expect(controller.rows, isEmpty);
  });
}
