// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get commonAdd => 'Přidat';

  @override
  String get commonCancel => 'Zrušit';

  @override
  String get commonClose => 'Zavřít';

  @override
  String get commonDelete => 'Smazat';

  @override
  String get commonDone => 'Hotovo';

  @override
  String get commonEdit => 'Upravit';

  @override
  String get commonMore => 'Více';

  @override
  String get commonMove => 'Přesunout';

  @override
  String get commonName => 'Název';

  @override
  String get commonNone => 'Žádné';

  @override
  String get commonOff => 'Vyp.';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Zap.';

  @override
  String get commonOptional => 'Volitelné';

  @override
  String get commonPassword => 'Heslo';

  @override
  String get commonRemove => 'Odebrat';

  @override
  String get commonRetry => 'Opakovat';

  @override
  String get commonSave => 'Uložit';

  @override
  String get commonSearch => 'Hledat';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Nastavení';

  @override
  String get commonShare => 'Sdílet';

  @override
  String get commonTryAgain => 'Zkusit znovu';

  @override
  String get commonUndo => 'Vrátit';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zpráv',
      few: '$count zprávy',
      one: '$count zpráva',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivovat';

  @override
  String get mailDelete => 'Smazat';

  @override
  String get mailFlag => 'Označit vlajkou';

  @override
  String get mailForward => 'Přeposlat';

  @override
  String get mailMarkAsRead => 'Označit jako přečtené';

  @override
  String get mailMarkAsUnread => 'Označit jako nepřečtené';

  @override
  String get mailMoveToJunk => 'Přesunout do spamu';

  @override
  String get mailNewMessage => 'Nová zpráva';

  @override
  String get mailNoSubject => 'Bez předmětu';

  @override
  String get mailReply => 'Odpovědět';

  @override
  String get mailReplyAll => 'Odpovědět všem';

  @override
  String get mailSend => 'Odeslat';

  @override
  String get mailUnflag => 'Zrušit vlajku';

  @override
  String get mailboxArchive => 'Archiv';

  @override
  String get mailboxDrafts => 'Koncepty';

  @override
  String get mailboxInbox => 'Doručená pošta';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'K odeslání';

  @override
  String get mailboxSent => 'Odeslané';

  @override
  String get mailboxTrash => 'Koš';

  @override
  String get conversationSomethingWentWrong => 'Něco se pokazilo. Zkuste to znovu.';

  @override
  String get conversationReplyToList => 'Odpovědět do konference';

  @override
  String get conversationReplyList => 'Do konference';

  @override
  String get conversationThreadMuted => 'Vlákno ztlumeno. Nové zprávy v něm přijdou jako přečtené.';

  @override
  String get conversationThreadUnmuted => 'Ztlumení vlákna zrušeno.';

  @override
  String get conversationLinkFailed => 'Odkaz se nepodařilo otevřít.';

  @override
  String get conversationGoneTitle => 'Žádná zpráva';

  @override
  String get conversationGoneText => 'Tato zpráva byla přesunuta nebo smazána.';

  @override
  String get conversationMuted => 'Ztlumeno';

  @override
  String get conversationReaderOptions => 'Možnosti čtení';

  @override
  String get conversationReaderOptionsHint => 'Velikost textu a zobrazení';

  @override
  String get conversationTrash => 'Do koše';

  @override
  String get conversationReplyHint => 'Podržením odpovíte všem nebo přepošlete';

  @override
  String get conversationOfflineTitle => 'Jste offline';

  @override
  String get conversationOfflineText => 'Tato konverzace ještě není stažená. Načte se, až budete znovu online.';

  @override
  String get conversationErrorTitle => 'Tuto zprávu nelze zobrazit';

  @override
  String get conversationErrorText => 'Něco se pokazilo.';

  @override
  String get conversationOfflineBanner => 'Jste offline';

  @override
  String get conversationNotUpdated => 'Neaktualizováno';

  @override
  String get conversationMe => 'já';

  @override
  String get conversationNoSender => '(bez odesílatele)';

  @override
  String get conversationNoRecipients => 'bez příjemců';

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
  String get conversationHeaderCc => 'Kopie';

  @override
  String get conversationHeaderBcc => 'Skrytá kopie';

  @override
  String get conversationHeaderReplyTo => 'Odpovědět na';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Zabezpečení';

  @override
  String get conversationVerifiedSender => 'Ověřený odesílatel';

  @override
  String get conversationUnverifiedSender => 'Neověřený odesílatel';

  @override
  String get conversationLoadingMessage => 'Načítání zprávy';

  @override
  String get conversationBodyError => 'Tuto zprávu se nepodařilo načíst.';

  @override
  String get conversationBodyOffline => 'Jste offline. Zpráva se načte, až budete znovu online.';

  @override
  String get conversationOriginalHint => 'Lépe vypadá v zobrazení „Originál“';

  @override
  String get conversationShowOriginal => 'Zobrazit originál';

  @override
  String get conversationScrollToTop => 'Posunout nahoru';

  @override
  String get conversationTagsMenu => 'Štítky…';

  @override
  String get conversationMuteThread => 'Ztlumit vlákno';

  @override
  String get conversationUnmuteThread => 'Zrušit ztlumení vlákna';

  @override
  String get conversationMoveMenu => 'Přesunout…';

  @override
  String get conversationDeletePermanently => 'Trvale smazat';

  @override
  String get conversationMoveToTrash => 'Přesunout do koše';

  @override
  String get conversationNotJunk => 'Není spam';

  @override
  String get conversationShowAllHeaders => 'Zobrazit všechna záhlaví';

  @override
  String get conversationViewSource => 'Zobrazit zdroj';

  @override
  String get conversationSaveAsFile => 'Uložit jako soubor…';

  @override
  String get conversationShareAsFile => 'Sdílet jako soubor…';

  @override
  String get conversationSearchFromMessageMenu => 'Hledat podle této zprávy…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopírovat adresu';

  @override
  String get conversationAddressCopied => 'Adresa zkopírována';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Hledat zprávy od: $name';
  }

  @override
  String get conversationTags => 'Štítky';

  @override
  String get conversationAllHeaders => 'Všechna záhlaví';

  @override
  String get conversationCopyAll => 'Kopírovat vše';

  @override
  String get conversationHeadersCopied => 'Záhlaví zkopírována';

  @override
  String get conversationNoHeaders => 'Žádná záhlaví';

  @override
  String get conversationSearchFromMessageTitle => 'Hledat podle této zprávy';

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
    return 'Předmět „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Zdroj';

  @override
  String get conversationSourceCopied => 'Zdroj zkopírován';

  @override
  String get conversationShareFailed => 'Zprávu se nepodařilo sdílet.';

  @override
  String get conversationWrapLines => 'Zalamovat řádky';

  @override
  String get conversationDontWrapLines => 'Nezalamovat řádky';

  @override
  String get conversationSourceError => 'Zdroj se nepodařilo načíst.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Zobrazeno prvních $shown z $total. Celý zdroj získáte zkopírováním nebo sdílením.';
  }

  @override
  String get conversationAttachmentUntitled => 'Bez názvu';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Další akce pro $name';
  }

  @override
  String get conversationMoveTo => 'Přesunout do…';

  @override
  String get conversationMailboxesError => 'Schránky se nepodařilo načíst.';

  @override
  String get conversationReaderReadable => 'Čitelné';

  @override
  String get conversationReaderOriginal => 'Originál';

  @override
  String get conversationReaderPlain => 'Text';

  @override
  String get conversationReaderSans => 'Bezpatkové';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Zachovat původní barvy';

  @override
  String get conversationReaderRemember => 'Zapamatovat pro tohoto odesílatele';

  @override
  String get conversationSecurityPossiblePhishing => 'Možný phishing';

  @override
  String get conversationSecurityBeCareful => 'Buďte opatrní';

  @override
  String get conversationSecurityVerified => 'Ověřeno';

  @override
  String get conversationSecurityNoIssues => 'Nenalezeny žádné problémy';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sledovačů',
      few: '$count sledovače',
      one: '$count sledovač',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Ukáže proč';

  @override
  String get conversationPhishingBannerTitle => 'Tato zpráva vypadá jako phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Odkazy a obrázky jsou vypnuté.';
  }

  @override
  String get conversationPhishingBannerText => 'Odkazy a obrázky jsou vypnuté.';

  @override
  String get conversationPhishingWhy => 'Proč?';

  @override
  String get conversationPhishingShowAnyway => 'Přesto zobrazit';

  @override
  String get conversationSecurityPhishingTitle => 'Vypadá to jako phishing';

  @override
  String get conversationSecurityPhishingText => 'Několik znaků naznačuje, že tato zpráva není tím, za co se vydává.';

  @override
  String get conversationSecurityCarefulTitle => 'S touto zprávou buďte opatrní';

  @override
  String get conversationSecurityCarefulText => 'Něco na ní stojí za druhý pohled.';

  @override
  String get conversationSecurityVerifiedText => 'Odesílatel je ověřený a nic nevypadá podezřele.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nic nevypadá podezřele. Váš poštovní server neuvedl, zda je odesílatel ověřený.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nic nevypadá podezřele.';

  @override
  String get conversationSecurityWhy => 'Proč';

  @override
  String get conversationSecurityPrivacy => 'Soukromí';

  @override
  String get conversationSecurityNoTrackingPixels => 'Žádné sledovací pixely';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstraněno $count sledovacích pixelů',
      few: 'Odstraněny $count sledovací pixely',
      one: 'Odstraněn $count sledovací pixel',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Prozradily by odesílateli, kdy jste tuto zprávu otevřeli.';

  @override
  String get conversationSecurityNoRemoteImages => 'Žádné vzdálené obrázky';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vzdálených obrázků',
      few: '$count vzdálené obrázky',
      one: '$count vzdálený obrázek',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Jejich načtení prozradí odesílateli, kdy tuto zprávu čtete, a také vaši IP adresu.';

  @override
  String get conversationSecurityNoClickTracking => 'Žádné sledování kliknutí';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odkazů přes sledování kliknutí',
      few: '$count odkazy přes sledování kliknutí',
      one: '$count odkaz přes sledování kliknutí',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Vaše kliknutí by zaznamenaly tyto služby: $services. Podržením odkazu otevřete jeho cíl přímo.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technické podrobnosti';

  @override
  String get conversationSecurityCheckedLocally => 'Zkontrolováno v tomto zařízení. Nic se nikam neodeslalo.';

  @override
  String get conversationSecurityTrackersLabel => 'Sledovače';

  @override
  String get conversationSecurityImagesFrom => 'Obrázky z';

  @override
  String get conversationSecuritySenderHistory => 'Historie s odesílatelem';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'přijato: $received, odesláno: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Odkazy vedou na';

  @override
  String get conversationSecurityHidden => 'Skryté';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements prvků',
      few: '$elements prvky',
      one: '$elements prvek',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters znaků',
      few: '$characters znaky',
      one: '$characters znak',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Neověřený odesílatel';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Váš poštovní server nedokázal potvrdit, že tato zpráva opravdu pochází z $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Váš poštovní server nedokázal potvrdit, že tato zpráva opravdu pochází od svého odesílatele.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Váš poštovní server nedokázal potvrdit, že tato zpráva pochází z $domain. U e-mailových konferencí je to běžné.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Váš poštovní server nedokázal potvrdit, že tato zpráva pochází od svého odesílatele. U e-mailových konferencí je to běžné.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nejednejte podle ní, pokud jste ji nečekali. Máte-li pochybnosti, kontaktujte odesílatele jinou cestou.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Podepsáno jinou doménou';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Zpráva je podepsaná doménou $signer, ne $domain. Rozesílací služby to tak dělají, ale nedokazuje to, kdo ji napsal.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Zpráva je podepsaná jinou doménou, ne $domain. Rozesílací služby to tak dělají, ale nedokazuje to, kdo ji napsal.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Jméno ukazuje jinou adresu';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Jméno odesílatele zní „$shown“, ale zpráva přichází z $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Věřte adrese, ne jménu.';

  @override
  String get conversationSecurityReplyToTitle => 'Odpovědi jdou jinam';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vaše odpověď by šla na $address, ne do $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Než odpovíte čímkoli osobním, zkontrolujte adresu.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Používá vaše jméno';

  @override
  String get conversationSecurityImpersonationTitle => 'Používá jméno někoho, koho znáte';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Je podepsaná „$name“ jako vy, ale přichází z nové adresy: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Je podepsaná „$name“ jako váš VIP kontakt $knownName ($knownEmail), ale přichází z nové adresy: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Je podepsaná „$name“ jako $knownName ($knownEmail), ale přichází z nové adresy: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'A odpovědi by šly na ještě jinou adresu.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Pokud žádá peníze, kódy nebo soubory, nejdřív si to ověřte u dané osoby jinou cestou.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Známá adresa: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Tato adresa: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'První zpráva od tohoto odesílatele';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Od $email jste dosud poštu nedostali.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Buďte opatrní u žádostí od lidí, které ještě neznáte.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Podobně vypadající písmena v adrese odesílatele';

  @override
  String get conversationSecurityLinkHomographTitle => 'Podobně vypadající písmena v odkazu';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host míchá písmena z různých abeced, aby napodobil jinou adresu.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host používá podobně vypadající písmena: není to $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Smažte ji nebo ji nahlaste jako spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Neotvírejte ho.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Doména: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Napodobená doména';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Používá v doméně známé jméno';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain vypadá jako vaše vlastní doména $real, ale je to jiná doména.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain vypadá jako $brand ($real), ale je to jiná doména.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain používá jméno vaší vlastní domény $real, ale nepatří k ní.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain používá jméno $brand ($real), ale nepatří k ní.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Skutečné zprávy od vaší organizace přicházejí z $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Skutečné zprávy od $brand přicházejí z $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Doména odesílatele: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Napodobuje: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odkazů skrývá, kam vedou',
      few: '$count odkazy skrývají, kam vedou',
      one: 'Odkaz skrývá, kam vede',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Odkaz ukazuje $shown, ale otevře $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Přes tyto odkazy se nepřihlašujte ani neplaťte. Raději zadejte adresu sami.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Cíl odkazu nelze ověřit';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Odkaz ukazuje $shown, ale vede přes $host, který kliknutí zaznamená, než ho předá dál.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Odkaz vede na holou IP adresu';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts není web se jménem. Skutečné firmy takto odkazují jen zřídka.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Maskovaný odkaz';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Odkaz začíná „$shown@“, aby vypadal jako $shown, ale otevře $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Skrytá stránka byla zakázána';

  @override
  String get conversationSecurityDataLinkText =>
      'Odkaz by otevřel stránku zabalenou přímo ve zprávě, což je způsob, jak obejít kontrolu odkazů.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Žádá heslo';

  @override
  String get conversationSecurityPasswordFieldText => 'Zpráva obsahovala pole pro heslo. Loupe ho odstranila.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nikdy nezadávejte heslo do e-mailu.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Odkaz spouštějící kód byl zakázán';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nikdy nespouští kód ze zpráv.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zkrácené odkazy',
      few: 'Zkrácené odkazy',
      one: 'Zkrácený odkaz',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skrývá skutečný cíl, dokud ho neotevřete.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Mezinárodní webová adresa';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts používá nelatinková písmena. V mnoha jazycích je to normální; ověřte, že jde o web, který očekáváte.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mnoho skrytého textu';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstraněno $count znaků neviditelného textu. Takový skrytý text má oklamat spamové filtry.',
      few: 'Odstraněny $count znaky neviditelného textu. Takový skrytý text má oklamat spamové filtry.',
      one: 'Odstraněn $count znak neviditelného textu. Takový skrytý text má oklamat spamové filtry.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skrytý text odstraněn';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstraněno $count znaků neviditelného textu.',
      few: 'Odstraněny $count znaky neviditelného textu.',
      one: 'Odstraněn $count znak neviditelného textu.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Zprávu se nepodařilo stáhnout. Zkontrolujte připojení a zkuste to znovu.';

  @override
  String exportSaved(String name) {
    return 'Uloženo „$name“';
  }

  @override
  String get exportSaveFailed => 'Zprávu se nepodařilo uložit.';

  @override
  String exportFailed(String folder) {
    return '„$folder“ se nepodařilo exportovat.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Ve složce „$folder“ nejsou žádné zprávy k exportu.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '„$folder“ se nepodařilo exportovat: nepodařilo se stáhnout žádnou zprávu. Zkontrolujte připojení a zkuste to znovu.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uloženo „$name“ bez $formattedCount zpráv, které se nepodařilo stáhnout.',
      few: 'Uloženo „$name“ bez $formattedCount zpráv, které se nepodařilo stáhnout.',
      one: 'Uloženo „$name“ bez $count zprávy, kterou se nepodařilo stáhnout.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ se nepodařilo uložit.';
  }

  @override
  String exportTitle(String folder) {
    return 'Export „$folder“';
  }

  @override
  String get exportListing => 'Vyhledávání zpráv…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportuje se $current z $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount zpráv se nepodařilo stáhnout',
      few: '$formattedCount zprávy se nepodařilo stáhnout',
      one: '$count zprávu se nepodařilo stáhnout',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Schránky';

  @override
  String get mailboxesShown => 'Zobrazeno';

  @override
  String get mailboxesHidden => 'Skryto';

  @override
  String get mailboxesCollapse => 'Sbalit';

  @override
  String get mailboxesExpand => 'Rozbalit';

  @override
  String get mailboxesManageVips => 'Spravovat VIP';

  @override
  String get mailboxesSubscriptions => 'Odběry';

  @override
  String mailboxesShowAccount(String account) {
    return 'Zobrazit $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Skrýt $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportovat složku…';

  @override
  String get mailboxesUnpin => 'Odepnout';

  @override
  String get mailboxesLists => 'Konference';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Uložte hledání a bude tady.';

  @override
  String get mailboxesTags => 'Štítky';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Můžete také klepnout na jméno odesílatele ve zprávě a zapnout VIP.';

  @override
  String get mailboxesAddVip => 'Přidat VIP…';

  @override
  String get mailboxesAddVipTitle => 'Přidat VIP';

  @override
  String get mailboxesAddVipText => 'Pošta z této adresy dostane hvězdičku a objeví se ve schránce VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Nepřečtené';

  @override
  String get messageListFilterFlagged => 'S vlajkou';

  @override
  String get messageListFilterToMe => 'Komu: mně';

  @override
  String get messageListFilterCcMe => 'Kopie: mně';

  @override
  String get messageListFilterWithAttachments => 'S přílohami';

  @override
  String get messageListFilterUnreplied => 'Bez odpovědi';

  @override
  String get messageListFilterFromVips => 'Od VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zpráv označeno jako přečtené',
      few: '$count zprávy označeny jako přečtené',
      one: '$count zpráva označena jako přečtená',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Starší poštu se nepodařilo načíst.';

  @override
  String get messageListSelectMessages => 'Výběr zpráv';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vybráno: $count',
      few: 'Vybráno: $count',
      one: 'Vybráno: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Vybrat vše';

  @override
  String get messageListDeselectAll => 'Zrušit výběr';

  @override
  String get messageListLoadFailed => 'Poštu se nepodařilo načíst';

  @override
  String get messageListNoUnread => 'Žádná nepřečtená pošta';

  @override
  String get messageListNoMatches => 'Žádná odpovídající pošta';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtry: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Vypnout filtr';

  @override
  String get messageListEmpty => 'Žádná pošta';

  @override
  String get messageListFilter => 'Filtr';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kritéria filtru: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtry:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount nepřečtených',
      few: '$formattedCount nepřečtené',
      one: '$formattedCount nepřečtená',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Označit';

  @override
  String get messageListTrash => 'Do koše';

  @override
  String get messageListFilterTitle => 'Filtr';

  @override
  String get messageListFilterInclude => 'ZAHRNOUT';

  @override
  String get panesHideMailboxes => 'Skrýt schránky';

  @override
  String get panesShowMailboxes => 'Zobrazit schránky';

  @override
  String get panesMailboxesWidth => 'Šířka sloupce schránek';

  @override
  String get panesListWidth => 'Šířka seznamu zpráv';

  @override
  String get panesNoMessageSelected => 'Není vybrána žádná zpráva';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zpráv',
      few: '$count zprávy',
      one: '$count zpráva',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Odložené';

  @override
  String get snoozeSheetTitle => 'Odložit';

  @override
  String get snoozeLaterToday => 'Později dnes';

  @override
  String get snoozeThisEvening => 'Dnes večer';

  @override
  String get snoozeTomorrow => 'Zítra';

  @override
  String get snoozeThisWeekend => 'Tento víkend';

  @override
  String get snoozeNextWeek => 'Příští týden';

  @override
  String get snoozePickDateTime => 'Vybrat datum a čas…';

  @override
  String get snoozeMenu => 'Odložit…';

  @override
  String get snoozeWakeNow => 'Vrátit hned';

  @override
  String get snoozeChangeTimeMenu => 'Změnit čas odložení…';

  @override
  String get snoozeChangeTime => 'Změnit čas';

  @override
  String get snoozeNoTime => 'Čas nenastaven';

  @override
  String get snoozeFooter => 'Odložené zprávy se ve svůj čas vrátí do Doručené pošty jako nepřečtené.';

  @override
  String get snoozeEmptyTitle => 'Nic není odloženo';

  @override
  String get snoozeEmptyText => 'Odložte zprávu a vrátí se do Doručené pošty, až ji budete potřebovat.';

  @override
  String get appLockUnlock => 'Odemknout';

  @override
  String get appLockFailed => 'Loupe nedokázala ověřit, že jste to vy.';

  @override
  String get appLockLockedOut => 'Příliš mnoho pokusů. Zkuste to později.';

  @override
  String get appLockPromptError => 'Výzvu se nepodařilo zobrazit. Zkuste to znovu.';

  @override
  String get appLockNoScreenLock => 'Tento telefon nemá zámek obrazovky.';

  @override
  String get appLockUnlockPromptTitle => 'Odemknout Loupe';

  @override
  String get appLockUnlockPromptReason => 'Potvrďte, že jste to vy, a uvidíte svou poštu.';

  @override
  String get appLockTurnOnPromptTitle => 'Zapnout zámek aplikace';

  @override
  String get appLockTurnOnPromptReason => 'Potvrďte, že jste to vy, a zapněte zámek aplikace.';

  @override
  String get appLockScreenLockRemoved =>
      'Zámek aplikace je vypnutý: tento telefon už nemá zámek obrazovky. Nastavte ho a zámek aplikace půjde znovu zapnout.';

  @override
  String get appLockAfterImmediately => 'Okamžitě';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      few: '$count minuty',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hodin',
      few: '$count hodiny',
      one: '$count hodina',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Šifrováno';

  @override
  String get openpgpEncryptedInPart => 'Částečně šifrováno';

  @override
  String get openpgpEncryptedLocked => 'Šifrováno · zamčeno';

  @override
  String get openpgpEncryptedNoKey => 'Šifrováno · chybí klíč';

  @override
  String get openpgpEncryptedDamaged => 'Šifrováno · poškozeno';

  @override
  String get openpgpEncryptedUnsupported => 'Šifrováno · nepodporováno';

  @override
  String get openpgpUnknownSigner => 'neznámý';

  @override
  String get openpgpUnknownKey => 'Neznámý klíč';

  @override
  String get openpgpSignatureInvalid => 'Neplatný podpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Podepsáno: $name, ne odesílatel';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Částečně podepsáno: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Podepsáno: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Podepsáno odmítnutým klíčem';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Podepsáno: $name · klíč nepřijat';
  }

  @override
  String get openpgpUnlock => 'Odemknout';

  @override
  String get openpgpCantDecrypt => 'Tuto zprávu nelze dešifrovat';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifrováno pomocí OpenPGP';

  @override
  String get openpgpEncryption => 'Šifrování';

  @override
  String get openpgpDecryptedHere => 'Dešifrováno v tomto zařízení';

  @override
  String get openpgpNotDecrypted => 'Nedešifrováno';

  @override
  String get openpgpKeyLocked => 'Váš klíč je zamčený.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pro klíče $keys',
      few: 'Pro klíče $keys',
      one: 'Pro klíč $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Chráněný předmět';

  @override
  String get openpgpUnlockKey => 'Odemknout klíč';

  @override
  String get openpgpSignature => 'Podpis';

  @override
  String get openpgpFingerprint => 'Otisk';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID klíče $id';
  }

  @override
  String get openpgpSigned => 'Podepsáno';

  @override
  String get openpgpProblem => 'Problém';

  @override
  String get openpgpAcceptance => 'Přijetí';

  @override
  String get openpgpChangeAcceptance => 'Změnit přijetí…';

  @override
  String get openpgpCheckedFooter => 'Zkontrolováno v tomto zařízení pomocí OpenPGP, kompatibilně s Thunderbirdem.';

  @override
  String get openpgpSummaryLocked => 'Váš klíč je zamčený. Odemkněte ho heslem, abyste si mohli tuto zprávu přečíst.';

  @override
  String get openpgpSummaryNoSecretKey => 'Byla zašifrována pro klíč, který v tomto zařízení není.';

  @override
  String get openpgpSummaryDamaged => 'Šifrovaná data jsou poškozená nebo byla cestou změněna.';

  @override
  String get openpgpSummaryUnsupported => 'Používá algoritmus, který Loupe nepodporuje.';

  @override
  String get openpgpSummaryEncrypted => 'Přečíst ji můžete jen vy a ostatní příjemci.';

  @override
  String get openpgpSummaryNotSigned => 'Není podepsaná, takže odesílatel není ověřený.';

  @override
  String get openpgpSummaryUnknownKey => 'Je podepsaná, ale klíčem, který nemáte, takže podpis nelze ověřit.';

  @override
  String get openpgpSummaryBadSignature => 'Podpis nesouhlasí: zpráva mohla být změněna.';

  @override
  String get openpgpSummaryMismatch => 'Podpis je platný, ale klíč patří k jiné adrese, než je adresa odesílatele.';

  @override
  String get openpgpSummaryPartial =>
      'Podepsaná je jen část zprávy. Text mimo podpis (například patička e-mailové konference) je zobrazen pod řádkem „Unsigned content“ a podpis nepokrývá ani další části zprávy, například přílohy.';

  @override
  String get openpgpSummaryOwnKey => 'Podepsáno vaším vlastním klíčem.';

  @override
  String get openpgpSummaryVerified => 'Podpis je platný a otisk klíče jste ověřili.';

  @override
  String get openpgpSummaryUnverified => 'Podpis je platný. Klíč jste přijali bez ověření otisku.';

  @override
  String get openpgpSummaryRejected => 'Podpis je platný, ale tento klíč jste odmítli.';

  @override
  String get openpgpSummaryUndecided =>
      'Podpis je platný, ale tento klíč jste ještě nepřijali. Porovnejte jeho otisk s odesílatelem.';

  @override
  String get openpgpAcceptanceRejected => 'Odmítnut';

  @override
  String get openpgpAcceptanceUndecided => 'Nepřijat';

  @override
  String get openpgpAcceptanceUnverified => 'Přijat';

  @override
  String get openpgpAcceptanceVerified => 'Přijat a ověřen';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Přijmout klíč uživatele $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Otisk $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ano, otisk je ověřený';

  @override
  String get openpgpAcceptUnverified => 'Ano, bez ověření';

  @override
  String get openpgpAcceptLater => 'Zatím ne';

  @override
  String get openpgpRejectKey => 'Odmítnout tento klíč';

  @override
  String get openpgpNoSubject => '(bez předmětu)';

  @override
  String get openpgpEncryptionTitle => 'Koncové šifrování';

  @override
  String get openpgpMyKeys => 'Moje klíče OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'S klíčem můžete číst šifrovanou poštu a podepisovat a šifrovat vlastní. Používáte Thunderbird? Exportujte v něm svůj klíč (Nastavení účtu › Koncové šifrování › Exportovat tajný klíč) a importujte ho sem.';

  @override
  String get openpgpAddKey => 'Přidat klíč…';

  @override
  String get openpgpAddresses => 'Adresy';

  @override
  String get openpgpAddressesFooter => 'Jaký klíč každá adresa používá a kdy šifruje a podepisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'Klíče OpenPGP korespondentů';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Klíč přijměte, jakmile věříte, že patří svému vlastníkovi; porovnejte s ním otisk a označte klíč jako ověřený.';

  @override
  String get openpgpImportPublicKey => 'Importovat veřejný klíč…';

  @override
  String get openpgpCollected => 'Získáno přes Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Klíče, které přišly se zprávami. Loupe pro ně může šifrovat, když o to obě strany žádají.';

  @override
  String get openpgpOnThisDevice => 'V tomto zařízení';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifrované zprávy skrývají svůj předmět. Loupe si předmět každé otevřené zprávy uloží do své šifrované databáze v tomto zařízení, aby ho zobrazoval seznam, hledání i oznámení. Na pozadí může Loupe také dešifrovat předměty nových zpráv pomocí klíčů bez hesla; každou zprávu (do 1 MB) si k tomu stáhne.';

  @override
  String get openpgpDecryptSubjects => 'Dešifrovat předměty na pozadí';

  @override
  String get openpgpIndexFooter =>
      'Hledání najde šifrované zprávy podle odesílatele, příjemců a předmětu. Když je tato volba zapnutá, Loupe přidá do vyhledávacího indexu ve své šifrované databázi v tomto zařízení i text každé dešifrované zprávy, takže ji hledání najde i podle textu. Vypnutím se tento text z indexu odstraní.';

  @override
  String get openpgpIndexDecrypted => 'Indexovat dešifrované zprávy pro hledání';

  @override
  String get openpgpPassphrases => 'Hesla ke klíčům';

  @override
  String get openpgpPassphrasesFooter =>
      'Klíče OpenPGP a certifikáty S/MIME chráněné heslem se odemknou, když je potřeba. Bez volby „Pamatovat si“ se dvě minuty po každém použití znovu zamknou.';

  @override
  String get openpgpRememberPassphrases => 'Pamatovat si hesla ke klíčům';

  @override
  String get openpgpRememberPassphrasesDetail => 'Do zavření Loupe';

  @override
  String get openpgpLockKeysNow => 'Zamknout klíče hned';

  @override
  String get openpgpKeysLocked => 'Klíče zamčeny.';

  @override
  String get openpgpKeyStateRevoked => 'odvolán';

  @override
  String get openpgpKeyStateExpired => 'vypršel';

  @override
  String get openpgpKeyStateNeverExpires => 'nevyprší';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'vyprší $date';
  }

  @override
  String get openpgpNoKey => 'Bez klíče';

  @override
  String get openpgpAlwaysEncrypt => 'Vždy šifrovat';

  @override
  String get openpgpAddKeyTitle => 'Přidat klíč OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importujte klíč, který používáte v Thunderbirdu, nebo vytvořte nový.';

  @override
  String get openpgpImportFromClipboard => 'Importovat ze schránky';

  @override
  String get openpgpImportFromFile => 'Importovat ze souboru';

  @override
  String get openpgpGenerateNewKey => 'Vytvořit nový klíč';

  @override
  String get openpgpImportPublicKeyTitle => 'Importovat veřejný klíč';

  @override
  String get openpgpFromClipboard => 'Ze schránky';

  @override
  String get openpgpFromFile => 'Ze souboru';

  @override
  String get openpgpClipboardEmpty => 'Schránka je prázdná. Nejdřív zkopírujte klíč.';

  @override
  String get openpgpKey => 'Klíč';

  @override
  String get openpgpValidityRevoked => 'Odvolán';

  @override
  String openpgpValidityExpired(String date) {
    return 'Vypršel $date';
  }

  @override
  String get openpgpNeverExpires => 'Nevyprší';

  @override
  String openpgpValidUntil(String date) {
    return 'Platný do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Otisk zkopírován.';

  @override
  String get openpgpAlgorithm => 'Algoritmus';

  @override
  String get openpgpCreated => 'Vytvořeno';

  @override
  String get openpgpValidity => 'Platnost';

  @override
  String get openpgpProtection => 'Ochrana';

  @override
  String get openpgpProtectionPassphrase => 'Heslo';

  @override
  String get openpgpProtectionKeychain => 'Jen úložiště klíčů';

  @override
  String get openpgpKeyDetailsFooter =>
      'Sdílejte svůj veřejný klíč, aby vám ostatní mohli posílat šifrované zprávy. Záloha je váš tajný klíč, chráněný heslem, pokud nějaké má: nikomu ji nedávejte.';

  @override
  String get openpgpSharePublicKey => 'Sdílet veřejný klíč';

  @override
  String get openpgpCopyPublicKey => 'Kopírovat veřejný klíč';

  @override
  String get openpgpPublicKeyCopied => 'Veřejný klíč zkopírován.';

  @override
  String get openpgpBackUpSecretKey => 'Zálohovat tajný klíč';

  @override
  String get openpgpDeleteKey => 'Smazat klíč';

  @override
  String get openpgpRemoveKey => 'Odebrat klíč';

  @override
  String get openpgpBackUpTitle => 'Zálohovat tajný klíč?';

  @override
  String get openpgpBackUpProtected =>
      'Záloha je chráněná heslem vašeho klíče. Kdokoli, kdo má obojí, může číst vaši poštu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Tento klíč nemá heslo: kdokoli se zálohou může číst vaši poštu a podepisovat se za vás.';

  @override
  String get openpgpBackUp => 'Zálohovat';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Smazat váš klíč $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Odebrat klíč uživatele $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Poštu zašifrovanou pro tento klíč už v tomto zařízení nepůjde přečíst, dokud ho znovu neimportujete.';

  @override
  String get openpgpRemoveKeyMessage => 'Později ho můžete znovu importovat.';

  @override
  String get openpgpKeyHeader => 'Klíč OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Přidejte klíč v části „Koncové šifrování“, abyste mohli šifrovat a podepisovat poštu z této adresy.';

  @override
  String get openpgpGenerateAKey => 'Vytvořit klíč…';

  @override
  String get openpgpSending => 'Odesílání';

  @override
  String get openpgpSendingFooter =>
      'Automatické šifrování se zapne, když má každý příjemce přijatý klíč nebo důvěryhodný certifikát, nebo když Autocrypt oznámí, že to chtějí obě strany. Šifrovaná pošta je vždy podepsaná.';

  @override
  String get openpgpEncryptAutomatically => 'Šifrovat automaticky';

  @override
  String get openpgpAlwaysEncryptDetail => 'Neodešle, pokud příjemce nemá klíč';

  @override
  String get openpgpSignUnencrypted => 'Podepisovat nešifrovanou poštu';

  @override
  String get openpgpAttachPublicKey => 'Přikládat můj veřejný klíč';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt posílá váš veřejný klíč s každou zprávou, takže vám ostatní aplikace mohou šifrovat bez jakéhokoli nastavování.';

  @override
  String get openpgpSendMyKey => 'Posílat můj klíč s poštou';

  @override
  String get openpgpPreferEncryption => 'Upřednostňovat šifrování';

  @override
  String get openpgpPreferEncryptionDetail => 'Žádat ostatní, aby šifrovali, když mohou';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count let',
      few: '$count roky',
      one: '$count rok',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Hesla se neshodují.';

  @override
  String openpgpKeyReady(String id) {
    return 'Váš klíč $id je připraven.';
  }

  @override
  String get openpgpNewKey => 'Nový klíč';

  @override
  String get openpgpNewKeyFor => 'Pro';

  @override
  String get openpgpYourName => 'Vaše jméno';

  @override
  String get openpgpAddress => 'Adresa';

  @override
  String get openpgpPassphrase => 'Heslo';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Volitelné. Bez hesla chrání klíč jen úložiště klíčů v telefonu a Loupe se na nic neptá. S heslem se na něj Loupe zeptá, když bude klíč potřeba.';

  @override
  String get openpgpRepeatPassphrase => 'Zopakovat';

  @override
  String get openpgpExpires => 'Platnost';

  @override
  String get openpgpExpiresFooter =>
      'Nový klíč můžete vytvořit ještě před vypršením platnosti. Thunderbird také používá tři roky.';

  @override
  String get openpgpGenerateKey => 'Vytvořit klíč';

  @override
  String get openpgpKeyFor => 'Klíč pro';

  @override
  String get openpgpCantEncrypt => 'Nelze zašifrovat';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Pro $names neexistuje klíč OpenPGP a tato adresa vždy šifruje. Odeberte příjemce, nebo importujte jeho klíč v Nastavení › Koncové šifrování.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Pro $names neexistuje platný certifikát S/MIME a tato adresa vždy šifruje. Odeberte příjemce, nebo importujte jeho certifikát v Nastavení › Koncové šifrování.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Pro $names neexistuje klíč OpenPGP.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Pro $names neexistuje platný certifikát S/MIME.';
  }

  @override
  String get openpgpSendUnencrypted => 'Odeslat nešifrovaně';

  @override
  String get openpgpCantSign => 'Nelze podepsat';

  @override
  String get openpgpCantSignMessage =>
      'Soukromý klíč vašeho certifikátu S/MIME není v tomto zařízení. Importujte certifikát znovu (soubor .p12 nebo .pfx) v Nastavení › Koncové šifrování.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Chybí klíč pro $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Chybí certifikát pro $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Klíče z Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Všichni mají klíč';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Všichni mají certifikát';

  @override
  String get openpgpComposeEncrypt => 'Šifrovat';

  @override
  String get openpgpComposeSign => 'Podepsat';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, přepnout';
  }

  @override
  String get openpgpNoKeyFound => 'Nenalezen žádný klíč OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importovat tajný klíč?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Tato příloha obsahuje tajný klíč ($names). Importujte ho jako vlastní klíč, jen pokud jste ho sami exportovali, například z Thunderbirdu.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importovat jako můj klíč';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'váš klíč $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importovat $count klíčů ($names)?',
      few: 'Importovat $count klíče ($names)?',
      one: 'Importovat klíč uživatele $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importovat a přijmout';

  @override
  String get openpgpImportDecideLater => 'Importovat, rozhodnout později';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'klíč uživatele $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importováno: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Je přiloženo $count klíčů OpenPGP.',
      few: 'Jsou přiloženy $count klíče OpenPGP.',
      one: 'Je přiložen klíč OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importovat';

  @override
  String get openpgpUnlockKeyTitle => 'Odemknout klíč OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Zadejte heslo ke klíči uživatele $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Nesprávné heslo. Zkuste to znovu.';

  @override
  String get openpgpExplainLocked =>
      'Tato zpráva je šifrovaná. Odemkněte svůj klíč OpenPGP, abyste si ji mohli přečíst.';

  @override
  String get openpgpExplainNoKey =>
      'Tato zpráva je šifrovaná, ale pro žádný klíč OpenPGP v tomto zařízení. Pokud ji čtete v Thunderbirdu, importujte odtud svůj klíč: Nastavení › Koncové šifrování.';

  @override
  String get openpgpExplainDamaged => 'Tato šifrovaná zpráva je poškozená, takže ji nelze bezpečně dešifrovat.';

  @override
  String get openpgpExplainUnsupported => 'Tato zpráva používá šifrování, které Loupe zatím neumí přečíst.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Tato zpráva je šifrovaná pomocí S/MIME, ale pro žádný certifikát v tomto zařízení. Importujte svůj certifikát (soubor .p12 nebo .pfx) v Nastavení › Koncové šifrování.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Tato zpráva je šifrovaná. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Odemkněte svůj certifikát S/MIME, abyste si ji mohli přečíst.';

  @override
  String get openpgpAttachmentGone => 'Tato příloha už není k dispozici.';

  @override
  String get smimeEncrypted => 'Šifrováno (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifrováno (S/MIME) · chybí certifikát';

  @override
  String get smimeEncryptedDamaged => 'Šifrováno (S/MIME) · poškozeno';

  @override
  String get smimeEncryptedUnsupported => 'Šifrováno (S/MIME) · nepodporováno';

  @override
  String get smimeEncryptedLocked => 'Šifrováno (S/MIME) · zamčeno';

  @override
  String get smimeUnknownSigner => 'neznámý';

  @override
  String get smimeSignatureModified => 'Neplatný podpis: zpráva byla změněna';

  @override
  String get smimeSignatureWeak => 'Nezabezpečený podpis: zastaralý algoritmus';

  @override
  String get smimeSignatureUncheckable => 'Podpis nelze ověřit';

  @override
  String get smimeSignedCertificateMissing => 'Podepsáno · chybí certifikát';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Podepsáno: $name · certifikát odvolán';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Podepsáno: $name · v jiném datu';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Podepsáno: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Podepsáno: $name · neplatný certifikát';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Podepsáno: $name · nedůvěryhodné';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Podepsáno: $name · platnost certifikátu vypršela';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Podepsáno: $name · certifikát ještě není platný';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Podepsáno: $name · certifikát není pro poštu';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Podepsáno: $name, ne odesílatel';
  }

  @override
  String get smimeCantDecrypt => 'Tuto zprávu nelze dešifrovat';

  @override
  String get smimeEncryptedWithSmime => 'Šifrováno pomocí S/MIME';

  @override
  String get smimeEncryption => 'Šifrování';

  @override
  String get smimeDecryptedHere => 'Dešifrováno v tomto zařízení';

  @override
  String get smimeNotDecrypted => 'Nedešifrováno';

  @override
  String get smimeAuthenticated => 'ověřené';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pro $count certifikátů',
      few: 'pro $count certifikáty',
      one: 'pro $count certifikát',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Podpis';

  @override
  String get smimeIssuedBy => 'Vydal';

  @override
  String get smimeValid => 'Platnost';

  @override
  String smimeValidRange(String from, String to) {
    return 'od $from do $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Otisk SHA-256';

  @override
  String get smimeSigned => 'Podepsáno';

  @override
  String get smimeProblem => 'Problém';

  @override
  String get smimeCheckingRevocation => 'Kontrola odvolání…';

  @override
  String get smimeNotRevoked => 'Neodvolán';

  @override
  String get smimeRevoked => 'Odvolán';

  @override
  String get smimeRevocationUnknown => 'Stav odvolání neznámý';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Dotaz u certifikační autority (seznam odvolaných certifikátů), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Dotaz u certifikační autority (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Důvěřovat „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Důvěřovat tomuto certifikátu…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Zkontrolováno v tomto zařízení pomocí S/MIME, kompatibilně s Outlookem a Thunderbirdem; odvolání ověřeno u certifikační autority.';

  @override
  String get smimeCheckedFooter =>
      'Zkontrolováno v tomto zařízení pomocí S/MIME, kompatibilně s Outlookem a Thunderbirdem. Odvolání se nekontroluje (Nastavení › Koncové šifrování).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Důvěřovat $name pro poštu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Důvěřovat certifikátu uživatele $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Důvěryhodný bude každý certifikát, který tato autorita vydá, podobně jako u certifikační autority vaší firmy. Nejdřív porovnejte otisk s jeho vlastníkem:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Nejdřív porovnejte otisk s jeho vlastníkem:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Důvěřovat';

  @override
  String get smimeSummaryNoKey => 'Byla zašifrována pro certifikát, který v tomto zařízení není.';

  @override
  String get smimeSummaryDamaged => 'Šifrovaná data jsou poškozená nebo byla cestou změněna.';

  @override
  String get smimeSummaryUnsupported => 'Používá algoritmus, který Loupe nepodporuje.';

  @override
  String get smimeSummaryLocked => 'Váš certifikát S/MIME je zamčený.';

  @override
  String get smimeSummaryEncrypted => 'Přečíst ji můžete jen vy a ostatní příjemci.';

  @override
  String get smimeSummaryNotSigned => 'Není podepsaná, takže odesílatel není ověřený.';

  @override
  String get smimeSummaryModified => 'Podpis nesouhlasí: zpráva byla po podepsání změněna.';

  @override
  String get smimeSummaryUncheckable => 'Podpis nelze ověřit.';

  @override
  String get smimeSummaryNoCertificate => 'Certifikát podepisujícího ve zprávě není, takže ho nelze ověřit.';

  @override
  String get smimeSummaryRevoked => 'Certifikační autorita odvolala certifikát podepisujícího: podpisu nelze věřit.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikační autorita odvolala certifikát podepisujícího ($reason): podpisu nelze věřit.';
  }

  @override
  String get smimeDateMismatch =>
      'Byla podepsána víc než hodinu před datem zprávy nebo po něm: může jít o starou zprávu odeslanou znovu.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Podpis je platný a $issuer ručí za to, že certifikát patří odesílateli.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikát nebo některý z jeho vydavatelů je neplatný.';

  @override
  String get smimeProblemUntrusted => 'Certifikát pochází od autority, které Loupe nedůvěřuje.';

  @override
  String get smimeProblemExpired => 'Platnost certifikátu vypršela.';

  @override
  String get smimeProblemNotYetValid => 'Certifikát ještě nebyl platný.';

  @override
  String get smimeProblemWrongUsage => 'Certifikát není určen pro poštu.';

  @override
  String get smimeProblemWrongAddress => 'Certifikát patří k jiné adrese, než je adresa odesílatele.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Důvěryhodný · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nedůvěryhodný · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Vypršel $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Platný od $date';
  }

  @override
  String get smimeTrustInvalid => 'Neplatný';

  @override
  String get smimeTrustNotForMail => 'Není pro poštu';

  @override
  String get smimeTrustAnotherAddress => 'Jiná adresa';

  @override
  String get smimeMyCertificates => 'Moje certifikáty S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Pro S/MIME, jak ho používá Outlook a mnoho firem. Importujte svůj certifikát se soukromým klíčem (soubor .p12 nebo .pfx), exportovaný z Outlooku, Windows, macOS nebo Thunderbirdu.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Pro S/MIME, jak ho používá Outlook a mnoho firem. Importujte svůj certifikát se soukromým klíčem (soubor .p12 nebo .pfx), exportovaný z Outlooku, Windows, macOS nebo Thunderbirdu, nebo použijte certifikát, který jste vy nebo vaše firma nainstalovali do tohoto zařízení.';

  @override
  String get smimeCertificateExpired => 'vypršel';

  @override
  String smimeCertificateUntil(String date) {
    return 'do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'v tomto zařízení';

  @override
  String get smimeImportCertificateEllipsis => 'Importovat certifikát…';

  @override
  String get smimeUseDeviceCertificate => 'Použít certifikát z tohoto zařízení…';

  @override
  String get smimeCorrespondentsCertificates => 'Certifikáty korespondentů';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Získané z podepsané pošty, stejně jako to dělají Outlook a Thunderbird. Pošta se šifruje jen pro důvěryhodné certifikáty: Loupe důvěřuje autoritám, kterým Mozilla důvěřuje pro e-mail, a těm, které přidáte.';

  @override
  String get smimeRevocation => 'Odvolání';

  @override
  String get smimeRevocationFooter =>
      'Když otevřete podepsanou poštu, Loupe se zeptá autority, která vydala certifikát podepisujícího, zda ho neodvolala (přes její OCSP server nebo seznam odvolaných certifikátů). Autorita tak může vidět, kdy někdo z vaší internetové adresy čte poštu podepsanou tímto certifikátem. Odpovědi se uchovávají v tomto zařízení, dokud nevyprší. Odvolaný certifikát se v záhlaví zprávy zobrazí jako „certifikát odvolán“.';

  @override
  String get smimeCheckRevocation => 'Kontrolovat odvolání certifikátů online';

  @override
  String get smimeTrustedAuthorities => 'Důvěryhodné autority';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Důvěryhodné pro vás, kromě $count autorit, kterým Mozilla důvěřuje pro e-mail.',
      few: 'Důvěryhodné pro vás, kromě $count autorit, kterým Mozilla důvěřuje pro e-mail.',
      one: 'Důvěryhodné pro vás, kromě $count autority, které Mozilla důvěřuje pro e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikační autorita';

  @override
  String get smimeImportACertificate => 'Importovat certifikát';

  @override
  String get smimeImportContactMessage => 'Certifikát korespondenta (.cer, .crt, .pem) nebo certifikační autority.';

  @override
  String get smimeFromClipboard => 'Ze schránky';

  @override
  String get smimeFromFile => 'Ze souboru';

  @override
  String get smimeClipboardEmpty => 'Schránka je prázdná. Nejdřív zkopírujte certifikát.';

  @override
  String get smimeCertificate => 'Certifikát';

  @override
  String get smimeOnDeviceFooter =>
      'Jeho soukromý klíč zůstává v úložišti pověření Androidu, kam ho nainstalovala vaše firma nebo vy: Loupe žádá Android, aby s ním podepisoval a dešifroval. Podepsaná pošta se podepisuje při odeslání.';

  @override
  String get smimeAddresses => 'Adresy';

  @override
  String get smimeUsage => 'Určení';

  @override
  String get smimeUsageNone => 'Nic, co Loupe používá';

  @override
  String get smimeUsageSigning => 'Podepisování';

  @override
  String get smimeUsageEncryption => 'Šifrování';

  @override
  String get smimeUsageCertificates => 'Certifikáty';

  @override
  String get smimeAlgorithm => 'Algoritmus';

  @override
  String get smimeSerialNumber => 'Sériové číslo';

  @override
  String get smimeFingerprintCopied => 'Otisk zkopírován.';

  @override
  String get smimeSha1Thumbprint => 'Kryptografický otisk SHA-1';

  @override
  String get smimePrivateKey => 'Soukromý klíč';

  @override
  String get smimeKeyOnDevice => 'V tomto zařízení';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'V Loupe, s heslem';

  @override
  String get smimeKeyInLoupe => 'V Loupe';

  @override
  String get smimeSource => 'Zdroj';

  @override
  String get smimeSourceSignedMail => 'Podepsaná pošta';

  @override
  String get smimeSourceImported => 'Importován';

  @override
  String get smimeTrustHeader => 'Důvěra';

  @override
  String get smimeTrustedRoot => 'Důvěryhodný kořen';

  @override
  String get smimeIssuer => 'Vydavatel';

  @override
  String smimeTrustNamed(String name) {
    return 'Důvěřovat „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Důvěřovat této autoritě';

  @override
  String get smimeTrustThisCertificate => 'Důvěřovat tomuto certifikátu';

  @override
  String get smimeStopTrusting => 'Přestat důvěřovat';

  @override
  String get smimePassphrase => 'Heslo';

  @override
  String get smimePassphraseFooter =>
      'Volitelné. S heslem je soukromý klíč v tomto zařízení navíc šifrovaný (Argon2id a AES-256) a Loupe si o něj při podepisování a dešifrování řekne; jak dlouho, určuje volba „Pamatovat si hesla ke klíčům“. Odesílaná pošta se podepisuje při odeslání; procesy na pozadí klíč použít nemohou.';

  @override
  String get smimeChangePassphrase => 'Změnit heslo…';

  @override
  String get smimeSetPassphraseEllipsis => 'Nastavit heslo…';

  @override
  String get smimeRemovePassphrase => 'Odebrat heslo';

  @override
  String get smimeShareCertificate => 'Sdílet certifikát';

  @override
  String get smimeDeleteCertificate => 'Smazat certifikát';

  @override
  String get smimeRemoveCertificate => 'Odebrat certifikát';

  @override
  String get smimePassphraseChanged => 'Heslo změněno.';

  @override
  String get smimePassphraseSet => 'Heslo nastaveno.';

  @override
  String get smimeRemovePassphraseTitle => 'Odebrat heslo?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Soukromý klíč pak bude chránit jen úložiště klíčů, jako bez hesla: Loupe se na něj už nebude ptát a procesy na pozadí ho budou moci použít.';

  @override
  String get smimePassphraseRemoved => 'Heslo odebráno.';

  @override
  String smimeTrustTitle(String name) {
    return 'Důvěřovat $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Každý certifikát, který vydá, bude pro poštu důvěryhodný. Nejdřív porovnejte otisk s jeho vlastníkem:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Smazat váš certifikát $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Odebrat certifikát uživatele $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ho přestane používat: poštu zašifrovanou pro něj už v Loupe nepůjde přečíst. Certifikát v tomto zařízení zůstane (Nastavení › Zabezpečení › Šifrování a pověření).';

  @override
  String get smimeDeleteOwnMessage =>
      'Jeho soukromý klíč bude z tohoto zařízení smazán: poštu zašifrovanou pro něj tu už nepůjde přečíst, dokud ho znovu neimportujete.';

  @override
  String get smimeRemoveContactMessage => 'Vrátí se s další podepsanou zprávou od této osoby.';

  @override
  String get smimeAddressImportFooter =>
      'Importujte certifikát pro tuto adresu, abyste mohli podepisovat a šifrovat pomocí S/MIME, jako to dělá Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importovat certifikát…';

  @override
  String get smimePreferFooter =>
      'Když mohou zprávu chránit oba standardy, použije se upřednostňovaný, pokud jen ten druhý nemá klíč nebo certifikát pro každého příjemce.';

  @override
  String get smimePreferSmime => 'Upřednostňovat S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Místo OpenPGP';

  @override
  String get smimeCertificatePassword => 'Heslo certifikátu';

  @override
  String get smimeCertificatePasswordPrompt => 'Zadejte heslo, se kterým byl soubor certifikátu exportován.';

  @override
  String get smimeImport => 'Importovat';

  @override
  String get smimeWrongPassword => 'Nesprávné heslo. Zkuste to znovu.';

  @override
  String get smimeNoCertificateFound => 'Nenalezen žádný certifikát.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikát uživatele $name';
  }

  @override
  String get smimeNothingNew => 'Nic nového k importu.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importováno: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importováno $count důvěryhodných certifikačních autorit.',
      few: 'Importovány $count důvěryhodné certifikační autority.',
      one: 'Importována důvěryhodná certifikační autorita.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importováno: $certificates a $count důvěryhodných certifikačních autorit.',
      few: 'Importováno: $certificates a $count důvěryhodné certifikační autority.',
      one: 'Importováno: $certificates a důvěryhodná certifikační autorita.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Tento soubor neobsahuje soukromý klíč. Exportujte certifikát i se soukromým klíčem.';

  @override
  String get smimeImportAsYoursTitle => 'Importovat jako váš certifikát?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Tato příloha obsahuje certifikát se soukromým klíčem: $names. Importujte ho, jen pokud jste ho sami exportovali, například z Outlooku nebo Thunderbirdu.';
  }

  @override
  String get smimeImportAsMine => 'Importovat jako můj certifikát';

  @override
  String smimeImportedOwn(String names) {
    return 'Importován váš certifikát $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Z tohoto zařízení byl přidán váš certifikát $name ($addresses).';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Důvěřovat „$name“ pro poštu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe tuto certifikační autoritu nezná (možná jde o vlastní autoritu nějaké firmy). Důvěřujte jí, aby bylo možné ověřovat certifikáty, které vydává. Nejdřív porovnejte její otisk se svým IT oddělením:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Je přiloženo $count certifikátů.',
      few: 'Jsou přiloženy $count certifikáty.',
      one: 'Je přiložen certifikát.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importovat certifikát';

  @override
  String get smimeUnlockTitle => 'Odemknout certifikát S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Zadejte heslo k certifikátu uživatele $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Nesprávné heslo. Zkuste to znovu.';

  @override
  String get smimeUnlock => 'Odemknout';

  @override
  String get smimeEnterAPassphrase => 'Zadejte heslo.';

  @override
  String get smimePassphrasesDiffer => 'Hesla se liší.';

  @override
  String get smimeSetPassphraseTitle => 'Nastavit heslo';

  @override
  String get smimeSetPassphraseText =>
      'Loupe si o něj řekne při podepisování a dešifrování. Pokud ho zapomenete, importujte certifikát znovu ze souboru .p12.';

  @override
  String get smimePassphraseAgain => 'Znovu';

  @override
  String get smimeSetPassphraseButton => 'Nastavit';

  @override
  String get smimeLockedOpenAgain => 'Váš certifikát S/MIME je zamčený. Otevřete zprávu znovu a odemkněte ho.';

  @override
  String get smimeDeviceHasNoCertificates => 'Toto zařízení své certifikáty nenabízí.';

  @override
  String get smimeCantReadCertificate => 'Loupe tento certifikát nedokáže přečíst.';

  @override
  String get smimeCertificateNotForMail =>
      'Tento certifikát není pro poštu: nemá e-mailovou adresu nebo není určen k podepisování ani šifrování.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikát už v tomto zařízení není nebo ho Loupe už nesmí používat. Vyberte ho znovu v Nastavení › Koncové šifrování.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikát v tomto zařízení lze použít, jen když je Loupe otevřená.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifrovaný klíč je poškozený.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikát v tomto zařízení to neumí: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nepodporováno';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikát v tomto zařízení selhal: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa autority není webová adresa.';

  @override
  String get smimeAuthorityTimeout => 'Certifikační autorita neodpověděla včas.';

  @override
  String get smimeAuthorityUnreachable => 'Certifikační autoritu se nepodařilo kontaktovat.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikační autorita odpověděla kódem $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odpověď certifikační autority je příliš velká.';

  @override
  String get smimeRevocationNotChecked =>
      'Nezkontrolováno: kontrolují se jen certifikáty od autorit, kterým Loupe důvěřuje.';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Stejný jako v telefonu';

  @override
  String get settingsLanguageFooter =>
      'Loupe používá jazyk telefonu, pokud ho podporuje, a jinak angličtinu. Jazyk, který zde vyberete, platí jen pro Loupe, včetně oznámení.';

  @override
  String get settingsAccountsHeader => 'Účty';

  @override
  String get settingsAddAccount => 'Přidat účet';

  @override
  String get settingsMailHeader => 'Pošta';

  @override
  String get settingsSwipeActions => 'Akce přejetí';

  @override
  String get settingsSwipeLeft => 'Přejetí doleva';

  @override
  String get settingsSwipeLeftFooter =>
      'Úplné přejetí provede tuto akci. „Označit vlajkou“ a „Více“ jsou vždy na krátké přejetí.';

  @override
  String get settingsSwipeRight => 'Přejetí doprava';

  @override
  String get settingsSwipeRightFooter => 'Úplné přejetí provede tuto akci.';

  @override
  String get settingsSwipeToggleRead => 'Označit jako přečtené / nepřečtené';

  @override
  String get settingsSwipeTrash => 'Do koše';

  @override
  String get settingsSwipeMove => 'Přesunout zprávu';

  @override
  String get settingsSwipeSnooze => 'Odložit';

  @override
  String get settingsThreaded => 'Seskupovat do konverzací';

  @override
  String get settingsUndoSendDelay => 'Prodleva pro vrácení odeslání';

  @override
  String get settingsUndoSendDelayFooter => 'Odeslané zprávy tak dlouho počkají, abyste je mohli vzít zpět.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekund',
      few: '$seconds sekundy',
      one: '$seconds sekunda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Vzhled';

  @override
  String get settingsTheme => 'Motiv';

  @override
  String get settingsThemeSystem => 'Automaticky';

  @override
  String get settingsThemeLight => 'Světlý';

  @override
  String get settingsThemeDark => 'Tmavý';

  @override
  String get settingsDensity => 'Seznam zpráv';

  @override
  String get settingsDensityComfortable => 'Vzdušný';

  @override
  String get settingsDensityCompact => 'Kompaktní';

  @override
  String get settingsReadingHeader => 'Čtení';

  @override
  String get settingsReadingFooter => 'Vzdálené obrázky mohou odesílatelům prozradit, kdy a kde jste zprávu otevřeli.';

  @override
  String get settingsDefaultView => 'Výchozí zobrazení';

  @override
  String get settingsDefaultViewFooter => 'Každou zprávu můžete přepnout tlačítkem Aa.';

  @override
  String get settingsViewReadable => 'Čitelné';

  @override
  String get settingsViewReadableDetail => 'Čisté, čitelné, řídí se tmavým režimem';

  @override
  String get settingsViewOriginal => 'Originál';

  @override
  String get settingsViewOriginalDetail => 'Přesně tak, jak ji navrhl odesílatel';

  @override
  String get settingsViewPlain => 'Prostý text';

  @override
  String get settingsViewPlainDetail => 'Jen slova';

  @override
  String get settingsPlainTextFont => 'Písmo prostého textu';

  @override
  String get settingsFontSans => 'Bezpatkové';

  @override
  String get settingsFontMono => 'Neproporcionální';

  @override
  String get settingsFontMonoDetail => 'Zachová zarovnání ASCII artu a tabulek';

  @override
  String get settingsTechnicalLists => 'Technické konference';

  @override
  String get settingsLoadRemoteImages => 'Načítat vzdálené obrázky';

  @override
  String get settingsOpenLinksDirectly => 'Otevírat odkazy přímo';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Vynechat sledování kliknutí, když je cíl známý';

  @override
  String get settingsSecurityHeader => 'Zabezpečení';

  @override
  String get settingsAppLock => 'Zámek aplikace';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe se zeptá při spuštění a také když se vrátíte po nepřítomnosti delší než čas v „Zamknout po“.';

  @override
  String get settingsAppLockFooterOff =>
      'Zámek aplikace si před zobrazením pošty vyžádá otisk prstu, obličej nebo zámek obrazovky.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Zámek aplikace je stále vypnutý. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Nastavte kód';

  @override
  String get settingsScreenLockTextIos =>
      'Zámek aplikace používá Face ID, Touch ID nebo kód a tento iPhone kód nemá. Nastavte ho v aplikaci Nastavení a pak zapněte zámek aplikace.';

  @override
  String get settingsScreenLockTitleAndroid => 'Nastavte zámek obrazovky';

  @override
  String get settingsScreenLockTextAndroid =>
      'Zámek aplikace používá zámek obrazovky telefonu nebo k němu přidaný otisk prstu či obličej a tento telefon žádný nemá. Nastavte PIN, gesto nebo heslo v nastavení Androidu a pak zapněte zámek aplikace.';

  @override
  String get settingsOpenSystemSettings => 'Otevřít nastavení';

  @override
  String get settingsOpenAndroidSettings => 'Otevřít nastavení Androidu';

  @override
  String get settingsLockAfter => 'Zamknout po';

  @override
  String get settingsLockAfterFooter => 'Jak dlouho může být Loupe na pozadí, než se znovu zeptá.';

  @override
  String get settingsNotifications => 'Oznámení';

  @override
  String get settingsEncryption => 'Koncové šifrování';

  @override
  String get settingsAdvanced => 'Pokročilé';

  @override
  String get settingsDemoHeader => 'Ukázka';

  @override
  String get settingsDemoFooter =>
      'Ukázková pošta je smyšlená schránka, která existuje jen v tomto telefonu. Nic se nikam neodesílá.';

  @override
  String get settingsDemoMode => 'Ukázkový režim';

  @override
  String get settingsResetApp => 'Resetovat aplikaci';

  @override
  String get settingsResetFooter => 'Zapomene všechna nastavení a vrátí se na úvodní obrazovku.';

  @override
  String get settingsResetTitle => 'Resetovat Loupe?';

  @override
  String get settingsResetMessage =>
      'Zapomenou se všechna nastavení, schránky Smart Mailbox i nedávná hledání a aplikace se vrátí na úvodní obrazovku.';

  @override
  String get settingsAboutHeader => 'O aplikaci';

  @override
  String get settingsVersion => 'Verze';

  @override
  String get settingsLicences => 'Licence';

  @override
  String get settingsPrivacy => 'Soukromí';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nemá žádnou analytiku ani sledování. Vaše pošta jde jen na vaše poštovní servery.';

  @override
  String get settingsNotificationsOffIos => 'Oznámení pro Loupe jsou vypnutá v Nastavení.';

  @override
  String get settingsNotificationsOffAndroid => 'Oznámení pro Loupe jsou vypnutá v nastavení Androidu.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nedovoluje aplikaci Loupe zobrazovat oznámení. Povolte je v nastavení.';
  }

  @override
  String get settingsNewMailHeader => 'Nová pošta';

  @override
  String get settingsNewMailFooterDemo =>
      'Ukázková pošta na pozadí nepřichází. Odešlete zkušební oznámení a uvidíte, jak nová pošta vypadá.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe kontroluje novou poštu na pozadí, když to iOS dovolí, což u aplikací, které neotvíráte často, může být i s odstupem několika hodin. Upozorní vás na nové zprávy v doručené poště a na zprávy od VIP v jakékoli složce.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe kontroluje novou poštu zhruba každých 15 minut, když to Android dovolí. Upozorní vás na nové zprávy v doručené poště a na zprávy od VIP v jakékoli složce.';

  @override
  String get settingsNoAccounts => 'Žádné účty';

  @override
  String get settingsVipOnly => 'Jen VIP';

  @override
  String get settingsVipOnlyDetail => 'Jen zprávy od vašich VIP';

  @override
  String get settingsHideContent => 'Skrýt obsah';

  @override
  String get settingsHideContentFooterOn => 'Oznámení uvádějí jen „Nová zpráva od“ a účet, ne kdo psal ani o čem.';

  @override
  String get settingsHideContentFooterOff =>
      '„Skrýt obsah“ nezobrazí odesílatele, předmět ani náhled na zamčené obrazovce a v oznámeních.';

  @override
  String get settingsBackgroundAppRefresh => 'Aktualizace na pozadí';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nová pošta přichází na pozadí jen tehdy, když je v Nastavení pro Loupe zapnutá Aktualizace na pozadí. iOS nedokáže udržet otevřené spojení s vaší doručenou poštou, takže okamžité doručování není k dispozici.';

  @override
  String get settingsInstantDelivery => 'Okamžité doručování';

  @override
  String get settingsInstantDeliveryFooter =>
      'Okamžité doručování (experimentální) udržuje otevřené spojení s vaší doručenou poštou, takže nová pošta dorazí během několika sekund. Zobrazuje tiché oznámení „Sledování nové pošty“ a spotřebuje víc baterie.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android může okamžité doručování zastavit, aby šetřil baterii. Aby běželo dál, povolte aplikaci Loupe používat baterii bez omezení.';

  @override
  String get settingsExperimental => 'Experimentální';

  @override
  String get settingsComingSoon => 'Již brzy';

  @override
  String get settingsAllowUnrestrictedBattery => 'Povolit neomezené využití baterie';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push umožňuje, aby nová pošta okamžitě probudila Loupe, pokud to vaše poštovní služba podporuje. Push zprávy jdou přes službu push od Googlu a neobsahují žádnou poštu, jen „zkontroluj teď“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Tento telefon nemůže přijímat push zprávy: potřebují služby Google Play a připojení k síti. Loupe stále kontroluje poštu zhruba každých 15 minut.';

  @override
  String get settingsCopyPushToken => 'Kopírovat token push';

  @override
  String get settingsPushTokenCopied => 'Token push zkopírován';

  @override
  String get settingsSendTestNotification => 'Odeslat zkušební oznámení';

  @override
  String get settingsAppIconBadge => 'Odznak na ikoně';

  @override
  String get settingsBadgeNote => 'Odznak se aktualizuje pokaždé, když Loupe kontroluje poštu, i na pozadí.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Domovská obrazovka tohoto telefonu nezobrazuje čísla na ikonách aplikací. Odznak se aktualizuje pokaždé, když Loupe kontroluje poštu, i na pozadí.';

  @override
  String get settingsTestNotificationBody => 'Takto vypadají oznámení o nové poště.';

  @override
  String get settingsAccountRemoved => 'Tento účet byl odebrán.';

  @override
  String get settingsAccountHeader => 'Účet';

  @override
  String get settingsAccountDescription => 'Popis';

  @override
  String get settingsAccountDescriptionHint => 'Práce, osobní…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Barva';

  @override
  String get settingsColourFooter => 'Označuje zprávy tohoto účtu ve Všech doručených.';

  @override
  String settingsColourNumber(int number) {
    return 'Barva $number';
  }

  @override
  String get settingsSendingHeader => 'Odesílání';

  @override
  String get settingsSendingFooter =>
      'Každá identita má vlastní podpis. Odpovědi odcházejí z adresy, na kterou zpráva přišla.';

  @override
  String get settingsFoldersHeader => 'Složky';

  @override
  String get settingsFoldersFooter =>
      'Loupe zobrazuje a synchronizuje složky, které odebíráte, stejně jako Thunderbird. Doručená pošta, Koncepty, Odeslané, Spam, Koš a Archiv se zobrazují vždy.';

  @override
  String get settingsShowAllFolders => 'Zobrazovat všechny složky';

  @override
  String get settingsIncoming => 'Příchozí';

  @override
  String get settingsOutgoing => 'Odchozí';

  @override
  String get settingsConnectionNotEncrypted => 'Nešifrováno';

  @override
  String get settingsSignIn => 'Přihlášení';

  @override
  String get settingsSignInExpired => 'Vypršelo';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider už pro tento účet nepřijímá přihlášení z Loupe, takže se jeho pošta nesynchronizuje. Opravíte to novým přihlášením.';
  }

  @override
  String get settingsSignInAgain => 'Znovu se přihlásit';

  @override
  String get settingsSigningIn => 'Přihlašování…';

  @override
  String get settingsRemoveAccount => 'Odebrat účet';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Odebrat „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Jeho pošta a nastavení se z tohoto telefonu odeberou. Na serveru se nic nesmaže.';

  @override
  String get settingsManageFolders => 'Spravovat složky';

  @override
  String get settingsNoFolders => 'Zatím žádné složky.';

  @override
  String get settingsManageFoldersFooter =>
      'Odebírané složky se zobrazují na obrazovce Schránky a synchronizují se na pozadí. Ostatní poštovní aplikace se stejným účtem se obvykle těmito odběry řídí také.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Uchovává vaše schránky Smart Mailbox pro vaše další zařízení. Na obrazovce Schránky je skrytá.';

  @override
  String get settingsFolderAlwaysShown => 'Vždy zobrazena';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Odebírat $folder';
  }

  @override
  String get settingsIdentities => 'Identity';

  @override
  String get settingsIdentitiesFooterReorder => 'První identita je výchozí pro nové zprávy. Přetažením změníte pořadí.';

  @override
  String get settingsIdentitiesFooterSingle => 'Výchozí identita pro nové zprávy.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odpověď odchází z identity, na kterou zpráva přišla.';

  @override
  String get settingsIdentityDefault => 'Výchozí';

  @override
  String settingsIdentityReorder(String email) {
    return 'Změnit pořadí: $email';
  }

  @override
  String get settingsAddIdentity => 'Přidat identitu';

  @override
  String get settingsNewIdentity => 'Nová identita';

  @override
  String get settingsIdentity => 'Identita';

  @override
  String get settingsIdentityNameHint => 'Vaše jméno';

  @override
  String get settingsReplyTo => 'Odpovědět na';

  @override
  String get settingsSignature => 'Podpis';

  @override
  String get settingsSignatureFooter => 'Přidává se pod „-- “ ve zprávách z této identity.';

  @override
  String get settingsNoSignature => 'Bez podpisu';

  @override
  String get settingsCopyToMyself => 'Kopie sobě';

  @override
  String get settingsCopyToMyselfFooter => 'Přidává se ke každé zprávě z této identity.';

  @override
  String get settingsCc => 'Kopie';

  @override
  String get settingsBcc => 'Skrytá kopie';

  @override
  String get settingsReplyPatterns => 'Použít pro odpovědi na';

  @override
  String get settingsReplyPatternsFooter =>
      'Odpovědi na zprávy poslané na tyto adresy odcházejí z této identity. * zastupuje cokoli: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adresa nebo vzor, ve kterém * zastupuje cokoli.';

  @override
  String get settingsAddReplyPattern => 'Přidat adresu nebo vzor';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Odebrat $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Neplatný vzor';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ není adresa ani vzor jako *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Chybí adresa';

  @override
  String get settingsIdentityNoAddressMessage => 'Zadejte e-mailovou adresu, ze které se má odesílat.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Neplatná adresa';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Odpovědět na: „$address“ není platná e-mailová adresa.',
      'cc': 'Kopie: „$address“ není platná e-mailová adresa.',
      'bcc': 'Skrytá kopie: „$address“ není platná e-mailová adresa.',
      'other': '„$address“ není platná e-mailová adresa.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Uložit identitu';

  @override
  String get settingsDiscardChanges => 'Zahodit změny';

  @override
  String get settingsDeleteIdentity => 'Smazat identitu';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Smazat „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Zprávy, které z ní už byly odeslány, zůstanou beze změny.';

  @override
  String get settingsLastIdentityFooter => 'Účet potřebuje alespoň jednu identitu.';

  @override
  String get rulesTitle => 'Pravidla';

  @override
  String get rulesNewRule => 'Nové pravidlo';

  @override
  String get rulesLoadError => 'Pravidla se nepodařilo načíst.';

  @override
  String get rulesEmptyTitle => 'Žádná pravidla';

  @override
  String get rulesEmptyText =>
      'Pravidla za vás třídí novou poštu do složek, přidávají štítky a vlajky. Vytvořte pravidlo tlačítkem nahoře nebo z hledání pomocí „Vytvořit z toho pravidlo“.';

  @override
  String get rulesListFooter =>
      'Pravidla se na novou poštu v Doručené poště uplatňují shora dolů. Pravidlo přesunete dlouhým podržením.';

  @override
  String get rulesChangeError => 'Pravidlo se nepodařilo změnit';

  @override
  String get rulesConditionEveryMessage => 'Každá zpráva';

  @override
  String rulesMoveRule(String rule) {
    return 'Přesunout $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule zapnuto';
  }

  @override
  String get rulesServerRulesHeader => 'Pravidla na serveru';

  @override
  String get rulesServerRulesFooter =>
      'Pravidla na serveru běží na poštovním serveru, když pošta přichází, i když je tento telefon vypnutý. Ukládají se ve skriptu Sieve s názvem „loupe“.';

  @override
  String get rulesStatusUnknown => 'Neznámý';

  @override
  String get rulesStatusError => 'Server se nepodařilo dotázat.';

  @override
  String get rulesStatusChecking => 'Kontrola…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Spouštěno ze skriptu „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktivní skript je „$script“. Klepnutím zajistíte, aby spouštěl i pravidla Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na serveru není aktivní žádný skript. Uložením pravidla na serveru se zapne skript Loupe.';

  @override
  String get rulesStatusUnavailable => 'Není k dispozici';

  @override
  String get rulesStatusNoSieve => 'Server tohoto účtu nenabízí Sieve (ManageSieve ani JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Přesunout do $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Přesunout do složky';

  @override
  String rulesActionTag(String tag) {
    return 'Přidat štítek $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Odebrat štítek $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Ponechat v Doručené poště';

  @override
  String rulesActionForward(String address) {
    return 'Přeposlat na $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Přeposlat na $address, bez kopie';
  }

  @override
  String get rulesActionStop => 'Zastavit';

  @override
  String get rulesNoActions => 'Zatím nic nedělá';

  @override
  String get rulesLocationDevice => 'Zařízení';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Toto zařízení';

  @override
  String get rulesNewRuleTitle => 'Nové pravidlo';

  @override
  String get rulesEditRuleTitle => 'Upravit pravidlo';

  @override
  String get rulesDefaultNameEveryMessage => 'Každá zpráva';

  @override
  String get rulesConditionHeader => 'Když nová zpráva odpovídá';

  @override
  String get rulesConditionFooter =>
      'Pište stejně jako při hledání: from:, to:, s: (předmět), b: (text), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Účty';

  @override
  String get rulesAllAccounts => 'Všechny účty';

  @override
  String get rulesRemovedAccount => 'Odebraný účet';

  @override
  String get rulesAccountsFooter => 'Pravidlo pro všechny účty platí i pro účty, které přidáte později.';

  @override
  String get rulesActionsHeader => 'Pak';

  @override
  String get rulesForwardingFooter =>
      'Přeposílání pošle každou odpovídající zprávu na jinou adresu hned, jak přijde, i když je tento telefon vypnutý. Někteří poskytovatelé omezují, kolik pošty lze přeposlat.';

  @override
  String get rulesForwardingHiddenFooter => 'Přeposílání funguje jen v pravidlech na serveru, proto tu chybí.';

  @override
  String rulesRemoveAction(String action) {
    return 'Odebrat $action';
  }

  @override
  String get rulesAddAction => 'Přidat akci';

  @override
  String get rulesAddMove => 'Přesunout do složky…';

  @override
  String get rulesAddTagMenu => 'Přidat štítek…';

  @override
  String get rulesRemoveTagMenu => 'Odebrat štítek…';

  @override
  String get rulesAddForward => 'Přeposlat na…';

  @override
  String get rulesStopProcessing => 'Nezpracovávat další pravidla';

  @override
  String get rulesRunOnHeader => 'Kde spouštět';

  @override
  String get rulesRunOnDeviceFooter =>
      'Toto zařízení uplatní pravidlo na novou poštu v Doručené poště pokaždé, když Loupe kontroluje poštu.';

  @override
  String get rulesRunOnServerFooter =>
      'Poštovní server uplatňuje pravidlo, když pošta přichází, i když je tento telefon vypnutý. Vyžaduje Sieve přes ManageSieve (Dovecot, mailcow) nebo JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Použít na existující zprávy…';

  @override
  String get rulesDeleteRule => 'Smazat pravidlo';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Smazat „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Složka v kterém účtu?';

  @override
  String get rulesMoveAccountMessage => 'Pošta z ostatních účtů půjde do složky se stejným názvem v daném účtu.';

  @override
  String get rulesAddTag => 'Přidat štítek';

  @override
  String get rulesRemoveTag => 'Odebrat štítek';

  @override
  String get rulesForwardTo => 'Přeposlat na';

  @override
  String get rulesForwardToMessage =>
      'Server bude každou odpovídající zprávu přeposílat na tuto adresu, i když je tento telefon vypnutý. Použijte adresu, která je vaše nebo které důvěřujete.';

  @override
  String get rulesNotAnAddressTitle => 'Není to e-mailová adresa';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ není adresa, na kterou lze přeposílat.';
  }

  @override
  String get rulesKeepCopyTitle => 'Ponechat kopii zde?';

  @override
  String get rulesKeepCopy => 'Ponechat kopii';

  @override
  String get rulesDontKeepCopy => 'Neponechávat kopii';

  @override
  String get rulesCheckCondition => 'Zkontrolujte podmínku';

  @override
  String get rulesChooseActionTitle => 'Vyberte akci';

  @override
  String get rulesChooseActionMessage => 'Přidejte, co má pravidlo dělat s odpovídajícími zprávami.';

  @override
  String get rulesSaveError => 'Pravidlo se nepodařilo uložit';

  @override
  String get rulesSaveServerError => 'Pravidlo na serveru se nepodařilo uložit';

  @override
  String get rulesRunOnDeviceInstead => 'Spouštět raději v tomto zařízení';

  @override
  String get rulesNothingToApplyTitle => 'Není co použít';

  @override
  String get rulesNothingToApplyMessage => 'Nejdřív pravidlu zadejte funkční podmínku a akci.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Použít „$rule“ na zprávy v…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Doručená pošta';

  @override
  String get rulesApplyScopeAll => 'Všechny schránky';

  @override
  String get rulesFindingMessages => 'Vyhledávání zpráv…';

  @override
  String get rulesSearchError => 'Hledání se nezdařilo';

  @override
  String get rulesSearchErrorUnknown => 'Něco se pokazilo.';

  @override
  String get rulesNoMatchesTitle => 'Žádné odpovídající zprávy';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nic tam neodpovídá „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Použít „$rule“ na $countString zpráv?',
      few: 'Použít „$rule“ na $countString zprávy?',
      one: 'Použít „$rule“ na $countString zprávu?',
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
      other: 'Použít na $countString zpráv',
      few: 'Použít na $countString zprávy',
      one: 'Použít na $countString zprávu',
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
      other: '„$rule“ použito na $countString zpráv',
      few: '„$rule“ použito na $countString zprávy',
      one: '„$rule“ použito na $countString zprávu',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Zjišťování, co server umí…';

  @override
  String get rulesServerUnreachable => 'Server se nepodařilo kontaktovat.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nelze spustit na serveru: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nelze spustit na serveru účtu $account: $problem';
  }

  @override
  String get rulesShowScript => 'Zobrazit skript';

  @override
  String get rulesHideScript => 'Skrýt skript';

  @override
  String get rulesMatchingHeader => 'Odpovídající zprávy';

  @override
  String get rulesMatchingHeaderLoading => 'Odpovídající zprávy…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString odpovídajících zpráv',
      few: '$countString odpovídající zprávy',
      one: '$countString odpovídající zpráva',
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
      other: '$countString+ odpovídajících zpráv',
      few: '$countString+ odpovídajících zpráv',
      one: '$countString+ odpovídajících zpráv',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Z posledních 30 dní. Samotné pravidlo působí jen na novou poštu, pokud ho nepoužijete na existující zprávy.';

  @override
  String rulesConditionError(String error) {
    return 'Podmínka obsahuje chybu: $error';
  }

  @override
  String get rulesPreviewNoSender => '(bez odesílatele)';

  @override
  String get rulesPreviewNoSubject => '(bez předmětu)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'a $countString dalších',
      few: 'a $countString další',
      one: 'a $countString další',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nic z posledních 30 dní.';

  @override
  String get rulesIncludeTitle => 'Zapnout pravidla na serveru';

  @override
  String get rulesIncludeLeaveOff => 'Ponechat vypnuté';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Server už pro účet $account spouští pravidla Loupe.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ je aktivní skript na serveru účtu $account, takže server spouští ten, a ne pravidla Loupe. Loupe ho nenahradí. Může do něj přidat tyto řádky a server pak spustí pravidla Loupe po vlastních pravidlech skriptu:';
  }

  @override
  String get rulesShowWholeScript => 'Zobrazit celý skript';

  @override
  String get rulesHideWholeScript => 'Skrýt celý skript';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nic jiného se ve skriptu „$script“ nezmění. Pokud se jeho filtry později upraví ve webmailu, webmail ho může přepsat bez těchto řádků; Loupe pak znovu ukáže pravidla na serveru jako vypnutá.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Přidat do „$script“';
  }

  @override
  String get subscriptionsTitle => 'Odběry';

  @override
  String get subscriptionsNewsletters => 'Newslettery';

  @override
  String get subscriptionsDiscussions => 'Diskuse';

  @override
  String get subscriptionsFilter => 'Filtr';

  @override
  String get subscriptionsFilterNeverRead => 'Nikdy nečtené';

  @override
  String get subscriptionsFilterRarelyRead => 'Zřídka čtené';

  @override
  String get subscriptionsFilterAll => 'Vše';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Odběry se nepodařilo spočítat';

  @override
  String get subscriptionsNoMatches => 'Žádné shody';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Žádný newsletter se nejmenuje „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Žádná konference se nejmenuje „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Žádné newslettery';

  @override
  String get subscriptionsNoNewslettersDetail => 'Newslettery a další hromadná pošta se tu objeví, jakmile dorazí.';

  @override
  String get subscriptionsNothingNeverRead => 'Nic nikdy nečteného';

  @override
  String get subscriptionsNothingRarelyRead => 'Nic zřídka čteného';

  @override
  String get subscriptionsNothingFilteredDetail => 'Ze všeho, co dostáváte, něco čtete.';

  @override
  String get subscriptionsNoDiscussions => 'Žádné diskuse';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'E-mailové konference, do kterých můžete psát, se tu objeví, jakmile z nich přijde pošta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Konference, do kterých píše víc lidí. Podržením konferenci připnete do schránek, budete ji číst jako prostý text, nebo ji přesunete do newsletterů.';

  @override
  String get subscriptionsPrivacyNote =>
      'Spočítáno v tomto telefonu ze stažené pošty; nic se kvůli tomu nikam neodesílá. Loupe kontaktuje odesílatele, jen když klepnete na Odhlásit odběr: odhlášení jedním klepnutím pošle jen „List-Unsubscribe=One-Click“ na adresu, kterou odesílatel uvedl, bez cookies a čehokoli dalšího o vás, a nikdy nenačítá jeho stránky ani obrázky.';

  @override
  String get subscriptionsVolumeNone => 'Poslední dobou nic';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / měs.';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / měs.';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'přečteno $percent';
  }

  @override
  String get subscriptionsStillSending => 'Stále posílá';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Odběr zrušen $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Stránka pro odhlášení otevřena $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Jedním klepnutím · kontaktuje $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-mailem na $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Na webu $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Odhlásit odběr';

  @override
  String get subscriptionsUnsubscribeAgain => 'Znovu odhlásit odběr';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivovat $countString v Doručené poště',
      few: 'Archivovat $countString v Doručené poště',
      one: 'Archivovat $countString v Doručené poště',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Vytvořit pravidlo…';

  @override
  String get subscriptionsCreateRuleDetail => 'Přesouvat nebo archivovat budoucí poštu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Považovat za diskusi';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Konference, do které lidé píšou: číst jako fórum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Považovat za newsletter';

  @override
  String get subscriptionsBlockSender => 'Zablokovat odesílatele';

  @override
  String get subscriptionsBlock => 'Zablokovat';

  @override
  String get subscriptionsBlocked => 'Zablokováno';

  @override
  String get subscriptionsBlockedDetail => 'Nová pošta jde do spamu';

  @override
  String get subscriptionsPin => 'Připnout do schránek';

  @override
  String get subscriptionsUnpin => 'Odepnout ze schránek';

  @override
  String get subscriptionsOpenDefaultView => 'Otevírat ve výchozím zobrazení';

  @override
  String get subscriptionsOpenPlainText => 'Otevírat jako prostý text (mono)';

  @override
  String get subscriptionsPinned => 'Připnuto';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString nepřečtených',
      few: '$countString nepřečtené',
      one: '$countString nepřečtená',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Od tohoto odesílatele teď není žádná pošta.';

  @override
  String get subscriptionsLatestMessages => 'NEJNOVĚJŠÍ ZPRÁVY';

  @override
  String get subscriptionsMail => 'Pošta';

  @override
  String get subscriptionsNoneIn90Days => 'Nic za 90 dní';

  @override
  String get subscriptionsRead => 'Přečteno';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString z $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Naposledy přijato';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Složky', few: 'Složky', one: 'Složka');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Stále posílá';

  @override
  String get subscriptionsUnsubscribedTitle => 'Odběr zrušen';

  @override
  String subscriptionsSince(String date) {
    return 'od $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'stránka otevřena $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender neuvádí, jak odhlásit odběr.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender neuvádí, jak odhlásit odběr. Místo toho ho můžete zablokovat.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Odhlašování odběru od $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Odběr od $sender zrušen.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Odběr se nepodařilo zrušit: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Odběr se nepodařilo zrušit automaticky';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Odeslat e-mail s odhlášením';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Otevřít $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Otevřít $site?';
  }

  @override
  String get subscriptionsOpen => 'Otevřít';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender odhlašuje odběr na svém webu. Stránka se otevře v prohlížeči Loupe; dokončete to tam.';
  }

  @override
  String get subscriptionsWebInsecure => 'Spojení s tímto webem není šifrované.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Pozor: tato adresa napodobuje $site podobně vypadajícími písmeny.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Pozor: tato adresa napodobuje jiný web podobně vypadajícími písmeny.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site se nepodařilo otevřít.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe si poznamená dnešní datum a dá vám vědět, pokud $sender bude psát dál.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Odhlásit odběr od $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kvůli odhlášení kontaktuje $site.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Je to jediný případ, kdy Loupe kontaktuje web odesílatele. Pošle jen „List-Unsubscribe=One-Click“ na adresu, kterou $sender uvedl, bez cookies a čehokoli dalšího o vás, a stránku nenačítá.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Odkaz pro odhlášení není zabezpečená adresa na internetu.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site neodpověděl včas.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site se nepodařilo kontaktovat.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site přesměroval požadavek na jinou stránku a Loupe přesměrování nesleduje.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site požadavek odmítl (chyba $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Není žádný účet, ze kterého by šlo e-mail s odhlášením odeslat.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe odešle e-mail na $to z adresy $from s předmětem „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-mail s odhlášením odeslán na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Zablokovat $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nová pošta z této konference bude chodit do spamu. Můžete to změnit v Nastavení › Pravidla.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nová pošta z $address bude chodit do spamu. Můžete to změnit v Nastavení › Pravidla.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Zablokováno: $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Přesunout $count do spamu',
      few: 'Přesunout $count do spamu',
      one: 'Přesunout $count do spamu',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokovat $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender je teď v newsletterech.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender je teď v diskusích.';
  }

  @override
  String get appLiveGateTitle => 'Vaše účty se nepodařilo otevřít';

  @override
  String get appLiveGateUnavailableBuild => 'Skutečné účty zatím v tomto sestavení nejsou k dispozici.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nedokázala přečíst klíč, který chrání vaši poštu v tomto telefonu. Často jde o dočasný problém: zkuste to znovu nebo telefon restartujte.';

  @override
  String get appLiveGateKeyMissing =>
      'Klíč, který chrání vaši poštu v tomto telefonu, zmizel, což se může stát po obnovení zálohy. Vaše pošta je stále na serveru.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Poštovní databázi v tomto telefonu nelze přečíst: je poškozená nebo se změnil její klíč. Vaše pošta je stále na serveru.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Při otevírání vašich účtů se něco pokazilo ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Tím smažete své účty a poštu uloženou v tomto telefonu, včetně zpráv čekajících ve složce K odeslání. Pošty na vašich serverech se to netýká; účty pak přidejte znovu.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Smazat a začít znovu';

  @override
  String get appLiveGateUseDemo => 'Použít ukázkovou poštu';

  @override
  String get appLiveGateReset => 'Resetovat poštu v tomto telefonu…';

  @override
  String get attachmentsUntitled => 'Příloha';

  @override
  String get attachmentsUntitledFile => 'Bez názvu';

  @override
  String get attachmentsOpenIn => 'Otevřít v…';

  @override
  String get attachmentsSaveToFiles => 'Uložit do souborů';

  @override
  String get attachmentsShareMenu => 'Sdílet…';

  @override
  String get attachmentsDownloadError => 'Přílohu se nepodařilo stáhnout. Zkontrolujte připojení a zkuste to znovu.';

  @override
  String get attachmentsShareError => 'Přílohu se nepodařilo sdílet.';

  @override
  String attachmentsNoApp(String type) {
    return 'V tomto zařízení není aplikace, která by tento soubor otevřela ($type). Zkuste raději Sdílet.';
  }

  @override
  String get attachmentsOpenInError => 'Přílohu se nepodařilo otevřít v jiné aplikaci.';

  @override
  String attachmentsSaved(String name) {
    return 'Uloženo „$name“';
  }

  @override
  String get attachmentsSaveError => 'Přílohu se nepodařilo uložit.';

  @override
  String get attachmentsGone => 'Tato příloha už není k dispozici.';

  @override
  String get attachmentsDownloadFailed => 'Přílohu se nepodařilo stáhnout.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stran',
      few: '$count strany',
      one: '$count strana',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size přes mobilní data';
  }

  @override
  String get attachmentsLargeDownload => 'Tato příloha je velká. Stáhněte ji teď, nebo později přes Wi-Fi.';

  @override
  String get attachmentsDownload => 'Stáhnout';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Stahování $size…';
  }

  @override
  String get attachmentsDownloading => 'Stahování…';

  @override
  String get attachmentsTooLarge => 'Příliš velké pro náhled zde.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Zobrazeno prvních $shown z $total. Celý obsah získáte zkopírováním, sdílením nebo uložením.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Toto PDF zde nelze zobrazit (může být chráněno heslem).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page z $count';
  }

  @override
  String get attachmentsModeTable => 'Tabulka';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Zpráva';

  @override
  String get attachmentsModeSource => 'Zdroj';

  @override
  String get attachmentsDontWrap => 'Nezalamovat řádky';

  @override
  String get attachmentsWrap => 'Zalamovat řádky';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines řádků',
      few: '$lines řádky',
      one: '$lines řádek',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopírovat vše';

  @override
  String get attachmentsCopied => 'Zkopírováno';

  @override
  String get attachmentsImageUnavailable => 'Tento obrázek zde nelze zobrazit. Zkuste „Otevřít v…“.';

  @override
  String get attachmentsEmlNoSubject => '(Bez předmětu)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Komu';

  @override
  String get attachmentsEmlCc => 'Kopie';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Tato zpráva neobsahuje text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Přílohy: $names',
      few: 'Přílohy: $names',
      one: 'Příloha: $names',
    );
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
      other: 'A ještě $count událostí',
      few: 'A ještě $count události',
      one: 'A ještě $count událost',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Obrázek';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Obrázek $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Hodnoty oddělené tabulátory';

  @override
  String get attachmentsTypeCsv => 'Tabulka CSV';

  @override
  String get attachmentsTypeCalendar => 'Událost kalendáře';

  @override
  String get attachmentsTypeEmail => 'E-mailová zpráva';

  @override
  String get attachmentsTypeContact => 'Vizitka';

  @override
  String get attachmentsTypeLog => 'Soubor protokolu';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'Archiv ZIP';

  @override
  String get attachmentsTypeArchive => 'Archiv';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Sešit Excel';

  @override
  String get attachmentsTypePowerPoint => 'Prezentace PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Webová stránka';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Zvuk';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Soubor $extension';
  }

  @override
  String get attachmentsTypeFile => 'Soubor';

  @override
  String get calendarUntitledEvent => 'Událost';

  @override
  String get calendarAllDay => 'Celý den';

  @override
  String calendarYourTime(String time) {
    return '$time vašeho času';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Připojit se: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name přijímá pozvánku: $details',
      'tentative': '$name předběžně přijímá pozvánku: $details',
      'declined': '$name odmítá pozvánku: $details',
      'delegated': '$name deleguje pozvánku: $details',
      'other': '$name neodpovídá na pozvánku: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name přijímá pozvánku',
      'tentative': '$name předběžně přijímá pozvánku',
      'declined': '$name odmítá pozvánku',
      'delegated': '$name deleguje pozvánku',
      'other': '$name neodpovídá na pozvánku',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Připojit';

  @override
  String get calendarOnlineMeeting => 'Online schůzka';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Schůzka $provider';
  }

  @override
  String get calendarOrganizerYou => 'Vy';

  @override
  String get calendarOrganizerLabel => 'organizátor';

  @override
  String get calendarStatusAccepted => 'Přijato';

  @override
  String get calendarStatusMaybe => 'Možná';

  @override
  String get calendarStatusDeclined => 'Odmítnuto';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name přijímá pozvánku',
      'tentative': '$name předběžně přijímá pozvánku',
      'declined': '$name odmítá pozvánku',
      'delegated': '$name deleguje pozvánku',
      'other': '$name neodpovídá na pozvánku',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name přijímá pozvánku:',
      'tentative': '$name předběžně přijímá pozvánku:',
      'declined': '$name odmítá pozvánku:',
      'delegated': '$name deleguje pozvánku:',
      'other': '$name neodpovídá na pozvánku:',
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
  String get calendarDeclineCounter => 'Organizátor ponechal původní čas';

  @override
  String calendarRefresh(String name) {
    return '$name žádá o nejnovější verzi';
  }

  @override
  String get calendarRefreshUnknown => 'Účastník žádá o nejnovější verzi';

  @override
  String get calendarCancelled => 'Zrušeno';

  @override
  String get calendarCancelledByOrganizer => 'Organizátor tuto událost zrušil.';

  @override
  String get calendarCancelledLater => 'Tato událost byla později zrušena.';

  @override
  String get calendarOutdated => 'Zastaralé';

  @override
  String get calendarOutdatedDetail => 'Tato pozvánka byla později aktualizována; platí ta novější.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Místo odebráno (bylo: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Místo odebráno (nebylo uvedeno)';

  @override
  String calendarLocationChanged(String location) {
    return 'Místo změněno na $location';
  }

  @override
  String get calendarNewTitle => 'Nový název';

  @override
  String get calendarRepeatChanged => 'Opakování se změnilo';

  @override
  String get calendarUpdated => 'Aktualizováno';

  @override
  String get calendarUpdatedInvitation => 'Aktualizovaná pozvánka';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Čas změněn z $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Neznámé časové pásmo „$zone“: časy tak, jak jsou uvedeny';
  }

  @override
  String calendarNext(String when) {
    return 'Další: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hostů',
      few: '$count hosté',
      one: '$count host',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'přijato: $count',
      few: 'přijato: $count',
      one: 'přijato: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'možná: $count',
      few: 'možná: $count',
      one: 'možná: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'odmítnuto: $count',
      few: 'odmítnuto: $count',
      one: 'odmítnuto: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (vy)';
  }

  @override
  String get calendarAttendeeOptional => 'nepovinně';

  @override
  String get calendarAttendeeRoom => 'místnost';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Předchozí verzi jste přijali.',
      'tentative': 'Předchozí verzi jste předběžně přijali.',
      'declined': 'Předchozí verzi jste odmítli.',
      'delegated': 'Předchozí verzi jste delegovali.',
      'other': 'Na předchozí verzi jste neodpověděli.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Přijmout';

  @override
  String get calendarMaybe => 'Možná';

  @override
  String get calendarDecline => 'Odmítnout';

  @override
  String get calendarCommentHint => 'Komentář pro organizátora (nepovinné)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Vaše odpověď půjde z adresy $address organizátorovi $organizer.';
  }

  @override
  String get calendarAddComment => 'Přidat komentář';

  @override
  String get calendarAddToCalendar => 'Přidat do kalendáře';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A ještě $count událostí v souboru',
      few: 'A ještě $count události v souboru',
      one: 'A ještě $count událost v souboru',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Není tu žádná aplikace kalendáře, do které by šlo událost přidat.';

  @override
  String get calendarCantOpenCalendar => 'Kalendář se nepodařilo otevřít.';

  @override
  String get calendarCantOpenLink => 'Odkaz se nepodařilo otevřít.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Připojit se ke schůzce $provider?';
  }

  @override
  String get calendarJoinTitle => 'Připojit se ke schůzce?';

  @override
  String calendarJoinOpens(String host) {
    return 'Otevře $host v prohlížeči.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Pozor: tato adresa napodobuje $site podobně vypadajícími písmeny.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Pozor: tato adresa napodobuje jiný web podobně vypadajícími písmeny.';

  @override
  String calendarJoinOpen(String host) {
    return 'Otevřít $host';
  }

  @override
  String get calendarNoOrganizer => 'Tato pozvánka nemá organizátora, kterému by šlo odpovědět.';

  @override
  String get calendarNoAccount => 'Není žádný účet, ze kterého by šlo odpovědět.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Přijato', 'tentative': 'Možná', 'other': 'Odmítnuto'});
    return '$_temp0 · odesílání odpovědi pro $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Přijato', 'tentative': 'Možná', 'other': 'Odmítnuto'});
    return '$_temp0 · odpověď odeslána';
  }

  @override
  String get calendarReplyAlreadySent => 'Odpověď už byla odeslána.';

  @override
  String get calendarReplyNotSent => 'Odpověď nebyla odeslána.';

  @override
  String get dataSmimeNeedsDevice =>
      'Váš certifikát S/MIME je v tomto zařízení: otevřete Loupe, abyste tuto zprávu podepsali a odeslali.';

  @override
  String dataSigningFailed(String error) {
    return 'Podepsání selhalo: $error';
  }

  @override
  String get keyboardShortcuts => 'Klávesové zkratky';

  @override
  String get keyboardGroupGeneral => 'Obecné';

  @override
  String get keyboardGroupMessages => 'Zprávy';

  @override
  String get keyboardGroupCompose => 'Psaní';

  @override
  String get keyboardCommandPalette => 'Paleta příkazů';

  @override
  String get keyboardBackClose => 'Zpět, zavřít';

  @override
  String get keyboardNextMessage => 'Další zpráva';

  @override
  String get keyboardPreviousMessage => 'Předchozí zpráva';

  @override
  String get keyboardOpenMessage => 'Otevřít zprávu';

  @override
  String get keyboardMoveToTrash => 'Přesunout do koše';

  @override
  String get keyboardToggleRead => 'Označit jako přečtené nebo nepřečtené';

  @override
  String get keyboardToggleFlag => 'Označit vlajkou nebo zrušit vlajku';

  @override
  String get keyboardCloseDraft => 'Zavřít (uložit nebo smazat koncept)';

  @override
  String get keyboardOr => 'nebo';

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
  String get mailingListsMuted => 'Vlákno ztlumeno. Nové zprávy v něm přijdou jako přečtené.';

  @override
  String get mailingListsUnmuted => 'Ztlumení vlákna zrušeno.';

  @override
  String get mailingListsMuteThread => 'Ztlumit vlákno';

  @override
  String get mailingListsUnmuteThread => 'Zrušit ztlumení vlákna';

  @override
  String get mailingListsPin => 'Připnout do schránek';

  @override
  String get mailingListsUnpin => 'Odepnout ze schránek';

  @override
  String get mailingListsDefaultView => 'Otevírat ve výchozím zobrazení';

  @override
  String get mailingListsPlainText => 'Otevírat jako prostý text (mono)';

  @override
  String get mailingListsShowMuted => 'Zobrazit ztlumená vlákna';

  @override
  String get mailingListsHideMuted => 'Skrýt ztlumená vlákna';

  @override
  String get mailingListsTreatAsNewsletter => 'Považovat za newsletter';

  @override
  String get mailingListsOptions => 'Možnosti konference';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted nepřečtených',
      few: '$formatted nepřečtené',
      one: '$formatted nepřečtená',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nová zpráva do konference';

  @override
  String get mailingListsRowUnread => 'Nepřečtené';

  @override
  String get mailingListsRowMuted => 'Ztlumeno';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odpovědí',
      few: '$count odpovědi',
      one: '$count odpověď',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Žádná vlákna';

  @override
  String get mailingListsMutedHidden => 'Ztlumená vlákna jsou skrytá.';

  @override
  String get mailingListsTechnicalTitle => 'Technické konference';

  @override
  String get mailingListsTechnicalEmpty => 'E-mailové konference se tu objeví, jakmile z nich přijde pošta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Zprávy z těchto konferencí se otevírají jako prostý text neproporcionálním písmem a patche se zobrazují jako diffy. Tlačítkem Aa můžete kteroukoli zprávu přepnout i nadále.';

  @override
  String get paletteMoveToMailbox => 'Přesunout do schránky…';

  @override
  String get paletteMarkAllRead => 'Označit vše jako přečtené';

  @override
  String get paletteExportFolder => 'Exportovat složku…';

  @override
  String get paletteGetNewMail => 'Načíst novou poštu';

  @override
  String get paletteSnoozed => 'Odložené';

  @override
  String get paletteSubscriptions => 'Odběry';

  @override
  String get paletteDiscussions => 'Diskuse';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-mailová konference';

  @override
  String get paletteTag => 'Štítek';

  @override
  String get paletteSwipeActions => 'Akce přejetí';

  @override
  String get paletteNotifications => 'Oznámení';

  @override
  String get paletteRules => 'Pravidla';

  @override
  String get paletteEncryption => 'Koncové šifrování';

  @override
  String get paletteAdvanced => 'Pokročilé';

  @override
  String get paletteAddAccount => 'Přidat účet';

  @override
  String get paletteAccount => 'Účet';

  @override
  String get paletteFolders => 'Složky';

  @override
  String get paletteRecentSearch => 'Nedávné hledání';

  @override
  String paletteSearchMail(String query) {
    return 'Hledat v poště „$query“';
  }

  @override
  String get palettePlaceholder => 'Hledat akce, schránky, nastavení';

  @override
  String get paletteNothingFound => 'Nic nenalezeno';

  @override
  String get searchNewSmartMailbox => 'Nová schránka Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Zobrazuje vše, co odpovídá „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ uloženo do schránek';
  }

  @override
  String get searchMakeRule => 'Vytvořit z toho pravidlo';

  @override
  String get searchSaveSmartMailbox => 'Uložit jako Smart Mailbox';

  @override
  String get searchNegate => 'Negovat';

  @override
  String get searchDontNegate => 'Nenegovat';

  @override
  String get searchAllMailboxes => 'Všechny schránky';

  @override
  String get searchRecent => 'Nedávná hledání';

  @override
  String get searchClear => 'Vymazat';

  @override
  String get searchSuggestions => 'Návrhy';

  @override
  String get searchUnreadMessages => 'Nepřečtené zprávy';

  @override
  String get searchFlaggedMessages => 'Zprávy s vlajkou';

  @override
  String get searchWithAttachments => 'Zprávy s přílohami';

  @override
  String get searchUnrepliedMessages => 'Zprávy bez odpovědi';

  @override
  String get searchTags => 'Štítky';

  @override
  String get searchPeople => 'Lidé';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Od: $name';
  }

  @override
  String get searchSearching => 'Hledání…';

  @override
  String get searchNoResults => 'Žádné výsledky';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted výsledků',
      few: '$formatted výsledky',
      one: '$formatted výsledek',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Nabídka hledání';

  @override
  String searchSearchingAccount(String account) {
    return 'Hledání v účtu $account na serveru…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Hledání v účtu na serveru…';

  @override
  String searchAccountFailed(String account) {
    return 'Účet $account se na serveru nepodařilo prohledat';
  }

  @override
  String get searchUnknownAccountFailed => 'Účet se na serveru nepodařilo prohledat';

  @override
  String searchChip(String term) {
    return '$term. Dvojitým klepnutím upravíte.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ne $term. Dvojitým klepnutím upravíte.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerova schránka: každá zpráva je tu zároveň přečtená i nepřečtená, dokud ji neotevřete.';

  @override
  String searchContradiction(String term) {
    return 'Žádná zpráva nemůže být „$term“ a zároveň nebýt.';
  }

  @override
  String get searchSyncDeviceOnly => 'Jen v tomto zařízení';

  @override
  String searchSyncUnsupported(String account) {
    return 'Jen v tomto zařízení: $account ji neumí uchovávat';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nesynchronizováno: $account má novější formát';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Čeká na synchronizaci s $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synchronizováno s $account';
  }

  @override
  String get searchRename => 'Přejmenovat';

  @override
  String get searchEditSearch => 'Upravit hledání';

  @override
  String get searchDeleteSmartMailbox => 'Smazat schránku Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Přejmenovat schránku Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Tato schránka Smart Mailbox byla smazána.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Schránky Smart Mailbox zůstávají v tomto zařízení.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Schránky Smart Mailbox se uchovávají na vašem poštovním serveru, takže je mají i vaše další zařízení a také Thunderbird s doplňkem Expression Search Reloaded. Ty, které prohledávají všechny účty, jsou uložené v účtu $account; ty pro jednu složku v účtu dané složky.';
  }

  @override
  String get searchSyncVia => 'Synchronizovat přes';

  @override
  String get searchSyncViaFooter => 'Na každém zařízení zvolte stejný účet.';

  @override
  String get searchGmailCantKeep => 'Gmail neumí uchovávat schránky Smart Mailbox';

  @override
  String get searchKeepOnDevice => 'Uchovávat schránky Smart Mailbox jen v tomto zařízení';

  @override
  String get searchOnTheServer => 'Na serveru';

  @override
  String get searchServerFooter =>
      'Metadata serveru (IMAP METADATA) se nezobrazují v žádné poštovní aplikaci. Servery bez nich dostanou složku „Loupe Settings“ s jednou zprávou; Loupe ji na obrazovce Schránky skryje.';

  @override
  String get searchSyncNow => 'Synchronizovat hned';

  @override
  String get searchStateUnsupported => 'Nepodporováno';

  @override
  String get searchStateNewerFormat => 'Novější formát';

  @override
  String get searchStateFailed => 'Synchronizace se nezdařila';

  @override
  String get searchStateSyncing => 'Synchronizace…';

  @override
  String get searchStateWaiting => 'Čeká se';

  @override
  String get searchStateMetadata => 'Metadata serveru';

  @override
  String get searchStateFolder => 'Složka Loupe Settings';

  @override
  String get searchStateNothing => 'Nic neuloženo';

  @override
  String get sharedBack => 'Zpět';

  @override
  String get sharedYesterday => 'Včera';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date v $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bajtů',
      few: '$count bajty',
      one: '$count bajt',
    );
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
  String get sharedSyncNoAccounts => 'Žádné účty';

  @override
  String get sharedSyncChecking => 'Kontrola pošty…';

  @override
  String get sharedSyncFailed => 'Poštu se nepodařilo zkontrolovat';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Právě aktualizováno';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Aktualizováno před $minutes minutami',
      few: 'Aktualizováno před $minutes minutami',
      one: 'Aktualizováno před $minutes minutou',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Aktualizováno v $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Aktualizováno $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Všechny doručené';

  @override
  String get sharedMailboxUnread => 'Nepřečtené';

  @override
  String get sharedMailboxFlagged => 'S vlajkou';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Všechny koncepty';

  @override
  String get sharedMailboxAllSent => 'Všechny odeslané';

  @override
  String get sharedMailboxUntitled => 'Schránka';

  @override
  String get sharedTagImportant => 'Důležité';

  @override
  String get sharedTagWork => 'Práce';

  @override
  String get sharedTagPersonal => 'Osobní';

  @override
  String get sharedTagToDo => 'K vyřízení';

  @override
  String get sharedTagLater => 'Později';

  @override
  String get sharedTags => 'Štítky';

  @override
  String get sharedMoveTo => 'Přesunout do…';

  @override
  String get sharedNoRecipients => 'Bez příjemců';

  @override
  String get sharedUnknownSender => 'Neznámý odesílatel';

  @override
  String get sharedOnServer => 'Na serveru';

  @override
  String get sharedAttachment => 'Příloha';

  @override
  String get sharedSnoozedBadge => 'Odloženo';

  @override
  String get sharedRowUnread => 'Nepřečtená';

  @override
  String get sharedRowBackFromSnooze => 'Vrácena z odložených';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'S vlajkou';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivováno $count zpráv',
      few: 'Archivovány $count zprávy',
      one: 'Archivována $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Smazáno $count zpráv',
      few: 'Smazány $count zprávy',
      one: 'Smazána $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do Doručené pošty přesunuto $count zpráv',
      few: 'Do Doručené pošty přesunuty $count zprávy',
      one: 'Do Doručené pošty přesunuta $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do koše přesunuto $count zpráv',
      few: 'Do koše přesunuty $count zprávy',
      one: 'Do koše přesunuta $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do spamu přesunuto $count zpráv',
      few: 'Do spamu přesunuty $count zprávy',
      one: 'Do spamu přesunuta $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do $mailbox přesunuto $count zpráv',
      few: 'Do $mailbox přesunuty $count zprávy',
      one: 'Do $mailbox přesunuta $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do schránky přesunuto $count zpráv',
      few: 'Do schránky přesunuty $count zprávy',
      one: 'Do schránky přesunuta $count zpráva',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odloženo $count zpráv do $time',
      few: 'Odloženy $count zprávy do $time',
      one: 'Odložena $count zpráva do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odloženo do $time jen v tomto zařízení: server neumí ukládat časy odložení.';
  }

  @override
  String get sharedMoveOneAccount => 'Chcete-li zprávy přesunout, vyberte je z jednoho účtu.';

  @override
  String get sharedSnoozeTitle => 'Odložit';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Změnit čas odložení';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trvale smazat $count zpráv?',
      few: 'Trvale smazat $count zprávy?',
      one: 'Trvale smazat tuto zprávu?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Tuto akci nelze vrátit.';

  @override
  String get sharedDeletePermanently => 'Trvale smazat';

  @override
  String get sharedSwipeRead => 'Přečtené';

  @override
  String get sharedSwipeUnread => 'Nepřečtené';

  @override
  String get sharedSwipeInbox => 'Doručené';

  @override
  String get sharedSwipeDelete => 'Smazat';

  @override
  String get sharedTrash => 'Do koše';

  @override
  String get sharedSwipeSnooze => 'Odložit';

  @override
  String get sharedWakeNow => 'Vrátit hned';

  @override
  String get sharedChangeSnoozeTime => 'Změnit čas odložení…';

  @override
  String get sharedSnooze => 'Odložit…';

  @override
  String get sharedTag => 'Štítky…';

  @override
  String get sharedMoveMessage => 'Přesunout zprávu…';

  @override
  String get sharedNotJunk => 'Není spam';

  @override
  String get accountSetupTitle => 'Přidat účet';

  @override
  String get accountSetupTitleDone => 'Účet přidán';

  @override
  String get accountSetupAddressTitle => 'Přidejte poštovní účet';

  @override
  String get accountSetupAddressText => 'Loupe najde nastavení pro většinu poskytovatelů.';

  @override
  String get accountSetupNameHint => 'Vaše jméno';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Pokračovat';

  @override
  String get accountSetupLookingUp => 'Hledání nastavení…';

  @override
  String get accountSetupImport => 'Importovat z Thunderbirdu';

  @override
  String get accountSetupInvalidEmail => 'Zadejte platnou e-mailovou adresu.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nastavení pro $domain se nepodařilo najít. Zadejte je níže.';
  }

  @override
  String get accountSetupCheckServers => 'Zkontrolujte názvy serverů a porty.';

  @override
  String get accountSetupEnterPassword => 'Zadejte heslo.';

  @override
  String get accountSetupConnecting => 'Připojování…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Čekání na $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Stránku se nepodařilo otevřít.';

  @override
  String get accountSetupCouldNotSaveName => 'Název se nepodařilo uložit.';

  @override
  String get accountSetupTrustCertificate => 'Důvěřovat tomuto certifikátu';

  @override
  String get accountSetupPasswordRequired => 'Povinné';

  @override
  String get accountSetupShowPassword => 'Zobrazit heslo';

  @override
  String get accountSetupHidePassword => 'Skrýt heslo';

  @override
  String get accountSetupAppPassword => 'Heslo aplikace';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Příchozí · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Odchozí · SMTP';

  @override
  String get accountSetupSignIn => 'Přihlásit se';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Přihlásit se přes $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Použít heslo aplikace';

  @override
  String get accountSetupUseAppPasswordInstead => 'Použít raději heslo aplikace';

  @override
  String get accountSetupUseDifferentAddress => 'Použít jinou adresu';

  @override
  String get accountSetupHowToCreateAppPassword => 'Jak vytvořit heslo aplikace';

  @override
  String get accountSetupHowToCreateOne => 'Jak ho vytvořit';

  @override
  String get accountSetupGoogleNote =>
      'Přihlašujete se na stránce Googlu a Loupe vaše heslo nikdy neuvidí. Povolte aplikaci Loupe číst, odesílat a třídit vaši poštu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Přihlásit se přes Google“ zatím v tomto sestavení není k dispozici. Místo toho se můžete připojit pomocí hesla aplikace (vyžaduje dvoufázové ověření ve vašem účtu Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Vytvořte heslo aplikace ve svém účtu Google a vložte ho níže.';

  @override
  String get accountSetupMicrosoftNote =>
      'Přihlašujete se na stránce Microsoftu a Loupe vaše heslo nikdy neuvidí. Funguje to pro Outlook.com a Hotmail i pro pracovní a školní účty Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Přihlášení přes Microsoft přijde v některém z dalších sestavení. Účty Outlook, Hotmail a Microsoft 365 ho potřebují: hesla z poštovních aplikací už nepřijímají.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail vyžaduje heslo pro konkrétní aplikaci, ne heslo k účtu Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail vyžaduje heslo aplikace, ne heslo k účtu.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se k Fastmailu připojuje přes JMAP pomocí tokenu API: Settings › Privacy & Security › Manage API tokens, pro JMAP, s přístupem k poště a odesílání.';

  @override
  String get accountSetupFastmailNote => 'Fastmail vyžaduje pro poštovní aplikace heslo aplikace.';

  @override
  String get accountSetupServerSettings => 'Nastavení serveru';

  @override
  String get accountSetupSettingsNotFound => 'Nenalezeno automaticky';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Nalezeno přes $source';
  }

  @override
  String get accountSetupEditSettings => 'Upravit nastavení';

  @override
  String get accountSetupSyncing => 'Vaše pošta se synchronizuje.';

  @override
  String get accountSetupDescription => 'Popis';

  @override
  String get accountSetupDescriptionHint => 'Práce, osobní…';

  @override
  String get accountSetupColour => 'Barva';

  @override
  String accountSetupColourNumber(int number) {
    return 'Barva $number';
  }

  @override
  String get accountSetupSaving => 'Ukládání…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nedokázala v tomto telefonu otevřít svou poštovní databázi. Zavřete Loupe, znovu ji otevřete a zkuste to znovu.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Něco se pokazilo ($error). Zkuste to znovu.';
  }

  @override
  String get accountSetupSecurityNone => 'Žádné';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Zabezpečení';

  @override
  String get accountSetupUsername => 'Uživatelské jméno';

  @override
  String get accountSetupUsernameHint => 'Vaše e-mailová adresa';

  @override
  String get accountSetupNoEncryptionTitle => 'Připojit se bez šifrování?';

  @override
  String get accountSetupNoEncryptionText =>
      'Vaše heslo i každá zpráva by putovaly jako prostý text. Kdokoli v síti, například na veřejné Wi-Fi, by je mohl přečíst. Používejte to jen pro server ve vlastní síti.';

  @override
  String get accountSetupUseWithoutEncryption => 'Použít bez šifrování';

  @override
  String get accountSetupApiTokenRejected =>
      'Token API byl odmítnut. Vytvořte token API Fastmailu pro JMAP s přístupem k e-mailu a vložte ho.';

  @override
  String get accountSetupAppPasswordRejected => 'Heslo bylo odmítnuto. Použijte heslo aplikace, ne heslo k účtu.';

  @override
  String get accountSetupPasswordRejected => 'Heslo bylo odmítnuto. Zkontrolujte ho a zkuste to znovu.';

  @override
  String get accountSetupServerUnreachable => 'Server je nedostupný. Zkontrolujte nastavení serveru a připojení.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certifikát serveru není důvěryhodný. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Přihlášení bylo zrušeno. Zkuste to znovu klepnutím na „Přihlásit se přes $provider“.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe potřebuje oprávnění číst a odesílat vaši poštu Gmail. Přihlaste se znovu a povolte přístup se zaškrtnutou volbou Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe potřebuje oprávnění číst a odesílat vaši poštu. Přihlaste se znovu a oprávnění přijměte.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Než budete moci Loupe s tímto účtem používat, musí ji vaše organizace schválit. Požádejte správce IT, aby pro Loupe udělil souhlas správce v Microsoft Entra ID, a pak to zkuste znovu.';

  @override
  String get accountSetupOAuthBlocked =>
      'Pravidla přihlašování vaší organizace nepovolují Loupe v tomto zařízení. Obraťte se na správce IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider se nepodařilo kontaktovat. Zkontrolujte připojení k internetu a zkuste to znovu.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Přihlášení přes $provider není v této verzi Loupe správně nastavené. Nahlaste to prosím.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Přihlášení přes $provider nefungovalo. Zkuste to znovu.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Přihlášení přes $provider proběhlo, ale Gmail pro tuto adresu odmítl přístup. Při přihlašování zvolte stejný účet. Pracovní nebo školní účty mohou mít IMAP vypnutý správcem.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Přihlášení přes $provider proběhlo, ale poštovní server pro tuto adresu odmítl přístup. Při přihlašování zvolte stejný účet. Pracovní nebo školní účty mohou mít IMAP vypnutý správcem.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Poštovní server je nedostupný. Zkontrolujte připojení a zkuste to znovu.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Přihlášení přes $provider není v této verzi k dispozici.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Znovu přihlášeno. $account se synchronizuje.';
  }

  @override
  String get accountSetupSignInAgain => 'Znovu se přihlásit';

  @override
  String get accountSetupSigningIn => 'Přihlašování…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider už nepřijímá přihlášení z Loupe pro $email, takže se $account nesynchronizuje. Přihlaste se znovu, abyste dostávali poštu.';
  }

  @override
  String get accountImportTitle => 'Import z Thunderbirdu';

  @override
  String get accountImportPointCamera => 'Namiřte fotoaparát na QR kód, který zobrazuje Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Naskenováno $scanned z $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Naskenováno $scanned z $total kódů',
      few: 'Naskenováno $scanned z $total kódů',
      one: 'Naskenováno $scanned z $total kódu',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zatím $count účtů',
      few: 'Zatím $count účty',
      one: 'Zatím $count účet',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'V počítači otevřete Thunderbird a zvolte Nástroje › Exportovat do mobilu. Vyberte své účty a pak naskenujte každý zobrazený kód. Kódy lze skenovat v libovolném pořadí.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pokračovat s $count účty',
      few: 'Pokračovat s $count účty',
      one: 'Pokračovat s $count účtem',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Raději vložit text';

  @override
  String get accountImportStartOver => 'Začít znovu';

  @override
  String get accountImportDuplicateCode => 'Tento kód už byl přidán.';

  @override
  String get accountImportRestarted => 'Tento kód je z nového exportu, takže dříve naskenované kódy byly odloženy.';

  @override
  String get accountImportNotThunderbird => 'Toto není kód účtu z Thunderbirdu.';

  @override
  String get accountImportNewerVersion =>
      'Tento kód pochází z novějšího Thunderbirdu. Aktualizujte Loupe, abyste ho mohli importovat.';

  @override
  String get accountImportDamaged => 'Tento kód z Thunderbirdu se nepodařilo přečíst.';

  @override
  String get accountImportTooLarge => 'Tento kód je příliš velký na to, aby šlo o export z Thunderbirdu.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nastavení se nepodařilo otevřít.';

  @override
  String get accountImportCameraOffTitle => 'Přístup k fotoaparátu je vypnutý';

  @override
  String get accountImportCameraOffText =>
      'Povolte aplikaci Loupe v Nastavení používat fotoaparát, abyste mohli kód naskenovat, nebo raději vložte text kódu.';

  @override
  String get accountImportNoCameraTitle => 'Žádný fotoaparát';

  @override
  String get accountImportNoCameraText => 'Loupe tu nemůže použít fotoaparát. Vložte raději text kódu.';

  @override
  String get accountImportCameraFailedTitle => 'Fotoaparát se nespustil';

  @override
  String get accountImportCameraFailedText => 'Zkuste to znovu, nebo raději vložte text kódu.';

  @override
  String get accountImportOpenSettings => 'Otevřít nastavení';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nalezeno $count účtů',
      few: 'Nalezeny $count účty',
      one: 'Nalezen $count účet',
      zero: 'Nenalezeny žádné účty',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Žádný z účtů v těchto kódech se nepodařilo přečíst.';

  @override
  String get accountImportChoose => 'Vyberte účty, které chcete přidat do Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kódy $codes z $total nebyly naskenovány, takže jejich účty nejsou uvedeny.',
      few: 'Kódy $codes z $total nebyly naskenovány, takže jejich účty nejsou uvedeny.',
      one: 'Kód $codes z $total nebyl naskenován, takže jeho účty nejsou uvedeny.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes a $last';
  }

  @override
  String get accountImportScanMore => 'Naskenovat další kódy';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count účtů v kódech se nepodařilo přečíst. Možná používají nastavení z novějšího Thunderbirdu.',
      few: '$count účty v kódech se nepodařilo přečíst. Možná používají nastavení z novějšího Thunderbirdu.',
      one: '$count účet v kódech se nepodařilo přečíst. Možná používá nastavení z novějšího Thunderbirdu.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skenovat znovu';

  @override
  String get accountImportAlreadyAdded => 'Účet s touto adresou už v Loupe je.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Po přidání se přihlásíte přes $provider, stejně jako v Thunderbirdu.';
  }

  @override
  String get accountImportGmailAppPassword => 'Přidejte účet pomocí hesla aplikace (vyžaduje dvoufázové ověření).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se do Gmailu přihlašuje přes Google. „Přihlásit se přes Google“ přijde v některém z dalších sestavení; do té doby přidejte účet pomocí hesla aplikace (vyžaduje dvoufázové ověření).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se k tomuto účtu přihlašuje v prohlížeči. To Loupe zatím neumí: použijte heslo aplikace, pokud ho váš poskytovatel nabízí.';

  @override
  String get accountImportUnencrypted => 'Připojuje se bez šifrování. Používejte to jen ve vlastní síti.';

  @override
  String get accountImportEnterAgain => 'Zadejte ho znovu';

  @override
  String get accountImportAdded => 'Přidáno';

  @override
  String accountImportAdding(int index, int total) {
    return 'Přidávání $index z $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Přidat $count účtů',
      few: 'Přidat $count účty',
      one: 'Přidat $count účet',
      zero: 'Přidat účty',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Vložte text exportu';

  @override
  String get accountImportPasteText => 'Vložte text kódu exportu z Thunderbirdu, jeden kód na řádek.';

  @override
  String get accountImportPop3 => 'Účty POP3 nejsou podporovány. Loupe nechává poštu na serveru přes IMAP.';

  @override
  String get accountImportKerberos => 'Tento účet se přihlašuje přes Kerberos, který Loupe nepodporuje.';

  @override
  String get accountImportNtlm => 'Tento účet se přihlašuje přes NTLM, které Loupe nepodporuje.';

  @override
  String get accountImportClientCertificate =>
      'Tento účet se přihlašuje klientským certifikátem, který Loupe zatím nepodporuje.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Přihlášení přes Microsoft přijde v některém z dalších sestavení. Účty Outlook a Microsoft 365 už nepřijímají hesla z poštovních aplikací.';

  @override
  String get accountImportEnterPassword => 'Zadejte heslo.';

  @override
  String get accountImportEnterAppPassword => 'Zadejte heslo aplikace.';

  @override
  String get accountImportEnterApiToken => 'Zadejte token API.';

  @override
  String get accountImportStorageFailed => 'Loupe nedokázala otevřít úložiště účtů. Zkuste to později.';

  @override
  String get accountImportFailed => 'Účet se nepodařilo přidat. Zkuste to znovu, nebo ho přidejte ručně.';

  @override
  String get composeNewMessageTitle => 'Nová zpráva';

  @override
  String get composeAttach => 'Přiložit';

  @override
  String get composeSendLater => 'Odeslat později';

  @override
  String composeSendAt(String time) {
    return 'Odeslat $time';
  }

  @override
  String get composeSendHint => 'Podržením odešlete později';

  @override
  String get composeNoAccount => 'Abyste mohli odesílat poštu, přidejte účet.';

  @override
  String get composeTo => 'Komu:';

  @override
  String get composeCc => 'Kopie:';

  @override
  String get composeBcc => 'Skrytá kopie:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopie, skrytá kopie, od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Předmět:';

  @override
  String composeReplyTo(String address) {
    return 'Odpovědět na: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odpovědět z $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Odeslat z $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odpovědět z $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Odeslat z $email?';
  }

  @override
  String get composeDismiss => 'Zavřít';

  @override
  String composeAliasNotSaved(String account) {
    return 'Neuloženo jako identita · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Uložit jako identitu';

  @override
  String composeAliasSaved(String email) {
    return '$email je uložena jako identita.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Neplatná adresa $address';
  }

  @override
  String get composeOriginalNotFound => 'Původní zprávu se nepodařilo najít.';

  @override
  String get composeDraftNotFound => 'Koncept se nepodařilo najít.';

  @override
  String get composeAttachmentsLost => 'Přílohy se nepodařilo obnovit. Přidejte je znovu.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Některé přílohy se nepodařilo přidat: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Přílohy mají celkem $size; některé servery tak velké zprávy odmítají.';
  }

  @override
  String get composeAttachFailed => 'Soubor se nepodařilo přiložit.';

  @override
  String get composeInvalidAddressTitle => 'Neplatná adresa';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ není platná e-mailová adresa.';
  }

  @override
  String get composeNoSubjectTitle => 'Bez předmětu';

  @override
  String get composeNoSubjectText => 'Tato zpráva nemá předmět. Přesto odeslat?';

  @override
  String get composeSentBeforeChanges => 'Zpráva byla odeslána před vašimi změnami, které jsou uložené v Konceptech.';

  @override
  String composeScheduled(String time) {
    return 'Naplánováno: $time';
  }

  @override
  String get composeSending => 'Odesílání…';

  @override
  String get composeSent => 'Odesláno';

  @override
  String get composeSendFailed => 'Odeslání se nezdařilo. Zkuste to znovu.';

  @override
  String get composeAlreadySent => 'Už odesláno.';

  @override
  String get composeDiscardChanges => 'Zahodit změny';

  @override
  String get composeSaveChanges => 'Uložit změny';

  @override
  String get composeDeleteDraft => 'Smazat koncept';

  @override
  String get composeSaveDraft => 'Uložit koncept';

  @override
  String get composeDraftSaved => 'Koncept uložen';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Dne $date v $time odesílatel $name napsal:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Dne $date v $time někdo napsal:';
  }

  @override
  String get composeForwardHeader => '---------- Přeposlaná zpráva ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Od: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date v $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Předmět: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Komu: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kopie: $addresses';
  }

  @override
  String get composeLaterToday => 'Později dnes';

  @override
  String get composeTomorrowMorning => 'Zítra ráno';

  @override
  String get composeMondayMorning => 'V pondělí ráno';

  @override
  String get composePickDateTime => 'Vybrat datum a čas…';

  @override
  String get composeSendWithoutDelay => 'Odeslat bez odkladu';

  @override
  String composeSendTimeToday(String time) {
    return 'Dnes v $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Zítra v $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day v $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Dnes $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Zítra $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Pokračovat v úpravách konceptu?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Zpráva nebyla odeslána, když se Loupe zavřela.',
      'one': 'Zpráva pro $name nebyla odeslána, když se Loupe zavřela.',
      'other': 'Zpráva pro $name a další nebyla odeslána, když se Loupe zavřela.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Zpráva „$subject“ nebyla odeslána, když se Loupe zavřela.',
      'one': 'Zpráva „$subject“ pro $name nebyla odeslána, když se Loupe zavřela.',
      'other': 'Zpráva „$subject“ pro $name a další nebyla odeslána, když se Loupe zavřela.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Pokračovat v úpravách';

  @override
  String get composeRecoverySave => 'Uložit do konceptů';

  @override
  String get composeRecoveryDiscard => 'Zahodit';

  @override
  String get composeRecoverySaved => 'Uloženo do konceptů';

  @override
  String get outboxSectionFailed => 'Neodesláno';

  @override
  String get outboxSectionSending => 'Odesílání';

  @override
  String get outboxSectionScheduled => 'Naplánováno';

  @override
  String get outboxStatusQueued => 'Brzy se odešle';

  @override
  String get outboxStatusSending => 'Odesílání…';

  @override
  String get outboxStatusFailed => 'Neodesláno';

  @override
  String get outboxNoRecipients => 'Bez příjemců';

  @override
  String get outboxNoSubject => '(Bez předmětu)';

  @override
  String get outboxSendingFailed => 'Odeslání se nezdařilo.';

  @override
  String get outboxEmptyTitle => 'Nic k odeslání';

  @override
  String get outboxEmptyText => 'Zprávy, které odešlete později, tu čekají, až přijde jejich čas.';

  @override
  String get outboxSendNow => 'Odeslat hned';

  @override
  String get outboxReschedule => 'Přeplánovat';

  @override
  String get outboxRescheduleMenu => 'Přeplánovat…';

  @override
  String get outboxRescheduleTitle => 'Přeplánovat';

  @override
  String outboxRescheduled(String time) {
    return 'Přeplánováno: $time';
  }

  @override
  String get outboxCancel => 'Zrušit';

  @override
  String get outboxCancelSending => 'Zrušit odeslání…';

  @override
  String get outboxCancelTitle => 'Zrušit odeslání?';

  @override
  String get outboxMoveToDrafts => 'Přesunout do konceptů';

  @override
  String get outboxDiscard => 'Zahodit zprávu';

  @override
  String get outboxMovedToDrafts => 'Přesunuto do konceptů';

  @override
  String get outboxDiscarded => 'Zpráva zahozena';

  @override
  String get outboxAlreadySent => 'Už odesláno.';

  @override
  String get outboxBeingSent => 'Tato zpráva se právě odesílá.';

  @override
  String get outboxActionFailed => 'Nepovedlo se. Zpráva je stále ve složce K odeslání.';

  @override
  String get notificationsBadgeInboxes => 'Nepřečtené v doručené poště';

  @override
  String get notificationsBadgeVip => 'Nepřečtené od VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nová pošta od vašich VIP v jakémkoli účtu';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nová pošta v $email';
  }

  @override
  String get notificationsUnknownSender => 'Neznámý odesílatel';

  @override
  String get notificationsNoSubject => '(Bez předmětu)';

  @override
  String get notificationsEncryptedMessage => 'Šifrovaná zpráva';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nová zpráva od $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nových zpráv',
      few: '$count nové zprávy',
      one: '$count nová zpráva',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nové zprávy v účtu $account';
  }

  @override
  String get platformInstantChannel => 'Okamžité doručování';

  @override
  String get platformInstantChannelDescription =>
      'Zobrazuje se, když Loupe sleduje vaši doručenou poštu kvůli nové poště';

  @override
  String get platformInstantTitle => 'Sledování nové pošty';

  @override
  String get platformInstantText => 'Okamžité doručování je zapnuté';

  @override
  String get platformErrorBox => 'Při zobrazení se něco pokazilo. Vraťte se zpět a zkuste to znovu.';

  @override
  String get welcomeTagline => 'Pošta na povrchu jednoduchá\na pod povrchem výkonná.';

  @override
  String get welcomeAccountsTitle => 'Všechny účty, jedna klidná schránka';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail a jakýkoli server IMAP nebo JMAP.';

  @override
  String get welcomeSearchTitle => 'Hledání, které najde';

  @override
  String get welcomeSearchText => 'Okamžité výsledky v telefonu, pak ty ze serveru.';

  @override
  String get welcomePrivacyTitle => 'Soukromí od základu';

  @override
  String get welcomePrivacyText => 'Žádné sledování. Vzdálené obrázky zůstanou blokované, dokud je nepovolíte.';

  @override
  String get welcomeAddAccount => 'Přidat účet';

  @override
  String get welcomeImport => 'Importovat z Thunderbirdu';

  @override
  String get welcomeTryDemo => 'Vyzkoušet s ukázkovou poštou';
}
