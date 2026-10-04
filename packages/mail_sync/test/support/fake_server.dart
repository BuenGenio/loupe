import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

/// A message on the fake server.
final class FakeMessage {
  FakeMessage({
    required this.uid,
    required this.subject,
    required this.from,
    required this.receivedAt,
    this.to = const [],
    this.cc = const [],
    this.messageId,
    this.inReplyTo,
    this.references = const [],
    Set<String> keywords = const {},
    this.text = '',
    this.gmailThreadId,
    this.size = 1000,
  }) : keywords = {...keywords};

  int uid;
  final String subject;
  final EmailAddress from;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final String? messageId;
  final String? inReplyTo;
  final List<String> references;
  Set<String> keywords;
  final String text;
  final DateTime receivedAt;
  final String? gmailThreadId;
  final int size;
  int modseq = 0;

  FakeMessage copy(int newUid) => FakeMessage(
    uid: newUid,
    subject: subject,
    from: from,
    receivedAt: receivedAt,
    to: to,
    cc: cc,
    messageId: messageId,
    inReplyTo: inReplyTo,
    references: references,
    keywords: keywords,
    text: text,
    gmailThreadId: gmailThreadId,
    size: size,
  );
}

final class FakeMailbox {
  FakeMailbox(this.path, this.role);
  final String path;
  final MailboxRole role;
  int uidValidity = 1;
  int uidNext = 1;
  int modseq = 1;
  final messages = SplayTreeMap<int, FakeMessage>();

  /// uid → modseq of the expunge.
  final expunged = <int, int>{};

  int get unread => messages.values.where((m) => !m.keywords.contains(Keywords.seen)).length;
}

/// One message handed to SMTP.
final class SentMail {
  SentMail(this.bytes, this.envelopeFrom, this.recipients);
  final Uint8List bytes;
  final String envelopeFrom;
  final List<String> recipients;
  Map<String, Object?> get json => (jsonDecode(utf8.decode(bytes)) as Map).cast();
}

/// An in-memory mail server: mailboxes, messages, flags, expunges,
/// UIDVALIDITY changes, IDLE notifications, injected failures and latency.
final class FakeServer {
  FakeServer({this.password = 'secret', this.gmail = false, this.idle = true, this.uidPlus = true}) {
    if (gmail) {
      for (final (path, role) in const [
        ('INBOX', MailboxRole.inbox),
        ('[Gmail]/Sent Mail', MailboxRole.sent),
        ('[Gmail]/Drafts', MailboxRole.drafts),
        ('[Gmail]/All Mail', MailboxRole.all),
        ('[Gmail]/Trash', MailboxRole.trash),
        ('[Gmail]/Spam', MailboxRole.junk),
      ]) {
        addMailbox(path, role: role);
      }
    } else {
      for (final (path, role) in const [
        ('INBOX', MailboxRole.inbox),
        ('Sent', MailboxRole.sent),
        ('Drafts', MailboxRole.drafts),
        ('Archive', MailboxRole.archive),
        ('Trash', MailboxRole.trash),
        ('Junk', MailboxRole.junk),
        ('Work', MailboxRole.none),
      ]) {
        addMailbox(path, role: role);
      }
    }
  }

  String password;
  final bool gmail;
  bool idle;
  bool uidPlus;

  /// While true every operation fails with a connection error.
  bool offline = false;
  Duration latency = Duration.zero;

  /// Operation name → error thrown once.
  final failOnce = <String, MailException>{};

  /// Operation name → error thrown until removed.
  final failAlways = <String, MailException>{};

  /// Error thrown by SMTP until cleared.
  MailException? smtpFailure;

  /// Overrides server search results (ids).
  List<String> Function(SearchExpr expr, String? path)? onSearch;

  final mailboxes = <String, FakeMailbox>{};
  final log = <String>[];
  final sent = <SentMail>[];
  final transports = <FakeTransport>[];
  int connects = 0;
  final _watchers = <String, List<StreamController<void>>>{};
  int _clock = 0;

  FakeMailbox addMailbox(String path, {MailboxRole role = MailboxRole.none}) =>
      mailboxes[path] = FakeMailbox(path, role);

  FakeMailbox box(String path) => mailboxes[path]!;

  String get allMailPath => '[Gmail]/All Mail';

