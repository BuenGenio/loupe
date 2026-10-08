import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../settings/ui_state.dart';
import '../../shared/bars.dart';
import '../../theme/theme.dart';
import 'search_session.dart';
import 'search_view.dart';

/// Full-screen search with [initialQuery] already entered ("Search from this
/// message", tags on the Mailboxes screen).
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.initialQuery = '', this.scope = const AllMailboxesScope()});

  final String initialQuery;
  final SearchScope scope;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final SearchSession _session = SearchSession(
    repository: ref.read(repositoryProvider),
    scope: widget.scope,
    initialQuery: widget.initialQuery.isEmpty ? '' : '${widget.initialQuery.trimRight()} ',
    onCommit: (q) => ref.read(recentSearchesProvider.notifier).add(q),
  );
  final _focus = FocusNode();

  @override
  void dispose() {
    _session.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    _session.controller
      ..operatorColor = colors.unreadDot
      ..keywordColor = colors.swipeArchive
      ..quotedColor = colors.success
      ..errorColor = colors.destructive;
    final thisMailbox = switch (widget.scope) {
      MailboxScope(:final ref) => ref,
      AllMailboxesScope() => null,
    };
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          LoupeTitleBar(
            title: context.l10n.commonSearch,
            searching: true,
            onCancelSearch: () => Navigator.of(context).maybePop(),
            searchField: LoupeSearchField(
              controller: _session.controller,
              focusNode: _focus,
              autofocus: widget.initialQuery.isEmpty,
              onChanged: _session.onChanged,
              onSubmitted: (_) => _session.submit(),
            ),
          ),
          SearchSlivers(session: _session, thisMailbox: thisMailbox),
        ],
      ),
    );
  }
}
