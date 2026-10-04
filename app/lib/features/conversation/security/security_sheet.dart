import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import '../sheets.dart';
import 'assessment.dart';
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
    final (title, subtitle) = switch (report.verdict) {
      Verdict.likelyPhishing => (
        'This looks like phishing',
        "Several signs say this message isn't what it claims to be.",
      ),
      Verdict.beCareful => ('Be careful with this message', 'Something about it deserves a second look.'),
      Verdict.noIssues when report.verified => (
        'No issues found',
        'The sender is verified and nothing looks suspicious.',
      ),
      Verdict.noIssues => (
        'No issues found',
        report.auth.methods.isEmpty
            ? "Nothing looks suspicious. Your mail server didn't say whether the sender is verified."
            : 'Nothing looks suspicious.',
      ),
    };
    final privacy = report.privacy;
    final details = [
      ...report.technical,
      for (final f in report.findings)
        for (final d in f.details) (f.title, d),
      if (privacy.trackerHosts.isNotEmpty) ('Trackers', privacy.trackerHosts.join(', ')),
      if (privacy.remoteImageHosts.isNotEmpty) ('Images from', privacy.remoteImageHosts.join(', ')),
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
            header: 'Why',
            children: [for (final f in report.findings) _FindingRow(finding: f)],
          ),
        SheetGroup(
          header: 'Privacy',
          children: [
            _InfoRow(
              icon: LoupeIcons.trackers,
              title: privacy.trackers == 0
                  ? 'No tracking pixels'
                  : '${_count(privacy.trackers, 'tracking pixel')} removed',
              text: privacy.trackers == 0 ? null : 'They would have told the sender when you opened this message.',
            ),
            _InfoRow(
              icon: LoupeIcons.images,
              title: privacy.remoteImages == 0 ? 'No remote images' : _count(privacy.remoteImages, 'remote image'),
              text: privacy.remoteImages == 0
                  ? null
                  : 'Loading them tells the sender when you read this message, and your IP address.',
            ),
            _InfoRow(
              icon: LoupeIcons.redirect,
              title: privacy.trackedLinks == 0
                  ? 'No click tracking'
                  : '${_count(privacy.trackedLinks, 'link')} through click trackers',
              text: privacy.trackedLinks == 0
                  ? null
                  : '${privacy.trackingServices.join(', ')} would record your click. Long-press a link to open '
                        'its destination directly.',
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
                  title: const Text('Technical Details', style: TextStyle(fontSize: 16)),
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
            'Checked on this device. Nothing was sent anywhere.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
          ),
        ),
      ],
    );
  }

  static String _count(int n, String noun) => '$n ${n == 1 ? noun : '${noun}s'}';
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
    return _InfoRow(
      icon: icon,
      iconColor: color,
      title: finding.title,
      text: finding.explanation,
      advice: finding.advice,
    );
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
