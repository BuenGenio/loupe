import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import 'features/account_import/account_import_screen.dart';
import 'features/account_setup/account_setup_screen.dart';
import 'features/attachments/attachment_viewer_screen.dart';
import 'features/compose/compose_args.dart';
import 'features/compose/compose_screen.dart';
import 'features/conversation/conversation_screen.dart';
import 'features/conversation/raw_source_screen.dart';
import 'features/mailing_lists/mailing_list_screen.dart';
import 'features/message_list/message_list_screen.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/outbox/outbox_screen.dart';
import 'features/panes/mail_home.dart';
import 'features/rules/rule_editor_screen.dart';
import 'features/rules/rules_screen.dart';
import 'features/search/search_screen.dart';
import 'features/search/smart_mailbox_screen.dart';
import 'features/settings/account_settings_screen.dart';
import 'features/settings/advanced_settings_screen.dart';
import 'features/settings/identities_screen.dart';
import 'features/settings/manage_folders_screen.dart';
import 'features/settings/notification_settings_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/settings/swipe_settings_screen.dart';
import 'features/snooze/snoozed_screen.dart';
import 'settings/app_mode.dart';
import 'shared/mailbox_ref_codec.dart';

/// Paths of every screen. Navigate with `context.push(Routes.message(id))`.
abstract final class Routes {
  static const mailboxes = '/';
  static const welcome = '/welcome';
  static const settings = '/settings';
  static const addAccount = '/add-account';

  /// Accounts from Thunderbird desktop's "Export for Mobile" QR codes.
  static const importAccounts = '/import-accounts';
  static const compose = '/compose';
  static const swipeSettings = '/settings/swipes';
  static const advancedSettings = '/settings/advanced';
  static const notificationSettings = '/settings/notifications';

  /// Messages waiting to be sent (scheduled, queued, failed).
  static const outbox = '/outbox';

  /// Settings › Rules, and the rule editor.
  static const rules = '/settings/rules';
  static String editRule(String id) => '$rules/edit/${Uri.encodeComponent(id)}';

  /// A new rule, with [condition] filled in ("Make This a Rule").
  static String newRule({String condition = ''}) =>
      Uri(path: '$rules/new', queryParameters: condition.isEmpty ? null : {'q': condition}).toString();

  /// Snoozed messages of every account, with their wake times.
  static const snoozed = '/snoozed';

  static String list(MailboxRef ref) => '/list/${MailboxRefCodec.encode(ref)}';

  /// A mailing list's threads, by List-Id.
  static String mailingList(String listId) => '/mailing-list/${Uri.encodeComponent(listId)}';
  static String message(String emailId) => '/message/${Uri.encodeComponent(emailId)}';
  static String source(String emailId) => '/source/${Uri.encodeComponent(emailId)}';

  /// The attachment viewer for one part of a message.
  static String attachment(String emailId, String partId) =>
      '/attachment/${Uri.encodeComponent(emailId)}/${Uri.encodeComponent(partId)}';

  /// Search with [query] already entered; [scope] null means all mailboxes.
  static String search(String query, {MailboxRef? scope}) => Uri(
    path: '/search',
    queryParameters: {'q': query, 'scope': ?(scope == null ? null : MailboxRefCodec.encode(scope))},
  ).toString();

  /// A saved search from the Mailboxes screen.
  static String smartMailbox(String id) => '/smart/${Uri.encodeComponent(id)}';

  static String accountSettings(String accountId) => '/settings/account/${Uri.encodeComponent(accountId)}';

  /// Every server folder of an account, with subscribe switches.
  static String manageFolders(String accountId) => '${accountSettings(accountId)}/folders';

  /// The addresses an account sends from.
  static String identities(String accountId) => '${accountSettings(accountId)}/identities';
}

final routerProvider = Provider<GoRouter>((ref) {
  // The router lives as long as the app; mode changes only re-run redirects.
  final mode = ValueNotifier<AppMode>(ref.read(appModeProvider));
  ref.listen(appModeProvider, (_, next) => mode.value = next);

  final router = GoRouter(
    initialLocation: Routes.mailboxes,
    refreshListenable: mode,
    redirect: (context, state) {
      final location = state.matchedLocation;
      if (mode.value == AppMode.none) {
        const open = {Routes.welcome, Routes.addAccount, Routes.importAccounts};
        return open.contains(location) ? null : Routes.welcome;
      }
      return location == Routes.welcome ? Routes.mailboxes : null;
    },
    routes: [
      // Mailboxes on a phone; the mail panes on wider screens.
      GoRoute(path: Routes.mailboxes, builder: (context, state) => const MailHome()),
      GoRoute(path: Routes.welcome, builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: Routes.outbox, builder: (context, state) => const OutboxScreen()),
      GoRoute(path: Routes.snoozed, builder: (context, state) => const SnoozedScreen()),
      GoRoute(
        path: '/list/:ref',
        builder: (context, state) =>
            MessageListScreen(mailboxRef: MailboxRefCodec.decode(state.pathParameters['ref']!)),
      ),
      GoRoute(
        path: '/mailing-list/:id',
        builder: (context, state) => MailingListScreen(listId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/message/:id',
        builder: (context, state) => ConversationScreen(emailId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/source/:id',
        builder: (context, state) => RawSourceScreen(emailId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/attachment/:id/:part',
        builder: (context, state) =>
            AttachmentViewerScreen(emailId: state.pathParameters['id']!, partId: state.pathParameters['part']!),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final scope = state.uri.queryParameters['scope'];
          return SearchScreen(
            initialQuery: state.uri.queryParameters['q'] ?? '',
            scope: scope == null ? const AllMailboxesScope() : MailboxScope(MailboxRefCodec.decode(scope)),
          );
        },
      ),
      GoRoute(
        path: '/smart/:id',
        builder: (context, state) => SmartMailboxScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(path: 'swipes', builder: (context, state) => const SwipeSettingsScreen()),
          GoRoute(path: 'advanced', builder: (context, state) => const AdvancedSettingsScreen()),
          GoRoute(path: 'notifications', builder: (context, state) => const NotificationSettingsScreen()),
          GoRoute(
            path: 'rules',
            builder: (context, state) => const RulesScreen(),
            routes: [
              GoRoute(
                path: 'new',
                pageBuilder: (context, state) => MaterialPage(
                  fullscreenDialog: true,
                  child: RuleEditorScreen(initialCondition: state.uri.queryParameters['q'] ?? ''),
                ),
              ),
              GoRoute(
                path: 'edit/:id',
                pageBuilder: (context, state) =>
                    MaterialPage(fullscreenDialog: true, child: RuleEditorScreen(ruleId: state.pathParameters['id']!)),
              ),
            ],
          ),
          GoRoute(
            path: 'account/:id',
            builder: (context, state) => AccountSettingsScreen(accountId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'folders',
                builder: (context, state) => ManageFoldersScreen(accountId: state.pathParameters['id']!),
              ),
              GoRoute(
                path: 'identities',
                builder: (context, state) => IdentitiesScreen(accountId: state.pathParameters['id']!),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: Routes.addAccount, builder: (context, state) => const AccountSetupScreen()),
      GoRoute(path: Routes.importAccounts, builder: (context, state) => const AccountImportScreen()),
      GoRoute(
        path: Routes.compose,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: ComposeScreen(args: state.extra is ComposeArgs ? state.extra! as ComposeArgs : const ComposeArgs()),
        ),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    mode.dispose();
  });
  return router;
});
