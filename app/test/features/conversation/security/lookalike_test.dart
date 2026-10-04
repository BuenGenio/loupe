import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/conversation/security/lookalike.dart';

void main() {
  const own = ['northwind.example', 'gmail.com'];

  Lookalike? check(String domain) => findLookalike(domain, ownDomains: own);

  test('near-identical spellings of brands are strong look-alikes', () {
    for (final (domain, imitates) in [
      ('paypa1.com', 'paypal.com'), // digit for letter
      ('paypai.com', 'paypal.com'), // i for l
      ('rnicrosoft.com', 'microsoft.com'), // rn for m
      ('micorsoft.com', 'microsoft.com'), // swapped neighbours
      ('paypall.com', 'paypal.com'), // doubled letter
      ('gogle.com', 'google.com'), // undoubled letter
      ('xn--pple-43d.com', 'apple.com'), // Cyrillic а
      ('amaz0n-mail.net', 'amazon.com'), // digit, and a hyphenated word
      ('0utlook.com', 'outlook.com'), // another domain of a brand
    ]) {
      final l = check(domain);
      expect(l, isNotNull, reason: domain);
      expect(l!.strong, isTrue, reason: domain);
      expect(l.imitates, imitates, reason: domain);
    }
  });

  test('a brand with a phishing word is a weak look-alike', () {
    for (final domain in [
      'paypal-secure.com',
      'secure-paypal-login.net',
      'applesupport.co',
      'paypal.com.verify.example',
    ]) {
      final l = check(domain);
      expect(l, isNotNull, reason: domain);
      expect(l!.strong, isFalse, reason: domain);
    }
  });

  test("look-alikes of the user's own domain", () {
    final l = check('northwlnd.example')!;
    expect(l.own, isTrue);
    expect(l.strong, isTrue);
    expect(l.imitates, 'northwind.example');
    expect(check('n0rthwind.example')?.own, isTrue);
    expect(check('northwind-helpdesk.example')?.strong, isFalse);
  });

  test('the real thing and ordinary names are not look-alikes', () {
    for (final domain in [
      'paypal.com',
      'mail.paypal.com',
      'email.apple.com',
      'paypal.de', // the brand's own country site
      'amazon.co.uk',
      'northwind.example',
      'it.northwind.example',
      'cooking.com', // one letter from booking, but a real word
      'applebees.com',
      'pineapple.example',
      'apple-farm.example',
      'paypal-community.com',
      'example.org',
      'gmail.com',
      '192.0.2.1',
    ]) {
      expect(check(domain), isNull, reason: domain);
    }
  });

  test('a free mail domain of the user is not treated as their organisation', () {
    // gmail.com is covered as Google's; "gmall" imitates it as a brand.
    final l = check('gmai1.com')!;
    expect(l.own, isFalse);
    expect(l.name, 'Google');
  });
}
