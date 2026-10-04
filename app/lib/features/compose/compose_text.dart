import 'package:mail_model/mail_model.dart';

import '../../shared/format.dart';

/// Pure text helpers for replies, forwards, signatures and addresses.
abstract final class ComposeText {
  static final _replyPrefix = RegExp(r'^\s*(re|aw|sv|antw|vs|ref)(\[\d+\])?\s*:\s*', caseSensitive: false);
  static final _forwardPrefix = RegExp(r'^\s*(fwd?|wg|tr|rv|enc)(\[\d+\])?\s*:\s*', caseSensitive: false);

  /// "Re: " + subject, unless it already is a reply.
  static String replySubject(String subject) {
    final s = subject.trim();
    return _replyPrefix.hasMatch(s) ? s : 'Re: $s';
  }

  /// "Fwd: " + subject, unless it already is a forward.
  static String forwardSubject(String subject) {
    final s = subject.trim();
    return _forwardPrefix.hasMatch(s) ? s : 'Fwd: $s';
  }

  /// The subject without any Re:/Fwd: prefixes, for "Search from this message".
  static String baseSubject(String subject) {
    var s = subject.trim();
    while (true) {
      final next = s.replaceFirst(_replyPrefix, '').replaceFirst(_forwardPrefix, '');
      if (next == s) return s;
      s = next;
    }
  }

  /// "On 4 October 2026 at 14:05, Alice wrote:".
  static String attribution(EmailSummary source) {
    final who = source.sender?.displayName ?? 'someone';
    return 'On ${formatFullDate(source.sentAt ?? source.receivedAt)}, $who wrote:';
  }

  /// Prefixes every line with "> " (">" for lines that already are quotes).
  static String quote(String text) => text
      .trimRight()
      .split(RegExp(r'\r?\n'))
      .map((l) => l.isEmpty ? '>' : (l.startsWith('>') ? '>$l' : '> $l'))
      .join('\n');

  /// The quoted reply block: attribution and quoted text.
  static String replyBlock(EmailSummary source, String sourceText) => '${attribution(source)}\n${quote(sourceText)}';

  /// The forwarded-message block: header fields and the original text.
  static String forwardBlock(EmailSummary source, String sourceText) {
    String list(List<EmailAddress> a) => a.map((e) => e.toString()).join(', ');
    return [
      '---------- Forwarded message ----------',
      'From: ${list(source.from)}',
      'Date: ${formatFullDate(source.sentAt ?? source.receivedAt)}',
      'Subject: ${source.subject}',
      if (source.to.isNotEmpty) 'To: ${list(source.to)}',
      if (source.cc.isNotEmpty) 'Cc: ${list(source.cc)}',
      '',
      sourceText.trimRight(),
    ].join('\n');
  }

  /// The signature block appended after "-- ", or empty.
  static String signatureBlock(String? signature) {
    final s = signature?.trimRight() ?? '';
    return s.isEmpty ? '' : '-- \n$s';
  }

  /// Swaps the [from] signature block in [body] for [to] (identity change).
  /// Appends [to] if [from] isn't found.
  static String replaceSignature(String body, String? from, String? to) {
    final oldBlock = signatureBlock(from);
    final newBlock = signatureBlock(to);
    if (oldBlock.isNotEmpty) {
      final i = body.indexOf(oldBlock);
      if (i >= 0) return body.replaceRange(i, i + oldBlock.length, newBlock);
    }
    if (newBlock.isEmpty) return body;
    return '${body.trimRight()}\n\n$newBlock';
  }

  /// Plain text of a message: the text part, or text generated from the HTML.
  static String plainTextOf(EmailContent content) {
    final text = content.text;
    if (text != null && text.trim().isNotEmpty) return text;
    return htmlToText(content.html ?? '');
  }

