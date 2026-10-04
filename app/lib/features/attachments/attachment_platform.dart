import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// A downloaded attachment, ready to hand to other apps.
final class AttachmentFile {
  const AttachmentFile({required this.name, required this.mimeType, required this.bytes, this.path});

  final String name;
  final String mimeType;
  final Uint8List bytes;

  /// Its copy in the attachment cache, when there is one.
  final String? path;
}

enum OpenInResult { opened, noApp, failed }

/// What the attachment viewer needs from the platform. Widget tests replace
/// it (see [attachmentPlatformProvider]).
abstract interface class AttachmentPlatform {
  /// The share sheet.
  Future<void> share(AttachmentFile file, {Rect? origin});

  /// Hands the file to another app (Android: ACTION_VIEW through a
  /// FileProvider), which the user picks.
  Future<OpenInResult> openIn(AttachmentFile file);

  /// Lets the user pick a place and a name (Downloads by default) and saves
  /// the file there. False when they cancel.
  Future<bool> save(AttachmentFile file);

  /// True on mobile data (and not on Wi-Fi or Ethernet). False when unknown.
  Future<bool> isOnMobileData();
}

final attachmentPlatformProvider = Provider<AttachmentPlatform>((ref) => const DeviceAttachmentPlatform());

/// [AttachmentPlatform] with share_plus, open_file, file_picker and
/// connectivity_plus.
class DeviceAttachmentPlatform implements AttachmentPlatform {
  const DeviceAttachmentPlatform();

  @override
  Future<void> share(AttachmentFile file, {Rect? origin}) async {
    final path = file.path;
    await SharePlus.instance.share(
      ShareParams(
        files: [
          path != null
              ? XFile(path, name: file.name, mimeType: file.mimeType)
              : XFile.fromData(file.bytes, name: file.name, mimeType: file.mimeType),
        ],
        fileNameOverrides: [file.name],
        sharePositionOrigin: origin,
      ),
    );
  }

  @override
  Future<OpenInResult> openIn(AttachmentFile file) async {
    var path = file.path;
    if (path == null) {
      // Not cached on disk: other apps need a file, so write one.
      final dir = await Directory((await getTemporaryDirectory()).path).createTemp('open_');
      path = '${dir.path}${Platform.pathSeparator}${file.name}';
      await File(path).writeAsBytes(file.bytes, flush: true);
    }
    final result = await OpenFile.open(path, type: file.mimeType);
    return switch (result.type) {
      ResultType.done => OpenInResult.opened,
      ResultType.noAppToOpen => OpenInResult.noApp,
      _ => OpenInResult.failed,
    };
  }

  @override
  Future<bool> save(AttachmentFile file) async {
    final uri = await FilePicker.saveFile(fileName: file.name, bytes: file.bytes, mimeType: file.mimeType);
    return uri != null;
  }

  @override
  Future<bool> isOnMobileData() async {
    try {
      final types = await Connectivity().checkConnectivity();
      return types.contains(ConnectivityResult.mobile) &&
          !types.contains(ConnectivityResult.wifi) &&
          !types.contains(ConnectivityResult.ethernet);
    } on Object {
      return false;
    }
  }
}
