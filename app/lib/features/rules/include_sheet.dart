import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../theme/theme.dart';
import 'rule_format.dart';

/// Offers to let the server's active script (somebody else's, e.g. SOGo's
/// filters) run Loupe's rules too, showing the exact lines first. Never
/// replaces that script. Resolves to true if the change was made.
Future<bool> showIncludeSheet(BuildContext context, {required String accountId, required String accountName}) async {
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _IncludeSheet(accountId: accountId, accountName: accountName),
  );
  return done ?? false;
}

class _IncludeSheet extends ConsumerStatefulWidget {
  const _IncludeSheet({required this.accountId, required this.accountName});

  final String accountId;
  final String accountName;

  @override
  ConsumerState<_IncludeSheet> createState() => _IncludeSheetState();
}

class _IncludeSheetState extends ConsumerState<_IncludeSheet> {
  late final Future<SieveIncludeProposal?> _proposal = ref
      .read(repositoryProvider)
      .rules
      .proposeInclude(widget.accountId);
  bool _whole = false;
  bool _busy = false;
  String? _error;

  Future<void> _apply(SieveIncludeProposal proposal) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(repositoryProvider).rules.applyInclude(proposal);
      ref.invalidate(serverRulesStatusProvider(widget.accountId));
      if (mounted) Navigator.of(context).pop(true);
    } on MailException catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (context, controller) => FutureBuilder<SieveIncludeProposal?>(
        future: _proposal,
        builder: (context, snapshot) {
          final proposal = snapshot.data;
          final Widget body;
          if (snapshot.connectionState != ConnectionState.done) {
            body = const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CupertinoActivityIndicator()),
            );
          } else if (snapshot.hasError) {
            final e = snapshot.error;
            body = Text(e is MailException ? e.message : l10n.rulesServerUnreachable, style: styles.body);
          } else if (proposal == null) {
            body = Text(l10n.rulesIncludeAlreadyOn(widget.accountName), style: styles.body);
          } else {
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.rulesIncludeExplanation(proposal.scriptName, widget.accountName), style: styles.body),
                const SizedBox(height: 12),
                CodeBox(proposal.addedLines.join('\n'), highlightLines: proposal.addedLines.toSet()),
                Align(
                  alignment: Alignment.centerLeft,
                  child: NoticeButton(
                    _whole ? l10n.rulesHideWholeScript : l10n.rulesShowWholeScript,
                    onPressed: () => setState(() => _whole = !_whole),
                  ),
                ),
                if (_whole) CodeBox(proposal.after, highlightLines: proposal.addedLines.toSet()),
                const SizedBox(height: 8),
                Text(l10n.rulesIncludeFootnote(proposal.scriptName), style: styles.footnote),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: styles.footnote.copyWith(color: colors.destructive)),
                ],
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 8),
                child: Row(
                  children: [
                    Expanded(child: Text(l10n.rulesIncludeTitle, style: styles.navTitle)),
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(proposal == null ? l10n.commonDone : l10n.rulesIncludeLeaveOff),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  children: [body],
                ),
              ),
              if (proposal != null)
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                    child: CupertinoButton.filled(
                      onPressed: _busy ? null : () => _apply(proposal),
                      child: _busy
                          ? const CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                              l10n.rulesIncludeAdd(proposal.scriptName),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
