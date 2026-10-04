import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/demo/demo_attachments.dart';
import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/attachments/attachment_type.dart';
import 'package:loupe/features/attachments/csv.dart';
import 'package:loupe/features/attachments/eml.dart';
import 'package:loupe/features/attachments/ics.dart';
import 'package:loupe/features/attachments/text_decoding.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the offsite pack has one attachment of every viewer type, all valid', () async {
    final repo = DemoMailRepository.instant(clock: () => DateTime(2026, 10, 4, 16));
    addTearDown(repo.dispose);
    final work = await repo.watchMailboxes(accountId: 'work').first;
    final inbox = work.firstWhere((m) => m.role == MailboxRole.inbox);
    final rows = await repo.watchList(RealMailboxRef(inbox.id), threaded: false).first;
    final pack = rows.map((r) => r.latest).firstWhere((e) => e.subject.startsWith('Offsite pack'));
    expect(pack.hasAttachment, isTrue);

    final content = await repo.loadContent(pack.id);
    final kinds = {for (final a in content.attachments) a.filename: attachmentKindOf(a.mimeType, a.filename)};
    expect(kinds.values.toSet(), AttachmentKind.values.toSet());

    Future<Uint8List> bytesOf(String name) async {
      final a = content.attachments.firstWhere((a) => a.filename == name);
      final bytes = await repo.loadAttachment(pack.id, a.partId);
      expect(bytes.length, a.size, reason: '$name: the listed size is the real one');
      return bytes;
    }

    final pdf = latin1.decode(await bytesOf('Offsite_plan.pdf'));
    expect(pdf, startsWith('%PDF-1.4'));
    expect(RegExp(r'/Type /Page ').allMatches(pdf).length, 3);
    expect(pdf, contains('/Count 3'));

    expect(parseCsv(utf8.decode(await bytesOf('Offsite_budget.csv'))).fitsTable, isTrue);
    expect(decodeAttachmentText(await bytesOf('Notes from Hana.txt')).charset, 'UTF-8');
    expect(parseIcsEvents(utf8.decode(await bytesOf('offsite.ics'))).single.summary, 'Team offsite at the Old Mill');
    expect(parseEml(await bytesOf('Venue confirmation.eml')).subject, 'Booking confirmed: Northwind offsite');
    final log = decodeAttachmentText(await bytesOf('booking_checkin.log'));
    expect(log.charset, 'Latin-1');
    expect(log.text, contains('salle « Lighthouse »'));

    final zip = await bytesOf('Venue_photos.zip');
    expect(zip.sublist(0, 4), [0x50, 0x4B, 0x03, 0x04]);
    expect(zip.sublist(zip.length - 22, zip.length - 18), [0x50, 0x4B, 0x05, 0x06]);

    final photo = await bytesOf('Old_Mill.jpg');
    expect(photo.sublist(0, 2), [0xFF, 0xD8]);
  });

  test('storedZip writes correct CRCs', () {
    final zip = storedZip({'a.txt': 'hello'});
    // CRC-32 of "hello" is 0x3610A686, at offset 14 of the local header.
    expect(ByteData.sublistView(zip).getUint32(14, Endian.little), 0x3610A686);
  });
}
