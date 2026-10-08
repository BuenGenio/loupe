// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get commonAdd => 'Dodaj';

  @override
  String get commonCancel => 'Odustani';

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
  String get commonNone => 'Ništa';

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
  String get commonRetry => 'Pokušaj ponovno';

  @override
  String get commonSave => 'Spremi';

  @override
  String get commonSearch => 'Pretraži';

  @override
  String get commonServer => 'Poslužitelj';

  @override
  String get commonSettings => 'Postavke';

  @override
  String get commonShare => 'Dijeli';

  @override
  String get commonTryAgain => 'Pokušaj ponovno';

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
  String get mailboxDrafts => 'Skice';

  @override
  String get mailboxInbox => 'Pristigla pošta';

  @override
  String get mailboxJunk => 'Neželjena pošta';

  @override
  String get mailboxOutbox => 'Izlazni spremnik';

  @override
  String get mailboxSent => 'Poslano';

  @override
  String get mailboxTrash => 'Smeće';

  @override
  String get conversationSomethingWentWrong => 'Nešto nije u redu. Pokušajte ponovno.';

  @override
  String get conversationReplyToList => 'Odgovori na dopisnu listu';

  @override
  String get conversationReplyList => 'Na listu';

  @override
  String get conversationThreadMuted => 'Nit je utišana. Nove poruke u njoj stižu kao pročitane.';

  @override
  String get conversationThreadUnmuted => 'Nit više nije utišana.';

  @override
  String get conversationLinkFailed => 'Poveznicu nije moguće otvoriti.';

  @override
  String get conversationGoneTitle => 'Nema poruke';

  @override
  String get conversationGoneText => 'Ova je poruka premještena ili izbrisana.';

  @override
  String get conversationMuted => 'Utišano';

  @override
  String get conversationReaderOptions => 'Mogućnosti čitanja';

  @override
  String get conversationReaderOptionsHint => 'Veličina teksta i prikaz';

  @override
  String get conversationTrash => 'U smeće';

  @override
  String get conversationReplyHint => 'Dugo pritisnite za Odgovori svima i Proslijedi';

  @override
  String get conversationOfflineTitle => 'Niste na mreži';

  @override
  String get conversationOfflineText => 'Ovaj razgovor još nije preuzet. Učitat će se kad se ponovno povežete.';

  @override
  String get conversationErrorTitle => 'Ova se poruka ne može prikazati';

  @override
  String get conversationErrorText => 'Nešto nije u redu.';

  @override
  String get conversationOfflineBanner => 'Niste na mreži';

  @override
  String get conversationNotUpdated => 'Nije ažurirano';

  @override
  String get conversationMe => 'ja';

  @override
  String get conversationNoSender => '(bez pošiljatelja)';

  @override
  String get conversationNoRecipients => 'bez primatelja';

  @override
  String conversationRecipients(String names) {
    return 'prima: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'prima: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Od';

  @override
  String get conversationHeaderTo => 'Prima';

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
  String get conversationVerifiedSender => 'Provjereni pošiljatelj';

  @override
  String get conversationUnverifiedSender => 'Neprovjereni pošiljatelj';

  @override
  String get conversationLoadingMessage => 'Učitavanje poruke';

  @override
  String get conversationBodyError => 'Ovu poruku nije bilo moguće učitati.';

  @override
  String get conversationBodyOffline => 'Niste na mreži. Poruka će se učitati kad se ponovno povežete.';

  @override
  String get conversationOriginalHint => 'Bolje izgleda u prikazu Izvorno';

  @override
  String get conversationShowOriginal => 'Prikaži izvorno';

  @override
  String get conversationScrollToTop => 'Pomakni na vrh';

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
  String get conversationSaveAsFile => 'Spremi kao datoteku…';

  @override
  String get conversationShareAsFile => 'Dijeli kao datoteku…';

  @override
  String get conversationSearchFromMessageMenu => 'Pretraži prema ovoj poruci…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiraj adresu';

  @override
  String get conversationAddressCopied => 'Adresa je kopirana';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Pretraži poruke pošiljatelja $name';
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
  String get conversationSearchFromMessageTitle => 'Pretraži prema ovoj poruci';

  @override
  String conversationSearchFrom(String name) {
    return 'Od: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Prima: $name';
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
  String get conversationShareFailed => 'Poruku nije bilo moguće podijeliti.';

  @override
  String get conversationWrapLines => 'Prelamaj retke';

  @override
  String get conversationDontWrapLines => 'Ne prelamaj retke';

  @override
  String get conversationSourceError => 'Izvor nije bilo moguće učitati.';

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
  String get conversationMailboxesError => 'Mape nije bilo moguće učitati.';

  @override
  String get conversationReaderReadable => 'Čitljivo';

  @override
  String get conversationReaderOriginal => 'Izvorno';

  @override
  String get conversationReaderPlain => 'Čisti tekst';

  @override
  String get conversationReaderSans => 'Bez serifa';

  @override
  String get conversationReaderMono => 'Fiksna širina';

  @override
  String get conversationReaderKeepColours => 'Zadrži izvorne boje';

  @override
  String get conversationReaderRemember => 'Zapamti za ovog pošiljatelja';

  @override
  String get conversationSecurityPossiblePhishing => 'Mogući phishing';

  @override
  String get conversationSecurityBeCareful => 'Budite oprezni';

  @override
  String get conversationSecurityVerified => 'Provjereno';

  @override
  String get conversationSecurityNoIssues => 'Nisu pronađeni problemi';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alata za praćenje',
      few: '$count alata za praćenje',
      one: '$count alat za praćenje',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Prikazuje razlog';

  @override
  String get conversationPhishingBannerTitle => 'Ova poruka izgleda kao phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Poveznice i slike su isključene.';
  }

  @override
  String get conversationPhishingBannerText => 'Poveznice i slike su isključene.';

  @override
  String get conversationPhishingWhy => 'Zašto?';

  @override
  String get conversationPhishingShowAnyway => 'Ipak prikaži';

  @override
  String get conversationSecurityPhishingTitle => 'Ovo izgleda kao phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Nekoliko znakova upućuje na to da ova poruka nije ono za što se predstavlja.';

  @override
  String get conversationSecurityCarefulTitle => 'Budite oprezni s ovom porukom';

  @override
  String get conversationSecurityCarefulText => 'Nešto u njoj zaslužuje još jedan pogled.';

  @override
  String get conversationSecurityVerifiedText => 'Pošiljatelj je provjeren i ništa ne izgleda sumnjivo.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ništa ne izgleda sumnjivo. Vaš poslužitelj e-pošte nije naveo je li pošiljatelj provjeren.';

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
  String get conversationSecurityTrackingPixelsText => 'Javili bi pošiljatelju kada ste otvorili ovu poruku.';

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
      'Njihovim učitavanjem pošiljatelj saznaje kada ste pročitali ovu poruku i vašu IP adresu.';

  @override
  String get conversationSecurityNoClickTracking => 'Nema praćenja klikova';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poveznica preko praćenja klikova',
      few: '$count poveznice preko praćenja klikova',
      one: '$count poveznica preko praćenja klikova',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services zabilježili bi vaš klik. Dugo pritisnite poveznicu da biste izravno otvorili njezino odredište.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tehnički detalji';

  @override
  String get conversationSecurityCheckedLocally => 'Provjereno na ovom uređaju. Ništa nije nikamo poslano.';

  @override
  String get conversationSecurityTrackersLabel => 'Alati za praćenje';

  @override
  String get conversationSecurityImagesFrom => 'Slike s';

  @override
  String get conversationSecuritySenderHistory => 'Povijest pošiljatelja';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'primljeno: $received, poslano: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Poveznice vode na';

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
  String get conversationSecurityAuthFailedTitle => 'Pošiljatelj nije provjeren';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Vaš poslužitelj e-pošte nije mogao potvrditi da ova poruka zaista dolazi s domene $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Vaš poslužitelj e-pošte nije mogao potvrditi da ova poruka zaista dolazi od svog pošiljatelja.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Vaš poslužitelj e-pošte nije mogao potvrditi da ova poruka dolazi s domene $domain. Uobičajeno za dopisne liste.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Vaš poslužitelj e-pošte nije mogao potvrditi da ova poruka dolazi od svog pošiljatelja. Uobičajeno za dopisne liste.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ne postupajte prema njoj ako je niste očekivali. Ako sumnjate, javite se pošiljatelju na drugi način.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Potpisano drugom domenom';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Poruku je potpisala domena $signer, a ne $domain. To rade servisi za slanje pošte, ali to ne dokazuje tko ju je napisao.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Poruku je potpisala druga domena, a ne $domain. To rade servisi za slanje pošte, ali to ne dokazuje tko ju je napisao.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Ime prikazuje drugu adresu';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Ime pošiljatelja glasi „$shown“, ali poruka dolazi s adrese $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Vjerujte adresi, a ne imenu.';

  @override
  String get conversationSecurityReplyToTitle => 'Odgovori idu drugamo';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vaš bi odgovor otišao na $address, a ne na domenu $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Provjerite adresu prije nego što odgovorite nečim osobnim.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Koristi vaše ime';

  @override
  String get conversationSecurityImpersonationTitle => 'Koristi ime nekoga koga poznajete';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Potpisana je imenom „$name“, jednakim vašem, ali dolazi s nove adrese: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Potpisana je imenom „$name“, kao da je od vašeg VIP kontakta $knownName ($knownEmail), ali dolazi s nove adrese: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Potpisana je imenom „$name“, kao da je od osobe $knownName ($knownEmail), ali dolazi s nove adrese: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'A odgovori bi išli na još jednu, drugu adresu.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ako traži novac, kodove ili datoteke, najprije to provjerite s tom osobom na drugi način.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Poznata adresa: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ova adresa: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Prva poruka od ovog pošiljatelja';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Dosad niste primili poštu s adrese $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Budite oprezni sa zahtjevima ljudi koje još ne poznajete.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Slova sličnog izgleda u adresi pošiljatelja';

  @override
  String get conversationSecurityLinkHomographTitle => 'Slova sličnog izgleda u poveznici';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host miješa slova iz različitih pisama kako bi oponašao drugu adresu.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host koristi slova sličnog izgleda: to nije $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Izbrišite je ili je prijavite kao neželjenu.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Nemojte je otvarati.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domena: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domena sličnog izgleda';

  @override
  String get conversationSecurityFamiliarNameTitle => 'U domeni koristi poznato ime';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain izgleda kao vaša domena $real, ali je riječ o drugoj domeni.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain izgleda kao $brand ($real), ali je riječ o drugoj domeni.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain koristi ime vaše domene $real, ali joj ne pripada.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain koristi ime $brand ($real), ali nije povezana s njim.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Prave poruke iz vaše organizacije dolaze s $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Prave poruke od $brand dolaze s $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domena pošiljatelja: $domain';
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
      other: '$count poveznica skriva kamo vode',
      few: '$count poveznice skrivaju kamo vode',
      one: '$count poveznica skriva kamo vodi',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Poveznica prikazuje $shown, ali otvara $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Nemojte se prijavljivati ni plaćati putem ovih poveznica. Umjesto toga sami upišite adresu.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Odredište poveznice ne može se provjeriti';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Poveznica prikazuje $shown, ali vodi preko $host, koji bilježi klik prije nego što ga proslijedi.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Poveznica vodi na golu IP adresu';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nije imenovano web-mjesto. Prave tvrtke rijetko tako postavljaju poveznice.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Prikrivena poveznica';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Poveznica počinje s „$shown@“ kako bi izgledala kao $shown, ali otvara $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Skrivena stranica je onemogućena';

  @override
  String get conversationSecurityDataLinkText =>
      'Poveznica bi otvorila stranicu zapakiranu u samu poruku, što je način zaobilaženja provjere poveznica.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Traži lozinku';

  @override
  String get conversationSecurityPasswordFieldText => 'Poruka je sadržavala polje za lozinku. Loupe ga je uklonio.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nikada ne upisujte lozinku u e-poruku.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Poveznica koja pokreće kod je onemogućena';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nikada ne pokreće kod iz poruka.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skraćenih poveznica',
      few: '$count skraćene poveznice',
      one: '$count skraćena poveznica',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts skriva pravo odredište dok ga ne otvorite.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Međunarodna web-adresa';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts koristi nelatinična slova. To je normalno za mnoge jezike; provjerite je li to stranica koju očekujete.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mnogo skrivenog teksta';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Uklonjeno je $count znakova nevidljivog teksta. Ovakav skriveni tekst služi za zavaravanje filtara neželjene pošte.',
      few:
          'Uklonjena su $count znaka nevidljivog teksta. Ovakav skriveni tekst služi za zavaravanje filtara neželjene pošte.',
      one:
          'Uklonjen je $count znak nevidljivog teksta. Ovakav skriveni tekst služi za zavaravanje filtara neželjene pošte.',
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
  String get exportDownloadFailed => 'Poruku nije bilo moguće preuzeti. Provjerite vezu i pokušajte ponovno.';

  @override
  String exportSaved(String name) {
    return 'Spremljeno: „$name“';
  }

  @override
  String get exportSaveFailed => 'Poruku nije bilo moguće spremiti.';

  @override
  String exportFailed(String folder) {
    return 'Mapu „$folder“ nije bilo moguće izvesti.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Mapa „$folder“ nema poruka za izvoz.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Mapu „$folder“ nije bilo moguće izvesti: nijednu poruku nije bilo moguće preuzeti. Provjerite vezu i pokušajte ponovno.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Spremljeno „$name“ bez $formattedCount poruka koje nije bilo moguće preuzeti.',
      few: 'Spremljeno „$name“ bez $formattedCount poruke koje nije bilo moguće preuzeti.',
      one: 'Spremljeno „$name“ bez $count poruke koju nije bilo moguće preuzeti.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ nije bilo moguće spremiti.';
  }

  @override
  String exportTitle(String folder) {
    return 'Izvoz mape „$folder“';
  }

  @override
  String get exportListing => 'Traženje poruka…';

  @override
  String exportProgress(String current, String total) {
    return 'Izvoz $current od $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount poruka nije bilo moguće preuzeti',
      few: '$formattedCount poruke nije bilo moguće preuzeti',
      one: '$count poruku nije bilo moguće preuzeti',
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
  String get mailboxesCollapse => 'Sažmi';

  @override
  String get mailboxesExpand => 'Proširi';

  @override
  String get mailboxesManageVips => 'Upravljaj VIP kontaktima';

  @override
  String get mailboxesSubscriptions => 'Pretplate';

  @override
  String mailboxesShowAccount(String account) {
    return 'Prikaži $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Sakrij $account';
  }

  @override
  String get mailboxesExportFolder => 'Izvezi mapu…';

  @override
  String get mailboxesUnpin => 'Otkvači';

  @override
  String get mailboxesLists => 'Liste';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Spremite pretragu da biste je zadržali ovdje.';

  @override
  String get mailboxesTags => 'Oznake';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Možete i dodirnuti ime pošiljatelja u poruci i uključiti VIP.';

  @override
  String get mailboxesAddVip => 'Dodaj VIP…';

  @override
  String get mailboxesAddVipTitle => 'Dodaj VIP';

  @override
  String get mailboxesAddVipText => 'Pošta s ove adrese dobiva zvjezdicu i pojavljuje se u sandučiću VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Nepročitano';

  @override
  String get messageListFilterFlagged => 'Označeno zastavicom';

  @override
  String get messageListFilterToMe => 'Upućeno meni';

  @override
  String get messageListFilterCcMe => 'Ja u kopiji';

  @override
  String get messageListFilterWithAttachments => 'S privicima';

  @override
  String get messageListFilterUnreplied => 'Bez odgovora';

  @override
  String get messageListFilterFromVips => 'Od VIP kontakata';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka označeno je kao pročitano',
      few: '$count poruke označene su kao pročitane',
      one: '$count poruka označena je kao pročitana',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Stariju poštu nije bilo moguće učitati.';

  @override
  String get messageListSelectMessages => 'Odaberite poruke';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odabranih',
      few: '$count odabrane',
      one: '$count odabrana',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Odaberi sve';

  @override
  String get messageListDeselectAll => 'Poništi odabir';

  @override
  String get messageListLoadFailed => 'Poštu nije moguće učitati';

  @override
  String get messageListNoUnread => 'Nema nepročitane pošte';

  @override
  String get messageListNoMatches => 'Nema odgovarajuće pošte';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrirano prema: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Isključi filtar';

  @override
  String get messageListEmpty => 'Nema pošte';

  @override
  String get messageListFilter => 'Filtar';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kriteriji filtra: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrirano prema:';

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
  String get messageListFilterTitle => 'Filtar';

  @override
  String get messageListFilterInclude => 'UKLJUČI';

  @override
  String get panesHideMailboxes => 'Sakrij sandučiće';

  @override
  String get panesShowMailboxes => 'Prikaži sandučiće';

  @override
  String get panesMailboxesWidth => 'Širina sandučića';

  @override
  String get panesListWidth => 'Širina popisa poruka';

  @override
  String get panesNoMessageSelected => 'Nije odabrana nijedna poruka';

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
  String get snoozeSheetTitle => 'Odgodi';

  @override
  String get snoozeLaterToday => 'Kasnije danas';

  @override
  String get snoozeThisEvening => 'Večeras';

  @override
  String get snoozeTomorrow => 'Sutra';

  @override
  String get snoozeThisWeekend => 'Ovaj vikend';

  @override
  String get snoozeNextWeek => 'Sljedeći tjedan';

  @override
  String get snoozePickDateTime => 'Odaberi datum i vrijeme…';

  @override
  String get snoozeMenu => 'Odgodi…';

  @override
  String get snoozeWakeNow => 'Vrati sada';

  @override
  String get snoozeChangeTimeMenu => 'Promijeni vrijeme odgode…';

  @override
  String get snoozeChangeTime => 'Promijeni vrijeme';

  @override
  String get snoozeNoTime => 'Vrijeme nije postavljeno';

  @override
  String get snoozeFooter => 'Odgođene poruke vraćaju se u pristiglu poštu kao nepročitane u zadano vrijeme.';

  @override
  String get snoozeEmptyTitle => 'Ništa nije odgođeno';

  @override
  String get snoozeEmptyText => 'Odgodite poruku i vratit će se u pristiglu poštu kad vam zatreba.';

  @override
  String get appLockUnlock => 'Otključaj';

  @override
  String get appLockFailed => 'Loupe nije mogao potvrditi da ste to vi.';

  @override
  String get appLockLockedOut => 'Previše pokušaja. Pokušajte ponovno kasnije.';

  @override
  String get appLockPromptError => 'Upit nije bilo moguće prikazati. Pokušajte ponovno.';

  @override
  String get appLockNoScreenLock => 'Ovaj telefon nema zaključavanje zaslona.';

  @override
  String get appLockUnlockPromptTitle => 'Otključajte Loupe';

  @override
  String get appLockUnlockPromptReason => 'Potvrdite da ste to vi kako biste vidjeli svoju poštu.';

  @override
  String get appLockTurnOnPromptTitle => 'Uključi zaključavanje aplikacije';

  @override
  String get appLockTurnOnPromptReason => 'Potvrdite da ste to vi kako biste uključili zaključavanje aplikacije.';

  @override
  String get appLockScreenLockRemoved =>
      'Zaključavanje aplikacije je isključeno: ovaj telefon više nema zaključavanje zaslona. Postavite ga da biste ponovno uključili zaključavanje aplikacije.';

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
  String get openpgpEncryptedInPart => 'Djelomično šifrirano';

  @override
  String get openpgpEncryptedLocked => 'Šifrirano · zaključano';

  @override
  String get openpgpEncryptedNoKey => 'Šifrirano · nema ključa';

  @override
  String get openpgpEncryptedDamaged => 'Šifrirano · oštećeno';

  @override
  String get openpgpEncryptedUnsupported => 'Šifrirano · nepodržano';

  @override
  String get openpgpUnknownSigner => 'nepoznat';

  @override
  String get openpgpUnknownKey => 'Nepoznat ključ';

  @override
  String get openpgpSignatureInvalid => 'Nevažeći potpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Potpisano: $name, a ne pošiljatelj';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Djelomično potpisano: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Potpisano: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Potpisano odbijenim ključem';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Potpisano: $name · ključ nije prihvaćen';
  }

  @override
  String get openpgpUnlock => 'Otključaj';

  @override
  String get openpgpCantDecrypt => 'Ova se poruka ne može dešifrirati';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Šifrirano s OpenPGP-om';

  @override
  String get openpgpEncryption => 'Šifriranje';

  @override
  String get openpgpDecryptedHere => 'Dešifrirano na ovom uređaju';

  @override
  String get openpgpNotDecrypted => 'Nije dešifrirano';

  @override
  String get openpgpKeyLocked => 'Vaš je ključ zaključan.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Za $count ključeva: $keys',
      few: 'Za $count ključa: $keys',
      one: 'Za $count ključ: $keys',
    );
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
    return 'ID ključa $id';
  }

  @override
  String get openpgpSigned => 'Potpisano';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Prihvaćanje';

  @override
  String get openpgpChangeAcceptance => 'Promijeni prihvaćanje…';

  @override
  String get openpgpCheckedFooter => 'Provjereno na ovom uređaju s OpenPGP-om, kompatibilno s Thunderbirdom.';

  @override
  String get openpgpSummaryLocked =>
      'Vaš je ključ zaključan. Otključajte ga pristupnom frazom da biste pročitali ovu poruku.';

  @override
  String get openpgpSummaryNoSecretKey => 'Šifrirana je za ključ koji nije na ovom uređaju.';

  @override
  String get openpgpSummaryDamaged => 'Šifrirani podaci su oštećeni ili su promijenjeni na putu.';

  @override
  String get openpgpSummaryUnsupported => 'Koristi algoritam koji Loupe ne podržava.';

  @override
  String get openpgpSummaryEncrypted => 'Mogu je pročitati samo vi i ostali primatelji.';

  @override
  String get openpgpSummaryNotSigned => 'Nije potpisana pa pošiljatelj nije potvrđen.';

  @override
  String get openpgpSummaryUnknownKey => 'Potpisana je, ali ključem koji nemate pa se potpis ne može provjeriti.';

  @override
  String get openpgpSummaryBadSignature => 'Potpis se ne podudara: poruka je možda promijenjena.';

  @override
  String get openpgpSummaryMismatch => 'Potpis je valjan, ali ključ pripada drugoj adresi, a ne pošiljateljevoj.';

  @override
  String get openpgpSummaryPartial =>
      'Potpisan je samo dio poruke. Tekst izvan potpisa (na primjer podnožje dopisne liste) prikazuje se ispod retka „Unsigned content“, a potpis ne obuhvaća ni druge dijelove poruke, poput privitaka.';

  @override
  String get openpgpSummaryOwnKey => 'Potpisano vašim vlastitim ključem.';

  @override
  String get openpgpSummaryVerified => 'Potpis je valjan i provjerili ste otisak ključa.';

  @override
  String get openpgpSummaryUnverified => 'Potpis je valjan. Ključ ste prihvatili bez provjere njegova otiska.';

  @override
  String get openpgpSummaryRejected => 'Potpis je valjan, ali ste ovaj ključ odbili.';

  @override
  String get openpgpSummaryUndecided =>
      'Potpis je valjan, ali ovaj ključ još niste prihvatili. Usporedite njegov otisak s pošiljateljem.';

  @override
  String get openpgpAcceptanceRejected => 'Odbijen';

  @override
  String get openpgpAcceptanceUndecided => 'Nije prihvaćen';

  @override
  String get openpgpAcceptanceUnverified => 'Prihvaćen';

  @override
  String get openpgpAcceptanceVerified => 'Prihvaćen i provjeren';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Prihvatiti ključ osobe $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Otisak $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Da, otisak je provjeren';

  @override
  String get openpgpAcceptUnverified => 'Da, bez provjere';

  @override
  String get openpgpAcceptLater => 'Još ne';

  @override
  String get openpgpRejectKey => 'Odbij ovaj ključ';

  @override
  String get openpgpNoSubject => '(bez predmeta)';

  @override
  String get openpgpEncryptionTitle => 'End-to-end šifriranje';

  @override
  String get openpgpMyKeys => 'Moji OpenPGP ključevi';

  @override
  String get openpgpMyKeysFooter =>
      'S ključem možete čitati šifriranu poštu te potpisivati i šifrirati vlastitu. Koristite Thunderbird? Ondje izvezite svoj ključ (Postavke računa › End-to-end šifriranje › Izvezi tajni ključ) i uvezite ga ovdje.';

  @override
  String get openpgpAddKey => 'Dodaj ključ…';

  @override
  String get openpgpAddresses => 'Adrese';

  @override
  String get openpgpAddressesFooter => 'Koji ključ koristi svaka adresa te kada šifrira i potpisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP ključevi dopisnika';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Prihvatite ključ kad vjerujete da pripada svom vlasniku; usporedite otisak s vlasnikom da biste ga označili kao provjeren.';

  @override
  String get openpgpImportPublicKey => 'Uvezi javni ključ…';

  @override
  String get openpgpCollected => 'Prikupljeno putem Autocrypta';

  @override
  String get openpgpCollectedFooter =>
      'Ključevi koji su stigli s porukama. Loupe može šifrirati za njih kad to traže obje strane.';

  @override
  String get openpgpOnThisDevice => 'Na ovom uređaju';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Šifrirane poruke skrivaju svoj predmet. Loupe sprema predmet svake poruke koju otvorite u svoju šifriranu bazu podataka na ovom uređaju, kako bi se prikazivao na popisu, u pretraživanju i u obavijestima. U pozadini Loupe može dešifrirati i predmete novih poruka ključevima bez pristupne fraze; za to preuzima svaku poruku (do 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Dešifriraj predmete u pozadini';

  @override
  String get openpgpIndexFooter =>
      'Pretraživanje pronalazi šifrirane poruke prema pošiljatelju, primateljima i predmetu. Kad je ovo uključeno, Loupe tekst svake šifrirane poruke koju dešifrira dodaje i u indeks pretraživanja u svojoj šifriranoj bazi podataka na ovom uređaju, pa ih pretraživanje pronalazi i prema tekstu. Isključivanjem se taj tekst uklanja iz indeksa.';

  @override
  String get openpgpIndexDecrypted => 'Indeksiraj dešifrirane poruke za pretraživanje';

  @override
  String get openpgpPassphrases => 'Pristupne fraze';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP ključevi i S/MIME certifikati zaštićeni pristupnom frazom otključavaju se kad je potrebno. Bez opcije „Zapamti“ ponovno se zaključavaju dvije minute nakon svake upotrebe.';

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
  String get openpgpKeyStateNeverExpires => 'nikad ne istječe';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'istječe $date';
  }

  @override
  String get openpgpNoKey => 'Nema ključa';

  @override
  String get openpgpAlwaysEncrypt => 'Uvijek šifriraj';

  @override
  String get openpgpAddKeyTitle => 'Dodajte OpenPGP ključ';

  @override
  String get openpgpAddKeyMessage => 'Uvezite ključ koji koristite u Thunderbirdu ili izradite novi.';

  @override
  String get openpgpImportFromClipboard => 'Uvezi iz međuspremnika';

  @override
  String get openpgpImportFromFile => 'Uvezi iz datoteke';

  @override
  String get openpgpGenerateNewKey => 'Generiraj novi ključ';

  @override
  String get openpgpImportPublicKeyTitle => 'Uvezite javni ključ';

  @override
  String get openpgpFromClipboard => 'Iz međuspremnika';

  @override
  String get openpgpFromFile => 'Iz datoteke';

  @override
  String get openpgpClipboardEmpty => 'Međuspremnik je prazan. Najprije kopirajte ključ.';

  @override
  String get openpgpKey => 'Ključ';

  @override
  String get openpgpValidityRevoked => 'Opozvan';

  @override
  String openpgpValidityExpired(String date) {
    return 'Istekao $date';
  }

  @override
  String get openpgpNeverExpires => 'Nikad ne istječe';

  @override
  String openpgpValidUntil(String date) {
    return 'Vrijedi do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Otisak je kopiran.';

  @override
  String get openpgpAlgorithm => 'Algoritam';

  @override
  String get openpgpCreated => 'Izrađen';

  @override
  String get openpgpValidity => 'Valjanost';

  @override
  String get openpgpProtection => 'Zaštita';

  @override
  String get openpgpProtectionPassphrase => 'Pristupna fraza';

  @override
  String get openpgpProtectionKeychain => 'Samo spremište ključeva';

  @override
  String get openpgpKeyDetailsFooter =>
      'Podijelite svoj javni ključ kako bi vam drugi mogli slati šifriranu poštu. Sigurnosna kopija je vaš tajni ključ, zaštićen pristupnom frazom ako je ima: čuvajte je privatnom.';

  @override
  String get openpgpSharePublicKey => 'Dijeli javni ključ';

  @override
  String get openpgpCopyPublicKey => 'Kopiraj javni ključ';

  @override
  String get openpgpPublicKeyCopied => 'Javni ključ je kopiran.';

  @override
  String get openpgpBackUpSecretKey => 'Sigurnosno kopiraj tajni ključ';

  @override
  String get openpgpDeleteKey => 'Izbriši ključ';

  @override
  String get openpgpRemoveKey => 'Ukloni ključ';

  @override
  String get openpgpBackUpTitle => 'Sigurnosno kopirati tajni ključ?';

  @override
  String get openpgpBackUpProtected =>
      'Sigurnosna kopija zaštićena je pristupnom frazom vašeg ključa. Tko ima oboje, može čitati vašu poštu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ovaj ključ nema pristupnu frazu: svatko sa sigurnosnom kopijom može čitati vašu poštu i potpisivati se kao vi.';

  @override
  String get openpgpBackUp => 'Sigurnosno kopiraj';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Izbrisati vaš ključ $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Ukloniti ključ osobe $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Poštu šifriranu za ovaj ključ više nećete moći čitati na ovom uređaju, osim ako ga ponovno ne uvezete.';

  @override
  String get openpgpRemoveKeyMessage => 'Kasnije ga možete ponovno uvesti.';

  @override
  String get openpgpKeyHeader => 'OpenPGP ključ';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Dodajte ključ u odjeljku End-to-end šifriranje da biste šifrirali i potpisivali poštu s ove adrese.';

  @override
  String get openpgpGenerateAKey => 'Generiraj ključ…';

  @override
  String get openpgpSending => 'Slanje';

  @override
  String get openpgpSendingFooter =>
      'Automatsko šifriranje uključuje se kad svaki primatelj ima prihvaćen ključ ili pouzdan certifikat ili kad Autocrypt kaže da ga obje strane žele. Šifrirana pošta uvijek je potpisana.';

  @override
  String get openpgpEncryptAutomatically => 'Šifriraj automatski';

  @override
  String get openpgpAlwaysEncryptDetail => 'Ne šalje ako neki primatelj nema ključ';

  @override
  String get openpgpSignUnencrypted => 'Potpisuj nešifriranu poštu';

  @override
  String get openpgpAttachPublicKey => 'Priloži moj javni ključ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt šalje vaš javni ključ uz svaku poruku, pa vam druge aplikacije mogu slati šifriranu poštu bez ikakvog postavljanja.';

  @override
  String get openpgpSendMyKey => 'Šalji moj ključ uz poštu';

  @override
  String get openpgpPreferEncryption => 'Preferiraj šifriranje';

  @override
  String get openpgpPreferEncryptionDetail => 'Zamoli druge da šifriraju kad mogu';

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
  String get openpgpNewKeyFor => 'Za';

  @override
  String get openpgpYourName => 'Vaše ime';

  @override
  String get openpgpAddress => 'Adresa';

  @override
  String get openpgpPassphrase => 'Pristupna fraza';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Neobavezno. Bez nje ključ štiti samo spremište ključeva na vašem telefonu i Loupe nikad ne pita. S njom Loupe traži frazu kad je ključ potreban.';

  @override
  String get openpgpRepeatPassphrase => 'Ponovite';

  @override
  String get openpgpExpires => 'Istječe';

  @override
  String get openpgpExpiresFooter =>
      'Novi ključ možete izraditi prije nego što ovaj istekne. Thunderbird također koristi tri godine.';

  @override
  String get openpgpGenerateKey => 'Generiraj ključ';

  @override
  String get openpgpKeyFor => 'Ključ za';

  @override
  String get openpgpCantEncrypt => 'Šifriranje nije moguće';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nema OpenPGP ključa za $names, a ova adresa uvijek šifrira. Uklonite primatelja ili uvezite njegov ključ u Postavke › End-to-end šifriranje.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nema valjanog S/MIME certifikata za $names, a ova adresa uvijek šifrira. Uklonite primatelja ili uvezite njegov certifikat u Postavke › End-to-end šifriranje.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nema OpenPGP ključa za $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nema valjanog S/MIME certifikata za $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Pošalji nešifrirano';

  @override
  String get openpgpCantSign => 'Potpisivanje nije moguće';

  @override
  String get openpgpCantSignMessage =>
      'Privatni ključ vašeg S/MIME certifikata nije na ovom uređaju. Ponovno uvezite certifikat (datoteku .p12 ili .pfx) u Postavke › End-to-end šifriranje.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nema ključa za $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nema certifikata za $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Ključevi iz Autocrypta';

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
    return '$standard, promijeni';
  }

  @override
  String get openpgpNoKeyFound => 'Nije pronađen nijedan OpenPGP ključ.';

  @override
  String get openpgpImportSecretKeyTitle => 'Uvesti tajni ključ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Ovaj privitak sadrži tajni ključ ($names). Uvezite ga kao vlastiti ključ samo ako ste ga sami izvezli, na primjer iz Thunderbirda.';
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
    return 'ključ osobe $name';
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
  String get openpgpUnlockKeyTitle => 'Otključaj OpenPGP ključ';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Unesite pristupnu frazu za ključ $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Pristupna fraza nije točna. Pokušajte ponovno.';

  @override
  String get openpgpExplainLocked => 'Ova je poruka šifrirana. Otključajte svoj OpenPGP ključ da biste je pročitali.';

  @override
  String get openpgpExplainNoKey =>
      'Ova je poruka šifrirana, ali ne za neki OpenPGP ključ na ovom uređaju. Ako je čitate u Thunderbirdu, ondje izvezite svoj ključ i uvezite ga ovdje: Postavke › End-to-end šifriranje.';

  @override
  String get openpgpExplainDamaged => 'Ova šifrirana poruka je oštećena pa se ne može sigurno dešifrirati.';

  @override
  String get openpgpExplainUnsupported => 'Ova poruka koristi šifriranje koje Loupe još ne može pročitati.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ova je poruka šifrirana S/MIME-om, ali ne za neki certifikat na ovom uređaju. Uvezite svoj certifikat (datoteku .p12 ili .pfx) u Postavke › End-to-end šifriranje.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ova je poruka šifrirana. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Otključajte svoj S/MIME certifikat da biste je pročitali.';

  @override
  String get openpgpAttachmentGone => 'Ovaj privitak više nije dostupan.';

  @override
  String get smimeEncrypted => 'Šifrirano (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Šifrirano (S/MIME) · nema certifikata';

  @override
  String get smimeEncryptedDamaged => 'Šifrirano (S/MIME) · oštećeno';

  @override
  String get smimeEncryptedUnsupported => 'Šifrirano (S/MIME) · nepodržano';

  @override
  String get smimeEncryptedLocked => 'Šifrirano (S/MIME) · zaključano';

  @override
  String get smimeUnknownSigner => 'nepoznat';

  @override
  String get smimeSignatureModified => 'Nevažeći potpis: poruka je promijenjena';

  @override
  String get smimeSignatureWeak => 'Nesiguran potpis: zastarjeli algoritam';

  @override
  String get smimeSignatureUncheckable => 'Potpis se ne može provjeriti';

  @override
  String get smimeSignedCertificateMissing => 'Potpisano · nedostaje certifikat';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Potpisano: $name · certifikat opozvan';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Potpisano: $name · drugog datuma';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Potpisano: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Potpisano: $name · nevaljan certifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Potpisano: $name · nije pouzdano';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Potpisano: $name · certifikat je istekao';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Potpisano: $name · certifikat još nije valjan';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Potpisano: $name · certifikat nije za poštu';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Potpisano: $name, a ne pošiljatelj';
  }

  @override
  String get smimeCantDecrypt => 'Ova se poruka ne može dešifrirati';

  @override
  String get smimeEncryptedWithSmime => 'Šifrirano S/MIME-om';

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
  String get smimeIssuedBy => 'Izdao';

  @override
  String get smimeValid => 'Valjanost';

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
  String get smimeCheckingRevocation => 'Provjera opoziva…';

  @override
  String get smimeNotRevoked => 'Nije opozvan';

  @override
  String get smimeRevoked => 'Opozvan';

  @override
  String get smimeRevocationUnknown => 'Opoziv nepoznat';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Provjereno kod certifikacijskog tijela (popis opozvanih certifikata), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Provjereno kod certifikacijskog tijela (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Vjeruj „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Vjeruj ovom certifikatu…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Provjereno na ovom uređaju s S/MIME-om, kompatibilno s Outlookom i Thunderbirdom; opoziv kod certifikacijskog tijela.';

  @override
  String get smimeCheckedFooter =>
      'Provjereno na ovom uređaju s S/MIME-om, kompatibilno s Outlookom i Thunderbirdom. Opoziv se ne provjerava (Postavke › End-to-end šifriranje).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vjerovati tijelu $name za poštu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vjerovati certifikatu osobe $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Vjerovat će se svakom certifikatu koji ovo tijelo izda, kao certifikacijskom tijelu vaše tvrtke. Najprije usporedite otisak s njegovim vlasnikom:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Najprije usporedite otisak s vlasnikom:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Vjeruj';

  @override
  String get smimeSummaryNoKey => 'Šifrirana je za certifikat koji nije na ovom uređaju.';

  @override
  String get smimeSummaryDamaged => 'Šifrirani podaci su oštećeni ili su promijenjeni na putu.';

  @override
  String get smimeSummaryUnsupported => 'Koristi algoritam koji Loupe ne podržava.';

  @override
  String get smimeSummaryLocked => 'Vaš je S/MIME certifikat zaključan.';

  @override
  String get smimeSummaryEncrypted => 'Mogu je pročitati samo vi i ostali primatelji.';

  @override
  String get smimeSummaryNotSigned => 'Nije potpisana pa pošiljatelj nije potvrđen.';

  @override
  String get smimeSummaryModified => 'Potpis se ne podudara: poruka je promijenjena nakon potpisivanja.';

  @override
  String get smimeSummaryUncheckable => 'Potpis se ne može provjeriti.';

  @override
  String get smimeSummaryNoCertificate => 'Certifikat potpisnika nije u poruci pa se ne može provjeriti.';

  @override
  String get smimeSummaryRevoked =>
      'Certifikacijsko tijelo opozvalo je certifikat potpisnika: potpisu se ne može vjerovati.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Certifikacijsko tijelo opozvalo je certifikat potpisnika ($reason): potpisu se ne može vjerovati.';
  }

  @override
  String get smimeDateMismatch =>
      'Potpisana je više od sat vremena prije ili nakon datuma poruke: možda je riječ o staroj poruci poslanoj ponovno.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Potpis je valjan i $issuer jamči da certifikat pripada pošiljatelju.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikat ili neki od njegovih izdavatelja nije valjan.';

  @override
  String get smimeProblemUntrusted => 'Certifikat potječe od tijela kojem Loupe ne vjeruje.';

  @override
  String get smimeProblemExpired => 'Certifikat je istekao.';

  @override
  String get smimeProblemNotYetValid => 'Certifikat još nije bio valjan.';

  @override
  String get smimeProblemWrongUsage => 'Certifikat nije namijenjen za poštu.';

  @override
  String get smimeProblemWrongAddress => 'Certifikat pripada drugoj adresi, a ne pošiljateljevoj.';

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
    return 'Vrijedi od $date';
  }

  @override
  String get smimeTrustInvalid => 'Nevaljan';

  @override
  String get smimeTrustNotForMail => 'Nije za poštu';

  @override
  String get smimeTrustAnotherAddress => 'Druga adresa';

  @override
  String get smimeMyCertificates => 'Moji S/MIME certifikati';

  @override
  String get smimeMyCertificatesFooter =>
      'Za S/MIME, kako ga koriste Outlook i mnoge tvrtke. Uvezite svoj certifikat s privatnim ključem (datoteku .p12 ili .pfx) izvezen iz Outlooka, Windowsa, macOS-a ili Thunderbirda.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Za S/MIME, kako ga koriste Outlook i mnoge tvrtke. Uvezite svoj certifikat s privatnim ključem (datoteku .p12 ili .pfx) izvezen iz Outlooka, Windowsa, macOS-a ili Thunderbirda ili koristite onaj koji ste vi ili vaša tvrtka instalirali na ovaj uređaj.';

  @override
  String get smimeCertificateExpired => 'istekao';

  @override
  String smimeCertificateUntil(String date) {
    return 'do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'na ovom uređaju';

  @override
  String get smimeImportCertificateEllipsis => 'Uvezi certifikat…';

  @override
  String get smimeUseDeviceCertificate => 'Koristi certifikat s ovog uređaja…';

  @override
  String get smimeCorrespondentsCertificates => 'Certifikati dopisnika';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Prikupljeni iz potpisane pošte, kao što to rade Outlook i Thunderbird. Pošta se šifrira samo za pouzdane certifikate: Loupe vjeruje certifikacijskim tijelima kojima Mozilla vjeruje za e-poštu i onima koje dodate.';

  @override
  String get smimeRevocation => 'Opoziv';

  @override
  String get smimeRevocationFooter =>
      'Kad otvorite potpisanu poštu, Loupe pita certifikacijsko tijelo koje je izdalo certifikat potpisnika je li ga opozvalo (njegov OCSP poslužitelj ili popis opozvanih certifikata). Tijelo tada može vidjeti kada netko s vaše internetske adrese čita poštu potpisanu tim certifikatom. Odgovori se čuvaju na ovom uređaju dok ne isteknu. Opozvani certifikat u zaglavlju poruke prikazuje se kao „opozvan“.';

  @override
  String get smimeCheckRevocation => 'Provjeravaj opoziv certifikata na mreži';

  @override
  String get smimeTrustedAuthorities => 'Pouzdana certifikacijska tijela';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tijela kojima vi vjerujete, uz $count kojima Mozilla vjeruje za e-poštu.',
      few: 'Tijela kojima vi vjerujete, uz $count kojima Mozilla vjeruje za e-poštu.',
      one: 'Tijela kojima vi vjerujete, uz $count kojem Mozilla vjeruje za e-poštu.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Certifikacijsko tijelo';

  @override
  String get smimeImportACertificate => 'Uvezite certifikat';

  @override
  String get smimeImportContactMessage => 'Certifikat dopisnika (.cer, .crt, .pem) ili certifikacijskog tijela.';

  @override
  String get smimeFromClipboard => 'Iz međuspremnika';

  @override
  String get smimeFromFile => 'Iz datoteke';

  @override
  String get smimeClipboardEmpty => 'Međuspremnik je prazan. Najprije kopirajte certifikat.';

  @override
  String get smimeCertificate => 'Certifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Njegov privatni ključ ostaje u Androidovoj pohrani vjerodajnica, gdje ste ga instalirali vi ili vaša tvrtka: Loupe traži od Androida da njime potpisuje i dešifrira. Potpisana pošta potpisuje se pri slanju.';

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
  String get smimeUsageCertificates => 'Certifikati';

  @override
  String get smimeAlgorithm => 'Algoritam';

  @override
  String get smimeSerialNumber => 'Serijski broj';

  @override
  String get smimeFingerprintCopied => 'Otisak je kopiran.';

  @override
  String get smimeSha1Thumbprint => 'Digitalni otisak SHA-1';

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
  String get smimeTrustedRoot => 'Pouzdano korijensko tijelo';

  @override
  String get smimeIssuer => 'Izdavatelj';

  @override
  String smimeTrustNamed(String name) {
    return 'Vjeruj „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Vjeruj ovom tijelu';

  @override
  String get smimeTrustThisCertificate => 'Vjeruj ovom certifikatu';

  @override
  String get smimeStopTrusting => 'Prestani vjerovati';

  @override
  String get smimePassphrase => 'Pristupna fraza';

  @override
  String get smimePassphraseFooter =>
      'Neobavezno. S pristupnom frazom privatni je ključ i šifriran na ovom uređaju (Argon2id i AES-256), a Loupe je traži za potpisivanje i dešifriranje; koliko dugo, određuje Zapamti pristupne fraze. Pošta koju šaljete potpisuje se pri slanju; poslovi u pozadini ne mogu koristiti ključ.';

  @override
  String get smimeChangePassphrase => 'Promijeni pristupnu frazu…';

  @override
  String get smimeSetPassphraseEllipsis => 'Postavi pristupnu frazu…';

  @override
  String get smimeRemovePassphrase => 'Ukloni pristupnu frazu';

  @override
  String get smimeShareCertificate => 'Dijeli certifikat';

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
      'Privatni ključ tada štiti samo spremište ključeva, kao bez pristupne fraze: Loupe je više neće tražiti, a poslovi u pozadini moći će ga koristiti.';

  @override
  String get smimePassphraseRemoved => 'Pristupna fraza je uklonjena.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vjerovati „$name“?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Svakom certifikatu koji izda vjerovat će se za poštu. Najprije usporedite otisak s njegovim vlasnikom:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Izbrisati vaš certifikat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Ukloniti certifikat osobe $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ga prestaje koristiti: poštu šifriranu za njega više nećete moći čitati u aplikaciji Loupe. Certifikat ostaje na ovom uređaju (Postavke › Sigurnost › Enkripcija i vjerodajnice).';

  @override
  String get smimeDeleteOwnMessage =>
      'Njegov privatni ključ briše se s ovog uređaja: poštu šifriranu za njega ovdje više nećete moći čitati, osim ako ga ponovno ne uvezete.';

  @override
  String get smimeRemoveContactMessage => 'Vratit će se s njegovom sljedećom potpisanom porukom.';

  @override
  String get smimeAddressImportFooter =>
      'Uvezite certifikat za ovu adresu da biste potpisivali i šifrirali S/MIME-om, kao što to radi Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Uvezi certifikat…';

  @override
  String get smimePreferFooter =>
      'Kad bi oba mogla zaštititi poruku, koristi se preferirani, osim ako samo drugi ima ključ ili certifikat za svakog primatelja.';

  @override
  String get smimePreferSmime => 'Preferiraj S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Umjesto OpenPGP-a';

  @override
  String get smimeCertificatePassword => 'Lozinka certifikata';

  @override
  String get smimeCertificatePasswordPrompt => 'Unesite lozinku s kojom je datoteka certifikata izvezena.';

  @override
  String get smimeImport => 'Uvezi';

  @override
  String get smimeWrongPassword => 'Lozinka nije točna. Pokušajte ponovno.';

  @override
  String get smimeNoCertificateFound => 'Nije pronađen nijedan certifikat.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikat osobe $name';
  }

  @override
  String get smimeNothingNew => 'Nema ništa novo za uvoz.';

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
    return 'Ovaj privitak sadrži certifikat s privatnim ključem: $names. Uvezite ga samo ako ste ga sami izvezli, na primjer iz Outlooka ili Thunderbirda.';
  }

  @override
  String get smimeImportAsMine => 'Uvezi kao moj certifikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Uvezen je vaš certifikat $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Vaš certifikat $name ($addresses) dodan je s ovog uređaja.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vjerovati „$name“ za poštu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ne poznaje ovo certifikacijsko tijelo (možda je riječ o vlastitom tijelu neke tvrtke). Vjerujte mu da biste mogli provjeravati certifikate koje izdaje. Najprije usporedite njegov otisak sa svojim IT odjelom:\n$fingerprint';
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
  String get smimeUnlockTitle => 'Otključaj S/MIME certifikat';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Unesite pristupnu frazu za certifikat $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Pristupna fraza nije točna. Pokušajte ponovno.';

  @override
  String get smimeUnlock => 'Otključaj';

  @override
  String get smimeEnterAPassphrase => 'Unesite pristupnu frazu.';

  @override
  String get smimePassphrasesDiffer => 'Pristupne fraze se razlikuju.';

  @override
  String get smimeSetPassphraseTitle => 'Postavi pristupnu frazu';

  @override
  String get smimeSetPassphraseText =>
      'Loupe će je tražiti za potpisivanje i dešifriranje. Ako je zaboravite, ponovno uvezite certifikat iz njegove datoteke .p12.';

  @override
  String get smimePassphraseAgain => 'Ponovno';

  @override
  String get smimeSetPassphraseButton => 'Postavi';

  @override
  String get smimeLockedOpenAgain =>
      'Vaš je S/MIME certifikat zaključan. Ponovno otvorite poruku da biste ga otključali.';

  @override
  String get smimeDeviceHasNoCertificates => 'Ovaj uređaj ne nudi svoje certifikate.';

  @override
  String get smimeCantReadCertificate => 'Loupe ne može pročitati ovaj certifikat.';

  @override
  String get smimeCertificateNotForMail =>
      'Ovaj certifikat nije za poštu: nema adresu e-pošte ili nije namijenjen potpisivanju ni šifriranju.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikat više nije na ovom uređaju ili ga Loupe više ne smije koristiti. Ponovno ga odaberite u Postavke › End-to-end šifriranje.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Certifikat na ovom uređaju može se koristiti samo dok je Loupe otvoren.';

  @override
  String get smimeDeviceKeyDamaged => 'Šifrirani ključ je oštećen.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikat na ovom uređaju to ne može: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nije podržano';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikat na ovom uređaju nije uspio: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa certifikacijskog tijela nije web-adresa.';

  @override
  String get smimeAuthorityTimeout => 'Certifikacijsko tijelo nije odgovorilo na vrijeme.';

  @override
  String get smimeAuthorityUnreachable => 'Certifikacijsko tijelo nije dostupno.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Certifikacijsko tijelo odgovorilo je kodom $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odgovor certifikacijskog tijela je prevelik.';

  @override
  String get smimeRevocationNotChecked =>
      'Nije provjereno: provjeravaju se samo certifikati tijela kojima Loupe vjeruje.';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Isto kao na telefonu';

  @override
  String get settingsLanguageFooter =>
      'Loupe koristi jezik vašeg telefona ako ga ima, a engleski ako ga nema. Jezik koji ovdje odaberete vrijedi samo za Loupe, uključujući obavijesti.';

  @override
  String get settingsAccountsHeader => 'Računi';

  @override
  String get settingsAddAccount => 'Dodaj račun';

  @override
  String get settingsMailHeader => 'Pošta';

  @override
  String get settingsSwipeActions => 'Radnje potezom prsta';

  @override
  String get settingsSwipeLeft => 'Potez ulijevo';

  @override
  String get settingsSwipeLeftFooter =>
      'Potpuni potez pokreće ovu radnju. Označi zastavicom i Više uvijek su dostupni kratkim potezom.';

  @override
  String get settingsSwipeRight => 'Potez udesno';

  @override
  String get settingsSwipeRightFooter => 'Potpuni potez pokreće ovu radnju.';

  @override
  String get settingsSwipeToggleRead => 'Označi kao pročitano/nepročitano';

  @override
  String get settingsSwipeTrash => 'U smeće';

  @override
  String get settingsSwipeMove => 'Premjesti poruku';

  @override
  String get settingsSwipeSnooze => 'Odgodi';

  @override
  String get settingsThreaded => 'Grupiraj po razgovorima';

  @override
  String get settingsUndoSendDelay => 'Vrijeme za poništavanje slanja';

  @override
  String get settingsUndoSendDelayFooter => 'Poslane poruke čekaju ovoliko dugo kako biste ih mogli povući.';

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
  String get settingsThemeSystem => 'Automatski';

  @override
  String get settingsThemeLight => 'Svijetla';

  @override
  String get settingsThemeDark => 'Tamna';

  @override
  String get settingsDensity => 'Popis poruka';

  @override
  String get settingsDensityComfortable => 'Prostran';

  @override
  String get settingsDensityCompact => 'Kompaktan';

  @override
  String get settingsReadingHeader => 'Čitanje';

  @override
  String get settingsReadingFooter => 'Udaljene slike mogu pošiljateljima otkriti kada i gdje ste otvorili poruku.';

  @override
  String get settingsDefaultView => 'Zadani prikaz';

  @override
  String get settingsDefaultViewFooter => 'Prikaz bilo koje poruke možete promijeniti gumbom Aa.';

  @override
  String get settingsViewReadable => 'Čitljivo';

  @override
  String get settingsViewReadableDetail => 'Čisto, čitljivo, prati tamni način';

  @override
  String get settingsViewOriginal => 'Izvorno';

  @override
  String get settingsViewOriginalDetail => 'Točno onako kako ju je pošiljatelj osmislio';

  @override
  String get settingsViewPlain => 'Čisti tekst';

  @override
  String get settingsViewPlainDetail => 'Samo riječi';

  @override
  String get settingsPlainTextFont => 'Font čistog teksta';

  @override
  String get settingsFontSans => 'Bez serifa';

  @override
  String get settingsFontMono => 'Fiksna širina';

  @override
  String get settingsFontMonoDetail => 'Zadržava poravnanje ASCII crteža i tablica';

  @override
  String get settingsTechnicalLists => 'Tehničke liste';

  @override
  String get settingsLoadRemoteImages => 'Učitavaj udaljene slike';

  @override
  String get settingsOpenLinksDirectly => 'Otvaraj poveznice izravno';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Zaobiđi praćenje klikova kad je odredište poznato';

  @override
  String get settingsSecurityHeader => 'Sigurnost';

  @override
  String get settingsAppLock => 'Zaključavanje aplikacije';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe pita pri pokretanju i kad se vratite nakon odsutnosti dulje od vremena u postavci Zaključaj nakon.';

  @override
  String get settingsAppLockFooterOff =>
      'Zaključavanje aplikacije traži otisak prsta, lice ili zaključavanje zaslona prije prikaza pošte.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Zaključavanje aplikacije još je isključeno. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Postavite šifru';

  @override
  String get settingsScreenLockTextIos =>
      'Zaključavanje aplikacije koristi Face ID, Touch ID ili šifru, a ovaj iPhone nema šifru. Postavite je u aplikaciji Postavke, a zatim uključite zaključavanje aplikacije.';

  @override
  String get settingsScreenLockTitleAndroid => 'Postavite zaključavanje zaslona';

  @override
  String get settingsScreenLockTextAndroid =>
      'Zaključavanje aplikacije koristi zaključavanje zaslona telefona ili otisak prsta ili lice dodani uz njega, a ovaj telefon nema ništa od toga. Postavite PIN, uzorak ili zaporku u postavkama Androida, a zatim uključite zaključavanje aplikacije.';

  @override
  String get settingsOpenSystemSettings => 'Otvori Postavke';

  @override
  String get settingsOpenAndroidSettings => 'Otvori postavke Androida';

  @override
  String get settingsLockAfter => 'Zaključaj nakon';

  @override
  String get settingsLockAfterFooter => 'Koliko dugo Loupe može biti u pozadini prije nego što ponovno pita.';

  @override
  String get settingsNotifications => 'Obavijesti';

  @override
  String get settingsEncryption => 'End-to-end šifriranje';

  @override
  String get settingsAdvanced => 'Napredno';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo pošta izmišljeni je sandučić koji postoji samo na ovom telefonu. Ništa se nikamo ne šalje.';

  @override
  String get settingsDemoMode => 'Demo način';

  @override
  String get settingsResetApp => 'Vrati aplikaciju na početno';

  @override
  String get settingsResetFooter => 'Zaboravlja sve postavke i vraća se na početni zaslon.';

  @override
  String get settingsResetTitle => 'Vratiti Loupe na početno?';

  @override
  String get settingsResetMessage =>
      'Zaboravljaju se sve postavke, Smart Mailboxes i nedavne pretrage, a aplikacija se vraća na početni zaslon.';

  @override
  String get settingsAboutHeader => 'O aplikaciji';

  @override
  String get settingsVersion => 'Verzija';

  @override
  String get settingsLicences => 'Licence';

  @override
  String get settingsPrivacy => 'Privatnost';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nema analitike ni praćenja. Vaša pošta ide samo na vaše poslužitelje e-pošte.';

  @override
  String get settingsNotificationsOffIos => 'Obavijesti za Loupe isključene su u Postavkama.';

  @override
  String get settingsNotificationsOffAndroid => 'Obavijesti za Loupe isključene su u postavkama Androida.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system ne dopušta aplikaciji Loupe prikazivanje obavijesti. Dopustite ih u Postavkama.';
  }

  @override
  String get settingsNewMailHeader => 'Nova pošta';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo pošta ne stiže u pozadini. Pošaljite probnu obavijest da vidite kako izgleda nova pošta.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe provjerava novu poštu u pozadini kad to iOS dopusti, što za aplikacije koje rijetko otvarate može biti u razmacima od nekoliko sati. Dobivate obavijesti o novim porukama u pristigloj pošti te o porukama VIP kontakata u bilo kojoj mapi.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe provjerava novu poštu otprilike svakih 15 minuta, kad to Android dopusti. Dobivate obavijesti o novim porukama u pristigloj pošti te o porukama VIP kontakata u bilo kojoj mapi.';

  @override
  String get settingsNoAccounts => 'Nema računa';

  @override
  String get settingsVipOnly => 'Samo VIP';

  @override
  String get settingsVipOnlyDetail => 'Samo poruke vaših VIP kontakata';

  @override
  String get settingsHideContent => 'Sakrij sadržaj';

  @override
  String get settingsHideContentFooterOn =>
      'Obavijesti navode samo „Nova poruka s računa“ i račun, a ne tko je pisao ni o čemu.';

  @override
  String get settingsHideContentFooterOff =>
      'Sakrij sadržaj uklanja pošiljatelja, predmet i pretpregled sa zaključanog zaslona i iz obavijesti.';

  @override
  String get settingsBackgroundAppRefresh => 'Osvježavanje aplikacija u pozadini';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nova pošta u pozadini stiže samo dok je za Loupe u Postavkama uključeno Osvježavanje aplikacija u pozadini. iOS ne može održavati otvorenu vezu s pristiglom poštom, pa nema Trenutačne dostave.';

  @override
  String get settingsInstantDelivery => 'Trenutačna dostava';

  @override
  String get settingsInstantDeliveryFooter =>
      'Trenutačna dostava (eksperimentalno) održava otvorenu vezu s pristiglom poštom, pa nova pošta stiže u roku od nekoliko sekundi. Prikazuje tihu obavijest „Praćenje nove pošte“ i troši više baterije.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android može zaustaviti Trenutačnu dostavu radi uštede baterije. Dopustite aplikaciji Loupe neograničenu upotrebu baterije kako bi dostava nastavila raditi.';

  @override
  String get settingsExperimental => 'Eksperimentalno';

  @override
  String get settingsComingSoon => 'Uskoro';

  @override
  String get settingsAllowUnrestrictedBattery => 'Dopusti neograničenu upotrebu baterije';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push omogućuje da nova pošta odmah probudi Loupe, ako to vaša usluga e-pošte podržava. Push poruke idu preko Googleove usluge za push i ne sadrže poštu, samo „provjeri sada“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ovaj telefon ne može primati push poruke: potrebne su usluge Google Playa i mrežna veza. Loupe i dalje provjerava poštu otprilike svakih 15 minuta.';

  @override
  String get settingsCopyPushToken => 'Kopiraj push token';

  @override
  String get settingsPushTokenCopied => 'Push token je kopiran';

  @override
  String get settingsSendTestNotification => 'Pošalji probnu obavijest';

  @override
  String get settingsAppIconBadge => 'Značka na ikoni aplikacije';

  @override
  String get settingsBadgeNote => 'Značka se ažurira kad god Loupe provjerava poštu, i u pozadini.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Početni zaslon ovog telefona ne prikazuje brojeve na ikonama aplikacija. Značka se ažurira kad god Loupe provjerava poštu, i u pozadini.';

  @override
  String get settingsTestNotificationBody => 'Obavijesti o novoj pošti izgledaju ovako.';

  @override
  String get settingsAccountRemoved => 'Ovaj je račun uklonjen.';

  @override
  String get settingsAccountHeader => 'Račun';

  @override
  String get settingsAccountDescription => 'Opis';

  @override
  String get settingsAccountDescriptionHint => 'Posao, Osobno…';

  @override
  String get settingsEmail => 'E-pošta';

  @override
  String get settingsColour => 'Boja';

  @override
  String get settingsColourFooter => 'Označava poruke ovog računa u prikazu Sva pristigla pošta.';

  @override
  String settingsColourNumber(int number) {
    return 'Boja $number';
  }

  @override
  String get settingsSendingHeader => 'Slanje';

  @override
  String get settingsSendingFooter =>
      'Svaki identitet ima vlastiti potpis. Odgovori se šalju s adrese na koju je poruka poslana.';

  @override
  String get settingsFoldersHeader => 'Mape';

  @override
  String get settingsFoldersFooter =>
      'Loupe prikazuje i sinkronizira mape na koje ste pretplaćeni, kao i Thunderbird. Pristigla pošta, Skice, Poslano, Neželjena pošta, Smeće i Arhiva uvijek se prikazuju.';

  @override
  String get settingsShowAllFolders => 'Prikaži sve mape';

  @override
  String get settingsIncoming => 'Dolazni poslužitelj';

  @override
  String get settingsOutgoing => 'Odlazni poslužitelj';

  @override
  String get settingsConnectionNotEncrypted => 'Nešifrirano';

  @override
  String get settingsSignIn => 'Prijava';

  @override
  String get settingsSignInExpired => 'Isteklo';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider više ne prihvaća prijavu aplikacije Loupe za ovaj račun pa se njegova pošta ne sinkronizira. Prijavite se ponovno da biste to riješili.';
  }

  @override
  String get settingsSignInAgain => 'Ponovno se prijavi';

  @override
  String get settingsSigningIn => 'Prijava…';

  @override
  String get settingsRemoveAccount => 'Ukloni račun';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Ukloniti „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Njegova pošta i postavke uklanjaju se s ovog telefona. Na poslužitelju se ništa ne briše.';

  @override
  String get settingsManageFolders => 'Upravljaj mapama';

  @override
  String get settingsNoFolders => 'Još nema mapa.';

  @override
  String get settingsManageFoldersFooter =>
      'Mape na koje ste pretplaćeni prikazuju se na zaslonu Sandučići i sinkroniziraju u pozadini. Druge aplikacije za e-poštu s istim računom obično također prate te pretplate.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Čuva vaše Smart Mailboxes za druge uređaje. Skrivena je na zaslonu Sandučići.';

  @override
  String get settingsFolderAlwaysShown => 'Uvijek prikazano';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Pretplati se na $folder';
  }

  @override
  String get settingsIdentities => 'Identiteti';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Prvi identitet zadan je za nove poruke. Povucite da biste promijenili redoslijed.';

  @override
  String get settingsIdentitiesFooterSingle => 'Zadani identitet za nove poruke.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odgovor se šalje s identiteta na koji je poruka poslana.';

  @override
  String get settingsIdentityDefault => 'Zadano';

  @override
  String settingsIdentityReorder(String email) {
    return 'Promijeni redoslijed za $email';
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
  String get settingsReplyTo => 'Odgovor na';

  @override
  String get settingsSignature => 'Potpis';

  @override
  String get settingsSignatureFooter => 'Dodaje se ispod „-- “ u porukama s ovog identiteta.';

  @override
  String get settingsNoSignature => 'Bez potpisa';

  @override
  String get settingsCopyToMyself => 'Kopija meni';

  @override
  String get settingsCopyToMyselfFooter => 'Dodaje se svakoj poruci s ovog identiteta.';

  @override
  String get settingsCc => 'Kopija';

  @override
  String get settingsBcc => 'Skrivena kopija';

  @override
  String get settingsReplyPatterns => 'Koristi za odgovore na';

  @override
  String get settingsReplyPatternsFooter =>
      'Odgovori na poruke poslane na ove adrese šalju se s ovog identiteta. * zamjenjuje bilo što: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adresa ili uzorak u kojem * zamjenjuje bilo što.';

  @override
  String get settingsAddReplyPattern => 'Dodaj adresu ili uzorak';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Ukloni $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Nevaljan uzorak';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ nije adresa ni uzorak poput *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nema adrese';

  @override
  String get settingsIdentityNoAddressMessage => 'Unesite adresu e-pošte s koje želite slati.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Nevaljana adresa';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„$address“ u polju Odgovor na nije valjana adresa e-pošte.',
      'cc': '„$address“ u polju Kopija nije valjana adresa e-pošte.',
      'bcc': '„$address“ u polju Skrivena kopija nije valjana adresa e-pošte.',
      'other': '„$address“ nije valjana adresa e-pošte.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Spremi identitet';

  @override
  String get settingsDiscardChanges => 'Odbaci promjene';

  @override
  String get settingsDeleteIdentity => 'Izbriši identitet';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Izbrisati „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Poruke koje su već poslane s njega ostaju kakve jesu.';

  @override
  String get settingsLastIdentityFooter => 'Račun treba imati barem jedan identitet.';

  @override
  String get rulesTitle => 'Pravila';

  @override
  String get rulesNewRule => 'Novo pravilo';

  @override
  String get rulesLoadError => 'Pravila nije bilo moguće učitati.';

  @override
  String get rulesEmptyTitle => 'Nema pravila';

  @override
  String get rulesEmptyText =>
      'Pravila umjesto vas razvrstavaju novu poštu te joj dodaju oznake i zastavice. Izradite ga gumbom za pisanje iznad ili iz pretrage pomoću „Pretvori u pravilo“.';

  @override
  String get rulesListFooter =>
      'Pravila se na novu poštu u pristigloj pošti primjenjuju odozgo prema dolje. Dodirnite i zadržite pravilo da biste ga premjestili.';

  @override
  String get rulesChangeError => 'Pravilo nije bilo moguće promijeniti';

  @override
  String get rulesConditionEveryMessage => 'Svaka poruka';

  @override
  String rulesMoveRule(String rule) {
    return 'Premjesti $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule uključeno';
  }

  @override
  String get rulesServerRulesHeader => 'Pravila na poslužitelju';

  @override
  String get rulesServerRulesFooter =>
      'Pravila na poslužitelju izvršavaju se na poslužitelju e-pošte kad pošta stigne, čak i dok je ovaj telefon isključen. Čuvaju se u Sieve skripti pod nazivom „loupe“.';

  @override
  String get rulesStatusUnknown => 'Nepoznato';

  @override
  String get rulesStatusError => 'Nije bilo moguće upitati poslužitelj.';

  @override
  String get rulesStatusChecking => 'Provjera…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Pokreće se iz skripte „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktivna je skripta „$script“. Dodirnite da bi izvršavala i pravila aplikacije Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na poslužitelju nije aktivna nijedna skripta. Spremanjem pravila na poslužitelju uključuje se skripta aplikacije Loupe.';

  @override
  String get rulesStatusUnavailable => 'Nije dostupno';

  @override
  String get rulesStatusNoSieve => 'Poslužitelj ovog računa ne nudi Sieve (ManageSieve ni JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Premjesti u $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Premjesti u mapu';

  @override
  String rulesActionTag(String tag) {
    return 'Dodaj oznaku $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Ukloni oznaku $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Zadrži u pristigloj pošti';

  @override
  String rulesActionForward(String address) {
    return 'Proslijedi na $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Proslijedi na $address, bez kopije';
  }

  @override
  String get rulesActionStop => 'Zaustavi';

  @override
  String get rulesNoActions => 'Još ništa ne radi';

  @override
  String get rulesLocationDevice => 'Uređaj';

  @override
  String get rulesLocationServer => 'Poslužitelj';

  @override
  String get rulesLocationThisDevice => 'Ovaj uređaj';

  @override
  String get rulesNewRuleTitle => 'Novo pravilo';

  @override
  String get rulesEditRuleTitle => 'Uredi pravilo';

  @override
  String get rulesDefaultNameEveryMessage => 'Svaka poruka';

  @override
  String get rulesConditionHeader => 'Kad nova poruka odgovara';

  @override
  String get rulesConditionFooter =>
      'Napišite kao što biste pretraživali: from:, to:, s: (predmet), b: (tijelo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:račun';

  @override
  String get rulesAccounts => 'Računi';

  @override
  String get rulesAllAccounts => 'Svi računi';

  @override
  String get rulesRemovedAccount => 'Uklonjeni račun';

  @override
  String get rulesAccountsFooter => 'Pravilo za sve račune obuhvaća i račune koje dodate kasnije.';

  @override
  String get rulesActionsHeader => 'Tada';

  @override
  String get rulesForwardingFooter =>
      'Prosljeđivanje šalje svaku odgovarajuću poruku na drugu adresu čim stigne, čak i dok je ovaj telefon isključen. Neki pružatelji ograničavaju koliko se pošte smije proslijediti.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Prosljeđivanje radi samo u pravilima na poslužitelju pa je ovdje izostavljeno.';

  @override
  String rulesRemoveAction(String action) {
    return 'Ukloni $action';
  }

  @override
  String get rulesAddAction => 'Dodaj radnju';

  @override
  String get rulesAddMove => 'Premjesti u mapu…';

  @override
  String get rulesAddTagMenu => 'Dodaj oznaku…';

  @override
  String get rulesRemoveTagMenu => 'Ukloni oznaku…';

  @override
  String get rulesAddForward => 'Proslijedi na…';

  @override
  String get rulesStopProcessing => 'Zaustavi obradu ostalih pravila';

  @override
  String get rulesRunOnHeader => 'Izvršavaj na';

  @override
  String get rulesRunOnDeviceFooter =>
      'Ovaj uređaj izvršava pravilo na novoj pošti u pristigloj pošti svaki put kad Loupe provjerava poštu.';

  @override
  String get rulesRunOnServerFooter =>
      'Poslužitelj e-pošte izvršava pravilo kad pošta stigne, čak i dok je ovaj telefon isključen. Potreban je Sieve, putem ManageSievea (Dovecot, mailcow) ili JMAP-a (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Primijeni na postojeće poruke…';

  @override
  String get rulesDeleteRule => 'Izbriši pravilo';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Izbrisati „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mapa u kojem računu?';

  @override
  String get rulesMoveAccountMessage => 'Pošta ostalih računa ide u mapu istog naziva u tim računima.';

  @override
  String get rulesAddTag => 'Dodaj oznaku';

  @override
  String get rulesRemoveTag => 'Ukloni oznaku';

  @override
  String get rulesForwardTo => 'Proslijedi na';

  @override
  String get rulesForwardToMessage =>
      'Poslužitelj prosljeđuje svaku odgovarajuću poruku na ovu adresu, čak i dok je ovaj telefon isključen. Koristite adresu koju posjedujete ili kojoj vjerujete.';

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
  String get rulesDontKeepCopy => 'Ne zadržavaj kopiju';

  @override
  String get rulesCheckCondition => 'Provjerite uvjet';

  @override
  String get rulesChooseActionTitle => 'Odaberite radnju';

  @override
  String get rulesChooseActionMessage => 'Dodajte što pravilo radi s porukama koje mu odgovaraju.';

  @override
  String get rulesSaveError => 'Pravilo nije bilo moguće spremiti';

  @override
  String get rulesSaveServerError => 'Pravilo na poslužitelju nije bilo moguće spremiti';

  @override
  String get rulesRunOnDeviceInstead => 'Umjesto toga izvršavaj na ovom uređaju';

  @override
  String get rulesNothingToApplyTitle => 'Nema se što primijeniti';

  @override
  String get rulesNothingToApplyMessage => 'Najprije pravilu zadajte valjan uvjet i radnju.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Primijeni „$rule“ na poruke u…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Pristigla pošta';

  @override
  String get rulesApplyScopeAll => 'Svi sandučići';

  @override
  String get rulesFindingMessages => 'Traženje poruka…';

  @override
  String get rulesSearchError => 'Pretraživanje nije uspjelo';

  @override
  String get rulesSearchErrorUnknown => 'Nešto nije u redu.';

  @override
  String get rulesNoMatchesTitle => 'Nema odgovarajućih poruka';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ništa ondje ne odgovara uvjetu „$condition“.';
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
      other: '„$rule“ primijenjeno na $countString poruka',
      few: '„$rule“ primijenjeno na $countString poruke',
      one: '„$rule“ primijenjeno na $countString poruku',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Provjera mogućnosti poslužitelja…';

  @override
  String get rulesServerUnreachable => 'Poslužitelj nije dostupan.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ne može se izvršavati na poslužitelju: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ne može se izvršavati na poslužitelju računa $account: $problem';
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
      'Iz posljednjih 30 dana. Samo pravilo djeluje samo na novu poštu, osim ako ga primijenite na postojeće poruke.';

  @override
  String rulesConditionError(String error) {
    return 'Uvjet sadrži pogrešku: $error';
  }

  @override
  String get rulesPreviewNoSender => '(bez pošiljatelja)';

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
  String get rulesIncludeTitle => 'Uključi pravila na poslužitelju';

  @override
  String get rulesIncludeLeaveOff => 'Ostavi isključeno';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Poslužitelj već izvršava pravila aplikacije Loupe za $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ je aktivna skripta na poslužitelju računa $account pa poslužitelj izvršava nju, a ne pravila aplikacije Loupe. Loupe je neće zamijeniti. Može joj dodati ove retke, a poslužitelj tada izvršava pravila aplikacije Loupe nakon pravila same skripte:';
  }

  @override
  String get rulesShowWholeScript => 'Prikaži cijelu skriptu';

  @override
  String get rulesHideWholeScript => 'Sakrij cijelu skriptu';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ništa se drugo u „$script“ ne mijenja. Ako se njezini filtri kasnije uređuju u web-pošti, web-pošta je može prepisati bez ovih redaka; Loupe tada ponovno prikazuje pravila na poslužitelju kao isključena.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Dodaj u „$script“';
  }

  @override
  String get subscriptionsTitle => 'Pretplate';

  @override
  String get subscriptionsNewsletters => 'Bilteni';

  @override
  String get subscriptionsDiscussions => 'Rasprave';

  @override
  String get subscriptionsFilter => 'Filtriraj';

  @override
  String get subscriptionsFilterNeverRead => 'Nikad pročitano';

  @override
  String get subscriptionsFilterRarelyRead => 'Rijetko pročitano';

  @override
  String get subscriptionsFilterAll => 'Sve';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Pretplate nije bilo moguće prebrojiti';

  @override
  String get subscriptionsNoMatches => 'Nema podudaranja';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nijedan bilten ne zove se „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nijedna lista ne zove se „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Nema biltena';

  @override
  String get subscriptionsNoNewslettersDetail => 'Bilteni i druga masovna pošta pojavit će se ovdje kad stignu.';

  @override
  String get subscriptionsNothingNeverRead => 'Nema nikad pročitanih';

  @override
  String get subscriptionsNothingRarelyRead => 'Nema rijetko pročitanih';

  @override
  String get subscriptionsNothingFilteredDetail => 'Od svega što primate ponešto pročitate.';

  @override
  String get subscriptionsNoDiscussions => 'Nema rasprava';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Dopisne liste na koje možete pisati pojavit će se ovdje kad stigne njihova pošta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Liste na koje piše više ljudi. Dodirnite i zadržite listu da biste je prikvačili na Sandučiće, čitali kao čisti tekst ili premjestili u Biltene.';

  @override
  String get subscriptionsPrivacyNote =>
      'Izračunato na ovom telefonu iz preuzete pošte; za to se ništa nikamo ne šalje. Loupe kontaktira pošiljatelja samo kad dodirnete Odjavi: odjava jednim klikom šalje samo „List-Unsubscribe=One-Click“ na adresu koju je pošiljatelj naveo, bez kolačića i bez ičega drugog o vama, i nikad ne učitava njegove stranice ni slike.';

  @override
  String get subscriptionsVolumeNone => 'U posljednje vrijeme ništa';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mjesečno';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mjesečno';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

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
    return 'Na web-mjestu $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Odjavi';

  @override
  String get subscriptionsUnsubscribeAgain => 'Ponovno odjavi';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhiviraj $countString poruka iz pristigle pošte',
      few: 'Arhiviraj $countString poruke iz pristigle pošte',
      one: 'Arhiviraj $countString poruku iz pristigle pošte',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Izradi pravilo…';

  @override
  String get subscriptionsCreateRuleDetail => 'Premještaj ili arhiviraj njegovu buduću poštu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Smatraj raspravom';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Lista na koju ljudi pišu: čitajte je kao forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Smatraj biltenom';

  @override
  String get subscriptionsBlockSender => 'Blokiraj pošiljatelja';

  @override
  String get subscriptionsBlock => 'Blokiraj';

  @override
  String get subscriptionsBlocked => 'Blokirano';

  @override
  String get subscriptionsBlockedDetail => 'Nova pošta ide u neželjenu poštu';

  @override
  String get subscriptionsPin => 'Prikvači na Sandučiće';

  @override
  String get subscriptionsUnpin => 'Otkvači sa Sandučića';

  @override
  String get subscriptionsOpenDefaultView => 'Otvori u zadanom prikazu';

  @override
  String get subscriptionsOpenPlainText => 'Otvori kao čisti tekst (fiksna širina)';

  @override
  String get subscriptionsPinned => 'Prikvačeno';

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
  String get subscriptionsNoMailNow => 'Trenutačno nema pošte od ovog pošiljatelja.';

  @override
  String get subscriptionsLatestMessages => 'NAJNOVIJE PORUKE';

  @override
  String get subscriptionsMail => 'Pošta';

  @override
  String get subscriptionsNoneIn90Days => 'Ništa u 90 dana';

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
  String get subscriptionsLastReceived => 'Posljednja primljena';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Nalazi se u');
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
    return '$sender ne navodi kako se odjaviti. Umjesto toga možete ga blokirati.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Odjavljivanje od pošiljatelja $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Odjavljeni ste od pošiljatelja $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Odjava nije uspjela: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatska odjava nije uspjela';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Pošalji e-poruku za odjavu';

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
    return '$sender odjavu provodi na svojem web-mjestu. Stranica se otvara u pregledniku aplikacije Loupe; dovršite odjavu ondje.';
  }

  @override
  String get subscriptionsWebInsecure => 'Veza s ovim web-mjestom nije šifrirana.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Oprez: ova adresa oponaša $site slovima sličnog izgleda.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Oprez: ova adresa oponaša drugo web-mjesto slovima sličnog izgleda.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site nije bilo moguće otvoriti.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe bilježi današnji datum i javit će vam ako od pošiljatelja $sender i dalje bude stizala pošta.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Odjaviti se od pošiljatelja $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe će kontaktirati $site radi odjave.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Ovo je jedini put kad Loupe kontaktira web-mjesto pošiljatelja. Šalje samo „List-Unsubscribe=One-Click“ na adresu koju navodi $sender, bez kolačića i bez ičega drugog o vama, i ne učitava stranicu.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Poveznica za odjavu nije sigurna internetska adresa.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Web-mjesto $site nije odgovorilo na vrijeme.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Web-mjesto $site nije dostupno.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Web-mjesto $site preusmjerilo je zahtjev na drugu stranicu, koju Loupe ne slijedi.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Web-mjesto $site odbilo je zahtjev (pogreška $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nema računa s kojeg bi se poslala e-poruka za odjavu.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe će poslati e-poruku na $to s adrese $from, s predmetom „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-poruka za odjavu poslana je na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Blokirati $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nova pošta s ove liste ide u neželjenu poštu. To možete promijeniti u Postavke › Pravila.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nova pošta s adrese $address ide u neželjenu poštu. To možete promijeniti u Postavke › Pravila.';
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
      other: 'Premjesti $count poruka u neželjenu poštu',
      few: 'Premjesti $count poruke u neželjenu poštu',
      one: 'Premjesti $count poruku u neželjenu poštu',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokiraj $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender je sada među biltenima.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender je sada među raspravama.';
  }

  @override
  String get appLiveGateTitle => 'Vaše račune nije bilo moguće otvoriti';

  @override
  String get appLiveGateUnavailableBuild => 'Pravi računi još nisu dostupni u ovoj verziji.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nije mogao pročitati ključ koji štiti vašu poštu na ovom telefonu. To je često privremeno: pokušajte ponovno ili ponovno pokrenite telefon.';

  @override
  String get appLiveGateKeyMissing =>
      'Ključ koji štiti vašu poštu na ovom telefonu nestao je, što se može dogoditi nakon vraćanja sigurnosne kopije. Vaša je pošta i dalje na poslužitelju.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Bazu podataka pošte na ovom telefonu nije moguće pročitati: oštećena je ili joj se ključ promijenio. Vaša je pošta i dalje na poslužitelju.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Nešto nije u redu pri otvaranju vaših računa ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Ovime se brišu vaši računi i pošta spremljena na ovom telefonu, uključujući poruke koje čekaju u izlaznom spremniku. Pošta na vašim poslužiteljima nije zahvaćena; nakon toga ponovno dodajte svoje račune.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Izbriši i počni ispočetka';

  @override
  String get appLiveGateUseDemo => 'Koristi demo poštu';

  @override
  String get appLiveGateReset => 'Vrati poštu na ovom telefonu na početno…';

  @override
  String get attachmentsUntitled => 'Privitak';

  @override
  String get attachmentsUntitledFile => 'Bez naziva';

  @override
  String get attachmentsOpenIn => 'Otvori u…';

  @override
  String get attachmentsSaveToFiles => 'Spremi u datoteke';

  @override
  String get attachmentsShareMenu => 'Dijeli…';

  @override
  String get attachmentsDownloadError => 'Privitak nije bilo moguće preuzeti. Provjerite vezu i pokušajte ponovno.';

  @override
  String get attachmentsShareError => 'Privitak nije bilo moguće podijeliti.';

  @override
  String attachmentsNoApp(String type) {
    return 'Na ovom uređaju nema aplikacije koja otvara ovu datoteku ($type). Umjesto toga pokušajte Dijeli.';
  }

  @override
  String get attachmentsOpenInError => 'Privitak nije bilo moguće otvoriti u drugoj aplikaciji.';

  @override
  String attachmentsSaved(String name) {
    return 'Spremljeno: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Privitak nije bilo moguće spremiti.';

  @override
  String get attachmentsGone => 'Ovaj privitak više nije dostupan.';

  @override
  String get attachmentsDownloadFailed => 'Privitak nije bilo moguće preuzeti.';

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
    return '$size putem mobilnih podataka';
  }

  @override
  String get attachmentsLargeDownload => 'Ovaj je privitak velik. Preuzmite ga sada ili kasnije putem Wi-Fija.';

  @override
  String get attachmentsDownload => 'Preuzmi';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Preuzimanje $size…';
  }

  @override
  String get attachmentsDownloading => 'Preuzimanje…';

  @override
  String get attachmentsTooLarge => 'Preveliko za pretpregled ovdje.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Prikazano je prvih $shown od $total. Kopirajte, podijelite ili spremite da biste dobili sve.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Ovaj PDF ne može se ovdje prikazati (možda je zaštićen lozinkom).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page od $count';
  }

  @override
  String get attachmentsModeTable => 'Tablica';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Poruka';

  @override
  String get attachmentsModeSource => 'Izvor';

  @override
  String get attachmentsDontWrap => 'Ne prelamaj retke';

  @override
  String get attachmentsWrap => 'Prelamaj retke';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines redaka',
      few: '$lines retka',
      one: '$count redak',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiraj sve';

  @override
  String get attachmentsCopied => 'Kopirano';

  @override
  String get attachmentsImageUnavailable => 'Ova se slika ne može ovdje prikazati. Pokušajte Otvori u…';

  @override
  String get attachmentsEmlNoSubject => '(Bez predmeta)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Prima';

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
      other: '$count privitaka: $names',
      few: '$count privitka: $names',
      one: '$count privitak: $names',
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
    return 'Slika $format';
  }

  @override
  String get attachmentsTypePdf => 'PDF dokument';

  @override
  String get attachmentsTypeTsv => 'Vrijednosti odvojene tabulatorom';

  @override
  String get attachmentsTypeCsv => 'CSV tablica';

  @override
  String get attachmentsTypeCalendar => 'Kalendarski događaj';

  @override
  String get attachmentsTypeEmail => 'E-poruka';

  @override
  String get attachmentsTypeContact => 'Kontaktna kartica';

  @override
  String get attachmentsTypeLog => 'Datoteka zapisnika';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'ZIP arhiva';

  @override
  String get attachmentsTypeArchive => 'Arhiva';

  @override
  String get attachmentsTypeWord => 'Word dokument';

  @override
  String get attachmentsTypeExcel => 'Excel proračunska tablica';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint prezentacija';

  @override
  String get attachmentsTypeWebPage => 'Web-stranica';

  @override
  String get attachmentsTypeVideo => 'Videozapis';

  @override
  String get attachmentsTypeAudio => 'Zvučni zapis';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Datoteka $extension';
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
    return 'Pridruži se: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvaća: $details',
      'tentative': '$name uvjetno prihvaća: $details',
      'declined': '$name odbija: $details',
      'delegated': '$name delegira: $details',
      'other': '$name još ne odgovara na: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvaća pozivnicu',
      'tentative': '$name uvjetno prihvaća pozivnicu',
      'declined': '$name odbija pozivnicu',
      'delegated': '$name delegira pozivnicu',
      'other': '$name još ne odgovara na pozivnicu',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Karta';

  @override
  String get calendarJoin => 'Pridruži se';

  @override
  String get calendarOnlineMeeting => 'Mrežni sastanak';

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
      'accepted': '$name: prihvaćeno',
      'tentative': '$name: uvjetno prihvaćeno',
      'declined': '$name: odbijeno',
      'delegated': '$name: delegirano',
      'other': '$name: bez odgovora',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name prihvaća:',
      'tentative': '$name uvjetno prihvaća:',
      'declined': '$name odbija:',
      'delegated': '$name delegira:',
      'other': '$name još ne odgovara:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name predlaže novo vrijeme';
  }

  @override
  String get calendarCounterUnknown => 'Sudionik predlaže novo vrijeme';

  @override
  String get calendarDeclineCounter => 'Organizator je zadržao vrijeme';

  @override
  String calendarRefresh(String name) {
    return '$name traži najnoviju verziju';
  }

  @override
  String get calendarRefreshUnknown => 'Sudionik traži najnoviju verziju';

  @override
  String get calendarCancelled => 'Otkazano';

  @override
  String get calendarCancelledByOrganizer => 'Organizator je otkazao ovaj događaj.';

  @override
  String get calendarCancelledLater => 'Ovaj je događaj kasnije otkazan.';

  @override
  String get calendarOutdated => 'Zastarjelo';

  @override
  String get calendarOutdatedDetail => 'Ova je pozivnica kasnije ažurirana; vrijedi novija.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Mjesto uklonjeno (prije: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Mjesto uklonjeno (prije nije bilo navedeno)';

  @override
  String calendarLocationChanged(String location) {
    return 'Mjesto promijenjeno u $location';
  }

  @override
  String get calendarNewTitle => 'Novi naslov';

  @override
  String get calendarRepeatChanged => 'Ponavljanje se promijenilo';

  @override
  String get calendarUpdated => 'Ažurirano';

  @override
  String get calendarUpdatedInvitation => 'Ažurirana pozivnica';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Vrijeme promijenjeno s $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Vremenska zona „$zone“ nije poznata: vremena su prikazana kako su napisana';
  }

  @override
  String calendarNext(String when) {
    return 'Sljedeći: $when';
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
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'prihvaćeno: $count');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'možda: $count');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'odbijeno: $count');
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
      'tentative': 'Uvjetno ste prihvatili raniju verziju.',
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
    return 'Vaš odgovor ide osobi $organizer s adrese $address.';
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
  String get calendarNoCalendarApp => 'Nema aplikacije kalendara u koju bi se dodao događaj.';

  @override
  String get calendarCantOpenCalendar => 'Kalendar nije bilo moguće otvoriti.';

  @override
  String get calendarCantOpenLink => 'Poveznicu nije bilo moguće otvoriti.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Pridružiti se sastanku $provider?';
  }

  @override
  String get calendarJoinTitle => 'Pridružiti se sastanku?';

  @override
  String calendarJoinOpens(String host) {
    return 'Otvara $host u pregledniku.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Oprez: ova adresa oponaša $site slovima sličnog izgleda.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Oprez: ova adresa oponaša drugo web-mjesto slovima sličnog izgleda.';

  @override
  String calendarJoinOpen(String host) {
    return 'Otvori $host';
  }

  @override
  String get calendarNoOrganizer => 'Ova pozivnica nema organizatora kojem bi se odgovorilo.';

  @override
  String get calendarNoAccount => 'Nema računa s kojeg bi se odgovorilo.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Prihvaćeno',
      'tentative': 'Možda',
      'other': 'Odbijeno',
    });
    return '$_temp0 · slanje odgovora osobi $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Prihvaćeno',
      'tentative': 'Možda',
      'other': 'Odbijeno',
    });
    return '$_temp0 · odgovor poslan';
  }

  @override
  String get calendarReplyAlreadySent => 'Odgovor je već poslan.';

  @override
  String get calendarReplyNotSent => 'Odgovor nije poslan.';

  @override
  String get dataSmimeNeedsDevice =>
      'Vaš je S/MIME certifikat na ovom uređaju: otvorite Loupe da biste potpisali i poslali ovu poruku.';

  @override
  String dataSigningFailed(String error) {
    return 'Potpisivanje nije uspjelo: $error';
  }

  @override
  String get keyboardShortcuts => 'Tipkovnički prečaci';

  @override
  String get keyboardGroupGeneral => 'Općenito';

  @override
  String get keyboardGroupMessages => 'Poruke';

  @override
  String get keyboardGroupCompose => 'Pisanje';

  @override
  String get keyboardCommandPalette => 'Paleta naredbi';

  @override
  String get keyboardBackClose => 'Natrag, zatvori';

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
  String get keyboardCloseDraft => 'Zatvori (spremi ili izbriši skicu)';

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
  String get mailingListsUnmuted => 'Nit više nije utišana.';

  @override
  String get mailingListsMuteThread => 'Utišaj nit';

  @override
  String get mailingListsUnmuteThread => 'Ukini utišavanje niti';

  @override
  String get mailingListsPin => 'Prikvači na Sandučiće';

  @override
  String get mailingListsUnpin => 'Otkvači sa Sandučića';

  @override
  String get mailingListsDefaultView => 'Otvori u zadanom prikazu';

  @override
  String get mailingListsPlainText => 'Otvori kao čisti tekst (fiksna širina)';

  @override
  String get mailingListsShowMuted => 'Prikaži utišane niti';

  @override
  String get mailingListsHideMuted => 'Sakrij utišane niti';

  @override
  String get mailingListsTreatAsNewsletter => 'Smatraj biltenom';

  @override
  String get mailingListsOptions => 'Mogućnosti liste';

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
  String get mailingListsNewMessage => 'Nova poruka na listu';

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
  String get mailingListsTechnicalEmpty => 'Dopisne liste pojavit će se ovdje kad stigne njihova pošta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Poruke s ovih lista otvaraju se kao čisti tekst u fontu fiksne širine, a zakrpe se prikazuju kao diff. Gumb Aa i dalje mijenja prikaz bilo koje poruke.';

  @override
  String get paletteMoveToMailbox => 'Premjesti u sandučić…';

  @override
  String get paletteMarkAllRead => 'Označi sve kao pročitano';

  @override
  String get paletteExportFolder => 'Izvezi mapu…';

  @override
  String get paletteGetNewMail => 'Dohvati novu poštu';

  @override
  String get paletteSnoozed => 'Odgođeno';

  @override
  String get paletteSubscriptions => 'Pretplate';

  @override
  String get paletteDiscussions => 'Rasprave';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Dopisna lista';

  @override
  String get paletteTag => 'Oznaka';

  @override
  String get paletteSwipeActions => 'Radnje potezom prsta';

  @override
  String get paletteNotifications => 'Obavijesti';

  @override
  String get paletteRules => 'Pravila';

  @override
  String get paletteEncryption => 'End-to-end šifriranje';

  @override
  String get paletteAdvanced => 'Napredno';

  @override
  String get paletteAddAccount => 'Dodaj račun';

  @override
  String get paletteAccount => 'Račun';

  @override
  String get paletteFolders => 'Mape';

  @override
  String get paletteRecentSearch => 'Nedavna pretraga';

  @override
  String paletteSearchMail(String query) {
    return 'Pretraži poštu za „$query“';
  }

  @override
  String get palettePlaceholder => 'Pretraži radnje, sandučiće, postavke';

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
    return '„$name“ spremljeno u Sandučiće';
  }

  @override
  String get searchMakeRule => 'Pretvori u pravilo';

  @override
  String get searchSaveSmartMailbox => 'Spremi kao Smart Mailbox';

  @override
  String get searchNegate => 'Negiraj';

  @override
  String get searchDontNegate => 'Ne negiraj';

  @override
  String get searchAllMailboxes => 'Svi sandučići';

  @override
  String get searchRecent => 'Nedavne pretrage';

  @override
  String get searchClear => 'Očisti';

  @override
  String get searchSuggestions => 'Prijedlozi';

  @override
  String get searchUnreadMessages => 'Nepročitane poruke';

  @override
  String get searchFlaggedMessages => 'Poruke označene zastavicom';

  @override
  String get searchWithAttachments => 'Poruke s privicima';

  @override
  String get searchUnrepliedMessages => 'Poruke bez odgovora';

  @override
  String get searchTags => 'Oznake';

  @override
  String get searchPeople => 'Osobe';

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
  String get searchMenu => 'Izbornik pretraživanja';

  @override
  String searchSearchingAccount(String account) {
    return 'Pretraživanje računa $account na poslužitelju…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Pretraživanje računa na poslužitelju…';

  @override
  String searchAccountFailed(String account) {
    return 'Pretraživanje računa $account na poslužitelju nije uspjelo';
  }

  @override
  String get searchUnknownAccountFailed => 'Pretraživanje računa na poslužitelju nije uspjelo';

  @override
  String searchChip(String term) {
    return '$term. Dvaput dodirnite za uređivanje.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ne $term. Dvaput dodirnite za uređivanje.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerov sandučić: svaka je poruka ovdje pročitana i nepročitana dok je ne otvorite.';

  @override
  String searchContradiction(String term) {
    return 'Nijedna poruka ne može istodobno biti „$term“ i ne biti.';
  }

  @override
  String get searchSyncDeviceOnly => 'Samo na ovom uređaju';

  @override
  String searchSyncUnsupported(String account) {
    return 'Samo na ovom uređaju: $account ga ne može čuvati';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nije sinkronizirano: $account ima noviji format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Čeka sinkronizaciju s računom $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinkronizirano s računom $account';
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
  String get searchSmartMailboxDeleted => 'Ovaj je Smart Mailbox izbrisan.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes ostaju na ovom uređaju.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes čuvaju se na vašem poslužitelju e-pošte, pa ih imaju i vaši drugi uređaji, kao i Thunderbird s dodatkom Expression Search Reloaded. Oni koji pretražuju sve račune čuvaju se na računu $account; oni za jednu mapu na računu te mape.';
  }

  @override
  String get searchSyncVia => 'Sinkroniziraj putem';

  @override
  String get searchSyncViaFooter => 'Na svakom uređaju odaberite isti račun.';

  @override
  String get searchGmailCantKeep => 'Gmail ne može čuvati Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Čuvaj Smart Mailboxes samo na ovom uređaju';

  @override
  String get searchOnTheServer => 'Na poslužitelju';

  @override
  String get searchServerFooter =>
      'Metapodaci poslužitelja (IMAP METADATA) ne prikazuju se ni u jednoj aplikaciji za e-poštu. Poslužitelji bez njih dobivaju mapu „Loupe Settings“ s jednom porukom; Loupe je skriva iz Sandučića.';

  @override
  String get searchSyncNow => 'Sinkroniziraj sada';

  @override
  String get searchStateUnsupported => 'Nije podržano';

  @override
  String get searchStateNewerFormat => 'Noviji format';

  @override
  String get searchStateFailed => 'Sinkronizacija nije uspjela';

  @override
  String get searchStateSyncing => 'Sinkronizacija…';

  @override
  String get searchStateWaiting => 'Na čekanju';

  @override
  String get searchStateMetadata => 'Metapodaci poslužitelja';

  @override
  String get searchStateFolder => 'Mapa Loupe Settings';

  @override
  String get searchStateNothing => 'Ništa nije spremljeno';

  @override
  String get sharedBack => 'Natrag';

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
  String get sharedSyncOffline => 'Izvan mreže';

  @override
  String get sharedSyncJustNow => 'Ažurirano upravo sada';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ažurirano prije $minutes minuta',
      few: 'Ažurirano prije $minutes minute',
      one: 'Ažurirano prije $minutes minutu',
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
  String get sharedMailboxAllInboxes => 'Sva pristigla pošta';

  @override
  String get sharedMailboxUnread => 'Nepročitano';

  @override
  String get sharedMailboxFlagged => 'Označeno zastavicom';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Sve skice';

  @override
  String get sharedMailboxAllSent => 'Sve poslano';

  @override
  String get sharedMailboxUntitled => 'Sandučić';

  @override
  String get sharedTagImportant => 'Važno';

  @override
  String get sharedTagWork => 'Posao';

  @override
  String get sharedTagPersonal => 'Osobno';

  @override
  String get sharedTagToDo => 'Za obaviti';

  @override
  String get sharedTagLater => 'Kasnije';

  @override
  String get sharedTags => 'Oznake';

  @override
  String get sharedMoveTo => 'Premjesti u…';

  @override
  String get sharedNoRecipients => 'Nema primatelja';

  @override
  String get sharedUnknownSender => 'Nepoznat pošiljatelj';

  @override
  String get sharedOnServer => 'Na poslužitelju';

  @override
  String get sharedAttachment => 'Privitak';

  @override
  String get sharedSnoozedBadge => 'Odgođeno';

  @override
  String get sharedRowUnread => 'Nepročitano';

  @override
  String get sharedRowBackFromSnooze => 'Vraćeno iz odgode';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Označeno zastavicom';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhivirano je $count poruka',
      few: 'Arhivirane su $count poruke',
      one: 'Arhivirana je $count poruka',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Izbrisano je $count poruka',
      few: 'Izbrisane su $count poruke',
      one: 'Izbrisana je $count poruka',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka premješteno je u pristiglu poštu',
      few: '$count poruke premještene su u pristiglu poštu',
      one: '$count poruka premještena je u pristiglu poštu',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka premješteno je u smeće',
      few: '$count poruke premještene su u smeće',
      one: '$count poruka premještena je u smeće',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka premješteno je u neželjenu poštu',
      few: '$count poruke premještene su u neželjenu poštu',
      one: '$count poruka premještena je u neželjenu poštu',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka premješteno je u mapu $mailbox',
      few: '$count poruke premještene su u mapu $mailbox',
      one: '$count poruka premještena je u mapu $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka premješteno je u sandučić',
      few: '$count poruke premještene su u sandučić',
      one: '$count poruka premještena je u sandučić',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poruka odgođeno je do $time',
      few: '$count poruke odgođene su do $time',
      one: '$count poruka odgođena je do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odgođeno do $time samo na ovom uređaju: poslužitelj ne može spremiti vremena odgode.';
  }

  @override
  String get sharedMoveOneAccount => 'Odaberite poruke s jednog računa da biste ih premjestili.';

  @override
  String get sharedSnoozeTitle => 'Odgodi';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Promijeni vrijeme odgode';

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
  String get sharedSwipeInbox => 'Pristigla pošta';

  @override
  String get sharedSwipeDelete => 'Izbriši';

  @override
  String get sharedTrash => 'U smeće';

  @override
  String get sharedSwipeSnooze => 'Odgodi';

  @override
  String get sharedWakeNow => 'Vrati sada';

  @override
  String get sharedChangeSnoozeTime => 'Promijeni vrijeme odgode…';

  @override
  String get sharedSnooze => 'Odgodi…';

  @override
  String get sharedTag => 'Oznake…';

  @override
  String get sharedMoveMessage => 'Premjesti poruku…';

  @override
  String get sharedNotJunk => 'Nije neželjena pošta';

  @override
  String get accountSetupTitle => 'Dodaj račun';

  @override
  String get accountSetupTitleDone => 'Račun je dodan';

  @override
  String get accountSetupAddressTitle => 'Dodajte račun e-pošte';

  @override
  String get accountSetupAddressText => 'Loupe pronalazi postavke za većinu pružatelja.';

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
  String get accountSetupInvalidEmail => 'Unesite valjanu adresu e-pošte.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Postavke za $domain nisu pronađene. Unesite ih u nastavku.';
  }

  @override
  String get accountSetupCheckServers => 'Provjerite nazive poslužitelja i priključke.';

  @override
  String get accountSetupEnterPassword => 'Unesite lozinku.';

  @override
  String get accountSetupConnecting => 'Povezivanje…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Čekanje na $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Stranicu nije bilo moguće otvoriti.';

  @override
  String get accountSetupCouldNotSaveName => 'Ime nije bilo moguće spremiti.';

  @override
  String get accountSetupTrustCertificate => 'Vjeruj ovom certifikatu';

  @override
  String get accountSetupPasswordRequired => 'Obavezno';

  @override
  String get accountSetupShowPassword => 'Prikaži lozinku';

  @override
  String get accountSetupHidePassword => 'Sakrij lozinku';

  @override
  String get accountSetupAppPassword => 'Lozinka aplikacije';

  @override
  String get accountSetupApiToken => 'API token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Dolazni poslužitelj · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Odlazni poslužitelj · SMTP';

  @override
  String get accountSetupSignIn => 'Prijavi se';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Prijavi se putem računa $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Koristi lozinku aplikacije';

  @override
  String get accountSetupUseAppPasswordInstead => 'Umjesto toga koristi lozinku aplikacije';

  @override
  String get accountSetupUseDifferentAddress => 'Koristi drugu adresu';

  @override
  String get accountSetupHowToCreateAppPassword => 'Kako izraditi lozinku aplikacije';

  @override
  String get accountSetupHowToCreateOne => 'Upute za izradu';

  @override
  String get accountSetupGoogleNote =>
      'Prijavljujete se na Googleovoj stranici i Loupe nikad ne vidi vašu lozinku. Dopustite aplikaciji Loupe da čita, šalje i organizira vašu poštu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Prijavi se putem računa Google“ još nije dostupno u ovoj verziji. Umjesto toga možete se povezati lozinkom aplikacije (potrebna je potvrda u dva koraka na vašem Google računu).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Izradite lozinku aplikacije na svom Google računu i zalijepite je u nastavku.';

  @override
  String get accountSetupMicrosoftNote =>
      'Prijavljujete se na Microsoftovoj stranici i Loupe nikad ne vidi vašu lozinku. To radi za Outlook.com i Hotmail te za poslovne ili školske račune na Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Prijava putem Microsofta stiže u kasnijoj verziji. Računi Outlook, Hotmail i Microsoft 365 trebaju je: više ne prihvaćaju lozinke iz aplikacija za e-poštu.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail zahtijeva lozinku specifičnu za aplikaciju, a ne lozinku vašeg Apple računa.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail zahtijeva lozinku aplikacije, a ne lozinku računa.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se s Fastmailom povezuje putem JMAP-a uz API token: Settings › Privacy & Security › Manage API tokens, za JMAP, s pristupom e-pošti i slanju.';

  @override
  String get accountSetupFastmailNote => 'Fastmail za aplikacije za e-poštu zahtijeva lozinku aplikacije.';

  @override
  String get accountSetupServerSettings => 'Postavke poslužitelja';

  @override
  String get accountSetupSettingsNotFound => 'Nisu pronađene automatski';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Pronađeno putem $source';
  }

  @override
  String get accountSetupEditSettings => 'Uredi postavke';

  @override
  String get accountSetupSyncing => 'Vaša se pošta sinkronizira.';

  @override
  String get accountSetupDescription => 'Opis';

  @override
  String get accountSetupDescriptionHint => 'Posao, Osobno…';

  @override
  String get accountSetupColour => 'Boja';

  @override
  String accountSetupColourNumber(int number) {
    return 'Boja $number';
  }

  @override
  String get accountSetupSaving => 'Spremanje…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nije mogao otvoriti svoju bazu podataka pošte na ovom telefonu. Zatvorite Loupe, ponovno ga otvorite i pokušajte opet.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Nešto nije u redu ($error). Pokušajte ponovno.';
  }

  @override
  String get accountSetupSecurityNone => 'Ništa';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Priključak';

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
      'Vaša bi lozinka i svaka poruka putovale kao običan tekst. Bilo tko na mreži, primjerice na javnom Wi-Fiju, mogao bi ih pročitati. Koristite ovo samo za poslužitelj na vlastitoj mreži.';

  @override
  String get accountSetupUseWithoutEncryption => 'Koristi bez šifriranja';

  @override
  String get accountSetupApiTokenRejected =>
      'API token je odbijen. Izradite Fastmail API token za JMAP s pristupom e-pošti i zalijepite ga.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Lozinka je odbijena. Koristite lozinku aplikacije, a ne lozinku računa.';

  @override
  String get accountSetupPasswordRejected => 'Lozinka je odbijena. Provjerite je i pokušajte ponovno.';

  @override
  String get accountSetupServerUnreachable => 'Poslužitelj nije dostupan. Provjerite postavke poslužitelja i vezu.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certifikat poslužitelja nije pouzdan. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Prijava je otkazana. Dodirnite „Prijavi se putem računa $provider“ da biste pokušali ponovno.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe treba dopuštenje za čitanje i slanje vaše Gmail pošte. Ponovno se prijavite i dopustite pristup, s označenim okvirom za Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe treba dopuštenje za čitanje i slanje vaše pošte. Ponovno se prijavite i prihvatite dopuštenja.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Vaša organizacija mora odobriti Loupe prije nego što ga možete koristiti s ovim računom. Zamolite IT administratora da u Microsoft Entra ID-u odobri administratorski pristanak za Loupe, a zatim pokušajte ponovno.';

  @override
  String get accountSetupOAuthBlocked =>
      'Pravila prijave vaše organizacije ne dopuštaju Loupe na ovom uređaju. Obratite se IT administratoru.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider nije dostupan. Provjerite internetsku vezu i pokušajte ponovno.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Prijava putem računa $provider nije ispravno postavljena u ovoj verziji aplikacije Loupe. Molimo prijavite to.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Prijava putem računa $provider nije uspjela. Pokušajte ponovno.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider vas je prijavio, ali Gmail je odbio pristup za ovu adresu. Pri prijavi odaberite isti račun. Na poslovnim ili školskim računima administrator je možda isključio IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider vas je prijavio, ali poslužitelj e-pošte odbio je pristup za ovu adresu. Pri prijavi odaberite isti račun. Na poslovnim ili školskim računima administrator je možda isključio IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Poslužitelj e-pošte nije dostupan. Provjerite vezu i pokušajte ponovno.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Prijava putem računa $provider nije dostupna u ovoj verziji.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Ponovno ste prijavljeni. $account se sinkronizira.';
  }

  @override
  String get accountSetupSignInAgain => 'Ponovno se prijavi';

  @override
  String get accountSetupSigningIn => 'Prijava…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider više ne prihvaća prijavu aplikacije Loupe za $email pa se $account ne sinkronizira. Ponovno se prijavite da biste primali njegovu poštu.';
  }

  @override
  String get accountImportTitle => 'Uvezi iz Thunderbirda';

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
      'Na računalu otvorite Thunderbird i odaberite Alati › Izvoz za mobilne uređaje. Odaberite svoje račune, a zatim skenirajte svaki kod koji se prikaže. Kodovi se mogu skenirati bilo kojim redoslijedom.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nastavi: $count računa',
      few: 'Nastavi: $count računa',
      one: 'Nastavi: $count račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Umjesto toga zalijepi tekst';

  @override
  String get accountImportStartOver => 'Počni ispočetka';

  @override
  String get accountImportDuplicateCode => 'Taj je kod već dodan.';

  @override
  String get accountImportRestarted => 'Ovaj kod potječe iz novog izvoza pa su prethodno skenirani kodovi zanemareni.';

  @override
  String get accountImportNotThunderbird => 'Ovo nije kod Thunderbird računa.';

  @override
  String get accountImportNewerVersion =>
      'Ovaj kod potječe iz novijeg Thunderbirda. Ažurirajte Loupe da biste ga uvezli.';

  @override
  String get accountImportDamaged => 'Ovaj Thunderbird kod nije bilo moguće pročitati.';

  @override
  String get accountImportTooLarge => 'Ovaj je kod prevelik da bi bio Thunderbirdov izvoz.';

  @override
  String get accountImportCouldNotOpenSettings => 'Postavke nije bilo moguće otvoriti.';

  @override
  String get accountImportCameraOffTitle => 'Pristup kameri je isključen';

  @override
  String get accountImportCameraOffText =>
      'U Postavkama dopustite aplikaciji Loupe korištenje kamere za skeniranje koda ili umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportNoCameraTitle => 'Nema kamere';

  @override
  String get accountImportNoCameraText => 'Loupe ovdje ne može koristiti kameru. Umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera se nije pokrenula';

  @override
  String get accountImportCameraFailedText => 'Pokušajte ponovno ili umjesto toga zalijepite tekst koda.';

  @override
  String get accountImportOpenSettings => 'Otvori Postavke';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pronađeno je $count računa',
      few: 'Pronađena su $count računa',
      one: 'Pronađen je $count račun',
      zero: 'Nije pronađen nijedan račun',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nijedan račun u ovim kodovima nije bilo moguće pročitati.';

  @override
  String get accountImportChoose => 'Odaberite račune koje želite dodati u Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kodova nije skenirano ($codes od $total), pa njihovi računi nisu navedeni.',
      few: '$count koda nisu skenirana ($codes od $total), pa njihovi računi nisu navedeni.',
      one: '$count kod nije skeniran ($codes od $total), pa njegovi računi nisu navedeni.',
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
      other: '$count računa u kodovima nije bilo moguće pročitati. Možda koriste postavke iz novijeg Thunderbirda.',
      few: '$count računa u kodovima nije bilo moguće pročitati. Možda koriste postavke iz novijeg Thunderbirda.',
      one: '$count račun u kodovima nije bilo moguće pročitati. Možda koristi postavke iz novijeg Thunderbirda.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skeniraj ponovno';

  @override
  String get accountImportAlreadyAdded => 'Račun s ovom adresom već je u aplikaciji Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Kad se doda, prijavit ćete se putem računa $provider, kao u Thunderbirdu.';
  }

  @override
  String get accountImportGmailAppPassword => 'Dodajte račun s lozinkom aplikacije (potrebna je potvrda u dva koraka).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se u Gmail prijavljuje putem Googlea. „Prijavi se putem računa Google“ stiže u kasnijoj verziji; do tada dodajte račun s lozinkom aplikacije (potrebna je potvrda u dva koraka).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se na ovaj račun prijavljuje u pregledniku. Loupe to još ne može: koristite lozinku aplikacije ako je vaš pružatelj nudi.';

  @override
  String get accountImportUnencrypted => 'Povezuje se bez šifriranja. Koristite ovo samo na vlastitoj mreži.';

  @override
  String get accountImportEnterAgain => 'Unesite je ponovno';

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
  String get accountImportPasteTitle => 'Zalijepi tekst izvoza';

  @override
  String get accountImportPasteText => 'Zalijepite tekst Thunderbirdova koda za izvoz, jedan kod po retku.';

  @override
  String get accountImportPop3 => 'POP3 računi nisu podržani. Loupe drži poštu na poslužitelju putem IMAP-a.';

  @override
  String get accountImportKerberos => 'Ovaj se račun prijavljuje putem Kerberosa, koji Loupe ne podržava.';

  @override
  String get accountImportNtlm => 'Ovaj se račun prijavljuje putem NTLM-a, koji Loupe ne podržava.';

  @override
  String get accountImportClientCertificate =>
      'Ovaj se račun prijavljuje klijentskim certifikatom, koji Loupe još ne podržava.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Prijava putem Microsofta stiže u kasnijoj verziji. Računi Outlook i Microsoft 365 više ne prihvaćaju lozinke iz aplikacija za e-poštu.';

  @override
  String get accountImportEnterPassword => 'Unesite lozinku.';

  @override
  String get accountImportEnterAppPassword => 'Unesite lozinku aplikacije.';

  @override
  String get accountImportEnterApiToken => 'Unesite API token.';

  @override
  String get accountImportStorageFailed => 'Loupe nije mogao otvoriti pohranu računa. Pokušajte ponovno kasnije.';

  @override
  String get accountImportFailed => 'Račun nije bilo moguće dodati. Pokušajte ponovno ili ga dodajte ručno.';

  @override
  String get composeNewMessageTitle => 'Nova poruka';

  @override
  String get composeAttach => 'Priloži';

  @override
  String get composeSendLater => 'Pošalji kasnije';

  @override
  String composeSendAt(String time) {
    return 'Pošalji $time';
  }

  @override
  String get composeSendHint => 'Dugo pritisnite za kasnije slanje';

  @override
  String get composeNoAccount => 'Dodajte račun da biste slali poštu.';

  @override
  String get composeTo => 'Prima:';

  @override
  String get composeCc => 'Kopija:';

  @override
  String get composeBcc => 'Skrivena kopija:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopija/skrivena kopija, od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Predmet:';

  @override
  String composeReplyTo(String address) {
    return 'Odgovor na: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odgovori s adrese $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Pošalji s adrese $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odgovoriti s adrese $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Poslati s adrese $email?';
  }

  @override
  String get composeDismiss => 'Odbaci';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nije spremljeno kao identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Spremi kao identitet';

  @override
  String composeAliasSaved(String email) {
    return 'Adresa $email spremljena je kao identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Nevaljana adresa $address';
  }

  @override
  String get composeOriginalNotFound => 'Izvornu poruku nije bilo moguće pronaći.';

  @override
  String get composeDraftNotFound => 'Skicu nije bilo moguće pronaći.';

  @override
  String get composeAttachmentsLost => 'Privitke nije bilo moguće vratiti. Dodajte ih ponovno.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Neke privitke nije bilo moguće dodati: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Privici ukupno imaju $size; neki poslužitelji odbijaju ovako velike poruke.';
  }

  @override
  String get composeAttachFailed => 'Datoteku nije bilo moguće priložiti.';

  @override
  String get composeInvalidAddressTitle => 'Nevaljana adresa';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ nije valjana adresa e-pošte.';
  }

  @override
  String get composeNoSubjectTitle => 'Bez predmeta';

  @override
  String get composeNoSubjectText => 'Ova poruka nema predmet. Ipak je poslati?';

  @override
  String get composeSentBeforeChanges => 'Poslana je prije vaših promjena, koje su spremljene u Skice.';

  @override
  String composeScheduled(String time) {
    return 'Zakazano za $time';
  }

  @override
  String get composeSending => 'Slanje…';

  @override
  String get composeSent => 'Poslano';

  @override
  String get composeSendFailed => 'Slanje nije uspjelo. Pokušajte ponovno.';

  @override
  String get composeAlreadySent => 'Već poslano.';

  @override
  String get composeDiscardChanges => 'Odbaci promjene';

  @override
  String get composeSaveChanges => 'Spremi promjene';

  @override
  String get composeDeleteDraft => 'Izbriši skicu';

  @override
  String get composeSaveDraft => 'Spremi skicu';

  @override
  String get composeDraftSaved => 'Skica je spremljena';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Dana $date u $time $name napisao/la je:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Dana $date u $time netko je napisao:';
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
    return 'Prima: $addresses';
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
  String get composeSendWithoutDelay => 'Pošalji bez odgode';

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
  String get composeRecoveryTitle => 'Nastaviti uređivati skicu?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Poruka nije poslana kad se Loupe zatvorio.',
      'one': 'Poruka za $name nije poslana kad se Loupe zatvorio.',
      'other': 'Poruka za $name i ostale nije poslana kad se Loupe zatvorio.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Poruka „$subject“ nije poslana kad se Loupe zatvorio.',
      'one': 'Poruka „$subject“ za $name nije poslana kad se Loupe zatvorio.',
      'other': 'Poruka „$subject“ za $name i ostale nije poslana kad se Loupe zatvorio.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Nastavi uređivati';

  @override
  String get composeRecoverySave => 'Spremi u skice';

  @override
  String get composeRecoveryDiscard => 'Odbaci';

  @override
  String get composeRecoverySaved => 'Spremljeno u skice';

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
  String get outboxNoRecipients => 'Nema primatelja';

  @override
  String get outboxNoSubject => '(Bez predmeta)';

  @override
  String get outboxSendingFailed => 'Slanje nije uspjelo.';

  @override
  String get outboxEmptyTitle => 'Ništa za slanje';

  @override
  String get outboxEmptyText => 'Poruke koje šaljete kasnije čekaju ovdje dok ne dođe vrijeme.';

  @override
  String get outboxSendNow => 'Pošalji sada';

  @override
  String get outboxReschedule => 'Ponovno zakaži';

  @override
  String get outboxRescheduleMenu => 'Ponovno zakaži…';

  @override
  String get outboxRescheduleTitle => 'Ponovno zakaži';

  @override
  String outboxRescheduled(String time) {
    return 'Ponovno zakazano za $time';
  }

  @override
  String get outboxCancel => 'Otkaži';

  @override
  String get outboxCancelSending => 'Otkaži slanje…';

  @override
  String get outboxCancelTitle => 'Otkazati slanje?';

  @override
  String get outboxMoveToDrafts => 'Premjesti u skice';

  @override
  String get outboxDiscard => 'Odbaci poruku';

  @override
  String get outboxMovedToDrafts => 'Premješteno u skice';

  @override
  String get outboxDiscarded => 'Poruka je odbačena';

  @override
  String get outboxAlreadySent => 'Već poslano.';

  @override
  String get outboxBeingSent => 'Ova se poruka upravo šalje.';

  @override
  String get outboxActionFailed => 'To nije uspjelo. Poruka je i dalje u izlaznom spremniku.';

  @override
  String get notificationsBadgeInboxes => 'Nepročitano u pristigloj pošti';

  @override
  String get notificationsBadgeVip => 'Nepročitano od VIP kontakata';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nova pošta vaših VIP kontakata, na bilo kojem računu';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nova pošta na $email';
  }

  @override
  String get notificationsUnknownSender => 'Nepoznat pošiljatelj';

  @override
  String get notificationsNoSubject => '(Bez predmeta)';

  @override
  String get notificationsEncryptedMessage => 'Šifrirana poruka';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nova poruka s računa $account';
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
    return 'Nove poruke na računu $account';
  }

  @override
  String get platformInstantChannel => 'Trenutačna dostava';

  @override
  String get platformInstantChannelDescription => 'Prikazuje se dok Loupe prati novu poštu u pristigloj pošti';

  @override
  String get platformInstantTitle => 'Praćenje nove pošte';

  @override
  String get platformInstantText => 'Trenutačna dostava je uključena';

  @override
  String get platformErrorBox => 'Nešto nije u redu pri prikazu. Vratite se i pokušajte ponovno.';

  @override
  String get welcomeTagline => 'Pošta jednostavna izvana\ni moćna iznutra.';

  @override
  String get welcomeAccountsTitle => 'Svi računi, jedan smiren sandučić';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail i bilo koji IMAP ili JMAP poslužitelj.';

  @override
  String get welcomeSearchTitle => 'Pretraživanje koje pronalazi';

  @override
  String get welcomeSearchText => 'Trenutačni rezultati na telefonu, zatim s poslužitelja.';

  @override
  String get welcomePrivacyTitle => 'Privatnost po dizajnu';

  @override
  String get welcomePrivacyText => 'Bez praćenja. Udaljene slike ostaju blokirane dok ne odlučite drukčije.';

  @override
  String get welcomeAddAccount => 'Dodaj račun';

  @override
  String get welcomeImport => 'Uvezi iz Thunderbirda';

  @override
  String get welcomeTryDemo => 'Isprobaj s demo poštom';
}
