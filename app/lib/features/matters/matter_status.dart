import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../router.dart';
import '../../shared/format.dart';
import '../../shared/grouped_list.dart';
import '../../theme/loupe_icons.dart';
import '../../theme/theme.dart';
import '../ai/ai_providers.dart';
import '../compose/compose_text.dart';
import '../conversation/mail_streams.dart';
import '../openpgp/content_loader.dart';

/// The last status task of each matter, by matter id, while the app runs:
/// with [AiService.cached] it gives the status back when the matter is
/// opened again, without asking the model. The results themselves stay in
/// the [AiLedger], so clearing them there clears them here too.
final matterStatusTasksProvider = Provider<Map<String, MatterStatusTask>>((ref) => {});

/// How many of the newest messages a status reads.
const _statusMessages = 12;

/// Where Things Stand: a few statements on a matter's latest position, each
/// linked to the message it quotes. Written by Private AI only on a tap, and
/// again only when the matter's messages changed; hidden when Private AI or
/// this feature is off. A provider that isn't on the phone never gets mail
/// of accounts that keep theirs local, nor encrypted mail, and the card
/// says so.
class MatterStatusCard extends ConsumerStatefulWidget {
  const MatterStatusCard({super.key, required this.matter, required this.messages});

  final Matter matter;

  /// The matter's messages, oldest first.
  final List<EmailSummary> messages;

  @override
  ConsumerState<MatterStatusCard> createState() => _MatterStatusCardState();
}

class _MatterStatusCardState extends ConsumerState<MatterStatusCard> {
  bool _running = false;
  AiFailure<MatterStatus>? _failure;

  /// The messages the provider may read, newest first, at most [_statusMessages].
  List<EmailSummary> _eligible(AiService service, Set<String> localOnly) {
    final onPhone = service.provider.location == ProviderLocation.onThisPhone;
    return [
      for (final m in widget.messages.reversed)
        if (onPhone || (!localOnly.contains(m.accountId) && !m.isEncrypted)) m,
    ].take(_statusMessages).toList();
  }

