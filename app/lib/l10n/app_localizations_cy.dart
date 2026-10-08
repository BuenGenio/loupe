// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Welsh (`cy`).
class AppLocalizationsCy extends AppLocalizations {
  AppLocalizationsCy([String locale = 'cy']) : super(locale);

  @override
  String get commonAdd => 'Ychwanegu';

  @override
  String get commonCancel => 'Diddymu';

  @override
  String get commonClose => 'Cau';

  @override
  String get commonDelete => 'Dileu';

  @override
  String get commonDone => 'Gorffen';

  @override
  String get commonEdit => 'Golygu';

  @override
  String get commonMore => 'Rhagor';

  @override
  String get commonMove => 'Symud';

  @override
  String get commonName => 'Enw';

  @override
  String get commonNone => 'Dim';

  @override
  String get commonOff => 'I ffwrdd';

  @override
  String get commonOk => 'Iawn';

  @override
  String get commonOn => 'Ymlaen';

  @override
  String get commonOptional => 'Dewisol';

  @override
  String get commonPassword => 'Cyfrinair';

  @override
  String get commonRemove => 'Tynnu';

  @override
  String get commonRetry => 'Ceisio eto';

  @override
  String get commonSave => 'Cadw';

  @override
  String get commonSearch => 'Chwilio';

  @override
  String get commonServer => 'Gweinydd';

  @override
  String get commonSettings => 'Gosodiadau';

  @override
  String get commonShare => 'Rhannu';

  @override
  String get commonTryAgain => 'Ceisio eto';

  @override
  String get commonUndo => 'Dadwneud';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count neges',
      many: '$count neges',
      few: '$count neges',
      two: '$count neges',
      one: '$count neges',
      zero: '$count neges',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archifo';

  @override
  String get mailDelete => 'Dileu';

  @override
  String get mailFlag => 'Fflagio';

  @override
  String get mailForward => 'Anfon ymlaen';

  @override
  String get mailMarkAsRead => 'Marcio fel wedi’i darllen';

  @override
  String get mailMarkAsUnread => 'Marcio fel heb ei darllen';

  @override
  String get mailMoveToJunk => 'Symud i Sothach';

  @override
  String get mailNewMessage => 'Neges newydd';

  @override
  String get mailNoSubject => 'Dim pwnc';

  @override
  String get mailReply => 'Ateb';

  @override
  String get mailReplyAll => 'Ateb pawb';

  @override
  String get mailSend => 'Anfon';

  @override
  String get mailUnflag => 'Dad-fflagio';

  @override
  String get mailboxArchive => 'Archif';

  @override
  String get mailboxDrafts => 'Drafftiau';

  @override
  String get mailboxInbox => 'Mewnflwch';

  @override
  String get mailboxJunk => 'Sothach';

  @override
  String get mailboxOutbox => 'Allflwch';

  @override
  String get mailboxSent => 'Anfonwyd';

  @override
  String get mailboxTrash => 'Sbwriel';

  @override
  String get conversationSomethingWentWrong => 'Aeth rhywbeth o’i le. Rhowch gynnig arall arni.';

  @override
  String get conversationReplyToList => 'Ateb y rhestr';

  @override
  String get conversationReplyList => 'Ateb rhestr';

  @override
  String get conversationThreadMuted =>
      'Edefyn wedi’i ddistewi. Bydd negeseuon newydd ynddo’n cyrraedd wedi’u darllen.';

  @override
  String get conversationThreadUnmuted => 'Edefyn wedi’i ddad-ddistewi.';

  @override
  String get conversationLinkFailed => 'Methu agor y ddolen.';

  @override
  String get conversationGoneTitle => 'Dim neges';

  @override
  String get conversationGoneText => 'Mae’r neges hon wedi’i symud neu ei dileu.';

  @override
  String get conversationMuted => 'Wedi’i ddistewi';

  @override
  String get conversationReaderOptions => 'Dewisiadau darllen';

  @override
  String get conversationReaderOptionsHint => 'Maint testun a golwg';

  @override
  String get conversationTrash => 'I’r sbwriel';

  @override
  String get conversationReplyHint => 'Pwyswch yn hir i Ateb pawb neu Anfon ymlaen';

  @override
  String get conversationOfflineTitle => 'Rydych chi all-lein';

  @override
  String get conversationOfflineText =>
      'Dyw’r sgwrs hon ddim wedi’i llwytho i lawr eto. Bydd yn llwytho pan fyddwch chi ar-lein eto.';

  @override
  String get conversationErrorTitle => 'Methu dangos y neges hon';

  @override
  String get conversationErrorText => 'Aeth rhywbeth o’i le.';

  @override
  String get conversationOfflineBanner => 'Rydych chi all-lein';

  @override
  String get conversationNotUpdated => 'Heb ei diweddaru';

  @override
  String get conversationMe => 'fi';

  @override
  String get conversationNoSender => '(dim anfonwr)';

  @override
  String get conversationNoRecipients => 'dim derbynwyr';

  @override
  String conversationRecipients(String names) {
    return 'at $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'at $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Oddi wrth';

  @override
  String get conversationHeaderTo => 'At';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Ateb i';

  @override
  String get conversationHeaderDate => 'Dyddiad';

  @override
  String get conversationHeaderSecurity => 'Diogelwch';

  @override
  String get conversationVerifiedSender => 'Anfonwr wedi’i ddilysu';

  @override
  String get conversationUnverifiedSender => 'Anfonwr heb ei ddilysu';

  @override
  String get conversationLoadingMessage => 'Yn llwytho’r neges';

  @override
  String get conversationBodyError => 'Methu llwytho’r neges hon.';

  @override
  String get conversationBodyOffline => 'Rydych chi all-lein. Bydd y neges yn llwytho pan fyddwch chi ar-lein eto.';

  @override
  String get conversationOriginalHint => 'Mae’n edrych yn well yn y golwg Gwreiddiol';

  @override
  String get conversationShowOriginal => 'Dangos y gwreiddiol';

  @override
  String get conversationScrollToTop => 'Sgrolio i’r brig';

  @override
  String get conversationTagsMenu => 'Tagiau…';

  @override
  String get conversationMuteThread => 'Distewi’r edefyn';

  @override
  String get conversationUnmuteThread => 'Dad-ddistewi’r edefyn';

  @override
  String get conversationMoveMenu => 'Symud…';

  @override
  String get conversationDeletePermanently => 'Dileu’n barhaol';

  @override
  String get conversationMoveToTrash => 'Symud i’r Sbwriel';

  @override
  String get conversationNotJunk => 'Nid sothach';

  @override
  String get conversationShowAllHeaders => 'Dangos pob pennyn';

  @override
  String get conversationViewSource => 'Gweld y ffynhonnell';

  @override
  String get conversationSaveAsFile => 'Cadw fel ffeil…';

  @override
  String get conversationShareAsFile => 'Rhannu fel ffeil…';

  @override
  String get conversationSearchFromMessageMenu => 'Chwilio o’r neges hon…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copïo’r cyfeiriad';

  @override
  String get conversationAddressCopied => 'Cyfeiriad wedi’i gopïo';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Chwilio negeseuon gan $name';
  }

  @override
  String get conversationTags => 'Tagiau';

  @override
  String get conversationAllHeaders => 'Pob pennyn';

  @override
  String get conversationCopyAll => 'Copïo’r cyfan';

  @override
  String get conversationHeadersCopied => 'Penynnau wedi’u copïo';

  @override
  String get conversationNoHeaders => 'Dim penynnau';

  @override
  String get conversationSearchFromMessageTitle => 'Chwilio o’r neges hon';

  @override
  String conversationSearchFrom(String name) {
    return 'Oddi wrth $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'At $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Pwnc “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Ffynhonnell';

  @override
  String get conversationSourceCopied => 'Ffynhonnell wedi’i chopïo';

  @override
  String get conversationShareFailed => 'Methu rhannu’r neges.';

  @override
  String get conversationWrapLines => 'Lapio llinellau';

  @override
  String get conversationDontWrapLines => 'Peidio â lapio llinellau';

  @override
  String get conversationSourceError => 'Methu llwytho’r ffynhonnell.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Yn dangos y $shown cyntaf o $total. Copïwch neu rhannwch i gael y cyfan.';
  }

