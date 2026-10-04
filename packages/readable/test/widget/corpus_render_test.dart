// Renders every corpus message in Readable and Plain, light and dark, on a
// phone-sized screen: no exceptions, no overflow, nothing wider than the
// screen.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/cache.dart';

import '../corpus_loader.dart';
import 'helpers.dart' show pngBytes;

void main() {
  setUpAll(() => ReadableMessageView.debugSynchronous = true);
  tearDownAll(() => ReadableMessageView.debugSynchronous = false);
  setUp(PipelineCache.instance.clear);

  for (final entry in loadCorpus().where((e) => e.smoke)) {
    for (final mode in [ReaderMode.readable, ReaderMode.plain]) {
      for (final brightness in Brightness.values) {
        testWidgets('${entry.name} ${mode.name} ${brightness.name}', (tester) async {
          tester.view.physicalSize = const Size(1080, 2400);
          tester.view.devicePixelRatio = 3;
          addTearDown(tester.view.reset);
          final content = EmailContent(
            emailId: entry.name,
            html: entry.html,
            text: entry.text,
            isFlowed: entry.isFlowed,
            inlineData: {for (final cid in entry.contentIds) cid: pngBytes},
          );
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(brightness: brightness),
              home: Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ReadableMessageView(
                    content: content,
                    settings: ReaderSettings(mode: mode),
                    onOpenLink: (_) {},
                  ),
                ),
              ),
            ),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
          final view = tester.getRect(find.byType(ReadableMessageView));
          expect(view.width, lessThanOrEqualTo(360));
        });
      }
    }
  }
}
