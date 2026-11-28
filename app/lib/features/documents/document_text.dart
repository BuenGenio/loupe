import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';

import '../../l10n/l10n.dart';
import '../../theme/theme.dart';
import 'document_versions.dart';

/// Why a document isn't fully searchable, or null when it is.
String? documentStatusText(ExtractedDocument? doc, AppLocalizations l10n) {
  if (doc == null) return l10n.documentsStatusNotDownloaded;
  return switch (doc.status) {
    ExtractionStatus.complete => null,
    ExtractionStatus.partial when doc.pageCount != null && doc.pageCount! > 1 => l10n.documentsStatusPartial(
      doc.pagesRead,
      doc.pageCount!,
    ),
    ExtractionStatus.partial => l10n.documentsStatusPartialText,
    ExtractionStatus.noText when doc.format != DocumentFormat.pdf => l10n.documentsStatusEmpty,
    ExtractionStatus.noText => l10n.documentsStatusNoText,
    ExtractionStatus.encrypted => l10n.documentsStatusEncrypted,
    ExtractionStatus.unsupported => l10n.documentsStatusUnsupported,
    ExtractionStatus.tooLarge => l10n.documentsStatusTooLarge,
    ExtractionStatus.damaged => l10n.documentsStatusDamaged,
  };
}

/// A copy's date, short: "28 Oct".
String copyDate(DateTime date) => DateFormat.MMMd().format(date.toLocal());

/// How [c] compares, in one line.
String copyNote(CopyComparison c, AppLocalizations l10n) {
  final date = copyDate(c.other.email.receivedAt);
  return switch (c.relation) {
    CopyRelation.same => l10n.documentsVersionSame(date),
    CopyRelation.different when c.otherIsEarlier => l10n.documentsVersionDifferentEarlier(date),
    CopyRelation.different => l10n.documentsVersionDifferentLater(date),
    CopyRelation.notCompared => l10n.documentsVersionNotDownloaded(date),
  };
}

String documentTypeLabel(DocumentType type, AppLocalizations l10n) => switch (type) {
  DocumentType.mortgageIllustration => l10n.documentsTypeMortgageIllustration,
  DocumentType.invoice => l10n.documentsTypeInvoice,
  DocumentType.booking => l10n.documentsTypeBooking,
  DocumentType.other => l10n.documentsTypeOther,
};

String factFieldLabel(FactField field, AppLocalizations l10n) => switch (field) {
  FactField.initialRate => l10n.documentsFieldInitialRate,
  FactField.ratePeriod => l10n.documentsFieldRatePeriod,
  FactField.monthlyPayment => l10n.documentsFieldMonthlyPayment,
  FactField.term => l10n.documentsFieldTerm,
  FactField.loanAmount => l10n.documentsFieldLoanAmount,
  FactField.arrangementFee => l10n.documentsFieldArrangementFee,
  FactField.valuationFee => l10n.documentsFieldValuationFee,
  FactField.brokerFee => l10n.documentsFieldBrokerFee,
  FactField.earlyRepaymentCharges => l10n.documentsFieldEarlyRepaymentCharges,
  FactField.totalAmountPayable => l10n.documentsFieldTotalAmountPayable,
  FactField.amountDue => l10n.documentsFieldAmountDue,
  FactField.currency => l10n.documentsFieldCurrency,
  FactField.dueDate => l10n.documentsFieldDueDate,
  FactField.payee => l10n.documentsFieldPayee,
  FactField.reference => l10n.documentsFieldReference,
  FactField.subtotal => l10n.documentsFieldSubtotal,
  FactField.tax => l10n.documentsFieldTax,
  FactField.date => l10n.documentsFieldDate,
  FactField.time => l10n.documentsFieldTime,
  FactField.timeZone => l10n.documentsFieldTimeZone,
  FactField.address => l10n.documentsFieldAddress,
  FactField.person => l10n.documentsFieldPerson,
};

/// [text] with [start]–[end] marked, as search results and evidence show
/// a passage: bold on a tint of the accent colour.
class HighlightedText extends StatelessWidget {
  const HighlightedText(
    this.text, {
    super.key,
    required this.start,
    required this.end,
    this.style,
    this.maxLines,
    this.selectable = false,
  });

  final String text;
  final int start;
  final int end;
  final TextStyle? style;
  final int? maxLines;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final base = style ?? LoupeTextStyles.of(context).body;
    final s = start.clamp(0, text.length), e = end.clamp(s, text.length);
    final span = TextSpan(
      style: base,
      children: [
        TextSpan(text: text.substring(0, s)),
        TextSpan(
          text: text.substring(s, e),
          style: TextStyle(fontWeight: FontWeight.w600, backgroundColor: colors.unreadDot.withValues(alpha: 0.22)),
        ),
        TextSpan(text: text.substring(e)),
      ],
    );
    if (selectable) return SelectableText.rich(span);
    return Text.rich(span, maxLines: maxLines, overflow: maxLines == null ? null : TextOverflow.ellipsis);
  }
}
