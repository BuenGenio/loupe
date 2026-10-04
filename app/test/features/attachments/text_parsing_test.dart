import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/csv.dart';
import 'package:loupe/features/attachments/ics.dart';
import 'package:loupe/features/attachments/text_decoding.dart';

void main() {
  group('decodeAttachmentText', () {
    test('reads valid UTF-8 as UTF-8', () {
      final d = decodeAttachmentText(utf8.encode('Grüße, 東京 🌧'));
      expect(d.text, 'Grüße, 東京 🌧');
      expect(d.charset, 'UTF-8');
    });

    test('falls back to Latin-1 (as Windows-1252) when the bytes are not UTF-8', () {
      final d = decodeAttachmentText([0x63, 0x61, 0x66, 0xE9, 0x20, 0x93, 0x71, 0x94, 0x20, 0x80, 0x35]);
      expect(d.text, 'café “q” €5');
      expect(d.charset, 'Latin-1');
    });

    test('honours byte-order marks', () {
      expect(decodeAttachmentText([0xEF, 0xBB, 0xBF, ...utf8.encode('bom')]).text, 'bom');
      final le = decodeAttachmentText([0xFF, 0xFE, 0x68, 0x00, 0xE9, 0x00]);
      expect((le.text, le.charset), ('hé', 'UTF-16'));
      expect(decodeAttachmentText([0xFE, 0xFF, 0x00, 0x68, 0x00, 0xE9]).text, 'hé');
    });

    test('decodes nothing to nothing', () => expect(decodeAttachmentText(const []).text, ''));

    test('headOfText cuts at a character boundary', () {
      final bytes = Uint8List.fromList(utf8.encode('aé')); // 61 C3 A9
      expect(headOfText(bytes, 2), [0x61]);
      expect(headOfText(bytes, 3), bytes);
      expect(headOfText(bytes, 10), bytes);
    });
  });

  group('parseCsv', () {
    test('splits rows and cells, with quotes, doubled quotes and line breaks in cells', () {
      final csv = parseCsv('Name,Note,Amount\r\n"Smith, Jo","said ""hi""\nthen left",12.50\r\nLee,,3\r\n');
      expect(csv.rows, [
        ['Name', 'Note', 'Amount'],
        ['Smith, Jo', 'said "hi"\nthen left', '12.50'],
        ['Lee', '', '3'],
      ]);
      expect(csv.columns, 3);
      expect(csv.delimiter, ',');
    });

    test('detects semicolons and tabs', () {
      expect(parseCsv('a;b;c\n1,5;2;3\n').rows, [
        ['a', 'b', 'c'],
        ['1,5', '2', '3'],
      ]);
      expect(parseCsv('a\tb\n1\t2').rows, [
        ['a', 'b'],
        ['1', '2'],
      ]);
      expect(detectCsvDelimiter('just one column\nline'), ',');
    });

    test('keeps a last line without a line break, and empty trailing cells', () {
      expect(parseCsv('a,b\nc,').rows, [
        ['a', 'b'],
        ['c', ''],
      ]);
      expect(parseCsv('').rows, isEmpty);
      expect(parseCsv('""').rows, [
        [''],
      ]);
    });

    test('stops after maxRows', () {
      final text = List.generate(100, (i) => '$i,x').join('\n');
      expect(parseCsv(text, maxRows: 10).rows.length, 10);
    });

    test('only small files fit the table', () {
      expect(parseCsv('a,b\n1,2').fitsTable, isTrue);
      expect(parseCsv('').fitsTable, isFalse);
      final tall = List.generate(CsvData.maxTableRows + 1, (i) => '$i').join('\n');
      expect(parseCsv(tall).fitsTable, isFalse);
      final wide = List.generate(CsvData.maxTableColumns + 1, (i) => '$i').join(',');
      expect(parseCsv(wide).fitsTable, isFalse);
    });
  });

  group('parseIcsEvents', () {
    test('reads title, place, organizer and times, unfolding and unescaping', () {
      final events = parseIcsEvents(
        'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nMETHOD:REQUEST\r\nBEGIN:VEVENT\r\n'
        'SUMMARY:Design review\\, round 2\r\n'
        'DTSTART;TZID=Europe/Berlin:20261006T140000\r\n'
        'DTEND;TZID=Europe/Berlin:20261006T153000\r\n'
        'LOCATION:Lighthouse\\; 3rd floor\\nBuilding A\r\n'
        'ORGANIZER;CN="Okafor, Dana":mailto:dana@example.com\r\n'
        'DESCRIPTION:A long description that is folded\r\n  over two lines\r\n'
        'BEGIN:VALARM\r\nSUMMARY:Alarm summary\r\nLOCATION:Nowhere\r\nEND:VALARM\r\n'
        'END:VEVENT\r\nEND:VCALENDAR\r\n',
      );
      expect(events, hasLength(1));
      final e = events.single;
      expect(e.summary, 'Design review, round 2');
      expect(e.location, 'Lighthouse; 3rd floor\nBuilding A');
      expect(e.organizer, 'Okafor, Dana');
      expect(e.start, DateTime(2026, 10, 6, 14));
      expect(e.end, DateTime(2026, 10, 6, 15, 30));
      expect(e.timeZone, 'Europe/Berlin');
      expect(e.utc, isFalse);
      expect(e.allDay, isFalse);
      expect(e.cancelled, isFalse);
    });

    test('UTC times, durations, all-day events and cancellations', () {
      final events = parseIcsEvents(
        'BEGIN:VCALENDAR\nMETHOD:CANCEL\n'
        'BEGIN:VEVENT\nSUMMARY:Call\nDTSTART:20261006T120000Z\nDURATION:PT45M\n'
        'ORGANIZER:mailto:ops@example.com\nEND:VEVENT\n'
        'BEGIN:VEVENT\nSUMMARY:Offsite\nDTSTART;VALUE=DATE:20261012\nDTEND;VALUE=DATE:20261014\nEND:VEVENT\n'
        'END:VCALENDAR\n',
      );
      expect(events, hasLength(2));
      expect(events[0].start, DateTime.utc(2026, 10, 6, 12));
      expect(events[0].utc, isTrue);
      expect(events[0].end, DateTime.utc(2026, 10, 6, 12, 45));
      expect(events[0].organizer, 'ops@example.com');
      expect(events[0].cancelled, isTrue);
      expect(events[1].allDay, isTrue);
      expect(events[1].start, DateTime(2026, 10, 12));
      expect(events[1].end, DateTime(2026, 10, 14));
    });

    test('a cancelled event and nothing at all', () {
      expect(parseIcsEvents('BEGIN:VEVENT\nSTATUS:CANCELLED\nEND:VEVENT').single.cancelled, isTrue);
      expect(parseIcsEvents('not a calendar'), isEmpty);
    });

    test('describes the time in words', () {
      // intl puts a narrow no-break space before AM/PM.
      String describe(IcsEvent e) => describeIcsTime(e).replaceAll(RegExp('[\u202F\u00A0]'), ' ');
      final timed = parseIcsEvents(
        'BEGIN:VEVENT\nDTSTART;TZID=Europe/Berlin:20261006T140000\nDTEND;TZID=Europe/Berlin:20261006T150000\n'
        'END:VEVENT',
      ).single;
      expect(describe(timed), 'Tue, Oct 6, 2026, 2:00 PM – 3:00 PM (Europe/Berlin)');
      final floating = parseIcsEvents('BEGIN:VEVENT\nDTSTART:20261006T090000\nEND:VEVENT').single;
      expect(describe(floating), 'Tue, Oct 6, 2026, 9:00 AM');
      final day = parseIcsEvents('BEGIN:VEVENT\nDTSTART;VALUE=DATE:20261006\nEND:VEVENT').single;
      expect(describe(day), 'Tue, Oct 6, 2026 (all day)');
      final days = parseIcsEvents('BEGIN:VEVENT\nDTSTART;VALUE=DATE:20261012\nDTEND;VALUE=DATE:20261014\nEND:VEVENT')
          .single;
      expect(describe(days), 'Mon, Oct 12, 2026 – Tue, Oct 13, 2026');
    });
  });
}
