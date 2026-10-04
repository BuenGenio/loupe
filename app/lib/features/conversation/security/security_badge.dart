import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../../theme/loupe_icons.dart';
import '../../../theme/theme.dart';
import 'assessment.dart';
import 'security_provider.dart';
import 'security_sheet.dart';

/// Colour and icon of each verdict.
({IconData icon, Color color, String label}) verdictStyle(BuildContext context, SecurityReport report) =>
    switch (report.verdict) {
      Verdict.likelyPhishing => (
        icon: LoupeIcons.phishing,
        color: CupertinoColors.systemRed.resolveFrom(context),
        label: 'Possible phishing',
      ),
      Verdict.beCareful => (
        icon: LoupeIcons.caution,
        color: CupertinoColors.systemOrange.resolveFrom(context),
        label: 'Be careful',
      ),
      Verdict.noIssues when report.verified => (
        icon: LoupeIcons.verified,
        color: CupertinoColors.systemGreen.resolveFrom(context),
        label: 'Verified',
      ),
      Verdict.noIssues => (
        icon: LoupeIcons.shield,
        color: LoupeColors.of(context).secondaryText,
        label: 'No issues found',
      ),
    };

/// Next to the sender: a green seal when the sender is verified and nothing
/// looks wrong, an amber "Be careful" or a red "Possible phishing", and a
/// small privacy shield with the number of trackers. Tapping it explains.
/// Nothing while the message loads.
class SecurityBadge extends ConsumerWidget {
  const SecurityBadge({super.key, required this.message, required this.content});

  final EmailSummary message;
  final EmailContent? content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = content;
    if (c == null) return const SizedBox.shrink();
    final report = ref.watch(securityReportProvider(SecurityKey(message, c))).value;
    if (report == null) return const SizedBox.shrink();
    return SecurityBadgeView(report: report, onTap: () => showSecuritySheet(context, report));
  }
}

/// The badge for a finished [report].
class SecurityBadgeView extends StatelessWidget {
  const SecurityBadgeView({super.key, required this.report, required this.onTap});

  final SecurityReport report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = verdictStyle(context, report);
    final colors = LoupeColors.of(context);
    final trackers = report.privacy.total;
    // With very large text the label would crowd out the sender's name.
    final iconOnly = MediaQuery.textScalerOf(context).scale(12) > 16;
    final mark = switch (report.verdict) {
      Verdict.likelyPhishing || Verdict.beCareful => Container(
        key: const ValueKey('security-pill'),
        padding: const EdgeInsets.fromLTRB(5, 2, 7, 2),
        decoration: BoxDecoration(color: style.color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(style.icon, size: 14, color: style.color),
            if (!iconOnly) ...[
              const SizedBox(width: 3),
              Text(
                style.label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: style.color),
              ),
            ],
          ],
        ),
      ),
      Verdict.noIssues when report.verified => Icon(style.icon, size: 16, color: style.color),
      Verdict.noIssues => null,
    };
    if (mark == null && trackers == 0) return const SizedBox.shrink();
    final label = [
      if (mark != null) style.label,
      if (trackers > 0) '$trackers ${trackers == 1 ? 'tracker' : 'trackers'}',
    ].join(', ');
    return Semantics(
      button: true,
      label: label,
      hint: 'Shows why',
      excludeSemantics: true,
      child: InkWell(
        key: const ValueKey('security-badge'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ?mark,
              if (mark != null && trackers > 0) const SizedBox(width: 6),
              if (trackers > 0) ...[
                Icon(LoupeIcons.trackers, size: 14, color: colors.secondaryText),
                const SizedBox(width: 2),
                Text('$trackers', style: TextStyle(fontSize: 12, color: colors.secondaryText)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
