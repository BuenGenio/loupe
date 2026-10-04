import 'package:mail_model/mail_model.dart';

/// Why an identity was chosen for a reply or forward, strongest first.
enum IdentityMatch {
  /// Its address is a To or Cc recipient of the original (or its sender).
  recipient,

  /// Its address is in the original's Delivered-To, X-Original-To or
  /// Envelope-To header.
  envelope,

  /// The original went to a plus-address of it (`me+shop@example.com`).
  plusAddress,

  /// One of its "Use for replies to" patterns matches a recipient.
  pattern,

  /// Nothing matched: the account's default identity.
  fallback,
}

/// The identity to reply or forward from, and an alias to offer.
final class IdentityChoice {
  const IdentityChoice({
    required this.account,
    required this.identity,
    required this.match,
    this.aliasAccount,
    this.alias,
  });

  final MailAccount account;
  final Identity identity;
  final IdentityMatch match;

  /// An address of the user's that the original was sent to but that isn't
  /// an identity: a catch-all alias at a domain an account owns, or a
  /// plus-address. An unsaved [MailAccount.aliasIdentity] of [aliasAccount],
  /// for "Reply from …?".
  final Identity? alias;
  final MailAccount? aliasAccount;

  /// Whether to offer [alias] in the compose header too, not only in the From
  /// picker: no identity was among the original's visible recipients, and no
  /// pattern said which one to use.
  bool get suggestsAlias => alias != null && match != IdentityMatch.recipient && match != IdentityMatch.pattern;
}

/// Picks the identity for a reply or forward from the recipients of the
/// original. In order: an identity among To and Cc; one in the envelope
/// headers (Delivered-To, X-Original-To, Envelope-To); a plus-address of one;
/// a "Use for replies to" pattern; the account's default. At each step the
/// original's own account is tried first, then the others.
abstract final class IdentitySelection {
  /// Headers that name the address a message was delivered to.
  static const envelopeHeaders = {'delivered-to', 'x-original-to', 'envelope-to', 'x-envelope-to', 'x-delivered-to'};

  /// Domains shared by many people: an unknown address there is someone
  /// else's, never a catch-all alias.
  static final publicDomains = _publicDomains.split(' ').toSet();
  static const _publicDomains =
      'gmail.com googlemail.com outlook.com hotmail.com hotmail.co.uk live.com msn.com yahoo.com yahoo.co.uk '
      'ymail.com aol.com icloud.com me.com mac.com fastmail.com fastmail.fm gmx.com gmx.de gmx.net web.de '
      't-online.de mail.com proton.me protonmail.com pm.me tutanota.com tuta.io zoho.com yandex.com yandex.ru '
      'mail.ru qq.com 163.com 126.com hey.com posteo.de mailbox.org free.fr orange.fr libero.it';

  static final _address = RegExp(r'''[^\s<>,;:"'()\[\]]+@[^\s<>,;:"'()\[\]]+''');

  /// The identity to reply to or forward [source] from, or null without
  /// accounts. [headers] are the original's header fields, once loaded.
  static IdentityChoice? choose({
    required List<MailAccount> accounts,
    required EmailSummary source,
    List<(String, String)> headers = const [],
  }) {
    if (accounts.isEmpty) return null;
    final home = accounts.where((a) => a.id == source.accountId).firstOrNull ?? accounts.first;
    final ordered = [home, ...accounts.where((a) => a.id != home.id)];
    final visible = _lower([...source.to, ...source.cc].map((a) => a.email));
    final senders = _lower(source.from.map((a) => a.email));
    final envelope = envelopeAddresses(headers);

    IdentityChoice? find(IdentityMatch match, Iterable<String> addresses, bool Function(Identity, String) test) {
      for (final account in ordered) {
        for (final address in addresses) {
          for (final identity in identitiesOf(account)) {
            if (test(identity, address)) return IdentityChoice(account: account, identity: identity, match: match);
          }
        }
      }
      return null;
    }

    bool same(Identity i, String a) => i.email.toLowerCase() == a;
    final choice =
        find(IdentityMatch.recipient, [...visible, ...senders], same) ??
        find(IdentityMatch.envelope, envelope, same) ??
        find(IdentityMatch.plusAddress, [...visible, ...envelope], (i, a) => isPlusAddressOf(a, i.email)) ??
        find(IdentityMatch.pattern, [
          ...visible,
          ...envelope,
        ], (i, a) => i.replyPatterns.any((p) => matchesPattern(p, a))) ??
        IdentityChoice(account: home, identity: home.defaultIdentity, match: IdentityMatch.fallback);
    if (choice.match == IdentityMatch.recipient) return choice;

    // An alias: first among the visible recipients, then the envelope.
    final senderDomains = {for (final s in senders) _domain(s)};
    final aliasAccounts = [choice.account, ...ordered.where((a) => a.id != choice.account.id)];
    for (final (address, isVisible) in [for (final a in visible) (a, true), for (final a in envelope) (a, false)]) {
      for (final account in aliasAccounts) {
        if (_isAliasOf(account, address, plusCounts: isVisible, senderDomains: senderDomains)) {
          return IdentityChoice(
            account: choice.account,
            identity: choice.identity,
            match: choice.match,
            aliasAccount: account,
            alias: account.aliasIdentity(address),
          );
        }
      }
    }
    return choice;
  }

