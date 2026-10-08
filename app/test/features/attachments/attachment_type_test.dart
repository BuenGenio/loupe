import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/attachment_type.dart';
import 'package:loupe/l10n/l10n.dart';

void main() {
  group('attachmentKindOf', () {
    test('goes by MIME type first', () {
      expect(attachmentKindOf('application/pdf', 'scan'), AttachmentKind.pdf);
      expect(attachmentKindOf('image/jpeg', 'IMG_1.JPG'), AttachmentKind.image);
      expect(attachmentKindOf('image/heic', 'IMG_2.HEIC'), AttachmentKind.image);
      expect(attachmentKindOf('image/webp'), AttachmentKind.image);
      expect(attachmentKindOf('image/gif'), AttachmentKind.image);
      expect(attachmentKindOf('text/csv', 'export'), AttachmentKind.csv);
      expect(attachmentKindOf('text/calendar', 'invite.ics'), AttachmentKind.calendar);
      expect(attachmentKindOf('message/rfc822', 'Fwd.eml'), AttachmentKind.email);
      expect(attachmentKindOf('application/json', 'data.json'), AttachmentKind.text);
      expect(attachmentKindOf('application/ld+json'), AttachmentKind.text);
      expect(attachmentKindOf('text/x-log'), AttachmentKind.text);
      expect(attachmentKindOf('text/vcard', 'card.vcf'), AttachmentKind.text);
      expect(attachmentKindOf('application/zip', 'photos.zip'), AttachmentKind.other);
    });

    test('ignores case and parameters', () {
      expect(attachmentKindOf('Application/PDF; name="a.pdf"'), AttachmentKind.pdf);
      expect(attachmentKindOf('TEXT/PLAIN; charset=iso-8859-1', 'notes.TXT'), AttachmentKind.text);
    });

    test('falls back to the extension when the MIME type is generic', () {
      expect(attachmentKindOf('application/octet-stream', 'Report.PDF'), AttachmentKind.pdf);
      expect(attachmentKindOf('application/octet-stream', 'photo.jpeg'), AttachmentKind.image);
      expect(attachmentKindOf('application/octet-stream', 'server.log'), AttachmentKind.text);
      expect(attachmentKindOf('application/octet-stream', 'budget.csv'), AttachmentKind.csv);
      expect(attachmentKindOf('application/octet-stream', 'meeting.ics'), AttachmentKind.calendar);
      expect(attachmentKindOf('application/octet-stream', 'message.eml'), AttachmentKind.email);
      expect(attachmentKindOf('application/octet-stream', 'archive.zip'), AttachmentKind.other);
      expect(attachmentKindOf('application/octet-stream', 'noextension'), AttachmentKind.other);
      expect(attachmentKindOf('', 'README.md'), AttachmentKind.text);
      expect(attachmentKindOf('application/x-unknown-thing', 'notes.txt'), AttachmentKind.text);
    });

    test('lets the extension refine text/plain and Excel CSVs', () {
      expect(attachmentKindOf('text/plain', 'export.csv'), AttachmentKind.csv);
      expect(attachmentKindOf('text/plain', 'event.ics'), AttachmentKind.calendar);
      expect(attachmentKindOf('text/plain', 'data.json'), AttachmentKind.text);
      expect(attachmentKindOf('application/vnd.ms-excel', 'export.csv'), AttachmentKind.csv);
      expect(attachmentKindOf('application/vnd.ms-excel', 'budget.xls'), AttachmentKind.other);
    });

    test("doesn't second-guess specific types it can't show", () {
      expect(attachmentKindOf('image/tiff', 'scan.jpg'), AttachmentKind.other);
      expect(attachmentKindOf('image/svg+xml', 'logo.svg'), AttachmentKind.other);
      expect(attachmentKindOf('text/html', 'page.txt'), AttachmentKind.other);
      expect(attachmentKindOf('video/mp4', 'clip.mp4'), AttachmentKind.other);
      expect(
        attachmentKindOf('application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'a.txt'),
        AttachmentKind.other,
      );
    });
  });

  test('fileExtension', () {
    expect(fileExtension('a.b.PDF'), 'pdf');
    expect(fileExtension('.bashrc'), '');
    expect(fileExtension('trailing.'), '');
    expect(fileExtension(null), '');
  });

  test('effectiveMimeType names generic types from the extension', () {
    expect(effectiveMimeType('application/octet-stream', 'a.pdf'), 'application/pdf');
    expect(effectiveMimeType('application/octet-stream', 'a.weird'), 'application/octet-stream');
    expect(effectiveMimeType('Image/PNG; name=x', 'a.jpg'), 'image/png');
  });

  test('describeFileType', () {
    final l10n = lookupAppLocalizations(const Locale('en'));
    String describe(String mime, [String? name]) => describeFileType(mime, name, l10n: l10n);
    expect(describe('application/pdf'), 'PDF Document');
    expect(describe('image/jpeg', 'a.jpg'), 'JPEG Image');
    expect(describe('application/zip', 'a.zip'), 'ZIP Archive');
    expect(describe('application/octet-stream', 'a.csv'), 'CSV Spreadsheet');
    expect(describe('text/calendar'), 'Calendar Event');
    expect(describe('message/rfc822'), 'Email Message');
    expect(describe('text/vcard', 'a.vcf'), 'Contact Card');
    expect(
      describe('application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'a.docx'),
      'Word Document',
    );
    expect(describe('application/x-thing', 'a.dwg'), 'DWG File');
    expect(describe('application/octet-stream'), 'File');
  });
}
