/// Deterministic mutation fuzzing of the S/MIME parsers: ASN.1, X.509, CMS
/// SignedData and EnvelopedData, PKCS #12 and whole messages.
///
/// Every iteration has its own random generator, seeded from the run's seed,
/// the target and the iteration number, so any failure can be replayed on
/// its own (`replay`). Seeds are the OpenSSL- and NSS-made fixtures.
///
/// `fuzz_test.dart` runs a few iterations; `tool/fuzz_smime.dart` runs many,
/// in parallel, with a watchdog for hangs.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:mail_crypto/mail_crypto.dart';
import 'package:mail_crypto/src/smime/der.dart';

import 'smime_support.dart';

/// One parser under test: seeds, how to run an input, which exceptions are fine.
final class FuzzTarget {
  FuzzTarget(this.name, this.seeds, this.run, {required this.allowed});

  final String name;
  final List<Uint8List> seeds;
  final void Function(Uint8List input) run;

  /// The exceptions a parser may throw on bad input (typed errors). Anything
  /// else is a failure.
  final bool Function(Object error) allowed;
}

/// A failure: an unexpected exception, or a call that took too long.
final class FuzzFailure {
  const FuzzFailure(this.target, this.iteration, this.input, this.error, this.stack, this.elapsed);

  final String target;
  final int iteration;
  final Uint8List input;
  final Object? error;
  final StackTrace? stack;
  final Duration elapsed;

  bool get slow => error == null;

  @override
  String toString() {
    final what = slow ? 'slow (${elapsed.inMilliseconds} ms)' : '${error.runtimeType}: $error';
    final first = stack?.toString().split('\n').take(6).join('\n    ') ?? '';
    return '[$target #$iteration, ${input.length} bytes] $what\n    $first';
  }
}

final class FuzzStats {
  int iterations = 0;
  Duration slowest = Duration.zero;
  final failures = <FuzzFailure>[];
}

/// The seed corpus: the fixtures, as DER.
final class FuzzCorpus {
  FuzzCorpus._();

  static final instance = FuzzCorpus._();

  Uint8List _der(String file) => MimeEntity.parse(smimeMail(file)).decodedBody;

  late final certificates = <Uint8List>[
    for (final f in [
      'root.crt',
      'intermediate.crt',
      'constrained.crt',
      'alice.crt',
      'bob.crt',
      'carol.crt',
      'dave.crt',
      'erin.crt',
      'frank.crt',
      'gina.crt',
      'hank.crt',
      'mallory.crt',
    ])
      readCertificates(smimeFixture(f)).single.der,
  ];

  /// p7s blobs with the content they sign (null: opaque).
  late final signed = <(Uint8List, Uint8List?)>[
    for (final f in ['signed-detached.eml', 'signed-noattr.eml', 'signed-untrusted.eml', 'signed-expired.eml'])
      () {
        final root = MimeEntity.parse(smimeMail(f));
        return (root.parts[1].decodedBody, canonicalLineEnds(root.parts[0].raw));
      }(),
    (_der('signed-opaque.eml'), null),
  ];

  late final enveloped = <Uint8List>[
    for (final f in [
      'enveloped-rsa.eml',
      'enveloped-oaep.eml',
      'enveloped-ec.eml',
      'enveloped-ec-sha1kdf.eml',
      'enveloped-3des.eml',
      'enveloped-stream.eml',
      'authenveloped.eml',
      'enveloped-other.eml',
    ])
      _der(f),
  ];

  late final pkcs12 = <(Uint8List, String)>[
    (smimeFixture('alice.p12'), 'alice-pass'),
    (smimeFixture('alice-legacy.p12'), 'alice-pass'),
    (smimeFixture('bob-3des.p12'), 'bob-pass'),
    (smimeFixture('bob-pbmac1.p12'), 'bob-pass'),
    (smimeFixture('dave-nopass.p12'), ''),
  ];

