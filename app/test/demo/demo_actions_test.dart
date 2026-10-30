import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_actions.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);

  test('every seeded action quotes its message exactly', () {
    final seed = DemoSeed.build(now);
    final actions = seed.seedActions();
    expect(actions, hasLength(11));
    for (final a in actions) {
      final m = seed.messages.singleWhere((m) => m.id == a.source.emailId);
      expect(BriefInput.normaliseWhitespace(m.text!), contains(a.quote), reason: a.currentRequest);
      expect(a.quote, isNot(contains(DemoPrivateAi.password)));
      expect(a.origin.providerId, 'demo');
    }
    final mine = actions.where((a) => a.owner == ActionOwner.me).map((a) => a.currentRequest).join(' | ');
    expect(mine, contains('2024/25'));
    expect(mine, contains('2025'));
    final id = actions.singleWhere((a) => a.quote.contains('ID check'));
    expect(id.channel, 'in the Harbour app');
    expect(id.state, ActionState.needsAction);
  });

  test('the storyline as tracked: sent, acknowledged, in progress, promised, with dates', () {
    final actions = DemoSeed.build(now).seedActions();
    ActionRecord about(String words) => actions.singleWhere((a) => a.quote.contains(words));

    final statement = about('bank statement');
    expect(statement.state, ActionState.acknowledged);
    expect(statement.history.map((e) => e.state).nonNulls, [
      ActionState.needsAction,
      ActionState.sent,
      ActionState.acknowledged,
    ]);
    expect(about('SA302').state, ActionState.acknowledged);
    expect(about('affordability form').state, ActionState.inProgress);

    final promise = about('valuation booking');
    expect((promise.owner, promise.kind, promise.folder), (
      ActionOwner.them,
      ActionKind.promise,
      VirtualMailbox.waitingOnOthers,
    ));
    expect(promise.due.kind, ActionDueKind.conditional);

    final confirm = about('Please confirm by');
    expect(confirm.due.kind, ActionDueKind.explicit);
    expect(confirm.due.date, DateTime(now.year, now.month, now.day + 6));
    final deposit = about('Amount due');
    expect(deposit.due.date, DateTime(now.year, now.month, now.day + 21));
  });

  test('the folders and their counts come from the records; one conversation is in both', () async {
    final repo = DemoMailRepository.instant(clock: () => now);
    addTearDown(repo.dispose);
    final counts = await repo.watchVirtualCounts().first;
    expect(counts[VirtualMailbox.needsMyAction], 3);
    expect(counts[VirtualMailbox.waitingOnOthers], 1);
    Future<List<String>> folder(VirtualMailbox kind) async => [
      for (final t in await repo.watchList(VirtualMailboxRef(kind)).first) t.threadId,
    ];
    final mortgage = DemoPrivateAi.threadId(DemoPrivateAi.mortgageThread);
    expect(await folder(VirtualMailbox.needsMyAction), [
      DemoPrivateAi.threadId(DemoPrivateAi.removalsThread),
      mortgage,
      DemoPrivateAi.threadId(DemoPrivateAi.solicitorThread),
    ]);
    expect(await folder(VirtualMailbox.waitingOnOthers), [mortgage]);

    // Settling the promise empties Waiting on Others; deleting is kept apart.
    final promise = (await repo.watchActions().first).singleWhere((a) => a.owner == ActionOwner.them);
    await repo.saveActions([promise.withState(ActionState.done, now)]);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.waitingOnOthers], 0);
    expect(await folder(VirtualMailbox.waitingOnOthers), isEmpty);

    // Trash takes a conversation out of the folders; its actions stay.
    final removals = (await repo.watchList(VirtualMailboxRef(VirtualMailbox.needsMyAction)).first).first;
    await repo.trash([removals.latest.id]);
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.needsMyAction], 2);
    expect(await repo.watchActions().first, hasLength(11));
  });
}
