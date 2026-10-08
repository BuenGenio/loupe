import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../../l10n/l10n.dart';
import '../../shared/avatar.dart';
import '../../shared/format.dart';
import '../../shared/tags.dart';
import '../../theme/theme.dart';
import '../calendar/invitation_card.dart';
import '../openpgp/key_import.dart';
import '../openpgp/pgp_status.dart';
import '../smime/smime_import.dart';
import '../smime/smime_status.dart';
import 'attachments.dart';
import 'auth_results.dart';
import 'security/security_badge.dart';
import 'security/security_gate.dart';
import '../../theme/loupe_icons.dart';

/// One message of a conversation: a one-line summary when collapsed, the
/// header, body and attachments when expanded.
class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.expanded,
    required this.ownAddresses,
    required this.content,
    required this.settings,
    required this.remoteContent,
    this.remoteAllowedHere = false,
    required this.showOriginalHint,
    required this.onToggle,
    required this.onMore,
    required this.onAddressTap,
    required this.onAllowRemoteContent,
    required this.onOpenLink,
    required this.onSuggestOriginal,
    required this.onUseOriginal,
    required this.onRetry,
    required this.loadAttachment,
  });

  final EmailSummary message;
  final bool expanded;

  /// The user's own addresses (lower-cased), shown as "me".
  final Set<String> ownAddresses;

  /// The body, loading; null while collapsed.
  final Future<EmailContent>? content;
  final ReaderSettings settings;
  final RemoteContentPolicy remoteContent;

  /// The user allowed remote content for this very message ("Load images"),
  /// not by a setting: what decrypted mail without integrity protection
  /// needs (see [remoteContentNeedsConsent]).
  final bool remoteAllowedHere;

  /// Readable mode suggested the Original view for this message.
  final bool showOriginalHint;

  /// Expands or collapses; null when the message can't collapse.
  final VoidCallback? onToggle;
  final VoidCallback onMore;
  final ValueChanged<EmailAddress> onAddressTap;
  final void Function({required bool always}) onAllowRemoteContent;
  final ValueChanged<Uri> onOpenLink;
  final VoidCallback onSuggestOriginal;
  final VoidCallback onUseOriginal;
  final VoidCallback onRetry;
  final Future<Uint8List> Function(Attachment attachment) loadAttachment;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool _details = false;

  EmailSummary get _m => widget.message;

  String _name(EmailAddress a) =>
      widget.ownAddresses.contains(a.email.toLowerCase()) ? context.l10n.conversationMe : a.displayName;

  @override
  Widget build(BuildContext context) => widget.expanded ? _expanded(context) : _collapsed(context);

  Widget _collapsed(BuildContext context) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return InkWell(
      key: ValueKey('collapsed-${_m.id}'),
      onTap: widget.onToggle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            SenderAvatar(address: _m.sender, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _m.sender == null ? context.l10n.conversationNoSender : _name(_m.sender!),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (_m.isFlagged) Icon(LoupeIcons.flaggedFilled, size: 14, color: colors.flag),
                      const SizedBox(width: 4),
                      Text(
                        formatListDate(_m.receivedAt),
                        style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
                      ),
                    ],
                  ),
                  Text(
                    _m.preview.isEmpty ? ' ' : _m.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expanded(BuildContext context) => FutureBuilder<EmailContent>(
    key: ObjectKey(widget.content),
    future: widget.content,
    builder: (context, snapshot) {
      final content = snapshot.data;
      final auth = content == null ? AuthResults.none : AuthResults.parse(content.headers);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(context, content),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            alignment: Alignment.topCenter,
            child: _details ? _detailsBlock(context, auth) : const SizedBox(width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: switch (snapshot) {
              AsyncSnapshot(hasError: true, :final error) => _BodyError(error: error!, onRetry: widget.onRetry),
              AsyncSnapshot(hasData: true, data: final c?) => _body(c),
              _ => const BodySkeleton(),
            },
          ),
        ],
      );
    },
  );

  Widget _header(BuildContext context, EmailContent? content) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    final sender = _m.sender;
    final recipients = [..._m.to, ..._m.cc, ..._m.bcc];
    final l10n = context.l10n;
    final shown = recipients.take(2).map(_name).join(', ');
    final tags = _m.tags.toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 4, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            key: ValueKey('avatar-${_m.id}'),
            onTap: widget.onToggle,
            child: SenderAvatar(address: sender, size: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        key: ValueKey('sender-${_m.id}'),
                        onTap: sender == null ? null : () => widget.onAddressTap(sender),
                        child: Text(
                          sender == null ? l10n.conversationNoSender : _name(sender),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SecurityBadge(message: _m, content: content),
                    PgpHeaderMark(message: _m, content: content, onRetry: widget.onRetry),
                    SmimeHeaderMark(message: _m, content: content, onRetry: widget.onRetry),
                  ],
                ),
                InkWell(
                  key: ValueKey('recipients-${_m.id}'),
                  onTap: () => setState(() => _details = !_details),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            recipients.isEmpty
                                ? l10n.conversationNoRecipients
                                : recipients.length > 2
                                ? l10n.conversationRecipientsMore(shown, recipients.length - 2)
                                : l10n.conversationRecipients(shown),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText, fontSize: 14),
                          ),
                        ),
                        Icon(
                          _details ? LoupeIcons.collapse : LoupeIcons.disclosure,
                          size: 16,
                          color: colors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                ),
                PgpStatusLine(message: _m, content: content, onRetry: widget.onRetry),
                SmimeStatusLine(message: _m, content: content, onRetry: widget.onRetry),
                if (tags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Wrap(spacing: 6, runSpacing: 4, children: [for (final t in tags) TagChip(keyword: t)]),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatListDate(_m.receivedAt),
                  style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText),
                ),
                if (_m.isFlagged)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Icon(LoupeIcons.flaggedFilled, size: 16, color: colors.flag),
                  ),
              ],
            ),
          ),
          IconButton(
            key: ValueKey('more-${_m.id}'),
            tooltip: l10n.commonMore,
            visualDensity: VisualDensity.compact,
            icon: Icon(LoupeIcons.more, color: theme.colorScheme.primary),
            onPressed: widget.onMore,
          ),
        ],
      ),
    );
  }

  Widget _detailsBlock(BuildContext context, AuthResults auth) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(68, 6, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addressRow(context, l10n.conversationHeaderFrom, _m.from),
          _addressRow(context, l10n.conversationHeaderTo, _m.to),
          if (_m.cc.isNotEmpty) _addressRow(context, l10n.conversationHeaderCc, _m.cc),
          if (_m.bcc.isNotEmpty) _addressRow(context, l10n.conversationHeaderBcc, _m.bcc),
          if (_m.replyTo.isNotEmpty) _addressRow(context, l10n.conversationHeaderReplyTo, _m.replyTo),
          _row(
            context,
            l10n.conversationHeaderDate,
            Text(formatFullDate(_m.sentAt ?? _m.receivedAt), style: theme.textTheme.bodySmall),
          ),
          if (auth.methods.isNotEmpty)
            _row(
              context,
              l10n.conversationHeaderSecurity,
              Row(
                children: [
                  AuthBadge(verdict: auth.verdict, summary: auth.summary, padding: EdgeInsets.zero),
                  const SizedBox(width: 4),
                  Flexible(child: Text(auth.summary, style: theme.textTheme.bodySmall)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, Widget value) {
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 68,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.secondaryText)),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }

  Widget _addressRow(BuildContext context, String label, List<EmailAddress> addresses) {
    final theme = Theme.of(context);
    final colors = LoupeColors.of(context);
    return _row(
      context,
      label,
      addresses.isEmpty
          ? Text('—', style: theme.textTheme.bodySmall?.copyWith(color: colors.secondaryText))
          : Wrap(
              spacing: 8,
              runSpacing: 2,
              children: [
                for (final a in addresses)
                  GestureDetector(
                    onTap: () => widget.onAddressTap(a),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _name(a),
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                          if (a.name?.trim().isNotEmpty ?? false)
                            TextSpan(
                              text: ' <${a.email}>',
                              style: TextStyle(color: colors.secondaryText),
                            ),
                        ],
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _body(EmailContent content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showOriginalHint && widget.settings.mode == ReaderMode.readable)
          _OriginalHint(onUseOriginal: widget.onUseOriginal),
        SecurityGate(
          message: _m,
          content: content,
          placeholder: const BodySkeleton(),
          builder: (context, {required inert, required openLinksDirectly}) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InvitationCard(message: _m, content: content, load: widget.loadAttachment, inert: inert),
              ReadableMessageView(
                content: content,
                senderDomain: widget.message.sender?.domain,
                settings: widget.settings,
                remoteContent: remoteContentNeedsConsent(content) && !widget.remoteAllowedHere
                    ? RemoteContentPolicy.block
                    : widget.remoteContent,
                onAllowRemoteContent: widget.onAllowRemoteContent,
                onOpenLink: widget.onOpenLink,
                loadAttachment: widget.loadAttachment,
                onSuggestOriginal: widget.onSuggestOriginal,
                openLinksDirectly: openLinksDirectly,
                inert: inert,
              ),
            ],
          ),
        ),
        AttachmentList(content: content, load: widget.loadAttachment),
        PgpKeyAttachments(content: content, load: widget.loadAttachment),
        SmimeCertificateAttachments(content: content, load: widget.loadAttachment),
      ],
    );
  }
}

