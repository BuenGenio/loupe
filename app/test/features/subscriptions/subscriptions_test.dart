import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/mailing_lists/mailing_list_screen.dart';
import 'package:loupe/features/palette/command_palette.dart';
import 'package:loupe/features/subscriptions/one_click.dart';
import 'package:loupe/features/subscriptions/subscription_format.dart';
import 'package:loupe/features/subscriptions/subscription_providers.dart';
import 'package:loupe/features/subscriptions/subscription_screen.dart';
import 'package:loupe/features/subscriptions/subscriptions_screen.dart';
import 'package:loupe/router.dart';
import 'package:loupe/shared/grouped_list.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';
import '../panes/fake_app.dart' show press;
import 'one_click_test.dart' show FakeTransport;

const _deals = 'from:deals@megamart.example';
const _run = 'from:hello@striderun.example';
const _trailhead = 'from:news@trailhead.example';
const _tracker = 'from:tracker@issues.northwind.example';
const _fieldNotes = 'from:hello@fieldnotes.example';

/// The demo repository, remembering what was sent.
class RecordingRepository extends DemoMailRepository {
  RecordingRepository() : super(latency: DemoLatency.zero, clock: () => testNow);

  final sent = <OutgoingMessage>[];

  @override
  Future<String> send(OutgoingMessage message, {Duration undoDelay = const Duration(seconds: 10), DateTime? sendAt}) {
    sent.add(message);
    return super.send(message, undoDelay: undoDelay, sendAt: sendAt);
  }
}

/// The demo without its newsletters.
class _OnlyDiscussions extends DemoMailRepository {
  _OnlyDiscussions() : super(latency: DemoLatency.zero, clock: () => testNow);

  @override
  Stream<List<Subscription>> watchSubscriptions() => super.watchSubscriptions().map(
    (subs) => [
      for (final s in subs)
        if (s.isDiscussion) s,
    ],
  );
}

/// Pumps the app on Subscriptions with a fake one-click transport and
/// browser.
Future<({RecordingRepository repo, FakeTransport http, List<Uri> opened})> pumpSubscriptions(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  String? location = Routes.subscriptions,
}) async {
  final http = FakeTransport();
  final opened = <Uri>[];
  final repo = RecordingRepository();
  await pumpLoupe(
    tester,
    repository: repo,
    prefs: prefs,
    overrides: [
      oneClickUnsubscriberProvider.overrideWithValue(OneClickUnsubscriber(http)),
      webPageOpenerProvider.overrideWithValue((uri) async {
        opened.add(uri);
        return true;
      }),
    ],
  );
  if (location != null) await goTo(tester, location);
  return (repo: repo, http: http, opened: opened);
}

Finder _row(String key) => find.byKey(ValueKey(key));

Finder _inRow(String key, Finder finder) => find.descendant(of: _row(key), matching: finder);

/// Scrolls [finder] into view: from the top of the list, down.
Future<void> _show(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.fling(find.byType(Scrollable).first, const Offset(0, 3000), 3000);
    await tester.pumpAndSettle();
  }
  await tester.scrollUntilVisible(finder, 120, scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
}

Future<void> _tapDialog(WidgetTester tester, String action) async {
  await tester.tap(find.widgetWithText(CupertinoDialogAction, action));
  await tester.pumpAndSettle();
}

Subscription _sub(String key, {int recent = 9, int read = 0, int total = 9}) => Subscription(
  key: key,
  name: 'News',
  address: 'news@x.example',
  messageCount: total,
  readCount: read,
  recentCount: recent,
  recentReadCount: read,
  lastReceived: testNow.subtract(const Duration(days: 2)),
);

