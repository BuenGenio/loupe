/// One authenticated IMAP connection on top of enough_mail's [ImapClient].
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:enough_mail/enough_mail.dart' as em show Mailbox;
import 'package:enough_mail/enough_mail.dart' show ImapClient, ImapException;
import 'package:mail_model/mail_model.dart';

import '../net/secure_socket.dart';
import '../util/modified_utf7.dart';
import '../util/quiet.dart';
import 'parsers.dart';
import 'protocol.dart';
import 'values.dart';

/// enough_mail's client with three additions: a future for the greeting, a
/// future for the connection closing (it otherwise leaves pending commands
/// hanging), and binary literals (APPEND, SETMETADATA).
final class LoupeImapClient extends ImapClient {
  LoupeImapClient() : super(isLogEnabled: false);

  final _greeting = Completer<String>();
  final _closed = Completer<void>();
  Uint8List? _pendingLiteral;

  Future<String> get greeting => _greeting.future;
  Future<void> get closed => _closed.future;
  bool get isClosed => _closed.isCompleted;

  @override
  FutureOr<void> onConnectionEstablished(ConnectionInfo connectionInfo, String serverGreeting) async {
    await super.onConnectionEstablished(connectionInfo, serverGreeting);
    if (!_greeting.isCompleted) _greeting.complete(serverGreeting);
  }

  @override
  void onConnectionError(dynamic error) {
    super.onConnectionError(error);
    _markClosed();
  }

  void _markClosed() {
    if (!_closed.isCompleted) _closed.complete();
    if (!_greeting.isCompleted) {
      _greeting.future.ignore();
      _greeting.completeError(const MailException(MailErrorKind.connection, 'Connection closed'));
    }
  }

  @override
  Future<void> onContinuationResponse(ImapResponse imapResponse) async {
    final literal = _pendingLiteral;
    if (literal != null) {
      _pendingLiteral = null;
      await writeData([...literal, 13, 10]);
      return;
    }
    await super.onContinuationResponse(imapResponse);
  }

  @override
  Future<void> disconnect() async {
    try {
      await super.disconnect();
    } finally {
      _markClosed();
    }
  }
}

/// Default time to wait for a command's response.
const defaultCommandTimeout = Duration(seconds: 90);

/// An open, authenticated IMAP connection with its capabilities and the
/// currently selected mailbox. Commands are serialised by enough_mail.
final class ImapConnection {
  ImapConnection._(this.client, this.host, this.port);

  final LoupeImapClient client;
  final String host;
  final int port;

  /// Upper-cased capabilities after login.
  Set<String> capabilities = {};

  /// QRESYNC was enabled (VANISHED responses instead of EXPUNGE).
  bool qresyncEnabled = false;

  /// Path of the selected mailbox (decoded), if any.
  String? selectedPath;
  SelectData? selectData;

  bool get isOpen => !client.isClosed && client.isConnected;
  Future<void> get closed => client.closed;

  bool has(String capability) => capabilities.contains(capability);
  bool get supportsCondstore => has('CONDSTORE') || has('QRESYNC');
  bool get supportsUidPlus => has('UIDPLUS');
  bool get supportsEsearch => has('ESEARCH');

  /// Annotations on the server itself, i.e. the empty mailbox name (RFC 5464:
  /// `METADATA` covers server and mailbox annotations, `METADATA-SERVER`
  /// only server ones).
  bool get supportsServerMetadata => has('METADATA') || has('METADATA-SERVER');

