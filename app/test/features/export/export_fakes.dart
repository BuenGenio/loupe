import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:loupe/demo/demo_repository.dart';
import 'package:loupe/features/export/export_files.dart';
import 'package:mail_model/mail_model.dart';

import '../../helpers.dart';

/// Exports kept in memory, and what went to the save dialog.
class MemoryExportFiles implements ExportFiles {
  final created = <MemoryExportFile>[];
  final saved = <({String name, String mimeType, Uint8List bytes})>[];

  /// What the save dialog answers: false is Cancel.
  bool saveAnswer = true;

  @override
  Future<ExportFile> create(String name) async {
    final file = MemoryExportFile(name);
    created.add(file);
    return file;
  }

  @override
  Future<bool> save(ExportFile file, {required String name, required String mimeType}) async {
    final f = file as MemoryExportFile;
    expectClosed(f);
    saved.add((name: name, mimeType: mimeType, bytes: f.bytes));
    return saveAnswer;
  }

  static void expectClosed(MemoryExportFile f) {
    if (!f.closed || f.deleted) throw StateError('Saving a file that is open or deleted');
  }
}

class MemoryExportFile implements ExportFile {
  MemoryExportFile(this.name);

  final String name;
  final _bytes = BytesBuilder();
  bool closed = false;
  bool deleted = false;

  Uint8List get bytes => _bytes.toBytes();
  String get text => utf8.decode(bytes);

  @override
  Future<void> write(List<int> bytes) async {
    if (closed || deleted) throw StateError('Writing to a closed file');
    _bytes.add(bytes);
  }

  @override
  Future<void> close() async => closed = true;

  @override
  Future<void> delete() async => deleted = true;
}

/// The demo, with downloads of raw messages that wait for [release] (while
/// [gated]) and fail for the ids in [failing].
class GatedDemoRepository extends DemoMailRepository {
  GatedDemoRepository() : super(latency: DemoLatency.zero, clock: () => testNow);

  bool gated = false;
  final failing = <String>{};
  final downloads = <String>[];
  final _waiting = <Completer<void>>[];

  /// Downloads waiting for [release].
  int get waiting => _waiting.length;

  /// Lets the oldest waiting download go on.
  void release() => _waiting.removeAt(0).complete();

  @override
  Future<Uint8List> loadRawSource(String emailId) async {
    downloads.add(emailId);
    if (gated) {
      final gate = Completer<void>();
      _waiting.add(gate);
      await gate.future;
    }
    if (failing.contains(emailId)) throw const MailException(MailErrorKind.connection, 'The connection was lost.');
    return super.loadRawSource(emailId);
  }
}

/// Every message of [mailboxId] the demo has now, newest first.
Future<List<EmailSummary>> demoMessages(DemoMailRepository repo, String mailboxId) async => [
  for (final t in await repo.watchList(RealMailboxRef(mailboxId), threaded: false, limit: 100000).first) t.latest,
];

/// The separator lines of an mbox file.
List<String> separators(String mbox) => [
  for (final line in const LineSplitter().convert(mbox))
    if (line.startsWith('From ')) line,
];