  Future<void> _write(AiService service, List<EmailSummary> eligible) async {
    setState(() {
      _running = true;
      _failure = null;
    });
    final loader = ref.read(contentLoaderProvider);
    final own = ownAddresses(ref.read(accountsProvider).value ?? const []);
    final language = Localizations.localeOf(context).toLanguageTag();
    final members = widget.matter.members;
    final inputs = <MatterStatusMessage>[];
    for (final m in eligible) {
      var text = m.preview;
      try {
        final content = await loader.loadContent(m.id);
        text = content.text ?? (content.html == null ? m.preview : ComposeText.htmlToText(content.html!));
      } on Object {
        // Offline or unreadable: its preview stands in.
      }
      final sender = m.sender;
      final member = members.indexWhere((x) => x.includes(m));
      inputs.add(
        MatterStatusMessage(
          emailId: m.id,
          conversation: 'c${member + 1}',
          from: sender == null ? '' : '${sender.displayName} <${sender.email}>',
          fromMe: sender != null && own.contains(sender.email.toLowerCase()),
          date: m.receivedAt,
          subject: m.subject,
          text: text,
        ),
      );
    }
    final task = MatterStatusTask(matterName: widget.matter.name, messages: inputs, language: language);
    ref.read(matterStatusTasksProvider)[widget.matter.id] = task;
    final run = await service.run(task);
    if (!mounted) return;
    setState(() {
      _running = false;
      _failure = run is AiFailure<MatterStatus> ? run : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(aiServiceForProvider((AiFeature.matters, null)));
    if (service == null || widget.messages.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final onPhone = service.provider.location == ProviderLocation.onThisPhone;
    final localOnly = onPhone ? const <String>{} : ref.watch(aiLocalOnlyAccountsProvider);
    final eligible = _eligible(service, localOnly);
    final accounts = ref.watch(accountsProvider).value ?? const <MailAccount>[];
    final keptLocal = [
      for (final a in accounts)
        if (localOnly.contains(a.id) && widget.messages.any((m) => m.accountId == a.id)) a.displayName,
    ];
    final encryptedKept = !onPhone && widget.messages.any((m) => m.isEncrypted && !localOnly.contains(m.accountId));

    final task = ref.watch(matterStatusTasksProvider)[widget.matter.id];
    final cached = task == null ? null : service.cached(task);
    final upToDate = task != null && _sameIds(task.messages.map((m) => m.emailId), eligible.map((m) => m.id));

    final notes = [
      if (keptLocal.isNotEmpty) l10n.mattersStatusLocalOnly(keptLocal.join(', ')),
      if (encryptedKept) l10n.mattersStatusEncrypted,
    ];
    Widget header({VoidCallback? onTap, String? hint}) => GroupedRow(
      key: const Key('matter-status'),
      leading: Icon(LoupeIcons.ask, color: colors.unreadDot),
      title: l10n.mattersStatusTitle,
      titleStyle: styles.body.copyWith(fontWeight: FontWeight.w600),
      subtitle: hint,
      onTap: onTap,
      chevron: onTap != null,
    );

    final List<Widget> body;
    if (eligible.isEmpty) {
      body = [header(hint: l10n.mattersStatusNoInput)];
    } else if (_running) {
      body = [
        header(),
        _Padded(
          child: Row(
            children: [
              const CupertinoActivityIndicator(),
              const SizedBox(width: 10),
              Expanded(child: Text(l10n.mattersStatusWorking, style: styles.body)),
            ],
          ),
        ),
      ];
    } else if (_failure case final failure? when cached == null) {
      body = [
        header(),
        _Padded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.mattersStatusFailed, style: styles.body),
              if (failure.message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(failure.message, style: styles.footnote),
                ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size(44, 36),
                onPressed: () => _write(service, eligible),
                child: Text(l10n.commonRetry),
              ),
            ],
          ),
        ),
      ];
    } else if (cached == null) {
      body = [header(hint: l10n.mattersStatusHint, onTap: () => _write(service, eligible))];
    } else {
      final status = cached.value;
      final byId = {for (final m in widget.messages) m.id: m};
      final record = cached.record;
      body = [
        header(),
        if (!upToDate)
          _Padded(
            child: Row(
              children: [
                Expanded(child: Text(l10n.mattersStatusOutdated, style: styles.footnote)),
                CupertinoButton(
                  padding: const EdgeInsets.only(left: 8),
                  minimumSize: const Size(44, 32),
                  onPressed: () => _write(service, eligible),
                  child: Text(l10n.mattersStatusUpdate),
                ),
              ],
            ),
          ),
        for (final s in status.statements) _Statement(statement: s, source: byId[s.emailId]),
        _Padded(
          child: Text(
            [
              record.providerId == 'demo'
                  ? l10n.mattersStatusDemoNote
                  : l10n.mattersStatusProvider([record.providerId, ?record.model].join(', ')),
              if (status.partial) l10n.mattersStatusPartial,
            ].join(' '),
            style: styles.footnote,
          ),
        ),
      ];
    }
    return InsetGroup(separatorIndent: 16, footer: notes.isEmpty ? null : notes.join(' '), children: body);
  }

  static bool _sameIds(Iterable<String> a, Iterable<String> b) {
    final x = a.toSet();
    final y = b.toSet();
    return x.length == y.length && x.containsAll(y);
  }
}

class _Padded extends StatelessWidget {
  const _Padded({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(16, 10, 14, 10), child: child);
}

/// One statement, with where it comes from; a tap opens that message.
class _Statement extends StatelessWidget {
  const _Statement({required this.statement, required this.source});

  final MatterStatusStatement statement;

  /// The message quoted, if it is still in the matter.
  final EmailSummary? source;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final l10n = context.l10n;
    final from = source;
    final showQuote = !statement.text.contains(statement.quote);
    return InkWell(
      onTap: from == null ? null : () => context.push(Routes.message(from.id)),
      child: _Padded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(statement.text, style: styles.body),
            if (showQuote)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text('“${statement.quote}”', style: styles.footnote.copyWith(fontStyle: FontStyle.italic)),
              ),
            if (from != null)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  l10n.mattersStatusSource(
                    from.sender?.displayName ?? l10n.sharedUnknownSender,
                    formatListDate(from.receivedAt, l10n: l10n),
                  ),
                  style: styles.footnote.copyWith(color: colors.unreadDot),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
