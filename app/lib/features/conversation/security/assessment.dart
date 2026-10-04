// The explainable phishing check: findings from local signals only (the
// receiving server's authentication results, the sender's history in the
// address book, the reader's link and privacy analysis), each with a
// severity and a plain-language explanation, and an overall verdict.
// Pure Dart: no Flutter, no network.

import 'package:mail_model/mail_model.dart';
import 'package:readable/readable.dart';

import '../auth_results.dart';
import 'lookalike.dart';

enum Severity { info, warning, danger }

enum Verdict {
  /// Nothing suspicious (tracking alone is a privacy matter, not this).
  noIssues,

  /// Something deserves a second look.
  beCareful,

  /// Several signs, or one strong one, of phishing.
  likelyPhishing,
}

/// Kinds of findings, the most telling first (the order within a severity).
enum FindingKind {
  homographSender,
  lookalikeSender,
  linkHomograph,
  impersonation,
  authFailed,
  linkMismatch,
  nameShowsOtherAddress,
  replyToDiffers,
  linkUserInfo,
  linkIpAddress,
  dataLink,
  passwordField,
  hiddenText,
  authUnaligned,
  firstTimeSender,
  linkUncheckable,
  linkShortener,
  linkInternational,
  scriptLink,
}

/// One reason, in plain language.
final class Finding {
  const Finding(
    this.kind,
    this.severity, {
    required this.title,
    required this.explanation,
    this.advice,
    this.details = const [],
  });

  final FindingKind kind;
  final Severity severity;

  /// A few words: "Sender not verified".
  final String title;

  /// What it means, in a sentence.
  final String explanation;

  /// What to do, in a sentence.
  final String? advice;

  /// Technical specifics (hosts, addresses) for the collapsed details.
  final List<String> details;

  Finding escalate(Severity to, {String? because}) => Finding(
    kind,
    to,
    title: title,
    explanation: because == null ? explanation : '$explanation $because',
    advice: advice,
    details: details,
  );

  @override
  String toString() => 'Finding(${kind.name}, ${severity.name})';
}

/// A known person whose name the sender uses with another address.
final class Namesake {
  const Namesake(this.address, {this.vip = false, this.you = false});
  final EmailAddress address;
  final bool vip;

  /// The user's own name.
  final bool you;
}

/// What the repository knows about the sender.
final class SenderFacts {
  const SenderFacts({
    this.history,
    this.namesakes = const [],
    this.ownAddresses = const {},
    this.ownDomains = const {},
    this.senderIsVip = false,
  });

  static const unknown = SenderFacts();

  /// Null when it couldn't be looked up.
  final SenderHistory? history;
  final List<Namesake> namesakes;

  /// The user's addresses and domains, lower-cased.
  final Set<String> ownAddresses;
  final Set<String> ownDomains;
  final bool senderIsVip;
}

/// The result of the check.
final class SecurityReport {
  const SecurityReport({
    required this.verdict,
    required this.findings,
    this.privacy = const PrivacyReport(),
    this.auth = AuthResults.none,
    this.senderVerified = false,
    this.technical = const [],
  });

  final Verdict verdict;

  /// Worst first.
  final List<Finding> findings;
  final PrivacyReport privacy;
  final AuthResults auth;

  /// The receiving server verified the From domain (DMARC passed, or DKIM
  /// passed for that domain).
  final bool senderVerified;

  /// Raw facts for the collapsed "Technical details": (label, value).
  final List<(String, String)> technical;

  /// Findings worth a warning or worse.
  Iterable<Finding> get concerns => findings.where((f) => f.severity != Severity.info);

  /// The badge shows "Verified".
  bool get verified => verdict == Verdict.noIssues && senderVerified;
}

const _identity = {
  FindingKind.authFailed,
  FindingKind.replyToDiffers,
  FindingKind.impersonation,
  FindingKind.nameShowsOtherAddress,
  FindingKind.lookalikeSender,
};

const _content = {
  FindingKind.linkMismatch,
  FindingKind.linkIpAddress,
  FindingKind.linkUserInfo,
  FindingKind.dataLink,
  FindingKind.passwordField,
};

