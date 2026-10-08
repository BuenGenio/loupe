// The explainable phishing check: findings from local signals only (the
// receiving server's authentication results, the sender's history in the
// address book, the reader's link and privacy analysis), each with a
// severity and what it is about, and an overall verdict. The plain-language
// explanations are made from them where they show (finding_text.dart).
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

/// One reason. It holds what the reason is about; its words are made where
/// it shows (`findingText`), in the app's language.
sealed class Finding {
  const Finding(this.kind, this.severity);

  final FindingKind kind;
  final Severity severity;

  @override
  String toString() => 'Finding(${kind.name}, ${severity.name})';
}

/// The receiving server couldn't confirm the sender ([FindingKind.authFailed]).
final class AuthFailedFinding extends Finding {
  const AuthFailedFinding(Severity severity, {required this.domain, required this.mailingList, required this.checks})
    : super(FindingKind.authFailed, severity);

  /// The sender's domain; empty when there is none.
  final String domain;

  /// It came through a mailing list, which often breaks the checks.
  final bool mailingList;

  /// The checks that failed, as the server reported them: "DMARC fail".
  final List<String> checks;
}

/// Signed by a domain other than the sender's ([FindingKind.authUnaligned]).
final class AuthUnalignedFinding extends Finding {
  const AuthUnalignedFinding({required this.signer, required this.domain})
    : super(FindingKind.authUnaligned, Severity.info);

  /// The signing domain, if the server named it.
  final String? signer;

  /// The sender's domain.
  final String domain;
}

/// The sender's name reads like another address
/// ([FindingKind.nameShowsOtherAddress]).
final class NameShowsOtherAddressFinding extends Finding {
  const NameShowsOtherAddressFinding({required this.shown, required this.email, required this.from})
    : super(FindingKind.nameShowsOtherAddress, Severity.warning);

  /// The address in the name.
  final String shown;

  /// The address it comes from.
  final String email;

  /// The From address, as written.
  final EmailAddress from;
}

/// Replies would go to another domain ([FindingKind.replyToDiffers]).
final class ReplyToDiffersFinding extends Finding {
  const ReplyToDiffersFinding(Severity severity, {required this.replyTo, required this.domain})
    : super(FindingKind.replyToDiffers, severity);

  final EmailAddress replyTo;

  /// The sender's domain.
  final String domain;
}

/// A new address uses the name of someone the user knows, or the user's own
/// ([FindingKind.impersonation]).
final class ImpersonationFinding extends Finding {
  const ImpersonationFinding(
    Severity severity, {
    required this.name,
    required this.email,
    required this.namesake,
    this.repliesElsewhere = false,
  }) : super(FindingKind.impersonation, severity);

  /// The name it is signed with.
  final String name;

  /// The address it comes from.
  final String email;

  /// Whose name it is.
  final Namesake namesake;

  /// And replies would go to yet another address.
  final bool repliesElsewhere;
}

/// No mail from this address before ([FindingKind.firstTimeSender]).
final class FirstTimeSenderFinding extends Finding {
  const FirstTimeSenderFinding({required this.email}) : super(FindingKind.firstTimeSender, Severity.info);

  final String email;
}

/// Look-alike letters in the sender's domain ([FindingKind.homographSender]).
final class SenderHomographFinding extends Finding {
  const SenderHomographFinding({required this.host}) : super(FindingKind.homographSender, Severity.danger);

  final HostInfo host;
}

/// A sender domain imitating a brand's or the user's own
/// ([FindingKind.lookalikeSender]).
final class LookalikeFinding extends Finding {
  LookalikeFinding({required this.domain, required this.lookalike})
    : super(FindingKind.lookalikeSender, lookalike.strong ? Severity.danger : Severity.warning);

  /// The sender's domain.
  final String domain;
  final Lookalike lookalike;
}

/// Links with an issue, the first one shown in the explanation: the link
/// kinds of [FindingKind] ([FindingKind.linkMismatch] …,
/// [FindingKind.dataLink], [FindingKind.scriptLink]).
final class LinksFinding extends Finding {
  const LinksFinding(super.kind, super.severity, {required this.links});

  final List<LinkFinding> links;
}

/// Something in the content: password fields ([FindingKind.passwordField])
/// or characters of hidden text ([FindingKind.hiddenText]), [count] of them.
final class ContentFinding extends Finding {
  const ContentFinding(super.kind, super.severity, {required this.count});

