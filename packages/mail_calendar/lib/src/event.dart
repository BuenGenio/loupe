/// Calendars and events as invitations use them.
library;

import 'component.dart';
import 'content_line.dart';
import 'rrule.dart';
import 'time_zones.dart';
import 'values.dart';

/// The iTIP method of a calendar object (RFC 5546 §1.4).
enum ItipMethod {
  publish,
  request,
  reply,
  add,
  cancel,
  refresh,
  counter,
  declineCounter,

  /// No METHOD (a plain .ics file) or one not known.
  none;

  static ItipMethod parse(String? value) => switch (value?.trim().toUpperCase()) {
    'PUBLISH' => publish,
    'REQUEST' => request,
    'REPLY' => reply,
    'ADD' => add,
    'CANCEL' => cancel,
    'REFRESH' => refresh,
    'COUNTER' => counter,
    'DECLINECOUNTER' => declineCounter,
    _ => none,
  };

  String get value => switch (this) {
    declineCounter => 'DECLINECOUNTER',
    none => '',
    _ => name.toUpperCase(),
  };
}

/// An attendee's participation status (PARTSTAT).
enum PartStat {
  needsAction,
  accepted,
  declined,
  tentative,
  delegated,

  /// Another value (COMPLETED, IN-PROCESS, an X- name).
  other;

  static PartStat parse(String? value) => switch (value?.trim().toUpperCase()) {
    null || '' || 'NEEDS-ACTION' => needsAction,
    'ACCEPTED' => accepted,
    'DECLINED' => declined,
    'TENTATIVE' => tentative,
    'DELEGATED' => delegated,
    _ => other,
  };

  String get value => switch (this) {
    needsAction => 'NEEDS-ACTION',
    other => 'NEEDS-ACTION',
    _ => name.toUpperCase(),
  };

  /// One of the answers a reply gives.
  bool get isAnswer => this == accepted || this == declined || this == tentative;
}

/// An attendee's role (ROLE).
enum AttendeeRole {
  chair,
  required,
  optional,
  nonParticipant;

  static AttendeeRole parse(String? value) => switch (value?.trim().toUpperCase()) {
    'CHAIR' => chair,
    'OPT-PARTICIPANT' => optional,
    'NON-PARTICIPANT' => nonParticipant,
    _ => required,
  };
}

enum EventStatus {
  tentative,
  confirmed,
  cancelled;

  static EventStatus? parse(String? value) => switch (value?.trim().toUpperCase()) {
    'TENTATIVE' => tentative,
    'CONFIRMED' => confirmed,
    'CANCELLED' || 'CANCELED' => cancelled,
    _ => null,
  };
}

/// A calendar user (ORGANIZER, ATTENDEE): an address and a name.
final class CalAddress {
  const CalAddress({required this.email, this.name, this.property});

  /// The address, from a `mailto:` value; empty when the value is something else.
  final String email;

  /// CN, when given.
  final String? name;

  /// The property as written.
  final Property? property;

  /// The name, else the address.
  String get displayName => (name?.trim().isNotEmpty ?? false) ? name!.trim() : email;

  static String emailOf(String value) {
    final v = value.trim();
    if (v.toLowerCase().startsWith('mailto:')) return Uri.decodeComponent(v.substring(7)).trim();
    return v.contains('@') && !v.contains(':') ? v : '';
  }

  static CalAddress fromProperty(Property p) {
    final cn = p.param('CN')?.trim();
    return CalAddress(email: emailOf(p.value), name: cn == null || cn.isEmpty ? null : cn, property: p);
  }

  bool hasEmail(String other) => email.isNotEmpty && email.toLowerCase() == other.trim().toLowerCase();
}

/// An ATTENDEE.
final class Attendee extends CalAddress {
  const Attendee({
    required super.email,
    super.name,
    super.property,
    this.partStat = PartStat.needsAction,
    this.role = AttendeeRole.required,
    this.rsvp = false,
    this.userType,
  });

  factory Attendee.fromProperty(Property p) {
    final cn = p.param('CN')?.trim();
    return Attendee(
      email: CalAddress.emailOf(p.value),
      name: cn == null || cn.isEmpty ? null : cn,
      property: p,
      partStat: PartStat.parse(p.param('PARTSTAT')),
      role: AttendeeRole.parse(p.param('ROLE')),
      rsvp: p.param('RSVP')?.toUpperCase() == 'TRUE',
      userType: p.param('CUTYPE')?.toUpperCase(),
    );
  }

  final PartStat partStat;
  final AttendeeRole role;

  /// The organizer asked for a reply.
  final bool rsvp;

  /// CUTYPE: INDIVIDUAL (the default), GROUP, RESOURCE, ROOM…
  final String? userType;

  /// A room or another resource, not a person.
  bool get isResource => userType == 'ROOM' || userType == 'RESOURCE';
}

/// A link to join an online meeting.
final class MeetingLink {
  const MeetingLink(this.uri, {this.provider});

  final Uri uri;

  /// "Teams", "Zoom", "Google Meet", "Webex"…; null when not known.
  final String? provider;

