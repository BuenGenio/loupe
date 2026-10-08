// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Maltese (`mt`).
class AppLocalizationsMt extends AppLocalizations {
  AppLocalizationsMt([String locale = 'mt']) : super(locale);

  @override
  String get commonAdd => 'Żid';

  @override
  String get commonCancel => 'Ikkanċella';

  @override
  String get commonClose => 'Agħlaq';

  @override
  String get commonDelete => 'Ħassar';

  @override
  String get commonDone => 'Lest';

  @override
  String get commonEdit => 'Editja';

  @override
  String get commonMore => 'Aktar';

  @override
  String get commonMove => 'Ċaqlaq';

  @override
  String get commonName => 'Isem';

  @override
  String get commonNone => 'Xejn';

  @override
  String get commonOff => 'Mitfi';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Mixgħul';

  @override
  String get commonOptional => 'Fakultattiv';

  @override
  String get commonPassword => 'Password';

  @override
  String get commonRemove => 'Neħħi';

  @override
  String get commonRetry => 'Erġa’ pprova';

  @override
  String get commonSave => 'Aħżen';

  @override
  String get commonSearch => 'Fittex';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Settings';

  @override
  String get commonShare => 'Aqsam';

  @override
  String get commonTryAgain => 'Erġa’ pprova';

  @override
  String get commonUndo => 'Irtira';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ',
      many: '$count-il messaġġ',
      few: '$count messaġġi',
      two: '$count messaġġi',
      one: '$count messaġġ',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkivja';

  @override
  String get mailDelete => 'Ħassar';

  @override
  String get mailFlag => 'Immarka b’bandiera';

  @override
  String get mailForward => 'Għaddi';

  @override
  String get mailMarkAsRead => 'Immarka bħala moqri';

  @override
  String get mailMarkAsUnread => 'Immarka bħala mhux moqri';

  @override
  String get mailMoveToJunk => 'Ċaqlaq għall-Ispam';

  @override
  String get mailNewMessage => 'Messaġġ ġdid';

  @override
  String get mailNoSubject => 'Mingħajr suġġett';

  @override
  String get mailReply => 'Wieġeb';

  @override
  String get mailReplyAll => 'Wieġeb lil kulħadd';

  @override
  String get mailSend => 'Ibgħat';

  @override
  String get mailUnflag => 'Neħħi l-bandiera';

  @override
  String get mailboxArchive => 'Arkivju';

  @override
  String get mailboxDrafts => 'Abbozzi';

  @override
  String get mailboxInbox => 'Inbox';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Outbox';

  @override
  String get mailboxSent => 'Mibgħuta';

  @override
  String get mailboxTrash => 'Skart';

  @override
  String get conversationSomethingWentWrong => 'Xi ħaġa marret ħażin. Erġa’ pprova.';

  @override
  String get conversationReplyToList => 'Wieġeb lil-lista';

  @override
  String get conversationReplyList => 'Wieġeb lil-lista';

  @override
  String get conversationThreadMuted => 'It-thread ġie msikket. Il-messaġġi l-ġodda fih jaslu diġà moqrija.';

  @override
  String get conversationThreadUnmuted => 'It-thread m’għadux imsikket.';

  @override
  String get conversationLinkFailed => 'Il-link ma setax jinfetaħ.';

  @override
  String get conversationGoneTitle => 'L-ebda messaġġ';

  @override
  String get conversationGoneText => 'Dan il-messaġġ ġie mċaqlaq jew imħassar.';

  @override
  String get conversationMuted => 'Imsikket';

  @override
  String get conversationReaderOptions => 'Għażliet tal-qari';

  @override
  String get conversationReaderOptionsHint => 'Daqs tat-test u veduta';

  @override
  String get conversationTrash => 'Skart';

  @override
  String get conversationReplyHint => 'Agħfas fit-tul għal Wieġeb lil kulħadd u Għaddi';

  @override
  String get conversationOfflineTitle => 'Int offline';

  @override
  String get conversationOfflineText =>
      'Din il-konversazzjoni għadha ma tniżżlitx. Se titgħabba meta terġa’ tkun online.';

  @override
  String get conversationErrorTitle => 'Dan il-messaġġ ma jistax jintwera';

  @override
  String get conversationErrorText => 'Xi ħaġa marret ħażin.';

  @override
  String get conversationOfflineBanner => 'Int offline';

  @override
  String get conversationNotUpdated => 'Mhux aġġornat';

  @override
  String get conversationMe => 'jien';

  @override
  String get conversationNoSender => '(l-ebda mittent)';

  @override
  String get conversationNoRecipients => 'l-ebda riċevitur';

  @override
  String conversationRecipients(String names) {
    return 'lil $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'lil $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Minn';

  @override
  String get conversationHeaderTo => 'Lil';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Wieġeb lil';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Sigurtà';

  @override
  String get conversationVerifiedSender => 'Mittent ivverifikat';

  @override
  String get conversationUnverifiedSender => 'Mittent mhux ivverifikat';

  @override
  String get conversationLoadingMessage => 'Qed jitgħabba l-messaġġ';

  @override
  String get conversationBodyError => 'Dan il-messaġġ ma setax jitgħabba.';

  @override
  String get conversationBodyOffline => 'Int offline. Il-messaġġ jitgħabba meta terġa’ tkun online.';

  @override
  String get conversationOriginalHint => 'Jidher aħjar fil-veduta Oriġinali';

  @override
  String get conversationShowOriginal => 'Uri l-oriġinal';

  @override
  String get conversationScrollToTop => 'Mur fil-quċċata';

  @override
  String get conversationTagsMenu => 'Tikketti…';

  @override
  String get conversationMuteThread => 'Issikket it-thread';

  @override
  String get conversationUnmuteThread => 'Neħħi s-silenzju mit-thread';

  @override
  String get conversationMoveMenu => 'Ċaqlaq…';

  @override
  String get conversationDeletePermanently => 'Ħassar għal kollox';

  @override
  String get conversationMoveToTrash => 'Ċaqlaq għall-Iskart';

  @override
  String get conversationNotJunk => 'Mhux spam';

  @override
  String get conversationShowAllHeaders => 'Uri l-intestaturi kollha';

  @override
  String get conversationViewSource => 'Ara s-sors';

  @override
  String get conversationSaveAsFile => 'Aħżen bħala fajl…';

  @override
  String get conversationShareAsFile => 'Aqsam bħala fajl…';

  @override
  String get conversationSearchFromMessageMenu => 'Fittex minn dan il-messaġġ…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Ikkopja l-indirizz';

  @override
  String get conversationAddressCopied => 'L-indirizz ġie kkupjat';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Fittex messaġġi minn $name';
  }

  @override
  String get conversationTags => 'Tikketti';

  @override
  String get conversationAllHeaders => 'L-intestaturi kollha';

  @override
  String get conversationCopyAll => 'Ikkopja kollox';

  @override
  String get conversationHeadersCopied => 'L-intestaturi ġew ikkupjati';

  @override
  String get conversationNoHeaders => 'L-ebda intestatura';

  @override
  String get conversationSearchFromMessageTitle => 'Fittex minn dan il-messaġġ';

  @override
  String conversationSearchFrom(String name) {
    return 'Minn $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Lil $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Suġġett “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Sors';

  @override
  String get conversationSourceCopied => 'Is-sors ġie kkupjat';

  @override
  String get conversationShareFailed => 'Il-messaġġ ma setax jinqasam.';

  @override
  String get conversationWrapLines => 'Ikser il-linji twal';

  @override
  String get conversationDontWrapLines => 'Tkissirx il-linji';

  @override
  String get conversationSourceError => 'Is-sors ma setax jitgħabba.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Qed jintwerew l-ewwel $shown minn $total. Ikkopja jew aqsam biex tieħu kollox.';
  }

