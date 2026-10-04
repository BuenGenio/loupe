// Shared helpers for the widget tests.

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

/// A valid 1×1 PNG.
final pngBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
);
final pngDataUri = 'data:image/png;base64,${base64Encode(pngBytes)}';

var _ids = 0;

EmailContent email({String? html, String? text, bool flowed = false, Map<String, Uint8List> inline = const {}}) =>
    EmailContent(
      emailId: 'e${_ids++}',
      html: html,
      text: text,
      isFlowed: flowed,
      inlineData: inline,
      headers: const [('From', 'Example News <news@shop.example>')],
    );

Future<void> pumpReader(
  WidgetTester tester,
  EmailContent content, {
  ReaderSettings settings = const ReaderSettings(),
  RemoteContentPolicy remote = RemoteContentPolicy.block,
  void Function({required bool always})? onAllow,
  void Function(Uri)? onOpen,
  VoidCallback? onSuggest,
  ThemeData? theme,
  bool openLinksDirectly = false,
  bool inert = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ReadableMessageView(
            content: content,
            settings: settings,
            remoteContent: remote,
            onAllowRemoteContent: onAllow,
            onOpenLink: onOpen,
            onSuggestOriginal: onSuggest,
            openLinksDirectly: openLinksDirectly,
            inert: inert,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

Finder richText(String text) => find.textContaining(text, findRichText: true);

/// Global centre of the first line box of [substring] (a Text widget can be
/// wider than its text).
Offset textCenter(String substring) {
  final range = find.textRange.ofSubstring(substring).evaluate().single;
  final boxes = range.renderObject.getBoxesForSelection(
    TextSelection(baseOffset: range.textRange.start, extentOffset: range.textRange.end),
  );
  return range.renderObject.localToGlobal(boxes.first.toRect().center);
}
