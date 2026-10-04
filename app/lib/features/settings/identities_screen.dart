import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../compose/compose_text.dart';
import '../compose/identity_selection.dart';
import '../conversation/sheets.dart' show showSnack;

/// Settings › account › Identities: the addresses an account sends from.
/// Tap to edit, drag to reorder; the first one is the default.
class IdentitiesScreen extends ConsumerStatefulWidget {
  const IdentitiesScreen({super.key, required this.accountId});

  final String accountId;

  @override
  ConsumerState<IdentitiesScreen> createState() => _IdentitiesScreenState();
}

class _IdentitiesScreenState extends ConsumerState<IdentitiesScreen> {
  /// A new order, shown until the account has saved it.
  List<Identity>? _reordered;

  MailAccount? get _account =>
      (ref.read(accountsProvider).value ?? const <MailAccount>[]).where((a) => a.id == widget.accountId).firstOrNull;

  Future<void> _save(MailAccount account, List<Identity> identities) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).updateAccount(account.copyWith(identities: identities));
    } on MailException catch (e) {
      showSnack(messenger, e.message);
    }
  }

  Future<void> _edit(MailAccount account, Identity? identity) async {
    final edit = await Navigator.of(context).push<IdentityEdit>(
      MaterialPageRoute(
        builder: (_) => IdentityEditorScreen(account: account, identity: identity),
      ),
    );
    if (edit == null || !mounted) return;
    // Applied to the account as it is now.
    final current = _account ?? account;
    final identities = [...IdentitySelection.identitiesOf(current)];
    final index = identity == null ? -1 : identities.indexWhere((i) => i.id == identity.id);
    switch (edit.saved) {
      case final saved? when index >= 0:
        identities[index] = saved;
      case final saved?:
        identities.add(saved);
      case null when index >= 0 && identities.length > 1:
        identities.removeAt(index);
      case null:
        return;
    }
    await _save(current, identities);
  }

  Future<void> _reorder(MailAccount account, List<Identity> identities, int from, int to) async {
    final next = [...identities];
    next.insert(to, next.removeAt(from));
    setState(() => _reordered = next);
    await _save(account, next);
    if (mounted) setState(() => _reordered = null);
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final account = (ref.watch(accountsProvider).value ?? const <MailAccount>[])
        .where((a) => a.id == widget.accountId)
        .firstOrNull;
    if (account == null) {
      return GroupedPage(
        title: 'Identities',
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text('This account was removed.', style: styles.footnote, textAlign: TextAlign.center),
          ),
        ],
      );
    }
    final identities = _reordered ?? IdentitySelection.identitiesOf(account);
    final reorderable = identities.length > 1;
    return GroupedPage(
      title: 'Identities',
      children: [
        InsetGroup(
          footer: reorderable
              ? 'The first identity is the default for new messages. Drag to change the order.'
              : 'The default identity for new messages.',
          children: [
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              onReorderItem: (from, to) => unawaited(_reorder(account, identities, from, to)),
              proxyDecorator: (child, _, _) => Material(color: colors.cellBackground, elevation: 3, child: child),
              children: [
                for (final (index, identity) in identities.indexed)
                  Column(
                    key: ValueKey(identity.id),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GroupedRow(
                        key: ValueKey('identity-row-${identity.id}'),
                        title: identity.name?.trim().isNotEmpty ?? false ? identity.name!.trim() : identity.email,
                        subtitle: identity.name?.trim().isNotEmpty ?? false ? identity.email : null,
                        detail: index == 0 && reorderable ? 'Default' : null,
                        chevron: !reorderable,
                        onTap: () => _edit(account, identity),
                        trailing: reorderable
                            ? ReorderableDragStartListener(
                                index: index,
                                child: Semantics(
                                  container: true,
                                  label: 'Reorder ${identity.email}',
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 12),
                                    child: Icon(LoupeIcons.reorder, color: colors.tertiaryText),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      if (index < identities.length - 1)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 16),
                          child: Divider(height: 0.5, thickness: 0.5, color: colors.separator),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        InsetGroup(
          footer: 'A reply goes out from the identity the message was sent to.',
          children: [
            GroupedRow(
              key: const Key('identity-add'),
              title: 'Add Identity',
              titleStyle: styles.body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: () => _edit(account, null),
            ),
          ],
        ),
      ],
    );
  }
}

/// What the identity editor resolves to: the [saved] identity, or null to
/// delete it.
final class IdentityEdit {
  const IdentityEdit.save(Identity this.saved);
  const IdentityEdit.delete() : saved = null;

  final Identity? saved;
}

/// Edits one identity: name, address, Reply-To, signature, automatic Cc and
/// Bcc, and the addresses whose replies use it. Resolves to an [IdentityEdit].
class IdentityEditorScreen extends StatefulWidget {
  const IdentityEditorScreen({super.key, required this.account, this.identity});

  final MailAccount account;

  /// Null for a new identity.
  final Identity? identity;

  @override
  State<IdentityEditorScreen> createState() => _IdentityEditorScreenState();
}

class _IdentityEditorScreenState extends State<IdentityEditorScreen> {
  late final Identity? _original = widget.identity;
  late final _name = TextEditingController(text: _original?.name ?? widget.account.defaultIdentity.name ?? '');
  late final _email = TextEditingController(text: _original?.email ?? '');
  late final _replyTo = TextEditingController(text: _original?.replyTo ?? '');
  late final _signature = TextEditingController(text: _original?.signature ?? '');
  late final _cc = TextEditingController(text: _original?.autoCc ?? '');
  late final _bcc = TextEditingController(text: _original?.autoBcc ?? '');
  late final List<String> _patterns = [...?_original?.replyPatterns];
  late final String _initial;
  bool _leaving = false;

  List<TextEditingController> get _fields => [_name, _email, _replyTo, _signature, _cc, _bcc];

  @override
  void initState() {
    super.initState();
    _initial = _snapshot();
    for (final c in _fields) {
      c.addListener(_changed);
    }
  }

  @override
  void dispose() {
    for (final c in _fields) {
      c.dispose();
    }
    super.dispose();
  }

  void _changed() => setState(() {});

  String _snapshot() => [for (final c in _fields) c.text, ..._patterns].join('\u0000');

  bool get _dirty => _snapshot() != _initial;

  bool get _isLast => IdentitySelection.identitiesOf(widget.account).length <= 1;

  /// Validates and resolves to the edited identity.
  Future<void> _done() async {
    final email = _email.text.trim();
    if (email.isEmpty) return _alert('No Address', 'Enter the email address to send from.');
    for (final (label, value) in [('', email), ('Reply-To ', _replyTo.text), ('Cc ', _cc.text), ('Bcc ', _bcc.text)]) {
      final v = value.trim();
      if (v.isNotEmpty && !ComposeText.isValidEmail(v)) {
        return _alert('Invalid Address', '$label“$v” isn’t a valid email address.');
      }
    }
    String? opt(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    final signature = _signature.text.trimRight();
    _leave(
      IdentityEdit.save(
        Identity(
          id: _original?.id ?? newIdentityId(widget.account),
          email: email,
          name: opt(_name),
          replyTo: opt(_replyTo),
          signature: signature.isEmpty ? null : signature,
          autoCc: opt(_cc),
          autoBcc: opt(_bcc),
          replyPatterns: List.unmodifiable(_patterns),
        ),
      ),
    );
  }

  void _leave([IdentityEdit? edit]) {
    _leaving = true;
    Navigator.of(context).pop(edit);
  }

  Future<void> _delete() async {
    final ok = await confirmDestructive(
      context,
      title: 'Delete “${_original!.email}”?',
      message: 'Messages already sent from it stay as they are.',
      action: 'Delete Identity',
    );
    if (ok && mounted) _leave(const IdentityEdit.delete());
  }

  /// Back with unsaved edits asks first.
  Future<void> _confirmLeave() async {
    final save = await showActionSheet<bool>(
      context,
      actions: const [
        SheetAction('Save Identity', true, isDefault: true),
        SheetAction('Discard Changes', false, destructive: true),
      ],
    );
    if (save == null || !mounted) return;
    save ? await _done() : _leave();
  }

  Future<void> _addPattern() async {
    final input = await showTextPrompt(
      context,
      title: 'Use for Replies To',
      message: 'An address, or a pattern where * stands for anything.',
      placeholder: '*@example.com',
      confirm: 'Add',
    );
    if (input == null || input.isEmpty || !mounted) return;
    final pattern = IdentitySelection.normalizePattern(input);
    if (pattern == null) {
      return _alert('Invalid Pattern', '“$input” isn’t an address or a pattern like *@example.com.');
    }
    if (!_patterns.contains(pattern)) setState(() => _patterns.add(pattern));
  }

  Future<void> _alert(String title, String message) => showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    Widget multiline(Key key, TextEditingController controller, String hint) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        key: key,
        controller: controller,
        minLines: 3,
        maxLines: 8,
        style: styles.body,
        decoration: InputDecoration.collapsed(hintText: hint),
      ),
    );
    return PopScope(
      canPop: _leaving || !_dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_confirmLeave());
      },
      child: GroupedPage(
        title: _original == null ? 'New Identity' : 'Identity',
        trailing: CupertinoButton(
          key: const Key('identity-done'),
          padding: EdgeInsets.zero,
          onPressed: _done,
          child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        children: [
          InsetGroup(
            separatorIndent: 16,
            children: [
              _Field(key: const Key('identity-name'), label: 'Name', controller: _name, hint: 'Your name'),
              _Field(
                key: const Key('identity-email'),
                label: 'Email',
                controller: _email,
                hint: 'name@example.com',
                email: true,
              ),
              _Field(
                key: const Key('identity-reply-to'),
                label: 'Reply-To',
                controller: _replyTo,
                hint: 'Optional',
                email: true,
              ),
            ],
          ),
          InsetGroup(
            header: 'Signature',
            footer: 'Added below “-- ” in messages from this identity.',
            children: [multiline(const Key('identity-signature'), _signature, 'No signature')],
          ),
          InsetGroup(
            header: 'Copy to Myself',
            footer: 'Added to every message from this identity.',
            separatorIndent: 16,
            children: [
              _Field(key: const Key('identity-cc'), label: 'Cc', controller: _cc, hint: 'Optional', email: true),
              _Field(key: const Key('identity-bcc'), label: 'Bcc', controller: _bcc, hint: 'Optional', email: true),
            ],
          ),
          InsetGroup(
            header: 'Use for Replies To',
            footer:
                'Replies to messages sent to these addresses go out from this identity. '
                '* stands for anything: *@example.com, me+*@example.com.',
            separatorIndent: 16,
            children: [
              for (final pattern in _patterns)
                GroupedRow(
                  key: ValueKey('identity-pattern-$pattern'),
                  title: pattern,
                  chevron: false,
                  trailing: IconButton(
                    tooltip: 'Remove $pattern',
                    visualDensity: VisualDensity.compact,
                    icon: Icon(LoupeIcons.remove, color: colors.destructive),
                    onPressed: () => setState(() => _patterns.remove(pattern)),
                  ),
                ),
              GroupedRow(
                key: const Key('identity-add-pattern'),
                title: 'Add Address or Pattern',
                titleStyle: styles.body.copyWith(color: colors.unreadDot),
                chevron: false,
                onTap: _addPattern,
              ),
            ],
          ),
          if (_original != null)
            InsetGroup(
              footer: _isLast ? 'An account needs at least one identity.' : null,
              children: [
                GroupedRow(
                  key: const Key('identity-delete'),
                  title: 'Delete Identity',
                  destructive: true,
                  enabled: !_isLast,
                  onTap: _delete,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// A label and a one-line text field.
class _Field extends StatelessWidget {
  const _Field({super.key, required this.label, required this.controller, this.hint, this.email = false});

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool email;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: LoupeMetrics.of(context).groupedRowHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(width: 96, child: Text(label, style: styles.body)),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: email ? TextInputType.emailAddress : TextInputType.name,
                textCapitalization: email ? TextCapitalization.none : TextCapitalization.words,
                autocorrect: false,
                style: styles.body,
                textAlign: TextAlign.end,
                decoration: InputDecoration.collapsed(hintText: hint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
