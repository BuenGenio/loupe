import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/model/document.dart';
import 'package:readable/src/pipeline/fine_print.dart';
import 'package:readable/src/pipeline/pipeline.dart';

ReaderDocument readable(String html) => runPipeline(PipelineInput(mode: PipelineMode.readable, html: html)).document;

/// Whether the paragraph containing [text] is fine print (searching quotes).
bool isFine(ReaderDocument d, String text) {
  Iterable<ParagraphBlock> paragraphs(List<Block> blocks) sync* {
    for (final b in blocks) {
      if (b is ParagraphBlock) yield b;
      if (b is QuoteBlock) yield* paragraphs(b.children);
    }
  }

  final p = paragraphs(d.blocks).firstWhere((p) => inlineText(p.inlines).contains(text));
  return p.inlines.whereType<TextRun>().every((r) => r.style.fine);
}

const body =
    '<p>Hi Sam,</p><p>Thanks for the call this morning. I have attached the revised draft with the changes we '
    'discussed, and marked the two clauses that still need your input.</p><p>Best,<br>Alex</p>';
const notice =
    'This email is confidential and may be legally privileged. If you are not the intended recipient, please '
    'delete it and notify the sender.';

void main() {
  group('footerScore', () {
    test('legal notices, registration, privacy and newsletter footers', () {
      for (final text in [
        notice,
        'X LLP is a limited liability partnership, registered in Scotland.',
        'Registered office: 1 Example Square. Company number 01234567. VAT number GB 123 4567 89.',
        'Authorised and regulated by the Solicitors Regulation Authority.',
        'To understand how we handle and process your personal data, see our privacy notice.',
        'You received this email because you signed up on our website.',
        'You’re receiving this because you opted in.',
        'Manage preferences · Unsubscribe',
        'View this email in your browser',
        'Copyright © 2026 Example Ltd. All rights reserved.',
        'Important notice: this message is confidential and legally privileged.',
      ]) {
        expect(footerScore(text), greaterThanOrEqualTo(footerThreshold), reason: text);
      }
    });

    test('body text that mentions the same words', () {
      for (final text in [
        'Please keep this confidential until Friday.',
        'The board papers are confidential and privileged.',
        'Prices include VAT.',
        'We registered in time for the conference.',
        'Can you adopt our outdoor style guide?',
      ]) {
        expect(footerScore(text), lessThan(footerThreshold), reason: text);
      }
    });
  });

  test('footer links and calls to action', () {
    bool footer(String url, String text) => isFooterLink(LinkRef(url, text: text));
    expect(footer('https://x.example/u?id=1', 'Unsubscribe'), isTrue);
    expect(footer('https://x.example/p', 'update your preferences'), isTrue);
    expect(footer('https://x.example/privacy', 'Privacy Notice'), isTrue);
    expect(footer('https://www.firm.example/', 'www.firm.example'), isTrue);
    expect(footer('mailto:info@firm.example', 'Email us'), isTrue);
    expect(footer('https://x.example/unsubscribe?u=1', 'here'), isTrue);
    expect(footer('https://x.example/confirm?u=1', 'here'), isFalse);
    expect(footer('https://x.example/reset?t=1', 'Reset your password'), isFalse);
    expect(footer('https://x.example/rsvp', 'Reserve your seat'), isFalse);
  });

  group('trailingStart', () {
    List<Block> paragraphs(List<String> texts) => [
      for (final t in texts) ParagraphBlock([TextRun(t)]),
    ];

    test('the last 30% of blocks, never the first block', () {
      expect(trailingStart(paragraphs(List.filled(10, 'x'))), 7);
      expect(trailingStart(paragraphs(['x'])), 1);
      expect(trailingStart(const []), 0);
    });

    test('at a signature delimiter or signature block', () {
      expect(trailingStart(paragraphs(['a', 'b', '--\nAlex', 'c', 'd', 'e', 'f', 'g', 'h', 'i'])), 2);
      final blocks = [
        ...paragraphs(['a', 'b', 'c']),
        const ParagraphBlock([TextRun('Alex')], muted: true),
        ...paragraphs(['d', 'e', 'f', 'g', 'h', 'i']),
      ];
      expect(trailingStart(blocks), 3);
    });

    test('after the last rule that follows text, unless asked to ignore rules', () {
      final blocks = [
        const RuleBlock(),
        ...paragraphs(['a', 'b']),
        const RuleBlock(),
        ...paragraphs(['c', 'd', 'e', 'f', 'g', 'h', 'i']),
      ];
      expect(trailingStart(blocks), 4);
      expect(trailingStart(blocks, afterRules: false), 7);
    });
  });

  group('fine print by wording', () {
    test('a notice at the end of the message, at body size', () {
      final d = readable('$body<p>$notice</p>');
      expect(isFine(d, 'This email is confidential'), isTrue);
      expect(isFine(d, 'Thanks for the call'), isFalse);
    });

    test('after a rule or a signature delimiter, through signature lines', () {
      final d = readable(
        '$body<hr><p>$notice</p><p>Example LLP, 1 Example Square</p>'
        '<p>Registered in England and Wales, number 0123456.</p>',
      );
      expect(isFine(d, 'This email is confidential'), isTrue);
      expect(isFine(d, 'Registered in England'), isTrue);
      expect(isFine(d, 'Example LLP, 1 Example Square'), isFalse);
      final sig = readable('$body<div>-- </div><div>Alex Example</div><p>$notice</p>');
      expect(isFine(sig, 'This email is confidential'), isTrue);
    });

    test('never the body proper', () {
      // The only paragraph.
      expect(isFine(readable('<p>$notice</p>'), 'This email'), isFalse);
      // Followed by more body text.
      final d = readable(
        '$body<p>$notice</p><p>${'And one more long paragraph of ordinary body text that follows it. ' * 3}</p>',
      );
      expect(isFine(d, 'This email is confidential'), isFalse);
      // At the start of a long message.
      final first = readable('<p>$notice</p>${'<p>Body paragraph.</p>' * 9}');
      expect(isFine(first, 'This email is confidential'), isFalse);
    });

    test('not a paragraph holding the call to action', () {
      final d = readable(
        '$body<p>You received this email because you asked to reset your password. '
        '<a href="https://x.example/reset?t=1">Reset your password</a></p>',
      );
      expect(isFine(d, 'You received this email'), isFalse);
      final footer = readable(
        '$body<p>You received this email because you subscribed. '
        '<a href="https://x.example/unsubscribe">Unsubscribe</a> or <a href="https://x.example/p">manage preferences</a>.</p>',
      );
      expect(isFine(footer, 'You received this email'), isTrue);
    });

    test('a quoted message has its own footer', () {
      final d = readable('<p>Forwarding this, see below.</p><blockquote>$body<p>$notice</p></blockquote>');
      expect(isFine(d, 'This email is confidential'), isTrue);
      expect(isFine(d, 'Thanks for the call'), isFalse);
    });
  });
}
