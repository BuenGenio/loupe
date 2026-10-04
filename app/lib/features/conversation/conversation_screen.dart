import 'package:flutter/material.dart';

/// Placeholder; replaced by the real screen.
class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key, required this.emailId});

  /// Any message of the conversation; the screen scrolls to it.
  final String emailId;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Message')));
}
