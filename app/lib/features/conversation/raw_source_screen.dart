import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers.dart';
import '../../shared/format.dart';
import '../../theme/theme.dart';
import 'sheets.dart';

/// Decodes a raw message: UTF-8 if valid, otherwise Latin-1 (8-bit parts in
/// legacy charsets).
String decodeRawSource(List<int> bytes) {
  try {
    return utf8.decode(bytes);
  } on FormatException {
    return latin1.decode(bytes);
  }
}

/// The raw RFC 822 message as selectable monospace text, with line wrapping
/// on or off, copy and share (as an .eml file).
class RawSourceScreen extends ConsumerStatefulWidget {
  const RawSourceScreen({super.key, required this.emailId});

  final String emailId;

  @override
  ConsumerState<RawSourceScreen> createState() => _RawSourceScreenState();
}

class _RawSourceScreenState extends ConsumerState<RawSourceScreen> {
  /// Longer sources are cut for display; copy and share use everything.
  static const _displayLimit = 512 * 1024;

  late Future<Uint8List> _raw = _load();
  bool _wrap = true;

  Future<Uint8List> _load() => ref.read(repositoryProvider).loadRawSource(widget.emailId);

  @override
  void didUpdateWidget(RawSourceScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.emailId != widget.emailId) _raw = _load();
  }

  Future<void> _copy(Uint8List bytes) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: decodeRawSource(bytes)));
    showSnack(messenger, 'Source copied');
  }

  Future<void> _share(Uint8List bytes) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(bytes, name: 'message.eml', mimeType: 'message/rfc822')],
          fileNameOverrides: const ['message.eml'],
        ),
      );
    } on Exception {
      showSnack(messenger, "Couldn't share the message.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return FutureBuilder<Uint8List>(
      future: _raw,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Source'),
            actions: [
              IconButton(
                key: const Key('source-wrap'),
                tooltip: _wrap ? "Don't Wrap Lines" : 'Wrap Lines',
                isSelected: _wrap,
                icon: const Icon(Icons.wrap_text),
                onPressed: () => setState(() => _wrap = !_wrap),
              ),
              IconButton(
                tooltip: 'Copy',
                icon: const Icon(Icons.copy),
                onPressed: bytes == null ? null : () => _copy(bytes),
              ),
              IconButton(
                tooltip: 'Share',
                icon: Icon(Icons.adaptive.share),
                onPressed: bytes == null ? null : () => _share(bytes),
              ),
            ],
          ),
          body: switch (snapshot) {
            AsyncSnapshot(hasError: true, :final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      error is MailException ? error.message : "The source couldn't be loaded.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.secondaryText),
                    ),
                    TextButton(onPressed: () => setState(() => _raw = _load()), child: const Text('Try Again')),
                  ],
                ),
              ),
            ),
            AsyncSnapshot(hasData: true, data: final b?) => _source(context, b),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
        );
      },
    );
  }

  Widget _source(BuildContext context, Uint8List bytes) {
    final colors = LoupeColors.of(context);
    final cut = bytes.length > _displayLimit;
    final text = decodeRawSource(cut ? bytes.sublist(0, _displayLimit) : bytes);
    final source = SelectableText(
      text,
      key: const Key('source-text'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.35),
    );
    return Scrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cut)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Showing the first ${formatBytes(_displayLimit)} of ${formatBytes(bytes.length)}. '
                  'Copy or share to get all of it.',
                  style: TextStyle(color: colors.secondaryText, fontSize: 13),
                ),
              ),
            if (_wrap) source else SingleChildScrollView(scrollDirection: Axis.horizontal, child: source),
          ],
        ),
      ),
    );
  }
}
