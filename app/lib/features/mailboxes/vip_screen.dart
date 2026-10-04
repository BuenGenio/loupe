import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../providers.dart';
import '../../shared/avatar.dart';
import '../../shared/grouped_list.dart';
import '../../shared/sheets.dart';
import '../../theme/theme.dart';
import '../../theme/loupe_icons.dart';

/// The VIP list: people whose mail gets a star and its own mailbox.
class VipScreen extends ConsumerStatefulWidget {
  const VipScreen({super.key});

  @override
  ConsumerState<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends ConsumerState<VipScreen> {
  /// Display names of known correspondents, for nicer rows.
  final _names = <String, EmailAddress>{};

  @override
  void initState() {
    super.initState();
    unawaited(_loadNames());
  }

  Future<void> _loadNames() async {
    final people = await ref.read(repositoryProvider).suggestAddresses('', limit: 200);
    final vips = ref.read(vipAddressesProvider).value ?? const <String>{};
    final named = <String, EmailAddress>{for (final p in people) p.email.toLowerCase(): p};
    for (final v in vips) {
      if (named.containsKey(v)) continue;
      final hits = await ref.read(repositoryProvider).suggestAddresses(v, limit: 1);
      if (hits.isNotEmpty) named[v] = hits.first;
    }
    if (mounted) setState(() => _names.addAll(named));
  }

  Future<void> _add() async {
    final email = await showTextPrompt(
      context,
      title: 'Add VIP',
      message: 'Mail from this address gets a star and appears in the VIP mailbox.',
      placeholder: 'name@example.com',
      confirm: 'Add',
    );
    if (email == null || !email.contains('@')) return;
    await ref.read(repositoryProvider).setVip(email.toLowerCase(), vip: true);
    unawaited(_loadNames());
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final vips = (ref.watch(vipAddressesProvider).value ?? const <String>{}).toList()..sort();
    return GroupedPage(
      title: 'VIP',
      children: [
        InsetGroup(
          footer: 'You can also tap a sender’s name in a message and turn on VIP.',
          separatorIndent: 62,
          children: [
            for (final email in vips)
              GroupedRow(
                key: ValueKey(email),
                leading: SenderAvatar(address: _names[email] ?? EmailAddress(email), size: 32),
                title: _names[email]?.displayName ?? email,
                subtitle: _names[email] == null ? null : email,
                chevron: false,
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(36, 36),
                  onPressed: () => ref.read(repositoryProvider).setVip(email, vip: false),
                  child: Icon(LoupeIcons.remove, color: colors.destructive, semanticLabel: 'Remove'),
                ),
              ),
            GroupedRow(
              leading: Icon(LoupeIcons.add, color: colors.unreadDot, size: 26),
              title: 'Add VIP…',
              titleStyle: LoupeTextStyles.of(context).body.copyWith(color: colors.unreadDot),
              chevron: false,
              onTap: _add,
            ),
          ],
        ),
      ],
    );
  }
}
