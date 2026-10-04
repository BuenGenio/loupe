import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/conversation/conversation_screen.dart';
import 'package:loupe/features/conversation/raw_source_screen.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:loupe/theme/theme.dart';
import 'package:loupe/data/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_mail_repository.dart';

/// Pumps a minimal app with the routes my screens use and returns its router.
///
/// `/compose` shows a probe text with the [ComposeArgs] unless
/// [composeBuilder] builds the real screen.
Future<GoRouter> pumpTestApp(
  WidgetTester tester, {
  required FakeMailRepository repository,
  String initialLocation = '/',
  Map<String, Object> prefs = const {},
  Widget Function(ComposeArgs args)? composeBuilder,
  Widget home = const Scaffold(body: Center(child: Text('home'))),
  List<RouteBase> extraRoutes = const [],
  ScrollBehavior? scrollBehavior,
  List<Override> overrides = const [],
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final sharedPrefs = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', builder: (_, _) => home),
      GoRoute(
        path: '/message/:id',
        builder: (_, s) => ConversationScreen(emailId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/source/:id',
        builder: (_, s) => RawSourceScreen(emailId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/search',
        builder: (_, s) => Scaffold(appBar: AppBar(), body: Text('search ${s.uri.queryParameters['q']}')),
      ),
      GoRoute(
        path: '/compose',
        builder: (_, s) {
          final args = s.extra is ComposeArgs ? s.extra! as ComposeArgs : const ComposeArgs();
          return composeBuilder?.call(args) ??
              Scaffold(
                appBar: AppBar(),
                body: Text('compose ${args.mode.name} ${args.sourceEmailId} ${args.to.map((a) => a.email)}'),
              );
        },
      ),
      ...extraRoutes,
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWithValue(repository),
        setupRepositoryProvider.overrideWith((ref) async => repository),
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ...overrides,
      ],
      child: MaterialApp.router(theme: LoupeTheme.light(), scrollBehavior: scrollBehavior, routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}