/// Checks [message] with its [headers], the reader's [analysis] and what the
/// repository knows about the sender.
SecurityReport assessMessage({
  required EmailSummary message,
  required List<(String, String)> headers,
  ReadableAnalysis analysis = ReadableAnalysis.empty,
  SenderFacts facts = SenderFacts.unknown,
}) {
  final findings = <Finding>[];
  final sender = message.sender;
  final email = sender?.email.toLowerCase() ?? '';
  final domain = sender?.domain ?? '';
  final own = email.isNotEmpty && facts.ownAddresses.contains(email);
  final auth = AuthResults.parse(headers);
  final verified = domain.isNotEmpty && _verifiedFor(auth, domain);
  final history = facts.history;
  final firstTime = !own && history != null && !history.isKnown;
  bool has(String name) => headers.any((h) => h.$1.toLowerCase() == name);
  final mailingList = has('list-id') || has('list-post');
  final bulk = mailingList || has('list-unsubscribe') || _precedenceBulk(headers);

  // Who sent it ---------------------------------------------------------------

  if (auth.verdict == AuthVerdict.failed) {
    final failed = [
      for (final m in auth.methods)
        if (const {'fail', 'softfail', 'permerror', 'none'}.contains(m.result) &&
            const {'dkim', 'spf', 'dmarc'}.contains(m.method))
          '${m.method.toUpperCase()} ${m.result}',
    ];
    final from = domain.isEmpty ? 'its sender' : domain;
    findings.add(
      Finding(
        FindingKind.authFailed,
        // Mailing lists change messages on the way and often break the checks.
        mailingList ? Severity.info : Severity.warning,
        title: 'Sender not verified',
        explanation: mailingList
            ? "Your mail server couldn't confirm that this message comes from $from. Common for mailing lists."
            : "Your mail server couldn't confirm that this message really comes from $from.",
        advice: "Don't act on it unless you expected it. If in doubt, contact the sender another way.",
        details: failed,
      ),
    );
  } else if (auth.verdict == AuthVerdict.verified && !verified && domain.isNotEmpty) {
    final signer = auth.methods.where((m) => m.method == 'dkim' && m.result == 'pass').firstOrNull?.domain;
    findings.add(
      Finding(
        FindingKind.authUnaligned,
        Severity.info,
        title: 'Signed by another domain',
        explanation:
            'The message is signed by ${signer ?? 'another domain'}, not $domain. Mailing services do this, '
            "but it doesn't prove who wrote it.",
      ),
    );
  }

  if (sender != null) {
    final shown = RegExp(r'[\w.+-]+@[\w-]+(\.[\w-]+)+').firstMatch(sender.name ?? '')?[0]?.toLowerCase();
    if (shown != null && shown != email && !(sender.name ?? '').toLowerCase().contains(' via ')) {
      findings.add(
        Finding(
          FindingKind.nameShowsOtherAddress,
          Severity.warning,
          title: 'Name shows a different address',
          explanation: 'The sender\'s name reads “$shown”, but the message comes from $email.',
          advice: 'Trust the address, not the name.',
          details: ['From: $sender'],
        ),
      );
    }
  }

  Finding? replyTo;
  for (final r in message.replyTo) {
    final rEmail = r.email.toLowerCase();
    if (domain.isEmpty || mailingList || facts.ownAddresses.contains(rEmail)) break;
    if (registrableDomain(r.domain) == registrableDomain(domain)) continue;
    final severity = auth.verdict == AuthVerdict.failed || (firstTime && !bulk) ? Severity.warning : Severity.info;
    replyTo = Finding(
      FindingKind.replyToDiffers,
      severity,
      title: 'Replies go elsewhere',
      explanation: 'Replying would send your answer to $rEmail, not to $domain.',
      advice: 'Check the address before you reply with anything personal.',
      details: ['Reply-To: $r'],
    );
    findings.add(replyTo);
    break;
  }

  if (sender != null && !own && !facts.senderIsVip && (history == null || !history.isKnown)) {
    // Brands write from many addresses of one domain ("Amazon" from
    // shipment-tracking@ and order-update@): only another domain counts.
    final others = [
      for (final n in facts.namesakes)
        if (n.you || registrableDomain(n.address.domain) != registrableDomain(domain)) n,
    ];
    final namesake =
        others.where((n) => n.you).firstOrNull ?? others.where((n) => n.vip).firstOrNull ?? others.firstOrNull;
    if (namesake != null) {
      final who = namesake.you
          ? 'your own name'
          : '${namesake.vip ? 'your VIP ' : ''}${namesake.address.displayName} (${namesake.address.email})';
      var finding = Finding(
        FindingKind.impersonation,
        Severity.warning,
        title: namesake.you ? 'Uses your name' : 'Uses the name of someone you know',
        explanation: 'It is signed “${sender.displayName}”, like $who, but comes from a new address: $email.',
        advice: 'If it asks for money, codes or files, check with them another way first.',
        details: ['Known address: ${namesake.address.email}', 'This address: $email'],
      );
      if (replyTo != null) {
        finding = finding.escalate(Severity.danger, because: 'And replies would go to yet another address.');
      }
      findings.add(finding);
    }
  }

  if (firstTime) {
    findings.add(
      Finding(
        FindingKind.firstTimeSender,
        Severity.info,
        title: 'First message from this sender',
        explanation: "You haven't had mail from $email before.",
        advice: "Be careful with requests from people you don't know yet.",
      ),
    );
  }

  if (domain.isNotEmpty && !own) {
    final host = inspectHost(domain);
    if (host.homograph) {
      findings.add(
        Finding(
          FindingKind.homographSender,
          Severity.danger,
          title: "Look-alike letters in the sender's address",
          explanation: host.looksLike == null
              ? '${host.display} mixes letters from different alphabets to imitate another address.'
              : '${host.display} uses look-alike letters: it is not ${host.looksLike}.',
          advice: 'Delete it or report it as junk.',
          details: ['Domain: ${host.host}'],
        ),
      );
    } else if (findLookalike(domain, ownDomains: facts.ownDomains) case final l?) {
      final whose = l.own ? 'your own domain, ${l.imitates}' : '${l.name} (${l.imitates})';
      findings.add(
        Finding(
          FindingKind.lookalikeSender,
          l.strong ? Severity.danger : Severity.warning,
          title: l.strong ? 'Look-alike domain' : 'Uses a familiar name in its domain',
          explanation: l.strong
              ? '$domain looks like $whose, but it is a different domain.'
              : '$domain uses the name of $whose, but doesn\'t belong to it.',
          advice: 'Real messages from ${l.own ? 'your organisation' : l.name} come from ${l.imitates}.',
          details: ['Sender domain: $domain', 'Imitates: ${l.imitates}'],
        ),
      );
    }
  }

  // Where its links go ----------------------------------------------------------

  List<LinkFinding> links(LinkIssue issue) => [
    for (final l in analysis.links)
      if (l.issue == issue) l,
  ];
  String hosts(List<LinkFinding> ls) => {for (final l in ls) l.host ?? l.url}.join(', ');

  final mismatches = links(LinkIssue.textMismatch);
  // Verified bulk mail goes through its mailing service's click tracking,
  // known to Loupe or not: a domain in the text can't be checked there.
  final uncheckable = verified && bulk;
  final hidden = mismatches.where((l) => !l.viaTracker && !uncheckable).toList();
  final tracked = mismatches.where((l) => l.viaTracker || uncheckable).toList();
  if (hidden.isNotEmpty) {
    final first = hidden.first;
    findings.add(
      Finding(
        FindingKind.linkMismatch,
        Severity.warning,
        title: hidden.length == 1 ? 'A link hides where it goes' : '${hidden.length} links hide where they go',
        explanation: 'A link shows ${first.detail}, but it opens ${first.host}.',
        advice: "Don't sign in or pay through these links. Type the address yourself instead.",
        details: [for (final l in hidden) '“${l.text}” → ${l.url}'],
      ),
    );
  }
  if (tracked.isNotEmpty) {
    findings.add(
      Finding(
        FindingKind.linkUncheckable,
        Severity.info,
        title: "A link's destination can't be checked",
        explanation:
            'A link shows ${tracked.first.detail}, but goes through ${tracked.first.host}, which records the click '
            'before passing it on.',
        details: [for (final l in tracked) '“${l.text}” → ${l.url}'],
      ),
    );
  }
  final homographs = links(LinkIssue.homograph);
  if (homographs.isNotEmpty) {
    final h = homographs.first;
    findings.add(
      Finding(
        FindingKind.linkHomograph,
        Severity.danger,
        title: 'Look-alike letters in a link',
        explanation: h.detail == null
            ? '${h.host} mixes letters from different alphabets to imitate another address.'
            : '${h.host} uses look-alike letters: it is not ${h.detail}.',
        advice: "Don't open it.",
        details: [for (final l in homographs) l.url],
      ),
    );
  }
  final ips = links(LinkIssue.ipAddress);
  if (ips.isNotEmpty) {
    findings.add(
      Finding(
        FindingKind.linkIpAddress,
        Severity.warning,
        title: 'A link points to a bare IP address',
        explanation: "${hosts(ips)} isn't a named website. Real companies rarely link like this.",
        details: [for (final l in ips) l.url],
      ),
    );
  }
  final userInfo = links(LinkIssue.userInfo);
  if (userInfo.isNotEmpty) {
    final u = userInfo.first;
    findings.add(
      Finding(
        FindingKind.linkUserInfo,
        Severity.warning,
        title: 'A disguised link',
        explanation: 'A link starts with “${u.detail}@” to look like ${u.detail}, but it opens ${u.host}.',
        details: [for (final l in userInfo) l.url],
      ),
    );
  }
  if (links(LinkIssue.dataUrl).isNotEmpty) {
    findings.add(
      const Finding(
        FindingKind.dataLink,
        Severity.warning,
        title: 'A hidden page was disabled',
        explanation: 'A link would have opened a page packed inside the message, a way around link checks.',
      ),
    );
  }
  if (analysis.passwordFields > 0) {
    findings.add(
      const Finding(
        FindingKind.passwordField,
        Severity.warning,
        title: 'Asks for a password',
        explanation: 'The message contained a password field. Loupe removed it.',
        advice: 'Never type a password into an email.',
      ),
    );
  }
  if (links(LinkIssue.script).isNotEmpty) {
    findings.add(
      const Finding(
        FindingKind.scriptLink,
        Severity.info,
        title: 'A link that runs code was disabled',
        explanation: 'Loupe never runs code from messages.',
      ),
    );
  }
  final shorteners = links(LinkIssue.shortener);
  if (shorteners.isNotEmpty) {
    findings.add(
      Finding(
        FindingKind.linkShortener,
        Severity.info,
        title: shorteners.length == 1 ? 'A shortened link' : 'Shortened links',
        explanation: '${hosts(shorteners)} hides the real destination until you open it.',
        details: [for (final l in shorteners) l.url],
      ),
    );
  }
  final international = links(LinkIssue.international);
  if (international.isNotEmpty) {
    findings.add(
      Finding(
        FindingKind.linkInternational,
        Severity.info,
        title: 'International web address',
        explanation:
            '${hosts(international)} uses non-Latin letters. Normal for many languages; check it is the site '
            'you expect.',
        details: [for (final l in international) l.url],
      ),
    );
  }
  final hiddenText = analysis.hiddenTextLength;
  // Responsive newsletters hide a whole second layout; only an unverified
  // sender hiding far more than it shows is suspicious.
  if (!verified && hiddenText >= 500 && hiddenText > 2 * analysis.keptTextLength) {
    findings.add(
      Finding(
        FindingKind.hiddenText,
        Severity.warning,
        title: 'Lots of hidden text',
        explanation:
            '$hiddenText characters of invisible text were removed. Hidden text like this is meant to fool '
            'spam filters.',
      ),
    );
  } else if (hiddenText >= 200) {
    findings.add(
      Finding(
        FindingKind.hiddenText,
        Severity.info,
        title: 'Hidden text removed',
        explanation: '$hiddenText characters of invisible text were removed.',
      ),
    );
  }

  findings.sort((a, b) {
    final s = b.severity.index.compareTo(a.severity.index);
    return s != 0 ? s : a.kind.index.compareTo(b.kind.index);
  });

  return SecurityReport(
    verdict: _verdict(findings),
    findings: findings,
    privacy: analysis.privacy,
    auth: auth,
    senderVerified: verified,
    technical: [
      if (sender != null) ('From', sender.toString()),
      for (final r in message.replyTo) ('Reply-To', r.toString()),
      for (final (name, value) in headers)
        if (const {'authentication-results', 'return-path', 'received-spf'}.contains(name.toLowerCase()))
          (name, value.replaceAll(RegExp(r'\s+'), ' ')),
      if (history != null) ('Sender history', '${history.received} received, ${history.sent} sent'),
      if (analysis.linkHosts.isNotEmpty) ('Links lead to', analysis.linkHosts.join(', ')),
      if (analysis.hiddenElements > 0)
        ('Hidden', '${analysis.hiddenElements} elements, ${analysis.hiddenTextLength} characters'),
    ],
  );
}

