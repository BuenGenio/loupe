import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/account_import/qr_sequence.dart';
import 'package:loupe/features/account_import/thunderbird_qr.dart';

import 'tb_payloads.dart';

void main() {
  group('parseThunderbirdQr', () {
    test('reads the spec’s single IMAP account without a password', () {
      final code = parseThunderbirdQr(specSingleAccount);
      expect(code.part, 1);
      expect(code.total, 1);
      expect(code.skipped, 0);
      final account = code.accounts.single;
      expect(account.protocol, TbIncomingProtocol.imap);
      expect(account.incoming.host, 'imap.domain.example');
      expect(account.incoming.port, 993);
      expect(account.incoming.security, TbSecurity.tls);
      expect(account.incoming.auth, TbAuth.passwordCleartext);
      expect(account.incoming.username, 'user@domain.example');
      expect(account.incoming.password, isNull);
      expect(account.outgoing.host, 'smtp.domain.example');
      expect(account.outgoing.port, 465);
      expect(account.outgoing.password, isNull);
      expect(account.email, 'user@domain.example');
      expect(account.identities.single.displayName, 'Jane Doe');
      // No AccountName: the first identity's address.
      expect(account.name, 'user@domain.example');
    });

    test('reads the spec’s two accounts, treating empty passwords as missing', () {
      final code = parseThunderbirdQr(specTwoAccounts);
      expect((code.part, code.total), (1, 2));
      expect(code.accounts, hasLength(2));
      final [work, personal] = code.accounts;
      expect(work.incoming.auth, TbAuth.oauth2);
      expect(work.outgoing.auth, TbAuth.oauth2);
      expect(work.incoming.password, isNull);
      expect(work.name, 'user@company.example');
      expect(personal.name, 'Jane (Personal)');
      expect(personal.email, 'jane@domain.example');
      expect(personal.outgoing.password, isNull);
    });

    test('reads passwords and every identity of a Thunderbird desktop export', () {
      final code = parseThunderbirdQr(
        tbPayload(
          part: 2,
          total: 3,
          accounts: [
            tbAccount(
              incoming: tbIncoming(name: 'Work', password: 'p@ss "word" ü'),
              identities: [
                ['jane@example.com', 'Jane Doe'],
                ['support@example.com', 'Example Support'],
              ],
              outgoingPassword: 'p@ss "word" ü',
            ),
          ],
        ),
      );
      expect((code.part, code.total), (2, 3));
      final account = code.accounts.single;
      expect(account.name, 'Work');
      expect(account.incoming.password, 'p@ss "word" ü');
      expect(account.outgoing.password, 'p@ss "word" ü');
      expect(account.identities.map((i) => i.email), ['jane@example.com', 'support@example.com']);
    });

    test('ignores extra elements a newer writer may add', () {
      final code = parseThunderbirdQr(
        jsonEncode([
          1,
          [1, 1, 'future'],
          [0, 'imap.example.com', 993, 3, 1, 'jane', 'Jane', 'pw', 'future', 42],
          [
            [
              [0, 'smtp.example.com', 465, 3, 1, 'jane', 'pw', 'future'],
              ['jane@example.com', 'Jane', 'future'],
            ],
          ],
        ]),
      );
      final account = code.accounts.single;
      expect(account.incoming.password, 'pw');
      expect(account.identities.single.email, 'jane@example.com');
    });

    test('maps every security and authentication value', () {
      TbServer incomingWith({int security = 3, int auth = 1}) => parseThunderbirdQr(
        tbPayload(
          accounts: [
            tbAccount(
              incoming: tbIncoming(security: security, auth: auth),
            ),
          ],
        ),
      ).accounts.single.incoming;

      expect(incomingWith(security: 0).security, TbSecurity.plain);
      // 1 is reserved ("STARTTLS when available"); it must never become plain text.
      expect(incomingWith(security: 1).security, TbSecurity.startTls);
      expect(incomingWith(security: 2).security, TbSecurity.startTls);
      expect(incomingWith(security: 3).security, TbSecurity.tls);
      expect([for (var a = 0; a <= 6; a++) incomingWith(auth: a).auth], TbAuth.values);
    });

    test('reads POP3 accounts (the mapping decides what to do with them)', () {
      final code = parseThunderbirdQr(tbPayload(accounts: [tbAccount(incoming: tbIncoming(protocol: 1, port: 995))]));
      expect(code.accounts.single.protocol, TbIncomingProtocol.pop3);
    });

    test('accepts IP addresses, IDNs in ACE form and a trailing dot', () {
      String hostOf(String host) => parseThunderbirdQr(
        tbPayload(
          accounts: [tbAccount(incoming: tbIncoming(host: host))],
        ),
      ).accounts.single.incoming.host;
      expect(hostOf('192.168.1.10'), '192.168.1.10');
      expect(hostOf('[2001:db8::1]'), '2001:db8::1');
      expect(hostOf('IMAP.xn--bcher-kva.example.'), 'imap.xn--bcher-kva.example');
      expect(hostOf('mail_1.example.com'), 'mail_1.example.com');
    });

    group('skips accounts with invalid or unknown values', () {
      void expectSkipped(List<Object?> incoming, {String why = ''}) {
        final code = parseThunderbirdQr(
          tbPayload(
            accounts: [
              tbAccount(incoming: incoming),
              tbAccount(incoming: tbIncoming(host: 'ok.example')),
            ],
          ),
        );
        expect(code.accounts.single.incoming.host, 'ok.example', reason: why);
        expect(code.skipped, 1, reason: why);
      }

      test('unknown protocol, security and authentication values', () {
        expectSkipped(tbIncoming(protocol: 2), why: 'protocol');
        expectSkipped(tbIncoming(security: 4), why: 'security');
        expectSkipped(tbIncoming(auth: 7), why: 'auth');
        expectSkipped(tbIncoming(auth: -1), why: 'auth');
      });

      test('ports out of range or of the wrong type', () {
        for (final port in [0, 65536, -1, '993', 993.5, null, true]) {
          expectSkipped(tbIncoming(port: port), why: '$port');
        }
      });

      test('hostnames that aren’t hostnames', () {
        for (final host in [
          '',
          'imap example.com',
          'imap.example.com/evil',
          'imap.example.com\n',
          'a..b',
          '-imap.example.com',
          'imap-.example.com',
          'ïmap.example.com',
          'user@imap.example.com',
          '256.1.1.1',
          '1.2.3',
          '[::g]',
          '${'a' * 64}.example.com',
          '${'abc.' * 64}com',
        ]) {
          expectSkipped(tbIncoming(host: host), why: host);
        }
      });

      test('control characters, line breaks and oversized text', () {
        expectSkipped(tbIncoming(username: 'jane\nINJECT'), why: 'username line break');
        expectSkipped(tbIncoming(username: 'jane\u0000'), why: 'NUL');
        expectSkipped(tbIncoming(username: 'x' * 257), why: 'long username');
        expectSkipped(tbIncoming(name: 'Work\r\nBcc: x'), why: 'name line break');
        expectSkipped(tbIncoming(name: '\u202Emoc.elpmaxe'), why: 'bidi override');
        expectSkipped(tbIncoming(password: 'pass\nword'), why: 'password line break');
        expectSkipped(tbIncoming(password: 'p' * 1025), why: 'long password');
        expectSkipped(tbIncoming(password: 42), why: 'password type');
        expectSkipped(tbIncoming(username: null), why: 'username missing');
      });

      test('incomplete incoming servers', () {
        expectSkipped([0, 'imap.example.com', 993, 3, 1], why: 'no username');
        expectSkipped([], why: 'empty');
      });
    });

    test('skips bad identities, and groups without a readable server or identity', () {
      final code = parseThunderbirdQr(
        tbPayload(
          accounts: [
            [
              tbIncoming(),
              [
                // Unreadable server: the whole group goes.
                [
                  [0, 'smtp example', 465, 3, 1, 'jane'],
                  ['first@example.com', 'First'],
                ],
                [
                  [0, 'smtp.example.com', 465, 3, 1, 'jane'],
                  ['not an address', 'Bad'],
                  ['jane@exämple.com', 'Bad'],
                  ['jane@example.com', 'Jane\u2028Doe'],
                  ['"quoted"@example.com', 'Bad'],
                  ['jane@example.com', 'Jane'],
                ],
              ],
            ],
            // No identity can be read: the account goes.
            tbAccount(
              identities: [
                ['@example.com', 'Bad'],
                ['jane@', 'Bad'],
              ],
            ),
          ],
        ),
      );
      expect(code.skipped, 1);
      final account = code.accounts.single;
      expect(account.outgoing.host, 'smtp.example.com');
      expect(account.identities.single.displayName, 'Jane');
      // The account name falls back to the first identity that could be read.
      expect(account.name, 'jane@example.com');
    });

    group('rejects payloads that aren’t Thunderbird exports', () {
      void expectRejected(String text, TbQrFormatException expected) =>
          expect(() => parseThunderbirdQr(text), throwsA(same(expected)), reason: text.length > 80 ? null : text);

      test('other QR codes and other JSON', () {
        expectRejected('', TbQrFormatException.notThunderbird);
        expectRejected('https://example.com', TbQrFormatException.notThunderbird);
        expectRejected('WIFI:S:home;T:WPA;P:secret;;', TbQrFormatException.notThunderbird);
        expectRejected('[1, [1, 1], ', TbQrFormatException.notThunderbird);
        expectRejected('{"version": 1}', TbQrFormatException.notThunderbird);
        expectRejected('[]', TbQrFormatException.notThunderbird);
        expectRejected('["1", [1, 1]]', TbQrFormatException.notThunderbird);
        expectRejected('[0, [1, 1]]', TbQrFormatException.notThunderbird);
      });

      test('a newer format version', () {
        expectRejected(specSingleAccount.replaceFirst('[1,', '[2,'), TbQrFormatException.newerVersion);
      });

      test('a broken sequence or structure', () {
        String withMisc(Object? misc) => jsonEncode([1, misc, ...tbAccount()]);
        for (final misc in [
          [0, 1],
          [2, 1],
          [1, 0],
          [1, 51],
          [1],
          ['1', 1],
          [1.0, 1],
          null,
        ]) {
          expectRejected(withMisc(misc), TbQrFormatException.damaged);
        }
        // No accounts, or an incoming server without its outgoing groups.
        expectRejected('[1,[1,1]]', TbQrFormatException.damaged);
        expectRejected(
          jsonEncode([
            1,
            [1, 1],
            tbIncoming(),
          ]),
          TbQrFormatException.damaged,
        );
        expectRejected(
          jsonEncode([
            1,
            [1, 1],
            'imap',
            [],
          ]),
          TbQrFormatException.damaged,
        );
      });

      test('oversized payloads', () {
        expectRejected('[${' ' * TbQrLimits.payloadLength}]', TbQrFormatException.tooLarge);
        final many = [for (var i = 0; i < 21; i++) ...tbAccount()];
        expectRejected(
          jsonEncode([
            1,
            [1, 1],
            ...many,
          ]),
          TbQrFormatException.tooLarge,
        );
      });

      test('deep nesting is rejected without exhausting the stack', () {
        final nested = '${'[' * 2000}${']' * 2000}';
        expectRejected(nested, TbQrFormatException.notThunderbird);
      });
    });

    test('repairs UTF-8 that a scanner decoded as Latin-1, and drops a BOM', () {
      final original = tbPayload(
        accounts: [
          tbAccount(
            identities: [
              ['jose@example.com', 'José Müller'],
            ],
          ),
        ],
      );
      final mangled = latin1.decode(utf8.encode(original));
      expect(mangled, isNot(original));
      expect(parseThunderbirdQr(mangled).accounts.single.identities.single.displayName, 'José Müller');
      expect(normalizeScannedText('\uFEFF  $original\n'), original);
      // Text that really is Latin-1 stays as it is.
      expect(normalizeScannedText('José'), 'José');
    });

    test('never shows passwords in descriptions', () {
      final code = parseThunderbirdQr(
        tbPayload(
          accounts: [
            tbAccount(
              incoming: tbIncoming(password: 'hunter2'),
              outgoingPassword: 'hunter2',
            ),
          ],
        ),
      );
      expect(code.accounts.single.toString(), isNot(contains('hunter2')));
      expect(code.accounts.single.toString(), contains('redacted'));
      expect(TbQrFormatException.damaged.toString(), isNot(contains('hunter2')));
    });
  });

  group('QrSequence', () {
    TbQrCode code(int part, int total, String host) => parseThunderbirdQr(
      tbPayload(
        part: part,
        total: total,
        accounts: [tbAccount(incoming: tbIncoming(host: host))],
      ),
    );

    test('collects parts in any order and ignores repeats', () {
      final sequence = QrSequence();
      expect(sequence.isEmpty, isTrue);
      expect(sequence.add(code(2, 3, 'two.example')), QrSequenceResult.added);
      expect((sequence.scanned, sequence.total), (1, 3));
      expect(sequence.missing, [1, 3]);
      expect(sequence.add(code(2, 3, 'two.example')), QrSequenceResult.duplicate);
      expect(sequence.add(code(3, 3, 'three.example')), QrSequenceResult.added);
      expect(sequence.isComplete, isFalse);
      expect(sequence.add(code(1, 3, 'one.example')), QrSequenceResult.added);
      expect(sequence.isComplete, isTrue);
      expect(sequence.missing, isEmpty);
      expect(sequence.accounts.map((a) => a.incoming.host), ['one.example', 'two.example', 'three.example']);
    });

    test('starts over when a code belongs to an export of a different size', () {
      final sequence = QrSequence()
        ..add(code(1, 3, 'old.example'))
        ..add(code(2, 3, 'old.example'));
      expect(sequence.add(code(1, 2, 'new.example')), QrSequenceResult.restarted);
      expect((sequence.scanned, sequence.total), (1, 2));
      expect(sequence.accounts.single.incoming.host, 'new.example');
    });

    test('clear forgets everything', () {
      final sequence = QrSequence()..add(code(1, 1, 'one.example'));
      sequence.clear();
      expect((sequence.isEmpty, sequence.total), (true, 0));
      expect(sequence.accounts, isEmpty);
    });
  });
}
