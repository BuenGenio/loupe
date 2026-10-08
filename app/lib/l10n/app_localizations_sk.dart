// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get commonAdd => 'Pridať';

  @override
  String get commonCancel => 'Zrušiť';

  @override
  String get commonClose => 'Zavrieť';

  @override
  String get commonDelete => 'Odstrániť';

  @override
  String get commonDone => 'Hotovo';

  @override
  String get commonEdit => 'Upraviť';

  @override
  String get commonMore => 'Viac';

  @override
  String get commonMove => 'Presunúť';

  @override
  String get commonName => 'Meno';

  @override
  String get commonNone => 'Žiadne';

  @override
  String get commonOff => 'Vypnuté';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Zapnuté';

  @override
  String get commonOptional => 'Voliteľné';

  @override
  String get commonPassword => 'Heslo';

  @override
  String get commonRemove => 'Odobrať';

  @override
  String get commonRetry => 'Skúsiť znova';

  @override
  String get commonSave => 'Uložiť';

  @override
  String get commonSearch => 'Hľadať';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Nastavenia';

  @override
  String get commonShare => 'Zdieľať';

  @override
  String get commonTryAgain => 'Skúsiť znova';

  @override
  String get commonUndo => 'Späť';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ',
      few: '$count správy',
      one: '$count správa',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivovať';

  @override
  String get mailDelete => 'Odstrániť';

  @override
  String get mailFlag => 'Označiť zástavkou';

  @override
  String get mailForward => 'Preposlať';

  @override
  String get mailMarkAsRead => 'Označiť ako prečítané';

  @override
  String get mailMarkAsUnread => 'Označiť ako neprečítané';

  @override
  String get mailMoveToJunk => 'Presunúť do nevyžiadanej pošty';

  @override
  String get mailNewMessage => 'Nová správa';

  @override
  String get mailNoSubject => 'Bez predmetu';

  @override
  String get mailReply => 'Odpovedať';

  @override
  String get mailReplyAll => 'Odpovedať všetkým';

  @override
  String get mailSend => 'Odoslať';

  @override
  String get mailUnflag => 'Zrušiť zástavku';

  @override
  String get mailboxArchive => 'Archív';

  @override
  String get mailboxDrafts => 'Koncepty';

  @override
  String get mailboxInbox => 'Doručená pošta';

  @override
  String get mailboxJunk => 'Nevyžiadaná pošta';

  @override
  String get mailboxOutbox => 'Pošta na odoslanie';

  @override
  String get mailboxSent => 'Odoslané';

  @override
  String get mailboxTrash => 'Kôš';

  @override
  String get conversationSomethingWentWrong => 'Niečo sa pokazilo. Skúste to znova.';

  @override
  String get conversationReplyToList => 'Odpovedať do konferencie';

  @override
  String get conversationReplyList => 'Do konferencie';

  @override
  String get conversationThreadMuted => 'Vlákno je stlmené. Nové správy v ňom prídu ako prečítané.';

  @override
  String get conversationThreadUnmuted => 'Stlmenie vlákna je zrušené.';

  @override
  String get conversationLinkFailed => 'Odkaz sa nepodarilo otvoriť.';

  @override
  String get conversationGoneTitle => 'Žiadna správa';

  @override
  String get conversationGoneText => 'Táto správa bola presunutá alebo odstránená.';

  @override
  String get conversationMuted => 'Stlmené';

  @override
  String get conversationReaderOptions => 'Možnosti čítania';

  @override
  String get conversationReaderOptionsHint => 'Veľkosť textu a zobrazenie';

  @override
  String get conversationTrash => 'Do koša';

  @override
  String get conversationReplyHint => 'Podržaním zobrazíte Odpovedať všetkým a Preposlať';

  @override
  String get conversationOfflineTitle => 'Ste offline';

  @override
  String get conversationOfflineText => 'Táto konverzácia ešte nie je stiahnutá. Načíta sa, keď budete znova online.';

  @override
  String get conversationErrorTitle => 'Túto správu nemožno zobraziť';

  @override
  String get conversationErrorText => 'Niečo sa pokazilo.';

  @override
  String get conversationOfflineBanner => 'Ste offline';

  @override
  String get conversationNotUpdated => 'Neaktualizované';

  @override
  String get conversationMe => 'ja';

  @override
  String get conversationNoSender => '(bez odosielateľa)';

  @override
  String get conversationNoRecipients => 'bez príjemcov';

  @override
  String conversationRecipients(String names) {
    return 'komu: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'komu: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Od';

  @override
  String get conversationHeaderTo => 'Komu';

  @override
  String get conversationHeaderCc => 'Kópia';

  @override
  String get conversationHeaderBcc => 'Skrytá kópia';

  @override
  String get conversationHeaderReplyTo => 'Odpovedať komu';

  @override
  String get conversationHeaderDate => 'Dátum';

  @override
  String get conversationHeaderSecurity => 'Zabezpečenie';

  @override
  String get conversationVerifiedSender => 'Overený odosielateľ';

  @override
  String get conversationUnverifiedSender => 'Neoverený odosielateľ';

  @override
  String get conversationLoadingMessage => 'Načítava sa správa';

  @override
  String get conversationBodyError => 'Túto správu sa nepodarilo načítať.';

  @override
  String get conversationBodyOffline => 'Ste offline. Správa sa načíta, keď budete znova online.';

  @override
  String get conversationOriginalHint => 'Lepšie vyzerá v zobrazení Pôvodné';

  @override
  String get conversationShowOriginal => 'Zobraziť pôvodné';

  @override
  String get conversationScrollToTop => 'Posunúť na začiatok';

  @override
  String get conversationTagsMenu => 'Štítky…';

  @override
  String get conversationMuteThread => 'Stlmiť vlákno';

  @override
  String get conversationUnmuteThread => 'Zrušiť stlmenie vlákna';

  @override
  String get conversationMoveMenu => 'Presunúť…';

  @override
  String get conversationDeletePermanently => 'Odstrániť natrvalo';

  @override
  String get conversationMoveToTrash => 'Presunúť do koša';

  @override
  String get conversationNotJunk => 'Nie je nevyžiadaná';

  @override
  String get conversationShowAllHeaders => 'Zobraziť všetky hlavičky';

  @override
  String get conversationViewSource => 'Zobraziť zdroj';

  @override
  String get conversationSaveAsFile => 'Uložiť ako súbor…';

  @override
  String get conversationShareAsFile => 'Zdieľať ako súbor…';

  @override
  String get conversationSearchFromMessageMenu => 'Hľadať podľa tejto správy…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopírovať adresu';

  @override
  String get conversationAddressCopied => 'Adresa je skopírovaná';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Hľadať správy od $name';
  }

  @override
  String get conversationTags => 'Štítky';

  @override
  String get conversationAllHeaders => 'Všetky hlavičky';

  @override
  String get conversationCopyAll => 'Kopírovať všetko';

  @override
  String get conversationHeadersCopied => 'Hlavičky sú skopírované';

  @override
  String get conversationNoHeaders => 'Žiadne hlavičky';

  @override
  String get conversationSearchFromMessageTitle => 'Hľadať podľa tejto správy';

  @override
  String conversationSearchFrom(String name) {
    return 'Od: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Komu: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Predmet „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Zdroj';

  @override
  String get conversationSourceCopied => 'Zdroj je skopírovaný';

  @override
  String get conversationShareFailed => 'Správu sa nepodarilo zdieľať.';

  @override
  String get conversationWrapLines => 'Zalamovať riadky';

  @override
  String get conversationDontWrapLines => 'Nezalamovať riadky';

  @override
  String get conversationSourceError => 'Zdroj sa nepodarilo načítať.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Zobrazuje sa prvých $shown z $total. Celý zdroj získate skopírovaním alebo zdieľaním.';
  }

  @override
  String get conversationAttachmentUntitled => 'Bez názvu';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Ďalšie akcie pre $name';
  }

  @override
  String get conversationMoveTo => 'Presunúť do…';

  @override
  String get conversationMailboxesError => 'Priečinky sa nepodarilo načítať.';

  @override
  String get conversationReaderReadable => 'Čitateľné';

  @override
  String get conversationReaderOriginal => 'Pôvodné';

  @override
  String get conversationReaderPlain => 'Čistý text';

  @override
  String get conversationReaderSans => 'Bezpätkové';

  @override
  String get conversationReaderMono => 'Pevná šírka';

  @override
  String get conversationReaderKeepColours => 'Zachovať pôvodné farby';

  @override
  String get conversationReaderRemember => 'Zapamätať pre tohto odosielateľa';

  @override
  String get conversationSecurityPossiblePhishing => 'Možný phishing';

  @override
  String get conversationSecurityBeCareful => 'Buďte opatrní';

  @override
  String get conversationSecurityVerified => 'Overené';

  @override
  String get conversationSecurityNoIssues => 'Nenašli sa žiadne problémy';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sledovačov',
      few: '$count sledovače',
      one: '$count sledovač',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Zobrazí dôvod';

  @override
  String get conversationPhishingBannerTitle => 'Táto správa vyzerá ako phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Odkazy a obrázky sú vypnuté.';
  }

  @override
  String get conversationPhishingBannerText => 'Odkazy a obrázky sú vypnuté.';

  @override
  String get conversationPhishingWhy => 'Prečo?';

  @override
  String get conversationPhishingShowAnyway => 'Napriek tomu zobraziť';

  @override
  String get conversationSecurityPhishingTitle => 'Vyzerá to ako phishing';

  @override
  String get conversationSecurityPhishingText => 'Viaceré znaky naznačujú, že táto správa nie je tým, za čo sa vydáva.';

  @override
  String get conversationSecurityCarefulTitle => 'Pri tejto správe buďte opatrní';

  @override
  String get conversationSecurityCarefulText => 'Niečo na nej si zaslúži druhý pohľad.';

  @override
  String get conversationSecurityVerifiedText => 'Odosielateľ je overený a nič nevyzerá podozrivo.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nič nevyzerá podozrivo. Váš poštový server neuviedol, či je odosielateľ overený.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nič nevyzerá podozrivo.';

  @override
  String get conversationSecurityWhy => 'Prečo';

  @override
  String get conversationSecurityPrivacy => 'Súkromie';

  @override
  String get conversationSecurityNoTrackingPixels => 'Žiadne sledovacie pixely';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstránených $count sledovacích pixelov',
      few: 'Odstránené $count sledovacie pixely',
      one: 'Odstránený $count sledovací pixel',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Prezradili by odosielateľovi, kedy ste túto správu otvorili.';

  @override
  String get conversationSecurityNoRemoteImages => 'Žiadne vzdialené obrázky';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vzdialených obrázkov',
      few: '$count vzdialené obrázky',
      one: '$count vzdialený obrázok',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ich načítanie prezradí odosielateľovi, kedy ste túto správu čítali, aj vašu IP adresu.';

  @override
  String get conversationSecurityNoClickTracking => 'Žiadne sledovanie kliknutí';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odkazov cez sledovanie kliknutí',
      few: '$count odkazy cez sledovanie kliknutí',
      one: '$count odkaz cez sledovanie kliknutí',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services by zaznamenali vaše kliknutie. Podržaním odkazu otvoríte priamo jeho cieľ.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technické podrobnosti';

  @override
  String get conversationSecurityCheckedLocally => 'Skontrolované v tomto zariadení. Nič sa nikam neodoslalo.';

  @override
  String get conversationSecurityTrackersLabel => 'Sledovače';

  @override
  String get conversationSecurityImagesFrom => 'Obrázky z';

  @override
  String get conversationSecuritySenderHistory => 'História odosielateľa';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'prijaté: $received, odoslané: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Odkazy vedú na';

  @override
  String get conversationSecurityHidden => 'Skryté';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements prvkov',
      few: '$elements prvky',
      one: '$elements prvok',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters znakov',
      few: '$characters znaky',
      one: '$characters znak',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Odosielateľ nie je overený';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Váš poštový server nedokázal potvrdiť, že táto správa naozaj pochádza z domény $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Váš poštový server nedokázal potvrdiť, že táto správa naozaj pochádza od svojho odosielateľa.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Váš poštový server nedokázal potvrdiť, že táto správa pochádza z domény $domain. Pri e-mailových konferenciách je to bežné.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Váš poštový server nedokázal potvrdiť, že táto správa pochádza od svojho odosielateľa. Pri e-mailových konferenciách je to bežné.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nekonajte podľa nej, ak ste ju nečakali. Ak máte pochybnosti, kontaktujte odosielateľa iným spôsobom.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Podpísané inou doménou';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Správu podpísala doména $signer, nie $domain. Robia to rozosielacie služby, no nedokazuje to, kto ju napísal.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Správu podpísala iná doména, nie $domain. Robia to rozosielacie služby, no nedokazuje to, kto ju napísal.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Meno ukazuje inú adresu';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Meno odosielateľa znie „$shown“, ale správa prichádza z adresy $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Verte adrese, nie menu.';

  @override
  String get conversationSecurityReplyToTitle => 'Odpovede idú inam';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vaša odpoveď by išla na adresu $address, nie do domény $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Skôr než odpoviete niečím osobným, skontrolujte adresu.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Používa vaše meno';

  @override
  String get conversationSecurityImpersonationTitle => 'Používa meno niekoho, koho poznáte';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Je podpísaná menom „$name“, rovnakým ako vaše, ale prichádza z novej adresy: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Je podpísaná menom „$name“, ako keby bola od vášho VIP kontaktu $knownName ($knownEmail), ale prichádza z novej adresy: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Je podpísaná menom „$name“, ako keby bola od osoby $knownName ($knownEmail), ale prichádza z novej adresy: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'A odpovede by išli na ďalšiu, inú adresu.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ak žiada peniaze, kódy alebo súbory, najprv si to s danou osobou overte iným spôsobom.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Známa adresa: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Táto adresa: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Prvá správa od tohto odosielateľa';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Z adresy $email ste ešte poštu nedostali.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Pri žiadostiach od ľudí, ktorých ešte nepoznáte, buďte opatrní.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Podobne vyzerajúce písmená v adrese odosielateľa';

  @override
  String get conversationSecurityLinkHomographTitle => 'Podobne vyzerajúce písmená v odkaze';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mieša písmená z rôznych abecied, aby napodobnil inú adresu.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host používa podobne vyzerajúce písmená: nie je to $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Odstráňte ju alebo ju nahláste ako nevyžiadanú.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Neotvárajte ho.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Doména: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Podobne vyzerajúca doména';

  @override
  String get conversationSecurityFamiliarNameTitle => 'V doméne používa známe meno';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain vyzerá ako vaša vlastná doména $real, ale je to iná doména.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain vyzerá ako $brand ($real), ale je to iná doména.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain používa názov vašej vlastnej domény $real, ale nepatrí k nej.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain používa názov $brand ($real), ale nemá s ním nič spoločné.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Skutočné správy z vašej organizácie prichádzajú z $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Skutočné správy od $brand prichádzajú z $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Doména odosielateľa: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Napodobňuje: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odkazov skrýva, kam vedú',
      few: '$count odkazy skrývajú, kam vedú',
      one: 'Odkaz skrýva, kam vedie',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Odkaz ukazuje $shown, ale otvára $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Cez tieto odkazy sa neprihlasujte ani neplaťte. Adresu radšej zadajte sami.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Cieľ odkazu nemožno overiť';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Odkaz ukazuje $shown, ale vedie cez $host, ktorý kliknutie zaznamená a až potom ho pošle ďalej.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Odkaz smeruje na holú IP adresu';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nie je pomenovaná webová stránka. Skutočné firmy takto odkazujú len zriedka.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Maskovaný odkaz';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Odkaz začína „$shown@“, aby vyzeral ako $shown, ale otvára $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Skrytá stránka bola zablokovaná';

  @override
  String get conversationSecurityDataLinkText =>
      'Odkaz by otvoril stránku zabalenú priamo v správe, čo je spôsob, ako obísť kontrolu odkazov.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Žiada heslo';

  @override
  String get conversationSecurityPasswordFieldText => 'Správa obsahovala pole na zadanie hesla. Loupe ho odstránila.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nikdy nezadávajte heslo do e-mailu.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Odkaz, ktorý spúšťa kód, bol zablokovaný';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nikdy nespúšťa kód zo správ.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Skrátené odkazy', one: 'Skrátený odkaz');
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skrýva skutočný cieľ, kým odkaz neotvoríte.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Medzinárodná webová adresa';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts používa nelatinské písmená. V mnohých jazykoch je to normálne; overte si, že ide o stránku, ktorú očakávate.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Veľa skrytého textu';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstránilo sa $count znakov neviditeľného textu. Takýto skrytý text má oklamať spamové filtre.',
      few: 'Odstránili sa $count znaky neviditeľného textu. Takýto skrytý text má oklamať spamové filtre.',
      one: 'Odstránil sa $count znak neviditeľného textu. Takýto skrytý text má oklamať spamové filtre.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skrytý text bol odstránený';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstránilo sa $count znakov neviditeľného textu.',
      few: 'Odstránili sa $count znaky neviditeľného textu.',
      one: 'Odstránil sa $count znak neviditeľného textu.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Správu sa nepodarilo stiahnuť. Skontrolujte pripojenie a skúste to znova.';

  @override
  String exportSaved(String name) {
    return 'Uložené: „$name“';
  }

  @override
  String get exportSaveFailed => 'Správu sa nepodarilo uložiť.';

  @override
  String exportFailed(String folder) {
    return 'Priečinok „$folder“ sa nepodarilo exportovať.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Priečinok „$folder“ nemá žiadne správy na export.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Priečinok „$folder“ sa nepodarilo exportovať: nepodarilo sa stiahnuť žiadnu správu. Skontrolujte pripojenie a skúste to znova.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uložené „$name“ bez $formattedCount správ, ktoré sa nepodarilo stiahnuť.',
      few: 'Uložené „$name“ bez $formattedCount správ, ktoré sa nepodarilo stiahnuť.',
      one: 'Uložené „$name“ bez $count správy, ktorú sa nepodarilo stiahnuť.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ sa nepodarilo uložiť.';
  }

  @override
  String exportTitle(String folder) {
    return 'Exportuje sa „$folder“';
  }

  @override
  String get exportListing => 'Hľadajú sa správy…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportuje sa $current z $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount správ sa nepodarilo stiahnuť',
      few: '$formattedCount správy sa nepodarilo stiahnuť',
      one: '$count správu sa nepodarilo stiahnuť',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Schránky';

  @override
  String get mailboxesShown => 'Zobrazené';

  @override
  String get mailboxesHidden => 'Skryté';

  @override
  String get mailboxesCollapse => 'Zbaliť';

  @override
  String get mailboxesExpand => 'Rozbaliť';

  @override
  String get mailboxesManageVips => 'Spravovať VIP';

  @override
  String get mailboxesSubscriptions => 'Odbery';

  @override
  String mailboxesShowAccount(String account) {
    return 'Zobraziť $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Skryť $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportovať priečinok…';

  @override
  String get mailboxesUnpin => 'Odopnúť';

  @override
  String get mailboxesLists => 'Konferencie';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Uložte vyhľadávanie a zostane tu.';

  @override
  String get mailboxesTags => 'Štítky';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'V správe môžete tiež ťuknúť na meno odosielateľa a zapnúť VIP.';

  @override
  String get mailboxesAddVip => 'Pridať VIP…';

  @override
  String get mailboxesAddVipTitle => 'Pridať VIP';

  @override
  String get mailboxesAddVipText => 'Pošta z tejto adresy dostane hviezdičku a zobrazí sa v schránke VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Neprečítané';

  @override
  String get messageListFilterFlagged => 'So zástavkou';

  @override
  String get messageListFilterToMe => 'Adresované mne';

  @override
  String get messageListFilterCcMe => 'Ja v kópii';

  @override
  String get messageListFilterWithAttachments => 'S prílohami';

  @override
  String get messageListFilterUnreplied => 'Bez odpovede';

  @override
  String get messageListFilterFromVips => 'Od VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ označených ako prečítané',
      few: '$count správy označené ako prečítané',
      one: '$count správa označená ako prečítaná',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Staršiu poštu sa nepodarilo načítať.';

  @override
  String get messageListSelectMessages => 'Vyberte správy';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vybraných',
      few: '$count vybrané',
      one: '$count vybraná',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Vybrať všetko';

  @override
  String get messageListDeselectAll => 'Zrušiť výber';

  @override
  String get messageListLoadFailed => 'Poštu sa nepodarilo načítať';

  @override
  String get messageListNoUnread => 'Žiadna neprečítaná pošta';

  @override
  String get messageListNoMatches => 'Žiadna zodpovedajúca pošta';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrované podľa: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Vypnúť filter';

  @override
  String get messageListEmpty => 'Žiadna pošta';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kritériá filtra: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrované podľa:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount neprečítaných',
      few: '$formattedCount neprečítané',
      one: '$count neprečítaná',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Označiť';

  @override
  String get messageListTrash => 'Do koša';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'ZAHRNÚŤ';

  @override
  String get panesHideMailboxes => 'Skryť schránky';

  @override
  String get panesShowMailboxes => 'Zobraziť schránky';

  @override
  String get panesMailboxesWidth => 'Šírka schránok';

  @override
  String get panesListWidth => 'Šírka zoznamu správ';

  @override
  String get panesNoMessageSelected => 'Nie je vybraná žiadna správa';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ',
      few: '$count správy',
      one: '$count správa',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Odložené';

  @override
  String get snoozeSheetTitle => 'Odložiť';

  @override
  String get snoozeLaterToday => 'Neskôr dnes';

  @override
  String get snoozeThisEvening => 'Dnes večer';

  @override
  String get snoozeTomorrow => 'Zajtra';

  @override
  String get snoozeThisWeekend => 'Tento víkend';

  @override
  String get snoozeNextWeek => 'Budúci týždeň';

  @override
  String get snoozePickDateTime => 'Vybrať dátum a čas…';

  @override
  String get snoozeMenu => 'Odložiť…';

  @override
  String get snoozeWakeNow => 'Vrátiť teraz';

  @override
  String get snoozeChangeTimeMenu => 'Zmeniť čas odloženia…';

  @override
  String get snoozeChangeTime => 'Zmeniť čas';

  @override
  String get snoozeNoTime => 'Čas nie je nastavený';

  @override
  String get snoozeFooter => 'Odložené správy sa v nastavenom čase vrátia do doručenej pošty ako neprečítané.';

  @override
  String get snoozeEmptyTitle => 'Nič nie je odložené';

  @override
  String get snoozeEmptyText => 'Odložte správu a vráti sa do doručenej pošty, keď ju budete potrebovať.';

  @override
  String get appLockUnlock => 'Odomknúť';

  @override
  String get appLockFailed => 'Loupe nedokázala overiť, že ste to vy.';

  @override
  String get appLockLockedOut => 'Príliš veľa pokusov. Skúste to neskôr.';

  @override
  String get appLockPromptError => 'Výzvu sa nepodarilo zobraziť. Skúste to znova.';

  @override
  String get appLockNoScreenLock => 'Tento telefón nemá zámku obrazovky.';

  @override
  String get appLockUnlockPromptTitle => 'Odomknúť Loupe';

  @override
  String get appLockUnlockPromptReason => 'Overte svoju totožnosť a zobrazte poštu.';

  @override
  String get appLockTurnOnPromptTitle => 'Zapnúť zámok aplikácie';

  @override
  String get appLockTurnOnPromptReason => 'Overte svoju totožnosť a zapnite zámok aplikácie.';

  @override
  String get appLockScreenLockRemoved =>
      'Zámok aplikácie je vypnutý: tento telefón už nemá zámku obrazovky. Ak ho chcete znova zapnúť, nastavte si zámku obrazovky.';

  @override
  String get appLockAfterImmediately => 'Okamžite';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minút',
      few: '$count minúty',
      one: '$count minúta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hodín',
      few: '$count hodiny',
      one: '$count hodina',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Zašifrované';

  @override
  String get openpgpEncryptedInPart => 'Čiastočne zašifrované';

  @override
  String get openpgpEncryptedLocked => 'Zašifrované · zamknuté';

  @override
  String get openpgpEncryptedNoKey => 'Zašifrované · chýba kľúč';

  @override
  String get openpgpEncryptedDamaged => 'Zašifrované · poškodené';

  @override
  String get openpgpEncryptedUnsupported => 'Zašifrované · nepodporované';

  @override
  String get openpgpUnknownSigner => 'neznámy';

  @override
  String get openpgpUnknownKey => 'Neznámy kľúč';

  @override
  String get openpgpSignatureInvalid => 'Neplatný podpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Podpísané: $name, nie odosielateľ';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Čiastočne podpísané: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Podpísané: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Podpísané odmietnutým kľúčom';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Podpísané: $name · kľúč neprijatý';
  }

  @override
  String get openpgpUnlock => 'Odomknúť';

  @override
  String get openpgpCantDecrypt => 'Túto správu nemožno dešifrovať';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Zašifrované pomocou OpenPGP';

  @override
  String get openpgpEncryption => 'Šifrovanie';

  @override
  String get openpgpDecryptedHere => 'Dešifrované v tomto zariadení';

  @override
  String get openpgpNotDecrypted => 'Nedešifrované';

  @override
  String get openpgpKeyLocked => 'Váš kľúč je zamknutý.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Pre kľúče $keys', one: 'Pre kľúč $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Chránený predmet';

  @override
  String get openpgpUnlockKey => 'Odomknúť kľúč';

  @override
  String get openpgpSignature => 'Podpis';

  @override
  String get openpgpFingerprint => 'Odtlačok';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID kľúča $id';
  }

  @override
  String get openpgpSigned => 'Podpísané';

  @override
  String get openpgpProblem => 'Problém';

  @override
  String get openpgpAcceptance => 'Prijatie';

  @override
  String get openpgpChangeAcceptance => 'Zmeniť prijatie…';

  @override
  String get openpgpCheckedFooter => 'Skontrolované v tomto zariadení pomocou OpenPGP, kompatibilné s Thunderbirdom.';

  @override
  String get openpgpSummaryLocked =>
      'Váš kľúč je zamknutý. Ak si chcete prečítať túto správu, odomknite ho prístupovou frázou.';

  @override
  String get openpgpSummaryNoSecretKey => 'Bola zašifrovaná pre kľúč, ktorý nie je v tomto zariadení.';

  @override
  String get openpgpSummaryDamaged => 'Zašifrované údaje sú poškodené alebo boli cestou zmenené.';

  @override
  String get openpgpSummaryUnsupported => 'Používa algoritmus, ktorý Loupe nepodporuje.';

  @override
  String get openpgpSummaryEncrypted => 'Môžete si ju prečítať len vy a ostatní príjemcovia.';

  @override
  String get openpgpSummaryNotSigned => 'Nie je podpísaná, takže odosielateľ nie je potvrdený.';

  @override
  String get openpgpSummaryUnknownKey => 'Je podpísaná, ale kľúčom, ktorý nemáte, takže podpis nemožno overiť.';

  @override
  String get openpgpSummaryBadSignature => 'Podpis nesedí: správa mohla byť zmenená.';

  @override
  String get openpgpSummaryMismatch => 'Podpis je platný, ale kľúč patrí inej adrese, než je adresa odosielateľa.';

  @override
  String get openpgpSummaryPartial =>
      'Podpísaná je len časť správy. Text mimo podpisu (napríklad päta e-mailovej konferencie) sa zobrazuje pod riadkom „Unsigned content“ a podpis nepokrýva ani ďalšie časti správy, napríklad prílohy.';

  @override
  String get openpgpSummaryOwnKey => 'Podpísané vaším vlastným kľúčom.';

  @override
  String get openpgpSummaryVerified => 'Podpis je platný a odtlačok kľúča ste overili.';

  @override
  String get openpgpSummaryUnverified => 'Podpis je platný. Kľúč ste prijali bez kontroly jeho odtlačku.';

  @override
  String get openpgpSummaryRejected => 'Podpis je platný, ale tento kľúč ste odmietli.';

  @override
  String get openpgpSummaryUndecided =>
      'Podpis je platný, ale tento kľúč ste ešte neprijali. Porovnajte jeho odtlačok s odosielateľom.';

  @override
  String get openpgpAcceptanceRejected => 'Odmietnutý';

  @override
  String get openpgpAcceptanceUndecided => 'Neprijatý';

  @override
  String get openpgpAcceptanceUnverified => 'Prijatý';

  @override
  String get openpgpAcceptanceVerified => 'Prijatý a overený';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Prijať kľúč osoby $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Odtlačok $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Áno, odtlačok je overený';

  @override
  String get openpgpAcceptUnverified => 'Áno, bez kontroly';

  @override
  String get openpgpAcceptLater => 'Zatiaľ nie';

  @override
  String get openpgpRejectKey => 'Odmietnuť tento kľúč';

  @override
  String get openpgpNoSubject => '(bez predmetu)';

  @override
  String get openpgpEncryptionTitle => 'End-to-end šifrovanie';

  @override
  String get openpgpMyKeys => 'Moje kľúče OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'S kľúčom môžete čítať zašifrovanú poštu a podpisovať a šifrovať vlastnú. Používate Thunderbird? Exportujte tam svoj kľúč (Nastavenia účtu › End-to-end šifrovanie › Exportovať tajný kľúč) a importujte ho sem.';

  @override
  String get openpgpAddKey => 'Pridať kľúč…';

  @override
  String get openpgpAddresses => 'Adresy';

  @override
  String get openpgpAddressesFooter => 'Ktorý kľúč používa každá adresa a kedy šifruje a podpisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'Kľúče OpenPGP korešpondentov';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Kľúč prijmite, keď dôverujete, že patrí svojmu vlastníkovi; ak s ním porovnáte odtlačok, označíte ho ako overený.';

  @override
  String get openpgpImportPublicKey => 'Importovať verejný kľúč…';

  @override
  String get openpgpCollected => 'Získané cez Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Kľúče, ktoré prišli so správami. Loupe pre ne dokáže šifrovať, keď o to požiadajú obe strany.';

  @override
  String get openpgpOnThisDevice => 'V tomto zariadení';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Zašifrované správy skrývajú svoj predmet. Loupe si predmet každej správy, ktorú otvoríte, uloží do svojej šifrovanej databázy v tomto zariadení, aby sa zobrazoval v zozname, vo vyhľadávaní a v upozorneniach. Na pozadí dokáže Loupe dešifrovať aj predmety nových správ pomocou kľúčov bez prístupovej frázy; na to stiahne každú správu (do 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Dešifrovať predmety na pozadí';

  @override
  String get openpgpIndexFooter =>
      'Vyhľadávanie nájde zašifrované správy podľa odosielateľa, príjemcov a predmetu. Keď je táto možnosť zapnutá, Loupe pridá do indexu vyhľadávania vo svojej šifrovanej databáze v tomto zariadení aj text každej zašifrovanej správy, ktorú dešifruje, takže vyhľadávanie ju nájde aj podľa textu. Vypnutím sa tento text z indexu odstráni.';

  @override
  String get openpgpIndexDecrypted => 'Indexovať dešifrované správy na vyhľadávanie';

  @override
  String get openpgpPassphrases => 'Prístupové frázy';

  @override
  String get openpgpPassphrasesFooter =>
      'Kľúče OpenPGP a certifikáty S/MIME chránené prístupovou frázou sa odomknú, keď je to potrebné. Bez možnosti „Zapamätať“ sa dve minúty po každom použití znova zamknú.';

  @override
  String get openpgpRememberPassphrases => 'Zapamätať prístupové frázy';

  @override
  String get openpgpRememberPassphrasesDetail => 'Kým sa Loupe nezatvorí';

  @override
  String get openpgpLockKeysNow => 'Zamknúť kľúče teraz';

  @override
  String get openpgpKeysLocked => 'Kľúče sú zamknuté.';

  @override
  String get openpgpKeyStateRevoked => 'odvolaný';

  @override
  String get openpgpKeyStateExpired => 'platnosť vypršala';

  @override
  String get openpgpKeyStateNeverExpires => 'nikdy nevyprší';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'vyprší $date';
  }

  @override
  String get openpgpNoKey => 'Bez kľúča';

  @override
  String get openpgpAlwaysEncrypt => 'Vždy šifrovať';

  @override
  String get openpgpAddKeyTitle => 'Pridať kľúč OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importujte kľúč, ktorý používate v Thunderbirde, alebo vytvorte nový.';

  @override
  String get openpgpImportFromClipboard => 'Importovať zo schránky';

  @override
  String get openpgpImportFromFile => 'Importovať zo súboru';

  @override
  String get openpgpGenerateNewKey => 'Vytvoriť nový kľúč';

  @override
  String get openpgpImportPublicKeyTitle => 'Importovať verejný kľúč';

  @override
  String get openpgpFromClipboard => 'Zo schránky';

  @override
  String get openpgpFromFile => 'Zo súboru';

  @override
  String get openpgpClipboardEmpty => 'Schránka je prázdna. Najprv skopírujte kľúč.';

  @override
  String get openpgpKey => 'Kľúč';

  @override
  String get openpgpValidityRevoked => 'Odvolaný';

  @override
  String openpgpValidityExpired(String date) {
    return 'Platnosť vypršala $date';
  }

  @override
  String get openpgpNeverExpires => 'Nikdy nevyprší';

  @override
  String openpgpValidUntil(String date) {
    return 'Platný do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Odtlačok je skopírovaný.';

  @override
  String get openpgpAlgorithm => 'Algoritmus';

  @override
  String get openpgpCreated => 'Vytvorený';

  @override
  String get openpgpValidity => 'Platnosť';

  @override
  String get openpgpProtection => 'Ochrana';

  @override
  String get openpgpProtectionPassphrase => 'Prístupová fráza';

  @override
  String get openpgpProtectionKeychain => 'Len úložisko kľúčov';

  @override
  String get openpgpKeyDetailsFooter =>
      'Zdieľajte svoj verejný kľúč, aby vám ostatní mohli posielať šifrovanú poštu. Záloha je váš tajný kľúč, chránený prístupovou frázou, ak ju má: uchovajte ju v súkromí.';

  @override
  String get openpgpSharePublicKey => 'Zdieľať verejný kľúč';

  @override
  String get openpgpCopyPublicKey => 'Kopírovať verejný kľúč';

  @override
  String get openpgpPublicKeyCopied => 'Verejný kľúč je skopírovaný.';

  @override
  String get openpgpBackUpSecretKey => 'Zálohovať tajný kľúč';

  @override
  String get openpgpDeleteKey => 'Odstrániť kľúč';

  @override
  String get openpgpRemoveKey => 'Odobrať kľúč';

  @override
  String get openpgpBackUpTitle => 'Zálohovať tajný kľúč?';

  @override
  String get openpgpBackUpProtected =>
      'Záloha je chránená prístupovou frázou vášho kľúča. Ktokoľvek, kto má oboje, môže čítať vašu poštu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Tento kľúč nemá prístupovú frázu: ktokoľvek so zálohou môže čítať vašu poštu a podpisovať sa ako vy.';

  @override
  String get openpgpBackUp => 'Zálohovať';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Odstrániť váš kľúč $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Odobrať kľúč osoby $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Poštu zašifrovanú pre tento kľúč už v tomto zariadení neprečítate, kým ho znova neimportujete.';

  @override
  String get openpgpRemoveKeyMessage => 'Neskôr ho môžete znova importovať.';

  @override
  String get openpgpKeyHeader => 'Kľúč OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Ak chcete šifrovať a podpisovať poštu z tejto adresy, pridajte kľúč v časti End-to-end šifrovanie.';

  @override
  String get openpgpGenerateAKey => 'Vytvoriť kľúč…';

  @override
  String get openpgpSending => 'Odosielanie';

  @override
  String get openpgpSendingFooter =>
      'Automatické šifrovanie sa zapne, keď má každý príjemca prijatý kľúč alebo dôveryhodný certifikát, alebo keď Autocrypt uvádza, že ho chcú obe strany. Zašifrovaná pošta je vždy podpísaná.';

  @override
  String get openpgpEncryptAutomatically => 'Šifrovať automaticky';

  @override
  String get openpgpAlwaysEncryptDetail => 'Neodošle, ak niektorý príjemca nemá kľúč';

  @override
  String get openpgpSignUnencrypted => 'Podpisovať nezašifrovanú poštu';

  @override
  String get openpgpAttachPublicKey => 'Priložiť môj verejný kľúč';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt posiela váš verejný kľúč s každou správou, takže vám iné aplikácie môžu posielať šifrovanú poštu bez akéhokoľvek nastavovania.';

  @override
  String get openpgpSendMyKey => 'Posielať môj kľúč s poštou';

  @override
  String get openpgpPreferEncryption => 'Uprednostniť šifrovanie';

  @override
  String get openpgpPreferEncryptionDetail => 'Požiadať ostatných, aby šifrovali, keď môžu';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rokov',
      few: '$count roky',
      one: '$count rok',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Prístupové frázy sa nezhodujú.';

  @override
  String openpgpKeyReady(String id) {
    return 'Váš kľúč $id je pripravený.';
  }

  @override
  String get openpgpNewKey => 'Nový kľúč';

  @override
  String get openpgpNewKeyFor => 'Pre';

  @override
  String get openpgpYourName => 'Vaše meno';

  @override
  String get openpgpAddress => 'Adresa';

  @override
  String get openpgpPassphrase => 'Prístupová fráza';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Voliteľné. Bez nej chráni kľúč len úložisko kľúčov vo vašom telefóne a Loupe sa nikdy nepýta. S ňou sa na ňu Loupe opýta, keď bude kľúč potrebný.';

  @override
  String get openpgpRepeatPassphrase => 'Zopakovať';

  @override
  String get openpgpExpires => 'Platnosť';

  @override
  String get openpgpExpiresFooter =>
      'Pred vypršaním platnosti môžete vytvoriť nový kľúč. Thunderbird tiež používa tri roky.';

  @override
  String get openpgpGenerateKey => 'Vytvoriť kľúč';

  @override
  String get openpgpKeyFor => 'Kľúč pre';

  @override
  String get openpgpCantEncrypt => 'Nemožno zašifrovať';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Pre $names neexistuje kľúč OpenPGP a táto adresa vždy šifruje. Odoberte príjemcu alebo importujte jeho kľúč v časti Nastavenia › End-to-end šifrovanie.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Pre $names neexistuje platný certifikát S/MIME a táto adresa vždy šifruje. Odoberte príjemcu alebo importujte jeho certifikát v časti Nastavenia › End-to-end šifrovanie.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Pre $names neexistuje kľúč OpenPGP.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Pre $names neexistuje platný certifikát S/MIME.';
  }

  @override
  String get openpgpSendUnencrypted => 'Odoslať nezašifrované';

  @override
  String get openpgpCantSign => 'Nemožno podpísať';

  @override
  String get openpgpCantSignMessage =>
      'Súkromný kľúč vášho certifikátu S/MIME nie je v tomto zariadení. Znova importujte certifikát (súbor .p12 alebo .pfx) v časti Nastavenia › End-to-end šifrovanie.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Žiadny kľúč pre $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Žiadny certifikát pre $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Kľúče z Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Všetci majú kľúč';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Všetci majú certifikát';

  @override
  String get openpgpComposeEncrypt => 'Šifrovať';

  @override
  String get openpgpComposeSign => 'Podpísať';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, prepnúť';
  }

  @override
  String get openpgpNoKeyFound => 'Nenašiel sa žiadny kľúč OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importovať tajný kľúč?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Táto príloha obsahuje tajný kľúč ($names). Ako vlastný kľúč ho importujte, len ak ste ho sami exportovali, napríklad z Thunderbirdu.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importovať ako môj kľúč';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'váš kľúč $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importovať $count kľúčov ($names)?',
      few: 'Importovať $count kľúče ($names)?',
      one: 'Importovať kľúč osoby $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importovať a prijať';

  @override
  String get openpgpImportDecideLater => 'Importovať, rozhodnúť neskôr';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'kľúč osoby $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importované: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Je priložených $count kľúčov OpenPGP.',
      few: 'Sú priložené $count kľúče OpenPGP.',
      one: 'Je priložený kľúč OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importovať';

  @override
  String get openpgpUnlockKeyTitle => 'Odomknúť kľúč OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Zadajte prístupovú frázu kľúča $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Prístupová fráza je nesprávna. Skúste to znova.';

  @override
  String get openpgpExplainLocked =>
      'Táto správa je zašifrovaná. Ak si ju chcete prečítať, odomknite svoj kľúč OpenPGP.';

  @override
  String get openpgpExplainNoKey =>
      'Táto správa je zašifrovaná, ale nie pre žiadny kľúč OpenPGP v tomto zariadení. Ak ju čítate v Thunderbirde, importujte odtiaľ svoj kľúč: Nastavenia › End-to-end šifrovanie.';

  @override
  String get openpgpExplainDamaged => 'Táto zašifrovaná správa je poškodená, takže ju nemožno bezpečne dešifrovať.';

  @override
  String get openpgpExplainUnsupported => 'Táto správa používa šifrovanie, ktoré Loupe zatiaľ nedokáže prečítať.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Táto správa je zašifrovaná pomocou S/MIME, ale nie pre žiadny certifikát v tomto zariadení. Importujte svoj certifikát (súbor .p12 alebo .pfx) v časti Nastavenia › End-to-end šifrovanie.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Táto správa je zašifrovaná. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Ak si ju chcete prečítať, odomknite svoj certifikát S/MIME.';

  @override
  String get openpgpAttachmentGone => 'Táto príloha už nie je k dispozícii.';

  @override
  String get smimeEncrypted => 'Zašifrované (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Zašifrované (S/MIME) · chýba certifikát';

  @override
  String get smimeEncryptedDamaged => 'Zašifrované (S/MIME) · poškodené';

  @override
  String get smimeEncryptedUnsupported => 'Zašifrované (S/MIME) · nepodporované';

  @override
  String get smimeEncryptedLocked => 'Zašifrované (S/MIME) · zamknuté';

  @override
  String get smimeUnknownSigner => 'neznámy';

  @override
  String get smimeSignatureModified => 'Neplatný podpis: správa bola zmenená';

  @override
  String get smimeSignatureWeak => 'Nezabezpečený podpis: zastaraný algoritmus';

  @override
  String get smimeSignatureUncheckable => 'Podpis nemožno overiť';

  @override
  String get smimeSignedCertificateMissing => 'Podpísané · chýba certifikát';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Podpísané: $name · certifikát odvolaný';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Podpísané: $name · v inom dátume';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Podpísané: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Podpísané: $name · neplatný certifikát';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Podpísané: $name · nedôveryhodné';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Podpísané: $name · platnosť certifikátu vypršala';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Podpísané: $name · certifikát ešte nie je platný';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Podpísané: $name · certifikát nie je na poštu';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Podpísané: $name, nie odosielateľ';
  }

  @override
  String get smimeCantDecrypt => 'Túto správu nemožno dešifrovať';

  @override
  String get smimeEncryptedWithSmime => 'Zašifrované pomocou S/MIME';

  @override
  String get smimeEncryption => 'Šifrovanie';

  @override
  String get smimeDecryptedHere => 'Dešifrované v tomto zariadení';

  @override
  String get smimeNotDecrypted => 'Nedešifrované';

  @override
  String get smimeAuthenticated => 'overené';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pre $count certifikátov',
      few: 'pre $count certifikáty',
      one: 'pre $count certifikát',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Podpis';

  @override
  String get smimeIssuedBy => 'Vydal';

  @override
  String get smimeValid => 'Platnosť';

  @override
  String smimeValidRange(String from, String to) {
    return 'od $from do $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Odtlačok SHA-256';

  @override
  String get smimeSigned => 'Podpísané';

  @override
  String get smimeProblem => 'Problém';

  @override
  String get smimeCheckingRevocation => 'Kontroluje sa odvolanie…';

  @override
  String get smimeNotRevoked => 'Neodvolaný';

  @override
  String get smimeRevoked => 'Odvolaný';

  @override
  String get smimeRevocationUnknown => 'Odvolanie neznáme';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Overené u autority (zoznam odvolaných certifikátov), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Overené u autority (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Dôverovať „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Dôverovať tomuto certifikátu…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Skontrolované v tomto zariadení pomocou S/MIME, kompatibilné s Outlookom a Thunderbirdom; odvolanie overené u certifikačnej autority.';

  @override
  String get smimeCheckedFooter =>
      'Skontrolované v tomto zariadení pomocou S/MIME, kompatibilné s Outlookom a Thunderbirdom. Odvolanie sa nekontroluje (Nastavenia › End-to-end šifrovanie).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Dôverovať autorite $name pre poštu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Dôverovať certifikátu osoby $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Bude sa dôverovať každému certifikátu, ktorý táto autorita vydá, podobne ako certifikačnej autorite vašej firmy. Najprv porovnajte odtlačok s jej vlastníkom:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Najprv porovnajte odtlačok s jeho vlastníkom:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Dôverovať';

  @override
  String get smimeSummaryNoKey => 'Bola zašifrovaná pre certifikát, ktorý nie je v tomto zariadení.';

  @override
  String get smimeSummaryDamaged => 'Zašifrované údaje sú poškodené alebo boli cestou zmenené.';

  @override
  String get smimeSummaryUnsupported => 'Používa algoritmus, ktorý Loupe nepodporuje.';

  @override
  String get smimeSummaryLocked => 'Váš certifikát S/MIME je zamknutý.';

  @override
  String get smimeSummaryEncrypted => 'Môžete si ju prečítať len vy a ostatní príjemcovia.';

  @override
  String get smimeSummaryNotSigned => 'Nie je podpísaná, takže odosielateľ nie je potvrdený.';

  @override
  String get smimeSummaryModified => 'Podpis nesedí: správa bola po podpísaní zmenená.';

  @override
  String get smimeSummaryUncheckable => 'Podpis nemožno overiť.';

  @override
  String get smimeSummaryNoCertificate => 'Certifikát podpisujúceho nie je v správe, takže ho nemožno overiť.';

  @override
  String get smimeSummaryRevoked =>
      'Certifikačná autorita odvolala certifikát podpisujúceho: podpisu nemožno dôverovať.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikačná autorita odvolala certifikát podpisujúceho ($reason): podpisu nemožno dôverovať.';
  }

  @override
  String get smimeDateMismatch =>
      'Bola podpísaná viac ako hodinu od dátumu správy: môže ísť o starú správu odoslanú znova.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Podpis je platný a $issuer ručí za to, že certifikát patrí odosielateľovi.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikát alebo niektorý z jeho vydavateľov je neplatný.';

  @override
  String get smimeProblemUntrusted => 'Certifikát pochádza od autority, ktorej Loupe nedôveruje.';

  @override
  String get smimeProblemExpired => 'Platnosť certifikátu vypršala.';

  @override
  String get smimeProblemNotYetValid => 'Certifikát ešte nebol platný.';

  @override
  String get smimeProblemWrongUsage => 'Certifikát nie je určený na poštu.';

  @override
  String get smimeProblemWrongAddress => 'Certifikát patrí inej adrese, než je adresa odosielateľa.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Dôveryhodný · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nedôveryhodný · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Platnosť vypršala $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Platný od $date';
  }

  @override
  String get smimeTrustInvalid => 'Neplatný';

  @override
  String get smimeTrustNotForMail => 'Nie je na poštu';

  @override
  String get smimeTrustAnotherAddress => 'Iná adresa';

  @override
  String get smimeMyCertificates => 'Moje certifikáty S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Pre S/MIME, ako ho používa Outlook a mnohé firmy. Importujte svoj certifikát so súkromným kľúčom (súbor .p12 alebo .pfx) exportovaný z Outlooku, Windowsu, macOS alebo Thunderbirdu.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Pre S/MIME, ako ho používa Outlook a mnohé firmy. Importujte svoj certifikát so súkromným kľúčom (súbor .p12 alebo .pfx) exportovaný z Outlooku, Windowsu, macOS alebo Thunderbirdu, alebo použite certifikát, ktorý ste vy alebo vaša firma nainštalovali do tohto zariadenia.';

  @override
  String get smimeCertificateExpired => 'platnosť vypršala';

  @override
  String smimeCertificateUntil(String date) {
    return 'do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'v tomto zariadení';

  @override
  String get smimeImportCertificateEllipsis => 'Importovať certifikát…';

  @override
  String get smimeUseDeviceCertificate => 'Použiť certifikát z tohto zariadenia…';

  @override
  String get smimeCorrespondentsCertificates => 'Certifikáty korešpondentov';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Získané z podpísanej pošty, rovnako ako to robí Outlook a Thunderbird. Pošta sa šifruje len pre dôveryhodné certifikáty: Loupe dôveruje autoritám, ktorým Mozilla dôveruje pre e-mail, a tým, ktoré pridáte.';

  @override
  String get smimeRevocation => 'Odvolanie';

  @override
  String get smimeRevocationFooter =>
      'Keď otvoríte podpísanú poštu, Loupe sa opýta autority, ktorá vydala certifikát podpisujúceho, či ho neodvolala (jej OCSP respondera alebo zoznamu odvolaných certifikátov). Autorita potom môže vidieť, kedy niekto z vašej internetovej adresy číta poštu podpísanú týmto certifikátom. Odpovede sa uchovávajú v tomto zariadení, kým nevyprší ich platnosť. Odvolaný certifikát sa v hlavičke správy zobrazí ako „odvolaný“.';

  @override
  String get smimeCheckRevocation => 'Kontrolovať odvolanie certifikátov online';

  @override
  String get smimeTrustedAuthorities => 'Dôveryhodné autority';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Autority, ktorým dôverujete vy, okrem $count autorít, ktorým Mozilla dôveruje pre e-mail.',
      few: 'Autority, ktorým dôverujete vy, okrem $count autorít, ktorým Mozilla dôveruje pre e-mail.',
      one: 'Autority, ktorým dôverujete vy, okrem $count autority, ktorej Mozilla dôveruje pre e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikačná autorita';

  @override
  String get smimeImportACertificate => 'Importovať certifikát';

  @override
  String get smimeImportContactMessage => 'Certifikát korešpondenta (.cer, .crt, .pem) alebo certifikačnej autority.';

  @override
  String get smimeFromClipboard => 'Zo schránky';

  @override
  String get smimeFromFile => 'Zo súboru';

  @override
  String get smimeClipboardEmpty => 'Schránka je prázdna. Najprv skopírujte certifikát.';

  @override
  String get smimeCertificate => 'Certifikát';

  @override
  String get smimeOnDeviceFooter =>
      'Jeho súkromný kľúč zostáva v úložisku poverení Androidu, kam ho nainštalovala vaša firma alebo vy: Loupe žiada Android, aby ním podpisoval a dešifroval. Podpísaná pošta sa podpíše pri odoslaní.';

  @override
  String get smimeAddresses => 'Adresy';

  @override
  String get smimeUsage => 'Určenie';

  @override
  String get smimeUsageNone => 'Nič, čo Loupe používa';

  @override
  String get smimeUsageSigning => 'Podpisovanie';

  @override
  String get smimeUsageEncryption => 'Šifrovanie';

  @override
  String get smimeUsageCertificates => 'Certifikáty';

  @override
  String get smimeAlgorithm => 'Algoritmus';

  @override
  String get smimeSerialNumber => 'Sériové číslo';

  @override
  String get smimeFingerprintCopied => 'Odtlačok je skopírovaný.';

  @override
  String get smimeSha1Thumbprint => 'Kryptografický odtlačok SHA-1';

  @override
  String get smimePrivateKey => 'Súkromný kľúč';

  @override
  String get smimeKeyOnDevice => 'V tomto zariadení';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'V aplikácii Loupe, s prístupovou frázou';

  @override
  String get smimeKeyInLoupe => 'V aplikácii Loupe';

  @override
  String get smimeSource => 'Zdroj';

  @override
  String get smimeSourceSignedMail => 'Podpísaná pošta';

  @override
  String get smimeSourceImported => 'Importovaný';

  @override
  String get smimeTrustHeader => 'Dôvera';

  @override
  String get smimeTrustedRoot => 'Dôveryhodná koreňová autorita';

  @override
  String get smimeIssuer => 'Vydavateľ';

  @override
  String smimeTrustNamed(String name) {
    return 'Dôverovať „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Dôverovať tejto autorite';

  @override
  String get smimeTrustThisCertificate => 'Dôverovať tomuto certifikátu';

  @override
  String get smimeStopTrusting => 'Prestať dôverovať';

  @override
  String get smimePassphrase => 'Prístupová fráza';

  @override
  String get smimePassphraseFooter =>
      'Voliteľné. S prístupovou frázou je súkromný kľúč v tomto zariadení aj zašifrovaný (Argon2id a AES-256) a Loupe si ju vyžiada na podpisovanie a dešifrovanie; ako dlho, určuje Zapamätať prístupové frázy. Odosielaná pošta sa podpíše pri odoslaní; úlohy na pozadí kľúč použiť nemôžu.';

  @override
  String get smimeChangePassphrase => 'Zmeniť prístupovú frázu…';

  @override
  String get smimeSetPassphraseEllipsis => 'Nastaviť prístupovú frázu…';

  @override
  String get smimeRemovePassphrase => 'Odstrániť prístupovú frázu';

  @override
  String get smimeShareCertificate => 'Zdieľať certifikát';

  @override
  String get smimeDeleteCertificate => 'Odstrániť certifikát';

  @override
  String get smimeRemoveCertificate => 'Odobrať certifikát';

  @override
  String get smimePassphraseChanged => 'Prístupová fráza je zmenená.';

  @override
  String get smimePassphraseSet => 'Prístupová fráza je nastavená.';

  @override
  String get smimeRemovePassphraseTitle => 'Odstrániť prístupovú frázu?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Súkromný kľúč bude potom chránený len úložiskom kľúčov, ako bez prístupovej frázy: Loupe sa na ňu už nebude pýtať a úlohy na pozadí ho budú môcť používať.';

  @override
  String get smimePassphraseRemoved => 'Prístupová fráza je odstránená.';

  @override
  String smimeTrustTitle(String name) {
    return 'Dôverovať „$name“?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Každému certifikátu, ktorý vydá, sa bude dôverovať pre poštu. Najprv porovnajte odtlačok s jeho vlastníkom:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Odstrániť váš certifikát $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Odobrať certifikát osoby $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ho prestane používať: poštu zašifrovanú preň už v Loupe neprečítate. Certifikát zostane v tomto zariadení (Nastavenia › Zabezpečenie › Šifrovanie a poverenia).';

  @override
  String get smimeDeleteOwnMessage =>
      'Jeho súkromný kľúč sa z tohto zariadenia odstráni: poštu zašifrovanú preň tu už neprečítate, kým ho znova neimportujete.';

  @override
  String get smimeRemoveContactMessage => 'Vráti sa s jeho ďalšou podpísanou správou.';

  @override
  String get smimeAddressImportFooter =>
      'Importujte certifikát pre túto adresu, aby ste mohli podpisovať a šifrovať pomocou S/MIME, ako to robí Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importovať certifikát…';

  @override
  String get smimePreferFooter =>
      'Keď by správu mohli chrániť oba, použije sa uprednostnený, pokiaľ len ten druhý nemá kľúč alebo certifikát pre každého príjemcu.';

  @override
  String get smimePreferSmime => 'Uprednostniť S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Pred OpenPGP';

  @override
  String get smimeCertificatePassword => 'Heslo certifikátu';

  @override
  String get smimeCertificatePasswordPrompt => 'Zadajte heslo, s ktorým bol súbor certifikátu exportovaný.';

  @override
  String get smimeImport => 'Importovať';

  @override
  String get smimeWrongPassword => 'Heslo je nesprávne. Skúste to znova.';

  @override
  String get smimeNoCertificateFound => 'Nenašiel sa žiadny certifikát.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikát osoby $name';
  }

  @override
  String get smimeNothingNew => 'Nie je čo nové importovať.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importované: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importovaných $count dôveryhodných autorít.',
      few: 'Importované $count dôveryhodné autority.',
      one: 'Importovaná dôveryhodná autorita.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importované: $certificates a $count dôveryhodných autorít.',
      few: 'Importované: $certificates a $count dôveryhodné autority.',
      one: 'Importované: $certificates a dôveryhodná autorita.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Tento súbor nemá súkromný kľúč. Exportujte certifikát spolu so súkromným kľúčom.';

  @override
  String get smimeImportAsYoursTitle => 'Importovať ako váš certifikát?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Táto príloha obsahuje certifikát so súkromným kľúčom: $names. Importujte ho, len ak ste ho sami exportovali, napríklad z Outlooku alebo Thunderbirdu.';
  }

  @override
  String get smimeImportAsMine => 'Importovať ako môj certifikát';

  @override
  String smimeImportedOwn(String names) {
    return 'Importovaný váš certifikát $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Váš certifikát $name ($addresses) bol pridaný z tohto zariadenia.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Dôverovať „$name“ pre poštu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe túto certifikačnú autoritu nepozná (možno je to vlastná autorita nejakej firmy). Ak jej budete dôverovať, Loupe bude môcť overovať certifikáty, ktoré vydá. Najprv porovnajte jej odtlačok s vaším IT oddelením:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Je priložených $count certifikátov.',
      few: 'Sú priložené $count certifikáty.',
      one: 'Je priložený certifikát.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importovať certifikát';

  @override
  String get smimeUnlockTitle => 'Odomknúť certifikát S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Zadajte prístupovú frázu certifikátu $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Prístupová fráza je nesprávna. Skúste to znova.';

  @override
  String get smimeUnlock => 'Odomknúť';

  @override
  String get smimeEnterAPassphrase => 'Zadajte prístupovú frázu.';

  @override
  String get smimePassphrasesDiffer => 'Prístupové frázy sa líšia.';

  @override
  String get smimeSetPassphraseTitle => 'Nastaviť prístupovú frázu';

  @override
  String get smimeSetPassphraseText =>
      'Loupe si ju vyžiada na podpisovanie a dešifrovanie. Ak ju zabudnete, znova importujte certifikát zo súboru .p12.';

  @override
  String get smimePassphraseAgain => 'Znova';

  @override
  String get smimeSetPassphraseButton => 'Nastaviť';

  @override
  String get smimeLockedOpenAgain => 'Váš certifikát S/MIME je zamknutý. Ak ho chcete odomknúť, znova otvorte správu.';

  @override
  String get smimeDeviceHasNoCertificates => 'Toto zariadenie neposkytuje svoje certifikáty.';

  @override
  String get smimeCantReadCertificate => 'Loupe nedokáže prečítať tento certifikát.';

  @override
  String get smimeCertificateNotForMail =>
      'Tento certifikát nie je na poštu: nemá e-mailovú adresu alebo nie je určený na podpisovanie ani šifrovanie.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikát už nie je v tomto zariadení alebo ho Loupe už nesmie používať. Znova ho vyberte v časti Nastavenia › End-to-end šifrovanie.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikát v tomto zariadení sa dá použiť, len keď je Loupe otvorená.';

  @override
  String get smimeDeviceKeyDamaged => 'Zašifrovaný kľúč je poškodený.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikát v tomto zariadení to nedokáže: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nepodporované';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikát v tomto zariadení zlyhal: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa autority nie je webová adresa.';

  @override
  String get smimeAuthorityTimeout => 'Certifikačná autorita neodpovedala včas.';

  @override
  String get smimeAuthorityUnreachable => 'Certifikačná autorita nie je dostupná.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikačná autorita odpovedala kódom $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odpoveď certifikačnej autority je príliš veľká.';

  @override
  String get smimeRevocationNotChecked =>
      'Nekontrolované: kontrolujú sa len certifikáty od autorít, ktorým Loupe dôveruje.';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Rovnaký ako v telefóne';

  @override
  String get settingsLanguageFooter =>
      'Loupe používa jazyk vášho telefónu, ak ho má, inak angličtinu. Jazyk, ktorý tu vyberiete, platí len pre Loupe vrátane upozornení.';

  @override
  String get settingsAccountsHeader => 'Účty';

  @override
  String get settingsAddAccount => 'Pridať účet';

  @override
  String get settingsMailHeader => 'Pošta';

  @override
  String get settingsSwipeActions => 'Akcie potiahnutia';

  @override
  String get settingsSwipeLeft => 'Potiahnutie doľava';

  @override
  String get settingsSwipeLeftFooter =>
      'Úplné potiahnutie spustí túto akciu. Označiť zástavkou a Viac sú vždy na dosah krátkym potiahnutím.';

  @override
  String get settingsSwipeRight => 'Potiahnutie doprava';

  @override
  String get settingsSwipeRightFooter => 'Úplné potiahnutie spustí túto akciu.';

  @override
  String get settingsSwipeToggleRead => 'Označiť ako prečítané/neprečítané';

  @override
  String get settingsSwipeTrash => 'Do koša';

  @override
  String get settingsSwipeMove => 'Presunúť správu';

  @override
  String get settingsSwipeSnooze => 'Odložiť';

  @override
  String get settingsThreaded => 'Zoskupovať do konverzácií';

  @override
  String get settingsUndoSendDelay => 'Čas na zrušenie odoslania';

  @override
  String get settingsUndoSendDelayFooter => 'Odoslané správy počkajú takto dlho, aby ste ich mohli vziať späť.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekúnd',
      few: '$seconds sekundy',
      one: '$seconds sekunda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Vzhľad';

  @override
  String get settingsTheme => 'Motív';

  @override
  String get settingsThemeSystem => 'Automaticky';

  @override
  String get settingsThemeLight => 'Svetlý';

  @override
  String get settingsThemeDark => 'Tmavý';

  @override
  String get settingsDensity => 'Zoznam správ';

  @override
  String get settingsDensityComfortable => 'Pohodlný';

  @override
  String get settingsDensityCompact => 'Kompaktný';

  @override
  String get settingsReadingHeader => 'Čítanie';

  @override
  String get settingsReadingFooter => 'Vzdialené obrázky môžu odosielateľom prezradiť, kedy a kde ste správu otvorili.';

  @override
  String get settingsDefaultView => 'Predvolené zobrazenie';

  @override
  String get settingsDefaultViewFooter => 'Zobrazenie ktorejkoľvek správy môžete prepnúť tlačidlom Aa.';

  @override
  String get settingsViewReadable => 'Čitateľné';

  @override
  String get settingsViewReadableDetail => 'Čisté, čitateľné, sleduje tmavý režim';

  @override
  String get settingsViewOriginal => 'Pôvodné';

  @override
  String get settingsViewOriginalDetail => 'Presne tak, ako to navrhol odosielateľ';

  @override
  String get settingsViewPlain => 'Čistý text';

  @override
  String get settingsViewPlainDetail => 'Len slová';

  @override
  String get settingsPlainTextFont => 'Písmo čistého textu';

  @override
  String get settingsFontSans => 'Bezpätkové';

  @override
  String get settingsFontMono => 'Pevná šírka';

  @override
  String get settingsFontMonoDetail => 'Zachová zarovnanie ASCII artu a tabuliek';

  @override
  String get settingsTechnicalLists => 'Technické konferencie';

  @override
  String get settingsLoadRemoteImages => 'Načítavať vzdialené obrázky';

  @override
  String get settingsOpenLinksDirectly => 'Otvárať odkazy priamo';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Preskočiť sledovanie kliknutí, keď je cieľ známy';

  @override
  String get settingsSecurityHeader => 'Zabezpečenie';

  @override
  String get settingsAppLock => 'Zámok aplikácie';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe sa opýta pri spustení a keď sa vrátite po neprítomnosti dlhšej, ako je čas v položke Zamknúť po.';

  @override
  String get settingsAppLockFooterOff =>
      'Zámok aplikácie si pred zobrazením pošty vyžiada odtlačok prsta, tvár alebo zámku obrazovky.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Zámok aplikácie je stále vypnutý. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Nastavte kód';

  @override
  String get settingsScreenLockTextIos =>
      'Zámok aplikácie používa Face ID, Touch ID alebo kód a tento iPhone nemá nastavený kód. Nastavte ho v aplikácii Nastavenia a potom zapnite zámok aplikácie.';

  @override
  String get settingsScreenLockTitleAndroid => 'Nastavte zámku obrazovky';

  @override
  String get settingsScreenLockTextAndroid =>
      'Zámok aplikácie používa zámku obrazovky telefónu alebo k nej pridaný odtlačok prsta či tvár a tento telefón nemá žiadnu. V nastaveniach Androidu nastavte PIN, vzor alebo heslo a potom zapnite zámok aplikácie.';

  @override
  String get settingsOpenSystemSettings => 'Otvoriť Nastavenia';

  @override
  String get settingsOpenAndroidSettings => 'Otvoriť nastavenia Androidu';

  @override
  String get settingsLockAfter => 'Zamknúť po';

  @override
  String get settingsLockAfterFooter => 'Ako dlho môže byť Loupe na pozadí, kým sa znova opýta.';

  @override
  String get settingsNotifications => 'Upozornenia';

  @override
  String get settingsEncryption => 'End-to-end šifrovanie';

  @override
  String get settingsAdvanced => 'Rozšírené';

  @override
  String get settingsDemoHeader => 'Ukážka';

  @override
  String get settingsDemoFooter =>
      'Ukážková pošta je vymyslená schránka, ktorá existuje len v tomto telefóne. Nič sa nikam neodosiela.';

  @override
  String get settingsDemoMode => 'Ukážkový režim';

  @override
  String get settingsResetApp => 'Obnoviť aplikáciu';

  @override
  String get settingsResetFooter => 'Zabudne všetky nastavenia a vráti sa na úvodnú obrazovku.';

  @override
  String get settingsResetTitle => 'Obnoviť Loupe?';

  @override
  String get settingsResetMessage =>
      'Zabudnú sa všetky nastavenia, Smart Mailboxes a nedávne vyhľadávania a aplikácia sa vráti na úvodnú obrazovku.';

  @override
  String get settingsAboutHeader => 'O aplikácii';

  @override
  String get settingsVersion => 'Verzia';

  @override
  String get settingsLicences => 'Licencie';

  @override
  String get settingsPrivacy => 'Súkromie';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nemá žiadnu analytiku ani sledovanie. Vaša pošta ide len na vaše poštové servery.';

  @override
  String get settingsNotificationsOffIos => 'Upozornenia pre Loupe sú v Nastaveniach vypnuté.';

  @override
  String get settingsNotificationsOffAndroid => 'Upozornenia pre Loupe sú v nastaveniach Androidu vypnuté.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nepovoľuje Loupe zobrazovať upozornenia. Povoľte ich v Nastaveniach.';
  }

  @override
  String get settingsNewMailHeader => 'Nová pošta';

  @override
  String get settingsNewMailFooterDemo =>
      'Ukážková pošta na pozadí neprichádza. Pošlite si testovacie upozornenie a pozrite sa, ako nová pošta vyzerá.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe kontroluje novú poštu na pozadí, keď to iOS dovolí, čo pri aplikáciách, ktoré často neotvárate, môže byť s odstupom hodín. Dostanete upozornenie na nové správy v doručenej pošte a na správy od VIP v ľubovoľnom priečinku.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe kontroluje novú poštu približne každých 15 minút, keď to Android dovolí. Dostanete upozornenie na nové správy v doručenej pošte a na správy od VIP v ľubovoľnom priečinku.';

  @override
  String get settingsNoAccounts => 'Žiadne účty';

  @override
  String get settingsVipOnly => 'Len VIP';

  @override
  String get settingsVipOnlyDetail => 'Len správy od vašich VIP';

  @override
  String get settingsHideContent => 'Skryť obsah';

  @override
  String get settingsHideContentFooterOn =>
      'Upozornenia uvádzajú len „Nová správa z účtu“ a účet, nie kto ju napísal ani o čom.';

  @override
  String get settingsHideContentFooterOff =>
      'Skryť obsah nezobrazí odosielateľa, predmet ani ukážku na uzamknutej obrazovke ani v upozorneniach.';

  @override
  String get settingsBackgroundAppRefresh => 'Obnovovanie aplikácií na pozadí';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nová pošta na pozadí prichádza, len keď je pre Loupe v Nastaveniach zapnuté Obnovovanie aplikácií na pozadí. iOS nedokáže udržať otvorené pripojenie k doručenej pošte, takže Okamžité doručovanie nie je k dispozícii.';

  @override
  String get settingsInstantDelivery => 'Okamžité doručovanie';

  @override
  String get settingsInstantDeliveryFooter =>
      'Okamžité doručovanie (experimentálne) udržiava otvorené pripojenie k doručenej pošte, takže nová pošta príde v priebehu sekúnd. Zobrazuje tiché upozornenie „Sleduje sa nová pošta“ a spotrebúva viac batérie.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android môže Okamžité doručovanie zastaviť, aby šetril batériu. Ak ho chcete udržať v chode, povoľte Loupe používať batériu bez obmedzení.';

  @override
  String get settingsExperimental => 'Experimentálne';

  @override
  String get settingsComingSoon => 'Už čoskoro';

  @override
  String get settingsAllowUnrestrictedBattery => 'Povoliť neobmedzené používanie batérie';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push umožňuje novej pošte okamžite prebudiť Loupe, ak to vaša poštová služba podporuje. Push správy idú cez službu Google a neobsahujú žiadnu poštu, len „skontroluj teraz“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Tento telefón nemôže prijímať push správy: vyžadujú služby Google Play a sieťové pripojenie. Loupe stále kontroluje poštu približne každých 15 minút.';

  @override
  String get settingsCopyPushToken => 'Kopírovať token push';

  @override
  String get settingsPushTokenCopied => 'Token push je skopírovaný';

  @override
  String get settingsSendTestNotification => 'Poslať testovacie upozornenie';

  @override
  String get settingsAppIconBadge => 'Odznak na ikone aplikácie';

  @override
  String get settingsBadgeNote => 'Odznak sa aktualizuje vždy, keď Loupe kontroluje poštu, aj na pozadí.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Plocha tohto telefónu nezobrazuje čísla na ikonách aplikácií. Odznak sa aktualizuje vždy, keď Loupe kontroluje poštu, aj na pozadí.';

  @override
  String get settingsTestNotificationBody => 'Upozornenia na novú poštu vyzerajú takto.';

  @override
  String get settingsAccountRemoved => 'Tento účet bol odstránený.';

  @override
  String get settingsAccountHeader => 'Účet';

  @override
  String get settingsAccountDescription => 'Popis';

  @override
  String get settingsAccountDescriptionHint => 'Práca, Osobné…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Farba';

  @override
  String get settingsColourFooter => 'Označuje správy tohto účtu v zobrazení Všetky doručené.';

  @override
  String settingsColourNumber(int number) {
    return 'Farba $number';
  }

  @override
  String get settingsSendingHeader => 'Odosielanie';

  @override
  String get settingsSendingFooter =>
      'Každá identita má vlastný podpis. Odpovede sa odosielajú z adresy, na ktorú správa prišla.';

  @override
  String get settingsFoldersHeader => 'Priečinky';

  @override
  String get settingsFoldersFooter =>
      'Loupe zobrazuje a synchronizuje priečinky, ktoré odoberáte, rovnako ako Thunderbird. Doručená pošta, Koncepty, Odoslané, Nevyžiadaná pošta, Kôš a Archív sa zobrazujú vždy.';

  @override
  String get settingsShowAllFolders => 'Zobraziť všetky priečinky';

  @override
  String get settingsIncoming => 'Prichádzajúci server';

  @override
  String get settingsOutgoing => 'Odchádzajúci server';

  @override
  String get settingsConnectionNotEncrypted => 'Nešifrované';

  @override
  String get settingsSignIn => 'Prihlásenie';

  @override
  String get settingsSignInExpired => 'Platnosť vypršala';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider už neprijíma prihlásenie Loupe pre tento účet, takže sa jeho pošta nesynchronizuje. Opravíte to opätovným prihlásením.';
  }

  @override
  String get settingsSignInAgain => 'Prihlásiť sa znova';

  @override
  String get settingsSigningIn => 'Prihlasuje sa…';

  @override
  String get settingsRemoveAccount => 'Odstrániť účet';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Odstrániť „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Jeho pošta a nastavenia sa z tohto telefónu odstránia. Na serveri sa nič nevymaže.';

  @override
  String get settingsManageFolders => 'Spravovať priečinky';

  @override
  String get settingsNoFolders => 'Zatiaľ žiadne priečinky.';

  @override
  String get settingsManageFoldersFooter =>
      'Odoberané priečinky sa zobrazujú na obrazovke Schránky a synchronizujú sa na pozadí. Ostatné poštové aplikácie s rovnakým účtom sa týmito odbermi zvyčajne tiež riadia.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Uchováva vaše Smart Mailboxes pre ostatné zariadenia. Na obrazovke Schránky je skrytý.';

  @override
  String get settingsFolderAlwaysShown => 'Vždy zobrazený';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Odoberať $folder';
  }

  @override
  String get settingsIdentities => 'Identity';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Prvá identita je predvolená pre nové správy. Poradie zmeníte potiahnutím.';

  @override
  String get settingsIdentitiesFooterSingle => 'Predvolená identita pre nové správy.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odpoveď sa odošle z identity, na ktorú správa prišla.';

  @override
  String get settingsIdentityDefault => 'Predvolená';

  @override
  String settingsIdentityReorder(String email) {
    return 'Zmeniť poradie $email';
  }

  @override
  String get settingsAddIdentity => 'Pridať identitu';

  @override
  String get settingsNewIdentity => 'Nová identita';

  @override
  String get settingsIdentity => 'Identita';

  @override
  String get settingsIdentityNameHint => 'Vaše meno';

  @override
  String get settingsReplyTo => 'Odpovedať komu';

  @override
  String get settingsSignature => 'Podpis';

  @override
  String get settingsSignatureFooter => 'Pridáva sa pod „-- “ v správach z tejto identity.';

  @override
  String get settingsNoSignature => 'Bez podpisu';

  @override
  String get settingsCopyToMyself => 'Kópia pre mňa';

  @override
  String get settingsCopyToMyselfFooter => 'Pridáva sa ku každej správe z tejto identity.';

  @override
  String get settingsCc => 'Kópia';

  @override
  String get settingsBcc => 'Skrytá kópia';

  @override
  String get settingsReplyPatterns => 'Použiť pre odpovede na';

  @override
  String get settingsReplyPatternsFooter =>
      'Odpovede na správy odoslané na tieto adresy sa odošlú z tejto identity. * znamená čokoľvek: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adresa alebo vzor, v ktorom * znamená čokoľvek.';

  @override
  String get settingsAddReplyPattern => 'Pridať adresu alebo vzor';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Odobrať $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Neplatný vzor';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ nie je adresa ani vzor ako *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Chýba adresa';

  @override
  String get settingsIdentityNoAddressMessage => 'Zadajte e-mailovú adresu, z ktorej sa má odosielať.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Neplatná adresa';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„$address“ v poli Odpovedať komu nie je platná e-mailová adresa.',
      'cc': '„$address“ v poli Kópia nie je platná e-mailová adresa.',
      'bcc': '„$address“ v poli Skrytá kópia nie je platná e-mailová adresa.',
      'other': '„$address“ nie je platná e-mailová adresa.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Uložiť identitu';

  @override
  String get settingsDiscardChanges => 'Zahodiť zmeny';

  @override
  String get settingsDeleteIdentity => 'Odstrániť identitu';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Odstrániť „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Správy, ktoré už z nej boli odoslané, zostanú, ako sú.';

  @override
  String get settingsLastIdentityFooter => 'Účet potrebuje aspoň jednu identitu.';

  @override
  String get rulesTitle => 'Pravidlá';

  @override
  String get rulesNewRule => 'Nové pravidlo';

  @override
  String get rulesLoadError => 'Pravidlá sa nepodarilo načítať.';

  @override
  String get rulesEmptyTitle => 'Žiadne pravidlá';

  @override
  String get rulesEmptyText =>
      'Pravidlá za vás triedia novú poštu a pridávajú jej štítky a zástavky. Vytvorte ho tlačidlom písania vyššie alebo z vyhľadávania pomocou „Vytvoriť z toho pravidlo“.';

  @override
  String get rulesListFooter =>
      'Pravidlá sa na novú poštu v doručenej pošte spúšťajú zhora nadol. Pravidlo presuniete podržaním.';

  @override
  String get rulesChangeError => 'Pravidlo sa nepodarilo zmeniť';

  @override
  String get rulesConditionEveryMessage => 'Každá správa';

  @override
  String rulesMoveRule(String rule) {
    return 'Presunúť $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule zapnuté';
  }

  @override
  String get rulesServerRulesHeader => 'Pravidlá na serveri';

  @override
  String get rulesServerRulesFooter =>
      'Pravidlá na serveri sa spúšťajú na poštovom serveri pri prijatí pošty, aj keď je tento telefón vypnutý. Sú uložené v skripte Sieve s názvom „loupe“.';

  @override
  String get rulesStatusUnknown => 'Neznámy';

  @override
  String get rulesStatusError => 'Server sa nepodarilo opýtať.';

  @override
  String get rulesStatusChecking => 'Kontroluje sa…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Spúšťa sa zo skriptu „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktívny je skript „$script“. Ťuknutím mu povolíte spúšťať aj pravidlá Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na serveri nie je aktívny žiadny skript. Uložením pravidla na serveri sa zapne skript Loupe.';

  @override
  String get rulesStatusUnavailable => 'Nedostupné';

  @override
  String get rulesStatusNoSieve => 'Server tohto účtu neposkytuje Sieve (ManageSieve ani JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Presunúť do $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Presunúť do priečinka';

  @override
  String rulesActionTag(String tag) {
    return 'Pridať štítok $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Odobrať štítok $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Ponechať v doručenej pošte';

  @override
  String rulesActionForward(String address) {
    return 'Preposlať na $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Preposlať na $address bez ponechania kópie';
  }

  @override
  String get rulesActionStop => 'Zastaviť';

  @override
  String get rulesNoActions => 'Zatiaľ nič nerobí';

  @override
  String get rulesLocationDevice => 'Zariadenie';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Toto zariadenie';

  @override
  String get rulesNewRuleTitle => 'Nové pravidlo';

  @override
  String get rulesEditRuleTitle => 'Upraviť pravidlo';

  @override
  String get rulesDefaultNameEveryMessage => 'Každá správa';

  @override
  String get rulesConditionHeader => 'Keď nová správa zodpovedá';

  @override
  String get rulesConditionFooter =>
      'Napíšte to ako pri vyhľadávaní: from:, to:, s: (predmet), b: (telo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktúra';

  @override
  String get rulesAccounts => 'Účty';

  @override
  String get rulesAllAccounts => 'Všetky účty';

  @override
  String get rulesRemovedAccount => 'Odstránený účet';

  @override
  String get rulesAccountsFooter => 'Pravidlo pre všetky účty sa vzťahuje aj na účty, ktoré pridáte neskôr.';

  @override
  String get rulesActionsHeader => 'Potom';

  @override
  String get rulesForwardingFooter =>
      'Preposielanie odošle každú zodpovedajúcu správu na inú adresu hneď po prijatí, aj keď je tento telefón vypnutý. Niektorí poskytovatelia obmedzujú, koľko pošty možno preposlať.';

  @override
  String get rulesForwardingHiddenFooter => 'Preposielanie funguje len v pravidlách na serveri, preto tu nie je.';

  @override
  String rulesRemoveAction(String action) {
    return 'Odobrať $action';
  }

  @override
  String get rulesAddAction => 'Pridať akciu';

  @override
  String get rulesAddMove => 'Presunúť do priečinka…';

  @override
  String get rulesAddTagMenu => 'Pridať štítok…';

  @override
  String get rulesRemoveTagMenu => 'Odobrať štítok…';

  @override
  String get rulesAddForward => 'Preposlať na…';

  @override
  String get rulesStopProcessing => 'Nespracúvať ďalšie pravidlá';

  @override
  String get rulesRunOnHeader => 'Spúšťať na';

  @override
  String get rulesRunOnDeviceFooter =>
      'Toto zariadenie spúšťa pravidlo na novú poštu v doručenej pošte vždy, keď Loupe kontroluje poštu.';

  @override
  String get rulesRunOnServerFooter =>
      'Poštový server spúšťa pravidlo pri prijatí pošty, aj keď je tento telefón vypnutý. Vyžaduje Sieve cez ManageSieve (Dovecot, mailcow) alebo JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Použiť na existujúce správy…';

  @override
  String get rulesDeleteRule => 'Odstrániť pravidlo';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Odstrániť „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Priečinok v ktorom účte?';

  @override
  String get rulesMoveAccountMessage => 'Pošta ostatných účtov ide do priečinka s rovnakým názvom v danom účte.';

  @override
  String get rulesAddTag => 'Pridať štítok';

  @override
  String get rulesRemoveTag => 'Odobrať štítok';

  @override
  String get rulesForwardTo => 'Preposlať na';

  @override
  String get rulesForwardToMessage =>
      'Server bude každú zodpovedajúcu správu posielať ďalej na túto adresu, aj keď je tento telefón vypnutý. Použite adresu, ktorú vlastníte alebo ktorej dôverujete.';

  @override
  String get rulesNotAnAddressTitle => 'Nie je e-mailová adresa';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ nie je adresa, na ktorú možno preposielať.';
  }

  @override
  String get rulesKeepCopyTitle => 'Ponechať kópiu tu?';

  @override
  String get rulesKeepCopy => 'Ponechať kópiu';

  @override
  String get rulesDontKeepCopy => 'Neponechať kópiu';

  @override
  String get rulesCheckCondition => 'Skontrolujte podmienku';

  @override
  String get rulesChooseActionTitle => 'Vyberte akciu';

  @override
  String get rulesChooseActionMessage => 'Pridajte, čo má pravidlo robiť so správami, ktoré mu zodpovedajú.';

  @override
  String get rulesSaveError => 'Pravidlo sa nepodarilo uložiť';

  @override
  String get rulesSaveServerError => 'Pravidlo na serveri sa nepodarilo uložiť';

  @override
  String get rulesRunOnDeviceInstead => 'Radšej spúšťať v tomto zariadení';

  @override
  String get rulesNothingToApplyTitle => 'Nie je čo použiť';

  @override
  String get rulesNothingToApplyMessage => 'Najprv pravidlu zadajte funkčnú podmienku a akciu.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Použiť „$rule“ na správy v…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Doručená pošta';

  @override
  String get rulesApplyScopeAll => 'Všetky schránky';

  @override
  String get rulesFindingMessages => 'Hľadajú sa správy…';

  @override
  String get rulesSearchError => 'Vyhľadávanie zlyhalo';

  @override
  String get rulesSearchErrorUnknown => 'Niečo sa pokazilo.';

  @override
  String get rulesNoMatchesTitle => 'Žiadne zodpovedajúce správy';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nič tam nezodpovedá podmienke „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Použiť „$rule“ na $countString správ?',
      few: 'Použiť „$rule“ na $countString správy?',
      one: 'Použiť „$rule“ na $countString správu?',
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
      other: 'Použiť na $countString správ',
      few: 'Použiť na $countString správy',
      one: 'Použiť na $countString správu',
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
      other: 'Pravidlo „$rule“ použité na $countString správ',
      few: 'Pravidlo „$rule“ použité na $countString správy',
      one: 'Pravidlo „$rule“ použité na $countString správu',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Zisťuje sa, čo server dokáže…';

  @override
  String get rulesServerUnreachable => 'Server nie je dostupný.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nemožno spustiť na serveri: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nemožno spustiť na serveri účtu $account: $problem';
  }

  @override
  String get rulesShowScript => 'Zobraziť skript';

  @override
  String get rulesHideScript => 'Skryť skript';

  @override
  String get rulesMatchingHeader => 'Zodpovedajúce správy';

  @override
  String get rulesMatchingHeaderLoading => 'Zodpovedajúce správy…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString zodpovedajúcich správ',
      few: '$countString zodpovedajúce správy',
      one: '$countString zodpovedajúca správa',
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
      other: '$countString+ zodpovedajúcich správ',
      few: '$countString+ zodpovedajúce správy',
      one: '$countString+ zodpovedajúca správa',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Za posledných 30 dní. Samotné pravidlo pôsobí len na novú poštu, pokiaľ ho nepoužijete na existujúce správy.';

  @override
  String rulesConditionError(String error) {
    return 'Podmienka obsahuje chybu: $error';
  }

  @override
  String get rulesPreviewNoSender => '(bez odosielateľa)';

  @override
  String get rulesPreviewNoSubject => '(bez predmetu)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'a ďalších $countString',
      few: 'a ďalšie $countString',
      one: 'a ešte $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Za posledných 30 dní nič.';

  @override
  String get rulesIncludeTitle => 'Zapnúť pravidlá na serveri';

  @override
  String get rulesIncludeLeaveOff => 'Nechať vypnuté';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Server už spúšťa pravidlá Loupe pre $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ je aktívny skript na serveri účtu $account, takže server spúšťa ten a nie pravidlá Loupe. Loupe ho nenahradí. Môže doň pridať tieto riadky a server potom spustí pravidlá Loupe po vlastných pravidlách skriptu:';
  }

  @override
  String get rulesShowWholeScript => 'Zobraziť celý skript';

  @override
  String get rulesHideWholeScript => 'Skryť celý skript';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nič iné sa v „$script“ nezmení. Ak sa jeho filtre neskôr upravia vo webmaile, webmail ho môže prepísať bez týchto riadkov; Loupe potom znova zobrazí pravidlá na serveri ako vypnuté.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Pridať do „$script“';
  }

  @override
  String get subscriptionsTitle => 'Odbery';

  @override
  String get subscriptionsNewsletters => 'Newslettery';

  @override
  String get subscriptionsDiscussions => 'Diskusie';

  @override
  String get subscriptionsFilter => 'Filtrovať';

  @override
  String get subscriptionsFilterNeverRead => 'Nikdy nečítané';

  @override
  String get subscriptionsFilterRarelyRead => 'Zriedka čítané';

  @override
  String get subscriptionsFilterAll => 'Všetko';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Odbery sa nepodarilo spočítať';

  @override
  String get subscriptionsNoMatches => 'Žiadne zhody';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Žiadny newsletter sa nevolá „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Žiadna konferencia sa nevolá „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Žiadne newslettery';

  @override
  String get subscriptionsNoNewslettersDetail => 'Newslettery a iná hromadná pošta sa tu zobrazia, keď prídu.';

  @override
  String get subscriptionsNothingNeverRead => 'Žiadne nikdy nečítané';

  @override
  String get subscriptionsNothingRarelyRead => 'Žiadne zriedka čítané';

  @override
  String get subscriptionsNothingFilteredDetail => 'Zo všetkého, čo dostávate, si niečo prečítate.';

  @override
  String get subscriptionsNoDiscussions => 'Žiadne diskusie';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'E-mailové konferencie, do ktorých môžete písať, sa tu zobrazia, keď z nich príde pošta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Konferencie, do ktorých píše viac ľudí. Podržaním ju pripnete do Schránok, prečítate ako čistý text alebo presuniete medzi newslettery.';

  @override
  String get subscriptionsPrivacyNote =>
      'Spočítané v tomto telefóne zo stiahnutej pošty; na zistenie sa nič nikam neposiela. Loupe kontaktuje odosielateľa, len keď ťuknete na Odhlásiť: odhlásenie jedným kliknutím pošle len „List-Unsubscribe=One-Click“ na adresu, ktorú odosielateľ uviedol, bez cookies a bez ďalších údajov o vás, a nikdy nenačíta jeho stránky ani obrázky.';

  @override
  String get subscriptionsVolumeNone => 'V poslednom čase nič';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mesiac';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mesiac';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'prečítané $percent';
  }

  @override
  String get subscriptionsStillSending => 'Stále posiela';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Odhlásené $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Stránka odhlásenia otvorená $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Jedno ťuknutie · kontaktuje $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-mailom na $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Na webovej stránke $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Odhlásiť';

  @override
  String get subscriptionsUnsubscribeAgain => 'Znova odhlásiť';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivovať $countString správ z doručenej pošty',
      few: 'Archivovať $countString správy z doručenej pošty',
      one: 'Archivovať $countString správu z doručenej pošty',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Vytvoriť pravidlo…';

  @override
  String get subscriptionsCreateRuleDetail => 'Presúvať alebo archivovať jeho budúcu poštu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Považovať za diskusiu';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Konferencia, do ktorej ľudia píšu: čítajte ju ako fórum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Považovať za newsletter';

  @override
  String get subscriptionsBlockSender => 'Blokovať odosielateľa';

  @override
  String get subscriptionsBlock => 'Blokovať';

  @override
  String get subscriptionsBlocked => 'Blokované';

  @override
  String get subscriptionsBlockedDetail => 'Nová pošta ide do nevyžiadanej pošty';

  @override
  String get subscriptionsPin => 'Pripnúť do Schránok';

  @override
  String get subscriptionsUnpin => 'Odopnúť zo Schránok';

  @override
  String get subscriptionsOpenDefaultView => 'Otvoriť v predvolenom zobrazení';

  @override
  String get subscriptionsOpenPlainText => 'Otvoriť ako čistý text (pevná šírka)';

  @override
  String get subscriptionsPinned => 'Pripnuté';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString neprečítaných',
      few: '$countString neprečítané',
      one: '$countString neprečítaná',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Od tohto odosielateľa teraz nie je žiadna pošta.';

  @override
  String get subscriptionsLatestMessages => 'NAJNOVŠIE SPRÁVY';

  @override
  String get subscriptionsMail => 'Pošta';

  @override
  String get subscriptionsNoneIn90Days => 'Za 90 dní nič';

  @override
  String get subscriptionsRead => 'Prečítané';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString z $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Naposledy prijaté';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Priečinky', one: 'Priečinok');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Stále posiela';

  @override
  String get subscriptionsUnsubscribedTitle => 'Odhlásené';

  @override
  String subscriptionsSince(String date) {
    return 'od $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'stránka otvorená $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender neuvádza, ako sa odhlásiť.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender neuvádza, ako sa odhlásiť. Namiesto toho ho môžete zablokovať.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Prebieha odhlásenie od $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Odhlásené od $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Odhlásenie zlyhalo: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatické odhlásenie zlyhalo';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Poslať e-mail na odhlásenie';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Otvoriť $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Otvoriť $site?';
  }

  @override
  String get subscriptionsOpen => 'Otvoriť';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender odhlasuje na svojej webovej stránke. Stránka sa otvorí v prehliadači Loupe; dokončite to tam.';
  }

  @override
  String get subscriptionsWebInsecure => 'Pripojenie k tejto stránke nie je šifrované.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Pozor: táto adresa napodobňuje $site podobne vyzerajúcimi písmenami.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Pozor: táto adresa napodobňuje inú stránku podobne vyzerajúcimi písmenami.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site sa nepodarilo otvoriť.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe si poznačí dnešný dátum a dá vám vedieť, ak od $sender bude naďalej prichádzať pošta.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Odhlásiť odber od $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontaktuje $site kvôli odhláseniu.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Je to jediný prípad, keď Loupe kontaktuje webovú stránku odosielateľa. Pošle len „List-Unsubscribe=One-Click“ na adresu, ktorú uvádza $sender, bez cookies a bez akýchkoľvek ďalších údajov o vás, a stránku nenačíta.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Odkaz na odhlásenie nie je zabezpečená adresa na internete.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Stránka $site neodpovedala včas.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Stránka $site nie je dostupná.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Stránka $site presmerovala požiadavku na inú stránku, ktorú Loupe nesleduje.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Stránka $site požiadavku odmietla (chyba $status).';
  }

  @override
  String get subscriptionsNoAccountToSend =>
      'Nie je k dispozícii žiadny účet, z ktorého by sa dal odoslať e-mail na odhlásenie.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe odošle e-mail na $to z adresy $from s predmetom „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-mail na odhlásenie bol odoslaný na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Blokovať $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nová pošta z tejto konferencie pôjde do nevyžiadanej pošty. Môžete to zmeniť v časti Nastavenia › Pravidlá.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nová pošta z $address pôjde do nevyžiadanej pošty. Môžete to zmeniť v časti Nastavenia › Pravidlá.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Zablokované: $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Presunúť $count správ do nevyžiadanej pošty',
      few: 'Presunúť $count správy do nevyžiadanej pošty',
      one: 'Presunúť $count správu do nevyžiadanej pošty',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokovať $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender je teraz medzi newslettermi.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender je teraz medzi diskusiami.';
  }

  @override
  String get appLiveGateTitle => 'Vaše účty sa nepodarilo otvoriť';

  @override
  String get appLiveGateUnavailableBuild => 'Skutočné účty v tejto zostave zatiaľ nie sú k dispozícii.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nedokázala prečítať kľúč, ktorý chráni vašu poštu v tomto telefóne. Často je to dočasné: skúste to znova alebo reštartujte telefón.';

  @override
  String get appLiveGateKeyMissing =>
      'Kľúč, ktorý chráni vašu poštu v tomto telefóne, zmizol, čo sa môže stať po obnovení zálohy. Vaša pošta je stále na serveri.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Databázu pošty v tomto telefóne nemožno prečítať: je poškodená alebo sa zmenil jej kľúč. Vaša pošta je stále na serveri.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Pri otváraní vašich účtov sa niečo pokazilo ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Týmto sa odstránia vaše účty a pošta uložená v tomto telefóne vrátane správ čakajúcich v priečinku Pošta na odoslanie. Pošty na vašich serveroch sa to netýka; potom znova pridajte svoje účty.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Odstrániť a začať odznova';

  @override
  String get appLiveGateUseDemo => 'Použiť ukážkovú poštu';

  @override
  String get appLiveGateReset => 'Obnoviť poštu v tomto telefóne…';

  @override
  String get attachmentsUntitled => 'Príloha';

  @override
  String get attachmentsUntitledFile => 'Bez názvu';

  @override
  String get attachmentsOpenIn => 'Otvoriť v…';

  @override
  String get attachmentsSaveToFiles => 'Uložiť do súborov';

  @override
  String get attachmentsShareMenu => 'Zdieľať…';

  @override
  String get attachmentsDownloadError => 'Prílohu sa nepodarilo stiahnuť. Skontrolujte pripojenie a skúste to znova.';

  @override
  String get attachmentsShareError => 'Prílohu sa nepodarilo zdieľať.';

  @override
  String attachmentsNoApp(String type) {
    return 'V tomto zariadení nie je aplikácia, ktorá by tento súbor otvorila ($type). Skúste radšej Zdieľať.';
  }

  @override
  String get attachmentsOpenInError => 'Prílohu sa nepodarilo otvoriť v inej aplikácii.';

  @override
  String attachmentsSaved(String name) {
    return 'Uložené: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Prílohu sa nepodarilo uložiť.';

  @override
  String get attachmentsGone => 'Táto príloha už nie je k dispozícii.';

  @override
  String get attachmentsDownloadFailed => 'Prílohu sa nepodarilo stiahnuť.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strán',
      few: '$count strany',
      one: '$count strana',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size cez mobilné dáta';
  }

  @override
  String get attachmentsLargeDownload => 'Táto príloha je veľká. Stiahnite ju teraz alebo neskôr cez Wi-Fi.';

  @override
  String get attachmentsDownload => 'Stiahnuť';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Sťahuje sa $size…';
  }

  @override
  String get attachmentsDownloading => 'Sťahuje sa…';

  @override
  String get attachmentsTooLarge => 'Príliš veľké na ukážku.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Zobrazuje sa prvých $shown z $total. Celý obsah získate skopírovaním, zdieľaním alebo uložením.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Tento PDF tu nemožno zobraziť (môže byť chránený heslom).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page z $count';
  }

  @override
  String get attachmentsModeTable => 'Tabuľka';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Správa';

  @override
  String get attachmentsModeSource => 'Zdroj';

  @override
  String get attachmentsDontWrap => 'Nezalamovať riadky';

  @override
  String get attachmentsWrap => 'Zalamovať riadky';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines riadkov',
      few: '$lines riadky',
      one: '$lines riadok',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopírovať všetko';

  @override
  String get attachmentsCopied => 'Skopírované';

  @override
  String get attachmentsImageUnavailable => 'Tento obrázok tu nemožno zobraziť. Skúste Otvoriť v…';

  @override
  String get attachmentsEmlNoSubject => '(Bez predmetu)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Komu';

  @override
  String get attachmentsEmlCc => 'Kópia';

  @override
  String get attachmentsEmlDate => 'Dátum';

  @override
  String get attachmentsEmlNoText => 'Táto správa nemá žiadny text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Prílohy: $names', one: 'Príloha: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizátor: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A ešte $count udalostí',
      few: 'A ešte $count udalosti',
      one: 'A ešte $count udalosť',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Obrázok';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Obrázok $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Hodnoty oddelené tabulátorom';

  @override
  String get attachmentsTypeCsv => 'Tabuľka CSV';

  @override
  String get attachmentsTypeCalendar => 'Udalosť kalendára';

  @override
  String get attachmentsTypeEmail => 'E-mailová správa';

  @override
  String get attachmentsTypeContact => 'Vizitka';

  @override
  String get attachmentsTypeLog => 'Súbor denníka';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'Archív ZIP';

  @override
  String get attachmentsTypeArchive => 'Archív';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Tabuľka Excel';

  @override
  String get attachmentsTypePowerPoint => 'Prezentácia PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Webová stránka';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Zvuk';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Súbor $extension';
  }

  @override
  String get attachmentsTypeFile => 'Súbor';

  @override
  String get calendarUntitledEvent => 'Udalosť';

  @override
  String get calendarAllDay => 'Celý deň';

  @override
  String calendarYourTime(String time) {
    return '$time váš čas';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Pripojiť sa: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prijíma: $details',
      'tentative': '$name predbežne prijíma: $details',
      'declined': '$name odmieta: $details',
      'delegated': '$name deleguje: $details',
      'other': '$name zatiaľ neodpovedá na: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prijíma pozvánku',
      'tentative': '$name predbežne prijíma pozvánku',
      'declined': '$name odmieta pozvánku',
      'delegated': '$name deleguje pozvánku',
      'other': '$name na pozvánku zatiaľ neodpovedá',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Pripojiť sa';

  @override
  String get calendarOnlineMeeting => 'Online stretnutie';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Stretnutie $provider';
  }

  @override
  String get calendarOrganizerYou => 'Vy';

  @override
  String get calendarOrganizerLabel => 'organizátor';

  @override
  String get calendarStatusAccepted => 'Prijaté';

  @override
  String get calendarStatusMaybe => 'Možno';

  @override
  String get calendarStatusDeclined => 'Odmietnuté';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: prijaté',
      'tentative': '$name: predbežne prijaté',
      'declined': '$name: odmietnuté',
      'delegated': '$name: delegované',
      'other': '$name: bez odpovede',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prijíma:',
      'tentative': '$name predbežne prijíma:',
      'declined': '$name odmieta:',
      'delegated': '$name deleguje:',
      'other': '$name zatiaľ neodpovedá:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name navrhuje nový čas';
  }

  @override
  String get calendarCounterUnknown => 'Účastník navrhuje nový čas';

  @override
  String get calendarDeclineCounter => 'Organizátor ponechal pôvodný čas';

  @override
  String calendarRefresh(String name) {
    return '$name žiada najnovšiu verziu';
  }

  @override
  String get calendarRefreshUnknown => 'Účastník žiada najnovšiu verziu';

  @override
  String get calendarCancelled => 'Zrušené';

  @override
  String get calendarCancelledByOrganizer => 'Organizátor túto udalosť zrušil.';

  @override
  String get calendarCancelledLater => 'Táto udalosť bola neskôr zrušená.';

  @override
  String get calendarOutdated => 'Neaktuálne';

  @override
  String get calendarOutdatedDetail => 'Táto pozvánka bola neskôr aktualizovaná; platí novšia.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Miesto odstránené (predtým $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Miesto odstránené (predtým žiadne)';

  @override
  String calendarLocationChanged(String location) {
    return 'Miesto zmenené na $location';
  }

  @override
  String get calendarNewTitle => 'Nový názov';

  @override
  String get calendarRepeatChanged => 'Opakovanie sa zmenilo';

  @override
  String get calendarUpdated => 'Aktualizované';

  @override
  String get calendarUpdatedInvitation => 'Aktualizovaná pozvánka';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Čas sa zmenil z $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Časové pásmo „$zone“ je neznáme: časy sú tak, ako boli napísané';
  }

  @override
  String calendarNext(String when) {
    return 'Ďalší: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hostí',
      few: '$count hostia',
      one: '$count hosť',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'prijaté: $count');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'možno: $count');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'odmietnuté: $count');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (vy)';
  }

  @override
  String get calendarAttendeeOptional => 'nepovinné';

  @override
  String get calendarAttendeeRoom => 'miestnosť';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Staršiu verziu ste prijali.',
      'tentative': 'Staršiu verziu ste predbežne prijali.',
      'declined': 'Staršiu verziu ste odmietli.',
      'delegated': 'Staršiu verziu ste delegovali.',
      'other': 'Na staršiu verziu ste neodpovedali.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Prijať';

  @override
  String get calendarMaybe => 'Možno';

  @override
  String get calendarDecline => 'Odmietnuť';

  @override
  String get calendarCommentHint => 'Komentár pre organizátora (voliteľné)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Vaša odpoveď pôjde osobe $organizer z adresy $address.';
  }

  @override
  String get calendarAddComment => 'Pridať komentár';

  @override
  String get calendarAddToCalendar => 'Pridať do kalendára';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A ešte $count udalostí v súbore',
      few: 'A ešte $count udalosti v súbore',
      one: 'A ešte $count udalosť v súbore',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp =>
      'Nie je k dispozícii žiadna aplikácia kalendára, do ktorej by sa dala udalosť pridať.';

  @override
  String get calendarCantOpenCalendar => 'Kalendár sa nepodarilo otvoriť.';

  @override
  String get calendarCantOpenLink => 'Odkaz sa nepodarilo otvoriť.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Pripojiť sa k stretnutiu $provider?';
  }

  @override
  String get calendarJoinTitle => 'Pripojiť sa k stretnutiu?';

  @override
  String calendarJoinOpens(String host) {
    return 'Otvorí $host v prehliadači.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Pozor: táto adresa napodobňuje $site podobne vyzerajúcimi písmenami.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Pozor: táto adresa napodobňuje inú stránku podobne vyzerajúcimi písmenami.';

  @override
  String calendarJoinOpen(String host) {
    return 'Otvoriť $host';
  }

  @override
  String get calendarNoOrganizer => 'Táto pozvánka nemá organizátora, ktorému by sa dalo odpovedať.';

  @override
  String get calendarNoAccount => 'Nie je k dispozícii žiadny účet, z ktorého by sa dalo odpovedať.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Prijaté', 'tentative': 'Možno', 'other': 'Odmietnuté'});
    return '$_temp0 · odosiela sa odpoveď osobe $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Prijaté', 'tentative': 'Možno', 'other': 'Odmietnuté'});
    return '$_temp0 · odpoveď odoslaná';
  }

  @override
  String get calendarReplyAlreadySent => 'Odpoveď už bola odoslaná.';

  @override
  String get calendarReplyNotSent => 'Odpoveď nebola odoslaná.';

  @override
  String get dataSmimeNeedsDevice =>
      'Váš certifikát S/MIME je v tomto zariadení: ak chcete túto správu podpísať a odoslať, otvorte Loupe.';

  @override
  String dataSigningFailed(String error) {
    return 'Podpisovanie zlyhalo: $error';
  }

  @override
  String get keyboardShortcuts => 'Klávesové skratky';

  @override
  String get keyboardGroupGeneral => 'Všeobecné';

  @override
  String get keyboardGroupMessages => 'Správy';

  @override
  String get keyboardGroupCompose => 'Písanie';

  @override
  String get keyboardCommandPalette => 'Paleta príkazov';

  @override
  String get keyboardBackClose => 'Späť, zavrieť';

  @override
  String get keyboardNextMessage => 'Ďalšia správa';

  @override
  String get keyboardPreviousMessage => 'Predchádzajúca správa';

  @override
  String get keyboardOpenMessage => 'Otvoriť správu';

  @override
  String get keyboardMoveToTrash => 'Presunúť do koša';

  @override
  String get keyboardToggleRead => 'Označiť ako prečítané alebo neprečítané';

  @override
  String get keyboardToggleFlag => 'Pridať alebo zrušiť zástavku';

  @override
  String get keyboardCloseDraft => 'Zavrieť (uložiť alebo zahodiť koncept)';

  @override
  String get keyboardOr => 'alebo';

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
  String get mailingListsMuted => 'Vlákno je stlmené. Nové správy v ňom prídu ako prečítané.';

  @override
  String get mailingListsUnmuted => 'Stlmenie vlákna je zrušené.';

  @override
  String get mailingListsMuteThread => 'Stlmiť vlákno';

  @override
  String get mailingListsUnmuteThread => 'Zrušiť stlmenie vlákna';

  @override
  String get mailingListsPin => 'Pripnúť do Schránok';

  @override
  String get mailingListsUnpin => 'Odopnúť zo Schránok';

  @override
  String get mailingListsDefaultView => 'Otvoriť v predvolenom zobrazení';

  @override
  String get mailingListsPlainText => 'Otvoriť ako čistý text (pevná šírka)';

  @override
  String get mailingListsShowMuted => 'Zobraziť stlmené vlákna';

  @override
  String get mailingListsHideMuted => 'Skryť stlmené vlákna';

  @override
  String get mailingListsTreatAsNewsletter => 'Považovať za newsletter';

  @override
  String get mailingListsOptions => 'Možnosti konferencie';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted neprečítaných',
      few: '$formatted neprečítané',
      one: '$formatted neprečítaná',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nová správa do konferencie';

  @override
  String get mailingListsRowUnread => 'Neprečítané';

  @override
  String get mailingListsRowMuted => 'Stlmené';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odpovedí',
      few: '$count odpovede',
      one: '$count odpoveď',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Žiadne vlákna';

  @override
  String get mailingListsMutedHidden => 'Stlmené vlákna sú skryté.';

  @override
  String get mailingListsTechnicalTitle => 'Technické konferencie';

  @override
  String get mailingListsTechnicalEmpty => 'E-mailové konferencie sa tu zobrazia, keď z nich príde pošta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Správy z týchto konferencií sa otvárajú ako čistý text písmom s pevnou šírkou a patche sa zobrazujú ako diffy. Tlačidlo Aa stále prepne zobrazenie ktorejkoľvek správy.';

  @override
  String get paletteMoveToMailbox => 'Presunúť do schránky…';

  @override
  String get paletteMarkAllRead => 'Označiť všetko ako prečítané';

  @override
  String get paletteExportFolder => 'Exportovať priečinok…';

  @override
  String get paletteGetNewMail => 'Načítať novú poštu';

  @override
  String get paletteSnoozed => 'Odložené';

  @override
  String get paletteSubscriptions => 'Odbery';

  @override
  String get paletteDiscussions => 'Diskusie';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-mailová konferencia';

  @override
  String get paletteTag => 'Štítok';

  @override
  String get paletteSwipeActions => 'Akcie potiahnutia';

  @override
  String get paletteNotifications => 'Upozornenia';

  @override
  String get paletteRules => 'Pravidlá';

  @override
  String get paletteEncryption => 'End-to-end šifrovanie';

  @override
  String get paletteAdvanced => 'Rozšírené';

  @override
  String get paletteAddAccount => 'Pridať účet';

  @override
  String get paletteAccount => 'Účet';

  @override
  String get paletteFolders => 'Priečinky';

  @override
  String get paletteRecentSearch => 'Nedávne vyhľadávanie';

  @override
  String paletteSearchMail(String query) {
    return 'Hľadať v pošte „$query“';
  }

  @override
  String get palettePlaceholder => 'Hľadať akcie, schránky, nastavenia';

  @override
  String get paletteNothingFound => 'Nič sa nenašlo';

  @override
  String get searchNewSmartMailbox => 'Nový Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Zobrazí všetko, čo zodpovedá „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ uložené do Schránok';
  }

  @override
  String get searchMakeRule => 'Vytvoriť z toho pravidlo';

  @override
  String get searchSaveSmartMailbox => 'Uložiť ako Smart Mailbox';

  @override
  String get searchNegate => 'Negovať';

  @override
  String get searchDontNegate => 'Nenegovať';

  @override
  String get searchAllMailboxes => 'Všetky schránky';

  @override
  String get searchRecent => 'Nedávne vyhľadávania';

  @override
  String get searchClear => 'Vymazať';

  @override
  String get searchSuggestions => 'Návrhy';

  @override
  String get searchUnreadMessages => 'Neprečítané správy';

  @override
  String get searchFlaggedMessages => 'Správy so zástavkou';

  @override
  String get searchWithAttachments => 'Správy s prílohami';

  @override
  String get searchUnrepliedMessages => 'Správy bez odpovede';

  @override
  String get searchTags => 'Štítky';

  @override
  String get searchPeople => 'Ľudia';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Od: $name';
  }

  @override
  String get searchSearching => 'Hľadá sa…';

  @override
  String get searchNoResults => 'Žiadne výsledky';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted výsledkov',
      few: '$formatted výsledky',
      one: '$formatted výsledok',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Ponuka vyhľadávania';

  @override
  String searchSearchingAccount(String account) {
    return 'Hľadá sa v účte $account na serveri…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Hľadá sa v účte na serveri…';

  @override
  String searchAccountFailed(String account) {
    return 'V účte $account sa nepodarilo hľadať na serveri';
  }

  @override
  String get searchUnknownAccountFailed => 'V účte sa nepodarilo hľadať na serveri';

  @override
  String searchChip(String term) {
    return '$term. Dvojitým ťuknutím upravíte.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nie $term. Dvojitým ťuknutím upravíte.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerova schránka: každá správa je tu prečítaná aj neprečítaná, kým ju neotvoríte.';

  @override
  String searchContradiction(String term) {
    return 'Žiadna správa nemôže byť zároveň „$term“ aj nie.';
  }

  @override
  String get searchSyncDeviceOnly => 'Len v tomto zariadení';

  @override
  String searchSyncUnsupported(String account) {
    return 'Len v tomto zariadení: $account ho nedokáže uchovať';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nesynchronizované: $account má novší formát';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Čaká na synchronizáciu s účtom $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synchronizované s účtom $account';
  }

  @override
  String get searchRename => 'Premenovať';

  @override
  String get searchEditSearch => 'Upraviť vyhľadávanie';

  @override
  String get searchDeleteSmartMailbox => 'Odstrániť Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Premenovať Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Tento Smart Mailbox bol odstránený.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes zostávajú v tomto zariadení.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes sa uchovávajú na vašom poštovom serveri, takže ich majú aj vaše ostatné zariadenia a tiež Thunderbird s doplnkom Expression Search Reloaded. Tie, ktoré hľadajú vo všetkých účtoch, sa uchovávajú v účte $account; tie pre jeden priečinok v účte daného priečinka.';
  }

  @override
  String get searchSyncVia => 'Synchronizovať cez';

  @override
  String get searchSyncViaFooter => 'Na každom zariadení vyberte rovnaký účet.';

  @override
  String get searchGmailCantKeep => 'Gmail nedokáže uchovávať Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Uchovávať Smart Mailboxes len v tomto zariadení';

  @override
  String get searchOnTheServer => 'Na serveri';

  @override
  String get searchServerFooter =>
      'Metadáta servera (IMAP METADATA) sa nezobrazujú v žiadnej poštovej aplikácii. Servery bez nich dostanú priečinok „Loupe Settings“ s jednou správou; Loupe ho v Schránkach skryje.';

  @override
  String get searchSyncNow => 'Synchronizovať teraz';

  @override
  String get searchStateUnsupported => 'Nepodporované';

  @override
  String get searchStateNewerFormat => 'Novší formát';

  @override
  String get searchStateFailed => 'Synchronizácia zlyhala';

  @override
  String get searchStateSyncing => 'Synchronizuje sa…';

  @override
  String get searchStateWaiting => 'Čaká sa';

  @override
  String get searchStateMetadata => 'Metadáta servera';

  @override
  String get searchStateFolder => 'Priečinok Loupe Settings';

  @override
  String get searchStateNothing => 'Nič nie je uložené';

  @override
  String get sharedBack => 'Späť';

  @override
  String get sharedYesterday => 'Včera';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date o $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bajtov',
      few: '$count bajty',
      one: '$count bajt',
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
  String get sharedSyncNoAccounts => 'Žiadne účty';

  @override
  String get sharedSyncChecking => 'Kontroluje sa pošta…';

  @override
  String get sharedSyncFailed => 'Poštu sa nepodarilo skontrolovať';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Aktualizované práve teraz';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Aktualizované pred $minutes minútami',
      one: 'Aktualizované pred $minutes minútou',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Aktualizované o $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Aktualizované $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Všetky doručené';

  @override
  String get sharedMailboxUnread => 'Neprečítané';

  @override
  String get sharedMailboxFlagged => 'So zástavkou';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Všetky koncepty';

  @override
  String get sharedMailboxAllSent => 'Všetky odoslané';

  @override
  String get sharedMailboxUntitled => 'Schránka';

  @override
  String get sharedTagImportant => 'Dôležité';

  @override
  String get sharedTagWork => 'Práca';

  @override
  String get sharedTagPersonal => 'Osobné';

  @override
  String get sharedTagToDo => 'Na vybavenie';

  @override
  String get sharedTagLater => 'Neskôr';

  @override
  String get sharedTags => 'Štítky';

  @override
  String get sharedMoveTo => 'Presunúť do…';

  @override
  String get sharedNoRecipients => 'Bez príjemcov';

  @override
  String get sharedUnknownSender => 'Neznámy odosielateľ';

  @override
  String get sharedOnServer => 'Na serveri';

  @override
  String get sharedAttachment => 'Príloha';

  @override
  String get sharedSnoozedBadge => 'Odložené';

  @override
  String get sharedRowUnread => 'Neprečítané';

  @override
  String get sharedRowBackFromSnooze => 'Vrátené z odloženia';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'So zástavkou';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivovaných $count správ',
      few: 'Archivované $count správy',
      one: 'Archivovaná $count správa',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstránených $count správ',
      few: 'Odstránené $count správy',
      one: 'Odstránená $count správa',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ presunutých do doručenej pošty',
      few: '$count správy presunuté do doručenej pošty',
      one: '$count správa presunutá do doručenej pošty',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ presunutých do koša',
      few: '$count správy presunuté do koša',
      one: '$count správa presunutá do koša',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ presunutých do nevyžiadanej pošty',
      few: '$count správy presunuté do nevyžiadanej pošty',
      one: '$count správa presunutá do nevyžiadanej pošty',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ presunutých do priečinka $mailbox',
      few: '$count správy presunuté do priečinka $mailbox',
      one: '$count správa presunutá do priečinka $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ presunutých do schránky',
      few: '$count správy presunuté do schránky',
      one: '$count správa presunutá do schránky',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count správ odložených do $time',
      few: '$count správy odložené do $time',
      one: '$count správa odložená do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odložené do $time len v tomto zariadení: server nedokáže uložiť časy odloženia.';
  }

  @override
  String get sharedMoveOneAccount => 'Ak chcete správy presunúť, vyberte ich z jedného účtu.';

  @override
  String get sharedSnoozeTitle => 'Odložiť';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Zmeniť čas odloženia';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Natrvalo odstrániť $count správ?',
      few: 'Natrvalo odstrániť $count správy?',
      one: 'Natrvalo odstrániť túto správu?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Túto akciu nemožno vrátiť späť.';

  @override
  String get sharedDeletePermanently => 'Odstrániť natrvalo';

  @override
  String get sharedSwipeRead => 'Prečítané';

  @override
  String get sharedSwipeUnread => 'Neprečítané';

  @override
  String get sharedSwipeInbox => 'Doručená pošta';

  @override
  String get sharedSwipeDelete => 'Odstrániť';

  @override
  String get sharedTrash => 'Do koša';

  @override
  String get sharedSwipeSnooze => 'Odložiť';

  @override
  String get sharedWakeNow => 'Vrátiť teraz';

  @override
  String get sharedChangeSnoozeTime => 'Zmeniť čas odloženia…';

  @override
  String get sharedSnooze => 'Odložiť…';

  @override
  String get sharedTag => 'Štítky…';

  @override
  String get sharedMoveMessage => 'Presunúť správu…';

  @override
  String get sharedNotJunk => 'Nie je nevyžiadaná';

  @override
  String get accountSetupTitle => 'Pridať účet';

  @override
  String get accountSetupTitleDone => 'Účet pridaný';

  @override
  String get accountSetupAddressTitle => 'Pridajte poštový účet';

  @override
  String get accountSetupAddressText => 'Loupe nájde nastavenia pre väčšinu poskytovateľov.';

  @override
  String get accountSetupNameHint => 'Vaše meno';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Pokračovať';

  @override
  String get accountSetupLookingUp => 'Hľadajú sa nastavenia…';

  @override
  String get accountSetupImport => 'Importovať z Thunderbirdu';

  @override
  String get accountSetupInvalidEmail => 'Zadajte platnú e-mailovú adresu.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nastavenia pre $domain sa nenašli. Zadajte ich nižšie.';
  }

  @override
  String get accountSetupCheckServers => 'Skontrolujte názvy serverov a porty.';

  @override
  String get accountSetupEnterPassword => 'Zadajte heslo.';

  @override
  String get accountSetupConnecting => 'Pripája sa…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Čaká sa na $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Stránku sa nepodarilo otvoriť.';

  @override
  String get accountSetupCouldNotSaveName => 'Meno sa nepodarilo uložiť.';

  @override
  String get accountSetupTrustCertificate => 'Dôverovať tomuto certifikátu';

  @override
  String get accountSetupPasswordRequired => 'Povinné';

  @override
  String get accountSetupShowPassword => 'Zobraziť heslo';

  @override
  String get accountSetupHidePassword => 'Skryť heslo';

  @override
  String get accountSetupAppPassword => 'Heslo aplikácie';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Prichádzajúci server · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Odchádzajúci server · SMTP';

  @override
  String get accountSetupSignIn => 'Prihlásiť sa';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Prihlásiť sa cez $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Použiť heslo aplikácie';

  @override
  String get accountSetupUseAppPasswordInstead => 'Radšej použiť heslo aplikácie';

  @override
  String get accountSetupUseDifferentAddress => 'Použiť inú adresu';

  @override
  String get accountSetupHowToCreateAppPassword => 'Ako vytvoriť heslo aplikácie';

  @override
  String get accountSetupHowToCreateOne => 'Návod na vytvorenie';

  @override
  String get accountSetupGoogleNote =>
      'Prihlasujete sa na stránke Google a Loupe vaše heslo nikdy nevidí. Povoľte Loupe čítať, odosielať a organizovať vašu poštu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Prihlásiť sa cez Google“ v tejto zostave ešte nie je k dispozícii. Namiesto toho sa môžete pripojiť s heslom aplikácie (vyžaduje overenie v dvoch krokoch v účte Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Vytvorte heslo aplikácie vo svojom účte Google a vložte ho nižšie.';

  @override
  String get accountSetupMicrosoftNote =>
      'Prihlasujete sa na stránke Microsoftu a Loupe vaše heslo nikdy nevidí. Funguje to pre Outlook.com a Hotmail aj pre pracovné či školské účty v Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Prihlásenie cez Microsoft príde v neskoršej zostave. Účty Outlook, Hotmail a Microsoft 365 ho potrebujú: už neprijímajú heslá z poštových aplikácií.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail vyžaduje heslo pre konkrétnu aplikáciu, nie heslo k Apple účtu.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail vyžaduje heslo aplikácie, nie heslo k účtu.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe sa k Fastmailu pripája cez JMAP s tokenom API: Settings › Privacy & Security › Manage API tokens, pre JMAP, s prístupom k e-mailu a odosielaniu.';

  @override
  String get accountSetupFastmailNote => 'Fastmail vyžaduje pre poštové aplikácie heslo aplikácie.';

  @override
  String get accountSetupServerSettings => 'Nastavenia servera';

  @override
  String get accountSetupSettingsNotFound => 'Nenašli sa automaticky';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Nájdené cez $source';
  }

  @override
  String get accountSetupEditSettings => 'Upraviť nastavenia';

  @override
  String get accountSetupSyncing => 'Vaša pošta sa synchronizuje.';

  @override
  String get accountSetupDescription => 'Popis';

  @override
  String get accountSetupDescriptionHint => 'Práca, Osobné…';

  @override
  String get accountSetupColour => 'Farba';

  @override
  String accountSetupColourNumber(int number) {
    return 'Farba $number';
  }

  @override
  String get accountSetupSaving => 'Ukladá sa…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nedokázala otvoriť svoju databázu pošty v tomto telefóne. Zatvorte Loupe, znova ju otvorte a skúste to znova.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Niečo sa pokazilo ($error). Skúste to znova.';
  }

  @override
  String get accountSetupSecurityNone => 'Žiadne';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Zabezpečenie';

  @override
  String get accountSetupUsername => 'Používateľské meno';

  @override
  String get accountSetupUsernameHint => 'Vaša e-mailová adresa';

  @override
  String get accountSetupNoEncryptionTitle => 'Pripojiť sa bez šifrovania?';

  @override
  String get accountSetupNoEncryptionText =>
      'Vaše heslo a každá správa by sa prenášali ako čistý text. Ktokoľvek v sieti, napríklad vo verejnej Wi-Fi, by ich mohol prečítať. Použite to len pre server vo vlastnej sieti.';

  @override
  String get accountSetupUseWithoutEncryption => 'Použiť bez šifrovania';

  @override
  String get accountSetupApiTokenRejected =>
      'Token API bol odmietnutý. Vytvorte token API Fastmail pre JMAP s prístupom k e-mailu a vložte ho.';

  @override
  String get accountSetupAppPasswordRejected => 'Heslo bolo odmietnuté. Použite heslo aplikácie, nie heslo k účtu.';

  @override
  String get accountSetupPasswordRejected => 'Heslo bolo odmietnuté. Skontrolujte ho a skúste to znova.';

  @override
  String get accountSetupServerUnreachable => 'Server nie je dostupný. Skontrolujte nastavenia servera a pripojenie.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certifikát servera nie je dôveryhodný. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Prihlásenie bolo zrušené. Ak to chcete skúsiť znova, ťuknite na „Prihlásiť sa cez $provider“.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe potrebuje povolenie na čítanie a odosielanie vašej pošty Gmail. Prihláste sa znova a povoľte prístup so zaškrtnutým políčkom Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe potrebuje povolenie na čítanie a odosielanie vašej pošty. Prihláste sa znova a prijmite povolenia.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Vaša organizácia musí Loupe schváliť, kým ju budete môcť používať s týmto účtom. Požiadajte správcu IT, aby pre Loupe udelil súhlas správcu v Microsoft Entra ID, a potom to skúste znova.';

  @override
  String get accountSetupOAuthBlocked =>
      'Pravidlá prihlasovania vašej organizácie nepovoľujú Loupe v tomto zariadení. Obráťte sa na správcu IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider nie je dostupný. Skontrolujte internetové pripojenie a skúste to znova.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Prihlásenie cez $provider nie je v tejto verzii Loupe správne nastavené. Nahláste to, prosím.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Prihlásenie cez $provider nefungovalo. Skúste to znova.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider vás prihlásil, ale Gmail odmietol prístup pre túto adresu. Pri prihlasovaní vyberte rovnaký účet. Pracovné či školské účty môžu mať IMAP vypnutý správcom.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider vás prihlásil, ale poštový server odmietol prístup pre túto adresu. Pri prihlasovaní vyberte rovnaký účet. Pracovné či školské účty môžu mať IMAP vypnutý správcom.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Poštový server nie je dostupný. Skontrolujte pripojenie a skúste to znova.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Prihlásenie cez $provider nie je v tejto verzii k dispozícii.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Znova prihlásené. $account sa synchronizuje.';
  }

  @override
  String get accountSetupSignInAgain => 'Prihlásiť sa znova';

  @override
  String get accountSetupSigningIn => 'Prihlasuje sa…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider už neprijíma prihlásenie Loupe pre $email, takže sa $account nesynchronizuje. Ak chcete dostávať jeho poštu, prihláste sa znova.';
  }

  @override
  String get accountImportTitle => 'Importovať z Thunderbirdu';

  @override
  String get accountImportPointCamera => 'Namierte fotoaparát na QR kód, ktorý zobrazuje Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Naskenované $scanned z $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Naskenované: $scanned z $total kódov',
      few: 'Naskenované: $scanned z $total kódov',
      one: 'Naskenované: $scanned z $total kódu',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zatiaľ $count účtov',
      few: 'Zatiaľ $count účty',
      one: 'Zatiaľ $count účet',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'V počítači otvorte Thunderbird a vyberte Nástroje › Exportovať do mobilu. Vyberte svoje účty a naskenujte každý zobrazený kód. Kódy môžete skenovať v ľubovoľnom poradí.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pokračovať: $count účtov',
      few: 'Pokračovať: $count účty',
      one: 'Pokračovať: $count účet',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Radšej vložiť text';

  @override
  String get accountImportStartOver => 'Začať odznova';

  @override
  String get accountImportDuplicateCode => 'Tento kód už bol pridaný.';

  @override
  String get accountImportRestarted =>
      'Tento kód pochádza z nového exportu, preto sa predtým naskenované kódy odložili.';

  @override
  String get accountImportNotThunderbird => 'Toto nie je kód účtu Thunderbirdu.';

  @override
  String get accountImportNewerVersion =>
      'Tento kód pochádza z novšieho Thunderbirdu. Ak ho chcete importovať, aktualizujte Loupe.';

  @override
  String get accountImportDamaged => 'Tento kód Thunderbirdu sa nepodarilo prečítať.';

  @override
  String get accountImportTooLarge => 'Tento kód je príliš veľký na to, aby bol exportom z Thunderbirdu.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nastavenia sa nepodarilo otvoriť.';

  @override
  String get accountImportCameraOffTitle => 'Prístup k fotoaparátu je vypnutý';

  @override
  String get accountImportCameraOffText =>
      'V Nastaveniach povoľte Loupe používať fotoaparát na naskenovanie kódu alebo radšej vložte text kódu.';

  @override
  String get accountImportNoCameraTitle => 'Žiadny fotoaparát';

  @override
  String get accountImportNoCameraText => 'Loupe tu nemôže použiť fotoaparát. Radšej vložte text kódu.';

  @override
  String get accountImportCameraFailedTitle => 'Fotoaparát sa nespustil';

  @override
  String get accountImportCameraFailedText => 'Skúste to znova alebo radšej vložte text kódu.';

  @override
  String get accountImportOpenSettings => 'Otvoriť Nastavenia';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Našlo sa $count účtov',
      few: 'Našli sa $count účty',
      one: 'Našiel sa $count účet',
      zero: 'Nenašli sa žiadne účty',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Žiadny z účtov v týchto kódoch sa nepodarilo prečítať.';

  @override
  String get accountImportChoose => 'Vyberte účty, ktoré chcete pridať do Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kódy $codes z $total neboli naskenované, takže ich účty nie sú uvedené.',
      one: 'Kód $codes z $total nebol naskenovaný, takže jeho účty nie sú uvedené.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes a $last';
  }

  @override
  String get accountImportScanMore => 'Naskenovať ďalšie kódy';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count účtov v kódoch sa nepodarilo prečítať. Môžu používať nastavenia z novšieho Thunderbirdu.',
      few: '$count účty v kódoch sa nepodarilo prečítať. Môžu používať nastavenia z novšieho Thunderbirdu.',
      one: '$count účet v kódoch sa nepodarilo prečítať. Môže používať nastavenia z novšieho Thunderbirdu.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Naskenovať znova';

  @override
  String get accountImportAlreadyAdded => 'Účet s touto adresou už v Loupe je.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Po pridaní sa prihlásite cez $provider, ako v Thunderbirde.';
  }

  @override
  String get accountImportGmailAppPassword => 'Pridajte účet s heslom aplikácie (vyžaduje overenie v dvoch krokoch).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird sa do Gmailu prihlasuje cez Google. „Prihlásiť sa cez Google“ príde v neskoršej zostave; dovtedy pridajte účet s heslom aplikácie (vyžaduje overenie v dvoch krokoch).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird sa do tohto účtu prihlasuje v prehliadači. Loupe to zatiaľ nedokáže: ak váš poskytovateľ ponúka heslo aplikácie, použite ho.';

  @override
  String get accountImportUnencrypted => 'Pripája sa bez šifrovania. Používajte to len vo vlastnej sieti.';

  @override
  String get accountImportEnterAgain => 'Zadajte ho znova';

  @override
  String get accountImportAdded => 'Pridané';

  @override
  String accountImportAdding(int index, int total) {
    return 'Pridáva sa $index z $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pridať $count účtov',
      few: 'Pridať $count účty',
      one: 'Pridať $count účet',
      zero: 'Pridať účty',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Vložiť text exportu';

  @override
  String get accountImportPasteText => 'Vložte text exportného kódu z Thunderbirdu, jeden kód na riadok.';

  @override
  String get accountImportPop3 => 'Účty POP3 nie sú podporované. Loupe uchováva poštu na serveri pomocou IMAP.';

  @override
  String get accountImportKerberos => 'Tento účet sa prihlasuje cez Kerberos, ktorý Loupe nepodporuje.';

  @override
  String get accountImportNtlm => 'Tento účet sa prihlasuje cez NTLM, ktoré Loupe nepodporuje.';

  @override
  String get accountImportClientCertificate =>
      'Tento účet sa prihlasuje klientskym certifikátom, ktorý Loupe zatiaľ nepodporuje.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Prihlásenie cez Microsoft príde v neskoršej zostave. Účty Outlook a Microsoft 365 už neprijímajú heslá z poštových aplikácií.';

  @override
  String get accountImportEnterPassword => 'Zadajte heslo.';

  @override
  String get accountImportEnterAppPassword => 'Zadajte heslo aplikácie.';

  @override
  String get accountImportEnterApiToken => 'Zadajte token API.';

  @override
  String get accountImportStorageFailed => 'Loupe nedokázala otvoriť úložisko účtov. Skúste to neskôr.';

  @override
  String get accountImportFailed => 'Účet sa nepodarilo pridať. Skúste to znova alebo ho pridajte ručne.';

  @override
  String get composeNewMessageTitle => 'Nová správa';

  @override
  String get composeAttach => 'Priložiť';

  @override
  String get composeSendLater => 'Odoslať neskôr';

  @override
  String composeSendAt(String time) {
    return 'Odoslať $time';
  }

  @override
  String get composeSendHint => 'Podržaním odošlete neskôr';

  @override
  String get composeNoAccount => 'Ak chcete odosielať poštu, pridajte účet.';

  @override
  String get composeTo => 'Komu:';

  @override
  String get composeCc => 'Kópia:';

  @override
  String get composeBcc => 'Skrytá kópia:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kópia/skrytá kópia, od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Predmet:';

  @override
  String composeReplyTo(String address) {
    return 'Odpovedať komu: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odpovedať z adresy $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Odoslať z adresy $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odpovedať z adresy $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Odoslať z adresy $email?';
  }

  @override
  String get composeDismiss => 'Zavrieť';

  @override
  String composeAliasNotSaved(String account) {
    return 'Neuložené ako identita · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Uložiť ako identitu';

  @override
  String composeAliasSaved(String email) {
    return 'Adresa $email je uložená ako identita.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Neplatná adresa $address';
  }

  @override
  String get composeOriginalNotFound => 'Pôvodnú správu sa nepodarilo nájsť.';

  @override
  String get composeDraftNotFound => 'Koncept sa nepodarilo nájsť.';

  @override
  String get composeAttachmentsLost => 'Prílohy sa nepodarilo obnoviť. Pridajte ich znova.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Niektoré prílohy sa nepodarilo pridať: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Prílohy majú spolu $size; niektoré servery odmietajú takto veľké správy.';
  }

  @override
  String get composeAttachFailed => 'Súbor sa nepodarilo priložiť.';

  @override
  String get composeInvalidAddressTitle => 'Neplatná adresa';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ nie je platná e-mailová adresa.';
  }

  @override
  String get composeNoSubjectTitle => 'Bez predmetu';

  @override
  String get composeNoSubjectText => 'Táto správa nemá predmet. Napriek tomu ju odoslať?';

  @override
  String get composeSentBeforeChanges => 'Bola odoslaná pred vašimi zmenami, ktoré sú uložené v Konceptoch.';

  @override
  String composeScheduled(String time) {
    return 'Naplánované na $time';
  }

  @override
  String get composeSending => 'Odosiela sa…';

  @override
  String get composeSent => 'Odoslané';

  @override
  String get composeSendFailed => 'Odoslanie zlyhalo. Skúste to znova.';

  @override
  String get composeAlreadySent => 'Už odoslané.';

  @override
  String get composeDiscardChanges => 'Zahodiť zmeny';

  @override
  String get composeSaveChanges => 'Uložiť zmeny';

  @override
  String get composeDeleteDraft => 'Odstrániť koncept';

  @override
  String get composeSaveDraft => 'Uložiť koncept';

  @override
  String get composeDraftSaved => 'Koncept je uložený';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Dňa $date o $time $name napísal(a):';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Dňa $date o $time niekto napísal:';
  }

  @override
  String get composeForwardHeader => '---------- Preposlaná správa ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Od: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dátum: $date o $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Predmet: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Komu: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kópia: $addresses';
  }

  @override
  String get composeLaterToday => 'Neskôr dnes';

  @override
  String get composeTomorrowMorning => 'Zajtra ráno';

  @override
  String get composeMondayMorning => 'V pondelok ráno';

  @override
  String get composePickDateTime => 'Vybrať dátum a čas…';

  @override
  String get composeSendWithoutDelay => 'Odoslať bez odkladu';

  @override
  String composeSendTimeToday(String time) {
    return 'Dnes o $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Zajtra o $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day o $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Dnes $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Zajtra $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Pokračovať v úprave konceptu?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Správa nebola odoslaná, keď sa Loupe zatvorila.',
      'one': 'Správa pre $name nebola odoslaná, keď sa Loupe zatvorila.',
      'other': 'Správa pre $name a ďalších nebola odoslaná, keď sa Loupe zatvorila.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Správa „$subject“ nebola odoslaná, keď sa Loupe zatvorila.',
      'one': 'Správa „$subject“ pre $name nebola odoslaná, keď sa Loupe zatvorila.',
      'other': 'Správa „$subject“ pre $name a ďalších nebola odoslaná, keď sa Loupe zatvorila.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Pokračovať v úprave';

  @override
  String get composeRecoverySave => 'Uložiť do konceptov';

  @override
  String get composeRecoveryDiscard => 'Zahodiť';

  @override
  String get composeRecoverySaved => 'Uložené do konceptov';

  @override
  String get outboxSectionFailed => 'Neodoslané';

  @override
  String get outboxSectionSending => 'Odosiela sa';

  @override
  String get outboxSectionScheduled => 'Naplánované';

  @override
  String get outboxStatusQueued => 'Čoskoro sa odošle';

  @override
  String get outboxStatusSending => 'Odosiela sa…';

  @override
  String get outboxStatusFailed => 'Neodoslané';

  @override
  String get outboxNoRecipients => 'Bez príjemcov';

  @override
  String get outboxNoSubject => '(Bez predmetu)';

  @override
  String get outboxSendingFailed => 'Odoslanie zlyhalo.';

  @override
  String get outboxEmptyTitle => 'Nič na odoslanie';

  @override
  String get outboxEmptyText => 'Správy, ktoré odošlete neskôr, tu čakajú, kým nepríde ich čas.';

  @override
  String get outboxSendNow => 'Odoslať teraz';

  @override
  String get outboxReschedule => 'Preplánovať';

  @override
  String get outboxRescheduleMenu => 'Preplánovať…';

  @override
  String get outboxRescheduleTitle => 'Preplánovať';

  @override
  String outboxRescheduled(String time) {
    return 'Preplánované na $time';
  }

  @override
  String get outboxCancel => 'Zrušiť';

  @override
  String get outboxCancelSending => 'Zrušiť odoslanie…';

  @override
  String get outboxCancelTitle => 'Zrušiť odoslanie?';

  @override
  String get outboxMoveToDrafts => 'Presunúť do konceptov';

  @override
  String get outboxDiscard => 'Zahodiť správu';

  @override
  String get outboxMovedToDrafts => 'Presunuté do konceptov';

  @override
  String get outboxDiscarded => 'Správa zahodená';

  @override
  String get outboxAlreadySent => 'Už odoslané.';

  @override
  String get outboxBeingSent => 'Táto správa sa práve odosiela.';

  @override
  String get outboxActionFailed => 'To nefungovalo. Správa je stále v priečinku Pošta na odoslanie.';

  @override
  String get notificationsBadgeInboxes => 'Neprečítané v doručenej pošte';

  @override
  String get notificationsBadgeVip => 'Neprečítané od VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nová pošta od vašich VIP v ľubovoľnom účte';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nová pošta v $email';
  }

  @override
  String get notificationsUnknownSender => 'Neznámy odosielateľ';

  @override
  String get notificationsNoSubject => '(Bez predmetu)';

  @override
  String get notificationsEncryptedMessage => 'Zašifrovaná správa';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nová správa z účtu $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nových správ',
      few: '$count nové správy',
      one: '$count nová správa',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nové správy v účte $account';
  }

  @override
  String get platformInstantChannel => 'Okamžité doručovanie';

  @override
  String get platformInstantChannelDescription => 'Zobrazuje sa, kým Loupe sleduje novú poštu v doručenej pošte';

  @override
  String get platformInstantTitle => 'Sleduje sa nová pošta';

  @override
  String get platformInstantText => 'Okamžité doručovanie je zapnuté';

  @override
  String get platformErrorBox => 'Pri zobrazovaní sa niečo pokazilo. Vráťte sa späť a skúste to znova.';

  @override
  String get welcomeTagline => 'Pošta navonok jednoduchá\na vo vnútri výkonná.';

  @override
  String get welcomeAccountsTitle => 'Všetky účty v jednej pokojnej schránke';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail a akýkoľvek server IMAP alebo JMAP.';

  @override
  String get welcomeSearchTitle => 'Vyhľadávanie, ktoré nájde';

  @override
  String get welcomeSearchText => 'Okamžité výsledky v telefóne, potom zo servera.';

  @override
  String get welcomePrivacyTitle => 'Súkromie už v návrhu';

  @override
  String get welcomePrivacyText => 'Žiadne sledovanie. Vzdialené obrázky zostanú blokované, kým nepoviete inak.';

  @override
  String get welcomeAddAccount => 'Pridať účet';

  @override
  String get welcomeImport => 'Importovať z Thunderbirdu';

  @override
  String get welcomeTryDemo => 'Vyskúšať s ukážkovou poštou';
}
