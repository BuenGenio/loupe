// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get commonAdd => 'Hozzáadás';

  @override
  String get commonCancel => 'Mégse';

  @override
  String get commonClose => 'Bezárás';

  @override
  String get commonDelete => 'Törlés';

  @override
  String get commonDone => 'Kész';

  @override
  String get commonEdit => 'Szerkesztés';

  @override
  String get commonMore => 'Továbbiak';

  @override
  String get commonMove => 'Áthelyezés';

  @override
  String get commonName => 'Név';

  @override
  String get commonNone => 'Nincs';

  @override
  String get commonOff => 'Ki';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Be';

  @override
  String get commonOptional => 'Nem kötelező';

  @override
  String get commonPassword => 'Jelszó';

  @override
  String get commonRemove => 'Eltávolítás';

  @override
  String get commonRetry => 'Újra';

  @override
  String get commonSave => 'Mentés';

  @override
  String get commonSearch => 'Keresés';

  @override
  String get commonServer => 'Szerver';

  @override
  String get commonSettings => 'Beállítások';

  @override
  String get commonShare => 'Megosztás';

  @override
  String get commonTryAgain => 'Újrapróbálás';

  @override
  String get commonUndo => 'Visszavonás';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count üzenet', one: '$count üzenet');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archiválás';

  @override
  String get mailDelete => 'Törlés';

  @override
  String get mailFlag => 'Megjelölés';

  @override
  String get mailForward => 'Továbbítás';

  @override
  String get mailMarkAsRead => 'Megjelölés olvasottként';

  @override
  String get mailMarkAsUnread => 'Megjelölés olvasatlanként';

  @override
  String get mailMoveToJunk => 'Áthelyezés a levélszemétbe';

  @override
  String get mailNewMessage => 'Új üzenet';

  @override
  String get mailNoSubject => 'Nincs tárgy';

  @override
  String get mailReply => 'Válasz';

  @override
  String get mailReplyAll => 'Válasz mindenkinek';

  @override
  String get mailSend => 'Küldés';

  @override
  String get mailUnflag => 'Megjelölés törlése';

  @override
  String get mailboxArchive => 'Archívum';

  @override
  String get mailboxDrafts => 'Piszkozatok';

  @override
  String get mailboxInbox => 'Beérkező levelek';

  @override
  String get mailboxJunk => 'Levélszemét';

  @override
  String get mailboxOutbox => 'Kimenő';

  @override
  String get mailboxSent => 'Elküldött';

  @override
  String get mailboxTrash => 'Kuka';

  @override
  String get conversationSomethingWentWrong => 'Hiba történt. Próbáld újra.';

  @override
  String get conversationReplyToList => 'Válasz a listának';

  @override
  String get conversationReplyList => 'Válasz listára';

  @override
  String get conversationThreadMuted => 'Szál némítva. Az új üzenetei olvasottként érkeznek.';

  @override
  String get conversationThreadUnmuted => 'Szál némítása feloldva.';

  @override
  String get conversationLinkFailed => 'Nem sikerült megnyitni a linket.';

  @override
  String get conversationGoneTitle => 'Nincs üzenet';

  @override
  String get conversationGoneText => 'Ezt az üzenetet áthelyezték vagy törölték.';

  @override
  String get conversationMuted => 'Némítva';

  @override
  String get conversationReaderOptions => 'Olvasási beállítások';

  @override
  String get conversationReaderOptionsHint => 'Betűméret és nézet';

  @override
  String get conversationTrash => 'Kukába';

  @override
  String get conversationReplyHint => 'Nyomd hosszan a Válasz mindenkinek és a Továbbítás eléréséhez';

  @override
  String get conversationOfflineTitle => 'Offline vagy';

  @override
  String get conversationOfflineText => 'Ez a beszélgetés még nincs letöltve. Betöltődik, amint újra online leszel.';

  @override
  String get conversationErrorTitle => 'Ez az üzenet nem jeleníthető meg';

  @override
  String get conversationErrorText => 'Hiba történt.';

  @override
  String get conversationOfflineBanner => 'Offline vagy';

  @override
  String get conversationNotUpdated => 'Nincs frissítve';

  @override
  String get conversationMe => 'én';

  @override
  String get conversationNoSender => '(nincs feladó)';

  @override
  String get conversationNoRecipients => 'nincs címzett';

  @override
  String conversationRecipients(String names) {
    return 'címzett: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'címzett: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Feladó';

  @override
  String get conversationHeaderTo => 'Címzett';

  @override
  String get conversationHeaderCc => 'Másolat';

  @override
  String get conversationHeaderBcc => 'Titkos másolat';

  @override
  String get conversationHeaderReplyTo => 'Válaszcím';

  @override
  String get conversationHeaderDate => 'Dátum';

  @override
  String get conversationHeaderSecurity => 'Biztonság';

  @override
  String get conversationVerifiedSender => 'Ellenőrzött feladó';

  @override
  String get conversationUnverifiedSender => 'Nem ellenőrzött feladó';

  @override
  String get conversationLoadingMessage => 'Üzenet betöltése';

  @override
  String get conversationBodyError => 'Az üzenetet nem sikerült betölteni.';

  @override
  String get conversationBodyOffline => 'Offline vagy. Az üzenet betöltődik, amint újra online leszel.';

  @override
  String get conversationOriginalHint => 'Eredeti nézetben jobban mutat';

  @override
  String get conversationShowOriginal => 'Eredeti megjelenítése';

  @override
  String get conversationScrollToTop => 'Görgetés a tetejére';

  @override
  String get conversationTagsMenu => 'Címkék…';

  @override
  String get conversationMuteThread => 'Szál némítása';

  @override
  String get conversationUnmuteThread => 'Szál némításának feloldása';

  @override
  String get conversationMoveMenu => 'Áthelyezés…';

  @override
  String get conversationDeletePermanently => 'Végleges törlés';

  @override
  String get conversationMoveToTrash => 'Áthelyezés a kukába';

  @override
  String get conversationNotJunk => 'Nem levélszemét';

  @override
  String get conversationShowAllHeaders => 'Összes fejléc megjelenítése';

  @override
  String get conversationViewSource => 'Forrás megtekintése';

  @override
  String get conversationSaveAsFile => 'Mentés fájlként…';

  @override
  String get conversationShareAsFile => 'Megosztás fájlként…';

  @override
  String get conversationSearchFromMessageMenu => 'Keresés ebből az üzenetből…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Cím másolása';

  @override
  String get conversationAddressCopied => 'Cím másolva';

  @override
  String conversationSearchMessagesFrom(String name) {
    return '$name üzeneteinek keresése';
  }

  @override
  String get conversationTags => 'Címkék';

  @override
  String get conversationAllHeaders => 'Összes fejléc';

  @override
  String get conversationCopyAll => 'Összes másolása';

  @override
  String get conversationHeadersCopied => 'Fejlécek másolva';

  @override
  String get conversationNoHeaders => 'Nincsenek fejlécek';

  @override
  String get conversationSearchFromMessageTitle => 'Keresés ebből az üzenetből';

  @override
  String conversationSearchFrom(String name) {
    return 'Feladó: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Címzett: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Tárgy: „$subject”';
  }

  @override
  String get conversationSourceTitle => 'Forrás';

  @override
  String get conversationSourceCopied => 'Forrás másolva';

  @override
  String get conversationShareFailed => 'Nem sikerült megosztani az üzenetet.';

  @override
  String get conversationWrapLines => 'Sortörés';

  @override
  String get conversationDontWrapLines => 'Sortörés kikapcsolása';

  @override
  String get conversationSourceError => 'A forrást nem sikerült betölteni.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Az első $shown látható, összesen $total. A teljes forráshoz másold vagy oszd meg.';
  }

  @override
  String get conversationAttachmentUntitled => 'Névtelen';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'További műveletek: $name';
  }

  @override
  String get conversationMoveTo => 'Áthelyezés ide…';

  @override
  String get conversationMailboxesError => 'Nem sikerült betölteni a postafiókokat.';

  @override
  String get conversationReaderReadable => 'Olvasóbarát';

  @override
  String get conversationReaderOriginal => 'Eredeti';

  @override
  String get conversationReaderPlain => 'Egyszerű';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Eredeti színek megtartása';

  @override
  String get conversationReaderRemember => 'Megjegyzés ennél a feladónál';

  @override
  String get conversationSecurityPossiblePhishing => 'Lehetséges adathalászat';

  @override
  String get conversationSecurityBeCareful => 'Légy óvatos';

  @override
  String get conversationSecurityVerified => 'Ellenőrzött';

  @override
  String get conversationSecurityNoIssues => 'Nem található probléma';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nyomkövető',
      one: '$count nyomkövető',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Megmutatja, miért';

  @override
  String get conversationPhishingBannerTitle => 'Ez az üzenet adathalászatnak tűnik';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. A linkek és a képek ki vannak kapcsolva.';
  }

  @override
  String get conversationPhishingBannerText => 'A linkek és a képek ki vannak kapcsolva.';

  @override
  String get conversationPhishingWhy => 'Miért?';

  @override
  String get conversationPhishingShowAnyway => 'Megjelenítés mégis';

  @override
  String get conversationSecurityPhishingTitle => 'Ez adathalászatnak tűnik';

  @override
  String get conversationSecurityPhishingText =>
      'Több jel is arra utal, hogy ez az üzenet nem az, aminek mondja magát.';

  @override
  String get conversationSecurityCarefulTitle => 'Légy óvatos ezzel az üzenettel';

  @override
  String get conversationSecurityCarefulText => 'Van benne valami, amit érdemes még egyszer megnézni.';

  @override
  String get conversationSecurityVerifiedText => 'A feladó ellenőrzött, és semmi sem tűnik gyanúsnak.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Semmi sem tűnik gyanúsnak. A levelezőszervered nem jelezte, hogy a feladó ellenőrzött-e.';

  @override
  String get conversationSecurityNothingSuspicious => 'Semmi sem tűnik gyanúsnak.';

  @override
  String get conversationSecurityWhy => 'Miért';

  @override
  String get conversationSecurityPrivacy => 'Adatvédelem';

  @override
  String get conversationSecurityNoTrackingPixels => 'Nincsenek követőpixelek';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count követőpixel eltávolítva',
      one: '$count követőpixel eltávolítva',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Ezek elárulták volna a feladónak, mikor nyitottad meg ezt az üzenetet.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nincsenek távoli képek';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count távoli kép',
      one: '$count távoli kép',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ha betöltöd őket, a feladó megtudja, mikor olvasod ezt az üzenetet, és az IP-címedet is.';

  @override
  String get conversationSecurityNoClickTracking => 'Nincs kattintáskövetés';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count link kattintáskövetőkön keresztül',
      one: '$count link kattintáskövetőn keresztül',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'A kattintásodat rögzítené: $services. Nyomd hosszan a linket, hogy közvetlenül a céljára juss.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technikai részletek';

  @override
  String get conversationSecurityCheckedLocally => 'Az ellenőrzés ezen az eszközön történt. Semmi sem lett elküldve.';

  @override
  String get conversationSecurityTrackersLabel => 'Nyomkövetők';

  @override
  String get conversationSecurityImagesFrom => 'Képek forrása';

  @override
  String get conversationSecuritySenderHistory => 'Előzmények';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'fogadott: $received, küldött: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linkek célja';

  @override
  String get conversationSecurityHidden => 'Rejtett';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements elem', one: '$elements elem');
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters karakter',
      one: '$characters karakter',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Nem ellenőrzött feladó';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'A levelezőszervered nem tudta megerősíteni, hogy ez az üzenet valóban innen érkezik: $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'A levelezőszervered nem tudta megerősíteni, hogy ez az üzenet valóban a feladójától érkezik.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'A levelezőszervered nem tudta megerősíteni, hogy ez az üzenet innen érkezik: $domain. Levelezőlistáknál ez gyakori.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'A levelezőszervered nem tudta megerősíteni, hogy ez az üzenet a feladójától érkezik. Levelezőlistáknál ez gyakori.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ne tegyél semmit a kérésére, hacsak nem számítottál rá. Ha kétséged van, érd el a feladót más módon.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Másik domain írta alá';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Az üzenet aláírója $signer, nem pedig $domain. A levelezőszolgáltatások így szokták, de ez nem bizonyítja, ki írta.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Az üzenetet nem $domain, hanem egy másik domain írta alá. A levelezőszolgáltatások így szokták, de ez nem bizonyítja, ki írta.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'A név egy másik címet mutat';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'A feladó neve „$shown”, de az üzenet erről a címről érkezik: $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'A címben bízz, ne a névben.';

  @override
  String get conversationSecurityReplyToTitle => 'A válaszok máshová mennek';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'A válaszod ide menne: $address, nem pedig ide: $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Ellenőrizd a címet, mielőtt bármi személyeset írnál válaszul.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'A te nevedet használja';

  @override
  String get conversationSecurityImpersonationTitle => 'Egy ismerősöd nevét használja';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Az aláírás „$name”, akárcsak a saját neved, de egy új címről érkezik: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Az aláírás „$name”, akárcsak VIP-partnered, $knownName ($knownEmail) neve, de egy új címről érkezik: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Az aláírás „$name”, akárcsak $knownName ($knownEmail) neve, de egy új címről érkezik: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Ráadásul a válaszok egy harmadik címre mennének.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ha pénzt, kódokat vagy fájlokat kér, előbb más módon ellenőrizd az illetőnél.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Ismert cím: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ez a cím: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Első üzenet ettől a feladótól';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Erről a címről még nem kaptál levelet: $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Légy óvatos azok kéréseivel, akiket még nem ismersz.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Megtévesztően hasonló betűk a feladó címében';

  @override
  String get conversationSecurityLinkHomographTitle => 'Megtévesztően hasonló betűk egy linkben';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host különböző ábécék betűit keveri, hogy egy másik címet utánozzon.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host megtévesztően hasonló betűket használ: ez nem $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Töröld, vagy jelentsd levélszemétként.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ne nyisd meg.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domain: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Megtévesztően hasonló domain';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Ismert nevet használ a domainjében';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain úgy néz ki, mint a saját domained ($real), de ez egy másik domain.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain úgy néz ki, mint $brand ($real), de ez egy másik domain.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain a saját domained ($real) nevét használja, de nem tartozik hozzá.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain ezt a nevet használja: $brand ($real), de nem tartozik hozzá.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'A szervezeted valódi üzenetei innen érkeznek: $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return '$brand valódi üzenetei innen érkeznek: $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Feladó domainje: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Utánozza: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count link elrejti, hová vezet',
      one: 'Egy link elrejti, hová vezet',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Egy link ezt mutatja: $shown, de ezt nyitja meg: $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ne jelentkezz be és ne fizess ezeken a linkeken keresztül. Inkább írd be magad a címet.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Egy link célja nem ellenőrizhető';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Egy link ezt mutatja: $shown, de ezen keresztül halad: $host, amely továbbítás előtt rögzíti a kattintást.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Egy link puszta IP-címre mutat';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nem névvel rendelkező webhely. Valódi cégek ritkán linkelnek így.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Álcázott link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Egy link így kezdődik: „$shown@”, hogy úgy tűnjön, mintha ide vezetne: $shown, de ezt nyitja meg: $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Rejtett oldal letiltva';

  @override
  String get conversationSecurityDataLinkText =>
      'Egy link az üzenetbe csomagolt oldalt nyitott volna meg – ez a linkellenőrzés megkerülésének egyik módja.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Jelszót kér';

  @override
  String get conversationSecurityPasswordFieldText => 'Az üzenet jelszómezőt tartalmazott. A Loupe eltávolította.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Soha ne írj be jelszót egy e-mailbe.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Kódot futtató link letiltva';

  @override
  String get conversationSecurityScriptLinkText => 'A Loupe soha nem futtat kódot az üzenetekből.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rövidített linkek',
      one: 'Rövidített link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts a megnyitásig elrejti a valódi célt.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Nemzetközi webcím';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts nem latin betűket használ. Sok nyelvnél ez természetes; ellenőrizd, hogy a várt webhelyről van-e szó.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Sok rejtett szöveg';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count karakternyi láthatatlan szöveg eltávolítva. Az ilyen rejtett szöveg a levélszemétszűrők megtévesztésére szolgál.',
      one:
          '$count karakternyi láthatatlan szöveg eltávolítva. Az ilyen rejtett szöveg a levélszemétszűrők megtévesztésére szolgál.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Rejtett szöveg eltávolítva';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count karakternyi láthatatlan szöveg eltávolítva.',
      one: '$count karakternyi láthatatlan szöveg eltávolítva.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Nem sikerült letölteni az üzenetet. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String exportSaved(String name) {
    return 'Mentve: „$name”';
  }

  @override
  String get exportSaveFailed => 'Nem sikerült menteni az üzenetet.';

  @override
  String exportFailed(String folder) {
    return 'Nem sikerült exportálni: „$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Nincs exportálható üzenet ebben a mappában: „$folder”.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Nem sikerült exportálni: „$folder”. Egyetlen üzenetet sem sikerült letölteni. Ellenőrizd a kapcsolatot, és próbáld újra.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mentve: „$name”, $formattedCount üzenet nélkül, amelyeket nem sikerült letölteni.',
      one: 'Mentve: „$name”, $formattedCount üzenet nélkül, amelyet nem sikerült letölteni.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Nem sikerült menteni: „$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Exportálás: „$folder”';
  }

  @override
  String get exportListing => 'Üzenetek keresése…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportálás: $current / $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount üzenetet nem sikerült letölteni',
      one: '$formattedCount üzenetet nem sikerült letölteni',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postafiókok';

  @override
  String get mailboxesShown => 'Látható';

  @override
  String get mailboxesHidden => 'Rejtett';

  @override
  String get mailboxesCollapse => 'Összecsukás';

  @override
  String get mailboxesExpand => 'Kibontás';

  @override
  String get mailboxesManageVips => 'VIP-ek kezelése';

  @override
  String get mailboxesSubscriptions => 'Feliratkozások';

  @override
  String mailboxesShowAccount(String account) {
    return '$account megjelenítése';
  }

  @override
  String mailboxesHideAccount(String account) {
    return '$account elrejtése';
  }

  @override
  String get mailboxesExportFolder => 'Mappa exportálása…';

  @override
  String get mailboxesUnpin => 'Rögzítés feloldása';

  @override
  String get mailboxesLists => 'Listák';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Ments el egy keresést, hogy itt legyen.';

  @override
  String get mailboxesTags => 'Címkék';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Ha egy üzenetben a feladó nevére koppintasz, ott is bekapcsolhatod a VIP-et.';

  @override
  String get mailboxesAddVip => 'VIP hozzáadása…';

  @override
  String get mailboxesAddVipTitle => 'VIP hozzáadása';

  @override
  String get mailboxesAddVipText =>
      'Az erről a címről érkező levelek csillagot kapnak, és a VIP postafiókban jelennek meg.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Olvasatlan';

  @override
  String get messageListFilterFlagged => 'Megjelölt';

  @override
  String get messageListFilterToMe => 'Címzett: én';

  @override
  String get messageListFilterCcMe => 'Másolat: én';

  @override
  String get messageListFilterWithAttachments => 'Mellékletes';

  @override
  String get messageListFilterUnreplied => 'Megválaszolatlan';

  @override
  String get messageListFilterFromVips => 'VIP-ektől';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet megjelölve olvasottként',
      one: '$count üzenet megjelölve olvasottként',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Nem sikerült betölteni a régebbi leveleket.';

  @override
  String get messageListSelectMessages => 'Üzenetek kijelölése';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kijelölve',
      one: '$count kijelölve',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Összes kijelölése';

  @override
  String get messageListDeselectAll => 'Kijelölés megszüntetése';

  @override
  String get messageListLoadFailed => 'Nem sikerült betölteni a leveleket';

  @override
  String get messageListNoUnread => 'Nincs olvasatlan levél';

  @override
  String get messageListNoMatches => 'Nincs egyező levél';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Szűrők: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Szűrő kikapcsolása';

  @override
  String get messageListEmpty => 'Nincs levél';

  @override
  String get messageListFilter => 'Szűrő';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Szűrési feltételek: $filters';
  }

  @override
  String get messageListFilteredBy => 'Szűrők:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount olvasatlan',
      one: '$formattedCount olvasatlan',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Megjelölés';

  @override
  String get messageListTrash => 'Kukába';

  @override
  String get messageListFilterTitle => 'Szűrő';

  @override
  String get messageListFilterInclude => 'MEGJELENÍTENDŐ';

  @override
  String get panesHideMailboxes => 'Postafiókok elrejtése';

  @override
  String get panesShowMailboxes => 'Postafiókok megjelenítése';

  @override
  String get panesMailboxesWidth => 'Postafiókok szélessége';

  @override
  String get panesListWidth => 'Üzenetlista szélessége';

  @override
  String get panesNoMessageSelected => 'Nincs kijelölt üzenet';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count üzenet', one: '$count üzenet');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Szundiztatott';

  @override
  String get snoozeSheetTitle => 'Szundi';

  @override
  String get snoozeLaterToday => 'Ma később';

  @override
  String get snoozeThisEvening => 'Ma este';

  @override
  String get snoozeTomorrow => 'Holnap';

  @override
  String get snoozeThisWeekend => 'Ezen a hétvégén';

  @override
  String get snoozeNextWeek => 'Jövő héten';

  @override
  String get snoozePickDateTime => 'Dátum és idő kiválasztása…';

  @override
  String get snoozeMenu => 'Szundi…';

  @override
  String get snoozeWakeNow => 'Felébresztés most';

  @override
  String get snoozeChangeTimeMenu => 'Szundi idejének módosítása…';

  @override
  String get snoozeChangeTime => 'Idő módosítása';

  @override
  String get snoozeNoTime => 'Nincs megadott idő';

  @override
  String get snoozeFooter =>
      'A szundiztatott üzenetek a megadott időben olvasatlanként visszakerülnek a Beérkező levelek közé.';

  @override
  String get snoozeEmptyTitle => 'Nincs szundiztatott üzenet';

  @override
  String get snoozeEmptyText =>
      'Szundiztass egy üzenetet, és akkor kerül vissza a Beérkező levelek közé, amikor szükséged van rá.';

  @override
  String get appLockUnlock => 'Feloldás';

  @override
  String get appLockFailed => 'A Loupe nem tudta megerősíteni, hogy te vagy az.';

  @override
  String get appLockLockedOut => 'Túl sok próbálkozás. Próbáld újra később.';

  @override
  String get appLockPromptError => 'A kérést nem sikerült megjeleníteni. Próbáld újra.';

  @override
  String get appLockNoScreenLock => 'Ezen a telefonon nincs képernyőzár.';

  @override
  String get appLockUnlockPromptTitle => 'A Loupe feloldása';

  @override
  String get appLockUnlockPromptReason => 'Erősítsd meg, hogy te vagy az, és láthatod a leveleidet.';

  @override
  String get appLockTurnOnPromptTitle => 'Alkalmazászár bekapcsolása';

  @override
  String get appLockTurnOnPromptReason => 'Erősítsd meg, hogy te vagy az, az alkalmazászár bekapcsolásához.';

  @override
  String get appLockScreenLockRemoved =>
      'Az alkalmazászár kikapcsolt: ezen a telefonon már nincs képernyőzár. Állíts be egyet, ha újra be szeretnéd kapcsolni az alkalmazászárat.';

  @override
  String get appLockAfterImmediately => 'Azonnal';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count perc', one: '$count perc');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count óra', one: '$count óra');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Titkosított';

  @override
  String get openpgpEncryptedInPart => 'Részben titkosított';

  @override
  String get openpgpEncryptedLocked => 'Titkosított · zárolt';

  @override
  String get openpgpEncryptedNoKey => 'Titkosított · nincs kulcs';

  @override
  String get openpgpEncryptedDamaged => 'Titkosított · sérült';

  @override
  String get openpgpEncryptedUnsupported => 'Titkosított · nem támogatott';

  @override
  String get openpgpUnknownSigner => 'ismeretlen';

  @override
  String get openpgpUnknownKey => 'Ismeretlen kulcs';

  @override
  String get openpgpSignatureInvalid => 'Érvénytelen aláírás';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Aláírta: $name, nem a feladó';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Részben aláírta: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Aláírta: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Elutasított kulccsal aláírva';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Aláírta: $name · a kulcs nincs elfogadva';
  }

  @override
  String get openpgpUnlock => 'Feloldás';

  @override
  String get openpgpCantDecrypt => 'Ez az üzenet nem fejthető vissza';

  @override
  String get openpgpEncryptedWithOpenPgp => 'OpenPGP-vel titkosítva';

  @override
  String get openpgpEncryption => 'Titkosítás';

  @override
  String get openpgpDecryptedHere => 'Ezen az eszközön visszafejtve';

  @override
  String get openpgpNotDecrypted => 'Nincs visszafejtve';

  @override
  String get openpgpKeyLocked => 'A kulcsod zárolva van.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Kulcsok: $keys', one: 'Kulcs: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Védett tárgy';

  @override
  String get openpgpUnlockKey => 'Kulcs feloldása';

  @override
  String get openpgpSignature => 'Aláírás';

  @override
  String get openpgpFingerprint => 'Ujjlenyomat';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Kulcsazonosító: $id';
  }

  @override
  String get openpgpSigned => 'Aláírva';

  @override
  String get openpgpProblem => 'Probléma';

  @override
  String get openpgpAcceptance => 'Elfogadás';

  @override
  String get openpgpChangeAcceptance => 'Elfogadás módosítása…';

  @override
  String get openpgpCheckedFooter => 'Ezen az eszközön ellenőrizve OpenPGP-vel, a Thunderbirddel kompatibilis módon.';

  @override
  String get openpgpSummaryLocked => 'A kulcsod zárolva van. Az üzenet elolvasásához oldd fel a jelmondatával.';

  @override
  String get openpgpSummaryNoSecretKey => 'Olyan kulcshoz titkosították, amely nincs ezen az eszközön.';

  @override
  String get openpgpSummaryDamaged => 'A titkosított adat sérült, vagy útközben módosult.';

  @override
  String get openpgpSummaryUnsupported => 'Olyan algoritmust használ, amelyet a Loupe nem támogat.';

  @override
  String get openpgpSummaryEncrypted => 'Csak te és a többi címzett olvashatja.';

  @override
  String get openpgpSummaryNotSigned => 'Nincs aláírva, így a feladó nincs megerősítve.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Alá van írva, de olyan kulccsal, amely nincs meg neked, így az aláírás nem ellenőrizhető.';

  @override
  String get openpgpSummaryBadSignature => 'Az aláírás nem egyezik: lehet, hogy az üzenetet módosították.';

  @override
  String get openpgpSummaryMismatch =>
      'Az aláírás érvényes, de a kulcs nem a feladó címéhez, hanem egy másik címhez tartozik.';

  @override
  String get openpgpSummaryPartial =>
      'Az üzenetnek csak egy része van aláírva. Az aláíráson kívüli szöveg (például egy levelezőlista lábléce) az „Unsigned content” sor alatt jelenik meg, és az aláírás az üzenet más részeire, például a mellékletekre sem terjed ki.';

  @override
  String get openpgpSummaryOwnKey => 'A saját kulcsoddal aláírva.';

  @override
  String get openpgpSummaryVerified => 'Az aláírás érvényes, és ellenőrizted a kulcs ujjlenyomatát.';

  @override
  String get openpgpSummaryUnverified =>
      'Az aláírás érvényes. A kulcsot az ujjlenyomata ellenőrzése nélkül fogadtad el.';

  @override
  String get openpgpSummaryRejected => 'Az aláírás érvényes, de elutasítottad ezt a kulcsot.';

  @override
  String get openpgpSummaryUndecided =>
      'Az aláírás érvényes, de még nem fogadtad el ezt a kulcsot. Hasonlítsd össze az ujjlenyomatát a feladóval.';

  @override
  String get openpgpAcceptanceRejected => 'Elutasítva';

  @override
  String get openpgpAcceptanceUndecided => 'Nincs elfogadva';

  @override
  String get openpgpAcceptanceUnverified => 'Elfogadva';

  @override
  String get openpgpAcceptanceVerified => 'Elfogadva és ellenőrizve';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Elfogadod $name kulcsát?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Ujjlenyomat: $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Igen, ellenőriztem az ujjlenyomatot';

  @override
  String get openpgpAcceptUnverified => 'Igen, ellenőrzés nélkül';

  @override
  String get openpgpAcceptLater => 'Még nem';

  @override
  String get openpgpRejectKey => 'Kulcs elutasítása';

  @override
  String get openpgpNoSubject => '(nincs tárgy)';

  @override
  String get openpgpEncryptionTitle => 'Végpontok közötti titkosítás';

  @override
  String get openpgpMyKeys => 'Saját OpenPGP-kulcsaim';

  @override
  String get openpgpMyKeysFooter =>
      'Egy kulccsal elolvashatod a titkosított leveleket, a sajátjaidat pedig aláírhatod és titkosíthatod. Thunderbirdöt használsz? Exportáld ott a kulcsodat (Fiókbeállítások › Végpontok közötti titkosítás › Titkos kulcs exportálása), és importáld ide.';

  @override
  String get openpgpAddKey => 'Kulcs hozzáadása…';

  @override
  String get openpgpAddresses => 'Címek';

  @override
  String get openpgpAddressesFooter => 'Melyik címhez melyik kulcs tartozik, és mikor titkosít és ír alá.';

  @override
  String get openpgpCorrespondentsKeys => 'Levelezőpartnerek OpenPGP-kulcsai';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Fogadj el egy kulcsot, ha megbízol abban, hogy a tulajdonosáé; hasonlítsd össze vele az ujjlenyomatot, hogy ellenőrzöttnek jelöld.';

  @override
  String get openpgpImportPublicKey => 'Nyilvános kulcs importálása…';

  @override
  String get openpgpCollected => 'Autocrypttel gyűjtve';

  @override
  String get openpgpCollectedFooter =>
      'Üzenetekkel érkezett kulcsok. A Loupe ezekkel titkosíthat, ha mindkét fél kéri.';

  @override
  String get openpgpOnThisDevice => 'Ezen az eszközön';

  @override
  String get openpgpOnThisDeviceFooter =>
      'A titkosított üzenetek elrejtik a tárgyukat. A Loupe minden megnyitott üzenet tárgyát megőrzi az eszközön lévő titkosított adatbázisában, hogy a lista, a keresés és az értesítések megjeleníthessék. A háttérben a Loupe a jelmondat nélküli kulcsokkal az új üzenetek tárgyát is visszafejtheti; ehhez letölti az egyes üzeneteket (legfeljebb 1 MB-ig).';

  @override
  String get openpgpDecryptSubjects => 'Tárgyak visszafejtése a háttérben';

  @override
  String get openpgpIndexFooter =>
      'A keresés a titkosított üzeneteket a feladójuk, a címzettjeik és a tárgyuk alapján találja meg. Ha ez be van kapcsolva, a Loupe minden általa visszafejtett titkosított üzenet szövegét is felveszi a keresési indexbe az eszközön lévő titkosított adatbázisában, így a keresés a szövegük alapján is megtalálja őket. Kikapcsolásakor ez a szöveg törlődik az indexből.';

  @override
  String get openpgpIndexDecrypted => 'Visszafejtett üzenetek indexelése a kereséshez';

  @override
  String get openpgpPassphrases => 'Jelmondatok';

  @override
  String get openpgpPassphrasesFooter =>
      'A jelmondattal védett OpenPGP-kulcsok és S/MIME-tanúsítványok szükség esetén feloldódnak. A „Jelmondatok megjegyzése” nélkül minden használat után két perccel újra zárolódnak.';

  @override
  String get openpgpRememberPassphrases => 'Jelmondatok megjegyzése';

  @override
  String get openpgpRememberPassphrasesDetail => 'A Loupe bezárásáig';

  @override
  String get openpgpLockKeysNow => 'Kulcsok zárolása most';

  @override
  String get openpgpKeysLocked => 'Kulcsok zárolva.';

  @override
  String get openpgpKeyStateRevoked => 'visszavonva';

  @override
  String get openpgpKeyStateExpired => 'lejárt';

  @override
  String get openpgpKeyStateNeverExpires => 'soha nem jár le';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'lejár: $date';
  }

  @override
  String get openpgpNoKey => 'Nincs kulcs';

  @override
  String get openpgpAlwaysEncrypt => 'Mindig titkosít';

  @override
  String get openpgpAddKeyTitle => 'OpenPGP-kulcs hozzáadása';

  @override
  String get openpgpAddKeyMessage => 'Importáld a Thunderbirdben használt kulcsodat, vagy hozz létre egy újat.';

  @override
  String get openpgpImportFromClipboard => 'Importálás vágólapról';

  @override
  String get openpgpImportFromFile => 'Importálás fájlból';

  @override
  String get openpgpGenerateNewKey => 'Új kulcs létrehozása';

  @override
  String get openpgpImportPublicKeyTitle => 'Nyilvános kulcs importálása';

  @override
  String get openpgpFromClipboard => 'Vágólapról';

  @override
  String get openpgpFromFile => 'Fájlból';

  @override
  String get openpgpClipboardEmpty => 'A vágólap üres. Előbb másold ki a kulcsot.';

  @override
  String get openpgpKey => 'Kulcs';

  @override
  String get openpgpValidityRevoked => 'Visszavonva';

  @override
  String openpgpValidityExpired(String date) {
    return 'Lejárt: $date';
  }

  @override
  String get openpgpNeverExpires => 'Soha nem jár le';

  @override
  String openpgpValidUntil(String date) {
    return 'Érvényes eddig: $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Ujjlenyomat másolva.';

  @override
  String get openpgpAlgorithm => 'Algoritmus';

  @override
  String get openpgpCreated => 'Létrehozva';

  @override
  String get openpgpValidity => 'Érvényesség';

  @override
  String get openpgpProtection => 'Védelem';

  @override
  String get openpgpProtectionPassphrase => 'Jelmondat';

  @override
  String get openpgpProtectionKeychain => 'Csak kulcstároló';

  @override
  String get openpgpKeyDetailsFooter =>
      'Oszd meg a nyilvános kulcsodat, hogy mások titkosítva írhassanak neked. A biztonsági mentés a titkos kulcsod, amelyet a jelmondata véd, ha van: tartsd titokban.';

  @override
  String get openpgpSharePublicKey => 'Nyilvános kulcs megosztása';

  @override
  String get openpgpCopyPublicKey => 'Nyilvános kulcs másolása';

  @override
  String get openpgpPublicKeyCopied => 'Nyilvános kulcs másolva.';

  @override
  String get openpgpBackUpSecretKey => 'Titkos kulcs mentése';

  @override
  String get openpgpDeleteKey => 'Kulcs törlése';

  @override
  String get openpgpRemoveKey => 'Kulcs eltávolítása';

  @override
  String get openpgpBackUpTitle => 'Elmented a titkos kulcsot?';

  @override
  String get openpgpBackUpProtected =>
      'A biztonsági mentést a kulcsod jelmondata védi. Aki mindkettőt megszerzi, elolvashatja a leveleidet.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ennek a kulcsnak nincs jelmondata: aki hozzáfér a mentéshez, elolvashatja a leveleidet, és a nevedben írhat alá.';

  @override
  String get openpgpBackUp => 'Mentés';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Törlöd ezt a kulcsodat: $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Eltávolítod $name kulcsát?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Az ehhez a kulcshoz titkosított leveleket ezen az eszközön többé nem tudod elolvasni, hacsak újra nem importálod.';

  @override
  String get openpgpRemoveKeyMessage => 'Később újra importálhatod.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-kulcs';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Adj hozzá egy kulcsot a Végpontok közötti titkosítás képernyőn, hogy titkosíthasd és aláírhasd az erről a címről küldött leveleket.';

  @override
  String get openpgpGenerateAKey => 'Kulcs létrehozása…';

  @override
  String get openpgpSending => 'Küldés';

  @override
  String get openpgpSendingFooter =>
      'Az automatikus titkosítás akkor kapcsol be, ha minden címzettnek van elfogadott kulcsa vagy megbízható tanúsítványa, vagy ha az Autocrypt szerint mindkét fél ezt szeretné. A titkosított levelek mindig alá vannak írva.';

  @override
  String get openpgpEncryptAutomatically => 'Automatikus titkosítás';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nem küld, ha egy címzettnek nincs kulcsa';

  @override
  String get openpgpSignUnencrypted => 'Titkosítatlan levelek aláírása';

  @override
  String get openpgpAttachPublicKey => 'Nyilvános kulcsom csatolása';

  @override
  String get openpgpAutocryptFooter =>
      'Az Autocrypt minden üzenettel elküldi a nyilvános kulcsodat, így más alkalmazások beállítás nélkül titkosítva írhatnak neked.';

  @override
  String get openpgpSendMyKey => 'Kulcsom küldése a levelekkel';

  @override
  String get openpgpPreferEncryption => 'Titkosítás előnyben részesítése';

  @override
  String get openpgpPreferEncryptionDetail => 'Arra kéri a többieket, hogy titkosítsanak, ha tudnak';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count év', one: '$count év');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'A jelmondatok nem egyeznek.';

  @override
  String openpgpKeyReady(String id) {
    return 'A kulcsod ($id) elkészült.';
  }

  @override
  String get openpgpNewKey => 'Új kulcs';

  @override
  String get openpgpNewKeyFor => 'Tulajdonos';

  @override
  String get openpgpYourName => 'Neved';

  @override
  String get openpgpAddress => 'Cím';

  @override
  String get openpgpPassphrase => 'Jelmondat';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Nem kötelező. Nélküle csak a telefonod kulcstárolója védi a kulcsot, és a Loupe soha nem kérdez rá. Ha megadod, a Loupe elkéri, amikor szükség van a kulcsra.';

  @override
  String get openpgpRepeatPassphrase => 'Ismét';

  @override
  String get openpgpExpires => 'Lejárat';

  @override
  String get openpgpExpiresFooter => 'Lejárat előtt létrehozhatsz egy új kulcsot. A Thunderbird is három évet használ.';

  @override
  String get openpgpGenerateKey => 'Kulcs létrehozása';

  @override
  String get openpgpKeyFor => 'Melyik címhez?';

  @override
  String get openpgpCantEncrypt => 'Nem lehet titkosítani';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nincs OpenPGP-kulcs a következőkhöz: $names, és ez a cím mindig titkosít. Távolítsd el a címzettet, vagy importáld a kulcsát itt: Beállítások › Végpontok közötti titkosítás.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nincs érvényes S/MIME-tanúsítvány a következőkhöz: $names, és ez a cím mindig titkosít. Távolítsd el a címzettet, vagy importáld a tanúsítványát itt: Beállítások › Végpontok közötti titkosítás.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nincs OpenPGP-kulcs a következőkhöz: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nincs érvényes S/MIME-tanúsítvány a következőkhöz: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Küldés titkosítás nélkül';

  @override
  String get openpgpCantSign => 'Nem lehet aláírni';

  @override
  String get openpgpCantSignMessage =>
      'Az S/MIME-tanúsítványod privát kulcsa nincs ezen az eszközön. Importáld újra a tanúsítványt (.p12 vagy .pfx fájl) itt: Beállítások › Végpontok közötti titkosítás.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nincs kulcs: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nincs tanúsítvány: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Kulcsok az Autocrypttől';

  @override
  String get openpgpComposeEveryoneHasKey => 'Mindenkinek van kulcsa';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Mindenkinek van tanúsítványa';

  @override
  String get openpgpComposeEncrypt => 'Titkosítás';

  @override
  String get openpgpComposeSign => 'Aláírás';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, váltás';
  }

  @override
  String get openpgpNoKeyFound => 'Nem található OpenPGP-kulcs.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importálod a titkos kulcsot?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Ez a melléklet egy titkos kulcsot tartalmaz ($names). Csak akkor importáld saját kulcsként, ha te magad exportáltad, például a Thunderbirdből.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importálás saját kulcsként';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'a saját kulcsod ($name)';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importálsz $count kulcsot ($names)?',
      one: 'Importálod $names kulcsát?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importálás és elfogadás';

  @override
  String get openpgpImportDecideLater => 'Importálás, döntés később';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name kulcsa';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importálva: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-kulcs van csatolva.',
      one: 'Egy OpenPGP-kulcs van csatolva.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importálás';

  @override
  String get openpgpUnlockKeyTitle => 'OpenPGP-kulcs feloldása';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Add meg $name kulcsának ($id) jelmondatát.';
  }

  @override
  String get openpgpWrongPassphrase => 'Hibás jelmondat. Próbáld újra.';

  @override
  String get openpgpExplainLocked => 'Ez az üzenet titkosított. Az elolvasásához oldd fel az OpenPGP-kulcsodat.';

  @override
  String get openpgpExplainNoKey =>
      'Ez az üzenet titkosított, de egyik, ezen az eszközön lévő OpenPGP-kulcshoz sem. Ha a Thunderbirdben olvasod, importáld onnan a kulcsodat: Beállítások › Végpontok közötti titkosítás.';

  @override
  String get openpgpExplainDamaged => 'Ez a titkosított üzenet sérült, ezért nem fejthető vissza biztonságosan.';

  @override
  String get openpgpExplainUnsupported =>
      'Ez az üzenet olyan titkosítást használ, amelyet a Loupe még nem tud olvasni.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ez az üzenet S/MIME-mal titkosított, de egyik, ezen az eszközön lévő tanúsítványhoz sem. Importáld a tanúsítványodat (.p12 vagy .pfx fájl) itt: Beállítások › Végpontok közötti titkosítás.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ez az üzenet titkosított. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Az elolvasásához oldd fel az S/MIME-tanúsítványodat.';

  @override
  String get openpgpAttachmentGone => 'Ez a melléklet már nem érhető el.';

  @override
  String get smimeEncrypted => 'Titkosított (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Titkosított (S/MIME) · nincs tanúsítvány';

  @override
  String get smimeEncryptedDamaged => 'Titkosított (S/MIME) · sérült';

  @override
  String get smimeEncryptedUnsupported => 'Titkosított (S/MIME) · nem támogatott';

  @override
  String get smimeEncryptedLocked => 'Titkosított (S/MIME) · zárolt';

  @override
  String get smimeUnknownSigner => 'ismeretlen';

  @override
  String get smimeSignatureModified => 'Érvénytelen aláírás: az üzenet módosult';

  @override
  String get smimeSignatureWeak => 'Nem biztonságos aláírás: elavult algoritmus';

  @override
  String get smimeSignatureUncheckable => 'Az aláírás nem ellenőrizhető';

  @override
  String get smimeSignedCertificateMissing => 'Aláírva · hiányzik a tanúsítvány';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Aláírta: $name · visszavont tanúsítvány';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Aláírta: $name · más időpontban';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Aláírta: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Aláírta: $name · érvénytelen tanúsítvány';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Aláírta: $name · nem megbízható';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Aláírta: $name · lejárt tanúsítvány';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Aláírta: $name · a tanúsítvány még nem érvényes';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Aláírta: $name · a tanúsítvány nem levelezéshez való';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Aláírta: $name, nem a feladó';
  }

  @override
  String get smimeCantDecrypt => 'Ez az üzenet nem fejthető vissza';

  @override
  String get smimeEncryptedWithSmime => 'S/MIME-mal titkosítva';

  @override
  String get smimeEncryption => 'Titkosítás';

  @override
  String get smimeDecryptedHere => 'Ezen az eszközön visszafejtve';

  @override
  String get smimeNotDecrypted => 'Nincs visszafejtve';

  @override
  String get smimeAuthenticated => 'hitelesített';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tanúsítványhoz',
      one: '$count tanúsítványhoz',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Aláírás';

  @override
  String get smimeIssuedBy => 'Kibocsátó';

  @override
  String get smimeValid => 'Érvényes';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 ujjlenyomat';

  @override
  String get smimeSigned => 'Aláírva';

  @override
  String get smimeProblem => 'Probléma';

  @override
  String get smimeCheckingRevocation => 'Visszavonás ellenőrzése…';

  @override
  String get smimeNotRevoked => 'Nincs visszavonva';

  @override
  String get smimeRevoked => 'Visszavonva';

  @override
  String get smimeRevocationUnknown => 'Visszavonási állapot ismeretlen';

  @override
  String smimeRevokedSince(String date) {
    return 'Ekkor óta: $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Lekérdezve a hitelesítésszolgáltatótól (visszavonási lista), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Lekérdezve a hitelesítésszolgáltatótól (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return '„$name” megbízhatónak jelölése…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Tanúsítvány megbízhatónak jelölése…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Ezen az eszközön ellenőrizve S/MIME-mal, az Outlookkal és a Thunderbirddel kompatibilis módon; a visszavonást a hitelesítésszolgáltatónál ellenőrizte.';

  @override
  String get smimeCheckedFooter =>
      'Ezen az eszközön ellenőrizve S/MIME-mal, az Outlookkal és a Thunderbirddel kompatibilis módon. A visszavonás nincs ellenőrizve (Beállítások › Végpontok közötti titkosítás).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Megbízhatónak jelölöd levelezéshez: $name?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Megbízhatónak jelölöd $name tanúsítványát?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Ennek a szolgáltatónak minden kiadott tanúsítványa megbízható lesz, mint a céged hitelesítésszolgáltatójáé. Előbb hasonlítsd össze az ujjlenyomatot a tulajdonosával:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Előbb hasonlítsd össze az ujjlenyomatot a tulajdonosával:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Megbízható';

  @override
  String get smimeSummaryNoKey => 'Olyan tanúsítványhoz titkosították, amely nincs ezen az eszközön.';

  @override
  String get smimeSummaryDamaged => 'A titkosított adat sérült, vagy útközben módosult.';

  @override
  String get smimeSummaryUnsupported => 'Olyan algoritmust használ, amelyet a Loupe nem támogat.';

  @override
  String get smimeSummaryLocked => 'Az S/MIME-tanúsítványod zárolva van.';

  @override
  String get smimeSummaryEncrypted => 'Csak te és a többi címzett olvashatja.';

  @override
  String get smimeSummaryNotSigned => 'Nincs aláírva, így a feladó nincs megerősítve.';

  @override
  String get smimeSummaryModified => 'Az aláírás nem egyezik: az üzenetet az aláírás után módosították.';

  @override
  String get smimeSummaryUncheckable => 'Az aláírás nem ellenőrizhető.';

  @override
  String get smimeSummaryNoCertificate => 'Az aláíró tanúsítványa nincs az üzenetben, így nem ellenőrizhető.';

  @override
  String get smimeSummaryRevoked =>
      'A hitelesítésszolgáltató visszavonta az aláíró tanúsítványát: az aláírás nem megbízható.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'A hitelesítésszolgáltató visszavonta az aláíró tanúsítványát ($reason): az aláírás nem megbízható.';
  }

  @override
  String get smimeDateMismatch =>
      'Az aláírás ideje több mint egy órával eltér az üzenet dátumától: lehet, hogy egy régi üzenetet küldtek el újra.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Az aláírás érvényes, és $issuer szavatolja, hogy a tanúsítvány a feladóé.';
  }

  @override
  String get smimeProblemInvalidChain => 'A tanúsítvány vagy valamelyik kibocsátója érvénytelen.';

  @override
  String get smimeProblemUntrusted => 'A tanúsítvány olyan szolgáltatótól származik, amelyben a Loupe nem bízik meg.';

  @override
  String get smimeProblemExpired => 'A tanúsítvány lejárt.';

  @override
  String get smimeProblemNotYetValid => 'A tanúsítvány még nem volt érvényes.';

  @override
  String get smimeProblemWrongUsage => 'A tanúsítvány nem levelezéshez való.';

  @override
  String get smimeProblemWrongAddress => 'A tanúsítvány nem a feladó címéhez, hanem egy másik címhez tartozik.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Megbízható · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nem megbízható · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Lejárt: $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Érvényes ettől: $date';
  }

  @override
  String get smimeTrustInvalid => 'Érvénytelen';

  @override
  String get smimeTrustNotForMail => 'Nem levelezéshez';

  @override
  String get smimeTrustAnotherAddress => 'Másik cím';

  @override
  String get smimeMyCertificates => 'Saját S/MIME-tanúsítványaim';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME-hoz, ahogy az Outlook és sok cég használja. Importáld a tanúsítványodat a privát kulcsával együtt (.p12 vagy .pfx fájl), amelyet az Outlookból, a Windowsból, a macOS-ből vagy a Thunderbirdből exportáltál.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME-hoz, ahogy az Outlook és sok cég használja. Importáld a tanúsítványodat a privát kulcsával együtt (.p12 vagy .pfx fájl), amelyet az Outlookból, a Windowsból, a macOS-ből vagy a Thunderbirdből exportáltál, vagy használj egy olyat, amelyet a céged vagy te telepítettél erre az eszközre.';

  @override
  String get smimeCertificateExpired => 'lejárt';

  @override
  String smimeCertificateUntil(String date) {
    return 'eddig: $date';
  }

  @override
  String get smimeCertificateOnDevice => 'ezen az eszközön';

  @override
  String get smimeImportCertificateEllipsis => 'Tanúsítvány importálása…';

  @override
  String get smimeUseDeviceCertificate => 'Tanúsítvány használata erről az eszközről…';

  @override
  String get smimeCorrespondentsCertificates => 'Levelezőpartnerek tanúsítványai';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Aláírt levelekből gyűjtve, ahogy az Outlook és a Thunderbird is teszi. A levelek csak megbízható tanúsítványokhoz titkosítódnak: a Loupe azokban a hitelesítésszolgáltatókban bízik meg, amelyekben a Mozilla az e-mailek terén megbízik, valamint azokban, amelyeket te adsz hozzá.';

  @override
  String get smimeRevocation => 'Visszavonás';

  @override
  String get smimeRevocationFooter =>
      'Amikor aláírt levelet nyitsz meg, a Loupe megkérdezi az aláíró tanúsítványát kiadó szolgáltatót (az OCSP-válaszolóját vagy a visszavonási listáját), hogy visszavonták-e. A szolgáltató így láthatja, mikor olvas valaki a te internetcímedről az adott tanúsítvánnyal aláírt levelet. A válaszok a lejáratukig ezen az eszközön maradnak. A visszavont tanúsítványt az üzenet fejléce „visszavont tanúsítvány” jelzéssel mutatja.';

  @override
  String get smimeCheckRevocation => 'Tanúsítványok visszavonásának online ellenőrzése';

  @override
  String get smimeTrustedAuthorities => 'Megbízható hitelesítésszolgáltatók';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Általad megbízhatónak jelöltek, azon $count mellett, amelyekben a Mozilla az e-mailek terén megbízik.',
      one: 'Általad megbízhatónak jelöltek, azon $count mellett, amelyben a Mozilla az e-mailek terén megbízik.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Hitelesítésszolgáltató';

  @override
  String get smimeImportACertificate => 'Tanúsítvány importálása';

  @override
  String get smimeImportContactMessage =>
      'Egy levelezőpartner tanúsítványa (.cer, .crt, .pem) vagy egy hitelesítésszolgáltatóé.';

  @override
  String get smimeFromClipboard => 'Vágólapról';

  @override
  String get smimeFromFile => 'Fájlból';

  @override
  String get smimeClipboardEmpty => 'A vágólap üres. Előbb másold ki a tanúsítványt.';

  @override
  String get smimeCertificate => 'Tanúsítvány';

  @override
  String get smimeOnDeviceFooter =>
      'A privát kulcsa az Android hitelesítésiadat-tárolójában marad, ahová a céged vagy te telepítetted: a Loupe az Androidot kéri meg, hogy aláírjon és visszafejtsen vele. Az aláírt levelek a küldéskor kapják meg az aláírást.';

  @override
  String get smimeAddresses => 'Címek';

  @override
  String get smimeUsage => 'Felhasználás';

  @override
  String get smimeUsageNone => 'Semmi, amit a Loupe használ';

  @override
  String get smimeUsageSigning => 'Aláírás';

  @override
  String get smimeUsageEncryption => 'Titkosítás';

  @override
  String get smimeUsageCertificates => 'Tanúsítványok';

  @override
  String get smimeAlgorithm => 'Algoritmus';

  @override
  String get smimeSerialNumber => 'Sorozatszám';

  @override
  String get smimeFingerprintCopied => 'Ujjlenyomat másolva.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 ujjlenyomat';

  @override
  String get smimePrivateKey => 'Privát kulcs';

  @override
  String get smimeKeyOnDevice => 'Ezen az eszközön';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'A Loupe-ban, jelmondattal';

  @override
  String get smimeKeyInLoupe => 'A Loupe-ban';

  @override
  String get smimeSource => 'Forrás';

  @override
  String get smimeSourceSignedMail => 'Aláírt levél';

  @override
  String get smimeSourceImported => 'Importálva';

  @override
  String get smimeTrustHeader => 'Megbízhatóság';

  @override
  String get smimeTrustedRoot => 'Megbízható gyökér';

  @override
  String get smimeIssuer => 'Kibocsátó';

  @override
  String smimeTrustNamed(String name) {
    return '„$name” megbízhatónak jelölése';
  }

  @override
  String get smimeTrustThisAuthority => 'Szolgáltató megbízhatónak jelölése';

  @override
  String get smimeTrustThisCertificate => 'Tanúsítvány megbízhatónak jelölése';

  @override
  String get smimeStopTrusting => 'Megbízhatóság visszavonása';

  @override
  String get smimePassphrase => 'Jelmondat';

  @override
  String get smimePassphraseFooter =>
      'Nem kötelező. Jelmondattal a privát kulcs ezen az eszközön is titkosítva van (Argon2id és AES-256), és a Loupe aláíráshoz és visszafejtéshez elkéri; hogy mennyi ideig, azt a Jelmondatok megjegyzése beállítás határozza meg. Az általad küldött levelek a küldéskor kapják meg az aláírást; háttérfolyamatok nem használhatják a kulcsot.';

  @override
  String get smimeChangePassphrase => 'Jelmondat módosítása…';

  @override
  String get smimeSetPassphraseEllipsis => 'Jelmondat beállítása…';

  @override
  String get smimeRemovePassphrase => 'Jelmondat eltávolítása';

  @override
  String get smimeShareCertificate => 'Tanúsítvány megosztása';

  @override
  String get smimeDeleteCertificate => 'Tanúsítvány törlése';

  @override
  String get smimeRemoveCertificate => 'Tanúsítvány eltávolítása';

  @override
  String get smimePassphraseChanged => 'Jelmondat módosítva.';

  @override
  String get smimePassphraseSet => 'Jelmondat beállítva.';

  @override
  String get smimeRemovePassphraseTitle => 'Eltávolítod a jelmondatot?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Ezután a privát kulcsot csak a kulcstároló védi, mint jelmondat nélkül: a Loupe nem kéri többé, és háttérfolyamatok is használhatják.';

  @override
  String get smimePassphraseRemoved => 'Jelmondat eltávolítva.';

  @override
  String smimeTrustTitle(String name) {
    return 'Megbízhatónak jelölöd: $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Minden általa kiadott tanúsítvány megbízható lesz a levelezésben. Előbb hasonlítsd össze az ujjlenyomatot a tulajdonosával:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Törlöd ezt a tanúsítványodat: $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Eltávolítod $name tanúsítványát?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'A Loupe nem használja tovább: a hozzá titkosított levelek a Loupe-ban többé nem olvashatók. A tanúsítvány az eszközön marad (Beállítások › Biztonság › Titkosítás és hitelesítési adatok).';

  @override
  String get smimeDeleteOwnMessage =>
      'A privát kulcsa törlődik erről az eszközről: a hozzá titkosított levelek itt többé nem olvashatók, hacsak újra nem importálod.';

  @override
  String get smimeRemoveContactMessage => 'A partner következő aláírt üzenetével visszakerül.';

  @override
  String get smimeAddressImportFooter =>
      'Importálj egy tanúsítványt ehhez a címhez, hogy S/MIME-mal írhass alá és titkosíthass, ahogy az Outlook is.';

  @override
  String get smimeImportACertificateEllipsis => 'Tanúsítvány importálása…';

  @override
  String get smimePreferFooter =>
      'Ha mindkettő védhetné az üzenetet, az előnyben részesített lesz használva, kivéve, ha csak a másiknak van kulcsa vagy tanúsítványa minden címzetthez.';

  @override
  String get smimePreferSmime => 'S/MIME előnyben részesítése';

  @override
  String get smimePreferSmimeDetail => 'Az OpenPGP helyett';

  @override
  String get smimeCertificatePassword => 'Tanúsítvány jelszava';

  @override
  String get smimeCertificatePasswordPrompt => 'Add meg a jelszót, amellyel a tanúsítványfájlt exportálták.';

  @override
  String get smimeImport => 'Importálás';

  @override
  String get smimeWrongPassword => 'Hibás jelszó. Próbáld újra.';

  @override
  String get smimeNoCertificateFound => 'Nem található tanúsítvány.';

  @override
  String smimeCertificateOf(String name) {
    return '$name tanúsítványa';
  }

  @override
  String get smimeNothingNew => 'Nincs új importálnivaló.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importálva: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count megbízható hitelesítésszolgáltató importálva.',
      one: 'Egy megbízható hitelesítésszolgáltató importálva.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importálva: $certificates és $count megbízható hitelesítésszolgáltató.',
      one: 'Importálva: $certificates és egy megbízható hitelesítésszolgáltató.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Ebben a fájlban nincs privát kulcs. Exportáld a tanúsítványodat a privát kulcsával együtt.';

  @override
  String get smimeImportAsYoursTitle => 'Importálod saját tanúsítványként?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Ez a melléklet egy tanúsítványt tartalmaz a privát kulcsával: $names. Csak akkor importáld, ha te magad exportáltad, például az Outlookból vagy a Thunderbirdből.';
  }

  @override
  String get smimeImportAsMine => 'Importálás saját tanúsítványként';

  @override
  String smimeImportedOwn(String names) {
    return 'Saját tanúsítvány importálva: $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Saját tanúsítvány hozzáadva erről az eszközről: $name ($addresses).';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Megbízhatónak jelölöd levelezéshez: „$name”?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'A Loupe nem ismeri ezt a hitelesítésszolgáltatót (talán egy cég sajátja). Jelöld megbízhatónak, hogy ellenőrizni lehessen az általa kiadott tanúsítványokat. Előbb hasonlítsd össze az ujjlenyomatát az informatikai részlegeddel:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tanúsítvány van csatolva.',
      one: 'Egy tanúsítvány van csatolva.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Tanúsítvány importálása';

  @override
  String get smimeUnlockTitle => 'S/MIME-tanúsítvány feloldása';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Add meg $name tanúsítványának ($addresses) jelmondatát.';
  }

  @override
  String get smimeWrongPassphrase => 'Hibás jelmondat. Próbáld újra.';

  @override
  String get smimeUnlock => 'Feloldás';

  @override
  String get smimeEnterAPassphrase => 'Adj meg egy jelmondatot.';

  @override
  String get smimePassphrasesDiffer => 'A két jelmondat eltér.';

  @override
  String get smimeSetPassphraseTitle => 'Jelmondat beállítása';

  @override
  String get smimeSetPassphraseText =>
      'A Loupe aláíráshoz és visszafejtéshez elkéri. Ha elfelejted, importáld újra a tanúsítványt a .p12 fájljából.';

  @override
  String get smimePassphraseAgain => 'Ismét';

  @override
  String get smimeSetPassphraseButton => 'Beállítás';

  @override
  String get smimeLockedOpenAgain => 'Az S/MIME-tanúsítványod zárolva van. A feloldáshoz nyisd meg újra az üzenetet.';

  @override
  String get smimeDeviceHasNoCertificates => 'Ez az eszköz nem kínálja fel a tanúsítványait.';

  @override
  String get smimeCantReadCertificate => 'A Loupe nem tudja beolvasni ezt a tanúsítványt.';

  @override
  String get smimeCertificateNotForMail =>
      'Ez a tanúsítvány nem levelezéshez való: nincs benne e-mail-cím, vagy nem aláírásra, illetve titkosításra szolgál.';

  @override
  String get smimeDeviceCertificateGone =>
      'A tanúsítvány már nincs ezen az eszközön, vagy a Loupe már nem használhatja. Válaszd ki újra itt: Beállítások › Végpontok közötti titkosítás.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Az eszközön lévő tanúsítvány csak akkor használható, ha a Loupe meg van nyitva.';

  @override
  String get smimeDeviceKeyDamaged => 'A titkosított kulcs sérült.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Az eszközön lévő tanúsítvány erre nem képes: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nem támogatott';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Az eszközön lévő tanúsítvány hibát jelzett: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'A szolgáltató címe nem webcím.';

  @override
  String get smimeAuthorityTimeout => 'A hitelesítésszolgáltató nem válaszolt időben.';

  @override
  String get smimeAuthorityUnreachable => 'A hitelesítésszolgáltató nem érhető el.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'A hitelesítésszolgáltató válasza: $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'A hitelesítésszolgáltató válasza túl nagy.';

  @override
  String get smimeRevocationNotChecked =>
      'Nincs ellenőrizve: csak a Loupe által megbízhatónak tartott szolgáltatóktól származó tanúsítványok ellenőrzése történik meg.';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get settingsLanguageSystem => 'A telefonnal azonos';

  @override
  String get settingsLanguageFooter =>
      'A Loupe a telefonod nyelvét használja, ha elérhető, egyébként az angolt. Az itt kiválasztott nyelv csak a Loupe-ra vonatkozik, az értesítéseket is beleértve.';

  @override
  String get settingsAccountsHeader => 'Fiókok';

  @override
  String get settingsAddAccount => 'Fiók hozzáadása';

  @override
  String get settingsMailHeader => 'Levelezés';

  @override
  String get settingsSwipeActions => 'Csúsztatási műveletek';

  @override
  String get settingsSwipeLeft => 'Csúsztatás balra';

  @override
  String get settingsSwipeLeftFooter =>
      'Teljes csúsztatással ez a művelet fut le. A Megjelölés és a Továbbiak mindig elérhető egy rövid csúsztatással.';

  @override
  String get settingsSwipeRight => 'Csúsztatás jobbra';

  @override
  String get settingsSwipeRightFooter => 'Teljes csúsztatással ez a művelet fut le.';

  @override
  String get settingsSwipeToggleRead => 'Megjelölés olvasottként / olvasatlanként';

  @override
  String get settingsSwipeTrash => 'Kukába';

  @override
  String get settingsSwipeMove => 'Üzenet áthelyezése';

  @override
  String get settingsSwipeSnooze => 'Szundi';

  @override
  String get settingsThreaded => 'Rendezés beszélgetések szerint';

  @override
  String get settingsUndoSendDelay => 'Küldés visszavonásának ideje';

  @override
  String get settingsUndoSendDelayFooter => 'Az elküldött üzenetek ennyi ideig várnak, így visszavonhatod őket.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds másodperc',
      one: '$seconds másodperc',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Megjelenés';

  @override
  String get settingsTheme => 'Téma';

  @override
  String get settingsThemeSystem => 'Automatikus';

  @override
  String get settingsThemeLight => 'Világos';

  @override
  String get settingsThemeDark => 'Sötét';

  @override
  String get settingsDensity => 'Üzenetlista';

  @override
  String get settingsDensityComfortable => 'Tágas';

  @override
  String get settingsDensityCompact => 'Tömör';

  @override
  String get settingsReadingHeader => 'Olvasás';

  @override
  String get settingsReadingFooter =>
      'A távoli képek elárulhatják a feladóknak, mikor és hol nyitottál meg egy üzenetet.';

  @override
  String get settingsDefaultView => 'Alapértelmezett nézet';

  @override
  String get settingsDefaultViewFooter => 'Bármelyik üzenet nézetét átválthatod az Aa gombbal.';

  @override
  String get settingsViewReadable => 'Olvasóbarát';

  @override
  String get settingsViewReadableDetail => 'Tiszta, jól olvasható, követi a sötét módot';

  @override
  String get settingsViewOriginal => 'Eredeti';

  @override
  String get settingsViewOriginalDetail => 'Pontosan úgy, ahogy a feladó megtervezte';

  @override
  String get settingsViewPlain => 'Egyszerű szöveg';

  @override
  String get settingsViewPlainDetail => 'Csak a szöveg';

  @override
  String get settingsPlainTextFont => 'Egyszerű szöveg betűtípusa';

  @override
  String get settingsFontSans => 'Talpatlan';

  @override
  String get settingsFontMono => 'Rögzített szélességű';

  @override
  String get settingsFontMonoDetail => 'Az ASCII-rajzok és a táblázatok nem csúsznak szét';

  @override
  String get settingsTechnicalLists => 'Technikai listák';

  @override
  String get settingsLoadRemoteImages => 'Távoli képek betöltése';

  @override
  String get settingsOpenLinksDirectly => 'Linkek közvetlen megnyitása';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Kattintáskövetők kihagyása, ha a cél ismert';

  @override
  String get settingsSecurityHeader => 'Biztonság';

  @override
  String get settingsAppLock => 'Alkalmazászár';

  @override
  String get settingsAppLockFooterOn =>
      'A Loupe induláskor kéri, és akkor is, ha az Automatikus zárolásnál beállított időnél tovább voltál távol.';

  @override
  String get settingsAppLockFooterOff =>
      'Az alkalmazászár az ujjlenyomatodat, az arcodat vagy a képernyőzárat kéri, mielőtt a leveleid megjelennek.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Az alkalmazászár továbbra is ki van kapcsolva. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Állíts be jelkódot';

  @override
  String get settingsScreenLockTextIos =>
      'Az alkalmazászár a Face ID-t, a Touch ID-t vagy a jelkódodat használja, de ezen az iPhone-on nincs jelkód. Állíts be egyet a Beállítások appban, majd kapcsold be az alkalmazászárat.';

  @override
  String get settingsScreenLockTitleAndroid => 'Állíts be képernyőzárat';

  @override
  String get settingsScreenLockTextAndroid =>
      'Az alkalmazászár a telefon képernyőzárát, vagy az ahhoz hozzáadott ujjlenyomatot vagy arcot használja, de ezen a telefonon nincs ilyen. Állíts be PIN-kódot, mintát vagy jelszót az Android beállításaiban, majd kapcsold be az alkalmazászárat.';

  @override
  String get settingsOpenSystemSettings => 'Beállítások megnyitása';

  @override
  String get settingsOpenAndroidSettings => 'Android-beállítások megnyitása';

  @override
  String get settingsLockAfter => 'Automatikus zárolás';

  @override
  String get settingsLockAfterFooter => 'Mennyi ideig lehet a Loupe a háttérben, mielőtt újra kérdez.';

  @override
  String get settingsNotifications => 'Értesítések';

  @override
  String get settingsEncryption => 'Végpontok közötti titkosítás';

  @override
  String get settingsAdvanced => 'Speciális';

  @override
  String get settingsDemoHeader => 'Demó';

  @override
  String get settingsDemoFooter =>
      'A demó levelezés egy kitalált postafiók, amely csak ezen a telefonon létezik. Semmi sem kerül elküldésre.';

  @override
  String get settingsDemoMode => 'Demó mód';

  @override
  String get settingsResetApp => 'Alkalmazás visszaállítása';

  @override
  String get settingsResetFooter => 'Elfelejti az összes beállítást, és visszatér az üdvözlőképernyőre.';

  @override
  String get settingsResetTitle => 'Visszaállítod a Loupe-ot?';

  @override
  String get settingsResetMessage =>
      'Ez elfelejti az összes beállítást, Smart Mailboxot és legutóbbi keresést, és visszatér az üdvözlőképernyőre.';

  @override
  String get settingsAboutHeader => 'Névjegy';

  @override
  String get settingsVersion => 'Verzió';

  @override
  String get settingsLicences => 'Licencek';

  @override
  String get settingsPrivacy => 'Adatvédelem';

  @override
  String get settingsPrivacyDetail =>
      'A Loupe nem használ analitikát, és nem követ. A leveleid csak a levelezőszervereidre jutnak el.';

  @override
  String get settingsNotificationsOffIos => 'A Loupe értesítései ki vannak kapcsolva a Beállításokban.';

  @override
  String get settingsNotificationsOffAndroid => 'A Loupe értesítései ki vannak kapcsolva az Android beállításaiban.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nem engedi, hogy a Loupe értesítéseket jelenítsen meg. Engedélyezd őket a Beállításokban.';
  }

  @override
  String get settingsNewMailHeader => 'Új levelek';

  @override
  String get settingsNewMailFooterDemo =>
      'A demó levelek nem érkeznek a háttérben. Küldj egy tesztértesítést, hogy lásd, hogyan néz ki egy új levél.';

  @override
  String get settingsNewMailFooterIos =>
      'A Loupe akkor keres új leveleket a háttérben, amikor az iOS engedi; a ritkán megnyitott appoknál ez órákig is eltarthat. Értesítést kapsz a beérkező leveleid közé érkező új üzenetekről, és a VIP-ek üzeneteiről bármely mappában.';

  @override
  String get settingsNewMailFooterAndroid =>
      'A Loupe körülbelül 15 percenként keres új leveleket, amikor az Android engedi. Értesítést kapsz a beérkező leveleid közé érkező új üzenetekről, és a VIP-ek üzeneteiről bármely mappában.';

  @override
  String get settingsNoAccounts => 'Nincsenek fiókok';

  @override
  String get settingsVipOnly => 'Csak VIP';

  @override
  String get settingsVipOnlyDetail => 'Csak a VIP-jeid üzenetei';

  @override
  String get settingsHideContent => 'Tartalom elrejtése';

  @override
  String get settingsHideContentFooterOn =>
      'Az értesítések csak annyit írnak: „Új üzenet”, és a fiókot, azt nem, hogy ki írt vagy miről.';

  @override
  String get settingsHideContentFooterOff =>
      'A Tartalom elrejtése távol tartja a feladót, a tárgyat és az előnézetet a zárolási képernyőtől és az értesítésektől.';

  @override
  String get settingsBackgroundAppRefresh => 'Háttérben frissítés';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Új levelek csak akkor érkeznek a háttérben, ha a Háttérben frissítés be van kapcsolva a Loupe számára a Beállításokban. Az iOS nem tud nyitott kapcsolatot tartani a postafiókjaiddal, ezért nincs Azonnali kézbesítés.';

  @override
  String get settingsInstantDelivery => 'Azonnali kézbesítés';

  @override
  String get settingsInstantDeliveryFooter =>
      'Az Azonnali kézbesítés (kísérleti) nyitott kapcsolatot tart a postafiókjaiddal, így az új levelek másodperceken belül megérkeznek. Egy csendes „Új levelek figyelése” értesítést jelenít meg, és több akkumulátort használ.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Az Android az akkumulátor kímélése érdekében leállíthatja az Azonnali kézbesítést. Engedd, hogy a Loupe korlátozás nélkül használja az akkumulátort, hogy folyamatosan fusson.';

  @override
  String get settingsExperimental => 'Kísérleti';

  @override
  String get settingsComingSoon => 'Hamarosan';

  @override
  String get settingsAllowUnrestrictedBattery => 'Korlátlan akkumulátorhasználat engedélyezése';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'A push révén az új levelek azonnal felébresztik a Loupe-ot, ha a levelezési szolgáltatásod támogatja. A push-értesítések a Google push-szolgáltatásán keresztül érkeznek, és nem tartalmaznak levelet, csak annyit: „nézz rá most”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ez a telefon nem tud push-értesítéseket fogadni: ehhez Google Play-szolgáltatások és hálózati kapcsolat kell. A Loupe továbbra is körülbelül 15 percenként keres új leveleket.';

  @override
  String get settingsCopyPushToken => 'Push-token másolása';

  @override
  String get settingsPushTokenCopied => 'Push-token másolva';

  @override
  String get settingsSendTestNotification => 'Tesztértesítés küldése';

  @override
  String get settingsAppIconBadge => 'Alkalmazásikon-jelvény';

  @override
  String get settingsBadgeNote => 'A jelvény minden levélellenőrzéskor frissül, a háttérben is.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'A telefon kezdőképernyője nem jelenít meg számokat az alkalmazásikonokon. A jelvény minden levélellenőrzéskor frissül, a háttérben is.';

  @override
  String get settingsTestNotificationBody => 'Az új levelek értesítései így néznek ki.';

  @override
  String get settingsAccountRemoved => 'Ezt a fiókot eltávolították.';

  @override
  String get settingsAccountHeader => 'Fiók';

  @override
  String get settingsAccountDescription => 'Leírás';

  @override
  String get settingsAccountDescriptionHint => 'Munka, személyes…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Szín';

  @override
  String get settingsColourFooter => 'Ezzel jelöli a fiók üzeneteit az Összes beérkező levél nézetben.';

  @override
  String settingsColourNumber(int number) {
    return '$number. szín';
  }

  @override
  String get settingsSendingHeader => 'Küldés';

  @override
  String get settingsSendingFooter =>
      'Minden identitásnak saját aláírása van. A válaszok arról a címről mennek ki, amelyre az üzenetet küldték.';

  @override
  String get settingsFoldersHeader => 'Mappák';

  @override
  String get settingsFoldersFooter =>
      'A Loupe azokat a mappákat mutatja és szinkronizálja, amelyekre feliratkoztál, ahogy a Thunderbird is. A Beérkező levelek, a Piszkozatok, az Elküldött, a Levélszemét, a Kuka és az Archívum mindig látható.';

  @override
  String get settingsShowAllFolders => 'Összes mappa megjelenítése';

  @override
  String get settingsIncoming => 'Bejövő';

  @override
  String get settingsOutgoing => 'Kimenő';

  @override
  String get settingsConnectionNotEncrypted => 'Nem titkosított';

  @override
  String get settingsSignIn => 'Bejelentkezés';

  @override
  String get settingsSignInExpired => 'Lejárt';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider már nem fogadja el a Loupe bejelentkezését ehhez a fiókhoz, ezért a levelei nem szinkronizálódnak. A javításhoz jelentkezz be újra.';
  }

  @override
  String get settingsSignInAgain => 'Újbóli bejelentkezés';

  @override
  String get settingsSigningIn => 'Bejelentkezés…';

  @override
  String get settingsRemoveAccount => 'Fiók eltávolítása';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Eltávolítod: „$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'A levelei és a beállításai törlődnek erről a telefonról. A szerveren semmi sem törlődik.';

  @override
  String get settingsManageFolders => 'Mappák kezelése';

  @override
  String get settingsNoFolders => 'Még nincsenek mappák.';

  @override
  String get settingsManageFoldersFooter =>
      'A feliratkozott mappák megjelennek a Postafiókok képernyőn, és a háttérben szinkronizálódnak. Az ugyanazt a fiókot használó más levelezőalkalmazások általában szintén követik ezeket a feliratkozásokat.';

  @override
  String get settingsSmartMailboxesFolder =>
      'A Smart Mailboxaidat tárolja a többi eszközöd számára. A Postafiókok képernyőn rejtve marad.';

  @override
  String get settingsFolderAlwaysShown => 'Mindig látható';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Feliratkozás: $folder';
  }

  @override
  String get settingsIdentities => 'Identitások';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Az első identitás az új üzenetek alapértelmezett identitása. Húzással módosíthatod a sorrendet.';

  @override
  String get settingsIdentitiesFooterSingle => 'Az új üzenetek alapértelmezett identitása.';

  @override
  String get settingsIdentitiesReplyFooter => 'A válasz abból az identitásból megy ki, amelyre az üzenetet küldték.';

  @override
  String get settingsIdentityDefault => 'Alapértelmezett';

  @override
  String settingsIdentityReorder(String email) {
    return '$email áthelyezése';
  }

  @override
  String get settingsAddIdentity => 'Identitás hozzáadása';

  @override
  String get settingsNewIdentity => 'Új identitás';

  @override
  String get settingsIdentity => 'Identitás';

  @override
  String get settingsIdentityNameHint => 'Neved';

  @override
  String get settingsReplyTo => 'Válaszcím';

  @override
  String get settingsSignature => 'Aláírás';

  @override
  String get settingsSignatureFooter => 'A „-- ” alá kerül az ebből az identitásból küldött üzenetekben.';

  @override
  String get settingsNoSignature => 'Nincs aláírás';

  @override
  String get settingsCopyToMyself => 'Másolat magamnak';

  @override
  String get settingsCopyToMyselfFooter => 'Az ebből az identitásból küldött minden üzenethez hozzáadódik.';

  @override
  String get settingsCc => 'Másolat';

  @override
  String get settingsBcc => 'Titkos másolat';

  @override
  String get settingsReplyPatterns => 'Használat ezekre adott válaszokhoz';

  @override
  String get settingsReplyPatternsFooter =>
      'Az ezekre a címekre küldött üzenetekre adott válaszok ebből az identitásból mennek ki. A * bármit jelent: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Egy cím, vagy egy minta, amelyben a * bármit jelent.';

  @override
  String get settingsAddReplyPattern => 'Cím vagy minta hozzáadása';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return '$pattern eltávolítása';
  }

  @override
  String get settingsInvalidPatternTitle => 'Érvénytelen minta';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input” nem cím, és nem is *@example.com-hoz hasonló minta.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nincs cím';

  @override
  String get settingsIdentityNoAddressMessage => 'Add meg az e-mail-címet, amelyről küldeni szeretnél.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Érvénytelen cím';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'A válaszcím („$address”) nem érvényes e-mail-cím.',
      'cc': 'A másolat címe („$address”) nem érvényes e-mail-cím.',
      'bcc': 'A titkos másolat címe („$address”) nem érvényes e-mail-cím.',
      'other': '„$address” nem érvényes e-mail-cím.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Identitás mentése';

  @override
  String get settingsDiscardChanges => 'Módosítások elvetése';

  @override
  String get settingsDeleteIdentity => 'Identitás törlése';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Törlöd: „$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Az erről a címről már elküldött üzenetek változatlanok maradnak.';

  @override
  String get settingsLastIdentityFooter => 'Egy fióknak legalább egy identitásra van szüksége.';

  @override
  String get rulesTitle => 'Szabályok';

  @override
  String get rulesNewRule => 'Új szabály';

  @override
  String get rulesLoadError => 'Nem sikerült betölteni a szabályokat.';

  @override
  String get rulesEmptyTitle => 'Nincsenek szabályok';

  @override
  String get rulesEmptyText =>
      'A szabályok helyetted rendezik el, címkézik fel és jelölik meg az új leveleket. Hozz létre egyet a fenti írás gombbal, vagy egy keresésből a „Szabály létrehozása ebből” paranccsal.';

  @override
  String get rulesListFooter =>
      'A szabályok fentről lefelé futnak le a Beérkező levelek új leveleire. Egy szabály áthelyezéséhez tartsd lenyomva.';

  @override
  String get rulesChangeError => 'Nem sikerült módosítani a szabályt';

  @override
  String get rulesConditionEveryMessage => 'Minden üzenet';

  @override
  String rulesMoveRule(String rule) {
    return '$rule áthelyezése';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule bekapcsolva';
  }

  @override
  String get rulesServerRulesHeader => 'Szerveroldali szabályok';

  @override
  String get rulesServerRulesFooter =>
      'A szerveroldali szabályok a levelezőszerveren futnak le a levelek érkezésekor, akkor is, ha ez a telefon ki van kapcsolva. Egy „loupe” nevű Sieve-szkriptben tárolódnak.';

  @override
  String get rulesStatusUnknown => 'Ismeretlen';

  @override
  String get rulesStatusError => 'Nem sikerült lekérdezni a szervert.';

  @override
  String get rulesStatusChecking => 'Ellenőrzés…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Futtatás innen: „$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script” az aktív szkript. Koppints, hogy a Loupe szabályait is futtassa.';
  }

  @override
  String get rulesStatusNoScript =>
      'Nincs aktív szkript a szerveren. Egy szerveroldali szabály mentése bekapcsolja a Loupe szkriptjét.';

  @override
  String get rulesStatusUnavailable => 'Nem érhető el';

  @override
  String get rulesStatusNoSieve => 'Ennek a fióknak a szervere nem kínál Sieve-et (ManageSieve vagy JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Áthelyezés ide: $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Áthelyezés egy mappába';

  @override
  String rulesActionTag(String tag) {
    return 'Címke: $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Címke eltávolítása: $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Megtartás a Beérkező levelekben';

  @override
  String rulesActionForward(String address) {
    return 'Továbbítás ide: $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Továbbítás ide: $address, másolat nélkül';
  }

  @override
  String get rulesActionStop => 'Leállítás';

  @override
  String get rulesNoActions => 'Még nem csinál semmit';

  @override
  String get rulesLocationDevice => 'Eszköz';

  @override
  String get rulesLocationServer => 'Szerver';

  @override
  String get rulesLocationThisDevice => 'Ez az eszköz';

  @override
  String get rulesNewRuleTitle => 'Új szabály';

  @override
  String get rulesEditRuleTitle => 'Szabály szerkesztése';

  @override
  String get rulesDefaultNameEveryMessage => 'Minden üzenet';

  @override
  String get rulesConditionHeader => 'Ha egy új üzenet megfelel ennek';

  @override
  String get rulesConditionFooter =>
      'Írd úgy, ahogy keresnél: from:, to:, s: (tárgy), b: (szövegtörzs), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:számla';

  @override
  String get rulesAccounts => 'Fiókok';

  @override
  String get rulesAllAccounts => 'Minden fiók';

  @override
  String get rulesRemovedAccount => 'Eltávolított fiók';

  @override
  String get rulesAccountsFooter => 'A minden fiókra vonatkozó szabály a később hozzáadott fiókokra is érvényes.';

  @override
  String get rulesActionsHeader => 'Akkor';

  @override
  String get rulesForwardingFooter =>
      'A továbbítás minden egyező üzenetet egy másik címre küld, amint megérkezik, akkor is, ha ez a telefon ki van kapcsolva. Egyes szolgáltatók korlátozzák, mennyi levél továbbítható.';

  @override
  String get rulesForwardingHiddenFooter =>
      'A továbbítás csak szerveroldali szabályokban működik, ezért itt nem szerepel.';

  @override
  String rulesRemoveAction(String action) {
    return '$action eltávolítása';
  }

  @override
  String get rulesAddAction => 'Művelet hozzáadása';

  @override
  String get rulesAddMove => 'Áthelyezés mappába…';

  @override
  String get rulesAddTagMenu => 'Címke hozzáadása…';

  @override
  String get rulesRemoveTagMenu => 'Címke eltávolítása…';

  @override
  String get rulesAddForward => 'Továbbítás ide…';

  @override
  String get rulesStopProcessing => 'További szabályok feldolgozásának leállítása';

  @override
  String get rulesRunOnHeader => 'Futtatás helye';

  @override
  String get rulesRunOnDeviceFooter =>
      'Ez az eszköz minden levélellenőrzéskor lefuttatja a szabályt a Beérkező levelek új leveleire.';

  @override
  String get rulesRunOnServerFooter =>
      'A levelezőszerver futtatja a szabályt, amint a levél megérkezik, akkor is, ha ez a telefon ki van kapcsolva. Sieve szükséges hozzá, ManageSieve-en (Dovecot, mailcow) vagy JMAP-on (Stalwart) keresztül.';

  @override
  String get rulesApplyToExisting => 'Alkalmazás a meglévő üzenetekre…';

  @override
  String get rulesDeleteRule => 'Szabály törlése';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Törlöd: „$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Melyik fiók mappájába?';

  @override
  String get rulesMoveAccountMessage => 'A többi fiók levelei az ott azonos nevű mappába kerülnek.';

  @override
  String get rulesAddTag => 'Címke hozzáadása';

  @override
  String get rulesRemoveTag => 'Címke eltávolítása';

  @override
  String get rulesForwardTo => 'Továbbítás ide';

  @override
  String get rulesForwardToMessage =>
      'A szerver minden egyező üzenetet továbbküld erre a címre, akkor is, ha ez a telefon ki van kapcsolva. Olyan címet használj, amely a tiéd, vagy amelyben megbízol.';

  @override
  String get rulesNotAnAddressTitle => 'Nem e-mail-cím';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address” nem olyan cím, amelyre továbbítani lehet.';
  }

  @override
  String get rulesKeepCopyTitle => 'Megtartasz itt egy másolatot?';

  @override
  String get rulesKeepCopy => 'Másolat megtartása';

  @override
  String get rulesDontKeepCopy => 'Ne maradjon másolat';

  @override
  String get rulesCheckCondition => 'Ellenőrizd a feltételt';

  @override
  String get rulesChooseActionTitle => 'Válassz műveletet';

  @override
  String get rulesChooseActionMessage => 'Add meg, mit tegyen a szabály az egyező üzenetekkel.';

  @override
  String get rulesSaveError => 'Nem sikerült menteni a szabályt';

  @override
  String get rulesSaveServerError => 'Nem sikerült menteni a szerveroldali szabályt';

  @override
  String get rulesRunOnDeviceInstead => 'Futtatás inkább ezen az eszközön';

  @override
  String get rulesNothingToApplyTitle => 'Nincs mit alkalmazni';

  @override
  String get rulesNothingToApplyMessage => 'Előbb adj a szabálynak működő feltételt és egy műveletet.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return '„$rule” alkalmazása az üzenetekre itt:';
  }

  @override
  String get rulesApplyScopeInboxes => 'Beérkező levelek';

  @override
  String get rulesApplyScopeAll => 'Összes postafiók';

  @override
  String get rulesFindingMessages => 'Üzenetek keresése…';

  @override
  String get rulesSearchError => 'Nem sikerült a keresés';

  @override
  String get rulesSearchErrorUnknown => 'Hiba történt.';

  @override
  String get rulesNoMatchesTitle => 'Nincs egyező üzenet';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ott semmi sem felel meg ennek: „$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$rule” alkalmazása $countString üzenetre?',
      one: '„$rule” alkalmazása $countString üzenetre?',
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
      other: 'Alkalmazás $countString üzenetre',
      one: 'Alkalmazás $countString üzenetre',
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
      other: '„$rule” alkalmazva $countString üzenetre',
      one: '„$rule” alkalmazva $countString üzenetre',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'A szerver képességeinek lekérdezése…';

  @override
  String get rulesServerUnreachable => 'Nem sikerült elérni a szervert.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nem futtatható a szerveren: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nem futtatható $account szerverén: $problem';
  }

  @override
  String get rulesShowScript => 'Szkript megjelenítése';

  @override
  String get rulesHideScript => 'Szkript elrejtése';

  @override
  String get rulesMatchingHeader => 'Egyező üzenetek';

  @override
  String get rulesMatchingHeaderLoading => 'Egyező üzenetek…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString egyező üzenet',
      one: '$countString egyező üzenet',
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
      other: '$countString+ egyező üzenet',
      one: '$countString+ egyező üzenet',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Az elmúlt 30 napból. Maga a szabály csak az új levelekre hat, hacsak nem alkalmazod a meglévő üzenetekre.';

  @override
  String rulesConditionError(String error) {
    return 'A feltétel hibás: $error';
  }

  @override
  String get rulesPreviewNoSender => '(nincs feladó)';

  @override
  String get rulesPreviewNoSubject => '(nincs tárgy)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'és még $countString',
      one: 'és még $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Semmi az elmúlt 30 napból.';

  @override
  String get rulesIncludeTitle => 'Szerveroldali szabályok bekapcsolása';

  @override
  String get rulesIncludeLeaveOff => 'Maradjon kikapcsolva';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'A szerver már futtatja a Loupe szabályait ennél a fióknál: $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script” az aktív szkript $account szerverén, ezért a szerver azt futtatja, nem a Loupe szabályait. A Loupe nem cseréli le, de hozzáadhatja a következő sorokat, és a szerver ezután a szkript saját szabályai után a Loupe szabályait is lefuttatja:';
  }

  @override
  String get rulesShowWholeScript => 'Teljes szkript megjelenítése';

  @override
  String get rulesHideWholeScript => 'Teljes szkript elrejtése';

  @override
  String rulesIncludeFootnote(String script) {
    return '„$script” más része nem változik. Ha később a webmailben szerkesztik a szűrőit, a webmail ezek nélkül a sorok nélkül írhatja újra; a Loupe ekkor ismét kikapcsoltként mutatja a szerveroldali szabályokat.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Hozzáadás ehhez: „$script”';
  }

  @override
  String get subscriptionsTitle => 'Feliratkozások';

  @override
  String get subscriptionsNewsletters => 'Hírlevelek';

  @override
  String get subscriptionsDiscussions => 'Beszélgetések';

  @override
  String get subscriptionsFilter => 'Szűrés';

  @override
  String get subscriptionsFilterNeverRead => 'Soha nem olvasott';

  @override
  String get subscriptionsFilterRarelyRead => 'Ritkán olvasott';

  @override
  String get subscriptionsFilterAll => 'Összes';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Nem sikerült megszámolni a feliratkozásokat';

  @override
  String get subscriptionsNoMatches => 'Nincs találat';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nincs „$text” nevű hírlevél.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nincs „$text” nevű lista.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Nincsenek hírlevelek';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'A hírlevelek és más tömeges levelek itt jelennek meg, amint megérkeznek.';

  @override
  String get subscriptionsNothingNeverRead => 'Nincs soha nem olvasott';

  @override
  String get subscriptionsNothingRarelyRead => 'Nincs ritkán olvasott';

  @override
  String get subscriptionsNothingFilteredDetail => 'Mindenből olvasol valamennyit, amit kapsz.';

  @override
  String get subscriptionsNoDiscussions => 'Nincsenek beszélgetések';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Azok a levelezőlisták, amelyekre írhatsz, itt jelennek meg, amint megérkeznek a leveleik.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listák, amelyekre többen is írnak. Tarts lenyomva egyet, hogy rögzítsd a Postafiókokhoz, egyszerű szövegként olvasd, vagy áthelyezd a Hírlevelek közé.';

  @override
  String get subscriptionsPrivacyNote =>
      'A telefonon számolva, a letöltött levelek alapján; ehhez semmi sem kerül elküldésre. A Loupe csak akkor lép kapcsolatba egy feladóval, ha a Leiratkozás gombra koppintasz: az egykoppintásos leiratkozás csak a „List-Unsubscribe=One-Click” szöveget küldi el a feladó által megadott címre, sütik és bármi más rólad szóló adat nélkül, és soha nem tölti be a feladó oldalait vagy képeit.';

  @override
  String get subscriptionsVolumeNone => 'Mostanában semmi';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / hónap';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / hónap';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'olvasva: $percent';
  }

  @override
  String get subscriptionsStillSending => 'Még mindig küld';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Leiratkozva: $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Leiratkozási oldal megnyitva: $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Egy koppintás · kapcsolatfelvétel: $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-mailben ide: $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'A webhelyen: $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Leiratkozás';

  @override
  String get subscriptionsUnsubscribeAgain => 'Leiratkozás újra';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString archiválása a Beérkező levelekből',
      one: '$countString archiválása a Beérkező levelekből',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Szabály létrehozása…';

  @override
  String get subscriptionsCreateRuleDetail => 'Jövőbeli leveleinek áthelyezése vagy archiválása';

  @override
  String get subscriptionsTreatAsDiscussion => 'Kezelés beszélgetésként';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Lista, amelyre emberek írnak: fórumszerű olvasás';

  @override
  String get subscriptionsTreatAsNewsletter => 'Kezelés hírlevélként';

  @override
  String get subscriptionsBlockSender => 'Feladó letiltása';

  @override
  String get subscriptionsBlock => 'Letiltás';

  @override
  String get subscriptionsBlocked => 'Letiltva';

  @override
  String get subscriptionsBlockedDetail => 'Az új levelek a Levélszemétbe kerülnek';

  @override
  String get subscriptionsPin => 'Rögzítés a Postafiókokhoz';

  @override
  String get subscriptionsUnpin => 'Rögzítés feloldása a Postafiókokból';

  @override
  String get subscriptionsOpenDefaultView => 'Megnyitás alapértelmezett nézetben';

  @override
  String get subscriptionsOpenPlainText => 'Megnyitás egyszerű szövegként (Mono)';

  @override
  String get subscriptionsPinned => 'Rögzítve';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString olvasatlan',
      one: '$countString olvasatlan',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Jelenleg nincs levél ettől a feladótól.';

  @override
  String get subscriptionsLatestMessages => 'LEGÚJABB ÜZENETEK';

  @override
  String get subscriptionsMail => 'Levelek';

  @override
  String get subscriptionsNoneIn90Days => 'Semmi 90 nap alatt';

  @override
  String get subscriptionsRead => 'Olvasva';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString / $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Utoljára érkezett';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Mappák', one: 'Mappa');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Még mindig küld';

  @override
  String get subscriptionsUnsubscribedTitle => 'Leiratkozva';

  @override
  String subscriptionsSince(String date) {
    return '$date óta';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'oldal megnyitva: $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nem adja meg, hogyan lehet leiratkozni.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nem adja meg, hogyan lehet leiratkozni. Helyette letilthatod.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Leiratkozás innen: $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Leiratkoztál innen: $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Nem sikerült leiratkozni: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Az automatikus leiratkozás nem sikerült';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Leiratkozási e-mail küldése';

  @override
  String subscriptionsOpenSite(String site) {
    return '$site megnyitása';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Megnyitod: $site?';
  }

  @override
  String get subscriptionsOpen => 'Megnyitás';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender a webhelyén iratkoztat le. Az oldal a Loupe böngészőjében nyílik meg; ott fejezd be.';
  }

  @override
  String get subscriptionsWebInsecure => 'A kapcsolat ehhez a webhelyhez nem titkosított.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Vigyázz: ez a cím megtévesztően hasonló betűkkel ezt utánozza: $site.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Vigyázz: ez a cím megtévesztően hasonló betűkkel egy másik webhelyet utánoz.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Nem sikerült megnyitni: $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'A Loupe feljegyzi a mai dátumot, és szól, ha $sender továbbra is ír.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Leiratkozol innen: $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'A Loupe a leiratkozáshoz kapcsolatba lép ezzel: $site.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Ez az egyetlen eset, amikor a Loupe kapcsolatba lép egy feladó webhelyével. Csak a „List-Unsubscribe=One-Click” szöveget küldi el a $sender által megadott címre, sütik és bármi más rólad szóló adat nélkül, és nem tölti be az oldalt.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'A leiratkozási link nem biztonságos internetes cím.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site nem válaszolt időben.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Nem sikerült elérni: $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site egy másik oldalra küldte tovább a kérést, amelyet a Loupe nem követ.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site elutasította a kérést (hibakód: $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nincs fiók, amelyről a leiratkozási e-mailt el lehetne küldeni.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'A Loupe e-mailt küld ide: $to, innen: $from, „$subject” tárggyal.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Leiratkozási e-mail elküldve ide: $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Letiltod: $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'A lista új levelei a Levélszemétbe kerülnek. Ezt a Beállítások › Szabályok alatt módosíthatod.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Az innen érkező új levelek a Levélszemétbe kerülnek: $address. Ezt a Beállítások › Szabályok alatt módosíthatod.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Letiltva: $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count áthelyezése a Levélszemétbe',
      one: '$count áthelyezése a Levélszemétbe',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return '$sender letiltása';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender mostantól a Hírlevelek között van.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender mostantól a Beszélgetések között van.';
  }

  @override
  String get appLiveGateTitle => 'A fiókjaidat nem sikerült megnyitni';

  @override
  String get appLiveGateUnavailableBuild => 'Valódi fiókok ebben a buildben még nem érhetők el.';

  @override
  String get appLiveGateKeyUnreadable =>
      'A Loupe nem tudta beolvasni a kulcsot, amely a leveleidet védi ezen a telefonon. Ez gyakran átmeneti: próbáld újra, vagy indítsd újra a telefont.';

  @override
  String get appLiveGateKeyMissing =>
      'A leveleidet ezen a telefonon védő kulcs eltűnt, ami egy biztonsági mentés visszaállítása után előfordulhat. A leveleid továbbra is a szerveren vannak.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'A telefonon lévő levelezési adatbázis nem olvasható: sérült, vagy megváltozott a kulcsa. A leveleid továbbra is a szerveren vannak.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Hiba történt a fiókjaid megnyitása közben ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Ez törli a fiókjaidat és a telefonon tárolt leveleket, a Kimenő mappában várakozó üzeneteket is. A szervereiden lévő leveleket ez nem érinti; utána add hozzá újra a fiókjaidat.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Törlés és újrakezdés';

  @override
  String get appLiveGateUseDemo => 'Demó levelek használata';

  @override
  String get appLiveGateReset => 'Levelek visszaállítása ezen a telefonon…';

  @override
  String get attachmentsUntitled => 'Melléklet';

  @override
  String get attachmentsUntitledFile => 'Névtelen';

  @override
  String get attachmentsOpenIn => 'Megnyitás ebben…';

  @override
  String get attachmentsSaveToFiles => 'Mentés a Fájlokba';

  @override
  String get attachmentsShareMenu => 'Megosztás…';

  @override
  String get attachmentsDownloadError =>
      'Nem sikerült letölteni a mellékletet. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get attachmentsShareError => 'Nem sikerült megosztani a mellékletet.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ezen az eszközön egyetlen alkalmazás sem nyitja meg ezt a fájlt ($type). Próbáld inkább a Megosztást.';
  }

  @override
  String get attachmentsOpenInError => 'Nem sikerült megnyitni a mellékletet egy másik alkalmazásban.';

  @override
  String attachmentsSaved(String name) {
    return 'Mentve: „$name”';
  }

  @override
  String get attachmentsSaveError => 'Nem sikerült menteni a mellékletet.';

  @override
  String get attachmentsGone => 'Ez a melléklet már nem érhető el.';

  @override
  String get attachmentsDownloadFailed => 'A mellékletet nem sikerült letölteni.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count oldal', one: '$count oldal');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size mobiladat-kapcsolaton';
  }

  @override
  String get attachmentsLargeDownload => 'Ez a melléklet nagy. Töltsd le most, vagy később Wi-Fi-n.';

  @override
  String get attachmentsDownload => 'Letöltés';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size letöltése…';
  }

  @override
  String get attachmentsDownloading => 'Letöltés…';

  @override
  String get attachmentsTooLarge => 'Túl nagy az itteni előnézethez.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Az első $shown látható, összesen $total. A teljes tartalomhoz másold, oszd meg vagy mentsd el.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Ez a PDF itt nem jeleníthető meg (lehet, hogy jelszóval védett).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page / $count';
  }

  @override
  String get attachmentsModeTable => 'Táblázat';

  @override
  String get attachmentsModeText => 'Szöveg';

  @override
  String get attachmentsModeMessage => 'Üzenet';

  @override
  String get attachmentsModeSource => 'Forrás';

  @override
  String get attachmentsDontWrap => 'Sortörés kikapcsolása';

  @override
  String get attachmentsWrap => 'Sortörés';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines sor', one: '$lines sor');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Összes másolása';

  @override
  String get attachmentsCopied => 'Másolva';

  @override
  String get attachmentsImageUnavailable => 'Ez a kép itt nem jeleníthető meg. Próbáld a Megnyitás ebben… lehetőséget.';

  @override
  String get attachmentsEmlNoSubject => '(Nincs tárgy)';

  @override
  String get attachmentsEmlFrom => 'Feladó';

  @override
  String get attachmentsEmlTo => 'Címzett';

  @override
  String get attachmentsEmlCc => 'Másolat';

  @override
  String get attachmentsEmlDate => 'Dátum';

  @override
  String get attachmentsEmlNoText => 'Ennek az üzenetnek nincs szövege.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mellékletek: $names',
      one: 'Melléklet: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Szervező: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'És még $count esemény',
      one: 'És még $count esemény',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Kép';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-kép';
  }

  @override
  String get attachmentsTypePdf => 'PDF-dokumentum';

  @override
  String get attachmentsTypeTsv => 'Tabulátorral tagolt értékek';

  @override
  String get attachmentsTypeCsv => 'CSV-táblázat';

  @override
  String get attachmentsTypeCalendar => 'Naptáresemény';

  @override
  String get attachmentsTypeEmail => 'E-mail-üzenet';

  @override
  String get attachmentsTypeContact => 'Névjegykártya';

  @override
  String get attachmentsTypeLog => 'Naplófájl';

  @override
  String get attachmentsTypeText => 'Szöveg';

  @override
  String get attachmentsTypeZip => 'ZIP-archívum';

  @override
  String get attachmentsTypeArchive => 'Archívum';

  @override
  String get attachmentsTypeWord => 'Word-dokumentum';

  @override
  String get attachmentsTypeExcel => 'Excel-munkafüzet';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-bemutató';

  @override
  String get attachmentsTypeWebPage => 'Weboldal';

  @override
  String get attachmentsTypeVideo => 'Videó';

  @override
  String get attachmentsTypeAudio => 'Hang';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-fájl';
  }

  @override
  String get attachmentsTypeFile => 'Fájl';

  @override
  String get calendarUntitledEvent => 'Esemény';

  @override
  String get calendarAllDay => 'Egész nap';

  @override
  String calendarYourTime(String time) {
    return '$time helyi idő szerint';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Csatlakozás: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name elfogadta: $details',
      'tentative': '$name feltételesen elfogadta: $details',
      'declined': '$name elutasította: $details',
      'delegated': '$name delegálta: $details',
      'other': '$name nem válaszolt erre: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name elfogadta a meghívást',
      'tentative': '$name feltételesen elfogadta a meghívást',
      'declined': '$name elutasította a meghívást',
      'delegated': '$name delegálta a meghívást',
      'other': '$name nem válaszolt a meghívásra',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Térkép';

  @override
  String get calendarJoin => 'Csatlakozás';

  @override
  String get calendarOnlineMeeting => 'Online értekezlet';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-értekezlet';
  }

  @override
  String get calendarOrganizerYou => 'Te';

  @override
  String get calendarOrganizerLabel => 'szervező';

  @override
  String get calendarStatusAccepted => 'Elfogadva';

  @override
  String get calendarStatusMaybe => 'Talán';

  @override
  String get calendarStatusDeclined => 'Elutasítva';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name elfogadta',
      'tentative': '$name feltételesen elfogadta',
      'declined': '$name elutasította',
      'delegated': '$name delegálta',
      'other': '$name nem válaszolt',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name elfogadta:',
      'tentative': '$name feltételesen elfogadta:',
      'declined': '$name elutasította:',
      'delegated': '$name delegálta:',
      'other': '$name nem válaszolt:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name új időpontot javasol';
  }

  @override
  String get calendarCounterUnknown => 'Egy résztvevő új időpontot javasol';

  @override
  String get calendarDeclineCounter => 'A szervező megtartotta az időpontot';

  @override
  String calendarRefresh(String name) {
    return '$name a legújabb változatot kéri';
  }

  @override
  String get calendarRefreshUnknown => 'Egy résztvevő a legújabb változatot kéri';

  @override
  String get calendarCancelled => 'Lemondva';

  @override
  String get calendarCancelledByOrganizer => 'A szervező lemondta ezt az eseményt.';

  @override
  String get calendarCancelledLater => 'Ezt az eseményt később lemondták.';

  @override
  String get calendarOutdated => 'Elavult';

  @override
  String get calendarOutdatedDetail => 'Ezt a meghívást később frissítették; az újabb az érvényes.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Helyszín eltávolítva (korábban: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Helyszín eltávolítva (korábban nem volt)';

  @override
  String calendarLocationChanged(String location) {
    return 'Új helyszín: $location';
  }

  @override
  String get calendarNewTitle => 'Új cím';

  @override
  String get calendarRepeatChanged => 'Az ismétlődés megváltozott';

  @override
  String get calendarUpdated => 'Frissítve';

  @override
  String get calendarUpdatedInvitation => 'Frissített meghívás';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Az időpont megváltozott: $before helyett $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Ismeretlen időzóna („$zone”): az időpontok az eredeti szerint';
  }

  @override
  String calendarNext(String when) {
    return 'Következő: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vendég', one: '$count vendég');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elfogadta',
      one: '$count elfogadta',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count talán', one: '$count talán');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elutasította',
      one: '$count elutasította',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (te)';
  }

  @override
  String get calendarAttendeeOptional => 'nem kötelező';

  @override
  String get calendarAttendeeRoom => 'terem';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Egy korábbi változatot elfogadtál.',
      'tentative': 'Egy korábbi változatot feltételesen elfogadtál.',
      'declined': 'Egy korábbi változatot elutasítottál.',
      'delegated': 'Egy korábbi változatot delegáltál.',
      'other': 'Egy korábbi változatra nem válaszoltál.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Elfogadás';

  @override
  String get calendarMaybe => 'Talán';

  @override
  String get calendarDecline => 'Elutasítás';

  @override
  String get calendarCommentHint => 'Megjegyzés a szervezőnek (nem kötelező)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'A válaszodat $organizer kapja meg, erről a címről: $address.';
  }

  @override
  String get calendarAddComment => 'Megjegyzés hozzáadása';

  @override
  String get calendarAddToCalendar => 'Hozzáadás a naptárhoz';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'És még $count esemény a fájlban',
      one: 'És még $count esemény a fájlban',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Nincs naptáralkalmazás, amelyhez hozzá lehetne adni az eseményt.';

  @override
  String get calendarCantOpenCalendar => 'Nem sikerült megnyitni a naptárt.';

  @override
  String get calendarCantOpenLink => 'Nem sikerült megnyitni a linket.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Csatlakozol az értekezlethez ($provider)?';
  }

  @override
  String get calendarJoinTitle => 'Csatlakozol az értekezlethez?';

  @override
  String calendarJoinOpens(String host) {
    return 'Megnyitja a böngésződben: $host.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Vigyázz: ez a cím megtévesztően hasonló betűkkel ezt utánozza: $site.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Vigyázz: ez a cím megtévesztően hasonló betűkkel egy másik webhelyet utánoz.';

  @override
  String calendarJoinOpen(String host) {
    return '$host megnyitása';
  }

  @override
  String get calendarNoOrganizer => 'Ennek a meghívásnak nincs szervezője, akinek válaszolni lehetne.';

  @override
  String get calendarNoAccount => 'Nincs fiók, amelyről válaszolni lehetne.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Elfogadva',
      'tentative': 'Talán',
      'other': 'Elutasítva',
    });
    return '$_temp0 · válasz küldése neki: $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Elfogadva',
      'tentative': 'Talán',
      'other': 'Elutasítva',
    });
    return '$_temp0 · válasz elküldve';
  }

  @override
  String get calendarReplyAlreadySent => 'A válasz már el lett küldve.';

  @override
  String get calendarReplyNotSent => 'A válasz nincs elküldve.';

  @override
  String get dataSmimeNeedsDevice =>
      'Az S/MIME-tanúsítványod ezen az eszközön van: nyisd meg a Loupe-ot az üzenet aláírásához és elküldéséhez.';

  @override
  String dataSigningFailed(String error) {
    return 'Az aláírás nem sikerült: $error';
  }

  @override
  String get keyboardShortcuts => 'Billentyűparancsok';

  @override
  String get keyboardGroupGeneral => 'Általános';

  @override
  String get keyboardGroupMessages => 'Üzenetek';

  @override
  String get keyboardGroupCompose => 'Írás';

  @override
  String get keyboardCommandPalette => 'Parancspaletta';

  @override
  String get keyboardBackClose => 'Vissza, bezárás';

  @override
  String get keyboardNextMessage => 'Következő üzenet';

  @override
  String get keyboardPreviousMessage => 'Előző üzenet';

  @override
  String get keyboardOpenMessage => 'Üzenet megnyitása';

  @override
  String get keyboardMoveToTrash => 'Áthelyezés a kukába';

  @override
  String get keyboardToggleRead => 'Megjelölés olvasottként vagy olvasatlanként';

  @override
  String get keyboardToggleFlag => 'Megjelölés vagy megjelölés törlése';

  @override
  String get keyboardCloseDraft => 'Bezárás (piszkozat mentése vagy törlése)';

  @override
  String get keyboardOr => 'vagy';

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
  String get mailingListsMuted => 'Szál némítva. Az új üzenetei olvasottként érkeznek.';

  @override
  String get mailingListsUnmuted => 'Szál némítása feloldva.';

  @override
  String get mailingListsMuteThread => 'Szál némítása';

  @override
  String get mailingListsUnmuteThread => 'Szál némításának feloldása';

  @override
  String get mailingListsPin => 'Rögzítés a Postafiókokhoz';

  @override
  String get mailingListsUnpin => 'Rögzítés feloldása a Postafiókokból';

  @override
  String get mailingListsDefaultView => 'Megnyitás alapértelmezett nézetben';

  @override
  String get mailingListsPlainText => 'Megnyitás egyszerű szövegként (Mono)';

  @override
  String get mailingListsShowMuted => 'Némított szálak megjelenítése';

  @override
  String get mailingListsHideMuted => 'Némított szálak elrejtése';

  @override
  String get mailingListsTreatAsNewsletter => 'Kezelés hírlevélként';

  @override
  String get mailingListsOptions => 'Lista beállításai';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted olvasatlan',
      one: '$formatted olvasatlan',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Új üzenet a listának';

  @override
  String get mailingListsRowUnread => 'Olvasatlan';

  @override
  String get mailingListsRowMuted => 'Némítva';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count válasz', one: '$count válasz');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Nincsenek szálak';

  @override
  String get mailingListsMutedHidden => 'A némított szálak rejtve vannak.';

  @override
  String get mailingListsTechnicalTitle => 'Technikai listák';

  @override
  String get mailingListsTechnicalEmpty => 'A levelezőlisták itt jelennek meg, amint megérkeznek a leveleik.';

  @override
  String get mailingListsTechnicalFooter =>
      'Ezeknek a listáknak az üzenetei egyszerű szövegként, rögzített szélességű betűtípussal nyílnak meg, a patchek diffként jelennek meg. Az Aa gombbal továbbra is bármelyik üzenet átváltható.';

  @override
  String get paletteMoveToMailbox => 'Áthelyezés postafiókba…';

  @override
  String get paletteMarkAllRead => 'Összes megjelölése olvasottként';

  @override
  String get paletteExportFolder => 'Mappa exportálása…';

  @override
  String get paletteGetNewMail => 'Új levelek letöltése';

  @override
  String get paletteSnoozed => 'Szundiztatott';

  @override
  String get paletteSubscriptions => 'Feliratkozások';

  @override
  String get paletteDiscussions => 'Beszélgetések';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Levelezőlista';

  @override
  String get paletteTag => 'Címke';

  @override
  String get paletteSwipeActions => 'Csúsztatási műveletek';

  @override
  String get paletteNotifications => 'Értesítések';

  @override
  String get paletteRules => 'Szabályok';

  @override
  String get paletteEncryption => 'Végpontok közötti titkosítás';

  @override
  String get paletteAdvanced => 'Speciális';

  @override
  String get paletteAddAccount => 'Fiók hozzáadása';

  @override
  String get paletteAccount => 'Fiók';

  @override
  String get paletteFolders => 'Mappák';

  @override
  String get paletteRecentSearch => 'Legutóbbi keresés';

  @override
  String paletteSearchMail(String query) {
    return 'Keresés a levelekben: „$query”';
  }

  @override
  String get palettePlaceholder => 'Műveletek, postafiókok, beállítások keresése';

  @override
  String get paletteNothingFound => 'Nincs találat';

  @override
  String get searchNewSmartMailbox => 'Új Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Minden, ami megfelel ennek: „$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name” mentve a Postafiókokhoz';
  }

  @override
  String get searchMakeRule => 'Szabály létrehozása ebből';

  @override
  String get searchSaveSmartMailbox => 'Mentés Smart Mailboxként';

  @override
  String get searchNegate => 'Tagadás';

  @override
  String get searchDontNegate => 'Tagadás megszüntetése';

  @override
  String get searchAllMailboxes => 'Összes postafiók';

  @override
  String get searchRecent => 'Legutóbbi keresések';

  @override
  String get searchClear => 'Törlés';

  @override
  String get searchSuggestions => 'Javaslatok';

  @override
  String get searchUnreadMessages => 'Olvasatlan üzenetek';

  @override
  String get searchFlaggedMessages => 'Megjelölt üzenetek';

  @override
  String get searchWithAttachments => 'Mellékletes üzenetek';

  @override
  String get searchUnrepliedMessages => 'Megválaszolatlan üzenetek';

  @override
  String get searchTags => 'Címkék';

  @override
  String get searchPeople => 'Személyek';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Feladó: $name';
  }

  @override
  String get searchSearching => 'Keresés…';

  @override
  String get searchNoResults => 'Nincs találat';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted találat',
      one: '$formatted találat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Keresési menü';

  @override
  String searchSearchingAccount(String account) {
    return 'Keresés a szerveren: $account…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Fiók keresése a szerveren…';

  @override
  String searchAccountFailed(String account) {
    return 'Nem sikerült a keresés a szerveren: $account';
  }

  @override
  String get searchUnknownAccountFailed => 'Nem sikerült a fiók keresése a szerveren';

  @override
  String searchChip(String term) {
    return '$term. Koppints duplán a szerkesztéshez.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nem $term. Koppints duplán a szerkesztéshez.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödinger postafiókja: itt minden üzenet egyszerre olvasott és olvasatlan, amíg meg nem nyitod.';

  @override
  String searchContradiction(String term) {
    return 'Egy üzenet nem lehet egyszerre „$term” és nem az.';
  }

  @override
  String get searchSyncDeviceOnly => 'Csak ezen az eszközön';

  @override
  String searchSyncUnsupported(String account) {
    return 'Csak ezen az eszközön: $account nem tudja tárolni';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nincs szinkronizálva: $account újabb formátumot használ';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Szinkronizálásra vár: $account';
  }

  @override
  String searchSynced(String account) {
    return 'Szinkronizálva: $account';
  }

  @override
  String get searchRename => 'Átnevezés';

  @override
  String get searchEditSearch => 'Keresés szerkesztése';

  @override
  String get searchDeleteSmartMailbox => 'Smart Mailbox törlése';

  @override
  String get searchRenameSmartMailbox => 'Smart Mailbox átnevezése';

  @override
  String get searchSmartMailboxDeleted => 'Ezt a Smart Mailboxot törölték.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'A Smart Mailboxok ezen az eszközön maradnak.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'A Smart Mailboxok a levelezőszervereden tárolódnak, így a többi eszközödön is megvannak, és a Thunderbirdben is az Expression Search Reloaded bővítménnyel. A minden fiókban keresők ebben a fiókban tárolódnak: $account; az egy mappára vonatkozók pedig annak a mappának a fiókjában.';
  }

  @override
  String get searchSyncVia => 'Szinkronizálás ezen keresztül';

  @override
  String get searchSyncViaFooter => 'Minden eszközön ugyanazt a fiókot válaszd.';

  @override
  String get searchGmailCantKeep => 'A Gmail nem tudja tárolni a Smart Mailboxokat';

  @override
  String get searchKeepOnDevice => 'Smart Mailboxok tárolása csak ezen az eszközön';

  @override
  String get searchOnTheServer => 'A szerveren';

  @override
  String get searchServerFooter =>
      'A szerver metaadatai (IMAP METADATA) egyik levelezőalkalmazásban sem látszanak. Az ezt nem támogató szervereken egy „Loupe Settings” mappa jön létre egyetlen üzenettel; a Loupe elrejti a Postafiókok közül.';

  @override
  String get searchSyncNow => 'Szinkronizálás most';

  @override
  String get searchStateUnsupported => 'Nem támogatott';

  @override
  String get searchStateNewerFormat => 'Újabb formátum';

  @override
  String get searchStateFailed => 'Nem sikerült szinkronizálni';

  @override
  String get searchStateSyncing => 'Szinkronizálás…';

  @override
  String get searchStateWaiting => 'Várakozik';

  @override
  String get searchStateMetadata => 'Szerver metaadatai';

  @override
  String get searchStateFolder => 'Loupe Settings mappa';

  @override
  String get searchStateNothing => 'Nincs tárolva semmi';

  @override
  String get sharedBack => 'Vissza';

  @override
  String get sharedYesterday => 'Tegnap';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bájt', one: '$count bájt');
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
  String get sharedSyncNoAccounts => 'Nincsenek fiókok';

  @override
  String get sharedSyncChecking => 'Levelek ellenőrzése…';

  @override
  String get sharedSyncFailed => 'Nem sikerült ellenőrizni a leveleket';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Épp most frissítve';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes perce frissítve',
      one: '$minutes perce frissítve',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Frissítve: $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Frissítve: $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Összes beérkező levél';

  @override
  String get sharedMailboxUnread => 'Olvasatlan';

  @override
  String get sharedMailboxFlagged => 'Megjelölt';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Összes piszkozat';

  @override
  String get sharedMailboxAllSent => 'Összes elküldött';

  @override
  String get sharedMailboxUntitled => 'Postafiók';

  @override
  String get sharedTagImportant => 'Fontos';

  @override
  String get sharedTagWork => 'Munka';

  @override
  String get sharedTagPersonal => 'Személyes';

  @override
  String get sharedTagToDo => 'Teendő';

  @override
  String get sharedTagLater => 'Később';

  @override
  String get sharedTags => 'Címkék';

  @override
  String get sharedMoveTo => 'Áthelyezés ide…';

  @override
  String get sharedNoRecipients => 'Nincs címzett';

  @override
  String get sharedUnknownSender => 'Ismeretlen feladó';

  @override
  String get sharedOnServer => 'A szerveren';

  @override
  String get sharedAttachment => 'Melléklet';

  @override
  String get sharedSnoozedBadge => 'Szundiból';

  @override
  String get sharedRowUnread => 'Olvasatlan';

  @override
  String get sharedRowBackFromSnooze => 'Visszatért a szundiból';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Megjelölt';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet archiválva',
      one: '$count üzenet archiválva',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet törölve',
      one: '$count üzenet törölve',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet áthelyezve a Beérkező levelek közé',
      one: '$count üzenet áthelyezve a Beérkező levelek közé',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet áthelyezve a Kukába',
      one: '$count üzenet áthelyezve a Kukába',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet áthelyezve a Levélszemétbe',
      one: '$count üzenet áthelyezve a Levélszemétbe',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet áthelyezve ide: $mailbox',
      one: '$count üzenet áthelyezve ide: $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet áthelyezve egy postafiókba',
      one: '$count üzenet áthelyezve egy postafiókba',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üzenet szundiztatva eddig: $time',
      one: '$count üzenet szundiztatva eddig: $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Szundiztatva eddig: $time, csak ezen az eszközön: a szerver nem tudja tárolni a szundi idejét.';
  }

  @override
  String get sharedMoveOneAccount => 'Az áthelyezéshez egyetlen fiók üzeneteit jelöld ki.';

  @override
  String get sharedSnoozeTitle => 'Szundi';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Szundi idejének módosítása';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Véglegesen törölsz $count üzenetet?',
      one: 'Véglegesen törlöd ezt az üzenetet?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ez nem vonható vissza.';

  @override
  String get sharedDeletePermanently => 'Végleges törlés';

  @override
  String get sharedSwipeRead => 'Olvasott';

  @override
  String get sharedSwipeUnread => 'Olvasatlan';

  @override
  String get sharedSwipeInbox => 'Beérkező';

  @override
  String get sharedSwipeDelete => 'Törlés';

  @override
  String get sharedTrash => 'Kukába';

  @override
  String get sharedSwipeSnooze => 'Szundi';

  @override
  String get sharedWakeNow => 'Felébresztés most';

  @override
  String get sharedChangeSnoozeTime => 'Szundi idejének módosítása…';

  @override
  String get sharedSnooze => 'Szundi…';

  @override
  String get sharedTag => 'Címkézés…';

  @override
  String get sharedMoveMessage => 'Üzenet áthelyezése…';

  @override
  String get sharedNotJunk => 'Nem levélszemét';

  @override
  String get accountSetupTitle => 'Fiók hozzáadása';

  @override
  String get accountSetupTitleDone => 'Fiók hozzáadva';

  @override
  String get accountSetupAddressTitle => 'Levelezőfiók hozzáadása';

  @override
  String get accountSetupAddressText => 'A Loupe a legtöbb szolgáltató beállításait megtalálja.';

  @override
  String get accountSetupNameHint => 'Neved';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Tovább';

  @override
  String get accountSetupLookingUp => 'Beállítások keresése…';

  @override
  String get accountSetupImport => 'Importálás Thunderbirdből';

  @override
  String get accountSetupInvalidEmail => 'Adj meg érvényes e-mail-címet.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nem találhatók beállítások ehhez: $domain. Add meg őket alább.';
  }

  @override
  String get accountSetupCheckServers => 'Ellenőrizd a szerverneveket és a portokat.';

  @override
  String get accountSetupEnterPassword => 'Add meg a jelszavadat.';

  @override
  String get accountSetupConnecting => 'Kapcsolódás…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Várakozás erre: $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Nem sikerült megnyitni az oldalt.';

  @override
  String get accountSetupCouldNotSaveName => 'Nem sikerült menteni a nevet.';

  @override
  String get accountSetupTrustCertificate => 'Tanúsítvány megbízhatónak jelölése';

  @override
  String get accountSetupPasswordRequired => 'Kötelező';

  @override
  String get accountSetupShowPassword => 'Jelszó megjelenítése';

  @override
  String get accountSetupHidePassword => 'Jelszó elrejtése';

  @override
  String get accountSetupAppPassword => 'Alkalmazásjelszó';

  @override
  String get accountSetupApiToken => 'API-token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Bejövő · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Kimenő · SMTP';

  @override
  String get accountSetupSignIn => 'Bejelentkezés';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Bejelentkezés ezzel: $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Alkalmazásjelszó használata';

  @override
  String get accountSetupUseAppPasswordInstead => 'Inkább alkalmazásjelszó használata';

  @override
  String get accountSetupUseDifferentAddress => 'Másik cím használata';

  @override
  String get accountSetupHowToCreateAppPassword => 'Hogyan hozhatok létre alkalmazásjelszót?';

  @override
  String get accountSetupHowToCreateOne => 'Hogyan hozhatok létre egyet?';

  @override
  String get accountSetupGoogleNote =>
      'A Google oldalán jelentkezel be, a Loupe soha nem látja a jelszavadat. Engedélyezd, hogy a Loupe olvassa, küldje és rendszerezze a leveleidet.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      'A „Bejelentkezés ezzel: Google” ebben a buildben még nem érhető el. Helyette alkalmazásjelszóval is kapcsolódhatsz (ehhez kétlépcsős azonosítás szükséges a Google-fiókodban).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Hozz létre egy alkalmazásjelszót a Google-fiókodban, és illeszd be alább.';

  @override
  String get accountSetupMicrosoftNote =>
      'A Microsoft oldalán jelentkezel be, a Loupe soha nem látja a jelszavadat. Ez működik Outlook.com- és Hotmail-fiókokkal, valamint Microsoft 365-ös munkahelyi vagy iskolai fiókokkal.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'A Microsoft-bejelentkezés egy későbbi buildben érkezik. Az Outlook-, Hotmail- és Microsoft 365-fiókokhoz erre szükség van: ezek már nem fogadnak el jelszót levelezőalkalmazásoktól.';

  @override
  String get accountSetupICloudNote =>
      'Az iCloud Mailhez alkalmazásspecifikus jelszó kell, nem az Apple-fiókod jelszava.';

  @override
  String get accountSetupYahooNote => 'A Yahoo Mailhez alkalmazásjelszó kell, nem a fiókod jelszava.';

  @override
  String get accountSetupFastmailJmapNote =>
      'A Loupe JMAP-on keresztül, API-tokennel kapcsolódik a Fastmailhez: Settings › Privacy & Security › Manage API tokens, JMAP-hoz, levelekhez és küldéshez való hozzáféréssel.';

  @override
  String get accountSetupFastmailNote => 'A Fastmail a levelezőalkalmazásokhoz alkalmazásjelszót kér.';

  @override
  String get accountSetupServerSettings => 'Szerverbeállítások';

  @override
  String get accountSetupSettingsNotFound => 'Automatikusan nem található';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Forrás: $source';
  }

  @override
  String get accountSetupEditSettings => 'Beállítások szerkesztése';

  @override
  String get accountSetupSyncing => 'A leveleid szinkronizálása folyamatban.';

  @override
  String get accountSetupDescription => 'Leírás';

  @override
  String get accountSetupDescriptionHint => 'Munka, személyes…';

  @override
  String get accountSetupColour => 'Szín';

  @override
  String accountSetupColourNumber(int number) {
    return '$number. szín';
  }

  @override
  String get accountSetupSaving => 'Mentés…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'A Loupe nem tudta megnyitni a levelezési adatbázisát ezen a telefonon. Zárd be a Loupe-ot, nyisd meg újra, és próbáld újra.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Hiba történt ($error). Próbáld újra.';
  }

  @override
  String get accountSetupSecurityNone => 'Nincs';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Biztonság';

  @override
  String get accountSetupUsername => 'Felhasználónév';

  @override
  String get accountSetupUsernameHint => 'Az e-mail-címed';

  @override
  String get accountSetupNoEncryptionTitle => 'Kapcsolódsz titkosítás nélkül?';

  @override
  String get accountSetupNoEncryptionText =>
      'A jelszavad és minden üzenet titkosítatlanul utazna. A hálózaton bárki, például egy nyilvános Wi-Fi-n, elolvashatná őket. Csak a saját hálózatodon lévő szerverhez használd.';

  @override
  String get accountSetupUseWithoutEncryption => 'Használat titkosítás nélkül';

  @override
  String get accountSetupApiTokenRejected =>
      'Az API-token elutasítva. Hozz létre egy Fastmail API-tokent JMAP-hoz, levelekhez való hozzáféréssel, és illeszd be.';

  @override
  String get accountSetupAppPasswordRejected =>
      'A jelszó elutasítva. Alkalmazásjelszót használj, ne a fiókod jelszavát.';

  @override
  String get accountSetupPasswordRejected => 'A jelszó elutasítva. Ellenőrizd, és próbáld újra.';

  @override
  String get accountSetupServerUnreachable =>
      'A szerver nem érhető el. Ellenőrizd a szerverbeállításokat és a kapcsolatot.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'A szerver tanúsítványa nem megbízható. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'A bejelentkezés megszakadt. Az újrapróbáláshoz koppints a „Bejelentkezés ezzel: $provider” gombra.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'A Loupe-nak engedély kell a Gmail-leveleid olvasásához és küldéséhez. Jelentkezz be újra, és engedélyezd a hozzáférést úgy, hogy a Gmail jelölőnégyzet be legyen jelölve.';

  @override
  String get accountSetupOAuthDenied =>
      'A Loupe-nak engedély kell a leveleid olvasásához és küldéséhez. Jelentkezz be újra, és fogadd el az engedélyeket.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'A szervezetednek jóvá kell hagynia a Loupe-ot, mielőtt ezzel a fiókkal használhatnád. Kérd meg az informatikai rendszergazdát, hogy adjon rendszergazdai hozzájárulást a Loupe-hoz a Microsoft Entra ID-ben, majd próbáld újra.';

  @override
  String get accountSetupOAuthBlocked =>
      'A szervezeted bejelentkezési szabályai nem engedélyezik a Loupe-ot ezen az eszközön. Fordulj az informatikai rendszergazdához.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Nem sikerült elérni: $provider. Ellenőrizd az internetkapcsolatot, és próbáld újra.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'A bejelentkezés ezzel: $provider nincs megfelelően beállítva a Loupe ezen verziójában. Kérjük, jelezd nekünk.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'A bejelentkezés ezzel: $provider nem sikerült. Próbáld újra.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider bejelentkeztetett, de a Gmail megtagadta a hozzáférést ehhez a címhez. Bejelentkezéskor ugyanazt a fiókot válaszd. Munkahelyi vagy iskolai fiókoknál a rendszergazda kikapcsolhatta az IMAP-ot.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider bejelentkeztetett, de a levelezőszerver megtagadta a hozzáférést ehhez a címhez. Bejelentkezéskor ugyanazt a fiókot válaszd. Munkahelyi vagy iskolai fiókoknál a rendszergazda kikapcsolhatta az IMAP-ot.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'A levelezőszerver nem érhető el. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'A bejelentkezés ezzel: $provider nem érhető el ebben a verzióban.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Újra bejelentkeztél. $account szinkronizálása folyamatban.';
  }

  @override
  String get accountSetupSignInAgain => 'Újbóli bejelentkezés';

  @override
  String get accountSetupSigningIn => 'Bejelentkezés…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider már nem fogadja el a Loupe bejelentkezését ehhez a címhez: $email, ezért $account nem szinkronizálódik. A levelei eléréséhez jelentkezz be újra.';
  }

  @override
  String get accountImportTitle => 'Importálás Thunderbirdből';

  @override
  String get accountImportPointCamera => 'Irányítsd a kamerát a Thunderbird által mutatott QR-kódra.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned/$total beolvasva';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned/$total kód beolvasva',
      one: '$scanned/$total kód beolvasva',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eddig $count fiók',
      one: 'Eddig $count fiók',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'A számítógépeden nyisd meg a Thunderbirdöt, és válaszd az Eszközök › Exportálás mobilra menüpontot. Jelöld ki a fiókjaidat, majd olvasd be az összes megjelenő kódot. A kódok bármilyen sorrendben beolvashatók.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Folytatás $count fiókkal',
      one: 'Folytatás $count fiókkal',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Inkább szöveg beillesztése';

  @override
  String get accountImportStartOver => 'Újrakezdés';

  @override
  String get accountImportDuplicateCode => 'Ezt a kódot már hozzáadtad.';

  @override
  String get accountImportRestarted =>
      'Ez a kód egy új exportból származik, ezért a korábban beolvasott kódok félre lettek téve.';

  @override
  String get accountImportNotThunderbird => 'Ez nem Thunderbird-fiókkód.';

  @override
  String get accountImportNewerVersion =>
      'Ez a kód egy újabb Thunderbirdből származik. Az importáláshoz frissítsd a Loupe-ot.';

  @override
  String get accountImportDamaged => 'Ezt a Thunderbird-kódot nem sikerült beolvasni.';

  @override
  String get accountImportTooLarge => 'Ez a kód túl nagy ahhoz, hogy Thunderbird-export legyen.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nem sikerült megnyitni a Beállításokat.';

  @override
  String get accountImportCameraOffTitle => 'A kamera-hozzáférés ki van kapcsolva';

  @override
  String get accountImportCameraOffText =>
      'A kód beolvasásához engedélyezd a Loupe-nak a kamera használatát a Beállításokban, vagy illeszd be inkább a kód szövegét.';

  @override
  String get accountImportNoCameraTitle => 'Nincs kamera';

  @override
  String get accountImportNoCameraText => 'A Loupe itt nem tud kamerát használni. Illeszd be inkább a kód szövegét.';

  @override
  String get accountImportCameraFailedTitle => 'A kamera nem indult el';

  @override
  String get accountImportCameraFailedText => 'Próbáld újra, vagy illeszd be inkább a kód szövegét.';

  @override
  String get accountImportOpenSettings => 'Beállítások megnyitása';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fiók található',
      one: '$count fiók található',
      zero: 'Nem található fiók',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'A kódokban lévő fiókok közül egyiket sem sikerült beolvasni.';

  @override
  String get accountImportChoose => 'Válaszd ki a Loupe-hoz hozzáadandó fiókokat.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$total kódból ezek nincsenek beolvasva: $codes, ezért a fiókjaik nem szerepelnek a listán.',
      one: '$total kódból ez nincs beolvasva: $codes, ezért a fiókjai nem szerepelnek a listán.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes és $last';
  }

  @override
  String get accountImportScanMore => 'További kódok beolvasása';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count fiókot nem sikerült beolvasni a kódokból. Lehet, hogy egy újabb Thunderbird beállításait használják.',
      one: '$count fiókot nem sikerült beolvasni a kódokból. Lehet, hogy egy újabb Thunderbird beállításait használja.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Újbóli beolvasás';

  @override
  String get accountImportAlreadyAdded => 'Ezzel a címmel már van fiók a Loupe-ban.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Hozzáadáskor ezzel jelentkezel be: $provider, ahogy a Thunderbirdben is.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Add hozzá a fiókot alkalmazásjelszóval (ehhez kétlépcsős azonosítás szükséges).';

  @override
  String get accountImportGmailNoSignIn =>
      'A Thunderbird a Google-lel jelentkezik be a Gmailbe. A „Bejelentkezés ezzel: Google” egy későbbi buildben érkezik; addig add hozzá a fiókot alkalmazásjelszóval (ehhez kétlépcsős azonosítás szükséges).';

  @override
  String get accountImportBrowserSignIn =>
      'A Thunderbird a böngészőben jelentkezik be ebbe a fiókba. A Loupe ezt még nem tudja: használj alkalmazásjelszót, ha a szolgáltatód kínál ilyet.';

  @override
  String get accountImportUnencrypted => 'Titkosítás nélkül kapcsolódik. Csak a saját hálózatodon használd.';

  @override
  String get accountImportEnterAgain => 'Add meg újra';

  @override
  String get accountImportAdded => 'Hozzáadva';

  @override
  String accountImportAdding(int index, int total) {
    return '$index/$total hozzáadása…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fiók hozzáadása',
      one: '$count fiók hozzáadása',
      zero: 'Fiókok hozzáadása',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Exportszöveg beillesztése';

  @override
  String get accountImportPasteText => 'Illeszd be egy Thunderbird-exportkód szövegét, soronként egy kódot.';

  @override
  String get accountImportPop3 => 'A POP3-fiókok nem támogatottak. A Loupe IMAP-pal a szerveren tartja a leveleket.';

  @override
  String get accountImportKerberos => 'Ez a fiók Kerberosszal jelentkezik be, amelyet a Loupe nem támogat.';

  @override
  String get accountImportNtlm => 'Ez a fiók NTLM-mel jelentkezik be, amelyet a Loupe nem támogat.';

  @override
  String get accountImportClientCertificate =>
      'Ez a fiók ügyféltanúsítvánnyal jelentkezik be, amelyet a Loupe még nem támogat.';

  @override
  String get accountImportMicrosoftSignIn =>
      'A Microsoft-bejelentkezés egy későbbi buildben érkezik. Az Outlook- és Microsoft 365-fiókok már nem fogadnak el jelszót levelezőalkalmazásoktól.';

  @override
  String get accountImportEnterPassword => 'Add meg a jelszót.';

  @override
  String get accountImportEnterAppPassword => 'Add meg az alkalmazásjelszót.';

  @override
  String get accountImportEnterApiToken => 'Add meg az API-tokent.';

  @override
  String get accountImportStorageFailed => 'A Loupe nem tudta megnyitni a fióktárolóját. Próbáld újra később.';

  @override
  String get accountImportFailed => 'A fiókot nem sikerült hozzáadni. Próbáld újra, vagy add hozzá kézzel.';

  @override
  String get composeNewMessageTitle => 'Új üzenet';

  @override
  String get composeAttach => 'Csatolás';

  @override
  String get composeSendLater => 'Küldés később';

  @override
  String composeSendAt(String time) {
    return 'Küldés: $time';
  }

  @override
  String get composeSendHint => 'Nyomd hosszan a későbbi küldéshez';

  @override
  String get composeNoAccount => 'Levelek küldéséhez adj hozzá egy fiókot.';

  @override
  String get composeTo => 'Címzett:';

  @override
  String get composeCc => 'Másolat:';

  @override
  String get composeBcc => 'Titkos másolat:';

  @override
  String composeCcBccFrom(String email) {
    return 'Másolat, titkos másolat, feladó: $email';
  }

  @override
  String get composeFromLabel => 'Feladó:';

  @override
  String get composeSubjectLabel => 'Tárgy:';

  @override
  String composeReplyTo(String address) {
    return 'Válaszcím: $address';
  }

  @override
  String get composeFrom => 'Feladó';

  @override
  String composeReplyFrom(String email) {
    return 'Válasz erről a címről: $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Küldés erről a címről: $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Erről a címről válaszolsz: $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Erről a címről küldöd: $email?';
  }

  @override
  String get composeDismiss => 'Elvetés';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nincs identitásként mentve · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Mentés identitásként';

  @override
  String composeAliasSaved(String email) {
    return '$email identitásként mentve.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Érvénytelen cím: $address';
  }

  @override
  String get composeOriginalNotFound => 'Nem található az eredeti üzenet.';

  @override
  String get composeDraftNotFound => 'Nem található a piszkozat.';

  @override
  String get composeAttachmentsLost => 'A mellékleteket nem sikerült visszaállítani. Add hozzá őket újra.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Néhány mellékletet nem sikerült hozzáadni: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'A mellékletek összmérete $size; egyes szerverek elutasítják az ilyen nagy üzeneteket.';
  }

  @override
  String get composeAttachFailed => 'Nem sikerült csatolni a fájlt.';

  @override
  String get composeInvalidAddressTitle => 'Érvénytelen cím';

  @override
  String composeInvalidAddress(String address) {
    return '„$address” nem érvényes e-mail-cím.';
  }

  @override
  String get composeNoSubjectTitle => 'Nincs tárgy';

  @override
  String get composeNoSubjectText => 'Ennek az üzenetnek nincs tárgya. Mégis elküldöd?';

  @override
  String get composeSentBeforeChanges =>
      'Az üzenet a módosításaid előtt elment; a módosítások a Piszkozatok közé kerültek.';

  @override
  String composeScheduled(String time) {
    return 'Ütemezve: $time';
  }

  @override
  String get composeSending => 'Küldés…';

  @override
  String get composeSent => 'Elküldve';

  @override
  String get composeSendFailed => 'Nem sikerült elküldeni. Próbáld újra.';

  @override
  String get composeAlreadySent => 'Már elküldve.';

  @override
  String get composeDiscardChanges => 'Módosítások elvetése';

  @override
  String get composeSaveChanges => 'Módosítások mentése';

  @override
  String get composeDeleteDraft => 'Piszkozat törlése';

  @override
  String get composeSaveDraft => 'Piszkozat mentése';

  @override
  String get composeDraftSaved => 'Piszkozat mentve';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date, $time-kor $name ezt írta:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date, $time-kor valaki ezt írta:';
  }

  @override
  String get composeForwardHeader => '---------- Továbbított üzenet ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Feladó: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dátum: $date, $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Tárgy: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Címzett: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Másolat: $addresses';
  }

  @override
  String get composeLaterToday => 'Ma később';

  @override
  String get composeTomorrowMorning => 'Holnap reggel';

  @override
  String get composeMondayMorning => 'Hétfő reggel';

  @override
  String get composePickDateTime => 'Dátum és idő kiválasztása…';

  @override
  String get composeSendWithoutDelay => 'Küldés késleltetés nélkül';

  @override
  String composeSendTimeToday(String time) {
    return 'Ma $time-kor';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Holnap $time-kor';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day $time-kor';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Ma $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Holnap $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Folytatod a piszkozat szerkesztését?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Egy üzenet nem lett elküldve, amikor a Loupe bezárult.',
      'one': 'Egy $name részére írt üzenet nem lett elküldve, amikor a Loupe bezárult.',
      'other': 'Egy $name és mások részére írt üzenet nem lett elküldve, amikor a Loupe bezárult.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject” nem lett elküldve, amikor a Loupe bezárult.',
      'one': '„$subject” ($name részére) nem lett elküldve, amikor a Loupe bezárult.',
      'other': '„$subject” ($name és mások részére) nem lett elküldve, amikor a Loupe bezárult.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Szerkesztés folytatása';

  @override
  String get composeRecoverySave => 'Mentés a Piszkozatokba';

  @override
  String get composeRecoveryDiscard => 'Elvetés';

  @override
  String get composeRecoverySaved => 'Mentve a Piszkozatokba';

  @override
  String get outboxSectionFailed => 'Nincs elküldve';

  @override
  String get outboxSectionSending => 'Küldés';

  @override
  String get outboxSectionScheduled => 'Ütemezett';

  @override
  String get outboxStatusQueued => 'Hamarosan elmegy';

  @override
  String get outboxStatusSending => 'Küldés…';

  @override
  String get outboxStatusFailed => 'Nincs elküldve';

  @override
  String get outboxNoRecipients => 'Nincs címzett';

  @override
  String get outboxNoSubject => '(Nincs tárgy)';

  @override
  String get outboxSendingFailed => 'A küldés nem sikerült.';

  @override
  String get outboxEmptyTitle => 'Nincs mit küldeni';

  @override
  String get outboxEmptyText => 'A később küldendő üzenetek itt várnak, amíg el nem jön az idejük.';

  @override
  String get outboxSendNow => 'Küldés most';

  @override
  String get outboxReschedule => 'Átütemezés';

  @override
  String get outboxRescheduleMenu => 'Átütemezés…';

  @override
  String get outboxRescheduleTitle => 'Átütemezés';

  @override
  String outboxRescheduled(String time) {
    return 'Átütemezve: $time';
  }

  @override
  String get outboxCancel => 'Megszakítás';

  @override
  String get outboxCancelSending => 'Küldés megszakítása…';

  @override
  String get outboxCancelTitle => 'Megszakítod a küldést?';

  @override
  String get outboxMoveToDrafts => 'Áthelyezés a Piszkozatokba';

  @override
  String get outboxDiscard => 'Üzenet elvetése';

  @override
  String get outboxMovedToDrafts => 'Áthelyezve a Piszkozatokba';

  @override
  String get outboxDiscarded => 'Üzenet elvetve';

  @override
  String get outboxAlreadySent => 'Már elküldve.';

  @override
  String get outboxBeingSent => 'Ez az üzenet küldés alatt áll.';

  @override
  String get outboxActionFailed => 'Ez nem sikerült. Az üzenet még a Kimenő mappában van.';

  @override
  String get notificationsBadgeInboxes => 'Olvasatlanok a beérkező levelek közt';

  @override
  String get notificationsBadgeVip => 'Olvasatlanok a VIP-ben';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Új levelek a VIP-jeidtől, bármely fiókban';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Új levelek itt: $email';
  }

  @override
  String get notificationsUnknownSender => 'Ismeretlen feladó';

  @override
  String get notificationsNoSubject => '(Nincs tárgy)';

  @override
  String get notificationsEncryptedMessage => 'Titkosított üzenet';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Új üzenet: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count új üzenet',
      one: '$count új üzenet',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Új üzenetek: $account';
  }

  @override
  String get platformInstantChannel => 'Azonnali kézbesítés';

  @override
  String get platformInstantChannelDescription =>
      'Akkor látható, amikor a Loupe új levelekre figyeli a postafiókjaidat';

  @override
  String get platformInstantTitle => 'Új levelek figyelése';

  @override
  String get platformInstantText => 'Az Azonnali kézbesítés be van kapcsolva';

  @override
  String get platformErrorBox => 'Hiba történt a megjelenítés közben. Lépj vissza, és próbáld újra.';

  @override
  String get welcomeTagline => 'A felszínen egyszerű,\na mélyben nagy tudású levelezés.';

  @override
  String get welcomeAccountsTitle => 'Minden fiók egyetlen nyugodt postafiókban';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail és bármely IMAP- vagy JMAP-szerver.';

  @override
  String get welcomeSearchTitle => 'Keresés, ami megtalálja';

  @override
  String get welcomeSearchText => 'Azonnali találatok a telefonodon, aztán a szerverről.';

  @override
  String get welcomePrivacyTitle => 'Eleve a magánszféra védelmére tervezve';

  @override
  String get welcomePrivacyText => 'Nincs követés. A távoli képek letiltva maradnak, amíg nem engedélyezed őket.';

  @override
  String get welcomeAddAccount => 'Fiók hozzáadása';

  @override
  String get welcomeImport => 'Importálás Thunderbirdből';

  @override
  String get welcomeTryDemo => 'Kipróbálás demó levelekkel';
}
