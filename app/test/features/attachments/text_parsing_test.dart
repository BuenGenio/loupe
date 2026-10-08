import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/attachment_type.dart';
import 'package:loupe/features/attachments/csv.dart';
import 'package:loupe/features/attachments/prepared_text.dart';
import 'package:loupe/features/attachments/text_decoding.dart';
import 'package:loupe/features/calendar/invitation_format.dart';
import 'package:loupe/l10n/l10n.dart';
import 'package:mail_calendar/mail_calendar.dart';

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

  group('calendar files', () {
    test('reads title, place, organizer and times, unfolding and unescaping', () {
      final text = prepareText(
        AttachmentKind.calendar,
        Uint8List.fromList(
          utf8.encode(
            'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nMETHOD:REQUEST\r\nBEGIN:VEVENT\r\n'
            'SUMMARY:Design review\\, round 2\r\n'
            'DTSTART;TZID=Europe/Berlin:20261006T140000\r\n'
            'DTEND;TZID=Europe/Berlin:20261006T153000\r\n'
            'LOCATION:Lighthouse\\; 3rd floor\\nBuilding A\r\n'
            'ORGANIZER;CN="Okafor, Dana":mailto:dana@example.com\r\n'
            'DESCRIPTION:A long description that is folded\r\n  over two lines\r\n'
            'BEGIN:VALARM\r\nSUMMARY:Alarm summary\r\nLOCATION:Nowhere\r\nEND:VALARM\r\n'
            'END:VEVENT\r\nEND:VCALENDAR\r\n',
          ),
        ),
      );
      final calendar = text.calendar!;
      final e = calendar.primary!;
      expect(calendar.events, hasLength(1));
      expect(e.summary, 'Design review, round 2');
      expect(e.location, 'Lighthouse; 3rd floor\nBuilding A');
      expect(e.organizer!.displayName, 'Okafor, Dana');
      expect(e.description, 'A long description that is folded over two lines');
      final span = eventSpan(e, calendar.zones)!;
      expect(span.start, DateTime.utc(2026, 10, 6, 12));
      expect(span.end, DateTime.utc(2026, 10, 6, 13, 30));
      expect(span.zone!.ianaName, 'Europe/Berlin');
      expect(span.allDay, isFalse);
    });

    test('not a calendar', () {
      expect(prepareText(AttachmentKind.calendar, Uint8List.fromList(utf8.encode('not a calendar'))).calendar, isNull);
      expect(
        prepareText(AttachmentKind.text, Uint8List.fromList(utf8.encode('BEGIN:VEVENT\nEND:VEVENT'))).calendar,
        isNull,
      );
    });

    test('describes the time in words, in the device zone and the event\'s', () {
      // intl puts a narrow no-break space before AM/PM.
      final london = IanaZone.named('Europe/London')!;
      final format = EventTimeFormat(
        l10n: lookupAppLocalizations(const Locale('en')),
        deviceZone: london,
        now: DateTime.utc(2026, 10, 1),
      );
      String describe(String props) {
        final c = Calendar.parse('BEGIN:VEVENT\n$props\nEND:VEVENT')!;
        final w = format.when(eventSpan(c.primary!, c.zones)!);
        return '${w.day} | ${w.time}'.replaceAll(RegExp('[\u202F\u00A0]'), ' ');
      }

      expect(
        describe('DTSTART;TZID=Europe/Berlin:20261006T140000\nDTEND;TZID=Europe/Berlin:20261006T150000'),
        'Tuesday, October 6 | 2:00 PM–3:00 PM Berlin · 1:00 PM–2:00 PM your time',
      );
      expect(
        describe('DTSTART;TZID=Europe/London:20261006T140000\nDTEND;TZID=Europe/London:20261006T150000'),
        'Tuesday, October 6 | 2:00 PM–3:00 PM',
      );
      expect(describe('DTSTART:20261006T090000'), 'Tuesday, October 6 | 9:00 AM');
      expect(describe('DTSTART;VALUE=DATE:20261006'), 'Tuesday, October 6 | All day');
      expect(describe('DTSTART;VALUE=DATE:20261012\nDTEND;VALUE=DATE:20261014'), 'Mon, Oct 12 – Tue, Oct 13 | All day');
      expect(describe('DTSTART;VALUE=DATE:20270105'), 'Tuesday, January 5, 2027 | All day');
    });
  });
}