  /// Delivers a new message to [path] (Gmail: also to All Mail).
  FakeMessage deliver(
    String path, {
    String subject = 'Hello',
    String from = 'alice@example.com',
    String? fromName,
    List<String> to = const ['me@example.com'],
    String? messageId,
    String? inReplyTo,
    List<String> references = const [],
    Set<String> keywords = const {},
    String text = '',
    DateTime? at,
  }) {
    final mb = box(path);
    final m = FakeMessage(
      uid: mb.uidNext++,
      subject: subject,
      from: EmailAddress(from, fromName),
      to: [for (final t in to) EmailAddress(t)],
      messageId: messageId ?? 'm${++_clock}@example.com',
      inReplyTo: inReplyTo,
      references: references,
      keywords: keywords,
      text: text,
      receivedAt: at ?? DateTime(2026, 9, 1).add(Duration(minutes: ++_clock)),
      gmailThreadId: gmail
          ? 'thr-${references.isNotEmpty ? references.first : (inReplyTo ?? messageId ?? _clock)}'
          : null,
    );
    _add(mb, m);
    if (gmail && path != allMailPath && mailboxes.containsKey(allMailPath)) {
      final all = box(allMailPath);
      _add(all, m.copy(all.uidNext++));
    }
    return m;
  }

  void _add(FakeMailbox mb, FakeMessage m) {
    m.modseq = ++mb.modseq;
    mb.messages[m.uid] = m;
    notify(mb.path);
  }

  void setFlags(String path, int uid, Set<String> keywords) {
    final mb = box(path);
    final m = mb.messages[uid]!;
    m.keywords = {...keywords};
    m.modseq = ++mb.modseq;
    notify(path);
  }

  void expunge(String path, int uid) {
    final mb = box(path);
    mb.messages.remove(uid);
    mb.expunged[uid] = ++mb.modseq;
    notify(path);
  }

  /// Changes UIDVALIDITY and renumbers all messages.
  void resetUidValidity(String path) {
    final mb = box(path);
    final old = mb.messages.values.toList();
    mb.messages.clear();
    mb.expunged.clear();
    mb.uidValidity++;
    mb.uidNext = 1;
    for (final m in old) {
      final c = m.copy(mb.uidNext++);
      c.modseq = ++mb.modseq;
      mb.messages[c.uid] = c;
    }
    notify(path);
  }

  void notify(String path) {
    for (final c in [...?_watchers[path]]) {
      if (!c.isClosed) c.add(null);
    }
  }

  /// Drops every connection (network change).
  Future<void> dropConnections() async {
    for (final t in transports) {
      await t.disconnect();
    }
  }

  /// Finds a message by subject in [path].
  FakeMessage? find(String path, String subject) =>
      box(path).messages.values.where((m) => m.subject == subject).firstOrNull;

  List<String> subjects(String path) => [for (final m in box(path).messages.values) m.subject];
}

/// A [MailTransport] over a [FakeServer].
final class FakeTransport implements MailTransport {
  FakeTransport(this.server, this.account, this.credentials);

  final FakeServer server;
  final MailAccount account;
  final CredentialsCallback credentials;
  bool _connected = false;
  final _watches = <StreamController<void>>[];
  int calls = 0;

  @override
  String get accountId => account.id;

  @override
  TransportCapabilities get capabilities => TransportCapabilities(
    supportsIdle: server.idle,
    supportsMove: true,
    supportsCondstore: true,
    supportsGmailExtensions: server.gmail,
  );

  @override
  bool get isConnected => _connected;

  Future<void> _delay() async {
    if (server.latency > Duration.zero) await Future<void>.delayed(server.latency);
  }

  Future<void> _op(String name) async {
    calls++;
    await _delay();
    if (server.offline) {
      await disconnect();
      throw const MailException(MailErrorKind.connection, 'Server unreachable');
    }
    if (!_connected) throw const MailException(MailErrorKind.connection, 'Connection lost');
    final f = server.failOnce.remove(name) ?? server.failAlways[name];
    if (f != null) throw f;
    server.log.add(name);
  }

  @override
  Future<void> connect() async {
    await _delay();
    if (server.offline) throw const MailException(MailErrorKind.connection, 'Server unreachable');
    final c = await credentials();
    if (c is PasswordCredentials && c.password != server.password) {
      throw const MailException(MailErrorKind.authentication, 'Password rejected');
    }
    final f = server.failOnce.remove('connect') ?? server.failAlways['connect'];
    if (f != null) throw f;
    _connected = true;
    server.connects++;
    if (!server.transports.contains(this)) server.transports.add(this);
  }

