import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../theme/theme.dart';
import 'mailbox_display.dart';
import 'tags.dart';
import '../theme/loupe_icons.dart';

/// One button of an action sheet.
class SheetAction<T> {
  const SheetAction(this.label, this.value, {this.icon, this.destructive = false, this.isDefault = false});

  final String label;
  final T value;
  final IconData? icon;
  final bool destructive;
  final bool isDefault;
}

/// An iOS action sheet; resolves to the chosen value, or null on Cancel.
Future<T?> showActionSheet<T>(
  BuildContext context, {
  required List<SheetAction<T>> actions,
  String? title,
  String? message,
}) {
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: title == null ? null : Text(title),
      message: message == null ? null : Text(message),
      actions: [
        for (final a in actions)
          CupertinoActionSheetAction(
            isDestructiveAction: a.destructive,
            isDefaultAction: a.isDefault,
            onPressed: () => Navigator.of(context).pop(a.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (a.icon != null) ...[Icon(a.icon, size: 21), const SizedBox(width: 10)],
                Flexible(child: Text(a.label, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
    ),
  );
}

/// Asks before something that can't be undone.
Future<bool> confirmDestructive(
  BuildContext context, {
  required String title,
  required String action,
  String? message,
}) async {
  final ok = await showActionSheet<bool>(
    context,
    title: title,
    message: message,
    actions: [SheetAction(action, true, destructive: true)],
  );
  return ok ?? false;
}

/// A one-field prompt (names of smart mailboxes, identities…).
Future<String?> showTextPrompt(
  BuildContext context, {
  required String title,
  String? message,
  String initial = '',
  String placeholder = '',
  String confirm = 'Save',
}) {
  final controller = TextEditingController(text: initial)
    ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);
  return showCupertinoDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message != null) Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(message)),
            CupertinoTextField(
              controller: controller,
              autofocus: true,
              placeholder: placeholder,
              onSubmitted: (v) => Navigator.of(context).pop(v.trim()),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(confirm),
        ),
      ],
    ),
  ).whenComplete(controller.dispose);
}

/// Picks a target mailbox of [accountId] for "Move to…".
Future<String?> showMailboxPicker(
  BuildContext context, {
  required List<Mailbox> mailboxes,
  required String accountId,
  String? accountName,
  Set<String> disabled = const {},
}) {
  final tree = mailboxTree([
    for (final m in mailboxes)
      if (m.accountId == accountId) m,
  ]);
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      final colors = LoupeColors.of(context);
      final styles = LoupeTextStyles.of(context);
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Move to…', style: styles.navTitle),
                        if (accountName != null) Text(accountName, style: styles.footnote),
                      ],
                    ),
                  ),
                  CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: colors.cellBackground,
                      child: Column(
                        children: [
                          for (final node in tree)
                            if (node.mailbox.isSelectable)
                              ListTile(
                                dense: true,
                                enabled: !disabled.contains(node.mailbox.id),
                                contentPadding: EdgeInsets.only(left: 16 + folderIndent(node.depth), right: 16),
                                leading: Icon(mailboxIcon(node.mailbox.role), color: colors.unreadDot),
                                title: Text(
                                  mailboxDisplayName(node.mailbox),
                                  style: styles.body,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () => Navigator.of(context).pop(node.mailbox.id),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// Toggles tags; resolves to the new tag set, or null if dismissed.
Future<Set<String>?> showTagPicker(BuildContext context, {required Set<String> current}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) {
      final selected = {...current};
      return StatefulBuilder(
        builder: (context, setState) {
          final colors = LoupeColors.of(context);
          final styles = LoupeTextStyles.of(context);
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
                  child: Row(
                    children: [
                      Expanded(child: Text('Tags', style: styles.navTitle)),
                      CupertinoButton(
                        onPressed: () => Navigator.of(context).pop(selected),
                        child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: colors.cellBackground,
                      child: Column(
                        children: [
                          for (final tag in TagDefinition.thunderbirdDefaults)
                            ListTile(
                              dense: true,
                              leading: Icon(LoupeIcons.dot, color: tagColor(tag.keyword), size: 16),
                              title: Text(tag.label, style: styles.body),
                              trailing: selected.contains(tag.keyword)
                                  ? Icon(LoupeIcons.check, color: colors.unreadDot)
                                  : null,
                              onTap: () => setState(
                                () => selected.contains(tag.keyword)
                                    ? selected.remove(tag.keyword)
                                    : selected.add(tag.keyword),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
