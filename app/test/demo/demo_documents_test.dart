import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/demo/demo_private_ai.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_documents/mail_documents.dart';

void main() {
  final now = DateTime(2026, 10, 30, 16);
  final seed = DemoSeed.build(now);

  /// Every PDF, text and CSV attachment of the demo mailbox, read by the
  /// extractor as the app reads it.
  final documents = [
    for (final m in seed.messages)
      for (final a in m.attachments)
        if (a.generate != null && documentFormatOf(a.attachment.mimeType, a.attachment.filename) != null)
          (
            m,
            a.attachment.filename!,
            readDocument(a.generate!(), mimeType: a.attachment.mimeType, fileName: a.attachment.filename),
          ),
  ];

  Future<DocumentFacts> facts(String name, {String? containing}) async {
    final (_, _, doc) = documents.firstWhere(
      (d) => d.$2 == name && (containing == null || d.$3.pages.any((p) => p.text.contains(containing))),
    );
    final task = DocumentFactsTask(DocumentFactsInput(fileName: name, pages: [for (final p in doc.pages) p.text]));
    final run = await AiRunner(DemoAiProvider(now: () => now)).run(task);
    if (run is AiFailure<DocumentFacts>) fail('$name: ${run.message}');
    return (run as AiSuccess<DocumentFacts>).value;
  }

  test('every demo document is read completely, page by page', () {
    expect(documents.length, greaterThanOrEqualTo(12));
    for (final (_, name, doc) in documents) {
      expect(doc.status, ExtractionStatus.complete, reason: name);
      expect(doc.searchable, isTrue, reason: name);
    }
    final (_, _, plan) = documents.firstWhere((d) => d.$2 == 'Offsite_plan.pdf');
    expect(plan.pageCount, 3);
    expect(plan.pages[1].text, contains('14:00 Roadmap workshop'));
  });

  test('the two illustrations: same name, different bytes, and Key Facts that differ', () async {
    final illustrations = documents.where((d) => d.$2 == 'Mortgage illustration.pdf').toList();
    expect(illustrations, hasLength(2));
    expect(illustrations[0].$3.contentHash, isNot(illustrations[1].$3.contentHash));
    final first = await facts('Mortgage illustration.pdf', containing: '4.29%');
    final revised = await facts('Mortgage illustration.pdf', containing: '4.19%');
    expect(first.type, DocumentType.mortgageIllustration);
    expect(first.known(FactField.initialRate)!.value, '4.29%');
    expect(revised.known(FactField.initialRate)!.value, '4.19%');
    expect(revised.known(FactField.initialRate)!.qualifier, 'fixed for 5 years');
    expect(revised.known(FactField.ratePeriod)!.value, '5 years');
    expect(revised.known(FactField.arrangementFee)!.value, 'GBP 1,499');
    expect(revised.known(FactField.arrangementFee)!.qualifier, 'payable on completion');
    expect(revised.known(FactField.monthlyPayment)!.value, 'GBP 1,392.01');
    expect(revised.known(FactField.monthlyPayment)!.qualifier, 'initial period');
    expect(revised.known(FactField.monthlyPayment)!.evidence.page, 1);
    expect(revised.known(FactField.earlyRepaymentCharges)!.evidence.page, 2);
    expect(revised.known(FactField.totalAmountPayable)!.value, 'GBP 566,620');
    // Every field is found, none conflicting.
    expect([for (final f in revised.fields) revised.known(f)], everyElement(isNotNull));
  });

  test('the removals invoice: the amount due, not the quote for the whole move', () async {
    final invoice = await facts('INV-2207.pdf');
    expect(invoice.type, DocumentType.invoice);
    expect(invoice.known(FactField.amountDue)!.value, 'GBP 450.00');
    expect(invoice.known(FactField.currency)!.value, 'GBP');
    expect(invoice.known(FactField.subtotal)!.value, 'GBP 375.00');
    expect(invoice.known(FactField.tax)!.value, 'GBP 75.00');
    expect(invoice.known(FactField.tax)!.qualifier, '20%');
    expect(invoice.known(FactField.reference)!.value, 'INV-2207');
    expect(invoice.known(FactField.payee)!.value, 'Quayside Removals Ltd');
    expect(invoice.known(FactField.dueDate), isNotNull);
  });

  test('the valuation booking: date, time and the stated zone', () async {
    final booking = await facts('Valuation booking.pdf');
    expect(booking.type, DocumentType.booking);
    expect(booking.known(FactField.time)!.value, '10:00');
    expect(booking.known(FactField.timeZone)!.value, 'UK time');
    expect(booking.known(FactField.reference)!.value, 'VAL-55021');
    expect(booking.known(FactField.address)!.value, '14 Quay Street');
    expect(booking.known(FactField.person)!.value, 'Priya Shah');
    expect(booking.known(FactField.date)!.value, matches(RegExp(r'^[A-Z][a-z]+day \d{1,2} [A-Z][a-z]+$')));
  });

  test('other documents get the fallback with no fields; nothing is guessed', () async {
    for (final name in [
      'Payment schedule.pdf',
      'Bank statement - September.pdf',
      'SA302 2024-25.pdf',
      'Offsite_plan.pdf',
    ]) {
      final f = await facts(name);
      expect(f.type, DocumentType.other, reason: name);
      expect(f.facts, isEmpty, reason: name);
    }
  });

  test('the storyline’s documents are the ones in its threads', () {
    final names = {
      for (final (m, name, _) in documents)
        if (DemoPrivateAi.threadIds.contains(m.summary.threadId)) name,
    };
    expect(
      names,
      containsAll([
        'Mortgage illustration.pdf',
        'Payment schedule.pdf',
        'Bank statement - September.pdf',
        'SA302 2024-25.pdf',
        'Client care letter.pdf',
        'Valuation booking.pdf',
        'INV-2207.pdf',
      ]),
    );
  });
}