  @override
  Future<void> disconnect() async {
    _connected = false;
    for (final c in [..._watches]) {
      unawaited(c.close());
    }
    _watches.clear();
  }

  String _mailboxId(FakeMailbox mb) => MailIds.mailbox(account.id, mb.path);
  String _id(FakeMailbox mb, int uid) => MailIds.imapEmail(account.id, mb.path, mb.uidValidity, uid);

  EmailSummary _summary(FakeMailbox mb, FakeMessage m) => EmailSummary(
    id: _id(mb, m.uid),
    accountId: account.id,
    mailboxId: _mailboxId(mb),
    receivedAt: m.receivedAt,
    sentAt: m.receivedAt,
    threadId: m.gmailThreadId,
    messageIdHeader: m.messageId,
    inReplyTo: m.inReplyTo,
    references: m.references,
    from: [m.from],
    to: m.to,
    cc: m.cc,
    subject: m.subject,
    preview: m.text.length > 256 ? m.text.substring(0, 256) : m.text,
    size: m.size,
    keywords: {...m.keywords},
  );

  (FakeMailbox, FakeMessage)? _find(String emailId) {
    final p = MailIds.parseImapEmail(emailId);
    if (p == null) return null;
    final mb = server.mailboxes[p.path];
    if (mb == null || mb.uidValidity != p.uidValidity) return null;
    final m = mb.messages[p.uid];
    return m == null ? null : (mb, m);
  }

  FakeMailbox _box(RemoteMailbox remote) =>
      server.mailboxes[remote.path] ?? (throw const MailException(MailErrorKind.notFound, 'No such mailbox'));

  @override
  Future<List<RemoteMailbox>> listMailboxes() async {
    await _op('list');
    return [
      for (final mb in server.mailboxes.values)
        RemoteMailbox(
          path: mb.path,
          name: mb.path.split('/').last,
          role: mb.role,
          parentPath: mb.path.contains('/') ? mb.path.substring(0, mb.path.lastIndexOf('/')) : null,
        ),
    ];
  }

  MailboxSyncState _state(FakeMailbox mb, int oldest) =>
      MailboxSyncState({'uv': mb.uidValidity, 'next': mb.uidNext, 'oldest': oldest, 'modseq': mb.modseq});

  @override
  Future<MailboxSyncResult> syncMailbox(
    RemoteMailbox mailbox,
    MailboxSyncState? previous, {
    int initialWindow = 200,
  }) async {
    await _op('sync:${mailbox.path}');
    final mb = _box(mailbox);
    final uids = mb.messages.keys.toList();
    final prev = previous?.data;
    if (prev == null || prev['uv'] != mb.uidValidity) {
      final window = uids.length > initialWindow ? uids.sublist(uids.length - initialWindow) : uids;
      final oldest = window.isEmpty ? mb.uidNext : window.first;
      return MailboxSyncResult(
        state: _state(mb, oldest),
        added: [for (final u in window) _summary(mb, mb.messages[u]!)],
        resetAll: prev != null,
        totalCount: uids.length,
        unreadCount: mb.unread,
        hasOlder: uids.any((u) => u < oldest),
      );
    }
    final next = prev['next']! as int;
    final oldest = prev['oldest']! as int;
    final modseq = prev['modseq']! as int;
    return MailboxSyncResult(
      state: _state(mb, oldest),
      added: [
        for (final m in mb.messages.values)
          if (m.uid >= next) _summary(mb, m),
      ],
      keywordUpdates: {
        for (final m in mb.messages.values)
          if (m.uid >= oldest && m.uid < next && m.modseq > modseq) _id(mb, m.uid): {...m.keywords},
      },
      vanishedIds: [
        for (final MapEntry(key: uid, value: seq) in mb.expunged.entries)
          if (uid >= oldest && uid < next && seq > modseq) _id(mb, uid),
      ],
      totalCount: uids.length,
      unreadCount: mb.unread,
      hasOlder: uids.any((u) => u < oldest),
    );
  }

