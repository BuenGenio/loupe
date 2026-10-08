import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

/// A file an export is written to before the user picks where it goes.
abstract interface class ExportFile {
  /// Appends [bytes]; completes once they are written.
  Future<void> write(List<int> bytes);

  /// Finishes writing.
  Future<void> close();

  /// Removes the file (also before [close]).
  Future<void> delete();
}

/// Where folder exports are written and how they reach the user's files.
/// Widget tests replace it (see [exportFilesProvider]).
abstract interface class ExportFiles {
  /// A new, empty file in the app's cache.
  Future<ExportFile> create(String name);

  /// The system's save dialog, suggesting [name]; copies [file] where the
  /// user picks. False when they cancel.
  Future<bool> save(ExportFile file, {required String name, required String mimeType});
}

final exportFilesProvider = Provider<ExportFiles>((ref) => DeviceExportFiles());

/// [ExportFiles] in the cache directory, saved through Android's own save
/// dialog by the app's `save_file` channel (SaveFileChannel.kt), which
/// copies the file in a stream: an exported folder can be far larger than
/// what fits in memory, and file_picker's saveFile takes the bytes.
/// Elsewhere (iOS) file_picker does it.
class DeviceExportFiles implements ExportFiles {
  DeviceExportFiles({Future<Directory> Function()? directory}) : _directory = directory ?? getTemporaryDirectory;

  final Future<Directory> Function() _directory;

  static const _channel = MethodChannel('io.github.buengenio.loupe/save_file');
  static const _prefix = 'export_';

  @override
  Future<ExportFile> create(String name) async {
    final cache = await _directory();
    // What an export cut short (the app closed) left behind; one export
    // runs at a time.
    try {
      await for (final e in cache.list()) {
        final base = e.path.substring(e.path.lastIndexOf(Platform.pathSeparator) + 1);
        if (e is Directory && base.startsWith(_prefix)) {
          await e.delete(recursive: true);
        }
      }
    } on FileSystemException {
      // Not worth failing the export for.
    }
    final dir = await cache.createTemp(_prefix);
    final file = File('${dir.path}${Platform.pathSeparator}$name');
    return _DiskExportFile(file, dir, file.openWrite());
  }

  @override
  Future<bool> save(ExportFile file, {required String name, required String mimeType}) async {
    final path = (file as _DiskExportFile).file.path;
    if (Platform.isAndroid) {
      // The type follows from the name's extension there.
      return await _channel.invokeMethod<bool>('save', {'path': path, 'name': name}) ?? false;
    }
    final Uint8List bytes = await File(path).readAsBytes();
    return await FilePicker.saveFile(fileName: name, bytes: bytes, mimeType: mimeType) != null;
  }
}

final class _DiskExportFile implements ExportFile {
  _DiskExportFile(this.file, this._dir, this._sink);

  final File file;
  final Directory _dir;
  final IOSink _sink;
  bool _closed = false;

  @override
  Future<void> write(List<int> bytes) {
    _sink.add(bytes);
    return _sink.flush();
  }

  @override
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _sink.close();
  }

  @override
  Future<void> delete() async {
    try {
      await close();
    } on FileSystemException {
      // Deleting anyway.
    }
    if (await _dir.exists()) await _dir.delete(recursive: true);
  }
}
