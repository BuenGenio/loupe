import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';
import '../../settings/ui_state.dart';
import '../../shared/mailbox_display.dart';
import '../../shared/tags.dart';
import '../../theme/loupe_icons.dart';
import '../compose/compose_args.dart';
import '../keyboard/mail_commands.dart';
import '../keyboard/shortcut_sheet.dart';
import '../keyboard/shortcuts.dart';
import '../subscriptions/subscription_providers.dart';
import '../search/search_session.dart';
import 'fuzzy.dart';

/// What an entry of the command palette is, in the order they are listed.
enum PaletteKind { action, mailbox, setting, search }

/// One entry of the command palette.
@immutable
final class PaletteItem {
  const PaletteItem({
    required this.id,
    required this.title,
    required this.kind,
    required this.icon,
    required this.run,
    this.subtitle,
    this.keywords = const [],
    this.shortcut,
    this.color,
  });

  /// Stable across launches, to remember it among the recently used.
  final String id;
  final String title;
  final String? subtitle;
  final PaletteKind kind;
  final IconData icon;
  final Color? color;

  /// Other words it answers to ("compose" for New Message).
  final List<String> keywords;

  /// Its keyboard shortcut's keys, as shown (["E"], ["⌘", "N"]).
  final List<String>? shortcut;

  /// Runs it, after the palette closed.
  final FutureOr<void> Function() run;

  /// How well it matches [query] (see [fuzzyScore]); null if it doesn't.
  int? score(String query) {
    int? best = fuzzyScore(query, title);
    for (final k in keywords) {
      final s = fuzzyScore(query, k);
      if (s != null && (best == null || s - 4 > best)) best = s - 4;
    }
    if (subtitle case final sub?) {
      // "work inbox" finds Work's Inbox.
      final s = fuzzyScore(query, '$sub $title');
      if (s != null && (best == null || s - 8 > best)) best = s - 8;
    }
    return best;
  }
}

/// Recently run palette entries, newest first.
final paletteRecentsProvider = NotifierProvider<PaletteRecents, List<String>>(PaletteRecents.new);

class PaletteRecents extends Notifier<List<String>> {
  static const key = 'palette.recent';
  static const max = 12;

  @override
  List<String> build() {
    ref.watch(prefsEpochProvider);
    return ref.watch(sharedPreferencesProvider).getStringList(key) ?? const [];
  }

  Future<void> add(String id) async {
    state = [id, ...state.where((s) => s != id)].take(max).toList();
    await ref.read(sharedPreferencesProvider).setStringList(key, state);
  }
}

/// The entries matching [query], best first, with "Search mail for …" last
/// (first when nothing else matches). Without a query: the recently used
/// first, then actions, places, settings and recent searches.
List<PaletteItem> rankPalette(List<PaletteItem> items, String query, {List<String> recents = const []}) {
  final recency = {for (final (i, id) in recents.indexed) id: i};
  final q = query.trim();
  if (q.isEmpty) {
    final recent = [for (final id in recents) ?items.where((i) => i.id == id).firstOrNull];
    return [...recent, ...items.where((i) => !recency.containsKey(i.id))];
  }
  final scored = <(PaletteItem, int)>[];
  for (final item in items) {
    final s = item.score(q);
    if (s == null) continue;
    // The recently used come first among similar matches.
    final r = recency[item.id];
    scored.add((item, s + (r == null ? 0 : 12 - r)));
  }
  scored.sort((a, b) {
    final byScore = b.$2.compareTo(a.$2);
    if (byScore != 0) return byScore;
    final byKind = a.$1.kind.index.compareTo(b.$1.kind.index);
    return byKind != 0 ? byKind : a.$1.title.length.compareTo(b.$1.title.length);
  });
  return [for (final (item, _) in scored.take(40)) item];
}

