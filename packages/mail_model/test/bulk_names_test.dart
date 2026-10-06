import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  group('looksMachineMade', () {
    test('the List-Ids and phrases of the owner’s newsletters', () {
      for (final id in [
        'MTEyNzQxMzMtODAtNQ==',
        '111929.broadcast',
        'cac06e6fcbbfef544827181d7mc list',
        'spc.265094.4.sparkpostmail.com',
        '1175803732',
        'NTE4NjMwOC0yNDA1MC00MA==',
        'NTE4NjMwOC0yNDA1MC00MQ==',
      ]) {
        expect(looksMachineMade(id), isTrue, reason: id);
      }
    });

    test('other bulk-mail services’ identifiers', () {
      for (final id in [
        // Mailchimp
        '2a8f1e3b5c7d9e0f1a2b3c4d5.123456.list-id.mcsv.net',
        '0f1e2d3c4b5a69788796a5b4cmc list',
        'us5.list-manage.com',
        'mc.us12.list-manage2.com',
        // SendGrid, Salesforce Marketing Cloud, Constant Contact, Campaign Monitor
        '8936203.ct.sendgrid.net',
        'u1234567.wl.sendgrid.net',
        '7234567_123456.xt.local',
        '1102345678901.list-id.constantcontact.com',
        'abcdef.createsend.com',
        // Sendsay, HubSpot, Klaviyo, Mailgun, Amazon SES
        'news.sendsay',
        'shop.sendsay.ru',
        'x9.hubspotemail.net',
        'list.klaviyomail.com',
        'mg.mailgun.org',
        'bounces.amazonses.com',
        // Shapes rather than hosts
        '5f2b1c9e-3a4d-4e8b-9c1d-2e3f4a5b6c7d',
        'a1b2c3d4e5f6a7b8',
        'YWJjZGVmZ2hpams',
        'MTEyNzQxMzMtODAtNQ',
        'list-12345678',
        'n4567.8901',
        '5186308-24050-40',
        '2024',
        '',
        '   ',
        '★★★',
      ]) {
        expect(looksMachineMade(id), isTrue, reason: id);
      }
    });

    test('names people chose', () {
      for (final name in [
        'HSBC',
        'Linear',
        'Kestrel developers',
        'Open Garden development',
        'Field Notes Weekly',
        'The Verge',
        'TechCrunch',
        'Substack',
        'Facebook',
        'Newsletter',
        'Announcements',
        'GitHub',
        'owner/repo',
        'rust-lang/rust',
        'Python-Dev',
        'linux-kernel',
        'iPhoneDealsUK',
        '1Password',
        '7-Eleven',
        '3M',
        'Web3 Weekly',
        'Order 4711 updates',
        'Сбербанк',
        'Новости недели',
        '日本経済新聞',
        'dev.lists.example.org',
        'linux-kernel.vger.kernel.org',
        'debian-devel.lists.debian.org',
        'python-dev.python.org',
        'nameofpub.substack.com',
        'Amazon.com',
      ]) {
        expect(looksMachineMade(name), isFalse, reason: name);
      }
    });

    test('humanName: trimmed, never an address or an identifier', () {
      expect(humanName('  Field   Notes '), 'Field Notes');
      expect(humanName('news@shop.example'), isNull);
      expect(humanName('NTE4NjMwOC0yNDA1MC00MA=='), isNull);
      expect(humanName(null), isNull);
      expect(humanName(''), isNull);
    });
  });

  group('sender addresses', () {
    test('registrable domains', () {
      expect(registrableDomainOf('mail.linear.app'), 'linear.app');
      expect(registrableDomainOf('linear.app'), 'linear.app');
      expect(registrableDomainOf('news.hsbc.co.uk'), 'hsbc.co.uk');
      expect(registrableDomainOf('Em.Shop.Example.'), 'shop.example');
      expect(registrableDomainOf('localhost'), 'localhost');
    });

    test('normalised: lower case, no +tag', () {
      expect(normalizeSenderAddress(' News+Spring@Shop.Example '), 'news@shop.example');
      expect(normalizeSenderAddress('news@shop.example'), 'news@shop.example');
      expect(normalizeSenderAddress('+x@shop.example'), '+x@shop.example');
    });

    test('per-campaign addresses', () {
      for (final a in [
        '5186308-24050-40@sendsay.example',
        'reply-fec01672766d0c7b7b@em.shop.example',
        'msprvs1=17abc=bounces-123@shop.example',
        'u123456@shop.example',
        'news@em-123456.shop.example',
        'news@a1b2c3d4e5f6a7b8.shop.example',
      ]) {
        expect(isPerCampaignAddress(a), isTrue, reason: a);
      }
      for (final a in [
        'news@shop.example',
        'no-reply@accounts.example',
        'newsletter2024@shop.example',
        'hello@mail.linear.app',
        'alerts@news.hsbc.co.uk',
      ]) {
        expect(isPerCampaignAddress(a), isFalse, reason: a);
      }
    });
  });
}
