import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import 'project_settings.dart';
import 'projects_state.dart';
import 'topic_ai.dart';
import 'topic_suggestions.dart';

/// A project's newest conversation.
final projectLatestProvider = StreamProvider.family<ThreadSummary?, String>(
  (ref, keyword) =>
      ref.watch(repositoryProvider).watchList(KeywordMailboxRef(keyword), limit: 1).map((rows) => rows.firstOrNull),
);

/// The conversations of [MailboxRef] in no project: how many are unread, and
/// the newest (the Everything Else tile).
final outsideProjectsProvider = StreamProvider.family<({int unread, ThreadSummary? latest}), MailboxRef>(
  (ref, mailbox) => ref.watch(repositoryProvider).watchList(mailbox, limit: 200).map((rows) {
    final outside = rows.where((r) => r.latest.projectIds.isEmpty).toList();
    return (unread: outside.where((r) => r.unreadCount > 0).length, latest: outside.firstOrNull);
  }),
);

/// A message of an AI error, for the line under the tiles and Settings.
String topicAiErrorText(AppLocalizations l10n, TopicAiException e) => switch (e.error) {
  TopicAiError.unreachable => l10n.projectsAiUnreachable,
  TopicAiError.refused => l10n.projectsAiRefused,
  TopicAiError.status => l10n.projectsAiStatus(e.detail),
  TopicAiError.timeout => l10n.projectsAiTimeout,
  TopicAiError.badAnswer => l10n.projectsAiBadAnswer,
  TopicAiError.noModel => l10n.projectsAiNoModel(e.detail),
};

/// The Tiles view of an Inbox list ([mailbox]): a tile per active project,
/// the most recently active first, then the suggested topics (dashed, with
/// Make Project and Not a Topic), then Everything Else.
List<Widget> projectTileSlivers(BuildContext context, WidgetRef ref, MailboxRef mailbox) {
  final l10n = context.l10n;
  final styles = LoupeTextStyles.of(context);
  final colors = LoupeColors.of(context);
  final settings = ref.watch(projectSettingsProvider);
  final unread = ref.watch(projectUnreadProvider).value ?? const <String, int>{};
  final projects =
      [
        for (final p in ref.watch(projectsProvider))
          if (!p.done) (project: p, latest: ref.watch(projectLatestProvider(p.keyword)).value),
      ]..sort((a, b) {
        final at = a.latest?.latest.receivedAt, bt = b.latest?.latest.receivedAt;
        if (at == null || bt == null) return at == null ? (bt == null ? 0 : 1) : -1;
        return bt.compareTo(at);
      });
  final topics = settings.suggest ? ref.watch(topicSuggestionsProvider) : const TopicState();
  final outside = settings.everythingElse ? ref.watch(outsideProjectsProvider(mailbox)).value : null;
  final tiles = <Widget>[
    for (final (:project, :latest) in projects)
      _Tile(
        key: ValueKey('tile-${project.id}'),
        color: project.color,
        title: project.name,
        unread: unread[project.keyword] ?? 0,
        latest: latest,
        onTap: () => context.push(Routes.list(project.ref)),
      ),
    for (final s in topics.suggestions) _SuggestionTile(key: ValueKey('suggestion-${s.key}'), suggestion: s),
    if (outside != null)
      _Tile(
        key: const ValueKey('tile-everything-else'),
        color: colors.secondaryText,
        icon: LoupeIcons.inbox,
        title: l10n.projectsEverythingElse,
        unread: outside.unread,
        latest: outside.latest,
        onTap: () => context.push(Routes.listOutsideProjects(mailbox)),
      ),
  ];
  final error = topics.aiError;
  return [
    if (tiles.isEmpty)
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
          child: Text(l10n.projectsTilesEmpty, style: styles.footnote, textAlign: TextAlign.center),
        ),
      )
    else
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        sliver: SliverGrid(
          delegate: SliverChildListDelegate(tiles),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisExtent: 150,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        ),
      ),
    if (topics.thinking || error != null)
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Row(
            children: [
              if (topics.thinking)
                const Padding(padding: EdgeInsets.only(right: 8), child: CupertinoActivityIndicator(radius: 7))
              else
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(LoupeIcons.warning, size: 14, color: colors.secondaryText),
                ),
              Expanded(
                child: Text(
                  topics.thinking ? l10n.projectsAiThinking : l10n.projectsAiFailed(topicAiErrorText(l10n, error!)),
                  style: styles.footnote,
                ),
              ),
            ],
          ),
        ),
      ),
  ];
}

/// A project's tile (or Everything Else): its colour, name and unread count,
/// then the newest conversation's sender, subject and time.
class _Tile extends StatelessWidget {
  const _Tile({
    super.key,
    required this.color,
    required this.title,
    required this.unread,
    required this.latest,
    required this.onTap,
    this.icon = LoupeIcons.projectFilled,
  });

  final Color color;
  final IconData icon;
  final String title;
  final int unread;
  final ThreadSummary? latest;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final email = latest?.latest;
    final sender = email?.sender?.displayName ?? '';
    return Semantics(
      button: true,
      label: unread > 0 ? '$title, ${l10n.messageListUnreadCount(unread, formatCount(unread))}' : title,
      excludeSemantics: true,
      child: Material(
        color: colors.cellBackground,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: color, width: 4)),
            ),
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 16, color: color),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(title, style: styles.senderUnread, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    if (unread > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                        decoration: BoxDecoration(color: colors.unreadDot, borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          formatCount(unread),
                          style: styles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (email != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          sender,
                          style: styles.caption.copyWith(color: colors.label, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(formatListDate(email.receivedAt, l10n: l10n), style: styles.caption),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email.subject.trim().isEmpty ? l10n.mailNoSubject : email.subject,
                    style: styles.preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else
                  Text('—', style: styles.preview),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A suggested topic: dashed, with its conversations' count and newest
/// subject, Make Project and Not a Topic.
class _SuggestionTile extends ConsumerWidget {
  const _SuggestionTile({super.key, required this.suggestion});

  final TopicSuggestion suggestion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final s = suggestion;
    final newest = s.threads.first;
    return CustomPaint(
      foregroundPainter: _DashedBorder(color: colors.tertiaryText, radius: 14),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: s.query.isEmpty ? null : () => context.push(Routes.search(s.query)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      s.kind == TopicKind.named ? LoupeIcons.sparkle : LoupeIcons.project,
                      size: 16,
                      color: colors.secondaryText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(s.label, style: styles.senderUnread, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.projectsSuggested(s.threads.length),
                  style: styles.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  newest.subject.isEmpty ? l10n.mailNoSubject : newest.subject,
                  style: styles.preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Flexible(
                      child: CupertinoButton(
                        key: ValueKey('make-${s.key}'),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(0, 30),
                        color: colors.unreadDot,
                        borderRadius: BorderRadius.circular(8),
                        onPressed: () => unawaited(
                          makeProjectFrom(ref.read(repositoryProvider), ref.read(projectsProvider.notifier), s),
                        ),
                        child: Text(
                          l10n.projectsMakeProject,
                          style: styles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Flexible(
                      child: CupertinoButton(
                        key: ValueKey('dismiss-${s.key}'),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 30),
                        onPressed: () => ref.read(dismissedTopicsProvider.notifier).toggle(s.key),
                        child: Text(
                          l10n.projectsNotATopic,
                          style: styles.caption.copyWith(color: colors.unreadDot),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorder extends CustomPainter {
  const _DashedBorder({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)).deflate(0.6));
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 9) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorder old) => old.color != color || old.radius != radius;
}
