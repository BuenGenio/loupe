import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/theme.dart';

class LoupeApp extends ConsumerWidget {
  const LoupeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Loupe',
      debugShowCheckedModeBanner: false,
      theme: LoupeTheme.light(),
      darkTheme: LoupeTheme.dark(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
