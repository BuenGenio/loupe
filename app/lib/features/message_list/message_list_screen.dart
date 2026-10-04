import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

/// Placeholder; replaced by the real screen.
class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key, required this.mailboxRef});

  final MailboxRef mailboxRef;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Inbox')));
}
