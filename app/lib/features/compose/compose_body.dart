import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../signatures/signature_render.dart';
import 'compose_text.dart';

/// The compose body: plain text, with the signature drawn as it will look
/// (formatting and images) while it stands as inserted. Its images are
/// U+FFFC in the text, one each. Once the user edits the signature it is
/// plain text like the rest (the compose screen drops [signature]).
class ComposeBodyController extends TextEditingController {
  ComposeBodyController();

  /// The signature in the body, as inserted; null for none or an edited one.
  RenderedSignature? signature;

  /// The block [signature] makes in the body ("-- " line included).
  String? get block => switch (signature) {
    final s? when !s.isEmpty => ComposeText.signatureBlock(s.display),
    _ => null,
  };

  /// Where [signature] stands in the text, if unchanged.
  (int, int)? intactRange() {
    final b = block;
    if (b == null) return null;
    final range = ComposeText.signatureRange(text, block: b);
    if (range == null || text.substring(range.$1, range.$2) != b) return null;
    return range;
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final s = signature;
    final range = s == null ? null : intactRange();
    if (s == null || range == null) {
      return super.buildTextSpan(context: context, style: style, withComposing: withComposing);
    }
    final composing = withComposing && value.isComposingRangeValid ? value.composing : TextRange.empty;
    final (start, end) = range;
    // The "-- " line, then the signature's display text.
    final sigStart = start + 4;
    return TextSpan(
      style: style,
      children: [
        ..._plain(text.substring(0, sigStart), 0, composing),
        ..._signatureSpans(context, s, sigStart, style),
        ..._plain(text.substring(end), end, composing),
      ],
    );
  }

  /// [part] (at [offset]) with the IME's composing range underlined.
  List<InlineSpan> _plain(String part, int offset, TextRange composing) {
    if (part.isEmpty) return const [];
    final a = (composing.start - offset).clamp(0, part.length);
    final b = (composing.end - offset).clamp(0, part.length);
    if (!composing.isValid || a >= b) return [TextSpan(text: part)];
    return [
      if (a > 0) TextSpan(text: part.substring(0, a)),
      TextSpan(
        text: part.substring(a, b),
        style: const TextStyle(decoration: TextDecoration.underline),
      ),
      if (b < part.length) TextSpan(text: part.substring(b)),
    ];
  }

  List<InlineSpan> _signatureSpans(BuildContext context, RenderedSignature s, int offset, TextStyle? base) {
    final display = s.display;
    final spans = <InlineSpan>[];
    var image = 0;
    var i = 0;
    final runs = s.runs;
    var r = 0;
    final baseSize = base?.fontSize ?? 16;
    while (i < display.length) {
      if (display[i] == objectReplacement) {
        final img = image < s.images.length ? s.images[image] : null;
        image++;
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: img == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Image.memory(
                      img.data,
                      width: img.width,
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
          ),
        );
        i++;
        continue;
      }
      // The next stretch without images, split at run edges.
      while (r < runs.length && runs[r].end <= i) {
        r++;
      }
      final run = r < runs.length && runs[r].start <= i ? runs[r] : null;
      var stop = run?.end ?? (r < runs.length ? runs[r].start : display.length);
      final next = display.indexOf(objectReplacement, i);
      if (next >= 0 && next < stop) stop = next;
      spans.add(
        TextSpan(text: display.substring(i, stop), style: run == null ? null : _style(context, run.style, baseSize)),
      );
      i = stop;
    }
    return spans;
  }

  static TextStyle _style(BuildContext context, SignatureStyle s, double baseSize) {
    final scale = SignatureStyle.sizeScale[s.size];
    final points = scale == null ? double.tryParse(s.size ?? '') : null;
    return TextStyle(
      fontWeight: s.bold ? FontWeight.w700 : null,
      fontStyle: s.italic ? FontStyle.italic : null,
      decoration: s.underline || s.link != null ? TextDecoration.underline : null,
      color: s.link != null ? Theme.of(context).colorScheme.primary : _color(s.color),
      fontSize: scale != null ? baseSize * scale : points,
      fontFamily: s.font,
    );
  }

  static Color? _color(String? hex) {
    if (hex == null) return null;
    final v = int.tryParse(hex.substring(1), radix: 16);
    return v == null ? null : Color(0xff000000 | v);
  }

  /// The body as the message's plain text: the signature as plain-text
  /// readers get it (links with their address), no U+FFFC. With the HTML
  /// and its images when the signature is formatted.
  ({String text, String? html, List<OutgoingAttachment> inline}) toMessage() {
    final s = signature;
    final range = s == null ? null : intactRange();
    if (s == null || range == null) return (text: text.replaceAll(objectReplacement, ''), html: null, inline: const []);
    final before = text.substring(0, range.$1);
    final after = text.substring(range.$2);
    final plain = '$before${ComposeText.signatureBlock(s.plain)}$after'.replaceAll(objectReplacement, '');
    if (!s.isRich) return (text: plain, html: null, inline: const []);
    final parts = s.toHtml();
    return (
      text: plain,
      html: messageHtml(before.replaceAll(objectReplacement, ''), parts.html, after.replaceAll(objectReplacement, '')),
      inline: parts.inline,
    );
  }
}
