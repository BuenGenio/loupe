import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../sheets.dart';
import 'assessment.dart';
import 'finding_text.dart';
import 'security_badge.dart';

/// "Why this looks suspicious": the verdict, the findings worst first with
/// what they mean and what to do, the privacy report, and the technical
/// details collapsed.
Future<void> showSecuritySheet(BuildContext context, SecurityReport report) =>
    showLoupeSheet<void>(context, expand: true, builder: (context) => SecuritySheet(report: report));

class SecuritySheet extends StatelessWidget {
  const SecuritySheet({super.key, required this.report});

  final SecurityReport report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final style = verdictStyle(context, report);
    final l10n = context.l10n;
    final (title, subtitle) = switch (report.verdict) {
      Verdict.likelyPhishing => (l10n.conversationSecurityPhishingTitle, l10n.conversationSecurityPhishingText),
      Verdict.beCareful => (l10n.conversationSecurityCarefulTitle, l10n.conversationSecurityCarefulText),
      Verdict.noIssues when report.verified => (
        l10n.conversationSecurityNoIssues,
        l10n.conversationSecurityVerifiedText,
      ),
      Verdict.noIssues => (
        l10n.conversationSecurityNoIssues,
        report.auth.methods.isEmpty
            ? l10n.conversationSecurityUnverifiedText
            : l10n.conversationSecurityNothingSuspicious,
      ),
    };
    final privacy = report.privacy;
    final history = report.senderHistory;
    final details = [
      ...report.technical,
      if (history != null)
        (
          l10n.conversationSecuritySenderHistory,
          l10n.conversationSecuritySenderHistoryValue(history.received, history.sent),
        ),
      if (report.linkHosts.isNotEmpty) (l10n.conversationSecurityLinksLeadTo, report.linkHosts.join(', ')),
      if (report.hiddenElements > 0)
        (
          l10n.conversationSecurityHidden,
          l10n.conversationSecurityHiddenValue(report.hiddenElements, report.hiddenCharacters),
        ),
      for (final f in report.findings)
        if (findingText(l10n, f) case final text)
          for (final d in text.details) (text.title, d),
      if (privacy.trackerHosts.isNotEmpty) (l10n.conversationSecurityTrackersLabel, privacy.trackerHosts.join(', ')),
      if (privacy.remoteImageHosts.isNotEmpty)
        (l10n.conversationSecurityImagesFrom, privacy.remoteImageHosts.join(', ')),
    ];
    return ListView(
      key: const ValueKey('security-sheet'),
      primary: true,
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: Column(
            children: [
              Icon(style.icon, size: 44, color: style.color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: colors.secondaryText),
              ),
            ],
          ),
        ),
        if (report.findings.isNotEmpty)
          SheetGroup(
            header: l10n.conversationSecurityWhy,
            children: [for (final f in report.findings) _FindingRow(finding: f)],
          ),
        SheetGroup(
          header: l10n.conversationSecurityPrivacy,
          children: [
            _InfoRow(
              icon: LoupeIcons.trackers,
              title: privacy.trackers == 0
                  ? l10n.conversationSecurityNoTrackingPixels
                  : l10n.conversationSecurityTrackingPixels(privacy.trackers),
              text: privacy.trackers == 0 ? null : l10n.conversationSecurityTrackingPixelsText,
            ),
            _InfoRow(
              icon: LoupeIcons.images,
              title: privacy.remoteImages == 0
                  ? l10n.conversationSecurityNoRemoteImages
                  : l10n.conversationSecurityRemoteImages(privacy.remoteImages),
              text: privacy.remoteImages == 0 ? null : l10n.conversationSecurityRemoteImagesText,
            ),
            _InfoRow(
              icon: LoupeIcons.redirect,
              title: privacy.trackedLinks == 0
                  ? l10n.conversationSecurityNoClickTracking
                  : l10n.conversationSecurityTrackedLinks(privacy.trackedLinks),
              text: privacy.trackedLinks == 0
                  ? null
                  : l10n.conversationSecurityTrackedLinksText(privacy.trackingServices.join(', ')),
            ),
          ],
        ),
        if (details.isNotEmpty)
          SheetGroup(
            children: [
              Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: const ValueKey('security-technical'),
                  title: Text(l10n.conversationSecurityTechnicalDetails, style: const TextStyle(fontSize: 16)),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (label, value) in details)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: colors.secondaryText)),
                            SelectableText(value, style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Text(
            l10n.conversationSecurityCheckedLocally,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
          ),
        ),
      ],
    );
  }
}

class _FindingRow extends StatelessWidget {
  const _FindingRow({required this.finding});
  final Finding finding;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (finding.severity) {
      Severity.danger => (LoupeIcons.phishing, CupertinoColors.systemRed.resolveFrom(context)),
      Severity.warning => (LoupeIcons.warning, CupertinoColors.systemOrange.resolveFrom(context)),
      Severity.info => (LoupeIcons.info, LoupeColors.of(context).secondaryText),
    };
    final text = findingText(context.l10n, finding);
    return _InfoRow(icon: icon, iconColor: color, title: text.title, text: text.explanation, advice: text.advice);
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, this.text, this.advice, this.iconColor});

  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? text;
  final String? advice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: iconColor ?? colors.secondaryText),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
                if (text != null) ...[const SizedBox(height: 2), Text(text!, style: theme.textTheme.bodyMedium)],
                if (advice != null) ...[
                  const SizedBox(height: 4),
                  Text(advice!, style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
