import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/pipeline/hosts.dart';

void main() {
  group('decodePunycode', () {
    test('RFC 3492 samples and well-known names', () {
      expect(decodePunycode('mnchen-3ya'), 'münchen');
      expect(decodePunycode('bcher-kva'), 'bücher');
      expect(decodePunycode('pple-43d'), 'аpple'); // Cyrillic а + Latin pple
      expect(decodePunycode('80ak6aa92e'), 'аррӏе'); // all Cyrillic
      expect(decodePunycode('ihqwcrb4cv8a8dqg056pqjye'), '他们为什么不说中文');
      expect(decodePunycode('egbpdaj6bu4bxfgehfvwxn'), 'ليهمابتكلموشعربي؟');
    });

    test('malformed input gives null', () {
      expect(decodePunycode('abc-é'), isNull);
      expect(decodePunycode('99999999999'), isNull);
      expect(decodePunycode('a-!'), isNull);
    });
  });

  group('inspectHost', () {
    test('plain ASCII names are fine', () {
      final h = inspectHost('www.Example.com');
      expect(h.host, 'www.example.com');
      expect(h.homograph, isFalse);
      expect(h.international, isFalse);
      expect(h.ipAddress, isFalse);
    });

    test('mixed Latin and Cyrillic is a homograph', () {
      final h = inspectHost('xn--pple-43d.com');
      expect(h.display, 'аpple.com');
      expect(h.international, isTrue);
      expect(h.homograph, isTrue);
      expect(h.looksLike, 'apple.com');
      expect(h.scripts, {'Latin', 'Cyrillic'});
    });

    test('a whole label of look-alike Cyrillic is a homograph', () {
      final h = inspectHost('xn--80ak6aa92e.com');
      expect(h.display, 'аррӏе.com');
      expect(h.homograph, isTrue);
      expect(h.looksLike, 'apple.com');
    });

    test('Unicode written directly or percent-encoded (as Uri.host gives it)', () {
      expect(inspectHost('pаypal.com').homograph, isTrue);
      expect(inspectHost(Uri.parse('https://pаypal.com/').host).looksLike, 'paypal.com');
    });

    test('Greek and Latin look-alikes', () {
      expect(inspectHost('gοogle.com').homograph, isTrue); // Greek omicron
      expect(inspectHost('pɑypal.com').looksLike, 'paypal.com'); // Latin alpha U+0251
    });

    test('genuine international names are not homographs', () {
      for (final host in [
        'xn--mnchen-3ya.de', // münchen.de
        'bücher.example',
        'xn--p1ai', // рф
        'пример.рф', // Cyrillic under a Cyrillic TLD
        'кот.com', // a Russian word, not Latin look-alikes
        '例え.テスト',
        'abc日本.jp', // Latin with Han is allowed
      ]) {
        final h = inspectHost(host);
        expect(h.international, isTrue, reason: host);
        expect(h.homograph, isFalse, reason: host);
      }
    });

    test('IP literals', () {
      for (final host in ['192.168.0.1', '3232235777', '0xc0a80001', '[2001:db8::1]', '::1', '10.0.1']) {
        expect(inspectHost(host).ipAddress, isTrue, reason: host);
      }
      for (final host in ['example.com', '1password.com', '365.example']) {
        expect(inspectHost(host).ipAddress, isFalse, reason: host);
      }
    });
  });

  test('latinSkeleton', () {
    expect(latinSkeleton('Раураl'), 'paypal');
    expect(latinSkeleton('münchen'), 'münchen');
  });
}
