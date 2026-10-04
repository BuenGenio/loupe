import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
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
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeader(
              topPadding: MediaQuery.paddingOf(context).top,
              background: colors.barBackground,
              separator: colors.separator,
              field: LoupeSearchField(
                controller: _session.controller,
                focusNode: _focus,
                autofocus: widget.initialQuery.isEmpty,
                onChanged: _session.onChanged,
                onSubmitted: (_) => _session.submit(),
              ),
            ),
          ),
          SearchSlivers(session: _session, thisMailbox: thisMailbox),
        ],
      ),
    );
  }
}

class _SearchHeader extends SliverPersistentHeaderDelegate {
  _SearchHeader({required this.topPadding, required this.field, required this.background, required this.separator});

  final double topPadding;
  final Widget field;
  final Color background;
  final Color separator;

  @override
  double get minExtent => topPadding + 54;

  @override
  double get maxExtent => topPadding + 54;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border(bottom: BorderSide(color: overlapsContent || shrinkOffset > 0 ? separator : background)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, topPadding + 8, 4, 8),
        child: Row(
          children: [
            Expanded(child: field),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchHeader old) =>
      old.topPadding != topPadding || old.field != field || old.background != background;
}
