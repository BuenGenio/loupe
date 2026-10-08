import 'dart:typed_data';

import 'package:mail_imap/mbox.dart';
import 'package:mail_model/mail_model.dart';

import 'export_files.dart';

/// How far a [FolderExport] is.
final class ExportProgress {
  const ExportProgress.listing() : current = 0, total = 0, failed = 0;
  const ExportProgress.exporting({required this.current, required this.total, this.failed = 0});

  /// The message being exported (1-based); 0 while the folder's messages
  /// are still being found.
  final int current;
  final int total;

  /// Messages that couldn't be downloaded so far.
  final int failed;

  bool get listing => total == 0;
}

/// What a finished [FolderExport] wrote.
final class FolderExportResult {
  const FolderExportResult({required this.file, required this.exported, required this.failed});

  /// The mbox file; null when the folder is empty.
  final ExportFile? file;
  final int exported;

  /// Messages left out because they couldn't be downloaded.
  final int failed;
}

/// Every message of [mailbox], oldest first, as an mbox file (mboxrd).
///
/// Messages older than those on the phone are listed from the server first
/// (as scrolling to the end would), then each raw message is downloaded and
/// appended to a file in the cache, so the folder is never held in memory.
/// A message that can't be downloaded is counted and left out. After
/// [giveUpAfter] such messages in a row (the connection is gone, and each
/// try may wait for a timeout) the rest count as not downloaded, and what
/// was written is kept. A folder that can't be listed, or a file that can't
/// be written, ends the export with the error.
class FolderExport {
  FolderExport({required this.repository, required this.files, required this.mailbox, required this.fileName});

  final MailRepository repository;
  final ExportFiles files;
  final Mailbox mailbox;
  final String fileName;

  bool _cancelled = false;

  bool get isCancelled => _cancelled;

  /// Stops after the message being downloaded; [run] then deletes the file
  /// and returns null.
  void cancel() => _cancelled = true;

  static const giveUpAfter = 10;

  /// The list would stop at a page; a folder has fewer messages than this.
  static const _everything = 1 << 30;

  Future<FolderExportResult?> run({void Function(ExportProgress progress)? onProgress}) async {
    final ref = RealMailboxRef(mailbox.id);
    onProgress?.call(const ExportProgress.listing());
    while (!_cancelled && await repository.loadOlder(ref)) {}
    if (_cancelled) return null;
    final rows = await repository.watchList(ref, threaded: false, limit: _everything).first;
    if (_cancelled) return null;
    // The list is newest first.
    final emails = [for (final row in rows.reversed) row.latest];
    if (emails.isEmpty) return const FolderExportResult(file: null, exported: 0, failed: 0);

    final file = await files.create(fileName);
    var exported = 0;
    var failed = 0;
    var inARow = 0;
    try {
      for (final (i, email) in emails.indexed) {
        if (_cancelled) break;
        if (inARow >= giveUpAfter) {
          failed += emails.length - i;
          break;
        }
        onProgress?.call(ExportProgress.exporting(current: i + 1, total: emails.length, failed: failed));
        final Uint8List raw;
        try {
          raw = await repository.loadRawSource(email.id);
        } on Exception {
          failed++;
          inARow++;
          continue;
        }
        inARow = 0;
        if (_cancelled) break;
        await file.write(mboxrdEntry(raw, date: email.receivedAt));
        exported++;
      }
      await file.close();
    } on Object {
      await file.delete();
      rethrow;
    }
    if (_cancelled) {
      await file.delete();
      return null;
    }
    onProgress?.call(ExportProgress.exporting(current: emails.length, total: emails.length, failed: failed));
    return FolderExportResult(file: file, exported: exported, failed: failed);
  }
}
