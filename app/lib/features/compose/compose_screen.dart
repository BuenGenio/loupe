import 'package:flutter/material.dart';

import 'compose_args.dart';

/// Placeholder; replaced by the real screen.
class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key, this.args = const ComposeArgs()});

  final ComposeArgs args;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('New Message')));
}
