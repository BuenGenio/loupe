import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_patches.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:mail_model/mail_model.dart';

const kestrel = 'dev.lists.example.org';

/// Problems with the hunks of [patch]: each `@@ -a,b +c,d @@` header must be
/// followed by exactly b old and d new lines.
List<String> hunkProblems(String patch) {
  final problems = <String>[];
  final lines = patch.split('\n');
  final header = RegExp(r'^@@ -\d+(?:,(\d+))? \+\d+(?:,(\d+))? @@');
  for (var i = 0; i < lines.length; i++) {
    final m = header.firstMatch(lines[i]);
    if (m == null) continue;
    var old = int.parse(m[1] ?? '1');
    var fresh = int.parse(m[2] ?? '1');
    var k = i + 1;
    while (old > 0 || fresh > 0) {
      if (k >= lines.length) break;
      final l = lines[k++];
      if (l.startsWith('+')) {
        fresh--;
      } else if (l.startsWith('-')) {
        old--;
      } else if (l.startsWith(' ')) {
        old--;
        fresh--;
      } else {
        break;
      }
    }
    if (old != 0 || fresh != 0) problems.add('${lines[i]}: $old old, $fresh new lines missing');
  }
  return problems;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime(2026, 10, 4, 16);
  late DemoMailRepository repo;

  setUp(() => repo = DemoMailRepository.instant(clock: () => now));
  tearDown(() => repo.dispose());

  test('the demo patches are well-formed git format-patch mail', () {
    for (final patch in [kestrelPatch1, kestrelPatch2, kestrelPatch3, kestrelDocsPatch]) {
      expect(patch, contains('\ndiff --git a/'));
      expect(hunkProblems(patch), isEmpty);
      expect(patch, endsWith('-- \n2.47.0\n'));
    }
    expect(kestrelCoverLetter, contains(' 6 files changed, 95 insertions(+), 4 deletions(-)'));
    expect(kestrelReview, contains('> @@ -214,10 +215,14 @@'));
    expect(kestrelReviewAnswer, contains('> > -\th = http_parse_headers'));
  });

  test('list headers fill the summaries; lists group by List-Id', () async {
    final lists = await repo.watchMailingLists().first;
    expect(lists.map((l) => (l.id, l.name)), [
      (kestrel, 'Kestrel developers'),
      ('open-garden.lists.opengarden.example', 'Open Garden development'),
    ]);
    final dev = lists.first;
    expect(dev.postAddress?.email, 'dev@lists.example.org');
    expect(dev.accountIds, [DemoAccounts.fastmail]);
    expect(dev.unreadCount, 3);

    final review = (await repo.watchListThreads(kestrel).first)
        .firstWhere((t) => t.first.subject.startsWith('[PATCH v2 0/3]'))
        .latest;
    expect(review.listUnsubscribe, contains('mailto:dev-leave@lists.example.org'));
    final newsletter = (await repo.watchList(const VirtualMailboxRef(VirtualMailbox.allInboxes), limit: 500).first)
        .map((t) => t.latest)
        .where((e) => isOneClickUnsubscribe(e.listUnsubscribePost));
    expect(newsletter, isNotEmpty);
  });

  test('forum threads: the series with its badge, a discussion, a lone patch', () async {
    final threads = await repo.watchListThreads(kestrel).first;
    expect(threads.map((t) => t.patchBadge ?? t.first.subject), [
      'PATCH v2 3/3',
      'PATCH',
      'Planning 2.4: freeze on the 20th?',
    ]);
    final series = threads.first;
    expect(series.messageCount, 7);
    expect(series.replyCount, 6);
    expect(series.participants.map((p) => p.displayName), ['Ines Duarte', 'Oskar Lind', 'Malik Osei']);
    expect(series.unreadCount, 2);
    expect(threads.last.participants.map((p) => p.displayName), ['Oskar Lind', 'Malik Osei', 'Sam Rivera']);
  });

  test('muting hides a thread from the list view, marks it read, and comes undone', () async {
    final series = (await repo.watchListThreads(kestrel).first).first;
    await repo.setThreadMuted(series.latest.id, muted: true);
    expect(await repo.watchMutedThreads().first, {series.threadId});
    final visible = await repo.watchListThreads(kestrel).first;
    expect(visible.map((t) => t.threadId), isNot(contains(series.threadId)));
    final all = await repo.watchListThreads(kestrel, includeMuted: true).first;
    final muted = all.firstWhere((t) => t.threadId == series.threadId);
    expect(muted.isMuted, isTrue);
    expect(muted.unreadCount, 0);
    expect((await repo.watchMailingLists().first).first.unreadCount, 1);

    await repo.setThreadMuted(series.first.id, muted: false);
    expect(await repo.watchMutedThreads().first, isEmpty);
    expect(await repo.watchListThreads(kestrel).first, hasLength(3));
    await expectLater(repo.setThreadMuted('nope', muted: true), throwsA(isA<MailException>()));
  });
}