  @override
  bool operator ==(Object other) => other is MeetingLink && other.uri == uri;

  @override
  int get hashCode => uri.hashCode;

  @override
  String toString() => '$provider $uri';
}

/// A VEVENT.
final class CalendarEvent {
  CalendarEvent(this.component);

  /// The VEVENT as written.
  final Component component;

  String? _text(String name) {
    final p = component.property(name);
    if (p == null) return null;
    final t = p.text.trim();
    return t.isEmpty ? null : t;
  }

  String? get uid => component.property('UID')?.value.trim();

  /// SEQUENCE (0 when missing or unreadable).
  int get sequence => int.tryParse(component.property('SEQUENCE')?.value.trim() ?? '') ?? 0;

  String? get summary => _text('SUMMARY');
  String? get description => _text('DESCRIPTION');
  String? get location => _text('LOCATION');

  /// URL, when it is one.
  Uri? get url => _uri(component.property('URL')?.value);

  /// GEO: latitude and longitude.
  (double, double)? get geo {
    final v = component.property('GEO')?.value.split(RegExp('[;,]'));
    if (v == null || v.length != 2) return null;
    final lat = double.tryParse(v[0].trim());
    final lon = double.tryParse(v[1].trim());
    if (lat == null || lon == null || lat.abs() > 90 || lon.abs() > 180) return null;
    return (lat, lon);
  }

  /// Apple's structured location: a `geo:` URI with a title and an address.
  ({Uri uri, String? title, String? address})? get structuredLocation {
    final p = component.property('X-APPLE-STRUCTURED-LOCATION');
    final uri = _uri(p?.value);
    if (p == null || uri == null || uri.scheme != 'geo') return null;
    return (uri: uri, title: p.param('X-TITLE'), address: p.param('X-ADDRESS'));
  }

  CalDateTime? _time(String name) {
    final p = component.property(name);
    return p == null ? null : CalDateTime.fromProperty(p);
  }

  CalDateTime? get start => _time('DTSTART');

  /// DTEND as written (null with DURATION, or without either).
  CalDateTime? get dtEnd => _time('DTEND');

  CalDuration? get duration {
    final d = component.property('DURATION');
    return d == null ? null : CalDuration.parse(d.value);
  }

  /// When it ends: DTEND, else DTSTART plus DURATION, else the end of the
  /// day for an all-day event (or the start, for a timed one).
  CalDateTime? get end {
    final s = start;
    final e = dtEnd;
    if (s == null) return e;
    if (e != null && !e.local.isBefore(s.local)) {
      // An all-day start with a timed end is read as all-day.
      return s.isDate && !e.isDate ? CalDateTime.date(e.local.year, e.local.month, e.local.day + 1) : e;
    }
    final d = duration;
    if (d != null && !d.negative) return CalDateTime.like(s, d.addTo(s.local));
    if (s.isDate) return CalDateTime.date(s.local.year, s.local.month, s.local.day + 1);
    return s;
  }

  bool get isAllDay => start?.isDate ?? false;

  RecurrenceRule? get rule {
    final p = component.property('RRULE');
    return p == null ? null : RecurrenceRule.parse(p.value);
  }

  /// The RRULE value as written.
  String? get ruleText => component.property('RRULE')?.value.trim();

  List<CalDateTime> _times(String name) => [
    for (final p in component.all(name))
      if ((p.param('VALUE')?.toUpperCase() ?? '') != 'PERIOD')
        for (final v in p.value.split(','))
          if (CalDateTime.parse(v, tzid: p.param('TZID')) case final t?) t,
  ];

  List<CalDateTime> get exceptionDates => _times('EXDATE');
  List<CalDateTime> get recurrenceDates => _times('RDATE');

  /// RECURRENCE-ID: which occurrence of a series this event is.
  CalDateTime? get recurrenceId => _time('RECURRENCE-ID');

  /// The RECURRENCE-ID applies to the later occurrences too (RANGE=THISANDFUTURE).
  bool get thisAndFuture => component.property('RECURRENCE-ID')?.param('RANGE')?.toUpperCase() == 'THISANDFUTURE';

  bool get isRecurring => component.property('RRULE') != null || component.property('RDATE') != null;

  CalAddress? get organizer {
    final p = component.property('ORGANIZER');
    return p == null ? null : CalAddress.fromProperty(p);
  }

  List<Attendee> get attendees => [for (final p in component.all('ATTENDEE')) Attendee.fromProperty(p)];

  /// The attendee with one of [addresses], or null.
  Attendee? attendeeFor(Iterable<String> addresses) {
    final wanted = {for (final a in addresses) a.trim().toLowerCase()};
    for (final a in attendees) {
      if (wanted.contains(a.email.toLowerCase())) return a;
    }
    return null;
  }

  EventStatus? get status => EventStatus.parse(component.property('STATUS')?.value);

  DateTime? get stamp {
    final t = _time('DTSTAMP');
    return t == null || !t.isUtc ? null : t.local;
  }

