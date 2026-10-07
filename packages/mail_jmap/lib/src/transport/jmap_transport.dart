/// [MailTransport] over JMAP (RFC 8620, RFC 8621).
library;

import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:expr_search/expr_search.dart';
import 'package:http/http.dart' as http;
import 'package:mail_imap/mime.dart';
import 'package:mail_model/mail_model.dart';

import '../client/client.dart';
import '../client/errors.dart';
import '../client/event_source.dart';
import '../client/request.dart';
import '../client/session.dart';
import 'email_mapping.dart';
import 'mailboxes.dart';
import 'sync_state.dart';

const _newestFirst = [
  {'property': 'receivedAt', 'isAscending': false},
];

/// JMAP implementation of [MailTransport].
///
/// Stateless HTTP underneath: "connected" means the session resource was
/// fetched and names a mail account. One instance per use, as for IMAP (the
/// sync engine keeps one for syncing, one for searches and one for [watch]).
///
/// **Copies.** A JMAP email can be in several mailboxes. Like an IMAP
/// folder, each mailbox has its own copy of it here, with its own id
/// ([MailIds.jmapEmailIn]): syncing a mailbox reports the emails in it,
/// moving a copy takes the email out of its mailbox and puts it in the
/// target (other mailboxes keep theirs), deleting a copy for good destroys
/// the email only when no other mailbox has it. Keywords belong to the
/// email, so every copy shows a change at its mailbox's next sync.
///
/// **Sync.** `Email/changes` is per account: each mailbox's state holds the
/// account's `Email` state at its last sync and the emails in its window,
/// and a sync looks at what changed since (created, updated, destroyed;
/// `mailboxIds` and `keywords` of the changed ones). The first sync is an
/// `Email/query` of the newest emails by `receivedAt`. When the server can't
/// calculate the changes (or there are too many), the window is checked
/// against the server instead, keeping what is stored.
final class JmapTransport implements MailTransport {
  JmapTransport(
    this.account,
    CredentialsCallback credentials, {
    http.Client? httpClient,
    this.pollInterval = const Duration(minutes: 1),
    this.pushPing = const Duration(seconds: 60),
    this.maxChangeRounds = 20,
  }) : _client = JmapClient(
         server: account.incoming,
         login: account.incoming.username ?? account.email,
         credentials: credentials,
         httpClient: httpClient,
       );

  final MailAccount account;
  final JmapClient _client;

  /// How often [watch] asks for the `Email` state when the server has no
  /// push (`eventSourceUrl`).
  final Duration pollInterval;

  /// The keep-alive interval [watch] asks the push stream for; a stream
  /// silent for three of them (and half a minute) counts as dropped.
  final Duration pushPing;

  /// `Email/changes` calls per sync before the window is checked against
  /// the server instead.
  final int maxChangeRounds;

  bool _wanted = false;
  bool _connected = false;
  String? _mailAccount;
  MailboxDirectory? _boxes;
  TransportCapabilities _capabilities = const TransportCapabilities();

  @override
  String get accountId => account.id;

  @override
  TransportCapabilities get capabilities => _capabilities;

  @override
  bool get isConnected => _connected;

  /// The session, once connected.
  JmapSession? get session => _client.currentSession;

  /// The JMAP client, for the sender and server rules.
  JmapClient get client => _client;

  String get _host => account.incoming.host;
  String get _account => _mailAccount!;

  // Connection ---------------------------------------------------------------

  @override
  Future<void> connect() async {
    _wanted = true;
    if (_connected) return;
    if (account.incoming.protocol != ServerProtocol.jmap) {
      throw const MailException(MailErrorKind.unsupported, 'This account doesn’t use JMAP.');
    }
    final s = await _client.session(refresh: true);
    final mail = s.primaryAccount(JmapCapabilities.mail);
    if (mail == null || !s.has(JmapCapabilities.mail)) {
      throw MailException(MailErrorKind.unsupported, '$_host offers no mail account for this login over JMAP.');
    }
    _mailAccount = mail;
    _capabilities = TransportCapabilities(
      // Push (EventSource) or a cheap state poll: either way, watch works.
      supportsIdle: true,
      supportsCondstore: true,
      supportsQresync: true,
      supportsMove: true,
      supportsUtf8: true,
      raw: Set.unmodifiable(s.capabilities.keys),
    );
    _connected = true;
  }

  @override
  Future<void> disconnect() async {
    _wanted = false;
    _connected = false;
    _boxes = null;
    _client.close();
  }

  /// Runs [body], connecting again when a call after [connect] finds the
  /// transport disconnected, and turns unexpected errors into
  /// [MailException]s.
  Future<T> _run<T>(Future<T> Function() body) async {
    if (!_connected) {
      if (!_wanted) throw const MailException(MailErrorKind.connection, 'Not connected.');
      await connect();
    }
    try {
      return await body();
    } on MailException {
      rethrow;
    } on Object catch (e) {
      throw MailException(MailErrorKind.unknown, 'Unexpected response from $_host.', e);
    }
  }

  Future<JmapResponse> _call(JmapRequest request) => _client.call(request);

  int get _maxGet => _client.currentSession?.maxObjectsInGet ?? 500;
  int get _maxSet => _client.currentSession?.maxObjectsInSet ?? 500;
  int get _maxCalls => _client.currentSession?.maxCallsInRequest ?? 16;

