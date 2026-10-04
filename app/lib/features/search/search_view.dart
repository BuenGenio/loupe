import 'dart:async';

import 'package:expr_search/expr_search.dart';
import 'package:flutter/cupertino.dart';
// mail_model's SearchField (search fields) is meant here, not the widget.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../router.dart';
import '../../shared/bars.dart';
import '../../settings/app_settings.dart';
import '../../settings/ui_state.dart';
import '../../shared/format.dart';
import '../../shared/mail_actions.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/mailbox_ref_codec.dart';
import '../../shared/message_row.dart';
import '../../shared/sheets.dart';
import '../../shared/swipe_row.dart';
import '../../shared/tags.dart';
import '../../theme/theme.dart';
import 'search_session.dart';
import '../../theme/loupe_icons.dart';

/// The search UI below a search field: scope control, suggestions while the
/// field is empty, then chips, people and streamed results.
class SearchSlivers extends ConsumerStatefulWidget {
  const SearchSlivers({super.key, required this.session, this.thisMailbox, this.showSuggestions = true});

  final SearchSession session;

  /// Offers "All Mailboxes | this mailbox" when set.
  final MailboxRef? thisMailbox;

  /// False for smart mailboxes, which only show results.
  final bool showSuggestions;

  @override
  ConsumerState<SearchSlivers> createState() => _SearchSliversState();
}

class _SearchSliversState extends ConsumerState<SearchSlivers> {
  String? _peopleQuery;
  Future<List<EmailAddress>>? _people;

  SearchSession get _session => widget.session;

  int get _cursor {
    final selection = _session.controller.selection;
    return selection.isValid ? selection.baseOffset.clamp(0, _session.query.length) : _session.query.length;
  }

  Future<List<EmailAddress>> _peopleFor(String prefix) {
    if (prefix != _peopleQuery || _people == null) {
      _peopleQuery = prefix;
      _people = ref.read(repositoryProvider).suggestAddresses(prefix, limit: prefix.isEmpty ? 5 : 3);
    }
    return _people!;
  }

  void _pick(String query) {
    _session.setQuery(query);
    unawaited(ref.read(recentSearchesProvider.notifier).add(query.trim()));
  }

  void _open(EmailSummary email) {
    unawaited(ref.read(recentSearchesProvider.notifier).add(_session.query.trim()));
    FocusManager.instance.primaryFocus?.unfocus();
    if (!email.isSeen) {
      unawaited(ref.read(repositoryProvider).setKeywords([email.id], add: const {Keywords.seen}));
    }
    unawaited(context.push(Routes.message(email.id)));
  }

  Future<void> _saveSmartMailbox() async {
    final query = _session.query.trim();
    final name = await showTextPrompt(
      context,
      title: 'New Smart Mailbox',
      message: 'Shows everything matching “$query”.',
      initial: query,
      placeholder: 'Name',
    );
    if (name == null || name.isEmpty || !mounted) return;
    final scope = switch (_session.scope) {
      MailboxScope(:final ref) => MailboxRefCodec.encode(ref),
      AllMailboxesScope() => null,
    };
    await ref.read(smartMailboxesProvider.notifier).add(name, query, scope: scope);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved “$name” to Mailboxes')));
  }

  /// The search's menu: what to make of this search.
  Future<void> _showMenu() async {
    final query = _session.query.trim();
    final choice = await showActionSheet<String>(
      context,
      title: query,
      actions: const [
        SheetAction('Make This a Rule', 'rule', icon: LoupeIcons.makeRule),
        SheetAction('Save as Smart Mailbox', 'smart', icon: LoupeIcons.saveSearch),
      ],
    );
    if (!mounted) return;
    switch (choice) {
      case 'rule':
        FocusManager.instance.primaryFocus?.unfocus();
        unawaited(context.push(Routes.newRule(condition: query)));
      case 'smart':
        await _saveSmartMailbox();
    }
  }

