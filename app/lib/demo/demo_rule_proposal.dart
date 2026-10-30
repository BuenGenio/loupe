import 'dart:convert';

import 'package:mail_ai/mail_ai.dart';

import '../features/ai/demo_ai_provider.dart';

/// The built-in demo's answer to `rules.propose` (RuleProposalTask): rules
/// over the sentence instead of a model. It splits the sentence into clauses
/// ("…, but …", "… and mark them read") and reads each for one action:
/// "move/file … to/in a folder", "tag … as a tag", "mark … (as) read",
/// "flag …", "junk"/"spam", "keep … in the inbox", "archive", "delete" (a
/// move to Trash) and "forward … to an address". Folders and tags must be the
/// account's own, as the task lists them; any other is reported as unknown,
/// never guessed. "Quiet", "mute", "notify me", "alert me" are reported as
/// something rules can't do, and a kind of mail in them ("invoices") as
/// something Loupe can't recognise, with a subject word to choose instead.
/// The rest of a clause is the condition: a sender after "from" or a name
/// before "newsletters", a kind of mail as a subject word (the explanation
/// says it is a word match), and demoTranslate for the other words. The
/// answer goes through RuleProposalTask's parser like a model's.
String demoRuleProposal(AiRequest request, DateTime now) {
  Map<String, Object?> data;
  try {
    data = jsonDecode(request.input.split('\n').first) as Map<String, Object?>;
  } on FormatException {
    data = const {};
  }
  final folders = <({String path, String? role})>[
    for (final f in data['folders'] as List? ?? const [])
      if (f is Map && f['path'] is String) (path: f['path'] as String, role: f['role'] as String?),
  ];
  final tags = [
    for (final t in data['tags'] as List? ?? const [])
      if (t is String) t,
  ];
  return jsonEncode(_DemoRule(data['sentence'] as String? ?? '', folders, tags, now).answer());
}

const _verbs =
    'move|file|put|send|tag|label|flag|mark|forward|redirect|keep|notify|alert|tell|ping|junk|delete|trash|archive|mute';

/// Where one clause ends and the next begins.
final _clauseBreak = RegExp(
  r'\s*(?:[,;]|\.(?=\s|$)|\bbut\b|\bthen\b|\balso\b|\band\b(?=\s+(?:' + _verbs + r')\b))\s*',
  caseSensitive: false,
);

final _notification = RegExp(
  r'\b(?:quiet|quietly|silent|silently|silence|mute|muted|notify|notified|notifications?|alerts?|ping|buzz|let me know|tell me)\b',
  caseSensitive: false,
);

/// The words of a notification request that aren't about which mail.
final _notificationWords = RegExp(
  r"\b(?:keep|make|leave|stay|stays|quiet|quietly|silent|silently|silence|mute|muted|still|only|just|don't|do not|no|notifications?|alerts?)\b|\b(?:notify|alert|ping|tell|buzz)\s+me\b|\blet me know\b",
  caseSensitive: false,
);

final _pronouns = RegExp(r'\b(?:it|them|these|those|they|this|that|please|ones)\b', caseSensitive: false);

final _every = RegExp(
  r'\b(?:everything|every (?:message|mail|email)|all (?:my |the )?(?:mail|messages|emails)|all of it)\b',
  caseSensitive: false,
);

/// A sender after "from": an address or domain, a run of capitalised
/// words ("Harbor Coffee"), or one word.
final _from = RegExp(
  r"\b[Ff]rom\s+([^\s,;]+@[^\s,;]+|[\w-]+\.[A-Za-z]{2,}\b|\p{Lu}[\p{L}\p{N}'’&.-]*(?:\s+\p{Lu}[\p{L}\p{N}'’&.-]*)*|[\p{Ll}\p{N}][\p{L}\p{N}'’&.-]*)",
  unicode: true,
);

/// A name before a kind of mail: "Trailhead newsletters".
final _namedKind = RegExp(
  r"(\p{Lu}[\p{L}\p{N}'’&.-]*(?:\s+\p{Lu}[\p{L}\p{N}'’&.-]*)*)\s+(?=(?:newsletters?|mail|emails?|messages?|updates?|news|receipts?|invoices?|bills?|statements?|orders?)\b)",
  unicode: true,
);

final _capitalised = RegExp(r"^\p{Lu}[\p{L}\p{N}'’&.-]*(?:\s+\p{Lu}[\p{L}\p{N}'’&.-]*)*$", unicode: true);

/// Kinds of mail that are matched as a subject word, in the singular.
const _kinds = {
  'receipt': 'receipt',
  'receipts': 'receipt',
  'invoice': 'invoice',
  'invoices': 'invoice',
  'bill': 'bill',
  'bills': 'bill',
  'statement': 'statement',
  'statements': 'statement',
  'order': 'order',
  'orders': 'order',
  'ticket': 'ticket',
  'tickets': 'ticket',
  'booking': 'booking',
  'bookings': 'booking',
};

