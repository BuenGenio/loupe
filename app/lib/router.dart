import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_model/mail_model.dart';

import 'features/account_setup/account_setup_screen.dart';
import 'features/attachments/attachment_viewer_screen.dart';
import 'features/compose/compose_args.dart';
import 'features/compose/compose_screen.dart';
import 'features/conversation/conversation_screen.dart';
import 'features/conversation/raw_source_screen.dart';
import 'features/mailboxes/mailboxes_screen.dart';
import 'features/message_list/message_list_screen.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/search/search_screen.dart';
import 'features/search/smart_mailbox_screen.dart';
import 'features/settings/account_settings_screen.dart';
import 'features/settings/advanced_settings_screen.dart';
import 'features/settings/manage_folders_screen.dart';
import 'features/settings/notification_settings_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/settings/swipe_settings_screen.dart';
import 'settings/app_mode.dart';
import 'shared/mailbox_ref_codec.dart';

/// Paths of every screen. Navigate with `context.push(Routes.message(id))`.
abstract final class Routes {
  static const mailboxes = '/';
  static const welcome = '/welcome';
  static const settings = '/settings';
  static const addAccount = '/add-account';
  static const compose = '/compose';
  static const swipeSettings = '/settings/swipes';
  static const advancedSettings = '/settings/advanced';
  static const notificationSettings = '/settings/notifications';

  static String list(MailboxRef ref) => '/list/${MailboxRefCodec.encode(ref)}';
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
        return location == Routes.welcome || location == Routes.addAccount ? null : Routes.welcome;
      }
      return location == Routes.welcome ? Routes.mailboxes : null;
    },
    routes: [
      GoRoute(path: Routes.mailboxes, builder: (context, state) => const MailboxesScreen()),
      GoRoute(path: Routes.welcome, builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: '/list/:ref',
        builder: (context, state) =>
            MessageListScreen(mailboxRef: MailboxRefCodec.decode(state.pathParameters['ref']!)),
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
            path: 'account/:id',
            builder: (context, state) => AccountSettingsScreen(accountId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'folders',
                builder: (context, state) => ManageFoldersScreen(accountId: state.pathParameters['id']!),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: Routes.addAccount, builder: (context, state) => const AccountSetupScreen()),
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
