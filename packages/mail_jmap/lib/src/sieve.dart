/// Server rules over JMAP (RFC 9661: SieveScript).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:mail_model/mail_model.dart';
import 'package:mail_sieve/mail_sieve.dart';

import 'client/errors.dart';
import 'client/request.dart';
import 'client/session.dart';
import 'transport/jmap_transport.dart';

/// Opens Sieve sessions over JMAP for JMAP accounts whose server offers
/// `urn:ietf:params:jmap:sieve` (Stalwart): no ManageSieve port needed,
/// the rules travel with the mail over HTTPS. Other accounts, and JMAP
/// servers without it, go to [fallback] (ManageSieve).
final class JmapSieveConnector implements SieveConnector {
  const JmapSieveConnector({this.fallback = const ManageSieveConnector(), http.Client? httpClient})
    : _http = httpClient;

  final SieveConnector fallback;
  final http.Client? _http;

  @override
  Future<SieveSession> connect(MailAccount account, CredentialsCallback credentials) async {
    if (account.incoming.protocol != ServerProtocol.jmap) return fallback.connect(account, credentials);
    final transport = JmapTransport(account, credentials, httpClient: _http);
    await transport.connect();
    final session = transport.session!;
    final sieveAccount = session.primaryAccount(JmapCapabilities.sieve);
    if (!session.has(JmapCapabilities.sieve) || sieveAccount == null) {
      await transport.disconnect();
      return fallback.connect(account, credentials);
    }
    return JmapSieveSession(transport, sieveAccount);
  }
}

/// A [SieveSession] on a JMAP account's `SieveScript` objects. Scripts are
/// blobs: uploaded, validated (`SieveScript/validate`) and downloaded.
final class JmapSieveSession implements SieveSession {
  JmapSieveSession(this._transport, this._account);

  final JmapTransport _transport;
  final String _account;

  static const _using = [JmapCapabilities.sieve];

  Map<String, Object?> get _limits {
    final caps = _transport.session?.accounts[_account]?.capabilities[JmapCapabilities.sieve];
    return caps is Map ? caps.cast() : const {};
  }

  @override
  SieveCapabilities get capabilities {
    final server = _transport.session?.capabilities[JmapCapabilities.sieve];
    final limits = _limits;
    return SieveCapabilities(
      implementation: server is Map ? server['implementation'] as String? : null,
      extensions: {
        for (final e in limits['sieveExtensions'] as List? ?? const [])
          if (e is String) e.toLowerCase(),
      },
      // SieveScript/validate does what CHECKSCRIPT does.
      version: '1.0',
      maxRedirects: (limits['maxNumberRedirects'] as num?)?.toInt(),
    );
  }

  Future<List<Json>> _scripts() async {
    final request = JmapRequest(_using);
    final get = request.add('SieveScript/get', {
      'accountId': _account,
      'properties': const ['id', 'name', 'blobId', 'isActive'],
    });
    return [
      for (final s in (await _transport.client.call(request)).of(get)['list'] as List? ?? const [])
        if (s is Map) s.cast<String, Object?>(),
    ];
  }

  Future<Json?> _byName(String name) async => (await _scripts()).where((s) => s['name'] == name).firstOrNull;

  @override
  Future<List<SieveScriptInfo>> listScripts() async => [
    for (final s in await _scripts()) SieveScriptInfo(s['name']! as String, active: s['isActive'] == true),
  ];

  @override
  Future<String> getScript(String name) async {
    final script = await _byName(name);
    final blob = script?['blobId'] as String?;
    if (blob == null) throw const SieveException('There is no script by that name.', code: 'NONEXISTENT');
    return utf8.decode(await _transport.client.download(_account, blob, type: 'application/sieve'));
  }

  Future<String> _upload(String script) async => (await _transport.client.upload(
    _account,
    Uint8List.fromList(utf8.encode(script)),
    type: 'application/sieve',
  )).blobId;

  @override
  Future<String?> checkScript(String script) async {
    final request = JmapRequest(_using);
    final validate = request.add('SieveScript/validate', {'accountId': _account, 'blobId': await _upload(script)});
    final error = (await _transport.client.call(request)).of(validate)['error'];
    if (error is Map) throw SieveException(error['description'] as String? ?? 'The script isn’t valid Sieve.');
    return null;
  }

  @override
  Future<void> putScript(String name, String script) async {
    final blob = await _upload(script);
    final existing = await _byName(name);
    final id = existing?['id'] as String?;
    await _set({
      if (id == null)
        'create': {
          's': {'name': name, 'blobId': blob},
        }
      else
        'update': {
          id: {'blobId': blob},
        },
    });
  }

  @override
  Future<void> setActive(String name) async {
    if (name.isEmpty) {
      await _set({'onSuccessDeactivateScript': true});
      return;
    }
    final id = (await _byName(name))?['id'] as String?;
    if (id == null) throw const SieveException('There is no script by that name.', code: 'NONEXISTENT');
    await _set({'onSuccessActivateScript': id});
  }

  @override
  Future<bool> haveSpace(String name, int size) async {
    final max = (_limits['maxSizeScript'] as num?)?.toInt();
    return max == null || size <= max;
  }

  @override
  Future<void> deleteScript(String name) async {
    final id = (await _byName(name))?['id'] as String?;
    if (id == null) throw const SieveException('There is no script by that name.', code: 'NONEXISTENT');
    await _set({
      'destroy': [id],
    });
  }

  /// SieveScript/set; per-script errors become [SieveException]s with the
  /// server's text (`invalidSieve` carries the parse error).
  Future<void> _set(Json args) async {
    final request = JmapRequest(_using);
    final set = request.add('SieveScript/set', {'accountId': _account, ...args});
    final result = (await _transport.client.call(request)).of(set);
    for (final key in const ['notCreated', 'notUpdated', 'notDestroyed']) {
      final errors = result[key];
      if (errors is! Map || errors.isEmpty) continue;
      final error = (errors.values.first as Map).cast<String, Object?>();
      final e = setError('The server refused the script', error);
      throw SieveException(
        error['description'] as String? ?? e.message,
        code: switch (e.type) {
          'scriptIsActive' => 'ACTIVE',
          'notFound' => 'NONEXISTENT',
          'overQuota' => 'QUOTA',
          _ => null,
        },
      );
    }
  }

  @override
  Future<void> logout() => _transport.disconnect();
}
