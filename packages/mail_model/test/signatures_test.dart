import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

Signature sig(String id, [SignatureRule rule = SignatureRule.always]) =>
    Signature(id: id, content: '[{"insert":"$id\\n"}]', rule: rule);

/// signature.cc's choice: copied, scheduled, rotating, default.
void main() {
  final now = DateTime(2026, 12, 10, 15);
  const client = EmailAddress('ana@client.example');
  const colleague = EmailAddress('bo@acme.example');

  String? pick(List<Signature> list, {List<EmailAddress> cc = const [], int? seed, DateTime? at}) =>
      chooseSignature(list, now: at ?? now, cc: cc, seed: seed)?.id;

  test('the first ordinary signature is the default; none without signatures', () {
    expect(pick([sig('a'), sig('b')]), 'a');
    expect(pick(const []), isNull);
  });

  test('a "when copied" signature replaces it while someone is in Cc', () {
    final list = [sig('default'), sig('copied', const SignatureRule(whenCopied: true))];
    expect(pick(list), 'default');
    expect(pick(list, cc: [colleague]), 'copied');
  });

  test('one naming the copied address or domain wins over one for anyone', () {
    final list = [
      sig('default'),
      sig('anyone', const SignatureRule(whenCopied: true)),
      sig('client', const SignatureRule(whenCopied: true, copied: ['*@client.example'])),
    ];
    expect(pick(list, cc: [colleague]), 'anyone');
    expect(pick(list, cc: [colleague, client]), 'client');
    // Only for that domain: without it in Cc, the default.
    final only = [
      sig('default'),
      sig('client', const SignatureRule(whenCopied: true, copied: ['client.example'])),
    ];
    expect(pick(only, cc: [colleague]), 'default');
    expect(pick(only, cc: [const EmailAddress('x@eu.client.example')]), 'client');
  });

  test('a scheduled signature takes over between its days, both included', () {
    final list = [
      sig('default'),
      sig('holidays', SignatureRule(from: DateTime(2026, 12, 20), until: DateTime(2027, 1, 2))),
    ];
    expect(pick(list), 'default');
    expect(pick(list, at: DateTime(2026, 12, 20, 0, 1)), 'holidays');
    expect(pick(list, at: DateTime(2027, 1, 2, 23, 59)), 'holidays');
    expect(pick(list, at: DateTime(2027, 1, 3)), 'default');
    // A copied-only signature out of its dates doesn't apply either.
    final copied = [sig('default'), sig('copied', SignatureRule(whenCopied: true, until: DateTime(2026, 12, 1)))];
    expect(pick(copied, cc: [client]), 'default');
  });

  test('signatures in rotation are picked at random, repeatably for a seed', () {
    final list = [
      sig('default'),
      sig('quote1', const SignatureRule(rotate: true)),
      sig('quote2', const SignatureRule(rotate: true)),
      sig('quote3', const SignatureRule(rotate: true)),
    ];
    final picks = {for (var seed = 0; seed < 40; seed++) pick(list, seed: seed)};
    expect(picks, {'quote1', 'quote2', 'quote3'});
    expect(pick(list, seed: 7), pick(list, seed: 7));
  });

  test('only copied signatures and nobody copied: no signature', () {
    expect(pick([sig('copied', const SignatureRule(whenCopied: true))]), isNull);
  });

  test('addressMatches: addresses, wildcards and domains', () {
    expect(addressMatches('Ana@Client.example', 'ana@client.example'), isTrue);
    expect(addressMatches('*@client.example', 'bo@client.example'), isTrue);
    expect(addressMatches('*@client.example', 'bo@eu.client.example'), isFalse);
    expect(addressMatches('client.example', 'bo@eu.client.example'), isTrue);
    expect(addressMatches('client.example', 'bo@notclient.example'), isFalse);
    expect(addressMatches('me+*@acme.example', 'me+news@acme.example'), isTrue);
  });

  test('rules round-trip through JSON; plainText drops images and fields', () {
    final rule = SignatureRule(
      whenCopied: true,
      copied: const ['a@b.example'],
      from: DateTime(2026, 1, 5),
      rotate: true,
    );
    final back = SignatureRule.fromJson(rule.toJson());
    expect(back.whenCopied, isTrue);
    expect(back.copied, ['a@b.example']);
    expect(back.from, DateTime(2026, 1, 5));
    expect(back.until, isNull);
    expect(back.rotate, isTrue);
    const rich = Signature(
      id: 's',
      content:
          '[{"insert":"Sam","attributes":{"bold":true}},{"insert":"\\n"},{"insert":{"image":"data:image/png;base64,AA=="}},'
          '{"insert":"\\n"},{"insert":{"loupe-field":"email"}},{"insert":"\\n"}]',
    );
    expect(rich.plainText, 'Sam');
  });
}
