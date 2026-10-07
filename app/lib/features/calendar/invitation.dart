import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';

import '../attachments/attachment_type.dart';
import '../attachments/text_decoding.dart';
import '../compose/identity_selection.dart';

/// The repository's [CalendarRecords], when it keeps them.
CalendarRecords? calendarRecordsOf(MailRepository repository) => switch (repository) {
  final CalendarRecords records => records,
  _ => null,
};

/// Calendar files bigger than this aren't read for a card (an invitation is
/// a few kilobytes; a whole calendar exported can be megabytes).
const maxInvitationBytes = 1024 * 1024;

/// An invitation's `text/calendar` alternative (iMIP), not a file someone
/// attached: the card stands for it, so the attachment list leaves it out.
bool isCalendarAlternative(Attachment a) => a.mimeType.toLowerCase() == 'text/calendar' && a.filename == null;

/// The part of [content] an invitation card shows: the `text/calendar`
/// alternative (what iMIP sends, with the method), else a calendar file
/// attached (`.ics`). Null without one, or when it is too big.
Attachment? invitationPart(EmailContent content) {
  final candidates = [
    for (final a in content.attachments)
      if (attachmentKindOf(a.mimeType, a.filename) == AttachmentKind.calendar && a.size <= maxInvitationBytes) a,
  ];
  return candidates.where(isCalendarAlternative).firstOrNull ?? candidates.firstOrNull;
}

/// What an invitation card shows: the calendar object, the event it is
/// about, and what the device knows about it.
final class Invitation {
  Invitation({
    required this.calendar,
    required this.event,
    required this.part,
    this.record,
    this.me,
    this.isOrganizer = false,
    this.senderIsOrganizer = true,
  });

  /// The calendar object as sent.
  final Calendar calendar;

  /// The event: the master of a series, or the one occurrence it changes.
  final CalendarEvent event;

  /// Where it came from.
  final Attachment part;

  /// The device's record of this invitation, after seeing this one; null
  /// for replies and proposals (other people's answers), or without a store.
  final InvitationRecord? record;

  /// The user among the attendees (by one of their addresses), if they are.
  final Attendee? me;

  /// The user organizes it (their copy, or replies to their invitation).
  final bool isOrganizer;

  /// The message comes from the organizer (or the file is the iMIP
  /// alternative, which calendar services send for the organizer).
  final bool senderIsOrganizer;

  /// The same invitation with [record] (after the user answered, or Undo).
  Invitation withRecord(InvitationRecord? record) => Invitation(
    calendar: calendar,
    event: event,
    part: part,
    record: record,
    me: me,
    isOrganizer: isOrganizer,
    senderIsOrganizer: senderIsOrganizer,
  );

  ItipMethod get method => calendar.method;
  ZoneResolver get zones => calendar.zones;

  /// The first occurrence (DTSTART).
  TimeSpan? get span => eventSpan(event, zones);

  /// The occurrence that hasn't ended at [now]: the event itself, or the
  /// next one of a series.
  TimeSpan? nextAfter(DateTime now) => eventOccurrences(event, zones, from: now, limit: 1).firstOrNull;

  /// The recurrence in words, or null for a single event.
  String? recurrence({String Function(DateTime date)? formatDate}) {
    final rule = event.rule;
    final start = event.start;
    if (rule == null || start == null) return null;
    return formatDate == null
        ? describeRule(rule, start: start, zones: zones)
        : describeRule(rule, start: start, zones: zones, formatDate: formatDate);
  }

  /// A newer version of it was seen: this one is out of date.
  bool get outdated => record != null && event.sequence < record!.sequence;

  /// It was cancelled: this is the cancellation, or one was seen since.
  bool get cancelled =>
      method == ItipMethod.cancel || event.status == EventStatus.cancelled || (record?.cancelled ?? false);

  /// What this update changed, when the version before it was seen.
  EventChanges? get changes {
    final r = record;
    if (r == null || r.previous == null || event.sequence != r.sequence || method == ItipMethod.cancel) return null;
    final c = EventChanges.between(r.previous!, r.latest);
    return c.isEmpty ? null : c;
  }

  /// The user's answer, as sent from this device, else as the invitation
  /// says (an update from Google carries it); null when not answered.
  PartStat? get response {
    final sent = record?.response;
    if (sent != null) return sent;
    final said = me?.partStat;
    return said != null && said.isAnswer ? said : null;
  }

  /// The answer sent from this device was to an earlier version.
  bool get respondedToEarlier {
    final r = record;
    return r?.response != null && (r!.responseSequence ?? 0) < event.sequence;
  }

  /// Accept, Maybe and Decline are offered: an invitation (REQUEST or ADD)
  /// with an organizer to reply to, not the user's own, current and not
  /// cancelled. A calendar file attached by someone else than the organizer
  /// only goes to the phone's calendar.
  bool get canRespond =>
      (method == ItipMethod.request || method == ItipMethod.add) &&
      (event.organizer?.email.isNotEmpty ?? false) &&
      !isOrganizer &&
      !cancelled &&
      !outdated &&
      senderIsOrganizer;

