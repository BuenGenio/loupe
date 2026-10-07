import 'package:mail_jmap/mail_jmap.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';
import 'package:test/test.dart';

import 'support/scripted_jmap.dart';

final class _Fallback implements SieveConnector {
  final accounts = <MailAccount>[];

  @override
  Future<SieveSession> connect(MailAccount account, CredentialsCallback credentials) async {
    accounts.add(account);
    throw const MailException(MailErrorKind.unsupported, 'fallback');
  }
}

Json _sieveCaps(Json session) => {
  ...session,
  'capabilities': {
    ...(session['capabilities']! as Map).cast<String, Object?>(),
    JmapCapabilities.sieve: {'implementation': 'Stalwart v1.0.0'},
  },
  'accounts': {
    'c': {
      'name': 'alice@example.test',
      'isPersonal': true,
      'isReadOnly': false,
      'accountCapabilities': {
        JmapCapabilities.sieve: {
          'maxSizeScript': 100,
          'maxNumberRedirects': 1,
          'sieveExtensions': ['fileinto', 'imap4flags', 'body'],
        },
      },
    },
  },
  'primaryAccounts': {...(session['primaryAccounts']! as Map).cast<String, Object?>(), JmapCapabilities.sieve: 'c'},
};

void main() {
  test('IMAP accounts, and JMAP servers without Sieve, use the fallback (ManageSieve)', () async {
    final fallback = _Fallback();
    final session = fixture('session');
    (session['capabilities']! as Map).remove(JmapCapabilities.sieve);
    final jmap = ScriptedJmap(session: session);
    final connector = JmapSieveConnector(fallback: fallback, httpClient: jmap.client);
    await expectLater(connector.connect(scriptedAccount(), passwordCallback()), throwsA(isA<MailException>()));
    expect(fallback.accounts.single.incoming.protocol, ServerProtocol.jmap);
    final imap = MailAccount(
      id: 'i',
      email: 'a@example.org',
      displayName: 'IMAP',
      provider: ProviderKind.generic,
      authKind: AuthKind.password,
      incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.org', port: 993),
    );
    await expectLater(connector.connect(imap, passwordCallback()), throwsA(isA<MailException>()));
    expect(fallback.accounts, hasLength(2));
  });

  test('scripts are blobs: uploaded, validated, set, activated and read back', () async {
    final scripts = <String, Json>{};
    final jmap = ScriptedJmap(session: _sieveCaps(fixture('session')));
    jmap
      ..on('SieveScript/get', (_) => {'list': scripts.values.toList()})
      ..on('SieveScript/validate', (args) {
        final text = String.fromCharCodes(jmap.blobs[args['blobId']]!);
        return {
          'error': text.contains('broken') ? {'type': 'invalidSieve', 'description': 'line 1: unexpected {'} : null,
        };
      })
      ..on('SieveScript/set', (args) {
        for (final MapEntry(:value) in (args['create'] as Map? ?? const {}).entries) {
          final v = (value as Map).cast<String, Object?>();
          scripts['s${scripts.length}'] = {'id': 's${scripts.length}', 'name': v['name'], 'blobId': v['blobId']};
        }
        for (final MapEntry(:key, :value) in (args['update'] as Map? ?? const {}).entries) {
          scripts[key]!['blobId'] = (value as Map)['blobId'];
        }
        if (args['onSuccessActivateScript'] case final String id) {
          for (final s in scripts.values) {
            s['isActive'] = s['id'] == id;
          }
        }
        for (final id in args['destroy'] as List? ?? const []) {
          if (scripts[id]?['isActive'] == true) {
            return {
              'notDestroyed': {
                id: {'type': 'scriptIsActive'},
              },
            };
          }
          scripts.remove(id);
        }
        return {'created': <String, Object>{}};
      });
    final s = await JmapSieveConnector(httpClient: jmap.client).connect(scriptedAccount(), passwordCallback());
    expect(s.capabilities.extensions, {'fileinto', 'imap4flags', 'body'});
    expect(s.capabilities.implementation, 'Stalwart v1.0.0');
    expect(s.capabilities.version, isNotNull);
    expect(await s.haveSpace('loupe', 100), isTrue);
    expect(await s.haveSpace('loupe', 101), isFalse);
    await expectLater(s.checkScript('if broken {'), throwsA(isA<SieveException>()));
    await s.putScript('loupe', 'keep;');
    await s.putScript('loupe', 'stop;');
    expect(scripts, hasLength(1));
    expect(await s.getScript('loupe'), 'stop;');
    await s.setActive('loupe');
    expect(await s.listScripts(), [const SieveScriptInfo('loupe', active: true)]);
    await expectLater(s.deleteScript('loupe'), throwsA(isA<SieveException>().having((e) => e.code, 'code', 'ACTIVE')));
    await expectLater(s.getScript('nope'), throwsA(isA<SieveException>().having((e) => e.code, 'code', 'NONEXISTENT')));
    expect(jmap.callsOf('SieveScript/set')[2], {'accountId': 'c', 'onSuccessActivateScript': 's0'});
    await s.logout();
  });
}
