import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/search/search_session.dart';

import '../conversation/fake_mail_repository.dart';

void main() {
  test('a failed search ends instead of searching forever', () async {
    final errors = <Object>[];
    await runZonedGuarded(() async {
      final repo = FakeMailRepository()..searchError = StateError('database is locked');
      final session = SearchSession(repository: repo, initialQuery: 'invoice');
      addTearDown(session.dispose);
      await pumpEventQueue();
      expect(session.results, isNotNull, reason: 'not "Searching…"');
      expect(session.results!.items, isEmpty);
      expect(session.results!.isComplete, isTrue);
    }, (e, _) => errors.add(e));
    expect(errors, isEmpty, reason: 'the error is handled, not left to the zone');
  });
}
