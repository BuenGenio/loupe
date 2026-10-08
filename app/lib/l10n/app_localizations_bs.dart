// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

  @override
  String get commonAdd => 'Dodaj';

  @override
  String get commonCancel => 'Otkaži';

  @override
  String get commonClose => 'Zatvori';

  @override
  String get commonDelete => 'Izbriši';

  @override
  String get commonDone => 'Gotovo';

  @override
  String get commonEdit => 'Uredi';

  @override
  String get commonMore => 'Više';

  @override
  String get commonMove => 'Premjesti';

  @override
  String get commonName => 'Ime';

  @override
  String get commonNone => 'Nema';

  @override
  String get commonOff => 'Isključeno';

  @override
  String get commonOk => 'U redu';

  @override
  String get commonOn => 'Uključeno';

  @override
  String get commonOptional => 'Neobavezno';

  @override
  String get commonPassword => 'Lozinka';

  @override
  String get commonRemove => 'Ukloni';

  @override
  String get commonRetry => 'Pokušaj ponovo';

  @override
  String get commonSave => 'Sačuvaj';

  @override
  String get commonSearch => 'Pretraga';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Postavke';

  @override
  String get commonShare => 'Podijeli';

  @override
  String get commonTryAgain => 'Pokušaj ponovo';

  @override
  String get commonUndo => 'Poništi';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka',
      few: '$count poruke',
      one: '$count poruka',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arhiviraj';

  @override
  String get mailDelete => 'Izbriši';

  @override
  String get mailFlag => 'Označi zastavicom';

  @override
  String get mailForward => 'Proslijedi';

  @override
  String get mailMarkAsRead => 'Označi kao pročitano';

  @override
  String get mailMarkAsUnread => 'Označi kao nepročitano';

  @override
  String get mailMoveToJunk => 'Premjesti u neželjenu poštu';

  @override
  String get mailNewMessage => 'Nova poruka';

  @override
  String get mailNoSubject => 'Bez predmeta';

  @override
  String get mailReply => 'Odgovori';

  @override
  String get mailReplyAll => 'Odgovori svima';

  @override
  String get mailSend => 'Pošalji';

  @override
  String get mailUnflag => 'Ukloni zastavicu';

  @override
  String get mailboxArchive => 'Arhiva';

  @override
  String get mailboxDrafts => 'Nacrti';

  @override
  String get mailboxInbox => 'Prijemno sanduče';

  @override
  String get mailboxJunk => 'Neželjena pošta';

  @override
  String get mailboxOutbox => 'Odlazno sanduče';

  @override
  String get mailboxSent => 'Poslano';

  @override
  String get mailboxTrash => 'Smeće';

  @override
  String get conversationSomethingWentWrong => 'Došlo je do greške. Pokušajte ponovo.';

  @override
  String get conversationReplyToList => 'Odgovori listi';

  @override
  String get conversationReplyList => 'Odgovori listi';

  @override
  String get conversationThreadMuted => 'Nit je utišana. Nove poruke u njoj stižu kao pročitane.';

  @override
  String get conversationThreadUnmuted => 'Utišavanje niti je ukinuto.';

  @override
  String get conversationLinkFailed => 'Otvaranje linka nije uspjelo.';

  @override
  String get conversationGoneTitle => 'Nema poruke';

  @override
  String get conversationGoneText => 'Ova poruka je premještena ili izbrisana.';

  @override
  String get conversationMuted => 'Utišano';

  @override
  String get conversationReaderOptions => 'Opcije čitanja';

  @override
  String get conversationReaderOptionsHint => 'Veličina teksta i prikaz';

  @override
  String get conversationTrash => 'U smeće';

  @override
  String get conversationReplyHint => 'Dugo pritisnite za „Odgovori svima“ i „Proslijedi“';

  @override
  String get conversationOfflineTitle => 'Niste na mreži';

  @override
  String get conversationOfflineText => 'Ovaj razgovor još nije preuzet. Učitat će se kad se ponovo povežete.';

  @override
  String get conversationErrorTitle => 'Poruka se ne može prikazati';

  @override
  String get conversationErrorText => 'Došlo je do greške.';

  @override
  String get conversationOfflineBanner => 'Niste na mreži';

  @override
  String get conversationNotUpdated => 'Nije ažurirano';

  @override
  String get conversationMe => 'ja';

  @override
  String get conversationNoSender => '(bez pošiljaoca)';

  @override
  String get conversationNoRecipients => 'bez primalaca';

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
  String get conversationHeaderCc => 'Kopija';

  @override
  String get conversationHeaderBcc => 'Skrivena kopija';

  @override
  String get conversationHeaderReplyTo => 'Odgovor na';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Sigurnost';

  @override
  String get conversationVerifiedSender => 'Potvrđen pošiljalac';

  @override
  String get conversationUnverifiedSender => 'Nepotvrđen pošiljalac';

  @override
  String get conversationLoadingMessage => 'Učitavanje poruke';

  @override
  String get conversationBodyError => 'Ova poruka se nije mogla učitati.';

  @override
  String get conversationBodyOffline => 'Niste na mreži. Poruka će se učitati kad se ponovo povežete.';

  @override
  String get conversationOriginalHint => 'Bolje izgleda u prikazu „Original“';

  @override
  String get conversationShowOriginal => 'Prikaži original';

  @override
  String get conversationScrollToTop => 'Pomjera na vrh';

  @override
  String get conversationTagsMenu => 'Oznake…';

  @override
  String get conversationMuteThread => 'Utišaj nit';

  @override
  String get conversationUnmuteThread => 'Ukini utišavanje niti';

  @override
  String get conversationMoveMenu => 'Premjesti…';

  @override
  String get conversationDeletePermanently => 'Trajno izbriši';

  @override
  String get conversationMoveToTrash => 'Premjesti u smeće';

  @override
  String get conversationNotJunk => 'Nije neželjena pošta';

  @override
  String get conversationShowAllHeaders => 'Prikaži sva zaglavlja';

  @override
  String get conversationViewSource => 'Prikaži izvor';

  @override
  String get conversationSaveAsFile => 'Sačuvaj kao datoteku…';

  @override
  String get conversationShareAsFile => 'Podijeli kao datoteku…';

  @override
  String get conversationSearchFromMessageMenu => 'Pretraži na osnovu ove poruke…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiraj adresu';

  @override
  String get conversationAddressCopied => 'Adresa je kopirana';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Pretraži poruke pošiljaoca $name';
  }

  @override
  String get conversationTags => 'Oznake';

  @override
  String get conversationAllHeaders => 'Sva zaglavlja';

  @override
  String get conversationCopyAll => 'Kopiraj sve';

  @override
  String get conversationHeadersCopied => 'Zaglavlja su kopirana';

  @override
  String get conversationNoHeaders => 'Nema zaglavlja';

  @override
  String get conversationSearchFromMessageTitle => 'Pretraga na osnovu ove poruke';

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
    return 'Predmet „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Izvor';

  @override
  String get conversationSourceCopied => 'Izvor je kopiran';

  @override
  String get conversationShareFailed => 'Dijeljenje poruke nije uspjelo.';

  @override
  String get conversationWrapLines => 'Prelamaj redove';

  @override
  String get conversationDontWrapLines => 'Ne prelamaj redove';

  @override
  String get conversationSourceError => 'Izvor se nije mogao učitati.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Prikazano je prvih $shown od $total. Kopirajte ili podijelite da biste dobili sve.';
  }

  @override
  String get conversationAttachmentUntitled => 'Bez naziva';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Više radnji za $name';
  }

  @override
  String get conversationMoveTo => 'Premjesti u…';

  @override
  String get conversationMailboxesError => 'Učitavanje sandučića nije uspjelo.';

  @override
  String get conversationReaderReadable => 'Čitljivo';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Običan tekst';

  @override
  String get conversationReaderSans => 'Bezserifni';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Zadrži originalne boje';

  @override
  String get conversationReaderRemember => 'Zapamti za ovog pošiljaoca';

  @override
  String get conversationSecurityPossiblePhishing => 'Mogući phishing';

  @override
  String get conversationSecurityBeCareful => 'Budite oprezni';

  @override
  String get conversationSecurityVerified => 'Potvrđeno';

  @override
  String get conversationSecurityNoIssues => 'Nisu pronađeni problemi';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elemenata za praćenje',
      few: '$count elementa za praćenje',
      one: '$count element za praćenje',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Prikazuje razlog';

  @override
  String get conversationPhishingBannerTitle => 'Ova poruka izgleda kao phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Linkovi i slike su isključeni.';
  }

  @override
  String get conversationPhishingBannerText => 'Linkovi i slike su isključeni.';

  @override
  String get conversationPhishingWhy => 'Zašto?';

  @override
  String get conversationPhishingShowAnyway => 'Ipak prikaži';

  @override
  String get conversationSecurityPhishingTitle => 'Ovo izgleda kao phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Više znakova ukazuje na to da ova poruka nije ono za šta se predstavlja.';

  @override
  String get conversationSecurityCarefulTitle => 'Budite oprezni s ovom porukom';

  @override
  String get conversationSecurityCarefulText => 'Nešto u njoj vrijedi bolje pogledati.';

  @override
  String get conversationSecurityVerifiedText => 'Pošiljalac je potvrđen i ništa ne izgleda sumnjivo.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ništa ne izgleda sumnjivo. Vaš server e-pošte nije naveo da li je pošiljalac potvrđen.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ništa ne izgleda sumnjivo.';

  @override
  String get conversationSecurityWhy => 'Zašto';

  @override
  String get conversationSecurityPrivacy => 'Privatnost';

  @override
  String get conversationSecurityNoTrackingPixels => 'Nema piksela za praćenje';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uklonjeno je $count piksela za praćenje',
      few: 'Uklonjena su $count piksela za praćenje',
      one: 'Uklonjen je $count piksel za praćenje',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Oni bi pošiljaocu javili kada ste otvorili ovu poruku.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nema udaljenih slika';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count udaljenih slika',
      few: '$count udaljene slike',
      one: '$count udaljena slika',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ako ih učitate, pošiljalac saznaje kada čitate ovu poruku, kao i vašu IP adresu.';

  @override
  String get conversationSecurityNoClickTracking => 'Nema praćenja klikova';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linkova s praćenjem klikova',
      few: '$count linka s praćenjem klikova',
      one: '$count link s praćenjem klikova',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Vaš klik bi zabilježili: $services. Dugo pritisnite link da biste direktno otvorili njegovo odredište.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tehnički detalji';

  @override
  String get conversationSecurityCheckedLocally => 'Provjereno na ovom uređaju. Ništa nije nikud poslano.';

  @override
  String get conversationSecurityTrackersLabel => 'Elementi za praćenje';

  @override
  String get conversationSecurityImagesFrom => 'Slike sa';

  @override
  String get conversationSecuritySenderHistory => 'Historija pošiljaoca';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'primljeno: $received, poslano: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linkovi vode na';

  @override
  String get conversationSecurityHidden => 'Skriveno';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elemenata',
      few: '$elements elementa',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters znakova',
      few: '$characters znaka',
      one: '$characters znak',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Pošiljalac nije potvrđen';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Vaš server e-pošte nije mogao potvrditi da ova poruka zaista dolazi s domena $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Vaš server e-pošte nije mogao potvrditi da ova poruka zaista dolazi od navedenog pošiljaoca.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Vaš server e-pošte nije mogao potvrditi da ova poruka dolazi s domena $domain. To je često kod mailing lista.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Vaš server e-pošte nije mogao potvrditi da ova poruka dolazi od navedenog pošiljaoca. To je često kod mailing lista.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ne postupajte po njoj osim ako ste je očekivali. Ako niste sigurni, kontaktirajte pošiljaoca na drugi način.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Potpisao drugi domen';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Poruku je potpisao domen $signer, a ne $domain. Servisi za slanje e-pošte to rade, ali to ne dokazuje ko ju je napisao.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Poruku je potpisao drugi domen, a ne $domain. Servisi za slanje e-pošte to rade, ali to ne dokazuje ko ju je napisao.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Ime prikazuje drugu adresu';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'U imenu pošiljaoca piše „$shown“, ali poruka dolazi s adrese $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Vjerujte adresi, a ne imenu.';

  @override
  String get conversationSecurityReplyToTitle => 'Odgovori idu na drugu adresu';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vaš odgovor bi otišao na adresu $address, a ne na domen $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Provjerite adresu prije nego što u odgovoru pošaljete bilo šta lično.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Koristi vaše ime';

  @override
  String get conversationSecurityImpersonationTitle => 'Koristi ime osobe koju poznajete';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Potpisana je imenom „$name“, istim kao vaše, ali dolazi s nove adrese: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Potpisana je imenom „$name“, kao vaš VIP kontakt $knownName ($knownEmail), ali dolazi s nove adrese: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Potpisana je imenom „$name“, kao $knownName ($knownEmail), ali dolazi s nove adrese: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Uz to, odgovori bi išli na još jednu drugu adresu.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ako traži novac, kodove ili datoteke, prvo provjerite s tom osobom na drugi način.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Poznata adresa: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ova adresa: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Prva poruka od ovog pošiljaoca';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Dosad niste primali poštu s adrese $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Budite oprezni sa zahtjevima ljudi koje još ne poznajete.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Slova sličnog izgleda u adresi pošiljaoca';

  @override
  String get conversationSecurityLinkHomographTitle => 'Slova sličnog izgleda u linku';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Adresa $host miješa slova iz različitih pisama kako bi oponašala neku drugu.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Adresa $host koristi slova sličnog izgleda: to nije $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Izbrišite je ili je prijavite kao neželjenu.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ne otvarajte ga.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domen: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domen koji oponaša drugi';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Koristi poznato ime u domenu';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Domen $domain liči na vaš domen $real, ali je to drugi domen.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Domen $domain liči na domen $real ($brand), ali je to drugi domen.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Domen $domain koristi ime vašeg domena $real, ali nije vaš.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Domen $domain koristi naziv $brand ($real), ali nije njihov.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Prave poruke vaše organizacije stižu s domena $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Prave poruke koje šalje $brand stižu s domena $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domen pošiljaoca: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Oponaša: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linkova skriva svoje odredište',
      few: '$count linka skrivaju svoje odredište',
      one: '$count link skriva svoje odredište',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Link prikazuje $shown, ali otvara $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ne prijavljujte se i ne plaćajte preko ovih linkova. Umjesto toga, sami ukucajte adresu.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Odredište linka se ne može provjeriti';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Link prikazuje $shown, ali ide preko domena $host, koji bilježi klik prije nego što ga proslijedi dalje.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Link vodi direktno na IP adresu';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nije web-stranica s imenom. Prave kompanije rijetko tako postavljaju linkove.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Prikriven link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Link počinje s „$shown@“ kako bi ličio na $shown, ali otvara $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Skrivena stranica je onemogućena';

  @override
  String get conversationSecurityDataLinkText =>
      'Link bi otvorio stranicu upakovanu u samu poruku, što je način da se zaobiđu provjere linkova.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Traži lozinku';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Poruka je sadržavala polje za lozinku. Aplikacija Loupe ga je uklonila.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nikada ne unosite lozinku u poruku e-pošte.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Link koji pokreće kod je onemogućen';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nikada ne pokreće kod iz poruka.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skraćenih linkova',
      few: '$count skraćena linka',
      one: '$count skraćeni link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skriva pravo odredište dok ne otvorite link.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Međunarodna web-adresa';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts koristi slova koja nisu latinična. To je uobičajeno za mnoge jezike; provjerite da li je to stranica koju očekujete.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mnogo skrivenog teksta';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Uklonjeno je $count znakova nevidljivog teksta. Ovakav skriveni tekst služi da prevari filtere za neželjenu poštu.',
      few:
          'Uklonjena su $count znaka nevidljivog teksta. Ovakav skriveni tekst služi da prevari filtere za neželjenu poštu.',
      one:
          'Uklonjen je $count znak nevidljivog teksta. Ovakav skriveni tekst služi da prevari filtere za neželjenu poštu.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Skriveni tekst je uklonjen';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uklonjeno je $count znakova nevidljivog teksta.',
      few: 'Uklonjena su $count znaka nevidljivog teksta.',
      one: 'Uklonjen je $count znak nevidljivog teksta.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Preuzimanje poruke nije uspjelo. Provjerite vezu i pokušajte ponovo.';

  @override
  String exportSaved(String name) {
    return 'Sačuvano: „$name“';
  }

  @override
  String get exportSaveFailed => 'Poruka se nije mogla sačuvati.';

  @override
  String exportFailed(String folder) {
    return 'Izvoz foldera „$folder“ nije uspio.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Folder „$folder“ nema poruka za izvoz.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Izvoz foldera „$folder“ nije uspio: nijedna poruka se nije mogla preuzeti. Provjerite vezu i pokušajte ponovo.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sačuvano: „$name“, bez $formattedCount poruka koje se nisu mogle preuzeti.',
      few: 'Sačuvano: „$name“, bez $formattedCount poruke koje se nisu mogle preuzeti.',
      one: 'Sačuvano: „$name“, bez $count poruke koja se nije mogla preuzeti.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Datoteka „$name“ se nije mogla sačuvati.';
  }

  @override
  String exportTitle(String folder) {
    return 'Izvoz foldera „$folder“';
  }

  @override
  String get exportListing => 'Traženje poruka…';

  @override
  String exportProgress(String current, String total) {
    return 'Izvoz: $current od $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount poruka se nije moglo preuzeti',
      few: '$formattedCount poruke se nisu mogle preuzeti',
      one: '$count poruka se nije mogla preuzeti',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Sandučići';

  @override
  String get mailboxesShown => 'Prikazano';

  @override
  String get mailboxesHidden => 'Skriveno';

  @override
  String get mailboxesCollapse => 'Skupi';

  @override
  String get mailboxesExpand => 'Proširi';

  @override
  String get mailboxesManageVips => 'Upravljaj VIP kontaktima';

  @override
  String get mailboxesSubscriptions => 'Pretplate';

  @override
  String mailboxesShowAccount(String account) {
    return 'Prikaži račun $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Sakrij račun $account';
  }

  @override
  String get mailboxesExportFolder => 'Izvezi folder…';

  @override
  String get mailboxesUnpin => 'Otkači';

  @override
  String get mailboxesLists => 'Liste';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Sačuvajte pretragu da biste je imali ovdje.';

  @override
  String get mailboxesTags => 'Oznake';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Možete i dodirnuti ime pošiljaoca u poruci i uključiti VIP.';

  @override
  String get mailboxesAddVip => 'Dodaj VIP kontakt…';

  @override
  String get mailboxesAddVipTitle => 'Dodaj VIP kontakt';

  @override
  String get mailboxesAddVipText => 'Pošta s ove adrese dobija zvjezdicu i pojavljuje se u sandučetu VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Nepročitano';

  @override
  String get messageListFilterFlagged => 'Označeno zastavicom';

  @override
  String get messageListFilterToMe => 'Za mene';

  @override
  String get messageListFilterCcMe => 'Kopija meni';

  @override
  String get messageListFilterWithAttachments => 'S prilozima';

  @override
  String get messageListFilterUnreplied => 'Bez odgovora';

  @override
  String get messageListFilterFromVips => 'Od VIP kontakata';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je označeno kao pročitano',
      few: '$count poruke su označene kao pročitane',
      one: '$count poruka je označena kao pročitana',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Učitavanje starije pošte nije uspjelo.';

  @override
  String get messageListSelectMessages => 'Odaberite poruke';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odabrano: $count',
      few: 'Odabrano: $count',
      one: 'Odabrano: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Odaberi sve';

  @override
  String get messageListDeselectAll => 'Poništi odabir';

  @override
  String get messageListLoadFailed => 'Učitavanje pošte nije uspjelo';

  @override
  String get messageListNoUnread => 'Nema nepročitane pošte';

  @override
  String get messageListNoMatches => 'Nema odgovarajuće pošte';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrirano po: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Isključi filter';

  @override
  String get messageListEmpty => 'Nema pošte';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kriteriji filtera: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrirano po:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount nepročitanih',
      few: '$formattedCount nepročitane',
      one: '$count nepročitana',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Označi';

  @override
  String get messageListTrash => 'U smeće';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'PRIKAŽI';

  @override
  String get panesHideMailboxes => 'Sakrij sandučiće';

  @override
  String get panesShowMailboxes => 'Prikaži sandučiće';

  @override
  String get panesMailboxesWidth => 'Širina kolone sandučića';

  @override
  String get panesListWidth => 'Širina liste poruka';

  @override
  String get panesNoMessageSelected => 'Nijedna poruka nije odabrana';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka',
      few: '$count poruke',
      one: '$count poruka',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Odgođeno';

  @override
  String get snoozeSheetTitle => 'Odgađanje';

  @override
  String get snoozeLaterToday => 'Kasnije danas';

  @override
  String get snoozeThisEvening => 'Večeras';

  @override
  String get snoozeTomorrow => 'Sutra';

  @override
  String get snoozeThisWeekend => 'Ovog vikenda';

  @override
  String get snoozeNextWeek => 'Sljedeće sedmice';

  @override
  String get snoozePickDateTime => 'Odaberi datum i vrijeme…';

  @override
  String get snoozeMenu => 'Odgodi…';

  @override
  String get snoozeWakeNow => 'Vrati sada';

  @override
  String get snoozeChangeTimeMenu => 'Promijeni vrijeme odgađanja…';

  @override
  String get snoozeChangeTime => 'Promijeni vrijeme';

  @override
  String get snoozeNoTime => 'Vrijeme nije postavljeno';

  @override
  String get snoozeFooter =>
      'Odgođene poruke se vraćaju u Prijemno sanduče kao nepročitane, u vrijeme koje ste odredili.';

  @override
  String get snoozeEmptyTitle => 'Nema odgođenih poruka';

  @override
  String get snoozeEmptyText => 'Odgodite poruku i ona će se vratiti u Prijemno sanduče kad vam zatreba.';

  @override
  String get appLockUnlock => 'Otključaj';

  @override
  String get appLockFailed => 'Nije moguće potvrditi da ste to vi.';

  @override
  String get appLockLockedOut => 'Previše pokušaja. Pokušajte ponovo kasnije.';

  @override
  String get appLockPromptError => 'Nije moguće prikazati prozor za potvrdu. Pokušajte ponovo.';

  @override
  String get appLockNoScreenLock => 'Ovaj telefon nema zaključavanje ekrana.';

  @override
  String get appLockUnlockPromptTitle => 'Otključaj Loupe';

  @override
  String get appLockUnlockPromptReason => 'Potvrdite da ste to vi kako biste vidjeli svoju poštu.';

  @override
  String get appLockTurnOnPromptTitle => 'Uključi zaključavanje aplikacije';

  @override
  String get appLockTurnOnPromptReason => 'Potvrdite da ste to vi kako biste uključili zaključavanje aplikacije.';

  @override
  String get appLockScreenLockRemoved =>
      'Zaključavanje aplikacije je isključeno: ovaj telefon više nema zaključavanje ekrana. Postavite ga kako biste ponovo uključili zaključavanje aplikacije.';

  @override
  String get appLockAfterImmediately => 'Odmah';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuta',
      few: '$count minute',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sati',
      few: '$count sata',
      one: '$count sat',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Šifrirano';

  @override
  String get openpgpEncryptedInPart => 'Djelimično šifrirano';

  @override
  String get openpgpEncryptedLocked => 'Šifrirano · zaključano';

  @override
  String get openpgpEncryptedNoKey => 'Šifrirano · nema ključa';

  @override
  String get openpgpEncryptedDamaged => 'Šifrirano · oštećeno';

  @override
  String get openpgpEncryptedUnsupported => 'Šifrirano · nije podržano';

  @override
  String get openpgpUnknownSigner => 'nepoznat';

  @override
  String get openpgpUnknownKey => 'Nepoznat ključ';

  @override
  String get openpgpSignatureInvalid => 'Nevažeći potpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Potpisnik: $name, a ne pošiljalac';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Potpisnik dijela poruke: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Potpisnik: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Potpisano odbačenim ključem';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Potpisnik: $name · ključ nije prihvaćen';
  }

  @override
  String get openpgpUnlock => 'Otključaj';

  @override
  String get openpgpCantDecrypt => 'Ova poruka se ne može dešifrirati';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifrirano standardom OpenPGP';

  @override
  String get openpgpEncryption => 'Šifriranje';

  @override
  String get openpgpDecryptedHere => 'Dešifrirano na ovom uređaju';

  @override
  String get openpgpNotDecrypted => 'Nije dešifrirano';

  @override
  String get openpgpKeyLocked => 'Vaš ključ je zaključan.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Šifrirano za: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Zaštićeni predmet';

  @override
  String get openpgpUnlockKey => 'Otključaj ključ';

  @override
  String get openpgpSignature => 'Potpis';

  @override
  String get openpgpFingerprint => 'Otisak';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID ključa: $id';
  }

  @override
  String get openpgpSigned => 'Potpisano';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Prihvatanje';

  @override
  String get openpgpChangeAcceptance => 'Promijeni prihvatanje…';

  @override
  String get openpgpCheckedFooter =>
      'Provjereno na ovom uređaju pomoću standarda OpenPGP, kompatibilno s Thunderbirdom.';

  @override
  String get openpgpSummaryLocked =>
      'Vaš ključ je zaključan. Otključajte ga pristupnom frazom kako biste pročitali ovu poruku.';

  @override
  String get openpgpSummaryNoSecretKey => 'Šifrirana je za ključ koji nije na ovom uređaju.';

  @override
  String get openpgpSummaryDamaged => 'Šifrirani podaci su oštećeni ili izmijenjeni tokom prenosa.';

  @override
  String get openpgpSummaryUnsupported => 'Koristi algoritam koji Loupe ne podržava.';

  @override
  String get openpgpSummaryEncrypted => 'Samo vi i ostali primaoci možete je pročitati.';

  @override
  String get openpgpSummaryNotSigned => 'Nije potpisana, pa pošiljalac nije potvrđen.';

  @override
  String get openpgpSummaryUnknownKey => 'Potpisana je, ali ključem koji nemate, pa se potpis ne može provjeriti.';

  @override
  String get openpgpSummaryBadSignature => 'Potpis se ne podudara: poruka je možda izmijenjena.';

  @override
  String get openpgpSummaryMismatch => 'Potpis je važeći, ali ključ pripada drugoj adresi, a ne adresi pošiljaoca.';

  @override
  String get openpgpSummaryPartial =>
      'Potpisan je samo dio poruke. Tekst izvan potpisa (na primjer, podnožje mailing liste) prikazuje se ispod linije „Unsigned content“, a ni ostali dijelovi poruke, poput priloga, nisu obuhvaćeni potpisom.';

  @override
  String get openpgpSummaryOwnKey => 'Potpisano vašim ključem.';

  @override
  String get openpgpSummaryVerified => 'Potpis je važeći i provjerili ste otisak ključa.';

  @override
  String get openpgpSummaryUnverified => 'Potpis je važeći. Prihvatili ste ključ bez provjere otiska.';

  @override
  String get openpgpSummaryRejected => 'Potpis je važeći, ali ste odbacili ovaj ključ.';

  @override
  String get openpgpSummaryUndecided =>
      'Potpis je važeći, ali još niste prihvatili ovaj ključ. Uporedite njegov otisak s pošiljaocem.';

  @override
  String get openpgpAcceptanceRejected => 'Odbačen';

  @override
  String get openpgpAcceptanceUndecided => 'Nije prihvaćen';

  @override
  String get openpgpAcceptanceUnverified => 'Prihvaćen';

  @override
  String get openpgpAcceptanceVerified => 'Prihvaćen i provjeren';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Prihvatiti ključ kontakta $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Otisak: $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Da, otisak je provjeren';

  @override
  String get openpgpAcceptUnverified => 'Da, bez provjere';

  @override
  String get openpgpAcceptLater => 'Još ne';

  @override
  String get openpgpRejectKey => 'Odbaci ovaj ključ';

  @override
  String get openpgpNoSubject => '(bez predmeta)';

  @override
  String get openpgpEncryptionTitle => 'Šifriranje s kraja na kraj';

  @override
  String get openpgpMyKeys => 'Moji OpenPGP ključevi';

  @override
  String get openpgpMyKeysFooter =>
      'S ključem možete čitati šifriranu poštu te potpisivati i šifrirati svoju. Koristite Thunderbird? Tamo izvezite ključ (Postavke računa › End-To-End Encryption › Backup Secret Key To File) i uvezite ga ovdje.';

  @override
  String get openpgpAddKey => 'Dodaj ključ…';

  @override
  String get openpgpAddresses => 'Adrese';

  @override
  String get openpgpAddressesFooter => 'Koji ključ koristi svaka adresa te kada šifrira i potpisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP ključevi kontakata';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Prihvatite ključ kada se uvjerite da pripada svom vlasniku, a otisak uporedite s vlasnikom kako biste ključ označili kao provjeren.';

  @override
  String get openpgpImportPublicKey => 'Uvezi javni ključ…';

  @override
  String get openpgpCollected => 'Prikupljeni Autocrypt ključevi';

  @override
  String get openpgpCollectedFooter =>
      'Ključevi koji su stigli uz poruke. Loupe može šifrirati za njih kada to obje strane žele.';

  @override
  String get openpgpOnThisDevice => 'Na ovom uređaju';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifrirane poruke skrivaju svoj predmet. Loupe čuva predmet svake poruke koju otvorite u svojoj šifriranoj bazi podataka na ovom uređaju, kako bi se prikazivao na listi, u pretrazi i u obavještenjima. U pozadini Loupe može dešifrirati i predmete novih poruka pomoću ključeva bez pristupne fraze; za to preuzima svaku poruku (do 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Dešifriraj predmete u pozadini';

  @override
  String get openpgpIndexFooter =>
      'Pretraga pronalazi šifrirane poruke po pošiljaocu, primaocima i predmetu. Kada je ovo uključeno, Loupe dodaje i tekst svake šifrirane poruke koju dešifrira u indeks pretrage u svojoj šifriranoj bazi podataka na ovom uređaju, pa je pretraga pronalazi i po tekstu. Isključivanjem se taj tekst uklanja iz indeksa.';

  @override
  String get openpgpIndexDecrypted => 'Indeksiraj dešifrirane poruke za pretragu';

  @override
  String get openpgpPassphrases => 'Pristupne fraze';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP ključevi i S/MIME certifikati koje štitite pristupnom frazom otključavaju se po potrebi. Bez opcije „Zapamti pristupne fraze“ ponovo se zaključavaju dvije minute poslije svake upotrebe.';

  @override
  String get openpgpRememberPassphrases => 'Zapamti pristupne fraze';

  @override
  String get openpgpRememberPassphrasesDetail => 'Dok se Loupe ne zatvori';

  @override
  String get openpgpLockKeysNow => 'Zaključaj ključeve sada';

  @override
  String get openpgpKeysLocked => 'Ključevi su zaključani.';

  @override
  String get openpgpKeyStateRevoked => 'opozvan';

  @override
  String get openpgpKeyStateExpired => 'istekao';

  @override
  String get openpgpKeyStateNeverExpires => 'ne ističe';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'ističe $date';
  }

  @override
  String get openpgpNoKey => 'Nema ključa';

  @override
  String get openpgpAlwaysEncrypt => 'Uvijek šifriraj';

  @override
  String get openpgpAddKeyTitle => 'Dodavanje OpenPGP ključa';

  @override
  String get openpgpAddKeyMessage => 'Uvezite ključ koji koristite u Thunderbirdu ili napravite novi.';

  @override
  String get openpgpImportFromClipboard => 'Uvezi iz međuspremnika';

  @override
  String get openpgpImportFromFile => 'Uvezi iz datoteke';

  @override
  String get openpgpGenerateNewKey => 'Napravi novi ključ';

  @override
  String get openpgpImportPublicKeyTitle => 'Uvoz javnog ključa';

  @override
  String get openpgpFromClipboard => 'Iz međuspremnika';

  @override
  String get openpgpFromFile => 'Iz datoteke';

  @override
  String get openpgpClipboardEmpty => 'Međuspremnik je prazan. Prvo kopirajte ključ.';

  @override
  String get openpgpKey => 'Ključ';

  @override
  String get openpgpValidityRevoked => 'Opozvan';

  @override
  String openpgpValidityExpired(String date) {
    return 'Istekao $date';
  }

  @override
  String get openpgpNeverExpires => 'Ne ističe';

  @override
  String openpgpValidUntil(String date) {
    return 'Važi do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Otisak je kopiran.';

  @override
  String get openpgpAlgorithm => 'Algoritam';

  @override
  String get openpgpCreated => 'Napravljen';

  @override
  String get openpgpValidity => 'Važenje';

  @override
  String get openpgpProtection => 'Zaštita';

  @override
  String get openpgpProtectionPassphrase => 'Pristupna fraza';

  @override
  String get openpgpProtectionKeychain => 'Samo skladište ključeva';

  @override
  String get openpgpKeyDetailsFooter =>
      'Podijelite javni ključ kako bi vam drugi mogli slati šifriranu poštu. Rezervna kopija je vaš tajni ključ, zaštićen pristupnom frazom ako je ima: ne dijelite je ni s kim.';

  @override
  String get openpgpSharePublicKey => 'Podijeli javni ključ';

  @override
  String get openpgpCopyPublicKey => 'Kopiraj javni ključ';

  @override
  String get openpgpPublicKeyCopied => 'Javni ključ je kopiran.';

  @override
  String get openpgpBackUpSecretKey => 'Napravi rezervnu kopiju tajnog ključa';

  @override
  String get openpgpDeleteKey => 'Izbriši ključ';

  @override
  String get openpgpRemoveKey => 'Ukloni ključ';

  @override
  String get openpgpBackUpTitle => 'Napraviti rezervnu kopiju tajnog ključa?';

  @override
  String get openpgpBackUpProtected =>
      'Rezervna kopija je zaštićena pristupnom frazom vašeg ključa. Ko ima oboje, može čitati vašu poštu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ovaj ključ nema pristupnu frazu: svako ko ima rezervnu kopiju može čitati vašu poštu i potpisivati u vaše ime.';

  @override
  String get openpgpBackUp => 'Napravi kopiju';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Izbrisati vaš ključ $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Ukloniti ključ kontakta $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Pošta šifrirana za ovaj ključ više se neće moći čitati na ovom uređaju, osim ako ga ponovo ne uvezete.';

  @override
  String get openpgpRemoveKeyMessage => 'Kasnije ga možete ponovo uvesti.';

  @override
  String get openpgpKeyHeader => 'OpenPGP ključ';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Dodajte ključ na ekranu „Šifriranje s kraja na kraj“ kako biste šifrirali i potpisivali poštu s ove adrese.';

  @override
  String get openpgpGenerateAKey => 'Napravi ključ…';

  @override
  String get openpgpSending => 'Slanje';

  @override
  String get openpgpSendingFooter =>
      'Automatsko šifriranje se uključuje kada svaki primalac ima prihvaćen ključ ili pouzdan certifikat, ili kada Autocrypt pokaže da to obje strane žele. Šifrirana pošta je uvijek potpisana.';

  @override
  String get openpgpEncryptAutomatically => 'Šifriraj automatski';

  @override
  String get openpgpAlwaysEncryptDetail => 'Ne šalje ako neki primalac nema ključ';

  @override
  String get openpgpSignUnencrypted => 'Potpisuj nešifriranu poštu';

  @override
  String get openpgpAttachPublicKey => 'Priloži moj javni ključ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt šalje vaš javni ključ uz svaku poruku, pa druge aplikacije mogu šifrirati za vas bez ikakvog podešavanja.';

  @override
  String get openpgpSendMyKey => 'Šalji moj ključ uz poštu';

  @override
  String get openpgpPreferEncryption => 'Daj prednost šifriranju';

  @override
  String get openpgpPreferEncryptionDetail => 'Traži od drugih da šifriraju kad mogu';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count godina',
      few: '$count godine',
      one: '$count godina',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Pristupne fraze se ne podudaraju.';

  @override
  String openpgpKeyReady(String id) {
    return 'Vaš ključ $id je spreman.';
  }

  @override
  String get openpgpNewKey => 'Novi ključ';

  @override
  String get openpgpNewKeyFor => 'Vlasnik ključa';

  @override
  String get openpgpYourName => 'Vaše ime';

  @override
  String get openpgpAddress => 'Adresa';

  @override
  String get openpgpPassphrase => 'Pristupna fraza';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Neobavezno. Bez nje ključ štiti samo skladište ključeva na telefonu, a Loupe nikada ne pita za frazu. S njom Loupe traži frazu kada je ključ potreban.';

  @override
  String get openpgpRepeatPassphrase => 'Ponovi';

  @override
  String get openpgpExpires => 'Rok važenja';

  @override
  String get openpgpExpiresFooter => 'Prije isteka možete napraviti novi ključ. I Thunderbird koristi tri godine.';

  @override
  String get openpgpGenerateKey => 'Napravi ključ';

  @override
  String get openpgpKeyFor => 'Ključ za adresu';

  @override
  String get openpgpCantEncrypt => 'Šifriranje nije moguće';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nema OpenPGP ključa za $names, a ova adresa uvijek šifrira. Uklonite primaoca ili uvezite ključ u „Postavke › Šifriranje s kraja na kraj“.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nema važećeg S/MIME certifikata za $names, a ova adresa uvijek šifrira. Uklonite primaoca ili uvezite certifikat u „Postavke › Šifriranje s kraja na kraj“.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nema OpenPGP ključa za $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nema važećeg S/MIME certifikata za $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Pošalji nešifrirano';

  @override
  String get openpgpCantSign => 'Potpisivanje nije moguće';

  @override
  String get openpgpCantSignMessage =>
      'Privatni ključ vašeg S/MIME certifikata nije na ovom uređaju. Ponovo uvezite certifikat (datoteku .p12 ili .pfx) u „Postavke › Šifriranje s kraja na kraj“.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nema ključa za $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nema certifikata za $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Autocrypt ključevi';

  @override
  String get openpgpComposeEveryoneHasKey => 'Svi imaju ključ';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Svi imaju certifikat';

  @override
  String get openpgpComposeEncrypt => 'Šifriraj';

  @override
  String get openpgpComposeSign => 'Potpiši';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, promijeni standard';
  }

  @override
  String get openpgpNoKeyFound => 'Nije pronađen nijedan OpenPGP ključ.';

  @override
  String get openpgpImportSecretKeyTitle => 'Uvesti tajni ključ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Ovaj prilog sadrži tajni ključ ($names). Uvezite ga kao svoj ključ samo ako ste ga sami izvezli, na primjer iz Thunderbirda.';
  }

  @override
  String get openpgpImportAsMyKey => 'Uvezi kao moj ključ';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'vaš ključ $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uvesti $count ključeva ($names)?',
      few: 'Uvesti $count ključa ($names)?',
      one: 'Uvesti $count ključ ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Uvezi i prihvati';

  @override
  String get openpgpImportDecideLater => 'Uvezi, odluči kasnije';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'ključ kontakta $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Uvezeno: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženo je $count OpenPGP ključeva.',
      few: 'Priložena su $count OpenPGP ključa.',
      one: 'Priložen je $count OpenPGP ključ.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Uvezi';

  @override
  String get openpgpUnlockKeyTitle => 'Otključavanje OpenPGP ključa';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Unesite pristupnu frazu za ključ $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Pristupna fraza nije tačna. Pokušajte ponovo.';

  @override
  String get openpgpExplainLocked => 'Ova poruka je šifrirana. Otključajte svoj OpenPGP ključ kako biste je pročitali.';

  @override
  String get openpgpExplainNoKey =>
      'Ova poruka je šifrirana, ali ni za jedan OpenPGP ključ na ovom uređaju. Ako je čitate u Thunderbirdu, uvezite svoj ključ odatle u „Postavke › Šifriranje s kraja na kraj“.';

  @override
  String get openpgpExplainDamaged => 'Ova šifrirana poruka je oštećena, pa se ne može sigurno dešifrirati.';

  @override
  String get openpgpExplainUnsupported => 'Ova poruka koristi šifriranje koje Loupe još ne može pročitati.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ova poruka je šifrirana standardom S/MIME, ali ni za jedan certifikat na ovom uređaju. Uvezite svoj certifikat (datoteku .p12 ili .pfx) u „Postavke › Šifriranje s kraja na kraj“.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ova poruka je šifrirana. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Otključajte svoj S/MIME certifikat kako biste je pročitali.';

  @override
  String get openpgpAttachmentGone => 'Ovaj prilog više nije dostupan.';

  @override
  String get smimeEncrypted => 'Šifrirano (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifrirano (S/MIME) · nema certifikata';

  @override
  String get smimeEncryptedDamaged => 'Šifrirano (S/MIME) · oštećeno';

  @override
  String get smimeEncryptedUnsupported => 'Šifrirano (S/MIME) · nije podržano';

  @override
  String get smimeEncryptedLocked => 'Šifrirano (S/MIME) · zaključano';

  @override
  String get smimeUnknownSigner => 'nepoznat';

  @override
  String get smimeSignatureModified => 'Nevažeći potpis: poruka je izmijenjena';

  @override
  String get smimeSignatureWeak => 'Nesiguran potpis: zastarjeli algoritam';

  @override
  String get smimeSignatureUncheckable => 'Potpis se ne može provjeriti';

  @override
  String get smimeSignedCertificateMissing => 'Potpisano · nedostaje certifikat';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Potpisnik: $name · certifikat je opozvan';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Potpisnik: $name · potpisano drugog datuma';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Potpisnik: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Potpisnik: $name · nevažeći certifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Potpisnik: $name · certifikat nije pouzdan';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Potpisnik: $name · certifikat je istekao';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Potpisnik: $name · certifikat još ne važi';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Potpisnik: $name · certifikat nije za poštu';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Potpisnik: $name, a ne pošiljalac';
  }

  @override
  String get smimeCantDecrypt => 'Ova poruka se ne može dešifrirati';

  @override
  String get smimeEncryptedWithSmime => 'Šifrirano standardom S/MIME';

  @override
  String get smimeEncryption => 'Šifriranje';

  @override
  String get smimeDecryptedHere => 'Dešifrirano na ovom uređaju';

  @override
  String get smimeNotDecrypted => 'Nije dešifrirano';

  @override
  String get smimeAuthenticated => 'autentificirano';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'za $count certifikata',
      few: 'za $count certifikata',
      one: 'za $count certifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Potpis';

  @override
  String get smimeIssuedBy => 'Izdavalac';

  @override
  String get smimeValid => 'Važi';

  @override
  String smimeValidRange(String from, String to) {
    return 'od $from do $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 otisak';

  @override
  String get smimeSigned => 'Potpisano';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Provjerava se opoziv…';

  @override
  String get smimeNotRevoked => 'Nije opozvan';

  @override
  String get smimeRevoked => 'Opozvan';

  @override
  String get smimeRevocationUnknown => 'Nepoznato da li je opozvan';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Provjereno kod certifikacijskog tijela (lista opozvanih certifikata), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Provjereno kod certifikacijskog tijela (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Vjeruj izdavaocu „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Vjeruj ovom certifikatu…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Provjereno na ovom uređaju pomoću standarda S/MIME, kompatibilno s Outlookom i Thunderbirdom; opoziv je provjeren kod certifikacijskog tijela.';

  @override
  String get smimeCheckedFooter =>
      'Provjereno na ovom uređaju pomoću standarda S/MIME, kompatibilno s Outlookom i Thunderbirdom. Opoziv se ne provjerava (Postavke › Šifriranje s kraja na kraj).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vjerovati certifikacijskom tijelu $name za poštu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vjerovati certifikatu kontakta $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Svi certifikati koje ovo tijelo izdaje bit će pouzdani, kao kod certifikacijskog tijela vaše firme. Prvo uporedite otisak s vlasnikom:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Prvo uporedite otisak s vlasnikom:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Vjeruj';

  @override
  String get smimeSummaryNoKey => 'Šifrirana je za certifikat koji nije na ovom uređaju.';

  @override
  String get smimeSummaryDamaged => 'Šifrirani podaci su oštećeni ili izmijenjeni tokom prenosa.';

  @override
  String get smimeSummaryUnsupported => 'Koristi algoritam koji Loupe ne podržava.';

  @override
  String get smimeSummaryLocked => 'Vaš S/MIME certifikat je zaključan.';

  @override
  String get smimeSummaryEncrypted => 'Samo vi i ostali primaoci možete je pročitati.';

  @override
  String get smimeSummaryNotSigned => 'Nije potpisana, pa pošiljalac nije potvrđen.';

  @override
  String get smimeSummaryModified => 'Potpis se ne podudara: poruka je izmijenjena nakon potpisivanja.';

  @override
  String get smimeSummaryUncheckable => 'Potpis se ne može provjeriti.';

  @override
  String get smimeSummaryNoCertificate => 'Certifikat potpisnika nije u poruci, pa se potpis ne može provjeriti.';

  @override
  String get smimeSummaryRevoked =>
      'Certifikacijsko tijelo je opozvalo certifikat potpisnika: potpisu se ne može vjerovati.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikacijsko tijelo je opozvalo certifikat potpisnika ($reason): potpisu se ne može vjerovati.';
  }

  @override
  String get smimeDateMismatch =>
      'Potpisana je više od sat vremena prije ili poslije datuma poruke: možda je to stara poruka ponovo poslana.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Potpis je važeći i $issuer garantuje da certifikat pripada pošiljaocu.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikat ili neki od njegovih izdavalaca nije važeći.';

  @override
  String get smimeProblemUntrusted => 'Certifikat potiče od certifikacijskog tijela kojem Loupe ne vjeruje.';

  @override
  String get smimeProblemExpired => 'Certifikat je već bio istekao.';

  @override
  String get smimeProblemNotYetValid => 'Certifikat još nije važio.';

  @override
  String get smimeProblemWrongUsage => 'Certifikat nije namijenjen za poštu.';

  @override
  String get smimeProblemWrongAddress => 'Certifikat pripada drugoj adresi, a ne adresi pošiljaoca.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Pouzdan · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nije pouzdan · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Istekao $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Važi od $date';
  }

  @override
  String get smimeTrustInvalid => 'Nevažeći';

  @override
  String get smimeTrustNotForMail => 'Nije za poštu';

  @override
  String get smimeTrustAnotherAddress => 'Druga adresa';

  @override
  String get smimeMyCertificates => 'Moji S/MIME certifikati';

  @override
  String get smimeMyCertificatesFooter =>
      'Za S/MIME, koji koriste Outlook i mnoge firme. Uvezite svoj certifikat s privatnim ključem (datoteku .p12 ili .pfx), izvezen iz programa Outlook i Thunderbird ili iz sistema Windows i macOS.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Za S/MIME, koji koriste Outlook i mnoge firme. Uvezite svoj certifikat s privatnim ključem (datoteku .p12 ili .pfx), izvezen iz programa Outlook i Thunderbird ili iz sistema Windows i macOS, ili koristite certifikat koji ste vi ili vaša firma instalirali na ovaj uređaj.';

  @override
  String get smimeCertificateExpired => 'istekao';

  @override
  String smimeCertificateUntil(String date) {
    return 'važi do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'na ovom uređaju';

  @override
  String get smimeImportCertificateEllipsis => 'Uvezi certifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Koristi certifikat s ovog uređaja…';

  @override
  String get smimeCorrespondentsCertificates => 'Certifikati kontakata';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Prikupljeni iz potpisane pošte, kao što to rade Outlook i Thunderbird. Pošta se šifrira samo za pouzdane certifikate: Loupe vjeruje certifikacijskim tijelima kojima Mozilla vjeruje za e-poštu, kao i onima koje vi dodate.';

  @override
  String get smimeRevocation => 'Opoziv';

  @override
  String get smimeRevocationFooter =>
      'Kada otvorite potpisanu poštu, Loupe pita certifikacijsko tijelo koje je izdalo certifikat potpisnika da li je taj certifikat opozvan (putem njegovog OCSP servera ili liste opozvanih certifikata). Tijelo tada može vidjeti kada neko s vaše internet adrese čita poštu potpisanu tim certifikatom. Odgovori se čuvaju na ovom uređaju dok ne isteknu. Opozvan certifikat se u zaglavlju poruke prikazuje kao „certifikat je opozvan“.';

  @override
  String get smimeCheckRevocation => 'Provjeravaj opoziv certifikata putem interneta';

  @override
  String get smimeTrustedAuthorities => 'Pouzdana certifikacijska tijela';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pouzdana po vašem izboru, pored $count tijela kojima Mozilla vjeruje za e-poštu.',
      few: 'Pouzdana po vašem izboru, pored $count tijela kojima Mozilla vjeruje za e-poštu.',
      one: 'Pouzdana po vašem izboru, pored $count tijela kojem Mozilla vjeruje za e-poštu.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikacijsko tijelo';

  @override
  String get smimeImportACertificate => 'Uvoz certifikata';

  @override
  String get smimeImportContactMessage => 'Certifikat kontakta (.cer, .crt, .pem) ili certifikacijskog tijela.';

  @override
  String get smimeFromClipboard => 'Iz međuspremnika';

  @override
  String get smimeFromFile => 'Iz datoteke';

  @override
  String get smimeClipboardEmpty => 'Međuspremnik je prazan. Prvo kopirajte certifikat.';

  @override
  String get smimeCertificate => 'Certifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Njegov privatni ključ ostaje u pohrani akreditiva sistema Android, gdje ste ga vi ili vaša firma instalirali: Loupe traži od sistema Android da njime potpisuje i dešifrira. Potpisana pošta se potpisuje u trenutku slanja.';

  @override
  String get smimeAddresses => 'Adrese';

  @override
  String get smimeUsage => 'Namjena';

  @override
  String get smimeUsageNone => 'Ništa što Loupe koristi';

  @override
  String get smimeUsageSigning => 'Potpisivanje';

  @override
  String get smimeUsageEncryption => 'Šifriranje';

  @override
  String get smimeUsageCertificates => 'Izdavanje certifikata';

  @override
  String get smimeAlgorithm => 'Algoritam';

  @override
  String get smimeSerialNumber => 'Serijski broj';

  @override
  String get smimeFingerprintCopied => 'Otisak je kopiran.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 otisak';

  @override
  String get smimePrivateKey => 'Privatni ključ';

  @override
  String get smimeKeyOnDevice => 'Na ovom uređaju';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'U aplikaciji Loupe, s pristupnom frazom';

  @override
  String get smimeKeyInLoupe => 'U aplikaciji Loupe';

  @override
  String get smimeSource => 'Izvor';

  @override
  String get smimeSourceSignedMail => 'Potpisana pošta';

  @override
  String get smimeSourceImported => 'Uvezen';

  @override
  String get smimeTrustHeader => 'Povjerenje';

  @override
  String get smimeTrustedRoot => 'Pouzdani korijenski certifikat';

  @override
  String get smimeIssuer => 'Izdavalac';

  @override
  String smimeTrustNamed(String name) {
    return 'Vjeruj izdavaocu „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Vjeruj ovom certifikacijskom tijelu';

  @override
  String get smimeTrustThisCertificate => 'Vjeruj ovom certifikatu';

  @override
  String get smimeStopTrusting => 'Ukloni povjerenje';

  @override
  String get smimePassphrase => 'Pristupna fraza';

  @override
  String get smimePassphraseFooter =>
      'Neobavezno. S pristupnom frazom privatni ključ je na ovom uređaju dodatno šifriran (Argon2id i AES-256), a Loupe je traži za potpisivanje i dešifriranje; koliko dugo je pamti, određuje „Zapamti pristupne fraze“. Pošta koju šaljete potpisuje se u trenutku slanja; pozadinski procesi ne mogu koristiti ključ.';

  @override
  String get smimeChangePassphrase => 'Promijeni pristupnu frazu…';

  @override
  String get smimeSetPassphraseEllipsis => 'Postavi pristupnu frazu…';

  @override
  String get smimeRemovePassphrase => 'Ukloni pristupnu frazu';

  @override
  String get smimeShareCertificate => 'Podijeli certifikat';

  @override
  String get smimeDeleteCertificate => 'Izbriši certifikat';

  @override
  String get smimeRemoveCertificate => 'Ukloni certifikat';

  @override
  String get smimePassphraseChanged => 'Pristupna fraza je promijenjena.';

  @override
  String get smimePassphraseSet => 'Pristupna fraza je postavljena.';

  @override
  String get smimeRemovePassphraseTitle => 'Ukloniti pristupnu frazu?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Privatni ključ će tada štititi samo skladište ključeva na telefonu, kao kada nema pristupne fraze: Loupe je više neće tražiti, a pozadinski procesi će ga moći koristiti.';

  @override
  String get smimePassphraseRemoved => 'Pristupna fraza je uklonjena.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vjerovati certifikatu $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Svi certifikati koje izdaje bit će pouzdani za poštu. Prvo uporedite otisak s vlasnikom:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Izbrisati vaš certifikat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Ukloniti certifikat kontakta $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ga prestaje koristiti: pošta šifrirana za njega više se ne može čitati u aplikaciji Loupe. Certifikat ostaje na ovom uređaju (Postavke › Sigurnost › Šifriranje i akreditivi).';

  @override
  String get smimeDeleteOwnMessage =>
      'Njegov privatni ključ se briše s ovog uređaja: pošta šifrirana za njega više se neće moći čitati ovdje, osim ako ga ponovo ne uvezete.';

  @override
  String get smimeRemoveContactMessage => 'Vratit će se uz sljedeću potpisanu poruku tog kontakta.';

  @override
  String get smimeAddressImportFooter =>
      'Uvezite certifikat za ovu adresu kako biste potpisivali i šifrirali pomoću standarda S/MIME, kao što to radi Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Uvezi certifikat…';

  @override
  String get smimePreferFooter =>
      'Kada poruku mogu zaštititi oba standarda, koristi se onaj kojem ste dali prednost, osim ako samo drugi ima ključ ili certifikat za svakog primaoca.';

  @override
  String get smimePreferSmime => 'Daj prednost standardu S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Umjesto standarda OpenPGP';

  @override
  String get smimeCertificatePassword => 'Lozinka certifikata';

  @override
  String get smimeCertificatePasswordPrompt => 'Unesite lozinku kojom je datoteka certifikata zaštićena pri izvozu.';

  @override
  String get smimeImport => 'Uvezi';

  @override
  String get smimeWrongPassword => 'Lozinka nije tačna. Pokušajte ponovo.';

  @override
  String get smimeNoCertificateFound => 'Nije pronađen nijedan certifikat.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikat kontakta $name';
  }

  @override
  String get smimeNothingNew => 'Nema ničeg novog za uvoz.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Uvezeno: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uvezeno je $count pouzdanih certifikacijskih tijela.',
      few: 'Uvezena su $count pouzdana certifikacijska tijela.',
      one: 'Uvezeno je $count pouzdano certifikacijsko tijelo.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Uvezeno: $certificates i $count pouzdanih certifikacijskih tijela.',
      few: 'Uvezeno: $certificates i $count pouzdana certifikacijska tijela.',
      one: 'Uvezeno: $certificates i $count pouzdano certifikacijsko tijelo.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Ova datoteka nema privatni ključ. Izvezite certifikat zajedno s privatnim ključem.';

  @override
  String get smimeImportAsYoursTitle => 'Uvesti kao vaš certifikat?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Ovaj prilog sadrži certifikat s privatnim ključem: $names. Uvezite ga samo ako ste ga sami izvezli, na primjer iz Outlooka ili Thunderbirda.';
  }

  @override
  String get smimeImportAsMine => 'Uvezi kao moj certifikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Uvezen je vaš certifikat $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Vaš certifikat $name ($addresses) je dodan s ovog uređaja.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vjerovati certifikacijskom tijelu „$name“ za poštu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ne poznaje ovo certifikacijsko tijelo (možda je to interno tijelo neke firme). Ako mu vjerujete, certifikati koje izdaje moći će se provjeriti. Prvo uporedite njegov otisak sa svojim IT odjelom:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Priloženo je $count certifikata.',
      few: 'Priložena su $count certifikata.',
      one: 'Priložen je $count certifikat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Uvezi certifikat';

  @override
  String get smimeUnlockTitle => 'Otključavanje S/MIME certifikata';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Unesite pristupnu frazu za certifikat $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Pristupna fraza nije tačna. Pokušajte ponovo.';

  @override
  String get smimeUnlock => 'Otključaj';

  @override
  String get smimeEnterAPassphrase => 'Unesite pristupnu frazu.';

  @override
  String get smimePassphrasesDiffer => 'Pristupne fraze se ne podudaraju.';

  @override
  String get smimeSetPassphraseTitle => 'Postavljanje pristupne fraze';

  @override
  String get smimeSetPassphraseText =>
      'Loupe će je tražiti za potpisivanje i dešifriranje. Ako je zaboravite, ponovo uvezite certifikat iz njegove datoteke .p12.';

  @override
  String get smimePassphraseAgain => 'Ponovi';

  @override
  String get smimeSetPassphraseButton => 'Postavi';

  @override
  String get smimeLockedOpenAgain =>
      'Vaš S/MIME certifikat je zaključan. Ponovo otvorite poruku kako biste ga otključali.';

  @override
  String get smimeDeviceHasNoCertificates => 'Ovaj uređaj ne nudi svoje certifikate.';

  @override
  String get smimeCantReadCertificate => 'Loupe ne može pročitati ovaj certifikat.';

  @override
  String get smimeCertificateNotForMail =>
      'Ovaj certifikat nije za poštu: nema adresu e-pošte ili nije namijenjen za potpisivanje ili šifriranje.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikat više nije na ovom uređaju ili ga Loupe više ne smije koristiti. Ponovo ga odaberite u „Postavke › Šifriranje s kraja na kraj“.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikat na ovom uređaju može se koristiti samo dok je Loupe otvoren.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifrirani ključ je oštećen.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikat na ovom uređaju ne može ovo uraditi: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nije podržano';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Greška certifikata na ovom uređaju: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa certifikacijskog tijela nije web adresa.';

  @override
  String get smimeAuthorityTimeout => 'Certifikacijsko tijelo nije odgovorilo na vrijeme.';

  @override
  String get smimeAuthorityUnreachable => 'Nije moguće povezati se s certifikacijskim tijelom.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikacijsko tijelo je odgovorilo kodom $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odgovor certifikacijskog tijela je prevelik.';

  @override
  String get smimeRevocationNotChecked =>
      'Nije provjereno: provjeravaju se samo certifikati koje izdaju certifikacijska tijela kojima Loupe vjeruje.';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Kao na telefonu';

  @override
  String get settingsLanguageFooter =>
      'Loupe koristi jezik telefona kada ga ima, a engleski kada ga nema. Jezik koji ovdje odaberete važi samo za Loupe, uključujući obavještenja.';

  @override
  String get settingsAccountsHeader => 'Računi';

  @override
  String get settingsAddAccount => 'Dodaj račun';

  @override
  String get settingsMailHeader => 'Pošta';

  @override
  String get settingsSwipeActions => 'Radnje prevlačenja';

  @override
  String get settingsSwipeLeft => 'Prevlačenje ulijevo';

  @override
  String get settingsSwipeLeftFooter =>
      'Potpuno prevlačenje pokreće ovu radnju. Kratko prevlačenje uvijek otkriva zastavicu i „Više“.';

  @override
  String get settingsSwipeRight => 'Prevlačenje udesno';

  @override
  String get settingsSwipeRightFooter => 'Potpuno prevlačenje pokreće ovu radnju.';

  @override
  String get settingsSwipeToggleRead => 'Označi kao pročitano / nepročitano';

  @override
  String get settingsSwipeTrash => 'Premjesti u smeće';

  @override
  String get settingsSwipeMove => 'Premjesti poruku';

  @override
  String get settingsSwipeSnooze => 'Odgodi';

  @override
  String get settingsThreaded => 'Grupiši po razgovorima';

  @override
  String get settingsUndoSendDelay => 'Vrijeme za poništavanje slanja';

  @override
  String get settingsUndoSendDelayFooter => 'Poslane poruke čekaju ovoliko dugo, pa slanje možete poništiti.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekundi',
      few: '$seconds sekunde',
      one: '$seconds sekunda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Izgled';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatska';

  @override
  String get settingsThemeLight => 'Svijetla';

  @override
  String get settingsThemeDark => 'Tamna';

  @override
  String get settingsDensity => 'Lista poruka';

  @override
  String get settingsDensityComfortable => 'Prostrana';

  @override
  String get settingsDensityCompact => 'Kompaktna';

  @override
  String get settingsReadingHeader => 'Čitanje';

  @override
  String get settingsReadingFooter => 'Udaljene slike mogu pošiljaocima otkriti kada i gdje ste otvorili poruku.';

  @override
  String get settingsDefaultView => 'Zadani prikaz';

  @override
  String get settingsDefaultViewFooter => 'Prikaz svake poruke možete promijeniti dugmetom Aa.';

  @override
  String get settingsViewReadable => 'Čitljivo';

  @override
  String get settingsViewReadableDetail => 'Uredno, čitko, prati tamnu temu';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Tačno onako kako ga je pošiljalac osmislio';

  @override
  String get settingsViewPlain => 'Običan tekst';

  @override
  String get settingsViewPlainDetail => 'Samo riječi';

  @override
  String get settingsPlainTextFont => 'Font za običan tekst';

  @override
  String get settingsFontSans => 'Bezserifni';

  @override
  String get settingsFontMono => 'Fiksne širine';

  @override
  String get settingsFontMonoDetail => 'ASCII crteži i tabele ostaju poravnati';

  @override
  String get settingsTechnicalLists => 'Tehničke liste';

  @override
  String get settingsLoadRemoteImages => 'Učitaj udaljene slike';

  @override
  String get settingsOpenLinksDirectly => 'Otvori linkove direktno';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Zaobilazi praćenje klikova kad je odredište poznato';

  @override
  String get settingsSecurityHeader => 'Sigurnost';

  @override
  String get settingsAppLock => 'Zaključavanje aplikacije';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe traži otključavanje pri pokretanju i kad se vratite nakon odsustva dužeg od vremena u „Zaključaj nakon“.';

  @override
  String get settingsAppLockFooterOff =>
      'Zaključavanje aplikacije traži otisak prsta, lice ili zaključavanje ekrana prije nego što se prikaže pošta.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Zaključavanje aplikacije je i dalje isključeno. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Postavite šifru';

  @override
  String get settingsScreenLockTextIos =>
      'Zaključavanje aplikacije koristi Face ID, Touch ID ili vašu šifru, a ovaj iPhone nema šifru. Postavite je u aplikaciji Postavke, pa uključite zaključavanje aplikacije.';

  @override
  String get settingsScreenLockTitleAndroid => 'Postavite zaključavanje ekrana';

  @override
  String get settingsScreenLockTextAndroid =>
      'Zaključavanje aplikacije koristi zaključavanje ekrana telefona, kao i otisak prsta ili lice dodano uz njega, a ovaj telefon ga nema. Postavite PIN, uzorak ili lozinku u Android postavkama, pa uključite zaključavanje aplikacije.';

  @override
  String get settingsOpenSystemSettings => 'Otvori postavke';

  @override
  String get settingsOpenAndroidSettings => 'Otvori Android postavke';

  @override
  String get settingsLockAfter => 'Zaključaj nakon';

  @override
  String get settingsLockAfterFooter =>
      'Koliko dugo Loupe može biti u pozadini prije nego što ponovo zatraži otključavanje.';

  @override
  String get settingsNotifications => 'Obavještenja';

  @override
  String get settingsEncryption => 'Šifriranje s kraja na kraj';

  @override
  String get settingsAdvanced => 'Napredno';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo pošta je izmišljeno sanduče koje postoji samo na ovom telefonu. Ništa se nikud ne šalje.';

  @override
  String get settingsDemoMode => 'Demo režim';

  @override
  String get settingsResetApp => 'Resetuj aplikaciju';

  @override
  String get settingsResetFooter => 'Briše sve postavke i vraća na ekran dobrodošlice.';

  @override
  String get settingsResetTitle => 'Resetovati Loupe?';

  @override
  String get settingsResetMessage =>
      'Brišu se sve postavke, Smart Mailboxes i nedavne pretrage, a aplikacija se vraća na ekran dobrodošlice.';

  @override
  String get settingsAboutHeader => 'O aplikaciji';

  @override
  String get settingsVersion => 'Verzija';

  @override
  String get settingsLicences => 'Licence';

  @override
  String get settingsPrivacy => 'Privatnost';

  @override
  String get settingsPrivacyDetail => 'Loupe nema analitiku ni praćenje. Vaša pošta ide samo na vaše servere e-pošte.';

  @override
  String get settingsNotificationsOffIos => 'Obavještenja za Loupe su isključena u Postavkama.';

  @override
  String get settingsNotificationsOffAndroid => 'Obavještenja za Loupe su isključena u Android postavkama.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system ne dozvoljava da Loupe prikazuje obavještenja. Dozvolite ih u Postavkama.';
  }

  @override
  String get settingsNewMailHeader => 'Nova pošta';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo pošta ne stiže u pozadini. Pošaljite probno obavještenje da vidite kako izgleda nova pošta.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe provjerava novu poštu u pozadini kad to iOS dozvoli, a kod aplikacija koje rijetko otvarate između provjera mogu proći i sati. Dobijate obavještenja o novim porukama u prijemnim sandučićima, kao i o porukama VIP kontakata u bilo kojem folderu.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe provjerava novu poštu otprilike svakih 15 minuta, kad Android dozvoli. Dobijate obavještenja o novim porukama u prijemnim sandučićima, kao i o porukama VIP kontakata u bilo kojem folderu.';

  @override
  String get settingsNoAccounts => 'Nema računa';

  @override
  String get settingsVipOnly => 'Samo VIP';

  @override
  String get settingsVipOnlyDetail => 'Samo poruke od vaših VIP kontakata';

  @override
  String get settingsHideContent => 'Sakrij sadržaj';

  @override
  String get settingsHideContentFooterOn =>
      'Obavještenja prikazuju samo „Nova poruka“ i račun, bez pošiljaoca i predmeta.';

  @override
  String get settingsHideContentFooterOff =>
      '„Sakrij sadržaj“ uklanja pošiljaoca, predmet i pregled sa zaključanog ekrana i iz obavještenja.';

  @override
  String get settingsBackgroundAppRefresh => 'Osvježavanje aplikacija u pozadini';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nova pošta stiže u pozadini samo dok je „Osvježavanje aplikacija u pozadini“ uključeno za Loupe u Postavkama. iOS ne može držati otvorenu vezu s prijemnim sandučićima, pa „Trenutna isporuka“ nije dostupna.';

  @override
  String get settingsInstantDelivery => 'Trenutna isporuka';

  @override
  String get settingsInstantDeliveryFooter =>
      'Trenutna isporuka (eksperimentalno) drži otvorenu vezu s prijemnim sandučićima, pa nova pošta stiže za nekoliko sekundi. Prikazuje nenametljivo obavještenje „Praćenje nove pošte“ i troši više baterije.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android može zaustaviti trenutnu isporuku radi uštede baterije. Da bi ona radila bez prekida, dozvolite da Loupe koristi bateriju bez ograničenja.';

  @override
  String get settingsExperimental => 'Eksperimentalno';

  @override
  String get settingsComingSoon => 'Uskoro';

  @override
  String get settingsAllowUnrestrictedBattery => 'Dozvoli neograničenu upotrebu baterije';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push omogućava da nova pošta odmah probudi Loupe, ako to vaša usluga e-pošte podržava. Push poruke idu preko Googleove usluge za push i ne sadrže poštu, samo „provjeri sada“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ovaj telefon ne može primati push poruke: potrebne su usluge Google Playa i mrežna veza. Loupe i dalje provjerava poštu otprilike svakih 15 minuta.';

  @override
  String get settingsCopyPushToken => 'Kopiraj push token';

  @override
  String get settingsPushTokenCopied => 'Push token je kopiran';

  @override
  String get settingsSendTestNotification => 'Pošalji probno obavještenje';

  @override
  String get settingsAppIconBadge => 'Broj na ikoni aplikacije';

  @override
  String get settingsBadgeNote => 'Broj se ažurira svaki put kad Loupe provjeri poštu, i u pozadini.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Početni ekran ovog telefona ne prikazuje brojeve na ikonama aplikacija. Broj se ažurira svaki put kad Loupe provjeri poštu, i u pozadini.';

  @override
  String get settingsTestNotificationBody => 'Obavještenja o novoj pošti izgledaju ovako.';

  @override
  String get settingsAccountRemoved => 'Ovaj račun je uklonjen.';

  @override
  String get settingsAccountHeader => 'Račun';

  @override
  String get settingsAccountDescription => 'Opis';

  @override
  String get settingsAccountDescriptionHint => 'Posao, Lično…';

  @override
  String get settingsEmail => 'E-pošta';

  @override
  String get settingsColour => 'Boja';

  @override
  String get settingsColourFooter => 'Označava poruke ovog računa u prikazu „Svi prijemni sandučići“.';

  @override
  String settingsColourNumber(int number) {
    return 'Boja $number';
  }

  @override
  String get settingsSendingHeader => 'Slanje';

  @override
  String get settingsSendingFooter =>
      'Svaki identitet ima svoj potpis. Odgovori se šalju s adrese na koju je poruka poslana.';

  @override
  String get settingsFoldersHeader => 'Folderi';

  @override
  String get settingsFoldersFooter =>
      'Loupe prikazuje i sinhronizira foldere na koje ste pretplaćeni, kao i Thunderbird. Prijemno sanduče, Nacrti, Poslano, Neželjena pošta, Smeće i Arhiva uvijek se prikazuju.';

  @override
  String get settingsShowAllFolders => 'Prikaži sve foldere';

  @override
  String get settingsIncoming => 'Dolazna pošta';

  @override
  String get settingsOutgoing => 'Odlazna pošta';

  @override
  String get settingsConnectionNotEncrypted => 'Bez šifriranja';

  @override
  String get settingsSignIn => 'Prijava';

  @override
  String get settingsSignInExpired => 'Istekla';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider više ne prihvata prijavu aplikacije Loupe za ovaj račun, pa se njegova pošta ne sinhronizira. Prijavite se ponovo da to riješite.';
  }

  @override
  String get settingsSignInAgain => 'Prijavi se ponovo';

  @override
  String get settingsSigningIn => 'Prijavljivanje…';

  @override
  String get settingsRemoveAccount => 'Ukloni račun';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Ukloniti „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Pošta i postavke ovog računa bit će uklonjeni s ovog telefona. Na serveru se ništa ne briše.';

  @override
  String get settingsManageFolders => 'Upravljanje folderima';

  @override
  String get settingsNoFolders => 'Još nema foldera.';

  @override
  String get settingsManageFoldersFooter =>
      'Folderi na koje ste pretplaćeni prikazuju se na ekranu „Sandučići“ i sinhroniziraju u pozadini. Druge aplikacije za poštu na istom računu obično također poštuju ove pretplate.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Čuva vaše Smart Mailboxes za druge uređaje. Skriven na ekranu „Sandučići“.';

  @override
  String get settingsFolderAlwaysShown => 'Uvijek se prikazuje';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Pretplati se na folder $folder';
  }

  @override
  String get settingsIdentities => 'Identiteti';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Prvi identitet je zadani za nove poruke. Prevucite da promijenite redoslijed.';

  @override
  String get settingsIdentitiesFooterSingle => 'Zadani identitet za nove poruke.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odgovor se šalje s identiteta na koji je poruka poslana.';

  @override
  String get settingsIdentityDefault => 'Zadani';

  @override
  String settingsIdentityReorder(String email) {
    return 'Promijeni redoslijed: $email';
  }

  @override
  String get settingsAddIdentity => 'Dodaj identitet';

  @override
  String get settingsNewIdentity => 'Novi identitet';

  @override
  String get settingsIdentity => 'Identitet';

  @override
  String get settingsIdentityNameHint => 'Vaše ime';

  @override
  String get settingsReplyTo => 'Adresa za odgovor';

  @override
  String get settingsSignature => 'Potpis';

  @override
  String get settingsSignatureFooter => 'Dodaje se ispod „-- “ u porukama s ovog identiteta.';

  @override
  String get settingsNoSignature => 'Bez potpisa';

  @override
  String get settingsCopyToMyself => 'Kopija za mene';

  @override
  String get settingsCopyToMyselfFooter => 'Dodaje se svakoj poruci s ovog identiteta.';

  @override
  String get settingsCc => 'Kopija';

  @override
  String get settingsBcc => 'Skrivena kopija';

  @override
  String get settingsReplyPatterns => 'Koristi za odgovore na adrese';

  @override
  String get settingsReplyPatternsFooter =>
      'Odgovori na poruke poslane na ove adrese šalju se s ovog identiteta. * zamjenjuje bilo šta: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adresa ili uzorak u kojem * zamjenjuje bilo šta.';

  @override
  String get settingsAddReplyPattern => 'Dodaj adresu ili uzorak';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Ukloni $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Neispravan uzorak';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ nije adresa ni uzorak poput *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nema adrese';

  @override
  String get settingsIdentityNoAddressMessage => 'Unesite adresu e-pošte s koje se šalje.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Neispravna adresa';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Adresa za odgovor: „$address“ nije ispravna adresa e-pošte.',
      'cc': 'Kopija: „$address“ nije ispravna adresa e-pošte.',
      'bcc': 'Skrivena kopija: „$address“ nije ispravna adresa e-pošte.',
      'other': '„$address“ nije ispravna adresa e-pošte.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Sačuvaj identitet';

  @override
  String get settingsDiscardChanges => 'Odbaci izmjene';

  @override
  String get settingsDeleteIdentity => 'Izbriši identitet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Izbrisati „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Poruke koje su već poslane s njega ostaju nepromijenjene.';

  @override
  String get settingsLastIdentityFooter => 'Račun mora imati barem jedan identitet.';

  @override
  String get rulesTitle => 'Pravila';

  @override
  String get rulesNewRule => 'Novo pravilo';

  @override
  String get rulesLoadError => 'Učitavanje pravila nije uspjelo.';

  @override
  String get rulesEmptyTitle => 'Nema pravila';

  @override
  String get rulesEmptyText =>
      'Pravila umjesto vas razvrstavaju novu poštu po folderima i dodaju joj oznake i zastavice. Napravite pravilo dugmetom za pisanje gore ili iz pretrage pomoću „Napravi pravilo“.';

  @override
  String get rulesListFooter =>
      'Pravila se primjenjuju odozgo prema dolje na novu poštu u prijemnom sandučetu. Dodirnite i zadržite pravilo da biste ga pomjerili.';

  @override
  String get rulesChangeError => 'Izmjena pravila nije uspjela';

  @override
  String get rulesConditionEveryMessage => 'Svaka poruka';

  @override
  String rulesMoveRule(String rule) {
    return 'Pomjeri pravilo $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Pravilo $rule uključeno';
  }

  @override
  String get rulesServerRulesHeader => 'Pravila na serveru';

  @override
  String get rulesServerRulesFooter =>
      'Pravila na serveru izvršava server e-pošte čim pošta stigne, čak i kada je ovaj telefon isključen. Čuvaju se u Sieve skripti pod imenom „loupe“.';

  @override
  String get rulesStatusUnknown => 'Nepoznato';

  @override
  String get rulesStatusError => 'Upit serveru nije uspio.';

  @override
  String get rulesStatusChecking => 'Provjera…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Izvršava ih skripta „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktivna skripta je „$script“. Dodirnite da izvršava i pravila aplikacije Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na serveru nije aktivna nijedna skripta. Kada sačuvate pravilo na serveru, uključuje se skripta aplikacije Loupe.';

  @override
  String get rulesStatusUnavailable => 'Nije dostupno';

  @override
  String get rulesStatusNoSieve => 'Server ovog računa ne nudi Sieve (ManageSieve ili JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Premjesti u folder $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Premjesti u folder';

  @override
  String rulesActionTag(String tag) {
    return 'Dodaj oznaku $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Ukloni oznaku $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Zadrži u prijemnom sandučetu';

  @override
  String rulesActionForward(String address) {
    return 'Proslijedi na $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Proslijedi na $address, bez kopije';
  }

  @override
  String get rulesActionStop => 'Bez daljih pravila';

  @override
  String get rulesNoActions => 'Još ne radi ništa';

  @override
  String get rulesLocationDevice => 'Uređaj';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Ovaj uređaj';

  @override
  String get rulesNewRuleTitle => 'Novo pravilo';

  @override
  String get rulesEditRuleTitle => 'Uredi pravilo';

  @override
  String get rulesDefaultNameEveryMessage => 'Svaka poruka';

  @override
  String get rulesConditionHeader => 'Kada nova poruka odgovara uslovu';

  @override
  String get rulesConditionFooter =>
      'Pišite kao u pretrazi: from:, to:, s: (predmet), b: (tijelo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:račun';

  @override
  String get rulesAccounts => 'Računi';

  @override
  String get rulesAllAccounts => 'Svi računi';

  @override
  String get rulesRemovedAccount => 'Uklonjen račun';

  @override
  String get rulesAccountsFooter => 'Pravilo za sve račune važi i za račune koje dodate kasnije.';

  @override
  String get rulesActionsHeader => 'Tada';

  @override
  String get rulesForwardingFooter =>
      'Prosljeđivanje šalje svaku poruku koja odgovara uslovu na drugu adresu čim stigne, čak i kada je ovaj telefon isključen. Neki pružaoci usluga ograničavaju koliko se pošte može proslijediti.';

  @override
  String get rulesForwardingHiddenFooter => 'Prosljeđivanje radi samo u pravilima na serveru, pa ovdje nije ponuđeno.';

  @override
  String rulesRemoveAction(String action) {
    return 'Ukloni: $action';
  }

  @override
  String get rulesAddAction => 'Dodaj radnju';

  @override
  String get rulesAddMove => 'Premjesti u folder…';

  @override
  String get rulesAddTagMenu => 'Dodaj oznaku…';

  @override
  String get rulesRemoveTagMenu => 'Ukloni oznaku…';

  @override
  String get rulesAddForward => 'Proslijedi na…';

  @override
  String get rulesStopProcessing => 'Ne izvršavaj sljedeća pravila';

  @override
  String get rulesRunOnHeader => 'Gdje se izvršava';

  @override
  String get rulesRunOnDeviceFooter =>
      'Ovaj uređaj primjenjuje pravilo na novu poštu u prijemnom sandučetu svaki put kada Loupe provjeri poštu.';

  @override
  String get rulesRunOnServerFooter =>
      'Server e-pošte izvršava pravilo čim pošta stigne, čak i kada je ovaj telefon isključen. Potreban je Sieve, putem ManageSieve (Dovecot, mailcow) ili JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Primijeni na postojeće poruke…';

  @override
  String get rulesDeleteRule => 'Izbriši pravilo';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Izbrisati pravilo „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Folder u kojem računu?';

  @override
  String get rulesMoveAccountMessage => 'Pošta ostalih računa ide u istoimeni folder u tim računima.';

  @override
  String get rulesAddTag => 'Dodaj oznaku';

  @override
  String get rulesRemoveTag => 'Ukloni oznaku';

  @override
  String get rulesForwardTo => 'Proslijedi na';

  @override
  String get rulesForwardToMessage =>
      'Server prosljeđuje svaku poruku koja odgovara uslovu na ovu adresu, čak i kada je ovaj telefon isključen. Unesite adresu koja je vaša ili kojoj vjerujete.';

  @override
  String get rulesNotAnAddressTitle => 'Nije adresa e-pošte';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ nije adresa na koju se može prosljeđivati.';
  }

  @override
  String get rulesKeepCopyTitle => 'Zadržati kopiju ovdje?';

  @override
  String get rulesKeepCopy => 'Zadrži kopiju';

  @override
  String get rulesDontKeepCopy => 'Bez kopije';

  @override
  String get rulesCheckCondition => 'Provjerite uslov';

  @override
  String get rulesChooseActionTitle => 'Odaberite radnju';

  @override
  String get rulesChooseActionMessage => 'Dodajte šta pravilo radi s porukama koje odgovaraju uslovu.';

  @override
  String get rulesSaveError => 'Čuvanje pravila nije uspjelo';

  @override
  String get rulesSaveServerError => 'Čuvanje pravila na serveru nije uspjelo';

  @override
  String get rulesRunOnDeviceInstead => 'Prebaci na ovaj uređaj';

  @override
  String get rulesNothingToApplyTitle => 'Nema se šta primijeniti';

  @override
  String get rulesNothingToApplyMessage => 'Prvo pravilu zadajte ispravan uslov i radnju.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Gdje primijeniti „$rule“?';
  }

  @override
  String get rulesApplyScopeInboxes => 'Prijemni sandučići';

  @override
  String get rulesApplyScopeAll => 'Svi sandučići';

  @override
  String get rulesFindingMessages => 'Traženje poruka…';

  @override
  String get rulesSearchError => 'Pretraga nije uspjela';

  @override
  String get rulesSearchErrorUnknown => 'Došlo je do greške.';

  @override
  String get rulesNoMatchesTitle => 'Nema odgovarajućih poruka';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Tamo nijedna poruka ne odgovara uslovu „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Primijeniti „$rule“ na $countString poruka?',
      few: 'Primijeniti „$rule“ na $countString poruke?',
      one: 'Primijeniti „$rule“ na $countString poruku?',
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
      other: 'Primijeni na $countString poruka',
      few: 'Primijeni na $countString poruke',
      one: 'Primijeni na $countString poruku',
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
      other: 'Pravilo „$rule“ primijenjeno je na $countString poruka',
      few: 'Pravilo „$rule“ primijenjeno je na $countString poruke',
      one: 'Pravilo „$rule“ primijenjeno je na $countString poruku',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Provjera mogućnosti servera…';

  @override
  String get rulesServerUnreachable => 'Povezivanje sa serverom nije uspjelo.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ne može se izvršavati na serveru: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ne može se izvršavati na serveru računa $account: $problem';
  }

  @override
  String get rulesShowScript => 'Prikaži skriptu';

  @override
  String get rulesHideScript => 'Sakrij skriptu';

  @override
  String get rulesMatchingHeader => 'Odgovarajuće poruke';

  @override
  String get rulesMatchingHeaderLoading => 'Odgovarajuće poruke…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString odgovarajućih poruka',
      few: '$countString odgovarajuće poruke',
      one: '$countString odgovarajuća poruka',
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
      other: '$countString+ odgovarajućih poruka',
      few: '$countString+ odgovarajuće poruke',
      one: '$countString+ odgovarajuća poruka',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Iz posljednjih 30 dana. Pravilo inače djeluje samo na novu poštu, osim ako ga ne primijenite i na postojeće poruke.';

  @override
  String rulesConditionError(String error) {
    return 'Uslov sadrži grešku: $error';
  }

  @override
  String get rulesPreviewNoSender => '(bez pošiljaoca)';

  @override
  String get rulesPreviewNoSubject => '(bez predmeta)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'i još $countString',
      few: 'i još $countString',
      one: 'i još $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ništa iz posljednjih 30 dana.';

  @override
  String get rulesIncludeTitle => 'Uključivanje pravila na serveru';

  @override
  String get rulesIncludeLeaveOff => 'Ne uključuj';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Server već izvršava pravila aplikacije Loupe za račun $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return 'Na serveru računa $account aktivna je skripta „$script“, pa server izvršava nju, a ne pravila aplikacije Loupe. Loupe je neće zamijeniti. Može joj dodati ove redove, pa će server izvršavati pravila aplikacije Loupe nakon pravila same skripte:';
  }

  @override
  String get rulesShowWholeScript => 'Prikaži cijelu skriptu';

  @override
  String get rulesHideWholeScript => 'Sakrij cijelu skriptu';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ništa drugo u skripti „$script“ se ne mijenja. Ako se njeni filteri kasnije izmijene u web-pošti, web-pošta je može prepisati bez ovih redova; Loupe će tada ponovo prikazati pravila na serveru kao isključena.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Dodaj u skriptu „$script“';
  }

  @override
  String get subscriptionsTitle => 'Pretplate';

  @override
  String get subscriptionsNewsletters => 'Bilteni';

  @override
  String get subscriptionsDiscussions => 'Diskusije';

  @override
  String get subscriptionsFilter => 'Filter';

  @override
  String get subscriptionsFilterNeverRead => 'Nikad čitani';

  @override
  String get subscriptionsFilterRarelyRead => 'Rijetko čitani';

  @override
  String get subscriptionsFilterAll => 'Svi';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Brojanje pretplata nije uspjelo';

  @override
  String get subscriptionsNoMatches => 'Nema rezultata';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nijedan bilten se ne zove „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nijedna lista se ne zove „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Nema biltena';

  @override
  String get subscriptionsNoNewslettersDetail => 'Bilteni i druga masovna pošta pojavljuju se ovdje čim stignu.';

  @override
  String get subscriptionsNothingNeverRead => 'Nema biltena koje nikad ne čitate';

  @override
  String get subscriptionsNothingRarelyRead => 'Nema biltena koje rijetko čitate';

  @override
  String get subscriptionsNothingFilteredDetail => 'Od svega što dobijate ponešto i pročitate.';

  @override
  String get subscriptionsNoDiscussions => 'Nema diskusija';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mailing liste na koje možete pisati pojavljuju se ovdje čim stigne njihova pošta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Liste na koje piše više ljudi. Dodirnite i zadržite listu da je zakačite u Sandučiće, čitate kao običan tekst ili premjestite u Biltene.';

  @override
  String get subscriptionsPrivacyNote =>
      'Prebrojano na ovom telefonu iz preuzete pošte; ništa se nikuda ne šalje da bi se ovo izračunalo. Loupe kontaktira pošiljaoca samo kada dodirnete „Odjavi se“: odjava jednim dodirom šalje samo „List-Unsubscribe=One-Click“ na adresu koju navodi pošiljalac, bez kolačića i bez ičega drugog o vama, i nikad ne učitava njegove stranice ni slike.';

  @override
  String get subscriptionsVolumeNone => 'Ništa u posljednje vrijeme';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mjesec';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mjesec';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'pročitano $percent';
  }

  @override
  String get subscriptionsStillSending => 'I dalje šalje';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Odjavljeno $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Stranica za odjavu otvorena $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Jednim dodirom · kontaktira $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-poštom na $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Na web-stranici $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Odjavi se';

  @override
  String get subscriptionsUnsubscribeAgain => 'Odjavi se ponovo';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhiviraj $countString iz prijemnog sandučeta',
      few: 'Arhiviraj $countString iz prijemnog sandučeta',
      one: 'Arhiviraj $countString iz prijemnog sandučeta',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Napravi pravilo…';

  @override
  String get subscriptionsCreateRuleDetail => 'Premjesti ili arhiviraj buduću poštu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Smatraj diskusijom';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Lista na koju ljudi pišu: čitajte je kao forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Smatraj biltenom';

  @override
  String get subscriptionsBlockSender => 'Blokiraj pošiljaoca';

  @override
  String get subscriptionsBlock => 'Blokiraj';

  @override
  String get subscriptionsBlocked => 'Blokirano';

  @override
  String get subscriptionsBlockedDetail => 'Nove poruke idu u neželjenu poštu';

  @override
  String get subscriptionsPin => 'Zakači u Sandučiće';

  @override
  String get subscriptionsUnpin => 'Otkači iz Sandučića';

  @override
  String get subscriptionsOpenDefaultView => 'Otvori u zadanom prikazu';

  @override
  String get subscriptionsOpenPlainText => 'Otvori kao običan tekst (mono)';

  @override
  String get subscriptionsPinned => 'Zakačeno';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString nepročitanih',
      few: '$countString nepročitane',
      one: '$countString nepročitana',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Trenutno nema pošte ovog pošiljaoca.';

  @override
  String get subscriptionsLatestMessages => 'NAJNOVIJE PORUKE';

  @override
  String get subscriptionsMail => 'Pošta';

  @override
  String get subscriptionsNoneIn90Days => 'Ništa u posljednjih 90 dana';

  @override
  String get subscriptionsRead => 'Pročitano';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString od $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Posljednja poruka';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foldera',
      few: '$count foldera',
      one: '$count folder',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'I dalje šalje';

  @override
  String get subscriptionsUnsubscribedTitle => 'Odjavljeno';

  @override
  String subscriptionsSince(String date) {
    return 'od $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'stranica otvorena $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender ne navodi kako se odjaviti.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender ne navodi kako se odjaviti. Umjesto toga, možete ga blokirati.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Odjavljivanje od pošiljaoca $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Odjavljeno od pošiljaoca $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Odjava nije uspjela: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatska odjava nije uspjela';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Pošalji poruku za odjavu';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Otvori $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Otvoriti $site?';
  }

  @override
  String get subscriptionsOpen => 'Otvori';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender nudi odjavu na svojoj web-stranici. Stranica se otvara u pregledniku aplikacije Loupe; tamo dovršite odjavu.';
  }

  @override
  String get subscriptionsWebInsecure => 'Veza s ovom stranicom nije šifrirana.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Pažnja: ova adresa oponaša $site pomoću slova sličnog izgleda.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Pažnja: ova adresa oponaša drugu stranicu pomoću slova sličnog izgleda.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Nije moguće otvoriti $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe bilježi današnji datum i obavijestit će vas ako $sender nastavi slati poštu.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Odjaviti se od pošiljaoca $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe će kontaktirati $site radi odjave.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Ovo je jedini slučaj kada Loupe kontaktira web-stranicu pošiljaoca. Šalje samo „List-Unsubscribe=One-Click“ na adresu koju navodi $sender, bez kolačića i bez ičega drugog o vama, i ne učitava stranicu.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Link za odjavu nije sigurna adresa na internetu.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Stranica $site nije odgovorila na vrijeme.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Stranica $site nije dostupna.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Stranica $site je proslijedila zahtjev na drugu stranicu, a Loupe ne prati preusmjeravanja.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Stranica $site je odbila zahtjev (greška $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nema računa s kojeg bi se poslala poruka za odjavu.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe će poslati poruku na $to s adrese $from, s predmetom „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Poruka za odjavu poslana je na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Blokirati pošiljaoca $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nove poruke s ove liste ići će u neželjenu poštu. To možete promijeniti u „Postavke › Pravila“.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nove poruke s adrese $address ići će u neželjenu poštu. To možete promijeniti u „Postavke › Pravila“.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Pošiljalac $sender je blokiran.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Premjesti $count u neželjenu poštu',
      few: 'Premjesti $count u neželjenu poštu',
      one: 'Premjesti $count u neželjenu poštu',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokiraj $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender je sada u Biltenima.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender je sada u Diskusijama.';
  }

  @override
  String get appLiveGateTitle => 'Vaše račune nije moguće otvoriti';

  @override
  String get appLiveGateUnavailableBuild => 'Pravi računi još nisu dostupni u ovoj verziji.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nije mogao pročitati ključ koji štiti vašu poštu na ovom telefonu. To je često privremeno: pokušajte ponovo ili ponovo pokrenite telefon.';

  @override
  String get appLiveGateKeyMissing =>
      'Ključ koji štiti vašu poštu na ovom telefonu je nestao, što se može desiti nakon vraćanja sigurnosne kopije. Vaša pošta je i dalje na serveru.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Baza pošte na ovom telefonu ne može se pročitati: oštećena je ili joj se ključ promijenio. Vaša pošta je i dalje na serveru.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Došlo je do greške pri otvaranju vaših računa ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Ovim se brišu vaši računi i pošta sačuvana na ovom telefonu, uključujući poruke koje čekaju u Odlaznom sandučetu. Pošta na vašim serverima ostaje netaknuta; nakon toga ponovo dodajte račune.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Izbriši i počni ispočetka';

  @override
  String get appLiveGateUseDemo => 'Koristi demo poštu';

  @override
  String get appLiveGateReset => 'Resetuj poštu na ovom telefonu…';

  @override
  String get attachmentsUntitled => 'Prilog';

  @override
  String get attachmentsUntitledFile => 'Bez naziva';

  @override
  String get attachmentsOpenIn => 'Otvori u…';

  @override
  String get attachmentsSaveToFiles => 'Sačuvaj u datoteke';

  @override
  String get attachmentsShareMenu => 'Podijeli…';

  @override
  String get attachmentsDownloadError => 'Prilog nije moguće preuzeti. Provjerite vezu i pokušajte ponovo.';

  @override
  String get attachmentsShareError => 'Prilog nije moguće podijeliti.';

  @override
  String attachmentsNoApp(String type) {
    return 'Nijedna aplikacija na ovom uređaju ne otvara ovu datoteku ($type). Probajte „Podijeli“.';
  }

  @override
  String get attachmentsOpenInError => 'Prilog nije moguće otvoriti u drugoj aplikaciji.';

  @override
  String attachmentsSaved(String name) {
    return 'Sačuvano: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Prilog nije moguće sačuvati.';

  @override
  String get attachmentsGone => 'Ovaj prilog više nije dostupan.';

  @override
  String get attachmentsDownloadFailed => 'Prilog nije moguće preuzeti.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stranica',
      few: '$count stranice',
      one: '$count stranica',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size preko mobilnih podataka';
  }

  @override
  String get attachmentsLargeDownload => 'Ovaj prilog je velik. Preuzmite ga sada ili kasnije preko Wi-Fi mreže.';

  @override
  String get attachmentsDownload => 'Preuzmi';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Preuzima se $size…';
  }

  @override
  String get attachmentsDownloading => 'Preuzimanje…';

  @override
  String get attachmentsTooLarge => 'Preveliko za pregled ovdje.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Prikazano je prvih $shown od $total. Kopirajte, podijelite ili sačuvajte da biste dobili sve.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Ovaj PDF se ne može prikazati ovdje (možda je zaštićen lozinkom).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page od $count';
  }

  @override
  String get attachmentsModeTable => 'Tabela';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Poruka';

  @override
  String get attachmentsModeSource => 'Izvor';

  @override
  String get attachmentsDontWrap => 'Ne prelamaj redove';

  @override
  String get attachmentsWrap => 'Prelamaj redove';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines redova',
      few: '$lines reda',
      one: '$count red',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiraj sve';

  @override
  String get attachmentsCopied => 'Kopirano';

  @override
  String get attachmentsImageUnavailable => 'Ova slika se ne može prikazati ovdje. Probajte „Otvori u…“.';

  @override
  String get attachmentsEmlNoSubject => '(Bez predmeta)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Za';

  @override
  String get attachmentsEmlCc => 'Kopija';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Ova poruka nema teksta.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count priloga: $names',
      few: '$count priloga: $names',
      one: '$count prilog: $names',
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
      other: 'I još $count događaja',
      few: 'I još $count događaja',
      one: 'I još $count događaj',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Slika';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format slika';
  }

  @override
  String get attachmentsTypePdf => 'PDF dokument';

  @override
  String get attachmentsTypeTsv => 'Vrijednosti razdvojene tabulatorom';

  @override
  String get attachmentsTypeCsv => 'CSV tabela';

  @override
  String get attachmentsTypeCalendar => 'Događaj u kalendaru';

  @override
  String get attachmentsTypeEmail => 'Poruka e-pošte';

  @override
  String get attachmentsTypeContact => 'Kontakt kartica';

  @override
  String get attachmentsTypeLog => 'Datoteka dnevnika';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'ZIP arhiva';

  @override
  String get attachmentsTypeArchive => 'Arhiva';

  @override
  String get attachmentsTypeWord => 'Word dokument';

  @override
  String get attachmentsTypeExcel => 'Excel tabela';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint prezentacija';

  @override
  String get attachmentsTypeWebPage => 'Web stranica';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension datoteka';
  }

  @override
  String get attachmentsTypeFile => 'Datoteka';

  @override
  String get calendarUntitledEvent => 'Događaj';

  @override
  String get calendarAllDay => 'Cijeli dan';

  @override
  String calendarYourTime(String time) {
    return '$time po vašem vremenu';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Link za sastanak: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvata poziv: $details',
      'tentative': '$name uslovno prihvata poziv: $details',
      'declined': '$name odbija poziv: $details',
      'delegated': '$name delegira poziv: $details',
      'other': '$name – bez odgovora na poziv: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvata poziv',
      'tentative': '$name uslovno prihvata poziv',
      'declined': '$name odbija poziv',
      'delegated': '$name delegira poziv',
      'other': '$name – bez odgovora na poziv',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Pridruži se';

  @override
  String get calendarOnlineMeeting => 'Online sastanak';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider sastanak';
  }

  @override
  String get calendarOrganizerYou => 'Vi';

  @override
  String get calendarOrganizerLabel => 'organizator';

  @override
  String get calendarStatusAccepted => 'Prihvaćeno';

  @override
  String get calendarStatusMaybe => 'Možda';

  @override
  String get calendarStatusDeclined => 'Odbijeno';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvata poziv',
      'tentative': '$name uslovno prihvata poziv',
      'declined': '$name odbija poziv',
      'delegated': '$name delegira poziv',
      'other': '$name – bez odgovora',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvata poziv:',
      'tentative': '$name uslovno prihvata poziv:',
      'declined': '$name odbija poziv:',
      'delegated': '$name delegira poziv:',
      'other': '$name – bez odgovora:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name predlaže novi termin';
  }

  @override
  String get calendarCounterUnknown => 'Učesnik predlaže novi termin';

  @override
  String get calendarDeclineCounter => 'Organizator zadržava prvobitni termin';

  @override
  String calendarRefresh(String name) {
    return '$name traži najnoviju verziju događaja';
  }

  @override
  String get calendarRefreshUnknown => 'Učesnik traži najnoviju verziju događaja';

  @override
  String get calendarCancelled => 'Otkazano';

  @override
  String get calendarCancelledByOrganizer => 'Organizator je otkazao ovaj događaj.';

  @override
  String get calendarCancelledLater => 'Ovaj događaj je kasnije otkazan.';

  @override
  String get calendarOutdated => 'Zastarjelo';

  @override
  String get calendarOutdatedDetail => 'Ovaj poziv je kasnije ažuriran; važi novija verzija.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Lokacija je uklonjena (bila je: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Lokacija je uklonjena (nije ni bila navedena)';

  @override
  String calendarLocationChanged(String location) {
    return 'Nova lokacija: $location';
  }

  @override
  String get calendarNewTitle => 'Novi naslov';

  @override
  String get calendarRepeatChanged => 'Ponavljanje je promijenjeno';

  @override
  String get calendarUpdated => 'Ažurirano';

  @override
  String get calendarUpdatedInvitation => 'Ažuriran poziv';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Vrijeme je promijenjeno s $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Nepoznata vremenska zona „$zone“: vremena su prikazana onako kako su napisana';
  }

  @override
  String calendarNext(String when) {
    return 'Sljedeće: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gostiju',
      few: '$count gosta',
      one: '$count gost',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'prihvaćeno: $count',
      few: 'prihvaćeno: $count',
      one: 'prihvaćeno: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'možda: $count',
      few: 'možda: $count',
      one: 'možda: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'odbijeno: $count',
      few: 'odbijeno: $count',
      one: 'odbijeno: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (vi)';
  }

  @override
  String get calendarAttendeeOptional => 'neobavezno';

  @override
  String get calendarAttendeeRoom => 'prostorija';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Prihvatili ste raniju verziju.',
      'tentative': 'Uslovno ste prihvatili raniju verziju.',
      'declined': 'Odbili ste raniju verziju.',
      'delegated': 'Delegirali ste raniju verziju.',
      'other': 'Niste odgovorili na raniju verziju.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Prihvati';

  @override
  String get calendarMaybe => 'Možda';

  @override
  String get calendarDecline => 'Odbij';

  @override
  String get calendarCommentHint => 'Komentar za organizatora (neobavezno)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Vaš odgovor ide organizatoru $organizer s adrese $address.';
  }

  @override
  String get calendarAddComment => 'Dodaj komentar';

  @override
  String get calendarAddToCalendar => 'Dodaj u kalendar';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I još $count događaja u datoteci',
      few: 'I još $count događaja u datoteci',
      one: 'I još $count događaj u datoteci',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Nema aplikacije za kalendar u koju bi se dodao događaj.';

  @override
  String get calendarCantOpenCalendar => 'Otvaranje kalendara nije uspjelo.';

  @override
  String get calendarCantOpenLink => 'Otvaranje linka nije uspjelo.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Pridružiti se $provider sastanku?';
  }

  @override
  String get calendarJoinTitle => 'Pridružiti se sastanku?';

  @override
  String calendarJoinOpens(String host) {
    return 'Otvara $host u vašem pregledniku.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Pažnja: ova adresa oponaša $site pomoću slova sličnog izgleda.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Pažnja: ova adresa oponaša drugu stranicu pomoću slova sličnog izgleda.';

  @override
  String calendarJoinOpen(String host) {
    return 'Otvori $host';
  }

  @override
  String get calendarNoOrganizer => 'Ovaj poziv nema organizatora kojem bi se odgovorilo.';

  @override
  String get calendarNoAccount => 'Nema računa s kojeg bi se poslao odgovor.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Prihvaćeno',
      'tentative': 'Možda',
      'other': 'Odbijeno',
    });
    return '$_temp0 · odgovor se šalje organizatoru $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Prihvaćeno',
      'tentative': 'Možda',
      'other': 'Odbijeno',
    });
    return '$_temp0 · odgovor je poslan';
  }

  @override
  String get calendarReplyAlreadySent => 'Odgovor je već poslan.';

  @override
  String get calendarReplyNotSent => 'Odgovor nije poslan.';

  @override
  String get dataSmimeNeedsDevice =>
      'Vaš S/MIME certifikat je na ovom uređaju: otvorite Loupe da biste potpisali i poslali ovu poruku.';

  @override
  String dataSigningFailed(String error) {
    return 'Potpisivanje nije uspjelo: $error';
  }

  @override
  String get keyboardShortcuts => 'Prečice na tastaturi';

  @override
  String get keyboardGroupGeneral => 'Općenito';

  @override
  String get keyboardGroupMessages => 'Poruke';

  @override
  String get keyboardGroupCompose => 'Pisanje';

  @override
  String get keyboardCommandPalette => 'Paleta komandi';

  @override
  String get keyboardBackClose => 'Nazad, zatvori';

  @override
  String get keyboardNextMessage => 'Sljedeća poruka';

  @override
  String get keyboardPreviousMessage => 'Prethodna poruka';

  @override
  String get keyboardOpenMessage => 'Otvori poruku';

  @override
  String get keyboardMoveToTrash => 'Premjesti u smeće';

  @override
  String get keyboardToggleRead => 'Označi kao pročitano ili nepročitano';

  @override
  String get keyboardToggleFlag => 'Dodaj ili ukloni zastavicu';

  @override
  String get keyboardCloseDraft => 'Zatvori (sačuvaj ili izbriši nacrt)';

  @override
  String get keyboardOr => 'ili';

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
  String get mailingListsMuted => 'Nit je utišana. Nove poruke u njoj stižu kao pročitane.';

  @override
  String get mailingListsUnmuted => 'Utišavanje niti je ukinuto.';

  @override
  String get mailingListsMuteThread => 'Utišaj nit';

  @override
  String get mailingListsUnmuteThread => 'Ukini utišavanje niti';

  @override
  String get mailingListsPin => 'Zakači u Sandučiće';

  @override
  String get mailingListsUnpin => 'Otkači iz Sandučića';

  @override
  String get mailingListsDefaultView => 'Otvori u zadanom prikazu';

  @override
  String get mailingListsPlainText => 'Otvori kao običan tekst (mono)';

  @override
  String get mailingListsShowMuted => 'Prikaži utišane niti';

  @override
  String get mailingListsHideMuted => 'Sakrij utišane niti';

  @override
  String get mailingListsTreatAsNewsletter => 'Smatraj biltenom';

  @override
  String get mailingListsOptions => 'Opcije liste';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted nepročitanih',
      few: '$formatted nepročitane',
      one: '$count nepročitana',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nova poruka listi';

  @override
  String get mailingListsRowUnread => 'Nepročitano';

  @override
  String get mailingListsRowMuted => 'Utišano';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odgovora',
      few: '$count odgovora',
      one: '$count odgovor',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Nema niti';

  @override
  String get mailingListsMutedHidden => 'Utišane niti su skrivene.';

  @override
  String get mailingListsTechnicalTitle => 'Tehničke liste';

  @override
  String get mailingListsTechnicalEmpty => 'Mailing liste pojavljuju se ovdje čim stigne njihova pošta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Poruke s ovih lista otvaraju se kao običan tekst u fontu fiksne širine, a zakrpe se prikazuju kao razlike (diff). Dugmetom Aa i dalje možete promijeniti prikaz bilo koje poruke.';

  @override
  String get paletteMoveToMailbox => 'Premjesti u sanduče…';

  @override
  String get paletteMarkAllRead => 'Označi sve kao pročitano';

  @override
  String get paletteExportFolder => 'Izvezi folder…';

  @override
  String get paletteGetNewMail => 'Preuzmi novu poštu';

  @override
  String get paletteSnoozed => 'Odgođeno';

  @override
  String get paletteSubscriptions => 'Pretplate';

  @override
  String get paletteDiscussions => 'Diskusije';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailing lista';

  @override
  String get paletteTag => 'Oznaka';

  @override
  String get paletteSwipeActions => 'Radnje prevlačenja';

  @override
  String get paletteNotifications => 'Obavještenja';

  @override
  String get paletteRules => 'Pravila';

  @override
  String get paletteEncryption => 'Šifriranje s kraja na kraj';

  @override
  String get paletteAdvanced => 'Napredno';

  @override
  String get paletteAddAccount => 'Dodaj račun';

  @override
  String get paletteAccount => 'Račun';

  @override
  String get paletteFolders => 'Folderi';

  @override
  String get paletteRecentSearch => 'Nedavna pretraga';

  @override
  String paletteSearchMail(String query) {
    return 'Pretraži poštu: „$query“';
  }

  @override
  String get palettePlaceholder => 'Pretražite radnje, sandučiće, postavke';

  @override
  String get paletteNothingFound => 'Ništa nije pronađeno';

  @override
  String get searchNewSmartMailbox => 'Novi Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Prikazuje sve što odgovara upitu „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ je sačuvano u Sandučiće';
  }

  @override
  String get searchMakeRule => 'Napravi pravilo';

  @override
  String get searchSaveSmartMailbox => 'Sačuvaj kao Smart Mailbox';

  @override
  String get searchNegate => 'Negiraj';

  @override
  String get searchDontNegate => 'Ukini negaciju';

  @override
  String get searchAllMailboxes => 'Svi sandučići';

  @override
  String get searchRecent => 'Nedavne pretrage';

  @override
  String get searchClear => 'Obriši';

  @override
  String get searchSuggestions => 'Prijedlozi';

  @override
  String get searchUnreadMessages => 'Nepročitane poruke';

  @override
  String get searchFlaggedMessages => 'Poruke označene zastavicom';

  @override
  String get searchWithAttachments => 'Poruke s prilozima';

  @override
  String get searchUnrepliedMessages => 'Poruke bez odgovora';

  @override
  String get searchTags => 'Oznake';

  @override
  String get searchPeople => 'Ljudi';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Od: $name';
  }

  @override
  String get searchSearching => 'Pretraživanje…';

  @override
  String get searchNoResults => 'Nema rezultata';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted rezultata',
      few: '$formatted rezultata',
      one: '$count rezultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Meni pretrage';

  @override
  String searchSearchingAccount(String account) {
    return 'Pretraživanje računa $account na serveru…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Pretraživanje računa na serveru…';

  @override
  String searchAccountFailed(String account) {
    return 'Pretraga računa $account na serveru nije uspjela';
  }

  @override
  String get searchUnknownAccountFailed => 'Pretraga računa na serveru nije uspjela';

  @override
  String searchChip(String term) {
    return '$term. Dvaput dodirnite za uređivanje.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Negirano: $term. Dvaput dodirnite za uređivanje.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerovo prijemno sanduče: svaka poruka ovdje je i pročitana i nepročitana dok je ne otvorite.';

  @override
  String searchContradiction(String term) {
    return 'Nijedna poruka ne može u isto vrijeme biti i ne biti „$term“.';
  }

  @override
  String get searchSyncDeviceOnly => 'Samo na ovom uređaju';

  @override
  String searchSyncUnsupported(String account) {
    return 'Samo na ovom uređaju: račun $account ga ne može čuvati';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nije sinhronizirano: račun $account ima noviji format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Čeka sinhronizaciju s računom $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinhronizirano s računom $account';
  }

  @override
  String get searchRename => 'Preimenuj';

  @override
  String get searchEditSearch => 'Uredi pretragu';

  @override
  String get searchDeleteSmartMailbox => 'Izbriši Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Preimenuj Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Ovaj Smart Mailbox je izbrisan.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes ostaju na ovom uređaju.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes se čuvaju na vašem serveru e-pošte, pa ih imaju i vaši drugi uređaji, kao i Thunderbird s dodatkom Expression Search Reloaded. Oni koji pretražuju sve račune čuvaju se na računu $account, a oni za jedan folder na računu tog foldera.';
  }

  @override
  String get searchSyncVia => 'Sinhroniziraj putem';

  @override
  String get searchSyncViaFooter => 'Odaberite isti račun na svakom uređaju.';

  @override
  String get searchGmailCantKeep => 'Gmail ne može čuvati Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Čuvaj Smart Mailboxes samo na ovom uređaju';

  @override
  String get searchOnTheServer => 'Na serveru';

  @override
  String get searchServerFooter =>
      'Metapodaci na serveru (IMAP METADATA) ne prikazuju se ni u jednoj aplikaciji za poštu. Na serverima bez njih pravi se folder „Loupe Settings“ s jednom porukom; Loupe ga ne prikazuje na ekranu „Sandučići“.';

  @override
  String get searchSyncNow => 'Sinhroniziraj sada';

  @override
  String get searchStateUnsupported => 'Nije podržano';

  @override
  String get searchStateNewerFormat => 'Noviji format';

  @override
  String get searchStateFailed => 'Sinhronizacija nije uspjela';

  @override
  String get searchStateSyncing => 'Sinhronizacija…';

  @override
  String get searchStateWaiting => 'Na čekanju';

  @override
  String get searchStateMetadata => 'Metapodaci na serveru';

  @override
  String get searchStateFolder => 'Folder „Loupe Settings“';

  @override
  String get searchStateNothing => 'Ništa nije sačuvano';

  @override
  String get sharedBack => 'Nazad';

  @override
  String get sharedYesterday => 'Jučer';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date u $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bajtova',
      few: '$count bajta',
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
  String get sharedSyncNoAccounts => 'Nema računa';

  @override
  String get sharedSyncChecking => 'Provjera pošte…';

  @override
  String get sharedSyncFailed => 'Provjera pošte nije uspjela';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Niste na mreži';

  @override
  String get sharedSyncJustNow => 'Ažurirano upravo sada';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ažurirano prije $minutes minuta',
      few: 'Ažurirano prije $minutes minute',
      one: 'Ažurirano prije $minutes minute',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Ažurirano u $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Ažurirano $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Svi prijemni sandučići';

  @override
  String get sharedMailboxUnread => 'Nepročitano';

  @override
  String get sharedMailboxFlagged => 'Označeno zastavicom';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Svi nacrti';

  @override
  String get sharedMailboxAllSent => 'Sve poslano';

  @override
  String get sharedMailboxUntitled => 'Sanduče';

  @override
  String get sharedTagImportant => 'Važno';

  @override
  String get sharedTagWork => 'Posao';

  @override
  String get sharedTagPersonal => 'Lično';

  @override
  String get sharedTagToDo => 'Za obaviti';

  @override
  String get sharedTagLater => 'Kasnije';

  @override
  String get sharedTags => 'Oznake';

  @override
  String get sharedMoveTo => 'Premjesti u…';

  @override
  String get sharedNoRecipients => 'Nema primalaca';

  @override
  String get sharedUnknownSender => 'Nepoznat pošiljalac';

  @override
  String get sharedOnServer => 'Na serveru';

  @override
  String get sharedAttachment => 'Ima prilog';

  @override
  String get sharedSnoozedBadge => 'Odgođeno';

  @override
  String get sharedRowUnread => 'Nepročitano';

  @override
  String get sharedRowBackFromSnooze => 'Vraćeno iz odgađanja';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Označeno zastavicom';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je arhivirano',
      few: '$count poruke su arhivirane',
      one: '$count poruka je arhivirana',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je izbrisano',
      few: '$count poruke su izbrisane',
      one: '$count poruka je izbrisana',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je premješteno u Prijemno sanduče',
      few: '$count poruke su premještene u Prijemno sanduče',
      one: '$count poruka je premještena u Prijemno sanduče',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je premješteno u smeće',
      few: '$count poruke su premještene u smeće',
      one: '$count poruka je premještena u smeće',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je premješteno u neželjenu poštu',
      few: '$count poruke su premještene u neželjenu poštu',
      one: '$count poruka je premještena u neželjenu poštu',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je premješteno u folder $mailbox',
      few: '$count poruke su premještene u folder $mailbox',
      one: '$count poruka je premještena u folder $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je premješteno u folder',
      few: '$count poruke su premještene u folder',
      one: '$count poruka je premještena u folder',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka je odgođeno do $time',
      few: '$count poruke su odgođene do $time',
      one: '$count poruka je odgođena do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odgođeno do $time samo na ovom uređaju: server ne može čuvati vremena odgađanja.';
  }

  @override
  String get sharedMoveOneAccount => 'Odaberite poruke iz jednog računa da biste ih premjestili.';

  @override
  String get sharedSnoozeTitle => 'Odgađanje';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Promijeni vrijeme odgađanja';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trajno izbrisati $count poruka?',
      few: 'Trajno izbrisati $count poruke?',
      one: 'Trajno izbrisati $count poruku?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ovo se ne može poništiti.';

  @override
  String get sharedDeletePermanently => 'Trajno izbriši';

  @override
  String get sharedSwipeRead => 'Pročitano';

  @override
  String get sharedSwipeUnread => 'Nepročitano';

  @override
  String get sharedSwipeInbox => 'U prijemno';

  @override
  String get sharedSwipeDelete => 'Izbriši';

  @override
  String get sharedTrash => 'U smeće';

  @override
  String get sharedSwipeSnooze => 'Odgodi';

  @override
  String get sharedWakeNow => 'Vrati sada';

  @override
  String get sharedChangeSnoozeTime => 'Promijeni vrijeme odgađanja…';

  @override
  String get sharedSnooze => 'Odgodi…';

  @override
  String get sharedTag => 'Oznake…';

  @override
  String get sharedMoveMessage => 'Premjesti poruku…';

  @override
  String get sharedNotJunk => 'Nije neželjena pošta';

  @override
  String get accountSetupTitle => 'Dodavanje računa';

  @override
  String get accountSetupTitleDone => 'Račun je dodan';

  @override
  String get accountSetupAddressTitle => 'Dodajte račun e-pošte';

  @override
  String get accountSetupAddressText => 'Loupe pronalazi postavke za većinu pružalaca usluga.';

  @override
  String get accountSetupNameHint => 'Vaše ime';

  @override
  String get accountSetupEmail => 'E-pošta';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Nastavi';

  @override
  String get accountSetupLookingUp => 'Traženje postavki…';

  @override
  String get accountSetupImport => 'Uvezi iz Thunderbirda';

  @override
  String get accountSetupInvalidEmail => 'Unesite ispravnu adresu e-pošte.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Postavke za $domain nisu pronađene. Unesite ih ispod.';
  }

  @override
  String get accountSetupCheckServers => 'Provjerite nazive servera i portove.';

  @override
  String get accountSetupEnterPassword => 'Unesite lozinku.';

  @override
  String get accountSetupConnecting => 'Povezivanje…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Čeka se $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Stranicu nije moguće otvoriti.';

  @override
  String get accountSetupCouldNotSaveName => 'Ime nije moguće sačuvati.';

  @override
  String get accountSetupTrustCertificate => 'Vjeruj ovom certifikatu';

  @override
  String get accountSetupPasswordRequired => 'Obavezno';

  @override
  String get accountSetupShowPassword => 'Prikaži lozinku';

  @override
  String get accountSetupHidePassword => 'Sakrij lozinku';

  @override
  String get accountSetupAppPassword => 'Lozinka za aplikaciju';

  @override
  String get accountSetupApiToken => 'API token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Dolazna pošta · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Odlazna pošta · SMTP';

  @override
  String get accountSetupSignIn => 'Prijavi se';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Prijavi se putem $provider računa';
  }

  @override
  String get accountSetupUseAppPassword => 'Koristi lozinku za aplikaciju';

  @override
  String get accountSetupUseAppPasswordInstead => 'Ipak koristi lozinku za aplikaciju';

  @override
  String get accountSetupUseDifferentAddress => 'Koristi drugu adresu';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kako napraviti lozinku za aplikaciju';

  @override
  String get accountSetupHowToCreateOne => 'Uputstvo za pravljenje';

  @override
  String get accountSetupGoogleNote =>
      'Prijavljujete se na Googleovoj stranici, a Loupe nikad ne vidi vašu lozinku. Dozvolite aplikaciji Loupe da čita, šalje i organizira vašu poštu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Prijavi se putem Google računa“ još nije dostupno u ovoj verziji. Umjesto toga možete se povezati lozinkom za aplikaciju (potrebna je verifikacija u 2 koraka na vašem Google računu).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Napravite lozinku za aplikaciju u svom Google računu i zalijepite je ispod.';

  @override
  String get accountSetupMicrosoftNote =>
      'Prijavljujete se na Microsoftovoj stranici, a Loupe nikad ne vidi vašu lozinku. Ovo radi za Outlook.com i Hotmail, kao i za poslovne ili školske račune na Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Prijava putem Microsoft računa stiže u jednoj od narednih verzija. Potrebna je za Outlook, Hotmail i Microsoft 365 račune: oni više ne prihvataju lozinke iz aplikacija za e-poštu.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail traži lozinku specifičnu za aplikaciju, a ne lozinku vašeg Apple računa.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail traži lozinku za aplikaciju, a ne lozinku vašeg računa.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se povezuje s Fastmailom preko JMAP-a pomoću API tokena: Settings › Privacy & Security › Manage API tokens, za JMAP, s pristupom e-pošti i slanju.';

  @override
  String get accountSetupFastmailNote => 'Fastmail za aplikacije za e-poštu traži lozinku za aplikaciju.';

  @override
  String get accountSetupServerSettings => 'Postavke servera';

  @override
  String get accountSetupSettingsNotFound => 'Nisu pronađene automatski';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Pronađeno putem: $source';
  }

  @override
  String get accountSetupEditSettings => 'Uredi postavke';

  @override
  String get accountSetupSyncing => 'Vaša pošta se sinhronizira.';

  @override
  String get accountSetupDescription => 'Opis';

  @override
  String get accountSetupDescriptionHint => 'Posao, Lično…';

  @override
  String get accountSetupColour => 'Boja';

  @override
  String accountSetupColourNumber(int number) {
    return 'Boja $number';
  }

  @override
  String get accountSetupSaving => 'Čuvanje…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nije mogao otvoriti bazu pošte na ovom telefonu. Zatvorite Loupe, ponovo ga otvorite i pokušajte opet.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Nešto nije u redu ($error). Pokušajte ponovo.';
  }

  @override
  String get accountSetupSecurityNone => 'Nema';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sigurnost';

  @override
  String get accountSetupUsername => 'Korisničko ime';

  @override
  String get accountSetupUsernameHint => 'Vaša adresa e-pošte';

  @override
  String get accountSetupNoEncryptionTitle => 'Povezati se bez šifriranja?';

  @override
  String get accountSetupNoEncryptionText =>
      'Vaša lozinka i svaka poruka putovale bi kao običan tekst. Svako na mreži, npr. na javnoj Wi-Fi mreži, mogao bi ih pročitati. Ovo koristite samo za server na vlastitoj mreži.';

  @override
  String get accountSetupUseWithoutEncryption => 'Koristi bez šifriranja';

  @override
  String get accountSetupApiTokenRejected =>
      'API token je odbijen. Napravite Fastmail API token za JMAP s pristupom e-pošti i zalijepite ga.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Lozinka je odbijena. Koristite lozinku za aplikaciju, a ne lozinku računa.';

  @override
  String get accountSetupPasswordRejected => 'Lozinka je odbijena. Provjerite je i pokušajte ponovo.';

  @override
  String get accountSetupServerUnreachable => 'Server nije dostupan. Provjerite postavke servera i vezu.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certifikat servera nije pouzdan. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Prijava je otkazana. Dodirnite „Prijavi se putem $provider računa“ da pokušate ponovo.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe treba dozvolu da čita i šalje vašu Gmail poštu. Prijavite se ponovo i dozvolite pristup, uz označeno polje za Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe treba dozvolu da čita i šalje vašu poštu. Prijavite se ponovo i prihvatite dozvole.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Vaša organizacija mora odobriti Loupe prije nego što ga budete mogli koristiti s ovim računom. Zamolite svog IT administratora da u Microsoft Entra ID odobri Loupe za cijelu organizaciju (saglasnost administratora), pa pokušajte ponovo.';

  @override
  String get accountSetupOAuthBlocked =>
      'Pravila prijave vaše organizacije ne dozvoljavaju Loupe na ovom uređaju. Obratite se svom IT administratoru.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Usluga $provider nije dostupna. Provjerite internetsku vezu i pokušajte ponovo.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Prijava putem $provider računa nije ispravno podešena u ovoj verziji aplikacije Loupe. Molimo prijavite to.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Prijava putem $provider računa nije uspjela. Pokušajte ponovo.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Prijava putem $provider računa je uspjela, ali Gmail je odbio pristup za ovu adresu. Pri prijavi odaberite isti račun. Na poslovnim ili školskim računima administrator je možda isključio IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Prijava putem $provider računa je uspjela, ali server e-pošte je odbio pristup za ovu adresu. Pri prijavi odaberite isti račun. Na poslovnim ili školskim računima administrator je možda isključio IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Server e-pošte nije dostupan. Provjerite vezu i pokušajte ponovo.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Prijava putem $provider računa nije dostupna u ovoj verziji.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Ponovo ste prijavljeni. Račun $account se sinhronizira.';
  }

  @override
  String get accountSetupSignInAgain => 'Prijavi se ponovo';

  @override
  String get accountSetupSigningIn => 'Prijavljivanje…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider više ne prihvata prijavu aplikacije Loupe za $email, pa se račun $account ne sinhronizira. Prijavite se ponovo da biste dobijali poštu.';
  }

  @override
  String get accountImportTitle => 'Uvoz iz Thunderbirda';

  @override
  String get accountImportPointCamera => 'Usmjerite kameru prema QR kodu koji prikazuje Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skenirano $scanned od $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Skenirano $scanned od $total kodova',
      few: 'Skenirano $scanned od $total koda',
      one: 'Skenirano $scanned od $total koda',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zasad $count računa',
      few: 'Zasad $count računa',
      one: 'Zasad $count račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Na računaru otvorite Thunderbird i odaberite Alati › Export for Mobile. Odaberite račune, zatim skenirajte svaki kod koji prikaže. Kodovi se mogu skenirati bilo kojim redoslijedom.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nastavi s $count računa',
      few: 'Nastavi s $count računa',
      one: 'Nastavi s $count računom',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Ipak zalijepi tekst';

  @override
  String get accountImportStartOver => 'Počni ispočetka';

  @override
  String get accountImportDuplicateCode => 'Taj kod je već dodan.';

  @override
  String get accountImportRestarted =>
      'Ovaj kod je iz novog izvoza, pa su ranije skenirani kodovi stavljeni po strani.';

  @override
  String get accountImportNotThunderbird => 'Ovo nije Thunderbird kod računa.';

  @override
  String get accountImportNewerVersion =>
      'Ovaj kod potiče iz novije verzije Thunderbirda. Ažurirajte Loupe da biste ga uvezli.';

  @override
  String get accountImportDamaged => 'Ovaj Thunderbird kod nije moguće pročitati.';

  @override
  String get accountImportTooLarge => 'Ovaj kod je prevelik da bi bio izvoz iz Thunderbirda.';

  @override
  String get accountImportCouldNotOpenSettings => 'Postavke nije moguće otvoriti.';

  @override
  String get accountImportCameraOffTitle => 'Pristup kameri je isključen';

  @override
  String get accountImportCameraOffText =>
      'U postavkama dozvolite aplikaciji Loupe da koristi kameru kako biste skenirali kod ili umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportNoCameraTitle => 'Nema kamere';

  @override
  String get accountImportNoCameraText => 'Loupe ovdje ne može koristiti kameru. Umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera se nije pokrenula';

  @override
  String get accountImportCameraFailedText => 'Pokušajte ponovo ili umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportOpenSettings => 'Otvori postavke';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pronađeno $count računa',
      few: 'Pronađena $count računa',
      one: 'Pronađen $count račun',
      zero: 'Nije pronađen nijedan račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nijedan račun iz ovih kodova nije moguće pročitati.';

  @override
  String get accountImportChoose => 'Odaberite račune koje želite dodati u Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nije skenirano $count kodova (brojevi $codes od $total), pa njihovi računi nisu navedeni.',
      few: 'Nisu skenirana $count koda (brojevi $codes od $total), pa njihovi računi nisu navedeni.',
      one: 'Nije skeniran $count kod (broj $codes od $total), pa njegovi računi nisu navedeni.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes i $last';
  }

  @override
  String get accountImportScanMore => 'Skeniraj još kodova';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count računa iz kodova nije moguće pročitati. Možda koriste postavke iz novije verzije Thunderbirda.',
      few: '$count računa iz kodova nije moguće pročitati. Možda koriste postavke iz novije verzije Thunderbirda.',
      one: '$count račun iz kodova nije moguće pročitati. Možda koristi postavke iz novije verzije Thunderbirda.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skeniraj ponovo';

  @override
  String get accountImportAlreadyAdded => 'Račun s ovom adresom već postoji u aplikaciji Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Kada račun bude dodan, prijavit ćete se putem $provider računa, kao u Thunderbirdu.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Dodajte račun pomoću lozinke za aplikaciju (potrebna je verifikacija u 2 koraka).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se na Gmail prijavljuje putem Google računa. „Prijavi se putem Google računa“ stiže u jednoj od narednih verzija; do tada dodajte račun pomoću lozinke za aplikaciju (potrebna je verifikacija u 2 koraka).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se na ovaj račun prijavljuje u pregledniku. Loupe to još ne može: koristite lozinku za aplikaciju ako je vaš pružalac usluge nudi.';

  @override
  String get accountImportUnencrypted => 'Povezuje se bez šifriranja. Koristite ovo samo na vlastitoj mreži.';

  @override
  String get accountImportEnterAgain => 'Unesite je ponovo';

  @override
  String get accountImportAdded => 'Dodano';

  @override
  String accountImportAdding(int index, int total) {
    return 'Dodavanje $index od $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dodaj $count računa',
      few: 'Dodaj $count računa',
      one: 'Dodaj $count račun',
      zero: 'Dodaj račune',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Zalijepite tekst izvoza';

  @override
  String get accountImportPasteText => 'Zalijepite tekst Thunderbird koda za izvoz, jedan kod po redu.';

  @override
  String get accountImportPop3 => 'POP3 računi nisu podržani. Loupe čuva poštu na serveru putem IMAP-a.';

  @override
  String get accountImportKerberos => 'Ovaj račun se prijavljuje putem Kerberosa, koji Loupe ne podržava.';

  @override
  String get accountImportNtlm => 'Ovaj račun se prijavljuje putem NTLM-a, koji Loupe ne podržava.';

  @override
  String get accountImportClientCertificate =>
      'Ovaj račun se prijavljuje pomoću klijentskog certifikata, koji Loupe još ne podržava.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Prijava putem Microsoft računa stiže u jednoj od narednih verzija. Outlook i Microsoft 365 računi više ne prihvataju lozinke iz aplikacija za e-poštu.';

  @override
  String get accountImportEnterPassword => 'Unesite lozinku.';

  @override
  String get accountImportEnterAppPassword => 'Unesite lozinku za aplikaciju.';

  @override
  String get accountImportEnterApiToken => 'Unesite API token.';

  @override
  String get accountImportStorageFailed => 'Loupe nije mogao otvoriti pohranu računa. Pokušajte ponovo kasnije.';

  @override
  String get accountImportFailed => 'Račun nije moguće dodati. Pokušajte ponovo ili ga dodajte ručno.';

  @override
  String get composeNewMessageTitle => 'Nova poruka';

  @override
  String get composeAttach => 'Priloži';

  @override
  String get composeSendLater => 'Pošalji kasnije';

  @override
  String composeSendAt(String time) {
    return 'Pošalji: $time';
  }

  @override
  String get composeSendHint => 'Dugo pritisnite za kasnije slanje';

  @override
  String get composeNoAccount => 'Dodajte račun da biste slali poštu.';

  @override
  String get composeTo => 'Za:';

  @override
  String get composeCc => 'Kopija:';

  @override
  String get composeBcc => 'Skrivena kopija:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopija, skrivena kopija, Od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Predmet:';

  @override
  String composeReplyTo(String address) {
    return 'Adresa za odgovor: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odgovori sa $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Pošalji sa $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odgovoriti sa $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Poslati sa $email?';
  }

  @override
  String get composeDismiss => 'Odbaci';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nije sačuvano kao identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Sačuvaj kao identitet';

  @override
  String composeAliasSaved(String email) {
    return 'Adresa $email je sačuvana kao identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Neispravna adresa $address';
  }

  @override
  String get composeOriginalNotFound => 'Originalna poruka nije pronađena.';

  @override
  String get composeDraftNotFound => 'Nacrt nije pronađen.';

  @override
  String get composeAttachmentsLost => 'Priloge nije moguće vratiti. Dodajte ih ponovo.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Neke priloge nije moguće dodati: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Prilozi ukupno imaju $size; neki serveri odbijaju ovako velike poruke.';
  }

  @override
  String get composeAttachFailed => 'Datoteku nije moguće priložiti.';

  @override
  String get composeInvalidAddressTitle => 'Neispravna adresa';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ nije ispravna adresa e-pošte.';
  }

  @override
  String get composeNoSubjectTitle => 'Bez predmeta';

  @override
  String get composeNoSubjectText => 'Ova poruka nema predmet. Ipak je poslati?';

  @override
  String get composeSentBeforeChanges => 'Poslana je prije vaših izmjena, koje su sačuvane u Nacrtima.';

  @override
  String composeScheduled(String time) {
    return 'Zakazano za $time';
  }

  @override
  String get composeSending => 'Slanje…';

  @override
  String get composeSent => 'Poslano';

  @override
  String get composeSendFailed => 'Slanje nije uspjelo. Pokušajte ponovo.';

  @override
  String get composeAlreadySent => 'Već je poslano.';

  @override
  String get composeDiscardChanges => 'Odbaci izmjene';

  @override
  String get composeSaveChanges => 'Sačuvaj izmjene';

  @override
  String get composeDeleteDraft => 'Izbriši nacrt';

  @override
  String get composeSaveDraft => 'Sačuvaj nacrt';

  @override
  String get composeDraftSaved => 'Nacrt je sačuvan';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date u $time, $name piše:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date u $time, neko piše:';
  }

  @override
  String get composeForwardHeader => '---------- Proslijeđena poruka ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Od: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date u $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Predmet: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Za: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kopija: $addresses';
  }

  @override
  String get composeLaterToday => 'Kasnije danas';

  @override
  String get composeTomorrowMorning => 'Sutra ujutro';

  @override
  String get composeMondayMorning => 'U ponedjeljak ujutro';

  @override
  String get composePickDateTime => 'Odaberi datum i vrijeme…';

  @override
  String get composeSendWithoutDelay => 'Pošalji odmah';

  @override
  String composeSendTimeToday(String time) {
    return 'Danas u $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Sutra u $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day u $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Danas $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Sutra $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Nastaviti uređivanje nacrta?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Poruka nije poslana kada se Loupe zatvorio.',
      'one': 'Poruka za $name nije poslana kada se Loupe zatvorio.',
      'other': 'Poruka za $name i druge nije poslana kada se Loupe zatvorio.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Poruka „$subject“ nije poslana kada se Loupe zatvorio.',
      'one': 'Poruka „$subject“ za $name nije poslana kada se Loupe zatvorio.',
      'other': 'Poruka „$subject“ za $name i druge nije poslana kada se Loupe zatvorio.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Nastavi uređivanje';

  @override
  String get composeRecoverySave => 'Sačuvaj u nacrte';

  @override
  String get composeRecoveryDiscard => 'Odbaci';

  @override
  String get composeRecoverySaved => 'Sačuvano u nacrtima';

  @override
  String get outboxSectionFailed => 'Nije poslano';

  @override
  String get outboxSectionSending => 'Slanje';

  @override
  String get outboxSectionScheduled => 'Zakazano';

  @override
  String get outboxStatusQueued => 'Uskoro se šalje';

  @override
  String get outboxStatusSending => 'Slanje…';

  @override
  String get outboxStatusFailed => 'Nije poslano';

  @override
  String get outboxNoRecipients => 'Nema primalaca';

  @override
  String get outboxNoSubject => '(Bez predmeta)';

  @override
  String get outboxSendingFailed => 'Slanje nije uspjelo.';

  @override
  String get outboxEmptyTitle => 'Nema ništa za slanje';

  @override
  String get outboxEmptyText => 'Poruke koje šaljete kasnije čekaju ovdje dok ne dođe vrijeme.';

  @override
  String get outboxSendNow => 'Pošalji odmah';

  @override
  String get outboxReschedule => 'Promijeni vrijeme';

  @override
  String get outboxRescheduleMenu => 'Promijeni vrijeme…';

  @override
  String get outboxRescheduleTitle => 'Novo vrijeme slanja';

  @override
  String outboxRescheduled(String time) {
    return 'Pomjereno na $time';
  }

  @override
  String get outboxCancel => 'Otkaži';

  @override
  String get outboxCancelSending => 'Otkaži slanje…';

  @override
  String get outboxCancelTitle => 'Otkazati slanje?';

  @override
  String get outboxMoveToDrafts => 'Premjesti u nacrte';

  @override
  String get outboxDiscard => 'Odbaci poruku';

  @override
  String get outboxMovedToDrafts => 'Premješteno u nacrte';

  @override
  String get outboxDiscarded => 'Poruka je odbačena';

  @override
  String get outboxAlreadySent => 'Već je poslano.';

  @override
  String get outboxBeingSent => 'Ova poruka se upravo šalje.';

  @override
  String get outboxActionFailed => 'To nije uspjelo. Poruka je i dalje u Odlaznom sandučetu.';

  @override
  String get notificationsBadgeInboxes => 'Nepročitano u prijemnim sandučićima';

  @override
  String get notificationsBadgeVip => 'Nepročitano u VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nova pošta od vaših VIP kontakata, na bilo kojem računu';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nova pošta na $email';
  }

  @override
  String get notificationsUnknownSender => 'Nepoznat pošiljalac';

  @override
  String get notificationsNoSubject => '(Bez predmeta)';

  @override
  String get notificationsEncryptedMessage => 'Šifrirana poruka';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nova poruka: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count novih poruka',
      few: '$count nove poruke',
      one: '$count nova poruka',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nove poruke: $account';
  }

  @override
  String get platformInstantChannel => 'Trenutna isporuka';

  @override
  String get platformInstantChannelDescription =>
      'Prikazuje se dok Loupe prati novu poštu u vašim prijemnim sandučićima';

  @override
  String get platformInstantTitle => 'Praćenje nove pošte';

  @override
  String get platformInstantText => 'Trenutna isporuka je uključena';

  @override
  String get platformErrorBox => 'Došlo je do greške pri prikazu. Vratite se i pokušajte ponovo.';

  @override
  String get welcomeTagline => 'Pošta jednostavna izvana\ni moćna iznutra.';

  @override
  String get welcomeAccountsTitle => 'Svi računi, jedno mirno sanduče';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail i bilo koji IMAP ili JMAP server.';

  @override
  String get welcomeSearchTitle => 'Pretraga koja pronalazi';

  @override
  String get welcomeSearchText => 'Trenutni rezultati na telefonu, zatim oni sa servera.';

  @override
  String get welcomePrivacyTitle => 'Privatnost po dizajnu';

  @override
  String get welcomePrivacyText => 'Bez praćenja. Udaljene slike ostaju blokirane dok ne kažete drugačije.';

  @override
  String get welcomeAddAccount => 'Dodaj račun';

  @override
  String get welcomeImport => 'Uvezi iz Thunderbirda';

  @override
  String get welcomeTryDemo => 'Isprobaj s demo poštom';
}
