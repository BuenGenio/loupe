import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../conversation/sheets.dart' show showSnack;
import 'action_providers.dart';

/// Saves [after] in place of [before] and says [label] in a snack bar whose
/// Undo puts [before] back, history and all. Errors are shown instead.
/// Returns whether it was saved.
Future<bool> changeAction(
  BuildContext context,
  WidgetRef ref,
  ActionRecord before,
  ActionRecord after,
  String label,
) async {
  if (identical(before, after)) return false;
  final tracker = ref.read(actionTrackerProvider);
  final messenger = ScaffoldMessenger.maybeOf(context);
  final l10n = context.l10n;
  unawaited(HapticFeedback.lightImpact());
  if (!await _run(messenger, l10n, () => tracker.save([after]))) return false;
  if (messenger != null) {
    showSnack(
      messenger,
      label,
      action: SnackBarAction(
        label: l10n.commonUndo,
        onPressed: () => unawaited(_run(messenger, l10n, () => tracker.save([before]))),
      ),
    );
  }
  return true;
}

/// Saves the new [records] and says so, with Undo that forgets them again
/// (a suggestion undone this way is offered again). Returns whether they
/// were saved.
Future<bool> addActions(BuildContext context, WidgetRef ref, List<ActionRecord> records) async {
  if (records.isEmpty) return false;
  final tracker = ref.read(actionTrackerProvider);
  final messenger = ScaffoldMessenger.maybeOf(context);
  final l10n = context.l10n;
  unawaited(HapticFeedback.lightImpact());
  if (!await _run(messenger, l10n, () => tracker.save(records))) return false;
  if (messenger != null) {
    showSnack(
      messenger,
      l10n.actionsAdded(records.length),
      action: SnackBarAction(
        label: l10n.commonUndo,
        onPressed: () => unawaited(_run(messenger, l10n, () => tracker.forget([for (final r in records) r.id]))),
      ),
    );
  }
  return true;
}

Future<bool> _run(ScaffoldMessengerState? messenger, AppLocalizations l10n, Future<void> Function() action) async {
  try {
    await action();
    return true;
  } on MailException catch (e) {
    if (messenger != null) showSnack(messenger, e.message);
  } on Exception {
    if (messenger != null) showSnack(messenger, l10n.actionsSaveFailed);
  }
  return false;
}