  static List<Json> _list(Json args, [String key = 'list']) => [
    for (final e in args[key] as List? ?? const [])
      if (e is Map) e.cast<String, Object?>(),
  ];

  // Mailboxes ----------------------------------------------------------------

  Future<MailboxDirectory> _directory({bool refresh = false}) async {
    final known = _boxes;
    if (known != null && !refresh) return known;
    final request = JmapRequest();
    final get = request.add('Mailbox/get', {'accountId': _account, 'properties': mailboxProperties});
    final args = (await _call(request)).of(get);
    return _boxes = MailboxDirectory([
      for (final m in _list(args)) JmapMailbox.fromJson(m),
    ], state: args['state'] as String?);
  }

  @override
  Future<List<RemoteMailbox>> listMailboxes() => _run(() async {
    final known = _boxes;
    final state = known?.state;
    if (known != null && state != null) {
      // Only the counts changed (or nothing): the list is still right.
      final request = JmapRequest();
      final changes = request.add('Mailbox/changes', {'accountId': _account, 'sinceState': state});
      final response = await _call(request);
      final c = response.errorOf(changes) == null ? response.of(changes) : null;
      if (c != null &&
          c['hasMoreChanges'] != true &&
          stringList(c['created']).isEmpty &&
          stringList(c['destroyed']).isEmpty &&
          (stringList(c['updated']).isEmpty || c['updatedProperties'] != null)) {
        return known.remote;
      }
    }
    return (await _directory(refresh: true)).remote;
  });

  /// The JMAP id of the mailbox at [path]; the list is fetched again once
  /// when it isn't known.
  Future<String> _mailboxIdOf(String path) async {
    final id = (await _directory()).idOf(path) ?? (await _directory(refresh: true)).idOf(path);
    if (id == null) throw MailException(MailErrorKind.notFound, 'Folder “$path” no longer exists.');
    return id;
  }

  @override
  Future<void> setSubscribed(RemoteMailbox mailbox, bool subscribed) => _run(() async {
    final dir = await _directory(refresh: true);
    final id = dir.idOf(mailbox.path);
    if (id == null) {
      // A mailbox that is gone needs no unsubscribing.
      if (subscribed) throw MailException(MailErrorKind.notFound, 'Folder “${mailbox.name}” no longer exists.');
      return;
    }
    final request = JmapRequest();
    final set = request.add('Mailbox/set', {
      'accountId': _account,
      'update': {
        id: {'isSubscribed': subscribed},
      },
    });
    final error = _setErrors((await _call(request)).of(set), 'notUpdated')[id];
    _boxes = null;
    if (error == null) return;
    if (error.kind == MailErrorKind.notFound && !subscribed) return;
    throw error;
  });

  @override
  Future<void> createMailbox(String path) => _run(() async {
    final dir = await _directory(refresh: true);
    if (dir.idOf(path) != null) return;
    final slash = path.lastIndexOf('/');
    String? parentId;
    if (slash > 0) {
      parentId = dir.idOf(path.substring(0, slash));
      if (parentId == null) {
        throw MailException(MailErrorKind.notFound, 'Folder “${path.substring(0, slash)}” doesn’t exist.');
      }
    }
    await _createMailbox(slash > 0 ? path.substring(slash + 1) : path, parentId: parentId, subscribed: true);
  });

  /// Creates a mailbox; one that exists already (another client was
  /// faster) is fine. Returns its id.
  Future<String> _createMailbox(String name, {String? parentId, required bool subscribed}) async {
    final request = JmapRequest();
    final set = request.add('Mailbox/set', {
      'accountId': _account,
      'create': {
        'm': {'name': name, 'parentId': parentId, 'isSubscribed': subscribed},
      },
    });
    final args = (await _call(request)).of(set);
    _boxes = null;
    if (args['created'] case {'m': {'id': final String id}}) return id;
    final error = (args['notCreated'] as Map?)?['m'];
    if (error is Map && error['type'] == 'alreadyExists' && error['existingId'] is String) {
      return error['existingId'] as String;
    }
    final dir = await _directory(refresh: true);
    for (final m in dir.all) {
      if (m.name == name && m.parentId == parentId) return m.id;
    }
    throw setError('Couldn’t create the folder “$name”', error is Map ? error.cast() : const {});
  }

  // Sync ---------------------------------------------------------------------

  @override
  Future<MailboxSyncResult> syncMailbox(RemoteMailbox mailbox, MailboxSyncState? previous, {int initialWindow = 200}) =>
      _run(() async {
        final boxId = await _mailboxIdOf(mailbox.path);
        final prev = JmapSyncState.fromState(previous);
        if (prev == null || prev.accountId != _account || prev.mailboxId != boxId) {
          return _initialSync(mailbox.path, boxId, window: initialWindow, reset: previous != null);
        }
        return _incrementalSync(mailbox.path, boxId, prev, window: initialWindow);
      });

