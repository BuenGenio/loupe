// Marketing screenshots of Loupe for the website (site/src/assets/screenshots).
//
// Not part of CI: tool/ci/test.sh runs only test/ directories. Run with
// tool/screenshots.sh, or one shot with
// `flutter test screenshots/ --plain-name inbox`.
//
// Widget tests draw text with a box font, so this loads real fonts first:
// Roboto (what Android shows), the Fluent icons, a monospace font, and
// symbol fallbacks. Text with no font family at all can't be redirected (the
// test engine's fallback is fixed), so the app is pumped as [_ShotApp], a
// copy of LoupeApp whose themes name Roboto explicitly.

// A test outside test/: the analyzer doesn't know, so it flags the test APIs.
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart' show CupertinoSearchTextField;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loupe/data/repositories.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/compose/compose_args.dart';
import 'package:loupe/features/keyboard/app_shortcuts.dart';
import 'package:loupe/features/notifications/app_icon_badge.dart';
import 'package:loupe/features/notifications/notifications_coordinator.dart';
import 'package:loupe/features/openpgp/openpgp_providers.dart';
import 'package:loupe/providers.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_mode.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:loupe/settings/ui_state.dart';
import 'package:loupe/theme/theme.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Where the PNGs go, relative to app/.
const _outDir = '../site/src/assets/screenshots';

const _phone = Size(390, 844);
const _tablet = Size(1280, 800);

/// System bar insets left plain at the top and bottom of every frame (an
/// Android status bar and gesture bar), so the site's device frame can draw
/// its own status bar there.
const _phoneInsets = (top: 44.0, bottom: 24.0);
const _tabletInsets = (top: 28.0, bottom: 20.0);

/// The demo's "now": today at 16:00. Not a fixed date, because list dates
/// compare with DateTime.now(), which a test can't move; the time is fixed
/// so the inbox always has the same shape.
final _now = () {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, 16);
}();

/// Runs [body] with `clock.now()` at [_now], advancing with the test's fake
/// time (as test/helpers.dart's atTestNow does with its fixed date).
Future<T> _atNow<T>(Future<T> Function() body) {
  final outer = clock;
  final offset = _now.difference(outer.now());
  return withClock(Clock(() => outer.now().add(offset)), body);
}

const _sans = 'Roboto';

/// Glyphs Roboto lacks (✓, arrows) come from these, as Android's fallback
/// fonts would supply them.
const _fallback = ['Noto Sans Symbols 2', 'DejaVu Sans', 'Noto Color Emoji'];

// Fonts ------------------------------------------------------------------------

Future<ByteData> _file(String path) async => ByteData.sublistView(await File(path).readAsBytes());

Future<void> _loadFamily(String family, Iterable<String> paths) async {
  final loader = FontLoader(family);
  for (final p in paths) {
    if (File(p).existsSync()) loader.addFont(_file(p));
  }
  await loader.load();
}

String _firstExisting(List<String> candidates) =>
    candidates.firstWhere((p) => File(p).existsSync(), orElse: () => throw StateError('none of $candidates exists'));

