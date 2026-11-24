import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/projects/project_settings.dart';
import 'package:loupe/features/projects/projects_state.dart';
import 'package:loupe/router.dart';
import 'package:loupe/shared/message_row.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_platform/mail_platform.dart' show SecretStorage;
import 'package:mail_sync/mail_sync.dart';

import '../../helpers.dart';

/// Projects: kept on the home account's server, listed on Mailboxes, and
/// filled from a conversation's Add to Project….

/// Lets the debounced sync round run.
Future<void> _syncRound(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

ProviderContainer _container(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));

List<String> _stored(DemoMailRepository repo) => [
  for (final e in ProjectDocument.parse(repo.serverDocuments['work']![ServerDocuments.projects]!).entries)
    e.deleted ? '${e.id}†' : '${e.name}${e.done ? ' (done)' : ''}',
];

Future<List<EmailSummary>> _members(DemoMailRepository repo, Project p) async => [
  for (final t in await repo.watchList(p.ref, threaded: false).first) t.latest,
];

void main() {
  group('tiles', tilesTests);
  group('settings', _settingsTests);

  testWidgets('the projects on the server show on Mailboxes; one opens as a list of its conversations', (tester) async {
    await pumpLoupe(tester);
    await _syncRound(tester);
    await tester.scrollTo(find.text('New Project…'));
    expect(find.text('Atlas Launch'), findsOneWidget);
    expect(find.text('Lisbon Trip'), findsOneWidget);
    expect(find.text('New Project…'), findsOneWidget);

    await tester.tap(find.text('Lisbon Trip'));
    await tester.pumpAndSettle();
    expect(find.text('Lisbon Trip'), findsWidgets, reason: 'the title');
    expect(find.text('Re: Lisbon in November?'), findsOneWidget);
    expect(find.text('Team offsite — logistics'), findsNothing, reason: 'another project');
    await drainTimers(tester);
  });

  testWidgets('New Project…, then Add to Project… puts the whole conversation in it', (tester) async {
    final repo = await pumpLoupe(tester);
    await _syncRound(tester);
    // Past it, so the row is clear of the bottom bar.
    await tester.scrollTo(find.text('Smart Mailboxes'));
    await tester.tap(find.text('New Project…'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('project-name')), 'Dinner club');
    await tester.tap(find.byKey(const ValueKey('project-colour-3')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('project-save')));
    await tester.pumpAndSettle();
    await _syncRound(tester);
    expect(_stored(repo), containsAll(['Dinner club', 'Lisbon Trip', 'Atlas Launch']));
    final dinner = _container(tester).read(projectsProvider).firstWhere((p) => p.name == 'Dinner club');
    expect(dinner.color, ProjectColors.palette[3]);

    // A conversation of three in All Inboxes: its More sheet.
    await goTo(tester, Routes.list(const VirtualMailboxRef(VirtualMailbox.allInboxes)));
    await tester.scrollTo(find.text('Re: Dinner Saturday?'));
    await tester.longPress(find.text('Re: Dinner Saturday?'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Project…'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('project-pick-${dinner.id}')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('project-picker-done')));
    await tester.pumpAndSettle();
    final members = await _members(repo, dinner);
    expect(members.map((e) => e.subject).toSet(), {'Dinner Saturday?', 'Re: Dinner Saturday?'});
    expect(members, hasLength(3), reason: 'every message of the conversation');

    // Its list, and Mark as Done from its menu.
    await goTo(tester, Routes.list(dinner.ref));
    expect(find.text('Re: Dinner Saturday?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('project-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mark as Done'));
    await tester.pumpAndSettle();
    await _syncRound(tester);
    expect(_stored(repo), contains('Dinner club (done)'));
    await drainTimers(tester);
  });

  testWidgets('Delete Project takes its keyword off the messages and leaves a tombstone', (tester) async {
    final repo = await pumpLoupe(tester);
    await _syncRound(tester);
    final atlas = _container(tester).read(projectsProvider).firstWhere((p) => p.name == 'Atlas Launch');
    expect(await _members(repo, atlas), isNotEmpty);
    await goTo(tester, Routes.list(atlas.ref));
    await tester.tap(find.byKey(const Key('project-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Project'));
    await tester.pumpAndSettle();
    expect(find.text('Its conversations stay where they are, out of the project.'), findsOneWidget);
    await tester.tap(find.text('Delete Project').last);
    await tester.pumpAndSettle();
    await _syncRound(tester);
    expect(_stored(repo), contains('atlas†'));
    expect(await _members(repo, atlas), isEmpty);
    expect(find.text('Project'), findsWidgets, reason: 'the list of a project no longer known');
    await drainTimers(tester);
  });

  testWidgets('a project made on another device arrives with the next round', (tester) async {
    final repo = await pumpLoupe(tester);
    await _syncRound(tester);
    final doc = ProjectDocument.parse(repo.serverDocuments['work']![ServerDocuments.projects]!);
    repo.serverDocuments['work']![ServerDocuments.projects] = ProjectDocument(
      entries: [
        ...doc.entries,
        ProjectEntry(id: 'tablet1', name: 'From the tablet', modifiedAt: DateTime.utc(2026, 10, 4, 15)),
      ],
    ).encode();
    unawaited(_container(tester).read(projectsProvider.notifier).sync());
    await _syncRound(tester);
    expect(_container(tester).read(projectsProvider).map((p) => p.name), [
      'Atlas Launch',
      'From the tablet',
      'Lisbon Trip',
    ]);
    await drainTimers(tester);
  });
}

Future<void> _openTiles(WidgetTester tester) async {
  await _syncRound(tester);
  await goTo(tester, Routes.list(const VirtualMailboxRef(VirtualMailbox.allInboxes)));
  await tester.tap(find.byKey(const Key('inbox-tiles')));
  await tester.pumpAndSettle();
  // Suggestions are found after a frame, from the local mail.
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

/// The Tiles view of All Inboxes (phase 2 and 3), on the demo mailbox.
void tilesTests() {
  testWidgets('tiles: projects, suggested topics and Everything Else; Make Project and Not a Topic', (tester) async {
    await atTestNow(() => _suggestionsAndMakeProject(tester));
  });
}

Future<void> _suggestionsAndMakeProject(WidgetTester tester) async {
  {
    final repo = await pumpLoupe(tester);
    await _openTiles(tester);
    expect(find.byKey(const ValueKey('tile-atlas')), findsOneWidget);
    expect(find.byKey(const ValueKey('tile-lisbon')), findsOneWidget);
    expect(find.byKey(const ValueKey('tile-everything-else')), findsOneWidget);
    const library = 'org:citylibrary.example';
    expect(find.byKey(const ValueKey('suggestion-$library')), findsOneWidget);
    expect(find.text('City Library'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('make-$library')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    final made = _container(tester).read(projectsProvider).firstWhere((p) => p.name == 'City Library');
    expect(find.byKey(const ValueKey('suggestion-$library')), findsNothing);
    expect(find.byKey(ValueKey('tile-${made.id}')), findsOneWidget);
    expect(await _members(repo, made), hasLength(greaterThanOrEqualTo(3)));
    final rule = (await repo.rules.watchRules().first).singleWhere((r) => r.id == 'project-${made.id}');
    expect(rule.condition, 'from:citylibrary.example');
    expect(rule.actions, [AddTagAction(made.keyword)]);

    final other = find.byWidgetPredicate(
      (w) => w.key is ValueKey<String> && (w.key! as ValueKey<String>).value.startsWith('dismiss-'),
    );
    final key = ((tester.widget(other.first).key! as ValueKey<String>).value).substring('dismiss-'.length);
    await tester.tap(other.first);
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey('suggestion-$key')), findsNothing);
    expect(_container(tester).read(dismissedTopicsProvider), contains(key));

    // Everything Else: the inboxes' conversations in no project.
    await tester.dragUntilVisible(
      find.byKey(const ValueKey('tile-everything-else')),
      find.byType(CustomScrollView).first,
      const Offset(0, -150),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tile-everything-else')));
    await tester.pumpAndSettle();
    expect(find.text('Everything Else'), findsWidgets);
    final rows = find.byType(MessageRow);
    expect(rows, findsWidgets);
    expect(find.descendant(of: rows, matching: find.text('Re: Lisbon in November?')), findsNothing);
    await drainTimers(tester);
  }
}

void _settingsTests() {
  testWidgets('Settings › Projects: Everything Else off; the AI server, key and model', (tester) async {
    final secrets = MemorySecrets();
    await pumpLoupe(tester, overrides: [projectSecretsProvider.overrideWithValue(secrets)]);
    await goTo(tester, Routes.settings);
    await tester.scrollTo(find.byKey(const Key('project-settings')));
    await tester.tap(find.byKey(const Key('project-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('projects-everything-else')));
    await tester.pumpAndSettle();
    expect(_container(tester).read(projectSettingsProvider).everythingElse, isFalse);

    await tester.tap(find.byKey(const Key('projects-ai')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('projects-ai-server')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(CupertinoTextField), 'ai.home.test:8080');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('projects-ai-key')));
    await tester.pumpAndSettle();
    expect(tester.widget<CupertinoTextField>(find.byType(CupertinoTextField)).obscureText, isTrue);
    await tester.enterText(find.byType(CupertinoTextField), 'sk-test');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final s = _container(tester).read(projectSettingsProvider);
    expect((s.ai, s.aiServer), (true, 'ai.home.test:8080'));
    expect(secrets.values, {projectAiKeySecret: 'sk-test'}, reason: 'the key is in the keychain, not the preferences');
    expect(find.text('••••••••'), findsOneWidget);

    await goTo(tester, Routes.list(const VirtualMailboxRef(VirtualMailbox.allInboxes)));
    await tester.tap(find.byKey(const Key('inbox-tiles')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('tile-everything-else')), findsNothing);
    await drainTimers(tester);
  });
}

/// A keychain in memory.
final class MemorySecrets implements SecretStorage {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}
