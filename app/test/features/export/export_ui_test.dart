import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/attachments/attachment_platform.dart';
import 'package:loupe/features/export/export_files.dart';
import 'package:loupe/router.dart';
import 'package:mail_imap/mbox.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../attachments/attachment_fakes.dart' show FakePlatform;
import '../openpgp/openpgp_test_support.dart' show inlinePgp;
import '../panes/fake_app.dart' show press;
import 'export_fakes.dart';

const _allInboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);
const _hike = 'Photos from Sunday’s hike';
final _folder = MailIds.mailbox(DemoAccounts.work, 'Notifications');

/// The id of the first message in All Inboxes that passes [test].
Future<String> _id(DemoMailRepository repo, bool Function(EmailSummary) test) async =>
    (await repo.watchList(_allInboxes, threaded: false, limit: 1000).first).map((t) => t.latest).firstWhere(test).id;

/// [id]'s raw source, outside the test's fake time (the demo waits on a
/// timer, which fake time only runs while pumping).
Future<List<int>> _raw(WidgetTester tester, DemoMailRepository repo, String id) async =>
    (await tester.runAsync(() => repo.loadRawSource(id)))!;

/// Long-presses the Notifications folder on Mailboxes and picks Export Folder….
Future<void> _exportFolder(WidgetTester tester, {bool settle = true}) async {
  final folder = find.text('Notifications');
  await tester.scrollTo(folder);
  // Into the middle, clear of the title and bottom bars.
  await Scrollable.ensureVisible(tester.element(folder), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.longPress(folder);
  await tester.pumpAndSettle();
  expect(find.text('Export Folder…'), findsOneWidget);
  await tester.tap(find.text('Export Folder…'));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }
}

