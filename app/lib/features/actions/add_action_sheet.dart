import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'action_changes.dart';
import 'action_providers.dart';

/// What Add Action… asks for.
typedef NewAction = ({ActionOwner owner, String text, DateTime? due});

/// Add Action…: an action the user writes about [message]: who has to act
/// (I need to, or they will), what, and optionally by when. Saved with Undo.
Future<void> addActionFor(BuildContext context, WidgetRef ref, EmailSummary message) async {
  final tracker = ref.read(actionTrackerProvider);
  final fromMe = await tracker.isFromMe(message);
  if (!context.mounted) return;
  final input = await showLoupeSheet<NewAction>(
    context,
    builder: (_) => _AddActionSheet(subject: message.subject, theyWill: fromMe),
  );
  if (input == null || !context.mounted) return;
  final due = input.due;
  final record = tracker.manual(
    source: MessageRef.of(message),
    owner: input.owner,
    text: input.text,
    fromMe: fromMe,
    due: due == null ? ActionDue.none : ActionDue(kind: ActionDueKind.explicit, date: due),
  );
  await addActions(context, ref, [record]);
}

class _AddActionSheet extends StatefulWidget {
  const _AddActionSheet({required this.subject, required this.theyWill});

  final String subject;

  /// Starts on They Will: in mail the user sent, what is tracked is usually
  /// an answer they wait for.
  final bool theyWill;

  @override
  State<_AddActionSheet> createState() => _AddActionSheetState();
}

class _AddActionSheetState extends State<_AddActionSheet> {
  late var _owner = widget.theyWill ? ActionOwner.them : ActionOwner.me;
  final _text = TextEditingController();
  DateTime? _due;

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _add() {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).pop<NewAction>((owner: _owner, text: text, due: _due));
  }

  Future<void> _pickDue() async {
    final now = clock.now();
    final today = DateTime(now.year, now.month, now.day);
    var picked = _due ?? today.add(const Duration(days: 1));
    final l10n = context.l10n;
    final chosen = await showModalBottomSheet<DateTime>(
      context: context,
      useSafeArea: true,
      backgroundColor: LoupeColors.of(context).groupedBackground,
      builder: (context) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
                Expanded(
                  child: Text(
                    l10n.actionsDueDate,
                    style: LoupeTextStyles.of(context).navTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                CupertinoButton(
                  key: const ValueKey('action-due-done'),
                  onPressed: () => Navigator.of(context).pop(picked),
                  child: Text(l10n.commonDone, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: picked,
                minimumDate: today,
                maximumDate: today.add(const Duration(days: 3 * 366)),
                onDateTimeChanged: (v) => picked = DateTime(v.year, v.month, v.day),
              ),
            ),
          ],
        ),
      ),
    );
    if (chosen != null && mounted) setState(() => _due = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final due = _due;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: Row(
                  children: [
                    CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
                    Expanded(
                      child: Text(l10n.actionsAddTitle, style: styles.navTitle, textAlign: TextAlign.center),
                    ),
                    CupertinoButton(
                      key: const ValueKey('action-add-save'),
                      onPressed: _text.text.trim().isEmpty ? null : _add,
                      child: Text(l10n.commonAdd, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: CupertinoSlidingSegmentedControl<ActionOwner>(
                  groupValue: _owner,
                  onValueChanged: (v) {
                    if (v == null) return;
                    unawaited(HapticFeedback.selectionClick());
                    setState(() => _owner = v);
                  },
                  children: {
                    ActionOwner.me: Padding(
                      key: const ValueKey('action-owner-me'),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(l10n.actionsOwnerMe),
                    ),
                    ActionOwner.them: Padding(
                      key: const ValueKey('action-owner-them'),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(l10n.actionsOwnerThem),
                    ),
                  },
                ),
              ),
              SheetGroup(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: CupertinoTextField.borderless(
                      key: const ValueKey('action-add-text'),
                      controller: _text,
                      autofocus: true,
                      minLines: 2,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      placeholder: _owner == ActionOwner.me
                          ? l10n.actionsAddPlaceholderMe
                          : l10n.actionsAddPlaceholderThem,
                      style: styles.body.copyWith(color: colors.label),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SheetRow(
                    key: const ValueKey('action-add-due'),
                    label: l10n.actionsDueDate,
                    icon: LoupeIcons.calendar,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          due == null ? l10n.commonNone : DateFormat.yMMMEd().format(due),
                          style: styles.body.copyWith(color: colors.secondaryText),
                        ),
                        if (due != null)
                          IconButton(
                            tooltip: l10n.actionsClearDueDate,
                            icon: Icon(LoupeIcons.clear, size: 18, color: colors.tertiaryText),
                            onPressed: () => setState(() => _due = null),
                          ),
                      ],
                    ),
                    onTap: _pickDue,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  l10n.actionsAddSource(widget.subject.trim().isEmpty ? l10n.mailNoSubject : widget.subject.trim()),
                  style: styles.footnote,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
