/// [MailTransport] over IMAP.
library;

import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:enough_mail/enough_mail.dart'
    show
        ImapConnectionLostEvent,
        ImapEvent,
        ImapExpungeEvent,
        ImapFetchEvent,
        ImapMessagesExistEvent,
        ImapVanishedEvent;
import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';

import '../mime/headers.dart';
import '../mime/transfer_encoding.dart';
import '../util/uid_set.dart';
import 'body_structure.dart';
import 'connection.dart';
import 'keyword_mapping.dart';
import 'mailbox_list.dart';
import 'message_mapping.dart';
import 'metadata.dart';
import 'parsers.dart';
import 'protocol.dart';
import 'search_commands.dart';
import 'server_documents.dart';
import 'sync_state.dart';

/// UIDs per FETCH of list rows.
const _summaryBatch = 100;

/// UIDs per STORE/COPY/MOVE/EXPUNGE command (keeps command lines short).
const _changeBatch = 500;

/// Long-running commands (bodies, attachments, flag refresh of big windows).
const _longTimeout = Duration(minutes: 10);

typedef _Ref = ({String id, int uidValidity, int uid});

/// IMAP implementation of [MailTransport] on top of enough_mail.
///
/// One instance holds one connection (plus one per [watch] stream). Not
/// thread-safe: callers serialise calls, as the [MailTransport] contract says.
/// After [connect], a dropped connection is re-established on the next call.
final class ImapTransport implements MailTransport {
  ImapTransport(
    this.account,
    this._credentials, {
    this.idleRefresh = const Duration(minutes: 25),
    this.pollInterval = const Duration(minutes: 2),
    this.maxSearchMailboxes = 30,
  });

  final MailAccount account;
  final CredentialsCallback _credentials;

  /// How often IDLE is re-issued (servers drop it after 30 minutes).
  final Duration idleRefresh;

  /// NOOP polling interval of [watch] on servers without IDLE.
  final Duration pollInterval;

  /// Mailboxes searched when [search] gets no mailbox (non-Gmail).
  final int maxSearchMailboxes;

  ImapConnection? _conn;
  bool _wanted = false;

  /// The server announced METADATA but refused to use it (Dovecot without
  /// `mail_attribute_dict`, no private entries…); documents go to the
  /// folder until the next connection.
  bool _metadataRefused = false;
  TransportCapabilities _capabilities = const TransportCapabilities();
  List<RemoteMailbox>? _mailboxes;

  @override
  String get accountId => account.id;

  @override
  TransportCapabilities get capabilities => _capabilities;

  @override
  bool get isConnected => _conn?.isOpen ?? false;

  ServerConfig get _server => account.incoming;
  String get _username => _server.username ?? account.email;

  // Connection ---------------------------------------------------------------

  @override
  Future<void> connect() async {
    _wanted = true;
    if (_conn?.isOpen ?? false) return;
    final conn = await _open();
    _conn = conn;
    _capabilities = _capabilitiesOf(conn);
    _metadataRefused = false;
  }

