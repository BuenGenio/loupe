// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get commonAdd => 'Tilføj';

  @override
  String get commonCancel => 'Annuller';

  @override
  String get commonClose => 'Luk';

  @override
  String get commonDelete => 'Slet';

  @override
  String get commonDone => 'Færdig';

  @override
  String get commonEdit => 'Redigér';

  @override
  String get commonMore => 'Mere';

  @override
  String get commonMove => 'Flyt';

  @override
  String get commonName => 'Navn';

  @override
  String get commonNone => 'Ingen';

  @override
  String get commonOff => 'Fra';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Til';

  @override
  String get commonOptional => 'Valgfrit';

  @override
  String get commonPassword => 'Adgangskode';

  @override
  String get commonRemove => 'Fjern';

  @override
  String get commonRetry => 'Prøv igen';

  @override
  String get commonSave => 'Gem';

  @override
  String get commonSearch => 'Søg';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Indstillinger';

  @override
  String get commonShare => 'Del';

  @override
  String get commonTryAgain => 'Prøv igen';

  @override
  String get commonUndo => 'Fortryd';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count beskeder', one: '1 besked');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkivér';

  @override
  String get mailDelete => 'Slet';

  @override
  String get mailFlag => 'Flag';

  @override
  String get mailForward => 'Videresend';

  @override
  String get mailMarkAsRead => 'Markér som læst';

  @override
  String get mailMarkAsUnread => 'Markér som ulæst';

  @override
  String get mailMoveToJunk => 'Flyt til Uønsket';

  @override
  String get mailNewMessage => 'Ny besked';

  @override
  String get mailNoSubject => 'Intet emne';

  @override
  String get mailReply => 'Svar';

  @override
  String get mailReplyAll => 'Svar alle';

  @override
  String get mailSend => 'Send';

  @override
  String get mailUnflag => 'Fjern flag';

  @override
  String get mailboxArchive => 'Arkiv';

  @override
  String get mailboxDrafts => 'Kladder';

  @override
  String get mailboxInbox => 'Indbakke';

  @override
  String get mailboxJunk => 'Uønsket';

  @override
  String get mailboxOutbox => 'Udbakke';

  @override
  String get mailboxSent => 'Sendt';

  @override
  String get mailboxTrash => 'Papirkurv';

  @override
  String get conversationSomethingWentWrong => 'Noget gik galt. Prøv igen.';

  @override
  String get conversationReplyToList => 'Svar til listen';

  @override
  String get conversationReplyList => 'Svar liste';

  @override
  String get conversationThreadMuted => 'Lyden er slået fra for tråden. Nye beskeder i den kommer som læste.';

  @override
  String get conversationThreadUnmuted => 'Lyden er slået til for tråden.';

  @override
  String get conversationLinkFailed => 'Linket kunne ikke åbnes.';

  @override
  String get conversationGoneTitle => 'Ingen besked';

  @override
  String get conversationGoneText => 'Beskeden er blevet flyttet eller slettet.';

  @override
  String get conversationMuted => 'Lydløs';

  @override
  String get conversationReaderOptions => 'Læseindstillinger';

  @override
  String get conversationReaderOptionsHint => 'Tekststørrelse og visning';

  @override
  String get conversationTrash => 'Papirkurv';

  @override
  String get conversationReplyHint => 'Tryk længe for Svar alle og Videresend';

  @override
  String get conversationOfflineTitle => 'Du er offline';

  @override
  String get conversationOfflineText => 'Samtalen er ikke hentet endnu. Den indlæses, når du er online igen.';

  @override
  String get conversationErrorTitle => 'Beskeden kan ikke vises';

  @override
  String get conversationErrorText => 'Noget gik galt.';

  @override
  String get conversationOfflineBanner => 'Du er offline';

  @override
  String get conversationNotUpdated => 'Ikke opdateret';

  @override
  String get conversationMe => 'mig';

  @override
  String get conversationNoSender => '(ingen afsender)';

  @override
  String get conversationNoRecipients => 'ingen modtagere';

  @override
  String conversationRecipients(String names) {
    return 'til $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'til $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Fra';

  @override
  String get conversationHeaderTo => 'Til';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Svar til';

  @override
  String get conversationHeaderDate => 'Dato';

  @override
  String get conversationHeaderSecurity => 'Sikkerhed';

  @override
  String get conversationVerifiedSender => 'Bekræftet afsender';

  @override
  String get conversationUnverifiedSender => 'Ikke-bekræftet afsender';

  @override
  String get conversationLoadingMessage => 'Indlæser besked';

  @override
  String get conversationBodyError => 'Beskeden kunne ikke indlæses.';

  @override
  String get conversationBodyOffline => 'Du er offline. Beskeden indlæses, når du er online igen.';

  @override
  String get conversationOriginalHint => 'Ser bedre ud i visningen Original';

  @override
  String get conversationShowOriginal => 'Vis original';

  @override
  String get conversationScrollToTop => 'Rul til toppen';

  @override
  String get conversationTagsMenu => 'Mærkater…';

  @override
  String get conversationMuteThread => 'Slå lyden fra for tråden';

  @override
  String get conversationUnmuteThread => 'Slå lyden til for tråden';

  @override
  String get conversationMoveMenu => 'Flyt…';

  @override
  String get conversationDeletePermanently => 'Slet permanent';

  @override
  String get conversationMoveToTrash => 'Flyt til papirkurven';

  @override
  String get conversationNotJunk => 'Ikke uønsket';

  @override
  String get conversationShowAllHeaders => 'Vis alle headerfelter';

  @override
  String get conversationViewSource => 'Vis kilde';

  @override
  String get conversationSaveAsFile => 'Gem som fil…';

  @override
  String get conversationShareAsFile => 'Del som fil…';

  @override
  String get conversationSearchFromMessageMenu => 'Søg ud fra denne besked…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiér adresse';

  @override
  String get conversationAddressCopied => 'Adressen er kopieret';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Søg efter beskeder fra $name';
  }

  @override
  String get conversationTags => 'Mærkater';

  @override
  String get conversationAllHeaders => 'Alle headerfelter';

  @override
  String get conversationCopyAll => 'Kopiér alt';

  @override
  String get conversationHeadersCopied => 'Headerfelterne er kopieret';

  @override
  String get conversationNoHeaders => 'Ingen headerfelter';

  @override
  String get conversationSearchFromMessageTitle => 'Søg ud fra denne besked';

  @override
  String conversationSearchFrom(String name) {
    return 'Fra $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Til $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Emne »$subject«';
  }

  @override
  String get conversationSourceTitle => 'Kilde';

  @override
  String get conversationSourceCopied => 'Kilden er kopieret';

  @override
  String get conversationShareFailed => 'Beskeden kunne ikke deles.';

  @override
  String get conversationWrapLines => 'Ombryd linjer';

  @override
  String get conversationDontWrapLines => 'Ombryd ikke linjer';

  @override
  String get conversationSourceError => 'Kilden kunne ikke indlæses.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Viser de første $shown af $total. Kopiér eller del for at få det hele.';
  }

  @override
  String get conversationAttachmentUntitled => 'Unavngivet';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Flere handlinger for $name';
  }

  @override
  String get conversationMoveTo => 'Flyt til…';

  @override
  String get conversationMailboxesError => 'Postkasserne kunne ikke indlæses.';

  @override
  String get conversationReaderReadable => 'Læsbar';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Ren tekst';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Behold de originale farver';

  @override
  String get conversationReaderRemember => 'Husk for denne afsender';

  @override
  String get conversationSecurityPossiblePhishing => 'Mulig phishing';

  @override
  String get conversationSecurityBeCareful => 'Vær forsigtig';

  @override
  String get conversationSecurityVerified => 'Bekræftet';

  @override
  String get conversationSecurityNoIssues => 'Ingen problemer fundet';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count trackere', one: '1 tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Viser hvorfor';

  @override
  String get conversationPhishingBannerTitle => 'Denne besked ligner phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Links og billeder er slået fra.';
  }

  @override
  String get conversationPhishingBannerText => 'Links og billeder er slået fra.';

  @override
  String get conversationPhishingWhy => 'Hvorfor?';

  @override
  String get conversationPhishingShowAnyway => 'Vis alligevel';

  @override
  String get conversationSecurityPhishingTitle => 'Det her ligner phishing';

  @override
  String get conversationSecurityPhishingText => 'Flere tegn tyder på, at beskeden ikke er det, den udgiver sig for.';

  @override
  String get conversationSecurityCarefulTitle => 'Vær forsigtig med denne besked';

  @override
  String get conversationSecurityCarefulText => 'Der er noget ved den, som fortjener et ekstra kig.';

  @override
  String get conversationSecurityVerifiedText => 'Afsenderen er bekræftet, og intet ser mistænkeligt ud.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Intet ser mistænkeligt ud. Din mailserver oplyste ikke, om afsenderen er bekræftet.';

  @override
  String get conversationSecurityNothingSuspicious => 'Intet ser mistænkeligt ud.';

  @override
  String get conversationSecurityWhy => 'Hvorfor';

  @override
  String get conversationSecurityPrivacy => 'Privatliv';

  @override
  String get conversationSecurityNoTrackingPixels => 'Ingen sporingspixels';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporingspixels fjernet',
      one: '1 sporingspixel fjernet',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'De ville have fortalt afsenderen, når du åbnede denne besked.';

  @override
  String get conversationSecurityNoRemoteImages => 'Ingen eksterne billeder';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eksterne billeder',
      one: '1 eksternt billede',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Hvis de indlæses, får afsenderen at vide, hvornår du læser beskeden, og hvad din IP-adresse er.';

  @override
  String get conversationSecurityNoClickTracking => 'Ingen kliksporing';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links via kliksporing',
      one: '1 link via kliksporing',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services ville registrere dit klik. Tryk længe på et link for at åbne destinationen direkte.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tekniske detaljer';

  @override
  String get conversationSecurityCheckedLocally => 'Tjekket på denne enhed. Intet blev sendt nogen steder hen.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackere';

  @override
  String get conversationSecurityImagesFrom => 'Billeder fra';

  @override
  String get conversationSecuritySenderHistory => 'Afsenderhistorik';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received modtaget, $sent sendt';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Links fører til';

  @override
  String get conversationSecurityHidden => 'Skjult';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements elementer', one: '1 element');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters tegn');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Afsenderen er ikke bekræftet';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Din mailserver kunne ikke bekræfte, at beskeden virkelig kommer fra $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Din mailserver kunne ikke bekræfte, at beskeden virkelig kommer fra afsenderen.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Din mailserver kunne ikke bekræfte, at beskeden kommer fra $domain. Det er almindeligt for mailinglister.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Din mailserver kunne ikke bekræfte, at beskeden kommer fra afsenderen. Det er almindeligt for mailinglister.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Gør ikke, hvad den beder om, medmindre du ventede den. Kontakt afsenderen på en anden måde, hvis du er i tvivl.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signeret af et andet domæne';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Beskeden er signeret af $signer, ikke $domain. Det gør mailtjenester, men det beviser ikke, hvem der har skrevet den.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Beskeden er signeret af et andet domæne, ikke $domain. Det gør mailtjenester, men det beviser ikke, hvem der har skrevet den.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Navnet viser en anden adresse';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Afsenderens navn lyder »$shown«, men beskeden kommer fra $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Stol på adressen, ikke på navnet.';

  @override
  String get conversationSecurityReplyToTitle => 'Svar går et andet sted hen';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Hvis du svarer, sendes dit svar til $address, ikke til $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Tjek adressen, før du svarer med noget personligt.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Bruger dit navn';

  @override
  String get conversationSecurityImpersonationTitle => 'Bruger navnet på en, du kender';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Den er underskrevet »$name« ligesom dit eget navn, men kommer fra en ny adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Den er underskrevet »$name« ligesom din VIP $knownName ($knownEmail), men kommer fra en ny adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Den er underskrevet »$name« ligesom $knownName ($knownEmail), men kommer fra en ny adresse: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Og svar ville gå til endnu en anden adresse.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Hvis den beder om penge, koder eller filer, så tjek det med personen på en anden måde først.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Kendt adresse: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Denne adresse: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Første besked fra denne afsender';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Du har ikke fået mail fra $email før.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Vær forsigtig med anmodninger fra folk, du ikke kender endnu.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Forvekslelige bogstaver i afsenderens adresse';

  @override
  String get conversationSecurityLinkHomographTitle => 'Forvekslelige bogstaver i et link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host blander bogstaver fra forskellige alfabeter for at efterligne en anden adresse.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host bruger forvekslelige bogstaver: det er ikke $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Slet den, eller rapportér den som uønsket.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Åbn det ikke.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domæne: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domæne, der efterligner et andet';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Bruger et kendt navn i sit domæne';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain ligner dit eget domæne, $real, men er et andet domæne.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain ligner $brand ($real), men er et andet domæne.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain bruger navnet på dit eget domæne, $real, men hører ikke til det.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain bruger navnet $brand ($real), men hører ikke til det.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Ægte beskeder fra din organisation kommer fra $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Ægte beskeder fra $brand kommer fra $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Afsenderdomæne: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Efterligner: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links skjuler, hvor de fører hen',
      one: 'Et link skjuler, hvor det fører hen',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Et link viser $shown, men åbner $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Log ikke ind, og betal ikke via disse links. Skriv selv adressen i stedet.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '»$text« → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Et links destination kan ikke tjekkes';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Et link viser $shown, men går via $host, som registrerer klikket, før det sendes videre.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Et link peger på en ren IP-adresse';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts er ikke et navngivet websted. Rigtige virksomheder linker sjældent sådan.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Et forklædt link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Et link starter med »$shown@« for at ligne $shown, men åbner $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'En skjult side blev slået fra';

  @override
  String get conversationSecurityDataLinkText =>
      'Et link ville have åbnet en side pakket ind i beskeden, en måde at omgå linktjek på.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Beder om en adgangskode';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Beskeden indeholdt et felt til adgangskode. Loupe har fjernet det.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Skriv aldrig en adgangskode i en mail.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Et link, der kører kode, blev slået fra';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe kører aldrig kode fra beskeder.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Forkortede links',
      one: 'Et forkortet link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skjuler den rigtige destination, indtil du åbner den.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'International webadresse';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts bruger ikke-latinske bogstaver. Det er normalt for mange sprog; tjek, at det er det websted, du forventer.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Meget skjult tekst';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tegn usynlig tekst blev fjernet. Skjult tekst som denne skal narre spamfiltre.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skjult tekst fjernet';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tegn usynlig tekst blev fjernet.');
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Beskeden kunne ikke hentes. Tjek forbindelsen, og prøv igen.';

  @override
  String exportSaved(String name) {
    return '»$name« er gemt';
  }

  @override
  String get exportSaveFailed => 'Beskeden kunne ikke gemmes.';

  @override
  String exportFailed(String folder) {
    return '»$folder« kunne ikke eksporteres.';
  }

  @override
  String exportEmpty(String folder) {
    return '»$folder« har ingen beskeder at eksportere.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '»$folder« kunne ikke eksporteres: ingen beskeder kunne hentes. Tjek forbindelsen, og prøv igen.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '»$name« er gemt uden $formattedCount beskeder, der ikke kunne hentes.',
      one: '»$name« er gemt uden 1 besked, der ikke kunne hentes.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '»$name« kunne ikke gemmes.';
  }

  @override
  String exportTitle(String folder) {
    return 'Eksporterer »$folder«';
  }

  @override
  String get exportListing => 'Finder beskeder…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksporterer $current af $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount beskeder kunne ikke hentes',
      one: '1 besked kunne ikke hentes',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postkasser';

  @override
  String get mailboxesShown => 'Vises';

  @override
  String get mailboxesHidden => 'Skjult';

  @override
  String get mailboxesCollapse => 'Fold sammen';

  @override
  String get mailboxesExpand => 'Fold ud';

  @override
  String get mailboxesManageVips => 'Administrér VIP’er';

  @override
  String get mailboxesSubscriptions => 'Abonnementer';

  @override
  String mailboxesShowAccount(String account) {
    return 'Vis $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Skjul $account';
  }

  @override
  String get mailboxesExportFolder => 'Eksportér mappe…';

  @override
  String get mailboxesUnpin => 'Frigør';

  @override
  String get mailboxesLists => 'Lister';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Gem en søgning for at have den her.';

  @override
  String get mailboxesTags => 'Mærkater';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Du kan også trykke på en afsenders navn i en besked og slå VIP til.';

  @override
  String get mailboxesAddVip => 'Tilføj VIP…';

  @override
  String get mailboxesAddVipTitle => 'Tilføj VIP';

  @override
  String get mailboxesAddVipText => 'Mail fra denne adresse får en stjerne og vises i VIP-postkassen.';

  @override
  String get mailboxesAddVipPlaceholder => 'navn@example.com';

  @override
  String get messageListFilterUnread => 'Ulæste';

  @override
  String get messageListFilterFlagged => 'Flagede';

  @override
  String get messageListFilterToMe => 'Til: mig';

  @override
  String get messageListFilterCcMe => 'Cc: mig';

  @override
  String get messageListFilterWithAttachments => 'Med vedhæftede filer';

  @override
  String get messageListFilterUnreplied => 'Ubesvarede';

  @override
  String get messageListFilterFromVips => 'Fra VIP’er';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er markeret som læst',
      one: '1 besked er markeret som læst',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Ældre mail kunne ikke indlæses.';

  @override
  String get messageListSelectMessages => 'Vælg beskeder';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count valgt');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Vælg alle';

  @override
  String get messageListDeselectAll => 'Fravælg alle';

  @override
  String get messageListLoadFailed => 'Mail kunne ikke indlæses';

  @override
  String get messageListNoUnread => 'Ingen ulæst mail';

  @override
  String get messageListNoMatches => 'Ingen mail matcher';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtreret efter: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Slå filter fra';

  @override
  String get messageListEmpty => 'Ingen mail';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filterkriterier: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtreret efter:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ulæste',
      one: '$formattedCount ulæst',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markér';

  @override
  String get messageListTrash => 'Papirkurv';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'MEDTAG';

  @override
  String get panesHideMailboxes => 'Skjul postkasser';

  @override
  String get panesShowMailboxes => 'Vis postkasser';

  @override
  String get panesMailboxesWidth => 'Bredde på postkasser';

  @override
  String get panesListWidth => 'Bredde på beskedliste';

  @override
  String get panesNoMessageSelected => 'Ingen besked valgt';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count beskeder', one: '1 besked');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Udsat';

  @override
  String get snoozeSheetTitle => 'Udsæt';

  @override
  String get snoozeLaterToday => 'Senere i dag';

  @override
  String get snoozeThisEvening => 'I aften';

  @override
  String get snoozeTomorrow => 'I morgen';

  @override
  String get snoozeThisWeekend => 'I weekenden';

  @override
  String get snoozeNextWeek => 'Næste uge';

  @override
  String get snoozePickDateTime => 'Vælg dato og tidspunkt…';

  @override
  String get snoozeMenu => 'Udsæt…';

  @override
  String get snoozeWakeNow => 'Hent tilbage nu';

  @override
  String get snoozeChangeTimeMenu => 'Skift tidspunkt for udsættelse…';

  @override
  String get snoozeChangeTime => 'Skift tidspunkt';

  @override
  String get snoozeNoTime => 'Intet tidspunkt angivet';

  @override
  String get snoozeFooter => 'Udsatte beskeder kommer tilbage til indbakken som ulæste på det valgte tidspunkt.';

  @override
  String get snoozeEmptyTitle => 'Intet udsat';

  @override
  String get snoozeEmptyText => 'Udsæt en besked, så den kommer tilbage til indbakken, når du har brug for den.';

  @override
  String get appLockUnlock => 'Lås op';

  @override
  String get appLockFailed => 'Loupe kunne ikke bekræfte, at det er dig.';

  @override
  String get appLockLockedOut => 'For mange forsøg. Prøv igen senere.';

  @override
  String get appLockPromptError => 'Dialogen kunne ikke vises. Prøv igen.';

  @override
  String get appLockNoScreenLock => 'Denne telefon har ingen skærmlås.';

  @override
  String get appLockUnlockPromptTitle => 'Lås Loupe op';

  @override
  String get appLockUnlockPromptReason => 'Bekræft, at det er dig, for at se din mail.';

  @override
  String get appLockTurnOnPromptTitle => 'Slå Applås til';

  @override
  String get appLockTurnOnPromptReason => 'Bekræft, at det er dig, for at slå Applås til.';

  @override
  String get appLockScreenLockRemoved =>
      'Applås er slået fra: telefonen har ikke længere en skærmlås. Konfigurer en for at slå Applås til igen.';

  @override
  String get appLockAfterImmediately => 'Med det samme';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutter', one: '1 minut');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count timer', one: '1 time');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Krypteret';

  @override
  String get openpgpEncryptedInPart => 'Delvist krypteret';

  @override
  String get openpgpEncryptedLocked => 'Krypteret · låst';

  @override
  String get openpgpEncryptedNoKey => 'Krypteret · ingen nøgle';

  @override
  String get openpgpEncryptedDamaged => 'Krypteret · beskadiget';

  @override
  String get openpgpEncryptedUnsupported => 'Krypteret · understøttes ikke';

  @override
  String get openpgpUnknownSigner => 'ukendt';

  @override
  String get openpgpUnknownKey => 'Ukendt nøgle';

  @override
  String get openpgpSignatureInvalid => 'Ugyldig signatur';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signeret af $name, ikke afsenderen';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Delvist signeret af $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signeret af $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signeret med en afvist nøgle';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signeret af $name · nøglen er ikke godkendt';
  }

  @override
  String get openpgpUnlock => 'Lås op';

  @override
  String get openpgpCantDecrypt => 'Beskeden kan ikke dekrypteres';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Krypteret med OpenPGP';

  @override
  String get openpgpEncryption => 'Kryptering';

  @override
  String get openpgpDecryptedHere => 'Dekrypteret på denne enhed';

  @override
  String get openpgpNotDecrypted => 'Ikke dekrypteret';

  @override
  String get openpgpKeyLocked => 'Din nøgle er låst.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Til nøglerne $keys',
      one: 'Til nøglen $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Beskyttet emne';

  @override
  String get openpgpUnlockKey => 'Lås nøgle op';

  @override
  String get openpgpSignature => 'Signatur';

  @override
  String get openpgpFingerprint => 'Fingeraftryk';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Nøgle-id $id';
  }

  @override
  String get openpgpSigned => 'Signeret';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Godkendelse';

  @override
  String get openpgpChangeAcceptance => 'Skift godkendelse…';

  @override
  String get openpgpCheckedFooter => 'Tjekket på denne enhed med OpenPGP, kompatibelt med Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Din nøgle er låst. Lås den op med dens adgangsfrase for at læse beskeden.';

  @override
  String get openpgpSummaryNoSecretKey => 'Den blev krypteret til en nøgle, der ikke findes på denne enhed.';

  @override
  String get openpgpSummaryDamaged => 'De krypterede data er beskadigede eller blev ændret undervejs.';

  @override
  String get openpgpSummaryUnsupported => 'Den bruger en algoritme, som Loupe ikke understøtter.';

  @override
  String get openpgpSummaryEncrypted => 'Kun du og de andre modtagere kan læse den.';

  @override
  String get openpgpSummaryNotSigned => 'Den er ikke signeret, så afsenderen er ikke bekræftet.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Den er signeret, men med en nøgle, du ikke har, så signaturen kan ikke tjekkes.';

  @override
  String get openpgpSummaryBadSignature => 'Signaturen passer ikke: beskeden kan være blevet ændret.';

  @override
  String get openpgpSummaryMismatch => 'Signaturen er gyldig, men nøglen tilhører en anden adresse end afsenderens.';

  @override
  String get openpgpSummaryPartial =>
      'Kun en del af beskeden er signeret. Tekst uden for signaturen (f.eks. en sidefod fra en mailingliste) vises under linjen »Unsigned content«, og andre dele af beskeden, såsom vedhæftede filer, er heller ikke dækket.';

  @override
  String get openpgpSummaryOwnKey => 'Signeret med din egen nøgle.';

  @override
  String get openpgpSummaryVerified => 'Signaturen er gyldig, og du har verificeret nøglens fingeraftryk.';

  @override
  String get openpgpSummaryUnverified => 'Signaturen er gyldig. Du godkendte nøglen uden at tjekke dens fingeraftryk.';

  @override
  String get openpgpSummaryRejected => 'Signaturen er gyldig, men du har afvist denne nøgle.';

  @override
  String get openpgpSummaryUndecided =>
      'Signaturen er gyldig, men du har ikke godkendt nøglen endnu. Sammenlign dens fingeraftryk med afsenderen.';

  @override
  String get openpgpAcceptanceRejected => 'Afvist';

  @override
  String get openpgpAcceptanceUndecided => 'Ikke godkendt';

  @override
  String get openpgpAcceptanceUnverified => 'Godkendt';

  @override
  String get openpgpAcceptanceVerified => 'Godkendt og verificeret';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Vil du godkende nøglen fra $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingeraftryk $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ja, jeg har verificeret fingeraftrykket';

  @override
  String get openpgpAcceptUnverified => 'Ja, uden at tjekke';

  @override
  String get openpgpAcceptLater => 'Ikke endnu';

  @override
  String get openpgpRejectKey => 'Afvis denne nøgle';

  @override
  String get openpgpNoSubject => '(intet emne)';

  @override
  String get openpgpEncryptionTitle => 'End-to-end-kryptering';

  @override
  String get openpgpMyKeys => 'Mine OpenPGP-nøgler';

  @override
  String get openpgpMyKeysFooter =>
      'Med en nøgle kan du læse krypteret mail og signere og kryptere din egen. Bruger du Thunderbird? Eksportér din nøgle der (Kontoindstillinger › End-to-end-kryptering › Eksportér hemmelig nøgle), og importér den her.';

  @override
  String get openpgpAddKey => 'Tilføj nøgle…';

  @override
  String get openpgpAddresses => 'Adresser';

  @override
  String get openpgpAddressesFooter => 'Hvilken nøgle hver adresse bruger, og hvornår den krypterer og signerer.';

  @override
  String get openpgpCorrespondentsKeys => 'Korrespondenters OpenPGP-nøgler';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Godkend en nøgle, når du stoler på, at den tilhører sin ejer; sammenlign fingeraftrykket med ejeren for at markere den som verificeret.';

  @override
  String get openpgpImportPublicKey => 'Importér offentlig nøgle…';

  @override
  String get openpgpCollected => 'Indsamlet via Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Nøgler, der er kommet med beskeder. Loupe kan kryptere til dem, når begge parter beder om det.';

  @override
  String get openpgpOnThisDevice => 'På denne enhed';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Krypterede beskeder skjuler deres emne. Loupe gemmer emnet på hver besked, du åbner, i sin krypterede database på denne enhed, så listen, søgning og notifikationer kan vise det. I baggrunden kan Loupe også dekryptere emnet på nye beskeder med nøgler uden adgangsfrase; den henter hver besked (op til 1 MB) for at gøre det.';

  @override
  String get openpgpDecryptSubjects => 'Dekryptér emner i baggrunden';

  @override
  String get openpgpIndexFooter =>
      'Søgning finder krypterede beskeder ud fra afsender, modtagere og emne. Når dette er slået til, føjer Loupe også teksten fra hver krypteret besked, den dekrypterer, til søgeindekset i sin krypterede database på denne enhed, så søgning også finder den ud fra teksten. Hvis du slår det fra, fjernes teksten fra indekset.';

  @override
  String get openpgpIndexDecrypted => 'Indeksér dekrypterede beskeder til søgning';

  @override
  String get openpgpPassphrases => 'Adgangsfraser';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-nøgler og S/MIME-certifikater, som du beskytter med en adgangsfrase, låses op, når der er brug for dem. Uden »Husk« låses de igen to minutter efter hver brug.';

  @override
  String get openpgpRememberPassphrases => 'Husk adgangsfraser';

  @override
  String get openpgpRememberPassphrasesDetail => 'Indtil Loupe lukkes';

  @override
  String get openpgpLockKeysNow => 'Lås nøgler nu';

  @override
  String get openpgpKeysLocked => 'Nøglerne er låst.';

  @override
  String get openpgpKeyStateRevoked => 'tilbagekaldt';

  @override
  String get openpgpKeyStateExpired => 'udløbet';

  @override
  String get openpgpKeyStateNeverExpires => 'udløber aldrig';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'udløber $date';
  }

  @override
  String get openpgpNoKey => 'Ingen nøgle';

  @override
  String get openpgpAlwaysEncrypt => 'Kryptér altid';

  @override
  String get openpgpAddKeyTitle => 'Tilføj en OpenPGP-nøgle';

  @override
  String get openpgpAddKeyMessage => 'Importér den nøgle, du bruger i Thunderbird, eller lav en ny.';

  @override
  String get openpgpImportFromClipboard => 'Importér fra udklipsholder';

  @override
  String get openpgpImportFromFile => 'Importér fra fil';

  @override
  String get openpgpGenerateNewKey => 'Generér ny nøgle';

  @override
  String get openpgpImportPublicKeyTitle => 'Importér en offentlig nøgle';

  @override
  String get openpgpFromClipboard => 'Fra udklipsholder';

  @override
  String get openpgpFromFile => 'Fra fil';

  @override
  String get openpgpClipboardEmpty => 'Udklipsholderen er tom. Kopiér nøglen først.';

  @override
  String get openpgpKey => 'Nøgle';

  @override
  String get openpgpValidityRevoked => 'Tilbagekaldt';

  @override
  String openpgpValidityExpired(String date) {
    return 'Udløb $date';
  }

  @override
  String get openpgpNeverExpires => 'Udløber aldrig';

  @override
  String openpgpValidUntil(String date) {
    return 'Gyldig til $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingeraftrykket er kopieret.';

  @override
  String get openpgpAlgorithm => 'Algoritme';

  @override
  String get openpgpCreated => 'Oprettet';

  @override
  String get openpgpValidity => 'Gyldighed';

  @override
  String get openpgpProtection => 'Beskyttelse';

  @override
  String get openpgpProtectionPassphrase => 'Adgangsfrase';

  @override
  String get openpgpProtectionKeychain => 'Kun telefonens nøglelager';

  @override
  String get openpgpKeyDetailsFooter =>
      'Del din offentlige nøgle, så andre kan kryptere til dig. Sikkerhedskopien er din hemmelige nøgle, beskyttet af dens adgangsfrase, hvis den har en: hold den privat.';

  @override
  String get openpgpSharePublicKey => 'Del offentlig nøgle';

  @override
  String get openpgpCopyPublicKey => 'Kopiér offentlig nøgle';

  @override
  String get openpgpPublicKeyCopied => 'Den offentlige nøgle er kopieret.';

  @override
  String get openpgpBackUpSecretKey => 'Sikkerhedskopiér hemmelig nøgle';

  @override
  String get openpgpDeleteKey => 'Slet nøgle';

  @override
  String get openpgpRemoveKey => 'Fjern nøgle';

  @override
  String get openpgpBackUpTitle => 'Vil du sikkerhedskopiere den hemmelige nøgle?';

  @override
  String get openpgpBackUpProtected =>
      'Sikkerhedskopien er beskyttet af din nøgles adgangsfrase. Alle, der har begge dele, kan læse din mail.';

  @override
  String get openpgpBackUpUnprotected =>
      'Denne nøgle har ingen adgangsfrase: alle med sikkerhedskopien kan læse din mail og signere som dig.';

  @override
  String get openpgpBackUp => 'Sikkerhedskopiér';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Vil du slette din nøgle $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Vil du fjerne nøglen fra $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Mail, der er krypteret til denne nøgle, kan ikke længere læses på denne enhed, medmindre du importerer den igen.';

  @override
  String get openpgpRemoveKeyMessage => 'Du kan importere den igen senere.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-nøgle';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Tilføj en nøgle under End-to-end-kryptering for at kryptere og signere mail fra denne adresse.';

  @override
  String get openpgpGenerateAKey => 'Generér en nøgle…';

  @override
  String get openpgpSending => 'Afsendelse';

  @override
  String get openpgpSendingFooter =>
      'Automatisk kryptering slås til, når alle modtagere har en godkendt nøgle eller et betroet certifikat, eller når Autocrypt siger, at begge parter ønsker det. Krypteret mail signeres altid.';

  @override
  String get openpgpEncryptAutomatically => 'Kryptér automatisk';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nægter at sende, når en modtager ikke har nogen nøgle';

  @override
  String get openpgpSignUnencrypted => 'Signér ukrypteret mail';

  @override
  String get openpgpAttachPublicKey => 'Vedhæft min offentlige nøgle';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt sender din offentlige nøgle med hver besked, så andre apps kan kryptere til dig uden opsætning.';

  @override
  String get openpgpSendMyKey => 'Send min nøgle med mail';

  @override
  String get openpgpPreferEncryption => 'Foretræk kryptering';

  @override
  String get openpgpPreferEncryptionDetail => 'Bed andre om at kryptere, når de kan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count år', one: '1 år');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Adgangsfraserne er ikke ens.';

  @override
  String openpgpKeyReady(String id) {
    return 'Din nøgle $id er klar.';
  }

  @override
  String get openpgpNewKey => 'Ny nøgle';

  @override
  String get openpgpNewKeyFor => 'Til';

  @override
  String get openpgpYourName => 'Dit navn';

  @override
  String get openpgpAddress => 'Adresse';

  @override
  String get openpgpPassphrase => 'Adgangsfrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valgfri. Uden en beskytter telefonens nøglelager alene nøglen, og Loupe spørger aldrig. Med en spørger Loupe efter den, når der er brug for nøglen.';

  @override
  String get openpgpRepeatPassphrase => 'Gentag';

  @override
  String get openpgpExpires => 'Udløber';

  @override
  String get openpgpExpiresFooter => 'Du kan lave en ny nøgle, før den udløber. Thunderbird bruger også tre år.';

  @override
  String get openpgpGenerateKey => 'Generér nøgle';

  @override
  String get openpgpKeyFor => 'Nøgle til';

  @override
  String get openpgpCantEncrypt => 'Kan ikke kryptere';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Der er ingen OpenPGP-nøgle til $names, og denne adresse krypterer altid. Fjern modtageren, eller importér vedkommendes nøgle under Indstillinger › End-to-end-kryptering.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Der er intet gyldigt S/MIME-certifikat til $names, og denne adresse krypterer altid. Fjern modtageren, eller importér vedkommendes certifikat under Indstillinger › End-to-end-kryptering.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Der er ingen OpenPGP-nøgle til $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Der er intet gyldigt S/MIME-certifikat til $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Send ukrypteret';

  @override
  String get openpgpCantSign => 'Kan ikke signere';

  @override
  String get openpgpCantSignMessage =>
      'Den private nøgle til dit S/MIME-certifikat findes ikke på denne enhed. Importér certifikatet igen (en .p12- eller .pfx-fil) under Indstillinger › End-to-end-kryptering.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Ingen nøgle til $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Intet certifikat til $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Nøgler fra Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Alle har en nøgle';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Alle har et certifikat';

  @override
  String get openpgpComposeEncrypt => 'Kryptér';

  @override
  String get openpgpComposeSign => 'Signér';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, skift';
  }

  @override
  String get openpgpNoKeyFound => 'Ingen OpenPGP-nøgle fundet.';

  @override
  String get openpgpImportSecretKeyTitle => 'Vil du importere en hemmelig nøgle?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Denne vedhæftede fil indeholder en hemmelig nøgle ($names). Importér den kun som din egen nøgle, hvis du selv har eksporteret den, f.eks. fra Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importér som min nøgle';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'din nøgle $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du importere $count nøgler ($names)?',
      one: 'Vil du importere nøglen fra $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importér og godkend';

  @override
  String get openpgpImportDecideLater => 'Importér, beslut senere';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'nøglen fra $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importeret: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-nøgler er vedhæftet.',
      one: 'En OpenPGP-nøgle er vedhæftet.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importér';

  @override
  String get openpgpUnlockKeyTitle => 'Lås OpenPGP-nøgle op';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Indtast adgangsfrasen til nøglen fra $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Adgangsfrasen er forkert. Prøv igen.';

  @override
  String get openpgpExplainLocked => 'Denne besked er krypteret. Lås din OpenPGP-nøgle op for at læse den.';

  @override
  String get openpgpExplainNoKey =>
      'Denne besked er krypteret, men ikke til nogen OpenPGP-nøgle på denne enhed. Hvis du læser den i Thunderbird, så importér din nøgle derfra: Indstillinger › End-to-end-kryptering.';

  @override
  String get openpgpExplainDamaged => 'Denne krypterede besked er beskadiget, så den kan ikke dekrypteres sikkert.';

  @override
  String get openpgpExplainUnsupported => 'Denne besked bruger kryptering, som Loupe ikke kan læse endnu.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Denne besked er krypteret med S/MIME, men ikke til noget certifikat på denne enhed. Importér dit certifikat (en .p12- eller .pfx-fil) under Indstillinger › End-to-end-kryptering.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Denne besked er krypteret. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Lås dit S/MIME-certifikat op for at læse den.';

  @override
  String get openpgpAttachmentGone => 'Denne vedhæftede fil er ikke længere tilgængelig.';

  @override
  String get smimeEncrypted => 'Krypteret (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Krypteret (S/MIME) · intet certifikat';

  @override
  String get smimeEncryptedDamaged => 'Krypteret (S/MIME) · beskadiget';

  @override
  String get smimeEncryptedUnsupported => 'Krypteret (S/MIME) · understøttes ikke';

  @override
  String get smimeEncryptedLocked => 'Krypteret (S/MIME) · låst';

  @override
  String get smimeUnknownSigner => 'ukendt';

  @override
  String get smimeSignatureModified => 'Ugyldig signatur: beskeden er ændret';

  @override
  String get smimeSignatureWeak => 'Usikker signatur: forældet algoritme';

  @override
  String get smimeSignatureUncheckable => 'Signaturen kan ikke tjekkes';

  @override
  String get smimeSignedCertificateMissing => 'Signeret · certifikat mangler';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signeret af $name · certifikatet er tilbagekaldt';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signeret af $name · på en anden dato';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signeret af $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signeret af $name · ugyldigt certifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signeret af $name · ikke betroet';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signeret af $name · certifikatet er udløbet';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signeret af $name · certifikatet er ikke gyldigt endnu';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signeret af $name · certifikatet er ikke til mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signeret af $name, ikke afsenderen';
  }

  @override
  String get smimeCantDecrypt => 'Beskeden kan ikke dekrypteres';

  @override
  String get smimeEncryptedWithSmime => 'Krypteret med S/MIME';

  @override
  String get smimeEncryption => 'Kryptering';

  @override
  String get smimeDecryptedHere => 'Dekrypteret på denne enhed';

  @override
  String get smimeNotDecrypted => 'Ikke dekrypteret';

  @override
  String get smimeAuthenticated => 'autentificeret';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'til $count certifikater',
      one: 'til 1 certifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatur';

  @override
  String get smimeIssuedBy => 'Udstedt af';

  @override
  String get smimeValid => 'Gyldigt';

  @override
  String smimeValidRange(String from, String to) {
    return '$from til $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-fingeraftryk';

  @override
  String get smimeSigned => 'Signeret';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Tjekker tilbagekaldelse…';

  @override
  String get smimeNotRevoked => 'Ikke tilbagekaldt';

  @override
  String get smimeRevoked => 'Tilbagekaldt';

  @override
  String get smimeRevocationUnknown => 'Ukendt, om det er tilbagekaldt';

  @override
  String smimeRevokedSince(String date) {
    return 'Siden $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Spurgte udstederen (dens tilbagekaldelsesliste), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Spurgte udstederen (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Stol på »$name«…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Stol på dette certifikat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Tjekket på denne enhed med S/MIME, kompatibelt med Outlook og Thunderbird; tilbagekaldelse hos certifikatudstederen.';

  @override
  String get smimeCheckedFooter =>
      'Tjekket på denne enhed med S/MIME, kompatibelt med Outlook og Thunderbird. Tilbagekaldelse tjekkes ikke (Indstillinger › End-to-end-kryptering).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vil du stole på $name til mail?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vil du stole på certifikatet fra $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Alle certifikater, som denne udsteder udsteder, bliver betroet, ligesom din virksomheds CA. Sammenlign først fingeraftrykket med ejeren:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Sammenlign først fingeraftrykket med ejeren:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Stol på';

  @override
  String get smimeSummaryNoKey => 'Den blev krypteret til et certifikat, der ikke findes på denne enhed.';

  @override
  String get smimeSummaryDamaged => 'De krypterede data er beskadigede eller blev ændret undervejs.';

  @override
  String get smimeSummaryUnsupported => 'Den bruger en algoritme, som Loupe ikke understøtter.';

  @override
  String get smimeSummaryLocked => 'Dit S/MIME-certifikat er låst.';

  @override
  String get smimeSummaryEncrypted => 'Kun du og de andre modtagere kan læse den.';

  @override
  String get smimeSummaryNotSigned => 'Den er ikke signeret, så afsenderen er ikke bekræftet.';

  @override
  String get smimeSummaryModified => 'Signaturen passer ikke: beskeden blev ændret, efter den blev signeret.';

  @override
  String get smimeSummaryUncheckable => 'Signaturen kan ikke tjekkes.';

  @override
  String get smimeSummaryNoCertificate => 'Underskriverens certifikat er ikke med i beskeden, så den kan ikke tjekkes.';

  @override
  String get smimeSummaryRevoked =>
      'Certifikatudstederen har tilbagekaldt underskriverens certifikat: signaturen kan ikke betros.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikatudstederen har tilbagekaldt underskriverens certifikat ($reason): signaturen kan ikke betros.';
  }

  @override
  String get smimeDateMismatch =>
      'Den blev signeret mere end en time fra beskedens dato: det kan være en gammel besked, der er sendt igen.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Signaturen er gyldig, og $issuer går inde for, at certifikatet tilhører afsenderen.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikatet eller en af dets udstedere er ugyldig.';

  @override
  String get smimeProblemUntrusted => 'Certifikatet kommer fra en udsteder, som Loupe ikke stoler på.';

  @override
  String get smimeProblemExpired => 'Certifikatet var udløbet.';

  @override
  String get smimeProblemNotYetValid => 'Certifikatet var ikke gyldigt endnu.';

  @override
  String get smimeProblemWrongUsage => 'Certifikatet er ikke beregnet til mail.';

  @override
  String get smimeProblemWrongAddress => 'Certifikatet tilhører en anden adresse end afsenderens.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Betroet · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ikke betroet · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Udløb $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Gyldigt fra $date';
  }

  @override
  String get smimeTrustInvalid => 'Ugyldigt';

  @override
  String get smimeTrustNotForMail => 'Ikke til mail';

  @override
  String get smimeTrustAnotherAddress => 'En anden adresse';

  @override
  String get smimeMyCertificates => 'Mine S/MIME-certifikater';

  @override
  String get smimeMyCertificatesFooter =>
      'Til S/MIME, som Outlook og mange virksomheder bruger. Importér dit certifikat med dets private nøgle (en .p12- eller .pfx-fil), eksporteret fra Outlook, Windows, macOS eller Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Til S/MIME, som Outlook og mange virksomheder bruger. Importér dit certifikat med dets private nøgle (en .p12- eller .pfx-fil), eksporteret fra Outlook, Windows, macOS eller Thunderbird, eller brug et, som din virksomhed eller du selv har installeret på denne enhed.';

  @override
  String get smimeCertificateExpired => 'udløbet';

  @override
  String smimeCertificateUntil(String date) {
    return 'til $date';
  }

  @override
  String get smimeCertificateOnDevice => 'på denne enhed';

  @override
  String get smimeImportCertificateEllipsis => 'Importér certifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Brug et certifikat fra denne enhed…';

  @override
  String get smimeCorrespondentsCertificates => 'Korrespondenters certifikater';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Indsamlet fra signeret mail, som Outlook og Thunderbird gør. Mail krypteres kun til betroede certifikater: Loupe stoler på de udstedere, som Mozilla stoler på til mail, og dem, du tilføjer.';

  @override
  String get smimeRevocation => 'Tilbagekaldelse';

  @override
  String get smimeRevocationFooter =>
      'Når du åbner signeret mail, spørger Loupe den udsteder, der har udstedt underskriverens certifikat, om det er tilbagekaldt (via udstederens OCSP-server eller tilbagekaldelsesliste). Udstederen kan så se, hvornår nogen på din internetadresse læser mail, der er signeret med det certifikat. Svarene gemmes på denne enhed, indtil de udløber. Et tilbagekaldt certifikat vises som »tilbagekaldt« i beskedens header.';

  @override
  String get smimeCheckRevocation => 'Tjek tilbagekaldelse af certifikater online';

  @override
  String get smimeTrustedAuthorities => 'Betroede udstedere';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Betroet af dig, ud over de $count, som Mozilla stoler på til mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikatudsteder';

  @override
  String get smimeImportACertificate => 'Importér et certifikat';

  @override
  String get smimeImportContactMessage =>
      'En korrespondents certifikat (.cer, .crt, .pem) eller en certifikatudsteders.';

  @override
  String get smimeFromClipboard => 'Fra udklipsholder';

  @override
  String get smimeFromFile => 'Fra fil';

  @override
  String get smimeClipboardEmpty => 'Udklipsholderen er tom. Kopiér certifikatet først.';

  @override
  String get smimeCertificate => 'Certifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Den private nøgle bliver i Androids lager for loginoplysninger, hvor din virksomhed eller du selv har installeret den: Loupe beder Android om at signere og dekryptere med den. Signeret mail signeres, når du sender den.';

  @override
  String get smimeAddresses => 'Adresser';

  @override
  String get smimeUsage => 'Til';

  @override
  String get smimeUsageNone => 'Intet, som Loupe bruger';

  @override
  String get smimeUsageSigning => 'Signering';

  @override
  String get smimeUsageEncryption => 'Kryptering';

  @override
  String get smimeUsageCertificates => 'Certifikater';

  @override
  String get smimeAlgorithm => 'Algoritme';

  @override
  String get smimeSerialNumber => 'Serienummer';

  @override
  String get smimeFingerprintCopied => 'Fingeraftrykket er kopieret.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-aftryk';

  @override
  String get smimePrivateKey => 'Privat nøgle';

  @override
  String get smimeKeyOnDevice => 'På denne enhed';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'I Loupe, med en adgangsfrase';

  @override
  String get smimeKeyInLoupe => 'I Loupe';

  @override
  String get smimeSource => 'Fra';

  @override
  String get smimeSourceSignedMail => 'Signeret mail';

  @override
  String get smimeSourceImported => 'Importeret';

  @override
  String get smimeTrustHeader => 'Tillid';

  @override
  String get smimeTrustedRoot => 'Betroet rod';

  @override
  String get smimeIssuer => 'Udsteder';

  @override
  String smimeTrustNamed(String name) {
    return 'Stol på »$name«';
  }

  @override
  String get smimeTrustThisAuthority => 'Stol på denne udsteder';

  @override
  String get smimeTrustThisCertificate => 'Stol på dette certifikat';

  @override
  String get smimeStopTrusting => 'Stop med at stole på';

  @override
  String get smimePassphrase => 'Adgangsfrase';

  @override
  String get smimePassphraseFooter =>
      'Valgfri. Med en adgangsfrase er den private nøgle også krypteret på denne enhed (Argon2id og AES-256), og Loupe beder om den for at signere og dekryptere; Husk adgangsfraser bestemmer hvor længe. Mail, du sender, signeres, idet du sender den; arbejde i baggrunden kan ikke bruge nøglen.';

  @override
  String get smimeChangePassphrase => 'Skift adgangsfrase…';

  @override
  String get smimeSetPassphraseEllipsis => 'Angiv adgangsfrase…';

  @override
  String get smimeRemovePassphrase => 'Fjern adgangsfrase';

  @override
  String get smimeShareCertificate => 'Del certifikat';

  @override
  String get smimeDeleteCertificate => 'Slet certifikat';

  @override
  String get smimeRemoveCertificate => 'Fjern certifikat';

  @override
  String get smimePassphraseChanged => 'Adgangsfrasen er skiftet.';

  @override
  String get smimePassphraseSet => 'Adgangsfrasen er angivet.';

  @override
  String get smimeRemovePassphraseTitle => 'Vil du fjerne adgangsfrasen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Den private nøgle beskyttes så kun af nøglelageret, som uden adgangsfrase: Loupe spørger ikke længere efter den, og arbejde i baggrunden kan bruge den.';

  @override
  String get smimePassphraseRemoved => 'Adgangsfrasen er fjernet.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vil du stole på $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Alle certifikater, den udsteder, bliver betroet til mail. Sammenlign først fingeraftrykket med ejeren:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Vil du slette dit certifikat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Vil du fjerne certifikatet fra $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe holder op med at bruge det: mail, der er krypteret til det, kan ikke længere læses i Loupe. Certifikatet bliver på denne enhed (Indstillinger › Sikkerhed › Kryptering og loginoplysninger).';

  @override
  String get smimeDeleteOwnMessage =>
      'Den private nøgle slettes fra denne enhed: mail, der er krypteret til den, kan ikke længere læses her, medmindre du importerer den igen.';

  @override
  String get smimeRemoveContactMessage => 'Det kommer tilbage med vedkommendes næste signerede besked.';

  @override
  String get smimeAddressImportFooter =>
      'Importér et certifikat til denne adresse for at signere og kryptere med S/MIME, som Outlook gør.';

  @override
  String get smimeImportACertificateEllipsis => 'Importér et certifikat…';

  @override
  String get smimePreferFooter =>
      'Når begge kan beskytte en besked, bruges den foretrukne, medmindre kun den anden har en nøgle eller et certifikat til alle modtagere.';

  @override
  String get smimePreferSmime => 'Foretræk S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Frem for OpenPGP';

  @override
  String get smimeCertificatePassword => 'Adgangskode til certifikat';

  @override
  String get smimeCertificatePasswordPrompt => 'Indtast den adgangskode, certifikatfilen blev eksporteret med.';

  @override
  String get smimeImport => 'Importér';

  @override
  String get smimeWrongPassword => 'Adgangskoden er forkert. Prøv igen.';

  @override
  String get smimeNoCertificateFound => 'Intet certifikat fundet.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikatet fra $name';
  }

  @override
  String get smimeNothingNew => 'Intet nyt at importere.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importeret: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerede $count betroede udstedere.',
      one: 'Importerede en betroet udsteder.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerede $certificates og $count betroede udstedere.',
      one: 'Importerede $certificates og en betroet udsteder.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Denne fil har ingen privat nøgle. Eksportér dit certifikat med dets private nøgle.';

  @override
  String get smimeImportAsYoursTitle => 'Vil du importere det som dit certifikat?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Denne vedhæftede fil indeholder et certifikat med dets private nøgle: $names. Importér det kun, hvis du selv har eksporteret det, f.eks. fra Outlook eller Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importér som mit certifikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Dit certifikat $names er importeret.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Dit certifikat $name ($addresses) er tilføjet fra denne enhed.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vil du stole på »$name« til mail?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe kender ikke denne certifikatudsteder (måske en virksomheds egen). Stol på den for at tjekke de certifikater, den udsteder. Sammenlign først fingeraftrykket med din it-afdeling:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certifikater er vedhæftet.',
      one: 'Et certifikat er vedhæftet.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importér certifikat';

  @override
  String get smimeUnlockTitle => 'Lås S/MIME-certifikat op';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Indtast adgangsfrasen til certifikatet fra $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Adgangsfrasen er forkert. Prøv igen.';

  @override
  String get smimeUnlock => 'Lås op';

  @override
  String get smimeEnterAPassphrase => 'Indtast en adgangsfrase.';

  @override
  String get smimePassphrasesDiffer => 'De to adgangsfraser er forskellige.';

  @override
  String get smimeSetPassphraseTitle => 'Angiv adgangsfrase';

  @override
  String get smimeSetPassphraseText =>
      'Loupe beder om den for at signere og dekryptere. Hvis du glemmer den, så importér certifikatet igen fra dets .p12-fil.';

  @override
  String get smimePassphraseAgain => 'Igen';

  @override
  String get smimeSetPassphraseButton => 'Angiv';

  @override
  String get smimeLockedOpenAgain => 'Dit S/MIME-certifikat er låst. Åbn beskeden igen for at låse det op.';

  @override
  String get smimeDeviceHasNoCertificates => 'Denne enhed tilbyder ikke sine certifikater.';

  @override
  String get smimeCantReadCertificate => 'Loupe kan ikke læse dette certifikat.';

  @override
  String get smimeCertificateNotForMail =>
      'Dette certifikat er ikke til mail: det har ingen mailadresse eller er ikke beregnet til signering eller kryptering.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikatet findes ikke længere på denne enhed, eller Loupe må ikke længere bruge det. Vælg det igen under Indstillinger › End-to-end-kryptering.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikatet på denne enhed kan kun bruges, mens Loupe er åben.';

  @override
  String get smimeDeviceKeyDamaged => 'Den krypterede nøgle er beskadiget.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikatet på denne enhed kan ikke gøre dette: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'understøttes ikke';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikatet på denne enhed fejlede: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Udstederens adresse er ikke en webadresse.';

  @override
  String get smimeAuthorityTimeout => 'Certifikatudstederen svarede ikke i tide.';

  @override
  String get smimeAuthorityUnreachable => 'Certifikatudstederen kunne ikke nås.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikatudstederen svarede $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Certifikatudstederens svar er for stort.';

  @override
  String get smimeRevocationNotChecked =>
      'Ikke tjekket: kun certifikater fra en udsteder, som Loupe stoler på, bliver tjekket.';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLanguageSystem => 'Samme som telefonen';

  @override
  String get settingsLanguageFooter =>
      'Loupe bruger telefonens sprog, når appen har det, og ellers engelsk. Det sprog, du vælger her, gælder kun for Loupe, også notifikationer.';

  @override
  String get settingsAccountsHeader => 'Konti';

  @override
  String get settingsAddAccount => 'Tilføj konto';

  @override
  String get settingsMailHeader => 'Mail';

  @override
  String get settingsSwipeActions => 'Swipe-handlinger';

  @override
  String get settingsSwipeLeft => 'Swipe til venstre';

  @override
  String get settingsSwipeLeftFooter =>
      'Et helt swipe udfører denne handling. Flag og Mere er altid et kort swipe væk.';

  @override
  String get settingsSwipeRight => 'Swipe til højre';

  @override
  String get settingsSwipeRightFooter => 'Et helt swipe udfører denne handling.';

  @override
  String get settingsSwipeToggleRead => 'Markér som læst/ulæst';

  @override
  String get settingsSwipeTrash => 'Papirkurv';

  @override
  String get settingsSwipeMove => 'Flyt besked';

  @override
  String get settingsSwipeSnooze => 'Udsæt';

  @override
  String get settingsThreaded => 'Organisér efter samtale';

  @override
  String get settingsUndoSendDelay => 'Forsinkelse for fortryd afsendelse';

  @override
  String get settingsUndoSendDelayFooter => 'Sendte beskeder venter så længe, så du kan tage dem tilbage.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds sekunder', one: '1 sekund');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Udseende';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatisk';

  @override
  String get settingsThemeLight => 'Lyst';

  @override
  String get settingsThemeDark => 'Mørkt';

  @override
  String get settingsDensity => 'Beskedliste';

  @override
  String get settingsDensityComfortable => 'Luftig';

  @override
  String get settingsDensityCompact => 'Kompakt';

  @override
  String get settingsReadingHeader => 'Læsning';

  @override
  String get settingsReadingFooter => 'Eksterne billeder kan fortælle afsendere, hvornår og hvor du åbnede en besked.';

  @override
  String get settingsDefaultView => 'Standardvisning';

  @override
  String get settingsDefaultViewFooter => 'Du kan skifte visning for enhver besked med knappen Aa.';

  @override
  String get settingsViewReadable => 'Læsbar';

  @override
  String get settingsViewReadableDetail => 'Ren og overskuelig, følger mørk tilstand';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Præcis som afsenderen designede den';

  @override
  String get settingsViewPlain => 'Ren tekst';

  @override
  String get settingsViewPlainDetail => 'Kun ordene';

  @override
  String get settingsPlainTextFont => 'Skrifttype til ren tekst';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Fast bredde';

  @override
  String get settingsFontMonoDetail => 'Holder ASCII-kunst og tabeller på linje';

  @override
  String get settingsTechnicalLists => 'Tekniske lister';

  @override
  String get settingsLoadRemoteImages => 'Indlæs eksterne billeder';

  @override
  String get settingsOpenLinksDirectly => 'Åbn links direkte';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Spring kliksporing over, når destinationen er kendt';

  @override
  String get settingsSecurityHeader => 'Sikkerhed';

  @override
  String get settingsAppLock => 'Applås';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe spørger, når appen starter, og når du kommer tilbage efter at have været væk i den tid, der er angivet under Lås efter.';

  @override
  String get settingsAppLockFooterOff =>
      'Applås beder om dit fingeraftryk, dit ansigt eller din skærmlås, før din mail vises.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Applås er stadig slået fra. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Opret en adgangskode';

  @override
  String get settingsScreenLockTextIos =>
      'Applås bruger Face ID, Touch ID eller din adgangskode, og denne iPhone har ingen adgangskode. Opret en i appen Indstillinger, og slå derefter Applås til.';

  @override
  String get settingsScreenLockTitleAndroid => 'Konfigurer en skærmlås';

  @override
  String get settingsScreenLockTextAndroid =>
      'Applås bruger telefonens skærmlås eller et fingeraftryk eller ansigt, der er tilføjet til den, og denne telefon har ingen. Konfigurer en pinkode, et mønster eller en adgangskode i Androids indstillinger, og slå derefter Applås til.';

  @override
  String get settingsOpenSystemSettings => 'Åbn Indstillinger';

  @override
  String get settingsOpenAndroidSettings => 'Åbn Android-indstillinger';

  @override
  String get settingsLockAfter => 'Lås efter';

  @override
  String get settingsLockAfterFooter => 'Hvor længe Loupe må være i baggrunden, før den spørger igen.';

  @override
  String get settingsNotifications => 'Notifikationer';

  @override
  String get settingsEncryption => 'End-to-end-kryptering';

  @override
  String get settingsAdvanced => 'Avanceret';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demomail er en opdigtet postkasse, der kun findes på denne telefon. Intet sendes nogen steder hen.';

  @override
  String get settingsDemoMode => 'Demotilstand';

  @override
  String get settingsResetApp => 'Nulstil app';

  @override
  String get settingsResetFooter => 'Glemmer alle indstillinger og vender tilbage til velkomstskærmen.';

  @override
  String get settingsResetTitle => 'Vil du nulstille Loupe?';

  @override
  String get settingsResetMessage =>
      'Dette glemmer alle indstillinger, Smart Mailboxes og seneste søgninger og vender tilbage til velkomstskærmen.';

  @override
  String get settingsAboutHeader => 'Om';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicences => 'Licenser';

  @override
  String get settingsPrivacy => 'Privatliv';

  @override
  String get settingsPrivacyDetail =>
      'Loupe har ingen statistik og ingen sporing. Din mail går kun til dine mailservere.';

  @override
  String get settingsNotificationsOffIos => 'Notifikationer er slået fra for Loupe i Indstillinger.';

  @override
  String get settingsNotificationsOffAndroid => 'Notifikationer er slået fra for Loupe i Android-indstillingerne.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system lader ikke Loupe vise notifikationer. Tillad dem i Indstillinger.';
  }

  @override
  String get settingsNewMailHeader => 'Ny mail';

  @override
  String get settingsNewMailFooterDemo =>
      'Demomail kommer ikke i baggrunden. Send en testnotifikation for at se, hvordan ny mail ser ud.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe tjekker for ny mail i baggrunden, når iOS tillader det, hvilket kan være med timers mellemrum for apps, du ikke åbner tit. Du får besked om nye beskeder i dine indbakker og fra VIP’er i alle mapper.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe tjekker for ny mail cirka hvert 15. minut, når Android tillader det. Du får besked om nye beskeder i dine indbakker og fra VIP’er i alle mapper.';

  @override
  String get settingsNoAccounts => 'Ingen konti';

  @override
  String get settingsVipOnly => 'Kun VIP';

  @override
  String get settingsVipOnlyDetail => 'Kun beskeder fra dine VIP’er';

  @override
  String get settingsHideContent => 'Skjul indhold';

  @override
  String get settingsHideContentFooterOn =>
      'Notifikationer siger kun »Ny besked fra« og kontoen, ikke hvem der skrev, eller hvad det handler om.';

  @override
  String get settingsHideContentFooterOff =>
      'Skjul indhold holder afsender, emne og forhåndsvisning væk fra låseskærmen og ude af notifikationer.';

  @override
  String get settingsBackgroundAppRefresh => 'Baggrundsopdatering';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Ny mail kommer kun i baggrunden, mens Baggrundsopdatering er slået til for Loupe i Indstillinger. iOS kan ikke holde en forbindelse til dine indbakker åben, så der er ingen øjeblikkelig levering.';

  @override
  String get settingsInstantDelivery => 'Øjeblikkelig levering';

  @override
  String get settingsInstantDeliveryFooter =>
      'Øjeblikkelig levering (eksperimentel) holder en forbindelse til dine indbakker åben, så ny mail kommer inden for sekunder. Den viser en diskret notifikation, »Holder øje med ny mail«, og bruger mere batteri.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android stopper muligvis Øjeblikkelig levering for at spare på batteriet. Lad Loupe bruge batteriet uden begrænsninger for at holde den kørende.';

  @override
  String get settingsExperimental => 'Eksperimentel';

  @override
  String get settingsComingSoon => 'Kommer snart';

  @override
  String get settingsAllowUnrestrictedBattery => 'Tillad ubegrænset batteriforbrug';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push lader ny mail vække Loupe med det samme, hvor din mailtjeneste understøtter det. Push-beskeder går gennem Googles pushtjeneste og indeholder ingen mail, kun »tjek nu«.';

  @override
  String get settingsPushUnavailableFooter =>
      'Denne telefon kan ikke modtage push-beskeder: de kræver Google Play-tjenester og en netværksforbindelse. Loupe tjekker stadig for mail cirka hvert 15. minut.';

  @override
  String get settingsCopyPushToken => 'Kopiér push-token';

  @override
  String get settingsPushTokenCopied => 'Push-tokenet er kopieret';

  @override
  String get settingsSendTestNotification => 'Send testnotifikation';

  @override
  String get settingsAppIconBadge => 'Badge på appikonet';

  @override
  String get settingsBadgeNote => 'Badget opdateres, hver gang Loupe tjekker for mail, også i baggrunden.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Denne telefons startskærm viser ikke tal på appikoner. Badget opdateres, hver gang Loupe tjekker for mail, også i baggrunden.';

  @override
  String get settingsTestNotificationBody => 'Notifikationer om ny mail ser sådan ud.';

  @override
  String get settingsAccountRemoved => 'Denne konto er fjernet.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Beskrivelse';

  @override
  String get settingsAccountDescriptionHint => 'Arbejde, privat…';

  @override
  String get settingsEmail => 'Mail';

  @override
  String get settingsColour => 'Farve';

  @override
  String get settingsColourFooter => 'Markerer kontoens beskeder i Alle indbakker.';

  @override
  String settingsColourNumber(int number) {
    return 'Farve $number';
  }

  @override
  String get settingsSendingHeader => 'Afsendelse';

  @override
  String get settingsSendingFooter =>
      'Hver identitet har sin egen signatur. Svar sendes fra den adresse, beskeden blev sendt til.';

  @override
  String get settingsFoldersHeader => 'Mapper';

  @override
  String get settingsFoldersFooter =>
      'Loupe viser og synkroniserer de mapper, du abonnerer på, ligesom Thunderbird. Indbakke, Kladder, Sendt, Uønsket, Papirkurv og Arkiv vises altid.';

  @override
  String get settingsShowAllFolders => 'Vis alle mapper';

  @override
  String get settingsIncoming => 'Indgående';

  @override
  String get settingsOutgoing => 'Udgående';

  @override
  String get settingsConnectionNotEncrypted => 'Ikke krypteret';

  @override
  String get settingsSignIn => 'Login';

  @override
  String get settingsSignInExpired => 'Udløbet';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider accepterer ikke længere Loupes login for denne konto, så dens mail synkroniseres ikke. Log ind igen for at løse det.';
  }

  @override
  String get settingsSignInAgain => 'Log ind igen';

  @override
  String get settingsSigningIn => 'Logger ind…';

  @override
  String get settingsRemoveAccount => 'Fjern konto';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Vil du fjerne »$account«?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Dens mail og indstillinger fjernes fra denne telefon. Intet slettes på serveren.';

  @override
  String get settingsManageFolders => 'Administrér mapper';

  @override
  String get settingsNoFolders => 'Ingen mapper endnu.';

  @override
  String get settingsManageFoldersFooter =>
      'Mapper, du abonnerer på, vises på skærmen Postkasser og synkroniseres i baggrunden. Andre mailapps på samme konto følger som regel også disse abonnementer.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Gemmer dine Smart Mailboxes til dine andre enheder. Skjult på skærmen Postkasser.';

  @override
  String get settingsFolderAlwaysShown => 'Vises altid';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abonnér på $folder';
  }

  @override
  String get settingsIdentities => 'Identiteter';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Den første identitet er standard for nye beskeder. Træk for at ændre rækkefølgen.';

  @override
  String get settingsIdentitiesFooterSingle => 'Standardidentiteten for nye beskeder.';

  @override
  String get settingsIdentitiesReplyFooter => 'Et svar sendes fra den identitet, beskeden blev sendt til.';

  @override
  String get settingsIdentityDefault => 'Standard';

  @override
  String settingsIdentityReorder(String email) {
    return 'Flyt $email';
  }

  @override
  String get settingsAddIdentity => 'Tilføj identitet';

  @override
  String get settingsNewIdentity => 'Ny identitet';

  @override
  String get settingsIdentity => 'Identitet';

  @override
  String get settingsIdentityNameHint => 'Dit navn';

  @override
  String get settingsReplyTo => 'Svar til';

  @override
  String get settingsSignature => 'Signatur';

  @override
  String get settingsSignatureFooter => 'Tilføjes under »-- « i beskeder fra denne identitet.';

  @override
  String get settingsNoSignature => 'Ingen signatur';

  @override
  String get settingsCopyToMyself => 'Kopi til mig selv';

  @override
  String get settingsCopyToMyselfFooter => 'Tilføjes til alle beskeder fra denne identitet.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Brug til svar på';

  @override
  String get settingsReplyPatternsFooter =>
      'Svar på beskeder sendt til disse adresser sendes fra denne identitet. * står for hvad som helst: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'En adresse eller et mønster, hvor * står for hvad som helst.';

  @override
  String get settingsAddReplyPattern => 'Tilføj adresse eller mønster';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Fjern $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ugyldigt mønster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '»$input« er hverken en adresse eller et mønster som *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ingen adresse';

  @override
  String get settingsIdentityNoAddressMessage => 'Indtast den mailadresse, der skal sendes fra.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ugyldig adresse';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Svar til »$address« er ikke en gyldig mailadresse.',
      'cc': 'Cc »$address« er ikke en gyldig mailadresse.',
      'bcc': 'Bcc »$address« er ikke en gyldig mailadresse.',
      'other': '»$address« er ikke en gyldig mailadresse.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Gem identitet';

  @override
  String get settingsDiscardChanges => 'Kassér ændringer';

  @override
  String get settingsDeleteIdentity => 'Slet identitet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Vil du slette »$email«?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Beskeder, der allerede er sendt fra den, forbliver uændrede.';

  @override
  String get settingsLastIdentityFooter => 'En konto skal have mindst én identitet.';

  @override
  String get rulesTitle => 'Regler';

  @override
  String get rulesNewRule => 'Ny regel';

  @override
  String get rulesLoadError => 'Reglerne kunne ikke indlæses.';

  @override
  String get rulesEmptyTitle => 'Ingen regler';

  @override
  String get rulesEmptyText =>
      'Regler flytter, sætter mærkater på og flager ny mail for dig. Lav en med skriveknappen ovenfor eller ud fra en søgning med »Gør dette til en regel«.';

  @override
  String get rulesListFooter =>
      'Regler kører fra top til bund på ny mail i indbakken. Tryk og hold på en regel for at flytte den.';

  @override
  String get rulesChangeError => 'Reglen kunne ikke ændres';

  @override
  String get rulesConditionEveryMessage => 'Alle beskeder';

  @override
  String rulesMoveRule(String rule) {
    return 'Flyt $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule til';
  }

  @override
  String get rulesServerRulesHeader => 'Serverregler';

  @override
  String get rulesServerRulesFooter =>
      'Serverregler kører på mailserveren, når mailen ankommer, også mens denne telefon er slukket. De gemmes i et Sieve-script med navnet »loupe«.';

  @override
  String get rulesStatusUnknown => 'Ukendt';

  @override
  String get rulesStatusError => 'Serveren kunne ikke spørges.';

  @override
  String get rulesStatusChecking => 'Tjekker…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Køres fra »$script«.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '»$script« er det aktive script. Tryk for også at lade det køre Loupes regler.';
  }

  @override
  String get rulesStatusNoScript =>
      'Intet script er aktivt på serveren. Når du gemmer en serverregel, slås Loupes til.';

  @override
  String get rulesStatusUnavailable => 'Ikke tilgængelig';

  @override
  String get rulesStatusNoSieve => 'Denne kontos server tilbyder ikke Sieve (ManageSieve eller JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Flyt til $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Flyt til en mappe';

  @override
  String rulesActionTag(String tag) {
    return 'Tilføj mærkat $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Fjern mærkat $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Behold i indbakken';

  @override
  String rulesActionForward(String address) {
    return 'Videresend til $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Videresend til $address, behold ingen kopi';
  }

  @override
  String get rulesActionStop => 'Stop';

  @override
  String get rulesNoActions => 'Gør intet endnu';

  @override
  String get rulesLocationDevice => 'Enhed';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Denne enhed';

  @override
  String get rulesNewRuleTitle => 'Ny regel';

  @override
  String get rulesEditRuleTitle => 'Redigér regel';

  @override
  String get rulesDefaultNameEveryMessage => 'Alle beskeder';

  @override
  String get rulesConditionHeader => 'Når en ny besked matcher';

  @override
  String get rulesConditionFooter =>
      'Skriv det, som når du søger: from:, to:, s: (emne), b: (brødtekst), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Konti';

  @override
  String get rulesAllAccounts => 'Alle konti';

  @override
  String get rulesRemovedAccount => 'Fjernet konto';

  @override
  String get rulesAccountsFooter => 'En regel for alle konti gælder også for konti, du tilføjer senere.';

  @override
  String get rulesActionsHeader => 'Så';

  @override
  String get rulesForwardingFooter =>
      'Videresendelse sender alle matchende beskeder til en anden adresse, når de ankommer, også mens denne telefon er slukket. Nogle udbydere begrænser, hvor meget mail der må videresendes.';

  @override
  String get rulesForwardingHiddenFooter => 'Videresendelse kører kun i serverregler, så den er udeladt her.';

  @override
  String rulesRemoveAction(String action) {
    return 'Fjern $action';
  }

  @override
  String get rulesAddAction => 'Tilføj handling';

  @override
  String get rulesAddMove => 'Flyt til mappe…';

  @override
  String get rulesAddTagMenu => 'Tilføj mærkat…';

  @override
  String get rulesRemoveTagMenu => 'Fjern mærkat…';

  @override
  String get rulesAddForward => 'Videresend til…';

  @override
  String get rulesStopProcessing => 'Stop behandling af flere regler';

  @override
  String get rulesRunOnHeader => 'Kør på';

  @override
  String get rulesRunOnDeviceFooter =>
      'Denne enhed kører reglen på ny mail i indbakken, hver gang Loupe tjekker for mail.';

  @override
  String get rulesRunOnServerFooter =>
      'Mailserveren kører reglen, når mailen ankommer, også mens denne telefon er slukket. Kræver Sieve via ManageSieve (Dovecot, mailcow) eller JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Anvend på eksisterende beskeder…';

  @override
  String get rulesDeleteRule => 'Slet regel';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Vil du slette »$rule«?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mappe i hvilken konto?';

  @override
  String get rulesMoveAccountMessage => 'Mail fra de andre konti går til mappen med samme navn der.';

  @override
  String get rulesAddTag => 'Tilføj mærkat';

  @override
  String get rulesRemoveTag => 'Fjern mærkat';

  @override
  String get rulesForwardTo => 'Videresend til';

  @override
  String get rulesForwardToMessage =>
      'Serveren sender alle matchende beskeder videre til denne adresse, også mens denne telefon er slukket. Brug en adresse, du ejer eller stoler på.';

  @override
  String get rulesNotAnAddressTitle => 'Ikke en mailadresse';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '»$address« er ikke en adresse, der kan videresendes til.';
  }

  @override
  String get rulesKeepCopyTitle => 'Vil du beholde en kopi her?';

  @override
  String get rulesKeepCopy => 'Behold en kopi';

  @override
  String get rulesDontKeepCopy => 'Behold ingen kopi';

  @override
  String get rulesCheckCondition => 'Tjek betingelsen';

  @override
  String get rulesChooseActionTitle => 'Vælg en handling';

  @override
  String get rulesChooseActionMessage => 'Tilføj, hvad reglen gør med de beskeder, den matcher.';

  @override
  String get rulesSaveError => 'Reglen kunne ikke gemmes';

  @override
  String get rulesSaveServerError => 'Serverreglen kunne ikke gemmes';

  @override
  String get rulesRunOnDeviceInstead => 'Kør på denne enhed i stedet';

  @override
  String get rulesNothingToApplyTitle => 'Intet at anvende';

  @override
  String get rulesNothingToApplyMessage => 'Giv først reglen en betingelse, der virker, og en handling.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Anvend »$rule« på beskeder i…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Indbakker';

  @override
  String get rulesApplyScopeAll => 'Alle postkasser';

  @override
  String get rulesFindingMessages => 'Finder beskeder…';

  @override
  String get rulesSearchError => 'Kunne ikke søge';

  @override
  String get rulesSearchErrorUnknown => 'Noget gik galt.';

  @override
  String get rulesNoMatchesTitle => 'Ingen beskeder matcher';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Intet der matcher »$condition«.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du anvende »$rule« på $countString beskeder?',
      one: 'Vil du anvende »$rule« på $countString besked?',
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
      other: 'Anvend på $countString beskeder',
      one: 'Anvend på $countString besked',
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
      other: '»$rule« er anvendt på $countString beskeder',
      one: '»$rule« er anvendt på $countString besked',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Spørger serveren, hvad den kan…';

  @override
  String get rulesServerUnreachable => 'Serveren kunne ikke nås.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kan ikke køre på serveren: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kan ikke køre på serveren for $account: $problem';
  }

  @override
  String get rulesShowScript => 'Vis script';

  @override
  String get rulesHideScript => 'Skjul script';

  @override
  String get rulesMatchingHeader => 'Matchende beskeder';

  @override
  String get rulesMatchingHeaderLoading => 'Matchende beskeder…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString matchende beskeder',
      one: '$countString matchende besked',
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
      other: '$countString+ matchende beskeder',
      one: '$countString+ matchende besked',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Fra de sidste 30 dage. Selve reglen virker kun på ny mail, medmindre du anvender den på eksisterende beskeder.';

  @override
  String rulesConditionError(String error) {
    return 'Betingelsen har en fejl: $error';
  }

  @override
  String get rulesPreviewNoSender => '(ingen afsender)';

  @override
  String get rulesPreviewNoSubject => '(intet emne)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'og $countString mere');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Intet fra de sidste 30 dage.';

  @override
  String get rulesIncludeTitle => 'Slå serverregler til';

  @override
  String get rulesIncludeLeaveOff => 'Lad være slået fra';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serveren kører allerede Loupes regler for $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '»$script« er det aktive script på serveren for $account, så serveren kører det og ikke Loupes regler. Loupe erstatter det ikke. Den kan tilføje disse linjer til det, og serveren kører så Loupes regler efter scriptets egne:';
  }

  @override
  String get rulesShowWholeScript => 'Vis hele scriptet';

  @override
  String get rulesHideWholeScript => 'Skjul hele scriptet';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Intet andet i »$script« ændres. Hvis dets filtre senere redigeres i webmailen, kan webmailen omskrive det uden disse linjer; Loupe viser så serverregler som slået fra igen.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Tilføj til »$script«';
  }

  @override
  String get subscriptionsTitle => 'Abonnementer';

  @override
  String get subscriptionsNewsletters => 'Nyhedsbreve';

  @override
  String get subscriptionsDiscussions => 'Diskussioner';

  @override
  String get subscriptionsFilter => 'Filtrér';

  @override
  String get subscriptionsFilterNeverRead => 'Aldrig læst';

  @override
  String get subscriptionsFilterRarelyRead => 'Sjældent læst';

  @override
  String get subscriptionsFilterAll => 'Alle';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonnementer kunne ikke tælles';

  @override
  String get subscriptionsNoMatches => 'Ingen resultater';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Intet nyhedsbrev hedder »$text«.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ingen liste hedder »$text«.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Ingen nyhedsbreve';

  @override
  String get subscriptionsNoNewslettersDetail => 'Nyhedsbreve og anden massemail vises her, når de ankommer.';

  @override
  String get subscriptionsNothingNeverRead => 'Intet, du aldrig læser';

  @override
  String get subscriptionsNothingRarelyRead => 'Intet, du sjældent læser';

  @override
  String get subscriptionsNothingFilteredDetail => 'Du læser noget af alt, hvad du får.';

  @override
  String get subscriptionsNoDiscussions => 'Ingen diskussioner';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mailinglister, du kan skrive til, vises her, når deres mail ankommer.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lister, som flere personer skriver til. Tryk og hold på en for at fastgøre den til Postkasser, læse den som ren tekst eller flytte den til Nyhedsbreve.';

  @override
  String get subscriptionsPrivacyNote =>
      'Optalt på denne telefon ud fra den mail, den har hentet; intet sendes nogen steder hen for at finde ud af det. Loupe kontakter kun en afsender, når du trykker på Afmeld: Afmelding med ét klik sender kun »List-Unsubscribe=One-Click« til den adresse, afsenderen har angivet, uden cookies eller andet om dig, og indlæser aldrig deres sider eller billeder.';

  @override
  String get subscriptionsVolumeNone => 'Ingen for nylig';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / måned';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / måned';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'læst $percent';
  }

  @override
  String get subscriptionsStillSending => 'Sender stadig';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Afmeldt $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Afmeldingsside åbnet $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ét tryk · kontakter $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Via mail til $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'På webstedet $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Afmeld';

  @override
  String get subscriptionsUnsubscribeAgain => 'Afmeld igen';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arkivér $countString i indbakken');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Opret regel…';

  @override
  String get subscriptionsCreateRuleDetail => 'Flyt eller arkivér fremtidig mail fra afsenderen';

  @override
  String get subscriptionsTreatAsDiscussion => 'Behandl som diskussion';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'En liste, folk skriver til: læs den som et forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Behandl som nyhedsbrev';

  @override
  String get subscriptionsBlockSender => 'Blokér afsender';

  @override
  String get subscriptionsBlock => 'Blokér';

  @override
  String get subscriptionsBlocked => 'Blokeret';

  @override
  String get subscriptionsBlockedDetail => 'Ny mail går til Uønsket';

  @override
  String get subscriptionsPin => 'Fastgør til Postkasser';

  @override
  String get subscriptionsUnpin => 'Frigør fra Postkasser';

  @override
  String get subscriptionsOpenDefaultView => 'Åbn i standardvisning';

  @override
  String get subscriptionsOpenPlainText => 'Åbn som ren tekst (Mono)';

  @override
  String get subscriptionsPinned => 'Fastgjort';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ulæste',
      one: '$countString ulæst',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Ingen mail fra denne afsender lige nu.';

  @override
  String get subscriptionsLatestMessages => 'SENESTE BESKEDER';

  @override
  String get subscriptionsMail => 'Mail';

  @override
  String get subscriptionsNoneIn90Days => 'Ingen på 90 dage';

  @override
  String get subscriptionsRead => 'Læst';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString af $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Senest modtaget';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Mapper', one: 'Mappe');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Sender stadig';

  @override
  String get subscriptionsUnsubscribedTitle => 'Afmeldt';

  @override
  String subscriptionsSince(String date) {
    return 'siden $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'side åbnet $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender oplyser ikke, hvordan man afmelder sig.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender oplyser ikke, hvordan man afmelder sig. Du kan blokere afsenderen i stedet.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Afmelder fra $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Afmeldt fra $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Kunne ikke afmelde: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Kunne ikke afmelde automatisk';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Send afmeldingsmail';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Åbn $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Vil du åbne $site?';
  }

  @override
  String get subscriptionsOpen => 'Åbn';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender afmelder på sit websted. Siden åbnes i Loupes browser; gør det færdigt der.';
  }

  @override
  String get subscriptionsWebInsecure => 'Forbindelsen til dette websted er ikke krypteret.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Pas på: denne adresse efterligner $site med forvekslelige bogstaver.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Pas på: denne adresse efterligner et andet websted med forvekslelige bogstaver.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site kunne ikke åbnes.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe noterer dagens dato og giver dig besked, hvis $sender bliver ved med at skrive.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vil du afmelde dig fra $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontakter $site for at afmelde dig.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Det er den eneste gang, Loupe kontakter en afsenders websted. Den sender kun »List-Unsubscribe=One-Click« til den adresse, $sender har angivet, uden cookies eller andet om dig, og indlæser ikke siden.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Afmeldingslinket er ikke en sikker adresse på internettet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site svarede ikke i tide.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site kunne ikke nås.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site sendte anmodningen videre til en anden side, som Loupe ikke følger.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site afviste anmodningen (fejl $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Der er ingen konto at sende afmeldingsmailen fra.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe sender en mail til $to fra $from med emnet »$subject«.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Afmeldingsmail sendt til $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Vil du blokere $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Ny mail fra denne liste går til Uønsket. Du kan ændre det under Indstillinger › Regler.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Ny mail fra $address går til Uønsket. Du kan ændre det under Indstillinger › Regler.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender er blokeret.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Flyt $count til Uønsket');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokér $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender er nu under Nyhedsbreve.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender er nu under Diskussioner.';
  }

  @override
  String get appLiveGateTitle => 'Dine konti kunne ikke åbnes';

  @override
  String get appLiveGateUnavailableBuild => 'Rigtige konti er ikke tilgængelige i dette build endnu.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe kunne ikke læse den nøgle, der beskytter din mail på denne telefon. Det er ofte midlertidigt: prøv igen, eller genstart telefonen.';

  @override
  String get appLiveGateKeyMissing =>
      'Den nøgle, der beskytter din mail på denne telefon, er væk, hvilket kan ske efter gendannelse af en sikkerhedskopi. Din mail ligger stadig på serveren.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Maildatabasen på denne telefon kan ikke læses: den er beskadiget, eller dens nøgle er ændret. Din mail ligger stadig på serveren.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Noget gik galt under åbning af dine konti ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Dette sletter dine konti og den mail, der er gemt på denne telefon, også beskeder, der venter i udbakken. Mail på dine servere påvirkes ikke; tilføj dine konti igen bagefter.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Slet, og start forfra';

  @override
  String get appLiveGateUseDemo => 'Brug demomail';

  @override
  String get appLiveGateReset => 'Nulstil mail på denne telefon…';

  @override
  String get attachmentsUntitled => 'Vedhæftet fil';

  @override
  String get attachmentsUntitledFile => 'Unavngivet';

  @override
  String get attachmentsOpenIn => 'Åbn i…';

  @override
  String get attachmentsSaveToFiles => 'Gem i filer';

  @override
  String get attachmentsShareMenu => 'Del…';

  @override
  String get attachmentsDownloadError => 'Den vedhæftede fil kunne ikke hentes. Tjek forbindelsen, og prøv igen.';

  @override
  String get attachmentsShareError => 'Den vedhæftede fil kunne ikke deles.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ingen app på denne enhed kan åbne denne fil ($type). Prøv at dele den i stedet.';
  }

  @override
  String get attachmentsOpenInError => 'Den vedhæftede fil kunne ikke åbnes i en anden app.';

  @override
  String attachmentsSaved(String name) {
    return '»$name« er gemt';
  }

  @override
  String get attachmentsSaveError => 'Den vedhæftede fil kunne ikke gemmes.';

  @override
  String get attachmentsGone => 'Denne vedhæftede fil er ikke længere tilgængelig.';

  @override
  String get attachmentsDownloadFailed => 'Den vedhæftede fil kunne ikke hentes.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sider', one: '1 side');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size via mobildata';
  }

  @override
  String get attachmentsLargeDownload => 'Denne vedhæftede fil er stor. Hent den nu, eller senere via wi-fi.';

  @override
  String get attachmentsDownload => 'Hent';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Henter $size…';
  }

  @override
  String get attachmentsDownloading => 'Henter…';

  @override
  String get attachmentsTooLarge => 'For stor til at blive vist her.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Viser de første $shown af $total. Kopiér, del eller gem for at få det hele.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Denne PDF kan ikke vises her (den er måske beskyttet med en adgangskode).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page af $count';
  }

  @override
  String get attachmentsModeTable => 'Tabel';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Besked';

  @override
  String get attachmentsModeSource => 'Kilde';

  @override
  String get attachmentsDontWrap => 'Ombryd ikke linjer';

  @override
  String get attachmentsWrap => 'Ombryd linjer';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines linjer', one: '$lines linje');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiér alt';

  @override
  String get attachmentsCopied => 'Kopieret';

  @override
  String get attachmentsImageUnavailable => 'Billedet kan ikke vises her. Prøv »Åbn i…«.';

  @override
  String get attachmentsEmlNoSubject => '(Intet emne)';

  @override
  String get attachmentsEmlFrom => 'Fra';

  @override
  String get attachmentsEmlTo => 'Til';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Dato';

  @override
  String get attachmentsEmlNoText => 'Denne besked har ingen tekst.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vedhæftede filer: $names',
      one: 'Vedhæftet fil: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Arrangør: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Og $count begivenheder mere',
      one: 'Og 1 begivenhed mere',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Billede';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-billede';
  }

  @override
  String get attachmentsTypePdf => 'PDF-dokument';

  @override
  String get attachmentsTypeTsv => 'Tabulatorseparerede værdier';

  @override
  String get attachmentsTypeCsv => 'CSV-regneark';

  @override
  String get attachmentsTypeCalendar => 'Kalenderbegivenhed';

  @override
  String get attachmentsTypeEmail => 'Mailbesked';

  @override
  String get attachmentsTypeContact => 'Kontaktkort';

  @override
  String get attachmentsTypeLog => 'Logfil';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'ZIP-arkiv';

  @override
  String get attachmentsTypeArchive => 'Arkiv';

  @override
  String get attachmentsTypeWord => 'Word-dokument';

  @override
  String get attachmentsTypeExcel => 'Excel-regneark';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-præsentation';

  @override
  String get attachmentsTypeWebPage => 'Webside';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Lyd';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-fil';
  }

  @override
  String get attachmentsTypeFile => 'Fil';

  @override
  String get calendarUntitledEvent => 'Begivenhed';

  @override
  String get calendarAllDay => 'Hele dagen';

  @override
  String calendarYourTime(String time) {
    return '$time din tid';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Deltag: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har accepteret: $details',
      'tentative': '$name har foreløbigt accepteret: $details',
      'declined': '$name har afslået: $details',
      'delegated': '$name har uddelegeret: $details',
      'other': '$name har ikke svaret på: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har accepteret invitationen',
      'tentative': '$name har foreløbigt accepteret invitationen',
      'declined': '$name har afslået invitationen',
      'delegated': '$name har uddelegeret invitationen',
      'other': '$name har ikke svaret på invitationen',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kort';

  @override
  String get calendarJoin => 'Deltag';

  @override
  String get calendarOnlineMeeting => 'Onlinemøde';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-møde';
  }

  @override
  String get calendarOrganizerYou => 'Dig';

  @override
  String get calendarOrganizerLabel => 'arrangør';

  @override
  String get calendarStatusAccepted => 'Accepteret';

  @override
  String get calendarStatusMaybe => 'Måske';

  @override
  String get calendarStatusDeclined => 'Afslået';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har accepteret',
      'tentative': '$name har foreløbigt accepteret',
      'declined': '$name har afslået',
      'delegated': '$name har uddelegeret',
      'other': '$name har ikke svaret',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har accepteret:',
      'tentative': '$name har foreløbigt accepteret:',
      'declined': '$name har afslået:',
      'delegated': '$name har uddelegeret:',
      'other': '$name har ikke svaret:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '»$comment«';
  }

  @override
  String calendarCounter(String name) {
    return '$name foreslår et nyt tidspunkt';
  }

  @override
  String get calendarCounterUnknown => 'En deltager foreslår et nyt tidspunkt';

  @override
  String get calendarDeclineCounter => 'Arrangøren beholdt tidspunktet';

  @override
  String calendarRefresh(String name) {
    return '$name beder om den seneste version';
  }

  @override
  String get calendarRefreshUnknown => 'En deltager beder om den seneste version';

  @override
  String get calendarCancelled => 'Aflyst';

  @override
  String get calendarCancelledByOrganizer => 'Arrangøren har aflyst denne begivenhed.';

  @override
  String get calendarCancelledLater => 'Denne begivenhed blev aflyst senere.';

  @override
  String get calendarOutdated => 'Forældet';

  @override
  String get calendarOutdatedDetail => 'Denne invitation blev opdateret senere; den nyeste gælder.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Sted fjernet (var $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Sted fjernet (var intet)';

  @override
  String calendarLocationChanged(String location) {
    return 'Sted ændret til $location';
  }

  @override
  String get calendarNewTitle => 'Ny titel';

  @override
  String get calendarRepeatChanged => 'Gentagelsen er ændret';

  @override
  String get calendarUpdated => 'Opdateret';

  @override
  String get calendarUpdatedInvitation => 'Opdateret invitation';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Tidspunkt ændret fra $before til $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Tidszonen »$zone« er ukendt: tidspunkter som skrevet';
  }

  @override
  String calendarNext(String when) {
    return 'Næste: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gæster', one: '1 gæst');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ja');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count måske');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count nej');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (dig)';
  }

  @override
  String get calendarAttendeeOptional => 'valgfri';

  @override
  String get calendarAttendeeRoom => 'lokale';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Du accepterede en tidligere version.',
      'tentative': 'Du accepterede foreløbigt en tidligere version.',
      'declined': 'Du afslog en tidligere version.',
      'delegated': 'Du uddelegerede en tidligere version.',
      'other': 'Du svarede ikke på en tidligere version.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Acceptér';

  @override
  String get calendarMaybe => 'Måske';

  @override
  String get calendarDecline => 'Afslå';

  @override
  String get calendarCommentHint => 'Kommentar til arrangøren (valgfri)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Dit svar går til $organizer fra $address.';
  }

  @override
  String get calendarAddComment => 'Tilføj en kommentar';

  @override
  String get calendarAddToCalendar => 'Føj til kalender';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Og $count begivenheder mere i filen',
      one: 'Og 1 begivenhed mere i filen',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Der er ingen kalenderapp at føje begivenheden til.';

  @override
  String get calendarCantOpenCalendar => 'Kalenderen kunne ikke åbnes.';

  @override
  String get calendarCantOpenLink => 'Linket kunne ikke åbnes.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Vil du deltage i $provider-mødet?';
  }

  @override
  String get calendarJoinTitle => 'Vil du deltage i mødet?';

  @override
  String calendarJoinOpens(String host) {
    return 'Åbner $host i din browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Pas på: denne adresse efterligner $site med forvekslelige bogstaver.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Pas på: denne adresse efterligner et andet websted med forvekslelige bogstaver.';

  @override
  String calendarJoinOpen(String host) {
    return 'Åbn $host';
  }

  @override
  String get calendarNoOrganizer => 'Denne invitation har ingen arrangør at svare til.';

  @override
  String get calendarNoAccount => 'Der er ingen konto at svare fra.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepteret', 'tentative': 'Måske', 'other': 'Afslået'});
    return '$_temp0 · sender svar til $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepteret', 'tentative': 'Måske', 'other': 'Afslået'});
    return '$_temp0 · svar sendt';
  }

  @override
  String get calendarReplyAlreadySent => 'Svaret var allerede sendt.';

  @override
  String get calendarReplyNotSent => 'Svaret blev ikke sendt.';

  @override
  String get dataSmimeNeedsDevice =>
      'Dit S/MIME-certifikat er på denne enhed: åbn Loupe for at signere og sende denne besked.';

  @override
  String dataSigningFailed(String error) {
    return 'Signering mislykkedes: $error';
  }

  @override
  String get keyboardShortcuts => 'Tastaturgenveje';

  @override
  String get keyboardGroupGeneral => 'Generelt';

  @override
  String get keyboardGroupMessages => 'Beskeder';

  @override
  String get keyboardGroupCompose => 'Skriv';

  @override
  String get keyboardCommandPalette => 'Kommandopalet';

  @override
  String get keyboardBackClose => 'Tilbage, luk';

  @override
  String get keyboardNextMessage => 'Næste besked';

  @override
  String get keyboardPreviousMessage => 'Forrige besked';

  @override
  String get keyboardOpenMessage => 'Åbn besked';

  @override
  String get keyboardMoveToTrash => 'Flyt til papirkurven';

  @override
  String get keyboardToggleRead => 'Markér som læst eller ulæst';

  @override
  String get keyboardToggleFlag => 'Flag eller fjern flag';

  @override
  String get keyboardCloseDraft => 'Luk (gem eller slet kladde)';

  @override
  String get keyboardOr => 'eller';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Skift';

  @override
  String get keyboardKeyEnter => 'Enter';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyBackspace => 'Tilbage';

  @override
  String get mailingListsMuted => 'Lyden er slået fra for tråden. Nye beskeder i den kommer som læste.';

  @override
  String get mailingListsUnmuted => 'Lyden er slået til for tråden.';

  @override
  String get mailingListsMuteThread => 'Slå lyden fra for tråden';

  @override
  String get mailingListsUnmuteThread => 'Slå lyden til for tråden';

  @override
  String get mailingListsPin => 'Fastgør til Postkasser';

  @override
  String get mailingListsUnpin => 'Frigør fra Postkasser';

  @override
  String get mailingListsDefaultView => 'Åbn i standardvisning';

  @override
  String get mailingListsPlainText => 'Åbn som ren tekst (Mono)';

  @override
  String get mailingListsShowMuted => 'Vis tråde uden lyd';

  @override
  String get mailingListsHideMuted => 'Skjul tråde uden lyd';

  @override
  String get mailingListsTreatAsNewsletter => 'Behandl som nyhedsbrev';

  @override
  String get mailingListsOptions => 'Listeindstillinger';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted ulæste',
      one: '$formatted ulæst',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Ny besked til listen';

  @override
  String get mailingListsRowUnread => 'Ulæst';

  @override
  String get mailingListsRowMuted => 'Lydløs';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count svar', one: '1 svar');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Ingen tråde';

  @override
  String get mailingListsMutedHidden => 'Tråde uden lyd er skjult.';

  @override
  String get mailingListsTechnicalTitle => 'Tekniske lister';

  @override
  String get mailingListsTechnicalEmpty => 'Mailinglister vises her, når deres mail ankommer.';

  @override
  String get mailingListsTechnicalFooter =>
      'Beskeder fra disse lister åbnes som ren tekst i en skrifttype med fast bredde, med patches vist som diffs. Knappen Aa kan stadig skifte visning for enhver besked.';

  @override
  String get paletteMoveToMailbox => 'Flyt til postkasse…';

  @override
  String get paletteMarkAllRead => 'Markér alle som læst';

  @override
  String get paletteExportFolder => 'Eksportér mappe…';

  @override
  String get paletteGetNewMail => 'Hent ny mail';

  @override
  String get paletteSnoozed => 'Udsat';

  @override
  String get paletteSubscriptions => 'Abonnementer';

  @override
  String get paletteDiscussions => 'Diskussioner';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailingliste';

  @override
  String get paletteTag => 'Mærkat';

  @override
  String get paletteSwipeActions => 'Swipe-handlinger';

  @override
  String get paletteNotifications => 'Notifikationer';

  @override
  String get paletteRules => 'Regler';

  @override
  String get paletteEncryption => 'End-to-end-kryptering';

  @override
  String get paletteAdvanced => 'Avanceret';

  @override
  String get paletteAddAccount => 'Tilføj konto';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Mapper';

  @override
  String get paletteRecentSearch => 'Seneste søgning';

  @override
  String paletteSearchMail(String query) {
    return 'Søg i mail efter »$query«';
  }

  @override
  String get palettePlaceholder => 'Søg i handlinger, postkasser, indstillinger';

  @override
  String get paletteNothingFound => 'Intet fundet';

  @override
  String get searchNewSmartMailbox => 'Ny Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Viser alt, der matcher »$query«.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '»$name« er gemt i Postkasser';
  }

  @override
  String get searchMakeRule => 'Gør dette til en regel';

  @override
  String get searchSaveSmartMailbox => 'Gem som Smart Mailbox';

  @override
  String get searchNegate => 'Ekskludér';

  @override
  String get searchDontNegate => 'Inkludér';

  @override
  String get searchAllMailboxes => 'Alle postkasser';

  @override
  String get searchRecent => 'Seneste søgninger';

  @override
  String get searchClear => 'Ryd';

  @override
  String get searchSuggestions => 'Forslag';

  @override
  String get searchUnreadMessages => 'Ulæste beskeder';

  @override
  String get searchFlaggedMessages => 'Flagede beskeder';

  @override
  String get searchWithAttachments => 'Beskeder med vedhæftede filer';

  @override
  String get searchUnrepliedMessages => 'Ubesvarede beskeder';

  @override
  String get searchTags => 'Mærkater';

  @override
  String get searchPeople => 'Personer';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Fra: $name';
  }

  @override
  String get searchSearching => 'Søger…';

  @override
  String get searchNoResults => 'Ingen resultater';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted resultater',
      one: '$formatted resultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Søgemenu';

  @override
  String searchSearchingAccount(String account) {
    return 'Søger i $account på serveren…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Søger i konto på serveren…';

  @override
  String searchAccountFailed(String account) {
    return 'Der kunne ikke søges i $account på serveren';
  }

  @override
  String get searchUnknownAccountFailed => 'Der kunne ikke søges i kontoen på serveren';

  @override
  String searchChip(String term) {
    return '$term. Dobbelttryk for at redigere.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ikke $term. Dobbelttryk for at redigere.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingers indbakke: alle beskeder her er både læste og ulæste, indtil du åbner dem.';

  @override
  String searchContradiction(String term) {
    return 'Ingen besked kan både være »$term« og ikke være det.';
  }

  @override
  String get searchSyncDeviceOnly => 'Kun på denne enhed';

  @override
  String searchSyncUnsupported(String account) {
    return 'Kun på denne enhed: $account kan ikke gemme den';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Ikke synkroniseret: $account har et nyere format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Venter på at synkronisere til $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synkroniseret til $account';
  }

  @override
  String get searchRename => 'Omdøb';

  @override
  String get searchEditSearch => 'Redigér søgning';

  @override
  String get searchDeleteSmartMailbox => 'Slet Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Omdøb Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Denne Smart Mailbox er slettet.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes bliver på denne enhed.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes gemmes på din mailserver, så dine andre enheder også har dem, og det samme har Thunderbird med Expression Search Reloaded. Dem, der søger i alle konti, gemmes på $account; dem for én mappe på den mappes konto.';
  }

  @override
  String get searchSyncVia => 'Synkronisér via';

  @override
  String get searchSyncViaFooter => 'Vælg den samme konto på alle enheder.';

  @override
  String get searchGmailCantKeep => 'Gmail kan ikke gemme Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Gem kun Smart Mailboxes på denne enhed';

  @override
  String get searchOnTheServer => 'På serveren';

  @override
  String get searchServerFooter =>
      'Servermetadata (IMAP METADATA) vises ikke i nogen mailapp. Servere uden det får en mappe, »Loupe Settings«, med én besked; Loupe skjuler den i Postkasser.';

  @override
  String get searchSyncNow => 'Synkronisér nu';

  @override
  String get searchStateUnsupported => 'Understøttes ikke';

  @override
  String get searchStateNewerFormat => 'Nyere format';

  @override
  String get searchStateFailed => 'Kunne ikke synkronisere';

  @override
  String get searchStateSyncing => 'Synkroniserer…';

  @override
  String get searchStateWaiting => 'Venter';

  @override
  String get searchStateMetadata => 'Servermetadata';

  @override
  String get searchStateFolder => 'Mappen Loupe Settings';

  @override
  String get searchStateNothing => 'Intet gemt';

  @override
  String get sharedBack => 'Tilbage';

  @override
  String get sharedYesterday => 'I går';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date kl. $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count byte');
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
  String get sharedSyncNoAccounts => 'Ingen konti';

  @override
  String get sharedSyncChecking => 'Tjekker for mail…';

  @override
  String get sharedSyncFailed => 'Kunne ikke tjekke for mail';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Opdateret lige nu';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Opdateret for $minutes minutter siden',
      one: 'Opdateret for 1 minut siden',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Opdateret kl. $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Opdateret $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Alle indbakker';

  @override
  String get sharedMailboxUnread => 'Ulæste';

  @override
  String get sharedMailboxFlagged => 'Flagede';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Alle kladder';

  @override
  String get sharedMailboxAllSent => 'Alle sendte';

  @override
  String get sharedMailboxUntitled => 'Postkasse';

  @override
  String get sharedTagImportant => 'Vigtigt';

  @override
  String get sharedTagWork => 'Arbejde';

  @override
  String get sharedTagPersonal => 'Personligt';

  @override
  String get sharedTagToDo => 'Opgave';

  @override
  String get sharedTagLater => 'Senere';

  @override
  String get sharedTags => 'Mærkater';

  @override
  String get sharedMoveTo => 'Flyt til…';

  @override
  String get sharedNoRecipients => 'Ingen modtagere';

  @override
  String get sharedUnknownSender => 'Ukendt afsender';

  @override
  String get sharedOnServer => 'På serveren';

  @override
  String get sharedAttachment => 'Vedhæftet fil';

  @override
  String get sharedSnoozedBadge => 'Udsat';

  @override
  String get sharedRowUnread => 'Ulæst';

  @override
  String get sharedRowBackFromSnooze => 'Tilbage fra udsættelse';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Flaget';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er arkiveret',
      one: '1 besked er arkiveret',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er slettet',
      one: '1 besked er slettet',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er flyttet til indbakken',
      one: '1 besked er flyttet til indbakken',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er flyttet til papirkurven',
      one: '1 besked er flyttet til papirkurven',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er flyttet til Uønsket',
      one: '1 besked er flyttet til Uønsket',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er flyttet til $mailbox',
      one: '1 besked er flyttet til $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er flyttet til en postkasse',
      one: '1 besked er flyttet til en postkasse',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beskeder er udsat til $time',
      one: '1 besked er udsat til $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Udsat til $time kun på denne enhed: serveren kan ikke gemme tidspunkter for udsættelse.';
  }

  @override
  String get sharedMoveOneAccount => 'Vælg beskeder fra én konto for at flytte dem.';

  @override
  String get sharedSnoozeTitle => 'Udsæt';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Skift tidspunkt for udsættelse';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du slette $count beskeder permanent?',
      one: 'Vil du slette denne besked permanent?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Det kan ikke fortrydes.';

  @override
  String get sharedDeletePermanently => 'Slet permanent';

  @override
  String get sharedSwipeRead => 'Læst';

  @override
  String get sharedSwipeUnread => 'Ulæst';

  @override
  String get sharedSwipeInbox => 'Indbakke';

  @override
  String get sharedSwipeDelete => 'Slet';

  @override
  String get sharedTrash => 'Papirkurv';

  @override
  String get sharedSwipeSnooze => 'Udsæt';

  @override
  String get sharedWakeNow => 'Hent tilbage nu';

  @override
  String get sharedChangeSnoozeTime => 'Skift tidspunkt for udsættelse…';

  @override
  String get sharedSnooze => 'Udsæt…';

  @override
  String get sharedTag => 'Mærkat…';

  @override
  String get sharedMoveMessage => 'Flyt besked…';

  @override
  String get sharedNotJunk => 'Ikke uønsket';

  @override
  String get accountSetupTitle => 'Tilføj konto';

  @override
  String get accountSetupTitleDone => 'Kontoen er tilføjet';

  @override
  String get accountSetupAddressTitle => 'Tilføj en mailkonto';

  @override
  String get accountSetupAddressText => 'Loupe finder indstillingerne for de fleste udbydere.';

  @override
  String get accountSetupNameHint => 'Dit navn';

  @override
  String get accountSetupEmail => 'Mail';

  @override
  String get accountSetupEmailHint => 'navn@example.com';

  @override
  String get accountSetupContinue => 'Fortsæt';

  @override
  String get accountSetupLookingUp => 'Slår indstillinger op…';

  @override
  String get accountSetupImport => 'Importér fra Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Indtast en gyldig mailadresse.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Kunne ikke finde indstillinger for $domain. Indtast dem nedenfor.';
  }

  @override
  String get accountSetupCheckServers => 'Tjek servernavne og porte.';

  @override
  String get accountSetupEnterPassword => 'Indtast din adgangskode.';

  @override
  String get accountSetupConnecting => 'Opretter forbindelse…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Venter på $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Siden kunne ikke åbnes.';

  @override
  String get accountSetupCouldNotSaveName => 'Navnet kunne ikke gemmes.';

  @override
  String get accountSetupTrustCertificate => 'Stol på dette certifikat';

  @override
  String get accountSetupPasswordRequired => 'Påkrævet';

  @override
  String get accountSetupShowPassword => 'Vis adgangskode';

  @override
  String get accountSetupHidePassword => 'Skjul adgangskode';

  @override
  String get accountSetupAppPassword => 'App-adgangskode';

  @override
  String get accountSetupApiToken => 'API-token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Indgående · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Udgående · SMTP';

  @override
  String get accountSetupSignIn => 'Log ind';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Log ind med $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Brug en app-adgangskode';

  @override
  String get accountSetupUseAppPasswordInstead => 'Brug en app-adgangskode i stedet';

  @override
  String get accountSetupUseDifferentAddress => 'Brug en anden adresse';

  @override
  String get accountSetupHowToCreateAppPassword => 'Sådan opretter du en app-adgangskode';

  @override
  String get accountSetupHowToCreateOne => 'Sådan opretter du en';

  @override
  String get accountSetupGoogleNote =>
      'Du logger ind på Googles side, og Loupe ser aldrig din adgangskode. Giv Loupe lov til at læse, sende og organisere din mail.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '»Log ind med Google« er ikke tilgængeligt i dette build endnu. Du kan i stedet oprette forbindelse med en app-adgangskode (det kræver totrinsbekræftelse på din Google-konto).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Opret en app-adgangskode i din Google-konto, og indsæt den nedenfor.';

  @override
  String get accountSetupMicrosoftNote =>
      'Du logger ind på Microsofts side, og Loupe ser aldrig din adgangskode. Det virker til Outlook.com og Hotmail og til arbejds- eller skolekonti på Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Login med Microsoft kommer i et senere build. Outlook-, Hotmail- og Microsoft 365-konti kræver det: de accepterer ikke længere adgangskoder fra mailapps.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail kræver en appspecifik adgangskode, ikke adgangskoden til din Apple-konto.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail kræver en app-adgangskode, ikke adgangskoden til din konto.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe opretter forbindelse til Fastmail via JMAP med et API-token: Settings › Privacy & Security › Manage API tokens, til JMAP, med adgang til mail og afsendelse.';

  @override
  String get accountSetupFastmailNote => 'Fastmail kræver en app-adgangskode til mailapps.';

  @override
  String get accountSetupServerSettings => 'Serverindstillinger';

  @override
  String get accountSetupSettingsNotFound => 'Ikke fundet automatisk';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Fundet via $source';
  }

  @override
  String get accountSetupEditSettings => 'Redigér indstillinger';

  @override
  String get accountSetupSyncing => 'Din mail synkroniseres.';

  @override
  String get accountSetupDescription => 'Beskrivelse';

  @override
  String get accountSetupDescriptionHint => 'Arbejde, privat…';

  @override
  String get accountSetupColour => 'Farve';

  @override
  String accountSetupColourNumber(int number) {
    return 'Farve $number';
  }

  @override
  String get accountSetupSaving => 'Gemmer…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe kunne ikke åbne sin maildatabase på denne telefon. Luk Loupe, åbn den igen, og prøv igen.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Noget gik galt ($error). Prøv igen.';
  }

  @override
  String get accountSetupSecurityNone => 'Ingen';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sikkerhed';

  @override
  String get accountSetupUsername => 'Brugernavn';

  @override
  String get accountSetupUsernameHint => 'Din mailadresse';

  @override
  String get accountSetupNoEncryptionTitle => 'Vil du oprette forbindelse uden kryptering?';

  @override
  String get accountSetupNoEncryptionText =>
      'Din adgangskode og alle beskeder ville blive sendt som almindelig tekst. Alle på netværket, f.eks. et offentligt wi-fi, ville kunne læse dem. Brug kun dette til en server på dit eget netværk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Brug uden kryptering';

  @override
  String get accountSetupApiTokenRejected =>
      'API-tokenet blev afvist. Opret et Fastmail-API-token til JMAP med adgang til mail, og indsæt det.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Adgangskoden blev afvist. Brug en app-adgangskode, ikke adgangskoden til din konto.';

  @override
  String get accountSetupPasswordRejected => 'Adgangskoden blev afvist. Tjek den, og prøv igen.';

  @override
  String get accountSetupServerUnreachable => 'Serveren kan ikke nås. Tjek serverindstillingerne og din forbindelse.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Serverens certifikat er ikke betroet. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Login blev annulleret. Tryk på »Log ind med $provider« for at prøve igen.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe skal have tilladelse til at læse og sende din Gmail. Log ind igen, og giv adgang med Gmail-feltet markeret.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe skal have tilladelse til at læse og sende din mail. Log ind igen, og acceptér tilladelserne.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Din organisation skal godkende Loupe, før du kan bruge den med denne konto. Bed din it-administrator om at give administratorsamtykke til Loupe i Microsoft Entra ID, og prøv så igen.';

  @override
  String get accountSetupOAuthBlocked =>
      'Din organisations loginregler tillader ikke Loupe på denne enhed. Spørg din it-administrator.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider kunne ikke nås. Tjek din internetforbindelse, og prøv igen.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Login med $provider er ikke konfigureret korrekt i denne version af Loupe. Rapportér det venligst.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Login med $provider virkede ikke. Prøv igen.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider loggede dig ind, men Gmail nægtede adgang for denne adresse. Vælg den samme konto, når du logger ind. Arbejds- eller skolekonti kan have fået IMAP slået fra af deres administrator.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider loggede dig ind, men mailserveren nægtede adgang for denne adresse. Vælg den samme konto, når du logger ind. Arbejds- eller skolekonti kan have fået IMAP slået fra af deres administrator.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Mailserveren kan ikke nås. Tjek din forbindelse, og prøv igen.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Login med $provider er ikke tilgængeligt i denne version.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Du er logget ind igen. $account synkroniseres.';
  }

  @override
  String get accountSetupSignInAgain => 'Log ind igen';

  @override
  String get accountSetupSigningIn => 'Logger ind…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider accepterer ikke længere Loupes login for $email, så $account synkroniseres ikke. Log ind igen for at få kontoens mail.';
  }

  @override
  String get accountImportTitle => 'Importér fra Thunderbird';

  @override
  String get accountImportPointCamera => 'Ret kameraet mod den QR-kode, Thunderbird viser.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Scannet $scanned af $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Scannet $scanned af $total koder');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konti indtil videre',
      one: '1 konto indtil videre',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Åbn Thunderbird på din computer, og vælg Funktioner › Eksportér til mobil. Vælg dine konti, og scan derefter hver kode, der vises. Koderne kan scannes i vilkårlig rækkefølge.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fortsæt med $count konti',
      one: 'Fortsæt med 1 konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Indsæt tekst i stedet';

  @override
  String get accountImportStartOver => 'Start forfra';

  @override
  String get accountImportDuplicateCode => 'Den kode er allerede tilføjet.';

  @override
  String get accountImportRestarted =>
      'Denne kode er fra en ny eksport, så de tidligere scannede koder er lagt til side.';

  @override
  String get accountImportNotThunderbird => 'Dette er ikke en kontokode fra Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Denne kode kommer fra en nyere Thunderbird. Opdatér Loupe for at importere den.';

  @override
  String get accountImportDamaged => 'Denne Thunderbird-kode kunne ikke læses.';

  @override
  String get accountImportTooLarge => 'Denne kode er for stor til at være en eksport fra Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Indstillinger kunne ikke åbnes.';

  @override
  String get accountImportCameraOffTitle => 'Kameraadgang er slået fra';

  @override
  String get accountImportCameraOffText =>
      'Giv Loupe adgang til kameraet i Indstillinger for at scanne koden, eller indsæt kodens tekst i stedet.';

  @override
  String get accountImportNoCameraTitle => 'Intet kamera';

  @override
  String get accountImportNoCameraText => 'Loupe kan ikke bruge et kamera her. Indsæt kodens tekst i stedet.';

  @override
  String get accountImportCameraFailedTitle => 'Kameraet startede ikke';

  @override
  String get accountImportCameraFailedText => 'Prøv igen, eller indsæt kodens tekst i stedet.';

  @override
  String get accountImportOpenSettings => 'Åbn Indstillinger';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konti fundet',
      one: '1 konto fundet',
      zero: 'Ingen konti fundet',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ingen af kontiene i disse koder kunne læses.';

  @override
  String get accountImportChoose => 'Vælg de konti, der skal føjes til Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Koderne $codes af $total blev ikke scannet, så deres konti vises ikke.',
      one: 'Kode $codes af $total blev ikke scannet, så dens konti vises ikke.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes og $last';
  }

  @override
  String get accountImportScanMore => 'Scan flere koder';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konti i koderne kunne ikke læses. De bruger måske indstillinger fra en nyere Thunderbird.',
      one: '1 konto i koderne kunne ikke læses. Den bruger måske indstillinger fra en nyere Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scan igen';

  @override
  String get accountImportAlreadyAdded => 'Der er allerede en konto med denne adresse i Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Du logger ind med $provider, når den tilføjes, ligesom i Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Tilføj kontoen med en app-adgangskode (det kræver totrinsbekræftelse).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird logger ind på Gmail med Google. »Log ind med Google« kommer i et senere build; indtil da kan du tilføje kontoen med en app-adgangskode (det kræver totrinsbekræftelse).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird logger ind på denne konto i browseren. Det kan Loupe ikke endnu: brug en app-adgangskode, hvis din udbyder tilbyder det.';

  @override
  String get accountImportUnencrypted => 'Opretter forbindelse uden kryptering. Brug kun dette på dit eget netværk.';

  @override
  String get accountImportEnterAgain => 'Indtast den igen';

  @override
  String get accountImportAdded => 'Tilføjet';

  @override
  String accountImportAdding(int index, int total) {
    return 'Tilføjer $index af $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tilføj $count konti',
      one: 'Tilføj 1 konto',
      zero: 'Tilføj konti',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Indsæt eksporttekst';

  @override
  String get accountImportPasteText => 'Indsæt teksten fra en eksportkode fra Thunderbird, én kode pr. linje.';

  @override
  String get accountImportPop3 => 'POP3-konti understøttes ikke. Loupe beholder mail på serveren med IMAP.';

  @override
  String get accountImportKerberos => 'Denne konto logger ind med Kerberos, som Loupe ikke understøtter.';

  @override
  String get accountImportNtlm => 'Denne konto logger ind med NTLM, som Loupe ikke understøtter.';

  @override
  String get accountImportClientCertificate =>
      'Denne konto logger ind med et klientcertifikat, som Loupe ikke understøtter endnu.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Login med Microsoft kommer i et senere build. Outlook- og Microsoft 365-konti accepterer ikke længere adgangskoder fra mailapps.';

  @override
  String get accountImportEnterPassword => 'Indtast adgangskoden.';

  @override
  String get accountImportEnterAppPassword => 'Indtast app-adgangskoden.';

  @override
  String get accountImportEnterApiToken => 'Indtast API-tokenet.';

  @override
  String get accountImportStorageFailed => 'Loupe kunne ikke åbne sit kontolager. Prøv igen senere.';

  @override
  String get accountImportFailed => 'Kontoen kunne ikke tilføjes. Prøv igen, eller tilføj den manuelt.';

  @override
  String get composeNewMessageTitle => 'Ny besked';

  @override
  String get composeAttach => 'Vedhæft';

  @override
  String get composeSendLater => 'Send senere';

  @override
  String composeSendAt(String time) {
    return 'Send $time';
  }

  @override
  String get composeSendHint => 'Tryk længe for at sende senere';

  @override
  String get composeNoAccount => 'Tilføj en konto for at sende mail.';

  @override
  String get composeTo => 'Til:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Fra: $email';
  }

  @override
  String get composeFromLabel => 'Fra:';

  @override
  String get composeSubjectLabel => 'Emne:';

  @override
  String composeReplyTo(String address) {
    return 'Svar til: $address';
  }

  @override
  String get composeFrom => 'Fra';

  @override
  String composeReplyFrom(String email) {
    return 'Svar fra $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Send fra $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vil du svare fra $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Vil du sende fra $email?';
  }

  @override
  String get composeDismiss => 'Afvis';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ikke gemt som identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Gem som identitet';

  @override
  String composeAliasSaved(String email) {
    return '$email er gemt som identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ugyldig adresse $address';
  }

  @override
  String get composeOriginalNotFound => 'Den oprindelige besked blev ikke fundet.';

  @override
  String get composeDraftNotFound => 'Kladden blev ikke fundet.';

  @override
  String get composeAttachmentsLost => 'De vedhæftede filer kunne ikke gendannes. Tilføj dem igen.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Nogle vedhæftede filer kunne ikke tilføjes: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'De vedhæftede filer fylder i alt $size; nogle servere afviser så store beskeder.';
  }

  @override
  String get composeAttachFailed => 'Filen kunne ikke vedhæftes.';

  @override
  String get composeInvalidAddressTitle => 'Ugyldig adresse';

  @override
  String composeInvalidAddress(String address) {
    return '»$address« er ikke en gyldig mailadresse.';
  }

  @override
  String get composeNoSubjectTitle => 'Intet emne';

  @override
  String get composeNoSubjectText => 'Denne besked har intet emne. Vil du sende den alligevel?';

  @override
  String get composeSentBeforeChanges => 'Den blev sendt før dine ændringer, som er gemt i Kladder.';

  @override
  String composeScheduled(String time) {
    return 'Planlagt til $time';
  }

  @override
  String get composeSending => 'Sender…';

  @override
  String get composeSent => 'Sendt';

  @override
  String get composeSendFailed => 'Kunne ikke sende. Prøv igen.';

  @override
  String get composeAlreadySent => 'Allerede sendt.';

  @override
  String get composeDiscardChanges => 'Kassér ændringer';

  @override
  String get composeSaveChanges => 'Gem ændringer';

  @override
  String get composeDeleteDraft => 'Slet kladde';

  @override
  String get composeSaveDraft => 'Gem kladde';

  @override
  String get composeDraftSaved => 'Kladden er gemt';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Den $date kl. $time skrev $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Den $date kl. $time skrev nogen:';
  }

  @override
  String get composeForwardHeader => '---------- Videresendt besked ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Fra: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dato: $date kl. $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Emne: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Til: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Senere i dag';

  @override
  String get composeTomorrowMorning => 'I morgen tidlig';

  @override
  String get composeMondayMorning => 'Mandag morgen';

  @override
  String get composePickDateTime => 'Vælg dato og tidspunkt…';

  @override
  String get composeSendWithoutDelay => 'Send uden forsinkelse';

  @override
  String composeSendTimeToday(String time) {
    return 'I dag kl. $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'I morgen kl. $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day kl. $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'I dag $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'I morgen $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Vil du fortsætte med at redigere din kladde?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'En besked blev ikke sendt, da Loupe lukkede.',
      'one': 'En besked til $name blev ikke sendt, da Loupe lukkede.',
      'other': 'En besked til $name og andre blev ikke sendt, da Loupe lukkede.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '»$subject« blev ikke sendt, da Loupe lukkede.',
      'one': '»$subject« til $name blev ikke sendt, da Loupe lukkede.',
      'other': '»$subject« til $name og andre blev ikke sendt, da Loupe lukkede.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Fortsæt redigering';

  @override
  String get composeRecoverySave => 'Gem i Kladder';

  @override
  String get composeRecoveryDiscard => 'Kassér';

  @override
  String get composeRecoverySaved => 'Gemt i Kladder';

  @override
  String get outboxSectionFailed => 'Ikke sendt';

  @override
  String get outboxSectionSending => 'Sendes';

  @override
  String get outboxSectionScheduled => 'Planlagt';

  @override
  String get outboxStatusQueued => 'Sendes snart';

  @override
  String get outboxStatusSending => 'Sender…';

  @override
  String get outboxStatusFailed => 'Ikke sendt';

  @override
  String get outboxNoRecipients => 'Ingen modtagere';

  @override
  String get outboxNoSubject => '(Intet emne)';

  @override
  String get outboxSendingFailed => 'Afsendelsen mislykkedes.';

  @override
  String get outboxEmptyTitle => 'Intet at sende';

  @override
  String get outboxEmptyText => 'Beskeder, du sender senere, venter her, indtil det er tid.';

  @override
  String get outboxSendNow => 'Send nu';

  @override
  String get outboxReschedule => 'Ny tid';

  @override
  String get outboxRescheduleMenu => 'Vælg nyt tidspunkt…';

  @override
  String get outboxRescheduleTitle => 'Nyt tidspunkt';

  @override
  String outboxRescheduled(String time) {
    return 'Flyttet til $time';
  }

  @override
  String get outboxCancel => 'Annuller';

  @override
  String get outboxCancelSending => 'Annuller afsendelse…';

  @override
  String get outboxCancelTitle => 'Vil du annullere afsendelsen?';

  @override
  String get outboxMoveToDrafts => 'Flyt til Kladder';

  @override
  String get outboxDiscard => 'Kassér besked';

  @override
  String get outboxMovedToDrafts => 'Flyttet til Kladder';

  @override
  String get outboxDiscarded => 'Beskeden er kasseret';

  @override
  String get outboxAlreadySent => 'Allerede sendt.';

  @override
  String get outboxBeingSent => 'Denne besked er ved at blive sendt.';

  @override
  String get outboxActionFailed => 'Det virkede ikke. Beskeden er stadig i udbakken.';

  @override
  String get notificationsBadgeInboxes => 'Ulæste i indbakker';

  @override
  String get notificationsBadgeVip => 'Ulæste fra VIP’er';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Ny mail fra dine VIP’er, på alle konti';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Ny mail i $email';
  }

  @override
  String get notificationsUnknownSender => 'Ukendt afsender';

  @override
  String get notificationsNoSubject => '(Intet emne)';

  @override
  String get notificationsEncryptedMessage => 'Krypteret besked';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Ny besked fra $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count nye beskeder', one: '1 ny besked');
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nye beskeder i $account';
  }

  @override
  String get platformInstantChannel => 'Øjeblikkelig levering';

  @override
  String get platformInstantChannelDescription => 'Vises, mens Loupe holder øje med ny mail i dine indbakker';

  @override
  String get platformInstantTitle => 'Holder øje med ny mail';

  @override
  String get platformInstantText => 'Øjeblikkelig levering er slået til';

  @override
  String get platformErrorBox => 'Noget gik galt under visningen. Gå tilbage, og prøv igen.';

  @override
  String get welcomeTagline => 'Mail, der er enkel på overfladen\nog kraftfuld nedenunder.';

  @override
  String get welcomeAccountsTitle => 'Alle konti, én rolig indbakke';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail og enhver IMAP- eller JMAP-server.';

  @override
  String get welcomeSearchTitle => 'Søgning, der finder det';

  @override
  String get welcomeSearchText => 'Øjeblikkelige resultater på din telefon, derefter serverens.';

  @override
  String get welcomePrivacyTitle => 'Privat fra starten';

  @override
  String get welcomePrivacyText => 'Ingen sporing. Eksterne billeder forbliver blokeret, indtil du siger til.';

  @override
  String get welcomeAddAccount => 'Tilføj konto';

  @override
  String get welcomeImport => 'Importér fra Thunderbird';

  @override
  String get welcomeTryDemo => 'Prøv med demomail';
}
