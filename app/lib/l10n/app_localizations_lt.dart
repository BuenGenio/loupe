// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get commonAdd => 'Pridėti';

  @override
  String get commonCancel => 'Atšaukti';

  @override
  String get commonClose => 'Uždaryti';

  @override
  String get commonDelete => 'Ištrinti';

  @override
  String get commonDone => 'Atlikta';

  @override
  String get commonEdit => 'Redaguoti';

  @override
  String get commonMore => 'Daugiau';

  @override
  String get commonMove => 'Perkelti';

  @override
  String get commonName => 'Vardas';

  @override
  String get commonNone => 'Nėra';

  @override
  String get commonOff => 'Išjungta';

  @override
  String get commonOk => 'Gerai';

  @override
  String get commonOn => 'Įjungta';

  @override
  String get commonOptional => 'Neprivaloma';

  @override
  String get commonPassword => 'Slaptažodis';

  @override
  String get commonRemove => 'Pašalinti';

  @override
  String get commonRetry => 'Kartoti';

  @override
  String get commonSave => 'Išsaugoti';

  @override
  String get commonSearch => 'Ieškoti';

  @override
  String get commonServer => 'Serveris';

  @override
  String get commonSettings => 'Nustatymai';

  @override
  String get commonShare => 'Bendrinti';

  @override
  String get commonTryAgain => 'Bandyti dar kartą';

  @override
  String get commonUndo => 'Anuliuoti';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų',
      few: '$count laiškai',
      one: '$count laiškas',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archyvuoti';

  @override
  String get mailDelete => 'Ištrinti';

  @override
  String get mailFlag => 'Pažymėti vėliavėle';

  @override
  String get mailForward => 'Persiųsti';

  @override
  String get mailMarkAsRead => 'Pažymėti kaip skaitytą';

  @override
  String get mailMarkAsUnread => 'Pažymėti kaip neskaitytą';

  @override
  String get mailMoveToJunk => 'Perkelti į šlamštą';

  @override
  String get mailNewMessage => 'Naujas laiškas';

  @override
  String get mailNoSubject => 'Be temos';

  @override
  String get mailReply => 'Atsakyti';

  @override
  String get mailReplyAll => 'Atsakyti visiems';

  @override
  String get mailSend => 'Siųsti';

  @override
  String get mailUnflag => 'Nuimti vėliavėlę';

  @override
  String get mailboxArchive => 'Archyvas';

  @override
  String get mailboxDrafts => 'Juodraščiai';

  @override
  String get mailboxInbox => 'Gauti laiškai';

  @override
  String get mailboxJunk => 'Šlamštas';

  @override
  String get mailboxOutbox => 'Siunčiamieji';

  @override
  String get mailboxSent => 'Išsiųsti laiškai';

  @override
  String get mailboxTrash => 'Šiukšliadėžė';

  @override
  String get conversationSomethingWentWrong => 'Kažkas nepavyko. Bandykite dar kartą.';

  @override
  String get conversationReplyToList => 'Atsakyti konferencijai';

  @override
  String get conversationReplyList => 'Atsakyti konferencijai';

  @override
  String get conversationThreadMuted => 'Gija nutildyta. Nauji jos laiškai bus gaunami kaip skaityti.';

  @override
  String get conversationThreadUnmuted => 'Gijos nutildymas atšauktas.';

  @override
  String get conversationLinkFailed => 'Nepavyko atidaryti nuorodos.';

  @override
  String get conversationGoneTitle => 'Laiško nėra';

  @override
  String get conversationGoneText => 'Šis laiškas perkeltas arba ištrintas.';

  @override
  String get conversationMuted => 'Nutildyta';

  @override
  String get conversationReaderOptions => 'Skaitymo parinktys';

  @override
  String get conversationReaderOptionsHint => 'Teksto dydis ir rodinys';

  @override
  String get conversationTrash => 'Į šiukšliadėžę';

  @override
  String get conversationReplyHint => 'Paspauskite ilgai, kad atsakytumėte visiems arba persiųstumėte';

  @override
  String get conversationOfflineTitle => 'Esate neprisijungę';

  @override
  String get conversationOfflineText => 'Šis pokalbis dar neatsisiųstas. Jis bus įkeltas, kai vėl prisijungsite.';

  @override
  String get conversationErrorTitle => 'Nepavyksta parodyti šio laiško';

  @override
  String get conversationErrorText => 'Kažkas nepavyko.';

  @override
  String get conversationOfflineBanner => 'Esate neprisijungę';

  @override
  String get conversationNotUpdated => 'Neatnaujinta';

  @override
  String get conversationMe => 'aš';

  @override
  String get conversationNoSender => '(nėra siuntėjo)';

  @override
  String get conversationNoRecipients => 'nėra gavėjų';

  @override
  String conversationRecipients(String names) {
    return 'kam: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'kam: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Nuo';

  @override
  String get conversationHeaderTo => 'Kam';

  @override
  String get conversationHeaderCc => 'Kopija';

  @override
  String get conversationHeaderBcc => 'Slapta kopija';

  @override
  String get conversationHeaderReplyTo => 'Atsakyti kam';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Saugumas';

  @override
  String get conversationVerifiedSender => 'Patvirtintas siuntėjas';

  @override
  String get conversationUnverifiedSender => 'Nepatvirtintas siuntėjas';

  @override
  String get conversationLoadingMessage => 'Įkeliamas laiškas';

  @override
  String get conversationBodyError => 'Šio laiško nepavyko įkelti.';

  @override
  String get conversationBodyOffline => 'Esate neprisijungę. Laiškas bus įkeltas, kai vėl prisijungsite.';

  @override
  String get conversationOriginalHint => 'Geriau atrodo rodinyje „Originalas“';

  @override
  String get conversationShowOriginal => 'Rodyti originalą';

  @override
  String get conversationScrollToTop => 'Slinkti į viršų';

  @override
  String get conversationTagsMenu => 'Žymės…';

  @override
  String get conversationMuteThread => 'Nutildyti giją';

  @override
  String get conversationUnmuteThread => 'Atšaukti gijos nutildymą';

  @override
  String get conversationMoveMenu => 'Perkelti…';

  @override
  String get conversationDeletePermanently => 'Ištrinti visam laikui';

  @override
  String get conversationMoveToTrash => 'Perkelti į šiukšliadėžę';

  @override
  String get conversationNotJunk => 'Ne šlamštas';

  @override
  String get conversationShowAllHeaders => 'Rodyti visas antraštes';

  @override
  String get conversationViewSource => 'Rodyti šaltinį';

  @override
  String get conversationSaveAsFile => 'Išsaugoti kaip failą…';

  @override
  String get conversationShareAsFile => 'Bendrinti kaip failą…';

  @override
  String get conversationSearchFromMessageMenu => 'Ieškoti pagal šį laišką…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopijuoti adresą';

  @override
  String get conversationAddressCopied => 'Adresas nukopijuotas';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Ieškoti siuntėjo $name laiškų';
  }

  @override
  String get conversationTags => 'Žymės';

  @override
  String get conversationAllHeaders => 'Visos antraštės';

  @override
  String get conversationCopyAll => 'Kopijuoti viską';

  @override
  String get conversationHeadersCopied => 'Antraštės nukopijuotos';

  @override
  String get conversationNoHeaders => 'Antraščių nėra';

  @override
  String get conversationSearchFromMessageTitle => 'Ieškoti pagal šį laišką';

  @override
  String conversationSearchFrom(String name) {
    return 'Nuo: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Kam: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Tema „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Šaltinis';

  @override
  String get conversationSourceCopied => 'Šaltinis nukopijuotas';

  @override
  String get conversationShareFailed => 'Nepavyko bendrinti laiško.';

  @override
  String get conversationWrapLines => 'Laužyti eilutes';

  @override
  String get conversationDontWrapLines => 'Nelaužyti eilučių';

  @override
  String get conversationSourceError => 'Šaltinio nepavyko įkelti.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Rodomi pirmieji $shown iš $total. Norėdami gauti viską, nukopijuokite arba bendrinkite.';
  }

  @override
  String get conversationAttachmentUntitled => 'Be pavadinimo';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Daugiau veiksmų su $name';
  }

  @override
  String get conversationMoveTo => 'Perkelti į…';

  @override
  String get conversationMailboxesError => 'Nepavyko įkelti pašto dėžučių.';

  @override
  String get conversationReaderReadable => 'Skaitymui';

  @override
  String get conversationReaderOriginal => 'Originalas';

  @override
  String get conversationReaderPlain => 'Paprastas';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Išlaikyti originalias spalvas';

  @override
  String get conversationReaderRemember => 'Įsiminti šiam siuntėjui';

  @override
  String get conversationSecurityPossiblePhishing => 'Galimas sukčiavimas';

  @override
  String get conversationSecurityBeCareful => 'Būkite atsargūs';

  @override
  String get conversationSecurityVerified => 'Patvirtinta';

  @override
  String get conversationSecurityNoIssues => 'Problemų nerasta';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sekiklių',
      few: '$count sekikliai',
      one: '$count sekiklis',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Parodo priežastį';

  @override
  String get conversationPhishingBannerTitle => 'Šis laiškas panašus į sukčiavimą';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Nuorodos ir vaizdai išjungti.';
  }

  @override
  String get conversationPhishingBannerText => 'Nuorodos ir vaizdai išjungti.';

  @override
  String get conversationPhishingWhy => 'Kodėl?';

  @override
  String get conversationPhishingShowAnyway => 'Vis tiek rodyti';

  @override
  String get conversationSecurityPhishingTitle => 'Panašu į sukčiavimą';

  @override
  String get conversationSecurityPhishingText => 'Keli požymiai rodo, kad šis laiškas nėra tas, kuo dedasi.';

  @override
  String get conversationSecurityCarefulTitle => 'Būkite atsargūs su šiuo laišku';

  @override
  String get conversationSecurityCarefulText => 'Kai ką jame verta patikrinti dar kartą.';

  @override
  String get conversationSecurityVerifiedText => 'Siuntėjas patvirtintas, ir niekas neatrodo įtartina.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Niekas neatrodo įtartina. Jūsų pašto serveris nenurodė, ar siuntėjas patvirtintas.';

  @override
  String get conversationSecurityNothingSuspicious => 'Niekas neatrodo įtartina.';

  @override
  String get conversationSecurityWhy => 'Kodėl';

  @override
  String get conversationSecurityPrivacy => 'Privatumas';

  @override
  String get conversationSecurityNoTrackingPixels => 'Sekimo pikselių nėra';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pašalinta $count sekimo pikselių',
      few: 'Pašalinti $count sekimo pikseliai',
      one: 'Pašalintas $count sekimo pikselis',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Jie būtų pranešę siuntėjui, kada atidarėte šį laišką.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nuotolinių vaizdų nėra';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuotolinių vaizdų',
      few: '$count nuotoliniai vaizdai',
      one: '$count nuotolinis vaizdas',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Juos įkėlus siuntėjas sužinos, kada skaitote šį laišką, ir jūsų IP adresą.';

  @override
  String get conversationSecurityNoClickTracking => 'Paspaudimai nesekami';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuorodų per paspaudimų sekiklius',
      few: '$count nuorodos per paspaudimų sekiklius',
      one: '$count nuoroda per paspaudimų sekiklius',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services užfiksuotų jūsų paspaudimą. Paspauskite nuorodą ilgai, kad atidarytumėte jos tikslą tiesiogiai.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Techninė informacija';

  @override
  String get conversationSecurityCheckedLocally => 'Patikrinta šiame įrenginyje. Niekas niekur nebuvo išsiųsta.';

  @override
  String get conversationSecurityTrackersLabel => 'Sekikliai';

  @override
  String get conversationSecurityImagesFrom => 'Vaizdai iš';

  @override
  String get conversationSecuritySenderHistory => 'Siuntėjo istorija';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'gauta: $received, išsiųsta: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Nuorodos veda į';

  @override
  String get conversationSecurityHidden => 'Paslėpta';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementų',
      few: '$elements elementai',
      one: '$elements elementas',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters simbolių',
      few: '$characters simboliai',
      one: '$characters simbolis',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Siuntėjas nepatvirtintas';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Jūsų pašto serveris negalėjo patvirtinti, kad šis laiškas tikrai atėjo iš $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Jūsų pašto serveris negalėjo patvirtinti, kad šis laiškas tikrai atėjo iš jo siuntėjo.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Jūsų pašto serveris negalėjo patvirtinti, kad šis laiškas atėjo iš $domain. Tai įprasta el. pašto konferencijoms.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Jūsų pašto serveris negalėjo patvirtinti, kad šis laiškas atėjo iš jo siuntėjo. Tai įprasta el. pašto konferencijoms.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nesiimkite jokių veiksmų, nebent šio laiško laukėte. Jei abejojate, susisiekite su siuntėju kitu būdu.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Pasirašyta kito domeno';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Laišką pasirašė $signer, o ne $domain. Taip daro laiškų siuntimo paslaugos, bet tai neįrodo, kas jį parašė.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Laišką pasirašė kitas domenas, o ne $domain. Taip daro laiškų siuntimo paslaugos, bet tai neįrodo, kas jį parašė.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Varde rodomas kitas adresas';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Siuntėjo vardas yra „$shown“, bet laiškas atėjo iš $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Pasitikėkite adresu, o ne vardu.';

  @override
  String get conversationSecurityReplyToTitle => 'Atsakymai keliauja kitur';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Jūsų atsakymas būtų išsiųstas adresu $address, o ne į $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Prieš atsakydami ką nors asmeniško, patikrinkite adresą.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Naudoja jūsų vardą';

  @override
  String get conversationSecurityImpersonationTitle => 'Naudoja jūsų pažįstamo žmogaus vardą';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Pasirašyta „$name“, kaip ir jūsų vardas, bet laiškas atėjo iš naujo adreso: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Pasirašyta „$name“, kaip ir jūsų VIP $knownName ($knownEmail), bet laiškas atėjo iš naujo adreso: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Pasirašyta „$name“, kaip ir $knownName ($knownEmail), bet laiškas atėjo iš naujo adreso: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'O atsakymai keliautų dar kitu adresu.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Jei prašoma pinigų, kodų ar failų, pirmiausia pasitikrinkite pas tą žmogų kitu būdu.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Žinomas adresas: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Šis adresas: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Pirmas laiškas iš šio siuntėjo';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Iš $email anksčiau laiškų negavote.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Būkite atsargūs su dar nepažįstamų žmonių prašymais.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Panašiai atrodančios raidės siuntėjo adrese';

  @override
  String get conversationSecurityLinkHomographTitle => 'Panašiai atrodančios raidės nuorodoje';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host maišo skirtingų abėcėlių raides, kad imituotų kitą adresą.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host naudoja panašiai atrodančias raides: tai ne $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Ištrinkite jį arba praneškite apie jį kaip apie šlamštą.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Neatidarykite jos.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domenas: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Panašiai atrodantis domenas';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Domene naudojamas žinomas pavadinimas';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain panašus į jūsų domeną $real, bet tai kitas domenas.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain panašus į $brand ($real), bet tai kitas domenas.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain naudoja jūsų domeno $real pavadinimą, bet jam nepriklauso.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain naudoja $brand ($real) pavadinimą, bet jam nepriklauso.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Tikri jūsų organizacijos laiškai ateina iš $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Tikri $brand laiškai ateina iš $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Siuntėjo domenas: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imituoja: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuorodų slepia, kur veda',
      few: '$count nuorodos slepia, kur veda',
      one: '$count nuoroda slepia, kur veda',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Nuorodoje rodomas $shown, bet ji atidaro $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Neprisijunkite ir nemokėkite per šias nuorodas. Geriau įveskite adresą patys.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Nuorodos tikslo patikrinti neįmanoma';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Nuorodoje rodomas $shown, bet ji eina per $host, kuris užfiksuoja paspaudimą ir tik tada perduoda jį toliau.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Nuoroda veda į IP adresą';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nėra svetainė su pavadinimu. Tikros įmonės retai pateikia tokias nuorodas.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Užmaskuota nuoroda';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Nuoroda prasideda „$shown@“, kad atrodytų kaip $shown, bet atidaro $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Paslėptas puslapis išjungtas';

  @override
  String get conversationSecurityDataLinkText =>
      'Nuoroda būtų atidariusi į laišką įdėtą puslapį – tai būdas apeiti nuorodų patikras.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Prašo slaptažodžio';

  @override
  String get conversationSecurityPasswordFieldText => 'Laiške buvo slaptažodžio laukas. Loupe jį pašalino.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Niekada neįveskite slaptažodžio el. laiške.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Kodą vykdanti nuoroda išjungta';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe niekada nevykdo kodo iš laiškų.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sutrumpintų nuorodų',
      few: '$count sutrumpintos nuorodos',
      one: '$count sutrumpinta nuoroda',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts slepia tikrąjį tikslą, kol jo neatidarote.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Tarptautinis žiniatinklio adresas';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts naudoja ne lotyniškas raides. Daugeliui kalbų tai įprasta; patikrinkite, ar tai svetainė, kurios tikitės.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Daug paslėpto teksto';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pašalinta $count nematomo teksto simbolių. Toks paslėptas tekstas skirtas apgauti šlamšto filtrus.',
      few: 'Pašalinti $count nematomo teksto simboliai. Toks paslėptas tekstas skirtas apgauti šlamšto filtrus.',
      one: 'Pašalintas $count nematomo teksto simbolis. Toks paslėptas tekstas skirtas apgauti šlamšto filtrus.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Paslėptas tekstas pašalintas';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pašalinta $count nematomo teksto simbolių.',
      few: 'Pašalinti $count nematomo teksto simboliai.',
      one: 'Pašalintas $count nematomo teksto simbolis.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Nepavyko atsisiųsti laiško. Patikrinkite ryšį ir bandykite dar kartą.';

  @override
  String exportSaved(String name) {
    return 'Išsaugota: „$name“';
  }

  @override
  String get exportSaveFailed => 'Nepavyko išsaugoti laiško.';

  @override
  String exportFailed(String folder) {
    return 'Nepavyko eksportuoti „$folder“.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Aplanke „$folder“ nėra laiškų, kuriuos būtų galima eksportuoti.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Nepavyko eksportuoti „$folder“: nepavyko atsisiųsti nė vieno laiško. Patikrinkite ryšį ir bandykite dar kartą.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Išsaugota „$name“ be $formattedCount laiškų, kurių nepavyko atsisiųsti.',
      few: 'Išsaugota „$name“ be $formattedCount laiškų, kurių nepavyko atsisiųsti.',
      one: 'Išsaugota „$name“ be $count laiško, kurio nepavyko atsisiųsti.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Nepavyko išsaugoti „$name“.';
  }

  @override
  String exportTitle(String folder) {
    return 'Eksportuojama: „$folder“';
  }

  @override
  String get exportListing => 'Ieškoma laiškų…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksportuojamas $current iš $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nepavyko atsisiųsti $formattedCount laiškų',
      few: 'Nepavyko atsisiųsti $formattedCount laiškų',
      one: 'Nepavyko atsisiųsti $count laiško',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Pašto dėžutės';

  @override
  String get mailboxesShown => 'Rodoma';

  @override
  String get mailboxesHidden => 'Paslėpta';

  @override
  String get mailboxesCollapse => 'Sutraukti';

  @override
  String get mailboxesExpand => 'Išskleisti';

  @override
  String get mailboxesManageVips => 'Tvarkyti VIP';

  @override
  String get mailboxesSubscriptions => 'Prenumeratos';

  @override
  String mailboxesShowAccount(String account) {
    return 'Rodyti $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Slėpti $account';
  }

  @override
  String get mailboxesExportFolder => 'Eksportuoti aplanką…';

  @override
  String get mailboxesUnpin => 'Atsegti';

  @override
  String get mailboxesLists => 'Konferencijos';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Išsaugokite paiešką, kad ji būtų čia.';

  @override
  String get mailboxesTags => 'Žymės';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Taip pat galite laiške bakstelėti siuntėjo vardą ir įjungti VIP.';

  @override
  String get mailboxesAddVip => 'Pridėti VIP…';

  @override
  String get mailboxesAddVipTitle => 'Pridėti VIP';

  @override
  String get mailboxesAddVipText => 'Laiškai iš šio adreso pažymimi žvaigždute ir rodomi VIP pašto dėžutėje.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Neskaityti';

  @override
  String get messageListFilterFlagged => 'Su vėliavėle';

  @override
  String get messageListFilterToMe => 'Kam: aš';

  @override
  String get messageListFilterCcMe => 'Kopija: aš';

  @override
  String get messageListFilterWithAttachments => 'Su priedais';

  @override
  String get messageListFilterUnreplied => 'Neatsakyti';

  @override
  String get messageListFilterFromVips => 'Nuo VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų pažymėta kaip skaityti',
      few: '$count laiškai pažymėti kaip skaityti',
      one: '$count laiškas pažymėtas kaip skaitytas',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Nepavyko įkelti senesnių laiškų.';

  @override
  String get messageListSelectMessages => 'Pasirinkite laiškus';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pasirinkta $count',
      few: 'Pasirinkti $count',
      one: 'Pasirinktas $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Pasirinkti viską';

  @override
  String get messageListDeselectAll => 'Atžymėti viską';

  @override
  String get messageListLoadFailed => 'Nepavyko įkelti laiškų';

  @override
  String get messageListNoUnread => 'Neskaitytų laiškų nėra';

  @override
  String get messageListNoMatches => 'Atitinkančių laiškų nėra';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtruojama pagal: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Išjungti filtrą';

  @override
  String get messageListEmpty => 'Laiškų nėra';

  @override
  String get messageListFilter => 'Filtras';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtro kriterijai: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtruojama pagal:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount neskaitytų',
      few: '$formattedCount neskaityti',
      one: '$count neskaitytas',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Žymėti';

  @override
  String get messageListTrash => 'Į šiukšliadėžę';

  @override
  String get messageListFilterTitle => 'Filtras';

  @override
  String get messageListFilterInclude => 'ĮTRAUKTI';

  @override
  String get panesHideMailboxes => 'Slėpti pašto dėžutes';

  @override
  String get panesShowMailboxes => 'Rodyti pašto dėžutes';

  @override
  String get panesMailboxesWidth => 'Pašto dėžučių stulpelio plotis';

  @override
  String get panesListWidth => 'Laiškų sąrašo plotis';

  @override
  String get panesNoMessageSelected => 'Nepasirinktas joks laiškas';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų',
      few: '$count laiškai',
      one: '$count laiškas',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Atidėti';

  @override
  String get snoozeSheetTitle => 'Atidėti';

  @override
  String get snoozeLaterToday => 'Vėliau šiandien';

  @override
  String get snoozeThisEvening => 'Šįvakar';

  @override
  String get snoozeTomorrow => 'Rytoj';

  @override
  String get snoozeThisWeekend => 'Šį savaitgalį';

  @override
  String get snoozeNextWeek => 'Kitą savaitę';

  @override
  String get snoozePickDateTime => 'Pasirinkti datą ir laiką…';

  @override
  String get snoozeMenu => 'Atidėti…';

  @override
  String get snoozeWakeNow => 'Grąžinti dabar';

  @override
  String get snoozeChangeTimeMenu => 'Keisti atidėjimo laiką…';

  @override
  String get snoozeChangeTime => 'Keisti laiką';

  @override
  String get snoozeNoTime => 'Laikas nenustatytas';

  @override
  String get snoozeFooter => 'Atidėti laiškai nustatytu laiku grįžta į aplanką „Gauti laiškai“ kaip neskaityti.';

  @override
  String get snoozeEmptyTitle => 'Atidėtų laiškų nėra';

  @override
  String get snoozeEmptyText => 'Atidėkite laišką, kad jis grįžtų į aplanką „Gauti laiškai“ tada, kai jums jo reikės.';

  @override
  String get appLockUnlock => 'Atrakinti';

  @override
  String get appLockFailed => 'Loupe nepavyko patvirtinti, kad tai jūs.';

  @override
  String get appLockLockedOut => 'Per daug bandymų. Bandykite vėliau.';

  @override
  String get appLockPromptError => 'Nepavyko parodyti užklausos. Bandykite dar kartą.';

  @override
  String get appLockNoScreenLock => 'Šiame telefone nenustatytas ekrano užraktas.';

  @override
  String get appLockUnlockPromptTitle => 'Atrakinti Loupe';

  @override
  String get appLockUnlockPromptReason => 'Patvirtinkite, kad tai jūs, ir matysite savo paštą.';

  @override
  String get appLockTurnOnPromptTitle => 'Įjungti programėlės užraktą';

  @override
  String get appLockTurnOnPromptReason => 'Patvirtinkite, kad tai jūs, ir įjungsite programėlės užraktą.';

  @override
  String get appLockScreenLockRemoved =>
      'Programėlės užraktas išjungtas: šiame telefone nebėra ekrano užrakto. Nustatykite jį, kad vėl įjungtumėte programėlės užraktą.';

  @override
  String get appLockAfterImmediately => 'Iš karto';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minučių',
      few: '$count minutės',
      one: '$count minutė',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count valandų',
      few: '$count valandos',
      one: '$count valanda',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Šifruotas';

  @override
  String get openpgpEncryptedInPart => 'Iš dalies šifruotas';

  @override
  String get openpgpEncryptedLocked => 'Šifruotas · užrakintas';

  @override
  String get openpgpEncryptedNoKey => 'Šifruotas · nėra rakto';

  @override
  String get openpgpEncryptedDamaged => 'Šifruotas · sugadintas';

  @override
  String get openpgpEncryptedUnsupported => 'Šifruotas · nepalaikomas';

  @override
  String get openpgpUnknownSigner => 'nežinomas';

  @override
  String get openpgpUnknownKey => 'Nežinomas raktas';

  @override
  String get openpgpSignatureInvalid => 'Netinkamas parašas';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Pasirašė $name, o ne siuntėjas';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Iš dalies pasirašė $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Pasirašė $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Pasirašyta atmestu raktu';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Pasirašė $name · raktas nepriimtas';
  }

  @override
  String get openpgpUnlock => 'Atrakinti';

  @override
  String get openpgpCantDecrypt => 'Nepavyksta iššifruoti šio laiško';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifruota naudojant OpenPGP';

  @override
  String get openpgpEncryption => 'Šifravimas';

  @override
  String get openpgpDecryptedHere => 'Iššifruota šiame įrenginyje';

  @override
  String get openpgpNotDecrypted => 'Neiššifruota';

  @override
  String get openpgpKeyLocked => 'Jūsų raktas užrakintas.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Raktų ID: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Apsaugota tema';

  @override
  String get openpgpUnlockKey => 'Atrakinti raktą';

  @override
  String get openpgpSignature => 'Parašas';

  @override
  String get openpgpFingerprint => 'Kontrolinis kodas';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Rakto ID $id';
  }

  @override
  String get openpgpSigned => 'Pasirašyta';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Priėmimas';

  @override
  String get openpgpChangeAcceptance => 'Keisti priėmimą…';

  @override
  String get openpgpCheckedFooter => 'Patikrinta šiame įrenginyje naudojant OpenPGP, suderinamą su Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Jūsų raktas užrakintas. Atrakinkite jį slaptafraze, kad perskaitytumėte šį laišką.';

  @override
  String get openpgpSummaryNoSecretKey => 'Jis užšifruotas raktui, kurio šiame įrenginyje nėra.';

  @override
  String get openpgpSummaryDamaged => 'Šifruoti duomenys sugadinti arba buvo pakeisti pakeliui.';

  @override
  String get openpgpSummaryUnsupported => 'Jame naudojamas algoritmas, kurio Loupe nepalaiko.';

  @override
  String get openpgpSummaryEncrypted => 'Jį gali perskaityti tik jūs ir kiti gavėjai.';

  @override
  String get openpgpSummaryNotSigned => 'Jis nepasirašytas, todėl siuntėjas nepatvirtintas.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Jis pasirašytas, bet raktu, kurio neturite, todėl parašo patikrinti neįmanoma.';

  @override
  String get openpgpSummaryBadSignature => 'Parašas neatitinka: laiškas galėjo būti pakeistas.';

  @override
  String get openpgpSummaryMismatch => 'Parašas galioja, bet raktas priklauso ne siuntėjo, o kitam adresui.';

  @override
  String get openpgpSummaryPartial =>
      'Pasirašyta tik dalis laiško. Tekstas už parašo ribų (pavyzdžiui, el. pašto konferencijos poraštė) rodomas po eilute „Unsigned content“, o kitos laiško dalys, pavyzdžiui, priedai, parašu taip pat neapsaugotos.';

  @override
  String get openpgpSummaryOwnKey => 'Pasirašyta jūsų pačių raktu.';

  @override
  String get openpgpSummaryVerified => 'Parašas galioja, ir jūs patikrinote rakto kontrolinį kodą.';

  @override
  String get openpgpSummaryUnverified => 'Parašas galioja. Raktą priėmėte nepatikrinę jo kontrolinio kodo.';

  @override
  String get openpgpSummaryRejected => 'Parašas galioja, bet jūs atmetėte šį raktą.';

  @override
  String get openpgpSummaryUndecided =>
      'Parašas galioja, bet šio rakto dar nepriėmėte. Palyginkite jo kontrolinį kodą su siuntėju.';

  @override
  String get openpgpAcceptanceRejected => 'Atmestas';

  @override
  String get openpgpAcceptanceUndecided => 'Nepriimtas';

  @override
  String get openpgpAcceptanceUnverified => 'Priimtas';

  @override
  String get openpgpAcceptanceVerified => 'Priimtas ir patikrintas';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Priimti $name raktą?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Kontrolinis kodas $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Taip, patikrinau kontrolinį kodą';

  @override
  String get openpgpAcceptUnverified => 'Taip, netikrinant';

  @override
  String get openpgpAcceptLater => 'Dar ne';

  @override
  String get openpgpRejectKey => 'Atmesti šį raktą';

  @override
  String get openpgpNoSubject => '(be temos)';

  @override
  String get openpgpEncryptionTitle => 'Ištisinis šifravimas';

  @override
  String get openpgpMyKeys => 'Mano OpenPGP raktai';

  @override
  String get openpgpMyKeysFooter =>
      'Turėdami raktą galite skaityti šifruotus laiškus, taip pat pasirašyti ir šifruoti savo laiškus. Naudojate Thunderbird? Eksportuokite raktą ten (Paskyros nustatymai › Ištisinis šifravimas › Eksportuoti slaptąjį raktą) ir importuokite jį čia.';

  @override
  String get openpgpAddKey => 'Pridėti raktą…';

  @override
  String get openpgpAddresses => 'Adresai';

  @override
  String get openpgpAddressesFooter => 'Kurį raktą naudoja kiekvienas adresas ir kada jis šifruoja bei pasirašo.';

  @override
  String get openpgpCorrespondentsKeys => 'Adresatų OpenPGP raktai';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Priimkite raktą, kai pasitikite, kad jis priklauso savininkui; palyginkite su juo kontrolinį kodą, kad pažymėtumėte raktą kaip patikrintą.';

  @override
  String get openpgpImportPublicKey => 'Importuoti viešąjį raktą…';

  @override
  String get openpgpCollected => 'Surinkti per Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Raktai, atėję kartu su laiškais. Loupe gali jais šifruoti, kai to pageidauja abi pusės.';

  @override
  String get openpgpOnThisDevice => 'Šiame įrenginyje';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifruoti laiškai slepia savo temą. Loupe išsaugo kiekvieno atidaryto laiško temą savo šifruotoje duomenų bazėje šiame įrenginyje, kad ją rodytų sąrašas, paieška ir pranešimai. Fone Loupe taip pat gali iššifruoti naujų laiškų temas raktais, kurie neturi slaptafrazės; tam ji atsisiunčia kiekvieną laišką (iki 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Iššifruoti temas fone';

  @override
  String get openpgpIndexFooter =>
      'Paieška randa šifruotus laiškus pagal siuntėją, gavėjus ir temą. Kai ši parinktis įjungta, Loupe taip pat įtraukia kiekvieno iššifruoto laiško tekstą į paieškos indeksą savo šifruotoje duomenų bazėje šiame įrenginyje, todėl paieška juos randa ir pagal tekstą. Išjungus šis tekstas pašalinamas iš indekso.';

  @override
  String get openpgpIndexDecrypted => 'Indeksuoti iššifruotus laiškus paieškai';

  @override
  String get openpgpPassphrases => 'Slaptafrazės';

  @override
  String get openpgpPassphrasesFooter =>
      'Slaptafraze apsaugoti OpenPGP raktai ir S/MIME sertifikatai atrakinami, kai jų reikia. Be parinkties „Įsiminti slaptafrazes“ jie vėl užrakinami praėjus dviem minutėms po kiekvieno naudojimo.';

  @override
  String get openpgpRememberPassphrases => 'Įsiminti slaptafrazes';

  @override
  String get openpgpRememberPassphrasesDetail => 'Kol Loupe bus uždaryta';

  @override
  String get openpgpLockKeysNow => 'Užrakinti raktus dabar';

  @override
  String get openpgpKeysLocked => 'Raktai užrakinti.';

  @override
  String get openpgpKeyStateRevoked => 'atšauktas';

  @override
  String get openpgpKeyStateExpired => 'nebegalioja';

  @override
  String get openpgpKeyStateNeverExpires => 'galioja neribotai';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'galioja iki $date';
  }

  @override
  String get openpgpNoKey => 'Nėra rakto';

  @override
  String get openpgpAlwaysEncrypt => 'Visada šifruoti';

  @override
  String get openpgpAddKeyTitle => 'Pridėti OpenPGP raktą';

  @override
  String get openpgpAddKeyMessage => 'Importuokite raktą, kurį naudojate Thunderbird, arba sukurkite naują.';

  @override
  String get openpgpImportFromClipboard => 'Importuoti iš iškarpinės';

  @override
  String get openpgpImportFromFile => 'Importuoti iš failo';

  @override
  String get openpgpGenerateNewKey => 'Sukurti naują raktą';

  @override
  String get openpgpImportPublicKeyTitle => 'Importuoti viešąjį raktą';

  @override
  String get openpgpFromClipboard => 'Iš iškarpinės';

  @override
  String get openpgpFromFile => 'Iš failo';

  @override
  String get openpgpClipboardEmpty => 'Iškarpinė tuščia. Pirmiausia nukopijuokite raktą.';

  @override
  String get openpgpKey => 'Raktas';

  @override
  String get openpgpValidityRevoked => 'Atšauktas';

  @override
  String openpgpValidityExpired(String date) {
    return 'Nebegalioja nuo $date';
  }

  @override
  String get openpgpNeverExpires => 'Galioja neribotai';

  @override
  String openpgpValidUntil(String date) {
    return 'Galioja iki $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Kontrolinis kodas nukopijuotas.';

  @override
  String get openpgpAlgorithm => 'Algoritmas';

  @override
  String get openpgpCreated => 'Sukurtas';

  @override
  String get openpgpValidity => 'Galiojimas';

  @override
  String get openpgpProtection => 'Apsauga';

  @override
  String get openpgpProtectionPassphrase => 'Slaptafrazė';

  @override
  String get openpgpProtectionKeychain => 'Tik raktų saugykla';

  @override
  String get openpgpKeyDetailsFooter =>
      'Bendrinkite savo viešąjį raktą, kad kiti galėtų jums siųsti šifruotus laiškus. Atsarginė kopija – tai jūsų slaptasis raktas, apsaugotas slaptafraze, jei ji yra: laikykite jį privačiai.';

  @override
  String get openpgpSharePublicKey => 'Bendrinti viešąjį raktą';

  @override
  String get openpgpCopyPublicKey => 'Kopijuoti viešąjį raktą';

  @override
  String get openpgpPublicKeyCopied => 'Viešasis raktas nukopijuotas.';

  @override
  String get openpgpBackUpSecretKey => 'Kurti slaptojo rakto atsarginę kopiją';

  @override
  String get openpgpDeleteKey => 'Ištrinti raktą';

  @override
  String get openpgpRemoveKey => 'Pašalinti raktą';

  @override
  String get openpgpBackUpTitle => 'Kurti slaptojo rakto atsarginę kopiją?';

  @override
  String get openpgpBackUpProtected =>
      'Atsarginę kopiją saugo jūsų rakto slaptafrazė. Kas turi abi, gali skaityti jūsų paštą.';

  @override
  String get openpgpBackUpUnprotected =>
      'Šis raktas neturi slaptafrazės: bet kas, turintis atsarginę kopiją, gali skaityti jūsų paštą ir pasirašyti jūsų vardu.';

  @override
  String get openpgpBackUp => 'Kurti kopiją';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Ištrinti savo raktą $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Pašalinti $name raktą?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Šiam raktui užšifruotų laiškų šiame įrenginyje nebebus galima perskaityti, nebent vėl jį importuosite.';

  @override
  String get openpgpRemoveKeyMessage => 'Vėliau galėsite jį vėl importuoti.';

  @override
  String get openpgpKeyHeader => 'OpenPGP raktas';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Pridėkite raktą skiltyje „Ištisinis šifravimas“, kad galėtumėte šifruoti ir pasirašyti laiškus iš šio adreso.';

  @override
  String get openpgpGenerateAKey => 'Sukurti raktą…';

  @override
  String get openpgpSending => 'Siuntimas';

  @override
  String get openpgpSendingFooter =>
      'Automatinis šifravimas įsijungia, kai kiekvienas gavėjas turi priimtą raktą arba patikimą sertifikatą, arba kai Autocrypt nurodo, kad to nori abi pusės. Šifruoti laiškai visada pasirašomi.';

  @override
  String get openpgpEncryptAutomatically => 'Šifruoti automatiškai';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nesiunčia, jei gavėjas neturi rakto';

  @override
  String get openpgpSignUnencrypted => 'Pasirašyti nešifruotus laiškus';

  @override
  String get openpgpAttachPublicKey => 'Pridėti mano viešąjį raktą';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt kartu su kiekvienu laišku siunčia jūsų viešąjį raktą, kad kitos programos galėtų jums siųsti šifruotus laiškus be jokios sąrankos.';

  @override
  String get openpgpSendMyKey => 'Siųsti mano raktą su laiškais';

  @override
  String get openpgpPreferEncryption => 'Teikti pirmenybę šifravimui';

  @override
  String get openpgpPreferEncryptionDetail => 'Prašyti kitų šifruoti, kai jie gali';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count metų',
      few: '$count metai',
      one: '$count metai',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Slaptafrazės nesutampa.';

  @override
  String openpgpKeyReady(String id) {
    return 'Jūsų raktas $id paruoštas.';
  }

  @override
  String get openpgpNewKey => 'Naujas raktas';

  @override
  String get openpgpNewKeyFor => 'Kam';

  @override
  String get openpgpYourName => 'Jūsų vardas';

  @override
  String get openpgpAddress => 'Adresas';

  @override
  String get openpgpPassphrase => 'Slaptafrazė';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Neprivaloma. Be jos raktą saugo tik jūsų telefono raktų saugykla, ir Loupe niekada nieko neklausia. Su ja Loupe jos paprašys, kai raktas bus reikalingas.';

  @override
  String get openpgpRepeatPassphrase => 'Pakartoti';

  @override
  String get openpgpExpires => 'Galiojimas';

  @override
  String get openpgpExpiresFooter =>
      'Prieš baigiantis galiojimui galite sukurti naują raktą. Thunderbird taip pat naudoja trejus metus.';

  @override
  String get openpgpGenerateKey => 'Sukurti raktą';

  @override
  String get openpgpKeyFor => 'Raktas adresui';

  @override
  String get openpgpCantEncrypt => 'Nepavyksta užšifruoti';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nėra OpenPGP rakto šiems gavėjams: $names, o šis adresas visada šifruoja. Pašalinkite gavėją arba importuokite jo raktą skiltyje Nustatymai › Ištisinis šifravimas.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nėra galiojančio S/MIME sertifikato šiems gavėjams: $names, o šis adresas visada šifruoja. Pašalinkite gavėją arba importuokite jo sertifikatą skiltyje Nustatymai › Ištisinis šifravimas.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nėra OpenPGP rakto šiems gavėjams: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nėra galiojančio S/MIME sertifikato šiems gavėjams: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Siųsti nešifruotą';

  @override
  String get openpgpCantSign => 'Nepavyksta pasirašyti';

  @override
  String get openpgpCantSignMessage =>
      'Jūsų S/MIME sertifikato privačiojo rakto šiame įrenginyje nėra. Vėl importuokite sertifikatą (.p12 arba .pfx failą) skiltyje Nustatymai › Ištisinis šifravimas.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nėra rakto: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nėra sertifikato: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Raktai iš Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Visi turi raktą';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Visi turi sertifikatą';

  @override
  String get openpgpComposeEncrypt => 'Šifruoti';

  @override
  String get openpgpComposeSign => 'Pasirašyti';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, perjungti';
  }

  @override
  String get openpgpNoKeyFound => 'OpenPGP rakto nerasta.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importuoti slaptąjį raktą?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Šiame priede yra slaptasis raktas ($names). Importuokite jį kaip savo raktą tik tuo atveju, jei patys jį eksportavote, pavyzdžiui, iš Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importuoti kaip mano raktą';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'jūsų raktas $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importuoti $count raktų ($names)?',
      few: 'Importuoti $count raktus ($names)?',
      one: 'Importuoti $count raktą ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importuoti ir priimti';

  @override
  String get openpgpImportDecideLater => 'Importuoti, nuspręsti vėliau';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name raktas';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importuota: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pridėta $count OpenPGP raktų.',
      few: 'Pridėti $count OpenPGP raktai.',
      one: 'Pridėtas $count OpenPGP raktas.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importuoti';

  @override
  String get openpgpUnlockKeyTitle => 'Atrakinti OpenPGP raktą';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Įveskite $name rakto ($id) slaptafrazę.';
  }

  @override
  String get openpgpWrongPassphrase => 'Slaptafrazė neteisinga. Bandykite dar kartą.';

  @override
  String get openpgpExplainLocked => 'Šis laiškas šifruotas. Atrakinkite savo OpenPGP raktą, kad jį perskaitytumėte.';

  @override
  String get openpgpExplainNoKey =>
      'Šis laiškas šifruotas, bet ne nė vienam šio įrenginio OpenPGP raktui. Jei skaitote jį Thunderbird, importuokite raktą iš ten: Nustatymai › Ištisinis šifravimas.';

  @override
  String get openpgpExplainDamaged => 'Šis šifruotas laiškas sugadintas, todėl jo negalima saugiai iššifruoti.';

  @override
  String get openpgpExplainUnsupported => 'Šiame laiške naudojamas šifravimas, kurio Loupe dar negali perskaityti.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Šis laiškas šifruotas naudojant S/MIME, bet ne nė vienam šio įrenginio sertifikatui. Importuokite savo sertifikatą (.p12 arba .pfx failą) skiltyje Nustatymai › Ištisinis šifravimas.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Šis laiškas šifruotas. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Atrakinkite savo S/MIME sertifikatą, kad jį perskaitytumėte.';

  @override
  String get openpgpAttachmentGone => 'Šis priedas nebepasiekiamas.';

  @override
  String get smimeEncrypted => 'Šifruotas (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifruotas (S/MIME) · nėra sertifikato';

  @override
  String get smimeEncryptedDamaged => 'Šifruotas (S/MIME) · sugadintas';

  @override
  String get smimeEncryptedUnsupported => 'Šifruotas (S/MIME) · nepalaikomas';

  @override
  String get smimeEncryptedLocked => 'Šifruotas (S/MIME) · užrakintas';

  @override
  String get smimeUnknownSigner => 'nežinomas';

  @override
  String get smimeSignatureModified => 'Netinkamas parašas: laiškas pakeistas';

  @override
  String get smimeSignatureWeak => 'Nesaugus parašas: pasenęs algoritmas';

  @override
  String get smimeSignatureUncheckable => 'Parašo patikrinti neįmanoma';

  @override
  String get smimeSignedCertificateMissing => 'Pasirašyta · trūksta sertifikato';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Pasirašė $name · sertifikatas atšauktas';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Pasirašė $name · kitu laiku';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Pasirašė $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Pasirašė $name · netinkamas sertifikatas';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Pasirašė $name · nepatikimas';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Pasirašė $name · sertifikato galiojimas baigėsi';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Pasirašė $name · sertifikatas dar negalioja';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Pasirašė $name · sertifikatas neskirtas el. paštui';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Pasirašė $name, o ne siuntėjas';
  }

  @override
  String get smimeCantDecrypt => 'Nepavyksta iššifruoti šio laiško';

  @override
  String get smimeEncryptedWithSmime => 'Šifruota naudojant S/MIME';

  @override
  String get smimeEncryption => 'Šifravimas';

  @override
  String get smimeDecryptedHere => 'Iššifruota šiame įrenginyje';

  @override
  String get smimeNotDecrypted => 'Neiššifruota';

  @override
  String get smimeAuthenticated => 'autentifikuota';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifikatų',
      few: '$count sertifikatams',
      one: '$count sertifikatui',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Parašas';

  @override
  String get smimeIssuedBy => 'Išdavė';

  @override
  String get smimeValid => 'Galioja';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 kontrolinis kodas';

  @override
  String get smimeSigned => 'Pasirašyta';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'Tikrinamas atšaukimas…';

  @override
  String get smimeNotRevoked => 'Neatšauktas';

  @override
  String get smimeRevoked => 'Atšauktas';

  @override
  String get smimeRevocationUnknown => 'Atšaukimo būsena nežinoma';

  @override
  String smimeRevokedSince(String date) {
    return 'Nuo $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Paklausta sertifikavimo įstaigos (atšauktųjų sąrašas), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Paklausta sertifikavimo įstaigos (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Pasitikėti „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Pasitikėti šiuo sertifikatu…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Patikrinta šiame įrenginyje naudojant S/MIME, suderinamą su Outlook ir Thunderbird; atšaukimas patikrintas sertifikavimo įstaigoje.';

  @override
  String get smimeCheckedFooter =>
      'Patikrinta šiame įrenginyje naudojant S/MIME, suderinamą su Outlook ir Thunderbird. Atšaukimas netikrinamas (Nustatymai › Ištisinis šifravimas).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Pasitikėti $name el. paštui?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Pasitikėti $name sertifikatu?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Bus pasitikima kiekvienu šios įstaigos išduotu sertifikatu, kaip jūsų įmonės sertifikavimo įstaigos. Pirmiausia palyginkite kontrolinį kodą su jo savininku:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Pirmiausia palyginkite kontrolinį kodą su jo savininku:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Pasitikėti';

  @override
  String get smimeSummaryNoKey => 'Jis užšifruotas sertifikatui, kurio šiame įrenginyje nėra.';

  @override
  String get smimeSummaryDamaged => 'Šifruoti duomenys sugadinti arba buvo pakeisti pakeliui.';

  @override
  String get smimeSummaryUnsupported => 'Jame naudojamas algoritmas, kurio Loupe nepalaiko.';

  @override
  String get smimeSummaryLocked => 'Jūsų S/MIME sertifikatas užrakintas.';

  @override
  String get smimeSummaryEncrypted => 'Jį gali perskaityti tik jūs ir kiti gavėjai.';

  @override
  String get smimeSummaryNotSigned => 'Jis nepasirašytas, todėl siuntėjas nepatvirtintas.';

  @override
  String get smimeSummaryModified => 'Parašas neatitinka: laiškas buvo pakeistas po pasirašymo.';

  @override
  String get smimeSummaryUncheckable => 'Parašo patikrinti neįmanoma.';

  @override
  String get smimeSummaryNoCertificate => 'Pasirašiusiojo sertifikato laiške nėra, todėl jo patikrinti neįmanoma.';

  @override
  String get smimeSummaryRevoked =>
      'Sertifikavimo įstaiga atšaukė pasirašiusiojo sertifikatą: parašu pasitikėti negalima.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Sertifikavimo įstaiga atšaukė pasirašiusiojo sertifikatą ($reason): parašu pasitikėti negalima.';
  }

  @override
  String get smimeDateMismatch =>
      'Jis pasirašytas daugiau nei valanda anksčiau ar vėliau nei laiško data: tai gali būti senas, pakartotinai išsiųstas laiškas.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Parašas galioja, ir $issuer patvirtina, kad sertifikatas priklauso siuntėjui.';
  }

  @override
  String get smimeProblemInvalidChain => 'Sertifikatas arba vienas iš jo išdavėjų netinkamas.';

  @override
  String get smimeProblemUntrusted => 'Sertifikatą išdavė įstaiga, kuria Loupe nepasitiki.';

  @override
  String get smimeProblemExpired => 'Sertifikato galiojimas buvo pasibaigęs.';

  @override
  String get smimeProblemNotYetValid => 'Sertifikatas dar negaliojo.';

  @override
  String get smimeProblemWrongUsage => 'Sertifikatas neskirtas el. paštui.';

  @override
  String get smimeProblemWrongAddress => 'Sertifikatas priklauso ne siuntėjo, o kitam adresui.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Patikimas · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nepatikimas · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Nebegalioja nuo $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Galioja nuo $date';
  }

  @override
  String get smimeTrustInvalid => 'Netinkamas';

  @override
  String get smimeTrustNotForMail => 'Neskirtas el. paštui';

  @override
  String get smimeTrustAnotherAddress => 'Kitas adresas';

  @override
  String get smimeMyCertificates => 'Mano S/MIME sertifikatai';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME, kurį naudoja Outlook ir daugelis įmonių. Importuokite savo sertifikatą su privačiuoju raktu (.p12 arba .pfx failą), eksportuotą iš Outlook, Windows, macOS arba Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME, kurį naudoja Outlook ir daugelis įmonių. Importuokite savo sertifikatą su privačiuoju raktu (.p12 arba .pfx failą), eksportuotą iš Outlook, Windows, macOS arba Thunderbird, arba naudokite sertifikatą, kurį šiame įrenginyje įdiegė jūsų įmonė ar jūs patys.';

  @override
  String get smimeCertificateExpired => 'nebegalioja';

  @override
  String smimeCertificateUntil(String date) {
    return 'iki $date';
  }

  @override
  String get smimeCertificateOnDevice => 'šiame įrenginyje';

  @override
  String get smimeImportCertificateEllipsis => 'Importuoti sertifikatą…';

  @override
  String get smimeUseDeviceCertificate => 'Naudoti šio įrenginio sertifikatą…';

  @override
  String get smimeCorrespondentsCertificates => 'Adresatų sertifikatai';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Surinkti iš pasirašytų laiškų, kaip tai daro Outlook ir Thunderbird. Laiškai šifruojami tik patikimiems sertifikatams: Loupe pasitiki įstaigomis, kuriomis el. pašto srityje pasitiki Mozilla, ir tomis, kurias pridedate jūs.';

  @override
  String get smimeRevocation => 'Atšaukimas';

  @override
  String get smimeRevocationFooter =>
      'Kai atidarote pasirašytą laišką, Loupe paklausia įstaigos, išdavusios pasirašiusiojo sertifikatą (jos OCSP serverio arba atšauktųjų sąrašo), ar jis nebuvo atšauktas. Taip įstaiga gali matyti, kada kas nors iš jūsų interneto adreso skaito šiuo sertifikatu pasirašytą laišką. Atsakymai saugomi šiame įrenginyje, kol nustoja galioti. Atšauktas sertifikatas laiško antraštėje rodomas kaip „sertifikatas atšauktas“.';

  @override
  String get smimeCheckRevocation => 'Tikrinti sertifikatų atšaukimą internetu';

  @override
  String get smimeTrustedAuthorities => 'Patikimos įstaigos';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jūsų patikimomis pažymėtos įstaigos, be $count įstaigų, kuriomis el. pašto srityje pasitiki Mozilla.',
      few: 'Jūsų patikimomis pažymėtos įstaigos, be $count įstaigų, kuriomis el. pašto srityje pasitiki Mozilla.',
      one: 'Jūsų patikimomis pažymėtos įstaigos, be $count įstaigos, kuria el. pašto srityje pasitiki Mozilla.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Sertifikavimo įstaiga';

  @override
  String get smimeImportACertificate => 'Importuoti sertifikatą';

  @override
  String get smimeImportContactMessage =>
      'Adresato sertifikatas (.cer, .crt, .pem) arba sertifikavimo įstaigos sertifikatas.';

  @override
  String get smimeFromClipboard => 'Iš iškarpinės';

  @override
  String get smimeFromFile => 'Iš failo';

  @override
  String get smimeClipboardEmpty => 'Iškarpinė tuščia. Pirmiausia nukopijuokite sertifikatą.';

  @override
  String get smimeCertificate => 'Sertifikatas';

  @override
  String get smimeOnDeviceFooter =>
      'Jo privatusis raktas lieka Android prisijungimo duomenų saugykloje, kur jį įdiegė jūsų įmonė arba jūs: Loupe paprašo Android juo pasirašyti ir iššifruoti. Pasirašomi laiškai pasirašomi juos siunčiant.';

  @override
  String get smimeAddresses => 'Adresai';

  @override
  String get smimeUsage => 'Paskirtis';

  @override
  String get smimeUsageNone => 'Nieko, ką naudoja Loupe';

  @override
  String get smimeUsageSigning => 'Pasirašymas';

  @override
  String get smimeUsageEncryption => 'Šifravimas';

  @override
  String get smimeUsageCertificates => 'Sertifikatai';

  @override
  String get smimeAlgorithm => 'Algoritmas';

  @override
  String get smimeSerialNumber => 'Serijos numeris';

  @override
  String get smimeFingerprintCopied => 'Kontrolinis kodas nukopijuotas.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 kontrolinis kodas';

  @override
  String get smimePrivateKey => 'Privatusis raktas';

  @override
  String get smimeKeyOnDevice => 'Šiame įrenginyje';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupe, su slaptafraze';

  @override
  String get smimeKeyInLoupe => 'Loupe';

  @override
  String get smimeSource => 'Šaltinis';

  @override
  String get smimeSourceSignedMail => 'Pasirašytas laiškas';

  @override
  String get smimeSourceImported => 'Importuotas';

  @override
  String get smimeTrustHeader => 'Pasitikėjimas';

  @override
  String get smimeTrustedRoot => 'Patikima šakninė įstaiga';

  @override
  String get smimeIssuer => 'Išdavėjas';

  @override
  String smimeTrustNamed(String name) {
    return 'Pasitikėti „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Pasitikėti šia įstaiga';

  @override
  String get smimeTrustThisCertificate => 'Pasitikėti šiuo sertifikatu';

  @override
  String get smimeStopTrusting => 'Nebepasitikėti';

  @override
  String get smimePassphrase => 'Slaptafrazė';

  @override
  String get smimePassphraseFooter =>
      'Neprivaloma. Su slaptafraze privatusis raktas šiame įrenginyje papildomai užšifruojamas (Argon2id ir AES-256), o Loupe jos prašo pasirašant ir iššifruojant; kiek laiko, nurodo parinktis „Įsiminti slaptafrazes“. Jūsų siunčiami laiškai pasirašomi siuntimo metu; foniniai darbai rakto naudoti negali.';

  @override
  String get smimeChangePassphrase => 'Keisti slaptafrazę…';

  @override
  String get smimeSetPassphraseEllipsis => 'Nustatyti slaptafrazę…';

  @override
  String get smimeRemovePassphrase => 'Pašalinti slaptafrazę';

  @override
  String get smimeShareCertificate => 'Bendrinti sertifikatą';

  @override
  String get smimeDeleteCertificate => 'Ištrinti sertifikatą';

  @override
  String get smimeRemoveCertificate => 'Pašalinti sertifikatą';

  @override
  String get smimePassphraseChanged => 'Slaptafrazė pakeista.';

  @override
  String get smimePassphraseSet => 'Slaptafrazė nustatyta.';

  @override
  String get smimeRemovePassphraseTitle => 'Pašalinti slaptafrazę?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Tada privatųjį raktą saugos tik raktų saugykla, kaip be slaptafrazės: Loupe jos nebeprašys, o foniniai darbai galės jį naudoti.';

  @override
  String get smimePassphraseRemoved => 'Slaptafrazė pašalinta.';

  @override
  String smimeTrustTitle(String name) {
    return 'Pasitikėti $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Kiekvienas jos išduotas sertifikatas bus laikomas patikimu el. paštui. Pirmiausia palyginkite kontrolinį kodą su jo savininku:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Ištrinti savo sertifikatą $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Pašalinti $name sertifikatą?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe nustos jį naudoti: jam užšifruotų laiškų Loupe nebebus galima perskaityti. Sertifikatas liks šiame įrenginyje (Nustatymai › Sauga › Šifruotė ir prisijungimo duomenys).';

  @override
  String get smimeDeleteOwnMessage =>
      'Jo privatusis raktas ištrinamas iš šio įrenginio: jam užšifruotų laiškų čia nebebus galima perskaityti, nebent vėl jį importuosite.';

  @override
  String get smimeRemoveContactMessage => 'Jis sugrįš su kitu šio adresato pasirašytu laišku.';

  @override
  String get smimeAddressImportFooter =>
      'Importuokite sertifikatą šiam adresui, kad galėtumėte pasirašyti ir šifruoti naudodami S/MIME, kaip tai daro Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importuoti sertifikatą…';

  @override
  String get smimePreferFooter =>
      'Kai laišką galėtų apsaugoti abu, naudojamas pageidaujamas, nebent tik kitas turi raktą arba sertifikatą kiekvienam gavėjui.';

  @override
  String get smimePreferSmime => 'Teikti pirmenybę S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Vietoj OpenPGP';

  @override
  String get smimeCertificatePassword => 'Sertifikato slaptažodis';

  @override
  String get smimeCertificatePasswordPrompt => 'Įveskite slaptažodį, su kuriuo buvo eksportuotas sertifikato failas.';

  @override
  String get smimeImport => 'Importuoti';

  @override
  String get smimeWrongPassword => 'Slaptažodis neteisingas. Bandykite dar kartą.';

  @override
  String get smimeNoCertificateFound => 'Sertifikato nerasta.';

  @override
  String smimeCertificateOf(String name) {
    return '$name sertifikatas';
  }

  @override
  String get smimeNothingNew => 'Nėra nieko naujo importuoti.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importuota: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importuota $count patikimų įstaigų.',
      few: 'Importuotos $count patikimos įstaigos.',
      one: 'Importuota $count patikima įstaiga.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importuota: $certificates ir $count patikimų įstaigų.',
      few: 'Importuota: $certificates ir $count patikimos įstaigos.',
      one: 'Importuota: $certificates ir $count patikima įstaiga.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Šiame faile nėra privačiojo rakto. Eksportuokite savo sertifikatą kartu su privačiuoju raktu.';

  @override
  String get smimeImportAsYoursTitle => 'Importuoti kaip jūsų sertifikatą?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Šiame priede yra sertifikatas su privačiuoju raktu: $names. Importuokite jį tik tuo atveju, jei patys jį eksportavote, pavyzdžiui, iš Outlook ar Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importuoti kaip mano sertifikatą';

  @override
  String smimeImportedOwn(String names) {
    return 'Importuotas jūsų sertifikatas $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Iš šio įrenginio pridėtas jūsų sertifikatas $name ($addresses).';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Pasitikėti „$name“ el. paštui?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe nežino šios sertifikavimo įstaigos (galbūt tai įmonės vidinė įstaiga). Pasitikėkite ja, kad būtų galima tikrinti jos išduotus sertifikatus. Pirmiausia palyginkite jos kontrolinį kodą su savo IT skyriumi:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pridėta $count sertifikatų.',
      few: 'Pridėti $count sertifikatai.',
      one: 'Pridėtas $count sertifikatas.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importuoti sertifikatą';

  @override
  String get smimeUnlockTitle => 'Atrakinti S/MIME sertifikatą';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Įveskite $name sertifikato ($addresses) slaptafrazę.';
  }

  @override
  String get smimeWrongPassphrase => 'Slaptafrazė neteisinga. Bandykite dar kartą.';

  @override
  String get smimeUnlock => 'Atrakinti';

  @override
  String get smimeEnterAPassphrase => 'Įveskite slaptafrazę.';

  @override
  String get smimePassphrasesDiffer => 'Abi slaptafrazės skiriasi.';

  @override
  String get smimeSetPassphraseTitle => 'Nustatyti slaptafrazę';

  @override
  String get smimeSetPassphraseText =>
      'Loupe jos prašys pasirašant ir iššifruojant. Jei ją pamiršite, vėl importuokite sertifikatą iš jo .p12 failo.';

  @override
  String get smimePassphraseAgain => 'Dar kartą';

  @override
  String get smimeSetPassphraseButton => 'Nustatyti';

  @override
  String get smimeLockedOpenAgain =>
      'Jūsų S/MIME sertifikatas užrakintas. Atidarykite laišką dar kartą, kad jį atrakintumėte.';

  @override
  String get smimeDeviceHasNoCertificates => 'Šis įrenginys nesiūlo savo sertifikatų.';

  @override
  String get smimeCantReadCertificate => 'Loupe negali perskaityti šio sertifikato.';

  @override
  String get smimeCertificateNotForMail =>
      'Šis sertifikatas neskirtas el. paštui: jame nėra el. pašto adreso arba jis neskirtas pasirašyti ar šifruoti.';

  @override
  String get smimeDeviceCertificateGone =>
      'Sertifikato šiame įrenginyje nebėra arba Loupe nebegali jo naudoti. Vėl jį pasirinkite skiltyje Nustatymai › Ištisinis šifravimas.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Šio įrenginio sertifikatą galima naudoti tik tada, kai Loupe atidaryta.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifruotas raktas sugadintas.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Šio įrenginio sertifikatas negali to atlikti: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nepalaikoma';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Šio įrenginio sertifikato klaida: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Įstaigos adresas nėra žiniatinklio adresas.';

  @override
  String get smimeAuthorityTimeout => 'Sertifikavimo įstaiga laiku neatsakė.';

  @override
  String get smimeAuthorityUnreachable => 'Nepavyko susisiekti su sertifikavimo įstaiga.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Sertifikavimo įstaiga atsakė $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Sertifikavimo įstaigos atsakymas per didelis.';

  @override
  String get smimeRevocationNotChecked => 'Netikrinta: tikrinami tik sertifikatai iš įstaigų, kuriomis Loupe pasitiki.';

  @override
  String get settingsLanguage => 'Kalba';

  @override
  String get settingsLanguageSystem => 'Kaip telefone';

  @override
  String get settingsLanguageFooter =>
      'Loupe naudoja jūsų telefono kalbą, jei ją turi, o jei ne – anglų. Čia pasirinkta kalba taikoma tik Loupe, įskaitant pranešimus.';

  @override
  String get settingsAccountsHeader => 'Paskyros';

  @override
  String get settingsAddAccount => 'Pridėti paskyrą';

  @override
  String get settingsMailHeader => 'Paštas';

  @override
  String get settingsSwipeActions => 'Braukimo veiksmai';

  @override
  String get settingsSwipeLeft => 'Braukimas kairėn';

  @override
  String get settingsSwipeLeftFooter =>
      'Visas braukimas atlieka šį veiksmą. „Pažymėti vėliavėle“ ir „Daugiau“ visada pasiekiami trumpu braukimu.';

  @override
  String get settingsSwipeRight => 'Braukimas dešinėn';

  @override
  String get settingsSwipeRightFooter => 'Visas braukimas atlieka šį veiksmą.';

  @override
  String get settingsSwipeToggleRead => 'Pažymėti kaip skaitytą / neskaitytą';

  @override
  String get settingsSwipeTrash => 'Į šiukšliadėžę';

  @override
  String get settingsSwipeMove => 'Perkelti laišką';

  @override
  String get settingsSwipeSnooze => 'Atidėti';

  @override
  String get settingsThreaded => 'Grupuoti pagal pokalbius';

  @override
  String get settingsUndoSendDelay => 'Siuntimo atšaukimo delsa';

  @override
  String get settingsUndoSendDelayFooter => 'Išsiųsti laiškai tiek laiko palaukia, kad galėtumėte juos atšaukti.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekundžių',
      few: '$seconds sekundės',
      one: '$seconds sekundė',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Išvaizda';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatinė';

  @override
  String get settingsThemeLight => 'Šviesi';

  @override
  String get settingsThemeDark => 'Tamsi';

  @override
  String get settingsDensity => 'Laiškų sąrašas';

  @override
  String get settingsDensityComfortable => 'Erdvus';

  @override
  String get settingsDensityCompact => 'Kompaktiškas';

  @override
  String get settingsReadingHeader => 'Skaitymas';

  @override
  String get settingsReadingFooter => 'Nuotoliniai vaizdai gali pranešti siuntėjams, kada ir kur atidarėte laišką.';

  @override
  String get settingsDefaultView => 'Numatytasis rodinys';

  @override
  String get settingsDefaultViewFooter => 'Bet kurio laiško rodinį galite perjungti mygtuku Aa.';

  @override
  String get settingsViewReadable => 'Skaitymui';

  @override
  String get settingsViewReadableDetail => 'Švarus, įskaitomas, prisitaiko prie tamsiojo režimo';

  @override
  String get settingsViewOriginal => 'Originalas';

  @override
  String get settingsViewOriginalDetail => 'Tiksliai taip, kaip sukūrė siuntėjas';

  @override
  String get settingsViewPlain => 'Paprastas tekstas';

  @override
  String get settingsViewPlainDetail => 'Tik žodžiai';

  @override
  String get settingsPlainTextFont => 'Paprasto teksto šriftas';

  @override
  String get settingsFontSans => 'Be užraitų';

  @override
  String get settingsFontMono => 'Lygiaplotis';

  @override
  String get settingsFontMonoDetail => 'ASCII piešiniai ir lentelės lieka sulygiuoti';

  @override
  String get settingsTechnicalLists => 'Techninės konferencijos';

  @override
  String get settingsLoadRemoteImages => 'Įkelti nuotolinius vaizdus';

  @override
  String get settingsOpenLinksDirectly => 'Atidaryti nuorodas tiesiogiai';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Praleisti paspaudimų sekiklius, kai tikslas žinomas';

  @override
  String get settingsSecurityHeader => 'Saugumas';

  @override
  String get settingsAppLock => 'Programėlės užraktas';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe paprašo patvirtinimo paleidžiama ir kai grįžtate po ilgesnio nebuvimo, nei nurodyta nustatyme „Užrakinti po“.';

  @override
  String get settingsAppLockFooterOff =>
      'Programėlės užraktas paprašo piršto atspaudo, veido arba ekrano užrakto, prieš parodydamas jūsų paštą.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Programėlės užraktas vis dar išjungtas. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Nustatykite slaptakodį';

  @override
  String get settingsScreenLockTextIos =>
      'Programėlės užraktas naudoja Face ID, Touch ID arba jūsų slaptakodį, o šiame iPhone slaptakodžio nėra. Nustatykite jį programėlėje „Nustatymai“, tada įjunkite programėlės užraktą.';

  @override
  String get settingsScreenLockTitleAndroid => 'Nustatykite ekrano užraktą';

  @override
  String get settingsScreenLockTextAndroid =>
      'Programėlės užraktas naudoja jūsų telefono ekrano užraktą arba prie jo pridėtą piršto atspaudą ar veidą, o šiame telefone jo nėra. Nustatykite PIN kodą, atrakinimo piešinį arba slaptažodį Android nustatymuose, tada įjunkite programėlės užraktą.';

  @override
  String get settingsOpenSystemSettings => 'Atidaryti nustatymus';

  @override
  String get settingsOpenAndroidSettings => 'Atidaryti Android nustatymus';

  @override
  String get settingsLockAfter => 'Užrakinti po';

  @override
  String get settingsLockAfterFooter => 'Kiek laiko Loupe gali veikti fone, kol vėl paprašys patvirtinimo.';

  @override
  String get settingsNotifications => 'Pranešimai';

  @override
  String get settingsEncryption => 'Ištisinis šifravimas';

  @override
  String get settingsAdvanced => 'Išplėstiniai';

  @override
  String get settingsDemoHeader => 'Demonstracija';

  @override
  String get settingsDemoFooter =>
      'Demonstracinis paštas – tai išgalvota pašto dėžutė, kuri yra tik šiame telefone. Niekas niekur nesiunčiama.';

  @override
  String get settingsDemoMode => 'Demonstracinis režimas';

  @override
  String get settingsResetApp => 'Atkurti programėlę';

  @override
  String get settingsResetFooter => 'Pamiršta visus nustatymus ir grįžta į pasveikinimo ekraną.';

  @override
  String get settingsResetTitle => 'Atkurti Loupe?';

  @override
  String get settingsResetMessage =>
      'Bus pamiršti visi nustatymai, Smart Mailboxes ir naujausios paieškos, ir grįšite į pasveikinimo ekraną.';

  @override
  String get settingsAboutHeader => 'Apie';

  @override
  String get settingsVersion => 'Versija';

  @override
  String get settingsLicences => 'Licencijos';

  @override
  String get settingsPrivacy => 'Privatumas';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nenaudoja analitikos ir jūsų neseka. Jūsų paštas keliauja tik į jūsų pašto serverius.';

  @override
  String get settingsNotificationsOffIos => 'Loupe pranešimai išjungti nustatymuose.';

  @override
  String get settingsNotificationsOffAndroid => 'Loupe pranešimai išjungti Android nustatymuose.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system neleidžia Loupe rodyti pranešimų. Leiskite juos nustatymuose.';
  }

  @override
  String get settingsNewMailHeader => 'Nauji laiškai';

  @override
  String get settingsNewMailFooterDemo =>
      'Demonstraciniai laiškai fone negaunami. Išsiųskite bandomąjį pranešimą, kad pamatytumėte, kaip atrodo naujas laiškas.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe tikrina naujus laiškus fone, kai leidžia iOS; retai atidaromoms programėlėms tarp patikrų gali praeiti kelios valandos. Jums pranešama apie naujus laiškus gautųjų aplankuose ir apie VIP laiškus bet kuriame aplanke.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe tikrina naujus laiškus maždaug kas 15 minučių, kai leidžia Android. Jums pranešama apie naujus laiškus gautųjų aplankuose ir apie VIP laiškus bet kuriame aplanke.';

  @override
  String get settingsNoAccounts => 'Paskyrų nėra';

  @override
  String get settingsVipOnly => 'Tik VIP';

  @override
  String get settingsVipOnlyDetail => 'Tik jūsų VIP laiškai';

  @override
  String get settingsHideContent => 'Slėpti turinį';

  @override
  String get settingsHideContentFooterOn =>
      'Pranešimuose rodoma tik „Naujas laiškas“ ir paskyra, bet ne tai, kas rašė ar apie ką.';

  @override
  String get settingsHideContentFooterOff =>
      'Parinktis „Slėpti turinį“ neleidžia siuntėjui, temai ir peržiūrai pasirodyti užrakinimo ekrane ir pranešimuose.';

  @override
  String get settingsBackgroundAppRefresh => 'Programų naujinimas fone';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nauji laiškai fone gaunami tik tada, kai nustatymuose Loupe įjungtas programų naujinimas fone. iOS negali palaikyti atviro ryšio su jūsų gautųjų aplankais, todėl momentinio pristatymo nėra.';

  @override
  String get settingsInstantDelivery => 'Momentinis pristatymas';

  @override
  String get settingsInstantDeliveryFooter =>
      'Momentinis pristatymas (eksperimentinis) palaiko atvirą ryšį su jūsų gautųjų aplankais, todėl nauji laiškai gaunami per kelias sekundes. Jis rodo tylų pranešimą „Laukiama naujų laiškų“ ir naudoja daugiau akumuliatoriaus energijos.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android gali sustabdyti momentinį pristatymą, kad taupytų akumuliatorių. Leiskite Loupe naudoti akumuliatorių be apribojimų, kad jis veiktų toliau.';

  @override
  String get settingsExperimental => 'Eksperimentinis';

  @override
  String get settingsComingSoon => 'Netrukus';

  @override
  String get settingsAllowUnrestrictedBattery => 'Leisti neribotą akumuliatoriaus naudojimą';

  @override
  String get settingsPush => 'Push pranešimai';

  @override
  String get settingsPushFooter =>
      'Push pranešimai leidžia naujam laiškui iškart pažadinti Loupe, jei jūsų pašto paslauga tai palaiko. Jie keliauja per Google push paslaugą ir neturi jokio laiško turinio, tik „patikrink dabar“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Šis telefonas negali gauti push pranešimų: jiems reikia Google Play paslaugų ir tinklo ryšio. Loupe vis tiek tikrina laiškus maždaug kas 15 minučių.';

  @override
  String get settingsCopyPushToken => 'Kopijuoti push prieigos raktą';

  @override
  String get settingsPushTokenCopied => 'Push prieigos raktas nukopijuotas';

  @override
  String get settingsSendTestNotification => 'Siųsti bandomąjį pranešimą';

  @override
  String get settingsAppIconBadge => 'Programėlės piktogramos ženklelis';

  @override
  String get settingsBadgeNote => 'Ženklelis atnaujinamas kaskart, kai Loupe tikrina paštą, taip pat ir fone.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Šio telefono pagrindinis ekranas nerodo skaičių ant programėlių piktogramų. Ženklelis atnaujinamas kaskart, kai Loupe tikrina paštą, taip pat ir fone.';

  @override
  String get settingsTestNotificationBody => 'Naujų laiškų pranešimai atrodo taip.';

  @override
  String get settingsAccountRemoved => 'Ši paskyra pašalinta.';

  @override
  String get settingsAccountHeader => 'Paskyra';

  @override
  String get settingsAccountDescription => 'Aprašas';

  @override
  String get settingsAccountDescriptionHint => 'Darbas, asmeninė…';

  @override
  String get settingsEmail => 'El. paštas';

  @override
  String get settingsColour => 'Spalva';

  @override
  String get settingsColourFooter => 'Žymi šios paskyros laiškus rodinyje „Visi gauti laiškai“.';

  @override
  String settingsColourNumber(int number) {
    return 'Spalva $number';
  }

  @override
  String get settingsSendingHeader => 'Siuntimas';

  @override
  String get settingsSendingFooter =>
      'Kiekviena tapatybė turi savo parašą. Atsakymai siunčiami iš adreso, kuriuo laiškas buvo atsiųstas.';

  @override
  String get settingsFoldersHeader => 'Aplankai';

  @override
  String get settingsFoldersFooter =>
      'Loupe rodo ir sinchronizuoja aplankus, kuriuos prenumeruojate, kaip tai daro Thunderbird. Gauti laiškai, Juodraščiai, Išsiųsti laiškai, Šlamštas, Šiukšliadėžė ir Archyvas rodomi visada.';

  @override
  String get settingsShowAllFolders => 'Rodyti visus aplankus';

  @override
  String get settingsIncoming => 'Gaunamasis';

  @override
  String get settingsOutgoing => 'Siunčiamasis';

  @override
  String get settingsConnectionNotEncrypted => 'Nešifruojama';

  @override
  String get settingsSignIn => 'Prisijungimas';

  @override
  String get settingsSignInExpired => 'Nebegalioja';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider nebepriima Loupe prisijungimo prie šios paskyros, todėl jos laiškai nesinchronizuojami. Prisijunkite iš naujo, kad tai ištaisytumėte.';
  }

  @override
  String get settingsSignInAgain => 'Prisijungti iš naujo';

  @override
  String get settingsSigningIn => 'Prisijungiama…';

  @override
  String get settingsRemoveAccount => 'Pašalinti paskyrą';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Pašalinti „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Jos laiškai ir nustatymai pašalinami iš šio telefono. Serveryje niekas neištrinama.';

  @override
  String get settingsManageFolders => 'Tvarkyti aplankus';

  @override
  String get settingsNoFolders => 'Aplankų dar nėra.';

  @override
  String get settingsManageFoldersFooter =>
      'Prenumeruojami aplankai rodomi ekrane „Pašto dėžutės“ ir sinchronizuojami fone. Kitos tą pačią paskyrą naudojančios pašto programos paprastai taip pat laikosi šių prenumeratų.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Saugo jūsų Smart Mailboxes kitiems jūsų įrenginiams. Ekrane „Pašto dėžutės“ paslėptas.';

  @override
  String get settingsFolderAlwaysShown => 'Rodomas visada';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Prenumeruoti $folder';
  }

  @override
  String get settingsIdentities => 'Tapatybės';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Pirmoji tapatybė yra numatytoji naujiems laiškams. Vilkite, kad pakeistumėte tvarką.';

  @override
  String get settingsIdentitiesFooterSingle => 'Numatytoji naujų laiškų tapatybė.';

  @override
  String get settingsIdentitiesReplyFooter => 'Atsakymas siunčiamas iš tapatybės, kuriai laiškas buvo atsiųstas.';

  @override
  String get settingsIdentityDefault => 'Numatytoji';

  @override
  String settingsIdentityReorder(String email) {
    return 'Perkelti $email';
  }

  @override
  String get settingsAddIdentity => 'Pridėti tapatybę';

  @override
  String get settingsNewIdentity => 'Nauja tapatybė';

  @override
  String get settingsIdentity => 'Tapatybė';

  @override
  String get settingsIdentityNameHint => 'Jūsų vardas';

  @override
  String get settingsReplyTo => 'Atsakyti kam';

  @override
  String get settingsSignature => 'Parašas';

  @override
  String get settingsSignatureFooter => 'Pridedamas po „-- “ šios tapatybės laiškuose.';

  @override
  String get settingsNoSignature => 'Nėra parašo';

  @override
  String get settingsCopyToMyself => 'Kopija sau';

  @override
  String get settingsCopyToMyselfFooter => 'Pridedama prie kiekvieno šios tapatybės laiško.';

  @override
  String get settingsCc => 'Kopija';

  @override
  String get settingsBcc => 'Slapta kopija';

  @override
  String get settingsReplyPatterns => 'Naudoti atsakant į';

  @override
  String get settingsReplyPatternsFooter =>
      'Atsakymai į laiškus, atsiųstus šiais adresais, siunčiami iš šios tapatybės. * reiškia bet ką: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adresas arba šablonas, kuriame * reiškia bet ką.';

  @override
  String get settingsAddReplyPattern => 'Pridėti adresą arba šabloną';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Pašalinti $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Netinkamas šablonas';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ nėra adresas arba šablonas, pvz., *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nėra adreso';

  @override
  String get settingsIdentityNoAddressMessage => 'Įveskite el. pašto adresą, iš kurio siųsti.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Netinkamas adresas';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„Atsakyti kam“ adresas „$address“ nėra tinkamas el. pašto adresas.',
      'cc': 'Kopijos adresas „$address“ nėra tinkamas el. pašto adresas.',
      'bcc': 'Slaptos kopijos adresas „$address“ nėra tinkamas el. pašto adresas.',
      'other': '„$address“ nėra tinkamas el. pašto adresas.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Išsaugoti tapatybę';

  @override
  String get settingsDiscardChanges => 'Atmesti pakeitimus';

  @override
  String get settingsDeleteIdentity => 'Ištrinti tapatybę';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Ištrinti „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Iš jos jau išsiųsti laiškai liks nepakeisti.';

  @override
  String get settingsLastIdentityFooter => 'Paskyrai reikia bent vienos tapatybės.';

  @override
  String get rulesTitle => 'Taisyklės';

  @override
  String get rulesNewRule => 'Nauja taisyklė';

  @override
  String get rulesLoadError => 'Nepavyko įkelti taisyklių.';

  @override
  String get rulesEmptyTitle => 'Taisyklių nėra';

  @override
  String get rulesEmptyText =>
      'Taisyklės už jus rūšiuoja naujus laiškus, pažymi juos žymėmis ir vėliavėlėmis. Sukurkite taisyklę rašymo mygtuku viršuje arba iš paieškos komanda „Paversti taisykle“.';

  @override
  String get rulesListFooter =>
      'Taisyklės vykdomos iš viršaus į apačią naujiems laiškams aplanke „Gauti laiškai“. Palieskite ir palaikykite taisyklę, kad ją perkeltumėte.';

  @override
  String get rulesChangeError => 'Nepavyko pakeisti taisyklės';

  @override
  String get rulesConditionEveryMessage => 'Kiekvienas laiškas';

  @override
  String rulesMoveRule(String rule) {
    return 'Perkelti $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule įjungta';
  }

  @override
  String get rulesServerRulesHeader => 'Serverio taisyklės';

  @override
  String get rulesServerRulesFooter =>
      'Serverio taisyklės vykdomos pašto serveryje, kai gaunami laiškai, net kai šis telefonas išjungtas. Jos saugomos Sieve scenarijuje pavadinimu „loupe“.';

  @override
  String get rulesStatusUnknown => 'Nežinoma';

  @override
  String get rulesStatusError => 'Nepavyko paklausti serverio.';

  @override
  String get rulesStatusChecking => 'Tikrinama…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Vykdoma iš „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script“ yra aktyvus scenarijus. Bakstelėkite, kad jis vykdytų ir Loupe taisykles.';
  }

  @override
  String get rulesStatusNoScript =>
      'Serveryje nėra aktyvaus scenarijaus. Išsaugojus serverio taisyklę, bus įjungtas Loupe scenarijus.';

  @override
  String get rulesStatusUnavailable => 'Nepasiekiama';

  @override
  String get rulesStatusNoSieve => 'Šios paskyros serveris nesiūlo Sieve (ManageSieve arba JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Perkelti į $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Perkelti į aplanką';

  @override
  String rulesActionTag(String tag) {
    return 'Pažymėti žyme $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Pašalinti žymę $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Palikti aplanke „Gauti laiškai“';

  @override
  String rulesActionForward(String address) {
    return 'Persiųsti adresu $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Persiųsti adresu $address, nepasiliekant kopijos';
  }

  @override
  String get rulesActionStop => 'Sustabdyti';

  @override
  String get rulesNoActions => 'Kol kas nieko nedaro';

  @override
  String get rulesLocationDevice => 'Įrenginys';

  @override
  String get rulesLocationServer => 'Serveris';

  @override
  String get rulesLocationThisDevice => 'Šis įrenginys';

  @override
  String get rulesNewRuleTitle => 'Nauja taisyklė';

  @override
  String get rulesEditRuleTitle => 'Redaguoti taisyklę';

  @override
  String get rulesDefaultNameEveryMessage => 'Kiekvienas laiškas';

  @override
  String get rulesConditionHeader => 'Kai naujas laiškas atitinka';

  @override
  String get rulesConditionFooter =>
      'Rašykite taip, kaip ieškotumėte: from:, to:, s: (tema), b: (tekstas), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:sąskaita';

  @override
  String get rulesAccounts => 'Paskyros';

  @override
  String get rulesAllAccounts => 'Visos paskyros';

  @override
  String get rulesRemovedAccount => 'Pašalinta paskyra';

  @override
  String get rulesAccountsFooter => 'Taisyklė visoms paskyroms taikoma ir vėliau pridėtoms paskyroms.';

  @override
  String get rulesActionsHeader => 'Tada';

  @override
  String get rulesForwardingFooter =>
      'Persiuntimas kiekvieną atitinkantį laišką vos gavus siunčia kitu adresu, net kai šis telefonas išjungtas. Kai kurie paslaugų teikėjai riboja, kiek laiškų galima persiųsti.';

  @override
  String get rulesForwardingHiddenFooter => 'Persiuntimas veikia tik serverio taisyklėse, todėl čia jo nėra.';

  @override
  String rulesRemoveAction(String action) {
    return 'Pašalinti: $action';
  }

  @override
  String get rulesAddAction => 'Pridėti veiksmą';

  @override
  String get rulesAddMove => 'Perkelti į aplanką…';

  @override
  String get rulesAddTagMenu => 'Pridėti žymę…';

  @override
  String get rulesRemoveTagMenu => 'Pašalinti žymę…';

  @override
  String get rulesAddForward => 'Persiųsti adresu…';

  @override
  String get rulesStopProcessing => 'Nebevykdyti kitų taisyklių';

  @override
  String get rulesRunOnHeader => 'Vykdyti';

  @override
  String get rulesRunOnDeviceFooter =>
      'Šis įrenginys vykdo taisyklę naujiems laiškams aplanke „Gauti laiškai“ kaskart, kai Loupe tikrina paštą.';

  @override
  String get rulesRunOnServerFooter =>
      'Pašto serveris vykdo taisyklę, kai gaunami laiškai, net kai šis telefonas išjungtas. Reikia Sieve per ManageSieve (Dovecot, mailcow) arba JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Taikyti esamiems laiškams…';

  @override
  String get rulesDeleteRule => 'Ištrinti taisyklę';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Ištrinti „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Kurios paskyros aplankas?';

  @override
  String get rulesMoveAccountMessage => 'Kitų paskyrų laiškai keliauja į ten esantį tokio paties pavadinimo aplanką.';

  @override
  String get rulesAddTag => 'Pridėti žymę';

  @override
  String get rulesRemoveTag => 'Pašalinti žymę';

  @override
  String get rulesForwardTo => 'Persiųsti adresu';

  @override
  String get rulesForwardToMessage =>
      'Serveris kiekvieną atitinkantį laišką persiunčia šiuo adresu, net kai šis telefonas išjungtas. Naudokite adresą, kuris priklauso jums arba kuriuo pasitikite.';

  @override
  String get rulesNotAnAddressTitle => 'Ne el. pašto adresas';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ nėra adresas, kuriuo galima persiųsti.';
  }

  @override
  String get rulesKeepCopyTitle => 'Pasilikti kopiją čia?';

  @override
  String get rulesKeepCopy => 'Pasilikti kopiją';

  @override
  String get rulesDontKeepCopy => 'Nepasilikti kopijos';

  @override
  String get rulesCheckCondition => 'Patikrinkite sąlygą';

  @override
  String get rulesChooseActionTitle => 'Pasirinkite veiksmą';

  @override
  String get rulesChooseActionMessage => 'Nurodykite, ką taisyklė daro su jai atitinkančiais laiškais.';

  @override
  String get rulesSaveError => 'Nepavyko išsaugoti taisyklės';

  @override
  String get rulesSaveServerError => 'Nepavyko išsaugoti serverio taisyklės';

  @override
  String get rulesRunOnDeviceInstead => 'Vietoj to vykdyti šiame įrenginyje';

  @override
  String get rulesNothingToApplyTitle => 'Nėra ko taikyti';

  @override
  String get rulesNothingToApplyMessage => 'Pirmiausia nurodykite taisyklei veikiančią sąlygą ir veiksmą.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Taikyti „$rule“ laiškams…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Gautų laiškų aplankuose';

  @override
  String get rulesApplyScopeAll => 'Visose pašto dėžutėse';

  @override
  String get rulesFindingMessages => 'Ieškoma laiškų…';

  @override
  String get rulesSearchError => 'Nepavyko ieškoti';

  @override
  String get rulesSearchErrorUnknown => 'Kažkas nepavyko.';

  @override
  String get rulesNoMatchesTitle => 'Atitinkančių laiškų nėra';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ten niekas neatitinka „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Taikyti „$rule“ $countString laiškų?',
      few: 'Taikyti „$rule“ $countString laiškams?',
      one: 'Taikyti „$rule“ $countString laiškui?',
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
      other: 'Taikyti $countString laiškų',
      few: 'Taikyti $countString laiškams',
      one: 'Taikyti $countString laiškui',
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
      other: '„$rule“ pritaikyta $countString laiškų',
      few: '„$rule“ pritaikyta $countString laiškams',
      one: '„$rule“ pritaikyta $countString laiškui',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Klausiama serverio, ką jis gali…';

  @override
  String get rulesServerUnreachable => 'Nepavyko pasiekti serverio.';

  @override
  String rulesServerProblem(String problem) {
    return 'Negalima vykdyti serveryje: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Negalima vykdyti paskyros $account serveryje: $problem';
  }

  @override
  String get rulesShowScript => 'Rodyti scenarijų';

  @override
  String get rulesHideScript => 'Slėpti scenarijų';

  @override
  String get rulesMatchingHeader => 'Atitinkantys laiškai';

  @override
  String get rulesMatchingHeaderLoading => 'Atitinkantys laiškai…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString atitinkančių laiškų',
      few: '$countString atitinkantys laiškai',
      one: '$countString atitinkantis laiškas',
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
      other: '$countString+ atitinkančių laiškų',
      few: '$countString+ atitinkantys laiškai',
      one: '$countString+ atitinkantis laiškas',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Iš paskutinių 30 dienų. Pati taisyklė veikia tik naujus laiškus, nebent ją pritaikysite esamiems laiškams.';

  @override
  String rulesConditionError(String error) {
    return 'Sąlygoje yra klaida: $error';
  }

  @override
  String get rulesPreviewNoSender => '(nėra siuntėjo)';

  @override
  String get rulesPreviewNoSubject => '(be temos)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'ir dar $countString');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nieko iš paskutinių 30 dienų.';

  @override
  String get rulesIncludeTitle => 'Įjungti serverio taisykles';

  @override
  String get rulesIncludeLeaveOff => 'Palikti išjungtas';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serveris jau vykdo Loupe taisykles paskyrai $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ yra aktyvus scenarijus paskyros $account serveryje, todėl serveris vykdo jį, o ne Loupe taisykles. Loupe jo nepakeis. Ji gali pridėti prie jo šias eilutes, ir tada serveris po paties scenarijaus taisyklių vykdys ir Loupe taisykles:';
  }

  @override
  String get rulesShowWholeScript => 'Rodyti visą scenarijų';

  @override
  String get rulesHideWholeScript => 'Slėpti visą scenarijų';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Niekas kita scenarijuje „$script“ nesikeičia. Jei vėliau jo filtrai bus redaguojami žiniatinklio pašte, šis gali jį perrašyti be šių eilučių; tada Loupe vėl rodys serverio taisykles kaip išjungtas.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Pridėti prie „$script“';
  }

  @override
  String get subscriptionsTitle => 'Prenumeratos';

  @override
  String get subscriptionsNewsletters => 'Naujienlaiškiai';

  @override
  String get subscriptionsDiscussions => 'Diskusijos';

  @override
  String get subscriptionsFilter => 'Filtruoti';

  @override
  String get subscriptionsFilterNeverRead => 'Niekada neskaityti';

  @override
  String get subscriptionsFilterRarelyRead => 'Retai skaitomi';

  @override
  String get subscriptionsFilterAll => 'Visi';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Nepavyko suskaičiuoti prenumeratų';

  @override
  String get subscriptionsNoMatches => 'Atitikmenų nėra';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nėra naujienlaiškio pavadinimu „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nėra konferencijos pavadinimu „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Naujienlaiškių nėra';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Naujienlaiškiai ir kiti masiniai laiškai bus rodomi čia, kai tik jų gausite.';

  @override
  String get subscriptionsNothingNeverRead => 'Niekada neskaitytų nėra';

  @override
  String get subscriptionsNothingRarelyRead => 'Retai skaitomų nėra';

  @override
  String get subscriptionsNothingFilteredDetail => 'Šiek tiek skaitote visko, ką gaunate.';

  @override
  String get subscriptionsNoDiscussions => 'Diskusijų nėra';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'El. pašto konferencijos, į kurias galite rašyti, bus rodomos čia, kai tik gausite jų laiškų.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Konferencijos, į kurias rašo keli žmonės. Palieskite ir palaikykite vieną, kad ją prisegtumėte prie pašto dėžučių, skaitytumėte kaip paprastą tekstą arba perkeltumėte į naujienlaiškius.';

  @override
  String get subscriptionsPrivacyNote =>
      'Suskaičiuota šiame telefone iš atsisiųstų laiškų; tam niekas niekur nesiunčiama. Loupe susisiekia su siuntėju tik tada, kai bakstelite „Atsisakyti prenumeratos“: atsisakant vienu spustelėjimu siunčiamas tik tekstas „List-Unsubscribe=One-Click“ siuntėjo nurodytu adresu, be slapukų ir be jokios kitos informacijos apie jus, o jo puslapiai ar vaizdai niekada neįkeliami.';

  @override
  String get subscriptionsVolumeNone => 'Pastaruoju metu nėra';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 per mėn.';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count per mėn.';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'perskaityta $percent';
  }

  @override
  String get subscriptionsStillSending => 'Vis dar siunčia';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Prenumeratos atsisakyta $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Atsisakymo puslapis atidarytas $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Vienu bakstelėjimu · susisiekia su $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'El. laišku adresu $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Svetainėje $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Atsisakyti prenumeratos';

  @override
  String get subscriptionsUnsubscribeAgain => 'Atsisakyti dar kartą';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archyvuoti $countString iš „Gauti laiškai“',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Sukurti taisyklę…';

  @override
  String get subscriptionsCreateRuleDetail => 'Perkelti arba archyvuoti būsimus jo laiškus';

  @override
  String get subscriptionsTreatAsDiscussion => 'Laikyti diskusija';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Konferencija, į kurią rašo žmonės: skaityti kaip forumą';

  @override
  String get subscriptionsTreatAsNewsletter => 'Laikyti naujienlaiškiu';

  @override
  String get subscriptionsBlockSender => 'Blokuoti siuntėją';

  @override
  String get subscriptionsBlock => 'Blokuoti';

  @override
  String get subscriptionsBlocked => 'Užblokuotas';

  @override
  String get subscriptionsBlockedDetail => 'Nauji laiškai keliauja į šlamštą';

  @override
  String get subscriptionsPin => 'Prisegti prie pašto dėžučių';

  @override
  String get subscriptionsUnpin => 'Atsegti nuo pašto dėžučių';

  @override
  String get subscriptionsOpenDefaultView => 'Atidaryti numatytuoju rodiniu';

  @override
  String get subscriptionsOpenPlainText => 'Atidaryti kaip paprastą tekstą (Mono)';

  @override
  String get subscriptionsPinned => 'Prisegta';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString neskaitytų',
      few: '$countString neskaityti',
      one: '$countString neskaitytas',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Šiuo metu laiškų iš šio siuntėjo nėra.';

  @override
  String get subscriptionsLatestMessages => 'NAUJAUSI LAIŠKAI';

  @override
  String get subscriptionsMail => 'Laiškai';

  @override
  String get subscriptionsNoneIn90Days => 'Nėra per 90 dienų';

  @override
  String get subscriptionsRead => 'Perskaityta';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString iš $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Paskutinį kartą gauta';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Vieta');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Vis dar siunčia';

  @override
  String get subscriptionsUnsubscribedTitle => 'Prenumeratos atsisakyta';

  @override
  String subscriptionsSince(String date) {
    return 'nuo $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'puslapis atidarytas $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nenurodo, kaip atsisakyti prenumeratos.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nenurodo, kaip atsisakyti prenumeratos. Vietoj to galite jį blokuoti.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Atsisakoma $sender prenumeratos…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Atsisakyta $sender prenumeratos.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Nepavyko atsisakyti prenumeratos: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Nepavyko atsisakyti automatiškai';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Siųsti atsisakymo laišką';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Atidaryti $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Atidaryti $site?';
  }

  @override
  String get subscriptionsOpen => 'Atidaryti';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender prenumeratos atsisakoma svetainėje. Puslapis atsidarys Loupe naršyklėje; užbaikite ten.';
  }

  @override
  String get subscriptionsWebInsecure => 'Ryšys su šia svetaine nešifruotas.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Atsargiai: šis adresas panašiai atrodančiomis raidėmis imituoja $site.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Atsargiai: šis adresas panašiai atrodančiomis raidėmis imituoja kitą svetainę.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Nepavyko atidaryti $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe įsimena šiandienos datą ir praneš, jei $sender toliau rašys.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Atsisakyti $sender prenumeratos?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe susisieks su $site, kad atsisakytų prenumeratos.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Tai vienintelis kartas, kai Loupe susisiekia su siuntėjo svetaine. Ji siunčia tik tekstą „List-Unsubscribe=One-Click“ adresu, kurį nurodė $sender, be slapukų ar jokios kitos informacijos apie jus, ir neįkelia puslapio.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Atsisakymo nuoroda nėra saugus interneto adresas.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site laiku neatsakė.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Nepavyko pasiekti $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site nukreipė užklausą į kitą puslapį, o Loupe nukreipimais neseka.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site atmetė užklausą (klaida $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nėra paskyros, iš kurios būtų galima išsiųsti atsisakymo laišką.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe išsiųs laišką adresu $to iš $from su tema „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Atsisakymo laiškas išsiųstas adresu $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Blokuoti $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nauji šios konferencijos laiškai keliaus į šlamštą. Tai galite pakeisti skiltyje Nustatymai › Taisyklės.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nauji laiškai iš $address keliaus į šlamštą. Tai galite pakeisti skiltyje Nustatymai › Taisyklės.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender užblokuotas.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Perkelti $count į šlamštą');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokuoti $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender dabar yra naujienlaiškiuose.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender dabar yra diskusijose.';
  }

  @override
  String get appLiveGateTitle => 'Nepavyko atidaryti jūsų paskyrų';

  @override
  String get appLiveGateUnavailableBuild => 'Tikros paskyros šioje versijoje dar nepasiekiamos.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nepavyko nuskaityti rakto, kuris saugo jūsų paštą šiame telefone. Dažnai tai laikina: bandykite dar kartą arba paleiskite telefoną iš naujo.';

  @override
  String get appLiveGateKeyMissing =>
      'Rakto, kuris saugo jūsų paštą šiame telefone, nebėra; taip gali nutikti atkūrus atsarginę kopiją. Jūsų paštas vis dar yra serveryje.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Šiame telefone esančios pašto duomenų bazės nepavyksta perskaityti: ji sugadinta arba pasikeitė jos raktas. Jūsų paštas vis dar yra serveryje.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Atidarant jūsų paskyras kažkas nepavyko ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Bus ištrintos jūsų paskyros ir šiame telefone saugomi laiškai, įskaitant laiškus, laukiančius aplanke „Siunčiamieji“. Laiškams jūsų serveriuose tai neturės įtakos; po to vėl pridėkite savo paskyras.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Ištrinti ir pradėti iš naujo';

  @override
  String get appLiveGateUseDemo => 'Naudoti demonstracinį paštą';

  @override
  String get appLiveGateReset => 'Atkurti paštą šiame telefone…';

  @override
  String get attachmentsUntitled => 'Priedas';

  @override
  String get attachmentsUntitledFile => 'Be pavadinimo';

  @override
  String get attachmentsOpenIn => 'Atidaryti su…';

  @override
  String get attachmentsSaveToFiles => 'Išsaugoti failuose';

  @override
  String get attachmentsShareMenu => 'Bendrinti…';

  @override
  String get attachmentsDownloadError => 'Nepavyko atsisiųsti priedo. Patikrinkite ryšį ir bandykite dar kartą.';

  @override
  String get attachmentsShareError => 'Nepavyko bendrinti priedo.';

  @override
  String attachmentsNoApp(String type) {
    return 'Šiame įrenginyje nėra programos, kuri atidarytų šį failą ($type). Verčiau pabandykite bendrinti.';
  }

  @override
  String get attachmentsOpenInError => 'Nepavyko atidaryti priedo kitoje programoje.';

  @override
  String attachmentsSaved(String name) {
    return 'Išsaugota: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Nepavyko išsaugoti priedo.';

  @override
  String get attachmentsGone => 'Šis priedas nebepasiekiamas.';

  @override
  String get attachmentsDownloadFailed => 'Priedo nepavyko atsisiųsti.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count puslapių',
      few: '$count puslapiai',
      one: '$count puslapis',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size mobiliuoju ryšiu';
  }

  @override
  String get attachmentsLargeDownload => 'Šis priedas didelis. Atsisiųskite jį dabar arba vėliau per Wi-Fi.';

  @override
  String get attachmentsDownload => 'Atsisiųsti';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Atsisiunčiama $size…';
  }

  @override
  String get attachmentsDownloading => 'Atsisiunčiama…';

  @override
  String get attachmentsTooLarge => 'Per didelis, kad būtų galima peržiūrėti čia.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Rodomi pirmieji $shown iš $total. Norėdami gauti viską, nukopijuokite, bendrinkite arba išsaugokite.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Šio PDF čia parodyti negalima (galbūt jis apsaugotas slaptažodžiu).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page iš $count';
  }

  @override
  String get attachmentsModeTable => 'Lentelė';

  @override
  String get attachmentsModeText => 'Tekstas';

  @override
  String get attachmentsModeMessage => 'Laiškas';

  @override
  String get attachmentsModeSource => 'Šaltinis';

  @override
  String get attachmentsDontWrap => 'Nelaužyti eilučių';

  @override
  String get attachmentsWrap => 'Laužyti eilutes';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines eilučių',
      few: '$lines eilutės',
      one: '$count eilutė',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopijuoti viską';

  @override
  String get attachmentsCopied => 'Nukopijuota';

  @override
  String get attachmentsImageUnavailable => 'Šio vaizdo čia parodyti negalima. Pabandykite „Atidaryti su…“.';

  @override
  String get attachmentsEmlNoSubject => '(Be temos)';

  @override
  String get attachmentsEmlFrom => 'Nuo';

  @override
  String get attachmentsEmlTo => 'Kam';

  @override
  String get attachmentsEmlCc => 'Kopija';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Šis laiškas neturi teksto.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Pridėta: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizatorius: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ir dar $count įvykių',
      few: 'Ir dar $count įvykiai',
      one: 'Ir dar $count įvykis',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Vaizdas';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format vaizdas';
  }

  @override
  String get attachmentsTypePdf => 'PDF dokumentas';

  @override
  String get attachmentsTypeTsv => 'Tabuliacija atskirtos reikšmės';

  @override
  String get attachmentsTypeCsv => 'CSV skaičiuoklė';

  @override
  String get attachmentsTypeCalendar => 'Kalendoriaus įvykis';

  @override
  String get attachmentsTypeEmail => 'El. laiškas';

  @override
  String get attachmentsTypeContact => 'Kontakto kortelė';

  @override
  String get attachmentsTypeLog => 'Žurnalo failas';

  @override
  String get attachmentsTypeText => 'Tekstas';

  @override
  String get attachmentsTypeZip => 'ZIP archyvas';

  @override
  String get attachmentsTypeArchive => 'Archyvas';

  @override
  String get attachmentsTypeWord => 'Word dokumentas';

  @override
  String get attachmentsTypeExcel => 'Excel skaičiuoklė';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint pateiktis';

  @override
  String get attachmentsTypeWebPage => 'Tinklalapis';

  @override
  String get attachmentsTypeVideo => 'Vaizdo įrašas';

  @override
  String get attachmentsTypeAudio => 'Garso įrašas';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension failas';
  }

  @override
  String get attachmentsTypeFile => 'Failas';

  @override
  String get calendarUntitledEvent => 'Įvykis';

  @override
  String get calendarAllDay => 'Visą dieną';

  @override
  String calendarYourTime(String time) {
    return '$time jūsų laiku';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Prisijungti: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name priėmė: $details',
      'tentative': '$name preliminariai priėmė: $details',
      'declined': '$name atmetė: $details',
      'delegated': '$name delegavo: $details',
      'other': '$name neatsakė į: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name priėmė kvietimą',
      'tentative': '$name preliminariai priėmė kvietimą',
      'declined': '$name atmetė kvietimą',
      'delegated': '$name delegavo kvietimą',
      'other': '$name neatsakė į kvietimą',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Žemėlapis';

  @override
  String get calendarJoin => 'Prisijungti';

  @override
  String get calendarOnlineMeeting => 'Internetinis susitikimas';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider susitikimas';
  }

  @override
  String get calendarOrganizerYou => 'Jūs';

  @override
  String get calendarOrganizerLabel => 'organizatorius';

  @override
  String get calendarStatusAccepted => 'Priimta';

  @override
  String get calendarStatusMaybe => 'Galbūt';

  @override
  String get calendarStatusDeclined => 'Atmesta';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name priėmė',
      'tentative': '$name preliminariai priėmė',
      'declined': '$name atmetė',
      'delegated': '$name delegavo',
      'other': '$name neatsakė',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name priėmė:',
      'tentative': '$name preliminariai priėmė:',
      'declined': '$name atmetė:',
      'delegated': '$name delegavo:',
      'other': '$name neatsakė:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name siūlo naują laiką';
  }

  @override
  String get calendarCounterUnknown => 'Dalyvis siūlo naują laiką';

  @override
  String get calendarDeclineCounter => 'Organizatorius paliko tą patį laiką';

  @override
  String calendarRefresh(String name) {
    return '$name prašo naujausios versijos';
  }

  @override
  String get calendarRefreshUnknown => 'Dalyvis prašo naujausios versijos';

  @override
  String get calendarCancelled => 'Atšauktas';

  @override
  String get calendarCancelledByOrganizer => 'Organizatorius atšaukė šį įvykį.';

  @override
  String get calendarCancelledLater => 'Šis įvykis vėliau buvo atšauktas.';

  @override
  String get calendarOutdated => 'Pasenęs';

  @override
  String get calendarOutdatedDetail => 'Šis kvietimas vėliau buvo atnaujintas; galioja naujesnis.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Vieta pašalinta (buvo $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Vieta pašalinta (nebuvo nurodyta)';

  @override
  String calendarLocationChanged(String location) {
    return 'Vieta pakeista į $location';
  }

  @override
  String get calendarNewTitle => 'Naujas pavadinimas';

  @override
  String get calendarRepeatChanged => 'Pasikeitė kartojimas';

  @override
  String get calendarUpdated => 'Atnaujinta';

  @override
  String get calendarUpdatedInvitation => 'Atnaujintas kvietimas';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Laikas pakeistas iš $before į $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Laiko juosta „$zone“ nežinoma: laikas toks, kaip parašyta';
  }

  @override
  String calendarNext(String when) {
    return 'Kitas: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count svečių',
      few: '$count svečiai',
      one: '$count svečias',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count priėmė');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count galbūt');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count atmetė');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (jūs)';
  }

  @override
  String get calendarAttendeeOptional => 'neprivalomas';

  @override
  String get calendarAttendeeRoom => 'patalpa';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Priėmėte ankstesnę versiją.',
      'tentative': 'Preliminariai priėmėte ankstesnę versiją.',
      'declined': 'Atmetėte ankstesnę versiją.',
      'delegated': 'Delegavote ankstesnę versiją.',
      'other': 'Neatsakėte į ankstesnę versiją.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Priimti';

  @override
  String get calendarMaybe => 'Galbūt';

  @override
  String get calendarDecline => 'Atmesti';

  @override
  String get calendarCommentHint => 'Komentaras organizatoriui (neprivaloma)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Jūsų atsakymas bus išsiųstas organizatoriui $organizer iš $address.';
  }

  @override
  String get calendarAddComment => 'Pridėti komentarą';

  @override
  String get calendarAddToCalendar => 'Įtraukti į kalendorių';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ir dar $count įvykių faile',
      few: 'Ir dar $count įvykiai faile',
      one: 'Ir dar $count įvykis faile',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Nėra kalendoriaus programos, į kurią būtų galima įtraukti įvykį.';

  @override
  String get calendarCantOpenCalendar => 'Nepavyko atidaryti kalendoriaus.';

  @override
  String get calendarCantOpenLink => 'Nepavyko atidaryti nuorodos.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Prisijungti prie $provider susitikimo?';
  }

  @override
  String get calendarJoinTitle => 'Prisijungti prie susitikimo?';

  @override
  String calendarJoinOpens(String host) {
    return 'Naršyklėje bus atidarytas $host.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Atsargiai: šis adresas panašiai atrodančiomis raidėmis imituoja $site.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Atsargiai: šis adresas panašiai atrodančiomis raidėmis imituoja kitą svetainę.';

  @override
  String calendarJoinOpen(String host) {
    return 'Atidaryti $host';
  }

  @override
  String get calendarNoOrganizer => 'Šis kvietimas neturi organizatoriaus, kuriam būtų galima atsakyti.';

  @override
  String get calendarNoAccount => 'Nėra paskyros, iš kurios būtų galima atsakyti.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Priimta', 'tentative': 'Galbūt', 'other': 'Atmesta'});
    return '$_temp0 · siunčiamas atsakymas: $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Priimta', 'tentative': 'Galbūt', 'other': 'Atmesta'});
    return '$_temp0 · atsakymas išsiųstas';
  }

  @override
  String get calendarReplyAlreadySent => 'Atsakymas jau išsiųstas.';

  @override
  String get calendarReplyNotSent => 'Atsakymas neišsiųstas.';

  @override
  String get dataSmimeNeedsDevice =>
      'Jūsų S/MIME sertifikatas yra šiame įrenginyje: atidarykite Loupe, kad pasirašytumėte ir išsiųstumėte šį laišką.';

  @override
  String dataSigningFailed(String error) {
    return 'Pasirašyti nepavyko: $error';
  }

  @override
  String get keyboardShortcuts => 'Spartieji klavišai';

  @override
  String get keyboardGroupGeneral => 'Bendrieji';

  @override
  String get keyboardGroupMessages => 'Laiškai';

  @override
  String get keyboardGroupCompose => 'Rašymas';

  @override
  String get keyboardCommandPalette => 'Komandų paletė';

  @override
  String get keyboardBackClose => 'Atgal, uždaryti';

  @override
  String get keyboardNextMessage => 'Kitas laiškas';

  @override
  String get keyboardPreviousMessage => 'Ankstesnis laiškas';

  @override
  String get keyboardOpenMessage => 'Atidaryti laišką';

  @override
  String get keyboardMoveToTrash => 'Perkelti į šiukšliadėžę';

  @override
  String get keyboardToggleRead => 'Pažymėti kaip skaitytą arba neskaitytą';

  @override
  String get keyboardToggleFlag => 'Pažymėti vėliavėle arba nuimti vėliavėlę';

  @override
  String get keyboardCloseDraft => 'Uždaryti (išsaugoti arba ištrinti juodraštį)';

  @override
  String get keyboardOr => 'arba';

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
  String get mailingListsMuted => 'Gija nutildyta. Nauji jos laiškai bus gaunami kaip skaityti.';

  @override
  String get mailingListsUnmuted => 'Gijos nutildymas atšauktas.';

  @override
  String get mailingListsMuteThread => 'Nutildyti giją';

  @override
  String get mailingListsUnmuteThread => 'Atšaukti gijos nutildymą';

  @override
  String get mailingListsPin => 'Prisegti prie pašto dėžučių';

  @override
  String get mailingListsUnpin => 'Atsegti nuo pašto dėžučių';

  @override
  String get mailingListsDefaultView => 'Atidaryti numatytuoju rodiniu';

  @override
  String get mailingListsPlainText => 'Atidaryti kaip paprastą tekstą (Mono)';

  @override
  String get mailingListsShowMuted => 'Rodyti nutildytas gijas';

  @override
  String get mailingListsHideMuted => 'Slėpti nutildytas gijas';

  @override
  String get mailingListsTreatAsNewsletter => 'Laikyti naujienlaiškiu';

  @override
  String get mailingListsOptions => 'Konferencijos parinktys';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted neskaitytų',
      few: '$formatted neskaityti',
      one: '$count neskaitytas',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Naujas laiškas konferencijai';

  @override
  String get mailingListsRowUnread => 'Neskaityta';

  @override
  String get mailingListsRowMuted => 'Nutildyta';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atsakymų',
      few: '$count atsakymai',
      one: '$count atsakymas',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Gijų nėra';

  @override
  String get mailingListsMutedHidden => 'Nutildytos gijos paslėptos.';

  @override
  String get mailingListsTechnicalTitle => 'Techninės konferencijos';

  @override
  String get mailingListsTechnicalEmpty => 'El. pašto konferencijos bus rodomos čia, kai tik gausite jų laiškų.';

  @override
  String get mailingListsTechnicalFooter =>
      'Šių konferencijų laiškai atidaromi kaip paprastas tekstas lygiapločiu šriftu, o pataisos rodomos kaip diff. Mygtuku Aa vis tiek galima perjungti bet kurį laišką.';

  @override
  String get paletteMoveToMailbox => 'Perkelti į pašto dėžutę…';

  @override
  String get paletteMarkAllRead => 'Pažymėti visus kaip skaitytus';

  @override
  String get paletteExportFolder => 'Eksportuoti aplanką…';

  @override
  String get paletteGetNewMail => 'Gauti naujus laiškus';

  @override
  String get paletteSnoozed => 'Atidėti';

  @override
  String get paletteSubscriptions => 'Prenumeratos';

  @override
  String get paletteDiscussions => 'Diskusijos';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'El. pašto konferencija';

  @override
  String get paletteTag => 'Žymė';

  @override
  String get paletteSwipeActions => 'Braukimo veiksmai';

  @override
  String get paletteNotifications => 'Pranešimai';

  @override
  String get paletteRules => 'Taisyklės';

  @override
  String get paletteEncryption => 'Ištisinis šifravimas';

  @override
  String get paletteAdvanced => 'Išplėstiniai';

  @override
  String get paletteAddAccount => 'Pridėti paskyrą';

  @override
  String get paletteAccount => 'Paskyra';

  @override
  String get paletteFolders => 'Aplankai';

  @override
  String get paletteRecentSearch => 'Neseniai ieškota';

  @override
  String paletteSearchMail(String query) {
    return 'Ieškoti laiškuose „$query“';
  }

  @override
  String get palettePlaceholder => 'Ieškoti veiksmų, pašto dėžučių, nustatymų';

  @override
  String get paletteNothingFound => 'Nieko nerasta';

  @override
  String get searchNewSmartMailbox => 'Nauja Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Rodo viską, kas atitinka „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ išsaugota pašto dėžutėse';
  }

  @override
  String get searchMakeRule => 'Paversti taisykle';

  @override
  String get searchSaveSmartMailbox => 'Išsaugoti kaip Smart Mailbox';

  @override
  String get searchNegate => 'Paneigti';

  @override
  String get searchDontNegate => 'Nebepaneigti';

  @override
  String get searchAllMailboxes => 'Visos pašto dėžutės';

  @override
  String get searchRecent => 'Naujausios paieškos';

  @override
  String get searchClear => 'Išvalyti';

  @override
  String get searchSuggestions => 'Pasiūlymai';

  @override
  String get searchUnreadMessages => 'Neskaityti laiškai';

  @override
  String get searchFlaggedMessages => 'Laiškai su vėliavėle';

  @override
  String get searchWithAttachments => 'Laiškai su priedais';

  @override
  String get searchUnrepliedMessages => 'Neatsakyti laiškai';

  @override
  String get searchTags => 'Žymės';

  @override
  String get searchPeople => 'Žmonės';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Nuo: $name';
  }

  @override
  String get searchSearching => 'Ieškoma…';

  @override
  String get searchNoResults => 'Rezultatų nėra';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted rezultatų',
      few: '$formatted rezultatai',
      one: '$count rezultatas',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Paieškos meniu';

  @override
  String searchSearchingAccount(String account) {
    return 'Ieškoma paskyroje $account serveryje…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Ieškoma paskyroje serveryje…';

  @override
  String searchAccountFailed(String account) {
    return 'Nepavyko ieškoti paskyroje $account serveryje';
  }

  @override
  String get searchUnknownAccountFailed => 'Nepavyko ieškoti paskyroje serveryje';

  @override
  String searchChip(String term) {
    return '$term. Dukart bakstelėkite, kad redaguotumėte.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ne $term. Dukart bakstelėkite, kad redaguotumėte.';
  }

  @override
  String get searchReadAndUnread =>
      'Šrėdingerio pašto dėžutė: kiekvienas laiškas čia yra ir skaitytas, ir neskaitytas, kol jo neatidarote.';

  @override
  String searchContradiction(String term) {
    return 'Joks laiškas negali kartu būti „$term“ ir nebūti.';
  }

  @override
  String get searchSyncDeviceOnly => 'Tik šiame įrenginyje';

  @override
  String searchSyncUnsupported(String account) {
    return 'Tik šiame įrenginyje: $account negali jos saugoti';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nesinchronizuota: $account turi naujesnį formatą';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Laukiama sinchronizavimo su $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinchronizuota su $account';
  }

  @override
  String get searchRename => 'Pervardyti';

  @override
  String get searchEditSearch => 'Redaguoti paiešką';

  @override
  String get searchDeleteSmartMailbox => 'Ištrinti Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Pervardyti Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Ši Smart Mailbox ištrinta.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes lieka šiame įrenginyje.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes saugomos jūsų pašto serveryje, todėl jas turi ir kiti jūsų įrenginiai, taip pat Thunderbird su Expression Search Reloaded. Tos, kurios ieško visose paskyrose, saugomos paskyroje $account; vieno aplanko – to aplanko paskyroje.';
  }

  @override
  String get searchSyncVia => 'Sinchronizuoti per';

  @override
  String get searchSyncViaFooter => 'Kiekviename įrenginyje pasirinkite tą pačią paskyrą.';

  @override
  String get searchGmailCantKeep => 'Gmail negali saugoti Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Saugoti Smart Mailboxes tik šiame įrenginyje';

  @override
  String get searchOnTheServer => 'Serveryje';

  @override
  String get searchServerFooter =>
      'Serverio metaduomenys (IMAP METADATA) nerodomi jokioje pašto programoje. Serveriuose be jų sukuriamas aplankas „Loupe Settings“ su vienu laišku; Loupe jį slepia pašto dėžučių sąraše.';

  @override
  String get searchSyncNow => 'Sinchronizuoti dabar';

  @override
  String get searchStateUnsupported => 'Nepalaikoma';

  @override
  String get searchStateNewerFormat => 'Naujesnis formatas';

  @override
  String get searchStateFailed => 'Nepavyko sinchronizuoti';

  @override
  String get searchStateSyncing => 'Sinchronizuojama…';

  @override
  String get searchStateWaiting => 'Laukiama';

  @override
  String get searchStateMetadata => 'Serverio metaduomenys';

  @override
  String get searchStateFolder => 'Aplankas „Loupe Settings“';

  @override
  String get searchStateNothing => 'Nieko nesaugoma';

  @override
  String get sharedBack => 'Atgal';

  @override
  String get sharedYesterday => 'Vakar';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baitų',
      few: '$count baitai',
      one: '$count baitas',
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
  String get sharedSyncNoAccounts => 'Paskyrų nėra';

  @override
  String get sharedSyncChecking => 'Tikrinami laiškai…';

  @override
  String get sharedSyncFailed => 'Nepavyko patikrinti laiškų';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Neprisijungta';

  @override
  String get sharedSyncJustNow => 'Ką tik atnaujinta';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Atnaujinta prieš $minutes minučių',
      few: 'Atnaujinta prieš $minutes minutes',
      one: 'Atnaujinta prieš $minutes minutę',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Atnaujinta $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Atnaujinta $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Visi gauti laiškai';

  @override
  String get sharedMailboxUnread => 'Neskaityti';

  @override
  String get sharedMailboxFlagged => 'Su vėliavėle';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Visi juodraščiai';

  @override
  String get sharedMailboxAllSent => 'Visi išsiųsti';

  @override
  String get sharedMailboxUntitled => 'Pašto dėžutė';

  @override
  String get sharedTagImportant => 'Svarbu';

  @override
  String get sharedTagWork => 'Darbas';

  @override
  String get sharedTagPersonal => 'Asmeniška';

  @override
  String get sharedTagToDo => 'Atlikti';

  @override
  String get sharedTagLater => 'Vėliau';

  @override
  String get sharedTags => 'Žymės';

  @override
  String get sharedMoveTo => 'Perkelti į…';

  @override
  String get sharedNoRecipients => 'Nėra gavėjų';

  @override
  String get sharedUnknownSender => 'Nežinomas siuntėjas';

  @override
  String get sharedOnServer => 'Serveryje';

  @override
  String get sharedAttachment => 'Priedas';

  @override
  String get sharedSnoozedBadge => 'Atidėtas';

  @override
  String get sharedRowUnread => 'Neskaitytas';

  @override
  String get sharedRowBackFromSnooze => 'Grįžo po atidėjimo';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Su vėliavėle';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archyvuota $count laiškų',
      few: 'Archyvuoti $count laiškai',
      one: 'Archyvuotas $count laiškas',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ištrinta $count laiškų',
      few: 'Ištrinti $count laiškai',
      one: 'Ištrintas $count laiškas',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų perkelta į „Gauti laiškai“',
      few: '$count laiškai perkelti į „Gauti laiškai“',
      one: '$count laiškas perkeltas į „Gauti laiškai“',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų perkelta į šiukšliadėžę',
      few: '$count laiškai perkelti į šiukšliadėžę',
      one: '$count laiškas perkeltas į šiukšliadėžę',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų perkelta į šlamštą',
      few: '$count laiškai perkelti į šlamštą',
      one: '$count laiškas perkeltas į šlamštą',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų perkelta į $mailbox',
      few: '$count laiškai perkelti į $mailbox',
      one: '$count laiškas perkeltas į $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų perkelta į pašto dėžutę',
      few: '$count laiškai perkelti į pašto dėžutę',
      one: '$count laiškas perkeltas į pašto dėžutę',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count laiškų atidėta iki $time',
      few: '$count laiškai atidėti iki $time',
      one: '$count laiškas atidėtas iki $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Atidėta iki $time tik šiame įrenginyje: serveris negali saugoti atidėjimo laikų.';
  }

  @override
  String get sharedMoveOneAccount => 'Kad perkeltumėte laiškus, pasirinkite juos iš vienos paskyros.';

  @override
  String get sharedSnoozeTitle => 'Atidėti';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Keisti atidėjimo laiką';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Visam laikui ištrinti $count laiškų?',
      few: 'Visam laikui ištrinti $count laiškus?',
      one: 'Visam laikui ištrinti $count laišką?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'To negalima anuliuoti.';

  @override
  String get sharedDeletePermanently => 'Ištrinti visam laikui';

  @override
  String get sharedSwipeRead => 'Skaityta';

  @override
  String get sharedSwipeUnread => 'Neskaityta';

  @override
  String get sharedSwipeInbox => 'Gauti';

  @override
  String get sharedSwipeDelete => 'Ištrinti';

  @override
  String get sharedTrash => 'Į šiukšliadėžę';

  @override
  String get sharedSwipeSnooze => 'Atidėti';

  @override
  String get sharedWakeNow => 'Grąžinti dabar';

  @override
  String get sharedChangeSnoozeTime => 'Keisti atidėjimo laiką…';

  @override
  String get sharedSnooze => 'Atidėti…';

  @override
  String get sharedTag => 'Žymėti…';

  @override
  String get sharedMoveMessage => 'Perkelti laišką…';

  @override
  String get sharedNotJunk => 'Ne šlamštas';

  @override
  String get accountSetupTitle => 'Pridėti paskyrą';

  @override
  String get accountSetupTitleDone => 'Paskyra pridėta';

  @override
  String get accountSetupAddressTitle => 'Pridėti pašto paskyrą';

  @override
  String get accountSetupAddressText => 'Loupe randa daugumos paslaugų teikėjų nustatymus.';

  @override
  String get accountSetupNameHint => 'Jūsų vardas';

  @override
  String get accountSetupEmail => 'El. paštas';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Tęsti';

  @override
  String get accountSetupLookingUp => 'Ieškoma nustatymų…';

  @override
  String get accountSetupImport => 'Importuoti iš Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Įveskite tinkamą el. pašto adresą.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nepavyko rasti $domain nustatymų. Įveskite juos žemiau.';
  }

  @override
  String get accountSetupCheckServers => 'Patikrinkite serverių pavadinimus ir prievadus.';

  @override
  String get accountSetupEnterPassword => 'Įveskite slaptažodį.';

  @override
  String get accountSetupConnecting => 'Jungiamasi…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Laukiama $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Nepavyko atidaryti puslapio.';

  @override
  String get accountSetupCouldNotSaveName => 'Nepavyko išsaugoti pavadinimo.';

  @override
  String get accountSetupTrustCertificate => 'Pasitikėti šiuo sertifikatu';

  @override
  String get accountSetupPasswordRequired => 'Privaloma';

  @override
  String get accountSetupShowPassword => 'Rodyti slaptažodį';

  @override
  String get accountSetupHidePassword => 'Slėpti slaptažodį';

  @override
  String get accountSetupAppPassword => 'Programėlės slaptažodis';

  @override
  String get accountSetupApiToken => 'API prieigos raktas';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Gaunamasis · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Siunčiamasis · SMTP';

  @override
  String get accountSetupSignIn => 'Prisijungti';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Prisijungti per $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Naudoti programėlės slaptažodį';

  @override
  String get accountSetupUseAppPasswordInstead => 'Vietoj to naudoti programėlės slaptažodį';

  @override
  String get accountSetupUseDifferentAddress => 'Naudoti kitą adresą';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kaip sukurti programėlės slaptažodį';

  @override
  String get accountSetupHowToCreateOne => 'Kaip jį sukurti';

  @override
  String get accountSetupGoogleNote =>
      'Prisijungiate Google puslapyje, o Loupe niekada nemato jūsų slaptažodžio. Leiskite Loupe skaityti, siųsti ir tvarkyti jūsų laiškus.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Prisijungti per Google“ šioje versijoje dar nepasiekiama. Vietoj to galite prisijungti su programėlės slaptažodžiu (jūsų Google paskyroje turi būti įjungtas patvirtinimas dviem veiksmais).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Sukurkite programėlės slaptažodį savo Google paskyroje ir įklijuokite jį žemiau.';

  @override
  String get accountSetupMicrosoftNote =>
      'Prisijungiate Microsoft puslapyje, o Loupe niekada nemato jūsų slaptažodžio. Tai veikia su Outlook.com ir Hotmail, taip pat su darbo ar mokymo įstaigos Microsoft 365 paskyromis.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Prisijungimas per Microsoft atsiras vėlesnėje versijoje. Outlook, Hotmail ir Microsoft 365 paskyroms jo reikia: jos nebepriima slaptažodžių iš pašto programų.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail reikia konkrečiai programėlei skirto slaptažodžio, o ne jūsų Apple paskyros slaptažodžio.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail reikia programėlės slaptažodžio, o ne jūsų paskyros slaptažodžio.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe jungiasi prie Fastmail per JMAP su API prieigos raktu: Settings › Privacy & Security › Manage API tokens, skirtu JMAP, su prieiga prie el. pašto ir siuntimo.';

  @override
  String get accountSetupFastmailNote => 'Fastmail pašto programoms reikia programėlės slaptažodžio.';

  @override
  String get accountSetupServerSettings => 'Serverio nustatymai';

  @override
  String get accountSetupSettingsNotFound => 'Automatiškai nerasta';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Rasta per $source';
  }

  @override
  String get accountSetupEditSettings => 'Redaguoti nustatymus';

  @override
  String get accountSetupSyncing => 'Jūsų laiškai sinchronizuojami.';

  @override
  String get accountSetupDescription => 'Aprašas';

  @override
  String get accountSetupDescriptionHint => 'Darbas, asmeninė…';

  @override
  String get accountSetupColour => 'Spalva';

  @override
  String accountSetupColourNumber(int number) {
    return 'Spalva $number';
  }

  @override
  String get accountSetupSaving => 'Išsaugoma…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nepavyko atidaryti savo pašto duomenų bazės šiame telefone. Uždarykite Loupe, vėl ją atidarykite ir bandykite dar kartą.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Kažkas nepavyko ($error). Bandykite dar kartą.';
  }

  @override
  String get accountSetupSecurityNone => 'Nėra';

  @override
  String get accountSetupProtocol => 'Protokolas';

  @override
  String get accountSetupPort => 'Prievadas';

  @override
  String get accountSetupSecurity => 'Saugumas';

  @override
  String get accountSetupUsername => 'Naudotojo vardas';

  @override
  String get accountSetupUsernameHint => 'Jūsų el. pašto adresas';

  @override
  String get accountSetupNoEncryptionTitle => 'Jungtis be šifravimo?';

  @override
  String get accountSetupNoEncryptionText =>
      'Jūsų slaptažodis ir kiekvienas laiškas keliautų kaip paprastas tekstas. Bet kas tinkle, pavyzdžiui, viešajame Wi-Fi, galėtų juos perskaityti. Naudokite tai tik serveriui savo tinkle.';

  @override
  String get accountSetupUseWithoutEncryption => 'Naudoti be šifravimo';

  @override
  String get accountSetupApiTokenRejected =>
      'API prieigos raktas atmestas. Sukurkite Fastmail API prieigos raktą, skirtą JMAP, su prieiga prie el. pašto, ir įklijuokite jį.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Slaptažodis atmestas. Naudokite programėlės slaptažodį, o ne paskyros slaptažodį.';

  @override
  String get accountSetupPasswordRejected => 'Slaptažodis atmestas. Patikrinkite jį ir bandykite dar kartą.';

  @override
  String get accountSetupServerUnreachable => 'Nepavyksta pasiekti serverio. Patikrinkite serverio nustatymus ir ryšį.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Serverio sertifikatas nepatikimas. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Prisijungimas atšauktas. Bakstelėkite „Prisijungti per $provider“, kad bandytumėte dar kartą.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe reikia leidimo skaityti ir siųsti jūsų Gmail laiškus. Prisijunkite iš naujo ir leiskite prieigą, pažymėję Gmail langelį.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe reikia leidimo skaityti ir siųsti jūsų laiškus. Prisijunkite iš naujo ir sutikite su leidimais.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Jūsų organizacija turi patvirtinti Loupe, kad galėtumėte ją naudoti su šia paskyra. Paprašykite IT administratoriaus suteikti administratoriaus sutikimą Loupe per Microsoft Entra ID, tada bandykite dar kartą.';

  @override
  String get accountSetupOAuthBlocked =>
      'Jūsų organizacijos prisijungimo taisyklės neleidžia naudoti Loupe šiame įrenginyje. Kreipkitės į IT administratorių.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Nepavyko pasiekti $provider. Patikrinkite interneto ryšį ir bandykite dar kartą.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Prisijungimas per $provider šioje Loupe versijoje nustatytas netinkamai. Praneškite apie tai.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Prisijungti per $provider nepavyko. Bandykite dar kartą.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider jus prijungė, bet Gmail atsisakė suteikti prieigą prie šio adreso. Prisijungdami pasirinkite tą pačią paskyrą. Darbo ar mokymo įstaigos paskyrose administratorius galėjo išjungti IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider jus prijungė, bet pašto serveris atsisakė suteikti prieigą prie šio adreso. Prisijungdami pasirinkite tą pačią paskyrą. Darbo ar mokymo įstaigos paskyrose administratorius galėjo išjungti IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Nepavyksta pasiekti pašto serverio. Patikrinkite ryšį ir bandykite dar kartą.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Prisijungimas per $provider šioje versijoje nepasiekiamas.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Prisijungta iš naujo. $account sinchronizuojama.';
  }

  @override
  String get accountSetupSignInAgain => 'Prisijungti iš naujo';

  @override
  String get accountSetupSigningIn => 'Prisijungiama…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider nebepriima Loupe prisijungimo adresui $email, todėl $account nesinchronizuojama. Prisijunkite iš naujo, kad gautumėte jos laiškus.';
  }

  @override
  String get accountImportTitle => 'Importuoti iš Thunderbird';

  @override
  String get accountImportPointCamera => 'Nukreipkite kamerą į Thunderbird rodomą QR kodą.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Nuskaityta $scanned iš $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Nuskaityta $scanned iš $total kodų',
      few: 'Nuskaityta $scanned iš $total kodų',
      one: 'Nuskaityta $scanned iš $total kodo',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kol kas $count paskyrų',
      few: 'Kol kas $count paskyros',
      one: 'Kol kas $count paskyra',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Kompiuteryje atidarykite Thunderbird ir pasirinkite Priemonės › Eksportuoti į mobilųjį įrenginį. Pažymėkite savo paskyras, tada nuskaitykite kiekvieną rodomą kodą. Kodus galima nuskaityti bet kuria tvarka.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tęsti su $count paskyrų',
      few: 'Tęsti su $count paskyromis',
      one: 'Tęsti su $count paskyra',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Vietoj to įklijuoti tekstą';

  @override
  String get accountImportStartOver => 'Pradėti iš naujo';

  @override
  String get accountImportDuplicateCode => 'Šis kodas jau pridėtas.';

  @override
  String get accountImportRestarted =>
      'Šis kodas yra iš naujo eksporto, todėl anksčiau nuskaityti kodai atidėti į šalį.';

  @override
  String get accountImportNotThunderbird => 'Tai ne Thunderbird paskyros kodas.';

  @override
  String get accountImportNewerVersion =>
      'Šis kodas yra iš naujesnės Thunderbird versijos. Atnaujinkite Loupe, kad jį importuotumėte.';

  @override
  String get accountImportDamaged => 'Šio Thunderbird kodo nepavyko perskaityti.';

  @override
  String get accountImportTooLarge => 'Šis kodas per didelis, kad būtų Thunderbird eksportas.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nepavyko atidaryti nustatymų.';

  @override
  String get accountImportCameraOffTitle => 'Prieiga prie kameros išjungta';

  @override
  String get accountImportCameraOffText =>
      'Nustatymuose leiskite Loupe naudoti kamerą, kad nuskaitytumėte kodą, arba vietoj to įklijuokite kodo tekstą.';

  @override
  String get accountImportNoCameraTitle => 'Kameros nėra';

  @override
  String get accountImportNoCameraText => 'Loupe čia negali naudoti kameros. Vietoj to įklijuokite kodo tekstą.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera neįsijungė';

  @override
  String get accountImportCameraFailedText => 'Bandykite dar kartą arba vietoj to įklijuokite kodo tekstą.';

  @override
  String get accountImportOpenSettings => 'Atidaryti nustatymus';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rasta $count paskyrų',
      few: 'Rastos $count paskyros',
      one: 'Rasta $count paskyra',
      zero: 'Paskyrų nerasta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nepavyko perskaityti nė vienos šiuose koduose esančios paskyros.';

  @override
  String get accountImportChoose => 'Pasirinkite paskyras, kurias norite pridėti prie Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nenuskaityta $count kodų iš $total ($codes), todėl jų paskyros nerodomos.',
      few: 'Nenuskaityti $count kodai iš $total ($codes), todėl jų paskyros nerodomos.',
      one: 'Nenuskaitytas $count kodas iš $total ($codes), todėl jo paskyros nerodomos.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes ir $last';
  }

  @override
  String get accountImportScanMore => 'Nuskaityti daugiau kodų';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Koduose nepavyko perskaityti $count paskyrų. Galbūt jose naudojami naujesnės Thunderbird versijos nustatymai.',
      few:
          'Koduose nepavyko perskaityti $count paskyrų. Galbūt jose naudojami naujesnės Thunderbird versijos nustatymai.',
      one:
          'Koduose nepavyko perskaityti $count paskyros. Galbūt joje naudojami naujesnės Thunderbird versijos nustatymai.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Nuskaityti dar kartą';

  @override
  String get accountImportAlreadyAdded => 'Paskyra su šiuo adresu jau yra Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Ją pridėjus prisijungsite per $provider, kaip ir Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Pridėkite paskyrą su programėlės slaptažodžiu (reikia patvirtinimo dviem veiksmais).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird prie Gmail jungiasi per Google. „Prisijungti per Google“ atsiras vėlesnėje versijoje; iki tol pridėkite paskyrą su programėlės slaptažodžiu (reikia patvirtinimo dviem veiksmais).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird prie šios paskyros jungiasi naršyklėje. Loupe to dar negali: naudokite programėlės slaptažodį, jei jūsų paslaugų teikėjas jį siūlo.';

  @override
  String get accountImportUnencrypted => 'Jungiasi be šifravimo. Naudokite tai tik savo tinkle.';

  @override
  String get accountImportEnterAgain => 'Įveskite dar kartą';

  @override
  String get accountImportAdded => 'Pridėta';

  @override
  String accountImportAdding(int index, int total) {
    return 'Pridedama $index iš $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pridėti $count paskyrų',
      few: 'Pridėti $count paskyras',
      one: 'Pridėti $count paskyrą',
      zero: 'Pridėti paskyras',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Įklijuoti eksporto tekstą';

  @override
  String get accountImportPasteText => 'Įklijuokite Thunderbird eksporto kodo tekstą, po vieną kodą eilutėje.';

  @override
  String get accountImportPop3 => 'POP3 paskyros nepalaikomos. Loupe laiškus laiko serveryje naudodama IMAP.';

  @override
  String get accountImportKerberos => 'Ši paskyra jungiasi naudodama Kerberos, kurio Loupe nepalaiko.';

  @override
  String get accountImportNtlm => 'Ši paskyra jungiasi naudodama NTLM, kurio Loupe nepalaiko.';

  @override
  String get accountImportClientCertificate =>
      'Ši paskyra jungiasi naudodama kliento sertifikatą, kurio Loupe dar nepalaiko.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Prisijungimas per Microsoft atsiras vėlesnėje versijoje. Outlook ir Microsoft 365 paskyros nebepriima slaptažodžių iš pašto programų.';

  @override
  String get accountImportEnterPassword => 'Įveskite slaptažodį.';

  @override
  String get accountImportEnterAppPassword => 'Įveskite programėlės slaptažodį.';

  @override
  String get accountImportEnterApiToken => 'Įveskite API prieigos raktą.';

  @override
  String get accountImportStorageFailed => 'Loupe nepavyko atidaryti savo paskyrų saugyklos. Bandykite vėliau.';

  @override
  String get accountImportFailed => 'Nepavyko pridėti paskyros. Bandykite dar kartą arba pridėkite ją rankiniu būdu.';

  @override
  String get composeNewMessageTitle => 'Naujas laiškas';

  @override
  String get composeAttach => 'Pridėti priedą';

  @override
  String get composeSendLater => 'Siųsti vėliau';

  @override
  String composeSendAt(String time) {
    return 'Siųsti $time';
  }

  @override
  String get composeSendHint => 'Paspauskite ilgai, kad išsiųstumėte vėliau';

  @override
  String get composeNoAccount => 'Kad galėtumėte siųsti laiškus, pridėkite paskyrą.';

  @override
  String get composeTo => 'Kam:';

  @override
  String get composeCc => 'Kopija:';

  @override
  String get composeBcc => 'Slapta kopija:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopija / slapta kopija, nuo: $email';
  }

  @override
  String get composeFromLabel => 'Nuo:';

  @override
  String get composeSubjectLabel => 'Tema:';

  @override
  String composeReplyTo(String address) {
    return 'Atsakyti kam: $address';
  }

  @override
  String get composeFrom => 'Nuo';

  @override
  String composeReplyFrom(String email) {
    return 'Atsakyti iš $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Siųsti iš $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Atsakyti iš $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Siųsti iš $email?';
  }

  @override
  String get composeDismiss => 'Atmesti';

  @override
  String composeAliasNotSaved(String account) {
    return 'Neišsaugota kaip tapatybė · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Išsaugoti kaip tapatybę';

  @override
  String composeAliasSaved(String email) {
    return '$email išsaugotas kaip tapatybė.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Netinkamas adresas $address';
  }

  @override
  String get composeOriginalNotFound => 'Nepavyko rasti pradinio laiško.';

  @override
  String get composeDraftNotFound => 'Nepavyko rasti juodraščio.';

  @override
  String get composeAttachmentsLost => 'Priedų nepavyko atkurti. Pridėkite juos dar kartą.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Kai kurių priedų nepavyko pridėti: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Priedų bendras dydis – $size; kai kurie serveriai atmeta tokio dydžio laiškus.';
  }

  @override
  String get composeAttachFailed => 'Nepavyko pridėti failo.';

  @override
  String get composeInvalidAddressTitle => 'Netinkamas adresas';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ nėra tinkamas el. pašto adresas.';
  }

  @override
  String get composeNoSubjectTitle => 'Nėra temos';

  @override
  String get composeNoSubjectText => 'Šis laiškas neturi temos. Vis tiek siųsti?';

  @override
  String get composeSentBeforeChanges => 'Jis buvo išsiųstas prieš jūsų pakeitimus, kurie išsaugoti juodraščiuose.';

  @override
  String composeScheduled(String time) {
    return 'Suplanuota: $time';
  }

  @override
  String get composeSending => 'Siunčiama…';

  @override
  String get composeSent => 'Išsiųsta';

  @override
  String get composeSendFailed => 'Nepavyko išsiųsti. Bandykite dar kartą.';

  @override
  String get composeAlreadySent => 'Jau išsiųsta.';

  @override
  String get composeDiscardChanges => 'Atmesti pakeitimus';

  @override
  String get composeSaveChanges => 'Išsaugoti pakeitimus';

  @override
  String get composeDeleteDraft => 'Ištrinti juodraštį';

  @override
  String get composeSaveDraft => 'Išsaugoti juodraštį';

  @override
  String get composeDraftSaved => 'Juodraštis išsaugotas';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date $time $name rašė:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date $time kažkas rašė:';
  }

  @override
  String get composeForwardHeader => '---------- Persiųstas laiškas ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Nuo: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Tema: $subject';
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
  String get composeLaterToday => 'Vėliau šiandien';

  @override
  String get composeTomorrowMorning => 'Rytoj ryte';

  @override
  String get composeMondayMorning => 'Pirmadienio rytą';

  @override
  String get composePickDateTime => 'Pasirinkti datą ir laiką…';

  @override
  String get composeSendWithoutDelay => 'Siųsti nedelsiant';

  @override
  String composeSendTimeToday(String time) {
    return 'Šiandien $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Rytoj $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Šiandien $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Rytoj $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Tęsti juodraščio redagavimą?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Uždarant Loupe vienas laiškas liko neišsiųstas.',
      'one': 'Uždarant Loupe laiškas gavėjui $name liko neišsiųstas.',
      'other': 'Uždarant Loupe laiškas gavėjui $name ir kitiems liko neišsiųstas.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Uždarant Loupe „$subject“ liko neišsiųstas.',
      'one': 'Uždarant Loupe „$subject“ gavėjui $name liko neišsiųstas.',
      'other': 'Uždarant Loupe „$subject“ gavėjui $name ir kitiems liko neišsiųstas.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Tęsti redagavimą';

  @override
  String get composeRecoverySave => 'Išsaugoti juodraščiuose';

  @override
  String get composeRecoveryDiscard => 'Atmesti';

  @override
  String get composeRecoverySaved => 'Išsaugota juodraščiuose';

  @override
  String get outboxSectionFailed => 'Neišsiųsti';

  @override
  String get outboxSectionSending => 'Siunčiami';

  @override
  String get outboxSectionScheduled => 'Suplanuoti';

  @override
  String get outboxStatusQueued => 'Netrukus bus išsiųstas';

  @override
  String get outboxStatusSending => 'Siunčiama…';

  @override
  String get outboxStatusFailed => 'Neišsiųstas';

  @override
  String get outboxNoRecipients => 'Nėra gavėjų';

  @override
  String get outboxNoSubject => '(Be temos)';

  @override
  String get outboxSendingFailed => 'Išsiųsti nepavyko.';

  @override
  String get outboxEmptyTitle => 'Nėra ką siųsti';

  @override
  String get outboxEmptyText => 'Vėliau siunčiami laiškai laukia čia, kol ateis laikas.';

  @override
  String get outboxSendNow => 'Siųsti dabar';

  @override
  String get outboxReschedule => 'Perplanuoti';

  @override
  String get outboxRescheduleMenu => 'Perplanuoti…';

  @override
  String get outboxRescheduleTitle => 'Perplanuoti';

  @override
  String outboxRescheduled(String time) {
    return 'Perplanuota: $time';
  }

  @override
  String get outboxCancel => 'Atšaukti';

  @override
  String get outboxCancelSending => 'Atšaukti siuntimą…';

  @override
  String get outboxCancelTitle => 'Atšaukti siuntimą?';

  @override
  String get outboxMoveToDrafts => 'Perkelti į juodraščius';

  @override
  String get outboxDiscard => 'Atmesti laišką';

  @override
  String get outboxMovedToDrafts => 'Perkelta į juodraščius';

  @override
  String get outboxDiscarded => 'Laiškas atmestas';

  @override
  String get outboxAlreadySent => 'Jau išsiųsta.';

  @override
  String get outboxBeingSent => 'Šis laiškas siunčiamas.';

  @override
  String get outboxActionFailed => 'Nepavyko. Laiškas vis dar yra aplanke „Siunčiamieji“.';

  @override
  String get notificationsBadgeInboxes => 'Neskaityti gautuose';

  @override
  String get notificationsBadgeVip => 'Neskaityti nuo VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nauji laiškai iš jūsų VIP bet kurioje paskyroje';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nauji laiškai paskyroje $email';
  }

  @override
  String get notificationsUnknownSender => 'Nežinomas siuntėjas';

  @override
  String get notificationsNoSubject => '(Be temos)';

  @override
  String get notificationsEncryptedMessage => 'Šifruotas laiškas';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Naujas laiškas: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count naujų laiškų',
      few: '$count nauji laiškai',
      one: '$count naujas laiškas',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nauji laiškai: $account';
  }

  @override
  String get platformInstantChannel => 'Momentinis pristatymas';

  @override
  String get platformInstantChannelDescription =>
      'Rodoma, kol Loupe stebi jūsų gautuosius aplankus ir laukia naujų laiškų';

  @override
  String get platformInstantTitle => 'Laukiama naujų laiškų';

  @override
  String get platformInstantText => 'Momentinis pristatymas įjungtas';

  @override
  String get platformErrorBox => 'Rodant šią dalį kažkas nepavyko. Grįžkite ir bandykite dar kartą.';

  @override
  String get welcomeTagline => 'Paštas, paprastas paviršiuje\nir galingas viduje.';

  @override
  String get welcomeAccountsTitle => 'Visos paskyros vienoje ramioje pašto dėžutėje';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail ir bet kuris IMAP ar JMAP serveris.';

  @override
  String get welcomeSearchTitle => 'Paieška, kuri randa';

  @override
  String get welcomeSearchText => 'Akimirksniu gaunami rezultatai jūsų telefone, paskui – iš serverio.';

  @override
  String get welcomePrivacyTitle => 'Privatumas pagal sumanymą';

  @override
  String get welcomePrivacyText => 'Jokio sekimo. Nuotoliniai vaizdai lieka blokuojami, kol neleisite.';

  @override
  String get welcomeAddAccount => 'Pridėti paskyrą';

  @override
  String get welcomeImport => 'Importuoti iš Thunderbird';

  @override
  String get welcomeTryDemo => 'Išbandyti su demonstraciniu paštu';
}
