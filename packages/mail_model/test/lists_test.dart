import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  group('List-Id', () {
    test('phrase and identifier', () {
      expect(parseListId('Example developers <Dev.Lists.Example.org>'), (
        id: 'dev.lists.example.org',
        name: 'Example developers',
      ));
      expect(parseListId('"Open \\"Garden\\"" <garden.example>'), (id: 'garden.example', name: 'Open "Garden"'));
      expect(parseListId('<linux-kernel.vger.kernel.org>'), (id: 'linux-kernel.vger.kernel.org', name: null));
      expect(parseListId('Folded\r\n  name (a comment) <x.example>'), (id: 'x.example', name: 'Folded name'));
    });

    test('without brackets, or unusable', () {
      expect(parseListId(' bare.example.org '), (id: 'bare.example.org', name: null));
      expect(parseListId('just words'), isNull);
      expect(parseListId('Name <>'), isNull);
      expect(parseListId(''), isNull);
      expect(parseListId(null), isNull);
    });
  });

  group('List-Unsubscribe and List-Post', () {
    test('URIs in order, folding removed', () {
      final uris = parseListUris('<https://example.org/unsub?u=1&\r\n l=2>, (comment) <mailto:leave@example.org>');
      expect(uris.map((u) => u.toString()), ['https://example.org/unsub?u=1&l=2', 'mailto:leave@example.org']);
      expect(parseListUris('no brackets here'), isEmpty);
      expect(parseListUris(null), isEmpty);
    });

    test('the post address', () {
      expect(listPostAddress('<mailto:dev@lists.example.org>')?.email, 'dev@lists.example.org');
      expect(
        listPostAddress('<https://example.org/post>, <mailto:dev%2Bx@example.org?subject=hi>')?.email,
        'dev+x@example.org',
      );
      expect(listPostAddress('NO (posting not allowed)'), isNull);
      expect(listPostAddress(null), isNull);
    });

    test('one-click unsubscribe (RFC 8058)', () {
      expect(isOneClickUnsubscribe('List-Unsubscribe=One-Click'), isTrue);
      expect(isOneClickUnsubscribe(' list-unsubscribe = one-click '), isTrue);
      expect(isOneClickUnsubscribe('List-Unsubscribe=Later'), isFalse);
      expect(isOneClickUnsubscribe(null), isFalse);
    });
  });

  group('PatchTag', () {
    test('series, versions and prefixes', () {
      expect(PatchTag.parse('[PATCH] fix a leak'), const PatchTag());
      expect(PatchTag.parse('[PATCH v2 3/7] mm: tidy'), const PatchTag(version: 2, index: 3, total: 7));
      expect(PatchTag.parse('[PATCH 0/3] cover'), const PatchTag(index: 0, total: 3));
      expect(PatchTag.parse('[RFC PATCH net-next v3 02/12] x')!.label, 'RFC PATCH net-next v3 2/12');
      expect(PatchTag.parse('[PATCHv4 1/2] glued')!.label, 'PATCH v4 1/2');
      expect(PatchTag.parse('[PATCH 0/3] cover')!.isCoverLetter, isTrue);
    });

    test('list tags and replies before the tag', () {
      expect(PatchTag.parse('[dev] [PATCH 1/2] a')!.label, 'PATCH 1/2');
      final review = PatchTag.parse('Re: [dev] [PATCH v2 2/3] b')!;
      expect(review.isReply, isTrue);
      expect(review.label, 'PATCH v2 2/3');
      expect(PatchTag.parse('[dev] Re: [PATCH] c')!.isReply, isTrue);
    });

    test('subjects without a patch tag', () {
      expect(PatchTag.parse('Patch Tuesday notes'), isNull);
      expect(PatchTag.parse('[dev] Release planning'), isNull);
      expect(PatchTag.parse('Re: meeting [PATCH] later'), isNull);
      expect(PatchTag.parse(''), isNull);
    });
  });

  test('copyWith keeps the list headers', () {
    final e = EmailSummary(
      id: 'a',
      accountId: 'acc',
      mailboxId: 'm',
      receivedAt: DateTime(2026),
      listId: 'dev.lists.example.org',
      listName: 'Developers',
      listPost: '<mailto:dev@lists.example.org>',
      listUnsubscribe: '<https://lists.example.org/u>',
      listUnsubscribePost: 'List-Unsubscribe=One-Click',
    );
    final c = e.copyWith(keywords: {Keywords.seen});
    expect(c.isListMail, isTrue);
    expect(
      [c.listId, c.listName, c.listPost, c.listUnsubscribe, c.listUnsubscribePost],
      [e.listId, e.listName, e.listPost, e.listUnsubscribe, e.listUnsubscribePost],
    );
  });
}
