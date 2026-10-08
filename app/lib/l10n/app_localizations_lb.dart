// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Luxembourgish Letzeburgesch (`lb`).
class AppLocalizationsLb extends AppLocalizations {
  AppLocalizationsLb([String locale = 'lb']) : super(locale);

  @override
  String get commonAdd => 'Derbäisetzen';

  @override
  String get commonCancel => 'Ofbriechen';

  @override
  String get commonClose => 'Zoumaachen';

  @override
  String get commonDelete => 'Läschen';

  @override
  String get commonDone => 'Fäerdeg';

  @override
  String get commonEdit => 'Änneren';

  @override
  String get commonMore => 'Méi';

  @override
  String get commonMove => 'Verréckelen';

  @override
  String get commonName => 'Numm';

  @override
  String get commonNone => 'Keng';

  @override
  String get commonOff => 'Aus';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Un';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonPassword => 'Passwuert';

  @override
  String get commonRemove => 'Ewechhuelen';

  @override
  String get commonRetry => 'Nach eng Kéier';

  @override
  String get commonSave => 'Späicheren';

  @override
  String get commonSearch => 'Sichen';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Astellungen';

  @override
  String get commonShare => 'Deelen';

  @override
  String get commonTryAgain => 'Nach eng Kéier probéieren';

  @override
  String get commonUndo => 'Réckgängeg';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Messagen', one: '$count Message');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivéieren';

  @override
  String get mailDelete => 'Läschen';

  @override
  String get mailFlag => 'Markéieren';

  @override
  String get mailForward => 'Weiderleeden';

  @override
  String get mailMarkAsRead => 'Als gelies markéieren';

  @override
  String get mailMarkAsUnread => 'Als ongelies markéieren';

  @override
  String get mailMoveToJunk => 'An de Spam verréckelen';

  @override
  String get mailNewMessage => 'Neie Message';

  @override
  String get mailNoSubject => 'Kee Sujet';

  @override
  String get mailReply => 'Äntweren';

  @override
  String get mailReplyAll => 'Allen äntweren';

  @override
  String get mailSend => 'Schécken';

  @override
  String get mailUnflag => 'Markéierung ewechhuelen';

  @override
  String get mailboxArchive => 'Archiv';

  @override
  String get mailboxDrafts => 'Entwërf';

  @override
  String get mailboxInbox => 'Inbox';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Ausgangsdossier';

  @override
  String get mailboxSent => 'Geschéckt';

  @override
  String get mailboxTrash => 'Pabeierkuerf';

  @override
  String get conversationSomethingWentWrong => 'Eppes ass schifgaang. Probéiert nach eng Kéier.';

  @override
  String get conversationReplyToList => 'Der Lëscht äntweren';

  @override
  String get conversationReplyList => 'Un d’Lëscht';

  @override
  String get conversationThreadMuted => 'Thread stommgeschalt. Nei Messagen dra kommen als gelies un.';

  @override
  String get conversationThreadUnmuted => 'Stommschaltung vum Thread opgehuewen.';

  @override
  String get conversationLinkFailed => 'De Link konnt net opgemaach ginn.';

  @override
  String get conversationGoneTitle => 'Kee Message';

  @override
  String get conversationGoneText => 'Dëse Message gouf verréckelt oder geläscht.';

  @override
  String get conversationMuted => 'Stommgeschalt';

  @override
  String get conversationReaderOptions => 'Liesoptiounen';

  @override
  String get conversationReaderOptionsHint => 'Textgréisst an Usiicht';

  @override
  String get conversationTrash => 'An de Pabeierkuerf';

  @override
  String get conversationReplyHint => 'Laang drécke fir „Allen äntweren“ a „Weiderleeden“';

  @override
  String get conversationOfflineTitle => 'Dir sidd offline';

  @override
  String get conversationOfflineText =>
      'Dës Konversatioun ass nach net erofgelueden. Si gëtt gelueden, soubal Dir erëm online sidd.';

  @override
  String get conversationErrorTitle => 'Message kann net ugewise ginn';

  @override
  String get conversationErrorText => 'Eppes ass schifgaang.';

  @override
  String get conversationOfflineBanner => 'Dir sidd offline';

  @override
  String get conversationNotUpdated => 'Net aktualiséiert';

  @override
  String get conversationMe => 'mech';

  @override
  String get conversationNoSender => '(keen Ofsender)';

  @override
  String get conversationNoRecipients => 'keng Empfänger';

  @override
  String conversationRecipients(String names) {
    return 'un $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'un $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Vun';

  @override
  String get conversationHeaderTo => 'Un';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Äntwert un';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Sécherheet';

  @override
  String get conversationVerifiedSender => 'Verifizéierten Ofsender';

  @override
  String get conversationUnverifiedSender => 'Net verifizéierten Ofsender';

  @override
  String get conversationLoadingMessage => 'Message gëtt gelueden';

  @override
  String get conversationBodyError => 'Dëse Message konnt net geluede ginn.';

  @override
  String get conversationBodyOffline => 'Dir sidd offline. De Message gëtt gelueden, soubal Dir erëm online sidd.';

  @override
  String get conversationOriginalHint => 'Gesäit an der Usiicht „Original“ besser aus';

  @override
  String get conversationShowOriginal => 'Original weisen';

  @override
  String get conversationScrollToTop => 'No uewe scrollen';

  @override
  String get conversationTagsMenu => 'Tags…';

  @override
  String get conversationMuteThread => 'Thread stommschalten';

  @override
  String get conversationUnmuteThread => 'Stommschaltung ophiewen';

  @override
  String get conversationMoveMenu => 'Verréckelen…';

  @override
  String get conversationDeletePermanently => 'Definitiv läschen';

  @override
  String get conversationMoveToTrash => 'An de Pabeierkuerf verréckelen';

  @override
  String get conversationNotJunk => 'Kee Spam';

  @override
  String get conversationShowAllHeaders => 'All Kappzeile weisen';

  @override
  String get conversationViewSource => 'Quelltext weisen';

  @override
  String get conversationSaveAsFile => 'Als Fichier späicheren…';

  @override
  String get conversationShareAsFile => 'Als Fichier deelen…';

  @override
  String get conversationSearchFromMessageMenu => 'Vun dësem Message aus sichen…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Adress kopéieren';

  @override
  String get conversationAddressCopied => 'Adress kopéiert';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Message vun $name sichen';
  }

  @override
  String get conversationTags => 'Tags';

  @override
  String get conversationAllHeaders => 'All Kappzeilen';

  @override
  String get conversationCopyAll => 'Alles kopéieren';

  @override
  String get conversationHeadersCopied => 'Kappzeile kopéiert';

  @override
  String get conversationNoHeaders => 'Keng Kappzeilen';

  @override
  String get conversationSearchFromMessageTitle => 'Vun dësem Message aus sichen';

  @override
  String conversationSearchFrom(String name) {
    return 'Vun $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Un $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Sujet „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Quelltext';

  @override
  String get conversationSourceCopied => 'Quelltext kopéiert';

  @override
  String get conversationShareFailed => 'De Message konnt net gedeelt ginn.';

  @override
  String get conversationWrapLines => 'Zeilen ëmbriechen';

  @override
  String get conversationDontWrapLines => 'Zeilen net ëmbriechen';

  @override
  String get conversationSourceError => 'De Quelltext konnt net geluede ginn.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Et ginn déi éischt $shown vun $total gewisen. Kopéiert oder deelt de Quelltext, fir alles ze kréien.';
  }

