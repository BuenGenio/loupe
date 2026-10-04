// The stateful body of ReadableMessageView: runs the pipeline (in an isolate
// for big messages, cached), then renders Readable, Plain or Original.

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../api.dart';
import '../cache.dart';
import '../color/color_adapter.dart';
import '../model/document.dart';
import '../pipeline/original_html.dart';
import '../pipeline/pipeline.dart';
import '../pipeline/plain_text.dart';
import 'banner.dart';
import 'blocks.dart';
import 'gallery.dart';
import 'images.dart';
import 'link_actions.dart';
import 'original_view.dart';
import 'scope.dart';

/// Messages smaller than this are processed synchronously: spawning an
/// isolate costs more than parsing them, and the first frame is complete.
const _syncThreshold = 24 * 1024;

class ReaderView extends StatefulWidget {
  const ReaderView({
    super.key,
    required this.content,
    required this.settings,
    required this.remoteContent,
    this.onAllowRemoteContent,
    this.onOpenLink,
    this.loadAttachment,
    this.onSuggestOriginal,
    this.senderDomain,
    this.backgroundColor,
  });

  final EmailContent content;
  final ReaderSettings settings;
  final RemoteContentPolicy remoteContent;
  final void Function({required bool always})? onAllowRemoteContent;
  final void Function(Uri uri)? onOpenLink;
  final Future<Uint8List> Function(Attachment attachment)? loadAttachment;
  final VoidCallback? onSuggestOriginal;
  final String? senderDomain;
  final Color? backgroundColor;

  /// Tests: run every message synchronously (no isolate).
  @visibleForTesting
  static bool debugSynchronous = false;

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  PipelineOutput? _output;
  int _generation = 0;

  /// The user tapped "Load images" for this message.
  bool _allowedHere = false;
  bool _suggested = false;
  final _providers = <int, ImageProvider?>{};
  ColorAdapter? _adapter;

  /// Original view: `data:` URIs for the `cid:` images of the page.
  final _cidUris = <String, String>{};
  (OriginalHtml, bool, int, String)? _pageKey;
  String _page = '';

  EmailContent get _content => widget.content;
  bool get _remoteAllowed => widget.remoteContent == RemoteContentPolicy.allow || _allowedHere;
  ReaderDocument get _doc => _output?.document ?? ReaderDocument.empty;

  PipelineMode get _mode => switch (widget.settings.mode) {
    ReaderMode.readable => PipelineMode.readable,
    ReaderMode.plain => PipelineMode.plain,
    // Without a WebView (tests, desktop) Original shows the Readable view.
    ReaderMode.original => originalViewAvailable ? PipelineMode.original : PipelineMode.readable,
  };

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(ReaderView old) {
    super.didUpdateWidget(old);
    final sameMessage = old.content.emailId == widget.content.emailId;
    if (!sameMessage) {
      _allowedHere = false;
      _suggested = false;
    }
    if (!sameMessage || !identical(old.content, widget.content) || old.settings.mode != widget.settings.mode) {
      _load();
    } else if (old.remoteContent != widget.remoteContent || old.loadAttachment != widget.loadAttachment) {
      _providers.clear();
    }
  }

  // -- Pipeline --------------------------------------------------------------

