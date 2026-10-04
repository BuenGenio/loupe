import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

/// Placeholder; replaced by the real screen. Opens with [initialQuery] already
/// entered (e.g. "Search from this message").
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, this.initialQuery = '', this.scope = const AllMailboxesScope()});

  final String initialQuery;
  final SearchScope scope;

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Search')));
}
