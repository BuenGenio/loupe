// Long fuzzing runs of the S/MIME parsers (see test/smime/fuzz_harness.dart),
// from packages/mail_crypto:
//
//   dart run tool/fuzz_smime.dart --iterations 20000 --workers 8 [--targets asn1,x509] [--seed 26]
//
// Each worker isolate takes its own range of iterations per target. A watchdog
// kills a worker whose input runs longer than --hang seconds, saves the input
// and goes on; failing inputs land in .dart_tool/fuzz-failures.
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import '../test/smime/fuzz_harness.dart';

Future<void> main(List<String> args) async {
  String? option(String name) {
    final i = args.indexOf('--$name');
    return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
  }

  final iterations = int.parse(option('iterations') ?? '1000');
  final workers = int.parse(option('workers') ?? '${Platform.numberOfProcessors}');
  final seed = int.parse(option('seed') ?? '26');
  final hang = Duration(seconds: int.parse(option('hang') ?? '30'));
  final names = option('targets')?.split(',');
  final all = fuzzTargets().map((t) => t.name).toList();
  final targets = names ?? all;

  final watch = Stopwatch()..start();
  var done = 0;
  var maxRss = ProcessInfo.currentRss;
  final failures = <String>[];
  final slowest = <String, int>{};

  Future<void> runWorker(int w) async {
    var from = w * iterations;
    final end = from + iterations;
    while (from < end) {
      final port = ReceivePort();
      final exit = ReceivePort();
      final isolate = await Isolate.spawn(_worker, (port.sendPort, targets, seed, from, end), onExit: exit.sendPort);
      var current = (targets.first, from);
      var lastProgress = DateTime.now();
      var finished = false;
      final sub = port.listen((message) {
        lastProgress = DateTime.now();
        switch (message) {
          case ('start', final String t, final int i):
            current = (t, i);
          case ('done', final String t, final int ms):
            done++;
            if (ms > (slowest[t] ?? 0)) slowest[t] = ms;
          case ('failure', final String report):
            failures.add(report);
            stderr.writeln(report);
          case ('end',):
            finished = true;
        }
      });
      final exited = exit.first;
      while (!finished) {
        final rss = ProcessInfo.currentRss;
        if (rss > maxRss) maxRss = rss;
        final stopped = await Future.any([
          exited.then((_) => true),
          Future.delayed(const Duration(seconds: 1), () => false),
        ]);
        if (stopped) break;
        if (DateTime.now().difference(lastProgress) > hang) {
          final (t, i) = current;
          final target = fuzzTargets().firstWhere((x) => x.name == t);
          final input = fuzzInput(target, seed, i, FuzzCorpus.instance.allDer);
          final path = saveFailure(FuzzFailure(t, i, input, 'hang', null, hang));
          final report = '[$t #$i] HANG (> ${hang.inSeconds} s), input saved to $path';
          failures.add(report);
          stderr.writeln(report);
          isolate.kill(priority: Isolate.immediate);
          break;
        }
      }
      await sub.cancel();
      port.close();
      exit.close();
      if (finished) break;
      // Killed or crashed: go on after the input it was on.
      from = current.$2 + 1;
    }
  }

  final ticker = Timer.periodic(const Duration(seconds: 30), (_) {
    stdout.writeln(
      '${watch.elapsed.inSeconds} s: $done inputs, ${failures.length} failures, '
      'max RSS ${maxRss >> 20} MB',
    );
  });
  await Future.wait([for (var w = 0; w < workers; w++) runWorker(w)]);
  ticker.cancel();
  stdout
    ..writeln(
      'Done: $done inputs (${targets.join(', ')}) in ${watch.elapsed.inSeconds} s, '
      'max RSS ${maxRss >> 20} MB',
    )
    ..writeln('Slowest input per target (ms): $slowest')
    ..writeln('${failures.length} failures');
  for (final f in failures) {
    stdout.writeln(f);
  }
  exitCode = failures.isEmpty ? 0 : 1;
}

void _worker((SendPort, List<String>, int, int, int) args) {
  final (port, names, seed, from, end) = args;
  final targets = [
    for (final t in fuzzTargets())
      if (names.contains(t.name)) t,
  ];
  final pool = FuzzCorpus.instance.allDer;
  for (var i = from; i < end; i++) {
    for (final target in targets) {
      port.send(('start', target.name, i));
      final input = fuzzInput(target, seed, i, pool);
      final watch = Stopwatch()..start();
      final failure = runOne(target, i, input, slow: const Duration(seconds: 5));
      port.send(('done', target.name, watch.elapsedMilliseconds));
      if (failure != null) {
        final path = saveFailure(failure);
        port.send(('failure', '$failure\n    input: $path'));
      }
    }
  }
  port.send(('end',));
}
