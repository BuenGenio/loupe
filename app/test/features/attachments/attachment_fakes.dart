import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:loupe/features/attachments/attachment_cache.dart';
import 'package:loupe/features/attachments/attachment_platform.dart';
import 'package:loupe/features/attachments/viewers/pdf_view.dart';
import 'package:loupe/providers.dart';

import '../conversation/fake_mail_repository.dart';

/// Serves attachment bytes by part and logs each download.
class AttachmentRepo extends FakeMailRepository {
  AttachmentRepo({super.emails, super.contents});

  final files = <String, List<int>>{};
  Object? attachmentError;

  @override
  Future<Uint8List> loadAttachment(String emailId, String partId) async {
    log.add('loadAttachment $emailId $partId');
    if (attachmentError case final e?) throw e;
    return Uint8List.fromList(files[partId] ?? const []);
  }
}

/// Records what would go to other apps.
class FakePlatform implements AttachmentPlatform {
  bool mobileData = false;
  OpenInResult openResult = OpenInResult.opened;
  final calls = <String>[];
  AttachmentFile? last;

  @override
  Future<void> share(AttachmentFile file, {Rect? origin}) async {
    last = file;
    calls.add('share ${file.name} ${file.mimeType}');
  }

  @override
  Future<OpenInResult> openIn(AttachmentFile file) async {
    last = file;
    calls.add('openIn ${file.name} ${file.mimeType}');
    return openResult;
  }

  @override
  Future<bool> save(AttachmentFile file) async {
    last = file;
    calls.add('save ${file.name}');
    return true;
  }

  @override
  Future<bool> isOnMobileData() async => mobileData;
}

/// Stands in for pdfx: "renders" a 3-page document when the bytes look like
/// a PDF, otherwise shows the error.
class FakePdf extends StatefulWidget {
  const FakePdf({
    super.key,
    required this.bytes,
    required this.onPageCount,
    required this.onPageChanged,
    required this.error,
  });

  final Uint8List bytes;
  final ValueChanged<int> onPageCount;
  final ValueChanged<int> onPageChanged;
  final Widget error;

  bool get valid => ascii.decode(bytes.take(5).toList(), allowInvalid: true) == '%PDF-';

  @override
  State<FakePdf> createState() => _FakePdfState();
}

class _FakePdfState extends State<FakePdf> {
  @override
  void initState() {
    super.initState();
    if (widget.valid) WidgetsBinding.instance.addPostFrameCallback((_) => widget.onPageCount(3));
  }

  @override
  Widget build(BuildContext context) => widget.valid
      ? Center(
          child: TextButton(
            onPressed: () => widget.onPageChanged(2),
            child: Text('PDF of ${widget.bytes.length} bytes'),
          ),
        )
      : widget.error;
}

Widget fakePdfBuilder({
  required String? path,
  required Uint8List bytes,
  required ValueChanged<int> onPageCount,
  required ValueChanged<int> onPageChanged,
  required Widget error,
}) => FakePdf(bytes: bytes, onPageCount: onPageCount, onPageChanged: onPageChanged, error: error);

/// The overrides that make the viewer testable: the fake repository, a
/// memory-only cache, the fake platform and the fake PDF renderer.
List<Override> overridesFor(AttachmentRepo repo, FakePlatform platform) => [
  repositoryProvider.overrideWithValue(repo),
  attachmentCacheProvider.overrideWith((ref) => AttachmentCache(repository: repo, directory: () async => null)),
  attachmentPlatformProvider.overrideWithValue(platform),
  pdfViewBuilderProvider.overrideWithValue(fakePdfBuilder),
];
