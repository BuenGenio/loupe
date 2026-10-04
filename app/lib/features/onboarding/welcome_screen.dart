import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/app_mode.dart';
import '../../theme/theme.dart';

/// First launch: the app name, a one-line pitch, and two ways in.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..forward();

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  Future<void> _tryDemo() => ref.read(appModeProvider.notifier).set(AppMode.demo);

  Future<void> _addAccount() async {
    // Real accounts aren't wired up yet: offer the demo instead.
    final useDemo = await showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      builder: (context) => const _ComingSoonSheet(),
    );
    if (useDemo ?? false) await _tryDemo();
  }

  Widget _stagger(double start, Widget child) {
    final animation = CurvedAnimation(
      parent: _intro,
      curve: Interval(start, (start + 0.5).clamp(0, 1), curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.08), end: Offset.zero).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Scaffold(
      body: SafeArea(
        // Spacers keep it airy on phones; short screens (landscape) scroll
        // with fixed gaps instead.
        child: LayoutBuilder(
          builder: (context, viewport) {
            final short = viewport.maxHeight < 720;
            Widget gap(int flex, double height) => short ? SizedBox(height: height) : Spacer(flex: flex);
            final column = Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: short ? MainAxisSize.min : MainAxisSize.max,
                    children: [
                      gap(3, 32),
                      _stagger(
                        0,
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: colors.unreadDot.withValues(alpha: 0.28),
                                blurRadius: 28,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icon/icon_rounded.png',
                            width: 104,
                            height: 104,
                            semanticLabel: 'Loupe',
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      _stagger(0.1, Text('Loupe', style: styles.largeTitle.copyWith(fontSize: 40))),
                      const SizedBox(height: 10),
                      _stagger(
                        0.18,
                        Text(
                          'Mail that’s simple on the surface\nand powerful underneath.',
                          textAlign: TextAlign.center,
                          style: styles.body.copyWith(color: colors.secondaryText, height: 1.35),
                        ),
                      ),
                      gap(2, 28),
                      _stagger(
                        0.3,
                        Column(
                          children: const [
                            _Feature(
                              icon: CupertinoIcons.tray_2,
                              title: 'Every account, one calm inbox',
                              text: 'Gmail, Outlook, iCloud, Fastmail and any IMAP server.',
                            ),
                            _Feature(
                              icon: CupertinoIcons.search,
                              title: 'Search that finds it',
                              text: 'Instant results on your phone, then the server’s.',
                            ),
                            _Feature(
                              icon: CupertinoIcons.lock_shield,
                              title: 'Private by design',
                              text: 'No tracking. Remote images stay blocked until you say so.',
                            ),
                          ],
                        ),
                      ),
                      gap(3, 28),
                      _stagger(
                        0.45,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton(
                              onPressed: _addAccount,
                              style: FilledButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              child: const Text('Add Account'),
                            ),
                            const SizedBox(height: 6),
                            CupertinoButton(onPressed: _tryDemo, child: const Text('Try with demo mail')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
            return short ? SingleChildScrollView(child: column) : column;
          },
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: colors.unreadDot),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: styles.subject.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(text, style: styles.footnote.copyWith(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComingSoonSheet extends StatelessWidget {
  const _ComingSoonSheet();

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 4, 28, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(CupertinoIcons.envelope_open, size: 44, color: colors.unreadDot),
            const SizedBox(height: 14),
            Text(
              'Real accounts are on their way',
              style: styles.navTitle.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'This early build doesn’t connect to mail servers yet. Explore Loupe with a demo mailbox in the '
              'meantime: everything works, and nothing leaves your phone.',
              style: styles.subject.copyWith(color: colors.secondaryText, height: 1.35),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              child: const Text('Try Demo Mail'),
            ),
            CupertinoButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Not Now')),
          ],
        ),
      ),
    );
  }
}