  late final messages = <Uint8List>[
    for (final f in [
      'signed-detached.eml',
      'signed-opaque.eml',
      'signed-enveloped.eml',
      'opaque-enveloped.eml',
      'authenveloped.eml',
      'enveloped-ec.eml',
    ])
      smimeMail(f),
  ];

  List<Uint8List> get allDer => [
    ...certificates,
    for (final (d, _) in signed) d,
    ...enveloped,
    for (final (d, _) in pkcs12) d,
  ];
}

/// The targets, over [corpus].
List<FuzzTarget> fuzzTargets([FuzzCorpus? corpus]) {
  final c = corpus ?? FuzzCorpus.instance;
  bool smimeError(Object e) => e is SmimeException;
  final keys = [alice, bob];
  const reader = SmimeReader(smime);
  return [
    FuzzTarget('asn1', c.allDer, (input) {
      final root = Asn1.parse(input);
      _walk(root, 0);
      Asn1.parseAll(Uint8List.sublistView(input, 0, min(input.length, root.encoded.length + 16)));
    }, allowed: (e) => e is Asn1Exception),
    FuzzTarget('x509', c.certificates, (input) {
      final cert = SmimeCertificate.fromDer(input);
      cert.fingerprint;
      cert.displayName;
      cert.issuerName;
      cert.subject.toString();
      cert.serialHex;
      cert.canSign;
      cert.canEncrypt;
      cert.pem;
      for (final usage in SmimeUsage.values) {
        checkTrust(
          cert,
          anchors: testAnchors,
          intermediates: [testCa, cert],
          at: today,
          usage: usage,
          email: 'alice@example.org',
          signedBy: smime.certificateSignedBy,
        );
      }
      readCertificates(input);
    }, allowed: smimeError),
    FuzzTarget('cms-signed', [for (final (d, _) in c.signed) d], (input) {
      for (final (_, content) in c.signed) {
        smime.verify(input, content: content);
      }
      smime.verify(input);
    }, allowed: smimeError),
    FuzzTarget('cms-enveloped', c.enveloped, (input) {
      smime.recipientsOf(input);
      smime.decrypt(input, keys);
    }, allowed: smimeError),
    FuzzTarget('pkcs12', [for (final (d, _) in c.pkcs12) d], (input) {
      for (final password in {for (final (_, p) in c.pkcs12) p}) {
        try {
          smime.readPkcs12(input, password);
        } on SmimeException catch (e) {
          if (e.kind != SmimeErrorKind.wrongPassword) rethrow;
        }
      }
    }, allowed: smimeError),
    FuzzTarget('message', c.messages, (input) {
      reader.read(input, keys: keys, anchors: testAnchors, now: today);
      reader.recipientsOf(input);
    }, allowed: (_) => false),
  ];
}

/// Reads everything an element offers, as the S/MIME code does.
void _walk(Asn1 e, int depth) {
  void guarded(void Function() f) {
    try {
      f();
    } on Asn1Exception {
      // A typed error: fine.
    }
  }

  e.encoded;
  e.content;
  guarded(() => e.integer);
  guarded(() => e.intValue);
  guarded(() => e.oid);
  guarded(() => e.string);
  guarded(() => e.time);
  guarded(() => e.octets);
  guarded(() => e.bits);
  guarded(() => e.namedBits);
  guarded(() => e.boolean);
  if (!e.constructed) {
    // Encapsulated DER (extensions, keys) is parsed again.
    guarded(() => _walk(Asn1.parse(e.content), depth + 1));
    return;
  }
  for (final child in e.children) {
    _walk(child, depth + 1);
  }
}

// Mutations ----------------------------------------------------------------------

/// A TLV found in a seed: where its identifier, length and content are.
typedef _Node = ({int start, int lengthAt, int contentStart, int end});

final _nodeCache = Expando<List<_Node>>('ASN.1 nodes');