  @override
  String get conversationAttachmentUntitled => 'Dideitl';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Rhagor o gamau ar gyfer $name';
  }

  @override
  String get conversationMoveTo => 'Symud i…';

  @override
  String get conversationMailboxesError => 'Methu llwytho’r blychau post.';

  @override
  String get conversationReaderReadable => 'Darllenadwy';

  @override
  String get conversationReaderOriginal => 'Gwreiddiol';

  @override
  String get conversationReaderPlain => 'Plaen';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Cadw’r lliwiau gwreiddiol';

  @override
  String get conversationReaderRemember => 'Cofio ar gyfer yr anfonwr hwn';

  @override
  String get conversationSecurityPossiblePhishing => 'Gwe-rwydo posib';

  @override
  String get conversationSecurityBeCareful => 'Byddwch yn ofalus';

  @override
  String get conversationSecurityVerified => 'Wedi’i ddilysu';

  @override
  String get conversationSecurityNoIssues => 'Dim problemau';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count traciwr',
      many: '$count traciwr',
      few: '$count traciwr',
      two: '$count draciwr',
      one: '$count traciwr',
      zero: '$count traciwr',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Yn dangos pam';

  @override
  String get conversationPhishingBannerTitle => 'Mae’r neges hon yn edrych fel gwe-rwydo';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Mae dolenni a delweddau wedi’u diffodd.';
  }

  @override
  String get conversationPhishingBannerText => 'Mae dolenni a delweddau wedi’u diffodd.';

  @override
  String get conversationPhishingWhy => 'Pam?';

  @override
  String get conversationPhishingShowAnyway => 'Dangos beth bynnag';

  @override
  String get conversationSecurityPhishingTitle => 'Mae hyn yn edrych fel gwe-rwydo';

  @override
  String get conversationSecurityPhishingText => 'Mae sawl arwydd nad yw’r neges hon yr hyn y mae’n honni ei bod.';

  @override
  String get conversationSecurityCarefulTitle => 'Byddwch yn ofalus gyda’r neges hon';

  @override
  String get conversationSecurityCarefulText => 'Mae rhywbeth amdani sy’n haeddu ail olwg.';

  @override
  String get conversationSecurityVerifiedText => 'Mae’r anfonwr wedi’i ddilysu a does dim byd yn edrych yn amheus.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Does dim byd yn edrych yn amheus. Wnaeth eich gweinydd e-bost ddim dweud a yw’r anfonwr wedi’i ddilysu.';

  @override
  String get conversationSecurityNothingSuspicious => 'Does dim byd yn edrych yn amheus.';

  @override
  String get conversationSecurityWhy => 'Pam';

  @override
  String get conversationSecurityPrivacy => 'Preifatrwydd';

  @override
  String get conversationSecurityNoTrackingPixels => 'Dim picseli tracio';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tynnwyd $count picsel tracio',
      many: 'Tynnwyd $count picsel tracio',
      few: 'Tynnwyd $count picsel tracio',
      two: 'Tynnwyd $count bicsel tracio',
      one: 'Tynnwyd $count picsel tracio',
      zero: 'Tynnwyd $count picsel tracio',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Bydden nhw wedi dweud wrth yr anfonwr pryd agoroch chi’r neges hon.';

  @override
  String get conversationSecurityNoRemoteImages => 'Dim delweddau o bell';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count delwedd o bell',
      many: '$count delwedd o bell',
      few: '$count delwedd o bell',
      two: '$count ddelwedd o bell',
      one: '$count ddelwedd o bell',
      zero: '$count delwedd o bell',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Mae eu llwytho’n dweud wrth yr anfonwr pryd rydych chi’n darllen y neges hon, a beth yw’ch cyfeiriad IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Dim tracio cliciau';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dolen drwy dracwyr cliciau',
      many: '$count dolen drwy dracwyr cliciau',
      few: '$count dolen drwy dracwyr cliciau',
      two: '$count ddolen drwy dracwyr cliciau',
      one: '$count ddolen drwy dracwyr cliciau',
      zero: '$count dolen drwy dracwyr cliciau',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Byddai $services yn cofnodi’ch clic. Pwyswch yn hir ar ddolen i agor ei chyrchfan yn uniongyrchol.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Manylion technegol';

  @override
  String get conversationSecurityCheckedLocally => 'Wedi’i wirio ar y ddyfais hon. Chafodd dim byd ei anfon i unman.';

  @override
  String get conversationSecurityTrackersLabel => 'Tracwyr';

  @override
  String get conversationSecurityImagesFrom => 'Delweddau o';

  @override
  String get conversationSecuritySenderHistory => 'Hanes yr anfonwr';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received wedi’u derbyn, $sent wedi’u hanfon';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Dolenni’n arwain at';

  @override
  String get conversationSecurityHidden => 'Cudd';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elfen',
      many: '$elements elfen',
      few: '$elements elfen',
      two: '$elements elfen',
      one: '$elements elfen',
      zero: '$elements elfen',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters nod',
      many: '$characters nod',
      few: '$characters nod',
      two: '$characters nod',
      one: '$characters nod',
      zero: '$characters nod',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Anfonwr heb ei ddilysu';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Doedd eich gweinydd e-bost ddim yn gallu cadarnhau bod y neges hon wir yn dod o $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Doedd eich gweinydd e-bost ddim yn gallu cadarnhau bod y neges hon wir yn dod gan ei hanfonwr.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Doedd eich gweinydd e-bost ddim yn gallu cadarnhau bod y neges hon yn dod o $domain. Mae hyn yn gyffredin gyda rhestrau e-bost.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Doedd eich gweinydd e-bost ddim yn gallu cadarnhau bod y neges hon yn dod gan ei hanfonwr. Mae hyn yn gyffredin gyda rhestrau e-bost.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Peidiwch â gweithredu arni oni bai eich bod chi’n ei disgwyl. Os oes amheuaeth, cysylltwch â’r anfonwr mewn ffordd arall.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Wedi’i llofnodi gan barth arall';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Mae’r neges wedi’i llofnodi gan $signer, nid $domain. Mae gwasanaethau postio’n gwneud hyn, ond dyw hynny ddim yn profi pwy a’i hysgrifennodd.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Mae’r neges wedi’i llofnodi gan barth arall, nid $domain. Mae gwasanaethau postio’n gwneud hyn, ond dyw hynny ddim yn profi pwy a’i hysgrifennodd.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Mae’r enw’n dangos cyfeiriad gwahanol';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Mae enw’r anfonwr yn dweud “$shown”, ond mae’r neges yn dod o $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Ymddiriedwch yn y cyfeiriad, nid yn yr enw.';

  @override
  String get conversationSecurityReplyToTitle => 'Mae atebion yn mynd i rywle arall';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Byddai ateb yn anfon eich ateb i $address, nid i $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Gwiriwch y cyfeiriad cyn ateb gydag unrhyw beth personol.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Yn defnyddio’ch enw';

  @override
  String get conversationSecurityImpersonationTitle => 'Yn defnyddio enw rhywun rydych chi’n ei adnabod';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Mae wedi’i llofnodi “$name”, fel eich enw chi, ond mae’n dod o gyfeiriad newydd: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Mae wedi’i llofnodi “$name”, fel eich VIP $knownName ($knownEmail), ond mae’n dod o gyfeiriad newydd: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Mae wedi’i llofnodi “$name”, fel $knownName ($knownEmail), ond mae’n dod o gyfeiriad newydd: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'A byddai atebion yn mynd i gyfeiriad arall eto.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Os yw’n gofyn am arian, codau neu ffeiliau, holwch nhw mewn ffordd arall yn gyntaf.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Cyfeiriad hysbys: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Y cyfeiriad hwn: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Y neges gyntaf gan yr anfonwr hwn';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Dydych chi ddim wedi cael e-bost gan $email o’r blaen.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Byddwch yn ofalus gyda cheisiadau gan bobl nad ydych chi’n eu hadnabod eto.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Llythrennau tebyg yng nghyfeiriad yr anfonwr';

  @override
  String get conversationSecurityLinkHomographTitle => 'Llythrennau tebyg mewn dolen';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Mae $host yn cymysgu llythrennau o wahanol wyddorau i ddynwared cyfeiriad arall.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Mae $host yn defnyddio llythrennau tebyg: nid $real yw e.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Dilëwch hi neu rhowch wybod ei bod yn sothach.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Peidiwch â’i hagor.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Parth: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Parth sy’n edrych yn debyg';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Yn defnyddio enw cyfarwydd yn ei barth';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Mae $domain yn edrych fel eich parth eich hun, $real, ond mae’n barth gwahanol.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Mae $domain yn edrych fel $brand ($real), ond mae’n barth gwahanol.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Mae $domain yn defnyddio enw eich parth eich hun, $real, ond dyw e ddim yn perthyn iddo.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Mae $domain yn defnyddio enw $brand ($real), ond dyw e ddim yn perthyn iddo.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Mae negeseuon go iawn gan eich sefydliad yn dod o $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Mae negeseuon go iawn gan $brand yn dod o $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Parth yr anfonwr: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Yn dynwared: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mae $count dolen yn cuddio i ble maen nhw’n mynd',
      many: 'Mae $count dolen yn cuddio i ble maen nhw’n mynd',
      few: 'Mae $count dolen yn cuddio i ble maen nhw’n mynd',
      two: 'Mae $count ddolen yn cuddio i ble maen nhw’n mynd',
      one: 'Mae dolen yn cuddio i ble mae’n mynd',
      zero: 'Mae $count dolen yn cuddio i ble maen nhw’n mynd',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Mae dolen yn dangos $shown, ond mae’n agor $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Peidiwch â mewngofnodi na thalu drwy’r dolenni hyn. Teipiwch y cyfeiriad eich hun yn lle hynny.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Does dim modd gwirio cyrchfan dolen';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Mae dolen yn dangos $shown, ond yn mynd drwy $host, sy’n cofnodi’r clic cyn ei basio ymlaen.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Mae dolen yn pwyntio at gyfeiriad IP moel';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return 'Dyw $hosts ddim yn wefan ag enw. Anaml y bydd cwmnïau go iawn yn creu dolenni fel hyn.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Dolen wedi’i chuddio';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Mae dolen yn dechrau gyda “$shown@” i edrych fel $shown, ond mae’n agor $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Analluogwyd tudalen gudd';

  @override
  String get conversationSecurityDataLinkText =>
      'Byddai dolen wedi agor tudalen wedi’i phacio y tu mewn i’r neges, ffordd o osgoi gwiriadau dolenni.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Yn gofyn am gyfrinair';

  @override
  String get conversationSecurityPasswordFieldText => 'Roedd maes cyfrinair yn y neges. Mae Loupe wedi’i dynnu.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Peidiwch byth â theipio cyfrinair mewn e-bost.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Analluogwyd dolen sy’n rhedeg cod';

  @override
  String get conversationSecurityScriptLinkText => 'Dyw Loupe byth yn rhedeg cod o negeseuon.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dolenni wedi’u byrhau',
      many: 'Dolenni wedi’u byrhau',
      few: 'Dolenni wedi’u byrhau',
      two: 'Dolenni wedi’u byrhau',
      one: 'Dolen wedi’i byrhau',
      zero: 'Dolenni wedi’u byrhau',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return 'Mae $hosts yn cuddio’r gyrchfan go iawn nes i chi ei hagor.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Cyfeiriad gwe rhyngwladol';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return 'Mae $hosts yn defnyddio llythrennau heblaw’r wyddor Ladin. Mae hyn yn arferol mewn llawer o ieithoedd; gwiriwch mai dyma’r wefan rydych chi’n ei disgwyl.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Llawer o destun cudd';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
      many: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
      few: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
      two: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
      one: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
      zero: 'Tynnwyd $count nod o destun anweledig. Mae testun cudd fel hyn wedi’i fwriadu i dwyllo hidlwyr sbam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Tynnwyd testun cudd';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tynnwyd $count nod o destun anweledig.',
      many: 'Tynnwyd $count nod o destun anweledig.',
      few: 'Tynnwyd $count nod o destun anweledig.',
      two: 'Tynnwyd $count nod o destun anweledig.',
      one: 'Tynnwyd $count nod o destun anweledig.',
      zero: 'Tynnwyd $count nod o destun anweledig.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Methu llwytho’r neges i lawr. Gwiriwch y cysylltiad a rhowch gynnig arall arni.';

  @override
  String exportSaved(String name) {
    return 'Wedi cadw “$name”';
  }

  @override
  String get exportSaveFailed => 'Methu cadw’r neges.';

  @override
  String exportFailed(String folder) {
    return 'Methu allforio “$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Does dim negeseuon yn “$folder” i’w hallforio.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Methu allforio “$folder”: doedd dim modd llwytho unrhyw neges i lawr. Gwiriwch y cysylltiad a rhowch gynnig arall arni.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wedi cadw “$name” heb $formattedCount neges nad oedd modd eu llwytho i lawr.',
      many: 'Wedi cadw “$name” heb $formattedCount neges nad oedd modd eu llwytho i lawr.',
      few: 'Wedi cadw “$name” heb $formattedCount neges nad oedd modd eu llwytho i lawr.',
      two: 'Wedi cadw “$name” heb $formattedCount neges nad oedd modd eu llwytho i lawr.',
      one: 'Wedi cadw “$name” heb 1 neges nad oedd modd ei llwytho i lawr.',
      zero: 'Wedi cadw “$name” heb $formattedCount neges nad oedd modd eu llwytho i lawr.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Methu cadw “$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Yn allforio “$folder”';
  }

  @override
  String get exportListing => 'Yn chwilio am negeseuon…';

  @override
  String exportProgress(String current, String total) {
    return 'Yn allforio $current o $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Doedd dim modd llwytho $formattedCount neges i lawr',
      many: 'Doedd dim modd llwytho $formattedCount neges i lawr',
      few: 'Doedd dim modd llwytho $formattedCount neges i lawr',
      two: 'Doedd dim modd llwytho $formattedCount neges i lawr',
      one: 'Doedd dim modd llwytho 1 neges i lawr',
      zero: 'Doedd dim modd llwytho $formattedCount neges i lawr',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Blychau post';

  @override
  String get mailboxesShown => 'Yn cael ei ddangos';

  @override
  String get mailboxesHidden => 'Wedi’i guddio';

  @override
  String get mailboxesCollapse => 'Lleihau';

  @override
  String get mailboxesExpand => 'Ehangu';

  @override
  String get mailboxesManageVips => 'Rheoli VIPs';

  @override
  String get mailboxesSubscriptions => 'Tanysgrifiadau';

  @override
  String mailboxesShowAccount(String account) {
    return 'Dangos $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Cuddio $account';
  }

  @override
  String get mailboxesExportFolder => 'Allforio’r ffolder…';

  @override
  String get mailboxesUnpin => 'Dadbinio';

  @override
  String get mailboxesLists => 'Rhestrau';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Cadwch chwiliad i’w gadw yma.';

  @override
  String get mailboxesTags => 'Tagiau';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Gallwch chi hefyd dapio enw anfonwr mewn neges a throi VIP ymlaen.';

  @override
  String get mailboxesAddVip => 'Ychwanegu VIP…';

  @override
  String get mailboxesAddVipTitle => 'Ychwanegu VIP';

  @override
  String get mailboxesAddVipText => 'Mae e-bost o’r cyfeiriad hwn yn cael seren ac yn ymddangos yn y blwch post VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Heb eu darllen';

  @override
  String get messageListFilterFlagged => 'Wedi’u fflagio';

  @override
  String get messageListFilterToMe => 'At: Fi';

  @override
  String get messageListFilterCcMe => 'Cc: Fi';

  @override
  String get messageListFilterWithAttachments => 'Gydag atodiadau';

  @override
  String get messageListFilterUnreplied => 'Heb eu hateb';

  @override
  String get messageListFilterFromVips => 'Gan VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Marciwyd $count neges fel wedi’u darllen',
      many: 'Marciwyd $count neges fel wedi’u darllen',
      few: 'Marciwyd $count neges fel wedi’u darllen',
      two: 'Marciwyd $count neges fel wedi’u darllen',
      one: 'Marciwyd 1 neges fel wedi’i darllen',
      zero: 'Marciwyd $count neges fel wedi’u darllen',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Methu llwytho e-bost hŷn.';

  @override
  String get messageListSelectMessages => 'Dewis negeseuon';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wedi’u dewis',
      many: '$count wedi’u dewis',
      few: '$count wedi’u dewis',
      two: '$count wedi’u dewis',
      one: '$count wedi’i dewis',
      zero: '$count wedi’u dewis',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Dewis y cyfan';

  @override
  String get messageListDeselectAll => 'Dad-ddewis y cyfan';

  @override
  String get messageListLoadFailed => 'Methu llwytho e-bost';

  @override
  String get messageListNoUnread => 'Dim e-bost heb ei ddarllen';

  @override
  String get messageListNoMatches => 'Dim e-bost sy’n cyfateb';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Wedi’u hidlo yn ôl: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Diffodd yr hidlydd';

  @override
  String get messageListEmpty => 'Dim e-bost';

  @override
  String get messageListFilter => 'Hidlo';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Meini prawf hidlo: $filters';
  }

  @override
  String get messageListFilteredBy => 'Wedi’u hidlo yn ôl:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount heb eu darllen',
      many: '$formattedCount heb eu darllen',
      few: '$formattedCount heb eu darllen',
      two: '$formattedCount heb eu darllen',
      one: '$formattedCount heb ei darllen',
      zero: '$formattedCount heb eu darllen',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marcio';

  @override
  String get messageListTrash => 'I’r sbwriel';

  @override
  String get messageListFilterTitle => 'Hidlo';

  @override
  String get messageListFilterInclude => 'CYNNWYS';

  @override
  String get panesHideMailboxes => 'Cuddio’r blychau post';

  @override
  String get panesShowMailboxes => 'Dangos y blychau post';

  @override
  String get panesMailboxesWidth => 'Lled y blychau post';

  @override
  String get panesListWidth => 'Lled y rhestr negeseuon';

  @override
  String get panesNoMessageSelected => 'Dim neges wedi’i dewis';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count neges',
      many: '$count neges',
      few: '$count neges',
      two: '$count neges',
      one: '1 neges',
      zero: '$count neges',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Wedi’u gohirio';

  @override
  String get snoozeSheetTitle => 'Gohirio';

  @override
  String get snoozeLaterToday => 'Yn nes ymlaen heddiw';

  @override
  String get snoozeThisEvening => 'Heno';

  @override
  String get snoozeTomorrow => 'Yfory';

  @override
  String get snoozeThisWeekend => 'Y penwythnos hwn';

  @override
  String get snoozeNextWeek => 'Wythnos nesaf';

  @override
  String get snoozePickDateTime => 'Dewis dyddiad ac amser…';

  @override
  String get snoozeMenu => 'Gohirio…';

  @override
  String get snoozeWakeNow => 'Deffro nawr';

  @override
  String get snoozeChangeTimeMenu => 'Newid amser gohirio…';

  @override
  String get snoozeChangeTime => 'Newid amser';

  @override
  String get snoozeNoTime => 'Dim amser wedi’i osod';

  @override
  String get snoozeFooter => 'Mae negeseuon wedi’u gohirio’n dod yn ôl i’r Mewnflwch, heb eu darllen, ar eu hamser.';

  @override
  String get snoozeEmptyTitle => 'Dim byd wedi’i ohirio';

  @override
  String get snoozeEmptyText => 'Gohiriwch neges i’w chael yn ôl yn y Mewnflwch pan fydd ei hangen arnoch chi.';

  @override
  String get appLockUnlock => 'Datgloi';

  @override
  String get appLockFailed => 'Doedd Loupe ddim yn gallu cadarnhau mai chi sydd yno.';

  @override
  String get appLockLockedOut => 'Gormod o ymdrechion. Rhowch gynnig arall arni nes ymlaen.';

  @override
  String get appLockPromptError => 'Methu dangos yr anogwr. Rhowch gynnig arall arni.';

  @override
  String get appLockNoScreenLock => 'Does gan y ffôn hwn ddim clo sgrin.';

  @override
  String get appLockUnlockPromptTitle => 'Datgloi Loupe';

  @override
  String get appLockUnlockPromptReason => 'Cadarnhewch mai chi sydd yno i weld eich e-bost.';

  @override
  String get appLockTurnOnPromptTitle => 'Troi Clo Ap ymlaen';

  @override
  String get appLockTurnOnPromptReason => 'Cadarnhewch mai chi sydd yno i droi Clo Ap ymlaen.';

  @override
  String get appLockScreenLockRemoved =>
      'Mae Clo Ap i ffwrdd: does gan y ffôn hwn ddim clo sgrin bellach. Gosodwch un i droi Clo Ap ymlaen eto.';

  @override
  String get appLockAfterImmediately => 'Ar unwaith';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count munud',
      many: '$count munud',
      few: '$count munud',
      two: '$count funud',
      one: '1 munud',
      zero: '$count munud',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count awr',
      many: '$count awr',
      few: '$count awr',
      two: '$count awr',
      one: '1 awr',
      zero: '$count awr',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Wedi’i hamgryptio';

  @override
  String get openpgpEncryptedInPart => 'Wedi’i hamgryptio’n rhannol';

  @override
  String get openpgpEncryptedLocked => 'Wedi’i hamgryptio · ar glo';

  @override
  String get openpgpEncryptedNoKey => 'Wedi’i hamgryptio · dim allwedd';

  @override
  String get openpgpEncryptedDamaged => 'Wedi’i hamgryptio · wedi’i difrodi';

  @override
  String get openpgpEncryptedUnsupported => 'Wedi’i hamgryptio · heb gefnogaeth';

  @override
  String get openpgpUnknownSigner => 'anhysbys';

  @override
  String get openpgpUnknownKey => 'Allwedd anhysbys';

  @override
  String get openpgpSignatureInvalid => 'Llofnod annilys';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Wedi’i llofnodi gan $name, nid yr anfonwr';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Wedi’i llofnodi’n rhannol gan $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Wedi’i llofnodi gan $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Wedi’i llofnodi ag allwedd a wrthodwyd';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Wedi’i llofnodi gan $name · allwedd heb ei derbyn';
  }

  @override
  String get openpgpUnlock => 'Datgloi';

  @override
  String get openpgpCantDecrypt => 'Methu dadgryptio’r neges hon';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Wedi’i hamgryptio ag OpenPGP';

  @override
  String get openpgpEncryption => 'Amgryptio';

  @override
  String get openpgpDecryptedHere => 'Wedi’i dadgryptio ar y ddyfais hon';

  @override
  String get openpgpNotDecrypted => 'Heb ei dadgryptio';

  @override
  String get openpgpKeyLocked => 'Mae’ch allwedd ar glo.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ar gyfer allweddi $keys',
      many: 'Ar gyfer allweddi $keys',
      few: 'Ar gyfer allweddi $keys',
      two: 'Ar gyfer allweddi $keys',
      one: 'Ar gyfer allwedd $keys',
      zero: 'Ar gyfer allweddi $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Pwnc wedi’i ddiogelu';

  @override
  String get openpgpUnlockKey => 'Datgloi’r allwedd';

  @override
  String get openpgpSignature => 'Llofnod';

  @override
  String get openpgpFingerprint => 'Ôl bys';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID allwedd $id';
  }

  @override
  String get openpgpSigned => 'Llofnodwyd';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Derbyn';

  @override
  String get openpgpChangeAcceptance => 'Newid derbyn…';

  @override
  String get openpgpCheckedFooter => 'Wedi’i gwirio ar y ddyfais hon gydag OpenPGP, yn gydnaws â Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Mae’ch allwedd ar glo. Datglowch hi gyda’i chyfrinymadrodd i ddarllen y neges hon.';

  @override
  String get openpgpSummaryNoSecretKey => 'Cafodd ei hamgryptio i allwedd sydd ddim ar y ddyfais hon.';

  @override
  String get openpgpSummaryDamaged => 'Mae’r data wedi’i amgryptio wedi’i ddifrodi neu wedi’i newid ar y ffordd.';

  @override
  String get openpgpSummaryUnsupported => 'Mae’n defnyddio algorithm nad yw Loupe yn ei gefnogi.';

  @override
  String get openpgpSummaryEncrypted => 'Dim ond chi a’r derbynwyr eraill sy’n gallu ei darllen.';

  @override
  String get openpgpSummaryNotSigned => 'Dyw hi ddim wedi’i llofnodi, felly dyw’r anfonwr ddim wedi’i gadarnhau.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Mae wedi’i llofnodi, ond ag allwedd sydd ddim gennych chi, felly does dim modd gwirio’r llofnod.';

  @override
  String get openpgpSummaryBadSignature => 'Dyw’r llofnod ddim yn cyfateb: efallai bod y neges wedi’i newid.';

  @override
  String get openpgpSummaryMismatch =>
      'Mae’r llofnod yn ddilys, ond mae’r allwedd yn perthyn i gyfeiriad gwahanol i un yr anfonwr.';

  @override
  String get openpgpSummaryPartial =>
      'Dim ond rhan o’r neges sydd wedi’i llofnodi. Mae testun y tu allan i’r llofnod (troedyn rhestr e-bost, er enghraifft) yn cael ei ddangos o dan y llinell “Unsigned content”, a dyw rhannau eraill o’r neges, fel atodiadau, ddim wedi’u cynnwys chwaith.';

  @override
  String get openpgpSummaryOwnKey => 'Wedi’i llofnodi â’ch allwedd eich hun.';

  @override
  String get openpgpSummaryVerified => 'Mae’r llofnod yn ddilys, ac rydych chi wedi gwirio ôl bys yr allwedd.';

  @override
  String get openpgpSummaryUnverified => 'Mae’r llofnod yn ddilys. Fe dderbynioch chi’r allwedd heb wirio’i hôl bys.';

  @override
  String get openpgpSummaryRejected => 'Mae’r llofnod yn ddilys, ond rydych chi wedi gwrthod yr allwedd hon.';

  @override
  String get openpgpSummaryUndecided =>
      'Mae’r llofnod yn ddilys, ond dydych chi ddim wedi derbyn yr allwedd hon eto. Cymharwch ei hôl bys gyda’r anfonwr.';

  @override
  String get openpgpAcceptanceRejected => 'Gwrthodwyd';

  @override
  String get openpgpAcceptanceUndecided => 'Heb ei derbyn';

  @override
  String get openpgpAcceptanceUnverified => 'Derbyniwyd';

  @override
  String get openpgpAcceptanceVerified => 'Derbyniwyd a dilyswyd';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Derbyn allwedd $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Ôl bys $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ie, rydw i wedi gwirio’r ôl bys';

  @override
  String get openpgpAcceptUnverified => 'Ie, heb wirio';

  @override
  String get openpgpAcceptLater => 'Ddim eto';

  @override
  String get openpgpRejectKey => 'Gwrthod yr allwedd hon';

  @override
  String get openpgpNoSubject => '(dim pwnc)';

  @override
  String get openpgpEncryptionTitle => 'Amgryptio pen-i-ben';

  @override
  String get openpgpMyKeys => 'Fy allweddi OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Gydag allwedd, gallwch chi ddarllen e-bost wedi’i amgryptio, a llofnodi ac amgryptio’ch e-bost eich hun. Yn defnyddio Thunderbird? Allforiwch eich allwedd yno (Gosodiadau Cyfrif › Amgryptio Pen-i-Ben › Allforio Allwedd Gyfrinachol) a’i mewnforio yma.';

  @override
  String get openpgpAddKey => 'Ychwanegu allwedd…';

  @override
  String get openpgpAddresses => 'Cyfeiriadau';

  @override
  String get openpgpAddressesFooter =>
      'Pa allwedd mae pob cyfeiriad yn ei defnyddio, a phryd mae’n amgryptio ac yn llofnodi.';

  @override
  String get openpgpCorrespondentsKeys => 'Allweddi OpenPGP gohebwyr';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Derbyniwch allwedd unwaith y byddwch chi’n ymddiried ei bod yn perthyn i’w pherchennog; cymharwch yr ôl bys gyda nhw i’w marcio wedi’i dilysu.';

  @override
  String get openpgpImportPublicKey => 'Mewnforio allwedd gyhoeddus…';

  @override
  String get openpgpCollected => 'Wedi’u casglu o Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Allweddi a gyrhaeddodd gyda negeseuon. Gall Loupe amgryptio iddyn nhw pan fydd y ddwy ochr yn gofyn am hynny.';

  @override
  String get openpgpOnThisDevice => 'Ar y ddyfais hon';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Mae negeseuon wedi’u hamgryptio’n cuddio’u pwnc. Mae Loupe yn cadw pwnc pob neges rydych chi’n ei hagor yn ei gronfa ddata wedi’i hamgryptio ar y ddyfais hon, fel bod y rhestr, chwilio a hysbysiadau’n ei ddangos. Yn y cefndir, gall Loupe hefyd ddadgryptio pynciau negeseuon newydd gydag allweddi heb gyfrinymadrodd; mae’n llwytho pob neges i lawr (hyd at 1 MB) i wneud hynny.';

  @override
  String get openpgpDecryptSubjects => 'Dadgryptio pynciau yn y cefndir';

  @override
  String get openpgpIndexFooter =>
      'Mae chwilio’n dod o hyd i negeseuon wedi’u hamgryptio yn ôl eu hanfonwr, eu derbynwyr a’u pwnc. Gyda hyn ymlaen, mae Loupe hefyd yn ychwanegu testun pob neges wedi’i hamgryptio y mae’n ei dadgryptio at y mynegai chwilio yn ei gronfa ddata wedi’i hamgryptio ar y ddyfais hon, fel bod chwilio’n dod o hyd iddi yn ôl ei thestun hefyd. Mae ei ddiffodd yn tynnu’r testun hwnnw o’r mynegai.';

  @override
  String get openpgpIndexDecrypted => 'Mynegeio negeseuon wedi’u dadgryptio ar gyfer chwilio';

  @override
  String get openpgpPassphrases => 'Cyfrinymadroddion';

  @override
  String get openpgpPassphrasesFooter =>
      'Mae allweddi OpenPGP a thystysgrifau S/MIME rydych chi’n eu diogelu â chyfrinymadrodd yn cael eu datgloi pan fo angen. Heb “Cofio cyfrinymadroddion”, maen nhw’n cael eu cloi eto ddwy funud ar ôl pob defnydd.';

  @override
  String get openpgpRememberPassphrases => 'Cofio cyfrinymadroddion';

  @override
  String get openpgpRememberPassphrasesDetail => 'Nes i Loupe gau';

  @override
  String get openpgpLockKeysNow => 'Cloi’r allweddi nawr';

  @override
  String get openpgpKeysLocked => 'Allweddi wedi’u cloi.';

  @override
  String get openpgpKeyStateRevoked => 'wedi’i dirymu';

  @override
  String get openpgpKeyStateExpired => 'wedi dod i ben';

  @override
  String get openpgpKeyStateNeverExpires => 'byth yn dod i ben';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'yn dod i ben $date';
  }

  @override
  String get openpgpNoKey => 'Dim allwedd';

  @override
  String get openpgpAlwaysEncrypt => 'Amgryptio bob tro';

  @override
  String get openpgpAddKeyTitle => 'Ychwanegu allwedd OpenPGP';

  @override
  String get openpgpAddKeyMessage =>
      'Mewnforiwch yr allwedd rydych chi’n ei defnyddio yn Thunderbird, neu crëwch un newydd.';

  @override
  String get openpgpImportFromClipboard => 'Mewnforio o’r clipfwrdd';

  @override
  String get openpgpImportFromFile => 'Mewnforio o ffeil';

  @override
  String get openpgpGenerateNewKey => 'Cynhyrchu allwedd newydd';

  @override
  String get openpgpImportPublicKeyTitle => 'Mewnforio allwedd gyhoeddus';

  @override
  String get openpgpFromClipboard => 'O’r clipfwrdd';

  @override
  String get openpgpFromFile => 'O ffeil';

  @override
  String get openpgpClipboardEmpty => 'Mae’r clipfwrdd yn wag. Copïwch yr allwedd yn gyntaf.';

  @override
  String get openpgpKey => 'Allwedd';

  @override
  String get openpgpValidityRevoked => 'Wedi’i dirymu';

  @override
  String openpgpValidityExpired(String date) {
    return 'Daeth i ben $date';
  }

  @override
  String get openpgpNeverExpires => 'Byth yn dod i ben';

  @override
  String openpgpValidUntil(String date) {
    return 'Dilys tan $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Ôl bys wedi’i gopïo.';

  @override
  String get openpgpAlgorithm => 'Algorithm';

  @override
  String get openpgpCreated => 'Crëwyd';

  @override
  String get openpgpValidity => 'Dilysrwydd';

  @override
  String get openpgpProtection => 'Diogelu';

  @override
  String get openpgpProtectionPassphrase => 'Cyfrinymadrodd';

  @override
  String get openpgpProtectionKeychain => 'Cadwyn allweddi yn unig';

  @override
  String get openpgpKeyDetailsFooter =>
      'Rhannwch eich allwedd gyhoeddus fel bod eraill yn gallu amgryptio i chi. Y copi wrth gefn yw’ch allwedd gyfrinachol, wedi’i diogelu gan ei chyfrinymadrodd os oes ganddi un: cadwch hi’n breifat.';

  @override
  String get openpgpSharePublicKey => 'Rhannu’r allwedd gyhoeddus';

  @override
  String get openpgpCopyPublicKey => 'Copïo’r allwedd gyhoeddus';

  @override
  String get openpgpPublicKeyCopied => 'Allwedd gyhoeddus wedi’i chopïo.';

  @override
  String get openpgpBackUpSecretKey => 'Gwneud copi wrth gefn o’r allwedd gyfrinachol';

  @override
  String get openpgpDeleteKey => 'Dileu’r allwedd';

  @override
  String get openpgpRemoveKey => 'Tynnu’r allwedd';

  @override
  String get openpgpBackUpTitle => 'Gwneud copi wrth gefn o’r allwedd gyfrinachol?';

  @override
  String get openpgpBackUpProtected =>
      'Mae’r copi wrth gefn wedi’i ddiogelu gan gyfrinymadrodd eich allwedd. Gall unrhyw un sydd â’r ddau ddarllen eich e-bost.';

  @override
  String get openpgpBackUpUnprotected =>
      'Does gan yr allwedd hon ddim cyfrinymadrodd: gall unrhyw un sydd â’r copi wrth gefn ddarllen eich e-bost a llofnodi fel chi.';

  @override
  String get openpgpBackUp => 'Gwneud copi wrth gefn';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Dileu eich allwedd $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Tynnu allwedd $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Fydd dim modd darllen e-bost wedi’i amgryptio i’r allwedd hon ar y ddyfais hon mwyach, oni bai eich bod chi’n ei mewnforio eto.';

  @override
  String get openpgpRemoveKeyMessage => 'Gallwch chi ei mewnforio eto yn nes ymlaen.';

  @override
  String get openpgpKeyHeader => 'Allwedd OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Ychwanegwch allwedd yn Amgryptio pen-i-ben i amgryptio a llofnodi e-bost o’r cyfeiriad hwn.';

  @override
  String get openpgpGenerateAKey => 'Cynhyrchu allwedd…';

  @override
  String get openpgpSending => 'Anfon';

  @override
  String get openpgpSendingFooter =>
      'Mae amgryptio awtomatig yn troi ymlaen pan fydd gan bob derbynnydd allwedd wedi’i derbyn neu dystysgrif ddibynadwy, neu pan fydd Autocrypt yn dweud bod y ddwy ochr am ei gael. Mae e-bost wedi’i amgryptio bob amser yn cael ei lofnodi.';

  @override
  String get openpgpEncryptAutomatically => 'Amgryptio’n awtomatig';

  @override
  String get openpgpAlwaysEncryptDetail => 'Yn gwrthod anfon pan fo derbynnydd heb allwedd';

  @override
  String get openpgpSignUnencrypted => 'Llofnodi e-bost heb ei amgryptio';

  @override
  String get openpgpAttachPublicKey => 'Atodi fy allwedd gyhoeddus';

  @override
  String get openpgpAutocryptFooter =>
      'Mae Autocrypt yn anfon eich allwedd gyhoeddus gyda phob neges, fel bod apiau eraill yn gallu amgryptio i chi heb osod dim.';

  @override
  String get openpgpSendMyKey => 'Anfon fy allwedd gydag e-bost';

  @override
  String get openpgpPreferEncryption => 'Mae’n well gen i amgryptio';

  @override
  String get openpgpPreferEncryptionDetail => 'Gofyn i eraill amgryptio pan allan nhw';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count blynedd',
      many: '$count blynedd',
      few: '$count blynedd',
      two: '$count flynedd',
      one: '1 flwyddyn',
      zero: '$count blynedd',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Dyw’r cyfrinymadroddion ddim yn cyfateb.';

  @override
  String openpgpKeyReady(String id) {
    return 'Mae’ch allwedd $id yn barod.';
  }

  @override
  String get openpgpNewKey => 'Allwedd newydd';

  @override
  String get openpgpNewKeyFor => 'Ar gyfer';

  @override
  String get openpgpYourName => 'Eich enw';

  @override
  String get openpgpAddress => 'Cyfeiriad';

  @override
  String get openpgpPassphrase => 'Cyfrinymadrodd';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Dewisol. Hebddo, dim ond cadwyn allweddi’ch ffôn sy’n diogelu’r allwedd a fydd Loupe byth yn gofyn. Gydag un, bydd Loupe yn gofyn amdano pan fydd angen yr allwedd.';

  @override
  String get openpgpRepeatPassphrase => 'Ailadrodd';

  @override
  String get openpgpExpires => 'Yn dod i ben';

  @override
  String get openpgpExpiresFooter =>
      'Gallwch chi greu allwedd newydd cyn iddi ddod i ben. Mae Thunderbird yn defnyddio tair blynedd hefyd.';

  @override
  String get openpgpGenerateKey => 'Cynhyrchu allwedd';

  @override
  String get openpgpKeyFor => 'Allwedd ar gyfer';

  @override
  String get openpgpCantEncrypt => 'Methu amgryptio';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Does dim allwedd OpenPGP ar gyfer $names, ac mae’r cyfeiriad hwn bob amser yn amgryptio. Tynnwch y derbynnydd, neu mewnforiwch eu hallwedd yn Gosodiadau › Amgryptio pen-i-ben.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Does dim tystysgrif S/MIME ddilys ar gyfer $names, ac mae’r cyfeiriad hwn bob amser yn amgryptio. Tynnwch y derbynnydd, neu mewnforiwch eu tystysgrif yn Gosodiadau › Amgryptio pen-i-ben.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Does dim allwedd OpenPGP ar gyfer $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Does dim tystysgrif S/MIME ddilys ar gyfer $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Anfon heb amgryptio';

  @override
  String get openpgpCantSign => 'Methu llofnodi';

  @override
  String get openpgpCantSignMessage =>
      'Dyw allwedd breifat eich tystysgrif S/MIME ddim ar y ddyfais hon. Mewnforiwch y dystysgrif eto (ffeil .p12 neu .pfx) yn Gosodiadau › Amgryptio pen-i-ben.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Dim allwedd ar gyfer $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Dim tystysgrif ar gyfer $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Allweddi o Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Mae gan bawb allwedd';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Mae gan bawb dystysgrif';

  @override
  String get openpgpComposeEncrypt => 'Amgryptio';

  @override
  String get openpgpComposeSign => 'Llofnodi';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, newid';
  }

  @override
  String get openpgpNoKeyFound => 'Heb ddod o hyd i allwedd OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Mewnforio allwedd gyfrinachol?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Mae’r atodiad hwn yn cynnwys allwedd gyfrinachol ($names). Mewnforiwch hi fel eich allwedd eich hun dim ond os gwnaethoch chi ei hallforio eich hun, o Thunderbird er enghraifft.';
  }

  @override
  String get openpgpImportAsMyKey => 'Mewnforio fel fy allwedd';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'eich allwedd $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mewnforio $count allwedd ($names)?',
      many: 'Mewnforio $count allwedd ($names)?',
      few: 'Mewnforio $count allwedd ($names)?',
      two: 'Mewnforio $count allwedd ($names)?',
      one: 'Mewnforio allwedd $names?',
      zero: 'Mewnforio $count allwedd ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Mewnforio a derbyn';

  @override
  String get openpgpImportDecideLater => 'Mewnforio, penderfynu wedyn';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'allwedd $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Wedi mewnforio $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mae $count allwedd OpenPGP wedi’u hatodi.',
      many: 'Mae $count allwedd OpenPGP wedi’u hatodi.',
      few: 'Mae $count allwedd OpenPGP wedi’u hatodi.',
      two: 'Mae $count allwedd OpenPGP wedi’u hatodi.',
      one: 'Mae allwedd OpenPGP wedi’i hatodi.',
      zero: 'Mae $count allwedd OpenPGP wedi’u hatodi.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Mewnforio';

  @override
  String get openpgpUnlockKeyTitle => 'Datgloi allwedd OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Rhowch gyfrinymadrodd allwedd $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Mae’r cyfrinymadrodd yna’n anghywir. Rhowch gynnig arall arni.';

  @override
  String get openpgpExplainLocked => 'Mae’r neges hon wedi’i hamgryptio. Datglowch eich allwedd OpenPGP i’w darllen.';

  @override
  String get openpgpExplainNoKey =>
      'Mae’r neges hon wedi’i hamgryptio, ond nid i unrhyw allwedd OpenPGP ar y ddyfais hon. Os ydych chi’n ei darllen yn Thunderbird, mewnforiwch eich allwedd oddi yno: Gosodiadau › Amgryptio pen-i-ben.';

  @override
  String get openpgpExplainDamaged =>
      'Mae’r neges hon wedi’i hamgryptio wedi’i difrodi, felly does dim modd ei dadgryptio’n ddiogel.';

  @override
  String get openpgpExplainUnsupported =>
      'Mae’r neges hon yn defnyddio amgryptio nad yw Loupe yn gallu ei ddarllen eto.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Mae’r neges hon wedi’i hamgryptio ag S/MIME, ond nid i unrhyw dystysgrif ar y ddyfais hon. Mewnforiwch eich tystysgrif (ffeil .p12 neu .pfx) yn Gosodiadau › Amgryptio pen-i-ben.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Mae’r neges hon wedi’i hamgryptio. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Datglowch eich tystysgrif S/MIME i’w darllen.';

  @override
  String get openpgpAttachmentGone => 'Dyw’r atodiad hwn ddim ar gael bellach.';

  @override
  String get smimeEncrypted => 'Wedi’i hamgryptio (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Wedi’i hamgryptio (S/MIME) · dim tystysgrif';

  @override
  String get smimeEncryptedDamaged => 'Wedi’i hamgryptio (S/MIME) · wedi’i difrodi';

  @override
  String get smimeEncryptedUnsupported => 'Wedi’i hamgryptio (S/MIME) · heb gefnogaeth';

  @override
  String get smimeEncryptedLocked => 'Wedi’i hamgryptio (S/MIME) · ar glo';

  @override
  String get smimeUnknownSigner => 'anhysbys';

  @override
  String get smimeSignatureModified => 'Llofnod annilys: neges wedi’i newid';

  @override
  String get smimeSignatureWeak => 'Llofnod anniogel: algorithm hen ffasiwn';

  @override
  String get smimeSignatureUncheckable => 'Does dim modd gwirio’r llofnod';

  @override
  String get smimeSignedCertificateMissing => 'Wedi’i llofnodi · tystysgrif ar goll';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Wedi’i llofnodi gan $name · tystysgrif wedi’i dirymu';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Wedi’i llofnodi gan $name · ar ddyddiad arall';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Wedi’i llofnodi gan $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Wedi’i llofnodi gan $name · tystysgrif annilys';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Wedi’i llofnodi gan $name · heb ei hymddiried';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Wedi’i llofnodi gan $name · tystysgrif wedi dod i ben';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Wedi’i llofnodi gan $name · tystysgrif ddim yn ddilys eto';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Wedi’i llofnodi gan $name · tystysgrif nid ar gyfer e-bost';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Wedi’i llofnodi gan $name, nid yr anfonwr';
  }

  @override
  String get smimeCantDecrypt => 'Methu dadgryptio’r neges hon';

  @override
  String get smimeEncryptedWithSmime => 'Wedi’i hamgryptio ag S/MIME';

  @override
  String get smimeEncryption => 'Amgryptio';

  @override
  String get smimeDecryptedHere => 'Wedi’i dadgryptio ar y ddyfais hon';

  @override
  String get smimeNotDecrypted => 'Heb ei dadgryptio';

  @override
  String get smimeAuthenticated => 'wedi’i ddilysu';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ar gyfer $count tystysgrif',
      many: 'ar gyfer $count tystysgrif',
      few: 'ar gyfer $count tystysgrif',
      two: 'ar gyfer $count dystysgrif',
      one: 'ar gyfer 1 dystysgrif',
      zero: 'ar gyfer $count tystysgrif',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Llofnod';

  @override
  String get smimeIssuedBy => 'Cyhoeddwyd gan';

  @override
  String get smimeValid => 'Dilys';

  @override
  String smimeValidRange(String from, String to) {
    return '$from i $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Ôl bys SHA-256';

  @override
  String get smimeSigned => 'Llofnodwyd';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Yn gwirio dirymiad…';

  @override
  String get smimeNotRevoked => 'Heb ei dirymu';

  @override
  String get smimeRevoked => 'Wedi’i dirymu';

  @override
  String get smimeRevocationUnknown => 'Dirymiad yn anhysbys';

  @override
  String smimeRevokedSince(String date) {
    return 'Ers $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Holwyd yr awdurdod (ei restr dirymu), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Holwyd yr awdurdod (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Ymddiried yn “$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Ymddiried yn y dystysgrif hon…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Wedi’i gwirio ar y ddyfais hon gydag S/MIME, yn gydnaws ag Outlook a Thunderbird; dirymiad gyda’r awdurdod tystysgrifau.';

  @override
  String get smimeCheckedFooter =>
      'Wedi’i gwirio ar y ddyfais hon gydag S/MIME, yn gydnaws ag Outlook a Thunderbird. Dyw dirymiad ddim yn cael ei wirio (Gosodiadau › Amgryptio pen-i-ben).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Ymddiried yn $name ar gyfer e-bost?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Ymddiried yn nhystysgrif $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Bydd pob tystysgrif mae’r awdurdod hwn yn ei chyhoeddi’n cael ei hymddiried, fel CA eich cwmni. Cymharwch yr ôl bys gyda’i berchennog yn gyntaf:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Cymharwch yr ôl bys gyda’i berchennog yn gyntaf:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Ymddiried';

  @override
  String get smimeSummaryNoKey => 'Cafodd ei hamgryptio i dystysgrif sydd ddim ar y ddyfais hon.';

  @override
  String get smimeSummaryDamaged => 'Mae’r data wedi’i amgryptio wedi’i ddifrodi neu wedi’i newid ar y ffordd.';

  @override
  String get smimeSummaryUnsupported => 'Mae’n defnyddio algorithm nad yw Loupe yn ei gefnogi.';

  @override
  String get smimeSummaryLocked => 'Mae’ch tystysgrif S/MIME ar glo.';

  @override
  String get smimeSummaryEncrypted => 'Dim ond chi a’r derbynwyr eraill sy’n gallu ei darllen.';

  @override
  String get smimeSummaryNotSigned => 'Dyw hi ddim wedi’i llofnodi, felly dyw’r anfonwr ddim wedi’i gadarnhau.';

  @override
  String get smimeSummaryModified =>
      'Dyw’r llofnod ddim yn cyfateb: cafodd y neges ei newid ar ôl iddi gael ei llofnodi.';

  @override
  String get smimeSummaryUncheckable => 'Does dim modd gwirio’r llofnod.';

  @override
  String get smimeSummaryNoCertificate => 'Dyw tystysgrif y llofnodwr ddim yn y neges, felly does dim modd ei gwirio.';

  @override
  String get smimeSummaryRevoked =>
      'Mae’r awdurdod tystysgrifau wedi dirymu tystysgrif y llofnodwr: does dim modd ymddiried yn y llofnod.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Mae’r awdurdod tystysgrifau wedi dirymu tystysgrif y llofnodwr ($reason): does dim modd ymddiried yn y llofnod.';
  }

  @override
  String get smimeDateMismatch =>
      'Cafodd ei llofnodi fwy nag awr i ffwrdd o ddyddiad y neges: efallai mai hen neges wedi’i hanfon eto yw hi.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Mae’r llofnod yn ddilys, ac mae $issuer yn gwarantu bod y dystysgrif yn perthyn i’r anfonwr.';
  }

  @override
  String get smimeProblemInvalidChain => 'Mae’r dystysgrif neu un o’i chyhoeddwyr yn annilys.';

  @override
  String get smimeProblemUntrusted => 'Mae’r dystysgrif yn dod gan awdurdod nad yw Loupe yn ymddiried ynddo.';

  @override
  String get smimeProblemExpired => 'Roedd y dystysgrif wedi dod i ben.';

  @override
  String get smimeProblemNotYetValid => 'Doedd y dystysgrif ddim yn ddilys eto.';

  @override
  String get smimeProblemWrongUsage => 'Dyw’r dystysgrif ddim wedi’i bwriadu ar gyfer e-bost.';

  @override
  String get smimeProblemWrongAddress => 'Mae’r dystysgrif yn perthyn i gyfeiriad gwahanol i un yr anfonwr.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Dibynadwy · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Heb ei hymddiried · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Daeth i ben $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Dilys o $date';
  }

  @override
  String get smimeTrustInvalid => 'Annilys';

  @override
  String get smimeTrustNotForMail => 'Nid ar gyfer e-bost';

  @override
  String get smimeTrustAnotherAddress => 'Cyfeiriad arall';

  @override
  String get smimeMyCertificates => 'Fy nhystysgrifau S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Ar gyfer S/MIME, fel y mae Outlook a llawer o gwmnïau’n ei ddefnyddio. Mewnforiwch eich tystysgrif gyda’i hallwedd breifat (ffeil .p12 neu .pfx), wedi’i hallforio o Outlook, Windows, macOS neu Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Ar gyfer S/MIME, fel y mae Outlook a llawer o gwmnïau’n ei ddefnyddio. Mewnforiwch eich tystysgrif gyda’i hallwedd breifat (ffeil .p12 neu .pfx), wedi’i hallforio o Outlook, Windows, macOS neu Thunderbird, neu defnyddiwch un y mae’ch cwmni neu chi wedi’i gosod ar y ddyfais hon.';

  @override
  String get smimeCertificateExpired => 'wedi dod i ben';

  @override
  String smimeCertificateUntil(String date) {
    return 'tan $date';
  }

  @override
  String get smimeCertificateOnDevice => 'ar y ddyfais hon';

  @override
  String get smimeImportCertificateEllipsis => 'Mewnforio tystysgrif…';

  @override
  String get smimeUseDeviceCertificate => 'Defnyddio tystysgrif o’r ddyfais hon…';

  @override
  String get smimeCorrespondentsCertificates => 'Tystysgrifau gohebwyr';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Wedi’u casglu o e-bost wedi’i lofnodi, fel mae Outlook a Thunderbird yn ei wneud. Dim ond i dystysgrifau dibynadwy y caiff e-bost ei amgryptio: mae Loupe yn ymddiried yn yr awdurdodau mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost, a’r rhai rydych chi’n eu hychwanegu.';

  @override
  String get smimeRevocation => 'Dirymu';

  @override
  String get smimeRevocationFooter =>
      'Pan fyddwch chi’n agor e-bost wedi’i lofnodi, mae Loupe yn gofyn i’r awdurdod a gyhoeddodd dystysgrif y llofnodwr a yw wedi’i dirymu (drwy ei ymatebydd OCSP, neu ei restr dirymu). Gall yr awdurdod wedyn weld pryd mae rhywun yn eich cyfeiriad rhyngrwyd yn darllen e-bost wedi’i lofnodi â’r dystysgrif honno. Caiff atebion eu cadw ar y ddyfais hon nes iddyn nhw ddod i ben. Mae tystysgrif wedi’i dirymu’n ymddangos fel “Wedi’i dirymu” ym mhennyn y neges.';

  @override
  String get smimeCheckRevocation => 'Gwirio dirymu tystysgrifau ar-lein';

  @override
  String get smimeTrustedAuthorities => 'Awdurdodau dibynadwy';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost.',
      many:
          'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost.',
      few:
          'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost.',
      two:
          'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost.',
      one: 'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddo ar gyfer e-bost.',
      zero:
          'Rydych chi’n ymddiried ynddyn nhw, yn ogystal â’r $count mae Mozilla yn ymddiried ynddyn nhw ar gyfer e-bost.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Awdurdod tystysgrifau';

  @override
  String get smimeImportACertificate => 'Mewnforio tystysgrif';

  @override
  String get smimeImportContactMessage =>
      'Tystysgrif gohebydd (.cer, .crt, .pem) neu dystysgrif awdurdod tystysgrifau.';

  @override
  String get smimeFromClipboard => 'O’r clipfwrdd';

  @override
  String get smimeFromFile => 'O ffeil';

  @override
  String get smimeClipboardEmpty => 'Mae’r clipfwrdd yn wag. Copïwch y dystysgrif yn gyntaf.';

  @override
  String get smimeCertificate => 'Tystysgrif';

  @override
  String get smimeOnDeviceFooter =>
      'Mae ei hallwedd breifat yn aros yn storfa manylion adnabod Android, lle gwnaeth eich cwmni neu chi ei gosod: mae Loupe yn gofyn i Android lofnodi a dadgryptio gyda hi. Mae e-bost wedi’i lofnodi’n cael ei lofnodi pan fyddwch chi’n ei anfon.';

  @override
  String get smimeAddresses => 'Cyfeiriadau';

  @override
  String get smimeUsage => 'Ar gyfer';

  @override
  String get smimeUsageNone => 'Dim byd mae Loupe yn ei ddefnyddio';

  @override
  String get smimeUsageSigning => 'Llofnodi';

  @override
  String get smimeUsageEncryption => 'Amgryptio';

  @override
  String get smimeUsageCertificates => 'Tystysgrifau';

  @override
  String get smimeAlgorithm => 'Algorithm';

  @override
  String get smimeSerialNumber => 'Rhif cyfresol';

  @override
  String get smimeFingerprintCopied => 'Ôl bys wedi’i gopïo.';

  @override
  String get smimeSha1Thumbprint => 'Ôl bawd SHA-1';

  @override
  String get smimePrivateKey => 'Allwedd breifat';

  @override
  String get smimeKeyOnDevice => 'Ar y ddyfais hon';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Yn Loupe, gyda chyfrinymadrodd';

  @override
  String get smimeKeyInLoupe => 'Yn Loupe';

  @override
  String get smimeSource => 'O';

  @override
  String get smimeSourceSignedMail => 'E-bost wedi’i lofnodi';

  @override
  String get smimeSourceImported => 'Wedi’i mewnforio';

  @override
  String get smimeTrustHeader => 'Ymddiriedaeth';

  @override
  String get smimeTrustedRoot => 'Gwraidd dibynadwy';

  @override
  String get smimeIssuer => 'Cyhoeddwr';

  @override
  String smimeTrustNamed(String name) {
    return 'Ymddiried yn “$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Ymddiried yn yr awdurdod hwn';

  @override
  String get smimeTrustThisCertificate => 'Ymddiried yn y dystysgrif hon';

  @override
  String get smimeStopTrusting => 'Peidio ag ymddiried';

  @override
  String get smimePassphrase => 'Cyfrinymadrodd';

  @override
  String get smimePassphraseFooter =>
      'Dewisol. Gyda chyfrinymadrodd, mae’r allwedd breifat hefyd wedi’i hamgryptio ar y ddyfais hon (Argon2id ac AES-256), ac mae Loupe yn gofyn amdano i lofnodi a dadgryptio; mae Cofio cyfrinymadroddion yn dweud am ba hyd. Mae e-bost rydych chi’n ei anfon yn cael ei lofnodi wrth i chi ei anfon; does dim modd i waith yn y cefndir ddefnyddio’r allwedd.';

  @override
  String get smimeChangePassphrase => 'Newid cyfrinymadrodd…';

  @override
  String get smimeSetPassphraseEllipsis => 'Gosod cyfrinymadrodd…';

  @override
  String get smimeRemovePassphrase => 'Tynnu’r cyfrinymadrodd';

  @override
  String get smimeShareCertificate => 'Rhannu’r dystysgrif';

  @override
  String get smimeDeleteCertificate => 'Dileu’r dystysgrif';

  @override
  String get smimeRemoveCertificate => 'Tynnu’r dystysgrif';

  @override
  String get smimePassphraseChanged => 'Cyfrinymadrodd wedi’i newid.';

  @override
  String get smimePassphraseSet => 'Cyfrinymadrodd wedi’i osod.';

  @override
  String get smimeRemovePassphraseTitle => 'Tynnu’r cyfrinymadrodd?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Bydd yr allwedd breifat wedyn yn cael ei diogelu gan y gadwyn allweddi’n unig, fel heb gyfrinymadrodd: fydd Loupe ddim yn gofyn amdano mwyach, a gall gwaith yn y cefndir ei defnyddio.';

  @override
  String get smimePassphraseRemoved => 'Cyfrinymadrodd wedi’i dynnu.';

  @override
  String smimeTrustTitle(String name) {
    return 'Ymddiried yn $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Bydd pob tystysgrif mae’n ei chyhoeddi’n cael ei hymddiried ar gyfer e-bost. Cymharwch yr ôl bys gyda’i berchennog yn gyntaf:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Dileu eich tystysgrif $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Tynnu tystysgrif $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Bydd Loupe yn peidio â’i defnyddio: fydd dim modd darllen e-bost wedi’i amgryptio iddi yn Loupe mwyach. Mae’r dystysgrif yn aros ar y ddyfais hon (Gosodiadau › Diogelwch › Amgryptio a manylion adnabod).';

  @override
  String get smimeDeleteOwnMessage =>
      'Mae ei hallwedd breifat yn cael ei dileu o’r ddyfais hon: fydd dim modd darllen e-bost wedi’i amgryptio iddi yma mwyach, oni bai eich bod chi’n ei mewnforio eto.';

  @override
  String get smimeRemoveContactMessage => 'Bydd yn dod yn ôl gyda’u neges nesaf wedi’i llofnodi.';

  @override
  String get smimeAddressImportFooter =>
      'Mewnforiwch dystysgrif ar gyfer y cyfeiriad hwn i lofnodi ac amgryptio ag S/MIME, fel mae Outlook yn ei wneud.';

  @override
  String get smimeImportACertificateEllipsis => 'Mewnforio tystysgrif…';

  @override
  String get smimePreferFooter =>
      'Pan fydd y ddau’n gallu diogelu neges, bydd yr un a ffefrir yn cael ei ddefnyddio, oni bai mai dim ond y llall sydd ag allwedd neu dystysgrif ar gyfer pob derbynnydd.';

  @override
  String get smimePreferSmime => 'Ffafrio S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Yn hytrach nag OpenPGP';

  @override
  String get smimeCertificatePassword => 'Cyfrinair y dystysgrif';

  @override
  String get smimeCertificatePasswordPrompt => 'Rhowch y cyfrinair a ddefnyddiwyd i allforio ffeil y dystysgrif.';

  @override
  String get smimeImport => 'Mewnforio';

  @override
  String get smimeWrongPassword => 'Mae’r cyfrinair yna’n anghywir. Rhowch gynnig arall arni.';

  @override
  String get smimeNoCertificateFound => 'Heb ddod o hyd i dystysgrif.';

  @override
  String smimeCertificateOf(String name) {
    return 'tystysgrif $name';
  }

  @override
  String get smimeNothingNew => 'Dim byd newydd i’w fewnforio.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Wedi mewnforio $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wedi mewnforio $count awdurdod dibynadwy.',
      many: 'Wedi mewnforio $count awdurdod dibynadwy.',
      few: 'Wedi mewnforio $count awdurdod dibynadwy.',
      two: 'Wedi mewnforio $count awdurdod dibynadwy.',
      one: 'Wedi mewnforio awdurdod dibynadwy.',
      zero: 'Wedi mewnforio $count awdurdod dibynadwy.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wedi mewnforio $certificates a $count awdurdod dibynadwy.',
      many: 'Wedi mewnforio $certificates a $count awdurdod dibynadwy.',
      few: 'Wedi mewnforio $certificates a $count awdurdod dibynadwy.',
      two: 'Wedi mewnforio $certificates a $count awdurdod dibynadwy.',
      one: 'Wedi mewnforio $certificates ac awdurdod dibynadwy.',
      zero: 'Wedi mewnforio $certificates a $count awdurdod dibynadwy.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Does dim allwedd breifat yn y ffeil hon. Allforiwch eich tystysgrif gyda’i hallwedd breifat.';

  @override
  String get smimeImportAsYoursTitle => 'Mewnforio fel eich tystysgrif chi?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Mae’r atodiad hwn yn cynnwys tystysgrif gyda’i hallwedd breifat: $names. Mewnforiwch hi dim ond os gwnaethoch chi ei hallforio eich hun, o Outlook neu Thunderbird er enghraifft.';
  }

  @override
  String get smimeImportAsMine => 'Mewnforio fel fy nhystysgrif';

  @override
  String smimeImportedOwn(String names) {
    return 'Wedi mewnforio eich tystysgrif $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Wedi ychwanegu eich tystysgrif $name ($addresses) o’r ddyfais hon.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Ymddiried yn “$name” ar gyfer e-bost?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Dyw Loupe ddim yn adnabod yr awdurdod tystysgrifau hwn (un cwmni ei hun, efallai). Ymddiriedwch ynddo i wirio’r tystysgrifau mae’n eu cyhoeddi. Cymharwch ei ôl bys gyda’ch adran TG yn gyntaf:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mae $count tystysgrif wedi’u hatodi.',
      many: 'Mae $count tystysgrif wedi’u hatodi.',
      few: 'Mae $count tystysgrif wedi’u hatodi.',
      two: 'Mae $count dystysgrif wedi’u hatodi.',
      one: 'Mae tystysgrif wedi’i hatodi.',
      zero: 'Mae $count tystysgrif wedi’u hatodi.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Mewnforio’r dystysgrif';

  @override
  String get smimeUnlockTitle => 'Datgloi tystysgrif S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Rhowch gyfrinymadrodd tystysgrif $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Mae’r cyfrinymadrodd yna’n anghywir. Rhowch gynnig arall arni.';

  @override
  String get smimeUnlock => 'Datgloi';

  @override
  String get smimeEnterAPassphrase => 'Rhowch gyfrinymadrodd.';

  @override
  String get smimePassphrasesDiffer => 'Mae’r ddau gyfrinymadrodd yn wahanol.';

  @override
  String get smimeSetPassphraseTitle => 'Gosod cyfrinymadrodd';

  @override
  String get smimeSetPassphraseText =>
      'Bydd Loupe yn gofyn amdano i lofnodi a dadgryptio. Os byddwch chi’n ei anghofio, mewnforiwch y dystysgrif eto o’i ffeil .p12.';

  @override
  String get smimePassphraseAgain => 'Eto';

  @override
  String get smimeSetPassphraseButton => 'Gosod';

  @override
  String get smimeLockedOpenAgain => 'Mae’ch tystysgrif S/MIME ar glo. Agorwch y neges eto i’w datgloi.';

  @override
  String get smimeDeviceHasNoCertificates => 'Dyw’r ddyfais hon ddim yn cynnig ei thystysgrifau.';

  @override
  String get smimeCantReadCertificate => 'Dyw Loupe ddim yn gallu darllen y dystysgrif hon.';

  @override
  String get smimeCertificateNotForMail =>
      'Dyw’r dystysgrif hon ddim ar gyfer e-bost: does ganddi ddim cyfeiriad e-bost, neu dyw hi ddim wedi’i bwriadu ar gyfer llofnodi nac amgryptio.';

  @override
  String get smimeDeviceCertificateGone =>
      'Dyw’r dystysgrif ddim ar y ddyfais hon bellach, neu efallai na all Loupe ei defnyddio mwyach. Dewiswch hi eto yn Gosodiadau › Amgryptio pen-i-ben.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Dim ond tra bo Loupe ar agor y gellir defnyddio’r dystysgrif ar y ddyfais hon.';

  @override
  String get smimeDeviceKeyDamaged => 'Mae’r allwedd wedi’i hamgryptio wedi’i difrodi.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Dyw’r dystysgrif ar y ddyfais hon ddim yn gallu gwneud hyn: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'dim cefnogaeth';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Methodd y dystysgrif ar y ddyfais hon: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Dyw cyfeiriad yr awdurdod ddim yn gyfeiriad gwe.';

  @override
  String get smimeAuthorityTimeout => 'Wnaeth yr awdurdod tystysgrifau ddim ateb mewn pryd.';

  @override
  String get smimeAuthorityUnreachable => 'Doedd dim modd cysylltu â’r awdurdod tystysgrifau.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Atebodd yr awdurdod tystysgrifau $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Mae ateb yr awdurdod tystysgrifau’n rhy fawr.';

  @override
  String get smimeRevocationNotChecked =>
      'Heb ei gwirio: dim ond tystysgrifau gan awdurdod mae Loupe yn ymddiried ynddo sy’n cael eu gwirio.';

  @override
  String get settingsLanguage => 'Iaith';

  @override
  String get settingsLanguageSystem => 'Yr un fath â’r ffôn';

  @override
  String get settingsLanguageFooter =>
      'Mae Loupe yn defnyddio iaith eich ffôn pan fydd hi ganddo, a Saesneg pan nad yw hi. Mae’r iaith rydych chi’n ei dewis yma ar gyfer Loupe yn unig, gan gynnwys hysbysiadau.';

  @override
  String get settingsAccountsHeader => 'Cyfrifon';

  @override
  String get settingsAddAccount => 'Ychwanegu cyfrif';

  @override
  String get settingsMailHeader => 'E-bost';

  @override
  String get settingsSwipeActions => 'Gweithredoedd sweipio';

  @override
  String get settingsSwipeLeft => 'Sweipio i’r chwith';

  @override
  String get settingsSwipeLeftFooter =>
      'Mae sweip llawn yn rhedeg y weithred hon. Mae Fflagio a Rhagor bob amser un sweip byr i ffwrdd.';

  @override
  String get settingsSwipeRight => 'Sweipio i’r dde';

  @override
  String get settingsSwipeRightFooter => 'Mae sweip llawn yn rhedeg y weithred hon.';

  @override
  String get settingsSwipeToggleRead => 'Marcio fel wedi’i darllen / heb ei darllen';

  @override
  String get settingsSwipeTrash => 'I’r sbwriel';

  @override
  String get settingsSwipeMove => 'Symud neges';

  @override
  String get settingsSwipeSnooze => 'Gohirio';

  @override
  String get settingsThreaded => 'Trefnu fesul sgwrs';

  @override
  String get settingsUndoSendDelay => 'Oedi dadwneud anfon';

  @override
  String get settingsUndoSendDelayFooter =>
      'Mae negeseuon wedi’u hanfon yn aros cyhyd â hyn, fel y gallwch chi eu tynnu’n ôl.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds eiliad',
      many: '$seconds eiliad',
      few: '$seconds eiliad',
      two: '$seconds eiliad',
      one: '1 eiliad',
      zero: '$seconds eiliad',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Golwg';

  @override
  String get settingsTheme => 'Thema';

  @override
  String get settingsThemeSystem => 'Awtomatig';

  @override
  String get settingsThemeLight => 'Golau';

  @override
  String get settingsThemeDark => 'Tywyll';

  @override
  String get settingsDensity => 'Rhestr negeseuon';

  @override
  String get settingsDensityComfortable => 'Cyfforddus';

  @override
  String get settingsDensityCompact => 'Cryno';

  @override
  String get settingsReadingHeader => 'Darllen';

  @override
  String get settingsReadingFooter => 'Gall delweddau o bell ddweud wrth anfonwyr pryd a ble agoroch chi neges.';

  @override
  String get settingsDefaultView => 'Golwg ddiofyn';

  @override
  String get settingsDefaultViewFooter => 'Gallwch chi newid unrhyw neges gyda’r botwm Aa.';

  @override
  String get settingsViewReadable => 'Darllenadwy';

  @override
  String get settingsViewReadableDetail => 'Glân, eglur, yn dilyn y modd tywyll';

  @override
  String get settingsViewOriginal => 'Gwreiddiol';

  @override
  String get settingsViewOriginalDetail => 'Yn union fel y cynlluniodd yr anfonwr hi';

  @override
  String get settingsViewPlain => 'Testun plaen';

  @override
  String get settingsViewPlainDetail => 'Y geiriau’n unig';

  @override
  String get settingsPlainTextFont => 'Ffont testun plaen';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Unlled';

  @override
  String get settingsFontMonoDetail => 'Yn cadw celf ASCII a thablau wedi’u halinio';

  @override
  String get settingsTechnicalLists => 'Rhestrau technegol';

  @override
  String get settingsLoadRemoteImages => 'Llwytho delweddau o bell';

  @override
  String get settingsOpenLinksDirectly => 'Agor dolenni’n uniongyrchol';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Hepgor tracwyr cliciau pan fo’r gyrchfan yn hysbys';

  @override
  String get settingsSecurityHeader => 'Diogelwch';

  @override
  String get settingsAppLock => 'Clo Ap';

  @override
  String get settingsAppLockFooterOn =>
      'Mae Loupe yn gofyn pan fydd yn cychwyn, a phan fyddwch chi’n dod yn ôl ar ôl bod i ffwrdd am amser Cloi ar ôl.';

  @override
  String get settingsAppLockFooterOff =>
      'Mae Clo Ap yn gofyn am eich ôl bys, eich wyneb neu’ch clo sgrin cyn i’ch e-bost ymddangos.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Mae Clo Ap yn dal i ffwrdd. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Gosod cod pas';

  @override
  String get settingsScreenLockTextIos =>
      'Mae Clo Ap yn defnyddio Face ID, Touch ID neu’ch cod pas, a does gan yr iPhone hwn ddim cod pas. Gosodwch un yn yr ap Settings, yna trowch Clo Ap ymlaen.';

  @override
  String get settingsScreenLockTitleAndroid => 'Gosod clo sgrin';

  @override
  String get settingsScreenLockTextAndroid =>
      'Mae Clo Ap yn defnyddio clo sgrin eich ffôn, neu ôl bys neu wyneb wedi’i ychwanegu ato, a does gan y ffôn hwn ddim un. Gosodwch PIN, patrwm neu gyfrinair yng ngosodiadau Android, yna trowch Clo Ap ymlaen.';

  @override
  String get settingsOpenSystemSettings => 'Agor Gosodiadau';

  @override
  String get settingsOpenAndroidSettings => 'Agor gosodiadau Android';

  @override
  String get settingsLockAfter => 'Cloi ar ôl';

  @override
  String get settingsLockAfterFooter => 'Am faint y gall Loupe fod yn y cefndir cyn gofyn eto.';

  @override
  String get settingsNotifications => 'Hysbysiadau';

  @override
  String get settingsEncryption => 'Amgryptio pen-i-ben';

  @override
  String get settingsAdvanced => 'Uwch';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Blwch post dychmygol yw’r e-bost demo, sy’n byw ar y ffôn hwn yn unig. Does dim byd yn cael ei anfon i unman.';

  @override
  String get settingsDemoMode => 'Modd demo';

  @override
  String get settingsResetApp => 'Ailosod yr ap';

  @override
  String get settingsResetFooter => 'Yn anghofio pob gosodiad ac yn mynd yn ôl i’r sgrin groeso.';

  @override
  String get settingsResetTitle => 'Ailosod Loupe?';

  @override
  String get settingsResetMessage =>
      'Bydd hyn yn anghofio pob gosodiad, pob Smart Mailbox a phob chwiliad diweddar, ac yn mynd yn ôl i’r sgrin groeso.';

  @override
  String get settingsAboutHeader => 'Ynghylch';

  @override
  String get settingsVersion => 'Fersiwn';

  @override
  String get settingsLicences => 'Trwyddedau';

  @override
  String get settingsPrivacy => 'Preifatrwydd';

  @override
  String get settingsPrivacyDetail =>
      'Does gan Loupe ddim dadansoddeg na thracio. Dim ond i’ch gweinyddion e-bost y mae’ch e-bost yn mynd.';

  @override
  String get settingsNotificationsOffIos => 'Mae hysbysiadau i ffwrdd ar gyfer Loupe yn Settings.';

  @override
  String get settingsNotificationsOffAndroid => 'Mae hysbysiadau i ffwrdd ar gyfer Loupe yng Ngosodiadau Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return 'Dyw $system ddim yn gadael i Loupe ddangos hysbysiadau. Caniatewch nhw yn y Gosodiadau.';
  }

  @override
  String get settingsNewMailHeader => 'E-bost newydd';

  @override
  String get settingsNewMailFooterDemo =>
      'Dyw e-bost demo ddim yn cyrraedd yn y cefndir. Anfonwch hysbysiad prawf i weld sut mae e-bost newydd yn edrych.';

  @override
  String get settingsNewMailFooterIos =>
      'Mae Loupe yn chwilio am e-bost newydd yn y cefndir pan fydd iOS yn caniatáu, a gall hynny fod oriau ar wahân ar gyfer apiau nad ydych chi’n eu hagor yn aml. Cewch chi wybod am negeseuon newydd yn eich mewnflychau, a gan VIPs mewn unrhyw ffolder.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Mae Loupe yn chwilio am e-bost newydd tua bob 15 munud, pan fydd Android yn caniatáu. Cewch chi wybod am negeseuon newydd yn eich mewnflychau, a gan VIPs mewn unrhyw ffolder.';

  @override
  String get settingsNoAccounts => 'Dim cyfrifon';

  @override
  String get settingsVipOnly => 'VIP yn unig';

  @override
  String get settingsVipOnlyDetail => 'Negeseuon gan eich VIPs yn unig';

  @override
  String get settingsHideContent => 'Cuddio’r cynnwys';

  @override
  String get settingsHideContentFooterOn =>
      'Dim ond “Neges newydd gan” a’r cyfrif mae hysbysiadau’n eu dweud, nid pwy ysgrifennodd na beth yw’r pwnc.';

  @override
  String get settingsHideContentFooterOff =>
      'Mae Cuddio’r cynnwys yn cadw’r anfonwr, y pwnc a’r rhagolwg oddi ar y sgrin glo ac allan o hysbysiadau.';

  @override
  String get settingsBackgroundAppRefresh => 'Adnewyddu apiau yn y cefndir';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Dim ond tra bo Adnewyddu apiau yn y cefndir ymlaen ar gyfer Loupe yn Settings y mae e-bost newydd yn cyrraedd yn y cefndir. Dyw iOS ddim yn gallu cadw cysylltiad â’ch mewnflychau ar agor, felly does dim Danfon ar unwaith.';

  @override
  String get settingsInstantDelivery => 'Danfon ar unwaith';

  @override
  String get settingsInstantDeliveryFooter =>
      'Mae Danfon ar unwaith (arbrofol) yn cadw cysylltiad â’ch mewnflychau ar agor, fel bod e-bost newydd yn cyrraedd o fewn eiliadau. Mae’n dangos hysbysiad tawel “Yn gwylio am e-bost newydd” ac yn defnyddio mwy o fatri.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Efallai y bydd Android yn atal Danfon ar unwaith i arbed batri. Gadewch i Loupe ddefnyddio’r batri heb gyfyngiadau i’w gadw i redeg.';

  @override
  String get settingsExperimental => 'Arbrofol';

  @override
  String get settingsComingSoon => 'Ar y ffordd';

  @override
  String get settingsAllowUnrestrictedBattery => 'Caniatáu defnydd batri heb gyfyngiad';

  @override
  String get settingsPush => 'Gwthio';

  @override
  String get settingsPushFooter =>
      'Mae Gwthio’n gadael i e-bost newydd ddeffro Loupe ar unwaith, lle mae’ch gwasanaeth e-bost yn ei gefnogi. Mae negeseuon gwthio’n mynd drwy wasanaeth gwthio Google a dydyn nhw ddim yn cario e-bost, dim ond “gwirio nawr”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Dyw’r ffôn hwn ddim yn gallu derbyn negeseuon gwthio: mae angen gwasanaethau Google Play a chysylltiad rhwydwaith arnyn nhw. Mae Loupe yn dal i chwilio am e-bost tua bob 15 munud.';

  @override
  String get settingsCopyPushToken => 'Copïo’r tocyn gwthio';

  @override
  String get settingsPushTokenCopied => 'Tocyn gwthio wedi’i gopïo';

  @override
  String get settingsSendTestNotification => 'Anfon hysbysiad prawf';

  @override
  String get settingsAppIconBadge => 'Bathodyn eicon yr ap';

  @override
  String get settingsBadgeNote =>
      'Mae’r bathodyn yn diweddaru pryd bynnag y bydd Loupe yn chwilio am e-bost, yn y cefndir hefyd.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Dyw sgrin gartref y ffôn hwn ddim yn dangos rhifau ar eiconau apiau. Mae’r bathodyn yn diweddaru pryd bynnag y bydd Loupe yn chwilio am e-bost, yn y cefndir hefyd.';

  @override
  String get settingsTestNotificationBody => 'Fel hyn mae hysbysiadau am e-bost newydd yn edrych.';

  @override
  String get settingsAccountRemoved => 'Mae’r cyfrif hwn wedi’i dynnu.';

  @override
  String get settingsAccountHeader => 'Cyfrif';

  @override
  String get settingsAccountDescription => 'Disgrifiad';

  @override
  String get settingsAccountDescriptionHint => 'Gwaith, Personol…';

  @override
  String get settingsEmail => 'E-bost';

  @override
  String get settingsColour => 'Lliw';

  @override
  String get settingsColourFooter => 'Yn marcio negeseuon y cyfrif hwn yn Pob Mewnflwch.';

  @override
  String settingsColourNumber(int number) {
    return 'Lliw $number';
  }

  @override
  String get settingsSendingHeader => 'Anfon';

  @override
  String get settingsSendingFooter =>
      'Mae gan bob hunaniaeth ei llofnod ei hun. Mae atebion yn mynd o’r cyfeiriad yr anfonwyd y neges ato.';

  @override
  String get settingsFoldersHeader => 'Ffolderi';

  @override
  String get settingsFoldersFooter =>
      'Mae Loupe yn dangos ac yn cysoni’r ffolderi rydych chi wedi tanysgrifio iddyn nhw, fel mae Thunderbird yn ei wneud. Mae Mewnflwch, Drafftiau, Anfonwyd, Sothach, Sbwriel ac Archif bob amser yn ymddangos.';

  @override
  String get settingsShowAllFolders => 'Dangos pob ffolder';

  @override
  String get settingsIncoming => 'Yn dod i mewn';

  @override
  String get settingsOutgoing => 'Yn mynd allan';

  @override
  String get settingsConnectionNotEncrypted => 'Heb ei amgryptio';

  @override
  String get settingsSignIn => 'Mewngofnodi';

  @override
  String get settingsSignInExpired => 'Wedi dod i ben';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return 'Dyw $provider ddim yn derbyn mewngofnodi Loupe ar gyfer y cyfrif hwn bellach, felly dyw ei e-bost ddim yn cysoni. Mewngofnodwch eto i’w drwsio.';
  }

  @override
  String get settingsSignInAgain => 'Mewngofnodi eto';

  @override
  String get settingsSigningIn => 'Yn mewngofnodi…';

  @override
  String get settingsRemoveAccount => 'Tynnu’r cyfrif';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Tynnu “$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Mae ei e-bost a’i osodiadau’n cael eu tynnu o’r ffôn hwn. Does dim byd yn cael ei ddileu ar y gweinydd.';

  @override
  String get settingsManageFolders => 'Rheoli ffolderi';

  @override
  String get settingsNoFolders => 'Dim ffolderi eto.';

  @override
  String get settingsManageFoldersFooter =>
      'Mae ffolderi rydych chi wedi tanysgrifio iddyn nhw’n ymddangos ar y sgrin Blychau post ac yn cysoni yn y cefndir. Fel arfer, mae apiau e-bost eraill ar yr un cyfrif yn dilyn y tanysgrifiadau hyn hefyd.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Yn cadw eich Smart Mailboxes ar gyfer eich dyfeisiau eraill. Wedi’i guddio ar y sgrin Blychau post.';

  @override
  String get settingsFolderAlwaysShown => 'Bob amser yn cael ei ddangos';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Tanysgrifio i $folder';
  }

  @override
  String get settingsIdentities => 'Hunaniaethau';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Yr hunaniaeth gyntaf yw’r un ddiofyn ar gyfer negeseuon newydd. Llusgwch i newid y drefn.';

  @override
  String get settingsIdentitiesFooterSingle => 'Yr hunaniaeth ddiofyn ar gyfer negeseuon newydd.';

  @override
  String get settingsIdentitiesReplyFooter => 'Mae ateb yn mynd o’r hunaniaeth yr anfonwyd y neges ati.';

  @override
  String get settingsIdentityDefault => 'Diofyn';

  @override
  String settingsIdentityReorder(String email) {
    return 'Aildrefnu $email';
  }

  @override
  String get settingsAddIdentity => 'Ychwanegu hunaniaeth';

  @override
  String get settingsNewIdentity => 'Hunaniaeth newydd';

  @override
  String get settingsIdentity => 'Hunaniaeth';

  @override
  String get settingsIdentityNameHint => 'Eich enw';

  @override
  String get settingsReplyTo => 'Ateb i';

  @override
  String get settingsSignature => 'Llofnod';

  @override
  String get settingsSignatureFooter => 'Wedi’i ychwanegu o dan “-- ” mewn negeseuon o’r hunaniaeth hon.';

  @override
  String get settingsNoSignature => 'Dim llofnod';

  @override
  String get settingsCopyToMyself => 'Copi i mi fy hun';

  @override
  String get settingsCopyToMyselfFooter => 'Wedi’i ychwanegu at bob neges o’r hunaniaeth hon.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Defnyddio ar gyfer atebion i';

  @override
  String get settingsReplyPatternsFooter =>
      'Mae atebion i negeseuon a anfonwyd i’r cyfeiriadau hyn yn mynd o’r hunaniaeth hon. Mae * yn golygu unrhyw beth: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Cyfeiriad, neu batrwm lle mae * yn golygu unrhyw beth.';

  @override
  String get settingsAddReplyPattern => 'Ychwanegu cyfeiriad neu batrwm';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Tynnu $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Patrwm annilys';

  @override
  String settingsInvalidPatternMessage(String input) {
    return 'Dyw “$input” ddim yn gyfeiriad nac yn batrwm fel *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Dim cyfeiriad';

  @override
  String get settingsIdentityNoAddressMessage => 'Rhowch y cyfeiriad e-bost i anfon ohono.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Cyfeiriad annilys';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Dyw Ateb i “$address” ddim yn gyfeiriad e-bost dilys.',
      'cc': 'Dyw Cc “$address” ddim yn gyfeiriad e-bost dilys.',
      'bcc': 'Dyw Bcc “$address” ddim yn gyfeiriad e-bost dilys.',
      'other': 'Dyw “$address” ddim yn gyfeiriad e-bost dilys.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Cadw’r hunaniaeth';

  @override
  String get settingsDiscardChanges => 'Hepgor y newidiadau';

  @override
  String get settingsDeleteIdentity => 'Dileu’r hunaniaeth';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Dileu “$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Mae negeseuon sydd eisoes wedi’u hanfon ohoni’n aros fel y maen nhw.';

  @override
  String get settingsLastIdentityFooter => 'Mae angen o leiaf un hunaniaeth ar gyfrif.';

  @override
  String get rulesTitle => 'Rheolau';

  @override
  String get rulesNewRule => 'Rheol newydd';

  @override
  String get rulesLoadError => 'Methu llwytho’r rheolau.';

  @override
  String get rulesEmptyTitle => 'Dim rheolau';

  @override
  String get rulesEmptyText =>
      'Mae rheolau’n ffeilio, tagio a fflagio e-bost newydd i chi. Crëwch un gyda’r botwm ysgrifennu uchod, neu o chwiliad gyda “Gwneud hwn yn rheol”.';

  @override
  String get rulesListFooter =>
      'Mae rheolau’n rhedeg o’r brig i’r gwaelod ar e-bost newydd yn y Mewnflwch. Cyffyrddwch a daliwch reol i’w symud.';

  @override
  String get rulesChangeError => 'Methu newid y rheol';

  @override
  String get rulesConditionEveryMessage => 'Pob neges';

  @override
  String rulesMoveRule(String rule) {
    return 'Symud $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule ymlaen';
  }

  @override
  String get rulesServerRulesHeader => 'Rheolau’r gweinydd';

  @override
  String get rulesServerRulesFooter =>
      'Mae rheolau’r gweinydd yn rhedeg ar y gweinydd e-bost wrth i e-bost gyrraedd, hyd yn oed tra bo’r ffôn hwn wedi’i ddiffodd. Maen nhw’n cael eu cadw mewn sgript Sieve o’r enw “loupe”.';

  @override
  String get rulesStatusUnknown => 'Anhysbys';

  @override
  String get rulesStatusError => 'Methu holi’r gweinydd.';

  @override
  String get rulesStatusChecking => 'Yn gwirio…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Yn rhedeg o “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” yw’r sgript weithredol. Tapiwch i adael iddi redeg rheolau Loupe hefyd.';
  }

  @override
  String get rulesStatusNoScript =>
      'Does dim sgript yn weithredol ar y gweinydd. Mae cadw rheol gweinydd yn troi sgript Loupe ymlaen.';

  @override
  String get rulesStatusUnavailable => 'Ddim ar gael';

  @override
  String get rulesStatusNoSieve => 'Dyw gweinydd y cyfrif hwn ddim yn cynnig Sieve (ManageSieve na JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Symud i $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Symud i ffolder';

  @override
  String rulesActionTag(String tag) {
    return 'Tagio $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Tynnu’r tag $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Cadw yn y Mewnflwch';

  @override
  String rulesActionForward(String address) {
    return 'Anfon ymlaen at $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Anfon ymlaen at $address, heb gadw copi';
  }

  @override
  String get rulesActionStop => 'Stopio';

  @override
  String get rulesNoActions => 'Dyw’n gwneud dim byd eto';

  @override
  String get rulesLocationDevice => 'Dyfais';

  @override
  String get rulesLocationServer => 'Gweinydd';

  @override
  String get rulesLocationThisDevice => 'Y ddyfais hon';

  @override
  String get rulesNewRuleTitle => 'Rheol newydd';

  @override
  String get rulesEditRuleTitle => 'Golygu rheol';

  @override
  String get rulesDefaultNameEveryMessage => 'Pob neges';

  @override
  String get rulesConditionHeader => 'Pan fydd neges newydd yn cyfateb';

  @override
  String get rulesConditionFooter =>
      'Ysgrifennwch hi fel y byddech chi’n chwilio: from:, to:, s: (pwnc), b: (corff), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:anfoneb';

  @override
  String get rulesAccounts => 'Cyfrifon';

  @override
  String get rulesAllAccounts => 'Pob cyfrif';

  @override
  String get rulesRemovedAccount => 'Cyfrif wedi’i dynnu';

  @override
  String get rulesAccountsFooter =>
      'Mae rheol ar gyfer pob cyfrif hefyd yn cynnwys cyfrifon rydych chi’n eu hychwanegu’n nes ymlaen.';

  @override
  String get rulesActionsHeader => 'Yna';

  @override
  String get rulesForwardingFooter =>
      'Mae anfon ymlaen yn anfon pob neges sy’n cyfateb i gyfeiriad arall wrth iddi gyrraedd, hyd yn oed tra bo’r ffôn hwn wedi’i ddiffodd. Mae rhai darparwyr yn cyfyngu ar faint o e-bost y gellir ei anfon ymlaen.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Dim ond mewn rheolau gweinydd mae anfon ymlaen yn rhedeg, felly mae wedi’i adael allan yma.';

  @override
  String rulesRemoveAction(String action) {
    return 'Tynnu $action';
  }

  @override
  String get rulesAddAction => 'Ychwanegu gweithred';

  @override
  String get rulesAddMove => 'Symud i ffolder…';

  @override
  String get rulesAddTagMenu => 'Ychwanegu tag…';

  @override
  String get rulesRemoveTagMenu => 'Tynnu tag…';

  @override
  String get rulesAddForward => 'Anfon ymlaen at…';

  @override
  String get rulesStopProcessing => 'Peidio â phrosesu rhagor o reolau';

  @override
  String get rulesRunOnHeader => 'Rhedeg ar';

  @override
  String get rulesRunOnDeviceFooter =>
      'Mae’r ddyfais hon yn rhedeg y rheol ar e-bost newydd yn y Mewnflwch bob tro mae Loupe yn chwilio am e-bost.';

  @override
  String get rulesRunOnServerFooter =>
      'Mae’r gweinydd e-bost yn rhedeg y rheol wrth i e-bost gyrraedd, hyd yn oed tra bo’r ffôn hwn wedi’i ddiffodd. Angen Sieve, dros ManageSieve (Dovecot, mailcow) neu JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Rhoi ar waith ar negeseuon presennol…';

  @override
  String get rulesDeleteRule => 'Dileu’r rheol';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Dileu “$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Ffolder ym mha gyfrif?';

  @override
  String get rulesMoveAccountMessage => 'Mae e-bost y cyfrifon eraill yn mynd i’r ffolder gyda’r un enw yno.';

  @override
  String get rulesAddTag => 'Ychwanegu tag';

  @override
  String get rulesRemoveTag => 'Tynnu tag';

  @override
  String get rulesForwardTo => 'Anfon ymlaen at';

  @override
  String get rulesForwardToMessage =>
      'Mae’r gweinydd yn anfon pob neges sy’n cyfateb ymlaen i’r cyfeiriad hwn, hyd yn oed tra bo’r ffôn hwn wedi’i ddiffodd. Defnyddiwch gyfeiriad sy’n perthyn i chi neu rydych chi’n ymddiried ynddo.';

  @override
  String get rulesNotAnAddressTitle => 'Nid cyfeiriad e-bost';

  @override
  String rulesNotAnAddressMessage(String address) {
    return 'Dyw “$address” ddim yn gyfeiriad i anfon ymlaen ato.';
  }

  @override
  String get rulesKeepCopyTitle => 'Cadw copi yma?';

  @override
  String get rulesKeepCopy => 'Cadw copi';

  @override
  String get rulesDontKeepCopy => 'Peidio â chadw copi';

  @override
  String get rulesCheckCondition => 'Gwiriwch yr amod';

  @override
  String get rulesChooseActionTitle => 'Dewiswch weithred';

  @override
  String get rulesChooseActionMessage => 'Ychwanegwch beth mae’r rheol yn ei wneud gyda’r negeseuon sy’n cyfateb iddi.';

  @override
  String get rulesSaveError => 'Methu cadw’r rheol';

  @override
  String get rulesSaveServerError => 'Methu cadw rheol y gweinydd';

  @override
  String get rulesRunOnDeviceInstead => 'Rhedeg ar y ddyfais hon yn lle hynny';

  @override
  String get rulesNothingToApplyTitle => 'Dim byd i’w roi ar waith';

  @override
  String get rulesNothingToApplyMessage => 'Rhowch amod sy’n gweithio a gweithred i’r rheol yn gyntaf.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Rhoi “$rule” ar waith ar negeseuon yn…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Mewnflychau';

  @override
  String get rulesApplyScopeAll => 'Pob blwch post';

  @override
  String get rulesFindingMessages => 'Yn chwilio am negeseuon…';

  @override
  String get rulesSearchError => 'Methu chwilio';

  @override
  String get rulesSearchErrorUnknown => 'Aeth rhywbeth o’i le.';

  @override
  String get rulesNoMatchesTitle => 'Dim negeseuon yn cyfateb';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Does dim byd yno’n cyfateb i “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rhoi “$rule” ar waith ar $countString neges?',
      many: 'Rhoi “$rule” ar waith ar $countString neges?',
      few: 'Rhoi “$rule” ar waith ar $countString neges?',
      two: 'Rhoi “$rule” ar waith ar $countString neges?',
      one: 'Rhoi “$rule” ar waith ar $countString neges?',
      zero: 'Rhoi “$rule” ar waith ar $countString neges?',
    );
    return '$_temp0';
  }

  @override
  String rulesApplyConfirm(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rhoi ar waith ar $countString neges',
      many: 'Rhoi ar waith ar $countString neges',
      few: 'Rhoi ar waith ar $countString neges',
      two: 'Rhoi ar waith ar $countString neges',
      one: 'Rhoi ar waith ar $countString neges',
      zero: 'Rhoi ar waith ar $countString neges',
    );
    return '$_temp0';
  }

  @override
  String rulesApplied(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rhoddwyd “$rule” ar waith ar $countString neges',
      many: 'Rhoddwyd “$rule” ar waith ar $countString neges',
      few: 'Rhoddwyd “$rule” ar waith ar $countString neges',
      two: 'Rhoddwyd “$rule” ar waith ar $countString neges',
      one: 'Rhoddwyd “$rule” ar waith ar $countString neges',
      zero: 'Rhoddwyd “$rule” ar waith ar $countString neges',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Yn holi’r gweinydd beth mae’n gallu ei wneud…';

  @override
  String get rulesServerUnreachable => 'Methu cysylltu â’r gweinydd.';

  @override
  String rulesServerProblem(String problem) {
    return 'Methu rhedeg ar y gweinydd: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Methu rhedeg ar weinydd $account: $problem';
  }

  @override
  String get rulesShowScript => 'Dangos y sgript';

  @override
  String get rulesHideScript => 'Cuddio’r sgript';

  @override
  String get rulesMatchingHeader => 'Negeseuon sy’n cyfateb';

  @override
  String get rulesMatchingHeaderLoading => 'Negeseuon sy’n cyfateb…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString neges sy’n cyfateb',
      many: '$countString neges sy’n cyfateb',
      few: '$countString neges sy’n cyfateb',
      two: '$countString neges sy’n cyfateb',
      one: '$countString neges sy’n cyfateb',
      zero: '$countString neges sy’n cyfateb',
    );
    return '$_temp0';
  }

  @override
  String rulesMatchingCountMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString+ neges sy’n cyfateb',
      many: '$countString+ neges sy’n cyfateb',
      few: '$countString+ neges sy’n cyfateb',
      two: '$countString+ neges sy’n cyfateb',
      one: '$countString+ neges sy’n cyfateb',
      zero: '$countString+ neges sy’n cyfateb',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'O’r 30 diwrnod diwethaf. Dim ond ar e-bost newydd mae’r rheol ei hun yn gweithredu, oni bai eich bod chi’n ei rhoi ar waith ar negeseuon presennol.';

  @override
  String rulesConditionError(String error) {
    return 'Mae gwall yn yr amod: $error';
  }

  @override
  String get rulesPreviewNoSender => '(dim anfonwr)';

  @override
  String get rulesPreviewNoSubject => '(dim pwnc)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'a $countString arall',
      many: 'a $countString arall',
      few: 'a $countString arall',
      two: 'a $countString arall',
      one: 'a $countString arall',
      zero: 'a $countString arall',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Dim byd o’r 30 diwrnod diwethaf.';

  @override
  String get rulesIncludeTitle => 'Troi rheolau’r gweinydd ymlaen';

  @override
  String get rulesIncludeLeaveOff => 'Gadael i ffwrdd';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Mae’r gweinydd eisoes yn rhedeg rheolau Loupe ar gyfer $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” yw’r sgript weithredol ar weinydd $account, felly mae’r gweinydd yn ei rhedeg hi ac nid rheolau Loupe. Fydd Loupe ddim yn ei disodli. Gall ychwanegu’r llinellau hyn ati, ac yna bydd y gweinydd yn rhedeg rheolau Loupe ar ôl rheolau’r sgript ei hun:';
  }

  @override
  String get rulesShowWholeScript => 'Dangos y sgript gyfan';

  @override
  String get rulesHideWholeScript => 'Cuddio’r sgript gyfan';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Does dim byd arall yn “$script” yn newid. Os caiff ei hidlwyr eu golygu yn yr e-bost gwe yn nes ymlaen, efallai y bydd yr e-bost gwe’n ei hailysgrifennu heb y llinellau hyn; bydd Loupe wedyn yn dangos rheolau’r gweinydd fel rhai i ffwrdd eto.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Ychwanegu at “$script”';
  }

  @override
  String get subscriptionsTitle => 'Tanysgrifiadau';

  @override
  String get subscriptionsNewsletters => 'Cylchlythyrau';

  @override
  String get subscriptionsDiscussions => 'Trafodaethau';

  @override
  String get subscriptionsFilter => 'Hidlo';

  @override
  String get subscriptionsFilterNeverRead => 'Byth yn cael eu darllen';

  @override
  String get subscriptionsFilterRarelyRead => 'Anaml yn cael eu darllen';

  @override
  String get subscriptionsFilterAll => 'Y cyfan';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Methu cyfrif tanysgrifiadau';

  @override
  String get subscriptionsNoMatches => 'Dim yn cyfateb';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Does dim cylchlythyr o’r enw “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Does dim rhestr o’r enw “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Dim cylchlythyrau';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Mae cylchlythyrau a phost swmp arall yn ymddangos yma unwaith maen nhw’n cyrraedd.';

  @override
  String get subscriptionsNothingNeverRead => 'Dim byd heb ei ddarllen erioed';

  @override
  String get subscriptionsNothingRarelyRead => 'Dim byd sy’n cael ei ddarllen yn anaml';

  @override
  String get subscriptionsNothingFilteredDetail => 'Rydych chi’n darllen rhywfaint o bopeth rydych chi’n ei gael.';

  @override
  String get subscriptionsNoDiscussions => 'Dim trafodaethau';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mae rhestrau e-bost y gallwch chi ysgrifennu atyn nhw’n ymddangos yma unwaith mae eu he-bost yn cyrraedd.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Rhestrau mae sawl person yn ysgrifennu atyn nhw. Cyffyrddwch a daliwch un i’w phinio i Blychau post, ei darllen fel testun plaen, neu ei symud i Cylchlythyrau.';

  @override
  String get subscriptionsPrivacyNote =>
      'Wedi’i gyfrif ar y ffôn hwn o’r e-bost mae wedi’i lwytho i lawr; does dim byd yn cael ei anfon i unman i gyfrifo hyn. Dim ond pan fyddwch chi’n tapio Dad-danysgrifio y mae Loupe yn cysylltu ag anfonwr: mae un clic yn anfon dim ond “List-Unsubscribe=One-Click” i’r cyfeiriad a roddodd yr anfonwr, heb gwcis na dim byd arall amdanoch chi, a dyw byth yn llwytho ei dudalennau na’i ddelweddau.';

  @override
  String get subscriptionsVolumeNone => 'Dim yn ddiweddar';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mis';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mis';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'wedi darllen $percent';
  }

  @override
  String get subscriptionsStillSending => 'Yn dal i anfon';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Wedi dad-danysgrifio ar $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Tudalen dad-danysgrifio wedi’i hagor $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Un tap · yn cysylltu â $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Drwy e-bost at $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Ar y wefan $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Dad-danysgrifio';

  @override
  String get subscriptionsUnsubscribeAgain => 'Dad-danysgrifio eto';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archifo $countString yn y Mewnflwch',
      many: 'Archifo $countString yn y Mewnflwch',
      few: 'Archifo $countString yn y Mewnflwch',
      two: 'Archifo $countString yn y Mewnflwch',
      one: 'Archifo $countString yn y Mewnflwch',
      zero: 'Archifo $countString yn y Mewnflwch',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Creu rheol…';

  @override
  String get subscriptionsCreateRuleDetail => 'Symud neu archifo ei e-bost yn y dyfodol';

  @override
  String get subscriptionsTreatAsDiscussion => 'Trin fel trafodaeth';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Rhestr mae pobl yn ysgrifennu ati: darllenwch hi fel fforwm';

  @override
  String get subscriptionsTreatAsNewsletter => 'Trin fel cylchlythyr';

  @override
  String get subscriptionsBlockSender => 'Rhwystro’r anfonwr';

  @override
  String get subscriptionsBlock => 'Rhwystro';

  @override
  String get subscriptionsBlocked => 'Wedi’i rwystro';

  @override
  String get subscriptionsBlockedDetail => 'Mae e-bost newydd yn mynd i Sothach';

  @override
  String get subscriptionsPin => 'Pinio i Blychau post';

  @override
  String get subscriptionsUnpin => 'Dadbinio o Blychau post';

  @override
  String get subscriptionsOpenDefaultView => 'Agor yn y golwg ddiofyn';

  @override
  String get subscriptionsOpenPlainText => 'Agor fel testun plaen (unlled)';

  @override
  String get subscriptionsPinned => 'Wedi’i phinio';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString heb eu darllen',
      many: '$countString heb eu darllen',
      few: '$countString heb eu darllen',
      two: '$countString heb eu darllen',
      one: '$countString heb ei darllen',
      zero: '$countString heb eu darllen',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Dim e-bost gan yr anfonwr hwn nawr.';

  @override
  String get subscriptionsLatestMessages => 'NEGESEUON DIWEDDARAF';

  @override
  String get subscriptionsMail => 'E-bost';

  @override
  String get subscriptionsNoneIn90Days => 'Dim mewn 90 diwrnod';

  @override
  String get subscriptionsRead => 'Wedi’u darllen';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString o $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Derbyniwyd ddiwethaf';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ffolderi',
      many: 'Ffolderi',
      few: 'Ffolderi',
      two: 'Ffolderi',
      one: 'Ffolder',
      zero: 'Ffolderi',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Yn dal i anfon';

  @override
  String get subscriptionsUnsubscribedTitle => 'Wedi dad-danysgrifio';

  @override
  String subscriptionsSince(String date) {
    return 'ers $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'tudalen wedi’i hagor $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return 'Dyw $sender ddim yn dweud sut i ddad-danysgrifio.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return 'Dyw $sender ddim yn dweud sut i ddad-danysgrifio. Gallwch chi ei rwystro yn lle hynny.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Yn dad-danysgrifio o $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Wedi dad-danysgrifio o $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Methu dad-danysgrifio: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Methu dad-danysgrifio’n awtomatig';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Anfon e-bost dad-danysgrifio';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Agor $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Agor $site?';
  }

  @override
  String get subscriptionsOpen => 'Agor';

  @override
  String subscriptionsWebExplanation(String sender) {
    return 'Mae $sender yn dad-danysgrifio ar ei wefan. Mae’r dudalen yn agor ym mhorwr Loupe; gorffennwch yno.';
  }

  @override
  String get subscriptionsWebInsecure => 'Dyw’r cysylltiad â’r wefan hon ddim wedi’i amgryptio.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Gofal: mae’r cyfeiriad hwn yn dynwared $site gyda llythrennau tebyg.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Gofal: mae’r cyfeiriad hwn yn dynwared gwefan arall gyda llythrennau tebyg.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Methu agor $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Mae Loupe yn nodi dyddiad heddiw ac yn rhoi gwybod i chi os bydd $sender yn dal i ysgrifennu.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Dad-danysgrifio o $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Bydd Loupe yn cysylltu â $site i ddad-danysgrifio.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Dyma’r unig dro mae Loupe yn cysylltu â gwefan anfonwr. Mae’n anfon dim ond “List-Unsubscribe=One-Click” i’r cyfeiriad a roddodd $sender, heb gwcis na dim byd arall amdanoch chi, a dyw ddim yn llwytho’r dudalen.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Dyw’r ddolen dad-danysgrifio ddim yn gyfeiriad diogel ar y rhyngrwyd.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Wnaeth $site ddim ateb mewn pryd.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Methu cysylltu â $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Anfonodd $site y cais ymlaen i dudalen arall, a dyw Loupe ddim yn dilyn hynny.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Gwrthododd $site y cais (gwall $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Does dim cyfrif i anfon yr e-bost dad-danysgrifio ohono.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Bydd Loupe yn anfon e-bost at $to o $from, gyda’r pwnc “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-bost dad-danysgrifio wedi’i anfon at $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Rhwystro $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Mae e-bost newydd o’r rhestr hon yn mynd i Sothach. Gallwch chi newid hyn yn Gosodiadau › Rheolau.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Mae e-bost newydd gan $address yn mynd i Sothach. Gallwch chi newid hyn yn Gosodiadau › Rheolau.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Wedi rhwystro $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symud $count i Sothach',
      many: 'Symud $count i Sothach',
      few: 'Symud $count i Sothach',
      two: 'Symud $count i Sothach',
      one: 'Symud $count i Sothach',
      zero: 'Symud $count i Sothach',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Rhwystro $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return 'Mae $sender yn Cylchlythyrau nawr.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return 'Mae $sender yn Trafodaethau nawr.';
  }

  @override
  String get appLiveGateTitle => 'Methu agor eich cyfrifon';

  @override
  String get appLiveGateUnavailableBuild => 'Dyw cyfrifon go iawn ddim ar gael yn yr adeiliad hwn eto.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Doedd Loupe ddim yn gallu darllen yr allwedd sy’n diogelu’ch e-bost ar y ffôn hwn. Mae hyn yn aml dros dro: rhowch gynnig arall arni, neu ailgychwynnwch y ffôn.';

  @override
  String get appLiveGateKeyMissing =>
      'Mae’r allwedd sy’n diogelu’ch e-bost ar y ffôn hwn wedi mynd, a gall hynny ddigwydd ar ôl adfer copi wrth gefn. Mae’ch e-bost yn dal ar y gweinydd.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Does dim modd darllen y gronfa ddata e-bost ar y ffôn hwn: mae wedi’i difrodi, neu mae ei hallwedd wedi newid. Mae’ch e-bost yn dal ar y gweinydd.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Aeth rhywbeth o’i le wrth agor eich cyfrifon ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Mae hyn yn dileu eich cyfrifon a’r e-bost sydd wedi’i storio ar y ffôn hwn, gan gynnwys negeseuon sy’n aros yn yr Allflwch. Dyw e-bost ar eich gweinyddion ddim yn cael ei effeithio; ychwanegwch eich cyfrifon eto wedyn.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Dileu a dechrau eto';

  @override
  String get appLiveGateUseDemo => 'Defnyddio e-bost demo';

  @override
  String get appLiveGateReset => 'Ailosod e-bost ar y ffôn hwn…';

  @override
  String get attachmentsUntitled => 'Atodiad';

  @override
  String get attachmentsUntitledFile => 'Dideitl';

  @override
  String get attachmentsOpenIn => 'Agor yn…';

  @override
  String get attachmentsSaveToFiles => 'Cadw i Ffeiliau';

  @override
  String get attachmentsShareMenu => 'Rhannu…';

  @override
  String get attachmentsDownloadError =>
      'Methu llwytho’r atodiad i lawr. Gwiriwch y cysylltiad a rhowch gynnig arall arni.';

  @override
  String get attachmentsShareError => 'Methu rhannu’r atodiad.';

  @override
  String attachmentsNoApp(String type) {
    return 'Does dim ap ar y ddyfais hon sy’n agor y ffeil hon ($type). Rhowch gynnig ar Rhannu yn lle hynny.';
  }

  @override
  String get attachmentsOpenInError => 'Methu agor yr atodiad mewn ap arall.';

  @override
  String attachmentsSaved(String name) {
    return 'Wedi cadw “$name”';
  }

  @override
  String get attachmentsSaveError => 'Methu cadw’r atodiad.';

  @override
  String get attachmentsGone => 'Dyw’r atodiad hwn ddim ar gael bellach.';

  @override
  String get attachmentsDownloadFailed => 'Methu llwytho’r atodiad i lawr.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tudalen',
      many: '$count tudalen',
      few: '$count tudalen',
      two: '$count dudalen',
      one: '1 dudalen',
      zero: '$count tudalen',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size ar ddata symudol';
  }

  @override
  String get attachmentsLargeDownload =>
      'Mae’r atodiad hwn yn fawr. Llwythwch ef i lawr nawr, neu’n nes ymlaen ar Wi-Fi.';

  @override
  String get attachmentsDownload => 'Llwytho i lawr';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Yn llwytho $size i lawr…';
  }

  @override
  String get attachmentsDownloading => 'Yn llwytho i lawr…';

  @override
  String get attachmentsTooLarge => 'Rhy fawr i gael rhagolwg yma.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Yn dangos y $shown cyntaf o $total. Copïwch, rhannwch neu cadwch i gael y cyfan.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Does dim modd dangos y PDF hwn yma (efallai ei fod wedi’i ddiogelu â chyfrinair).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page o $count';
  }

  @override
  String get attachmentsModeTable => 'Tabl';

  @override
  String get attachmentsModeText => 'Testun';

  @override
  String get attachmentsModeMessage => 'Neges';

  @override
  String get attachmentsModeSource => 'Ffynhonnell';

  @override
  String get attachmentsDontWrap => 'Peidio â lapio llinellau';

  @override
  String get attachmentsWrap => 'Lapio llinellau';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines llinell',
      many: '$lines llinell',
      few: '$lines llinell',
      two: '$lines linell',
      one: '$lines llinell',
      zero: '$lines llinell',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copïo’r cyfan';

  @override
  String get attachmentsCopied => 'Wedi’i gopïo';

  @override
  String get attachmentsImageUnavailable => 'Does dim modd dangos y ddelwedd hon yma. Rhowch gynnig ar Agor yn….';

  @override
  String get attachmentsEmlNoSubject => '(Dim pwnc)';

  @override
  String get attachmentsEmlFrom => 'Oddi wrth';

  @override
  String get attachmentsEmlTo => 'At';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Dyddiad';

  @override
  String get attachmentsEmlNoText => 'Does dim testun yn y neges hon.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atodiadau: $names',
      many: 'Atodiadau: $names',
      few: 'Atodiadau: $names',
      two: 'Atodiadau: $names',
      one: 'Atodiad: $names',
      zero: 'Atodiadau: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Trefnydd: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A $count digwyddiad arall',
      many: 'A $count digwyddiad arall',
      few: 'A $count digwyddiad arall',
      two: 'A $count ddigwyddiad arall',
      one: 'Ac 1 digwyddiad arall',
      zero: 'A $count digwyddiad arall',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Delwedd';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Delwedd $format';
  }

  @override
  String get attachmentsTypePdf => 'Dogfen PDF';

  @override
  String get attachmentsTypeTsv => 'Gwerthoedd wedi’u gwahanu gan dabiau';

  @override
  String get attachmentsTypeCsv => 'Taenlen CSV';

  @override
  String get attachmentsTypeCalendar => 'Digwyddiad calendr';

  @override
  String get attachmentsTypeEmail => 'Neges e-bost';

  @override
  String get attachmentsTypeContact => 'Cerdyn cyswllt';

  @override
  String get attachmentsTypeLog => 'Ffeil log';

  @override
  String get attachmentsTypeText => 'Testun';

  @override
  String get attachmentsTypeZip => 'Archif ZIP';

  @override
  String get attachmentsTypeArchive => 'Archif';

  @override
  String get attachmentsTypeWord => 'Dogfen Word';

  @override
  String get attachmentsTypeExcel => 'Taenlen Excel';

  @override
  String get attachmentsTypePowerPoint => 'Cyflwyniad PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Tudalen we';

  @override
  String get attachmentsTypeVideo => 'Fideo';

  @override
  String get attachmentsTypeAudio => 'Sain';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Ffeil $extension';
  }

  @override
  String get attachmentsTypeFile => 'Ffeil';

  @override
  String get calendarUntitledEvent => 'Digwyddiad';

  @override
  String get calendarAllDay => 'Drwy’r dydd';

  @override
  String calendarYourTime(String time) {
    return '$time eich amser chi';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Ymuno: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Mae $name wedi derbyn: $details',
      'tentative': 'Mae $name wedi derbyn dros dro: $details',
      'declined': 'Mae $name wedi gwrthod: $details',
      'delegated': 'Mae $name wedi dirprwyo: $details',
      'other': 'Dyw $name ddim wedi ymateb i: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Mae $name wedi derbyn y gwahoddiad',
      'tentative': 'Mae $name wedi derbyn y gwahoddiad dros dro',
      'declined': 'Mae $name wedi gwrthod y gwahoddiad',
      'delegated': 'Mae $name wedi dirprwyo’r gwahoddiad',
      'other': 'Dyw $name ddim wedi ymateb i’r gwahoddiad',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Map';

  @override
  String get calendarJoin => 'Ymuno';

  @override
  String get calendarOnlineMeeting => 'Cyfarfod ar-lein';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Cyfarfod $provider';
  }

  @override
  String get calendarOrganizerYou => 'Chi';

  @override
  String get calendarOrganizerLabel => 'trefnydd';

  @override
  String get calendarStatusAccepted => 'Derbyniwyd';

  @override
  String get calendarStatusMaybe => 'Efallai';

  @override
  String get calendarStatusDeclined => 'Gwrthodwyd';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Derbyniodd $name',
      'tentative': 'Derbyniodd $name dros dro',
      'declined': 'Gwrthododd $name',
      'delegated': 'Dirprwyodd $name',
      'other': 'Wnaeth $name ddim ymateb',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Derbyniodd $name:',
      'tentative': 'Derbyniodd $name dros dro:',
      'declined': 'Gwrthododd $name:',
      'delegated': 'Dirprwyodd $name:',
      'other': 'Wnaeth $name ddim ymateb:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return 'Mae $name yn cynnig amser newydd';
  }

  @override
  String get calendarCounterUnknown => 'Mae mynychwr yn cynnig amser newydd';

  @override
  String get calendarDeclineCounter => 'Cadwodd y trefnydd yr amser';

  @override
  String calendarRefresh(String name) {
    return 'Mae $name yn gofyn am y fersiwn ddiweddaraf';
  }

  @override
  String get calendarRefreshUnknown => 'Mae mynychwr yn gofyn am y fersiwn ddiweddaraf';

  @override
  String get calendarCancelled => 'Wedi’i ganslo';

  @override
  String get calendarCancelledByOrganizer => 'Canslodd y trefnydd y digwyddiad hwn.';

  @override
  String get calendarCancelledLater => 'Cafodd y digwyddiad hwn ei ganslo’n nes ymlaen.';

  @override
  String get calendarOutdated => 'Wedi dyddio';

  @override
  String get calendarOutdatedDetail =>
      'Cafodd y gwahoddiad hwn ei ddiweddaru’n nes ymlaen; yr un mwy newydd sy’n cyfrif.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Lleoliad wedi’i dynnu (roedd yn $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Lleoliad wedi’i dynnu (doedd dim un)';

  @override
  String calendarLocationChanged(String location) {
    return 'Lleoliad wedi newid i $location';
  }

  @override
  String get calendarNewTitle => 'Teitl newydd';

  @override
  String get calendarRepeatChanged => 'Mae’r ailadrodd wedi newid';

  @override
  String get calendarUpdated => 'Wedi’i ddiweddaru';

  @override
  String get calendarUpdatedInvitation => 'Gwahoddiad wedi’i ddiweddaru';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Amser wedi newid o $before i $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Cylchfa amser “$zone” yn anhysbys: amseroedd fel y’u hysgrifennwyd';
  }

  @override
  String calendarNext(String when) {
    return 'Nesaf: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gwestai',
      many: '$count gwestai',
      few: '$count gwestai',
      two: '$count westai',
      one: '1 gwestai',
      zero: '$count gwestai',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wedi derbyn',
      many: '$count wedi derbyn',
      few: '$count wedi derbyn',
      two: '$count wedi derbyn',
      one: '$count wedi derbyn',
      zero: '$count wedi derbyn',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count efallai',
      many: '$count efallai',
      few: '$count efallai',
      two: '$count efallai',
      one: '$count efallai',
      zero: '$count efallai',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wedi gwrthod',
      many: '$count wedi gwrthod',
      few: '$count wedi gwrthod',
      two: '$count wedi gwrthod',
      one: '$count wedi gwrthod',
      zero: '$count wedi gwrthod',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (chi)';
  }

  @override
  String get calendarAttendeeOptional => 'dewisol';

  @override
  String get calendarAttendeeRoom => 'ystafell';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Fe dderbynioch chi fersiwn gynharach.',
      'tentative': 'Fe dderbynioch chi fersiwn gynharach dros dro.',
      'declined': 'Fe wrthodoch chi fersiwn gynharach.',
      'delegated': 'Fe ddirprwyoch chi fersiwn gynharach.',
      'other': 'Wnaethoch chi ddim ymateb i fersiwn gynharach.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Derbyn';

  @override
  String get calendarMaybe => 'Efallai';

  @override
  String get calendarDecline => 'Gwrthod';

  @override
  String get calendarCommentHint => 'Sylw i’r trefnydd (dewisol)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Mae’ch ateb yn mynd at $organizer o $address.';
  }

  @override
  String get calendarAddComment => 'Ychwanegu sylw';

  @override
  String get calendarAddToCalendar => 'Ychwanegu at y calendr';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A $count digwyddiad arall yn y ffeil',
      many: 'A $count digwyddiad arall yn y ffeil',
      few: 'A $count digwyddiad arall yn y ffeil',
      two: 'A $count ddigwyddiad arall yn y ffeil',
      one: 'Ac 1 digwyddiad arall yn y ffeil',
      zero: 'A $count digwyddiad arall yn y ffeil',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Does dim ap calendr i ychwanegu’r digwyddiad ato.';

  @override
  String get calendarCantOpenCalendar => 'Methu agor y calendr.';

  @override
  String get calendarCantOpenLink => 'Methu agor y ddolen.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Ymuno â chyfarfod $provider?';
  }

  @override
  String get calendarJoinTitle => 'Ymuno â’r cyfarfod?';

  @override
  String calendarJoinOpens(String host) {
    return 'Yn agor $host yn eich porwr.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Gofal: mae’r cyfeiriad hwn yn dynwared $site gyda llythrennau tebyg.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Gofal: mae’r cyfeiriad hwn yn dynwared gwefan arall gyda llythrennau tebyg.';

  @override
  String calendarJoinOpen(String host) {
    return 'Agor $host';
  }

  @override
  String get calendarNoOrganizer => 'Does gan y gwahoddiad hwn ddim trefnydd i’w ateb.';

  @override
  String get calendarNoAccount => 'Does dim cyfrif i ateb ohono.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Derbyniwyd',
      'tentative': 'Efallai',
      'other': 'Gwrthodwyd',
    });
    return '$_temp0 · yn anfon ateb at $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Derbyniwyd',
      'tentative': 'Efallai',
      'other': 'Gwrthodwyd',
    });
    return '$_temp0 · ateb wedi’i anfon';
  }

  @override
  String get calendarReplyAlreadySent => 'Mae’r ateb eisoes wedi’i anfon.';

  @override
  String get calendarReplyNotSent => 'Ateb heb ei anfon.';

  @override
  String get dataSmimeNeedsDevice =>
      'Mae’ch tystysgrif S/MIME ar y ddyfais hon: agorwch Loupe i lofnodi ac anfon y neges hon.';

  @override
  String dataSigningFailed(String error) {
    return 'Methodd y llofnodi: $error';
  }

  @override
  String get keyboardShortcuts => 'Llwybrau byr bysellfwrdd';

  @override
  String get keyboardGroupGeneral => 'Cyffredinol';

  @override
  String get keyboardGroupMessages => 'Negeseuon';

  @override
  String get keyboardGroupCompose => 'Ysgrifennu';

  @override
  String get keyboardCommandPalette => 'Palet gorchmynion';

  @override
  String get keyboardBackClose => 'Yn ôl, Cau';

  @override
  String get keyboardNextMessage => 'Neges nesaf';

  @override
  String get keyboardPreviousMessage => 'Neges flaenorol';

  @override
  String get keyboardOpenMessage => 'Agor neges';

  @override
  String get keyboardMoveToTrash => 'Symud i’r Sbwriel';

  @override
  String get keyboardToggleRead => 'Marcio fel wedi’i darllen neu heb ei darllen';

  @override
  String get keyboardToggleFlag => 'Fflagio neu ddad-fflagio';

  @override
  String get keyboardCloseDraft => 'Cau (cadw neu ddileu’r drafft)';

  @override
  String get keyboardOr => 'neu';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeyEnter => 'Enter';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get mailingListsMuted => 'Edefyn wedi’i ddistewi. Bydd negeseuon newydd ynddo’n cyrraedd wedi’u darllen.';

  @override
  String get mailingListsUnmuted => 'Edefyn wedi’i ddad-ddistewi.';

  @override
  String get mailingListsMuteThread => 'Distewi’r edefyn';

  @override
  String get mailingListsUnmuteThread => 'Dad-ddistewi’r edefyn';

  @override
  String get mailingListsPin => 'Pinio i Blychau post';

  @override
  String get mailingListsUnpin => 'Dadbinio o Blychau post';

  @override
  String get mailingListsDefaultView => 'Agor yn y golwg ddiofyn';

  @override
  String get mailingListsPlainText => 'Agor fel testun plaen (unlled)';

  @override
  String get mailingListsShowMuted => 'Dangos edafedd wedi’u distewi';

  @override
  String get mailingListsHideMuted => 'Cuddio edafedd wedi’u distewi';

  @override
  String get mailingListsTreatAsNewsletter => 'Trin fel cylchlythyr';

  @override
  String get mailingListsOptions => 'Dewisiadau’r rhestr';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted heb eu darllen',
      many: '$formatted heb eu darllen',
      few: '$formatted heb eu darllen',
      two: '$formatted heb eu darllen',
      one: '$formatted heb ei darllen',
      zero: '$formatted heb eu darllen',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Neges newydd i’r rhestr';

  @override
  String get mailingListsRowUnread => 'Heb eu darllen';

  @override
  String get mailingListsRowMuted => 'Wedi’i ddistewi';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ateb',
      many: '$count ateb',
      few: '$count ateb',
      two: '$count ateb',
      one: '1 ateb',
      zero: '$count ateb',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Dim edafedd';

  @override
  String get mailingListsMutedHidden => 'Mae edafedd wedi’u distewi wedi’u cuddio.';

  @override
  String get mailingListsTechnicalTitle => 'Rhestrau technegol';

  @override
  String get mailingListsTechnicalEmpty => 'Mae rhestrau e-bost yn ymddangos yma unwaith mae eu he-bost yn cyrraedd.';

  @override
  String get mailingListsTechnicalFooter =>
      'Mae negeseuon o’r rhestrau hyn yn agor fel testun plaen mewn ffont unlled, gyda chlytiau’n cael eu dangos fel diffs. Mae’r botwm Aa yn dal i newid unrhyw neges.';

  @override
  String get paletteMoveToMailbox => 'Symud i flwch post…';

  @override
  String get paletteMarkAllRead => 'Marcio’r cyfan fel wedi’u darllen';

  @override
  String get paletteExportFolder => 'Allforio’r ffolder…';

  @override
  String get paletteGetNewMail => 'Nôl e-bost newydd';

  @override
  String get paletteSnoozed => 'Wedi’u gohirio';

  @override
  String get paletteSubscriptions => 'Tanysgrifiadau';

  @override
  String get paletteDiscussions => 'Trafodaethau';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Rhestr e-bost';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Gweithredoedd sweipio';

  @override
  String get paletteNotifications => 'Hysbysiadau';

  @override
  String get paletteRules => 'Rheolau';

  @override
  String get paletteEncryption => 'Amgryptio pen-i-ben';

  @override
  String get paletteAdvanced => 'Uwch';

  @override
  String get paletteAddAccount => 'Ychwanegu cyfrif';

  @override
  String get paletteAccount => 'Cyfrif';

  @override
  String get paletteFolders => 'Ffolderi';

  @override
  String get paletteRecentSearch => 'Chwiliad diweddar';

  @override
  String paletteSearchMail(String query) {
    return 'Chwilio e-bost am “$query”';
  }

  @override
  String get palettePlaceholder => 'Chwilio gweithredoedd, blychau post, gosodiadau';

  @override
  String get paletteNothingFound => 'Heb ddod o hyd i ddim';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox newydd';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Yn dangos popeth sy’n cyfateb i “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Wedi cadw “$name” i Blychau post';
  }

  @override
  String get searchMakeRule => 'Gwneud hwn yn rheol';

  @override
  String get searchSaveSmartMailbox => 'Cadw fel Smart Mailbox';

  @override
  String get searchNegate => 'Negyddu';

  @override
  String get searchDontNegate => 'Peidio â negyddu';

  @override
  String get searchAllMailboxes => 'Pob blwch post';

  @override
  String get searchRecent => 'Chwiliadau diweddar';

  @override
  String get searchClear => 'Clirio';

  @override
  String get searchSuggestions => 'Awgrymiadau';

  @override
  String get searchUnreadMessages => 'Negeseuon heb eu darllen';

  @override
  String get searchFlaggedMessages => 'Negeseuon wedi’u fflagio';

  @override
  String get searchWithAttachments => 'Negeseuon gydag atodiadau';

  @override
  String get searchUnrepliedMessages => 'Negeseuon heb eu hateb';

  @override
  String get searchTags => 'Tagiau';

  @override
  String get searchPeople => 'Pobl';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Oddi wrth: $name';
  }

  @override
  String get searchSearching => 'Yn chwilio…';

  @override
  String get searchNoResults => 'Dim canlyniadau';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted canlyniad',
      many: '$formatted canlyniad',
      few: '$formatted canlyniad',
      two: '$formatted ganlyniad',
      one: '$formatted canlyniad',
      zero: '$formatted canlyniad',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Dewislen chwilio';

  @override
  String searchSearchingAccount(String account) {
    return 'Yn chwilio $account ar y gweinydd…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Yn chwilio cyfrif ar y gweinydd…';

  @override
  String searchAccountFailed(String account) {
    return 'Methu chwilio $account ar y gweinydd';
  }

  @override
  String get searchUnknownAccountFailed => 'Methu chwilio cyfrif ar y gweinydd';

  @override
  String searchChip(String term) {
    return '$term. Tapiwch ddwywaith i olygu.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nid $term. Tapiwch ddwywaith i olygu.';
  }

  @override
  String get searchReadAndUnread =>
      'Mewnflwch Schrödinger: mae pob neges yma wedi’i darllen a heb ei darllen nes i chi ei hagor.';

  @override
  String searchContradiction(String term) {
    return 'All dim neges fod yn “$term” a ddim yr un pryd.';
  }

  @override
  String get searchSyncDeviceOnly => 'Ar y ddyfais hon yn unig';

  @override
  String searchSyncUnsupported(String account) {
    return 'Ar y ddyfais hon yn unig: all $account mo’i gadw';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Heb ei gysoni: mae gan $account fformat mwy newydd';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Yn aros i gysoni â $account';
  }

  @override
  String searchSynced(String account) {
    return 'Wedi’i gysoni â $account';
  }

  @override
  String get searchRename => 'Ailenwi';

  @override
  String get searchEditSearch => 'Golygu’r chwiliad';

  @override
  String get searchDeleteSmartMailbox => 'Dileu’r Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Ailenwi’r Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Mae’r Smart Mailbox hwn wedi’i ddileu.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Mae Smart Mailboxes yn aros ar y ddyfais hon.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Mae Smart Mailboxes yn cael eu cadw ar eich gweinydd e-bost, fel bod gan eich dyfeisiau eraill nhw hefyd, a Thunderbird gydag Expression Search Reloaded. Mae’r rhai sy’n chwilio pob cyfrif yn cael eu cadw ar $account; rhai un ffolder, ar gyfrif y ffolder honno.';
  }

  @override
  String get searchSyncVia => 'Cysoni drwy';

  @override
  String get searchSyncViaFooter => 'Dewiswch yr un cyfrif ar bob dyfais.';

  @override
  String get searchGmailCantKeep => 'All Gmail ddim cadw Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Cadw Smart Mailboxes ar y ddyfais hon yn unig';

  @override
  String get searchOnTheServer => 'Ar y gweinydd';

  @override
  String get searchServerFooter =>
      'Dyw metadata’r gweinydd (IMAP METADATA) ddim yn ymddangos mewn unrhyw ap e-bost. Mae gweinyddion hebddo’n cael ffolder “Loupe Settings” sy’n cynnwys un neges; mae Loupe yn ei chuddio o Blychau post.';

  @override
  String get searchSyncNow => 'Cysoni nawr';

  @override
  String get searchStateUnsupported => 'Dim cefnogaeth';

  @override
  String get searchStateNewerFormat => 'Fformat mwy newydd';

  @override
  String get searchStateFailed => 'Methu cysoni';

  @override
  String get searchStateSyncing => 'Yn cysoni…';

  @override
  String get searchStateWaiting => 'Yn aros';

  @override
  String get searchStateMetadata => 'Metadata’r gweinydd';

  @override
  String get searchStateFolder => 'Ffolder Loupe Settings';

  @override
  String get searchStateNothing => 'Dim byd wedi’i storio';

  @override
  String get sharedBack => 'Yn ôl';

  @override
  String get sharedYesterday => 'Ddoe';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date am $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beit',
      many: '$count beit',
      few: '$count beit',
      two: '$count feit',
      one: '$count beit',
      zero: '$count beit',
    );
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size KB';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size MB';
  }

  @override
  String get sharedSyncNoAccounts => 'Dim cyfrifon';

  @override
  String get sharedSyncChecking => 'Yn chwilio am e-bost…';

  @override
  String get sharedSyncFailed => 'Methu chwilio am e-bost';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'All-lein';

  @override
  String get sharedSyncJustNow => 'Wedi’i ddiweddaru eiliad yn ôl';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Wedi’i ddiweddaru $minutes munud yn ôl',
      many: 'Wedi’i ddiweddaru $minutes munud yn ôl',
      few: 'Wedi’i ddiweddaru $minutes munud yn ôl',
      two: 'Wedi’i ddiweddaru $minutes funud yn ôl',
      one: 'Wedi’i ddiweddaru 1 munud yn ôl',
      zero: 'Wedi’i ddiweddaru $minutes munud yn ôl',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Wedi’i ddiweddaru am $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Wedi’i ddiweddaru $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Pob Mewnflwch';

  @override
  String get sharedMailboxUnread => 'Heb eu darllen';

  @override
  String get sharedMailboxFlagged => 'Wedi’u fflagio';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Pob Drafft';

  @override
  String get sharedMailboxAllSent => 'Pob Neges a Anfonwyd';

  @override
  String get sharedMailboxUntitled => 'Blwch post';

  @override
  String get sharedTagImportant => 'Pwysig';

  @override
  String get sharedTagWork => 'Gwaith';

  @override
  String get sharedTagPersonal => 'Personol';

  @override
  String get sharedTagToDo => 'I’w wneud';

  @override
  String get sharedTagLater => 'Hwyrach';

  @override
  String get sharedTags => 'Tagiau';

  @override
  String get sharedMoveTo => 'Symud i…';

  @override
  String get sharedNoRecipients => 'Dim derbynwyr';

  @override
  String get sharedUnknownSender => 'Anfonwr anhysbys';

  @override
  String get sharedOnServer => 'Ar y gweinydd';

  @override
  String get sharedAttachment => 'Atodiad';

  @override
  String get sharedSnoozedBadge => 'Wedi’i gohirio';

  @override
  String get sharedRowUnread => 'Heb ei darllen';

  @override
  String get sharedRowBackFromSnooze => 'Yn ôl o ohirio';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Wedi’i fflagio';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archifwyd $count neges',
      many: 'Archifwyd $count neges',
      few: 'Archifwyd $count neges',
      two: 'Archifwyd $count neges',
      one: 'Archifwyd 1 neges',
      zero: 'Archifwyd $count neges',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dilëwyd $count neges',
      many: 'Dilëwyd $count neges',
      few: 'Dilëwyd $count neges',
      two: 'Dilëwyd $count neges',
      one: 'Dilëwyd 1 neges',
      zero: 'Dilëwyd $count neges',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symudwyd $count neges i’r Mewnflwch',
      many: 'Symudwyd $count neges i’r Mewnflwch',
      few: 'Symudwyd $count neges i’r Mewnflwch',
      two: 'Symudwyd $count neges i’r Mewnflwch',
      one: 'Symudwyd 1 neges i’r Mewnflwch',
      zero: 'Symudwyd $count neges i’r Mewnflwch',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symudwyd $count neges i’r Sbwriel',
      many: 'Symudwyd $count neges i’r Sbwriel',
      few: 'Symudwyd $count neges i’r Sbwriel',
      two: 'Symudwyd $count neges i’r Sbwriel',
      one: 'Symudwyd 1 neges i’r Sbwriel',
      zero: 'Symudwyd $count neges i’r Sbwriel',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symudwyd $count neges i Sothach',
      many: 'Symudwyd $count neges i Sothach',
      few: 'Symudwyd $count neges i Sothach',
      two: 'Symudwyd $count neges i Sothach',
      one: 'Symudwyd 1 neges i Sothach',
      zero: 'Symudwyd $count neges i Sothach',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symudwyd $count neges i $mailbox',
      many: 'Symudwyd $count neges i $mailbox',
      few: 'Symudwyd $count neges i $mailbox',
      two: 'Symudwyd $count neges i $mailbox',
      one: 'Symudwyd 1 neges i $mailbox',
      zero: 'Symudwyd $count neges i $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Symudwyd $count neges i flwch post',
      many: 'Symudwyd $count neges i flwch post',
      few: 'Symudwyd $count neges i flwch post',
      two: 'Symudwyd $count neges i flwch post',
      one: 'Symudwyd 1 neges i flwch post',
      zero: 'Symudwyd $count neges i flwch post',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gohiriwyd $count neges tan $time',
      many: 'Gohiriwyd $count neges tan $time',
      few: 'Gohiriwyd $count neges tan $time',
      two: 'Gohiriwyd $count neges tan $time',
      one: 'Gohiriwyd 1 neges tan $time',
      zero: 'Gohiriwyd $count neges tan $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Wedi’i gohirio tan $time ar y ddyfais hon yn unig: all y gweinydd ddim storio amseroedd gohirio.';
  }

  @override
  String get sharedMoveOneAccount => 'Dewiswch negeseuon o un cyfrif i’w symud.';

  @override
  String get sharedSnoozeTitle => 'Gohirio';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Newid amser gohirio';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dileu $count neges yn barhaol?',
      many: 'Dileu $count neges yn barhaol?',
      few: 'Dileu $count neges yn barhaol?',
      two: 'Dileu $count neges yn barhaol?',
      one: 'Dileu’r neges hon yn barhaol?',
      zero: 'Dileu $count neges yn barhaol?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Does dim modd dadwneud hyn.';

  @override
  String get sharedDeletePermanently => 'Dileu’n barhaol';

  @override
  String get sharedSwipeRead => 'Darllenwyd';

  @override
  String get sharedSwipeUnread => 'Heb ddarllen';

  @override
  String get sharedSwipeInbox => 'Mewnflwch';

  @override
  String get sharedSwipeDelete => 'Dileu';

  @override
  String get sharedTrash => 'I’r sbwriel';

  @override
  String get sharedSwipeSnooze => 'Gohirio';

  @override
  String get sharedWakeNow => 'Deffro nawr';

  @override
  String get sharedChangeSnoozeTime => 'Newid amser gohirio…';

  @override
  String get sharedSnooze => 'Gohirio…';

  @override
  String get sharedTag => 'Tagio…';

  @override
  String get sharedMoveMessage => 'Symud neges…';

  @override
  String get sharedNotJunk => 'Nid sothach';

  @override
  String get accountSetupTitle => 'Ychwanegu cyfrif';

  @override
  String get accountSetupTitleDone => 'Cyfrif wedi’i ychwanegu';

  @override
  String get accountSetupAddressTitle => 'Ychwanegu cyfrif e-bost';

  @override
  String get accountSetupAddressText => 'Mae Loupe yn dod o hyd i’r gosodiadau ar gyfer y rhan fwyaf o ddarparwyr.';

  @override
  String get accountSetupNameHint => 'Eich enw';

  @override
  String get accountSetupEmail => 'E-bost';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Parhau';

  @override
  String get accountSetupLookingUp => 'Yn chwilio am osodiadau…';

  @override
  String get accountSetupImport => 'Mewnforio o Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Rhowch gyfeiriad e-bost dilys.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Methu dod o hyd i osodiadau ar gyfer $domain. Rhowch nhw isod.';
  }

  @override
  String get accountSetupCheckServers => 'Gwiriwch enwau a phyrth y gweinyddion.';

  @override
  String get accountSetupEnterPassword => 'Rhowch eich cyfrinair.';

  @override
  String get accountSetupConnecting => 'Yn cysylltu…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Yn aros am $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Methu agor y dudalen.';

  @override
  String get accountSetupCouldNotSaveName => 'Methu cadw’r enw.';

  @override
  String get accountSetupTrustCertificate => 'Ymddiried yn y dystysgrif hon';

  @override
  String get accountSetupPasswordRequired => 'Gofynnol';

  @override
  String get accountSetupShowPassword => 'Dangos y cyfrinair';

  @override
  String get accountSetupHidePassword => 'Cuddio’r cyfrinair';

  @override
  String get accountSetupAppPassword => 'Cyfrinair ap';

  @override
  String get accountSetupApiToken => 'Tocyn API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Yn dod i mewn · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Yn mynd allan · SMTP';

  @override
  String get accountSetupSignIn => 'Mewngofnodi';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Mewngofnodi gyda $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Defnyddio cyfrinair ap';

  @override
  String get accountSetupUseAppPasswordInstead => 'Defnyddio cyfrinair ap yn lle hynny';

  @override
  String get accountSetupUseDifferentAddress => 'Defnyddio cyfeiriad gwahanol';

  @override
  String get accountSetupHowToCreateAppPassword => 'Sut i greu cyfrinair ap';

  @override
  String get accountSetupHowToCreateOne => 'Sut i greu un';

  @override
  String get accountSetupGoogleNote =>
      'Rydych chi’n mewngofnodi ar dudalen Google, a dyw Loupe byth yn gweld eich cyfrinair. Caniatewch i Loupe ddarllen, anfon a threfnu’ch e-bost.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      'Dyw “Mewngofnodi gyda Google” ddim ar gael yn yr adeiliad hwn eto. Gallwch chi gysylltu â chyfrinair ap yn lle hynny (mae angen Dilysu 2 Gam ar eich cyfrif Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Crëwch gyfrinair ap yn eich cyfrif Google a’i ludo isod.';

  @override
  String get accountSetupMicrosoftNote =>
      'Rydych chi’n mewngofnodi ar dudalen Microsoft, a dyw Loupe byth yn gweld eich cyfrinair. Mae hyn yn gweithio ar gyfer Outlook.com a Hotmail, ac ar gyfer cyfrifon gwaith neu ysgol ar Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Bydd mewngofnodi Microsoft yn cyrraedd mewn adeiliad diweddarach. Mae ei angen ar gyfrifon Outlook, Hotmail a Microsoft 365: dydyn nhw ddim yn derbyn cyfrineiriau gan apiau e-bost bellach.';

  @override
  String get accountSetupICloudNote => 'Mae iCloud Mail angen cyfrinair penodol i ap, nid cyfrinair eich Cyfrif Apple.';

  @override
  String get accountSetupYahooNote => 'Mae Yahoo Mail angen cyfrinair ap, nid cyfrinair eich cyfrif.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Mae Loupe yn cysylltu â Fastmail dros JMAP gyda thocyn API: Settings › Privacy & Security › Manage API tokens, ar gyfer JMAP, gyda mynediad at e-bost ac anfon.';

  @override
  String get accountSetupFastmailNote => 'Mae Fastmail angen cyfrinair ap ar gyfer apiau e-bost.';

  @override
  String get accountSetupServerSettings => 'Gosodiadau’r gweinydd';

  @override
  String get accountSetupSettingsNotFound => 'Heb ddod o hyd iddyn nhw’n awtomatig';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Wedi’u canfod drwy $source';
  }

  @override
  String get accountSetupEditSettings => 'Golygu’r gosodiadau';

  @override
  String get accountSetupSyncing => 'Mae’ch e-bost yn cysoni.';

  @override
  String get accountSetupDescription => 'Disgrifiad';

  @override
  String get accountSetupDescriptionHint => 'Gwaith, Personol…';

  @override
  String get accountSetupColour => 'Lliw';

  @override
  String accountSetupColourNumber(int number) {
    return 'Lliw $number';
  }

  @override
  String get accountSetupSaving => 'Yn cadw…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Doedd Loupe ddim yn gallu agor ei gronfa ddata e-bost ar y ffôn hwn. Caewch Loupe, ei agor eto a rhoi cynnig arall arni.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Aeth rhywbeth o’i le ($error). Rhowch gynnig arall arni.';
  }

  @override
  String get accountSetupSecurityNone => 'Dim';

  @override
  String get accountSetupProtocol => 'Protocol';

  @override
  String get accountSetupPort => 'Porth';

  @override
  String get accountSetupSecurity => 'Diogelwch';

  @override
  String get accountSetupUsername => 'Enw defnyddiwr';

  @override
  String get accountSetupUsernameHint => 'Eich cyfeiriad e-bost';

  @override
  String get accountSetupNoEncryptionTitle => 'Cysylltu heb amgryptio?';

  @override
  String get accountSetupNoEncryptionText =>
      'Byddai’ch cyfrinair a phob neges yn teithio fel testun plaen. Gallai unrhyw un ar y rhwydwaith, fel Wi-Fi cyhoeddus, eu darllen. Defnyddiwch hyn ar gyfer gweinydd ar eich rhwydwaith eich hun yn unig.';

  @override
  String get accountSetupUseWithoutEncryption => 'Defnyddio heb amgryptio';

  @override
  String get accountSetupApiTokenRejected =>
      'Gwrthodwyd y tocyn API. Crëwch docyn API Fastmail ar gyfer JMAP gyda mynediad at e-bost, a’i ludo.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Gwrthodwyd y cyfrinair. Defnyddiwch gyfrinair ap, nid cyfrinair eich cyfrif.';

  @override
  String get accountSetupPasswordRejected => 'Gwrthodwyd y cyfrinair. Gwiriwch ef a rhowch gynnig arall arni.';

  @override
  String get accountSetupServerUnreachable =>
      'Methu cysylltu â’r gweinydd. Gwiriwch osodiadau’r gweinydd a’ch cysylltiad.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Does dim ymddiriedaeth yn nhystysgrif y gweinydd. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Cafodd y mewngofnodi ei ddiddymu. Tapiwch “Mewngofnodi gyda $provider” i roi cynnig arall arni.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Mae angen caniatâd ar Loupe i ddarllen ac anfon eich Gmail. Mewngofnodwch eto a chaniatáu mynediad, gyda blwch Gmail wedi’i dicio.';

  @override
  String get accountSetupOAuthDenied =>
      'Mae angen caniatâd ar Loupe i ddarllen ac anfon eich e-bost. Mewngofnodwch eto a derbyn y caniatâd.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Rhaid i’ch sefydliad gymeradwyo Loupe cyn y gallwch chi ei ddefnyddio gyda’r cyfrif hwn. Gofynnwch i’ch gweinyddwr TG roi caniatâd gweinyddwr i Loupe yn Microsoft Entra ID, yna rhowch gynnig arall arni.';

  @override
  String get accountSetupOAuthBlocked =>
      'Dyw rheolau mewngofnodi’ch sefydliad ddim yn caniatáu Loupe ar y ddyfais hon. Gofynnwch i’ch gweinyddwr TG.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Methu cysylltu â $provider. Gwiriwch eich cysylltiad rhyngrwyd a rhowch gynnig arall arni.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Dyw mewngofnodi gyda $provider ddim wedi’i osod yn gywir yn y fersiwn hon o Loupe. Rhowch wybod am hyn.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Wnaeth mewngofnodi gyda $provider ddim gweithio. Rhowch gynnig arall arni.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Fe wnaeth $provider eich mewngofnodi, ond gwrthododd Gmail fynediad ar gyfer y cyfeiriad hwn. Dewiswch yr un cyfrif wrth fewngofnodi. Efallai bod IMAP wedi’i ddiffodd gan y gweinyddwr ar gyfrifon gwaith neu ysgol.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Fe wnaeth $provider eich mewngofnodi, ond gwrthododd y gweinydd e-bost fynediad ar gyfer y cyfeiriad hwn. Dewiswch yr un cyfrif wrth fewngofnodi. Efallai bod IMAP wedi’i ddiffodd gan y gweinyddwr ar gyfrifon gwaith neu ysgol.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Methu cysylltu â’r gweinydd e-bost. Gwiriwch eich cysylltiad a rhowch gynnig arall arni.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Dyw mewngofnodi gyda $provider ddim ar gael yn y fersiwn hon.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Wedi mewngofnodi eto. Mae $account yn cysoni.';
  }

  @override
  String get accountSetupSignInAgain => 'Mewngofnodi eto';

  @override
  String get accountSetupSigningIn => 'Yn mewngofnodi…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return 'Dyw $provider ddim yn derbyn mewngofnodi Loupe ar gyfer $email bellach, felly dyw $account ddim yn cysoni. Mewngofnodwch eto i gael ei e-bost.';
  }

  @override
  String get accountImportTitle => 'Mewnforio o Thunderbird';

  @override
  String get accountImportPointCamera => 'Pwyntiwch y camera at y cod QR mae Thunderbird yn ei ddangos.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Wedi sganio $scanned o $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Wedi sganio $scanned o $total cod',
      many: 'Wedi sganio $scanned o $total cod',
      few: 'Wedi sganio $scanned o $total cod',
      two: 'Wedi sganio $scanned o $total god',
      one: 'Wedi sganio $scanned o $total cod',
      zero: 'Wedi sganio $scanned o $total cod',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cyfrif hyd yma',
      many: '$count cyfrif hyd yma',
      few: '$count cyfrif hyd yma',
      two: '$count gyfrif hyd yma',
      one: '1 cyfrif hyd yma',
      zero: '$count cyfrif hyd yma',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Ar eich cyfrifiadur, agorwch Thunderbird a dewis Offer › Allforio ar gyfer Symudol. Dewiswch eich cyfrifon, yna sganiwch bob cod mae’n ei ddangos. Gellir sganio’r codau mewn unrhyw drefn.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Parhau gyda $count cyfrif',
      many: 'Parhau gyda $count cyfrif',
      few: 'Parhau gyda $count cyfrif',
      two: 'Parhau gyda $count gyfrif',
      one: 'Parhau gydag 1 cyfrif',
      zero: 'Parhau gyda $count cyfrif',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Gludo testun yn lle hynny';

  @override
  String get accountImportStartOver => 'Dechrau eto';

  @override
  String get accountImportDuplicateCode => 'Mae’r cod yna eisoes wedi’i ychwanegu.';

  @override
  String get accountImportRestarted =>
      'Mae’r cod hwn o allforiad newydd, felly cafodd y codau a sganiwyd o’r blaen eu rhoi o’r neilltu.';

  @override
  String get accountImportNotThunderbird => 'Dyw hwn ddim yn god cyfrif Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Mae’r cod hwn yn dod o Thunderbird mwy newydd. Diweddarwch Loupe i’w fewnforio.';

  @override
  String get accountImportDamaged => 'Methu darllen y cod Thunderbird hwn.';

  @override
  String get accountImportTooLarge => 'Mae’r cod hwn yn rhy fawr i fod yn allforiad Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Methu agor y Gosodiadau.';

  @override
  String get accountImportCameraOffTitle => 'Mae mynediad at y camera i ffwrdd';

  @override
  String get accountImportCameraOffText =>
      'Caniatewch i Loupe ddefnyddio’r camera yn y Gosodiadau i sganio’r cod, neu gludwch destun y cod yn lle hynny.';

  @override
  String get accountImportNoCameraTitle => 'Dim camera';

  @override
  String get accountImportNoCameraText => 'All Loupe ddim defnyddio camera yma. Gludwch destun y cod yn lle hynny.';

  @override
  String get accountImportCameraFailedTitle => 'Wnaeth y camera ddim cychwyn';

  @override
  String get accountImportCameraFailedText => 'Rhowch gynnig arall arni, neu gludwch destun y cod yn lle hynny.';

  @override
  String get accountImportOpenSettings => 'Agor Gosodiadau';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wedi dod o hyd i $count cyfrif',
      many: 'Wedi dod o hyd i $count cyfrif',
      few: 'Wedi dod o hyd i $count cyfrif',
      two: 'Wedi dod o hyd i $count gyfrif',
      one: 'Wedi dod o hyd i 1 cyfrif',
      zero: 'Heb ddod o hyd i gyfrifon',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Doedd dim modd darllen yr un o’r cyfrifon yn y codau hyn.';

  @override
  String get accountImportChoose => 'Dewiswch y cyfrifon i’w hychwanegu at Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Chafodd codau $codes o $total mo’u sganio, felly dyw eu cyfrifon ddim wedi’u rhestru.',
      many: 'Chafodd codau $codes o $total mo’u sganio, felly dyw eu cyfrifon ddim wedi’u rhestru.',
      few: 'Chafodd codau $codes o $total mo’u sganio, felly dyw eu cyfrifon ddim wedi’u rhestru.',
      two: 'Chafodd codau $codes o $total mo’u sganio, felly dyw eu cyfrifon ddim wedi’u rhestru.',
      one: 'Chafodd cod $codes o $total mo’i sganio, felly dyw ei gyfrifon ddim wedi’u rhestru.',
      zero: 'Chafodd codau $codes o $total mo’u sganio, felly dyw eu cyfrifon ddim wedi’u rhestru.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes a $last';
  }

  @override
  String get accountImportScanMore => 'Sganio rhagor o godau';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Doedd dim modd darllen $count cyfrif yn y codau. Efallai eu bod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
      many:
          'Doedd dim modd darllen $count cyfrif yn y codau. Efallai eu bod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
      few:
          'Doedd dim modd darllen $count cyfrif yn y codau. Efallai eu bod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
      two:
          'Doedd dim modd darllen $count gyfrif yn y codau. Efallai eu bod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
      one: 'Doedd dim modd darllen 1 cyfrif yn y codau. Efallai ei fod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
      zero:
          'Doedd dim modd darllen $count cyfrif yn y codau. Efallai eu bod yn defnyddio gosodiadau o Thunderbird mwy newydd.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Sganio eto';

  @override
  String get accountImportAlreadyAdded => 'Mae cyfrif gyda’r cyfeiriad hwn eisoes yn Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Byddwch chi’n mewngofnodi gyda $provider pan fydd yn cael ei ychwanegu, fel yn Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Ychwanegwch y cyfrif gyda chyfrinair ap (mae angen Dilysu 2 Gam).';

  @override
  String get accountImportGmailNoSignIn =>
      'Mae Thunderbird yn mewngofnodi i Gmail gyda Google. Bydd “Mewngofnodi gyda Google” yn cyrraedd mewn adeiliad diweddarach; tan hynny, ychwanegwch y cyfrif gyda chyfrinair ap (mae angen Dilysu 2 Gam).';

  @override
  String get accountImportBrowserSignIn =>
      'Mae Thunderbird yn mewngofnodi i’r cyfrif hwn yn y porwr. All Loupe ddim gwneud hynny eto: defnyddiwch gyfrinair ap os yw’ch darparwr yn cynnig un.';

  @override
  String get accountImportUnencrypted =>
      'Yn cysylltu heb amgryptio. Defnyddiwch hyn ar eich rhwydwaith eich hun yn unig.';

  @override
  String get accountImportEnterAgain => 'Rhowch ef eto';

  @override
  String get accountImportAdded => 'Wedi’i ychwanegu';

  @override
  String accountImportAdding(int index, int total) {
    return 'Yn ychwanegu $index o $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ychwanegu $count cyfrif',
      many: 'Ychwanegu $count cyfrif',
      few: 'Ychwanegu $count cyfrif',
      two: 'Ychwanegu $count gyfrif',
      one: 'Ychwanegu 1 cyfrif',
      zero: 'Ychwanegu cyfrifon',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Gludo testun allforio';

  @override
  String get accountImportPasteText => 'Gludwch destun cod allforio Thunderbird, un cod ar bob llinell.';

  @override
  String get accountImportPop3 =>
      'Does dim cefnogaeth i gyfrifon POP3. Mae Loupe yn cadw e-bost ar y gweinydd gydag IMAP.';

  @override
  String get accountImportKerberos =>
      'Mae’r cyfrif hwn yn mewngofnodi gyda Kerberos, a dyw Loupe ddim yn cefnogi hynny.';

  @override
  String get accountImportNtlm => 'Mae’r cyfrif hwn yn mewngofnodi gyda NTLM, a dyw Loupe ddim yn cefnogi hynny.';

  @override
  String get accountImportClientCertificate =>
      'Mae’r cyfrif hwn yn mewngofnodi gyda thystysgrif cleient, a dyw Loupe ddim yn cefnogi hynny eto.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Bydd mewngofnodi Microsoft yn cyrraedd mewn adeiliad diweddarach. Dyw cyfrifon Outlook a Microsoft 365 ddim yn derbyn cyfrineiriau gan apiau e-bost bellach.';

  @override
  String get accountImportEnterPassword => 'Rhowch y cyfrinair.';

  @override
  String get accountImportEnterAppPassword => 'Rhowch y cyfrinair ap.';

  @override
  String get accountImportEnterApiToken => 'Rhowch y tocyn API.';

  @override
  String get accountImportStorageFailed =>
      'Doedd Loupe ddim yn gallu agor ei storfa cyfrifon. Rhowch gynnig arall arni nes ymlaen.';

  @override
  String get accountImportFailed => 'Methu ychwanegu’r cyfrif. Rhowch gynnig arall arni, neu ei ychwanegu â llaw.';

  @override
  String get composeNewMessageTitle => 'Neges newydd';

  @override
  String get composeAttach => 'Atodi';

  @override
  String get composeSendLater => 'Anfon yn hwyrach';

  @override
  String composeSendAt(String time) {
    return 'Anfon $time';
  }

  @override
  String get composeSendHint => 'Pwyswch yn hir i anfon yn hwyrach';

  @override
  String get composeNoAccount => 'Ychwanegwch gyfrif i anfon e-bost.';

  @override
  String get composeTo => 'At:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Oddi wrth: $email';
  }

  @override
  String get composeFromLabel => 'Oddi wrth:';

  @override
  String get composeSubjectLabel => 'Pwnc:';

  @override
  String composeReplyTo(String address) {
    return 'Ateb i: $address';
  }

  @override
  String get composeFrom => 'Oddi wrth';

  @override
  String composeReplyFrom(String email) {
    return 'Ateb o $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Anfon o $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Ateb o $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Anfon o $email?';
  }

  @override
  String get composeDismiss => 'Cau';

  @override
  String composeAliasNotSaved(String account) {
    return 'Heb ei gadw fel hunaniaeth · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Cadw fel hunaniaeth';

  @override
  String composeAliasSaved(String email) {
    return 'Mae $email wedi’i gadw fel hunaniaeth.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Cyfeiriad annilys $address';
  }

  @override
  String get composeOriginalNotFound => 'Methu dod o hyd i’r neges wreiddiol.';

  @override
  String get composeDraftNotFound => 'Methu dod o hyd i’r drafft.';

  @override
  String get composeAttachmentsLost => 'Methu adfer yr atodiadau. Ychwanegwch nhw eto.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Methu ychwanegu rhai atodiadau: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Cyfanswm yr atodiadau yw $size; mae rhai gweinyddion yn gwrthod negeseuon mor fawr â hyn.';
  }

  @override
  String get composeAttachFailed => 'Methu atodi’r ffeil.';

  @override
  String get composeInvalidAddressTitle => 'Cyfeiriad annilys';

  @override
  String composeInvalidAddress(String address) {
    return 'Dyw “$address” ddim yn gyfeiriad e-bost dilys.';
  }

  @override
  String get composeNoSubjectTitle => 'Dim pwnc';

  @override
  String get composeNoSubjectText => 'Does gan y neges hon ddim pwnc. Ei hanfon beth bynnag?';

  @override
  String get composeSentBeforeChanges => 'Cafodd ei hanfon cyn eich newidiadau, sydd wedi’u cadw yn Drafftiau.';

  @override
  String composeScheduled(String time) {
    return 'Wedi’i hamserlennu ar gyfer $time';
  }

  @override
  String get composeSending => 'Yn anfon…';

  @override
  String get composeSent => 'Wedi’i hanfon';

  @override
  String get composeSendFailed => 'Methu anfon. Rhowch gynnig arall arni.';

  @override
  String get composeAlreadySent => 'Wedi’i hanfon eisoes.';

  @override
  String get composeDiscardChanges => 'Hepgor y newidiadau';

  @override
  String get composeSaveChanges => 'Cadw’r newidiadau';

  @override
  String get composeDeleteDraft => 'Dileu’r drafft';

  @override
  String get composeSaveDraft => 'Cadw’r drafft';

  @override
  String get composeDraftSaved => 'Drafft wedi’i gadw';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Ar $date am $time, ysgrifennodd $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Ar $date am $time, ysgrifennodd rhywun:';
  }

  @override
  String get composeForwardHeader => '---------- Neges wedi’i hanfon ymlaen ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Oddi wrth: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dyddiad: $date am $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Pwnc: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'At: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Yn nes ymlaen heddiw';

  @override
  String get composeTomorrowMorning => 'Bore yfory';

  @override
  String get composeMondayMorning => 'Bore Llun';

  @override
  String get composePickDateTime => 'Dewis dyddiad ac amser…';

  @override
  String get composeSendWithoutDelay => 'Anfon heb oedi';

  @override
  String composeSendTimeToday(String time) {
    return 'Heddiw am $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Yfory am $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day am $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Heddiw $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Yfory $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Parhau i olygu’ch drafft?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Chafodd neges mo’i hanfon pan gaeodd Loupe.',
      'one': 'Chafodd neges at $name mo’i hanfon pan gaeodd Loupe.',
      'other': 'Chafodd neges at $name ac eraill mo’i hanfon pan gaeodd Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Chafodd “$subject” mo’i hanfon pan gaeodd Loupe.',
      'one': 'Chafodd “$subject” at $name mo’i hanfon pan gaeodd Loupe.',
      'other': 'Chafodd “$subject” at $name ac eraill mo’i hanfon pan gaeodd Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Parhau i olygu';

  @override
  String get composeRecoverySave => 'Cadw yn Drafftiau';

  @override
  String get composeRecoveryDiscard => 'Hepgor';

  @override
  String get composeRecoverySaved => 'Wedi’i chadw yn Drafftiau';

  @override
  String get outboxSectionFailed => 'Heb eu hanfon';

  @override
  String get outboxSectionSending => 'Yn anfon';

  @override
  String get outboxSectionScheduled => 'Wedi’u hamserlennu';

  @override
  String get outboxStatusQueued => 'Yn anfon cyn hir';

  @override
  String get outboxStatusSending => 'Yn anfon…';

  @override
  String get outboxStatusFailed => 'Heb ei hanfon';

  @override
  String get outboxNoRecipients => 'Dim derbynwyr';

  @override
  String get outboxNoSubject => '(Dim pwnc)';

  @override
  String get outboxSendingFailed => 'Methodd yr anfon.';

  @override
  String get outboxEmptyTitle => 'Dim byd i’w anfon';

  @override
  String get outboxEmptyText => 'Mae negeseuon rydych chi’n eu hanfon yn hwyrach yn aros yma nes ei bod hi’n amser.';

  @override
  String get outboxSendNow => 'Anfon nawr';

  @override
  String get outboxReschedule => 'Aildrefnu';

  @override
  String get outboxRescheduleMenu => 'Aildrefnu…';

  @override
  String get outboxRescheduleTitle => 'Aildrefnu';

  @override
  String outboxRescheduled(String time) {
    return 'Wedi’i haildrefnu ar gyfer $time';
  }

  @override
  String get outboxCancel => 'Diddymu';

  @override
  String get outboxCancelSending => 'Diddymu’r anfon…';

  @override
  String get outboxCancelTitle => 'Diddymu’r anfon?';

  @override
  String get outboxMoveToDrafts => 'Symud i Drafftiau';

  @override
  String get outboxDiscard => 'Hepgor y neges';

  @override
  String get outboxMovedToDrafts => 'Wedi’i symud i Drafftiau';

  @override
  String get outboxDiscarded => 'Neges wedi’i hepgor';

  @override
  String get outboxAlreadySent => 'Wedi’i hanfon eisoes.';

  @override
  String get outboxBeingSent => 'Mae’r neges hon yn cael ei hanfon.';

  @override
  String get outboxActionFailed => 'Wnaeth hynny ddim gweithio. Mae’r neges yn dal yn yr Allflwch.';

  @override
  String get notificationsBadgeInboxes => 'Heb eu darllen yn y mewnflychau';

  @override
  String get notificationsBadgeVip => 'Heb eu darllen yn VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'E-bost newydd gan eich VIPs, mewn unrhyw gyfrif';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'E-bost newydd yn $email';
  }

  @override
  String get notificationsUnknownSender => 'Anfonwr anhysbys';

  @override
  String get notificationsNoSubject => '(Dim pwnc)';

  @override
  String get notificationsEncryptedMessage => 'Neges wedi’i hamgryptio';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Neges newydd gan $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count neges newydd',
      many: '$count neges newydd',
      few: '$count neges newydd',
      two: '$count neges newydd',
      one: '1 neges newydd',
      zero: '$count neges newydd',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Negeseuon newydd yn $account';
  }

  @override
  String get platformInstantChannel => 'Danfon ar unwaith';

  @override
  String get platformInstantChannelDescription => 'Yn ymddangos tra bo Loupe yn gwylio’ch mewnflychau am e-bost newydd';

  @override
  String get platformInstantTitle => 'Yn gwylio am e-bost newydd';

  @override
  String get platformInstantText => 'Mae Danfon ar unwaith ymlaen';

  @override
  String get platformErrorBox => 'Aeth rhywbeth o’i le wrth ddangos hyn. Ewch yn ôl a rhowch gynnig arall arni.';

  @override
  String get welcomeTagline => 'E-bost sy’n syml ar yr wyneb\nac yn bwerus oddi tano.';

  @override
  String get welcomeAccountsTitle => 'Pob cyfrif, un mewnflwch tawel';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail ac unrhyw weinydd IMAP neu JMAP.';

  @override
  String get welcomeSearchTitle => 'Chwilio sy’n dod o hyd iddo';

  @override
  String get welcomeSearchText => 'Canlyniadau ar unwaith ar eich ffôn, yna rhai’r gweinydd.';

  @override
  String get welcomePrivacyTitle => 'Preifat o’r cychwyn';

  @override
  String get welcomePrivacyText => 'Dim tracio. Mae delweddau o bell yn aros wedi’u rhwystro nes i chi ddweud.';

  @override
  String get welcomeAddAccount => 'Ychwanegu cyfrif';

  @override
  String get welcomeImport => 'Mewnforio o Thunderbird';

  @override
  String get welcomeTryDemo => 'Rhoi cynnig arni gydag e-bost demo';
}