  @override
  String get conversationAttachmentUntitled => 'Ouni Numm';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Méi Aktioune fir $name';
  }

  @override
  String get conversationMoveTo => 'Verréckelen an…';

  @override
  String get conversationMailboxesError => 'D’Mailboxe konnten net geluede ginn.';

  @override
  String get conversationReaderReadable => 'Liesbar';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Nëmmen Text';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Originalfaarwe behalen';

  @override
  String get conversationReaderRemember => 'Fir dësen Ofsender behalen';

  @override
  String get conversationSecurityPossiblePhishing => 'Méiglecherweis Phishing';

  @override
  String get conversationSecurityBeCareful => 'Opgepasst';

  @override
  String get conversationSecurityVerified => 'Verifizéiert';

  @override
  String get conversationSecurityNoIssues => 'Keng Problemer fonnt';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Trackeren', one: '$count Tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Weist firwat';

  @override
  String get conversationPhishingBannerTitle => 'Dëse Message gesäit no Phishing aus';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Linken a Biller sinn ausgeschalt.';
  }

  @override
  String get conversationPhishingBannerText => 'Linken a Biller sinn ausgeschalt.';

  @override
  String get conversationPhishingWhy => 'Firwat?';

  @override
  String get conversationPhishingShowAnyway => 'Trotzdeem weisen';

  @override
  String get conversationSecurityPhishingTitle => 'Dat gesäit no Phishing aus';

  @override
  String get conversationSecurityPhishingText =>
      'Verschidden Usazeeche weisen drop hin, datt dëse Message net dat ass, wat e virgëtt.';

  @override
  String get conversationSecurityCarefulTitle => 'Opgepasst mat dësem Message';

  @override
  String get conversationSecurityCarefulText => 'Eppes doru verdéngt en zweete Bléck.';

  @override
  String get conversationSecurityVerifiedText => 'Den Ofsender ass verifizéiert an näischt gesäit verdächteg aus.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Näischt gesäit verdächteg aus. Äre Mailserver huet net gesot, ob den Ofsender verifizéiert ass.';

  @override
  String get conversationSecurityNothingSuspicious => 'Näischt gesäit verdächteg aus.';

  @override
  String get conversationSecurityWhy => 'Grënn';

  @override
  String get conversationSecurityPrivacy => 'Dateschutz';

  @override
  String get conversationSecurityNoTrackingPixels => 'Keng Tracking-Pixelen';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tracking-Pixelen ewechgeholl',
      one: '$count Tracking-Pixel ewechgeholl',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Si hätten dem Ofsender verroden, wéini Dir dëse Message opgemaach hutt.';

  @override
  String get conversationSecurityNoRemoteImages => 'Keng extern Biller';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extern Biller',
      one: '$count externt Bild',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Wann Dir se lued, erfiert den Ofsender, wéini Dir dëse Message liest, an Är IP-Adress.';

  @override
  String get conversationSecurityNoClickTracking => 'Kee Klick-Tracking';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Linken iwwer Klick-Trackeren',
      one: '$count Link iwwer Klick-Trackeren',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Äre Klick géif vun $services registréiert ginn. Dréckt laang op e Link, fir säin Zil direkt opzemaachen.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technesch Detailer';

  @override
  String get conversationSecurityCheckedLocally => 'Op dësem Apparat iwwerpréift. Et gouf näischt verschéckt.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackeren';

  @override
  String get conversationSecurityImagesFrom => 'Biller vun';

  @override
  String get conversationSecuritySenderHistory => 'Ofsenderverlaf';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received kritt, $sent geschéckt';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linke féieren op';

  @override
  String get conversationSecurityHidden => 'Verstoppt';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements Elementer',
      one: '$elements Element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters Zeechen',
      one: '$characters Zeechen',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Ofsender net verifizéiert';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Äre Mailserver konnt net bestätegen, datt dëse Message wierklech vun $domain kënnt.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Äre Mailserver konnt net bestätegen, datt dëse Message wierklech vu sengem Ofsender kënnt.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Äre Mailserver konnt net bestätegen, datt dëse Message vun $domain kënnt. Dat ass bei Mailinglëschten üblech.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Äre Mailserver konnt net bestätegen, datt dëse Message vu sengem Ofsender kënnt. Dat ass bei Mailinglëschten üblech.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Reagéiert just drop, wann Dir e erwaart hutt. Am Zweifel kontaktéiert den Ofsender op en anere Wee.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Vun enger anerer Domain signéiert';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'De Message ass vun $signer signéiert, net vun $domain. Mailingdéngschter maachen dat, mee et beweist net, wien e geschriwwen huet.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'De Message ass vun enger anerer Domain signéiert, net vun $domain. Mailingdéngschter maachen dat, mee et beweist net, wien e geschriwwen huet.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Numm weist eng aner Adress';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Den Numm vum Ofsender ass „$shown“, mee de Message kënnt vun $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Vertraut der Adress, net dem Numm.';

  @override
  String get conversationSecurityReplyToTitle => 'Äntwerte ginn anzwousch hin';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Eng Äntwert géif un $address goen, net un $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Iwwerpréift d’Adress, éier Dir mat eppes Perséinlechem äntwert.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Benotzt Ären Numm';

  @override
  String get conversationSecurityImpersonationTitle => 'Benotzt den Numm vun enger Persoun, déi Dir kennt';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'En ass mat „$name“ ënnerschriwwen, wéi Ären eegenen Numm, kënnt awer vun enger neier Adress: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'En ass mat „$name“ ënnerschriwwen, wéi Äre VIP $knownName ($knownEmail), kënnt awer vun enger neier Adress: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'En ass mat „$name“ ënnerschriwwen, wéi $knownName ($knownEmail), kënnt awer vun enger neier Adress: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'An Äntwerte géifen un nach eng aner Adress goen.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Wann e no Suen, Coden oder Fichiere freet, frot d’Persoun als éischt op en anere Wee.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Bekannt Adress: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Dës Adress: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Éischte Message vun dësem Ofsender';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Dir hutt nach ni eng Mail vun $email kritt.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Passt op mat Ufroe vu Leit, déi Dir nach net kennt.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Verwiesselbar Buschtawen an der Adress vum Ofsender';

  @override
  String get conversationSecurityLinkHomographTitle => 'Verwiesselbar Buschtawen an engem Link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host vermëscht Buschtawen aus verschiddenen Alphabeten, fir eng aner Adress nozemaachen.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host benotzt verwiesselbar Buschtawen: et ass net $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Läscht en oder mellt en als Spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Maacht en net op.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domain: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domain, déi änlech ausgesäit';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Benotzt e bekannten Numm an der Domain';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain gesäit aus wéi Är eege Domain, $real, mee et ass eng aner Domain.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain gesäit aus wéi $brand ($real), mee et ass eng aner Domain.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain benotzt den Numm vun Ärer eegener Domain, $real, gehéiert awer net dozou.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain benotzt den Numm vun $brand ($real), gehéiert awer net dozou.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Richteg Message vun Ärer Organisatioun komme vun $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Richteg Message vun $brand komme vun $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domain vum Ofsender: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imitéiert: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Linke verstoppen, wouhi se féieren',
      one: 'E Link verstoppt, wouhin e féiert',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'E Link weist $shown, mécht awer $host op.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Mellt Iech net iwwer dës Linken un a bezuelt näischt doriwwer. Gitt d’Adress amplaz selwer an.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'D’Zil vun engem Link kann net iwwerpréift ginn';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'E Link weist $shown, geet awer iwwer $host, deen de Klick registréiert, éier e weiderleet.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'E Link féiert op eng reng IP-Adress';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts ass keng Websäit mat Numm. Richteg Firme verlinke selten esou.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'E verkleete Link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'E Link fänkt mat „$shown@“ un, fir wéi $shown auszegesinn, mécht awer $host op.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Eng verstoppte Säit gouf desaktivéiert';

  @override
  String get conversationSecurityDataLinkText =>
      'E Link hätt eng Säit opgemaach, déi am Message verpaakt ass, en Trick fir d’Link-Kontrollen ze ëmgoen.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Freet no engem Passwuert';

  @override
  String get conversationSecurityPasswordFieldText => 'De Message hat e Passwuertfeld. Loupe huet et ewechgeholl.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Gitt ni e Passwuert an eng E-Mail an.';

  @override
  String get conversationSecurityScriptLinkTitle => 'E Link, deen Code ausféiert, gouf desaktivéiert';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe féiert ni Code aus Messagen aus.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Verkierzt Linken',
      one: 'E verkierzte Link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts verstoppt dat richtegt Zil, bis Dir de Link opmaacht.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'International Webadress';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts benotzt net-laténgesch Buschtawen. Dat ass a ville Sprooche normal; kuckt, ob et déi Websäit ass, déi Dir erwaart.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Vill verstoppten Text';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Zeeche vun onsichtbarem Text goufen ewechgeholl. Esou verstoppten Text soll Spamfilteren täuschen.',
      one: '$count Zeeche vun onsichtbarem Text gouf ewechgeholl. Esou verstoppten Text soll Spamfilteren täuschen.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Verstoppten Text ewechgeholl';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeeche vun onsichtbarem Text goufen ewechgeholl.',
      one: '$count Zeeche vun onsichtbarem Text gouf ewechgeholl.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'De Message konnt net erofgeluede ginn. Iwwerpréift d’Verbindung a probéiert nach eng Kéier.';

  @override
  String exportSaved(String name) {
    return '„$name“ gespäichert';
  }

  @override
  String get exportSaveFailed => 'De Message konnt net gespäichert ginn.';

  @override
  String exportFailed(String folder) {
    return '„$folder“ konnt net exportéiert ginn.';
  }

  @override
  String exportEmpty(String folder) {
    return '„$folder“ huet keng Messagen zum Exportéieren.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '„$folder“ konnt net exportéiert ginn: Et konnt kee Message erofgeluede ginn. Iwwerpréift d’Verbindung a probéiert nach eng Kéier.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$name“ gespäichert, ouni $formattedCount Messagen, déi net erofgeluede konnte ginn.',
      one: '„$name“ gespäichert, ouni ee Message, deen net erofgeluede konnt ginn.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ konnt net gespäichert ginn.';
  }

  @override
  String exportTitle(String folder) {
    return '„$folder“ gëtt exportéiert';
  }

  @override
  String get exportListing => 'Message gi gesicht…';

  @override
  String exportProgress(String current, String total) {
    return '$current vun $total gëtt exportéiert…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount Message konnten net erofgeluede ginn',
      one: '1 Message konnt net erofgeluede ginn',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Mailboxen';

  @override
  String get mailboxesShown => 'Ugewisen';

  @override
  String get mailboxesHidden => 'Verstoppt';

  @override
  String get mailboxesCollapse => 'Zouklappen';

  @override
  String get mailboxesExpand => 'Opklappen';

  @override
  String get mailboxesManageVips => 'VIPs verwalten';

  @override
  String get mailboxesSubscriptions => 'Abonnementer';

  @override
  String mailboxesShowAccount(String account) {
    return '$account weisen';
  }

  @override
  String mailboxesHideAccount(String account) {
    return '$account verstoppen';
  }

  @override
  String get mailboxesExportFolder => 'Dossier exportéieren…';

  @override
  String get mailboxesUnpin => 'Net méi fixéieren';

  @override
  String get mailboxesLists => 'Lëschten';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Späichert eng Sich, fir se hei ze halen.';

  @override
  String get mailboxesTags => 'Tags';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Dir kënnt och an engem Message op den Numm vum Ofsender tippen a VIP aschalten.';

  @override
  String get mailboxesAddVip => 'VIP derbäisetzen…';

  @override
  String get mailboxesAddVipTitle => 'VIP derbäisetzen';

  @override
  String get mailboxesAddVipText => 'Maile vun dëser Adress kréien e Stär an erschéngen an der VIP-Mailbox.';

  @override
  String get mailboxesAddVipPlaceholder => 'numm@example.com';

  @override
  String get messageListFilterUnread => 'Ongelies';

  @override
  String get messageListFilterFlagged => 'Markéiert';

  @override
  String get messageListFilterToMe => 'Un: mech';

  @override
  String get messageListFilterCcMe => 'Cc: mech';

  @override
  String get messageListFilterWithAttachments => 'Mat Unhäng';

  @override
  String get messageListFilterUnreplied => 'Net beäntwert';

  @override
  String get messageListFilterFromVips => 'Vu VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen als gelies markéiert',
      one: '$count Message als gelies markéiert',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Méi al Maile konnten net geluede ginn.';

  @override
  String get messageListSelectMessages => 'Messagen auswielen';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgewielt',
      one: '$count ausgewielt',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'All auswielen';

  @override
  String get messageListDeselectAll => 'Auswiel ophiewen';

  @override
  String get messageListLoadFailed => 'Maile konnten net geluede ginn';

  @override
  String get messageListNoUnread => 'Keng ongeliese Mailen';

  @override
  String get messageListNoMatches => 'Keng passend Mailen';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Gefiltert no: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Filter ausschalten';

  @override
  String get messageListEmpty => 'Keng Mailen';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filterkritären: $filters';
  }

  @override
  String get messageListFilteredBy => 'Gefiltert no:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ongelies',
      one: '$formattedCount ongelies',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markéieren';

  @override
  String get messageListTrash => 'An de Pabeierkuerf';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'WEISEN';

  @override
  String get panesHideMailboxes => 'Mailboxe verstoppen';

  @override
  String get panesShowMailboxes => 'Mailboxe weisen';

  @override
  String get panesMailboxesWidth => 'Breet vun de Mailboxen';

  @override
  String get panesListWidth => 'Breet vun der Messagelëscht';

  @override
  String get panesNoMessageSelected => 'Kee Message ausgewielt';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Messagen', one: '$count Message');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Zréckgestallt';

  @override
  String get snoozeSheetTitle => 'Zréckstellen';

  @override
  String get snoozeLaterToday => 'Méi spéit haut';

  @override
  String get snoozeThisEvening => 'Haut den Owend';

  @override
  String get snoozeTomorrow => 'Muer';

  @override
  String get snoozeThisWeekend => 'Dëse Weekend';

  @override
  String get snoozeNextWeek => 'Nächst Woch';

  @override
  String get snoozePickDateTime => 'Datum an Zäit wielen…';

  @override
  String get snoozeMenu => 'Zréckstellen…';

  @override
  String get snoozeWakeNow => 'Elo zréckhuelen';

  @override
  String get snoozeChangeTimeMenu => 'Zäitpunkt änneren…';

  @override
  String get snoozeChangeTime => 'Zäit änneren';

  @override
  String get snoozeNoTime => 'Keng Zäit festgeluecht';

  @override
  String get snoozeFooter => 'Zréckgestallte Message kommen zur gewielter Zäit ongelies an d’Inbox zréck.';

  @override
  String get snoozeEmptyTitle => 'Näischt zréckgestallt';

  @override
  String get snoozeEmptyText => 'Stellt e Message zréck, da kënnt e erëm an d’Inbox, wann Dir e braucht.';

  @override
  String get appLockUnlock => 'Entspären';

  @override
  String get appLockFailed => 'Loupe konnt net bestätegen, datt Dir et sidd.';

  @override
  String get appLockLockedOut => 'Ze vill Versich. Probéiert méi spéit nach eng Kéier.';

  @override
  String get appLockPromptError => 'D’Ufro konnt net ugewise ginn. Probéiert nach eng Kéier.';

  @override
  String get appLockNoScreenLock => 'Dësen Handy huet keng Ecran-Spär.';

  @override
  String get appLockUnlockPromptTitle => 'Loupe entspären';

  @override
  String get appLockUnlockPromptReason => 'Bestätegt, datt Dir et sidd, fir Är Mailen ze gesinn.';

  @override
  String get appLockTurnOnPromptTitle => 'App-Spär aschalten';

  @override
  String get appLockTurnOnPromptReason => 'Bestätegt, datt Dir et sidd, fir d’App-Spär anzeschalten.';

  @override
  String get appLockScreenLockRemoved =>
      'D’App-Spär ass aus: Dësen Handy huet keng Ecran-Spär méi. Riicht eng an, fir d’App-Spär erëm anzeschalten.';

  @override
  String get appLockAfterImmediately => 'Direkt';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Minutten', one: '$count Minutt');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Stonnen', one: '$count Stonn');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Verschlësselt';

  @override
  String get openpgpEncryptedInPart => 'Deelweis verschlësselt';

  @override
  String get openpgpEncryptedLocked => 'Verschlësselt · gespaart';

  @override
  String get openpgpEncryptedNoKey => 'Verschlësselt · kee Schlëssel';

  @override
  String get openpgpEncryptedDamaged => 'Verschlësselt · beschiedegt';

  @override
  String get openpgpEncryptedUnsupported => 'Verschlësselt · net ënnerstëtzt';

  @override
  String get openpgpUnknownSigner => 'onbekannt';

  @override
  String get openpgpUnknownKey => 'Onbekannte Schlëssel';

  @override
  String get openpgpSignatureInvalid => 'Signatur ongëlteg';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signéiert vun $name, net vum Ofsender';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Deelweis signéiert vun $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signéiert vun $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Mat engem zréckgewisene Schlëssel signéiert';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signéiert vun $name · Schlëssel net akzeptéiert';
  }

  @override
  String get openpgpUnlock => 'Entspären';

  @override
  String get openpgpCantDecrypt => 'Dëse Message kann net entschlësselt ginn';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Mat OpenPGP verschlësselt';

  @override
  String get openpgpEncryption => 'Verschlësselung';

  @override
  String get openpgpDecryptedHere => 'Op dësem Apparat entschlësselt';

  @override
  String get openpgpNotDecrypted => 'Net entschlësselt';

  @override
  String get openpgpKeyLocked => 'Äre Schlëssel ass gespaart.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fir d’Schlësselen $keys',
      one: 'Fir de Schlëssel $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Geschützte Sujet';

  @override
  String get openpgpUnlockKey => 'Schlëssel entspären';

  @override
  String get openpgpSignature => 'Signatur';

  @override
  String get openpgpFingerprint => 'Fangerofdrock';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Schlëssel-ID $id';
  }

  @override
  String get openpgpSigned => 'Signéiert';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Akzeptanz';

  @override
  String get openpgpChangeAcceptance => 'Akzeptanz änneren…';

  @override
  String get openpgpCheckedFooter => 'Op dësem Apparat mat OpenPGP iwwerpréift, kompatibel mat Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Äre Schlëssel ass gespaart. Entspärt e mat senger Passphrase, fir dëse Message ze liesen.';

  @override
  String get openpgpSummaryNoSecretKey => 'E gouf fir e Schlëssel verschlësselt, deen net op dësem Apparat ass.';

  @override
  String get openpgpSummaryDamaged => 'Déi verschlësselt Donnéeë si beschiedegt oder goufen ënnerwee verännert.';

  @override
  String get openpgpSummaryUnsupported => 'E benotzt en Algorithmus, deen Loupe net ënnerstëtzt.';

  @override
  String get openpgpSummaryEncrypted => 'Just Dir an déi aner Empfänger kënnen e liesen.';

  @override
  String get openpgpSummaryNotSigned => 'E ass net signéiert, dofir ass den Ofsender net bestätegt.';

  @override
  String get openpgpSummaryUnknownKey =>
      'E ass signéiert, mee mat engem Schlëssel, deen Dir net hutt, dofir kann d’Signatur net iwwerpréift ginn.';

  @override
  String get openpgpSummaryBadSignature => 'D’Signatur passt net: De Message gouf méiglecherweis verännert.';

  @override
  String get openpgpSummaryMismatch =>
      'D’Signatur ass gëlteg, mee de Schlëssel gehéiert zu enger anerer Adress wéi där vum Ofsender.';

  @override
  String get openpgpSummaryPartial =>
      'Just en Deel vum Message ass signéiert. Text baussent der Signatur (zum Beispill d’Fousszeil vun enger Mailinglëscht) gëtt ënner der Zeil „Unsigned content“ gewisen, an aner Deeler vum Message, wéi Unhäng, sinn och net ofgedeckt.';

  @override
  String get openpgpSummaryOwnKey => 'Mat Ärem eegene Schlëssel signéiert.';

  @override
  String get openpgpSummaryVerified =>
      'D’Signatur ass gëlteg, an Dir hutt de Fangerofdrock vum Schlëssel verifizéiert.';

  @override
  String get openpgpSummaryUnverified =>
      'D’Signatur ass gëlteg. Dir hutt de Schlëssel akzeptéiert, ouni säi Fangerofdrock ze iwwerpréiwen.';

  @override
  String get openpgpSummaryRejected => 'D’Signatur ass gëlteg, mee Dir hutt dëse Schlëssel zréckgewisen.';

  @override
  String get openpgpSummaryUndecided =>
      'D’Signatur ass gëlteg, mee Dir hutt dëse Schlëssel nach net akzeptéiert. Vergläicht säi Fangerofdrock mam Ofsender.';

  @override
  String get openpgpAcceptanceRejected => 'Zréckgewisen';

  @override
  String get openpgpAcceptanceUndecided => 'Net akzeptéiert';

  @override
  String get openpgpAcceptanceUnverified => 'Akzeptéiert';

  @override
  String get openpgpAcceptanceVerified => 'Akzeptéiert a verifizéiert';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Schlëssel vun $name akzeptéieren?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fangerofdrock $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Jo, ech hunn de Fangerofdrock verifizéiert';

  @override
  String get openpgpAcceptUnverified => 'Jo, ouni Iwwerpréiwung';

  @override
  String get openpgpAcceptLater => 'Nach net';

  @override
  String get openpgpRejectKey => 'Dëse Schlëssel zréckweisen';

  @override
  String get openpgpNoSubject => '(kee Sujet)';

  @override
  String get openpgpEncryptionTitle => 'End-zu-End-Verschlësselung';

  @override
  String get openpgpMyKeys => 'Meng OpenPGP-Schlësselen';

  @override
  String get openpgpMyKeysFooter =>
      'Mat engem Schlëssel kënnt Dir verschlësselt Maile liesen an Är eege signéieren a verschlësselen. Dir benotzt Thunderbird? Exportéiert Äre Schlëssel do (Account Settings › End-To-End Encryption › Export Secret Key) an importéiert en hei.';

  @override
  String get openpgpAddKey => 'Schlëssel derbäisetzen…';

  @override
  String get openpgpAddresses => 'Adressen';

  @override
  String get openpgpAddressesFooter => 'Wéi ee Schlëssel all Adress benotzt, a wéini se verschlësselt a signéiert.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP-Schlëssele vun Äre Kontakter';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Akzeptéiert e Schlëssel, soubal Dir drop vertraut, datt e sengem Besëtzer gehéiert; vergläicht de Fangerofdrock mat him, fir e als verifizéiert ze markéieren.';

  @override
  String get openpgpImportPublicKey => 'Ëffentleche Schlëssel importéieren…';

  @override
  String get openpgpCollected => 'Iwwer Autocrypt gesammelt';

  @override
  String get openpgpCollectedFooter =>
      'Schlësselen, déi mat Messagen ukomm sinn. Loupe ka fir si verschlësselen, wa béid Säiten et wëllen.';

  @override
  String get openpgpOnThisDevice => 'Op dësem Apparat';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Verschlësselt Message verstoppen hire Sujet. Loupe späichert de Sujet vun all Message, deen Dir opmaacht, a senger verschlësselter Datebank op dësem Apparat, sou datt d’Lëscht, d’Sich an d’Notifikatiounen en uweisen. Am Hannergrond ka Loupe mat Schlësselen ouni Passphrase och d’Sujete vun neie Messagen entschlësselen; dofir luet et all Message (bis zu 1 MB) erof.';

  @override
  String get openpgpDecryptSubjects => 'Sujeten am Hannergrond entschlësselen';

  @override
  String get openpgpIndexFooter =>
      'D’Sich fënnt verschlësselt Messagen iwwer den Ofsender, d’Empfänger an de Sujet. Wann dëst ageschalt ass, setzt Loupe och den Text vun all verschlësselte Message, deen et entschlësselt, an de Sichindex vu senger verschlësselter Datebank op dësem Apparat, sou datt d’Sich se och iwwer hiren Text fënnt. Beim Ausschalte gëtt dësen Text aus dem Index geholl.';

  @override
  String get openpgpIndexDecrypted => 'Entschlësselt Message fir d’Sich indexéieren';

  @override
  String get openpgpPassphrases => 'Passphrasen';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-Schlësselen an S/MIME-Zertifikater, déi Dir mat enger Passphrase schützt, ginn entspaart, wann een se brauch. Ouni „Passphrase behalen“ gi se zwou Minutten no all Benotzung erëm gespaart.';

  @override
  String get openpgpRememberPassphrases => 'Passphrase behalen';

  @override
  String get openpgpRememberPassphrasesDetail => 'Bis Loupe zougemaach gëtt';

  @override
  String get openpgpLockKeysNow => 'Schlësselen elo spären';

  @override
  String get openpgpKeysLocked => 'Schlëssele gespaart.';

  @override
  String get openpgpKeyStateRevoked => 'widderruff';

  @override
  String get openpgpKeyStateExpired => 'ofgelaf';

  @override
  String get openpgpKeyStateNeverExpires => 'leeft ni of';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'leeft of den $date';
  }

  @override
  String get openpgpNoKey => 'Kee Schlëssel';

  @override
  String get openpgpAlwaysEncrypt => 'Ëmmer verschlësselen';

  @override
  String get openpgpAddKeyTitle => 'OpenPGP-Schlëssel derbäisetzen';

  @override
  String get openpgpAddKeyMessage =>
      'Importéiert de Schlëssel, deen Dir an Thunderbird benotzt, oder generéiert en neien.';

  @override
  String get openpgpImportFromClipboard => 'Aus der Tëschenoflag importéieren';

  @override
  String get openpgpImportFromFile => 'Aus engem Fichier importéieren';

  @override
  String get openpgpGenerateNewKey => 'Neie Schlëssel generéieren';

  @override
  String get openpgpImportPublicKeyTitle => 'Ëffentleche Schlëssel importéieren';

  @override
  String get openpgpFromClipboard => 'Aus der Tëschenoflag';

  @override
  String get openpgpFromFile => 'Aus engem Fichier';

  @override
  String get openpgpClipboardEmpty => 'D’Tëschenoflag ass eidel. Kopéiert als éischt de Schlëssel.';

  @override
  String get openpgpKey => 'Schlëssel';

  @override
  String get openpgpValidityRevoked => 'Widderruff';

  @override
  String openpgpValidityExpired(String date) {
    return 'Ofgelaf den $date';
  }

  @override
  String get openpgpNeverExpires => 'Leeft ni of';

  @override
  String openpgpValidUntil(String date) {
    return 'Gëlteg bis $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fangerofdrock kopéiert.';

  @override
  String get openpgpAlgorithm => 'Algorithmus';

  @override
  String get openpgpCreated => 'Erstallt';

  @override
  String get openpgpValidity => 'Gëltegkeet';

  @override
  String get openpgpProtection => 'Schutz';

  @override
  String get openpgpProtectionPassphrase => 'Passphrase';

  @override
  String get openpgpProtectionKeychain => 'Just Schlësselbond';

  @override
  String get openpgpKeyDetailsFooter =>
      'Deelt Äre ëffentleche Schlëssel, fir datt anerer fir Iech verschlëssele kënnen. D’Sécherheetskopie ass Äre geheime Schlëssel, geschützt duerch seng Passphrase, wann en eng huet: haalt se privat.';

  @override
  String get openpgpSharePublicKey => 'Ëffentleche Schlëssel deelen';

  @override
  String get openpgpCopyPublicKey => 'Ëffentleche Schlëssel kopéieren';

  @override
  String get openpgpPublicKeyCopied => 'Ëffentleche Schlëssel kopéiert.';

  @override
  String get openpgpBackUpSecretKey => 'Geheime Schlëssel sécheren';

  @override
  String get openpgpDeleteKey => 'Schlëssel läschen';

  @override
  String get openpgpRemoveKey => 'Schlëssel ewechhuelen';

  @override
  String get openpgpBackUpTitle => 'Geheime Schlëssel sécheren?';

  @override
  String get openpgpBackUpProtected =>
      'D’Sécherheetskopie ass duerch d’Passphrase vun Ärem Schlëssel geschützt. Wien allebéid huet, ka Är Maile liesen.';

  @override
  String get openpgpBackUpUnprotected =>
      'Dëse Schlëssel huet keng Passphrase: Wien d’Sécherheetskopie huet, ka Är Maile liesen an an Ärem Numm signéieren.';

  @override
  String get openpgpBackUp => 'Sécheren';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Äre Schlëssel $name läschen?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Schlëssel vun $name ewechhuelen?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Mailen, déi fir dëse Schlëssel verschlësselt sinn, kënnen op dësem Apparat net méi gelies ginn, ausser Dir importéiert en nach eng Kéier.';

  @override
  String get openpgpRemoveKeyMessage => 'Dir kënnt e spéider nach eng Kéier importéieren.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-Schlëssel';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Setzt ënner „End-zu-End-Verschlësselung“ e Schlëssel derbäi, fir Maile vun dëser Adress ze verschlësselen an ze signéieren.';

  @override
  String get openpgpGenerateAKey => 'Schlëssel generéieren…';

  @override
  String get openpgpSending => 'Schécken';

  @override
  String get openpgpSendingFooter =>
      'Déi automatesch Verschlësselung schalt sech an, wann all Empfänger en akzeptéierte Schlëssel oder e vertrauenswierdegt Zertifikat huet, oder wann Autocrypt seet, datt béid Säiten et wëllen. Verschlësselt Maile ginn ëmmer signéiert.';

  @override
  String get openpgpEncryptAutomatically => 'Automatesch verschlësselen';

  @override
  String get openpgpAlwaysEncryptDetail => 'Schéckt net, wann en Empfänger kee Schlëssel huet';

  @override
  String get openpgpSignUnencrypted => 'Onverschlësselt Maile signéieren';

  @override
  String get openpgpAttachPublicKey => 'Mäin ëffentleche Schlëssel uhänken';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt schéckt Äre ëffentleche Schlëssel mat all Message mat, sou datt aner Apps ouni Ariichtung fir Iech verschlëssele kënnen.';

  @override
  String get openpgpSendMyKey => 'Mäi Schlëssel mat de Maile schécken';

  @override
  String get openpgpPreferEncryption => 'Verschlësselung bevirzéien';

  @override
  String get openpgpPreferEncryptionDetail => 'Anerer bieden ze verschlësselen, wa se kënnen';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Joer', one: '$count Joer');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'D’Passphrase stëmmen net iwwereneen.';

  @override
  String openpgpKeyReady(String id) {
    return 'Äre Schlëssel $id ass prett.';
  }

  @override
  String get openpgpNewKey => 'Neie Schlëssel';

  @override
  String get openpgpNewKeyFor => 'Fir';

  @override
  String get openpgpYourName => 'Ären Numm';

  @override
  String get openpgpAddress => 'Adress';

  @override
  String get openpgpPassphrase => 'Passphrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Optional. Ouni Passphrase schützt just de Schlësselbond vun Ärem Handy de Schlëssel, a Loupe freet ni dono. Mat Passphrase freet Loupe dono, wann de Schlëssel gebraucht gëtt.';

  @override
  String get openpgpRepeatPassphrase => 'Widderhuelen';

  @override
  String get openpgpExpires => 'Oflaf';

  @override
  String get openpgpExpiresFooter =>
      'Dir kënnt en neie Schlëssel generéieren, ier dësen ofleeft. Thunderbird benotzt och dräi Joer.';

  @override
  String get openpgpGenerateKey => 'Schlëssel generéieren';

  @override
  String get openpgpKeyFor => 'Schlëssel fir';

  @override
  String get openpgpCantEncrypt => 'Verschlësselen net méiglech';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Fir $names gëtt et keen OpenPGP-Schlëssel, an dës Adress verschlësselt ëmmer. Huelt den Empfänger ewech oder importéiert de Schlëssel ënner Astellungen › End-zu-End-Verschlësselung.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Fir $names gëtt et kee gëltegt S/MIME-Zertifikat, an dës Adress verschlësselt ëmmer. Huelt den Empfänger ewech oder importéiert d’Zertifikat ënner Astellungen › End-zu-End-Verschlësselung.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Fir $names gëtt et keen OpenPGP-Schlëssel.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Fir $names gëtt et kee gëltegt S/MIME-Zertifikat.';
  }

  @override
  String get openpgpSendUnencrypted => 'Onverschlësselt schécken';

  @override
  String get openpgpCantSign => 'Signéieren net méiglech';

  @override
  String get openpgpCantSignMessage =>
      'De private Schlëssel vun Ärem S/MIME-Zertifikat ass net op dësem Apparat. Importéiert d’Zertifikat nach eng Kéier (e .p12- oder .pfx-Fichier) ënner Astellungen › End-zu-End-Verschlësselung.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Kee Schlëssel fir $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Keen Zertifikat fir $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Schlësselen aus Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Jiddereen huet e Schlëssel';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Jiddereen huet en Zertifikat';

  @override
  String get openpgpComposeEncrypt => 'Verschlësselen';

  @override
  String get openpgpComposeSign => 'Signéieren';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, wiesselen';
  }

  @override
  String get openpgpNoKeyFound => 'Keen OpenPGP-Schlëssel fonnt.';

  @override
  String get openpgpImportSecretKeyTitle => 'Geheime Schlëssel importéieren?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Dësen Unhang enthält e geheime Schlëssel ($names). Importéiert en nëmmen als Ären eegene Schlëssel, wann Dir en selwer exportéiert hutt, zum Beispill aus Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Als mäi Schlëssel importéieren';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'äre Schlëssel $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schlësselen importéieren ($names)?',
      one: 'Schlëssel vun $names importéieren?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importéieren an akzeptéieren';

  @override
  String get openpgpImportDecideLater => 'Importéieren, méi spéit decidéieren';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'Schlëssel vun $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importéiert: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-Schlëssele sinn ugehaangen.',
      one: 'En OpenPGP-Schlëssel ass ugehaangen.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importéieren';

  @override
  String get openpgpUnlockKeyTitle => 'OpenPGP-Schlëssel entspären';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Gitt d’Passphrase vum Schlëssel vun $name ($id) an.';
  }

  @override
  String get openpgpWrongPassphrase => 'Dës Passphrase ass falsch. Probéiert nach eng Kéier.';

  @override
  String get openpgpExplainLocked =>
      'Dëse Message ass verschlësselt. Entspärt Ären OpenPGP-Schlëssel, fir e ze liesen.';

  @override
  String get openpgpExplainNoKey =>
      'Dëse Message ass verschlësselt, mee fir keen OpenPGP-Schlëssel op dësem Apparat. Wann Dir en an Thunderbird liest, importéiert Äre Schlëssel vun do: Astellungen › End-zu-End-Verschlësselung.';

  @override
  String get openpgpExplainDamaged =>
      'Dëse verschlësselte Message ass beschiedegt a kann dofir net sécher entschlësselt ginn.';

  @override
  String get openpgpExplainUnsupported => 'Dëse Message benotzt eng Verschlësselung, déi Loupe nach net liese kann.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Dëse Message ass mat S/MIME verschlësselt, mee fir keen Zertifikat op dësem Apparat. Importéiert Äert Zertifikat (e .p12- oder .pfx-Fichier) ënner Astellungen › End-zu-End-Verschlësselung.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Dëse Message ass verschlësselt. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Entspärt Äert S/MIME-Zertifikat, fir e ze liesen.';

  @override
  String get openpgpAttachmentGone => 'Dësen Unhang ass net méi disponibel.';

  @override
  String get smimeEncrypted => 'Verschlësselt (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Verschlësselt (S/MIME) · keen Zertifikat';

  @override
  String get smimeEncryptedDamaged => 'Verschlësselt (S/MIME) · beschiedegt';

  @override
  String get smimeEncryptedUnsupported => 'Verschlësselt (S/MIME) · net ënnerstëtzt';

  @override
  String get smimeEncryptedLocked => 'Verschlësselt (S/MIME) · gespaart';

  @override
  String get smimeUnknownSigner => 'onbekannt';

  @override
  String get smimeSignatureModified => 'Signatur ongëlteg: Message verännert';

  @override
  String get smimeSignatureWeak => 'Signatur onsécher: alen Algorithmus';

  @override
  String get smimeSignatureUncheckable => 'Signatur kann net iwwerpréift ginn';

  @override
  String get smimeSignedCertificateMissing => 'Signéiert · Zertifikat feelt';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signéiert vun $name · Zertifikat widderruff';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signéiert vun $name · un engem aneren Datum';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signéiert vun $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signéiert vun $name · ongëltegt Zertifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signéiert vun $name · net vertrauenswierdeg';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signéiert vun $name · Zertifikat ofgelaf';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signéiert vun $name · Zertifikat nach net gëlteg';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signéiert vun $name · Zertifikat net fir Mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signéiert vun $name, net vum Ofsender';
  }

  @override
  String get smimeCantDecrypt => 'Dëse Message kann net entschlësselt ginn';

  @override
  String get smimeEncryptedWithSmime => 'Mat S/MIME verschlësselt';

  @override
  String get smimeEncryption => 'Verschlësselung';

  @override
  String get smimeDecryptedHere => 'Op dësem Apparat entschlësselt';

  @override
  String get smimeNotDecrypted => 'Net entschlësselt';

  @override
  String get smimeAuthenticated => 'authentifizéiert';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fir $count Zertifikater',
      one: 'fir $count Zertifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatur';

  @override
  String get smimeIssuedBy => 'Ausgestallt vun';

  @override
  String get smimeValid => 'Gëlteg';

  @override
  String smimeValidRange(String from, String to) {
    return '$from bis $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-Fangerofdrock';

  @override
  String get smimeSigned => 'Signéiert';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Widderruff gëtt iwwerpréift…';

  @override
  String get smimeNotRevoked => 'Net widderruff';

  @override
  String get smimeRevoked => 'Widderruff';

  @override
  String get smimeRevocationUnknown => 'Widderruffsstatus onbekannt';

  @override
  String smimeRevokedSince(String date) {
    return 'Zënter $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Bei der Zertifizéierungsstell ugefrot (Spärlëscht), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Bei der Zertifizéierungsstell ugefrot (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return '„$name“ vertrauen…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Dësem Zertifikat vertrauen…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Op dësem Apparat mat S/MIME iwwerpréift, kompatibel mat Outlook an Thunderbird; Widderruff bei der Zertifizéierungsstell.';

  @override
  String get smimeCheckedFooter =>
      'Op dësem Apparat mat S/MIME iwwerpréift, kompatibel mat Outlook an Thunderbird. De Widderruff gëtt net iwwerpréift (Astellungen › End-zu-End-Verschlësselung).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return '$name fir Maile vertrauen?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Dem Zertifikat vun $name vertrauen?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'All Zertifikat, dat dës Stell ausstellt, gëtt vertraut, wéi bei der Zertifizéierungsstell vun Ärer Firma. Vergläicht als éischt de Fangerofdrock mam Besëtzer:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Vergläicht als éischt de Fangerofdrock mam Besëtzer:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Vertrauen';

  @override
  String get smimeSummaryNoKey => 'E gouf fir en Zertifikat verschlësselt, dat net op dësem Apparat ass.';

  @override
  String get smimeSummaryDamaged => 'Déi verschlësselt Donnéeë si beschiedegt oder goufen ënnerwee verännert.';

  @override
  String get smimeSummaryUnsupported => 'E benotzt en Algorithmus, deen Loupe net ënnerstëtzt.';

  @override
  String get smimeSummaryLocked => 'Äert S/MIME-Zertifikat ass gespaart.';

  @override
  String get smimeSummaryEncrypted => 'Just Dir an déi aner Empfänger kënnen e liesen.';

  @override
  String get smimeSummaryNotSigned => 'E ass net signéiert, dofir ass den Ofsender net bestätegt.';

  @override
  String get smimeSummaryModified => 'D’Signatur passt net: De Message gouf nom Signéiere verännert.';

  @override
  String get smimeSummaryUncheckable => 'D’Signatur kann net iwwerpréift ginn.';

  @override
  String get smimeSummaryNoCertificate =>
      'D’Zertifikat vum Ënnerschreiwer ass net am Message an dofir kann et net iwwerpréift ginn.';

  @override
  String get smimeSummaryRevoked =>
      'D’Zertifizéierungsstell huet d’Zertifikat vum Ënnerschreiwer widderruff: Der Signatur ka net vertraut ginn.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'D’Zertifizéierungsstell huet d’Zertifikat vum Ënnerschreiwer widderruff ($reason): Der Signatur ka net vertraut ginn.';
  }

  @override
  String get smimeDateMismatch =>
      'E gouf méi wéi eng Stonn virun oder nom Datum vum Message signéiert: Et kéint en ale Message sinn, deen nach eng Kéier geschéckt gouf.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'D’Signatur ass gëlteg, an $issuer garantéiert, datt d’Zertifikat dem Ofsender gehéiert.';
  }

  @override
  String get smimeProblemInvalidChain => 'D’Zertifikat oder ee vu sengen Aussteller ass ongëlteg.';

  @override
  String get smimeProblemUntrusted => 'D’Zertifikat kënnt vun enger Stell, där Loupe net vertraut.';

  @override
  String get smimeProblemExpired => 'D’Zertifikat war ofgelaf.';

  @override
  String get smimeProblemNotYetValid => 'D’Zertifikat war nach net gëlteg.';

  @override
  String get smimeProblemWrongUsage => 'D’Zertifikat ass net fir Maile geduecht.';

  @override
  String get smimeProblemWrongAddress => 'D’Zertifikat gehéiert zu enger anerer Adress wéi där vum Ofsender.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Vertrauenswierdeg · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Net vertrauenswierdeg · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Ofgelaf den $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Gëlteg vum $date un';
  }

  @override
  String get smimeTrustInvalid => 'Ongëlteg';

  @override
  String get smimeTrustNotForMail => 'Net fir Mail';

  @override
  String get smimeTrustAnotherAddress => 'Aner Adress';

  @override
  String get smimeMyCertificates => 'Meng S/MIME-Zertifikater';

  @override
  String get smimeMyCertificatesFooter =>
      'Fir S/MIME, sou wéi Outlook a vill Firmen et benotzen. Importéiert Äert Zertifikat mat sengem private Schlëssel (e .p12- oder .pfx-Fichier), exportéiert aus Outlook, Windows, macOS oder Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Fir S/MIME, sou wéi Outlook a vill Firmen et benotzen. Importéiert Äert Zertifikat mat sengem private Schlëssel (e .p12- oder .pfx-Fichier), exportéiert aus Outlook, Windows, macOS oder Thunderbird, oder benotzt eent, dat Är Firma oder Dir op dësem Apparat installéiert hutt.';

  @override
  String get smimeCertificateExpired => 'ofgelaf';

  @override
  String smimeCertificateUntil(String date) {
    return 'bis $date';
  }

  @override
  String get smimeCertificateOnDevice => 'op dësem Apparat';

  @override
  String get smimeImportCertificateEllipsis => 'Zertifikat importéieren…';

  @override
  String get smimeUseDeviceCertificate => 'Zertifikat vun dësem Apparat benotzen…';

  @override
  String get smimeCorrespondentsCertificates => 'Zertifikater vun Äre Kontakter';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Aus signéierte Maile gesammelt, sou wéi Outlook an Thunderbird et maachen. Maile ginn nëmme fir vertrauenswierdeg Zertifikater verschlësselt: Loupe vertraut de Zertifizéierungsstellen, deene Mozilla fir E-Mail vertraut, an deenen, déi Dir derbäisetzt.';

  @override
  String get smimeRevocation => 'Widderruff';

  @override
  String get smimeRevocationFooter =>
      'Wann Dir eng signéiert Mail opmaacht, freet Loupe bei der Zertifizéierungsstell no, déi d’Zertifikat vum Ënnerschreiwer ausgestallt huet, ob et widderruff gouf (iwwer hiren OCSP-Responder oder hir Spärlëscht). D’Stell kann da gesinn, wéini een ënner Ärer Internetadress eng Mail liest, déi mat deem Zertifikat signéiert ass. D’Äntwerte bleiwen op dësem Apparat, bis se oflafen. E widderrufft Zertifikat gëtt am Kapp vum Message als „Widderruff“ ugewisen.';

  @override
  String get smimeCheckRevocation => 'Widderruff vun Zertifikater online iwwerpréiwen';

  @override
  String get smimeTrustedAuthorities => 'Vertrauenswierdeg Zertifizéierungsstellen';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vun Iech als vertrauenswierdeg agestuft, nieft deenen $count Stellen, deene Mozilla fir E-Mail vertraut.',
      one: 'Vun Iech als vertrauenswierdeg agestuft, nieft där $count Stell, där Mozilla fir E-Mail vertraut.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Zertifizéierungsstell';

  @override
  String get smimeImportACertificate => 'Zertifikat importéieren';

  @override
  String get smimeImportContactMessage =>
      'D’Zertifikat vun engem Kontakt (.cer, .crt, .pem) oder vun enger Zertifizéierungsstell.';

  @override
  String get smimeFromClipboard => 'Aus der Tëschenoflag';

  @override
  String get smimeFromFile => 'Aus engem Fichier';

  @override
  String get smimeClipboardEmpty => 'D’Tëschenoflag ass eidel. Kopéiert als éischt d’Zertifikat.';

  @override
  String get smimeCertificate => 'Zertifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Säi private Schlëssel bleift am Späicher fir Umeldungsdate vun Android, wou Är Firma oder Dir en installéiert hutt: Loupe freet Android, domat ze signéieren an z’entschlësselen. Signéiert Maile gi signéiert, wann Dir se schéckt.';

  @override
  String get smimeAddresses => 'Adressen';

  @override
  String get smimeUsage => 'Fir';

  @override
  String get smimeUsageNone => 'Näischt, wat Loupe benotzt';

  @override
  String get smimeUsageSigning => 'Signéieren';

  @override
  String get smimeUsageEncryption => 'Verschlësselung';

  @override
  String get smimeUsageCertificates => 'Zertifikater';

  @override
  String get smimeAlgorithm => 'Algorithmus';

  @override
  String get smimeSerialNumber => 'Seriennummer';

  @override
  String get smimeFingerprintCopied => 'Fangerofdrock kopéiert.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-Fangerofdrock';

  @override
  String get smimePrivateKey => 'Private Schlëssel';

  @override
  String get smimeKeyOnDevice => 'Op dësem Apparat';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'A Loupe, mat Passphrase';

  @override
  String get smimeKeyInLoupe => 'A Loupe';

  @override
  String get smimeSource => 'Hierkonft';

  @override
  String get smimeSourceSignedMail => 'Signéiert Mail';

  @override
  String get smimeSourceImported => 'Importéiert';

  @override
  String get smimeTrustHeader => 'Vertrauen';

  @override
  String get smimeTrustedRoot => 'Vertrauenswierdeg Stammstell';

  @override
  String get smimeIssuer => 'Aussteller';

  @override
  String smimeTrustNamed(String name) {
    return '„$name“ vertrauen';
  }

  @override
  String get smimeTrustThisAuthority => 'Dëser Stell vertrauen';

  @override
  String get smimeTrustThisCertificate => 'Dësem Zertifikat vertrauen';

  @override
  String get smimeStopTrusting => 'Net méi vertrauen';

  @override
  String get smimePassphrase => 'Passphrase';

  @override
  String get smimePassphraseFooter =>
      'Optional. Mat enger Passphrase gëtt de private Schlëssel op dësem Apparat zousätzlech verschlësselt (Argon2id an AES-256), a Loupe freet dono, fir ze signéieren an z’entschlësselen; „Passphrase behalen“ bestëmmt, wéi laang. Mailen, déi Dir schéckt, gi beim Schécke signéiert; Aarbechten am Hannergrond kënnen de Schlëssel net benotzen.';

  @override
  String get smimeChangePassphrase => 'Passphrase änneren…';

  @override
  String get smimeSetPassphraseEllipsis => 'Passphrase festleeën…';

  @override
  String get smimeRemovePassphrase => 'Passphrase ewechhuelen';

  @override
  String get smimeShareCertificate => 'Zertifikat deelen';

  @override
  String get smimeDeleteCertificate => 'Zertifikat läschen';

  @override
  String get smimeRemoveCertificate => 'Zertifikat ewechhuelen';

  @override
  String get smimePassphraseChanged => 'Passphrase geännert.';

  @override
  String get smimePassphraseSet => 'Passphrase festgeluecht.';

  @override
  String get smimeRemovePassphraseTitle => 'Passphrase ewechhuelen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'De private Schlëssel ass dann nëmme méi duerch de Schlësselbond geschützt, wéi ouni Passphrase: Loupe freet net méi dono, an Aarbechten am Hannergrond kënnen e benotzen.';

  @override
  String get smimePassphraseRemoved => 'Passphrase ewechgeholl.';

  @override
  String smimeTrustTitle(String name) {
    return '$name vertrauen?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'All Zertifikat, dat se ausstellt, gëtt fir Maile vertraut. Vergläicht als éischt de Fangerofdrock mam Besëtzer:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Äert Zertifikat $name läschen?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Zertifikat vun $name ewechhuelen?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe benotzt et net méi: Mailen, déi dofir verschlësselt sinn, kënnen a Loupe net méi gelies ginn. D’Zertifikat bleift op dësem Apparat (Settings › Security › Encryption & credentials).';

  @override
  String get smimeDeleteOwnMessage =>
      'Säi private Schlëssel gëtt vun dësem Apparat geläscht: Mailen, déi dofir verschlësselt sinn, kënnen hei net méi gelies ginn, ausser Dir importéiert et nach eng Kéier.';

  @override
  String get smimeRemoveContactMessage => 'Et kënnt mam nächste signéierte Message vun där Persoun zréck.';

  @override
  String get smimeAddressImportFooter =>
      'Importéiert en Zertifikat fir dës Adress, fir wéi Outlook mat S/MIME ze signéieren an ze verschlësselen.';

  @override
  String get smimeImportACertificateEllipsis => 'Zertifikat importéieren…';

  @override
  String get smimePreferFooter =>
      'Wa béid e Message kéinte schützen, gëtt dat bevirzugt benotzt, ausser nëmmen dat anert huet e Schlëssel oder en Zertifikat fir all Empfänger.';

  @override
  String get smimePreferSmime => 'S/MIME bevirzéien';

  @override
  String get smimePreferSmimeDetail => 'Amplaz OpenPGP';

  @override
  String get smimeCertificatePassword => 'Passwuert vum Zertifikat';

  @override
  String get smimeCertificatePasswordPrompt => 'Gitt d’Passwuert an, mat deem den Zertifikatsfichier exportéiert gouf.';

  @override
  String get smimeImport => 'Importéieren';

  @override
  String get smimeWrongPassword => 'Dëst Passwuert ass falsch. Probéiert nach eng Kéier.';

  @override
  String get smimeNoCertificateFound => 'Keen Zertifikat fonnt.';

  @override
  String smimeCertificateOf(String name) {
    return 'Zertifikat vun $name';
  }

  @override
  String get smimeNothingNew => 'Näischt Neies ze importéieren.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importéiert: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vertrauenswierdeg Zertifizéierungsstellen importéiert.',
      one: 'Eng vertrauenswierdeg Zertifizéierungsstell importéiert.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importéiert: $certificates an $count vertrauenswierdeg Zertifizéierungsstellen.',
      one: 'Importéiert: $certificates an eng vertrauenswierdeg Zertifizéierungsstell.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Dëse Fichier huet kee private Schlëssel. Exportéiert Äert Zertifikat mat sengem private Schlëssel.';

  @override
  String get smimeImportAsYoursTitle => 'Als Äert Zertifikat importéieren?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Dësen Unhang enthält en Zertifikat mat sengem private Schlëssel: $names. Importéiert et nëmmen, wann Dir et selwer exportéiert hutt, zum Beispill aus Outlook oder Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Als mäin Zertifikat importéieren';

  @override
  String smimeImportedOwn(String names) {
    return 'Äert Zertifikat $names gouf importéiert.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Äert Zertifikat $name ($addresses) gouf vun dësem Apparat derbäigesat.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return '„$name“ fir Maile vertrauen?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe kennt dës Zertifizéierungsstell net (vläicht déi vun enger Firma). Vertraut hir, fir d’Zertifikater ze iwwerpréiwen, déi se ausstellt. Vergläicht als éischt hire Fangerofdrock mat Ärer IT-Abteilung:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zertifikater sinn ugehaangen.',
      one: 'En Zertifikat ass ugehaangen.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Zertifikat importéieren';

  @override
  String get smimeUnlockTitle => 'S/MIME-Zertifikat entspären';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Gitt d’Passphrase vum Zertifikat vun $name ($addresses) an.';
  }

  @override
  String get smimeWrongPassphrase => 'Dës Passphrase ass falsch. Probéiert nach eng Kéier.';

  @override
  String get smimeUnlock => 'Entspären';

  @override
  String get smimeEnterAPassphrase => 'Gitt eng Passphrase an.';

  @override
  String get smimePassphrasesDiffer => 'Déi zwou Passphrase sinn net gläich.';

  @override
  String get smimeSetPassphraseTitle => 'Passphrase festleeën';

  @override
  String get smimeSetPassphraseText =>
      'Loupe freet dono, fir ze signéieren an z’entschlësselen. Wann Dir se vergiesst, importéiert d’Zertifikat nach eng Kéier aus sengem .p12-Fichier.';

  @override
  String get smimePassphraseAgain => 'Nach eng Kéier';

  @override
  String get smimeSetPassphraseButton => 'Festleeën';

  @override
  String get smimeLockedOpenAgain =>
      'Äert S/MIME-Zertifikat ass gespaart. Maacht de Message nach eng Kéier op, fir et z’entspären.';

  @override
  String get smimeDeviceHasNoCertificates => 'Dësen Apparat stellt seng Zertifikater net zur Verfügung.';

  @override
  String get smimeCantReadCertificate => 'Loupe kann dëst Zertifikat net liesen.';

  @override
  String get smimeCertificateNotForMail =>
      'Dëst Zertifikat ass net fir Mailen: Et huet keng E-Mail-Adress oder ass net fir ze signéieren oder ze verschlëssele geduecht.';

  @override
  String get smimeDeviceCertificateGone =>
      'D’Zertifikat ass net méi op dësem Apparat, oder Loupe däerf et net méi benotzen. Wielt et ënner Astellungen › End-zu-End-Verschlësselung nach eng Kéier aus.';

  @override
  String get smimeDeviceCertificateAppOnly => 'D’Zertifikat op dësem Apparat kann nëmme benotzt ginn, wa Loupe op ass.';

  @override
  String get smimeDeviceKeyDamaged => 'De verschlësselte Schlëssel ass beschiedegt.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'D’Zertifikat op dësem Apparat kann dat net: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'net ënnerstëtzt';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'D’Zertifikat op dësem Apparat huet net funktionéiert: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'D’Adress vun der Zertifizéierungsstell ass keng Webadress.';

  @override
  String get smimeAuthorityTimeout => 'D’Zertifizéierungsstell huet net rechtzäiteg geäntwert.';

  @override
  String get smimeAuthorityUnreachable => 'D’Zertifizéierungsstell war net z’erreechen.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'D’Zertifizéierungsstell huet mat $status geäntwert.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'D’Äntwert vun der Zertifizéierungsstell ass ze grouss.';

  @override
  String get smimeRevocationNotChecked =>
      'Net iwwerpréift: Nëmmen Zertifikater vu Stellen, deene Loupe vertraut, ginn iwwerpréift.';

  @override
  String get settingsLanguage => 'Sprooch';

  @override
  String get settingsLanguageSystem => 'Wéi den Handy';

  @override
  String get settingsLanguageFooter =>
      'Loupe benotzt d’Sprooch vun Ärem Handy, wann et se huet, a soss Englesch. D’Sprooch, déi Dir hei wielt, gëllt nëmme fir Loupe, Notifikatiounen inklusiv.';

  @override
  String get settingsAccountsHeader => 'Konten';

  @override
  String get settingsAddAccount => 'Kont derbäisetzen';

  @override
  String get settingsMailHeader => 'Mail';

  @override
  String get settingsSwipeActions => 'Wëschgesten';

  @override
  String get settingsSwipeLeft => 'No lénks wëschen';

  @override
  String get settingsSwipeLeftFooter =>
      'Eng komplett Wëschbeweegung féiert dës Aktioun aus. „Markéieren“ a „Méi“ sinn ëmmer just eng kuerz Wëschbeweegung ewech.';

  @override
  String get settingsSwipeRight => 'No riets wëschen';

  @override
  String get settingsSwipeRightFooter => 'Eng komplett Wëschbeweegung féiert dës Aktioun aus.';

  @override
  String get settingsSwipeToggleRead => 'Als gelies/ongelies markéieren';

  @override
  String get settingsSwipeTrash => 'An de Pabeierkuerf';

  @override
  String get settingsSwipeMove => 'Message verréckelen';

  @override
  String get settingsSwipeSnooze => 'Zréckstellen';

  @override
  String get settingsThreaded => 'No Konversatioun gruppéieren';

  @override
  String get settingsUndoSendDelay => 'Zäit fir d’Schécken z’annuléieren';

  @override
  String get settingsUndoSendDelayFooter => 'Geschéckte Message waarde sou laang, fir datt Dir se zréckhuele kënnt.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds Sekonnen',
      one: '$seconds Sekonn',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Ausgesinn';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSystem => 'Automatesch';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Donkel';

  @override
  String get settingsDensity => 'Messagelëscht';

  @override
  String get settingsDensityComfortable => 'Komfortabel';

  @override
  String get settingsDensityCompact => 'Kompakt';

  @override
  String get settingsReadingHeader => 'Liesen';

  @override
  String get settingsReadingFooter =>
      'Extern Biller kënnen den Ofsender verroden, wéini a wou Dir e Message opgemaach hutt.';

  @override
  String get settingsDefaultView => 'Standardusiicht';

  @override
  String get settingsDefaultViewFooter => 'Dir kënnt all Message mam Aa-Knäppchen ëmschalten.';

  @override
  String get settingsViewReadable => 'Liesbar';

  @override
  String get settingsViewReadableDetail => 'Opgeraumt, gutt liesbar, follegt dem donkele Modus';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Genee esou, wéi den Ofsender en designt huet';

  @override
  String get settingsViewPlain => 'Nëmmen Text';

  @override
  String get settingsViewPlainDetail => 'Just d’Wierder';

  @override
  String get settingsPlainTextFont => 'Schrëft fir Nëmmen-Text';

  @override
  String get settingsFontSans => 'Ouni Serifen';

  @override
  String get settingsFontMono => 'Fix Breet';

  @override
  String get settingsFontMonoDetail => 'Hält ASCII-Art an Tabellen ausgeriicht';

  @override
  String get settingsTechnicalLists => 'Technesch Lëschten';

  @override
  String get settingsLoadRemoteImages => 'Extern Biller lueden';

  @override
  String get settingsOpenLinksDirectly => 'Linken direkt opmaachen';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Klick-Trackeren iwwersprangen, wann d’Zil bekannt ass';

  @override
  String get settingsSecurityHeader => 'Sécherheet';

  @override
  String get settingsAppLock => 'App-Spär';

  @override
  String get settingsAppLockFooterOn => 'Loupe freet beim Start, a wann Dir no der Zäit ënner „Spären no“ zréckkommt.';

  @override
  String get settingsAppLockFooterOff =>
      'D’App-Spär freet no Ärem Fangerofdrock, Ärem Gesiicht oder Ärer Ecran-Spär, ier Är Maile gewise ginn.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'D’App-Spär ass nach aus. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Code ariichten';

  @override
  String get settingsScreenLockTextIos =>
      'D’App-Spär benotzt Face ID, Touch ID oder Äre Code, an dësen iPhone huet kee Code. Riicht een an der App „Settings“ an, a schalt dann d’App-Spär an.';

  @override
  String get settingsScreenLockTitleAndroid => 'Ecran-Spär ariichten';

  @override
  String get settingsScreenLockTextAndroid =>
      'D’App-Spär benotzt d’Ecran-Spär vun Ärem Handy, oder e Fangerofdrock oder e Gesiicht, deen do derbäigesat gouf, an dësen Handy huet keng. Riicht an den Android-Astellungen e PIN, e Muster oder e Passwuert an, a schalt dann d’App-Spär an.';

  @override
  String get settingsOpenSystemSettings => 'Astellungen opmaachen';

  @override
  String get settingsOpenAndroidSettings => 'Android-Astellungen opmaachen';

  @override
  String get settingsLockAfter => 'Spären no';

  @override
  String get settingsLockAfterFooter => 'Wéi laang Loupe am Hannergrond ka sinn, ier et nach eng Kéier freet.';

  @override
  String get settingsNotifications => 'Notifikatiounen';

  @override
  String get settingsEncryption => 'End-zu-End-Verschlësselung';

  @override
  String get settingsAdvanced => 'Erweidert';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo-Mail ass eng erfonnt Mailbox, déi nëmmen op dësem Handy existéiert. Et gëtt näischt verschéckt.';

  @override
  String get settingsDemoMode => 'Demo-Modus';

  @override
  String get settingsResetApp => 'App zrécksetzen';

  @override
  String get settingsResetFooter => 'Vergësst all Astellungen a geet zréck op den Wëllkommensecran.';

  @override
  String get settingsResetTitle => 'Loupe zrécksetzen?';

  @override
  String get settingsResetMessage =>
      'Doduerch ginn all Astellungen, Smart Mailboxes a rezent Siche vergiess, an Dir kommt zréck op de Wëllkommensecran.';

  @override
  String get settingsAboutHeader => 'Iwwer';

  @override
  String get settingsVersion => 'Versioun';

  @override
  String get settingsLicences => 'Lizenzen';

  @override
  String get settingsPrivacy => 'Dateschutz';

  @override
  String get settingsPrivacyDetail =>
      'Loupe huet keng Analytics a keen Tracking. Är Maile ginn nëmmen un Är Mailserveren.';

  @override
  String get settingsNotificationsOffIos => 'D’Notifikatioune fir Loupe sinn an de Settings ausgeschalt.';

  @override
  String get settingsNotificationsOffAndroid =>
      'D’Notifikatioune fir Loupe sinn an den Android-Astellungen ausgeschalt.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system erlaabt Loupe net, Notifikatiounen ze weisen. Erlaabt se an den Astellungen.';
  }

  @override
  String get settingsNewMailHeader => 'Nei Mailen';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo-Maile kommen net am Hannergrond un. Schéckt eng Testnotifikatioun, fir ze gesinn, wéi nei Maile ausgesinn.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe kuckt am Hannergrond no neie Mailen, wann iOS et erlaabt, wat bei Apps, déi Dir selten opmaacht, Stonnen ausernee leie kann. Dir gitt iwwer nei Messagen an Ären Inboxen informéiert, an iwwer Message vu VIPs an all Dossier.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe kuckt ongeféier all 15 Minutten no neie Mailen, wann Android et erlaabt. Dir gitt iwwer nei Messagen an Ären Inboxen informéiert, an iwwer Message vu VIPs an all Dossier.';

  @override
  String get settingsNoAccounts => 'Keng Konten';

  @override
  String get settingsVipOnly => 'Just VIP';

  @override
  String get settingsVipOnlyDetail => 'Just Message vun Äre VIPs';

  @override
  String get settingsHideContent => 'Inhalt verstoppen';

  @override
  String get settingsHideContentFooterOn =>
      'D’Notifikatioune soen nëmmen „Neie Message vun“ an de Kont, mee net, wie geschriwwen huet oder ëm wat et geet.';

  @override
  String get settingsHideContentFooterOff =>
      '„Inhalt verstoppen“ hält den Ofsender, de Sujet an d’Virschau vum Spärecran an aus den Notifikatiounen eraus.';

  @override
  String get settingsBackgroundAppRefresh => 'Background App Refresh';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nei Maile kommen nëmmen am Hannergrond un, wa Background App Refresh fir Loupe an de Settings ageschalt ass. iOS kann d’Verbindung mat Ären Inboxen net op halen, dofir gëtt et keng direkt Zoustellung.';

  @override
  String get settingsInstantDelivery => 'Direkt Zoustellung';

  @override
  String get settingsInstantDeliveryFooter =>
      'Déi direkt Zoustellung (experimentell) hält eng Verbindung mat Ären Inboxen op, sou datt nei Mailen a puer Sekonnen ukommen. Si weist eng diskret Notifikatioun „Waart op nei Mailen“ a verbraucht méi Batterie.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android kann déi direkt Zoustellung stoppen, fir Batterie ze spueren. Erlaabt Loupe, d’Batterie ouni Aschränkungen ze benotzen, fir datt se weiderleeft.';

  @override
  String get settingsExperimental => 'Experimentell';

  @override
  String get settingsComingSoon => 'Geschwënn';

  @override
  String get settingsAllowUnrestrictedBattery => 'Batterie ouni Aschränkungen erlaben';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Mat Push kënnen nei Maile Loupe direkt opwecken, wann Ären Mail-Service dat ënnerstëtzt. Pushen ginn iwwer de Push-Service vu Google a droen keng Mailen, mee just „kuck elo no“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Dëst Handy kann keng Pushen empfänken: si brauchen d’Google Play Services an eng Netzverbindung. Loupe kuckt weiderhin ongeféier all 15 Minutten no neie Mailen.';

  @override
  String get settingsCopyPushToken => 'Push-Token kopéieren';

  @override
  String get settingsPushTokenCopied => 'Push-Token kopéiert';

  @override
  String get settingsSendTestNotification => 'Testnotifikatioun schécken';

  @override
  String get settingsAppIconBadge => 'Badge um App-Symbol';

  @override
  String get settingsBadgeNote => 'De Badge gëtt aktualiséiert, all Kéier wa Loupe no Maile kuckt, och am Hannergrond.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'De Startecran vun dësem Handy weist keng Zuelen op App-Symboler. De Badge gëtt aktualiséiert, all Kéier wa Loupe no Maile kuckt, och am Hannergrond.';

  @override
  String get settingsTestNotificationBody => 'Esou gesi Notifikatioune fir nei Mailen aus.';

  @override
  String get settingsAccountRemoved => 'Dëse Kont gouf ewechgeholl.';

  @override
  String get settingsAccountHeader => 'Kont';

  @override
  String get settingsAccountDescription => 'Beschreiwung';

  @override
  String get settingsAccountDescriptionHint => 'Aarbecht, Privat…';

  @override
  String get settingsEmail => 'E-Mail';

  @override
  String get settingsColour => 'Faarf';

  @override
  String get settingsColourFooter => 'Markéiert d’Message vun dësem Kont an „All Inboxen“.';

  @override
  String settingsColourNumber(int number) {
    return 'Faarf $number';
  }

  @override
  String get settingsSendingHeader => 'Schécken';

  @override
  String get settingsSendingFooter =>
      'All Identitéit huet hir eege Signatur. Äntwerte gi vun der Adress geschéckt, un déi e Message geschéckt gouf.';

  @override
  String get settingsFoldersHeader => 'Dossieren';

  @override
  String get settingsFoldersFooter =>
      'Loupe weist a synchroniséiert d’Dossieren, déi Dir abonnéiert hutt, sou wéi Thunderbird. Inbox, Entwërf, Geschéckt, Spam, Pabeierkuerf an Archiv ginn ëmmer ugewisen.';

  @override
  String get settingsShowAllFolders => 'All Dossiere weisen';

  @override
  String get settingsIncoming => 'Erakommend';

  @override
  String get settingsOutgoing => 'Erausgoend';

  @override
  String get settingsConnectionNotEncrypted => 'Net verschlësselt';

  @override
  String get settingsSignIn => 'Umeldung';

  @override
  String get settingsSignInExpired => 'Ofgelaf';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider akzeptéiert d’Umeldung vu Loupe fir dëse Kont net méi, dofir ginn d’Mailen net synchroniséiert. Mellt Iech nach eng Kéier un, fir dat ze flécken.';
  }

  @override
  String get settingsSignInAgain => 'Nach eng Kéier umellen';

  @override
  String get settingsSigningIn => 'Umeldung leeft…';

  @override
  String get settingsRemoveAccount => 'Kont ewechhuelen';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '„$account“ ewechhuelen?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Seng Mailen an Astellunge gi vun dësem Handy ewechgeholl. Um Server gëtt näischt geläscht.';

  @override
  String get settingsManageFolders => 'Dossiere verwalten';

  @override
  String get settingsNoFolders => 'Nach keng Dossieren.';

  @override
  String get settingsManageFoldersFooter =>
      'Abonnéiert Dossieren erschéngen um Mailboxen-Ecran a ginn am Hannergrond synchroniséiert. Aner Mail-Apps mam selwechte Kont hale sech meeschtens och un dës Abonnementer.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Hält Är Smart Mailboxes fir Är aner Apparater. Um Mailboxen-Ecran verstoppt.';

  @override
  String get settingsFolderAlwaysShown => 'Ëmmer ugewisen';

  @override
  String settingsSubscribeToFolder(String folder) {
    return '$folder abonnéieren';
  }

  @override
  String get settingsIdentities => 'Identitéiten';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Déi éischt Identitéit ass de Standard fir nei Messagen. Zitt, fir d’Reiefolleg z’änneren.';

  @override
  String get settingsIdentitiesFooterSingle => 'D’Standardidentitéit fir nei Messagen.';

  @override
  String get settingsIdentitiesReplyFooter =>
      'Eng Äntwert gëtt vun der Identitéit geschéckt, un déi de Message geschéckt gouf.';

  @override
  String get settingsIdentityDefault => 'Standard';

  @override
  String settingsIdentityReorder(String email) {
    return '$email verréckelen';
  }

  @override
  String get settingsAddIdentity => 'Identitéit derbäisetzen';

  @override
  String get settingsNewIdentity => 'Nei Identitéit';

  @override
  String get settingsIdentity => 'Identitéit';

  @override
  String get settingsIdentityNameHint => 'Ären Numm';

  @override
  String get settingsReplyTo => 'Äntwert un';

  @override
  String get settingsSignature => 'Signatur';

  @override
  String get settingsSignatureFooter => 'Gëtt a Message vun dëser Identitéit ënner „-- “ derbäigesat.';

  @override
  String get settingsNoSignature => 'Keng Signatur';

  @override
  String get settingsCopyToMyself => 'Kopie u mech';

  @override
  String get settingsCopyToMyselfFooter => 'Gëtt bei all Message vun dëser Identitéit derbäigesat.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Fir Äntwerten un';

  @override
  String get settingsReplyPatternsFooter =>
      'Äntwerten op Messagen un dës Adresse gi vun dëser Identitéit geschéckt. * steet fir egal wat: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Eng Adress oder e Muster, an deem * fir egal wat steet.';

  @override
  String get settingsAddReplyPattern => 'Adress oder Muster derbäisetzen';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return '$pattern ewechhuelen';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ongëltegt Muster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ ass keng Adress a kee Muster wéi *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Keng Adress';

  @override
  String get settingsIdentityNoAddressMessage => 'Gitt d’E-Mail-Adress an, vun där geschéckt soll ginn.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ongëlteg Adress';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„Äntwert un“-Adress „$address“ ass keng gëlteg E-Mail-Adress.',
      'cc': 'Cc-Adress „$address“ ass keng gëlteg E-Mail-Adress.',
      'bcc': 'Bcc-Adress „$address“ ass keng gëlteg E-Mail-Adress.',
      'other': '„$address“ ass keng gëlteg E-Mail-Adress.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Identitéit späicheren';

  @override
  String get settingsDiscardChanges => 'Ännerunge verwerfen';

  @override
  String get settingsDeleteIdentity => 'Identitéit läschen';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '„$email“ läschen?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Messagen, déi schonn dovu geschéckt goufen, bleiwen, wéi se sinn.';

  @override
  String get settingsLastIdentityFooter => 'E Kont brauch op d’mannst eng Identitéit.';

  @override
  String get rulesTitle => 'Reegelen';

  @override
  String get rulesNewRule => 'Nei Reegel';

  @override
  String get rulesLoadError => 'D’Reegele konnten net geluede ginn.';

  @override
  String get rulesEmptyTitle => 'Keng Reegelen';

  @override
  String get rulesEmptyText =>
      'Reegele sortéieren, taggen a markéiere nei Maile fir Iech. Maacht eng mam Knäppchen uewen, oder aus enger Sich mat „Doraus eng Reegel maachen“.';

  @override
  String get rulesListFooter =>
      'D’Reegele lafe vun uewen no ënnen op nei Mailen an der Inbox. Halt eng Reegel gedréckt, fir se ze verréckelen.';

  @override
  String get rulesChangeError => 'D’Reegel konnt net geännert ginn';

  @override
  String get rulesConditionEveryMessage => 'All Message';

  @override
  String rulesMoveRule(String rule) {
    return '$rule verréckelen';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule un';
  }

  @override
  String get rulesServerRulesHeader => 'Server-Reegelen';

  @override
  String get rulesServerRulesFooter =>
      'Server-Reegele lafen um Mailserver, wa Mailen ukommen, och wann dësen Handy aus ass. Si leien an engem Sieve-Skript mam Numm „loupe“.';

  @override
  String get rulesStatusUnknown => 'Onbekannt';

  @override
  String get rulesStatusError => 'De Server konnt net ofgefrot ginn.';

  @override
  String get rulesStatusChecking => 'Gëtt iwwerpréift…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Leeft iwwer „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script“ ass dat aktiivt Skript. Tippt, fir datt et och d’Reegele vu Loupe ausféiert.';
  }

  @override
  String get rulesStatusNoScript =>
      'Um Server ass keen Skript aktiv. Wann Dir eng Server-Reegel späichert, gëtt dee vu Loupe aktivéiert.';

  @override
  String get rulesStatusUnavailable => 'Net disponibel';

  @override
  String get rulesStatusNoSieve => 'De Server vun dësem Kont bitt kee Sieve (ManageSieve oder JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'An $folder verréckelen';
  }

  @override
  String get rulesActionMoveUnknown => 'An en Dossier verréckelen';

  @override
  String rulesActionTag(String tag) {
    return 'Tag $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Tag $tag ewechhuelen';
  }

  @override
  String get rulesActionKeepInInbox => 'An der Inbox behalen';

  @override
  String rulesActionForward(String address) {
    return 'Weiderleeden un $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Weiderleeden un $address, keng Kopie behalen';
  }

  @override
  String get rulesActionStop => 'Stopp';

  @override
  String get rulesNoActions => 'Mécht nach näischt';

  @override
  String get rulesLocationDevice => 'Apparat';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Dësen Apparat';

  @override
  String get rulesNewRuleTitle => 'Nei Reegel';

  @override
  String get rulesEditRuleTitle => 'Reegel änneren';

  @override
  String get rulesDefaultNameEveryMessage => 'All Message';

  @override
  String get rulesConditionHeader => 'Wann en neie Message passt';

  @override
  String get rulesConditionFooter =>
      'Schreift se wéi eng Sich: from:, to:, s: (Sujet), b: (Text), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:rechnung';

  @override
  String get rulesAccounts => 'Konten';

  @override
  String get rulesAllAccounts => 'All Konten';

  @override
  String get rulesRemovedAccount => 'Ewechgeholle Kont';

  @override
  String get rulesAccountsFooter => 'Eng Reegel fir all Konte gëllt och fir Konten, déi Dir méi spéit derbäisetzt.';

  @override
  String get rulesActionsHeader => 'Dann';

  @override
  String get rulesForwardingFooter =>
      'Weiderleede schéckt all passende Message, soubal e ukënnt, un eng aner Adress, och wann dësen Handy aus ass. Verschidde Providere limitéieren, wéi vill Maile weidergeleet däerfe ginn.';

  @override
  String get rulesForwardingHiddenFooter => 'Weiderleede funktionéiert nëmmen a Server-Reegelen a feelt dofir hei.';

  @override
  String rulesRemoveAction(String action) {
    return '$action ewechhuelen';
  }

  @override
  String get rulesAddAction => 'Aktioun derbäisetzen';

  @override
  String get rulesAddMove => 'An en Dossier verréckelen…';

  @override
  String get rulesAddTagMenu => 'Tag derbäisetzen…';

  @override
  String get rulesRemoveTagMenu => 'Tag ewechhuelen…';

  @override
  String get rulesAddForward => 'Weiderleeden un…';

  @override
  String get rulesStopProcessing => 'Keng weider Reegelen ausféieren';

  @override
  String get rulesRunOnHeader => 'Ausféieren op';

  @override
  String get rulesRunOnDeviceFooter =>
      'Dësen Apparat féiert d’Reegel op neie Mailen an der Inbox aus, all Kéier wa Loupe no Maile kuckt.';

  @override
  String get rulesRunOnServerFooter =>
      'De Mailserver féiert d’Reegel aus, wa Mailen ukommen, och wann dësen Handy aus ass. Brauch Sieve, iwwer ManageSieve (Dovecot, mailcow) oder JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Op existent Messagen uwenden…';

  @override
  String get rulesDeleteRule => 'Reegel läschen';

  @override
  String rulesDeleteTitle(String rule) {
    return '„$rule“ läschen?';
  }

  @override
  String get rulesMoveAccountTitle => 'Dossier a wéi engem Kont?';

  @override
  String get rulesMoveAccountMessage => 'Maile vun den anere Konte kommen do an den Dossier mam selwechten Numm.';

  @override
  String get rulesAddTag => 'Tag derbäisetzen';

  @override
  String get rulesRemoveTag => 'Tag ewechhuelen';

  @override
  String get rulesForwardTo => 'Weiderleeden un';

  @override
  String get rulesForwardToMessage =>
      'De Server leet all passende Message un dës Adress weider, och wann dësen Handy aus ass. Benotzt eng Adress, déi Iech gehéiert oder där Dir vertraut.';

  @override
  String get rulesNotAnAddressTitle => 'Keng E-Mail-Adress';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ ass keng Adress, un déi weidergeleet ka ginn.';
  }

  @override
  String get rulesKeepCopyTitle => 'Hei eng Kopie behalen?';

  @override
  String get rulesKeepCopy => 'Kopie behalen';

  @override
  String get rulesDontKeepCopy => 'Keng Kopie behalen';

  @override
  String get rulesCheckCondition => 'Konditioun iwwerpréiwen';

  @override
  String get rulesChooseActionTitle => 'Aktioun wielen';

  @override
  String get rulesChooseActionMessage => 'Leet fest, wat d’Reegel mat de passende Message mécht.';

  @override
  String get rulesSaveError => 'D’Reegel konnt net gespäichert ginn';

  @override
  String get rulesSaveServerError => 'D’Server-Reegel konnt net gespäichert ginn';

  @override
  String get rulesRunOnDeviceInstead => 'Amplaz op dësem Apparat ausféieren';

  @override
  String get rulesNothingToApplyTitle => 'Näischt fir unzewenden';

  @override
  String get rulesNothingToApplyMessage =>
      'Gitt der Reegel als éischt eng Konditioun, déi funktionéiert, an eng Aktioun.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return '„$rule“ op Messagen uwenden an…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inboxen';

  @override
  String get rulesApplyScopeAll => 'All Mailboxen';

  @override
  String get rulesFindingMessages => 'Message gi gesicht…';

  @override
  String get rulesSearchError => 'Sich huet net geklappt';

  @override
  String get rulesSearchErrorUnknown => 'Eppes ass schifgaang.';

  @override
  String get rulesNoMatchesTitle => 'Keng passend Messagen';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Do passt näischt op „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$rule“ op $countString Messagen uwenden?',
      one: '„$rule“ op $countString Message uwenden?',
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
      other: 'Op $countString Messagen uwenden',
      one: 'Op $countString Message uwenden',
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
      other: '„$rule“ op $countString Messagen ugewannt',
      one: '„$rule“ op $countString Message ugewannt',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'De Server gëtt gefrot, wat e kann…';

  @override
  String get rulesServerUnreachable => 'De Server war net z’erreechen.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kann net um Server lafen: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kann net um Server vun $account lafen: $problem';
  }

  @override
  String get rulesShowScript => 'Skript weisen';

  @override
  String get rulesHideScript => 'Skript verstoppen';

  @override
  String get rulesMatchingHeader => 'Passend Messagen';

  @override
  String get rulesMatchingHeaderLoading => 'Passend Messagen…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString passend Messagen',
      one: '$countString passende Message',
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
      other: '$countString+ passend Messagen',
      one: '$countString+ passende Message',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Vun de leschten 30 Deeg. D’Reegel selwer wierkt nëmmen op nei Mailen, ausser Dir wennt se op existent Messagen un.';

  @override
  String rulesConditionError(String error) {
    return 'D’Konditioun huet e Feeler: $error';
  }

  @override
  String get rulesPreviewNoSender => '(keen Ofsender)';

  @override
  String get rulesPreviewNoSubject => '(kee Sujet)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'an $countString weider',
      one: 'an $countString weideren',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Näischt vun de leschten 30 Deeg.';

  @override
  String get rulesIncludeTitle => 'Server-Reegelen aschalten';

  @override
  String get rulesIncludeLeaveOff => 'Aus loossen';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'De Server féiert d’Reegele vu Loupe fir $account schonn aus.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ ass dat aktiivt Skript um Server vun $account, dofir féiert de Server dat aus an net d’Reegele vu Loupe. Loupe ersetzt et net. Et ka follgend Zeilen derbäisetzen, an da féiert de Server d’Reegele vu Loupe no deene vum Skript aus:';
  }

  @override
  String get rulesShowWholeScript => 'Ganze Skript weisen';

  @override
  String get rulesHideWholeScript => 'Ganze Skript verstoppen';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Soss ännert sech näischt un „$script“. Wa seng Filteren duerno am Webmail geännert ginn, kann de Webmail et ouni dës Zeilen nei schreiwen; Loupe weist d’Server-Reegelen dann erëm als aus.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Bei „$script“ derbäisetzen';
  }

  @override
  String get subscriptionsTitle => 'Abonnementer';

  @override
  String get subscriptionsNewsletters => 'Newsletteren';

  @override
  String get subscriptionsDiscussions => 'Diskussiounen';

  @override
  String get subscriptionsFilter => 'Filteren';

  @override
  String get subscriptionsFilterNeverRead => 'Ni gelies';

  @override
  String get subscriptionsFilterRarelyRead => 'Seele gelies';

  @override
  String get subscriptionsFilterAll => 'All';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonnementer konnten net gezielt ginn';

  @override
  String get subscriptionsNoMatches => 'Keng Treffer';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Keng Newsletter heescht „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Keng Lëscht heescht „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Keng Newsletteren';

  @override
  String get subscriptionsNoNewslettersDetail => 'Newsletteren an aner Massemaile erschéngen hei, soubal se ukommen.';

  @override
  String get subscriptionsNothingNeverRead => 'Näischt ni gelies';

  @override
  String get subscriptionsNothingRarelyRead => 'Näischt seele gelies';

  @override
  String get subscriptionsNothingFilteredDetail => 'Dir liest vun allem, wat Dir kritt, op d’mannst eppes.';

  @override
  String get subscriptionsNoDiscussions => 'Keng Diskussiounen';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mailinglëschten, op déi Dir schreiwe kënnt, erschéngen hei, soubal hir Mailen ukommen.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lëschten, op déi verschidde Leit schreiwen. Halt eng gedréckt, fir se un d’Mailboxen ze fixéieren, als rengen Text ze liesen oder bei d’Newsletteren ze verréckelen.';

  @override
  String get subscriptionsPrivacyNote =>
      'Um Handy gezielt, aus de Mailen, déi en erofgelueden huet; dofir gëtt näischt verschéckt. Loupe kontaktéiert en Ofsender nëmmen, wann Dir op „Ofmellen“ tippt: D’Ofmeldung mat engem Klick schéckt just „List-Unsubscribe=One-Click“ un d’Adress, déi den Ofsender uginn huet, ouni Cookien an ouni soss eppes iwwer Iech, a luet ni seng Säiten oder Biller.';

  @override
  String get subscriptionsVolumeNone => 'Lescht Zäit keng';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / Mount';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / Mount';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '< 1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return '$percent gelies';
  }

  @override
  String get subscriptionsStillSending => 'Schéckt nach ëmmer';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Ofgemellt den $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Ofmeldsäit den $date opgemaach';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Een Tipp · kontaktéiert $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Per E-Mail un $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Op der Websäit $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Ofmellen';

  @override
  String get subscriptionsUnsubscribeAgain => 'Nach eng Kéier ofmellen';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString an der Inbox archivéieren',
      one: '$countString an der Inbox archivéieren',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Reegel maachen…';

  @override
  String get subscriptionsCreateRuleDetail => 'Zukünfteg Maile verréckelen oder archivéieren';

  @override
  String get subscriptionsTreatAsDiscussion => 'Als Diskussioun behandelen';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Eng Lëscht, op déi Leit schreiwen: wéi e Forum liesen';

  @override
  String get subscriptionsTreatAsNewsletter => 'Als Newsletter behandelen';

  @override
  String get subscriptionsBlockSender => 'Ofsender blockéieren';

  @override
  String get subscriptionsBlock => 'Blockéieren';

  @override
  String get subscriptionsBlocked => 'Blockéiert';

  @override
  String get subscriptionsBlockedDetail => 'Nei Maile kommen an de Spam';

  @override
  String get subscriptionsPin => 'Un d’Mailboxe fixéieren';

  @override
  String get subscriptionsUnpin => 'Vun de Mailboxe lassmaachen';

  @override
  String get subscriptionsOpenDefaultView => 'An der Standardusiicht opmaachen';

  @override
  String get subscriptionsOpenPlainText => 'Als rengen Text opmaachen (Mono)';

  @override
  String get subscriptionsPinned => 'Fixéiert';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ongelies',
      one: '$countString ongelies',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Momentan keng Maile vun dësem Ofsender.';

  @override
  String get subscriptionsLatestMessages => 'LESCHT MESSAGEN';

  @override
  String get subscriptionsMail => 'Mailen';

  @override
  String get subscriptionsNoneIn90Days => 'Keng an 90 Deeg';

  @override
  String get subscriptionsRead => 'Gelies';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString vun $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Fir d’lescht kritt';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Dossieren', one: 'Dossier');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Schéckt nach ëmmer';

  @override
  String get subscriptionsUnsubscribedTitle => 'Ofgemellt';

  @override
  String subscriptionsSince(String date) {
    return 'zënter $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'Säit den $date opgemaach';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender seet net, wéi een sech ofmellt.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender seet net, wéi een sech ofmellt. Dir kënnt en amplaz blockéieren.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Ofmeldung vun $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Vun $sender ofgemellt.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Ofmeldung huet net geklappt: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatesch Ofmeldung huet net geklappt';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Ofmeld-E-Mail schécken';

  @override
  String subscriptionsOpenSite(String site) {
    return '$site opmaachen';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site opmaachen?';
  }

  @override
  String get subscriptionsOpen => 'Opmaachen';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender mellt iwwer seng Websäit of. D’Säit geet am Browser vu Loupe op; maacht et do fäerdeg.';
  }

  @override
  String get subscriptionsWebInsecure => 'D’Verbindung mat dëser Websäit ass net verschlësselt.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Opgepasst: Dës Adress imitéiert $site mat Buschtawen, déi änlech ausgesinn.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Opgepasst: Dës Adress imitéiert eng aner Websäit mat Buschtawen, déi änlech ausgesinn.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site konnt net opgemaach ginn.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe notéiert den Datum vun haut a seet Iech Bescheed, wann $sender weider schreift.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vun $sender ofmellen?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontaktéiert $site, fir Iech ofzemellen.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Dat ass deen eenzege Moment, wou Loupe d’Websäit vun engem Ofsender kontaktéiert. Et schéckt just „List-Unsubscribe=One-Click“ un d’Adress, déi $sender uginn huet, ouni Cookien oder soss eppes iwwer Iech, a luet d’Säit net.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Den Ofmeldlink ass keng sécher Adress um Internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site huet net rechtzäiteg geäntwert.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site war net z’erreechen.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site huet d’Ufro op eng aner Säit weidergeleet, där Loupe net follegt.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site huet d’Ufro refuséiert (Feeler $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Et gëtt kee Kont, vun deem d’Ofmeld-E-Mail geschéckt ka ginn.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe schéckt eng E-Mail un $to vun $from, mam Sujet „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Ofmeld-E-Mail un $address geschéckt.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender blockéieren?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nei Maile vun dëser Lëscht kommen an de Spam. Dir kënnt dat ënner Astellungen › Reegelen änneren.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nei Maile vun $address kommen an de Spam. Dir kënnt dat ënner Astellungen › Reegelen änneren.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender blockéiert.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count an de Spam verréckelen',
      one: '$count an de Spam verréckelen',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return '$sender blockéieren';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender ass elo bei den Newsletteren.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender ass elo bei den Diskussiounen.';
  }

  @override
  String get appLiveGateTitle => 'Är Konte konnten net opgemaach ginn';

  @override
  String get appLiveGateUnavailableBuild => 'Richteg Konte sinn an dësem Build nach net disponibel.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe konnt de Schlëssel net liesen, deen Är Mailen op dësem Handy schützt. Dat ass dacks just temporär: probéiert nach eng Kéier, oder start den Handy nei.';

  @override
  String get appLiveGateKeyMissing =>
      'De Schlëssel, deen Är Mailen op dësem Handy schützt, ass fort. Dat ka geschéien, nodeems eng Sécherheetskopie restauréiert gouf. Är Maile sinn nach um Server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'D’Mail-Datebank op dësem Handy kann net gelies ginn: si ass beschiedegt, oder hire Schlëssel huet geännert. Är Maile sinn nach um Server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Beim Opmaache vun Äre Konten ass eppes schifgaang ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Doduerch ginn Är Konten an d’Mailen, déi op dësem Handy gespäichert sinn, geläscht, och Messagen, déi am Ausgangsdossier waarden. Mailen op Äre Servere sinn net betraff; setzt Är Konten duerno nach eng Kéier derbäi.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Läschen an nei ufänken';

  @override
  String get appLiveGateUseDemo => 'Demo-Mail benotzen';

  @override
  String get appLiveGateReset => 'Mailen op dësem Handy zrécksetzen…';

  @override
  String get attachmentsUntitled => 'Unhang';

  @override
  String get attachmentsUntitledFile => 'Ouni Numm';

  @override
  String get attachmentsOpenIn => 'Opmaachen an…';

  @override
  String get attachmentsSaveToFiles => 'An de Fichiere späicheren';

  @override
  String get attachmentsShareMenu => 'Deelen…';

  @override
  String get attachmentsDownloadError =>
      'Den Unhang konnt net erofgeluede ginn. Iwwerpréift d’Verbindung a probéiert nach eng Kéier.';

  @override
  String get attachmentsShareError => 'Den Unhang konnt net gedeelt ginn.';

  @override
  String attachmentsNoApp(String type) {
    return 'Keng App op dësem Apparat mécht dëse Fichier op ($type). Probéiert amplaz „Deelen“.';
  }

  @override
  String get attachmentsOpenInError => 'Den Unhang konnt net an enger anerer App opgemaach ginn.';

  @override
  String attachmentsSaved(String name) {
    return '„$name“ gespäichert';
  }

  @override
  String get attachmentsSaveError => 'Den Unhang konnt net gespäichert ginn.';

  @override
  String get attachmentsGone => 'Dësen Unhang ass net méi disponibel.';

  @override
  String get attachmentsDownloadFailed => 'Den Unhang konnt net erofgeluede ginn.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Säiten', one: '$count Säit');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size iwwer mobil Donnéeën';
  }

  @override
  String get attachmentsLargeDownload => 'Dësen Unhang ass grouss. Luet en elo erof oder méi spéit iwwer WLAN.';

  @override
  String get attachmentsDownload => 'Eroflueden';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size gëtt erofgelueden…';
  }

  @override
  String get attachmentsDownloading => 'Gëtt erofgelueden…';

  @override
  String get attachmentsTooLarge => 'Ze grouss fir eng Virschau hei.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Et ginn déi éischt $shown vun $total gewisen. Kopéiert, deelt oder späichert den Unhang, fir alles ze kréien.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Dëse PDF kann hei net ugewise ginn (en ass méiglecherweis mat engem Passwuert geschützt).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page vun $count';
  }

  @override
  String get attachmentsModeTable => 'Tabell';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Message';

  @override
  String get attachmentsModeSource => 'Quelltext';

  @override
  String get attachmentsDontWrap => 'Zeilen net ëmbriechen';

  @override
  String get attachmentsWrap => 'Zeilen ëmbriechen';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines Zeilen', one: '$lines Zeil');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Alles kopéieren';

  @override
  String get attachmentsCopied => 'Kopéiert';

  @override
  String get attachmentsImageUnavailable => 'Dëst Bild kann hei net ugewise ginn. Probéiert „Opmaachen an…“.';

  @override
  String get attachmentsEmlNoSubject => '(Kee Sujet)';

  @override
  String get attachmentsEmlFrom => 'Vun';

  @override
  String get attachmentsEmlTo => 'Un';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Dëse Message huet keen Text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Unhäng: $names', one: 'Unhang: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organisateur: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An nach $count Evenementer',
      one: 'An nach $count Evenement',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Bild';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-Bild';
  }

  @override
  String get attachmentsTypePdf => 'PDF-Dokument';

  @override
  String get attachmentsTypeTsv => 'Duerch Tabulatore getrennte Wäerter';

  @override
  String get attachmentsTypeCsv => 'CSV-Tabell';

  @override
  String get attachmentsTypeCalendar => 'Kalennerevenement';

  @override
  String get attachmentsTypeEmail => 'E-Mail-Message';

  @override
  String get attachmentsTypeContact => 'Kontaktkaart';

  @override
  String get attachmentsTypeLog => 'Logfichier';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'ZIP-Archiv';

  @override
  String get attachmentsTypeArchive => 'Archiv';

  @override
  String get attachmentsTypeWord => 'Word-Dokument';

  @override
  String get attachmentsTypeExcel => 'Excel-Tabell';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-Presentatioun';

  @override
  String get attachmentsTypeWebPage => 'Websäit';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-Fichier';
  }

  @override
  String get attachmentsTypeFile => 'Fichier';

  @override
  String get calendarUntitledEvent => 'Evenement';

  @override
  String get calendarAllDay => 'De ganzen Dag';

  @override
  String calendarYourTime(String time) {
    return '$time Är Zäit';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Matmaachen: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name huet ugeholl: $details',
      'tentative': '$name huet provisoresch ugeholl: $details',
      'declined': '$name huet ofgeleent: $details',
      'delegated': '$name huet delegéiert: $details',
      'other': '$name huet net geäntwert op: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name huet d’Invitatioun ugeholl',
      'tentative': '$name huet d’Invitatioun provisoresch ugeholl',
      'declined': '$name huet d’Invitatioun ofgeleent',
      'delegated': '$name huet d’Invitatioun delegéiert',
      'other': '$name huet net op d’Invitatioun geäntwert',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kaart';

  @override
  String get calendarJoin => 'Matmaachen';

  @override
  String get calendarOnlineMeeting => 'Online-Reunioun';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-Reunioun';
  }

  @override
  String get calendarOrganizerYou => 'Dir';

  @override
  String get calendarOrganizerLabel => 'Organisateur';

  @override
  String get calendarStatusAccepted => 'Ugeholl';

  @override
  String get calendarStatusMaybe => 'Vläicht';

  @override
  String get calendarStatusDeclined => 'Ofgeleent';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name huet ugeholl',
      'tentative': '$name huet provisoresch ugeholl',
      'declined': '$name huet ofgeleent',
      'delegated': '$name huet delegéiert',
      'other': '$name huet net geäntwert',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name huet ugeholl:',
      'tentative': '$name huet provisoresch ugeholl:',
      'declined': '$name huet ofgeleent:',
      'delegated': '$name huet delegéiert:',
      'other': '$name huet net geäntwert:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name proposéiert eng nei Zäit';
  }

  @override
  String get calendarCounterUnknown => 'En Deelhueler proposéiert eng nei Zäit';

  @override
  String get calendarDeclineCounter => 'Den Organisateur huet d’Zäit behalen';

  @override
  String calendarRefresh(String name) {
    return '$name freet no der neister Versioun';
  }

  @override
  String get calendarRefreshUnknown => 'En Deelhueler freet no der neister Versioun';

  @override
  String get calendarCancelled => 'Ofgesot';

  @override
  String get calendarCancelledByOrganizer => 'Den Organisateur huet dëst Evenement ofgesot.';

  @override
  String get calendarCancelledLater => 'Dëst Evenement gouf duerno ofgesot.';

  @override
  String get calendarOutdated => 'Net méi aktuell';

  @override
  String get calendarOutdatedDetail => 'Dës Invitatioun gouf duerno aktualiséiert; déi méi nei gëllt.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Plaz ewechgeholl (war $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Plaz ewechgeholl (war keng)';

  @override
  String calendarLocationChanged(String location) {
    return 'Plaz geännert op $location';
  }

  @override
  String get calendarNewTitle => 'Neien Titel';

  @override
  String get calendarRepeatChanged => 'D’Widderhuelung huet geännert';

  @override
  String get calendarUpdated => 'Aktualiséiert';

  @override
  String get calendarUpdatedInvitation => 'Aktualiséiert Invitatioun';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Zäit geännert vun $before op $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Zäitzon „$zone“ onbekannt: Zäite wéi uginn';
  }

  @override
  String calendarNext(String when) {
    return 'Nächst: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Gäscht', one: '$count Gaascht');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count zougesot', one: '$count zougesot');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vläicht', one: '$count vläicht');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ofgesot', one: '$count ofgesot');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (Dir)';
  }

  @override
  String get calendarAttendeeOptional => 'optional';

  @override
  String get calendarAttendeeRoom => 'Sall';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Dir hutt eng méi fréi Versioun ugeholl.',
      'tentative': 'Dir hutt eng méi fréi Versioun provisoresch ugeholl.',
      'declined': 'Dir hutt eng méi fréi Versioun ofgeleent.',
      'delegated': 'Dir hutt eng méi fréi Versioun delegéiert.',
      'other': 'Dir hutt net op eng méi fréi Versioun geäntwert.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Unhuelen';

  @override
  String get calendarMaybe => 'Vläicht';

  @override
  String get calendarDecline => 'Ofleenen';

  @override
  String get calendarCommentHint => 'Kommentar fir den Organisateur (optional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Är Äntwert geet vun $address un $organizer.';
  }

  @override
  String get calendarAddComment => 'Kommentar derbäisetzen';

  @override
  String get calendarAddToCalendar => 'An de Kalenner setzen';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An nach $count Evenementer am Fichier',
      one: 'An nach $count Evenement am Fichier',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Et gëtt keng Kalenner-App, fir d’Evenement derbäizesetzen.';

  @override
  String get calendarCantOpenCalendar => 'De Kalenner konnt net opgemaach ginn.';

  @override
  String get calendarCantOpenLink => 'De Link konnt net opgemaach ginn.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Un der $provider-Reunioun deelhuelen?';
  }

  @override
  String get calendarJoinTitle => 'Un der Reunioun deelhuelen?';

  @override
  String calendarJoinOpens(String host) {
    return 'Mécht $host an Ärem Browser op.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Opgepasst: Dës Adress imitéiert $site mat Buschtawen, déi änlech ausgesinn.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Opgepasst: Dës Adress imitéiert eng aner Websäit mat Buschtawen, déi änlech ausgesinn.';

  @override
  String calendarJoinOpen(String host) {
    return '$host opmaachen';
  }

  @override
  String get calendarNoOrganizer => 'Dës Invitatioun huet keen Organisateur, deem een äntwerte kann.';

  @override
  String get calendarNoAccount => 'Et gëtt kee Kont, vun deem een äntwerte kann.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ugeholl',
      'tentative': 'Vläicht',
      'other': 'Ofgeleent',
    });
    return '$_temp0 · Äntwert un $name gëtt geschéckt…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ugeholl',
      'tentative': 'Vläicht',
      'other': 'Ofgeleent',
    });
    return '$_temp0 · Äntwert geschéckt';
  }

  @override
  String get calendarReplyAlreadySent => 'D’Äntwert gouf scho geschéckt.';

  @override
  String get calendarReplyNotSent => 'Äntwert net geschéckt.';

  @override
  String get dataSmimeNeedsDevice =>
      'Äert S/MIME-Zertifikat ass op dësem Apparat: Maacht Loupe op, fir dëse Message ze signéieren an ze schécken.';

  @override
  String dataSigningFailed(String error) {
    return 'Signéieren huet net geklappt: $error';
  }

  @override
  String get keyboardShortcuts => 'Tastaturkierzelen';

  @override
  String get keyboardGroupGeneral => 'Allgemeng';

  @override
  String get keyboardGroupMessages => 'Messagen';

  @override
  String get keyboardGroupCompose => 'Schreiwen';

  @override
  String get keyboardCommandPalette => 'Kommandopalette';

  @override
  String get keyboardBackClose => 'Zréck, Zoumaachen';

  @override
  String get keyboardNextMessage => 'Nächste Message';

  @override
  String get keyboardPreviousMessage => 'Virege Message';

  @override
  String get keyboardOpenMessage => 'Message opmaachen';

  @override
  String get keyboardMoveToTrash => 'An de Pabeierkuerf verréckelen';

  @override
  String get keyboardToggleRead => 'Als gelies oder ongelies markéieren';

  @override
  String get keyboardToggleFlag => 'Markéieren oder Markéierung ewechhuelen';

  @override
  String get keyboardCloseDraft => 'Zoumaachen (Entworf späicheren oder läschen)';

  @override
  String get keyboardOr => 'oder';

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
  String get mailingListsMuted => 'Thread stommgeschalt. Nei Messagen dra kommen als gelies un.';

  @override
  String get mailingListsUnmuted => 'Stommschaltung vum Thread opgehuewen.';

  @override
  String get mailingListsMuteThread => 'Thread stommschalten';

  @override
  String get mailingListsUnmuteThread => 'Stommschaltung ophiewen';

  @override
  String get mailingListsPin => 'Un d’Mailboxe fixéieren';

  @override
  String get mailingListsUnpin => 'Vun de Mailboxe lassmaachen';

  @override
  String get mailingListsDefaultView => 'An der Standardusiicht opmaachen';

  @override
  String get mailingListsPlainText => 'Als rengen Text opmaachen (Mono)';

  @override
  String get mailingListsShowMuted => 'Stommgeschalt Threads weisen';

  @override
  String get mailingListsHideMuted => 'Stommgeschalt Threads verstoppen';

  @override
  String get mailingListsTreatAsNewsletter => 'Als Newsletter behandelen';

  @override
  String get mailingListsOptions => 'Lëschtenoptiounen';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted ongelies',
      one: '$formatted ongelies',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Neie Message un d’Lëscht';

  @override
  String get mailingListsRowUnread => 'Ongelies';

  @override
  String get mailingListsRowMuted => 'Stommgeschalt';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Äntwerten', one: '$count Äntwert');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Keng Threads';

  @override
  String get mailingListsMutedHidden => 'Stommgeschalt Threads si verstoppt.';

  @override
  String get mailingListsTechnicalTitle => 'Technesch Lëschten';

  @override
  String get mailingListsTechnicalEmpty => 'Mailinglëschten erschéngen hei, soubal hir Mailen ukommen.';

  @override
  String get mailingListsTechnicalFooter =>
      'Message vun dëse Lëschte ginn als rengen Text an enger Schrëft mat fixer Breet op, Patche ginn als Diffen ugewisen. Mam Aa-Knäppche kann een trotzdeem all Message ëmschalten.';

  @override
  String get paletteMoveToMailbox => 'An eng Mailbox verréckelen…';

  @override
  String get paletteMarkAllRead => 'All als gelies markéieren';

  @override
  String get paletteExportFolder => 'Dossier exportéieren…';

  @override
  String get paletteGetNewMail => 'Nei Mailen ofruffen';

  @override
  String get paletteSnoozed => 'Zréckgestallt';

  @override
  String get paletteSubscriptions => 'Abonnementer';

  @override
  String get paletteDiscussions => 'Diskussiounen';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailinglëscht';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Wëschgesten';

  @override
  String get paletteNotifications => 'Notifikatiounen';

  @override
  String get paletteRules => 'Reegelen';

  @override
  String get paletteEncryption => 'End-zu-End-Verschlësselung';

  @override
  String get paletteAdvanced => 'Erweidert';

  @override
  String get paletteAddAccount => 'Kont derbäisetzen';

  @override
  String get paletteAccount => 'Kont';

  @override
  String get paletteFolders => 'Dossieren';

  @override
  String get paletteRecentSearch => 'Rezent Sich';

  @override
  String paletteSearchMail(String query) {
    return 'Mailen no „$query“ duerchsichen';
  }

  @override
  String get palettePlaceholder => 'Aktiounen, Mailboxen, Astellunge sichen';

  @override
  String get paletteNothingFound => 'Näischt fonnt';

  @override
  String get searchNewSmartMailbox => 'Nei Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Weist alles, wat op „$query“ passt.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ an de Mailboxe gespäichert';
  }

  @override
  String get searchMakeRule => 'Doraus eng Reegel maachen';

  @override
  String get searchSaveSmartMailbox => 'Als Smart Mailbox späicheren';

  @override
  String get searchNegate => 'Ëmdréinen';

  @override
  String get searchDontNegate => 'Net ëmdréinen';

  @override
  String get searchAllMailboxes => 'All Mailboxen';

  @override
  String get searchRecent => 'Rezent Sichen';

  @override
  String get searchClear => 'Läschen';

  @override
  String get searchSuggestions => 'Virschléi';

  @override
  String get searchUnreadMessages => 'Ongeliese Messagen';

  @override
  String get searchFlaggedMessages => 'Markéiert Messagen';

  @override
  String get searchWithAttachments => 'Message mat Unhäng';

  @override
  String get searchUnrepliedMessages => 'Net beäntwert Messagen';

  @override
  String get searchTags => 'Tags';

  @override
  String get searchPeople => 'Persounen';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Vun: $name';
  }

  @override
  String get searchSearching => 'Sich leeft…';

  @override
  String get searchNoResults => 'Keng Resultater';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted Resultater',
      one: '$formatted Resultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Sichmenü';

  @override
  String searchSearchingAccount(String account) {
    return '$account gëtt um Server duerchsicht…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Kont gëtt um Server duerchsicht…';

  @override
  String searchAccountFailed(String account) {
    return '$account konnt um Server net duerchsicht ginn';
  }

  @override
  String get searchUnknownAccountFailed => 'Kont konnt um Server net duerchsicht ginn';

  @override
  String searchChip(String term) {
    return '$term. Duebel tippe fir z’änneren.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Net $term. Duebel tippe fir z’änneren.';
  }

  @override
  String get searchReadAndUnread =>
      'Dem Schrödinger seng Inbox: All Message hei ass gelies an ongelies, bis Dir en opmaacht.';

  @override
  String searchContradiction(String term) {
    return 'Kee Message ka gläichzäiteg „$term“ an net „$term“ sinn.';
  }

  @override
  String get searchSyncDeviceOnly => 'Nëmmen op dësem Apparat';

  @override
  String searchSyncUnsupported(String account) {
    return 'Nëmmen op dësem Apparat: $account ka se net späicheren';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Net synchroniséiert: $account huet e méi neit Format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Waart op d’Synchronisatioun mat $account';
  }

  @override
  String searchSynced(String account) {
    return 'Mat $account synchroniséiert';
  }

  @override
  String get searchRename => 'Ëmbenennen';

  @override
  String get searchEditSearch => 'Sich änneren';

  @override
  String get searchDeleteSmartMailbox => 'Smart Mailbox läschen';

  @override
  String get searchRenameSmartMailbox => 'Smart Mailbox ëmbenennen';

  @override
  String get searchSmartMailboxDeleted => 'Dës Smart Mailbox gouf geläscht.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes bleiwen op dësem Apparat.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes ginn op Ärem Mailserver gespäichert, sou datt Är aner Apparater se och hunn, an och Thunderbird mat Expression Search Reloaded. Déi, déi all Konten duerchsichen, leien op $account; déi vun engem eenzegen Dossier op dem Kont vun deem Dossier.';
  }

  @override
  String get searchSyncVia => 'Synchroniséieren iwwer';

  @override
  String get searchSyncViaFooter => 'Wielt op all Apparat dee selwechte Kont.';

  @override
  String get searchGmailCantKeep => 'Gmail ka keng Smart Mailboxes späicheren';

  @override
  String get searchKeepOnDevice => 'Smart Mailboxes nëmmen op dësem Apparat halen';

  @override
  String get searchOnTheServer => 'Um Server';

  @override
  String get searchServerFooter =>
      'Server-Metadaten (IMAP METADATA) ginn a kenger Mail-App ugewisen. Serveren ouni dës Funktioun kréien en Dossier „Loupe Settings“ mat engem Message; Loupe verstoppt en an de Mailboxen.';

  @override
  String get searchSyncNow => 'Elo synchroniséieren';

  @override
  String get searchStateUnsupported => 'Net ënnerstëtzt';

  @override
  String get searchStateNewerFormat => 'Méi neit Format';

  @override
  String get searchStateFailed => 'Synchronisatioun huet net geklappt';

  @override
  String get searchStateSyncing => 'Gëtt synchroniséiert…';

  @override
  String get searchStateWaiting => 'Waart';

  @override
  String get searchStateMetadata => 'Server-Metadaten';

  @override
  String get searchStateFolder => 'Dossier „Loupe Settings“';

  @override
  String get searchStateNothing => 'Näischt gespäichert';

  @override
  String get sharedBack => 'Zréck';

  @override
  String get sharedYesterday => 'Gëschter';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date um $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Byte', one: '$count Byte');
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
  String get sharedSyncNoAccounts => 'Keng Konten';

  @override
  String get sharedSyncChecking => 'Kucke no Mailen…';

  @override
  String get sharedSyncFailed => 'Maile konnten net ofgeruff ginn';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Elo grad aktualiséiert';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Viru $minutes Minutten aktualiséiert',
      one: 'Viru $minutes Minutt aktualiséiert',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Um $time aktualiséiert';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Den $date aktualiséiert';
  }

  @override
  String get sharedMailboxAllInboxes => 'All Inboxen';

  @override
  String get sharedMailboxUnread => 'Ongelies';

  @override
  String get sharedMailboxFlagged => 'Markéiert';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'All Entwërf';

  @override
  String get sharedMailboxAllSent => 'All geschéckt';

  @override
  String get sharedMailboxUntitled => 'Mailbox';

  @override
  String get sharedTagImportant => 'Wichteg';

  @override
  String get sharedTagWork => 'Aarbecht';

  @override
  String get sharedTagPersonal => 'Perséinlech';

  @override
  String get sharedTagToDo => 'Ze maachen';

  @override
  String get sharedTagLater => 'Méi spéit';

  @override
  String get sharedTags => 'Tags';

  @override
  String get sharedMoveTo => 'Verréckelen an…';

  @override
  String get sharedNoRecipients => 'Keng Empfänger';

  @override
  String get sharedUnknownSender => 'Onbekannten Ofsender';

  @override
  String get sharedOnServer => 'Um Server';

  @override
  String get sharedAttachment => 'Unhang';

  @override
  String get sharedSnoozedBadge => 'Zréckgestallt';

  @override
  String get sharedRowUnread => 'Ongelies';

  @override
  String get sharedRowBackFromSnooze => 'Zréck aus dem Zréckstellen';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Markéiert';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen archivéiert',
      one: '$count Message archivéiert',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Message geläscht',
      one: '$count Message geläscht',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen an d’Inbox verréckelt',
      one: '$count Message an d’Inbox verréckelt',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen an de Pabeierkuerf verréckelt',
      one: '$count Message an de Pabeierkuerf verréckelt',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen an de Spam verréckelt',
      one: '$count Message an de Spam verréckelt',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen an $mailbox verréckelt',
      one: '$count Message an $mailbox verréckelt',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen an eng Mailbox verréckelt',
      one: '$count Message an eng Mailbox verréckelt',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Message bis $time zréckgestallt',
      one: '$count Message bis $time zréckgestallt',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Nëmmen op dësem Apparat bis $time zréckgestallt: De Server ka keng Zäite fir d’Zréckstelle späicheren.';
  }

  @override
  String get sharedMoveOneAccount => 'Wielt Messagen aus engem Kont aus, fir se ze verréckelen.';

  @override
  String get sharedSnoozeTitle => 'Zréckstellen';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Zäitpunkt änneren';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messagen definitiv läschen?',
      one: 'Dëse Message definitiv läschen?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Dat kann net réckgängeg gemaach ginn.';

  @override
  String get sharedDeletePermanently => 'Definitiv läschen';

  @override
  String get sharedSwipeRead => 'Gelies';

  @override
  String get sharedSwipeUnread => 'Ongelies';

  @override
  String get sharedSwipeInbox => 'Inbox';

  @override
  String get sharedSwipeDelete => 'Läschen';

  @override
  String get sharedTrash => 'Pabeierkuerf';

  @override
  String get sharedSwipeSnooze => 'Zréckstellen';

  @override
  String get sharedWakeNow => 'Elo zréckhuelen';

  @override
  String get sharedChangeSnoozeTime => 'Zäitpunkt änneren…';

  @override
  String get sharedSnooze => 'Zréckstellen…';

  @override
  String get sharedTag => 'Taggen…';

  @override
  String get sharedMoveMessage => 'Message verréckelen…';

  @override
  String get sharedNotJunk => 'Kee Spam';

  @override
  String get accountSetupTitle => 'Kont derbäisetzen';

  @override
  String get accountSetupTitleDone => 'Kont derbäigesat';

  @override
  String get accountSetupAddressTitle => 'Mailkont derbäisetzen';

  @override
  String get accountSetupAddressText => 'Loupe fënnt d’Astellunge fir déi meescht Provideren.';

  @override
  String get accountSetupNameHint => 'Ären Numm';

  @override
  String get accountSetupEmail => 'E-Mail';

  @override
  String get accountSetupEmailHint => 'numm@example.com';

  @override
  String get accountSetupContinue => 'Weider';

  @override
  String get accountSetupLookingUp => 'Astellunge gi gesicht…';

  @override
  String get accountSetupImport => 'Aus Thunderbird importéieren';

  @override
  String get accountSetupInvalidEmail => 'Gitt eng gëlteg E-Mail-Adress an.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Fir $domain goufe keng Astellunge fonnt. Gitt se hei ënnen an.';
  }

  @override
  String get accountSetupCheckServers => 'Iwwerpréift d’Servernimm an d’Ports.';

  @override
  String get accountSetupEnterPassword => 'Gitt Äert Passwuert an.';

  @override
  String get accountSetupConnecting => 'Verbindung gëtt hiergestallt…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Waarden op $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'D’Säit konnt net opgemaach ginn.';

  @override
  String get accountSetupCouldNotSaveName => 'Den Numm konnt net gespäichert ginn.';

  @override
  String get accountSetupTrustCertificate => 'Dësem Zertifikat vertrauen';

  @override
  String get accountSetupPasswordRequired => 'Obligatoresch';

  @override
  String get accountSetupShowPassword => 'Passwuert weisen';

  @override
  String get accountSetupHidePassword => 'Passwuert verstoppen';

  @override
  String get accountSetupAppPassword => 'App-Passwuert';

  @override
  String get accountSetupApiToken => 'API-Token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Erakommend · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Erausgoend · SMTP';

  @override
  String get accountSetupSignIn => 'Umellen';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Mat $provider umellen';
  }

  @override
  String get accountSetupUseAppPassword => 'App-Passwuert benotzen';

  @override
  String get accountSetupUseAppPasswordInstead => 'Amplaz en App-Passwuert benotzen';

  @override
  String get accountSetupUseDifferentAddress => 'Aner Adress benotzen';

  @override
  String get accountSetupHowToCreateAppPassword => 'Wéi een en App-Passwuert mécht';

  @override
  String get accountSetupHowToCreateOne => 'Wéi een et mécht';

  @override
  String get accountSetupGoogleNote =>
      'Dir mellt Iech op der Säit vu Google un, a Loupe gesäit Äert Passwuert ni. Erlaabt Loupe, Är Mailen ze liesen, ze schécken an ze organiséieren.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Mat Google umellen“ ass an dësem Build nach net disponibel. Dir kënnt Iech amplaz mat engem App-Passwuert verbannen (dofir brauch Äre Google-Kont 2-Step Verification).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Maacht an Ärem Google-Kont en App-Passwuert a fügt et hei ënnen an.';

  @override
  String get accountSetupMicrosoftNote =>
      'Dir mellt Iech op der Säit vu Microsoft un, a Loupe gesäit Äert Passwuert ni. Dat funktionéiert fir Outlook.com an Hotmail, a fir Aarbechts- oder Schoulkonten op Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'D’Umeldung mat Microsoft kënnt an engem spéidere Build. Outlook-, Hotmail- a Microsoft-365-Konte brauche se: si akzeptéiere keng Passwierder vu Mail-Apps méi.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail brauch en App-spezifescht Passwuert, net d’Passwuert vun Ärem Apple Account.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail brauch en App-Passwuert, net d’Passwuert vun Ärem Kont.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe verbënnt sech iwwer JMAP mat engem API-Token mat Fastmail: Settings › Privacy & Security › Manage API tokens, fir JMAP, mat Zougrëff op E-Mail a Schécken.';

  @override
  String get accountSetupFastmailNote => 'Fastmail brauch fir Mail-Apps en App-Passwuert.';

  @override
  String get accountSetupServerSettings => 'Serverastellungen';

  @override
  String get accountSetupSettingsNotFound => 'Net automatesch fonnt';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Fonnt iwwer $source';
  }

  @override
  String get accountSetupEditSettings => 'Astellungen änneren';

  @override
  String get accountSetupSyncing => 'Är Maile gi synchroniséiert.';

  @override
  String get accountSetupDescription => 'Beschreiwung';

  @override
  String get accountSetupDescriptionHint => 'Aarbecht, Privat…';

  @override
  String get accountSetupColour => 'Faarf';

  @override
  String accountSetupColourNumber(int number) {
    return 'Faarf $number';
  }

  @override
  String get accountSetupSaving => 'Gëtt gespäichert…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe konnt seng Mail-Datebank op dësem Handy net opmaachen. Maacht Loupe zou, maacht et erëm op a probéiert nach eng Kéier.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Eppes ass schifgaang ($error). Probéiert nach eng Kéier.';
  }

  @override
  String get accountSetupSecurityNone => 'Keng';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sécherheet';

  @override
  String get accountSetupUsername => 'Benotzernumm';

  @override
  String get accountSetupUsernameHint => 'Är E-Mail-Adress';

  @override
  String get accountSetupNoEncryptionTitle => 'Ouni Verschlësselung verbannen?';

  @override
  String get accountSetupNoEncryptionText =>
      'Äert Passwuert an all Message géifen als Kloertext iwwerdroe ginn. Jiddereen am Netzwierk, zum Beispill an engem ëffentleche WLAN, kéint se liesen. Benotzt dat nëmme fir e Server an Ärem eegenen Netzwierk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Ouni Verschlësselung benotzen';

  @override
  String get accountSetupApiTokenRejected =>
      'API-Token refuséiert. Maacht e Fastmail-API-Token fir JMAP mat Zougrëff op E-Mail a fügt en an.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Passwuert refuséiert. Benotzt en App-Passwuert, net d’Passwuert vun Ärem Kont.';

  @override
  String get accountSetupPasswordRejected => 'Passwuert refuséiert. Iwwerpréift et a probéiert nach eng Kéier.';

  @override
  String get accountSetupServerUnreachable =>
      'Server net z’erreechen. Iwwerpréift d’Serverastellungen an Är Verbindung.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Dem Zertifikat vum Server gëtt net vertraut. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'D’Umeldung gouf ofgebrach. Tippt op „Mat $provider umellen“, fir et nach eng Kéier ze probéieren.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe brauch d’Erlaabnes, Äre Gmail ze liesen an ze schécken. Mellt Iech nach eng Kéier un an erlaabt den Zougrëff, mat ugekräizter Gmail-Këscht.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe brauch d’Erlaabnes, Är Mailen ze liesen an ze schécken. Mellt Iech nach eng Kéier un an akzeptéiert d’Rechter.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Är Organisatioun muss Loupe guttheeschen, ier Dir et mat dësem Kont benotze kënnt. Frot Ären IT-Administrateur, a Microsoft Entra ID d’Administrateur-Zoustëmmung fir Loupe ze ginn, a probéiert et dann nach eng Kéier.';

  @override
  String get accountSetupOAuthBlocked =>
      'D’Umeldreegele vun Ärer Organisatioun erlabe Loupe net op dësem Apparat. Frot Ären IT-Administrateur.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider war net z’erreechen. Iwwerpréift Är Internetverbindung a probéiert nach eng Kéier.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'D’Umeldung mat $provider ass an dëser Versioun vu Loupe net richteg ageriicht. Mellt dat w.e.g.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'D’Umeldung mat $provider huet net geklappt. Probéiert nach eng Kéier.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider huet Iech ugemellt, mee Gmail huet den Zougrëff fir dës Adress refuséiert. Wielt beim Umellen dee selwechte Kont. Bei Aarbechts- oder Schoulkonten huet den Administrateur IMAP méiglecherweis ausgeschalt.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider huet Iech ugemellt, mee de Mailserver huet den Zougrëff fir dës Adress refuséiert. Wielt beim Umellen dee selwechte Kont. Bei Aarbechts- oder Schoulkonten huet den Administrateur IMAP méiglecherweis ausgeschalt.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'De Mailserver ass net z’erreechen. Iwwerpréift Är Verbindung a probéiert nach eng Kéier.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'D’Umeldung mat $provider ass an dëser Versioun net disponibel.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Erëm ugemellt. $account gëtt synchroniséiert.';
  }

  @override
  String get accountSetupSignInAgain => 'Nach eng Kéier umellen';

  @override
  String get accountSetupSigningIn => 'Umeldung leeft…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider akzeptéiert d’Umeldung vu Loupe fir $email net méi, dofir gëtt $account net synchroniséiert. Mellt Iech nach eng Kéier un, fir d’Mailen ze kréien.';
  }

  @override
  String get accountImportTitle => 'Aus Thunderbird importéieren';

  @override
  String get accountImportPointCamera => 'Riicht d’Kamera op de QR-Code, deen Thunderbird weist.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned vun $total gescannt';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned vun $total Code gescannt',
      one: '$scanned vun $total Code gescannt',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bis elo $count Konten',
      one: 'Bis elo $count Kont',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Maacht op Ärem Computer Thunderbird op a wielt Tools › Export for Mobile. Wielt Är Konten aus a scannt dann all Code, deen ugewise gëtt. D’Code kënnen an all Reiefolleg gescannt ginn.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mat $count Konte weidermaachen',
      one: 'Mat $count Kont weidermaachen',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Amplaz Text afügen';

  @override
  String get accountImportStartOver => 'Nei ufänken';

  @override
  String get accountImportDuplicateCode => 'Dëse Code gouf schonn derbäigesat.';

  @override
  String get accountImportRestarted =>
      'Dëse Code ass vun engem neien Export, dofir goufen déi virdru gescannte Coden op d’Säit geluecht.';

  @override
  String get accountImportNotThunderbird => 'Dat ass kee Thunderbird-Kontcode.';

  @override
  String get accountImportNewerVersion =>
      'Dëse Code kënnt vun engem méi neien Thunderbird. Aktualiséiert Loupe, fir en z’importéieren.';

  @override
  String get accountImportDamaged => 'Dëse Thunderbird-Code konnt net gelies ginn.';

  @override
  String get accountImportTooLarge => 'Dëse Code ass ze grouss fir en Thunderbird-Export.';

  @override
  String get accountImportCouldNotOpenSettings => 'D’Astellunge konnten net opgemaach ginn.';

  @override
  String get accountImportCameraOffTitle => 'Kamerazougrëff ass aus';

  @override
  String get accountImportCameraOffText =>
      'Erlaabt Loupe an den Astellungen, d’Kamera ze benotzen, fir de Code ze scannen, oder fügt amplaz den Text vum Code an.';

  @override
  String get accountImportNoCameraTitle => 'Keng Kamera';

  @override
  String get accountImportNoCameraText => 'Loupe ka keng Kamera hei benotzen. Fügt amplaz den Text vum Code an.';

  @override
  String get accountImportCameraFailedTitle => 'D’Kamera ass net ugaangen';

  @override
  String get accountImportCameraFailedText => 'Probéiert nach eng Kéier, oder fügt amplaz den Text vum Code an.';

  @override
  String get accountImportOpenSettings => 'Astellungen opmaachen';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konte fonnt',
      one: '$count Kont fonnt',
      zero: 'Keng Konte fonnt',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Keen eenzege Kont an dëse Code konnt gelies ginn.';

  @override
  String get accountImportChoose => 'Wielt d’Konten aus, déi bei Loupe derbäigesat solle ginn.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'D’Coden $codes vun $total goufen net gescannt, dofir sinn hir Konten net opgelëscht.',
      one: 'Code $codes vun $total gouf net gescannt, dofir si seng Konten net opgelëscht.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes an $last';
  }

  @override
  String get accountImportScanMore => 'Méi Code scannen';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Konten an de Code konnten net gelies ginn. Si benotze méiglecherweis Astellunge vun engem méi neien Thunderbird.',
      one:
          '$count Kont an de Code konnt net gelies ginn. E benotzt méiglecherweis Astellunge vun engem méi neien Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Nach eng Kéier scannen';

  @override
  String get accountImportAlreadyAdded => 'E Kont mat dëser Adress ass schonn a Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Dir mellt Iech nom Derbäisetze mat $provider un, wéi an Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Setzt de Kont mat engem App-Passwuert derbäi (dofir brauch een 2-Step Verification).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird mellt sech bei Gmail mat Google un. „Mat Google umellen“ kënnt an engem spéidere Build; bis dohin setzt de Kont mat engem App-Passwuert derbäi (dofir brauch een 2-Step Verification).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird mellt sech bei dësem Kont am Browser un. Loupe kann dat nach net: benotzt en App-Passwuert, wann Äre Provider eent ubitt.';

  @override
  String get accountImportUnencrypted =>
      'Verbënnt sech ouni Verschlësselung. Benotzt dat nëmmen an Ärem eegenen Netzwierk.';

  @override
  String get accountImportEnterAgain => 'Nach eng Kéier aginn';

  @override
  String get accountImportAdded => 'Derbäigesat';

  @override
  String accountImportAdding(int index, int total) {
    return '$index vun $total gëtt derbäigesat…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten derbäisetzen',
      one: '$count Kont derbäisetzen',
      zero: 'Konten derbäisetzen',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Exporttext afügen';

  @override
  String get accountImportPasteText => 'Fügt den Text vun engem Thunderbird-Exportcode an, ee Code pro Zeil.';

  @override
  String get accountImportPop3 => 'POP3-Konte ginn net ënnerstëtzt. Loupe léisst d’Maile mat IMAP um Server.';

  @override
  String get accountImportKerberos => 'Dëse Kont mellt sech mat Kerberos un, wat Loupe net ënnerstëtzt.';

  @override
  String get accountImportNtlm => 'Dëse Kont mellt sech mat NTLM un, wat Loupe net ënnerstëtzt.';

  @override
  String get accountImportClientCertificate =>
      'Dëse Kont mellt sech mat engem Client-Zertifikat un, wat Loupe nach net ënnerstëtzt.';

  @override
  String get accountImportMicrosoftSignIn =>
      'D’Umeldung mat Microsoft kënnt an engem spéidere Build. Outlook- a Microsoft-365-Konten akzeptéiere keng Passwierder vu Mail-Apps méi.';

  @override
  String get accountImportEnterPassword => 'Gitt d’Passwuert an.';

  @override
  String get accountImportEnterAppPassword => 'Gitt d’App-Passwuert an.';

  @override
  String get accountImportEnterApiToken => 'Gitt den API-Token an.';

  @override
  String get accountImportStorageFailed =>
      'Loupe konnt säi Kontespäicher net opmaachen. Probéiert méi spéit nach eng Kéier.';

  @override
  String get accountImportFailed =>
      'De Kont konnt net derbäigesat ginn. Probéiert nach eng Kéier, oder setzt e manuell derbäi.';

  @override
  String get composeNewMessageTitle => 'Neie Message';

  @override
  String get composeAttach => 'Uhänken';

  @override
  String get composeSendLater => 'Méi spéit schécken';

  @override
  String composeSendAt(String time) {
    return '$time schécken';
  }

  @override
  String get composeSendHint => 'Laang drécken, fir méi spéit ze schécken';

  @override
  String get composeNoAccount => 'Setzt e Kont derbäi, fir Mailen ze schécken.';

  @override
  String get composeTo => 'Un:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Vun: $email';
  }

  @override
  String get composeFromLabel => 'Vun:';

  @override
  String get composeSubjectLabel => 'Sujet:';

  @override
  String composeReplyTo(String address) {
    return 'Äntwert un: $address';
  }

  @override
  String get composeFrom => 'Vun';

  @override
  String composeReplyFrom(String email) {
    return 'Vun $email äntweren';
  }

  @override
  String composeSendFrom(String email) {
    return 'Vun $email schécken';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vun $email äntweren?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Vun $email schécken?';
  }

  @override
  String get composeDismiss => 'Verstoppen';

  @override
  String composeAliasNotSaved(String account) {
    return 'Net als Identitéit gespäichert · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Als Identitéit späicheren';

  @override
  String composeAliasSaved(String email) {
    return '$email ass als Identitéit gespäichert.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ongëlteg Adress $address';
  }

  @override
  String get composeOriginalNotFound => 'Den originale Message gouf net fonnt.';

  @override
  String get composeDraftNotFound => 'Den Entworf gouf net fonnt.';

  @override
  String get composeAttachmentsLost => 'D’Unhäng konnten net restauréiert ginn. Setzt se nach eng Kéier derbäi.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Verschidden Unhäng konnten net derbäigesat ginn: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'D’Unhäng sinn zesummen $size grouss; verschidde Servere refuséiere sou grouss Messagen.';
  }

  @override
  String get composeAttachFailed => 'De Fichier konnt net ugehaange ginn.';

  @override
  String get composeInvalidAddressTitle => 'Ongëlteg Adress';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ ass keng gëlteg E-Mail-Adress.';
  }

  @override
  String get composeNoSubjectTitle => 'Kee Sujet';

  @override
  String get composeNoSubjectText => 'Dëse Message huet kee Sujet. Trotzdeem schécken?';

  @override
  String get composeSentBeforeChanges => 'E gouf virun Ären Ännerunge geschéckt; déi sinn an den Entwërf gespäichert.';

  @override
  String composeScheduled(String time) {
    return 'Geplangt fir $time';
  }

  @override
  String get composeSending => 'Gëtt geschéckt…';

  @override
  String get composeSent => 'Geschéckt';

  @override
  String get composeSendFailed => 'Schécken huet net geklappt. Probéiert nach eng Kéier.';

  @override
  String get composeAlreadySent => 'Scho geschéckt.';

  @override
  String get composeDiscardChanges => 'Ännerunge verwerfen';

  @override
  String get composeSaveChanges => 'Ännerunge späicheren';

  @override
  String get composeDeleteDraft => 'Entworf läschen';

  @override
  String get composeSaveDraft => 'Entworf späicheren';

  @override
  String get composeDraftSaved => 'Entworf gespäichert';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Den $date um $time huet $name geschriwwen:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Den $date um $time huet een geschriwwen:';
  }

  @override
  String get composeForwardHeader => '---------- Weidergeleete Message ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Vun: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date um $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Sujet: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Un: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Méi spéit haut';

  @override
  String get composeTomorrowMorning => 'Muer de Moien';

  @override
  String get composeMondayMorning => 'Méindeg de Moien';

  @override
  String get composePickDateTime => 'Datum an Zäit wielen…';

  @override
  String get composeSendWithoutDelay => 'Ouni Verzögerung schécken';

  @override
  String composeSendTimeToday(String time) {
    return 'Haut um $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Muer um $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day um $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Haut $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Muer $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Entworf weider änneren?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'E Message gouf net geschéckt, wéi Loupe zougemaach gouf.',
      'one': 'E Message un $name gouf net geschéckt, wéi Loupe zougemaach gouf.',
      'other': 'E Message un $name an anerer gouf net geschéckt, wéi Loupe zougemaach gouf.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject“ gouf net geschéckt, wéi Loupe zougemaach gouf.',
      'one': '„$subject“ un $name gouf net geschéckt, wéi Loupe zougemaach gouf.',
      'other': '„$subject“ un $name an anerer gouf net geschéckt, wéi Loupe zougemaach gouf.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Weider änneren';

  @override
  String get composeRecoverySave => 'An den Entwërf späicheren';

  @override
  String get composeRecoveryDiscard => 'Verwerfen';

  @override
  String get composeRecoverySaved => 'An den Entwërf gespäichert';

  @override
  String get outboxSectionFailed => 'Net geschéckt';

  @override
  String get outboxSectionSending => 'Gëtt geschéckt';

  @override
  String get outboxSectionScheduled => 'Geplangt';

  @override
  String get outboxStatusQueued => 'Gëtt geschwënn geschéckt';

  @override
  String get outboxStatusSending => 'Gëtt geschéckt…';

  @override
  String get outboxStatusFailed => 'Net geschéckt';

  @override
  String get outboxNoRecipients => 'Keng Empfänger';

  @override
  String get outboxNoSubject => '(Kee Sujet)';

  @override
  String get outboxSendingFailed => 'Schécken huet net geklappt.';

  @override
  String get outboxEmptyTitle => 'Näischt ze schécken';

  @override
  String get outboxEmptyText => 'Messagen, déi Dir méi spéit schéckt, waarden hei, bis et sou wäit ass.';

  @override
  String get outboxSendNow => 'Elo schécken';

  @override
  String get outboxReschedule => 'Nei plangen';

  @override
  String get outboxRescheduleMenu => 'Nei plangen…';

  @override
  String get outboxRescheduleTitle => 'Nei plangen';

  @override
  String outboxRescheduled(String time) {
    return 'Nei geplangt fir $time';
  }

  @override
  String get outboxCancel => 'Ofbriechen';

  @override
  String get outboxCancelSending => 'Schécken ofbriechen…';

  @override
  String get outboxCancelTitle => 'Schécken ofbriechen?';

  @override
  String get outboxMoveToDrafts => 'An d’Entwërf verréckelen';

  @override
  String get outboxDiscard => 'Message verwerfen';

  @override
  String get outboxMovedToDrafts => 'An d’Entwërf verréckelt';

  @override
  String get outboxDiscarded => 'Message verworf';

  @override
  String get outboxAlreadySent => 'Scho geschéckt.';

  @override
  String get outboxBeingSent => 'Dëse Message gëtt elo grad geschéckt.';

  @override
  String get outboxActionFailed => 'Dat huet net geklappt. De Message ass nach am Ausgangsdossier.';

  @override
  String get notificationsBadgeInboxes => 'Ongelies an den Inboxen';

  @override
  String get notificationsBadgeVip => 'Ongelies a VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nei Maile vun Äre VIPs, an all Kont';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nei Mailen an $email';
  }

  @override
  String get notificationsUnknownSender => 'Onbekannten Ofsender';

  @override
  String get notificationsNoSubject => '(Kee Sujet)';

  @override
  String get notificationsEncryptedMessage => 'Verschlësselte Message';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Neie Message vun $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nei Messagen',
      one: '$count neie Message',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nei Messagen an $account';
  }

  @override
  String get platformInstantChannel => 'Direkt Zoustellung';

  @override
  String get platformInstantChannelDescription => 'Gëtt ugewisen, wärend Loupe Är Inboxen op nei Maile kontrolléiert';

  @override
  String get platformInstantTitle => 'Waart op nei Mailen';

  @override
  String get platformInstantText => 'Direkt Zoustellung ass un';

  @override
  String get platformErrorBox => 'Beim Uweisen ass eppes schifgaang. Gitt zréck a probéiert nach eng Kéier.';

  @override
  String get welcomeTagline => 'Mail, déi baussen einfach\na banne staark ass.';

  @override
  String get welcomeAccountsTitle => 'All Konten, eng roueg Inbox';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail an all IMAP- oder JMAP-Server.';

  @override
  String get welcomeSearchTitle => 'Eng Sich, déi fënnt';

  @override
  String get welcomeSearchText => 'Direkt Resultater op Ärem Handy, duerno déi vum Server.';

  @override
  String get welcomePrivacyTitle => 'Privat vun Ufank un';

  @override
  String get welcomePrivacyText => 'Keen Tracking. Extern Biller bleiwe blockéiert, bis Dir et sot.';

  @override
  String get welcomeAddAccount => 'Kont derbäisetzen';

  @override
  String get welcomeImport => 'Aus Thunderbird importéieren';

  @override
  String get welcomeTryDemo => 'Mat Demo-Mailen ausprobéieren';
}
