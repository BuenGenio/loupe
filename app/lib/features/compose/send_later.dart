import 'dart:async';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import '../../platform/background.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';

/// The quick choices of "Send Later".
enum SendLaterPreset {
  laterToday(LoupeIcons.laterToday),
  tomorrowMorning(LoupeIcons.tomorrowMorning),
  mondayMorning(LoupeIcons.mondayMorning);

  const SendLaterPreset(this.icon);

  final IconData icon;

  String label(AppLocalizations l10n) => switch (this) {
    laterToday => l10n.composeLaterToday,
    tomorrowMorning => l10n.composeTomorrowMorning,
    mondayMorning => l10n.composeMondayMorning,
  };
}

/// "Later Today" (18:00) is offered only before this hour.
const laterTodayCutoffHour = 17;

/// The presets on offer at [now], with the times they send at: Later Today
/// (18:00, before 17:00 only), Tomorrow Morning (08:00) and Monday Morning
/// (08:00 next Monday; left out on Sundays, when it is tomorrow morning).
///
/// Times are wall-clock times in the device's time zone ([now] is converted
/// to local time first), so they stay at 08:00 across daylight-saving changes.
List<(SendLaterPreset, DateTime)> sendLaterPresets(DateTime now) {
  final n = now.toLocal();
  DateTime at(int days, int hour) => DateTime(n.year, n.month, n.day + days, hour);
  final tomorrow = at(1, 8);
  final toMonday = (DateTime.monday - n.weekday) % 7;
  final monday = at(toMonday == 0 ? 7 : toMonday, 8);
  return [
    if (n.hour < laterTodayCutoffHour) (SendLaterPreset.laterToday, at(0, 18)),
    (SendLaterPreset.tomorrowMorning, tomorrow),
    if (monday != tomorrow) (SendLaterPreset.mondayMorning, monday),
  ];
}

var _dateDataLoaded = false;

/// The device's locale for dates and times (intl's data for it loaded), or
/// en_US if intl doesn't know it.
String deviceDateLocale() {
  if (!_dateDataLoaded) {
    // Synchronous for the bundled data; the Future is only for the API.
    unawaited(initializeDateFormatting());
    _dateDataLoaded = true;
  }
  final tag = Intl.canonicalizedLocale(PlatformDispatcher.instance.locale.toLanguageTag());
  return Intl.verifiedLocale(tag, DateFormat.localeExists, onFailure: (_) => 'en_US') ?? 'en_US';
}

/// When a waiting message goes out: "Today at 18:00", "Tomorrow at 08:00",
/// "Monday at 08:00", "Tue, Oct 13 at 08:00" in [locale]'s formats, with a
/// 24-hour clock when [use24h] (the device setting) or the locale wants one.
/// [compact] is for the Send button: "Tomorrow 08:00", "Mon 08:00", "Oct 13 08:00",
/// and just "Jan 4, 2027" in another year.
String formatSendTime(
  DateTime at, {
  required DateTime now,
  required AppLocalizations l10n,
  String locale = 'en_US',
  bool use24h = false,
  bool compact = false,
}) {
  final a = at.toLocal();
  final n = now.toLocal();
  final time = (use24h ? DateFormat.Hm(locale) : DateFormat.jm(locale)).format(a);
  // Calendar days apart; UTC dates so a daylight-saving change doesn't make a day 23 hours.
  final days = DateTime.utc(a.year, a.month, a.day).difference(DateTime.utc(n.year, n.month, n.day)).inDays;
  if (days == 0) return compact ? l10n.composeSendTimeTodayShort(time) : l10n.composeSendTimeToday(time);
  if (days == 1) return compact ? l10n.composeSendTimeTomorrowShort(time) : l10n.composeSendTimeTomorrow(time);
  final String day;
  if (days > 1 && days < 7) {
    day = (compact ? DateFormat.E(locale) : DateFormat.EEEE(locale)).format(a);
  } else if (a.year == n.year) {
    day = (compact ? DateFormat.MMMd(locale) : DateFormat.MMMEd(locale)).format(a);
  } else {
    // Another year: on the Send button the date alone is long enough.
    if (compact) return DateFormat.yMMMd(locale).format(a);
    day = DateFormat.yMMMEd(locale).format(a);
  }
  return compact ? l10n.composeSendTimeDayShort(day, time) : l10n.composeSendTimeDay(day, time);
}

/// [formatSendTime] with the app's language, and the device's locale and
/// clock setting.
String formatSendTimeFor(BuildContext context, DateTime at, {required DateTime now, bool compact = false}) =>
    formatSendTime(
      at,
      now: now,
      l10n: context.l10n,
      locale: deviceDateLocale(),
      use24h: MediaQuery.alwaysUse24HourFormatOf(context),
      compact: compact,
    );