  final int count;
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
    this.senderHistory,
    this.linkHosts = const [],
    this.hiddenElements = 0,
    this.hiddenCharacters = 0,
  });

  final Verdict verdict;

  /// Worst first.
  final List<Finding> findings;
  final PrivacyReport privacy;
  final AuthResults auth;

  /// The receiving server verified the From domain (DMARC passed, or DKIM
  /// passed for that domain).
  final bool senderVerified;

  /// Header fields for the collapsed "Technical details", by their raw
  /// names: From, Reply-To and the receiving server's results.
  final List<(String, String)> technical;

  /// What the address book knows of the sender; null when it couldn't be
  /// looked up. Also for the technical details, like the rest below.
  final SenderHistory? senderHistory;

  /// Where the links lead.
  final List<String> linkHosts;

  /// Hidden elements removed, and the characters of text in them.
  final int hiddenElements;
  final int hiddenCharacters;

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
    findings.add(
      AuthFailedFinding(
        // Mailing lists change messages on the way and often break the checks.
        mailingList ? Severity.info : Severity.warning,
        domain: domain,
        mailingList: mailingList,
        checks: [
          for (final m in auth.methods)
            if (const {'fail', 'softfail', 'permerror', 'none'}.contains(m.result) &&
                const {'dkim', 'spf', 'dmarc'}.contains(m.method))
              '${m.method.toUpperCase()} ${m.result}',
        ],
      ),
    );
  } else if (auth.verdict == AuthVerdict.verified && !verified && domain.isNotEmpty) {
    final signer = auth.methods.where((m) => m.method == 'dkim' && m.result == 'pass').firstOrNull?.domain;
    findings.add(AuthUnalignedFinding(signer: signer, domain: domain));
  }

  if (sender != null) {
    final shown = RegExp(r'[\w.+-]+@[\w-]+(\.[\w-]+)+').firstMatch(sender.name ?? '')?[0]?.toLowerCase();
    if (shown != null && shown != email && !(sender.name ?? '').toLowerCase().contains(' via ')) {
      findings.add(NameShowsOtherAddressFinding(shown: shown, email: email, from: sender));
    }
  }

  ReplyToDiffersFinding? replyTo;
  for (final r in message.replyTo) {
    final rEmail = r.email.toLowerCase();
    if (domain.isEmpty || mailingList || facts.ownAddresses.contains(rEmail)) break;
    if (registrableDomain(r.domain) == registrableDomain(domain)) continue;
    final severity = auth.verdict == AuthVerdict.failed || (firstTime && !bulk) ? Severity.warning : Severity.info;
    replyTo = ReplyToDiffersFinding(severity, replyTo: r, domain: domain);
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
      findings.add(
        ImpersonationFinding(
          // Worse when replies would go to yet another address.
          replyTo != null ? Severity.danger : Severity.warning,
          name: sender.displayName,
          email: email,
          namesake: namesake,
          repliesElsewhere: replyTo != null,
        ),
      );
    }
  }

  if (firstTime) findings.add(FirstTimeSenderFinding(email: email));

  if (domain.isNotEmpty && !own) {
    final host = inspectHost(domain);
    if (host.homograph) {
      findings.add(SenderHomographFinding(host: host));
    } else if (findLookalike(domain, ownDomains: facts.ownDomains) case final l?) {
      findings.add(LookalikeFinding(domain: domain, lookalike: l));
    }
  }

  // Where its links go ----------------------------------------------------------

  List<LinkFinding> links(LinkIssue issue) => [
    for (final l in analysis.links)
      if (l.issue == issue) l,
  ];

  final mismatches = links(LinkIssue.textMismatch);
  // Verified bulk mail goes through its mailing service's click tracking,
  // known to Loupe or not: a domain in the text can't be checked there.
  final uncheckable = verified && bulk;
  final hidden = mismatches.where((l) => !l.viaTracker && !uncheckable).toList();
  final tracked = mismatches.where((l) => l.viaTracker || uncheckable).toList();
  void addLinks(FindingKind kind, Severity severity, List<LinkFinding> ls) {
    if (ls.isNotEmpty) findings.add(LinksFinding(kind, severity, links: ls));
  }

  addLinks(FindingKind.linkMismatch, Severity.warning, hidden);
  addLinks(FindingKind.linkUncheckable, Severity.info, tracked);
  addLinks(FindingKind.linkHomograph, Severity.danger, links(LinkIssue.homograph));
  addLinks(FindingKind.linkIpAddress, Severity.warning, links(LinkIssue.ipAddress));
  addLinks(FindingKind.linkUserInfo, Severity.warning, links(LinkIssue.userInfo));
  addLinks(FindingKind.dataLink, Severity.warning, links(LinkIssue.dataUrl));
  if (analysis.passwordFields > 0) {
    findings.add(ContentFinding(FindingKind.passwordField, Severity.warning, count: analysis.passwordFields));
  }
  addLinks(FindingKind.scriptLink, Severity.info, links(LinkIssue.script));
  addLinks(FindingKind.linkShortener, Severity.info, links(LinkIssue.shortener));
  addLinks(FindingKind.linkInternational, Severity.info, links(LinkIssue.international));
  final hiddenText = analysis.hiddenTextLength;
  // Responsive newsletters hide a whole second layout; only an unverified
  // sender hiding far more than it shows is suspicious.
  if (!verified && hiddenText >= 500 && hiddenText > 2 * analysis.keptTextLength) {
    findings.add(ContentFinding(FindingKind.hiddenText, Severity.warning, count: hiddenText));
  } else if (hiddenText >= 200) {
    findings.add(ContentFinding(FindingKind.hiddenText, Severity.info, count: hiddenText));
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
    // Raw header names, like the server's ones below and in View Source.
    technical: [
      if (sender != null) ('From', sender.toString()),
      for (final r in message.replyTo) ('Reply-To', r.toString()),
      for (final (name, value) in headers)
        if (const {'authentication-results', 'return-path', 'received-spf'}.contains(name.toLowerCase()))
          (name, value.replaceAll(RegExp(r'\s+'), ' ')),
    ],
    senderHistory: history,
    linkHosts: analysis.linkHosts,
    hiddenElements: analysis.hiddenElements,
    hiddenCharacters: analysis.hiddenTextLength,
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
