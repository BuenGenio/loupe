import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

/// Keeps a Brief item as a durable action: its own completion, reminder and
/// place in Needs My Action, across restarts and moves of the message. The
/// Brief only proposes; tracking is the reader's choice, item by item.
abstract interface class BriefItemTracker {
  /// Whether [item] can become an action (the Brief offers Track only for
  /// items the reader owns).
  bool canTrack(BriefItem item);

  /// Starts tracking [item] of the message [source]. Throws when it can't;
  /// the Brief says so.
  Future<void> track(MessageRef source, BriefItem item);
}

/// The tracker for Brief items, or null while there is none: then the Brief
/// offers no Track, and its ticks last for the session.
final briefItemTrackerProvider = Provider<BriefItemTracker?>((ref) => null);
