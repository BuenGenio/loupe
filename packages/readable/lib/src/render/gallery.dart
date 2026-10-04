// Full-screen image gallery: swipe between images, pinch or double-tap to
// zoom, dark background, close button and a counter.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icons.dart';

/// One gallery page (mirrors the public `GalleryImage`, kept separate so the
/// render code doesn't import the API file).
typedef GalleryItem = ({ImageProvider image, String? caption});

/// Pushes the gallery as a full-screen route.
Future<void> pushGallery(BuildContext context, List<GalleryItem> items, int initialIndex) {
  if (items.isEmpty) return Future.value();
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 160),
      pageBuilder: (context, animation, secondary) =>
          ImageGalleryPage(items: items, initialIndex: initialIndex.clamp(0, items.length - 1)),
      transitionsBuilder: (context, animation, secondary, child) => FadeTransition(opacity: animation, child: child),
    ),
  );
}

class ImageGalleryPage extends StatefulWidget {
  const ImageGalleryPage({super.key, required this.items, this.initialIndex = 0});

  final List<GalleryItem> items;
  final int initialIndex;

  @override
  State<ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  late final PageController _pages = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;
  bool _zoomed = false;
  bool _chrome = true;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final caption = items[_index].caption;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              key: const ValueKey('readable-gallery'),
              controller: _pages,
              // While zoomed, horizontal drags pan the image instead of paging.
              physics: _zoomed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
              itemCount: items.length,
              onPageChanged: (i) => setState(() {
                _index = i;
                _zoomed = false;
              }),
              itemBuilder: (context, i) => _ZoomableImage(
                image: items[i].image,
                semanticLabel: items[i].caption,
                onZoomChanged: (z) {
                  if (z != _zoomed) setState(() => _zoomed = z);
                },
                onTap: () => setState(() => _chrome = !_chrome),
              ),
            ),
            AnimatedOpacity(
              opacity: _chrome ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: IgnorePointer(
                ignoring: !_chrome,
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                            color: Colors.white,
                            icon: const Icon(ReadableIcons.close),
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                          Expanded(
                            child: Text(
                              items.length > 1 ? '${_index + 1} / ${items.length}' : '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const Spacer(),
                      if (caption != null && caption.isNotEmpty)
                        Container(
                          width: double.infinity,
                          color: Colors.black54,
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                          child: Text(
                            caption,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  const _ZoomableImage({required this.image, required this.onZoomChanged, required this.onTap, this.semanticLabel});

  final ImageProvider image;
  final String? semanticLabel;
  final ValueChanged<bool> onZoomChanged;
  final VoidCallback onTap;

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> with SingleTickerProviderStateMixin {
  final _transform = TransformationController();
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  )..addListener(() => _transform.value = _tween?.evaluate(_animation) ?? _transform.value);
  Matrix4Tween? _tween;
  Offset? _doubleTapAt;

  @override
  void initState() {
    super.initState();
    _transform.addListener(_reportZoom);
  }

  @override
  void dispose() {
    _animation.dispose();
    _transform.dispose();
    super.dispose();
  }

  void _reportZoom() => widget.onZoomChanged(_transform.value.getMaxScaleOnAxis() > 1.01);

  void _toggleZoom() {
    final zoomedIn = _transform.value.getMaxScaleOnAxis() > 1.01;
    final at = _doubleTapAt ?? Offset.zero;
    final target = zoomedIn
        ? Matrix4.identity()
        : (Matrix4.identity()
            ..translateByDouble(-at.dx * 1.5, -at.dy * 1.5, 0, 1)
            ..scaleByDouble(2.5, 2.5, 1, 1));
    _tween = Matrix4Tween(begin: _transform.value, end: target);
    _animation.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTapDown: (d) => _doubleTapAt = d.localPosition,
      onDoubleTap: _toggleZoom,
      child: InteractiveViewer(
        transformationController: _transform,
        minScale: 1,
        maxScale: 6,
        child: SizedBox.expand(
          child: Image(
            // Enough pixels to zoom into, without decoding a 50-megapixel
            // photo at full size.
            image: ResizeImage(widget.image, width: 4096, height: 4096, policy: ResizeImagePolicy.fit),
            fit: BoxFit.contain,
            semanticLabel: widget.semanticLabel,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const Center(child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 2)),
            errorBuilder: (context, error, stack) =>
                const Center(child: Icon(ReadableIcons.imageBroken, color: Colors.white54, size: 48)),
          ),
        ),
      ),
    );
  }
}
