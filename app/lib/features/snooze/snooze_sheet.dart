import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../compose/send_later.dart';
import '../conversation/sheets.dart';

/// The quick choices of "Snooze".
enum SnoozePreset {
  laterToday(LoupeIcons.snoozeLaterToday),
  thisEvening(LoupeIcons.snoozeEvening),
  tomorrow(LoupeIcons.snoozeTomorrow),
  thisWeekend(LoupeIcons.snoozeWeekend),
  nextWeek(LoupeIcons.snoozeNextWeek);

  const SnoozePreset(this.icon);

  final IconData icon;

  String label(AppLocalizations l10n) => switch (this) {
    laterToday => l10n.snoozeLaterToday,
    thisEvening => l10n.snoozeThisEvening,
    tomorrow => l10n.snoozeTomorrow,
    thisWeekend => l10n.snoozeThisWeekend,
    nextWeek => l10n.snoozeNextWeek,
  };
}

/// When "This Evening" is: 18:00, offered until an hour before.
const snoozeEveningHour = 18;

/// Mornings ("Tomorrow", "Next Week") start at 08:00, weekends at 09:00.
const snoozeMorningHour = 8;
const snoozeWeekendHour = 9;

/// The presets on offer at [now], with the times they wake at:
///
/// - Later Today: three hours from now, rounded up to the half hour; only
///   if that is still today, and before This Evening while that is offered.
/// - This Evening: 18:00, before 17:00.
/// - Tomorrow: 08:00 tomorrow.
/// - This Weekend: Saturday 09:00, Monday to Friday.
/// - Next Week: Monday 08:00; left out on Sundays, when it is tomorrow.
///
/// Times are wall-clock times in the device's time zone ([now] is converted
/// to local time first), so they stay at 08:00 across daylight-saving changes.
List<(SnoozePreset, DateTime)> snoozePresets(DateTime now) {
  final n = now.toLocal();
  DateTime at(int days, int hour) => DateTime(n.year, n.month, n.day + days, hour);
  final evening = at(0, snoozeEveningHour);
  final showEvening = n.hour < snoozeEveningHour - 1;
  final later = roundUpToMinutes(n.add(const Duration(hours: 3)), 30);
  final laterIsToday = later.year == n.year && later.month == n.month && later.day == n.day;
  final tomorrow = at(1, snoozeMorningHour);
  final toMonday = (DateTime.monday - n.weekday) % 7;
  final monday = at(toMonday == 0 ? 7 : toMonday, snoozeMorningHour);
  return [
    if (laterIsToday && (!showEvening || later.isBefore(evening))) (SnoozePreset.laterToday, later),
    if (showEvening) (SnoozePreset.thisEvening, evening),
    (SnoozePreset.tomorrow, tomorrow),
    if (n.weekday <= DateTime.friday) (SnoozePreset.thisWeekend, at(DateTime.saturday - n.weekday, snoozeWeekendHour)),
    if (toMonday != 1) (SnoozePreset.nextWeek, monday),
  ];
}

/// The Snooze sheet: the presets and "Pick Date & Time…". [current] (a
/// snoozed message's time) gets a check mark and starts the wheel. [title] is
/// "Snooze" unless given. Resolves to the chosen time, or null when dismissed.
Future<DateTime?> showSnoozeSheet(BuildContext context, {required DateTime now, DateTime? current, String? title}) =>
    showLoupeSheet<DateTime>(
      context,
      builder: (context) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: SheetGroup(
            header: title ?? context.l10n.snoozeSheetTitle,
            children: [
              for (final (preset, at) in snoozePresets(now))
                SheetRow(
                  key: ValueKey('snooze-${preset.name}'),
                  label: preset.label(context.l10n),
                  subtitle: formatSendTimeFor(context, at, now: now),
                  icon: preset.icon,
                  trailing: current != null && at.isAtSameMomentAs(current)
                      ? Icon(LoupeIcons.check, color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () => Navigator.of(context).pop(at),
                ),
              SheetRow(
                key: const ValueKey('snooze-pick'),
                label: context.l10n.snoozePickDateTime,
                icon: LoupeIcons.pickDateTime,
                onTap: () async {
                  final picked = await showSendTimePicker(
                    context,
                    now: now,
                    initial: current?.toLocal(),
                    title: title ?? context.l10n.snoozeSheetTitle,
                  );
                  if (picked != null && context.mounted) Navigator.of(context).pop(picked);
                },
              ),
            ],
          ),
        ),
      ),
    );
