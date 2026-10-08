import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../shared/format.dart';
import '../../shared/mailbox_display.dart';
import '../../theme/theme.dart';
import '../attachments/attachment_platform.dart';
import '../conversation/sheets.dart';
import 'export_files.dart';
import 'export_names.dart';
import 'folder_export.dart';

const _emlType = 'message/rfc822';
const _mboxType = 'application/mbox';

/// [message]'s raw source, as the server has it (encrypted mail stays
/// encrypted), as a file named after its subject; null after saying why not.
Future<AttachmentFile?> _messageFile(
  ScaffoldMessengerState messenger,
  AppLocalizations l10n,
  MailRepository repository,
  EmailSummary message,
) async {
  try {
    final raw = await repository.loadRawSource(message.id);
    return AttachmentFile(name: messageFileName(message.subject), mimeType: _emlType, bytes: raw);
  } on Exception catch (e) {
    showSnack(messenger, e is MailException ? e.message : l10n.exportDownloadFailed);
    return null;
  }
}

/// Save as File…: the system's save dialog for the message as
/// `<subject>.eml`, which other mail apps open.
Future<void> saveMessageAsFile(BuildContext context, WidgetRef ref, EmailSummary message) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final platform = ref.read(attachmentPlatformProvider);
  final file = await _messageFile(messenger, l10n, ref.read(repositoryProvider), message);
  if (file == null) return;
  try {
    if (await platform.save(file)) showSnack(messenger, l10n.exportSaved(file.name));
  } on Object {
    showSnack(messenger, l10n.exportSaveFailed);
  }
}

/// Share as File…: the same file, to another app.
Future<void> shareMessageAsFile(BuildContext context, WidgetRef ref, EmailSummary message) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final platform = ref.read(attachmentPlatformProvider);
  final file = await _messageFile(messenger, l10n, ref.read(repositoryProvider), message);
  if (file == null) return;
  try {
    await platform.share(file);
  } on Object {
    showSnack(messenger, l10n.conversationShareFailed);
  }
}

/// Export Folder…: every message of [mailbox], oldest first, as an mbox file
/// (`<account> - <folder>.mbox`). A sheet shows the progress, with Cancel;
/// then the system's save dialog asks where the file goes.
Future<void> exportFolder(BuildContext context, WidgetRef ref, Mailbox mailbox) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final files = ref.read(exportFilesProvider);
  final accounts = ref.read(accountsProvider).value ?? const <MailAccount>[];
  final account = accounts.where((a) => a.id == mailbox.accountId).firstOrNull;
  final folder = mailboxDisplayName(mailbox);
  final name = folderFileName(account?.displayName ?? '', folder);
  final export = FolderExport(repository: ref.read(repositoryProvider), files: files, mailbox: mailbox, fileName: name);
  final progress = ValueNotifier<ExportProgress>(const ExportProgress.listing());
  final job = export.run(
    onProgress: (p) {
      if (!export.isCancelled) progress.value = p;
    },
  );
  await showLoupeSheet<void>(
    context,
    dismissible: false,
    builder: (_) => _ExportSheet(folder: folder, progress: progress, job: job, onCancel: export.cancel),
  );

  final FolderExportResult? result;
  try {
    result = await job;
  } on MailException catch (e) {
    showSnack(messenger, e.message);
    return;
  } on Object {
    showSnack(messenger, l10n.exportFailed(folder));
    return;
  }
  if (result == null) return; // Cancelled.
  final file = result.file;
  if (file == null) {
    showSnack(messenger, l10n.exportEmpty(folder));
    return;
  }
  try {
    if (result.exported == 0) {
      showSnack(messenger, l10n.exportNothingDownloaded(folder));
      return;
    }
    if (await files.save(file, name: name, mimeType: _mboxType)) {
      showSnack(
        messenger,
        result.failed == 0
            ? l10n.exportSaved(name)
            : l10n.exportSavedWithout(result.failed, formatCount(result.failed), name),
        duration: result.failed == 0 ? null : const Duration(seconds: 8),
      );
    }
  } on Object {
    showSnack(messenger, l10n.exportSaveFileFailed(name));
  } finally {
    await file.delete();
  }
}

/// The progress of an export: what it is doing, a bar, and Cancel (Back
/// cancels too). Closes itself when [job] ends.
class _ExportSheet extends StatefulWidget {
  const _ExportSheet({required this.folder, required this.progress, required this.job, required this.onCancel});

  final String folder;
  final ValueListenable<ExportProgress> progress;
  final Future<Object?> job;
  final VoidCallback onCancel;

  @override
  State<_ExportSheet> createState() => _ExportSheetState();
}

class _ExportSheetState extends State<_ExportSheet> {
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    void close() {
      _finished = true;
      if (!mounted) return;
      final route = ModalRoute.of(context);
      if (route == null || !route.isActive) return;
      if (route.isCurrent) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).removeRoute(route);
      }
    }

    // The export's errors are reported once the sheet is gone.
    unawaited(widget.job.then<void>((_) => close(), onError: (Object _) => close()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final l10n = context.l10n;
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop && !_finished) widget.onCancel();
      },
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          child: ValueListenableBuilder<ExportProgress>(
            valueListenable: widget.progress,
            builder: (context, p, _) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.exportTitle(widget.folder),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: p.listing ? null : p.current / p.total,
                  borderRadius: BorderRadius.circular(2),
                ),
                const SizedBox(height: 10),
                Text(
                  p.listing ? l10n.exportListing : l10n.exportProgress(formatCount(p.current), formatCount(p.total)),
                  key: const Key('export-status'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.secondaryText),
                ),
                if (p.failed > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l10n.exportFailedCount(p.failed, formatCount(p.failed)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.destructive, fontSize: 13),
                    ),
                  ),
                const SizedBox(height: 8),
                TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
