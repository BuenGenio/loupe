import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/search/smart_mailbox_screen.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:loupe/settings/ui_state.dart';
import 'package:loupe/shared/mailbox_ref_codec.dart';
import 'package:loupe/theme/loupe_icons.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_sync/mail_sync.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../conversation/fake_mail_repository.dart';

const _name = ServerDocuments.smartMailboxes;

/// A container on [repository] with [prefs], its accounts loaded.
Future<ProviderContainer> _container(MailRepository repository, {Map<String, Object> prefs = const {}}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final shared = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(shared), repositoryProvider.overrideWithValue(repository)],
  );
  addTearDown(container.dispose);
  container.listen(smartMailboxesProvider, (_, _) {});
  await container.read(accountsProvider.future);
  return container;
}

SmartMailboxDocument? _stored(Map<String, Map<String, String>> docs, String accountId) {
  final raw = docs[accountId]?[_name];
  return raw == null ? null : SmartMailboxDocument.parse(raw);
}

List<String> _names(SmartMailboxDocument? doc) => [
  for (final e in doc?.entries ?? const <SmartMailboxEntry>[]) e.deleted ? '${e.id}†' : e.name,
];

String _legacyScope(String accountId, String path) =>
    MailboxRefCodec.encode(RealMailboxRef(MailIds.mailbox(accountId, path)));

