import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loupe/app.dart';
import 'package:loupe/demo/demo_data.dart';
import 'package:loupe/features/attachments/attachment_cache.dart';
import 'package:loupe/features/attachments/attachment_viewer_screen.dart';
import 'package:loupe/features/attachments/viewers/pdf_view.dart';
import 'package:loupe/features/openpgp/content_loader.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/features/documents/document_index.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:mail_documents/mail_documents.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../attachments/attachment_fakes.dart' show fakePdfBuilder;

const _ai = {'settings.aiAssist': true};

/// The demo's attachments called [name], oldest message first. From the
/// seed, which the test repository is built from (same clock), so nothing
/// waits on the repository's timers outside the test's pumps.
List<(EmailSummary, Attachment)> attachmentsNamed(String name) {
  final found = [
    for (final m in DemoSeed.build(testNow).messages)
      for (final a in m.attachments)
        if (a.attachment.filename == name) (m.summary, a.attachment),
  ]..sort((a, b) => a.$1.receivedAt.compareTo(b.$1.receivedAt));
  return found;
}

/// The app with a memory-only attachment cache (no cache directory in
/// tests) and the fake PDF renderer, as the attachment tests use.
Future<void> pumpDocs(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  AppMode mode = AppMode.demo,
  Size size = const Size(390, 844),
  List<Override> overrides = const [],
}) => pumpLoupe(
  tester,
  prefs: prefs,
  mode: mode,
  size: size,
  overrides: [
    attachmentCacheProvider.overrideWith(
      (ref) => AttachmentCache(
        repository: ref.watch(repositoryProvider),
        directory: () async => null,
        loadAttachment: ref.watch(contentLoaderProvider).loadAttachment,
      ),
    ),
    pdfViewBuilderProvider.overrideWithValue(fakePdfBuilder),
    ...overrides,
  ],
);

Future<void> search(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(CupertinoSearchTextField), text);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}