/// Every definite-length element of [b], walking into constructed ones and
/// into OCTET STRING and BIT STRING contents that are DER themselves.
List<_Node> _nodes(Uint8List b) => _nodeCache[b] ??= () {
  final out = <_Node>[];
  void scan(int start, int end, int depth) {
    var at = start;
    while (at < end && depth < 64) {
      if (at + 2 > end) return;
      final tag = b[at];
      if (tag & 0x1f == 0x1f) return;
      var p = at + 1;
      final first = b[p++];
      int length;
      if (first < 0x80) {
        length = first;
      } else {
        final n = first & 0x7f;
        if (n == 0 || n > 4 || p + n > end) return;
        length = 0;
        for (var i = 0; i < n; i++) {
          length = (length << 8) | b[p++];
        }
      }
      if (p + length > end) return;
      out.add((start: at, lengthAt: at + 1, contentStart: p, end: p + length));
      if (tag & 0x20 != 0) {
        scan(p, p + length, depth + 1);
      } else if (tag == 0x04 && length > 2 && b[p] & 0x20 != 0) {
        scan(p, p + length, depth + 1);
      } else if (tag == 0x03 && length > 3 && b[p] == 0 && b[p + 1] & 0x20 != 0) {
        scan(p + 1, p + length, depth + 1);
      }
      at = p + length;
    }
  }

  scan(0, b.length, 0);
  return out;
}();

Uint8List _lengthBytes(int n) {
  if (n < 0x80) return Uint8List.fromList([n]);
  final bytes = <int>[];
  for (var v = n; v > 0; v >>= 8) {
    bytes.insert(0, v & 0xff);
  }
  return Uint8List.fromList([0x80 | bytes.length, ...bytes]);
}

Uint8List _replace(Uint8List b, int from, int to, List<int> by) {
  final out = BytesBuilder(copy: false)
    ..add(Uint8List.sublistView(b, 0, from))
    ..add(by)
    ..add(Uint8List.sublistView(b, to));
  return out.takeBytes();
}

const _interesting = [0x00, 0x01, 0x02, 0x7f, 0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x88, 0xa0, 0xff];
const _tags = [
  0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x0c, 0x13, 0x14, 0x16, 0x17, 0x18, 0x1c, 0x1e, //
  0x24, 0x30, 0x31, 0x80, 0x81, 0xa0, 0xa1, 0xa2, 0xa3, 0x00, 0x1f,
];

