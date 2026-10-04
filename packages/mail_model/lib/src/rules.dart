import 'email.dart';
import 'search.dart';

/// Where a rule runs.
enum RuleLocation {
  /// On this device, on new Inbox messages after each sync.
  device,

  /// On the mail server, as a Sieve script (RFC 5228) installed through
  /// ManageSieve, as mail is delivered, also while the phone is off.
  server,
}

/// What a rule does to a message it matches.
sealed class RuleAction {
  const RuleAction();

  /// The JSON stored with the rule (and in Loupe's Sieve script).
  Map<String, Object?> toJson();

  /// Whether the action can run at [location]: forwarding is server only.
  bool runsOn(RuleLocation location) => true;

  /// Reads [toJson]'s output; null for an unknown action (from a newer app).
  static RuleAction? fromJson(Map<String, Object?> json) => switch (json['type']) {
    'move' => switch (json['mailboxId']) {
      final String id => MoveToMailboxAction(id),
      _ => null,
    },
    'addTag' => switch (json['keyword']) {
      final String k => AddTagAction(k),
      _ => null,
    },
    'removeTag' => switch (json['keyword']) {
      final String k => RemoveTagAction(k),
      _ => null,
    },
    'flag' => const FlagAction(),
    'markRead' => const MarkReadAction(),
    'junk' => const MarkJunkAction(),
    'keep' => const KeepInInboxAction(),
    'forward' => switch (json['address']) {
      final String a => ForwardAction(a, keepCopy: json['keepCopy'] as bool? ?? true),
      _ => null,
    },
    _ => null,
  };
}

/// Moves the message to a mailbox. In a rule for several accounts, messages
/// of another account go to the mailbox with the same path there.
final class MoveToMailboxAction extends RuleAction {
  const MoveToMailboxAction(this.mailboxId);
  final String mailboxId;
  @override
  Map<String, Object?> toJson() => {'type': 'move', 'mailboxId': mailboxId};
  @override
  bool operator ==(Object other) => other is MoveToMailboxAction && other.mailboxId == mailboxId;
  @override
  int get hashCode => Object.hash('move', mailboxId);
  @override
  String toString() => 'Move($mailboxId)';
}

/// Adds a tag (a keyword such as `$label1`).
final class AddTagAction extends RuleAction {
  const AddTagAction(this.keyword);
  final String keyword;
  @override
  Map<String, Object?> toJson() => {'type': 'addTag', 'keyword': keyword};
  @override
  bool operator ==(Object other) => other is AddTagAction && other.keyword == keyword;
  @override
  int get hashCode => Object.hash('addTag', keyword);
  @override
  String toString() => 'AddTag($keyword)';
}

/// Removes a tag.
final class RemoveTagAction extends RuleAction {
  const RemoveTagAction(this.keyword);
  final String keyword;
  @override
  Map<String, Object?> toJson() => {'type': 'removeTag', 'keyword': keyword};
  @override
  bool operator ==(Object other) => other is RemoveTagAction && other.keyword == keyword;
  @override
  int get hashCode => Object.hash('removeTag', keyword);
  @override
  String toString() => 'RemoveTag($keyword)';
}

/// Flags the message.
final class FlagAction extends RuleAction {
  const FlagAction();
  @override
  Map<String, Object?> toJson() => {'type': 'flag'};
  @override
  bool operator ==(Object other) => other is FlagAction;
  @override
  int get hashCode => 11;
  @override
  String toString() => 'Flag';
}

/// Marks the message as read.
final class MarkReadAction extends RuleAction {
  const MarkReadAction();
  @override
  Map<String, Object?> toJson() => {'type': 'markRead'};
  @override
  bool operator ==(Object other) => other is MarkReadAction;
  @override
  int get hashCode => 12;
  @override
  String toString() => 'MarkRead';
}

/// Marks the message as junk and moves it to the Junk mailbox.
final class MarkJunkAction extends RuleAction {
  const MarkJunkAction();
  @override
  Map<String, Object?> toJson() => {'type': 'junk'};
  @override
  bool operator ==(Object other) => other is MarkJunkAction;
  @override
  int get hashCode => 13;
  @override
  String toString() => 'Junk';
}

/// Keeps the message in the Inbox and stops: later rules don't run on it.
/// Put it first for exceptions ("my boss always stays in the Inbox").
final class KeepInInboxAction extends RuleAction {
  const KeepInInboxAction();
  @override
  Map<String, Object?> toJson() => {'type': 'keep'};
  @override
  bool operator ==(Object other) => other is KeepInInboxAction;
  @override
  int get hashCode => 14;
  @override
  String toString() => 'Keep';
}

