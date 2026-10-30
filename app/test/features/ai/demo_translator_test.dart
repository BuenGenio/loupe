import 'package:expr_search/expr_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/ai/demo_ai_provider.dart';
import 'package:mail_ai/mail_ai.dart';

void main() {
  final now = DateTime(2026, 10, 29, 12);
  String expression(String sentence) => demoTranslate(sentence, now: now)['expression']! as String;

  test('turns the plan\'s example into operators the parser accepts', () {
    final e = expression('unread from dana with attachments since september');
    expect(e, contains('from:dana'));
    expect(e, contains('is:unread'));
    expect(e, contains('has:attachment'));
    expect(e, contains('after:2026-09-01'));
    expect(parseQuery(e, now: now).isValid, isTrue);
  });

  test('knows a few more words: flagged, about, last week, years, PDFs', () {
    expect(expression('flagged mail about invoices from the last week'), 'is:flagged subject:invoices newer_than:7d');
    expect(expression('anything from ben in 2025'), 'from:ben date:2025');
    expect(expression('pdfs sent to accounts in march'), 'filename:pdf to:accounts date:2026-03');
    expect(expression('unreplied messages from the past 3 days'), 'is:unreplied newer_than:3d');
  });

  test('a month later in the year than today belongs to last year', () {
    expect(expression('mail from dana since december'), 'from:dana after:2025-12-01');
  });

  test('words it does not know search as text, and are named in the interpretation', () {
    final answer = demoTranslate('unread invoices from harbour', now: now);
    expect(answer['expression'], 'is:unread from:harbour invoices');
    expect(answer['interpretation'], 'Mail mentioning "invoices" unread, from harbour.');
  });

  test('one word, or nothing it can use, becomes a question', () {
    expect(demoTranslate('photos', now: now)['expression'], '');
    expect(demoTranslate('photos', now: now)['questions'], isNotEmpty);
    expect(demoTranslate('show me all the mail', now: now)['expression'], '');
  });

  test('every sentence it answers parses', () {
    for (final s in [
      'unread from dana with attachments since september',
      'flagged mail about invoices from the last week',
      'anything from ben in 2025',
      'replied mail to jordan before june',
      'photos from yesterday',
      'important mail from the last month',
    ]) {
      final e = expression(s);
      expect(e, isNotEmpty, reason: s);
      expect(parseQuery(e, now: now).isValid, isTrue, reason: '$s → $e');
    }
  });

  test('as a provider it answers the translation task and refuses others', () async {
    final provider = DemoAiProvider(now: () => now);
    final run = await AiRunner(provider).run(SearchTranslationTask('unread from dana', now: now));
    expect(run, isA<AiSuccess<SearchTranslation>>());
    final value = (run as AiSuccess<SearchTranslation>).value;
    expect(value.expression, 'is:unread from:dana');
    expect(run.record.model, 'demo');

    final other = await AiRunner(provider).run(BriefTaskStandIn());
    expect((other as AiFailure<String>).reason, AiFailureReason.providerError);
  });
}

/// Any task that is not a search translation.
final class BriefTaskStandIn extends AiTask<String> {
  @override
  String get type => 'brief.message';
  @override
  int get version => 1;
  @override
  TaskSize get size => TaskSize.long;
  @override
  String get instructions => 'x';
  @override
  String get input => 'y';
  @override
  int get maxOutputTokens => 10;
  @override
  TaskParse<String> parse(String raw) => Parsed(raw);
}
