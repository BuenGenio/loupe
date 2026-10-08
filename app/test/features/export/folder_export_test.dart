import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/features/export/export_files.dart';
import 'package:loupe/features/export/folder_export.dart';
import 'package:mail_imap/mbox.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'export_fakes.dart';

final _fastmailInbox = MailIds.mailbox(DemoAccounts.fastmail, 'INBOX');

Future<Mailbox> _mailbox(MailRepository repo, String id) async =>
    (await repo.watchMailboxes().first).firstWhere((m) => m.id == id);

/// Lets the export run until it waits for a download.
Future<void> _untilWaiting(GatedDemoRepository repo, int n) async {
  for (var i = 0; i < 1000 && repo.waiting < n; i++) {
    await Future<void>.delayed(Duration.zero);
  }
  expect(repo.waiting, n);
}

final class _BrokenFile extends MemoryExportFile {
  _BrokenFile() : super('broken');

  @override
  Future<void> write(List<int> bytes) async => throw const FileSystemException('No space left on device');
}

final class _FullDisk extends MemoryExportFiles {
  @override
  Future<ExportFile> create(String name) async {
    final file = _BrokenFile();
    created.add(file);
    return file;
  }
}

void main() {
  // The demo's attachments come from the asset bundle.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FolderExport', () {
    test('writes every message, oldest first, also those the phone has yet to load', () async {
      final repo = GatedDemoRepository();
      addTearDown(repo.dispose);
      final onPhone = (await demoMessages(repo, _fastmailInbox)).length;
      final files = MemoryExportFiles();
      final progress = <ExportProgress>[];
      final export = FolderExport(
        repository: repo,
        files: files,
        mailbox: await _mailbox(repo, _fastmailInbox),
        fileName: 'Fastmail - Inbox.mbox',
      );

      final result = await export.run(onProgress: progress.add);

      final all = await demoMessages(repo, _fastmailInbox);
      expect(all.length, onPhone + 24, reason: 'the 24 older messages were loaded from the "server"');
      expect(result!.exported, all.length);
      expect(result.failed, 0);
      final file = result.file! as MemoryExportFile;
      expect((file.name, file.closed, file.deleted), ('Fastmail - Inbox.mbox', true, false));
      final lines = separators(file.text);
      expect(lines, hasLength(all.length));
      expect(
        [for (final l in lines) l.split(' ').skip(2).join(' ')],
        [for (final e in all.reversed) mboxDate(e.receivedAt)],
      );
      // Each message as View Source has it, in mboxrd.
      final oldest = all.last;
      final entry = mboxrdEntry(await repo.loadRawSource(oldest.id), date: oldest.receivedAt);
      expect(file.text, startsWith(utf8.decode(entry)));

      expect(progress.first.listing, isTrue);
      final counted = progress.skip(1).toList();
      expect(counted.first.current, 1);
      expect(counted.last.current, all.length);
      expect(counted.every((p) => p.total == all.length && !p.listing), isTrue);
    });

    test('counts messages that fail to download, leaves them out, and goes on', () async {
      final repo = GatedDemoRepository();
      addTearDown(repo.dispose);
      final messages = await demoMessages(repo, _fastmailInbox);
      repo.failing.addAll([messages.first.id, messages.last.id]);
      final files = MemoryExportFiles();
      final progress = <ExportProgress>[];
      final result = await FolderExport(
        repository: repo,
        files: files,
        mailbox: await _mailbox(repo, _fastmailInbox),
        fileName: 'x.mbox',
      ).run(onProgress: progress.add);

      final total = messages.length + 24;
      expect((result!.exported, result.failed), (total - 2, 2));
      expect(separators((result.file! as MemoryExportFile).text), hasLength(total - 2));
      expect(progress.last.failed, 2);
      expect(repo.downloads, hasLength(total), reason: 'every message was tried');
    });

    test('gives up on the rest after ${FolderExport.giveUpAfter} failures in a row, keeping what it has', () async {
      final repo = GatedDemoRepository();
      addTearDown(repo.dispose);
      final export = FolderExport(
        repository: repo,
        files: MemoryExportFiles(),
        mailbox: await _mailbox(repo, _fastmailInbox),
        fileName: 'x.mbox',
      );
      // All but the five oldest fail, as when the connection goes.
      while (await repo.loadOlder(RealMailboxRef(_fastmailInbox))) {}
      final all = await demoMessages(repo, _fastmailInbox);
      repo.failing.addAll(all.take(all.length - 5).map((m) => m.id));

      final result = await export.run();

      expect((result!.exported, result.failed), (5, all.length - 5));
      expect(repo.downloads, hasLength(5 + FolderExport.giveUpAfter));
      expect(separators((result.file! as MemoryExportFile).text), hasLength(5));
    });

    test('Cancel stops after the download under way and deletes the file', () async {
      final repo = GatedDemoRepository()..gated = true;
      addTearDown(repo.dispose);
      final files = MemoryExportFiles();
      final export = FolderExport(
        repository: repo,
        files: files,
        mailbox: await _mailbox(repo, _fastmailInbox),
        fileName: 'x.mbox',
      );
      final job = export.run();
      await _untilWaiting(repo, 1);
      repo.release();
      await _untilWaiting(repo, 1);
      export.cancel();
      repo.release();

      expect(await job, isNull);
      expect(repo.downloads, hasLength(2));
      expect(files.created.single.deleted, isTrue);
      expect(files.saved, isEmpty);
    });

    test('an empty folder gives no file', () async {
      final repo = FakeMailRepository();
      final files = MemoryExportFiles();
      final result = await FolderExport(
        repository: repo,
        files: files,
        mailbox: testMailboxes.first,
        fileName: 'Work - Inbox.mbox',
      ).run();
      expect((result!.file, result.exported, result.failed), (null, 0, 0));
      expect(files.created, isEmpty);
    });

    test('a folder that can’t be listed fails the export', () async {
      final repo = FakeMailRepository()..searchError = const MailException(MailErrorKind.connection, 'Offline.');
      final files = MemoryExportFiles();
      final export = FolderExport(repository: repo, files: files, mailbox: testMailboxes.first, fileName: 'x.mbox');
      await expectLater(export.run(), throwsA(isA<MailException>()));
      expect(files.created, isEmpty);
    });

    test('a file that can’t be written fails the export and is deleted', () async {
      final repo = GatedDemoRepository();
      addTearDown(repo.dispose);
      final files = _FullDisk();
      final export = FolderExport(
        repository: repo,
        files: files,
        mailbox: await _mailbox(repo, _fastmailInbox),
        fileName: 'x.mbox',
      );
      await expectLater(export.run(), throwsA(isA<FileSystemException>()));
      expect(files.created.single.deleted, isTrue);
    });
  });

  group('DeviceExportFiles', () {
    late Directory cache;
    setUp(() async => cache = await Directory.systemTemp.createTemp('loupe_export_test'));
    tearDown(() async => cache.delete(recursive: true));

    test('writes to a file of its own in the cache, and deletes it with its folder', () async {
      final files = DeviceExportFiles(directory: () async => cache);
      final file = await files.create('Work - Inbox.mbox');
      await file.write(utf8.encode('From a@x.org Thu Jan  1 00:00:00 2026\n'));
      await file.write(utf8.encode('Subject: Hi\n\n'));
      await file.close();
      final dirs = cache.listSync().whereType<Directory>().toList();
      expect(dirs, hasLength(1));
      final written = File('${dirs.single.path}/Work - Inbox.mbox');
      expect(written.readAsStringSync(), 'From a@x.org Thu Jan  1 00:00:00 2026\nSubject: Hi\n\n');

      await file.delete();
      expect(cache.listSync(), isEmpty);
    });

    test('clears what an export cut short left behind', () async {
      final leftover = await cache.createTemp('export_');
      File('${leftover.path}/old.mbox').writeAsStringSync('half');
      final unrelated = await Directory('${cache.path}/open_abc').create();
      final files = DeviceExportFiles(directory: () async => cache);
      final file = await files.create('new.mbox');
      expect(leftover.existsSync(), isFalse);
      expect(unrelated.existsSync(), isTrue);
      await file.delete();
    });
  });
}
