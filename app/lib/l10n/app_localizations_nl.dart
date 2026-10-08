// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get commonAdd => 'Toevoegen';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get commonClose => 'Sluiten';

  @override
  String get commonDelete => 'Verwijderen';

  @override
  String get commonDone => 'Klaar';

  @override
  String get commonEdit => 'Bewerken';

  @override
  String get commonMore => 'Meer';

  @override
  String get commonMove => 'Verplaatsen';

  @override
  String get commonName => 'Naam';

  @override
  String get commonNone => 'Geen';

  @override
  String get commonOff => 'Uit';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Aan';

  @override
  String get commonOptional => 'Optioneel';

  @override
  String get commonPassword => 'Wachtwoord';

  @override
  String get commonRemove => 'Verwijderen';

  @override
  String get commonRetry => 'Opnieuw';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonSearch => 'Zoeken';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Instellingen';

  @override
  String get commonShare => 'Delen';

  @override
  String get commonTryAgain => 'Opnieuw proberen';

  @override
  String get commonUndo => 'Ongedaan maken';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count berichten', one: '$count bericht');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archiveren';

  @override
  String get mailDelete => 'Verwijderen';

  @override
  String get mailFlag => 'Markeren';

  @override
  String get mailForward => 'Doorsturen';

  @override
  String get mailMarkAsRead => 'Markeren als gelezen';

  @override
  String get mailMarkAsUnread => 'Markeren als ongelezen';

  @override
  String get mailMoveToJunk => 'Naar spam verplaatsen';

  @override
  String get mailNewMessage => 'Nieuw bericht';

  @override
  String get mailNoSubject => 'Geen onderwerp';

  @override
  String get mailReply => 'Beantwoorden';

  @override
  String get mailReplyAll => 'Allen beantwoorden';

  @override
  String get mailSend => 'Verzenden';

  @override
  String get mailUnflag => 'Markering verwijderen';

  @override
  String get mailboxArchive => 'Archief';

  @override
  String get mailboxDrafts => 'Concepten';

  @override
  String get mailboxInbox => 'Inbox';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Postvak UIT';

  @override
  String get mailboxSent => 'Verzonden';

  @override
  String get mailboxTrash => 'Prullenbak';

  @override
  String get conversationSomethingWentWrong => 'Er ging iets mis. Probeer het opnieuw.';

  @override
  String get conversationReplyToList => 'Beantwoorden aan lijst';

  @override
  String get conversationReplyList => 'Lijst beantwoorden';

  @override
  String get conversationThreadMuted => 'Thread gedempt. Nieuwe berichten erin komen binnen als gelezen.';

  @override
  String get conversationThreadUnmuted => 'Thread niet meer gedempt.';

  @override
  String get conversationLinkFailed => 'Kan de link niet openen.';

  @override
  String get conversationGoneTitle => 'Geen bericht';

  @override
  String get conversationGoneText => 'Dit bericht is verplaatst of verwijderd.';

  @override
  String get conversationMuted => 'Gedempt';

  @override
  String get conversationReaderOptions => 'Leesopties';

  @override
  String get conversationReaderOptionsHint => 'Tekstgrootte en weergave';

  @override
  String get conversationTrash => 'Naar prullenbak';

  @override
  String get conversationReplyHint => 'Lang indrukken voor Allen beantwoorden en Doorsturen';

  @override
  String get conversationOfflineTitle => 'Je bent offline';

  @override
  String get conversationOfflineText =>
      'Dit gesprek is nog niet gedownload. Het wordt geladen zodra je weer online bent.';

  @override
  String get conversationErrorTitle => 'Kan dit bericht niet tonen';

  @override
  String get conversationErrorText => 'Er ging iets mis.';

  @override
  String get conversationOfflineBanner => 'Je bent offline';

  @override
  String get conversationNotUpdated => 'Niet bijgewerkt';

  @override
  String get conversationMe => 'mij';

  @override
  String get conversationNoSender => '(geen afzender)';

  @override
  String get conversationNoRecipients => 'geen ontvangers';

  @override
  String conversationRecipients(String names) {
    return 'aan $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'aan $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Van';

  @override
  String get conversationHeaderTo => 'Aan';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Antwoord aan';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Beveiliging';

  @override
  String get conversationVerifiedSender => 'Geverifieerde afzender';

  @override
  String get conversationUnverifiedSender => 'Niet-geverifieerde afzender';

  @override
  String get conversationLoadingMessage => 'Bericht wordt geladen';

  @override
  String get conversationBodyError => 'Dit bericht kon niet worden geladen.';

  @override
  String get conversationBodyOffline => 'Je bent offline. Het bericht wordt geladen zodra je weer online bent.';

  @override
  String get conversationOriginalHint => 'Ziet er beter uit in de weergave Origineel';

  @override
  String get conversationShowOriginal => 'Origineel tonen';

  @override
  String get conversationScrollToTop => 'Naar boven scrollen';

  @override
  String get conversationTagsMenu => 'Tags…';

  @override
  String get conversationMuteThread => 'Thread dempen';

  @override
  String get conversationUnmuteThread => 'Dempen opheffen';

  @override
  String get conversationMoveMenu => 'Verplaatsen…';

  @override
  String get conversationDeletePermanently => 'Definitief verwijderen';

  @override
  String get conversationMoveToTrash => 'Naar prullenbak verplaatsen';

  @override
  String get conversationNotJunk => 'Geen spam';

  @override
  String get conversationShowAllHeaders => 'Alle kopteksten tonen';

  @override
  String get conversationViewSource => 'Bron bekijken';

  @override
  String get conversationSaveAsFile => 'Opslaan als bestand…';

  @override
  String get conversationShareAsFile => 'Delen als bestand…';

  @override
  String get conversationSearchFromMessageMenu => 'Zoeken vanuit dit bericht…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Adres kopiëren';

  @override
  String get conversationAddressCopied => 'Adres gekopieerd';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Berichten van $name zoeken';
  }

  @override
  String get conversationTags => 'Tags';

  @override
  String get conversationAllHeaders => 'Alle kopteksten';

  @override
  String get conversationCopyAll => 'Alles kopiëren';

  @override
  String get conversationHeadersCopied => 'Kopteksten gekopieerd';

  @override
  String get conversationNoHeaders => 'Geen kopteksten';

  @override
  String get conversationSearchFromMessageTitle => 'Zoeken vanuit dit bericht';

  @override
  String conversationSearchFrom(String name) {
    return 'Van $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Aan $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Onderwerp “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Bron';

  @override
  String get conversationSourceCopied => 'Bron gekopieerd';

  @override
  String get conversationShareFailed => 'Het bericht kon niet worden gedeeld.';

  @override
  String get conversationWrapLines => 'Regels laten teruglopen';

  @override
  String get conversationDontWrapLines => 'Regels niet laten teruglopen';

  @override
  String get conversationSourceError => 'De bron kon niet worden geladen.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'De eerste $shown van $total worden getoond. Kopieer of deel de bron om alles te krijgen.';
  }

  @override
  String get conversationAttachmentUntitled => 'Naamloos';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Meer acties voor $name';
  }

  @override
  String get conversationMoveTo => 'Verplaatsen naar…';

  @override
  String get conversationMailboxesError => 'Kan mailboxen niet laden.';

  @override
  String get conversationReaderReadable => 'Leesbaar';

  @override
  String get conversationReaderOriginal => 'Origineel';

  @override
  String get conversationReaderPlain => 'Platte tekst';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Originele kleuren behouden';

  @override
  String get conversationReaderRemember => 'Onthouden voor deze afzender';

  @override
  String get conversationSecurityPossiblePhishing => 'Mogelijk phishing';

  @override
  String get conversationSecurityBeCareful => 'Wees voorzichtig';

  @override
  String get conversationSecurityVerified => 'Geverifieerd';

  @override
  String get conversationSecurityNoIssues => 'Geen problemen gevonden';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count trackers', one: '$count tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Toont waarom';

  @override
  String get conversationPhishingBannerTitle => 'Dit bericht lijkt op phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Links en afbeeldingen zijn uitgeschakeld.';
  }

  @override
  String get conversationPhishingBannerText => 'Links en afbeeldingen zijn uitgeschakeld.';

  @override
  String get conversationPhishingWhy => 'Waarom?';

  @override
  String get conversationPhishingShowAnyway => 'Toch tonen';

  @override
  String get conversationSecurityPhishingTitle => 'Dit lijkt op phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Verschillende signalen wijzen erop dat dit bericht niet is wat het beweert te zijn.';

  @override
  String get conversationSecurityCarefulTitle => 'Wees voorzichtig met dit bericht';

  @override
  String get conversationSecurityCarefulText => 'Er is iets aan dat een tweede blik verdient.';

  @override
  String get conversationSecurityVerifiedText => 'De afzender is geverifieerd en niets ziet er verdacht uit.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Niets ziet er verdacht uit. Je mailserver heeft niet aangegeven of de afzender is geverifieerd.';

  @override
  String get conversationSecurityNothingSuspicious => 'Niets ziet er verdacht uit.';

  @override
  String get conversationSecurityWhy => 'Redenen';

  @override
  String get conversationSecurityPrivacy => 'Privacy';

  @override
  String get conversationSecurityNoTrackingPixels => 'Geen trackingpixels';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count trackingpixels verwijderd',
      one: '$count trackingpixel verwijderd',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Die hadden de afzender laten weten wanneer je dit bericht opende.';

  @override
  String get conversationSecurityNoRemoteImages => 'Geen externe afbeeldingen';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count externe afbeeldingen',
      one: '$count externe afbeelding',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Als je ze laadt, ziet de afzender wanneer je dit bericht leest, en je IP-adres.';

  @override
  String get conversationSecurityNoClickTracking => 'Geen kliktracking';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links via kliktrackers',
      one: '$count link via kliktrackers',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Je klik zou worden vastgelegd door $services. Houd een link ingedrukt om de bestemming direct te openen.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technische details';

  @override
  String get conversationSecurityCheckedLocally => 'Gecontroleerd op dit apparaat. Er is niets verstuurd.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackers';

  @override
  String get conversationSecurityImagesFrom => 'Afbeeldingen van';

  @override
  String get conversationSecuritySenderHistory => 'Afzendergeschiedenis';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received ontvangen, $sent verzonden';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Links leiden naar';

  @override
  String get conversationSecurityHidden => 'Verborgen';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementen',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters tekens',
      one: '$characters teken',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Afzender niet geverifieerd';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Je mailserver kon niet bevestigen dat dit bericht echt van $domain komt.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Je mailserver kon niet bevestigen dat dit bericht echt van de afzender komt.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Je mailserver kon niet bevestigen dat dit bericht van $domain komt. Gebruikelijk bij mailinglijsten.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Je mailserver kon niet bevestigen dat dit bericht van de afzender komt. Gebruikelijk bij mailinglijsten.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Doe er niets mee tenzij je het verwachtte. Neem bij twijfel op een andere manier contact op met de afzender.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Ondertekend door een ander domein';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Het bericht is ondertekend door $signer, niet door $domain. Verzenddiensten doen dit, maar het bewijst niet wie het heeft geschreven.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Het bericht is ondertekend door een ander domein, niet door $domain. Verzenddiensten doen dit, maar het bewijst niet wie het heeft geschreven.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Naam toont een ander adres';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'De naam van de afzender luidt “$shown”, maar het bericht komt van $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Vertrouw op het adres, niet op de naam.';

  @override
  String get conversationSecurityReplyToTitle => 'Antwoorden gaan ergens anders heen';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Als je antwoordt, gaat je antwoord naar $address, niet naar $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Controleer het adres voordat je iets persoonlijks terugstuurt.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Gebruikt jouw naam';

  @override
  String get conversationSecurityImpersonationTitle => 'Gebruikt de naam van iemand die je kent';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Het is ondertekend met “$name”, net als je eigen naam, maar komt van een nieuw adres: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Het is ondertekend met “$name”, net als je VIP $knownName ($knownEmail), maar komt van een nieuw adres: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Het is ondertekend met “$name”, net als $knownName ($knownEmail), maar komt van een nieuw adres: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'En antwoorden zouden naar nog een ander adres gaan.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Vraagt het om geld, codes of bestanden? Check het dan eerst op een andere manier bij die persoon.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Bekend adres: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Dit adres: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Eerste bericht van deze afzender';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Je hebt nog niet eerder mail van $email gehad.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Wees voorzichtig met verzoeken van mensen die je nog niet kent.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Gelijkende letters in het adres van de afzender';

  @override
  String get conversationSecurityLinkHomographTitle => 'Gelijkende letters in een link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mengt letters uit verschillende alfabetten om een ander adres na te bootsen.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host gebruikt gelijkende letters: het is niet $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Verwijder het of meld het als spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Open hem niet.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domein: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Nagebootst domein';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Gebruikt een bekende naam in het domein';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain lijkt op je eigen domein, $real, maar is een ander domein.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain lijkt op $brand ($real), maar is een ander domein.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain gebruikt de naam van je eigen domein, $real, maar hoort er niet bij.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain gebruikt de naam van $brand ($real), maar hoort er niet bij.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Echte berichten van je organisatie komen van $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Echte berichten van $brand komen van $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Afzenderdomein: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imiteert: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links verbergen waar ze heen gaan',
      one: 'Een link verbergt waar hij heen gaat',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Een link toont $shown, maar opent $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Log niet in en betaal niet via deze links. Typ het adres liever zelf.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'De bestemming van een link kan niet worden gecontroleerd';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Een link toont $shown, maar gaat via $host, dat de klik vastlegt voordat het je doorstuurt.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Een link verwijst naar een kaal IP-adres';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts is geen website met een naam. Echte bedrijven linken zelden zo.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Een vermomde link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Een link begint met “$shown@” om eruit te zien als $shown, maar opent $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Een verborgen pagina is uitgeschakeld';

  @override
  String get conversationSecurityDataLinkText =>
      'Een link zou een pagina hebben geopend die in het bericht zelf zit, een manier om linkcontroles te omzeilen.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Vraagt om een wachtwoord';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Het bericht bevatte een wachtwoordveld. Loupe heeft het verwijderd.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Typ nooit een wachtwoord in een e-mail.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Een link die code uitvoert is uitgeschakeld';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe voert nooit code uit berichten uit.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Verkorte links', one: 'Een verkorte link');
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts verbergt de echte bestemming tot je de link opent.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Internationaal webadres';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts gebruikt niet-Latijnse letters. Normaal voor veel talen; controleer of het de site is die je verwacht.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Veel verborgen tekst';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count tekens onzichtbare tekst zijn verwijderd. Verborgen tekst als deze is bedoeld om spamfilters te misleiden.',
      one:
          '$count teken onzichtbare tekst is verwijderd. Verborgen tekst als deze is bedoeld om spamfilters te misleiden.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Verborgen tekst verwijderd';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tekens onzichtbare tekst zijn verwijderd.',
      one: '$count teken onzichtbare tekst is verwijderd.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Kan het bericht niet downloaden. Controleer de verbinding en probeer het opnieuw.';

  @override
  String exportSaved(String name) {
    return '“$name” opgeslagen';
  }

  @override
  String get exportSaveFailed => 'Kan het bericht niet opslaan.';

  @override
  String exportFailed(String folder) {
    return 'Kan “$folder” niet exporteren.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” bevat geen berichten om te exporteren.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Kan “$folder” niet exporteren: er kon geen enkel bericht worden gedownload. Controleer de verbinding en probeer het opnieuw.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$name” opgeslagen zonder $formattedCount berichten die niet konden worden gedownload.',
      one: '“$name” opgeslagen zonder 1 bericht dat niet kon worden gedownload.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Kan “$name” niet opslaan.';
  }

  @override
  String exportTitle(String folder) {
    return '“$folder” exporteren';
  }

  @override
  String get exportListing => 'Berichten zoeken…';

  @override
  String exportProgress(String current, String total) {
    return '$current van $total exporteren…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount berichten konden niet worden gedownload',
      one: '1 bericht kon niet worden gedownload',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Mailboxen';

  @override
  String get mailboxesShown => 'Zichtbaar';

  @override
  String get mailboxesHidden => 'Verborgen';

  @override
  String get mailboxesCollapse => 'Samenvouwen';

  @override
  String get mailboxesExpand => 'Uitvouwen';

  @override
  String get mailboxesManageVips => 'VIP’s beheren';

  @override
  String get mailboxesSubscriptions => 'Abonnementen';

  @override
  String mailboxesShowAccount(String account) {
    return '$account tonen';
  }

  @override
  String mailboxesHideAccount(String account) {
    return '$account verbergen';
  }

  @override
  String get mailboxesExportFolder => 'Map exporteren…';

  @override
  String get mailboxesUnpin => 'Losmaken';

  @override
  String get mailboxesLists => 'Lijsten';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Bewaar een zoekopdracht om hem hier te houden.';

  @override
  String get mailboxesTags => 'Tags';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Je kunt ook in een bericht op de naam van een afzender tikken en VIP aanzetten.';

  @override
  String get mailboxesAddVip => 'VIP toevoegen…';

  @override
  String get mailboxesAddVipTitle => 'VIP toevoegen';

  @override
  String get mailboxesAddVipText => 'Mail van dit adres krijgt een ster en verschijnt in de VIP-mailbox.';

  @override
  String get mailboxesAddVipPlaceholder => 'naam@example.com';

  @override
  String get messageListFilterUnread => 'Ongelezen';

  @override
  String get messageListFilterFlagged => 'Gemarkeerd';

  @override
  String get messageListFilterToMe => 'Aan: mij';

  @override
  String get messageListFilterCcMe => 'Cc: mij';

  @override
  String get messageListFilterWithAttachments => 'Met bijlagen';

  @override
  String get messageListFilterUnreplied => 'Onbeantwoord';

  @override
  String get messageListFilterFromVips => 'Van VIP’s';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten gemarkeerd als gelezen',
      one: '$count bericht gemarkeerd als gelezen',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Kan oudere mail niet laden.';

  @override
  String get messageListSelectMessages => 'Berichten selecteren';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count geselecteerd',
      one: '$count geselecteerd',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Alles selecteren';

  @override
  String get messageListDeselectAll => 'Selectie opheffen';

  @override
  String get messageListLoadFailed => 'Kan mail niet laden';

  @override
  String get messageListNoUnread => 'Geen ongelezen mail';

  @override
  String get messageListNoMatches => 'Geen overeenkomende mail';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Gefilterd op: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Filter uitschakelen';

  @override
  String get messageListEmpty => 'Geen mail';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtercriteria: $filters';
  }

  @override
  String get messageListFilteredBy => 'Gefilterd op:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ongelezen',
      one: '$formattedCount ongelezen',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markeren';

  @override
  String get messageListTrash => 'Naar prullenbak';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'TONEN';

  @override
  String get panesHideMailboxes => 'Mailboxen verbergen';

  @override
  String get panesShowMailboxes => 'Mailboxen tonen';

  @override
  String get panesMailboxesWidth => 'Breedte van de mailboxen';

  @override
  String get panesListWidth => 'Breedte van de berichtenlijst';

  @override
  String get panesNoMessageSelected => 'Geen bericht geselecteerd';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count berichten', one: '$count bericht');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Gesnoozed';

  @override
  String get snoozeSheetTitle => 'Snoozen';

  @override
  String get snoozeLaterToday => 'Later vandaag';

  @override
  String get snoozeThisEvening => 'Vanavond';

  @override
  String get snoozeTomorrow => 'Morgen';

  @override
  String get snoozeThisWeekend => 'Dit weekend';

  @override
  String get snoozeNextWeek => 'Volgende week';

  @override
  String get snoozePickDateTime => 'Datum en tijd kiezen…';

  @override
  String get snoozeMenu => 'Snoozen…';

  @override
  String get snoozeWakeNow => 'Nu terughalen';

  @override
  String get snoozeChangeTimeMenu => 'Snoozetijd wijzigen…';

  @override
  String get snoozeChangeTime => 'Tijd wijzigen';

  @override
  String get snoozeNoTime => 'Geen tijd ingesteld';

  @override
  String get snoozeFooter => 'Gesnoozede berichten komen op het gekozen moment ongelezen terug in de inbox.';

  @override
  String get snoozeEmptyTitle => 'Niets gesnoozed';

  @override
  String get snoozeEmptyText => 'Snooze een bericht om het terug te laten komen in de inbox wanneer je het nodig hebt.';

  @override
  String get appLockUnlock => 'Ontgrendelen';

  @override
  String get appLockFailed => 'Loupe kon niet bevestigen dat jij het bent.';

  @override
  String get appLockLockedOut => 'Te veel pogingen. Probeer het later opnieuw.';

  @override
  String get appLockPromptError => 'Het verzoek kon niet worden getoond. Probeer het opnieuw.';

  @override
  String get appLockNoScreenLock => 'Deze telefoon heeft geen schermvergrendeling.';

  @override
  String get appLockUnlockPromptTitle => 'Loupe ontgrendelen';

  @override
  String get appLockUnlockPromptReason => 'Bevestig dat jij het bent om je mail te zien.';

  @override
  String get appLockTurnOnPromptTitle => 'App-vergrendeling inschakelen';

  @override
  String get appLockTurnOnPromptReason => 'Bevestig dat jij het bent om app-vergrendeling in te schakelen.';

  @override
  String get appLockScreenLockRemoved =>
      'App-vergrendeling staat uit: deze telefoon heeft geen schermvergrendeling meer. Stel er een in om app-vergrendeling weer in te schakelen.';

  @override
  String get appLockAfterImmediately => 'Direct';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuten', one: '$count minuut');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count uur', one: '$count uur');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Versleuteld';

  @override
  String get openpgpEncryptedInPart => 'Gedeeltelijk versleuteld';

  @override
  String get openpgpEncryptedLocked => 'Versleuteld · vergrendeld';

  @override
  String get openpgpEncryptedNoKey => 'Versleuteld · geen sleutel';

  @override
  String get openpgpEncryptedDamaged => 'Versleuteld · beschadigd';

  @override
  String get openpgpEncryptedUnsupported => 'Versleuteld · niet ondersteund';

  @override
  String get openpgpUnknownSigner => 'onbekend';

  @override
  String get openpgpUnknownKey => 'Onbekende sleutel';

  @override
  String get openpgpSignatureInvalid => 'Handtekening ongeldig';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Ondertekend door $name, niet door de afzender';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Gedeeltelijk ondertekend door $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Ondertekend door $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Ondertekend met een geweigerde sleutel';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Ondertekend door $name · sleutel niet geaccepteerd';
  }

  @override
  String get openpgpUnlock => 'Ontgrendelen';

  @override
  String get openpgpCantDecrypt => 'Kan dit bericht niet ontsleutelen';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Versleuteld met OpenPGP';

  @override
  String get openpgpEncryption => 'Versleuteling';

  @override
  String get openpgpDecryptedHere => 'Ontsleuteld op dit apparaat';

  @override
  String get openpgpNotDecrypted => 'Niet ontsleuteld';

  @override
  String get openpgpKeyLocked => 'Je sleutel is vergrendeld.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Voor sleutels $keys',
      one: 'Voor sleutel $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Beschermd onderwerp';

  @override
  String get openpgpUnlockKey => 'Sleutel ontgrendelen';

  @override
  String get openpgpSignature => 'Handtekening';

  @override
  String get openpgpFingerprint => 'Vingerafdruk';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Sleutel-ID $id';
  }

  @override
  String get openpgpSigned => 'Ondertekend';

  @override
  String get openpgpProblem => 'Probleem';

  @override
  String get openpgpAcceptance => 'Acceptatie';

  @override
  String get openpgpChangeAcceptance => 'Acceptatie wijzigen…';

  @override
  String get openpgpCheckedFooter => 'Op dit apparaat gecontroleerd met OpenPGP, compatibel met Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Je sleutel is vergrendeld. Ontgrendel hem met de wachtwoordzin om dit bericht te lezen.';

  @override
  String get openpgpSummaryNoSecretKey => 'Het is versleuteld voor een sleutel die niet op dit apparaat staat.';

  @override
  String get openpgpSummaryDamaged => 'De versleutelde gegevens zijn beschadigd of onderweg gewijzigd.';

  @override
  String get openpgpSummaryUnsupported => 'Het gebruikt een algoritme dat Loupe niet ondersteunt.';

  @override
  String get openpgpSummaryEncrypted => 'Alleen jij en de andere ontvangers kunnen het lezen.';

  @override
  String get openpgpSummaryNotSigned => 'Het is niet ondertekend, dus de afzender is niet bevestigd.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Het is ondertekend, maar met een sleutel die je niet hebt, dus de handtekening kan niet worden gecontroleerd.';

  @override
  String get openpgpSummaryBadSignature => 'De handtekening klopt niet: het bericht is mogelijk gewijzigd.';

  @override
  String get openpgpSummaryMismatch =>
      'De handtekening is geldig, maar de sleutel hoort bij een ander adres dan dat van de afzender.';

  @override
  String get openpgpSummaryPartial =>
      'Slechts een deel van het bericht is ondertekend. Tekst buiten de handtekening (bijvoorbeeld de voettekst van een mailinglijst) staat onder de regel “Unsigned content”, en andere delen van het bericht, zoals bijlagen, vallen er ook niet onder.';

  @override
  String get openpgpSummaryOwnKey => 'Ondertekend met je eigen sleutel.';

  @override
  String get openpgpSummaryVerified =>
      'De handtekening is geldig en je hebt de vingerafdruk van de sleutel geverifieerd.';

  @override
  String get openpgpSummaryUnverified =>
      'De handtekening is geldig. Je hebt de sleutel geaccepteerd zonder de vingerafdruk te controleren.';

  @override
  String get openpgpSummaryRejected => 'De handtekening is geldig, maar je hebt deze sleutel geweigerd.';

  @override
  String get openpgpSummaryUndecided =>
      'De handtekening is geldig, maar je hebt deze sleutel nog niet geaccepteerd. Vergelijk de vingerafdruk met de afzender.';

  @override
  String get openpgpAcceptanceRejected => 'Geweigerd';

  @override
  String get openpgpAcceptanceUndecided => 'Niet geaccepteerd';

  @override
  String get openpgpAcceptanceUnverified => 'Geaccepteerd';

  @override
  String get openpgpAcceptanceVerified => 'Geaccepteerd en geverifieerd';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Sleutel van $name accepteren?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Vingerafdruk $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ja, ik heb de vingerafdruk geverifieerd';

  @override
  String get openpgpAcceptUnverified => 'Ja, zonder te controleren';

  @override
  String get openpgpAcceptLater => 'Nog niet';

  @override
  String get openpgpRejectKey => 'Deze sleutel weigeren';

  @override
  String get openpgpNoSubject => '(geen onderwerp)';

  @override
  String get openpgpEncryptionTitle => 'End-to-end-versleuteling';

  @override
  String get openpgpMyKeys => 'Mijn OpenPGP-sleutels';

  @override
  String get openpgpMyKeysFooter =>
      'Met een sleutel kun je versleutelde mail lezen en je eigen mail ondertekenen en versleutelen. Gebruik je Thunderbird? Exporteer je sleutel daar (Accountinstellingen › End-to-end-versleuteling › Reservekopiebestand van geheime sleutel maken) en importeer hem hier.';

  @override
  String get openpgpAddKey => 'Sleutel toevoegen…';

  @override
  String get openpgpAddresses => 'Adressen';

  @override
  String get openpgpAddressesFooter => 'Welke sleutel elk adres gebruikt, en wanneer het versleutelt en ondertekent.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP-sleutels van contacten';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Accepteer een sleutel zodra je erop vertrouwt dat hij van de eigenaar is; vergelijk de vingerafdruk met die persoon om hem als geverifieerd te markeren.';

  @override
  String get openpgpImportPublicKey => 'Publieke sleutel importeren…';

  @override
  String get openpgpCollected => 'Verzameld via Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Sleutels die met berichten zijn meegekomen. Loupe kan ernaar versleutelen als beide kanten erom vragen.';

  @override
  String get openpgpOnThisDevice => 'Op dit apparaat';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Versleutelde berichten verbergen hun onderwerp. Loupe bewaart het onderwerp van elk bericht dat je opent in de versleutelde database op dit apparaat, zodat de lijst, zoeken en meldingen het tonen. Op de achtergrond kan Loupe met sleutels zonder wachtwoordzin ook de onderwerpen van nieuwe berichten ontsleutelen; daarvoor downloadt het elk bericht (tot 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Onderwerpen op de achtergrond ontsleutelen';

  @override
  String get openpgpIndexFooter =>
      'Zoeken vindt versleutelde berichten op afzender, ontvangers en onderwerp. Als dit aan staat, voegt Loupe ook de tekst van elk versleuteld bericht dat het ontsleutelt toe aan de zoekindex in de versleutelde database op dit apparaat, zodat zoeken het ook op tekst vindt. Uitschakelen verwijdert die tekst uit de index.';

  @override
  String get openpgpIndexDecrypted => 'Ontsleutelde berichten indexeren voor zoeken';

  @override
  String get openpgpPassphrases => 'Wachtwoordzinnen';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-sleutels en S/MIME-certificaten die je met een wachtwoordzin beveiligt, worden ontgrendeld wanneer dat nodig is. Zonder “Wachtwoordzinnen onthouden” worden ze twee minuten na elk gebruik weer vergrendeld.';

  @override
  String get openpgpRememberPassphrases => 'Wachtwoordzinnen onthouden';

  @override
  String get openpgpRememberPassphrasesDetail => 'Tot Loupe wordt gesloten';

  @override
  String get openpgpLockKeysNow => 'Sleutels nu vergrendelen';

  @override
  String get openpgpKeysLocked => 'Sleutels vergrendeld.';

  @override
  String get openpgpKeyStateRevoked => 'ingetrokken';

  @override
  String get openpgpKeyStateExpired => 'verlopen';

  @override
  String get openpgpKeyStateNeverExpires => 'verloopt nooit';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'verloopt op $date';
  }

  @override
  String get openpgpNoKey => 'Geen sleutel';

  @override
  String get openpgpAlwaysEncrypt => 'Altijd versleutelen';

  @override
  String get openpgpAddKeyTitle => 'OpenPGP-sleutel toevoegen';

  @override
  String get openpgpAddKeyMessage => 'Importeer de sleutel die je in Thunderbird gebruikt, of maak een nieuwe.';

  @override
  String get openpgpImportFromClipboard => 'Importeren vanaf klembord';

  @override
  String get openpgpImportFromFile => 'Importeren uit bestand';

  @override
  String get openpgpGenerateNewKey => 'Nieuwe sleutel genereren';

  @override
  String get openpgpImportPublicKeyTitle => 'Publieke sleutel importeren';

  @override
  String get openpgpFromClipboard => 'Vanaf klembord';

  @override
  String get openpgpFromFile => 'Uit bestand';

  @override
  String get openpgpClipboardEmpty => 'Het klembord is leeg. Kopieer eerst de sleutel.';

  @override
  String get openpgpKey => 'Sleutel';

  @override
  String get openpgpValidityRevoked => 'Ingetrokken';

  @override
  String openpgpValidityExpired(String date) {
    return 'Verlopen op $date';
  }

  @override
  String get openpgpNeverExpires => 'Verloopt nooit';

  @override
  String openpgpValidUntil(String date) {
    return 'Geldig tot $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Vingerafdruk gekopieerd.';

  @override
  String get openpgpAlgorithm => 'Algoritme';

  @override
  String get openpgpCreated => 'Aangemaakt';

  @override
  String get openpgpValidity => 'Geldigheid';

  @override
  String get openpgpProtection => 'Beveiliging';

  @override
  String get openpgpProtectionPassphrase => 'Wachtwoordzin';

  @override
  String get openpgpProtectionKeychain => 'Alleen sleutelhanger';

  @override
  String get openpgpKeyDetailsFooter =>
      'Deel je publieke sleutel zodat anderen naar jou kunnen versleutelen. De back-up is je geheime sleutel, beschermd met de wachtwoordzin als die er is: houd hem privé.';

  @override
  String get openpgpSharePublicKey => 'Publieke sleutel delen';

  @override
  String get openpgpCopyPublicKey => 'Publieke sleutel kopiëren';

  @override
  String get openpgpPublicKeyCopied => 'Publieke sleutel gekopieerd.';

  @override
  String get openpgpBackUpSecretKey => 'Back-up van geheime sleutel maken';

  @override
  String get openpgpDeleteKey => 'Sleutel verwijderen';

  @override
  String get openpgpRemoveKey => 'Sleutel verwijderen';

  @override
  String get openpgpBackUpTitle => 'Back-up van geheime sleutel maken?';

  @override
  String get openpgpBackUpProtected =>
      'De back-up is beschermd met de wachtwoordzin van je sleutel. Iedereen die beide heeft, kan je mail lezen.';

  @override
  String get openpgpBackUpUnprotected =>
      'Deze sleutel heeft geen wachtwoordzin: iedereen met de back-up kan je mail lezen en namens jou ondertekenen.';

  @override
  String get openpgpBackUp => 'Back-up maken';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Je sleutel $name verwijderen?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Sleutel van $name verwijderen?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Mail die naar deze sleutel is versleuteld, kan op dit apparaat niet meer worden gelezen, tenzij je hem opnieuw importeert.';

  @override
  String get openpgpRemoveKeyMessage => 'Je kunt hem later opnieuw importeren.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-sleutel';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Voeg een sleutel toe in End-to-end-versleuteling om mail van dit adres te versleutelen en te ondertekenen.';

  @override
  String get openpgpGenerateAKey => 'Sleutel genereren…';

  @override
  String get openpgpSending => 'Verzenden';

  @override
  String get openpgpSendingFooter =>
      'Automatische versleuteling gaat aan als elke ontvanger een geaccepteerde sleutel of een vertrouwd certificaat heeft, of als Autocrypt aangeeft dat beide kanten het willen. Versleutelde mail wordt altijd ondertekend.';

  @override
  String get openpgpEncryptAutomatically => 'Automatisch versleutelen';

  @override
  String get openpgpAlwaysEncryptDetail => 'Weigert te verzenden als een ontvanger geen sleutel heeft';

  @override
  String get openpgpSignUnencrypted => 'Onversleutelde mail ondertekenen';

  @override
  String get openpgpAttachPublicKey => 'Mijn publieke sleutel bijvoegen';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt stuurt je publieke sleutel mee met elk bericht, zodat andere apps zonder instellen naar jou kunnen versleutelen.';

  @override
  String get openpgpSendMyKey => 'Mijn sleutel met mail meesturen';

  @override
  String get openpgpPreferEncryption => 'Voorkeur voor versleuteling';

  @override
  String get openpgpPreferEncryptionDetail => 'Anderen vragen te versleutelen wanneer dat kan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count jaar', one: '$count jaar');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'De wachtwoordzinnen komen niet overeen.';

  @override
  String openpgpKeyReady(String id) {
    return 'Je sleutel $id is klaar.';
  }

  @override
  String get openpgpNewKey => 'Nieuwe sleutel';

  @override
  String get openpgpNewKeyFor => 'Voor';

  @override
  String get openpgpYourName => 'Je naam';

  @override
  String get openpgpAddress => 'Adres';

  @override
  String get openpgpPassphrase => 'Wachtwoordzin';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Optioneel. Zonder wachtwoordzin beschermt alleen de sleutelhanger van je telefoon de sleutel en vraagt Loupe er nooit om. Met een wachtwoordzin vraagt Loupe erom wanneer de sleutel nodig is.';

  @override
  String get openpgpRepeatPassphrase => 'Herhalen';

  @override
  String get openpgpExpires => 'Verloopt';

  @override
  String get openpgpExpiresFooter =>
      'Je kunt een nieuwe sleutel maken voordat deze verloopt. Thunderbird gebruikt ook drie jaar.';

  @override
  String get openpgpGenerateKey => 'Sleutel genereren';

  @override
  String get openpgpKeyFor => 'Sleutel voor';

  @override
  String get openpgpCantEncrypt => 'Kan niet versleutelen';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Er is geen OpenPGP-sleutel voor $names, en dit adres versleutelt altijd. Verwijder de ontvanger of importeer de sleutel via Instellingen › End-to-end-versleuteling.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Er is geen geldig S/MIME-certificaat voor $names, en dit adres versleutelt altijd. Verwijder de ontvanger of importeer het certificaat via Instellingen › End-to-end-versleuteling.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Er is geen OpenPGP-sleutel voor $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Er is geen geldig S/MIME-certificaat voor $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Onversleuteld verzenden';

  @override
  String get openpgpCantSign => 'Kan niet ondertekenen';

  @override
  String get openpgpCantSignMessage =>
      'De privésleutel van je S/MIME-certificaat staat niet op dit apparaat. Importeer het certificaat opnieuw (een .p12- of .pfx-bestand) via Instellingen › End-to-end-versleuteling.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Geen sleutel voor $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Geen certificaat voor $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Sleutels uit Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Iedereen heeft een sleutel';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Iedereen heeft een certificaat';

  @override
  String get openpgpComposeEncrypt => 'Versleutelen';

  @override
  String get openpgpComposeSign => 'Ondertekenen';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, wisselen';
  }

  @override
  String get openpgpNoKeyFound => 'Geen OpenPGP-sleutel gevonden.';

  @override
  String get openpgpImportSecretKeyTitle => 'Geheime sleutel importeren?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Deze bijlage bevat een geheime sleutel ($names). Importeer hem alleen als je eigen sleutel als je hem zelf hebt geëxporteerd, bijvoorbeeld uit Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importeren als mijn sleutel';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'je sleutel $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sleutels importeren ($names)?',
      one: 'Sleutel van $names importeren?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importeren en accepteren';

  @override
  String get openpgpImportDecideLater => 'Importeren, later beslissen';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'sleutel van $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Geïmporteerd: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Er zijn $count OpenPGP-sleutels bijgevoegd.',
      one: 'Er is een OpenPGP-sleutel bijgevoegd.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importeren';

  @override
  String get openpgpUnlockKeyTitle => 'OpenPGP-sleutel ontgrendelen';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Voer de wachtwoordzin in van de sleutel van $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Die wachtwoordzin is onjuist. Probeer het opnieuw.';

  @override
  String get openpgpExplainLocked => 'Dit bericht is versleuteld. Ontgrendel je OpenPGP-sleutel om het te lezen.';

  @override
  String get openpgpExplainNoKey =>
      'Dit bericht is versleuteld, maar niet voor een OpenPGP-sleutel op dit apparaat. Lees je het in Thunderbird, importeer je sleutel dan daarvandaan: Instellingen › End-to-end-versleuteling.';

  @override
  String get openpgpExplainDamaged =>
      'Dit versleutelde bericht is beschadigd en kan daarom niet veilig worden ontsleuteld.';

  @override
  String get openpgpExplainUnsupported => 'Dit bericht gebruikt versleuteling die Loupe nog niet kan lezen.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Dit bericht is versleuteld met S/MIME, maar niet voor een certificaat op dit apparaat. Importeer je certificaat (een .p12- of .pfx-bestand) via Instellingen › End-to-end-versleuteling.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Dit bericht is versleuteld. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Ontgrendel je S/MIME-certificaat om het te lezen.';

  @override
  String get openpgpAttachmentGone => 'Deze bijlage is niet meer beschikbaar.';

  @override
  String get smimeEncrypted => 'Versleuteld (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Versleuteld (S/MIME) · geen certificaat';

  @override
  String get smimeEncryptedDamaged => 'Versleuteld (S/MIME) · beschadigd';

  @override
  String get smimeEncryptedUnsupported => 'Versleuteld (S/MIME) · niet ondersteund';

  @override
  String get smimeEncryptedLocked => 'Versleuteld (S/MIME) · vergrendeld';

  @override
  String get smimeUnknownSigner => 'onbekend';

  @override
  String get smimeSignatureModified => 'Handtekening ongeldig: bericht gewijzigd';

  @override
  String get smimeSignatureWeak => 'Handtekening onveilig: verouderd algoritme';

  @override
  String get smimeSignatureUncheckable => 'Handtekening kan niet worden gecontroleerd';

  @override
  String get smimeSignedCertificateMissing => 'Ondertekend · certificaat ontbreekt';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Ondertekend door $name · certificaat ingetrokken';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Ondertekend door $name · op een andere datum';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Ondertekend door $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Ondertekend door $name · ongeldig certificaat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Ondertekend door $name · niet vertrouwd';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Ondertekend door $name · certificaat verlopen';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Ondertekend door $name · certificaat nog niet geldig';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Ondertekend door $name · certificaat niet voor mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Ondertekend door $name, niet door de afzender';
  }

  @override
  String get smimeCantDecrypt => 'Kan dit bericht niet ontsleutelen';

  @override
  String get smimeEncryptedWithSmime => 'Versleuteld met S/MIME';

  @override
  String get smimeEncryption => 'Versleuteling';

  @override
  String get smimeDecryptedHere => 'Ontsleuteld op dit apparaat';

  @override
  String get smimeNotDecrypted => 'Niet ontsleuteld';

  @override
  String get smimeAuthenticated => 'geauthenticeerd';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'voor $count certificaten',
      one: 'voor $count certificaat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Handtekening';

  @override
  String get smimeIssuedBy => 'Uitgegeven door';

  @override
  String get smimeValid => 'Geldig';

  @override
  String smimeValidRange(String from, String to) {
    return '$from tot $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-vingerafdruk';

  @override
  String get smimeSigned => 'Ondertekend';

  @override
  String get smimeProblem => 'Probleem';

  @override
  String get smimeCheckingRevocation => 'Intrekking controleren…';

  @override
  String get smimeNotRevoked => 'Niet ingetrokken';

  @override
  String get smimeRevoked => 'Ingetrokken';

  @override
  String get smimeRevocationUnknown => 'Intrekkingsstatus onbekend';

  @override
  String smimeRevokedSince(String date) {
    return 'Sinds $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Gevraagd aan de instantie (intrekkingslijst), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Gevraagd aan de instantie (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return '“$name” vertrouwen…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Dit certificaat vertrouwen…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Op dit apparaat gecontroleerd met S/MIME, compatibel met Outlook en Thunderbird; intrekking bij de certificeringsinstantie.';

  @override
  String get smimeCheckedFooter =>
      'Op dit apparaat gecontroleerd met S/MIME, compatibel met Outlook en Thunderbird. Intrekking wordt niet gecontroleerd (Instellingen › End-to-end-versleuteling).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return '$name vertrouwen voor mail?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Certificaat van $name vertrouwen?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Elk certificaat dat deze instantie uitgeeft, wordt vertrouwd, zoals de CA van je bedrijf. Vergelijk eerst de vingerafdruk met de eigenaar:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Vergelijk eerst de vingerafdruk met de eigenaar:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Vertrouwen';

  @override
  String get smimeSummaryNoKey => 'Het is versleuteld voor een certificaat dat niet op dit apparaat staat.';

  @override
  String get smimeSummaryDamaged => 'De versleutelde gegevens zijn beschadigd of onderweg gewijzigd.';

  @override
  String get smimeSummaryUnsupported => 'Het gebruikt een algoritme dat Loupe niet ondersteunt.';

  @override
  String get smimeSummaryLocked => 'Je S/MIME-certificaat is vergrendeld.';

  @override
  String get smimeSummaryEncrypted => 'Alleen jij en de andere ontvangers kunnen het lezen.';

  @override
  String get smimeSummaryNotSigned => 'Het is niet ondertekend, dus de afzender is niet bevestigd.';

  @override
  String get smimeSummaryModified => 'De handtekening klopt niet: het bericht is na het ondertekenen gewijzigd.';

  @override
  String get smimeSummaryUncheckable => 'De handtekening kan niet worden gecontroleerd.';

  @override
  String get smimeSummaryNoCertificate =>
      'Het certificaat van de ondertekenaar zit niet in het bericht, dus het kan niet worden gecontroleerd.';

  @override
  String get smimeSummaryRevoked =>
      'De certificeringsinstantie heeft het certificaat van de ondertekenaar ingetrokken: de handtekening kan niet worden vertrouwd.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'De certificeringsinstantie heeft het certificaat van de ondertekenaar ingetrokken ($reason): de handtekening kan niet worden vertrouwd.';
  }

  @override
  String get smimeDateMismatch =>
      'Het is meer dan een uur voor of na de datum van het bericht ondertekend: het kan een oud bericht zijn dat opnieuw is verzonden.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'De handtekening is geldig en $issuer staat ervoor in dat het certificaat van de afzender is.';
  }

  @override
  String get smimeProblemInvalidChain => 'Het certificaat of een van de uitgevers ervan is ongeldig.';

  @override
  String get smimeProblemUntrusted => 'Het certificaat komt van een instantie die Loupe niet vertrouwt.';

  @override
  String get smimeProblemExpired => 'Het certificaat was verlopen.';

  @override
  String get smimeProblemNotYetValid => 'Het certificaat was nog niet geldig.';

  @override
  String get smimeProblemWrongUsage => 'Het certificaat is niet bedoeld voor mail.';

  @override
  String get smimeProblemWrongAddress => 'Het certificaat hoort bij een ander adres dan dat van de afzender.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Vertrouwd · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Niet vertrouwd · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Verlopen op $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Geldig vanaf $date';
  }

  @override
  String get smimeTrustInvalid => 'Ongeldig';

  @override
  String get smimeTrustNotForMail => 'Niet voor mail';

  @override
  String get smimeTrustAnotherAddress => 'Ander adres';

  @override
  String get smimeMyCertificates => 'Mijn S/MIME-certificaten';

  @override
  String get smimeMyCertificatesFooter =>
      'Voor S/MIME, zoals Outlook en veel bedrijven het gebruiken. Importeer je certificaat met de privésleutel (een .p12- of .pfx-bestand), geëxporteerd uit Outlook, Windows, macOS of Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Voor S/MIME, zoals Outlook en veel bedrijven het gebruiken. Importeer je certificaat met de privésleutel (een .p12- of .pfx-bestand), geëxporteerd uit Outlook, Windows, macOS of Thunderbird, of gebruik er een dat je bedrijf of jijzelf op dit apparaat hebt geïnstalleerd.';

  @override
  String get smimeCertificateExpired => 'verlopen';

  @override
  String smimeCertificateUntil(String date) {
    return 'tot $date';
  }

  @override
  String get smimeCertificateOnDevice => 'op dit apparaat';

  @override
  String get smimeImportCertificateEllipsis => 'Certificaat importeren…';

  @override
  String get smimeUseDeviceCertificate => 'Certificaat van dit apparaat gebruiken…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificaten van contacten';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Verzameld uit ondertekende mail, zoals Outlook en Thunderbird dat doen. Mail wordt alleen versleuteld naar vertrouwde certificaten: Loupe vertrouwt de instanties die Mozilla vertrouwt voor e-mail, en de instanties die jij toevoegt.';

  @override
  String get smimeRevocation => 'Intrekking';

  @override
  String get smimeRevocationFooter =>
      'Als je ondertekende mail opent, vraagt Loupe de instantie die het certificaat van de ondertekenaar heeft uitgegeven of het is ingetrokken (via de OCSP-responder of de intrekkingslijst). De instantie kan dan zien wanneer iemand op jouw internetadres mail leest die met dat certificaat is ondertekend. Antwoorden blijven op dit apparaat bewaard tot ze verlopen. Een ingetrokken certificaat staat als “Ingetrokken” in de kop van het bericht.';

  @override
  String get smimeCheckRevocation => 'Intrekking van certificaten online controleren';

  @override
  String get smimeTrustedAuthorities => 'Vertrouwde instanties';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Door jou vertrouwd, naast de $count instanties die Mozilla vertrouwt voor e-mail.',
      one: 'Door jou vertrouwd, naast de $count instantie die Mozilla vertrouwt voor e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certificeringsinstantie';

  @override
  String get smimeImportACertificate => 'Certificaat importeren';

  @override
  String get smimeImportContactMessage =>
      'Het certificaat van een contact (.cer, .crt, .pem) of van een certificeringsinstantie.';

  @override
  String get smimeFromClipboard => 'Vanaf klembord';

  @override
  String get smimeFromFile => 'Uit bestand';

  @override
  String get smimeClipboardEmpty => 'Het klembord is leeg. Kopieer eerst het certificaat.';

  @override
  String get smimeCertificate => 'Certificaat';

  @override
  String get smimeOnDeviceFooter =>
      'De privésleutel blijft in de opslag voor inloggegevens van Android, waar je bedrijf of jijzelf hem heeft geïnstalleerd: Loupe vraagt Android ermee te ondertekenen en te ontsleutelen. Ondertekende mail wordt ondertekend wanneer je hem verstuurt.';

  @override
  String get smimeAddresses => 'Adressen';

  @override
  String get smimeUsage => 'Voor';

  @override
  String get smimeUsageNone => 'Niets wat Loupe gebruikt';

  @override
  String get smimeUsageSigning => 'Ondertekenen';

  @override
  String get smimeUsageEncryption => 'Versleuteling';

  @override
  String get smimeUsageCertificates => 'Certificaten';

  @override
  String get smimeAlgorithm => 'Algoritme';

  @override
  String get smimeSerialNumber => 'Serienummer';

  @override
  String get smimeFingerprintCopied => 'Vingerafdruk gekopieerd.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-vingerafdruk';

  @override
  String get smimePrivateKey => 'Privésleutel';

  @override
  String get smimeKeyOnDevice => 'Op dit apparaat';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'In Loupe, met wachtwoordzin';

  @override
  String get smimeKeyInLoupe => 'In Loupe';

  @override
  String get smimeSource => 'Herkomst';

  @override
  String get smimeSourceSignedMail => 'Ondertekende mail';

  @override
  String get smimeSourceImported => 'Geïmporteerd';

  @override
  String get smimeTrustHeader => 'Vertrouwen';

  @override
  String get smimeTrustedRoot => 'Vertrouwde root';

  @override
  String get smimeIssuer => 'Uitgever';

  @override
  String smimeTrustNamed(String name) {
    return '“$name” vertrouwen';
  }

  @override
  String get smimeTrustThisAuthority => 'Deze instantie vertrouwen';

  @override
  String get smimeTrustThisCertificate => 'Dit certificaat vertrouwen';

  @override
  String get smimeStopTrusting => 'Niet meer vertrouwen';

  @override
  String get smimePassphrase => 'Wachtwoordzin';

  @override
  String get smimePassphraseFooter =>
      'Optioneel. Met een wachtwoordzin wordt de privésleutel op dit apparaat ook versleuteld (Argon2id en AES-256) en vraagt Loupe erom om te ondertekenen en te ontsleutelen; “Wachtwoordzinnen onthouden” bepaalt hoelang. Mail die je verstuurt, wordt bij het verzenden ondertekend; taken op de achtergrond kunnen de sleutel niet gebruiken.';

  @override
  String get smimeChangePassphrase => 'Wachtwoordzin wijzigen…';

  @override
  String get smimeSetPassphraseEllipsis => 'Wachtwoordzin instellen…';

  @override
  String get smimeRemovePassphrase => 'Wachtwoordzin verwijderen';

  @override
  String get smimeShareCertificate => 'Certificaat delen';

  @override
  String get smimeDeleteCertificate => 'Certificaat verwijderen';

  @override
  String get smimeRemoveCertificate => 'Certificaat verwijderen';

  @override
  String get smimePassphraseChanged => 'Wachtwoordzin gewijzigd.';

  @override
  String get smimePassphraseSet => 'Wachtwoordzin ingesteld.';

  @override
  String get smimeRemovePassphraseTitle => 'Wachtwoordzin verwijderen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'De privésleutel wordt dan alleen door de sleutelhanger beschermd, zoals zonder wachtwoordzin: Loupe vraagt er niet meer om en taken op de achtergrond kunnen hem gebruiken.';

  @override
  String get smimePassphraseRemoved => 'Wachtwoordzin verwijderd.';

  @override
  String smimeTrustTitle(String name) {
    return '$name vertrouwen?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Elk certificaat dat ze uitgeeft, wordt vertrouwd voor mail. Vergelijk eerst de vingerafdruk met de eigenaar:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Je certificaat $name verwijderen?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Certificaat van $name verwijderen?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe gebruikt het niet meer: mail die ernaar is versleuteld, kan niet meer in Loupe worden gelezen. Het certificaat blijft op dit apparaat (Instellingen › Beveiliging › Versleuteling en inloggegevens).';

  @override
  String get smimeDeleteOwnMessage =>
      'De privésleutel wordt van dit apparaat verwijderd: mail die ernaar is versleuteld, kan hier niet meer worden gelezen, tenzij je het opnieuw importeert.';

  @override
  String get smimeRemoveContactMessage => 'Het komt terug met het volgende ondertekende bericht van die persoon.';

  @override
  String get smimeAddressImportFooter =>
      'Importeer een certificaat voor dit adres om, net als Outlook, met S/MIME te ondertekenen en te versleutelen.';

  @override
  String get smimeImportACertificateEllipsis => 'Certificaat importeren…';

  @override
  String get smimePreferFooter =>
      'Als beide een bericht kunnen beveiligen, wordt de voorkeur gebruikt, tenzij alleen de andere een sleutel of certificaat voor elke ontvanger heeft.';

  @override
  String get smimePreferSmime => 'Voorkeur voor S/MIME';

  @override
  String get smimePreferSmimeDetail => 'In plaats van OpenPGP';

  @override
  String get smimeCertificatePassword => 'Certificaatwachtwoord';

  @override
  String get smimeCertificatePasswordPrompt => 'Voer het wachtwoord in waarmee het certificaatbestand is geëxporteerd.';

  @override
  String get smimeImport => 'Importeren';

  @override
  String get smimeWrongPassword => 'Dat wachtwoord is onjuist. Probeer het opnieuw.';

  @override
  String get smimeNoCertificateFound => 'Geen certificaat gevonden.';

  @override
  String smimeCertificateOf(String name) {
    return 'certificaat van $name';
  }

  @override
  String get smimeNothingNew => 'Niets nieuws om te importeren.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Geïmporteerd: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vertrouwde instanties geïmporteerd.',
      one: 'Een vertrouwde instantie geïmporteerd.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Geïmporteerd: $certificates en $count vertrouwde instanties.',
      one: 'Geïmporteerd: $certificates en een vertrouwde instantie.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Dit bestand bevat geen privésleutel. Exporteer je certificaat met de privésleutel.';

  @override
  String get smimeImportAsYoursTitle => 'Importeren als je eigen certificaat?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Deze bijlage bevat een certificaat met de privésleutel: $names. Importeer het alleen als je het zelf hebt geëxporteerd, bijvoorbeeld uit Outlook of Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importeren als mijn certificaat';

  @override
  String smimeImportedOwn(String names) {
    return 'Je certificaat $names is geïmporteerd.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Je certificaat $name ($addresses) is toegevoegd vanaf dit apparaat.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return '“$name” vertrouwen voor mail?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe kent deze certificeringsinstantie niet (misschien die van een bedrijf zelf). Vertrouw haar om de certificaten te controleren die ze uitgeeft. Vergelijk eerst de vingerafdruk met je IT-afdeling:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Er zijn $count certificaten bijgevoegd.',
      one: 'Er is een certificaat bijgevoegd.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Certificaat importeren';

  @override
  String get smimeUnlockTitle => 'S/MIME-certificaat ontgrendelen';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Voer de wachtwoordzin in van het certificaat van $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Die wachtwoordzin is onjuist. Probeer het opnieuw.';

  @override
  String get smimeUnlock => 'Ontgrendelen';

  @override
  String get smimeEnterAPassphrase => 'Voer een wachtwoordzin in.';

  @override
  String get smimePassphrasesDiffer => 'De twee wachtwoordzinnen verschillen.';

  @override
  String get smimeSetPassphraseTitle => 'Wachtwoordzin instellen';

  @override
  String get smimeSetPassphraseText =>
      'Loupe vraagt erom om te ondertekenen en te ontsleutelen. Vergeet je hem, importeer het certificaat dan opnieuw uit het .p12-bestand.';

  @override
  String get smimePassphraseAgain => 'Nogmaals';

  @override
  String get smimeSetPassphraseButton => 'Instellen';

  @override
  String get smimeLockedOpenAgain =>
      'Je S/MIME-certificaat is vergrendeld. Open het bericht opnieuw om het te ontgrendelen.';

  @override
  String get smimeDeviceHasNoCertificates => 'Dit apparaat biedt zijn certificaten niet aan.';

  @override
  String get smimeCantReadCertificate => 'Loupe kan dit certificaat niet lezen.';

  @override
  String get smimeCertificateNotForMail =>
      'Dit certificaat is niet voor mail: het heeft geen e-mailadres of is niet bedoeld om te ondertekenen of te versleutelen.';

  @override
  String get smimeDeviceCertificateGone =>
      'Het certificaat staat niet meer op dit apparaat, of Loupe mag het niet meer gebruiken. Kies het opnieuw in Instellingen › End-to-end-versleuteling.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Het certificaat op dit apparaat kan alleen worden gebruikt terwijl Loupe open is.';

  @override
  String get smimeDeviceKeyDamaged => 'De versleutelde sleutel is beschadigd.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Het certificaat op dit apparaat kan dit niet: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'niet ondersteund';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Het certificaat op dit apparaat is mislukt: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Het adres van de instantie is geen webadres.';

  @override
  String get smimeAuthorityTimeout => 'De certificeringsinstantie heeft niet op tijd geantwoord.';

  @override
  String get smimeAuthorityUnreachable => 'De certificeringsinstantie was niet bereikbaar.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'De certificeringsinstantie antwoordde met $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Het antwoord van de certificeringsinstantie is te groot.';

  @override
  String get smimeRevocationNotChecked =>
      'Niet gecontroleerd: alleen certificaten van een instantie die Loupe vertrouwt, worden gecontroleerd.';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Zelfde als telefoon';

  @override
  String get settingsLanguageFooter =>
      'Loupe gebruikt de taal van je telefoon als het die heeft, en anders Engels. De taal die je hier kiest, geldt alleen voor Loupe, meldingen inbegrepen.';

  @override
  String get settingsAccountsHeader => 'Accounts';

  @override
  String get settingsAddAccount => 'Account toevoegen';

  @override
  String get settingsMailHeader => 'Mail';

  @override
  String get settingsSwipeActions => 'Veegacties';

  @override
  String get settingsSwipeLeft => 'Naar links vegen';

  @override
  String get settingsSwipeLeftFooter =>
      'Helemaal vegen voert deze actie uit. Markeren en Meer zijn altijd met een korte veeg bereikbaar.';

  @override
  String get settingsSwipeRight => 'Naar rechts vegen';

  @override
  String get settingsSwipeRightFooter => 'Helemaal vegen voert deze actie uit.';

  @override
  String get settingsSwipeToggleRead => 'Markeren als gelezen/ongelezen';

  @override
  String get settingsSwipeTrash => 'Naar prullenbak';

  @override
  String get settingsSwipeMove => 'Bericht verplaatsen';

  @override
  String get settingsSwipeSnooze => 'Snoozen';

  @override
  String get settingsThreaded => 'Ordenen per gesprek';

  @override
  String get settingsUndoSendDelay => 'Tijd om verzenden ongedaan te maken';

  @override
  String get settingsUndoSendDelayFooter => 'Verzonden berichten wachten zo lang, zodat je ze kunt terughalen.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds seconden',
      one: '$seconds seconde',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Weergave';

  @override
  String get settingsTheme => 'Thema';

  @override
  String get settingsThemeSystem => 'Automatisch';

  @override
  String get settingsThemeLight => 'Licht';

  @override
  String get settingsThemeDark => 'Donker';

  @override
  String get settingsDensity => 'Berichtenlijst';

  @override
  String get settingsDensityComfortable => 'Ruim';

  @override
  String get settingsDensityCompact => 'Compact';

  @override
  String get settingsReadingHeader => 'Lezen';

  @override
  String get settingsReadingFooter =>
      'Externe afbeeldingen kunnen afzenders laten weten wanneer en waar je een bericht hebt geopend.';

  @override
  String get settingsDefaultView => 'Standaardweergave';

  @override
  String get settingsDefaultViewFooter => 'Je kunt elk bericht omschakelen met de knop Aa.';

  @override
  String get settingsViewReadable => 'Leesbaar';

  @override
  String get settingsViewReadableDetail => 'Rustig, goed leesbaar, volgt de donkere modus';

  @override
  String get settingsViewOriginal => 'Origineel';

  @override
  String get settingsViewOriginalDetail => 'Precies zoals de afzender het heeft ontworpen';

  @override
  String get settingsViewPlain => 'Platte tekst';

  @override
  String get settingsViewPlainDetail => 'Alleen de woorden';

  @override
  String get settingsPlainTextFont => 'Lettertype voor platte tekst';

  @override
  String get settingsFontSans => 'Schreefloos';

  @override
  String get settingsFontMono => 'Vaste breedte';

  @override
  String get settingsFontMonoDetail => 'Houdt ASCII-art en tabellen uitgelijnd';

  @override
  String get settingsTechnicalLists => 'Technische lijsten';

  @override
  String get settingsLoadRemoteImages => 'Externe afbeeldingen laden';

  @override
  String get settingsOpenLinksDirectly => 'Links direct openen';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Kliktrackers overslaan als de bestemming bekend is';

  @override
  String get settingsSecurityHeader => 'Beveiliging';

  @override
  String get settingsAppLock => 'App-vergrendeling';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe vraagt erom bij het starten, en als je terugkomt na de tijd bij Vergrendelen na.';

  @override
  String get settingsAppLockFooterOff =>
      'App-vergrendeling vraagt om je vingerafdruk, gezicht of schermvergrendeling voordat je mail wordt getoond.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'App-vergrendeling staat nog uit. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Toegangscode instellen';

  @override
  String get settingsScreenLockTextIos =>
      'App-vergrendeling gebruikt Face ID, Touch ID of je toegangscode, en deze iPhone heeft geen toegangscode. Stel er een in via de app Instellingen en schakel daarna app-vergrendeling in.';

  @override
  String get settingsScreenLockTitleAndroid => 'Schermvergrendeling instellen';

  @override
  String get settingsScreenLockTextAndroid =>
      'App-vergrendeling gebruikt de schermvergrendeling van je telefoon, of een vingerafdruk of gezicht dat eraan is toegevoegd, en deze telefoon heeft er geen. Stel een pincode, patroon of wachtwoord in via de Android-instellingen en schakel daarna app-vergrendeling in.';

  @override
  String get settingsOpenSystemSettings => 'Instellingen openen';

  @override
  String get settingsOpenAndroidSettings => 'Android-instellingen openen';

  @override
  String get settingsLockAfter => 'Vergrendelen na';

  @override
  String get settingsLockAfterFooter => 'Hoelang Loupe op de achtergrond kan zijn voordat het opnieuw vraagt.';

  @override
  String get settingsNotifications => 'Meldingen';

  @override
  String get settingsEncryption => 'End-to-end-versleuteling';

  @override
  String get settingsAdvanced => 'Geavanceerd';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demomail is een verzonnen mailbox die alleen op deze telefoon bestaat. Er wordt niets verstuurd.';

  @override
  String get settingsDemoMode => 'Demomodus';

  @override
  String get settingsResetApp => 'App resetten';

  @override
  String get settingsResetFooter => 'Vergeet alle instellingen en gaat terug naar het welkomstscherm.';

  @override
  String get settingsResetTitle => 'Loupe resetten?';

  @override
  String get settingsResetMessage =>
      'Hiermee worden alle instellingen, Smart Mailboxes en recente zoekopdrachten vergeten en ga je terug naar het welkomstscherm.';

  @override
  String get settingsAboutHeader => 'Over';

  @override
  String get settingsVersion => 'Versie';

  @override
  String get settingsLicences => 'Licenties';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyDetail =>
      'Loupe heeft geen analytics en geen tracking. Je mail gaat alleen naar je mailservers.';

  @override
  String get settingsNotificationsOffIos => 'Meldingen voor Loupe staan uit in Instellingen.';

  @override
  String get settingsNotificationsOffAndroid => 'Meldingen voor Loupe staan uit in de Android-instellingen.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system staat niet toe dat Loupe meldingen toont. Sta ze toe in Instellingen.';
  }

  @override
  String get settingsNewMailHeader => 'Nieuwe mail';

  @override
  String get settingsNewMailFooterDemo =>
      'Demomail komt niet op de achtergrond binnen. Stuur een testmelding om te zien hoe nieuwe mail eruitziet.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe controleert op de achtergrond op nieuwe mail wanneer iOS dat toestaat, wat voor apps die je niet vaak opent uren uit elkaar kan liggen. Je krijgt een melding van nieuwe berichten in je inboxen, en van VIP’s in elke map.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe controleert ongeveer elke 15 minuten op nieuwe mail, als Android dat toestaat. Je krijgt een melding van nieuwe berichten in je inboxen, en van VIP’s in elke map.';

  @override
  String get settingsNoAccounts => 'Geen accounts';

  @override
  String get settingsVipOnly => 'Alleen VIP';

  @override
  String get settingsVipOnlyDetail => 'Alleen berichten van je VIP’s';

  @override
  String get settingsHideContent => 'Inhoud verbergen';

  @override
  String get settingsHideContentFooterOn =>
      'Meldingen tonen alleen “Nieuw bericht van” en het account, niet wie het schreef of waarover.';

  @override
  String get settingsHideContentFooterOff =>
      'Inhoud verbergen houdt de afzender, het onderwerp en de voorvertoning van het vergrendelscherm en uit meldingen.';

  @override
  String get settingsBackgroundAppRefresh => 'Ververs op achtergrond';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nieuwe mail komt alleen op de achtergrond binnen als Ververs op achtergrond voor Loupe aanstaat in Instellingen. iOS kan geen verbinding met je inboxen openhouden, dus er is geen directe bezorging.';

  @override
  String get settingsInstantDelivery => 'Directe bezorging';

  @override
  String get settingsInstantDeliveryFooter =>
      'Directe bezorging (experimenteel) houdt een verbinding met je inboxen open, zodat nieuwe mail binnen enkele seconden binnenkomt. Het toont een rustige melding “Wacht op nieuwe mail” en verbruikt meer batterij.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android kan directe bezorging stoppen om batterij te sparen. Sta Loupe onbeperkt batterijgebruik toe om het actief te houden.';

  @override
  String get settingsExperimental => 'Experimenteel';

  @override
  String get settingsComingSoon => 'Binnenkort';

  @override
  String get settingsAllowUnrestrictedBattery => 'Onbeperkt batterijgebruik toestaan';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Met push wekt nieuwe mail Loupe meteen, waar je maildienst dat ondersteunt. Pushberichten gaan via de pushdienst van Google en bevatten geen mail, alleen “kijk nu”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Deze telefoon kan geen pushberichten ontvangen: daarvoor zijn Google Play-services en een netwerkverbinding nodig. Loupe controleert nog steeds ongeveer elke 15 minuten op nieuwe mail.';

  @override
  String get settingsCopyPushToken => 'Pushtoken kopiëren';

  @override
  String get settingsPushTokenCopied => 'Pushtoken gekopieerd';

  @override
  String get settingsSendTestNotification => 'Testmelding sturen';

  @override
  String get settingsAppIconBadge => 'Badge op app-icoon';

  @override
  String get settingsBadgeNote => 'De badge wordt bijgewerkt wanneer Loupe op mail controleert, ook op de achtergrond.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Het startscherm van deze telefoon toont geen getallen op app-iconen. De badge wordt bijgewerkt wanneer Loupe op mail controleert, ook op de achtergrond.';

  @override
  String get settingsTestNotificationBody => 'Zo zien meldingen voor nieuwe mail eruit.';

  @override
  String get settingsAccountRemoved => 'Dit account is verwijderd.';

  @override
  String get settingsAccountHeader => 'Account';

  @override
  String get settingsAccountDescription => 'Beschrijving';

  @override
  String get settingsAccountDescriptionHint => 'Werk, Privé…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Kleur';

  @override
  String get settingsColourFooter => 'Markeert de berichten van dit account in Alle inboxen.';

  @override
  String settingsColourNumber(int number) {
    return 'Kleur $number';
  }

  @override
  String get settingsSendingHeader => 'Verzenden';

  @override
  String get settingsSendingFooter =>
      'Elke identiteit heeft een eigen handtekening. Antwoorden worden verzonden vanaf het adres waar een bericht naartoe is gestuurd.';

  @override
  String get settingsFoldersHeader => 'Mappen';

  @override
  String get settingsFoldersFooter =>
      'Loupe toont en synchroniseert de mappen waarop je bent geabonneerd, net als Thunderbird. Inbox, Concepten, Verzonden, Spam, Prullenbak en Archief worden altijd getoond.';

  @override
  String get settingsShowAllFolders => 'Alle mappen tonen';

  @override
  String get settingsIncoming => 'Inkomend';

  @override
  String get settingsOutgoing => 'Uitgaand';

  @override
  String get settingsConnectionNotEncrypted => 'Niet versleuteld';

  @override
  String get settingsSignIn => 'Inloggen';

  @override
  String get settingsSignInExpired => 'Verlopen';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider accepteert de aanmelding van Loupe voor dit account niet meer, dus de mail wordt niet gesynchroniseerd. Log opnieuw in om dit op te lossen.';
  }

  @override
  String get settingsSignInAgain => 'Opnieuw inloggen';

  @override
  String get settingsSigningIn => 'Inloggen…';

  @override
  String get settingsRemoveAccount => 'Account verwijderen';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '“$account” verwijderen?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'De mail en instellingen worden van deze telefoon verwijderd. Op de server wordt niets verwijderd.';

  @override
  String get settingsManageFolders => 'Mappen beheren';

  @override
  String get settingsNoFolders => 'Nog geen mappen.';

  @override
  String get settingsManageFoldersFooter =>
      'Mappen waarop je bent geabonneerd, verschijnen op het scherm Mailboxen en worden op de achtergrond gesynchroniseerd. Andere mailapps met hetzelfde account volgen deze abonnementen meestal ook.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Bewaart je Smart Mailboxes voor je andere apparaten. Verborgen op het scherm Mailboxen.';

  @override
  String get settingsFolderAlwaysShown => 'Altijd getoond';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abonneren op $folder';
  }

  @override
  String get settingsIdentities => 'Identiteiten';

  @override
  String get settingsIdentitiesFooterReorder =>
      'De eerste identiteit is de standaard voor nieuwe berichten. Sleep om de volgorde te wijzigen.';

  @override
  String get settingsIdentitiesFooterSingle => 'De standaardidentiteit voor nieuwe berichten.';

  @override
  String get settingsIdentitiesReplyFooter =>
      'Een antwoord wordt verzonden vanaf de identiteit waar het bericht naartoe is gestuurd.';

  @override
  String get settingsIdentityDefault => 'Standaard';

  @override
  String settingsIdentityReorder(String email) {
    return '$email verplaatsen';
  }

  @override
  String get settingsAddIdentity => 'Identiteit toevoegen';

  @override
  String get settingsNewIdentity => 'Nieuwe identiteit';

  @override
  String get settingsIdentity => 'Identiteit';

  @override
  String get settingsIdentityNameHint => 'Je naam';

  @override
  String get settingsReplyTo => 'Antwoord aan';

  @override
  String get settingsSignature => 'Handtekening';

  @override
  String get settingsSignatureFooter => 'Wordt onder “-- ” toegevoegd in berichten van deze identiteit.';

  @override
  String get settingsNoSignature => 'Geen handtekening';

  @override
  String get settingsCopyToMyself => 'Kopie naar mezelf';

  @override
  String get settingsCopyToMyselfFooter => 'Wordt toegevoegd aan elk bericht van deze identiteit.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Gebruiken voor antwoorden aan';

  @override
  String get settingsReplyPatternsFooter =>
      'Antwoorden op berichten aan deze adressen worden verzonden vanaf deze identiteit. * staat voor alles: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Een adres, of een patroon waarin * voor alles staat.';

  @override
  String get settingsAddReplyPattern => 'Adres of patroon toevoegen';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return '$pattern verwijderen';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ongeldig patroon';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” is geen adres en geen patroon zoals *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Geen adres';

  @override
  String get settingsIdentityNoAddressMessage => 'Voer het e-mailadres in waarvandaan je wilt verzenden.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ongeldig adres';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Antwoord aan-adres “$address” is geen geldig e-mailadres.',
      'cc': 'Cc-adres “$address” is geen geldig e-mailadres.',
      'bcc': 'Bcc-adres “$address” is geen geldig e-mailadres.',
      'other': '“$address” is geen geldig e-mailadres.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Identiteit opslaan';

  @override
  String get settingsDiscardChanges => 'Wijzigingen negeren';

  @override
  String get settingsDeleteIdentity => 'Identiteit verwijderen';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '“$email” verwijderen?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Berichten die er al mee zijn verzonden, blijven zoals ze zijn.';

  @override
  String get settingsLastIdentityFooter => 'Een account heeft minstens één identiteit nodig.';

  @override
  String get rulesTitle => 'Regels';

  @override
  String get rulesNewRule => 'Nieuwe regel';

  @override
  String get rulesLoadError => 'Kan de regels niet laden.';

  @override
  String get rulesEmptyTitle => 'Geen regels';

  @override
  String get rulesEmptyText =>
      'Regels sorteren, taggen en markeren nieuwe mail voor je. Maak er een met de knop hierboven, of vanuit een zoekopdracht met “Er een regel van maken”.';

  @override
  String get rulesListFooter =>
      'Regels worden van boven naar beneden uitgevoerd op nieuwe mail in de inbox. Houd een regel ingedrukt om hem te verplaatsen.';

  @override
  String get rulesChangeError => 'Kan de regel niet wijzigen';

  @override
  String get rulesConditionEveryMessage => 'Elk bericht';

  @override
  String rulesMoveRule(String rule) {
    return '$rule verplaatsen';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule aan';
  }

  @override
  String get rulesServerRulesHeader => 'Serverregels';

  @override
  String get rulesServerRulesFooter =>
      'Serverregels draaien op de mailserver wanneer mail binnenkomt, ook als deze telefoon uit staat. Ze staan in een Sieve-script met de naam “loupe”.';

  @override
  String get rulesStatusUnknown => 'Onbekend';

  @override
  String get rulesStatusError => 'Kan de server niet raadplegen.';

  @override
  String get rulesStatusChecking => 'Controleren…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Draait via “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” is het actieve script. Tik om het ook de regels van Loupe te laten uitvoeren.';
  }

  @override
  String get rulesStatusNoScript =>
      'Er is geen script actief op de server. Als je een serverregel opslaat, wordt dat van Loupe ingeschakeld.';

  @override
  String get rulesStatusUnavailable => 'Niet beschikbaar';

  @override
  String get rulesStatusNoSieve => 'De server van dit account biedt geen Sieve (ManageSieve of JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Verplaatsen naar $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Verplaatsen naar een map';

  @override
  String rulesActionTag(String tag) {
    return 'Tag $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Tag $tag verwijderen';
  }

  @override
  String get rulesActionKeepInInbox => 'In inbox houden';

  @override
  String rulesActionForward(String address) {
    return 'Doorsturen naar $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Doorsturen naar $address, geen kopie bewaren';
  }

  @override
  String get rulesActionStop => 'Stoppen';

  @override
  String get rulesNoActions => 'Doet nog niets';

  @override
  String get rulesLocationDevice => 'Apparaat';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Dit apparaat';

  @override
  String get rulesNewRuleTitle => 'Nieuwe regel';

  @override
  String get rulesEditRuleTitle => 'Regel bewerken';

  @override
  String get rulesDefaultNameEveryMessage => 'Elk bericht';

  @override
  String get rulesConditionHeader => 'Als een nieuw bericht overeenkomt';

  @override
  String get rulesConditionFooter =>
      'Schrijf het zoals je zou zoeken: from:, to:, s: (onderwerp), b: (tekst), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:factuur';

  @override
  String get rulesAccounts => 'Accounts';

  @override
  String get rulesAllAccounts => 'Alle accounts';

  @override
  String get rulesRemovedAccount => 'Verwijderd account';

  @override
  String get rulesAccountsFooter => 'Een regel voor alle accounts geldt ook voor accounts die je later toevoegt.';

  @override
  String get rulesActionsHeader => 'Dan';

  @override
  String get rulesForwardingFooter =>
      'Doorsturen stuurt elk overeenkomend bericht bij aankomst naar een ander adres, ook als deze telefoon uit staat. Sommige providers beperken hoeveel mail mag worden doorgestuurd.';

  @override
  String get rulesForwardingHiddenFooter => 'Doorsturen werkt alleen in serverregels en ontbreekt hier daarom.';

  @override
  String rulesRemoveAction(String action) {
    return '$action verwijderen';
  }

  @override
  String get rulesAddAction => 'Actie toevoegen';

  @override
  String get rulesAddMove => 'Verplaatsen naar map…';

  @override
  String get rulesAddTagMenu => 'Tag toevoegen…';

  @override
  String get rulesRemoveTagMenu => 'Tag verwijderen…';

  @override
  String get rulesAddForward => 'Doorsturen naar…';

  @override
  String get rulesStopProcessing => 'Geen verdere regels uitvoeren';

  @override
  String get rulesRunOnHeader => 'Uitvoeren op';

  @override
  String get rulesRunOnDeviceFooter =>
      'Dit apparaat voert de regel uit op nieuwe mail in de inbox wanneer Loupe op mail controleert.';

  @override
  String get rulesRunOnServerFooter =>
      'De mailserver voert de regel uit wanneer mail binnenkomt, ook als deze telefoon uit staat. Vereist Sieve, via ManageSieve (Dovecot, mailcow) of JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Toepassen op bestaande berichten…';

  @override
  String get rulesDeleteRule => 'Regel verwijderen';

  @override
  String rulesDeleteTitle(String rule) {
    return '“$rule” verwijderen?';
  }

  @override
  String get rulesMoveAccountTitle => 'Map in welk account?';

  @override
  String get rulesMoveAccountMessage => 'Mail van de andere accounts gaat daar naar de map met dezelfde naam.';

  @override
  String get rulesAddTag => 'Tag toevoegen';

  @override
  String get rulesRemoveTag => 'Tag verwijderen';

  @override
  String get rulesForwardTo => 'Doorsturen naar';

  @override
  String get rulesForwardToMessage =>
      'De server stuurt elk overeenkomend bericht door naar dit adres, ook als deze telefoon uit staat. Gebruik een adres dat van jou is of dat je vertrouwt.';

  @override
  String get rulesNotAnAddressTitle => 'Geen e-mailadres';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address” is geen adres om naar door te sturen.';
  }

  @override
  String get rulesKeepCopyTitle => 'Hier een kopie bewaren?';

  @override
  String get rulesKeepCopy => 'Kopie bewaren';

  @override
  String get rulesDontKeepCopy => 'Geen kopie bewaren';

  @override
  String get rulesCheckCondition => 'Controleer de voorwaarde';

  @override
  String get rulesChooseActionTitle => 'Kies een actie';

  @override
  String get rulesChooseActionMessage => 'Voeg toe wat de regel doet met de berichten die overeenkomen.';

  @override
  String get rulesSaveError => 'Kan de regel niet opslaan';

  @override
  String get rulesSaveServerError => 'Kan de serverregel niet opslaan';

  @override
  String get rulesRunOnDeviceInstead => 'In plaats daarvan op dit apparaat uitvoeren';

  @override
  String get rulesNothingToApplyTitle => 'Niets toe te passen';

  @override
  String get rulesNothingToApplyMessage => 'Geef de regel eerst een werkende voorwaarde en een actie.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return '“$rule” toepassen op berichten in…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inboxen';

  @override
  String get rulesApplyScopeAll => 'Alle mailboxen';

  @override
  String get rulesFindingMessages => 'Berichten zoeken…';

  @override
  String get rulesSearchError => 'Zoeken mislukt';

  @override
  String get rulesSearchErrorUnknown => 'Er ging iets mis.';

  @override
  String get rulesNoMatchesTitle => 'Geen overeenkomende berichten';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Niets daar komt overeen met “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$rule” toepassen op $countString berichten?',
      one: '“$rule” toepassen op $countString bericht?',
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
      other: 'Toepassen op $countString berichten',
      one: 'Toepassen op $countString bericht',
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
      other: '“$rule” toegepast op $countString berichten',
      one: '“$rule” toegepast op $countString bericht',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Server vragen wat hij kan…';

  @override
  String get rulesServerUnreachable => 'Kan de server niet bereiken.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kan niet op de server draaien: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kan niet op de server van $account draaien: $problem';
  }

  @override
  String get rulesShowScript => 'Script tonen';

  @override
  String get rulesHideScript => 'Script verbergen';

  @override
  String get rulesMatchingHeader => 'Overeenkomende berichten';

  @override
  String get rulesMatchingHeaderLoading => 'Overeenkomende berichten…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString overeenkomende berichten',
      one: '$countString overeenkomend bericht',
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
      other: '$countString+ overeenkomende berichten',
      one: '$countString+ overeenkomend bericht',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Van de afgelopen 30 dagen. De regel zelf werkt alleen op nieuwe mail, tenzij je hem toepast op bestaande berichten.';

  @override
  String rulesConditionError(String error) {
    return 'De voorwaarde bevat een fout: $error';
  }

  @override
  String get rulesPreviewNoSender => '(geen afzender)';

  @override
  String get rulesPreviewNoSubject => '(geen onderwerp)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'en nog $countString',
      one: 'en nog $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Niets van de afgelopen 30 dagen.';

  @override
  String get rulesIncludeTitle => 'Serverregels inschakelen';

  @override
  String get rulesIncludeLeaveOff => 'Uit laten';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'De server voert de regels van Loupe voor $account al uit.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” is het actieve script op de server van $account, dus de server voert dat uit en niet de regels van Loupe. Loupe vervangt het niet. Het kan er deze regels aan toevoegen, waarna de server de regels van Loupe uitvoert na die van het script zelf:';
  }

  @override
  String get rulesShowWholeScript => 'Hele script tonen';

  @override
  String get rulesHideWholeScript => 'Hele script verbergen';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Verder verandert er niets aan “$script”. Als de filters later in de webmail worden bewerkt, kan de webmail het zonder deze regels herschrijven; Loupe toont serverregels dan weer als uit.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Toevoegen aan “$script”';
  }

  @override
  String get subscriptionsTitle => 'Abonnementen';

  @override
  String get subscriptionsNewsletters => 'Nieuwsbrieven';

  @override
  String get subscriptionsDiscussions => 'Discussies';

  @override
  String get subscriptionsFilter => 'Filteren';

  @override
  String get subscriptionsFilterNeverRead => 'Nooit gelezen';

  @override
  String get subscriptionsFilterRarelyRead => 'Zelden gelezen';

  @override
  String get subscriptionsFilterAll => 'Alle';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Kan abonnementen niet tellen';

  @override
  String get subscriptionsNoMatches => 'Geen resultaten';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Geen nieuwsbrief heet “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Geen lijst heet “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Geen nieuwsbrieven';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Nieuwsbrieven en andere bulkmail verschijnen hier zodra ze binnenkomen.';

  @override
  String get subscriptionsNothingNeverRead => 'Niets nooit gelezen';

  @override
  String get subscriptionsNothingRarelyRead => 'Niets zelden gelezen';

  @override
  String get subscriptionsNothingFilteredDetail => 'Je leest van alles wat je krijgt wel iets.';

  @override
  String get subscriptionsNoDiscussions => 'Geen discussies';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mailinglijsten waar je naar kunt schrijven, verschijnen hier zodra hun mail binnenkomt.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lijsten waar meerdere mensen naar schrijven. Houd er een ingedrukt om hem vast te zetten in Mailboxen, als platte tekst te lezen of naar Nieuwsbrieven te verplaatsen.';

  @override
  String get subscriptionsPrivacyNote =>
      'Geteld op deze telefoon uit de mail die hij heeft gedownload; daarvoor wordt niets verstuurd. Loupe neemt alleen contact op met een afzender als je op Afmelden tikt: afmelden met één klik stuurt alleen “List-Unsubscribe=One-Click” naar het adres dat de afzender heeft opgegeven, zonder cookies en zonder iets anders over jou, en laadt nooit diens pagina’s of afbeeldingen.';

  @override
  String get subscriptionsVolumeNone => 'De laatste tijd geen';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / maand';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / maand';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return '$percent gelezen';
  }

  @override
  String get subscriptionsStillSending => 'Stuurt nog steeds';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Afgemeld op $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Afmeldpagina geopend op $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Eén tik · neemt contact op met $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Per e-mail naar $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Op de website $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Afmelden';

  @override
  String get subscriptionsUnsubscribeAgain => 'Opnieuw afmelden';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString in inbox archiveren',
      one: '$countString in inbox archiveren',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Regel maken…';

  @override
  String get subscriptionsCreateRuleDetail => 'Toekomstige mail verplaatsen of archiveren';

  @override
  String get subscriptionsTreatAsDiscussion => 'Behandelen als discussie';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Een lijst waar mensen naar schrijven: lezen als forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Behandelen als nieuwsbrief';

  @override
  String get subscriptionsBlockSender => 'Afzender blokkeren';

  @override
  String get subscriptionsBlock => 'Blokkeren';

  @override
  String get subscriptionsBlocked => 'Geblokkeerd';

  @override
  String get subscriptionsBlockedDetail => 'Nieuwe mail gaat naar spam';

  @override
  String get subscriptionsPin => 'Vastzetten in Mailboxen';

  @override
  String get subscriptionsUnpin => 'Losmaken van Mailboxen';

  @override
  String get subscriptionsOpenDefaultView => 'Openen in standaardweergave';

  @override
  String get subscriptionsOpenPlainText => 'Openen als platte tekst (mono)';

  @override
  String get subscriptionsPinned => 'Vastgezet';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ongelezen',
      one: '$countString ongelezen',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Op dit moment geen mail van deze afzender.';

  @override
  String get subscriptionsLatestMessages => 'NIEUWSTE BERICHTEN';

  @override
  String get subscriptionsMail => 'Mail';

  @override
  String get subscriptionsNoneIn90Days => 'Geen in 90 dagen';

  @override
  String get subscriptionsRead => 'Gelezen';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString van $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Laatst ontvangen';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Mappen', one: 'Map');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Stuurt nog steeds';

  @override
  String get subscriptionsUnsubscribedTitle => 'Afgemeld';

  @override
  String subscriptionsSince(String date) {
    return 'sinds $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'pagina geopend op $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender geeft niet aan hoe je je afmeldt.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender geeft niet aan hoe je je afmeldt. Je kunt de afzender in plaats daarvan blokkeren.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Afmelden bij $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Afgemeld bij $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Afmelden mislukt: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatisch afmelden mislukt';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Afmeld-e-mail sturen';

  @override
  String subscriptionsOpenSite(String site) {
    return '$site openen';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site openen?';
  }

  @override
  String get subscriptionsOpen => 'Openen';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender meldt af via de eigen website. De pagina opent in de browser van Loupe; rond het daar af.';
  }

  @override
  String get subscriptionsWebInsecure => 'De verbinding met deze site is niet versleuteld.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Let op: dit adres imiteert $site met gelijkende letters.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Let op: dit adres imiteert een andere site met gelijkende letters.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Kan $site niet openen.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe noteert de datum van vandaag en laat het je weten als $sender blijft schrijven.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Afmelden bij $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe neemt contact op met $site om je af te melden.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Dit is de enige keer dat Loupe contact opneemt met de website van een afzender. Het stuurt alleen “List-Unsubscribe=One-Click” naar het adres dat $sender heeft opgegeven, zonder cookies of iets anders over jou, en laadt de pagina niet.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'De afmeldlink is geen veilig adres op internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site heeft niet op tijd geantwoord.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Kan $site niet bereiken.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site heeft het verzoek doorgestuurd naar een andere pagina, die Loupe niet volgt.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site heeft het verzoek geweigerd (fout $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Er is geen account om de afmeld-e-mail vanaf te sturen.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe stuurt een e-mail naar $to vanaf $from, met het onderwerp “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Afmeld-e-mail verstuurd naar $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender blokkeren?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nieuwe mail van deze lijst gaat naar spam. Je kunt dit wijzigen in Instellingen › Regels.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nieuwe mail van $address gaat naar spam. Je kunt dit wijzigen in Instellingen › Regels.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender geblokkeerd.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count naar spam verplaatsen',
      one: '$count naar spam verplaatsen',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return '$sender blokkeren';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender staat nu bij Nieuwsbrieven.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender staat nu bij Discussies.';
  }

  @override
  String get appLiveGateTitle => 'Je accounts konden niet worden geopend';

  @override
  String get appLiveGateUnavailableBuild => 'Echte accounts zijn nog niet beschikbaar in deze build.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe kon de sleutel die je mail op deze telefoon beschermt niet lezen. Dit is vaak tijdelijk: probeer het opnieuw of start de telefoon opnieuw op.';

  @override
  String get appLiveGateKeyMissing =>
      'De sleutel die je mail op deze telefoon beschermt, is weg. Dat kan gebeuren na het terugzetten van een back-up. Je mail staat nog op de server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'De maildatabase op deze telefoon kan niet worden gelezen: hij is beschadigd of de sleutel is gewijzigd. Je mail staat nog op de server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Er ging iets mis bij het openen van je accounts ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Hiermee worden je accounts en de mail op deze telefoon verwijderd, ook berichten die in Postvak UIT wachten. Mail op je servers blijft onaangetast; voeg je accounts daarna opnieuw toe.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Verwijderen en opnieuw beginnen';

  @override
  String get appLiveGateUseDemo => 'Demomail gebruiken';

  @override
  String get appLiveGateReset => 'Mail op deze telefoon resetten…';

  @override
  String get attachmentsUntitled => 'Bijlage';

  @override
  String get attachmentsUntitledFile => 'Naamloos';

  @override
  String get attachmentsOpenIn => 'Openen in…';

  @override
  String get attachmentsSaveToFiles => 'Opslaan in Bestanden';

  @override
  String get attachmentsShareMenu => 'Delen…';

  @override
  String get attachmentsDownloadError =>
      'Kan de bijlage niet downloaden. Controleer de verbinding en probeer het opnieuw.';

  @override
  String get attachmentsShareError => 'Kan de bijlage niet delen.';

  @override
  String attachmentsNoApp(String type) {
    return 'Geen app op dit apparaat opent dit bestand ($type). Probeer in plaats daarvan Delen.';
  }

  @override
  String get attachmentsOpenInError => 'Kan de bijlage niet openen in een andere app.';

  @override
  String attachmentsSaved(String name) {
    return '“$name” opgeslagen';
  }

  @override
  String get attachmentsSaveError => 'Kan de bijlage niet opslaan.';

  @override
  String get attachmentsGone => 'Deze bijlage is niet meer beschikbaar.';

  @override
  String get attachmentsDownloadFailed => 'De bijlage kon niet worden gedownload.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pagina’s', one: '$count pagina');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size via mobiele data';
  }

  @override
  String get attachmentsLargeDownload => 'Deze bijlage is groot. Download hem nu, of later via wifi.';

  @override
  String get attachmentsDownload => 'Downloaden';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size downloaden…';
  }

  @override
  String get attachmentsDownloading => 'Downloaden…';

  @override
  String get attachmentsTooLarge => 'Te groot om hier te bekijken.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'De eerste $shown van $total worden getoond. Kopieer, deel of sla op om alles te krijgen.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Deze pdf kan hier niet worden getoond (mogelijk is hij beveiligd met een wachtwoord).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page van $count';
  }

  @override
  String get attachmentsModeTable => 'Tabel';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Bericht';

  @override
  String get attachmentsModeSource => 'Bron';

  @override
  String get attachmentsDontWrap => 'Regels niet laten teruglopen';

  @override
  String get attachmentsWrap => 'Regels laten teruglopen';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines regels', one: '$lines regel');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Alles kopiëren';

  @override
  String get attachmentsCopied => 'Gekopieerd';

  @override
  String get attachmentsImageUnavailable => 'Deze afbeelding kan hier niet worden getoond. Probeer Openen in….';

  @override
  String get attachmentsEmlNoSubject => '(Geen onderwerp)';

  @override
  String get attachmentsEmlFrom => 'Van';

  @override
  String get attachmentsEmlTo => 'Aan';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Dit bericht heeft geen tekst.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Bijlagen: $names', one: 'Bijlage: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organisator: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En nog $count afspraken',
      one: 'En nog $count afspraak',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Afbeelding';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-afbeelding';
  }

  @override
  String get attachmentsTypePdf => 'Pdf-document';

  @override
  String get attachmentsTypeTsv => 'Door tabs gescheiden waarden';

  @override
  String get attachmentsTypeCsv => 'CSV-spreadsheet';

  @override
  String get attachmentsTypeCalendar => 'Agenda-afspraak';

  @override
  String get attachmentsTypeEmail => 'E-mailbericht';

  @override
  String get attachmentsTypeContact => 'Contactkaart';

  @override
  String get attachmentsTypeLog => 'Logbestand';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'Zip-archief';

  @override
  String get attachmentsTypeArchive => 'Archief';

  @override
  String get attachmentsTypeWord => 'Word-document';

  @override
  String get attachmentsTypeExcel => 'Excel-spreadsheet';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-presentatie';

  @override
  String get attachmentsTypeWebPage => 'Webpagina';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-bestand';
  }

  @override
  String get attachmentsTypeFile => 'Bestand';

  @override
  String get calendarUntitledEvent => 'Afspraak';

  @override
  String get calendarAllDay => 'Hele dag';

  @override
  String calendarYourTime(String time) {
    return '$time jouw tijd';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Deelnemen: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name heeft geaccepteerd: $details',
      'tentative': '$name heeft voorlopig geaccepteerd: $details',
      'declined': '$name heeft afgewezen: $details',
      'delegated': '$name heeft gedelegeerd: $details',
      'other': '$name heeft niet gereageerd op: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name heeft de uitnodiging geaccepteerd',
      'tentative': '$name heeft de uitnodiging voorlopig geaccepteerd',
      'declined': '$name heeft de uitnodiging afgewezen',
      'delegated': '$name heeft de uitnodiging gedelegeerd',
      'other': '$name heeft niet op de uitnodiging gereageerd',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kaart';

  @override
  String get calendarJoin => 'Deelnemen';

  @override
  String get calendarOnlineMeeting => 'Onlinevergadering';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-vergadering';
  }

  @override
  String get calendarOrganizerYou => 'Jij';

  @override
  String get calendarOrganizerLabel => 'organisator';

  @override
  String get calendarStatusAccepted => 'Geaccepteerd';

  @override
  String get calendarStatusMaybe => 'Misschien';

  @override
  String get calendarStatusDeclined => 'Afgewezen';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name heeft geaccepteerd',
      'tentative': '$name heeft voorlopig geaccepteerd',
      'declined': '$name heeft afgewezen',
      'delegated': '$name heeft gedelegeerd',
      'other': '$name heeft niet gereageerd',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name heeft geaccepteerd:',
      'tentative': '$name heeft voorlopig geaccepteerd:',
      'declined': '$name heeft afgewezen:',
      'delegated': '$name heeft gedelegeerd:',
      'other': '$name heeft niet gereageerd:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name stelt een nieuwe tijd voor';
  }

  @override
  String get calendarCounterUnknown => 'Een deelnemer stelt een nieuwe tijd voor';

  @override
  String get calendarDeclineCounter => 'De organisator heeft de tijd behouden';

  @override
  String calendarRefresh(String name) {
    return '$name vraagt om de nieuwste versie';
  }

  @override
  String get calendarRefreshUnknown => 'Een deelnemer vraagt om de nieuwste versie';

  @override
  String get calendarCancelled => 'Geannuleerd';

  @override
  String get calendarCancelledByOrganizer => 'De organisator heeft deze afspraak geannuleerd.';

  @override
  String get calendarCancelledLater => 'Deze afspraak is later geannuleerd.';

  @override
  String get calendarOutdated => 'Verouderd';

  @override
  String get calendarOutdatedDetail => 'Deze uitnodiging is later bijgewerkt; de nieuwere telt.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Locatie verwijderd (was $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Locatie verwijderd (was geen)';

  @override
  String calendarLocationChanged(String location) {
    return 'Locatie gewijzigd in $location';
  }

  @override
  String get calendarNewTitle => 'Nieuwe titel';

  @override
  String get calendarRepeatChanged => 'De herhaling is gewijzigd';

  @override
  String get calendarUpdated => 'Bijgewerkt';

  @override
  String get calendarUpdatedInvitation => 'Bijgewerkte uitnodiging';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Tijd gewijzigd van $before naar $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Tijdzone “$zone” onbekend: tijden zoals vermeld';
  }

  @override
  String calendarNext(String when) {
    return 'Volgende: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gasten', one: '$count gast');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count geaccepteerd',
      one: '$count geaccepteerd',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count misschien',
      one: '$count misschien',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count afgewezen',
      one: '$count afgewezen',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (jij)';
  }

  @override
  String get calendarAttendeeOptional => 'optioneel';

  @override
  String get calendarAttendeeRoom => 'ruimte';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Je hebt een eerdere versie geaccepteerd.',
      'tentative': 'Je hebt een eerdere versie voorlopig geaccepteerd.',
      'declined': 'Je hebt een eerdere versie afgewezen.',
      'delegated': 'Je hebt een eerdere versie gedelegeerd.',
      'other': 'Je hebt niet gereageerd op een eerdere versie.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Accepteren';

  @override
  String get calendarMaybe => 'Misschien';

  @override
  String get calendarDecline => 'Afwijzen';

  @override
  String get calendarCommentHint => 'Opmerking voor de organisator (optioneel)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Je antwoord gaat naar $organizer vanaf $address.';
  }

  @override
  String get calendarAddComment => 'Opmerking toevoegen';

  @override
  String get calendarAddToCalendar => 'Toevoegen aan agenda';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En nog $count afspraken in het bestand',
      one: 'En nog $count afspraak in het bestand',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Er is geen agenda-app om de afspraak aan toe te voegen.';

  @override
  String get calendarCantOpenCalendar => 'Kan de agenda niet openen.';

  @override
  String get calendarCantOpenLink => 'Kan de link niet openen.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Deelnemen aan $provider-vergadering?';
  }

  @override
  String get calendarJoinTitle => 'Deelnemen aan de vergadering?';

  @override
  String calendarJoinOpens(String host) {
    return 'Opent $host in je browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Let op: dit adres imiteert $site met gelijkende letters.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Let op: dit adres imiteert een andere site met gelijkende letters.';

  @override
  String calendarJoinOpen(String host) {
    return '$host openen';
  }

  @override
  String get calendarNoOrganizer => 'Deze uitnodiging heeft geen organisator om op te antwoorden.';

  @override
  String get calendarNoAccount => 'Er is geen account om vanaf te antwoorden.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Geaccepteerd',
      'tentative': 'Misschien',
      'other': 'Afgewezen',
    });
    return '$_temp0 · antwoord naar $name verzenden…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Geaccepteerd',
      'tentative': 'Misschien',
      'other': 'Afgewezen',
    });
    return '$_temp0 · antwoord verzonden';
  }

  @override
  String get calendarReplyAlreadySent => 'Het antwoord is al verzonden.';

  @override
  String get calendarReplyNotSent => 'Antwoord niet verzonden.';

  @override
  String get dataSmimeNeedsDevice =>
      'Je S/MIME-certificaat staat op dit apparaat: open Loupe om dit bericht te ondertekenen en te verzenden.';

  @override
  String dataSigningFailed(String error) {
    return 'Ondertekenen mislukt: $error';
  }

  @override
  String get keyboardShortcuts => 'Sneltoetsen';

  @override
  String get keyboardGroupGeneral => 'Algemeen';

  @override
  String get keyboardGroupMessages => 'Berichten';

  @override
  String get keyboardGroupCompose => 'Opstellen';

  @override
  String get keyboardCommandPalette => 'Opdrachtenpalet';

  @override
  String get keyboardBackClose => 'Terug, sluiten';

  @override
  String get keyboardNextMessage => 'Volgend bericht';

  @override
  String get keyboardPreviousMessage => 'Vorig bericht';

  @override
  String get keyboardOpenMessage => 'Bericht openen';

  @override
  String get keyboardMoveToTrash => 'Naar prullenbak verplaatsen';

  @override
  String get keyboardToggleRead => 'Markeren als gelezen of ongelezen';

  @override
  String get keyboardToggleFlag => 'Markeren of markering verwijderen';

  @override
  String get keyboardCloseDraft => 'Sluiten (concept opslaan of verwijderen)';

  @override
  String get keyboardOr => 'of';

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
  String get mailingListsMuted => 'Thread gedempt. Nieuwe berichten erin komen binnen als gelezen.';

  @override
  String get mailingListsUnmuted => 'Thread niet meer gedempt.';

  @override
  String get mailingListsMuteThread => 'Thread dempen';

  @override
  String get mailingListsUnmuteThread => 'Dempen opheffen';

  @override
  String get mailingListsPin => 'Vastzetten in Mailboxen';

  @override
  String get mailingListsUnpin => 'Losmaken van Mailboxen';

  @override
  String get mailingListsDefaultView => 'Openen in standaardweergave';

  @override
  String get mailingListsPlainText => 'Openen als platte tekst (mono)';

  @override
  String get mailingListsShowMuted => 'Gedempte threads tonen';

  @override
  String get mailingListsHideMuted => 'Gedempte threads verbergen';

  @override
  String get mailingListsTreatAsNewsletter => 'Behandelen als nieuwsbrief';

  @override
  String get mailingListsOptions => 'Lijstopties';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted ongelezen',
      one: '$formatted ongelezen',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nieuw bericht aan lijst';

  @override
  String get mailingListsRowUnread => 'Ongelezen';

  @override
  String get mailingListsRowMuted => 'Gedempt';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count antwoorden',
      one: '$count antwoord',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Geen threads';

  @override
  String get mailingListsMutedHidden => 'Gedempte threads zijn verborgen.';

  @override
  String get mailingListsTechnicalTitle => 'Technische lijsten';

  @override
  String get mailingListsTechnicalEmpty => 'Mailinglijsten verschijnen hier zodra hun mail binnenkomt.';

  @override
  String get mailingListsTechnicalFooter =>
      'Berichten van deze lijsten openen als platte tekst in een lettertype met vaste breedte, met patches als diffs. Met de knop Aa kun je elk bericht nog steeds omschakelen.';

  @override
  String get paletteMoveToMailbox => 'Verplaatsen naar mailbox…';

  @override
  String get paletteMarkAllRead => 'Alles markeren als gelezen';

  @override
  String get paletteExportFolder => 'Map exporteren…';

  @override
  String get paletteGetNewMail => 'Nieuwe mail ophalen';

  @override
  String get paletteSnoozed => 'Gesnoozed';

  @override
  String get paletteSubscriptions => 'Abonnementen';

  @override
  String get paletteDiscussions => 'Discussies';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailinglijst';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Veegacties';

  @override
  String get paletteNotifications => 'Meldingen';

  @override
  String get paletteRules => 'Regels';

  @override
  String get paletteEncryption => 'End-to-end-versleuteling';

  @override
  String get paletteAdvanced => 'Geavanceerd';

  @override
  String get paletteAddAccount => 'Account toevoegen';

  @override
  String get paletteAccount => 'Account';

  @override
  String get paletteFolders => 'Mappen';

  @override
  String get paletteRecentSearch => 'Recente zoekopdracht';

  @override
  String paletteSearchMail(String query) {
    return 'Mail doorzoeken op “$query”';
  }

  @override
  String get palettePlaceholder => 'Acties, mailboxen, instellingen zoeken';

  @override
  String get paletteNothingFound => 'Niets gevonden';

  @override
  String get searchNewSmartMailbox => 'Nieuwe Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Toont alles wat overeenkomt met “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '“$name” opgeslagen in Mailboxen';
  }

  @override
  String get searchMakeRule => 'Er een regel van maken';

  @override
  String get searchSaveSmartMailbox => 'Opslaan als Smart Mailbox';

  @override
  String get searchNegate => 'Omkeren';

  @override
  String get searchDontNegate => 'Niet omkeren';

  @override
  String get searchAllMailboxes => 'Alle mailboxen';

  @override
  String get searchRecent => 'Recente zoekopdrachten';

  @override
  String get searchClear => 'Wissen';

  @override
  String get searchSuggestions => 'Suggesties';

  @override
  String get searchUnreadMessages => 'Ongelezen berichten';

  @override
  String get searchFlaggedMessages => 'Gemarkeerde berichten';

  @override
  String get searchWithAttachments => 'Berichten met bijlagen';

  @override
  String get searchUnrepliedMessages => 'Onbeantwoorde berichten';

  @override
  String get searchTags => 'Tags';

  @override
  String get searchPeople => 'Personen';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Van: $name';
  }

  @override
  String get searchSearching => 'Zoeken…';

  @override
  String get searchNoResults => 'Geen resultaten';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted resultaten',
      one: '$formatted resultaat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Zoekmenu';

  @override
  String searchSearchingAccount(String account) {
    return '$account doorzoeken op de server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Account doorzoeken op de server…';

  @override
  String searchAccountFailed(String account) {
    return 'Kan $account niet doorzoeken op de server';
  }

  @override
  String get searchUnknownAccountFailed => 'Kan account niet doorzoeken op de server';

  @override
  String searchChip(String term) {
    return '$term. Dubbeltik om te bewerken.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Niet $term. Dubbeltik om te bewerken.';
  }

  @override
  String get searchReadAndUnread => 'Schrödingers inbox: elk bericht hier is gelezen én ongelezen, tot je het opent.';

  @override
  String searchContradiction(String term) {
    return 'Geen bericht kan tegelijk “$term” en niet “$term” zijn.';
  }

  @override
  String get searchSyncDeviceOnly => 'Alleen op dit apparaat';

  @override
  String searchSyncUnsupported(String account) {
    return 'Alleen op dit apparaat: $account kan hem niet bewaren';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Niet gesynchroniseerd: $account heeft een nieuwere indeling';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Wacht op synchronisatie met $account';
  }

  @override
  String searchSynced(String account) {
    return 'Gesynchroniseerd met $account';
  }

  @override
  String get searchRename => 'Naam wijzigen';

  @override
  String get searchEditSearch => 'Zoekopdracht bewerken';

  @override
  String get searchDeleteSmartMailbox => 'Smart Mailbox verwijderen';

  @override
  String get searchRenameSmartMailbox => 'Naam van Smart Mailbox wijzigen';

  @override
  String get searchSmartMailboxDeleted => 'Deze Smart Mailbox is verwijderd.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes blijven op dit apparaat.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes worden op je mailserver bewaard, zodat je andere apparaten ze ook hebben, net als Thunderbird met Expression Search Reloaded. Die alle accounts doorzoeken, staan op $account; die van één map op het account van die map.';
  }

  @override
  String get searchSyncVia => 'Synchroniseren via';

  @override
  String get searchSyncViaFooter => 'Kies op elk apparaat hetzelfde account.';

  @override
  String get searchGmailCantKeep => 'Gmail kan geen Smart Mailboxes bewaren';

  @override
  String get searchKeepOnDevice => 'Smart Mailboxes alleen op dit apparaat bewaren';

  @override
  String get searchOnTheServer => 'Op de server';

  @override
  String get searchServerFooter =>
      'Servermetadata (IMAP METADATA) zijn in geen enkele mailapp zichtbaar. Servers zonder deze functie krijgen een map “Loupe Settings” met één bericht; Loupe verbergt die in Mailboxen.';

  @override
  String get searchSyncNow => 'Nu synchroniseren';

  @override
  String get searchStateUnsupported => 'Niet ondersteund';

  @override
  String get searchStateNewerFormat => 'Nieuwere indeling';

  @override
  String get searchStateFailed => 'Synchronisatie mislukt';

  @override
  String get searchStateSyncing => 'Synchroniseren…';

  @override
  String get searchStateWaiting => 'Wachten';

  @override
  String get searchStateMetadata => 'Servermetadata';

  @override
  String get searchStateFolder => 'Map “Loupe Settings”';

  @override
  String get searchStateNothing => 'Niets opgeslagen';

  @override
  String get sharedBack => 'Terug';

  @override
  String get sharedYesterday => 'Gisteren';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date om $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bytes', one: '$count byte');
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size kB';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size MB';
  }

  @override
  String get sharedSyncNoAccounts => 'Geen accounts';

  @override
  String get sharedSyncChecking => 'Controleren op mail…';

  @override
  String get sharedSyncFailed => 'Kan niet op mail controleren';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Zojuist bijgewerkt';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minuten geleden bijgewerkt',
      one: '$minutes minuut geleden bijgewerkt',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Bijgewerkt om $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Bijgewerkt op $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Alle inboxen';

  @override
  String get sharedMailboxUnread => 'Ongelezen';

  @override
  String get sharedMailboxFlagged => 'Gemarkeerd';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Alle concepten';

  @override
  String get sharedMailboxAllSent => 'Alle verzonden';

  @override
  String get sharedMailboxUntitled => 'Mailbox';

  @override
  String get sharedTagImportant => 'Belangrijk';

  @override
  String get sharedTagWork => 'Werk';

  @override
  String get sharedTagPersonal => 'Persoonlijk';

  @override
  String get sharedTagToDo => 'Nog te doen';

  @override
  String get sharedTagLater => 'Later';

  @override
  String get sharedTags => 'Tags';

  @override
  String get sharedMoveTo => 'Verplaatsen naar…';

  @override
  String get sharedNoRecipients => 'Geen ontvangers';

  @override
  String get sharedUnknownSender => 'Onbekende afzender';

  @override
  String get sharedOnServer => 'Op server';

  @override
  String get sharedAttachment => 'Bijlage';

  @override
  String get sharedSnoozedBadge => 'Gesnoozed';

  @override
  String get sharedRowUnread => 'Ongelezen';

  @override
  String get sharedRowBackFromSnooze => 'Terug van snoozen';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Gemarkeerd';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten gearchiveerd',
      one: '$count bericht gearchiveerd',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten verwijderd',
      one: '$count bericht verwijderd',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten naar inbox verplaatst',
      one: '$count bericht naar inbox verplaatst',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten naar prullenbak verplaatst',
      one: '$count bericht naar prullenbak verplaatst',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten naar spam verplaatst',
      one: '$count bericht naar spam verplaatst',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten naar $mailbox verplaatst',
      one: '$count bericht naar $mailbox verplaatst',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten naar mailbox verplaatst',
      one: '$count bericht naar mailbox verplaatst',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten gesnoozed tot $time',
      one: '$count bericht gesnoozed tot $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Alleen op dit apparaat gesnoozed tot $time: de server kan geen snoozetijden opslaan.';
  }

  @override
  String get sharedMoveOneAccount => 'Selecteer berichten uit één account om ze te verplaatsen.';

  @override
  String get sharedSnoozeTitle => 'Snoozen';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Snoozetijd wijzigen';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count berichten definitief verwijderen?',
      one: 'Dit bericht definitief verwijderen?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Dit kan niet ongedaan worden gemaakt.';

  @override
  String get sharedDeletePermanently => 'Definitief verwijderen';

  @override
  String get sharedSwipeRead => 'Gelezen';

  @override
  String get sharedSwipeUnread => 'Ongelezen';

  @override
  String get sharedSwipeInbox => 'Inbox';

  @override
  String get sharedSwipeDelete => 'Wissen';

  @override
  String get sharedTrash => 'Prullenbak';

  @override
  String get sharedSwipeSnooze => 'Snoozen';

  @override
  String get sharedWakeNow => 'Nu terughalen';

  @override
  String get sharedChangeSnoozeTime => 'Snoozetijd wijzigen…';

  @override
  String get sharedSnooze => 'Snoozen…';

  @override
  String get sharedTag => 'Taggen…';

  @override
  String get sharedMoveMessage => 'Bericht verplaatsen…';

  @override
  String get sharedNotJunk => 'Geen spam';

  @override
  String get accountSetupTitle => 'Account toevoegen';

  @override
  String get accountSetupTitleDone => 'Account toegevoegd';

  @override
  String get accountSetupAddressTitle => 'Mailaccount toevoegen';

  @override
  String get accountSetupAddressText => 'Loupe vindt de instellingen voor de meeste providers.';

  @override
  String get accountSetupNameHint => 'Je naam';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'naam@example.com';

  @override
  String get accountSetupContinue => 'Doorgaan';

  @override
  String get accountSetupLookingUp => 'Instellingen opzoeken…';

  @override
  String get accountSetupImport => 'Importeren uit Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Voer een geldig e-mailadres in.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Geen instellingen gevonden voor $domain. Voer ze hieronder in.';
  }

  @override
  String get accountSetupCheckServers => 'Controleer de servernamen en poorten.';

  @override
  String get accountSetupEnterPassword => 'Voer je wachtwoord in.';

  @override
  String get accountSetupConnecting => 'Verbinden…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Wachten op $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Kan de pagina niet openen.';

  @override
  String get accountSetupCouldNotSaveName => 'Kan de naam niet opslaan.';

  @override
  String get accountSetupTrustCertificate => 'Dit certificaat vertrouwen';

  @override
  String get accountSetupPasswordRequired => 'Verplicht';

  @override
  String get accountSetupShowPassword => 'Wachtwoord tonen';

  @override
  String get accountSetupHidePassword => 'Wachtwoord verbergen';

  @override
  String get accountSetupAppPassword => 'App-wachtwoord';

  @override
  String get accountSetupApiToken => 'API-token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Inkomend · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Uitgaand · SMTP';

  @override
  String get accountSetupSignIn => 'Inloggen';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Inloggen met $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'App-wachtwoord gebruiken';

  @override
  String get accountSetupUseAppPasswordInstead => 'In plaats daarvan app-wachtwoord gebruiken';

  @override
  String get accountSetupUseDifferentAddress => 'Ander adres gebruiken';

  @override
  String get accountSetupHowToCreateAppPassword => 'Zo maak je een app-wachtwoord';

  @override
  String get accountSetupHowToCreateOne => 'Zo maak je er een';

  @override
  String get accountSetupGoogleNote =>
      'Je logt in op de pagina van Google, en Loupe ziet je wachtwoord nooit. Sta Loupe toe je mail te lezen, te verzenden en te ordenen.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Inloggen met Google” is nog niet beschikbaar in deze build. Je kunt in plaats daarvan verbinden met een app-wachtwoord (daarvoor is verificatie in twee stappen nodig in je Google-account).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Maak een app-wachtwoord in je Google-account en plak het hieronder.';

  @override
  String get accountSetupMicrosoftNote =>
      'Je logt in op de pagina van Microsoft, en Loupe ziet je wachtwoord nooit. Dit werkt voor Outlook.com en Hotmail, en voor werk- of schoolaccounts op Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Inloggen met Microsoft komt in een latere build. Outlook-, Hotmail- en Microsoft 365-accounts hebben het nodig: ze accepteren geen wachtwoorden van mailapps meer.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail heeft een appspecifiek wachtwoord nodig, niet het wachtwoord van je Apple Account.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail heeft een app-wachtwoord nodig, niet je accountwachtwoord.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe verbindt met Fastmail via JMAP met een API-token: Settings › Privacy & Security › Manage API tokens, voor JMAP, met toegang tot e-mail en verzenden.';

  @override
  String get accountSetupFastmailNote => 'Fastmail heeft een app-wachtwoord nodig voor mailapps.';

  @override
  String get accountSetupServerSettings => 'Serverinstellingen';

  @override
  String get accountSetupSettingsNotFound => 'Niet automatisch gevonden';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Gevonden via $source';
  }

  @override
  String get accountSetupEditSettings => 'Instellingen bewerken';

  @override
  String get accountSetupSyncing => 'Je mail wordt gesynchroniseerd.';

  @override
  String get accountSetupDescription => 'Beschrijving';

  @override
  String get accountSetupDescriptionHint => 'Werk, Privé…';

  @override
  String get accountSetupColour => 'Kleur';

  @override
  String accountSetupColourNumber(int number) {
    return 'Kleur $number';
  }

  @override
  String get accountSetupSaving => 'Opslaan…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe kon de maildatabase op deze telefoon niet openen. Sluit Loupe, open het opnieuw en probeer het nog eens.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Er ging iets mis ($error). Probeer het opnieuw.';
  }

  @override
  String get accountSetupSecurityNone => 'Geen';

  @override
  String get accountSetupProtocol => 'Protocol';

  @override
  String get accountSetupPort => 'Poort';

  @override
  String get accountSetupSecurity => 'Beveiliging';

  @override
  String get accountSetupUsername => 'Gebruikersnaam';

  @override
  String get accountSetupUsernameHint => 'Je e-mailadres';

  @override
  String get accountSetupNoEncryptionTitle => 'Verbinden zonder versleuteling?';

  @override
  String get accountSetupNoEncryptionText =>
      'Je wachtwoord en elk bericht zouden als platte tekst worden verstuurd. Iedereen op het netwerk, zoals openbare wifi, zou ze kunnen lezen. Gebruik dit alleen voor een server op je eigen netwerk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Zonder versleuteling gebruiken';

  @override
  String get accountSetupApiTokenRejected =>
      'API-token geweigerd. Maak een Fastmail-API-token voor JMAP met toegang tot e-mail en plak het.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Wachtwoord geweigerd. Gebruik een app-wachtwoord, niet je accountwachtwoord.';

  @override
  String get accountSetupPasswordRejected => 'Wachtwoord geweigerd. Controleer het en probeer het opnieuw.';

  @override
  String get accountSetupServerUnreachable =>
      'Kan de server niet bereiken. Controleer de serverinstellingen en je verbinding.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Het certificaat van de server wordt niet vertrouwd. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Inloggen is geannuleerd. Tik op “Inloggen met $provider” om het opnieuw te proberen.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe heeft toestemming nodig om je Gmail te lezen en te verzenden. Log opnieuw in en sta toegang toe, met het vakje voor Gmail aangevinkt.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe heeft toestemming nodig om je mail te lezen en te verzenden. Log opnieuw in en accepteer de machtigingen.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Je organisatie moet Loupe goedkeuren voordat je het met dit account kunt gebruiken. Vraag je IT-beheerder om in Microsoft Entra ID beheerderstoestemming voor Loupe te verlenen en probeer het daarna opnieuw.';

  @override
  String get accountSetupOAuthBlocked =>
      'De aanmeldregels van je organisatie staan Loupe niet toe op dit apparaat. Vraag het je IT-beheerder.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Kan $provider niet bereiken. Controleer je internetverbinding en probeer het opnieuw.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Inloggen met $provider is niet goed ingesteld in deze versie van Loupe. Meld dit alsjeblieft.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Inloggen met $provider is niet gelukt. Probeer het opnieuw.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider heeft je ingelogd, maar Gmail weigerde de toegang voor dit adres. Kies bij het inloggen hetzelfde account. Bij werk- of schoolaccounts kan IMAP door de beheerder zijn uitgeschakeld.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider heeft je ingelogd, maar de mailserver weigerde de toegang voor dit adres. Kies bij het inloggen hetzelfde account. Bij werk- of schoolaccounts kan IMAP door de beheerder zijn uitgeschakeld.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Kan de mailserver niet bereiken. Controleer je verbinding en probeer het opnieuw.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Inloggen met $provider is niet beschikbaar in deze versie.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Opnieuw ingelogd. $account wordt gesynchroniseerd.';
  }

  @override
  String get accountSetupSignInAgain => 'Opnieuw inloggen';

  @override
  String get accountSetupSigningIn => 'Inloggen…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider accepteert de aanmelding van Loupe voor $email niet meer, dus $account wordt niet gesynchroniseerd. Log opnieuw in om de mail te ontvangen.';
  }

  @override
  String get accountImportTitle => 'Importeren uit Thunderbird';

  @override
  String get accountImportPointCamera => 'Richt de camera op de QR-code die Thunderbird toont.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned van $total gescand';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned van $total codes gescand',
      one: '$scanned van $total code gescand',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tot nu toe $count accounts',
      one: 'Tot nu toe $count account',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Open Thunderbird op je computer en kies Extra › Exporteren voor Mobiel. Selecteer je accounts en scan daarna elke code die verschijnt. De codes kunnen in elke volgorde worden gescand.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Doorgaan met $count accounts',
      one: 'Doorgaan met $count account',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'In plaats daarvan tekst plakken';

  @override
  String get accountImportStartOver => 'Opnieuw beginnen';

  @override
  String get accountImportDuplicateCode => 'Die code is al toegevoegd.';

  @override
  String get accountImportRestarted =>
      'Deze code komt uit een nieuwe export, dus de eerder gescande codes zijn opzijgezet.';

  @override
  String get accountImportNotThunderbird => 'Dit is geen Thunderbird-accountcode.';

  @override
  String get accountImportNewerVersion =>
      'Deze code komt uit een nieuwere Thunderbird. Werk Loupe bij om hem te importeren.';

  @override
  String get accountImportDamaged => 'Deze Thunderbird-code kon niet worden gelezen.';

  @override
  String get accountImportTooLarge => 'Deze code is te groot voor een Thunderbird-export.';

  @override
  String get accountImportCouldNotOpenSettings => 'Kan Instellingen niet openen.';

  @override
  String get accountImportCameraOffTitle => 'Cameratoegang staat uit';

  @override
  String get accountImportCameraOffText =>
      'Sta Loupe in Instellingen toe de camera te gebruiken om de code te scannen, of plak in plaats daarvan de tekst van de code.';

  @override
  String get accountImportNoCameraTitle => 'Geen camera';

  @override
  String get accountImportNoCameraText =>
      'Loupe kan hier geen camera gebruiken. Plak in plaats daarvan de tekst van de code.';

  @override
  String get accountImportCameraFailedTitle => 'De camera is niet gestart';

  @override
  String get accountImportCameraFailedText => 'Probeer het opnieuw, of plak in plaats daarvan de tekst van de code.';

  @override
  String get accountImportOpenSettings => 'Instellingen openen';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts gevonden',
      one: '$count account gevonden',
      zero: 'Geen accounts gevonden',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Geen van de accounts in deze codes kon worden gelezen.';

  @override
  String get accountImportChoose => 'Kies de accounts die je aan Loupe wilt toevoegen.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Codes $codes van $total zijn niet gescand, dus de accounts erin staan er niet bij.',
      one: 'Code $codes van $total is niet gescand, dus de accounts erin staan er niet bij.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes en $last';
  }

  @override
  String get accountImportScanMore => 'Meer codes scannen';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count accounts in de codes konden niet worden gelezen. Ze gebruiken mogelijk instellingen uit een nieuwere Thunderbird.',
      one:
          '$count account in de codes kon niet worden gelezen. Het gebruikt mogelijk instellingen uit een nieuwere Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Opnieuw scannen';

  @override
  String get accountImportAlreadyAdded => 'Er staat al een account met dit adres in Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Je logt in met $provider wanneer het is toegevoegd, net als in Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Voeg het account toe met een app-wachtwoord (daarvoor is verificatie in twee stappen nodig).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird logt bij Gmail in met Google. “Inloggen met Google” komt in een latere build; voeg het account tot dan toe met een app-wachtwoord (daarvoor is verificatie in twee stappen nodig).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird logt bij dit account in via de browser. Loupe kan dat nog niet: gebruik een app-wachtwoord als je provider dat aanbiedt.';

  @override
  String get accountImportUnencrypted => 'Verbindt zonder versleuteling. Gebruik dit alleen op je eigen netwerk.';

  @override
  String get accountImportEnterAgain => 'Opnieuw invoeren';

  @override
  String get accountImportAdded => 'Toegevoegd';

  @override
  String accountImportAdding(int index, int total) {
    return '$index van $total toevoegen…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts toevoegen',
      one: '$count account toevoegen',
      zero: 'Accounts toevoegen',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Exporttekst plakken';

  @override
  String get accountImportPasteText => 'Plak de tekst van een Thunderbird-exportcode, één code per regel.';

  @override
  String get accountImportPop3 => 'POP3-accounts worden niet ondersteund. Loupe houdt mail op de server met IMAP.';

  @override
  String get accountImportKerberos => 'Dit account logt in met Kerberos, wat Loupe niet ondersteunt.';

  @override
  String get accountImportNtlm => 'Dit account logt in met NTLM, wat Loupe niet ondersteunt.';

  @override
  String get accountImportClientCertificate =>
      'Dit account logt in met een clientcertificaat, wat Loupe nog niet ondersteunt.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Inloggen met Microsoft komt in een latere build. Outlook- en Microsoft 365-accounts accepteren geen wachtwoorden van mailapps meer.';

  @override
  String get accountImportEnterPassword => 'Voer het wachtwoord in.';

  @override
  String get accountImportEnterAppPassword => 'Voer het app-wachtwoord in.';

  @override
  String get accountImportEnterApiToken => 'Voer het API-token in.';

  @override
  String get accountImportStorageFailed => 'Loupe kon de accountopslag niet openen. Probeer het later opnieuw.';

  @override
  String get accountImportFailed =>
      'Het account kon niet worden toegevoegd. Probeer het opnieuw of voeg het handmatig toe.';

  @override
  String get composeNewMessageTitle => 'Nieuw bericht';

  @override
  String get composeAttach => 'Bijvoegen';

  @override
  String get composeSendLater => 'Later verzenden';

  @override
  String composeSendAt(String time) {
    return '$time verzenden';
  }

  @override
  String get composeSendHint => 'Lang indrukken om later te verzenden';

  @override
  String get composeNoAccount => 'Voeg een account toe om mail te verzenden.';

  @override
  String get composeTo => 'Aan:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Van: $email';
  }

  @override
  String get composeFromLabel => 'Van:';

  @override
  String get composeSubjectLabel => 'Onderwerp:';

  @override
  String composeReplyTo(String address) {
    return 'Antwoord aan: $address';
  }

  @override
  String get composeFrom => 'Van';

  @override
  String composeReplyFrom(String email) {
    return 'Antwoorden vanaf $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Verzenden vanaf $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Antwoorden vanaf $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Verzenden vanaf $email?';
  }

  @override
  String get composeDismiss => 'Sluiten';

  @override
  String composeAliasNotSaved(String account) {
    return 'Niet opgeslagen als identiteit · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Opslaan als identiteit';

  @override
  String composeAliasSaved(String email) {
    return '$email is opgeslagen als identiteit.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ongeldig adres $address';
  }

  @override
  String get composeOriginalNotFound => 'Kan het oorspronkelijke bericht niet vinden.';

  @override
  String get composeDraftNotFound => 'Kan het concept niet vinden.';

  @override
  String get composeAttachmentsLost => 'De bijlagen konden niet worden hersteld. Voeg ze opnieuw toe.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Sommige bijlagen konden niet worden toegevoegd: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Bijlagen samen $size; sommige servers weigeren zulke grote berichten.';
  }

  @override
  String get composeAttachFailed => 'Kan het bestand niet bijvoegen.';

  @override
  String get composeInvalidAddressTitle => 'Ongeldig adres';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” is geen geldig e-mailadres.';
  }

  @override
  String get composeNoSubjectTitle => 'Geen onderwerp';

  @override
  String get composeNoSubjectText => 'Dit bericht heeft geen onderwerp. Toch verzenden?';

  @override
  String get composeSentBeforeChanges => 'Het is verzonden vóór je wijzigingen; die zijn opgeslagen in Concepten.';

  @override
  String composeScheduled(String time) {
    return 'Gepland voor $time';
  }

  @override
  String get composeSending => 'Verzenden…';

  @override
  String get composeSent => 'Verzonden';

  @override
  String get composeSendFailed => 'Verzenden mislukt. Probeer het opnieuw.';

  @override
  String get composeAlreadySent => 'Al verzonden.';

  @override
  String get composeDiscardChanges => 'Wijzigingen negeren';

  @override
  String get composeSaveChanges => 'Wijzigingen opslaan';

  @override
  String get composeDeleteDraft => 'Concept verwijderen';

  @override
  String get composeSaveDraft => 'Concept opslaan';

  @override
  String get composeDraftSaved => 'Concept opgeslagen';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Op $date om $time schreef $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Op $date om $time schreef iemand:';
  }

  @override
  String get composeForwardHeader => '---------- Doorgestuurd bericht ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Van: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date om $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Onderwerp: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Aan: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Later vandaag';

  @override
  String get composeTomorrowMorning => 'Morgenochtend';

  @override
  String get composeMondayMorning => 'Maandagochtend';

  @override
  String get composePickDateTime => 'Datum en tijd kiezen…';

  @override
  String get composeSendWithoutDelay => 'Zonder vertraging verzenden';

  @override
  String composeSendTimeToday(String time) {
    return 'Vandaag om $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Morgen om $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day om $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Vandaag $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Morgen $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Verder met je concept?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Een bericht is niet verzonden toen Loupe werd gesloten.',
      'one': 'Een bericht aan $name is niet verzonden toen Loupe werd gesloten.',
      'other': 'Een bericht aan $name en anderen is niet verzonden toen Loupe werd gesloten.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '“$subject” is niet verzonden toen Loupe werd gesloten.',
      'one': '“$subject” aan $name is niet verzonden toen Loupe werd gesloten.',
      'other': '“$subject” aan $name en anderen is niet verzonden toen Loupe werd gesloten.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Verder bewerken';

  @override
  String get composeRecoverySave => 'Opslaan in Concepten';

  @override
  String get composeRecoveryDiscard => 'Negeren';

  @override
  String get composeRecoverySaved => 'Opgeslagen in Concepten';

  @override
  String get outboxSectionFailed => 'Niet verzonden';

  @override
  String get outboxSectionSending => 'Verzenden';

  @override
  String get outboxSectionScheduled => 'Gepland';

  @override
  String get outboxStatusQueued => 'Wordt zo verzonden';

  @override
  String get outboxStatusSending => 'Verzenden…';

  @override
  String get outboxStatusFailed => 'Niet verzonden';

  @override
  String get outboxNoRecipients => 'Geen ontvangers';

  @override
  String get outboxNoSubject => '(Geen onderwerp)';

  @override
  String get outboxSendingFailed => 'Verzenden mislukt.';

  @override
  String get outboxEmptyTitle => 'Niets te verzenden';

  @override
  String get outboxEmptyText => 'Berichten die je later verstuurt, wachten hier tot het zover is.';

  @override
  String get outboxSendNow => 'Nu verzenden';

  @override
  String get outboxReschedule => 'Opnieuw plannen';

  @override
  String get outboxRescheduleMenu => 'Opnieuw plannen…';

  @override
  String get outboxRescheduleTitle => 'Opnieuw plannen';

  @override
  String outboxRescheduled(String time) {
    return 'Opnieuw gepland voor $time';
  }

  @override
  String get outboxCancel => 'Annuleren';

  @override
  String get outboxCancelSending => 'Verzenden annuleren…';

  @override
  String get outboxCancelTitle => 'Verzenden annuleren?';

  @override
  String get outboxMoveToDrafts => 'Naar Concepten verplaatsen';

  @override
  String get outboxDiscard => 'Bericht negeren';

  @override
  String get outboxMovedToDrafts => 'Naar Concepten verplaatst';

  @override
  String get outboxDiscarded => 'Bericht genegeerd';

  @override
  String get outboxAlreadySent => 'Al verzonden.';

  @override
  String get outboxBeingSent => 'Dit bericht wordt nu verzonden.';

  @override
  String get outboxActionFailed => 'Dat is niet gelukt. Het bericht staat nog in Postvak UIT.';

  @override
  String get notificationsBadgeInboxes => 'Ongelezen in inboxen';

  @override
  String get notificationsBadgeVip => 'Ongelezen in VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nieuwe mail van je VIP’s, in elk account';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nieuwe mail in $email';
  }

  @override
  String get notificationsUnknownSender => 'Onbekende afzender';

  @override
  String get notificationsNoSubject => '(Geen onderwerp)';

  @override
  String get notificationsEncryptedMessage => 'Versleuteld bericht';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nieuw bericht van $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nieuwe berichten',
      one: '$count nieuw bericht',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nieuwe berichten in $account';
  }

  @override
  String get platformInstantChannel => 'Directe bezorging';

  @override
  String get platformInstantChannelDescription =>
      'Wordt getoond terwijl Loupe je inboxen in de gaten houdt voor nieuwe mail';

  @override
  String get platformInstantTitle => 'Wacht op nieuwe mail';

  @override
  String get platformInstantText => 'Directe bezorging staat aan';

  @override
  String get platformErrorBox => 'Er ging iets mis bij het tonen hiervan. Ga terug en probeer het opnieuw.';

  @override
  String get welcomeTagline => 'Mail die eenvoudig is aan de buitenkant\nen krachtig vanbinnen.';

  @override
  String get welcomeAccountsTitle => 'Elk account, één rustige inbox';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail en elke IMAP- of JMAP-server.';

  @override
  String get welcomeSearchTitle => 'Zoeken dat vindt';

  @override
  String get welcomeSearchText => 'Directe resultaten op je telefoon, daarna die van de server.';

  @override
  String get welcomePrivacyTitle => 'Privé vanaf het ontwerp';

  @override
  String get welcomePrivacyText => 'Geen tracking. Externe afbeeldingen blijven geblokkeerd tot jij het zegt.';

  @override
  String get welcomeAddAccount => 'Account toevoegen';

  @override
  String get welcomeImport => 'Importeren uit Thunderbird';

  @override
  String get welcomeTryDemo => 'Proberen met demomail';
}
