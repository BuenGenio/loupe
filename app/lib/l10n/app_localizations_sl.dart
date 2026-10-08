// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get commonAdd => 'Dodaj';

  @override
  String get commonCancel => 'Prekliči';

  @override
  String get commonClose => 'Zapri';

  @override
  String get commonDelete => 'Izbriši';

  @override
  String get commonDone => 'Končano';

  @override
  String get commonEdit => 'Uredi';

  @override
  String get commonMore => 'Več';

  @override
  String get commonMove => 'Premakni';

  @override
  String get commonName => 'Ime';

  @override
  String get commonNone => 'Brez';

  @override
  String get commonOff => 'Izklopljeno';

  @override
  String get commonOk => 'V redu';

  @override
  String get commonOn => 'Vklopljeno';

  @override
  String get commonOptional => 'Neobvezno';

  @override
  String get commonPassword => 'Geslo';

  @override
  String get commonRemove => 'Odstrani';

  @override
  String get commonRetry => 'Poskusi znova';

  @override
  String get commonSave => 'Shrani';

  @override
  String get commonSearch => 'Išči';

  @override
  String get commonServer => 'Strežnik';

  @override
  String get commonSettings => 'Nastavitve';

  @override
  String get commonShare => 'Deli';

  @override
  String get commonTryAgain => 'Poskusi znova';

  @override
  String get commonUndo => 'Razveljavi';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil',
      few: '$count sporočila',
      two: '$count sporočili',
      one: '$count sporočilo',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arhiviraj';

  @override
  String get mailDelete => 'Izbriši';

  @override
  String get mailFlag => 'Označi z zastavico';

  @override
  String get mailForward => 'Posreduj';

  @override
  String get mailMarkAsRead => 'Označi kot prebrano';

  @override
  String get mailMarkAsUnread => 'Označi kot neprebrano';

  @override
  String get mailMoveToJunk => 'Premakni med neželeno pošto';

  @override
  String get mailNewMessage => 'Novo sporočilo';

  @override
  String get mailNoSubject => 'Brez zadeve';

  @override
  String get mailReply => 'Odgovori';

  @override
  String get mailReplyAll => 'Odgovori vsem';

  @override
  String get mailSend => 'Pošlji';

  @override
  String get mailUnflag => 'Odstrani zastavico';

  @override
  String get mailboxArchive => 'Arhiv';

  @override
  String get mailboxDrafts => 'Osnutki';

  @override
  String get mailboxInbox => 'Prejeto';

  @override
  String get mailboxJunk => 'Neželena pošta';

  @override
  String get mailboxOutbox => 'Odhodna pošta';

  @override
  String get mailboxSent => 'Poslano';

  @override
  String get mailboxTrash => 'Smeti';

  @override
  String get conversationSomethingWentWrong => 'Prišlo je do napake. Poskusite znova.';

  @override
  String get conversationReplyToList => 'Odgovori na poštni seznam';

  @override
  String get conversationReplyList => 'Na seznam';

  @override
  String get conversationThreadMuted => 'Nit je utišana. Nova sporočila v njej prispejo kot prebrana.';

  @override
  String get conversationThreadUnmuted => 'Utišanje niti je preklicano.';

  @override
  String get conversationLinkFailed => 'Povezave ni bilo mogoče odpreti.';

  @override
  String get conversationGoneTitle => 'Ni sporočila';

  @override
  String get conversationGoneText => 'To sporočilo je bilo premaknjeno ali izbrisano.';

  @override
  String get conversationMuted => 'Utišano';

  @override
  String get conversationReaderOptions => 'Možnosti branja';

  @override
  String get conversationReaderOptionsHint => 'Velikost besedila in pogled';

  @override
  String get conversationTrash => 'V smeti';

  @override
  String get conversationReplyHint => 'Pridržite za Odgovori vsem in Posreduj';

  @override
  String get conversationOfflineTitle => 'Niste povezani';

  @override
  String get conversationOfflineText => 'Ta pogovor še ni prenesen. Naložil se bo, ko boste spet povezani.';

  @override
  String get conversationErrorTitle => 'Tega sporočila ni mogoče prikazati';

  @override
  String get conversationErrorText => 'Prišlo je do napake.';

  @override
  String get conversationOfflineBanner => 'Niste povezani';

  @override
  String get conversationNotUpdated => 'Ni posodobljeno';

  @override
  String get conversationMe => 'jaz';

  @override
  String get conversationNoSender => '(brez pošiljatelja)';

  @override
  String get conversationNoRecipients => 'brez prejemnikov';

  @override
  String conversationRecipients(String names) {
    return 'za: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'za: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Od';

  @override
  String get conversationHeaderTo => 'Za';

  @override
  String get conversationHeaderCc => 'Kp';

  @override
  String get conversationHeaderBcc => 'Skp';

  @override
  String get conversationHeaderReplyTo => 'Odgovor za';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Varnost';

  @override
  String get conversationVerifiedSender => 'Preverjen pošiljatelj';

  @override
  String get conversationUnverifiedSender => 'Nepreverjen pošiljatelj';

  @override
  String get conversationLoadingMessage => 'Nalaganje sporočila';

  @override
  String get conversationBodyError => 'Tega sporočila ni bilo mogoče naložiti.';

  @override
  String get conversationBodyOffline => 'Niste povezani. Sporočilo se bo naložilo, ko boste spet povezani.';

  @override
  String get conversationOriginalHint => 'Bolje je videti v pogledu Izvirno';

  @override
  String get conversationShowOriginal => 'Pokaži izvirnik';

  @override
  String get conversationScrollToTop => 'Pomakni na vrh';

  @override
  String get conversationTagsMenu => 'Oznake …';

  @override
  String get conversationMuteThread => 'Utišaj nit';

  @override
  String get conversationUnmuteThread => 'Prekliči utišanje niti';

  @override
  String get conversationMoveMenu => 'Premakni …';

  @override
  String get conversationDeletePermanently => 'Trajno izbriši';

  @override
  String get conversationMoveToTrash => 'Premakni v smeti';

  @override
  String get conversationNotJunk => 'Ni neželeno';

  @override
  String get conversationShowAllHeaders => 'Pokaži vse glave';

  @override
  String get conversationViewSource => 'Pokaži izvorno kodo';

  @override
  String get conversationSaveAsFile => 'Shrani kot datoteko …';

  @override
  String get conversationShareAsFile => 'Deli kot datoteko …';

  @override
  String get conversationSearchFromMessageMenu => 'Išči glede na to sporočilo …';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiraj naslov';

  @override
  String get conversationAddressCopied => 'Naslov je kopiran';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Išči sporočila pošiljatelja $name';
  }

  @override
  String get conversationTags => 'Oznake';

  @override
  String get conversationAllHeaders => 'Vse glave';

  @override
  String get conversationCopyAll => 'Kopiraj vse';

  @override
  String get conversationHeadersCopied => 'Glave so kopirane';

  @override
  String get conversationNoHeaders => 'Ni glav';

  @override
  String get conversationSearchFromMessageTitle => 'Išči glede na to sporočilo';

  @override
  String conversationSearchFrom(String name) {
    return 'Od: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Za: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Zadeva „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Izvorna koda';

  @override
  String get conversationSourceCopied => 'Izvorna koda je kopirana';

  @override
  String get conversationShareFailed => 'Sporočila ni bilo mogoče deliti.';

  @override
  String get conversationWrapLines => 'Prelomi vrstice';

  @override
  String get conversationDontWrapLines => 'Ne prelamljaj vrstic';

  @override
  String get conversationSourceError => 'Izvorne kode ni bilo mogoče naložiti.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Prikazanih je prvih $shown od $total. Za celotno kodo jo kopirajte ali delite.';
  }

  @override
  String get conversationAttachmentUntitled => 'Brez imena';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Več dejanj za $name';
  }

  @override
  String get conversationMoveTo => 'Premakni v …';

  @override
  String get conversationMailboxesError => 'Map ni bilo mogoče naložiti.';

  @override
  String get conversationReaderReadable => 'Berljivo';

  @override
  String get conversationReaderOriginal => 'Izvirno';

  @override
  String get conversationReaderPlain => 'Navadno besedilo';

  @override
  String get conversationReaderSans => 'Brez serifov';

  @override
  String get conversationReaderMono => 'Stalna širina';

  @override
  String get conversationReaderKeepColours => 'Ohrani izvirne barve';

  @override
  String get conversationReaderRemember => 'Zapomni si za tega pošiljatelja';

  @override
  String get conversationSecurityPossiblePhishing => 'Možen phishing';

  @override
  String get conversationSecurityBeCareful => 'Bodite previdni';

  @override
  String get conversationSecurityVerified => 'Preverjeno';

  @override
  String get conversationSecurityNoIssues => 'Ni najdenih težav';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sledilnikov',
      few: '$count sledilniki',
      two: '$count sledilnika',
      one: '$count sledilnik',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Pokaže razlog';

  @override
  String get conversationPhishingBannerTitle => 'To sporočilo je videti kot phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Povezave in slike so izklopljene.';
  }

  @override
  String get conversationPhishingBannerText => 'Povezave in slike so izklopljene.';

  @override
  String get conversationPhishingWhy => 'Zakaj?';

  @override
  String get conversationPhishingShowAnyway => 'Vseeno pokaži';

  @override
  String get conversationSecurityPhishingTitle => 'To je videti kot phishing';

  @override
  String get conversationSecurityPhishingText => 'Več znakov kaže, da to sporočilo ni to, za kar se izdaja.';

  @override
  String get conversationSecurityCarefulTitle => 'Pri tem sporočilu bodite previdni';

  @override
  String get conversationSecurityCarefulText => 'Nekaj pri njem si zasluži še en pogled.';

  @override
  String get conversationSecurityVerifiedText => 'Pošiljatelj je preverjen in nič ni videti sumljivo.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nič ni videti sumljivo. Vaš poštni strežnik ni sporočil, ali je pošiljatelj preverjen.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nič ni videti sumljivo.';

  @override
  String get conversationSecurityWhy => 'Zakaj';

  @override
  String get conversationSecurityPrivacy => 'Zasebnost';

  @override
  String get conversationSecurityNoTrackingPixels => 'Ni sledilnih slikovnih pik';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstranjenih $count sledilnih slikovnih pik',
      few: 'Odstranjene $count sledilne slikovne pike',
      two: 'Odstranjeni $count sledilni slikovni piki',
      one: 'Odstranjena $count sledilna slikovna pika',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Pošiljatelju bi sporočile, kdaj ste odprli to sporočilo.';

  @override
  String get conversationSecurityNoRemoteImages => 'Ni oddaljenih slik';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oddaljenih slik',
      few: '$count oddaljene slike',
      two: '$count oddaljeni sliki',
      one: '$count oddaljena slika',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Če jih naložite, pošiljatelj izve, kdaj ste prebrali to sporočilo, in vaš naslov IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Brez sledenja klikom';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count povezav prek sledenja klikom',
      few: '$count povezave prek sledenja klikom',
      two: '$count povezavi prek sledenja klikom',
      one: '$count povezava prek sledenja klikom',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services bi zabeležili vaš klik. Pridržite povezavo, da neposredno odprete njen cilj.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tehnične podrobnosti';

  @override
  String get conversationSecurityCheckedLocally => 'Preverjeno v tej napravi. Nič ni bilo nikamor poslano.';

  @override
  String get conversationSecurityTrackersLabel => 'Sledilniki';

  @override
  String get conversationSecurityImagesFrom => 'Slike z';

  @override
  String get conversationSecuritySenderHistory => 'Zgodovina pošiljatelja';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'prejeto: $received, poslano: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Povezave vodijo na';

  @override
  String get conversationSecurityHidden => 'Skrito';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementov',
      few: '$elements elementi',
      two: '$elements elementa',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters znakov',
      few: '$characters znaki',
      two: '$characters znaka',
      one: '$characters znak',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Pošiljatelj ni preverjen';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Vaš poštni strežnik ni mogel potrditi, da to sporočilo res prihaja z domene $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Vaš poštni strežnik ni mogel potrditi, da to sporočilo res prihaja od svojega pošiljatelja.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Vaš poštni strežnik ni mogel potrditi, da to sporočilo prihaja z domene $domain. Pri poštnih seznamih je to pogosto.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Vaš poštni strežnik ni mogel potrditi, da to sporočilo prihaja od svojega pošiljatelja. Pri poštnih seznamih je to pogosto.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ne ukrepajte na podlagi tega sporočila, če ga niste pričakovali. Če ste v dvomih, se s pošiljateljem povežite drugače.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Podpisano z drugo domeno';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Sporočilo je podpisala domena $signer, ne $domain. To počnejo storitve za pošiljanje pošte, vendar to ne dokazuje, kdo ga je napisal.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Sporočilo je podpisala druga domena, ne $domain. To počnejo storitve za pošiljanje pošte, vendar to ne dokazuje, kdo ga je napisal.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Ime prikazuje drug naslov';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Ime pošiljatelja se glasi „$shown“, sporočilo pa prihaja z naslova $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Zaupajte naslovu, ne imenu.';

  @override
  String get conversationSecurityReplyToTitle => 'Odgovori gredo drugam';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vaš odgovor bi bil poslan na $address, ne na domeno $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Preden odgovorite s čimer koli osebnim, preverite naslov.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Uporablja vaše ime';

  @override
  String get conversationSecurityImpersonationTitle => 'Uporablja ime nekoga, ki ga poznate';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Podpisano je z imenom „$name“, enakim vašemu, vendar prihaja z novega naslova: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Podpisano je z imenom „$name“, kot da je od vašega stika VIP $knownName ($knownEmail), vendar prihaja z novega naslova: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Podpisano je z imenom „$name“, kot da je od osebe $knownName ($knownEmail), vendar prihaja z novega naslova: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Odgovori pa bi šli na še en, drug naslov.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Če zahteva denar, kode ali datoteke, to najprej preverite pri tej osebi na drug način.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Znan naslov: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ta naslov: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Prvo sporočilo tega pošiljatelja';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Z naslova $email še niste prejeli pošte.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Bodite previdni pri zahtevah ljudi, ki jih še ne poznate.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Podobne črke v naslovu pošiljatelja';

  @override
  String get conversationSecurityLinkHomographTitle => 'Podobne črke v povezavi';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host meša črke iz različnih pisav, da posnema drug naslov.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host uporablja podobne črke: to ni $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Izbrišite ga ali ga prijavite kot neželeno pošto.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ne odpirajte je.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domena: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Podobna domena';

  @override
  String get conversationSecurityFamiliarNameTitle => 'V domeni uporablja znano ime';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain je videti kot vaša domena $real, vendar je to druga domena.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain je videti kot $brand ($real), vendar je to druga domena.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain uporablja ime vaše domene $real, vendar ji ne pripada.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain uporablja ime $brand ($real), vendar z njim ni povezana.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Prava sporočila iz vaše organizacije prihajajo z $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Prava sporočila od $brand prihajajo z $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domena pošiljatelja: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Posnema: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count povezav skriva, kam vodijo',
      few: '$count povezave skrivajo, kam vodijo',
      two: '$count povezavi skrivata, kam vodita',
      one: '$count povezava skriva, kam vodi',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Povezava prikazuje $shown, odpre pa $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Prek teh povezav se ne prijavljajte in ne plačujte. Naslov raje vtipkajte sami.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Cilja povezave ni mogoče preveriti';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Povezava prikazuje $shown, vendar vodi prek $host, ki klik zabeleži, preden ga posreduje naprej.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Povezava kaže na gol naslov IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts ni poimenovano spletno mesto. Prava podjetja redko povezujejo tako.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Prikrita povezava';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Povezava se začne z „$shown@“, da je videti kot $shown, odpre pa $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Skrita stran je bila onemogočena';

  @override
  String get conversationSecurityDataLinkText =>
      'Povezava bi odprla stran, zapakirano v samo sporočilo, kar je način za izogibanje preverjanju povezav.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Zahteva geslo';

  @override
  String get conversationSecurityPasswordFieldText => 'Sporočilo je vsebovalo polje za geslo. Loupe ga je odstranila.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nikoli ne vpisujte gesla v e-poštno sporočilo.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Povezava, ki zažene kodo, je bila onemogočena';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nikoli ne zažene kode iz sporočil.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skrajšanih povezav',
      few: '$count skrajšane povezave',
      two: '$count skrajšani povezavi',
      one: '$count skrajšana povezava',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skriva pravi cilj, dokler povezave ne odprete.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Mednarodni spletni naslov';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts uporablja nelatinične črke. Za mnoge jezike je to običajno; preverite, ali je to spletno mesto, ki ga pričakujete.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Veliko skritega besedila';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Odstranjenih je bilo $count znakov nevidnega besedila. Tako skrito besedilo je namenjeno zavajanju filtrov neželene pošte.',
      few:
          'Odstranjeni so bili $count znaki nevidnega besedila. Tako skrito besedilo je namenjeno zavajanju filtrov neželene pošte.',
      two:
          'Odstranjena sta bila $count znaka nevidnega besedila. Tako skrito besedilo je namenjeno zavajanju filtrov neželene pošte.',
      one:
          'Odstranjen je bil $count znak nevidnega besedila. Tako skrito besedilo je namenjeno zavajanju filtrov neželene pošte.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skrito besedilo je bilo odstranjeno';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odstranjenih je bilo $count znakov nevidnega besedila.',
      few: 'Odstranjeni so bili $count znaki nevidnega besedila.',
      two: 'Odstranjena sta bila $count znaka nevidnega besedila.',
      one: 'Odstranjen je bil $count znak nevidnega besedila.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Sporočila ni bilo mogoče prenesti. Preverite povezavo in poskusite znova.';

  @override
  String exportSaved(String name) {
    return 'Shranjeno: „$name“';
  }

  @override
  String get exportSaveFailed => 'Sporočila ni bilo mogoče shraniti.';

  @override
  String exportFailed(String folder) {
    return 'Mape „$folder“ ni bilo mogoče izvoziti.';
  }

  @override
  String exportEmpty(String folder) {
    return 'V mapi „$folder“ ni sporočil za izvoz.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Mape „$folder“ ni bilo mogoče izvoziti: nobenega sporočila ni bilo mogoče prenesti. Preverite povezavo in poskusite znova.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Shranjeno „$name“ brez $formattedCount sporočil, ki jih ni bilo mogoče prenesti.',
      few: 'Shranjeno „$name“ brez $formattedCount sporočil, ki jih ni bilo mogoče prenesti.',
      two: 'Shranjeno „$name“ brez $formattedCount sporočil, ki ju ni bilo mogoče prenesti.',
      one: 'Shranjeno „$name“ brez $count sporočila, ki ga ni bilo mogoče prenesti.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ ni bilo mogoče shraniti.';
  }

  @override
  String exportTitle(String folder) {
    return 'Izvažanje mape „$folder“';
  }

  @override
  String get exportListing => 'Iskanje sporočil …';

  @override
  String exportProgress(String current, String total) {
    return 'Izvažanje $current od $total …';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount sporočil ni bilo mogoče prenesti',
      few: '$formattedCount sporočil ni bilo mogoče prenesti',
      two: '$formattedCount sporočil ni bilo mogoče prenesti',
      one: '$count sporočila ni bilo mogoče prenesti',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Nabiralniki';

  @override
  String get mailboxesShown => 'Prikazano';

  @override
  String get mailboxesHidden => 'Skrito';

  @override
  String get mailboxesCollapse => 'Strni';

  @override
  String get mailboxesExpand => 'Razširi';

  @override
  String get mailboxesManageVips => 'Upravljaj stike VIP';

  @override
  String get mailboxesSubscriptions => 'Naročnine';

  @override
  String mailboxesShowAccount(String account) {
    return 'Pokaži $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Skrij $account';
  }

  @override
  String get mailboxesExportFolder => 'Izvozi mapo …';

  @override
  String get mailboxesUnpin => 'Odpni';

  @override
  String get mailboxesLists => 'Seznami';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Shranite iskanje, da ostane tukaj.';

  @override
  String get mailboxesTags => 'Oznake';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'V sporočilu se lahko tudi dotaknete imena pošiljatelja in vklopite VIP.';

  @override
  String get mailboxesAddVip => 'Dodaj VIP …';

  @override
  String get mailboxesAddVipTitle => 'Dodaj VIP';

  @override
  String get mailboxesAddVipText => 'Pošta s tega naslova dobi zvezdico in se prikaže v nabiralniku VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Neprebrano';

  @override
  String get messageListFilterFlagged => 'Z zastavico';

  @override
  String get messageListFilterToMe => 'Naslovljeno name';

  @override
  String get messageListFilterCcMe => 'Jaz v kopiji';

  @override
  String get messageListFilterWithAttachments => 'S prilogami';

  @override
  String get messageListFilterUnreplied => 'Neodgovorjeno';

  @override
  String get messageListFilterFromVips => 'Od stikov VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil označenih kot prebranih',
      few: '$count sporočila označena kot prebrana',
      two: '$count sporočili označeni kot prebrani',
      one: '$count sporočilo označeno kot prebrano',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Starejše pošte ni bilo mogoče naložiti.';

  @override
  String get messageListSelectMessages => 'Izberite sporočila';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count izbranih',
      few: '$count izbrana',
      two: '$count izbrani',
      one: '$count izbrano',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Izberi vse';

  @override
  String get messageListDeselectAll => 'Počisti izbor';

  @override
  String get messageListLoadFailed => 'Pošte ni mogoče naložiti';

  @override
  String get messageListNoUnread => 'Ni neprebrane pošte';

  @override
  String get messageListNoMatches => 'Ni ustrezne pošte';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrirano po: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Izklopi filter';

  @override
  String get messageListEmpty => 'Ni pošte';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Merila filtra: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrirano po:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount neprebranih',
      few: '$formattedCount neprebrana',
      two: '$formattedCount neprebrani',
      one: '$count neprebrano',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Označi';

  @override
  String get messageListTrash => 'V smeti';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'VKLJUČI';

  @override
  String get panesHideMailboxes => 'Skrij nabiralnike';

  @override
  String get panesShowMailboxes => 'Pokaži nabiralnike';

  @override
  String get panesMailboxesWidth => 'Širina nabiralnikov';

  @override
  String get panesListWidth => 'Širina seznama sporočil';

  @override
  String get panesNoMessageSelected => 'Ni izbranega sporočila';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil',
      few: '$count sporočila',
      two: '$count sporočili',
      one: '$count sporočilo',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Odloženo';

  @override
  String get snoozeSheetTitle => 'Odloži';

  @override
  String get snoozeLaterToday => 'Pozneje danes';

  @override
  String get snoozeThisEvening => 'Nocoj';

  @override
  String get snoozeTomorrow => 'Jutri';

  @override
  String get snoozeThisWeekend => 'Ta vikend';

  @override
  String get snoozeNextWeek => 'Naslednji teden';

  @override
  String get snoozePickDateTime => 'Izberi datum in čas …';

  @override
  String get snoozeMenu => 'Odloži …';

  @override
  String get snoozeWakeNow => 'Vrni zdaj';

  @override
  String get snoozeChangeTimeMenu => 'Spremeni čas odloga …';

  @override
  String get snoozeChangeTime => 'Spremeni čas';

  @override
  String get snoozeNoTime => 'Čas ni nastavljen';

  @override
  String get snoozeFooter => 'Odložena sporočila se ob nastavljenem času vrnejo v mapo Prejeto kot neprebrana.';

  @override
  String get snoozeEmptyTitle => 'Nič ni odloženo';

  @override
  String get snoozeEmptyText => 'Odložite sporočilo in vrnilo se bo v mapo Prejeto, ko ga boste potrebovali.';

  @override
  String get appLockUnlock => 'Odkleni';

  @override
  String get appLockFailed => 'Loupe ni mogla potrditi, da ste to vi.';

  @override
  String get appLockLockedOut => 'Preveč poskusov. Poskusite znova pozneje.';

  @override
  String get appLockPromptError => 'Poziva ni bilo mogoče prikazati. Poskusite znova.';

  @override
  String get appLockNoScreenLock => 'Ta telefon nima zaklepanja zaslona.';

  @override
  String get appLockUnlockPromptTitle => 'Odklenite Loupe';

  @override
  String get appLockUnlockPromptReason => 'Potrdite, da ste to vi, da vidite svojo pošto.';

  @override
  String get appLockTurnOnPromptTitle => 'Vklopi zaklepanje aplikacije';

  @override
  String get appLockTurnOnPromptReason => 'Potrdite, da ste to vi, da vklopite zaklepanje aplikacije.';

  @override
  String get appLockScreenLockRemoved =>
      'Zaklepanje aplikacije je izklopljeno: ta telefon nima več zaklepanja zaslona. Nastavite ga, da znova vklopite zaklepanje aplikacije.';

  @override
  String get appLockAfterImmediately => 'Takoj';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      few: '$count minute',
      two: '$count minuti',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ur',
      few: '$count ure',
      two: '$count uri',
      one: '$count ura',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Šifrirano';

  @override
  String get openpgpEncryptedInPart => 'Delno šifrirano';

  @override
  String get openpgpEncryptedLocked => 'Šifrirano · zaklenjeno';

  @override
  String get openpgpEncryptedNoKey => 'Šifrirano · ni ključa';

  @override
  String get openpgpEncryptedDamaged => 'Šifrirano · poškodovano';

  @override
  String get openpgpEncryptedUnsupported => 'Šifrirano · ni podprto';

  @override
  String get openpgpUnknownSigner => 'neznan';

  @override
  String get openpgpUnknownKey => 'Neznan ključ';

  @override
  String get openpgpSignatureInvalid => 'Neveljaven podpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Podpisano: $name, ne pošiljatelj';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Delno podpisano: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Podpisano: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Podpisano z zavrnjenim ključem';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Podpisano: $name · ključ ni sprejet';
  }

  @override
  String get openpgpUnlock => 'Odkleni';

  @override
  String get openpgpCantDecrypt => 'Tega sporočila ni mogoče dešifrirati';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifrirano z OpenPGP';

  @override
  String get openpgpEncryption => 'Šifriranje';

  @override
  String get openpgpDecryptedHere => 'Dešifrirano v tej napravi';

  @override
  String get openpgpNotDecrypted => 'Ni dešifrirano';

  @override
  String get openpgpKeyLocked => 'Vaš ključ je zaklenjen.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Za $count ključev: $keys',
      few: 'Za $count ključe: $keys',
      two: 'Za $count ključa: $keys',
      one: 'Za $count ključ: $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Zaščitena zadeva';

  @override
  String get openpgpUnlockKey => 'Odkleni ključ';

  @override
  String get openpgpSignature => 'Podpis';

  @override
  String get openpgpFingerprint => 'Prstni odtis';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID ključa $id';
  }

  @override
  String get openpgpSigned => 'Podpisano';

  @override
  String get openpgpProblem => 'Težava';

  @override
  String get openpgpAcceptance => 'Sprejetje';

  @override
  String get openpgpChangeAcceptance => 'Spremeni sprejetje …';

  @override
  String get openpgpCheckedFooter => 'Preverjeno v tej napravi z OpenPGP, združljivo s Thunderbirdom.';

  @override
  String get openpgpSummaryLocked =>
      'Vaš ključ je zaklenjen. Odklenite ga z geselsko frazo, da preberete to sporočilo.';

  @override
  String get openpgpSummaryNoSecretKey => 'Šifrirano je bilo za ključ, ki ga ni v tej napravi.';

  @override
  String get openpgpSummaryDamaged => 'Šifrirani podatki so poškodovani ali so bili med potjo spremenjeni.';

  @override
  String get openpgpSummaryUnsupported => 'Uporablja algoritem, ki ga Loupe ne podpira.';

  @override
  String get openpgpSummaryEncrypted => 'Preberete ga lahko samo vi in drugi prejemniki.';

  @override
  String get openpgpSummaryNotSigned => 'Ni podpisano, zato pošiljatelj ni potrjen.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Podpisano je, vendar s ključem, ki ga nimate, zato podpisa ni mogoče preveriti.';

  @override
  String get openpgpSummaryBadSignature => 'Podpis se ne ujema: sporočilo je bilo morda spremenjeno.';

  @override
  String get openpgpSummaryMismatch => 'Podpis je veljaven, vendar ključ pripada drugemu naslovu, ne pošiljateljevemu.';

  @override
  String get openpgpSummaryPartial =>
      'Podpisan je le del sporočila. Besedilo zunaj podpisa (na primer noga poštnega seznama) je prikazano pod vrstico „Unsigned content“, podpis pa ne zajema niti drugih delov sporočila, kot so priloge.';

  @override
  String get openpgpSummaryOwnKey => 'Podpisano z vašim lastnim ključem.';

  @override
  String get openpgpSummaryVerified => 'Podpis je veljaven in prstni odtis ključa ste preverili.';

  @override
  String get openpgpSummaryUnverified =>
      'Podpis je veljaven. Ključ ste sprejeli, ne da bi preverili njegov prstni odtis.';

  @override
  String get openpgpSummaryRejected => 'Podpis je veljaven, vendar ste ta ključ zavrnili.';

  @override
  String get openpgpSummaryUndecided =>
      'Podpis je veljaven, vendar tega ključa še niste sprejeli. Njegov prstni odtis primerjajte s pošiljateljem.';

  @override
  String get openpgpAcceptanceRejected => 'Zavrnjen';

  @override
  String get openpgpAcceptanceUndecided => 'Ni sprejet';

  @override
  String get openpgpAcceptanceUnverified => 'Sprejet';

  @override
  String get openpgpAcceptanceVerified => 'Sprejet in preverjen';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Sprejmete ključ osebe $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Prstni odtis $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Da, prstni odtis je preverjen';

  @override
  String get openpgpAcceptUnverified => 'Da, brez preverjanja';

  @override
  String get openpgpAcceptLater => 'Še ne';

  @override
  String get openpgpRejectKey => 'Zavrni ta ključ';

  @override
  String get openpgpNoSubject => '(brez zadeve)';

  @override
  String get openpgpEncryptionTitle => 'Šifriranje od konca do konca';

  @override
  String get openpgpMyKeys => 'Moji ključi OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'S ključem lahko berete šifrirano pošto ter podpisujete in šifrirate svojo. Uporabljate Thunderbird? Tam izvozite svoj ključ (Nastavitve računa › Šifriranje od konca do konca › Izvozi skrivni ključ) in ga uvozite sem.';

  @override
  String get openpgpAddKey => 'Dodaj ključ …';

  @override
  String get openpgpAddresses => 'Naslovi';

  @override
  String get openpgpAddressesFooter => 'Kateri ključ uporablja posamezen naslov ter kdaj šifrira in podpisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'Ključi OpenPGP dopisnikov';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Ključ sprejmite, ko zaupate, da pripada svojemu lastniku; prstni odtis primerjajte z lastnikom, da ga označite kot preverjenega.';

  @override
  String get openpgpImportPublicKey => 'Uvozi javni ključ …';

  @override
  String get openpgpCollected => 'Zbrano prek Autocrypta';

  @override
  String get openpgpCollectedFooter =>
      'Ključi, ki so prispeli s sporočili. Loupe lahko šifrira zanje, ko si to želita obe strani.';

  @override
  String get openpgpOnThisDevice => 'V tej napravi';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifrirana sporočila skrijejo svojo zadevo. Loupe zadevo vsakega sporočila, ki ga odprete, shrani v svojo šifrirano zbirko podatkov v tej napravi, da jo prikažejo seznam, iskanje in obvestila. V ozadju lahko Loupe dešifrira tudi zadeve novih sporočil s ključi brez geselske fraze; za to prenese vsako sporočilo (do 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Dešifriraj zadeve v ozadju';

  @override
  String get openpgpIndexFooter =>
      'Iskanje najde šifrirana sporočila po pošiljatelju, prejemnikih in zadevi. Ko je to vklopljeno, Loupe besedilo vsakega šifriranega sporočila, ki ga dešifrira, doda tudi v iskalni indeks v svoji šifrirani zbirki podatkov v tej napravi, zato jih iskanje najde tudi po besedilu. Izklop to besedilo odstrani iz indeksa.';

  @override
  String get openpgpIndexDecrypted => 'Indeksiraj dešifrirana sporočila za iskanje';

  @override
  String get openpgpPassphrases => 'Geselske fraze';

  @override
  String get openpgpPassphrasesFooter =>
      'Ključi OpenPGP in potrdila S/MIME, zaščiteni z geselsko frazo, se odklenejo, ko je treba. Brez možnosti „Zapomni si“ se dve minuti po vsaki uporabi znova zaklenejo.';

  @override
  String get openpgpRememberPassphrases => 'Zapomni si geselske fraze';

  @override
  String get openpgpRememberPassphrasesDetail => 'Dokler se Loupe ne zapre';

  @override
  String get openpgpLockKeysNow => 'Zakleni ključe zdaj';

  @override
  String get openpgpKeysLocked => 'Ključi so zaklenjeni.';

  @override
  String get openpgpKeyStateRevoked => 'preklican';

  @override
  String get openpgpKeyStateExpired => 'potekel';

  @override
  String get openpgpKeyStateNeverExpires => 'nikoli ne poteče';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'poteče $date';
  }

  @override
  String get openpgpNoKey => 'Ni ključa';

  @override
  String get openpgpAlwaysEncrypt => 'Vedno šifriraj';

  @override
  String get openpgpAddKeyTitle => 'Dodajte ključ OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Uvozite ključ, ki ga uporabljate v Thunderbirdu, ali ustvarite novega.';

  @override
  String get openpgpImportFromClipboard => 'Uvozi iz odložišča';

  @override
  String get openpgpImportFromFile => 'Uvozi iz datoteke';

  @override
  String get openpgpGenerateNewKey => 'Ustvari nov ključ';

  @override
  String get openpgpImportPublicKeyTitle => 'Uvozite javni ključ';

  @override
  String get openpgpFromClipboard => 'Iz odložišča';

  @override
  String get openpgpFromFile => 'Iz datoteke';

  @override
  String get openpgpClipboardEmpty => 'Odložišče je prazno. Najprej kopirajte ključ.';

  @override
  String get openpgpKey => 'Ključ';

  @override
  String get openpgpValidityRevoked => 'Preklican';

  @override
  String openpgpValidityExpired(String date) {
    return 'Potekel $date';
  }

  @override
  String get openpgpNeverExpires => 'Nikoli ne poteče';

  @override
  String openpgpValidUntil(String date) {
    return 'Velja do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Prstni odtis je kopiran.';

  @override
  String get openpgpAlgorithm => 'Algoritem';

  @override
  String get openpgpCreated => 'Ustvarjen';

  @override
  String get openpgpValidity => 'Veljavnost';

  @override
  String get openpgpProtection => 'Zaščita';

  @override
  String get openpgpProtectionPassphrase => 'Geselska fraza';

  @override
  String get openpgpProtectionKeychain => 'Samo shramba ključev';

  @override
  String get openpgpKeyDetailsFooter =>
      'Delite svoj javni ključ, da vam drugi lahko pošiljajo šifrirano pošto. Varnostna kopija je vaš skrivni ključ, zaščiten z geselsko frazo, če jo ima: hranite jo zasebno.';

  @override
  String get openpgpSharePublicKey => 'Deli javni ključ';

  @override
  String get openpgpCopyPublicKey => 'Kopiraj javni ključ';

  @override
  String get openpgpPublicKeyCopied => 'Javni ključ je kopiran.';

  @override
  String get openpgpBackUpSecretKey => 'Varnostno kopiraj skrivni ključ';

  @override
  String get openpgpDeleteKey => 'Izbriši ključ';

  @override
  String get openpgpRemoveKey => 'Odstrani ključ';

  @override
  String get openpgpBackUpTitle => 'Želite varnostno kopirati skrivni ključ?';

  @override
  String get openpgpBackUpProtected =>
      'Varnostna kopija je zaščitena z geselsko frazo vašega ključa. Kdor ima oboje, lahko bere vašo pošto.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ta ključ nima geselske fraze: kdor koli ima varnostno kopijo, lahko bere vašo pošto in se podpisuje kot vi.';

  @override
  String get openpgpBackUp => 'Varnostno kopiraj';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Želite izbrisati svoj ključ $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Želite odstraniti ključ osebe $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Pošte, šifrirane za ta ključ, v tej napravi ne bo več mogoče brati, razen če ga znova uvozite.';

  @override
  String get openpgpRemoveKeyMessage => 'Pozneje ga lahko znova uvozite.';

  @override
  String get openpgpKeyHeader => 'Ključ OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Za šifriranje in podpisovanje pošte s tega naslova dodajte ključ v razdelku Šifriranje od konca do konca.';

  @override
  String get openpgpGenerateAKey => 'Ustvari ključ …';

  @override
  String get openpgpSending => 'Pošiljanje';

  @override
  String get openpgpSendingFooter =>
      'Samodejno šifriranje se vklopi, ko ima vsak prejemnik sprejet ključ ali zaupanja vredno potrdilo ali ko Autocrypt sporoči, da si ga želita obe strani. Šifrirana pošta je vedno podpisana.';

  @override
  String get openpgpEncryptAutomatically => 'Šifriraj samodejno';

  @override
  String get openpgpAlwaysEncryptDetail => 'Ne pošlje, če kateri od prejemnikov nima ključa';

  @override
  String get openpgpSignUnencrypted => 'Podpisuj nešifrirano pošto';

  @override
  String get openpgpAttachPublicKey => 'Priloži moj javni ključ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt vaš javni ključ pošlje z vsakim sporočilom, zato vam druge aplikacije lahko pošiljajo šifrirano pošto brez kakršne koli nastavitve.';

  @override
  String get openpgpSendMyKey => 'Pošiljaj moj ključ s pošto';

  @override
  String get openpgpPreferEncryption => 'Daj prednost šifriranju';

  @override
  String get openpgpPreferEncryptionDetail => 'Prosi druge, naj šifrirajo, ko lahko';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count let',
      few: '$count leta',
      two: '$count leti',
      one: '$count leto',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Geselski frazi se ne ujemata.';

  @override
  String openpgpKeyReady(String id) {
    return 'Vaš ključ $id je pripravljen.';
  }

  @override
  String get openpgpNewKey => 'Nov ključ';

  @override
  String get openpgpNewKeyFor => 'Za';

  @override
  String get openpgpYourName => 'Vaše ime';

  @override
  String get openpgpAddress => 'Naslov';

  @override
  String get openpgpPassphrase => 'Geselska fraza';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Neobvezno. Brez nje ključ ščiti le shramba ključev v telefonu in Loupe nikoli ne vpraša. Z njo jo Loupe zahteva, ko potrebuje ključ.';

  @override
  String get openpgpRepeatPassphrase => 'Ponovite';

  @override
  String get openpgpExpires => 'Poteče';

  @override
  String get openpgpExpiresFooter =>
      'Preden ključ poteče, lahko ustvarite novega. Tudi Thunderbird uporablja tri leta.';

  @override
  String get openpgpGenerateKey => 'Ustvari ključ';

  @override
  String get openpgpKeyFor => 'Ključ za';

  @override
  String get openpgpCantEncrypt => 'Šifriranje ni mogoče';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Za $names ni ključa OpenPGP, ta naslov pa vedno šifrira. Odstranite prejemnika ali uvozite njegov ključ v Nastavitve › Šifriranje od konca do konca.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Za $names ni veljavnega potrdila S/MIME, ta naslov pa vedno šifrira. Odstranite prejemnika ali uvozite njegovo potrdilo v Nastavitve › Šifriranje od konca do konca.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Za $names ni ključa OpenPGP.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Za $names ni veljavnega potrdila S/MIME.';
  }

  @override
  String get openpgpSendUnencrypted => 'Pošlji nešifrirano';

  @override
  String get openpgpCantSign => 'Podpisovanje ni mogoče';

  @override
  String get openpgpCantSignMessage =>
      'Zasebnega ključa vašega potrdila S/MIME ni v tej napravi. Potrdilo (datoteko .p12 ali .pfx) znova uvozite v Nastavitve › Šifriranje od konca do konca.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Ni ključa za $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Ni potrdila za $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Ključi iz Autocrypta';

  @override
  String get openpgpComposeEveryoneHasKey => 'Vsi imajo ključ';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Vsi imajo potrdilo';

  @override
  String get openpgpComposeEncrypt => 'Šifriraj';

  @override
  String get openpgpComposeSign => 'Podpiši';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, preklopi';
  }

  @override
  String get openpgpNoKeyFound => 'Ključa OpenPGP ni bilo mogoče najti.';

  @override
  String get openpgpImportSecretKeyTitle => 'Želite uvoziti skrivni ključ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Ta priloga vsebuje skrivni ključ ($names). Kot svoj ključ ga uvozite le, če ste ga izvozili sami, na primer iz Thunderbirda.';
  }

  @override
  String get openpgpImportAsMyKey => 'Uvozi kot moj ključ';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'vaš ključ $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Želite uvoziti $count ključev ($names)?',
      few: 'Želite uvoziti $count ključe ($names)?',
      two: 'Želite uvoziti $count ključa ($names)?',
      one: 'Želite uvoziti $count ključ ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Uvozi in sprejmi';

  @override
  String get openpgpImportDecideLater => 'Uvozi, odloči pozneje';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'ključ osebe $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Uvoženo: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženih je $count ključev OpenPGP.',
      few: 'Priloženi so $count ključi OpenPGP.',
      two: 'Priložena sta $count ključa OpenPGP.',
      one: 'Priložen je $count ključ OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Uvozi';

  @override
  String get openpgpUnlockKeyTitle => 'Odkleni ključ OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Vnesite geselsko frazo za ključ $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Geselska fraza ni pravilna. Poskusite znova.';

  @override
  String get openpgpExplainLocked => 'To sporočilo je šifrirano. Za branje odklenite svoj ključ OpenPGP.';

  @override
  String get openpgpExplainNoKey =>
      'To sporočilo je šifrirano, vendar ne za noben ključ OpenPGP v tej napravi. Če ga berete v Thunderbirdu, od tam uvozite svoj ključ: Nastavitve › Šifriranje od konca do konca.';

  @override
  String get openpgpExplainDamaged => 'To šifrirano sporočilo je poškodovano, zato ga ni mogoče varno dešifrirati.';

  @override
  String get openpgpExplainUnsupported => 'To sporočilo uporablja šifriranje, ki ga Loupe še ne zna prebrati.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'To sporočilo je šifrirano s S/MIME, vendar ne za nobeno potrdilo v tej napravi. Svoje potrdilo (datoteko .p12 ali .pfx) uvozite v Nastavitve › Šifriranje od konca do konca.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'To sporočilo je šifrirano. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Za branje odklenite svoje potrdilo S/MIME.';

  @override
  String get openpgpAttachmentGone => 'Ta priloga ni več na voljo.';

  @override
  String get smimeEncrypted => 'Šifrirano (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifrirano (S/MIME) · ni potrdila';

  @override
  String get smimeEncryptedDamaged => 'Šifrirano (S/MIME) · poškodovano';

  @override
  String get smimeEncryptedUnsupported => 'Šifrirano (S/MIME) · ni podprto';

  @override
  String get smimeEncryptedLocked => 'Šifrirano (S/MIME) · zaklenjeno';

  @override
  String get smimeUnknownSigner => 'neznan';

  @override
  String get smimeSignatureModified => 'Neveljaven podpis: sporočilo je bilo spremenjeno';

  @override
  String get smimeSignatureWeak => 'Nevaren podpis: zastarel algoritem';

  @override
  String get smimeSignatureUncheckable => 'Podpisa ni mogoče preveriti';

  @override
  String get smimeSignedCertificateMissing => 'Podpisano · manjka potrdilo';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Podpisano: $name · potrdilo preklicano';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Podpisano: $name · na drug datum';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Podpisano: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Podpisano: $name · neveljavno potrdilo';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Podpisano: $name · ni zaupanja vredno';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Podpisano: $name · potrdilo je poteklo';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Podpisano: $name · potrdilo še ni veljavno';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Podpisano: $name · potrdilo ni za pošto';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Podpisano: $name, ne pošiljatelj';
  }

  @override
  String get smimeCantDecrypt => 'Tega sporočila ni mogoče dešifrirati';

  @override
  String get smimeEncryptedWithSmime => 'Šifrirano s S/MIME';

  @override
  String get smimeEncryption => 'Šifriranje';

  @override
  String get smimeDecryptedHere => 'Dešifrirano v tej napravi';

  @override
  String get smimeNotDecrypted => 'Ni dešifrirano';

  @override
  String get smimeAuthenticated => 'overjeno';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'za $count potrdil',
      few: 'za $count potrdila',
      two: 'za $count potrdili',
      one: 'za $count potrdilo',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Podpis';

  @override
  String get smimeIssuedBy => 'Izdajatelj';

  @override
  String get smimeValid => 'Veljavnost';

  @override
  String smimeValidRange(String from, String to) {
    return 'od $from do $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Prstni odtis SHA-256';

  @override
  String get smimeSigned => 'Podpisano';

  @override
  String get smimeProblem => 'Težava';

  @override
  String get smimeCheckingRevocation => 'Preverjanje preklica …';

  @override
  String get smimeNotRevoked => 'Ni preklicano';

  @override
  String get smimeRevoked => 'Preklicano';

  @override
  String get smimeRevocationUnknown => 'Preklic neznan';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Preverjeno pri overitelju (seznam preklicanih potrdil), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Preverjeno pri overitelju (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Zaupaj „$name“ …';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Zaupaj temu potrdilu …';

  @override
  String get smimeCheckedFooterRevocation =>
      'Preverjeno v tej napravi s S/MIME, združljivo z Outlookom in Thunderbirdom; preklic preverjen pri overitelju potrdil.';

  @override
  String get smimeCheckedFooter =>
      'Preverjeno v tej napravi s S/MIME, združljivo z Outlookom in Thunderbirdom. Preklic se ne preverja (Nastavitve › Šifriranje od konca do konca).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Želite zaupati overitelju $name za pošto?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Želite zaupati potrdilu osebe $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Zaupano bo vsakemu potrdilu, ki ga izda ta overitelj, kot na primer overitelju vašega podjetja. Najprej primerjajte prstni odtis z lastnikom:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Najprej primerjajte prstni odtis z lastnikom:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Zaupaj';

  @override
  String get smimeSummaryNoKey => 'Šifrirano je bilo za potrdilo, ki ga ni v tej napravi.';

  @override
  String get smimeSummaryDamaged => 'Šifrirani podatki so poškodovani ali so bili med potjo spremenjeni.';

  @override
  String get smimeSummaryUnsupported => 'Uporablja algoritem, ki ga Loupe ne podpira.';

  @override
  String get smimeSummaryLocked => 'Vaše potrdilo S/MIME je zaklenjeno.';

  @override
  String get smimeSummaryEncrypted => 'Preberete ga lahko samo vi in drugi prejemniki.';

  @override
  String get smimeSummaryNotSigned => 'Ni podpisano, zato pošiljatelj ni potrjen.';

  @override
  String get smimeSummaryModified => 'Podpis se ne ujema: sporočilo je bilo po podpisu spremenjeno.';

  @override
  String get smimeSummaryUncheckable => 'Podpisa ni mogoče preveriti.';

  @override
  String get smimeSummaryNoCertificate => 'Potrdila podpisnika ni v sporočilu, zato ga ni mogoče preveriti.';

  @override
  String get smimeSummaryRevoked => 'Overitelj je preklical potrdilo podpisnika: podpisu ni mogoče zaupati.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Overitelj je preklical potrdilo podpisnika ($reason): podpisu ni mogoče zaupati.';
  }

  @override
  String get smimeDateMismatch =>
      'Podpisano je bilo več kot uro pred datumom sporočila ali po njem: morda gre za staro sporočilo, poslano znova.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Podpis je veljaven in $issuer jamči, da potrdilo pripada pošiljatelju.';
  }

  @override
  String get smimeProblemInvalidChain => 'Potrdilo ali eden od njegovih izdajateljev ni veljaven.';

  @override
  String get smimeProblemUntrusted => 'Potrdilo prihaja od overitelja, ki mu Loupe ne zaupa.';

  @override
  String get smimeProblemExpired => 'Potrdilo je poteklo.';

  @override
  String get smimeProblemNotYetValid => 'Potrdilo še ni bilo veljavno.';

  @override
  String get smimeProblemWrongUsage => 'Potrdilo ni namenjeno za pošto.';

  @override
  String get smimeProblemWrongAddress => 'Potrdilo pripada drugemu naslovu, ne pošiljateljevemu.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Zaupanja vredno · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ni zaupanja vredno · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Poteklo $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Velja od $date';
  }

  @override
  String get smimeTrustInvalid => 'Neveljavno';

  @override
  String get smimeTrustNotForMail => 'Ni za pošto';

  @override
  String get smimeTrustAnotherAddress => 'Drug naslov';

  @override
  String get smimeMyCertificates => 'Moja potrdila S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Za S/MIME, kot ga uporabljajo Outlook in številna podjetja. Uvozite svoje potrdilo z zasebnim ključem (datoteko .p12 ali .pfx), izvoženo iz Outlooka, Windows, macOS ali Thunderbirda.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Za S/MIME, kot ga uporabljajo Outlook in številna podjetja. Uvozite svoje potrdilo z zasebnim ključem (datoteko .p12 ali .pfx), izvoženo iz Outlooka, Windows, macOS ali Thunderbirda, ali uporabite potrdilo, ki ste ga vi ali vaše podjetje namestili v to napravo.';

  @override
  String get smimeCertificateExpired => 'poteklo';

  @override
  String smimeCertificateUntil(String date) {
    return 'do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'v tej napravi';

  @override
  String get smimeImportCertificateEllipsis => 'Uvozi potrdilo …';

  @override
  String get smimeUseDeviceCertificate => 'Uporabi potrdilo iz te naprave …';

  @override
  String get smimeCorrespondentsCertificates => 'Potrdila dopisnikov';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Zbrana iz podpisane pošte, kot to počneta Outlook in Thunderbird. Pošta se šifrira le za zaupanja vredna potrdila: Loupe zaupa overiteljem, ki jim za e-pošto zaupa Mozilla, in tistim, ki jih dodate.';

  @override
  String get smimeRevocation => 'Preklic';

  @override
  String get smimeRevocationFooter =>
      'Ko odprete podpisano pošto, Loupe overitelja, ki je izdal potrdilo podpisnika, vpraša, ali ga je preklical (njegov odzivnik OCSP ali seznam preklicanih potrdil). Overitelj lahko tako vidi, kdaj nekdo z vašega internetnega naslova bere pošto, podpisano s tem potrdilom. Odgovori se hranijo v tej napravi, dokler ne potečejo. Preklicano potrdilo je v glavi sporočila prikazano kot „preklicano“.';

  @override
  String get smimeCheckRevocation => 'Preverjaj preklic potrdil prek spleta';

  @override
  String get smimeTrustedAuthorities => 'Zaupanja vredni overitelji';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Overitelji, ki jim zaupate vi, poleg $count, ki jim za e-pošto zaupa Mozilla.',
      few: 'Overitelji, ki jim zaupate vi, poleg $count, ki jim za e-pošto zaupa Mozilla.',
      two: 'Overitelji, ki jim zaupate vi, poleg $count, ki jima za e-pošto zaupa Mozilla.',
      one: 'Overitelji, ki jim zaupate vi, poleg $count, ki mu za e-pošto zaupa Mozilla.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Overitelj potrdil';

  @override
  String get smimeImportACertificate => 'Uvozite potrdilo';

  @override
  String get smimeImportContactMessage => 'Potrdilo dopisnika (.cer, .crt, .pem) ali overitelja potrdil.';

  @override
  String get smimeFromClipboard => 'Iz odložišča';

  @override
  String get smimeFromFile => 'Iz datoteke';

  @override
  String get smimeClipboardEmpty => 'Odložišče je prazno. Najprej kopirajte potrdilo.';

  @override
  String get smimeCertificate => 'Potrdilo';

  @override
  String get smimeOnDeviceFooter =>
      'Njegov zasebni ključ ostane v Androidovi shrambi poverilnic, kamor ste ga namestili vi ali vaše podjetje: Loupe prosi Android, naj z njim podpisuje in dešifrira. Podpisana pošta se podpiše ob pošiljanju.';

  @override
  String get smimeAddresses => 'Naslovi';

  @override
  String get smimeUsage => 'Namen';

  @override
  String get smimeUsageNone => 'Nič, kar uporablja Loupe';

  @override
  String get smimeUsageSigning => 'Podpisovanje';

  @override
  String get smimeUsageEncryption => 'Šifriranje';

  @override
  String get smimeUsageCertificates => 'Potrdila';

  @override
  String get smimeAlgorithm => 'Algoritem';

  @override
  String get smimeSerialNumber => 'Serijska številka';

  @override
  String get smimeFingerprintCopied => 'Prstni odtis je kopiran.';

  @override
  String get smimeSha1Thumbprint => 'Odtis SHA-1';

  @override
  String get smimePrivateKey => 'Zasebni ključ';

  @override
  String get smimeKeyOnDevice => 'V tej napravi';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'V aplikaciji Loupe, z geselsko frazo';

  @override
  String get smimeKeyInLoupe => 'V aplikaciji Loupe';

  @override
  String get smimeSource => 'Vir';

  @override
  String get smimeSourceSignedMail => 'Podpisana pošta';

  @override
  String get smimeSourceImported => 'Uvoženo';

  @override
  String get smimeTrustHeader => 'Zaupanje';

  @override
  String get smimeTrustedRoot => 'Zaupanja vreden korenski overitelj';

  @override
  String get smimeIssuer => 'Izdajatelj';

  @override
  String smimeTrustNamed(String name) {
    return 'Zaupaj „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Zaupaj temu overitelju';

  @override
  String get smimeTrustThisCertificate => 'Zaupaj temu potrdilu';

  @override
  String get smimeStopTrusting => 'Prenehaj zaupati';

  @override
  String get smimePassphrase => 'Geselska fraza';

  @override
  String get smimePassphraseFooter =>
      'Neobvezno. Z geselsko frazo je zasebni ključ v tej napravi tudi šifriran (Argon2id in AES-256), Loupe pa jo zahteva za podpisovanje in dešifriranje; kako dolgo, določa Zapomni si geselske fraze. Pošta, ki jo pošljete, se podpiše ob pošiljanju; opravila v ozadju ključa ne morejo uporabiti.';

  @override
  String get smimeChangePassphrase => 'Spremeni geselsko frazo …';

  @override
  String get smimeSetPassphraseEllipsis => 'Nastavi geselsko frazo …';

  @override
  String get smimeRemovePassphrase => 'Odstrani geselsko frazo';

  @override
  String get smimeShareCertificate => 'Deli potrdilo';

  @override
  String get smimeDeleteCertificate => 'Izbriši potrdilo';

  @override
  String get smimeRemoveCertificate => 'Odstrani potrdilo';

  @override
  String get smimePassphraseChanged => 'Geselska fraza je spremenjena.';

  @override
  String get smimePassphraseSet => 'Geselska fraza je nastavljena.';

  @override
  String get smimeRemovePassphraseTitle => 'Želite odstraniti geselsko frazo?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Zasebni ključ bo nato ščitila le shramba ključev, kot brez geselske fraze: Loupe po njej ne bo več spraševala, opravila v ozadju pa ga bodo lahko uporabljala.';

  @override
  String get smimePassphraseRemoved => 'Geselska fraza je odstranjena.';

  @override
  String smimeTrustTitle(String name) {
    return 'Želite zaupati „$name“?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Vsakemu potrdilu, ki ga izda, bo zaupano za pošto. Najprej primerjajte prstni odtis z lastnikom:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Želite izbrisati svoje potrdilo $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Želite odstraniti potrdilo osebe $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ga preneha uporabljati: pošte, šifrirane zanj, v aplikaciji Loupe ne bo več mogoče brati. Potrdilo ostane v tej napravi (Nastavitve › Varnost › Šifriranje in poverilnice).';

  @override
  String get smimeDeleteOwnMessage =>
      'Njegov zasebni ključ bo izbrisan iz te naprave: pošte, šifrirane zanj, tu ne bo več mogoče brati, razen če ga znova uvozite.';

  @override
  String get smimeRemoveContactMessage => 'Vrnilo se bo z njegovim naslednjim podpisanim sporočilom.';

  @override
  String get smimeAddressImportFooter =>
      'Uvozite potrdilo za ta naslov, da boste podpisovali in šifrirali s S/MIME, kot to počne Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Uvozi potrdilo …';

  @override
  String get smimePreferFooter =>
      'Ko bi sporočilo lahko zaščitila oba, se uporabi prednostni, razen če ima le drugi ključ ali potrdilo za vsakega prejemnika.';

  @override
  String get smimePreferSmime => 'Daj prednost S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Pred OpenPGP';

  @override
  String get smimeCertificatePassword => 'Geslo potrdila';

  @override
  String get smimeCertificatePasswordPrompt => 'Vnesite geslo, s katerim je bila izvožena datoteka potrdila.';

  @override
  String get smimeImport => 'Uvozi';

  @override
  String get smimeWrongPassword => 'Geslo ni pravilno. Poskusite znova.';

  @override
  String get smimeNoCertificateFound => 'Potrdila ni bilo mogoče najti.';

  @override
  String smimeCertificateOf(String name) {
    return 'potrdilo osebe $name';
  }

  @override
  String get smimeNothingNew => 'Ni ničesar novega za uvoz.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Uvoženo: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uvoženih je $count zaupanja vrednih overiteljev.',
      few: 'Uvoženi so $count zaupanja vredni overitelji.',
      two: 'Uvožena sta $count zaupanja vredna overitelja.',
      one: 'Uvožen je $count zaupanja vreden overitelj.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uvoženo: $certificates in $count zaupanja vrednih overiteljev.',
      few: 'Uvoženo: $certificates in $count zaupanja vredni overitelji.',
      two: 'Uvoženo: $certificates in $count zaupanja vredna overitelja.',
      one: 'Uvoženo: $certificates in $count zaupanja vreden overitelj.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Ta datoteka nima zasebnega ključa. Potrdilo izvozite skupaj z zasebnim ključem.';

  @override
  String get smimeImportAsYoursTitle => 'Želite uvoziti kot svoje potrdilo?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Ta priloga vsebuje potrdilo z zasebnim ključem: $names. Uvozite ga le, če ste ga izvozili sami, na primer iz Outlooka ali Thunderbirda.';
  }

  @override
  String get smimeImportAsMine => 'Uvozi kot moje potrdilo';

  @override
  String smimeImportedOwn(String names) {
    return 'Uvoženo je vaše potrdilo $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Vaše potrdilo $name ($addresses) je bilo dodano iz te naprave.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Želite zaupati „$name“ za pošto?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe tega overitelja potrdil ne pozna (morda gre za lastnega overitelja nekega podjetja). Zaupajte mu, da boste lahko preverjali potrdila, ki jih izdaja. Najprej primerjajte njegov prstni odtis s svojim oddelkom IT:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženih je $count potrdil.',
      few: 'Priložena so $count potrdila.',
      two: 'Priloženi sta $count potrdili.',
      one: 'Priloženo je $count potrdilo.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Uvozi potrdilo';

  @override
  String get smimeUnlockTitle => 'Odkleni potrdilo S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Vnesite geselsko frazo za potrdilo $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Geselska fraza ni pravilna. Poskusite znova.';

  @override
  String get smimeUnlock => 'Odkleni';

  @override
  String get smimeEnterAPassphrase => 'Vnesite geselsko frazo.';

  @override
  String get smimePassphrasesDiffer => 'Geselski frazi se razlikujeta.';

  @override
  String get smimeSetPassphraseTitle => 'Nastavi geselsko frazo';

  @override
  String get smimeSetPassphraseText =>
      'Loupe jo bo zahtevala za podpisovanje in dešifriranje. Če jo pozabite, znova uvozite potrdilo iz njegove datoteke .p12.';

  @override
  String get smimePassphraseAgain => 'Ponovno';

  @override
  String get smimeSetPassphraseButton => 'Nastavi';

  @override
  String get smimeLockedOpenAgain => 'Vaše potrdilo S/MIME je zaklenjeno. Za odklepanje znova odprite sporočilo.';

  @override
  String get smimeDeviceHasNoCertificates => 'Ta naprava ne ponuja svojih potrdil.';

  @override
  String get smimeCantReadCertificate => 'Loupe tega potrdila ne more prebrati.';

  @override
  String get smimeCertificateNotForMail =>
      'To potrdilo ni za pošto: nima e-poštnega naslova ali ni namenjeno podpisovanju ali šifriranju.';

  @override
  String get smimeDeviceCertificateGone =>
      'Potrdila ni več v tej napravi ali pa ga Loupe ne sme več uporabljati. Znova ga izberite v Nastavitve › Šifriranje od konca do konca.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Potrdilo v tej napravi je mogoče uporabiti le, ko je Loupe odprta.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifrirani ključ je poškodovan.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Potrdilo v tej napravi tega ne zmore: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'ni podprto';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Potrdilo v tej napravi ni uspelo: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Naslov overitelja ni spletni naslov.';

  @override
  String get smimeAuthorityTimeout => 'Overitelj potrdil ni pravočasno odgovoril.';

  @override
  String get smimeAuthorityUnreachable => 'Overitelj potrdil ni dosegljiv.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Overitelj potrdil je odgovoril s kodo $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odgovor overitelja potrdil je prevelik.';

  @override
  String get smimeRevocationNotChecked => 'Ni preverjeno: preverjajo se le potrdila overiteljev, ki jim Loupe zaupa.';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Enako kot v telefonu';

  @override
  String get settingsLanguageFooter =>
      'Loupe uporablja jezik vašega telefona, če ga ima, sicer pa angleščino. Jezik, ki ga izberete tukaj, velja samo za Loupe, vključno z obvestili.';

  @override
  String get settingsAccountsHeader => 'Računi';

  @override
  String get settingsAddAccount => 'Dodaj račun';

  @override
  String get settingsMailHeader => 'Pošta';

  @override
  String get settingsSwipeActions => 'Dejanja s podrsljaji';

  @override
  String get settingsSwipeLeft => 'Podrsljaj levo';

  @override
  String get settingsSwipeLeftFooter =>
      'Poln podrsljaj izvede to dejanje. Označi z zastavico in Več sta vedno na voljo s kratkim podrsljajem.';

  @override
  String get settingsSwipeRight => 'Podrsljaj desno';

  @override
  String get settingsSwipeRightFooter => 'Poln podrsljaj izvede to dejanje.';

  @override
  String get settingsSwipeToggleRead => 'Označi kot prebrano/neprebrano';

  @override
  String get settingsSwipeTrash => 'V smeti';

  @override
  String get settingsSwipeMove => 'Premakni sporočilo';

  @override
  String get settingsSwipeSnooze => 'Odloži';

  @override
  String get settingsThreaded => 'Razvrsti po pogovorih';

  @override
  String get settingsUndoSendDelay => 'Čas za preklic pošiljanja';

  @override
  String get settingsUndoSendDelayFooter => 'Poslana sporočila toliko časa počakajo, da jih lahko prekličete.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekund',
      few: '$seconds sekunde',
      two: '$seconds sekundi',
      one: '$seconds sekunda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Videz';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Samodejno';

  @override
  String get settingsThemeLight => 'Svetla';

  @override
  String get settingsThemeDark => 'Temna';

  @override
  String get settingsDensity => 'Seznam sporočil';

  @override
  String get settingsDensityComfortable => 'Prostoren';

  @override
  String get settingsDensityCompact => 'Kompakten';

  @override
  String get settingsReadingHeader => 'Branje';

  @override
  String get settingsReadingFooter => 'Oddaljene slike lahko pošiljateljem izdajo, kdaj in kje ste odprli sporočilo.';

  @override
  String get settingsDefaultView => 'Privzeti pogled';

  @override
  String get settingsDefaultViewFooter => 'Pogled katerega koli sporočila lahko preklopite z gumbom Aa.';

  @override
  String get settingsViewReadable => 'Berljivo';

  @override
  String get settingsViewReadableDetail => 'Čisto, berljivo, sledi temnemu načinu';

  @override
  String get settingsViewOriginal => 'Izvirno';

  @override
  String get settingsViewOriginalDetail => 'Natanko tako, kot ga je oblikoval pošiljatelj';

  @override
  String get settingsViewPlain => 'Navadno besedilo';

  @override
  String get settingsViewPlainDetail => 'Samo besede';

  @override
  String get settingsPlainTextFont => 'Pisava navadnega besedila';

  @override
  String get settingsFontSans => 'Brez serifov';

  @override
  String get settingsFontMono => 'Stalna širina';

  @override
  String get settingsFontMonoDetail => 'Ohrani poravnavo umetnosti ASCII in tabel';

  @override
  String get settingsTechnicalLists => 'Tehnični seznami';

  @override
  String get settingsLoadRemoteImages => 'Nalagaj oddaljene slike';

  @override
  String get settingsOpenLinksDirectly => 'Odpiraj povezave neposredno';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Preskoči sledenje klikom, ko je cilj znan';

  @override
  String get settingsSecurityHeader => 'Varnost';

  @override
  String get settingsAppLock => 'Zaklepanje aplikacije';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe vpraša ob zagonu in ko se vrnete po odsotnosti, daljši od časa v nastavitvi Zakleni po.';

  @override
  String get settingsAppLockFooterOff =>
      'Zaklepanje aplikacije pred prikazom pošte zahteva prstni odtis, obraz ali zaklepanje zaslona.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Zaklepanje aplikacije je še vedno izklopljeno. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Nastavite kodo';

  @override
  String get settingsScreenLockTextIos =>
      'Zaklepanje aplikacije uporablja Face ID, Touch ID ali kodo, ta iPhone pa nima kode. Nastavite jo v aplikaciji Nastavitve in nato vklopite zaklepanje aplikacije.';

  @override
  String get settingsScreenLockTitleAndroid => 'Nastavite zaklepanje zaslona';

  @override
  String get settingsScreenLockTextAndroid =>
      'Zaklepanje aplikacije uporablja zaklepanje zaslona telefona ali vanj dodan prstni odtis ali obraz, ta telefon pa ga nima. V nastavitvah Androida nastavite PIN, vzorec ali geslo in nato vklopite zaklepanje aplikacije.';

  @override
  String get settingsOpenSystemSettings => 'Odpri Nastavitve';

  @override
  String get settingsOpenAndroidSettings => 'Odpri nastavitve Androida';

  @override
  String get settingsLockAfter => 'Zakleni po';

  @override
  String get settingsLockAfterFooter => 'Kako dolgo je lahko Loupe v ozadju, preden znova vpraša.';

  @override
  String get settingsNotifications => 'Obvestila';

  @override
  String get settingsEncryption => 'Šifriranje od konca do konca';

  @override
  String get settingsAdvanced => 'Napredno';

  @override
  String get settingsDemoHeader => 'Predstavitev';

  @override
  String get settingsDemoFooter =>
      'Predstavitvena pošta je izmišljen nabiralnik, ki obstaja le v tem telefonu. Nič se ne pošilja nikamor.';

  @override
  String get settingsDemoMode => 'Predstavitveni način';

  @override
  String get settingsResetApp => 'Ponastavi aplikacijo';

  @override
  String get settingsResetFooter => 'Pozabi vse nastavitve in se vrne na pozdravni zaslon.';

  @override
  String get settingsResetTitle => 'Želite ponastaviti Loupe?';

  @override
  String get settingsResetMessage =>
      'Pozabljene bodo vse nastavitve, Smart Mailboxes in nedavna iskanja, aplikacija pa se vrne na pozdravni zaslon.';

  @override
  String get settingsAboutHeader => 'O aplikaciji';

  @override
  String get settingsVersion => 'Različica';

  @override
  String get settingsLicences => 'Licence';

  @override
  String get settingsPrivacy => 'Zasebnost';

  @override
  String get settingsPrivacyDetail => 'Loupe nima analitike ne sledenja. Vaša pošta gre samo na vaše poštne strežnike.';

  @override
  String get settingsNotificationsOffIos => 'Obvestila za Loupe so v Nastavitvah izklopljena.';

  @override
  String get settingsNotificationsOffAndroid => 'Obvestila za Loupe so v nastavitvah Androida izklopljena.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system aplikaciji Loupe ne dovoli prikazovati obvestil. Dovolite jih v Nastavitvah.';
  }

  @override
  String get settingsNewMailHeader => 'Nova pošta';

  @override
  String get settingsNewMailFooterDemo =>
      'Predstavitvena pošta v ozadju ne prihaja. Pošljite preizkusno obvestilo, da vidite, kako je videti nova pošta.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe preverja novo pošto v ozadju, ko to dovoli iOS, kar je lahko pri aplikacijah, ki jih redko odprete, v razmikih več ur. Obveščeni ste o novih sporočilih v mapah Prejeto in o sporočilih stikov VIP v kateri koli mapi.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe preverja novo pošto približno vsakih 15 minut, ko to dovoli Android. Obveščeni ste o novih sporočilih v mapah Prejeto in o sporočilih stikov VIP v kateri koli mapi.';

  @override
  String get settingsNoAccounts => 'Ni računov';

  @override
  String get settingsVipOnly => 'Samo VIP';

  @override
  String get settingsVipOnlyDetail => 'Samo sporočila vaših stikov VIP';

  @override
  String get settingsHideContent => 'Skrij vsebino';

  @override
  String get settingsHideContentFooterOn =>
      'Obvestila navedejo le „Novo sporočilo v računu“ in račun, ne pa, kdo je pisal ali o čem.';

  @override
  String get settingsHideContentFooterOff =>
      'Skrij vsebino skrije pošiljatelja, zadevo in predogled z zaklenjenega zaslona in iz obvestil.';

  @override
  String get settingsBackgroundAppRefresh => 'Osveževanje aplikacij v ozadju';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nova pošta v ozadju prihaja le, ko je za Loupe v Nastavitvah vklopljeno Osveževanje aplikacij v ozadju. iOS ne more ohranjati odprte povezave z mapami Prejeto, zato Takojšnje dostave ni.';

  @override
  String get settingsInstantDelivery => 'Takojšnja dostava';

  @override
  String get settingsInstantDeliveryFooter =>
      'Takojšnja dostava (preizkusno) ohranja odprto povezavo z mapami Prejeto, zato nova pošta prispe v nekaj sekundah. Prikaže tiho obvestilo „Spremljanje nove pošte“ in porabi več baterije.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android lahko Takojšnjo dostavo ustavi, da prihrani baterijo. Dovolite aplikaciji Loupe neomejeno porabo baterije, da bo dostava delovala naprej.';

  @override
  String get settingsExperimental => 'Preizkusno';

  @override
  String get settingsComingSoon => 'Kmalu';

  @override
  String get settingsAllowUnrestrictedBattery => 'Dovoli neomejeno porabo baterije';

  @override
  String get settingsPush => 'Potiskanje';

  @override
  String get settingsPushFooter =>
      'Potiskanje omogoča, da nova pošta takoj zbudi Loupe, če to vaša poštna storitev podpira. Potisna sporočila gredo prek Googlove storitve za potiskanje in ne vsebujejo pošte, le „preveri zdaj“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ta telefon ne more prejemati potisnih sporočil: potrebujejo storitve Google Play in omrežno povezavo. Loupe še vedno preverja pošto približno vsakih 15 minut.';

  @override
  String get settingsCopyPushToken => 'Kopiraj žeton za potiskanje';

  @override
  String get settingsPushTokenCopied => 'Žeton za potiskanje je kopiran';

  @override
  String get settingsSendTestNotification => 'Pošlji preizkusno obvestilo';

  @override
  String get settingsAppIconBadge => 'Značka na ikoni aplikacije';

  @override
  String get settingsBadgeNote => 'Značka se posodobi vsakič, ko Loupe preveri pošto, tudi v ozadju.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Domači zaslon tega telefona ne prikazuje številk na ikonah aplikacij. Značka se posodobi vsakič, ko Loupe preveri pošto, tudi v ozadju.';

  @override
  String get settingsTestNotificationBody => 'Obvestila o novi pošti so videti takole.';

  @override
  String get settingsAccountRemoved => 'Ta račun je bil odstranjen.';

  @override
  String get settingsAccountHeader => 'Račun';

  @override
  String get settingsAccountDescription => 'Opis';

  @override
  String get settingsAccountDescriptionHint => 'Služba, Osebno …';

  @override
  String get settingsEmail => 'E-pošta';

  @override
  String get settingsColour => 'Barva';

  @override
  String get settingsColourFooter => 'Označuje sporočila tega računa v pogledu Vsa prejeta pošta.';

  @override
  String settingsColourNumber(int number) {
    return 'Barva $number';
  }

  @override
  String get settingsSendingHeader => 'Pošiljanje';

  @override
  String get settingsSendingFooter =>
      'Vsaka identiteta ima svoj podpis. Odgovori se pošljejo z naslova, na katerega je bilo sporočilo poslano.';

  @override
  String get settingsFoldersHeader => 'Mape';

  @override
  String get settingsFoldersFooter =>
      'Loupe prikazuje in sinhronizira mape, na katere ste naročeni, tako kot Thunderbird. Prejeto, Osnutki, Poslano, Neželena pošta, Smeti in Arhiv so vedno prikazani.';

  @override
  String get settingsShowAllFolders => 'Pokaži vse mape';

  @override
  String get settingsIncoming => 'Dohodni strežnik';

  @override
  String get settingsOutgoing => 'Odhodni strežnik';

  @override
  String get settingsConnectionNotEncrypted => 'Nešifrirano';

  @override
  String get settingsSignIn => 'Prijava';

  @override
  String get settingsSignInExpired => 'Poteklo';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider ne sprejema več prijave aplikacije Loupe za ta račun, zato se njegova pošta ne sinhronizira. Za popravilo se znova prijavite.';
  }

  @override
  String get settingsSignInAgain => 'Znova se prijavi';

  @override
  String get settingsSigningIn => 'Prijavljanje …';

  @override
  String get settingsRemoveAccount => 'Odstrani račun';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Želite odstraniti „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Njegova pošta in nastavitve bodo odstranjene iz tega telefona. Na strežniku se nič ne izbriše.';

  @override
  String get settingsManageFolders => 'Upravljaj mape';

  @override
  String get settingsNoFolders => 'Še ni map.';

  @override
  String get settingsManageFoldersFooter =>
      'Naročene mape so prikazane na zaslonu Nabiralniki in se sinhronizirajo v ozadju. Druge poštne aplikacije z istim računom običajno upoštevajo te naročnine.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Hrani vaše Smart Mailboxes za druge naprave. Na zaslonu Nabiralniki je skrita.';

  @override
  String get settingsFolderAlwaysShown => 'Vedno prikazano';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Naroči se na $folder';
  }

  @override
  String get settingsIdentities => 'Identitete';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Prva identiteta je privzeta za nova sporočila. Za spremembo vrstnega reda jih povlecite.';

  @override
  String get settingsIdentitiesFooterSingle => 'Privzeta identiteta za nova sporočila.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odgovor se pošlje z identitete, na katero je bilo sporočilo poslano.';

  @override
  String get settingsIdentityDefault => 'Privzeto';

  @override
  String settingsIdentityReorder(String email) {
    return 'Prerazporedi $email';
  }

  @override
  String get settingsAddIdentity => 'Dodaj identiteto';

  @override
  String get settingsNewIdentity => 'Nova identiteta';

  @override
  String get settingsIdentity => 'Identiteta';

  @override
  String get settingsIdentityNameHint => 'Vaše ime';

  @override
  String get settingsReplyTo => 'Odgovor za';

  @override
  String get settingsSignature => 'Podpis';

  @override
  String get settingsSignatureFooter => 'Doda se pod „-- “ v sporočilih s te identitete.';

  @override
  String get settingsNoSignature => 'Brez podpisa';

  @override
  String get settingsCopyToMyself => 'Kopija zame';

  @override
  String get settingsCopyToMyselfFooter => 'Doda se vsakemu sporočilu s te identitete.';

  @override
  String get settingsCc => 'Kp';

  @override
  String get settingsBcc => 'Skp';

  @override
  String get settingsReplyPatterns => 'Uporabi za odgovore na';

  @override
  String get settingsReplyPatternsFooter =>
      'Odgovori na sporočila, poslana na te naslove, se pošljejo s te identitete. * pomeni kar koli: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Naslov ali vzorec, v katerem * pomeni kar koli.';

  @override
  String get settingsAddReplyPattern => 'Dodaj naslov ali vzorec';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Odstrani $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Neveljaven vzorec';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ ni naslov ali vzorec, kot je *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ni naslova';

  @override
  String get settingsIdentityNoAddressMessage => 'Vnesite e-poštni naslov, s katerega želite pošiljati.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Neveljaven naslov';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„$address“ v polju Odgovor za ni veljaven e-poštni naslov.',
      'cc': '„$address“ v polju Kp ni veljaven e-poštni naslov.',
      'bcc': '„$address“ v polju Skp ni veljaven e-poštni naslov.',
      'other': '„$address“ ni veljaven e-poštni naslov.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Shrani identiteto';

  @override
  String get settingsDiscardChanges => 'Zavrzi spremembe';

  @override
  String get settingsDeleteIdentity => 'Izbriši identiteto';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Želite izbrisati „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Sporočila, ki so bila z nje že poslana, ostanejo, kot so.';

  @override
  String get settingsLastIdentityFooter => 'Račun potrebuje vsaj eno identiteto.';

  @override
  String get rulesTitle => 'Pravila';

  @override
  String get rulesNewRule => 'Novo pravilo';

  @override
  String get rulesLoadError => 'Pravil ni bilo mogoče naložiti.';

  @override
  String get rulesEmptyTitle => 'Ni pravil';

  @override
  String get rulesEmptyText =>
      'Pravila za vas razvrščajo novo pošto ter ji dodajajo oznake in zastavice. Ustvarite ga z gumbom za pisanje zgoraj ali iz iskanja z „Ustvari pravilo iz tega“.';

  @override
  String get rulesListFooter =>
      'Pravila se za novo pošto v mapi Prejeto izvajajo od zgoraj navzdol. Pravilo premaknete tako, da se ga dotaknete in ga pridržite.';

  @override
  String get rulesChangeError => 'Pravila ni bilo mogoče spremeniti';

  @override
  String get rulesConditionEveryMessage => 'Vsako sporočilo';

  @override
  String rulesMoveRule(String rule) {
    return 'Premakni $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule vklopljeno';
  }

  @override
  String get rulesServerRulesHeader => 'Pravila na strežniku';

  @override
  String get rulesServerRulesFooter =>
      'Pravila na strežniku se izvajajo na poštnem strežniku ob prihodu pošte, tudi ko je ta telefon izklopljen. Shranjena so v skriptu Sieve z imenom „loupe“.';

  @override
  String get rulesStatusUnknown => 'Neznano';

  @override
  String get rulesStatusError => 'Strežnika ni bilo mogoče vprašati.';

  @override
  String get rulesStatusChecking => 'Preverjanje …';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Izvaja se iz skripta „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktiven je skript „$script“. Dotaknite se, da bo izvajal tudi pravila aplikacije Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na strežniku ni aktiven noben skript. Ko shranite pravilo na strežniku, se vklopi skript aplikacije Loupe.';

  @override
  String get rulesStatusUnavailable => 'Ni na voljo';

  @override
  String get rulesStatusNoSieve => 'Strežnik tega računa ne ponuja Sieve (ManageSieve ali JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Premakni v $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Premakni v mapo';

  @override
  String rulesActionTag(String tag) {
    return 'Dodaj oznako $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Odstrani oznako $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Obdrži v mapi Prejeto';

  @override
  String rulesActionForward(String address) {
    return 'Posreduj na $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Posreduj na $address, brez kopije';
  }

  @override
  String get rulesActionStop => 'Ustavi';

  @override
  String get rulesNoActions => 'Še ne naredi ničesar';

  @override
  String get rulesLocationDevice => 'Naprava';

  @override
  String get rulesLocationServer => 'Strežnik';

  @override
  String get rulesLocationThisDevice => 'Ta naprava';

  @override
  String get rulesNewRuleTitle => 'Novo pravilo';

  @override
  String get rulesEditRuleTitle => 'Uredi pravilo';

  @override
  String get rulesDefaultNameEveryMessage => 'Vsako sporočilo';

  @override
  String get rulesConditionHeader => 'Ko se novo sporočilo ujema';

  @override
  String get rulesConditionFooter =>
      'Napišite tako, kot bi iskali: from:, to:, s: (zadeva), b: (telo), tag:, has:attachment, larger:2M …';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:račun';

  @override
  String get rulesAccounts => 'Računi';

  @override
  String get rulesAllAccounts => 'Vsi računi';

  @override
  String get rulesRemovedAccount => 'Odstranjen račun';

  @override
  String get rulesAccountsFooter => 'Pravilo za vse račune velja tudi za račune, ki jih dodate pozneje.';

  @override
  String get rulesActionsHeader => 'Potem';

  @override
  String get rulesForwardingFooter =>
      'Posredovanje vsako ujemajoče se sporočilo ob prihodu pošlje na drug naslov, tudi ko je ta telefon izklopljen. Nekateri ponudniki omejujejo, koliko pošte je mogoče posredovati.';

  @override
  String get rulesForwardingHiddenFooter => 'Posredovanje deluje le v pravilih na strežniku, zato ga tu ni.';

  @override
  String rulesRemoveAction(String action) {
    return 'Odstrani $action';
  }

  @override
  String get rulesAddAction => 'Dodaj dejanje';

  @override
  String get rulesAddMove => 'Premakni v mapo …';

  @override
  String get rulesAddTagMenu => 'Dodaj oznako …';

  @override
  String get rulesRemoveTagMenu => 'Odstrani oznako …';

  @override
  String get rulesAddForward => 'Posreduj na …';

  @override
  String get rulesStopProcessing => 'Ustavi obdelavo nadaljnjih pravil';

  @override
  String get rulesRunOnHeader => 'Izvajaj na';

  @override
  String get rulesRunOnDeviceFooter =>
      'Ta naprava izvede pravilo za novo pošto v mapi Prejeto vsakič, ko Loupe preveri pošto.';

  @override
  String get rulesRunOnServerFooter =>
      'Poštni strežnik izvede pravilo ob prihodu pošte, tudi ko je ta telefon izklopljen. Potreben je Sieve prek ManageSieve (Dovecot, mailcow) ali JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Uporabi za obstoječa sporočila …';

  @override
  String get rulesDeleteRule => 'Izbriši pravilo';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Želite izbrisati „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mapa v katerem računu?';

  @override
  String get rulesMoveAccountMessage => 'Pošta drugih računov gre v tamkajšnjo mapo z enakim imenom.';

  @override
  String get rulesAddTag => 'Dodaj oznako';

  @override
  String get rulesRemoveTag => 'Odstrani oznako';

  @override
  String get rulesForwardTo => 'Posreduj na';

  @override
  String get rulesForwardToMessage =>
      'Strežnik vsako ujemajoče se sporočilo posreduje na ta naslov, tudi ko je ta telefon izklopljen. Uporabite naslov, ki je vaš ali mu zaupate.';

  @override
  String get rulesNotAnAddressTitle => 'Ni e-poštni naslov';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ ni naslov, na katerega bi lahko posredovali.';
  }

  @override
  String get rulesKeepCopyTitle => 'Želite obdržati kopijo tukaj?';

  @override
  String get rulesKeepCopy => 'Obdrži kopijo';

  @override
  String get rulesDontKeepCopy => 'Ne obdrži kopije';

  @override
  String get rulesCheckCondition => 'Preverite pogoj';

  @override
  String get rulesChooseActionTitle => 'Izberite dejanje';

  @override
  String get rulesChooseActionMessage => 'Dodajte, kaj naj pravilo naredi s sporočili, ki se z njim ujemajo.';

  @override
  String get rulesSaveError => 'Pravila ni bilo mogoče shraniti';

  @override
  String get rulesSaveServerError => 'Pravila na strežniku ni bilo mogoče shraniti';

  @override
  String get rulesRunOnDeviceInstead => 'Raje izvajaj v tej napravi';

  @override
  String get rulesNothingToApplyTitle => 'Ni česa uporabiti';

  @override
  String get rulesNothingToApplyMessage => 'Najprej pravilu določite delujoč pogoj in dejanje.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Uporabi „$rule“ za sporočila v …';
  }

  @override
  String get rulesApplyScopeInboxes => 'Mape Prejeto';

  @override
  String get rulesApplyScopeAll => 'Vsi nabiralniki';

  @override
  String get rulesFindingMessages => 'Iskanje sporočil …';

  @override
  String get rulesSearchError => 'Iskanje ni uspelo';

  @override
  String get rulesSearchErrorUnknown => 'Prišlo je do napake.';

  @override
  String get rulesNoMatchesTitle => 'Ni ujemajočih se sporočil';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nič tam se ne ujema s pogojem „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Želite uporabiti „$rule“ za $countString sporočil?',
      few: 'Želite uporabiti „$rule“ za $countString sporočila?',
      two: 'Želite uporabiti „$rule“ za $countString sporočili?',
      one: 'Želite uporabiti „$rule“ za $countString sporočilo?',
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
      other: 'Uporabi za $countString sporočil',
      few: 'Uporabi za $countString sporočila',
      two: 'Uporabi za $countString sporočili',
      one: 'Uporabi za $countString sporočilo',
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
      other: '„$rule“ uporabljeno za $countString sporočil',
      few: '„$rule“ uporabljeno za $countString sporočila',
      two: '„$rule“ uporabljeno za $countString sporočili',
      one: '„$rule“ uporabljeno za $countString sporočilo',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Preverjanje zmožnosti strežnika …';

  @override
  String get rulesServerUnreachable => 'Strežnik ni dosegljiv.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ni mogoče izvajati na strežniku: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ni mogoče izvajati na strežniku računa $account: $problem';
  }

  @override
  String get rulesShowScript => 'Pokaži skript';

  @override
  String get rulesHideScript => 'Skrij skript';

  @override
  String get rulesMatchingHeader => 'Ujemajoča se sporočila';

  @override
  String get rulesMatchingHeaderLoading => 'Ujemajoča se sporočila …';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ujemajočih se sporočil',
      few: '$countString ujemajoča se sporočila',
      two: '$countString ujemajoči se sporočili',
      one: '$countString ujemajoče se sporočilo',
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
      other: '$countString+ ujemajočih se sporočil',
      few: '$countString+ ujemajoča se sporočila',
      two: '$countString+ ujemajoči se sporočili',
      one: '$countString+ ujemajoče se sporočilo',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Iz zadnjih 30 dni. Pravilo samo deluje le na novo pošto, razen če ga uporabite za obstoječa sporočila.';

  @override
  String rulesConditionError(String error) {
    return 'Pogoj vsebuje napako: $error';
  }

  @override
  String get rulesPreviewNoSender => '(brez pošiljatelja)';

  @override
  String get rulesPreviewNoSubject => '(brez zadeve)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'in še $countString',
      few: 'in še $countString',
      two: 'in še $countString',
      one: 'in še $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nič iz zadnjih 30 dni.';

  @override
  String get rulesIncludeTitle => 'Vklopi pravila na strežniku';

  @override
  String get rulesIncludeLeaveOff => 'Pusti izklopljeno';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Strežnik že izvaja pravila aplikacije Loupe za $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ je aktivni skript na strežniku računa $account, zato strežnik izvaja njega in ne pravil aplikacije Loupe. Loupe ga ne bo zamenjala. Vanj lahko doda te vrstice, strežnik pa nato izvede pravila aplikacije Loupe po pravilih samega skripta:';
  }

  @override
  String get rulesShowWholeScript => 'Pokaži celoten skript';

  @override
  String get rulesHideWholeScript => 'Skrij celoten skript';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nič drugega v „$script“ se ne spremeni. Če njegove filtre pozneje urejate v spletni pošti, ga lahko spletna pošta prepiše brez teh vrstic; Loupe bo nato pravila na strežniku spet prikazala kot izklopljena.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Dodaj v „$script“';
  }

  @override
  String get subscriptionsTitle => 'Naročnine';

  @override
  String get subscriptionsNewsletters => 'E-novice';

  @override
  String get subscriptionsDiscussions => 'Razprave';

  @override
  String get subscriptionsFilter => 'Filtriraj';

  @override
  String get subscriptionsFilterNeverRead => 'Nikoli prebrano';

  @override
  String get subscriptionsFilterRarelyRead => 'Redko prebrano';

  @override
  String get subscriptionsFilterAll => 'Vse';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Naročnin ni bilo mogoče prešteti';

  @override
  String get subscriptionsNoMatches => 'Ni zadetkov';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nobena e-novica se ne imenuje „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Noben seznam se ne imenuje „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Ni e-novic';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'E-novice in druga množična pošta se bodo prikazale tukaj, ko prispejo.';

  @override
  String get subscriptionsNothingNeverRead => 'Ni nikoli prebranih';

  @override
  String get subscriptionsNothingRarelyRead => 'Ni redko prebranih';

  @override
  String get subscriptionsNothingFilteredDetail => 'Od vsega, kar prejmete, nekaj preberete.';

  @override
  String get subscriptionsNoDiscussions => 'Ni razprav';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Poštni seznami, na katere lahko pišete, se bodo prikazali tukaj, ko prispe njihova pošta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Seznami, na katere piše več ljudi. Seznam pridržite, da ga pripnete med Nabiralnike, ga berete kot navadno besedilo ali premaknete med E-novice.';

  @override
  String get subscriptionsPrivacyNote =>
      'Prešteto v tem telefonu iz prenesene pošte; za to se nič ne pošlje nikamor. Loupe pošiljatelja kontaktira le, ko se dotaknete Odjavi: odjava z enim klikom pošlje le „List-Unsubscribe=One-Click“ na naslov, ki ga je navedel pošiljatelj, brez piškotkov in brez česar koli drugega o vas, in nikoli ne naloži njegovih strani ali slik.';

  @override
  String get subscriptionsVolumeNone => 'V zadnjem času nič';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mesec';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mesec';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'prebrano $percent';
  }

  @override
  String get subscriptionsStillSending => 'Še vedno pošilja';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Odjavljeno $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Stran za odjavo odprta $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Z enim dotikom · stopi v stik s $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Po e-pošti na $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Na spletnem mestu $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Odjavi';

  @override
  String get subscriptionsUnsubscribeAgain => 'Znova odjavi';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhiviraj $countString sporočil iz mape Prejeto',
      few: 'Arhiviraj $countString sporočila iz mape Prejeto',
      two: 'Arhiviraj $countString sporočili iz mape Prejeto',
      one: 'Arhiviraj $countString sporočilo iz mape Prejeto',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Ustvari pravilo …';

  @override
  String get subscriptionsCreateRuleDetail => 'Premikaj ali arhiviraj njegovo prihodnjo pošto';

  @override
  String get subscriptionsTreatAsDiscussion => 'Obravnavaj kot razpravo';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Seznam, na katerega pišejo ljudje: berite ga kot forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Obravnavaj kot e-novico';

  @override
  String get subscriptionsBlockSender => 'Blokiraj pošiljatelja';

  @override
  String get subscriptionsBlock => 'Blokiraj';

  @override
  String get subscriptionsBlocked => 'Blokirano';

  @override
  String get subscriptionsBlockedDetail => 'Nova pošta gre med neželeno pošto';

  @override
  String get subscriptionsPin => 'Pripni med Nabiralnike';

  @override
  String get subscriptionsUnpin => 'Odpni iz Nabiralnikov';

  @override
  String get subscriptionsOpenDefaultView => 'Odpri v privzetem pogledu';

  @override
  String get subscriptionsOpenPlainText => 'Odpri kot navadno besedilo (stalna širina)';

  @override
  String get subscriptionsPinned => 'Pripeto';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString neprebranih',
      few: '$countString neprebrana',
      two: '$countString neprebrani',
      one: '$countString neprebrano',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Od tega pošiljatelja trenutno ni pošte.';

  @override
  String get subscriptionsLatestMessages => 'NAJNOVEJŠA SPOROČILA';

  @override
  String get subscriptionsMail => 'Pošta';

  @override
  String get subscriptionsNoneIn90Days => 'Nič v 90 dneh';

  @override
  String get subscriptionsRead => 'Prebrano';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString od $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Nazadnje prejeto';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Nahaja se v');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Še vedno pošilja';

  @override
  String get subscriptionsUnsubscribedTitle => 'Odjavljeno';

  @override
  String subscriptionsSince(String date) {
    return 'od $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'stran odprta $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender ne navaja, kako se odjaviti.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender ne navaja, kako se odjaviti. Namesto tega ga lahko blokirate.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Odjavljanje od $sender …';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Odjavljeni ste od $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Odjava ni uspela: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Samodejna odjava ni uspela';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Pošlji e-pošto za odjavo';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Odpri $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Želite odpreti $site?';
  }

  @override
  String get subscriptionsOpen => 'Odpri';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender odjavo izvede na svojem spletnem mestu. Stran se odpre v brskalniku aplikacije Loupe; tam jo dokončajte.';
  }

  @override
  String get subscriptionsWebInsecure => 'Povezava s tem spletnim mestom ni šifrirana.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Previdno: ta naslov s podobnimi črkami posnema $site.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Previdno: ta naslov s podobnimi črkami posnema drugo spletno mesto.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site ni bilo mogoče odpreti.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe si zabeleži današnji datum in vas obvesti, če bo od $sender še naprej prihajala pošta.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Se želite odjaviti od $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe bo zaradi odjave stopila v stik s $site.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'To je edini primer, ko Loupe stopi v stik s spletnim mestom pošiljatelja. Na naslov, ki ga navaja $sender, pošlje le „List-Unsubscribe=One-Click“, brez piškotkov ali česar koli drugega o vas, in strani ne naloži.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Povezava za odjavo ni varen naslov na internetu.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Spletno mesto $site ni pravočasno odgovorilo.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Spletno mesto $site ni dosegljivo.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Spletno mesto $site je zahtevo preusmerilo na drugo stran, ki ji Loupe ne sledi.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Spletno mesto $site je zahtevo zavrnilo (napaka $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Ni računa, s katerega bi poslali e-pošto za odjavo.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe bo poslala e-pošto na $to z naslova $from z zadevo „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-pošta za odjavo je bila poslana na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Želite blokirati $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nova pošta s tega seznama gre med neželeno pošto. To lahko spremenite v Nastavitve › Pravila.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nova pošta z naslova $address gre med neželeno pošto. To lahko spremenite v Nastavitve › Pravila.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Blokirano: $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Premakni $count sporočil med neželeno pošto',
      few: 'Premakni $count sporočila med neželeno pošto',
      two: 'Premakni $count sporočili med neželeno pošto',
      one: 'Premakni $count sporočilo med neželeno pošto',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokiraj $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender je zdaj med e-novicami.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender je zdaj med razpravami.';
  }

  @override
  String get appLiveGateTitle => 'Vaših računov ni bilo mogoče odpreti';

  @override
  String get appLiveGateUnavailableBuild => 'Pravi računi v tej različici še niso na voljo.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe ni mogla prebrati ključa, ki ščiti vašo pošto v tem telefonu. To je pogosto začasno: poskusite znova ali znova zaženite telefon.';

  @override
  String get appLiveGateKeyMissing =>
      'Ključ, ki ščiti vašo pošto v tem telefonu, je izginil, kar se lahko zgodi po obnovitvi varnostne kopije. Vaša pošta je še vedno na strežniku.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Zbirke podatkov pošte v tem telefonu ni mogoče prebrati: poškodovana je ali pa se je spremenil njen ključ. Vaša pošta je še vedno na strežniku.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Pri odpiranju vaših računov je prišlo do napake ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'S tem boste izbrisali svoje račune in pošto, shranjeno v tem telefonu, vključno s sporočili, ki čakajo v mapi Odhodna pošta. Pošta na vaših strežnikih ostane nedotaknjena; nato znova dodajte svoje račune.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Izbriši in začni znova';

  @override
  String get appLiveGateUseDemo => 'Uporabi predstavitveno pošto';

  @override
  String get appLiveGateReset => 'Ponastavi pošto v tem telefonu …';

  @override
  String get attachmentsUntitled => 'Priloga';

  @override
  String get attachmentsUntitledFile => 'Brez imena';

  @override
  String get attachmentsOpenIn => 'Odpri v …';

  @override
  String get attachmentsSaveToFiles => 'Shrani v datoteke';

  @override
  String get attachmentsShareMenu => 'Deli …';

  @override
  String get attachmentsDownloadError => 'Priloge ni bilo mogoče prenesti. Preverite povezavo in poskusite znova.';

  @override
  String get attachmentsShareError => 'Priloge ni bilo mogoče deliti.';

  @override
  String attachmentsNoApp(String type) {
    return 'V tej napravi ni aplikacije, ki bi odprla to datoteko ($type). Raje poskusite Deli.';
  }

  @override
  String get attachmentsOpenInError => 'Priloge ni bilo mogoče odpreti v drugi aplikaciji.';

  @override
  String attachmentsSaved(String name) {
    return 'Shranjeno: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Priloge ni bilo mogoče shraniti.';

  @override
  String get attachmentsGone => 'Ta priloga ni več na voljo.';

  @override
  String get attachmentsDownloadFailed => 'Priloge ni bilo mogoče prenesti.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strani',
      few: '$count strani',
      two: '$count strani',
      one: '$count stran',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size prek mobilnih podatkov';
  }

  @override
  String get attachmentsLargeDownload => 'Ta priloga je velika. Prenesite jo zdaj ali pozneje prek Wi-Fi-ja.';

  @override
  String get attachmentsDownload => 'Prenesi';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Prenašanje $size …';
  }

  @override
  String get attachmentsDownloading => 'Prenašanje …';

  @override
  String get attachmentsTooLarge => 'Preveliko za predogled tukaj.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Prikazanih je prvih $shown od $total. Za celotno vsebino kopirajte, delite ali shranite.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Tega PDF-ja ni mogoče prikazati tukaj (morda je zaščiten z geslom).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page od $count';
  }

  @override
  String get attachmentsModeTable => 'Tabela';

  @override
  String get attachmentsModeText => 'Besedilo';

  @override
  String get attachmentsModeMessage => 'Sporočilo';

  @override
  String get attachmentsModeSource => 'Izvorna koda';

  @override
  String get attachmentsDontWrap => 'Ne prelamljaj vrstic';

  @override
  String get attachmentsWrap => 'Prelomi vrstice';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines vrstic',
      few: '$lines vrstice',
      two: '$lines vrstici',
      one: '$count vrstica',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiraj vse';

  @override
  String get attachmentsCopied => 'Kopirano';

  @override
  String get attachmentsImageUnavailable => 'Te slike ni mogoče prikazati tukaj. Poskusite Odpri v …';

  @override
  String get attachmentsEmlNoSubject => '(Brez zadeve)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Za';

  @override
  String get attachmentsEmlCc => 'Kp';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'To sporočilo nima besedila.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prilog: $names',
      few: '$count priloge: $names',
      two: '$count prilogi: $names',
      one: '$count priloga: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizator: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In še $count dogodkov',
      few: 'In še $count dogodki',
      two: 'In še $count dogodka',
      one: 'In še $count dogodek',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Slika';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Slika $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Vrednosti, ločene s tabulatorji';

  @override
  String get attachmentsTypeCsv => 'Preglednica CSV';

  @override
  String get attachmentsTypeCalendar => 'Dogodek v koledarju';

  @override
  String get attachmentsTypeEmail => 'E-poštno sporočilo';

  @override
  String get attachmentsTypeContact => 'Vizitka';

  @override
  String get attachmentsTypeLog => 'Dnevniška datoteka';

  @override
  String get attachmentsTypeText => 'Besedilo';

  @override
  String get attachmentsTypeZip => 'Arhiv ZIP';

  @override
  String get attachmentsTypeArchive => 'Arhiv';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Preglednica Excel';

  @override
  String get attachmentsTypePowerPoint => 'Predstavitev PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Spletna stran';

  @override
  String get attachmentsTypeVideo => 'Videoposnetek';

  @override
  String get attachmentsTypeAudio => 'Zvočni posnetek';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Datoteka $extension';
  }

  @override
  String get attachmentsTypeFile => 'Datoteka';

  @override
  String get calendarUntitledEvent => 'Dogodek';

  @override
  String get calendarAllDay => 'Ves dan';

  @override
  String calendarYourTime(String time) {
    return '$time po vašem času';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Pridruži se: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name sprejema: $details',
      'tentative': '$name pogojno sprejema: $details',
      'declined': '$name zavrača: $details',
      'delegated': '$name delegira: $details',
      'other': '$name še ne odgovarja na: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name sprejema povabilo',
      'tentative': '$name pogojno sprejema povabilo',
      'declined': '$name zavrača povabilo',
      'delegated': '$name delegira povabilo',
      'other': '$name še ne odgovarja na povabilo',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Zemljevid';

  @override
  String get calendarJoin => 'Pridruži se';

  @override
  String get calendarOnlineMeeting => 'Spletni sestanek';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Sestanek $provider';
  }

  @override
  String get calendarOrganizerYou => 'Vi';

  @override
  String get calendarOrganizerLabel => 'organizator';

  @override
  String get calendarStatusAccepted => 'Sprejeto';

  @override
  String get calendarStatusMaybe => 'Morda';

  @override
  String get calendarStatusDeclined => 'Zavrnjeno';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: sprejeto',
      'tentative': '$name: pogojno sprejeto',
      'declined': '$name: zavrnjeno',
      'delegated': '$name: delegirano',
      'other': '$name: brez odgovora',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name sprejema:',
      'tentative': '$name pogojno sprejema:',
      'declined': '$name zavrača:',
      'delegated': '$name delegira:',
      'other': '$name še ne odgovarja:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name predlaga nov čas';
  }

  @override
  String get calendarCounterUnknown => 'Udeleženec predlaga nov čas';

  @override
  String get calendarDeclineCounter => 'Organizator je ohranil čas';

  @override
  String calendarRefresh(String name) {
    return '$name zahteva najnovejšo različico';
  }

  @override
  String get calendarRefreshUnknown => 'Udeleženec zahteva najnovejšo različico';

  @override
  String get calendarCancelled => 'Preklicano';

  @override
  String get calendarCancelledByOrganizer => 'Organizator je preklical ta dogodek.';

  @override
  String get calendarCancelledLater => 'Ta dogodek je bil pozneje preklican.';

  @override
  String get calendarOutdated => 'Zastarelo';

  @override
  String get calendarOutdatedDetail => 'To povabilo je bilo pozneje posodobljeno; velja novejše.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Lokacija odstranjena (prej $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Lokacija odstranjena (prej ni bila navedena)';

  @override
  String calendarLocationChanged(String location) {
    return 'Lokacija spremenjena v $location';
  }

  @override
  String get calendarNewTitle => 'Nov naslov';

  @override
  String get calendarRepeatChanged => 'Ponavljanje se je spremenilo';

  @override
  String get calendarUpdated => 'Posodobljeno';

  @override
  String get calendarUpdatedInvitation => 'Posodobljeno povabilo';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Čas spremenjen z $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Časovni pas „$zone“ ni znan: časi so prikazani, kot so zapisani';
  }

  @override
  String calendarNext(String when) {
    return 'Naslednji: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gostov',
      few: '$count gostje',
      two: '$count gosta',
      one: '$count gost',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'sprejeto: $count');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'morda: $count');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'zavrnjeno: $count');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (vi)';
  }

  @override
  String get calendarAttendeeOptional => 'neobvezno';

  @override
  String get calendarAttendeeRoom => 'prostor';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Starejšo različico ste sprejeli.',
      'tentative': 'Starejšo različico ste pogojno sprejeli.',
      'declined': 'Starejšo različico ste zavrnili.',
      'delegated': 'Starejšo različico ste delegirali.',
      'other': 'Na starejšo različico niste odgovorili.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Sprejmi';

  @override
  String get calendarMaybe => 'Morda';

  @override
  String get calendarDecline => 'Zavrni';

  @override
  String get calendarCommentHint => 'Komentar za organizatorja (neobvezno)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Vaš odgovor gre osebi $organizer z naslova $address.';
  }

  @override
  String get calendarAddComment => 'Dodaj komentar';

  @override
  String get calendarAddToCalendar => 'Dodaj v koledar';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In še $count dogodkov v datoteki',
      few: 'In še $count dogodki v datoteki',
      two: 'In še $count dogodka v datoteki',
      one: 'In še $count dogodek v datoteki',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Ni aplikacije za koledar, v katero bi lahko dodali dogodek.';

  @override
  String get calendarCantOpenCalendar => 'Koledarja ni bilo mogoče odpreti.';

  @override
  String get calendarCantOpenLink => 'Povezave ni bilo mogoče odpreti.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Se želite pridružiti sestanku $provider?';
  }

  @override
  String get calendarJoinTitle => 'Se želite pridružiti sestanku?';

  @override
  String calendarJoinOpens(String host) {
    return 'Odpre $host v brskalniku.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Previdno: ta naslov s podobnimi črkami posnema $site.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Previdno: ta naslov s podobnimi črkami posnema drugo spletno mesto.';

  @override
  String calendarJoinOpen(String host) {
    return 'Odpri $host';
  }

  @override
  String get calendarNoOrganizer => 'To povabilo nima organizatorja, ki bi mu lahko odgovorili.';

  @override
  String get calendarNoAccount => 'Ni računa, s katerega bi lahko odgovorili.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Sprejeto', 'tentative': 'Morda', 'other': 'Zavrnjeno'});
    return '$_temp0 · pošiljanje odgovora osebi $name …';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Sprejeto', 'tentative': 'Morda', 'other': 'Zavrnjeno'});
    return '$_temp0 · odgovor poslan';
  }

  @override
  String get calendarReplyAlreadySent => 'Odgovor je bil že poslan.';

  @override
  String get calendarReplyNotSent => 'Odgovor ni bil poslan.';

  @override
  String get dataSmimeNeedsDevice =>
      'Vaše potrdilo S/MIME je v tej napravi: odprite Loupe, da podpišete in pošljete to sporočilo.';

  @override
  String dataSigningFailed(String error) {
    return 'Podpisovanje ni uspelo: $error';
  }

  @override
  String get keyboardShortcuts => 'Bližnjice na tipkovnici';

  @override
  String get keyboardGroupGeneral => 'Splošno';

  @override
  String get keyboardGroupMessages => 'Sporočila';

  @override
  String get keyboardGroupCompose => 'Pisanje';

  @override
  String get keyboardCommandPalette => 'Paleta ukazov';

  @override
  String get keyboardBackClose => 'Nazaj, zapri';

  @override
  String get keyboardNextMessage => 'Naslednje sporočilo';

  @override
  String get keyboardPreviousMessage => 'Prejšnje sporočilo';

  @override
  String get keyboardOpenMessage => 'Odpri sporočilo';

  @override
  String get keyboardMoveToTrash => 'Premakni v smeti';

  @override
  String get keyboardToggleRead => 'Označi kot prebrano ali neprebrano';

  @override
  String get keyboardToggleFlag => 'Dodaj ali odstrani zastavico';

  @override
  String get keyboardCloseDraft => 'Zapri (shrani ali izbriši osnutek)';

  @override
  String get keyboardOr => 'ali';

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
  String get mailingListsMuted => 'Nit je utišana. Nova sporočila v njej prispejo kot prebrana.';

  @override
  String get mailingListsUnmuted => 'Utišanje niti je preklicano.';

  @override
  String get mailingListsMuteThread => 'Utišaj nit';

  @override
  String get mailingListsUnmuteThread => 'Prekliči utišanje niti';

  @override
  String get mailingListsPin => 'Pripni med Nabiralnike';

  @override
  String get mailingListsUnpin => 'Odpni iz Nabiralnikov';

  @override
  String get mailingListsDefaultView => 'Odpri v privzetem pogledu';

  @override
  String get mailingListsPlainText => 'Odpri kot navadno besedilo (stalna širina)';

  @override
  String get mailingListsShowMuted => 'Pokaži utišane niti';

  @override
  String get mailingListsHideMuted => 'Skrij utišane niti';

  @override
  String get mailingListsTreatAsNewsletter => 'Obravnavaj kot e-novico';

  @override
  String get mailingListsOptions => 'Možnosti seznama';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted neprebranih',
      few: '$formatted neprebrana',
      two: '$formatted neprebrani',
      one: '$count neprebrano',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Novo sporočilo na seznam';

  @override
  String get mailingListsRowUnread => 'Neprebrano';

  @override
  String get mailingListsRowMuted => 'Utišano';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odgovorov',
      few: '$count odgovori',
      two: '$count odgovora',
      one: '$count odgovor',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Ni niti';

  @override
  String get mailingListsMutedHidden => 'Utišane niti so skrite.';

  @override
  String get mailingListsTechnicalTitle => 'Tehnični seznami';

  @override
  String get mailingListsTechnicalEmpty => 'Poštni seznami se bodo prikazali tukaj, ko prispe njihova pošta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Sporočila s teh seznamov se odprejo kot navadno besedilo v pisavi stalne širine, popravki pa so prikazani kot razlike. Gumb Aa še vedno preklopi pogled katerega koli sporočila.';

  @override
  String get paletteMoveToMailbox => 'Premakni v nabiralnik …';

  @override
  String get paletteMarkAllRead => 'Označi vse kot prebrano';

  @override
  String get paletteExportFolder => 'Izvozi mapo …';

  @override
  String get paletteGetNewMail => 'Prejmi novo pošto';

  @override
  String get paletteSnoozed => 'Odloženo';

  @override
  String get paletteSubscriptions => 'Naročnine';

  @override
  String get paletteDiscussions => 'Razprave';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Poštni seznam';

  @override
  String get paletteTag => 'Oznaka';

  @override
  String get paletteSwipeActions => 'Dejanja s podrsljaji';

  @override
  String get paletteNotifications => 'Obvestila';

  @override
  String get paletteRules => 'Pravila';

  @override
  String get paletteEncryption => 'Šifriranje od konca do konca';

  @override
  String get paletteAdvanced => 'Napredno';

  @override
  String get paletteAddAccount => 'Dodaj račun';

  @override
  String get paletteAccount => 'Račun';

  @override
  String get paletteFolders => 'Mape';

  @override
  String get paletteRecentSearch => 'Nedavno iskanje';

  @override
  String paletteSearchMail(String query) {
    return 'Išči „$query“ v pošti';
  }

  @override
  String get palettePlaceholder => 'Išči dejanja, nabiralnike, nastavitve';

  @override
  String get paletteNothingFound => 'Ni zadetkov';

  @override
  String get searchNewSmartMailbox => 'Nov Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Prikaže vse, kar se ujema s „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ shranjeno med Nabiralnike';
  }

  @override
  String get searchMakeRule => 'Ustvari pravilo iz tega';

  @override
  String get searchSaveSmartMailbox => 'Shrani kot Smart Mailbox';

  @override
  String get searchNegate => 'Zanikaj';

  @override
  String get searchDontNegate => 'Ne zanikaj';

  @override
  String get searchAllMailboxes => 'Vsi nabiralniki';

  @override
  String get searchRecent => 'Nedavna iskanja';

  @override
  String get searchClear => 'Počisti';

  @override
  String get searchSuggestions => 'Predlogi';

  @override
  String get searchUnreadMessages => 'Neprebrana sporočila';

  @override
  String get searchFlaggedMessages => 'Sporočila z zastavico';

  @override
  String get searchWithAttachments => 'Sporočila s prilogami';

  @override
  String get searchUnrepliedMessages => 'Neodgovorjena sporočila';

  @override
  String get searchTags => 'Oznake';

  @override
  String get searchPeople => 'Osebe';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Od: $name';
  }

  @override
  String get searchSearching => 'Iskanje …';

  @override
  String get searchNoResults => 'Ni rezultatov';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted rezultatov',
      few: '$formatted rezultati',
      two: '$formatted rezultata',
      one: '$count rezultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Meni iskanja';

  @override
  String searchSearchingAccount(String account) {
    return 'Iskanje v računu $account na strežniku …';
  }

  @override
  String get searchSearchingUnknownAccount => 'Iskanje v računu na strežniku …';

  @override
  String searchAccountFailed(String account) {
    return 'Iskanje v računu $account na strežniku ni uspelo';
  }

  @override
  String get searchUnknownAccountFailed => 'Iskanje v računu na strežniku ni uspelo';

  @override
  String searchChip(String term) {
    return '$term. Dvakrat se dotaknite za urejanje.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ne $term. Dvakrat se dotaknite za urejanje.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerjev nabiralnik: vsako sporočilo tukaj je prebrano in neprebrano, dokler ga ne odprete.';

  @override
  String searchContradiction(String term) {
    return 'Nobeno sporočilo ne more biti hkrati „$term“ in ne.';
  }

  @override
  String get searchSyncDeviceOnly => 'Samo v tej napravi';

  @override
  String searchSyncUnsupported(String account) {
    return 'Samo v tej napravi: $account ga ne more hraniti';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Ni sinhronizirano: $account ima novejšo obliko';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Čaka na sinhronizacijo z računom $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinhronizirano z računom $account';
  }

  @override
  String get searchRename => 'Preimenuj';

  @override
  String get searchEditSearch => 'Uredi iskanje';

  @override
  String get searchDeleteSmartMailbox => 'Izbriši Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Preimenuj Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Ta Smart Mailbox je bil izbrisan.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes ostanejo v tej napravi.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes so shranjeni na vašem poštnem strežniku, zato jih imajo tudi vaše druge naprave in Thunderbird z dodatkom Expression Search Reloaded. Tisti, ki iščejo po vseh računih, so shranjeni v računu $account; tisti za eno mapo pa v računu te mape.';
  }

  @override
  String get searchSyncVia => 'Sinhroniziraj prek';

  @override
  String get searchSyncViaFooter => 'Na vsaki napravi izberite isti račun.';

  @override
  String get searchGmailCantKeep => 'Gmail ne more hraniti Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Smart Mailboxes hrani samo v tej napravi';

  @override
  String get searchOnTheServer => 'Na strežniku';

  @override
  String get searchServerFooter =>
      'Metapodatki strežnika (IMAP METADATA) niso prikazani v nobeni poštni aplikaciji. Strežniki brez njih dobijo mapo „Loupe Settings“ z enim sporočilom; Loupe jo skrije iz Nabiralnikov.';

  @override
  String get searchSyncNow => 'Sinhroniziraj zdaj';

  @override
  String get searchStateUnsupported => 'Ni podprto';

  @override
  String get searchStateNewerFormat => 'Novejša oblika';

  @override
  String get searchStateFailed => 'Sinhronizacija ni uspela';

  @override
  String get searchStateSyncing => 'Sinhroniziranje …';

  @override
  String get searchStateWaiting => 'V čakanju';

  @override
  String get searchStateMetadata => 'Metapodatki strežnika';

  @override
  String get searchStateFolder => 'Mapa Loupe Settings';

  @override
  String get searchStateNothing => 'Nič ni shranjeno';

  @override
  String get sharedBack => 'Nazaj';

  @override
  String get sharedYesterday => 'Včeraj';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date ob $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bajtov',
      few: '$count bajti',
      two: '$count bajta',
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
  String get sharedSyncNoAccounts => 'Ni računov';

  @override
  String get sharedSyncChecking => 'Preverjanje pošte …';

  @override
  String get sharedSyncFailed => 'Preverjanje pošte ni uspelo';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Brez povezave';

  @override
  String get sharedSyncJustNow => 'Posodobljeno pravkar';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Posodobljeno pred $minutes minutami',
      few: 'Posodobljeno pred $minutes minutami',
      two: 'Posodobljeno pred $minutes minutama',
      one: 'Posodobljeno pred $minutes minuto',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Posodobljeno ob $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Posodobljeno $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Vsa prejeta pošta';

  @override
  String get sharedMailboxUnread => 'Neprebrano';

  @override
  String get sharedMailboxFlagged => 'Z zastavico';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Vsi osnutki';

  @override
  String get sharedMailboxAllSent => 'Vse poslano';

  @override
  String get sharedMailboxUntitled => 'Nabiralnik';

  @override
  String get sharedTagImportant => 'Pomembno';

  @override
  String get sharedTagWork => 'Služba';

  @override
  String get sharedTagPersonal => 'Osebno';

  @override
  String get sharedTagToDo => 'Za narediti';

  @override
  String get sharedTagLater => 'Pozneje';

  @override
  String get sharedTags => 'Oznake';

  @override
  String get sharedMoveTo => 'Premakni v …';

  @override
  String get sharedNoRecipients => 'Ni prejemnikov';

  @override
  String get sharedUnknownSender => 'Neznan pošiljatelj';

  @override
  String get sharedOnServer => 'Na strežniku';

  @override
  String get sharedAttachment => 'Priloga';

  @override
  String get sharedSnoozedBadge => 'Odloženo';

  @override
  String get sharedRowUnread => 'Neprebrano';

  @override
  String get sharedRowBackFromSnooze => 'Vrnjeno iz odloga';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Z zastavico';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhiviranih je $count sporočil',
      few: 'Arhivirana so $count sporočila',
      two: 'Arhivirani sta $count sporočili',
      one: 'Arhivirano je $count sporočilo',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Izbrisanih je $count sporočil',
      few: 'Izbrisana so $count sporočila',
      two: 'Izbrisani sta $count sporočili',
      one: 'Izbrisano je $count sporočilo',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil premaknjenih v mapo Prejeto',
      few: '$count sporočila premaknjena v mapo Prejeto',
      two: '$count sporočili premaknjeni v mapo Prejeto',
      one: '$count sporočilo premaknjeno v mapo Prejeto',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil premaknjenih v smeti',
      few: '$count sporočila premaknjena v smeti',
      two: '$count sporočili premaknjeni v smeti',
      one: '$count sporočilo premaknjeno v smeti',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil premaknjenih med neželeno pošto',
      few: '$count sporočila premaknjena med neželeno pošto',
      two: '$count sporočili premaknjeni med neželeno pošto',
      one: '$count sporočilo premaknjeno med neželeno pošto',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil premaknjenih v mapo $mailbox',
      few: '$count sporočila premaknjena v mapo $mailbox',
      two: '$count sporočili premaknjeni v mapo $mailbox',
      one: '$count sporočilo premaknjeno v mapo $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil premaknjenih v nabiralnik',
      few: '$count sporočila premaknjena v nabiralnik',
      two: '$count sporočili premaknjeni v nabiralnik',
      one: '$count sporočilo premaknjeno v nabiralnik',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sporočil odloženih do $time',
      few: '$count sporočila odložena do $time',
      two: '$count sporočili odloženi do $time',
      one: '$count sporočilo odloženo do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odloženo do $time samo v tej napravi: strežnik ne more shraniti časov odloga.';
  }

  @override
  String get sharedMoveOneAccount => 'Za premik izberite sporočila iz enega računa.';

  @override
  String get sharedSnoozeTitle => 'Odloži';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Spremeni čas odloga';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Želite trajno izbrisati $count sporočil?',
      few: 'Želite trajno izbrisati $count sporočila?',
      two: 'Želite trajno izbrisati $count sporočili?',
      one: 'Želite trajno izbrisati $count sporočilo?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Tega ni mogoče razveljaviti.';

  @override
  String get sharedDeletePermanently => 'Trajno izbriši';

  @override
  String get sharedSwipeRead => 'Prebrano';

  @override
  String get sharedSwipeUnread => 'Neprebrano';

  @override
  String get sharedSwipeInbox => 'Prejeto';

  @override
  String get sharedSwipeDelete => 'Izbriši';

  @override
  String get sharedTrash => 'V smeti';

  @override
  String get sharedSwipeSnooze => 'Odloži';

  @override
  String get sharedWakeNow => 'Vrni zdaj';

  @override
  String get sharedChangeSnoozeTime => 'Spremeni čas odloga …';

  @override
  String get sharedSnooze => 'Odloži …';

  @override
  String get sharedTag => 'Oznake …';

  @override
  String get sharedMoveMessage => 'Premakni sporočilo …';

  @override
  String get sharedNotJunk => 'Ni neželeno';

  @override
  String get accountSetupTitle => 'Dodaj račun';

  @override
  String get accountSetupTitleDone => 'Račun je dodan';

  @override
  String get accountSetupAddressTitle => 'Dodajte poštni račun';

  @override
  String get accountSetupAddressText => 'Loupe najde nastavitve za večino ponudnikov.';

  @override
  String get accountSetupNameHint => 'Vaše ime';

  @override
  String get accountSetupEmail => 'E-pošta';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Nadaljuj';

  @override
  String get accountSetupLookingUp => 'Iskanje nastavitev …';

  @override
  String get accountSetupImport => 'Uvozi iz Thunderbirda';

  @override
  String get accountSetupInvalidEmail => 'Vnesite veljaven e-poštni naslov.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nastavitev za $domain ni bilo mogoče najti. Vnesite jih spodaj.';
  }

  @override
  String get accountSetupCheckServers => 'Preverite imena strežnikov in vrata.';

  @override
  String get accountSetupEnterPassword => 'Vnesite geslo.';

  @override
  String get accountSetupConnecting => 'Povezovanje …';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Čakanje na $provider …';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Strani ni bilo mogoče odpreti.';

  @override
  String get accountSetupCouldNotSaveName => 'Imena ni bilo mogoče shraniti.';

  @override
  String get accountSetupTrustCertificate => 'Zaupaj temu potrdilu';

  @override
  String get accountSetupPasswordRequired => 'Obvezno';

  @override
  String get accountSetupShowPassword => 'Pokaži geslo';

  @override
  String get accountSetupHidePassword => 'Skrij geslo';

  @override
  String get accountSetupAppPassword => 'Geslo za aplikacijo';

  @override
  String get accountSetupApiToken => 'Žeton API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Dohodni strežnik · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Odhodni strežnik · SMTP';

  @override
  String get accountSetupSignIn => 'Prijavi se';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Prijava z računom $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Uporabi geslo za aplikacijo';

  @override
  String get accountSetupUseAppPasswordInstead => 'Raje uporabi geslo za aplikacijo';

  @override
  String get accountSetupUseDifferentAddress => 'Uporabi drug naslov';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kako ustvariti geslo za aplikacijo';

  @override
  String get accountSetupHowToCreateOne => 'Navodila za ustvarjanje';

  @override
  String get accountSetupGoogleNote =>
      'Prijavite se na Googlovi strani in Loupe vašega gesla nikoli ne vidi. Aplikaciji Loupe dovolite branje, pošiljanje in urejanje vaše pošte.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Prijava z računom Google“ v tej različici še ni na voljo. Namesto tega se lahko povežete z geslom za aplikacijo (zahteva preverjanje v dveh korakih v vašem Google Računu).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'V svojem Google Računu ustvarite geslo za aplikacijo in ga prilepite spodaj.';

  @override
  String get accountSetupMicrosoftNote =>
      'Prijavite se na Microsoftovi strani in Loupe vašega gesla nikoli ne vidi. To deluje za Outlook.com in Hotmail ter za službene ali šolske račune v Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Prijava z Microsoftom bo na voljo v poznejši različici. Računi Outlook, Hotmail in Microsoft 365 jo potrebujejo: ne sprejemajo več gesel iz poštnih aplikacij.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail zahteva geslo za določeno aplikacijo, ne gesla vašega Apple računa.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail zahteva geslo za aplikacijo, ne gesla računa.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se s Fastmailom poveže prek JMAP z žetonom API: Settings › Privacy & Security › Manage API tokens, za JMAP, z dostopom do e-pošte in pošiljanja.';

  @override
  String get accountSetupFastmailNote => 'Fastmail za poštne aplikacije zahteva geslo za aplikacijo.';

  @override
  String get accountSetupServerSettings => 'Nastavitve strežnika';

  @override
  String get accountSetupSettingsNotFound => 'Niso bile najdene samodejno';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Najdeno prek $source';
  }

  @override
  String get accountSetupEditSettings => 'Uredi nastavitve';

  @override
  String get accountSetupSyncing => 'Vaša pošta se sinhronizira.';

  @override
  String get accountSetupDescription => 'Opis';

  @override
  String get accountSetupDescriptionHint => 'Služba, Osebno …';

  @override
  String get accountSetupColour => 'Barva';

  @override
  String accountSetupColourNumber(int number) {
    return 'Barva $number';
  }

  @override
  String get accountSetupSaving => 'Shranjevanje …';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe ni mogla odpreti svoje zbirke podatkov pošte v tem telefonu. Zaprite Loupe, jo znova odprite in poskusite znova.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Prišlo je do napake ($error). Poskusite znova.';
  }

  @override
  String get accountSetupSecurityNone => 'Brez';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Vrata';

  @override
  String get accountSetupSecurity => 'Varnost';

  @override
  String get accountSetupUsername => 'Uporabniško ime';

  @override
  String get accountSetupUsernameHint => 'Vaš e-poštni naslov';

  @override
  String get accountSetupNoEncryptionTitle => 'Se želite povezati brez šifriranja?';

  @override
  String get accountSetupNoEncryptionText =>
      'Vaše geslo in vsako sporočilo bi potovali kot navadno besedilo. Kdor koli v omrežju, na primer v javnem Wi-Fi-ju, bi jih lahko prebral. To uporabite le za strežnik v lastnem omrežju.';

  @override
  String get accountSetupUseWithoutEncryption => 'Uporabi brez šifriranja';

  @override
  String get accountSetupApiTokenRejected =>
      'Žeton API je bil zavrnjen. Ustvarite žeton API Fastmail za JMAP z dostopom do e-pošte in ga prilepite.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Geslo je bilo zavrnjeno. Uporabite geslo za aplikacijo, ne gesla računa.';

  @override
  String get accountSetupPasswordRejected => 'Geslo je bilo zavrnjeno. Preverite ga in poskusite znova.';

  @override
  String get accountSetupServerUnreachable => 'Strežnik ni dosegljiv. Preverite nastavitve strežnika in povezavo.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Potrdilo strežnika ni zaupanja vredno. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Prijava je bila preklicana. Za ponoven poskus se dotaknite „Prijava z računom $provider“.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe potrebuje dovoljenje za branje in pošiljanje vaše pošte Gmail. Znova se prijavite in dovolite dostop z obkljukanim poljem Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe potrebuje dovoljenje za branje in pošiljanje vaše pošte. Znova se prijavite in sprejmite dovoljenja.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Vaša organizacija mora odobriti Loupe, preden jo lahko uporabljate s tem računom. Skrbnika IT prosite, naj za Loupe v Microsoft Entra ID odobri skrbniško soglasje, nato poskusite znova.';

  @override
  String get accountSetupOAuthBlocked =>
      'Pravila prijave vaše organizacije ne dovoljujejo aplikacije Loupe v tej napravi. Obrnite se na skrbnika IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider ni dosegljiv. Preverite internetno povezavo in poskusite znova.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Prijava z računom $provider v tej različici aplikacije Loupe ni pravilno nastavljena. Prosimo, prijavite to.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Prijava z računom $provider ni uspela. Poskusite znova.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider vas je prijavil, vendar je Gmail zavrnil dostop za ta naslov. Ob prijavi izberite isti račun. Pri službenih ali šolskih računih je skrbnik morda izklopil IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider vas je prijavil, vendar je poštni strežnik zavrnil dostop za ta naslov. Ob prijavi izberite isti račun. Pri službenih ali šolskih računih je skrbnik morda izklopil IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Poštni strežnik ni dosegljiv. Preverite povezavo in poskusite znova.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Prijava z računom $provider v tej različici ni na voljo.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Znova ste prijavljeni. $account se sinhronizira.';
  }

  @override
  String get accountSetupSignInAgain => 'Znova se prijavi';

  @override
  String get accountSetupSigningIn => 'Prijavljanje …';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider ne sprejema več prijave aplikacije Loupe za $email, zato se $account ne sinhronizira. Znova se prijavite, da boste prejemali njegovo pošto.';
  }

  @override
  String get accountImportTitle => 'Uvozi iz Thunderbirda';

  @override
  String get accountImportPointCamera => 'Kamero usmerite v kodo QR, ki jo prikazuje Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Optično prebrano $scanned od $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Optično prebrano $scanned od $total kod',
      few: 'Optično prebrano $scanned od $total kod',
      two: 'Optično prebrano $scanned od $total kod',
      one: 'Optično prebrano $scanned od $total kode',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaenkrat $count računov',
      few: 'Zaenkrat $count računi',
      two: 'Zaenkrat $count računa',
      one: 'Zaenkrat $count račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'V računalniku odprite Thunderbird in izberite Orodja › Izvozi za mobilne naprave. Izberite svoje račune in nato optično preberite vsako kodo, ki jo prikaže. Kode lahko preberete v poljubnem vrstnem redu.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nadaljuj: $count računov',
      few: 'Nadaljuj: $count računi',
      two: 'Nadaljuj: $count računa',
      one: 'Nadaljuj: $count račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Raje prilepi besedilo';

  @override
  String get accountImportStartOver => 'Začni znova';

  @override
  String get accountImportDuplicateCode => 'Ta koda je že dodana.';

  @override
  String get accountImportRestarted => 'Ta koda je iz novega izvoza, zato so bile prej prebrane kode odložene.';

  @override
  String get accountImportNotThunderbird => 'To ni koda računa Thunderbird.';

  @override
  String get accountImportNewerVersion => 'Ta koda je iz novejšega Thunderbirda. Za uvoz posodobite Loupe.';

  @override
  String get accountImportDamaged => 'Te kode Thunderbird ni bilo mogoče prebrati.';

  @override
  String get accountImportTooLarge => 'Ta koda je prevelika, da bi bila izvoz iz Thunderbirda.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nastavitev ni bilo mogoče odpreti.';

  @override
  String get accountImportCameraOffTitle => 'Dostop do kamere je izklopljen';

  @override
  String get accountImportCameraOffText =>
      'V Nastavitvah aplikaciji Loupe dovolite uporabo kamere za branje kode ali pa raje prilepite besedilo kode.';

  @override
  String get accountImportNoCameraTitle => 'Ni kamere';

  @override
  String get accountImportNoCameraText => 'Loupe tukaj ne more uporabiti kamere. Raje prilepite besedilo kode.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera se ni zagnala';

  @override
  String get accountImportCameraFailedText => 'Poskusite znova ali raje prilepite besedilo kode.';

  @override
  String get accountImportOpenSettings => 'Odpri Nastavitve';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Najdenih je $count računov',
      few: 'Najdeni so $count računi',
      two: 'Najdena sta $count računa',
      one: 'Najden je $count račun',
      zero: 'Ni najdenih računov',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nobenega računa v teh kodah ni bilo mogoče prebrati.';

  @override
  String get accountImportChoose => 'Izberite račune, ki jih želite dodati v Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kod ni bilo optično prebranih ($codes od $total), zato njihovi računi niso navedeni.',
      few: '$count kode niso bile optično prebrane ($codes od $total), zato njihovi računi niso navedeni.',
      two: '$count kodi nista bili optično prebrani ($codes od $total), zato njuni računi niso navedeni.',
      one: '$count koda ni bila optično prebrana ($codes od $total), zato njeni računi niso navedeni.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes in $last';
  }

  @override
  String get accountImportScanMore => 'Optično preberi več kod';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count računov v kodah ni bilo mogoče prebrati. Morda uporabljajo nastavitve iz novejšega Thunderbirda.',
      few: '$count računov v kodah ni bilo mogoče prebrati. Morda uporabljajo nastavitve iz novejšega Thunderbirda.',
      two: '$count računov v kodah ni bilo mogoče prebrati. Morda uporabljata nastavitve iz novejšega Thunderbirda.',
      one: '$count računa v kodah ni bilo mogoče prebrati. Morda uporablja nastavitve iz novejšega Thunderbirda.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Znova optično preberi';

  @override
  String get accountImportAlreadyAdded => 'Račun s tem naslovom je že v aplikaciji Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Ko bo dodan, se boste prijavili z računom $provider, kot v Thunderbirdu.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Dodajte račun z geslom za aplikacijo (zahteva preverjanje v dveh korakih).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se v Gmail prijavlja z Googlom. „Prijava z računom Google“ bo na voljo v poznejši različici; do takrat dodajte račun z geslom za aplikacijo (zahteva preverjanje v dveh korakih).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se v ta račun prijavlja v brskalniku. Loupe tega še ne zmore: uporabite geslo za aplikacijo, če ga vaš ponudnik ponuja.';

  @override
  String get accountImportUnencrypted => 'Poveže se brez šifriranja. To uporabljajte le v lastnem omrežju.';

  @override
  String get accountImportEnterAgain => 'Vnesite ga znova';

  @override
  String get accountImportAdded => 'Dodano';

  @override
  String accountImportAdding(int index, int total) {
    return 'Dodajanje $index od $total …';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dodaj $count računov',
      few: 'Dodaj $count račune',
      two: 'Dodaj $count računa',
      one: 'Dodaj $count račun',
      zero: 'Dodaj račune',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Prilepi besedilo izvoza';

  @override
  String get accountImportPasteText => 'Prilepite besedilo izvozne kode iz Thunderbirda, eno kodo na vrstico.';

  @override
  String get accountImportPop3 => 'Računi POP3 niso podprti. Loupe hrani pošto na strežniku prek IMAP.';

  @override
  String get accountImportKerberos => 'Ta račun se prijavlja s Kerberosom, ki ga Loupe ne podpira.';

  @override
  String get accountImportNtlm => 'Ta račun se prijavlja z NTLM, ki ga Loupe ne podpira.';

  @override
  String get accountImportClientCertificate =>
      'Ta račun se prijavlja z odjemalskim potrdilom, ki ga Loupe še ne podpira.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Prijava z Microsoftom bo na voljo v poznejši različici. Računi Outlook in Microsoft 365 ne sprejemajo več gesel iz poštnih aplikacij.';

  @override
  String get accountImportEnterPassword => 'Vnesite geslo.';

  @override
  String get accountImportEnterAppPassword => 'Vnesite geslo za aplikacijo.';

  @override
  String get accountImportEnterApiToken => 'Vnesite žeton API.';

  @override
  String get accountImportStorageFailed => 'Loupe ni mogla odpreti shrambe računov. Poskusite znova pozneje.';

  @override
  String get accountImportFailed => 'Računa ni bilo mogoče dodati. Poskusite znova ali ga dodajte ročno.';

  @override
  String get composeNewMessageTitle => 'Novo sporočilo';

  @override
  String get composeAttach => 'Priloži';

  @override
  String get composeSendLater => 'Pošlji pozneje';

  @override
  String composeSendAt(String time) {
    return 'Pošlji $time';
  }

  @override
  String get composeSendHint => 'Pridržite za poznejše pošiljanje';

  @override
  String get composeNoAccount => 'Za pošiljanje pošte dodajte račun.';

  @override
  String get composeTo => 'Za:';

  @override
  String get composeCc => 'Kp:';

  @override
  String get composeBcc => 'Skp:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kp/Skp, od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Zadeva:';

  @override
  String composeReplyTo(String address) {
    return 'Odgovor za: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odgovori z naslova $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Pošlji z naslova $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odgovorite z naslova $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Pošljete z naslova $email?';
  }

  @override
  String get composeDismiss => 'Opusti';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ni shranjeno kot identiteta · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Shrani kot identiteto';

  @override
  String composeAliasSaved(String email) {
    return 'Naslov $email je shranjen kot identiteta.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Neveljaven naslov $address';
  }

  @override
  String get composeOriginalNotFound => 'Izvirnega sporočila ni bilo mogoče najti.';

  @override
  String get composeDraftNotFound => 'Osnutka ni bilo mogoče najti.';

  @override
  String get composeAttachmentsLost => 'Prilog ni bilo mogoče obnoviti. Dodajte jih znova.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Nekaterih prilog ni bilo mogoče dodati: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Priloge skupaj obsegajo $size; nekateri strežniki zavrnejo tako velika sporočila.';
  }

  @override
  String get composeAttachFailed => 'Datoteke ni bilo mogoče priložiti.';

  @override
  String get composeInvalidAddressTitle => 'Neveljaven naslov';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ ni veljaven e-poštni naslov.';
  }

  @override
  String get composeNoSubjectTitle => 'Brez zadeve';

  @override
  String get composeNoSubjectText => 'To sporočilo nima zadeve. Ga želite vseeno poslati?';

  @override
  String get composeSentBeforeChanges => 'Poslano je bilo pred vašimi spremembami, ki so shranjene v Osnutkih.';

  @override
  String composeScheduled(String time) {
    return 'Načrtovano za $time';
  }

  @override
  String get composeSending => 'Pošiljanje …';

  @override
  String get composeSent => 'Poslano';

  @override
  String get composeSendFailed => 'Pošiljanje ni uspelo. Poskusite znova.';

  @override
  String get composeAlreadySent => 'Že poslano.';

  @override
  String get composeDiscardChanges => 'Zavrzi spremembe';

  @override
  String get composeSaveChanges => 'Shrani spremembe';

  @override
  String get composeDeleteDraft => 'Izbriši osnutek';

  @override
  String get composeSaveDraft => 'Shrani osnutek';

  @override
  String get composeDraftSaved => 'Osnutek je shranjen';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date ob $time je $name napisal(a):';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date ob $time je nekdo napisal:';
  }

  @override
  String get composeForwardHeader => '---------- Posredovano sporočilo ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Od: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date ob $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Zadeva: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Za: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kp: $addresses';
  }

  @override
  String get composeLaterToday => 'Pozneje danes';

  @override
  String get composeTomorrowMorning => 'Jutri zjutraj';

  @override
  String get composeMondayMorning => 'V ponedeljek zjutraj';

  @override
  String get composePickDateTime => 'Izberi datum in čas …';

  @override
  String get composeSendWithoutDelay => 'Pošlji brez zamika';

  @override
  String composeSendTimeToday(String time) {
    return 'Danes ob $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Jutri ob $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day ob $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Danes $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Jutri $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Želite nadaljevati urejanje osnutka?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Sporočilo ni bilo poslano, ko se je Loupe zaprla.',
      'one': 'Sporočilo za $name ni bilo poslano, ko se je Loupe zaprla.',
      'other': 'Sporočilo za $name in druge ni bilo poslano, ko se je Loupe zaprla.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Sporočilo „$subject“ ni bilo poslano, ko se je Loupe zaprla.',
      'one': 'Sporočilo „$subject“ za $name ni bilo poslano, ko se je Loupe zaprla.',
      'other': 'Sporočilo „$subject“ za $name in druge ni bilo poslano, ko se je Loupe zaprla.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Nadaljuj urejanje';

  @override
  String get composeRecoverySave => 'Shrani med osnutke';

  @override
  String get composeRecoveryDiscard => 'Zavrzi';

  @override
  String get composeRecoverySaved => 'Shranjeno med osnutke';

  @override
  String get outboxSectionFailed => 'Ni poslano';

  @override
  String get outboxSectionSending => 'Pošiljanje';

  @override
  String get outboxSectionScheduled => 'Načrtovano';

  @override
  String get outboxStatusQueued => 'Kmalu bo poslano';

  @override
  String get outboxStatusSending => 'Pošiljanje …';

  @override
  String get outboxStatusFailed => 'Ni poslano';

  @override
  String get outboxNoRecipients => 'Ni prejemnikov';

  @override
  String get outboxNoSubject => '(Brez zadeve)';

  @override
  String get outboxSendingFailed => 'Pošiljanje ni uspelo.';

  @override
  String get outboxEmptyTitle => 'Ničesar za pošiljanje';

  @override
  String get outboxEmptyText => 'Sporočila, ki jih pošljete pozneje, tukaj čakajo, dokler ne pride čas.';

  @override
  String get outboxSendNow => 'Pošlji zdaj';

  @override
  String get outboxReschedule => 'Prestavi';

  @override
  String get outboxRescheduleMenu => 'Prestavi …';

  @override
  String get outboxRescheduleTitle => 'Prestavi';

  @override
  String outboxRescheduled(String time) {
    return 'Prestavljeno na $time';
  }

  @override
  String get outboxCancel => 'Prekliči';

  @override
  String get outboxCancelSending => 'Prekliči pošiljanje …';

  @override
  String get outboxCancelTitle => 'Želite preklicati pošiljanje?';

  @override
  String get outboxMoveToDrafts => 'Premakni med osnutke';

  @override
  String get outboxDiscard => 'Zavrzi sporočilo';

  @override
  String get outboxMovedToDrafts => 'Premaknjeno med osnutke';

  @override
  String get outboxDiscarded => 'Sporočilo je zavrženo';

  @override
  String get outboxAlreadySent => 'Že poslano.';

  @override
  String get outboxBeingSent => 'To sporočilo se pravkar pošilja.';

  @override
  String get outboxActionFailed => 'To ni uspelo. Sporočilo je še vedno v mapi Odhodna pošta.';

  @override
  String get notificationsBadgeInboxes => 'Neprebrano v mapah Prejeto';

  @override
  String get notificationsBadgeVip => 'Neprebrano od stikov VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nova pošta vaših stikov VIP v katerem koli računu';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nova pošta v $email';
  }

  @override
  String get notificationsUnknownSender => 'Neznan pošiljatelj';

  @override
  String get notificationsNoSubject => '(Brez zadeve)';

  @override
  String get notificationsEncryptedMessage => 'Šifrirano sporočilo';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Novo sporočilo v računu $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count novih sporočil',
      few: '$count nova sporočila',
      two: '$count novi sporočili',
      one: '$count novo sporočilo',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nova sporočila v računu $account';
  }

  @override
  String get platformInstantChannel => 'Takojšnja dostava';

  @override
  String get platformInstantChannelDescription => 'Prikazano, medtem ko Loupe spremlja novo pošto v mapah Prejeto';

  @override
  String get platformInstantTitle => 'Spremljanje nove pošte';

  @override
  String get platformInstantText => 'Takojšnja dostava je vklopljena';

  @override
  String get platformErrorBox => 'Pri prikazu je prišlo do napake. Pojdite nazaj in poskusite znova.';

  @override
  String get welcomeTagline => 'Pošta, preprosta na površini\nin zmogljiva v globini.';

  @override
  String get welcomeAccountsTitle => 'Vsi računi, en miren nabiralnik';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail in kateri koli strežnik IMAP ali JMAP.';

  @override
  String get welcomeSearchTitle => 'Iskanje, ki najde';

  @override
  String get welcomeSearchText => 'Takojšnji rezultati v telefonu, nato s strežnika.';

  @override
  String get welcomePrivacyTitle => 'Zasebnost že v zasnovi';

  @override
  String get welcomePrivacyText => 'Brez sledenja. Oddaljene slike ostanejo blokirane, dokler ne rečete drugače.';

  @override
  String get welcomeAddAccount => 'Dodaj račun';

  @override
  String get welcomeImport => 'Uvozi iz Thunderbirda';

  @override
  String get welcomeTryDemo => 'Preizkusi s predstavitveno pošto';
}