  Future<MailboxSyncResult> _initialSync(String path, String boxId, {required int window, required bool reset}) async {
    final limit = math.max(window, 1);
    final request = JmapRequest();
    // The state before the query: whatever changes after it is in the next
    // Email/changes, even if the query already saw it.
    final state = request.add('Email/get', {
      'accountId': _account,
      'ids': const <String>[],
      'properties': const ['id'],
    });
    final query = request.add('Email/query', {
      'accountId': _account,
      'filter': {'inMailbox': boxId},
      'sort': _newestFirst,
      'limit': limit,
      'calculateTotal': true,
    });
    final get = limit <= _maxGet ? request.add('Email/get', _summaryGet(query.ref('/ids'))) : null;
    final counts = _countsCall(request, boxId);
    final response = await _call(request);
    final emailState = response.of(state)['state']! as String;
    final q = response.of(query);
    final ids = stringList(q['ids']);
    final emails = get != null ? _list(response.of(get)) : await _getEmails(ids, summaryProperties());
    final box = _list(response.of(counts)).firstOrNull;
    final byId = {for (final e in emails) e['id']: e};
    final kept = [
      for (final id in ids)
        if (byId[id] case final e? when idSet(e['mailboxIds']).contains(boxId)) id,
    ];
    final total = (box?['totalEmails'] as num?)?.toInt() ?? (q['total'] as num?)?.toInt() ?? kept.length;
    final next = JmapSyncState(accountId: _account, mailboxId: boxId, emailState: emailState, ids: kept, total: total);
    return MailboxSyncResult(
      state: next.toState(),
      added: [for (final id in kept) summaryOf(byId[id]!, accountId: account.id, path: path)],
      resetAll: reset,
      totalCount: total,
      unreadCount: (box?['unreadEmails'] as num?)?.toInt(),
      hasOlder: next.olderExist,
      canStoreKeywords: true,
    );
  }

  JmapCall _countsCall(JmapRequest request, String boxId) => request.add('Mailbox/get', {
    'accountId': _account,
    'ids': [boxId],
    'properties': const ['totalEmails', 'unreadEmails'],
  });

  Json _summaryGet(Object ids, {bool previews = true}) => {
    'accountId': _account,
    if (ids is List) 'ids': ids else '#ids': ids,
    'properties': summaryProperties(previews: previews),
    'bodyProperties': bodyProperties,
  };

  Future<MailboxSyncResult> _incrementalSync(
    String path,
    String boxId,
    JmapSyncState prev, {
    required int window,
  }) async {
    var since = prev.emailState;
    final destroyed = <String>{};
    final changed = <String, Json>{};
    Json? box;
    for (var round = 0; ; round++) {
      if (round >= maxChangeRounds) return _resync(path, boxId, prev, window: window);
      final request = JmapRequest();
      final changes = request.add('Email/changes', {'accountId': _account, 'sinceState': since, 'maxChanges': _maxGet});
      final created = request.add('Email/get', {
        'accountId': _account,
        '#ids': changes.ref('/created'),
        'properties': const ['id', 'mailboxIds', 'keywords'],
      });
      final updated = request.add('Email/get', {
        'accountId': _account,
        '#ids': changes.ref('/updated'),
        'properties': const ['id', 'mailboxIds', 'keywords'],
      });
      final counts = _countsCall(request, boxId);
      final JmapResponse response;
      final Json c;
      try {
        response = await _call(request);
        c = response.of(changes);
      } on JmapException catch (e) {
        // Stalwart answers a state it doesn't know with invalidArguments,
        // or one it can't parse with a request error.
        if (const {
          'cannotCalculateChanges',
          'invalidArguments',
          'tooManyChanges',
          'notRequest',
          'http400',
        }.contains(e.type)) {
          return _resync(path, boxId, prev, window: window);
        }
        rethrow;
      }
      for (final id in stringList(c['destroyed'])) {
        destroyed.add(id);
        changed.remove(id);
      }
      for (final call in [created, updated]) {
        final args = response.of(call);
        for (final e in _list(args)) {
          final id = e['id'] as String?;
          if (id == null) continue;
          changed[id] = e;
          destroyed.remove(id);
        }
        for (final id in stringList(args['notFound'])) {
          destroyed.add(id);
          changed.remove(id);
        }
      }
      box = _list(response.of(counts)).firstOrNull ?? box;
      since = c['newState'] as String? ?? since;
      if (c['hasMoreChanges'] != true) break;
    }

    final known = prev.ids.toSet();
    final gone = <String>{
      for (final id in destroyed)
        if (known.contains(id)) id,
    };
    final keywordUpdates = <String, Set<String>>{};
    final arrivals = <String>[];
    for (final MapEntry(key: id, value: e) in changed.entries) {
      final inBox = idSet(e['mailboxIds']).contains(boxId);
      if (known.contains(id)) {
        if (inBox) {
          keywordUpdates[MailIds.jmapEmailIn(account.id, path, id)] = keywordsOf(e['keywords']);
        } else {
          gone.add(id);
        }
      } else if (inBox) {
        arrivals.add(id);
      }
    }
    final added = await _summariesIn(arrivals, path, boxId);
    final total = (box?['totalEmails'] as num?)?.toInt() ?? prev.total;
    final next = prev.copyWith(
      emailState: since,
      ids: [
        for (final s in added) MailIds.parseJmapEmail(s.id)!.jmapId,
        for (final id in prev.ids)
          if (!gone.contains(id)) id,
      ],
      total: total,
    );
    return MailboxSyncResult(
      state: next.toState(),
      added: added,
      keywordUpdates: keywordUpdates,
      vanishedIds: [for (final id in gone) MailIds.jmapEmailIn(account.id, path, id)],
      totalCount: total,
      unreadCount: (box?['unreadEmails'] as num?)?.toInt(),
      hasOlder: next.olderExist,
      canStoreKeywords: true,
    );
  }