  /// COMMENTs (a reply's note to the organizer).
  List<String> get comments => [
    for (final p in component.all('COMMENT'))
      if (p.text.trim().isNotEmpty) p.text.trim(),
  ];

  /// Meeting links: CONFERENCE (RFC 7986), Google's and Microsoft's
  /// properties, then a URL, LOCATION or DESCRIPTION pointing at a known
  /// meeting service. The first is the one to offer.
  List<MeetingLink> get meetingLinks {
    final out = <MeetingLink>{};
    void add(String? value, {bool knownOnly = false}) {
      final uri = _uri(value);
      if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http')) return;
      final provider = meetingProvider(uri);
      if (knownOnly && provider == null) return;
      out.add(MeetingLink(uri, provider: provider));
    }

    for (final p in component.all('CONFERENCE')) {
      add(p.value);
    }
    add(component.property('X-GOOGLE-CONFERENCE')?.value);
    add(component.property('X-MICROSOFT-SKYPETEAMSMEETINGURL')?.value);
    add(component.property('X-MICROSOFT-ONLINEMEETINGCONFLINK')?.value);
    add(component.property('URL')?.value, knownOnly: true);
    for (final text in [location, description]) {
      if (text == null) continue;
      for (final m in RegExp(r'''https?://[^\s<>"'\)\]]+''').allMatches(text)) {
        add(m[0]!.replaceAll(RegExp(r'[.,;:!?]+$'), ''), knownOnly: true);
      }
    }
    return out.toList();
  }
}

/// The service behind a meeting link, or null.
String? meetingProvider(Uri uri) {
  final host = uri.host.toLowerCase();
  bool at(String domain) => host == domain || host.endsWith('.$domain');
  if (at('teams.microsoft.com') || at('teams.live.com')) return 'Teams';
  if (at('zoom.us') || at('zoomgov.com')) return 'Zoom';
  if (at('meet.google.com')) return 'Google Meet';
  if (at('webex.com')) return 'Webex';
  if (at('whereby.com')) return 'Whereby';
  if (at('meet.jit.si')) return 'Jitsi';
  if (at('gotomeeting.com') || at('meet.goto.com')) return 'GoTo Meeting';
  if (at('chime.aws')) return 'Amazon Chime';
  if (at('bluejeans.com')) return 'BlueJeans';
  if (at('facetime.apple.com')) return 'FaceTime';
  if (at('skype.com') || host == 'join.skype.com') return 'Skype';
  return null;
}

Uri? _uri(String? value) {
  final v = value?.trim();
  if (v == null || v.isEmpty) return null;
  final uri = Uri.tryParse(v);
  if (uri == null || !uri.hasScheme) return null;
  if ((uri.scheme == 'https' || uri.scheme == 'http') && uri.host.isEmpty) return null;
  return uri;
}

/// A parsed iCalendar object.
final class Calendar {
  Calendar._(this.root, this.events, this.zones);

  /// Parses [text]; null when it holds no VCALENDAR or VEVENT. Bare VEVENTs
  /// (without VCALENDAR) are read too.
  static Calendar? parse(String text) {
    final roots = parseComponents(text);
    var root = roots.where((c) => c.name == 'VCALENDAR').firstOrNull;
    if (root == null) {
      final events = roots.where((c) => c.name == 'VEVENT').toList();
      if (events.isEmpty) return null;
      root = Component('VCALENDAR', components: events);
    }
    final timezones = <String, Component>{
      for (final tz in root.children('VTIMEZONE'))
        if (tz.property('TZID')?.value.trim() case final id? when id.isNotEmpty) id: tz,
    };
    final events = [for (final c in root.children('VEVENT')) CalendarEvent(c)];
    return Calendar._(root, events, ZoneResolver(timezones));
  }

  /// The VCALENDAR as written.
  final Component root;

  /// Its VEVENTs, in order.
  final List<CalendarEvent> events;

  /// Its time zones: TZIDs to zones.
  final ZoneResolver zones;

  ItipMethod get method => ItipMethod.parse(root.property('METHOD')?.value);

  String? get productId => root.property('PRODID')?.value.trim();

  /// The VTIMEZONE with [tzid], as written.
  Component? timezone(String tzid) =>
      root.children('VTIMEZONE').where((c) => c.property('TZID')?.value.trim() == tzid.trim()).firstOrNull;

  /// The event the invitation is about: the master (without
  /// RECURRENCE-ID) of the first UID, else its first occurrence.
  CalendarEvent? get primary {
    if (events.isEmpty) return null;
    final uid = events.first.uid;
    final same = events.where((e) => e.uid == uid);
    return same.where((e) => e.recurrenceId == null).firstOrNull ?? same.first;
  }

  /// Events of [primary]'s UID that change one occurrence (RECURRENCE-ID).
  List<CalendarEvent> get overrides {
    final p = primary;
    if (p == null) return const [];
    return [
      for (final e in events)
        if (e.uid == p.uid && e.recurrenceId != null && !identical(e, p)) e,
    ];
  }

  /// How many different events (UIDs) it holds.
  int get eventCount => {for (final e in events) e.uid ?? identityHashCode(e)}.length;
}
