// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get commonAdd => 'Legg til';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonClose => 'Lukk';

  @override
  String get commonDelete => 'Slett';

  @override
  String get commonDone => 'Ferdig';

  @override
  String get commonEdit => 'Rediger';

  @override
  String get commonMore => 'Mer';

  @override
  String get commonMove => 'Flytt';

  @override
  String get commonName => 'Navn';

  @override
  String get commonNone => 'Ingen';

  @override
  String get commonOff => 'Av';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'På';

  @override
  String get commonOptional => 'Valgfritt';

  @override
  String get commonPassword => 'Passord';

  @override
  String get commonRemove => 'Fjern';

  @override
  String get commonRetry => 'Prøv igjen';

  @override
  String get commonSave => 'Lagre';

  @override
  String get commonSearch => 'Søk';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Innstillinger';

  @override
  String get commonShare => 'Del';

  @override
  String get commonTryAgain => 'Prøv igjen';

  @override
  String get commonUndo => 'Angre';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meldinger', one: '1 melding');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkiver';

  @override
  String get mailDelete => 'Slett';

  @override
  String get mailFlag => 'Flagg';

  @override
  String get mailForward => 'Videresend';

  @override
  String get mailMarkAsRead => 'Merk som lest';

  @override
  String get mailMarkAsUnread => 'Merk som ulest';

  @override
  String get mailMoveToJunk => 'Flytt til Søppelpost';

  @override
  String get mailNewMessage => 'Ny melding';

  @override
  String get mailNoSubject => 'Uten emne';

  @override
  String get mailReply => 'Svar';

  @override
  String get mailReplyAll => 'Svar alle';

  @override
  String get mailSend => 'Send';

  @override
  String get mailUnflag => 'Fjern flagg';

  @override
  String get mailboxArchive => 'Arkiv';

  @override
  String get mailboxDrafts => 'Utkast';

  @override
  String get mailboxInbox => 'Innboks';

  @override
  String get mailboxJunk => 'Søppelpost';

  @override
  String get mailboxOutbox => 'Utboks';

  @override
  String get mailboxSent => 'Sendt';

  @override
  String get mailboxTrash => 'Papirkurv';

  @override
  String get conversationSomethingWentWrong => 'Noe gikk galt. Prøv igjen.';

  @override
  String get conversationReplyToList => 'Svar til listen';

  @override
  String get conversationReplyList => 'Svar liste';

  @override
  String get conversationThreadMuted => 'Tråden er dempet. Nye meldinger i den kommer som lest.';

  @override
  String get conversationThreadUnmuted => 'Tråden er ikke lenger dempet.';

  @override
  String get conversationLinkFailed => 'Kunne ikke åpne lenken.';

  @override
  String get conversationGoneTitle => 'Ingen melding';

  @override
  String get conversationGoneText => 'Meldingen er flyttet eller slettet.';

  @override
  String get conversationMuted => 'Dempet';

  @override
  String get conversationReaderOptions => 'Lesealternativer';

  @override
  String get conversationReaderOptionsHint => 'Tekststørrelse og visning';

  @override
  String get conversationTrash => 'Papirkurv';

  @override
  String get conversationReplyHint => 'Trykk lenge for Svar alle og Videresend';

  @override
  String get conversationOfflineTitle => 'Du er frakoblet';

  @override
  String get conversationOfflineText => 'Samtalen er ikke lastet ned ennå. Den lastes inn når du er på nett igjen.';

  @override
  String get conversationErrorTitle => 'Kan ikke vise meldingen';

  @override
  String get conversationErrorText => 'Noe gikk galt.';

  @override
  String get conversationOfflineBanner => 'Du er frakoblet';

  @override
  String get conversationNotUpdated => 'Ikke oppdatert';

  @override
  String get conversationMe => 'meg';

  @override
  String get conversationNoSender => '(ingen avsender)';

  @override
  String get conversationNoRecipients => 'ingen mottakere';

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
  String get conversationHeaderCc => 'Kopi';

  @override
  String get conversationHeaderBcc => 'Blindkopi';

  @override
  String get conversationHeaderReplyTo => 'Svar til';

  @override
  String get conversationHeaderDate => 'Dato';

  @override
  String get conversationHeaderSecurity => 'Sikkerhet';

  @override
  String get conversationVerifiedSender => 'Verifisert avsender';

  @override
  String get conversationUnverifiedSender => 'Ikke verifisert avsender';

  @override
  String get conversationLoadingMessage => 'Laster inn meldingen';

  @override
  String get conversationBodyError => 'Kunne ikke laste inn meldingen.';

  @override
  String get conversationBodyOffline => 'Du er frakoblet. Meldingen lastes inn når du er på nett igjen.';

  @override
  String get conversationOriginalHint => 'Ser bedre ut i visningen Original';

  @override
  String get conversationShowOriginal => 'Vis original';

  @override
  String get conversationScrollToTop => 'Rull til toppen';

  @override
  String get conversationTagsMenu => 'Etiketter…';

  @override
  String get conversationMuteThread => 'Demp tråden';

  @override
  String get conversationUnmuteThread => 'Opphev demping av tråden';

  @override
  String get conversationMoveMenu => 'Flytt…';

  @override
  String get conversationDeletePermanently => 'Slett permanent';

  @override
  String get conversationMoveToTrash => 'Flytt til papirkurven';

  @override
  String get conversationNotJunk => 'Ikke søppelpost';

  @override
  String get conversationShowAllHeaders => 'Vis alle meldingshoder';

  @override
  String get conversationViewSource => 'Vis kilde';

  @override
  String get conversationSaveAsFile => 'Lagre som fil…';

  @override
  String get conversationShareAsFile => 'Del som fil…';

  @override
  String get conversationSearchFromMessageMenu => 'Søk ut fra denne meldingen…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopier adresse';

  @override
  String get conversationAddressCopied => 'Adressen er kopiert';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Søk etter meldinger fra $name';
  }

  @override
  String get conversationTags => 'Etiketter';

  @override
  String get conversationAllHeaders => 'Alle meldingshoder';

  @override
  String get conversationCopyAll => 'Kopier alt';

  @override
  String get conversationHeadersCopied => 'Meldingshodene er kopiert';

  @override
  String get conversationNoHeaders => 'Ingen meldingshoder';

  @override
  String get conversationSearchFromMessageTitle => 'Søk ut fra denne meldingen';

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
    return 'Emne «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Kilde';

  @override
  String get conversationSourceCopied => 'Kilden er kopiert';

  @override
  String get conversationShareFailed => 'Kunne ikke dele meldingen.';

  @override
  String get conversationWrapLines => 'Bryt linjer';

  @override
  String get conversationDontWrapLines => 'Ikke bryt linjer';

  @override
  String get conversationSourceError => 'Kunne ikke laste inn kilden.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Viser de første $shown av $total. Kopier eller del for å få med alt.';
  }

  @override
  String get conversationAttachmentUntitled => 'Uten navn';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Flere handlinger for $name';
  }

  @override
  String get conversationMoveTo => 'Flytt til…';

  @override
  String get conversationMailboxesError => 'Kunne ikke laste inn postkassene.';

  @override
  String get conversationReaderReadable => 'Lettlest';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Ren tekst';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Behold originalfargene';

  @override
  String get conversationReaderRemember => 'Husk for denne avsenderen';

  @override
  String get conversationSecurityPossiblePhishing => 'Mulig phishing';

  @override
  String get conversationSecurityBeCareful => 'Vær forsiktig';

  @override
  String get conversationSecurityVerified => 'Verifisert';

  @override
  String get conversationSecurityNoIssues => 'Ingen problemer funnet';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sporere', one: '1 sporer');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Viser hvorfor';

  @override
  String get conversationPhishingBannerTitle => 'Denne meldingen ser ut som phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Lenker og bilder er slått av.';
  }

  @override
  String get conversationPhishingBannerText => 'Lenker og bilder er slått av.';

  @override
  String get conversationPhishingWhy => 'Hvorfor?';

  @override
  String get conversationPhishingShowAnyway => 'Vis likevel';

  @override
  String get conversationSecurityPhishingTitle => 'Dette ser ut som phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Flere tegn tyder på at meldingen ikke er det den gir seg ut for å være.';

  @override
  String get conversationSecurityCarefulTitle => 'Vær forsiktig med denne meldingen';

  @override
  String get conversationSecurityCarefulText => 'Noe ved den fortjener en ekstra titt.';

  @override
  String get conversationSecurityVerifiedText => 'Avsenderen er verifisert, og ingenting ser mistenkelig ut.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ingenting ser mistenkelig ut. E-postserveren din oppga ikke om avsenderen er verifisert.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ingenting ser mistenkelig ut.';

  @override
  String get conversationSecurityWhy => 'Hvorfor';

  @override
  String get conversationSecurityPrivacy => 'Personvern';

  @override
  String get conversationSecurityNoTrackingPixels => 'Ingen sporingspiksler';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporingspiksler fjernet',
      one: '1 sporingspiksel fjernet',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'De ville ha fortalt avsenderen når du åpnet denne meldingen.';

  @override
  String get conversationSecurityNoRemoteImages => 'Ingen eksterne bilder';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eksterne bilder',
      one: '1 eksternt bilde',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Hvis de lastes inn, får avsenderen vite når du leser meldingen, og IP-adressen din.';

  @override
  String get conversationSecurityNoClickTracking => 'Ingen klikksporing';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lenker via klikksporing',
      one: '1 lenke via klikksporing',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services ville registrert klikket ditt. Trykk lenge på en lenke for å åpne målet direkte.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tekniske detaljer';

  @override
  String get conversationSecurityCheckedLocally => 'Sjekket på denne enheten. Ingenting ble sendt noe sted.';

  @override
  String get conversationSecurityTrackersLabel => 'Sporere';

  @override
  String get conversationSecurityImagesFrom => 'Bilder fra';

  @override
  String get conversationSecuritySenderHistory => 'Avsenderhistorikk';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received mottatt, $sent sendt';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Lenker fører til';

  @override
  String get conversationSecurityHidden => 'Skjult';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements elementer', one: '1 element');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters tegn');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Avsenderen er ikke verifisert';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'E-postserveren din kunne ikke bekrefte at meldingen virkelig kommer fra $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'E-postserveren din kunne ikke bekrefte at meldingen virkelig kommer fra avsenderen.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'E-postserveren din kunne ikke bekrefte at meldingen kommer fra $domain. Det er vanlig for e-postlister.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'E-postserveren din kunne ikke bekrefte at meldingen kommer fra avsenderen. Det er vanlig for e-postlister.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ikke gjør det den ber om med mindre du ventet den. Kontakt avsenderen på en annen måte hvis du er i tvil.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signert av et annet domene';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Meldingen er signert av $signer, ikke $domain. Det gjør utsendelsestjenester, men det beviser ikke hvem som skrev den.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Meldingen er signert av et annet domene, ikke $domain. Det gjør utsendelsestjenester, men det beviser ikke hvem som skrev den.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Navnet viser en annen adresse';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Avsenderens navn er «$shown», men meldingen kommer fra $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Stol på adressen, ikke navnet.';

  @override
  String get conversationSecurityReplyToTitle => 'Svar går et annet sted';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Hvis du svarer, sendes svaret ditt til $address, ikke til $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Sjekk adressen før du svarer med noe personlig.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Bruker navnet ditt';

  @override
  String get conversationSecurityImpersonationTitle => 'Bruker navnet til noen du kjenner';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Den er signert «$name», som ditt eget navn, men kommer fra en ny adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Den er signert «$name», som VIP-en din $knownName ($knownEmail), men kommer fra en ny adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Den er signert «$name», som $knownName ($knownEmail), men kommer fra en ny adresse: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Og svar ville gått til enda en annen adresse.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Hvis den ber om penger, koder eller filer, sjekk med personen på en annen måte først.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Kjent adresse: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Denne adressen: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Første melding fra denne avsenderen';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Du har ikke fått e-post fra $email før.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Vær forsiktig med forespørsler fra folk du ikke kjenner ennå.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Bokstaver som ligner til forveksling i avsenderens adresse';

  @override
  String get conversationSecurityLinkHomographTitle => 'Bokstaver som ligner til forveksling i en lenke';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host blander bokstaver fra ulike alfabeter for å etterligne en annen adresse.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host bruker bokstaver som ligner til forveksling: det er ikke $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Slett den, eller rapporter den som søppelpost.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ikke åpne den.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domene: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domene som ligner til forveksling';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Bruker et kjent navn i domenet sitt';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain ligner ditt eget domene, $real, men er et annet domene.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain ligner $brand ($real), men er et annet domene.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain bruker navnet på ditt eget domene, $real, men hører ikke til det.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain bruker navnet $brand ($real), men hører ikke til det.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Ekte meldinger fra organisasjonen din kommer fra $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Ekte meldinger fra $brand kommer fra $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Avsenderdomene: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Etterligner: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lenker skjuler hvor de fører',
      one: 'En lenke skjuler hvor den fører',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'En lenke viser $shown, men åpner $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ikke logg inn eller betal via disse lenkene. Skriv inn adressen selv i stedet.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Målet for en lenke kan ikke sjekkes';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'En lenke viser $shown, men går via $host, som registrerer klikket før det sendes videre.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'En lenke peker til en ren IP-adresse';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts er ikke et navngitt nettsted. Ekte bedrifter lenker sjelden slik.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'En forkledd lenke';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'En lenke starter med «$shown@» for å se ut som $shown, men åpner $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'En skjult side ble slått av';

  @override
  String get conversationSecurityDataLinkText =>
      'En lenke ville ha åpnet en side pakket inn i meldingen, en måte å omgå lenkesjekker på.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Ber om et passord';

  @override
  String get conversationSecurityPasswordFieldText => 'Meldingen inneholdt et passordfelt. Loupe fjernet det.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Skriv aldri inn et passord i en e-post.';

  @override
  String get conversationSecurityScriptLinkTitle => 'En lenke som kjører kode, ble slått av';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe kjører aldri kode fra meldinger.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Forkortede lenker',
      one: 'En forkortet lenke',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skjuler det egentlige målet til du åpner den.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Internasjonal nettadresse';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts bruker ikke-latinske bokstaver. Det er normalt for mange språk; sjekk at det er nettstedet du venter.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mye skjult tekst';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tegn med usynlig tekst ble fjernet. Skjult tekst som dette skal lure søppelpostfiltre.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skjult tekst fjernet';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tegn med usynlig tekst ble fjernet.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Kunne ikke laste ned meldingen. Sjekk tilkoblingen og prøv igjen.';

  @override
  String exportSaved(String name) {
    return '«$name» er lagret';
  }

  @override
  String get exportSaveFailed => 'Kunne ikke lagre meldingen.';

  @override
  String exportFailed(String folder) {
    return 'Kunne ikke eksportere «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» har ingen meldinger å eksportere.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Kunne ikke eksportere «$folder»: ingen meldinger kunne lastes ned. Sjekk tilkoblingen og prøv igjen.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '«$name» er lagret uten $formattedCount meldinger som ikke kunne lastes ned.',
      one: '«$name» er lagret uten 1 melding som ikke kunne lastes ned.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Kunne ikke lagre «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'Eksporterer «$folder»';
  }

  @override
  String get exportListing => 'Finner meldinger…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksporterer $current av $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount meldinger kunne ikke lastes ned',
      one: '1 melding kunne ikke lastes ned',
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
  String get mailboxesCollapse => 'Skjul';

  @override
  String get mailboxesExpand => 'Vis';

  @override
  String get mailboxesManageVips => 'Administrer VIP-er';

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
  String get mailboxesExportFolder => 'Eksporter mappe…';

  @override
  String get mailboxesUnpin => 'Løsne';

  @override
  String get mailboxesLists => 'Lister';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Lagre et søk for å ha det her.';

  @override
  String get mailboxesTags => 'Etiketter';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Du kan også trykke på navnet til en avsender i en melding og slå på VIP.';

  @override
  String get mailboxesAddVip => 'Legg til VIP…';

  @override
  String get mailboxesAddVipTitle => 'Legg til VIP';

  @override
  String get mailboxesAddVipText => 'E-post fra denne adressen får en stjerne og vises i VIP-postkassen.';

  @override
  String get mailboxesAddVipPlaceholder => 'navn@example.com';

  @override
  String get messageListFilterUnread => 'Uleste';

  @override
  String get messageListFilterFlagged => 'Flaggede';

  @override
  String get messageListFilterToMe => 'Til: meg';

  @override
  String get messageListFilterCcMe => 'Kopi: meg';

  @override
  String get messageListFilterWithAttachments => 'Med vedlegg';

  @override
  String get messageListFilterUnreplied => 'Ubesvarte';

  @override
  String get messageListFilterFromVips => 'Fra VIP-er';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er merket som lest',
      one: '1 melding er merket som lest',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Kunne ikke laste inn eldre e-post.';

  @override
  String get messageListSelectMessages => 'Velg meldinger';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count valgt');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Velg alle';

  @override
  String get messageListDeselectAll => 'Fjern alle valg';

  @override
  String get messageListLoadFailed => 'Kunne ikke laste inn e-post';

  @override
  String get messageListNoUnread => 'Ingen ulest e-post';

  @override
  String get messageListNoMatches => 'Ingen e-post passer';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrert etter: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Slå av filteret';

  @override
  String get messageListEmpty => 'Ingen e-post';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filterkriterier: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrert etter:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount uleste',
      one: '$formattedCount ulest',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Merk';

  @override
  String get messageListTrash => 'Papirkurv';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'INKLUDER';

  @override
  String get panesHideMailboxes => 'Skjul postkasser';

  @override
  String get panesShowMailboxes => 'Vis postkasser';

  @override
  String get panesMailboxesWidth => 'Bredde på postkasser';

  @override
  String get panesListWidth => 'Bredde på meldingslisten';

  @override
  String get panesNoMessageSelected => 'Ingen melding valgt';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meldinger', one: '1 melding');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Slumret';

  @override
  String get snoozeSheetTitle => 'Slumre';

  @override
  String get snoozeLaterToday => 'Senere i dag';

  @override
  String get snoozeThisEvening => 'I kveld';

  @override
  String get snoozeTomorrow => 'I morgen';

  @override
  String get snoozeThisWeekend => 'I helgen';

  @override
  String get snoozeNextWeek => 'Neste uke';

  @override
  String get snoozePickDateTime => 'Velg dato og klokkeslett…';

  @override
  String get snoozeMenu => 'Slumre…';

  @override
  String get snoozeWakeNow => 'Vekk nå';

  @override
  String get snoozeChangeTimeMenu => 'Endre slumretid…';

  @override
  String get snoozeChangeTime => 'Endre tid';

  @override
  String get snoozeNoTime => 'Ingen tid angitt';

  @override
  String get snoozeFooter => 'Slumrede meldinger kommer tilbake til innboksen som uleste på det valgte tidspunktet.';

  @override
  String get snoozeEmptyTitle => 'Ingenting slumret';

  @override
  String get snoozeEmptyText => 'Slumre en melding, så kommer den tilbake til innboksen når du trenger den.';

  @override
  String get appLockUnlock => 'Lås opp';

  @override
  String get appLockFailed => 'Loupe kunne ikke bekrefte at det er deg.';

  @override
  String get appLockLockedOut => 'For mange forsøk. Prøv igjen senere.';

  @override
  String get appLockPromptError => 'Kunne ikke vise dialogen. Prøv igjen.';

  @override
  String get appLockNoScreenLock => 'Denne telefonen har ingen skjermlås.';

  @override
  String get appLockUnlockPromptTitle => 'Lås opp Loupe';

  @override
  String get appLockUnlockPromptReason => 'Bekreft at det er deg, for å se e-posten din.';

  @override
  String get appLockTurnOnPromptTitle => 'Slå på Applås';

  @override
  String get appLockTurnOnPromptReason => 'Bekreft at det er deg, for å slå på Applås.';

  @override
  String get appLockScreenLockRemoved =>
      'Applås er slått av: telefonen har ikke lenger skjermlås. Konfigurer en for å slå på Applås igjen.';

  @override
  String get appLockAfterImmediately => 'Umiddelbart';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutter', one: '1 minutt');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count timer', one: '1 time');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Kryptert';

  @override
  String get openpgpEncryptedInPart => 'Delvis kryptert';

  @override
  String get openpgpEncryptedLocked => 'Kryptert · låst';

  @override
  String get openpgpEncryptedNoKey => 'Kryptert · ingen nøkkel';

  @override
  String get openpgpEncryptedDamaged => 'Kryptert · skadet';

  @override
  String get openpgpEncryptedUnsupported => 'Kryptert · støttes ikke';

  @override
  String get openpgpUnknownSigner => 'ukjent';

  @override
  String get openpgpUnknownKey => 'Ukjent nøkkel';

  @override
  String get openpgpSignatureInvalid => 'Ugyldig signatur';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signert av $name, ikke avsenderen';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Delvis signert av $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signert av $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signert med en avvist nøkkel';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signert av $name · nøkkelen er ikke godkjent';
  }

  @override
  String get openpgpUnlock => 'Lås opp';

  @override
  String get openpgpCantDecrypt => 'Kan ikke dekryptere meldingen';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Kryptert med OpenPGP';

  @override
  String get openpgpEncryption => 'Kryptering';

  @override
  String get openpgpDecryptedHere => 'Dekryptert på denne enheten';

  @override
  String get openpgpNotDecrypted => 'Ikke dekryptert';

  @override
  String get openpgpKeyLocked => 'Nøkkelen din er låst.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'For nøklene $keys',
      one: 'For nøkkelen $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Beskyttet emne';

  @override
  String get openpgpUnlockKey => 'Lås opp nøkkel';

  @override
  String get openpgpSignature => 'Signatur';

  @override
  String get openpgpFingerprint => 'Fingeravtrykk';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Nøkkel-ID $id';
  }

  @override
  String get openpgpSigned => 'Signert';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Godkjenning';

  @override
  String get openpgpChangeAcceptance => 'Endre godkjenning…';

  @override
  String get openpgpCheckedFooter => 'Sjekket på denne enheten med OpenPGP, kompatibelt med Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Nøkkelen din er låst. Lås den opp med passordfrasen for å lese meldingen.';

  @override
  String get openpgpSummaryNoSecretKey => 'Den ble kryptert til en nøkkel som ikke finnes på denne enheten.';

  @override
  String get openpgpSummaryDamaged => 'De krypterte dataene er skadet eller ble endret underveis.';

  @override
  String get openpgpSummaryUnsupported => 'Den bruker en algoritme som Loupe ikke støtter.';

  @override
  String get openpgpSummaryEncrypted => 'Bare du og de andre mottakerne kan lese den.';

  @override
  String get openpgpSummaryNotSigned => 'Den er ikke signert, så avsenderen er ikke bekreftet.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Den er signert, men med en nøkkel du ikke har, så signaturen kan ikke sjekkes.';

  @override
  String get openpgpSummaryBadSignature => 'Signaturen stemmer ikke: meldingen kan ha blitt endret.';

  @override
  String get openpgpSummaryMismatch => 'Signaturen er gyldig, men nøkkelen tilhører en annen adresse enn avsenderens.';

  @override
  String get openpgpSummaryPartial =>
      'Bare en del av meldingen er signert. Tekst utenfor signaturen (for eksempel en bunntekst fra en e-postliste) vises under linjen «Unsigned content», og andre deler av meldingen, som vedlegg, er heller ikke dekket.';

  @override
  String get openpgpSummaryOwnKey => 'Signert med din egen nøkkel.';

  @override
  String get openpgpSummaryVerified => 'Signaturen er gyldig, og du har verifisert fingeravtrykket til nøkkelen.';

  @override
  String get openpgpSummaryUnverified => 'Signaturen er gyldig. Du godkjente nøkkelen uten å sjekke fingeravtrykket.';

  @override
  String get openpgpSummaryRejected => 'Signaturen er gyldig, men du har avvist denne nøkkelen.';

  @override
  String get openpgpSummaryUndecided =>
      'Signaturen er gyldig, men du har ikke godkjent nøkkelen ennå. Sammenlign fingeravtrykket med avsenderen.';

  @override
  String get openpgpAcceptanceRejected => 'Avvist';

  @override
  String get openpgpAcceptanceUndecided => 'Ikke godkjent';

  @override
  String get openpgpAcceptanceUnverified => 'Godkjent';

  @override
  String get openpgpAcceptanceVerified => 'Godkjent og verifisert';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Vil du godkjenne nøkkelen til $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingeravtrykk $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ja, jeg har verifisert fingeravtrykket';

  @override
  String get openpgpAcceptUnverified => 'Ja, uten å sjekke';

  @override
  String get openpgpAcceptLater => 'Ikke ennå';

  @override
  String get openpgpRejectKey => 'Avvis denne nøkkelen';

  @override
  String get openpgpNoSubject => '(uten emne)';

  @override
  String get openpgpEncryptionTitle => 'Ende-til-ende-kryptering';

  @override
  String get openpgpMyKeys => 'Mine OpenPGP-nøkler';

  @override
  String get openpgpMyKeysFooter =>
      'Med en nøkkel kan du lese kryptert e-post og signere og kryptere din egen. Bruker du Thunderbird? Eksporter nøkkelen din der (Kontoinnstillinger › Ende-til-ende-kryptering › Eksporter hemmelig nøkkel), og importer den her.';

  @override
  String get openpgpAddKey => 'Legg til nøkkel…';

  @override
  String get openpgpAddresses => 'Adresser';

  @override
  String get openpgpAddressesFooter => 'Hvilken nøkkel hver adresse bruker, og når den krypterer og signerer.';

  @override
  String get openpgpCorrespondentsKeys => 'Korrespondenters OpenPGP-nøkler';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Godkjenn en nøkkel når du stoler på at den tilhører eieren; sammenlign fingeravtrykket med eieren for å merke den som verifisert.';

  @override
  String get openpgpImportPublicKey => 'Importer offentlig nøkkel…';

  @override
  String get openpgpCollected => 'Samlet inn via Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Nøkler som har kommet med meldinger. Loupe kan kryptere til dem når begge parter ber om det.';

  @override
  String get openpgpOnThisDevice => 'På denne enheten';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Krypterte meldinger skjuler emnet sitt. Loupe lagrer emnet til hver melding du åpner, i den krypterte databasen på denne enheten, slik at listen, søk og varsler kan vise det. I bakgrunnen kan Loupe også dekryptere emnet i nye meldinger med nøkler uten passordfrase; da lastes hver melding (opptil 1 MB) ned.';

  @override
  String get openpgpDecryptSubjects => 'Dekrypter emner i bakgrunnen';

  @override
  String get openpgpIndexFooter =>
      'Søk finner krypterte meldinger etter avsender, mottakere og emne. Når dette er på, legger Loupe også teksten i hver krypterte melding den dekrypterer, til søkeindeksen i den krypterte databasen på denne enheten, slik at søk også finner den etter teksten. Slår du det av, fjernes teksten fra indeksen.';

  @override
  String get openpgpIndexDecrypted => 'Indekser dekrypterte meldinger for søk';

  @override
  String get openpgpPassphrases => 'Passordfraser';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-nøkler og S/MIME-sertifikater som du beskytter med en passordfrase, låses opp når det trengs. Uten «Husk» låses de igjen to minutter etter hver bruk.';

  @override
  String get openpgpRememberPassphrases => 'Husk passordfraser';

  @override
  String get openpgpRememberPassphrasesDetail => 'Til Loupe lukkes';

  @override
  String get openpgpLockKeysNow => 'Lås nøkler nå';

  @override
  String get openpgpKeysLocked => 'Nøklene er låst.';

  @override
  String get openpgpKeyStateRevoked => 'tilbakekalt';

  @override
  String get openpgpKeyStateExpired => 'utløpt';

  @override
  String get openpgpKeyStateNeverExpires => 'utløper aldri';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'utløper $date';
  }

  @override
  String get openpgpNoKey => 'Ingen nøkkel';

  @override
  String get openpgpAlwaysEncrypt => 'Krypter alltid';

  @override
  String get openpgpAddKeyTitle => 'Legg til en OpenPGP-nøkkel';

  @override
  String get openpgpAddKeyMessage => 'Importer nøkkelen du bruker i Thunderbird, eller lag en ny.';

  @override
  String get openpgpImportFromClipboard => 'Importer fra utklippstavlen';

  @override
  String get openpgpImportFromFile => 'Importer fra fil';

  @override
  String get openpgpGenerateNewKey => 'Generer ny nøkkel';

  @override
  String get openpgpImportPublicKeyTitle => 'Importer en offentlig nøkkel';

  @override
  String get openpgpFromClipboard => 'Fra utklippstavlen';

  @override
  String get openpgpFromFile => 'Fra fil';

  @override
  String get openpgpClipboardEmpty => 'Utklippstavlen er tom. Kopier nøkkelen først.';

  @override
  String get openpgpKey => 'Nøkkel';

  @override
  String get openpgpValidityRevoked => 'Tilbakekalt';

  @override
  String openpgpValidityExpired(String date) {
    return 'Utløp $date';
  }

  @override
  String get openpgpNeverExpires => 'Utløper aldri';

  @override
  String openpgpValidUntil(String date) {
    return 'Gyldig til $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingeravtrykket er kopiert.';

  @override
  String get openpgpAlgorithm => 'Algoritme';

  @override
  String get openpgpCreated => 'Opprettet';

  @override
  String get openpgpValidity => 'Gyldighet';

  @override
  String get openpgpProtection => 'Beskyttelse';

  @override
  String get openpgpProtectionPassphrase => 'Passordfrase';

  @override
  String get openpgpProtectionKeychain => 'Bare telefonens nøkkellager';

  @override
  String get openpgpKeyDetailsFooter =>
      'Del den offentlige nøkkelen din, så andre kan kryptere til deg. Sikkerhetskopien er den hemmelige nøkkelen din, beskyttet av passordfrasen hvis den har en: hold den privat.';

  @override
  String get openpgpSharePublicKey => 'Del offentlig nøkkel';

  @override
  String get openpgpCopyPublicKey => 'Kopier offentlig nøkkel';

  @override
  String get openpgpPublicKeyCopied => 'Den offentlige nøkkelen er kopiert.';

  @override
  String get openpgpBackUpSecretKey => 'Sikkerhetskopier hemmelig nøkkel';

  @override
  String get openpgpDeleteKey => 'Slett nøkkel';

  @override
  String get openpgpRemoveKey => 'Fjern nøkkel';

  @override
  String get openpgpBackUpTitle => 'Vil du sikkerhetskopiere den hemmelige nøkkelen?';

  @override
  String get openpgpBackUpProtected =>
      'Sikkerhetskopien er beskyttet av passordfrasen til nøkkelen. Alle som har begge deler, kan lese e-posten din.';

  @override
  String get openpgpBackUpUnprotected =>
      'Denne nøkkelen har ingen passordfrase: alle med sikkerhetskopien kan lese e-posten din og signere som deg.';

  @override
  String get openpgpBackUp => 'Sikkerhetskopier';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Vil du slette nøkkelen din $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Vil du fjerne nøkkelen til $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'E-post som er kryptert til denne nøkkelen, kan ikke lenger leses på denne enheten med mindre du importerer den igjen.';

  @override
  String get openpgpRemoveKeyMessage => 'Du kan importere den igjen senere.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-nøkkel';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Legg til en nøkkel under Ende-til-ende-kryptering for å kryptere og signere e-post fra denne adressen.';

  @override
  String get openpgpGenerateAKey => 'Generer en nøkkel…';

  @override
  String get openpgpSending => 'Sending';

  @override
  String get openpgpSendingFooter =>
      'Automatisk kryptering slås på når alle mottakere har en godkjent nøkkel eller et klarert sertifikat, eller når Autocrypt sier at begge parter ønsker det. Kryptert e-post signeres alltid.';

  @override
  String get openpgpEncryptAutomatically => 'Krypter automatisk';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nekter å sende når en mottaker ikke har nøkkel';

  @override
  String get openpgpSignUnencrypted => 'Signer ukryptert e-post';

  @override
  String get openpgpAttachPublicKey => 'Legg ved den offentlige nøkkelen min';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt sender den offentlige nøkkelen din med hver melding, så andre apper kan kryptere til deg uten oppsett.';

  @override
  String get openpgpSendMyKey => 'Send nøkkelen min med e-post';

  @override
  String get openpgpPreferEncryption => 'Foretrekk kryptering';

  @override
  String get openpgpPreferEncryptionDetail => 'Be andre om å kryptere når de kan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count år', one: '1 år');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Passordfrasene er ikke like.';

  @override
  String openpgpKeyReady(String id) {
    return 'Nøkkelen din $id er klar.';
  }

  @override
  String get openpgpNewKey => 'Ny nøkkel';

  @override
  String get openpgpNewKeyFor => 'For';

  @override
  String get openpgpYourName => 'Navnet ditt';

  @override
  String get openpgpAddress => 'Adresse';

  @override
  String get openpgpPassphrase => 'Passordfrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valgfritt. Uten passordfrase beskyttes nøkkelen bare av telefonens nøkkellager, og Loupe spør aldri. Med en spør Loupe etter den når nøkkelen trengs.';

  @override
  String get openpgpRepeatPassphrase => 'Gjenta';

  @override
  String get openpgpExpires => 'Utløper';

  @override
  String get openpgpExpiresFooter => 'Du kan lage en ny nøkkel før den utløper. Thunderbird bruker også tre år.';

  @override
  String get openpgpGenerateKey => 'Generer nøkkel';

  @override
  String get openpgpKeyFor => 'Nøkkel for';

  @override
  String get openpgpCantEncrypt => 'Kan ikke kryptere';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Det finnes ingen OpenPGP-nøkkel for $names, og denne adressen krypterer alltid. Fjern mottakeren, eller importer nøkkelen deres under Innstillinger › Ende-til-ende-kryptering.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Det finnes ikke noe gyldig S/MIME-sertifikat for $names, og denne adressen krypterer alltid. Fjern mottakeren, eller importer sertifikatet deres under Innstillinger › Ende-til-ende-kryptering.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Det finnes ingen OpenPGP-nøkkel for $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Det finnes ikke noe gyldig S/MIME-sertifikat for $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Send ukryptert';

  @override
  String get openpgpCantSign => 'Kan ikke signere';

  @override
  String get openpgpCantSignMessage =>
      'Den private nøkkelen til S/MIME-sertifikatet ditt finnes ikke på denne enheten. Importer sertifikatet igjen (en .p12- eller .pfx-fil) under Innstillinger › Ende-til-ende-kryptering.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Ingen nøkkel for $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Ikke noe sertifikat for $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Nøkler fra Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Alle har en nøkkel';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Alle har et sertifikat';

  @override
  String get openpgpComposeEncrypt => 'Krypter';

  @override
  String get openpgpComposeSign => 'Signer';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, bytt';
  }

  @override
  String get openpgpNoKeyFound => 'Fant ingen OpenPGP-nøkkel.';

  @override
  String get openpgpImportSecretKeyTitle => 'Vil du importere en hemmelig nøkkel?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Dette vedlegget inneholder en hemmelig nøkkel ($names). Importer den som din egen nøkkel bare hvis du har eksportert den selv, for eksempel fra Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importer som min nøkkel';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'nøkkelen din $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du importere $count nøkler ($names)?',
      one: 'Vil du importere nøkkelen til $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importer og godkjenn';

  @override
  String get openpgpImportDecideLater => 'Importer, bestem senere';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'nøkkelen til $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importert: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-nøkler er vedlagt.',
      one: 'En OpenPGP-nøkkel er vedlagt.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importer';

  @override
  String get openpgpUnlockKeyTitle => 'Lås opp OpenPGP-nøkkel';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Skriv inn passordfrasen til nøkkelen til $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Passordfrasen er feil. Prøv igjen.';

  @override
  String get openpgpExplainLocked => 'Denne meldingen er kryptert. Lås opp OpenPGP-nøkkelen din for å lese den.';

  @override
  String get openpgpExplainNoKey =>
      'Denne meldingen er kryptert, men ikke til noen OpenPGP-nøkkel på denne enheten. Hvis du leser den i Thunderbird, importer nøkkelen din derfra: Innstillinger › Ende-til-ende-kryptering.';

  @override
  String get openpgpExplainDamaged => 'Denne krypterte meldingen er skadet, så den kan ikke dekrypteres trygt.';

  @override
  String get openpgpExplainUnsupported => 'Denne meldingen bruker kryptering som Loupe ikke kan lese ennå.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Denne meldingen er kryptert med S/MIME, men ikke til noe sertifikat på denne enheten. Importer sertifikatet ditt (en .p12- eller .pfx-fil) under Innstillinger › Ende-til-ende-kryptering.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Denne meldingen er kryptert. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Lås opp S/MIME-sertifikatet ditt for å lese den.';

  @override
  String get openpgpAttachmentGone => 'Dette vedlegget er ikke lenger tilgjengelig.';

  @override
  String get smimeEncrypted => 'Kryptert (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Kryptert (S/MIME) · ikke noe sertifikat';

  @override
  String get smimeEncryptedDamaged => 'Kryptert (S/MIME) · skadet';

  @override
  String get smimeEncryptedUnsupported => 'Kryptert (S/MIME) · støttes ikke';

  @override
  String get smimeEncryptedLocked => 'Kryptert (S/MIME) · låst';

  @override
  String get smimeUnknownSigner => 'ukjent';

  @override
  String get smimeSignatureModified => 'Ugyldig signatur: meldingen er endret';

  @override
  String get smimeSignatureWeak => 'Usikker signatur: utdatert algoritme';

  @override
  String get smimeSignatureUncheckable => 'Signaturen kan ikke sjekkes';

  @override
  String get smimeSignedCertificateMissing => 'Signert · sertifikat mangler';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signert av $name · sertifikatet er tilbakekalt';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signert av $name · på en annen dato';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signert av $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signert av $name · ugyldig sertifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signert av $name · ikke klarert';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signert av $name · sertifikatet er utløpt';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signert av $name · sertifikatet er ikke gyldig ennå';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signert av $name · sertifikatet er ikke for e-post';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signert av $name, ikke avsenderen';
  }

  @override
  String get smimeCantDecrypt => 'Kan ikke dekryptere meldingen';

  @override
  String get smimeEncryptedWithSmime => 'Kryptert med S/MIME';

  @override
  String get smimeEncryption => 'Kryptering';

  @override
  String get smimeDecryptedHere => 'Dekryptert på denne enheten';

  @override
  String get smimeNotDecrypted => 'Ikke dekryptert';

  @override
  String get smimeAuthenticated => 'autentisert';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'til $count sertifikater',
      one: 'til 1 sertifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatur';

  @override
  String get smimeIssuedBy => 'Utstedt av';

  @override
  String get smimeValid => 'Gyldig';

  @override
  String smimeValidRange(String from, String to) {
    return '$from til $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-fingeravtrykk';

  @override
  String get smimeSigned => 'Signert';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Sjekker tilbakekalling…';

  @override
  String get smimeNotRevoked => 'Ikke tilbakekalt';

  @override
  String get smimeRevoked => 'Tilbakekalt';

  @override
  String get smimeRevocationUnknown => 'Ukjent om det er tilbakekalt';

  @override
  String smimeRevokedSince(String date) {
    return 'Siden $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Spurte utstederen (tilbakekallingslisten), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Spurte utstederen (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Stol på «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Stol på dette sertifikatet…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Sjekket på denne enheten med S/MIME, kompatibelt med Outlook og Thunderbird; tilbakekalling hos sertifikatutstederen.';

  @override
  String get smimeCheckedFooter =>
      'Sjekket på denne enheten med S/MIME, kompatibelt med Outlook og Thunderbird. Tilbakekalling sjekkes ikke (Innstillinger › Ende-til-ende-kryptering).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vil du stole på $name for e-post?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vil du stole på sertifikatet til $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Alle sertifikater denne utstederen utsteder, blir klarert, som bedriftens CA. Sammenlign først fingeravtrykket med eieren:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Sammenlign først fingeravtrykket med eieren:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Stol på';

  @override
  String get smimeSummaryNoKey => 'Den ble kryptert til et sertifikat som ikke finnes på denne enheten.';

  @override
  String get smimeSummaryDamaged => 'De krypterte dataene er skadet eller ble endret underveis.';

  @override
  String get smimeSummaryUnsupported => 'Den bruker en algoritme som Loupe ikke støtter.';

  @override
  String get smimeSummaryLocked => 'S/MIME-sertifikatet ditt er låst.';

  @override
  String get smimeSummaryEncrypted => 'Bare du og de andre mottakerne kan lese den.';

  @override
  String get smimeSummaryNotSigned => 'Den er ikke signert, så avsenderen er ikke bekreftet.';

  @override
  String get smimeSummaryModified => 'Signaturen stemmer ikke: meldingen ble endret etter at den ble signert.';

  @override
  String get smimeSummaryUncheckable => 'Signaturen kan ikke sjekkes.';

  @override
  String get smimeSummaryNoCertificate =>
      'Sertifikatet til den som signerte, er ikke med i meldingen, så den kan ikke sjekkes.';

  @override
  String get smimeSummaryRevoked =>
      'Sertifikatutstederen har tilbakekalt sertifikatet til den som signerte: signaturen kan ikke klareres.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Sertifikatutstederen har tilbakekalt sertifikatet til den som signerte ($reason): signaturen kan ikke klareres.';
  }

  @override
  String get smimeDateMismatch =>
      'Den ble signert mer enn en time unna datoen på meldingen: det kan være en gammel melding som er sendt på nytt.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Signaturen er gyldig, og $issuer går god for at sertifikatet tilhører avsenderen.';
  }

  @override
  String get smimeProblemInvalidChain => 'Sertifikatet eller en av utstederne er ugyldig.';

  @override
  String get smimeProblemUntrusted => 'Sertifikatet kommer fra en utsteder som Loupe ikke stoler på.';

  @override
  String get smimeProblemExpired => 'Sertifikatet var utløpt.';

  @override
  String get smimeProblemNotYetValid => 'Sertifikatet var ikke gyldig ennå.';

  @override
  String get smimeProblemWrongUsage => 'Sertifikatet er ikke beregnet for e-post.';

  @override
  String get smimeProblemWrongAddress => 'Sertifikatet tilhører en annen adresse enn avsenderens.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Klarert · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ikke klarert · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Utløp $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Gyldig fra $date';
  }

  @override
  String get smimeTrustInvalid => 'Ugyldig';

  @override
  String get smimeTrustNotForMail => 'Ikke for e-post';

  @override
  String get smimeTrustAnotherAddress => 'En annen adresse';

  @override
  String get smimeMyCertificates => 'Mine S/MIME-sertifikater';

  @override
  String get smimeMyCertificatesFooter =>
      'For S/MIME, slik Outlook og mange bedrifter bruker det. Importer sertifikatet ditt med den private nøkkelen (en .p12- eller .pfx-fil), eksportert fra Outlook, Windows, macOS eller Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'For S/MIME, slik Outlook og mange bedrifter bruker det. Importer sertifikatet ditt med den private nøkkelen (en .p12- eller .pfx-fil), eksportert fra Outlook, Windows, macOS eller Thunderbird, eller bruk et som bedriften din eller du selv har installert på denne enheten.';

  @override
  String get smimeCertificateExpired => 'utløpt';

  @override
  String smimeCertificateUntil(String date) {
    return 'til $date';
  }

  @override
  String get smimeCertificateOnDevice => 'på denne enheten';

  @override
  String get smimeImportCertificateEllipsis => 'Importer sertifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Bruk et sertifikat fra denne enheten…';

  @override
  String get smimeCorrespondentsCertificates => 'Korrespondenters sertifikater';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Samlet inn fra signert e-post, slik Outlook og Thunderbird gjør. E-post krypteres bare til klarerte sertifikater: Loupe stoler på utstederne Mozilla stoler på for e-post, og dem du legger til.';

  @override
  String get smimeRevocation => 'Tilbakekalling';

  @override
  String get smimeRevocationFooter =>
      'Når du åpner signert e-post, spør Loupe utstederen av sertifikatet til den som signerte, om det er tilbakekalt (via utstederens OCSP-tjeneste eller tilbakekallingsliste). Utstederen kan da se når noen på internettadressen din leser e-post som er signert med det sertifikatet. Svarene lagres på denne enheten til de utløper. Et tilbakekalt sertifikat vises som «tilbakekalt» i meldingshodet.';

  @override
  String get smimeCheckRevocation => 'Sjekk tilbakekalling av sertifikater på nett';

  @override
  String get smimeTrustedAuthorities => 'Klarerte utstedere';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Klarert av deg, i tillegg til de $count som Mozilla stoler på for e-post.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Sertifikatutsteder';

  @override
  String get smimeImportACertificate => 'Importer et sertifikat';

  @override
  String get smimeImportContactMessage =>
      'En korrespondents sertifikat (.cer, .crt, .pem) eller en sertifikatutsteders.';

  @override
  String get smimeFromClipboard => 'Fra utklippstavlen';

  @override
  String get smimeFromFile => 'Fra fil';

  @override
  String get smimeClipboardEmpty => 'Utklippstavlen er tom. Kopier sertifikatet først.';

  @override
  String get smimeCertificate => 'Sertifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Den private nøkkelen blir værende i Androids legitimasjonslager, der bedriften din eller du selv installerte den: Loupe ber Android om å signere og dekryptere med den. Signert e-post signeres når du sender den.';

  @override
  String get smimeAddresses => 'Adresser';

  @override
  String get smimeUsage => 'For';

  @override
  String get smimeUsageNone => 'Ingenting Loupe bruker';

  @override
  String get smimeUsageSigning => 'Signering';

  @override
  String get smimeUsageEncryption => 'Kryptering';

  @override
  String get smimeUsageCertificates => 'Sertifikater';

  @override
  String get smimeAlgorithm => 'Algoritme';

  @override
  String get smimeSerialNumber => 'Serienummer';

  @override
  String get smimeFingerprintCopied => 'Fingeravtrykket er kopiert.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-avtrykk';

  @override
  String get smimePrivateKey => 'Privat nøkkel';

  @override
  String get smimeKeyOnDevice => 'På denne enheten';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'I Loupe, med en passordfrase';

  @override
  String get smimeKeyInLoupe => 'I Loupe';

  @override
  String get smimeSource => 'Fra';

  @override
  String get smimeSourceSignedMail => 'Signert e-post';

  @override
  String get smimeSourceImported => 'Importert';

  @override
  String get smimeTrustHeader => 'Tillit';

  @override
  String get smimeTrustedRoot => 'Klarert rot';

  @override
  String get smimeIssuer => 'Utsteder';

  @override
  String smimeTrustNamed(String name) {
    return 'Stol på «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Stol på denne utstederen';

  @override
  String get smimeTrustThisCertificate => 'Stol på dette sertifikatet';

  @override
  String get smimeStopTrusting => 'Slutt å stole på';

  @override
  String get smimePassphrase => 'Passordfrase';

  @override
  String get smimePassphraseFooter =>
      'Valgfritt. Med en passordfrase krypteres den private nøkkelen også på denne enheten (Argon2id og AES-256), og Loupe ber om den for å signere og dekryptere; Husk passordfraser bestemmer hvor lenge. E-post du sender, signeres idet du sender den; arbeid i bakgrunnen kan ikke bruke nøkkelen.';

  @override
  String get smimeChangePassphrase => 'Endre passordfrase…';

  @override
  String get smimeSetPassphraseEllipsis => 'Angi passordfrase…';

  @override
  String get smimeRemovePassphrase => 'Fjern passordfrase';

  @override
  String get smimeShareCertificate => 'Del sertifikat';

  @override
  String get smimeDeleteCertificate => 'Slett sertifikat';

  @override
  String get smimeRemoveCertificate => 'Fjern sertifikat';

  @override
  String get smimePassphraseChanged => 'Passordfrasen er endret.';

  @override
  String get smimePassphraseSet => 'Passordfrasen er angitt.';

  @override
  String get smimeRemovePassphraseTitle => 'Vil du fjerne passordfrasen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Den private nøkkelen beskyttes da bare av nøkkellageret, som uten passordfrase: Loupe spør ikke lenger etter den, og arbeid i bakgrunnen kan bruke den.';

  @override
  String get smimePassphraseRemoved => 'Passordfrasen er fjernet.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vil du stole på $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Alle sertifikater den utsteder, blir klarert for e-post. Sammenlign først fingeravtrykket med eieren:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Vil du slette sertifikatet ditt $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Vil du fjerne sertifikatet til $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe slutter å bruke det: e-post som er kryptert til det, kan ikke lenger leses i Loupe. Sertifikatet blir værende på denne enheten (Innstillinger › Sikkerhet › Kryptering og legitimasjon).';

  @override
  String get smimeDeleteOwnMessage =>
      'Den private nøkkelen slettes fra denne enheten: e-post som er kryptert til den, kan ikke lenger leses her med mindre du importerer den igjen.';

  @override
  String get smimeRemoveContactMessage => 'Det kommer tilbake med personens neste signerte melding.';

  @override
  String get smimeAddressImportFooter =>
      'Importer et sertifikat for denne adressen for å signere og kryptere med S/MIME, slik Outlook gjør.';

  @override
  String get smimeImportACertificateEllipsis => 'Importer et sertifikat…';

  @override
  String get smimePreferFooter =>
      'Når begge kan beskytte en melding, brukes den foretrukne, med mindre bare den andre har en nøkkel eller et sertifikat for alle mottakerne.';

  @override
  String get smimePreferSmime => 'Foretrekk S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Fremfor OpenPGP';

  @override
  String get smimeCertificatePassword => 'Sertifikatpassord';

  @override
  String get smimeCertificatePasswordPrompt => 'Skriv inn passordet sertifikatfilen ble eksportert med.';

  @override
  String get smimeImport => 'Importer';

  @override
  String get smimeWrongPassword => 'Passordet er feil. Prøv igjen.';

  @override
  String get smimeNoCertificateFound => 'Fant ikke noe sertifikat.';

  @override
  String smimeCertificateOf(String name) {
    return 'sertifikatet til $name';
  }

  @override
  String get smimeNothingNew => 'Ingenting nytt å importere.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importert: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerte $count klarerte utstedere.',
      one: 'Importerte en klarert utsteder.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerte $certificates og $count klarerte utstedere.',
      one: 'Importerte $certificates og en klarert utsteder.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Denne filen har ingen privat nøkkel. Eksporter sertifikatet ditt med den private nøkkelen.';

  @override
  String get smimeImportAsYoursTitle => 'Vil du importere det som sertifikatet ditt?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Dette vedlegget inneholder et sertifikat med den private nøkkelen: $names. Importer det bare hvis du har eksportert det selv, for eksempel fra Outlook eller Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importer som mitt sertifikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Sertifikatet ditt $names er importert.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Sertifikatet ditt $name ($addresses) er lagt til fra denne enheten.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vil du stole på «$name» for e-post?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe kjenner ikke denne sertifikatutstederen (kanskje en bedrifts egen). Stol på den for å sjekke sertifikatene den utsteder. Sammenlign først fingeravtrykket med IT-avdelingen din:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifikater er vedlagt.',
      one: 'Et sertifikat er vedlagt.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importer sertifikat';

  @override
  String get smimeUnlockTitle => 'Lås opp S/MIME-sertifikat';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Skriv inn passordfrasen til sertifikatet til $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Passordfrasen er feil. Prøv igjen.';

  @override
  String get smimeUnlock => 'Lås opp';

  @override
  String get smimeEnterAPassphrase => 'Skriv inn en passordfrase.';

  @override
  String get smimePassphrasesDiffer => 'De to passordfrasene er ulike.';

  @override
  String get smimeSetPassphraseTitle => 'Angi passordfrase';

  @override
  String get smimeSetPassphraseText =>
      'Loupe ber om den for å signere og dekryptere. Hvis du glemmer den, importerer du sertifikatet på nytt fra .p12-filen.';

  @override
  String get smimePassphraseAgain => 'Igjen';

  @override
  String get smimeSetPassphraseButton => 'Angi';

  @override
  String get smimeLockedOpenAgain => 'S/MIME-sertifikatet ditt er låst. Åpne meldingen på nytt for å låse det opp.';

  @override
  String get smimeDeviceHasNoCertificates => 'Denne enheten tilbyr ikke sertifikatene sine.';

  @override
  String get smimeCantReadCertificate => 'Loupe kan ikke lese dette sertifikatet.';

  @override
  String get smimeCertificateNotForMail =>
      'Dette sertifikatet er ikke for e-post: det har ingen e-postadresse eller er ikke beregnet for signering eller kryptering.';

  @override
  String get smimeDeviceCertificateGone =>
      'Sertifikatet finnes ikke lenger på denne enheten, eller Loupe har ikke lenger lov til å bruke det. Velg det på nytt under Innstillinger › Ende-til-ende-kryptering.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Sertifikatet på denne enheten kan bare brukes mens Loupe er åpen.';

  @override
  String get smimeDeviceKeyDamaged => 'Den krypterte nøkkelen er skadet.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Sertifikatet på denne enheten kan ikke gjøre dette: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'støttes ikke';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Sertifikatet på denne enheten mislyktes: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Utstederens adresse er ikke en nettadresse.';

  @override
  String get smimeAuthorityTimeout => 'Sertifikatutstederen svarte ikke i tide.';

  @override
  String get smimeAuthorityUnreachable => 'Kunne ikke nå sertifikatutstederen.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Sertifikatutstederen svarte $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Svaret fra sertifikatutstederen er for stort.';

  @override
  String get smimeRevocationNotChecked =>
      'Ikke sjekket: bare sertifikater fra en utsteder Loupe stoler på, blir sjekket.';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Samme som telefonen';

  @override
  String get settingsLanguageFooter =>
      'Loupe bruker telefonens språk når appen har det, og ellers engelsk. Språket du velger her, gjelder bare for Loupe, også varsler.';

  @override
  String get settingsAccountsHeader => 'Kontoer';

  @override
  String get settingsAddAccount => 'Legg til konto';

  @override
  String get settingsMailHeader => 'E-post';

  @override
  String get settingsSwipeActions => 'Sveipehandlinger';

  @override
  String get settingsSwipeLeft => 'Sveip mot venstre';

  @override
  String get settingsSwipeLeftFooter =>
      'Et helt sveip utfører denne handlingen. Flagg og Mer er alltid et kort sveip unna.';

  @override
  String get settingsSwipeRight => 'Sveip mot høyre';

  @override
  String get settingsSwipeRightFooter => 'Et helt sveip utfører denne handlingen.';

  @override
  String get settingsSwipeToggleRead => 'Merk som lest/ulest';

  @override
  String get settingsSwipeTrash => 'Papirkurv';

  @override
  String get settingsSwipeMove => 'Flytt melding';

  @override
  String get settingsSwipeSnooze => 'Slumre';

  @override
  String get settingsThreaded => 'Organiser etter samtale';

  @override
  String get settingsUndoSendDelay => 'Forsinkelse for angre sending';

  @override
  String get settingsUndoSendDelayFooter => 'Sendte meldinger venter så lenge, slik at du kan trekke dem tilbake.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds sekunder', one: '1 sekund');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Utseende';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatisk';

  @override
  String get settingsThemeLight => 'Lyst';

  @override
  String get settingsThemeDark => 'Mørkt';

  @override
  String get settingsDensity => 'Meldingsliste';

  @override
  String get settingsDensityComfortable => 'Luftig';

  @override
  String get settingsDensityCompact => 'Kompakt';

  @override
  String get settingsReadingHeader => 'Lesing';

  @override
  String get settingsReadingFooter => 'Eksterne bilder kan fortelle avsendere når og hvor du åpnet en melding.';

  @override
  String get settingsDefaultView => 'Standardvisning';

  @override
  String get settingsDefaultViewFooter => 'Du kan bytte visning for hvilken som helst melding med Aa-knappen.';

  @override
  String get settingsViewReadable => 'Lettlest';

  @override
  String get settingsViewReadableDetail => 'Ryddig og tydelig, følger mørk modus';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Akkurat slik avsenderen utformet den';

  @override
  String get settingsViewPlain => 'Ren tekst';

  @override
  String get settingsViewPlainDetail => 'Bare ordene';

  @override
  String get settingsPlainTextFont => 'Skrift for ren tekst';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Fast bredde';

  @override
  String get settingsFontMonoDetail => 'Holder ASCII-kunst og tabeller på linje';

  @override
  String get settingsTechnicalLists => 'Tekniske lister';

  @override
  String get settingsLoadRemoteImages => 'Last inn eksterne bilder';

  @override
  String get settingsOpenLinksDirectly => 'Åpne lenker direkte';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Hopp over klikksporing når målet er kjent';

  @override
  String get settingsSecurityHeader => 'Sikkerhet';

  @override
  String get settingsAppLock => 'Applås';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe spør når appen starter, og når du kommer tilbake etter å ha vært borte lenger enn tiden under Lås etter.';

  @override
  String get settingsAppLockFooterOff => 'Applås ber om fingeravtrykk, ansikt eller skjermlås før e-posten din vises.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Applås er fortsatt slått av. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Konfigurer en kode';

  @override
  String get settingsScreenLockTextIos =>
      'Applås bruker Face ID, Touch ID eller koden din, og denne iPhonen har ingen kode. Konfigurer en i Innstillinger-appen, og slå deretter på Applås.';

  @override
  String get settingsScreenLockTitleAndroid => 'Konfigurer en skjermlås';

  @override
  String get settingsScreenLockTextAndroid =>
      'Applås bruker telefonens skjermlås, eller et fingeravtrykk eller ansikt som er lagt til i den, og denne telefonen har ingen. Konfigurer en PIN-kode, et mønster eller et passord i Android-innstillingene, og slå deretter på Applås.';

  @override
  String get settingsOpenSystemSettings => 'Åpne Innstillinger';

  @override
  String get settingsOpenAndroidSettings => 'Åpne Android-innstillinger';

  @override
  String get settingsLockAfter => 'Lås etter';

  @override
  String get settingsLockAfterFooter => 'Hvor lenge Loupe kan være i bakgrunnen før den spør igjen.';

  @override
  String get settingsNotifications => 'Varsler';

  @override
  String get settingsEncryption => 'Ende-til-ende-kryptering';

  @override
  String get settingsAdvanced => 'Avansert';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo-e-post er en oppdiktet postkasse som bare finnes på denne telefonen. Ingenting sendes noe sted.';

  @override
  String get settingsDemoMode => 'Demomodus';

  @override
  String get settingsResetApp => 'Tilbakestill appen';

  @override
  String get settingsResetFooter => 'Glemmer alle innstillinger og går tilbake til velkomstskjermen.';

  @override
  String get settingsResetTitle => 'Vil du tilbakestille Loupe?';

  @override
  String get settingsResetMessage =>
      'Dette glemmer alle innstillinger, Smart Mailboxes og nylige søk, og går tilbake til velkomstskjermen.';

  @override
  String get settingsAboutHeader => 'Om';

  @override
  String get settingsVersion => 'Versjon';

  @override
  String get settingsLicences => 'Lisenser';

  @override
  String get settingsPrivacy => 'Personvern';

  @override
  String get settingsPrivacyDetail =>
      'Loupe har ingen analyse og ingen sporing. E-posten din går bare til e-postserverne dine.';

  @override
  String get settingsNotificationsOffIos => 'Varsler er slått av for Loupe i Innstillinger.';

  @override
  String get settingsNotificationsOffAndroid => 'Varsler er slått av for Loupe i Android-innstillingene.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system lar ikke Loupe vise varsler. Tillat dem i Innstillinger.';
  }

  @override
  String get settingsNewMailHeader => 'Ny e-post';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo-e-post kommer ikke i bakgrunnen. Send et testvarsel for å se hvordan ny e-post ser ut.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe ser etter ny e-post i bakgrunnen når iOS tillater det, noe som kan være med timers mellomrom for apper du ikke åpner ofte. Du får beskjed om nye meldinger i innboksene dine og fra VIP-er i alle mapper.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe ser etter ny e-post omtrent hvert 15. minutt når Android tillater det. Du får beskjed om nye meldinger i innboksene dine og fra VIP-er i alle mapper.';

  @override
  String get settingsNoAccounts => 'Ingen kontoer';

  @override
  String get settingsVipOnly => 'Bare VIP';

  @override
  String get settingsVipOnlyDetail => 'Bare meldinger fra VIP-ene dine';

  @override
  String get settingsHideContent => 'Skjul innhold';

  @override
  String get settingsHideContentFooterOn =>
      'Varsler sier bare «Ny melding fra» og kontoen, ikke hvem som skrev eller hva det gjelder.';

  @override
  String get settingsHideContentFooterOff =>
      'Skjul innhold holder avsender, emne og forhåndsvisning unna låseskjermen og varslene.';

  @override
  String get settingsBackgroundAppRefresh => 'Bakgrunnsoppdatering';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Ny e-post kommer bare i bakgrunnen mens Bakgrunnsoppdatering er på for Loupe i Innstillinger. iOS kan ikke holde en tilkobling til innboksene dine åpen, så det finnes ingen umiddelbar levering.';

  @override
  String get settingsInstantDelivery => 'Umiddelbar levering';

  @override
  String get settingsInstantDeliveryFooter =>
      'Umiddelbar levering (eksperimentell) holder en tilkobling til innboksene dine åpen, så ny e-post kommer i løpet av sekunder. Den viser et diskret varsel, «Ser etter ny e-post», og bruker mer batteri.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android kan stoppe Umiddelbar levering for å spare batteri. La Loupe bruke batteriet uten begrensninger for å holde den i gang.';

  @override
  String get settingsExperimental => 'Eksperimentell';

  @override
  String get settingsComingSoon => 'Kommer snart';

  @override
  String get settingsAllowUnrestrictedBattery => 'Tillat ubegrenset batteribruk';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push lar ny e-post vekke Loupe med en gang, der e-posttjenesten din støtter det. Push-varsler går gjennom Googles pushtjeneste og inneholder ingen e-post, bare «sjekk nå».';

  @override
  String get settingsPushUnavailableFooter =>
      'Denne telefonen kan ikke motta push-varsler: de krever Google Play-tjenester og en nettverkstilkobling. Loupe ser fortsatt etter ny e-post omtrent hvert 15. minutt.';

  @override
  String get settingsCopyPushToken => 'Kopier push-token';

  @override
  String get settingsPushTokenCopied => 'Push-tokenet er kopiert';

  @override
  String get settingsSendTestNotification => 'Send testvarsel';

  @override
  String get settingsAppIconBadge => 'Merke på appikonet';

  @override
  String get settingsBadgeNote => 'Merket oppdateres hver gang Loupe ser etter e-post, også i bakgrunnen.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Startskjermen på denne telefonen viser ikke tall på appikoner. Merket oppdateres hver gang Loupe ser etter e-post, også i bakgrunnen.';

  @override
  String get settingsTestNotificationBody => 'Varsler om ny e-post ser slik ut.';

  @override
  String get settingsAccountRemoved => 'Denne kontoen er fjernet.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Beskrivelse';

  @override
  String get settingsAccountDescriptionHint => 'Jobb, privat…';

  @override
  String get settingsEmail => 'E-post';

  @override
  String get settingsColour => 'Farge';

  @override
  String get settingsColourFooter => 'Markerer meldingene fra denne kontoen i Alle innbokser.';

  @override
  String settingsColourNumber(int number) {
    return 'Farge $number';
  }

  @override
  String get settingsSendingHeader => 'Sending';

  @override
  String get settingsSendingFooter =>
      'Hver identitet har sin egen signatur. Svar sendes fra adressen meldingen ble sendt til.';

  @override
  String get settingsFoldersHeader => 'Mapper';

  @override
  String get settingsFoldersFooter =>
      'Loupe viser og synkroniserer mappene du abonnerer på, slik Thunderbird gjør. Innboks, Utkast, Sendt, Søppelpost, Papirkurv og Arkiv vises alltid.';

  @override
  String get settingsShowAllFolders => 'Vis alle mapper';

  @override
  String get settingsIncoming => 'Innkommende';

  @override
  String get settingsOutgoing => 'Utgående';

  @override
  String get settingsConnectionNotEncrypted => 'Ikke kryptert';

  @override
  String get settingsSignIn => 'Pålogging';

  @override
  String get settingsSignInExpired => 'Utløpt';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider godtar ikke lenger Loupes pålogging for denne kontoen, så e-posten synkroniseres ikke. Logg inn på nytt for å fikse det.';
  }

  @override
  String get settingsSignInAgain => 'Logg inn på nytt';

  @override
  String get settingsSigningIn => 'Logger inn…';

  @override
  String get settingsRemoveAccount => 'Fjern konto';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Vil du fjerne «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'E-posten og innstillingene fjernes fra denne telefonen. Ingenting slettes på serveren.';

  @override
  String get settingsManageFolders => 'Administrer mapper';

  @override
  String get settingsNoFolders => 'Ingen mapper ennå.';

  @override
  String get settingsManageFoldersFooter =>
      'Mapper du abonnerer på, vises på Postkasser-skjermen og synkroniseres i bakgrunnen. Andre e-postapper på samme konto følger som regel også disse abonnementene.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Lagrer Smart Mailboxes for de andre enhetene dine. Skjult på Postkasser-skjermen.';

  @override
  String get settingsFolderAlwaysShown => 'Vises alltid';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abonner på $folder';
  }

  @override
  String get settingsIdentities => 'Identiteter';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Den første identiteten er standard for nye meldinger. Dra for å endre rekkefølgen.';

  @override
  String get settingsIdentitiesFooterSingle => 'Standardidentiteten for nye meldinger.';

  @override
  String get settingsIdentitiesReplyFooter => 'Et svar sendes fra identiteten meldingen ble sendt til.';

  @override
  String get settingsIdentityDefault => 'Standard';

  @override
  String settingsIdentityReorder(String email) {
    return 'Flytt $email';
  }

  @override
  String get settingsAddIdentity => 'Legg til identitet';

  @override
  String get settingsNewIdentity => 'Ny identitet';

  @override
  String get settingsIdentity => 'Identitet';

  @override
  String get settingsIdentityNameHint => 'Navnet ditt';

  @override
  String get settingsReplyTo => 'Svar til';

  @override
  String get settingsSignature => 'Signatur';

  @override
  String get settingsSignatureFooter => 'Legges til under «-- » i meldinger fra denne identiteten.';

  @override
  String get settingsNoSignature => 'Ingen signatur';

  @override
  String get settingsCopyToMyself => 'Kopi til meg selv';

  @override
  String get settingsCopyToMyselfFooter => 'Legges til i alle meldinger fra denne identiteten.';

  @override
  String get settingsCc => 'Kopi';

  @override
  String get settingsBcc => 'Blindkopi';

  @override
  String get settingsReplyPatterns => 'Bruk for svar til';

  @override
  String get settingsReplyPatternsFooter =>
      'Svar på meldinger sendt til disse adressene, sendes fra denne identiteten. * står for hva som helst: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'En adresse eller et mønster der * står for hva som helst.';

  @override
  String get settingsAddReplyPattern => 'Legg til adresse eller mønster';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Fjern $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ugyldig mønster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» er verken en adresse eller et mønster som *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ingen adresse';

  @override
  String get settingsIdentityNoAddressMessage => 'Skriv inn e-postadressen det skal sendes fra.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ugyldig adresse';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Svar til «$address» er ikke en gyldig e-postadresse.',
      'cc': 'Kopi «$address» er ikke en gyldig e-postadresse.',
      'bcc': 'Blindkopi «$address» er ikke en gyldig e-postadresse.',
      'other': '«$address» er ikke en gyldig e-postadresse.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Lagre identitet';

  @override
  String get settingsDiscardChanges => 'Forkast endringer';

  @override
  String get settingsDeleteIdentity => 'Slett identitet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Vil du slette «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Meldinger som allerede er sendt fra den, forblir som de er.';

  @override
  String get settingsLastIdentityFooter => 'En konto må ha minst én identitet.';

  @override
  String get rulesTitle => 'Regler';

  @override
  String get rulesNewRule => 'Ny regel';

  @override
  String get rulesLoadError => 'Kunne ikke laste inn reglene.';

  @override
  String get rulesEmptyTitle => 'Ingen regler';

  @override
  String get rulesEmptyText =>
      'Regler sorterer, gir etiketter og flagger ny e-post for deg. Lag en med skriveknappen over, eller fra et søk med «Gjør dette til en regel».';

  @override
  String get rulesListFooter =>
      'Regler kjøres ovenfra og ned på ny e-post i innboksen. Trykk og hold på en regel for å flytte den.';

  @override
  String get rulesChangeError => 'Kunne ikke endre regelen';

  @override
  String get rulesConditionEveryMessage => 'Alle meldinger';

  @override
  String rulesMoveRule(String rule) {
    return 'Flytt $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule på';
  }

  @override
  String get rulesServerRulesHeader => 'Serverregler';

  @override
  String get rulesServerRulesFooter =>
      'Serverregler kjøres på e-postserveren når e-posten kommer inn, også mens telefonen er slått av. De lagres i et Sieve-skript med navnet «loupe».';

  @override
  String get rulesStatusUnknown => 'Ukjent';

  @override
  String get rulesStatusError => 'Kunne ikke spørre serveren.';

  @override
  String get rulesStatusChecking => 'Sjekker…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Kjøres fra «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» er det aktive skriptet. Trykk for å la det kjøre Loupes regler også.';
  }

  @override
  String get rulesStatusNoScript => 'Ingen skript er aktive på serveren. Når du lagrer en serverregel, slås Loupes på.';

  @override
  String get rulesStatusUnavailable => 'Ikke tilgjengelig';

  @override
  String get rulesStatusNoSieve => 'Serveren til denne kontoen tilbyr ikke Sieve (ManageSieve eller JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Flytt til $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Flytt til en mappe';

  @override
  String rulesActionTag(String tag) {
    return 'Legg til etikett $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Fjern etikett $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Behold i innboksen';

  @override
  String rulesActionForward(String address) {
    return 'Videresend til $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Videresend til $address, behold ingen kopi';
  }

  @override
  String get rulesActionStop => 'Stopp';

  @override
  String get rulesNoActions => 'Gjør ingenting ennå';

  @override
  String get rulesLocationDevice => 'Enhet';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Denne enheten';

  @override
  String get rulesNewRuleTitle => 'Ny regel';

  @override
  String get rulesEditRuleTitle => 'Rediger regel';

  @override
  String get rulesDefaultNameEveryMessage => 'Alle meldinger';

  @override
  String get rulesConditionHeader => 'Når en ny melding samsvarer med';

  @override
  String get rulesConditionFooter =>
      'Skriv det slik du ville søkt: from:, to:, s: (emne), b: (brødtekst), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Kontoer';

  @override
  String get rulesAllAccounts => 'Alle kontoer';

  @override
  String get rulesRemovedAccount => 'Fjernet konto';

  @override
  String get rulesAccountsFooter => 'En regel for alle kontoer gjelder også kontoer du legger til senere.';

  @override
  String get rulesActionsHeader => 'Så';

  @override
  String get rulesForwardingFooter =>
      'Videresending sender alle meldinger som samsvarer, til en annen adresse når de kommer inn, også mens telefonen er slått av. Noen leverandører begrenser hvor mye e-post som kan videresendes.';

  @override
  String get rulesForwardingHiddenFooter => 'Videresending kjøres bare i serverregler, så den er utelatt her.';

  @override
  String rulesRemoveAction(String action) {
    return 'Fjern $action';
  }

  @override
  String get rulesAddAction => 'Legg til handling';

  @override
  String get rulesAddMove => 'Flytt til mappe…';

  @override
  String get rulesAddTagMenu => 'Legg til etikett…';

  @override
  String get rulesRemoveTagMenu => 'Fjern etikett…';

  @override
  String get rulesAddForward => 'Videresend til…';

  @override
  String get rulesStopProcessing => 'Stopp behandlingen av flere regler';

  @override
  String get rulesRunOnHeader => 'Kjør på';

  @override
  String get rulesRunOnDeviceFooter =>
      'Denne enheten kjører regelen på ny e-post i innboksen hver gang Loupe ser etter e-post.';

  @override
  String get rulesRunOnServerFooter =>
      'E-postserveren kjører regelen når e-posten kommer inn, også mens telefonen er slått av. Krever Sieve via ManageSieve (Dovecot, mailcow) eller JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Bruk på eksisterende meldinger…';

  @override
  String get rulesDeleteRule => 'Slett regel';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Vil du slette «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mappe i hvilken konto?';

  @override
  String get rulesMoveAccountMessage => 'E-post fra de andre kontoene går til mappen med samme navn der.';

  @override
  String get rulesAddTag => 'Legg til etikett';

  @override
  String get rulesRemoveTag => 'Fjern etikett';

  @override
  String get rulesForwardTo => 'Videresend til';

  @override
  String get rulesForwardToMessage =>
      'Serveren sender alle meldinger som samsvarer, videre til denne adressen, også mens telefonen er slått av. Bruk en adresse du eier eller stoler på.';

  @override
  String get rulesNotAnAddressTitle => 'Ikke en e-postadresse';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» er ikke en adresse det kan videresendes til.';
  }

  @override
  String get rulesKeepCopyTitle => 'Vil du beholde en kopi her?';

  @override
  String get rulesKeepCopy => 'Behold en kopi';

  @override
  String get rulesDontKeepCopy => 'Ikke behold noen kopi';

  @override
  String get rulesCheckCondition => 'Sjekk betingelsen';

  @override
  String get rulesChooseActionTitle => 'Velg en handling';

  @override
  String get rulesChooseActionMessage => 'Legg til hva regelen gjør med meldingene den treffer.';

  @override
  String get rulesSaveError => 'Kunne ikke lagre regelen';

  @override
  String get rulesSaveServerError => 'Kunne ikke lagre serverregelen';

  @override
  String get rulesRunOnDeviceInstead => 'Kjør på denne enheten i stedet';

  @override
  String get rulesNothingToApplyTitle => 'Ingenting å bruke';

  @override
  String get rulesNothingToApplyMessage => 'Gi først regelen en betingelse som virker, og en handling.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Bruk «$rule» på meldinger i…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Innbokser';

  @override
  String get rulesApplyScopeAll => 'Alle postkasser';

  @override
  String get rulesFindingMessages => 'Finner meldinger…';

  @override
  String get rulesSearchError => 'Kunne ikke søke';

  @override
  String get rulesSearchErrorUnknown => 'Noe gikk galt.';

  @override
  String get rulesNoMatchesTitle => 'Ingen meldinger samsvarer';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ingenting der samsvarer med «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du bruke «$rule» på $countString meldinger?',
      one: 'Vil du bruke «$rule» på $countString melding?',
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
      other: 'Bruk på $countString meldinger',
      one: 'Bruk på $countString melding',
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
      other: '«$rule» er brukt på $countString meldinger',
      one: '«$rule» er brukt på $countString melding',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Spør serveren hva den kan gjøre…';

  @override
  String get rulesServerUnreachable => 'Kunne ikke nå serveren.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kan ikke kjøre på serveren: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kan ikke kjøre på serveren til $account: $problem';
  }

  @override
  String get rulesShowScript => 'Vis skript';

  @override
  String get rulesHideScript => 'Skjul skript';

  @override
  String get rulesMatchingHeader => 'Meldinger som samsvarer';

  @override
  String get rulesMatchingHeaderLoading => 'Meldinger som samsvarer…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString meldinger som samsvarer',
      one: '$countString melding som samsvarer',
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
      other: '$countString+ meldinger som samsvarer',
      one: '$countString+ melding som samsvarer',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Fra de siste 30 dagene. Selve regelen virker bare på ny e-post, med mindre du bruker den på eksisterende meldinger.';

  @override
  String rulesConditionError(String error) {
    return 'Betingelsen har en feil: $error';
  }

  @override
  String get rulesPreviewNoSender => '(ingen avsender)';

  @override
  String get rulesPreviewNoSubject => '(uten emne)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'og $countString til');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ingenting fra de siste 30 dagene.';

  @override
  String get rulesIncludeTitle => 'Slå på serverregler';

  @override
  String get rulesIncludeLeaveOff => 'La være av';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serveren kjører allerede Loupes regler for $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» er det aktive skriptet på serveren til $account, så serveren kjører det og ikke Loupes regler. Loupe erstatter det ikke. Den kan legge til disse linjene i det, og serveren kjører da Loupes regler etter skriptets egne:';
  }

  @override
  String get rulesShowWholeScript => 'Vis hele skriptet';

  @override
  String get rulesHideWholeScript => 'Skjul hele skriptet';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ingenting annet i «$script» endres. Hvis filtrene redigeres i webmailen senere, kan webmailen skrive det om uten disse linjene; Loupe viser da serverregler som slått av igjen.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Legg til i «$script»';
  }

  @override
  String get subscriptionsTitle => 'Abonnementer';

  @override
  String get subscriptionsNewsletters => 'Nyhetsbrev';

  @override
  String get subscriptionsDiscussions => 'Diskusjoner';

  @override
  String get subscriptionsFilter => 'Filtrer';

  @override
  String get subscriptionsFilterNeverRead => 'Aldri lest';

  @override
  String get subscriptionsFilterRarelyRead => 'Sjelden lest';

  @override
  String get subscriptionsFilterAll => 'Alle';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Kunne ikke telle abonnementer';

  @override
  String get subscriptionsNoMatches => 'Ingen treff';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ingen nyhetsbrev heter «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ingen liste heter «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Ingen nyhetsbrev';

  @override
  String get subscriptionsNoNewslettersDetail => 'Nyhetsbrev og andre masseutsendelser vises her når de kommer.';

  @override
  String get subscriptionsNothingNeverRead => 'Ingenting du aldri leser';

  @override
  String get subscriptionsNothingRarelyRead => 'Ingenting du sjelden leser';

  @override
  String get subscriptionsNothingFilteredDetail => 'Du leser noe av alt du får.';

  @override
  String get subscriptionsNoDiscussions => 'Ingen diskusjoner';

  @override
  String get subscriptionsNoDiscussionsDetail => 'E-postlister du kan skrive til, vises her når e-posten deres kommer.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lister som flere personer skriver til. Trykk og hold på en for å feste den til Postkasser, lese den som ren tekst eller flytte den til Nyhetsbrev.';

  @override
  String get subscriptionsPrivacyNote =>
      'Telt opp på denne telefonen fra e-posten den har lastet ned; ingenting sendes noe sted for å finne ut av dette. Loupe kontakter en avsender bare når du trykker på Meld av: avmelding med ett klikk sender bare «List-Unsubscribe=One-Click» til adressen avsenderen har oppgitt, uten informasjonskapsler eller noe annet om deg, og laster aldri inn sidene eller bildene deres.';

  @override
  String get subscriptionsVolumeNone => 'Ingen i det siste';

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
    return 'lest $percent';
  }

  @override
  String get subscriptionsStillSending => 'Sender fortsatt';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Avmeldt $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Avmeldingssiden åpnet $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ett trykk · kontakter $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Via e-post til $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'På nettstedet $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Meld av';

  @override
  String get subscriptionsUnsubscribeAgain => 'Meld av igjen';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arkiver $countString i innboksen');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Opprett regel…';

  @override
  String get subscriptionsCreateRuleDetail => 'Flytt eller arkiver framtidig e-post fra avsenderen';

  @override
  String get subscriptionsTreatAsDiscussion => 'Behandle som diskusjon';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'En liste folk skriver til: les den som et forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Behandle som nyhetsbrev';

  @override
  String get subscriptionsBlockSender => 'Blokker avsender';

  @override
  String get subscriptionsBlock => 'Blokker';

  @override
  String get subscriptionsBlocked => 'Blokkert';

  @override
  String get subscriptionsBlockedDetail => 'Ny e-post går til Søppelpost';

  @override
  String get subscriptionsPin => 'Fest til Postkasser';

  @override
  String get subscriptionsUnpin => 'Løsne fra Postkasser';

  @override
  String get subscriptionsOpenDefaultView => 'Åpne i standardvisning';

  @override
  String get subscriptionsOpenPlainText => 'Åpne som ren tekst (Mono)';

  @override
  String get subscriptionsPinned => 'Festet';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString uleste',
      one: '$countString ulest',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Ingen e-post fra denne avsenderen nå.';

  @override
  String get subscriptionsLatestMessages => 'SISTE MELDINGER';

  @override
  String get subscriptionsMail => 'E-post';

  @override
  String get subscriptionsNoneIn90Days => 'Ingen på 90 dager';

  @override
  String get subscriptionsRead => 'Lest';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString av $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Sist mottatt';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Mapper', one: 'Mappe');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Sender fortsatt';

  @override
  String get subscriptionsUnsubscribedTitle => 'Avmeldt';

  @override
  String subscriptionsSince(String date) {
    return 'siden $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'side åpnet $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender oppgir ikke hvordan man melder seg av.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender oppgir ikke hvordan man melder seg av. Du kan blokkere avsenderen i stedet.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Melder av fra $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Meldt av fra $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Kunne ikke melde av: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Kunne ikke melde av automatisk';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Send avmeldings-e-post';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Åpne $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Vil du åpne $site?';
  }

  @override
  String get subscriptionsOpen => 'Åpne';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender melder av på nettstedet sitt. Siden åpnes i Loupes nettleser; fullfør der.';
  }

  @override
  String get subscriptionsWebInsecure => 'Tilkoblingen til dette nettstedet er ikke kryptert.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Pass på: denne adressen etterligner $site med bokstaver som ligner til forveksling.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Pass på: denne adressen etterligner et annet nettsted med bokstaver som ligner til forveksling.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Kunne ikke åpne $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe noterer dagens dato og gir deg beskjed hvis $sender fortsetter å skrive.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vil du melde deg av $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontakter $site for å melde deg av.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Dette er den eneste gangen Loupe kontakter nettstedet til en avsender. Den sender bare «List-Unsubscribe=One-Click» til adressen $sender har oppgitt, uten informasjonskapsler eller noe annet om deg, og laster ikke inn siden.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Avmeldingslenken er ikke en sikker adresse på internett.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site svarte ikke i tide.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Kunne ikke nå $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site sendte forespørselen videre til en annen side, som Loupe ikke følger.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site avviste forespørselen (feil $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Det finnes ingen konto å sende avmeldings-e-posten fra.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe sender en e-post til $to fra $from med emnet «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Avmeldings-e-post sendt til $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Vil du blokkere $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Ny e-post fra denne listen går til Søppelpost. Du kan endre det under Innstillinger › Regler.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Ny e-post fra $address går til Søppelpost. Du kan endre det under Innstillinger › Regler.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender er blokkert.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Flytt $count til Søppelpost');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokker $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender er nå under Nyhetsbrev.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender er nå under Diskusjoner.';
  }

  @override
  String get appLiveGateTitle => 'Kunne ikke åpne kontoene dine';

  @override
  String get appLiveGateUnavailableBuild => 'Ekte kontoer er ikke tilgjengelige i dette bygget ennå.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe kunne ikke lese nøkkelen som beskytter e-posten din på denne telefonen. Dette er ofte midlertidig: prøv igjen, eller start telefonen på nytt.';

  @override
  String get appLiveGateKeyMissing =>
      'Nøkkelen som beskytter e-posten din på denne telefonen, er borte, noe som kan skje etter at en sikkerhetskopi er gjenopprettet. E-posten din ligger fortsatt på serveren.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'E-postdatabasen på denne telefonen kan ikke leses: den er skadet, eller nøkkelen er endret. E-posten din ligger fortsatt på serveren.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Noe gikk galt da kontoene dine skulle åpnes ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Dette sletter kontoene dine og e-posten som er lagret på denne telefonen, også meldinger som venter i utboksen. E-post på serverne dine berøres ikke; legg til kontoene dine på nytt etterpå.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Slett og start på nytt';

  @override
  String get appLiveGateUseDemo => 'Bruk demo-e-post';

  @override
  String get appLiveGateReset => 'Tilbakestill e-post på denne telefonen…';

  @override
  String get attachmentsUntitled => 'Vedlegg';

  @override
  String get attachmentsUntitledFile => 'Uten navn';

  @override
  String get attachmentsOpenIn => 'Åpne i…';

  @override
  String get attachmentsSaveToFiles => 'Lagre i filer';

  @override
  String get attachmentsShareMenu => 'Del…';

  @override
  String get attachmentsDownloadError => 'Kunne ikke laste ned vedlegget. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get attachmentsShareError => 'Kunne ikke dele vedlegget.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ingen app på denne enheten åpner denne filen ($type). Prøv å dele den i stedet.';
  }

  @override
  String get attachmentsOpenInError => 'Kunne ikke åpne vedlegget i en annen app.';

  @override
  String attachmentsSaved(String name) {
    return '«$name» er lagret';
  }

  @override
  String get attachmentsSaveError => 'Kunne ikke lagre vedlegget.';

  @override
  String get attachmentsGone => 'Dette vedlegget er ikke lenger tilgjengelig.';

  @override
  String get attachmentsDownloadFailed => 'Kunne ikke laste ned vedlegget.';

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
  String get attachmentsLargeDownload => 'Dette vedlegget er stort. Last det ned nå, eller senere på wifi.';

  @override
  String get attachmentsDownload => 'Last ned';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Laster ned $size…';
  }

  @override
  String get attachmentsDownloading => 'Laster ned…';

  @override
  String get attachmentsTooLarge => 'For stor til å forhåndsvises her.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Viser de første $shown av $total. Kopier, del eller lagre for å få med alt.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Denne PDF-en kan ikke vises her (den kan være beskyttet med passord).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page av $count';
  }

  @override
  String get attachmentsModeTable => 'Tabell';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Melding';

  @override
  String get attachmentsModeSource => 'Kilde';

  @override
  String get attachmentsDontWrap => 'Ikke bryt linjer';

  @override
  String get attachmentsWrap => 'Bryt linjer';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines linjer', one: '$lines linje');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopier alt';

  @override
  String get attachmentsCopied => 'Kopiert';

  @override
  String get attachmentsImageUnavailable => 'Bildet kan ikke vises her. Prøv «Åpne i…».';

  @override
  String get attachmentsEmlNoSubject => '(Uten emne)';

  @override
  String get attachmentsEmlFrom => 'Fra';

  @override
  String get attachmentsEmlTo => 'Til';

  @override
  String get attachmentsEmlCc => 'Kopi';

  @override
  String get attachmentsEmlDate => 'Dato';

  @override
  String get attachmentsEmlNoText => 'Denne meldingen har ingen tekst.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Vedlegg: $names', one: 'Vedlegg: $names');
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
      other: 'Og $count hendelser til',
      one: 'Og 1 hendelse til',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Bilde';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-bilde';
  }

  @override
  String get attachmentsTypePdf => 'PDF-dokument';

  @override
  String get attachmentsTypeTsv => 'Tabulatorseparerte verdier';

  @override
  String get attachmentsTypeCsv => 'CSV-regneark';

  @override
  String get attachmentsTypeCalendar => 'Kalenderhendelse';

  @override
  String get attachmentsTypeEmail => 'E-postmelding';

  @override
  String get attachmentsTypeContact => 'Kontaktkort';

  @override
  String get attachmentsTypeLog => 'Loggfil';

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
  String get attachmentsTypePowerPoint => 'PowerPoint-presentasjon';

  @override
  String get attachmentsTypeWebPage => 'Nettside';

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
  String get calendarUntitledEvent => 'Hendelse';

  @override
  String get calendarAllDay => 'Hele dagen';

  @override
  String calendarYourTime(String time) {
    return '$time din tid';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Bli med: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har godtatt: $details',
      'tentative': '$name har foreløpig godtatt: $details',
      'declined': '$name har avslått: $details',
      'delegated': '$name har delegert: $details',
      'other': '$name har ikke svart på: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har godtatt invitasjonen',
      'tentative': '$name har foreløpig godtatt invitasjonen',
      'declined': '$name har avslått invitasjonen',
      'delegated': '$name har delegert invitasjonen',
      'other': '$name har ikke svart på invitasjonen',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kart';

  @override
  String get calendarJoin => 'Bli med';

  @override
  String get calendarOnlineMeeting => 'Nettmøte';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-møte';
  }

  @override
  String get calendarOrganizerYou => 'Deg';

  @override
  String get calendarOrganizerLabel => 'arrangør';

  @override
  String get calendarStatusAccepted => 'Godtatt';

  @override
  String get calendarStatusMaybe => 'Kanskje';

  @override
  String get calendarStatusDeclined => 'Avslått';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har godtatt',
      'tentative': '$name har foreløpig godtatt',
      'declined': '$name har avslått',
      'delegated': '$name har delegert',
      'other': '$name har ikke svart',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har godtatt:',
      'tentative': '$name har foreløpig godtatt:',
      'declined': '$name har avslått:',
      'delegated': '$name har delegert:',
      'other': '$name har ikke svart:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name foreslår et nytt tidspunkt';
  }

  @override
  String get calendarCounterUnknown => 'En deltaker foreslår et nytt tidspunkt';

  @override
  String get calendarDeclineCounter => 'Arrangøren beholdt tidspunktet';

  @override
  String calendarRefresh(String name) {
    return '$name ber om den nyeste versjonen';
  }

  @override
  String get calendarRefreshUnknown => 'En deltaker ber om den nyeste versjonen';

  @override
  String get calendarCancelled => 'Avlyst';

  @override
  String get calendarCancelledByOrganizer => 'Arrangøren har avlyst denne hendelsen.';

  @override
  String get calendarCancelledLater => 'Denne hendelsen ble avlyst senere.';

  @override
  String get calendarOutdated => 'Utdatert';

  @override
  String get calendarOutdatedDetail => 'Denne invitasjonen ble oppdatert senere; den nyeste gjelder.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Sted fjernet (var $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Sted fjernet (var ingen)';

  @override
  String calendarLocationChanged(String location) {
    return 'Sted endret til $location';
  }

  @override
  String get calendarNewTitle => 'Ny tittel';

  @override
  String get calendarRepeatChanged => 'Gjentakelsen er endret';

  @override
  String get calendarUpdated => 'Oppdatert';

  @override
  String get calendarUpdatedInvitation => 'Oppdatert invitasjon';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Tidspunkt endret fra $before til $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Tidssonen «$zone» er ukjent: tidspunkter som skrevet';
  }

  @override
  String calendarNext(String when) {
    return 'Neste: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gjester', one: '1 gjest');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ja');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kanskje');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count nei');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (deg)';
  }

  @override
  String get calendarAttendeeOptional => 'valgfri';

  @override
  String get calendarAttendeeRoom => 'rom';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Du godtok en tidligere versjon.',
      'tentative': 'Du godtok en tidligere versjon foreløpig.',
      'declined': 'Du avslo en tidligere versjon.',
      'delegated': 'Du delegerte en tidligere versjon.',
      'other': 'Du svarte ikke på en tidligere versjon.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Godta';

  @override
  String get calendarMaybe => 'Kanskje';

  @override
  String get calendarDecline => 'Avslå';

  @override
  String get calendarCommentHint => 'Kommentar til arrangøren (valgfritt)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Svaret ditt går til $organizer fra $address.';
  }

  @override
  String get calendarAddComment => 'Legg til en kommentar';

  @override
  String get calendarAddToCalendar => 'Legg til i kalenderen';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Og $count hendelser til i filen',
      one: 'Og 1 hendelse til i filen',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Det finnes ingen kalenderapp å legge hendelsen til i.';

  @override
  String get calendarCantOpenCalendar => 'Kunne ikke åpne kalenderen.';

  @override
  String get calendarCantOpenLink => 'Kunne ikke åpne lenken.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Vil du bli med i $provider-møtet?';
  }

  @override
  String get calendarJoinTitle => 'Vil du bli med i møtet?';

  @override
  String calendarJoinOpens(String host) {
    return 'Åpner $host i nettleseren din.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Pass på: denne adressen etterligner $site med bokstaver som ligner til forveksling.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Pass på: denne adressen etterligner et annet nettsted med bokstaver som ligner til forveksling.';

  @override
  String calendarJoinOpen(String host) {
    return 'Åpne $host';
  }

  @override
  String get calendarNoOrganizer => 'Denne invitasjonen har ingen arrangør å svare til.';

  @override
  String get calendarNoAccount => 'Det finnes ingen konto å svare fra.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Godtatt', 'tentative': 'Kanskje', 'other': 'Avslått'});
    return '$_temp0 · sender svar til $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Godtatt', 'tentative': 'Kanskje', 'other': 'Avslått'});
    return '$_temp0 · svar sendt';
  }

  @override
  String get calendarReplyAlreadySent => 'Svaret var allerede sendt.';

  @override
  String get calendarReplyNotSent => 'Svaret ble ikke sendt.';

  @override
  String get dataSmimeNeedsDevice =>
      'S/MIME-sertifikatet ditt er på denne enheten: åpne Loupe for å signere og sende denne meldingen.';

  @override
  String dataSigningFailed(String error) {
    return 'Signering mislyktes: $error';
  }

  @override
  String get keyboardShortcuts => 'Hurtigtaster';

  @override
  String get keyboardGroupGeneral => 'Generelt';

  @override
  String get keyboardGroupMessages => 'Meldinger';

  @override
  String get keyboardGroupCompose => 'Skriv';

  @override
  String get keyboardCommandPalette => 'Kommandopalett';

  @override
  String get keyboardBackClose => 'Tilbake, lukk';

  @override
  String get keyboardNextMessage => 'Neste melding';

  @override
  String get keyboardPreviousMessage => 'Forrige melding';

  @override
  String get keyboardOpenMessage => 'Åpne melding';

  @override
  String get keyboardMoveToTrash => 'Flytt til papirkurven';

  @override
  String get keyboardToggleRead => 'Merk som lest eller ulest';

  @override
  String get keyboardToggleFlag => 'Flagg eller fjern flagg';

  @override
  String get keyboardCloseDraft => 'Lukk (lagre eller slett utkast)';

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
  String get keyboardKeyBackspace => 'Tilbake';

  @override
  String get mailingListsMuted => 'Tråden er dempet. Nye meldinger i den kommer som lest.';

  @override
  String get mailingListsUnmuted => 'Tråden er ikke lenger dempet.';

  @override
  String get mailingListsMuteThread => 'Demp tråden';

  @override
  String get mailingListsUnmuteThread => 'Opphev demping av tråden';

  @override
  String get mailingListsPin => 'Fest til Postkasser';

  @override
  String get mailingListsUnpin => 'Løsne fra Postkasser';

  @override
  String get mailingListsDefaultView => 'Åpne i standardvisning';

  @override
  String get mailingListsPlainText => 'Åpne som ren tekst (Mono)';

  @override
  String get mailingListsShowMuted => 'Vis dempede tråder';

  @override
  String get mailingListsHideMuted => 'Skjul dempede tråder';

  @override
  String get mailingListsTreatAsNewsletter => 'Behandle som nyhetsbrev';

  @override
  String get mailingListsOptions => 'Listealternativer';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted uleste',
      one: '$formatted ulest',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Ny melding til listen';

  @override
  String get mailingListsRowUnread => 'Ulest';

  @override
  String get mailingListsRowMuted => 'Dempet';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count svar', one: '1 svar');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Ingen tråder';

  @override
  String get mailingListsMutedHidden => 'Dempede tråder er skjult.';

  @override
  String get mailingListsTechnicalTitle => 'Tekniske lister';

  @override
  String get mailingListsTechnicalEmpty => 'E-postlister vises her når e-posten deres kommer.';

  @override
  String get mailingListsTechnicalFooter =>
      'Meldinger fra disse listene åpnes som ren tekst i en skrift med fast bredde, med patcher vist som differ. Aa-knappen kan fortsatt bytte visning for hvilken som helst melding.';

  @override
  String get paletteMoveToMailbox => 'Flytt til postkasse…';

  @override
  String get paletteMarkAllRead => 'Merk alle som lest';

  @override
  String get paletteExportFolder => 'Eksporter mappe…';

  @override
  String get paletteGetNewMail => 'Hent ny e-post';

  @override
  String get paletteSnoozed => 'Slumret';

  @override
  String get paletteSubscriptions => 'Abonnementer';

  @override
  String get paletteDiscussions => 'Diskusjoner';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-postliste';

  @override
  String get paletteTag => 'Etikett';

  @override
  String get paletteSwipeActions => 'Sveipehandlinger';

  @override
  String get paletteNotifications => 'Varsler';

  @override
  String get paletteRules => 'Regler';

  @override
  String get paletteEncryption => 'Ende-til-ende-kryptering';

  @override
  String get paletteAdvanced => 'Avansert';

  @override
  String get paletteAddAccount => 'Legg til konto';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Mapper';

  @override
  String get paletteRecentSearch => 'Nylig søk';

  @override
  String paletteSearchMail(String query) {
    return 'Søk i e-post etter «$query»';
  }

  @override
  String get palettePlaceholder => 'Søk i handlinger, postkasser, innstillinger';

  @override
  String get paletteNothingFound => 'Ingenting funnet';

  @override
  String get searchNewSmartMailbox => 'Ny Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Viser alt som samsvarer med «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» er lagret i Postkasser';
  }

  @override
  String get searchMakeRule => 'Gjør dette til en regel';

  @override
  String get searchSaveSmartMailbox => 'Lagre som Smart Mailbox';

  @override
  String get searchNegate => 'Ekskluder';

  @override
  String get searchDontNegate => 'Inkluder';

  @override
  String get searchAllMailboxes => 'Alle postkasser';

  @override
  String get searchRecent => 'Nylige søk';

  @override
  String get searchClear => 'Tøm';

  @override
  String get searchSuggestions => 'Forslag';

  @override
  String get searchUnreadMessages => 'Uleste meldinger';

  @override
  String get searchFlaggedMessages => 'Flaggede meldinger';

  @override
  String get searchWithAttachments => 'Meldinger med vedlegg';

  @override
  String get searchUnrepliedMessages => 'Ubesvarte meldinger';

  @override
  String get searchTags => 'Etiketter';

  @override
  String get searchPeople => 'Personer';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Fra: $name';
  }

  @override
  String get searchSearching => 'Søker…';

  @override
  String get searchNoResults => 'Ingen treff';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted treff',
      one: '$formatted treff',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Søkemeny';

  @override
  String searchSearchingAccount(String account) {
    return 'Søker i $account på serveren…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Søker i konto på serveren…';

  @override
  String searchAccountFailed(String account) {
    return 'Kunne ikke søke i $account på serveren';
  }

  @override
  String get searchUnknownAccountFailed => 'Kunne ikke søke i kontoen på serveren';

  @override
  String searchChip(String term) {
    return '$term. Dobbelttrykk for å redigere.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ikke $term. Dobbelttrykk for å redigere.';
  }

  @override
  String get searchReadAndUnread => 'Schrödingers innboks: hver melding her er både lest og ulest til du åpner den.';

  @override
  String searchContradiction(String term) {
    return 'Ingen melding kan både være «$term» og ikke være det.';
  }

  @override
  String get searchSyncDeviceOnly => 'Bare på denne enheten';

  @override
  String searchSyncUnsupported(String account) {
    return 'Bare på denne enheten: $account kan ikke lagre den';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Ikke synkronisert: $account har et nyere format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Venter på å synkronisere til $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synkronisert til $account';
  }

  @override
  String get searchRename => 'Gi nytt navn';

  @override
  String get searchEditSearch => 'Rediger søk';

  @override
  String get searchDeleteSmartMailbox => 'Slett Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Gi Smart Mailbox nytt navn';

  @override
  String get searchSmartMailboxDeleted => 'Denne Smart Mailbox er slettet.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes blir værende på denne enheten.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes lagres på e-postserveren din, så de andre enhetene dine også har dem, og det samme har Thunderbird med Expression Search Reloaded. De som søker i alle kontoer, lagres på $account; de for én mappe på kontoen til den mappen.';
  }

  @override
  String get searchSyncVia => 'Synkroniser via';

  @override
  String get searchSyncViaFooter => 'Velg den samme kontoen på alle enheter.';

  @override
  String get searchGmailCantKeep => 'Gmail kan ikke lagre Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Lagre Smart Mailboxes bare på denne enheten';

  @override
  String get searchOnTheServer => 'På serveren';

  @override
  String get searchServerFooter =>
      'Servermetadata (IMAP METADATA) vises ikke i noen e-postapp. Servere uten det får en mappe, «Loupe Settings», med én melding; Loupe skjuler den i Postkasser.';

  @override
  String get searchSyncNow => 'Synkroniser nå';

  @override
  String get searchStateUnsupported => 'Støttes ikke';

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
  String get searchStateNothing => 'Ingenting lagret';

  @override
  String get sharedBack => 'Tilbake';

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
  String get sharedSyncNoAccounts => 'Ingen kontoer';

  @override
  String get sharedSyncChecking => 'Ser etter e-post…';

  @override
  String get sharedSyncFailed => 'Kunne ikke se etter e-post';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Frakoblet';

  @override
  String get sharedSyncJustNow => 'Oppdatert akkurat nå';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Oppdatert for $minutes minutter siden',
      one: 'Oppdatert for 1 minutt siden',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Oppdatert kl. $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Oppdatert $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Alle innbokser';

  @override
  String get sharedMailboxUnread => 'Uleste';

  @override
  String get sharedMailboxFlagged => 'Flaggede';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Alle utkast';

  @override
  String get sharedMailboxAllSent => 'Alle sendte';

  @override
  String get sharedMailboxUntitled => 'Postkasse';

  @override
  String get sharedTagImportant => 'Viktig';

  @override
  String get sharedTagWork => 'Arbeid';

  @override
  String get sharedTagPersonal => 'Personlig';

  @override
  String get sharedTagToDo => 'Å gjøre';

  @override
  String get sharedTagLater => 'Senere';

  @override
  String get sharedTags => 'Etiketter';

  @override
  String get sharedMoveTo => 'Flytt til…';

  @override
  String get sharedNoRecipients => 'Ingen mottakere';

  @override
  String get sharedUnknownSender => 'Ukjent avsender';

  @override
  String get sharedOnServer => 'På serveren';

  @override
  String get sharedAttachment => 'Vedlegg';

  @override
  String get sharedSnoozedBadge => 'Slumret';

  @override
  String get sharedRowUnread => 'Ulest';

  @override
  String get sharedRowBackFromSnooze => 'Tilbake fra slumring';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Flagget';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er arkivert',
      one: '1 melding er arkivert',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er slettet',
      one: '1 melding er slettet',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er flyttet til innboksen',
      one: '1 melding er flyttet til innboksen',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er flyttet til papirkurven',
      one: '1 melding er flyttet til papirkurven',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er flyttet til Søppelpost',
      one: '1 melding er flyttet til Søppelpost',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er flyttet til $mailbox',
      one: '1 melding er flyttet til $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er flyttet til en postkasse',
      one: '1 melding er flyttet til en postkasse',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meldinger er slumret til $time',
      one: '1 melding er slumret til $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Slumret til $time bare på denne enheten: serveren kan ikke lagre slumretider.';
  }

  @override
  String get sharedMoveOneAccount => 'Velg meldinger fra én konto for å flytte dem.';

  @override
  String get sharedSnoozeTitle => 'Slumre';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Endre slumretid';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vil du slette $count meldinger permanent?',
      one: 'Vil du slette denne meldingen permanent?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Dette kan ikke angres.';

  @override
  String get sharedDeletePermanently => 'Slett permanent';

  @override
  String get sharedSwipeRead => 'Lest';

  @override
  String get sharedSwipeUnread => 'Ulest';

  @override
  String get sharedSwipeInbox => 'Innboks';

  @override
  String get sharedSwipeDelete => 'Slett';

  @override
  String get sharedTrash => 'Papirkurv';

  @override
  String get sharedSwipeSnooze => 'Slumre';

  @override
  String get sharedWakeNow => 'Vekk nå';

  @override
  String get sharedChangeSnoozeTime => 'Endre slumretid…';

  @override
  String get sharedSnooze => 'Slumre…';

  @override
  String get sharedTag => 'Etikett…';

  @override
  String get sharedMoveMessage => 'Flytt melding…';

  @override
  String get sharedNotJunk => 'Ikke søppelpost';

  @override
  String get accountSetupTitle => 'Legg til konto';

  @override
  String get accountSetupTitleDone => 'Kontoen er lagt til';

  @override
  String get accountSetupAddressTitle => 'Legg til en e-postkonto';

  @override
  String get accountSetupAddressText => 'Loupe finner innstillingene for de fleste leverandører.';

  @override
  String get accountSetupNameHint => 'Navnet ditt';

  @override
  String get accountSetupEmail => 'E-post';

  @override
  String get accountSetupEmailHint => 'navn@example.com';

  @override
  String get accountSetupContinue => 'Fortsett';

  @override
  String get accountSetupLookingUp => 'Slår opp innstillinger…';

  @override
  String get accountSetupImport => 'Importer fra Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Skriv inn en gyldig e-postadresse.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Fant ikke innstillinger for $domain. Skriv dem inn nedenfor.';
  }

  @override
  String get accountSetupCheckServers => 'Sjekk servernavnene og portene.';

  @override
  String get accountSetupEnterPassword => 'Skriv inn passordet ditt.';

  @override
  String get accountSetupConnecting => 'Kobler til…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Venter på $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Kunne ikke åpne siden.';

  @override
  String get accountSetupCouldNotSaveName => 'Kunne ikke lagre navnet.';

  @override
  String get accountSetupTrustCertificate => 'Stol på dette sertifikatet';

  @override
  String get accountSetupPasswordRequired => 'Påkrevd';

  @override
  String get accountSetupShowPassword => 'Vis passord';

  @override
  String get accountSetupHidePassword => 'Skjul passord';

  @override
  String get accountSetupAppPassword => 'App-passord';

  @override
  String get accountSetupApiToken => 'API-token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Innkommende · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Utgående · SMTP';

  @override
  String get accountSetupSignIn => 'Logg inn';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Logg inn med $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Bruk et app-passord';

  @override
  String get accountSetupUseAppPasswordInstead => 'Bruk et app-passord i stedet';

  @override
  String get accountSetupUseDifferentAddress => 'Bruk en annen adresse';

  @override
  String get accountSetupHowToCreateAppPassword => 'Slik lager du et app-passord';

  @override
  String get accountSetupHowToCreateOne => 'Slik lager du et';

  @override
  String get accountSetupGoogleNote =>
      'Du logger inn på Googles side, og Loupe ser aldri passordet ditt. Gi Loupe tillatelse til å lese, sende og organisere e-posten din.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Logg inn med Google» er ikke tilgjengelig i dette bygget ennå. Du kan koble til med et app-passord i stedet (det krever totrinnsbekreftelse på Google-kontoen din).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Lag et app-passord i Google-kontoen din, og lim det inn nedenfor.';

  @override
  String get accountSetupMicrosoftNote =>
      'Du logger inn på Microsofts side, og Loupe ser aldri passordet ditt. Dette fungerer for Outlook.com og Hotmail, og for jobb- eller skolekontoer på Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Pålogging med Microsoft kommer i et senere bygg. Outlook-, Hotmail- og Microsoft 365-kontoer trenger det: de godtar ikke lenger passord fra e-postapper.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail krever et appspesifikt passord, ikke passordet til Apple-kontoen din.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail krever et app-passord, ikke passordet til kontoen din.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe kobler til Fastmail over JMAP med et API-token: Settings › Privacy & Security › Manage API tokens, for JMAP, med tilgang til e-post og sending.';

  @override
  String get accountSetupFastmailNote => 'Fastmail krever et app-passord for e-postapper.';

  @override
  String get accountSetupServerSettings => 'Serverinnstillinger';

  @override
  String get accountSetupSettingsNotFound => 'Ikke funnet automatisk';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Funnet via $source';
  }

  @override
  String get accountSetupEditSettings => 'Rediger innstillinger';

  @override
  String get accountSetupSyncing => 'E-posten din synkroniseres.';

  @override
  String get accountSetupDescription => 'Beskrivelse';

  @override
  String get accountSetupDescriptionHint => 'Jobb, privat…';

  @override
  String get accountSetupColour => 'Farge';

  @override
  String accountSetupColourNumber(int number) {
    return 'Farge $number';
  }

  @override
  String get accountSetupSaving => 'Lagrer…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe kunne ikke åpne e-postdatabasen sin på denne telefonen. Lukk Loupe, åpne den igjen og prøv på nytt.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Noe gikk galt ($error). Prøv igjen.';
  }

  @override
  String get accountSetupSecurityNone => 'Ingen';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sikkerhet';

  @override
  String get accountSetupUsername => 'Brukernavn';

  @override
  String get accountSetupUsernameHint => 'E-postadressen din';

  @override
  String get accountSetupNoEncryptionTitle => 'Vil du koble til uten kryptering?';

  @override
  String get accountSetupNoEncryptionText =>
      'Passordet ditt og alle meldinger ville blitt sendt som klartekst. Alle på nettverket, for eksempel et offentlig wifi, kunne lest dem. Bruk dette bare for en server på ditt eget nettverk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Bruk uten kryptering';

  @override
  String get accountSetupApiTokenRejected =>
      'API-tokenet ble avvist. Lag et Fastmail-API-token for JMAP med tilgang til e-post, og lim det inn.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Passordet ble avvist. Bruk et app-passord, ikke passordet til kontoen din.';

  @override
  String get accountSetupPasswordRejected => 'Passordet ble avvist. Sjekk det og prøv igjen.';

  @override
  String get accountSetupServerUnreachable => 'Kan ikke nå serveren. Sjekk serverinnstillingene og tilkoblingen din.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Serverens sertifikat er ikke klarert. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Påloggingen ble avbrutt. Trykk på «Logg inn med $provider» for å prøve igjen.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe trenger tillatelse til å lese og sende Gmail-en din. Logg inn på nytt og gi tilgang med Gmail-boksen avkrysset.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe trenger tillatelse til å lese og sende e-posten din. Logg inn på nytt og godta tillatelsene.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Organisasjonen din må godkjenne Loupe før du kan bruke den med denne kontoen. Be IT-administratoren din om å gi administratorsamtykke for Loupe i Microsoft Entra ID, og prøv deretter igjen.';

  @override
  String get accountSetupOAuthBlocked =>
      'Påloggingsreglene i organisasjonen din tillater ikke Loupe på denne enheten. Spør IT-administratoren din.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Kunne ikke nå $provider. Sjekk internettilkoblingen din og prøv igjen.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Pålogging med $provider er ikke satt opp riktig i denne versjonen av Loupe. Rapporter gjerne dette.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Pålogging med $provider fungerte ikke. Prøv igjen.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider logget deg inn, men Gmail nektet tilgang for denne adressen. Velg den samme kontoen når du logger inn. Jobb- eller skolekontoer kan ha fått IMAP slått av av administratoren.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider logget deg inn, men e-postserveren nektet tilgang for denne adressen. Velg den samme kontoen når du logger inn. Jobb- eller skolekontoer kan ha fått IMAP slått av av administratoren.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Kan ikke nå e-postserveren. Sjekk tilkoblingen din og prøv igjen.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Pålogging med $provider er ikke tilgjengelig i denne versjonen.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Du er logget inn igjen. $account synkroniseres.';
  }

  @override
  String get accountSetupSignInAgain => 'Logg inn på nytt';

  @override
  String get accountSetupSigningIn => 'Logger inn…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider godtar ikke lenger Loupes pålogging for $email, så $account synkroniseres ikke. Logg inn på nytt for å få e-posten til kontoen.';
  }

  @override
  String get accountImportTitle => 'Importer fra Thunderbird';

  @override
  String get accountImportPointCamera => 'Rett kameraet mot QR-koden Thunderbird viser.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skannet $scanned av $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Skannet $scanned av $total koder');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kontoer så langt',
      one: '1 konto så langt',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Åpne Thunderbird på datamaskinen, og velg Verktøy › Eksporter til mobil. Velg kontoene dine, og skann deretter hver kode som vises. Kodene kan skannes i hvilken som helst rekkefølge.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fortsett med $count kontoer',
      one: 'Fortsett med 1 konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Lim inn tekst i stedet';

  @override
  String get accountImportStartOver => 'Start på nytt';

  @override
  String get accountImportDuplicateCode => 'Den koden er allerede lagt til.';

  @override
  String get accountImportRestarted =>
      'Denne koden er fra en ny eksport, så kodene som ble skannet tidligere, er lagt til side.';

  @override
  String get accountImportNotThunderbird => 'Dette er ikke en kontokode fra Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Denne koden kommer fra en nyere Thunderbird. Oppdater Loupe for å importere den.';

  @override
  String get accountImportDamaged => 'Denne Thunderbird-koden kunne ikke leses.';

  @override
  String get accountImportTooLarge => 'Denne koden er for stor til å være en eksport fra Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Kunne ikke åpne Innstillinger.';

  @override
  String get accountImportCameraOffTitle => 'Kameratilgang er slått av';

  @override
  String get accountImportCameraOffText =>
      'Gi Loupe tilgang til kameraet i Innstillinger for å skanne koden, eller lim inn teksten i koden i stedet.';

  @override
  String get accountImportNoCameraTitle => 'Ingen kamera';

  @override
  String get accountImportNoCameraText => 'Loupe kan ikke bruke et kamera her. Lim inn teksten i koden i stedet.';

  @override
  String get accountImportCameraFailedTitle => 'Kameraet startet ikke';

  @override
  String get accountImportCameraFailedText => 'Prøv igjen, eller lim inn teksten i koden i stedet.';

  @override
  String get accountImportOpenSettings => 'Åpne Innstillinger';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fant $count kontoer',
      one: 'Fant 1 konto',
      zero: 'Fant ingen kontoer',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ingen av kontoene i disse kodene kunne leses.';

  @override
  String get accountImportChoose => 'Velg kontoene som skal legges til i Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kodene $codes av $total ble ikke skannet, så kontoene i dem vises ikke.',
      one: 'Kode $codes av $total ble ikke skannet, så kontoene i den vises ikke.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes og $last';
  }

  @override
  String get accountImportScanMore => 'Skann flere koder';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kontoer i kodene kunne ikke leses. De bruker kanskje innstillinger fra en nyere Thunderbird.',
      one: '1 konto i kodene kunne ikke leses. Den bruker kanskje innstillinger fra en nyere Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skann på nytt';

  @override
  String get accountImportAlreadyAdded => 'Det finnes allerede en konto med denne adressen i Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Du logger inn med $provider når den legges til, slik som i Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Legg til kontoen med et app-passord (det krever totrinnsbekreftelse).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird logger inn på Gmail med Google. «Logg inn med Google» kommer i et senere bygg; inntil da kan du legge til kontoen med et app-passord (det krever totrinnsbekreftelse).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird logger inn på denne kontoen i nettleseren. Det kan ikke Loupe ennå: bruk et app-passord hvis leverandøren din tilbyr det.';

  @override
  String get accountImportUnencrypted => 'Kobler til uten kryptering. Bruk dette bare på ditt eget nettverk.';

  @override
  String get accountImportEnterAgain => 'Skriv det inn på nytt';

  @override
  String get accountImportAdded => 'Lagt til';

  @override
  String accountImportAdding(int index, int total) {
    return 'Legger til $index av $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Legg til $count kontoer',
      one: 'Legg til 1 konto',
      zero: 'Legg til kontoer',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Lim inn eksporttekst';

  @override
  String get accountImportPasteText => 'Lim inn teksten fra en eksportkode fra Thunderbird, én kode per linje.';

  @override
  String get accountImportPop3 => 'POP3-kontoer støttes ikke. Loupe lar e-posten ligge på serveren med IMAP.';

  @override
  String get accountImportKerberos => 'Denne kontoen logger inn med Kerberos, som Loupe ikke støtter.';

  @override
  String get accountImportNtlm => 'Denne kontoen logger inn med NTLM, som Loupe ikke støtter.';

  @override
  String get accountImportClientCertificate =>
      'Denne kontoen logger inn med et klientsertifikat, som Loupe ikke støtter ennå.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Pålogging med Microsoft kommer i et senere bygg. Outlook- og Microsoft 365-kontoer godtar ikke lenger passord fra e-postapper.';

  @override
  String get accountImportEnterPassword => 'Skriv inn passordet.';

  @override
  String get accountImportEnterAppPassword => 'Skriv inn app-passordet.';

  @override
  String get accountImportEnterApiToken => 'Skriv inn API-tokenet.';

  @override
  String get accountImportStorageFailed => 'Loupe kunne ikke åpne kontolageret sitt. Prøv igjen senere.';

  @override
  String get accountImportFailed => 'Kunne ikke legge til kontoen. Prøv igjen, eller legg den til manuelt.';

  @override
  String get composeNewMessageTitle => 'Ny melding';

  @override
  String get composeAttach => 'Legg ved';

  @override
  String get composeSendLater => 'Send senere';

  @override
  String composeSendAt(String time) {
    return 'Send $time';
  }

  @override
  String get composeSendHint => 'Trykk lenge for å sende senere';

  @override
  String get composeNoAccount => 'Legg til en konto for å sende e-post.';

  @override
  String get composeTo => 'Til:';

  @override
  String get composeCc => 'Kopi:';

  @override
  String get composeBcc => 'Blindkopi:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopi/blindkopi, Fra: $email';
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
  String get composeDismiss => 'Lukk';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ikke lagret som identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Lagre som identitet';

  @override
  String composeAliasSaved(String email) {
    return '$email er lagret som identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ugyldig adresse $address';
  }

  @override
  String get composeOriginalNotFound => 'Fant ikke den opprinnelige meldingen.';

  @override
  String get composeDraftNotFound => 'Fant ikke utkastet.';

  @override
  String get composeAttachmentsLost => 'Vedleggene kunne ikke gjenopprettes. Legg dem til på nytt.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Noen vedlegg kunne ikke legges til: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Vedleggene er til sammen $size; noen servere avviser så store meldinger.';
  }

  @override
  String get composeAttachFailed => 'Kunne ikke legge ved filen.';

  @override
  String get composeInvalidAddressTitle => 'Ugyldig adresse';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» er ikke en gyldig e-postadresse.';
  }

  @override
  String get composeNoSubjectTitle => 'Uten emne';

  @override
  String get composeNoSubjectText => 'Denne meldingen har ikke noe emne. Vil du sende den likevel?';

  @override
  String get composeSentBeforeChanges => 'Den ble sendt før endringene dine, som er lagret i Utkast.';

  @override
  String composeScheduled(String time) {
    return 'Planlagt til $time';
  }

  @override
  String get composeSending => 'Sender…';

  @override
  String get composeSent => 'Sendt';

  @override
  String get composeSendFailed => 'Kunne ikke sende. Prøv igjen.';

  @override
  String get composeAlreadySent => 'Allerede sendt.';

  @override
  String get composeDiscardChanges => 'Forkast endringer';

  @override
  String get composeSaveChanges => 'Lagre endringer';

  @override
  String get composeDeleteDraft => 'Slett utkast';

  @override
  String get composeSaveDraft => 'Lagre utkast';

  @override
  String get composeDraftSaved => 'Utkastet er lagret';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Den $date kl. $time skrev $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Den $date kl. $time skrev noen:';
  }

  @override
  String get composeForwardHeader => '---------- Videresendt melding ----------';

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
    return 'Kopi: $addresses';
  }

  @override
  String get composeLaterToday => 'Senere i dag';

  @override
  String get composeTomorrowMorning => 'I morgen tidlig';

  @override
  String get composeMondayMorning => 'Mandag morgen';

  @override
  String get composePickDateTime => 'Velg dato og klokkeslett…';

  @override
  String get composeSendWithoutDelay => 'Send uten forsinkelse';

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
  String get composeRecoveryTitle => 'Vil du fortsette å redigere utkastet ditt?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'En melding ble ikke sendt da Loupe ble lukket.',
      'one': 'En melding til $name ble ikke sendt da Loupe ble lukket.',
      'other': 'En melding til $name og andre ble ikke sendt da Loupe ble lukket.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» ble ikke sendt da Loupe ble lukket.',
      'one': '«$subject» til $name ble ikke sendt da Loupe ble lukket.',
      'other': '«$subject» til $name og andre ble ikke sendt da Loupe ble lukket.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Fortsett redigeringen';

  @override
  String get composeRecoverySave => 'Lagre i Utkast';

  @override
  String get composeRecoveryDiscard => 'Forkast';

  @override
  String get composeRecoverySaved => 'Lagret i Utkast';

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
  String get outboxNoRecipients => 'Ingen mottakere';

  @override
  String get outboxNoSubject => '(Uten emne)';

  @override
  String get outboxSendingFailed => 'Sendingen mislyktes.';

  @override
  String get outboxEmptyTitle => 'Ingenting å sende';

  @override
  String get outboxEmptyText => 'Meldinger du sender senere, venter her til det er tid.';

  @override
  String get outboxSendNow => 'Send nå';

  @override
  String get outboxReschedule => 'Ny tid';

  @override
  String get outboxRescheduleMenu => 'Velg nytt tidspunkt…';

  @override
  String get outboxRescheduleTitle => 'Nytt tidspunkt';

  @override
  String outboxRescheduled(String time) {
    return 'Flyttet til $time';
  }

  @override
  String get outboxCancel => 'Avbryt';

  @override
  String get outboxCancelSending => 'Avbryt sending…';

  @override
  String get outboxCancelTitle => 'Vil du avbryte sendingen?';

  @override
  String get outboxMoveToDrafts => 'Flytt til Utkast';

  @override
  String get outboxDiscard => 'Forkast melding';

  @override
  String get outboxMovedToDrafts => 'Flyttet til Utkast';

  @override
  String get outboxDiscarded => 'Meldingen er forkastet';

  @override
  String get outboxAlreadySent => 'Allerede sendt.';

  @override
  String get outboxBeingSent => 'Denne meldingen sendes nå.';

  @override
  String get outboxActionFailed => 'Det fungerte ikke. Meldingen er fortsatt i utboksen.';

  @override
  String get notificationsBadgeInboxes => 'Uleste i innbokser';

  @override
  String get notificationsBadgeVip => 'Uleste fra VIP-er';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Ny e-post fra VIP-ene dine, på alle kontoer';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Ny e-post i $email';
  }

  @override
  String get notificationsUnknownSender => 'Ukjent avsender';

  @override
  String get notificationsNoSubject => '(Uten emne)';

  @override
  String get notificationsEncryptedMessage => 'Kryptert melding';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Ny melding fra $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nye meldinger',
      one: '1 ny melding',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nye meldinger i $account';
  }

  @override
  String get platformInstantChannel => 'Umiddelbar levering';

  @override
  String get platformInstantChannelDescription => 'Vises mens Loupe ser etter ny e-post i innboksene dine';

  @override
  String get platformInstantTitle => 'Ser etter ny e-post';

  @override
  String get platformInstantText => 'Umiddelbar levering er på';

  @override
  String get platformErrorBox => 'Noe gikk galt da dette skulle vises. Gå tilbake og prøv igjen.';

  @override
  String get welcomeTagline => 'E-post som er enkel på overflaten\nog kraftig under panseret.';

  @override
  String get welcomeAccountsTitle => 'Alle kontoer, én rolig innboks';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail og alle IMAP- eller JMAP-servere.';

  @override
  String get welcomeSearchTitle => 'Søk som finner det';

  @override
  String get welcomeSearchText => 'Umiddelbare treff på telefonen, deretter serverens.';

  @override
  String get welcomePrivacyTitle => 'Privat fra grunnen av';

  @override
  String get welcomePrivacyText => 'Ingen sporing. Eksterne bilder forblir blokkert til du tillater dem.';

  @override
  String get welcomeAddAccount => 'Legg til konto';

  @override
  String get welcomeImport => 'Importer fra Thunderbird';

  @override
  String get welcomeTryDemo => 'Prøv med demo-e-post';
}