  /// Opens and authenticates a new connection; with OAuth, retries once with
  /// a refreshed token when the server rejects the current one.
  Future<ImapConnection> _open() async {
    if (_server.protocol != ServerProtocol.imap) {
      throw const MailException(MailErrorKind.unsupported, 'This account doesn’t use IMAP.');
    }
    var credentials = await _credentials();
    try {
      return await ImapConnection.open(_server, username: _username, credentials: credentials);
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.authentication || credentials is! OAuthCredentials) rethrow;
      credentials = await _credentials(forceRefresh: true);
      return ImapConnection.open(_server, username: _username, credentials: credentials);
    }
  }

  static TransportCapabilities _capabilitiesOf(ImapConnection c) => TransportCapabilities(
    supportsIdle: c.has('IDLE'),
    supportsCondstore: c.supportsCondstore,
    supportsQresync: c.qresyncEnabled,
    supportsMove: c.has('MOVE'),
    supportsGmailExtensions: c.has('X-GM-EXT-1'),
    supportsEsearch: c.supportsEsearch,
    supportsUtf8: c.has('UTF8=ACCEPT') || c.has('UTF8=ONLY'),
    raw: Set.unmodifiable(c.capabilities),
  );

  @override
  Future<void> disconnect() async {
    _wanted = false;
    final conn = _conn;
    _conn = null;
    await conn?.logout();
  }

  Future<ImapConnection> _live() async {
    final c = _conn;
    if (c != null && c.isOpen) return c;
    if (!_wanted) throw const MailException(MailErrorKind.connection, 'Not connected.');
    await connect();
    return _conn!;
  }

  /// Runs [body] and turns unexpected errors into [MailException]s.
  Future<T> _run<T>(Future<T> Function(ImapConnection c) body) async {
    final c = await _live();
    try {
      return await body(c);
    } on MailException {
      rethrow;
    } on Object catch (e) {
      throw MailException(MailErrorKind.unknown, 'Unexpected response from ${_server.host}.', e);
    }
  }

  // Mailboxes ----------------------------------------------------------------

  @override
  Future<List<RemoteMailbox>> listMailboxes() => _run((c) async {
    List<ListEntry>? entries;
    Set<String>? subscribed;
    if (c.has('LIST-EXTENDED')) {
      final options = c.has('SPECIAL-USE') ? 'SUBSCRIBED SPECIAL-USE' : 'SUBSCRIBED';
      try {
        entries = await c.send(Command('LIST "" "*" RETURN ($options)'), ListParser());
      } on MailException catch (e) {
        if (e.kind != MailErrorKind.server) rethrow;
      }
    }
    if (entries == null) {
      entries = await c.send(Command('LIST "" "*"'), ListParser());
      try {
        subscribed = {for (final e in await c.send(Command('LSUB "" "*"'), ListParser())) e.rawName};
      } on MailException catch (e) {
        if (e.kind != MailErrorKind.server) rethrow;
      }
    }
    final boxes = buildRemoteMailboxes(entries ?? const [], subscribedRawNames: subscribed);
    _mailboxes = boxes;
    return boxes;
  });

  Future<List<RemoteMailbox>> _knownMailboxes() async => _mailboxes ?? await listMailboxes();

  @override
  Future<void> setSubscribed(RemoteMailbox mailbox, bool subscribed) => _run((c) async {
    try {
      await c.send(Command(subscriptionCommand(c.mailboxArg(mailbox.path), subscribe: subscribed)), GenericParser());
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server || !e.message.contains('[NONEXISTENT]')) rethrow;
      // A mailbox that is gone needs no unsubscribing.
      if (subscribed) throw MailException(MailErrorKind.notFound, 'Folder “${mailbox.name}” no longer exists.', e);
    }
  });

  @override
  Future<void> createMailbox(String path) => _run((c) async {
    final arg = c.mailboxArg(path);
    try {
      await c.send(Command('CREATE $arg'), GenericParser());
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server) rethrow;
      // [ALREADYEXISTS], or a server that words it differently: fine if the
      // mailbox is there now (another client created it first).
      final listed = await listMailboxes();
      if (!listed.any((b) => b.path == path)) rethrow;
    }
    try {
      await c.send(Command(subscriptionCommand(arg, subscribe: true)), GenericParser());
    } on MailException catch (e) {
      // Unsubscribed works too; Loupe syncs the folder anyway.
      if (e.kind != MailErrorKind.server) rethrow;
    }
    _mailboxes = null;
  });

  // Sync ---------------------------------------------------------------------

  @override
  Future<MailboxSyncResult> syncMailbox(RemoteMailbox mailbox, MailboxSyncState? previous, {int initialWindow = 200}) =>
      _run((c) async {
        final prev = ImapSyncState.fromState(previous);
        final sel = await c.select(mailbox.path, condstore: c.supportsCondstore);
        final validity = sel.uidValidity ?? 0;
        if (prev == null || prev.uidValidity != validity) {
          return _initialSync(c, mailbox.path, sel, window: initialWindow, reset: previous != null);
        }
        return _incrementalSync(c, mailbox.path, sel, prev);
      });

  Future<MailboxSyncResult> _initialSync(
    ImapConnection c,
    String path,
    SelectData sel, {
    required int window,
    required bool reset,
  }) async {
    final validity = sel.uidValidity ?? 0;
    final lo = math.max(1, sel.exists - math.max(window, 1) + 1).toInt();
    final fetched = sel.exists == 0
        ? const <(int, EmailSummary)>[]
        : await _summariesBySeq(c, path, validity, lo, sel.exists);
    final uids = [for (final (uid, _) in fetched) uid];
    final uidNext = sel.uidNext ?? (uids.isEmpty ? 1 : uids.reduce(math.max) + 1);
    final state = ImapSyncState(
      uidValidity: validity,
      uidNext: uidNext,
      highestModSeq: sel.noModSeq ? null : sel.highestModSeq,
      oldestUid: uids.isEmpty ? uidNext : uids.reduce(math.min),
      exists: sel.exists,
      uids: uids,
    );
    return MailboxSyncResult(
      state: state.toState(),
      added: [for (final (_, s) in fetched) s],
      resetAll: reset,
      totalCount: sel.exists,
      unreadCount: await _unreadCount(c, sel),
      hasOlder: lo > 1,
      canStoreKeywords: sel.canStoreKeywords,
    );
  }

  Future<MailboxSyncResult> _incrementalSync(ImapConnection c, String path, SelectData sel, ImapSyncState prev) async {
    final validity = prev.uidValidity;
    final known = prev.uids.toSet();

    // New arrivals: everything at or above the previous UIDNEXT.
    var newUids = <int>[];
    if (sel.uidNext == null || sel.uidNext! > prev.uidNext) {
      final found = await c.send(Command('UID SEARCH UID ${prev.uidNext}:*'), SearchParser());
      newUids = found.ids.where((u) => u >= prev.uidNext && !known.contains(u)).toSet().toList()..sort();
    }
    final added = await _summariesByUid(c, path, validity, newUids);
    // Arrivals after our SELECT (not counted in its EXISTS).
    final selUidNext = sel.uidNext;
    final late = selUidNext == null ? 0 : newUids.where((u) => u >= selUidNext).length;

    // Flag changes and removals inside the window.
    final keywordUpdates = <String, Set<String>>{};
    var vanished = <int>[];
    if (known.isNotEmpty) {
      final range = '${prev.oldestUid}:${math.max(prev.oldestUid, prev.uidNext - 1)}';
      final hms = prev.highestModSeq;
      final serverHms = sel.noModSeq ? null : sel.highestModSeq;
      if (c.supportsCondstore && hms != null && serverHms != null) {
        if (serverHms != hms) {
          final modifier = c.qresyncEnabled ? ' VANISHED' : '';
          final changed = await c.send(
            Command('UID FETCH $range (UID FLAGS) (CHANGEDSINCE $hms$modifier)'),
            FetchParser(),
            timeout: _longTimeout,
          );
          for (final m in changed.messages) {
            final uid = m.uid;
            if (uid == null || !known.contains(uid) || m.flags == null) continue;
            keywordUpdates[_id(path, validity, uid)] = keywordsFromFlags(m.flags!);
          }
          if (c.qresyncEnabled) vanished = changed.vanished.where(known.contains).toList();
        }
        if (!c.qresyncEnabled && prev.hasRemovals(serverExists: sel.exists, newCount: newUids.length - late)) {
          vanished = vanishedUids(known, await _uidsIn(c, range));
        }
      } else {
        // No CONDSTORE: refresh every flag in the window. The reply also
        // shows which messages still exist.
        final all = await c.send(Command('UID FETCH $range (UID FLAGS)'), FetchParser(), timeout: _longTimeout);
        final present = <int>{};
        for (final m in all.messages) {
          final uid = m.uid;
          if (uid == null || !known.contains(uid)) continue;
          present.add(uid);
          keywordUpdates[_id(path, validity, uid)] = keywordsFromFlags(m.flags ?? const []);
        }
        vanished = vanishedUids(known, present);
      }
    }

    final remaining = known.difference(vanished.toSet())..addAll(newUids);
    final uidNext = math.max(sel.uidNext ?? prev.uidNext, newUids.isEmpty ? 0 : newUids.last + 1);
    final state = ImapSyncState(
      uidValidity: validity,
      uidNext: uidNext,
      highestModSeq: sel.noModSeq ? null : (sel.highestModSeq ?? prev.highestModSeq),
      oldestUid: prev.oldestUid,
      exists: sel.exists + late,
      uids: remaining.toList(),
    );
    return MailboxSyncResult(
      state: state.toState(),
      added: [for (final (_, s) in added) s],
      keywordUpdates: keywordUpdates,
      vanishedIds: [for (final uid in vanished) _id(path, validity, uid)],
      totalCount: sel.exists,
      unreadCount: await _unreadCount(c, sel),
      hasOlder: state.olderExist(sel.exists),
      canStoreKeywords: sel.canStoreKeywords,
    );
  }

  @override
  Future<MailboxSyncResult> fetchOlder(RemoteMailbox mailbox, MailboxSyncState state, {int count = 100}) =>
      _run((c) async {
        final prev = ImapSyncState.fromState(state);
        final sel = await c.select(mailbox.path, condstore: c.supportsCondstore);
        if (prev == null || prev.uidValidity != (sel.uidValidity ?? 0)) {
          return _initialSync(c, mailbox.path, sel, window: count, reset: true);
        }
        final validity = prev.uidValidity;
        final lowestKnown = prev.uids.isEmpty ? prev.oldestUid : prev.uids.first;
        // Older messages have lower sequence numbers than our lowest known
        // UID; find its sequence number cheaply.
        int? seq;
        if (prev.uids.isNotEmpty) {
          final probe = prev.uids.take(20).toList();
          final r = await c.send(Command('UID FETCH ${formatSequenceSet(probe)} (UID)'), FetchParser());
          final seqs = [
            for (final m in r.messages)
              if (m.uid != null && probe.contains(m.uid)) m.seq,
          ];
          if (seqs.isNotEmpty) seq = seqs.reduce(math.min);
        }
        List<(int, EmailSummary)> fetched;
        bool hasOlder;
        if (seq != null) {
          final hi = seq - 1;
          if (hi < 1) return _olderResult(prev, sel, const [], hasOlder: false);
          final lo = math.max(1, hi - count + 1);
          fetched = (await _summariesBySeq(
            c,
            mailbox.path,
            validity,
            lo,
            hi,
          )).where((e) => e.$1 < lowestKnown && !prev.uids.contains(e.$1)).toList();
          hasOlder = lo > 1;
        } else {
          if (lowestKnown <= 1) return _olderResult(prev, sel, const [], hasOlder: false);
          final older = (await _uidsIn(c, '1:${lowestKnown - 1}')).where((u) => u < lowestKnown).toList()..sort();
          final take = older.length > count ? older.sublist(older.length - count) : older;
          fetched = await _summariesByUid(c, mailbox.path, validity, take);
          hasOlder = older.length > take.length;
        }
        return _olderResult(prev, sel, fetched, hasOlder: hasOlder);
      });

  MailboxSyncResult _olderResult(
    ImapSyncState prev,
    SelectData sel,
    List<(int, EmailSummary)> fetched, {
    required bool hasOlder,
  }) {
    final uids = [...prev.uids, for (final (uid, _) in fetched) uid];
    final oldest = fetched.isEmpty
        ? prev.oldestUid
        : math.min(prev.oldestUid, fetched.map((e) => e.$1).reduce(math.min));
    final state = ImapSyncState(
      uidValidity: prev.uidValidity,
      uidNext: prev.uidNext,
      highestModSeq: prev.highestModSeq,
      oldestUid: hasOlder ? oldest : math.min(oldest, 1),
      exists: prev.exists,
      uids: uids,
    );
    return MailboxSyncResult(
      state: state.toState(),
      added: [for (final (_, s) in fetched) s],
      totalCount: sel.exists,
      hasOlder: hasOlder,
    );
  }

  @override
  Future<List<EmailSummary>> fetchSummaries(List<String> emailIds) => _run((c) async {
    final result = <EmailSummary>[];
    for (final MapEntry(key: path, value: refs) in _group(emailIds).entries) {
      final sel = await c.ensureSelected(path);
      final valid = refs.where((r) => r.uidValidity == sel.uidValidity).map((r) => r.uid).toList();
      result.addAll([for (final (_, s) in await _summariesByUid(c, path, sel.uidValidity ?? 0, valid)) s]);
    }
    return result;
  });

  /// List rows for [uids] (any order), with previews.
  Future<List<(int, EmailSummary)>> _summariesByUid(ImapConnection c, String path, int validity, List<int> uids) async {
    final sorted = uids.toSet().toList()..sort();
    final result = <(int, EmailSummary)>[];
    for (final chunk in chunked(sorted, _summaryBatch).toList().reversed) {
      final wanted = chunk.toSet();
      final r = await c.send(
        Command('UID FETCH ${formatSequenceSet(chunk)} ${summaryFetchItems(gmail: c.has('X-GM-EXT-1'))}'),
        FetchParser(),
      );
      result.addAll(await _rows(c, path, validity, r.messages.where((m) => wanted.contains(m.uid)).toList()));
    }
    return result;
  }

  /// List rows for the sequence range [lo]..[hi], newest batch first.
  Future<List<(int, EmailSummary)>> _summariesBySeq(ImapConnection c, String path, int validity, int lo, int hi) async {
    final result = <(int, EmailSummary)>[];
    for (var top = hi; top >= lo; top -= _summaryBatch) {
      final bottom = math.max(lo, top - _summaryBatch + 1);
      final r = await c.send(
        Command('FETCH $bottom:$top ${summaryFetchItems(gmail: c.has('X-GM-EXT-1'))}'),
        FetchParser(),
      );
      result.addAll(await _rows(c, path, validity, r.messages.where((m) => m.uid != null).toList()));
    }
    return result;
  }

  Future<List<(int, EmailSummary)>> _rows(ImapConnection c, String path, int validity, List<FetchedMessage> ms) async {
    final previews = await _previews(c, ms);
    return [
      for (final m in ms)
        if (summaryFromFetch(m, accountId: accountId, path: path, uidValidity: validity, preview: previews[m.uid] ?? '')
            case final s?)
          (m.uid!, s),
    ];
  }

  /// Fetches the start of each message's preview part, grouped by section
  /// so a batch needs only a few commands.
  Future<Map<int, String>> _previews(ImapConnection c, List<FetchedMessage> messages) async {
    final groups = <String, List<(int, BodyNode)>>{};
    for (final m in messages) {
      final structure = m.structure;
      final uid = m.uid;
      if (structure == null || uid == null) continue;
      final part = selectPreviewPart(structure);
      if (part == null) continue;
      groups.putIfAbsent('[${part.section}]<0.${previewBytes(part)}>', () => []).add((uid, part));
    }
    final result = <int, String>{};
    for (final MapEntry(key: spec, value: items) in groups.entries) {
      final section = items.first.$2.section;
      try {
        final r = await c.send(
          Command('UID FETCH ${formatSequenceSet(items.map((e) => e.$1))} (BODY.PEEK$spec)'),
          FetchParser(),
        );
        final byUid = {for (final m in r.messages) m.uid: m};
        for (final (uid, part) in items) {
          final raw = byUid[uid]?.sections[section];
          if (raw != null) result[uid] = previewFromPart(part, raw);
        }
      } on MailException catch (e) {
        if (e.kind == MailErrorKind.connection) rethrow;
        // A server that can't serve a part leaves the preview empty.
      }
    }
    return result;
  }

  Future<List<int>> _uidsIn(ImapConnection c, String range) async {
    final command = c.supportsEsearch ? 'UID SEARCH RETURN (ALL) UID $range' : 'UID SEARCH UID $range';
    return (await c.send(Command(command), SearchParser(), timeout: _longTimeout)).ids;
  }

  Future<int?> _unreadCount(ImapConnection c, SelectData sel) async {
    if (sel.exists == 0) return 0;
    try {
      if (c.supportsEsearch) {
        final r = await c.send(Command('SEARCH RETURN (COUNT) UNSEEN'), SearchParser());
        return r.count ?? r.ids.length;
      }
      return (await c.send(Command('UID SEARCH UNSEEN'), SearchParser())).ids.length;
    } on MailException catch (e) {
      if (e.kind == MailErrorKind.connection) rethrow;
      return null;
    }
  }

  // Messages -----------------------------------------------------------------

  @override
  Future<EmailContent> fetchContent(String emailId) => _run((c) async {
    final ref = _ref(emailId);
    await _selectChecked(c, emailId);
    final head = await _fetchOne(c, ref, '(UID BODYSTRUCTURE BODY.PEEK[HEADER])');
    final structure = head.structure;
    if (structure == null) throw MailException(MailErrorKind.server, 'The server sent no structure for this message.');
    final plan = planContentFetch(structure);
    final sections = <String>{...plan.body.map((n) => n.section), ...plan.inline.map((a) => a.partId)};
    var fetched = const <String, Uint8List>{};
    if (sections.isNotEmpty) {
      final items = sections.map((s) => 'BODY.PEEK[$s]').join(' ');
      fetched = (await _fetchOne(c, ref, '(UID $items)', timeout: _longTimeout)).sections;
    }
    return buildContent(
      emailId: emailId,
      root: structure,
      header: head.sections['HEADER'] ?? Uint8List(0),
      sections: fetched,
    );
  });

  @override
  Future<Uint8List> fetchAttachment(String emailId, String partId) => _run((c) async {
    if (!RegExp(r'^\d+(\.\d+)*$').hasMatch(partId)) {
      throw MailException(MailErrorKind.notFound, 'No part $partId in this message.');
    }
    final ref = _ref(emailId);
    await _selectChecked(c, emailId);
    final m = await _fetchOne(c, ref, '(UID BODYSTRUCTURE BODY.PEEK[$partId])', timeout: _longTimeout);
    final raw = m.sections[partId];
    if (raw == null) throw MailException(MailErrorKind.notFound, 'No part $partId in this message.');
    final node = m.structure?.find(partId);
    return node == null || node.isMessage ? raw : decodeTransferEncoding(raw, node.encoding);
  });

  @override
  Future<Uint8List> fetchRaw(String emailId) => _run((c) async {
    final ref = _ref(emailId);
    await _selectChecked(c, emailId);
    final m = await _fetchOne(c, ref, '(UID BODY.PEEK[])', timeout: _longTimeout);
    return m.sections[''] ?? Uint8List(0);
  });

  Future<FetchedMessage> _fetchOne(ImapConnection c, _Ref ref, String items, {Duration? timeout}) async {
    final r = await c.send(Command('UID FETCH ${ref.uid} $items'), FetchParser(), timeout: timeout);
    for (final m in r.messages) {
      if (m.uid == ref.uid) return m;
    }
    throw const MailException(MailErrorKind.notFound, 'The message no longer exists on the server.');
  }

  // Changes ------------------------------------------------------------------

  @override
  Future<void> setKeywords(List<String> emailIds, {Set<String> add = const {}, Set<String> remove = const {}}) => _run((
    c,
  ) async {
    final plus = flagsForKeywords(add);
    final minus = flagsForKeywords(remove.difference(add));
    if (plus.isEmpty && minus.isEmpty) return;
    for (final refs in _group(emailIds).values) {
      await _selectChecked(c, refs.first.id);
      for (final chunk in chunked(_uids(refs), _changeBatch)) {
        final set = formatSequenceSet(chunk);
        if (plus.isNotEmpty) await c.send(Command('UID STORE $set +FLAGS.SILENT (${plus.join(' ')})'), GenericParser());
        if (minus.isNotEmpty) {
          await c.send(Command('UID STORE $set -FLAGS.SILENT (${minus.join(' ')})'), GenericParser());
        }
      }
    }
  });

  @override
  Future<Map<String, String>> move(List<String> emailIds, RemoteMailbox target) => _run((c) async {
    final result = <String, String>{};
    final to = c.mailboxArg(target.path);
    for (final MapEntry(key: path, value: refs) in _group(emailIds).entries) {
      if (path == target.path) continue;
      final validity = refs.first.uidValidity;
      await _selectChecked(c, refs.first.id);
      for (final chunk in chunked(_uids(refs), _changeBatch)) {
        final set = formatSequenceSet(chunk);
        final GenericResult r;
        if (c.has('MOVE')) {
          r = await c.send(Command('UID MOVE $set $to'), GenericParser(), timeout: _longTimeout);
        } else {
          r = await c.send(Command('UID COPY $set $to'), GenericParser(), timeout: _longTimeout);
          await c.send(Command('UID STORE $set +FLAGS.SILENT (\\Deleted)'), GenericParser());
          await _expunge(c, set);
        }
        final copy = parseUidPlusCode(r.code('COPYUID'));
        if (copy == null) continue;
        final (newValidity, from, into) = copy;
        for (var i = 0; i < from.length && i < into.length; i++) {
          result[_id(path, validity, from[i])] = MailIds.imapEmail(accountId, target.path, newValidity, into[i]);
        }
      }
    }
    return result;
  });

  @override
  Future<void> deletePermanently(List<String> emailIds) => _run((c) async {
    for (final refs in _group(emailIds).values) {
      await _selectChecked(c, refs.first.id);
      for (final chunk in chunked(_uids(refs), _changeBatch)) {
        final set = formatSequenceSet(chunk);
        await c.send(Command('UID STORE $set +FLAGS.SILENT (\\Deleted)'), GenericParser());
        await _expunge(c, set);
      }
    }
  });

  /// UID EXPUNGE with UIDPLUS; otherwise a plain EXPUNGE, which also removes
  /// other messages already flagged \Deleted in this mailbox.
  Future<void> _expunge(ImapConnection c, String set) async {
    final command = c.supportsUidPlus ? 'UID EXPUNGE $set' : 'EXPUNGE';
    await c.send(Command(command), GenericParser(), timeout: _longTimeout);
  }

  @override
  Future<String?> append(RemoteMailbox mailbox, Uint8List rfc822, {Set<String> keywords = const {}}) => _run((c) async {
    final r = await c.append(mailbox.path, rfc822, flagsForKeywords(keywords));
    final code = parseUidPlusCode(r.code('APPENDUID'));
    if (code == null || code.$3.isEmpty) return null;
    return MailIds.imapEmail(accountId, mailbox.path, code.$1, code.$3.first);
  });

  // Search -------------------------------------------------------------------

  @override
  Future<List<String>> search(SearchExpr expr, {RemoteMailbox? mailbox, int limit = 200}) => _run((c) async {
    final bound = bindAccountTerms(expr, _accountLabel);
    if (matchesNothing(bound)) return const <String>[];
    if (c.has('X-GM-EXT-1')) {
      final raw = compileGmailRaw(bound) ?? compileGmailRaw(widenForServer(bound, gmailSupports));
      final box = mailbox ?? _withRole(await _knownMailboxes(), MailboxRole.all);
      if (raw != null && box != null) {
        // An empty Gmail query means everything.
        final command = raw.trim().isEmpty ? 'UID SEARCH ALL' : gmailRawSearchCommand(raw);
        return _searchIn(c, box.path, command, limit);
      }
    }
    // compileImap widens what IMAP can't express itself; the caller
    // post-filters whenever the result isn't exact.
    final command = uidSearchCommand(compileImap(bound));
    final boxes = mailbox != null ? [mailbox] : _searchOrder(await _knownMailboxes());
    final result = <String>[];
    for (final box in boxes.take(maxSearchMailboxes)) {
      if (result.length >= limit) break;
      try {
        result.addAll(await _searchIn(c, box.path, command, limit - result.length));
      } on MailException catch (e) {
        if (e.kind == MailErrorKind.connection || mailbox != null) rethrow;
      }
    }
    return result;
  });

  /// The account's name and addresses, for [bindAccountTerms].
  String get _accountLabel =>
      {account.displayName, account.email, for (final i in account.identities) i.email}.join(' ');

  Future<List<String>> _searchIn(ImapConnection c, String path, String command, int limit) async {
    final sel = await c.ensureSelected(path);
    if (sel.exists == 0) return const [];
    final parts = literalize(command);
    final r = await c.send(
      parts.length == 1 ? Command(parts.single) : Command.withContinuation(parts),
      SearchParser(),
      timeout: const Duration(minutes: 3),
    );
    final uids = r.ids.toSet().toList()..sort((a, b) => b.compareTo(a));
    return [for (final uid in uids.take(limit)) _id(path, sel.uidValidity ?? 0, uid)];
  }

  static RemoteMailbox? _withRole(List<RemoteMailbox> boxes, MailboxRole role) {
    for (final b in boxes) {
      if (b.role == role && b.isSelectable) return b;
    }
    return null;
  }

  /// Mailboxes to search when none is given: an \All mailbox alone if the
  /// server has one; otherwise Inbox first, Trash and Junk last (never the
  /// Loupe Settings folder).
  static List<RemoteMailbox> _searchOrder(List<RemoteMailbox> boxes) {
    final all = _withRole(boxes, MailboxRole.all);
    if (all != null) return [all];
    int rank(RemoteMailbox b) => switch (b.role) {
      MailboxRole.inbox => 0,
      MailboxRole.sent || MailboxRole.archive => 1,
      MailboxRole.trash || MailboxRole.junk => 3,
      _ => 2,
    };
    return boxes.where((b) => b.isSelectable && !ServerDocuments.isFolderName(b.name, b.parentPath)).toList()
      ..sort((a, b) => rank(a).compareTo(rank(b)));
  }

  // Documents ----------------------------------------------------------------

  bool _metadataUsable(ImapConnection c) => c.supportsServerMetadata && !_metadataRefused;

  /// Gmail has no METADATA, and a folder wouldn't do: every copy would stay
  /// in All Mail (deleting from a label only removes the label).
  static void _checkDocumentsSupported(ImapConnection c) {
    if (c.has('X-GM-EXT-1')) {
      throw const MailException(MailErrorKind.unsupported, 'Gmail can’t keep Loupe settings on the server.');
    }
  }

  @override
  Future<List<ServerDocument>> readDocuments(String name) => _run((c) async {
    _checkDocumentsSupported(c);
    final docs = <ServerDocument>[];
    if (_metadataUsable(c)) {
      final value = await _getMetadata(c, ServerDocuments.metadataEntry(name));
      if (value != null && value.trim().isNotEmpty) {
        docs.add(ServerDocument(content: value, storage: ServerStorage.metadata));
      }
    }
    // Also where METADATA works: copies written before it was enabled.
    final folder = findDocumentsFolder(await _knownMailboxes());
    if (folder != null) docs.addAll(await _folderDocuments(c, folder, name));
    return docs;
  });

  @override
  Future<ServerStorage> writeDocument(String name, String content, {List<ServerDocument> replaces = const []}) =>
      _run((c) async {
        _checkDocumentsSupported(c);
        final entry = ServerDocuments.metadataEntry(name);
        final folderCopies = [
          for (final d in replaces)
            if (d.storage == ServerStorage.folder && d.ref != null) d.ref!,
        ];
        if (_metadataUsable(c) && await _setMetadata(c, entry, content)) {
          await _deleteCopies(c, folderCopies);
          return ServerStorage.metadata;
        }
        final folder = await _documentsFolder(c);
        final message = buildDocumentMessage(
          name,
          content,
          address: account.email,
          date: DateTime.now(),
          messageId:
              '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}.'
              '${math.Random.secure().nextInt(1 << 32).toRadixString(36)}@loupe.invalid',
        );
        await c.append(folder.path, message, const [r'\Seen']);
        await _deleteCopies(c, folderCopies);
        // A METADATA copy merged into this one (too large for METADATA now)
        // must go, or its entries would come back.
        if (c.supportsServerMetadata && replaces.any((d) => d.storage == ServerStorage.metadata)) {
          await _setMetadata(c, entry, null);
        }
        return ServerStorage.folder;
      });

  /// The value of a server annotation; null when unset or when the server
  /// refuses METADATA after all (then documents use the folder).
  Future<String?> _getMetadata(ImapConnection c, String entry) async {
    try {
      var r = await c.send(Command(getMetadataCommand('""', [entry])), MetadataParser());
      final long = r.longEntries;
      if (r[entry] == null && long != null) {
        if (long > maxDocumentSize) {
          throw MailException(MailErrorKind.server, 'The stored document is too large ($long bytes).');
        }
        r = await c.send(Command(getMetadataCommand('""', [entry], maxSize: long)), MetadataParser());
      }
      return r[entry];
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server || e.message.startsWith('The stored document')) rethrow;
      _metadataRefused = true;
      return null;
    }
  }

  /// Sets (or with null, removes) a server annotation. Returns false when
  /// the server refuses; unless the value was just too large, METADATA is
  /// then given up for this connection.
  Future<bool> _setMetadata(ImapConnection c, String entry, String? value) async {
    final command = setMetadataCommand('""', entry, value);
    try {
      final literal = command.literal;
      if (literal == null) {
        await c.send(Command(command.head), GenericParser());
      } else {
        await c.sendLiteral(command.head, literal, command.tail, GenericParser());
      }
      return true;
    } on MailException catch (e) {
      if (e.kind != MailErrorKind.server) rethrow;
      if (metadataRefusal(e.message).$1 != MetadataRefusal.maxSize) _metadataRefused = true;
      return false;
    }
  }

  /// Copies of document [name] in the documents folder, oldest first.
  Future<List<ServerDocument>> _folderDocuments(ImapConnection c, RemoteMailbox folder, String name) async {
    final sel = await c.select(folder.path);
    if (sel.exists == 0) return const [];
    final validity = sel.uidValidity ?? 0;
    final lo = math.max(1, sel.exists - maxDocumentMessages + 1);
    final heads = await c.send(
      Command('FETCH $lo:${sel.exists} (UID BODY.PEEK[HEADER.FIELDS (${ServerDocuments.header.toUpperCase()})])'),
      FetchParser(),
    );
    final uids = [
      for (final m in heads.messages)
        if (m.uid != null &&
            headerValue(
                  parseHeaderBlock(m.sections['HEADER.FIELDS'] ?? Uint8List(0)),
                  ServerDocuments.header,
                )?.trim() ==
                name)
          m.uid!,
    ]..sort();
    if (uids.isEmpty) return const [];
    final bodies = await c.send(
      Command('UID FETCH ${formatSequenceSet(uids)} (UID BODY.PEEK[HEADER] BODY.PEEK[TEXT])'),
      FetchParser(),
      timeout: _longTimeout,
    );
    final byUid = {for (final m in bodies.messages) m.uid: m};
    return [
      for (final uid in uids)
        if (byUid[uid] case final m?)
          if (readDocumentMessage(name, m.sections['HEADER'] ?? Uint8List(0), m.sections['TEXT'] ?? Uint8List(0))
              case final content? when content.isNotEmpty)
            ServerDocument(content: content, storage: ServerStorage.folder, ref: _id(folder.path, validity, uid)),
    ];
  }

  /// The documents folder, created (unsubscribed) when missing: at the top
  /// level, or under INBOX on servers that keep every folder there.
  Future<RemoteMailbox> _documentsFolder(ImapConnection c) async {
    final known = findDocumentsFolder(await _knownMailboxes()) ?? findDocumentsFolder(await listMailboxes());
    if (known != null) return known;
    final delimiter = (await c.send(Command('LIST "" ""'), ListParser())).firstOrNull?.delimiter;
    const name = ServerDocuments.folderName;
    MailException? refused;
    for (final path in [name, if (delimiter != null && delimiter.isNotEmpty) 'INBOX$delimiter$name']) {
      try {
        await c.send(Command('CREATE ${c.mailboxArg(path)}'), GenericParser());
      } on MailException catch (e) {
        if (e.kind != MailErrorKind.server) rethrow;
        if (!e.message.contains('[ALREADYEXISTS]')) {
          refused = e;
          continue;
        }
      }
      final created = findDocumentsFolder(await listMailboxes());
      if (created != null) return created;
    }
    throw MailException(
      MailErrorKind.server,
      'Couldn’t create the “$name” folder${refused == null ? '' : ': ${refused.message}'}',
      refused,
    );
  }

  /// Deletes folder copies of a document; copies already gone (or from an
  /// earlier UIDVALIDITY) are skipped.
  Future<void> _deleteCopies(ImapConnection c, List<String> emailIds) async {
    final ours = [
      for (final id in emailIds)
        if (MailIds.parseImapEmail(id)?.accountId == accountId) id,
    ];
    for (final refs in _group(ours).values) {
      try {
        await _selectChecked(c, refs.first.id);
      } on MailException catch (e) {
        if (e.kind == MailErrorKind.notFound) continue;
        rethrow;
      }
      final set = formatSequenceSet(_uids(refs));
      await c.send(Command('UID STORE $set +FLAGS.SILENT (\\Deleted)'), GenericParser());
      await _expunge(c, set);
    }
  }

  // Watch --------------------------------------------------------------------

  @override
  Stream<void> watch(RemoteMailbox mailbox) {
    late final StreamController<void> controller;
    ImapConnection? conn;
    StreamSubscription<ImapEvent>? events;
    Timer? refresh;
    Timer? debounce;
    var stopped = false;
    var busy = false;

    Future<void> stop() async {
      if (stopped) return;
      stopped = true;
      refresh?.cancel();
      debounce?.cancel();
      await events?.cancel();
      await conn?.close();
      if (!controller.isClosed) await controller.close();
    }

    void changed() {
      debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () {
        if (!controller.isClosed) controller.add(null);
      });
    }

    Future<void> start() async {
      try {
        final c = conn = await _open();
        if (stopped) {
          await c.close();
          return;
        }
        events = c.client.eventBus.on<ImapEvent>().listen((e) {
          if (e is ImapConnectionLostEvent) {
            unawaited(stop());
          } else if (e is ImapMessagesExistEvent ||
              e is ImapExpungeEvent ||
              e is ImapVanishedEvent ||
              e is ImapFetchEvent) {
            changed();
          }
        });
        unawaited(c.closed.then((_) => stop()));
        await c.selectForIdle(mailbox.path, null);
        final idle = c.has('IDLE');
        if (idle) await c.guard(c.client.idleStart);
        refresh = Timer.periodic(idle ? idleRefresh : pollInterval, (_) async {
          if (busy || stopped) return;
          busy = true;
          try {
            if (idle) {
              await c.guard(c.client.idleDone, timeout: const Duration(seconds: 30));
              await c.guard(c.client.idleStart);
            } else {
              await c.guard(c.client.noop);
            }
          } on Object {
            await stop();
          } finally {
            busy = false;
          }
        });
      } on Object catch (e, s) {
        if (!controller.isClosed && !stopped) {
          controller.addError(
            e is MailException ? e : MailException(MailErrorKind.connection, 'Watching for changes failed.', e),
            s,
          );
        }
        await stop();
      }
    }

    controller = StreamController<void>(onListen: () => unawaited(start()), onCancel: stop);
    return controller.stream;
  }

  // Ids ----------------------------------------------------------------------

  String _id(String path, int uidValidity, int uid) => MailIds.imapEmail(accountId, path, uidValidity, uid);

  _Ref _ref(String emailId) {
    final p = MailIds.parseImapEmail(emailId);
    if (p == null || p.accountId != accountId) {
      throw MailException(MailErrorKind.notFound, 'Not a message of this account: $emailId');
    }
    return (id: emailId, uidValidity: p.uidValidity, uid: p.uid);
  }

  /// Ids grouped by mailbox path; foreign ids are rejected.
  Map<String, List<_Ref>> _group(List<String> emailIds) {
    final groups = <String, List<_Ref>>{};
    for (final id in emailIds) {
      final p = MailIds.parseImapEmail(id);
      if (p == null || p.accountId != accountId) {
        throw MailException(MailErrorKind.notFound, 'Not a message of this account: $id');
      }
      groups.putIfAbsent(p.path, () => []).add((id: id, uidValidity: p.uidValidity, uid: p.uid));
    }
    return groups;
  }

  static List<int> _uids(List<_Ref> refs) => refs.map((r) => r.uid).toSet().toList()..sort();

  /// Selects the mailbox of [emailId] and checks its UIDVALIDITY.
  Future<void> _selectChecked(ImapConnection c, String emailId) async {
    final p = MailIds.parseImapEmail(emailId)!;
    final sel = await c.ensureSelected(p.path);
    if (sel.uidValidity != null && sel.uidValidity != p.uidValidity) {
      throw MailException(MailErrorKind.notFound, 'Mailbox “${p.path}” was reset on the server; sync again.');
    }
  }
}