/// One mutation of [b] (an ASN.1-aware one most of the time).
Uint8List _mutateOnce(Uint8List b, Random r, List<Uint8List> pool) {
  if (b.isEmpty) return Uint8List.fromList([r.nextInt(256)]);
  final nodes = _nodes(b);
  int pos() => r.nextInt(b.length);
  final choice = r.nextInt(nodes.isEmpty ? 8 : 22);
  switch (choice) {
    case 0: // flip a bit
      final p = pos();
      return Uint8List.fromList(b)..[p] ^= 1 << r.nextInt(8);
    case 1: // a random byte
      return Uint8List.fromList(b)..[pos()] = r.nextInt(256);
    case 2: // an interesting byte
      return Uint8List.fromList(b)..[pos()] = _interesting[r.nextInt(_interesting.length)];
    case 3: // insert bytes
      final p = pos();
      return _replace(b, p, p, [for (var i = r.nextInt(16) + 1; i > 0; i--) r.nextInt(256)]);
    case 4: // delete a range
      final p = pos();
      return _replace(b, p, min(b.length, p + 1 + r.nextInt(32)), const []);
    case 5: // duplicate a range
      final p = pos();
      final q = min(b.length, p + 1 + r.nextInt(64));
      final at = pos();
      return _replace(b, at, at, Uint8List.sublistView(b, p, q));
    case 6: // truncate
      return Uint8List.sublistView(b, 0, pos());
    case 7: // splice another seed in
      if (pool.isEmpty) return b;
      final other = pool[r.nextInt(pool.length)];
      if (other.isEmpty) return b;
      final p = pos();
      final q = r.nextInt(other.length);
      return _replace(b, p, min(b.length, p + r.nextInt(64)), Uint8List.sublistView(other, q, min(other.length, q + 1 + r.nextInt(256))));
  }
  final n = nodes[r.nextInt(nodes.length)];
  final content = Uint8List.sublistView(b, n.contentStart, n.end);
  switch (choice) {
    case 8: // indefinite length (with or without end-of-contents)
      final eoc = r.nextBool();
      return Uint8List.fromList([
        ...Uint8List.sublistView(b, 0, n.start),
        b[n.start] | (r.nextInt(4) == 0 ? 0 : 0x20),
        0x80,
        ...content,
        if (eoc) ...[0, 0],
        ...Uint8List.sublistView(b, n.end),
      ]);
    case 9: // a huge declared length
      final huge = [0x84, 0x7f + r.nextInt(0x81), r.nextInt(256), r.nextInt(256), r.nextInt(256)];
      return _replace(b, n.lengthAt, n.contentStart, huge);
    case 10: // length off by a little
      final delta = r.nextInt(5) - 2;
      return _replace(b, n.lengthAt, n.contentStart, _lengthBytes(max(0, n.end - n.contentStart + delta)));
    case 11: // non-minimal length
      final len = n.end - n.contentStart;
      return _replace(b, n.lengthAt, n.contentStart, [0x84, (len >> 24) & 0xff, (len >> 16) & 0xff, (len >> 8) & 0xff, len & 0xff]);
    case 12: // another tag
      return Uint8List.fromList(b)..[n.start] = _tags[r.nextInt(_tags.length)];
    case 13: // random content, same length
      return _replace(b, n.contentStart, n.end, [for (var i = 0; i < content.length; i++) r.nextInt(256)]);
    case 14: // this element replaced by one of another seed
      if (pool.isEmpty) return b;
      final other = pool[r.nextInt(pool.length)];
      final on = _nodes(other);
      if (on.isEmpty) return b;
      final m = on[r.nextInt(on.length)];
      return _replace(b, n.start, n.end, Uint8List.sublistView(other, m.start, m.end));
    case 15: // nested deeply
      var e = Uint8List.sublistView(b, n.start, n.end);
      final tag = r.nextBool() ? 0x30 : (r.nextBool() ? 0xa0 : 0x24);
      final depth = 1 + r.nextInt(r.nextBool() ? 8 : 300);
      final indefinite = r.nextInt(3) == 0;
      for (var i = 0; i < depth; i++) {
        e = indefinite
            ? Uint8List.fromList([tag, 0x80, ...e, 0, 0])
            : Uint8List.fromList([tag, ..._lengthBytes(e.length), ...e]);
      }
      return _replace(b, n.start, n.end, e);
    case 16: // repeated (many certificates, signers, recipients, attributes)
      final e = Uint8List.sublistView(b, n.start, n.end);
      final times = 2 + r.nextInt(r.nextBool() ? 4 : 200);
      final out = BytesBuilder(copy: false);
      for (var i = 0; i < times; i++) {
        out.add(e);
      }
      return _replace(b, n.start, n.end, out.takeBytes());
    case 17: // a large content (integers, strings, octets)
      final size = [64, 1024, 20000, 200000][r.nextInt(4)];
      final fill = r.nextInt(256);
      final big = Uint8List(size)..fillRange(0, size, fill);
      if (r.nextBool()) big[0] = 0x7f;
      return _replace(b, n.lengthAt, n.end, [..._lengthBytes(size), ...big]);
    case 18: // emptied
      return _replace(b, n.lengthAt, n.end, const [0]);
    case 19: // removed
      return _replace(b, n.start, n.end, const []);
    case 20: // a small integer value (versions, lengths, counts)
      final v = [0, 1, -1, 3, 12, 16, 255, 0x7fffffff, 0x100000000][r.nextInt(9)];
      return _replace(b, n.start, n.end, derInt(v));
    default: // the constructed bit flipped
      return Uint8List.fromList(b)..[n.start] ^= 0x20;
  }
}

