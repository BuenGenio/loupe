import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

import '../../theme/theme.dart';
import '../conversation/sheets.dart';
import 'compose_text.dart';

/// The addresses of one recipient field plus the text still being typed.
class RecipientController extends ChangeNotifier {
  RecipientController([Iterable<EmailAddress> initial = const []]) {
    initial.forEach(add);
  }

  final _items = <EmailAddress>[];
  String _pending = '';

  /// The committed addresses (chips).
  List<EmailAddress> get items => List.unmodifiable(_items);

  /// Text typed but not yet turned into a chip.
  String get pending => _pending;
  set pending(String value) {
    if (value == _pending) return;
    _pending = value;
    notifyListeners();
  }

  /// The chips plus the pending text parsed as addresses.
  List<EmailAddress> get withPending => [
    ..._items,
    if (_pending.trim().isNotEmpty) ...ComposeText.parseAddresses(_pending),
  ];

  bool get hasValid => withPending.any((a) => ComposeText.isValidEmail(a.email));
  List<EmailAddress> get invalid => [
    for (final a in withPending)
      if (!ComposeText.isValidEmail(a.email)) a,
  ];

  /// Adds [address] unless it is already there.
  void add(EmailAddress address) {
    final email = address.email.trim();
    if (email.isEmpty || _items.any((a) => a.email.toLowerCase() == email.toLowerCase())) return;
    _items.add(EmailAddress(email, address.name));
    notifyListeners();
  }

  void remove(EmailAddress address) {
    _items.remove(address);
    notifyListeners();
  }

  void removeLast() {
    if (_items.isEmpty) return;
    _items.removeLast();
    notifyListeners();
  }
}

/// A recipient row: label, address chips and a text field with autocomplete.
///
/// Comma, semicolon or return turn the typed text into a chip; so does a
/// space after a complete address. Backspace in the empty field removes the
/// last chip.
class RecipientField extends StatefulWidget {
  const RecipientField({
    super.key,
    required this.label,
    required this.controller,
    required this.suggest,
    this.focusNode,
    this.autofocus = false,
  });

  final String label;
  final RecipientController controller;

  /// Autocomplete lookup (MailRepository.suggestAddresses).
  final Future<List<EmailAddress>> Function(String prefix) suggest;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  State<RecipientField> createState() => _RecipientFieldState();
}

class _RecipientFieldState extends State<RecipientField> {
  /// A zero-width space kept at the start of the text, so that backspace in an
  /// "empty" field reaches us on soft keyboards too.
  static const _zw = '​';

  final _text = TextEditingController(text: _zw);
  FocusNode? _ownFocus;
  FocusNode get _focus => widget.focusNode ?? (_ownFocus ??= FocusNode());

  List<EmailAddress> _suggestions = const [];
  int _query = 0;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
    _text.addListener(_keepCursorAfterSentinel);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _ownFocus?.dispose();
    _text.dispose();
    super.dispose();
  }

  String get _typed => _text.text.replaceAll(_zw, '');

  void _keepCursorAfterSentinel() {
    final v = _text.value;
    if (v.text.startsWith(_zw) && v.selection.isCollapsed && v.selection.baseOffset == 0) {
      _text.selection = const TextSelection.collapsed(offset: 1);
    }
  }

  void _onFocus() {
    if (!_focus.hasFocus) {
      _commit(_typed);
      _setText('');
    }
    setState(() {});
  }

  void _setText(String typed) {
    _text.value = TextEditingValue(
      text: _zw + typed,
      selection: TextSelection.collapsed(offset: 1 + typed.length),
    );
    widget.controller.pending = typed;
    if (typed.isEmpty) setState(() => _suggestions = const []);
  }

  void _commit(String text) {
    for (final a in ComposeText.parseAddresses(text)) {
      widget.controller.add(a);
    }
  }

  void _onChanged(String raw) {
    var typed = raw.replaceAll(_zw, '');
    if (!raw.startsWith(_zw) && typed.isEmpty && widget.controller.pending.isEmpty) {
      widget.controller.removeLast();
    }
    final sep = typed.lastIndexOf(RegExp('[,;\n]'));
    if (sep >= 0) {
      _commit(typed.substring(0, sep));
      typed = typed.substring(sep + 1).trimLeft();
    } else if (typed.endsWith(' ') && ComposeText.isValidEmail(typed.trim())) {
      _commit(typed);
      typed = '';
    }
    if (raw != _zw + typed) {
      _setText(typed);
    } else {
      widget.controller.pending = typed;
    }
    _lookup(typed.trim());
  }

  Future<void> _lookup(String prefix) async {
    final id = ++_query;
    if (prefix.isEmpty) {
      setState(() => _suggestions = const []);
      return;
    }
    List<EmailAddress> found;
    try {
      found = await widget.suggest(prefix);
    } on Exception {
      found = const [];
    }
    if (!mounted || id != _query) return;
    final taken = {for (final a in widget.controller.items) a.email.toLowerCase()};
    setState(
      () => _suggestions = [
        for (final a in found.take(6))
          if (!taken.contains(a.email.toLowerCase())) a,
      ],
    );
  }

  void _pick(EmailAddress a) {
    widget.controller.add(a);
    _setText('');
    _focus.requestFocus();
  }

  void _onSubmitted(String _) {
    final typed = _typed.trim();
    if (typed.isEmpty) {
      _focus.nextFocus();
      return;
    }
    _commit(typed);
    _setText('');
    _focus.requestFocus();
  }

  Future<void> _chipTapped(EmailAddress a) async {
    final remove = await showActionSheet<bool>(
      context,
      title: a.name?.trim().isNotEmpty ?? false ? a.name : null,
      message: a.email,
      actions: const [SheetAction('Remove', true, destructive: true)],
    );
    if (remove ?? false) widget.controller.remove(a);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _focus.requestFocus,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9, right: 6),
                    child: Text(widget.label, style: TextStyle(color: colors.secondaryText, fontSize: 16)),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final a in widget.controller.items) _AddressChip(address: a, onTap: () => _chipTapped(a)),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 80),
                          child: IntrinsicWidth(
                            child: TextField(
                              key: ValueKey('recipients-${widget.label}'),
                              controller: _text,
                              focusNode: _focus,
                              autofocus: widget.autofocus,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              enableSuggestions: false,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(fontSize: 16),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 9),
                              ),
                              onChanged: _onChanged,
                              onSubmitted: _onSubmitted,
                              onEditingComplete: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_focus.hasFocus && _suggestions.isNotEmpty)
            Material(
              color: subtleFill(context),
              child: Column(
                children: [
                  for (final s in _suggestions)
                    ListTile(
                      key: ValueKey('suggestion-${s.email}'),
                      dense: true,
                      title: Text(s.displayName, style: const TextStyle(fontSize: 15)),
                      subtitle: Text(s.email, style: TextStyle(color: colors.secondaryText)),
                      onTap: () => _pick(s),
                    ),
                ],
              ),
            ),
          Divider(indent: 16, color: theme.dividerTheme.color),
        ],
      ),
    );
  }
}

class _AddressChip extends StatelessWidget {
  const _AddressChip({required this.address, required this.onTap});
  final EmailAddress address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final valid = ComposeText.isValidEmail(address.email);
    final color = valid ? Theme.of(context).colorScheme.primary : CupertinoColors.systemRed.resolveFrom(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
        child: Text(
          address.displayName,
          style: TextStyle(color: color, fontSize: 15),
          semanticsLabel: valid ? address.email : 'Invalid address ${address.email}',
        ),
      ),
    );
  }
}
