import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../compose/compose_screen.dart' show mimeTypeFor;

/// An image made ready for a signature: at most [maxPixels] wide, as a
/// `data:` URI, shown at most 300 logical pixels wide ([width]), so a wide
/// one stays sharp on phones.
typedef SignatureImageData = ({String dataUri, int width});

/// The widest a signature image is kept, in pixels.
const maxPixels = 600;

/// The most a signature image may weigh once prepared.
const maxBytes = 512 * 1024;

/// Prepares [bytes] (a file called [name]) for a signature: small PNG,
/// JPEG and GIF files stay as they are; others are scaled down to
/// [maxPixels] and saved as PNG. Null when it is still too large; throws
/// when it isn't an image.
Future<SignatureImageData?> prepareSignatureImage(Uint8List bytes, String name) async {
  final mime = mimeTypeFor(name);
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final pixels = frame.image.width;
  frame.image.dispose();
  codec.dispose();
  var out = bytes;
  var type = mime;
  var width = pixels;
  const kept = {'image/png', 'image/jpeg', 'image/gif'};
  if (pixels > maxPixels || bytes.length > 300 * 1024 || !kept.contains(mime)) {
    final scaled = await ui.instantiateImageCodec(bytes, targetWidth: min(pixels, maxPixels));
    final f = await scaled.getNextFrame();
    final png = await f.image.toByteData(format: ui.ImageByteFormat.png);
    width = f.image.width;
    f.image.dispose();
    scaled.dispose();
    if (png == null) return null;
    out = png.buffer.asUint8List();
    type = 'image/png';
  }
  if (out.length > maxBytes) return null;
  return (dataUri: 'data:$type;base64,${base64Encode(out)}', width: min(width, 300));
}
