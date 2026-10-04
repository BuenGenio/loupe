import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/features/attachments/attachment_cache.dart';
import 'package:mail_model/mail_model.dart';

import '../conversation/fake_mail_repository.dart';

/// Serves attachment bytes by part and counts downloads.
class _Repo extends FakeMailRepository {
  final downloads = <String>[];
  Completer<void>? gate;

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async {
    downloads.add('$emailId/$partId');
    await gate?.future;
    return Uint8List.fromList('$emailId $partId'.codeUnits);
  }
}

const _pdf = Attachment(partId: '2', mimeType: 'application/pdf', filename: 'Q4 plan.pdf', size: 10);
const _txt = Attachment(partId: '3', mimeType: 'text/plain', filename: '../../etc/passwd', size: 10);

void main() {
  late Directory temp;
  setUp(() => temp = Directory.systemTemp.createTempSync('loupe_cache_test'));
  tearDown(() => temp.deleteSync(recursive: true));

  test('downloads each part once per session and keeps it on disk under its name', () async {
    final repo = _Repo();
    final dir = Directory('${temp.path}/attachments');
    final cache = AttachmentCache(repository: repo, directory: () async => dir);

    expect(cache.contains('m1', '2'), isFalse);
    expect(String.fromCharCodes(await cache.bytes('m1', _pdf)), 'm1 2');
    expect(String.fromCharCodes(await cache.bytes('m1', _pdf)), 'm1 2');
    expect(String.fromCharCodes(await cache.bytes('m2', _pdf)), 'm2 2', reason: 'keyed by email and part');
    expect(repo.downloads, ['m1/2', 'm2/2']);
    expect(cache.contains('m1', '2'), isTrue);

    final file = await cache.file('m1', _pdf);
    expect(file, isNotNull);
    expect(file!.path, startsWith(dir.path));
    expect(file.path, endsWith('Q4 plan.pdf'));
    expect(file.readAsStringSync(), 'm1 2');

    // A hostile name stays inside the cache directory.
    final txt = await cache.file('m1', _txt);
    expect(txt!.parent.parent.path, dir.path);
    expect(txt.uri.pathSegments.last, '_.._etc_passwd');
  });

  test('a new session starts empty', () async {
    final dir = Directory('${temp.path}/attachments')..createSync();
    final old = File('${dir.path}/stale.bin')..writeAsStringSync('old');
    final cache = AttachmentCache(repository: _Repo(), directory: () async => dir);
    await cache.bytes('m1', _pdf);
    expect(old.existsSync(), isFalse);
  });

  test('concurrent requests share one download', () async {
    final repo = _Repo()..gate = Completer();
    final cache = AttachmentCache(repository: repo, directory: () async => Directory('${temp.path}/a'));
    final a = cache.bytes('m1', _pdf);
    final b = cache.bytes('m1', _pdf);
    repo.gate!.complete();
    expect(await a, await b);
    expect(repo.downloads, ['m1/2']);
  });

  test('downloads again when the system cleared the file', () async {
    final repo = _Repo();
    final cache = AttachmentCache(repository: repo, directory: () async => Directory('${temp.path}/a'));
    final file = await cache.file('m1', _pdf);
    file!.deleteSync();
    expect(String.fromCharCodes(await cache.bytes('m1', _pdf)), 'm1 2');
    expect(repo.downloads, ['m1/2', 'm1/2']);
  });

  test('drops the oldest files once the session passes the disk limit', () async {
    final repo = _Repo();
    final cache = AttachmentCache(repository: repo, directory: () async => Directory('${temp.path}/a'), diskLimit: 8);
    final first = await cache.file('m1', _pdf); // 4 bytes each
    await cache.file('m2', _pdf);
    expect(first!.existsSync(), isTrue);
    await cache.file('m3', _pdf);
    expect(first.existsSync(), isFalse);
    expect(cache.contains('m1', '2'), isFalse);
    expect(cache.contains('m3', '2'), isTrue);
    // One file over the limit on its own is still kept.
    final big = AttachmentCache(repository: repo, directory: () async => Directory('${temp.path}/b'), diskLimit: 1);
    expect(await big.file('m4', _pdf), isNotNull);
  });

  test('a custom download replaces the repository', () async {
    final repo = _Repo();
    final cache = AttachmentCache(repository: repo, directory: () async => null);
    final bytes = await cache.bytes('m1', _pdf, download: () async => Uint8List.fromList([7]));
    expect(bytes, [7]);
    expect(repo.downloads, isEmpty);
  });

  test('without a directory, keeps bytes in memory within the limit', () async {
    final repo = _Repo();
    final cache = AttachmentCache(repository: repo, directory: () async => null, memoryLimit: 8);
    await cache.bytes('m1', _pdf); // 4 bytes
    await cache.bytes('m2', _pdf); // 4 bytes
    expect(await cache.file('m1', _pdf), isNull);
    await cache.bytes('m1', _pdf);
    expect(repo.downloads, ['m1/2', 'm2/2']);
    await cache.bytes('m3', _pdf); // evicts the oldest
    await cache.bytes('m1', _pdf);
    expect(repo.downloads, ['m1/2', 'm2/2', 'm3/2', 'm1/2']);
  });

  test('download errors reach the caller and are not cached', () async {
    var fail = true;
    final cache = AttachmentCache(repository: _Repo(), directory: () async => null);
    Future<Uint8List> download() async {
      if (fail) throw const MailException(MailErrorKind.connection, 'Offline');
      return Uint8List.fromList([1]);
    }

    await expectLater(cache.bytes('m1', _pdf, download: download), throwsA(isA<MailException>()));
    fail = false;
    expect(await cache.bytes('m1', _pdf, download: download), [1]);
  });

  test('safeFileName', () {
    expect(safeFileName('Report Q4.pdf', 'application/pdf'), 'Report Q4.pdf');
    expect(safeFileName('a/b\\c:d*e?f"g<h>i|j.txt', 'text/plain'), 'a_b_c_d_e_f_g_h_i_j.txt');
    expect(safeFileName('..hidden', 'text/plain'), 'hidden');
    expect(safeFileName(null, 'application/pdf'), 'attachment.pdf');
    expect(safeFileName('   ', 'application/octet-stream'), 'attachment');
    final long = safeFileName('${'x' * 300}.docx', 'application/msword');
    expect(long.length, 120);
    expect(long, endsWith('.docx'));
  });
}
