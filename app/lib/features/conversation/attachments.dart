import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../router.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../attachments/attachment_actions.dart';
import '../attachments/attachment_cache.dart';
import '../attachments/attachment_gallery.dart';
import '../attachments/attachment_icon.dart';
import '../attachments/attachment_type.dart';
import '../calendar/invitation.dart' show isCalendarAlternative;
import 'sheets.dart';

export '../attachments/attachment_gallery.dart' show AttachmentImage;
export '../attachments/attachment_icon.dart' show attachmentIcon;

/// The attachment list under a message body. A tap opens an attachment:
/// images in the gallery (over all images of the message), everything else
/// in the attachment viewer. The ⋯ button (or a long press) offers Open in…,
/// Save and Share.
class AttachmentList extends ConsumerWidget {
  const AttachmentList({super.key, required this.content, required this.load});

  final EmailContent content;

  /// Downloads an attachment's bytes; the session's attachment cache keeps them.
  final Future<Uint8List> Function(Attachment attachment) load;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // An invitation's text/calendar alternative is the card above the body.
    final items = content.visibleAttachments.where((a) => !isCalendarAlternative(a)).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          for (final a in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AttachmentTile(
                emailId: content.emailId,
                attachment: a,
                load: () => load(a),
                onOpen: () => _open(context, ref, a),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref, Attachment a) async {
    if (attachmentKindOf(a.mimeType, a.filename) == AttachmentKind.image) {
      await openAttachmentGallery(
        context,
        content: content,
        current: a,
        cache: ref.read(attachmentCacheProvider),
        download: load,
      );
    } else {
      await context.push(Routes.attachment(content.emailId, a.partId));
    }
  }
}

/// One attachment: icon, name and size, and a ⋯ button for its actions.
class AttachmentTile extends ConsumerStatefulWidget {
  const AttachmentTile({
    super.key,
    required this.emailId,
    required this.attachment,
    required this.load,
    required this.onOpen,
  });

  final String emailId;
  final Attachment attachment;
  final Future<Uint8List> Function() load;

  /// Opens the attachment (gallery or viewer).
  final Future<void> Function() onOpen;

  @override
  ConsumerState<AttachmentTile> createState() => _AttachmentTileState();
}

class _AttachmentTileState extends ConsumerState<AttachmentTile> {
  final _moreKey = GlobalKey();
  bool _busy = false;

  Attachment get _a => widget.attachment;

  Future<void> _actions() async {
    final box = _moreKey.currentContext?.findRenderObject();
    final origin = box is RenderBox && box.hasSize ? box.localToGlobal(Offset.zero) & box.size : null;
    await showAttachmentActions(
      context,
      AttachmentActions.of(ref, widget.emailId, _a, download: widget.load),
      origin: origin,
      onBusy: (busy) {
        if (mounted) setState(() => _busy = busy);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final name = _a.filename?.isNotEmpty == true ? _a.filename! : 'Untitled';
    return Material(
      color: subtleFill(context),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _busy ? null : widget.onOpen,
        onLongPress: _busy ? null : _actions,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(attachmentIcon(_a.mimeType, _a.filename), color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium),
                    if (_a.size > 0)
                      Text(
                        formatBytes(_a.size),
                        style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
                      ),
                  ],
                ),
              ),
              if (_busy)
                const SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                )
              else
                Tooltip(
                  message: 'More',
                  excludeFromSemantics: true,
                  child: Semantics(
                    container: true,
                    label: 'More actions for $name',
                    child: CupertinoButton(
                      key: _moreKey,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 44),
                      onPressed: _actions,
                      child: Icon(LoupeIcons.more, size: 22, color: colors.secondaryText),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
