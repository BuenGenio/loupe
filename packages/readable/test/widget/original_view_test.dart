import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/cache.dart';
import 'package:readable/src/render/banner.dart';
import 'package:readable/src/render/original_view.dart';
import 'package:webview_flutter/webview_flutter.dart' show NavigationDecision;

import 'helpers.dart';

void main() {
  final requests = <OriginalViewRequest>[];

  setUp(() {
    PipelineCache.instance.clear();
    requests.clear();
  });
  tearDown(() => debugOriginalViewBuilder = null);

  const original = ReaderSettings(mode: ReaderMode.original);
  const html =
      '<html><head><style>.x{color:red}</style><script>steal()</script></head>'
      '<body onload="steal()"><p class="x">Hello</p><img src="https://cdn.shop.example/a.png">'
      '<img src="cid:logo@shop"></body></html>';

  EmailContent content() => EmailContent(
    emailId: 'o${DateTime.now().microsecondsSinceEpoch}',
    html: html,
    inlineData: {'logo@shop': pngBytes},
    attachments: const [Attachment(partId: '2', mimeType: 'image/png', contentId: 'logo@shop', isInline: true)],
  );

  testWidgets('hands a locked-down page to the WebView seam', (tester) async {
    debugOriginalViewBuilder = (context, request) {
      requests.add(request);
      return const SizedBox(height: 100, child: Text('webview'));
    };
    await pumpReader(tester, content(), settings: original);
    expect(find.text('webview'), findsOneWidget);
    final page = requests.last.html;
    expect(page, contains("default-src 'none'; img-src cid: data:; style-src 'unsafe-inline'"));
    expect(page, contains('<meta name="viewport" content="width=device-width, initial-scale=1">'));
    expect(page, contains('img{max-width:100%'));
    expect(page, contains('.x{color:red}'));
    expect(page, isNot(contains('steal')));
    expect(page, contains('src="data:image/png;base64,'));
    expect(page, isNot(contains('cid:logo@shop"')));

    // Remote images: banner, and allowing them relaxes the CSP.
    expect(find.byType(RemoteContentBanner), findsOneWidget);
    await tester.tap(find.text('Load images'));
    await tester.pump();
    expect(requests.last.html, contains('img-src cid: data: https:;'));
    expect(find.byType(RemoteContentBanner), findsNothing);
  });

  testWidgets('without a WebView, Original falls back to the Readable rendering', (tester) async {
    await pumpReader(tester, content(), settings: original);
    expect(richText('Hello'), findsOneWidget);
  });

  testWidgets('a text-only message in Original mode shows its text', (tester) async {
    debugOriginalViewBuilder = (context, request) => const Text('webview');
    await pumpReader(
      tester,
      const EmailContent(emailId: 't1', text: 'Plain body'),
      settings: original,
    );
    expect(richText('Plain body'), findsOneWidget);
    expect(find.text('webview'), findsNothing);
  });

  group('navigation', () {
    test('the initial blank page loads; links go to the host; everything else is blocked', () {
      final opened = <Uri>[];
      NavigationDecision decide(String url, {bool main = true}) =>
          decideNavigation(url, isMainFrame: main, onOpenLink: opened.add);
      expect(decide('about:blank'), NavigationDecision.navigate);
      expect(decide('https://shop.example/x'), NavigationDecision.prevent);
      expect(decide('mailto:a@b.example'), NavigationDecision.prevent);
      expect(decide('data:text/html,<p>hi'), NavigationDecision.prevent);
      expect(decide('javascript:alert(1)'), NavigationDecision.prevent);
      expect(decide('file:///etc/passwd'), NavigationDecision.prevent);
      expect(decide('https://ads.example/frame', main: false), NavigationDecision.prevent);
      expect(opened, [Uri.parse('https://shop.example/x'), Uri.parse('mailto:a@b.example')]);
    });
  });
}