final _kind = RegExp(r'\b(' + _kinds.keys.join('|') + r')\b', caseSensitive: false);

final _generic = RegExp(r'\b(?:mail|mails|emails?|messages?|newsletters?|updates?|news)\b', caseSensitive: false);

/// Words left over at the edges of a condition once its terms are taken.
final _edges = RegExp(
  r'^(?:\s*\b(?:of|for|on|and|or|to|the|my|all|any)\b\s*)+|(?:\s*\b(?:about|of|for|on|and|or)\b\s*)+$',
  caseSensitive: false,
);

const _senderStop = {'the', 'a', 'an', 'my', 'last', 'past', 'this', 'today', 'yesterday'};

final class _Condition {
  final terms = <String>[];
  final said = <String>[];
  String? sender;
  String? keyword;
  bool every = false;

  bool get isEmpty => terms.isEmpty && !every;
  String get expression => terms.join(' ');
}

final class _DemoRule {
  _DemoRule(this.sentence, this.folders, this.tags, this.now);

  final String sentence;
  final List<({String path, String? role})> folders;
  final List<String> tags;
  final DateTime now;

  final _actions = <Map<String, Object?>>[];
  final _actionsSaid = <String>[];
  final _unsupported = <Map<String, Object?>>[];
  final _questions = <String>[];
  _Condition? _condition;

  Map<String, Object?> answer() {
    for (final clause in sentence.split(_clauseBreak)) {
      final text = clause.trim().replaceAll(RegExp(r'^(?:and|but|then|also|still)\s+', caseSensitive: false), '');
      if (text.isNotEmpty) _clause(text);
    }
    final c = _condition ?? _Condition();
    if (_actions.isNotEmpty && c.isEmpty) {
      _questions.add('Which mail should this rule act on? For example: mail from Harbor Coffee.');
      _actions.clear();
      _actionsSaid.clear();
    }
    if (_actions.isEmpty && _unsupported.isEmpty && _questions.isEmpty) {
      _questions.add(
        'What should the rule do, and with which mail? For example: move receipts from Harbor Coffee to Receipts.',
      );
    }
    return {
      'name': _name(c),
      'explanation': _explanation(c),
      'condition': c.expression,
      'every_message': c.every && c.terms.isEmpty,
      'actions': _actions,
      'unsupported': _unsupported,
      'questions': _questions,
    };
  }

  void _clause(String text) {
    final quiet = _notification.hasMatch(text);
    if (quiet) _gap(text, 'no_notification_action');
    var rest = text;
    for (final read in _readers) {
      final match = read.pattern.firstMatch(text);
      if (match == null) continue;
      String group(String name) => match.groupNames.contains(name) ? match.namedGroup(name) ?? '' : '';
      final pre = group('pre');
      final obj = group('obj');
      final post = group('post');
      read.act(this, match);
      // Text after an address counts only when it says more about the mail.
      final more = RegExp(r'^\s*(?:since|before|after|with|from|about|in)\b', caseSensitive: false).hasMatch(post);
      rest = '$pre $obj ${more ? post : ''}';
      break;
    }
    final c = _conditionOf(rest, quiet: quiet);
    if (c.isEmpty) return;
    final current = _condition;
    if (current == null) {
      _condition = c;
    } else if (current.expression != c.expression || current.every != c.every) {
      _questions.add('This sounds like more than one rule: describe “$text” as a rule of its own.');
    }
  }

