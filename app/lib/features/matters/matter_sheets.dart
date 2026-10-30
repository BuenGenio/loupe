import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../router.dart';
import '../../shared/sheets.dart' show SheetAction, showActionSheet, showTextPrompt;
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show SheetGroup, SheetRow, showLoupeSheet, showSnack;
import 'matter_providers.dart';

/// Asks for a new matter's name and makes it, with [emails]' conversations
/// in it. Returns it, or null when the user cancelled.
Future<Matter?> createMatter(BuildContext context, WidgetRef ref, {List<EmailSummary> emails = const []}) async {
  final controller = ref.read(mattersControllerProvider);
  if (controller == null) return null;
  final l10n = context.l10n;
  final name = await showTextPrompt(context, title: l10n.mattersNewMatterTitle, placeholder: l10n.mattersNameHint);
  if (name == null || name.trim().isEmpty) return null;
  return controller.create(name, emails: emails);
}

/// Add to Matter…: the matters to put [email]'s conversation in (those it is
/// in already say so), and New Matter…. [conversation] is all of its
/// messages, to tell which matters have it.
Future<void> showAddToMatterSheet(
  BuildContext context,
  WidgetRef ref,
  EmailSummary email, {
  List<EmailSummary> conversation = const [],
}) async {
  final controller = ref.read(mattersControllerProvider);
  if (controller == null) return;
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final matters = ref.read(mattersProvider).value ?? const <Matter>[];
  final messages = conversation.isEmpty ? [email] : conversation;
  final choice = await showLoupeSheet<String>(
    context,
    builder: (context) {
      final colors = LoupeColors.of(context);
      final styles = LoupeTextStyles.of(context);
      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Text(l10n.mattersAddToMatterTitle, style: styles.navTitle),
              ),
              SheetGroup(
                children: [
                  for (final m in matters)
                    if (messages.any(m.includes))
                      SheetRow(
                        label: m.name,
                        icon: LoupeIcons.matter,
                        subtitle: l10n.mattersAlreadyIn,
                        trailing: Icon(LoupeIcons.check, color: colors.unreadDot),
                      )
                    else
                      SheetRow(
                        label: m.name,
                        icon: LoupeIcons.matter,
                        subtitle: l10n.mattersRowDetail(m.members.length),
                        onTap: () => Navigator.of(context).pop(m.id),
                      ),
                  SheetRow(
                    label: l10n.mattersNewMatter,
                    icon: LoupeIcons.add,
                    onTap: () => Navigator.of(context).pop(''),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  if (choice == null || !context.mounted) return;
  try {
    if (choice.isEmpty) {
      final created = await createMatter(context, ref, emails: [email]);
      if (created != null) showSnack(messenger, l10n.mattersAddedTo(created.name));
      return;
    }
    await controller.add(choice, email);
    final name = matters.where((m) => m.id == choice).firstOrNull?.name ?? '';
    showSnack(messenger, l10n.mattersAddedTo(name));
  } on Object {
    showSnack(messenger, l10n.conversationSomethingWentWrong);
  }
}

/// Remove from Matter: takes [email]'s conversation out of the matter it is
/// in (asking which, when it is in several), with Undo. Its mail stays.
Future<void> removeFromMatter(
  BuildContext context,
  WidgetRef ref,
  EmailSummary email, {
  List<EmailSummary> conversation = const [],
}) async {
  final controller = ref.read(mattersControllerProvider);
  if (controller == null) return;
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final messages = conversation.isEmpty ? [email] : conversation;
  final matters = mattersWith(ref.read(mattersProvider).value ?? const <Matter>[], messages);
  if (matters.isEmpty) return;
  final matter = matters.length == 1
      ? matters.single
      : await showActionSheet<Matter>(
          context,
          title: l10n.mattersRemoveWhich,
          actions: [for (final m in matters) SheetAction(m.name, m, icon: LoupeIcons.matter)],
        );
  if (matter == null) return;
  final member = matter.members.firstWhere((x) => messages.any(x.includes));
  try {
    final removed = await controller.remove(matter.id, member.key, subject: email.subject);
    if (removed == null) return;
    showSnack(
      messenger,
      l10n.mattersRemoved(matter.name),
      action: SnackBarAction(
        label: l10n.commonUndo,
        onPressed: () => unawaited(controller.restore(matter.id, removed, subject: email.subject)),
      ),
    );
  } on Object {
    showSnack(messenger, l10n.conversationSomethingWentWrong);
  }
}

/// The matters a conversation is in, under its subject: each a chip that
/// opens it. Nothing when it is in none.
class MatterLinks extends ConsumerWidget {
  const MatterLinks({super.key, required this.messages});

  /// The conversation's messages.
  final List<EmailSummary> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matters = mattersWith(ref.watch(mattersProvider).value ?? const <Matter>[], messages);
    if (matters.isEmpty) return const SizedBox.shrink();
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          for (final m in matters)
            Semantics(
              button: true,
              label: context.l10n.mattersOpenMatter(m.name),
              excludeSemantics: true,
              child: Material(
                key: ValueKey('matter-link-${m.id}'),
                color: colors.unreadDot.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => context.push(Routes.matter(m.id)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LoupeIcons.matter, size: 15, color: colors.unreadDot),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            m.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: styles.footnote.copyWith(color: colors.unreadDot, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
