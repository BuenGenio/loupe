import 'package:mail_ai/mail_ai.dart';
import 'package:test/test.dart';

/// Asks for `{"v": string}` and accepts nothing else.
final class _Echo extends AiTask<String> {
  const _Echo(this.input);

  @override
  final String input;

  @override
  String get type => 'test.echo';
  @override
  int get version => 1;
  @override
  TaskSize get size => TaskSize.short;
  @override
  String get instructions => 'Reply with JSON {"v": string}.';
  @override
  int get maxOutputTokens => 50;

  @override
  TaskParse<String> parse(String raw) => switch (parseJsonObject(raw)) {
    Parsed(:final value) when value['v'] is String => Parsed(value['v'] as String),
    Parsed() => const Rejected('"v" must be a string.'),
    Rejected(:final reason) => Rejected(reason),
  };
}

void main() {
  final at = DateTime.utc(2026, 10, 29, 12);
  AiRunner runner(FakeProvider fake) => AiRunner(fake, now: () => at);

  test('a valid answer is parsed and recorded', () async {
    final fake = FakeProvider(answers: ['{"v": "hello"}']);
    final run = await runner(fake).run(const _Echo('x'));
    expect(run, isA<AiSuccess<String>>());
    expect((run as AiSuccess<String>).value, 'hello');
    expect(run.record.attempts, 1);
    expect(run.record.providerId, 'fake');
    expect(run.record.model, 'fake-1');
    expect(run.record.taskType, 'test.echo');
    expect(run.record.inputHash, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(run.record.inputTokens, greaterThan(0));
    expect(run.record.startedAt, at);
    expect(fake.requests.single.instructions, 'Reply with JSON {"v": string}.');
    expect(fake.requests.single.input, 'x');
  });

  test('a rejected answer gets one repair attempt with the reason', () async {
    final fake = FakeProvider(answers: ['Sure! Here you go.', '{"v": "fixed"}']);
    final run = await runner(fake).run(const _Echo('x'));
    expect((run as AiSuccess<String>).value, 'fixed');
    expect(run.record.attempts, 2);
    expect(fake.requests, hasLength(2));
    final repair = fake.requests[1];
    expect(repair.instructions, fake.requests[0].instructions);
    expect(repair.input, startsWith('x\n'));
    expect(repair.input, contains('could not be used: The answer is not valid JSON'));
    expect(repair.input, contains('Sure! Here you go.'));
  });

  test('two rejected answers fail with the last reason', () async {
    final fake = FakeProvider(answers: ['{"v": 1}', '{"v": 2}']);
    final run = await runner(fake).run(const _Echo('x'));
    expect(run, isA<AiFailure<String>>());
    final failure = run as AiFailure<String>;
    expect(failure.reason, AiFailureReason.invalidOutput);
    expect(failure.message, '"v" must be a string.');
    expect(failure.record.attempts, 2);
    expect(fake.requests, hasLength(2));
  });

  test('a fenced answer is accepted', () async {
    final fake = FakeProvider(answers: ['```json\n{"v": "fenced"}\n```']);
    final run = await runner(fake).run(const _Echo('x'));
    expect((run as AiSuccess<String>).value, 'fenced');
  });

  test('a provider error fails the run; nothing else is tried', () async {
    final fake = FakeProvider(answers: ['{"v": "never"}'])
      ..failWith = const AiProviderException('No network', retryable: true);
    final run = await runner(fake).run(const _Echo('x'));
    final failure = run as AiFailure<String>;
    expect(failure.reason, AiFailureReason.providerError);
    expect(failure.message, 'No network');
    expect(failure.retryable, isTrue);
    expect(failure.record.attempts, 1);
  });

  test('cancelled before the first request: nothing is sent', () async {
    final fake = FakeProvider(answers: ['{"v": "never"}']);
    final run = await runner(fake).run(const _Echo('x'), cancel: CancelToken()..cancel());
    expect((run as AiFailure<String>).reason, AiFailureReason.cancelled);
    expect(run.record.attempts, 0);
    expect(fake.requests, isEmpty);
  });

  test('cancelled after a rejected answer: no repair is sent', () async {
    final token = CancelToken();
    final fake = FakeProvider.scripted((_) {
      token.cancel();
      return 'not json';
    });
    final run = await runner(fake).run(const _Echo('x'), cancel: token);
    expect((run as AiFailure<String>).reason, AiFailureReason.cancelled);
    expect(run.record.attempts, 1);
    expect(fake.requests, hasLength(1));
  });

  test('cancelled while the provider is working', () async {
    final token = CancelToken();
    final fake = FakeProvider(answers: ['{"v": "late"}'])..delay = const Duration(milliseconds: 20);
    final pending = runner(fake).run(const _Echo('x'), cancel: token);
    token.cancel();
    final run = await pending;
    expect((run as AiFailure<String>).reason, AiFailureReason.cancelled);
  });

  test('input that does not fit the provider is refused, not trimmed', () async {
    final fake = FakeProvider(
      answers: ['{"v": "never"}'],
      capabilities: const ProviderCapabilities(maxInputTokens: 20, maxOutputTokens: 100),
    );
    final run = await runner(fake).run(_Echo('x' * 400));
    final failure = run as AiFailure<String>;
    expect(failure.reason, AiFailureReason.tooLarge);
    expect(failure.message, contains('at most 20'));
    expect(failure.record.attempts, 0);
    expect(fake.requests, isEmpty);
  });

  test('an output budget the provider cannot give is refused', () async {
    final fake = FakeProvider(
      answers: ['{"v": "never"}'],
      capabilities: const ProviderCapabilities(maxInputTokens: 1000, maxOutputTokens: 10),
    );
    final run = await runner(fake).run(const _Echo('x'));
    expect((run as AiFailure<String>).reason, AiFailureReason.tooLarge);
    expect(fake.requests, isEmpty);
  });

  test('anything but a provider exception is a bug and propagates', () {
    final fake = FakeProvider(); // no answers: StateError
    expect(runner(fake).run(const _Echo('x')), throwsStateError);
  });

  test('the input hash covers type, version, instructions and input', () {
    expect(inputHash(const _Echo('x')), inputHash(const _Echo('x')));
    expect(inputHash(const _Echo('x')), isNot(inputHash(const _Echo('y'))));
  });

  test('token counts are summed over attempts and never invented', () async {
    final silent = FakeProvider.scripted((_) => '{"v": "ok"}');
    final run = await runner(silent).run(const _Echo('x'));
    expect(run.record.inputTokens, isNotNull); // the fake reports estimates

    final fake = FakeProvider(answers: ['nope', '{"v": "ok"}']);
    final two = await runner(fake).run(const _Echo('x'));
    expect(two.record.inputTokens, fake.requests[0].estimatedInputTokens + fake.requests[1].estimatedInputTokens);
  });
}
