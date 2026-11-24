import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/ui_state.dart' show smartMailboxHomeProvider;
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../conversation/sheets.dart' show SheetGroup, SheetRow, showLoupeSheet;
import '../rules/rule_format.dart' show rulesProvider;
import 'projects_state.dart';

/// Where the projects are kept: an icon and a line for the editor.
(IconData, String) projectSyncLabel(
  ProjectSyncStatus status, {
  required String? home,
  required List<MailAccount> accounts,
  required AppLocalizations l10n,
}) {
  final owner = accounts.where((a) => a.id == home).firstOrNull;
  if (home == null || owner == null) return (LoupeIcons.thisDevice, l10n.searchSyncDeviceOnly);
  final name = owner.displayName;
  if (status.unsupported) return (LoupeIcons.thisDevice, l10n.searchSyncUnsupported(name));
  if (status.newerFormat) return (LoupeIcons.warning, l10n.searchSyncNewerFormat(name));
  if (status.pending || !status.synced || status.accountId != home) {
    return (LoupeIcons.syncPending, l10n.searchSyncWaiting(name));
  }
  return (LoupeIcons.synced, l10n.searchSynced(name));
}

/// Puts the [conversations] (each a list of its messages) in projects or
/// takes them out: a picker of every project, checked when all of them are
/// in it, with New Project… at the end. A change applies to every message
/// of every conversation, so a project follows the whole conversation.
Future<void> pickProjectsFor(BuildContext context, MailRepository repo, List<List<EmailSummary>> conversations) async {
  if (conversations.isEmpty) return;
  final each = [
    for (final c in conversations) {for (final e in c) ...e.projectIds},
  ];
  final current = each.reduce((a, b) => a.intersection(b));
  final picked = await showProjectPicker(context, current: current);
  if (picked == null) return;
  final add = picked.difference(current);
  final remove = current.difference(picked);
  if (add.isEmpty && remove.isEmpty) return;
  await repo.setKeywords(
    [
      for (final c in conversations)
        for (final e in c) e.id,
    ],
    add: {for (final id in add) Projects.keyword(id)},
    remove: {for (final id in remove) Projects.keyword(id)},
  );
}

/// Toggles projects; resolves to the ids picked, or null when dismissed.
Future<Set<String>?> showProjectPicker(BuildContext context, {required Set<String> current}) =>
    showLoupeSheet<Set<String>>(context, builder: (context) => _ProjectPicker(current: current));

class _ProjectPicker extends ConsumerStatefulWidget {
  const _ProjectPicker({required this.current});

  final Set<String> current;

  @override
  ConsumerState<_ProjectPicker> createState() => _ProjectPickerState();
}

class _ProjectPickerState extends ConsumerState<_ProjectPicker> {
  late final _selected = {...widget.current};

