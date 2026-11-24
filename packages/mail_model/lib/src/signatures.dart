import 'dart:convert';
import 'dart:math';

import 'address.dart';

/// When a signature is used: the signature.cc rules. A signature without
/// rules ([always]) is an ordinary one; the first of those is the
/// identity's default.
///
/// - [whenCopied]: for messages that copy someone (Cc), optionally only
///   when one of [copied] is among them.
/// - [from] and [until]: only between those days (a campaign, holiday
///   hours). While it runs it takes the place of the ordinary signatures.
/// - [rotate]: one of the signatures in rotation is picked at random for
///   each new message.
///
/// [chooseSignature] applies them.
final class SignatureRule {
  const SignatureRule({this.whenCopied = false, this.copied = const [], this.from, this.until, this.rotate = false});

  static const always = SignatureRule();

  final bool whenCopied;

  /// Addresses or patterns (`ana@client.example`, `*@client.example`, or
  /// a bare domain); empty means anyone in Cc.
  final List<String> copied;

  /// First and last day (local dates; the time is ignored). Either may be
  /// open.
  final DateTime? from;
  final DateTime? until;

  final bool rotate;

  bool get isScheduled => from != null || until != null;

  bool get isAlways => !whenCopied && !isScheduled && !rotate;

  /// Whether [day] (local) is within [from] and [until].
  bool activeOn(DateTime day) {
    final d = _day(day);
    final start = from;
    final end = until;
    if (start != null && d.isBefore(_day(start))) return false;
    if (end != null && d.isAfter(_day(end))) return false;
    return true;
  }

  /// Whether [cc] copies someone this rule is for. False without
  /// [whenCopied] or without anyone in Cc.
  bool matchesCopied(List<EmailAddress> cc) {
    if (!whenCopied || cc.isEmpty) return false;
    if (copied.isEmpty) return true;
    return cc.any((a) => copied.any((p) => addressMatches(p, a.email)));
  }

  SignatureRule copyWith({
    bool? whenCopied,
    List<String>? copied,
    DateTime? Function()? from,
    DateTime? Function()? until,
    bool? rotate,
  }) => SignatureRule(
    whenCopied: whenCopied ?? this.whenCopied,
    copied: copied ?? this.copied,
    from: from == null ? this.from : from(),
    until: until == null ? this.until : until(),
    rotate: rotate ?? this.rotate,
  );

  Map<String, Object?> toJson() => {
    if (whenCopied) 'whenCopied': true,
    if (copied.isNotEmpty) 'copied': copied,
    if (from case final d?) 'from': _dateJson(d),
    if (until case final d?) 'until': _dateJson(d),
    if (rotate) 'rotate': true,
  };

  factory SignatureRule.fromJson(Object? json) {
    if (json is! Map) return always;
    return SignatureRule(
      whenCopied: json['whenCopied'] == true,
      copied: [for (final p in (json['copied'] as List? ?? const [])) p as String],
      from: _dateFromJson(json['from']),
      until: _dateFromJson(json['until']),
      rotate: json['rotate'] == true,
    );
  }
}

/// One signature of an identity.
final class Signature {
  const Signature({required this.id, this.name = '', required this.content, this.rule = SignatureRule.always});

  /// A signature of plain text.
  factory Signature.plain(String id, String text, {String name = ''}) {
    final t = text.trimRight();
    return Signature(
      id: id,
      name: name,
      content: jsonEncode([
        {'insert': '$t\n'},
      ]),
    );
  }

  final String id;

  /// What the user calls it ("Work", "Short"); may be empty.
  final String name;

  /// The signature as a Quill Delta (JSON): formatted text, images as
  /// `data:` URIs and fields (`{"loupe-field": "name"}`). The app renders it;
  /// [plainText] is enough without formatting.
  final String content;

  final SignatureRule rule;

  /// The text without formatting, images or fields: a preview, and the
  /// signature of code that doesn't render Delta.
  String get plainText {
    try {
      final ops = jsonDecode(content);
      if (ops is! List) return '';
      final out = StringBuffer();
      for (final op in ops) {
        if (op is Map && op['insert'] is String) out.write(op['insert']);
      }
      return out.toString().trimRight();
    } on FormatException {
      return '';
    }
  }

  Signature copyWith({String? name, String? content, SignatureRule? rule}) =>
      Signature(id: id, name: name ?? this.name, content: content ?? this.content, rule: rule ?? this.rule);

  Map<String, Object?> toJson() => {
    'id': id,
    if (name.isNotEmpty) 'name': name,
    'content': content,
    if (!rule.isAlways) 'rule': rule.toJson(),
  };

  factory Signature.fromJson(Map<String, Object?> json) => Signature(
    id: json['id']! as String,
    name: json['name'] as String? ?? '',
    content: json['content']! as String,
    rule: SignatureRule.fromJson(json['rule']),
  );
}

/// The signature a message gets from [signatures] (an identity's, in order),
/// as signature.cc picks it:
///
/// 1. Only signatures whose schedule includes [now]'s day count.
/// 2. With anyone in [cc]: a "when copied" signature naming one of them,
///    else one for anyone copied.
/// 3. Otherwise (or with none of those): a scheduled ordinary signature
///    while one runs, else the ordinary ones.
/// 4. Among the candidates, one in rotation at random ([seed] makes the
///    pick repeatable, so a message keeps it while Cc changes), else the
///    first.
///
/// Null when none applies: no signature.
Signature? chooseSignature(
  List<Signature> signatures, {
  required DateTime now,
  List<EmailAddress> cc = const [],
  int? seed,
}) {
  final live = [
    for (final s in signatures)
      if (s.rule.activeOn(now)) s,
  ];
  var tier = <Signature>[];
  if (cc.isNotEmpty) {
    final named = [
      for (final s in live)
        if (s.rule.copied.isNotEmpty && s.rule.matchesCopied(cc)) s,
    ];
    tier = named.isNotEmpty
        ? named
        : [
            for (final s in live)
              if (s.rule.whenCopied && s.rule.copied.isEmpty) s,
          ];
  }
  if (tier.isEmpty) {
    final ordinary = [
      for (final s in live)
        if (!s.rule.whenCopied) s,
    ];
    final scheduled = [
      for (final s in ordinary)
        if (s.rule.isScheduled) s,
    ];
    tier = scheduled.isNotEmpty ? scheduled : ordinary;
  }
  if (tier.isEmpty) return null;
  final rotating = [
    for (final s in tier)
      if (s.rule.rotate) s,
  ];
  if (rotating.isNotEmpty) return rotating[Random(seed).nextInt(rotating.length)];
  return tier.first;
}

/// Whether [email] matches [pattern]: an address, a wildcard pattern
/// (`*@example.com`, `me+*@example.com`) or a bare domain (`example.com`,
/// which also takes its subdomains). Case-insensitive.
bool addressMatches(String pattern, String email) {
  final p = pattern.trim().toLowerCase();
  final e = email.trim().toLowerCase();
  if (p.isEmpty || e.isEmpty) return false;
  if (!p.contains('@')) {
    final domain = e.substring(e.lastIndexOf('@') + 1);
    return domain == p || domain.endsWith('.$p');
  }
  if (!p.contains('*')) return p == e;
  final re = RegExp('^${p.split('*').map(RegExp.escape).join('.*')}\$');
  return re.hasMatch(e);
}

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

String _dateJson(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

DateTime? _dateFromJson(Object? v) {
  if (v is! String) return null;
  final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(v);
  return m == null ? null : DateTime(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
}