  void _load() {
    final generation = ++_generation;
    final c = _content;
    final mode = _mode;
    final input = PipelineInput(
      mode: mode,
      html: c.html,
      text: c.text,
      isFlowed: c.isFlowed,
      contentIds: {
        for (final id in c.inlineData.keys) _normalizeCid(id),
        for (final a in c.attachments)
          if (a.contentId != null) _normalizeCid(a.contentId!),
      },
    );
    final PipelineKey key = (
      c.emailId,
      mode,
      c.html?.length ?? -1,
      c.text?.length ?? -1,
      Object.hash(sampleHash(c.html), sampleHash(c.text)),
      c.isFlowed,
    );
    _providers.clear();
    _cidUris.clear();
    _pageKey = null;
    final cached = PipelineCache.instance[key];
    if (cached != null) {
      _output = cached;
      _afterLoad();
      return;
    }
    if (input.size <= _syncThreshold || ReaderView.debugSynchronous) {
      _output = PipelineCache.instance[key] = _runSafely(input);
      _afterLoad();
      return;
    }
    _output = null;
    runPipelineInIsolate(input).then<void>(
      (out) {
        PipelineCache.instance[key] = out;
        if (!mounted || generation != _generation) return;
        setState(() => _output = out);
        _afterLoad();
      },
      onError: (Object error, StackTrace stack) {
        if (!mounted || generation != _generation) return;
        setState(() => _output = _fallback(input));
      },
    );
  }

  PipelineOutput _runSafely(PipelineInput input) {
    try {
      return runPipeline(input);
    } catch (error, stack) {
      FlutterError.reportError(FlutterErrorDetails(exception: error, stack: stack, library: 'readable'));
      return _fallback(input);
    }
  }

  /// Last resort: the text part, or the HTML with tags crudely removed.
  PipelineOutput _fallback(PipelineInput input) {
    final text = input.hasText
        ? input.text!
        : (input.html ?? '')
              .replaceAll(RegExp(r'<(style|script|head)[^>]*>.*?</\1>', caseSensitive: false, dotAll: true), '')
              .replaceAll(RegExp(r'<br\s*/?>|</p>|</div>|</tr>', caseSensitive: false), '\n')
              .replaceAll(RegExp(r'<[^>]{0,2000}>'), '')
              .replaceAll('&nbsp;', ' ')
              .replaceAll('&amp;', '&');
    return PipelineOutput(document: parsePlainText(text.length > 200000 ? text.substring(0, 200000) : text));
  }

