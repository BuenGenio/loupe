// The Original view: the sender's HTML in a WebView with JavaScript off and
// a CSP that blocks remote loads unless allowed. Every navigation goes to
// the host's onOpenLink instead. The WebView sizes itself to its content so
// it scrolls with the host's scroll view.
//
// The WebView sits behind a seam ([originalViewAvailable], [buildOriginalView])
// because it can't run in widget tests or on desktop; there the reader shows
// the Readable rendering instead.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

/// What the Original view shows.
@immutable
final class OriginalViewRequest {
  const OriginalViewRequest({required this.html, this.onOpenLink, this.textScale = 1.0});

  /// The complete page, CSP included.
  final String html;
  final void Function(Uri uri)? onOpenLink;

  /// Text size relative to the WebView default (platform scale × reader scale).
  final double textScale;
}

/// Replaces the WebView (tests, previews).
typedef OriginalViewBuilder = Widget Function(BuildContext context, OriginalViewRequest request);

/// Set in tests to stand in for the WebView.
@visibleForTesting
OriginalViewBuilder? debugOriginalViewBuilder;

/// Whether this platform can show the Original view.
bool get originalViewAvailable =>
    debugOriginalViewBuilder != null ||
    (!kIsWeb &&
        WebViewPlatform.instance != null &&
        (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS));

Widget buildOriginalView(BuildContext context, OriginalViewRequest request) {
  final override = debugOriginalViewBuilder;
  if (override != null) return override(context, request);
  return OriginalWebView(request: request);
}

/// Decides what a navigation request does: the initial `about:blank` load
/// proceeds, links go to [onOpenLink], everything else is blocked.
NavigationDecision decideNavigation(String url, {required bool isMainFrame, void Function(Uri uri)? onOpenLink}) {
  final uri = Uri.tryParse(url);
  if (uri == null) return NavigationDecision.prevent;
  final scheme = uri.scheme.toLowerCase();
  if (scheme == 'about' && uri.path == 'blank') return NavigationDecision.navigate;
  if (isMainFrame && const {'http', 'https', 'mailto', 'tel'}.contains(scheme)) onOpenLink?.call(uri);
  return NavigationDecision.prevent;
}

/// Tallest the WebView grows; beyond that it scrolls inside (very long
/// messages, or content sized to the viewport).
const _maxHeight = 16000.0;

class OriginalWebView extends StatefulWidget {
  const OriginalWebView({super.key, required this.request});
  final OriginalViewRequest request;

  @override
  State<OriginalWebView> createState() => _OriginalWebViewState();
}

class _OriginalWebViewState extends State<OriginalWebView> {
  late final WebViewController _controller;
  double _height = 120;
  double? _width;
  int _measureGeneration = 0;
  final _timers = <Timer>[];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    unawaited(_setUp());
  }

  Future<void> _setUp() async {
    final c = _controller;
    await c.setJavaScriptMode(JavaScriptMode.disabled);
    await c.setBackgroundColor(Colors.white);
    await c.enableZoom(false);
    await c.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (r) =>
            decideNavigation(r.url, isMainFrame: r.isMainFrame, onOpenLink: widget.request.onOpenLink),
        onPageFinished: (_) => _scheduleMeasure(),
      ),
    );
    final platform = c.platform;
    if (platform is AndroidWebViewController) {
      await platform.setAllowFileAccess(false);
      await platform.setAllowContentAccess(false);
      await platform.setGeolocationEnabled(false);
      await platform.setMediaPlaybackRequiresUserGesture(true);
      await platform.setVerticalScrollBarEnabled(false);
      await platform.setOverScrollMode(WebViewOverScrollMode.never);
      await platform.setTextZoom((widget.request.textScale * 100).round());
    }
    await c.loadHtmlString(widget.request.html);
  }

  @override
  void didUpdateWidget(OriginalWebView old) {
    super.didUpdateWidget(old);
    if (old.request.textScale != widget.request.textScale) {
      final platform = _controller.platform;
      if (platform is AndroidWebViewController) {
        unawaited(platform.setTextZoom((widget.request.textScale * 100).round()));
      }
    }
    if (old.request.html != widget.request.html) {
      unawaited(_controller.loadHtmlString(widget.request.html));
    }
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    super.dispose();
  }

  /// Measures now and again shortly after (inline images decode late).
  void _scheduleMeasure() {
    for (final t in _timers) {
      t.cancel();
    }
    _timers
      ..clear()
      ..add(Timer(Duration.zero, _measure))
      ..add(Timer(const Duration(milliseconds: 400), _measure))
      ..add(Timer(const Duration(milliseconds: 1500), _measure));
  }

  Future<void> _measure() async {
    if (!mounted) return;
    final generation = ++_measureGeneration;
    for (var i = 0; i < 4; i++) {
      final measured = await _contentHeight();
      if (!mounted || generation != _measureGeneration || measured == null) return;
      final next = measured.clamp(1.0, _maxHeight);
      if ((next - _height).abs() < 1) return;
      setState(() => _height = next);
      // Let the new height lay out before checking again.
      await Future<void>.delayed(const Duration(milliseconds: 60));
    }
  }

  /// The page's height in logical pixels. iOS evaluates script even with
  /// page JavaScript off; Android doesn't, so there the height comes from
  /// scrolling to the bottom: max scroll + view height = content height.
  Future<double?> _contentHeight() async {
    try {
      final result = await _controller.runJavaScriptReturningResult(
        'Math.max(document.body.scrollHeight, document.documentElement.scrollHeight)',
      );
      final h = double.tryParse('$result');
      if (h != null && h > 0) return h;
    } catch (_) {
      // Script evaluation unavailable: fall through to the scroll probe.
    }
    try {
      final android = _controller.platform is AndroidWebViewController;
      final dpr = mounted ? MediaQuery.devicePixelRatioOf(context) : 1.0;
      await _controller.scrollTo(0, 1 << 22);
      final pos = await _controller.getScrollPosition();
      await _controller.scrollTo(0, 0);
      // Android reports physical pixels.
      final extra = android ? pos.dy / dpr : pos.dy;
      return _height + extra;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final capped = _height >= _maxHeight;
    final params = _widgetParams(context, capped);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_width != constraints.maxWidth) {
          final first = _width == null;
          _width = constraints.maxWidth;
          if (!first) _scheduleMeasure();
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: _height,
            child: WebViewWidget.fromPlatformCreationParams(params: params),
          ),
        );
      },
    );
  }

  PlatformWebViewWidgetCreationParams _widgetParams(BuildContext context, bool capped) {
    final gestures = <Factory<OneSequenceGestureRecognizer>>{
      // Only when the page is taller than the WebView does it take vertical drags.
      if (capped) Factory<VerticalDragGestureRecognizer>(VerticalDragGestureRecognizer.new),
    };
    final params = PlatformWebViewWidgetCreationParams(
      controller: _controller.platform,
      layoutDirection: Directionality.of(context),
      gestureRecognizers: gestures,
    );
    if (_controller.platform is AndroidWebViewController) {
      // Hybrid composition: a tall WebView would exceed the texture size limit
      // of texture-layer composition.
      return AndroidWebViewWidgetCreationParams.fromPlatformWebViewWidgetCreationParams(
        params,
        displayWithHybridComposition: true,
      );
    }
    return params;
  }
}
