import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_calendar/mail_calendar.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart' show inspectHost;
import 'package:url_launcher/url_launcher.dart';

import '../../providers.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/identity_selection.dart';
import '../compose/send_later.dart' show deviceDateLocale;
import '../conversation/sheets.dart';
import 'device_calendar.dart';
import 'invitation.dart';
import 'invitation_format.dart';
import 'invitation_reply.dart';

/// The device's zone for invitation times; null is the system's. Tests pin it.
final invitationZoneProvider = Provider<Zone?>((ref) => null);

/// An invitation above the message body: what, when (in local time, and in
/// the organizer's zone when it differs), how often, where (with a map),
/// the meeting link, who organizes and who comes, and Accept, Maybe and
/// Decline. Shows nothing when the message holds no event.
///
/// [inert] (likely phishing): links and answers are off.
class InvitationCard extends ConsumerStatefulWidget {
  const InvitationCard({
    super.key,
    required this.message,
    required this.content,
    required this.load,
    this.inert = false,
  });

  final EmailSummary message;
  final EmailContent content;
  final Future<Uint8List> Function(Attachment attachment) load;
  final bool inert;

  @override
  ConsumerState<InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends ConsumerState<InvitationCard> {
  Future<Invitation?>? _loading;
  Invitation? _invitation;
  bool _attendees = false;
  bool _commenting = false;
  bool _sending = false;
  final _comment = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loading = _load();
  }

