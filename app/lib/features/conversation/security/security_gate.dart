import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../../l10n/l10n.dart';
import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import 'assessment.dart';
import 'finding_text.dart';
import 'security_provider.dart';
import 'security_sheet.dart';

/// Builds the message body once the check is done. [inert]: links and
/// remote content stay off (likely phishing, until "Show anyway").
typedef SecureBodyBuilder = Widget Function(
  BuildContext context, {
  required bool inert,
  required bool openLinksDirectly,
});

/// Puts the body behind the phishing check: a calm warning banner with
/// "Show anyway" above an inert body when the message is likely phishing.
/// While the check runs it shows [placeholder] (links must not be live
/// before the verdict); if the check fails the body shows as usual.
class SecurityGate extends ConsumerStatefulWidget {
  const SecurityGate({
    super.key,
    required this.message,
    required this.content,
    required this.builder,
    this.placeholder = const SizedBox.shrink(),
  });

  final EmailSummary message;
  final EmailContent content;
  final SecureBodyBuilder builder;
  final Widget placeholder;

  @override
  ConsumerState<SecurityGate> createState() => _SecurityGateState();
}

class _SecurityGateState extends ConsumerState<SecurityGate> {
  /// The user chose "Show anyway".
  bool _shown = false;

  @override
  void didUpdateWidget(SecurityGate old) {
    super.didUpdateWidget(old);
    if (old.message.id != widget.message.id) _shown = false;
  }

  @override
  Widget build(BuildContext context) {
    final direct = ref.watch(openLinksDirectlyProvider);
    final report = ref.watch(securityReportProvider(SecurityKey(widget.message, widget.content)));
    return switch (report) {
      AsyncData(:final value) when value.verdict == Verdict.likelyPhishing && !_shown => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhishingBanner(
            report: value,
            onWhy: () => showSecuritySheet(context, value),
            onShowAnyway: () => setState(() => _shown = true),
          ),
          const SizedBox(height: 16),
          widget.builder(context, inert: true, openLinksDirectly: direct),
        ],
      ),
      AsyncData() || AsyncError() => widget.builder(context, inert: false, openLinksDirectly: direct),
      _ => widget.placeholder,
    };
  }
}

/// "This message looks like phishing", calm: what the strongest sign is,
/// that links and images are off, Why and Show anyway.
class PhishingBanner extends StatelessWidget {
  const PhishingBanner({super.key, required this.report, required this.onWhy, required this.onShowAnyway});

  final SecurityReport report;
  final VoidCallback onWhy;
  final VoidCallback onShowAnyway;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final red = CupertinoColors.systemRed.resolveFrom(context);
    final l10n = context.l10n;
    final top = report.findings.firstOrNull;
    return Semantics(
      container: true,
      child: Container(
        key: const ValueKey('phishing-banner'),
        decoration: BoxDecoration(
          color: red.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: red.withValues(alpha: 0.25), width: 0.5),
        ),
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Icon(LoupeIcons.phishing, size: 20, color: red),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.conversationPhishingBannerTitle,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        top == null
                            ? l10n.conversationPhishingBannerText
                            : l10n.conversationPhishingBannerReason(findingText(l10n, top).title),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.secondaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                TextButton(onPressed: onWhy, child: Text(l10n.conversationPhishingWhy)),
                TextButton(
                  key: const ValueKey('show-anyway'),
                  onPressed: onShowAnyway,
                  child: Text(l10n.conversationPhishingShowAnyway),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