Future<void> _loadFonts() async {
  // The app's bundled fonts: MaterialIcons and the Fluent icon families
  // (packages/fluentui_system_icons/FluentSystemIcons-Regular, -Filled).
  final manifest = jsonDecode(await rootBundle.loadString('FontManifest.json')) as List<dynamic>;
  for (final family in manifest.cast<Map<String, dynamic>>()) {
    final loader = FontLoader(family['family'] as String);
    for (final font in (family['fonts'] as List).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }

  // Roboto from the Flutter SDK, under the names Material and Cupertino ask for.
  final flutterRoot = Platform.environment['FLUTTER_ROOT'] ?? '${Platform.environment['HOME']}/development/flutter';
  final materialFonts = Directory('$flutterRoot/bin/cache/artifacts/material_fonts');
  final roboto = [
    for (final f in materialFonts.listSync().whereType<File>())
      if (RegExp(r'/Roboto-\w+\.ttf$').hasMatch(f.path)) f.path,
  ];
  if (roboto.isEmpty) throw StateError('Roboto not found in ${materialFonts.path}');
  for (final name in [_sans, 'CupertinoSystemText', 'CupertinoSystemDisplay', '.SF UI Text', '.SF UI Display']) {
    await _loadFamily(name, roboto);
  }

  // Monospace (Plain/Mono view, patches, Sieve): Noto Sans Mono, the
  // successor of Android's Droid Sans Mono; DejaVu Sans Mono as the
  // fallbacks the reader names, for symbols.
  const fonts = '/usr/share/fonts/truetype';
  final mono = [
    _firstExisting(['$fonts/noto/NotoSansMono-Regular.ttf', '$fonts/dejavu/DejaVuSansMono.ttf']),
    _firstExisting(['$fonts/noto/NotoSansMono-Bold.ttf', '$fonts/dejavu/DejaVuSansMono-Bold.ttf']),
  ];
  await _loadFamily('monospace', mono);
  final dejavuMono = ['$fonts/dejavu/DejaVuSansMono.ttf', '$fonts/dejavu/DejaVuSansMono-Bold.ttf'];
  for (final name in ['Menlo', 'Roboto Mono', 'Courier New', 'Courier']) {
    await _loadFamily(name, dejavuMono);
  }

  await _loadFamily('Noto Sans Symbols 2', ['$fonts/noto/NotoSansSymbols2-Regular.ttf']);
  await _loadFamily('DejaVu Sans', ['$fonts/dejavu/DejaVuSans.ttf', '$fonts/dejavu/DejaVuSans-Bold.ttf']);
  await _loadFamily('Noto Color Emoji', ['$fonts/noto/NotoColorEmoji.ttf']);
}

/// [style] in Roboto (unless it names a family, like monospace), with the
/// symbol fallbacks.
TextStyle? _font(TextStyle? style) {
  if (style == null) return null;
  final family = style.fontFamily;
  final keep = family != null && !family.startsWith('CupertinoSystem') && !family.startsWith('.SF');
  return style.copyWith(
    fontFamily: keep ? family : _sans,
    fontFamilyFallback: [...?style.fontFamilyFallback, ..._fallback],
  );
}

/// [theme] with every text style naming Roboto.
ThemeData _withFonts(ThemeData theme) {
  final cupertino = theme.cupertinoOverrideTheme;
  final t = cupertino?.textTheme;
  final loupe = theme.extension<LoupeTextStyles>()!;
  return theme.copyWith(
    textTheme: theme.textTheme.apply(fontFamily: _sans, fontFamilyFallback: _fallback),
    primaryTextTheme: theme.primaryTextTheme.apply(fontFamily: _sans, fontFamilyFallback: _fallback),
    appBarTheme: theme.appBarTheme.copyWith(
      titleTextStyle: _font(theme.appBarTheme.titleTextStyle),
      toolbarTextStyle: _font(theme.appBarTheme.toolbarTextStyle),
    ),
    snackBarTheme: theme.snackBarTheme.copyWith(contentTextStyle: _font(theme.snackBarTheme.contentTextStyle)),
    inputDecorationTheme: theme.inputDecorationTheme.copyWith(hintStyle: _font(theme.inputDecorationTheme.hintStyle)),
    cupertinoOverrideTheme: cupertino?.copyWith(
      textTheme: t?.copyWith(
        textStyle: _font(t.textStyle),
        actionTextStyle: _font(t.actionTextStyle),
        actionSmallTextStyle: _font(t.actionSmallTextStyle),
        tabLabelTextStyle: _font(t.tabLabelTextStyle),
        navTitleTextStyle: _font(t.navTitleTextStyle),
        navLargeTitleTextStyle: _font(t.navLargeTitleTextStyle),
        navActionTextStyle: _font(t.navActionTextStyle),
        pickerTextStyle: _font(t.pickerTextStyle),
        dateTimePickerTextStyle: _font(t.dateTimePickerTextStyle),
      ),
    ),
    extensions: [
      for (final e in theme.extensions.values)
        if (e is! LoupeTextStyles) e,
      LoupeTextStyles(
        largeTitle: _font(loupe.largeTitle)!,
        navTitle: _font(loupe.navTitle)!,
        body: _font(loupe.body)!,
        sender: _font(loupe.sender)!,
        senderUnread: _font(loupe.senderUnread)!,
        subject: _font(loupe.subject)!,
        preview: _font(loupe.preview)!,
        date: _font(loupe.date)!,
        footnote: _font(loupe.footnote)!,
        caption: _font(loupe.caption)!,
        sectionHeader: _font(loupe.sectionHeader)!,
      ),
    ],
  );
}

// The app ----------------------------------------------------------------------

/// LoupeApp (lib/app.dart) with [_withFonts] themes. Its private system-bar
/// and live-gate wrappers are left out: in demo mode they draw nothing.
class _ShotApp extends ConsumerWidget {
  const _ShotApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    return MaterialApp.router(
      title: 'Loupe',
      debugShowCheckedModeBanner: false,
      theme: _withFonts(LoupeTheme.light(density: settings.density)),
      darkTheme: _withFonts(LoupeTheme.dark(density: settings.density)),
      themeMode: settings.themeMode,
      scrollBehavior: const LoupeScrollBehavior(),
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => AppIconBadgeUpdater(
        child: NotificationsCoordinator(child: AppShortcuts(child: child ?? const SizedBox.shrink())),
      ),
    );
  }
}

