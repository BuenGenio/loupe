import 'package:flutter/material.dart';

/// "Images from example.com are blocked to protect your privacy", with
/// Load images and Always for this sender.
class RemoteContentBanner extends StatelessWidget {
  const RemoteContentBanner({super.key, this.senderDomain, required this.onLoad, this.onAlways});

  final String? senderDomain;
  final VoidCallback onLoad;

  /// Null hides "Always for this sender" (the host can't remember it).
  final VoidCallback? onAlways;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final domain = senderDomain;
    final title = domain == null || domain.isEmpty
        ? 'Images are blocked to protect your privacy'
        : 'Images from $domain are blocked to protect your privacy';
    return Semantics(
      container: true,
      child: Container(
        decoration: BoxDecoration(color: scheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(Icons.shield_outlined, size: 20, color: scheme.onSurfaceVariant),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 2),
                      Text(
                        'Loading them tells the sender when and where you opened this message.',
                        style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                if (onAlways != null) TextButton(onPressed: onAlways, child: const Text('Always for this sender')),
                TextButton(onPressed: onLoad, child: const Text('Load images')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