  /// It can go to the phone's calendar.
  bool get canAddToCalendar =>
      event.start != null &&
      !cancelled &&
      method != ItipMethod.reply &&
      method != ItipMethod.refresh &&
      method != ItipMethod.declineCounter;

  /// Other events in the file (a calendar export), besides this one.
  int get otherEvents => calendar.eventCount - 1;

  /// The best link to join the meeting, if any.
  MeetingLink? get meetingLink => event.meetingLinks.firstOrNull;

  /// A place to show on a map: Apple's geo: URI, GEO, else the LOCATION text
  /// (not a link: those are meeting links).
  ({String? query, (double, double)? geo})? get place {
    final structured = event.structuredLocation;
    if (structured != null) {
      final coords = structured.uri.path.split(',');
      final lat = double.tryParse(coords.first);
      final lon = coords.length > 1 ? double.tryParse(coords[1].split(';').first) : null;
      return (query: event.location ?? structured.address, geo: lat != null && lon != null ? (lat, lon) : null);
    }
    final location = event.location;
    final geo = event.geo;
    if (location == null && geo == null) return null;
    if (location != null && RegExp(r'^\s*https?://', caseSensitive: false).hasMatch(location)) return null;
    // Outlook's "Microsoft Teams Meeting" is no place.
    if (location != null &&
        geo == null &&
        RegExp(r'^microsoft teams meeting$', caseSensitive: false).hasMatch(location)) {
      return null;
    }
    return (query: location, geo: geo);
  }
}

/// Reads the invitation in [bytes] (the [part] of [message]) and updates
/// the device's record of it in [records]. [own] tells the user's
/// addresses. Null when the part holds no event.
Future<Invitation?> readInvitation({
  required Uint8List bytes,
  required Attachment part,
  required EmailSummary message,
  required OwnAddresses own,
  CalendarRecords? records,
}) async {
  final calendar = Calendar.parse(decodeAttachmentText(bytes).text);
  final event = calendar?.primary;
  if (calendar == null || event == null) return null;
  final organizer = event.organizer;
  final isOrganizer = organizer != null && organizer.email.isNotEmpty && own.contains(organizer.email);
  final me = [
    for (final a in event.attendees)
      if (a.email.isNotEmpty && own.contains(a.email)) a,
  ].firstOrNull;
  final sender = message.sender?.email.toLowerCase();
  final senderIsOrganizer =
      isCalendarAlternative(part) || (organizer != null && sender != null && organizer.hasEmail(sender));

  InvitationRecord? record;
  final uid = event.uid;
  final tracked = switch (calendar.method) {
    ItipMethod.reply || ItipMethod.counter || ItipMethod.declineCounter || ItipMethod.refresh => false,
    _ => true,
  };
  if (records != null && uid != null && uid.isNotEmpty && tracked) {
    final recurrenceId = event.recurrenceId?.value ?? '';
    final json = await records.readCalendarRecord(uid, recurrenceId: recurrenceId);
    final before = json == null ? null : _decode(uid, recurrenceId, json);
    record =
        before?.seen(event, calendar.method, calendar.zones) ??
        InvitationRecord.first(event, calendar.method, calendar.zones);
    final encoded = jsonEncode(record.toJson());
    if (encoded != json) await records.writeCalendarRecord(uid, encoded, recurrenceId: recurrenceId);
  }
  return Invitation(
    calendar: calendar,
    event: event,
    part: part,
    record: record,
    me: me,
    isOrganizer: isOrganizer,
    senderIsOrganizer: senderIsOrganizer,
  );
}

InvitationRecord? _decode(String uid, String recurrenceId, String json) {
  try {
    final map = jsonDecode(json);
    return map is Map ? InvitationRecord.fromJson(uid, recurrenceId, map.cast()) : null;
  } on FormatException {
    return null;
  }
}

/// The identity to answer [message]'s invitation from: the one whose
/// address the invitation names as the attendee [me] (an unsaved alias of
/// an account counts, so the organizer finds the address they invited),
/// else as a reply to the message would choose. Null without accounts.
({MailAccount account, Identity identity})? replyIdentity({
  required List<MailAccount> accounts,
  required EmailSummary message,
  Attendee? me,
  List<(String, String)> headers = const [],
}) {
  final source = me == null
      ? message
      : EmailSummary(
          id: message.id,
          accountId: message.accountId,
          mailboxId: message.mailboxId,
          receivedAt: message.receivedAt,
          to: [EmailAddress(me.email, me.name)],
        );
  final choice = IdentitySelection.choose(accounts: accounts, source: source, headers: me == null ? headers : const []);
  if (choice == null) return null;
  if (choice.alias != null && choice.aliasAccount != null && choice.match != IdentityMatch.recipient) {
    return (account: choice.aliasAccount!, identity: choice.alias!);
  }
  return (account: choice.account, identity: choice.identity);
}
