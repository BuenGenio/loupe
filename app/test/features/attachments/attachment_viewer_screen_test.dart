import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/attachment_platform.dart';
import 'package:loupe/features/attachments/attachment_viewer_screen.dart';
import 'package:loupe/features/attachments/viewers/csv_table_view.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../conversation/fake_mail_repository.dart';
import 'attachment_fakes.dart';

typedef _Setup = ({AttachmentRepo repo, FakePlatform platform});

Future<_Setup> _open(
  WidgetTester tester,
  List<(Attachment, List<int>)> files, {
  String part = '2',
  bool mobileData = false,
}) async {
  tester.view
    ..physicalSize = const Size(390, 844) * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final repo = AttachmentRepo(
    emails: [testEmail('m1')],
    contents: {
      'm1': EmailContent(emailId: 'm1', text: 'See attached.', attachments: [for (final (a, _) in files) a]),
    },
  );
  for (final (a, bytes) in files) {
    repo.files[a.partId] = bytes;
  }
  final platform = FakePlatform()..mobileData = mobileData;
  await tester.pumpWidget(
    ProviderScope(
      overrides: overridesFor(repo, platform),
      child: MaterialApp(
        theme: LoupeTheme.light(),
        home: AttachmentViewerScreen(emailId: 'm1', partId: part),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (repo: repo, platform: platform);
}

Attachment _a(String mime, String name, {String part = '2', int size = 100}) =>
    Attachment(partId: part, mimeType: mime, filename: name, size: size);

String _subtitle(WidgetTester tester) => tester.widget<Text>(find.byKey(const Key('attachment-subtitle'))).data!;

void main() {
  setUp(() => ReadableMessageView.debugSynchronous = true);
  tearDown(() => ReadableMessageView.debugSynchronous = false);

  testWidgets('a text file opens in the monospace viewer, read as Latin-1 when not UTF-8', (tester) async {
    // A .log sent as octet-stream: the extension picks the text viewer.
    final latin1Log = [...latin1.encode('12:00 démarrage\n12:01 prêt\n'), 0x93, ...latin1.encode('fin'), 0x94];
    final s = await _open(tester, [(_a('application/octet-stream', 'server.log'), latin1Log)]);

    expect(find.text('server.log'), findsOneWidget);
    expect(_subtitle(tester), 'Log File · ${latin1Log.length} bytes');
    expect(find.text('12:00 démarrage'), findsOneWidget);
    expect(find.text('“fin”'), findsOneWidget);
    expect(tester.widget<Text>(find.byKey(const Key('attachment-text-info'))).data, 'Latin-1 · 3 lines');
    expect(s.repo.log.where((l) => l.startsWith('loadAttachment')), ['loadAttachment m1 2']);

    expect(tester.widget<Text>(find.text('12:01 prêt')).softWrap, isTrue);
    await tester.tap(find.byKey(const Key('attachment-wrap')));
    await tester.pumpAndSettle();
    expect(tester.widget<Text>(find.text('12:01 prêt')).softWrap, isFalse);
    expect(find.byTooltip('Wrap Lines'), findsOneWidget);

    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String;
      return null;
    });
    await tester.tap(find.byTooltip('Copy All'));
    await tester.pumpAndSettle();
    expect(copied, '12:00 démarrage\n12:01 prêt\n“fin”');
    expect(find.text('Copied'), findsOneWidget);
  });

  testWidgets('a small CSV shows as a table, and as text on request', (tester) async {
    final csv = utf8.encode('Item;Cost\r\nVenue;1 200,00\r\n"Coffee; tea";85,50\r\n');
    await _open(tester, [(_a('text/csv', 'budget.csv'), csv)]);

    expect(find.byType(CsvTableView), findsOneWidget);
    expect(find.text('Item'), findsOneWidget);
    expect(find.text('Coffee; tea'), findsOneWidget);
    expect(find.text('85,50'), findsOneWidget);
    // Numbers align right.
    expect(tester.widget<Text>(find.text('85,50')).textAlign, TextAlign.end);
    expect(find.byKey(const Key('attachment-wrap')), findsNothing);

    await tester.tap(find.text('Text'));
    await tester.pumpAndSettle();
    expect(find.byType(CsvTableView), findsNothing);
    expect(find.text('"Coffee; tea";85,50'), findsOneWidget);
    expect(find.byKey(const Key('attachment-wrap')), findsOneWidget);
  });

  testWidgets('a large CSV shows as text', (tester) async {
    final rows = List.generate(2500, (i) => '$i,row $i').join('\n');
    await _open(tester, [(_a('text/csv', 'big.csv'), utf8.encode(rows))]);
    expect(find.byType(CsvTableView), findsNothing);
    expect(find.text('0,row 0'), findsOneWidget);
    expect(find.byKey(const Key('attachment-mode')), findsNothing);
  });

  testWidgets('a calendar file shows the event above its text', (tester) async {
    final ics = utf8.encode(
      'BEGIN:VCALENDAR\r\nBEGIN:VEVENT\r\nSUMMARY:Atlas design review\r\n'
      'DTSTART:20261006T140000\r\nDTEND:20261006T150000\r\nLOCATION:Lighthouse (3rd floor)\r\n'
      'ORGANIZER;CN=Dana Okafor:mailto:dana@example.com\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n',
    );
    await _open(tester, [(_a('text/calendar', 'invite.ics'), ics)]);

    final card = find.byKey(const Key('event-summary'));
    expect(find.descendant(of: card, matching: find.text('Atlas design review')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('Lighthouse (3rd floor)')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.text('Organizer: Dana Okafor')), findsOneWidget);
    expect(find.descendant(of: card, matching: find.textContaining('October 6')), findsOneWidget);
    expect(find.text('SUMMARY:Atlas design review'), findsOneWidget);
    expect(_subtitle(tester), startsWith('Calendar Event'));
  });

  testWidgets('a PDF shows its pages through the renderer, with the page count and indicator', (tester) async {
    final pdf = latin1.encode('%PDF-1.4\n% a tiny test document\n%%EOF\n');
    await _open(tester, [(_a('application/pdf', 'Plan.pdf', size: 400000), pdf)]);

    expect(find.text('PDF of ${pdf.length} bytes'), findsOneWidget);
    expect(_subtitle(tester), 'PDF Document · ${pdf.length} bytes · 3 pages');
    expect(find.text('1 of 3'), findsOneWidget);
    await tester.tap(find.text('PDF of ${pdf.length} bytes'));
    await tester.pumpAndSettle();
    expect(find.text('2 of 3'), findsOneWidget);
    // Text tools are for text.
    expect(find.byTooltip('Copy All'), findsNothing);
  });

  testWidgets("a PDF that can't be rendered offers the details card", (tester) async {
    final s = await _open(tester, [(_a('application/pdf', 'Locked.pdf'), utf8.encode('garbage'))]);
    expect(find.byKey(const Key('attachment-details')), findsOneWidget);
    expect(find.textContaining('protected with a password'), findsOneWidget);
    await tester.tap(find.text('Open in…'));
    await tester.pumpAndSettle();
    expect(s.platform.calls, ['openIn Locked.pdf application/pdf']);
  });

  testWidgets('an attached message shows its headers and body, and its source', (tester) async {
    final eml = utf8.encode(
      'From: Dana Okafor <dana@example.com>\r\nTo: Sam Rivera <sam@example.com>\r\n'
      'Subject: =?UTF-8?Q?Venue_confirm=C3=A9d?=\r\nDate: Sat, 03 Oct 2026 10:00:00 +0000\r\n'
      'MIME-Version: 1.0\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n'
      'The Old Mill is booked for the 6th.\r\n',
    );
    await _open(tester, [(_a('message/rfc822', 'Venue.eml'), eml)]);

    expect(find.text('Venue confirméd'), findsOneWidget);
    expect(find.textContaining('Dana Okafor <dana@example.com>', findRichText: true), findsOneWidget);
    expect(find.textContaining('The Old Mill is booked', findRichText: true), findsWidgets);

    await tester.tap(find.text('Source'));
    await tester.pumpAndSettle();
    expect(find.text('Subject: =?UTF-8?Q?Venue_confirm=C3=A9d?='), findsOneWidget);
  });

  testWidgets('other files show details without downloading; the actions download once', (tester) async {
    final zip = [0x50, 0x4B, 0x03, 0x04, 1, 2, 3];
    final s = await _open(tester, [(_a('application/zip', 'Photos.zip', size: 2048), zip)]);

    final details = find.byKey(const Key('attachment-details'));
    expect(find.descendant(of: details, matching: find.text('ZIP Archive · 2 KB')), findsOneWidget);
    expect(s.repo.log.where((l) => l.startsWith('loadAttachment')), isEmpty);

    await tester.tap(find.byTooltip('Open in…'));
    await tester.pumpAndSettle();
    expect(s.platform.calls, ['openIn Photos.zip application/zip']);
    expect(s.platform.last!.bytes, zip);

    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Saved “Photos.zip”'), findsOneWidget);

    await tester.tap(find.byTooltip('Share'));
    await tester.pumpAndSettle();
    expect(s.platform.calls, [
      'openIn Photos.zip application/zip',
      'save Photos.zip',
      'share Photos.zip application/zip',
    ]);
    expect(s.repo.log.where((l) => l.startsWith('loadAttachment')), ['loadAttachment m1 2']);

    s.platform.openResult = OpenInResult.noApp;
    await tester.tap(find.text('Open in…'));
    await tester.pumpAndSettle();
    expect(find.textContaining('No app on this device opens this file (ZIP Archive)'), findsOneWidget);
  });

  testWidgets('asks before downloading a large attachment on mobile data', (tester) async {
    final s = await _open(tester, [
      (_a('text/plain', 'dump.txt', size: 40 * 1024 * 1024), utf8.encode('tiny really')),
    ], mobileData: true);

    expect(find.text('40.0 MB on mobile data'), findsOneWidget);
    expect(s.repo.log.where((l) => l.startsWith('loadAttachment')), isEmpty);
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    expect(find.text('tiny really'), findsOneWidget);
  });

  testWidgets('a large attachment on Wi-Fi downloads right away', (tester) async {
    await _open(tester, [(_a('text/plain', 'dump.txt', size: 40 * 1024 * 1024), utf8.encode('tiny really'))]);
    expect(find.text('tiny really'), findsOneWidget);
  });

  testWidgets('reports a missing attachment', (tester) async {
    await _open(tester, [(_a('text/plain', 'a.txt'), utf8.encode('a'))], part: '9');
    expect(find.text('This attachment is no longer available.'), findsOneWidget);
    expect(find.text('Attachment'), findsOneWidget);
  });

  testWidgets('a failed download can be retried', (tester) async {
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final repo = AttachmentRepo(
      emails: [testEmail('m1')],
      contents: {
        'm1': EmailContent(emailId: 'm1', attachments: [_a('text/plain', 'notes.txt')]),
      },
    )..attachmentError = const MailException(MailErrorKind.connection, 'The server is not reachable.');
    repo.files['2'] = utf8.encode('Remember the milk');
    await tester.pumpWidget(
      ProviderScope(
        overrides: overridesFor(repo, FakePlatform()),
        child: MaterialApp(
          theme: LoupeTheme.light(),
          home: const AttachmentViewerScreen(emailId: 'm1', partId: '2'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('The server is not reachable.'), findsOneWidget);

    repo.attachmentError = null;
    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();
    expect(find.text('Remember the milk'), findsOneWidget);
  });

  testWidgets('an image shows zoomable, at its real size in the subtitle', (tester) async {
    // 1×1 transparent PNG.
    final png = base64.decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
    );
    await _open(tester, [(_a('application/octet-stream', 'dot.png'), png)]);
    expect(find.byKey(const Key('attachment-image')), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(_subtitle(tester), 'PNG Image · ${png.length} bytes');
  });
}