  /// A simple HTML to text conversion for quoting.
  static String htmlToText(String html) {
    var s = html
        .replaceAll(RegExp(r'<(head|style|script|title)[^>]*>.*?</\1>', caseSensitive: false, dotAll: true), '')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</(p|div|tr|li|h[1-6]|blockquote)>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '• ')
        .replaceAll(RegExp(r'<[^>]+>'), '');
    const entities = {'&nbsp;': ' ', '&lt;': '<', '&gt;': '>', '&quot;': '"', '&#39;': "'", '&apos;': "'"};
    for (final MapEntry(:key, :value) in entities.entries) {
      s = s.replaceAll(key, value);
    }
    s = s.replaceAllMapped(RegExp(r'&#(\d+);'), (m) => String.fromCharCode(int.parse(m.group(1)!)));
    s = s.replaceAll('&amp;', '&');
    return s
        .split('\n')
        .map((l) => l.replaceAll(RegExp(r'[ \t]+'), ' ').trim())
        .join('\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  static final _emailRe = RegExp(r'^[^\s@<>(),;:"]+@[^\s@<>(),;:"]+\.[^\s@<>(),;:"]{2,}$');

  /// A plausible address: local@domain.tld, no spaces.
  static bool isValidEmail(String email) => _emailRe.hasMatch(email.trim());

  /// Parses `Alice <a@x.com>, b@y.com; "Doe, J" <j@z.com>` into addresses.
  /// Tokens that aren't addresses are returned as is (to show as invalid).
  static List<EmailAddress> parseAddresses(String input) {
    final out = <EmailAddress>[];
    final buf = StringBuffer();
    var quoted = false;
    var angle = false;
    void flush() {
      final token = buf.toString().trim();
      buf.clear();
      if (token.isEmpty) return;
      final m = RegExp(r'^(.*?)<([^>]*)>\s*$').firstMatch(token);
      if (m != null) {
        final name = m.group(1)!.trim().replaceAll(RegExp(r'^"|"$'), '').trim();
        out.add(EmailAddress(m.group(2)!.trim(), name.isEmpty ? null : name));
      } else {
        out.add(EmailAddress(token.replaceAll(RegExp(r'^mailto:', caseSensitive: false), '')));
      }
    }

    for (final ch in input.split('')) {
      if (ch == '"') quoted = !quoted;
      if (ch == '<') angle = true;
      if (ch == '>') angle = false;
      if (!quoted && !angle && (ch == ',' || ch == ';' || ch == '\n')) {
        flush();
      } else {
        buf.write(ch);
      }
    }
    flush();
    return out;
  }

  /// Removes duplicates (by address, case-insensitive) and the [exclude] addresses.
  static List<EmailAddress> dedupe(Iterable<EmailAddress> addresses, {Set<String> exclude = const {}}) {
    final seen = {...exclude.map((e) => e.toLowerCase())};
    return [
      for (final a in addresses)
        if (seen.add(a.email.toLowerCase())) a,
    ];
  }

  /// Recipients of a reply to [source]. [own] are the user's addresses
  /// (lower-cased); they never receive a Reply All, and replying to one's own
  /// message goes to its original recipients.
  static ({List<EmailAddress> to, List<EmailAddress> cc}) replyRecipients(
    EmailSummary source, {
    required bool all,
    required Set<String> own,
  }) {
    final fromMe = source.from.isNotEmpty && own.contains(source.from.first.email.toLowerCase());
    final primary = fromMe ? source.to : (source.replyTo.isNotEmpty ? source.replyTo : source.from);
    if (!all) {
      final to = dedupe(primary, exclude: fromMe ? own : const {});
      return (to: to.isEmpty ? dedupe(primary) : to, cc: const []);
    }
    final to = dedupe([...primary, if (!fromMe) ...source.to], exclude: own);
    final cc = dedupe(source.cc, exclude: {...own, ...to.map((a) => a.email)});
    return (to: to.isEmpty && cc.isEmpty ? dedupe(primary) : to, cc: cc);
  }

  /// The References of a reply: the source's references plus its Message-ID.
  static List<String> replyReferences(EmailSummary source) => [
    ...source.references.where((r) => r != source.messageIdHeader),
    ?source.messageIdHeader,
  ];
}
