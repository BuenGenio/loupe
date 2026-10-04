// What happens when a link is tapped or long-pressed: the mismatch and
// look-alike warnings, and the sheet that shows where a link really goes.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/document.dart';
import '../pipeline/hosts.dart';
import 'icons.dart';

/// Opens [link] through [onOpen], after a warning if its text names another
/// domain or its host imitates another one. With [direct], a known click
/// tracker with a known destination is skipped. Does nothing when [onOpen]
/// is null (inert links).
Future<void> openLink(BuildContext context, LinkRef link, void Function(Uri uri)? onOpen, {bool direct = false}) async {
  if (onOpen == null) return;
  final skip = direct && (link.redirect?.skippable ?? false);
  final uri = Uri.tryParse(skip ? link.direct! : link.url);
  if (uri == null) return;
  final host = inspectHost(uri.host);
  if (link.isMismatch || host.homograph) {
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
    final host = inspectHost(uri.host);
    const bold = TextStyle(fontWeight: FontWeight.w600);
    return AlertDialog(
      icon: Icon(ReadableIcons.warning, color: theme.colorScheme.error),
      title: const Text('Check this link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (link.isMismatch)
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'The link text shows '),
                  TextSpan(text: link.namedDomain, style: bold),
                  const TextSpan(text: ', but it opens '),
                  TextSpan(text: host.display, style: bold),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          if (host.homograph) ...[if (link.isMismatch) const SizedBox(height: 8), Text(homographWarning(host))],
          const SizedBox(height: 12),
          Text(
            uri.toString(),
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

/// One sentence about a look-alike host.
String homographWarning(HostInfo host) => host.looksLike == null
    ? '${host.display} mixes letters from different alphabets, a trick to imitate another address.'
    : '${host.display} uses look-alike letters: it is not ${host.looksLike}.';

/// Long-press sheet: where the link really goes (the destination of a click
/// tracker or link filter), Copy, Open original and Open directly (and View
/// image for linked images). [inert] links can't be opened.
Future<void> showLinkSheet(
  BuildContext context,
  LinkRef link, {
  void Function(Uri uri)? onOpen,
  VoidCallback? onViewImage,
  bool inert = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: LinkSheetContent(link: link, onOpen: onOpen, onViewImage: onViewImage, inert: inert),
      ),
    ),
  );
}

class LinkSheetContent extends StatelessWidget {
  const LinkSheetContent({super.key, required this.link, this.onOpen, this.onViewImage, this.inert = false});

  final LinkRef link;
  final void Function(Uri uri)? onOpen;
  final VoidCallback? onViewImage;
  final bool inert;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final uri = Uri.tryParse(link.url);
    final redirect = link.redirect;
    final direct = link.direct;
    final directUri = direct == null ? null : Uri.tryParse(direct);
    // Known redirects are titled by their destination; anything else by the
    // host the link really opens.
    final shownHost = directUri?.host ?? uri?.host;
    final host = shownHost == null || shownHost.isEmpty ? null : inspectHost(shownHost);
    final linkHost = uri == null || uri.host.isEmpty ? null : inspectHost(uri.host);
    final copyText = direct ?? link.url;

    void close() => Navigator.of(context).pop();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (host != null) Text(host.display, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        if (redirect == null)
          SelectableText(
            link.url,
            maxLines: 6,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          )
        else ...[
          if (redirect.resolved)
            Text.rich(
              key: const ValueKey('link-opens'),
              TextSpan(
                children: [
                  TextSpan(
                    text: redirect.known ? 'Opens: ' : 'Probably opens: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: direct ?? redirect.target),
                ],
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            )
          else
            Text(
              _hiddenDestination(redirect.service, redirect.hostHint),
              key: const ValueKey('link-hidden'),
              style: theme.textTheme.bodyMedium,
            ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(ReadableIcons.redirect, size: 16, color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  redirect.known
                      ? 'Through ${redirect.services.join(', then ')}'
                      : 'Through ${linkHost?.display ?? redirect.service}',
                  style: secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SelectableText(link.url, maxLines: 3, style: secondary),
        ],
        if (link.isMismatch) _Warning('The link text shows ${link.namedDomain}', key: const ValueKey('link-mismatch')),
        for (final h in [?host, if (linkHost?.host != host?.host) ?linkHost])
          if (h.homograph)
            _Warning(homographWarning(h))
          else if (h.ipAddress)
            _Warning('${h.display} is an IP address, not a named website'),
        if (inert) _Note('Links in this message are turned off.', key: const ValueKey('link-inert')),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            if (onViewImage != null)
              TextButton.icon(
                onPressed: () {
                  close();
                  onViewImage!();
                },
                icon: const Icon(ReadableIcons.image),
                label: const Text('View image'),
              ),
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: copyText));
                close();
              },
              icon: const Icon(ReadableIcons.copy),
              label: const Text('Copy'),
            ),
            if (onOpen != null && uri != null && directUri != null) ...[
              TextButton(
                onPressed: () {
                  close();
                  onOpen!(uri);
                },
                child: const Text('Open original'),
              ),
              FilledButton.icon(
                onPressed: () {
                  close();
                  onOpen!(directUri);
                },
                icon: const Icon(ReadableIcons.open),
                label: const Text('Open directly'),
              ),
            ] else if (onOpen != null && uri != null)
              FilledButton.icon(
                onPressed: () {
                  close();
                  onOpen!(uri);
                },
                icon: const Icon(ReadableIcons.open),
                label: const Text('Open'),
              ),
          ],
        ),
      ],
    );
  }

  static String _hiddenDestination(String service, String? hint) => hint == null
      ? "Goes through $service's click tracker. The final address isn't in the link."
      : 'Leads to a page on $hint, through $service.';
}

class _Warning extends StatelessWidget {
  const _Warning(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ReadableIcons.warning, size: 18, color: theme.colorScheme.error),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error)),
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(ReadableIcons.linkOff, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}
