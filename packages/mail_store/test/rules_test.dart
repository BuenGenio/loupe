import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_store/src/schema.dart';
import 'package:sqlite3/sqlite3.dart' show sqlite3;
import 'package:test/test.dart';

import 'fixtures.dart';

Rule _rule(String id, {String condition = 'f:x'}) =>
    Rule(id: id, name: id.toUpperCase(), condition: condition, actions: const [FlagAction()]);

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  test('rules: new ones go last, saves keep the place, reorder and delete', () async {
    final store = MailStore.memory();
    final seen = <List<String>>[];
    final sub = store.watchRules().listen((rules) => seen.add([for (final r in rules) r.id]));
    await store.saveRule(_rule('a'));
    await store.saveRule(_rule('b').copyWith(order: -5));
    await store.saveRule(_rule('c'));
    await store.saveRule(_rule('a', condition: 'f:changed'));
    var rules = await store.getRules();
    expect([for (final r in rules) (r.id, r.order)], [('a', 0), ('b', 1), ('c', 2)]);
    expect(rules.first.condition, 'f:changed');
    expect(rules.first.actions, [const FlagAction()]);

    await store.reorderRules(['c', 'a']);
    rules = await store.getRules();
    expect([for (final r in rules) (r.id, r.order)], [('c', 0), ('a', 1), ('b', 2)]);
    await store.deleteRule('a');
    expect([for (final r in await store.getRules()) r.id], ['c', 'b']);
    await Future<void>.delayed(Duration.zero);
    expect(seen.last, ['c', 'b']);
    await sub.cancel();
    await store.close();
  });

  test('watermarks and messages stored after one', () async {
    final store = await seededStore();
    final inbox = mbox('INBOX');
    expect(await store.ruleWatermark(inbox), isNull);
    await addMails(store, [mail(1), mail(2), mail(1, path: 'Work')]);
    final all = await store.emailsStoredAfter(inbox, 0);
    expect([for (final (_, e) in all) e.id], [eid('INBOX', 1), eid('INBOX', 2)]);
    final last = all.last.$1;
    await store.setRuleWatermark(inbox, RuleWatermark(seq: last, uidValidity: 1, uid: 2));
    expect(await store.ruleWatermark(inbox), RuleWatermark(seq: last, uidValidity: 1, uid: 2));
    await addMails(store, [mail(3)]);
    expect([for (final (_, e) in await store.emailsStoredAfter(inbox, last)) e.id], [eid('INBOX', 3)]);
    // Gone with the mailbox.
    await store.replaceMailboxes(accountId, standardMailboxes.where((m) => m.path != 'INBOX').toList());
    expect(await store.ruleWatermark(inbox), isNull);
    await store.close();
  });

  test('a version 1 database gains the rule tables', () async {
    final dir = Directory.systemTemp.createTempSync('mail_store_migration');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File('${dir.path}/v1.db');
    // The schema of version 1, as the first release created it.
    final raw = sqlite3.open(file.path);
    for (final statement in File('test/schemas/v1.sql').readAsStringSync().split(RegExp(r'^--$', multiLine: true))) {
      final sql = statement.split('\n').where((l) => !l.startsWith('-- ')).join('\n').trim();
      if (sql.isNotEmpty) raw.execute(sql);
    }
    raw
      ..execute('PRAGMA user_version = 1')
      ..close();

    final db = StoreDatabase(NativeDatabase(file));
    final tables = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table' AND name LIKE 'rule%' ORDER BY name")
        .get();
    expect([for (final t in tables) t.read<String>('name')], ['rule_watermarks', 'rules']);
    expect((await db.customSelect('PRAGMA user_version').getSingle()).read<int>('user_version'), latestSchemaVersion);
    await db.close();
  });
}
