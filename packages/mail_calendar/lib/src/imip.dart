/// iMIP (RFC 6047) and iTIP (RFC 5546): replies to invitations.
library;

import 'component.dart';
import 'content_line.dart';
import 'event.dart';
import 'values.dart';

/// The PRODID of what Loupe writes.
const loupeProductId = '-//Loupe//Loupe Mail//EN';

/// Builds the iTIP REPLY (RFC 5546 §3.2.3) of the attendee [email] to
/// [event] of [calendar], answering [partStat] (accepted, tentative or
/// declined), with an optional [comment] for the organizer.
///
/// It has METHOD:REPLY and one VEVENT with the event's UID, SEQUENCE and
/// RECURRENCE-ID, its ORGANIZER, one ATTENDEE (the attendee's line from the
/// invitation, with the new PARTSTAT and without RSVP; a new line when the
/// invitation didn't name them) and DTSTAMP [now]; also DTSTART, DTEND (or
/// DURATION) and SUMMARY, as Outlook, Google and Thunderbird send them, and
/// the VTIMEZONEs those use.
String buildReply({
  required Calendar calendar,
  required CalendarEvent event,
  required String email,
  String? name,
  required PartStat partStat,
  String? comment,
  required DateTime now,
  String productId = loupeProductId,
}) {
  if (!partStat.isAnswer) throw ArgumentError.value(partStat, 'partStat', 'must be an answer');
  final existing = event.component.all('ATTENDEE').where((p) => CalAddress.fromProperty(p).hasEmail(email)).firstOrNull;
  final Property attendee;
  if (existing != null) {
    final params = {
      for (final MapEntry(:key, :value) in existing.params.entries)
        if (key != 'RSVP' && key != 'PARTSTAT' && key != 'SENT-BY') key: value,
    };
    if (!params.containsKey('CN') && (name?.trim().isNotEmpty ?? false)) params['CN'] = [name!.trim()];
    attendee = Property(
      'ATTENDEE',
      existing.value.trim(),
      params: {
        ...params,
        'PARTSTAT': [partStat.value],
      },
    );
  } else {
    attendee = Property(
      'ATTENDEE',
      'mailto:${email.trim()}',
      params: {
        if (name?.trim().isNotEmpty ?? false) 'CN': [name!.trim()],
        'PARTSTAT': [partStat.value],
      },
    );
  }
  final source = event.component;
  final properties = <Property>[
    attendee,
    ?source.property('ORGANIZER'),
    Property('UID', event.uid ?? ''),
    Property('SEQUENCE', '${event.sequence}'),
    ?source.property('RECURRENCE-ID'),
    CalDateTime.utc(now).toProperty('DTSTAMP'),
    ?source.property('DTSTART'),
    ?source.property('DTEND'),
    if (source.property('DTEND') == null) ?source.property('DURATION'),
    ?source.property('SUMMARY'),
    if (comment != null && comment.trim().isNotEmpty) Property('COMMENT', escapeText(comment.trim())),
  ];
  final zones = <String>{for (final p in properties) ?p.param('TZID')};
  final root = Component(
    'VCALENDAR',
    properties: [Property('PRODID', productId), Property('VERSION', '2.0'), Property('METHOD', 'REPLY')],
    components: [
      for (final tzid in zones) ?calendar.timezone(tzid),
      Component('VEVENT', properties: properties),
    ],
  );
  return root.toIcs();
}

/// "accepted", "tentatively accepted", "declined".
String partStatVerb(PartStat partStat) => switch (partStat) {
  PartStat.accepted => 'accepted',
  PartStat.tentative => 'tentatively accepted',
  PartStat.declined => 'declined',
  PartStat.delegated => 'delegated',
  _ => 'not responded to',
};

/// The subject of a reply, as Outlook writes it: "Accepted: Team sync".
String replySubject(PartStat partStat, String? summary) {
  final verb = switch (partStat) {
    PartStat.accepted => 'Accepted',
    PartStat.tentative => 'Tentative',
    PartStat.declined => 'Declined',
    _ => 'Reply',
  };
  final title = summary?.trim();
  return title == null || title.isEmpty ? verb : '$verb: $title';
}