void main() {
  // As main.dart does: dates in every language.
  setUpAll(initializeDateFormatting);

  testWidgets('Mailboxes › Documents lists the demo’s documents and says what it can’t read', (tester) async {
    await pumpDocs(tester);
    await tester.scrollTo(find.text('Documents'));
    await tester.tap(find.text('Documents'));
    await tester.pumpAndSettle();
    expect(find.text('Search in Documents'), findsOneWidget); // the field's placeholder
    expect(textContaining('downloaded documents · 1 can’t be read'), findsOneWidget); // the .docx
    expect(find.text('Mortgage illustration.pdf'), findsWidgets);
    // Same name, different bytes: both copies say so.
    expect(find.textContaining('Different contents from the earlier copy'), findsOneWidget);
    await tester.scrollTo(find.textContaining('A newer copy'));
    expect(find.textContaining('A newer copy'), findsOneWidget);
    await tester.scrollTo(find.textContaining('Searches attachments on this phone, not your whole mailbox'));
    await drainTimers(tester);
  });

  testWidgets('a search shows document, message, page and the passage, with honest coverage', (tester) async {
    await pumpDocs(tester);
    await goTo(tester, Routes.documents);
    await search(tester, 'arrangement FEE');
    final coverage = tester.widget<Text>(
      find.descendant(of: find.byKey(const Key('documents-coverage')), matching: find.byType(Text)),
    );
    expect(coverage.data, matches(RegExp(r'^Searched \d+ downloaded documents · 1 couldn’t be read$')));
    expect(coverage.data, isNot(contains('all')));
    expect(find.text('Mortgage illustration.pdf'), findsNWidgets(2));
    expect(find.text('Matched on page 2'), findsNWidgets(2));
    expect(textContaining('Arrangement fee: GBP 1,499'), findsOneWidget);
    expect(textContaining('Arrangement fee: GBP 999'), findsOneWidget);
    expect(textContaining('Rhea Patel · Re: Your mortgage application'), findsOneWidget);

    // A passage opens the attachment.
    await tester.tap(textContaining('Arrangement fee: GBP 1,499'));
    await tester.pumpAndSettle();
    expect(find.byType(AttachmentViewerScreen), findsOneWidget);
    await systemBack(tester);

    await search(tester, 'no such words anywhere');
    expect(find.text('No Matches'), findsOneWidget);
    expect(find.text('No downloaded document contains “no such words anywhere”.'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('a text file’s match is by line; CSV and Latin-1 logs are searched too', (tester) async {
    await pumpDocs(tester);
    await goTo(tester, Routes.documents);
    await search(tester, 'walking shoes');
    expect(find.text('Notes from Hana.txt'), findsOneWidget);
    expect(find.text('Matched on line 7'), findsOneWidget);
    await search(tester, 'Mill House');
    expect(find.text('Offsite_budget.csv'), findsOneWidget);
    await search(tester, 'réservation confirmée');
    expect(find.text('booking_checkin.log'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('mail search offers the same words in Documents', (tester) async {
    await pumpDocs(tester);
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'valuation fee');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Search in Documents'), findsOneWidget);
    await tester.tap(find.text('Search in Documents'));
    await tester.pumpAndSettle();
    expect(textContaining('Valuation fee: GBP 0'), findsNWidgets(2));
    expect(find.byKey(const Key('documents-coverage')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('operators alone aren’t offered for a search in documents', (tester) async {
    await pumpDocs(tester);
    await goTo(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'from:dana is:unread');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Search in Documents'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('the revised illustration: Key Facts with page-linked quotes, and what changed', (tester) async {
    await pumpDocs(tester, prefs: _ai);
    final copies = attachmentsNamed('Mortgage illustration.pdf');
    expect(copies, hasLength(2));
    final (revised, attachment) = copies.last;
    await goTo(tester, Routes.document(revised.id, attachment.partId));

    final card = find.byKey(const Key('key-facts'));
    await tester.scrollTo(card);
    expect(find.descendant(of: card, matching: find.text('Mortgage illustration')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('4.19%')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('fixed for 5 years')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('GBP 1,392.01')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('GBP 1,499')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('Made by the built-in demo, not a model.')), findsOneWidget);

    // Version comparison, by bytes, with the changed facts.
    expect(textContaining('Different contents from the earlier copy'), findsOneWidget);
    final changes = find.byKey(const Key('document-changes'));
    expect(find.descendant(of: changes, matching: find.text('4.29% → 4.19%')), findsOneWidget);
    expect(find.descendant(of: changes, matching: find.text('GBP 999 → GBP 1,499')), findsOneWidget);
    expect(find.descendant(of: changes, matching: find.text('GBP 1,408.72 → GBP 1,392.01')), findsOneWidget);
    // Unchanged facts are not listed.
    expect(find.descendant(of: changes, matching: textContaining('285,000')), findsNothing);

    // A fact shows its page with the quote.
    await tester.ensureVisible(find.byKey(const ValueKey('fact-arrangement_fee')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('fact-arrangement_fee')));
    await tester.pumpAndSettle();
    expect(find.text('Page 2'), findsWidgets);
    expect(find.text('“Arrangement fee: GBP 1,499 payable on completion”'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    await drainTimers(tester);
  });

  testWidgets('the removals invoice: the amount due, not the quote for the whole move', (tester) async {
    await pumpDocs(tester, prefs: _ai);
    final (email, attachment) = (attachmentsNamed('INV-2207.pdf')).single;
    await goTo(tester, Routes.document(email.id, attachment.partId));
    final card = find.byKey(const Key('key-facts'));
    await tester.scrollTo(card);
    expect(find.descendant(of: card, matching: find.text('Invoice')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('Amount due')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('GBP 450.00')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('GBP 1,850.00')), findsNothing);
    expect(find.descendant(of: card, matching: find.text('20%')), findsOneWidget); // the VAT's qualifier
    await drainTimers(tester);
  });

  testWidgets('in the conversation: the copy note and the Key Facts button', (tester) async {
    await pumpDocs(tester, prefs: _ai);
    final (revised, attachment) = (attachmentsNamed('Mortgage illustration.pdf')).last;
    await goTo(tester, Routes.message(revised.id));
    final note = find.byKey(const Key('attachment-copy-note'));
    await tester.scrollTo(note);
    expect(tester.widget<Text>(note).data, startsWith('Different contents from the earlier copy ('));
    final button = find.byKey(ValueKey('key-facts-${attachment.partId}'));
    expect(button, findsWidgets);
    await tester.ensureVisible(button.last);
    await tester.pumpAndSettle();
    await tester.tap(button.last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('key-facts')), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('with Private AI off: no Key Facts anywhere; reading, copies and search still work', (tester) async {
    await pumpDocs(tester);
    final (revised, attachment) = (attachmentsNamed('Mortgage illustration.pdf')).last;
    await goTo(tester, Routes.document(revised.id, attachment.partId));
    expect(find.byKey(const Key('key-facts')), findsNothing);
    expect(textContaining('Different contents from the earlier copy'), findsOneWidget);
    expect(find.byKey(const Key('document-changes')), findsNothing);
    await tester.scrollTo(find.text('TEXT BY PAGE'));
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 2'), findsOneWidget);
    expect(textContaining('Contents fingerprint'), findsOneWidget);

    await goTo(tester, Routes.message(revised.id));
    expect(find.byKey(ValueKey('key-facts-${attachment.partId}')), findsNothing);

    await goTo(tester, Routes.documentsSearch('4.19%'));
    expect(find.text('Matched on page 1'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('the viewer has Document Details for a PDF', (tester) async {
    await pumpDocs(tester);
    final (email, attachment) = (attachmentsNamed('Valuation booking.pdf')).single;
    await goTo(tester, Routes.attachment(email.id, attachment.partId));
    await tester.tap(find.byKey(const Key('document-details')));
    await tester.pumpAndSettle();
    await tester.scrollTo(find.text('TEXT BY PAGE'));
    await tester.tap(find.text('Page 1'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Booking reference: VAL-55021'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('with real accounts only downloaded attachments are searched', (tester) async {
    await pumpDocs(tester, mode: AppMode.live);
    await goTo(tester, Routes.documents);
    expect(find.text('No Documents Yet'), findsOneWidget);
    await systemBack(tester);

    final (email, attachment) = (attachmentsNamed('INV-2207.pdf')).single;
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    // As opening it would: the download runs on the repository's timers.
    unawaited(container.read(attachmentCacheProvider).bytes(email.id, attachment));
    await tester.pumpAndSettle();
    await goTo(tester, Routes.documentsSearch('amount due'));
    expect(find.text('Searched 1 downloaded document'), findsOneWidget);
    expect(find.text('INV-2207.pdf'), findsOneWidget);
    expect(find.text('Mortgage illustration.pdf'), findsNothing);
    await drainTimers(tester);
  });

  testWidgets('protected, scanned and partly read documents say so, and aren’t counted as searched', (tester) async {
    final email = EmailSummary(
      id: 'personal|INBOX|1|900',
      accountId: 'personal',
      mailboxId: 'personal|INBOX',
      from: const [EmailAddress('lender@calderbs.example', 'Calder')],
      subject: 'Your documents',
      receivedAt: testNow,
    );
    DocumentEntry entry(
      String part,
      String name,
      ExtractionStatus status, {
      List<DocumentPage> pages = const [],
      int? count,
      ExtractionLimit? limit,
    }) => DocumentEntry(
      ref: DocumentRef(email.id, part),
      attachment: Attachment(partId: part, mimeType: 'application/pdf', filename: name, size: 1000),
      email: email,
      document: ExtractedDocument(
        contentHash: part * 64,
        byteLength: 1000,
        format: DocumentFormat.pdf,
        status: status,
        pages: pages,
        pageCount: count,
        limit: limit,
      ),
    );
    final library = DocumentLibrary([
      entry('2', 'Payslip.pdf', ExtractionStatus.encrypted),
      entry('3', 'Scan.pdf', ExtractionStatus.noText, pages: const [DocumentPage(1, '')], count: 1),
      entry(
        '4',
        'Long report.pdf',
        ExtractionStatus.partial,
        pages: const [DocumentPage(1, 'Summary of the valuation'), DocumentPage(2, 'More')],
        count: 340,
        limit: ExtractionLimit.pages,
      ),
    ]);
    await pumpDocs(tester, overrides: [documentLibraryProvider.overrideWith((ref) async => library)]);
    await goTo(tester, Routes.documents);
    expect(find.text('3 downloaded documents · 2 can’t be read'), findsOneWidget);
    expect(find.text('Password protected: Loupe can’t read it.'), findsOneWidget);
    expect(find.text('No text found: it may be a scan or a photo, which Loupe can’t read yet.'), findsOneWidget);
    expect(find.text('Read 2 of 340 pages; the rest isn’t searched.'), findsOneWidget);

    await search(tester, 'valuation');
    expect(find.text('Searched 1 downloaded document · 2 couldn’t be read'), findsOneWidget);
    expect(find.text('Long report.pdf'), findsOneWidget);
    expect(find.text('Read 2 of 340 pages; the rest isn’t searched.'), findsOneWidget);
    await drainTimers(tester);
  });

  // Translations run longer than English: the screens must fit a small phone.
  for (final lang in ['de', 'fi', 'ga', 'el', 'hu']) {
    testWidgets('Documents, a search and Key Facts fit a small phone in $lang', (tester) async {
      await pumpDocs(tester, prefs: {..._ai, 'settings.language': lang}, size: const Size(360, 640));
      addTearDown(() => appLanguage = null);
      await goTo(tester, Routes.documents);
      expect(tester.takeException(), isNull);
      await search(tester, 'GBP');
      expect(tester.takeException(), isNull);
      final (revised, attachment) = attachmentsNamed('Mortgage illustration.pdf').last;
      await goTo(tester, Routes.document(revised.id, attachment.partId));
      await tester.scrollTo(find.byKey(const ValueKey('fact-early_repayment_charges')));
      expect(tester.takeException(), isNull);
      await drainTimers(tester);
    });
  }
}
