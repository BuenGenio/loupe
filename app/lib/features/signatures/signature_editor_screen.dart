import 'dart:convert';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../shared/bars.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show showSnack;
import 'signature_images.dart';
import 'signature_render.dart';

/// What the signature editor hands back to the identity.
sealed class SignatureEdit {
  const SignatureEdit();
}

final class SignatureSaved extends SignatureEdit {
  const SignatureSaved(this.signature, {this.makeDefault = false});
  final Signature signature;

  /// Move it first, where the default is.
  final bool makeDefault;
}

final class SignatureDeleted extends SignatureEdit {
  const SignatureDeleted();
}

/// A new signature's id.
String newSignatureId() =>
    'sig-${clock.now().microsecondsSinceEpoch.toRadixString(36)}${Random().nextInt(1 << 20).toRadixString(36)}';

/// Edits one signature: its name, its text with formatting, images and
/// fields (flutter_quill), and when it is used (signature.cc's rules: when
/// someone is copied, between two days, in rotation).
class SignatureEditorScreen extends StatefulWidget {
  const SignatureEditorScreen({super.key, this.signature, this.canMakeDefault = false});

  /// Null for a new one.
  final Signature? signature;

  /// Offer "Make Default" (it isn't first).
  final bool canMakeDefault;

  @override
  State<SignatureEditorScreen> createState() => _SignatureEditorScreenState();
}

class _SignatureEditorScreenState extends State<SignatureEditorScreen> {
  late final _name = TextEditingController(text: widget.signature?.name ?? '');
  late final QuillController _quill = QuillController(
    document: _document(widget.signature),
    selection: const TextSelection.collapsed(offset: 0),
  );
  final _editorFocus = FocusNode();
  final _editorScroll = ScrollController();
  late SignatureRule _rule = widget.signature?.rule ?? SignatureRule.always;