  @override
  Future<MailboxSyncResult> fetchOlder(RemoteMailbox mailbox, MailboxSyncState state, {int count = 100}) async {
    await _op('older:${mailbox.path}');
    final mb = _box(mailbox);
    final oldest = state.data['oldest']! as int;
    final older = mb.messages.keys.where((u) => u < oldest).toList();
    final page = older.length > count ? older.sublist(older.length - count) : older;
    final newOldest = page.isEmpty ? oldest : page.first;
    return MailboxSyncResult(
      state: MailboxSyncState({...state.data, 'oldest': newOldest}),
      added: [for (final u in page) _summary(mb, mb.messages[u]!)],
      totalCount: mb.messages.length,
      unreadCount: mb.unread,
      hasOlder: mb.messages.keys.any((u) => u < newOldest),
    );
  }

  @override
  Future<List<EmailSummary>> fetchSummaries(List<String> emailIds) async {
    await _op('fetchSummaries');
    return [
      for (final id in emailIds)
        if (_find(id) case (final mb, final m)) _summary(mb, m),
    ];
  }

  @override
  Future<EmailContent> fetchContent(String emailId) async {
    await _op('content');
    final (_, m) = _find(emailId) ?? (throw const MailException(MailErrorKind.notFound, 'Message not found'));
    return EmailContent(emailId: emailId, text: m.text, headers: [('Subject', m.subject), ('X-Fake', 'yes')]);
  }

  @override
  Future<Uint8List> fetchAttachment(String emailId, String partId) async {
    await _op('attachment');
    if (_find(emailId) == null) throw const MailException(MailErrorKind.notFound, 'Message not found');
    return Uint8List.fromList(utf8.encode('part $partId'));
  }

  @override
  Future<Uint8List> fetchRaw(String emailId) async {
    await _op('raw');
    final (_, m) = _find(emailId) ?? (throw const MailException(MailErrorKind.notFound, 'Message not found'));
    return Uint8List.fromList(utf8.encode('Subject: ${m.subject}\r\n\r\n${m.text}'));
  }

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) async {
    await _op('setKeywords');
    for (final id in emailIds) {
      final found = _find(id);
      if (found == null) continue;
      final (mb, m) = found;
      m.keywords = {...m.keywords.difference(remove), ...add};
      m.modseq = ++mb.modseq;
    }
  }

  @override
  Future<Map<String, String>> move(List<String> emailIds, RemoteMailbox target) async {
    await _op('move');
    final tgt = _box(target);
    final out = <String, String>{};
    for (final id in emailIds) {
      final found = _find(id);
      if (found == null) continue;
      final (mb, m) = found;
      if (identical(mb, tgt)) continue;
      mb.messages.remove(m.uid);
      mb.expunged[m.uid] = ++mb.modseq;
      // Gmail: the message is already in All Mail; moving there only drops the label.
      final existing = server.gmail && tgt.role == MailboxRole.all
          ? tgt.messages.values.where((x) => x.messageId == m.messageId).firstOrNull
          : null;
      final uid = existing?.uid ?? tgt.uidNext++;
      if (existing == null) {
        final c = m.copy(uid)..modseq = ++tgt.modseq;
        tgt.messages[uid] = c;
      }
      if (server.uidPlus) out[id] = _id(tgt, uid);
      server.notify(mb.path);
    }
    server.notify(tgt.path);
    return out;
  }

  @override
  Future<void> deletePermanently(List<String> emailIds) async {
    await _op('delete');
    for (final id in emailIds) {
      final found = _find(id);
      if (found == null) continue;
      final (mb, m) = found;
      mb.messages.remove(m.uid);
      mb.expunged[m.uid] = ++mb.modseq;
    }
  }

  @override
  Future<List<String>> search(SearchExpr expr, {RemoteMailbox? mailbox, int limit = 200}) async {
    await _op('search');
    final custom = server.onSearch;
    if (custom != null) return custom(expr, mailbox?.path);
    final words = <String>[];
    void collect(SearchExpr e) {
      switch (e) {
        case TextTerm(:final value):
          words.add(value.toLowerCase());
        case SearchAnd(:final children) || SearchOr(:final children):
          children.forEach(collect);
        default:
      }
    }

    collect(expr);
    final boxes = mailbox != null
        ? [_box(mailbox)]
        : server.gmail
        ? [server.box(server.allMailPath)]
        : server.mailboxes.values.toList();
    final out = <String>[];
    for (final mb in boxes) {
      for (final m in mb.messages.values) {
        final hay = '${m.subject} ${m.text}'.toLowerCase();
        if (words.isEmpty || words.any(hay.contains)) out.add(_id(mb, m.uid));
      }
    }
    return out.take(limit).toList();
  }

  @override
  Future<String?> append(RemoteMailbox mailbox, Uint8List rfc822, {Set<String> keywords = const {}}) async {
    await _op('append:${mailbox.path}');
    final mb = _box(mailbox);
    final j = (jsonDecode(utf8.decode(rfc822)) as Map).cast<String, Object?>();
    final m = FakeMessage(
      uid: mb.uidNext++,
      subject: j['subject']! as String,
      from: EmailAddress(j['from']! as String),
      to: [for (final t in j['to']! as List<Object?>) EmailAddress(t! as String)],
      messageId: j['messageId'] as String?,
      inReplyTo: j['inReplyTo'] as String?,
      text: j['text']! as String,
      keywords: keywords,
      receivedAt: DateTime.fromMillisecondsSinceEpoch(j['date']! as int),
    );
    server._add(mb, m);
    return server.uidPlus ? _id(mb, m.uid) : null;
  }

  @override
  Stream<void> watch(RemoteMailbox mailbox) {
    final c = StreamController<void>();
    if (!_connected || server.offline) {
      scheduleMicrotask(c.close);
      return c.stream;
    }
    _watches.add(c);
    (server._watchers[mailbox.path] ??= []).add(c);
    c.onCancel = () {
      server._watchers[mailbox.path]?.remove(c);
      _watches.remove(c);
    };
    return c.stream;
  }
}

