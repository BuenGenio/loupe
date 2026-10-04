import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../shared/bars.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show showSnack;
import '../openpgp/content_loader.dart';
import '../smime/smime_import.dart';
import 'attachment_actions.dart';
import 'attachment_cache.dart';
import 'attachment_gallery.dart';
import 'attachment_icon.dart';
import 'attachment_platform.dart';
import 'attachment_type.dart';
import 'prepared_text.dart';
import 'text_decoding.dart';
import 'viewers/csv_table_view.dart';
import 'viewers/details_card.dart';
import 'viewers/eml_view.dart';
import 'viewers/event_summary.dart';
import 'viewers/monospace_text_view.dart';
import 'viewers/pdf_view.dart';

/// Attachments over this size get the details card instead of a preview
/// (Open in…, Share and Save still work).
const attachmentPreviewLimit = 100 * 1024 * 1024;

/// Above this size, ask before downloading on mobile data.
const largeAttachmentSize = 25 * 1024 * 1024;

enum _Phase { loading, confirm, downloading, ready, failed }

/// One attachment, full screen: the file name and size on top with Share,
/// "Open in…" and Save, and a viewer for its type below: PDF pages, text
/// and code in a monospace view, CSV as a table, a calendar event's
/// summary, an attached message, or a details card for anything else.
/// Images open the gallery (over all images of the message).
///
/// Downloads go through the session's [AttachmentCache], so the actions
/// reuse what the viewer downloaded.
class AttachmentViewerScreen extends ConsumerStatefulWidget {
  const AttachmentViewerScreen({super.key, required this.emailId, required this.partId});

  final String emailId;
  final String partId;

  @override
  ConsumerState<AttachmentViewerScreen> createState() => _AttachmentViewerScreenState();
}

class _AttachmentViewerScreenState extends ConsumerState<AttachmentViewerScreen> {
  final _shareKey = GlobalKey();
  var _phase = _Phase.loading;
  Object? _error;
  EmailContent? _content;
  Attachment? _attachment;
  var _kind = AttachmentKind.other;
  Uint8List? _bytes;
  String? _path;
  PreparedText? _text;
  int? _pages;
  var _page = 1;
  var _wrap = true;

  /// CSV as text instead of the table; a message's source instead of the message.
  var _alternate = false;

  /// Actions (Share, Open in…, Save) still downloading.
  var _busy = 0;

  /// Increases on every (re)load, so a stale load doesn't overwrite a newer one.
  var _generation = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  Future<void> _start() async {
    final generation = ++_generation;
    final cache = ref.read(attachmentCacheProvider);
    final platform = ref.read(attachmentPlatformProvider);
    try {
      final content = _content ?? await ref.read(contentLoaderProvider).loadContent(widget.emailId);
      final attachment = content.attachments.where((a) => a.partId == widget.partId).firstOrNull;
      if (attachment == null) {
        throw const MailException(MailErrorKind.notFound, 'This attachment is no longer available.');
      }
      if (!mounted || generation != _generation) return;
      final kind = attachmentKindOf(attachment.mimeType, attachment.filename);
      setState(() {
        _content = content;
        _attachment = attachment;
        _kind = kind;
      });
      if (kind == AttachmentKind.other || attachment.size > attachmentPreviewLimit) {
        setState(() => _phase = _Phase.ready);
        return;
      }
      if (attachment.size >= largeAttachmentSize &&
          !cache.contains(widget.emailId, attachment.partId) &&
          await platform.isOnMobileData()) {
        if (mounted && generation == _generation) setState(() => _phase = _Phase.confirm);
        return;
      }
      await _download(generation, cache);
    } on Object catch (e) {
      if (mounted && generation == _generation) {
        setState(() {
          _phase = _Phase.failed;
          _error = e;
        });
      }
    }
  }

  Future<void> _download(int generation, AttachmentCache cache) async {
    final a = _attachment!;
    setState(() => _phase = _Phase.downloading);
    final bytes = await cache.bytes(widget.emailId, a);
    final path = _kind == AttachmentKind.pdf ? (await cache.file(widget.emailId, a))?.path : null;
    final text = _isText ? await prepareTextAsync(_kind, bytes) : null;
    if (!mounted || generation != _generation) return;
    setState(() {
      _bytes = bytes;
      _path = path;
      _text = text;
      _phase = _Phase.ready;
    });
  }

  Future<void> _downloadAnyway() async {
    final generation = ++_generation;
    try {
      await _download(generation, ref.read(attachmentCacheProvider));
    } on Object catch (e) {
      if (mounted && generation == _generation) {
        setState(() {
          _phase = _Phase.failed;
          _error = e;
        });
      }
    }
  }

  void _retry() {
    setState(() {
      _phase = _Phase.loading;
      _error = null;
    });
    unawaited(_start());
  }

