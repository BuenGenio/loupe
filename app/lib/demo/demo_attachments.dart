import 'dart:convert';
import 'dart:typed_data';

import 'package:mail_model/mail_model.dart';

import 'demo_data.dart' show DemoAttachment;
import 'demo_mime.dart';

/// Small, generated files of every type the attachment viewer handles, for
/// the demo mailbox's "offsite pack" message.
abstract final class DemoAttachments {
  /// PDF, CSV, text, calendar, image, ZIP, message and a Latin-1 log sent as
  /// octet-stream (the extension and the charset fallback decide), as parts
  /// 2 onwards. The event is at [start].
  static List<DemoAttachment> offsitePack(DateTime start) {
    DemoAttachment file(String partId, String mime, String name, Uint8List bytes) => DemoAttachment(
      Attachment(partId: partId, mimeType: mime, filename: name, size: bytes.length),
      generate: () => bytes,
    );
    return [
      file('2', 'application/pdf', 'Offsite_plan.pdf', pagedPdf('Offsite plan', _planPages)),
      file('3', 'text/csv', 'Offsite_budget.csv', _utf8(_budget)),
      file('4', 'text/plain', 'Notes from Hana.txt', _utf8(_notes)),
      file('5', 'text/calendar', 'offsite.ics', calendarFile('Team offsite at the Old Mill', start)),
      const DemoAttachment(
        Attachment(partId: '6', mimeType: 'image/jpeg', filename: 'Old_Mill.jpg', size: 12272),
        asset: 'assets/demo/photo_mountains.jpg',
      ),
      file('7', 'application/zip', 'Venue_photos.zip', storedZip(_zipEntries)),
      file('8', 'message/rfc822', 'Venue confirmation.eml', _utf8(_venueEml(start))),
      file('9', 'application/octet-stream', 'booking_checkin.log', Uint8List.fromList(latin1.encode(_log))),
    ];
  }

  static Uint8List _utf8(String s) => Uint8List.fromList(utf8.encode(s));

  static const _planPages = [
    ['Day 1 - Arrival', '09:30 Coffee at the Old Mill', '10:00 Welcome and goals', '12:30 Lunch by the river'],
    ['Day 1 - Afternoon', '14:00 Roadmap workshop', '16:00 Walk along the canal', '19:00 Dinner'],
    ['Day 2 - Wrap-up', '09:00 Retro: what to keep', '11:00 Decisions and owners', '13:00 Lunch, then home'],
  ];

  static const _budget =
      'Item,Supplier,Cost (EUR),Paid\r\n'
      'Venue (2 days),The Old Mill,"1,200.00",yes\r\n'
      'Lunch x2,River Kitchen,640.00,no\r\n'
      'Dinner,"Mill House ""Bistro""",780.50,no\r\n'
      'Coffee and snacks,Harbor Coffee,85.50,yes\r\n'
      'Train tickets,Northline Rail,412.00,yes\r\n'
      'Total,,"3,118.00",\r\n';

  static const _notes =
      'Offsite notes\n'
      '=============\n\n'
      '- Parking: 12 spaces behind the mill, first come first served.\n'
      '- Dietary: Leo is vegetarian; Aisha avoids gluten. Café menu has both.\n'
      '- Wi-Fi: "OldMill-Guest", password on the board by the entrance.\n'
      '- Bring: laptop, charger, walking shoes (the canal path is muddy in October).\n\n'
      'Questions? Ask me or Ben.\n';

  static const _log =
      '2026-10-01 09:12:04 Réservation confirmée: Old Mill, salle « Lighthouse »\n'
      '2026-10-01 09:12:05 Arrivée prévue: 09h30, départ 17h00\n'
      '2026-10-01 09:12:05 Caution reçue: 200,00 EUR\n'
      '2026-10-02 18:40:11 Rappel envoyé à hana.sato@northwind.example\n';

  static const _zipEntries = {
    'README.txt': 'Photos of the Old Mill, taken during the venue visit.\n',
    'credits.txt': 'All photos by Hana Sato. For internal use only.\n',
  };

  static String _venueEml(DateTime start) {
    final date = rfc5322Date(start.subtract(const Duration(days: 9)));
    return 'From: The Old Mill <events@oldmill.example>\r\n'
        'To: Hana Sato <hana.sato@northwind.example>\r\n'
        'Subject: Booking confirmed: Northwind offsite\r\n'
        'Date: $date\r\n'
        'Message-ID: <booking-4471@oldmill.example>\r\n'
        'MIME-Version: 1.0\r\n'
        'Content-Type: multipart/alternative; boundary="venue"\r\n'
        '\r\n'
        '--venue\r\n'
        'Content-Type: text/plain; charset=utf-8\r\n'
        '\r\n'
        'Dear Hana,\r\n\r\nYour booking for the Lighthouse room is confirmed. Coffee is served from 09:30.\r\n\r\n'
        'The Old Mill\r\n'
        '--venue\r\n'
        'Content-Type: text/html; charset=utf-8\r\n'
        '\r\n'
        '<p>Dear Hana,</p><p>Your booking for the <b>Lighthouse room</b> is confirmed. '
        'Coffee is served from 09:30.</p><p>See you soon,<br>The Old Mill</p>\r\n'
        '--venue--\r\n';
  }
}

