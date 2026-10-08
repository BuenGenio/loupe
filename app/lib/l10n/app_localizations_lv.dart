// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get commonAdd => 'Pievienot';

  @override
  String get commonCancel => 'Atcelt';

  @override
  String get commonClose => 'Aizvērt';

  @override
  String get commonDelete => 'Dzēst';

  @override
  String get commonDone => 'Gatavs';

  @override
  String get commonEdit => 'Rediģēt';

  @override
  String get commonMore => 'Vairāk';

  @override
  String get commonMove => 'Pārvietot';

  @override
  String get commonName => 'Vārds';

  @override
  String get commonNone => 'Nav';

  @override
  String get commonOff => 'Izslēgts';

  @override
  String get commonOk => 'Labi';

  @override
  String get commonOn => 'Ieslēgts';

  @override
  String get commonOptional => 'Neobligāti';

  @override
  String get commonPassword => 'Parole';

  @override
  String get commonRemove => 'Noņemt';

  @override
  String get commonRetry => 'Mēģināt vēlreiz';

  @override
  String get commonSave => 'Saglabāt';

  @override
  String get commonSearch => 'Meklēt';

  @override
  String get commonServer => 'Serveris';

  @override
  String get commonSettings => 'Iestatījumi';

  @override
  String get commonShare => 'Kopīgot';

  @override
  String get commonTryAgain => 'Mēģināt vēlreiz';

  @override
  String get commonUndo => 'Atsaukt';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi',
      one: '$count ziņojums',
      zero: '$count ziņojumu',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arhivēt';

  @override
  String get mailDelete => 'Dzēst';

  @override
  String get mailFlag => 'Atzīmēt ar karodziņu';

  @override
  String get mailForward => 'Pārsūtīt';

  @override
  String get mailMarkAsRead => 'Atzīmēt kā lasītu';

  @override
  String get mailMarkAsUnread => 'Atzīmēt kā nelasītu';

  @override
  String get mailMoveToJunk => 'Pārvietot uz mēstulēm';

  @override
  String get mailNewMessage => 'Jauns ziņojums';

  @override
  String get mailNoSubject => 'Bez temata';

  @override
  String get mailReply => 'Atbildēt';

  @override
  String get mailReplyAll => 'Atbildēt visiem';

  @override
  String get mailSend => 'Sūtīt';

  @override
  String get mailUnflag => 'Noņemt karodziņu';

  @override
  String get mailboxArchive => 'Arhīvs';

  @override
  String get mailboxDrafts => 'Melnraksti';

  @override
  String get mailboxInbox => 'Iesūtne';

  @override
  String get mailboxJunk => 'Mēstules';

  @override
  String get mailboxOutbox => 'Izsūtne';

  @override
  String get mailboxSent => 'Nosūtītie';

  @override
  String get mailboxTrash => 'Miskaste';

  @override
  String get conversationSomethingWentWrong => 'Radās kļūda. Mēģiniet vēlreiz.';

  @override
  String get conversationReplyToList => 'Atbildēt sarakstam';

  @override
  String get conversationReplyList => 'Atbildēt sarakstam';

  @override
  String get conversationThreadMuted => 'Pavediens apklusināts. Jauni ziņojumi tajā tiks saņemti kā lasīti.';

  @override
  String get conversationThreadUnmuted => 'Pavediena apklusināšana atcelta.';

  @override
  String get conversationLinkFailed => 'Neizdevās atvērt saiti.';

  @override
  String get conversationGoneTitle => 'Nav ziņojuma';

  @override
  String get conversationGoneText => 'Šis ziņojums ir pārvietots vai izdzēsts.';

  @override
  String get conversationMuted => 'Apklusināts';

  @override
  String get conversationReaderOptions => 'Lasīšanas opcijas';

  @override
  String get conversationReaderOptionsHint => 'Teksta lielums un skats';

  @override
  String get conversationTrash => 'Uz miskasti';

  @override
  String get conversationReplyHint => 'Turiet nospiestu, lai atbildētu visiem vai pārsūtītu';

  @override
  String get conversationOfflineTitle => 'Jūs esat bezsaistē';

  @override
  String get conversationOfflineText =>
      'Šī saruna vēl nav lejupielādēta. Tā tiks ielādēta, kad atkal būsiet tiešsaistē.';

  @override
  String get conversationErrorTitle => 'Nevar parādīt šo ziņojumu';

  @override
  String get conversationErrorText => 'Radās kļūda.';

  @override
  String get conversationOfflineBanner => 'Jūs esat bezsaistē';

  @override
  String get conversationNotUpdated => 'Nav atjaunināts';

  @override
  String get conversationMe => 'es';

  @override
  String get conversationNoSender => '(nav sūtītāja)';

  @override
  String get conversationNoRecipients => 'nav adresātu';

  @override
  String conversationRecipients(String names) {
    return 'kam: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'kam: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'No';

  @override
  String get conversationHeaderTo => 'Kam';

  @override
  String get conversationHeaderCc => 'Kopija';

  @override
  String get conversationHeaderBcc => 'Diskrētā kopija';

  @override
  String get conversationHeaderReplyTo => 'Atbildēt uz';

  @override
  String get conversationHeaderDate => 'Datums';

  @override
  String get conversationHeaderSecurity => 'Drošība';

  @override
  String get conversationVerifiedSender => 'Pārbaudīts sūtītājs';

  @override
  String get conversationUnverifiedSender => 'Nepārbaudīts sūtītājs';

  @override
  String get conversationLoadingMessage => 'Ielādē ziņojumu';

  @override
  String get conversationBodyError => 'Šo ziņojumu neizdevās ielādēt.';

  @override
  String get conversationBodyOffline => 'Jūs esat bezsaistē. Ziņojums tiks ielādēts, kad atkal būsiet tiešsaistē.';

  @override
  String get conversationOriginalHint => 'Skatā „Oriģināls“ izskatās labāk';

  @override
  String get conversationShowOriginal => 'Rādīt oriģinālu';

  @override
  String get conversationScrollToTop => 'Ritināt uz augšu';

  @override
  String get conversationTagsMenu => 'Birkas…';

  @override
  String get conversationMuteThread => 'Apklusināt pavedienu';

  @override
  String get conversationUnmuteThread => 'Atcelt pavediena apklusināšanu';

  @override
  String get conversationMoveMenu => 'Pārvietot…';

  @override
  String get conversationDeletePermanently => 'Dzēst neatgriezeniski';

  @override
  String get conversationMoveToTrash => 'Pārvietot uz miskasti';

  @override
  String get conversationNotJunk => 'Nav mēstule';

  @override
  String get conversationShowAllHeaders => 'Rādīt visas galvenes';

  @override
  String get conversationViewSource => 'Skatīt avotu';

  @override
  String get conversationSaveAsFile => 'Saglabāt kā failu…';

  @override
  String get conversationShareAsFile => 'Kopīgot kā failu…';

  @override
  String get conversationSearchFromMessageMenu => 'Meklēt pēc šī ziņojuma…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopēt adresi';

  @override
  String get conversationAddressCopied => 'Adrese nokopēta';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Meklēt sūtītāja $name ziņojumus';
  }

  @override
  String get conversationTags => 'Birkas';

  @override
  String get conversationAllHeaders => 'Visas galvenes';

  @override
  String get conversationCopyAll => 'Kopēt visu';

  @override
  String get conversationHeadersCopied => 'Galvenes nokopētas';

  @override
  String get conversationNoHeaders => 'Nav galveņu';

  @override
  String get conversationSearchFromMessageTitle => 'Meklēt pēc šī ziņojuma';

  @override
  String conversationSearchFrom(String name) {
    return 'No: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Kam: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Temats „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Avots';

  @override
  String get conversationSourceCopied => 'Avots nokopēts';

  @override
  String get conversationShareFailed => 'Neizdevās kopīgot ziņojumu.';

  @override
  String get conversationWrapLines => 'Aplauzt rindas';

  @override
  String get conversationDontWrapLines => 'Neaplauzt rindas';

  @override
  String get conversationSourceError => 'Avotu neizdevās ielādēt.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Tiek rādīti pirmie $shown no $total. Lai iegūtu visu, nokopējiet vai kopīgojiet.';
  }

  @override
  String get conversationAttachmentUntitled => 'Bez nosaukuma';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Citas darbības ar $name';
  }

  @override
  String get conversationMoveTo => 'Pārvietot uz…';

  @override
  String get conversationMailboxesError => 'Neizdevās ielādēt pastkastes.';

  @override
  String get conversationReaderReadable => 'Lasīšanai';

  @override
  String get conversationReaderOriginal => 'Oriģināls';

  @override
  String get conversationReaderPlain => 'Vienkāršs';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Saglabāt oriģinālās krāsas';

  @override
  String get conversationReaderRemember => 'Atcerēties šim sūtītājam';

  @override
  String get conversationSecurityPossiblePhishing => 'Iespējama pikšķerēšana';

  @override
  String get conversationSecurityBeCareful => 'Esiet piesardzīgi';

  @override
  String get conversationSecurityVerified => 'Pārbaudīts';

  @override
  String get conversationSecurityNoIssues => 'Problēmas nav atrastas';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count izsekotāji',
      one: '$count izsekotājs',
      zero: '$count izsekotāju',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Parāda iemeslu';

  @override
  String get conversationPhishingBannerTitle => 'Šis ziņojums izskatās pēc pikšķerēšanas';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Saites un attēli ir izslēgti.';
  }

  @override
  String get conversationPhishingBannerText => 'Saites un attēli ir izslēgti.';

  @override
  String get conversationPhishingWhy => 'Kāpēc?';

  @override
  String get conversationPhishingShowAnyway => 'Tomēr rādīt';

  @override
  String get conversationSecurityPhishingTitle => 'Tas izskatās pēc pikšķerēšanas';

  @override
  String get conversationSecurityPhishingText => 'Vairākas pazīmes liecina, ka šis ziņojums nav tas, par ko uzdodas.';

  @override
  String get conversationSecurityCarefulTitle => 'Esiet piesardzīgi ar šo ziņojumu';

  @override
  String get conversationSecurityCarefulText => 'Kaut kas tajā ir pelnījis rūpīgāku apskati.';

  @override
  String get conversationSecurityVerifiedText => 'Sūtītājs ir pārbaudīts, un nekas neizskatās aizdomīgs.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nekas neizskatās aizdomīgs. Jūsu pasta serveris nenorādīja, vai sūtītājs ir pārbaudīts.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nekas neizskatās aizdomīgs.';

  @override
  String get conversationSecurityWhy => 'Kāpēc';

  @override
  String get conversationSecurityPrivacy => 'Privātums';

  @override
  String get conversationSecurityNoTrackingPixels => 'Nav izsekošanas pikseļu';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noņemti $count izsekošanas pikseļi',
      one: 'Noņemts $count izsekošanas pikselis',
      zero: 'Noņemti $count izsekošanas pikseļu',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Tie būtu paziņojuši sūtītājam, kad atvērāt šo ziņojumu.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nav attālo attēlu';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attālie attēli',
      one: '$count attālais attēls',
      zero: '$count attālo attēlu',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ja tos ielādēsiet, sūtītājs uzzinās, kad lasāt šo ziņojumu, kā arī jūsu IP adresi.';

  @override
  String get conversationSecurityNoClickTracking => 'Nav klikšķu izsekošanas';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saites caur klikšķu izsekotājiem',
      one: '$count saite caur klikšķu izsekotājiem',
      zero: '$count saišu caur klikšķu izsekotājiem',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services reģistrētu jūsu klikšķi. Turiet saiti nospiestu, lai atvērtu tās galamērķi tieši.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tehniskā informācija';

  @override
  String get conversationSecurityCheckedLocally => 'Pārbaudīts šajā ierīcē. Nekas netika nekur nosūtīts.';

  @override
  String get conversationSecurityTrackersLabel => 'Izsekotāji';

  @override
  String get conversationSecurityImagesFrom => 'Attēli no';

  @override
  String get conversationSecuritySenderHistory => 'Sūtītāja vēsture';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'saņemti: $received, nosūtīti: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Saites ved uz';

  @override
  String get conversationSecurityHidden => 'Paslēpts';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementi',
      one: '$elements elements',
      zero: '$elements elementu',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters rakstzīmes',
      one: '$characters rakstzīme',
      zero: '$characters rakstzīmju',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Sūtītājs nav pārbaudīts';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Jūsu pasta serveris nevarēja apstiprināt, ka šis ziņojums tiešām ir no $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Jūsu pasta serveris nevarēja apstiprināt, ka šis ziņojums tiešām ir no tā sūtītāja.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Jūsu pasta serveris nevarēja apstiprināt, ka šis ziņojums ir no $domain. E-pasta sarakstiem tas ir bieži.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Jūsu pasta serveris nevarēja apstiprināt, ka šis ziņojums ir no tā sūtītāja. E-pasta sarakstiem tas ir bieži.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nerīkojieties pēc tā, ja vien to negaidījāt. Ja šaubāties, sazinieties ar sūtītāju citā veidā.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Parakstījis cits domēns';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Ziņojumu ir parakstījis $signer, nevis $domain. Tā dara e-pasta sūtīšanas pakalpojumi, taču tas nepierāda, kas to uzrakstīja.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Ziņojumu ir parakstījis cits domēns, nevis $domain. Tā dara e-pasta sūtīšanas pakalpojumi, taču tas nepierāda, kas to uzrakstīja.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Vārdā redzama cita adrese';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Sūtītāja vārds ir „$shown“, bet ziņojums nāk no $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Uzticieties adresei, nevis vārdam.';

  @override
  String get conversationSecurityReplyToTitle => 'Atbildes nonāks citur';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Jūsu atbilde tiktu nosūtīta uz $address, nevis uz $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Pirms atbildat ar kaut ko personisku, pārbaudiet adresi.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Izmanto jūsu vārdu';

  @override
  String get conversationSecurityImpersonationTitle => 'Izmanto kāda jums pazīstama cilvēka vārdu';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Paraksts ir „$name“ — tāpat kā jūsu vārds, taču ziņojums nāk no jaunas adreses: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Paraksts ir „$name“ — tāpat kā jūsu VIP $knownName ($knownEmail), taču ziņojums nāk no jaunas adreses: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Paraksts ir „$name“ — tāpat kā $knownName ($knownEmail), taču ziņojums nāk no jaunas adreses: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Un atbildes nonāktu vēl citā adresē.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ja tajā tiek prasīta nauda, kodi vai faili, vispirms pārliecinieties pie šī cilvēka citā veidā.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Zināmā adrese: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Šī adrese: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Pirmais ziņojums no šī sūtītāja';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'No $email līdz šim pasts nav saņemts.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Esiet piesardzīgi ar lūgumiem no cilvēkiem, kurus vēl nepazīstat.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Līdzīga izskata burti sūtītāja adresē';

  @override
  String get conversationSecurityLinkHomographTitle => 'Līdzīga izskata burti saitē';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host jauc dažādu alfabētu burtus, lai atdarinātu citu adresi.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host izmanto līdzīga izskata burtus: tas nav $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Izdzēsiet to vai ziņojiet par to kā par mēstuli.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Neatveriet to.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domēns: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Līdzīga izskata domēns';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Domēnā izmantots pazīstams nosaukums';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain izskatās pēc jūsu domēna $real, taču tas ir cits domēns.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain izskatās pēc $brand ($real), taču tas ir cits domēns.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain izmanto jūsu domēna $real nosaukumu, taču tam nepieder.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain izmanto $brand ($real) nosaukumu, taču tam nepieder.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Īsti ziņojumi no jūsu organizācijas nāk no $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Īsti ziņojumi no $brand nāk no $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Sūtītāja domēns: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Atdarina: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saites slēpj, kurp tās ved',
      one: '$count saite slēpj, kurp tā ved',
      zero: '$count saišu slēpj, kurp tās ved',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Saitē redzams $shown, taču tā atver $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Nepierakstieties un nemaksājiet, izmantojot šīs saites. Tā vietā ierakstiet adresi paši.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Saites galamērķi nevar pārbaudīt';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Saitē redzams $shown, taču tā ved caur $host, kas reģistrē klikšķi, pirms to nodod tālāk.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Saite norāda uz IP adresi';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nav vietne ar nosaukumu. Īsti uzņēmumi reti izmanto šādas saites.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Maskēta saite';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Saite sākas ar „$shown@“, lai izskatītos pēc $shown, taču tā atver $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Slēpta lapa atspējota';

  @override
  String get conversationSecurityDataLinkText =>
      'Saite būtu atvērusi ziņojumā iepakotu lapu — tas ir veids, kā apiet saišu pārbaudes.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Prasa paroli';

  @override
  String get conversationSecurityPasswordFieldText => 'Ziņojumā bija paroles lauks. Loupe to noņēma.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nekad neievadiet paroli e-pasta ziņojumā.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Saite, kas izpilda kodu, atspējota';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nekad neizpilda kodu no ziņojumiem.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saīsinātas saites',
      one: '$count saīsināta saite',
      zero: '$count saīsinātu saišu',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts slēpj īsto galamērķi, līdz to atverat.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Starptautiska tīmekļa adrese';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts izmanto nelatīņu burtus. Daudzās valodās tas ir normāli; pārbaudiet, vai tā ir vietne, ko gaidāt.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Daudz slēpta teksta';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Noņemts neredzams teksts $count rakstzīmju garumā. Šāds slēpts teksts ir paredzēts mēstuļu filtru maldināšanai.',
      one:
          'Noņemts neredzams teksts $count rakstzīmes garumā. Šāds slēpts teksts ir paredzēts mēstuļu filtru maldināšanai.',
      zero:
          'Noņemts neredzams teksts $count rakstzīmju garumā. Šāds slēpts teksts ir paredzēts mēstuļu filtru maldināšanai.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Slēpts teksts noņemts';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noņemts neredzams teksts $count rakstzīmju garumā.',
      one: 'Noņemts neredzams teksts $count rakstzīmes garumā.',
      zero: 'Noņemts neredzams teksts $count rakstzīmju garumā.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Neizdevās lejupielādēt ziņojumu. Pārbaudiet savienojumu un mēģiniet vēlreiz.';

  @override
  String exportSaved(String name) {
    return 'Saglabāts „$name“';
  }

  @override
  String get exportSaveFailed => 'Neizdevās saglabāt ziņojumu.';

  @override
  String exportFailed(String folder) {
    return 'Neizdevās eksportēt „$folder“.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Mapē „$folder“ nav ziņojumu, ko eksportēt.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Neizdevās eksportēt „$folder“: nevienu ziņojumu nevarēja lejupielādēt. Pārbaudiet savienojumu un mēģiniet vēlreiz.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Saglabāts „$name“ bez $formattedCount ziņojumiem, kurus nevarēja lejupielādēt.',
      one: 'Saglabāts „$name“ bez $count ziņojuma, kuru nevarēja lejupielādēt.',
      zero: 'Saglabāts „$name“ bez $formattedCount ziņojumiem, kurus nevarēja lejupielādēt.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Neizdevās saglabāt „$name“.';
  }

  @override
  String exportTitle(String folder) {
    return 'Eksportē „$folder“';
  }

  @override
  String get exportListing => 'Meklē ziņojumus…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksportē $current no $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nevarēja lejupielādēt $formattedCount ziņojumus',
      one: 'Nevarēja lejupielādēt $count ziņojumu',
      zero: 'Nevarēja lejupielādēt $formattedCount ziņojumu',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Pastkastes';

  @override
  String get mailboxesShown => 'Rādīta';

  @override
  String get mailboxesHidden => 'Paslēpta';

  @override
  String get mailboxesCollapse => 'Sakļaut';

  @override
  String get mailboxesExpand => 'Izvērst';

  @override
  String get mailboxesManageVips => 'Pārvaldīt VIP';

  @override
  String get mailboxesSubscriptions => 'Abonementi';

  @override
  String mailboxesShowAccount(String account) {
    return 'Rādīt $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Paslēpt $account';
  }

  @override
  String get mailboxesExportFolder => 'Eksportēt mapi…';

  @override
  String get mailboxesUnpin => 'Atspraust';

  @override
  String get mailboxesLists => 'Saraksti';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Saglabājiet meklēšanu, lai tā būtu šeit.';

  @override
  String get mailboxesTags => 'Birkas';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Varat arī ziņojumā pieskarties sūtītāja vārdam un ieslēgt VIP.';

  @override
  String get mailboxesAddVip => 'Pievienot VIP…';

  @override
  String get mailboxesAddVipTitle => 'Pievienot VIP';

  @override
  String get mailboxesAddVipText => 'Pasts no šīs adreses saņem zvaigznīti un parādās VIP pastkastē.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Nelasītie';

  @override
  String get messageListFilterFlagged => 'Ar karodziņu';

  @override
  String get messageListFilterToMe => 'Kam: man';

  @override
  String get messageListFilterCcMe => 'Kopija: man';

  @override
  String get messageListFilterWithAttachments => 'Ar pielikumiem';

  @override
  String get messageListFilterUnreplied => 'Neatbildētie';

  @override
  String get messageListFilterFromVips => 'No VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi atzīmēti kā lasīti',
      one: '$count ziņojums atzīmēts kā lasīts',
      zero: '$count ziņojumu atzīmēti kā lasīti',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Neizdevās ielādēt vecāko pastu.';

  @override
  String get messageListSelectMessages => 'Atlasīt ziņojumus';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atlasīti: $count',
      one: 'Atlasīts: $count',
      zero: 'Atlasīti: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Atlasīt visu';

  @override
  String get messageListDeselectAll => 'Noņemt atlasi';

  @override
  String get messageListLoadFailed => 'Neizdevās ielādēt pastu';

  @override
  String get messageListNoUnread => 'Nav nelasīta pasta';

  @override
  String get messageListNoMatches => 'Nav atbilstoša pasta';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrs: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Izslēgt filtru';

  @override
  String get messageListEmpty => 'Nav pasta';

  @override
  String get messageListFilter => 'Filtrs';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtra kritēriji: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrs:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount nelasīti',
      one: '$count nelasīts',
      zero: '$formattedCount nelasītu',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Atzīmēt';

  @override
  String get messageListTrash => 'Uz miskasti';

  @override
  String get messageListFilterTitle => 'Filtrs';

  @override
  String get messageListFilterInclude => 'IEKĻAUT';

  @override
  String get panesHideMailboxes => 'Paslēpt pastkastes';

  @override
  String get panesShowMailboxes => 'Rādīt pastkastes';

  @override
  String get panesMailboxesWidth => 'Pastkastu kolonnas platums';

  @override
  String get panesListWidth => 'Ziņojumu saraksta platums';

  @override
  String get panesNoMessageSelected => 'Nav atlasīts neviens ziņojums';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi',
      one: '$count ziņojums',
      zero: '$count ziņojumu',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Atliktie';

  @override
  String get snoozeSheetTitle => 'Atlikt';

  @override
  String get snoozeLaterToday => 'Vēlāk šodien';

  @override
  String get snoozeThisEvening => 'Šovakar';

  @override
  String get snoozeTomorrow => 'Rīt';

  @override
  String get snoozeThisWeekend => 'Šajā nedēļas nogalē';

  @override
  String get snoozeNextWeek => 'Nākamnedēļ';

  @override
  String get snoozePickDateTime => 'Izvēlēties datumu un laiku…';

  @override
  String get snoozeMenu => 'Atlikt…';

  @override
  String get snoozeWakeNow => 'Atgriezt tūlīt';

  @override
  String get snoozeChangeTimeMenu => 'Mainīt atlikšanas laiku…';

  @override
  String get snoozeChangeTime => 'Mainīt laiku';

  @override
  String get snoozeNoTime => 'Laiks nav iestatīts';

  @override
  String get snoozeFooter => 'Atliktie ziņojumi noteiktajā laikā atgriežas iesūtnē kā nelasīti.';

  @override
  String get snoozeEmptyTitle => 'Nav atliktu ziņojumu';

  @override
  String get snoozeEmptyText => 'Atlieciet ziņojumu, lai tas atgrieztos iesūtnē, kad jums tas būs vajadzīgs.';

  @override
  String get appLockUnlock => 'Atbloķēt';

  @override
  String get appLockFailed => 'Loupe nevarēja apstiprināt, ka tas esat jūs.';

  @override
  String get appLockLockedOut => 'Pārāk daudz mēģinājumu. Mēģiniet vēlreiz vēlāk.';

  @override
  String get appLockPromptError => 'Uzvedni neizdevās parādīt. Mēģiniet vēlreiz.';

  @override
  String get appLockNoScreenLock => 'Šim tālrunim nav iestatīta ekrāna bloķēšana.';

  @override
  String get appLockUnlockPromptTitle => 'Atbloķēt Loupe';

  @override
  String get appLockUnlockPromptReason => 'Apstipriniet, ka tas esat jūs, lai redzētu savu pastu.';

  @override
  String get appLockTurnOnPromptTitle => 'Ieslēgt lietotnes bloķēšanu';

  @override
  String get appLockTurnOnPromptReason => 'Apstipriniet, ka tas esat jūs, lai ieslēgtu lietotnes bloķēšanu.';

  @override
  String get appLockScreenLockRemoved =>
      'Lietotnes bloķēšana ir izslēgta: šim tālrunim vairs nav ekrāna bloķēšanas. Iestatiet to, lai atkal ieslēgtu lietotnes bloķēšanu.';

  @override
  String get appLockAfterImmediately => 'Nekavējoties';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minūtes',
      one: '$count minūte',
      zero: '$count minūšu',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stundas',
      one: '$count stunda',
      zero: '$count stundu',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Šifrēts';

  @override
  String get openpgpEncryptedInPart => 'Daļēji šifrēts';

  @override
  String get openpgpEncryptedLocked => 'Šifrēts · bloķēts';

  @override
  String get openpgpEncryptedNoKey => 'Šifrēts · nav atslēgas';

  @override
  String get openpgpEncryptedDamaged => 'Šifrēts · bojāts';

  @override
  String get openpgpEncryptedUnsupported => 'Šifrēts · neatbalstīts';

  @override
  String get openpgpUnknownSigner => 'nezināms';

  @override
  String get openpgpUnknownKey => 'Nezināma atslēga';

  @override
  String get openpgpSignatureInvalid => 'Nederīgs paraksts';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Parakstījis $name, nevis sūtītājs';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Daļēji parakstījis $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Parakstījis $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Parakstīts ar noraidītu atslēgu';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Parakstījis $name · atslēga nav pieņemta';
  }

  @override
  String get openpgpUnlock => 'Atbloķēt';

  @override
  String get openpgpCantDecrypt => 'Nevar atšifrēt šo ziņojumu';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifrēts ar OpenPGP';

  @override
  String get openpgpEncryption => 'Šifrēšana';

  @override
  String get openpgpDecryptedHere => 'Atšifrēts šajā ierīcē';

  @override
  String get openpgpNotDecrypted => 'Nav atšifrēts';

  @override
  String get openpgpKeyLocked => 'Jūsu atslēga ir bloķēta.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Atslēgu ID: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Aizsargāts temats';

  @override
  String get openpgpUnlockKey => 'Atbloķēt atslēgu';

  @override
  String get openpgpSignature => 'Paraksts';

  @override
  String get openpgpFingerprint => 'Pirkstu nospiedums';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Atslēgas ID $id';
  }

  @override
  String get openpgpSigned => 'Parakstīts';

  @override
  String get openpgpProblem => 'Problēma';

  @override
  String get openpgpAcceptance => 'Pieņemšana';

  @override
  String get openpgpChangeAcceptance => 'Mainīt pieņemšanu…';

  @override
  String get openpgpCheckedFooter => 'Pārbaudīts šajā ierīcē ar OpenPGP, saderīgs ar Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Jūsu atslēga ir bloķēta. Atbloķējiet to ar tās paroles frāzi, lai lasītu šo ziņojumu.';

  @override
  String get openpgpSummaryNoSecretKey => 'Tas tika šifrēts atslēgai, kuras šajā ierīcē nav.';

  @override
  String get openpgpSummaryDamaged => 'Šifrētie dati ir bojāti vai tika mainīti ceļā.';

  @override
  String get openpgpSummaryUnsupported => 'Tajā izmantots algoritms, ko Loupe neatbalsta.';

  @override
  String get openpgpSummaryEncrypted => 'To var lasīt tikai jūs un pārējie adresāti.';

  @override
  String get openpgpSummaryNotSigned => 'Tas nav parakstīts, tāpēc sūtītājs nav apstiprināts.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Tas ir parakstīts, bet ar atslēgu, kuras jums nav, tāpēc parakstu nevar pārbaudīt.';

  @override
  String get openpgpSummaryBadSignature => 'Paraksts neatbilst: ziņojums, iespējams, ir mainīts.';

  @override
  String get openpgpSummaryMismatch => 'Paraksts ir derīgs, bet atslēga pieder citai adresei, nevis sūtītājam.';

  @override
  String get openpgpSummaryPartial =>
      'Parakstīta ir tikai daļa ziņojuma. Teksts ārpus paraksta (piemēram, e-pasta saraksta kājene) tiek rādīts zem rindas „Unsigned content“, un parakstā nav iekļautas arī citas ziņojuma daļas, piemēram, pielikumi.';

  @override
  String get openpgpSummaryOwnKey => 'Parakstīts ar jūsu atslēgu.';

  @override
  String get openpgpSummaryVerified => 'Paraksts ir derīgs, un jūs pārbaudījāt atslēgas pirkstu nospiedumu.';

  @override
  String get openpgpSummaryUnverified =>
      'Paraksts ir derīgs. Jūs pieņēmāt atslēgu, nepārbaudot tās pirkstu nospiedumu.';

  @override
  String get openpgpSummaryRejected => 'Paraksts ir derīgs, bet jūs noraidījāt šo atslēgu.';

  @override
  String get openpgpSummaryUndecided =>
      'Paraksts ir derīgs, bet šī atslēga vēl nav pieņemta. Salīdziniet tās pirkstu nospiedumu ar sūtītāju.';

  @override
  String get openpgpAcceptanceRejected => 'Noraidīta';

  @override
  String get openpgpAcceptanceUndecided => 'Nav pieņemta';

  @override
  String get openpgpAcceptanceUnverified => 'Pieņemta';

  @override
  String get openpgpAcceptanceVerified => 'Pieņemta un pārbaudīta';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Vai pieņemt $name atslēgu?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Pirkstu nospiedums $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Jā, es pārbaudīju pirkstu nospiedumu';

  @override
  String get openpgpAcceptUnverified => 'Jā, bez pārbaudes';

  @override
  String get openpgpAcceptLater => 'Vēl ne';

  @override
  String get openpgpRejectKey => 'Noraidīt šo atslēgu';

  @override
  String get openpgpNoSubject => '(bez temata)';

  @override
  String get openpgpEncryptionTitle => 'Pilnīga šifrēšana';

  @override
  String get openpgpMyKeys => 'Manas OpenPGP atslēgas';

  @override
  String get openpgpMyKeysFooter =>
      'Ar atslēgu varat lasīt šifrētu pastu, kā arī parakstīt un šifrēt savējo. Izmantojat Thunderbird? Eksportējiet atslēgu tur (Konta iestatījumi › Pilnīga šifrēšana › Eksportēt slepeno atslēgu) un importējiet to šeit.';

  @override
  String get openpgpAddKey => 'Pievienot atslēgu…';

  @override
  String get openpgpAddresses => 'Adreses';

  @override
  String get openpgpAddressesFooter => 'Kuru atslēgu izmanto katra adrese un kad tā šifrē un paraksta.';

  @override
  String get openpgpCorrespondentsKeys => 'Sarakstes partneru OpenPGP atslēgas';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Pieņemiet atslēgu, kad uzticaties, ka tā pieder tās īpašniekam; salīdziniet pirkstu nospiedumu ar īpašnieku, lai atzīmētu to kā pārbaudītu.';

  @override
  String get openpgpImportPublicKey => 'Importēt publisko atslēgu…';

  @override
  String get openpgpCollected => 'Savāktas ar Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Atslēgas, kas saņemtas kopā ar ziņojumiem. Loupe var ar tām šifrēt, ja abas puses to vēlas.';

  @override
  String get openpgpOnThisDevice => 'Šajā ierīcē';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifrēti ziņojumi slēpj savu tematu. Loupe saglabā katra atvērtā ziņojuma tematu savā šifrētajā datubāzē šajā ierīcē, lai to varētu rādīt sarakstā, meklēšanā un paziņojumos. Fonā Loupe var arī atšifrēt jaunu ziņojumu tematus ar atslēgām, kurām nav paroles frāzes; lai to izdarītu, tā lejupielādē katru ziņojumu (līdz 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Atšifrēt tematus fonā';

  @override
  String get openpgpIndexFooter =>
      'Meklēšana atrod šifrētus ziņojumus pēc sūtītāja, adresātiem un temata. Ja šī opcija ir ieslēgta, Loupe katra atšifrētā ziņojuma tekstu pievieno arī meklēšanas indeksam savā šifrētajā datubāzē šajā ierīcē, lai meklēšana tos atrastu arī pēc teksta. Izslēdzot to, šis teksts tiek noņemts no indeksa.';

  @override
  String get openpgpIndexDecrypted => 'Indeksēt atšifrētos ziņojumus meklēšanai';

  @override
  String get openpgpPassphrases => 'Paroles frāzes';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP atslēgas un S/MIME sertifikāti, ko aizsargājat ar paroles frāzi, tiek atbloķēti, kad tas nepieciešams. Bez opcijas „Atcerēties paroles frāzes“ tie tiek atkal bloķēti divas minūtes pēc katras lietošanas.';

  @override
  String get openpgpRememberPassphrases => 'Atcerēties paroles frāzes';

  @override
  String get openpgpRememberPassphrasesDetail => 'Līdz Loupe aizvēršanai';

  @override
  String get openpgpLockKeysNow => 'Bloķēt atslēgas tūlīt';

  @override
  String get openpgpKeysLocked => 'Atslēgas bloķētas.';

  @override
  String get openpgpKeyStateRevoked => 'atsaukta';

  @override
  String get openpgpKeyStateExpired => 'beigusies';

  @override
  String get openpgpKeyStateNeverExpires => 'nebeidzas nekad';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'beidzas $date';
  }

  @override
  String get openpgpNoKey => 'Nav atslēgas';

  @override
  String get openpgpAlwaysEncrypt => 'Vienmēr šifrēt';

  @override
  String get openpgpAddKeyTitle => 'Pievienot OpenPGP atslēgu';

  @override
  String get openpgpAddKeyMessage => 'Importējiet atslēgu, ko izmantojat Thunderbird, vai izveidojiet jaunu.';

  @override
  String get openpgpImportFromClipboard => 'Importēt no starpliktuves';

  @override
  String get openpgpImportFromFile => 'Importēt no faila';

  @override
  String get openpgpGenerateNewKey => 'Ģenerēt jaunu atslēgu';

  @override
  String get openpgpImportPublicKeyTitle => 'Importēt publisko atslēgu';

  @override
  String get openpgpFromClipboard => 'No starpliktuves';

  @override
  String get openpgpFromFile => 'No faila';

  @override
  String get openpgpClipboardEmpty => 'Starpliktuve ir tukša. Vispirms nokopējiet atslēgu.';

  @override
  String get openpgpKey => 'Atslēga';

  @override
  String get openpgpValidityRevoked => 'Atsaukta';

  @override
  String openpgpValidityExpired(String date) {
    return 'Beigusies $date';
  }

  @override
  String get openpgpNeverExpires => 'Nebeidzas nekad';

  @override
  String openpgpValidUntil(String date) {
    return 'Derīga līdz $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Pirkstu nospiedums nokopēts.';

  @override
  String get openpgpAlgorithm => 'Algoritms';

  @override
  String get openpgpCreated => 'Izveidota';

  @override
  String get openpgpValidity => 'Derīgums';

  @override
  String get openpgpProtection => 'Aizsardzība';

  @override
  String get openpgpProtectionPassphrase => 'Paroles frāze';

  @override
  String get openpgpProtectionKeychain => 'Tikai atslēgu krātuve';

  @override
  String get openpgpKeyDetailsFooter =>
      'Kopīgojiet savu publisko atslēgu, lai citi varētu jums sūtīt šifrētu pastu. Rezerves kopija ir jūsu slepenā atslēga, ko aizsargā tās paroles frāze, ja tāda ir: glabājiet to privāti.';

  @override
  String get openpgpSharePublicKey => 'Kopīgot publisko atslēgu';

  @override
  String get openpgpCopyPublicKey => 'Kopēt publisko atslēgu';

  @override
  String get openpgpPublicKeyCopied => 'Publiskā atslēga nokopēta.';

  @override
  String get openpgpBackUpSecretKey => 'Dublēt slepeno atslēgu';

  @override
  String get openpgpDeleteKey => 'Dzēst atslēgu';

  @override
  String get openpgpRemoveKey => 'Noņemt atslēgu';

  @override
  String get openpgpBackUpTitle => 'Vai dublēt slepeno atslēgu?';

  @override
  String get openpgpBackUpProtected =>
      'Rezerves kopiju aizsargā jūsu atslēgas paroles frāze. Ikviens, kam ir abas, var lasīt jūsu pastu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Šai atslēgai nav paroles frāzes: ikviens, kam ir rezerves kopija, var lasīt jūsu pastu un parakstīt jūsu vārdā.';

  @override
  String get openpgpBackUp => 'Dublēt';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Vai dzēst savu atslēgu $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Vai noņemt $name atslēgu?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Šai atslēgai šifrēto pastu šajā ierīcē vairs nevarēs izlasīt, ja vien to neimportēsiet vēlreiz.';

  @override
  String get openpgpRemoveKeyMessage => 'Vēlāk to varēsiet importēt vēlreiz.';

  @override
  String get openpgpKeyHeader => 'OpenPGP atslēga';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Pievienojiet atslēgu sadaļā „Pilnīga šifrēšana“, lai šifrētu un parakstītu pastu no šīs adreses.';

  @override
  String get openpgpGenerateAKey => 'Ģenerēt atslēgu…';

  @override
  String get openpgpSending => 'Sūtīšana';

  @override
  String get openpgpSendingFooter =>
      'Automātiskā šifrēšana ieslēdzas, ja katram adresātam ir pieņemta atslēga vai uzticams sertifikāts vai ja Autocrypt norāda, ka abas puses to vēlas. Šifrēts pasts vienmēr tiek parakstīts.';

  @override
  String get openpgpEncryptAutomatically => 'Šifrēt automātiski';

  @override
  String get openpgpAlwaysEncryptDetail => 'Atsakās sūtīt, ja adresātam nav atslēgas';

  @override
  String get openpgpSignUnencrypted => 'Parakstīt nešifrētu pastu';

  @override
  String get openpgpAttachPublicKey => 'Pievienot manu publisko atslēgu';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt kopā ar katru ziņojumu nosūta jūsu publisko atslēgu, lai citas lietotnes bez jebkādas iestatīšanas varētu jums sūtīt šifrētu pastu.';

  @override
  String get openpgpSendMyKey => 'Sūtīt manu atslēgu kopā ar pastu';

  @override
  String get openpgpPreferEncryption => 'Dot priekšroku šifrēšanai';

  @override
  String get openpgpPreferEncryptionDetail => 'Lūgt citiem šifrēt, kad viņi to var';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gadi',
      one: '$count gads',
      zero: '$count gadu',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Paroles frāzes nesakrīt.';

  @override
  String openpgpKeyReady(String id) {
    return 'Jūsu atslēga $id ir gatava.';
  }

  @override
  String get openpgpNewKey => 'Jauna atslēga';

  @override
  String get openpgpNewKeyFor => 'Kam';

  @override
  String get openpgpYourName => 'Jūsu vārds';

  @override
  String get openpgpAddress => 'Adrese';

  @override
  String get openpgpPassphrase => 'Paroles frāze';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Neobligāti. Bez tās atslēgu aizsargā tikai jūsu tālruņa atslēgu krātuve, un Loupe to nekad neprasa. Ja tā ir iestatīta, Loupe to prasa, kad atslēga ir vajadzīga.';

  @override
  String get openpgpRepeatPassphrase => 'Atkārtot';

  @override
  String get openpgpExpires => 'Derīguma termiņš';

  @override
  String get openpgpExpiresFooter =>
      'Pirms termiņa beigām varat izveidot jaunu atslēgu. Arī Thunderbird izmanto trīs gadus.';

  @override
  String get openpgpGenerateKey => 'Ģenerēt atslēgu';

  @override
  String get openpgpKeyFor => 'Atslēga adresei';

  @override
  String get openpgpCantEncrypt => 'Nevar šifrēt';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nav OpenPGP atslēgas šiem adresātiem: $names, un šī adrese vienmēr šifrē. Noņemiet adresātu vai importējiet tā atslēgu sadaļā Iestatījumi › Pilnīga šifrēšana.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nav derīga S/MIME sertifikāta šiem adresātiem: $names, un šī adrese vienmēr šifrē. Noņemiet adresātu vai importējiet tā sertifikātu sadaļā Iestatījumi › Pilnīga šifrēšana.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nav OpenPGP atslēgas šiem adresātiem: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nav derīga S/MIME sertifikāta šiem adresātiem: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Sūtīt nešifrētu';

  @override
  String get openpgpCantSign => 'Nevar parakstīt';

  @override
  String get openpgpCantSignMessage =>
      'Jūsu S/MIME sertifikāta privātās atslēgas šajā ierīcē nav. Importējiet sertifikātu vēlreiz (.p12 vai .pfx failu) sadaļā Iestatījumi › Pilnīga šifrēšana.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nav atslēgas: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nav sertifikāta: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Atslēgas no Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Visiem ir atslēga';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Visiem ir sertifikāts';

  @override
  String get openpgpComposeEncrypt => 'Šifrēt';

  @override
  String get openpgpComposeSign => 'Parakstīt';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, pārslēgt';
  }

  @override
  String get openpgpNoKeyFound => 'OpenPGP atslēga nav atrasta.';

  @override
  String get openpgpImportSecretKeyTitle => 'Vai importēt slepeno atslēgu?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Šajā pielikumā ir slepenā atslēga ($names). Importējiet to kā savu atslēgu tikai tad, ja paši to eksportējāt, piemēram, no Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importēt kā manu atslēgu';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'jūsu atslēga $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vai importēt $count atslēgas ($names)?',
      one: 'Vai importēt $count atslēgu ($names)?',
      zero: 'Vai importēt $count atslēgu ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importēt un pieņemt';

  @override
  String get openpgpImportDecideLater => 'Importēt, izlemt vēlāk';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name atslēga';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importēts: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pielikumā ir $count OpenPGP atslēgas.',
      one: 'Pielikumā ir $count OpenPGP atslēga.',
      zero: 'Pielikumā ir $count OpenPGP atslēgu.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importēt';

  @override
  String get openpgpUnlockKeyTitle => 'Atbloķēt OpenPGP atslēgu';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Ievadiet atslēgas $id ($name) paroles frāzi.';
  }

  @override
  String get openpgpWrongPassphrase => 'Paroles frāze ir nepareiza. Mēģiniet vēlreiz.';

  @override
  String get openpgpExplainLocked => 'Šis ziņojums ir šifrēts. Atbloķējiet savu OpenPGP atslēgu, lai to izlasītu.';

  @override
  String get openpgpExplainNoKey =>
      'Šis ziņojums ir šifrēts, bet ne kādai no OpenPGP atslēgām šajā ierīcē. Ja lasāt to Thunderbird, importējiet atslēgu no turienes: Iestatījumi › Pilnīga šifrēšana.';

  @override
  String get openpgpExplainDamaged => 'Šis šifrētais ziņojums ir bojāts, tāpēc to nevar droši atšifrēt.';

  @override
  String get openpgpExplainUnsupported => 'Šajā ziņojumā izmantota šifrēšana, ko Loupe vēl nevar nolasīt.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Šis ziņojums ir šifrēts ar S/MIME, bet ne kādam no sertifikātiem šajā ierīcē. Importējiet savu sertifikātu (.p12 vai .pfx failu) sadaļā Iestatījumi › Pilnīga šifrēšana.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Šis ziņojums ir šifrēts. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Atbloķējiet savu S/MIME sertifikātu, lai to izlasītu.';

  @override
  String get openpgpAttachmentGone => 'Šis pielikums vairs nav pieejams.';

  @override
  String get smimeEncrypted => 'Šifrēts (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifrēts (S/MIME) · nav sertifikāta';

  @override
  String get smimeEncryptedDamaged => 'Šifrēts (S/MIME) · bojāts';

  @override
  String get smimeEncryptedUnsupported => 'Šifrēts (S/MIME) · neatbalstīts';

  @override
  String get smimeEncryptedLocked => 'Šifrēts (S/MIME) · bloķēts';

  @override
  String get smimeUnknownSigner => 'nezināms';

  @override
  String get smimeSignatureModified => 'Nederīgs paraksts: ziņojums ir mainīts';

  @override
  String get smimeSignatureWeak => 'Nedrošs paraksts: novecojis algoritms';

  @override
  String get smimeSignatureUncheckable => 'Parakstu nevar pārbaudīt';

  @override
  String get smimeSignedCertificateMissing => 'Parakstīts · trūkst sertifikāta';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Parakstījis $name · sertifikāts atsaukts';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Parakstījis $name · citā datumā';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Parakstījis $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Parakstījis $name · nederīgs sertifikāts';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Parakstījis $name · nav uzticams';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Parakstījis $name · sertifikāta derīgums beidzies';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Parakstījis $name · sertifikāts vēl nav derīgs';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Parakstījis $name · sertifikāts nav paredzēts pastam';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Parakstījis $name, nevis sūtītājs';
  }

  @override
  String get smimeCantDecrypt => 'Nevar atšifrēt šo ziņojumu';

  @override
  String get smimeEncryptedWithSmime => 'Šifrēts ar S/MIME';

  @override
  String get smimeEncryption => 'Šifrēšana';

  @override
  String get smimeDecryptedHere => 'Atšifrēts šajā ierīcē';

  @override
  String get smimeNotDecrypted => 'Nav atšifrēts';

  @override
  String get smimeAuthenticated => 'autentificēts';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifikātiem',
      one: '$count sertifikātam',
      zero: '$count sertifikātiem',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Paraksts';

  @override
  String get smimeIssuedBy => 'Izdevējs';

  @override
  String get smimeValid => 'Derīgs';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 pirkstu nospiedums';

  @override
  String get smimeSigned => 'Parakstīts';

  @override
  String get smimeProblem => 'Problēma';

  @override
  String get smimeCheckingRevocation => 'Pārbauda atsaukšanu…';

  @override
  String get smimeNotRevoked => 'Nav atsaukts';

  @override
  String get smimeRevoked => 'Atsaukts';

  @override
  String get smimeRevocationUnknown => 'Atsaukšanas statuss nav zināms';

  @override
  String smimeRevokedSince(String date) {
    return 'Kopš $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Vaicāts sertifikātu iestādei (atsaukšanas saraksts), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Vaicāts sertifikātu iestādei (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Uzticēties „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Uzticēties šim sertifikātam…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Pārbaudīts šajā ierīcē ar S/MIME, saderīgs ar Outlook un Thunderbird; atsaukšana pārbaudīta sertifikātu iestādē.';

  @override
  String get smimeCheckedFooter =>
      'Pārbaudīts šajā ierīcē ar S/MIME, saderīgs ar Outlook un Thunderbird. Atsaukšana netiek pārbaudīta (Iestatījumi › Pilnīga šifrēšana).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vai uzticēties $name attiecībā uz pastu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vai uzticēties $name sertifikātam?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Katrs šīs iestādes izdotais sertifikāts tiks uzskatīts par uzticamu, tāpat kā jūsu uzņēmuma sertifikātu iestādes izdotie. Vispirms salīdziniet pirkstu nospiedumu ar tā īpašnieku:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Vispirms salīdziniet pirkstu nospiedumu ar tā īpašnieku:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Uzticēties';

  @override
  String get smimeSummaryNoKey => 'Tas tika šifrēts sertifikātam, kura šajā ierīcē nav.';

  @override
  String get smimeSummaryDamaged => 'Šifrētie dati ir bojāti vai tika mainīti ceļā.';

  @override
  String get smimeSummaryUnsupported => 'Tajā izmantots algoritms, ko Loupe neatbalsta.';

  @override
  String get smimeSummaryLocked => 'Jūsu S/MIME sertifikāts ir bloķēts.';

  @override
  String get smimeSummaryEncrypted => 'To var lasīt tikai jūs un pārējie adresāti.';

  @override
  String get smimeSummaryNotSigned => 'Tas nav parakstīts, tāpēc sūtītājs nav apstiprināts.';

  @override
  String get smimeSummaryModified => 'Paraksts neatbilst: ziņojums tika mainīts pēc parakstīšanas.';

  @override
  String get smimeSummaryUncheckable => 'Parakstu nevar pārbaudīt.';

  @override
  String get smimeSummaryNoCertificate => 'Parakstītāja sertifikāta ziņojumā nav, tāpēc to nevar pārbaudīt.';

  @override
  String get smimeSummaryRevoked => 'Sertifikātu iestāde atsauca parakstītāja sertifikātu: parakstam nevar uzticēties.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Sertifikātu iestāde atsauca parakstītāja sertifikātu ($reason): parakstam nevar uzticēties.';
  }

  @override
  String get smimeDateMismatch =>
      'Tas tika parakstīts vairāk nekā stundu pirms vai pēc ziņojuma datuma: tas var būt vecs ziņojums, kas nosūtīts vēlreiz.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Paraksts ir derīgs, un $issuer apliecina, ka sertifikāts pieder sūtītājam.';
  }

  @override
  String get smimeProblemInvalidChain => 'Sertifikāts vai kāds no tā izdevējiem ir nederīgs.';

  @override
  String get smimeProblemUntrusted => 'Sertifikātu izdevusi iestāde, kurai Loupe neuzticas.';

  @override
  String get smimeProblemExpired => 'Sertifikāta derīgums bija beidzies.';

  @override
  String get smimeProblemNotYetValid => 'Sertifikāts vēl nebija derīgs.';

  @override
  String get smimeProblemWrongUsage => 'Sertifikāts nav paredzēts pastam.';

  @override
  String get smimeProblemWrongAddress => 'Sertifikāts pieder citai adresei, nevis sūtītājam.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Uzticams · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nav uzticams · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Beidzies $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Derīgs no $date';
  }

  @override
  String get smimeTrustInvalid => 'Nederīgs';

  @override
  String get smimeTrustNotForMail => 'Nav paredzēts pastam';

  @override
  String get smimeTrustAnotherAddress => 'Cita adrese';

  @override
  String get smimeMyCertificates => 'Mani S/MIME sertifikāti';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME, ko izmanto Outlook un daudzi uzņēmumi. Importējiet savu sertifikātu ar tā privāto atslēgu (.p12 vai .pfx failu), kas eksportēts no Outlook, Windows, macOS vai Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME, ko izmanto Outlook un daudzi uzņēmumi. Importējiet savu sertifikātu ar tā privāto atslēgu (.p12 vai .pfx failu), kas eksportēts no Outlook, Windows, macOS vai Thunderbird, vai izmantojiet sertifikātu, ko šajā ierīcē instalējāt jūs vai jūsu uzņēmums.';

  @override
  String get smimeCertificateExpired => 'beidzies';

  @override
  String smimeCertificateUntil(String date) {
    return 'līdz $date';
  }

  @override
  String get smimeCertificateOnDevice => 'šajā ierīcē';

  @override
  String get smimeImportCertificateEllipsis => 'Importēt sertifikātu…';

  @override
  String get smimeUseDeviceCertificate => 'Izmantot sertifikātu no šīs ierīces…';

  @override
  String get smimeCorrespondentsCertificates => 'Sarakstes partneru sertifikāti';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Savākti no parakstītiem ziņojumiem, kā to dara Outlook un Thunderbird. Pasts tiek šifrēts tikai uzticamiem sertifikātiem: Loupe uzticas iestādēm, kurām e-pasta jomā uzticas Mozilla, un tām, ko pievienojat jūs.';

  @override
  String get smimeRevocation => 'Atsaukšana';

  @override
  String get smimeRevocationFooter =>
      'Kad atverat parakstītu ziņojumu, Loupe vaicā iestādei, kas izdevusi parakstītāja sertifikātu (tās OCSP serverim vai atsaukšanas sarakstam), vai tas ir atsaukts. Tādējādi iestāde var redzēt, kad kāds no jūsu interneta adreses lasa ar šo sertifikātu parakstītu pastu. Atbildes tiek glabātas šajā ierīcē līdz to derīguma beigām. Atsaukts sertifikāts ziņojuma galvenē tiek parādīts kā „sertifikāts atsaukts“.';

  @override
  String get smimeCheckRevocation => 'Pārbaudīt sertifikātu atsaukšanu tiešsaistē';

  @override
  String get smimeTrustedAuthorities => 'Uzticamās iestādes';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jūsu uzticētās iestādes papildus $count iestādēm, kurām e-pasta jomā uzticas Mozilla.',
      one: 'Jūsu uzticētās iestādes papildus $count iestādei, kurai e-pasta jomā uzticas Mozilla.',
      zero: 'Jūsu uzticētās iestādes papildus $count iestādēm, kurām e-pasta jomā uzticas Mozilla.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Sertifikātu iestāde';

  @override
  String get smimeImportACertificate => 'Importēt sertifikātu';

  @override
  String get smimeImportContactMessage =>
      'Sarakstes partnera sertifikāts (.cer, .crt, .pem) vai sertifikātu iestādes sertifikāts.';

  @override
  String get smimeFromClipboard => 'No starpliktuves';

  @override
  String get smimeFromFile => 'No faila';

  @override
  String get smimeClipboardEmpty => 'Starpliktuve ir tukša. Vispirms nokopējiet sertifikātu.';

  @override
  String get smimeCertificate => 'Sertifikāts';

  @override
  String get smimeOnDeviceFooter =>
      'Tā privātā atslēga paliek Android akreditācijas datu krātuvē, kur to instalējāt jūs vai jūsu uzņēmums: Loupe lūdz Android ar to parakstīt un atšifrēt. Parakstītais pasts tiek parakstīts sūtīšanas brīdī.';

  @override
  String get smimeAddresses => 'Adreses';

  @override
  String get smimeUsage => 'Paredzēts';

  @override
  String get smimeUsageNone => 'Nekam, ko izmanto Loupe';

  @override
  String get smimeUsageSigning => 'Parakstīšanai';

  @override
  String get smimeUsageEncryption => 'Šifrēšanai';

  @override
  String get smimeUsageCertificates => 'Sertifikātiem';

  @override
  String get smimeAlgorithm => 'Algoritms';

  @override
  String get smimeSerialNumber => 'Sērijas numurs';

  @override
  String get smimeFingerprintCopied => 'Pirkstu nospiedums nokopēts.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 nospiedums';

  @override
  String get smimePrivateKey => 'Privātā atslēga';

  @override
  String get smimeKeyOnDevice => 'Šajā ierīcē';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupe, ar paroles frāzi';

  @override
  String get smimeKeyInLoupe => 'Loupe';

  @override
  String get smimeSource => 'Avots';

  @override
  String get smimeSourceSignedMail => 'Parakstīts ziņojums';

  @override
  String get smimeSourceImported => 'Importēts';

  @override
  String get smimeTrustHeader => 'Uzticamība';

  @override
  String get smimeTrustedRoot => 'Uzticama sakne';

  @override
  String get smimeIssuer => 'Izdevējs';

  @override
  String smimeTrustNamed(String name) {
    return 'Uzticēties „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Uzticēties šai iestādei';

  @override
  String get smimeTrustThisCertificate => 'Uzticēties šim sertifikātam';

  @override
  String get smimeStopTrusting => 'Pārtraukt uzticēties';

  @override
  String get smimePassphrase => 'Paroles frāze';

  @override
  String get smimePassphraseFooter =>
      'Neobligāti. Ar paroles frāzi privātā atslēga šajā ierīcē tiek papildus šifrēta (Argon2id un AES-256), un Loupe to prasa, lai parakstītu un atšifrētu; cik ilgi, nosaka iestatījums „Atcerēties paroles frāzes“. Jūsu sūtītais pasts tiek parakstīts sūtīšanas brīdī; fona darbi atslēgu izmantot nevar.';

  @override
  String get smimeChangePassphrase => 'Mainīt paroles frāzi…';

  @override
  String get smimeSetPassphraseEllipsis => 'Iestatīt paroles frāzi…';

  @override
  String get smimeRemovePassphrase => 'Noņemt paroles frāzi';

  @override
  String get smimeShareCertificate => 'Kopīgot sertifikātu';

  @override
  String get smimeDeleteCertificate => 'Dzēst sertifikātu';

  @override
  String get smimeRemoveCertificate => 'Noņemt sertifikātu';

  @override
  String get smimePassphraseChanged => 'Paroles frāze nomainīta.';

  @override
  String get smimePassphraseSet => 'Paroles frāze iestatīta.';

  @override
  String get smimeRemovePassphraseTitle => 'Vai noņemt paroles frāzi?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Tad privāto atslēgu aizsargās tikai atslēgu krātuve, kā bez paroles frāzes: Loupe to vairs neprasīs, un to varēs izmantot fona darbi.';

  @override
  String get smimePassphraseRemoved => 'Paroles frāze noņemta.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vai uzticēties $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Katrs tās izdotais sertifikāts tiks uzskatīts par uzticamu pastam. Vispirms salīdziniet pirkstu nospiedumu ar tā īpašnieku:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Vai dzēst savu sertifikātu $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Vai noņemt $name sertifikātu?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe pārtrauks to izmantot: tam šifrēto pastu Loupe vairs nevarēs izlasīt. Sertifikāts paliks šajā ierīcē (Iestatījumi › Drošība › Šifrēšana un akreditācijas dati).';

  @override
  String get smimeDeleteOwnMessage =>
      'Tā privātā atslēga tiks izdzēsta no šīs ierīces: tam šifrēto pastu šeit vairs nevarēs izlasīt, ja vien to neimportēsiet vēlreiz.';

  @override
  String get smimeRemoveContactMessage => 'Tas atgriezīsies ar nākamo šī sūtītāja parakstīto ziņojumu.';

  @override
  String get smimeAddressImportFooter =>
      'Importējiet sertifikātu šai adresei, lai parakstītu un šifrētu ar S/MIME, kā to dara Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importēt sertifikātu…';

  @override
  String get smimePreferFooter =>
      'Ja ziņojumu varētu aizsargāt abi, tiek izmantots vēlamais, ja vien tikai otram nav atslēgas vai sertifikāta katram adresātam.';

  @override
  String get smimePreferSmime => 'Dot priekšroku S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Nevis OpenPGP';

  @override
  String get smimeCertificatePassword => 'Sertifikāta parole';

  @override
  String get smimeCertificatePasswordPrompt => 'Ievadiet paroli, ar kuru sertifikāta fails tika eksportēts.';

  @override
  String get smimeImport => 'Importēt';

  @override
  String get smimeWrongPassword => 'Parole ir nepareiza. Mēģiniet vēlreiz.';

  @override
  String get smimeNoCertificateFound => 'Sertifikāts nav atrasts.';

  @override
  String smimeCertificateOf(String name) {
    return '$name sertifikāts';
  }

  @override
  String get smimeNothingNew => 'Nav nekā jauna, ko importēt.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importēts: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importētas $count uzticamas iestādes.',
      one: 'Importēta $count uzticama iestāde.',
      zero: 'Importētas $count uzticamas iestādes.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importēts: $certificates un $count uzticamas iestādes.',
      one: 'Importēts: $certificates un $count uzticama iestāde.',
      zero: 'Importēts: $certificates un $count uzticamas iestādes.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Šajā failā nav privātās atslēgas. Eksportējiet savu sertifikātu kopā ar privāto atslēgu.';

  @override
  String get smimeImportAsYoursTitle => 'Vai importēt kā savu sertifikātu?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Šajā pielikumā ir sertifikāts ar privāto atslēgu: $names. Importējiet to tikai tad, ja paši to eksportējāt, piemēram, no Outlook vai Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importēt kā manu sertifikātu';

  @override
  String smimeImportedOwn(String names) {
    return 'Importēts jūsu sertifikāts $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'No šīs ierīces pievienots jūsu sertifikāts $name ($addresses).';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vai uzticēties „$name“ attiecībā uz pastu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe nepazīst šo sertifikātu iestādi (iespējams, tā ir kāda uzņēmuma iekšējā iestāde). Uzticieties tai, lai varētu pārbaudīt tās izdotos sertifikātus. Vispirms salīdziniet tās pirkstu nospiedumu ar savu IT nodaļu:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pielikumā ir $count sertifikāti.',
      one: 'Pielikumā ir $count sertifikāts.',
      zero: 'Pielikumā ir $count sertifikātu.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importēt sertifikātu';

  @override
  String get smimeUnlockTitle => 'Atbloķēt S/MIME sertifikātu';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Ievadiet sertifikāta $name ($addresses) paroles frāzi.';
  }

  @override
  String get smimeWrongPassphrase => 'Paroles frāze ir nepareiza. Mēģiniet vēlreiz.';

  @override
  String get smimeUnlock => 'Atbloķēt';

  @override
  String get smimeEnterAPassphrase => 'Ievadiet paroles frāzi.';

  @override
  String get smimePassphrasesDiffer => 'Abas paroles frāzes atšķiras.';

  @override
  String get smimeSetPassphraseTitle => 'Iestatīt paroles frāzi';

  @override
  String get smimeSetPassphraseText =>
      'Loupe to prasīs, lai parakstītu un atšifrētu. Ja to aizmirsīsiet, importējiet sertifikātu vēlreiz no tā .p12 faila.';

  @override
  String get smimePassphraseAgain => 'Vēlreiz';

  @override
  String get smimeSetPassphraseButton => 'Iestatīt';

  @override
  String get smimeLockedOpenAgain => 'Jūsu S/MIME sertifikāts ir bloķēts. Atveriet ziņojumu vēlreiz, lai to atbloķētu.';

  @override
  String get smimeDeviceHasNoCertificates => 'Šī ierīce nepiedāvā savus sertifikātus.';

  @override
  String get smimeCantReadCertificate => 'Loupe nevar nolasīt šo sertifikātu.';

  @override
  String get smimeCertificateNotForMail =>
      'Šis sertifikāts nav paredzēts pastam: tam nav e-pasta adreses, vai tas nav paredzēts parakstīšanai vai šifrēšanai.';

  @override
  String get smimeDeviceCertificateGone =>
      'Sertifikāta vairs nav šajā ierīcē, vai Loupe to vairs nedrīkst izmantot. Izvēlieties to vēlreiz sadaļā Iestatījumi › Pilnīga šifrēšana.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Šajā ierīcē esošo sertifikātu var izmantot tikai tad, kad Loupe ir atvērta.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifrētā atslēga ir bojāta.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Šajā ierīcē esošais sertifikāts to nevar izdarīt: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'netiek atbalstīts';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Šajā ierīcē esošā sertifikāta kļūda: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Iestādes adrese nav tīmekļa adrese.';

  @override
  String get smimeAuthorityTimeout => 'Sertifikātu iestāde laikus neatbildēja.';

  @override
  String get smimeAuthorityUnreachable => 'Ar sertifikātu iestādi neizdevās sazināties.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Sertifikātu iestāde atbildēja ar $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Sertifikātu iestādes atbilde ir pārāk liela.';

  @override
  String get smimeRevocationNotChecked =>
      'Nav pārbaudīts: tiek pārbaudīti tikai sertifikāti no iestādēm, kurām Loupe uzticas.';

  @override
  String get settingsLanguage => 'Valoda';

  @override
  String get settingsLanguageSystem => 'Tāda pati kā tālrunī';

  @override
  String get settingsLanguageFooter =>
      'Loupe izmanto jūsu tālruņa valodu, ja tā ir pieejama, un angļu valodu, ja nav. Šeit izvēlētā valoda attiecas tikai uz Loupe, arī uz paziņojumiem.';

  @override
  String get settingsAccountsHeader => 'Konti';

  @override
  String get settingsAddAccount => 'Pievienot kontu';

  @override
  String get settingsMailHeader => 'Pasts';

  @override
  String get settingsSwipeActions => 'Pavilkšanas darbības';

  @override
  String get settingsSwipeLeft => 'Pavilkt pa kreisi';

  @override
  String get settingsSwipeLeftFooter =>
      'Pilns pavilciens izpilda šo darbību. „Atzīmēt ar karodziņu“ un „Vairāk“ vienmēr ir pieejami ar īsu pavilcienu.';

  @override
  String get settingsSwipeRight => 'Pavilkt pa labi';

  @override
  String get settingsSwipeRightFooter => 'Pilns pavilciens izpilda šo darbību.';

  @override
  String get settingsSwipeToggleRead => 'Atzīmēt kā lasītu / nelasītu';

  @override
  String get settingsSwipeTrash => 'Uz miskasti';

  @override
  String get settingsSwipeMove => 'Pārvietot ziņojumu';

  @override
  String get settingsSwipeSnooze => 'Atlikt';

  @override
  String get settingsThreaded => 'Kārtot pēc sarunām';

  @override
  String get settingsUndoSendDelay => 'Sūtīšanas atsaukšanas aizture';

  @override
  String get settingsUndoSendDelayFooter => 'Nosūtītie ziņojumi gaida tik ilgi, lai jūs varētu tos atsaukt.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekundes',
      one: '$seconds sekunde',
      zero: '$seconds sekunžu',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Izskats';

  @override
  String get settingsTheme => 'Motīvs';

  @override
  String get settingsThemeSystem => 'Automātiski';

  @override
  String get settingsThemeLight => 'Gaišs';

  @override
  String get settingsThemeDark => 'Tumšs';

  @override
  String get settingsDensity => 'Ziņojumu saraksts';

  @override
  String get settingsDensityComfortable => 'Ērts';

  @override
  String get settingsDensityCompact => 'Kompakts';

  @override
  String get settingsReadingHeader => 'Lasīšana';

  @override
  String get settingsReadingFooter => 'Attālie attēli var pavēstīt sūtītājiem, kad un kur atvērāt ziņojumu.';

  @override
  String get settingsDefaultView => 'Noklusējuma skats';

  @override
  String get settingsDefaultViewFooter => 'Jebkura ziņojuma skatu varat pārslēgt ar pogu Aa.';

  @override
  String get settingsViewReadable => 'Lasīšanai';

  @override
  String get settingsViewReadableDetail => 'Tīrs, salasāms, pielāgojas tumšajam režīmam';

  @override
  String get settingsViewOriginal => 'Oriģināls';

  @override
  String get settingsViewOriginalDetail => 'Tieši tā, kā to veidojis sūtītājs';

  @override
  String get settingsViewPlain => 'Vienkāršs teksts';

  @override
  String get settingsViewPlainDetail => 'Tikai vārdi';

  @override
  String get settingsPlainTextFont => 'Vienkārša teksta fonts';

  @override
  String get settingsFontSans => 'Bezserifu';

  @override
  String get settingsFontMono => 'Vienplatuma';

  @override
  String get settingsFontMonoDetail => 'Saglabā ASCII zīmējumu un tabulu līdzinājumu';

  @override
  String get settingsTechnicalLists => 'Tehniskie saraksti';

  @override
  String get settingsLoadRemoteImages => 'Ielādēt attālos attēlus';

  @override
  String get settingsOpenLinksDirectly => 'Atvērt saites tieši';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Izlaist klikšķu izsekotājus, ja galamērķis ir zināms';

  @override
  String get settingsSecurityHeader => 'Drošība';

  @override
  String get settingsAppLock => 'Lietotnes bloķēšana';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe prasa apstiprinājumu, kad tiek startēta un kad atgriežaties pēc prombūtnes, kas ilgāka par iestatījumā „Bloķēt pēc“ norādīto laiku.';

  @override
  String get settingsAppLockFooterOff =>
      'Lietotnes bloķēšana prasa pirksta nospiedumu, seju vai ekrāna bloķēšanu, pirms tiek parādīts jūsu pasts.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Lietotnes bloķēšana joprojām ir izslēgta. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Iestatiet piekļuves kodu';

  @override
  String get settingsScreenLockTextIos =>
      'Lietotnes bloķēšana izmanto Face ID, Touch ID vai jūsu piekļuves kodu, bet šim iPhone nav piekļuves koda. Iestatiet to lietotnē Iestatījumi un pēc tam ieslēdziet lietotnes bloķēšanu.';

  @override
  String get settingsScreenLockTitleAndroid => 'Iestatiet ekrāna bloķēšanu';

  @override
  String get settingsScreenLockTextAndroid =>
      'Lietotnes bloķēšana izmanto jūsu tālruņa ekrāna bloķēšanu vai tai pievienotu pirksta nospiedumu vai seju, bet šim tālrunim tādas nav. Iestatiet PIN, kombināciju vai paroli Android iestatījumos un pēc tam ieslēdziet lietotnes bloķēšanu.';

  @override
  String get settingsOpenSystemSettings => 'Atvērt iestatījumus';

  @override
  String get settingsOpenAndroidSettings => 'Atvērt Android iestatījumus';

  @override
  String get settingsLockAfter => 'Bloķēt pēc';

  @override
  String get settingsLockAfterFooter => 'Cik ilgi Loupe var būt fonā, pirms tā atkal prasa apstiprinājumu.';

  @override
  String get settingsNotifications => 'Paziņojumi';

  @override
  String get settingsEncryption => 'Pilnīga šifrēšana';

  @override
  String get settingsAdvanced => 'Papildu';

  @override
  String get settingsDemoHeader => 'Demonstrācija';

  @override
  String get settingsDemoFooter =>
      'Demonstrācijas pasts ir izdomāta pastkaste, kas atrodas tikai šajā tālrunī. Nekas netiek nekur nosūtīts.';

  @override
  String get settingsDemoMode => 'Demonstrācijas režīms';

  @override
  String get settingsResetApp => 'Atiestatīt lietotni';

  @override
  String get settingsResetFooter => 'Aizmirst visus iestatījumus un atgriežas sveiciena ekrānā.';

  @override
  String get settingsResetTitle => 'Vai atiestatīt Loupe?';

  @override
  String get settingsResetMessage =>
      'Tiks aizmirsti visi iestatījumi, Smart Mailboxes un nesenie meklējumi, un tiks atvērts sveiciena ekrāns.';

  @override
  String get settingsAboutHeader => 'Par lietotni';

  @override
  String get settingsVersion => 'Versija';

  @override
  String get settingsLicences => 'Licences';

  @override
  String get settingsPrivacy => 'Privātums';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nav analītikas un izsekošanas. Jūsu pasts nonāk tikai jūsu pasta serveros.';

  @override
  String get settingsNotificationsOffIos => 'Loupe paziņojumi ir izslēgti iestatījumos.';

  @override
  String get settingsNotificationsOffAndroid => 'Loupe paziņojumi ir izslēgti Android iestatījumos.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system neļauj Loupe rādīt paziņojumus. Atļaujiet tos iestatījumos.';
  }

  @override
  String get settingsNewMailHeader => 'Jauns pasts';

  @override
  String get settingsNewMailFooterDemo =>
      'Demonstrācijas pasts fonā nepienāk. Nosūtiet testa paziņojumu, lai redzētu, kā izskatās jauns pasts.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe pārbauda jaunu pastu fonā, kad iOS to atļauj; retāk atvērtām lietotnēm starp pārbaudēm var paiet vairākas stundas. Jums tiek paziņots par jauniem ziņojumiem iesūtnēs un par VIP ziņojumiem jebkurā mapē.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe pārbauda jaunu pastu aptuveni ik pēc 15 minūtēm, kad Android to atļauj. Jums tiek paziņots par jauniem ziņojumiem iesūtnēs un par VIP ziņojumiem jebkurā mapē.';

  @override
  String get settingsNoAccounts => 'Nav kontu';

  @override
  String get settingsVipOnly => 'Tikai VIP';

  @override
  String get settingsVipOnlyDetail => 'Tikai ziņojumi no jūsu VIP';

  @override
  String get settingsHideContent => 'Slēpt saturu';

  @override
  String get settingsHideContentFooterOn =>
      'Paziņojumos redzams tikai „Jauns ziņojums“ un konts, bet ne tas, kas rakstīja un par ko.';

  @override
  String get settingsHideContentFooterOff =>
      'Iestatījums „Slēpt saturu“ neļauj sūtītājam, tematam un priekšskatījumam parādīties bloķēšanas ekrānā un paziņojumos.';

  @override
  String get settingsBackgroundAppRefresh => 'Fona lietotņu atsvaidzināšana';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Jauns pasts fonā pienāk tikai tad, ja iestatījumos Loupe ir ieslēgta fona lietotņu atsvaidzināšana. iOS nevar uzturēt atvērtu savienojumu ar jūsu iesūtnēm, tāpēc tūlītējas piegādes nav.';

  @override
  String get settingsInstantDelivery => 'Tūlītēja piegāde';

  @override
  String get settingsInstantDeliveryFooter =>
      'Tūlītēja piegāde (eksperimentāla) uztur atvērtu savienojumu ar jūsu iesūtnēm, tāpēc jauns pasts pienāk dažu sekunžu laikā. Tā rāda klusu paziņojumu „Gaida jaunu pastu“ un patērē vairāk akumulatora.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android var apturēt tūlītējo piegādi, lai taupītu akumulatoru. Ļaujiet Loupe izmantot akumulatoru bez ierobežojumiem, lai tā turpinātu darboties.';

  @override
  String get settingsExperimental => 'Eksperimentāls';

  @override
  String get settingsComingSoon => 'Drīzumā';

  @override
  String get settingsAllowUnrestrictedBattery => 'Atļaut neierobežotu akumulatora lietojumu';

  @override
  String get settingsPush => 'Push paziņojumi';

  @override
  String get settingsPushFooter =>
      'Push paziņojumi ļauj jaunam pastam uzreiz pamodināt Loupe, ja jūsu pasta pakalpojums to atbalsta. Tie tiek sūtīti caur Google push pakalpojumu, un tajos nav pasta, tikai „pārbaudi tagad“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Šis tālrunis nevar saņemt push paziņojumus: tiem nepieciešami Google Play pakalpojumi un tīkla savienojums. Loupe joprojām pārbauda pastu aptuveni ik pēc 15 minūtēm.';

  @override
  String get settingsCopyPushToken => 'Kopēt push marķieri';

  @override
  String get settingsPushTokenCopied => 'Push marķieris nokopēts';

  @override
  String get settingsSendTestNotification => 'Sūtīt testa paziņojumu';

  @override
  String get settingsAppIconBadge => 'Lietotnes ikonas emblēma';

  @override
  String get settingsBadgeNote => 'Emblēma tiek atjaunināta ikreiz, kad Loupe pārbauda pastu, arī fonā.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Šī tālruņa sākuma ekrāns nerāda skaitļus uz lietotņu ikonām. Emblēma tiek atjaunināta ikreiz, kad Loupe pārbauda pastu, arī fonā.';

  @override
  String get settingsTestNotificationBody => 'Jauna pasta paziņojumi izskatās šādi.';

  @override
  String get settingsAccountRemoved => 'Šis konts tika noņemts.';

  @override
  String get settingsAccountHeader => 'Konts';

  @override
  String get settingsAccountDescription => 'Apraksts';

  @override
  String get settingsAccountDescriptionHint => 'Darbs, personīgais…';

  @override
  String get settingsEmail => 'E-pasts';

  @override
  String get settingsColour => 'Krāsa';

  @override
  String get settingsColourFooter => 'Iezīmē šī konta ziņojumus skatā „Visas iesūtnes“.';

  @override
  String settingsColourNumber(int number) {
    return 'Krāsa $number';
  }

  @override
  String get settingsSendingHeader => 'Sūtīšana';

  @override
  String get settingsSendingFooter =>
      'Katrai identitātei ir savs paraksts. Atbildes tiek sūtītas no adreses, uz kuru ziņojums tika nosūtīts.';

  @override
  String get settingsFoldersHeader => 'Mapes';

  @override
  String get settingsFoldersFooter =>
      'Loupe rāda un sinhronizē mapes, kuras abonējat, tāpat kā Thunderbird. Iesūtne, Melnraksti, Nosūtītie, Mēstules, Miskaste un Arhīvs tiek rādīti vienmēr.';

  @override
  String get settingsShowAllFolders => 'Rādīt visas mapes';

  @override
  String get settingsIncoming => 'Ienākošais';

  @override
  String get settingsOutgoing => 'Izejošais';

  @override
  String get settingsConnectionNotEncrypted => 'Nav šifrēts';

  @override
  String get settingsSignIn => 'Pierakstīšanās';

  @override
  String get settingsSignInExpired => 'Beigusies';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider vairs nepieņem Loupe pierakstīšanos šim kontam, tāpēc tā pasts netiek sinhronizēts. Pierakstieties vēlreiz, lai to novērstu.';
  }

  @override
  String get settingsSignInAgain => 'Pierakstīties vēlreiz';

  @override
  String get settingsSigningIn => 'Pierakstās…';

  @override
  String get settingsRemoveAccount => 'Noņemt kontu';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Vai noņemt „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Tā pasts un iestatījumi tiks noņemti no šī tālruņa. Serverī nekas netiks dzēsts.';

  @override
  String get settingsManageFolders => 'Pārvaldīt mapes';

  @override
  String get settingsNoFolders => 'Vēl nav mapju.';

  @override
  String get settingsManageFoldersFooter =>
      'Abonētās mapes tiek rādītas ekrānā „Pastkastes“ un sinhronizētas fonā. Citas pasta lietotnes, kas izmanto to pašu kontu, parasti arī ievēro šos abonementus.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Glabā jūsu Smart Mailboxes citām jūsu ierīcēm. Ekrānā „Pastkastes“ paslēpta.';

  @override
  String get settingsFolderAlwaysShown => 'Vienmēr rādīta';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abonēt $folder';
  }

  @override
  String get settingsIdentities => 'Identitātes';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Pirmā identitāte ir noklusējuma identitāte jauniem ziņojumiem. Velciet, lai mainītu secību.';

  @override
  String get settingsIdentitiesFooterSingle => 'Noklusējuma identitāte jauniem ziņojumiem.';

  @override
  String get settingsIdentitiesReplyFooter => 'Atbilde tiek sūtīta no identitātes, uz kuru ziņojums tika nosūtīts.';

  @override
  String get settingsIdentityDefault => 'Noklusējuma';

  @override
  String settingsIdentityReorder(String email) {
    return 'Pārkārtot $email';
  }

  @override
  String get settingsAddIdentity => 'Pievienot identitāti';

  @override
  String get settingsNewIdentity => 'Jauna identitāte';

  @override
  String get settingsIdentity => 'Identitāte';

  @override
  String get settingsIdentityNameHint => 'Jūsu vārds';

  @override
  String get settingsReplyTo => 'Atbildēt uz';

  @override
  String get settingsSignature => 'Paraksts';

  @override
  String get settingsSignatureFooter => 'Tiek pievienots zem „-- “ šīs identitātes ziņojumos.';

  @override
  String get settingsNoSignature => 'Nav paraksta';

  @override
  String get settingsCopyToMyself => 'Kopija sev';

  @override
  String get settingsCopyToMyselfFooter => 'Tiek pievienots katram šīs identitātes ziņojumam.';

  @override
  String get settingsCc => 'Kopija';

  @override
  String get settingsBcc => 'Diskrētā kopija';

  @override
  String get settingsReplyPatterns => 'Izmantot atbildēm uz';

  @override
  String get settingsReplyPatternsFooter =>
      'Atbildes uz ziņojumiem, kas nosūtīti uz šīm adresēm, tiek sūtītas no šīs identitātes. * nozīmē jebko: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adrese vai paraugs, kurā * nozīmē jebko.';

  @override
  String get settingsAddReplyPattern => 'Pievienot adresi vai paraugu';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Noņemt $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Nederīgs paraugs';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ nav adrese vai paraugs, piemēram, *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nav adreses';

  @override
  String get settingsIdentityNoAddressMessage => 'Ievadiet e-pasta adresi, no kuras sūtīt.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Nederīga adrese';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Adrese „Atbildēt uz“ („$address“) nav derīga e-pasta adrese.',
      'cc': 'Kopijas adrese „$address“ nav derīga e-pasta adrese.',
      'bcc': 'Diskrētās kopijas adrese „$address“ nav derīga e-pasta adrese.',
      'other': '„$address“ nav derīga e-pasta adrese.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Saglabāt identitāti';

  @override
  String get settingsDiscardChanges => 'Atmest izmaiņas';

  @override
  String get settingsDeleteIdentity => 'Dzēst identitāti';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Vai dzēst „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'No tās jau nosūtītie ziņojumi paliks nemainīti.';

  @override
  String get settingsLastIdentityFooter => 'Kontam nepieciešama vismaz viena identitāte.';

  @override
  String get rulesTitle => 'Kārtulas';

  @override
  String get rulesNewRule => 'Jauna kārtula';

  @override
  String get rulesLoadError => 'Neizdevās ielādēt kārtulas.';

  @override
  String get rulesEmptyTitle => 'Nav kārtulu';

  @override
  String get rulesEmptyText =>
      'Kārtulas jūsu vietā šķiro jaunu pastu, pievieno tam birkas un karodziņus. Izveidojiet kārtulu ar rakstīšanas pogu augšā vai no meklēšanas ar „Pārvērst par kārtulu“.';

  @override
  String get rulesListFooter =>
      'Kārtulas tiek izpildītas no augšas uz leju jaunam pastam iesūtnē. Pieskarieties kārtulai un turiet, lai to pārvietotu.';

  @override
  String get rulesChangeError => 'Neizdevās mainīt kārtulu';

  @override
  String get rulesConditionEveryMessage => 'Katrs ziņojums';

  @override
  String rulesMoveRule(String rule) {
    return 'Pārvietot $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule ieslēgta';
  }

  @override
  String get rulesServerRulesHeader => 'Servera kārtulas';

  @override
  String get rulesServerRulesFooter =>
      'Servera kārtulas darbojas pasta serverī, kad pienāk pasts, arī tad, kad šis tālrunis ir izslēgts. Tās glabājas Sieve skriptā ar nosaukumu „loupe“.';

  @override
  String get rulesStatusUnknown => 'Nezināms';

  @override
  String get rulesStatusError => 'Neizdevās vaicāt serverim.';

  @override
  String get rulesStatusChecking => 'Pārbauda…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Izpilda no „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script“ ir aktīvais skripts. Pieskarieties, lai tas izpildītu arī Loupe kārtulas.';
  }

  @override
  String get rulesStatusNoScript =>
      'Serverī nav aktīva skripta. Saglabājot servera kārtulu, tiks ieslēgts Loupe skripts.';

  @override
  String get rulesStatusUnavailable => 'Nav pieejams';

  @override
  String get rulesStatusNoSieve => 'Šī konta serveris nepiedāvā Sieve (ManageSieve vai JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Pārvietot uz $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Pārvietot uz mapi';

  @override
  String rulesActionTag(String tag) {
    return 'Pievienot birku $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Noņemt birku $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Paturēt iesūtnē';

  @override
  String rulesActionForward(String address) {
    return 'Pārsūtīt uz $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Pārsūtīt uz $address, nesaglabājot kopiju';
  }

  @override
  String get rulesActionStop => 'Apturēt';

  @override
  String get rulesNoActions => 'Pagaidām neko nedara';

  @override
  String get rulesLocationDevice => 'Ierīce';

  @override
  String get rulesLocationServer => 'Serveris';

  @override
  String get rulesLocationThisDevice => 'Šī ierīce';

  @override
  String get rulesNewRuleTitle => 'Jauna kārtula';

  @override
  String get rulesEditRuleTitle => 'Rediģēt kārtulu';

  @override
  String get rulesDefaultNameEveryMessage => 'Katrs ziņojums';

  @override
  String get rulesConditionHeader => 'Ja jauns ziņojums atbilst';

  @override
  String get rulesConditionFooter =>
      'Rakstiet tāpat kā meklējot: from:, to:, s: (temats), b: (teksts), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:rēķins';

  @override
  String get rulesAccounts => 'Konti';

  @override
  String get rulesAllAccounts => 'Visi konti';

  @override
  String get rulesRemovedAccount => 'Noņemts konts';

  @override
  String get rulesAccountsFooter => 'Kārtula visiem kontiem attiecas arī uz kontiem, ko pievienosiet vēlāk.';

  @override
  String get rulesActionsHeader => 'Tad';

  @override
  String get rulesForwardingFooter =>
      'Pārsūtīšana nosūta katru atbilstošo ziņojumu uz citu adresi, tiklīdz tas pienāk, arī tad, kad šis tālrunis ir izslēgts. Daži pakalpojumu sniedzēji ierobežo, cik daudz pasta drīkst pārsūtīt.';

  @override
  String get rulesForwardingHiddenFooter => 'Pārsūtīšana darbojas tikai servera kārtulās, tāpēc šeit tā nav iekļauta.';

  @override
  String rulesRemoveAction(String action) {
    return 'Noņemt: $action';
  }

  @override
  String get rulesAddAction => 'Pievienot darbību';

  @override
  String get rulesAddMove => 'Pārvietot uz mapi…';

  @override
  String get rulesAddTagMenu => 'Pievienot birku…';

  @override
  String get rulesRemoveTagMenu => 'Noņemt birku…';

  @override
  String get rulesAddForward => 'Pārsūtīt uz…';

  @override
  String get rulesStopProcessing => 'Pārtraukt citu kārtulu apstrādi';

  @override
  String get rulesRunOnHeader => 'Izpildīt';

  @override
  String get rulesRunOnDeviceFooter =>
      'Šī ierīce izpilda kārtulu jaunam iesūtnes pastam ikreiz, kad Loupe pārbauda pastu.';

  @override
  String get rulesRunOnServerFooter =>
      'Pasta serveris izpilda kārtulu, kad pasts pienāk, arī tad, kad šis tālrunis ir izslēgts. Nepieciešams Sieve, izmantojot ManageSieve (Dovecot, mailcow) vai JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Lietot esošajiem ziņojumiem…';

  @override
  String get rulesDeleteRule => 'Dzēst kārtulu';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Vai dzēst „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Kura konta mapē?';

  @override
  String get rulesMoveAccountMessage => 'Pārējo kontu pasts nonāk tur esošajā mapē ar tādu pašu nosaukumu.';

  @override
  String get rulesAddTag => 'Pievienot birku';

  @override
  String get rulesRemoveTag => 'Noņemt birku';

  @override
  String get rulesForwardTo => 'Pārsūtīt uz';

  @override
  String get rulesForwardToMessage =>
      'Serveris pārsūta katru atbilstošo ziņojumu uz šo adresi, arī tad, kad šis tālrunis ir izslēgts. Izmantojiet adresi, kas pieder jums vai kurai uzticaties.';

  @override
  String get rulesNotAnAddressTitle => 'Nav e-pasta adrese';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ nav adrese, uz kuru var pārsūtīt.';
  }

  @override
  String get rulesKeepCopyTitle => 'Vai paturēt kopiju šeit?';

  @override
  String get rulesKeepCopy => 'Paturēt kopiju';

  @override
  String get rulesDontKeepCopy => 'Nepaturēt kopiju';

  @override
  String get rulesCheckCondition => 'Pārbaudiet nosacījumu';

  @override
  String get rulesChooseActionTitle => 'Izvēlieties darbību';

  @override
  String get rulesChooseActionMessage => 'Pievienojiet, ko kārtula dara ar ziņojumiem, kas tai atbilst.';

  @override
  String get rulesSaveError => 'Neizdevās saglabāt kārtulu';

  @override
  String get rulesSaveServerError => 'Neizdevās saglabāt servera kārtulu';

  @override
  String get rulesRunOnDeviceInstead => 'Tā vietā izpildīt šajā ierīcē';

  @override
  String get rulesNothingToApplyTitle => 'Nav ko lietot';

  @override
  String get rulesNothingToApplyMessage => 'Vispirms norādiet kārtulai derīgu nosacījumu un darbību.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Lietot „$rule“ ziņojumiem…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Iesūtnēs';

  @override
  String get rulesApplyScopeAll => 'Visās pastkastēs';

  @override
  String get rulesFindingMessages => 'Meklē ziņojumus…';

  @override
  String get rulesSearchError => 'Neizdevās meklēt';

  @override
  String get rulesSearchErrorUnknown => 'Radās kļūda.';

  @override
  String get rulesNoMatchesTitle => 'Neviens ziņojums neatbilst';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Tur nekas neatbilst „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vai lietot „$rule“ $countString ziņojumiem?',
      one: 'Vai lietot „$rule“ $countString ziņojumam?',
      zero: 'Vai lietot „$rule“ $countString ziņojumiem?',
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
      other: 'Lietot $countString ziņojumiem',
      one: 'Lietot $countString ziņojumam',
      zero: 'Lietot $countString ziņojumiem',
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
      other: '„$rule“ lietota $countString ziņojumiem',
      one: '„$rule“ lietota $countString ziņojumam',
      zero: '„$rule“ lietota $countString ziņojumiem',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Vaicā serverim, ko tas prot…';

  @override
  String get rulesServerUnreachable => 'Neizdevās sazināties ar serveri.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nevar izpildīt serverī: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nevar izpildīt konta $account serverī: $problem';
  }

  @override
  String get rulesShowScript => 'Rādīt skriptu';

  @override
  String get rulesHideScript => 'Paslēpt skriptu';

  @override
  String get rulesMatchingHeader => 'Atbilstošie ziņojumi';

  @override
  String get rulesMatchingHeaderLoading => 'Atbilstošie ziņojumi…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString atbilstoši ziņojumi',
      one: '$countString atbilstošs ziņojums',
      zero: '$countString atbilstošu ziņojumu',
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
      other: '$countString+ atbilstoši ziņojumi',
      one: '$countString+ atbilstošs ziņojums',
      zero: '$countString+ atbilstošu ziņojumu',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'No pēdējām 30 dienām. Pati kārtula darbojas tikai ar jaunu pastu, ja vien to nelietojat esošajiem ziņojumiem.';

  @override
  String rulesConditionError(String error) {
    return 'Nosacījumā ir kļūda: $error';
  }

  @override
  String get rulesPreviewNoSender => '(nav sūtītāja)';

  @override
  String get rulesPreviewNoSubject => '(bez temata)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'un vēl $countString');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nekā no pēdējām 30 dienām.';

  @override
  String get rulesIncludeTitle => 'Ieslēgt servera kārtulas';

  @override
  String get rulesIncludeLeaveOff => 'Atstāt izslēgtas';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serveris jau izpilda Loupe kārtulas kontam $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ ir aktīvais skripts konta $account serverī, tāpēc serveris izpilda to, nevis Loupe kārtulas. Loupe to neaizstās. Tā var pievienot tam šīs rindas, un tad serveris pēc paša skripta kārtulām izpildīs arī Loupe kārtulas:';
  }

  @override
  String get rulesShowWholeScript => 'Rādīt visu skriptu';

  @override
  String get rulesHideWholeScript => 'Paslēpt visu skriptu';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nekas cits skriptā „$script“ nemainās. Ja vēlāk tā filtri tiks rediģēti tīmekļa pastā, tīmekļa pasts var to pārrakstīt bez šīm rindām; tad Loupe atkal rādīs servera kārtulas kā izslēgtas.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Pievienot skriptam „$script“';
  }

  @override
  String get subscriptionsTitle => 'Abonementi';

  @override
  String get subscriptionsNewsletters => 'Jaunumu vēstules';

  @override
  String get subscriptionsDiscussions => 'Diskusijas';

  @override
  String get subscriptionsFilter => 'Filtrēt';

  @override
  String get subscriptionsFilterNeverRead => 'Nekad nelasītas';

  @override
  String get subscriptionsFilterRarelyRead => 'Reti lasītas';

  @override
  String get subscriptionsFilterAll => 'Visas';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Neizdevās saskaitīt abonementus';

  @override
  String get subscriptionsNoMatches => 'Nav atbilstību';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nav jaunumu vēstules ar nosaukumu „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nav saraksta ar nosaukumu „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Nav jaunumu vēstuļu';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Jaunumu vēstules un cits masveida pasts šeit parādīsies, tiklīdz pienāks.';

  @override
  String get subscriptionsNothingNeverRead => 'Nav nekad nelasītu';

  @override
  String get subscriptionsNothingRarelyRead => 'Nav reti lasītu';

  @override
  String get subscriptionsNothingFilteredDetail => 'Jūs mazliet izlasāt no visa, ko saņemat.';

  @override
  String get subscriptionsNoDiscussions => 'Nav diskusiju';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'E-pasta saraksti, kuros varat rakstīt, šeit parādīsies, tiklīdz pienāks to pasts.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Saraksti, kuros raksta vairāki cilvēki. Pieskarieties sarakstam un turiet, lai to piespraustu pastkastēm, lasītu kā vienkāršu tekstu vai pārvietotu uz jaunumu vēstulēm.';

  @override
  String get subscriptionsPrivacyNote =>
      'Saskaitīts šajā tālrunī no lejupielādētā pasta; lai to aprēķinātu, nekas netiek nekur sūtīts. Loupe sazinās ar sūtītāju tikai tad, kad pieskaraties pogai „Atteikties“: atteikšanās ar vienu klikšķi nosūta tikai „List-Unsubscribe=One-Click“ uz sūtītāja norādīto adresi, bez sīkfailiem un bez jebkādas citas informācijas par jums, un nekad neielādē tā lapas vai attēlus.';

  @override
  String get subscriptionsVolumeNone => 'Pēdējā laikā nav';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 mēnesī';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count mēnesī';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'izlasīti $percent';
  }

  @override
  String get subscriptionsStillSending => 'Joprojām sūta';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Abonements atteikts $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Atteikšanās lapa atvērta $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Viens pieskāriens · sazinās ar $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Ar e-pastu uz $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Vietnē $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Atteikties';

  @override
  String get subscriptionsUnsubscribeAgain => 'Atteikties vēlreiz';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arhivēt $countString no iesūtnes');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Izveidot kārtulu…';

  @override
  String get subscriptionsCreateRuleDetail => 'Pārvietot vai arhivēt tā turpmāko pastu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Uzskatīt par diskusiju';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Saraksts, kurā raksta cilvēki: lasīt kā forumu';

  @override
  String get subscriptionsTreatAsNewsletter => 'Uzskatīt par jaunumu vēstuli';

  @override
  String get subscriptionsBlockSender => 'Bloķēt sūtītāju';

  @override
  String get subscriptionsBlock => 'Bloķēt';

  @override
  String get subscriptionsBlocked => 'Bloķēts';

  @override
  String get subscriptionsBlockedDetail => 'Jauns pasts nonāk mēstulēs';

  @override
  String get subscriptionsPin => 'Piespraust pastkastēm';

  @override
  String get subscriptionsUnpin => 'Atspraust no pastkastēm';

  @override
  String get subscriptionsOpenDefaultView => 'Atvērt noklusējuma skatā';

  @override
  String get subscriptionsOpenPlainText => 'Atvērt kā vienkāršu tekstu (Mono)';

  @override
  String get subscriptionsPinned => 'Piesprausts';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString nelasīti',
      one: '$countString nelasīts',
      zero: '$countString nelasītu',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Pašlaik nav pasta no šī sūtītāja.';

  @override
  String get subscriptionsLatestMessages => 'JAUNĀKIE ZIŅOJUMI';

  @override
  String get subscriptionsMail => 'Pasts';

  @override
  String get subscriptionsNoneIn90Days => 'Nav 90 dienās';

  @override
  String get subscriptionsRead => 'Izlasīts';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString no $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Pēdējoreiz saņemts';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Atrašanās vieta');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Joprojām sūta';

  @override
  String get subscriptionsUnsubscribedTitle => 'Abonements atteikts';

  @override
  String subscriptionsSince(String date) {
    return 'kopš $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'lapa atvērta $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nenorāda, kā atteikties no abonementa.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nenorāda, kā atteikties no abonementa. Tā vietā varat to bloķēt.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Atsakās no $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Abonements atteikts: $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Neizdevās atteikties: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Neizdevās atteikties automātiski';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Sūtīt atteikšanās e-pastu';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Atvērt $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Vai atvērt $site?';
  }

  @override
  String get subscriptionsOpen => 'Atvērt';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender abonementu var atteikt tā vietnē. Lapa tiks atvērta Loupe pārlūkā; pabeidziet tur.';
  }

  @override
  String get subscriptionsWebInsecure => 'Savienojums ar šo vietni nav šifrēts.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Uzmanību: šī adrese ar līdzīga izskata burtiem atdarina $site.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Uzmanību: šī adrese ar līdzīga izskata burtiem atdarina citu vietni.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Neizdevās atvērt $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe atzīmē šodienas datumu un paziņos, ja $sender turpinās rakstīt.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vai atteikties no $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe sazināsies ar $site, lai atteiktu abonementu.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Šī ir vienīgā reize, kad Loupe sazinās ar sūtītāja vietni. Tā nosūta tikai „List-Unsubscribe=One-Click“ uz adresi, ko norādījis $sender, bez sīkfailiem vai jebkādas citas informācijas par jums, un neielādē lapu.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Atteikšanās saite nav droša interneta adrese.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site laikus neatbildēja.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Neizdevās sazināties ar $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site pārsūtīja pieprasījumu uz citu lapu, kurai Loupe neseko.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site noraidīja pieprasījumu (kļūda $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nav konta, no kura nosūtīt atteikšanās e-pastu.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe nosūtīs e-pastu uz $to no $from ar tematu „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Atteikšanās e-pasts nosūtīts uz $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Vai bloķēt $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Jauns pasts no šī saraksta nonāks mēstulēs. To var mainīt sadaļā Iestatījumi › Kārtulas.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Jauns pasts no $address nonāks mēstulēs. To var mainīt sadaļā Iestatījumi › Kārtulas.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender bloķēts.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Pārvietot $count uz mēstulēm');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloķēt $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender tagad ir jaunumu vēstulēs.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender tagad ir diskusijās.';
  }

  @override
  String get appLiveGateTitle => 'Jūsu kontus neizdevās atvērt';

  @override
  String get appLiveGateUnavailableBuild => 'Īsti konti šajā būvējumā vēl nav pieejami.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nevarēja nolasīt atslēgu, kas aizsargā jūsu pastu šajā tālrunī. Bieži tas ir īslaicīgi: mēģiniet vēlreiz vai restartējiet tālruni.';

  @override
  String get appLiveGateKeyMissing =>
      'Atslēga, kas aizsargā jūsu pastu šajā tālrunī, ir pazudusi; tā var notikt pēc dublējuma atjaunošanas. Jūsu pasts joprojām ir serverī.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Pasta datubāzi šajā tālrunī nevar nolasīt: tā ir bojāta vai ir mainījusies tās atslēga. Jūsu pasts joprojām ir serverī.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Atverot jūsu kontus, radās kļūda ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Tiks dzēsti jūsu konti un šajā tālrunī saglabātais pasts, arī izsūtnē gaidošie ziņojumi. Pasts jūsu serveros netiks ietekmēts; pēc tam pievienojiet kontus vēlreiz.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Dzēst un sākt no jauna';

  @override
  String get appLiveGateUseDemo => 'Izmantot demonstrācijas pastu';

  @override
  String get appLiveGateReset => 'Atiestatīt pastu šajā tālrunī…';

  @override
  String get attachmentsUntitled => 'Pielikums';

  @override
  String get attachmentsUntitledFile => 'Bez nosaukuma';

  @override
  String get attachmentsOpenIn => 'Atvērt ar…';

  @override
  String get attachmentsSaveToFiles => 'Saglabāt failos';

  @override
  String get attachmentsShareMenu => 'Kopīgot…';

  @override
  String get attachmentsDownloadError =>
      'Neizdevās lejupielādēt pielikumu. Pārbaudiet savienojumu un mēģiniet vēlreiz.';

  @override
  String get attachmentsShareError => 'Neizdevās kopīgot pielikumu.';

  @override
  String attachmentsNoApp(String type) {
    return 'Šajā ierīcē nav lietotnes, kas atvērtu šo failu ($type). Tā vietā mēģiniet to kopīgot.';
  }

  @override
  String get attachmentsOpenInError => 'Neizdevās atvērt pielikumu citā lietotnē.';

  @override
  String attachmentsSaved(String name) {
    return 'Saglabāts „$name“';
  }

  @override
  String get attachmentsSaveError => 'Neizdevās saglabāt pielikumu.';

  @override
  String get attachmentsGone => 'Šis pielikums vairs nav pieejams.';

  @override
  String get attachmentsDownloadFailed => 'Pielikumu neizdevās lejupielādēt.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lappuses',
      one: '$count lappuse',
      zero: '$count lappušu',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size, izmantojot mobilos datus';
  }

  @override
  String get attachmentsLargeDownload =>
      'Šis pielikums ir liels. Lejupielādējiet to tagad vai vēlāk, izmantojot Wi-Fi.';

  @override
  String get attachmentsDownload => 'Lejupielādēt';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Lejupielādē $size…';
  }

  @override
  String get attachmentsDownloading => 'Lejupielādē…';

  @override
  String get attachmentsTooLarge => 'Pārāk liels, lai to priekšskatītu šeit.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Tiek rādīti pirmie $shown no $total. Lai iegūtu visu, nokopējiet, kopīgojiet vai saglabājiet.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Šo PDF šeit nevar parādīt (iespējams, tas ir aizsargāts ar paroli).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page no $count';
  }

  @override
  String get attachmentsModeTable => 'Tabula';

  @override
  String get attachmentsModeText => 'Teksts';

  @override
  String get attachmentsModeMessage => 'Ziņojums';

  @override
  String get attachmentsModeSource => 'Avots';

  @override
  String get attachmentsDontWrap => 'Neaplauzt rindas';

  @override
  String get attachmentsWrap => 'Aplauzt rindas';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines rindas',
      one: '$count rinda',
      zero: '$lines rindu',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopēt visu';

  @override
  String get attachmentsCopied => 'Nokopēts';

  @override
  String get attachmentsImageUnavailable => 'Šo attēlu šeit nevar parādīt. Mēģiniet „Atvērt ar…“.';

  @override
  String get attachmentsEmlNoSubject => '(Bez temata)';

  @override
  String get attachmentsEmlFrom => 'No';

  @override
  String get attachmentsEmlTo => 'Kam';

  @override
  String get attachmentsEmlCc => 'Kopija';

  @override
  String get attachmentsEmlDate => 'Datums';

  @override
  String get attachmentsEmlNoText => 'Šim ziņojumam nav teksta.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Pielikumā: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizators: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Un vēl $count notikumi',
      one: 'Un vēl $count notikums',
      zero: 'Un vēl $count notikumu',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Attēls';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format attēls';
  }

  @override
  String get attachmentsTypePdf => 'PDF dokuments';

  @override
  String get attachmentsTypeTsv => 'Ar tabulēšanas zīmēm atdalītas vērtības';

  @override
  String get attachmentsTypeCsv => 'CSV izklājlapa';

  @override
  String get attachmentsTypeCalendar => 'Kalendāra notikums';

  @override
  String get attachmentsTypeEmail => 'E-pasta ziņojums';

  @override
  String get attachmentsTypeContact => 'Kontaktkartīte';

  @override
  String get attachmentsTypeLog => 'Žurnāla fails';

  @override
  String get attachmentsTypeText => 'Teksts';

  @override
  String get attachmentsTypeZip => 'ZIP arhīvs';

  @override
  String get attachmentsTypeArchive => 'Arhīvs';

  @override
  String get attachmentsTypeWord => 'Word dokuments';

  @override
  String get attachmentsTypeExcel => 'Excel izklājlapa';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint prezentācija';

  @override
  String get attachmentsTypeWebPage => 'Tīmekļa lapa';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension fails';
  }

  @override
  String get attachmentsTypeFile => 'Fails';

  @override
  String get calendarUntitledEvent => 'Notikums';

  @override
  String get calendarAllDay => 'Visu dienu';

  @override
  String calendarYourTime(String time) {
    return '$time pēc jūsu laika';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Pievienoties: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pieņēma: $details',
      'tentative': '$name provizoriski pieņēma: $details',
      'declined': '$name noraidīja: $details',
      'delegated': '$name deleģēja: $details',
      'other': '$name neatbildēja uz: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pieņēma ielūgumu',
      'tentative': '$name provizoriski pieņēma ielūgumu',
      'declined': '$name noraidīja ielūgumu',
      'delegated': '$name deleģēja ielūgumu',
      'other': '$name neatbildēja uz ielūgumu',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Karte';

  @override
  String get calendarJoin => 'Pievienoties';

  @override
  String get calendarOnlineMeeting => 'Tiešsaistes sapulce';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider sapulce';
  }

  @override
  String get calendarOrganizerYou => 'Jūs';

  @override
  String get calendarOrganizerLabel => 'organizators';

  @override
  String get calendarStatusAccepted => 'Pieņemts';

  @override
  String get calendarStatusMaybe => 'Varbūt';

  @override
  String get calendarStatusDeclined => 'Noraidīts';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pieņēma',
      'tentative': '$name provizoriski pieņēma',
      'declined': '$name noraidīja',
      'delegated': '$name deleģēja',
      'other': '$name neatbildēja',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pieņēma:',
      'tentative': '$name provizoriski pieņēma:',
      'declined': '$name noraidīja:',
      'delegated': '$name deleģēja:',
      'other': '$name neatbildēja:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name ierosina jaunu laiku';
  }

  @override
  String get calendarCounterUnknown => 'Kāds dalībnieks ierosina jaunu laiku';

  @override
  String get calendarDeclineCounter => 'Organizators saglabāja laiku';

  @override
  String calendarRefresh(String name) {
    return '$name lūdz jaunāko versiju';
  }

  @override
  String get calendarRefreshUnknown => 'Kāds dalībnieks lūdz jaunāko versiju';

  @override
  String get calendarCancelled => 'Atcelts';

  @override
  String get calendarCancelledByOrganizer => 'Organizators atcēla šo notikumu.';

  @override
  String get calendarCancelledLater => 'Šis notikums vēlāk tika atcelts.';

  @override
  String get calendarOutdated => 'Novecojis';

  @override
  String get calendarOutdatedDetail => 'Šis ielūgums vēlāk tika atjaunināts; spēkā ir jaunākais.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Vieta noņemta (bija $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Vieta noņemta (nebija norādīta)';

  @override
  String calendarLocationChanged(String location) {
    return 'Vieta mainīta uz $location';
  }

  @override
  String get calendarNewTitle => 'Jauns nosaukums';

  @override
  String get calendarRepeatChanged => 'Mainījies atkārtojums';

  @override
  String get calendarUpdated => 'Atjaunināts';

  @override
  String get calendarUpdatedInvitation => 'Atjaunināts ielūgums';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Laiks mainīts no $before uz $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Laika josla „$zone“ nav zināma: laiki, kā norādīts';
  }

  @override
  String calendarNext(String when) {
    return 'Nākamais: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viesi',
      one: '$count viesis',
      zero: '$count viesu',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pieņēma');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count varbūt');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count noraidīja');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (jūs)';
  }

  @override
  String get calendarAttendeeOptional => 'neobligāts';

  @override
  String get calendarAttendeeRoom => 'telpa';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Jūs pieņēmāt agrāku versiju.',
      'tentative': 'Jūs provizoriski pieņēmāt agrāku versiju.',
      'declined': 'Jūs noraidījāt agrāku versiju.',
      'delegated': 'Jūs deleģējāt agrāku versiju.',
      'other': 'Jūs neatbildējāt uz agrāku versiju.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Pieņemt';

  @override
  String get calendarMaybe => 'Varbūt';

  @override
  String get calendarDecline => 'Noraidīt';

  @override
  String get calendarCommentHint => 'Komentārs organizatoram (neobligāti)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Atbilde tiks nosūtīta organizatoram $organizer no $address.';
  }

  @override
  String get calendarAddComment => 'Pievienot komentāru';

  @override
  String get calendarAddToCalendar => 'Pievienot kalendāram';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Un vēl $count notikumi failā',
      one: 'Un vēl $count notikums failā',
      zero: 'Un vēl $count notikumu failā',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Nav kalendāra lietotnes, kurai pievienot notikumu.';

  @override
  String get calendarCantOpenCalendar => 'Neizdevās atvērt kalendāru.';

  @override
  String get calendarCantOpenLink => 'Neizdevās atvērt saiti.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Vai pievienoties $provider sapulcei?';
  }

  @override
  String get calendarJoinTitle => 'Vai pievienoties sapulcei?';

  @override
  String calendarJoinOpens(String host) {
    return 'Pārlūkā tiks atvērts $host.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Uzmanību: šī adrese ar līdzīga izskata burtiem atdarina $site.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Uzmanību: šī adrese ar līdzīga izskata burtiem atdarina citu vietni.';

  @override
  String calendarJoinOpen(String host) {
    return 'Atvērt $host';
  }

  @override
  String get calendarNoOrganizer => 'Šim ielūgumam nav organizatora, kuram atbildēt.';

  @override
  String get calendarNoAccount => 'Nav konta, no kura atbildēt.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Pieņemts',
      'tentative': 'Varbūt',
      'other': 'Noraidīts',
    });
    return '$_temp0 · sūta atbildi: $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Pieņemts',
      'tentative': 'Varbūt',
      'other': 'Noraidīts',
    });
    return '$_temp0 · atbilde nosūtīta';
  }

  @override
  String get calendarReplyAlreadySent => 'Atbilde jau tika nosūtīta.';

  @override
  String get calendarReplyNotSent => 'Atbilde netika nosūtīta.';

  @override
  String get dataSmimeNeedsDevice =>
      'Jūsu S/MIME sertifikāts ir šajā ierīcē: atveriet Loupe, lai parakstītu un nosūtītu šo ziņojumu.';

  @override
  String dataSigningFailed(String error) {
    return 'Parakstīšana neizdevās: $error';
  }

  @override
  String get keyboardShortcuts => 'Īsinājumtaustiņi';

  @override
  String get keyboardGroupGeneral => 'Vispārīgi';

  @override
  String get keyboardGroupMessages => 'Ziņojumi';

  @override
  String get keyboardGroupCompose => 'Rakstīšana';

  @override
  String get keyboardCommandPalette => 'Komandu palete';

  @override
  String get keyboardBackClose => 'Atpakaļ, aizvērt';

  @override
  String get keyboardNextMessage => 'Nākamais ziņojums';

  @override
  String get keyboardPreviousMessage => 'Iepriekšējais ziņojums';

  @override
  String get keyboardOpenMessage => 'Atvērt ziņojumu';

  @override
  String get keyboardMoveToTrash => 'Pārvietot uz miskasti';

  @override
  String get keyboardToggleRead => 'Atzīmēt kā lasītu vai nelasītu';

  @override
  String get keyboardToggleFlag => 'Pievienot vai noņemt karodziņu';

  @override
  String get keyboardCloseDraft => 'Aizvērt (saglabāt vai dzēst melnrakstu)';

  @override
  String get keyboardOr => 'vai';

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
  String get mailingListsMuted => 'Pavediens apklusināts. Jauni ziņojumi tajā tiks saņemti kā lasīti.';

  @override
  String get mailingListsUnmuted => 'Pavediena apklusināšana atcelta.';

  @override
  String get mailingListsMuteThread => 'Apklusināt pavedienu';

  @override
  String get mailingListsUnmuteThread => 'Atcelt pavediena apklusināšanu';

  @override
  String get mailingListsPin => 'Piespraust pastkastēm';

  @override
  String get mailingListsUnpin => 'Atspraust no pastkastēm';

  @override
  String get mailingListsDefaultView => 'Atvērt noklusējuma skatā';

  @override
  String get mailingListsPlainText => 'Atvērt kā vienkāršu tekstu (Mono)';

  @override
  String get mailingListsShowMuted => 'Rādīt apklusinātos pavedienus';

  @override
  String get mailingListsHideMuted => 'Paslēpt apklusinātos pavedienus';

  @override
  String get mailingListsTreatAsNewsletter => 'Uzskatīt par jaunumu vēstuli';

  @override
  String get mailingListsOptions => 'Saraksta opcijas';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted nelasīti',
      one: '$count nelasīts',
      zero: '$formatted nelasītu',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Jauns ziņojums sarakstam';

  @override
  String get mailingListsRowUnread => 'Nelasīts';

  @override
  String get mailingListsRowMuted => 'Apklusināts';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atbildes',
      one: '$count atbilde',
      zero: '$count atbilžu',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Nav pavedienu';

  @override
  String get mailingListsMutedHidden => 'Apklusinātie pavedieni ir paslēpti.';

  @override
  String get mailingListsTechnicalTitle => 'Tehniskie saraksti';

  @override
  String get mailingListsTechnicalEmpty => 'E-pasta saraksti šeit parādīsies, tiklīdz pienāks to pasts.';

  @override
  String get mailingListsTechnicalFooter =>
      'Šo sarakstu ziņojumi tiek atvērti kā vienkāršs teksts vienplatuma fontā, un ielāpi tiek rādīti kā diff. Ar pogu Aa joprojām var pārslēgt jebkuru ziņojumu.';

  @override
  String get paletteMoveToMailbox => 'Pārvietot uz pastkasti…';

  @override
  String get paletteMarkAllRead => 'Atzīmēt visu kā lasītu';

  @override
  String get paletteExportFolder => 'Eksportēt mapi…';

  @override
  String get paletteGetNewMail => 'Saņemt jaunu pastu';

  @override
  String get paletteSnoozed => 'Atliktie';

  @override
  String get paletteSubscriptions => 'Abonementi';

  @override
  String get paletteDiscussions => 'Diskusijas';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-pasta saraksts';

  @override
  String get paletteTag => 'Birka';

  @override
  String get paletteSwipeActions => 'Pavilkšanas darbības';

  @override
  String get paletteNotifications => 'Paziņojumi';

  @override
  String get paletteRules => 'Kārtulas';

  @override
  String get paletteEncryption => 'Pilnīga šifrēšana';

  @override
  String get paletteAdvanced => 'Papildu';

  @override
  String get paletteAddAccount => 'Pievienot kontu';

  @override
  String get paletteAccount => 'Konts';

  @override
  String get paletteFolders => 'Mapes';

  @override
  String get paletteRecentSearch => 'Nesena meklēšana';

  @override
  String paletteSearchMail(String query) {
    return 'Meklēt pastā „$query“';
  }

  @override
  String get palettePlaceholder => 'Meklēt darbības, pastkastes, iestatījumus';

  @override
  String get paletteNothingFound => 'Nekas nav atrasts';

  @override
  String get searchNewSmartMailbox => 'Jauna Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Rāda visu, kas atbilst „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ saglabāta pastkastēs';
  }

  @override
  String get searchMakeRule => 'Pārvērst par kārtulu';

  @override
  String get searchSaveSmartMailbox => 'Saglabāt kā Smart Mailbox';

  @override
  String get searchNegate => 'Noliegt';

  @override
  String get searchDontNegate => 'Nenoliegt';

  @override
  String get searchAllMailboxes => 'Visas pastkastes';

  @override
  String get searchRecent => 'Nesenie meklējumi';

  @override
  String get searchClear => 'Notīrīt';

  @override
  String get searchSuggestions => 'Ieteikumi';

  @override
  String get searchUnreadMessages => 'Nelasītie ziņojumi';

  @override
  String get searchFlaggedMessages => 'Ziņojumi ar karodziņu';

  @override
  String get searchWithAttachments => 'Ziņojumi ar pielikumiem';

  @override
  String get searchUnrepliedMessages => 'Neatbildētie ziņojumi';

  @override
  String get searchTags => 'Birkas';

  @override
  String get searchPeople => 'Cilvēki';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'No: $name';
  }

  @override
  String get searchSearching => 'Meklē…';

  @override
  String get searchNoResults => 'Nav rezultātu';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted rezultāti',
      one: '$count rezultāts',
      zero: '$formatted rezultātu',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Meklēšanas izvēlne';

  @override
  String searchSearchingAccount(String account) {
    return 'Meklē kontā $account serverī…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Meklē kontā serverī…';

  @override
  String searchAccountFailed(String account) {
    return 'Neizdevās meklēt kontā $account serverī';
  }

  @override
  String get searchUnknownAccountFailed => 'Neizdevās meklēt kontā serverī';

  @override
  String searchChip(String term) {
    return '$term. Pieskarieties divreiz, lai rediģētu.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ne $term. Pieskarieties divreiz, lai rediģētu.';
  }

  @override
  String get searchReadAndUnread =>
      'Šrēdingera iesūtne: katrs ziņojums šeit ir vienlaikus lasīts un nelasīts, līdz to atverat.';

  @override
  String searchContradiction(String term) {
    return 'Neviens ziņojums nevar vienlaikus būt „$term“ un nebūt.';
  }

  @override
  String get searchSyncDeviceOnly => 'Tikai šajā ierīcē';

  @override
  String searchSyncUnsupported(String account) {
    return 'Tikai šajā ierīcē: $account to nevar glabāt';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nav sinhronizēts: $account ir jaunāks formāts';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Gaida sinhronizāciju ar $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinhronizēts ar $account';
  }

  @override
  String get searchRename => 'Pārdēvēt';

  @override
  String get searchEditSearch => 'Rediģēt meklēšanu';

  @override
  String get searchDeleteSmartMailbox => 'Dzēst Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Pārdēvēt Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Šī Smart Mailbox tika izdzēsta.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes paliek šajā ierīcē.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes tiek glabātas jūsu pasta serverī, tāpēc tās ir arī citās jūsu ierīcēs, kā arī Thunderbird ar Expression Search Reloaded. Tās, kas meklē visos kontos, tiek glabātas kontā $account; tās, kas attiecas uz vienu mapi, — šīs mapes kontā.';
  }

  @override
  String get searchSyncVia => 'Sinhronizēt, izmantojot';

  @override
  String get searchSyncViaFooter => 'Katrā ierīcē izvēlieties to pašu kontu.';

  @override
  String get searchGmailCantKeep => 'Gmail nevar glabāt Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Glabāt Smart Mailboxes tikai šajā ierīcē';

  @override
  String get searchOnTheServer => 'Serverī';

  @override
  String get searchServerFooter =>
      'Servera metadati (IMAP METADATA) nav redzami nevienā pasta lietotnē. Serveros bez tiem tiek izveidota mape „Loupe Settings“ ar vienu ziņojumu; Loupe to paslēpj no pastkastu saraksta.';

  @override
  String get searchSyncNow => 'Sinhronizēt tūlīt';

  @override
  String get searchStateUnsupported => 'Netiek atbalstīts';

  @override
  String get searchStateNewerFormat => 'Jaunāks formāts';

  @override
  String get searchStateFailed => 'Neizdevās sinhronizēt';

  @override
  String get searchStateSyncing => 'Sinhronizē…';

  @override
  String get searchStateWaiting => 'Gaida';

  @override
  String get searchStateMetadata => 'Servera metadati';

  @override
  String get searchStateFolder => 'Mape „Loupe Settings“';

  @override
  String get searchStateNothing => 'Nekas nav saglabāts';

  @override
  String get sharedBack => 'Atpakaļ';

  @override
  String get sharedYesterday => 'Vakar';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date plkst. $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baiti',
      one: '$count baits',
      zero: '$count baitu',
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
  String get sharedSyncNoAccounts => 'Nav kontu';

  @override
  String get sharedSyncChecking => 'Pārbauda pastu…';

  @override
  String get sharedSyncFailed => 'Neizdevās pārbaudīt pastu';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Bezsaistē';

  @override
  String get sharedSyncJustNow => 'Tikko atjaunināts';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Atjaunināts pirms $minutes minūtēm',
      one: 'Atjaunināts pirms $minutes minūtes',
      zero: 'Atjaunināts pirms $minutes minūtēm',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Atjaunināts plkst. $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Atjaunināts $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Visas iesūtnes';

  @override
  String get sharedMailboxUnread => 'Nelasītie';

  @override
  String get sharedMailboxFlagged => 'Ar karodziņu';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Visi melnraksti';

  @override
  String get sharedMailboxAllSent => 'Visi nosūtītie';

  @override
  String get sharedMailboxUntitled => 'Pastkaste';

  @override
  String get sharedTagImportant => 'Svarīgs';

  @override
  String get sharedTagWork => 'Darbs';

  @override
  String get sharedTagPersonal => 'Personīgs';

  @override
  String get sharedTagToDo => 'Jāizdara';

  @override
  String get sharedTagLater => 'Vēlāk';

  @override
  String get sharedTags => 'Birkas';

  @override
  String get sharedMoveTo => 'Pārvietot uz…';

  @override
  String get sharedNoRecipients => 'Nav adresātu';

  @override
  String get sharedUnknownSender => 'Nezināms sūtītājs';

  @override
  String get sharedOnServer => 'Serverī';

  @override
  String get sharedAttachment => 'Pielikums';

  @override
  String get sharedSnoozedBadge => 'Atlikts';

  @override
  String get sharedRowUnread => 'Nelasīts';

  @override
  String get sharedRowBackFromSnooze => 'Atgriezies pēc atlikšanas';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Ar karodziņu';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhivēti $count ziņojumi',
      one: 'Arhivēts $count ziņojums',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dzēsti $count ziņojumi',
      one: 'Dzēsts $count ziņojums',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi pārvietoti uz iesūtni',
      one: '$count ziņojums pārvietots uz iesūtni',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi pārvietoti uz miskasti',
      one: '$count ziņojums pārvietots uz miskasti',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi pārvietoti uz mēstulēm',
      one: '$count ziņojums pārvietots uz mēstulēm',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi pārvietoti uz $mailbox',
      one: '$count ziņojums pārvietots uz $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi pārvietoti uz pastkasti',
      one: '$count ziņojums pārvietots uz pastkasti',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziņojumi atlikti līdz $time',
      one: '$count ziņojums atlikts līdz $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Atlikts līdz $time tikai šajā ierīcē: serveris nevar glabāt atlikšanas laikus.';
  }

  @override
  String get sharedMoveOneAccount => 'Lai pārvietotu ziņojumus, atlasiet tos no viena konta.';

  @override
  String get sharedSnoozeTitle => 'Atlikt';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Mainīt atlikšanas laiku';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dzēst $count ziņojumus neatgriezeniski?',
      one: 'Dzēst $count ziņojumu neatgriezeniski?',
      zero: 'Dzēst $count ziņojumu neatgriezeniski?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'To nevar atsaukt.';

  @override
  String get sharedDeletePermanently => 'Dzēst neatgriezeniski';

  @override
  String get sharedSwipeRead => 'Lasīts';

  @override
  String get sharedSwipeUnread => 'Nelasīts';

  @override
  String get sharedSwipeInbox => 'Iesūtne';

  @override
  String get sharedSwipeDelete => 'Dzēst';

  @override
  String get sharedTrash => 'Uz miskasti';

  @override
  String get sharedSwipeSnooze => 'Atlikt';

  @override
  String get sharedWakeNow => 'Atgriezt tūlīt';

  @override
  String get sharedChangeSnoozeTime => 'Mainīt atlikšanas laiku…';

  @override
  String get sharedSnooze => 'Atlikt…';

  @override
  String get sharedTag => 'Birkas…';

  @override
  String get sharedMoveMessage => 'Pārvietot ziņojumu…';

  @override
  String get sharedNotJunk => 'Nav mēstule';

  @override
  String get accountSetupTitle => 'Pievienot kontu';

  @override
  String get accountSetupTitleDone => 'Konts pievienots';

  @override
  String get accountSetupAddressTitle => 'Pievienot e-pasta kontu';

  @override
  String get accountSetupAddressText => 'Loupe atrod iestatījumus lielākajai daļai pakalpojumu sniedzēju.';

  @override
  String get accountSetupNameHint => 'Jūsu vārds';

  @override
  String get accountSetupEmail => 'E-pasts';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Turpināt';

  @override
  String get accountSetupLookingUp => 'Meklē iestatījumus…';

  @override
  String get accountSetupImport => 'Importēt no Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Ievadiet derīgu e-pasta adresi.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Neizdevās atrast iestatījumus domēnam $domain. Ievadiet tos zemāk.';
  }

  @override
  String get accountSetupCheckServers => 'Pārbaudiet serveru nosaukumus un portus.';

  @override
  String get accountSetupEnterPassword => 'Ievadiet paroli.';

  @override
  String get accountSetupConnecting => 'Savienojas…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Gaida $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Neizdevās atvērt lapu.';

  @override
  String get accountSetupCouldNotSaveName => 'Neizdevās saglabāt nosaukumu.';

  @override
  String get accountSetupTrustCertificate => 'Uzticēties šim sertifikātam';

  @override
  String get accountSetupPasswordRequired => 'Obligāti';

  @override
  String get accountSetupShowPassword => 'Rādīt paroli';

  @override
  String get accountSetupHidePassword => 'Paslēpt paroli';

  @override
  String get accountSetupAppPassword => 'Lietotnes parole';

  @override
  String get accountSetupApiToken => 'API marķieris';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Ienākošais · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Izejošais · SMTP';

  @override
  String get accountSetupSignIn => 'Pierakstīties';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Pierakstīties ar $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Izmantot lietotnes paroli';

  @override
  String get accountSetupUseAppPasswordInstead => 'Tā vietā izmantot lietotnes paroli';

  @override
  String get accountSetupUseDifferentAddress => 'Izmantot citu adresi';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kā izveidot lietotnes paroli';

  @override
  String get accountSetupHowToCreateOne => 'Kā to izveidot';

  @override
  String get accountSetupGoogleNote =>
      'Jūs pierakstāties Google lapā, un Loupe nekad neredz jūsu paroli. Atļaujiet Loupe lasīt, sūtīt un kārtot jūsu pastu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Pierakstīties ar Google“ šajā būvējumā vēl nav pieejams. Tā vietā varat izveidot savienojumu ar lietotnes paroli (jūsu Google kontā jābūt ieslēgtai divpakāpju verifikācijai).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Izveidojiet lietotnes paroli savā Google kontā un ielīmējiet to zemāk.';

  @override
  String get accountSetupMicrosoftNote =>
      'Jūs pierakstāties Microsoft lapā, un Loupe nekad neredz jūsu paroli. Tas darbojas ar Outlook.com un Hotmail, kā arī ar Microsoft 365 darba vai mācību kontiem.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Pierakstīšanās ar Microsoft būs pieejama vēlākā būvējumā. Outlook, Hotmail un Microsoft 365 kontiem tā ir nepieciešama: tie vairs nepieņem paroles no pasta lietotnēm.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail nepieciešama lietotnei specifiska parole, nevis jūsu Apple konta parole.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail nepieciešama lietotnes parole, nevis jūsu konta parole.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe izveido savienojumu ar Fastmail, izmantojot JMAP un API marķieri: Settings › Privacy & Security › Manage API tokens, JMAP, ar piekļuvi e-pastam un sūtīšanai.';

  @override
  String get accountSetupFastmailNote => 'Fastmail pasta lietotnēm nepieciešama lietotnes parole.';

  @override
  String get accountSetupServerSettings => 'Servera iestatījumi';

  @override
  String get accountSetupSettingsNotFound => 'Automātiski netika atrasti';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Atrasti, izmantojot $source';
  }

  @override
  String get accountSetupEditSettings => 'Rediģēt iestatījumus';

  @override
  String get accountSetupSyncing => 'Jūsu pasts tiek sinhronizēts.';

  @override
  String get accountSetupDescription => 'Apraksts';

  @override
  String get accountSetupDescriptionHint => 'Darbs, personīgais…';

  @override
  String get accountSetupColour => 'Krāsa';

  @override
  String accountSetupColourNumber(int number) {
    return 'Krāsa $number';
  }

  @override
  String get accountSetupSaving => 'Saglabā…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe neizdevās atvērt savu pasta datubāzi šajā tālrunī. Aizveriet Loupe, atveriet to vēlreiz un mēģiniet vēlreiz.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Radās kļūda ($error). Mēģiniet vēlreiz.';
  }

  @override
  String get accountSetupSecurityNone => 'Nav';

  @override
  String get accountSetupProtocol => 'Protokols';

  @override
  String get accountSetupPort => 'Ports';

  @override
  String get accountSetupSecurity => 'Drošība';

  @override
  String get accountSetupUsername => 'Lietotājvārds';

  @override
  String get accountSetupUsernameHint => 'Jūsu e-pasta adrese';

  @override
  String get accountSetupNoEncryptionTitle => 'Vai izveidot savienojumu bez šifrēšanas?';

  @override
  String get accountSetupNoEncryptionText =>
      'Jūsu parole un katrs ziņojums tiktu pārsūtīti kā vienkāršs teksts. Ikviens tīklā, piemēram, publiskā Wi-Fi tīklā, varētu tos izlasīt. Izmantojiet to tikai serverim savā tīklā.';

  @override
  String get accountSetupUseWithoutEncryption => 'Izmantot bez šifrēšanas';

  @override
  String get accountSetupApiTokenRejected =>
      'API marķieris noraidīts. Izveidojiet Fastmail API marķieri JMAP ar piekļuvi e-pastam un ielīmējiet to.';

  @override
  String get accountSetupAppPasswordRejected => 'Parole noraidīta. Izmantojiet lietotnes paroli, nevis konta paroli.';

  @override
  String get accountSetupPasswordRejected => 'Parole noraidīta. Pārbaudiet to un mēģiniet vēlreiz.';

  @override
  String get accountSetupServerUnreachable => 'Nevar sasniegt serveri. Pārbaudiet servera iestatījumus un savienojumu.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Servera sertifikāts nav uzticams. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Pierakstīšanās tika atcelta. Pieskarieties „Pierakstīties ar $provider“, lai mēģinātu vēlreiz.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe nepieciešama atļauja lasīt un sūtīt jūsu Gmail pastu. Pierakstieties vēlreiz un atļaujiet piekļuvi, atzīmējot Gmail izvēles rūtiņu.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe nepieciešama atļauja lasīt un sūtīt jūsu pastu. Pierakstieties vēlreiz un pieņemiet atļaujas.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Jūsu organizācijai ir jāapstiprina Loupe, pirms varat to izmantot ar šo kontu. Lūdziet IT administratoram piešķirt administratora piekrišanu Loupe pakalpojumā Microsoft Entra ID un pēc tam mēģiniet vēlreiz.';

  @override
  String get accountSetupOAuthBlocked =>
      'Jūsu organizācijas pierakstīšanās noteikumi neatļauj Loupe šajā ierīcē. Vērsieties pie IT administratora.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Neizdevās sazināties ar $provider. Pārbaudiet interneta savienojumu un mēģiniet vēlreiz.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Pierakstīšanās ar $provider šajā Loupe versijā nav pareizi iestatīta. Lūdzu, ziņojiet par to.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Pierakstīšanās ar $provider neizdevās. Mēģiniet vēlreiz.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider jūs pierakstīja, bet Gmail atteica piekļuvi šai adresei. Pierakstoties izvēlieties to pašu kontu. Darba vai mācību kontiem administrators var būt izslēdzis IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider jūs pierakstīja, bet pasta serveris atteica piekļuvi šai adresei. Pierakstoties izvēlieties to pašu kontu. Darba vai mācību kontiem administrators var būt izslēdzis IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Nevar sasniegt pasta serveri. Pārbaudiet savienojumu un mēģiniet vēlreiz.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Pierakstīšanās ar $provider šajā versijā nav pieejama.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Atkārtoti pierakstījāties. $account tiek sinhronizēts.';
  }

  @override
  String get accountSetupSignInAgain => 'Pierakstīties vēlreiz';

  @override
  String get accountSetupSigningIn => 'Pierakstās…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider vairs nepieņem Loupe pierakstīšanos adresei $email, tāpēc $account netiek sinhronizēts. Pierakstieties vēlreiz, lai saņemtu tā pastu.';
  }

  @override
  String get accountImportTitle => 'Importēt no Thunderbird';

  @override
  String get accountImportPointCamera => 'Pavērsiet kameru pret QR kodu, ko rāda Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Noskenēti $scanned no $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Noskenēti $scanned no $total kodiem',
      one: 'Noskenēti $scanned no $total koda',
      zero: 'Noskenēti $scanned no $total kodiem',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pagaidām $count konti',
      one: 'Pagaidām $count konts',
      zero: 'Pagaidām $count kontu',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Datorā atveriet Thunderbird un izvēlieties Rīki › Eksportēt uz mobilo ierīci. Atlasiet savus kontus un pēc tam noskenējiet katru parādīto kodu. Kodus var skenēt jebkurā secībā.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Turpināt ar $count kontiem',
      one: 'Turpināt ar $count kontu',
      zero: 'Turpināt ar $count kontiem',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Tā vietā ielīmēt tekstu';

  @override
  String get accountImportStartOver => 'Sākt no jauna';

  @override
  String get accountImportDuplicateCode => 'Šis kods jau ir pievienots.';

  @override
  String get accountImportRestarted =>
      'Šis kods ir no jauna eksporta, tāpēc iepriekš noskenētie kodi tika atlikti malā.';

  @override
  String get accountImportNotThunderbird => 'Šis nav Thunderbird konta kods.';

  @override
  String get accountImportNewerVersion =>
      'Šis kods ir no jaunākas Thunderbird versijas. Atjauniniet Loupe, lai to importētu.';

  @override
  String get accountImportDamaged => 'Šo Thunderbird kodu neizdevās nolasīt.';

  @override
  String get accountImportTooLarge => 'Šis kods ir pārāk liels, lai būtu Thunderbird eksports.';

  @override
  String get accountImportCouldNotOpenSettings => 'Neizdevās atvērt iestatījumus.';

  @override
  String get accountImportCameraOffTitle => 'Piekļuve kamerai ir izslēgta';

  @override
  String get accountImportCameraOffText =>
      'Atļaujiet Loupe izmantot kameru iestatījumos, lai noskenētu kodu, vai tā vietā ielīmējiet koda tekstu.';

  @override
  String get accountImportNoCameraTitle => 'Nav kameras';

  @override
  String get accountImportNoCameraText => 'Loupe šeit nevar izmantot kameru. Tā vietā ielīmējiet koda tekstu.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera neieslēdzās';

  @override
  String get accountImportCameraFailedText => 'Mēģiniet vēlreiz vai tā vietā ielīmējiet koda tekstu.';

  @override
  String get accountImportOpenSettings => 'Atvērt iestatījumus';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atrasti $count konti',
      one: 'Atrasts $count konts',
      zero: 'Atrasti $count konti',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nevienu no šajos kodos esošajiem kontiem neizdevās nolasīt.';

  @override
  String get accountImportChoose => 'Izvēlieties kontus, ko pievienot Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Netika noskenēti $count kodi no $total ($codes), tāpēc to konti nav sarakstā.',
      one: 'Netika noskenēts $count kods no $total ($codes), tāpēc tā konti nav sarakstā.',
      zero: 'Netika noskenēti $count kodi no $total ($codes), tāpēc to konti nav sarakstā.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes un $last';
  }

  @override
  String get accountImportScanMore => 'Skenēt vēl kodus';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Kodos neizdevās nolasīt $count kontus. Iespējams, tie izmanto jaunākas Thunderbird versijas iestatījumus.',
      one: 'Kodos neizdevās nolasīt $count kontu. Iespējams, tas izmanto jaunākas Thunderbird versijas iestatījumus.',
      zero: 'Kodos neizdevās nolasīt $count kontus. Iespējams, tie izmanto jaunākas Thunderbird versijas iestatījumus.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skenēt vēlreiz';

  @override
  String get accountImportAlreadyAdded => 'Konts ar šo adresi jau ir Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Kad konts tiks pievienots, jūs pierakstīsieties ar $provider, tāpat kā Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Pievienojiet kontu ar lietotnes paroli (nepieciešama divpakāpju verifikācija).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird pierakstās Gmail ar Google. „Pierakstīties ar Google“ būs pieejams vēlākā būvējumā; līdz tam pievienojiet kontu ar lietotnes paroli (nepieciešama divpakāpju verifikācija).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird pierakstās šajā kontā pārlūkā. Loupe to vēl nespēj: izmantojiet lietotnes paroli, ja jūsu pakalpojumu sniedzējs tādu piedāvā.';

  @override
  String get accountImportUnencrypted => 'Savienojas bez šifrēšanas. Izmantojiet to tikai savā tīklā.';

  @override
  String get accountImportEnterAgain => 'Ievadiet vēlreiz';

  @override
  String get accountImportAdded => 'Pievienots';

  @override
  String accountImportAdding(int index, int total) {
    return 'Pievieno $index no $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pievienot $count kontus',
      one: 'Pievienot $count kontu',
      zero: 'Pievienot $count kontus',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Ielīmēt eksporta tekstu';

  @override
  String get accountImportPasteText => 'Ielīmējiet Thunderbird eksporta koda tekstu, vienu kodu katrā rindā.';

  @override
  String get accountImportPop3 => 'POP3 konti netiek atbalstīti. Loupe glabā pastu serverī, izmantojot IMAP.';

  @override
  String get accountImportKerberos => 'Šis konts pierakstās ar Kerberos, ko Loupe neatbalsta.';

  @override
  String get accountImportNtlm => 'Šis konts pierakstās ar NTLM, ko Loupe neatbalsta.';

  @override
  String get accountImportClientCertificate => 'Šis konts pierakstās ar klienta sertifikātu, ko Loupe vēl neatbalsta.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Pierakstīšanās ar Microsoft būs pieejama vēlākā būvējumā. Outlook un Microsoft 365 konti vairs nepieņem paroles no pasta lietotnēm.';

  @override
  String get accountImportEnterPassword => 'Ievadiet paroli.';

  @override
  String get accountImportEnterAppPassword => 'Ievadiet lietotnes paroli.';

  @override
  String get accountImportEnterApiToken => 'Ievadiet API marķieri.';

  @override
  String get accountImportStorageFailed => 'Loupe neizdevās atvērt savu kontu krātuvi. Vēlāk mēģiniet vēlreiz.';

  @override
  String get accountImportFailed => 'Kontu neizdevās pievienot. Mēģiniet vēlreiz vai pievienojiet to manuāli.';

  @override
  String get composeNewMessageTitle => 'Jauns ziņojums';

  @override
  String get composeAttach => 'Pievienot pielikumu';

  @override
  String get composeSendLater => 'Sūtīt vēlāk';

  @override
  String composeSendAt(String time) {
    return 'Sūtīt $time';
  }

  @override
  String get composeSendHint => 'Turiet nospiestu, lai nosūtītu vēlāk';

  @override
  String get composeNoAccount => 'Lai sūtītu pastu, pievienojiet kontu.';

  @override
  String get composeTo => 'Kam:';

  @override
  String get composeCc => 'Kopija:';

  @override
  String get composeBcc => 'Diskrētā kopija:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopija/diskrētā kopija, no: $email';
  }

  @override
  String get composeFromLabel => 'No:';

  @override
  String get composeSubjectLabel => 'Temats:';

  @override
  String composeReplyTo(String address) {
    return 'Atbildēt uz: $address';
  }

  @override
  String get composeFrom => 'No';

  @override
  String composeReplyFrom(String email) {
    return 'Atbildēt no $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Sūtīt no $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vai atbildēt no $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Vai sūtīt no $email?';
  }

  @override
  String get composeDismiss => 'Nerādīt';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nav saglabāts kā identitāte · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Saglabāt kā identitāti';

  @override
  String composeAliasSaved(String email) {
    return '$email ir saglabāta kā identitāte.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Nederīga adrese $address';
  }

  @override
  String get composeOriginalNotFound => 'Neizdevās atrast sākotnējo ziņojumu.';

  @override
  String get composeDraftNotFound => 'Neizdevās atrast melnrakstu.';

  @override
  String get composeAttachmentsLost => 'Pielikumus neizdevās atgūt. Pievienojiet tos vēlreiz.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Dažus pielikumus neizdevās pievienot: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Pielikumu kopējais lielums ir $size; daži serveri noraida tik lielus ziņojumus.';
  }

  @override
  String get composeAttachFailed => 'Neizdevās pievienot failu.';

  @override
  String get composeInvalidAddressTitle => 'Nederīga adrese';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ nav derīga e-pasta adrese.';
  }

  @override
  String get composeNoSubjectTitle => 'Nav temata';

  @override
  String get composeNoSubjectText => 'Šim ziņojumam nav temata. Vai tomēr nosūtīt?';

  @override
  String get composeSentBeforeChanges => 'Tas tika nosūtīts pirms jūsu izmaiņām, kas ir saglabātas melnrakstos.';

  @override
  String composeScheduled(String time) {
    return 'Ieplānots: $time';
  }

  @override
  String get composeSending => 'Sūta…';

  @override
  String get composeSent => 'Nosūtīts';

  @override
  String get composeSendFailed => 'Neizdevās nosūtīt. Mēģiniet vēlreiz.';

  @override
  String get composeAlreadySent => 'Jau nosūtīts.';

  @override
  String get composeDiscardChanges => 'Atmest izmaiņas';

  @override
  String get composeSaveChanges => 'Saglabāt izmaiņas';

  @override
  String get composeDeleteDraft => 'Dzēst melnrakstu';

  @override
  String get composeSaveDraft => 'Saglabāt melnrakstu';

  @override
  String get composeDraftSaved => 'Melnraksts saglabāts';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date plkst. $time $name rakstīja:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date plkst. $time kāds rakstīja:';
  }

  @override
  String get composeForwardHeader => '---------- Pārsūtīts ziņojums ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'No: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datums: $date plkst. $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Temats: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Kam: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kopija: $addresses';
  }

  @override
  String get composeLaterToday => 'Vēlāk šodien';

  @override
  String get composeTomorrowMorning => 'Rīt no rīta';

  @override
  String get composeMondayMorning => 'Pirmdien no rīta';

  @override
  String get composePickDateTime => 'Izvēlēties datumu un laiku…';

  @override
  String get composeSendWithoutDelay => 'Sūtīt bez aiztures';

  @override
  String composeSendTimeToday(String time) {
    return 'Šodien plkst. $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Rīt plkst. $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day plkst. $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Šodien $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Rīt $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Vai turpināt rediģēt melnrakstu?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Kad Loupe tika aizvērta, kāds ziņojums netika nosūtīts.',
      'one': 'Kad Loupe tika aizvērta, ziņojums adresātam $name netika nosūtīts.',
      'other': 'Kad Loupe tika aizvērta, ziņojums adresātam $name un citiem netika nosūtīts.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Kad Loupe tika aizvērta, „$subject“ netika nosūtīts.',
      'one': 'Kad Loupe tika aizvērta, „$subject“ adresātam $name netika nosūtīts.',
      'other': 'Kad Loupe tika aizvērta, „$subject“ adresātam $name un citiem netika nosūtīts.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Turpināt rediģēt';

  @override
  String get composeRecoverySave => 'Saglabāt melnrakstos';

  @override
  String get composeRecoveryDiscard => 'Atmest';

  @override
  String get composeRecoverySaved => 'Saglabāts melnrakstos';

  @override
  String get outboxSectionFailed => 'Nav nosūtīti';

  @override
  String get outboxSectionSending => 'Sūta';

  @override
  String get outboxSectionScheduled => 'Ieplānoti';

  @override
  String get outboxStatusQueued => 'Drīz tiks nosūtīts';

  @override
  String get outboxStatusSending => 'Sūta…';

  @override
  String get outboxStatusFailed => 'Nav nosūtīts';

  @override
  String get outboxNoRecipients => 'Nav adresātu';

  @override
  String get outboxNoSubject => '(Bez temata)';

  @override
  String get outboxSendingFailed => 'Sūtīšana neizdevās.';

  @override
  String get outboxEmptyTitle => 'Nav ko sūtīt';

  @override
  String get outboxEmptyText => 'Ziņojumi, ko sūtāt vēlāk, gaida šeit, līdz pienāk laiks.';

  @override
  String get outboxSendNow => 'Sūtīt tūlīt';

  @override
  String get outboxReschedule => 'Pārplānot';

  @override
  String get outboxRescheduleMenu => 'Pārplānot…';

  @override
  String get outboxRescheduleTitle => 'Pārplānot';

  @override
  String outboxRescheduled(String time) {
    return 'Pārplānots uz $time';
  }

  @override
  String get outboxCancel => 'Atcelt';

  @override
  String get outboxCancelSending => 'Atcelt sūtīšanu…';

  @override
  String get outboxCancelTitle => 'Vai atcelt sūtīšanu?';

  @override
  String get outboxMoveToDrafts => 'Pārvietot uz melnrakstiem';

  @override
  String get outboxDiscard => 'Atmest ziņojumu';

  @override
  String get outboxMovedToDrafts => 'Pārvietots uz melnrakstiem';

  @override
  String get outboxDiscarded => 'Ziņojums atmests';

  @override
  String get outboxAlreadySent => 'Jau nosūtīts.';

  @override
  String get outboxBeingSent => 'Šis ziņojums tiek sūtīts.';

  @override
  String get outboxActionFailed => 'Tas neizdevās. Ziņojums joprojām ir izsūtnē.';

  @override
  String get notificationsBadgeInboxes => 'Nelasītie iesūtnēs';

  @override
  String get notificationsBadgeVip => 'Nelasītie no VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Jauns pasts no jūsu VIP jebkurā kontā';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Jauns pasts kontā $email';
  }

  @override
  String get notificationsUnknownSender => 'Nezināms sūtītājs';

  @override
  String get notificationsNoSubject => '(Bez temata)';

  @override
  String get notificationsEncryptedMessage => 'Šifrēts ziņojums';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Jauns ziņojums: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jauni ziņojumi',
      one: '$count jauns ziņojums',
      zero: '$count jaunu ziņojumu',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Jauni ziņojumi: $account';
  }

  @override
  String get platformInstantChannel => 'Tūlītēja piegāde';

  @override
  String get platformInstantChannelDescription => 'Tiek rādīts, kamēr Loupe gaida jaunu pastu jūsu iesūtnēs';

  @override
  String get platformInstantTitle => 'Gaida jaunu pastu';

  @override
  String get platformInstantText => 'Tūlītēja piegāde ir ieslēgta';

  @override
  String get platformErrorBox => 'Parādot šo, radās kļūda. Atgriezieties un mēģiniet vēlreiz.';

  @override
  String get welcomeTagline => 'Pasts, kas virspusē ir vienkāršs,\nbet dziļumā — jaudīgs.';

  @override
  String get welcomeAccountsTitle => 'Visi konti vienā mierīgā iesūtnē';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail un jebkurš IMAP vai JMAP serveris.';

  @override
  String get welcomeSearchTitle => 'Meklēšana, kas atrod';

  @override
  String get welcomeSearchText => 'Tūlītēji rezultāti jūsu tālrunī, pēc tam no servera.';

  @override
  String get welcomePrivacyTitle => 'Privāts pēc būtības';

  @override
  String get welcomePrivacyText => 'Nekādas izsekošanas. Attālie attēli paliek bloķēti, līdz jūs tos atļaujat.';

  @override
  String get welcomeAddAccount => 'Pievienot kontu';

  @override
  String get welcomeImport => 'Importēt no Thunderbird';

  @override
  String get welcomeTryDemo => 'Izmēģināt ar demonstrācijas pastu';
}
