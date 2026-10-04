import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../../shared/format.dart';
import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../attachment_icon.dart';
import '../attachment_type.dart';

/// A file the app doesn't show itself: its icon, name, type and size, with
/// "Open in…" (to another app) and Share.
class AttachmentDetailsCard extends StatelessWidget {
  const AttachmentDetailsCard({
    super.key,
    required this.attachment,
    required this.onOpenIn,
    required this.onShare,
    this.size,
    this.note,
    this.busy = false,
    this.action,
  });

  final Attachment attachment;
  final VoidCallback? onOpenIn;
  final VoidCallback? onShare;

  /// The exact size once downloaded; [Attachment.size] otherwise.
  final int? size;

  /// Why there's no preview, when it isn't just the type.
  final String? note;

  /// An action is downloading the file.
  final bool busy;

  /// What the app can do with this kind of file itself (import a certificate), above "Open in…".
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final a = attachment;
    final bytes = size ?? a.size;
    final type = describeFileType(a.mimeType, a.filename);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
        child: Column(
          key: const Key('attachment-details'),
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(attachmentIcon(a.mimeType, a.filename), size: 42, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              a.filename?.isNotEmpty == true ? a.filename! : 'Untitled',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: styles.body.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              bytes > 0 ? '$type · ${formatBytes(bytes)}' : type,
              textAlign: TextAlign.center,
              style: styles.footnote.copyWith(color: colors.secondaryText),
            ),
            if (note != null) ...[
              const SizedBox(height: 12),
              Text(
                note!,
                textAlign: TextAlign.center,
                style: styles.footnote.copyWith(color: colors.secondaryText),
              ),
            ],
            const SizedBox(height: 28),
            if (action != null) ...[action!, const SizedBox(height: 8)],
            SizedBox(
              width: 240,
              child: FilledButton.tonalIcon(
                onPressed: busy ? null : onOpenIn,
                icon: const Icon(LoupeIcons.openIn, size: 20),
                label: const Text('Open in…'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 240,
              child: TextButton.icon(
                onPressed: busy ? null : onShare,
                icon: const Icon(LoupeIcons.share, size: 20),
                label: const Text('Share'),
              ),
            ),
            SizedBox(
              height: 28,
              child: busy
                  ? const Center(
                      child: SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
