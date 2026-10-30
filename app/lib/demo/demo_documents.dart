import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

/// The built-in demo's answer to `documents.facts` (DocumentFactsTask): a
/// few rules instead of a model. It decides the type from the file name and
/// a few telling labels, then reads "Label: value" lines, each field from
/// the line its own label starts, and quotes that line exactly with its page
/// number, so the task's parser checks the answer as it would a model's.
/// Values keep their currency and unit; words between a label and its
/// colon, or after a fee, are the qualifier. Fields it finds no line for
/// are null. It reads labels, not meaning: a document that labels things
/// differently gets fewer facts, never guessed ones.
String demoDocumentFacts(AiRequest request, DateTime now) {
  final Map<String, Object?> data;
  try {
    data = jsonDecode(request.input.split('\n').first) as Map<String, Object?>;
  } on FormatException {
    return jsonEncode({'type': 'other', 'fields': <String, Object?>{}});
  }
  final name = (data['file_name'] as String?) ?? '';
  final pages = [
    for (final p in (data['pages'] as List<Object?>?) ?? const [])
      if (p case {'page': final int number, 'text': final String text}) (number, text),
  ];
  final type = _typeOf(name, pages.map((p) => p.$2).join('\n'));
  final fields = <String, Object?>{for (final f in type.fields) f.json: null};
  for (final (field, rule) in _rules[type] ?? const <(FactField, _Rule)>[]) {
    fields[field.json] ??= _find(pages, rule);
  }
  return jsonEncode({'type': type.json, 'fields': fields});
}

DocumentType _typeOf(String name, String text) {
  final n = name.toLowerCase();
  if (n.contains('illustration') || RegExp(r'^Initial rate:', multiLine: true).hasMatch(text)) {
    return DocumentType.mortgageIllustration;
  }
  if (n.contains('invoice') || RegExp(r'^(Invoice\b|Amount due:)', multiLine: true).hasMatch(text)) {
    return DocumentType.invoice;
  }
  if (n.contains('booking') || RegExp(r'^Booking reference:', multiLine: true).hasMatch(text)) {
    return DocumentType.booking;
  }
  return DocumentType.other;
}

/// How to read one field: the line's label, and the value in what follows
/// it (all of it when [value] is null). Words between the label and its
/// colon ("Monthly payment initial period:", "VAT 20%:") are the qualifier;
/// otherwise [qualifier] picks one out of the rest of the line. [next] takes
/// the value from the line after the label's own.
final class _Rule {
  const _Rule(this.label, {this.value, this.qualifier, this.next = false});

  final String label;
  final RegExp? value;
  final RegExp? qualifier;
  final bool next;
}

final _amount = RegExp(r'(?:[A-Z]{3} |[£€$])\d[\d,]*(?:\.\d+)?');

/// Words after a figure: "GBP 1,499 payable on completion".
final _trailingNote = RegExp(r'(?<=\d )[a-z][a-z ]*[a-z]$');

final _rules = <DocumentType, List<(FactField, _Rule)>>{
  DocumentType.mortgageIllustration: [
    (
      FactField.initialRate,
      _Rule('Initial rate', value: RegExp(r'\d+(?:\.\d+)?%'), qualifier: RegExp(r'fixed for \d+ years?')),
    ),
    (FactField.ratePeriod, _Rule('Initial rate', value: RegExp(r'(?<=fixed for )\d+ years?'))),
    (FactField.monthlyPayment, _Rule('Monthly payment', value: _amount)),
    (FactField.term, _Rule('Term', value: RegExp(r'\d+ years?'))),
    (FactField.loanAmount, _Rule('Loan amount', value: _amount)),
    (FactField.arrangementFee, _Rule('Arrangement fee', value: _amount, qualifier: _trailingNote)),
    (FactField.valuationFee, _Rule('Valuation fee', value: _amount)),
    (FactField.brokerFee, _Rule('Broker fee', value: _amount)),
    (FactField.earlyRepaymentCharges, const _Rule('Early repayment charges', next: true)),
    (FactField.totalAmountPayable, _Rule('Total amount payable', value: _amount)),
  ],
  DocumentType.invoice: [
    (FactField.amountDue, _Rule('Amount due', value: _amount)),
    (FactField.currency, _Rule('Amount due', value: RegExp(r'[A-Z]{3}(?= \d)|[£€$](?=\d)'))),
    (FactField.dueDate, const _Rule('Due date')),
    (FactField.payee, const _Rule('Payee')),
    (FactField.reference, _Rule('Invoice', value: RegExp(r'[A-Z]+-?\d[\w-]*'))),
    (FactField.subtotal, _Rule('Subtotal', value: _amount)),
    (FactField.tax, _Rule('VAT', value: _amount)),
  ],
  DocumentType.booking: [
    (FactField.date, const _Rule('Date')),
    (FactField.time, _Rule('Time', value: RegExp(r'\d{1,2}[:.]\d{2}'))),
    (FactField.timeZone, _Rule('Time', value: RegExp(r'\b[A-Z][A-Za-z]* time\b|\b(?:UTC|GMT|BST|CET)\b'))),
    (FactField.reference, const _Rule('Booking reference')),
    (FactField.address, const _Rule('Property')),
    (FactField.person, _Rule('Valuer', value: RegExp(r'[^,]+'))),
  ],
};

/// The first line of [pages] that [rule] reads, as the task's field object.
Map<String, Object?>? _find(List<(int, String)> pages, _Rule rule) {
  final label = RegExp.escape(rule.label);
  final withColon = RegExp('^$label\\b([^:]*):\\s*(.*)\$');
  final bare = RegExp('^$label\\b\\s*(.*)\$');
  for (final (number, text) in pages) {
    final lines = text.split('\n');
    for (final (i, raw) in lines.indexed) {
      final line = raw.trim();
      final colon = withColon.firstMatch(line);
      final plain = colon == null ? bare.firstMatch(line) : null;
      if (colon == null && plain == null) continue;
      if (rule.next) {
        if (i + 1 >= lines.length || lines[i + 1].trim().isEmpty) continue;
        final value = lines[i + 1].trim();
        return {'value': value, 'qualifier': null, 'page': number, 'quote': '$line $value'};
      }
      final before = (colon?.group(1) ?? '').replaceAll(RegExp(r'[()]'), '').trim();
      final rest = (colon?.group(2) ?? plain!.group(1)!).trim();
      final value = rule.value == null ? rest : rule.value!.firstMatch(rest)?.group(0)?.trim();
      if (value == null || value.isEmpty) continue;
      final note = before.isNotEmpty ? before : rule.qualifier?.firstMatch(rest)?.group(0);
      return {'value': value, 'qualifier': note, 'page': number, 'quote': line};
    }
  }
  return null;
}
