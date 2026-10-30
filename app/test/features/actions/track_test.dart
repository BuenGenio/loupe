import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/actions/action_providers.dart';
import 'package:loupe/providers.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);
  late DemoMailRepository repo;
  late ProviderContainer container;
  late ActionTracker tracker;

  setUp(() {
    repo = DemoMailRepository.instant(clock: () => now);
    container = ProviderContainer(overrides: [repositoryProvider.overrideWithValue(repo)]);
    tracker = container.read(actionTrackerProvider);
  });
  tearDown(() {
    container.dispose();
    repo.dispose();
  });

  BriefItem item(String quote, {BriefItemKind kind = BriefItemKind.action, BriefOwner owner = BriefOwner.me}) =>
      BriefItem(
        kind: kind,
        text: quote.replaceAll('.', ''),
        evidence: BriefEvidence(quote: quote, start: 0, end: quote.length),
        due: BriefDue.none,
        owner: owner,
      );

  Future<EmailSummary> message(String key, bool Function(EmailSummary) test) async {
    final rows = await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes)).first;
    final any = rows.firstWhere((r) => r.threadId == DemoPrivateAi.threadId(key)).latest;
    return (await repo.watchConversation(any.id).first).firstWhere(test);
  }

  final run = AiRunRecord(
    taskType: 'brief.message',
    taskVersion: 1,
    providerId: 'cloud',
    model: 'm1',
    inputHash: 'h',
    startedAt: now,
    finishedAt: now,
    attempts: 1,
  );

  test('trackBriefItem: a new action, or the one already tracking the passage', () async {
    final lender = await message(DemoPrivateAi.valuationThread, (_) => true);
    final source = MessageRef.of(lender);
    const quote =
        "If the time doesn't suit, reply to this email or call 0300 555 0177 at least two working days before.";
    final added = await tracker.trackBriefItem(source, item(quote), run: run);
    expect(added, isNotNull);
    expect((added!.owner, added.kind, added.folder), (ActionOwner.me, ActionKind.task, VirtualMailbox.needsMyAction));
    expect(added.origin, const ActionOrigin.suggested(providerId: 'cloud', model: 'm1', runHash: 'h'));
    expect((await repo.watchVirtualCounts().first)[VirtualMailbox.needsMyAction], 4);

    // Again: the same action, nothing new.
    final again = await tracker.trackBriefItem(source, item(quote), run: run);
    expect(again?.id, added.id);
    expect((await repo.watchActions().first).where((a) => a.source.emailId == lender.id), hasLength(1));

    // Deleted: not tracked again.
    await repo.saveActions([added.withDeleted(true, now)]);
    expect(await tracker.trackBriefItem(source, item(quote), run: run), isNull);
  });

  test('trackBriefItem: dates and conditions are not actions; a promise from someone else is waited for', () async {
    final receipt = await message(DemoPrivateAi.mortgageThread, (m) => m.preview.contains('have arrived'));
    final source = MessageRef.of(receipt);
    expect(
      await tracker.trackBriefItem(
        source,
        item('Usually within a week.', kind: BriefItemKind.date, owner: BriefOwner.them),
      ),
      isNull,
    );
    expect(
      await tracker.trackBriefItem(
        source,
        item('The overview should be for 2025, as written.', kind: BriefItemKind.next, owner: BriefOwner.them),
      ),
      isNull,
      reason: 'not a promise: nobody says “I will”',
    );
    // The adviser's promise is tracked already (the demo's seed).
    final promise = await tracker.trackBriefItem(
      source,
      item(
        'I will send you the valuation booking once the case is with the lender, usually within a week.',
        kind: BriefItemKind.next,
        owner: BriefOwner.them,
      ),
    );
    expect(promise?.id, startsWith('demo-action-'));
    expect(promise?.owner, ActionOwner.them);
  });
}
