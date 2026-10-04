import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/auth_results.dart';

void main() {
  test('DMARC pass is verified, with a summary', () {
    final r = AuthResults.parse(const [
      ('Received', 'from x'),
      (
        'Authentication-Results',
        'mx.google.com;\r\n       dkim=pass header.i=@example.com header.s=s1 header.b=abc;\r\n'
            '       spf=pass (google.com: domain of a@example.com designates 1.2.3.4) smtp.mailfrom=a@example.com;\r\n'
            '       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=example.com',
      ),
    ]);
    expect(r.verdict, AuthVerdict.verified);
    expect(r.summary, 'DKIM pass · SPF pass · DMARC pass');
    expect(r.methods.first.domain, 'example.com');
  });

  test('DMARC fail wins over DKIM pass', () {
    final r = AuthResults.parseValue('mx.example.net; dkim=pass header.d=evil.test; dmarc=fail header.from=bank.test');
    expect(r.verdict, AuthVerdict.failed);
  });

  test('DKIM alone decides without DMARC', () {
    expect(AuthResults.parseValue('mx; dkim=pass header.d=a.test').verdict, AuthVerdict.verified);
    expect(AuthResults.parseValue('mx; dkim=fail header.d=a.test').verdict, AuthVerdict.failed);
    expect(AuthResults.parseValue('mx; spf=pass').verdict, AuthVerdict.unknown);
  });

  test('only the topmost header counts and no header is unknown', () {
    final r = AuthResults.parse(const [
      ('Authentication-Results', 'mx.mine; dmarc=fail'),
      ('Authentication-Results', 'forged; dmarc=pass'),
    ]);
    expect(r.verdict, AuthVerdict.failed);
    expect(AuthResults.parse(const []).verdict, AuthVerdict.unknown);
    expect(AuthResults.parseValue('mx.example.net; none').methods, isEmpty);
  });
}
