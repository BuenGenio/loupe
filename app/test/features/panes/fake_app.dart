import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:mail_model/mail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../conversation/fake_mail_repository.dart';

/// A [FakeMailRepository] whose lists show its messages, newest first, so
/// the whole app can run on it and the calls it gets can be checked.
class ListingRepository extends FakeMailRepository {
  ListingRepository({super.emails, super.mailboxes});

  @override
  Stream<List<ThreadSummary>> watchList(
    MailboxRef ref, {
    Set<QuickFilter> filters = const {},
    bool threaded = true,
    int limit = 200,
  }) =>
      // watchSnoozed emits now and after every change.
      watchSnoozed().map((_) => threadsOf(ref, filters: filters, threaded: threaded));

  List<ThreadSummary> threadsOf(MailboxRef ref, {Set<QuickFilter> filters = const {}, bool threaded = true}) {
    final roles = {for (final m in mailboxes) m.id: m.role};
    bool inScope(EmailSummary e) => switch (ref) {
      RealMailboxRef(:final mailboxId) => e.mailboxId == mailboxId,
      VirtualMailboxRef(kind: VirtualMailbox.allInboxes) => roles[e.mailboxId] == MailboxRole.inbox,
      VirtualMailboxRef(kind: VirtualMailbox.flagged) => e.isFlagged,
      VirtualMailboxRef() => true,
    };
    final shown = [
      for (final e in emails)
        if (inScope(e) && (!filters.contains(QuickFilter.unread) || !e.isSeen)) e,
    ]..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
    final threads = <String, List<EmailSummary>>{};
    for (final e in shown) {
      threads.putIfAbsent(threaded ? (e.threadId ?? e.id) : e.id, () => []).add(e);
    }
    return [
      for (final MapEntry(key: id, value: messages) in threads.entries)
        ThreadSummary(
          threadId: id,
          latest: messages.first,
          messageCount: messages.length,
          unreadCount: messages.where((m) => !m.isSeen).length,
        ),
    ];
  }
}

/// Three conversations in the test inbox, newest first: Lunch plans,
/// Quarterly report, Garden party.
ListingRepository threeConversations() => ListingRepository(
  emails: [
    testEmail('m1', thread: 't1', subject: 'Lunch plans', minutesAgo: 1),
    testEmail('m2', thread: 't2', subject: 'Quarterly report', minutesAgo: 2, from: bob, cc: [alice]),
    testEmail('m3', thread: 't3', subject: 'Garden party', minutesAgo: 3, keywords: {Keywords.seen}),
  ],
);

/// Pumps the whole app on [repository] at [size].
Future<void> pumpAppOn(WidgetTester tester, MailRepository repository, {required Size size}) async {
  tester.view
    ..physicalSize = size * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({AppModeController.key: AppMode.demo.name});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs), repositoryProvider.overrideWithValue(repository)],
      child: const LoupeApp(),
    ),
  );
  await tester.pumpAndSettle();
}

/// Presses [key] with Ctrl and/or Shift held.
Future<void> press(WidgetTester tester, LogicalKeyboardKey key, {bool ctrl = false, bool shift = false}) async {
  if (ctrl) await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
  if (shift) await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
  await tester.sendKeyEvent(key);
  if (shift) await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
  if (ctrl) await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
  await tester.pumpAndSettle();
}