  static Document _document(Signature? s) {
    if (s == null) return Document();
    try {
      return Document.fromJson((jsonDecode(s.content) as List).cast<Map<String, dynamic>>());
    } on Object {
      return Document()..insert(0, s.plainText);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _quill.dispose();
    _editorFocus.dispose();
    _editorScroll.dispose();
    super.dispose();
  }

  bool get _isEmpty {
    final delta = _quill.document.toDelta().toList();
    return _quill.document.toPlainText().trim().isEmpty && !delta.any((op) => op.data is Map);
  }

  void _done({bool makeDefault = false}) {
    final original = widget.signature;
    if (_isEmpty) {
      Navigator.of(context).pop(original == null ? null : const SignatureDeleted());
      return;
    }
    final signature = Signature(
      id: original?.id ?? newSignatureId(),
      name: _name.text.trim(),
      content: jsonEncode(_quill.document.toDelta().toJson()),
      rule: _rule,
    );
    Navigator.of(context).pop(SignatureSaved(signature, makeDefault: makeDefault));
  }

  // Images and fields ---------------------------------------------------------------

  /// Inserts [embed] where the cursor is, over a selection.
  void _insert(Embeddable embed, {Attribute<Object?>? attribute}) {
    final sel = _quill.selection;
    final start = sel.isValid ? sel.start : max(0, _quill.document.length - 1);
    final length = sel.isValid ? sel.end - sel.start : 0;
    _quill.replaceText(start, length, embed, TextSelection.collapsed(offset: start + 1));
    if (attribute != null) _quill.formatText(start, 1, attribute);
  }

  Future<void> _addImage() async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      final files = await FilePicker.pickFiles(type: FileType.image);
      if (files.isEmpty) return;
      final file = files.first;
      final image = await prepareSignatureImage(await file.readAsBytes(), file.name);
      if (!mounted) return;
      if (image == null) {
        showSnack(messenger, l10n.settingsSignatureImageFailed);
        return;
      }
      _insert(BlockEmbed.image(image.dataUri), attribute: WidthAttribute('${image.width}'));
    } on Object catch (e) {
      debugPrint('Signature image failed: ${e.runtimeType}');
      showSnack(messenger, l10n.settingsSignatureImageFailed);
    }
  }

  Future<void> _addField() async {
    final l10n = context.l10n;
    final field = await showActionSheet<String>(
      context,
      title: l10n.settingsSignatureAddField,
      actions: [SheetAction(l10n.commonName, 'name'), SheetAction(l10n.settingsEmail, 'email')],
    );
    if (field != null && mounted) _insert(Embeddable(fieldEmbedType, field));
  }

  // Rules ---------------------------------------------------------------------------

  Future<void> _addCopied() async {
    final l10n = context.l10n;
    final input = await showTextPrompt(
      context,
      title: l10n.settingsSignatureAddCopied,
      message: l10n.settingsSignatureCopiedPrompt,
      placeholder: 'client.example',
      confirm: l10n.commonAdd,
    );
    final value = input?.trim().toLowerCase();
    if (value == null || value.isEmpty || value.contains(' ') || !mounted) return;
    if (!_rule.copied.contains(value)) setState(() => _rule = _rule.copyWith(copied: [..._rule.copied, value]));
  }

  void _schedule(bool on) {
    final today = clock.now();
    setState(
      () => _rule = on
          ? _rule.copyWith(
              from: () => DateTime(today.year, today.month, today.day),
              until: () => DateTime(today.year, today.month, today.day + 7),
            )
          : _rule.copyWith(from: () => null, until: () => null),
    );
  }

  Future<void> _pickDay({required bool start}) async {
    final current = (start ? _rule.from : _rule.until) ?? clock.now();
    final picked = await _showDayPicker(context, current);
    if (picked == null || !mounted) return;
    setState(() {
      var from = _rule.from ?? picked;
      var until = _rule.until ?? picked;
      if (start) {
        from = picked;
        if (until.isBefore(from)) until = from;
      } else {
        until = picked;
        if (from.isAfter(until)) from = until;
      }
      _rule = _rule.copyWith(from: () => from, until: () => until);
    });
  }

  // Build ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final day = DateFormat.yMMMd();
    final accent = styles.body.copyWith(color: colors.unreadDot);
    return Scaffold(
      backgroundColor: colors.groupedBackground,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          LoupeTitleBar(
            title: widget.signature == null ? l10n.settingsNewSignature : l10n.settingsSignature,
            leading: BarTextButton(label: l10n.commonCancel, onPressed: () => Navigator.of(context).maybePop()),
            trailing: [
              BarTextButton(key: const Key('signature-done'), label: l10n.commonDone, bold: true, onPressed: _done),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverList.list(
            children: [
              InsetGroup(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: TextField(
                      key: const Key('signature-name'),
                      controller: _name,
                      textCapitalization: TextCapitalization.words,
                      style: styles.body,
                      decoration: InputDecoration.collapsed(hintText: l10n.settingsSignatureNameHint),
                    ),
                  ),
                ],
              ),
              InsetGroup(
                footer: l10n.settingsSignatureEditorFooter,
                children: [
                  QuillSimpleToolbar(
                    controller: _quill,
                    config: QuillSimpleToolbarConfig(
                      showDividers: false,
                      showSmallButton: false,
                      showLineHeightButton: false,
                      showStrikeThrough: false,
                      showInlineCode: false,
                      showBackgroundColorButton: false,
                      showAlignmentButtons: true,
                      showJustifyAlignment: false,
                      showHeaderStyle: false,
                      showListNumbers: false,
                      showListBullets: false,
                      showListCheck: false,
                      showCodeBlock: false,
                      showQuote: false,
                      showIndent: false,
                      showSearchButton: false,
                      showSubscript: false,
                      showSuperscript: false,
                      buttonOptions: const QuillSimpleToolbarButtonOptions(
                        fontFamily: QuillToolbarFontFamilyButtonOptions(
                          // l10n-ignore: generic font names, as on the website's Plain view.
                          items: {'Sans': 'sans-serif', 'Serif': 'serif', 'Mono': 'monospace', 'Clear': 'Clear'},
                        ),
                      ),
                      customButtons: [
                        QuillToolbarCustomButtonOptions(
                          icon: const Icon(LoupeIcons.addImage),
                          tooltip: l10n.settingsSignatureAddImage,
                          onPressed: _addImage,
                        ),
                        QuillToolbarCustomButtonOptions(
                          icon: const Icon(LoupeIcons.addField),
                          tooltip: l10n.settingsSignatureAddField,
                          onPressed: _addField,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: QuillEditor(
                      key: const Key('signature-editor'),
                      controller: _quill,
                      focusNode: _editorFocus,
                      scrollController: _editorScroll,
                      config: QuillEditorConfig(
                        scrollable: false,
                        minHeight: 120,
                        placeholder: l10n.settingsSignatureHint,
                        embedBuilders: const [SignatureImageEmbed(), SignatureFieldEmbed()],
                        unknownEmbedBuilder: const _NoEmbed(),
                      ),
                    ),
                  ),
                ],
              ),
              InsetGroup(
                header: l10n.settingsSignatureWhenToUse,
                footer: l10n.settingsSignatureWhenCopiedFooter,
                separatorIndent: 16,
                children: [
                  SwitchRow(
                    key: const Key('signature-when-copied'),
                    title: l10n.settingsSignatureWhenCopied,
                    value: _rule.whenCopied,
                    onChanged: (on) => setState(() => _rule = _rule.copyWith(whenCopied: on)),
                  ),
                  if (_rule.whenCopied) ...[
                    for (final p in _rule.copied)
                      GroupedRow(
                        key: ValueKey('signature-copied-$p'),
                        title: p,
                        chevron: false,
                        trailing: IconButton(
                          tooltip: l10n.settingsRemoveReplyPattern(p),
                          visualDensity: VisualDensity.compact,
                          icon: Icon(LoupeIcons.remove, color: colors.destructive),
                          onPressed: () => setState(
                            () => _rule = _rule.copyWith(
                              copied: [
                                for (final c in _rule.copied)
                                  if (c != p) c,
                              ],
                            ),
                          ),
                        ),
                      ),
                    GroupedRow(
                      key: const Key('signature-add-copied'),
                      title: l10n.settingsSignatureAddCopied,
                      titleStyle: accent,
                      chevron: false,
                      onTap: _addCopied,
                    ),
                  ],
                ],
              ),
              InsetGroup(
                footer: l10n.settingsSignatureScheduledFooter,
                separatorIndent: 16,
                children: [
                  SwitchRow(
                    key: const Key('signature-scheduled'),
                    title: l10n.settingsSignatureScheduled,
                    value: _rule.isScheduled,
                    onChanged: _schedule,
                  ),
                  if (_rule.isScheduled) ...[
                    GroupedRow(
                      key: const Key('signature-starts'),
                      title: l10n.settingsSignatureStarts,
                      detail: _rule.from == null ? null : day.format(_rule.from!),
                      onTap: () => _pickDay(start: true),
                    ),
                    GroupedRow(
                      key: const Key('signature-ends'),
                      title: l10n.settingsSignatureEnds,
                      detail: _rule.until == null ? null : day.format(_rule.until!),
                      onTap: () => _pickDay(start: false),
                    ),
                  ],
                ],
              ),
              InsetGroup(
                footer: l10n.settingsSignatureRotationFooter,
                children: [
                  SwitchRow(
                    key: const Key('signature-rotation'),
                    title: l10n.settingsSignatureRotation,
                    value: _rule.rotate,
                    onChanged: (on) => setState(() => _rule = _rule.copyWith(rotate: on)),
                  ),
                ],
              ),
              if (widget.signature != null)
                InsetGroup(
                  separatorIndent: 16,
                  children: [
                    if (widget.canMakeDefault)
                      GroupedRow(
                        key: const Key('signature-make-default'),
                        title: l10n.settingsSignatureMakeDefault,
                        titleStyle: accent,
                        chevron: false,
                        onTap: () => _done(makeDefault: true),
                      ),
                    GroupedRow(
                      key: const Key('signature-delete'),
                      title: l10n.settingsDeleteSignature,
                      destructive: true,
                      onTap: () => Navigator.of(context).pop(const SignatureDeleted()),
                    ),
                  ],
                ),
              SizedBox(height: 24 + MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ],
      ),
    );
  }
}

/// The embed type of a field: `{"loupe-field": "name"}` or `"email"`.
const fieldEmbedType = 'loupe-field';

/// A signature image (a `data:` URI) in the editor, at its width.
class SignatureImageEmbed extends EmbedBuilder {
  const SignatureImageEmbed();

  @override
  String get key => BlockEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final image = decodeImageDataUri('${embedContext.node.value.data}');
    if (image == null) return const SizedBox.shrink();
    final width = double.tryParse('${embedContext.node.style.attributes[Attribute.width.key]?.value ?? ''}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Image.memory(image.$2, width: width, errorBuilder: (_, _, _) => const Icon(LoupeIcons.image)),
    );
  }
}

/// A field in the editor: a chip naming it ("Name", "Email").
class SignatureFieldEmbed extends EmbedBuilder {
  const SignatureFieldEmbed();

  @override
  String get key => fieldEmbedType;

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final l10n = context.l10n;
    final label = switch (embedContext.node.value.data) {
      'name' => l10n.commonName,
      'email' => l10n.settingsEmail,
      _ => '?',
    };
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(5)),
      child: Text(label, style: embedContext.textStyle.copyWith(color: color)),
    );
  }
}

/// Anything else (pasted from elsewhere): not shown, not sent.
class _NoEmbed extends EmbedBuilder {
  const _NoEmbed();

  @override
  String get key => 'unknown';

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) => const SizedBox.shrink();
}

/// A date wheel in a sheet; null when cancelled.
Future<DateTime?> _showDayPicker(BuildContext context, DateTime initial) {
  var picked = DateTime(initial.year, initial.month, initial.day);
  return showModalBottomSheet<DateTime>(
    context: context,
    useSafeArea: true,
    backgroundColor: LoupeColors.of(context).groupedBackground,
    builder: (context) {
      final l10n = context.l10n;
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                children: [
                  CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
                  const Spacer(),
                  CupertinoButton(
                    key: const ValueKey('signature-day-done'),
                    onPressed: () => Navigator.of(context).pop(picked),
                    child: Text(l10n.commonDone, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: picked,
                onDateTimeChanged: (v) => picked = DateTime(v.year, v.month, v.day),
              ),
            ),
          ],
        ),
      );
    },
  );
}