  /// Brings the window up to date without `Email/changes`: what is still in
  /// the mailbox keeps its row (and cached content), what left vanishes,
  /// and the newest emails not known yet arrive.
  Future<MailboxSyncResult> _resync(String path, String boxId, JmapSyncState prev, {required int window}) async {
    final request = JmapRequest();
    final state = request.add('Email/get', {
      'accountId': _account,
      'ids': const <String>[],
      'properties': const ['id'],
    });
    final query = request.add('Email/query', {
      'accountId': _account,
      'filter': {'inMailbox': boxId},
      'sort': _newestFirst,
      'limit': math.max(window, 1),
      'calculateTotal': true,
    });
    final counts = _countsCall(request, boxId);
    final response = await _call(request);
    final emailState = response.of(state)['state']! as String;
    final top = stringList(response.of(query)['ids']);
    final box = _list(response.of(counts)).firstOrNull;
    final current = {
      for (final e in await _getEmails(prev.ids, const ['id', 'mailboxIds', 'keywords'])) e['id']: e,
    };
    final keywordUpdates = <String, Set<String>>{};
    final gone = <String>[];
    final kept = <String>[];
    for (final id in prev.ids) {
      final e = current[id];
      if (e != null && idSet(e['mailboxIds']).contains(boxId)) {
        kept.add(id);
        keywordUpdates[MailIds.jmapEmailIn(account.id, path, id)] = keywordsOf(e['keywords']);
      } else {
        gone.add(id);
      }
    }
    final keptSet = kept.toSet();
    final added = await _summariesIn(
      [
        for (final id in top)
          if (!keptSet.contains(id)) id,
      ],
      path,
      boxId,
    );
    final total = (box?['totalEmails'] as num?)?.toInt() ?? prev.total;
    final next = prev.copyWith(
      emailState: emailState,
      ids: [for (final s in added) MailIds.parseJmapEmail(s.id)!.jmapId, ...kept],
      total: total,
    );
    return MailboxSyncResult(
      state: next.toState(),
      added: added,
      keywordUpdates: keywordUpdates,
      vanishedIds: [for (final id in gone) MailIds.jmapEmailIn(account.id, path, id)],
      totalCount: total,
      unreadCount: (box?['unreadEmails'] as num?)?.toInt(),
      hasOlder: next.olderExist,
      canStoreKeywords: true,
    );
  }

  /// List rows of [ids] that are in mailbox [boxId] (at [path]), newest
  /// first.
  Future<List<EmailSummary>> _summariesIn(List<String> ids, String path, String boxId, {bool previews = true}) async {
    if (ids.isEmpty) return const [];
    final emails = await _getEmails(ids, summaryProperties(previews: previews));
    final rows = [
      for (final e in emails)
        if (idSet(e['mailboxIds']).contains(boxId)) summaryOf(e, accountId: account.id, path: path),
    ];
    rows.sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
    return rows;
  }

  /// `Email/get` of [ids] in chunks the server takes, several per request.
  Future<List<Json>> _getEmails(List<String> ids, List<String> properties, {Json extra = const {}}) async {
    final unique = ids.toSet().toList();
    final result = <Json>[];
    final chunks = chunksOf(unique, _maxGet).toList();
    for (final group in chunksOf(chunks, _maxCalls)) {
      final request = JmapRequest();
      final calls = [
        for (final chunk in group)
          request.add('Email/get', {
            'accountId': _account,
            'ids': chunk,
            'properties': properties,
            if (properties.contains('bodyStructure')) 'bodyProperties': bodyProperties,
            ...extra,
          }),
      ];
      final response = await _call(request);
      for (final call in calls) {
        result.addAll(_list(response.of(call)));
      }
    }
    return result;
  }

  @override
  Future<MailboxSyncResult> fetchOlder(RemoteMailbox mailbox, MailboxSyncState state, {int count = 100}) =>
      _run(() async {
        final boxId = await _mailboxIdOf(mailbox.path);
        final prev = JmapSyncState.fromState(state);
        if (prev == null || prev.accountId != _account || prev.mailboxId != boxId) {
          return _initialSync(mailbox.path, boxId, window: count, reset: true);
        }
        Json q;
        try {
          q = await _queryPage(boxId, count, anchor: prev.ids.lastOrNull);
        } on JmapException catch (e) {
          if (e.type != 'anchorNotFound') rethrow;
          q = await _queryPage(boxId, count, position: prev.ids.length);
        }
        final known = prev.ids.toSet();
        final page = stringList(q['ids']);
        final fresh = [
          for (final id in page)
            if (!known.contains(id)) id,
        ];
        final added = await _summariesIn(fresh, mailbox.path, boxId);
        final addedIds = {for (final s in added) MailIds.parseJmapEmail(s.id)!.jmapId};
        final total = (q['total'] as num?)?.toInt() ?? prev.total;
        final position = (q['position'] as num?)?.toInt() ?? prev.ids.length;
        final hasOlder = page.isNotEmpty && position + page.length < total;
        final next = prev.copyWith(
          ids: [
            ...prev.ids,
            for (final id in fresh)
              if (addedIds.contains(id)) id,
          ],
          total: hasOlder ? total : math.min(total, prev.ids.length + addedIds.length),
        );
        return MailboxSyncResult(state: next.toState(), added: added, totalCount: total, hasOlder: hasOlder);
      });

