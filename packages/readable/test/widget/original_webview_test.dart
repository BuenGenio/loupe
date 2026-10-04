// Exercises the real OriginalWebView against a fake WebView platform: the
// settings it applies, the page it loads, link interception and the
// auto-height measurement. (A real WebView can't run in widget tests.)
//
// WebViewPlatform.instance can't be unset, so this lives in its own file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:readable/src/cache.dart';
import 'package:readable/src/render/original_view.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

final class FakeWebViewPlatform extends WebViewPlatform {
  final controllers = <FakeController>[];

  @override
  PlatformWebViewController createPlatformWebViewController(PlatformWebViewControllerCreationParams params) {
    final c = FakeController(params);
    controllers.add(c);
    return c;
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(PlatformNavigationDelegateCreationParams params) =>
      FakeNavigationDelegate(params);

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(PlatformWebViewWidgetCreationParams params) =>
      FakeWebViewWidget(params);
}

final class FakeController extends PlatformWebViewController {
  FakeController(super.params) : super.implementation();

  JavaScriptMode? javaScriptMode;
  bool? zoom;
  final loaded = <String>[];
  FakeNavigationDelegate? delegate;

  /// Height of the rendered page and of the view showing it.
  double contentHeight = 1000;
  double viewHeight = 0;
  int _scrollY = 0;

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async => this.javaScriptMode = javaScriptMode;

  @override
  Future<void> setBackgroundColor(Color color) async {}

  @override
  Future<void> enableZoom(bool enabled) async => zoom = enabled;

  @override
  Future<void> setPlatformNavigationDelegate(PlatformNavigationDelegate handler) async =>
      delegate = handler as FakeNavigationDelegate;

  @override
  Future<void> loadHtmlString(String html, {String? baseUrl}) async => loaded.add(html);

  /// Like Android with JavaScript off: script evaluation yields nothing.
  @override
  Future<Object> runJavaScriptReturningResult(String javaScript) async => '';

  @override
  Future<void> scrollTo(int x, int y) async =>
      _scrollY = math.max(0, math.min(y, (contentHeight - viewHeight).round()));

  @override
  Future<Offset> getScrollPosition() async => Offset(0, _scrollY.toDouble());
}

final class FakeNavigationDelegate extends PlatformNavigationDelegate {
  FakeNavigationDelegate(super.params) : super.implementation();

  NavigationRequestCallback? onNavigationRequest;
  PageEventCallback? onPageFinished;

  @override
  Future<void> setOnNavigationRequest(NavigationRequestCallback onNavigationRequest) async =>
      this.onNavigationRequest = onNavigationRequest;

  @override
  Future<void> setOnPageFinished(PageEventCallback onPageFinished) async => this.onPageFinished = onPageFinished;
}

final class FakeWebViewWidget extends PlatformWebViewWidget {
  FakeWebViewWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      (params.controller as FakeController).viewHeight = constraints.maxHeight;
      return const SizedBox.expand(key: ValueKey('fake-webview'));
    },
  );
}

void main() {
  final platform = FakeWebViewPlatform();
  setUpAll(() => WebViewPlatform.instance = platform);
  setUp(() {
    PipelineCache.instance.clear();
    platform.controllers.clear();
  });

  Future<FakeController> pumpOriginal(WidgetTester tester, {List<Uri>? opened}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReadableMessageView(
              content: const EmailContent(
                emailId: 'w1',
                html: '<p>Hello <a href="https://shop.example/x">shop</a></p><img src="https://cdn.example/a.png">',
              ),
              settings: const ReaderSettings(mode: ReaderMode.original),
              onOpenLink: opened?.add,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    return platform.controllers.single;
  }

  testWidgets('loads the locked-down page with JavaScript off', (tester) async {
    expect(originalViewAvailable, isTrue);
    final c = await pumpOriginal(tester);
    expect(find.byKey(const ValueKey('fake-webview')), findsOneWidget);
    expect(c.javaScriptMode, JavaScriptMode.disabled);
    expect(c.zoom, isFalse);
    expect(c.loaded.single, contains("default-src 'none'; img-src cid: data:; style-src 'unsafe-inline'"));
    expect(c.loaded.single, contains('Hello'));
  });

  testWidgets('links go to onOpenLink; everything else is blocked', (tester) async {
    final opened = <Uri>[];
    final c = await pumpOriginal(tester, opened: opened);
    final decide = c.delegate!.onNavigationRequest!;
    expect(await decide(const NavigationRequest(url: 'about:blank', isMainFrame: true)), NavigationDecision.navigate);
    expect(
      await decide(const NavigationRequest(url: 'https://shop.example/x', isMainFrame: true)),
      NavigationDecision.prevent,
    );
    expect(opened, [Uri.parse('https://shop.example/x')]);
  });

  testWidgets('grows to the page height when it has loaded', (tester) async {
    final c = await pumpOriginal(tester);
    c.contentHeight = 1800;
    c.delegate!.onPageFinished!('about:blank');
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.getSize(find.byKey(const ValueKey('fake-webview'))).height, 1800);
    // Images that load later make the page taller: measured again.
    c.contentHeight = 2100;
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.getSize(find.byKey(const ValueKey('fake-webview'))).height, 2100);
  });

  testWidgets('allowing remote images reloads with https: in the CSP', (tester) async {
    final c = await pumpOriginal(tester);
    await tester.tap(find.text('Load images'));
    await tester.pump();
    expect(c.loaded.last, contains('img-src cid: data: https:;'));
    // The same WebView reloads; dismissing the banner doesn't recreate it.
    expect(platform.controllers, hasLength(1));
  });
}