/// Pumps the demo app like test/helpers.dart's pumpLoupe, at [size] with
/// system bar insets.
Future<DemoMailRepository> _pumpApp(
  WidgetTester tester, {
  Size size = _phone,
  double pixelRatio = 3,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
}) async {
  final insets = size.width > size.height ? _tabletInsets : _phoneInsets;
  final padding = FakeViewPadding(top: insets.top * pixelRatio, bottom: insets.bottom * pixelRatio);
  tester.view
    ..physicalSize = size * pixelRatio
    ..devicePixelRatio = pixelRatio
    ..padding = padding
    ..viewPadding = padding;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({AppModeController.key: AppMode.demo.name, ...prefs});
  final sharedPreferences = await SharedPreferences.getInstance();
  final repo = DemoMailRepository.instant(clock: () => _now);
  addTearDown(repo.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        demoRepositoryProvider.overrideWithValue(repo),
        liveRepositoryProvider.overrideWith((ref) async => repo),
        repositoryProvider.overrideWith(repositoryForMode),
        // OpenPGP and S/MIME work inline instead of in an isolate.
        pgpRunnerProvider.overrideWithValue(<T>(T Function() work) async => work()),
        ...overrides,
      ],
      child: const _ShotApp(),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

ProviderContainer _container(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(_ShotApp)));

GoRouter _router(WidgetTester tester) => _container(tester).read(routerProvider);

Future<void> _go(WidgetTester tester, String location, {Object? extra}) async {
  unawaited(_router(tester).push<void>(location, extra: extra));
  await tester.pumpAndSettle();
}

/// Decodes every image on screen for real (decoding needs real async), then
/// lets the frames land.
Future<void> _resolveImages(WidgetTester tester) async {
  for (var round = 0; round < 4; round++) {
    final images = find.byType(Image, skipOffstage: false).evaluate().toList();
    await tester.runAsync(() async {
      for (final e in images) {
        try {
          await precacheImage((e.widget as Image).image, e);
        } on Object {
          // A broken image shows as broken; the screenshot reveals it.
        }
      }
      await Future<void>.delayed(const Duration(milliseconds: 50));
    });
    await tester.pumpAndSettle();
  }
}

Future<void> _capture(WidgetTester tester, String slug) async {
  await _resolveImages(tester);
  final view = tester.binding.renderViews.first;
  final layer = view.debugLayer! as OffsetLayer;
  await tester.runAsync(() async {
    final image = await layer.toImage(view.paintBounds);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final out = File('$_outDir/$slug.png');
    out.parent.createSync(recursive: true);
    out.writeAsBytesSync(bytes!.buffer.asUint8List());
    // ignore: avoid_print
    print('screenshot ${out.path} ${image.width}x${image.height}');
  });
}

/// One screen in both themes: pumps the app (a phone unless told otherwise),
/// runs [body] to get to the screen, and saves it as [slug].png (light) and
/// [slug]-dark.png (dark), from the same state so the two swap one for one.
void _shot(
  String slug,
  Future<void> Function(WidgetTester tester, DemoMailRepository repo) body, {
  Size size = _phone,
  double pixelRatio = 3,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
}) {
  for (final dark in [false, true]) {
    final name = dark ? '$slug-dark' : slug;
    testWidgets(name, (tester) async {
      await _atNow(() async {
        final repo = await _pumpApp(
          tester,
          size: size,
          pixelRatio: pixelRatio,
          prefs: {'settings.themeMode': dark ? 'dark' : 'light', ...prefs},
          overrides: overrides,
        );
        await body(tester, repo);
        await _capture(tester, name);
        // Let SnackBars and other timers run out.
        await tester.pump(const Duration(seconds: 10));
      });
    });
  }
}

// Demo mail --------------------------------------------------------------------

const _allInboxes = VirtualMailboxRef(VirtualMailbox.allInboxes);
const _kestrel = 'dev.lists.example.org';

Future<EmailSummary> _find(DemoMailRepository repo, bool Function(EmailSummary e) test) async {
  final rows = await repo.watchList(_allInboxes, threaded: false, limit: 1000).first;
  return rows.map((t) => t.latest).firstWhere(test);
}

Future<String> _bySubject(DemoMailRepository repo, String subject) async =>
    (await _find(repo, (e) => e.subject == subject)).id;

