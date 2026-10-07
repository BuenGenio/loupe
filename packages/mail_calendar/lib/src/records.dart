/// What the device remembers about an invitation: the latest version seen
/// (to tell an update from the original and say what changed), whether it
/// was cancelled, and the user's response.
library;

import 'event.dart';
import 'occurrences.dart';
import 'time_zones.dart';

/// An event version, as much as "what changed" needs.
final class EventSnapshot {
  const EventSnapshot({
    required this.sequence,
    this.start,
    this.end,
    this.allDay = false,
    this.summary,
    this.location,
    this.rule,
  });

  /// [event]'s version, its times resolved through [zones].
  factory EventSnapshot.of(CalendarEvent event, ZoneResolver zones) {
    final span = eventSpan(event, zones);
    return EventSnapshot(
      sequence: event.sequence,
      start: span?.start,
      end: span?.end,
      allDay: span?.allDay ?? false,
      summary: event.summary,
      location: event.location,
      rule: event.ruleText,
    );
  }

  final int sequence;

  /// As [TimeSpan] has them: instants (UTC), or local wall-clock times.
  final DateTime? start;
  final DateTime? end;
  final bool allDay;
  final String? summary;
  final String? location;
  final String? rule;

  TimeSpan? get span => start == null ? null : TimeSpan(start: start!, end: end ?? start!, allDay: allDay);

  Map<String, Object?> toJson() => {
    'seq': sequence,
    if (start != null) 'start': start!.toIso8601String(),
    if (end != null) 'end': end!.toIso8601String(),
    if (allDay) 'allDay': true,
    if (summary != null) 'summary': summary,
    if (location != null) 'location': location,
    if (rule != null) 'rule': rule,
  };

  static EventSnapshot fromJson(Map<String, Object?> j) => EventSnapshot(
    sequence: (j['seq'] as num?)?.toInt() ?? 0,
    start: DateTime.tryParse(j['start'] as String? ?? ''),
    end: DateTime.tryParse(j['end'] as String? ?? ''),
    allDay: j['allDay'] == true,
    summary: j['summary'] as String?,
    location: j['location'] as String?,
    rule: j['rule'] as String?,
  );
}

/// What changed from [before] to [after].
final class EventChanges {
  const EventChanges({this.time, this.location, this.title = false, this.recurrence = false});

  /// The times before and after, when they changed.
  final (TimeSpan, TimeSpan)? time;

  /// The locations before and after (null for none), when it changed.
  final (String?, String?)? location;
  final bool title;
  final bool recurrence;

  bool get isEmpty => time == null && location == null && !title && !recurrence;

  static EventChanges between(EventSnapshot before, EventSnapshot after) {
    final a = before.span;
    final b = after.span;
    final timeChanged = a != null && b != null && (a.start != b.start || a.end != b.end || a.allDay != b.allDay);
    String? norm(String? s) => s?.trim().isEmpty ?? true ? null : s!.trim();
    return EventChanges(
      time: timeChanged ? (a, b) : null,
      location: norm(before.location) != norm(after.location) ? (norm(before.location), norm(after.location)) : null,
      title: norm(before.summary) != norm(after.summary),
      recurrence: norm(before.rule) != norm(after.rule),
    );
  }
}

/// The record of one invitation (a UID, and a RECURRENCE-ID for one
/// occurrence of a series).
final class InvitationRecord {
  const InvitationRecord({
    required this.uid,
    this.recurrenceId = '',
    required this.latest,
    this.previous,
    this.cancelledSequence,
    this.response,
    this.responseSequence,
    this.respondedAt,
  });

  final String uid;
  final String recurrenceId;

  /// The newest version seen.
  final EventSnapshot latest;

  /// The version seen before [latest], if any: what an update changed.
  final EventSnapshot? previous;

  /// The SEQUENCE of a cancellation seen.
  final int? cancelledSequence;

  /// What the user answered (accepted, tentative, declined), to which
  /// version, and when.
  final PartStat? response;
  final int? responseSequence;
  final DateTime? respondedAt;

  int get sequence => latest.sequence;

  bool get cancelled => cancelledSequence != null && cancelledSequence! >= latest.sequence;

  /// The record after seeing [event] (of a calendar with [method]): a newer
  /// version becomes [latest], the one before it [previous]; an older one
  /// changes nothing.
  InvitationRecord seen(CalendarEvent event, ItipMethod method, ZoneResolver zones) {
    final snapshot = EventSnapshot.of(event, zones);
    final cancel = method == ItipMethod.cancel || event.status == EventStatus.cancelled;
    if (snapshot.sequence < latest.sequence) return this;
    if (snapshot.sequence == latest.sequence) {
      if (!cancel || cancelledSequence == snapshot.sequence) return this;
      return _copy(cancelledSequence: snapshot.sequence);
    }
    return InvitationRecord(
      uid: uid,
      recurrenceId: recurrenceId,
      latest: cancel ? EventSnapshot.fromJson({...latest.toJson(), 'seq': snapshot.sequence}) : snapshot,
      previous: cancel ? previous : latest,
      cancelledSequence: cancel ? snapshot.sequence : cancelledSequence,
      response: response,
      responseSequence: responseSequence,
      respondedAt: respondedAt,
    );
  }

  /// The record of a first sighting of [event].
  static InvitationRecord first(CalendarEvent event, ItipMethod method, ZoneResolver zones) {
    final snapshot = EventSnapshot.of(event, zones);
    final cancel = method == ItipMethod.cancel || event.status == EventStatus.cancelled;
    return InvitationRecord(
      uid: event.uid ?? '',
      recurrenceId: event.recurrenceId?.value ?? '',
      latest: snapshot,
      cancelledSequence: cancel ? snapshot.sequence : null,
    );
  }

  /// The record after the user answered [partStat] to version [sequence].
  InvitationRecord responded(PartStat partStat, int sequence, DateTime at) =>
      _copy(response: partStat, responseSequence: sequence, respondedAt: at);

  InvitationRecord _copy({int? cancelledSequence, PartStat? response, int? responseSequence, DateTime? respondedAt}) =>
      InvitationRecord(
        uid: uid,
        recurrenceId: recurrenceId,
        latest: latest,
        previous: previous,
        cancelledSequence: cancelledSequence ?? this.cancelledSequence,
        response: response ?? this.response,
        responseSequence: responseSequence ?? this.responseSequence,
        respondedAt: respondedAt ?? this.respondedAt,
      );

  Map<String, Object?> toJson() => {
    'latest': latest.toJson(),
    if (previous != null) 'previous': previous!.toJson(),
    if (cancelledSequence != null) 'cancelled': cancelledSequence,
    if (response != null) 'response': response!.value,
    if (responseSequence != null) 'responseSeq': responseSequence,
    if (respondedAt != null) 'respondedAt': respondedAt!.toUtc().toIso8601String(),
  };

  static InvitationRecord? fromJson(String uid, String recurrenceId, Map<String, Object?> j) {
    final latest = j['latest'];
    if (latest is! Map) return null;
    final previous = j['previous'];
    return InvitationRecord(
      uid: uid,
      recurrenceId: recurrenceId,
      latest: EventSnapshot.fromJson(latest.cast()),
      previous: previous is Map ? EventSnapshot.fromJson(previous.cast()) : null,
      cancelledSequence: (j['cancelled'] as num?)?.toInt(),
      response: j['response'] == null ? null : PartStat.parse(j['response'] as String?),
      responseSequence: (j['responseSeq'] as num?)?.toInt(),
      respondedAt: DateTime.tryParse(j['respondedAt'] as String? ?? ''),
    );
  }
}
