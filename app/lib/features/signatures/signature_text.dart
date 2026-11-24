import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';

/// What a signature is called in lists: its name, else its first line,
/// else "Signature 2" (by its place, [index] from 0).
String signatureLabel(AppLocalizations l10n, Signature s, int index) {
  if (s.name.trim().isNotEmpty) return s.name.trim();
  final first = s.plainText.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).firstOrNull;
  return first ?? l10n.settingsSignatureNumbered(index + 1);
}

/// When a signature is used, in a few words ("When copying *@client.example
/// · 1 Dec – 2 Jan · In rotation"); "Default" for the first ordinary one.
String signatureRuleSummary(AppLocalizations l10n, Signature s, {required bool isDefault}) {
  final r = s.rule;
  String day(DateTime d) => DateFormat.MMMd().format(d);
  final parts = [
    if (r.whenCopied)
      r.copied.isEmpty
          ? l10n.settingsSignatureWhenCopiedAnyone
          : l10n.settingsSignatureWhenCopying(r.copied.join(', ')),
    if (r.isScheduled)
      l10n.settingsSignatureBetween(r.from == null ? '…' : day(r.from!), r.until == null ? '…' : day(r.until!)),
    if (r.rotate) l10n.settingsSignatureInRotation,
  ];
  if (parts.isEmpty) return isDefault ? l10n.settingsSignatureDefault : '';
  return parts.join(' · ');
}
