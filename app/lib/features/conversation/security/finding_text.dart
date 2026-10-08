// The words of the phishing check's findings, in the app's language: what
// each one is, what it means, what to do, and its technical specifics.

import '../../../l10n/l10n.dart';
import 'assessment.dart';

/// What a [Finding] says. [details] are technical specifics (hosts,
/// addresses) for the collapsed "Technical details".
typedef FindingText = ({String title, String explanation, String? advice, List<String> details});

/// The words of [finding].
FindingText findingText(AppLocalizations l10n, Finding finding) {
  FindingText text(String title, String explanation, {String? advice, List<String> details = const []}) =>
      (title: title, explanation: explanation, advice: advice, details: details);

  switch (finding) {
    case AuthFailedFinding(:final domain, :final mailingList, :final checks):
      return text(
        l10n.conversationSecurityAuthFailedTitle,
        switch ((mailingList, domain.isEmpty)) {
          (true, false) => l10n.conversationSecurityAuthFailedListText(domain),
          (true, true) => l10n.conversationSecurityAuthFailedListTextNoDomain,
          (false, false) => l10n.conversationSecurityAuthFailedText(domain),
          (false, true) => l10n.conversationSecurityAuthFailedTextNoDomain,
        },
        advice: l10n.conversationSecurityAuthFailedAdvice,
        // As the server reported them: "DMARC fail".
        details: checks,
      );
    case AuthUnalignedFinding(:final signer, :final domain):
      return text(
        l10n.conversationSecurityAuthUnalignedTitle,
        signer == null
            ? l10n.conversationSecurityAuthUnalignedTextNoSigner(domain)
            : l10n.conversationSecurityAuthUnalignedText(signer, domain),
      );
    case NameShowsOtherAddressFinding(:final shown, :final email, :final from):
      return text(
        l10n.conversationSecurityNameShowsAddressTitle,
        l10n.conversationSecurityNameShowsAddressText(shown, email),
        advice: l10n.conversationSecurityNameShowsAddressAdvice,
        details: ['From: $from'], // l10n-ignore: the header field, as in View Source
      );
    case ReplyToDiffersFinding(:final replyTo, :final domain):
      return text(
        l10n.conversationSecurityReplyToTitle,
        l10n.conversationSecurityReplyToText(replyTo.email.toLowerCase(), domain),
        advice: l10n.conversationSecurityReplyToAdvice,
        details: ['Reply-To: $replyTo'], // l10n-ignore: the header field, as in View Source
      );
    case ImpersonationFinding(:final name, :final email, :final namesake, :final repliesElsewhere):
      final known = namesake.address;
      final explanation = namesake.you
          ? l10n.conversationSecurityImpersonationYouText(name, email)
          : namesake.vip
          ? l10n.conversationSecurityImpersonationVipText(name, known.displayName, known.email, email)
          : l10n.conversationSecurityImpersonationText(name, known.displayName, known.email, email);
      return text(
        namesake.you ? l10n.conversationSecurityImpersonationYouTitle : l10n.conversationSecurityImpersonationTitle,
        repliesElsewhere ? '$explanation ${l10n.conversationSecurityImpersonationRepliesElsewhere}' : explanation,
        advice: l10n.conversationSecurityImpersonationAdvice,
        details: [l10n.conversationSecurityKnownAddress(known.email), l10n.conversationSecurityThisAddress(email)],
      );
    case FirstTimeSenderFinding(:final email):
      return text(
        l10n.conversationSecurityFirstTimeTitle,
        l10n.conversationSecurityFirstTimeText(email),
        advice: l10n.conversationSecurityFirstTimeAdvice,
      );
    case SenderHomographFinding(:final host):
      return text(
        l10n.conversationSecuritySenderHomographTitle,
        switch (host.looksLike) {
          null => l10n.conversationSecurityHomographText(host.display),
          final real => l10n.conversationSecurityHomographImitatesText(host.display, real),
        },
        advice: l10n.conversationSecuritySenderHomographAdvice,
        details: [l10n.conversationSecurityDomainDetail(host.host)],
      );
    case LookalikeFinding(:final domain, lookalike: final l):
      return text(
        l.strong ? l10n.conversationSecurityLookalikeTitle : l10n.conversationSecurityFamiliarNameTitle,
        switch ((l.strong, l.own)) {
          (true, true) => l10n.conversationSecurityLookalikeOwnText(domain, l.imitates),
          (true, false) => l10n.conversationSecurityLookalikeText(domain, l.name, l.imitates),
          (false, true) => l10n.conversationSecurityFamiliarNameOwnText(domain, l.imitates),
          (false, false) => l10n.conversationSecurityFamiliarNameText(domain, l.name, l.imitates),
        },
        advice: l.own
            ? l10n.conversationSecurityLookalikeOwnAdvice(l.imitates)
            : l10n.conversationSecurityLookalikeAdvice(l.name, l.imitates),
        details: [l10n.conversationSecuritySenderDomain(domain), l10n.conversationSecurityImitates(l.imitates)],
      );
    case LinksFinding(:final kind, :final links):
      final first = links.first;
      final hosts = {for (final l in links) l.host ?? l.url}.join(', ');
      final urls = [for (final l in links) l.url];
      final texts = [for (final l in links) l10n.conversationSecurityLinkDetail(l.text, l.url)];
      return switch (kind) {
        FindingKind.linkMismatch => text(
          l10n.conversationSecurityLinkMismatchTitle(links.length),
          l10n.conversationSecurityLinkMismatchText(first.detail ?? '', first.host ?? first.url),
          advice: l10n.conversationSecurityLinkMismatchAdvice,
          details: texts,
        ),
        FindingKind.linkUncheckable => text(
          l10n.conversationSecurityLinkUncheckableTitle,
          l10n.conversationSecurityLinkUncheckableText(first.detail ?? '', first.host ?? first.url),
          details: texts,
        ),
        FindingKind.linkHomograph => text(
          l10n.conversationSecurityLinkHomographTitle,
          switch (first.detail) {
            null => l10n.conversationSecurityHomographText(first.host ?? first.url),
            final real => l10n.conversationSecurityHomographImitatesText(first.host ?? first.url, real),
          },
          advice: l10n.conversationSecurityLinkHomographAdvice,
          details: urls,
        ),
        FindingKind.linkIpAddress => text(
          l10n.conversationSecurityIpAddressTitle,
          l10n.conversationSecurityIpAddressText(hosts),
          details: urls,
        ),
        FindingKind.linkUserInfo => text(
          l10n.conversationSecurityUserInfoTitle,
          l10n.conversationSecurityUserInfoText(first.detail ?? '', first.host ?? first.url),
          details: urls,
        ),
        FindingKind.dataLink => text(l10n.conversationSecurityDataLinkTitle, l10n.conversationSecurityDataLinkText),
        FindingKind.scriptLink => text(
          l10n.conversationSecurityScriptLinkTitle,
          l10n.conversationSecurityScriptLinkText,
        ),
        FindingKind.linkShortener => text(
          l10n.conversationSecurityShortenerTitle(links.length),
          l10n.conversationSecurityShortenerText(hosts),
          details: urls,
        ),
        // FindingKind.linkInternational, the last link kind.
        _ => text(
          l10n.conversationSecurityInternationalTitle,
          l10n.conversationSecurityInternationalText(hosts),
          details: urls,
        ),
      };
    case ContentFinding(kind: FindingKind.passwordField):
      return text(
        l10n.conversationSecurityPasswordFieldTitle,
        l10n.conversationSecurityPasswordFieldText,
        advice: l10n.conversationSecurityPasswordFieldAdvice,
      );
    case ContentFinding(:final count, :final severity):
      return severity == Severity.info
          ? text(l10n.conversationSecurityHiddenTextTitle, l10n.conversationSecurityHiddenTextText(count))
          : text(l10n.conversationSecurityLotsOfHiddenTextTitle, l10n.conversationSecurityLotsOfHiddenTextText(count));
  }
}