void main() {
  setUpAll(() => ReadableMessageView.debugSynchronous = true);
  tearDownAll(() => ReadableMessageView.debugSynchronous = false);

  group('labels', () {
    test('volume and read rate', () {
      expect(statsLine(_sub(_deals)), '≈ 3 / month · read 0%');
      expect(statsLine(_sub(_deals, recent: 2, read: 1, total: 2)), '< 1 / month · read 50%');
      expect(statsLine(_sub(_deals, recent: 0, read: 0, total: 4)), 'None lately · read 0%');
      expect(readLabel(_sub(_deals, recent: 300, read: 1, total: 300)), 'read <1%');
      expect(readLabel(_sub(_deals, recent: 300, read: 299, total: 300)), 'read 99%');
    });

    test('filters', () {
      final never = _sub(_deals);
      final rarely = _sub(_run, recent: 10, read: 2, total: 10);
      final often = _sub(_run, recent: 10, read: 8, total: 10);
      expect(SubscriptionFilter.neverRead.matches(never), isTrue);
      expect(SubscriptionFilter.neverRead.matches(rarely), isFalse);
      expect(SubscriptionFilter.rarelyRead.matches(never), isTrue);
      expect(SubscriptionFilter.rarelyRead.matches(rarely), isTrue);
      expect(SubscriptionFilter.rarelyRead.matches(often), isFalse);
      expect(SubscriptionFilter.all.matches(often), isTrue);
    });

    test('still sending a week after unsubscribing', () {
      final s = _sub(_deals);
      final recent = UnsubscribeRecord(at: testNow.subtract(const Duration(days: 6)), via: UnsubscribeVia.oneClick);
      final old = UnsubscribeRecord(at: testNow.subtract(const Duration(days: 12)), via: UnsubscribeVia.mail);
      expect(recent.stillSending(s), isFalse);
      expect(old.stillSending(s), isTrue);
      expect(unsubscribedLabel(old, s), 'Still sending');
      expect(unsubscribedLabel(recent, s, now: testNow), startsWith('Unsubscribed on '));
      expect(
        unsubscribedLabel(
          UnsubscribeRecord(at: testNow, via: UnsubscribeVia.web),
          s,
          now: testNow,
        ),
        startsWith('Unsubscribe page opened '),
      );
      expect(UnsubscribeRecord.fromJson(jsonDecode(jsonEncode(old.toJson()))), old);
      expect(UnsubscribeRecord.fromJson({'at': 'never', 'via': 'mail'}), isNull);
    });

    test('rule conditions: the sender, or the List-Id of a list with many senders', () {
      expect(subscriptionCondition(_sub(_deals)), 'from:news@x.example');
      const list = Subscription(
        key: 'list:dev.lists.example.org',
        name: 'Dev',
        address: 'ann@x.example',
        senderCount: 4,
      );
      expect(subscriptionCondition(list), 'header:List-Id=dev.lists.example.org');
      final block = blockRule(list);
      expect(block.actions, [const MarkJunkAction()]);
      expect(isBlocked(list, [block]), isTrue);
      expect(isBlocked(list, [block.copyWith(enabled: false)]), isFalse);
    });
  });

  testWidgets('Mailboxes › Subscriptions: newsletters, the mail you never read first', (tester) async {
    await pumpSubscriptions(tester, location: null);
    expect(find.text('Tools'), findsNothing);
    expect(find.text('Mailing Lists'), findsNothing);
    await tester.tap(find.text('Subscriptions'));
    await tester.pumpAndSettle();

    expect(find.byType(SubscriptionsScreen), findsOneWidget);
    final names = tester
        .widgetList<SubscriptionRow>(find.byType(SubscriptionRow))
        .map((r) => r.subscription.name)
        .toList();
    expect(names.first, 'MegaMart Deals');
    expect(_inRow(_deals, find.text('≈ 3 / month · read 0%')), findsOneWidget);
    expect(_inRow(_deals, find.text('deals@megamart.example')), findsOneWidget);
    expect(_inRow(_deals, find.text('Unsubscribe')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('filter-neverRead')));
    await tester.pumpAndSettle();
    expect(_row(_deals), findsOneWidget);
    expect(_row(_trailhead), findsOneWidget);
    expect(_row(_run), findsNothing);

    // The test font is wider than a phone's: the chip row scrolls.
    await tester.ensureVisible(find.byKey(const ValueKey('filter-all')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('filter-all')));
    await tester.pumpAndSettle();
    // Lists people write to are Discussions, not newsletters.
    expect(find.text('Kestrel developers'), findsNothing);
    await _show(tester, textContaining('Counted on this phone'));
    expect(textContaining('no cookies'), findsOneWidget);
  });

  testWidgets('one-click: explained the first time, one POST, then the date', (tester) async {
    final t = await pumpSubscriptions(tester);
    await _show(tester, _row(_run));
    await tester.tap(_inRow(_run, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    expect(find.text('Unsubscribe from Stride Run Club?'), findsOneWidget);
    expect(textContaining('Loupe will contact striderun.example to unsubscribe.'), findsOneWidget);
    expect(textContaining('the only time Loupe contacts a sender’s website'), findsOneWidget);

    await _tapDialog(tester, 'Cancel');
    expect(t.http.requests, isEmpty);

    await tester.tap(_inRow(_run, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    await _tapDialog(tester, 'Unsubscribe');
    expect(t.http.requests.single.uri, Uri.parse('https://striderun.example/unsubscribe?u=sam'));
    expect(utf8.decode(t.http.requests.single.bodyBytes), 'List-Unsubscribe=One-Click');
    expect(find.text('Unsubscribed from Stride Run Club.'), findsOneWidget);
    expect(_inRow(_run, textContaining('Unsubscribed on')), findsOneWidget);
    expect(_inRow(_run, find.text('Unsubscribe')), findsNothing);

    // Explained once: the next one only names the host.
    await _show(tester, _row(_trailhead));
    await tester.tap(_inRow(_trailhead, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    expect(textContaining('Loupe will contact trailhead.example to unsubscribe.'), findsOneWidget);
    expect(textContaining('the only time'), findsNothing);
    await _tapDialog(tester, 'Cancel');
    await drainTimers(tester);
  });

  testWidgets('a failed one-click offers mail; mailto unsubscribes through the outbox', (tester) async {
    final t = await pumpSubscriptions(tester, prefs: {OneClickExplained.key: true});
    t.http.answer = (_) => const OneClickResponse(500);
    await _show(tester, _row(_trailhead));
    await tester.tap(_inRow(_trailhead, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    await _tapDialog(tester, 'Unsubscribe');
    expect(find.text('Couldn’t Unsubscribe Automatically'), findsOneWidget);
    expect(find.text('trailhead.example refused the request (error 500).'), findsOneWidget);
    expect(find.text('Open trailhead.example'), findsOneWidget);
    await tester.tap(find.text('Send Unsubscribe Email'));
    await tester.pumpAndSettle();
    expect(
      textContaining('send an email to unsubscribe@trailhead.example from sam.rivera@gmail.example'),
      findsOneWidget,
    );
    await _tapDialog(tester, 'Send');
    final first = t.repo.sent.single;
    expect(first.accountId, DemoAccounts.personal);
    expect(first.to.single.email, 'unsubscribe@trailhead.example');
    expect(first.subject, 'unsubscribe');
    expect(_inRow(_trailhead, textContaining('Unsubscribed on')), findsOneWidget);

    // mailto with a subject in the URI.
    await _show(tester, _row(_deals));
    await tester.tap(_inRow(_deals, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    expect(textContaining('with the subject “Unsubscribe daily deals”'), findsOneWidget);
    await _tapDialog(tester, 'Send');
    expect(t.repo.sent.last.to.single.email, 'unsubscribe@megamart.example');
    expect(t.repo.sent.last.subject, 'Unsubscribe daily deals');
    expect(t.http.requests, hasLength(1));
    await drainTimers(tester);
    expect(await t.repo.watchOutbox().first, isEmpty, reason: 'sent');
  });

  testWidgets('a web page: the host first, then the in-app browser', (tester) async {
    final t = await pumpSubscriptions(tester);
    await _show(tester, _row(_tracker));
    await tester.tap(_inRow(_tracker, find.text('Unsubscribe')));
    await tester.pumpAndSettle();
    expect(find.text('Open tracker.northwind.example?'), findsOneWidget);
    expect(t.opened, isEmpty);
    await _tapDialog(tester, 'Open');
    expect(t.opened.single, Uri.parse('https://tracker.northwind.example/settings/notifications'));
    expect(t.http.requests, isEmpty);
    expect(_inRow(_tracker, textContaining('Unsubscribe page opened')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('still sending a week later: flagged, with Block', (tester) async {
    String record(int daysAgo, String via) =>
        '"${daysAgo == 20 ? _deals : _fieldNotes}": {"at": "${testNow.subtract(Duration(days: daysAgo)).toUtc().toIso8601String()}", "via": "$via"}';
    await pumpSubscriptions(
      tester,
      prefs: {UnsubscribeRecords.key: '{${record(20, 'mail')}, ${record(1, 'oneClick')}}'},
    );
    expect(_inRow(_deals, find.text('Still sending')), findsOneWidget);
    expect(_inRow(_deals, find.text('Block')), findsOneWidget);
    await _show(tester, _row(_fieldNotes));
    expect(_inRow(_fieldNotes, textContaining('Unsubscribed on')), findsOneWidget);
    expect(_inRow(_fieldNotes, find.text('Unsubscribe')), findsNothing);
    expect(_inRow(_fieldNotes, find.text('Block')), findsNothing);
  });

  testWidgets('a subscription: its latest messages; Archive All with Undo', (tester) async {
    final t = await pumpSubscriptions(tester, location: Routes.subscription(_run));
    expect(find.text('Stride Run Club'), findsWidgets);
    expect(find.text('LATEST MESSAGES'), findsOneWidget);
    expect(find.text('One tap · contacts striderun.example'), findsOneWidget);
    final inbox = await t.repo.watchSubscriptionEmails(_run, inboxOnly: true).first;
    expect(inbox, hasLength(5));

    await tester.tap(find.text('Archive 5 in Inbox'));
    await tester.pumpAndSettle();
    expect(find.text('Archived 5 messages'), findsOneWidget);
    expect(await t.repo.watchSubscriptionEmails(_run, inboxOnly: true).first, isEmpty);
    expect(find.text('Archive 5 in Inbox'), findsNothing);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect((await t.repo.watchSubscriptionEmails(_run, inboxOnly: true).first).map((e) => e.id).toSet(), {
      for (final e in inbox) e.id,
    });
    await drainTimers(tester);
  });

  testWidgets('Block Sender adds a Junk rule; Create Rule opens the editor filled in', (tester) async {
    final t = await pumpSubscriptions(tester, location: Routes.subscription(_deals));
    await tester.tap(find.text('Block Sender'));
    await tester.pumpAndSettle();
    expect(find.text('Block MegaMart Deals?'), findsOneWidget);
    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    final rule = (await t.repo.rules.watchRules().first).last;
    expect(rule.name, 'Block MegaMart Deals');
    expect(rule.condition, 'from:deals@megamart.example');
    expect(rule.actions, [const MarkJunkAction()]);
    expect(find.text('Blocked'), findsOneWidget);
    expect(find.text('Block Sender'), findsNothing);
    await drainTimers(tester);

    await tester.tap(find.text('Create Rule…'));
    await tester.pumpAndSettle();
    expect(find.text('from:deals@megamart.example'), findsOneWidget);
    expect(find.text('MegaMart Deals'), findsWidgets);
    expect(find.text('Move to All Mail'), findsOneWidget);
  });

  group('newsletters and discussions', () {
    const kestrel = 'list:dev.lists.example.org';
    const garden = 'list:open-garden.lists.opengarden.example';
    const nordlicht = 'from:news@nordlicht.example';
    const tidepool = 'from:hello@tidepool.example';

    Future<void> tab(WidgetTester tester, String label) async {
      // Back at the top, where the tabs are.
      await tester.fling(find.byType(Scrollable).first, const Offset(0, 3000), 3000);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(of: find.byKey(const ValueKey('subscriptions-tabs')), matching: find.text(label)),
      );
      await tester.pumpAndSettle();
    }

    /// Back, as Android's back gesture goes.
    Future<void> back(WidgetTester tester) async {
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
    }

    Future<void> menu(WidgetTester tester, String key, String action) async {
      await _show(tester, _row(key));
      await tester.longPress(_row(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text(action));
      await tester.pumpAndSettle();
    }

    test('rule conditions of newsletters grouped by name and domain', () {
      const brand = Subscription(
        key: 'sender:northline.example/northline rail',
        name: 'Northline Rail',
        address: '0d93f1e2a7c4b85e6f10@news.northline.example',
      );
      expect(subscriptionCondition(brand), 'from:"northline rail" from:northline.example');
      expect(senderLine(brand), 'northline.example');
      // A block rule made for one of its lists before still counts.
      const merged = Subscription(
        key: nordlicht,
        name: 'Nordlicht Books',
        address: 'news@nordlicht.example',
        sourceKeys: ['list:a.sendsay', 'list:b.sendsay'],
      );
      final old = Rule(
        id: 'r',
        name: 'Block',
        condition: 'header:List-Id=b.sendsay',
        actions: const [MarkJunkAction()],
      );
      expect(isBlocked(merged, [old]), isTrue);
    });

    testWidgets('one row on Mailboxes: unread discussion mail, else no count', (tester) async {
      final repo = await pumpLoupe(tester);
      final discussions = [
        for (final s in await repo.watchSubscriptions().first)
          if (s.isDiscussion) s,
      ];
      final unread = discussions.fold(0, (n, s) => n + s.unreadCount);
      expect(unread, greaterThan(0));
      final row = find.byKey(const ValueKey('subscriptions'));
      expect(find.descendant(of: row, matching: find.text('$unread')), findsOneWidget);
      // In the top group, after the unified mailboxes.
      expect(tester.getTopLeft(row).dy, greaterThan(tester.getTopLeft(find.text('Unread')).dy));
      expect(tester.getTopLeft(row).dy, lessThan(tester.getTopLeft(find.text('Personal')).dy));
      // No list of lists until one is pinned.
      await tester.scrollTo(find.text('Smart Mailboxes'));
      expect(find.byWidgetPredicate((w) => w is InsetGroup && w.header == 'Lists'), findsNothing);
      expect(find.text('Kestrel developers'), findsNothing);
      await tester.fling(find.byType(Scrollable).first, const Offset(0, 5000), 5000);
      await tester.pumpAndSettle();

      final ids = [
        for (final s in discussions)
          for (final e in await repo.watchSubscriptionEmails(s.key).first)
            if (!e.isSeen) e.id,
      ];
      await repo.setKeywords(ids, add: {Keywords.seen});
      await tester.pumpAndSettle();
      expect(find.descendant(of: row, matching: find.text('$unread')), findsNothing);
      expect(find.descendant(of: row, matching: find.text('0')), findsNothing);
    });

    testWidgets('tabs: Newsletters at first, then the last one chosen', (tester) async {
      await pumpSubscriptions(tester);
      expect(find.byType(SubscriptionRow), findsWidgets);
      expect(find.byType(DiscussionRow), findsNothing);
      await tab(tester, 'Discussions');
      expect(find.byType(SubscriptionRow), findsNothing);
      final rows = tester.widgetList<DiscussionRow>(find.byType(DiscussionRow)).map((r) => r.subscription.name);
      expect(rows, ['Kestrel developers', 'Open Garden development']);
      expect(_inRow(kestrel, find.text('dev@lists.example.org')), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(SubscriptionsTab.key), 'discussion');

      // Next time it opens on Discussions.
      Navigator.of(tester.element(find.byType(SubscriptionsScreen))).pop();
      await tester.pumpAndSettle();
      await goTo(tester, Routes.subscriptions);
      expect(find.byType(DiscussionRow), findsNWidgets(2));
      await goTo(tester, Routes.subscriptionsTab(SubscriptionKind.newsletter));
      expect(find.byType(DiscussionRow), findsNothing);
    });

    testWidgets('Discussions when there are no newsletters', (tester) async {
      await pumpLoupe(tester, repository: _OnlyDiscussions());
      await goTo(tester, Routes.subscriptions);
      expect(find.byType(DiscussionRow), findsNWidgets(2));
    });

    testWidgets('the filter field narrows by name', (tester) async {
      await pumpSubscriptions(tester);
      await tester.enterText(find.byType(CupertinoSearchTextField), 'nord');
      await tester.pumpAndSettle();
      expect(find.byType(SubscriptionRow), findsOneWidget);
      expect(_row(nordlicht), findsOneWidget);
      await tab(tester, 'Discussions');
      expect(find.text('No Matches'), findsOneWidget);
      await tester.enterText(find.byType(CupertinoSearchTextField), 'garden');
      await tester.pumpAndSettle();
      expect(find.byType(DiscussionRow), findsOneWidget);
      expect(_row(garden), findsOneWidget);
    });

    testWidgets('a discussion: forum view, pin, plain text, unsubscribe, Treat as Newsletter', (tester) async {
      final t = await pumpSubscriptions(tester, location: Routes.subscriptionsTab(SubscriptionKind.discussion));
      await tester.tap(_row(kestrel));
      await tester.pumpAndSettle();
      expect(find.byType(MailingListScreen), findsOneWidget);
      expect(find.text('Cache parsed headers on keep-alive connections'), findsOneWidget);
      await back(tester);

      await menu(tester, kestrel, 'Pin to Mailboxes');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('subscriptions.pinnedLists'), ['dev.lists.example.org']);
      expect(_inRow(kestrel, find.byIcon(LoupeIcons.pinFilled)), findsOneWidget);

      await menu(tester, kestrel, 'Open as Plain Text (Mono)');
      expect(prefs.getStringList('reader.technicalLists'), ['dev.lists.example.org']);

      await menu(tester, kestrel, 'Unsubscribe');
      expect(textContaining('send an email to dev-leave@lists.example.org from sam@rivera.example'), findsOneWidget);
      await _tapDialog(tester, 'Send');
      expect(t.repo.sent.single.to.single.email, 'dev-leave@lists.example.org');
      expect(UnsubscribeRecords.key, isNotEmpty);
      expect(prefs.getString(UnsubscribeRecords.key), contains(kestrel));

      await menu(tester, kestrel, 'Treat as Newsletter');
      expect(_row(kestrel), findsNothing);
      expect(find.text('Kestrel developers is in Newsletters now.'), findsOneWidget);
      await tab(tester, 'Newsletters');
      await _show(tester, _row(kestrel));
      expect(
        _inRow(kestrel, find.text('dev.lists.example.org')),
        findsOneWidget,
        reason: 'several senders: the List-Id',
      );
      await drainTimers(tester);
    });

    testWidgets('Treat as Discussion, and Undo', (tester) async {
      final t = await pumpSubscriptions(tester);
      await menu(tester, tidepool, 'Treat as Discussion');
      expect(_row(tidepool), findsNothing);
      await tab(tester, 'Discussions');
      expect(find.text('Tidepool'), findsOneWidget);
      expect(
        (await t.repo.watchSubscriptions().first).firstWhere((s) => s.name == 'Tidepool').kind,
        SubscriptionKind.discussion,
      );
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(find.text('Tidepool'), findsNothing);
      await drainTimers(tester);
    });

    testWidgets('a pinned list on Mailboxes: its threads, its unread count; unpinned in Edit', (tester) async {
      final repo = await pumpLoupe(
        tester,
        prefs: {
          'subscriptions.pinnedLists': ['dev.lists.example.org'],
        },
      );
      final kestrelSub = (await repo.watchSubscriptions().first).firstWhere((s) => s.key == kestrel);
      final row = find.byKey(const ValueKey('list.dev.lists.example.org'));
      await tester.scrollTo(row);
      expect(find.descendant(of: row, matching: find.text('Kestrel developers')), findsOneWidget);
      expect(find.descendant(of: row, matching: find.text('${kestrelSub.unreadCount}')), findsOneWidget);
      expect(find.text('Open Garden development'), findsNothing);
      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(find.byType(MailingListScreen), findsOneWidget);
      await back(tester);

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      final unpin = find.descendant(of: row, matching: find.byIcon(LoupeIcons.remove));
      await tester.scrollTo(unpin);
      await tester.tap(unpin);
      await tester.pumpAndSettle();
      expect(row, findsNothing);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('subscriptions.pinnedLists'), isEmpty);
    });

    testWidgets('the command palette: Subscriptions, and the discussion lists', (tester) async {
      await pumpLoupe(tester);
      Future<void> run(String text) async {
        await press(tester, LogicalKeyboardKey.keyK, ctrl: true);
        await tester.enterText(find.byKey(const Key('palette-field')), text);
        await tester.pumpAndSettle();
        await press(tester, LogicalKeyboardKey.enter);
      }

      await run('kestrel developers');
      expect(tester.widget<MailingListScreen>(find.byType(MailingListScreen)).listId, 'dev.lists.example.org');
      await run('subscriptions');
      expect(find.byType(SubscriptionsScreen), findsOneWidget);
      // Newsletters aren't mailing lists any more.
      await press(tester, LogicalKeyboardKey.keyK, ctrl: true);
      await tester.enterText(find.byKey(const Key('palette-field')), 'nordlicht');
      await tester.pumpAndSettle();
      expect(find.descendant(of: find.byType(CommandPalette), matching: find.text('Mailing List')), findsNothing);
    });

    testWidgets('old links: a list now in a newsletter, a discussion, the lists', (tester) async {
      await pumpSubscriptions(tester, location: Routes.subscription('list:5186308-24050-41.nordlicht.sendsay'));
      expect(tester.widget<SubscriptionScreen>(find.byType(SubscriptionScreen)).subscriptionKey, nordlicht);
      expect(find.text('Nordlicht Books'), findsWidgets);
      await goTo(tester, Routes.subscription(kestrel));
      expect(find.byType(SubscriptionScreen), findsNothing);
      expect(tester.widget<MailingListScreen>(find.byType(MailingListScreen)).listId, 'dev.lists.example.org');
      await goTo(tester, Routes.mailingLists);
      expect(find.byType(DiscussionRow), findsNWidgets(2));
    });

    testWidgets('unsubscribed before mail was grouped by sender: the record moves to the newsletter', (tester) async {
      const old = 'list:5186308-24050-40.nordlicht.sendsay';
      final at = testNow.subtract(const Duration(days: 1)).toUtc().toIso8601String();
      await pumpSubscriptions(tester, prefs: {UnsubscribeRecords.key: '{"$old": {"at": "$at", "via": "oneClick"}}'});
      await _show(tester, _row(nordlicht));
      expect(_inRow(nordlicht, textContaining('Unsubscribed on')), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      final saved = jsonDecode(prefs.getString(UnsubscribeRecords.key)!) as Map;
      expect(saved.keys, [nordlicht]);
    });
  });
}
