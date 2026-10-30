// The Brief's Track, wired to Needs My Action: an item becomes a durable
// action, once, saying which provider found it.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/features/conversation/message_card.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

void main() {
  final offsite = DemoSeed.build(testNow).messages.firstWhere((m) => m.summary.subject == 'Team offsite — logistics');

  Finder inCard(Finder finder) => find.descendant(
    of: find.byWidgetPredicate((w) => w is MessageCard && w.message.id == offsite.id),
    matching: finder,
  );

  Future<void> track(WidgetTester tester, String words) async {
    final tile = find
        .ancestor(
          of: find.textContaining(words),
          matching: find.byWidgetPredicate((w) => '${w.key}'.contains('brief-item-')),
        )
        .first;
    final index = RegExp(r'brief-item-(\d+)').firstMatch('${tester.widget(tile).key}')!.group(1);
    await tester.tap(find.byKey(ValueKey('brief-more-$index')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Track'));
    await tester.pumpAndSettle();
  }

  testWidgets('Track keeps a Brief item in Needs My Action, once, with the provider that found it', (tester) async {
    final repo = await pumpLoupe(tester, prefs: {'settings.aiAssist': true}, size: const Size(390, 2400));
    final before = await repo.watchActions().first;
    expect(before.where((a) => a.source.emailId == offsite.id), isEmpty);

    await goTo(tester, '/message/${Uri.encodeComponent(offsite.id)}');
    await tester.tap(inCard(find.byKey(const Key('brief-button'))));
    await tester.pumpAndSettle();
    await track(tester, 'dietary form');
    expect(find.textContaining('Tracking'), findsOneWidget);

    final after = await repo.watchActions().first;
    expect(after, hasLength(before.length + 1));
    final tracked = after.singleWhere((a) => a.source.emailId == offsite.id);
    expect(tracked.owner, ActionOwner.me);
    expect(tracked.folder, VirtualMailbox.needsMyAction);
    expect(tracked.origin.providerId, 'demo');

    await tester.pump(const Duration(seconds: 5));
    await track(tester, 'dietary form');
    expect(await repo.watchActions().first, hasLength(before.length + 1));
  });
}