  @override
  void didUpdateWidget(InvitationCard old) {
    super.didUpdateWidget(old);
    if (!identical(old.content, widget.content)) {
      _invitation = null;
      _loading = _load();
    }
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<Invitation?> _load() async {
    final part = invitationPart(widget.content);
    if (part == null) return null;
    try {
      final bytes = await widget.load(part);
      final List<MailAccount> accounts =
          ref.read(accountsProvider).value ?? await ref.read(accountsProvider.future) ?? const [];
      final repo = ref.read(repositoryProvider);
      final invitation = await readInvitation(
        bytes: bytes,
        part: part,
        message: widget.message,
        own: OwnAddresses(accounts),
        records: calendarRecordsOf(repo),
      );
      if (mounted) setState(() => _invitation = invitation);
      return invitation;
    } on Object {
      // Unreadable or gone: the message shows as it is, with its attachment.
      return null;
    }
  }

  EventTimeFormat _format(BuildContext context) => EventTimeFormat(
    locale: deviceDateLocale(),
    use24h: MediaQuery.alwaysUse24HourFormatOf(context),
    deviceZone: ref.watch(invitationZoneProvider),
    now: clock.now(),
  );

  @override
  Widget build(BuildContext context) {
    // Keeps the accounts coming: the user's addresses are who "you" are.
    ref.watch(accountsProvider);
    return FutureBuilder<Invitation?>(
      future: _loading,
      builder: (context, snapshot) {
        final invitation = _invitation ?? snapshot.data;
        if (invitation == null) return const SizedBox.shrink();
        return _card(context, invitation);
      },
    );
  }

  Widget _card(BuildContext context, Invitation inv) {
    final colors = LoupeColors.of(context);
    final format = _format(context);
    final event = inv.event;
    final span = inv.span;
    final now = clock.now();
    final next = inv.event.isRecurring ? inv.nextAfter(now) : null;
    final recurrence = inv.recurrence(formatDate: format.date);
    final place = inv.place;
    final link = inv.meetingLink;
    final organizer = event.organizer;
    final attendees = event.attendees.where((a) => a.email.isNotEmpty || a.name != null).toList();
    final isReply = inv.method == ItipMethod.reply;

    return Container(
      key: const Key('invitation-card'),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(color: subtleFill(context), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _title(context, inv),
          ..._notices(context, inv, format),
          if (span != null) _when(context, span, next, format, tzid: event.start?.tzid),
          if (recurrence != null)
            _row(context, LoupeIcons.recurring, Text(recurrence, key: const Key('invitation-recurrence'))),
          // A meeting service's "location" (Zoom's link, "Microsoft Teams Meeting") is the meeting row.
          if (event.location != null && (place != null || link == null))
            _row(
              context,
              LoupeIcons.location,
              Text(event.location!, key: const Key('invitation-location')),
              trailing: place == null || inv.cancelled
                  ? null
                  : _SmallButton(
                      key: const Key('invitation-map'),
                      label: 'Map',
                      onPressed: widget.inert ? null : () => _openMap(place),
                    ),
            ),
          if (link != null && !inv.cancelled)
            _row(
              context,
              LoupeIcons.meeting,
              Column(
                key: const Key('invitation-meeting'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_meetingName(link)),
                  Text(inspectHost(link.uri.host).display, style: TextStyle(color: colors.secondaryText, fontSize: 14)),
                ],
              ),
              trailing: _SmallButton(
                key: const Key('invitation-join'),
                label: 'Join',
                onPressed: widget.inert ? null : () => _join(link),
              ),
            ),
          if (organizer != null && organizer.email.isNotEmpty && !isReply)
            _row(
              context,
              LoupeIcons.person,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: inv.isOrganizer ? 'You' : organizer.displayName),
                    TextSpan(
                      text: ' · organizer',
                      style: TextStyle(color: colors.secondaryText),
                    ),
                  ],
                ),
                key: const Key('invitation-organizer'),
              ),
            ),
          if (attendees.isNotEmpty && !isReply) ..._attendeeRows(context, inv, attendees),
          if (inv.canRespond) _answers(context, inv),
          if (inv.canRespond || inv.canAddToCalendar) _footer(context, inv),
        ],
      ),
    );
  }

  /// "Teams meeting", "Google Meet", "Online meeting".
  static String _meetingName(MeetingLink link) {
    final provider = link.provider;
    if (provider == null) return 'Online meeting';
    return provider.endsWith('Meet') || provider.endsWith('Meeting') ? provider : '$provider meeting';
  }

  Widget _title(BuildContext context, Invitation inv) {
    final styles = LoupeTextStyles.of(context);
    final theme = Theme.of(context);
    final cancelled = inv.cancelled;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(
            cancelled ? LoupeIcons.eventCancelled : LoupeIcons.calendar,
            color: cancelled ? LoupeColors.of(context).destructive : theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            inv.event.summary ?? 'Event',
            key: const Key('invitation-title'),
            style: styles.body.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              decoration: cancelled ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        if (_responseLabel(inv) case final label?) _Pill(label: label.$1, color: label.$2(context)),
      ],
    );
  }

  /// "Accepted" and its colour, for the title row.
  (String, Color Function(BuildContext))? _responseLabel(Invitation inv) {
    if (inv.method != ItipMethod.request && inv.method != ItipMethod.add) return null;
    if (inv.cancelled || inv.outdated) return null;
    return switch (inv.response) {
      PartStat.accepted => ('Accepted', (c) => CupertinoColors.systemGreen.resolveFrom(c)),
      PartStat.tentative => ('Maybe', (c) => CupertinoColors.systemOrange.resolveFrom(c)),
      PartStat.declined => ('Declined', (c) => CupertinoColors.systemRed.resolveFrom(c)),
      _ => null,
    };
  }

  List<Widget> _notices(BuildContext context, Invitation inv, EventTimeFormat format) {
    final colors = LoupeColors.of(context);
    final orange = CupertinoColors.systemOrange.resolveFrom(context);
    final primary = Theme.of(context).colorScheme.primary;
    Widget notice(Key key, IconData icon, Color color, String text, {String? detail}) => Padding(
      key: key,
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 15),
                ),
                if (detail != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(detail, style: TextStyle(color: colors.secondaryText, fontSize: 14)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    final out = <Widget>[];
    switch (inv.method) {
      case ItipMethod.reply:
        for (final a in inv.event.attendees) {
          final who = a.displayName;
          final comment = inv.event.comments.firstOrNull;
          final (icon, color) = _statusLook(context, a.partStat);
          out.add(
            notice(
              ValueKey('invitation-reply-${a.email}'),
              icon,
              color,
              comment == null ? '$who ${partStatVerb(a.partStat)}' : '$who ${partStatVerb(a.partStat)}:',
              detail: comment == null ? null : '“$comment”',
            ),
          );
        }
      case ItipMethod.counter:
        final who = inv.event.attendees.firstOrNull?.displayName ?? 'An attendee';
        out.add(notice(const Key('invitation-counter'), LoupeIcons.eventUpdated, orange, '$who proposes a new time'));
      case ItipMethod.declineCounter:
        out.add(notice(const Key('invitation-declinecounter'), LoupeIcons.info, orange, 'The organizer kept the time'));
      case ItipMethod.refresh:
        final who = inv.event.attendees.firstOrNull?.displayName ?? 'An attendee';
        out.add(
          notice(const Key('invitation-refresh'), LoupeIcons.refresh, primary, '$who asks for the latest version'),
        );
      default:
        break;
    }
    if (inv.cancelled) {
      out.add(
        notice(
          const Key('invitation-cancelled'),
          LoupeIcons.eventCancelled,
          colors.destructive,
          'Cancelled',
          detail: inv.method == ItipMethod.cancel
              ? 'The organizer cancelled this event.'
              : 'This event was cancelled later.',
        ),
      );
    } else if (inv.outdated) {
      out.add(
        notice(
          const Key('invitation-outdated'),
          LoupeIcons.eventUpdated,
          orange,
          'Out of date',
          detail: 'This invitation was updated later; the newer one counts.',
        ),
      );
    } else if (inv.changes case final changes?) {
      final lines = <String>[
        if (changes.time case (final before, final after)) _timeChange(format, before, after),
        if (changes.location case (final before, final after))
          after == null ? 'Location removed (was ${before ?? 'none'})' : 'Location changed to $after',
        if (changes.title) 'New title',
        if (changes.recurrence) 'The repeat changed',
      ];
      out.add(
        notice(const Key('invitation-updated'), LoupeIcons.eventUpdated, primary, 'Updated', detail: lines.join('\n')),
      );
    } else if (inv.event.sequence > 0 && inv.method == ItipMethod.request && inv.record?.previous == null) {
      // An update whose earlier version this device never saw.
      out.add(notice(const Key('invitation-updated'), LoupeIcons.eventUpdated, primary, 'Updated invitation'));
    }
    return out;
  }

  /// "Time changed from 17:00–18:00 to 18:00–19:00" (with the days when they differ).
  String _timeChange(EventTimeFormat format, TimeSpan before, TimeSpan after) {
    final a = format.when(before);
    final b = format.when(after);
    if (a.day == b.day && a.time != null && b.time != null && !before.allDay && !after.allDay) {
      return 'Time changed from ${a.time} to ${b.time}';
    }
    return 'Time changed from ${_describe(format, before)} to ${_describe(format, after)}';
  }

  String _describe(EventTimeFormat format, TimeSpan span) {
    final w = format.when(span);
    return w.time == null || span.allDay ? w.day : '${w.day}, ${w.time}';
  }

  (IconData, Color) _statusLook(BuildContext context, PartStat status) => switch (status) {
    PartStat.accepted => (LoupeIcons.accepted, CupertinoColors.systemGreen.resolveFrom(context)),
    PartStat.declined => (LoupeIcons.declined, CupertinoColors.systemRed.resolveFrom(context)),
    PartStat.tentative => (LoupeIcons.tentative, CupertinoColors.systemOrange.resolveFrom(context)),
    _ => (LoupeIcons.awaitingReply, LoupeColors.of(context).secondaryText),
  };

  Widget _when(BuildContext context, TimeSpan span, TimeSpan? next, EventTimeFormat format, {String? tzid}) {
    final colors = LoupeColors.of(context);
    final w = format.when(span);
    final showNext = next != null && next.start != span.start;
    return _row(
      context,
      LoupeIcons.time,
      Column(
        key: const Key('invitation-when'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(w.day),
          // The event's own times, then "… your time", on lines of their own.
          for (final line in (w.time ?? '').split(' · '))
            if (line.isNotEmpty) Text(line, style: TextStyle(color: colors.secondaryText, fontSize: 14)),
          if (span.unknownZone)
            Text(
              'Time zone “${tzid ?? ''}” unknown: times as written',
              style: TextStyle(color: colors.secondaryText, fontSize: 13),
            ),
          if (showNext)
            Text(
              'Next: ${_describe(format, next)}',
              key: const Key('invitation-next'),
              style: TextStyle(color: colors.secondaryText, fontSize: 14),
            ),
        ],
      ),
    );
  }

  List<Widget> _attendeeRows(BuildContext context, Invitation inv, List<Attendee> attendees) {
    final colors = LoupeColors.of(context);
    final counts = <PartStat, int>{};
    for (final a in attendees) {
      counts[a.partStat] = (counts[a.partStat] ?? 0) + 1;
    }
    final parts = [
      if (counts[PartStat.accepted] case final n?) '$n accepted',
      if (counts[PartStat.tentative] case final n?) '$n maybe',
      if (counts[PartStat.declined] case final n?) '$n declined',
    ];
    final summary =
        '${attendees.length} ${attendees.length == 1 ? 'guest' : 'guests'}${parts.isEmpty ? '' : ' · ${parts.join(', ')}'}';
    return [
      InkWell(
        key: const Key('invitation-attendees'),
        onTap: () => setState(() => _attendees = !_attendees),
        child: _row(
          context,
          LoupeIcons.people,
          Text(summary),
          trailing: Icon(_attendees ? LoupeIcons.collapse : LoupeIcons.expand, size: 16, color: colors.secondaryText),
        ),
      ),
      if (_attendees)
        Padding(
          padding: const EdgeInsets.only(left: 28, top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final a in attendees)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(_statusLook(context, a.partStat).$1, size: 16, color: _statusLook(context, a.partStat).$2),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          [
                            if (identical(a, inv.me) || (inv.me != null && a.hasEmail(inv.me!.email)))
                              '${a.displayName} (you)'
                            else
                              a.displayName,
                            if (a.role == AttendeeRole.optional) 'optional',
                            if (a.isResource) 'room',
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
    ];
  }

  Widget _answers(BuildContext context, Invitation inv) {
    final colors = LoupeColors.of(context);
    final current = inv.response;
    final enabled = !widget.inert && !_sending;
    Widget answer(PartStat value, String label, Key key) {
      final selected = current == value && !inv.respondedToEarlier;
      final onPressed = enabled ? () => _respond(inv, value) : null;
      final child = Text(label, maxLines: 1);
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: selected
              ? FilledButton(key: key, onPressed: onPressed, child: child)
              : OutlinedButton(key: key, onPressed: onPressed, child: child),
        ),
      );
    }

    final from = _replyFrom(inv);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (inv.respondedToEarlier && inv.record?.response != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 3),
              child: Text(
                'You ${partStatVerb(inv.record!.response!)} an earlier version.',
                key: const Key('invitation-earlier-answer'),
                style: TextStyle(color: colors.secondaryText, fontSize: 14),
              ),
            ),
          Row(
            children: [
              answer(PartStat.accepted, 'Accept', const Key('invitation-accept')),
              answer(PartStat.tentative, 'Maybe', const Key('invitation-maybe')),
              answer(PartStat.declined, 'Decline', const Key('invitation-decline')),
            ],
          ),
          if (_commenting)
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 8, 3, 0),
              child: TextField(
                key: const Key('invitation-comment'),
                controller: _comment,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Comment for the organizer (optional)',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          if (from != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 8, 3, 0),
              child: Text(
                'Your reply goes to ${inv.event.organizer!.displayName} from $from.',
                key: const Key('invitation-reply-from'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.secondaryText, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  String? _replyFrom(Invitation inv) {
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final from = replyIdentity(
      accounts: accounts,
      message: widget.message,
      me: inv.me,
      headers: widget.content.headers,
    );
    return from?.identity.email;
  }

  /// Add a Comment (while answering is possible) and Add to Calendar.
  Widget _footer(BuildContext context, Invitation inv) {
    final colors = LoupeColors.of(context);
    final style = TextButton.styleFrom(
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 15),
    );
    final enabled = !widget.inert && !_sending;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              if (inv.canRespond && !_commenting)
                TextButton.icon(
                  key: const Key('invitation-add-comment'),
                  style: style,
                  onPressed: enabled ? () => setState(() => _commenting = true) : null,
                  icon: const Icon(LoupeIcons.comment, size: 18),
                  label: const Text('Add a Comment'),
                ),
              if (inv.canAddToCalendar)
                TextButton.icon(
                  key: const Key('invitation-add-to-calendar'),
                  style: style,
                  onPressed: widget.inert ? null : () => _addToCalendar(inv),
                  icon: const Icon(LoupeIcons.addToCalendar, size: 18),
                  label: const Text('Add to Calendar'),
                ),
            ],
          ),
          if (inv.otherEvents > 0)
            Text(
              inv.otherEvents == 1 ? 'And 1 more event in the file' : 'And ${inv.otherEvents} more events in the file',
              textAlign: TextAlign.end,
              style: TextStyle(color: colors.secondaryText, fontSize: 13),
            ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, IconData icon, Widget child, {Widget? trailing}) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, size: 18, color: colors.secondaryText),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DefaultTextStyle.merge(style: styles.body.copyWith(fontSize: 15), child: child),
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing],
        ],
      ),
    );
  }

  // Actions -------------------------------------------------------------------

  Future<void> _respond(Invitation inv, PartStat answer) async {
    setState(() => _sending = true);
    try {
      final comment = _comment.text.trim();
      final record = await sendInvitationReply(
        context,
        ref,
        invitation: inv,
        source: widget.message,
        answer: answer,
        headers: widget.content.headers,
        comment: comment.isEmpty ? null : comment,
        onUndone: (before) {
          if (mounted) setState(() => _invitation = (_invitation ?? inv).withRecord(before));
        },
      );
      if (record != null && mounted) {
        setState(() {
          _invitation = inv.withRecord(record);
          _commenting = false;
          _comment.clear();
        });
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _addToCalendar(Invitation inv) async {
    final messenger = ScaffoldMessenger.of(context);
    final event = deviceEventFor(inv);
    if (event == null) return;
    try {
      final opened = await ref.read(deviceCalendarProvider).add(event);
      if (!opened && defaultTargetPlatform == TargetPlatform.android) {
        showSnack(messenger, 'There’s no calendar app to add the event to.');
      }
    } on Object {
      showSnack(messenger, 'Couldn’t open the calendar.');
    }
  }

  Future<void> _join(MeetingLink link) async {
    final host = inspectHost(link.uri.host);
    final ok = await showActionSheet<bool>(
      context,
      title: 'Join ${link.provider ?? 'the'} Meeting?',
      message: [
        'Opens ${host.display} in your browser.',
        if (host.homograph)
          'Careful: this address imitates ${host.looksLike ?? 'another site'} with look-alike letters.',
      ].join('\n\n'),
      actions: [SheetAction('Open ${host.display}', true, isDefault: true)],
    );
    if (ok != true || !mounted) return;
    await _launch(link.uri);
  }

  Future<void> _openMap(({String? query, (double, double)? geo}) place) async {
    final query = place.query?.replaceAll('\n', ', ');
    final geo = place.geo;
    final Uri uri;
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      uri = Uri.https('maps.apple.com', '/', {
        if (query != null) 'q': query,
        if (geo != null) 'll': '${geo.$1},${geo.$2}',
      });
    } else {
      // The map app the user picked (geo: intent), with the place searched for.
      final at = geo == null ? '0,0' : '${geo.$1},${geo.$2}';
      final q = query ?? (geo == null ? '' : '${geo.$1},${geo.$2}');
      uri = Uri.parse('geo:$at?q=${Uri.encodeQueryComponent(q)}');
    }
    if (await _launch(uri, quiet: true)) return;
    await _launch(Uri.https('www.openstreetmap.org', '/search', {'query': query ?? '${geo?.$1},${geo?.$2}'}));
  }

  Future<bool> _launch(Uri uri, {bool quiet = false}) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && !quiet) showSnack(messenger, 'Couldn’t open the link.');
      return ok;
    } on Object {
      if (!quiet) showSnack(messenger, 'Couldn’t open the link.');
      return false;
    }
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => FilledButton.tonal(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      minimumSize: const Size(0, 32),
    ),
    child: Text(label),
  );
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    key: const Key('invitation-response'),
    margin: const EdgeInsets.only(left: 8, top: 2),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
    child: Text(
      label,
      style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
    ),
  );
}
