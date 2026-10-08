// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get commonAdd => 'Lägg till';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonClose => 'Stäng';

  @override
  String get commonDelete => 'Radera';

  @override
  String get commonDone => 'Klar';

  @override
  String get commonEdit => 'Redigera';

  @override
  String get commonMore => 'Mer';

  @override
  String get commonMove => 'Flytta';

  @override
  String get commonName => 'Namn';

  @override
  String get commonNone => 'Ingen';

  @override
  String get commonOff => 'Av';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'På';

  @override
  String get commonOptional => 'Valfritt';

  @override
  String get commonPassword => 'Lösenord';

  @override
  String get commonRemove => 'Ta bort';

  @override
  String get commonRetry => 'Försök igen';

  @override
  String get commonSave => 'Spara';

  @override
  String get commonSearch => 'Sök';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Inställningar';

  @override
  String get commonShare => 'Dela';

  @override
  String get commonTryAgain => 'Försök igen';

  @override
  String get commonUndo => 'Ångra';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meddelanden', one: '1 meddelande');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkivera';

  @override
  String get mailDelete => 'Radera';

  @override
  String get mailFlag => 'Flagga';

  @override
  String get mailForward => 'Vidarebefordra';

  @override
  String get mailMarkAsRead => 'Markera som läst';

  @override
  String get mailMarkAsUnread => 'Markera som oläst';

  @override
  String get mailMoveToJunk => 'Flytta till Skräppost';

  @override
  String get mailNewMessage => 'Nytt meddelande';

  @override
  String get mailNoSubject => 'Inget ämne';

  @override
  String get mailReply => 'Svara';

  @override
  String get mailReplyAll => 'Svara alla';

  @override
  String get mailSend => 'Skicka';

  @override
  String get mailUnflag => 'Ta bort flagga';

  @override
  String get mailboxArchive => 'Arkiv';

  @override
  String get mailboxDrafts => 'Utkast';

  @override
  String get mailboxInbox => 'Inkorg';

  @override
  String get mailboxJunk => 'Skräppost';

  @override
  String get mailboxOutbox => 'Utkorg';

  @override
  String get mailboxSent => 'Skickat';

  @override
  String get mailboxTrash => 'Papperskorg';

  @override
  String get conversationSomethingWentWrong => 'Något gick fel. Försök igen.';

  @override
  String get conversationReplyToList => 'Svara till listan';

  @override
  String get conversationReplyList => 'Svara lista';

  @override
  String get conversationThreadMuted => 'Tråden är tystad. Nya meddelanden i den kommer som lästa.';

  @override
  String get conversationThreadUnmuted => 'Tråden är inte längre tystad.';

  @override
  String get conversationLinkFailed => 'Det gick inte att öppna länken.';

  @override
  String get conversationGoneTitle => 'Inget meddelande';

  @override
  String get conversationGoneText => 'Meddelandet har flyttats eller raderats.';

  @override
  String get conversationMuted => 'Tystad';

  @override
  String get conversationReaderOptions => 'Läsalternativ';

  @override
  String get conversationReaderOptionsHint => 'Textstorlek och vy';

  @override
  String get conversationTrash => 'Papperskorg';

  @override
  String get conversationReplyHint => 'Tryck länge för Svara alla och Vidarebefordra';

  @override
  String get conversationOfflineTitle => 'Du är offline';

  @override
  String get conversationOfflineText => 'Konversationen har inte laddats ned än. Den läses in när du är online igen.';

  @override
  String get conversationErrorTitle => 'Meddelandet kan inte visas';

  @override
  String get conversationErrorText => 'Något gick fel.';

  @override
  String get conversationOfflineBanner => 'Du är offline';

  @override
  String get conversationNotUpdated => 'Inte uppdaterad';

  @override
  String get conversationMe => 'mig';

  @override
  String get conversationNoSender => '(ingen avsändare)';

  @override
  String get conversationNoRecipients => 'inga mottagare';

  @override
  String conversationRecipients(String names) {
    return 'till $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'till $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Från';

  @override
  String get conversationHeaderTo => 'Till';

  @override
  String get conversationHeaderCc => 'Kopia';

  @override
  String get conversationHeaderBcc => 'Dold kopia';

  @override
  String get conversationHeaderReplyTo => 'Svara till';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Säkerhet';

  @override
  String get conversationVerifiedSender => 'Verifierad avsändare';

  @override
  String get conversationUnverifiedSender => 'Ej verifierad avsändare';

  @override
  String get conversationLoadingMessage => 'Läser in meddelandet';

  @override
  String get conversationBodyError => 'Det gick inte att läsa in meddelandet.';

  @override
  String get conversationBodyOffline => 'Du är offline. Meddelandet läses in när du är online igen.';

  @override
  String get conversationOriginalHint => 'Ser bättre ut i vyn Original';

  @override
  String get conversationShowOriginal => 'Visa original';

  @override
  String get conversationScrollToTop => 'Rulla till början';

  @override
  String get conversationTagsMenu => 'Taggar…';

  @override
  String get conversationMuteThread => 'Tysta tråden';

  @override
  String get conversationUnmuteThread => 'Sluta tysta tråden';

  @override
  String get conversationMoveMenu => 'Flytta…';

  @override
  String get conversationDeletePermanently => 'Radera permanent';

  @override
  String get conversationMoveToTrash => 'Flytta till papperskorgen';

  @override
  String get conversationNotJunk => 'Inte skräppost';

  @override
  String get conversationShowAllHeaders => 'Visa alla rubrikfält';

  @override
  String get conversationViewSource => 'Visa källkod';

  @override
  String get conversationSaveAsFile => 'Spara som fil…';

  @override
  String get conversationShareAsFile => 'Dela som fil…';

  @override
  String get conversationSearchFromMessageMenu => 'Sök utifrån det här meddelandet…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiera adress';

  @override
  String get conversationAddressCopied => 'Adressen har kopierats';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Sök efter meddelanden från $name';
  }

  @override
  String get conversationTags => 'Taggar';

  @override
  String get conversationAllHeaders => 'Alla rubrikfält';

  @override
  String get conversationCopyAll => 'Kopiera allt';

  @override
  String get conversationHeadersCopied => 'Rubrikfälten har kopierats';

  @override
  String get conversationNoHeaders => 'Inga rubrikfält';

  @override
  String get conversationSearchFromMessageTitle => 'Sök utifrån det här meddelandet';

  @override
  String conversationSearchFrom(String name) {
    return 'Från $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Till $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Ämne ”$subject”';
  }

  @override
  String get conversationSourceTitle => 'Källkod';

  @override
  String get conversationSourceCopied => 'Källkoden har kopierats';

  @override
  String get conversationShareFailed => 'Det gick inte att dela meddelandet.';

  @override
  String get conversationWrapLines => 'Radbryt';

  @override
  String get conversationDontWrapLines => 'Radbryt inte';

  @override
  String get conversationSourceError => 'Det gick inte att läsa in källkoden.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Visar de första $shown av $total. Kopiera eller dela för att få allt.';
  }

  @override
  String get conversationAttachmentUntitled => 'Namnlös';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Fler åtgärder för $name';
  }

  @override
  String get conversationMoveTo => 'Flytta till…';

  @override
  String get conversationMailboxesError => 'Det gick inte att läsa in brevlådorna.';

  @override
  String get conversationReaderReadable => 'Lättläst';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Ren text';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Behåll originalfärgerna';

  @override
  String get conversationReaderRemember => 'Kom ihåg för den här avsändaren';

  @override
  String get conversationSecurityPossiblePhishing => 'Möjligt nätfiske';

  @override
  String get conversationSecurityBeCareful => 'Var försiktig';

  @override
  String get conversationSecurityVerified => 'Verifierad';

  @override
  String get conversationSecurityNoIssues => 'Inga problem hittades';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count spårare', one: '1 spårare');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Visar varför';

  @override
  String get conversationPhishingBannerTitle => 'Det här meddelandet ser ut som nätfiske';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Länkar och bilder är avstängda.';
  }

  @override
  String get conversationPhishingBannerText => 'Länkar och bilder är avstängda.';

  @override
  String get conversationPhishingWhy => 'Varför?';

  @override
  String get conversationPhishingShowAnyway => 'Visa ändå';

  @override
  String get conversationSecurityPhishingTitle => 'Det här ser ut som nätfiske';

  @override
  String get conversationSecurityPhishingText =>
      'Flera tecken tyder på att meddelandet inte är vad det utger sig för att vara.';

  @override
  String get conversationSecurityCarefulTitle => 'Var försiktig med det här meddelandet';

  @override
  String get conversationSecurityCarefulText => 'Något med det förtjänar en extra titt.';

  @override
  String get conversationSecurityVerifiedText => 'Avsändaren är verifierad och inget ser misstänkt ut.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Inget ser misstänkt ut. Din e-postserver angav inte om avsändaren är verifierad.';

  @override
  String get conversationSecurityNothingSuspicious => 'Inget ser misstänkt ut.';

  @override
  String get conversationSecurityWhy => 'Varför';

  @override
  String get conversationSecurityPrivacy => 'Integritet';

  @override
  String get conversationSecurityNoTrackingPixels => 'Inga spårningspixlar';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spårningspixlar borttagna',
      one: '1 spårningspixel borttagen',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'De skulle ha talat om för avsändaren när du öppnade det här meddelandet.';

  @override
  String get conversationSecurityNoRemoteImages => 'Inga fjärrbilder';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count fjärrbilder', one: '1 fjärrbild');
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Om de läses in får avsändaren veta när du läser meddelandet, och din IP-adress.';

  @override
  String get conversationSecurityNoClickTracking => 'Ingen klickspårning';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count länkar via klickspårning',
      one: '1 länk via klickspårning',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services skulle registrera ditt klick. Tryck länge på en länk för att öppna målet direkt.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tekniska detaljer';

  @override
  String get conversationSecurityCheckedLocally => 'Kontrollerat på den här enheten. Inget skickades någonstans.';

  @override
  String get conversationSecurityTrackersLabel => 'Spårare';

  @override
  String get conversationSecurityImagesFrom => 'Bilder från';

  @override
  String get conversationSecuritySenderHistory => 'Avsändarhistorik';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received mottagna, $sent skickade';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Länkar leder till';

  @override
  String get conversationSecurityHidden => 'Dolt';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements element');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters tecken');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Avsändaren är inte verifierad';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Din e-postserver kunde inte bekräfta att meddelandet verkligen kommer från $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Din e-postserver kunde inte bekräfta att meddelandet verkligen kommer från avsändaren.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Din e-postserver kunde inte bekräfta att meddelandet kommer från $domain. Det är vanligt för e-postlistor.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Din e-postserver kunde inte bekräfta att meddelandet kommer från avsändaren. Det är vanligt för e-postlistor.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Gör inget som det ber om om du inte väntade dig det. Kontakta avsändaren på annat sätt om du är osäker.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signerat av en annan domän';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Meddelandet är signerat av $signer, inte $domain. Det gör utskickstjänster, men det bevisar inte vem som skrev det.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Meddelandet är signerat av en annan domän, inte $domain. Det gör utskickstjänster, men det bevisar inte vem som skrev det.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Namnet visar en annan adress';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Avsändarens namn lyder ”$shown”, men meddelandet kommer från $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Lita på adressen, inte på namnet.';

  @override
  String get conversationSecurityReplyToTitle => 'Svar går någon annanstans';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Om du svarar skickas ditt svar till $address, inte till $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Kontrollera adressen innan du svarar med något personligt.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Använder ditt namn';

  @override
  String get conversationSecurityImpersonationTitle => 'Använder namnet på någon du känner';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Det är undertecknat ”$name” som ditt eget namn, men kommer från en ny adress: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Det är undertecknat ”$name” som din VIP $knownName ($knownEmail), men kommer från en ny adress: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Det är undertecknat ”$name” som $knownName ($knownEmail), men kommer från en ny adress: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Och svar skulle gå till ännu en annan adress.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Om det ber om pengar, koder eller filer, kontrollera med personen på annat sätt först.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Känd adress: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Den här adressen: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Första meddelandet från den här avsändaren';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Du har inte fått e-post från $email tidigare.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Var försiktig med förfrågningar från personer du inte känner än.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Förväxlingsbara bokstäver i avsändarens adress';

  @override
  String get conversationSecurityLinkHomographTitle => 'Förväxlingsbara bokstäver i en länk';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host blandar bokstäver från olika alfabet för att efterlikna en annan adress.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host använder förväxlingsbara bokstäver: det är inte $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Radera det eller rapportera det som skräppost.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Öppna den inte.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domän: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Förväxlingsbar domän';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Använder ett välbekant namn i sin domän';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain liknar din egen domän, $real, men är en annan domän.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain liknar $brand ($real), men är en annan domän.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain använder namnet på din egen domän, $real, men hör inte till den.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain använder namnet $brand ($real), men hör inte till det.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Äkta meddelanden från din organisation kommer från $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Äkta meddelanden från $brand kommer från $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Avsändardomän: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Efterliknar: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count länkar döljer vart de leder',
      one: 'En länk döljer vart den leder',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'En länk visar $shown, men öppnar $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Logga inte in och betala inte via de här länkarna. Skriv in adressen själv i stället.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '”$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'En länks mål kan inte kontrolleras';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'En länk visar $shown, men går via $host, som registrerar klicket innan det skickas vidare.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'En länk pekar på en ren IP-adress';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts är ingen namngiven webbplats. Riktiga företag länkar sällan så här.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'En förklädd länk';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'En länk börjar med ”$shown@” för att se ut som $shown, men öppnar $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'En dold sida stängdes av';

  @override
  String get conversationSecurityDataLinkText =>
      'En länk skulle ha öppnat en sida inpackad i meddelandet, ett sätt att kringgå länkkontroller.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Ber om ett lösenord';

  @override
  String get conversationSecurityPasswordFieldText => 'Meddelandet innehöll ett lösenordsfält. Loupe tog bort det.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Skriv aldrig ett lösenord i ett mejl.';

  @override
  String get conversationSecurityScriptLinkTitle => 'En länk som kör kod stängdes av';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe kör aldrig kod från meddelanden.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Förkortade länkar',
      one: 'En förkortad länk',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts döljer det verkliga målet tills du öppnar länken.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Internationell webbadress';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts använder icke-latinska bokstäver. Det är normalt för många språk; kontrollera att det är den webbplats du väntar dig.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mycket dold text';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tecken osynlig text togs bort. Dold text som den här ska lura skräppostfilter.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Dold text borttagen';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tecken osynlig text togs bort.');
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Det gick inte att ladda ned meddelandet. Kontrollera anslutningen och försök igen.';

  @override
  String exportSaved(String name) {
    return '”$name” har sparats';
  }

  @override
  String get exportSaveFailed => 'Det gick inte att spara meddelandet.';

  @override
  String exportFailed(String folder) {
    return 'Det gick inte att exportera ”$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return '”$folder” har inga meddelanden att exportera.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Det gick inte att exportera ”$folder”: inga meddelanden kunde laddas ned. Kontrollera anslutningen och försök igen.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '”$name” har sparats utan $formattedCount meddelanden som inte kunde laddas ned.',
      one: '”$name” har sparats utan 1 meddelande som inte kunde laddas ned.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Det gick inte att spara ”$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Exporterar ”$folder”';
  }

  @override
  String get exportListing => 'Söker efter meddelanden…';

  @override
  String exportProgress(String current, String total) {
    return 'Exporterar $current av $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount meddelanden kunde inte laddas ned',
      one: '1 meddelande kunde inte laddas ned',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Brevlådor';

  @override
  String get mailboxesShown => 'Visas';

  @override
  String get mailboxesHidden => 'Dold';

  @override
  String get mailboxesCollapse => 'Fäll ihop';

  @override
  String get mailboxesExpand => 'Fäll ut';

  @override
  String get mailboxesManageVips => 'Hantera VIP-personer';

  @override
  String get mailboxesSubscriptions => 'Prenumerationer';

  @override
  String mailboxesShowAccount(String account) {
    return 'Visa $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Dölj $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportera mapp…';

  @override
  String get mailboxesUnpin => 'Lossa';

  @override
  String get mailboxesLists => 'Listor';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Spara en sökning för att ha den här.';

  @override
  String get mailboxesTags => 'Taggar';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Du kan också trycka på en avsändares namn i ett meddelande och slå på VIP.';

  @override
  String get mailboxesAddVip => 'Lägg till VIP…';

  @override
  String get mailboxesAddVipTitle => 'Lägg till VIP';

  @override
  String get mailboxesAddVipText => 'E-post från den här adressen får en stjärna och visas i VIP-brevlådan.';

  @override
  String get mailboxesAddVipPlaceholder => 'namn@example.com';

  @override
  String get messageListFilterUnread => 'Olästa';

  @override
  String get messageListFilterFlagged => 'Flaggade';

  @override
  String get messageListFilterToMe => 'Till: mig';

  @override
  String get messageListFilterCcMe => 'Kopia: mig';

  @override
  String get messageListFilterWithAttachments => 'Med bilagor';

  @override
  String get messageListFilterUnreplied => 'Obesvarade';

  @override
  String get messageListFilterFromVips => 'Från VIP-personer';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har markerats som lästa',
      one: '1 meddelande har markerats som läst',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Det gick inte att läsa in äldre e-post.';

  @override
  String get messageListSelectMessages => 'Välj meddelanden';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count markerade', one: '1 markerad');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Markera alla';

  @override
  String get messageListDeselectAll => 'Avmarkera alla';

  @override
  String get messageListLoadFailed => 'Det gick inte att läsa in e-post';

  @override
  String get messageListNoUnread => 'Ingen oläst e-post';

  @override
  String get messageListNoMatches => 'Ingen e-post matchar';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrerat efter: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Stäng av filtret';

  @override
  String get messageListEmpty => 'Ingen e-post';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtervillkor: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrerat efter:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount olästa',
      one: '$formattedCount oläst',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markera';

  @override
  String get messageListTrash => 'Papperskorg';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'INKLUDERA';

  @override
  String get panesHideMailboxes => 'Dölj brevlådor';

  @override
  String get panesShowMailboxes => 'Visa brevlådor';

  @override
  String get panesMailboxesWidth => 'Bredd på brevlådor';

  @override
  String get panesListWidth => 'Bredd på meddelandelistan';

  @override
  String get panesNoMessageSelected => 'Inget meddelande markerat';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meddelanden', one: '1 meddelande');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Snoozade';

  @override
  String get snoozeSheetTitle => 'Snooza';

  @override
  String get snoozeLaterToday => 'Senare i dag';

  @override
  String get snoozeThisEvening => 'I kväll';

  @override
  String get snoozeTomorrow => 'I morgon';

  @override
  String get snoozeThisWeekend => 'I helgen';

  @override
  String get snoozeNextWeek => 'Nästa vecka';

  @override
  String get snoozePickDateTime => 'Välj datum och tid…';

  @override
  String get snoozeMenu => 'Snooza…';

  @override
  String get snoozeWakeNow => 'Väck nu';

  @override
  String get snoozeChangeTimeMenu => 'Ändra snoozetid…';

  @override
  String get snoozeChangeTime => 'Ändra tid';

  @override
  String get snoozeNoTime => 'Ingen tid angiven';

  @override
  String get snoozeFooter => 'Snoozade meddelanden kommer tillbaka till inkorgen som olästa vid den valda tiden.';

  @override
  String get snoozeEmptyTitle => 'Inget snoozat';

  @override
  String get snoozeEmptyText => 'Snooza ett meddelande så kommer det tillbaka till inkorgen när du behöver det.';

  @override
  String get appLockUnlock => 'Lås upp';

  @override
  String get appLockFailed => 'Loupe kunde inte bekräfta att det är du.';

  @override
  String get appLockLockedOut => 'För många försök. Försök igen senare.';

  @override
  String get appLockPromptError => 'Det gick inte att visa dialogrutan. Försök igen.';

  @override
  String get appLockNoScreenLock => 'Den här telefonen har inget skärmlås.';

  @override
  String get appLockUnlockPromptTitle => 'Lås upp Loupe';

  @override
  String get appLockUnlockPromptReason => 'Bekräfta att det är du för att se din e-post.';

  @override
  String get appLockTurnOnPromptTitle => 'Slå på Applås';

  @override
  String get appLockTurnOnPromptReason => 'Bekräfta att det är du för att slå på Applås.';

  @override
  String get appLockScreenLockRemoved =>
      'Applås är avstängt: telefonen har inte längre något skärmlås. Ställ in ett för att slå på Applås igen.';

  @override
  String get appLockAfterImmediately => 'Omedelbart';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuter', one: '1 minut');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count timmar', one: '1 timme');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Krypterat';

  @override
  String get openpgpEncryptedInPart => 'Delvis krypterat';

  @override
  String get openpgpEncryptedLocked => 'Krypterat · låst';

  @override
  String get openpgpEncryptedNoKey => 'Krypterat · ingen nyckel';

  @override
  String get openpgpEncryptedDamaged => 'Krypterat · skadat';

  @override
  String get openpgpEncryptedUnsupported => 'Krypterat · stöds inte';

  @override
  String get openpgpUnknownSigner => 'okänd';

  @override
  String get openpgpUnknownKey => 'Okänd nyckel';

  @override
  String get openpgpSignatureInvalid => 'Ogiltig signatur';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signerat av $name, inte avsändaren';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Delvis signerat av $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signerat av $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signerat med en avvisad nyckel';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signerat av $name · nyckeln är inte godkänd';
  }

  @override
  String get openpgpUnlock => 'Lås upp';

  @override
  String get openpgpCantDecrypt => 'Meddelandet kan inte dekrypteras';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Krypterat med OpenPGP';

  @override
  String get openpgpEncryption => 'Kryptering';

  @override
  String get openpgpDecryptedHere => 'Dekrypterat på den här enheten';

  @override
  String get openpgpNotDecrypted => 'Inte dekrypterat';

  @override
  String get openpgpKeyLocked => 'Din nyckel är låst.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'För nycklarna $keys',
      one: 'För nyckeln $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Skyddat ämne';

  @override
  String get openpgpUnlockKey => 'Lås upp nyckel';

  @override
  String get openpgpSignature => 'Signatur';

  @override
  String get openpgpFingerprint => 'Fingeravtryck';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Nyckel-id $id';
  }

  @override
  String get openpgpSigned => 'Signerat';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Godkännande';

  @override
  String get openpgpChangeAcceptance => 'Ändra godkännande…';

  @override
  String get openpgpCheckedFooter => 'Kontrollerat på den här enheten med OpenPGP, kompatibelt med Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Din nyckel är låst. Lås upp den med dess lösenfras för att läsa meddelandet.';

  @override
  String get openpgpSummaryNoSecretKey => 'Det krypterades för en nyckel som inte finns på den här enheten.';

  @override
  String get openpgpSummaryDamaged => 'Den krypterade datan är skadad eller ändrades på vägen.';

  @override
  String get openpgpSummaryUnsupported => 'Det använder en algoritm som Loupe inte stöder.';

  @override
  String get openpgpSummaryEncrypted => 'Bara du och de andra mottagarna kan läsa det.';

  @override
  String get openpgpSummaryNotSigned => 'Det är inte signerat, så avsändaren är inte bekräftad.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Det är signerat, men med en nyckel du inte har, så signaturen kan inte kontrolleras.';

  @override
  String get openpgpSummaryBadSignature => 'Signaturen stämmer inte: meddelandet kan ha ändrats.';

  @override
  String get openpgpSummaryMismatch => 'Signaturen är giltig, men nyckeln hör till en annan adress än avsändarens.';

  @override
  String get openpgpSummaryPartial =>
      'Bara en del av meddelandet är signerad. Text utanför signaturen (till exempel en sidfot från en e-postlista) visas under raden ”Unsigned content”, och andra delar av meddelandet, som bilagor, omfattas inte heller.';

  @override
  String get openpgpSummaryOwnKey => 'Signerat med din egen nyckel.';

  @override
  String get openpgpSummaryVerified => 'Signaturen är giltig och du har verifierat nyckelns fingeravtryck.';

  @override
  String get openpgpSummaryUnverified =>
      'Signaturen är giltig. Du godkände nyckeln utan att kontrollera dess fingeravtryck.';

  @override
  String get openpgpSummaryRejected => 'Signaturen är giltig, men du har avvisat den här nyckeln.';

  @override
  String get openpgpSummaryUndecided =>
      'Signaturen är giltig, men du har inte godkänt nyckeln än. Jämför dess fingeravtryck med avsändaren.';

  @override
  String get openpgpAcceptanceRejected => 'Avvisad';

  @override
  String get openpgpAcceptanceUndecided => 'Inte godkänd';

  @override
  String get openpgpAcceptanceUnverified => 'Godkänd';

  @override
  String get openpgpAcceptanceVerified => 'Godkänd och verifierad';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Vill du godkänna nyckeln från $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingeravtryck $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ja, jag har verifierat fingeravtrycket';

  @override
  String get openpgpAcceptUnverified => 'Ja, utan att kontrollera';

  @override
  String get openpgpAcceptLater => 'Inte än';

  @override
  String get openpgpRejectKey => 'Avvisa den här nyckeln';

  @override
  String get openpgpNoSubject => '(inget ämne)';

  @override
  String get openpgpEncryptionTitle => 'End-to-end-kryptering';

  @override
  String get openpgpMyKeys => 'Mina OpenPGP-nycklar';

  @override
  String get openpgpMyKeysFooter =>
      'Med en nyckel kan du läsa krypterad e-post och signera och kryptera din egen. Använder du Thunderbird? Exportera din nyckel där (Kontoinställningar › End-to-end-kryptering › Exportera hemlig nyckel) och importera den här.';

  @override
  String get openpgpAddKey => 'Lägg till nyckel…';

  @override
  String get openpgpAddresses => 'Adresser';

  @override
  String get openpgpAddressesFooter => 'Vilken nyckel varje adress använder och när den krypterar och signerar.';

  @override
  String get openpgpCorrespondentsKeys => 'Korrespondenters OpenPGP-nycklar';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Godkänn en nyckel när du litar på att den tillhör sin ägare; jämför fingeravtrycket med ägaren för att markera den som verifierad.';

  @override
  String get openpgpImportPublicKey => 'Importera offentlig nyckel…';

  @override
  String get openpgpCollected => 'Insamlade via Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Nycklar som har kommit med meddelanden. Loupe kan kryptera till dem när båda parter ber om det.';

  @override
  String get openpgpOnThisDevice => 'På den här enheten';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Krypterade meddelanden döljer sitt ämne. Loupe sparar ämnet för varje meddelande du öppnar i sin krypterade databas på den här enheten, så att listan, sökningen och aviseringarna kan visa det. I bakgrunden kan Loupe också dekryptera ämnet i nya meddelanden med nycklar som saknar lösenfras; då laddas varje meddelande (upp till 1 MB) ned.';

  @override
  String get openpgpDecryptSubjects => 'Dekryptera ämnen i bakgrunden';

  @override
  String get openpgpIndexFooter =>
      'Sökningen hittar krypterade meddelanden via avsändare, mottagare och ämne. När detta är på lägger Loupe även till texten i varje krypterat meddelande som dekrypteras i sökindexet i den krypterade databasen på den här enheten, så att sökningen hittar det via texten också. Om du stänger av det tas texten bort ur indexet.';

  @override
  String get openpgpIndexDecrypted => 'Indexera dekrypterade meddelanden för sökning';

  @override
  String get openpgpPassphrases => 'Lösenfraser';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-nycklar och S/MIME-certifikat som du skyddar med en lösenfras låses upp när de behövs. Utan ”Kom ihåg” låses de igen två minuter efter varje användning.';

  @override
  String get openpgpRememberPassphrases => 'Kom ihåg lösenfraser';

  @override
  String get openpgpRememberPassphrasesDetail => 'Tills Loupe stängs';

  @override
  String get openpgpLockKeysNow => 'Lås nycklar nu';

  @override
  String get openpgpKeysLocked => 'Nycklarna är låsta.';

  @override
  String get openpgpKeyStateRevoked => 'återkallad';

  @override
  String get openpgpKeyStateExpired => 'har upphört';

  @override
  String get openpgpKeyStateNeverExpires => 'upphör aldrig';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'upphör $date';
  }

  @override
  String get openpgpNoKey => 'Ingen nyckel';

  @override
  String get openpgpAlwaysEncrypt => 'Kryptera alltid';

  @override
  String get openpgpAddKeyTitle => 'Lägg till en OpenPGP-nyckel';

  @override
  String get openpgpAddKeyMessage => 'Importera nyckeln du använder i Thunderbird eller skapa en ny.';

  @override
  String get openpgpImportFromClipboard => 'Importera från urklipp';

  @override
  String get openpgpImportFromFile => 'Importera från fil';

  @override
  String get openpgpGenerateNewKey => 'Skapa ny nyckel';

  @override
  String get openpgpImportPublicKeyTitle => 'Importera en offentlig nyckel';

  @override
  String get openpgpFromClipboard => 'Från urklipp';

  @override
  String get openpgpFromFile => 'Från fil';

  @override
  String get openpgpClipboardEmpty => 'Urklippet är tomt. Kopiera nyckeln först.';

  @override
  String get openpgpKey => 'Nyckel';

  @override
  String get openpgpValidityRevoked => 'Återkallad';

  @override
  String openpgpValidityExpired(String date) {
    return 'Upphörde $date';
  }

  @override
  String get openpgpNeverExpires => 'Upphör aldrig';

  @override
  String openpgpValidUntil(String date) {
    return 'Giltig till $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingeravtrycket har kopierats.';

  @override
  String get openpgpAlgorithm => 'Algoritm';

  @override
  String get openpgpCreated => 'Skapad';

  @override
  String get openpgpValidity => 'Giltighet';

  @override
  String get openpgpProtection => 'Skydd';

  @override
  String get openpgpProtectionPassphrase => 'Lösenfras';

  @override
  String get openpgpProtectionKeychain => 'Endast telefonens nyckellager';

  @override
  String get openpgpKeyDetailsFooter =>
      'Dela din offentliga nyckel så att andra kan kryptera till dig. Säkerhetskopian är din hemliga nyckel, skyddad av dess lösenfras om den har en: håll den privat.';

  @override
  String get openpgpSharePublicKey => 'Dela offentlig nyckel';

  @override
  String get openpgpCopyPublicKey => 'Kopiera offentlig nyckel';

  @override
  String get openpgpPublicKeyCopied => 'Den offentliga nyckeln har kopierats.';

  @override
  String get openpgpBackUpSecretKey => 'Säkerhetskopiera hemlig nyckel';

  @override
  String get openpgpDeleteKey => 'Radera nyckel';

  @override
  String get openpgpRemoveKey => 'Ta bort nyckel';

  @override
  String get openpgpBackUpTitle => 'Vill du säkerhetskopiera den hemliga nyckeln?';

  @override
  String get openpgpBackUpProtected =>
      'Säkerhetskopian skyddas av nyckelns lösenfras. Den som har båda kan läsa din e-post.';

  @override
  String get openpgpBackUpUnprotected =>
      'Den här nyckeln har ingen lösenfras: den som har säkerhetskopian kan läsa din e-post och signera som du.';

  @override
  String get openpgpBackUp => 'Säkerhetskopiera';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Vill du radera din nyckel $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Vill du ta bort nyckeln från $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'E-post som är krypterad till den här nyckeln kan inte längre läsas på den här enheten, om du inte importerar den igen.';

  @override
  String get openpgpRemoveKeyMessage => 'Du kan importera den igen senare.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-nyckel';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Lägg till en nyckel under End-to-end-kryptering för att kryptera och signera e-post från den här adressen.';

  @override
  String get openpgpGenerateAKey => 'Skapa en nyckel…';

  @override
  String get openpgpSending => 'Sändning';

  @override
  String get openpgpSendingFooter =>
      'Automatisk kryptering slås på när alla mottagare har en godkänd nyckel eller ett betrott certifikat, eller när Autocrypt säger att båda parter vill det. Krypterad e-post signeras alltid.';

  @override
  String get openpgpEncryptAutomatically => 'Kryptera automatiskt';

  @override
  String get openpgpAlwaysEncryptDetail => 'Vägrar skicka när en mottagare saknar nyckel';

  @override
  String get openpgpSignUnencrypted => 'Signera okrypterad e-post';

  @override
  String get openpgpAttachPublicKey => 'Bifoga min offentliga nyckel';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt skickar med din offentliga nyckel i varje meddelande, så att andra appar kan kryptera till dig utan någon konfiguration.';

  @override
  String get openpgpSendMyKey => 'Skicka min nyckel med e-post';

  @override
  String get openpgpPreferEncryption => 'Föredra kryptering';

  @override
  String get openpgpPreferEncryptionDetail => 'Be andra att kryptera när de kan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count år', one: '1 år');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Lösenfraserna stämmer inte överens.';

  @override
  String openpgpKeyReady(String id) {
    return 'Din nyckel $id är klar.';
  }

  @override
  String get openpgpNewKey => 'Ny nyckel';

  @override
  String get openpgpNewKeyFor => 'För';

  @override
  String get openpgpYourName => 'Ditt namn';

  @override
  String get openpgpAddress => 'Adress';

  @override
  String get openpgpPassphrase => 'Lösenfras';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valfritt. Utan lösenfras skyddas nyckeln enbart av telefonens nyckellager och Loupe frågar aldrig. Med en lösenfras frågar Loupe efter den när nyckeln behövs.';

  @override
  String get openpgpRepeatPassphrase => 'Upprepa';

  @override
  String get openpgpExpires => 'Upphör';

  @override
  String get openpgpExpiresFooter => 'Du kan skapa en ny nyckel innan den upphör. Thunderbird använder också tre år.';

  @override
  String get openpgpGenerateKey => 'Skapa nyckel';

  @override
  String get openpgpKeyFor => 'Nyckel för';

  @override
  String get openpgpCantEncrypt => 'Kan inte kryptera';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Det finns ingen OpenPGP-nyckel för $names, och den här adressen krypterar alltid. Ta bort mottagaren eller importera mottagarens nyckel under Inställningar › End-to-end-kryptering.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Det finns inget giltigt S/MIME-certifikat för $names, och den här adressen krypterar alltid. Ta bort mottagaren eller importera mottagarens certifikat under Inställningar › End-to-end-kryptering.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Det finns ingen OpenPGP-nyckel för $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Det finns inget giltigt S/MIME-certifikat för $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Skicka okrypterat';

  @override
  String get openpgpCantSign => 'Kan inte signera';

  @override
  String get openpgpCantSignMessage =>
      'Den privata nyckeln till ditt S/MIME-certifikat finns inte på den här enheten. Importera certifikatet igen (en .p12- eller .pfx-fil) under Inställningar › End-to-end-kryptering.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Ingen nyckel för $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Inget certifikat för $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Nycklar från Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Alla har en nyckel';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Alla har ett certifikat';

  @override
  String get openpgpComposeEncrypt => 'Kryptera';

  @override
  String get openpgpComposeSign => 'Signera';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, byt';
  }

  @override
  String get openpgpNoKeyFound => 'Ingen OpenPGP-nyckel hittades.';

  @override
  String get openpgpImportSecretKeyTitle => 'Vill du importera en hemlig nyckel?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Den här bilagan innehåller en hemlig nyckel ($names). Importera den bara som din egen nyckel om du själv har exporterat den, till exempel från Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importera som min nyckel';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'din nyckel $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vill du importera $count nycklar ($names)?',
      one: 'Vill du importera nyckeln från $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importera och godkänn';

  @override
  String get openpgpImportDecideLater => 'Importera, bestäm senare';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'nyckeln från $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importerade: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-nycklar är bifogade.',
      one: 'En OpenPGP-nyckel är bifogad.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importera';

  @override
  String get openpgpUnlockKeyTitle => 'Lås upp OpenPGP-nyckel';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Ange lösenfrasen för nyckeln från $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Lösenfrasen är fel. Försök igen.';

  @override
  String get openpgpExplainLocked => 'Det här meddelandet är krypterat. Lås upp din OpenPGP-nyckel för att läsa det.';

  @override
  String get openpgpExplainNoKey =>
      'Det här meddelandet är krypterat, men inte till någon OpenPGP-nyckel på den här enheten. Om du läser det i Thunderbird kan du importera din nyckel därifrån: Inställningar › End-to-end-kryptering.';

  @override
  String get openpgpExplainDamaged => 'Det här krypterade meddelandet är skadat och kan inte dekrypteras säkert.';

  @override
  String get openpgpExplainUnsupported => 'Det här meddelandet använder kryptering som Loupe inte kan läsa än.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Det här meddelandet är krypterat med S/MIME, men inte till något certifikat på den här enheten. Importera ditt certifikat (en .p12- eller .pfx-fil) under Inställningar › End-to-end-kryptering.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Det här meddelandet är krypterat. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Lås upp ditt S/MIME-certifikat för att läsa det.';

  @override
  String get openpgpAttachmentGone => 'Den här bilagan är inte längre tillgänglig.';

  @override
  String get smimeEncrypted => 'Krypterat (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Krypterat (S/MIME) · inget certifikat';

  @override
  String get smimeEncryptedDamaged => 'Krypterat (S/MIME) · skadat';

  @override
  String get smimeEncryptedUnsupported => 'Krypterat (S/MIME) · stöds inte';

  @override
  String get smimeEncryptedLocked => 'Krypterat (S/MIME) · låst';

  @override
  String get smimeUnknownSigner => 'okänd';

  @override
  String get smimeSignatureModified => 'Ogiltig signatur: meddelandet har ändrats';

  @override
  String get smimeSignatureWeak => 'Osäker signatur: föråldrad algoritm';

  @override
  String get smimeSignatureUncheckable => 'Signaturen kan inte kontrolleras';

  @override
  String get smimeSignedCertificateMissing => 'Signerat · certifikat saknas';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signerat av $name · certifikatet är återkallat';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signerat av $name · vid ett annat datum';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signerat av $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signerat av $name · ogiltigt certifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signerat av $name · inte betrott';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signerat av $name · certifikatet har upphört';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signerat av $name · certifikatet är inte giltigt än';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signerat av $name · certifikatet är inte avsett för e-post';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signerat av $name, inte avsändaren';
  }

  @override
  String get smimeCantDecrypt => 'Meddelandet kan inte dekrypteras';

  @override
  String get smimeEncryptedWithSmime => 'Krypterat med S/MIME';

  @override
  String get smimeEncryption => 'Kryptering';

  @override
  String get smimeDecryptedHere => 'Dekrypterat på den här enheten';

  @override
  String get smimeNotDecrypted => 'Inte dekrypterat';

  @override
  String get smimeAuthenticated => 'autentiserad';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'för $count certifikat',
      one: 'för 1 certifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatur';

  @override
  String get smimeIssuedBy => 'Utfärdat av';

  @override
  String get smimeValid => 'Giltigt';

  @override
  String smimeValidRange(String from, String to) {
    return '$from till $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-fingeravtryck';

  @override
  String get smimeSigned => 'Signerat';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Kontrollerar återkallelse…';

  @override
  String get smimeNotRevoked => 'Inte återkallat';

  @override
  String get smimeRevoked => 'Återkallat';

  @override
  String get smimeRevocationUnknown => 'Okänt om det är återkallat';

  @override
  String smimeRevokedSince(String date) {
    return 'Sedan $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Frågade utfärdaren (dess spärrlista), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Frågade utfärdaren (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Lita på ”$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Lita på det här certifikatet…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Kontrollerat på den här enheten med S/MIME, kompatibelt med Outlook och Thunderbird; återkallelse hos certifikatutfärdaren.';

  @override
  String get smimeCheckedFooter =>
      'Kontrollerat på den här enheten med S/MIME, kompatibelt med Outlook och Thunderbird. Återkallelse kontrolleras inte (Inställningar › End-to-end-kryptering).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vill du lita på $name för e-post?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vill du lita på certifikatet från $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Alla certifikat som den här utfärdaren utfärdar blir betrodda, som ditt företags CA. Jämför först fingeravtrycket med ägaren:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Jämför först fingeravtrycket med ägaren:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Lita på';

  @override
  String get smimeSummaryNoKey => 'Det krypterades för ett certifikat som inte finns på den här enheten.';

  @override
  String get smimeSummaryDamaged => 'Den krypterade datan är skadad eller ändrades på vägen.';

  @override
  String get smimeSummaryUnsupported => 'Det använder en algoritm som Loupe inte stöder.';

  @override
  String get smimeSummaryLocked => 'Ditt S/MIME-certifikat är låst.';

  @override
  String get smimeSummaryEncrypted => 'Bara du och de andra mottagarna kan läsa det.';

  @override
  String get smimeSummaryNotSigned => 'Det är inte signerat, så avsändaren är inte bekräftad.';

  @override
  String get smimeSummaryModified => 'Signaturen stämmer inte: meddelandet ändrades efter att det signerades.';

  @override
  String get smimeSummaryUncheckable => 'Signaturen kan inte kontrolleras.';

  @override
  String get smimeSummaryNoCertificate =>
      'Undertecknarens certifikat finns inte i meddelandet, så det kan inte kontrolleras.';

  @override
  String get smimeSummaryRevoked =>
      'Certifikatutfärdaren har återkallat undertecknarens certifikat: signaturen går inte att lita på.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikatutfärdaren har återkallat undertecknarens certifikat ($reason): signaturen går inte att lita på.';
  }

  @override
  String get smimeDateMismatch =>
      'Det signerades mer än en timme från meddelandets datum: det kan vara ett gammalt meddelande som skickats igen.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Signaturen är giltig och $issuer intygar att certifikatet tillhör avsändaren.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikatet eller någon av dess utfärdare är ogiltig.';

  @override
  String get smimeProblemUntrusted => 'Certifikatet kommer från en utfärdare som Loupe inte litar på.';

  @override
  String get smimeProblemExpired => 'Certifikatet hade upphört.';

  @override
  String get smimeProblemNotYetValid => 'Certifikatet var inte giltigt än.';

  @override
  String get smimeProblemWrongUsage => 'Certifikatet är inte avsett för e-post.';

  @override
  String get smimeProblemWrongAddress => 'Certifikatet tillhör en annan adress än avsändarens.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Betrott · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Inte betrott · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Upphörde $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Giltigt från $date';
  }

  @override
  String get smimeTrustInvalid => 'Ogiltigt';

  @override
  String get smimeTrustNotForMail => 'Inte för e-post';

  @override
  String get smimeTrustAnotherAddress => 'En annan adress';

  @override
  String get smimeMyCertificates => 'Mina S/MIME-certifikat';

  @override
  String get smimeMyCertificatesFooter =>
      'För S/MIME, som Outlook och många företag använder. Importera ditt certifikat med dess privata nyckel (en .p12- eller .pfx-fil), exporterad från Outlook, Windows, macOS eller Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'För S/MIME, som Outlook och många företag använder. Importera ditt certifikat med dess privata nyckel (en .p12- eller .pfx-fil), exporterad från Outlook, Windows, macOS eller Thunderbird, eller använd ett som ditt företag eller du själv har installerat på den här enheten.';

  @override
  String get smimeCertificateExpired => 'har upphört';

  @override
  String smimeCertificateUntil(String date) {
    return 'till $date';
  }

  @override
  String get smimeCertificateOnDevice => 'på den här enheten';

  @override
  String get smimeImportCertificateEllipsis => 'Importera certifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Använd ett certifikat från den här enheten…';

  @override
  String get smimeCorrespondentsCertificates => 'Korrespondenters certifikat';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Insamlade från signerad e-post, som Outlook och Thunderbird gör. E-post krypteras bara till betrodda certifikat: Loupe litar på de utfärdare som Mozilla litar på för e-post, och på dem du lägger till.';

  @override
  String get smimeRevocation => 'Återkallelse';

  @override
  String get smimeRevocationFooter =>
      'När du öppnar signerad e-post frågar Loupe utfärdaren av undertecknarens certifikat om det har återkallats (via utfärdarens OCSP-tjänst eller spärrlista). Utfärdaren kan då se när någon på din internetadress läser e-post som signerats med det certifikatet. Svaren sparas på den här enheten tills de upphör att gälla. Ett återkallat certifikat visas som ”återkallat” i meddelandets sidhuvud.';

  @override
  String get smimeCheckRevocation => 'Kontrollera återkallelse av certifikat online';

  @override
  String get smimeTrustedAuthorities => 'Betrodda utfärdare';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Betrodda av dig, utöver de $count som Mozilla litar på för e-post.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikatutfärdare';

  @override
  String get smimeImportACertificate => 'Importera ett certifikat';

  @override
  String get smimeImportContactMessage =>
      'En korrespondents certifikat (.cer, .crt, .pem) eller en certifikatutfärdares.';

  @override
  String get smimeFromClipboard => 'Från urklipp';

  @override
  String get smimeFromFile => 'Från fil';

  @override
  String get smimeClipboardEmpty => 'Urklippet är tomt. Kopiera certifikatet först.';

  @override
  String get smimeCertificate => 'Certifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Den privata nyckeln stannar i Androids lagring för användaruppgifter, där ditt företag eller du själv installerade den: Loupe ber Android att signera och dekryptera med den. Signerad e-post signeras när du skickar den.';

  @override
  String get smimeAddresses => 'Adresser';

  @override
  String get smimeUsage => 'För';

  @override
  String get smimeUsageNone => 'Inget som Loupe använder';

  @override
  String get smimeUsageSigning => 'Signering';

  @override
  String get smimeUsageEncryption => 'Kryptering';

  @override
  String get smimeUsageCertificates => 'Certifikat';

  @override
  String get smimeAlgorithm => 'Algoritm';

  @override
  String get smimeSerialNumber => 'Serienummer';

  @override
  String get smimeFingerprintCopied => 'Fingeravtrycket har kopierats.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-tumavtryck';

  @override
  String get smimePrivateKey => 'Privat nyckel';

  @override
  String get smimeKeyOnDevice => 'På den här enheten';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'I Loupe, med en lösenfras';

  @override
  String get smimeKeyInLoupe => 'I Loupe';

  @override
  String get smimeSource => 'Från';

  @override
  String get smimeSourceSignedMail => 'Signerad e-post';

  @override
  String get smimeSourceImported => 'Importerat';

  @override
  String get smimeTrustHeader => 'Förtroende';

  @override
  String get smimeTrustedRoot => 'Betrodd rot';

  @override
  String get smimeIssuer => 'Utfärdare';

  @override
  String smimeTrustNamed(String name) {
    return 'Lita på ”$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Lita på den här utfärdaren';

  @override
  String get smimeTrustThisCertificate => 'Lita på det här certifikatet';

  @override
  String get smimeStopTrusting => 'Sluta lita på';

  @override
  String get smimePassphrase => 'Lösenfras';

  @override
  String get smimePassphraseFooter =>
      'Valfritt. Med en lösenfras krypteras den privata nyckeln även på den här enheten (Argon2id och AES-256), och Loupe ber om den för att signera och dekryptera; Kom ihåg lösenfraser avgör hur länge. E-post du skickar signeras när du skickar den; arbete i bakgrunden kan inte använda nyckeln.';

  @override
  String get smimeChangePassphrase => 'Ändra lösenfras…';

  @override
  String get smimeSetPassphraseEllipsis => 'Ange lösenfras…';

  @override
  String get smimeRemovePassphrase => 'Ta bort lösenfras';

  @override
  String get smimeShareCertificate => 'Dela certifikat';

  @override
  String get smimeDeleteCertificate => 'Radera certifikat';

  @override
  String get smimeRemoveCertificate => 'Ta bort certifikat';

  @override
  String get smimePassphraseChanged => 'Lösenfrasen har ändrats.';

  @override
  String get smimePassphraseSet => 'Lösenfrasen har angetts.';

  @override
  String get smimeRemovePassphraseTitle => 'Vill du ta bort lösenfrasen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Den privata nyckeln skyddas då bara av nyckellagret, som utan lösenfras: Loupe frågar inte längre efter den och arbete i bakgrunden kan använda den.';

  @override
  String get smimePassphraseRemoved => 'Lösenfrasen har tagits bort.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vill du lita på $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Alla certifikat som den utfärdar blir betrodda för e-post. Jämför först fingeravtrycket med ägaren:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Vill du radera ditt certifikat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Vill du ta bort certifikatet från $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe slutar använda det: e-post som är krypterad till det kan inte längre läsas i Loupe. Certifikatet finns kvar på den här enheten (Inställningar › Säkerhet › Kryptering och användaruppgifter).';

  @override
  String get smimeDeleteOwnMessage =>
      'Den privata nyckeln raderas från den här enheten: e-post som är krypterad till den kan inte längre läsas här, om du inte importerar den igen.';

  @override
  String get smimeRemoveContactMessage => 'Det kommer tillbaka med personens nästa signerade meddelande.';

  @override
  String get smimeAddressImportFooter =>
      'Importera ett certifikat för den här adressen för att signera och kryptera med S/MIME, som Outlook gör.';

  @override
  String get smimeImportACertificateEllipsis => 'Importera ett certifikat…';

  @override
  String get smimePreferFooter =>
      'När båda kan skydda ett meddelande används den föredragna, om inte bara den andra har en nyckel eller ett certifikat för alla mottagare.';

  @override
  String get smimePreferSmime => 'Föredra S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Framför OpenPGP';

  @override
  String get smimeCertificatePassword => 'Certifikatlösenord';

  @override
  String get smimeCertificatePasswordPrompt => 'Ange lösenordet som certifikatfilen exporterades med.';

  @override
  String get smimeImport => 'Importera';

  @override
  String get smimeWrongPassword => 'Lösenordet är fel. Försök igen.';

  @override
  String get smimeNoCertificateFound => 'Inget certifikat hittades.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikatet från $name';
  }

  @override
  String get smimeNothingNew => 'Inget nytt att importera.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importerade: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerade $count betrodda utfärdare.',
      one: 'Importerade en betrodd utfärdare.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importerade $certificates och $count betrodda utfärdare.',
      one: 'Importerade $certificates och en betrodd utfärdare.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Den här filen har ingen privat nyckel. Exportera ditt certifikat med dess privata nyckel.';

  @override
  String get smimeImportAsYoursTitle => 'Vill du importera det som ditt certifikat?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Den här bilagan innehåller ett certifikat med dess privata nyckel: $names. Importera det bara om du själv har exporterat det, till exempel från Outlook eller Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importera som mitt certifikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Ditt certifikat $names har importerats.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Ditt certifikat $name ($addresses) har lagts till från den här enheten.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vill du lita på ”$name” för e-post?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe känner inte till den här certifikatutfärdaren (kanske ett företags egen). Lita på den för att kontrollera certifikaten den utfärdar. Jämför först fingeravtrycket med din it-avdelning:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certifikat är bifogade.',
      one: 'Ett certifikat är bifogat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importera certifikat';

  @override
  String get smimeUnlockTitle => 'Lås upp S/MIME-certifikat';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Ange lösenfrasen för certifikatet från $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Lösenfrasen är fel. Försök igen.';

  @override
  String get smimeUnlock => 'Lås upp';

  @override
  String get smimeEnterAPassphrase => 'Ange en lösenfras.';

  @override
  String get smimePassphrasesDiffer => 'De två lösenfraserna skiljer sig åt.';

  @override
  String get smimeSetPassphraseTitle => 'Ange lösenfras';

  @override
  String get smimeSetPassphraseText =>
      'Loupe ber om den för att signera och dekryptera. Om du glömmer den kan du importera certifikatet igen från dess .p12-fil.';

  @override
  String get smimePassphraseAgain => 'Igen';

  @override
  String get smimeSetPassphraseButton => 'Ange';

  @override
  String get smimeLockedOpenAgain => 'Ditt S/MIME-certifikat är låst. Öppna meddelandet igen för att låsa upp det.';

  @override
  String get smimeDeviceHasNoCertificates => 'Den här enheten erbjuder inte sina certifikat.';

  @override
  String get smimeCantReadCertificate => 'Loupe kan inte läsa det här certifikatet.';

  @override
  String get smimeCertificateNotForMail =>
      'Det här certifikatet är inte för e-post: det har ingen e-postadress eller är inte avsett för signering eller kryptering.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikatet finns inte längre på den här enheten, eller så får Loupe inte längre använda det. Välj det igen under Inställningar › End-to-end-kryptering.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikatet på den här enheten kan bara användas medan Loupe är öppen.';

  @override
  String get smimeDeviceKeyDamaged => 'Den krypterade nyckeln är skadad.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikatet på den här enheten kan inte göra detta: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'stöds inte';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikatet på den här enheten misslyckades: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Utfärdarens adress är ingen webbadress.';

  @override
  String get smimeAuthorityTimeout => 'Certifikatutfärdaren svarade inte i tid.';

  @override
  String get smimeAuthorityUnreachable => 'Det gick inte att nå certifikatutfärdaren.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikatutfärdaren svarade $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Certifikatutfärdarens svar är för stort.';

  @override
  String get smimeRevocationNotChecked =>
      'Inte kontrollerat: bara certifikat från en utfärdare som Loupe litar på kontrolleras.';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Samma som telefonen';

  @override
  String get settingsLanguageFooter =>
      'Loupe använder telefonens språk när appen har det, och annars engelska. Språket du väljer här gäller bara Loupe, även aviseringar.';

  @override
  String get settingsAccountsHeader => 'Konton';

  @override
  String get settingsAddAccount => 'Lägg till konto';

  @override
  String get settingsMailHeader => 'E-post';

  @override
  String get settingsSwipeActions => 'Svephandlingar';

  @override
  String get settingsSwipeLeft => 'Svep åt vänster';

  @override
  String get settingsSwipeLeftFooter =>
      'Ett helt svep utför den här åtgärden. Flagga och Mer finns alltid ett kort svep bort.';

  @override
  String get settingsSwipeRight => 'Svep åt höger';

  @override
  String get settingsSwipeRightFooter => 'Ett helt svep utför den här åtgärden.';

  @override
  String get settingsSwipeToggleRead => 'Markera som läst/oläst';

  @override
  String get settingsSwipeTrash => 'Papperskorg';

  @override
  String get settingsSwipeMove => 'Flytta meddelande';

  @override
  String get settingsSwipeSnooze => 'Snooza';

  @override
  String get settingsThreaded => 'Ordna efter konversation';

  @override
  String get settingsUndoSendDelay => 'Fördröjning för ångra skicka';

  @override
  String get settingsUndoSendDelayFooter => 'Skickade meddelanden väntar så här länge, så att du kan ta tillbaka dem.';

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
  String get settingsThemeSystem => 'Automatiskt';

  @override
  String get settingsThemeLight => 'Ljust';

  @override
  String get settingsThemeDark => 'Mörkt';

  @override
  String get settingsDensity => 'Meddelandelista';

  @override
  String get settingsDensityComfortable => 'Luftig';

  @override
  String get settingsDensityCompact => 'Kompakt';

  @override
  String get settingsReadingHeader => 'Läsning';

  @override
  String get settingsReadingFooter => 'Fjärrbilder kan avslöja för avsändare när och var du öppnade ett meddelande.';

  @override
  String get settingsDefaultView => 'Standardvy';

  @override
  String get settingsDefaultViewFooter => 'Du kan byta vy för valfritt meddelande med Aa-knappen.';

  @override
  String get settingsViewReadable => 'Lättläst';

  @override
  String get settingsViewReadableDetail => 'Ren och tydlig, följer mörkt läge';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exakt som avsändaren utformade det';

  @override
  String get settingsViewPlain => 'Ren text';

  @override
  String get settingsViewPlainDetail => 'Bara orden';

  @override
  String get settingsPlainTextFont => 'Typsnitt för ren text';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Fast bredd';

  @override
  String get settingsFontMonoDetail => 'Håller ASCII-konst och tabeller i linje';

  @override
  String get settingsTechnicalLists => 'Tekniska listor';

  @override
  String get settingsLoadRemoteImages => 'Läs in fjärrbilder';

  @override
  String get settingsOpenLinksDirectly => 'Öppna länkar direkt';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Hoppa över klickspårning när målet är känt';

  @override
  String get settingsSecurityHeader => 'Säkerhet';

  @override
  String get settingsAppLock => 'Applås';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe frågar när appen startar och när du kommer tillbaka efter att ha varit borta längre än tiden under Lås efter.';

  @override
  String get settingsAppLockFooterOff =>
      'Applås ber om ditt fingeravtryck, ditt ansikte eller ditt skärmlås innan din e-post visas.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Applås är fortfarande avstängt. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Ställ in en lösenkod';

  @override
  String get settingsScreenLockTextIos =>
      'Applås använder Face ID, Touch ID eller din lösenkod, och den här iPhonen har ingen lösenkod. Ställ in en i appen Inställningar och slå sedan på Applås.';

  @override
  String get settingsScreenLockTitleAndroid => 'Ställ in ett skärmlås';

  @override
  String get settingsScreenLockTextAndroid =>
      'Applås använder telefonens skärmlås, eller ett fingeravtryck eller ansikte som lagts till i det, och den här telefonen har inget. Ställ in en pinkod, ett mönster eller ett lösenord i Androids inställningar och slå sedan på Applås.';

  @override
  String get settingsOpenSystemSettings => 'Öppna Inställningar';

  @override
  String get settingsOpenAndroidSettings => 'Öppna Android-inställningar';

  @override
  String get settingsLockAfter => 'Lås efter';

  @override
  String get settingsLockAfterFooter => 'Hur länge Loupe får vara i bakgrunden innan den frågar igen.';

  @override
  String get settingsNotifications => 'Aviseringar';

  @override
  String get settingsEncryption => 'End-to-end-kryptering';

  @override
  String get settingsAdvanced => 'Avancerat';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo-e-post är en påhittad brevlåda som bara finns i den här telefonen. Inget skickas någonstans.';

  @override
  String get settingsDemoMode => 'Demoläge';

  @override
  String get settingsResetApp => 'Återställ appen';

  @override
  String get settingsResetFooter => 'Glömmer alla inställningar och går tillbaka till välkomstskärmen.';

  @override
  String get settingsResetTitle => 'Vill du återställa Loupe?';

  @override
  String get settingsResetMessage =>
      'Detta glömmer alla inställningar, Smart Mailboxes och senaste sökningar och går tillbaka till välkomstskärmen.';

  @override
  String get settingsAboutHeader => 'Om';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicences => 'Licenser';

  @override
  String get settingsPrivacy => 'Integritet';

  @override
  String get settingsPrivacyDetail =>
      'Loupe har ingen statistikinsamling och ingen spårning. Din e-post går bara till dina e-postservrar.';

  @override
  String get settingsNotificationsOffIos => 'Aviseringar är avstängda för Loupe i Inställningar.';

  @override
  String get settingsNotificationsOffAndroid => 'Aviseringar är avstängda för Loupe i Androids inställningar.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system låter inte Loupe visa aviseringar. Tillåt dem i Inställningar.';
  }

  @override
  String get settingsNewMailHeader => 'Ny e-post';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo-e-post kommer inte i bakgrunden. Skicka en testavisering för att se hur ny e-post ser ut.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe söker efter ny e-post i bakgrunden när iOS tillåter det, vilket kan vara med timmars mellanrum för appar du sällan öppnar. Du får veta om nya meddelanden i dina inkorgar och från VIP-personer i alla mappar.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe söker efter ny e-post ungefär var 15:e minut när Android tillåter det. Du får veta om nya meddelanden i dina inkorgar och från VIP-personer i alla mappar.';

  @override
  String get settingsNoAccounts => 'Inga konton';

  @override
  String get settingsVipOnly => 'Endast VIP';

  @override
  String get settingsVipOnlyDetail => 'Bara meddelanden från dina VIP-personer';

  @override
  String get settingsHideContent => 'Dölj innehåll';

  @override
  String get settingsHideContentFooterOn =>
      'Aviseringar visar bara ”Nytt meddelande från” och kontot, inte vem som skrev eller vad det gäller.';

  @override
  String get settingsHideContentFooterOff =>
      'Dölj innehåll håller avsändare, ämne och förhandsvisning borta från låsskärmen och aviseringarna.';

  @override
  String get settingsBackgroundAppRefresh => 'Bakgrundsuppdatering';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Ny e-post kommer bara i bakgrunden medan Bakgrundsuppdatering är på för Loupe i Inställningar. iOS kan inte hålla en anslutning till dina inkorgar öppen, så det finns ingen direktleverans.';

  @override
  String get settingsInstantDelivery => 'Direktleverans';

  @override
  String get settingsInstantDeliveryFooter =>
      'Direktleverans (experimentell) håller en anslutning till dina inkorgar öppen, så att ny e-post kommer inom några sekunder. Den visar en diskret avisering, ”Bevakar ny e-post”, och drar mer batteri.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android kan stoppa Direktleverans för att spara batteri. Låt Loupe använda batteriet utan begränsningar för att hålla den igång.';

  @override
  String get settingsExperimental => 'Experimentell';

  @override
  String get settingsComingSoon => 'Kommer snart';

  @override
  String get settingsAllowUnrestrictedBattery => 'Tillåt obegränsad batterianvändning';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push låter ny e-post väcka Loupe direkt, där din e-posttjänst har stöd för det. Push-meddelanden går via Googles pushtjänst och innehåller ingen e-post, bara ”kolla nu”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Den här telefonen kan inte ta emot push-meddelanden: de kräver Google Play-tjänster och en nätverksanslutning. Loupe söker fortfarande efter ny e-post ungefär var 15:e minut.';

  @override
  String get settingsCopyPushToken => 'Kopiera push-token';

  @override
  String get settingsPushTokenCopied => 'Push-token har kopierats';

  @override
  String get settingsSendTestNotification => 'Skicka testavisering';

  @override
  String get settingsAppIconBadge => 'Aviseringsbricka på appikonen';

  @override
  String get settingsBadgeNote => 'Brickan uppdateras varje gång Loupe söker efter e-post, även i bakgrunden.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Den här telefonens hemskärm visar inte siffror på appikoner. Brickan uppdateras varje gång Loupe söker efter e-post, även i bakgrunden.';

  @override
  String get settingsTestNotificationBody => 'Aviseringar om ny e-post ser ut så här.';

  @override
  String get settingsAccountRemoved => 'Det här kontot har tagits bort.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Beskrivning';

  @override
  String get settingsAccountDescriptionHint => 'Jobb, privat…';

  @override
  String get settingsEmail => 'E-post';

  @override
  String get settingsColour => 'Färg';

  @override
  String get settingsColourFooter => 'Markerar kontots meddelanden i Alla inkorgar.';

  @override
  String settingsColourNumber(int number) {
    return 'Färg $number';
  }

  @override
  String get settingsSendingHeader => 'Sändning';

  @override
  String get settingsSendingFooter =>
      'Varje identitet har sin egen signatur. Svar skickas från adressen som meddelandet skickades till.';

  @override
  String get settingsFoldersHeader => 'Mappar';

  @override
  String get settingsFoldersFooter =>
      'Loupe visar och synkroniserar mapparna du prenumererar på, precis som Thunderbird. Inkorg, Utkast, Skickat, Skräppost, Papperskorg och Arkiv visas alltid.';

  @override
  String get settingsShowAllFolders => 'Visa alla mappar';

  @override
  String get settingsIncoming => 'Inkommande';

  @override
  String get settingsOutgoing => 'Utgående';

  @override
  String get settingsConnectionNotEncrypted => 'Inte krypterad';

  @override
  String get settingsSignIn => 'Inloggning';

  @override
  String get settingsSignInExpired => 'Har upphört';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider godtar inte längre Loupes inloggning för det här kontot, så dess e-post synkroniseras inte. Logga in igen för att åtgärda det.';
  }

  @override
  String get settingsSignInAgain => 'Logga in igen';

  @override
  String get settingsSigningIn => 'Loggar in…';

  @override
  String get settingsRemoveAccount => 'Ta bort konto';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Vill du ta bort ”$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Dess e-post och inställningar tas bort från den här telefonen. Inget raderas på servern.';

  @override
  String get settingsManageFolders => 'Hantera mappar';

  @override
  String get settingsNoFolders => 'Inga mappar än.';

  @override
  String get settingsManageFoldersFooter =>
      'Mappar du prenumererar på visas på skärmen Brevlådor och synkroniseras i bakgrunden. Andra e-postappar med samma konto följer oftast också dessa prenumerationer.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Sparar dina Smart Mailboxes för dina andra enheter. Dold på skärmen Brevlådor.';

  @override
  String get settingsFolderAlwaysShown => 'Visas alltid';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Prenumerera på $folder';
  }

  @override
  String get settingsIdentities => 'Identiteter';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Den första identiteten är standard för nya meddelanden. Dra för att ändra ordningen.';

  @override
  String get settingsIdentitiesFooterSingle => 'Standardidentiteten för nya meddelanden.';

  @override
  String get settingsIdentitiesReplyFooter => 'Ett svar skickas från identiteten som meddelandet skickades till.';

  @override
  String get settingsIdentityDefault => 'Standard';

  @override
  String settingsIdentityReorder(String email) {
    return 'Flytta $email';
  }

  @override
  String get settingsAddIdentity => 'Lägg till identitet';

  @override
  String get settingsNewIdentity => 'Ny identitet';

  @override
  String get settingsIdentity => 'Identitet';

  @override
  String get settingsIdentityNameHint => 'Ditt namn';

  @override
  String get settingsReplyTo => 'Svara till';

  @override
  String get settingsSignature => 'Signatur';

  @override
  String get settingsSignatureFooter => 'Läggs till under ”-- ” i meddelanden från den här identiteten.';

  @override
  String get settingsNoSignature => 'Ingen signatur';

  @override
  String get settingsCopyToMyself => 'Kopia till mig själv';

  @override
  String get settingsCopyToMyselfFooter => 'Läggs till i alla meddelanden från den här identiteten.';

  @override
  String get settingsCc => 'Kopia';

  @override
  String get settingsBcc => 'Dold kopia';

  @override
  String get settingsReplyPatterns => 'Använd för svar till';

  @override
  String get settingsReplyPatternsFooter =>
      'Svar på meddelanden som skickats till dessa adresser skickas från den här identiteten. * står för vad som helst: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'En adress eller ett mönster där * står för vad som helst.';

  @override
  String get settingsAddReplyPattern => 'Lägg till adress eller mönster';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Ta bort $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ogiltigt mönster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '”$input” är varken en adress eller ett mönster som *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ingen adress';

  @override
  String get settingsIdentityNoAddressMessage => 'Ange e-postadressen som du vill skicka från.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ogiltig adress';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Svara till ”$address” är ingen giltig e-postadress.',
      'cc': 'Kopia ”$address” är ingen giltig e-postadress.',
      'bcc': 'Dold kopia ”$address” är ingen giltig e-postadress.',
      'other': '”$address” är ingen giltig e-postadress.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Spara identitet';

  @override
  String get settingsDiscardChanges => 'Ignorera ändringar';

  @override
  String get settingsDeleteIdentity => 'Radera identitet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Vill du radera ”$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Meddelanden som redan skickats från den förblir som de är.';

  @override
  String get settingsLastIdentityFooter => 'Ett konto måste ha minst en identitet.';

  @override
  String get rulesTitle => 'Regler';

  @override
  String get rulesNewRule => 'Ny regel';

  @override
  String get rulesLoadError => 'Det gick inte att läsa in reglerna.';

  @override
  String get rulesEmptyTitle => 'Inga regler';

  @override
  String get rulesEmptyText =>
      'Regler sorterar, taggar och flaggar ny e-post åt dig. Skapa en med skrivknappen ovan eller från en sökning med ”Gör detta till en regel”.';

  @override
  String get rulesListFooter =>
      'Regler körs uppifrån och ned på ny e-post i inkorgen. Tryck länge på en regel för att flytta den.';

  @override
  String get rulesChangeError => 'Det gick inte att ändra regeln';

  @override
  String get rulesConditionEveryMessage => 'Alla meddelanden';

  @override
  String rulesMoveRule(String rule) {
    return 'Flytta $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule på';
  }

  @override
  String get rulesServerRulesHeader => 'Serverregler';

  @override
  String get rulesServerRulesFooter =>
      'Serverregler körs på e-postservern när e-posten kommer in, även när telefonen är avstängd. De sparas i ett Sieve-skript med namnet ”loupe”.';

  @override
  String get rulesStatusUnknown => 'Okänd';

  @override
  String get rulesStatusError => 'Det gick inte att fråga servern.';

  @override
  String get rulesStatusChecking => 'Kontrollerar…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Körs från ”$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '”$script” är det aktiva skriptet. Tryck för att låta det köra Loupes regler också.';
  }

  @override
  String get rulesStatusNoScript => 'Inget skript är aktivt på servern. När du sparar en serverregel aktiveras Loupes.';

  @override
  String get rulesStatusUnavailable => 'Inte tillgänglig';

  @override
  String get rulesStatusNoSieve => 'Det här kontots server erbjuder inte Sieve (ManageSieve eller JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Flytta till $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Flytta till en mapp';

  @override
  String rulesActionTag(String tag) {
    return 'Tagga $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Ta bort taggen $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Behåll i inkorgen';

  @override
  String rulesActionForward(String address) {
    return 'Vidarebefordra till $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Vidarebefordra till $address, behåll ingen kopia';
  }

  @override
  String get rulesActionStop => 'Stoppa';

  @override
  String get rulesNoActions => 'Gör inget än';

  @override
  String get rulesLocationDevice => 'Enhet';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Den här enheten';

  @override
  String get rulesNewRuleTitle => 'Ny regel';

  @override
  String get rulesEditRuleTitle => 'Redigera regel';

  @override
  String get rulesDefaultNameEveryMessage => 'Alla meddelanden';

  @override
  String get rulesConditionHeader => 'När ett nytt meddelande matchar';

  @override
  String get rulesConditionFooter =>
      'Skriv det som när du söker: from:, to:, s: (ämne), b: (brödtext), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Konton';

  @override
  String get rulesAllAccounts => 'Alla konton';

  @override
  String get rulesRemovedAccount => 'Borttaget konto';

  @override
  String get rulesAccountsFooter => 'En regel för alla konton gäller även konton som du lägger till senare.';

  @override
  String get rulesActionsHeader => 'Då';

  @override
  String get rulesForwardingFooter =>
      'Vidarebefordran skickar alla matchande meddelanden till en annan adress när de kommer in, även när telefonen är avstängd. Vissa leverantörer begränsar hur mycket e-post som får vidarebefordras.';

  @override
  String get rulesForwardingHiddenFooter => 'Vidarebefordran körs bara i serverregler, så den är utelämnad här.';

  @override
  String rulesRemoveAction(String action) {
    return 'Ta bort $action';
  }

  @override
  String get rulesAddAction => 'Lägg till åtgärd';

  @override
  String get rulesAddMove => 'Flytta till mapp…';

  @override
  String get rulesAddTagMenu => 'Lägg till tagg…';

  @override
  String get rulesRemoveTagMenu => 'Ta bort tagg…';

  @override
  String get rulesAddForward => 'Vidarebefordra till…';

  @override
  String get rulesStopProcessing => 'Sluta behandla fler regler';

  @override
  String get rulesRunOnHeader => 'Kör på';

  @override
  String get rulesRunOnDeviceFooter =>
      'Den här enheten kör regeln på ny e-post i inkorgen varje gång Loupe söker efter e-post.';

  @override
  String get rulesRunOnServerFooter =>
      'E-postservern kör regeln när e-posten kommer in, även när telefonen är avstängd. Kräver Sieve via ManageSieve (Dovecot, mailcow) eller JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Tillämpa på befintliga meddelanden…';

  @override
  String get rulesDeleteRule => 'Radera regel';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Vill du radera ”$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mapp i vilket konto?';

  @override
  String get rulesMoveAccountMessage => 'E-post från de andra kontona hamnar i mappen med samma namn där.';

  @override
  String get rulesAddTag => 'Lägg till tagg';

  @override
  String get rulesRemoveTag => 'Ta bort tagg';

  @override
  String get rulesForwardTo => 'Vidarebefordra till';

  @override
  String get rulesForwardToMessage =>
      'Servern skickar alla matchande meddelanden vidare till den här adressen, även när telefonen är avstängd. Använd en adress som du äger eller litar på.';

  @override
  String get rulesNotAnAddressTitle => 'Ingen e-postadress';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '”$address” är ingen adress att vidarebefordra till.';
  }

  @override
  String get rulesKeepCopyTitle => 'Vill du behålla en kopia här?';

  @override
  String get rulesKeepCopy => 'Behåll en kopia';

  @override
  String get rulesDontKeepCopy => 'Behåll ingen kopia';

  @override
  String get rulesCheckCondition => 'Kontrollera villkoret';

  @override
  String get rulesChooseActionTitle => 'Välj en åtgärd';

  @override
  String get rulesChooseActionMessage => 'Lägg till vad regeln gör med meddelandena den matchar.';

  @override
  String get rulesSaveError => 'Det gick inte att spara regeln';

  @override
  String get rulesSaveServerError => 'Det gick inte att spara serverregeln';

  @override
  String get rulesRunOnDeviceInstead => 'Kör på den här enheten i stället';

  @override
  String get rulesNothingToApplyTitle => 'Inget att tillämpa';

  @override
  String get rulesNothingToApplyMessage => 'Ge först regeln ett villkor som fungerar och en åtgärd.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Tillämpa ”$rule” på meddelanden i…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inkorgar';

  @override
  String get rulesApplyScopeAll => 'Alla brevlådor';

  @override
  String get rulesFindingMessages => 'Söker efter meddelanden…';

  @override
  String get rulesSearchError => 'Det gick inte att söka';

  @override
  String get rulesSearchErrorUnknown => 'Något gick fel.';

  @override
  String get rulesNoMatchesTitle => 'Inga meddelanden matchar';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Inget där matchar ”$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vill du tillämpa ”$rule” på $countString meddelanden?',
      one: 'Vill du tillämpa ”$rule” på $countString meddelande?',
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
      other: 'Tillämpa på $countString meddelanden',
      one: 'Tillämpa på $countString meddelande',
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
      other: '”$rule” har tillämpats på $countString meddelanden',
      one: '”$rule” har tillämpats på $countString meddelande',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Frågar servern vad den kan göra…';

  @override
  String get rulesServerUnreachable => 'Det gick inte att nå servern.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kan inte köras på servern: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kan inte köras på servern för $account: $problem';
  }

  @override
  String get rulesShowScript => 'Visa skript';

  @override
  String get rulesHideScript => 'Dölj skript';

  @override
  String get rulesMatchingHeader => 'Matchande meddelanden';

  @override
  String get rulesMatchingHeaderLoading => 'Matchande meddelanden…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString matchande meddelanden',
      one: '$countString matchande meddelande',
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
      other: '$countString+ matchande meddelanden',
      one: '$countString+ matchande meddelande',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Från de senaste 30 dagarna. Själva regeln påverkar bara ny e-post, om du inte tillämpar den på befintliga meddelanden.';

  @override
  String rulesConditionError(String error) {
    return 'Villkoret innehåller ett fel: $error';
  }

  @override
  String get rulesPreviewNoSender => '(ingen avsändare)';

  @override
  String get rulesPreviewNoSubject => '(inget ämne)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'och $countString till');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Inget från de senaste 30 dagarna.';

  @override
  String get rulesIncludeTitle => 'Slå på serverregler';

  @override
  String get rulesIncludeLeaveOff => 'Låt vara avstängt';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Servern kör redan Loupes regler för $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '”$script” är det aktiva skriptet på servern för $account, så servern kör det och inte Loupes regler. Loupe ersätter det inte. Loupe kan lägga till de här raderna i det, och då kör servern Loupes regler efter skriptets egna:';
  }

  @override
  String get rulesShowWholeScript => 'Visa hela skriptet';

  @override
  String get rulesHideWholeScript => 'Dölj hela skriptet';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Inget annat i ”$script” ändras. Om dess filter redigeras i webbmejlen senare kan webbmejlen skriva om det utan de här raderna; Loupe visar då serverregler som avstängda igen.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Lägg till i ”$script”';
  }

  @override
  String get subscriptionsTitle => 'Prenumerationer';

  @override
  String get subscriptionsNewsletters => 'Nyhetsbrev';

  @override
  String get subscriptionsDiscussions => 'Diskussioner';

  @override
  String get subscriptionsFilter => 'Filtrera';

  @override
  String get subscriptionsFilterNeverRead => 'Aldrig lästa';

  @override
  String get subscriptionsFilterRarelyRead => 'Sällan lästa';

  @override
  String get subscriptionsFilterAll => 'Alla';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Det gick inte att räkna prenumerationer';

  @override
  String get subscriptionsNoMatches => 'Inga träffar';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Inget nyhetsbrev heter ”$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ingen lista heter ”$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Inga nyhetsbrev';

  @override
  String get subscriptionsNoNewslettersDetail => 'Nyhetsbrev och andra massutskick visas här när de kommer in.';

  @override
  String get subscriptionsNothingNeverRead => 'Inget som aldrig läses';

  @override
  String get subscriptionsNothingRarelyRead => 'Inget som sällan läses';

  @override
  String get subscriptionsNothingFilteredDetail => 'Du läser något av allt du får.';

  @override
  String get subscriptionsNoDiscussions => 'Inga diskussioner';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'E-postlistor som du kan skriva till visas här när deras e-post kommer in.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listor som flera personer skriver till. Tryck länge på en för att fästa den i Brevlådor, läsa den som ren text eller flytta den till Nyhetsbrev.';

  @override
  String get subscriptionsPrivacyNote =>
      'Räknat i den här telefonen utifrån den e-post som laddats ned; inget skickas någonstans för att ta reda på det. Loupe kontaktar en avsändare bara när du trycker på Avregistrera: avregistrering med ett klick skickar bara ”List-Unsubscribe=One-Click” till adressen som avsändaren angett, utan cookies eller något annat om dig, och läser aldrig in deras sidor eller bilder.';

  @override
  String get subscriptionsVolumeNone => 'Inga på sistone';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / månad';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / månad';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'läst $percent';
  }

  @override
  String get subscriptionsStillSending => 'Skickar fortfarande';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Avregistrerad $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Avregistreringssidan öppnades $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ett tryck · kontaktar $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Via e-post till $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'På webbplatsen $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Avregistrera';

  @override
  String get subscriptionsUnsubscribeAgain => 'Avregistrera igen';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arkivera $countString i inkorgen');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Skapa regel…';

  @override
  String get subscriptionsCreateRuleDetail => 'Flytta eller arkivera framtida e-post från avsändaren';

  @override
  String get subscriptionsTreatAsDiscussion => 'Behandla som diskussion';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'En lista som folk skriver till: läs den som ett forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Behandla som nyhetsbrev';

  @override
  String get subscriptionsBlockSender => 'Blockera avsändare';

  @override
  String get subscriptionsBlock => 'Blockera';

  @override
  String get subscriptionsBlocked => 'Blockerad';

  @override
  String get subscriptionsBlockedDetail => 'Ny e-post hamnar i Skräppost';

  @override
  String get subscriptionsPin => 'Fäst i Brevlådor';

  @override
  String get subscriptionsUnpin => 'Lossa från Brevlådor';

  @override
  String get subscriptionsOpenDefaultView => 'Öppna i standardvy';

  @override
  String get subscriptionsOpenPlainText => 'Öppna som ren text (Mono)';

  @override
  String get subscriptionsPinned => 'Fäst';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString olästa',
      one: '$countString oläst',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Ingen e-post från den här avsändaren just nu.';

  @override
  String get subscriptionsLatestMessages => 'SENASTE MEDDELANDENA';

  @override
  String get subscriptionsMail => 'E-post';

  @override
  String get subscriptionsNoneIn90Days => 'Inga på 90 dagar';

  @override
  String get subscriptionsRead => 'Läst';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString av $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Senast mottaget';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Mappar', one: 'Mapp');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Skickar fortfarande';

  @override
  String get subscriptionsUnsubscribedTitle => 'Avregistrerad';

  @override
  String subscriptionsSince(String date) {
    return 'sedan $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'sidan öppnades $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender anger inte hur man avregistrerar sig.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender anger inte hur man avregistrerar sig. Du kan blockera avsändaren i stället.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Avregistrerar från $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Avregistrerad från $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Det gick inte att avregistrera: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Det gick inte att avregistrera automatiskt';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Skicka avregistreringsmejl';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Öppna $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Vill du öppna $site?';
  }

  @override
  String get subscriptionsOpen => 'Öppna';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender sköter avregistrering på sin webbplats. Sidan öppnas i Loupes webbläsare; slutför där.';
  }

  @override
  String get subscriptionsWebInsecure => 'Anslutningen till den här webbplatsen är inte krypterad.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Se upp: den här adressen efterliknar $site med förväxlingsbara bokstäver.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Se upp: den här adressen efterliknar en annan webbplats med förväxlingsbara bokstäver.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Det gick inte att öppna $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe noterar dagens datum och säger till om $sender fortsätter att skriva.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vill du avregistrera dig från $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontaktar $site för att avregistrera dig.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Det är det enda tillfället då Loupe kontaktar en avsändares webbplats. Den skickar bara ”List-Unsubscribe=One-Click” till adressen som $sender har angett, utan cookies eller något annat om dig, och läser inte in sidan.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Avregistreringslänken är ingen säker adress på internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site svarade inte i tid.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Det gick inte att nå $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site skickade vidare begäran till en annan sida, som Loupe inte följer.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site avvisade begäran (fel $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Det finns inget konto att skicka avregistreringsmejlet från.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe skickar ett mejl till $to från $from med ämnet ”$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Avregistreringsmejl skickat till $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Vill du blockera $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Ny e-post från den här listan hamnar i Skräppost. Du kan ändra det under Inställningar › Regler.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Ny e-post från $address hamnar i Skräppost. Du kan ändra det under Inställningar › Regler.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender har blockerats.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Flytta $count till Skräppost');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blockera $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender finns nu under Nyhetsbrev.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender finns nu under Diskussioner.';
  }

  @override
  String get appLiveGateTitle => 'Det gick inte att öppna dina konton';

  @override
  String get appLiveGateUnavailableBuild => 'Riktiga konton är inte tillgängliga i det här bygget än.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe kunde inte läsa nyckeln som skyddar din e-post i den här telefonen. Det är ofta tillfälligt: försök igen eller starta om telefonen.';

  @override
  String get appLiveGateKeyMissing =>
      'Nyckeln som skyddar din e-post i den här telefonen är borta, vilket kan hända efter att en säkerhetskopia har återställts. Din e-post finns kvar på servern.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'E-postdatabasen i den här telefonen kan inte läsas: den är skadad eller så har dess nyckel ändrats. Din e-post finns kvar på servern.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Något gick fel när dina konton skulle öppnas ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Detta raderar dina konton och e-posten som är sparad i den här telefonen, även meddelanden som väntar i utkorgen. E-post på dina servrar påverkas inte; lägg till dina konton igen efteråt.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Radera och börja om';

  @override
  String get appLiveGateUseDemo => 'Använd demo-e-post';

  @override
  String get appLiveGateReset => 'Återställ e-post i den här telefonen…';

  @override
  String get attachmentsUntitled => 'Bilaga';

  @override
  String get attachmentsUntitledFile => 'Namnlös';

  @override
  String get attachmentsOpenIn => 'Öppna i…';

  @override
  String get attachmentsSaveToFiles => 'Spara i filer';

  @override
  String get attachmentsShareMenu => 'Dela…';

  @override
  String get attachmentsDownloadError =>
      'Det gick inte att ladda ned bilagan. Kontrollera anslutningen och försök igen.';

  @override
  String get attachmentsShareError => 'Det gick inte att dela bilagan.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ingen app på den här enheten kan öppna filen ($type). Prova att dela den i stället.';
  }

  @override
  String get attachmentsOpenInError => 'Det gick inte att öppna bilagan i en annan app.';

  @override
  String attachmentsSaved(String name) {
    return '”$name” har sparats';
  }

  @override
  String get attachmentsSaveError => 'Det gick inte att spara bilagan.';

  @override
  String get attachmentsGone => 'Den här bilagan är inte längre tillgänglig.';

  @override
  String get attachmentsDownloadFailed => 'Det gick inte att ladda ned bilagan.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sidor', one: '1 sida');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size via mobildata';
  }

  @override
  String get attachmentsLargeDownload => 'Den här bilagan är stor. Ladda ned den nu eller senare via wifi.';

  @override
  String get attachmentsDownload => 'Ladda ned';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Laddar ned $size…';
  }

  @override
  String get attachmentsDownloading => 'Laddar ned…';

  @override
  String get attachmentsTooLarge => 'För stor för att förhandsvisas här.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Visar de första $shown av $total. Kopiera, dela eller spara för att få allt.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Den här PDF-filen kan inte visas här (den kanske är lösenordsskyddad).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page av $count';
  }

  @override
  String get attachmentsModeTable => 'Tabell';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Meddelande';

  @override
  String get attachmentsModeSource => 'Källkod';

  @override
  String get attachmentsDontWrap => 'Radbryt inte';

  @override
  String get attachmentsWrap => 'Radbryt';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines rader', one: '$lines rad');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiera allt';

  @override
  String get attachmentsCopied => 'Kopierat';

  @override
  String get attachmentsImageUnavailable => 'Bilden kan inte visas här. Prova ”Öppna i…”.';

  @override
  String get attachmentsEmlNoSubject => '(Inget ämne)';

  @override
  String get attachmentsEmlFrom => 'Från';

  @override
  String get attachmentsEmlTo => 'Till';

  @override
  String get attachmentsEmlCc => 'Kopia';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Det här meddelandet har ingen text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Bilagor: $names', one: 'Bilaga: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organisatör: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Och $count händelser till',
      one: 'Och 1 händelse till',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Bild';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-bild';
  }

  @override
  String get attachmentsTypePdf => 'PDF-dokument';

  @override
  String get attachmentsTypeTsv => 'Tabbavgränsade värden';

  @override
  String get attachmentsTypeCsv => 'CSV-kalkylblad';

  @override
  String get attachmentsTypeCalendar => 'Kalenderhändelse';

  @override
  String get attachmentsTypeEmail => 'E-postmeddelande';

  @override
  String get attachmentsTypeContact => 'Kontaktkort';

  @override
  String get attachmentsTypeLog => 'Loggfil';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'ZIP-arkiv';

  @override
  String get attachmentsTypeArchive => 'Arkiv';

  @override
  String get attachmentsTypeWord => 'Word-dokument';

  @override
  String get attachmentsTypeExcel => 'Excel-kalkylblad';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-presentation';

  @override
  String get attachmentsTypeWebPage => 'Webbsida';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Ljud';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-fil';
  }

  @override
  String get attachmentsTypeFile => 'Fil';

  @override
  String get calendarUntitledEvent => 'Händelse';

  @override
  String get calendarAllDay => 'Heldag';

  @override
  String calendarYourTime(String time) {
    return '$time din tid';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Anslut: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har tackat ja: $details',
      'tentative': '$name har preliminärt tackat ja: $details',
      'declined': '$name har tackat nej: $details',
      'delegated': '$name har delegerat: $details',
      'other': '$name har inte svarat på: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har tackat ja till inbjudan',
      'tentative': '$name har preliminärt tackat ja till inbjudan',
      'declined': '$name har tackat nej till inbjudan',
      'delegated': '$name har delegerat inbjudan',
      'other': '$name har inte svarat på inbjudan',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Karta';

  @override
  String get calendarJoin => 'Anslut';

  @override
  String get calendarOnlineMeeting => 'Onlinemöte';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-möte';
  }

  @override
  String get calendarOrganizerYou => 'Du';

  @override
  String get calendarOrganizerLabel => 'organisatör';

  @override
  String get calendarStatusAccepted => 'Tackat ja';

  @override
  String get calendarStatusMaybe => 'Kanske';

  @override
  String get calendarStatusDeclined => 'Tackat nej';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har tackat ja',
      'tentative': '$name har preliminärt tackat ja',
      'declined': '$name har tackat nej',
      'delegated': '$name har delegerat',
      'other': '$name har inte svarat',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name har tackat ja:',
      'tentative': '$name har preliminärt tackat ja:',
      'declined': '$name har tackat nej:',
      'delegated': '$name har delegerat:',
      'other': '$name har inte svarat:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '”$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name föreslår en ny tid';
  }

  @override
  String get calendarCounterUnknown => 'En deltagare föreslår en ny tid';

  @override
  String get calendarDeclineCounter => 'Organisatören behöll tiden';

  @override
  String calendarRefresh(String name) {
    return '$name ber om den senaste versionen';
  }

  @override
  String get calendarRefreshUnknown => 'En deltagare ber om den senaste versionen';

  @override
  String get calendarCancelled => 'Inställd';

  @override
  String get calendarCancelledByOrganizer => 'Organisatören har ställt in händelsen.';

  @override
  String get calendarCancelledLater => 'Händelsen ställdes in senare.';

  @override
  String get calendarOutdated => 'Inaktuell';

  @override
  String get calendarOutdatedDetail => 'Inbjudan uppdaterades senare; den nyare gäller.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Plats borttagen (var $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Plats borttagen (var ingen)';

  @override
  String calendarLocationChanged(String location) {
    return 'Plats ändrad till $location';
  }

  @override
  String get calendarNewTitle => 'Ny titel';

  @override
  String get calendarRepeatChanged => 'Upprepningen har ändrats';

  @override
  String get calendarUpdated => 'Uppdaterad';

  @override
  String get calendarUpdatedInvitation => 'Uppdaterad inbjudan';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Tiden ändrad från $before till $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Tidszonen ”$zone” är okänd: tider som de skrevs';
  }

  @override
  String calendarNext(String when) {
    return 'Nästa: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gäster', one: '1 gäst');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ja');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kanske');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count nej');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (du)';
  }

  @override
  String get calendarAttendeeOptional => 'valfri';

  @override
  String get calendarAttendeeRoom => 'rum';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Du tackade ja till en tidigare version.',
      'tentative': 'Du tackade preliminärt ja till en tidigare version.',
      'declined': 'Du tackade nej till en tidigare version.',
      'delegated': 'Du delegerade en tidigare version.',
      'other': 'Du svarade inte på en tidigare version.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Tacka ja';

  @override
  String get calendarMaybe => 'Kanske';

  @override
  String get calendarDecline => 'Tacka nej';

  @override
  String get calendarCommentHint => 'Kommentar till organisatören (valfritt)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Ditt svar går till $organizer från $address.';
  }

  @override
  String get calendarAddComment => 'Lägg till en kommentar';

  @override
  String get calendarAddToCalendar => 'Lägg till i kalendern';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Och $count händelser till i filen',
      one: 'Och 1 händelse till i filen',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Det finns ingen kalenderapp att lägga till händelsen i.';

  @override
  String get calendarCantOpenCalendar => 'Det gick inte att öppna kalendern.';

  @override
  String get calendarCantOpenLink => 'Det gick inte att öppna länken.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Vill du ansluta till $provider-mötet?';
  }

  @override
  String get calendarJoinTitle => 'Vill du ansluta till mötet?';

  @override
  String calendarJoinOpens(String host) {
    return 'Öppnar $host i din webbläsare.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Se upp: den här adressen efterliknar $site med förväxlingsbara bokstäver.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Se upp: den här adressen efterliknar en annan webbplats med förväxlingsbara bokstäver.';

  @override
  String calendarJoinOpen(String host) {
    return 'Öppna $host';
  }

  @override
  String get calendarNoOrganizer => 'Inbjudan har ingen organisatör att svara till.';

  @override
  String get calendarNoAccount => 'Det finns inget konto att svara från.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Tackat ja',
      'tentative': 'Kanske',
      'other': 'Tackat nej',
    });
    return '$_temp0 · skickar svar till $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Tackat ja',
      'tentative': 'Kanske',
      'other': 'Tackat nej',
    });
    return '$_temp0 · svar skickat';
  }

  @override
  String get calendarReplyAlreadySent => 'Svaret har redan skickats.';

  @override
  String get calendarReplyNotSent => 'Svaret skickades inte.';

  @override
  String get dataSmimeNeedsDevice =>
      'Ditt S/MIME-certifikat finns på den här enheten: öppna Loupe för att signera och skicka meddelandet.';

  @override
  String dataSigningFailed(String error) {
    return 'Signeringen misslyckades: $error';
  }

  @override
  String get keyboardShortcuts => 'Kortkommandon';

  @override
  String get keyboardGroupGeneral => 'Allmänt';

  @override
  String get keyboardGroupMessages => 'Meddelanden';

  @override
  String get keyboardGroupCompose => 'Skriv';

  @override
  String get keyboardCommandPalette => 'Kommandopalett';

  @override
  String get keyboardBackClose => 'Tillbaka, stäng';

  @override
  String get keyboardNextMessage => 'Nästa meddelande';

  @override
  String get keyboardPreviousMessage => 'Föregående meddelande';

  @override
  String get keyboardOpenMessage => 'Öppna meddelande';

  @override
  String get keyboardMoveToTrash => 'Flytta till papperskorgen';

  @override
  String get keyboardToggleRead => 'Markera som läst eller oläst';

  @override
  String get keyboardToggleFlag => 'Flagga eller ta bort flagga';

  @override
  String get keyboardCloseDraft => 'Stäng (spara eller radera utkast)';

  @override
  String get keyboardOr => 'eller';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Skift';

  @override
  String get keyboardKeyEnter => 'Retur';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyBackspace => 'Backsteg';

  @override
  String get mailingListsMuted => 'Tråden är tystad. Nya meddelanden i den kommer som lästa.';

  @override
  String get mailingListsUnmuted => 'Tråden är inte längre tystad.';

  @override
  String get mailingListsMuteThread => 'Tysta tråden';

  @override
  String get mailingListsUnmuteThread => 'Sluta tysta tråden';

  @override
  String get mailingListsPin => 'Fäst i Brevlådor';

  @override
  String get mailingListsUnpin => 'Lossa från Brevlådor';

  @override
  String get mailingListsDefaultView => 'Öppna i standardvy';

  @override
  String get mailingListsPlainText => 'Öppna som ren text (Mono)';

  @override
  String get mailingListsShowMuted => 'Visa tystade trådar';

  @override
  String get mailingListsHideMuted => 'Dölj tystade trådar';

  @override
  String get mailingListsTreatAsNewsletter => 'Behandla som nyhetsbrev';

  @override
  String get mailingListsOptions => 'Listalternativ';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted olästa',
      one: '$formatted oläst',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nytt meddelande till listan';

  @override
  String get mailingListsRowUnread => 'Oläst';

  @override
  String get mailingListsRowMuted => 'Tystad';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count svar', one: '1 svar');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Inga trådar';

  @override
  String get mailingListsMutedHidden => 'Tystade trådar är dolda.';

  @override
  String get mailingListsTechnicalTitle => 'Tekniska listor';

  @override
  String get mailingListsTechnicalEmpty => 'E-postlistor visas här när deras e-post kommer in.';

  @override
  String get mailingListsTechnicalFooter =>
      'Meddelanden från dessa listor öppnas som ren text i ett typsnitt med fast bredd, med patchar visade som diffar. Aa-knappen kan fortfarande byta vy för valfritt meddelande.';

  @override
  String get paletteMoveToMailbox => 'Flytta till brevlåda…';

  @override
  String get paletteMarkAllRead => 'Markera alla som lästa';

  @override
  String get paletteExportFolder => 'Exportera mapp…';

  @override
  String get paletteGetNewMail => 'Hämta ny e-post';

  @override
  String get paletteSnoozed => 'Snoozade';

  @override
  String get paletteSubscriptions => 'Prenumerationer';

  @override
  String get paletteDiscussions => 'Diskussioner';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-postlista';

  @override
  String get paletteTag => 'Tagg';

  @override
  String get paletteSwipeActions => 'Svephandlingar';

  @override
  String get paletteNotifications => 'Aviseringar';

  @override
  String get paletteRules => 'Regler';

  @override
  String get paletteEncryption => 'End-to-end-kryptering';

  @override
  String get paletteAdvanced => 'Avancerat';

  @override
  String get paletteAddAccount => 'Lägg till konto';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Mappar';

  @override
  String get paletteRecentSearch => 'Senaste sökning';

  @override
  String paletteSearchMail(String query) {
    return 'Sök i e-post efter ”$query”';
  }

  @override
  String get palettePlaceholder => 'Sök efter åtgärder, brevlådor, inställningar';

  @override
  String get paletteNothingFound => 'Inget hittades';

  @override
  String get searchNewSmartMailbox => 'Ny Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Visar allt som matchar ”$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '”$name” har sparats i Brevlådor';
  }

  @override
  String get searchMakeRule => 'Gör detta till en regel';

  @override
  String get searchSaveSmartMailbox => 'Spara som Smart Mailbox';

  @override
  String get searchNegate => 'Exkludera';

  @override
  String get searchDontNegate => 'Inkludera';

  @override
  String get searchAllMailboxes => 'Alla brevlådor';

  @override
  String get searchRecent => 'Senaste sökningar';

  @override
  String get searchClear => 'Rensa';

  @override
  String get searchSuggestions => 'Förslag';

  @override
  String get searchUnreadMessages => 'Olästa meddelanden';

  @override
  String get searchFlaggedMessages => 'Flaggade meddelanden';

  @override
  String get searchWithAttachments => 'Meddelanden med bilagor';

  @override
  String get searchUnrepliedMessages => 'Obesvarade meddelanden';

  @override
  String get searchTags => 'Taggar';

  @override
  String get searchPeople => 'Personer';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Från: $name';
  }

  @override
  String get searchSearching => 'Söker…';

  @override
  String get searchNoResults => 'Inga träffar';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted träffar',
      one: '$formatted träff',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Sökmeny';

  @override
  String searchSearchingAccount(String account) {
    return 'Söker i $account på servern…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Söker i konto på servern…';

  @override
  String searchAccountFailed(String account) {
    return 'Det gick inte att söka i $account på servern';
  }

  @override
  String get searchUnknownAccountFailed => 'Det gick inte att söka i kontot på servern';

  @override
  String searchChip(String term) {
    return '$term. Dubbeltryck för att redigera.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Inte $term. Dubbeltryck för att redigera.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingers inkorg: varje meddelande här är både läst och oläst tills du öppnar det.';

  @override
  String searchContradiction(String term) {
    return 'Inget meddelande kan både vara ”$term” och inte vara det.';
  }

  @override
  String get searchSyncDeviceOnly => 'Bara på den här enheten';

  @override
  String searchSyncUnsupported(String account) {
    return 'Bara på den här enheten: $account kan inte spara den';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Inte synkroniserad: $account har ett nyare format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Väntar på att synkroniseras till $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synkroniserad till $account';
  }

  @override
  String get searchRename => 'Byt namn';

  @override
  String get searchEditSearch => 'Redigera sökning';

  @override
  String get searchDeleteSmartMailbox => 'Radera Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Byt namn på Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Den här Smart Mailbox har raderats.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes stannar på den här enheten.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes sparas på din e-postserver, så att dina andra enheter också har dem, och likaså Thunderbird med Expression Search Reloaded. De som söker i alla konton sparas på $account; de för en enskild mapp på den mappens konto.';
  }

  @override
  String get searchSyncVia => 'Synkronisera via';

  @override
  String get searchSyncViaFooter => 'Välj samma konto på alla enheter.';

  @override
  String get searchGmailCantKeep => 'Gmail kan inte spara Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Spara Smart Mailboxes bara på den här enheten';

  @override
  String get searchOnTheServer => 'På servern';

  @override
  String get searchServerFooter =>
      'Servermetadata (IMAP METADATA) visas inte i någon e-postapp. Servrar utan det får en mapp, ”Loupe Settings”, med ett meddelande; Loupe döljer den i Brevlådor.';

  @override
  String get searchSyncNow => 'Synkronisera nu';

  @override
  String get searchStateUnsupported => 'Stöds inte';

  @override
  String get searchStateNewerFormat => 'Nyare format';

  @override
  String get searchStateFailed => 'Det gick inte att synkronisera';

  @override
  String get searchStateSyncing => 'Synkroniserar…';

  @override
  String get searchStateWaiting => 'Väntar';

  @override
  String get searchStateMetadata => 'Servermetadata';

  @override
  String get searchStateFolder => 'Mappen Loupe Settings';

  @override
  String get searchStateNothing => 'Inget sparat';

  @override
  String get sharedBack => 'Tillbaka';

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
  String get sharedSyncNoAccounts => 'Inga konton';

  @override
  String get sharedSyncChecking => 'Söker efter e-post…';

  @override
  String get sharedSyncFailed => 'Det gick inte att söka efter e-post';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Uppdaterad nyss';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Uppdaterad för $minutes minuter sedan',
      one: 'Uppdaterad för 1 minut sedan',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Uppdaterad kl. $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Uppdaterad $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Alla inkorgar';

  @override
  String get sharedMailboxUnread => 'Olästa';

  @override
  String get sharedMailboxFlagged => 'Flaggade';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Alla utkast';

  @override
  String get sharedMailboxAllSent => 'Alla skickade';

  @override
  String get sharedMailboxUntitled => 'Brevlåda';

  @override
  String get sharedTagImportant => 'Viktigt';

  @override
  String get sharedTagWork => 'Arbete';

  @override
  String get sharedTagPersonal => 'Personligt';

  @override
  String get sharedTagToDo => 'Att göra';

  @override
  String get sharedTagLater => 'Senare';

  @override
  String get sharedTags => 'Taggar';

  @override
  String get sharedMoveTo => 'Flytta till…';

  @override
  String get sharedNoRecipients => 'Inga mottagare';

  @override
  String get sharedUnknownSender => 'Okänd avsändare';

  @override
  String get sharedOnServer => 'På servern';

  @override
  String get sharedAttachment => 'Bilaga';

  @override
  String get sharedSnoozedBadge => 'Snoozat';

  @override
  String get sharedRowUnread => 'Oläst';

  @override
  String get sharedRowBackFromSnooze => 'Tillbaka från snooze';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Flaggat';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har arkiverats',
      one: '1 meddelande har arkiverats',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har raderats',
      one: '1 meddelande har raderats',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har flyttats till inkorgen',
      one: '1 meddelande har flyttats till inkorgen',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har flyttats till papperskorgen',
      one: '1 meddelande har flyttats till papperskorgen',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har flyttats till Skräppost',
      one: '1 meddelande har flyttats till Skräppost',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har flyttats till $mailbox',
      one: '1 meddelande har flyttats till $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har flyttats till en brevlåda',
      one: '1 meddelande har flyttats till en brevlåda',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meddelanden har snoozats till $time',
      one: '1 meddelande har snoozats till $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Snoozat till $time bara på den här enheten: servern kan inte spara snoozetider.';
  }

  @override
  String get sharedMoveOneAccount => 'Välj meddelanden från ett konto för att flytta dem.';

  @override
  String get sharedSnoozeTitle => 'Snooza';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Ändra snoozetid';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vill du radera $count meddelanden permanent?',
      one: 'Vill du radera det här meddelandet permanent?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Det går inte att ångra.';

  @override
  String get sharedDeletePermanently => 'Radera permanent';

  @override
  String get sharedSwipeRead => 'Läst';

  @override
  String get sharedSwipeUnread => 'Oläst';

  @override
  String get sharedSwipeInbox => 'Inkorg';

  @override
  String get sharedSwipeDelete => 'Radera';

  @override
  String get sharedTrash => 'Papperskorg';

  @override
  String get sharedSwipeSnooze => 'Snooza';

  @override
  String get sharedWakeNow => 'Väck nu';

  @override
  String get sharedChangeSnoozeTime => 'Ändra snoozetid…';

  @override
  String get sharedSnooze => 'Snooza…';

  @override
  String get sharedTag => 'Tagga…';

  @override
  String get sharedMoveMessage => 'Flytta meddelande…';

  @override
  String get sharedNotJunk => 'Inte skräppost';

  @override
  String get accountSetupTitle => 'Lägg till konto';

  @override
  String get accountSetupTitleDone => 'Kontot har lagts till';

  @override
  String get accountSetupAddressTitle => 'Lägg till ett e-postkonto';

  @override
  String get accountSetupAddressText => 'Loupe hittar inställningarna för de flesta leverantörer.';

  @override
  String get accountSetupNameHint => 'Ditt namn';

  @override
  String get accountSetupEmail => 'E-post';

  @override
  String get accountSetupEmailHint => 'namn@example.com';

  @override
  String get accountSetupContinue => 'Fortsätt';

  @override
  String get accountSetupLookingUp => 'Söker efter inställningar…';

  @override
  String get accountSetupImport => 'Importera från Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Ange en giltig e-postadress.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Det gick inte att hitta inställningar för $domain. Ange dem nedan.';
  }

  @override
  String get accountSetupCheckServers => 'Kontrollera servernamn och portar.';

  @override
  String get accountSetupEnterPassword => 'Ange ditt lösenord.';

  @override
  String get accountSetupConnecting => 'Ansluter…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Väntar på $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Det gick inte att öppna sidan.';

  @override
  String get accountSetupCouldNotSaveName => 'Det gick inte att spara namnet.';

  @override
  String get accountSetupTrustCertificate => 'Lita på det här certifikatet';

  @override
  String get accountSetupPasswordRequired => 'Obligatoriskt';

  @override
  String get accountSetupShowPassword => 'Visa lösenord';

  @override
  String get accountSetupHidePassword => 'Dölj lösenord';

  @override
  String get accountSetupAppPassword => 'Applösenord';

  @override
  String get accountSetupApiToken => 'API-token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Inkommande · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Utgående · SMTP';

  @override
  String get accountSetupSignIn => 'Logga in';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Logga in med $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Använd ett applösenord';

  @override
  String get accountSetupUseAppPasswordInstead => 'Använd ett applösenord i stället';

  @override
  String get accountSetupUseDifferentAddress => 'Använd en annan adress';

  @override
  String get accountSetupHowToCreateAppPassword => 'Så skapar du ett applösenord';

  @override
  String get accountSetupHowToCreateOne => 'Så skapar du ett';

  @override
  String get accountSetupGoogleNote =>
      'Du loggar in på Googles sida och Loupe ser aldrig ditt lösenord. Ge Loupe tillåtelse att läsa, skicka och ordna din e-post.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '”Logga in med Google” är inte tillgängligt i det här bygget än. Du kan ansluta med ett applösenord i stället (det kräver tvåstegsverifiering på ditt Google-konto).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Skapa ett applösenord i ditt Google-konto och klistra in det nedan.';

  @override
  String get accountSetupMicrosoftNote =>
      'Du loggar in på Microsofts sida och Loupe ser aldrig ditt lösenord. Det fungerar för Outlook.com och Hotmail, och för jobb- eller skolkonton på Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Inloggning med Microsoft kommer i ett senare bygge. Outlook-, Hotmail- och Microsoft 365-konton kräver det: de godtar inte längre lösenord från e-postappar.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail kräver ett appspecifikt lösenord, inte lösenordet till ditt Apple-konto.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail kräver ett applösenord, inte lösenordet till ditt konto.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe ansluter till Fastmail via JMAP med en API-token: Settings › Privacy & Security › Manage API tokens, för JMAP, med åtkomst till e-post och sändning.';

  @override
  String get accountSetupFastmailNote => 'Fastmail kräver ett applösenord för e-postappar.';

  @override
  String get accountSetupServerSettings => 'Serverinställningar';

  @override
  String get accountSetupSettingsNotFound => 'Hittades inte automatiskt';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Hittades via $source';
  }

  @override
  String get accountSetupEditSettings => 'Redigera inställningar';

  @override
  String get accountSetupSyncing => 'Din e-post synkroniseras.';

  @override
  String get accountSetupDescription => 'Beskrivning';

  @override
  String get accountSetupDescriptionHint => 'Jobb, privat…';

  @override
  String get accountSetupColour => 'Färg';

  @override
  String accountSetupColourNumber(int number) {
    return 'Färg $number';
  }

  @override
  String get accountSetupSaving => 'Sparar…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe kunde inte öppna sin e-postdatabas i den här telefonen. Stäng Loupe, öppna appen igen och försök på nytt.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Något gick fel ($error). Försök igen.';
  }

  @override
  String get accountSetupSecurityNone => 'Ingen';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Säkerhet';

  @override
  String get accountSetupUsername => 'Användarnamn';

  @override
  String get accountSetupUsernameHint => 'Din e-postadress';

  @override
  String get accountSetupNoEncryptionTitle => 'Vill du ansluta utan kryptering?';

  @override
  String get accountSetupNoEncryptionText =>
      'Ditt lösenord och alla meddelanden skulle skickas som klartext. Vem som helst på nätverket, till exempel ett offentligt wifi, skulle kunna läsa dem. Använd bara detta för en server i ditt eget nätverk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Använd utan kryptering';

  @override
  String get accountSetupApiTokenRejected =>
      'API-token avvisades. Skapa en Fastmail-API-token för JMAP med åtkomst till e-post och klistra in den.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Lösenordet avvisades. Använd ett applösenord, inte lösenordet till ditt konto.';

  @override
  String get accountSetupPasswordRejected => 'Lösenordet avvisades. Kontrollera det och försök igen.';

  @override
  String get accountSetupServerUnreachable =>
      'Det går inte att nå servern. Kontrollera serverinställningarna och din anslutning.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Serverns certifikat är inte betrott. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Inloggningen avbröts. Tryck på ”Logga in med $provider” för att försöka igen.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe behöver tillåtelse att läsa och skicka din Gmail. Logga in igen och ge åtkomst med Gmail-rutan markerad.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe behöver tillåtelse att läsa och skicka din e-post. Logga in igen och godkänn behörigheterna.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Din organisation måste godkänna Loupe innan du kan använda appen med det här kontot. Be din it-administratör att ge administratörsmedgivande för Loupe i Microsoft Entra ID och försök sedan igen.';

  @override
  String get accountSetupOAuthBlocked =>
      'Din organisations inloggningsregler tillåter inte Loupe på den här enheten. Fråga din it-administratör.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Det gick inte att nå $provider. Kontrollera din internetanslutning och försök igen.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Inloggning med $provider är inte korrekt konfigurerad i den här versionen av Loupe. Rapportera gärna detta.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Inloggning med $provider fungerade inte. Försök igen.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider loggade in dig, men Gmail nekade åtkomst för den här adressen. Välj samma konto när du loggar in. Jobb- eller skolkonton kan ha IMAP avstängt av sin administratör.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider loggade in dig, men e-postservern nekade åtkomst för den här adressen. Välj samma konto när du loggar in. Jobb- eller skolkonton kan ha IMAP avstängt av sin administratör.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Det går inte att nå e-postservern. Kontrollera din anslutning och försök igen.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Inloggning med $provider är inte tillgänglig i den här versionen.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Du är inloggad igen. $account synkroniseras.';
  }

  @override
  String get accountSetupSignInAgain => 'Logga in igen';

  @override
  String get accountSetupSigningIn => 'Loggar in…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider godtar inte längre Loupes inloggning för $email, så $account synkroniseras inte. Logga in igen för att få kontots e-post.';
  }

  @override
  String get accountImportTitle => 'Importera från Thunderbird';

  @override
  String get accountImportPointCamera => 'Rikta kameran mot QR-koden som Thunderbird visar.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skannat $scanned av $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Skannat $scanned av $total koder');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konton hittills',
      one: '1 konto hittills',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Öppna Thunderbird på datorn och välj Verktyg › Exportera till mobil. Välj dina konton och skanna sedan varje kod som visas. Koderna kan skannas i valfri ordning.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fortsätt med $count konton',
      one: 'Fortsätt med 1 konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Klistra in text i stället';

  @override
  String get accountImportStartOver => 'Börja om';

  @override
  String get accountImportDuplicateCode => 'Den koden har redan lagts till.';

  @override
  String get accountImportRestarted =>
      'Den här koden kommer från en ny export, så de koder som skannats tidigare har lagts åt sidan.';

  @override
  String get accountImportNotThunderbird => 'Det här är ingen kontokod från Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Den här koden kommer från en nyare Thunderbird. Uppdatera Loupe för att importera den.';

  @override
  String get accountImportDamaged => 'Den här Thunderbird-koden gick inte att läsa.';

  @override
  String get accountImportTooLarge => 'Den här koden är för stor för att vara en export från Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Det gick inte att öppna Inställningar.';

  @override
  String get accountImportCameraOffTitle => 'Kameraåtkomst är avstängd';

  @override
  String get accountImportCameraOffText =>
      'Ge Loupe åtkomst till kameran i Inställningar för att skanna koden, eller klistra in kodens text i stället.';

  @override
  String get accountImportNoCameraTitle => 'Ingen kamera';

  @override
  String get accountImportNoCameraText => 'Loupe kan inte använda någon kamera här. Klistra in kodens text i stället.';

  @override
  String get accountImportCameraFailedTitle => 'Kameran startade inte';

  @override
  String get accountImportCameraFailedText => 'Försök igen eller klistra in kodens text i stället.';

  @override
  String get accountImportOpenSettings => 'Öppna Inställningar';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konton hittades',
      one: '1 konto hittades',
      zero: 'Inga konton hittades',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Inget av kontona i de här koderna gick att läsa.';

  @override
  String get accountImportChoose => 'Välj vilka konton som ska läggas till i Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Koderna $codes av $total skannades inte, så deras konton visas inte.',
      one: 'Kod $codes av $total skannades inte, så dess konton visas inte.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes och $last';
  }

  @override
  String get accountImportScanMore => 'Skanna fler koder';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count konton i koderna gick inte att läsa. De kanske använder inställningar från en nyare Thunderbird.',
      one: '1 konto i koderna gick inte att läsa. Det kanske använder inställningar från en nyare Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skanna igen';

  @override
  String get accountImportAlreadyAdded => 'Det finns redan ett konto med den här adressen i Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Du loggar in med $provider när kontot läggs till, precis som i Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Lägg till kontot med ett applösenord (det kräver tvåstegsverifiering).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird loggar in på Gmail med Google. ”Logga in med Google” kommer i ett senare bygge; till dess kan du lägga till kontot med ett applösenord (det kräver tvåstegsverifiering).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird loggar in på det här kontot i webbläsaren. Det kan Loupe inte göra än: använd ett applösenord om din leverantör erbjuder det.';

  @override
  String get accountImportUnencrypted => 'Ansluter utan kryptering. Använd bara detta i ditt eget nätverk.';

  @override
  String get accountImportEnterAgain => 'Ange det igen';

  @override
  String get accountImportAdded => 'Tillagt';

  @override
  String accountImportAdding(int index, int total) {
    return 'Lägger till $index av $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lägg till $count konton',
      one: 'Lägg till 1 konto',
      zero: 'Lägg till konton',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Klistra in exporttext';

  @override
  String get accountImportPasteText => 'Klistra in texten från en exportkod från Thunderbird, en kod per rad.';

  @override
  String get accountImportPop3 => 'POP3-konton stöds inte. Loupe behåller e-posten på servern med IMAP.';

  @override
  String get accountImportKerberos => 'Det här kontot loggar in med Kerberos, som Loupe inte stöder.';

  @override
  String get accountImportNtlm => 'Det här kontot loggar in med NTLM, som Loupe inte stöder.';

  @override
  String get accountImportClientCertificate =>
      'Det här kontot loggar in med ett klientcertifikat, som Loupe inte stöder än.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Inloggning med Microsoft kommer i ett senare bygge. Outlook- och Microsoft 365-konton godtar inte längre lösenord från e-postappar.';

  @override
  String get accountImportEnterPassword => 'Ange lösenordet.';

  @override
  String get accountImportEnterAppPassword => 'Ange applösenordet.';

  @override
  String get accountImportEnterApiToken => 'Ange API-token.';

  @override
  String get accountImportStorageFailed => 'Loupe kunde inte öppna sin kontolagring. Försök igen senare.';

  @override
  String get accountImportFailed => 'Det gick inte att lägga till kontot. Försök igen eller lägg till det manuellt.';

  @override
  String get composeNewMessageTitle => 'Nytt meddelande';

  @override
  String get composeAttach => 'Bifoga';

  @override
  String get composeSendLater => 'Skicka senare';

  @override
  String composeSendAt(String time) {
    return 'Skicka $time';
  }

  @override
  String get composeSendHint => 'Tryck länge för att skicka senare';

  @override
  String get composeNoAccount => 'Lägg till ett konto för att skicka e-post.';

  @override
  String get composeTo => 'Till:';

  @override
  String get composeCc => 'Kopia:';

  @override
  String get composeBcc => 'Dold kopia:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopia/dold kopia, Från: $email';
  }

  @override
  String get composeFromLabel => 'Från:';

  @override
  String get composeSubjectLabel => 'Ämne:';

  @override
  String composeReplyTo(String address) {
    return 'Svara till: $address';
  }

  @override
  String get composeFrom => 'Från';

  @override
  String composeReplyFrom(String email) {
    return 'Svara från $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Skicka från $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vill du svara från $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Vill du skicka från $email?';
  }

  @override
  String get composeDismiss => 'Stäng';

  @override
  String composeAliasNotSaved(String account) {
    return 'Inte sparad som identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Spara som identitet';

  @override
  String composeAliasSaved(String email) {
    return '$email har sparats som identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ogiltig adress $address';
  }

  @override
  String get composeOriginalNotFound => 'Det ursprungliga meddelandet hittades inte.';

  @override
  String get composeDraftNotFound => 'Utkastet hittades inte.';

  @override
  String get composeAttachmentsLost => 'Det gick inte att återställa bilagorna. Lägg till dem igen.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Vissa bilagor gick inte att lägga till: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Bilagorna är totalt $size; vissa servrar avvisar så stora meddelanden.';
  }

  @override
  String get composeAttachFailed => 'Det gick inte att bifoga filen.';

  @override
  String get composeInvalidAddressTitle => 'Ogiltig adress';

  @override
  String composeInvalidAddress(String address) {
    return '”$address” är ingen giltig e-postadress.';
  }

  @override
  String get composeNoSubjectTitle => 'Inget ämne';

  @override
  String get composeNoSubjectText => 'Meddelandet har inget ämne. Vill du skicka det ändå?';

  @override
  String get composeSentBeforeChanges => 'Det skickades före dina ändringar, som har sparats i Utkast.';

  @override
  String composeScheduled(String time) {
    return 'Schemalagt till $time';
  }

  @override
  String get composeSending => 'Skickar…';

  @override
  String get composeSent => 'Skickat';

  @override
  String get composeSendFailed => 'Det gick inte att skicka. Försök igen.';

  @override
  String get composeAlreadySent => 'Redan skickat.';

  @override
  String get composeDiscardChanges => 'Ignorera ändringar';

  @override
  String get composeSaveChanges => 'Spara ändringar';

  @override
  String get composeDeleteDraft => 'Radera utkast';

  @override
  String get composeSaveDraft => 'Spara utkast';

  @override
  String get composeDraftSaved => 'Utkastet har sparats';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Den $date kl. $time skrev $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Den $date kl. $time skrev någon:';
  }

  @override
  String get composeForwardHeader => '---------- Vidarebefordrat meddelande ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Från: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date kl. $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Ämne: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Till: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kopia: $addresses';
  }

  @override
  String get composeLaterToday => 'Senare i dag';

  @override
  String get composeTomorrowMorning => 'I morgon bitti';

  @override
  String get composeMondayMorning => 'Måndag morgon';

  @override
  String get composePickDateTime => 'Välj datum och tid…';

  @override
  String get composeSendWithoutDelay => 'Skicka utan fördröjning';

  @override
  String composeSendTimeToday(String time) {
    return 'I dag kl. $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'I morgon kl. $time';
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
    return 'I morgon $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Vill du fortsätta redigera ditt utkast?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Ett meddelande skickades inte när Loupe stängdes.',
      'one': 'Ett meddelande till $name skickades inte när Loupe stängdes.',
      'other': 'Ett meddelande till $name med flera skickades inte när Loupe stängdes.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '”$subject” skickades inte när Loupe stängdes.',
      'one': '”$subject” till $name skickades inte när Loupe stängdes.',
      'other': '”$subject” till $name med flera skickades inte när Loupe stängdes.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Fortsätt redigera';

  @override
  String get composeRecoverySave => 'Spara i Utkast';

  @override
  String get composeRecoveryDiscard => 'Ignorera';

  @override
  String get composeRecoverySaved => 'Sparat i Utkast';

  @override
  String get outboxSectionFailed => 'Inte skickade';

  @override
  String get outboxSectionSending => 'Skickas';

  @override
  String get outboxSectionScheduled => 'Schemalagda';

  @override
  String get outboxStatusQueued => 'Skickas snart';

  @override
  String get outboxStatusSending => 'Skickar…';

  @override
  String get outboxStatusFailed => 'Inte skickat';

  @override
  String get outboxNoRecipients => 'Inga mottagare';

  @override
  String get outboxNoSubject => '(Inget ämne)';

  @override
  String get outboxSendingFailed => 'Det gick inte att skicka.';

  @override
  String get outboxEmptyTitle => 'Inget att skicka';

  @override
  String get outboxEmptyText => 'Meddelanden som du skickar senare väntar här tills det är dags.';

  @override
  String get outboxSendNow => 'Skicka nu';

  @override
  String get outboxReschedule => 'Ny tid';

  @override
  String get outboxRescheduleMenu => 'Välj ny tid…';

  @override
  String get outboxRescheduleTitle => 'Ny tid';

  @override
  String outboxRescheduled(String time) {
    return 'Flyttat till $time';
  }

  @override
  String get outboxCancel => 'Avbryt';

  @override
  String get outboxCancelSending => 'Avbryt sändning…';

  @override
  String get outboxCancelTitle => 'Vill du avbryta sändningen?';

  @override
  String get outboxMoveToDrafts => 'Flytta till Utkast';

  @override
  String get outboxDiscard => 'Ignorera meddelande';

  @override
  String get outboxMovedToDrafts => 'Flyttat till Utkast';

  @override
  String get outboxDiscarded => 'Meddelandet har ignorerats';

  @override
  String get outboxAlreadySent => 'Redan skickat.';

  @override
  String get outboxBeingSent => 'Det här meddelandet håller på att skickas.';

  @override
  String get outboxActionFailed => 'Det fungerade inte. Meddelandet ligger kvar i utkorgen.';

  @override
  String get notificationsBadgeInboxes => 'Olästa i inkorgar';

  @override
  String get notificationsBadgeVip => 'Olästa från VIP-personer';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Ny e-post från dina VIP-personer, i alla konton';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Ny e-post i $email';
  }

  @override
  String get notificationsUnknownSender => 'Okänd avsändare';

  @override
  String get notificationsNoSubject => '(Inget ämne)';

  @override
  String get notificationsEncryptedMessage => 'Krypterat meddelande';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nytt meddelande från $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nya meddelanden',
      one: '1 nytt meddelande',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nya meddelanden i $account';
  }

  @override
  String get platformInstantChannel => 'Direktleverans';

  @override
  String get platformInstantChannelDescription => 'Visas medan Loupe bevakar dina inkorgar efter ny e-post';

  @override
  String get platformInstantTitle => 'Bevakar ny e-post';

  @override
  String get platformInstantText => 'Direktleverans är på';

  @override
  String get platformErrorBox => 'Något gick fel när detta skulle visas. Gå tillbaka och försök igen.';

  @override
  String get welcomeTagline => 'E-post som är enkel på ytan\noch kraftfull under huven.';

  @override
  String get welcomeAccountsTitle => 'Alla konton, en lugn inkorg';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail och alla IMAP- eller JMAP-servrar.';

  @override
  String get welcomeSearchTitle => 'Sökning som hittar';

  @override
  String get welcomeSearchText => 'Direkta träffar i telefonen, sedan serverns.';

  @override
  String get welcomePrivacyTitle => 'Privat från grunden';

  @override
  String get welcomePrivacyText => 'Ingen spårning. Fjärrbilder förblir blockerade tills du säger till.';

  @override
  String get welcomeAddAccount => 'Lägg till konto';

  @override
  String get welcomeImport => 'Importera från Thunderbird';

  @override
  String get welcomeTryDemo => 'Prova med demo-e-post';
}
