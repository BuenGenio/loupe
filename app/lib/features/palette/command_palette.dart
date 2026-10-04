import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../keyboard/shortcut_sheet.dart';
import 'palette_items.dart';

/// The command palette (Ctrl/⌘+K, or a long press on a search field):
/// actions on what is on screen, every mailbox, Smart Mailbox and mailing
/// list, the settings pages and recent searches, found by typing a few
/// letters of them. ↑ and ↓ choose, Enter runs, Esc closes.
Future<void> showCommandPalette(BuildContext context) async {
  final container = ProviderScope.containerOf(context, listen: false);
  // Read now: once the palette is up, the screen below isn't on top.
  final items = paletteItems(container);
  final picked = await showDialog<PaletteItem>(
    context: context,
    barrierColor: const Color(0x33000000),
    builder: (context) => CommandPalette(items: items, searchItem: (text) => searchMailItem(text, container)),
  );
  if (picked == null) return;
  if (picked.kind != PaletteKind.search) await container.read(paletteRecentsProvider.notifier).add(picked.id);
  await picked.run();
}

class CommandPalette extends ConsumerStatefulWidget {
  const CommandPalette({super.key, required this.items, required this.searchItem});

  final List<PaletteItem> items;

  /// The "Search mail for …" entry for what was typed.
  final PaletteItem Function(String text) searchItem;

  @override
  ConsumerState<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends ConsumerState<CommandPalette> {
  final _query = TextEditingController();
  final _scroll = ScrollController();
  int _highlight = 0;
  List<PaletteItem> _shown = const [];

  static const _rowHeight = 52.0;

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() => _highlight = 0));
  }

  @override
  void dispose() {
    _query.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _move(int delta) {
    if (_shown.isEmpty) return;
    setState(() => _highlight = (_highlight + delta).clamp(0, _shown.length - 1));
    // Keep the highlighted row in view.
    if (!_scroll.hasClients) return;
    final top = _highlight * _rowHeight;
    final view = _scroll.position.viewportDimension;
    final offset = _scroll.offset;
    if (top < offset) {
      _scroll.jumpTo(top);
    } else if (top + _rowHeight > offset + view) {
      _scroll.jumpTo(top + _rowHeight - view);
    }
  }

  void _pick([int? index]) {
    final i = index ?? _highlight;
    if (i < 0 || i >= _shown.length) return;
    unawaited(HapticFeedback.selectionClick());
    Navigator.of(context).pop(_shown[i]);
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final text = _query.text.trim();
    final ranked = rankPalette(widget.items, text, recents: ref.watch(paletteRecentsProvider));
    _shown = [...ranked, if (text.isNotEmpty) widget.searchItem(text)];
    final media = MediaQuery.of(context);
    final room = media.size.height - media.viewInsets.bottom - media.padding.top - 160;
    return Dialog(
      alignment: Alignment.topCenter,
      backgroundColor: colors.cellBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: EdgeInsets.fromLTRB(16, media.size.height > 600 ? 72 : 16, 16, 16),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.arrowDown): () => _move(1),
                  const SingleActivator(LogicalKeyboardKey.arrowUp): () => _move(-1),
                  const SingleActivator(LogicalKeyboardKey.enter): _pick,
                },
                child: CupertinoSearchTextField(
                  key: const Key('palette-field'),
                  controller: _query,
                  autofocus: true,
                  autocorrect: false,
                  placeholder: 'Search actions, mailboxes, settings',
                  backgroundColor: colors.fill,
                  style: styles.body,
                  placeholderStyle: styles.body.copyWith(color: colors.secondaryText),
                  prefixIcon: const Icon(LoupeIcons.search),
                  suffixIcon: const Icon(LoupeIcons.clear),
                  onSubmitted: (_) => _pick(),
                ),
              ),
            ),
            Divider(height: 0.5, thickness: 0.5, color: colors.separator),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: math.max(_rowHeight * 3, math.min(_rowHeight * 8, room))),
              child: _shown.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('Nothing found', style: styles.footnote, textAlign: TextAlign.center),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemExtent: _rowHeight,
                      itemCount: _shown.length,
                      itemBuilder: (context, i) =>
                          _PaletteRow(item: _shown[i], highlighted: i == _highlight, onTap: () => _pick(i)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteRow extends StatelessWidget {
  const _PaletteRow({required this.item, required this.highlighted, required this.onTap});

  final PaletteItem item;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final shortcut = item.shortcut;
    return Semantics(
      selected: highlighted,
      button: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Material(
          color: highlighted ? colors.selectedRow : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(item.icon, size: 22, color: item.color ?? colors.unreadDot),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: styles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                        if (item.subtitle case final sub?)
                          Text(sub, style: styles.footnote, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  if (shortcut != null) ...[const SizedBox(width: 8), KeyCaps(shortcut)],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