  _Condition _conditionOf(String raw, {required bool quiet}) {
    final c = _Condition();
    var text = raw;
    if (quiet) text = text.replaceAll(_notificationWords, ' ');
    text = text.replaceAll(_pronouns, ' ');
    if (_every.hasMatch(text)) {
      c.every = true;
      text = text.replaceAll(_every, ' ');
    }
    void sender(String who) {
      if (c.sender != null) return;
      final value = who.trim();
      c.sender = value;
      final simple = !value.contains(' ');
      c.terms.add(simple ? 'from:${value.toLowerCase()}' : 'from:"$value"');
      c.said.add('from “$value”');
    }

    for (final m in _from.allMatches(text).toList()) {
      final who = m.group(1)!;
      if (_senderStop.contains(who.toLowerCase())) continue;
      sender(who);
      text = text.replaceFirst(m.group(0)!, ' ');
    }
    if (_namedKind.firstMatch(text) case final m?) {
      sender(m.group(1)!);
      text = text.replaceFirst(m.group(1)!, ' ');
    }
    for (final m in _kind.allMatches(text).toList()) {
      final word = m.group(1)!;
      final singular = _kinds[word.toLowerCase()]!;
      if (quiet) {
        _gap(word, 'not_semantic_predicate', suggestion: 'subject:$singular');
      } else if (c.keyword == null) {
        c.keyword = singular;
        c.terms.add('subject:$singular');
        c.said.add('with “$singular” in the subject (a word match, not a check that it is a $singular)');
      }
    }
    text = text.replaceAll(_kind, ' ').replaceAll(_generic, ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    text = text.replaceAll(_edges, '').trim();
    if (text.isNotEmpty && c.sender == null && _capitalised.hasMatch(text)) {
      sender(text);
      text = '';
    }
    if (text.isNotEmpty) {
      // demoTranslate asks about a one-word sentence; "mail" is one of its stop words.
      final translated = demoTranslate('mail $text', now: now);
      final expression = translated['expression']! as String;
      if (expression.isNotEmpty) {
        c.terms.add(expression);
        final interpretation = translated['interpretation']! as String;
        final said = interpretation.replaceFirst(RegExp(r'^Mail'), '').replaceFirst(RegExp(r'\.$'), '').trim();
        if (said.isNotEmpty) c.said.add(said);
      }
    }
    return c;
  }

  void _gap(String request, String reason, {String? suggestion}) {
    if (_unsupported.any((u) => u['request'] == request && u['reason'] == reason)) return;
    _unsupported.add({'request': request, 'reason': reason, 'suggestion': suggestion});
  }

  void _add(Map<String, Object?> action, String said) {
    final type = action['type'];
    if (type == 'move' && _actions.any((a) => a['type'] == 'move' || a['type'] == 'junk')) return;
    if (type == 'junk') _actions.removeWhere((a) => a['type'] == 'move' || a['type'] == 'keep_in_inbox');
    if (type == 'keep_in_inbox' && _actions.any((a) => a['type'] == 'move' || a['type'] == 'junk')) return;
    if (_actions.any((a) => jsonEncode(a) == jsonEncode(action))) return;
    _actions.add({'folder': null, 'tag': null, 'address': null, 'keep_copy': null, ...action});
    _actionsSaid.add(said);
  }

  /// The account's folder [raw] names: its path or last part, or a special
  /// folder by its usual name. Null when the account has none.
  ({String path, String? role})? _folder(String raw) {
    final name = raw
        .trim()
        .replaceAll(RegExp(r'''^["“‘']+|["”’'.]+$'''), '')
        .replaceFirst(RegExp(r'^(?:the|my)\s+', caseSensitive: false), '')
        .replaceFirst(RegExp(r'\s+folder$', caseSensitive: false), '')
        .trim();
    final lower = name.toLowerCase();
    final role = switch (lower) {
      'trash' || 'bin' || 'deleted items' => 'trash',
      'archive' => 'archive',
      'inbox' => 'inbox',
      _ => null,
    };
    if (role != null) {
      final special = folders.where((f) => f.role == role).firstOrNull;
      if (special != null) return special;
    }
    final byPath = folders.where((f) => f.path.toLowerCase() == lower).toList();
    if (byPath.length == 1) return byPath.single;
    final byName = folders.where((f) => f.path.split('/').last.toLowerCase() == lower).toList();
    return byName.length == 1 ? byName.single : null;
  }

  void _move(String raw, String request) {
    final lower = raw.trim().toLowerCase().replaceAll(RegExp(r'^(?:the|my)\s+|\s+folder$'), '');
    if (lower == 'junk' || lower == 'spam' || lower == 'junk mail') {
      _add({'type': 'junk'}, 'move it to Junk');
      return;
    }
    final folder = _folder(raw);
    if (folder == null) {
      _gap(request, 'unknown_folder');
      return;
    }
    _add({'type': 'move', 'folder': folder.path}, 'move it to ${folder.path.split('/').last}');
  }

  void _tag(String raw, String request) {
    final name = raw
        .trim()
        .replaceAll(RegExp(r'''^["“‘']+|["”’'.]+$'''), '')
        .replaceFirst(RegExp(r'\s+tag$', caseSensitive: false), '');
    final tag = tags.where((t) => t.toLowerCase() == name.toLowerCase()).firstOrNull;
    if (tag == null) {
      _gap(request, 'unknown_tag');
      return;
    }
    _add({'type': 'add_tag', 'tag': tag}, 'tag it $tag');
  }

  String _name(_Condition c) {
    final name = switch (c) {
      _Condition(sender: final s?) => s,
      _Condition(keyword: final k?) => '${k[0].toUpperCase()}${k.substring(1)}s',
      _Condition(every: true) => 'Every message',
      _ => '',
    };
    return name.length > 60 ? name.substring(0, 60) : name;
  }

  String _explanation(_Condition c) {
    final parts = <String>[];
    if (!c.isEmpty) {
      final which = c.every && c.terms.isEmpty ? 'Every message' : 'Mail ${c.said.join(', ')}';
      parts.add(_actionsSaid.isEmpty ? '$which.' : '$which: ${_actionsSaid.join(', then ')}.');
    }
    if (_unsupported.any((u) => u['reason'] == 'no_notification_action')) {
      parts.add('Rules can’t change notifications, so that part is left out rather than replaced.');
    }
    final kinds = [
      for (final u in _unsupported)
        if (u['reason'] == 'not_semantic_predicate') u['request'],
    ];
    if (kinds.isNotEmpty) parts.add('Loupe can’t recognise ${kinds.join(' or ')}; a rule can only match words.');
    if (_actions.isEmpty && !c.isEmpty) parts.add('The rule does nothing yet: choose an action in the editor.');
    var out = parts.join(' ');
    while (out.length > 500 && parts.length > 1) {
      parts.removeLast();
      out = parts.join(' ');
    }
    return out.length > 500 ? '${out.substring(0, 499)}…' : out;
  }
}

/// One action phrase: its pattern (with the mail it is about in `pre`,
/// `obj` and `post`) and what it adds.
final class _Reader {
  const _Reader(this.pattern, this.act);

