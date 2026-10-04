import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/platform/error_log.dart';

void main() {
  late Directory dir;
  setUp(() => dir = Directory.systemTemp.createTempSync('loupe_error_log'));
  tearDown(() => dir.deleteSync(recursive: true));

  File logFile() => File('${dir.path}/logs/errors.log');

  test('logs the type and the stack, never the message', () async {
    final log = ErrorLog(Future.value(dir), clock: () => DateTime.utc(2026, 10, 5, 7));
    await log.record(const FormatException('Subject: Your biopsy results'), StackTrace.current, where: 'uncaught');
    final text = logFile().readAsStringSync();
    expect(text, startsWith('2026-10-05T07:00:00.000Z FormatException uncaught\n'));
    expect(text, contains('error_log_test.dart'));
    expect(text, isNot(contains('biopsy')));
  });

  test('stays under its size limit', () async {
    final log = ErrorLog(Future.value(dir));
    final stack = StackTrace.fromString(List.filled(ErrorLog.maxFrames, '#0 frame ${'x' * 200}').join('\n'));
    for (var i = 0; i < 100; i++) {
      await log.record(StateError('$i'), stack);
    }
    expect(logFile().lengthSync(), lessThanOrEqualTo(ErrorLog.maxBytes));
    expect(logFile().readAsStringSync(), matches(RegExp(r'^\d{4}-')));
  });

  testWidgets('handlers log errors, keep uncaught ones from crashing and show a friendly box', (tester) async {
    final onError = FlutterError.onError;
    final platformOnError = PlatformDispatcher.instance.onError;
    final builder = ErrorWidget.builder;
    // Restored before the test ends: the binding checks these.
    void restore() {
      FlutterError.onError = onError;
      PlatformDispatcher.instance.onError = platformOnError;
      ErrorWidget.builder = builder;
    }

    try {
      final log = ErrorLog(Future.value(dir));
      installErrorHandlers(log, friendlyErrorWidget: true);

      final box = ErrorWidget.builder(FlutterErrorDetails(exception: StateError('build failed')));
      await tester.pumpWidget(box);
      expect(find.textContaining('Something went wrong'), findsOneWidget);

      // File I/O needs real time.
      await tester.runAsync(() async {
        expect(PlatformDispatcher.instance.onError!(StateError('boom'), StackTrace.current), isTrue);
        await log.flushed;
      });
      expect(logFile().readAsStringSync(), contains('StateError uncaught'));
    } finally {
      restore();
    }
  });
}
