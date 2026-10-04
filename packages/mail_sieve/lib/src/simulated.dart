/// An in-memory stand-in for ManageSieve servers, for demo mode and tests.
library;

import 'dart:convert';

import 'package:mail_model/mail_model.dart';

import 'check.dart';
import 'compile.dart';
import 'managesieve/session.dart';

/// One simulated server's state.
final class SimulatedSieveAccount {
  SimulatedSieveAccount({Set<String>? extensions, this.quota = 128 * 1024})
    : extensions = extensions ?? {...loupeSieveExtensions, 'envelope', 'vacation', 'reject'};

  /// Sieve extensions the server offers.
  Set<String> extensions;

  /// Bytes all scripts together may take.
  int quota;

  final scripts = <String, String>{};
  String? active;

  /// Commands run, e.g. `PUTSCRIPT loupe`, for tests.
  final log = <String>[];

  /// When set, every command fails with it (a server that went away).
  MailException? failure;
}

/// Simulated ManageSieve servers by account id. Accounts in [unavailable]
/// have none (connecting fails with the given message).
final class SimulatedSieveServers implements SieveConnector {
  SimulatedSieveServers({this.latency = Duration.zero});

  /// Delay of every command.
  Duration latency;
  final _accounts = <String, SimulatedSieveAccount>{};

  /// Account id → why it has no server rules.
  final unavailable = <String, String>{};

  /// The server of [accountId] (created on first use).
  SimulatedSieveAccount operator [](String accountId) => _accounts.putIfAbsent(accountId, SimulatedSieveAccount.new);

  @override
  Future<SieveSession> connect(MailAccount account, CredentialsCallback credentials) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    final why = unavailable[account.id];
    if (why != null) throw MailException(MailErrorKind.unsupported, why);
    final state = this[account.id];
    if (state.failure case final f?) throw f;
    return _SimulatedSession(state, latency);
  }
}

final class _SimulatedSession implements SieveSession {
  _SimulatedSession(this._s, this._latency);

  final SimulatedSieveAccount _s;
  final Duration _latency;

  Future<void> _step(String command) async {
    if (_latency > Duration.zero) await Future<void>.delayed(_latency);
    if (_s.failure case final f?) throw f;
    _s.log.add(command);
  }

  @override
  SieveCapabilities get capabilities => SieveCapabilities(
    implementation: 'Loupe simulated Sieve',
    extensions: _s.extensions,
    sasl: const {'PLAIN'},
    version: '1.0',
  );

  @override
  Future<List<SieveScriptInfo>> listScripts() async {
    await _step('LISTSCRIPTS');
    return [for (final name in _s.scripts.keys) SieveScriptInfo(name, active: name == _s.active)];
  }

  @override
  Future<String> getScript(String name) async {
    await _step('GETSCRIPT $name');
    return _s.scripts[name] ?? (throw const SieveException('There is no script by that name.', code: 'NONEXISTENT'));
  }

  void _validate(String script) {
    final errors = checkSieveScript(script, _s.extensions);
    if (errors.isNotEmpty) throw SieveException(errors.join('\n'));
  }

  @override
  Future<String?> checkScript(String script) async {
    await _step('CHECKSCRIPT');
    _validate(script);
    return null;
  }

  @override
  Future<void> putScript(String name, String script) async {
    await _step('PUTSCRIPT $name');
    _validate(script);
    if (!_fits(name, utf8.encode(script).length)) {
      throw const SieveException('Not enough space for the script.', code: 'QUOTA/MAXSIZE');
    }
    _s.scripts[name] = script;
  }

  bool _fits(String name, int size) {
    var used = 0;
    for (final MapEntry(:key, :value) in _s.scripts.entries) {
      if (key != name) used += utf8.encode(value).length;
    }
    return used + size <= _s.quota;
  }

  @override
  Future<void> setActive(String name) async {
    await _step('SETACTIVE $name');
    if (name.isNotEmpty && !_s.scripts.containsKey(name)) {
      throw const SieveException('There is no script by that name.', code: 'NONEXISTENT');
    }
    _s.active = name.isEmpty ? null : name;
  }

  @override
  Future<bool> haveSpace(String name, int size) async {
    await _step('HAVESPACE $name $size');
    return _fits(name, size);
  }

  @override
  Future<void> deleteScript(String name) async {
    await _step('DELETESCRIPT $name');
    if (_s.active == name) throw const SieveException('You may not delete an active script.', code: 'ACTIVE');
    _s.scripts.remove(name);
  }

  @override
  Future<void> logout() async {
    _s.log.add('LOGOUT');
  }
}
