import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/pipeline/redirects.dart';

/// One real-world-shaped redirect: the link, who wraps it, where it ends up.
typedef Case = ({String name, String url, List<String> services, String? target, bool hidden, String? hint});

Case resolved(String name, String url, List<String> services, String target) =>
    (name: name, url: url, services: services, target: target, hidden: false, hint: null);

Case opaque(String name, String url, List<String> services, {String? hint}) =>
    (name: name, url: url, services: services, target: null, hidden: true, hint: hint);

final cases = <Case>[
  resolved(
    'Outlook Safe Links',
    'https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.example.com%2Fdocs%3Fid%3D7&data=05%7C02%7C'
        'sam%40contoso.com%7C6a1f%7C72f988bf%7C0%7C0%7C638612%7CUnknown&sdata=Zm9vYmFy%3D&reserved=0',
    ['Outlook Safe Links'],
    'https://www.example.com/docs?id=7',
  ),
  resolved(
    'Google url?q=',
    'https://www.google.com/url?q=https://example.org/report.pdf&sa=D&source=editors&ust=1728000000000000&usg=AOvVaw1x',
    ['Google'],
    'https://example.org/report.pdf',
  ),
  resolved(
    'Google url?url= on a country domain',
    'https://www.google.co.uk/url?sa=t&rct=j&url=https%3A%2F%2Fexample.co.uk%2Fnews&ved=2ahUKEw',
    ['Google'],
    'https://example.co.uk/news',
  ),
  resolved('Google AMP', 'https://www.google.com/amp/s/example.com/story/42', [
    'Google',
  ], 'https://example.com/story/42'),
  opaque(
    'Mimecast with a domain hint',
    'https://protect-eu.mimecast.com/s/Ab1CDe2FgHi3JkL4mNoP?domain=www.example.com',
    ['Mimecast'],
    hint: 'www.example.com',
  ),
  opaque('Mimecast without a hint', 'https://protect-us.mimecast.com/s/qwErTy12UiOp', ['Mimecast']),
  opaque('Mimecast protect domain', 'https://url.uk.m.mimecastprotect.com/s/AbCdEfGh?domain=portal.example.net', [
    'Mimecast',
  ], hint: 'portal.example.net'),
  resolved(
    'Proofpoint v1',
    'https://urldefense.proofpoint.com/v1/url?u=http%3A%2F%2Fwww.example.com%2Fa&k=abc%3D%0A&r=def&m=ghi&s=jkl',
    ['Proofpoint URL Defense'],
    'http://www.example.com/a',
  ),
  resolved(
    'Proofpoint v2',
    'https://urldefense.proofpoint.com/v2/url?u=https-3A__www.example.com_path_to-5Fpage-3Fa-3D1-26b-3D2&d=DwMFaQ'
        '&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=abc&m=def&s=ghi&e=',
    ['Proofpoint URL Defense'],
    'https://www.example.com/path/to_page?a=1&b=2',
  ),
  resolved(
    'Proofpoint v3 without replacements',
    'https://urldefense.com/v3/__https://www.example.com/path?a=1__;!!ABcDeF!GhIjKl\$',
    ['Proofpoint URL Defense'],
    'https://www.example.com/path?a=1',
  ),
  resolved(
    'Proofpoint v3 with one replaced character',
    'https://urldefense.com/v3/__https://www.example.com/page*section__;Iw!!ABcDeF!GhIjKl\$',
    ['Proofpoint URL Defense'],
    'https://www.example.com/page#section',
  ),
  resolved('Proofpoint v3 with a run', 'https://urldefense.com/v3/__https://example.com/a**Ab__;JiY!!ABcDeF!GhIjKl\$', [
    'Proofpoint URL Defense',
  ], 'https://example.com/a&&b'),
  resolved('Facebook', 'https://l.facebook.com/l.php?u=https%3A%2F%2Fexample.com%2Fevent%3Ffbclid%3DIwAR0&h=AT0abc', [
    'Facebook',
  ], 'https://example.com/event?fbclid=IwAR0'),
  resolved('Instagram', 'https://l.instagram.com/?u=https%3A%2F%2Fshop.example%2F&e=ATM', [
    'Instagram',
  ], 'https://shop.example/'),
  resolved(
    'LinkedIn',
    'https://www.linkedin.com/redir/redirect?url=https%3A%2F%2Fexample.com%2Fjobs&urlhash=Ab1c&trk=public_profile',
    ['LinkedIn'],
    'https://example.com/jobs',
  ),
  opaque('LinkedIn short link', 'https://www.linkedin.com/slink?code=gXyZ123', ['LinkedIn']),
  opaque('Mailchimp', 'https://fieldnotes.us21.list-manage.com/track/click?u=0b1c2d3e4f&id=5a6b7c8d9e&e=1f2e3d4c5b', [
    'Mailchimp',
  ]),
  opaque(
    'SendGrid',
    'https://u1234567.ct.sendgrid.net/ls/click?upn=u001.Zk9vQmFyQmF6UXV4LTJGLTJGZXhhbXBsZQ-3D-3D_xyz',
    ['SendGrid'],
  ),
  resolved(
    'SendGrid with a decodable token',
    'https://ct.sendgrid.net/ls/click?upn=aHR0cHM6Ly9leGFtcGxlLmNvbS9vZmZlcj9pZD0x',
    ['SendGrid'],
    'https://example.com/offer?id=1',
  ),
  opaque('SendGrid on a branded link domain', 'https://url4425.news.example.com/ls/click?upn=u001.QWJjZGVm-2BgH', [
    'SendGrid',
  ]),
  opaque('Klaviyo', 'https://trk.klclick.com/ls/click?upn=u001.YWJjZGVmZ2g-3D', ['Klaviyo']),
  opaque('HubSpot', 'https://d2v8tf04.na1.hubspotlinks.com/Ctc/RG+113/d2v8tf04/VW1Kxl3Xg8dCW8Q0', ['HubSpot']),
  opaque('HubSpot Sales', 'https://t.sidekickopen06.com/s1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs', ['HubSpot']),
  opaque('HubSpot CTA', 'https://cta-redirect.hubspot.com/cta/redirect/2252258/aa9fbd7c-1b2b', ['HubSpot']),
  resolved(
    'Amazon SES (path encoding)',
    'https://8q6v2v7r.r.us-east-1.awstrack.me/L0/https:%2F%2Fwww.example.com%2Fissue%2F42%3Futm_source=ses/1/'
        '0100018f-1b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e-000000/AbCdEfGhIj=383',
    ['Amazon SES'],
    'https://www.example.com/issue/42?utm_source=ses',
  ),
  opaque(
    'Mandrill with a domain in the path',
    'https://mandrillapp.com/track/click/30363097/www.example.com?p=bm90IGpzb24',
    ['Mandrill'],
    hint: 'www.example.com',
  ),
  (
    name: 'Mandrill with base64 JSON',
    url:
        'https://mandrillapp.com/track/click/30363097/example.com?p=eyJwIjogIntcInVybFwiOiBcImh0dHBzOlxcL1xcL2V4YW1wbGUu'
        'Y29tXFwvc2FsZVwifSJ9',
    services: ['Mandrill'],
    target: 'https://example.com/sale',
    hidden: false,
    hint: 'example.com',
  ),
  resolved('YouTube', 'https://www.youtube.com/redirect?event=video_description&q=https%3A%2F%2Fexample.com%2F', [
    'YouTube',
  ], 'https://example.com/'),
  resolved('Slack', 'https://slack-redir.net/link?url=https%3A%2F%2Fexample.com%2Fx', [
    'Slack',
  ], 'https://example.com/x'),
  resolved('Barracuda', 'https://linkprotect.cudasvc.com/url?a=https%3a%2f%2fexample.com%2flogin&c=E,1,abc&typo=1', [
    'Barracuda Link Protection',
  ], 'https://example.com/login'),
  // Generic parameters.
  resolved('generic url=', 'https://click.example.net/out?url=https%3A%2F%2Fexample.org%2F', [
    'click.example.net',
  ], 'https://example.org/'),
  resolved('generic redirect=', 'https://go.example.net/r?redirect=https://example.org/page&id=3', [
    'go.example.net',
  ], 'https://example.org/page'),
  resolved('generic u=', 'http://t.example.net/c?u=https%3A%2F%2Fexample.org%2Fa%2Bb', [
    't.example.net',
  ], 'https://example.org/a+b'),
  // Nested and double-encoded.
  resolved(
    'Safe Links around Google',
    'https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.google.com%2Furl%3Fq%3Dhttps%253A%252F%252F'
        'example.com%252Fa%253Fb%253D1%26sa%3DD&data=05%7C01&reserved=0',
    ['Outlook Safe Links', 'Google'],
    'https://example.com/a?b=1',
  ),
  resolved(
    'double-encoded value',
    'https://nam04.safelinks.protection.outlook.com/?url=https%253A%252F%252Fexample.com%252Fdeep&data=x',
    ['Outlook Safe Links'],
    'https://example.com/deep',
  ),
  resolved(
    'Proofpoint v2 around Safe Links around SES',
    'https://urldefense.proofpoint.com/v2/url?u=https-3A__nam12.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A'
        '-252F-252Fabc.r.us-2Deast-2D1.awstrack.me-252FL0-252Fhttps-253A-25252F-25252Fexample.com-25252Fx-252F1-252Fid'
        '-26reserved-3D0&d=DwMFaQ&c=x&r=y&m=z&s=w&e=',
    ['Proofpoint URL Defense', 'Outlook Safe Links', 'Amazon SES'],
    'https://example.com/x',
  ),
  (
    name: 'Safe Links around Mailchimp',
    url:
        'https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fnews.us5.list-manage.com%2Ftrack%2Fclick'
        '%3Fu%3Dabc%26id%3Ddef&data=05&reserved=0',
    services: ['Outlook Safe Links', 'Mailchimp'],
    target: 'https://news.us5.list-manage.com/track/click?u=abc&id=def',
    hidden: true,
    hint: null,
  ),
];