  final RegExp pattern;
  final void Function(_DemoRule rule, RegExpMatch match) act;
}

RegExp _phrase(String pattern) => RegExp(pattern, caseSensitive: false, unicode: true);

final _readers = <_Reader>[
  _Reader(
    _phrase(r'^(?<pre>.*?)\b(?:forward|redirect)\b(?<obj>.*?)\bto\s+(?<addr>[^\s,;]+@[^\s,;]*[^\s,;.])(?<post>.*)$'),
    (rule, m) {
      final address = m.namedGroup('addr')!;
      final noCopy = RegExp(
        r"\b(?:without (?:keeping )?a copy|don't keep a copy|no copy)\b",
        caseSensitive: false,
      ).hasMatch(rule.sentence);
      rule._add({
        'type': 'forward',
        'address': address,
        'keep_copy': !noCopy,
      }, 'forward it to $address${noCopy ? ' without keeping a copy' : ''}');
    },
  ),
  _Reader(
    _phrase(r'^(?<pre>.*?)\bkeep\b(?<obj>.*?)\bin\s+(?:the\s+|my\s+)?inbox\b(?<post>.*)$'),
    (rule, m) => rule._add({'type': 'keep_in_inbox'}, 'keep it in the Inbox'),
  ),
  _Reader(
    _phrase(r'^(?<pre>.*?)\bmark\b(?<obj>.*?)\bas\s+(?:junk|spam)\b(?<post>.*)$'),
    (rule, m) => rule._add({'type': 'junk'}, 'move it to Junk'),
  ),
  _Reader(
    _phrase(r'^(?<pre>.*?)\bmark\b(?<obj>.*?)\b(?:as\s+)?read\b(?<post>.*)$'),
    (rule, m) => rule._add({'type': 'mark_read'}, 'mark it as read'),
  ),
  _Reader(
    _phrase(r'^(?<pre>.*?)\b(?:tag|label)\b(?<obj>.*?)\b(?:as|with)\s+(?<tag>.+)$'),
    (rule, m) => rule._tag(m.namedGroup('tag')!, m.group(0)!.trim()),
  ),
  _Reader(
    _phrase(r'^(?<pre>.*?)\b(?:move|file|put|send)\b(?<obj>.*)\s(?:to|into|in)\s+(?<folder>.+)$'),
    (rule, m) => rule._move(m.namedGroup('folder')!, m.group(0)!.trim()),
  ),
  _Reader(_phrase(r'^(?<pre>.*?)\barchive\b(?<obj>.*)$'), (rule, m) => rule._move('archive', m.group(0)!.trim())),
  _Reader(_phrase(r'^(?<pre>.*?)\b(?:delete|trash)\b(?<obj>.*)$'), (rule, m) {
    if (rule.folders.any((f) => f.role == 'trash')) {
      rule._move('trash', m.group(0)!.trim());
    } else {
      rule._gap(m.group(0)!.trim(), 'other');
    }
  }),
  _Reader(
    _phrase(r'^(?<pre>.*?)\b(?:junk|spam)\b(?<obj>.*)$'),
    (rule, m) => rule._add({'type': 'junk'}, 'move it to Junk'),
  ),
  _Reader(_phrase(r'^(?<pre>.*?)\bflag\b(?<obj>.*)$'), (rule, m) => rule._add({'type': 'flag'}, 'flag it')),
];