  /// Whether [address] is an address of [account] that isn't one of its
  /// identities: a plus-address of one (only if [plusCounts]: envelope
  /// headers often carry the server's own tags, like `me+catchall@`), or an
  /// unknown address at a domain the account owns. Addresses at the
  /// sender's domain are left out: those are usually colleagues.
  static bool _isAliasOf(
    MailAccount account,
    String address, {
    required bool plusCounts,
    required Set<String> senderDomains,
  }) {
    final identities = identitiesOf(account);
    if (identities.any((i) => i.email.toLowerCase() == address)) return false;
    if (identities.any((i) => isPlusAddressOf(address, i.email))) return plusCounts;
    final domain = _domain(address);
    return ownedDomains(account).contains(domain) && !senderDomains.contains(domain);
  }

  /// The identities of [account]; its default one if it has none saved.
  static List<Identity> identitiesOf(MailAccount account) =>
      account.identities.isEmpty ? [account.defaultIdentity] : account.identities;

  /// Domains whose unknown addresses can be catch-all aliases of [account]:
  /// those of its address and identities, without [publicDomains]. (Pattern
  /// domains don't count: `*@lists.example.com` names mailing lists.)
  static Set<String> ownedDomains(MailAccount account) => {
    for (final address in [account.email, for (final i in identitiesOf(account)) i.email]) _domain(address),
  }..removeWhere((d) => d.isEmpty || publicDomains.contains(d));

  /// The addresses of the envelope headers among [headers], lower-cased, in order.
  static List<String> envelopeAddresses(List<(String, String)> headers) => _lower([
    for (final (name, value) in headers)
      if (envelopeHeaders.contains(name.trim().toLowerCase()))
        for (final m in _address.allMatches(value)) m.group(0)!,
  ]);

  /// Whether [address] is `user+tag@domain` for [identityEmail] `user@domain`.
  static bool isPlusAddressOf(String address, String identityEmail) {
    final stripped = stripPlus(address);
    return stripped != address.toLowerCase() && stripped == identityEmail.toLowerCase();
  }

  /// `user+tag@domain` as `user@domain`, lower-cased.
  static String stripPlus(String address) {
    final a = address.trim().toLowerCase();
    final at = a.lastIndexOf('@');
    if (at < 0) return a;
    final plus = a.indexOf('+');
    return plus > 0 && plus < at ? '${a.substring(0, plus)}${a.substring(at)}' : a;
  }

  /// A "Use for replies to" pattern in its full form, or null if it isn't
  /// one: `*@example.com` and `me+*@example.com` stay, `@example.com` and
  /// `example.com` mean `*@example.com`. `*` matches any characters.
  static String? normalizePattern(String raw) {
    var p = raw.trim().toLowerCase();
    if (p.isEmpty) return null;
    if (p.startsWith('@')) {
      p = '*$p';
    } else if (!p.contains('@')) {
      p = '*@$p';
    }
    final valid = RegExp(r'''^[^\s@<>(),;:"']+@[^\s@<>(),;:"']+$''').hasMatch(p);
    return valid && (_domain(p).contains('.') || _domain(p).contains('*')) ? p : null;
  }

  /// Whether [address] matches the "Use for replies to" [pattern].
  static bool matchesPattern(String pattern, String address) {
    final p = normalizePattern(pattern);
    if (p == null) return false;
    final re = RegExp('^${p.split('*').map(RegExp.escape).join('.*')}\$', caseSensitive: false);
    return re.hasMatch(address.trim());
  }

  static String _domain(String address) {
    final at = address.lastIndexOf('@');
    return at < 0 ? '' : address.substring(at + 1).toLowerCase();
  }

  static List<String> _lower(Iterable<String> addresses) => [
    for (final a in addresses)
      if (a.trim().isNotEmpty) a.trim().toLowerCase(),
  ];
}

/// The user's own addresses, to leave out of a Reply All: every account and
/// identity address, their plus-addresses, addresses matching a "Use for
/// replies to" pattern, and [extra] (the envelope addresses of the original,
/// an alias replied from).
final class OwnAddresses {
  OwnAddresses(Iterable<MailAccount> accounts, {Iterable<String> extra = const []})
    : _exact = {
        for (final a in accounts) ...[
          a.email.toLowerCase(),
          for (final i in IdentitySelection.identitiesOf(a)) i.email.toLowerCase(),
        ],
        for (final e in extra) e.trim().toLowerCase(),
      },
      _patterns = [
        for (final a in accounts)
          for (final i in IdentitySelection.identitiesOf(a)) ...i.replyPatterns,
      ];

  final Set<String> _exact;
  final List<String> _patterns;

  bool contains(String email) {
    final e = email.trim().toLowerCase();
    return _exact.contains(e) ||
        _exact.contains(IdentitySelection.stripPlus(e)) ||
        _patterns.any((p) => IdentitySelection.matchesPattern(p, e));
  }
}