/// Forwards (redirects) the message to [address], keeping a copy unless
/// [keepCopy] is false. Server rules only.
final class ForwardAction extends RuleAction {
  const ForwardAction(this.address, {this.keepCopy = true});
  final String address;
  final bool keepCopy;
  @override
  Map<String, Object?> toJson() => {'type': 'forward', 'address': address, 'keepCopy': keepCopy};
  @override
  bool runsOn(RuleLocation location) => location == RuleLocation.server;
  @override
  bool operator ==(Object other) => other is ForwardAction && other.address == address && other.keepCopy == keepCopy;
  @override
  int get hashCode => Object.hash('forward', address, keepCopy);
  @override
  String toString() => 'Forward($address${keepCopy ? ', keep' : ''})';
}

/// A mail rule: when a new message matches [condition], do [actions].
///
/// The condition is a query in the Loupe search language (expr_search), the
/// same text a search or a Smart Mailbox uses.
final class Rule {
  const Rule({
    required this.id,
    required this.name,
    required this.condition,
    this.actions = const [],
    this.enabled = true,
    this.accountIds = const {},
    this.stopProcessing = false,
    this.location = RuleLocation.device,
    this.order = 0,
  });

  final String id;
  final String name;

  /// The query, e.g. `from:@newsletter.example or h:List-Id`.
  final String condition;
  final List<RuleAction> actions;
  final bool enabled;

  /// The accounts whose mail the rule handles; empty means every account.
  final Set<String> accountIds;

  /// Later rules don't run on a message this rule matched.
  final bool stopProcessing;
  final RuleLocation location;

  /// Position in the rule list; rules run in this order.
  final int order;

  bool appliesTo(String accountId) => accountIds.isEmpty || accountIds.contains(accountId);

  /// True if the rule stops later rules (explicitly, or by keeping the
  /// message in the Inbox).
  bool get stops => stopProcessing || actions.any((a) => a is KeepInInboxAction);

  Rule copyWith({
    String? name,
    String? condition,
    List<RuleAction>? actions,
    bool? enabled,
    Set<String>? accountIds,
    bool? stopProcessing,
    RuleLocation? location,
    int? order,
  }) => Rule(
    id: id,
    name: name ?? this.name,
    condition: condition ?? this.condition,
    actions: actions ?? this.actions,
    enabled: enabled ?? this.enabled,
    accountIds: accountIds ?? this.accountIds,
    stopProcessing: stopProcessing ?? this.stopProcessing,
    location: location ?? this.location,
    order: order ?? this.order,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'condition': condition,
    'actions': [for (final a in actions) a.toJson()],
    'enabled': enabled,
    'accountIds': [...accountIds],
    'stop': stopProcessing,
    'location': location.name,
    'order': order,
  };

  /// Reads [toJson]'s output. Unknown actions are dropped; missing fields
  /// take their defaults.
  factory Rule.fromJson(Map<String, Object?> json) => Rule(
    id: json['id']! as String,
    name: json['name'] as String? ?? '',
    condition: json['condition'] as String? ?? '',
    actions: [
      for (final a in json['actions'] as List? ?? const [])
        if (a is Map) ?RuleAction.fromJson(a.cast()),
    ],
    enabled: json['enabled'] as bool? ?? true,
    accountIds: {for (final a in json['accountIds'] as List? ?? const []) a as String},
    stopProcessing: json['stop'] as bool? ?? false,
    location: RuleLocation.values.asNameMap()[json['location']] ?? RuleLocation.device,
    order: json['order'] as int? ?? 0,
  );

  @override
  bool operator ==(Object other) =>
      other is Rule &&
      other.id == id &&
      other.name == name &&
      other.condition == condition &&
      _listEquals(other.actions, actions) &&
      other.enabled == enabled &&
      other.accountIds.length == accountIds.length &&
      other.accountIds.containsAll(accountIds) &&
      other.stopProcessing == stopProcessing &&
      other.location == location &&
      other.order == order;

  @override
  int get hashCode => Object.hash(id, name, condition, enabled, location, order);

  @override
  String toString() => 'Rule($id "$name": $condition → $actions)';
}

