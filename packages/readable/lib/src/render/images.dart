// Images: fit-to-width blocks, inline icons, the carousel for consecutive
// images, placeholders for blocked remote images, and an ImageProvider for
// attachments loaded on demand.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/document.dart';
import 'scope.dart';

/// Decodes at most this many physical pixels across, whatever the source.
const _maxDecodeWidth = 2048;

/// Caps decode size to the displayed width (memory), keeping aspect ratio.
ImageProvider sizedProvider(ImageProvider provider, double logicalWidth, double devicePixelRatio) {
  final px = (logicalWidth * devicePixelRatio).round().clamp(1, _maxDecodeWidth);
  return ResizeImage(provider, width: px, policy: ResizeImagePolicy.fit);
}

/// An image attachment fetched through the host's `loadAttachment`.
@immutable
class AttachmentImage extends ImageProvider<AttachmentImage> {
  const AttachmentImage({required this.emailId, required this.partId, required this.load});

  final String emailId;
  final String partId;
  final Future<Uint8List> Function() load;

  @override
  Future<AttachmentImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(AttachmentImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: _decode(decode), scale: 1, debugLabel: 'attachment $partId');

  Future<ui.Codec> _decode(ImageDecoderCallback decode) async {
    final bytes = await load();
    return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is AttachmentImage && other.emailId == emailId && other.partId == partId;

  @override
  int get hashCode => Object.hash(emailId, partId);
}

/// A content image, scaled to fit the width with its aspect ratio.
class BlockImage extends StatelessWidget {
  const BlockImage(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final ref = scope.document.images[index];
    final provider = scope.imageFor(index);
    if (provider == null) return ImagePlaceholder(ref);
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 400.0;
        final w = ref.width;
        final h = ref.height;
        Widget image;
        if (w != null && h != null && w > 0 && h > 0) {
          final width = w < maxWidth ? w : maxWidth;
          image = SizedBox(
            width: width,
            height: width * h / w,
            child: _image(sizedProvider(provider, width, dpr), ref, BoxFit.contain),
          );
        } else {
          final width = w != null && w < maxWidth ? w : maxWidth;
          image = ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width),
            child: _image(sizedProvider(provider, width, dpr), ref, null),
          );
        }
        return Align(
          alignment: AlignmentDirectional.center,
          child: Semantics(
            image: true,
            label: ref.alt,
            child: GestureDetector(
              onTap: () => ref.link != null ? scope.onLinkTap(ref.link!) : scope.onImageTap(index),
              onLongPress: ref.link != null ? () => scope.onLinkLongPress(ref.link!, image: index) : null,
              child: image,
            ),
          ),
        );
      },
    );
  }

  Widget _image(ImageProvider provider, ImageRef ref, BoxFit? fit) => Image(
    image: provider,
    fit: fit,
    gaplessPlayback: true,
    semanticLabel: ref.alt,
    excludeFromSemantics: true,
    errorBuilder: (context, error, stack) => ImagePlaceholder(ref, failed: true),
  );
}

/// A small image inside the text (icons, emoji images), at its declared size
/// scaled like the text.
class InlineIcon extends StatelessWidget {
  const InlineIcon(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final ref = scope.document.images[index];
    final scaler = MediaQuery.textScalerOf(context);
    final w = scaler.scale(ref.width ?? ref.height ?? 20);
    final h = scaler.scale(ref.height ?? ref.width ?? 20);
    final provider = scope.imageFor(index);
    final alt = ref.alt?.trim() ?? '';
    Widget child = provider == null
        // Blocked: the alt text says more than a broken-image glyph.
        ? (alt.isNotEmpty
              ? Text(alt, style: scope.styles.body.copyWith(color: scope.styles.muted, fontSize: 13))
              : Icon(Icons.image_not_supported_outlined, size: h.clamp(10, 20), color: scope.styles.muted))
        : Image(
            image: sizedProvider(provider, w, MediaQuery.devicePixelRatioOf(context)),
            width: w,
            height: h,
            fit: BoxFit.contain,
            semanticLabel: ref.alt,
            errorBuilder: (context, error, stack) => SizedBox(width: w, height: h),
          );
    if (ref.link != null) {
      child = GestureDetector(
        onTap: () => scope.onLinkTap(ref.link!),
        onLongPress: () => scope.onLinkLongPress(ref.link!, image: index),
        child: child,
      );
    }
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 1), child: child);
  }
}

/// Stands in for a blocked remote image (or one that failed): a quiet box
/// with the alt text, so the reader knows something is there.
class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder(this.ref, {super.key, this.failed = false});
  final ImageRef ref;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final alt = ref.alt?.trim() ?? '';
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 300.0;
        final w = ref.width;
        final h = ref.height;
        var height = 44.0;
        if (w != null && h != null && w > 0) {
          height = ((w < maxWidth ? w : maxWidth) * h / w).clamp(32.0, 96.0);
        }
        return Container(
          height: height,
          width: w != null && w < maxWidth ? w : null,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: scheme.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(failed ? Icons.broken_image_outlined : Icons.image_outlined, size: 18, color: scheme.outline),
              if (alt.isNotEmpty) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    alt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Two or more consecutive images: a swipeable strip with page dots. Tapping
/// opens the gallery at that image.
class ImageCarousel extends StatefulWidget {
  const ImageCarousel(this.images, {super.key});
  final List<int> images;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = PageController(viewportFraction: 0.92);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Height/width of the strip: the median of the images with a known size
  /// (one odd portrait shouldn't letterbox all the landscapes).
  double _aspect(ReaderDocument doc) {
    final ratios = [
      for (final i in widget.images)
        if ((doc.images[i].width ?? 0) > 0 && doc.images[i].height != null)
          doc.images[i].height! / doc.images[i].width!,
    ]..sort();
    if (ratios.isEmpty) return 0.75;
    return ratios[ratios.length ~/ 2].clamp(0.4, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    final scope = ReaderScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final count = widget.images.length;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;
        final height = (width * 0.92 * _aspect(scope.document)).clamp(120.0, 520.0);
        return Semantics(
          label: 'Image ${_page + 1} of $count',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                child: PageView.builder(
                  key: const ValueKey('readable-carousel'),
                  controller: _controller,
                  itemCount: count,
                  onPageChanged: (p) => setState(() => _page = p),
                  itemBuilder: (context, i) {
                    final index = widget.images[i];
                    final ref = scope.document.images[index];
                    final provider = scope.imageFor(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => scope.onImageTap(index),
                        onLongPress: ref.link != null ? () => scope.onLinkLongPress(ref.link!, image: index) : null,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ColoredBox(
                            color: scheme.surfaceContainerHigh,
                            child: provider == null
                                ? Center(child: ImagePlaceholder(ref))
                                : Image(
                                    image: sizedProvider(provider, width, dpr),
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: height,
                                    semanticLabel: ref.alt,
                                    errorBuilder: (context, error, stack) =>
                                        Center(child: ImagePlaceholder(ref, failed: true)),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < count; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _page ? 8 : 6,
                      height: i == _page ? 8 : 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _page ? scheme.primary : scheme.outlineVariant,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