/// A valid PDF with one page per entry of [pages] (each a list of lines),
/// headed by [title].
Uint8List pagedPdf(String title, List<List<String>> pages) {
  String safe(String s) => s.replaceAll(RegExp(r'[()\\]'), '').replaceAll(RegExp(r'[^\x20-\x7E]'), '-');
  final n = pages.length;
  // Objects: 1 catalog, 2 pages, 3 font, then a page and its content per page.
  final objects = <String>[
    '<< /Type /Catalog /Pages 2 0 R >>',
    '<< /Type /Pages /Kids [${[for (var i = 0; i < n; i++) '${4 + 2 * i} 0 R'].join(' ')}] /Count $n >>',
    '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>',
  ];
  for (final (i, lines) in pages.indexed) {
    final content = StringBuffer('BT /F1 24 Tf 72 720 Td (${safe(title)}) Tj ET\n');
    var y = 680;
    for (final line in lines) {
      content.write('BT /F1 14 Tf 72 $y Td (${safe(line)}) Tj ET\n');
      y -= 26;
    }
    content.write('BT /F1 10 Tf 72 60 Td (Page ${i + 1} of $n - demo document generated by Loupe) Tj ET');
    objects
      ..add(
        '<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents ${5 + 2 * i} 0 R '
        '/Resources << /Font << /F1 3 0 R >> >> >>',
      )
      ..add('<< /Length ${content.length} >>\nstream\n$content\nendstream');
  }
  final out = StringBuffer('%PDF-1.4\n');
  final offsets = <int>[];
  for (final (i, body) in objects.indexed) {
    offsets.add(out.length);
    out.write('${i + 1} 0 obj\n$body\nendobj\n');
  }
  final xref = out.length;
  out.write('xref\n0 ${objects.length + 1}\n0000000000 65535 f \n');
  for (final o in offsets) {
    out.write('${o.toString().padLeft(10, '0')} 00000 n \n');
  }
  out.write('trailer\n<< /Size ${objects.length + 1} /Root 1 0 R >>\nstartxref\n$xref\n%%EOF\n');
  return Uint8List.fromList(latin1.encode(out.toString()));
}

final _crcTable = List<int>.generate(256, (n) {
  var c = n;
  for (var k = 0; k < 8; k++) {
    c = (c & 1) != 0 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
  }
  return c;
});

int _crc32(List<int> bytes) {
  var crc = 0xFFFFFFFF;
  for (final b in bytes) {
    crc = _crcTable[(crc ^ b) & 0xFF] ^ (crc >>> 8);
  }
  return crc ^ 0xFFFFFFFF;
}

/// A valid ZIP archive of [files] (name → text), stored without compression.
Uint8List storedZip(Map<String, String> files) {
  final out = BytesBuilder();
  final central = BytesBuilder();
  void u16(BytesBuilder b, int v) => b.add([v & 0xFF, (v >> 8) & 0xFF]);
  void u32(BytesBuilder b, int v) => b.add([v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF, (v >> 24) & 0xFF]);
  // 2026-10-01 12:00, in DOS format.
  const time = 12 << 11, date = ((2026 - 1980) << 9) | (10 << 5) | 1;
  for (final MapEntry(key: name, value: text) in files.entries) {
    final data = utf8.encode(text);
    final nameBytes = utf8.encode(name);
    final crc = _crc32(data);
    final offset = out.length;
    u32(out, 0x04034b50);
    for (final v in [10, 0, 0, time, date]) {
      u16(out, v);
    }
    for (final v in [crc, data.length, data.length]) {
      u32(out, v);
    }
    u16(out, nameBytes.length);
    u16(out, 0);
    out
      ..add(nameBytes)
      ..add(data);

    u32(central, 0x02014b50);
    for (final v in [20, 10, 0, 0, time, date]) {
      u16(central, v);
    }
    for (final v in [crc, data.length, data.length]) {
      u32(central, v);
    }
    for (final v in [nameBytes.length, 0, 0, 0, 0]) {
      u16(central, v);
    }
    u32(central, 0);
    u32(central, offset);
    central.add(nameBytes);
  }
  final centralOffset = out.length;
  final centralBytes = central.takeBytes();
  out.add(centralBytes);
  u32(out, 0x06054b50);
  for (final v in [0, 0, files.length, files.length]) {
    u16(out, v);
  }
  u32(out, centralBytes.length);
  u32(out, centralOffset);
  u16(out, 0);
  return out.takeBytes();
}
