import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_matters.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:loupe/features/matters/matter_candidates.dart';
import 'package:loupe/features/matters/matter_providers.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime(2026, 10, 30, 16);
  late DemoMailRepository repo;
  late MattersController controller;

  setUp(() {
    repo = DemoMailRepository.instant(clock: () => now);
    controller = MattersController(repo, now: () => now);
  });
  tearDown(() => repo.dispose());

  Future<Matter> house() async => (await repo.watchMatters().first).singleWhere((m) => m.id == DemoMatters.quayStreet);
  Future<List<EmailSummary>> messages([String id = DemoMatters.quayStreet]) => repo.watchMatterMessages(id).first;
  Future<Set<String>> mailIds() async => {
    for (final b in await repo.watchMailboxes().first)
      for (final t in await repo.watchList(RealMailboxRef(b.id), threaded: false, limit: 1000).first) t.latest.id,
  };

  test('the demo starts with "Buying 14 Quay Street": four conversations from four senders', () async {
    final m = await house();
    expect(m.name, 'Buying 14 Quay Street');
    expect(m.members.map((x) => x.threadId), DemoPrivateAi.threadIds);
    expect(m.members.every((x) => x.source == MatterSource.manual), isTrue);
    expect(m.history.first.kind, MatterEventKind.created);
    expect(m.history.where((e) => e.kind == MatterEventKind.added), hasLength(4));
    final all = await messages();
    expect(all, hasLength(7));
    expect(
      {for (final e in all) e.sender!.email},
      containsAll([
        DemoPrivateAi.adviser.email,
        DemoPrivateAi.solicitor.email,
        DemoPrivateAi.lender.email,
        DemoPrivateAi.removals.email,
      ]),
    );
    expect([for (final e in all) e.receivedAt], [...all.map((e) => e.receivedAt)]..sort(), reason: 'oldest first');
    expect((await repo.watchMatterActivity().first)[m.id], all.last.receivedAt);
  });

  test('filing a message keeps it in the matter; deleting the matter leaves the mail', () async {
    final before = await mailIds();
    final solicitor = (await messages()).firstWhere((e) => e.sender == DemoPrivateAi.solicitor);
    final archive = (await repo.watchMailboxes().first).firstWhere(
      (b) => b.accountId == DemoAccounts.personal && b.role == MailboxRole.all,
    );
    await repo.move([solicitor.id], archive.id);
    expect((await messages()).map((e) => e.id), contains(solicitor.id));
    expect(await repo.locateMessage(MessageRef.of(solicitor)), isNotNull);

    await controller.delete(DemoMatters.quayStreet);
    expect(await repo.watchMatters().first, isEmpty);
    expect(await mailIds(), before);
  });

  test('add, remove (remembered), merge, split and rename; the mail is untouched', () async {
    final before = await mailIds();
    final m = await house();
    final first = (await messages()).first;
    final removed = (await controller.remove(m.id, conversationOf(first), subject: first.subject))!;
    expect((await house()).members, hasLength(3));
    expect((await house()).excludes(first), isTrue);
    await controller.restore(m.id, removed, subject: first.subject);
    expect((await house()).members, hasLength(4));
    expect((await house()).excludes(first), isFalse);

    final removals = (await messages()).firstWhere((e) => e.sender == DemoPrivateAi.removals);
    final move = (await controller.split(m.id, {conversationOf(removals)}, 'The move'))!;
    expect(move.members.single.threadId, removals.threadId);
    expect((await house()).members, hasLength(3));
    expect((await messages(move.id)).single.id, removals.id);

    await controller.rename(move.id, 'Moving day');
    await controller.merge(move.id, m.id);
    final all = await repo.watchMatters().first;
    expect(all.map((x) => x.name), ['Buying 14 Quay Street']);
    expect(all.single.members, hasLength(4));
    expect(all.single.history.last.text, 'Moving day');
    expect(await mailIds(), before);
  });

  test(
    'suggestions: the insurance quote for its mention, the adviser’s other case lower, the bookshop never',
    () async {
      final m = await house();
      final all = await messages();
      final terms = matterTerms(m, all);
      expect(terms, containsAll(['14 Quay Street', 'INV-2207']));
      expect(terms, isNot(contains('Invoice')));

      Future<List<MatterCandidate>> find() async => findMatterCandidates(
        repository: repo,
        matter: await house(),
        messages: all,
        ownAddresses: {DemoPeople.personal.email, DemoPeople.work.email, DemoPeople.fastmail.email},
        mailboxes: {for (final b in await repo.watchMailboxes().first) b.id: b},
      );
      final found = await find();
      expect(found.first.email.subject, 'Your buildings insurance quote');
      expect(found.first.reason, const MatterReason(MatterReasonKind.mentions, '14 Quay Street'));
      final referral = found.singleWhere((c) => c.email.subject == 'Thank you for the introduction');
      expect(referral.reason.kind, MatterReasonKind.sameSender);
      expect(referral.reason.isWeak, isTrue);
      expect(found.indexOf(referral), greaterThan(0));
      expect(found.map((c) => c.email.subject), isNot(contains(startsWith('Order #10482'))));
      expect(found.any((c) => all.any((e) => conversationOf(e) == conversationOf(c.email))), isFalse);

      // Not This One is remembered; Add makes it a member with its reason.
      await controller.decline(m.id, referral.email);
      expect((await find()).map((c) => c.email.subject), isNot(contains('Thank you for the introduction')));
      await controller.add(m.id, found.first.email, reason: found.first.reason);
      final added = (await house()).members.last;
      expect((added.source, added.reason), (MatterSource.suggested, found.first.reason));
      expect((await find()).map((c) => c.email.subject), isNot(contains('Your buildings insurance quote')));
    },
  );

  test('removing an account takes its conversations out of the matter', () async {
    await repo.removeAccount(DemoAccounts.personal);
    final m = await house();
    expect(m.members, isEmpty);
    expect(m.history.map((e) => e.kind), [MatterEventKind.created]);
  });

  test('the demo’s Where Things Stand passes the task’s own parser and quotes each source', () async {
    final all = await messages();
    final byId = {for (final e in all) e.id: MatterStatusMessage.ownText((await repo.loadContent(e.id)).text!)};
    final task = MatterStatusTask(
      matterName: DemoMatters.quayStreetName,
      messages: [
        for (final e in all)
          MatterStatusMessage(
            emailId: e.id,
            conversation: e.threadId!,
            from: '${e.sender!.displayName} <${e.sender!.email}>',
            fromMe: e.sender!.email == DemoPeople.personal.email,
            date: e.receivedAt,
            subject: e.subject,
            text: byId[e.id]!,
          ),
      ],
    );
    final run = await AiRunner(DemoAiProvider(now: () => now)).run(task);
    if (run is AiFailure<MatterStatus>) fail(run.message);
    final status = (run as AiSuccess<MatterStatus>).value;
    expect(status.statements.length, inInclusiveRange(4, 5));
    expect(status.statements.first.text, startsWith('Quayside Removals: Amount due: £450.00'));
    expect(status.statements.map((s) => s.text).join('\n'), contains('booked the valuation of 14 Quay Street'));
    for (final s in status.statements) {
      expect(byId[s.emailId], contains(s.quote));
      expect(s.text, isNot(contains(DemoPrivateAi.password)));
    }
    expect(status.partial, isFalse);
  });
}
