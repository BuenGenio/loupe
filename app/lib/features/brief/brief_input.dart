import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mail_ai/mail_ai.dart';
import 'package:mail_model/mail_model.dart';

import '../calendar/invitation.dart' show isCalendarAlternative;
import '../conversation/changes/comparison_content.dart';
import '../conversation/changes/email_diff.dart';
import '../openpgp/content_loader.dart';

/// HTML beyond this is not read, as in Compare Messages. Its text is
/// usually far over BriefTask's own limit anyway; the Brief says it is
/// partial either way.
const _maxHtmlCharacters = 120000;

/// HTML up to this is turned into text at once; more goes to an isolate.
const _syncHtmlCharacters = 32000;

/// What a Brief reads of a message, and whether some of it was left out
/// before the task's own limit.
typedef BriefSource = ({BriefInput input, bool cut});

/// Whether [content] has text a Brief can read: decrypted when it was
/// encrypted (never the "can't decrypt" explanation), with a plain-text or
/// an HTML body.
bool briefReadable(EmailSummary message, EmailContent content) {
  final readable = comparisonContentAvailable(
    content,
    summaryEncrypted: message.isEncrypted,
    pgpStatus: pgpStatusOf(content),
    smimeStatus: smimeStatusOf(content),
  );
  if (!readable) return false;
  return (content.text?.trim().isNotEmpty ?? false) || (content.html?.trim().isNotEmpty ?? false);
}

/// The [BriefInput] for [message]: the plain-text body, or the HTML body as
/// text (link destinations kept) when there is no plain text; the sender, the
/// date it was sent and the attachments' names. Nothing else of the message
/// goes to the model: no headers, no attachment contents. At once, unless a
/// long HTML body has to be read in an isolate.
FutureOr<BriefSource> briefSource(EmailSummary message, EmailContent content) {
  BriefSource source(String text, {required bool cut}) => (
    input: BriefInput(
      subject: protectedSubjectIn(content) ?? message.subject,
      from: message.sender?.toString() ?? '',
      date: message.sentAt ?? message.receivedAt,
      text: text,
      attachments: [for (final a in briefAttachments(content)) a.filename!],
    ),
    cut: cut,
  );
  final plain = content.text ?? '';
  final html = content.html;
  if (plain.trim().isNotEmpty || html == null) return source(plain, cut: false);
  final cut = html.length > _maxHtmlCharacters;
  final bounded = cut ? html.substring(0, _maxHtmlCharacters) : html;
  if (bounded.length <= _syncHtmlCharacters) return source(_tidy(emailHtmlText(bounded)), cut: cut);
  return compute(emailHtmlText, bounded).then((text) => source(_tidy(text), cut: cut));
}

/// The Brief task for [input], as the reader and Reply Check both make it, so
/// an unchanged message has one result in [AiService] whichever asked first:
/// [now]'s date and the device's time zone ([zone], an IANA name).
BriefTask briefTaskFor(BriefInput input, {required DateTime now, String? zone}) =>
    BriefTask(input, now: now, timeZone: zone ?? now.timeZoneName);

/// Nested blocks leave runs of empty lines; a paragraph break is enough.
String _tidy(String text) => text.replaceAll(RegExp(r'\n[ \t]*\n(?:[ \t]*\n)+'), '\n\n');

/// The attachments a Brief names: the ones the attachment list shows, with
/// a file name.
List<Attachment> briefAttachments(EmailContent content) => [
  for (final a in content.visibleAttachments)
    if (!isCalendarAlternative(a) && (a.filename?.trim().isNotEmpty ?? false)) a,
];