  @override
  String get conversationAttachmentUntitled => 'Mingħajr titlu';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Aktar azzjonijiet għal $name';
  }

  @override
  String get conversationMoveTo => 'Ċaqlaq għal…';

  @override
  String get conversationMailboxesError => 'Il-mailboxes ma setgħux jitgħabbew.';

  @override
  String get conversationReaderReadable => 'Leġġibbli';

  @override
  String get conversationReaderOriginal => 'Oriġinali';

  @override
  String get conversationReaderPlain => 'Test sempliċi';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Żomm il-kuluri oriġinali';

  @override
  String get conversationReaderRemember => 'Ftakar għal dan il-mittent';

  @override
  String get conversationSecurityPossiblePhishing => 'Possibbli phishing';

  @override
  String get conversationSecurityBeCareful => 'Oqgħod attent';

  @override
  String get conversationSecurityVerified => 'Ivverifikat';

  @override
  String get conversationSecurityNoIssues => 'Ma nstabet l-ebda problema';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracker',
      many: '$count-il tracker',
      few: '$count trackers',
      two: '$count trackers',
      one: '$count tracker',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Juri għaliex';

  @override
  String get conversationPhishingBannerTitle => 'Dan il-messaġġ jidher li hu phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Il-links u l-istampi huma mitfija.';
  }

  @override
  String get conversationPhishingBannerText => 'Il-links u l-istampi huma mitfija.';

  @override
  String get conversationPhishingWhy => 'Għaliex?';

  @override
  String get conversationPhishingShowAnyway => 'Uri xorta waħda';

  @override
  String get conversationSecurityPhishingTitle => 'Dan jidher li hu phishing';

  @override
  String get conversationSecurityPhishingText => 'Diversi sinjali juru li dan il-messaġġ mhuwiex dak li jgħid li hu.';

  @override
  String get conversationSecurityCarefulTitle => 'Oqgħod attent b’dan il-messaġġ';

  @override
  String get conversationSecurityCarefulText => 'Hemm xi ħaġa fih li jistħoqqilha ħarsa oħra.';

  @override
  String get conversationSecurityVerifiedText => 'Il-mittent huwa vverifikat u xejn ma jidher suspettuż.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Xejn ma jidher suspettuż. Is-server tal-imejl tiegħek ma qalx jekk il-mittent huwiex ivverifikat.';

  @override
  String get conversationSecurityNothingSuspicious => 'Xejn ma jidher suspettuż.';

  @override
  String get conversationSecurityWhy => 'Għaliex';

  @override
  String get conversationSecurityPrivacy => 'Privatezza';

  @override
  String get conversationSecurityNoTrackingPixels => 'L-ebda pixel tat-traċċar';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pixel tat-traċċar tneħħew',
      many: '$count-il pixel tat-traċċar tneħħew',
      few: '$count pixels tat-traċċar tneħħew',
      two: '$count pixels tat-traċċar tneħħew',
      one: '$count pixel tat-traċċar tneħħa',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Kienu jgħidu lill-mittent meta ftaħt dan il-messaġġ.';

  @override
  String get conversationSecurityNoRemoteImages => 'L-ebda stampa remota';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stampa remota',
      many: '$count-il stampa remota',
      few: '$count stampi remoti',
      two: '$count stampi remoti',
      one: '$count stampa remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Jekk tgħabbihom, il-mittent isir jaf meta taqra dan il-messaġġ, u jsir jaf ukoll l-indirizz IP tiegħek.';

  @override
  String get conversationSecurityNoClickTracking => 'L-ebda traċċar tal-klikks';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count link li jgħaddu minn trackers tal-klikks',
      many: '$count-il link li jgħaddu minn trackers tal-klikks',
      few: '$count links li jgħaddu minn trackers tal-klikks',
      two: '$count links li jgħaddu minn trackers tal-klikks',
      one: '$count link li jgħaddi minn trackers tal-klikks',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services kienu jirreġistraw il-klikk tiegħek. Agħfas fit-tul fuq link biex tiftaħ id-destinazzjoni tiegħu direttament.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Dettalji tekniċi';

  @override
  String get conversationSecurityCheckedLocally => 'Iċċekkjat fuq dan l-apparat. Xejn ma ntbagħat x’imkien.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackers';

  @override
  String get conversationSecurityImagesFrom => 'Stampi minn';

  @override
  String get conversationSecuritySenderHistory => 'Storja tal-mittent';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'riċevuti: $received, mibgħuta: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Il-links iwasslu għal';

  @override
  String get conversationSecurityHidden => 'Moħbi';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements element',
      many: '$elements-il element',
      few: '$elements elementi',
      two: '$elements elementi',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters karattru',
      many: '$characters-il karattru',
      few: '$characters karattri',
      two: '$characters karattri',
      one: '$characters karattru',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Mittent mhux ivverifikat';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Is-server tal-imejl tiegħek ma setax jikkonferma li dan il-messaġġ verament ġej minn $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Is-server tal-imejl tiegħek ma setax jikkonferma li dan il-messaġġ verament ġej mill-mittent tiegħu.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Is-server tal-imejl tiegħek ma setax jikkonferma li dan il-messaġġ ġej minn $domain. Dan komuni fil-mailing lists.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Is-server tal-imejl tiegħek ma setax jikkonferma li dan il-messaġġ ġej mill-mittent tiegħu. Dan komuni fil-mailing lists.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Tagħmel xejn fuqu jekk ma kontx qed tistennieh. Jekk għandek xi dubju, ikkuntattja lill-mittent b’mod ieħor.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Iffirmat minn dominju ieħor';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Il-messaġġ huwa ffirmat minn $signer, mhux minn $domain. Is-servizzi tal-posta jagħmlu hekk, iżda dan ma jippruvax min kitbu.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Il-messaġġ huwa ffirmat minn dominju ieħor, mhux minn $domain. Is-servizzi tal-posta jagħmlu hekk, iżda dan ma jippruvax min kitbu.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'L-isem juri indirizz ieħor';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'L-isem tal-mittent jgħid “$shown”, iżda l-messaġġ ġej minn $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Afda fl-indirizz, mhux fl-isem.';

  @override
  String get conversationSecurityReplyToTitle => 'It-tweġibiet imorru x’imkien ieħor';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Jekk twieġeb, it-tweġiba tiegħek tmur għand $address, mhux għand $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Iċċekkja l-indirizz qabel ma twieġeb b’xi ħaġa personali.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Juża ismek';

  @override
  String get conversationSecurityImpersonationTitle => 'Juża l-isem ta’ xi ħadd li taf';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Huwa ffirmat “$name”, bħal ismek stess, iżda ġej minn indirizz ġdid: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Huwa ffirmat “$name”, bħall-VIP tiegħek $knownName ($knownEmail), iżda ġej minn indirizz ġdid: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Huwa ffirmat “$name”, bħal $knownName ($knownEmail), iżda ġej minn indirizz ġdid: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'U t-tweġibiet imorru għal indirizz ieħor għal kollox.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Jekk jitlob flus, kodiċijiet jew fajls, l-ewwel iċċekkja mal-persuna b’mod ieħor.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Indirizz magħruf: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Dan l-indirizz: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'L-ewwel messaġġ minn dan il-mittent';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Qatt ma rċevejt posta minn $email qabel.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Oqgħod attent għal talbiet minn nies li għadek ma tafx.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Ittri qarrieqa fl-indirizz tal-mittent';

  @override
  String get conversationSecurityLinkHomographTitle => 'Ittri qarrieqa f’link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host iħallat ittri minn alfabeti differenti biex jimita indirizz ieħor.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host juża ittri li jixbhu lil oħrajn: mhuwiex $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Ħassru jew irrapportah bħala spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Tiftħux.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Dominju: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Dominju li jixbah lil ieħor';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Juża isem familjari fid-dominju tiegħu';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain jixbah lid-dominju tiegħek stess, $real, iżda huwa dominju differenti.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain jixbah lil $brand ($real), iżda huwa dominju differenti.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain juża l-isem tad-dominju tiegħek stess, $real, iżda mhuwiex tiegħu.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain juża l-isem ta’ $brand ($real), iżda mhuwiex tagħhom.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Il-messaġġi veri mill-organizzazzjoni tiegħek ġejjin minn $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Il-messaġġi veri minn $brand ġejjin minn $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Dominju tal-mittent: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Jimita: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count link jaħbu fejn imorru',
      many: '$count-il link jaħbu fejn imorru',
      few: '$count links jaħbu fejn imorru',
      two: '$count links jaħbu fejn imorru',
      one: 'Link jaħbi fejn imur',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Link juri $shown, iżda jiftaħ $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Tidħolx u tħallasx permezz ta’ dawn il-links. Minflok, ikteb l-indirizz int stess.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Id-destinazzjoni ta’ link ma tistax tiġi ċċekkjata';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Link juri $shown, iżda jgħaddi minn $host, li jirreġistra l-klikk qabel ma jgħaddih.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Link jipponta lejn indirizz IP biss';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts mhuwiex sit web b’isem. Kumpaniji veri rarament jagħmlu links hekk.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Link qarrieqi';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Link jibda b’“$shown@” biex jidher qisu $shown, iżda jiftaħ $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Paġna moħbija ġiet diżattivata';

  @override
  String get conversationSecurityDataLinkText =>
      'Link kien se jiftaħ paġna ppakkjata ġol-messaġġ, mod kif jevita l-kontrolli tal-links.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Jitlob password';

  @override
  String get conversationSecurityPasswordFieldText => 'Il-messaġġ kien fih qasam tal-password. Loupe neħħietu.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Qatt tikteb password f’imejl.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Link li jħaddem kodiċi ġie diżattivat';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe qatt ma tħaddem kodiċi mill-messaġġi.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Links imqassra',
      many: 'Links imqassra',
      few: 'Links imqassra',
      two: 'Links imqassra',
      one: 'Link imqassar',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts jaħbi d-destinazzjoni vera sakemm tiftħu.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Indirizz web internazzjonali';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts juża ittri mhux Latini. Normali f’ħafna lingwi; iċċekkja li huwa s-sit li qed tistenna.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Ħafna test moħbi';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tneħħew $count karattru ta’ test inviżibbli. Test moħbi bħal dan isir biex iqarraq bil-filtri tal-ispam.',
      many:
          'Tneħħew $count-il karattru ta’ test inviżibbli. Test moħbi bħal dan isir biex iqarraq bil-filtri tal-ispam.',
      few: 'Tneħħew $count karattri ta’ test inviżibbli. Test moħbi bħal dan isir biex iqarraq bil-filtri tal-ispam.',
      two: 'Tneħħew $count karattri ta’ test inviżibbli. Test moħbi bħal dan isir biex iqarraq bil-filtri tal-ispam.',
      one: 'Tneħħa $count karattru ta’ test inviżibbli. Test moħbi bħal dan isir biex iqarraq bil-filtri tal-ispam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Tneħħa test moħbi';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tneħħew $count karattru ta’ test inviżibbli.',
      many: 'Tneħħew $count-il karattru ta’ test inviżibbli.',
      few: 'Tneħħew $count karattri ta’ test inviżibbli.',
      two: 'Tneħħew $count karattri ta’ test inviżibbli.',
      one: 'Tneħħa $count karattru ta’ test inviżibbli.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Il-messaġġ ma setax jitniżżel. Iċċekkja l-konnessjoni u erġa’ pprova.';

  @override
  String exportSaved(String name) {
    return '“$name” ġie maħżun';
  }

  @override
  String get exportSaveFailed => 'Il-messaġġ ma setax jinħażen.';

  @override
  String exportFailed(String folder) {
    return '“$folder” ma setax jiġi esportat.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” m’għandu l-ebda messaġġ x’jiġi esportat.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '“$folder” ma setax jiġi esportat: l-ebda messaġġ ma seta’ jitniżżel. Iċċekkja l-konnessjoni u erġa’ pprova.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$name” ġie maħżun mingħajr $formattedCount messaġġ li ma setgħux jitniżżlu.',
      many: '“$name” ġie maħżun mingħajr $formattedCount-il messaġġ li ma setgħux jitniżżlu.',
      few: '“$name” ġie maħżun mingħajr $formattedCount messaġġi li ma setgħux jitniżżlu.',
      two: '“$name” ġie maħżun mingħajr $formattedCount messaġġi li ma setgħux jitniżżlu.',
      one: '“$name” ġie maħżun mingħajr messaġġ wieħed li ma setax jitniżżel.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '“$name” ma setax jinħażen.';
  }

  @override
  String exportTitle(String folder) {
    return 'Qed jiġi esportat “$folder”';
  }

  @override
  String get exportListing => 'Qed jinstabu l-messaġġi…';

  @override
  String exportProgress(String current, String total) {
    return 'Qed jiġi esportat $current minn $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount messaġġ ma setgħux jitniżżlu',
      many: '$formattedCount-il messaġġ ma setgħux jitniżżlu',
      few: '$formattedCount messaġġi ma setgħux jitniżżlu',
      two: '$formattedCount messaġġi ma setgħux jitniżżlu',
      one: 'Messaġġ wieħed ma setax jitniżżel',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Mailboxes';

  @override
  String get mailboxesShown => 'Murija';

  @override
  String get mailboxesHidden => 'Moħbija';

  @override
  String get mailboxesCollapse => 'Iġbor';

  @override
  String get mailboxesExpand => 'Espandi';

  @override
  String get mailboxesManageVips => 'Immaniġġja l-VIPs';

  @override
  String get mailboxesSubscriptions => 'Abbonamenti';

  @override
  String mailboxesShowAccount(String account) {
    return 'Uri $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Aħbi $account';
  }

  @override
  String get mailboxesExportFolder => 'Esporta l-folder…';

  @override
  String get mailboxesUnpin => 'Neħħi';

  @override
  String get mailboxesLists => 'Listi';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Aħżen tfittxija biex iżżommha hawn.';

  @override
  String get mailboxesTags => 'Tikketti';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Tista’ wkoll tagħfas fuq l-isem ta’ mittent f’messaġġ u tixgħel VIP.';

  @override
  String get mailboxesAddVip => 'Żid VIP…';

  @override
  String get mailboxesAddVipTitle => 'Żid VIP';

  @override
  String get mailboxesAddVipText => 'Il-posta minn dan l-indirizz tieħu stilla u tidher fil-mailbox VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'isem@example.com';

  @override
  String get messageListFilterUnread => 'Mhux moqrija';

  @override
  String get messageListFilterFlagged => 'B’bandiera';

  @override
  String get messageListFilterToMe => 'Lil: lili';

  @override
  String get messageListFilterCcMe => 'Cc: lili';

  @override
  String get messageListFilterWithAttachments => 'B’annessi';

  @override
  String get messageListFilterUnreplied => 'Mingħajr tweġiba';

  @override
  String get messageListFilterFromVips => 'Mill-VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew immarkati bħala moqrija',
      many: '$count-il messaġġ ġew immarkati bħala moqrija',
      few: '$count messaġġi ġew immarkati bħala moqrija',
      two: '$count messaġġi ġew immarkati bħala moqrija',
      one: '$count messaġġ ġie mmarkat bħala moqri',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Il-posta eqdem ma setgħetx titgħabba.';

  @override
  String get messageListSelectMessages => 'Agħżel messaġġi';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count magħżula',
      many: '$count magħżula',
      few: '$count magħżula',
      two: '$count magħżula',
      one: '$count magħżul',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Agħżel kollox';

  @override
  String get messageListDeselectAll => 'Neħħi l-għażla kollha';

  @override
  String get messageListLoadFailed => 'Il-posta ma setgħetx titgħabba';

  @override
  String get messageListNoUnread => 'L-ebda posta mhux moqrija';

  @override
  String get messageListNoMatches => 'L-ebda posta li taqbel';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Iffiltrat skont: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Itfi l-filtru';

  @override
  String get messageListEmpty => 'L-ebda posta';

  @override
  String get messageListFilter => 'Iffiltra';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kriterji tal-filtru: $filters';
  }

  @override
  String get messageListFilteredBy => 'Iffiltrat skont:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount mhux moqrija',
      many: '$formattedCount mhux moqrija',
      few: '$formattedCount mhux moqrija',
      two: '$formattedCount mhux moqrija',
      one: '$count mhux moqri',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Immarka';

  @override
  String get messageListTrash => 'Skart';

  @override
  String get messageListFilterTitle => 'Filtru';

  @override
  String get messageListFilterInclude => 'INKLUDI';

  @override
  String get panesHideMailboxes => 'Aħbi l-mailboxes';

  @override
  String get panesShowMailboxes => 'Uri l-mailboxes';

  @override
  String get panesMailboxesWidth => 'Wisa’ tal-mailboxes';

  @override
  String get panesListWidth => 'Wisa’ tal-lista tal-messaġġi';

  @override
  String get panesNoMessageSelected => 'L-ebda messaġġ magħżul';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ',
      many: '$count-il messaġġ',
      few: '$count messaġġi',
      two: '$count messaġġi',
      one: '$count messaġġ',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Ipposponuti';

  @override
  String get snoozeSheetTitle => 'Ipposponi';

  @override
  String get snoozeLaterToday => 'Aktar tard illum';

  @override
  String get snoozeThisEvening => 'Illejla';

  @override
  String get snoozeTomorrow => 'Għada';

  @override
  String get snoozeThisWeekend => 'Dan il-weekend';

  @override
  String get snoozeNextWeek => 'Il-ġimgħa d-dieħla';

  @override
  String get snoozePickDateTime => 'Agħżel data u ħin…';

  @override
  String get snoozeMenu => 'Ipposponi…';

  @override
  String get snoozeWakeNow => 'Ġibu lura issa';

  @override
  String get snoozeChangeTimeMenu => 'Ibdel il-ħin tal-posponiment…';

  @override
  String get snoozeChangeTime => 'Ibdel il-ħin';

  @override
  String get snoozeNoTime => 'L-ebda ħin stabbilit';

  @override
  String get snoozeFooter => 'Il-messaġġi pposponuti jerġgħu lura fl-Inbox, mhux moqrija, fil-ħin tagħhom.';

  @override
  String get snoozeEmptyTitle => 'Xejn ipposponut';

  @override
  String get snoozeEmptyText => 'Ipposponi messaġġ biex jerġa’ lura fl-Inbox meta jkollok bżonnu.';

  @override
  String get appLockUnlock => 'Iftaħ';

  @override
  String get appLockFailed => 'Loupe ma setgħetx tikkonferma li int.';

  @override
  String get appLockLockedOut => 'Wisq tentattivi. Erġa’ pprova aktar tard.';

  @override
  String get appLockPromptError => 'It-talba ma setgħetx tintwera. Erġa’ pprova.';

  @override
  String get appLockNoScreenLock => 'Dan il-mowbajl m’għandux qafla tal-iskrin.';

  @override
  String get appLockUnlockPromptTitle => 'Iftaħ Loupe';

  @override
  String get appLockUnlockPromptReason => 'Ikkonferma li int biex tara l-posta tiegħek.';

  @override
  String get appLockTurnOnPromptTitle => 'Ixgħel il-Qafla għall-app';

  @override
  String get appLockTurnOnPromptReason => 'Ikkonferma li int biex tixgħel il-Qafla għall-app.';

  @override
  String get appLockScreenLockRemoved =>
      'Il-Qafla għall-app hija mitfija: dan il-mowbajl m’għadx għandu qafla tal-iskrin. Issettja waħda biex terġa’ tixgħel il-Qafla għall-app.';

  @override
  String get appLockAfterImmediately => 'Minnufih';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuta',
      many: '$count-il minuta',
      few: '$count minuti',
      two: '$count minuti',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count siegħa',
      many: '$count-il siegħa',
      few: '$count sigħat',
      two: '$count sigħat',
      one: '$count siegħa',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Kriptat';

  @override
  String get openpgpEncryptedInPart => 'Kriptat parzjalment';

  @override
  String get openpgpEncryptedLocked => 'Kriptat · imsakkar';

  @override
  String get openpgpEncryptedNoKey => 'Kriptat · l-ebda ċavetta';

  @override
  String get openpgpEncryptedDamaged => 'Kriptat · bil-ħsara';

  @override
  String get openpgpEncryptedUnsupported => 'Kriptat · mhux appoġġjat';

  @override
  String get openpgpUnknownSigner => 'mhux magħruf';

  @override
  String get openpgpUnknownKey => 'Ċavetta mhux magħrufa';

  @override
  String get openpgpSignatureInvalid => 'Firma invalida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Iffirmat minn $name, mhux mill-mittent';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Iffirmat parzjalment minn $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Iffirmat minn $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Iffirmat b’ċavetta miċħuda';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Iffirmat minn $name · ċavetta mhux aċċettata';
  }

  @override
  String get openpgpUnlock => 'Iftaħ';

  @override
  String get openpgpCantDecrypt => 'Dan il-messaġġ ma jistax jiġi dekriptat';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Kriptat b’OpenPGP';

  @override
  String get openpgpEncryption => 'Kriptaġġ';

  @override
  String get openpgpDecryptedHere => 'Dekriptat fuq dan l-apparat';

  @override
  String get openpgpNotDecrypted => 'Mhux dekriptat';

  @override
  String get openpgpKeyLocked => 'Iċ-ċavetta tiegħek hija msakkra.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Għaċ-ċwievet $keys',
      many: 'Għaċ-ċwievet $keys',
      few: 'Għaċ-ċwievet $keys',
      two: 'Għaċ-ċwievet $keys',
      one: 'Għaċ-ċavetta $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Suġġett protett';

  @override
  String get openpgpUnlockKey => 'Iftaħ iċ-ċavetta';

  @override
  String get openpgpSignature => 'Firma';

  @override
  String get openpgpFingerprint => 'Fingerprint';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID taċ-ċavetta $id';
  }

  @override
  String get openpgpSigned => 'Iffirmat';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Aċċettazzjoni';

  @override
  String get openpgpChangeAcceptance => 'Ibdel l-aċċettazzjoni…';

  @override
  String get openpgpCheckedFooter => 'Iċċekkjat fuq dan l-apparat b’OpenPGP, kompatibbli ma’ Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Iċ-ċavetta tiegħek hija msakkra. Iftaħha bil-frażi sigrieta tagħha biex taqra dan il-messaġġ.';

  @override
  String get openpgpSummaryNoSecretKey => 'Ġie kriptat għal ċavetta li mhix fuq dan l-apparat.';

  @override
  String get openpgpSummaryDamaged => 'Id-data kriptata għandha ħsara jew inbidlet fit-triq.';

  @override
  String get openpgpSummaryUnsupported => 'Juża algoritmu li Loupe ma tappoġġjax.';

  @override
  String get openpgpSummaryEncrypted => 'Int u r-riċevituri l-oħra biss tistgħu taqrawh.';

  @override
  String get openpgpSummaryNotSigned => 'Mhuwiex iffirmat, għalhekk il-mittent mhuwiex ikkonfermat.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Huwa ffirmat, iżda b’ċavetta li m’għandekx, għalhekk il-firma ma tistax tiġi ċċekkjata.';

  @override
  String get openpgpSummaryBadSignature => 'Il-firma ma taqbilx: il-messaġġ seta’ nbidel.';

  @override
  String get openpgpSummaryMismatch =>
      'Il-firma hija valida, iżda ċ-ċavetta tappartjeni għal indirizz ieħor minflok dak tal-mittent.';

  @override
  String get openpgpSummaryPartial =>
      'Parti biss mill-messaġġ hija ffirmata. It-test barra mill-firma (pereżempju, il-footer ta’ mailing list) jintwera taħt il-linja “Unsigned content”, u partijiet oħra tal-messaġġ, bħall-annessi, lanqas ma huma koperti.';

  @override
  String get openpgpSummaryOwnKey => 'Iffirmat biċ-ċavetta tiegħek stess.';

  @override
  String get openpgpSummaryVerified => 'Il-firma hija valida, u vverifikajt il-fingerprint taċ-ċavetta.';

  @override
  String get openpgpSummaryUnverified =>
      'Il-firma hija valida. Aċċettajt iċ-ċavetta mingħajr ma ċċekkjajt il-fingerprint tagħha.';

  @override
  String get openpgpSummaryRejected => 'Il-firma hija valida, iżda ċħadt din iċ-ċavetta.';

  @override
  String get openpgpSummaryUndecided =>
      'Il-firma hija valida, iżda għadek ma aċċettajtx din iċ-ċavetta. Qabbel il-fingerprint tagħha mal-mittent.';

  @override
  String get openpgpAcceptanceRejected => 'Miċħuda';

  @override
  String get openpgpAcceptanceUndecided => 'Mhux aċċettata';

  @override
  String get openpgpAcceptanceUnverified => 'Aċċettata';

  @override
  String get openpgpAcceptanceVerified => 'Aċċettata u vverifikata';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Taċċetta ċ-ċavetta ta’ $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingerprint $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Iva, ivverifikajt il-fingerprint';

  @override
  String get openpgpAcceptUnverified => 'Iva, mingħajr ma ċċekkjajt';

  @override
  String get openpgpAcceptLater => 'Mhux issa';

  @override
  String get openpgpRejectKey => 'Iċħad din iċ-ċavetta';

  @override
  String get openpgpNoSubject => '(mingħajr suġġett)';

  @override
  String get openpgpEncryptionTitle => 'Kriptaġġ minn tarf għal tarf';

  @override
  String get openpgpMyKeys => 'Iċ-ċwievet OpenPGP tiegħi';

  @override
  String get openpgpMyKeysFooter =>
      'B’ċavetta, tista’ taqra posta kriptata, u tiffirma u tikkripta l-posta tiegħek. Tuża Thunderbird? Esporta ċ-ċavetta tiegħek minn hemm (Account Settings › End-To-End Encryption › Export Secret Key) u importaha hawn.';

  @override
  String get openpgpAddKey => 'Żid ċavetta…';

  @override
  String get openpgpAddresses => 'Indirizzi';

  @override
  String get openpgpAddressesFooter => 'Liema ċavetta juża kull indirizz, u meta jikkripta u jiffirma.';

  @override
  String get openpgpCorrespondentsKeys => 'Iċ-ċwievet OpenPGP tal-korrispondenti';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Aċċetta ċavetta ladarba tafda li tappartjeni lis-sid tagħha; qabbel il-fingerprint mas-sid biex timmarkaha bħala vverifikata.';

  @override
  String get openpgpImportPublicKey => 'Importa ċavetta pubblika…';

  @override
  String get openpgpCollected => 'Miġbura minn Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Ċwievet li waslu mal-messaġġi. Loupe tista’ tikkripta għalihom meta ż-żewġ naħat jitolbu dan.';

  @override
  String get openpgpOnThisDevice => 'Fuq dan l-apparat';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Il-messaġġi kriptati jaħbu s-suġġett tagħhom. Loupe iżżomm is-suġġett ta’ kull messaġġ li tiftaħ fid-database kriptata tagħha fuq dan l-apparat, biex il-lista, it-tfittxija u n-notifiki juruh. Fl-isfond, Loupe tista’ wkoll tiddekripta s-suġġetti tal-messaġġi l-ġodda b’ċwievet mingħajr frażi sigrieta; biex tagħmel dan, tniżżel kull messaġġ (sa 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Iddekripta s-suġġetti fl-isfond';

  @override
  String get openpgpIndexFooter =>
      'It-tfittxija ssib messaġġi kriptati skont il-mittent, ir-riċevituri u s-suġġett tagħhom. B’dan mixgħul, Loupe iżżid ukoll it-test ta’ kull messaġġ kriptat li tiddekripta mal-indiċi tat-tfittxija fid-database kriptata tagħha fuq dan l-apparat, biex it-tfittxija ssibu wkoll mit-test tiegħu. Jekk titfih, dak it-test jitneħħa mill-indiċi.';

  @override
  String get openpgpIndexDecrypted => 'Indiċizza l-messaġġi dekriptati għat-tfittxija';

  @override
  String get openpgpPassphrases => 'Frażijiet sigrieti';

  @override
  String get openpgpPassphrasesFooter =>
      'Iċ-ċwievet OpenPGP u ċ-ċertifikati S/MIME li tipproteġi bi frażi sigrieta jinfetħu meta jkun hemm bżonn. Mingħajr “Ftakar”, jerġgħu jissakkru żewġ minuti wara kull użu.';

  @override
  String get openpgpRememberPassphrases => 'Ftakar il-frażijiet sigrieti';

  @override
  String get openpgpRememberPassphrasesDetail => 'Sakemm tingħalaq Loupe';

  @override
  String get openpgpLockKeysNow => 'Sakkar iċ-ċwievet issa';

  @override
  String get openpgpKeysLocked => 'Iċ-ċwievet ġew imsakkra.';

  @override
  String get openpgpKeyStateRevoked => 'revokata';

  @override
  String get openpgpKeyStateExpired => 'skaduta';

  @override
  String get openpgpKeyStateNeverExpires => 'qatt ma tiskadi';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'tiskadi: $date';
  }

  @override
  String get openpgpNoKey => 'L-ebda ċavetta';

  @override
  String get openpgpAlwaysEncrypt => 'Dejjem ikkripta';

  @override
  String get openpgpAddKeyTitle => 'Żid ċavetta OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importa ċ-ċavetta li tuża f’Thunderbird, jew agħmel waħda ġdida.';

  @override
  String get openpgpImportFromClipboard => 'Importa mill-clipboard';

  @override
  String get openpgpImportFromFile => 'Importa minn fajl';

  @override
  String get openpgpGenerateNewKey => 'Iġġenera ċavetta ġdida';

  @override
  String get openpgpImportPublicKeyTitle => 'Importa ċavetta pubblika';

  @override
  String get openpgpFromClipboard => 'Mill-clipboard';

  @override
  String get openpgpFromFile => 'Minn fajl';

  @override
  String get openpgpClipboardEmpty => 'Il-clipboard huwa vojt. L-ewwel ikkopja ċ-ċavetta.';

  @override
  String get openpgpKey => 'Ċavetta';

  @override
  String get openpgpValidityRevoked => 'Revokata';

  @override
  String openpgpValidityExpired(String date) {
    return 'Skadiet: $date';
  }

  @override
  String get openpgpNeverExpires => 'Qatt ma tiskadi';

  @override
  String openpgpValidUntil(String date) {
    return 'Valida sa $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Il-fingerprint ġie kkupjat.';

  @override
  String get openpgpAlgorithm => 'Algoritmu';

  @override
  String get openpgpCreated => 'Maħluqa';

  @override
  String get openpgpValidity => 'Validità';

  @override
  String get openpgpProtection => 'Protezzjoni';

  @override
  String get openpgpProtectionPassphrase => 'Frażi sigrieta';

  @override
  String get openpgpProtectionKeychain => 'Ħażna sigura biss';

  @override
  String get openpgpKeyDetailsFooter =>
      'Aqsam iċ-ċavetta pubblika tiegħek biex oħrajn ikunu jistgħu jibagħtulek posta kriptata. Il-backup huwa ċ-ċavetta sigrieta tiegħek, protetta bil-frażi sigrieta tagħha jekk għandha waħda: żommu privat.';

  @override
  String get openpgpSharePublicKey => 'Aqsam iċ-ċavetta pubblika';

  @override
  String get openpgpCopyPublicKey => 'Ikkopja ċ-ċavetta pubblika';

  @override
  String get openpgpPublicKeyCopied => 'Iċ-ċavetta pubblika ġiet ikkupjata.';

  @override
  String get openpgpBackUpSecretKey => 'Agħmel backup taċ-ċavetta sigrieta';

  @override
  String get openpgpDeleteKey => 'Ħassar iċ-ċavetta';

  @override
  String get openpgpRemoveKey => 'Neħħi ċ-ċavetta';

  @override
  String get openpgpBackUpTitle => 'Tagħmel backup taċ-ċavetta sigrieta?';

  @override
  String get openpgpBackUpProtected =>
      'Il-backup huwa protett bil-frażi sigrieta taċ-ċavetta tiegħek. Kull min ikollu t-tnejn jista’ jaqra l-posta tiegħek.';

  @override
  String get openpgpBackUpUnprotected =>
      'Din iċ-ċavetta m’għandhiex frażi sigrieta: kull min ikollu l-backup jista’ jaqra l-posta tiegħek u jiffirma f’ismek.';

  @override
  String get openpgpBackUp => 'Agħmel backup';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Tħassar iċ-ċavetta tiegħek $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Tneħħi ċ-ċavetta ta’ $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Il-posta kriptata għal din iċ-ċavetta ma tkunx tista’ tinqara aktar fuq dan l-apparat, sakemm ma terġax timportaha.';

  @override
  String get openpgpRemoveKeyMessage => 'Tista’ terġa’ timportaha aktar tard.';

  @override
  String get openpgpKeyHeader => 'Ċavetta OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Żid ċavetta f’Kriptaġġ minn tarf għal tarf biex tikkripta u tiffirma l-posta minn dan l-indirizz.';

  @override
  String get openpgpGenerateAKey => 'Iġġenera ċavetta…';

  @override
  String get openpgpSending => 'Bgħit';

  @override
  String get openpgpSendingFooter =>
      'Il-kriptaġġ awtomatiku jixgħel meta kull riċevitur ikollu ċavetta aċċettata jew ċertifikat fdat, jew meta Autocrypt jgħid li ż-żewġ naħat iridu. Il-posta kriptata dejjem tiġi ffirmata.';

  @override
  String get openpgpEncryptAutomatically => 'Ikkripta awtomatikament';

  @override
  String get openpgpAlwaysEncryptDetail => 'Ma jibgħatx jekk riċevitur m’għandux ċavetta';

  @override
  String get openpgpSignUnencrypted => 'Iffirma l-posta mhux kriptata';

  @override
  String get openpgpAttachPublicKey => 'Ehmeż iċ-ċavetta pubblika tiegħi';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt jibgħat iċ-ċavetta pubblika tiegħek ma’ kull messaġġ, biex apps oħra jkunu jistgħu jibagħtulek posta kriptata mingħajr ebda setup.';

  @override
  String get openpgpSendMyKey => 'Ibgħat iċ-ċavetta tiegħi mal-posta';

  @override
  String get openpgpPreferEncryption => 'Ippreferi l-kriptaġġ';

  @override
  String get openpgpPreferEncryptionDetail => 'Itlob lill-oħrajn jikkriptaw meta jistgħu';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sena',
      many: '$count-il sena',
      few: '$count snin',
      two: '$count snin',
      one: '$count sena',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Il-frażijiet sigrieti ma jaqblux.';

  @override
  String openpgpKeyReady(String id) {
    return 'Iċ-ċavetta tiegħek $id lesta.';
  }

  @override
  String get openpgpNewKey => 'Ċavetta ġdida';

  @override
  String get openpgpNewKeyFor => 'Għal';

  @override
  String get openpgpYourName => 'Ismek';

  @override
  String get openpgpAddress => 'Indirizz';

  @override
  String get openpgpPassphrase => 'Frażi sigrieta';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Fakultattiva. Mingħajrha, il-ħażna sigura tal-mowbajl tiegħek biss tipproteġi ċ-ċavetta, u Loupe qatt ma titolbok xejn. Biha, Loupe titolbok għaliha meta ċ-ċavetta tkun meħtieġa.';

  @override
  String get openpgpRepeatPassphrase => 'Erġa’ ikteb';

  @override
  String get openpgpExpires => 'Skadenza';

  @override
  String get openpgpExpiresFooter =>
      'Tista’ tagħmel ċavetta ġdida qabel ma tiskadi. Thunderbird ukoll juża tliet snin.';

  @override
  String get openpgpGenerateKey => 'Iġġenera ċ-ċavetta';

  @override
  String get openpgpKeyFor => 'Ċavetta għal';

  @override
  String get openpgpCantEncrypt => 'Ma jistax jiġi kriptat';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'M’hemm l-ebda ċavetta OpenPGP għal $names, u dan l-indirizz dejjem jikkripta. Neħħi r-riċevitur, jew importa ċ-ċavetta tiegħu f’Settings › Kriptaġġ minn tarf għal tarf.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'M’hemm l-ebda ċertifikat S/MIME validu għal $names, u dan l-indirizz dejjem jikkripta. Neħħi r-riċevitur, jew importa ċ-ċertifikat tiegħu f’Settings › Kriptaġġ minn tarf għal tarf.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'M’hemm l-ebda ċavetta OpenPGP għal $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'M’hemm l-ebda ċertifikat S/MIME validu għal $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Ibgħat mhux kriptat';

  @override
  String get openpgpCantSign => 'Ma jistax jiġi ffirmat';

  @override
  String get openpgpCantSignMessage =>
      'Iċ-ċavetta privata taċ-ċertifikat S/MIME tiegħek mhix fuq dan l-apparat. Erġa’ importa ċ-ċertifikat (fajl .p12 jew .pfx) f’Settings › Kriptaġġ minn tarf għal tarf.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'L-ebda ċavetta għal $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'L-ebda ċertifikat għal $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Ċwievet minn Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Kulħadd għandu ċavetta';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Kulħadd għandu ċertifikat';

  @override
  String get openpgpComposeEncrypt => 'Ikkripta';

  @override
  String get openpgpComposeSign => 'Iffirma';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, ibdel';
  }

  @override
  String get openpgpNoKeyFound => 'Ma nstabet l-ebda ċavetta OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Timporta ċavetta sigrieta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Dan l-anness fih ċavetta sigrieta ($names). Importaha bħala ċ-ċavetta tiegħek biss jekk esportajtha int stess, minn Thunderbird pereżempju.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importa bħala ċ-ċavetta tiegħi';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'iċ-ċavetta tiegħek $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Timporta $count ċavetta ($names)?',
      many: 'Timporta $count-il ċavetta ($names)?',
      few: 'Timporta $count ċwievet ($names)?',
      two: 'Timporta $count ċwievet ($names)?',
      one: 'Timporta ċ-ċavetta ta’ $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importa u aċċetta';

  @override
  String get openpgpImportDecideLater => 'Importa, iddeċiedi aktar tard';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'iċ-ċavetta ta’ $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Ġew importati: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hemm $count ċavetta OpenPGP mehmuża.',
      many: 'Hemm $count-il ċavetta OpenPGP mehmuża.',
      few: 'Hemm $count ċwievet OpenPGP mehmuża.',
      two: 'Hemm $count ċwievet OpenPGP mehmuża.',
      one: 'Hemm ċavetta OpenPGP mehmuża.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importa';

  @override
  String get openpgpUnlockKeyTitle => 'Iftaħ iċ-ċavetta OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Daħħal il-frażi sigrieta taċ-ċavetta ta’ $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Dik il-frażi sigrieta hija żbaljata. Erġa’ pprova.';

  @override
  String get openpgpExplainLocked => 'Dan il-messaġġ huwa kriptat. Iftaħ iċ-ċavetta OpenPGP tiegħek biex taqrah.';

  @override
  String get openpgpExplainNoKey =>
      'Dan il-messaġġ huwa kriptat, iżda mhux għal xi ċavetta OpenPGP fuq dan l-apparat. Jekk taqrah f’Thunderbird, importa ċ-ċavetta li tuża hemmhekk: Settings › Kriptaġġ minn tarf għal tarf.';

  @override
  String get openpgpExplainDamaged =>
      'Dan il-messaġġ kriptat għandu ħsara, għalhekk ma jistax jiġi dekriptat b’mod sigur.';

  @override
  String get openpgpExplainUnsupported => 'Dan il-messaġġ juża kriptaġġ li Loupe għadha ma tistax taqra.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Dan il-messaġġ huwa kriptat b’S/MIME, iżda mhux għal xi ċertifikat fuq dan l-apparat. Importa ċ-ċertifikat tiegħek (fajl .p12 jew .pfx) f’Settings › Kriptaġġ minn tarf għal tarf.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Dan il-messaġġ huwa kriptat. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Iftaħ iċ-ċertifikat S/MIME tiegħek biex taqrah.';

  @override
  String get openpgpAttachmentGone => 'Dan l-anness m’għadux disponibbli.';

  @override
  String get smimeEncrypted => 'Kriptat (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Kriptat (S/MIME) · l-ebda ċertifikat';

  @override
  String get smimeEncryptedDamaged => 'Kriptat (S/MIME) · bil-ħsara';

  @override
  String get smimeEncryptedUnsupported => 'Kriptat (S/MIME) · mhux appoġġjat';

  @override
  String get smimeEncryptedLocked => 'Kriptat (S/MIME) · imsakkar';

  @override
  String get smimeUnknownSigner => 'mhux magħruf';

  @override
  String get smimeSignatureModified => 'Firma invalida: il-messaġġ inbidel';

  @override
  String get smimeSignatureWeak => 'Firma mhux sigura: algoritmu antikwat';

  @override
  String get smimeSignatureUncheckable => 'Il-firma ma tistax tiġi ċċekkjata';

  @override
  String get smimeSignedCertificateMissing => 'Iffirmat · iċ-ċertifikat nieqes';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Iffirmat minn $name · ċertifikat revokat';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Iffirmat minn $name · f’data oħra';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Iffirmat minn $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Iffirmat minn $name · ċertifikat invalidu';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Iffirmat minn $name · mhux fdat';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Iffirmat minn $name · ċertifikat skadut';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Iffirmat minn $name · ċertifikat għadu mhux validu';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Iffirmat minn $name · ċertifikat mhux għall-posta';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Iffirmat minn $name, mhux mill-mittent';
  }

  @override
  String get smimeCantDecrypt => 'Dan il-messaġġ ma jistax jiġi dekriptat';

  @override
  String get smimeEncryptedWithSmime => 'Kriptat b’S/MIME';

  @override
  String get smimeEncryption => 'Kriptaġġ';

  @override
  String get smimeDecryptedHere => 'Dekriptat fuq dan l-apparat';

  @override
  String get smimeNotDecrypted => 'Mhux dekriptat';

  @override
  String get smimeAuthenticated => 'awtentikat';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'għal $count ċertifikat',
      many: 'għal $count-il ċertifikat',
      few: 'għal $count ċertifikati',
      two: 'għal $count ċertifikati',
      one: 'għal $count ċertifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Firma';

  @override
  String get smimeIssuedBy => 'Maħruġ minn';

  @override
  String get smimeValid => 'Validu';

  @override
  String smimeValidRange(String from, String to) {
    return '$from sa $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Fingerprint SHA-256';

  @override
  String get smimeSigned => 'Iffirmat';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'Qed tiġi ċċekkjata r-revoka…';

  @override
  String get smimeNotRevoked => 'Mhux revokat';

  @override
  String get smimeRevoked => 'Revokat';

  @override
  String get smimeRevocationUnknown => 'Revoka mhux magħrufa';

  @override
  String smimeRevokedSince(String date) {
    return 'Minn $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Ġiet mistoqsija l-awtorità (il-lista tar-revoki tagħha), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Ġiet mistoqsija l-awtorità (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Afda f’“$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Afda f’dan iċ-ċertifikat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Iċċekkjat fuq dan l-apparat b’S/MIME, kompatibbli ma’ Outlook u Thunderbird; ir-revoka ċċekkjata mal-awtorità taċ-ċertifikazzjoni.';

  @override
  String get smimeCheckedFooter =>
      'Iċċekkjat fuq dan l-apparat b’S/MIME, kompatibbli ma’ Outlook u Thunderbird. Ir-revoka mhix iċċekkjata (Settings › Kriptaġġ minn tarf għal tarf).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Tafda f’$name għall-posta?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Tafda fiċ-ċertifikat ta’ $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Kull ċertifikat li toħroġ din l-awtorità jkun fdat, bħal dawk tal-awtorità taċ-ċertifikazzjoni tal-kumpanija tiegħek. L-ewwel qabbel il-fingerprint mas-sid tiegħu:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'L-ewwel qabbel il-fingerprint mas-sid tiegħu:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Afda';

  @override
  String get smimeSummaryNoKey => 'Ġie kriptat għal ċertifikat li mhux fuq dan l-apparat.';

  @override
  String get smimeSummaryDamaged => 'Id-data kriptata għandha ħsara jew inbidlet fit-triq.';

  @override
  String get smimeSummaryUnsupported => 'Juża algoritmu li Loupe ma tappoġġjax.';

  @override
  String get smimeSummaryLocked => 'Iċ-ċertifikat S/MIME tiegħek huwa msakkar.';

  @override
  String get smimeSummaryEncrypted => 'Int u r-riċevituri l-oħra biss tistgħu taqrawh.';

  @override
  String get smimeSummaryNotSigned => 'Mhuwiex iffirmat, għalhekk il-mittent mhuwiex ikkonfermat.';

  @override
  String get smimeSummaryModified => 'Il-firma ma taqbilx: il-messaġġ inbidel wara li ġie ffirmat.';

  @override
  String get smimeSummaryUncheckable => 'Il-firma ma tistax tiġi ċċekkjata.';

  @override
  String get smimeSummaryNoCertificate =>
      'Iċ-ċertifikat ta’ min iffirma mhuwiex fil-messaġġ, għalhekk ma jistax jiġi ċċekkjat.';

  @override
  String get smimeSummaryRevoked =>
      'L-awtorità taċ-ċertifikazzjoni rrevokat iċ-ċertifikat ta’ min iffirma: il-firma ma tistax tiġi fdata.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'L-awtorità taċ-ċertifikazzjoni rrevokat iċ-ċertifikat ta’ min iffirma ($reason): il-firma ma tistax tiġi fdata.';
  }

  @override
  String get smimeDateMismatch =>
      'Ġie ffirmat aktar minn siegħa ’l bogħod mid-data tal-messaġġ: jista’ jkun messaġġ qadim mibgħut mill-ġdid.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Il-firma hija valida, u $issuer jiggarantixxi li ċ-ċertifikat jappartjeni lill-mittent.';
  }

  @override
  String get smimeProblemInvalidChain => 'Iċ-ċertifikat jew wieħed minn dawk li ħarġuh huwa invalidu.';

  @override
  String get smimeProblemUntrusted => 'Iċ-ċertifikat ġej minn awtorità li Loupe ma tafdax.';

  @override
  String get smimeProblemExpired => 'Iċ-ċertifikat kien skada.';

  @override
  String get smimeProblemNotYetValid => 'Iċ-ċertifikat kien għadu mhux validu.';

  @override
  String get smimeProblemWrongUsage => 'Iċ-ċertifikat mhuwiex maħsub għall-posta.';

  @override
  String get smimeProblemWrongAddress => 'Iċ-ċertifikat jappartjeni għal indirizz ieħor minflok dak tal-mittent.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Fdat · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Mhux fdat · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Skada: $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Validu minn $date';
  }

  @override
  String get smimeTrustInvalid => 'Invalidu';

  @override
  String get smimeTrustNotForMail => 'Mhux għall-posta';

  @override
  String get smimeTrustAnotherAddress => 'Indirizz ieħor';

  @override
  String get smimeMyCertificates => 'Iċ-ċertifikati S/MIME tiegħi';

  @override
  String get smimeMyCertificatesFooter =>
      'Għal S/MIME, kif jużawh Outlook u ħafna kumpaniji. Importa ċ-ċertifikat tiegħek biċ-ċavetta privata tiegħu (fajl .p12 jew .pfx), esportat minn Outlook, Windows, macOS jew Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Għal S/MIME, kif jużawh Outlook u ħafna kumpaniji. Importa ċ-ċertifikat tiegħek biċ-ċavetta privata tiegħu (fajl .p12 jew .pfx), esportat minn Outlook, Windows, macOS jew Thunderbird, jew uża wieħed li installat il-kumpanija tiegħek jew int fuq dan l-apparat.';

  @override
  String get smimeCertificateExpired => 'skadut';

  @override
  String smimeCertificateUntil(String date) {
    return 'sa $date';
  }

  @override
  String get smimeCertificateOnDevice => 'fuq dan l-apparat';

  @override
  String get smimeImportCertificateEllipsis => 'Importa ċertifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Uża ċertifikat minn dan l-apparat…';

  @override
  String get smimeCorrespondentsCertificates => 'Iċ-ċertifikati tal-korrispondenti';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Miġbura mill-posta ffirmata, kif jagħmlu Outlook u Thunderbird. Il-posta tiġi kriptata biss għal ċertifikati fdati: Loupe tafda l-awtoritajiet li Mozilla tafda għall-imejl, u dawk li żżid int.';

  @override
  String get smimeRevocation => 'Revoka';

  @override
  String get smimeRevocationFooter =>
      'Meta tiftaħ posta ffirmata, Loupe tistaqsi lill-awtorità li ħarġet iċ-ċertifikat ta’ min iffirma jekk ġiex revokat (lir-responder OCSP tagħha, jew lil-lista tar-revoki tagħha). L-awtorità mbagħad tista’ tara meta xi ħadd mill-indirizz IP tiegħek jaqra posta ffirmata b’dak iċ-ċertifikat. It-tweġibiet jinżammu fuq dan l-apparat sakemm jiskadu. Ċertifikat revokat jidher bħala “Revokat” fl-intestatura tal-messaġġ.';

  @override
  String get smimeCheckRevocation => 'Iċċekkja r-revoka taċ-ċertifikati online';

  @override
  String get smimeTrustedAuthorities => 'Awtoritajiet fdati';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fdati minnek, minbarra dawk li Mozilla tafda għall-imejl ($count).',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Awtorità taċ-ċertifikazzjoni';

  @override
  String get smimeImportACertificate => 'Importa ċertifikat';

  @override
  String get smimeImportContactMessage =>
      'Iċ-ċertifikat ta’ korrispondent (.cer, .crt, .pem) jew ta’ awtorità taċ-ċertifikazzjoni.';

  @override
  String get smimeFromClipboard => 'Mill-clipboard';

  @override
  String get smimeFromFile => 'Minn fajl';

  @override
  String get smimeClipboardEmpty => 'Il-clipboard huwa vojt. L-ewwel ikkopja ċ-ċertifikat.';

  @override
  String get smimeCertificate => 'Ċertifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Iċ-ċavetta privata tiegħu tibqa’ fil-ħażna tal-kredenzjali ta’ Android, fejn installatu l-kumpanija tiegħek jew int: Loupe titlob lil Android jiffirma u jiddekripta biha. Il-posta ffirmata tiġi ffirmata meta tibgħatha.';

  @override
  String get smimeAddresses => 'Indirizzi';

  @override
  String get smimeUsage => 'Għal';

  @override
  String get smimeUsageNone => 'Xejn li tuża Loupe';

  @override
  String get smimeUsageSigning => 'Iffirmar';

  @override
  String get smimeUsageEncryption => 'Kriptaġġ';

  @override
  String get smimeUsageCertificates => 'Ċertifikati';

  @override
  String get smimeAlgorithm => 'Algoritmu';

  @override
  String get smimeSerialNumber => 'Numru tas-serje';

  @override
  String get smimeFingerprintCopied => 'Il-fingerprint ġie kkupjat.';

  @override
  String get smimeSha1Thumbprint => 'Thumbprint SHA-1';

  @override
  String get smimePrivateKey => 'Ċavetta privata';

  @override
  String get smimeKeyOnDevice => 'Fuq dan l-apparat';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'F’Loupe, bi frażi sigrieta';

  @override
  String get smimeKeyInLoupe => 'F’Loupe';

  @override
  String get smimeSource => 'Minn';

  @override
  String get smimeSourceSignedMail => 'Posta ffirmata';

  @override
  String get smimeSourceImported => 'Importat';

  @override
  String get smimeTrustHeader => 'Fiduċja';

  @override
  String get smimeTrustedRoot => 'Għerq fdat';

  @override
  String get smimeIssuer => 'Emittent';

  @override
  String smimeTrustNamed(String name) {
    return 'Afda f’“$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Afda f’din l-awtorità';

  @override
  String get smimeTrustThisCertificate => 'Afda f’dan iċ-ċertifikat';

  @override
  String get smimeStopTrusting => 'Waqqaf il-fiduċja';

  @override
  String get smimePassphrase => 'Frażi sigrieta';

  @override
  String get smimePassphraseFooter =>
      'Fakultattiva. Bi frażi sigrieta, iċ-ċavetta privata tiġi kriptata wkoll fuq dan l-apparat (Argon2id u AES-256), u Loupe titolbok għaliha biex tiffirma u tiddekripta; “Ftakar il-frażijiet sigrieti” jgħid għal kemm żmien. Il-posta li tibgħat tiġi ffirmata hekk kif tibgħatha; ix-xogħol fl-isfond ma jistax juża ċ-ċavetta.';

  @override
  String get smimeChangePassphrase => 'Ibdel il-frażi sigrieta…';

  @override
  String get smimeSetPassphraseEllipsis => 'Issettja frażi sigrieta…';

  @override
  String get smimeRemovePassphrase => 'Neħħi l-frażi sigrieta';

  @override
  String get smimeShareCertificate => 'Aqsam iċ-ċertifikat';

  @override
  String get smimeDeleteCertificate => 'Ħassar iċ-ċertifikat';

  @override
  String get smimeRemoveCertificate => 'Neħħi ċ-ċertifikat';

  @override
  String get smimePassphraseChanged => 'Il-frażi sigrieta nbidlet.';

  @override
  String get smimePassphraseSet => 'Il-frażi sigrieta ġiet issettjata.';

  @override
  String get smimeRemovePassphraseTitle => 'Tneħħi l-frażi sigrieta?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Imbagħad iċ-ċavetta privata tkun protetta biss mill-ħażna sigura, bħal mingħajr frażi sigrieta: Loupe ma titolbokx aktar għaliha, u x-xogħol fl-isfond jista’ jużaha.';

  @override
  String get smimePassphraseRemoved => 'Il-frażi sigrieta tneħħiet.';

  @override
  String smimeTrustTitle(String name) {
    return 'Tafda f’$name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Kull ċertifikat li toħroġ ikun fdat għall-posta. L-ewwel qabbel il-fingerprint mas-sid tiegħu:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Tħassar iċ-ċertifikat tiegħek $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Tneħħi ċ-ċertifikat ta’ $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe tieqaf tużah: il-posta kriptata għalih ma tkunx tista’ tinqara aktar f’Loupe. Iċ-ċertifikat jibqa’ fuq dan l-apparat (Settings › Security › Encryption & credentials).';

  @override
  String get smimeDeleteOwnMessage =>
      'Iċ-ċavetta privata tiegħu titħassar minn dan l-apparat: il-posta kriptata għalih ma tkunx tista’ tinqara aktar hawn, sakemm ma terġax timportah.';

  @override
  String get smimeRemoveContactMessage => 'Jerġa’ lura mal-messaġġ iffirmat li jmiss minn din il-persuna.';

  @override
  String get smimeAddressImportFooter =>
      'Importa ċertifikat għal dan l-indirizz biex tiffirma u tikkripta b’S/MIME, kif jagħmel Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importa ċertifikat…';

  @override
  String get smimePreferFooter =>
      'Meta t-tnejn ikunu jistgħu jipproteġu messaġġ, jintuża dak ippreferut, sakemm l-ieħor biss ma jkollux ċavetta jew ċertifikat għal kull riċevitur.';

  @override
  String get smimePreferSmime => 'Ippreferi S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Minflok OpenPGP';

  @override
  String get smimeCertificatePassword => 'Password taċ-ċertifikat';

  @override
  String get smimeCertificatePasswordPrompt => 'Daħħal il-password li biha ġie esportat il-fajl taċ-ċertifikat.';

  @override
  String get smimeImport => 'Importa';

  @override
  String get smimeWrongPassword => 'Dik il-password hija żbaljata. Erġa’ pprova.';

  @override
  String get smimeNoCertificateFound => 'Ma nstab l-ebda ċertifikat.';

  @override
  String smimeCertificateOf(String name) {
    return 'iċ-ċertifikat ta’ $name';
  }

  @override
  String get smimeNothingNew => 'M’hemm xejn ġdid x’jiġi importat.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Ġew importati: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ġew importati $count awtorità fdata.',
      many: 'Ġew importati $count-il awtorità fdata.',
      few: 'Ġew importati $count awtoritajiet fdati.',
      two: 'Ġew importati $count awtoritajiet fdati.',
      one: 'Ġiet importata awtorità fdata.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ġew importati $certificates u $count awtorità fdata.',
      many: 'Ġew importati $certificates u $count-il awtorità fdata.',
      few: 'Ġew importati $certificates u $count awtoritajiet fdati.',
      two: 'Ġew importati $certificates u $count awtoritajiet fdati.',
      one: 'Ġew importati $certificates u awtorità fdata.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Dan il-fajl m’għandux ċavetta privata. Esporta ċ-ċertifikat tiegħek biċ-ċavetta privata tiegħu.';

  @override
  String get smimeImportAsYoursTitle => 'Timportah bħala ċ-ċertifikat tiegħek?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Dan l-anness fih ċertifikat biċ-ċavetta privata tiegħu: $names. Importah biss jekk esportajtu int stess, minn Outlook jew Thunderbird pereżempju.';
  }

  @override
  String get smimeImportAsMine => 'Importa bħala ċ-ċertifikat tiegħi';

  @override
  String smimeImportedOwn(String names) {
    return 'Iċ-ċertifikat tiegħek $names ġie importat.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Iċ-ċertifikat tiegħek $name ($addresses) ġie miżjud minn dan l-apparat.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Tafda f’“$name” għall-posta?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ma tafx din l-awtorità taċ-ċertifikazzjoni (forsi ta’ xi kumpanija). Afdaha biex tiċċekkja ċ-ċertifikati li toħroġ. L-ewwel qabbel il-fingerprint tagħha mad-dipartiment tal-IT tiegħek:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hemm $count ċertifikat mehmuż.',
      many: 'Hemm $count-il ċertifikat mehmuż.',
      few: 'Hemm $count ċertifikati mehmuża.',
      two: 'Hemm $count ċertifikati mehmuża.',
      one: 'Hemm ċertifikat mehmuż.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importa ċ-ċertifikat';

  @override
  String get smimeUnlockTitle => 'Iftaħ iċ-ċertifikat S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Daħħal il-frażi sigrieta taċ-ċertifikat ta’ $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Dik il-frażi sigrieta hija żbaljata. Erġa’ pprova.';

  @override
  String get smimeUnlock => 'Iftaħ';

  @override
  String get smimeEnterAPassphrase => 'Daħħal frażi sigrieta.';

  @override
  String get smimePassphrasesDiffer => 'Iż-żewġ frażijiet sigrieti huma differenti.';

  @override
  String get smimeSetPassphraseTitle => 'Issettja frażi sigrieta';

  @override
  String get smimeSetPassphraseText =>
      'Loupe titolbok għaliha biex tiffirma u tiddekripta. Jekk tinsieha, erġa’ importa ċ-ċertifikat mill-fajl .p12 tiegħu.';

  @override
  String get smimePassphraseAgain => 'Għal darb’oħra';

  @override
  String get smimeSetPassphraseButton => 'Issettja';

  @override
  String get smimeLockedOpenAgain => 'Iċ-ċertifikat S/MIME tiegħek huwa msakkar. Erġa’ iftaħ il-messaġġ biex tiftħu.';

  @override
  String get smimeDeviceHasNoCertificates => 'Dan l-apparat ma joffrix iċ-ċertifikati tiegħu.';

  @override
  String get smimeCantReadCertificate => 'Loupe ma tistax taqra dan iċ-ċertifikat.';

  @override
  String get smimeCertificateNotForMail =>
      'Dan iċ-ċertifikat mhuwiex għall-posta: m’għandux indirizz tal-imejl, jew mhuwiex maħsub għall-iffirmar jew għall-kriptaġġ.';

  @override
  String get smimeDeviceCertificateGone =>
      'Iċ-ċertifikat m’għadux fuq dan l-apparat, jew Loupe ma tistax tużah aktar. Erġa’ agħżlu f’Settings › Kriptaġġ minn tarf għal tarf.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Iċ-ċertifikat fuq dan l-apparat jista’ jintuża biss waqt li Loupe tkun miftuħa.';

  @override
  String get smimeDeviceKeyDamaged => 'Iċ-ċavetta kriptata għandha ħsara.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Iċ-ċertifikat fuq dan l-apparat ma jistax jagħmel dan: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'mhux appoġġjat';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Iċ-ċertifikat fuq dan l-apparat falla: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'L-indirizz tal-awtorità mhuwiex indirizz web.';

  @override
  String get smimeAuthorityTimeout => 'L-awtorità taċ-ċertifikazzjoni ma wieġbitx fil-ħin.';

  @override
  String get smimeAuthorityUnreachable => 'L-awtorità taċ-ċertifikazzjoni ma setgħetx tintlaħaq.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'L-awtorità taċ-ċertifikazzjoni wieġbet $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'It-tweġiba tal-awtorità taċ-ċertifikazzjoni hija kbira wisq.';

  @override
  String get smimeRevocationNotChecked =>
      'Mhux iċċekkjat: jiġu ċċekkjati biss ċertifikati minn awtorità li Loupe tafda.';

  @override
  String get settingsLanguage => 'Lingwa';

  @override
  String get settingsLanguageSystem => 'L-istess bħall-mowbajl';

  @override
  String get settingsLanguageFooter =>
      'Loupe tuża l-lingwa tal-mowbajl tiegħek meta jkollha, u l-Ingliż meta ma jkollhiex. Il-lingwa li tagħżel hawn hija għal Loupe biss, inklużi n-notifiki.';

  @override
  String get settingsAccountsHeader => 'Kontijiet';

  @override
  String get settingsAddAccount => 'Żid kont';

  @override
  String get settingsMailHeader => 'Posta';

  @override
  String get settingsSwipeActions => 'Azzjonijiet tas-swipe';

  @override
  String get settingsSwipeLeft => 'Swipe lejn ix-xellug';

  @override
  String get settingsSwipeLeftFooter =>
      'Swipe sħiħ iħaddem din l-azzjoni. “Immarka b’bandiera” u “Aktar” huma dejjem swipe qasir ’il bogħod.';

  @override
  String get settingsSwipeRight => 'Swipe lejn il-lemin';

  @override
  String get settingsSwipeRightFooter => 'Swipe sħiħ iħaddem din l-azzjoni.';

  @override
  String get settingsSwipeToggleRead => 'Immarka bħala moqri / mhux moqri';

  @override
  String get settingsSwipeTrash => 'Ċaqlaq għall-Iskart';

  @override
  String get settingsSwipeMove => 'Ċaqlaq il-messaġġ';

  @override
  String get settingsSwipeSnooze => 'Ipposponi';

  @override
  String get settingsThreaded => 'Organizza skont il-konversazzjoni';

  @override
  String get settingsUndoSendDelay => 'Ħin biex tirtira l-bgħit';

  @override
  String get settingsUndoSendDelayFooter => 'Il-messaġġi mibgħuta jistennew dan iż-żmien, biex tkun tista’ tirtirahom.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekonda',
      many: '$seconds-il sekonda',
      few: '$seconds sekondi',
      two: '$seconds sekondi',
      one: '$seconds sekonda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Dehra';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Awtomatika';

  @override
  String get settingsThemeLight => 'Ċara';

  @override
  String get settingsThemeDark => 'Skura';

  @override
  String get settingsDensity => 'Lista tal-messaġġi';

  @override
  String get settingsDensityComfortable => 'Komda';

  @override
  String get settingsDensityCompact => 'Kompatta';

  @override
  String get settingsReadingHeader => 'Qari';

  @override
  String get settingsReadingFooter => 'L-istampi remoti jistgħu jgħidu lill-mittenti meta u fejn ftaħt messaġġ.';

  @override
  String get settingsDefaultView => 'Veduta default';

  @override
  String get settingsDefaultViewFooter => 'Tista’ tibdel il-veduta ta’ kwalunkwe messaġġ bil-buttuna Aa.';

  @override
  String get settingsViewReadable => 'Leġġibbli';

  @override
  String get settingsViewReadableDetail => 'Nadifa, tinqara faċilment, issegwi l-modalità skura';

  @override
  String get settingsViewOriginal => 'Oriġinali';

  @override
  String get settingsViewOriginalDetail => 'Eżatt kif iddisinjah il-mittent';

  @override
  String get settingsViewPlain => 'Test sempliċi';

  @override
  String get settingsViewPlainDetail => 'Il-kliem biss';

  @override
  String get settingsPlainTextFont => 'Tipa tat-test sempliċi';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monospace';

  @override
  String get settingsFontMonoDetail => 'Iżomm l-arti ASCII u t-tabelli allinjati';

  @override
  String get settingsTechnicalLists => 'Listi tekniċi';

  @override
  String get settingsLoadRemoteImages => 'Għabbi l-istampi remoti';

  @override
  String get settingsOpenLinksDirectly => 'Iftaħ il-links direttament';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Aqbeż it-trackers tal-klikks meta d-destinazzjoni tkun magħrufa';

  @override
  String get settingsSecurityHeader => 'Sigurtà';

  @override
  String get settingsAppLock => 'Qafla għall-app';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe titlob meta tibda, u meta terġa’ lura wara li tkun ilek ’il bogħod aktar mill-ħin ta’ “Sakkar wara”.';

  @override
  String get settingsAppLockFooterOff =>
      'Il-Qafla għall-app titlob il-marka tas-saba’, il-wiċċ jew il-qafla tal-iskrin tiegħek qabel ma tidher il-posta tiegħek.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Il-Qafla għall-app għadha mitfija. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Issettja passcode';

  @override
  String get settingsScreenLockTextIos =>
      'Il-Qafla għall-app tuża Face ID, Touch ID jew il-passcode tiegħek, u dan l-iPhone m’għandux passcode. Issettja wieħed fl-app Settings, imbagħad ixgħel il-Qafla għall-app.';

  @override
  String get settingsScreenLockTitleAndroid => 'Issettja qafla tal-iskrin';

  @override
  String get settingsScreenLockTextAndroid =>
      'Il-Qafla għall-app tuża l-qafla tal-iskrin tal-mowbajl tiegħek, jew marka tas-saba’ jew wiċċ miżjud magħha, u dan il-mowbajl m’għandu xejn minn dawn. Issettja PIN, pattern jew password fis-settings ta’ Android, imbagħad ixgħel il-Qafla għall-app.';

  @override
  String get settingsOpenSystemSettings => 'Iftaħ is-Settings';

  @override
  String get settingsOpenAndroidSettings => 'Iftaħ is-settings ta’ Android';

  @override
  String get settingsLockAfter => 'Sakkar wara';

  @override
  String get settingsLockAfterFooter => 'Kemm tista’ Loupe tkun fl-isfond qabel ma terġa’ titlob.';

  @override
  String get settingsNotifications => 'Notifiki';

  @override
  String get settingsEncryption => 'Kriptaġġ minn tarf għal tarf';

  @override
  String get settingsAdvanced => 'Avvanzat';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Il-posta demo hija mailbox ivvintata li teżisti biss fuq dan il-mowbajl. Xejn ma jintbagħat x’imkien.';

  @override
  String get settingsDemoMode => 'Modalità demo';

  @override
  String get settingsResetApp => 'Irrisettja l-app';

  @override
  String get settingsResetFooter => 'Tinsa s-settings kollha u tmur lura għall-iskrin ta’ merħba.';

  @override
  String get settingsResetTitle => 'Tirrisettja Loupe?';

  @override
  String get settingsResetMessage =>
      'Dan jinsa kull setting, Smart Mailbox u tfittxija reċenti, u jmur lura għall-iskrin ta’ merħba.';

  @override
  String get settingsAboutHeader => 'Dwar';

  @override
  String get settingsVersion => 'Verżjoni';

  @override
  String get settingsLicences => 'Liċenzji';

  @override
  String get settingsPrivacy => 'Privatezza';

  @override
  String get settingsPrivacyDetail =>
      'Loupe m’għandha l-ebda analitika u l-ebda traċċar. Il-posta tiegħek tmur biss għas-servers tal-imejl tiegħek.';

  @override
  String get settingsNotificationsOffIos => 'In-notifiki ta’ Loupe huma mitfija f’Settings.';

  @override
  String get settingsNotificationsOffAndroid => 'In-notifiki ta’ Loupe huma mitfija fis-settings ta’ Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system ma jħallix lil Loupe turi notifiki. Ippermettihom fis-Settings.';
  }

  @override
  String get settingsNewMailHeader => 'Posta ġdida';

  @override
  String get settingsNewMailFooterDemo =>
      'Il-posta demo ma tasalx fl-isfond. Ibgħat notifika tat-test biex tara kif tidher posta ġdida.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe tiċċekkja għal posta ġdida fl-isfond meta jħalliha iOS, u dan jista’ jkun bi sigħat bejn darba u oħra għal apps li ma tiftaħx spiss. Tiġi mgħarraf b’messaġġi ġodda fl-inboxes tiegħek, u b’dawk mill-VIPs f’kull folder.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe tiċċekkja għal posta ġdida madwar kull 15-il minuta, meta jħalliha Android. Tiġi mgħarraf b’messaġġi ġodda fl-inboxes tiegħek, u b’dawk mill-VIPs f’kull folder.';

  @override
  String get settingsNoAccounts => 'L-ebda kont';

  @override
  String get settingsVipOnly => 'VIP biss';

  @override
  String get settingsVipOnlyDetail => 'Messaġġi mill-VIPs tiegħek biss';

  @override
  String get settingsHideContent => 'Aħbi l-kontenut';

  @override
  String get settingsHideContentFooterOn =>
      'In-notifiki jgħidu biss “Messaġġ ġdid minn” u l-kont, mhux min kiteb jew dwar xiex.';

  @override
  String get settingsHideContentFooterOff =>
      '“Aħbi l-kontenut” iżomm il-mittent, is-suġġett u l-preview ’il bogħod mill-iskrin imsakkar u min-notifiki.';

  @override
  String get settingsBackgroundAppRefresh => 'Background App Refresh';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Il-posta ġdida tasal fl-isfond biss meta Background App Refresh ikun mixgħul għal Loupe f’Settings. iOS ma jistax iżomm konnessjoni miftuħa mal-inboxes tiegħek, għalhekk m’hemmx Twassil immedjat.';

  @override
  String get settingsInstantDelivery => 'Twassil immedjat';

  @override
  String get settingsInstantDeliveryFooter =>
      'It-Twassil immedjat (sperimentali) iżomm konnessjoni miftuħa mal-inboxes tiegħek, biex il-posta ġdida tasal fi ftit sekondi. Juri notifika kwieta “Qed tistenna posta ġdida” u juża aktar batterija.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android jista’ jwaqqaf it-Twassil immedjat biex jiffranka l-batterija. Ħalli lil Loupe tuża l-batterija mingħajr restrizzjonijiet biex jibqa’ jaħdem.';

  @override
  String get settingsExperimental => 'Sperimentali';

  @override
  String get settingsComingSoon => 'Dalwaqt';

  @override
  String get settingsAllowUnrestrictedBattery => 'Ippermetti użu tal-batterija mingħajr restrizzjonijiet';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Il-push iħalli l-posta ġdida tqajjem lil Loupe minnufih, fejn is-servizz tal-imejl tiegħek jappoġġjah. Il-pushes jgħaddu mis-servizz tal-push ta’ Google u ma fihom l-ebda posta, biss “iċċekkja issa”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Dan il-mowbajl ma jistax jirċievi pushes: għandhom bżonn Google Play services u konnessjoni man-network. Loupe xorta tiċċekkja l-posta madwar kull 15-il minuta.';

  @override
  String get settingsCopyPushToken => 'Ikkopja t-token tal-push';

  @override
  String get settingsPushTokenCopied => 'It-token tal-push ġie kkupjat';

  @override
  String get settingsSendTestNotification => 'Ibgħat notifika tat-test';

  @override
  String get settingsAppIconBadge => 'Badge fuq l-ikona tal-app';

  @override
  String get settingsBadgeNote => 'Il-badge jiġi aġġornat kull meta Loupe tiċċekkja l-posta, anki fl-isfond.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'L-iskrin ewlieni ta’ dan il-mowbajl ma jurix numri fuq l-ikoni tal-apps. Il-badge jiġi aġġornat kull meta Loupe tiċċekkja l-posta, anki fl-isfond.';

  @override
  String get settingsTestNotificationBody => 'In-notifiki għal posta ġdida jidhru hekk.';

  @override
  String get settingsAccountRemoved => 'Dan il-kont tneħħa.';

  @override
  String get settingsAccountHeader => 'Kont';

  @override
  String get settingsAccountDescription => 'Deskrizzjoni';

  @override
  String get settingsAccountDescriptionHint => 'Xogħol, Personali…';

  @override
  String get settingsEmail => 'Imejl';

  @override
  String get settingsColour => 'Kulur';

  @override
  String get settingsColourFooter => 'Jimmarka l-messaġġi ta’ dan il-kont fl-Inboxes kollha.';

  @override
  String settingsColourNumber(int number) {
    return 'Kulur $number';
  }

  @override
  String get settingsSendingHeader => 'Bgħit';

  @override
  String get settingsSendingFooter =>
      'Kull identità għandha l-firma tagħha. It-tweġibiet joħorġu mill-indirizz li ntbagħat lilu l-messaġġ.';

  @override
  String get settingsFoldersHeader => 'Folders';

  @override
  String get settingsFoldersFooter =>
      'Loupe turi u tissinkronizza l-folders li int abbonat fihom, kif jagħmel Thunderbird. Inbox, Abbozzi, Mibgħuta, Spam, Skart u Arkivju jidhru dejjem.';

  @override
  String get settingsShowAllFolders => 'Uri l-folders kollha';

  @override
  String get settingsIncoming => 'Dieħel';

  @override
  String get settingsOutgoing => 'Ħiereġ';

  @override
  String get settingsConnectionNotEncrypted => 'Mhux kriptata';

  @override
  String get settingsSignIn => 'Dħul';

  @override
  String get settingsSignInExpired => 'Skada';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider m’għadux jaċċetta d-dħul ta’ Loupe għal dan il-kont, għalhekk il-posta tiegħu mhix qed tissinkronizza. Erġa’ idħol biex tirranġaha.';
  }

  @override
  String get settingsSignInAgain => 'Erġa’ idħol';

  @override
  String get settingsSigningIn => 'Qed tidħol…';

  @override
  String get settingsRemoveAccount => 'Neħħi l-kont';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Tneħħi “$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Il-posta u s-settings tiegħu jitneħħew minn dan il-mowbajl. Xejn ma jitħassar fuq is-server.';

  @override
  String get settingsManageFolders => 'Immaniġġja l-folders';

  @override
  String get settingsNoFolders => 'Għad m’hemmx folders.';

  @override
  String get settingsManageFoldersFooter =>
      'Il-folders abbonati jidhru fuq l-iskrin tal-Mailboxes u jissinkronizzaw fl-isfond. Apps oħra tal-imejl fuq l-istess kont normalment isegwu dawn l-abbonamenti wkoll.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Iżomm is-Smart Mailboxes tiegħek għall-apparati l-oħra tiegħek. Moħbi fuq l-iskrin tal-Mailboxes.';

  @override
  String get settingsFolderAlwaysShown => 'Dejjem muri';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abbona f’$folder';
  }

  @override
  String get settingsIdentities => 'Identitajiet';

  @override
  String get settingsIdentitiesFooterReorder =>
      'L-ewwel identità hija d-default għal messaġġi ġodda. Kaxkar biex tibdel l-ordni.';

  @override
  String get settingsIdentitiesFooterSingle => 'L-identità default għal messaġġi ġodda.';

  @override
  String get settingsIdentitiesReplyFooter => 'Tweġiba toħroġ mill-identità li ntbagħat lilha l-messaġġ.';

  @override
  String get settingsIdentityDefault => 'Default';

  @override
  String settingsIdentityReorder(String email) {
    return 'Ibdel il-pożizzjoni ta’ $email';
  }

  @override
  String get settingsAddIdentity => 'Żid identità';

  @override
  String get settingsNewIdentity => 'Identità ġdida';

  @override
  String get settingsIdentity => 'Identità';

  @override
  String get settingsIdentityNameHint => 'Ismek';

  @override
  String get settingsReplyTo => 'Wieġeb lil';

  @override
  String get settingsSignature => 'Firma';

  @override
  String get settingsSignatureFooter => 'Tiżdied taħt “-- ” fil-messaġġi minn din l-identità.';

  @override
  String get settingsNoSignature => 'L-ebda firma';

  @override
  String get settingsCopyToMyself => 'Kopja lili nnifsi';

  @override
  String get settingsCopyToMyselfFooter => 'Jiżdiedu ma’ kull messaġġ minn din l-identità.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Uża għal tweġibiet lil';

  @override
  String get settingsReplyPatternsFooter =>
      'It-tweġibiet għal messaġġi mibgħuta lil dawn l-indirizzi joħorġu minn din l-identità. * tfisser kwalunkwe ħaġa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Indirizz, jew mudell fejn * tfisser kwalunkwe ħaġa.';

  @override
  String get settingsAddReplyPattern => 'Żid indirizz jew mudell';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Neħħi $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Mudell invalidu';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” mhuwiex indirizz jew mudell bħal *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'L-ebda indirizz';

  @override
  String get settingsIdentityNoAddressMessage => 'Daħħal l-indirizz tal-imejl li minnu tibgħat.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Indirizz invalidu';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Wieġeb lil: “$address” mhuwiex indirizz tal-imejl validu.',
      'cc': 'Cc: “$address” mhuwiex indirizz tal-imejl validu.',
      'bcc': 'Bcc: “$address” mhuwiex indirizz tal-imejl validu.',
      'other': '“$address” mhuwiex indirizz tal-imejl validu.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Aħżen l-identità';

  @override
  String get settingsDiscardChanges => 'Armi l-bidliet';

  @override
  String get settingsDeleteIdentity => 'Ħassar l-identità';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Tħassar “$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Il-messaġġi diġà mibgħuta minnha jibqgħu kif inhuma.';

  @override
  String get settingsLastIdentityFooter => 'Kont għandu bżonn mill-inqas identità waħda.';

  @override
  String get rulesTitle => 'Regoli';

  @override
  String get rulesNewRule => 'Regola ġdida';

  @override
  String get rulesLoadError => 'Ir-regoli ma setgħux jitgħabbew.';

  @override
  String get rulesEmptyTitle => 'L-ebda regola';

  @override
  String get rulesEmptyText =>
      'Ir-regoli jqassmu, jittikkettjaw u jimmarkaw b’bandiera l-posta ġdida għalik. Agħmel waħda bil-buttuna tal-kitba hawn fuq, jew minn tfittxija b’“Agħmilha regola”.';

  @override
  String get rulesListFooter =>
      'Ir-regoli jaħdmu minn fuq għal isfel fuq il-posta ġdida fl-Inbox. Żomm regola magħfusa biex iċċaqlaqha.';

  @override
  String get rulesChangeError => 'Ir-regola ma setgħetx tinbidel';

  @override
  String get rulesConditionEveryMessage => 'Kull messaġġ';

  @override
  String rulesMoveRule(String rule) {
    return 'Ċaqlaq $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule mixgħula';
  }

  @override
  String get rulesServerRulesHeader => 'Regoli fuq is-server';

  @override
  String get rulesServerRulesFooter =>
      'Ir-regoli fuq is-server jaħdmu fuq is-server tal-imejl hekk kif tasal il-posta, anki meta dan il-mowbajl ikun mitfi. Jinżammu fi skript Sieve jismu “loupe”.';

  @override
  String get rulesStatusUnknown => 'Mhux magħruf';

  @override
  String get rulesStatusError => 'Ma setgħetx issir mistoqsija lis-server.';

  @override
  String get rulesStatusChecking => 'Qed jiġi ċċekkjat…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Jitħaddmu minn “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” huwa l-iskript attiv. Agħfas biex tħallih iħaddem ir-regoli ta’ Loupe wkoll.';
  }

  @override
  String get rulesStatusNoScript =>
      'L-ebda skript mhu attiv fuq is-server. Meta taħżen regola fuq is-server, jinxtegħel dak ta’ Loupe.';

  @override
  String get rulesStatusUnavailable => 'Mhux disponibbli';

  @override
  String get rulesStatusNoSieve => 'Is-server ta’ dan il-kont ma joffrix Sieve (ManageSieve jew JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Ċaqlaq għal $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Ċaqlaq għal folder';

  @override
  String rulesActionTag(String tag) {
    return 'Ittikkettja $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Neħħi t-tikketta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Żomm fl-Inbox';

  @override
  String rulesActionForward(String address) {
    return 'Għaddi lil $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Għaddi lil $address, żżommx kopja';
  }

  @override
  String get rulesActionStop => 'Ieqaf';

  @override
  String get rulesNoActions => 'Għadha ma tagħmel xejn';

  @override
  String get rulesLocationDevice => 'Apparat';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Dan l-apparat';

  @override
  String get rulesNewRuleTitle => 'Regola ġdida';

  @override
  String get rulesEditRuleTitle => 'Editja r-regola';

  @override
  String get rulesDefaultNameEveryMessage => 'Kull messaġġ';

  @override
  String get rulesConditionHeader => 'Meta messaġġ ġdid jaqbel ma’';

  @override
  String get rulesConditionFooter =>
      'Iktibha kif tfittex: from:, to:, s: (suġġett), b: (kontenut), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:fattura';

  @override
  String get rulesAccounts => 'Kontijiet';

  @override
  String get rulesAllAccounts => 'Il-kontijiet kollha';

  @override
  String get rulesRemovedAccount => 'Kont imneħħi';

  @override
  String get rulesAccountsFooter => 'Regola għall-kontijiet kollha tkopri wkoll il-kontijiet li żżid aktar tard.';

  @override
  String get rulesActionsHeader => 'Imbagħad';

  @override
  String get rulesForwardingFooter =>
      'B’Għaddi, kull messaġġ li jaqbel jintbagħat lil indirizz ieħor hekk kif jasal, anki meta dan il-mowbajl ikun mitfi. Xi fornituri jillimitaw kemm posta tista’ tingħadda.';

  @override
  String get rulesForwardingHiddenFooter => 'Għaddi jaħdem biss fir-regoli fuq is-server, għalhekk mhuwiex muri hawn.';

  @override
  String rulesRemoveAction(String action) {
    return 'Neħħi $action';
  }

  @override
  String get rulesAddAction => 'Żid azzjoni';

  @override
  String get rulesAddMove => 'Ċaqlaq għal folder…';

  @override
  String get rulesAddTagMenu => 'Żid tikketta…';

  @override
  String get rulesRemoveTagMenu => 'Neħħi tikketta…';

  @override
  String get rulesAddForward => 'Għaddi lil…';

  @override
  String get rulesStopProcessing => 'Tipproċessax aktar regoli';

  @override
  String get rulesRunOnHeader => 'Ħaddem fuq';

  @override
  String get rulesRunOnDeviceFooter =>
      'Dan l-apparat iħaddem ir-regola fuq il-posta l-ġdida fl-Inbox kull darba li Loupe tiċċekkja l-posta.';

  @override
  String get rulesRunOnServerFooter =>
      'Is-server tal-imejl iħaddem ir-regola hekk kif tasal il-posta, anki meta dan il-mowbajl ikun mitfi. Jeħtieġ Sieve, permezz ta’ ManageSieve (Dovecot, mailcow) jew JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Applika għall-messaġġi eżistenti…';

  @override
  String get rulesDeleteRule => 'Ħassar ir-regola';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Tħassar “$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Folder f’liema kont?';

  @override
  String get rulesMoveAccountMessage => 'Il-posta tal-kontijiet l-oħra tmur fil-folder bl-istess isem hemmhekk.';

  @override
  String get rulesAddTag => 'Żid tikketta';

  @override
  String get rulesRemoveTag => 'Neħħi tikketta';

  @override
  String get rulesForwardTo => 'Għaddi lil';

  @override
  String get rulesForwardToMessage =>
      'Is-server jibgħat kull messaġġ li jaqbel lil dan l-indirizz, anki meta dan il-mowbajl ikun mitfi. Uża indirizz li huwa tiegħek jew li tafda.';

  @override
  String get rulesNotAnAddressTitle => 'Mhux indirizz tal-imejl';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address” mhuwiex indirizz li tista’ tgħaddi lilu.';
  }

  @override
  String get rulesKeepCopyTitle => 'Iżżomm kopja hawn?';

  @override
  String get rulesKeepCopy => 'Żomm kopja';

  @override
  String get rulesDontKeepCopy => 'Iżżommx kopja';

  @override
  String get rulesCheckCondition => 'Iċċekkja l-kundizzjoni';

  @override
  String get rulesChooseActionTitle => 'Agħżel azzjoni';

  @override
  String get rulesChooseActionMessage => 'Żid x’tagħmel ir-regola bil-messaġġi li jaqblu magħha.';

  @override
  String get rulesSaveError => 'Ir-regola ma setgħetx tinħażen';

  @override
  String get rulesSaveServerError => 'Ir-regola fuq is-server ma setgħetx tinħażen';

  @override
  String get rulesRunOnDeviceInstead => 'Minflok, ħaddimha fuq dan l-apparat';

  @override
  String get rulesNothingToApplyTitle => 'Xejn x’tapplika';

  @override
  String get rulesNothingToApplyMessage => 'L-ewwel agħti lir-regola kundizzjoni li taħdem u azzjoni.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Applika “$rule” għall-messaġġi f’…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inboxes';

  @override
  String get rulesApplyScopeAll => 'Il-mailboxes kollha';

  @override
  String get rulesFindingMessages => 'Qed jinstabu l-messaġġi…';

  @override
  String get rulesSearchError => 'It-tfittxija ma setgħetx issir';

  @override
  String get rulesSearchErrorUnknown => 'Xi ħaġa marret ħażin.';

  @override
  String get rulesNoMatchesTitle => 'L-ebda messaġġ ma jaqbel';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Xejn hemmhekk ma jaqbel ma’ “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tapplika “$rule” għal $countString messaġġ?',
      many: 'Tapplika “$rule” għal $countString-il messaġġ?',
      few: 'Tapplika “$rule” għal $countString messaġġi?',
      two: 'Tapplika “$rule” għal $countString messaġġi?',
      one: 'Tapplika “$rule” għal $countString messaġġ?',
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
      other: 'Applika għal $countString messaġġ',
      many: 'Applika għal $countString-il messaġġ',
      few: 'Applika għal $countString messaġġi',
      two: 'Applika għal $countString messaġġi',
      one: 'Applika għal $countString messaġġ',
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
      other: '“$rule” ġiet applikata għal $countString messaġġ',
      many: '“$rule” ġiet applikata għal $countString-il messaġġ',
      few: '“$rule” ġiet applikata għal $countString messaġġi',
      two: '“$rule” ġiet applikata għal $countString messaġġi',
      one: '“$rule” ġiet applikata għal $countString messaġġ',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Qed jiġi mistoqsi s-server x’jista’ jagħmel…';

  @override
  String get rulesServerUnreachable => 'Is-server ma setax jintlaħaq.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ma tistax taħdem fuq is-server: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ma tistax taħdem fuq is-server ta’ $account: $problem';
  }

  @override
  String get rulesShowScript => 'Uri l-iskript';

  @override
  String get rulesHideScript => 'Aħbi l-iskript';

  @override
  String get rulesMatchingHeader => 'Messaġġi li jaqblu';

  @override
  String get rulesMatchingHeaderLoading => 'Messaġġi li jaqblu…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString messaġġ li jaqblu',
      many: '$countString-il messaġġ li jaqblu',
      few: '$countString messaġġi li jaqblu',
      two: '$countString messaġġi li jaqblu',
      one: '$countString messaġġ li jaqbel',
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
      other: '$countString+ messaġġ li jaqblu',
      many: '$countString+ messaġġ li jaqblu',
      few: '$countString+ messaġġi li jaqblu',
      two: '$countString+ messaġġi li jaqblu',
      one: '$countString+ messaġġ li jaqbel',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Mill-aħħar 30 jum. Ir-regola nfisha taġixxi biss fuq posta ġdida, sakemm ma tapplikahiex għall-messaġġi eżistenti.';

  @override
  String rulesConditionError(String error) {
    return 'Il-kundizzjoni fiha żball: $error';
  }

  @override
  String get rulesPreviewNoSender => '(l-ebda mittent)';

  @override
  String get rulesPreviewNoSubject => '(mingħajr suġġett)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'u $countString oħra',
      one: 'u $countString ieħor',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Xejn mill-aħħar 30 jum.';

  @override
  String get rulesIncludeTitle => 'Ixgħel ir-regoli fuq is-server';

  @override
  String get rulesIncludeLeaveOff => 'Ħallihom mitfija';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Is-server diġà jħaddem ir-regoli ta’ Loupe għal $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” huwa l-iskript attiv fuq is-server ta’ $account, għalhekk is-server iħaddem lilu u mhux ir-regoli ta’ Loupe. Loupe mhix se tissostitwih. Tista’ żżidlu dawn il-linji, u mbagħad is-server iħaddem ir-regoli ta’ Loupe wara dawk tal-iskript innifsu:';
  }

  @override
  String get rulesShowWholeScript => 'Uri l-iskript kollu';

  @override
  String get rulesHideWholeScript => 'Aħbi l-iskript kollu';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Xejn ieħor f’“$script” ma jinbidel. Jekk il-filtri tiegħu jiġu editjati aktar tard fil-webmail, il-webmail jista’ jerġa’ jiktbu mingħajr dawn il-linji; imbagħad Loupe terġa’ turi r-regoli fuq is-server bħala mitfija.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Żid ma’ “$script”';
  }

  @override
  String get subscriptionsTitle => 'Abbonamenti';

  @override
  String get subscriptionsNewsletters => 'Newsletters';

  @override
  String get subscriptionsDiscussions => 'Diskussjonijiet';

  @override
  String get subscriptionsFilter => 'Iffiltra';

  @override
  String get subscriptionsFilterNeverRead => 'Qatt moqrija';

  @override
  String get subscriptionsFilterRarelyRead => 'Rarament moqrija';

  @override
  String get subscriptionsFilterAll => 'Kollha';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'L-abbonamenti ma setgħux jingħaddu';

  @override
  String get subscriptionsNoMatches => 'L-ebda riżultat';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'L-ebda newsletter ma jisimha “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'L-ebda lista ma jisimha “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'L-ebda newsletter';

  @override
  String get subscriptionsNoNewslettersDetail => 'In-newsletters u posta oħra bl-ingrossa jidhru hawn hekk kif jaslu.';

  @override
  String get subscriptionsNothingNeverRead => 'Xejn f’“Qatt moqrija”';

  @override
  String get subscriptionsNothingRarelyRead => 'Xejn f’“Rarament moqrija”';

  @override
  String get subscriptionsNothingFilteredDetail => 'Taqra ftit minn kull ma tirċievi.';

  @override
  String get subscriptionsNoDiscussions => 'L-ebda diskussjoni';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Il-mailing lists li tista’ tikteb fihom jidhru hawn hekk kif tasal il-posta tagħhom.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listi li jiktbu fihom diversi nies. Żomm waħda magħfusa biex twaħħalha mal-Mailboxes, taqraha bħala test sempliċi, jew iċċaqlaqha għal Newsletters.';

  @override
  String get subscriptionsPrivacyNote =>
      'Magħdud fuq dan il-mowbajl mill-posta li niżżel; xejn ma jintbagħat x’imkien biex isir dan il-kalkolu. Loupe tikkuntattja mittent biss meta tagħfas “Neħħi l-abbonament”: il-klikk waħda tibgħat biss “List-Unsubscribe=One-Click” lill-indirizz li ta l-mittent, mingħajr cookies u mingħajr xejn ieħor dwarek, u qatt ma ttella’ l-paġni jew l-istampi tiegħu.';

  @override
  String get subscriptionsVolumeNone => 'Xejn dan l-aħħar';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / xahar';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / xahar';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'moqri $percent';
  }

  @override
  String get subscriptionsStillSending => 'Għadu jibgħat';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'L-abbonament tneħħa: $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Il-paġna biex tneħħi l-abbonament infetħet: $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Għafsa waħda · jikkuntattja $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Bl-imejl lil $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Fuq is-sit $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Neħħi l-abbonament';

  @override
  String get subscriptionsUnsubscribeAgain => 'Erġa’ neħħi l-abbonament';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arkivja $countString fl-Inbox');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Oħloq regola…';

  @override
  String get subscriptionsCreateRuleDetail => 'Ċaqlaq jew arkivja l-posta futura tiegħu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Ittrattaha bħala diskussjoni';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Lista li n-nies jiktbu fiha: aqraha bħal forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Ittrattaha bħala newsletter';

  @override
  String get subscriptionsBlockSender => 'Imblokka l-mittent';

  @override
  String get subscriptionsBlock => 'Imblokka';

  @override
  String get subscriptionsBlocked => 'Imblukkat';

  @override
  String get subscriptionsBlockedDetail => 'Il-posta l-ġdida tmur fl-Ispam';

  @override
  String get subscriptionsPin => 'Waħħal mal-Mailboxes';

  @override
  String get subscriptionsUnpin => 'Neħħi mill-Mailboxes';

  @override
  String get subscriptionsOpenDefaultView => 'Iftaħ fil-veduta default';

  @override
  String get subscriptionsOpenPlainText => 'Iftaħ bħala test sempliċi (Mono)';

  @override
  String get subscriptionsPinned => 'Imwaħħla';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString mhux moqrija',
      one: '$countString mhux moqri',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Bħalissa m’hemmx posta minn dan il-mittent.';

  @override
  String get subscriptionsLatestMessages => 'L-AĦĦAR MESSAĠĠI';

  @override
  String get subscriptionsMail => 'Posta';

  @override
  String get subscriptionsNoneIn90Days => 'Xejn f’90 jum';

  @override
  String get subscriptionsRead => 'Moqri';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString minn $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'L-aħħar riċevut';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Folders', one: 'Folder');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Għadu jibgħat';

  @override
  String get subscriptionsUnsubscribedTitle => 'Abbonament imneħħi';

  @override
  String subscriptionsSince(String date) {
    return 'minn $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'il-paġna nfetħet: $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender ma jgħidx kif tneħħi l-abbonament.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender ma jgħidx kif tneħħi l-abbonament. Minflok, tista’ timblokkah.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Qed jitneħħa l-abbonament minn $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'L-abbonament ma’ $sender tneħħa.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'L-abbonament ma setax jitneħħa: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'L-abbonament ma setax jitneħħa awtomatikament';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Ibgħat imejl biex tneħħi l-abbonament';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Iftaħ $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Tiftaħ $site?';
  }

  @override
  String get subscriptionsOpen => 'Iftaħ';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender ineħħi l-abbonamenti fuq is-sit web tiegħu. Il-paġna tiftaħ fil-browser ta’ Loupe; temm il-proċess hemmhekk.';
  }

  @override
  String get subscriptionsWebInsecure => 'Il-konnessjoni ma’ dan is-sit mhix kriptata.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Attent: dan l-indirizz jimita $site b’ittri li jixbhu lil oħrajn.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Attent: dan l-indirizz jimita sit ieħor b’ittri li jixbhu lil oħrajn.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site ma setax jinfetaħ.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe tieħu nota tad-data tal-lum u tgħidlek jekk $sender jibqa’ jikteb.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Tneħħi l-abbonament ma’ $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe se tikkuntattja $site biex tneħħi l-abbonament.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Din hija l-unika darba li Loupe tikkuntattja s-sit web ta’ mittent. Tibgħat biss “List-Unsubscribe=One-Click” lill-indirizz li ta $sender, mingħajr cookies jew xi ħaġa oħra dwarek, u ma ttellax il-paġna.';
  }

  @override
  String get subscriptionsOneClickNotAllowed =>
      'Il-link biex tneħħi l-abbonament mhuwiex indirizz sigur fuq l-internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site ma wieġibx fil-ħin.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site ma setax jintlaħaq.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site bagħat it-talba lil paġna oħra, li Loupe ma ssegwix.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site irrifjuta t-talba (żball $status).';
  }

  @override
  String get subscriptionsNoAccountToSend =>
      'M’hemm l-ebda kont li minnu jista’ jintbagħat l-imejl biex jitneħħa l-abbonament.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe se tibgħat imejl lil $to minn $from, bis-suġġett “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'L-imejl biex jitneħħa l-abbonament intbagħat lil $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Timblokka lil $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Il-posta l-ġdida minn din il-lista tmur fl-Ispam. Tista’ tibdel dan f’Settings › Regoli.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Il-posta l-ġdida minn $address tmur fl-Ispam. Tista’ tibdel dan f’Settings › Regoli.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender ġie mblukkat.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Ċaqlaq $count għall-Ispam');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Imblokka lil $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender issa jinsab f’Newsletters.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender issa jinsab f’Diskussjonijiet.';
  }

  @override
  String get appLiveGateTitle => 'Il-kontijiet tiegħek ma setgħux jinfetħu';

  @override
  String get appLiveGateUnavailableBuild => 'Il-kontijiet veri għadhom mhumiex disponibbli f’din il-verżjoni.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe ma setgħetx taqra ċ-ċavetta li tipproteġi l-posta tiegħek fuq dan il-mowbajl. Dan spiss ikun temporanju: erġa’ pprova, jew erġa’ ixgħel il-mowbajl.';

  @override
  String get appLiveGateKeyMissing =>
      'Iċ-ċavetta li tipproteġi l-posta tiegħek fuq dan il-mowbajl m’għadhiex hemm, ħaġa li tista’ tiġri wara li tirrestawra backup. Il-posta tiegħek għadha fuq is-server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Id-database tal-posta fuq dan il-mowbajl ma tistax tinqara: għandha ħsara, jew iċ-ċavetta tagħha nbidlet. Il-posta tiegħek għadha fuq is-server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Xi ħaġa marret ħażin waqt li kienu qed jinfetħu l-kontijiet tiegħek ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Dan iħassar il-kontijiet tiegħek u l-posta maħżuna fuq dan il-mowbajl, inklużi l-messaġġi li qed jistennew fl-Outbox. Il-posta fuq is-servers tiegħek mhix affettwata; wara, żid il-kontijiet tiegħek mill-ġdid.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Ħassar u erġa’ ibda';

  @override
  String get appLiveGateUseDemo => 'Uża l-posta demo';

  @override
  String get appLiveGateReset => 'Irrisettja l-posta fuq dan il-mowbajl…';

  @override
  String get attachmentsUntitled => 'Anness';

  @override
  String get attachmentsUntitledFile => 'Mingħajr titlu';

  @override
  String get attachmentsOpenIn => 'Iftaħ f’…';

  @override
  String get attachmentsSaveToFiles => 'Aħżen fil-fajls';

  @override
  String get attachmentsShareMenu => 'Aqsam…';

  @override
  String get attachmentsDownloadError => 'L-anness ma setax jitniżżel. Iċċekkja l-konnessjoni u erġa’ pprova.';

  @override
  String get attachmentsShareError => 'L-anness ma setax jinqasam.';

  @override
  String attachmentsNoApp(String type) {
    return 'L-ebda app fuq dan l-apparat ma tiftaħ dan il-fajl ($type). Minflok, ipprova “Aqsam”.';
  }

  @override
  String get attachmentsOpenInError => 'L-anness ma setax jinfetaħ f’app oħra.';

  @override
  String attachmentsSaved(String name) {
    return '“$name” ġie maħżun';
  }

  @override
  String get attachmentsSaveError => 'L-anness ma setax jinħażen.';

  @override
  String get attachmentsGone => 'Dan l-anness m’għadux disponibbli.';

  @override
  String get attachmentsDownloadFailed => 'L-anness ma setax jitniżżel.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paġna',
      many: '$count-il paġna',
      few: '$count paġni',
      two: '$count paġni',
      one: '$count paġna',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size fuq data mobbli';
  }

  @override
  String get attachmentsLargeDownload => 'Dan l-anness huwa kbir. Niżżlu issa, jew aktar tard fuq Wi-Fi.';

  @override
  String get attachmentsDownload => 'Niżżel';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Qed jitniżżlu $size…';
  }

  @override
  String get attachmentsDownloading => 'Qed jitniżżel…';

  @override
  String get attachmentsTooLarge => 'Kbir wisq biex jintwera hawn.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Qed jintwerew l-ewwel $shown minn $total. Ikkopja, aqsam jew aħżen biex tieħu kollox.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Dan il-PDF ma jistax jintwera hawn (jista’ jkun protett b’password).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page minn $count';
  }

  @override
  String get attachmentsModeTable => 'Tabella';

  @override
  String get attachmentsModeText => 'Test';

  @override
  String get attachmentsModeMessage => 'Messaġġ';

  @override
  String get attachmentsModeSource => 'Sors';

  @override
  String get attachmentsDontWrap => 'Tkissirx il-linji';

  @override
  String get attachmentsWrap => 'Ikser il-linji twal';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines linja',
      many: '$lines-il linja',
      few: '$lines linji',
      two: '$lines linji',
      one: '$lines linja',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Ikkopja kollox';

  @override
  String get attachmentsCopied => 'Ikkupjat';

  @override
  String get attachmentsImageUnavailable => 'Din l-istampa ma tistax tintwera hawn. Ipprova “Iftaħ f’…”.';

  @override
  String get attachmentsEmlNoSubject => '(Mingħajr suġġett)';

  @override
  String get attachmentsEmlFrom => 'Minn';

  @override
  String get attachmentsEmlTo => 'Lil';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Dan il-messaġġ m’għandux test.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Annessi: $names', one: 'Anness: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizzatur: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U $count avveniment ieħor',
      many: 'U $count-il avveniment ieħor',
      few: 'U $count avvenimenti oħra',
      two: 'U $count avvenimenti oħra',
      one: 'U avveniment ieħor',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Stampa';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Stampa $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Valuri separati b’tabs';

  @override
  String get attachmentsTypeCsv => 'Spreadsheet CSV';

  @override
  String get attachmentsTypeCalendar => 'Avveniment tal-kalendarju';

  @override
  String get attachmentsTypeEmail => 'Messaġġ tal-imejl';

  @override
  String get attachmentsTypeContact => 'Kard tal-kuntatt';

  @override
  String get attachmentsTypeLog => 'Fajl log';

  @override
  String get attachmentsTypeText => 'Test';

  @override
  String get attachmentsTypeZip => 'Arkivju ZIP';

  @override
  String get attachmentsTypeArchive => 'Arkivju kompressat';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Spreadsheet Excel';

  @override
  String get attachmentsTypePowerPoint => 'Preżentazzjoni PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Paġna web';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Awdjo';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Fajl $extension';
  }

  @override
  String get attachmentsTypeFile => 'Fajl';

  @override
  String get calendarUntitledEvent => 'Avveniment';

  @override
  String get calendarAllDay => 'Il-ġurnata kollha';

  @override
  String calendarYourTime(String time) {
    return '$time il-ħin tiegħek';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Ingħaqad: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Stedina aċċettata minn $name: $details',
      'tentative': 'Stedina aċċettata provviżorjament minn $name: $details',
      'declined': 'Stedina rrifjutata minn $name: $details',
      'delegated': 'Stedina ddelegata minn $name: $details',
      'other': 'L-ebda tweġiba minn $name għal: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'L-istedina ġiet aċċettata minn $name',
      'tentative': 'L-istedina ġiet aċċettata provviżorjament minn $name',
      'declined': 'L-istedina ġiet irrifjutata minn $name',
      'delegated': 'L-istedina ġiet iddelegata minn $name',
      'other': 'L-istedina għadha bla tweġiba minn $name',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mappa';

  @override
  String get calendarJoin => 'Ingħaqad';

  @override
  String get calendarOnlineMeeting => 'Laqgħa online';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Laqgħa $provider';
  }

  @override
  String get calendarOrganizerYou => 'Int';

  @override
  String get calendarOrganizerLabel => 'organizzatur';

  @override
  String get calendarStatusAccepted => 'Aċċettata';

  @override
  String get calendarStatusMaybe => 'Forsi';

  @override
  String get calendarStatusDeclined => 'Irrifjutata';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aċċettata minn $name',
      'tentative': 'Aċċettata provviżorjament minn $name',
      'declined': 'Irrifjutata minn $name',
      'delegated': 'Iddelegata minn $name',
      'other': 'L-ebda tweġiba minn $name',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aċċettata minn $name:',
      'tentative': 'Aċċettata provviżorjament minn $name:',
      'declined': 'Irrifjutata minn $name:',
      'delegated': 'Iddelegata minn $name:',
      'other': 'L-ebda tweġiba minn $name:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return 'Ħin ġdid propost minn $name';
  }

  @override
  String get calendarCounterUnknown => 'Parteċipant qed jipproponi ħin ġdid';

  @override
  String get calendarDeclineCounter => 'L-organizzatur żamm il-ħin';

  @override
  String calendarRefresh(String name) {
    return 'L-aħħar verżjoni mitluba minn $name';
  }

  @override
  String get calendarRefreshUnknown => 'Parteċipant qed jitlob l-aħħar verżjoni';

  @override
  String get calendarCancelled => 'Ikkanċellat';

  @override
  String get calendarCancelledByOrganizer => 'L-organizzatur ikkanċella dan l-avveniment.';

  @override
  String get calendarCancelledLater => 'Dan l-avveniment ġie kkanċellat aktar tard.';

  @override
  String get calendarOutdated => 'Mhux aġġornat';

  @override
  String get calendarOutdatedDetail => 'Din l-istedina ġiet aġġornata aktar tard; dik l-aktar ġdida hija li tgħodd.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Il-post tneħħa (qabel kien $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Il-post tneħħa (qabel ma kien hemm xejn)';

  @override
  String calendarLocationChanged(String location) {
    return 'Il-post inbidel għal $location';
  }

  @override
  String get calendarNewTitle => 'Titlu ġdid';

  @override
  String get calendarRepeatChanged => 'Ir-repetizzjoni nbidlet';

  @override
  String get calendarUpdated => 'Aġġornata';

  @override
  String get calendarUpdatedInvitation => 'Stedina aġġornata';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Il-ħin inbidel minn $before għal $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Żona tal-ħin “$zone” mhux magħrufa: il-ħinijiet kif miktuba';
  }

  @override
  String calendarNext(String when) {
    return 'Li jmiss: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mistieden',
      many: '$count-il mistieden',
      few: '$count mistednin',
      two: '$count mistednin',
      one: '$count mistieden',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count aċċettaw', one: '$count aċċetta');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count forsi');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count irrifjutaw',
      one: '$count irrifjuta',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (int)';
  }

  @override
  String get calendarAttendeeOptional => 'fakultattiv';

  @override
  String get calendarAttendeeRoom => 'kamra';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aċċettajt verżjoni preċedenti.',
      'tentative': 'Aċċettajt verżjoni preċedenti provviżorjament.',
      'declined': 'Irrifjutajt verżjoni preċedenti.',
      'delegated': 'Iddelegajt verżjoni preċedenti.',
      'other': 'Ma weġibtx għal verżjoni preċedenti.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Aċċetta';

  @override
  String get calendarMaybe => 'Forsi';

  @override
  String get calendarDecline => 'Irrifjuta';

  @override
  String get calendarCommentHint => 'Kumment għall-organizzatur (fakultattiv)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'It-tweġiba tiegħek tmur għand $organizer minn $address.';
  }

  @override
  String get calendarAddComment => 'Żid kumment';

  @override
  String get calendarAddToCalendar => 'Żid mal-kalendarju';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U $count avveniment ieħor fil-fajl',
      many: 'U $count-il avveniment ieħor fil-fajl',
      few: 'U $count avvenimenti oħra fil-fajl',
      two: 'U $count avvenimenti oħra fil-fajl',
      one: 'U avveniment ieħor fil-fajl',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'M’hemm l-ebda app tal-kalendarju biex iżżid l-avveniment fiha.';

  @override
  String get calendarCantOpenCalendar => 'Il-kalendarju ma setax jinfetaħ.';

  @override
  String get calendarCantOpenLink => 'Il-link ma setax jinfetaħ.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Tingħaqad mal-laqgħa $provider?';
  }

  @override
  String get calendarJoinTitle => 'Tingħaqad mal-laqgħa?';

  @override
  String calendarJoinOpens(String host) {
    return 'Jiftaħ $host fil-browser tiegħek.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Attent: dan l-indirizz jimita $site b’ittri li jixbhu lil oħrajn.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Attent: dan l-indirizz jimita sit ieħor b’ittri li jixbhu lil oħrajn.';

  @override
  String calendarJoinOpen(String host) {
    return 'Iftaħ $host';
  }

  @override
  String get calendarNoOrganizer => 'Din l-istedina m’għandhiex organizzatur biex twieġbu.';

  @override
  String get calendarNoAccount => 'M’hemm l-ebda kont li minnu tista’ twieġeb.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aċċettata',
      'tentative': 'Forsi',
      'other': 'Irrifjutata',
    });
    return '$_temp0 · qed tintbagħat it-tweġiba lil $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aċċettata',
      'tentative': 'Forsi',
      'other': 'Irrifjutata',
    });
    return '$_temp0 · it-tweġiba ntbagħtet';
  }

  @override
  String get calendarReplyAlreadySent => 'It-tweġiba kienet diġà ntbagħtet.';

  @override
  String get calendarReplyNotSent => 'It-tweġiba ma ntbagħtitx.';

  @override
  String get dataSmimeNeedsDevice =>
      'Iċ-ċertifikat S/MIME tiegħek jinsab fuq dan l-apparat: iftaħ Loupe biex tiffirma u tibgħat dan il-messaġġ.';

  @override
  String dataSigningFailed(String error) {
    return 'L-iffirmar falla: $error';
  }

  @override
  String get keyboardShortcuts => 'Shortcuts tat-tastiera';

  @override
  String get keyboardGroupGeneral => 'Ġenerali';

  @override
  String get keyboardGroupMessages => 'Messaġġi';

  @override
  String get keyboardGroupCompose => 'Kitba';

  @override
  String get keyboardCommandPalette => 'Paletta tal-kmandi';

  @override
  String get keyboardBackClose => 'Lura, agħlaq';

  @override
  String get keyboardNextMessage => 'Il-messaġġ li jmiss';

  @override
  String get keyboardPreviousMessage => 'Il-messaġġ ta’ qabel';

  @override
  String get keyboardOpenMessage => 'Iftaħ il-messaġġ';

  @override
  String get keyboardMoveToTrash => 'Ċaqlaq għall-Iskart';

  @override
  String get keyboardToggleRead => 'Immarka bħala moqri jew mhux moqri';

  @override
  String get keyboardToggleFlag => 'Immarka jew neħħi l-bandiera';

  @override
  String get keyboardCloseDraft => 'Agħlaq (aħżen jew ħassar l-abbozz)';

  @override
  String get keyboardOr => 'jew';

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
  String get mailingListsMuted => 'It-thread ġie msikket. Il-messaġġi l-ġodda fih jaslu diġà moqrija.';

  @override
  String get mailingListsUnmuted => 'It-thread m’għadux imsikket.';

  @override
  String get mailingListsMuteThread => 'Issikket it-thread';

  @override
  String get mailingListsUnmuteThread => 'Neħħi s-silenzju mit-thread';

  @override
  String get mailingListsPin => 'Waħħal mal-Mailboxes';

  @override
  String get mailingListsUnpin => 'Neħħi mill-Mailboxes';

  @override
  String get mailingListsDefaultView => 'Iftaħ fil-veduta default';

  @override
  String get mailingListsPlainText => 'Iftaħ bħala test sempliċi (Mono)';

  @override
  String get mailingListsShowMuted => 'Uri t-threads imsikkta';

  @override
  String get mailingListsHideMuted => 'Aħbi t-threads imsikkta';

  @override
  String get mailingListsTreatAsNewsletter => 'Ittrattaha bħala newsletter';

  @override
  String get mailingListsOptions => 'Għażliet tal-lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted mhux moqrija',
      one: '$count mhux moqri',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Messaġġ ġdid lil-lista';

  @override
  String get mailingListsRowUnread => 'Mhux moqri';

  @override
  String get mailingListsRowMuted => 'Imsikket';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tweġiba',
      many: '$count-il tweġiba',
      few: '$count tweġibiet',
      two: '$count tweġibiet',
      one: '$count tweġiba',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'L-ebda thread';

  @override
  String get mailingListsMutedHidden => 'It-threads imsikkta huma moħbija.';

  @override
  String get mailingListsTechnicalTitle => 'Listi tekniċi';

  @override
  String get mailingListsTechnicalEmpty => 'Il-mailing lists jidhru hawn hekk kif tasal il-posta tagħhom.';

  @override
  String get mailingListsTechnicalFooter =>
      'Il-messaġġi minn dawn il-listi jinfetħu bħala test sempliċi b’tipa monospace, bil-patches murija bħala diffs. Il-buttuna Aa xorta tibdel il-veduta ta’ kwalunkwe messaġġ.';

  @override
  String get paletteMoveToMailbox => 'Ċaqlaq għal mailbox…';

  @override
  String get paletteMarkAllRead => 'Immarka kollox bħala moqri';

  @override
  String get paletteExportFolder => 'Esporta l-folder…';

  @override
  String get paletteGetNewMail => 'Ġib posta ġdida';

  @override
  String get paletteSnoozed => 'Ipposponuti';

  @override
  String get paletteSubscriptions => 'Abbonamenti';

  @override
  String get paletteDiscussions => 'Diskussjonijiet';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailing list';

  @override
  String get paletteTag => 'Tikketta';

  @override
  String get paletteSwipeActions => 'Azzjonijiet tas-swipe';

  @override
  String get paletteNotifications => 'Notifiki';

  @override
  String get paletteRules => 'Regoli';

  @override
  String get paletteEncryption => 'Kriptaġġ minn tarf għal tarf';

  @override
  String get paletteAdvanced => 'Avvanzat';

  @override
  String get paletteAddAccount => 'Żid kont';

  @override
  String get paletteAccount => 'Kont';

  @override
  String get paletteFolders => 'Folders';

  @override
  String get paletteRecentSearch => 'Tfittxija reċenti';

  @override
  String paletteSearchMail(String query) {
    return 'Fittex il-posta għal “$query”';
  }

  @override
  String get palettePlaceholder => 'Fittex azzjonijiet, mailboxes, settings';

  @override
  String get paletteNothingFound => 'Ma nstab xejn';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox ġdida';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Turi kull ma jaqbel ma’ “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '“$name” ġiet maħżuna fil-Mailboxes';
  }

  @override
  String get searchMakeRule => 'Agħmilha regola';

  @override
  String get searchSaveSmartMailbox => 'Aħżen bħala Smart Mailbox';

  @override
  String get searchNegate => 'Innega';

  @override
  String get searchDontNegate => 'Tinnegax';

  @override
  String get searchAllMailboxes => 'Il-mailboxes kollha';

  @override
  String get searchRecent => 'Tfittxijiet reċenti';

  @override
  String get searchClear => 'Ħassar';

  @override
  String get searchSuggestions => 'Suġġerimenti';

  @override
  String get searchUnreadMessages => 'Messaġġi mhux moqrija';

  @override
  String get searchFlaggedMessages => 'Messaġġi b’bandiera';

  @override
  String get searchWithAttachments => 'Messaġġi b’annessi';

  @override
  String get searchUnrepliedMessages => 'Messaġġi mingħajr tweġiba';

  @override
  String get searchTags => 'Tikketti';

  @override
  String get searchPeople => 'Nies';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Minn: $name';
  }

  @override
  String get searchSearching => 'Tfittxija għaddejja…';

  @override
  String get searchNoResults => 'L-ebda riżultat';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted riżultat',
      many: '$formatted-il riżultat',
      few: '$formatted riżultati',
      two: '$formatted riżultati',
      one: '$formatted riżultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menu tat-tfittxija';

  @override
  String searchSearchingAccount(String account) {
    return 'Tfittxija f’$account fuq is-server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Tfittxija fil-kont fuq is-server…';

  @override
  String searchAccountFailed(String account) {
    return 'It-tfittxija f’$account fuq is-server ma setgħetx issir';
  }

  @override
  String get searchUnknownAccountFailed => 'It-tfittxija fil-kont fuq is-server ma setgħetx issir';

  @override
  String searchChip(String term) {
    return '$term. Agħfas darbtejn biex tibdel.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Mhux $term. Agħfas darbtejn biex tibdel.';
  }

  @override
  String get searchReadAndUnread => 'L-inbox ta’ Schrödinger: kull messaġġ hawn huwa moqri u mhux moqri sakemm tiftħu.';

  @override
  String searchContradiction(String term) {
    return 'L-ebda messaġġ ma jista’ jkun kemm “$term” kif ukoll le.';
  }

  @override
  String get searchSyncDeviceOnly => 'Fuq dan l-apparat biss';

  @override
  String searchSyncUnsupported(String account) {
    return 'Fuq dan l-apparat biss: $account ma jistax iżommha';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Mhux sinkronizzata: $account għandu format aktar ġdid';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Qed tistenna li tissinkronizza ma’ $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinkronizzata ma’ $account';
  }

  @override
  String get searchRename => 'Ibdel l-isem';

  @override
  String get searchEditSearch => 'Editja t-tfittxija';

  @override
  String get searchDeleteSmartMailbox => 'Ħassar is-Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Ibdel l-isem tas-Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Din is-Smart Mailbox tħassret.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Is-Smart Mailboxes jibqgħu fuq dan l-apparat.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Is-Smart Mailboxes jinżammu fuq is-server tal-imejl tiegħek, għalhekk l-apparati l-oħra tiegħek ikollhom ukoll, u hekk ukoll Thunderbird b’Expression Search Reloaded. Dawk li jfittxu fil-kontijiet kollha jinżammu fuq $account; dawk ta’ folder wieħed, fuq il-kont ta’ dak il-folder.';
  }

  @override
  String get searchSyncVia => 'Issinkronizza permezz ta’';

  @override
  String get searchSyncViaFooter => 'Agħżel l-istess kont fuq kull apparat.';

  @override
  String get searchGmailCantKeep => 'Gmail ma jistax iżomm Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Żomm is-Smart Mailboxes fuq dan l-apparat biss';

  @override
  String get searchOnTheServer => 'Fuq is-server';

  @override
  String get searchServerFooter =>
      'Il-metadata tas-server (IMAP METADATA) ma tidhirx f’ebda app tal-imejl. Is-servers mingħajrha jieħdu folder “Loupe Settings” b’messaġġ wieħed fih; Loupe taħbih mill-Mailboxes.';

  @override
  String get searchSyncNow => 'Issinkronizza issa';

  @override
  String get searchStateUnsupported => 'Mhux appoġġjat';

  @override
  String get searchStateNewerFormat => 'Format aktar ġdid';

  @override
  String get searchStateFailed => 'Ma setgħetx tissinkronizza';

  @override
  String get searchStateSyncing => 'Qed tissinkronizza…';

  @override
  String get searchStateWaiting => 'Qed tistenna';

  @override
  String get searchStateMetadata => 'Metadata tas-server';

  @override
  String get searchStateFolder => 'Folder Loupe Settings';

  @override
  String get searchStateNothing => 'Xejn maħżun';

  @override
  String get sharedBack => 'Lura';

  @override
  String get sharedYesterday => 'Ilbieraħ';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bytes', one: '$count byte');
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
  String get sharedSyncNoAccounts => 'L-ebda kont';

  @override
  String get sharedSyncChecking => 'Qed tiġi ċċekkjata l-posta…';

  @override
  String get sharedSyncFailed => 'Il-posta ma setgħetx tiġi ċċekkjata';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Aġġornat issa stess';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Aġġornat $minutes minuta ilu',
      many: 'Aġġornat $minutes-il minuta ilu',
      few: 'Aġġornat $minutes minuti ilu',
      two: 'Aġġornat minutejn ilu',
      one: 'Aġġornat minuta ilu',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Aġġornat: $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Aġġornat: $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'L-Inboxes kollha';

  @override
  String get sharedMailboxUnread => 'Mhux moqrija';

  @override
  String get sharedMailboxFlagged => 'B’bandiera';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'L-abbozzi kollha';

  @override
  String get sharedMailboxAllSent => 'Il-mibgħuta kollha';

  @override
  String get sharedMailboxUntitled => 'Mailbox';

  @override
  String get sharedTagImportant => 'Importanti';

  @override
  String get sharedTagWork => 'Xogħol';

  @override
  String get sharedTagPersonal => 'Personali';

  @override
  String get sharedTagToDo => 'Biex isir';

  @override
  String get sharedTagLater => 'Aktar tard';

  @override
  String get sharedTags => 'Tikketti';

  @override
  String get sharedMoveTo => 'Ċaqlaq għal…';

  @override
  String get sharedNoRecipients => 'L-ebda riċevitur';

  @override
  String get sharedUnknownSender => 'Mittent mhux magħruf';

  @override
  String get sharedOnServer => 'Fuq is-server';

  @override
  String get sharedAttachment => 'Anness';

  @override
  String get sharedSnoozedBadge => 'Ipposponut';

  @override
  String get sharedRowUnread => 'Mhux moqri';

  @override
  String get sharedRowBackFromSnooze => 'Lura mill-posponiment';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'B’bandiera';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ġew arkivjati $count messaġġ',
      many: 'Ġew arkivjati $count-il messaġġ',
      few: 'Ġew arkivjati $count messaġġi',
      two: 'Ġew arkivjati $count messaġġi',
      one: 'Ġie arkivjat $count messaġġ',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tħassru $count messaġġ',
      many: 'Tħassru $count-il messaġġ',
      few: 'Tħassru $count messaġġi',
      two: 'Tħassru $count messaġġi',
      one: 'Tħassar $count messaġġ',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew imċaqilqa għall-Inbox',
      many: '$count-il messaġġ ġew imċaqilqa għall-Inbox',
      few: '$count messaġġi ġew imċaqilqa għall-Inbox',
      two: '$count messaġġi ġew imċaqilqa għall-Inbox',
      one: '$count messaġġ ġie mċaqlaq għall-Inbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew imċaqilqa għall-Iskart',
      many: '$count-il messaġġ ġew imċaqilqa għall-Iskart',
      few: '$count messaġġi ġew imċaqilqa għall-Iskart',
      two: '$count messaġġi ġew imċaqilqa għall-Iskart',
      one: '$count messaġġ ġie mċaqlaq għall-Iskart',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew imċaqilqa għall-Ispam',
      many: '$count-il messaġġ ġew imċaqilqa għall-Ispam',
      few: '$count messaġġi ġew imċaqilqa għall-Ispam',
      two: '$count messaġġi ġew imċaqilqa għall-Ispam',
      one: '$count messaġġ ġie mċaqlaq għall-Ispam',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew imċaqilqa għal $mailbox',
      many: '$count-il messaġġ ġew imċaqilqa għal $mailbox',
      few: '$count messaġġi ġew imċaqilqa għal $mailbox',
      two: '$count messaġġi ġew imċaqilqa għal $mailbox',
      one: '$count messaġġ ġie mċaqlaq għal $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew imċaqilqa għal mailbox',
      many: '$count-il messaġġ ġew imċaqilqa għal mailbox',
      few: '$count messaġġi ġew imċaqilqa għal mailbox',
      two: '$count messaġġi ġew imċaqilqa għal mailbox',
      one: '$count messaġġ ġie mċaqlaq għal mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġew ipposponuti sa $time',
      many: '$count-il messaġġ ġew ipposponuti sa $time',
      few: '$count messaġġi ġew ipposponuti sa $time',
      two: '$count messaġġi ġew ipposponuti sa $time',
      one: '$count messaġġ ġie pposponut sa $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Ipposponut sa $time fuq dan l-apparat biss: is-server ma jistax jaħżen il-ħinijiet tal-posponiment.';
  }

  @override
  String get sharedMoveOneAccount => 'Agħżel messaġġi minn kont wieħed biex iċċaqlaqhom.';

  @override
  String get sharedSnoozeTitle => 'Ipposponi';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Ibdel il-ħin tal-posponiment';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tħassar $count messaġġ għal kollox?',
      many: 'Tħassar $count-il messaġġ għal kollox?',
      few: 'Tħassar $count messaġġi għal kollox?',
      two: 'Tħassar $count messaġġi għal kollox?',
      one: 'Tħassar dan il-messaġġ għal kollox?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Dan ma jistax jitreġġa’ lura.';

  @override
  String get sharedDeletePermanently => 'Ħassar għal kollox';

  @override
  String get sharedSwipeRead => 'Moqri';

  @override
  String get sharedSwipeUnread => 'Mhux moqri';

  @override
  String get sharedSwipeInbox => 'Inbox';

  @override
  String get sharedSwipeDelete => 'Ħassar';

  @override
  String get sharedTrash => 'Skart';

  @override
  String get sharedSwipeSnooze => 'Ipposponi';

  @override
  String get sharedWakeNow => 'Ġibu lura issa';

  @override
  String get sharedChangeSnoozeTime => 'Ibdel il-ħin tal-posponiment…';

  @override
  String get sharedSnooze => 'Ipposponi…';

  @override
  String get sharedTag => 'Ittikkettja…';

  @override
  String get sharedMoveMessage => 'Ċaqlaq il-messaġġ…';

  @override
  String get sharedNotJunk => 'Mhux spam';

  @override
  String get accountSetupTitle => 'Żid kont';

  @override
  String get accountSetupTitleDone => 'Il-kont ġie miżjud';

  @override
  String get accountSetupAddressTitle => 'Żid kont tal-imejl';

  @override
  String get accountSetupAddressText => 'Loupe ssib is-settings għall-biċċa l-kbira tal-fornituri.';

  @override
  String get accountSetupNameHint => 'Ismek';

  @override
  String get accountSetupEmail => 'Imejl';

  @override
  String get accountSetupEmailHint => 'isem@example.com';

  @override
  String get accountSetupContinue => 'Kompli';

  @override
  String get accountSetupLookingUp => 'Qed jinstabu s-settings…';

  @override
  String get accountSetupImport => 'Importa minn Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Daħħal indirizz tal-imejl validu.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Ma nstabux settings għal $domain. Daħħalhom hawn taħt.';
  }

  @override
  String get accountSetupCheckServers => 'Iċċekkja l-ismijiet tas-servers u l-portijiet.';

  @override
  String get accountSetupEnterPassword => 'Daħħal il-password tiegħek.';

  @override
  String get accountSetupConnecting => 'Qed jikkonnettja…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Qed jistenna lil $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Il-paġna ma setgħetx tinfetaħ.';

  @override
  String get accountSetupCouldNotSaveName => 'L-isem ma setax jinħażen.';

  @override
  String get accountSetupTrustCertificate => 'Afda f’dan iċ-ċertifikat';

  @override
  String get accountSetupPasswordRequired => 'Meħtieġ';

  @override
  String get accountSetupShowPassword => 'Uri l-password';

  @override
  String get accountSetupHidePassword => 'Aħbi l-password';

  @override
  String get accountSetupAppPassword => 'Password tal-app';

  @override
  String get accountSetupApiToken => 'Token tal-API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Dieħel · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Ħiereġ · SMTP';

  @override
  String get accountSetupSignIn => 'Idħol';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Idħol b’$provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Uża password tal-app';

  @override
  String get accountSetupUseAppPasswordInstead => 'Minflok, uża password tal-app';

  @override
  String get accountSetupUseDifferentAddress => 'Uża indirizz ieħor';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kif toħloq password tal-app';

  @override
  String get accountSetupHowToCreateOne => 'Kif toħloq waħda';

  @override
  String get accountSetupGoogleNote =>
      'Tidħol fuq il-paġna ta’ Google, u Loupe qatt ma tara l-password tiegħek. Ħalli lil Loupe taqra, tibgħat u torganizza l-posta tiegħek.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Idħol b’Google” għadu mhux disponibbli f’din il-verżjoni. Minflok, tista’ tikkonnettja b’password tal-app (għandek bżonn 2-Step Verification fuq il-kont Google tiegħek).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Oħloq password tal-app fil-kont Google tiegħek u waħħalha hawn taħt.';

  @override
  String get accountSetupMicrosoftNote =>
      'Tidħol fuq il-paġna ta’ Microsoft, u Loupe qatt ma tara l-password tiegħek. Dan jaħdem għal Outlook.com u Hotmail, u għal kontijiet tax-xogħol jew tal-iskola fuq Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Id-dħul b’Microsoft jasal f’verżjoni aktar tard. Il-kontijiet ta’ Outlook, Hotmail u Microsoft 365 għandhom bżonnu: m’għadhomx jaċċettaw passwords minn apps tal-imejl.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail għandu bżonn password speċifika għall-app, mhux il-password tal-Apple Account tiegħek.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail għandu bżonn password tal-app, mhux il-password tal-kont tiegħek.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe tikkonnettja ma’ Fastmail permezz ta’ JMAP b’token tal-API: Settings › Privacy & Security › Manage API tokens, għal JMAP, b’aċċess għall-imejl u għall-bgħit.';

  @override
  String get accountSetupFastmailNote => 'Fastmail għandu bżonn password tal-app għall-apps tal-imejl.';

  @override
  String get accountSetupServerSettings => 'Settings tas-server';

  @override
  String get accountSetupSettingsNotFound => 'Ma nstabux awtomatikament';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Instabu permezz ta’ $source';
  }

  @override
  String get accountSetupEditSettings => 'Editja s-settings';

  @override
  String get accountSetupSyncing => 'Il-posta tiegħek qed tissinkronizza.';

  @override
  String get accountSetupDescription => 'Deskrizzjoni';

  @override
  String get accountSetupDescriptionHint => 'Xogħol, Personali…';

  @override
  String get accountSetupColour => 'Kulur';

  @override
  String accountSetupColourNumber(int number) {
    return 'Kulur $number';
  }

  @override
  String get accountSetupSaving => 'Qed jinħażen…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe ma setgħetx tiftaħ id-database tal-posta tagħha fuq dan il-mowbajl. Agħlaq Loupe, erġa’ iftaħha u erġa’ pprova.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Xi ħaġa marret ħażin ($error). Erġa’ pprova.';
  }

  @override
  String get accountSetupSecurityNone => 'Xejn';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sigurtà';

  @override
  String get accountSetupUsername => 'Isem tal-utent';

  @override
  String get accountSetupUsernameHint => 'L-indirizz tal-imejl tiegħek';

  @override
  String get accountSetupNoEncryptionTitle => 'Tikkonnettja mingħajr kriptaġġ?';

  @override
  String get accountSetupNoEncryptionText =>
      'Il-password tiegħek u kull messaġġ jivvjaġġaw bħala test ċar. Kull min ikun fuq in-network, bħal Wi-Fi pubbliku, jista’ jaqrahom. Uża dan biss għal server fuq in-network tiegħek stess.';

  @override
  String get accountSetupUseWithoutEncryption => 'Uża mingħajr kriptaġġ';

  @override
  String get accountSetupApiTokenRejected =>
      'It-token tal-API ġie rrifjutat. Oħloq token tal-API ta’ Fastmail għal JMAP b’aċċess għall-imejl, u waħħlu.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Il-password ġiet irrifjutata. Uża password tal-app, mhux il-password tal-kont tiegħek.';

  @override
  String get accountSetupPasswordRejected => 'Il-password ġiet irrifjutata. Iċċekkjaha u erġa’ pprova.';

  @override
  String get accountSetupServerUnreachable =>
      'Is-server ma jistax jintlaħaq. Iċċekkja s-settings tas-server u l-konnessjoni tiegħek.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Iċ-ċertifikat tas-server mhuwiex fdat. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Id-dħul ġie kkanċellat. Agħfas “Idħol b’$provider” biex terġa’ tipprova.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe għandha bżonn permess biex taqra u tibgħat il-Gmail tiegħek. Erġa’ idħol u ħalli l-aċċess, bil-kaxxa ta’ Gmail immarkata.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe għandha bżonn permess biex taqra u tibgħat il-posta tiegħek. Erġa’ idħol u aċċetta l-permessi.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'L-organizzazzjoni tiegħek trid tapprova lil Loupe qabel ma tkun tista’ tużaha ma’ dan il-kont. Itlob lill-amministratur tal-IT tiegħek jagħti admin consent għal Loupe f’Microsoft Entra ID, imbagħad erġa’ pprova.';

  @override
  String get accountSetupOAuthBlocked =>
      'Ir-regoli tad-dħul tal-organizzazzjoni tiegħek ma jippermettux lil Loupe fuq dan l-apparat. Staqsi lill-amministratur tal-IT tiegħek.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider ma setax jintlaħaq. Iċċekkja l-konnessjoni tal-internet u erġa’ pprova.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Id-dħul b’$provider mhuwiex issettjat sew f’din il-verżjoni ta’ Loupe. Jekk jogħġbok irrapporta dan.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Id-dħul b’$provider ma ħadimx. Erġa’ pprova.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider daħħlek, iżda Gmail irrifjuta l-aċċess għal dan l-indirizz. Agħżel l-istess kont meta tidħol. Il-kontijiet tax-xogħol jew tal-iskola jista’ jkollhom l-IMAP mitfi mill-amministratur tagħhom.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider daħħlek, iżda s-server tal-imejl irrifjuta l-aċċess għal dan l-indirizz. Agħżel l-istess kont meta tidħol. Il-kontijiet tax-xogħol jew tal-iskola jista’ jkollhom l-IMAP mitfi mill-amministratur tagħhom.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Is-server tal-imejl ma jistax jintlaħaq. Iċċekkja l-konnessjoni tiegħek u erġa’ pprova.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Id-dħul b’$provider mhuwiex disponibbli f’din il-verżjoni.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Dħalt mill-ġdid. $account qed jissinkronizza.';
  }

  @override
  String get accountSetupSignInAgain => 'Erġa’ idħol';

  @override
  String get accountSetupSigningIn => 'Qed tidħol…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider m’għadux jaċċetta d-dħul ta’ Loupe għal $email, għalhekk $account mhux qed jissinkronizza. Erġa’ idħol biex tieħu l-posta tiegħu.';
  }

  @override
  String get accountImportTitle => 'Importa minn Thunderbird';

  @override
  String get accountImportPointCamera => 'Ipponta l-kamera lejn il-kodiċi QR li juri Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skennjati $scanned minn $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Skennjati $scanned minn $total kodiċi');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kont s’issa',
      many: '$count-il kont s’issa',
      few: '$count kontijiet s’issa',
      two: '$count kontijiet s’issa',
      one: 'Kont wieħed s’issa',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Fuq il-kompjuter tiegħek, iftaħ Thunderbird u agħżel Tools › Export for Mobile. Agħżel il-kontijiet tiegħek, imbagħad skennja kull kodiċi li juri. Il-kodiċijiet jistgħu jiġu skennjati f’kull ordni.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kompli b’$count kont',
      many: 'Kompli b’$count-il kont',
      few: 'Kompli b’$count kontijiet',
      two: 'Kompli b’$count kontijiet',
      one: 'Kompli b’kont wieħed',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Minflok, waħħal it-test';

  @override
  String get accountImportStartOver => 'Erġa’ ibda';

  @override
  String get accountImportDuplicateCode => 'Dak il-kodiċi diġà ġie miżjud.';

  @override
  String get accountImportRestarted =>
      'Dan il-kodiċi huwa minn esportazzjoni ġdida, għalhekk il-kodiċijiet skennjati qabel tpoġġew fil-ġenb.';

  @override
  String get accountImportNotThunderbird => 'Dan mhuwiex kodiċi ta’ kont ta’ Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Dan il-kodiċi ġej minn Thunderbird aktar ġdid. Aġġorna Loupe biex timportah.';

  @override
  String get accountImportDamaged => 'Dan il-kodiċi ta’ Thunderbird ma setax jinqara.';

  @override
  String get accountImportTooLarge => 'Dan il-kodiċi huwa kbir wisq biex ikun esportazzjoni ta’ Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Is-Settings ma setgħux jinfetħu.';

  @override
  String get accountImportCameraOffTitle => 'L-aċċess għall-kamera huwa mitfi';

  @override
  String get accountImportCameraOffText =>
      'Ħalli lil Loupe tuża l-kamera fis-Settings biex tiskennja l-kodiċi, jew minflok waħħal it-test tal-kodiċi.';

  @override
  String get accountImportNoCameraTitle => 'L-ebda kamera';

  @override
  String get accountImportNoCameraText => 'Loupe ma tistax tuża kamera hawn. Minflok, waħħal it-test tal-kodiċi.';

  @override
  String get accountImportCameraFailedTitle => 'Il-kamera ma bdietx';

  @override
  String get accountImportCameraFailedText => 'Erġa’ pprova, jew minflok waħħal it-test tal-kodiċi.';

  @override
  String get accountImportOpenSettings => 'Iftaħ is-Settings';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Instabu $count kont',
      many: 'Instabu $count-il kont',
      few: 'Instabu $count kontijiet',
      two: 'Instabu $count kontijiet',
      one: 'Instab kont wieħed',
      zero: 'Ma nstab l-ebda kont',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'L-ebda wieħed mill-kontijiet f’dawn il-kodiċijiet ma seta’ jinqara.';

  @override
  String get accountImportChoose => 'Agħżel il-kontijiet li trid iżżid ma’ Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il-kodiċijiet $codes minn $total ma ġewx skennjati, għalhekk il-kontijiet tagħhom mhumiex elenkati.',
      one: 'Il-kodiċi $codes minn $total ma ġiex skennjat, għalhekk il-kontijiet tiegħu mhumiex elenkati.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes u $last';
  }

  @override
  String get accountImportScanMore => 'Skennja aktar kodiċijiet';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count kont fil-kodiċijiet ma setgħux jinqraw. Jista’ jkun li jużaw settings minn Thunderbird aktar ġdid.',
      many:
          '$count-il kont fil-kodiċijiet ma setgħux jinqraw. Jista’ jkun li jużaw settings minn Thunderbird aktar ġdid.',
      few:
          '$count kontijiet fil-kodiċijiet ma setgħux jinqraw. Jista’ jkun li jużaw settings minn Thunderbird aktar ġdid.',
      two:
          '$count kontijiet fil-kodiċijiet ma setgħux jinqraw. Jista’ jkun li jużaw settings minn Thunderbird aktar ġdid.',
      one: 'Kont wieħed fil-kodiċijiet ma setax jinqara. Jista’ jkun li juża settings minn Thunderbird aktar ġdid.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Erġa’ skennja';

  @override
  String get accountImportAlreadyAdded => 'Kont b’dan l-indirizz diġà jinsab f’Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Tidħol b’$provider meta jiżdied, bħal f’Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Żid il-kont b’password tal-app (għandek bżonn 2-Step Verification).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird jidħol f’Gmail b’Google. “Idħol b’Google” jasal f’verżjoni aktar tard; sa dakinhar, żid il-kont b’password tal-app (għandek bżonn 2-Step Verification).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird jidħol f’dan il-kont fil-browser. Loupe għadha ma tistax tagħmel dan: uża password tal-app jekk il-fornitur tiegħek joffri waħda.';

  @override
  String get accountImportUnencrypted => 'Jikkonnettja mingħajr kriptaġġ. Uża dan biss fuq in-network tiegħek stess.';

  @override
  String get accountImportEnterAgain => 'Erġa’ daħħalha';

  @override
  String get accountImportAdded => 'Miżjud';

  @override
  String accountImportAdding(int index, int total) {
    return 'Qed jiżdied $index minn $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Żid $count kont',
      many: 'Żid $count-il kont',
      few: 'Żid $count kontijiet',
      two: 'Żid $count kontijiet',
      one: 'Żid kont wieħed',
      zero: 'Żid kontijiet',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Waħħal it-test tal-esportazzjoni';

  @override
  String get accountImportPasteText =>
      'Waħħal it-test ta’ kodiċi ta’ esportazzjoni ta’ Thunderbird, kodiċi wieħed f’kull linja.';

  @override
  String get accountImportPop3 => 'Il-kontijiet POP3 mhumiex appoġġjati. Loupe iżżomm il-posta fuq is-server b’IMAP.';

  @override
  String get accountImportKerberos => 'Dan il-kont jidħol b’Kerberos, li Loupe ma tappoġġjax.';

  @override
  String get accountImportNtlm => 'Dan il-kont jidħol b’NTLM, li Loupe ma tappoġġjax.';

  @override
  String get accountImportClientCertificate =>
      'Dan il-kont jidħol b’ċertifikat tal-klijent, li Loupe għadha ma tappoġġjax.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Id-dħul b’Microsoft jasal f’verżjoni aktar tard. Il-kontijiet ta’ Outlook u Microsoft 365 m’għadhomx jaċċettaw passwords minn apps tal-imejl.';

  @override
  String get accountImportEnterPassword => 'Daħħal il-password.';

  @override
  String get accountImportEnterAppPassword => 'Daħħal il-password tal-app.';

  @override
  String get accountImportEnterApiToken => 'Daħħal it-token tal-API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe ma setgħetx tiftaħ il-ħażna tal-kontijiet tagħha. Erġa’ pprova aktar tard.';

  @override
  String get accountImportFailed => 'Il-kont ma setax jiżdied. Erġa’ pprova, jew żidu manwalment.';

  @override
  String get composeNewMessageTitle => 'Messaġġ ġdid';

  @override
  String get composeAttach => 'Ehmeż';

  @override
  String get composeSendLater => 'Ibgħat aktar tard';

  @override
  String composeSendAt(String time) {
    return 'Ibgħat $time';
  }

  @override
  String get composeSendHint => 'Agħfas fit-tul biex tibgħat aktar tard';

  @override
  String get composeNoAccount => 'Żid kont biex tibgħat posta.';

  @override
  String get composeTo => 'Lil:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Minn: $email';
  }

  @override
  String get composeFromLabel => 'Minn:';

  @override
  String get composeSubjectLabel => 'Suġġett:';

  @override
  String composeReplyTo(String address) {
    return 'Wieġeb lil: $address';
  }

  @override
  String get composeFrom => 'Minn';

  @override
  String composeReplyFrom(String email) {
    return 'Wieġeb minn $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Ibgħat minn $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Twieġeb minn $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Tibgħat minn $email?';
  }

  @override
  String get composeDismiss => 'Warrab';

  @override
  String composeAliasNotSaved(String account) {
    return 'Mhux maħżun bħala identità · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Aħżen bħala identità';

  @override
  String composeAliasSaved(String email) {
    return '$email huwa maħżun bħala identità.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Indirizz invalidu $address';
  }

  @override
  String get composeOriginalNotFound => 'Il-messaġġ oriġinali ma nstabx.';

  @override
  String get composeDraftNotFound => 'L-abbozz ma nstabx.';

  @override
  String get composeAttachmentsLost => 'L-annessi ma setgħux jiġu rkuprati. Erġa’ żidhom.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Xi annessi ma setgħux jiżdiedu: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'L-annessi b’kollox huma $size; xi servers jirrifjutaw messaġġi daqshekk kbar.';
  }

  @override
  String get composeAttachFailed => 'Il-fajl ma setax jiġi mehmuż.';

  @override
  String get composeInvalidAddressTitle => 'Indirizz invalidu';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” mhuwiex indirizz tal-imejl validu.';
  }

  @override
  String get composeNoSubjectTitle => 'Mingħajr suġġett';

  @override
  String get composeNoSubjectText => 'Dan il-messaġġ m’għandux suġġett. Tibagħtu xorta waħda?';

  @override
  String get composeSentBeforeChanges => 'Intbagħat qabel il-bidliet tiegħek, li huma maħżuna fl-Abbozzi.';

  @override
  String composeScheduled(String time) {
    return 'Skedat għal $time';
  }

  @override
  String get composeSending => 'Qed jintbagħat…';

  @override
  String get composeSent => 'Mibgħut';

  @override
  String get composeSendFailed => 'Ma setax jintbagħat. Erġa’ pprova.';

  @override
  String get composeAlreadySent => 'Diġà ntbagħat.';

  @override
  String get composeDiscardChanges => 'Armi l-bidliet';

  @override
  String get composeSaveChanges => 'Aħżen il-bidliet';

  @override
  String get composeDeleteDraft => 'Ħassar l-abbozz';

  @override
  String get composeSaveDraft => 'Aħżen l-abbozz';

  @override
  String get composeDraftSaved => 'L-abbozz ġie maħżun';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Messaġġ minn $name, $date, $time:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date, $time, xi ħadd kiteb:';
  }

  @override
  String get composeForwardHeader => '---------- Messaġġ mgħoddi ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Minn: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date, $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Suġġett: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Lil: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Aktar tard illum';

  @override
  String get composeTomorrowMorning => 'Għada filgħodu';

  @override
  String get composeMondayMorning => 'It-Tnejn filgħodu';

  @override
  String get composePickDateTime => 'Agħżel data u ħin…';

  @override
  String get composeSendWithoutDelay => 'Ibgħat mingħajr dewmien';

  @override
  String composeSendTimeToday(String time) {
    return 'Illum, $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Għada, $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day, $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Illum $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Għada $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Tkompli teditja l-abbozz tiegħek?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Messaġġ ma ntbagħatx meta Loupe ngħalqet.',
      'one': 'Messaġġ lil $name ma ntbagħatx meta Loupe ngħalqet.',
      'other': 'Messaġġ lil $name u oħrajn ma ntbagħatx meta Loupe ngħalqet.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '“$subject” ma ntbagħatx meta Loupe ngħalqet.',
      'one': '“$subject” lil $name ma ntbagħatx meta Loupe ngħalqet.',
      'other': '“$subject” lil $name u oħrajn ma ntbagħatx meta Loupe ngħalqet.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Kompli editja';

  @override
  String get composeRecoverySave => 'Aħżen fl-Abbozzi';

  @override
  String get composeRecoveryDiscard => 'Armi';

  @override
  String get composeRecoverySaved => 'Maħżun fl-Abbozzi';

  @override
  String get outboxSectionFailed => 'Mhux mibgħuta';

  @override
  String get outboxSectionSending => 'Qed jintbagħtu';

  @override
  String get outboxSectionScheduled => 'Skedati';

  @override
  String get outboxStatusQueued => 'Se jintbagħat dalwaqt';

  @override
  String get outboxStatusSending => 'Qed jintbagħat…';

  @override
  String get outboxStatusFailed => 'Mhux mibgħut';

  @override
  String get outboxNoRecipients => 'L-ebda riċevitur';

  @override
  String get outboxNoSubject => '(Mingħajr suġġett)';

  @override
  String get outboxSendingFailed => 'Il-bgħit falla.';

  @override
  String get outboxEmptyTitle => 'Xejn x’tibgħat';

  @override
  String get outboxEmptyText => 'Il-messaġġi li tibgħat aktar tard jistennew hawn sakemm jasal il-ħin.';

  @override
  String get outboxSendNow => 'Ibgħat issa';

  @override
  String get outboxReschedule => 'Skeda mill-ġdid';

  @override
  String get outboxRescheduleMenu => 'Skeda mill-ġdid…';

  @override
  String get outboxRescheduleTitle => 'Skeda mill-ġdid';

  @override
  String outboxRescheduled(String time) {
    return 'Skedat mill-ġdid għal $time';
  }

  @override
  String get outboxCancel => 'Ikkanċella';

  @override
  String get outboxCancelSending => 'Ikkanċella l-bgħit…';

  @override
  String get outboxCancelTitle => 'Tikkanċella l-bgħit?';

  @override
  String get outboxMoveToDrafts => 'Ċaqlaq għall-Abbozzi';

  @override
  String get outboxDiscard => 'Armi l-messaġġ';

  @override
  String get outboxMovedToDrafts => 'Ġie mċaqlaq għall-Abbozzi';

  @override
  String get outboxDiscarded => 'Il-messaġġ ġie mormi';

  @override
  String get outboxAlreadySent => 'Diġà ntbagħat.';

  @override
  String get outboxBeingSent => 'Dan il-messaġġ qed jintbagħat.';

  @override
  String get outboxActionFailed => 'Dan ma ħadimx. Il-messaġġ għadu fl-Outbox.';

  @override
  String get notificationsBadgeInboxes => 'Mhux moqrija fl-Inboxes';

  @override
  String get notificationsBadgeVip => 'Mhux moqrija fil-VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Posta ġdida mill-VIPs tiegħek, f’kull kont';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Posta ġdida f’$email';
  }

  @override
  String get notificationsUnknownSender => 'Mittent mhux magħruf';

  @override
  String get notificationsNoSubject => '(Mingħajr suġġett)';

  @override
  String get notificationsEncryptedMessage => 'Messaġġ kriptat';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Messaġġ ġdid minn $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaġġ ġdid',
      many: '$count-il messaġġ ġdid',
      few: '$count messaġġi ġodda',
      two: '$count messaġġi ġodda',
      one: '$count messaġġ ġdid',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Messaġġi ġodda f’$account';
  }

  @override
  String get platformInstantChannel => 'Twassil immedjat';

  @override
  String get platformInstantChannelDescription =>
      'Tidher waqt li Loupe tkun qed tistenna posta ġdida fl-inboxes tiegħek';

  @override
  String get platformInstantTitle => 'Qed tistenna posta ġdida';

  @override
  String get platformInstantText => 'It-Twassil immedjat huwa mixgħul';

  @override
  String get platformErrorBox => 'Xi ħaġa marret ħażin waqt li kien qed jintwera dan. Mur lura u erġa’ pprova.';

  @override
  String get welcomeTagline => 'Imejl sempliċi fil-wiċċ\nu qawwi minn taħt.';

  @override
  String get welcomeAccountsTitle => 'Kull kont, inbox waħda kalma';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail u kull server IMAP jew JMAP.';

  @override
  String get welcomeSearchTitle => 'Tfittxija li ssib';

  @override
  String get welcomeSearchText => 'Riżultati minnufih fuq il-mowbajl tiegħek, imbagħad dawk tas-server.';

  @override
  String get welcomePrivacyTitle => 'Privata mid-disinn';

  @override
  String get welcomePrivacyText => 'L-ebda traċċar. L-istampi remoti jibqgħu mblukkati sakemm tgħid int.';

  @override
  String get welcomeAddAccount => 'Żid kont';

  @override
  String get welcomeImport => 'Importa minn Thunderbird';

  @override
  String get welcomeTryDemo => 'Ipprova bil-posta demo';
}