  Future<void> _new() async {
    final created = await showProjectEditor(context);
    if (created != null && mounted) setState(() => _selected.add(created.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    // Done projects only where the conversation still is in one.
    final projects = [
      for (final p in ref.watch(projectsProvider))
        if (!p.done || widget.current.contains(p.id)) p,
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.mailboxesProjects, style: styles.navTitle)),
                  CupertinoButton(
                    key: const Key('project-picker-done'),
                    onPressed: () => Navigator.of(context).pop(_selected),
                    child: Text(l10n.commonDone, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            SheetGroup(
              children: [
                for (final p in projects)
                  SheetRow(
                    key: ValueKey('project-pick-${p.id}'),
                    label: p.name,
                    icon: LoupeIcons.projectFilled,
                    iconColor: p.color,
                    trailing: _selected.contains(p.id) ? Icon(LoupeIcons.check, color: colors.unreadDot) : null,
                    onTap: () =>
                        setState(() => _selected.contains(p.id) ? _selected.remove(p.id) : _selected.add(p.id)),
                  ),
                SheetRow(
                  key: const Key('project-pick-new'),
                  label: l10n.projectsNewMenu,
                  icon: LoupeIcons.newProject,
                  onTap: _new,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Creates a project ([project] null) or edits one: name and colour.
/// Resolves to the project, or null when cancelled.
Future<Project?> showProjectEditor(BuildContext context, {Project? project}) =>
    showLoupeSheet<Project>(context, builder: (context) => _ProjectEditor(project: project));

class _ProjectEditor extends ConsumerStatefulWidget {
  const _ProjectEditor({this.project});

  final Project? project;

  @override
  ConsumerState<_ProjectEditor> createState() => _ProjectEditorState();
}

class _ProjectEditorState extends ConsumerState<_ProjectEditor> {
  late final _name = TextEditingController(text: widget.project?.name ?? '');
  late Color _color = widget.project?.color ?? ProjectColors.palette[ref.read(projectsProvider).length % 8];

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final projects = ref.read(projectsProvider.notifier);
    final existing = widget.project;
    final navigator = Navigator.of(context);
    if (existing == null) {
      navigator.pop(await projects.add(name, color: _color));
    } else {
      await projects.edit(existing.id, name: name, color: _color == existing.color ? null : _color);
      navigator.pop(ref.read(projectsByIdProvider)[existing.id]);
    }
  }

  /// The rules that add [project]'s keyword to new mail, and Add Rule….
  List<Widget> _rules(BuildContext context, Project project) {
    final l10n = context.l10n;
    final styles = LoupeTextStyles.of(context);
    final rules = [
      for (final r in ref.watch(rulesProvider).value ?? const <Rule>[])
        if (r.actions.any((a) => a is AddTagAction && Keywords.normalize(a.keyword) == project.keyword)) r,
    ];
    void open(String location) {
      final router = GoRouter.of(context);
      Navigator.of(context).pop();
      unawaited(router.push(location));
    }

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 20, 16, 8),
        child: Text(l10n.rulesTitle.toUpperCase(), style: styles.footnote),
      ),
      SheetGroup(
        children: [
          for (final r in rules)
            SheetRow(
              key: ValueKey('project-rule-${r.id}'),
              label: r.name.isEmpty ? r.condition : r.name,
              subtitle: r.condition,
              icon: LoupeIcons.rules,
              onTap: () => open(Routes.editRule(r.id)),
            ),
          SheetRow(
            key: const Key('project-add-rule'),
            label: l10n.projectsAddRule,
            icon: LoupeIcons.newProject,
            onTap: () => open(Routes.newRule(name: project.name, actions: [AddTagAction(project.keyword)])),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 16, 0),
        child: Text(l10n.projectsRulesFooter, style: styles.footnote),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final (syncIcon, syncText) = projectSyncLabel(
      ref.watch(projectSyncStatusProvider),
      home: ref.watch(smartMailboxHomeProvider),
      accounts: ref.watch(accountsProvider).value ?? const <MailAccount>[],
      l10n: l10n,
    );
    final swatches = [...ProjectColors.palette, if (!ProjectColors.palette.contains(_color)) _color];
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: [
                  CupertinoButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
                  Expanded(
                    child: Text(
                      widget.project == null ? l10n.projectsNewTitle : l10n.projectsEditTitle,
                      style: styles.navTitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _name,
                    builder: (context, value, _) => CupertinoButton(
                      key: const Key('project-save'),
                      onPressed: value.text.trim().isEmpty ? null : _save,
                      child: Text(l10n.commonSave, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoTextField(
                key: const Key('project-name'),
                controller: _name,
                autofocus: widget.project == null,
                placeholder: l10n.commonName,
                textCapitalization: TextCapitalization.sentences,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                decoration: BoxDecoration(color: colors.cellBackground, borderRadius: BorderRadius.circular(10)),
                style: styles.body,
                onSubmitted: (_) => _save(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 20, 16, 8),
              child: Text(l10n.settingsColour.toUpperCase(), style: styles.footnote),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: colors.cellBackground, borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  spacing: 14,
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < swatches.length; i++)
                      Semantics(
                        button: true,
                        selected: _color == swatches[i],
                        label: l10n.settingsColourNumber(i + 1),
                        child: GestureDetector(
                          key: ValueKey('project-colour-$i'),
                          onTap: () => setState(() => _color = swatches[i]),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: swatches[i],
                              shape: BoxShape.circle,
                              border: _color == swatches[i] ? Border.all(color: colors.label, width: 2.5) : null,
                            ),
                            child: _color == swatches[i]
                                ? const Icon(LoupeIcons.check, color: Colors.white, size: 20)
                                : null,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.project case final project?) ..._rules(context, project),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 16, 16),
              child: Row(
                children: [
                  Icon(syncIcon, size: 14, color: colors.secondaryText),
                  const SizedBox(width: 6),
                  Expanded(child: Text(syncText, style: styles.footnote)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The menu of a project's list: Edit Project, Mark as Done or Reopen, and
/// Delete Project.
Future<void> showProjectMenu(BuildContext context, WidgetRef ref, Project project) async {
  final l10n = context.l10n;
  final choice = await showActionSheet<String>(
    context,
    title: project.name,
    actions: [
      SheetAction(l10n.projectsEditTitle, 'edit', icon: LoupeIcons.rename),
      if (project.done)
        SheetAction(l10n.projectsReopen, 'reopen', icon: LoupeIcons.project)
      else
        SheetAction(l10n.projectsMarkDone, 'done', icon: LoupeIcons.projectDone),
      SheetAction(l10n.projectsDelete, 'delete', icon: LoupeIcons.trash, destructive: true),
    ],
  );
  if (choice == null || !context.mounted) return;
  final projects = ref.read(projectsProvider.notifier);
  switch (choice) {
    case 'edit':
      await showProjectEditor(context, project: project);
    case 'done':
      await projects.edit(project.id, done: true);
    case 'reopen':
      await projects.edit(project.id, done: false);
    case 'delete':
      await deleteProject(context, ref, project);
  }
}

/// Deletes [project] once confirmed. Its conversations stay where they
/// are; the messages kept here lose its keyword (other devices' copies
/// lose it as those sync, the rest keeps an unused keyword). Resolves to
/// whether it was deleted.
Future<bool> deleteProject(BuildContext context, WidgetRef ref, Project project) async {
  final l10n = context.l10n;
  final repo = ref.read(repositoryProvider);
  final projects = ref.read(projectsProvider.notifier);
  final ok = await confirmDestructive(
    context,
    title: project.name,
    message: l10n.projectsDeleteMessage,
    action: l10n.projectsDelete,
  );
  if (!ok) return false;
  await projects.remove(project.id);
  final members = await repo.watchList(project.ref, threaded: false, limit: 10000).first;
  if (members.isNotEmpty) {
    await repo.setKeywords([for (final t in members) t.latest.id], remove: {project.keyword});
  }
  return true;
}