/// Scrolls [finder] into view, [alignment] down the viewport.
Future<void> _reveal(WidgetTester tester, Finder finder, {double alignment = 0.5}) async {
  await tester.scrollUntilVisible(finder, 300, scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
  await Scrollable.ensureVisible(tester.element(finder), alignment: alignment);
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

// The shots --------------------------------------------------------------------
//
// In the order of site/src/data/screenshots.json, which describes each one.

const _hike = 'Photos from Sunday’s hike';
const _trailhead = 'Members: 20% off layers + the autumn layering guide';

void main() {
  setUpAll(() async {
    await _loadFonts();
    ReadableMessageView.debugSynchronous = true;
  });

  _shot('inbox', (tester, repo) async {
    await _go(tester, Routes.list(_allInboxes));
  });

  _shot('newsletter', (tester, repo) async {
    await _go(tester, Routes.message(await _bySubject(repo, _trailhead)));
  });

  _shot('search', (tester, repo) async {
    await _go(tester, Routes.search('f:(dana or ben) -is:read'));
  });

  // For the site's hero: an expression being typed, with its chips, the
  // completions for the word under the cursor, and the results below.
  _shot('search-hero', (tester, repo) async {
    await _go(tester, Routes.search(''));
    await tester.enterText(find.byType(CupertinoSearchTextField), 'f:(dana or ben) is:unread a');
    // Past the search's debounce.
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  });

  _shot('phishing', (tester, repo) async {
    await _go(tester, Routes.message(await _bySubject(repo, 'Action needed: your mailbox password expires today')));
    await _tap(tester, find.text('Why?'));
  });

  _shot('tablet', size: _tablet, pixelRatio: 2, (tester, repo) async {
    await _tap(tester, find.text(_hike));
  });

  _shot('subscriptions', (tester, repo) async {
    await _go(tester, Routes.subscriptions);
  });

  _shot('mailboxes', (tester, repo) async {
    final smart = _container(tester).read(smartMailboxesProvider.notifier);
    for (final (name, query) in [
      ('Receipts & Invoices', 's:(receipt or invoice) or fi:pdf'),
      ('Big Attachments', 'larger:5M'),
    ]) {
      await smart.add(name, query);
      // Ids come from the clock.
      await tester.pump(const Duration(seconds: 1));
    }
    await tester.pumpAndSettle();
    // Fold the accounts so the Smart Mailboxes come into view.
    for (final account in ['Personal', 'Work', 'Fastmail']) {
      final row = find.ancestor(of: find.text(account), matching: find.byType(Row)).first;
      await _tap(tester, find.descendant(of: row, matching: find.byType(Icon)).last);
    }
    // Past the search field, to the top of the first group.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -60));
    await tester.pumpAndSettle();
  });

  _shot('invitation', (tester, repo) async {
    await _go(tester, Routes.message(await _bySubject(repo, 'SOW phase 2 – pricing review')));
  });

  _shot('openpgp', (tester, repo) async {
    final dana = await _find(repo, (e) => e.sender?.email == 'dana.okafor@northwind.example' && e.subject == '...');
    await _go(tester, Routes.message(dana.id));
    await _tap(tester, find.byKey(ValueKey('pgp-status-${dana.id}')));
  });

  _shot('compose', (tester, repo) async {
    await _go(
      tester,
      Routes.compose,
      extra: const ComposeArgs(
        to: [
          EmailAddress('jordan.lee@example.com', 'Jordan Lee'),
          EmailAddress('priya.nair@example.org', 'Priya Nair'),
        ],
        subject: 'Lisbon in November',
      ),
    );
    await tester.enterText(
      find.byKey(const Key('compose-body')),
      'Hi both,\n\nFlights are booked: we land Thursday at 10:40 and leave Monday evening. '
      'I found a flat in Alfama with a terrace, two minutes from the tram.\n\n'
      'Shall we do the Sintra day trip on Saturday?\n\nSam',
    );
    await tester.pumpAndSettle();
    // Shows the From line (the identity picker).
    await _tap(tester, find.byKey(const Key('compose-ccbcc-from')));
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  });

  _shot('rules', (tester, repo) async {
    await _go(tester, Routes.newRule(condition: 'from:@brandt.example'));
    await _tap(tester, find.text('Accounts'));
    await _tap(tester, find.text('Fastmail'));
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _reveal(tester, find.text('Add Action'));
    await _tap(tester, find.text('Add Action'));
    await _tap(tester, find.text('Mark as Read'));
    await _reveal(tester, find.text('Server'));
    await _tap(tester, find.text('Server'));
    await _reveal(tester, find.text('Show Script'));
    await _tap(tester, find.text('Show Script'));
    await _reveal(tester, find.text('WHEN A NEW MESSAGE MATCHES'), alignment: 0.1);
  });

  // The list marked technical: plain text in a monospaced font, the patch as a diff.
  _shot(
    'patch',
    prefs: {
      'reader.technicalLists': [_kestrel],
    },
    (tester, repo) async {
      final series = (await repo.watchListThreads(_kestrel).first).first;
      final conversation = await repo.watchConversation(series.first.id).first;
      final patch = conversation.firstWhere((m) => m.subject.startsWith('[PATCH v2 2/3]'));
      await _go(tester, Routes.message(patch.id));
      await _reveal(tester, find.textContaining('v2: free the cache', findRichText: true).first, alignment: 0.14);
    },
  );
}
