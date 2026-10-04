import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../providers.dart';
import 'attachment_type.dart';

/// The cache of the active repository. A new repository (demo ↔ live)
/// starts a new, empty cache.
final attachmentCacheProvider = Provider<AttachmentCache>(
  (ref) => AttachmentCache(repository: ref.watch(repositoryProvider)),
);

/// A file name that is safe on disk and keeps its extension: no path
/// separators or control characters, no leading dots, at most 120
/// characters. "attachment" (plus an extension from [mimeType]) when
/// nothing is left.
String safeFileName(String? name, String mimeType) {
  var n = (name ?? '').replaceAll(RegExp(r'[\x00-\x1f\x7f/\\:*?"<>|]'), '_').trim();
  n = n.replaceFirst(RegExp(r'^[.\s]+'), '');
  if (n.isEmpty) {
    final ext = switch (effectiveMimeType(mimeType)) {
      'application/pdf' => '.pdf',
      'text/plain' => '.txt',
      'text/csv' => '.csv',
      'text/calendar' => '.ics',
      'message/rfc822' => '.eml',
      'image/jpeg' => '.jpg',
      'image/png' => '.png',
      'application/zip' => '.zip',
      _ => '',
    };
    return 'attachment$ext';
  }
  if (n.length > 120) {
    final ext = fileExtension(n);
    final keep = ext.isEmpty || ext.length > 10 ? '' : '.$ext';
    n = '${n.substring(0, 120 - keep.length)}$keep';
  }
  return n;
}

/// Attachments downloaded this session, kept in the app's cache directory
/// and keyed by email and part, so viewing, sharing, saving and "Open in…"
/// download each one once. The directory is emptied when the cache first
/// uses it, so files live for one session (and the system may clear the
/// cache directory any time).
///
/// Without a directory (tests, or when it can't be created) the bytes stay
/// in memory instead, up to [memoryLimit]. On disk, the oldest files go
/// once the session's files pass [diskLimit].
class AttachmentCache {
  AttachmentCache({
    required this.repository,
    Future<Directory?> Function()? directory,
    this.memoryLimit = 64 << 20,
    this.diskLimit = 512 << 20,
  }) : _directory = directory ?? _defaultDirectory;

  final MailRepository repository;
  final int memoryLimit;
  final int diskLimit;
  final Future<Directory?> Function() _directory;

  static Future<Directory?> _defaultDirectory() async {
    final base = await getApplicationCacheDirectory();
    return Directory('${base.path}${Platform.pathSeparator}attachments');
  }

  Future<Directory?>? _sessionDir;
  final _files = <String, File>{};
  final _fileSizes = <String, int>{};
  final _memory = <String, Uint8List>{};
  final _pending = <String, Future<Uint8List>>{};
  var _next = 0;

  static String _key(String emailId, String partId) => '$emailId\u0000$partId';

  /// The directory, emptied of earlier sessions' files on first use.
  Future<Directory?> _dir() => _sessionDir ??= () async {
    try {
      final dir = await _directory();
      if (dir == null) return null;
      if (dir.existsSync()) await dir.delete(recursive: true);
      await dir.create(recursive: true);
      return dir;
    } on Object {
      return null;
    }
  }();

  /// Whether the attachment was downloaded this session.
  bool contains(String emailId, String partId) {
    final key = _key(emailId, partId);
    return _memory.containsKey(key) || _files.containsKey(key);
  }

  /// The attachment's bytes: from the cache, or downloaded with [download]
  /// (by default from the repository). Concurrent calls share one download.
  Future<Uint8List> bytes(String emailId, Attachment attachment, {Future<Uint8List> Function()? download}) async {
    final key = _key(emailId, attachment.partId);
    final inMemory = _memory[key];
    if (inMemory != null) return inMemory;
    final file = _files[key];
    if (file != null) {
      try {
        return await file.readAsBytes();
      } on FileSystemException {
        _files.remove(key); // The system cleared the cache: download again.
        _fileSizes.remove(key);
      }
    }
    final pending = _pending[key];
    if (pending != null) return pending;
    final load = _download(key, attachment, download ?? () => repository.loadAttachment(emailId, attachment.partId));
    _pending[key] = load;
    try {
      return await load;
    } finally {
      if (identical(_pending[key], load)) unawaited(_pending.remove(key));
    }
  }

  Future<Uint8List> _download(String key, Attachment attachment, Future<Uint8List> Function() download) async {
    final data = await download();
    final dir = await _dir();
    if (dir != null) {
      try {
        // One folder per attachment keeps the original name (other apps show it).
        final folder = Directory('${dir.path}${Platform.pathSeparator}${++_next}');
        await folder.create(recursive: true);
        final file = File(
          '${folder.path}${Platform.pathSeparator}${safeFileName(attachment.filename, attachment.mimeType)}',
        );
        await file.writeAsBytes(data, flush: true);
        _files[key] = file;
        _fileSizes[key] = data.length;
        _trimDisk(keep: key);
        return data;
      } on FileSystemException {
        // Fall through to memory.
      }
    }
    _remember(key, data);
    return data;
  }

  /// Deletes the oldest files (never [keep]) while the total is over [diskLimit].
  void _trimDisk({required String keep}) {
    var total = _fileSizes.values.fold(0, (s, n) => s + n);
    for (final key in _files.keys.toList()) {
      if (total <= diskLimit) break;
      if (key == keep) continue;
      final file = _files.remove(key)!;
      total -= _fileSizes.remove(key) ?? 0;
      try {
        file.parent.deleteSync(recursive: true);
      } on FileSystemException {
        // Already gone.
      }
    }
  }

  void _remember(String key, Uint8List data) {
    if (data.length > memoryLimit) return;
    var total = _memory.values.fold(0, (s, b) => s + b.length) + data.length;
    while (total > memoryLimit && _memory.isNotEmpty) {
      total -= _memory.remove(_memory.keys.first)!.length;
    }
    _memory[key] = data;
  }

  /// The attachment's file in the cache directory, downloading it first; null
  /// when there is no cache directory.
  Future<File?> file(String emailId, Attachment attachment) async {
    final key = _key(emailId, attachment.partId);
    final cached = _files[key];
    if (cached != null && cached.existsSync()) return cached;
    _files.remove(key);
    await bytes(emailId, attachment);
    return _files[key];
  }
}
