import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../l10n/l10n.dart';

/// Errors nothing else caught, kept in `logs/errors.log` in the app support
/// directory for when something goes wrong on a device.
///
/// A line holds the time, the error's type, where it happened and the stack
/// trace; never the error's message, which may quote mail (subjects,
/// addresses, server replies). The file stays under [maxBytes] by dropping
/// its older half.
final class ErrorLog {
  ErrorLog(this._directory, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final Future<Directory> _directory;
  final DateTime Function() _clock;

  static const maxBytes = 256 * 1024;

  /// Stack frames kept per error.
  static const maxFrames = 25;

  Future<void> _writes = Future.value();

  /// Completes when everything recorded so far is written.
  Future<void> get flushed => _writes;

  /// Appends [error] (its type) and [stack]; [where] says what was going on
  /// (e.g. Flutter's "while building ConversationScreen").
  Future<void> record(Object error, StackTrace? stack, {String? where}) {
    final frames = (stack?.toString() ?? '').split('\n').where((l) => l.trim().isNotEmpty).take(maxFrames);
    final entry = StringBuffer()
      ..writeln('${_clock().toUtc().toIso8601String()} ${error.runtimeType}${where == null ? '' : ' $where'}');
    for (final f in frames) {
      entry.writeln('  $f');
    }
    return _writes = _writes.then((_) => _append(entry.toString())).catchError((Object _) {});
  }

  Future<void> _append(String entry) async {
    final dir = Directory('${(await _directory).path}/logs');
    await dir.create(recursive: true);
    final file = File('${dir.path}/errors.log');
    if (file.existsSync() && file.lengthSync() + entry.length > maxBytes) {
      final text = await file.readAsString();
      final keep = text.substring(text.length ~/ 2);
      // From the next entry on (frames are indented).
      final start = keep.indexOf(RegExp(r'\n(?=[^ ])'));
      await file.writeAsString(start < 0 ? '' : keep.substring(start + 1));
    }
    await file.writeAsString(entry, mode: FileMode.append, flush: true);
  }
}

/// Catches what would otherwise end up as a crash or a red screen:
///
/// - Flutter framework errors (build, layout, gestures) are logged; outside
///   release builds they are also printed as usual;
/// - uncaught asynchronous errors are logged and marked handled, so the app
///   keeps running;
/// - with [friendlyErrorWidget] (release and profile builds), a widget that
///   fails to build shows a short apology instead of the error box.
void installErrorHandlers(ErrorLog log, {bool friendlyErrorWidget = !kDebugMode}) {
  FlutterError.onError = (details) {
    unawaited(log.record(details.exception, details.stack, where: details.context?.toDescription()));
    if (!kReleaseMode) FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(log.record(error, stack, where: 'uncaught'));
    if (!kReleaseMode) debugPrint('Uncaught ${error.runtimeType}: $error\n$stack');
    return true;
  };
  if (friendlyErrorWidget) ErrorWidget.builder = (details) => const FriendlyErrorBox();
}

/// Stands in for a widget that failed to build. The failure may be above
/// the app's localizations, so it falls back to the device's language.
class FriendlyErrorBox extends StatelessWidget {
  const FriendlyErrorBox({super.key});

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
    child: ColoredBox(
      color: const Color(0x0F8E8E93),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            (Localizations.of<AppLocalizations>(context, AppLocalizations) ?? deviceL10n()).platformErrorBox,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 14, decoration: TextDecoration.none),
          ),
        ),
      ),
    ),
  );
}
