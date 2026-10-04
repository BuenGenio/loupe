import 'package:mail_model/mail_model.dart';

/// How an operator interprets its value.
enum OpKind {
  /// Substring (or `/regex/`) on [OpSpec.field].
  text,

  /// `to:`: To or Cc.
  toOrCc,

  /// Regular expression on [OpSpec.field]; a bare value is a pattern.
  regex,

  /// Case-sensitive literal subject text.
  simple,

  /// `name`, `name=text` or `name=/regex/` on a header (desktop `headerre`).
  headerRegex,

  /// `name=text` on a header, literal.
  header,
  attachment,
  has,
  status,
  tag,
  keyword,
  before,
  after,
  date,
  olderThan,
  newerThan,
  larger,
  smaller,
  account,
  only,
}

/// One operator of the language with its aliases.
final class OpSpec {
  const OpSpec(
    this.name,
    this.kind,
    this.summary,
    this.example, {
    this.aliases = const [],
    this.field,
    this.restOfInput = false,
  });

  /// Canonical name, used by `formatQuery` and suggestions.
  final String name;
  final List<String> aliases;
  final OpKind kind;
  final TextField? field;

  /// A few words for completion lists.
  final String summary;
  final String example;

  /// Takes the rest of the input (or of the enclosing group) as its value,
  /// unless the value is quoted or a `/regex/`.
  final bool restOfInput;

  Iterable<String> get names => [name, ...aliases];
}

/// Every operator, in the order suggestions list them.
const operators = <OpSpec>[
  OpSpec('from', OpKind.text, 'sender contains', 'from:alice', aliases: ['f'], field: TextField.from),
  OpSpec('to', OpKind.toOrCc, 'To or Cc contains', 'to:bob', aliases: ['t', 'toorcc']),
  OpSpec('subject', OpKind.text, 'subject contains', 'subject:invoice', aliases: ['s'], field: TextField.subject),
  OpSpec('body', OpKind.text, 'message text contains', 'body:"tracking number"', aliases: ['b'], field: TextField.body),
  OpSpec('is', OpKind.status, 'unread, flagged, replied…', 'is:unread', aliases: ['status', 'i', 'u']),
  OpSpec('tag', OpKind.tag, 'has a tag', 'tag:work', aliases: ['l', 'label']),
  OpSpec('attachment', OpKind.attachment, 'yes, no, or a file name', 'attachment:yes', aliases: ['a']),
  OpSpec('after', OpKind.after, 'received after a day', 'after:2026-03-01', aliases: ['af']),
  OpSpec('before', OpKind.before, 'received before a day', 'before:2026-03-01', aliases: ['be']),
  OpSpec('date', OpKind.date, 'received on a day, month or year', 'date:2026-03', aliases: ['d']),
  OpSpec('newer_than', OpKind.newerThan, 'younger than 7d, 2w, 3m, 1y', 'newer_than:7d', aliases: ['n', 'nt']),
  OpSpec(
    'older_than',
    OpKind.olderThan,
    'older than 7d, 2w, 3m, 1y',
    'older_than:1y',
    aliases: ['days', 'age', 'ag', 'da', 'ot'],
  ),
  OpSpec('cc', OpKind.text, 'Cc contains', 'cc:carol', aliases: ['c'], field: TextField.cc),
  OpSpec('bcc', OpKind.text, 'Bcc contains', 'bcc:dave', aliases: ['bc'], field: TextField.bcc),
  OpSpec('tonocc', OpKind.text, 'To (not Cc) contains', 'tonocc:bob', aliases: ['tn'], field: TextField.to),
  OpSpec('recipients', OpKind.text, 'To, Cc or Bcc contains', 'recipients:team', field: TextField.recipients),
  OpSpec(
    'fromto',
    OpKind.text,
    'any address contains',
    'fromto:alice',
    aliases: ['ft', 'ftc', 'fromtocc', 'alladdresses'],
    field: TextField.participants,
  ),
  OpSpec('only', OpKind.only, 'the only To recipients', 'only:(tom,jerry)', aliases: ['o']),
  OpSpec(
    'all',
    OpKind.text,
    'addresses, subject or body contain',
    'all:weekend',
    aliases: ['al'],
    field: TextField.any,
  ),
  OpSpec('larger', OpKind.larger, 'larger than (KB, or 2M)', 'larger:2M', aliases: ['size', 'si']),
  OpSpec('smaller', OpKind.smaller, 'smaller than (KB, or 2M)', 'smaller:100K', aliases: ['sm']),
  OpSpec(
    'filename',
    OpKind.text,
    'attachment name or type contains',
    'filename:pdf',
    aliases: ['fi', 'fn', 'file'],
    field: TextField.attachment,
  ),
  OpSpec('has', OpKind.has, 'has:attachment', 'has:attachment'),
  OpSpec('account', OpKind.account, 'account name or address contains', 'account:work', aliases: ['acc']),
  OpSpec(
    'simple',
    OpKind.simple,
    'subject contains, case-sensitive',
    'simple:Re: (urgent)',
    field: TextField.subject,
    restOfInput: true,
  ),
  OpSpec(
    'regex',
    OpKind.regex,
    'subject matches a pattern',
    r'regex:/^\[jira\]/i',
    aliases: ['re', 'r', 'subre'],
    field: TextField.subject,
    restOfInput: true,
  ),
  OpSpec(
    'bodyre',
    OpKind.regex,
    'message text matches a pattern',
    r'bodyre:/order #\d{6}/',
    aliases: ['br'],
    field: TextField.body,
    restOfInput: true,
  ),
  OpSpec(
    'fromre',
    OpKind.regex,
    'sender matches a pattern',
    r'fromre:/@example\.org/',
    aliases: ['fr'],
    field: TextField.from,
    restOfInput: true,
  ),
  OpSpec(
    'tore',
    OpKind.regex,
    'a recipient matches a pattern',
    'tore:^team-',
    aliases: ['tr'],
    field: TextField.recipients,
    restOfInput: true,
  ),
  OpSpec('header', OpKind.header, 'a header contains', 'header:"List-Id=dev"'),
  OpSpec(
    'headerre',
    OpKind.headerRegex,
    'a header exists or matches',
    'headerre:List-Id',
    aliases: ['h', 'hr'],
    restOfInput: true,
  ),
  OpSpec('keyword', OpKind.keyword, 'has a raw IMAP/JMAP keyword', r'keyword:$label1', aliases: ['kw']),
];

/// Operators by every name and alias.
final Map<String, OpSpec> operatorsByName = {
  for (final op in operators)
    for (final n in op.names) n: op,
};

/// The canonical operator for a plain text field (`any` has none).
String? textOperatorFor(TextField field) => switch (field) {
  TextField.any => null,
  TextField.from => 'from',
  TextField.to => 'tonocc',
  TextField.cc => 'cc',
  TextField.bcc => 'bcc',
  TextField.recipients => 'recipients',
  TextField.participants => 'fromto',
  TextField.subject => 'subject',
  TextField.body => 'body',
  TextField.attachment => 'filename',
};
