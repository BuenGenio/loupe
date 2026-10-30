import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../actions/action_providers.dart';
import '../actions/brief_actions.dart';

/// Keeps a Brief item as a durable action: its own completion, reminder and
/// place in Needs My Action, across restarts and moves of the message. The
/// Brief only proposes; tracking is the reader's choice, item by item.
abstract interface class BriefItemTracker {
  /// Whether [item] can become an action (the Brief offers Track only for
  /// items the reader owns).
  bool canTrack(BriefItem item);

  /// Starts tracking [item] of the message [source]; [run] is the Brief's,
  /// so the action says which provider and model found it. Throws when it
  /// can't; the Brief says so.
  Future<void> track(MessageRef source, BriefItem item, {AiRunRecord? run});
}

/// The tracker for Brief items: Needs My Action and Waiting on Others, when
/// the repository keeps actions; else null, and the Brief offers no Track.
final briefItemTrackerProvider = Provider<BriefItemTracker?>((ref) {
  if (actionRecordsOf(ref.watch(repositoryProvider)) == null) return null;
  return _ActionTracking(ref.watch(actionTrackerProvider));
});

/// Tracks Brief items as Suggest Actions does ([ActionTracker.trackBriefItem]):
/// the passage's existing action if there is one, else a new one.
final class _ActionTracking implements BriefItemTracker {
  const _ActionTracking(this.actions);

  final ActionTracker actions;

  // The Brief isn't offered on the user's own mail, so its items are read as
  // someone else's asking.
  @override
  bool canTrack(BriefItem item) => suggestionFromBriefItem(item, fromMe: false) != null;

  @override
  Future<void> track(MessageRef source, BriefItem item, {AiRunRecord? run}) async {
    if (await actions.trackBriefItem(source, item, run: run) == null) throw StateError('not tracked');
  }
}