  Future<void> _editChip(List<SearchExpr> terms, int index) async {
    final term = terms[index];
    final negated = term is SearchNot;
    final choice = await showActionSheet<String>(
      context,
      title: describeTerm(term),
      actions: [
        SheetAction(negated ? 'Don’t Negate' : 'Negate', 'negate', icon: LoupeIcons.negate),
        const SheetAction('Remove', 'remove', icon: LoupeIcons.backspace, destructive: true),
      ],
    );
    if (choice == null) return;
    final next = [...terms];
    if (choice == 'remove') {
      next.removeAt(index);
    } else {
      next[index] = term is SearchNot ? term.child : SearchNot(term);
    }
    final text = queryFromTerms(next);
    _session.setQuery(text.isEmpty ? '' : '$text ');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _session,
      builder: (context, _) {
        final slivers = <Widget>[
          if (widget.thisMailbox != null) SliverToBoxAdapter(child: _scopeBar(context)),
          if (!_session.hasQuery && widget.showSuggestions) ..._suggestions(context) else ..._results(context),
        ];
        return SliverMainAxisGroup(slivers: slivers);
      },
    );
  }

  Widget _scopeBar(BuildContext context) {
    final mailboxes = ref.watch(mailboxesProvider).value ?? const <Mailbox>[];
    final label = mailboxRefTitle(widget.thisMailbox!, mailboxes);
    final isAll = _session.scope is AllMailboxesScope;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<bool>(
          groupValue: isAll,
          onValueChanged: (all) =>
              _session.setScope((all ?? true) ? const AllMailboxesScope() : MailboxScope(widget.thisMailbox!)),
          children: {
            true: const Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('All Mailboxes')),
            false: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          },
        ),
      ),
    );
  }

  // Suggestions (empty field) -----------------------------------------------------------

  List<Widget> _suggestions(BuildContext context) {
    final recents = ref.watch(recentSearchesProvider);
    final smart = ref.watch(smartMailboxesProvider);
    return [
      if (recents.isNotEmpty) ...[
        SliverToBoxAdapter(
          child: _SectionHeader(
            'Recent Searches',
            action: 'Clear',
            onAction: () => ref.read(recentSearchesProvider.notifier).clear(),
          ),
        ),
        SliverList.list(
          children: [for (final q in recents) _SuggestionRow(icon: LoupeIcons.recent, label: q, onTap: () => _pick(q))],
        ),
      ],
      const SliverToBoxAdapter(child: _SectionHeader('Suggestions')),
      SliverList.list(
        children: [
          _SuggestionRow(
            icon: LoupeIcons.unread,
            label: 'Unread Messages',
            onTap: () => _session.addToken(SearchTokens.unread),
          ),
          _SuggestionRow(
            icon: LoupeIcons.flagged,
            label: 'Flagged Messages',
            onTap: () => _session.addToken(SearchTokens.flagged),
          ),
          _SuggestionRow(
            icon: LoupeIcons.attachment,
            label: 'Messages with Attachments',
            onTap: () => _session.addToken(SearchTokens.attachments),
          ),
          _SuggestionRow(
            icon: LoupeIcons.reply,
            label: 'Unreplied Messages',
            onTap: () => _session.addToken(SearchTokens.unreplied),
          ),
        ],
      ),
      const SliverToBoxAdapter(child: _SectionHeader('Tags')),
      SliverList.list(
        children: [
          for (final t in TagDefinition.thunderbirdDefaults)
            _SuggestionRow(
              leading: Icon(LoupeIcons.tagFilled, size: 18, color: tagColor(t.keyword)),
              label: t.label,
              onTap: () => _session.addToken(SearchTokens.tag(t.keyword)),
            ),
        ],
      ),
      SliverToBoxAdapter(
        child: FutureBuilder<List<EmailAddress>>(
          future: _peopleFor(''),
          builder: (context, snapshot) {
            final people = snapshot.data ?? const <EmailAddress>[];
            if (people.isEmpty) return const SizedBox.shrink();
            return Column(
              children: [
                const _SectionHeader('People'),
                for (final p in people)
                  _SuggestionRow(
                    icon: LoupeIcons.contact,
                    label: p.displayName,
                    detail: p.email,
                    onTap: () => _session.addToken(SearchTokens.from(p)),
                  ),
              ],
            );
          },
        ),
      ),
      if (smart.isNotEmpty) ...[
        const SliverToBoxAdapter(child: _SectionHeader('Smart Mailboxes')),
        SliverList.list(
          children: [
            for (final s in smart)
              _SuggestionRow(
                icon: LoupeIcons.smartMailbox,
                label: s.name,
                detail: s.query,
                onTap: () => context.push(Routes.smartMailbox(s.id)),
              ),
          ],
        ),
      ],
      const SliverToBoxAdapter(child: SizedBox(height: 32)),
    ];
  }

  // Results (something typed) -------------------------------------------------------------

  List<Widget> _results(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final parsed = _session.parsed;
    final terms = parsed.isValid ? queryTerms(parsed.expr) : const <SearchExpr>[];
    final showChips = terms.length > 1 || terms.any((t) => !(t is TextTerm && t.field == SearchField.any));
    final results = _session.results;
    final accounts = {for (final a in ref.watch(accountsProvider).value ?? const <MailAccount>[]) a.id: a};
    final boxes = {for (final m in ref.watch(mailboxesProvider).value ?? const <Mailbox>[]) m.id: m};
    final vips = ref.watch(vipAddressesProvider).value ?? const <String>{};
    final settings = ref.watch(appSettingsProvider);
    final actions = MailActions(context, ref, scope: null, threaded: false);
    final lastWord = _session.query.split(RegExp(r'\s+')).lastWhere((w) => w.isNotEmpty, orElse: () => '');
    final suggestPeople = widget.showSuggestions && lastWord.length >= 2 && !lastWord.contains(':');
    final word = _session.currentWord;
    final completions = widget.showSuggestions && word.isNotEmpty
        ? suggest(_session.query, _cursor).where((c) => c.insertText != word).take(4).toList()
        : const <QuerySuggestion>[];
    final stale = results != null && _session.resultsQuery != _session.query;

    return [
      if (showChips)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: [
                for (final (i, t) in terms.indexed)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _Chip(
                      label: describeTerm(t),
                      // Some descriptions already read naturally ("Unread").
                      negated: t is SearchNot && describeTerm(t).toLowerCase().startsWith('not'),
                      onTap: () => _editChip(terms, i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      if (completions.isNotEmpty)
        SliverList.list(
          children: [
            for (final c in completions)
              _SuggestionRow(
                icon: LoupeIcons.completion,
                label: c.insertText,
                detail: c.detail,
                onTap: () => _session.completeWord(c.insertText),
              ),
          ],
        ),
      if (suggestPeople)
        SliverToBoxAdapter(
          child: FutureBuilder<List<EmailAddress>>(
            future: _peopleFor(lastWord),
            builder: (context, snapshot) {
              final people = snapshot.data ?? const <EmailAddress>[];
              if (people.isEmpty) return const SizedBox.shrink();
              return Column(
                children: [
                  for (final p in people)
                    _SuggestionRow(
                      icon: LoupeIcons.contact,
                      label: 'From: ${p.displayName}',
                      detail: p.email,
                      onTap: () {
                        final words = _session.query.trimRight().split(RegExp(r'\s+'))..removeLast();
                        final prefix = words.join(' ');
                        _pick('${prefix.isEmpty ? '' : '$prefix '}${SearchTokens.from(p)} ');
                      },
                    ),
                ],
              );
            },
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 6, 4),
          child: Row(
            children: [
              Text(
                results == null
                    ? 'Searching…'
                    : results.items.isEmpty && results.isComplete
                    ? 'No Results'
                    : '${formatCount(results.items.length)} ${results.items.length == 1 ? 'Result' : 'Results'}',
                style: styles.sectionHeader.copyWith(fontSize: 17),
              ),
              if (widget.showSuggestions && _session.hasQuery) ...[
                const Spacer(),
                Flexible(
                  child: Semantics(
                    button: true,
                    label: 'Save as Smart Mailbox',
                    excludeSemantics: true,
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: const Size(44, 32),
                      onPressed: _saveSmartMailbox,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LoupeIcons.saveSearch, size: 18),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'Save as Smart Mailbox',
                              style: TextStyle(fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BarIconButton(icon: LoupeIcons.moreCircle, tooltip: 'Search Menu', size: 22, onPressed: _showMenu),
              ],
            ],
          ),
        ),
      ),
      if (results != null)
        for (final id in results.pendingAccountIds)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
              child: Row(
                children: [
                  const CupertinoActivityIndicator(radius: 7),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Searching ${accounts[id]?.displayName ?? 'account'} on the server…',
                      style: styles.footnote,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
      if (results != null)
        for (final id in results.failedAccountIds)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
              child: Row(
                children: [
                  Icon(LoupeIcons.error, size: 15, color: colors.secondaryText),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Couldn’t search ${accounts[id]?.displayName ?? 'account'} on the server',
                      style: styles.footnote,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
      if (results != null)
        SliverOpacity(
          opacity: stale ? 0.6 : 1,
          sliver: SliverList.builder(
            itemCount: results.items.length,
            itemBuilder: (context, i) {
              final email = results.items[i];
              final box = boxes[email.mailboxId];
              final account = accounts[email.accountId];
              final row = ThreadSummary(
                threadId: email.threadId ?? email.id,
                latest: email,
                messageCount: 1,
                unreadCount: email.isSeen ? 0 : 1,
              );
              return SwipeActionRow(
                key: ValueKey(email.id),
                leading: actions.leadingSwipes(row, settings),
                trailing: actions.trailingSwipes(row, settings),
                child: MessageRow(
                  email: email,
                  isVip: email.from.any((f) => vips.contains(f.email.toLowerCase())),
                  fromServer: results.fromServerIds.contains(email.id),
                  location: [
                    if (box != null) mailboxDisplayName(box),
                    if (account != null && accounts.length > 1) account.displayName,
                  ].join(' · '),
                  showRecipients: box?.role == MailboxRole.sent || box?.role == MailboxRole.drafts,
                  onTap: () => _open(email),
                  onLongPress: () => actions.showMore(row),
                ),
              );
            },
          ),
        ),
      SliverToBoxAdapter(child: SizedBox(height: 32 + MediaQuery.paddingOf(context).bottom)),
    ];
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 6, 4),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styles.sectionHeader.copyWith(fontSize: 17))),
          if (action != null)
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(44, 28),
              onPressed: onAction,
              child: Text(action!, style: const TextStyle(fontSize: 15)),
            ),
        ],
      ),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.label, required this.onTap, this.icon, this.leading, this.detail});

  final IconData? icon;
  final Widget? leading;
  final String label;
  final String? detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            SizedBox(width: 26, child: leading ?? Icon(icon, size: 20, color: colors.unreadDot)),
            const SizedBox(width: 12),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: colors.separator, width: 0.5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(label, style: styles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      if (detail != null) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(detail!, style: styles.footnote, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.onTap, this.negated = false});

  final String label;
  final bool negated;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final tint = negated ? colors.destructive : colors.unreadDot;
    return Semantics(
      button: true,
      label: '${negated ? 'Not ' : ''}$label. Double tap to edit.',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: tint.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (negated) ...[Icon(LoupeIcons.remove, size: 14, color: tint), const SizedBox(width: 4)],
              Text(
                label,
                style: TextStyle(color: tint, fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 4),
              Icon(LoupeIcons.expand, size: 11, color: tint),
            ],
          ),
        ),
      ),
    );
  }
}
