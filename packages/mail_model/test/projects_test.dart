import 'package:mail_model/mail_model.dart';
import 'package:test/test.dart';

void main() {
  test('project keywords: valid ids only, case-insensitive, not shown as tags', () {
    expect(Projects.keyword('lq3k2x1a9b'), r'$loupe-project-lq3k2x1a9b');
    expect(Projects.idOf(r'$Loupe-Project-LQ3K2X1A9B'), 'lq3k2x1a9b');
    expect(Projects.idOf(r'$label1'), isNull);
    expect(Projects.idOf(r'$loupe-project-'), isNull);
    expect(Projects.isValidId('house_2026-move'), isTrue);
    for (final bad in ['', 'House', 'a b', 'x(y)', 'é', 'a' * 65]) {
      expect(Projects.isValidId(bad), isFalse, reason: bad);
    }
    final e = EmailSummary(
      id: 'a|INBOX|1|1',
      accountId: 'a',
      mailboxId: 'a|INBOX',
      receivedAt: DateTime.utc(2026),
      keywords: {Keywords.seen, Keywords.label2, Projects.keyword('house'), Projects.keyword('tax')},
    );
    expect(e.tags, [Keywords.label2]);
    expect(e.projectIds, {'house', 'tax'});
  });
}