/// [seed] with one to four stacked mutations.
Uint8List mutate(Uint8List seed, Random r, List<Uint8List> pool) {
  var out = seed;
  for (var n = 1 + r.nextInt(r.nextInt(4) == 0 ? 4 : 2); n > 0; n--) {
    out = _mutateOnce(out, r, pool);
    if (out.length > 4 << 20) out = Uint8List.sublistView(out, 0, 4 << 20);
  }
  return out;
}

/// The input of iteration [i] for [target] in run [seed].
Uint8List fuzzInput(FuzzTarget target, int seed, int i, List<Uint8List> pool) {
  final r = Random(Object.hash(seed, target.name, i) & 0x7fffffff);
  final base = target.seeds[r.nextInt(target.seeds.length)];
  if (target.name == 'message') return _mutateMessage(base, r, pool);
  return mutate(base, r, pool);
}

/// A message with its CMS part mutated (re-encoded) or its MIME bytes changed.
Uint8List _mutateMessage(Uint8List raw, Random r, List<Uint8List> pool) {
  if (r.nextInt(4) == 0) return mutate(raw, r, const []);
  final text = latin1.decode(raw);
  // The base64 body of the S/MIME part: the last run of base64 lines.
  final m = RegExp(r'\r?\n\r?\n((?:[A-Za-z0-9+/=]+\r?\n)+)').allMatches(text).lastOrNull;
  if (m == null) return mutate(raw, r, const []);
  final der = base64.decode(m.group(1)!.replaceAll(RegExp(r'\s'), ''));
  final bad = mutate(der, r, pool);
  final b64 = base64.encode(bad);
  final lines = [for (var i = 0; i < b64.length; i += 64) b64.substring(i, min(b64.length, i + 64))].join('\r\n');
  final start = m.end - m.group(1)!.length;
  return latin1.encode('${text.substring(0, start)}$lines\r\n${text.substring(m.end)}');
}

/// Runs one input; returns the failure, if any.
FuzzFailure? runOne(FuzzTarget target, int i, Uint8List input, {Duration slow = const Duration(seconds: 2)}) {
  final watch = Stopwatch()..start();
  Object? error;
  StackTrace? stack;
  try {
    target.run(input);
  } on Object catch (e, s) {
    if (!target.allowed(e)) {
      error = e;
      stack = s;
    }
  }
  watch.stop();
  if (error != null) return FuzzFailure(target.name, i, input, error, stack, watch.elapsed);
  if (watch.elapsed > slow) return FuzzFailure(target.name, i, input, null, null, watch.elapsed);
  return null;
}

/// Runs [iterations] inputs per target, from [seed]; iteration numbers
/// [from] on (to shard a run).
FuzzStats fuzz({
  required List<FuzzTarget> targets,
  required int iterations,
  int seed = 26,
  int from = 0,
  Duration slow = const Duration(seconds: 2),
  void Function(FuzzTarget target, int i, Uint8List input)? before,
}) {
  final stats = FuzzStats();
  final pool = FuzzCorpus.instance.allDer;
  for (final target in targets) {
    for (var i = from; i < from + iterations; i++) {
      final input = fuzzInput(target, seed, i, pool);
      before?.call(target, i, input);
      final watch = Stopwatch()..start();
      final failure = runOne(target, i, input, slow: slow);
      if (watch.elapsed > stats.slowest) stats.slowest = watch.elapsed;
      stats.iterations++;
      if (failure != null) stats.failures.add(failure);
    }
  }
  return stats;
}

/// Writes [failure]'s input under `.dart_tool/fuzz-failures` and returns the path.
String saveFailure(FuzzFailure failure) {
  final dir = Directory('.dart_tool/fuzz-failures')..createSync(recursive: true);
  final f = File('${dir.path}/${failure.target}-${failure.iteration}.bin')..writeAsBytesSync(failure.input);
  return f.path;
}
