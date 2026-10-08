import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/search/search_session.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';
import '../conversation/fake_mail_repository.dart';

/// Counts the searches the session asks for.
class _CountingRepository extends FakeMailRepository {
  final requests = <SearchRequest>[];

  @override
  Stream<SearchResults> search(SearchRequest request) {
    requests.add(request);
    return super.search(request);
  }
}

void main() {
  group('a query that contradicts itself', () {
    Future<(SearchSession, _CountingRepository)> open(String query) async {
      final repo = _CountingRepository();
      final session = SearchSession(repository: repo, initialQuery: query);
      addTearDown(session.dispose);
      await pumpEventQueue();
      return (session, repo);
    }

    test('searches nothing, locally or on the server, and ends at once', () async {
      final (session, repo) = await open('from:alice and not from:alice');
      expect(repo.requests, isEmpty);
      expect(session.results!.items, isEmpty);
      expect(session.results!.isComplete, isTrue);
      expect(
        session.contradictionNote(lookupAppLocalizations(const Locale('en'))),
        'No message can be both “From: alice” and not.',
      );
    });

    test('read and unread is Schrödinger’s', () async {
      final (session, _) = await open('is:read and is:unread');
      expect(session.contradictionNote(lookupAppLocalizations(const Locale('en'))), startsWith('Schrödinger'));
    });

    test('other queries search as before, with no note', () async {
      final (session, repo) = await open('is:read and is:flagged');
      expect(repo.requests, hasLength(1));
      expect(session.contradictionNote(lookupAppLocalizations(const Locale('en'))), isNull);
    });
  });

  testWidgets('the results say why there are none', (tester) async {
    await pumpLoupe(tester);
    await goTo(tester, '/search?q=${Uri.encodeQueryComponent('is:read and is:unread')}');
    expect(find.text('No Results'), findsOneWidget);
    expect(find.text("Schrödinger's inbox: every message here is read and unread until you open it."), findsOneWidget);
  });
}