  Future<Json> _queryPage(String boxId, int count, {String? anchor, int position = 0}) async {
    final request = JmapRequest();
    final query = request.add('Email/query', {
      'accountId': _account,
      'filter': {'inMailbox': boxId},
      'sort': _newestFirst,
      if (anchor != null) ...{'anchor': anchor, 'anchorOffset': 1} else 'position': position,
      'limit': math.max(count, 1),
      'calculateTotal': true,
    });
    return (await _call(request)).of(query);
  }

  @override
  Future<List<EmailSummary>> fetchSummaries(List<String> emailIds, {bool previews = true}) => _run(() async {
    final result = <EmailSummary>[];
    for (final MapEntry(key: path, value: ids) in _group(emailIds).entries) {
      final boxId = (await _directory()).idOf(path);
      if (boxId == null) continue;
      result.addAll(await _summariesIn(ids.toList(), path, boxId, previews: previews));
    }
    return result;
  });

  // Messages -----------------------------------------------------------------

  @override
  Future<EmailContent> fetchContent(String emailId) => _run(() async {
    final ref = _ref(emailId);
    final request = JmapRequest();
    final get = request.add('Email/get', {
      'accountId': _account,
      'ids': [ref.jmapId],
      'properties': const ['id', 'headers', 'bodyStructure', 'bodyValues'],
      'bodyProperties': bodyProperties,
      'fetchTextBodyValues': true,
      'fetchHTMLBodyValues': true,
    });
    final email = _list((await _call(request)).of(get)).firstOrNull;
    final structure = email?['bodyStructure'];
    if (email == null || structure is! Map) {
      throw const MailException(MailErrorKind.notFound, 'The message no longer exists on the server.');
    }
    return _content(emailId, email, JmapStructure.of(structure.cast()));
  });

  Future<EmailContent> _content(String emailId, Json email, JmapStructure structure) async {
    final root = structure.root;
    final values = email['bodyValues'] is Map ? (email['bodyValues'] as Map).cast<String, Object?>() : const {};
    Future<String?> textOf(BodyNode part) async {
      final value = values[structure.partIdOf(part.section)];
      if (value is Map && value['value'] is String && value['isTruncated'] != true) return value['value'] as String;
      final blob = structure.blobIdOf(part.section);
      if (blob == null) return null;
      return decodeCharset(await _client.download(_account, blob, type: part.mimeType), part.charset);
    }

    Future<String?> join(List<BodyNode> parts, String separator) async {
      final texts = [for (final p in parts) ?await textOf(p)];
      return texts.isEmpty ? null : texts.join(separator);
    }

    final display = selectDisplayParts(root);
    final html = await join(display.html, '\n');
    var text = await join(display.text, '\n\n');
    var flowed = display.text.isNotEmpty && display.text.first.isFlowed;
    if (flowed && text != null && display.text.first.isDelSp) {
      // The model has no DelSp flag: unwrap here and hand over plain text.
      text = unflowText(text, delSp: true);
      flowed = false;
    }
    final inlineData = <String, Uint8List>{};
    await Future.wait([
      for (final a in planContentFetch(root).inline)
        if (structure.blobIdOf(a.partId) case final blob?)
          () async {
            try {
              inlineData[a.contentId!] = await _client.download(_account, blob, type: a.mimeType);
            } on MailException catch (e) {
              if (e.kind == MailErrorKind.connection) rethrow;
              // A part the server can't serve stays a broken image.
            }
          }(),
    ]);
    return EmailContent(
      emailId: emailId,
      html: html,
      text: text,
      isFlowed: flowed,
      attachments: [
        for (final a in listAttachments(root))
          Attachment(
            partId: structure.blobIdOf(a.partId) ?? a.partId,
            mimeType: a.mimeType,
            filename: a.filename,
            size: a.size,
            contentId: a.contentId,
            isInline: a.isInline,
          ),
      ],
      inlineData: inlineData,
      headers: headersOf(email['headers']),
    );
  }

  /// [partId] is the part's JMAP blob id ([Attachment.partId]).
  @override
  Future<Uint8List> fetchAttachment(String emailId, String partId) => _run(() async {
    _ref(emailId);
    return _client.download(_account, partId);
  });

  @override
  Future<Uint8List> fetchRaw(String emailId) => _run(() async {
    final ref = _ref(emailId);
    final request = JmapRequest();
    final get = request.add('Email/get', {
      'accountId': _account,
      'ids': [ref.jmapId],
      'properties': const ['blobId'],
    });
    final blob = _list((await _call(request)).of(get)).firstOrNull?['blobId'] as String?;
    if (blob == null) throw const MailException(MailErrorKind.notFound, 'The message no longer exists on the server.');
    return _client.download(_account, blob, type: 'message/rfc822', name: 'message.eml');
  });