/// Opens the ⋯ menu of the only message shown and taps [label].
Future<void> _messageMenu(WidgetTester tester, String label) async {
  await tester.tap(find.byTooltip('More').first);
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

void main() {
  group('a message as a file', () {
    testWidgets('Save as File… saves its source as <subject>.eml; Share as File… shares it', (tester) async {
      final platform = FakePlatform();
      final repo = await pumpLoupe(tester, overrides: [attachmentPlatformProvider.overrideWithValue(platform)]);
      await goTo(tester, Routes.list(_allInboxes));
      await tester.tap(find.text(_hike));
      await tester.pumpAndSettle();
      final id = await _id(repo, (e) => e.subject == _hike);

      await tester.tap(find.byTooltip('More').first);
      await tester.pumpAndSettle();
      expect(find.text('View Source'), findsOneWidget);
      expect(find.text('Save as File…'), findsOneWidget);
      expect(find.text('Share as File…'), findsOneWidget);
      await tester.tap(find.text('Save as File…'));
      await tester.pumpAndSettle();
      expect(platform.calls, ['save $_hike.eml']);
      expect(platform.last!.mimeType, 'message/rfc822');
      expect(platform.last!.bytes, await _raw(tester, repo, id));
      expect(find.text('Saved “$_hike.eml”'), findsOneWidget);
      await drainTimers(tester);

      await _messageMenu(tester, 'Share as File…');
      expect(platform.calls.last, 'share $_hike.eml message/rfc822');
      expect(platform.last!.bytes, await _raw(tester, repo, id));
    });

    testWidgets('an encrypted message is saved as it was sent, encrypted, named by its decrypted subject', (
      tester,
    ) async {
      final platform = FakePlatform();
      final repo = await pumpLoupe(
        tester,
        overrides: [inlinePgp, attachmentPlatformProvider.overrideWithValue(platform)],
      );
      final id = await _id(repo, (e) => e.sender?.email == 'dana.okafor@northwind.example' && e.subject == '...');
      await goTo(tester, Routes.message(id));
      expect(textContaining('Lighthouse Lodge'), findsWidgets, reason: 'shown decrypted');

      await _messageMenu(tester, 'Save as File…');
      expect(platform.calls, ['save Offsite venue (confidential).eml']);
      final saved = latin1.decode(platform.last!.bytes);
      expect(saved, contains('-----BEGIN PGP MESSAGE-----'));
      expect(saved, isNot(contains('Lighthouse Lodge')));
      expect(platform.last!.bytes, await _raw(tester, repo, id));
      await drainTimers(tester);
    });
  });

  group('Export Folder…', () {
    testWidgets('a folder’s long-press menu exports it as <account> - <folder>.mbox, oldest first', (tester) async {
      final files = MemoryExportFiles();
      final repo = await pumpLoupe(tester, overrides: [exportFilesProvider.overrideWithValue(files)]);

      await _exportFolder(tester);

      final messages = await demoMessages(repo, _folder);
      expect(messages, hasLength(18));
      final saved = files.saved.single;
      expect((saved.name, saved.mimeType), ('Work - Notifications.mbox', 'application/mbox'));
      final mbox = utf8.decode(saved.bytes);
      expect(separators(mbox), hasLength(messages.length));
      // Oldest first.
      expect(
        [for (final l in separators(mbox)) l.split(' ').skip(2).join(' ')],
        [for (final e in messages.reversed) mboxDate(e.receivedAt)],
      );
      expect(files.created.single.deleted, isTrue, reason: 'the copy in the cache is gone');
      expect(find.text('Saved “Work - Notifications.mbox”'), findsOneWidget);
      expect(find.byKey(const Key('export-status')), findsNothing);
      await drainTimers(tester);
    });

    testWidgets('the sheet shows the progress, and Cancel stops the export', (tester) async {
      final files = MemoryExportFiles();
      final repo = GatedDemoRepository();
      await pumpLoupe(tester, repository: repo, overrides: [exportFilesProvider.overrideWithValue(files)]);
      repo.gated = true;

      await _exportFolder(tester, settle: false);
      final total = (await demoMessages(repo, _folder)).length;
      expect(total, greaterThan(2));
      expect(find.text('Exporting “Notifications”'), findsOneWidget);
      expect(find.text('Exporting 1 of $total…'), findsOneWidget);
      repo.release();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Exporting 2 of $total…'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('export-status')), findsNothing);
      repo.release();
      await tester.pumpAndSettle();
      expect(repo.downloads, hasLength(2));
      expect(files.created.single.deleted, isTrue);
      expect(files.saved, isEmpty, reason: 'no save dialog');
      expect(textContaining('Saved'), findsNothing);
    });

    testWidgets('Back cancels it too', (tester) async {
      final files = MemoryExportFiles();
      final repo = GatedDemoRepository();
      await pumpLoupe(tester, repository: repo, overrides: [exportFilesProvider.overrideWithValue(files)]);
      repo.gated = true;
      await _exportFolder(tester, settle: false);
      expect(find.byKey(const Key('export-status')), findsOneWidget);

      await systemBack(tester);
      expect(find.byKey(const Key('export-status')), findsNothing);
      expect(find.text('Mailboxes'), findsWidgets, reason: 'only the sheet closed');
      repo.release();
      await tester.pumpAndSettle();
      expect(repo.downloads, hasLength(1));
      expect(files.created.single.deleted, isTrue);
      expect(files.saved, isEmpty);
    });

    testWidgets('messages that can’t be downloaded are counted and reported at the end', (tester) async {
      final files = MemoryExportFiles();
      final repo = GatedDemoRepository();
      await pumpLoupe(tester, repository: repo, overrides: [exportFilesProvider.overrideWithValue(files)]);
      repo.failing.add((await demoMessages(repo, _folder)).first.id);

      await _exportFolder(tester);

      final total = (await demoMessages(repo, _folder)).length;
      expect(separators(utf8.decode(files.saved.single.bytes)), hasLength(total - 1));
      expect(
        find.text("Saved “Work - Notifications.mbox” without 1 message that couldn't be downloaded."),
        findsOneWidget,
      );
      await drainTimers(tester);
    });

    testWidgets('nothing is saved when no message could be downloaded, or the save dialog is cancelled', (
      tester,
    ) async {
      final files = MemoryExportFiles()..saveAnswer = false;
      final repo = GatedDemoRepository();
      await pumpLoupe(tester, repository: repo, overrides: [exportFilesProvider.overrideWithValue(files)]);

      await _exportFolder(tester);
      expect(files.saved, hasLength(1));
      expect(textContaining('Saved'), findsNothing);
      expect(files.created.last.deleted, isTrue);

      repo.failing.addAll([for (final m in await demoMessages(repo, _folder)) m.id]);
      await _exportFolder(tester);
      expect(files.saved, hasLength(1), reason: 'no second save dialog');
      expect(textContaining('no message could be downloaded'), findsOneWidget);
      expect(files.created.last.deleted, isTrue);
      await drainTimers(tester);
    });

    testWidgets('the command palette exports the list’s folder', (tester) async {
      final files = MemoryExportFiles();
      await pumpLoupe(tester, overrides: [exportFilesProvider.overrideWithValue(files)]);
      await goTo(tester, Routes.list(RealMailboxRef(_folder)));
      await press(tester, LogicalKeyboardKey.keyK, ctrl: true);
      await tester.enterText(find.byKey(const Key('palette-field')), 'export folder');
      await tester.pumpAndSettle();
      expect(find.text('Export Folder…'), findsOneWidget);
      await press(tester, LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(files.saved.single.name, 'Work - Notifications.mbox');
      await drainTimers(tester);
    });

    testWidgets('unified mailboxes have no Export Folder…', (tester) async {
      await pumpLoupe(tester);
      await goTo(tester, Routes.list(_allInboxes));
      await press(tester, LogicalKeyboardKey.keyK, ctrl: true);
      await tester.enterText(find.byKey(const Key('palette-field')), 'export folder');
      await tester.pumpAndSettle();
      expect(find.text('Export Folder…'), findsNothing);
    });
  });
}
