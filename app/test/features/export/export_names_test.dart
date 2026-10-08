import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/export/export_names.dart';

void main() {
  group('saved messages are named after their subject', () {
    test('as <subject>.eml', () {
      expect(messageFileName('Quarterly report'), 'Quarterly report.eml');
      expect(messageFileName('Café — 東京 🎉'), 'Café — 東京 🎉.eml');
    });

    test('without characters file systems refuse', () {
      expect(messageFileName('Re: Invoice 3/2026 <draft> "final"?'), 'Re_ Invoice 3_2026 _draft_ _final__.eml');
      expect(messageFileName(r'C:\Temp*|x'), 'C__Temp__x.eml');
      expect(messageFileName('Tab\there\r\nand a new line\u0007'), 'Tab here and a new line_.eml');
    });

    test('with white space collapsed and no leading dots or trailing dots and spaces', () {
      expect(messageFileName('  Many    spaces  '), 'Many spaces.eml');
      expect(messageFileName('...hidden'), 'hidden.eml');
      expect(messageFileName('Ends with dots...'), 'Ends with dots.eml');
    });

    test('cut to 80 characters, never inside an emoji', () {
      final long = 'A' * 100;
      expect(messageFileName(long), '${'A' * 80}.eml');
      final emoji = '${'B' * 79}🎉🎉';
      expect(messageFileName(emoji), '${'B' * 79}🎉.eml');
      expect(messageFileName('${'C' * 79} tail'), '${'C' * 79}.eml', reason: 'no trailing space after cutting');
    });

    test('message.eml when nothing is left', () {
      expect(messageFileName(''), 'message.eml');
      expect(messageFileName('   '), 'message.eml');
      // An encrypted message whose protected subject wasn't decrypted.
      expect(messageFileName('...'), 'message.eml');
    });
  });

  group('exported folders', () {
    test('are named <account> - <folder>.mbox', () {
      expect(folderFileName('Work', 'Inbox'), 'Work - Inbox.mbox');
      expect(folderFileName('Home: Family', 'Trips/2026'), 'Home_ Family - Trips_2026.mbox');
      expect(folderFileName('', 'Archive'), 'Archive.mbox');
      expect(folderFileName('', ''), 'mail.mbox');
    });

    test('with each part cut to half the length', () {
      final name = folderFileName('A' * 60, 'F' * 60);
      expect(name, '${'A' * 40} - ${'F' * 40}.mbox');
    });
  });
}
