// Screenshots of the Private AI features on the demo storyline (Sam buying
// 14 Quay Street, app/lib/demo/demo_private_ai.dart), for a walkthrough of
// the milestone rather than the website: they go to build/private-ai-shots,
// or wherever LOUPE_AI_SHOTS says. One shot:
// `tool/screenshots.sh --plain-name ai-brief`; all of them: `--plain-name ai-`.

part of 'screenshots_test.dart';

final _aiOutDir = Platform.environment['LOUPE_AI_SHOTS'] ?? '../build/private-ai-shots';

const _aiOn = {'settings.aiAssist': true};
const _adviserFirst = 'Your mortgage application: what we need next';
const _adviserRe = 'Re: Your mortgage application: what we need next';

/// A shot with Private AI on (the built-in demo provider).
void _aiShot(String slug, Future<void> Function(WidgetTester tester, DemoMailRepository repo) body) =>
    _shot(slug, body, prefs: _aiOn, outDir: _aiOutDir);

/// The mortgage conversation's messages, oldest first.
Future<List<EmailSummary>> _mortgage(DemoMailRepository repo) async {
  final first = await _find(repo, (e) => e.subject == _adviserFirst || e.subject == _adviserRe);
  final messages = await repo.watchConversation(first.id).first;
  return [...messages]..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
}

/// Waits for work outside the widget test's fake time (isolates, compute).
Future<void> _settleOutside(WidgetTester tester) async {
  await tester.runAsync(() async {
    for (var attempt = 0; attempt < 100; attempt++) {
      await tester.pump();
      if (find.byType(CircularProgressIndicator).evaluate().isEmpty) return;
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  });
  await tester.pumpAndSettle();
}

/// Opens [id] and its Brief, scrolled to the summary.
Future<void> _openBrief(WidgetTester tester, String id) async {
  await _go(tester, Routes.message(id));
  final card = find.byWidgetPredicate((w) => w is MessageCard && w.message.id == id);
  await _tap(tester, find.descendant(of: card, matching: find.byKey(const Key('brief-button'))));
  await _reveal(tester, find.byKey(const Key('brief-summary')), alignment: 0.08);
}

/// The index of the Brief item whose text has [words].
int _briefItem(WidgetTester tester, String words) {
  final tile = find
      .ancestor(
        of: find.textContaining(words),
        matching: find.byWidgetPredicate((w) => '${w.key}'.contains('brief-item-')),
      )
      .first;
  return int.parse(RegExp(r'brief-item-(\d+)').firstMatch('${tester.widget(tile).key}')!.group(1)!);
}

void _privateAiShots() {
  _aiShot('ai-settings', (tester, repo) async {
    await _go(tester, Routes.privateAi);
  });

  _aiShot('ai-usage', (tester, repo) async {
    final service = _container(tester).read(aiServiceProvider)!;
    await tester.runAsync(() async {
      for (final sentence in ['unread from rhea with attachments', 'invoices since september']) {
        await service.run(SearchTranslationTask(sentence, now: _now));
      }
    });
    await _go(tester, Routes.aiUsage);
  });

  _aiShot('ai-ask', (tester, repo) async {
    await _go(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'unread from rhea with attachments since september');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    await _tap(tester, find.text('Ask in Plain English').last);
  });

  _aiShot('ai-brief', (tester, repo) async {
    await _openBrief(tester, (await _mortgage(repo)).first.id);
  });

  _aiShot('ai-brief-source', (tester, repo) async {
    await _openBrief(tester, (await _mortgage(repo)).first.id);
    final item = find.byKey(ValueKey('brief-item-${_briefItem(tester, 'The ID check')}'));
    await _reveal(tester, item);
    await _tap(tester, find.descendant(of: item, matching: find.textContaining('The ID check')).first);
  });

  _aiShot('ai-brief-calendar', (tester, repo) async {
    await _openBrief(tester, await _bySubject(repo, 'Valuation booked: 14 Quay Street'));
    final index = _briefItem(tester, 'We have booked the valuation');
    await _reveal(tester, find.byKey(ValueKey('brief-more-$index')));
    await _tap(tester, find.byKey(ValueKey('brief-more-$index')));
    await _tap(tester, find.text('Add to Calendar…'));
  });

  _aiShot('ai-changes', (tester, repo) async {
    final messages = await _mortgage(repo);
    final revised = messages.last;
    await _go(tester, Routes.message(revised.id));
    final more = find.byKey(ValueKey('more-${revised.id}'));
    await tester.ensureVisible(more);
    await _tap(tester, more);
    final compare = find.text('Compare Messages…');
    await tester.ensureVisible(compare);
    await tester.tap(compare);
    await _settleOutside(tester);
    await _tap(tester, find.byKey(const ValueKey('changes-from')));
    await tester.tap(find.byWidgetPredicate((w) => w is DropdownMenuItem<String> && w.value == messages.first.id).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await _settleOutside(tester);
    final explain = find.byKey(const ValueKey('explain-changes'));
    await tester.runAsync(() => Scrollable.ensureVisible(tester.element(explain), alignment: 0.5));
    await tester.pump();
    await _tap(tester, explain);
    await tester.runAsync(() => Scrollable.ensureVisible(tester.element(find.text('What Changed')), alignment: 0.02));
    await tester.pumpAndSettle();
  });

  _aiShot('ai-rule', (tester, repo) async {
    await _go(tester, Routes.rules);
    await _tap(tester, find.text('Describe a Rule…'));
    await tester.enterText(
      find.byKey(const ValueKey('describe-sentence')),
      'Keep Trailhead newsletters quiet but notify me about invoices',
    );
    await tester.pump();
    await _tap(tester, find.text('Propose Rule'));
  });

  _aiShot('ai-reply-check', (tester, repo) async {
    final first = (await _mortgage(repo)).first;
    await _go(
      tester,
      Routes.compose,
      extra: ComposeArgs(mode: ComposeMode.reply, sourceEmailId: first.id),
    );
    await _tap(tester, find.byTooltip('Attach'));
    final file = find.byKey(const ValueKey('demo-file-SA302 2023-24.pdf'));
    await tester.ensureVisible(file);
    await _tap(tester, file);
    await _tap(tester, find.byKey(const Key('reply-check-toggle')));
    await _reveal(tester, find.byKey(const Key('reply-check')), alignment: 0.05);
  });

  _aiShot('ai-mailboxes', (tester, repo) async {
    await _reveal(tester, find.text('Needs My Action'), alignment: 0.15);
  });

  _aiShot('ai-needs-my-action', (tester, repo) async {
    await _reveal(tester, find.text('Needs My Action'));
    await _tap(tester, find.text('Needs My Action'));
  });

  _aiShot('ai-actions', (tester, repo) async {
    await _go(tester, Routes.message((await _mortgage(repo)).last.id));
    await _tap(tester, find.byKey(const Key('conversation-actions')));
  });

  _aiShot('ai-matter', (tester, repo) async {
    await _go(tester, Routes.matter(DemoMatters.quayStreet));
    await _tap(tester, find.text('Where Things Stand'));
  });
}
