import 'package:flutter_test/flutter_test.dart';
import 'package:readable/src/pipeline/css.dart';
import 'package:readable/src/pipeline/links.dart';
import 'package:readable/src/pipeline/original_html.dart';

void main() {
  group('parseStyle', () {
    test('lower-cases properties, drops !important, keeps data URIs intact', () {
      expect(parseStyle('COLOR: Red !important; background:url(data:image/png;base64,AA==) ;; bad'), {
        'color': 'Red',
        'background': 'url(data:image/png;base64,AA==)',
      });
    });
  });

  group('parseColor', () {
    test('formats', () {
      expect(parseColor('#fff'), 0xFFFFFFFF);
      expect(parseColor('#0A0B0C'), 0xFF0A0B0C);
      expect(parseColor('rgb(255, 0, 0)'), 0xFFFF0000);
      expect(parseColor('rgba(0,0,0,1.0)'), 0xFF000000);
      expect(parseColor('rgb(0 128 0 / 50%)'), 0xFF008000);
      expect(parseColor('hsl(120, 100%, 25%)'), 0xFF008000);
      expect(parseColor('DarkBlue'), 0xFF00008B);
      expect(parseColor('ffcc00'), 0xFFFFCC00);
      expect(parseColor('#fff url(x.png) no-repeat'), 0xFFFFFFFF);
    });

    test('transparent and unknown values are null', () {
      expect(parseColor('transparent'), isNull);
      expect(parseColor('rgba(0,0,0,0)'), isNull);
      expect(parseColor('inherit'), isNull);
      expect(parseColor('#ggg'), isNull);
    });
  });

  test('lengths and font sizes', () {
    expect(parseLength('12pt'), 16);
    expect(parseLength('2em', fontPx: 10), 20);
    expect(parseLength('50%'), isNull);
    expect(isZeroLength('0.0em'), isTrue);
    expect(isZeroLength('1px'), isFalse);
    expect(parseFontSize('150%', 16), 24);
    expect(parseFontSize('x-large', 16), 24);
    expect(legacyFontSize('+1'), 18);
    expect(scaleStep(9), 0.85);
    expect(scaleStep(16), 1.0);
    expect(scaleStep(28), 1.5);
  });

  test('monospace families', () {
    expect(isMonospaceFamily("'Courier New', monospace"), isTrue);
    expect(isMonospaceFamily('Arial, sans-serif'), isFalse);
  });

  group('links', () {
    test('safeHref', () {
      expect(safeHref(' https://a.example/x y '), 'https://a.example/x%20y');
      expect(safeHref('www.a.example'), 'https://www.a.example');
      expect(safeHref('JavaScript:alert(1)'), isNull);
      expect(safeHref('data:text/html,hi'), isNull);
      expect(safeHref('#top'), isNull);
      expect(safeHref('tel:+15551234'), 'tel:+15551234');
    });

    test('domainNamedIn', () {
      expect(domainNamedIn('Visit www.PayPal.com today'), 'www.paypal.com');
      expect(domainNamedIn('https://bank.example/login'), 'bank.example');
      expect(domainNamedIn('Click here'), isNull);
      expect(domainNamedIn('report.pdf'), isNull);
      expect(domainNamedIn('mail me@x.example'), isNull);
    });

    test('registrableDomain', () {
      expect(registrableDomain('a.b.example.com'), 'example.com');
      expect(registrableDomain('shop.example.co.uk'), 'example.co.uk');
    });

    test('linkMismatch', () {
      expect(linkMismatch('paypal.com', 'https://evil.example'), 'paypal.com');
      expect(linkMismatch('www.example.com', 'https://click.example.com/x'), isNull);
      expect(linkMismatch('Read more', 'https://evil.example'), isNull);
    });
  });

  group('Original view HTML', () {
    test('strips active content, counts remote images', () {
      final o = prepareOriginalHtml(
        '<html><head><style>p{color:red}</style><script>x()</script><meta http-equiv="refresh" content="0;url=https://x">'
        '</head><body onload="x()"><p onclick="y()">Hi</p><img src="https://r.example/a.png">'
        '<a href="javascript:z()">j</a><iframe src="https://f.example"></iframe><form action="https://p.example">'
        '<button>Go</button></form></body></html>',
      );
      expect(o.head, '<style>p{color:red}</style>');
      expect(o.body, isNot(contains('onload')));
      expect(o.body, isNot(contains('onclick')));
      expect(o.body, isNot(contains('javascript')));
      expect(o.body, isNot(contains('iframe')));
      expect(o.body, isNot(contains('action')));
      expect(o.remoteImages, 1);
    });

    test('CSP blocks remote loads unless allowed; cid images become data URIs', () {
      final o = prepareOriginalHtml('<img src="cid:logo@x">');
      final blocked = buildOriginalPage(o, allowRemote: false, cidDataUris: {'logo@x': 'data:image/png;base64,AA=='});
      expect(blocked, contains("default-src 'none'; img-src cid: data:; style-src 'unsafe-inline'"));
      expect(blocked, contains('src="data:image/png;base64,AA=="'));
      expect(blocked, contains('width=device-width'));
      expect(blocked, contains('img{max-width:100%'));
      final allowed = buildOriginalPage(o, allowRemote: true);
      expect(allowed, contains('img-src cid: data: https:;'));
      // The CSP comes before anything that could load.
      expect(allowed.indexOf('Content-Security-Policy'), lessThan(allowed.indexOf('<style>')));
    });
  });
}