/// Builds messages as JSON so the fake server can read them back.
final class FakeComposer implements MessageComposer {
  @override
  Uint8List compose(OutgoingMessage message, Identity from, {required String messageId, DateTime? date}) =>
      Uint8List.fromList(
        utf8.encode(
          jsonEncode({
            'messageId': messageId,
            'from': from.email,
            'to': [for (final a in message.to) a.email],
            'cc': [for (final a in message.cc) a.email],
            'subject': message.subject,
            'text': message.text,
            'inReplyTo': message.inReplyTo,
            'date': (date ?? DateTime(2026)).millisecondsSinceEpoch,
          }),
        ),
      );
}

final class FakeSender implements MailSender {
  FakeSender(this.server);
  final FakeServer server;

  @override
  Future<void> send(Uint8List rfc822, {required String envelopeFrom, required List<String> recipients}) async {
    if (server.latency > Duration.zero) await Future<void>.delayed(server.latency);
    if (server.offline) throw const MailException(MailErrorKind.connection, 'Server unreachable');
    final f = server.smtpFailure;
    if (f != null) throw f;
    server.sent.add(SentMail(rfc822, envelopeFrom, recipients));
  }

  @override
  Future<void> close() async {}
}

/// Routes accounts to fake servers by email address.
final class FakeTransportFactory implements TransportFactory {
  final servers = <String, FakeServer>{};
  final created = <FakeTransport>[];

  FakeServer serve(String email, FakeServer server) => servers[email] = server;

  @override
  MailTransport createTransport(MailAccount account, CredentialsCallback credentials) {
    final t = FakeTransport(servers[account.email]!, account, credentials);
    created.add(t);
    return t;
  }

  @override
  MailSender createSender(MailAccount account, CredentialsCallback credentials) => FakeSender(servers[account.email]!);

  @override
  final MessageComposer composer = FakeComposer();

  @override
  Future<AccountDiscovery> discover(String email) async => AccountDiscovery(
    email: email,
    provider: ProviderKind.generic,
    authKind: AuthKind.password,
    incoming: ServerConfig(protocol: ServerProtocol.imap, host: 'imap.${email.split('@').last}', port: 993),
    outgoing: ServerConfig(protocol: ServerProtocol.smtp, host: 'smtp.${email.split('@').last}', port: 465),
    source: 'fake',
  );
}

final class FakeCredentialStore implements CredentialStore {
  final values = <String, Credentials>{};

  @override
  Future<Credentials?> read(String accountId) async => values[accountId];

  @override
  Future<void> write(String accountId, Credentials credentials) async => values[accountId] = credentials;

  @override
  Future<void> delete(String accountId) async => values.remove(accountId);
}
