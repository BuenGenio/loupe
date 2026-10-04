// What happens when a link is tapped or long-pressed: the mismatch warning,
// and the sheet that shows the real URL.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/document.dart';

/// Opens [link] through [onOpen], after a warning if its text names another
/// domain. Does nothing when [onOpen] is null (inert links).
Future<void> openLink(BuildContext context, LinkRef link, void Function(Uri uri)? onOpen) async {
  if (onOpen == null) return;
  final uri = Uri.tryParse(link.url);
  if (uri == null) return;
  if (link.isMismatch) {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => LinkMismatchDialog(link: link, uri: uri),
    );
    if (ok != true) return;
  }
  onOpen(uri);
}

/// "This link goes somewhere else" warning.
class LinkMismatchDialog extends StatelessWidget {
  const LinkMismatchDialog({super.key, required this.link, required this.uri});
  final LinkRef link;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      icon: Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error),
      title: const Text('Check this link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'The link text shows '),
                TextSpan(
                  text: link.namedDomain,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: ', but it opens '),
                TextSpan(
                  text: uri.host,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            link.url,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Open anyway')),
      ],
    );
  }
}

/// Long-press sheet: the real URL, Copy, Open (and View image for linked
/// images).
Future<void> showLinkSheet(
  BuildContext context,
  LinkRef link, {
  void Function(Uri uri)? onOpen,
  VoidCallback? onViewImage,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      final uri = Uri.tryParse(link.url);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (uri != null && uri.host.isNotEmpty) Text(uri.host, style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              SelectableText(
                link.url,
                maxLines: 6,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              if (link.isMismatch) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 18, color: theme.colorScheme.error),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'The link text shows ${link.namedDomain}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  if (onViewImage != null)
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        onViewImage();
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('View image'),
                    ),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: link.url));
                      Navigator.of(sheetContext).pop();
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Copy'),
                  ),
                  if (onOpen != null && uri != null)
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        onOpen(uri);
                      },
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text('Open'),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
