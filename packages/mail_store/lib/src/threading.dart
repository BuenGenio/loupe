import 'package:drift/drift.dart';
import 'package:mail_model/mail_model.dart';

import 'codec.dart';
import 'schema.dart';

/// How far apart a reply and an earlier message with the same base subject
/// may be for the subject fallback to group them.
const subjectFallbackWindow = Duration(days: 30);

/// Assigns thread ids to new messages of one account (a simplified JWZ):
/// a message joins the thread of any message it references or that
/// references it; when it links several threads, they are merged. Replies
/// without known references fall back to the base subject within
/// [subjectFallbackWindow]. Must run inside a transaction.
final class ThreadAssigner {
  ThreadAssigner(this._db, this.accountId);

  final StoreDatabase _db;
  final String accountId;

  /// Message-ID → thread id, loaded lazily and updated as we go.
  final _refs = <String, String>{};
  final _loaded = <String>{};

  /// Base subject → (thread id, received ms) of messages assigned in this batch.
  final _batchSubjects = <String, List<(String, int)>>{};

  /// Ids referenced by [e], own Message-ID first.
  static List<String> referencedIds(EmailSummary e) {
    final ids = <String>{
      if (e.messageIdHeader != null && e.messageIdHeader!.trim().isNotEmpty) normalizeMessageId(e.messageIdHeader!),
      for (final r in e.references)
        if (r.trim().isNotEmpty) normalizeMessageId(r),
      if (e.inReplyTo != null && e.inReplyTo!.trim().isNotEmpty) normalizeMessageId(e.inReplyTo!),
    };
    ids.remove('');
    return ids.toList();
  }

  /// Preloads mappings for all ids referenced by [emails].
  Future<void> preload(Iterable<EmailSummary> emails) async {
    final wanted = {for (final e in emails) ...referencedIds(e)}.difference(_loaded);
    final list = wanted.toList();
    for (var i = 0; i < list.length; i += 500) {
      final chunk = list.sublist(i, i + 500 > list.length ? list.length : i + 500);
      final rows = await (_db.select(
        _db.threadRefs,
      )..where((t) => t.accountId.equals(accountId) & t.messageId.isIn(chunk))).get();
      for (final r in rows) {
        _refs[r.messageId] = r.threadId;
      }
      _loaded.addAll(chunk);
    }
  }

  /// Returns the thread id for [e] and records its references.
  Future<String> assign(EmailSummary e) async {
    final ids = referencedIds(e);
    await preload([e]);
    final given = e.threadId;
    String threadId;
    if (given != null && given.isNotEmpty) {
      threadId = given;
    } else {
      final found = <String>{for (final id in ids) ?_refs[id]};
      if (found.isEmpty) {
        threadId = await _bySubject(e) ?? _newThreadId(e);
      } else {
        final sorted = found.toList()..sort();
        threadId = sorted.first;
        if (sorted.length > 1) await _merge(sorted.sublist(1), threadId);
      }
    }
    for (final id in ids) {
      if (_refs[id] == threadId) continue;
      // Gmail/JMAP thread ids are authoritative; computed ones never override them.
      if (_refs.containsKey(id) && (given == null || given.isEmpty)) continue;
      _refs[id] = threadId;
      await _db
          .into(_db.threadRefs)
          .insertOnConflictUpdate(ThreadRefsCompanion.insert(accountId: accountId, messageId: id, threadId: threadId));
    }
    final base = baseSubject(e.subject);
    if (base.isNotEmpty) {
      (_batchSubjects[base] ??= []).add((threadId, e.receivedAt.millisecondsSinceEpoch));
    }
    return threadId;
  }

  /// A new thread is named after the account and its root: the first
  /// reference, the parent, or the message itself.
  String _newThreadId(EmailSummary e) {
    String norm(String? s) => s == null ? '' : normalizeMessageId(s);
    final root = e.references.map(norm).firstWhere((r) => r.isNotEmpty, orElse: () => '');
    final parent = norm(e.inReplyTo);
    final own = norm(e.messageIdHeader);
    final name = root.isNotEmpty ? root : (parent.isNotEmpty ? parent : (own.isNotEmpty ? own : e.id));
    return '$accountId|t:$name';
  }

  Future<String?> _bySubject(EmailSummary e) async {
    final looksLikeReply = isReplySubject(e.subject) || e.references.isNotEmpty || e.inReplyTo != null;
    final base = baseSubject(e.subject);
    if (!looksLikeReply || base.isEmpty) return null;
    final at = e.receivedAt.millisecondsSinceEpoch;
    final window = subjectFallbackWindow.inMilliseconds;
    for (final (tid, ms) in _batchSubjects[base] ?? const <(String, int)>[]) {
      if ((ms - at).abs() <= window) return tid;
    }
    final row = await _db
        .customSelect(
          'SELECT thread_id FROM emails WHERE account_id = ? AND base_subject = ? AND received_at BETWEEN ? AND ? '
          'ORDER BY abs(received_at - ?) LIMIT 1',
          variables: [
            Variable.withString(accountId),
            Variable.withString(base),
            Variable.withInt(at - window),
            Variable.withInt(at + window),
            Variable.withInt(at),
          ],
          readsFrom: {_db.emails},
        )
        .getSingleOrNull();
    return row?.read<String>('thread_id');
  }

  Future<void> _merge(List<String> from, String into) async {
    for (final old in from) {
      await _db.customUpdate(
        'UPDATE emails SET thread_id = ? WHERE account_id = ? AND thread_id = ?',
        variables: [Variable.withString(into), Variable.withString(accountId), Variable.withString(old)],
        updates: {_db.emails},
        updateKind: UpdateKind.update,
      );
      await _db.customUpdate(
        'UPDATE thread_refs SET thread_id = ? WHERE account_id = ? AND thread_id = ?',
        variables: [Variable.withString(into), Variable.withString(accountId), Variable.withString(old)],
        updates: {_db.threadRefs},
        updateKind: UpdateKind.update,
      );
      _refs.updateAll((_, t) => t == old ? into : t);
      for (final list in _batchSubjects.values) {
        for (var i = 0; i < list.length; i++) {
          if (list[i].$1 == old) list[i] = (into, list[i].$2);
        }
      }
    }
  }
}
