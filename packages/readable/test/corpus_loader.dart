// Loads the synthetic corpus in test/corpus: `<name>.html` or `<name>.txt`,
// with an optional `<name>.json` sidecar:
//
//   {"cids": ["a@b"]}      Content-IDs the host can resolve (inline parts)
//   {"isFlowed": true}     the text part is format=flowed
//   {"repeat": 100}        repeat the body (size limits)
//   {"nest": 5000}         wrap the body in this many <div>s (depth limits)
//   {"summary": true}      snapshot only stats and the first blocks
//   {"smoke": false}       skip the widget smoke test (too big to lay out)

import 'dart:convert';
import 'dart:io';

final class CorpusEntry {
  CorpusEntry({required this.name, this.html, this.text, this.sidecar = const {}});

  final String name;
  final String? html;
  final String? text;
  final Map<String, Object?> sidecar;

  bool get isFlowed => sidecar['isFlowed'] == true;
  bool get summary => sidecar['summary'] == true;
  bool get smoke => sidecar['smoke'] != false;
  Set<String> get contentIds => {...((sidecar['cids'] as List<Object?>?) ?? const []).cast<String>()};
}

final corpusDir = Directory('test/corpus');

List<CorpusEntry> loadCorpus() {
  final files =
      corpusDir.listSync().whereType<File>().where((f) => f.path.endsWith('.html') || f.path.endsWith('.txt')).toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  return [for (final f in files) _load(f)];
}

CorpusEntry _load(File file) {
  final base = file.uri.pathSegments.last;
  final name = base.substring(0, base.lastIndexOf('.'));
  final sidecarFile = File('${corpusDir.path}/$name.json');
  final sidecar = sidecarFile.existsSync()
      ? (jsonDecode(sidecarFile.readAsStringSync()) as Map<String, Object?>)
      : const <String, Object?>{};
  var body = file.readAsStringSync();
  final repeat = sidecar['repeat'] as int?;
  if (repeat != null) body = List.filled(repeat, body).join('\n');
  final nest = sidecar['nest'] as int?;
  if (nest != null) body = '${'<div>' * nest}$body${'</div>' * nest}';
  return file.path.endsWith('.txt')
      ? CorpusEntry(name: name, text: body, sidecar: sidecar)
      : CorpusEntry(name: name, html: body, sidecar: sidecar);
}
