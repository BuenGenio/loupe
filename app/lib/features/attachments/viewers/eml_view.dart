import 'package:flutter/material.dart';
import 'package:readable/readable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/format.dart';
import '../../../theme/theme.dart';
import '../eml.dart';

/// An attached message: its headers, then its body in the reader (remote
/// content blocked until asked for, like any message), then the names of
/// its own attachments.
class EmlView extends StatefulWidget {
  const EmlView({super.key, required this.message, required this.emailId});

  final EmlMessage message;

  /// Identifies the body for the reader's cache: unique per attachment.
  final String emailId;

  @override
  State<EmlView> createState() => _EmlViewState();
}

class _EmlViewState extends State<EmlView> {
  var _remote = RemoteContentPolicy.block;

  Future<void> _openLink(Uri uri) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Exception {
      // Nothing to do: the link stays where it is.
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.message;
    final colors = LoupeColors.of(context);
    final styles = LoupeTextStyles.of(context);
    final label = styles.footnote.copyWith(color: colors.secondaryText);

    Widget header(String name, String? value) => value == null || value.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '$name  ', style: label),
                  TextSpan(text: value, style: styles.footnote),
                ],
              ),
            ),
          );

    return ListView(
      key: const Key('eml-view'),
      padding: EdgeInsets.fromLTRB(16, 12, 16, 32 + MediaQuery.paddingOf(context).bottom),
      children: [
        SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                m.subject?.trim().isNotEmpty == true ? m.subject! : '(No Subject)',
                style: styles.body.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              header('From', m.from),
              header('To', m.to),
              header('Cc', m.cc),
              if (m.date != null) header('Date', formatFullDate(m.date!)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1, thickness: 0.5, color: colors.separator),
        ),
        if (m.hasBody)
          ReadableMessageView(
            content: m.toContent(widget.emailId),
            remoteContent: _remote,
            onAllowRemoteContent: ({required always}) => setState(() => _remote = RemoteContentPolicy.allow),
            onOpenLink: _openLink,
          )
        else
          Text('This message has no text.', style: label),
        if (m.attachmentNames.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              '${m.attachmentNames.length == 1 ? 'Attachment' : 'Attachments'}: ${m.attachmentNames.join(', ')}',
              style: label,
            ),
          ),
      ],
    );
  }
}
