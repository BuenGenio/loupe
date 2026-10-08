// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get commonAdd => 'Lisa';

  @override
  String get commonCancel => 'Tühista';

  @override
  String get commonClose => 'Sulge';

  @override
  String get commonDelete => 'Kustuta';

  @override
  String get commonDone => 'Valmis';

  @override
  String get commonEdit => 'Muuda';

  @override
  String get commonMore => 'Rohkem';

  @override
  String get commonMove => 'Teisalda';

  @override
  String get commonName => 'Nimi';

  @override
  String get commonNone => 'Puudub';

  @override
  String get commonOff => 'Väljas';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Sees';

  @override
  String get commonOptional => 'Valikuline';

  @override
  String get commonPassword => 'Parool';

  @override
  String get commonRemove => 'Eemalda';

  @override
  String get commonRetry => 'Proovi uuesti';

  @override
  String get commonSave => 'Salvesta';

  @override
  String get commonSearch => 'Otsing';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Seaded';

  @override
  String get commonShare => 'Jaga';

  @override
  String get commonTryAgain => 'Proovi uuesti';

  @override
  String get commonUndo => 'Võta tagasi';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kirja', one: '$count kiri');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arhiveeri';

  @override
  String get mailDelete => 'Kustuta';

  @override
  String get mailFlag => 'Märgista';

  @override
  String get mailForward => 'Edasta';

  @override
  String get mailMarkAsRead => 'Märgi loetuks';

  @override
  String get mailMarkAsUnread => 'Märgi lugemata';

  @override
  String get mailMoveToJunk => 'Teisalda rämpsposti';

  @override
  String get mailNewMessage => 'Uus kiri';

  @override
  String get mailNoSubject => 'Teema puudub';

  @override
  String get mailReply => 'Vasta';

  @override
  String get mailReplyAll => 'Vasta kõigile';

  @override
  String get mailSend => 'Saada';

  @override
  String get mailUnflag => 'Eemalda märgistus';

  @override
  String get mailboxArchive => 'Arhiiv';

  @override
  String get mailboxDrafts => 'Mustandid';

  @override
  String get mailboxInbox => 'Sisendkaust';

  @override
  String get mailboxJunk => 'Rämpspost';

  @override
  String get mailboxOutbox => 'Väljuvad kirjad';

  @override
  String get mailboxSent => 'Saadetud';

  @override
  String get mailboxTrash => 'Prügikast';

  @override
  String get conversationSomethingWentWrong => 'Midagi läks valesti. Proovi uuesti.';

  @override
  String get conversationReplyToList => 'Vasta postiloendile';

  @override
  String get conversationReplyList => 'Vasta loendile';

  @override
  String get conversationThreadMuted => 'Lõim on vaigistatud. Selle uued kirjad saabuvad loetuna.';

  @override
  String get conversationThreadUnmuted => 'Lõim pole enam vaigistatud.';

  @override
  String get conversationLinkFailed => 'Linki ei õnnestunud avada.';

  @override
  String get conversationGoneTitle => 'Kirja pole';

  @override
  String get conversationGoneText => 'See kiri on teisaldatud või kustutatud.';

  @override
  String get conversationMuted => 'Vaigistatud';

  @override
  String get conversationReaderOptions => 'Lugemisvalikud';

  @override
  String get conversationReaderOptionsHint => 'Teksti suurus ja vaade';

  @override
  String get conversationTrash => 'Prügikasti';

  @override
  String get conversationReplyHint => 'Vajuta pikalt, et vastata kõigile või edastada';

  @override
  String get conversationOfflineTitle => 'Võrguühendus puudub';

  @override
  String get conversationOfflineText => 'Seda vestlust pole veel alla laaditud. See laaditakse, kui oled taas võrgus.';

  @override
  String get conversationErrorTitle => 'Seda kirja ei saa näidata';

  @override
  String get conversationErrorText => 'Midagi läks valesti.';

  @override
  String get conversationOfflineBanner => 'Võrguühendus puudub';

  @override
  String get conversationNotUpdated => 'Pole värskendatud';

  @override
  String get conversationMe => 'mina';

  @override
  String get conversationNoSender => '(saatja puudub)';

  @override
  String get conversationNoRecipients => 'saajad puuduvad';

  @override
  String conversationRecipients(String names) {
    return 'saaja: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'saaja: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Saatja';

  @override
  String get conversationHeaderTo => 'Saaja';

  @override
  String get conversationHeaderCc => 'Koopia';

  @override
  String get conversationHeaderBcc => 'Pimekoopia';

  @override
  String get conversationHeaderReplyTo => 'Vastuse saaja';

  @override
  String get conversationHeaderDate => 'Kuupäev';

  @override
  String get conversationHeaderSecurity => 'Turvalisus';

  @override
  String get conversationVerifiedSender => 'Kinnitatud saatja';

  @override
  String get conversationUnverifiedSender => 'Kinnitamata saatja';

  @override
  String get conversationLoadingMessage => 'Kirja laadimine';

  @override
  String get conversationBodyError => 'Seda kirja ei õnnestunud laadida.';

  @override
  String get conversationBodyOffline => 'Võrguühendus puudub. Kiri laaditakse, kui oled taas võrgus.';

  @override
  String get conversationOriginalHint => 'Originaalvaates näeb parem välja';

  @override
  String get conversationShowOriginal => 'Näita originaali';

  @override
  String get conversationScrollToTop => 'Keri algusesse';

  @override
  String get conversationTagsMenu => 'Sildid…';

  @override
  String get conversationMuteThread => 'Vaigista lõim';

  @override
  String get conversationUnmuteThread => 'Tühista lõime vaigistus';

  @override
  String get conversationMoveMenu => 'Teisalda…';

  @override
  String get conversationDeletePermanently => 'Kustuta jäädavalt';

  @override
  String get conversationMoveToTrash => 'Teisalda prügikasti';

  @override
  String get conversationNotJunk => 'Pole rämpspost';

  @override
  String get conversationShowAllHeaders => 'Näita kõiki päiseid';

  @override
  String get conversationViewSource => 'Näita lähteteksti';

  @override
  String get conversationSaveAsFile => 'Salvesta failina…';

  @override
  String get conversationShareAsFile => 'Jaga failina…';

  @override
  String get conversationSearchFromMessageMenu => 'Otsi selle kirja põhjal…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopeeri aadress';

  @override
  String get conversationAddressCopied => 'Aadress on kopeeritud';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Otsi kirju saatjalt $name';
  }

  @override
  String get conversationTags => 'Sildid';

  @override
  String get conversationAllHeaders => 'Kõik päised';

  @override
  String get conversationCopyAll => 'Kopeeri kõik';

  @override
  String get conversationHeadersCopied => 'Päised on kopeeritud';

  @override
  String get conversationNoHeaders => 'Päiseid pole';

  @override
  String get conversationSearchFromMessageTitle => 'Otsi selle kirja põhjal';

  @override
  String conversationSearchFrom(String name) {
    return 'Saatja: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Saaja: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Teema: „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Lähtetekst';

  @override
  String get conversationSourceCopied => 'Lähtetekst on kopeeritud';

  @override
  String get conversationShareFailed => 'Kirja ei õnnestunud jagada.';

  @override
  String get conversationWrapLines => 'Murra read';

  @override
  String get conversationDontWrapLines => 'Ära murra ridu';

  @override
  String get conversationSourceError => 'Lähteteksti ei õnnestunud laadida.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Näidatakse esimesed $shown, kokku on $total. Kogu teksti saamiseks kopeeri või jaga see.';
  }

  @override
  String get conversationAttachmentUntitled => 'Nimetu';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Manuse $name muud toimingud';
  }

  @override
  String get conversationMoveTo => 'Teisalda kausta…';

  @override
  String get conversationMailboxesError => 'Postkaste ei õnnestunud laadida.';

  @override
  String get conversationReaderReadable => 'Loetav';

  @override
  String get conversationReaderOriginal => 'Originaal';

  @override
  String get conversationReaderPlain => 'Lihttekst';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Säilita originaalvärvid';

  @override
  String get conversationReaderRemember => 'Jäta selle saatja jaoks meelde';

  @override
  String get conversationSecurityPossiblePhishing => 'Võimalik õngitsus';

  @override
  String get conversationSecurityBeCareful => 'Ole ettevaatlik';

  @override
  String get conversationSecurityVerified => 'Kinnitatud';

  @override
  String get conversationSecurityNoIssues => 'Probleeme ei leitud';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count jälgijat', one: '$count jälgija');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Näitab põhjust';

  @override
  String get conversationPhishingBannerTitle => 'See kiri näeb välja nagu õngitsus';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Lingid ja pildid on välja lülitatud.';
  }

  @override
  String get conversationPhishingBannerText => 'Lingid ja pildid on välja lülitatud.';

  @override
  String get conversationPhishingWhy => 'Miks?';

  @override
  String get conversationPhishingShowAnyway => 'Näita siiski';

  @override
  String get conversationSecurityPhishingTitle => 'See näeb välja nagu õngitsus';

  @override
  String get conversationSecurityPhishingText =>
      'Mitu märki viitab sellele, et see kiri pole see, mis ta väidab end olevat.';

  @override
  String get conversationSecurityCarefulTitle => 'Ole selle kirjaga ettevaatlik';

  @override
  String get conversationSecurityCarefulText => 'Miski selles väärib teist pilku.';

  @override
  String get conversationSecurityVerifiedText => 'Saatja on kinnitatud ja midagi kahtlast ei paista.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Midagi kahtlast ei paista. Sinu e-posti server ei teatanud, kas saatja on kinnitatud.';

  @override
  String get conversationSecurityNothingSuspicious => 'Midagi kahtlast ei paista.';

  @override
  String get conversationSecurityWhy => 'Miks';

  @override
  String get conversationSecurityPrivacy => 'Privaatsus';

  @override
  String get conversationSecurityNoTrackingPixels => 'Jälgimispiksleid pole';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jälgimispikslit eemaldatud',
      one: '$count jälgimispiksel eemaldatud',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Need oleksid saatjale teada andnud, millal sa selle kirja avasid.';

  @override
  String get conversationSecurityNoRemoteImages => 'Väliseid pilte pole';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count välist pilti',
      one: '$count väline pilt',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Nende laadimine teatab saatjale, millal sa selle kirja loed, ja avaldab sinu IP-aadressi.';

  @override
  String get conversationSecurityNoClickTracking => 'Klikkide jälgimist pole';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linki läbi klikijälgijate',
      one: '$count link läbi klikijälgija',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services salvestaks sinu kliki. Sihtkoha otse avamiseks vajuta lingile pikalt.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tehnilised üksikasjad';

  @override
  String get conversationSecurityCheckedLocally => 'Kontrollitud selles seadmes. Midagi ei saadetud kuhugi.';

  @override
  String get conversationSecurityTrackersLabel => 'Jälgijad';

  @override
  String get conversationSecurityImagesFrom => 'Piltide allikad';

  @override
  String get conversationSecuritySenderHistory => 'Saatja ajalugu';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'saadud: $received, saadetud: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linkide sihtkohad';

  @override
  String get conversationSecurityHidden => 'Peidetud';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementi',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters märki',
      one: '$characters märk',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Saatja pole kinnitatud';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Sinu e-posti server ei suutnud kinnitada, et see kiri tuleb tõesti domeenilt $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Sinu e-posti server ei suutnud kinnitada, et see kiri tuleb tõesti näidatud saatjalt.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Sinu e-posti server ei suutnud kinnitada, et see kiri tuleb domeenilt $domain. Postiloendite puhul on see tavaline.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Sinu e-posti server ei suutnud kinnitada, et see kiri tuleb näidatud saatjalt. Postiloendite puhul on see tavaline.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ära tee kirja põhjal midagi, kui sa seda ei oodanud. Kahtluse korral võta saatjaga muul viisil ühendust.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Allkirjastanud teine domeen';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Kirja on allkirjastanud domeen $signer, mitte $domain. Masspostitusteenused teevad nii, kuid see ei tõesta, kes kirja kirjutas.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Kirja on allkirjastanud teine domeen, mitte $domain. Masspostitusteenused teevad nii, kuid see ei tõesta, kes kirja kirjutas.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Nimes on teine aadress';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Saatja nimi on „$shown“, kuid kiri tuleb aadressilt $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Usalda aadressi, mitte nime.';

  @override
  String get conversationSecurityReplyToTitle => 'Vastused lähevad mujale';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vastates läheks sinu vastus aadressile $address, mitte domeenile $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Kontrolli aadressi, enne kui saadad vastuses midagi isiklikku.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Kasutab sinu nime';

  @override
  String get conversationSecurityImpersonationTitle => 'Kasutab sulle tuttava inimese nime';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Kirja allkiri on „$name“, nagu sinu enda nimi, kuid kiri tuleb uuelt aadressilt: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Kirja allkiri on „$name“, nagu sinu VIP-kontakti $knownName ($knownEmail) nimi, kuid kiri tuleb uuelt aadressilt: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Kirja allkiri on „$name“, nagu sinu tuttava $knownName ($knownEmail) nimi, kuid kiri tuleb uuelt aadressilt: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Ja vastused läheksid hoopis kolmandale aadressile.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Kui kirjas küsitakse raha, koode või faile, küsi temalt enne muul viisil üle.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Tuntud aadress: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'See aadress: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Esimene kiri sellelt saatjalt';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Sa pole varem aadressilt $email kirju saanud.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Ole ettevaatlik palvetega inimestelt, keda sa veel ei tunne.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Saatja aadressis on sarnase välimusega tähti';

  @override
  String get conversationSecurityLinkHomographTitle => 'Lingis on sarnase välimusega tähti';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Aadress $host segab eri tähestike tähti, et jäljendada teist aadressi.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Aadress $host kasutab sarnase välimusega tähti: see ei ole $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Kustuta see või teata sellest kui rämpspostist.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ära ava seda.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domeen: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Sarnase välimusega domeen';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Domeenis on tuttav nimi';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Domeen $domain näeb välja nagu sinu enda domeen $real, kuid on tegelikult teine domeen.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Domeen $domain näeb välja nagu $brand ($real), kuid on tegelikult teine domeen.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Domeen $domain kasutab sinu enda domeeni $real nime, kuid ei kuulu sellele.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Domeen $domain kasutab nime $brand ($real), kuid ei kuulu sellele.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Sinu organisatsiooni päris kirjad tulevad domeenilt $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Päris kirjad saatjalt $brand tulevad domeenilt $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Saatja domeen: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Jäljendab: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linki peidab oma sihtkohta',
      one: 'Link peidab oma sihtkohta',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Link näitab aadressi $shown, kuid avab aadressi $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ära logi nende linkide kaudu sisse ega maksa. Kirjuta aadress hoopis ise.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Lingi sihtkohta ei saa kontrollida';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Link näitab aadressi $shown, kuid läheb läbi teenuse $host, mis salvestab kliki ja alles siis suunab edasi.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Link viitab paljale IP-aadressile';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts pole nimega veebisait. Päris ettevõtted lingivad nii harva.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Varjatud link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Link algab kujul „$shown@“, et näida nagu $shown, kuid avab aadressi $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Peidetud leht lülitati välja';

  @override
  String get conversationSecurityDataLinkText =>
      'Link oleks avanud kirja sisse pakitud lehe, mis on üks viis linkide kontrollist mööda pääseda.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Küsib parooli';

  @override
  String get conversationSecurityPasswordFieldText => 'Kirjas oli parooliväli. Loupe eemaldas selle.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Ära kunagi sisesta parooli e-kirja.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Koodi käivitav link lülitati välja';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe ei käivita kunagi kirjades olevat koodi.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lühendatud lingid',
      one: 'Lühendatud link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts: tegelik sihtkoht on peidetud, kuni lingi avad.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Rahvusvaheline veebiaadress';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts: mitteladina tähed. Paljudes keeltes on see tavaline; kontrolli, et tegu on oodatud saidiga.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Palju peidetud teksti';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eemaldati $count märki nähtamatut teksti. Sellise peidetud tekstiga püütakse rämpspostifiltreid petta.',
      one: 'Eemaldati $count märk nähtamatut teksti. Sellise peidetud tekstiga püütakse rämpspostifiltreid petta.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Peidetud tekst eemaldati';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eemaldati $count märki nähtamatut teksti.',
      one: 'Eemaldati $count märk nähtamatut teksti.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Kirja ei õnnestunud alla laadida. Kontrolli ühendust ja proovi uuesti.';

  @override
  String exportSaved(String name) {
    return 'Salvestatud: „$name“';
  }

  @override
  String get exportSaveFailed => 'Kirja ei õnnestunud salvestada.';

  @override
  String exportFailed(String folder) {
    return 'Kausta „$folder“ ei õnnestunud eksportida.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Kaustas „$folder“ pole eksporditavaid kirju.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Kausta „$folder“ ei õnnestunud eksportida: ühtegi kirja ei õnnestunud alla laadida. Kontrolli ühendust ja proovi uuesti.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Salvestatud: „$name“. $formattedCount kirja jäi välja, sest neid ei õnnestunud alla laadida.',
      one: 'Salvestatud: „$name“. $count kiri jäi välja, sest seda ei õnnestunud alla laadida.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Faili „$name“ ei õnnestunud salvestada.';
  }

  @override
  String exportTitle(String folder) {
    return 'Kausta „$folder“ eksportimine';
  }

  @override
  String get exportListing => 'Kirjade otsimine…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksportimine: $current/$total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount kirja ei õnnestunud alla laadida',
      one: '$count kirja ei õnnestunud alla laadida',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postkastid';

  @override
  String get mailboxesShown => 'Nähtav';

  @override
  String get mailboxesHidden => 'Peidetud';

  @override
  String get mailboxesCollapse => 'Ahenda';

  @override
  String get mailboxesExpand => 'Laienda';

  @override
  String get mailboxesManageVips => 'Halda VIP-kontakte';

  @override
  String get mailboxesSubscriptions => 'Tellimused';

  @override
  String mailboxesShowAccount(String account) {
    return 'Näita kontot $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Peida konto $account';
  }

  @override
  String get mailboxesExportFolder => 'Ekspordi kaust…';

  @override
  String get mailboxesUnpin => 'Eemalda kinnitus';

  @override
  String get mailboxesLists => 'Loendid';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxid';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Salvesta otsing, et seda siin hoida.';

  @override
  String get mailboxesTags => 'Sildid';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Saad ka puudutada kirjas saatja nime ja lülitada sisse valiku VIP.';

  @override
  String get mailboxesAddVip => 'Lisa VIP-kontakt…';

  @override
  String get mailboxesAddVipTitle => 'Lisa VIP-kontakt';

  @override
  String get mailboxesAddVipText => 'Sellelt aadressilt saabuvad kirjad saavad tärni ja ilmuvad VIP-postkasti.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Lugemata';

  @override
  String get messageListFilterFlagged => 'Märgistatud';

  @override
  String get messageListFilterToMe => 'Saaja: mina';

  @override
  String get messageListFilterCcMe => 'Koopia: mina';

  @override
  String get messageListFilterWithAttachments => 'Manustega';

  @override
  String get messageListFilterUnreplied => 'Vastamata';

  @override
  String get messageListFilterFromVips => 'VIP-kontaktidelt';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja märgiti loetuks',
      one: '$count kiri märgiti loetuks',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Vanemaid kirju ei õnnestunud laadida.';

  @override
  String get messageListSelectMessages => 'Vali kirjad';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count valitud', one: '$count valitud');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Vali kõik';

  @override
  String get messageListDeselectAll => 'Tühista kõigi valik';

  @override
  String get messageListLoadFailed => 'Kirju ei õnnestunud laadida';

  @override
  String get messageListNoUnread => 'Lugemata kirju pole';

  @override
  String get messageListNoMatches => 'Sobivaid kirju pole';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrid: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Lülita filter välja';

  @override
  String get messageListEmpty => 'Kirju pole';

  @override
  String get messageListFilter => 'Filtreeri';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtri tingimused: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrid:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount lugemata',
      one: '$formattedCount lugemata',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Märgi';

  @override
  String get messageListTrash => 'Prügikasti';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'NÄITA';

  @override
  String get panesHideMailboxes => 'Peida postkastid';

  @override
  String get panesShowMailboxes => 'Näita postkaste';

  @override
  String get panesMailboxesWidth => 'Postkastide veeru laius';

  @override
  String get panesListWidth => 'Kirjade loendi laius';

  @override
  String get panesNoMessageSelected => 'Kirja pole valitud';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kirja', one: '$count kiri');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Edasi lükatud';

  @override
  String get snoozeSheetTitle => 'Lükka edasi';

  @override
  String get snoozeLaterToday => 'Täna hiljem';

  @override
  String get snoozeThisEvening => 'Täna õhtul';

  @override
  String get snoozeTomorrow => 'Homme';

  @override
  String get snoozeThisWeekend => 'Sel nädalavahetusel';

  @override
  String get snoozeNextWeek => 'Järgmisel nädalal';

  @override
  String get snoozePickDateTime => 'Vali kuupäev ja kellaaeg…';

  @override
  String get snoozeMenu => 'Lükka edasi…';

  @override
  String get snoozeWakeNow => 'Too kohe tagasi';

  @override
  String get snoozeChangeTimeMenu => 'Muuda edasilükkamise aega…';

  @override
  String get snoozeChangeTime => 'Muuda aega';

  @override
  String get snoozeNoTime => 'Aeg määramata';

  @override
  String get snoozeFooter => 'Edasi lükatud kirjad naasevad oma ajal sisendkausta lugemata kirjadena.';

  @override
  String get snoozeEmptyTitle => 'Midagi pole edasi lükatud';

  @override
  String get snoozeEmptyText => 'Lükka kiri edasi ja see naaseb sisendkausta siis, kui seda vajad.';

  @override
  String get appLockUnlock => 'Ava lukk';

  @override
  String get appLockFailed => 'Loupe ei suutnud kinnitada, et see oled sina.';

  @override
  String get appLockLockedOut => 'Liiga palju katseid. Proovi hiljem uuesti.';

  @override
  String get appLockPromptError => 'Kinnitusakent ei õnnestunud kuvada. Proovi uuesti.';

  @override
  String get appLockNoScreenLock => 'Selles telefonis pole ekraanilukku.';

  @override
  String get appLockUnlockPromptTitle => 'Ava Loupe’i lukk';

  @override
  String get appLockUnlockPromptReason => 'Oma kirjade nägemiseks kinnita, et see oled sina.';

  @override
  String get appLockTurnOnPromptTitle => 'Lülita rakenduse lukk sisse';

  @override
  String get appLockTurnOnPromptReason => 'Rakenduse luku sisselülitamiseks kinnita, et see oled sina.';

  @override
  String get appLockScreenLockRemoved =>
      'Rakenduse lukk on välja lülitatud: selles telefonis pole enam ekraanilukku. Rakenduse luku uuesti sisselülitamiseks seadista ekraanilukk.';

  @override
  String get appLockAfterImmediately => 'Kohe';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutit', one: '$count minut');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tundi', one: '$count tund');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Krüpteeritud';

  @override
  String get openpgpEncryptedInPart => 'Osaliselt krüpteeritud';

  @override
  String get openpgpEncryptedLocked => 'Krüpteeritud · lukus';

  @override
  String get openpgpEncryptedNoKey => 'Krüpteeritud · võti puudub';

  @override
  String get openpgpEncryptedDamaged => 'Krüpteeritud · kahjustatud';

  @override
  String get openpgpEncryptedUnsupported => 'Krüpteeritud · toetamata';

  @override
  String get openpgpUnknownSigner => 'tundmatu';

  @override
  String get openpgpUnknownKey => 'Tundmatu võti';

  @override
  String get openpgpSignatureInvalid => 'Kehtetu allkiri';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Allkirjastanud $name, mitte saatja';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Osaliselt allkirjastanud $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Allkirjastanud $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Allkirjastatud tagasi lükatud võtmega';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Allkirjastanud $name · võti aktsepteerimata';
  }

  @override
  String get openpgpUnlock => 'Ava lukk';

  @override
  String get openpgpCantDecrypt => 'Seda kirja ei saa dekrüpteerida';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Krüpteeritud OpenPGP-ga';

  @override
  String get openpgpEncryption => 'Krüpteerimine';

  @override
  String get openpgpDecryptedHere => 'Dekrüpteeritud selles seadmes';

  @override
  String get openpgpNotDecrypted => 'Dekrüpteerimata';

  @override
  String get openpgpKeyLocked => 'Sinu võti on lukus.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Võtmete $keys jaoks',
      one: 'Võtme $keys jaoks',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Kaitstud teema';

  @override
  String get openpgpUnlockKey => 'Ava võtme lukk';

  @override
  String get openpgpSignature => 'Allkiri';

  @override
  String get openpgpFingerprint => 'Sõrmejälg';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Võtme ID $id';
  }

  @override
  String get openpgpSigned => 'Allkirjastatud';

  @override
  String get openpgpProblem => 'Probleem';

  @override
  String get openpgpAcceptance => 'Aktsepteerimine';

  @override
  String get openpgpChangeAcceptance => 'Muuda aktsepteerimist…';

  @override
  String get openpgpCheckedFooter => 'Kontrollitud selles seadmes OpenPGP-ga, mis ühildub Thunderbirdiga.';

  @override
  String get openpgpSummaryLocked => 'Sinu võti on lukus. Selle kirja lugemiseks ava võtme lukk paroolifraasiga.';

  @override
  String get openpgpSummaryNoSecretKey => 'See on krüpteeritud võtmele, mida selles seadmes pole.';

  @override
  String get openpgpSummaryDamaged => 'Krüpteeritud andmed on kahjustatud või neid muudeti teel.';

  @override
  String get openpgpSummaryUnsupported => 'See kasutab algoritmi, mida Loupe ei toeta.';

  @override
  String get openpgpSummaryEncrypted => 'Seda saad lugeda ainult sina ja teised adressaadid.';

  @override
  String get openpgpSummaryNotSigned => 'See pole allkirjastatud, seega pole saatja kinnitatud.';

  @override
  String get openpgpSummaryUnknownKey =>
      'See on allkirjastatud, kuid võtmega, mida sul pole, seega ei saa allkirja kontrollida.';

  @override
  String get openpgpSummaryBadSignature => 'Allkiri ei klapi: kirja võidi muuta.';

  @override
  String get openpgpSummaryMismatch => 'Allkiri kehtib, kuid võti kuulub teisele aadressile kui saatja oma.';

  @override
  String get openpgpSummaryPartial =>
      'Ainult osa kirjast on allkirjastatud. Väljaspool allkirja olev tekst (näiteks postiloendi jalus) on näidatud rea „Unsigned content“ all ning ka kirja muud osad, näiteks manused, pole allkirjaga kaetud.';

  @override
  String get openpgpSummaryOwnKey => 'Allkirjastatud sinu enda võtmega.';

  @override
  String get openpgpSummaryVerified => 'Allkiri kehtib ja sa oled võtme sõrmejälje kinnitanud.';

  @override
  String get openpgpSummaryUnverified => 'Allkiri kehtib. Sa aktsepteerisid võtme ilma selle sõrmejälge kontrollimata.';

  @override
  String get openpgpSummaryRejected => 'Allkiri kehtib, kuid sa oled selle võtme tagasi lükanud.';

  @override
  String get openpgpSummaryUndecided =>
      'Allkiri kehtib, kuid sa pole seda võtit veel aktsepteerinud. Võrdle selle sõrmejälge koos saatjaga.';

  @override
  String get openpgpAcceptanceRejected => 'Tagasi lükatud';

  @override
  String get openpgpAcceptanceUndecided => 'Aktsepteerimata';

  @override
  String get openpgpAcceptanceUnverified => 'Aktsepteeritud';

  @override
  String get openpgpAcceptanceVerified => 'Aktsepteeritud ja kinnitatud';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Kas aktsepteerida kontakti $name võti?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Sõrmejälg $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Jah, kontrollisin sõrmejälge';

  @override
  String get openpgpAcceptUnverified => 'Jah, ilma kontrollimata';

  @override
  String get openpgpAcceptLater => 'Mitte praegu';

  @override
  String get openpgpRejectKey => 'Lükka see võti tagasi';

  @override
  String get openpgpNoSubject => '(teema puudub)';

  @override
  String get openpgpEncryptionTitle => 'Otspunktkrüpteerimine';

  @override
  String get openpgpMyKeys => 'Minu OpenPGP võtmed';

  @override
  String get openpgpMyKeysFooter =>
      'Võtmega saad lugeda krüpteeritud kirju ning oma kirju allkirjastada ja krüpteerida. Kasutad Thunderbirdi? Ekspordi seal oma võti (Kontode sätted › Otspunktkrüptimine › Varunda salajane võti faili) ja impordi see siia.';

  @override
  String get openpgpAddKey => 'Lisa võti…';

  @override
  String get openpgpAddresses => 'Aadressid';

  @override
  String get openpgpAddressesFooter => 'Millist võtit iga aadress kasutab ning millal see krüpteerib ja allkirjastab.';

  @override
  String get openpgpCorrespondentsKeys => 'Kontaktide OpenPGP võtmed';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Aktsepteeri võti, kui usaldad, et see kuulub oma omanikule; võrdle temaga sõrmejälge, et märkida võti kinnitatuks.';

  @override
  String get openpgpImportPublicKey => 'Impordi avalik võti…';

  @override
  String get openpgpCollected => 'Kogutud Autocrypti kaudu';

  @override
  String get openpgpCollectedFooter =>
      'Kirjadega saabunud võtmed. Loupe saab neile krüpteerida, kui mõlemad pooled seda soovivad.';

  @override
  String get openpgpOnThisDevice => 'Selles seadmes';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Krüpteeritud kirjad peidavad oma teema. Loupe hoiab iga avatud kirja teemat selle seadme krüpteeritud andmebaasis, et loend, otsing ja teavitused saaksid seda näidata. Taustal saab Loupe dekrüpteerida ka uute kirjade teemad võtmetega, millel pole paroolifraasi; selleks laadib see iga kirja (kuni 1 MB) alla.';

  @override
  String get openpgpDecryptSubjects => 'Dekrüpteeri teemad taustal';

  @override
  String get openpgpIndexFooter =>
      'Otsing leiab krüpteeritud kirju saatja, adressaatide ja teema järgi. Kui see on sees, lisab Loupe iga dekrüpteeritud kirja teksti ka selle seadme krüpteeritud andmebaasis olevasse otsinguindeksisse, nii et otsing leiab kirja ka teksti järgi. Väljalülitamine eemaldab selle teksti indeksist.';

  @override
  String get openpgpIndexDecrypted => 'Indekseeri dekrüpteeritud kirjad otsingu jaoks';

  @override
  String get openpgpPassphrases => 'Paroolifraasid';

  @override
  String get openpgpPassphrasesFooter =>
      'Paroolifraasiga kaitstud OpenPGP võtmete ja S/MIME-sertifikaatide lukk avatakse vajaduse korral. Kui „Jäta paroolifraasid meelde“ on väljas, lukustatakse need kaks minutit pärast iga kasutust uuesti.';

  @override
  String get openpgpRememberPassphrases => 'Jäta paroolifraasid meelde';

  @override
  String get openpgpRememberPassphrasesDetail => 'Kuni Loupe suletakse';

  @override
  String get openpgpLockKeysNow => 'Lukusta võtmed kohe';

  @override
  String get openpgpKeysLocked => 'Võtmed on lukustatud.';

  @override
  String get openpgpKeyStateRevoked => 'tühistatud';

  @override
  String get openpgpKeyStateExpired => 'aegunud';

  @override
  String get openpgpKeyStateNeverExpires => 'ei aegu kunagi';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'aegub $date';
  }

  @override
  String get openpgpNoKey => 'Võti puudub';

  @override
  String get openpgpAlwaysEncrypt => 'Krüpteeri alati';

  @override
  String get openpgpAddKeyTitle => 'Lisa OpenPGP võti';

  @override
  String get openpgpAddKeyMessage => 'Impordi võti, mida kasutad Thunderbirdis, või loo uus.';

  @override
  String get openpgpImportFromClipboard => 'Impordi lõikelaualt';

  @override
  String get openpgpImportFromFile => 'Impordi failist';

  @override
  String get openpgpGenerateNewKey => 'Loo uus võti';

  @override
  String get openpgpImportPublicKeyTitle => 'Impordi avalik võti';

  @override
  String get openpgpFromClipboard => 'Lõikelaualt';

  @override
  String get openpgpFromFile => 'Failist';

  @override
  String get openpgpClipboardEmpty => 'Lõikelaud on tühi. Kopeeri esmalt võti.';

  @override
  String get openpgpKey => 'Võti';

  @override
  String get openpgpValidityRevoked => 'Tühistatud';

  @override
  String openpgpValidityExpired(String date) {
    return 'Aegus $date';
  }

  @override
  String get openpgpNeverExpires => 'Ei aegu kunagi';

  @override
  String openpgpValidUntil(String date) {
    return 'Kehtib kuni $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Sõrmejälg on kopeeritud.';

  @override
  String get openpgpAlgorithm => 'Algoritm';

  @override
  String get openpgpCreated => 'Loodud';

  @override
  String get openpgpValidity => 'Kehtivus';

  @override
  String get openpgpProtection => 'Kaitse';

  @override
  String get openpgpProtectionPassphrase => 'Paroolifraas';

  @override
  String get openpgpProtectionKeychain => 'Ainult võtmehoidla';

  @override
  String get openpgpKeyDetailsFooter =>
      'Jaga oma avalikku võtit, et teised saaksid sulle krüpteeritud kirju saata. Varukoopia on sinu salajane võti, mida kaitseb selle paroolifraas, kui see on olemas: hoia see enda teada.';

  @override
  String get openpgpSharePublicKey => 'Jaga avalikku võtit';

  @override
  String get openpgpCopyPublicKey => 'Kopeeri avalik võti';

  @override
  String get openpgpPublicKeyCopied => 'Avalik võti on kopeeritud.';

  @override
  String get openpgpBackUpSecretKey => 'Varunda salajane võti';

  @override
  String get openpgpDeleteKey => 'Kustuta võti';

  @override
  String get openpgpRemoveKey => 'Eemalda võti';

  @override
  String get openpgpBackUpTitle => 'Kas varundada salajane võti?';

  @override
  String get openpgpBackUpProtected =>
      'Varukoopiat kaitseb sinu võtme paroolifraas. Igaüks, kellel on mõlemad, saab sinu kirju lugeda.';

  @override
  String get openpgpBackUpUnprotected =>
      'Sellel võtmel pole paroolifraasi: igaüks, kellel on varukoopia, saab sinu kirju lugeda ja sinu nimel allkirjastada.';

  @override
  String get openpgpBackUp => 'Varunda';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Kas kustutada oma võti $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Kas eemaldada kontakti $name võti?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Sellele võtmele krüpteeritud kirju ei saa selles seadmes enam lugeda, kui sa võtit uuesti ei impordi.';

  @override
  String get openpgpRemoveKeyMessage => 'Saad selle hiljem uuesti importida.';

  @override
  String get openpgpKeyHeader => 'OpenPGP võti';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Selle aadressi kirjade krüpteerimiseks ja allkirjastamiseks lisa võti jaotises „Otspunktkrüpteerimine“.';

  @override
  String get openpgpGenerateAKey => 'Loo võti…';

  @override
  String get openpgpSending => 'Saatmine';

  @override
  String get openpgpSendingFooter =>
      'Automaatne krüpteerimine lülitub sisse, kui igal adressaadil on aktsepteeritud võti või usaldusväärne sertifikaat või kui Autocrypt ütleb, et mõlemad pooled seda soovivad. Krüpteeritud kirjad allkirjastatakse alati.';

  @override
  String get openpgpEncryptAutomatically => 'Krüpteeri automaatselt';

  @override
  String get openpgpAlwaysEncryptDetail => 'Keeldub saatmast, kui adressaadil pole võtit';

  @override
  String get openpgpSignUnencrypted => 'Allkirjasta krüpteerimata kirjad';

  @override
  String get openpgpAttachPublicKey => 'Lisa kirjale minu avalik võti';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt saadab sinu avaliku võtme iga kirjaga kaasa, nii et teised rakendused saavad sulle krüpteerida ilma seadistamiseta.';

  @override
  String get openpgpSendMyKey => 'Saada minu võti kirjadega kaasa';

  @override
  String get openpgpPreferEncryption => 'Eelista krüpteerimist';

  @override
  String get openpgpPreferEncryptionDetail => 'Palu teistel võimaluse korral krüpteerida';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count aastat', one: '$count aasta');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Paroolifraasid ei klapi.';

  @override
  String openpgpKeyReady(String id) {
    return 'Sinu võti $id on valmis.';
  }

  @override
  String get openpgpNewKey => 'Uus võti';

  @override
  String get openpgpNewKeyFor => 'Omanik';

  @override
  String get openpgpYourName => 'Sinu nimi';

  @override
  String get openpgpAddress => 'Aadress';

  @override
  String get openpgpPassphrase => 'Paroolifraas';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valikuline. Ilma selleta kaitseb võtit ainult sinu telefoni võtmehoidla ja Loupe ei küsi seda kunagi. Kui see on määratud, küsib Loupe seda siis, kui võtit on vaja.';

  @override
  String get openpgpRepeatPassphrase => 'Korda';

  @override
  String get openpgpExpires => 'Aegub';

  @override
  String get openpgpExpiresFooter => 'Enne aegumist saad luua uue võtme. Ka Thunderbird kasutab kolme aastat.';

  @override
  String get openpgpGenerateKey => 'Loo võti';

  @override
  String get openpgpKeyFor => 'Võti aadressile';

  @override
  String get openpgpCantEncrypt => 'Ei saa krüpteerida';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'OpenPGP võti puudub: $names. See aadress krüpteerib alati. Eemalda adressaat või impordi tema võti jaotises Seaded › Otspunktkrüpteerimine.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Kehtiv S/MIME-sertifikaat puudub: $names. See aadress krüpteerib alati. Eemalda adressaat või impordi tema sertifikaat jaotises Seaded › Otspunktkrüpteerimine.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'OpenPGP võti puudub: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Kehtiv S/MIME-sertifikaat puudub: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Saada krüpteerimata';

  @override
  String get openpgpCantSign => 'Ei saa allkirjastada';

  @override
  String get openpgpCantSignMessage =>
      'Sinu S/MIME-sertifikaadi privaatvõtit pole selles seadmes. Impordi sertifikaat uuesti (.p12- või .pfx-fail) jaotises Seaded › Otspunktkrüpteerimine.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Võti puudub: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sertifikaat puudub: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Võtmed Autocryptist';

  @override
  String get openpgpComposeEveryoneHasKey => 'Kõigil on võti';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Kõigil on sertifikaat';

  @override
  String get openpgpComposeEncrypt => 'Krüpteeri';

  @override
  String get openpgpComposeSign => 'Allkirjasta';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, vaheta';
  }

  @override
  String get openpgpNoKeyFound => 'OpenPGP võtit ei leitud.';

  @override
  String get openpgpImportSecretKeyTitle => 'Kas importida salajane võti?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'See manus sisaldab salajast võtit ($names). Impordi see oma võtmena ainult siis, kui eksportisid selle ise, näiteks Thunderbirdist.';
  }

  @override
  String get openpgpImportAsMyKey => 'Impordi minu võtmena';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'sinu võti $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kas importida $count võtit ($names)?',
      one: 'Kas importida kontakti $names võti?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Impordi ja aktsepteeri';

  @override
  String get openpgpImportDecideLater => 'Impordi, otsusta hiljem';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'kontakti $name võti';
  }

  @override
  String openpgpImported(String keys) {
    return 'Imporditud: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Manustes on $count OpenPGP võtit.',
      one: 'Manuses on OpenPGP võti.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Impordi';

  @override
  String get openpgpUnlockKeyTitle => 'Ava OpenPGP võtme lukk';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Sisesta võtme $name ($id) paroolifraas.';
  }

  @override
  String get openpgpWrongPassphrase => 'See paroolifraas on vale. Proovi uuesti.';

  @override
  String get openpgpExplainLocked => 'See kiri on krüpteeritud. Selle lugemiseks ava oma OpenPGP võtme lukk.';

  @override
  String get openpgpExplainNoKey =>
      'See kiri on krüpteeritud, kuid mitte ühelegi selles seadmes olevale OpenPGP võtmele. Kui loed seda Thunderbirdis, impordi sealt oma võti: Seaded › Otspunktkrüpteerimine.';

  @override
  String get openpgpExplainDamaged =>
      'See krüpteeritud kiri on kahjustatud, seega ei saa seda turvaliselt dekrüpteerida.';

  @override
  String get openpgpExplainUnsupported => 'See kiri kasutab krüpteerimist, mida Loupe veel lugeda ei oska.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'See kiri on krüpteeritud S/MIME-iga, kuid mitte ühelegi selles seadmes olevale sertifikaadile. Impordi oma sertifikaat (.p12- või .pfx-fail) jaotises Seaded › Otspunktkrüpteerimine.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'See kiri on krüpteeritud. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Selle lugemiseks ava oma S/MIME-sertifikaadi lukk.';

  @override
  String get openpgpAttachmentGone => 'See manus pole enam saadaval.';

  @override
  String get smimeEncrypted => 'Krüpteeritud (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Krüpteeritud (S/MIME) · sertifikaat puudub';

  @override
  String get smimeEncryptedDamaged => 'Krüpteeritud (S/MIME) · kahjustatud';

  @override
  String get smimeEncryptedUnsupported => 'Krüpteeritud (S/MIME) · toetamata';

  @override
  String get smimeEncryptedLocked => 'Krüpteeritud (S/MIME) · lukus';

  @override
  String get smimeUnknownSigner => 'tundmatu';

  @override
  String get smimeSignatureModified => 'Kehtetu allkiri: kirja on muudetud';

  @override
  String get smimeSignatureWeak => 'Ebaturvaline allkiri: aegunud algoritm';

  @override
  String get smimeSignatureUncheckable => 'Allkirja ei saa kontrollida';

  @override
  String get smimeSignedCertificateMissing => 'Allkirjastatud · sertifikaat puudub';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Allkirjastanud $name · sertifikaat tühistatud';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Allkirjastanud $name · teisel kuupäeval';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Allkirjastanud $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Allkirjastanud $name · kehtetu sertifikaat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Allkirjastanud $name · pole usaldatud';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Allkirjastanud $name · sertifikaat aegunud';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Allkirjastanud $name · sertifikaat pole veel kehtiv';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Allkirjastanud $name · sertifikaat pole e-posti jaoks';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Allkirjastanud $name, mitte saatja';
  }

  @override
  String get smimeCantDecrypt => 'Seda kirja ei saa dekrüpteerida';

  @override
  String get smimeEncryptedWithSmime => 'Krüpteeritud S/MIME-iga';

  @override
  String get smimeEncryption => 'Krüpteerimine';

  @override
  String get smimeDecryptedHere => 'Dekrüpteeritud selles seadmes';

  @override
  String get smimeNotDecrypted => 'Dekrüpteerimata';

  @override
  String get smimeAuthenticated => 'autenditud';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifikaadile',
      one: '$count sertifikaadile',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Allkiri';

  @override
  String get smimeIssuedBy => 'Väljaandja';

  @override
  String get smimeValid => 'Kehtib';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 sõrmejälg';

  @override
  String get smimeSigned => 'Allkirjastatud';

  @override
  String get smimeProblem => 'Probleem';

  @override
  String get smimeCheckingRevocation => 'Tühistamise kontrollimine…';

  @override
  String get smimeNotRevoked => 'Pole tühistatud';

  @override
  String get smimeRevoked => 'Tühistatud';

  @override
  String get smimeRevocationUnknown => 'Tühistamise olek teadmata';

  @override
  String smimeRevokedSince(String date) {
    return 'Alates $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Küsitud sertifitseerimisasutuselt (tühistusnimekiri), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Küsitud sertifitseerimisasutuselt (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Usalda väljaandjat „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Usalda seda sertifikaati…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Kontrollitud selles seadmes S/MIME-iga, mis ühildub Outlooki ja Thunderbirdiga; tühistamine on kontrollitud sertifitseerimisasutuse juures.';

  @override
  String get smimeCheckedFooter =>
      'Kontrollitud selles seadmes S/MIME-iga, mis ühildub Outlooki ja Thunderbirdiga. Tühistamist ei kontrollita (Seaded › Otspunktkrüpteerimine).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Kas usaldada väljaandjat $name e-posti jaoks?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Kas usaldada kontakti $name sertifikaati?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Usaldatakse iga sertifikaati, mille see asutus väljastab, nagu sinu ettevõtte sertifitseerimisasutuse puhul. Võrdle enne sõrmejälge selle omanikuga:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Võrdle enne sõrmejälge selle omanikuga:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Usalda';

  @override
  String get smimeSummaryNoKey => 'See on krüpteeritud sertifikaadile, mida selles seadmes pole.';

  @override
  String get smimeSummaryDamaged => 'Krüpteeritud andmed on kahjustatud või neid muudeti teel.';

  @override
  String get smimeSummaryUnsupported => 'See kasutab algoritmi, mida Loupe ei toeta.';

  @override
  String get smimeSummaryLocked => 'Sinu S/MIME-sertifikaat on lukus.';

  @override
  String get smimeSummaryEncrypted => 'Seda saad lugeda ainult sina ja teised adressaadid.';

  @override
  String get smimeSummaryNotSigned => 'See pole allkirjastatud, seega pole saatja kinnitatud.';

  @override
  String get smimeSummaryModified => 'Allkiri ei klapi: kirja on pärast allkirjastamist muudetud.';

  @override
  String get smimeSummaryUncheckable => 'Allkirja ei saa kontrollida.';

  @override
  String get smimeSummaryNoCertificate => 'Allkirjastaja sertifikaati pole kirjas, seega ei saa seda kontrollida.';

  @override
  String get smimeSummaryRevoked =>
      'Sertifitseerimisasutus on allkirjastaja sertifikaadi tühistanud: allkirja ei saa usaldada.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Sertifitseerimisasutus on allkirjastaja sertifikaadi tühistanud ($reason): allkirja ei saa usaldada.';
  }

  @override
  String get smimeDateMismatch =>
      'See on allkirjastatud rohkem kui tund aega kirja kuupäevast erineval ajal: see võib olla uuesti saadetud vana kiri.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Allkiri kehtib ja väljaandja $issuer kinnitab, et sertifikaat kuulub saatjale.';
  }

  @override
  String get smimeProblemInvalidChain => 'Sertifikaat või mõni selle väljaandja on kehtetu.';

  @override
  String get smimeProblemUntrusted => 'Sertifikaat on pärit asutuselt, mida Loupe ei usalda.';

  @override
  String get smimeProblemExpired => 'Sertifikaat oli aegunud.';

  @override
  String get smimeProblemNotYetValid => 'Sertifikaat ei olnud veel kehtiv.';

  @override
  String get smimeProblemWrongUsage => 'Sertifikaat pole mõeldud e-posti jaoks.';

  @override
  String get smimeProblemWrongAddress => 'Sertifikaat kuulub teisele aadressile kui saatja oma.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Usaldatud · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Pole usaldatud · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Aegus $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Kehtib alates $date';
  }

  @override
  String get smimeTrustInvalid => 'Kehtetu';

  @override
  String get smimeTrustNotForMail => 'Pole e-posti jaoks';

  @override
  String get smimeTrustAnotherAddress => 'Teine aadress';

  @override
  String get smimeMyCertificates => 'Minu S/MIME-sertifikaadid';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME jaoks, nagu seda kasutavad Outlook ja paljud ettevõtted. Impordi oma sertifikaat koos privaatvõtmega (.p12- või .pfx-fail), mis on eksporditud Outlookist, Windowsist, macOS-ist või Thunderbirdist.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME jaoks, nagu seda kasutavad Outlook ja paljud ettevõtted. Impordi oma sertifikaat koos privaatvõtmega (.p12- või .pfx-fail), mis on eksporditud Outlookist, Windowsist, macOS-ist või Thunderbirdist, või kasuta sertifikaati, mille sinu ettevõte või sa ise oled sellesse seadmesse paigaldanud.';

  @override
  String get smimeCertificateExpired => 'aegunud';

  @override
  String smimeCertificateUntil(String date) {
    return 'kuni $date';
  }

  @override
  String get smimeCertificateOnDevice => 'selles seadmes';

  @override
  String get smimeImportCertificateEllipsis => 'Impordi sertifikaat…';

  @override
  String get smimeUseDeviceCertificate => 'Kasuta selle seadme sertifikaati…';

  @override
  String get smimeCorrespondentsCertificates => 'Kontaktide sertifikaadid';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Kogutud allkirjastatud kirjadest, nagu teevad Outlook ja Thunderbird. Kirju krüpteeritakse ainult usaldatud sertifikaatidele: Loupe usaldab sertifitseerimisasutusi, mida Mozilla e-posti jaoks usaldab, ja neid, mille lisad ise.';

  @override
  String get smimeRevocation => 'Tühistamine';

  @override
  String get smimeRevocationFooter =>
      'Allkirjastatud kirja avamisel küsib Loupe allkirjastaja sertifikaadi väljastanud asutuselt, kas sertifikaat on tühistatud (selle OCSP-teenuselt või tühistusnimekirjast). Asutus näeb siis, millal keegi sinu IP-aadressilt loeb selle sertifikaadiga allkirjastatud kirja. Vastuseid hoitakse selles seadmes kuni nende aegumiseni. Tühistatud sertifikaat on kirja päises tähistatud kui „Tühistatud“.';

  @override
  String get smimeCheckRevocation => 'Kontrolli sertifikaatide tühistamist võrgus';

  @override
  String get smimeTrustedAuthorities => 'Usaldatud sertifitseerimisasutused';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sinu usaldatud, lisaks $count asutusele, mida Mozilla e-posti jaoks usaldab.',
      one: 'Sinu usaldatud, lisaks $count asutusele, mida Mozilla e-posti jaoks usaldab.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Sertifitseerimisasutus';

  @override
  String get smimeImportACertificate => 'Impordi sertifikaat';

  @override
  String get smimeImportContactMessage => 'Kontakti sertifikaat (.cer, .crt, .pem) või sertifitseerimisasutuse oma.';

  @override
  String get smimeFromClipboard => 'Lõikelaualt';

  @override
  String get smimeFromFile => 'Failist';

  @override
  String get smimeClipboardEmpty => 'Lõikelaud on tühi. Kopeeri esmalt sertifikaat.';

  @override
  String get smimeCertificate => 'Sertifikaat';

  @override
  String get smimeOnDeviceFooter =>
      'Selle privaatvõti jääb Androidi mandaatide hoidlasse, kuhu sinu ettevõte või sa ise selle paigaldasid: Loupe palub Androidil sellega allkirjastada ja dekrüpteerida. Allkirjastatud kirjad allkirjastatakse saatmise ajal.';

  @override
  String get smimeAddresses => 'Aadressid';

  @override
  String get smimeUsage => 'Kasutus';

  @override
  String get smimeUsageNone => 'Ei midagi Loupe’i jaoks';

  @override
  String get smimeUsageSigning => 'Allkirjastamine';

  @override
  String get smimeUsageEncryption => 'Krüpteerimine';

  @override
  String get smimeUsageCertificates => 'Sertifikaadid';

  @override
  String get smimeAlgorithm => 'Algoritm';

  @override
  String get smimeSerialNumber => 'Seerianumber';

  @override
  String get smimeFingerprintCopied => 'Sõrmejälg on kopeeritud.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 pöidlajälg';

  @override
  String get smimePrivateKey => 'Privaatvõti';

  @override
  String get smimeKeyOnDevice => 'Selles seadmes';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupe’is, paroolifraasiga';

  @override
  String get smimeKeyInLoupe => 'Loupe’is';

  @override
  String get smimeSource => 'Allikas';

  @override
  String get smimeSourceSignedMail => 'Allkirjastatud kiri';

  @override
  String get smimeSourceImported => 'Imporditud';

  @override
  String get smimeTrustHeader => 'Usaldus';

  @override
  String get smimeTrustedRoot => 'Usaldatud juursertifikaat';

  @override
  String get smimeIssuer => 'Väljaandja';

  @override
  String smimeTrustNamed(String name) {
    return 'Usalda väljaandjat „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Usalda seda asutust';

  @override
  String get smimeTrustThisCertificate => 'Usalda seda sertifikaati';

  @override
  String get smimeStopTrusting => 'Lõpeta usaldamine';

  @override
  String get smimePassphrase => 'Paroolifraas';

  @override
  String get smimePassphraseFooter =>
      'Valikuline. Paroolifraasiga krüpteeritakse privaatvõti ka selles seadmes (Argon2id ja AES-256) ning Loupe küsib seda allkirjastamiseks ja dekrüpteerimiseks; kui kauaks, määrab „Jäta paroolifraasid meelde“. Saadetavad kirjad allkirjastatakse saatmise ajal; taustatööd ei saa võtit kasutada.';

  @override
  String get smimeChangePassphrase => 'Muuda paroolifraasi…';

  @override
  String get smimeSetPassphraseEllipsis => 'Määra paroolifraas…';

  @override
  String get smimeRemovePassphrase => 'Eemalda paroolifraas';

  @override
  String get smimeShareCertificate => 'Jaga sertifikaati';

  @override
  String get smimeDeleteCertificate => 'Kustuta sertifikaat';

  @override
  String get smimeRemoveCertificate => 'Eemalda sertifikaat';

  @override
  String get smimePassphraseChanged => 'Paroolifraas on muudetud.';

  @override
  String get smimePassphraseSet => 'Paroolifraas on määratud.';

  @override
  String get smimeRemovePassphraseTitle => 'Kas eemaldada paroolifraas?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Siis kaitseb privaatvõtit ainult võtmehoidla, nagu ilma paroolifraasita: Loupe ei küsi seda enam ja taustatööd saavad seda kasutada.';

  @override
  String get smimePassphraseRemoved => 'Paroolifraas on eemaldatud.';

  @override
  String smimeTrustTitle(String name) {
    return 'Kas usaldada sertifikaati $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Kõiki selle väljastatud sertifikaate usaldatakse e-posti jaoks. Võrdle enne sõrmejälge selle omanikuga:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Kas kustutada oma sertifikaat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Kas eemaldada kontakti $name sertifikaat?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe lõpetab selle kasutamise: sellele krüpteeritud kirju ei saa Loupe’is enam lugeda. Sertifikaat jääb sellesse seadmesse (Seaded › Turvalisus › Krüpteerimine ja mandaadid).';

  @override
  String get smimeDeleteOwnMessage =>
      'Selle privaatvõti kustutatakse sellest seadmest: sellele krüpteeritud kirju ei saa siin enam lugeda, kui sa seda uuesti ei impordi.';

  @override
  String get smimeRemoveContactMessage => 'See tuleb tagasi tema järgmise allkirjastatud kirjaga.';

  @override
  String get smimeAddressImportFooter =>
      'Impordi sellele aadressile sertifikaat, et allkirjastada ja krüpteerida S/MIME-iga, nagu teeb Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Impordi sertifikaat…';

  @override
  String get smimePreferFooter =>
      'Kui kirja saaks kaitsta mõlemaga, kasutatakse eelistatut, välja arvatud juhul, kui ainult teisel on igale adressaadile võti või sertifikaat.';

  @override
  String get smimePreferSmime => 'Eelista S/MIME-i';

  @override
  String get smimePreferSmimeDetail => 'OpenPGP asemel';

  @override
  String get smimeCertificatePassword => 'Sertifikaadi parool';

  @override
  String get smimeCertificatePasswordPrompt => 'Sisesta parool, millega sertifikaadifail eksporditi.';

  @override
  String get smimeImport => 'Impordi';

  @override
  String get smimeWrongPassword => 'See parool on vale. Proovi uuesti.';

  @override
  String get smimeNoCertificateFound => 'Sertifikaati ei leitud.';

  @override
  String smimeCertificateOf(String name) {
    return 'kontakti $name sertifikaat';
  }

  @override
  String get smimeNothingNew => 'Pole midagi uut importida.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Imporditud: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imporditud $count usaldatud asutust.',
      one: 'Imporditud usaldatud asutus.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imporditud: $certificates ja $count usaldatud asutust.',
      one: 'Imporditud: $certificates ja usaldatud asutus.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Selles failis pole privaatvõtit. Ekspordi oma sertifikaat koos privaatvõtmega.';

  @override
  String get smimeImportAsYoursTitle => 'Kas importida sinu sertifikaadina?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'See manus sisaldab sertifikaati koos privaatvõtmega: $names. Impordi see ainult siis, kui eksportisid selle ise, näiteks Outlookist või Thunderbirdist.';
  }

  @override
  String get smimeImportAsMine => 'Impordi minu sertifikaadina';

  @override
  String smimeImportedOwn(String names) {
    return 'Sinu sertifikaat $names on imporditud.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Sinu sertifikaat $name ($addresses) on sellest seadmest lisatud.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Kas usaldada väljaandjat „$name“ e-posti jaoks?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ei tunne seda sertifitseerimisasutust (võib-olla on see mõne ettevõtte oma). Usalda seda, et kontrollida selle väljastatud sertifikaate. Võrdle enne selle sõrmejälge oma IT-osakonnaga:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Manustes on $count sertifikaati.',
      one: 'Manuses on sertifikaat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Impordi sertifikaat';

  @override
  String get smimeUnlockTitle => 'Ava S/MIME-sertifikaadi lukk';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Sisesta sertifikaadi $name ($addresses) paroolifraas.';
  }

  @override
  String get smimeWrongPassphrase => 'See paroolifraas on vale. Proovi uuesti.';

  @override
  String get smimeUnlock => 'Ava lukk';

  @override
  String get smimeEnterAPassphrase => 'Sisesta paroolifraas.';

  @override
  String get smimePassphrasesDiffer => 'Paroolifraasid erinevad.';

  @override
  String get smimeSetPassphraseTitle => 'Määra paroolifraas';

  @override
  String get smimeSetPassphraseText =>
      'Loupe küsib seda allkirjastamiseks ja dekrüpteerimiseks. Kui unustad selle, impordi sertifikaat uuesti selle .p12-failist.';

  @override
  String get smimePassphraseAgain => 'Uuesti';

  @override
  String get smimeSetPassphraseButton => 'Määra';

  @override
  String get smimeLockedOpenAgain => 'Sinu S/MIME-sertifikaat on lukus. Luku avamiseks ava kiri uuesti.';

  @override
  String get smimeDeviceHasNoCertificates => 'See seade ei paku oma sertifikaate.';

  @override
  String get smimeCantReadCertificate => 'Loupe ei suuda seda sertifikaati lugeda.';

  @override
  String get smimeCertificateNotForMail =>
      'See sertifikaat pole e-posti jaoks: sellel pole e-posti aadressi või see pole mõeldud allkirjastamiseks ega krüpteerimiseks.';

  @override
  String get smimeDeviceCertificateGone =>
      'Sertifikaati pole enam selles seadmes või Loupe ei tohi seda enam kasutada. Vali see uuesti jaotises Seaded › Otspunktkrüpteerimine.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Selle seadme sertifikaati saab kasutada ainult siis, kui Loupe on avatud.';

  @override
  String get smimeDeviceKeyDamaged => 'Krüpteeritud võti on kahjustatud.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Selle seadme sertifikaat ei saa seda teha: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'pole toetatud';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Selle seadme sertifikaat andis vea: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Asutuse aadress pole veebiaadress.';

  @override
  String get smimeAuthorityTimeout => 'Sertifitseerimisasutus ei vastanud õigel ajal.';

  @override
  String get smimeAuthorityUnreachable => 'Sertifitseerimisasutusega ei õnnestunud ühendust saada.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Sertifitseerimisasutus vastas koodiga $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Sertifitseerimisasutuse vastus on liiga suur.';

  @override
  String get smimeRevocationNotChecked =>
      'Pole kontrollitud: kontrollitakse ainult nende asutuste sertifikaate, mida Loupe usaldab.';

  @override
  String get settingsLanguage => 'Keel';

  @override
  String get settingsLanguageSystem => 'Sama mis telefonis';

  @override
  String get settingsLanguageFooter =>
      'Loupe kasutab sinu telefoni keelt, kui see on saadaval, ja muidu inglise keelt. Siin valitud keel kehtib ainult Loupe’is, ka teavitustes.';

  @override
  String get settingsAccountsHeader => 'Kontod';

  @override
  String get settingsAddAccount => 'Lisa konto';

  @override
  String get settingsMailHeader => 'E-post';

  @override
  String get settingsSwipeActions => 'Pühkimistoimingud';

  @override
  String get settingsSwipeLeft => 'Pühkimine vasakule';

  @override
  String get settingsSwipeLeftFooter =>
      'Täispikk pühkimine käivitab selle toimingu. „Märgista“ ja „Rohkem“ on alati ühe lühikese pühkimise kaugusel.';

  @override
  String get settingsSwipeRight => 'Pühkimine paremale';

  @override
  String get settingsSwipeRightFooter => 'Täispikk pühkimine käivitab selle toimingu.';

  @override
  String get settingsSwipeToggleRead => 'Märgi loetuks / lugemata';

  @override
  String get settingsSwipeTrash => 'Prügikasti';

  @override
  String get settingsSwipeMove => 'Teisalda kiri';

  @override
  String get settingsSwipeSnooze => 'Lükka edasi';

  @override
  String get settingsThreaded => 'Rühmita vestlusteks';

  @override
  String get settingsUndoSendDelay => 'Saatmise tühistamise aeg';

  @override
  String get settingsUndoSendDelayFooter => 'Saadetud kirjad ootavad nii kaua, et saaksid need tagasi võtta.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekundit',
      one: '$seconds sekund',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxid';

  @override
  String get settingsAppearanceHeader => 'Välimus';

  @override
  String get settingsTheme => 'Teema';

  @override
  String get settingsThemeSystem => 'Automaatne';

  @override
  String get settingsThemeLight => 'Hele';

  @override
  String get settingsThemeDark => 'Tume';

  @override
  String get settingsDensity => 'Kirjade loend';

  @override
  String get settingsDensityComfortable => 'Avar';

  @override
  String get settingsDensityCompact => 'Kompaktne';

  @override
  String get settingsReadingHeader => 'Lugemine';

  @override
  String get settingsReadingFooter => 'Välised pildid võivad saatjatele öelda, millal ja kus sa kirja avasid.';

  @override
  String get settingsDefaultView => 'Vaikevaade';

  @override
  String get settingsDefaultViewFooter => 'Iga kirja vaadet saad muuta nupuga Aa.';

  @override
  String get settingsViewReadable => 'Loetav';

  @override
  String get settingsViewReadableDetail => 'Puhas, selge, järgib tumedat režiimi';

  @override
  String get settingsViewOriginal => 'Originaal';

  @override
  String get settingsViewOriginalDetail => 'Täpselt nii, nagu saatja selle kujundas';

  @override
  String get settingsViewPlain => 'Lihttekst';

  @override
  String get settingsViewPlainDetail => 'Ainult sõnad';

  @override
  String get settingsPlainTextFont => 'Lihtteksti kirjatüüp';

  @override
  String get settingsFontSans => 'Seriifideta';

  @override
  String get settingsFontMono => 'Püsisammkiri';

  @override
  String get settingsFontMonoDetail => 'Hoiab ASCII-kunsti ja tabelid joondatuna';

  @override
  String get settingsTechnicalLists => 'Tehnilised postiloendid';

  @override
  String get settingsLoadRemoteImages => 'Laadi välised pildid';

  @override
  String get settingsOpenLinksDirectly => 'Ava lingid otse';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Jäta klikijälgijad vahele, kui sihtkoht on teada';

  @override
  String get settingsSecurityHeader => 'Turvalisus';

  @override
  String get settingsAppLock => 'Rakenduse lukk';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe küsib seda käivitumisel ning siis, kui oled olnud eemal kauem kui valikus „Lukusta pärast“ määratud aeg.';

  @override
  String get settingsAppLockFooterOff =>
      'Rakenduse lukk küsib enne kirjade näitamist sinu sõrmejälge, nägu või ekraanilukku.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Rakenduse lukk on endiselt väljas. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Seadista pääsukood';

  @override
  String get settingsScreenLockTextIos =>
      'Rakenduse lukk kasutab Face ID-d, Touch ID-d või sinu pääsukoodi, kuid selles iPhone’is pole pääsukoodi. Seadista see rakenduses Seaded ja lülita seejärel rakenduse lukk sisse.';

  @override
  String get settingsScreenLockTitleAndroid => 'Seadista ekraanilukk';

  @override
  String get settingsScreenLockTextAndroid =>
      'Rakenduse lukk kasutab sinu telefoni ekraanilukku või sellele lisatud sõrmejälge või nägu, kuid selles telefonis seda pole. Seadista Androidi seadetes PIN-kood, muster või parool ja lülita seejärel rakenduse lukk sisse.';

  @override
  String get settingsOpenSystemSettings => 'Ava seaded';

  @override
  String get settingsOpenAndroidSettings => 'Ava Androidi seaded';

  @override
  String get settingsLockAfter => 'Lukusta pärast';

  @override
  String get settingsLockAfterFooter => 'Kui kaua võib Loupe olla taustal, enne kui see uuesti küsib.';

  @override
  String get settingsNotifications => 'Teavitused';

  @override
  String get settingsEncryption => 'Otspunktkrüpteerimine';

  @override
  String get settingsAdvanced => 'Täpsemad seaded';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demopost on väljamõeldud postkast, mis on ainult selles telefonis. Midagi ei saadeta kuhugi.';

  @override
  String get settingsDemoMode => 'Demorežiim';

  @override
  String get settingsResetApp => 'Lähtesta rakendus';

  @override
  String get settingsResetFooter => 'Unustab kõik seaded ja naaseb tervituskuvale.';

  @override
  String get settingsResetTitle => 'Kas lähtestada Loupe?';

  @override
  String get settingsResetMessage =>
      'See unustab kõik seaded, Smart Mailboxid ja hiljutised otsingud ning naaseb tervituskuvale.';

  @override
  String get settingsAboutHeader => 'Teave';

  @override
  String get settingsVersion => 'Versioon';

  @override
  String get settingsLicences => 'Litsentsid';

  @override
  String get settingsPrivacy => 'Privaatsus';

  @override
  String get settingsPrivacyDetail =>
      'Loupe’il pole analüütikat ega jälgimist. Sinu kirjad liiguvad ainult sinu e-posti serveritesse.';

  @override
  String get settingsNotificationsOffIos => 'Loupe’i teavitused on seadetes välja lülitatud.';

  @override
  String get settingsNotificationsOffAndroid => 'Loupe’i teavitused on Androidi seadetes välja lülitatud.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system ei luba Loupe’il teavitusi näidata. Luba need seadetes.';
  }

  @override
  String get settingsNewMailHeader => 'Uued kirjad';

  @override
  String get settingsNewMailFooterDemo =>
      'Demopost ei saabu taustal. Saada testteavitus, et näha, kuidas uued kirjad välja näevad.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe kontrollib taustal uusi kirju siis, kui iOS seda lubab, ja harva avatavate rakenduste puhul võib vahe olla mitu tundi. Sulle antakse teada uutest kirjadest sinu sisendkaustades ja VIP-kontaktide kirjadest mis tahes kaustas.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe kontrollib uusi kirju umbes iga 15 minuti järel, kui Android seda lubab. Sulle antakse teada uutest kirjadest sinu sisendkaustades ja VIP-kontaktide kirjadest mis tahes kaustas.';

  @override
  String get settingsNoAccounts => 'Kontosid pole';

  @override
  String get settingsVipOnly => 'Ainult VIP';

  @override
  String get settingsVipOnlyDetail => 'Ainult sinu VIP-kontaktide kirjad';

  @override
  String get settingsHideContent => 'Peida sisu';

  @override
  String get settingsHideContentFooterOn =>
      'Teavitustes on ainult „Uus kiri kontol“ ja konto nimi, mitte see, kes kirjutas või millest.';

  @override
  String get settingsHideContentFooterOff =>
      '„Peida sisu“ hoiab saatja, teema ja eelvaate lukustuskuvalt ja teavitustest eemal.';

  @override
  String get settingsBackgroundAppRefresh => 'Taustal rakenduse värskendamine';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Uued kirjad saabuvad taustal ainult siis, kui Loupe’il on seadetes sisse lülitatud „Taustal rakenduse värskendamine“. iOS ei saa hoida ühendust sinu sisendkaustadega avatuna, seega pole valik „Kohene kättetoimetamine“ saadaval.';

  @override
  String get settingsInstantDelivery => 'Kohene kättetoimetamine';

  @override
  String get settingsInstantDeliveryFooter =>
      'Kohene kättetoimetamine (katseline) hoiab ühenduse sinu sisendkaustadega avatuna, nii et uued kirjad saabuvad sekunditega. See näitab vaikset teavitust „Uute kirjade jälgimine“ ja kasutab rohkem akut.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android võib aku säästmiseks kohese kättetoimetamise peatada. Selle töös hoidmiseks luba Loupe’il kasutada akut piiranguteta.';

  @override
  String get settingsExperimental => 'Katseline';

  @override
  String get settingsComingSoon => 'Tulekul';

  @override
  String get settingsAllowUnrestrictedBattery => 'Luba piiranguteta akukasutus';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push laseb uutel kirjadel Loupe’i kohe üles äratada, kui sinu e-posti teenus seda toetab. Push-sõnumid käivad läbi Google’i push-teenuse ega sisalda kirju, vaid ainult teadet „kontrolli kohe“.';

  @override
  String get settingsPushUnavailableFooter =>
      'See telefon ei saa push-sõnumeid vastu võtta: need vajavad Google Play teenuseid ja võrguühendust. Loupe kontrollib uusi kirju ikka umbes iga 15 minuti järel.';

  @override
  String get settingsCopyPushToken => 'Kopeeri push-luba';

  @override
  String get settingsPushTokenCopied => 'Push-luba on kopeeritud';

  @override
  String get settingsSendTestNotification => 'Saada testteavitus';

  @override
  String get settingsAppIconBadge => 'Rakenduse ikooni märk';

  @override
  String get settingsBadgeNote => 'Märk värskendub iga kord, kui Loupe kirju kontrollib, ka taustal.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Selle telefoni avakuva ei näita rakenduste ikoonidel numbreid. Märk värskendub iga kord, kui Loupe kirju kontrollib, ka taustal.';

  @override
  String get settingsTestNotificationBody => 'Uute kirjade teavitused näevad välja sellised.';

  @override
  String get settingsAccountRemoved => 'See konto on eemaldatud.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Kirjeldus';

  @override
  String get settingsAccountDescriptionHint => 'Töö, isiklik…';

  @override
  String get settingsEmail => 'E-post';

  @override
  String get settingsColour => 'Värv';

  @override
  String get settingsColourFooter => 'Märgistab selle konto kirjad vaates „Kõik sisendkaustad“.';

  @override
  String settingsColourNumber(int number) {
    return 'Värv $number';
  }

  @override
  String get settingsSendingHeader => 'Saatmine';

  @override
  String get settingsSendingFooter =>
      'Igal identiteedil on oma allkiri. Vastused saadetakse aadressilt, kuhu kiri saadeti.';

  @override
  String get settingsFoldersHeader => 'Kaustad';

  @override
  String get settingsFoldersFooter =>
      'Loupe näitab ja sünkroonib kaustu, mida tellid, nagu Thunderbird. Sisendkaust, Mustandid, Saadetud, Rämpspost, Prügikast ja Arhiiv on alati nähtavad.';

  @override
  String get settingsShowAllFolders => 'Näita kõiki kaustu';

  @override
  String get settingsIncoming => 'Sissetulev';

  @override
  String get settingsOutgoing => 'Väljuv';

  @override
  String get settingsConnectionNotEncrypted => 'Krüpteerimata';

  @override
  String get settingsSignIn => 'Sisselogimine';

  @override
  String get settingsSignInExpired => 'Aegunud';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider ei aktsepteeri enam selle konto jaoks Loupe’i sisselogimist, seega selle kirjad ei sünkroonu. Parandamiseks logi uuesti sisse.';
  }

  @override
  String get settingsSignInAgain => 'Logi uuesti sisse';

  @override
  String get settingsSigningIn => 'Sisselogimine…';

  @override
  String get settingsRemoveAccount => 'Eemalda konto';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Kas eemaldada „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Selle kirjad ja seaded eemaldatakse sellest telefonist. Serveris ei kustutata midagi.';

  @override
  String get settingsManageFolders => 'Halda kaustu';

  @override
  String get settingsNoFolders => 'Kaustu veel pole.';

  @override
  String get settingsManageFoldersFooter =>
      'Tellitud kaustad on nähtavad postkastide vaates ja sünkroonitakse taustal. Ka teised sama konto e-posti rakendused järgivad tavaliselt neid tellimusi.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Hoiab sinu Smart Mailboxe sinu teiste seadmete jaoks. Postkastide vaates peidetud.';

  @override
  String get settingsFolderAlwaysShown => 'Alati nähtav';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Telli kaust $folder';
  }

  @override
  String get settingsIdentities => 'Identiteedid';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Esimene identiteet on uute kirjade vaikeidentiteet. Järjestuse muutmiseks lohista.';

  @override
  String get settingsIdentitiesFooterSingle => 'Uute kirjade vaikeidentiteet.';

  @override
  String get settingsIdentitiesReplyFooter => 'Vastus saadetakse identiteedilt, kuhu kiri saadeti.';

  @override
  String get settingsIdentityDefault => 'Vaikimisi';

  @override
  String settingsIdentityReorder(String email) {
    return 'Muuda identiteedi $email järjekorda';
  }

  @override
  String get settingsAddIdentity => 'Lisa identiteet';

  @override
  String get settingsNewIdentity => 'Uus identiteet';

  @override
  String get settingsIdentity => 'Identiteet';

  @override
  String get settingsIdentityNameHint => 'Sinu nimi';

  @override
  String get settingsReplyTo => 'Vastuse saaja';

  @override
  String get settingsSignature => 'Allkiri';

  @override
  String get settingsSignatureFooter => 'Lisatakse selle identiteedi kirjades rea „-- “ alla.';

  @override
  String get settingsNoSignature => 'Allkiri puudub';

  @override
  String get settingsCopyToMyself => 'Koopia endale';

  @override
  String get settingsCopyToMyselfFooter => 'Lisatakse igale selle identiteedi kirjale.';

  @override
  String get settingsCc => 'Koopia';

  @override
  String get settingsBcc => 'Pimekoopia';

  @override
  String get settingsReplyPatterns => 'Kasuta vastustes aadressidele';

  @override
  String get settingsReplyPatternsFooter =>
      'Vastused kirjadele, mis saadeti nendele aadressidele, saadetakse sellelt identiteedilt. * tähendab mida tahes: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Aadress või muster, kus * tähendab mida tahes.';

  @override
  String get settingsAddReplyPattern => 'Lisa aadress või muster';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Eemalda $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Vigane muster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ pole aadress ega muster nagu *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Aadress puudub';

  @override
  String get settingsIdentityNoAddressMessage => 'Sisesta e-posti aadress, millelt saata.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Vigane aadress';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Vastuse saaja: „$address“ pole kehtiv e-posti aadress.',
      'cc': 'Koopia: „$address“ pole kehtiv e-posti aadress.',
      'bcc': 'Pimekoopia: „$address“ pole kehtiv e-posti aadress.',
      'other': '„$address“ pole kehtiv e-posti aadress.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Salvesta identiteet';

  @override
  String get settingsDiscardChanges => 'Loobu muudatustest';

  @override
  String get settingsDeleteIdentity => 'Kustuta identiteet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Kas kustutada „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Sellelt juba saadetud kirjad jäävad samaks.';

  @override
  String get settingsLastIdentityFooter => 'Kontol peab olema vähemalt üks identiteet.';

  @override
  String get rulesTitle => 'Reeglid';

  @override
  String get rulesNewRule => 'Uus reegel';

  @override
  String get rulesLoadError => 'Reegleid ei õnnestunud laadida.';

  @override
  String get rulesEmptyTitle => 'Reegleid pole';

  @override
  String get rulesEmptyText =>
      'Reeglid sorteerivad, sildistavad ja märgistavad uusi kirju sinu eest. Loo reegel ülal oleva kirjutamisnupuga või otsingust valikuga „Tee sellest reegel“.';

  @override
  String get rulesListFooter =>
      'Reeglid rakenduvad sisendkausta uutele kirjadele ülevalt alla. Reegli teisaldamiseks vajuta sellele pikalt.';

  @override
  String get rulesChangeError => 'Reeglit ei õnnestunud muuta';

  @override
  String get rulesConditionEveryMessage => 'Iga kiri';

  @override
  String rulesMoveRule(String rule) {
    return 'Teisalda reegel $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Reegel $rule on sees';
  }

  @override
  String get rulesServerRulesHeader => 'Serveri reeglid';

  @override
  String get rulesServerRulesFooter =>
      'Serveri reeglid töötavad e-posti serveris kirjade saabumisel, ka siis, kui see telefon on välja lülitatud. Neid hoitakse Sieve’i skriptis nimega „loupe“.';

  @override
  String get rulesStatusUnknown => 'Teadmata';

  @override
  String get rulesStatusError => 'Serverilt ei õnnestunud küsida.';

  @override
  String get rulesStatusChecking => 'Kontrollimine…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Käivitatakse skriptist „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktiivne skript on „$script“. Puuduta, et see käivitaks ka Loupe’i reeglid.';
  }

  @override
  String get rulesStatusNoScript =>
      'Serveris pole ühtegi aktiivset skripti. Serveri reegli salvestamine lülitab Loupe’i skripti sisse.';

  @override
  String get rulesStatusUnavailable => 'Pole saadaval';

  @override
  String get rulesStatusNoSieve => 'Selle konto server ei paku Sieve’i (ManageSieve või JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Teisalda kausta $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Teisalda kausta';

  @override
  String rulesActionTag(String tag) {
    return 'Lisa silt $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Eemalda silt $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Jäta sisendkausta';

  @override
  String rulesActionForward(String address) {
    return 'Edasta aadressile $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Edasta aadressile $address, ära jäta koopiat';
  }

  @override
  String get rulesActionStop => 'Lõpeta';

  @override
  String get rulesNoActions => 'Ei tee veel midagi';

  @override
  String get rulesLocationDevice => 'Seade';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'See seade';

  @override
  String get rulesNewRuleTitle => 'Uus reegel';

  @override
  String get rulesEditRuleTitle => 'Muuda reeglit';

  @override
  String get rulesDefaultNameEveryMessage => 'Iga kiri';

  @override
  String get rulesConditionHeader => 'Kui uus kiri vastab tingimusele';

  @override
  String get rulesConditionFooter =>
      'Kirjuta see nagu otsingus: from:, to:, s: (teema), b: (sisu), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:arve';

  @override
  String get rulesAccounts => 'Kontod';

  @override
  String get rulesAllAccounts => 'Kõik kontod';

  @override
  String get rulesRemovedAccount => 'Eemaldatud konto';

  @override
  String get rulesAccountsFooter => 'Kõigi kontode reegel kehtib ka kontodele, mille lisad hiljem.';

  @override
  String get rulesActionsHeader => 'Siis';

  @override
  String get rulesForwardingFooter =>
      'Edastamine saadab iga sobiva kirja selle saabumisel teisele aadressile, ka siis, kui see telefon on välja lülitatud. Mõni teenusepakkuja piirab edastatava posti hulka.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Edastamine töötab ainult serveri reeglites, seega on see siin välja jäetud.';

  @override
  String rulesRemoveAction(String action) {
    return 'Eemalda: $action';
  }

  @override
  String get rulesAddAction => 'Lisa toiming';

  @override
  String get rulesAddMove => 'Teisalda kausta…';

  @override
  String get rulesAddTagMenu => 'Lisa silt…';

  @override
  String get rulesRemoveTagMenu => 'Eemalda silt…';

  @override
  String get rulesAddForward => 'Edasta aadressile…';

  @override
  String get rulesStopProcessing => 'Lõpeta reeglite töötlemine';

  @override
  String get rulesRunOnHeader => 'Kus käivitada';

  @override
  String get rulesRunOnDeviceFooter =>
      'See seade rakendab reeglit sisendkausta uutele kirjadele iga kord, kui Loupe kirju kontrollib.';

  @override
  String get rulesRunOnServerFooter =>
      'E-posti server rakendab reeglit kirjade saabumisel, ka siis, kui see telefon on välja lülitatud. Vajab Sieve’i, kas ManageSieve’i (Dovecot, mailcow) või JMAP-i (Stalwart) kaudu.';

  @override
  String get rulesApplyToExisting => 'Rakenda olemasolevatele kirjadele…';

  @override
  String get rulesDeleteRule => 'Kustuta reegel';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Kas kustutada „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Millise konto kaust?';

  @override
  String get rulesMoveAccountMessage => 'Teiste kontode kirjad lähevad seal samanimelisse kausta.';

  @override
  String get rulesAddTag => 'Lisa silt';

  @override
  String get rulesRemoveTag => 'Eemalda silt';

  @override
  String get rulesForwardTo => 'Edasta aadressile';

  @override
  String get rulesForwardToMessage =>
      'Server saadab iga sobiva kirja sellele aadressile edasi, ka siis, kui see telefon on välja lülitatud. Kasuta aadressi, mis kuulub sulle või mida usaldad.';

  @override
  String get rulesNotAnAddressTitle => 'Pole e-posti aadress';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ pole aadress, kuhu edastada.';
  }

  @override
  String get rulesKeepCopyTitle => 'Kas jätta koopia siia?';

  @override
  String get rulesKeepCopy => 'Jäta koopia';

  @override
  String get rulesDontKeepCopy => 'Ära jäta koopiat';

  @override
  String get rulesCheckCondition => 'Kontrolli tingimust';

  @override
  String get rulesChooseActionTitle => 'Vali toiming';

  @override
  String get rulesChooseActionMessage => 'Lisa, mida reegel sobivate kirjadega teeb.';

  @override
  String get rulesSaveError => 'Reeglit ei õnnestunud salvestada';

  @override
  String get rulesSaveServerError => 'Serveri reeglit ei õnnestunud salvestada';

  @override
  String get rulesRunOnDeviceInstead => 'Käivita hoopis selles seadmes';

  @override
  String get rulesNothingToApplyTitle => 'Pole midagi rakendada';

  @override
  String get rulesNothingToApplyMessage => 'Anna reeglile esmalt toimiv tingimus ja toiming.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Millistele kirjadele rakendada „$rule“?';
  }

  @override
  String get rulesApplyScopeInboxes => 'Sisendkaustad';

  @override
  String get rulesApplyScopeAll => 'Kõik postkastid';

  @override
  String get rulesFindingMessages => 'Kirjade otsimine…';

  @override
  String get rulesSearchError => 'Otsing ebaõnnestus';

  @override
  String get rulesSearchErrorUnknown => 'Midagi läks valesti.';

  @override
  String get rulesNoMatchesTitle => 'Sobivaid kirju pole';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Seal pole midagi, mis vastaks tingimusele „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kas rakendada „$rule“ $countString kirjale?',
      one: 'Kas rakendada „$rule“ $countString kirjale?',
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
      other: 'Rakenda $countString kirjale',
      one: 'Rakenda $countString kirjale',
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
      other: '„$rule“ rakendati $countString kirjale',
      one: '„$rule“ rakendati $countString kirjale',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Serveri võimaluste kontrollimine…';

  @override
  String get rulesServerUnreachable => 'Serveriga ei õnnestunud ühendust saada.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ei saa serveris käivitada: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ei saa konto $account serveris käivitada: $problem';
  }

  @override
  String get rulesShowScript => 'Näita skripti';

  @override
  String get rulesHideScript => 'Peida skript';

  @override
  String get rulesMatchingHeader => 'Sobivad kirjad';

  @override
  String get rulesMatchingHeaderLoading => 'Sobivad kirjad…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString sobivat kirja',
      one: '$countString sobiv kiri',
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
      other: '$countString+ sobivat kirja',
      one: '$countString+ sobivat kirja',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Viimase 30 päeva kirjad. Reegel ise toimib ainult uutele kirjadele, kui sa seda olemasolevatele kirjadele ei rakenda.';

  @override
  String rulesConditionError(String error) {
    return 'Tingimuses on viga: $error';
  }

  @override
  String get rulesPreviewNoSender => '(saatja puudub)';

  @override
  String get rulesPreviewNoSubject => '(teema puudub)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ja veel $countString',
      one: 'ja veel $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Viimase 30 päeva jooksul pole midagi.';

  @override
  String get rulesIncludeTitle => 'Lülita serveri reeglid sisse';

  @override
  String get rulesIncludeLeaveOff => 'Ära lülita sisse';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Server juba käivitab konto $account jaoks Loupe’i reegleid.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ on konto $account serveris aktiivne skript, seega käivitab server selle ja mitte Loupe’i reegleid. Loupe ei asenda seda. See saab lisada skripti need read ja siis käivitab server Loupe’i reeglid pärast skripti enda reegleid:';
  }

  @override
  String get rulesShowWholeScript => 'Näita kogu skripti';

  @override
  String get rulesHideWholeScript => 'Peida kogu skript';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Muu skriptis „$script“ ei muutu. Kui selle filtreid hiljem veebipostis muudetakse, võib veebipost selle ilma nende ridadeta ümber kirjutada; siis näitab Loupe serveri reegleid jälle väljalülitatuna.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Lisa skripti „$script“';
  }

  @override
  String get subscriptionsTitle => 'Tellimused';

  @override
  String get subscriptionsNewsletters => 'Uudiskirjad';

  @override
  String get subscriptionsDiscussions => 'Arutelud';

  @override
  String get subscriptionsFilter => 'Filtreeri';

  @override
  String get subscriptionsFilterNeverRead => 'Pole kunagi loetud';

  @override
  String get subscriptionsFilterRarelyRead => 'Harva loetud';

  @override
  String get subscriptionsFilterAll => 'Kõik';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Tellimusi ei õnnestunud loendada';

  @override
  String get subscriptionsNoMatches => 'Vasteid pole';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Uudiskirja nimega „$text“ pole.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Loendit nimega „$text“ pole.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Uudiskirju pole';

  @override
  String get subscriptionsNoNewslettersDetail => 'Uudiskirjad ja muu masspost ilmuvad siia, kui need saabuvad.';

  @override
  String get subscriptionsNothingNeverRead => 'Kunagi lugemata uudiskirju pole';

  @override
  String get subscriptionsNothingRarelyRead => 'Harva loetud uudiskirju pole';

  @override
  String get subscriptionsNothingFilteredDetail => 'Loed vähemalt osa kõigest, mida saad.';

  @override
  String get subscriptionsNoDiscussions => 'Arutelusid pole';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Postiloendid, kuhu saad kirjutada, ilmuvad siia, kui nende kirjad saabuvad.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Loendid, kuhu kirjutavad mitu inimest. Vajuta loendile pikalt, et kinnitada see postkastide vaatesse, lugeda seda lihttekstina või teisaldada see uudiskirjade alla.';

  @override
  String get subscriptionsPrivacyNote =>
      'Loendatud selles telefonis allalaaditud kirjade põhjal; selleks ei saadeta midagi kuhugi. Loupe võtab saatjaga ühendust ainult siis, kui puudutad „Loobu tellimusest“: ühe klõpsuga loobumine saadab saatja antud aadressile ainult „List-Unsubscribe=One-Click“, ilma küpsiste ja muu sinu kohta käiva teabeta, ega laadi kunagi selle lehti ega pilte.';

  @override
  String get subscriptionsVolumeNone => 'Viimasel ajal pole';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / kuus';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / kuus';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'loetud $percent';
  }

  @override
  String get subscriptionsStillSending => 'Saadab endiselt';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Tellimusest loobutud $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Loobumisleht avatud $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Üks puudutus · võtab ühendust saidiga $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-kirjaga aadressile $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Veebisaidil $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Loobu tellimusest';

  @override
  String get subscriptionsUnsubscribeAgain => 'Loobu uuesti';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhiveeri sisendkaustast $countString kirja',
      one: 'Arhiveeri sisendkaustast $countString kiri',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Loo reegel…';

  @override
  String get subscriptionsCreateRuleDetail => 'Teisalda või arhiveeri selle tulevased kirjad';

  @override
  String get subscriptionsTreatAsDiscussion => 'Käsitle aruteluna';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Loend, kuhu inimesed kirjutavad: loe seda foorumi moodi';

  @override
  String get subscriptionsTreatAsNewsletter => 'Käsitle uudiskirjana';

  @override
  String get subscriptionsBlockSender => 'Blokeeri saatja';

  @override
  String get subscriptionsBlock => 'Blokeeri';

  @override
  String get subscriptionsBlocked => 'Blokeeritud';

  @override
  String get subscriptionsBlockedDetail => 'Uued kirjad lähevad rämpsposti';

  @override
  String get subscriptionsPin => 'Kinnita postkastide vaatesse';

  @override
  String get subscriptionsUnpin => 'Eemalda postkastide vaatest';

  @override
  String get subscriptionsOpenDefaultView => 'Ava vaikevaates';

  @override
  String get subscriptionsOpenPlainText => 'Ava lihttekstina (Mono)';

  @override
  String get subscriptionsPinned => 'Kinnitatud';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString lugemata',
      one: '$countString lugemata',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Sellelt saatjalt pole praegu kirju.';

  @override
  String get subscriptionsLatestMessages => 'VIIMASED KIRJAD';

  @override
  String get subscriptionsMail => 'Kirjad';

  @override
  String get subscriptionsNoneIn90Days => '90 päeva jooksul pole';

  @override
  String get subscriptionsRead => 'Loetud';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString/$totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Viimati saadud';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Kaustad', one: 'Kaust');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Saadab endiselt';

  @override
  String get subscriptionsUnsubscribedTitle => 'Tellimusest loobutud';

  @override
  String subscriptionsSince(String date) {
    return 'alates $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'leht avatud $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return 'Saatja $sender ei ütle, kuidas tellimusest loobuda.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return 'Saatja $sender ei ütle, kuidas tellimusest loobuda. Selle asemel saad saatja blokeerida.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Saatja $sender tellimusest loobumine…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Saatja $sender tellimusest on loobutud.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Tellimusest ei õnnestunud loobuda: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automaatselt ei õnnestunud loobuda';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Saada loobumiskiri';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Ava $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Kas avada $site?';
  }

  @override
  String get subscriptionsOpen => 'Ava';

  @override
  String subscriptionsWebExplanation(String sender) {
    return 'Saatja $sender tellimusest loobutakse tema veebisaidil. Leht avaneb Loupe’i brauseris; vii loobumine seal lõpuni.';
  }

  @override
  String get subscriptionsWebInsecure => 'Ühendus selle saidiga pole krüpteeritud.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Ettevaatust: see aadress jäljendab sarnase välimusega tähtedega saiti $site.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Ettevaatust: see aadress jäljendab sarnase välimusega tähtedega teist saiti.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Saiti $site ei õnnestunud avada.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe märgib tänase kuupäeva üles ja annab sulle teada, kui saatja $sender kirjutamist jätkab.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Kas loobuda saatja $sender tellimusest?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Tellimusest loobumiseks võtab Loupe ühendust saidiga $site.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'See on ainus kord, kui Loupe võtab saatja veebisaidiga ühendust. See saadab ainult „List-Unsubscribe=One-Click“ aadressile, mille saatja $sender andis, ilma küpsiste ja muu sinu kohta käiva teabeta, ega laadi lehte.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Loobumislink pole turvaline aadress internetis.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Sait $site ei vastanud õigel ajal.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Saidiga $site ei õnnestunud ühendust saada.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Sait $site suunas päringu teisele lehele, mida Loupe ei järgi.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Sait $site keeldus päringust (viga $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Pole kontot, millelt loobumiskirja saata.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe saadab aadressilt $from aadressile $to kirja teemaga „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Loobumiskiri on saadetud aadressile $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Kas blokeerida $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Selle loendi uued kirjad lähevad rämpsposti. Saad seda muuta jaotises Seaded › Reeglid.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Uued kirjad aadressilt $address lähevad rämpsposti. Saad seda muuta jaotises Seaded › Reeglid.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Saatja $sender on blokeeritud.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Teisalda $count rämpsposti',
      one: 'Teisalda $count rämpsposti',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokeeri $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender on nüüd uudiskirjade all.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender on nüüd arutelude all.';
  }

  @override
  String get appLiveGateTitle => 'Sinu kontosid ei õnnestunud avada';

  @override
  String get appLiveGateUnavailableBuild => 'Päris kontod pole selles versioonis veel saadaval.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe ei suutnud lugeda võtit, mis kaitseb sinu kirju selles telefonis. See on sageli ajutine: proovi uuesti või taaskäivita telefon.';

  @override
  String get appLiveGateKeyMissing =>
      'Võti, mis kaitseb sinu kirju selles telefonis, on kadunud, mis võib juhtuda pärast varukoopia taastamist. Sinu kirjad on endiselt serveris.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Selle telefoni e-posti andmebaasi ei saa lugeda: see on kahjustatud või selle võti on muutunud. Sinu kirjad on endiselt serveris.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Sinu kontode avamisel läks midagi valesti ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'See kustutab sinu kontod ja selles telefonis talletatud kirjad, sealhulgas väljuvate kirjade kaustas ootavad kirjad. Sinu serverites olevaid kirju see ei mõjuta; lisa oma kontod pärast uuesti.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Kustuta ja alusta otsast';

  @override
  String get appLiveGateUseDemo => 'Kasuta demoposti';

  @override
  String get appLiveGateReset => 'Lähtesta selle telefoni post…';

  @override
  String get attachmentsUntitled => 'Manus';

  @override
  String get attachmentsUntitledFile => 'Nimetu';

  @override
  String get attachmentsOpenIn => 'Ava rakenduses…';

  @override
  String get attachmentsSaveToFiles => 'Salvesta failidesse';

  @override
  String get attachmentsShareMenu => 'Jaga…';

  @override
  String get attachmentsDownloadError => 'Manust ei õnnestunud alla laadida. Kontrolli ühendust ja proovi uuesti.';

  @override
  String get attachmentsShareError => 'Manust ei õnnestunud jagada.';

  @override
  String attachmentsNoApp(String type) {
    return 'Selles seadmes pole rakendust, mis avaks selle faili ($type). Proovi selle asemel „Jaga“.';
  }

  @override
  String get attachmentsOpenInError => 'Manust ei õnnestunud teises rakenduses avada.';

  @override
  String attachmentsSaved(String name) {
    return 'Salvestatud: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Manust ei õnnestunud salvestada.';

  @override
  String get attachmentsGone => 'See manus pole enam saadaval.';

  @override
  String get attachmentsDownloadFailed => 'Manust ei õnnestunud alla laadida.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count lehekülge', one: '$count lehekülg');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size mobiilse andmeside kaudu';
  }

  @override
  String get attachmentsLargeDownload => 'See manus on suur. Laadi see alla kohe või hiljem WiFi kaudu.';

  @override
  String get attachmentsDownload => 'Laadi alla';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Allalaadimine: $size…';
  }

  @override
  String get attachmentsDownloading => 'Allalaadimine…';

  @override
  String get attachmentsTooLarge => 'Liiga suur, et siin eelvaadet näidata.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Näidatakse esimesed $shown, kokku on $total. Kogu sisu saamiseks kopeeri, jaga või salvesta see.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Seda PDF-i ei saa siin näidata (see võib olla parooliga kaitstud).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page/$count';
  }

  @override
  String get attachmentsModeTable => 'Tabel';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Kiri';

  @override
  String get attachmentsModeSource => 'Lähtetekst';

  @override
  String get attachmentsDontWrap => 'Ära murra ridu';

  @override
  String get attachmentsWrap => 'Murra read';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines rida', one: '$lines rida');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopeeri kõik';

  @override
  String get attachmentsCopied => 'Kopeeritud';

  @override
  String get attachmentsImageUnavailable => 'Seda pilti ei saa siin näidata. Proovi „Ava rakenduses…“.';

  @override
  String get attachmentsEmlNoSubject => '(teema puudub)';

  @override
  String get attachmentsEmlFrom => 'Saatja';

  @override
  String get attachmentsEmlTo => 'Saaja';

  @override
  String get attachmentsEmlCc => 'Koopia';

  @override
  String get attachmentsEmlDate => 'Kuupäev';

  @override
  String get attachmentsEmlNoText => 'Selles kirjas pole teksti.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Manused: $names', one: 'Manus: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Korraldaja: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ja veel $count sündmust',
      one: 'Ja veel $count sündmus',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Pilt';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-pilt';
  }

  @override
  String get attachmentsTypePdf => 'PDF-dokument';

  @override
  String get attachmentsTypeTsv => 'Tabeldusmärgiga eraldatud väärtused';

  @override
  String get attachmentsTypeCsv => 'CSV-tabel';

  @override
  String get attachmentsTypeCalendar => 'Kalendrisündmus';

  @override
  String get attachmentsTypeEmail => 'E-kiri';

  @override
  String get attachmentsTypeContact => 'Kontaktkaart';

  @override
  String get attachmentsTypeLog => 'Logifail';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'ZIP-arhiiv';

  @override
  String get attachmentsTypeArchive => 'Arhiiv';

  @override
  String get attachmentsTypeWord => 'Wordi dokument';

  @override
  String get attachmentsTypeExcel => 'Exceli tabel';

  @override
  String get attachmentsTypePowerPoint => 'PowerPointi esitlus';

  @override
  String get attachmentsTypeWebPage => 'Veebileht';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Heli';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-fail';
  }

  @override
  String get attachmentsTypeFile => 'Fail';

  @override
  String get calendarUntitledEvent => 'Sündmus';

  @override
  String get calendarAllDay => 'Terve päev';

  @override
  String calendarYourTime(String time) {
    return '$time sinu aja järgi';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Liitu: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name nõustus: $details',
      'tentative': '$name nõustus esialgselt: $details',
      'declined': '$name keeldus: $details',
      'delegated': '$name delegeeris: $details',
      'other': '$name pole vastanud: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name nõustus kutsega',
      'tentative': '$name nõustus kutsega esialgselt',
      'declined': '$name keeldus kutsest',
      'delegated': '$name delegeeris kutse',
      'other': '$name pole kutsele vastanud',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kaart';

  @override
  String get calendarJoin => 'Liitu';

  @override
  String get calendarOnlineMeeting => 'Veebikoosolek';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Koosolek ($provider)';
  }

  @override
  String get calendarOrganizerYou => 'Sina';

  @override
  String get calendarOrganizerLabel => 'korraldaja';

  @override
  String get calendarStatusAccepted => 'Nõustunud';

  @override
  String get calendarStatusMaybe => 'Võib-olla';

  @override
  String get calendarStatusDeclined => 'Keeldunud';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name nõustus',
      'tentative': '$name nõustus esialgselt',
      'declined': '$name keeldus',
      'delegated': '$name delegeeris',
      'other': '$name pole vastanud',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name nõustus:',
      'tentative': '$name nõustus esialgselt:',
      'declined': '$name keeldus:',
      'delegated': '$name delegeeris:',
      'other': '$name pole vastanud:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name pakub uut aega';
  }

  @override
  String get calendarCounterUnknown => 'Osaleja pakub uut aega';

  @override
  String get calendarDeclineCounter => 'Korraldaja jättis aja samaks';

  @override
  String calendarRefresh(String name) {
    return '$name küsib uusimat versiooni';
  }

  @override
  String get calendarRefreshUnknown => 'Osaleja küsib uusimat versiooni';

  @override
  String get calendarCancelled => 'Tühistatud';

  @override
  String get calendarCancelledByOrganizer => 'Korraldaja tühistas selle sündmuse.';

  @override
  String get calendarCancelledLater => 'See sündmus tühistati hiljem.';

  @override
  String get calendarOutdated => 'Aegunud';

  @override
  String get calendarOutdatedDetail => 'Seda kutset on hiljem uuendatud; kehtib uuem.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Asukoht eemaldatud (oli $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Asukoht eemaldatud (polnud määratud)';

  @override
  String calendarLocationChanged(String location) {
    return 'Uus asukoht: $location';
  }

  @override
  String get calendarNewTitle => 'Uus pealkiri';

  @override
  String get calendarRepeatChanged => 'Kordus muutus';

  @override
  String get calendarUpdated => 'Uuendatud';

  @override
  String get calendarUpdatedInvitation => 'Uuendatud kutse';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Uus aeg: $after (oli $before)';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Ajavöönd „$zone“ on tundmatu: ajad on näidatud nii, nagu kirjutatud';
  }

  @override
  String calendarNext(String when) {
    return 'Järgmine: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count külalist', one: '$count külaline');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count nõustus', one: '$count nõustus');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count võib-olla',
      one: '$count võib-olla',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count keeldus', one: '$count keeldus');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (sina)';
  }

  @override
  String get calendarAttendeeOptional => 'valikuline';

  @override
  String get calendarAttendeeRoom => 'ruum';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Nõustusid varasema versiooniga.',
      'tentative': 'Nõustusid esialgselt varasema versiooniga.',
      'declined': 'Keeldusid varasemast versioonist.',
      'delegated': 'Delegeerisid varasema versiooni.',
      'other': 'Sa pole varasemale versioonile vastanud.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Nõustu';

  @override
  String get calendarMaybe => 'Võib-olla';

  @override
  String get calendarDecline => 'Keeldu';

  @override
  String get calendarCommentHint => 'Kommentaar korraldajale (valikuline)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Sinu vastus saadetakse korraldajale $organizer aadressilt $address.';
  }

  @override
  String get calendarAddComment => 'Lisa kommentaar';

  @override
  String get calendarAddToCalendar => 'Lisa kalendrisse';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ja failis on veel $count sündmust',
      one: 'Ja failis on veel $count sündmus',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Pole kalendrirakendust, kuhu sündmust lisada.';

  @override
  String get calendarCantOpenCalendar => 'Kalendrit ei õnnestunud avada.';

  @override
  String get calendarCantOpenLink => 'Linki ei õnnestunud avada.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Kas liituda koosolekuga ($provider)?';
  }

  @override
  String get calendarJoinTitle => 'Kas liituda koosolekuga?';

  @override
  String calendarJoinOpens(String host) {
    return 'Avab brauseris aadressi $host.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Ettevaatust: see aadress jäljendab sarnase välimusega tähtedega saiti $site.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Ettevaatust: see aadress jäljendab sarnase välimusega tähtedega teist saiti.';

  @override
  String calendarJoinOpen(String host) {
    return 'Ava $host';
  }

  @override
  String get calendarNoOrganizer => 'Sellel kutsel pole korraldajat, kellele vastata.';

  @override
  String get calendarNoAccount => 'Pole kontot, millelt vastata.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Nõustunud',
      'tentative': 'Võib-olla',
      'other': 'Keeldunud',
    });
    return '$_temp0 · vastuse saatmine korraldajale $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Nõustunud',
      'tentative': 'Võib-olla',
      'other': 'Keeldunud',
    });
    return '$_temp0 · vastus saadetud';
  }

  @override
  String get calendarReplyAlreadySent => 'Vastus on juba saadetud.';

  @override
  String get calendarReplyNotSent => 'Vastust ei saadetud.';

  @override
  String get dataSmimeNeedsDevice =>
      'Sinu S/MIME-sertifikaat on selles seadmes: selle kirja allkirjastamiseks ja saatmiseks ava Loupe.';

  @override
  String dataSigningFailed(String error) {
    return 'Allkirjastamine ebaõnnestus: $error';
  }

  @override
  String get keyboardShortcuts => 'Kiirklahvid';

  @override
  String get keyboardGroupGeneral => 'Üldine';

  @override
  String get keyboardGroupMessages => 'Kirjad';

  @override
  String get keyboardGroupCompose => 'Kirjutamine';

  @override
  String get keyboardCommandPalette => 'Käsupalett';

  @override
  String get keyboardBackClose => 'Tagasi, sulge';

  @override
  String get keyboardNextMessage => 'Järgmine kiri';

  @override
  String get keyboardPreviousMessage => 'Eelmine kiri';

  @override
  String get keyboardOpenMessage => 'Ava kiri';

  @override
  String get keyboardMoveToTrash => 'Teisalda prügikasti';

  @override
  String get keyboardToggleRead => 'Märgi loetuks või lugemata';

  @override
  String get keyboardToggleFlag => 'Märgista või eemalda märgistus';

  @override
  String get keyboardCloseDraft => 'Sulge (salvesta või kustuta mustand)';

  @override
  String get keyboardOr => 'või';

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
  String get mailingListsMuted => 'Lõim on vaigistatud. Selle uued kirjad saabuvad loetuna.';

  @override
  String get mailingListsUnmuted => 'Lõim pole enam vaigistatud.';

  @override
  String get mailingListsMuteThread => 'Vaigista lõim';

  @override
  String get mailingListsUnmuteThread => 'Tühista lõime vaigistus';

  @override
  String get mailingListsPin => 'Kinnita postkastide vaatesse';

  @override
  String get mailingListsUnpin => 'Eemalda postkastide vaatest';

  @override
  String get mailingListsDefaultView => 'Ava vaikevaates';

  @override
  String get mailingListsPlainText => 'Ava lihttekstina (Mono)';

  @override
  String get mailingListsShowMuted => 'Näita vaigistatud lõimi';

  @override
  String get mailingListsHideMuted => 'Peida vaigistatud lõimed';

  @override
  String get mailingListsTreatAsNewsletter => 'Käsitle uudiskirjana';

  @override
  String get mailingListsOptions => 'Loendi valikud';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted lugemata',
      one: '$formatted lugemata',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Uus kiri loendisse';

  @override
  String get mailingListsRowUnread => 'Lugemata';

  @override
  String get mailingListsRowMuted => 'Vaigistatud';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vastust', one: '$count vastus');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Lõimi pole';

  @override
  String get mailingListsMutedHidden => 'Vaigistatud lõimed on peidetud.';

  @override
  String get mailingListsTechnicalTitle => 'Tehnilised postiloendid';

  @override
  String get mailingListsTechnicalEmpty => 'Postiloendid ilmuvad siia, kui nende kirjad saabuvad.';

  @override
  String get mailingListsTechnicalFooter =>
      'Nende loendite kirjad avanevad lihttekstina püsisammkirjas ning paigad kuvatakse diffidena. Nupuga Aa saab endiselt iga kirja vaadet muuta.';

  @override
  String get paletteMoveToMailbox => 'Teisalda postkasti…';

  @override
  String get paletteMarkAllRead => 'Märgi kõik loetuks';

  @override
  String get paletteExportFolder => 'Ekspordi kaust…';

  @override
  String get paletteGetNewMail => 'Too uued kirjad';

  @override
  String get paletteSnoozed => 'Edasi lükatud';

  @override
  String get paletteSubscriptions => 'Tellimused';

  @override
  String get paletteDiscussions => 'Arutelud';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Postiloend';

  @override
  String get paletteTag => 'Silt';

  @override
  String get paletteSwipeActions => 'Pühkimistoimingud';

  @override
  String get paletteNotifications => 'Teavitused';

  @override
  String get paletteRules => 'Reeglid';

  @override
  String get paletteEncryption => 'Otspunktkrüpteerimine';

  @override
  String get paletteAdvanced => 'Täpsemad seaded';

  @override
  String get paletteAddAccount => 'Lisa konto';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Kaustad';

  @override
  String get paletteRecentSearch => 'Hiljutine otsing';

  @override
  String paletteSearchMail(String query) {
    return 'Otsi kirjadest „$query“';
  }

  @override
  String get palettePlaceholder => 'Otsi toiminguid, postkaste, seadeid';

  @override
  String get paletteNothingFound => 'Midagi ei leitud';

  @override
  String get searchNewSmartMailbox => 'Uus Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Näitab kõike, mis vastab päringule „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ salvestati postkastide vaatesse';
  }

  @override
  String get searchMakeRule => 'Tee sellest reegel';

  @override
  String get searchSaveSmartMailbox => 'Salvesta Smart Mailboxina';

  @override
  String get searchNegate => 'Eita';

  @override
  String get searchDontNegate => 'Ära eita';

  @override
  String get searchAllMailboxes => 'Kõik postkastid';

  @override
  String get searchRecent => 'Hiljutised otsingud';

  @override
  String get searchClear => 'Tühjenda';

  @override
  String get searchSuggestions => 'Soovitused';

  @override
  String get searchUnreadMessages => 'Lugemata kirjad';

  @override
  String get searchFlaggedMessages => 'Märgistatud kirjad';

  @override
  String get searchWithAttachments => 'Manustega kirjad';

  @override
  String get searchUnrepliedMessages => 'Vastamata kirjad';

  @override
  String get searchTags => 'Sildid';

  @override
  String get searchPeople => 'Inimesed';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxid';

  @override
  String searchFromPerson(String name) {
    return 'Saatja: $name';
  }

  @override
  String get searchSearching => 'Otsimine…';

  @override
  String get searchNoResults => 'Tulemusi pole';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted tulemust',
      one: '$formatted tulemus',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Otsingumenüü';

  @override
  String searchSearchingAccount(String account) {
    return 'Otsimine konto $account serverist…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Otsimine konto serverist…';

  @override
  String searchAccountFailed(String account) {
    return 'Konto $account serverist ei õnnestunud otsida';
  }

  @override
  String get searchUnknownAccountFailed => 'Konto serverist ei õnnestunud otsida';

  @override
  String searchChip(String term) {
    return '$term. Muutmiseks topeltpuuduta.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Mitte $term. Muutmiseks topeltpuuduta.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingeri postkast: iga kiri siin on korraga loetud ja lugemata, kuni sa selle avad.';

  @override
  String searchContradiction(String term) {
    return 'Ükski kiri ei saa olla korraga „$term“ ja mitte.';
  }

  @override
  String get searchSyncDeviceOnly => 'Ainult selles seadmes';

  @override
  String searchSyncUnsupported(String account) {
    return 'Ainult selles seadmes: konto $account ei saa seda hoida';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Pole sünkroonitud: kontol $account on uuem vorming';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Ootab sünkroonimist kontoga $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sünkroonitud kontoga $account';
  }

  @override
  String get searchRename => 'Nimeta ümber';

  @override
  String get searchEditSearch => 'Muuda otsingut';

  @override
  String get searchDeleteSmartMailbox => 'Kustuta Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Nimeta Smart Mailbox ümber';

  @override
  String get searchSmartMailboxDeleted => 'See Smart Mailbox on kustutatud.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxid';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxid jäävad sellesse seadmesse.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxe hoitakse sinu e-posti serveris, nii et need on olemas ka sinu teistes seadmetes ning Thunderbirdis lisaga Expression Search Reloaded. Kõiki kontosid läbiotsivaid hoitakse kontol $account; ühe kausta omi selle kausta kontol.';
  }

  @override
  String get searchSyncVia => 'Sünkrooni konto kaudu';

  @override
  String get searchSyncViaFooter => 'Vali igas seadmes sama konto.';

  @override
  String get searchGmailCantKeep => 'Gmail ei saa Smart Mailboxe hoida';

  @override
  String get searchKeepOnDevice => 'Hoia Smart Mailboxe ainult selles seadmes';

  @override
  String get searchOnTheServer => 'Serveris';

  @override
  String get searchServerFooter =>
      'Serveri metaandmeid (IMAP METADATA) ei näe ükski e-posti rakendus. Serverites, kus neid pole, luuakse kaust „Loupe Settings“, milles on üks kiri; Loupe peidab selle postkastide vaatest.';

  @override
  String get searchSyncNow => 'Sünkrooni kohe';

  @override
  String get searchStateUnsupported => 'Pole toetatud';

  @override
  String get searchStateNewerFormat => 'Uuem vorming';

  @override
  String get searchStateFailed => 'Sünkroonimine ebaõnnestus';

  @override
  String get searchStateSyncing => 'Sünkroonimine…';

  @override
  String get searchStateWaiting => 'Ootel';

  @override
  String get searchStateMetadata => 'Serveri metaandmed';

  @override
  String get searchStateFolder => 'Kaust „Loupe Settings“';

  @override
  String get searchStateNothing => 'Midagi pole talletatud';

  @override
  String get sharedBack => 'Tagasi';

  @override
  String get sharedYesterday => 'Eile';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date kell $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count baiti', one: '$count bait');
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
  String get sharedSyncNoAccounts => 'Kontosid pole';

  @override
  String get sharedSyncChecking => 'Kirjade kontrollimine…';

  @override
  String get sharedSyncFailed => 'Kirju ei õnnestunud kontrollida';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Võrguühenduseta';

  @override
  String get sharedSyncJustNow => 'Värskendatud just praegu';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Värskendatud $minutes minutit tagasi',
      one: 'Värskendatud $minutes minut tagasi',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Värskendatud kell $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Värskendatud $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Kõik sisendkaustad';

  @override
  String get sharedMailboxUnread => 'Lugemata';

  @override
  String get sharedMailboxFlagged => 'Märgistatud';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Kõik mustandid';

  @override
  String get sharedMailboxAllSent => 'Kõik saadetud';

  @override
  String get sharedMailboxUntitled => 'Postkast';

  @override
  String get sharedTagImportant => 'Tähtis';

  @override
  String get sharedTagWork => 'Töö';

  @override
  String get sharedTagPersonal => 'Isiklik';

  @override
  String get sharedTagToDo => 'Ülesanne';

  @override
  String get sharedTagLater => 'Hiljem';

  @override
  String get sharedTags => 'Sildid';

  @override
  String get sharedMoveTo => 'Teisalda kausta…';

  @override
  String get sharedNoRecipients => 'Saajad puuduvad';

  @override
  String get sharedUnknownSender => 'Tundmatu saatja';

  @override
  String get sharedOnServer => 'Serveris';

  @override
  String get sharedAttachment => 'Manus';

  @override
  String get sharedSnoozedBadge => 'Edasi lükatud';

  @override
  String get sharedRowUnread => 'Lugemata';

  @override
  String get sharedRowBackFromSnooze => 'Naasis edasilükkamiselt';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Märgistatud';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja arhiveeriti',
      one: '$count kiri arhiveeriti',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja kustutati',
      one: '$count kiri kustutati',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja teisaldati sisendkausta',
      one: '$count kiri teisaldati sisendkausta',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja teisaldati prügikasti',
      one: '$count kiri teisaldati prügikasti',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja teisaldati rämpsposti',
      one: '$count kiri teisaldati rämpsposti',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja teisaldati kausta $mailbox',
      one: '$count kiri teisaldati kausta $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja teisaldati postkasti',
      one: '$count kiri teisaldati postkasti',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kirja lükati edasi kuni $time',
      one: '$count kiri lükati edasi kuni $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Edasi lükatud kuni $time ainult selles seadmes: server ei saa edasilükkamise aegu talletada.';
  }

  @override
  String get sharedMoveOneAccount => 'Teisaldamiseks vali kirjad ühelt kontolt.';

  @override
  String get sharedSnoozeTitle => 'Lükka edasi';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Muuda edasilükkamise aega';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kas kustutada $count kirja jäädavalt?',
      one: 'Kas kustutada see kiri jäädavalt?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Seda ei saa tagasi võtta.';

  @override
  String get sharedDeletePermanently => 'Kustuta jäädavalt';

  @override
  String get sharedSwipeRead => 'Loetud';

  @override
  String get sharedSwipeUnread => 'Lugemata';

  @override
  String get sharedSwipeInbox => 'Sisendkaust';

  @override
  String get sharedSwipeDelete => 'Kustuta';

  @override
  String get sharedTrash => 'Prügikasti';

  @override
  String get sharedSwipeSnooze => 'Lükka edasi';

  @override
  String get sharedWakeNow => 'Too kohe tagasi';

  @override
  String get sharedChangeSnoozeTime => 'Muuda edasilükkamise aega…';

  @override
  String get sharedSnooze => 'Lükka edasi…';

  @override
  String get sharedTag => 'Sildista…';

  @override
  String get sharedMoveMessage => 'Teisalda kiri…';

  @override
  String get sharedNotJunk => 'Pole rämpspost';

  @override
  String get accountSetupTitle => 'Lisa konto';

  @override
  String get accountSetupTitleDone => 'Konto lisatud';

  @override
  String get accountSetupAddressTitle => 'Lisa e-posti konto';

  @override
  String get accountSetupAddressText => 'Loupe leiab enamiku teenusepakkujate seaded ise.';

  @override
  String get accountSetupNameHint => 'Sinu nimi';

  @override
  String get accountSetupEmail => 'E-post';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Jätka';

  @override
  String get accountSetupLookingUp => 'Seadete otsimine…';

  @override
  String get accountSetupImport => 'Impordi Thunderbirdist';

  @override
  String get accountSetupInvalidEmail => 'Sisesta kehtiv e-posti aadress.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Domeeni $domain seadeid ei leitud. Sisesta need allpool.';
  }

  @override
  String get accountSetupCheckServers => 'Kontrolli serverite nimesid ja porte.';

  @override
  String get accountSetupEnterPassword => 'Sisesta oma parool.';

  @override
  String get accountSetupConnecting => 'Ühendamine…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Teenuse $provider ootamine…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Lehte ei õnnestunud avada.';

  @override
  String get accountSetupCouldNotSaveName => 'Nime ei õnnestunud salvestada.';

  @override
  String get accountSetupTrustCertificate => 'Usalda seda sertifikaati';

  @override
  String get accountSetupPasswordRequired => 'Kohustuslik';

  @override
  String get accountSetupShowPassword => 'Näita parooli';

  @override
  String get accountSetupHidePassword => 'Peida parool';

  @override
  String get accountSetupAppPassword => 'Rakenduse parool';

  @override
  String get accountSetupApiToken => 'API-luba';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Sissetulev · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Väljuv · SMTP';

  @override
  String get accountSetupSignIn => 'Logi sisse';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Logi sisse teenusega $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Kasuta rakenduse parooli';

  @override
  String get accountSetupUseAppPasswordInstead => 'Kasuta hoopis rakenduse parooli';

  @override
  String get accountSetupUseDifferentAddress => 'Kasuta teist aadressi';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kuidas luua rakenduse parool';

  @override
  String get accountSetupHowToCreateOne => 'Kuidas see luua';

  @override
  String get accountSetupGoogleNote =>
      'Logid sisse Google’i lehel ja Loupe ei näe kunagi sinu parooli. Luba Loupe’il sinu kirju lugeda, saata ja korraldada.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Logi sisse teenusega Google“ pole selles versioonis veel saadaval. Selle asemel saad ühendada rakenduse parooliga (selleks peab sinu Google’i kontol olema sisse lülitatud kaheastmeline kinnitamine).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Loo oma Google’i kontol rakenduse parool ja kleebi see allpool.';

  @override
  String get accountSetupMicrosoftNote =>
      'Logid sisse Microsofti lehel ja Loupe ei näe kunagi sinu parooli. See töötab Outlook.com-i ja Hotmaili ning Microsoft 365 töö- või koolikontodega.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Microsofti sisselogimine tuleb hilisemas versioonis. Outlooki, Hotmaili ja Microsoft 365 kontod vajavad seda: need ei aktsepteeri enam e-posti rakenduste paroole.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail vajab rakenduspõhist parooli, mitte sinu Apple’i konto parooli.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail vajab rakenduse parooli, mitte sinu konto parooli.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe ühendub Fastmailiga JMAP-i kaudu API-loa abil: Settings › Privacy & Security › Manage API tokens, JMAP-i jaoks, e-posti ja saatmise juurdepääsuga.';

  @override
  String get accountSetupFastmailNote => 'Fastmail vajab e-posti rakenduste jaoks rakenduse parooli.';

  @override
  String get accountSetupServerSettings => 'Serveri seaded';

  @override
  String get accountSetupSettingsNotFound => 'Automaatselt ei leitud';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Leitud allikast $source';
  }

  @override
  String get accountSetupEditSettings => 'Muuda seadeid';

  @override
  String get accountSetupSyncing => 'Sinu kirju sünkroonitakse.';

  @override
  String get accountSetupDescription => 'Kirjeldus';

  @override
  String get accountSetupDescriptionHint => 'Töö, isiklik…';

  @override
  String get accountSetupColour => 'Värv';

  @override
  String accountSetupColourNumber(int number) {
    return 'Värv $number';
  }

  @override
  String get accountSetupSaving => 'Salvestamine…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe ei saanud selles telefonis oma e-posti andmebaasi avada. Sulge Loupe, ava see uuesti ja proovi veel kord.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Midagi läks valesti ($error). Proovi uuesti.';
  }

  @override
  String get accountSetupSecurityNone => 'Puudub';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Turvalisus';

  @override
  String get accountSetupUsername => 'Kasutajanimi';

  @override
  String get accountSetupUsernameHint => 'Sinu e-posti aadress';

  @override
  String get accountSetupNoEncryptionTitle => 'Kas ühendada ilma krüpteerimiseta?';

  @override
  String get accountSetupNoEncryptionText =>
      'Sinu parool ja iga kiri liiguksid lihttekstina. Igaüks samas võrgus, näiteks avalikus WiFi-võrgus, saaks neid lugeda. Kasuta seda ainult oma võrgus oleva serveri puhul.';

  @override
  String get accountSetupUseWithoutEncryption => 'Kasuta ilma krüpteerimiseta';

  @override
  String get accountSetupApiTokenRejected =>
      'API-luba lükati tagasi. Loo Fastmailis JMAP-i jaoks e-posti juurdepääsuga API-luba ja kleebi see siia.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Parool lükati tagasi. Kasuta rakenduse parooli, mitte oma konto parooli.';

  @override
  String get accountSetupPasswordRejected => 'Parool lükati tagasi. Kontrolli seda ja proovi uuesti.';

  @override
  String get accountSetupServerUnreachable => 'Serveriga ei saa ühendust. Kontrolli serveri seadeid ja oma ühendust.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Serveri sertifikaati ei usaldata. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Sisselogimine tühistati. Uuesti proovimiseks puuduta „Logi sisse teenusega $provider“.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe vajab luba sinu Gmaili lugemiseks ja saatmiseks. Logi uuesti sisse ja luba juurdepääs, märkides Gmaili ruudu.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe vajab luba sinu kirjade lugemiseks ja saatmiseks. Logi uuesti sisse ja nõustu lubadega.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Sinu organisatsioon peab Loupe’i heaks kiitma, enne kui saad seda selle kontoga kasutada. Palu oma IT-administraatoril anda Microsoft Entra ID-s Loupe’ile administraatori nõusolek ja proovi siis uuesti.';

  @override
  String get accountSetupOAuthBlocked =>
      'Sinu organisatsiooni sisselogimisreeglid ei luba Loupe’i selles seadmes. Pöördu oma IT-administraatori poole.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Teenusega $provider ei saanud ühendust. Kontrolli internetiühendust ja proovi uuesti.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Sisselogimine teenusega $provider pole selles Loupe’i versioonis õigesti seadistatud. Palun teata sellest.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Sisselogimine teenusega $provider ei õnnestunud. Proovi uuesti.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider logis sind sisse, kuid Gmail keelas sellele aadressile juurdepääsu. Vali sisselogimisel sama konto. Töö- või koolikontodel võib administraator olla IMAP-i välja lülitanud.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider logis sind sisse, kuid e-posti server keelas sellele aadressile juurdepääsu. Vali sisselogimisel sama konto. Töö- või koolikontodel võib administraator olla IMAP-i välja lülitanud.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'E-posti serveriga ei saa ühendust. Kontrolli ühendust ja proovi uuesti.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Sisselogimine teenusega $provider pole selles versioonis saadaval.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Uuesti sisse logitud. Kontot $account sünkroonitakse.';
  }

  @override
  String get accountSetupSignInAgain => 'Logi uuesti sisse';

  @override
  String get accountSetupSigningIn => 'Sisselogimine…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider ei aktsepteeri enam Loupe’i sisselogimist aadressi $email jaoks, seega kontot $account ei sünkroonita. Kirjade saamiseks logi uuesti sisse.';
  }

  @override
  String get accountImportTitle => 'Impordi Thunderbirdist';

  @override
  String get accountImportPointCamera => 'Suuna kaamera QR-koodile, mida Thunderbird näitab.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skannitud $scanned/$total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Skannitud koode: $scanned/$total',
      one: 'Skannitud koode: $scanned/$total',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Seni $count kontot',
      one: 'Seni $count konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Ava arvutis Thunderbird ja vali Tööriistad › Ekspordi mobiili. Vali oma kontod ja skanni seejärel iga kood, mida see näitab. Koode võib skannida mis tahes järjekorras.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jätka $count kontoga',
      one: 'Jätka $count kontoga',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Kleebi hoopis tekst';

  @override
  String get accountImportStartOver => 'Alusta otsast';

  @override
  String get accountImportDuplicateCode => 'See kood on juba lisatud.';

  @override
  String get accountImportRestarted =>
      'See kood on pärit uuest ekspordist, seega pandi varem skannitud koodid kõrvale.';

  @override
  String get accountImportNotThunderbird => 'See pole Thunderbirdi kontokood.';

  @override
  String get accountImportNewerVersion =>
      'See kood on pärit uuemast Thunderbirdist. Selle importimiseks uuenda Loupe’i.';

  @override
  String get accountImportDamaged => 'Seda Thunderbirdi koodi ei õnnestunud lugeda.';

  @override
  String get accountImportTooLarge => 'See kood on Thunderbirdi ekspordi jaoks liiga suur.';

  @override
  String get accountImportCouldNotOpenSettings => 'Seadeid ei õnnestunud avada.';

  @override
  String get accountImportCameraOffTitle => 'Juurdepääs kaamerale on välja lülitatud';

  @override
  String get accountImportCameraOffText =>
      'Koodi skannimiseks luba seadetes Loupe’il kaamerat kasutada või kleebi hoopis koodi tekst.';

  @override
  String get accountImportNoCameraTitle => 'Kaamera puudub';

  @override
  String get accountImportNoCameraText => 'Loupe ei saa siin kaamerat kasutada. Kleebi hoopis koodi tekst.';

  @override
  String get accountImportCameraFailedTitle => 'Kaamera ei käivitunud';

  @override
  String get accountImportCameraFailedText => 'Proovi uuesti või kleebi hoopis koodi tekst.';

  @override
  String get accountImportOpenSettings => 'Ava seaded';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Leiti $count kontot',
      one: 'Leiti $count konto',
      zero: 'Kontosid ei leitud',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ühtegi nende koodide kontot ei õnnestunud lugeda.';

  @override
  String get accountImportChoose => 'Vali kontod, mida Loupe’i lisada.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Koode $codes (kokku $total) ei skannitud, seega nende kontosid pole loendis.',
      one: 'Koodi $codes (kokku $total) ei skannitud, seega selle kontosid pole loendis.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes ja $last';
  }

  @override
  String get accountImportScanMore => 'Skanni rohkem koode';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Koodides olevat $count kontot ei õnnestunud lugeda. Need võivad kasutada uuema Thunderbirdi seadeid.',
      one: 'Koodides olevat $count kontot ei õnnestunud lugeda. See võib kasutada uuema Thunderbirdi seadeid.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skanni uuesti';

  @override
  String get accountImportAlreadyAdded => 'Selle aadressiga konto on Loupe’is juba olemas.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Pärast lisamist logid sisse teenusega $provider, nagu Thunderbirdis.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Lisa konto rakenduse parooliga (selleks on vaja kaheastmelist kinnitamist).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird logib Gmaili sisse Google’i kaudu. „Logi sisse teenusega Google“ tuleb hilisemas versioonis; seni lisa konto rakenduse parooliga (selleks on vaja kaheastmelist kinnitamist).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird logib sellesse kontosse sisse brauseris. Loupe seda veel ei oska: kasuta rakenduse parooli, kui sinu teenusepakkuja seda pakub.';

  @override
  String get accountImportUnencrypted => 'Ühendub ilma krüpteerimiseta. Kasuta seda ainult oma võrgus.';

  @override
  String get accountImportEnterAgain => 'Sisesta uuesti';

  @override
  String get accountImportAdded => 'Lisatud';

  @override
  String accountImportAdding(int index, int total) {
    return 'Lisamine: $index/$total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lisa $count kontot',
      one: 'Lisa $count konto',
      zero: 'Lisa kontod',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Kleebi ekspordi tekst';

  @override
  String get accountImportPasteText => 'Kleebi Thunderbirdi ekspordikoodi tekst, üks kood rea kohta.';

  @override
  String get accountImportPop3 => 'POP3-kontosid ei toetata. Loupe hoiab kirju IMAP-iga serveris.';

  @override
  String get accountImportKerberos => 'See konto logib sisse Kerberosega, mida Loupe ei toeta.';

  @override
  String get accountImportNtlm => 'See konto logib sisse NTLM-iga, mida Loupe ei toeta.';

  @override
  String get accountImportClientCertificate => 'See konto logib sisse kliendisertifikaadiga, mida Loupe veel ei toeta.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Microsofti sisselogimine tuleb hilisemas versioonis. Outlooki ja Microsoft 365 kontod ei aktsepteeri enam e-posti rakenduste paroole.';

  @override
  String get accountImportEnterPassword => 'Sisesta parool.';

  @override
  String get accountImportEnterAppPassword => 'Sisesta rakenduse parool.';

  @override
  String get accountImportEnterApiToken => 'Sisesta API-luba.';

  @override
  String get accountImportStorageFailed => 'Loupe ei saanud oma kontode hoidlat avada. Proovi hiljem uuesti.';

  @override
  String get accountImportFailed => 'Kontot ei õnnestunud lisada. Proovi uuesti või lisa see käsitsi.';

  @override
  String get composeNewMessageTitle => 'Uus kiri';

  @override
  String get composeAttach => 'Lisa manus';

  @override
  String get composeSendLater => 'Saada hiljem';

  @override
  String composeSendAt(String time) {
    return 'Saada $time';
  }

  @override
  String get composeSendHint => 'Hiljem saatmiseks vajuta pikalt';

  @override
  String get composeNoAccount => 'Kirjade saatmiseks lisa konto.';

  @override
  String get composeTo => 'Saaja:';

  @override
  String get composeCc => 'Koopia:';

  @override
  String get composeBcc => 'Pimekoopia:';

  @override
  String composeCcBccFrom(String email) {
    return 'Koopia/pimekoopia, saatja: $email';
  }

  @override
  String get composeFromLabel => 'Saatja:';

  @override
  String get composeSubjectLabel => 'Teema:';

  @override
  String composeReplyTo(String address) {
    return 'Vastuse saaja: $address';
  }

  @override
  String get composeFrom => 'Saatja';

  @override
  String composeReplyFrom(String email) {
    return 'Vasta aadressilt $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Saada aadressilt $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Kas vastata aadressilt $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Kas saata aadressilt $email?';
  }

  @override
  String get composeDismiss => 'Peida';

  @override
  String composeAliasNotSaved(String account) {
    return 'Pole identiteedina salvestatud · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Salvesta identiteedina';

  @override
  String composeAliasSaved(String email) {
    return '$email on salvestatud identiteedina.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Vigane aadress $address';
  }

  @override
  String get composeOriginalNotFound => 'Algset kirja ei leitud.';

  @override
  String get composeDraftNotFound => 'Mustandit ei leitud.';

  @override
  String get composeAttachmentsLost => 'Manuseid ei õnnestunud taastada. Lisa need uuesti.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Mõnda manust ei õnnestunud lisada: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Manuste kogumaht on $size; mõni server ei võta nii suuri kirju vastu.';
  }

  @override
  String get composeAttachFailed => 'Faili ei õnnestunud lisada.';

  @override
  String get composeInvalidAddressTitle => 'Vigane aadress';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ pole kehtiv e-posti aadress.';
  }

  @override
  String get composeNoSubjectTitle => 'Teema puudub';

  @override
  String get composeNoSubjectText => 'Sellel kirjal pole teemat. Kas saata see siiski?';

  @override
  String get composeSentBeforeChanges => 'See saadeti enne sinu muudatusi, mis on salvestatud mustanditesse.';

  @override
  String composeScheduled(String time) {
    return 'Ajastatud: $time';
  }

  @override
  String get composeSending => 'Saatmine…';

  @override
  String get composeSent => 'Saadetud';

  @override
  String get composeSendFailed => 'Saatmine ebaõnnestus. Proovi uuesti.';

  @override
  String get composeAlreadySent => 'Juba saadetud.';

  @override
  String get composeDiscardChanges => 'Loobu muudatustest';

  @override
  String get composeSaveChanges => 'Salvesta muudatused';

  @override
  String get composeDeleteDraft => 'Kustuta mustand';

  @override
  String get composeSaveDraft => 'Salvesta mustand';

  @override
  String get composeDraftSaved => 'Mustand on salvestatud';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date kell $time kirjutas $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date kell $time kirjutas keegi:';
  }

  @override
  String get composeForwardHeader => '---------- Edastatud kiri ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Saatja: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Kuupäev: $date kell $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Teema: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Saaja: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Koopia: $addresses';
  }

  @override
  String get composeLaterToday => 'Täna hiljem';

  @override
  String get composeTomorrowMorning => 'Homme hommikul';

  @override
  String get composeMondayMorning => 'Esmaspäeva hommikul';

  @override
  String get composePickDateTime => 'Vali kuupäev ja kellaaeg…';

  @override
  String get composeSendWithoutDelay => 'Saada viivituseta';

  @override
  String composeSendTimeToday(String time) {
    return 'Täna kell $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Homme kell $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day kell $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Täna $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Homme $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Kas jätkata mustandi muutmist?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Üks kiri jäi Loupe’i sulgemisel saatmata.',
      'one': 'Kiri saajale $name jäi Loupe’i sulgemisel saatmata.',
      'other': 'Kiri saajale $name ja teistele jäi Loupe’i sulgemisel saatmata.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject“ jäi Loupe’i sulgemisel saatmata.',
      'one': '„$subject“ saajale $name jäi Loupe’i sulgemisel saatmata.',
      'other': '„$subject“ saajale $name ja teistele jäi Loupe’i sulgemisel saatmata.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Jätka muutmist';

  @override
  String get composeRecoverySave => 'Salvesta mustanditesse';

  @override
  String get composeRecoveryDiscard => 'Loobu';

  @override
  String get composeRecoverySaved => 'Salvestatud mustanditesse';

  @override
  String get outboxSectionFailed => 'Saatmata';

  @override
  String get outboxSectionSending => 'Saatmisel';

  @override
  String get outboxSectionScheduled => 'Ajastatud';

  @override
  String get outboxStatusQueued => 'Saadetakse peagi';

  @override
  String get outboxStatusSending => 'Saatmine…';

  @override
  String get outboxStatusFailed => 'Saatmata';

  @override
  String get outboxNoRecipients => 'Saajad puuduvad';

  @override
  String get outboxNoSubject => '(teema puudub)';

  @override
  String get outboxSendingFailed => 'Saatmine ebaõnnestus.';

  @override
  String get outboxEmptyTitle => 'Pole midagi saata';

  @override
  String get outboxEmptyText => 'Hiljem saadetavad kirjad ootavad siin, kuni on aeg.';

  @override
  String get outboxSendNow => 'Saada kohe';

  @override
  String get outboxReschedule => 'Ajasta ümber';

  @override
  String get outboxRescheduleMenu => 'Ajasta ümber…';

  @override
  String get outboxRescheduleTitle => 'Ajasta ümber';

  @override
  String outboxRescheduled(String time) {
    return 'Ümber ajastatud: $time';
  }

  @override
  String get outboxCancel => 'Tühista';

  @override
  String get outboxCancelSending => 'Tühista saatmine…';

  @override
  String get outboxCancelTitle => 'Kas tühistada saatmine?';

  @override
  String get outboxMoveToDrafts => 'Teisalda mustanditesse';

  @override
  String get outboxDiscard => 'Kustuta kiri';

  @override
  String get outboxMovedToDrafts => 'Teisaldatud mustanditesse';

  @override
  String get outboxDiscarded => 'Kiri on kustutatud';

  @override
  String get outboxAlreadySent => 'Juba saadetud.';

  @override
  String get outboxBeingSent => 'Seda kirja saadetakse.';

  @override
  String get outboxActionFailed => 'See ei õnnestunud. Kiri on endiselt väljuvate kirjade kaustas.';

  @override
  String get notificationsBadgeInboxes => 'Lugemata sisendkaustades';

  @override
  String get notificationsBadgeVip => 'Lugemata VIP-postkastis';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Uued kirjad sinu VIP-kontaktidelt kõigil kontodel';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Uued kirjad kontol $email';
  }

  @override
  String get notificationsUnknownSender => 'Tundmatu saatja';

  @override
  String get notificationsNoSubject => '(teema puudub)';

  @override
  String get notificationsEncryptedMessage => 'Krüpteeritud kiri';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Uus kiri kontol $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count uut kirja', one: '$count uus kiri');
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Uued kirjad kontol $account';
  }

  @override
  String get platformInstantChannel => 'Kohene kättetoimetamine';

  @override
  String get platformInstantChannelDescription => 'Kuvatakse, kui Loupe jälgib sinu sisendkaustu uute kirjade suhtes';

  @override
  String get platformInstantTitle => 'Uute kirjade jälgimine';

  @override
  String get platformInstantText => 'Kohene kättetoimetamine on sees';

  @override
  String get platformErrorBox => 'Selle näitamisel läks midagi valesti. Mine tagasi ja proovi uuesti.';

  @override
  String get welcomeTagline => 'E-post, mis on pealtnäha lihtne\nja seest võimas.';

  @override
  String get welcomeAccountsTitle => 'Kõik kontod, üks rahulik postkast';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail ja mis tahes IMAP- või JMAP-server.';

  @override
  String get welcomeSearchTitle => 'Otsing, mis leiab';

  @override
  String get welcomeSearchText => 'Kohesed tulemused sinu telefonist, seejärel serverist.';

  @override
  String get welcomePrivacyTitle => 'Algusest peale privaatne';

  @override
  String get welcomePrivacyText => 'Jälgimist pole. Välised pildid jäävad blokeerituks, kuni sa teisiti ütled.';

  @override
  String get welcomeAddAccount => 'Lisa konto';

  @override
  String get welcomeImport => 'Impordi Thunderbirdist';

  @override
  String get welcomeTryDemo => 'Proovi demopostiga';
}