void main() {
  group('unwrapRedirect', () {
    for (final c in cases) {
      test(c.name, () {
        final r = unwrapRedirect(c.url);
        expect(r, isNotNull);
        expect(r!.services, c.services);
        expect(r.target, c.target);
        expect(r.hidden, c.hidden);
        expect(r.hostHint, c.hint);
        expect(r.resolved, c.target != null && !c.hidden);
      });
    }

    test('ordinary links are not redirects', () {
      for (final url in [
        'https://example.com/',
        'https://www.example.com/search?q=shoes',
        'https://www.google.com/search?q=https://example.com',
        'https://accounts.example.com/login?next=/home',
        'https://example.com/a?u=not-a-url',
        'https://example.com/a?url=https://example.com/b',
        'https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fexample.com',
        'https://twitter.com/intent/tweet?url=https%3A%2F%2Fexample.com',
        'mailto:someone@example.com',
        'javascript:alert(1)',
        'https://www.linkedin.com/in/someone',
      ]) {
        expect(unwrapRedirect(url), isNull, reason: url);
      }
    });

    test('never yields anything but http(s)', () {
      expect(unwrapRedirect('https://www.google.com/url?q=javascript:alert(1)')?.target, isNull);
      expect(unwrapRedirect('https://click.example.net/out?url=data:text/html,hi'), isNull);
      expect(unwrapRedirect('https://eur01.safelinks.protection.outlook.com/?url=file%3A%2F%2F%2Fetc')?.target, isNull);
    });

    test('known, tracking and protection', () {
      final safeLinks = unwrapRedirect(cases.firstWhere((c) => c.name == 'Outlook Safe Links').url)!;
      expect(safeLinks.known, isTrue);
      expect(safeLinks.protection, isTrue);
      expect(safeLinks.tracking, isFalse);
      final mailchimp = unwrapRedirect(cases.firstWhere((c) => c.name == 'Mailchimp').url)!;
      expect(mailchimp.tracking, isTrue);
      expect(mailchimp.destinationHost, isNull);
      final generic = unwrapRedirect('https://click.example.net/out?url=https%3A%2F%2Fexample.org%2F')!;
      expect(generic.known, isFalse);
      final mimecast = unwrapRedirect('https://protect-eu.mimecast.com/s/Ab1?domain=www.example.com')!;
      expect(mimecast.destinationHost, 'www.example.com');
    });

    test('direct drops tracking parameters', () {
      final r = unwrapRedirect(cases.firstWhere((c) => c.name == 'Amazon SES (path encoding)').url)!;
      expect(r.direct, 'https://www.example.com/issue/42');
      expect(unwrapRedirect(cases.firstWhere((c) => c.name == 'Mailchimp').url)!.direct, isNull);
    });
  });

  test('stripTrackingParameters', () {
    expect(stripTrackingParameters('https://a.example/x'), 'https://a.example/x');
    expect(
      stripTrackingParameters('https://a.example/x?utm_source=n&id=4&UTM_Medium=e&mc_eid=9#top'),
      'https://a.example/x?id=4#top',
    );
    expect(stripTrackingParameters('https://a.example/?fbclid=1&gclid=2'), 'https://a.example/');
    expect(stripTrackingParameters('https://a.example/?_hsenc=p2A&_hsmi=1&page=2'), 'https://a.example/?page=2');
  });
}