/// Times a wake-up was asked for in this run of the app, so each is asked for once.
final _wakeUpTimesProvider = Provider<Set<int>>((ref) => <int>{});

/// Asks for a background wake-up at [at], so a scheduled message goes out
/// even when Loupe isn't running. Best effort: in the foreground the
/// repository's own timer sends it anyway. Once per time and run.
///
/// Never throws: it runs after the message is queued, often after an await,
/// when the screen whose [ref] it is may be gone (`ref` throws then; the
/// Mailboxes screen asks again on the next launch).
void wakeUpAt(WidgetRef ref, DateTime at) {
  try {
    if (!ref.read(_wakeUpTimesProvider).add(at.millisecondsSinceEpoch)) return;
    unawaited(ref.read(backgroundSchedulerProvider).scheduleWakeUp(at).catchError((Object _) {}));
  } on StateError catch (e) {
    debugPrint('No wake-up asked for: ${e.runtimeType}');
  }
}

/// What the Send Later sheet chose: a time, or (with [at] null) to send
/// right away after all.
typedef SendLaterChoice = ({DateTime? at});

/// The Send Later sheet: the presets, "Pick Date & Time…" and, when a time
/// is already set ([current]), "Send Without Delay". Null when dismissed.
/// [title] is "Send Later" unless given.
Future<SendLaterChoice?> showSendLaterSheet(
  BuildContext context, {
  required DateTime now,
  DateTime? current,
  String? title,
}) => showLoupeSheet<SendLaterChoice>(
  context,
  builder: (context) => SafeArea(
    top: false,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetGroup(
            header: title ?? context.l10n.composeSendLater,
            children: [
              for (final (preset, at) in sendLaterPresets(now))
                SheetRow(
                  key: ValueKey('send-later-${preset.name}'),
                  label: preset.label(context.l10n),
                  subtitle: formatSendTimeFor(context, at, now: now),
                  icon: preset.icon,
                  trailing: at == current ? Icon(LoupeIcons.check, color: Theme.of(context).colorScheme.primary) : null,
                  onTap: () => Navigator.of(context).pop((at: at)),
                ),
              SheetRow(
                key: const ValueKey('send-later-pick'),
                label: context.l10n.composePickDateTime,
                icon: LoupeIcons.pickDateTime,
                onTap: () async {
                  final picked = await showSendTimePicker(context, now: now, initial: current);
                  if (picked != null && context.mounted) Navigator.of(context).pop((at: picked));
                },
              ),
            ],
          ),
          if (current != null)
            SheetGroup(
              children: [
                SheetRow(
                  key: const ValueKey('send-later-clear'),
                  label: context.l10n.composeSendWithoutDelay,
                  icon: LoupeIcons.sendNow,
                  onTap: () => Navigator.of(context).pop((at: null)),
                ),
              ],
            ),
        ],
      ),
    ),
  ),
);

/// Rounds [t] up to the next multiple of [minutes] past the hour.
DateTime roundUpToMinutes(DateTime t, int minutes) {
  final floor = DateTime(t.year, t.month, t.day, t.hour, t.minute - t.minute % minutes);
  return floor.isAtSameMomentAs(t) ? floor : floor.add(Duration(minutes: minutes));
}

/// A date and time wheel for "Pick Date & Time…", from a few minutes from
/// now up to a year ahead, in 5-minute steps. Null when cancelled. [title]
/// is "Send Later" unless given.
Future<DateTime?> showSendTimePicker(BuildContext context, {required DateTime now, DateTime? initial, String? title}) {
  final earliest = roundUpToMinutes(now.toLocal().add(const Duration(minutes: 1)), 5);
  var picked = initial != null && !initial.isBefore(earliest)
      ? roundUpToMinutes(initial.toLocal(), 5)
      : roundUpToMinutes(now.toLocal().add(const Duration(hours: 1)), 5);
  return showModalBottomSheet<DateTime>(
    context: context,
    useSafeArea: true,
    backgroundColor: LoupeColors.of(context).groupedBackground,
    builder: (context) {
      final styles = LoupeTextStyles.of(context);
      final l10n = context.l10n;
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                children: [
                  CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
                  Expanded(
                    child: Text(title ?? l10n.composeSendLater, style: styles.navTitle, textAlign: TextAlign.center),
                  ),
                  CupertinoButton(
                    key: const ValueKey('send-later-done'),
                    onPressed: () => Navigator.of(context).pop(picked),
                    child: Text(l10n.commonDone, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                key: const ValueKey('send-later-wheel'),
                initialDateTime: picked,
                minimumDate: earliest,
                maximumDate: earliest.add(const Duration(days: 366)),
                minuteInterval: 5,
                use24hFormat: MediaQuery.alwaysUse24HourFormatOf(context),
                onDateTimeChanged: (v) => picked = v,
              ),
            ),
          ],
        ),
      );
    },
  );
}