/// The palette's entries for the screen on top, read now and run later,
/// named in [l10n]'s words. Their keywords stay English, as extra words to
/// find them by.
List<PaletteItem> paletteItems(ProviderContainer container, AppLocalizations l10n) {
  final router = container.read(routerProvider);
  final commands = container.read(mailCommandsProvider);
  final navigator = router.routerDelegate.navigatorKey;
  final items = <PaletteItem>[];

  // Actions on the conversation or list on top.
  void command(
    MailCommand c,
    String title,
    IconData icon, {
    List<String> keywords = const [],
    FutureOr<void> Function()? otherwise,
  }) {
    final handler = commands.handlerFor(c);
    if (handler == null && otherwise == null) return;
    items.add(
      PaletteItem(
        id: 'action.${c.name}',
        title: title,
        kind: PaletteKind.action,
        icon: icon,
        keywords: keywords,
        shortcut: shortcutKeys(c, l10n),
        run: handler == null ? otherwise! : () => handler.run(c),
      ),
    );
  }

  command(
    MailCommand.newMessage,
    l10n.mailNewMessage,
    LoupeIcons.compose,
    keywords: const ['compose', 'write'],
    otherwise: () => router.push<void>(Routes.compose, extra: const ComposeArgs()),
  );
  command(MailCommand.reply, l10n.mailReply, LoupeIcons.reply);
  command(MailCommand.replyAll, l10n.mailReplyAll, LoupeIcons.replyAll);
  command(MailCommand.forward, l10n.mailForward, LoupeIcons.forward);
  command(MailCommand.archive, l10n.mailArchive, LoupeIcons.archive);
  command(MailCommand.trash, l10n.keyboardMoveToTrash, LoupeIcons.trash, keywords: const ['delete']);
  command(MailCommand.toggleRead, l10n.keyboardToggleRead, LoupeIcons.markRead, keywords: const ['seen']);
  command(MailCommand.toggleFlag, l10n.keyboardToggleFlag, LoupeIcons.flagged, keywords: const ['star']);
  command(MailCommand.snooze, l10n.sharedSnooze, LoupeIcons.snooze, keywords: const ['remind', 'later']);
  command(MailCommand.move, l10n.paletteMoveToMailbox, LoupeIcons.move, keywords: const ['folder', 'file']);
  command(MailCommand.markAllRead, l10n.paletteMarkAllRead, LoupeIcons.markAllRead);
  command(
    MailCommand.exportFolder,
    l10n.paletteExportFolder,
    LoupeIcons.exportFolder,
    keywords: const ['mbox', 'save', 'backup', 'download'],
  );
  command(
    MailCommand.refresh,
    l10n.paletteGetNewMail,
    LoupeIcons.refresh,
    keywords: const ['refresh', 'sync', 'check'],
    otherwise: () => container.read(repositoryProvider).refresh(),
  );
  items.add(
    PaletteItem(
      id: 'action.shortcuts',
      title: l10n.keyboardShortcuts,
      kind: PaletteKind.action,
      icon: LoupeIcons.keyboard,
      keywords: const ['help', 'keys'],
      shortcut: shortcutKeys(MailCommand.shortcuts, l10n),
      run: () {
        final ctx = navigator.currentContext;
        if (ctx != null) return showShortcutSheet(ctx);
      },
    ),
  );

  // Places.
  PaletteItem place(
    String id,
    String title,
    IconData icon,
    String location, {
    String? subtitle,
    Color? color,
    List<String> keywords = const [],
  }) => PaletteItem(
    id: id,
    title: title,
    subtitle: subtitle,
    kind: PaletteKind.mailbox,
    icon: icon,
    color: color,
    keywords: keywords,
    run: () => router.push<void>(location),
  );
  final accounts = container.read(accountsProvider).value ?? const <MailAccount>[];
  for (final kind in const [
    VirtualMailbox.allInboxes,
    VirtualMailbox.vip,
    VirtualMailbox.flagged,
    VirtualMailbox.unread,
    VirtualMailbox.allDrafts,
    VirtualMailbox.allSent,
  ]) {
    items.add(
      place(
        'mailbox.v.${kind.name}',
        virtualMailboxTitle(kind, l10n: l10n),
        virtualMailboxIcon(kind),
        Routes.list(VirtualMailboxRef(kind)),
      ),
    );
  }
  items
    ..add(place('mailbox.snoozed', l10n.paletteSnoozed, LoupeIcons.snoozed, Routes.snoozed))
    ..add(place('mailbox.outbox', l10n.mailboxOutbox, LoupeIcons.outbox, Routes.outbox))
    ..add(
      place(
        'mailbox.subscriptions',
        l10n.paletteSubscriptions,
        LoupeIcons.subscriptions,
        Routes.subscriptions,
        keywords: const ['newsletters', 'unsubscribe', 'mailing lists', 'discussions'],
      ),
    )
    ..add(
      place(
        'mailbox.subscriptions.discussions',
        l10n.paletteDiscussions,
        LoupeIcons.mailingList,
        Routes.subscriptionsTab(SubscriptionKind.discussion),
        subtitle: l10n.paletteSubscriptions,
        keywords: const ['mailing lists'],
      ),
    );
  final mailboxes = container.read(mailboxesProvider).value ?? const <Mailbox>[];
  final showAll = container.read(showAllFoldersProvider);
  for (final account in accounts) {
    final own = [
      for (final m in mailboxes)
        if (m.accountId == account.id && m.isSelectable && !ServerDocuments.isFolder(m) && !Snooze.isFolder(m)) m,
    ];
    final byId = {for (final m in own) m.id: m};
    for (final m in showAll.contains(account.id) ? own : subscribedFolders(own)) {
      // Nested folders say where they are: Work › Projects.
      final parents = <String>[];
      for (var p = byId[m.parentId]; p != null; p = byId[p.parentId]) {
        parents.insert(0, mailboxDisplayName(p, l10n: l10n));
      }
      items.add(
        place(
          'mailbox.${m.id}',
          mailboxDisplayName(m, l10n: l10n),
          mailboxIcon(m.role),
          Routes.list(RealMailboxRef(m.id)),
          subtitle: [account.displayName, ...parents].join(' › '),
        ),
      );
    }
  }
  for (final s in container.read(smartMailboxesProvider)) {
    items.add(
      place(
        'smart.${s.id}',
        s.name,
        LoupeIcons.smartMailbox,
        Routes.smartMailbox(s.id),
        subtitle: l10n.paletteSmartMailbox,
      ),
    );
  }
  for (final l in container.read(discussionsProvider)) {
    items.add(
      place(
        'list.${l.listId}',
        l.name,
        LoupeIcons.mailingList,
        Routes.mailingList(l.listId!),
        subtitle: l10n.paletteMailingList,
      ),
    );
  }
  for (final tag in TagDefinition.thunderbirdDefaults) {
    items.add(
      place(
        'tag.${tag.keyword}',
        tagLabel(tag.keyword, l10n: l10n),
        LoupeIcons.tagFilled,
        Routes.search(SearchTokens.tag(tag.keyword)),
        subtitle: l10n.paletteTag,
        color: tagColor(tag.keyword),
      ),
    );
  }

  // Settings.
  PaletteItem setting(
    String id,
    String title,
    String location, {
    IconData icon = LoupeIcons.settings,
    String? sub,
    bool showSub = true,
    List<String> keywords = const [],
  }) => PaletteItem(
    id: 'settings.$id',
    title: title,
    subtitle: showSub ? sub ?? l10n.commonSettings : null,
    kind: PaletteKind.setting,
    icon: icon,
    keywords: keywords,
    run: () => router.push<void>(location),
  );
  items
    ..add(setting('main', l10n.commonSettings, Routes.settings, showSub: false, keywords: const ['preferences']))
    ..add(setting('swipes', l10n.paletteSwipeActions, Routes.swipeSettings, icon: LoupeIcons.swipeActions))
    ..add(
      setting('notifications', l10n.paletteNotifications, Routes.notificationSettings, icon: LoupeIcons.notifications),
    )
    ..add(setting('rules', l10n.paletteRules, Routes.rules, icon: LoupeIcons.rules))
    ..add(
      setting(
        'encryption',
        l10n.paletteEncryption,
        Routes.encryption,
        icon: LoupeIcons.e2ee,
        keywords: const ['openpgp', 'pgp', 'keys'],
      ),
    )
    ..add(setting('advanced', l10n.paletteAdvanced, Routes.advancedSettings, icon: LoupeIcons.serverSettings))
    ..add(setting('addAccount', l10n.paletteAddAccount, Routes.addAccount, icon: LoupeIcons.add));
  for (final a in accounts) {
    items
      ..add(
        setting(
          'account.${a.id}',
          a.displayName,
          Routes.accountSettings(a.id),
          icon: LoupeIcons.contact,
          sub: l10n.paletteAccount,
        ),
      )
      ..add(
        setting(
          'folders.${a.id}',
          l10n.paletteFolders,
          Routes.manageFolders(a.id),
          icon: LoupeIcons.folder,
          sub: '${a.displayName} › ${l10n.paletteFolders}',
        ),
      );
  }

  // Recent searches.
  for (final q in container.read(recentSearchesProvider)) {
    items.add(
      PaletteItem(
        id: 'search.$q',
        title: q,
        subtitle: l10n.paletteRecentSearch,
        kind: PaletteKind.search,
        icon: LoupeIcons.recent,
        run: () => router.push<void>(Routes.search(q)),
      ),
    );
  }
  return items;
}

/// "Search mail for '[text]'": searches every mailbox (and remembers it).
PaletteItem searchMailItem(String text, ProviderContainer container, AppLocalizations l10n) {
  final q = text.trim();
  return PaletteItem(
    id: 'search.$q',
    title: l10n.paletteSearchMail(q),
    kind: PaletteKind.search,
    icon: LoupeIcons.search,
    run: () {
      unawaited(container.read(recentSearchesProvider.notifier).add(q));
      return container.read(routerProvider).push<void>(Routes.search(q));
    },
  );
}