void main() {
  late DemoMailRepository demo;

  setUp(() {
    demo = DemoMailRepository.instant(clock: () => DateTime(2026, 10, 4, 16));
    addTearDown(demo.dispose);
  });

  test('first sync migrates the Smart Mailboxes saved before syncing existed', () async {
    // Ids are creation times; one searches a folder of the work account.
    final legacy = [
      {'id': 'lq3k2x1a9b', 'name': 'Invoices', 'query': 'subject:invoice', 'scope': null},
      {'id': 'lq3m0c7f2d', 'name': 'Receipts', 'query': 'has:attachment', 'scope': _legacyScope('work', 'Receipts')},
      {'id': 'lq3m0c7f2e', 'name': 'Flagged VIPs', 'query': 'is:vip', 'scope': 'v.flagged'},
    ];
    final c = await _container(demo, prefs: {SmartMailboxes.legacyKey: jsonEncode(legacy)});
    final boxes = c.read(smartMailboxesProvider);
    expect(boxes.map((b) => b.name), ['Invoices', 'Receipts', 'Flagged VIPs']);
    expect(boxes[1].scope, _legacyScope('work', 'Receipts'));
    expect(boxes[1].accountId, 'work');
    expect(boxes[2].scope, 'v.flagged');

    await c.read(smartMailboxesProvider.notifier).sync();
    // Unified ones on the home account (the first), the folder search on its own.
    expect(c.read(smartMailboxHomeProvider), 'personal');
    expect(_names(_stored(demo.serverDocuments, 'personal')), ['Invoices', 'Flagged VIPs']);
    final work = _stored(demo.serverDocuments, 'work')!;
    expect(_names(work), ['Receipts']);
    expect(work.entries.single.scope, {'mailbox': 'Receipts'});
    expect(work.entries.single.modifiedAt.year, greaterThanOrEqualTo(2020));
    final status = c.read(smartMailboxSyncStatusProvider);
    expect(status.synced, {'personal': ServerStorage.metadata, 'work': ServerStorage.folder, 'fastmail': null});
    expect(status.pending, isFalse);
    // The new storage is written; the old key stays as it was.
    final prefs = c.read(sharedPreferencesProvider);
    expect(prefs.getString(SmartMailboxes.key), contains('Invoices'));
    expect(prefs.getString(SmartMailboxes.legacyKey), isNotNull);
  });

  test('the demo repository keeps documents like a server; another device’s changes arrive', () async {
    final c = await _container(demo);
    final notifier = c.read(smartMailboxesProvider.notifier);
    final mine = await notifier.add('Unread from Ana', 'from:ana is:unread');
    await notifier.sync();
    expect(_names(_stored(demo.serverDocuments, 'personal')), ['Unread from Ana']);

    // Another device renames ours and adds one.
    final doc = _stored(demo.serverDocuments, 'personal')!;
    final later = DateTime.now().toUtc().add(const Duration(minutes: 1));
    demo.serverDocuments['personal']![_name] = SmartMailboxDocument(
      entries: [
        doc.entries.single.copyWith(name: 'Ana', modifiedAt: later),
        SmartMailboxEntry(id: 'tablet1', name: 'From the tablet', query: 'is:flagged', modifiedAt: later),
      ],
    ).encode();
    await notifier.sync();
    expect(c.read(smartMailboxesProvider).map((b) => b.name), ['Ana', 'From the tablet']);

    // Deleting here leaves a tombstone there.
    await notifier.remove(mine.id);
    await notifier.sync();
    expect(c.read(smartMailboxesProvider).map((b) => b.name), ['From the tablet']);
    expect(_names(_stored(demo.serverDocuments, 'personal')), ['${mine.id}†', 'From the tablet']);
  });

  test('the folder fallback shows up as a hidden-ish folder of that account', () async {
    final c = await _container(demo);
    await c
        .read(smartMailboxesProvider.notifier)
        .add('Work receipts', 'has:attachment', scope: _legacyScope('work', 'INBOX'));
    await c.read(smartMailboxesProvider.notifier).sync();
    final folders = await demo.watchMailboxes(accountId: 'work').first;
    final folder = folders.singleWhere(ServerDocuments.isFolder);
    expect(folder.isSubscribed, isFalse);
    expect(c.read(smartMailboxSyncStatusProvider).synced['work'], ServerStorage.folder);
  });

  test('Sync via Off keeps everything on this device', () async {
    final c = await _container(demo, prefs: {SmartMailboxSyncVia.key: SmartMailboxSyncVia.off});
    final box = await c.read(smartMailboxesProvider.notifier).add('Local', 'is:unread');
    await c.read(smartMailboxesProvider.notifier).sync();
    expect(demo.serverDocuments, isEmpty);
    final (icon, text) = smartMailboxSyncLabel(
      box,
      home: c.read(smartMailboxHomeProvider),
      accounts: c.read(accountsProvider).value!,
      status: c.read(smartMailboxSyncStatusProvider),
    );
    expect((icon, text), (LoupeIcons.thisDevice, 'On this device only'));
  });

  test('a chosen home account keeps the unified ones', () async {
    final c = await _container(demo, prefs: {SmartMailboxSyncVia.key: 'fastmail'});
    await c.read(smartMailboxesProvider.notifier).add('Everything unread', 'is:unread');
    await c.read(smartMailboxesProvider.notifier).sync();
    expect(_names(_stored(demo.serverDocuments, 'fastmail')), ['Everything unread']);
    expect(_stored(demo.serverDocuments, 'personal'), isNull);
  });

  test('offline: changes wait on this device and go out once the server answers', () async {
    final fake = FakeMailRepository()..serverDocumentsError = const MailException(MailErrorKind.connection, 'Offline');
    final c = await _container(fake);
    final box = await c.read(smartMailboxesProvider.notifier).add('Later', 'is:flagged');
    await c.read(smartMailboxesProvider.notifier).sync();
    String label() => smartMailboxSyncLabel(
      box,
      home: c.read(smartMailboxHomeProvider),
      accounts: c.read(accountsProvider).value!,
      status: c.read(smartMailboxSyncStatusProvider),
    ).$2;
    expect(label(), 'Waiting to sync to Work');
    expect(c.read(smartMailboxSyncStatusProvider).failed, {'acc': 'Offline'});
    expect(fake.serverDocuments, isEmpty);

    fake.serverDocumentsError = null;
    await c.read(smartMailboxesProvider.notifier).sync();
    expect(label(), 'Synced to Work');
    expect(_names(_stored(fake.serverDocuments, 'acc')), ['Later']);
  });

  test('a rename keeps the entry and wins over the copy it replaces', () async {
    final c = await _container(demo);
    final notifier = c.read(smartMailboxesProvider.notifier);
    final box = await notifier.add('Old', 'is:unread');
    await notifier.sync();
    await notifier.rename(box.id, 'New');
    await notifier.sync();
    expect(c.read(smartMailboxesProvider).single.name, 'New');
    expect(_names(_stored(demo.serverDocuments, 'personal')), ['New']);
  });
}
