/// Calendar invitations for Loupe, in pure Dart: iCalendar (RFC 5545)
/// reading and writing, time zones (the IANA database, Outlook's Windows
/// names, VTIMEZONE rules), recurrence rules in words and expanded, and
/// iTIP replies (RFC 5546) for iMIP mail (RFC 6047).
library;

export 'src/component.dart' show Component, ParseLimits, parseComponents;
export 'src/content_line.dart' show Property, escapeText, foldLine, parseContentLine, unescapeText, unfoldLines;
export 'src/describe.dart' show describeRule, formatShortDate;
export 'src/event.dart'
    show
        Attendee,
        AttendeeRole,
        CalAddress,
        Calendar,
        CalendarEvent,
        EventStatus,
        ItipMethod,
        MeetingLink,
        PartStat,
        meetingProvider;
export 'src/imip.dart' show buildReply, loupeProductId, partStatVerb, replySubject;
export 'src/occurrences.dart' show TimeSpan, eventOccurrences, eventSpan;
export 'src/records.dart' show EventChanges, EventSnapshot, InvitationRecord;
export 'src/rrule.dart' show Frequency, RecurrenceRule, WeekdayNum, expandRule;
export 'src/time_zones.dart'
    show
        EmbeddedZone,
        FixedZone,
        IanaZone,
        Zone,
        ZoneResolver,
        ensureTimeZoneDatabase,
        ianaZoneName,
        offsetLabel,
        zoneLabel;
export 'src/values.dart' show CalDateTime, CalDuration, TimeForm, parseUtcOffset;
