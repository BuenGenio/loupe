import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

/// Why the camera view can't show.
enum ScannerProblem {
  /// The user didn't allow the camera.
  permissionDenied,

  /// No camera on this device (or platform).
  unavailable,

  /// The camera failed to start.
  failed,
}

/// Builds the camera view. [onPayload] gets the text of every QR code seen
/// (repeatedly while it stays in view); [problem] builds what to show
/// instead when the camera can't run.
typedef QrScannerBuilder = Widget Function(
  BuildContext context, {
  required ValueChanged<String> onPayload,
  required Widget Function(BuildContext context, ScannerProblem problem) problem,
});

/// The camera scanner. Tests replace it with a fake that feeds payloads.
final qrScannerProvider = Provider<QrScannerBuilder>(
  (ref) =>
      (context, {required onPayload, required problem}) => CameraQrScanner(onPayload: onPayload, problem: problem),
);

/// Opens Loupe's page in the system settings, to allow the camera.
final openAppSettingsProvider = Provider<Future<void> Function()>((ref) => AppSettings.openAppSettings);

/// The camera preview with QR detection: flutter_zxing's reader (zxing-cpp
/// on the `camera` plugin), without its extra buttons.
///
/// The camera permission is requested when the reader starts the camera,
/// so only once the user opens the scanner. The reader pauses the camera
/// while the app is in the background.
class CameraQrScanner extends StatefulWidget {
  const CameraQrScanner({super.key, required this.onPayload, required this.problem});

  final ValueChanged<String> onPayload;
  final Widget Function(BuildContext context, ScannerProblem problem) problem;

  @override
  State<CameraQrScanner> createState() => _CameraQrScannerState();
}

class _CameraQrScannerState extends State<CameraQrScanner> {
  /// Null until the cameras are listed (which needs no permission).
  bool? _hasCamera;
  ScannerProblem? _problem;

  @override
  void initState() {
    super.initState();
    _findCamera();
  }

  Future<void> _findCamera() async {
    bool found;
    try {
      found = (await availableCameras()).isNotEmpty;
    } on Object {
      found = false;
    }
    if (mounted) setState(() => _hasCamera = found);
  }

  void _created(CameraController? controller, Exception? error) {
    if (error == null || !mounted) return;
    setState(
      () => _problem = switch (error) {
        CameraException(code: 'CameraAccessDenied' || 'CameraAccessDeniedWithoutPrompt' || 'CameraAccessRestricted') =>
          ScannerProblem.permissionDenied,
        _ => ScannerProblem.failed,
      },
    );
  }

  void _scanned(Code code) {
    final text = _textOf(code);
    if (text != null && text.isNotEmpty) widget.onPayload(text);
  }

  /// The code's bytes as UTF-8, which is what Thunderbird writes (without
  /// saying so in the code); zxing's own reading of the text otherwise.
  static String? _textOf(Code code) {
    final bytes = code.rawBytes;
    if (bytes != null && bytes.isNotEmpty) {
      try {
        return utf8.decode(bytes);
      } on FormatException {
        // Not UTF-8: fall back to zxing's guess.
      }
    }
    return code.text;
  }

  static const _waiting = ColoredBox(
    color: Colors.black,
    child: Center(child: CupertinoActivityIndicator(color: Colors.white)),
  );

  @override
  Widget build(BuildContext context) {
    if (_problem case final problem?) return widget.problem(context, problem);
    return switch (_hasCamera) {
      null => _waiting,
      false => widget.problem(context, ScannerProblem.unavailable),
      true => ReaderWidget(
        onScan: _scanned,
        onControllerCreated: _created,
        codeFormat: Format.qrCode,
        // Thunderbird's codes are dense (up to about 800 characters).
        tryHarder: true,
        resolution: ResolutionPreset.high,
        cropPercent: 0.8,
        scanDelay: const Duration(milliseconds: 200),
        scanDelaySuccess: const Duration(milliseconds: 500),
        showFlashlight: false,
        showGallery: false,
        showToggleCamera: false,
        scannerOverlay: const ScannerOverlayBorder(
          cutOutSize: 0.8,
          borderColor: Colors.white,
          overlayColor: Colors.black38,
          borderRadius: 14,
          borderLength: 28,
          borderWidth: 4,
        ),
        loading: _waiting,
      ),
    };
  }
}
