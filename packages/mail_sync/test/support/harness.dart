import 'dart:async';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:fake_async/fake_async.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_sync/mail_sync.dart';

import 'fake_server.dart';

/// Runs [body] in fake time: timers fire as fake time advances, so polling,
/// backoff and undo delays take no real time. Fails if [body] needs more
/// than [limit] of fake time; [step] is how often it checks.
void fakeTime(
  Future<void> Function(FakeAsync async) body, {
  Duration limit = const Duration(hours: 5),
  Duration step = const Duration(milliseconds: 100),
}) {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  fakeAsync((async) {
    var done = false;
    Object? error;
    StackTrace? trace;
    body(async).then<void>(
      (_) => done = true,
      onError: (Object e, StackTrace st) {
        error = e;
        trace = st;
        done = true;
      },
    );
    final start = async.elapsed;
    while (!done) {
      if (async.elapsed - start > limit) throw StateError('The test did not finish in fake time');
      async.elapse(step);
    }
    if (error != null) Error.throwWithStackTrace(error!, trace!);
  }, initialTime: DateTime(2026, 9, 1, 12));
}

/// Lets background work (syncs, replays) run.
Future<void> settle([Duration d = const Duration(seconds: 2)]) => Future<void>.delayed(d);

const fastConfig = SyncConfig(
  pollInterval: Duration(minutes: 5),
  reconnectBase: Duration(seconds: 5),
  reconnectMax: Duration(minutes: 1),
  opRetryBase: Duration(seconds: 10),
  maxOpAttempts: 3,
  sendRetryBase: Duration(seconds: 30),
);

final class Harness {
  Harness({SyncConfig config = fastConfig, OAuthRefresher? refreshOAuth, MailStore? store})
    : store = store ?? MailStore.memory() {
    repo = LiveMailRepository(this.store, factory, credentials, config: config, refreshOAuth: refreshOAuth);
  }

  final MailStore store;
  final factory = FakeTransportFactory();
  final credentials = FakeCredentialStore();
  late final LiveMailRepository repo;
  final errors = <MailException>[];
  StreamSubscription<MailException>? _errorsSub;

  AccountSetup setup(
    String email, {
    String password = 'secret',
    ProviderKind provider = ProviderKind.generic,
    Credentials? credentials,
  }) => AccountSetup(
    email: email,
    displayName: provider == ProviderKind.gmail ? 'Gmail' : 'Work',
    provider: provider,
    incoming: const ServerConfig(protocol: ServerProtocol.imap, host: 'imap.example.com', port: 993),
    outgoing: const ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.example.com', port: 465),
    credentials: credentials ?? PasswordCredentials(password),
    senderName: 'Me',
  );

  /// Adds an account served by [server] and waits for the initial sync.
  Future<MailAccount> add(
    FakeServer server, {
    String email = 'me@example.com',
    ProviderKind provider = ProviderKind.generic,
  }) async {
    _errorsSub ??= repo.errors.listen(errors.add);
    factory.serve(email, server);
    final account = await repo.addAccount(setup(email, provider: provider));
    await settle();
    return account;
  }

  String mailbox(MailAccount a, String path) => MailIds.mailbox(a.id, path);

  /// Subjects stored in a mailbox, newest first (doesn't trigger a sync).
  Future<List<String>> subjects(MailAccount a, String path) async => [
    for (final t in await store.watchList(RealMailboxRef(mailbox(a, path)), threaded: false).first) t.latest.subject,
  ];

  Future<EmailSummary> email(MailAccount a, String path, String subject) async {
    final list = await store.watchList(RealMailboxRef(mailbox(a, path)), threaded: false).first;
    return list.firstWhere((t) => t.latest.subject == subject).latest;
  }

  Future<AccountSyncStatus> status(MailAccount a) async =>
      (await repo.watchSyncStatus().first).firstWhere((s) => s.accountId == a.id);

  Future<void> dispose() async {
    unawaited(_errorsSub?.cancel());
    await repo.dispose();
    await store.close();
  }
}