/// A small seal next to the sender: verified (DKIM/DMARC pass) or a warning
/// (they failed). Nothing when the result is unknown.
class AuthBadge extends StatelessWidget {
  const AuthBadge({
    super.key,
    required this.verdict,
    required this.summary,
    this.padding = const EdgeInsets.only(left: 4),
  });

  final AuthVerdict verdict;
  final String summary;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final (icon, color, label) = switch (verdict) {
      AuthVerdict.verified => (
        LoupeIcons.verified,
        CupertinoColors.systemGreen.resolveFrom(context),
        context.l10n.conversationVerifiedSender,
      ),
      AuthVerdict.failed => (
        LoupeIcons.unverified,
        CupertinoColors.systemOrange.resolveFrom(context),
        context.l10n.conversationUnverifiedSender,
      ),
      AuthVerdict.unknown => (null, null, null),
    };
    if (icon == null) return const SizedBox.shrink();
    return Padding(
      padding: padding,
      child: Tooltip(
        message: summary.isEmpty ? label! : '$label · $summary',
        triggerMode: TooltipTriggerMode.tap,
        child: Icon(icon, size: 16, color: color, semanticLabel: label),
      ),
    );
  }
}

/// A coloured tag label.
class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.keyword});
  final String keyword;

  @override
  Widget build(BuildContext context) {
    final color = tagColor(keyword);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
      child: Text(
        tagLabel(keyword),
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Grey placeholder lines while a body loads.
class BodySkeleton extends StatelessWidget {
  const BodySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = LoupeColors.of(context).separator.withValues(alpha: 0.5);
    Widget line(double factor) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: factor,
        child: Container(
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
    return Semantics(
      label: context.l10n.conversationLoadingMessage,
      child: Column(
        key: const Key('body-skeleton'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [line(0.92), line(0.98), line(0.85), line(0.6), const SizedBox(height: 8), line(0.9), line(0.4)],
      ),
    );
  }
}

class _BodyError extends StatelessWidget {
  const _BodyError({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    final offline = error is MailException && (error as MailException).kind == MailErrorKind.connection;
    final l10n = context.l10n;
    final message = switch (error) {
      MailException(:final message) => message,
      _ => l10n.conversationBodyError,
    };
    return Column(
      children: [
        Icon(offline ? LoupeIcons.offline : LoupeIcons.error, color: colors.secondaryText),
        const SizedBox(height: 8),
        Text(
          offline ? l10n.conversationBodyOffline : message,
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.secondaryText),
        ),
        TextButton(onPressed: onRetry, child: Text(l10n.commonTryAgain)),
      ],
    );
  }
}

class _OriginalHint extends StatelessWidget {
  const _OriginalHint({required this.onUseOriginal});
  final VoidCallback onUseOriginal;

  @override
  Widget build(BuildContext context) {
    final colors = LoupeColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(LoupeIcons.readable, size: 16, color: colors.secondaryText),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              context.l10n.conversationOriginalHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.secondaryText),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: onUseOriginal,
            child: Text(context.l10n.conversationShowOriginal),
          ),
        ],
      ),
    );
  }
}