bool _listEquals(List<Object?> a, List<Object?> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// How far server rules (Sieve) are for one account.
enum ServerRulesState {
  /// The server hasn't been asked yet.
  unknown,

  /// No server rules here: the server has no ManageSieve, can't be reached
  /// or refused the login ([ServerRulesStatus.message] says which).
  unavailable,

  /// Loupe's script runs: it is the active script, or the active script
  /// includes it.
  active,

  /// Loupe's script isn't running because another script is active
  /// ([ServerRulesStatus.activeScript]) and doesn't include it.
  inactive,
}

/// The server-rules situation of one account.
final class ServerRulesStatus {
  const ServerRulesStatus({
    required this.accountId,
    required this.state,
    this.activeScript,
    this.viaInclude = false,
    this.extensions = const {},
    this.otherScripts = const [],
    this.implementation,
    this.message,
  });

  final String accountId;
  final ServerRulesState state;

  /// The active script when it isn't Loupe's own (e.g. SOGo's filters).
  final String? activeScript;

  /// Loupe's rules run through `include` from [activeScript].
  final bool viaInclude;

  /// The server's Sieve extensions (`fileinto`, `imap4flags`, `body`, …).
  final Set<String> extensions;

  /// Scripts on the server that aren't Loupe's. Loupe never edits them,
  /// except to add an include line when the user agrees.
  final List<String> otherScripts;

  /// The server software, e.g. "Dovecot Pigeonhole".
  final String? implementation;

  /// Why server rules are unavailable, or the last error; shown as is.
  final String? message;
}

/// What a rule becomes on one account's server.
final class ServerRulePreview {
  const ServerRulePreview({required this.accountId, this.script, this.problems = const []});

  final String accountId;

  /// Loupe's complete script with the rule in place, or null if the rule
  /// can't run on this server.
  final String? script;

  /// Why the rule can't run on the server, one reason each (shown as
  /// “Can’t run on the server: …”). Empty when it can.
  final List<String> problems;

  bool get canRun => problems.isEmpty && script != null;
}

/// The change that makes the server's active script also run Loupe's rules:
/// `require "include";` near the top and `include :personal "loupe";` at
/// the end. Shown to the user before anything is changed.
final class SieveIncludeProposal {
  const SieveIncludeProposal({
    required this.accountId,
    required this.scriptName,
    required this.before,
    required this.after,
    required this.addedLines,
  });

  final String accountId;

  /// The active script that would change.
  final String scriptName;
  final String before;
  final String after;

  /// The lines Loupe adds, in order.
  final List<String> addedLines;
}

/// Mail rules: the list, running rules on existing mail, and server rules.
///
/// Implemented by the demo repository and mail_sync's live repository and
/// reached through `MailRepository.rules`. Device rules run on new Inbox messages after
/// each sync, never twice on the same message.
abstract interface class MailRules {
  /// Every rule, in order.
  Stream<List<Rule>> watchRules();

  /// Adds [rule], or replaces the rule with its id; a new rule goes last.
  ///
  /// For server rules, Loupe's script is regenerated for each of the rule's
  /// accounts, checked (CHECKSCRIPT) and uploaded (PUTSCRIPT) first, and
  /// activated if no script is active. Throws [MailException] with the
  /// server's message (or why the rule can't run there), and then nothing
  /// changes.
  Future<void> saveRule(Rule rule);

  /// Deletes a rule, also from the servers' scripts.
  Future<void> deleteRule(String ruleId);

  /// Puts the rules in this order (ids of every rule).
  Future<void> reorderRules(List<String> ruleIds);

  /// Messages in [scope] that [rule]'s condition matches, for "Apply to
  /// Existing Messages" (the count is confirmed first). Exact: bodies are
  /// loaded where the condition needs them. Only the rule's accounts.
  Future<List<EmailSummary>> findMatches(Rule rule, SearchScope scope, {int limit = 500});

  /// Runs [rule]'s actions on [emailIds] now, through the normal action
  /// paths (offline queue). Forwarding isn't done here. Returns how many
  /// messages were changed.
  Future<int> applyRule(Rule rule, List<String> emailIds);

  /// Server rules of [accountId]; [refresh] asks the server again (and
  /// picks up rules saved in Loupe's script by another device).
  Future<ServerRulesStatus> serverStatus(String accountId, {bool refresh = false});

  /// What [rule] becomes on each of its accounts' servers: the script for
  /// "Show Script", or why it can't run there.
  Future<List<ServerRulePreview>> previewServerRule(Rule rule);

  /// The change to the active script that would make it run Loupe's rules,
  /// or null when none is needed (or possible).
  Future<SieveIncludeProposal?> proposeInclude(String accountId);

  /// Makes the change [proposal] describes (checked, then uploaded), unless
  /// the script changed meanwhile. Throws [MailException] on failure.
  Future<void> applyInclude(SieveIncludeProposal proposal);
}
