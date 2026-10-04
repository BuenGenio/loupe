import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:expr_search/expr_search.dart';
import 'package:mail_model/mail_model.dart';
import 'package:mail_store/mail_store.dart';
import 'package:mail_store/src/search_sql.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  group('ftsMatchQuery', () {
    test('quotes every token and makes each a prefix', () {
      expect(ftsMatchQuery('Invoice 42', ['subject']), '{subject} : "Invoice"* + "42"*');
      expect(ftsMatchQuery('a"b', ['body']), '{body} : "a"* + "b"*');
      expect(ftsMatchQuery('  ', ['body']), isNull);
      expect(ftsMatchQuery('"*()-^:', ['body']), isNull);
      expect(ftsMatchQuery('Ünïcödé café', ['body']), '{body} : "Ünïcödé"* + "café"*');
    });
  });

  group('translateSearch', () {
    test('pushes negation down and widens unsupported terms', () {
      final c = translateSearch(
        const SearchNot(SearchAnd([KeywordTerm(Keywords.seen), RegexTerm(SearchField.subject, 'x+')])),
      );
      expect(c.sql, '(NOT (e.is_seen = 1) OR 1)');
      expect(c.needsPostFilter, isTrue);
      expect(translateSearch(const KeywordTerm('Work')).args, ['work']);
    });
  });

  group('search', () {
    late MailStore store;
    setUp(() async {
      store = await seededStore(
        accounts: [
          account(),
          account(id: 'acc2', email: 'you@home.test', name: 'Home'),
        ],
      );
      await addMails(store, [
        mail(1, subject: 'Invoice 2026-42', from: 'billing@shop.test', fromName: 'Shop', minutes: 1, size: 50000),
        mail(2, subject: 'Lunch on Friday?', preview: 'Shall we try the new café', minutes: 2, keywords: {r'$label1'}),
        mail(3, subject: 'Re: Invoice', from: 'bob@x.test', fromName: 'Bob Builder', cc: ['carol@x.test'], minutes: 3),
        mail(4, subject: 'Holiday photos', hasAttachment: true, minutes: 60 * 24 * 3, keywords: {Keywords.seen}),
        mail(5, path: 'Work', subject: 'Quarterly report', minutes: 4, size: 200),
        mail(6, account: 'acc2', subject: 'Invoice from home', minutes: 5),
        mail(7, subject: r'Weird "quotes" * and NEAR(x) {subject}: -minus ^caret', minutes: 6),
      ]);
    });

    Future<List<String>> run(SearchExpr expr, {SearchScope scope = const AllMailboxesScope(), int limit = 200}) async =>
        [for (final e in await store.search(expr, scope: scope, limit: limit)) e.subject];

    test('text terms with column filters and prefixes', () async {
      expect(await run(const TextTerm(SearchField.subject, 'invo')), [
        'Invoice from home',
        'Re: Invoice',
        'Invoice 2026-42',
      ]);
      expect(await run(const TextTerm(SearchField.from, 'bob build')), ['Re: Invoice']);
      expect(await run(const TextTerm(SearchField.from, 'billing@shop.test')), ['Invoice 2026-42']);
      expect(await run(const TextTerm(SearchField.cc, 'carol')), ['Re: Invoice']);
      expect(await run(const TextTerm(SearchField.participants, 'carol')), ['Re: Invoice']);
      expect(await run(const TextTerm(SearchField.body, 'cafe')), ['Lunch on Friday?'], reason: 'diacritics folded');
      expect(await run(const TextTerm(SearchField.any, 'friday')), ['Lunch on Friday?']);
      expect(await run(const TextTerm(SearchField.subject, '2026-42')), ['Invoice 2026-42']);
      expect(await run(const TextTerm(SearchField.subject, 'invoice'), limit: 1), ['Invoice from home']);
    });

    test('boolean structure', () async {
      expect(
        await run(
          const SearchAnd([TextTerm(SearchField.subject, 'invoice'), SearchNot(TextTerm(SearchField.from, 'bob'))]),
        ),
        ['Invoice from home', 'Invoice 2026-42'],
      );
      expect(
        await run(const SearchOr([TextTerm(SearchField.subject, 'lunch'), TextTerm(SearchField.subject, 'holiday')])),
        ['Holiday photos', 'Lunch on Friday?'],
      );
      expect(await run(const SearchOr([])), isEmpty);
      expect(await run(const MatchAll()), hasLength(7));
    });

    test('keywords, dates, size, attachments and accounts', () async {
      expect(await run(const KeywordTerm(r'$Label1')), ['Lunch on Friday?']);
      expect(await run(const SearchNot(KeywordTerm(Keywords.seen))), hasLength(6));
      expect(await run(const KeywordTerm(Keywords.seen)), ['Holiday photos']);
      expect(await run(DateTerm(DateComparison.on, base)), hasLength(6));
      expect(await run(DateTerm(DateComparison.onOrAfter, base.add(const Duration(days: 1)))), ['Holiday photos']);
      expect(await run(DateTerm(DateComparison.before, base)), isEmpty);
      expect(await run(DateTerm(DateComparison.on, DateTime(2026, 9, 4))), ['Holiday photos']);
      expect(await run(const SizeTerm(SizeComparison.larger, 10000)), ['Invoice 2026-42']);
      expect(await run(const SizeTerm(SizeComparison.smaller, 500)), ['Quarterly report']);
      expect(await run(const HasAttachmentTerm()), ['Holiday photos']);
      expect(await run(const AccountTerm('HOME')), ['Invoice from home']);
      expect(await run(const AccountTerm('me@example')), hasLength(6));
    });

    test('scopes', () async {
      final work = MailboxScope(RealMailboxRef(mbox('Work')));
      expect(await run(const MatchAll(), scope: work), ['Quarterly report']);
      expect(await run(const TextTerm(SearchField.subject, 'invoice'), scope: work), isEmpty);
      const inboxes = MailboxScope(VirtualMailboxRef(VirtualMailbox.allInboxes));
      expect(await run(const TextTerm(SearchField.subject, 'invoice'), scope: inboxes), hasLength(3));
    });

    test('regex and unknown headers are widened in SQL and post-filtered', () async {
      await store.putContent(
        EmailContent(emailId: eid('INBOX', 2), text: 'x', headers: const [('List-Id', '<news.example.com>')]),
      );
      // The expected rows are the SQL superset filtered by matchesEmail (with
      // cached content), whatever the matcher's current implementation.
      Future<List<String>> expected(SearchExpr expr, SearchExpr superset) async {
        final out = <String>[];
        for (final e in await store.search(superset)) {
          final c = await store.getContent(e.id);
          final headers = {for (final (n, v) in c?.headers ?? const <(String, String)>[]) n.toLowerCase(): v};
          if (matchesEmail(expr, e, content: c, headers: headers)) out.add(e.subject);
        }
        return out;
      }

      const regex = SearchAnd([RegexTerm(SearchField.subject, r'^Invoice \d+'), HasAttachmentTerm()]);
      expect(await run(regex), await expected(regex, const HasAttachmentTerm()));
      const header = HeaderTerm('List-Id', 'news');
      expect(await run(header), await expected(header, const MatchAll()));
      expect(translateSearch(header).needsPostFilter, isTrue);
      expect(await run(const HeaderTerm('Subject', 'holiday')), ['Holiday photos']);
    });

    test('hostile input is inert', () async {
      final evil = [
        "'; DROP TABLE emails; --",
        '" OR 1=1 --',
        'NEAR(a b)',
        '{subject} : x',
        'subject:x',
        '*',
        '"',
        '^caret',
        '-minus',
        'a AND b OR NOT c',
        r'\',
        '%',
        '_',
        '(((',
      ];
      for (final text in evil) {
        for (final field in SearchField.values) {
          await store.search(TextTerm(field, text));
        }
        await store.search(HeaderTerm('Message-ID', text));
        await store.search(AccountTerm(text));
        await store.search(KeywordTerm(text));
      }
      expect(await run(const MatchAll()), hasLength(7));
      expect(await run(const TextTerm(SearchField.subject, '"quotes" * and')), [startsWith('Weird')]);
      expect(await run(const TextTerm(SearchField.subject, 'NEAR(x)')), [startsWith('Weird')]);
      expect(await run(const TextTerm(SearchField.subject, '{subject}: -minus ^caret')), [startsWith('Weird')]);
      expect(await run(const HeaderTerm('Message-ID', '%')), isEmpty);
    });

    test('merges copies of one message across mailboxes', () async {
      await store.replaceMailboxes(accountId, [
        ...standardMailboxes,
        const RemoteMailbox(path: 'All Mail', name: 'All Mail', role: MailboxRole.all),
      ]);
      await addMails(store, [
        mail(10, messageId: 'dup@x', subject: 'Twice', minutes: 9),
        mail(10, path: 'All Mail', messageId: 'dup@x', subject: 'Twice', minutes: 9),
      ]);
      final hits = await store.search(const TextTerm(SearchField.subject, 'twice'));
      expect(hits.single.mailboxId, mbox('INBOX'));
    });
  });
}
