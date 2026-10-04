import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SemanticsAction;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/attachments/attachment_viewer_screen.dart';
import 'package:loupe/features/conversation/attachments.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';
import 'attachment_fakes.dart';

final _png = base64.decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
);

const _photo = Attachment(partId: '2', mimeType: 'image/jpeg', filename: 'photo.jpg', size: 2000);
const _heic = Attachment(partId: '3', mimeType: 'application/octet-stream', filename: 'scan.heic', size: 3000);
const _pdf = Attachment(partId: '4', mimeType: 'application/pdf', filename: 'plan.pdf', size: 4000);
const _content = EmailContent(emailId: 'm1', text: 'Files', attachments: [_photo, _heic, _pdf]);

Future<({AttachmentRepo repo, FakePlatform platform, List<String> loads})> _pump(WidgetTester tester) async {
  tester.view
    ..physicalSize = const Size(390, 844) * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final repo = AttachmentRepo(emails: [testEmail('m1')], contents: {'m1': _content});
  repo.files
    ..['2'] = _png
    ..['3'] = _png
    ..['4'] = latin1.encode('%PDF-1.4\n%%EOF\n');
  final platform = FakePlatform();
  final loads = <String>[];
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => Scaffold(
          body: ListView(
            children: [
              AttachmentList(
                content: _content,
                load: (a) {
                  loads.add(a.partId);
                  return repo.loadAttachment('m1', a.partId);
                },
              ),
            ],
          ),
        ),
      ),
      GoRoute(
        path: '/attachment/:id/:part',
        builder: (_, s) => AttachmentViewerScreen(emailId: s.pathParameters['id']!, partId: s.pathParameters['part']!),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overridesFor(repo, platform),
      child: MaterialApp.router(theme: LoupeTheme.light(), routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return (repo: repo, platform: platform, loads: loads);
}

void main() {
  testWidgets('lists the attachments with type icons and sizes', (tester) async {
    await _pump(tester);
    expect(find.byType(AttachmentTile), findsNWidgets(3));
    expect(find.text('plan.pdf'), findsOneWidget);
    expect(find.text('4 KB'), findsOneWidget);
    expect(find.byIcon(attachmentIcon('application/octet-stream', 'scan.heic')), findsNWidgets(2));
  });

  testWidgets('images open the gallery over every image, whatever their MIME type says', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('scan.heic'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('readable-gallery')), findsOneWidget);
    expect(find.text('2 / 2'), findsOneWidget);
    expect(find.byType(AttachmentViewerScreen), findsNothing);
  });

  testWidgets('other files open the viewer', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('plan.pdf'));
    await tester.pumpAndSettle();
    expect(find.byType(AttachmentViewerScreen), findsOneWidget);
    expect(find.text('1 of 3'), findsOneWidget);
  });

  testWidgets('the more button offers Open in…, Save and Share, downloading once', (tester) async {
    final s = await _pump(tester);
    final more = find.descendant(
      of: find.widgetWithText(AttachmentTile, 'plan.pdf'),
      matching: find.byType(CupertinoButton),
    );
    final semantics = tester.ensureSemantics();
    await tester.pump();
    final node = tester.getSemantics(more).getSemanticsData();
    expect(node.label, 'More actions for plan.pdf');
    expect(node.hasAction(SemanticsAction.tap), isTrue);
    semantics.dispose();
    await tester.tap(more);
    await tester.pumpAndSettle();
    expect(find.text('Open in…'), findsOneWidget);
    expect(find.text('Save to Files'), findsOneWidget);
    await tester.tap(find.text('Save to Files'));
    await tester.pumpAndSettle();
    expect(s.platform.calls, ['save plan.pdf']);
    expect(find.text('Saved “plan.pdf”'), findsOneWidget);

    await tester.longPress(find.text('plan.pdf'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open in…'));
    await tester.pumpAndSettle();
    expect(s.platform.calls, ['save plan.pdf', 'openIn plan.pdf application/pdf']);
    expect(s.loads, ['4'], reason: 'the session cache keeps the download');
  });
}