  void _afterLoad() {
    final out = _output;
    if (out?.original != null) _resolveOriginalCids(out!.original!);
    if (out == null || _suggested || widget.settings.mode != ReaderMode.readable) return;
    if (!out.document.stats.suggestOriginal || widget.onSuggestOriginal == null) return;
    _suggested = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onSuggestOriginal?.call();
    });
  }

  // -- Original view -----------------------------------------------------------

  /// A WebView can't resolve `cid:`; inline parts become `data:` URIs, and
  /// parts that must be downloaded are added when they arrive.
  void _resolveOriginalCids(OriginalHtml original) {
    final generation = _generation;
    for (final cid in original.contentIds) {
      final bytes = _inlineBytes(cid);
      if (bytes != null) {
        _cidUris[cid] = _dataUri(bytes, _attachmentFor(cid)?.mimeType);
        continue;
      }
      final attachment = _attachmentFor(cid);
      final load = widget.loadAttachment;
      if (attachment == null || load == null) continue;
      unawaited(
        load(attachment).then((bytes) {
          if (!mounted || generation != _generation) return;
          setState(() => _cidUris[cid] = _dataUri(bytes, attachment.mimeType));
        }, onError: (Object _) {}),
      );
    }
  }

  Uint8List? _inlineBytes(String cid) {
    final data = _content.inlineData;
    final direct = data[cid] ?? data['<$cid>'];
    if (direct != null) return direct;
    for (final e in data.entries) {
      if (_normalizeCid(e.key).toLowerCase() == cid.toLowerCase()) return e.value;
    }
    return null;
  }

  Attachment? _attachmentFor(String cid) => _content.attachments
      .where((a) => a.contentId != null && _normalizeCid(a.contentId!).toLowerCase() == cid.toLowerCase())
      .firstOrNull;

  static String _dataUri(Uint8List bytes, String? mimeType) {
    var mime = mimeType?.toLowerCase();
    if (mime == null || !mime.startsWith('image/')) {
      mime = switch (bytes) {
        [0x89, 0x50, 0x4E, 0x47, ...] => 'image/png',
        [0xFF, 0xD8, ...] => 'image/jpeg',
        [0x47, 0x49, 0x46, ...] => 'image/gif',
        [0x52, 0x49, 0x46, 0x46, ...] => 'image/webp',
        _ => 'application/octet-stream',
      };
    }
    return 'data:$mime;base64,${base64Encode(bytes)}';
  }

  Widget _original(BuildContext context, OriginalHtml original) {
    final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
    final ios = Theme.of(context).platform == TargetPlatform.iOS;
    // Android scales text with setTextZoom; iOS through CSS.
    final css = ios && (scale - 1).abs() > 0.01 ? 'html{-webkit-text-size-adjust:${(scale * 100).round()}%}' : '';
    final key = (original, _remoteAllowed, _cidUris.length, css);
    if (_pageKey != key) {
      _pageKey = key;
      _page = buildOriginalPage(original, allowRemote: _remoteAllowed, cidDataUris: Map.of(_cidUris), extraCss: css);
    }
    final view = buildOriginalView(
      context,
      OriginalViewRequest(html: _page, onOpenLink: widget.onOpenLink, textScale: scale),
    );
    if (_remoteAllowed || original.remoteImages == 0) return view;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [_banner(), const SizedBox(height: 16), view],
    );
  }

  Widget _banner() => RemoteContentBanner(
    senderDomain: _senderDomain,
    onLoad: () => _allow(always: false),
    onAlways: widget.onAllowRemoteContent == null ? null : () => _allow(always: true),
  );

  // -- Images ----------------------------------------------------------------

  static String _normalizeCid(String id) => id.trim().replaceAll(RegExp(r'^<|>$'), '');

  ImageProvider? _imageFor(int index) => _providers.putIfAbsent(index, () {
    final images = _doc.images;
    if (index < 0 || index >= images.length) return null;
    return switch (images[index].source) {
      RemoteImageSource(:final url) => _remoteAllowed ? NetworkImage(url) : null,
      DataImageSource(:final bytes) => MemoryImage(bytes),
      CidImageSource(:final contentId) => _cidImage(contentId),
      AttachmentImageSource(:final partId) => _attachmentImage(
        _content.attachments.where((a) => a.partId == partId).firstOrNull,
      ),
    };
  });

  ImageProvider? _cidImage(String contentId) {
    final data = _content.inlineData;
    final bytes = data[contentId] ?? data['<$contentId>'];
    if (bytes != null) return MemoryImage(bytes);
    for (final e in data.entries) {
      if (_normalizeCid(e.key).toLowerCase() == contentId.toLowerCase()) return MemoryImage(e.value);
    }
    final attachment = _content.attachments
        .where((a) => a.contentId != null && _normalizeCid(a.contentId!).toLowerCase() == contentId.toLowerCase())
        .firstOrNull;
    return _attachmentImage(attachment);
  }

  ImageProvider? _attachmentImage(Attachment? attachment) {
    final load = widget.loadAttachment;
    if (attachment == null || load == null) return null;
    return AttachmentImage(emailId: _content.emailId, partId: attachment.partId, load: () => load(attachment));
  }

  /// Every image of the message for the gallery: content images (not icons)
  /// in order, then image attachments the body doesn't show.
  List<(int?, GalleryItem)> _galleryItems() {
    final items = <(int?, GalleryItem)>[];
    final shownCids = <String>{};
    for (final (i, ref) in _doc.images.indexed) {
      final source = ref.source;
      if (source is CidImageSource) shownCids.add(source.contentId.toLowerCase());
      if (ref.icon) continue;
      final provider = _imageFor(i);
      if (provider == null) continue;
      items.add((i, (image: provider, caption: _caption(ref.alt))));
    }
    for (final a in _content.attachments) {
      if (!a.isImage) continue;
      final cid = a.contentId == null ? null : _normalizeCid(a.contentId!).toLowerCase();
      if (cid != null && shownCids.contains(cid)) continue;
      final provider = _attachmentImage(a);
      if (provider != null) items.add((null, (image: provider, caption: a.filename)));
    }
    return items;
  }

  /// Alt text worth showing (not a file name or a placeholder).
  static String? _caption(String? alt) {
    final a = alt?.trim();
    if (a == null || a.isEmpty) return null;
    if (RegExp(r'^[\w-]+\.(png|jpe?g|gif|webp|heic)$', caseSensitive: false).hasMatch(a)) return null;
    if (const {'image', 'img', 'photo', 'picture'}.contains(a.toLowerCase())) return null;
    return a;
  }

  void _openGallery(int index) {
    final items = _galleryItems();
    final at = items.indexWhere((e) => e.$1 == index);
    if (at < 0) return;
    unawaited(pushGallery(context, [for (final e in items) e.$2], at));
  }

  // -- Links -----------------------------------------------------------------

  void _onLinkTap(int link) {
    final links = _doc.links;
    if (link < 0 || link >= links.length) return;
    unawaited(openLink(context, links[link], widget.onOpenLink));
  }

  void _onLinkLongPress(int link, {int? image}) {
    final links = _doc.links;
    if (link < 0 || link >= links.length) return;
    unawaited(
      showLinkSheet(
        context,
        links[link],
        onOpen: widget.onOpenLink,
        onViewImage: image == null ? null : () => _openGallery(image),
      ),
    );
  }

  // -- Remote content --------------------------------------------------------

  void _allow({required bool always}) {
    setState(() {
      _allowedHere = true;
      _providers.clear();
    });
    widget.onAllowRemoteContent?.call(always: always);
  }

  String? get _senderDomain {
    final explicit = widget.senderDomain;
    if (explicit != null) return explicit;
    for (final (name, value) in _content.headers) {
      if (name.toLowerCase() != 'from') continue;
      final m = RegExp(r'[\w.+-]+@([\w-]+(?:\.[\w-]+)+)').firstMatch(value);
      return m?[1]?.toLowerCase();
    }
    return null;
  }

  // -- Build -----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final scale = widget.settings.textScale.clamp(0.8, 1.6);
    return MediaQuery(
      data: mq.copyWith(textScaler: MultipliedTextScaler(mq.textScaler, scale)),
      child: Builder(builder: _buildBody),
    );
  }

  Widget _buildBody(BuildContext context) {
    final out = _output;
    if (out == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2.5))),
      );
    }
    final original = out.original;
    if (original != null && widget.settings.mode == ReaderMode.original) return _original(context, original);
    final plain = widget.settings.mode == ReaderMode.plain;
    final doc = out.document;
    final showBanner = !plain && !_remoteAllowed && doc.stats.remoteImages > 0;
    final body = _document(context, doc, plain: plain, mono: plain && widget.settings.plainFont == PlainTextFont.mono);
    if (!showBanner) return body;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [_banner(), const SizedBox(height: 16), body],
    );
  }

  Widget _document(BuildContext context, ReaderDocument doc, {required bool plain, required bool mono}) {
    final styles = ReaderStyles.of(context, monoBody: mono);
    final page = widget.backgroundColor ?? Theme.of(context).colorScheme.surface;
    final text = styles.body.color ?? Theme.of(context).colorScheme.onSurface;
    ColorAdapter? colors;
    if (!widget.settings.keepOriginalColors) {
      final current = _adapter;
      colors = current != null && current.page == page.toARGB32() && current.text == text.toARGB32()
          ? current
          : _adapter = ColorAdapter(page: page.toARGB32(), text: text.toARGB32());
    }
    return ReaderScope(
      document: doc,
      styles: styles,
      colors: colors,
      imageFor: _imageFor,
      onImageTap: _openGallery,
      onLinkTap: _onLinkTap,
      onLinkLongPress: _onLinkLongPress,
      remoteAllowed: _remoteAllowed,
      child: SelectionArea(child: BlockList(doc.blocks)),
    );
  }
}