  // Changes ------------------------------------------------------------------

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) =>
      _run(() async {
        final plus = {for (final k in add) Keywords.normalize(k)};
        final minus = {for (final k in remove) Keywords.normalize(k)}.difference(plus);
        if (plus.isEmpty && minus.isEmpty) return;
        final patch = <String, Object?>{
          for (final k in plus) 'keywords/${pointerSegment(k)}': true,
          for (final k in minus) 'keywords/${pointerSegment(k)}': null,
        };
        final ids = {for (final refs in _group(emailIds).values) ...refs}.toList();
        await _update({for (final id in ids) id: patch}, 'Couldn’t update the message');
      });

  /// `Email/set` updates in chunks. Emails the server no longer has are
  /// skipped (their copies vanish at the next sync), unless none was found.
  /// Returns the ids that were updated.
  Future<Set<String>> _update(Map<String, Json> updates, String what, {List<String> destroy = const []}) async {
    final done = <String>{};
    final missing = <String>{};
    final updateIds = updates.keys.toList();
    for (final chunk in chunksOf([...updateIds, ...destroy], _maxSet)) {
      final request = JmapRequest();
      final set = request.add('Email/set', {
        'accountId': _account,
        'update': {for (final id in chunk) id: ?updates[id]},
        'destroy': [
          for (final id in chunk)
            if (!updates.containsKey(id)) id,
        ],
      });
      final args = (await _call(request)).of(set);
      done
        ..addAll([...?(args['updated'] as Map?)?.keys.cast<String>()])
        ..addAll(stringList(args['destroyed']));
      final errors = {..._setErrors(args, 'notUpdated', what), ..._setErrors(args, 'notDestroyed', what)};
      for (final MapEntry(key: id, value: e) in errors.entries) {
        if (e.kind != MailErrorKind.notFound) throw e;
        missing.add(id);
      }
    }
    if (done.isEmpty && missing.isNotEmpty) {
      throw const MailException(MailErrorKind.notFound, 'The message no longer exists on the server.');
    }
    return done;
  }

  Map<String, JmapException> _setErrors(Json args, String key, [String what = 'The server refused']) => {
    if (args[key] case final Map<Object?, Object?> errors)
      for (final MapEntry(:key, :value) in errors.entries)
        if (key is String && value is Map) key: setError(what, value.cast()),
  };

  @override
  Future<Map<String, String>> move(List<String> emailIds, RemoteMailbox target) => _run(() async {
    final targetId = await _mailboxIdOf(target.path);
    final dir = await _directory();
    final patches = <String, Json>{};
    final moved = <String, List<String>>{};
    for (final MapEntry(key: path, value: ids) in _group(emailIds).entries) {
      if (path == target.path) continue;
      final source = dir.idOf(path);
      for (final id in ids) {
        final patch = patches.putIfAbsent(id, () => {'mailboxIds/$targetId': true});
        if (source != null && source != targetId) patch['mailboxIds/$source'] = null;
        moved.putIfAbsent(id, () => []).add(MailIds.jmapEmailIn(account.id, path, id));
      }
    }
    if (patches.isEmpty) return const {};
    final done = await _update(patches, 'Couldn’t move the message');
    return {
      for (final id in done)
        for (final old in moved[id] ?? const <String>[]) old: MailIds.jmapEmailIn(account.id, target.path, id),
    };
  });

  @override
  Future<void> deletePermanently(List<String> emailIds) => _run(() async {
    final dir = await _directory();
    final sources = <String, Set<String>>{};
    for (final MapEntry(key: path, value: ids) in _group(emailIds).entries) {
      final source = dir.idOf(path);
      if (source == null) continue;
      for (final id in ids) {
        sources.putIfAbsent(id, () => {}).add(source);
      }
    }
    if (sources.isEmpty) return;
    final current = await _getEmails(sources.keys.toList(), const ['id', 'mailboxIds']);
    final updates = <String, Json>{};
    final destroy = <String>[];
    for (final e in current) {
      final id = e['id']! as String;
      final from = sources[id]!;
      // Other mailboxes keep their copies; the last copy destroys the email.
      if (idSet(e['mailboxIds']).difference(from).isEmpty) {
        destroy.add(id);
      } else {
        updates[id] = {for (final box in from) 'mailboxIds/$box': null};
      }
    }
    if (updates.isEmpty && destroy.isEmpty) return;
    try {
      await _update(updates, 'Couldn’t delete the message', destroy: destroy);
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.notFound) rethrow;
      // Gone already.
    }
  });

  @override
  Future<String?> append(RemoteMailbox mailbox, Uint8List rfc822, {Set<String> keywords = const {}}) => _run(() async {
    final boxId = await _mailboxIdOf(mailbox.path);
    final id = await importMessage(rfc822, {boxId}, keywords);
    return MailIds.jmapEmailIn(account.id, mailbox.path, id);
  });

  /// Uploads [rfc822] and imports it into [mailboxIds] with [keywords].
  /// Returns the new email's JMAP id (an existing one when the server
  /// recognises the message, which is then put in the mailboxes too).
  Future<String> importMessage(Uint8List rfc822, Set<String> mailboxIds, Set<String> keywords) async {
    final blob = await _client.upload(_account, rfc822, type: 'message/rfc822');
    final request = JmapRequest();
    final import = request.add('Email/import', {
      'accountId': _account,
      'emails': {
        'm': {
          'blobId': blob.blobId,
          'mailboxIds': {for (final b in mailboxIds) b: true},
          'keywords': keywordSet(keywords),
        },
      },
    });
    final args = (await _call(request)).of(import);
    if (args['created'] case {'m': {'id': final String id}}) return id;
    final error = (args['notCreated'] as Map?)?['m'];
    if (error is Map && error['type'] == 'alreadyExists' && error['existingId'] is String) {
      final id = error['existingId'] as String;
      await _update({
        id: {
          for (final b in mailboxIds) 'mailboxIds/$b': true,
          for (final k in keywords) 'keywords/${pointerSegment(Keywords.normalize(k))}': true,
        },
      }, 'Couldn’t save the message');
      return id;
    }
    final e = setError('Couldn’t save the message', error is Map ? error.cast() : const {});
    if (e.type == 'tooLarge' || e.type == 'invalidEmail' || e.type == 'overQuota') {
      throw PermanentMailException(e.kind, e.message, e);
    }
    throw e;
  }

  // Search -------------------------------------------------------------------

  @override
  Future<List<String>> search(SearchExpr expr, {RemoteMailbox? mailbox, int limit = 200}) => _run(() async {
    final bound = bindAccountTerms(expr, _accountLabel);
    if (matchesNothing(bound)) return const <String>[];
    // compileJmapFilter widens patterns, attachment names and accounts too;
    // the caller post-filters with matchesEmail.
    final filter = compileJmapFilter(widenForServer(bound, jmapSupports));
    final dir = await _directory();
    final Json scope;
    if (mailbox != null) {
      scope = {'inMailbox': await _mailboxIdOf(mailbox.path)};
    } else {
      final documents = findDocumentsFolder(dir.remote);
      final id = documents == null ? null : dir.idOf(documents.path);
      scope = id == null
          ? const {}
          : {
              'inMailboxOtherThan': [id],
            };
    }
    final request = JmapRequest();
    final query = request.add('Email/query', {
      'accountId': _account,
      'filter': _and(scope, filter),
      'sort': _newestFirst,
      'limit': math.max(limit, 1),
    });
    final get = limit <= _maxGet
        ? request.add('Email/get', {
            'accountId': _account,
            '#ids': query.ref('/ids'),
            'properties': const ['id', 'mailboxIds'],
          })
        : null;
    final response = await _call(request);
    final ids = stringList(response.of(query)['ids']);
    final emails = get != null ? _list(response.of(get)) : await _getEmails(ids, const ['id', 'mailboxIds']);
    final boxesOf = {for (final e in emails) e['id']: idSet(e['mailboxIds'])};
    final result = <String>[];
    for (final id in ids) {
      final boxes = boxesOf[id];
      if (boxes == null) continue;
      final path = mailbox != null ? mailbox.path : _bestPath(dir, boxes);
      if (path != null) result.add(MailIds.jmapEmailIn(account.id, path, id));
    }
    return result;
  });

  static Json _and(Json a, Json b) {
    if (a.isEmpty) return b;
    if (b.isEmpty) return a;
    return {
      'operator': 'AND',
      'conditions': [a, b],
    };
  }

  /// The copy a search hit in all mailboxes shows as: the Inbox's, else a
  /// folder's, Archive, Sent, Drafts, and Junk or Trash last (never the
  /// documents folder).
  static String? _bestPath(MailboxDirectory dir, Set<String> boxes) {
    int rank(JmapMailbox m) => switch (dir.roleFor(m)) {
      MailboxRole.inbox => 0,
      MailboxRole.none || MailboxRole.flagged || MailboxRole.important => 1,
      MailboxRole.archive => 2,
      MailboxRole.sent => 3,
      MailboxRole.drafts => 4,
      MailboxRole.all => 5,
      MailboxRole.junk => 6,
      MailboxRole.trash => 7,
      MailboxRole.outbox => 8,
    };
    String? best;
    var bestRank = 1 << 30;
    for (final id in boxes) {
      final m = dir.byId(id);
      final path = dir.pathOf(id);
      if (m == null || path == null) continue;
      if (ServerDocuments.isFolderName(m.name, m.parentId == null ? null : dir.pathOf(m.parentId!))) continue;
      final r = rank(m);
      if (r < bestRank || r == bestRank && path.compareTo(best!) < 0) {
        best = path;
        bestRank = r;
      }
    }
    return best;
  }

  /// The account's name and addresses, for [bindAccountTerms].
  String get _accountLabel =>
      {account.displayName, account.email, for (final i in account.identities) i.email}.join(' ');

  // Documents ----------------------------------------------------------------

  /// JMAP has no METADATA: documents are messages in the "Loupe Settings"
  /// mailbox, in the same format as over IMAP, so an account used over both
  /// protocols shares them.
  @override
  Future<List<ServerDocument>> readDocuments(String name) => _run(() async {
    final dir = await _directory(refresh: true);
    final folder = findDocumentsFolder(dir.remote);
    final boxId = folder == null ? null : dir.idOf(folder.path);
    if (folder == null || boxId == null) return const <ServerDocument>[];
    final request = JmapRequest();
    final query = request.add('Email/query', {
      'accountId': _account,
      'filter': {'inMailbox': boxId},
      'sort': _newestFirst,
      'limit': maxDocumentMessages,
    });
    final get = request.add('Email/get', {
      'accountId': _account,
      '#ids': query.ref('/ids'),
      'properties': ['id', 'header:${ServerDocuments.header}', 'textBody', 'bodyValues'],
      'fetchTextBodyValues': true,
    });
    final response = await _call(request);
    final docs = <ServerDocument>[];
    // Oldest first, as over IMAP.
    for (final e in _list(response.of(get)).reversed) {
      final header = headerProperty(e, ServerDocuments.header);
      if (header is! String || decodeHeaderValue(header) != name) continue;
      final values = e['bodyValues'] is Map ? e['bodyValues'] as Map : const {};
      final content = [
        for (final part in e['textBody'] as List? ?? const [])
          if (part is Map)
            if (values[part['partId']] case {'value': final String v}) v,
      ].join().trim();
      if (content.isEmpty) continue;
      if (content.length > maxDocumentSize) {
        throw MailException(MailErrorKind.server, 'The stored document is too large (${content.length} bytes).');
      }
      docs.add(
        ServerDocument(
          content: content,
          storage: ServerStorage.folder,
          ref: MailIds.jmapEmailIn(account.id, folder.path, e['id']! as String),
        ),
      );
    }
    return docs;
  });

  @override
  Future<ServerStorage> writeDocument(String name, String content, {List<ServerDocument> replaces = const []}) =>
      _run(() async {
        final dir = await _directory(refresh: true);
        final existing = findDocumentsFolder(dir.remote);
        final folderId =
            (existing == null ? null : dir.idOf(existing.path)) ??
            await _createMailbox(ServerDocuments.folderName, subscribed: false);
        final now = DateTime.now();
        final message = buildDocumentMessage(
          name,
          content,
          address: account.email,
          date: now,
          messageId:
              '${now.microsecondsSinceEpoch.toRadixString(36)}.'
              '${math.Random.secure().nextInt(1 << 32).toRadixString(36)}@loupe.invalid',
        );
        await importMessage(message, {folderId}, const {Keywords.seen});
        final copies = [
          for (final d in replaces)
            if (d.storage == ServerStorage.folder && d.ref != null)
              if (MailIds.parseJmapEmail(d.ref!) case final p? when p.accountId == account.id) p.jmapId,
        ];
        if (copies.isNotEmpty) {
          try {
            await _update(const {}, 'Couldn’t remove an old copy of the settings', destroy: copies);
          } on MailException catch (e) {
            if (e.kind != MailErrorKind.notFound) rethrow;
          }
        }
        return ServerStorage.folder;
      });

  // Watch --------------------------------------------------------------------

  @override
  Stream<void> watch(RemoteMailbox mailbox) {
    late final StreamController<void> controller;
    final abort = Completer<void>();
    StreamSubscription<ServerEvent>? events;
    Timer? poll;
    Timer? debounce;
    Timer? silence;
    var stopped = false;
    String? lastState;

    Future<void> stop() async {
      if (stopped) return;
      stopped = true;
      poll?.cancel();
      debounce?.cancel();
      silence?.cancel();
      // Stop listening first, then abort the request, which closes the
      // connection at once (a cancelled stream alone waits for the server's
      // next write).
      unawaited(events?.cancel().catchError((Object _) {}));
      if (!abort.isCompleted) abort.complete();
      if (!controller.isClosed) await controller.close();
    }

    void changed(String? state) {
      if (state == null || state == lastState) return;
      final first = lastState == null;
      lastState = state;
      // The first state seen is where watching starts, not a change.
      if (first) return;
      debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () {
        if (!controller.isClosed) controller.add(null);
      });
    }

    void fail(Object e, [StackTrace? s]) {
      if (!controller.isClosed && !stopped) {
        controller.addError(
          e is MailException ? e : MailException(MailErrorKind.connection, 'Watching for changes failed.', e),
          s,
        );
      }
      unawaited(stop());
    }

    Future<String?> currentState() async {
      final request = JmapRequest();
      final get = request.add('Email/get', {
        'accountId': _account,
        'ids': const <String>[],
        'properties': const ['id'],
      });
      return (await _call(request)).of(get)['state'] as String?;
    }

    void heard() {
      silence?.cancel();
      silence = Timer(pushPing * 3 + const Duration(seconds: 30), () => unawaited(stop()));
    }

    Future<void> start() async {
      try {
        if (!_connected) await connect();
        lastState = await currentState();
        final uri = _client.currentSession?.eventSource(types: 'Email', ping: math.max(pushPing.inSeconds, 1));
        if (stopped) return;
        if (uri == null) {
          poll = Timer.periodic(pollInterval, (_) async {
            try {
              changed(await currentState());
            } on Object catch (e, s) {
              fail(e, s);
            }
          });
          return;
        }
        final response = await _client.openStream(uri, abort: abort.future);
        if (stopped) return;
        heard();
        events = parseServerEvents(response.stream).listen(
          (event) {
            heard();
            changed(stateChangesOf(event, _account)['Email']);
          },
          onError: (Object e, StackTrace s) => stopped ? null : fail(e, s),
          onDone: () => unawaited(stop()),
          cancelOnError: true,
        );
      } on Object catch (e, s) {
        fail(e, s);
      }
    }

    controller = StreamController<void>(onListen: () => unawaited(start()), onCancel: stop);
    return controller.stream;
  }

  // Ids ----------------------------------------------------------------------

  ({String path, String jmapId}) _ref(String emailId) {
    final p = MailIds.parseJmapEmail(emailId);
    if (p == null || p.accountId != account.id) {
      throw MailException(MailErrorKind.notFound, 'Not a message of this account: $emailId');
    }
    return (path: p.path, jmapId: p.jmapId);
  }

  /// JMAP ids grouped by mailbox path; foreign ids are rejected.
  Map<String, Set<String>> _group(List<String> emailIds) {
    final groups = <String, Set<String>>{};
    for (final id in emailIds) {
      final r = _ref(id);
      groups.putIfAbsent(r.path, () => {}).add(r.jmapId);
    }
    return groups;
  }
}