  /// Connects and logs in with the credentials [credentials] returns.
  /// Throws [MailException]; authentication failures have kind
  /// [MailErrorKind.authentication].
  static Future<ImapConnection> open(
    ServerConfig server, {
    required String username,
    required Credentials credentials,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final socket = await openMailSocket(
      host: server.host,
      port: server.port,
      security: server.security,
      protocol: WireProtocol.imap,
      trustedSha256: server.trustedCertificateSha256,
      timeout: timeout,
    );
    final client = LoupeImapClient();
    final conn = ImapConnection._(client, server.host, server.port);
    try {
      runQuietly(
        () => client.connect(
          socket,
          connectionInformation: ConnectionInfo(
            server.host,
            server.port,
            isSecure: server.security != ConnectionSecurity.none,
          ),
        ),
      );
      final greeting = await client.greeting.timeout(timeout);
      if (greeting.startsWith('* BYE')) {
        throw MailException(MailErrorKind.server, '${server.host}: ${greeting.substring(5).trim()}');
      }
      final initial = RegExp(r'\[CAPABILITY ([^\]]*)\]').firstMatch(greeting);
      conn.capabilities = initial == null || server.security == ConnectionSecurity.startTls
          ? await conn.send(Command('CAPABILITY'), CapabilityParser(), timeout: timeout)
          : parseCapabilityList(initial[1]!);
      if (!greeting.startsWith('* PREAUTH')) {
        final caps = await conn._authenticate(username, credentials, timeout);
        conn.capabilities = caps.isNotEmpty ? caps : await conn.send(Command('CAPABILITY'), CapabilityParser());
      }
      client.isLoggedIn = true;
      if (conn.has('QRESYNC') && conn.has('ENABLE')) {
        try {
          await conn.send(Command('ENABLE QRESYNC'), GenericParser());
          conn.qresyncEnabled = true;
        } on MailException catch (e) {
          if (e.kind == MailErrorKind.connection) rethrow;
        }
      }
      return conn;
    } on TimeoutException {
      await conn.close();
      throw MailException(MailErrorKind.connection, '${server.host} did not answer.');
    } catch (_) {
      await conn.close();
      rethrow;
    }
  }

  Future<Set<String>> _authenticate(String username, Credentials credentials, Duration timeout) async {
    final saslIr = has('SASL-IR');
    Command sasl(String mechanism, String token) => saslIr
        ? Command('AUTHENTICATE $mechanism $token', logText: 'AUTHENTICATE $mechanism ****')
        : Command.withContinuation(['AUTHENTICATE $mechanism', token, ''], logText: 'AUTHENTICATE $mechanism ****');
    final Command command;
    switch (credentials) {
      case PasswordCredentials(:final password):
        if (has('LOGINDISABLED')) {
          throw MailException(MailErrorKind.unsupported, '$host doesn’t allow logging in on this connection.');
        }
        if (has('AUTH=PLAIN')) {
          command = sasl('PLAIN', base64.encode(utf8.encode('\u0000$username\u0000$password')));
        } else if (isQuotable(username) && isQuotable(password)) {
          command = Command('LOGIN ${quoteImap(username)} ${quoteImap(password)}', logText: 'LOGIN ****');
        } else {
          final u = utf8.encode(username).length;
          final p = utf8.encode(password).length;
          command = Command.withContinuation(['LOGIN {$u}', '$username {$p}', password], logText: 'LOGIN ****');
        }
      case OAuthCredentials(:final accessToken):
        if (has('AUTH=XOAUTH2') || !has('AUTH=OAUTHBEARER')) {
          command = sasl(
            'XOAUTH2',
            base64.encode(utf8.encode('user=$username\u0001auth=Bearer $accessToken\u0001\u0001')),
          );
        } else {
          command = sasl(
            'OAUTHBEARER',
            base64.encode(
              utf8.encode('n,a=$username,\u0001host=$host\u0001port=$port\u0001auth=Bearer $accessToken\u0001\u0001'),
            ),
          );
        }
    }
    try {
      return await send(command, CapabilityParser(), timeout: timeout);
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server) rethrow;
      throw MailException(MailErrorKind.authentication, _authMessage(e.message), e.cause);
    }
  }

  String _authMessage(String serverText) {
    final t = serverText.replaceAll(RegExp(r'\[[A-Z-]+\]\s*'), '').trim();
    return t.isEmpty ? 'The server rejected the user name or password.' : t;
  }

  /// Sends [command] and waits for its tagged response, the connection
  /// closing, or [timeout]. A timeout closes the connection, since the
  /// protocol state is unknown afterwards.
  Future<T> send<T>(Command command, ResponseParser<T> parser, {Duration? timeout}) =>
      guard(() => client.sendCommand<T>(command, parser), timeout: timeout);