  bool get _isText => switch (_kind) {
    AttachmentKind.text || AttachmentKind.csv || AttachmentKind.calendar || AttachmentKind.email => true,
    _ => false,
  };

  // Actions -----------------------------------------------------------------

  Future<void> _act(Future<void> Function(AttachmentActions actions, ScaffoldMessengerState messenger) run) async {
    final a = _attachment;
    if (a == null) return;
    final actions = AttachmentActions.of(ref, widget.emailId, a);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy++);
    try {
      await run(actions, messenger);
    } finally {
      if (mounted) setState(() => _busy--);
    }
  }

  Rect? _shareOrigin() {
    final box = _shareKey.currentContext?.findRenderObject();
    return box is RenderBox && box.hasSize ? box.localToGlobal(Offset.zero) & box.size : null;
  }

  void _share() => _act((a, m) => a.share(m, origin: _shareOrigin()));
  void _openIn() => _act((a, m) => a.openIn(m));
  void _save() => _act((a, m) => a.save(m));

  Future<void> _copy() async {
    final bytes = _bytes;
    if (bytes == null) return;
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: decodeAttachmentText(bytes).text));
    showSnack(messenger, 'Copied');
  }

  Future<void> _openGallery() async {
    final content = _content, a = _attachment;
    if (content == null || a == null) return;
    await openAttachmentGallery(context, content: content, current: a, cache: ref.read(attachmentCacheProvider));
  }

  // Layout ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final a = _attachment;
    final size = _bytes?.length ?? a?.size ?? 0;
    final pages = _pages;
    final subtitle = a == null
        ? null
        : [
            describeFileType(a.mimeType, a.filename),
            if (size > 0) formatBytes(size),
            if (pages != null) pages == 1 ? '1 page' : '$pages pages',
          ].join(' · ');
    final enabled = a != null && _busy == 0;
    return Scaffold(
      backgroundColor: _kind == AttachmentKind.pdf && _phase == _Phase.ready ? colors.groupedBackground : null,
      bottomNavigationBar: _bottomBar(context),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          LoupeTitleBar(
            title: a?.filename?.isNotEmpty == true ? a!.filename! : 'Attachment',
            subtitle: subtitle == null ? null : Text(subtitle, key: const Key('attachment-subtitle')),
            trailing: [
              BarIconButton(
                key: _shareKey,
                icon: LoupeIcons.share,
                tooltip: 'Share',
                onPressed: enabled ? _share : null,
              ),
              BarIconButton(icon: LoupeIcons.openIn, tooltip: 'Open in…', onPressed: enabled ? _openIn : null),
              BarIconButton(icon: LoupeIcons.save, tooltip: 'Save', onPressed: enabled ? _save : null),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 2, child: _busy > 0 ? const LinearProgressIndicator(minHeight: 2) : null),
                Expanded(child: _body(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    switch (_phase) {
      case _Phase.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
      case _Phase.failed:
        final e = _error;
        return _Message(
          icon: LoupeIcons.fileError,
          text: e is MailException ? e.message : "The attachment couldn't be downloaded.",
          action: TextButton(onPressed: _retry, child: const Text('Try Again')),
        );
      case _Phase.confirm:
        final a = _attachment!;
        return _Message(
          icon: LoupeIcons.mobileData,
          title: '${formatBytes(a.size)} on mobile data',
          text: 'This attachment is large. Download it now, or later on Wi-Fi.',
          action: FilledButton.tonal(onPressed: _downloadAnyway, child: const Text('Download')),
        );
      case _Phase.downloading:
        final a = _attachment!;
        return Center(
          child: Column(
            key: const Key('attachment-downloading'),
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(attachmentIcon(a.mimeType, a.filename), size: 40, color: colors.secondaryText),
              const SizedBox(height: 16),
              const SizedBox(width: 180, child: LinearProgressIndicator()),
              const SizedBox(height: 10),
              Text(
                a.size > 0 ? 'Downloading ${formatBytes(a.size)}…' : 'Downloading…',
                style: styles.footnote.copyWith(color: colors.secondaryText),
              ),
            ],
          ),
        );
      case _Phase.ready:
        return _viewer(context);
    }
  }

  Widget _details({String? note}) => AttachmentDetailsCard(
    attachment: _attachment!,
    size: _bytes?.length,
    note: note,
    busy: _busy > 0,
    onOpenIn: _openIn,
    onShare: _share,
    action: isCertificateAttachment(_attachment!)
        ? SmimeImportButton(load: () => ref.read(attachmentCacheProvider).bytes(widget.emailId, _attachment!))
        : null,
  );

  Widget _viewer(BuildContext context) {
    final a = _attachment!;
    final bytes = _bytes;
    if (_kind == AttachmentKind.other) return _details();
    if (bytes == null) return _details(note: 'Too large to preview here.');
    final text = _text;
    final emailId = widget.emailId;
    return switch (_kind) {
      AttachmentKind.image => _ImageBody(bytes: bytes, onOpenGallery: _openGallery),
      AttachmentKind.pdf => _pdf(context, bytes),
      AttachmentKind.csv when text?.table != null && !_alternate => CsvTableView(data: text!.table!),
      AttachmentKind.calendar when text != null && text.events.isNotEmpty => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EventSummaryCard(events: text.events),
          Expanded(child: _monospace(text)),
        ],
      ),
      AttachmentKind.email when text?.message != null && !_alternate => EmlView(
        message: text!.message!,
        emailId: 'attachment:$emailId#${a.partId}',
      ),
      _ when text != null => _monospace(text),
      _ => _details(),
    };
  }

  Widget _monospace(PreparedText text) {
    final colors = LoupeColors.of(context);
    return MonospaceTextView(
      lines: text.lines,
      wrap: _wrap,
      header: text.cut
          ? Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Text(
                'Showing the first ${formatBytes(PreparedText.displayLimit)} of ${formatBytes(_bytes!.length)}. '
                'Copy, share or save to get all of it.',
                style: TextStyle(color: colors.secondaryText, fontSize: 13),
              ),
            )
          : null,
    );
  }

  Widget _pdf(BuildContext context, Uint8List bytes) {
    final build = ref.watch(pdfViewBuilderProvider);
    final pages = _pages;
    return Stack(
      children: [
        Positioned.fill(
          child: build(
            path: _path,
            bytes: bytes,
            onPageCount: (n) {
              if (mounted && n != _pages) setState(() => _pages = n);
            },
            onPageChanged: (p) {
              if (mounted && p != _page) setState(() => _page = p);
            },
            error: _details(note: "This PDF can't be shown here (it may be protected with a password)."),
          ),
        ),
        if (pages != null && pages > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16 + MediaQuery.paddingOf(context).bottom,
            child: Center(
              child: IgnorePointer(
                child: Container(
                  key: const Key('pdf-page-indicator'),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${_page.clamp(1, pages)} of $pages',
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Text kinds: wrap, a view switch (table or text, message or source) or
  /// the charset, and Copy.
  Widget? _bottomBar(BuildContext context) {
    final text = _text;
    if (_phase != _Phase.ready || text == null || _bytes == null) return null;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final modes = switch (_kind) {
      AttachmentKind.csv when text.table != null => ('Table', 'Text'),
      AttachmentKind.email when text.message != null => ('Message', 'Source'),
      _ => null,
    };
    final monospace = modes == null || _alternate;
    final lines = text.lines.rows.length;
    return LoupeBottomBar(
      leading: monospace
          ? BarIconButton(
              key: const Key('attachment-wrap'),
              icon: _wrap ? LoupeIcons.wrapFilled : LoupeIcons.wrap,
              tooltip: _wrap ? "Don't Wrap Lines" : 'Wrap Lines',
              onPressed: () => setState(() => _wrap = !_wrap),
            )
          : null,
      center: modes != null
          ? CupertinoSlidingSegmentedControl<bool>(
              key: const Key('attachment-mode'),
              groupValue: _alternate,
              onValueChanged: (v) => setState(() => _alternate = v ?? false),
              children: {
                false: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(modes.$1)),
                true: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(modes.$2)),
              },
            )
          : Text(
              '${text.charset} · ${formatCount(lines)} ${lines == 1 ? 'line' : 'lines'}',
              key: const Key('attachment-text-info'),
              style: styles.footnote.copyWith(color: colors.secondaryText),
            ),
      trailing: BarIconButton(icon: LoupeIcons.copy, tooltip: 'Copy All', onPressed: _copy),
    );
  }
}

/// An image, zoomable; a tap opens the gallery.
class _ImageBody extends StatelessWidget {
  const _ImageBody({required this.bytes, required this.onOpenGallery});

  final Uint8List bytes;
  final VoidCallback onOpenGallery;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onOpenGallery,
    child: InteractiveViewer(
      maxScale: 6,
      child: Center(
        child: Image.memory(
          bytes,
          key: const Key('attachment-image'),
          fit: BoxFit.contain,
          gaplessPlayback: true,
          errorBuilder: (context, _, _) =>
              const _Message(icon: LoupeIcons.fileError, text: "This image can't be shown here. Try Open in…."),
        ),
      ),
    ),
  );
}

/// A centred icon, an optional title, a message and an action.
class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text, this.title, this.action});

  final IconData icon;
  final String? title;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: colors.secondaryText),
            const SizedBox(height: 12),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: styles.body.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.secondaryText),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