Verdict _verdict(List<Finding> findings) {
  if (findings.any((f) => f.severity == Severity.danger)) return Verdict.likelyPhishing;
  final warnings = findings.where((f) => f.severity == Severity.warning).toList();
  if (warnings.isEmpty) return Verdict.noIssues;
  final identity = warnings.where((f) => _identity.contains(f.kind)).length;
  final content = warnings.where((f) => _content.contains(f.kind)).length;
  // Not who it claims to be, and links or forms that aren't what they claim.
  if (identity > 0 && content > 0) return Verdict.likelyPhishing;
  // A borrowed name plus another identity trick.
  if (identity >= 2 && warnings.any((f) => f.kind == FindingKind.impersonation)) return Verdict.likelyPhishing;
  return Verdict.beCareful;
}

/// DMARC passed, or (without DMARC) DKIM passed for the From domain.
bool _verifiedFor(AuthResults auth, String fromDomain) {
  final dmarc = auth.methods.where((m) => m.method == 'dmarc').map((m) => m.result).toList();
  if (dmarc.contains('pass')) return true;
  if (dmarc.contains('fail')) return false;
  final from = registrableDomain(fromDomain);
  return auth.methods.any(
    (m) => m.method == 'dkim' && m.result == 'pass' && m.domain != null && registrableDomain(m.domain!) == from,
  );
}

bool _precedenceBulk(List<(String, String)> headers) => headers.any(
  (h) => h.$1.toLowerCase() == 'precedence' && const {'bulk', 'list', 'junk'}.contains(h.$2.trim().toLowerCase()),
);