  /// Runs an enough_mail call with the same guarantees as [send].
  Future<T> guard<T>(Future<T> Function() call, {Duration? timeout}) async {
    if (client.isClosed) throw MailException(MailErrorKind.connection, 'Not connected to $host.');
    final result = Completer<T>();
    final pending = runQuietly(call);
    unawaited(
      pending.then(
        (v) {
          if (!result.isCompleted) result.complete(v);
        },
        onError: (Object e, StackTrace s) {
          if (!result.isCompleted) result.completeError(e, s);
        },
      ),
    );
    unawaited(
      client.closed.then((_) {
        if (!result.isCompleted) {
          result.completeError(MailException(MailErrorKind.connection, 'Lost the connection to $host.'));
        }
      }),
    );
    try {
      return await result.future.timeout(timeout ?? defaultCommandTimeout);
    } on TimeoutException {
      unawaited(close());
      throw MailException(MailErrorKind.connection, '$host stopped responding.');
    } on ImapException catch (e) {
      final message = e.message ?? 'Command failed';
      if (message == 'timeout') {
        unawaited(close());
        throw MailException(MailErrorKind.connection, '$host stopped responding.');
      }
      throw MailException(MailErrorKind.server, message.trim(), e);
    } on MailException {
      rethrow;
    } catch (e) {
      // Socket write errors and the like.
      unawaited(close());
      throw MailException(MailErrorKind.connection, 'Lost the connection to $host.', e);
    }
  }

  /// The mailbox argument for a command (modified UTF-7, quoted).
  String mailboxArg(String path) => path.toUpperCase() == 'INBOX' ? 'INBOX' : quoteImap(encodeModifiedUtf7(path));

  /// Selects [path] (always issues SELECT, to get fresh UIDNEXT/MODSEQ).
  Future<SelectData> select(String path, {bool condstore = false}) async {
    selectedPath = null;
    selectData = null;
    final args = condstore && supportsCondstore ? ' (CONDSTORE)' : '';
    try {
      final data = await send(Command('SELECT ${mailboxArg(path)}$args'), SelectParser());
      selectedPath = path;
      selectData = data;
      return data;
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server) rethrow;
      throw MailException(MailErrorKind.notFound, 'Couldn’t open mailbox “$path”: ${e.message}', e.cause);
    }
  }

  /// Selects [path] unless it is already selected.
  Future<SelectData> ensureSelected(String path) async {
    final data = selectData;
    if (selectedPath == path && data != null) return data;
    return select(path, condstore: supportsCondstore);
  }

  /// Selects [path] through enough_mail, so its IDLE support works.
  Future<void> selectForIdle(String path, String? delimiter) async {
    final encoded = mailboxArg(path);
    final inner = encoded.startsWith('"') ? encoded.substring(1, encoded.length - 1) : encoded;
    final box = em.Mailbox(encodedName: inner, encodedPath: inner, flags: [], pathSeparator: delimiter ?? '/');
    await guard(() => client.selectMailbox(box));
    selectedPath = path;
  }

  /// APPENDs [data] as a binary literal.
  Future<GenericResult> append(String path, Uint8List data, List<String> flags) {
    final flagList = flags.isEmpty ? '' : ' (${flags.join(' ')})';
    return sendLiteral(
      'APPEND ${mailboxArg(path)}$flagList {${data.length}}',
      data,
      '',
      GenericParser(),
      timeout: const Duration(minutes: 5),
    );
  }

  /// Sends [head] (ending in a `{n}` literal announcement), then, once the
  /// server asks for it, the [literal] bytes followed by [tail] and CRLF.
  Future<T> sendLiteral<T>(
    String head,
    Uint8List literal,
    String tail,
    ResponseParser<T> parser, {
    Duration? timeout,
  }) async {
    client._pendingLiteral = Uint8List.fromList([...literal, ...utf8.encode(tail)]);
    try {
      return await send(Command(head), parser, timeout: timeout);
    } finally {
      client._pendingLiteral = null;
    }
  }

  /// Logs out (best effort) and closes the socket.
  Future<void> close() async {
    if (client.isClosed) return;
    try {
      await runQuietly(client.disconnect);
    } catch (_) {
      // Already gone.
    }
  }

  /// Sends LOGOUT, then closes.
  Future<void> logout() async {
    if (isOpen) {
      try {
        await send(Command('LOGOUT'), GenericParser(), timeout: const Duration(seconds: 5));
      } on MailException {
        // Closing anyway.
      }
    }
    await close();
  }
}
