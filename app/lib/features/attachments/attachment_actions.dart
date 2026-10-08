import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../conversation/sheets.dart';
import 'attachment_cache.dart';
import 'attachment_platform.dart';
import 'attachment_type.dart';

/// Share, "Open in…" and Save for one attachment, each downloading it first
/// (once per session, through the cache) and reporting problems in a snack
/// bar.
final class AttachmentActions {
  const AttachmentActions({
    required this.cache,
    required this.platform,
    required this.emailId,
    required this.attachment,
    this.download,
  });

  /// Reads the providers now, so the actions keep working after the widget
  /// that started them is gone.
  factory AttachmentActions.of(
    WidgetRef ref,
    String emailId,
    Attachment attachment, {
    Future<Uint8List> Function()? download,
  }) => AttachmentActions(
    cache: ref.read(attachmentCacheProvider),
    platform: ref.read(attachmentPlatformProvider),
    emailId: emailId,
    attachment: attachment,
    download: download,
  );

  final AttachmentCache cache;
  final AttachmentPlatform platform;
  final String emailId;
  final Attachment attachment;

  /// Replaces the repository as the source of the bytes.
  final Future<Uint8List> Function()? download;

  /// The name other apps and the save dialog get.
  String get fileName => safeFileName(attachment.filename, attachment.mimeType);

  Future<AttachmentFile> _file() async {
    final bytes = await cache.bytes(emailId, attachment, download: download);
    final file = await cache.file(emailId, attachment);
    return AttachmentFile(
      name: fileName,
      mimeType: effectiveMimeType(attachment.mimeType, attachment.filename),
      bytes: bytes,
      path: file?.path,
    );
  }

  static String _downloadError(Object e, AppLocalizations l10n) =>
      e is MailException ? e.message : l10n.attachmentsDownloadError;

  /// The share sheet; [origin] anchors it on tablets.
  Future<void> share(ScaffoldMessengerState messenger, AppLocalizations l10n, {Rect? origin}) async {
    final AttachmentFile file;
    try {
      file = await _file();
    } on Object catch (e) {
      showSnack(messenger, _downloadError(e, l10n));
      return;
    }
    try {
      await platform.share(file, origin: origin);
    } on Object {
      showSnack(messenger, l10n.attachmentsShareError);
    }
  }

  /// Hands the file to another app.
  Future<void> openIn(ScaffoldMessengerState messenger, AppLocalizations l10n) async {
    final AttachmentFile file;
    try {
      file = await _file();
    } on Object catch (e) {
      showSnack(messenger, _downloadError(e, l10n));
      return;
    }
    try {
      switch (await platform.openIn(file)) {
        case OpenInResult.opened:
          break;
        case OpenInResult.noApp:
          final type = describeFileType(attachment.mimeType, attachment.filename, l10n: l10n);
          showSnack(messenger, l10n.attachmentsNoApp(type));
        case OpenInResult.failed:
          showSnack(messenger, l10n.attachmentsOpenInError);
      }
    } on Object {
      showSnack(messenger, l10n.attachmentsOpenInError);
    }
  }

  /// Asks where to save (Downloads by default) and saves there.
  Future<void> save(ScaffoldMessengerState messenger, AppLocalizations l10n) async {
    final AttachmentFile file;
    try {
      file = await _file();
    } on Object catch (e) {
      showSnack(messenger, _downloadError(e, l10n));
      return;
    }
    try {
      if (await platform.save(file)) showSnack(messenger, l10n.attachmentsSaved(file.name));
    } on Object {
      showSnack(messenger, l10n.attachmentsSaveError);
    }
  }
}

enum _Action { openIn, save, share }

/// The attachment's action sheet: Open in…, Save and Share. [onBusy] hears
/// when the chosen action starts (true) and ends (false).
Future<void> showAttachmentActions(
  BuildContext context,
  AttachmentActions actions, {
  Rect? origin,
  ValueChanged<bool>? onBusy,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final choice = await showActionSheet<_Action>(
    context,
    title: actions.attachment.filename ?? l10n.attachmentsUntitled,
    actions: [
      SheetAction(l10n.attachmentsOpenIn, _Action.openIn),
      SheetAction(l10n.attachmentsSaveToFiles, _Action.save),
      SheetAction(l10n.attachmentsShareMenu, _Action.share),
    ],
  );
  if (choice == null) return;
  onBusy?.call(true);
  try {
    switch (choice) {
      case _Action.openIn:
        await actions.openIn(messenger, l10n);
      case _Action.save:
        await actions.save(messenger, l10n);
      case _Action.share:
        await actions.share(messenger, l10n, origin: origin);
    }
  } finally {
    onBusy?.call(false);
  }
}
