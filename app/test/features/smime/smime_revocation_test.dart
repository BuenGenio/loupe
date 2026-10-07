import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/app.dart';
import 'package:loupe/features/smime/smime_revocation.dart';
import 'package:loupe/router.dart';
import 'package:loupe/settings/app_settings.dart';
import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';
import '../conversation/test_app.dart';
import '../openpgp/openpgp_test_support.dart';
import 'smime_test_support.dart';

/// mail_crypto's revocation vectors: a CA with an OCSP responder, Gail (good) and Rex (revoked).
Uint8List revocationFixture(String name) => File('$smimeFixtures/revocation/$name').readAsBytesSync();

final revocationCa = readCertificates(revocationFixture('ca.crt')).single;

/// The CA's OCSP responder, faked: Gail is good, Rex revoked.
final class FakeAuthority implements SmimeRevocationFetcher {
  final asked = <Uri>[];

  @override
  Future<Uint8List> postOcsp(Uri url, Uint8List request, {required int maxBytes}) async {
    asked.add(url);
    final gail = readCertificates(revocationFixture('gail.crt')).single;
    final isGail = listEquals(request, ocspRequest(gail, revocationCa));
    return revocationFixture(isGail ? 'ocsp-good.der' : 'ocsp-revoked.der');
  }

  @override
  Future<Uint8List> getCrl(Uri url, {required int maxBytes}) async => throw const SocketException('not here');
}

bool listEquals(List<int> a, List<int> b) =>
    a.length == b.length && [for (var i = 0; i < a.length; i++) a[i] == b[i]].every((x) => x);

void main() {
  Future<FakeAuthority> open(WidgetTester tester, String who, {bool check = true}) async {
    final authority = FakeAuthority();
    final raw = latin1.decode(revocationFixture('signed-$who.eml'));
    final storage = await smimeKeychain(trusted: [revocationCa]);
    final repo = FakeMailRepository(
      emails: [
        testEmail('m1', from: EmailAddress('$who@revocation.test', who), to: const [bobAddress], subject: 'Signed'),
      ],
      contents: {'m1': serverContent('m1', raw)},
    )..rawSources['m1'] = raw;
    final router = await pumpTestApp(
      tester,
      repository: repo,
      prefs: {if (check) CheckRevocation.key: true},
      overrides: [inlinePgp, keychain(storage), revocationFetcherProvider.overrideWithValue(authority)],
    );
    unawaited(router.push('/message/m1'));
    await tester.pumpAndSettle();
    return authority;
  }

  testWidgets('off (the default): nobody is asked', (tester) async {
    final authority = await open(tester, 'rex', check: false);
    expect(textContaining('Signed by Rex Revoked ✓'), findsOneWidget);
    expect(authority.asked, isEmpty);
    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(textContaining('Revocation isn’t checked'), findsOneWidget);
  });

  testWidgets('on: a revoked certificate shows as revoked, with the authority’s reason', (tester) async {
    final authority = await open(tester, 'rex');
    expect(authority.asked, [Uri.parse('http://ocsp.revocation.test/')]);
    expect(textContaining('Signed by Rex Revoked · certificate revoked'), findsOneWidget);
    expect(textContaining('✓'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(find.text('Revoked'), findsOneWidget);
    expect(textContaining('key compromise'), findsWidgets);
    expect(textContaining('revoked the signer’s certificate'), findsOneWidget);
  });

  testWidgets('on: a good one keeps its ✓, and the sheet says it was asked', (tester) async {
    await open(tester, 'gail');
    expect(textContaining('Signed by Gail Good ✓'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(find.text('Not revoked'), findsOneWidget);
    expect(textContaining('Asked the authority (OCSP)'), findsOneWidget);
  });

  testWidgets('a certificate from an authority Loupe doesn’t trust: its server is never asked', (tester) async {
    final authority = FakeAuthority();
    final raw = latin1.decode(revocationFixture('signed-rex.eml'));
    final repo = FakeMailRepository(
      emails: [
        testEmail('m1', from: const EmailAddress('rex@revocation.test', 'Rex'), to: const [bobAddress]),
      ],
      contents: {'m1': serverContent('m1', raw)},
    )..rawSources['m1'] = raw;
    final router = await pumpTestApp(
      tester,
      repository: repo,
      prefs: {CheckRevocation.key: true},
      overrides: [inlinePgp, keychain(await smimeKeychain()), revocationFetcherProvider.overrideWithValue(authority)],
    );
    unawaited(router.push('/message/m1'));
    await tester.pumpAndSettle();
    expect(textContaining('not trusted'), findsOneWidget);
    expect(authority.asked, isEmpty);
    await tester.tap(find.byKey(const ValueKey('smime-status-m1')));
    await tester.pumpAndSettle();
    expect(textContaining('only certificates from an authority Loupe trusts'), findsOneWidget);
  });

  testWidgets('Settings: the switch, off by default, says what it reveals', (tester) async {
    await pumpLoupe(tester, overrides: [inlinePgp]);
    await goTo(tester, Routes.encryption);
    final row = find.byKey(const ValueKey('smime-check-revocation'));
    await tester.scrollTo(row);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    expect(textContaining('The authority can then see when someone'), findsOneWidget);
    final container = ProviderScope.containerOf(tester.element(find.byType(LoupeApp)));
    expect(container.read(checkRevocationProvider), isFalse);
    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(container.read(checkRevocationProvider), isTrue);
    expect(container.read(sharedPreferencesProvider).getBool(CheckRevocation.key), isTrue);
    await drainTimers(tester);
  });
}
