// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get commonAdd => 'Adaugă';

  @override
  String get commonCancel => 'Anulează';

  @override
  String get commonClose => 'Închide';

  @override
  String get commonDelete => 'Șterge';

  @override
  String get commonDone => 'Gata';

  @override
  String get commonEdit => 'Editează';

  @override
  String get commonMore => 'Mai multe';

  @override
  String get commonMove => 'Mută';

  @override
  String get commonName => 'Nume';

  @override
  String get commonNone => 'Niciunul';

  @override
  String get commonOff => 'Dezactivat';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Activat';

  @override
  String get commonOptional => 'Opțional';

  @override
  String get commonPassword => 'Parolă';

  @override
  String get commonRemove => 'Elimină';

  @override
  String get commonRetry => 'Reîncearcă';

  @override
  String get commonSave => 'Salvează';

  @override
  String get commonSearch => 'Caută';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Setări';

  @override
  String get commonShare => 'Distribuie';

  @override
  String get commonTryAgain => 'Încearcă din nou';

  @override
  String get commonUndo => 'Anulează';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje',
      few: '$count mesaje',
      one: '$count mesaj',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arhivează';

  @override
  String get mailDelete => 'Șterge';

  @override
  String get mailFlag => 'Marchează cu steguleț';

  @override
  String get mailForward => 'Redirecționează';

  @override
  String get mailMarkAsRead => 'Marchează ca citit';

  @override
  String get mailMarkAsUnread => 'Marchează ca necitit';

  @override
  String get mailMoveToJunk => 'Mută în Spam';

  @override
  String get mailNewMessage => 'Mesaj nou';

  @override
  String get mailNoSubject => 'Fără subiect';

  @override
  String get mailReply => 'Răspunde';

  @override
  String get mailReplyAll => 'Răspunde tuturor';

  @override
  String get mailSend => 'Trimite';

  @override
  String get mailUnflag => 'Elimină stegulețul';

  @override
  String get mailboxArchive => 'Arhivă';

  @override
  String get mailboxDrafts => 'Ciorne';

  @override
  String get mailboxInbox => 'Inbox';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Căsuță de ieșire';

  @override
  String get mailboxSent => 'Trimise';

  @override
  String get mailboxTrash => 'Coș de gunoi';

  @override
  String get conversationSomethingWentWrong => 'Ceva nu a mers bine. Încearcă din nou.';

  @override
  String get conversationReplyToList => 'Răspunde listei';

  @override
  String get conversationReplyList => 'Răspunde listei';

  @override
  String get conversationThreadMuted => 'Fir ignorat. Mesajele noi din el sosesc deja citite.';

  @override
  String get conversationThreadUnmuted => 'Firul nu mai este ignorat.';

  @override
  String get conversationLinkFailed => 'Linkul nu a putut fi deschis.';

  @override
  String get conversationGoneTitle => 'Niciun mesaj';

  @override
  String get conversationGoneText => 'Acest mesaj a fost mutat sau șters.';

  @override
  String get conversationMuted => 'Ignorat';

  @override
  String get conversationReaderOptions => 'Opțiuni de citire';

  @override
  String get conversationReaderOptionsHint => 'Dimensiunea textului și vizualizarea';

  @override
  String get conversationTrash => 'Coș de gunoi';

  @override
  String get conversationReplyHint => 'Apasă lung pentru Răspunde tuturor și Redirecționează';

  @override
  String get conversationOfflineTitle => 'Ești offline';

  @override
  String get conversationOfflineText =>
      'Această conversație nu a fost descărcată încă. Se va încărca atunci când revii online.';

  @override
  String get conversationErrorTitle => 'Mesajul nu poate fi afișat';

  @override
  String get conversationErrorText => 'Ceva nu a mers bine.';

  @override
  String get conversationOfflineBanner => 'Ești offline';

  @override
  String get conversationNotUpdated => 'Neactualizat';

  @override
  String get conversationMe => 'mine';

  @override
  String get conversationNoSender => '(fără expeditor)';

  @override
  String get conversationNoRecipients => 'fără destinatari';

  @override
  String conversationRecipients(String names) {
    return 'către $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'către $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'De la';

  @override
  String get conversationHeaderTo => 'Către';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Răspuns către';

  @override
  String get conversationHeaderDate => 'Dată';

  @override
  String get conversationHeaderSecurity => 'Securitate';

  @override
  String get conversationVerifiedSender => 'Expeditor verificat';

  @override
  String get conversationUnverifiedSender => 'Expeditor neverificat';

  @override
  String get conversationLoadingMessage => 'Se încarcă mesajul';

  @override
  String get conversationBodyError => 'Acest mesaj nu a putut fi încărcat.';

  @override
  String get conversationBodyOffline => 'Ești offline. Mesajul se va încărca atunci când revii online.';

  @override
  String get conversationOriginalHint => 'Arată mai bine în vizualizarea Original';

  @override
  String get conversationShowOriginal => 'Afișează originalul';

  @override
  String get conversationScrollToTop => 'Derulează la început';

  @override
  String get conversationTagsMenu => 'Etichete…';

  @override
  String get conversationMuteThread => 'Ignoră firul';

  @override
  String get conversationUnmuteThread => 'Nu mai ignora firul';

  @override
  String get conversationMoveMenu => 'Mută…';

  @override
  String get conversationDeletePermanently => 'Șterge definitiv';

  @override
  String get conversationMoveToTrash => 'Mută în Coșul de gunoi';

  @override
  String get conversationNotJunk => 'Nu este spam';

  @override
  String get conversationShowAllHeaders => 'Afișează toate anteturile';

  @override
  String get conversationViewSource => 'Vezi sursa';

  @override
  String get conversationSaveAsFile => 'Salvează ca fișier…';

  @override
  String get conversationShareAsFile => 'Distribuie ca fișier…';

  @override
  String get conversationSearchFromMessageMenu => 'Caută pornind de la acest mesaj…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copiază adresa';

  @override
  String get conversationAddressCopied => 'Adresă copiată';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Caută mesajele de la $name';
  }

  @override
  String get conversationTags => 'Etichete';

  @override
  String get conversationAllHeaders => 'Toate anteturile';

  @override
  String get conversationCopyAll => 'Copiază tot';

  @override
  String get conversationHeadersCopied => 'Anteturi copiate';

  @override
  String get conversationNoHeaders => 'Niciun antet';

  @override
  String get conversationSearchFromMessageTitle => 'Caută pornind de la acest mesaj';

  @override
  String conversationSearchFrom(String name) {
    return 'De la $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Către $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Subiect „$subject”';
  }

  @override
  String get conversationSourceTitle => 'Sursă';

  @override
  String get conversationSourceCopied => 'Sursă copiată';

  @override
  String get conversationShareFailed => 'Mesajul nu a putut fi distribuit.';

  @override
  String get conversationWrapLines => 'Încadrează rândurile';

  @override
  String get conversationDontWrapLines => 'Nu încadra rândurile';

  @override
  String get conversationSourceError => 'Sursa nu a putut fi încărcată.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Se afișează primii $shown din $total. Copiază sau distribuie ca s-o obții integral.';
  }

  @override
  String get conversationAttachmentUntitled => 'Fără titlu';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Mai multe acțiuni pentru $name';
  }

  @override
  String get conversationMoveTo => 'Mută în…';

  @override
  String get conversationMailboxesError => 'Căsuțele poștale nu au putut fi încărcate.';

  @override
  String get conversationReaderReadable => 'Lizibil';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Text';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Păstrează culorile originale';

  @override
  String get conversationReaderRemember => 'Reține pentru acest expeditor';

  @override
  String get conversationSecurityPossiblePhishing => 'Posibil phishing';

  @override
  String get conversationSecurityBeCareful => 'Atenție';

  @override
  String get conversationSecurityVerified => 'Verificat';

  @override
  String get conversationSecurityNoIssues => 'Nicio problemă găsită';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de trackere',
      few: '$count trackere',
      one: '$count tracker',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Arată de ce';

  @override
  String get conversationPhishingBannerTitle => 'Acest mesaj pare a fi phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Linkurile și imaginile sunt dezactivate.';
  }

  @override
  String get conversationPhishingBannerText => 'Linkurile și imaginile sunt dezactivate.';

  @override
  String get conversationPhishingWhy => 'De ce?';

  @override
  String get conversationPhishingShowAnyway => 'Afișează oricum';

  @override
  String get conversationSecurityPhishingTitle => 'Pare a fi phishing';

  @override
  String get conversationSecurityPhishingText => 'Mai multe semne arată că acest mesaj nu este ceea ce pretinde.';

  @override
  String get conversationSecurityCarefulTitle => 'Ai grijă cu acest mesaj';

  @override
  String get conversationSecurityCarefulText => 'Ceva din el merită o a doua privire.';

  @override
  String get conversationSecurityVerifiedText => 'Expeditorul este verificat și nimic nu pare suspect.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nimic nu pare suspect. Serverul tău de e-mail nu a precizat dacă expeditorul este verificat.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nimic nu pare suspect.';

  @override
  String get conversationSecurityWhy => 'De ce';

  @override
  String get conversationSecurityPrivacy => 'Confidențialitate';

  @override
  String get conversationSecurityNoTrackingPixels => 'Niciun pixel de urmărire';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de pixeli de urmărire eliminați',
      few: '$count pixeli de urmărire eliminați',
      one: '$count pixel de urmărire eliminat',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'I-ar fi spus expeditorului când ai deschis acest mesaj.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nicio imagine externă';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de imagini externe',
      few: '$count imagini externe',
      one: '$count imagine externă',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Dacă le încarci, expeditorul află când citești acest mesaj, precum și adresa ta IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Fără urmărirea clicurilor';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de linkuri trec prin trackere de clicuri',
      few: '$count linkuri trec prin trackere de clicuri',
      one: '$count link trece prin trackere de clicuri',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Clicul tău ar fi înregistrat de $services. Apasă lung pe un link ca să-i deschizi direct destinația.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Detalii tehnice';

  @override
  String get conversationSecurityCheckedLocally => 'Verificat pe acest dispozitiv. Nu s-a trimis nimic nicăieri.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackere';

  @override
  String get conversationSecurityImagesFrom => 'Imagini de la';

  @override
  String get conversationSecuritySenderHistory => 'Istoricul expeditorului';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'primite: $received, trimise: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linkurile duc la';

  @override
  String get conversationSecurityHidden => 'Ascunse';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements de elemente',
      few: '$elements elemente',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters de caractere',
      few: '$characters caractere',
      one: '$characters caracter',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Expeditor neverificat';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Serverul tău de e-mail nu a putut confirma că acest mesaj provine cu adevărat de la $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Serverul tău de e-mail nu a putut confirma că acest mesaj provine cu adevărat de la expeditorul său.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Serverul tău de e-mail nu a putut confirma că acest mesaj provine de la $domain. Este ceva obișnuit la listele de e-mail.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Serverul tău de e-mail nu a putut confirma că acest mesaj provine de la expeditorul său. Este ceva obișnuit la listele de e-mail.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nu da curs mesajului decât dacă îl așteptai. Dacă ai dubii, contactează expeditorul pe altă cale.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Semnat de alt domeniu';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Mesajul este semnat de $signer, nu de $domain. Serviciile de trimitere a e-mailurilor fac asta, dar asta nu dovedește cine l-a scris.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Mesajul este semnat de alt domeniu, nu de $domain. Serviciile de trimitere a e-mailurilor fac asta, dar asta nu dovedește cine l-a scris.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Numele arată o altă adresă';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Numele expeditorului este „$shown”, dar mesajul vine de la $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Ai încredere în adresă, nu în nume.';

  @override
  String get conversationSecurityReplyToTitle => 'Răspunsurile ajung în altă parte';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Dacă răspunzi, răspunsul tău ar ajunge la $address, nu la $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Verifică adresa înainte să răspunzi cu ceva personal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Folosește numele tău';

  @override
  String get conversationSecurityImpersonationTitle => 'Folosește numele cuiva pe care îl cunoști';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Este semnat „$name”, ca numele tău, dar vine de la o adresă nouă: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Este semnat „$name”, ca VIP-ul tău $knownName ($knownEmail), dar vine de la o adresă nouă: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Este semnat „$name”, ca $knownName ($knownEmail), dar vine de la o adresă nouă: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Iar răspunsurile ar ajunge la încă o altă adresă.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Dacă cere bani, coduri sau fișiere, verifică mai întâi cu persoana respectivă pe altă cale.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Adresă cunoscută: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Această adresă: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primul mesaj de la acest expeditor';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Nu ai mai primit e-mailuri de la $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Ai grijă la cererile venite de la persoane pe care încă nu le cunoști.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Litere înșelătoare în adresa expeditorului';

  @override
  String get conversationSecurityLinkHomographTitle => 'Litere înșelătoare într-un link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host amestecă litere din alfabete diferite ca să imite o altă adresă.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host folosește litere asemănătoare: nu este $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Șterge-l sau raportează-l ca spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Nu-l deschide.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domeniu: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domeniu care imită altul';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Folosește un nume cunoscut în domeniu';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain seamănă cu domeniul tău, $real, dar este un domeniu diferit.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain seamănă cu $brand ($real), dar este un domeniu diferit.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain folosește numele domeniului tău, $real, dar nu îi aparține.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain folosește numele $brand ($real), dar nu îi aparține.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Mesajele reale de la organizația ta vin de la $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Mesajele reale de la $brand vin de la $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domeniul expeditorului: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imită: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de linkuri ascund unde duc',
      few: '$count linkuri ascund unde duc',
      one: 'Un link ascunde unde duce',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Un link arată $shown, dar deschide $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Nu te autentifica și nu plăti prin aceste linkuri. Tastează tu adresa.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Destinația unui link nu poate fi verificată';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Un link arată $shown, dar trece prin $host, care înregistrează clicul înainte să-l transmită mai departe.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Un link duce la o simplă adresă IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nu este un site cu nume. Companiile reale folosesc rareori astfel de linkuri.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Un link deghizat';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Un link începe cu „$shown@” ca să pară $shown, dar deschide $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'O pagină ascunsă a fost dezactivată';

  @override
  String get conversationSecurityDataLinkText =>
      'Un link ar fi deschis o pagină împachetată în mesaj, o metodă de a ocoli verificarea linkurilor.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Cere o parolă';

  @override
  String get conversationSecurityPasswordFieldText => 'Mesajul conținea un câmp pentru parolă. Loupe l-a eliminat.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nu introduce niciodată o parolă într-un e-mail.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Un link care rulează cod a fost dezactivat';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nu rulează niciodată cod din mesaje.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Linkuri scurtate',
      few: 'Linkuri scurtate',
      one: 'Un link scurtat',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts ascunde destinația reală până când îl deschizi.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Adresă web internațională';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts folosește litere nelatine. E normal pentru multe limbi; verifică dacă este site-ul la care te aștepți.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mult text ascuns';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Au fost eliminate $count de caractere de text invizibil. Textul ascuns de acest fel are rolul de a păcăli filtrele de spam.',
      few:
          'Au fost eliminate $count caractere de text invizibil. Textul ascuns de acest fel are rolul de a păcăli filtrele de spam.',
      one:
          'A fost eliminat $count caracter de text invizibil. Textul ascuns de acest fel are rolul de a păcăli filtrele de spam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Text ascuns eliminat';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Au fost eliminate $count de caractere de text invizibil.',
      few: 'Au fost eliminate $count caractere de text invizibil.',
      one: 'A fost eliminat $count caracter de text invizibil.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Mesajul nu a putut fi descărcat. Verifică conexiunea și încearcă din nou.';

  @override
  String exportSaved(String name) {
    return '„$name” a fost salvat';
  }

  @override
  String get exportSaveFailed => 'Mesajul nu a putut fi salvat.';

  @override
  String exportFailed(String folder) {
    return '„$folder” nu a putut fi exportat.';
  }

  @override
  String exportEmpty(String folder) {
    return '„$folder” nu conține mesaje de exportat.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '„$folder” nu a putut fi exportat: niciun mesaj nu a putut fi descărcat. Verifică conexiunea și încearcă din nou.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$name” a fost salvat fără $formattedCount de mesaje care nu au putut fi descărcate.',
      few: '„$name” a fost salvat fără $formattedCount mesaje care nu au putut fi descărcate.',
      one: '„$name” a fost salvat fără $count mesaj care nu a putut fi descărcat.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name” nu a putut fi salvat.';
  }

  @override
  String exportTitle(String folder) {
    return 'Se exportă „$folder”';
  }

  @override
  String get exportListing => 'Se caută mesajele…';

  @override
  String exportProgress(String current, String total) {
    return 'Se exportă $current din $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount de mesaje nu au putut fi descărcate',
      few: '$formattedCount mesaje nu au putut fi descărcate',
      one: '$count mesaj nu a putut fi descărcat',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Căsuțe poștale';

  @override
  String get mailboxesShown => 'Afișat';

  @override
  String get mailboxesHidden => 'Ascuns';

  @override
  String get mailboxesCollapse => 'Restrânge';

  @override
  String get mailboxesExpand => 'Extinde';

  @override
  String get mailboxesManageVips => 'Gestionează VIP-urile';

  @override
  String get mailboxesSubscriptions => 'Abonamente';

  @override
  String mailboxesShowAccount(String account) {
    return 'Afișează $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ascunde $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportă dosarul…';

  @override
  String get mailboxesUnpin => 'Anulează fixarea';

  @override
  String get mailboxesLists => 'Liste';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Salvează o căutare ca s-o păstrezi aici.';

  @override
  String get mailboxesTags => 'Etichete';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Poți și să atingi numele unui expeditor într-un mesaj și să activezi VIP.';

  @override
  String get mailboxesAddVip => 'Adaugă VIP…';

  @override
  String get mailboxesAddVipTitle => 'Adaugă VIP';

  @override
  String get mailboxesAddVipText => 'E-mailurile de la această adresă primesc o stea și apar în căsuța poștală VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'nume@example.com';

  @override
  String get messageListFilterUnread => 'Necitite';

  @override
  String get messageListFilterFlagged => 'Cu steguleț';

  @override
  String get messageListFilterToMe => 'Către: mine';

  @override
  String get messageListFilterCcMe => 'Cc: mine';

  @override
  String get messageListFilterWithAttachments => 'Cu atașamente';

  @override
  String get messageListFilterUnreplied => 'Fără răspuns';

  @override
  String get messageListFilterFromVips => 'De la VIP-uri';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje marcate ca citite',
      few: '$count mesaje marcate ca citite',
      one: '$count mesaj marcat ca citit',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'E-mailurile mai vechi nu au putut fi încărcate.';

  @override
  String get messageListSelectMessages => 'Selectează mesaje';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Selectate: $count');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Selectează tot';

  @override
  String get messageListDeselectAll => 'Deselectează tot';

  @override
  String get messageListLoadFailed => 'E-mailurile nu au putut fi încărcate';

  @override
  String get messageListNoUnread => 'Niciun e-mail necitit';

  @override
  String get messageListNoMatches => 'Niciun e-mail potrivit';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrat după: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Dezactivează filtrul';

  @override
  String get messageListEmpty => 'Niciun e-mail';

  @override
  String get messageListFilter => 'Filtrează';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Criterii de filtrare: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrat după:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount necitite',
      one: '$formattedCount necitit',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marchează';

  @override
  String get messageListTrash => 'Coș de gunoi';

  @override
  String get messageListFilterTitle => 'Filtrează';

  @override
  String get messageListFilterInclude => 'INCLUDE';

  @override
  String get panesHideMailboxes => 'Ascunde căsuțele poștale';

  @override
  String get panesShowMailboxes => 'Afișează căsuțele poștale';

  @override
  String get panesMailboxesWidth => 'Lățimea căsuțelor poștale';

  @override
  String get panesListWidth => 'Lățimea listei de mesaje';

  @override
  String get panesNoMessageSelected => 'Niciun mesaj selectat';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje',
      few: '$count mesaje',
      one: '$count mesaj',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Amânate';

  @override
  String get snoozeSheetTitle => 'Amână';

  @override
  String get snoozeLaterToday => 'Mai târziu azi';

  @override
  String get snoozeThisEvening => 'Diseară';

  @override
  String get snoozeTomorrow => 'Mâine';

  @override
  String get snoozeThisWeekend => 'Weekendul acesta';

  @override
  String get snoozeNextWeek => 'Săptămâna viitoare';

  @override
  String get snoozePickDateTime => 'Alege data și ora…';

  @override
  String get snoozeMenu => 'Amână…';

  @override
  String get snoozeWakeNow => 'Readu acum';

  @override
  String get snoozeChangeTimeMenu => 'Schimbă ora amânării…';

  @override
  String get snoozeChangeTime => 'Schimbă ora';

  @override
  String get snoozeNoTime => 'Nicio oră setată';

  @override
  String get snoozeFooter => 'Mesajele amânate revin în Inbox, necitite, la ora stabilită.';

  @override
  String get snoozeEmptyTitle => 'Nimic amânat';

  @override
  String get snoozeEmptyText => 'Amână un mesaj ca să revină în Inbox când ai nevoie de el.';

  @override
  String get appLockUnlock => 'Deblochează';

  @override
  String get appLockFailed => 'Loupe nu a putut confirma că ești tu.';

  @override
  String get appLockLockedOut => 'Prea multe încercări. Încearcă din nou mai târziu.';

  @override
  String get appLockPromptError => 'Solicitarea nu a putut fi afișată. Încearcă din nou.';

  @override
  String get appLockNoScreenLock => 'Acest telefon nu are blocarea ecranului configurată.';

  @override
  String get appLockUnlockPromptTitle => 'Deblochează Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirmă că ești tu ca să-ți vezi e-mailurile.';

  @override
  String get appLockTurnOnPromptTitle => 'Activează Blocarea aplicației';

  @override
  String get appLockTurnOnPromptReason => 'Confirmă că ești tu ca să activezi Blocarea aplicației.';

  @override
  String get appLockScreenLockRemoved =>
      'Blocarea aplicației este dezactivată: acest telefon nu mai are blocarea ecranului. Configureaz-o ca să activezi din nou Blocarea aplicației.';

  @override
  String get appLockAfterImmediately => 'Imediat';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de minute',
      few: '$count minute',
      one: '$count minut',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de ore',
      few: '$count ore',
      one: '$count oră',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Criptat';

  @override
  String get openpgpEncryptedInPart => 'Criptat parțial';

  @override
  String get openpgpEncryptedLocked => 'Criptat · blocat';

  @override
  String get openpgpEncryptedNoKey => 'Criptat · fără cheie';

  @override
  String get openpgpEncryptedDamaged => 'Criptat · deteriorat';

  @override
  String get openpgpEncryptedUnsupported => 'Criptat · neacceptat';

  @override
  String get openpgpUnknownSigner => 'necunoscut';

  @override
  String get openpgpUnknownKey => 'Cheie necunoscută';

  @override
  String get openpgpSignatureInvalid => 'Semnătură nevalidă';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Semnat de $name, nu de expeditor';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Semnat parțial de $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Semnat de $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Semnat cu o cheie respinsă';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Semnat de $name · cheie neacceptată';
  }

  @override
  String get openpgpUnlock => 'Deblochează';

  @override
  String get openpgpCantDecrypt => 'Acest mesaj nu poate fi decriptat';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Criptat cu OpenPGP';

  @override
  String get openpgpEncryption => 'Criptare';

  @override
  String get openpgpDecryptedHere => 'Decriptat pe acest dispozitiv';

  @override
  String get openpgpNotDecrypted => 'Nedecriptat';

  @override
  String get openpgpKeyLocked => 'Cheia ta este blocată.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pentru cheile $keys',
      few: 'Pentru cheile $keys',
      one: 'Pentru cheia $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Subiect protejat';

  @override
  String get openpgpUnlockKey => 'Deblochează cheia';

  @override
  String get openpgpSignature => 'Semnătură';

  @override
  String get openpgpFingerprint => 'Amprentă';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID cheie $id';
  }

  @override
  String get openpgpSigned => 'Semnat la';

  @override
  String get openpgpProblem => 'Problemă';

  @override
  String get openpgpAcceptance => 'Acceptare';

  @override
  String get openpgpChangeAcceptance => 'Schimbă acceptarea…';

  @override
  String get openpgpCheckedFooter => 'Verificat pe acest dispozitiv cu OpenPGP, compatibil cu Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Cheia ta este blocată. Deblocheaz-o cu fraza de acces ca să citești acest mesaj.';

  @override
  String get openpgpSummaryNoSecretKey => 'A fost criptat pentru o cheie care nu se află pe acest dispozitiv.';

  @override
  String get openpgpSummaryDamaged => 'Datele criptate sunt deteriorate sau au fost modificate pe drum.';

  @override
  String get openpgpSummaryUnsupported => 'Folosește un algoritm pe care Loupe nu îl acceptă.';

  @override
  String get openpgpSummaryEncrypted => 'Doar tu și ceilalți destinatari îl puteți citi.';

  @override
  String get openpgpSummaryNotSigned => 'Nu este semnat, deci expeditorul nu este confirmat.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Este semnat, dar cu o cheie pe care nu o ai, așa că semnătura nu poate fi verificată.';

  @override
  String get openpgpSummaryBadSignature => 'Semnătura nu se potrivește: este posibil ca mesajul să fi fost modificat.';

  @override
  String get openpgpSummaryMismatch =>
      'Semnătura este validă, dar cheia aparține altei adrese decât cea a expeditorului.';

  @override
  String get openpgpSummaryPartial =>
      'Doar o parte a mesajului este semnată. Textul din afara semnăturii (de exemplu, subsolul unei liste de e-mail) apare sub linia „Unsigned content”, iar alte părți ale mesajului, cum ar fi atașamentele, nu sunt nici ele acoperite.';

  @override
  String get openpgpSummaryOwnKey => 'Semnat cu propria ta cheie.';

  @override
  String get openpgpSummaryVerified => 'Semnătura este validă și ai verificat amprenta cheii.';

  @override
  String get openpgpSummaryUnverified => 'Semnătura este validă. Ai acceptat cheia fără să-i verifici amprenta.';

  @override
  String get openpgpSummaryRejected => 'Semnătura este validă, dar ai respins această cheie.';

  @override
  String get openpgpSummaryUndecided =>
      'Semnătura este validă, dar nu ai acceptat încă această cheie. Compară-i amprenta cu expeditorul.';

  @override
  String get openpgpAcceptanceRejected => 'Respinsă';

  @override
  String get openpgpAcceptanceUndecided => 'Neacceptată';

  @override
  String get openpgpAcceptanceUnverified => 'Acceptată';

  @override
  String get openpgpAcceptanceVerified => 'Acceptată și verificată';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Accepți cheia de la $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Amprentă $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Da, am verificat amprenta';

  @override
  String get openpgpAcceptUnverified => 'Da, fără verificare';

  @override
  String get openpgpAcceptLater => 'Nu încă';

  @override
  String get openpgpRejectKey => 'Respinge această cheie';

  @override
  String get openpgpNoSubject => '(fără subiect)';

  @override
  String get openpgpEncryptionTitle => 'Criptare end-to-end';

  @override
  String get openpgpMyKeys => 'Cheile mele OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Cu o cheie poți citi e-mailurile criptate și le poți semna și cripta pe ale tale. Folosești Thunderbird? Exportă-ți cheia de acolo (Setări cont › Criptare end-to-end › Exportă cheia secretă) și import-o aici.';

  @override
  String get openpgpAddKey => 'Adaugă o cheie…';

  @override
  String get openpgpAddresses => 'Adrese';

  @override
  String get openpgpAddressesFooter => 'Ce cheie folosește fiecare adresă și când criptează și semnează.';

  @override
  String get openpgpCorrespondentsKeys => 'Cheile OpenPGP ale corespondenților';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Acceptă o cheie după ce ești sigur că aparține proprietarului ei; compară amprenta cu proprietarul ca s-o marchezi ca verificată.';

  @override
  String get openpgpImportPublicKey => 'Importă o cheie publică…';

  @override
  String get openpgpCollected => 'Colectate prin Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Chei sosite odată cu mesajele. Loupe poate cripta pentru ele atunci când ambele părți cer asta.';

  @override
  String get openpgpOnThisDevice => 'Pe acest dispozitiv';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Mesajele criptate își ascund subiectul. Loupe păstrează subiectul fiecărui mesaj pe care îl deschizi în baza sa de date criptată de pe acest dispozitiv, ca lista, căutarea și notificările să-l poată afișa. În fundal, Loupe poate decripta și subiectele mesajelor noi cu cheile care nu au frază de acces; pentru asta, descarcă fiecare mesaj (până la 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Decriptează subiectele în fundal';

  @override
  String get openpgpIndexFooter =>
      'Căutarea găsește mesajele criptate după expeditor, destinatari și subiect. Cu această opțiune activată, Loupe adaugă și textul fiecărui mesaj criptat pe care îl decriptează în indexul de căutare din baza sa de date criptată de pe acest dispozitiv, așa că și căutarea după text îl găsește. Dacă o dezactivezi, acel text este eliminat din index.';

  @override
  String get openpgpIndexDecrypted => 'Indexează mesajele decriptate pentru căutare';

  @override
  String get openpgpPassphrases => 'Fraze de acces';

  @override
  String get openpgpPassphrasesFooter =>
      'Cheile OpenPGP și certificatele S/MIME protejate cu o frază de acces sunt deblocate când e nevoie. Fără „Reține”, sunt blocate din nou la două minute după fiecare utilizare.';

  @override
  String get openpgpRememberPassphrases => 'Reține frazele de acces';

  @override
  String get openpgpRememberPassphrasesDetail => 'Până la închiderea Loupe';

  @override
  String get openpgpLockKeysNow => 'Blochează cheile acum';

  @override
  String get openpgpKeysLocked => 'Chei blocate.';

  @override
  String get openpgpKeyStateRevoked => 'revocată';

  @override
  String get openpgpKeyStateExpired => 'expirată';

  @override
  String get openpgpKeyStateNeverExpires => 'nu expiră niciodată';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'expiră pe $date';
  }

  @override
  String get openpgpNoKey => 'Fără cheie';

  @override
  String get openpgpAlwaysEncrypt => 'Criptează întotdeauna';

  @override
  String get openpgpAddKeyTitle => 'Adaugă o cheie OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importă cheia pe care o folosești în Thunderbird sau creează una nouă.';

  @override
  String get openpgpImportFromClipboard => 'Importă din clipboard';

  @override
  String get openpgpImportFromFile => 'Importă din fișier';

  @override
  String get openpgpGenerateNewKey => 'Generează o cheie nouă';

  @override
  String get openpgpImportPublicKeyTitle => 'Importă o cheie publică';

  @override
  String get openpgpFromClipboard => 'Din clipboard';

  @override
  String get openpgpFromFile => 'Din fișier';

  @override
  String get openpgpClipboardEmpty => 'Clipboardul este gol. Copiază mai întâi cheia.';

  @override
  String get openpgpKey => 'Cheie';

  @override
  String get openpgpValidityRevoked => 'Revocată';

  @override
  String openpgpValidityExpired(String date) {
    return 'A expirat pe $date';
  }

  @override
  String get openpgpNeverExpires => 'Nu expiră niciodată';

  @override
  String openpgpValidUntil(String date) {
    return 'Validă până pe $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Amprentă copiată.';

  @override
  String get openpgpAlgorithm => 'Algoritm';

  @override
  String get openpgpCreated => 'Creată';

  @override
  String get openpgpValidity => 'Valabilitate';

  @override
  String get openpgpProtection => 'Protecție';

  @override
  String get openpgpProtectionPassphrase => 'Frază de acces';

  @override
  String get openpgpProtectionKeychain => 'Doar stocarea securizată';

  @override
  String get openpgpKeyDetailsFooter =>
      'Distribuie-ți cheia publică pentru ca alții să poată cripta pentru tine. Copia de rezervă este cheia ta secretă, protejată de fraza de acces, dacă are una: păstreaz-o privată.';

  @override
  String get openpgpSharePublicKey => 'Distribuie cheia publică';

  @override
  String get openpgpCopyPublicKey => 'Copiază cheia publică';

  @override
  String get openpgpPublicKeyCopied => 'Cheie publică copiată.';

  @override
  String get openpgpBackUpSecretKey => 'Fă o copie de rezervă a cheii secrete';

  @override
  String get openpgpDeleteKey => 'Șterge cheia';

  @override
  String get openpgpRemoveKey => 'Elimină cheia';

  @override
  String get openpgpBackUpTitle => 'Faci o copie de rezervă a cheii secrete?';

  @override
  String get openpgpBackUpProtected =>
      'Copia de rezervă este protejată de fraza de acces a cheii tale. Oricine le are pe amândouă îți poate citi e-mailurile.';

  @override
  String get openpgpBackUpUnprotected =>
      'Această cheie nu are frază de acces: oricine are copia de rezervă îți poate citi e-mailurile și poate semna în numele tău.';

  @override
  String get openpgpBackUp => 'Fă copia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Ștergi cheia ta $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Elimini cheia de la $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'E-mailurile criptate pentru această cheie nu vor mai putea fi citite pe acest dispozitiv, decât dacă o imporți din nou.';

  @override
  String get openpgpRemoveKeyMessage => 'O poți importa din nou mai târziu.';

  @override
  String get openpgpKeyHeader => 'Cheie OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Adaugă o cheie în Criptare end-to-end ca să criptezi și să semnezi e-mailurile de la această adresă.';

  @override
  String get openpgpGenerateAKey => 'Generează o cheie…';

  @override
  String get openpgpSending => 'Trimitere';

  @override
  String get openpgpSendingFooter =>
      'Criptarea automată se activează când fiecare destinatar are o cheie acceptată sau un certificat de încredere ori când Autocrypt indică faptul că ambele părți o doresc. E-mailurile criptate sunt întotdeauna semnate.';

  @override
  String get openpgpEncryptAutomatically => 'Criptează automat';

  @override
  String get openpgpAlwaysEncryptDetail => 'Refuză trimiterea când un destinatar nu are cheie';

  @override
  String get openpgpSignUnencrypted => 'Semnează e-mailurile necriptate';

  @override
  String get openpgpAttachPublicKey => 'Atașează cheia mea publică';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt trimite cheia ta publică odată cu fiecare mesaj, ca alte aplicații să poată cripta pentru tine fără nicio configurare.';

  @override
  String get openpgpSendMyKey => 'Trimite cheia mea cu e-mailurile';

  @override
  String get openpgpPreferEncryption => 'Preferă criptarea';

  @override
  String get openpgpPreferEncryptionDetail => 'Le cere celorlalți să cripteze când pot';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de ani',
      few: '$count ani',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Frazele de acces nu se potrivesc.';

  @override
  String openpgpKeyReady(String id) {
    return 'Cheia ta $id este gata.';
  }

  @override
  String get openpgpNewKey => 'Cheie nouă';

  @override
  String get openpgpNewKeyFor => 'Pentru';

  @override
  String get openpgpYourName => 'Numele tău';

  @override
  String get openpgpAddress => 'Adresă';

  @override
  String get openpgpPassphrase => 'Frază de acces';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opțional. Fără ea, doar stocarea securizată a telefonului protejează cheia, iar Loupe nu o cere niciodată. Cu ea, Loupe o cere când este nevoie de cheie.';

  @override
  String get openpgpRepeatPassphrase => 'Repetă';

  @override
  String get openpgpExpires => 'Expiră';

  @override
  String get openpgpExpiresFooter =>
      'Poți crea o cheie nouă înainte ca aceasta să expire. Și Thunderbird folosește trei ani.';

  @override
  String get openpgpGenerateKey => 'Generează cheia';

  @override
  String get openpgpKeyFor => 'Cheie pentru';

  @override
  String get openpgpCantEncrypt => 'Nu se poate cripta';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Nu există nicio cheie OpenPGP pentru $names, iar această adresă criptează întotdeauna. Elimină destinatarul sau importă-i cheia în Setări › Criptare end-to-end.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Nu există niciun certificat S/MIME valid pentru $names, iar această adresă criptează întotdeauna. Elimină destinatarul sau importă-i certificatul în Setări › Criptare end-to-end.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Nu există nicio cheie OpenPGP pentru $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Nu există niciun certificat S/MIME valid pentru $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Trimite necriptat';

  @override
  String get openpgpCantSign => 'Nu se poate semna';

  @override
  String get openpgpCantSignMessage =>
      'Cheia privată a certificatului tău S/MIME nu se află pe acest dispozitiv. Importă din nou certificatul (un fișier .p12 sau .pfx) în Setări › Criptare end-to-end.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nicio cheie pentru $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Niciun certificat pentru $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Chei prin Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Toți au o cheie';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Toți au un certificat';

  @override
  String get openpgpComposeEncrypt => 'Criptează';

  @override
  String get openpgpComposeSign => 'Semnează';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, comută';
  }

  @override
  String get openpgpNoKeyFound => 'Nu s-a găsit nicio cheie OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Imporți o cheie secretă?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Acest atașament conține o cheie secretă ($names). Import-o ca fiind cheia ta doar dacă ai exportat-o chiar tu, de exemplu din Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importă ca cheia mea';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'cheia ta $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imporți $count de chei ($names)?',
      few: 'Imporți $count chei ($names)?',
      one: 'Imporți cheia de la $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importă și acceptă';

  @override
  String get openpgpImportDecideLater => 'Importă, decide mai târziu';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'cheia de la $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'S-au importat: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sunt atașate $count de chei OpenPGP.',
      few: 'Sunt atașate $count chei OpenPGP.',
      one: 'Este atașată o cheie OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importă';

  @override
  String get openpgpUnlockKeyTitle => 'Deblochează cheia OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Introdu fraza de acces a cheii de la $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Fraza de acces este greșită. Încearcă din nou.';

  @override
  String get openpgpExplainLocked => 'Acest mesaj este criptat. Deblochează-ți cheia OpenPGP ca să-l citești.';

  @override
  String get openpgpExplainNoKey =>
      'Acest mesaj este criptat, dar nu pentru vreo cheie OpenPGP de pe acest dispozitiv. Dacă îl citești în Thunderbird, importă-ți cheia de acolo: Setări › Criptare end-to-end.';

  @override
  String get openpgpExplainDamaged => 'Acest mesaj criptat este deteriorat, așa că nu poate fi decriptat în siguranță.';

  @override
  String get openpgpExplainUnsupported => 'Acest mesaj folosește o criptare pe care Loupe nu o poate citi încă.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Acest mesaj este criptat cu S/MIME, dar nu pentru vreun certificat de pe acest dispozitiv. Importă-ți certificatul (un fișier .p12 sau .pfx) în Setări › Criptare end-to-end.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Acest mesaj este criptat. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Deblochează-ți certificatul S/MIME ca să-l citești.';

  @override
  String get openpgpAttachmentGone => 'Acest atașament nu mai este disponibil.';

  @override
  String get smimeEncrypted => 'Criptat (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Criptat (S/MIME) · fără certificat';

  @override
  String get smimeEncryptedDamaged => 'Criptat (S/MIME) · deteriorat';

  @override
  String get smimeEncryptedUnsupported => 'Criptat (S/MIME) · neacceptat';

  @override
  String get smimeEncryptedLocked => 'Criptat (S/MIME) · blocat';

  @override
  String get smimeUnknownSigner => 'necunoscut';

  @override
  String get smimeSignatureModified => 'Semnătură nevalidă: mesaj modificat';

  @override
  String get smimeSignatureWeak => 'Semnătură nesigură: algoritm învechit';

  @override
  String get smimeSignatureUncheckable => 'Semnătura nu poate fi verificată';

  @override
  String get smimeSignedCertificateMissing => 'Semnat · certificat lipsă';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Semnat de $name · certificat revocat';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Semnat de $name · la altă dată';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Semnat de $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Semnat de $name · certificat nevalid';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Semnat de $name · nu este de încredere';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Semnat de $name · certificat expirat';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Semnat de $name · certificat încă nevalid';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Semnat de $name · certificat nedestinat e-mailului';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Semnat de $name, nu de expeditor';
  }

  @override
  String get smimeCantDecrypt => 'Acest mesaj nu poate fi decriptat';

  @override
  String get smimeEncryptedWithSmime => 'Criptat cu S/MIME';

  @override
  String get smimeEncryption => 'Criptare';

  @override
  String get smimeDecryptedHere => 'Decriptat pe acest dispozitiv';

  @override
  String get smimeNotDecrypted => 'Nedecriptat';

  @override
  String get smimeAuthenticated => 'autentificat';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pentru $count de certificate',
      few: 'pentru $count certificate',
      one: 'pentru $count certificat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Semnătură';

  @override
  String get smimeIssuedBy => 'Emis de';

  @override
  String get smimeValid => 'Valabil';

  @override
  String smimeValidRange(String from, String to) {
    return 'de la $from la $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Amprentă SHA-256';

  @override
  String get smimeSigned => 'Semnat la';

  @override
  String get smimeProblem => 'Problemă';

  @override
  String get smimeCheckingRevocation => 'Se verifică revocarea…';

  @override
  String get smimeNotRevoked => 'Nerevocat';

  @override
  String get smimeRevoked => 'Revocat';

  @override
  String get smimeRevocationUnknown => 'Revocare necunoscută';

  @override
  String smimeRevokedSince(String date) {
    return 'Din $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Autoritatea a fost întrebată (lista sa de revocare), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Autoritatea a fost întrebată (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Ai încredere în „$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Ai încredere în acest certificat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Verificat pe acest dispozitiv cu S/MIME, compatibil cu Outlook și Thunderbird; revocarea, verificată la autoritatea de certificare.';

  @override
  String get smimeCheckedFooter =>
      'Verificat pe acest dispozitiv cu S/MIME, compatibil cu Outlook și Thunderbird. Revocarea nu este verificată (Setări › Criptare end-to-end).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Ai încredere în $name pentru e-mail?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Ai încredere în certificatul de la $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Orice certificat emis de această autoritate va fi considerat de încredere, ca autoritatea de certificare a companiei tale. Compară mai întâi amprenta cu proprietarul:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Compară mai întâi amprenta cu proprietarul:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Ai încredere';

  @override
  String get smimeSummaryNoKey => 'A fost criptat pentru un certificat care nu se află pe acest dispozitiv.';

  @override
  String get smimeSummaryDamaged => 'Datele criptate sunt deteriorate sau au fost modificate pe drum.';

  @override
  String get smimeSummaryUnsupported => 'Folosește un algoritm pe care Loupe nu îl acceptă.';

  @override
  String get smimeSummaryLocked => 'Certificatul tău S/MIME este blocat.';

  @override
  String get smimeSummaryEncrypted => 'Doar tu și ceilalți destinatari îl puteți citi.';

  @override
  String get smimeSummaryNotSigned => 'Nu este semnat, deci expeditorul nu este confirmat.';

  @override
  String get smimeSummaryModified => 'Semnătura nu se potrivește: mesajul a fost modificat după ce a fost semnat.';

  @override
  String get smimeSummaryUncheckable => 'Semnătura nu poate fi verificată.';

  @override
  String get smimeSummaryNoCertificate =>
      'Certificatul semnatarului nu se află în mesaj, așa că semnătura nu poate fi verificată.';

  @override
  String get smimeSummaryRevoked =>
      'Autoritatea de certificare a revocat certificatul semnatarului: semnătura nu este de încredere.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Autoritatea de certificare a revocat certificatul semnatarului ($reason): semnătura nu este de încredere.';
  }

  @override
  String get smimeDateMismatch =>
      'A fost semnat cu mai mult de o oră înainte sau după data mesajului: poate fi un mesaj vechi trimis din nou.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Semnătura este validă, iar $issuer garantează că certificatul aparține expeditorului.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certificatul sau unul dintre emitenții săi este nevalid.';

  @override
  String get smimeProblemUntrusted => 'Certificatul provine de la o autoritate în care Loupe nu are încredere.';

  @override
  String get smimeProblemExpired => 'Certificatul expirase.';

  @override
  String get smimeProblemNotYetValid => 'Certificatul nu era încă valid.';

  @override
  String get smimeProblemWrongUsage => 'Certificatul nu este destinat e-mailului.';

  @override
  String get smimeProblemWrongAddress => 'Certificatul aparține altei adrese decât cea a expeditorului.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'De încredere · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nu este de încredere · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'A expirat pe $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Valabil de la $date';
  }

  @override
  String get smimeTrustInvalid => 'Nevalid';

  @override
  String get smimeTrustNotForMail => 'Nu este pentru e-mail';

  @override
  String get smimeTrustAnotherAddress => 'Altă adresă';

  @override
  String get smimeMyCertificates => 'Certificatele mele S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Pentru S/MIME, așa cum îl folosesc Outlook și multe companii. Importă-ți certificatul împreună cu cheia privată (un fișier .p12 sau .pfx), exportat din Outlook, Windows, macOS sau Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Pentru S/MIME, așa cum îl folosesc Outlook și multe companii. Importă-ți certificatul împreună cu cheia privată (un fișier .p12 sau .pfx), exportat din Outlook, Windows, macOS sau Thunderbird, sau folosește unul instalat pe acest dispozitiv de tine sau de compania ta.';

  @override
  String get smimeCertificateExpired => 'expirat';

  @override
  String smimeCertificateUntil(String date) {
    return 'până pe $date';
  }

  @override
  String get smimeCertificateOnDevice => 'pe acest dispozitiv';

  @override
  String get smimeImportCertificateEllipsis => 'Importă un certificat…';

  @override
  String get smimeUseDeviceCertificate => 'Folosește un certificat de pe acest dispozitiv…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificatele corespondenților';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Colectate din e-mailurile semnate, așa cum fac Outlook și Thunderbird. E-mailurile sunt criptate doar pentru certificate de încredere: Loupe are încredere în autoritățile în care Mozilla are încredere pentru e-mail și în cele pe care le adaugi tu.';

  @override
  String get smimeRevocation => 'Revocare';

  @override
  String get smimeRevocationFooter =>
      'Când deschizi un e-mail semnat, Loupe întreabă autoritatea care a emis certificatul semnatarului dacă acesta a fost revocat (prin serviciul său OCSP sau prin lista sa de revocare). Astfel, autoritatea poate vedea când cineva de la adresa ta de internet citește e-mailuri semnate cu acel certificat. Răspunsurile sunt păstrate pe acest dispozitiv până expiră. Un certificat revocat apare ca „certificat revocat” în antetul mesajului.';

  @override
  String get smimeCheckRevocation => 'Verifică online revocarea certificatelor';

  @override
  String get smimeTrustedAuthorities => 'Autorități de încredere';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alese de tine, pe lângă cele $count în care Mozilla are încredere pentru e-mail.',
      few: 'Alese de tine, pe lângă cele $count în care Mozilla are încredere pentru e-mail.',
      one: 'Alese de tine, pe lângă cea în care Mozilla are încredere pentru e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoritate de certificare';

  @override
  String get smimeImportACertificate => 'Importă un certificat';

  @override
  String get smimeImportContactMessage =>
      'Certificatul unui corespondent (.cer, .crt, .pem) sau al unei autorități de certificare.';

  @override
  String get smimeFromClipboard => 'Din clipboard';

  @override
  String get smimeFromFile => 'Din fișier';

  @override
  String get smimeClipboardEmpty => 'Clipboardul este gol. Copiază mai întâi certificatul.';

  @override
  String get smimeCertificate => 'Certificat';

  @override
  String get smimeOnDeviceFooter =>
      'Cheia sa privată rămâne în spațiul de stocare a datelor de conectare din Android, unde ai instalat-o tu sau compania ta: Loupe îi cere sistemului Android să semneze și să decripteze cu ea. E-mailurile semnate sunt semnate în momentul trimiterii.';

  @override
  String get smimeAddresses => 'Adrese';

  @override
  String get smimeUsage => 'Pentru';

  @override
  String get smimeUsageNone => 'Nimic din ce folosește Loupe';

  @override
  String get smimeUsageSigning => 'Semnare';

  @override
  String get smimeUsageEncryption => 'Criptare';

  @override
  String get smimeUsageCertificates => 'Certificate';

  @override
  String get smimeAlgorithm => 'Algoritm';

  @override
  String get smimeSerialNumber => 'Număr de serie';

  @override
  String get smimeFingerprintCopied => 'Amprentă copiată.';

  @override
  String get smimeSha1Thumbprint => 'Amprentă digitală SHA-1';

  @override
  String get smimePrivateKey => 'Cheie privată';

  @override
  String get smimeKeyOnDevice => 'Pe acest dispozitiv';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'În Loupe, cu frază de acces';

  @override
  String get smimeKeyInLoupe => 'În Loupe';

  @override
  String get smimeSource => 'Sursă';

  @override
  String get smimeSourceSignedMail => 'E-mail semnat';

  @override
  String get smimeSourceImported => 'Importat';

  @override
  String get smimeTrustHeader => 'Încredere';

  @override
  String get smimeTrustedRoot => 'Rădăcină de încredere';

  @override
  String get smimeIssuer => 'Emitent';

  @override
  String smimeTrustNamed(String name) {
    return 'Ai încredere în „$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Ai încredere în această autoritate';

  @override
  String get smimeTrustThisCertificate => 'Ai încredere în acest certificat';

  @override
  String get smimeStopTrusting => 'Nu mai avea încredere';

  @override
  String get smimePassphrase => 'Frază de acces';

  @override
  String get smimePassphraseFooter =>
      'Opțional. Cu o frază de acces, cheia privată este criptată și pe acest dispozitiv (Argon2id și AES-256), iar Loupe ți-o cere ca să semneze și să decripteze; Reține frazele de acces stabilește pentru cât timp. E-mailurile pe care le trimiți sunt semnate în momentul trimiterii; activitățile din fundal nu pot folosi cheia.';

  @override
  String get smimeChangePassphrase => 'Schimbă fraza de acces…';

  @override
  String get smimeSetPassphraseEllipsis => 'Setează o frază de acces…';

  @override
  String get smimeRemovePassphrase => 'Elimină fraza de acces';

  @override
  String get smimeShareCertificate => 'Distribuie certificatul';

  @override
  String get smimeDeleteCertificate => 'Șterge certificatul';

  @override
  String get smimeRemoveCertificate => 'Elimină certificatul';

  @override
  String get smimePassphraseChanged => 'Fraza de acces a fost schimbată.';

  @override
  String get smimePassphraseSet => 'Fraza de acces a fost setată.';

  @override
  String get smimeRemovePassphraseTitle => 'Elimini fraza de acces?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Cheia privată va fi apoi protejată doar de stocarea securizată, ca fără frază de acces: Loupe nu o mai cere, iar activitățile din fundal o pot folosi.';

  @override
  String get smimePassphraseRemoved => 'Fraza de acces a fost eliminată.';

  @override
  String smimeTrustTitle(String name) {
    return 'Ai încredere în $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Fiecare certificat pe care îl emite va fi considerat de încredere pentru e-mail. Compară mai întâi amprenta cu proprietarul:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Ștergi certificatul tău $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Elimini certificatul de la $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe nu îl mai folosește: e-mailurile criptate pentru el nu mai pot fi citite în Loupe. Certificatul rămâne pe acest dispozitiv (Setări › Securitate › Criptare și date de conectare).';

  @override
  String get smimeDeleteOwnMessage =>
      'Cheia sa privată este ștearsă de pe acest dispozitiv: e-mailurile criptate pentru el nu mai pot fi citite aici, decât dacă îl imporți din nou.';

  @override
  String get smimeRemoveContactMessage => 'Revine odată cu următorul mesaj semnat de la persoana respectivă.';

  @override
  String get smimeAddressImportFooter =>
      'Importă un certificat pentru această adresă ca să semnezi și să criptezi cu S/MIME, așa cum face Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importă un certificat…';

  @override
  String get smimePreferFooter =>
      'Când ambele pot proteja un mesaj, se folosește cel preferat, cu excepția cazului în care doar celălalt are o cheie sau un certificat pentru fiecare destinatar.';

  @override
  String get smimePreferSmime => 'Preferă S/MIME';

  @override
  String get smimePreferSmimeDetail => 'În loc de OpenPGP';

  @override
  String get smimeCertificatePassword => 'Parola certificatului';

  @override
  String get smimeCertificatePasswordPrompt => 'Introdu parola cu care a fost exportat fișierul certificatului.';

  @override
  String get smimeImport => 'Importă';

  @override
  String get smimeWrongPassword => 'Parola este greșită. Încearcă din nou.';

  @override
  String get smimeNoCertificateFound => 'Nu s-a găsit niciun certificat.';

  @override
  String smimeCertificateOf(String name) {
    return 'certificatul de la $name';
  }

  @override
  String get smimeNothingNew => 'Nimic nou de importat.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'S-au importat: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S-au importat $count de autorități de încredere.',
      few: 'S-au importat $count autorități de încredere.',
      one: 'S-a importat o autoritate de încredere.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S-au importat $certificates și $count de autorități de încredere.',
      few: 'S-au importat $certificates și $count autorități de încredere.',
      one: 'S-au importat $certificates și o autoritate de încredere.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Acest fișier nu conține cheia privată. Exportă-ți certificatul împreună cu cheia privată.';

  @override
  String get smimeImportAsYoursTitle => 'Îl imporți ca certificatul tău?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Acest atașament conține un certificat cu cheia sa privată: $names. Importă-l doar dacă l-ai exportat chiar tu, de exemplu din Outlook sau Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importă ca certificatul meu';

  @override
  String smimeImportedOwn(String names) {
    return 'S-a importat certificatul tău $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'S-a adăugat certificatul tău $name ($addresses) de pe acest dispozitiv.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Ai încredere în „$name” pentru e-mail?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe nu cunoaște această autoritate de certificare (poate este a unei companii). Acordă-i încredere ca să verifici certificatele pe care le emite. Compară mai întâi amprenta cu departamentul IT:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sunt atașate $count de certificate.',
      few: 'Sunt atașate $count certificate.',
      one: 'Este atașat un certificat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importă certificatul';

  @override
  String get smimeUnlockTitle => 'Deblochează certificatul S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Introdu fraza de acces a certificatului de la $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Fraza de acces este greșită. Încearcă din nou.';

  @override
  String get smimeUnlock => 'Deblochează';

  @override
  String get smimeEnterAPassphrase => 'Introdu o frază de acces.';

  @override
  String get smimePassphrasesDiffer => 'Cele două fraze de acces diferă.';

  @override
  String get smimeSetPassphraseTitle => 'Setează fraza de acces';

  @override
  String get smimeSetPassphraseText =>
      'Loupe o va cere ca să semneze și să decripteze. Dacă o uiți, importă din nou certificatul din fișierul său .p12.';

  @override
  String get smimePassphraseAgain => 'Din nou';

  @override
  String get smimeSetPassphraseButton => 'Setează';

  @override
  String get smimeLockedOpenAgain =>
      'Certificatul tău S/MIME este blocat. Deschide din nou mesajul ca să-l deblochezi.';

  @override
  String get smimeDeviceHasNoCertificates => 'Acest dispozitiv nu își pune la dispoziție certificatele.';

  @override
  String get smimeCantReadCertificate => 'Loupe nu poate citi acest certificat.';

  @override
  String get smimeCertificateNotForMail =>
      'Acest certificat nu este pentru e-mail: nu are o adresă de e-mail sau nu este destinat semnării ori criptării.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certificatul nu mai este pe acest dispozitiv sau Loupe nu îl mai poate folosi. Alege-l din nou în Setări › Criptare end-to-end.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Certificatul de pe acest dispozitiv poate fi folosit doar cât timp Loupe este deschisă.';

  @override
  String get smimeDeviceKeyDamaged => 'Cheia criptată este deteriorată.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certificatul de pe acest dispozitiv nu poate face asta: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'neacceptat';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certificatul de pe acest dispozitiv a dat eroare: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa autorității nu este o adresă web.';

  @override
  String get smimeAuthorityTimeout => 'Autoritatea de certificare nu a răspuns la timp.';

  @override
  String get smimeAuthorityUnreachable => 'Autoritatea de certificare nu a putut fi contactată.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Autoritatea de certificare a răspuns $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Răspunsul autorității de certificare este prea mare.';

  @override
  String get smimeRevocationNotChecked =>
      'Neverificat: sunt verificate doar certificatele de la autorități în care Loupe are încredere.';

  @override
  String get settingsLanguage => 'Limbă';

  @override
  String get settingsLanguageSystem => 'La fel ca telefonul';

  @override
  String get settingsLanguageFooter =>
      'Loupe folosește limba telefonului când o are, iar engleza când nu o are. Limba pe care o alegi aici se aplică doar pentru Loupe, inclusiv pentru notificări.';

  @override
  String get settingsAccountsHeader => 'Conturi';

  @override
  String get settingsAddAccount => 'Adaugă un cont';

  @override
  String get settingsMailHeader => 'E-mail';

  @override
  String get settingsSwipeActions => 'Acțiuni de glisare';

  @override
  String get settingsSwipeLeft => 'Glisare la stânga';

  @override
  String get settingsSwipeLeftFooter =>
      'O glisare completă rulează această acțiune. Marchează cu steguleț și Mai multe sunt mereu la o glisare scurtă distanță.';

  @override
  String get settingsSwipeRight => 'Glisare la dreapta';

  @override
  String get settingsSwipeRightFooter => 'O glisare completă rulează această acțiune.';

  @override
  String get settingsSwipeToggleRead => 'Marchează ca citit / necitit';

  @override
  String get settingsSwipeTrash => 'Mută în Coșul de gunoi';

  @override
  String get settingsSwipeMove => 'Mută mesajul';

  @override
  String get settingsSwipeSnooze => 'Amână';

  @override
  String get settingsThreaded => 'Organizează pe conversații';

  @override
  String get settingsUndoSendDelay => 'Întârziere pentru anularea trimiterii';

  @override
  String get settingsUndoSendDelayFooter => 'Mesajele trimise așteaptă atât, ca să le poți retrage.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds de secunde',
      few: '$seconds secunde',
      one: '$seconds secundă',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Aspect';

  @override
  String get settingsTheme => 'Temă';

  @override
  String get settingsThemeSystem => 'Automată';

  @override
  String get settingsThemeLight => 'Luminoasă';

  @override
  String get settingsThemeDark => 'Întunecată';

  @override
  String get settingsDensity => 'Lista de mesaje';

  @override
  String get settingsDensityComfortable => 'Aerisită';

  @override
  String get settingsDensityCompact => 'Compactă';

  @override
  String get settingsReadingHeader => 'Citire';

  @override
  String get settingsReadingFooter => 'Imaginile externe le pot spune expeditorilor când și unde ai deschis un mesaj.';

  @override
  String get settingsDefaultView => 'Vizualizare implicită';

  @override
  String get settingsDefaultViewFooter => 'Poți schimba vizualizarea oricărui mesaj cu butonul Aa.';

  @override
  String get settingsViewReadable => 'Lizibil';

  @override
  String get settingsViewReadableDetail => 'Curat, lizibil, urmează modul întunecat';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exact cum l-a conceput expeditorul';

  @override
  String get settingsViewPlain => 'Text simplu';

  @override
  String get settingsViewPlainDetail => 'Doar cuvintele';

  @override
  String get settingsPlainTextFont => 'Font pentru text simplu';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monospațiat';

  @override
  String get settingsFontMonoDetail => 'Păstrează aliniate tabelele și desenele ASCII';

  @override
  String get settingsTechnicalLists => 'Liste tehnice';

  @override
  String get settingsLoadRemoteImages => 'Încarcă imaginile externe';

  @override
  String get settingsOpenLinksDirectly => 'Deschide linkurile direct';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Ocolește trackerele de clicuri când destinația este cunoscută';

  @override
  String get settingsSecurityHeader => 'Securitate';

  @override
  String get settingsAppLock => 'Blocarea aplicației';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe o cere la pornire și când revii după o absență mai lungă decât timpul de la „Blochează după”.';

  @override
  String get settingsAppLockFooterOff =>
      'Blocarea aplicației îți cere amprenta, fața sau blocarea ecranului înainte să apară e-mailurile.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Blocarea aplicației este încă dezactivată. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configurează un cod de acces';

  @override
  String get settingsScreenLockTextIos =>
      'Blocarea aplicației folosește Face ID, Touch ID sau codul de acces, iar acest iPhone nu are cod de acces. Configurează unul în aplicația Configurări, apoi activează Blocarea aplicației.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configurează blocarea ecranului';

  @override
  String get settingsScreenLockTextAndroid =>
      'Blocarea aplicației folosește blocarea ecranului telefonului sau o amprentă ori o față adăugate la aceasta, iar acest telefon nu are niciuna. Configurează un PIN, un model sau o parolă în setările Android, apoi activează Blocarea aplicației.';

  @override
  String get settingsOpenSystemSettings => 'Deschide Setările';

  @override
  String get settingsOpenAndroidSettings => 'Deschide setările Android';

  @override
  String get settingsLockAfter => 'Blochează după';

  @override
  String get settingsLockAfterFooter => 'Cât timp poate sta Loupe în fundal înainte să ceară din nou.';

  @override
  String get settingsNotifications => 'Notificări';

  @override
  String get settingsEncryption => 'Criptare end-to-end';

  @override
  String get settingsAdvanced => 'Avansate';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'E-mailurile demo sunt o căsuță poștală inventată, care există doar pe acest telefon. Nu se trimite nimic nicăieri.';

  @override
  String get settingsDemoMode => 'Mod demo';

  @override
  String get settingsResetApp => 'Resetează aplicația';

  @override
  String get settingsResetFooter => 'Uită toate setările și revine la ecranul de bun venit.';

  @override
  String get settingsResetTitle => 'Resetezi Loupe?';

  @override
  String get settingsResetMessage =>
      'Se vor uita toate setările, Smart Mailboxes și căutările recente, iar aplicația revine la ecranul de bun venit.';

  @override
  String get settingsAboutHeader => 'Despre';

  @override
  String get settingsVersion => 'Versiune';

  @override
  String get settingsLicences => 'Licențe';

  @override
  String get settingsPrivacy => 'Confidențialitate';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nu are statistici de utilizare și nu te urmărește. E-mailurile tale ajung doar la serverele tale de e-mail.';

  @override
  String get settingsNotificationsOffIos => 'Notificările pentru Loupe sunt dezactivate în Configurări.';

  @override
  String get settingsNotificationsOffAndroid => 'Notificările pentru Loupe sunt dezactivate în setările Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nu îi permite lui Loupe să afișeze notificări. Permite-le din setări.';
  }

  @override
  String get settingsNewMailHeader => 'E-mailuri noi';

  @override
  String get settingsNewMailFooterDemo =>
      'E-mailurile demo nu sosesc în fundal. Trimite o notificare de test ca să vezi cum arată e-mailurile noi.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe caută e-mailuri noi în fundal când îi permite iOS, ceea ce se poate întâmpla la ore distanță pentru aplicațiile pe care nu le deschizi des. Primești notificări pentru mesajele noi din inboxuri și pentru cele de la VIP-uri din orice dosar.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe caută e-mailuri noi cam la fiecare 15 minute, când îi permite Android. Primești notificări pentru mesajele noi din inboxuri și pentru cele de la VIP-uri din orice dosar.';

  @override
  String get settingsNoAccounts => 'Niciun cont';

  @override
  String get settingsVipOnly => 'Doar VIP';

  @override
  String get settingsVipOnlyDetail => 'Doar mesajele de la VIP-urile tale';

  @override
  String get settingsHideContent => 'Ascunde conținutul';

  @override
  String get settingsHideContentFooterOn =>
      'Notificările spun doar „Mesaj nou de la” și contul, nu cine a scris sau despre ce.';

  @override
  String get settingsHideContentFooterOff =>
      'Ascunde conținutul ține expeditorul, subiectul și previzualizarea departe de ecranul de blocare și de notificări.';

  @override
  String get settingsBackgroundAppRefresh => 'Reîmprospătare în fundal';

  @override
  String get settingsBackgroundRefreshFooter =>
      'E-mailurile noi sosesc în fundal doar cât timp Reîmprospătare în fundal este activată pentru Loupe în Configurări. iOS nu poate ține deschisă o conexiune cu inboxurile tale, așa că nu există Livrare instantanee.';

  @override
  String get settingsInstantDelivery => 'Livrare instantanee';

  @override
  String get settingsInstantDeliveryFooter =>
      'Livrarea instantanee (experimentală) ține deschisă o conexiune cu inboxurile tale, așa că e-mailurile noi sosesc în câteva secunde. Afișează o notificare discretă „Se așteaptă e-mailuri noi” și consumă mai multă baterie.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android poate opri Livrarea instantanee ca să economisească bateria. Permite-i lui Loupe să folosească bateria fără restricții ca s-o mențină activă.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'În curând';

  @override
  String get settingsAllowUnrestrictedBattery => 'Permite utilizarea nerestricționată a bateriei';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push-ul permite e-mailurilor noi să trezească Loupe imediat, dacă serviciul tău de e-mail acceptă asta. Mesajele push trec prin serviciul push al Google și nu conțin e-mailuri, doar „verifică acum”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Acest telefon nu poate primi mesaje push: au nevoie de serviciile Google Play și de o conexiune la rețea. Loupe caută în continuare e-mailuri cam la fiecare 15 minute.';

  @override
  String get settingsCopyPushToken => 'Copiază tokenul push';

  @override
  String get settingsPushTokenCopied => 'Tokenul push a fost copiat';

  @override
  String get settingsSendTestNotification => 'Trimite o notificare de test';

  @override
  String get settingsAppIconBadge => 'Insigna pictogramei aplicației';

  @override
  String get settingsBadgeNote =>
      'Insigna se actualizează de fiecare dată când Loupe caută e-mailuri, inclusiv în fundal.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Ecranul de pornire al acestui telefon nu afișează numere pe pictogramele aplicațiilor. Insigna se actualizează de fiecare dată când Loupe caută e-mailuri, inclusiv în fundal.';

  @override
  String get settingsTestNotificationBody => 'Notificările pentru e-mailurile noi arată așa.';

  @override
  String get settingsAccountRemoved => 'Acest cont a fost eliminat.';

  @override
  String get settingsAccountHeader => 'Cont';

  @override
  String get settingsAccountDescription => 'Descriere';

  @override
  String get settingsAccountDescriptionHint => 'Serviciu, Personal…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Culoare';

  @override
  String get settingsColourFooter => 'Marchează mesajele acestui cont în Toate inboxurile.';

  @override
  String settingsColourNumber(int number) {
    return 'Culoarea $number';
  }

  @override
  String get settingsSendingHeader => 'Trimitere';

  @override
  String get settingsSendingFooter =>
      'Fiecare identitate are propria semnătură. Răspunsurile pleacă de pe adresa la care a fost trimis mesajul.';

  @override
  String get settingsFoldersHeader => 'Dosare';

  @override
  String get settingsFoldersFooter =>
      'Loupe afișează și sincronizează dosarele la care ești abonat, ca Thunderbird. Inbox, Ciorne, Trimise, Spam, Coș de gunoi și Arhivă apar întotdeauna.';

  @override
  String get settingsShowAllFolders => 'Afișează toate dosarele';

  @override
  String get settingsIncoming => 'Intrare';

  @override
  String get settingsOutgoing => 'Ieșire';

  @override
  String get settingsConnectionNotEncrypted => 'Necriptată';

  @override
  String get settingsSignIn => 'Autentificare';

  @override
  String get settingsSignInExpired => 'Expirată';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider nu mai acceptă autentificarea Loupe pentru acest cont, așa că e-mailurile lui nu se sincronizează. Conectează-te din nou ca să rezolvi problema.';
  }

  @override
  String get settingsSignInAgain => 'Conectează-te din nou';

  @override
  String get settingsSigningIn => 'Se conectează…';

  @override
  String get settingsRemoveAccount => 'Elimină contul';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Elimini „$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'E-mailurile și setările contului sunt eliminate de pe acest telefon. Nimic nu este șters de pe server.';

  @override
  String get settingsManageFolders => 'Gestionează dosarele';

  @override
  String get settingsNoFolders => 'Niciun dosar încă.';

  @override
  String get settingsManageFoldersFooter =>
      'Dosarele la care ești abonat apar pe ecranul Căsuțe poștale și se sincronizează în fundal. De obicei, și alte aplicații de e-mail pentru același cont respectă aceste abonări.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Păstrează Smart Mailboxes pentru celelalte dispozitive ale tale. Ascuns pe ecranul Căsuțe poștale.';

  @override
  String get settingsFolderAlwaysShown => 'Afișat întotdeauna';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Abonează-te la $folder';
  }

  @override
  String get settingsIdentities => 'Identități';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Prima identitate este cea implicită pentru mesajele noi. Trage ca să schimbi ordinea.';

  @override
  String get settingsIdentitiesFooterSingle => 'Identitatea implicită pentru mesajele noi.';

  @override
  String get settingsIdentitiesReplyFooter => 'Un răspuns pleacă de pe identitatea la care a fost trimis mesajul.';

  @override
  String get settingsIdentityDefault => 'Implicită';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reordonează $email';
  }

  @override
  String get settingsAddIdentity => 'Adaugă o identitate';

  @override
  String get settingsNewIdentity => 'Identitate nouă';

  @override
  String get settingsIdentity => 'Identitate';

  @override
  String get settingsIdentityNameHint => 'Numele tău';

  @override
  String get settingsReplyTo => 'Răspuns către';

  @override
  String get settingsSignature => 'Semnătură';

  @override
  String get settingsSignatureFooter => 'Adăugată sub „-- ” în mesajele de pe această identitate.';

  @override
  String get settingsNoSignature => 'Fără semnătură';

  @override
  String get settingsCopyToMyself => 'Copie pentru mine';

  @override
  String get settingsCopyToMyselfFooter => 'Adăugate la fiecare mesaj de pe această identitate.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Folosește pentru răspunsuri către';

  @override
  String get settingsReplyPatternsFooter =>
      'Răspunsurile la mesajele trimise la aceste adrese pleacă de pe această identitate. * înlocuiește orice: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'O adresă sau un model în care * înlocuiește orice.';

  @override
  String get settingsAddReplyPattern => 'Adaugă o adresă sau un model';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Elimină $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Model nevalid';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input” nu este o adresă sau un model precum *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nicio adresă';

  @override
  String get settingsIdentityNoAddressMessage => 'Introdu adresa de e-mail de pe care vrei să trimiți.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Adresă nevalidă';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'La Răspuns către, „$address” nu este o adresă de e-mail validă.',
      'cc': 'La Cc, „$address” nu este o adresă de e-mail validă.',
      'bcc': 'La Bcc, „$address” nu este o adresă de e-mail validă.',
      'other': '„$address” nu este o adresă de e-mail validă.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Salvează identitatea';

  @override
  String get settingsDiscardChanges => 'Renunță la modificări';

  @override
  String get settingsDeleteIdentity => 'Șterge identitatea';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Ștergi „$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Mesajele deja trimise de pe ea rămân neschimbate.';

  @override
  String get settingsLastIdentityFooter => 'Un cont are nevoie de cel puțin o identitate.';

  @override
  String get rulesTitle => 'Reguli';

  @override
  String get rulesNewRule => 'Regulă nouă';

  @override
  String get rulesLoadError => 'Regulile nu au putut fi încărcate.';

  @override
  String get rulesEmptyTitle => 'Nicio regulă';

  @override
  String get rulesEmptyText =>
      'Regulile sortează în dosare, etichetează și marchează cu steguleț e-mailurile noi în locul tău. Creează una cu butonul de scriere de mai sus sau dintr-o căutare, cu „Transformă în regulă”.';

  @override
  String get rulesListFooter =>
      'Regulile rulează de sus în jos pentru e-mailurile noi din Inbox. Ține apăsat pe o regulă ca s-o muți.';

  @override
  String get rulesChangeError => 'Regula nu a putut fi modificată';

  @override
  String get rulesConditionEveryMessage => 'Orice mesaj';

  @override
  String rulesMoveRule(String rule) {
    return 'Mută $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule activată';
  }

  @override
  String get rulesServerRulesHeader => 'Reguli pe server';

  @override
  String get rulesServerRulesFooter =>
      'Regulile pe server rulează pe serverul de e-mail pe măsură ce sosesc e-mailurile, chiar și când acest telefon este închis. Sunt păstrate într-un script Sieve numit „loupe”.';

  @override
  String get rulesStatusUnknown => 'Necunoscut';

  @override
  String get rulesStatusError => 'Serverul nu a putut fi interogat.';

  @override
  String get rulesStatusChecking => 'Se verifică…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Rulate din „$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script” este scriptul activ. Atinge ca să ruleze și regulile Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Niciun script nu este activ pe server. Salvarea unei reguli pe server îl activează pe cel al Loupe.';

  @override
  String get rulesStatusUnavailable => 'Indisponibil';

  @override
  String get rulesStatusNoSieve => 'Serverul acestui cont nu oferă Sieve (ManageSieve sau JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mută în $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mută într-un dosar';

  @override
  String rulesActionTag(String tag) {
    return 'Etichetează cu $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Elimină eticheta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Păstrează în Inbox';

  @override
  String rulesActionForward(String address) {
    return 'Redirecționează către $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Redirecționează către $address, fără a păstra o copie';
  }

  @override
  String get rulesActionStop => 'Oprește';

  @override
  String get rulesNoActions => 'Nu face nimic încă';

  @override
  String get rulesLocationDevice => 'Dispozitiv';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Acest dispozitiv';

  @override
  String get rulesNewRuleTitle => 'Regulă nouă';

  @override
  String get rulesEditRuleTitle => 'Editează regula';

  @override
  String get rulesDefaultNameEveryMessage => 'Orice mesaj';

  @override
  String get rulesConditionHeader => 'Când un mesaj nou se potrivește cu';

  @override
  String get rulesConditionFooter =>
      'Scrie-o ca pe o căutare: from:, to:, s: (subiect), b: (conținut), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:factură';

  @override
  String get rulesAccounts => 'Conturi';

  @override
  String get rulesAllAccounts => 'Toate conturile';

  @override
  String get rulesRemovedAccount => 'Cont eliminat';

  @override
  String get rulesAccountsFooter =>
      'O regulă pentru toate conturile se aplică și conturilor pe care le adaugi mai târziu.';

  @override
  String get rulesActionsHeader => 'Atunci';

  @override
  String get rulesForwardingFooter =>
      'Redirecționarea trimite fiecare mesaj potrivit la o altă adresă pe măsură ce sosește, chiar și când acest telefon este închis. Unii furnizori limitează cantitatea de e-mailuri care pot fi redirecționate.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Redirecționarea funcționează doar în regulile pe server, așa că nu apare aici.';

  @override
  String rulesRemoveAction(String action) {
    return 'Elimină $action';
  }

  @override
  String get rulesAddAction => 'Adaugă o acțiune';

  @override
  String get rulesAddMove => 'Mută în dosar…';

  @override
  String get rulesAddTagMenu => 'Adaugă o etichetă…';

  @override
  String get rulesRemoveTagMenu => 'Elimină o etichetă…';

  @override
  String get rulesAddForward => 'Redirecționează către…';

  @override
  String get rulesStopProcessing => 'Nu mai procesa alte reguli';

  @override
  String get rulesRunOnHeader => 'Rulează pe';

  @override
  String get rulesRunOnDeviceFooter =>
      'Acest dispozitiv rulează regula pentru e-mailurile noi din Inbox de fiecare dată când Loupe caută e-mailuri.';

  @override
  String get rulesRunOnServerFooter =>
      'Serverul de e-mail rulează regula pe măsură ce sosesc e-mailurile, chiar și când acest telefon este închis. Necesită Sieve, prin ManageSieve (Dovecot, mailcow) sau JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Aplică mesajelor existente…';

  @override
  String get rulesDeleteRule => 'Șterge regula';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Ștergi „$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Dosar din ce cont?';

  @override
  String get rulesMoveAccountMessage =>
      'E-mailurile celorlalte conturi ajung în dosarul cu același nume din contul respectiv.';

  @override
  String get rulesAddTag => 'Adaugă o etichetă';

  @override
  String get rulesRemoveTag => 'Elimină o etichetă';

  @override
  String get rulesForwardTo => 'Redirecționează către';

  @override
  String get rulesForwardToMessage =>
      'Serverul trimite mai departe fiecare mesaj potrivit la această adresă, chiar și când acest telefon este închis. Folosește o adresă care îți aparține sau în care ai încredere.';

  @override
  String get rulesNotAnAddressTitle => 'Nu este o adresă de e-mail';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address” nu este o adresă către care se poate redirecționa.';
  }

  @override
  String get rulesKeepCopyTitle => 'Păstrezi o copie aici?';

  @override
  String get rulesKeepCopy => 'Păstrează o copie';

  @override
  String get rulesDontKeepCopy => 'Nu păstra o copie';

  @override
  String get rulesCheckCondition => 'Verifică condiția';

  @override
  String get rulesChooseActionTitle => 'Alege o acțiune';

  @override
  String get rulesChooseActionMessage => 'Adaugă ce face regula cu mesajele care se potrivesc.';

  @override
  String get rulesSaveError => 'Regula nu a putut fi salvată';

  @override
  String get rulesSaveServerError => 'Regula pe server nu a putut fi salvată';

  @override
  String get rulesRunOnDeviceInstead => 'Rulează pe acest dispozitiv';

  @override
  String get rulesNothingToApplyTitle => 'Nimic de aplicat';

  @override
  String get rulesNothingToApplyMessage => 'Dă-i mai întâi regulii o condiție validă și o acțiune.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplică „$rule” mesajelor din…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Inboxuri';

  @override
  String get rulesApplyScopeAll => 'Toate căsuțele poștale';

  @override
  String get rulesFindingMessages => 'Se caută mesajele…';

  @override
  String get rulesSearchError => 'Căutarea nu a reușit';

  @override
  String get rulesSearchErrorUnknown => 'Ceva nu a mers bine.';

  @override
  String get rulesNoMatchesTitle => 'Niciun mesaj nu se potrivește';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nimic de acolo nu se potrivește cu „$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aplici „$rule” pentru $countString de mesaje?',
      few: 'Aplici „$rule” pentru $countString mesaje?',
      one: 'Aplici „$rule” pentru $countString mesaj?',
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
      other: 'Aplică pentru $countString de mesaje',
      few: 'Aplică pentru $countString mesaje',
      one: 'Aplică pentru $countString mesaj',
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
      other: '„$rule” a fost aplicată pentru $countString de mesaje',
      few: '„$rule” a fost aplicată pentru $countString mesaje',
      one: '„$rule” a fost aplicată pentru $countString mesaj',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Se întreabă serverul ce poate face…';

  @override
  String get rulesServerUnreachable => 'Serverul nu a putut fi contactat.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nu poate rula pe server: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nu poate rula pe serverul contului $account: $problem';
  }

  @override
  String get rulesShowScript => 'Afișează scriptul';

  @override
  String get rulesHideScript => 'Ascunde scriptul';

  @override
  String get rulesMatchingHeader => 'Mesaje potrivite';

  @override
  String get rulesMatchingHeaderLoading => 'Mesaje potrivite…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString de mesaje potrivite',
      few: '$countString mesaje potrivite',
      one: '$countString mesaj potrivit',
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
      other: '$countString+ de mesaje potrivite',
      few: '$countString+ mesaje potrivite',
      one: '$countString+ mesaj potrivit',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Din ultimele 30 de zile. Regula în sine acționează doar asupra e-mailurilor noi, cu excepția cazului în care o aplici mesajelor existente.';

  @override
  String rulesConditionError(String error) {
    return 'Condiția are o eroare: $error';
  }

  @override
  String get rulesPreviewNoSender => '(fără expeditor)';

  @override
  String get rulesPreviewNoSubject => '(fără subiect)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'și încă $countString',
      few: 'și încă $countString',
      one: 'și încă $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nimic din ultimele 30 de zile.';

  @override
  String get rulesIncludeTitle => 'Activează regulile pe server';

  @override
  String get rulesIncludeLeaveOff => 'Lasă dezactivate';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serverul rulează deja regulile Loupe pentru $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script” este scriptul activ pe serverul contului $account, așa că serverul rulează acel script, nu regulile Loupe. Loupe nu îl va înlocui. Poate adăuga aceste rânduri în el, iar serverul va rula apoi regulile Loupe după cele ale scriptului:';
  }

  @override
  String get rulesShowWholeScript => 'Afișează tot scriptul';

  @override
  String get rulesHideWholeScript => 'Ascunde tot scriptul';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nimic altceva din „$script” nu se schimbă. Dacă filtrele lui sunt editate mai târziu în webmail, webmailul l-ar putea rescrie fără aceste rânduri; Loupe va afișa atunci din nou regulile pe server ca dezactivate.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Adaugă în „$script”';
  }

  @override
  String get subscriptionsTitle => 'Abonamente';

  @override
  String get subscriptionsNewsletters => 'Newslettere';

  @override
  String get subscriptionsDiscussions => 'Discuții';

  @override
  String get subscriptionsFilter => 'Filtrează';

  @override
  String get subscriptionsFilterNeverRead => 'Niciodată citite';

  @override
  String get subscriptionsFilterRarelyRead => 'Rar citite';

  @override
  String get subscriptionsFilterAll => 'Toate';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonamentele nu au putut fi numărate';

  @override
  String get subscriptionsNoMatches => 'Niciun rezultat';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Niciun newsletter nu se numește „$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nicio listă nu se numește „$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Niciun newsletter';

  @override
  String get subscriptionsNoNewslettersDetail => 'Newsletterele și alte e-mailuri în masă apar aici după ce sosesc.';

  @override
  String get subscriptionsNothingNeverRead => 'Nimic la „Niciodată citite”';

  @override
  String get subscriptionsNothingRarelyRead => 'Nimic la „Rar citite”';

  @override
  String get subscriptionsNothingFilteredDetail => 'Citești câte ceva din tot ce primești.';

  @override
  String get subscriptionsNoDiscussions => 'Nicio discuție';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Listele de e-mail la care poți scrie apar aici după ce sosesc e-mailurile lor.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Liste la care scriu mai multe persoane. Ține apăsat pe una ca s-o fixezi în Căsuțe poștale, s-o citești ca text simplu sau s-o muți la Newslettere.';

  @override
  String get subscriptionsPrivacyNote =>
      'Calculat pe acest telefon din e-mailurile pe care le-a descărcat; nu se trimite nimic nicăieri pentru asta. Loupe contactează un expeditor doar când atingi Dezabonează-te: dezabonarea dintr-un clic trimite doar „List-Unsubscribe=One-Click” la adresa indicată de expeditor, fără cookie-uri și fără nimic altceva despre tine, și nu îi încarcă niciodată paginile sau imaginile.';

  @override
  String get subscriptionsVolumeNone => 'Nimic în ultima vreme';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / lună';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / lună';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'citite $percent';
  }

  @override
  String get subscriptionsStillSending => 'Încă trimite';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Dezabonat pe $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Pagina de dezabonare deschisă pe $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'O atingere · contactează $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Prin e-mail la $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Pe site-ul $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Dezabonează-te';

  @override
  String get subscriptionsUnsubscribeAgain => 'Dezabonează-te din nou';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arhivează $countString din Inbox',
      few: 'Arhivează $countString din Inbox',
      one: 'Arhivează $countString din Inbox',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Creează o regulă…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mută sau arhivează e-mailurile viitoare';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratează ca discuție';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'O listă la care scriu oamenii: citește-o ca pe un forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratează ca newsletter';

  @override
  String get subscriptionsBlockSender => 'Blochează expeditorul';

  @override
  String get subscriptionsBlock => 'Blochează';

  @override
  String get subscriptionsBlocked => 'Blocat';

  @override
  String get subscriptionsBlockedDetail => 'E-mailurile noi ajung în Spam';

  @override
  String get subscriptionsPin => 'Fixează în Căsuțe poștale';

  @override
  String get subscriptionsUnpin => 'Anulează fixarea din Căsuțe poștale';

  @override
  String get subscriptionsOpenDefaultView => 'Deschide în vizualizarea implicită';

  @override
  String get subscriptionsOpenPlainText => 'Deschide ca text simplu (Mono)';

  @override
  String get subscriptionsPinned => 'Fixată';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString necitite',
      few: '$countString necitite',
      one: '$countString necitit',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Momentan nu există e-mailuri de la acest expeditor.';

  @override
  String get subscriptionsLatestMessages => 'ULTIMELE MESAJE';

  @override
  String get subscriptionsMail => 'E-mailuri';

  @override
  String get subscriptionsNoneIn90Days => 'Niciunul în 90 de zile';

  @override
  String get subscriptionsRead => 'Citite';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString din $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Ultimul primit';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Dosare', few: 'Dosare', one: 'Dosar');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Încă trimite';

  @override
  String get subscriptionsUnsubscribedTitle => 'Dezabonat';

  @override
  String subscriptionsSince(String date) {
    return 'din $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'pagină deschisă pe $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nu spune cum te poți dezabona.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nu spune cum te poți dezabona. Îl poți bloca în schimb.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Te dezabonezi de la $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Te-ai dezabonat de la $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Dezabonarea nu a reușit: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Dezabonarea automată nu a reușit';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Trimite e-mailul de dezabonare';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Deschide $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Deschizi $site?';
  }

  @override
  String get subscriptionsOpen => 'Deschide';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender gestionează dezabonarea pe site-ul său. Pagina se deschide în browserul Loupe; finalizează acolo.';
  }

  @override
  String get subscriptionsWebInsecure => 'Conexiunea la acest site nu este criptată.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Atenție: această adresă imită $site cu litere asemănătoare.';
  }

  @override
  String get subscriptionsHomographWarningUnknown => 'Atenție: această adresă imită alt site cu litere asemănătoare.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site nu a putut fi deschis.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe notează data de azi și te anunță dacă $sender continuă să-ți scrie.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Te dezabonezi de la $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe va contacta $site ca să te dezaboneze.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Este singura dată când Loupe contactează site-ul unui expeditor. Trimite doar „List-Unsubscribe=One-Click” la adresa indicată de $sender, fără cookie-uri și fără nimic altceva despre tine, și nu încarcă pagina.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Linkul de dezabonare nu este o adresă sigură de pe internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site nu a răspuns la timp.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site nu a putut fi contactat.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site a trimis cererea mai departe către altă pagină, pe care Loupe nu o urmează.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site a refuzat cererea (eroarea $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nu există niciun cont de pe care să fie trimis e-mailul de dezabonare.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe va trimite un e-mail la $to de pe $from, cu subiectul „$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-mailul de dezabonare a fost trimis la $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Blochezi $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'E-mailurile noi de pe această listă ajung în Spam. Poți schimba asta în Setări › Reguli.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'E-mailurile noi de la $address ajung în Spam. Poți schimba asta în Setări › Reguli.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender a fost blocat.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mută $count în Spam',
      few: 'Mută $count în Spam',
      one: 'Mută $count în Spam',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blochează $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender este acum la Newslettere.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender este acum la Discuții.';
  }

  @override
  String get appLiveGateTitle => 'Conturile tale nu au putut fi deschise';

  @override
  String get appLiveGateUnavailableBuild => 'Conturile reale nu sunt încă disponibile în această versiune.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nu a putut citi cheia care îți protejează e-mailurile pe acest telefon. De multe ori este o problemă temporară: încearcă din nou sau repornește telefonul.';

  @override
  String get appLiveGateKeyMissing =>
      'Cheia care îți protejează e-mailurile pe acest telefon a dispărut, lucru care se poate întâmpla după restaurarea unei copii de rezervă. E-mailurile tale sunt încă pe server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Baza de date cu e-mailuri de pe acest telefon nu poate fi citită: este deteriorată sau cheia ei s-a schimbat. E-mailurile tale sunt încă pe server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Ceva nu a mers bine la deschiderea conturilor tale ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Această acțiune șterge conturile și e-mailurile stocate pe acest telefon, inclusiv mesajele care așteaptă în Căsuța de ieșire. E-mailurile de pe servere nu sunt afectate; adaugă-ți din nou conturile după aceea.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Șterge și ia-o de la capăt';

  @override
  String get appLiveGateUseDemo => 'Folosește e-mailurile demo';

  @override
  String get appLiveGateReset => 'Resetează e-mailurile de pe acest telefon…';

  @override
  String get attachmentsUntitled => 'Atașament';

  @override
  String get attachmentsUntitledFile => 'Fără titlu';

  @override
  String get attachmentsOpenIn => 'Deschide în…';

  @override
  String get attachmentsSaveToFiles => 'Salvează în fișiere';

  @override
  String get attachmentsShareMenu => 'Distribuie…';

  @override
  String get attachmentsDownloadError =>
      'Atașamentul nu a putut fi descărcat. Verifică conexiunea și încearcă din nou.';

  @override
  String get attachmentsShareError => 'Atașamentul nu a putut fi distribuit.';

  @override
  String attachmentsNoApp(String type) {
    return 'Nicio aplicație de pe acest dispozitiv nu deschide acest fișier ($type). Încearcă Distribuie.';
  }

  @override
  String get attachmentsOpenInError => 'Atașamentul nu a putut fi deschis în altă aplicație.';

  @override
  String attachmentsSaved(String name) {
    return '„$name” a fost salvat';
  }

  @override
  String get attachmentsSaveError => 'Atașamentul nu a putut fi salvat.';

  @override
  String get attachmentsGone => 'Acest atașament nu mai este disponibil.';

  @override
  String get attachmentsDownloadFailed => 'Atașamentul nu a putut fi descărcat.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de pagini',
      few: '$count pagini',
      one: '$count pagină',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size prin date mobile';
  }

  @override
  String get attachmentsLargeDownload => 'Acest atașament este mare. Descarcă-l acum sau mai târziu prin Wi-Fi.';

  @override
  String get attachmentsDownload => 'Descarcă';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Se descarcă $size…';
  }

  @override
  String get attachmentsDownloading => 'Se descarcă…';

  @override
  String get attachmentsTooLarge => 'Prea mare pentru previzualizare aici.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Se afișează primii $shown din $total. Copiază, distribuie sau salvează ca să-l obții integral.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Acest PDF nu poate fi afișat aici (poate fi protejat cu parolă).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page din $count';
  }

  @override
  String get attachmentsModeTable => 'Tabel';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Mesaj';

  @override
  String get attachmentsModeSource => 'Sursă';

  @override
  String get attachmentsDontWrap => 'Nu încadra rândurile';

  @override
  String get attachmentsWrap => 'Încadrează rândurile';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines de rânduri',
      few: '$lines rânduri',
      one: '$lines rând',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copiază tot';

  @override
  String get attachmentsCopied => 'Copiat';

  @override
  String get attachmentsImageUnavailable => 'Această imagine nu poate fi afișată aici. Încearcă Deschide în….';

  @override
  String get attachmentsEmlNoSubject => '(Fără subiect)';

  @override
  String get attachmentsEmlFrom => 'De la';

  @override
  String get attachmentsEmlTo => 'Către';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Dată';

  @override
  String get attachmentsEmlNoText => 'Acest mesaj nu are text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atașamente: $names',
      few: 'Atașamente: $names',
      one: 'Atașament: $names',
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
      other: 'Și încă $count de evenimente',
      few: 'Și încă $count evenimente',
      one: 'Și încă un eveniment',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imagine';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imagine $format';
  }

  @override
  String get attachmentsTypePdf => 'Document PDF';

  @override
  String get attachmentsTypeTsv => 'Valori separate prin tabulatori';

  @override
  String get attachmentsTypeCsv => 'Foaie de calcul CSV';

  @override
  String get attachmentsTypeCalendar => 'Eveniment din calendar';

  @override
  String get attachmentsTypeEmail => 'Mesaj de e-mail';

  @override
  String get attachmentsTypeContact => 'Carte de vizită';

  @override
  String get attachmentsTypeLog => 'Fișier jurnal';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'Arhivă ZIP';

  @override
  String get attachmentsTypeArchive => 'Arhivă';

  @override
  String get attachmentsTypeWord => 'Document Word';

  @override
  String get attachmentsTypeExcel => 'Foaie de calcul Excel';

  @override
  String get attachmentsTypePowerPoint => 'Prezentare PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Pagină web';

  @override
  String get attachmentsTypeVideo => 'Videoclip';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Fișier $extension';
  }

  @override
  String get attachmentsTypeFile => 'Fișier';

  @override
  String get calendarUntitledEvent => 'Eveniment';

  @override
  String get calendarAllDay => 'Toată ziua';

  @override
  String calendarYourTime(String time) {
    return '$time ora ta';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Participă: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a acceptat: $details',
      'tentative': '$name a acceptat provizoriu: $details',
      'declined': '$name a refuzat: $details',
      'delegated': '$name a delegat: $details',
      'other': '$name nu a răspuns la: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a acceptat invitația',
      'tentative': '$name a acceptat provizoriu invitația',
      'declined': '$name a refuzat invitația',
      'delegated': '$name a delegat invitația',
      'other': '$name nu a răspuns la invitație',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Hartă';

  @override
  String get calendarJoin => 'Participă';

  @override
  String get calendarOnlineMeeting => 'Întâlnire online';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Întâlnire $provider';
  }

  @override
  String get calendarOrganizerYou => 'Tu';

  @override
  String get calendarOrganizerLabel => 'organizator';

  @override
  String get calendarStatusAccepted => 'Acceptat';

  @override
  String get calendarStatusMaybe => 'Poate';

  @override
  String get calendarStatusDeclined => 'Refuzat';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a acceptat',
      'tentative': '$name a acceptat provizoriu',
      'declined': '$name a refuzat',
      'delegated': '$name a delegat',
      'other': '$name nu a răspuns',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a acceptat:',
      'tentative': '$name a acceptat provizoriu:',
      'declined': '$name a refuzat:',
      'delegated': '$name a delegat:',
      'other': '$name nu a răspuns:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name propune o oră nouă';
  }

  @override
  String get calendarCounterUnknown => 'Un participant propune o oră nouă';

  @override
  String get calendarDeclineCounter => 'Organizatorul a păstrat ora';

  @override
  String calendarRefresh(String name) {
    return '$name cere cea mai recentă versiune';
  }

  @override
  String get calendarRefreshUnknown => 'Un participant cere cea mai recentă versiune';

  @override
  String get calendarCancelled => 'Anulat';

  @override
  String get calendarCancelledByOrganizer => 'Organizatorul a anulat acest eveniment.';

  @override
  String get calendarCancelledLater => 'Acest eveniment a fost anulat ulterior.';

  @override
  String get calendarOutdated => 'Depășit';

  @override
  String get calendarOutdatedDetail => 'Această invitație a fost actualizată ulterior; contează cea mai nouă.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Locație eliminată (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Locație eliminată (nu exista)';

  @override
  String calendarLocationChanged(String location) {
    return 'Locația s-a schimbat în $location';
  }

  @override
  String get calendarNewTitle => 'Titlu nou';

  @override
  String get calendarRepeatChanged => 'Repetarea s-a schimbat';

  @override
  String get calendarUpdated => 'Actualizat';

  @override
  String get calendarUpdatedInvitation => 'Invitație actualizată';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Ora s-a schimbat din $before în $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Fus orar „$zone” necunoscut: orele sunt afișate așa cum au fost scrise';
  }

  @override
  String calendarNext(String when) {
    return 'Următorul: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de invitați',
      few: '$count invitați',
      one: '$count invitat',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count au acceptat',
      few: '$count au acceptat',
      one: '$count a acceptat',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poate',
      few: '$count poate',
      one: '$count poate',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count au refuzat',
      few: '$count au refuzat',
      one: '$count a refuzat',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (tu)';
  }

  @override
  String get calendarAttendeeOptional => 'opțional';

  @override
  String get calendarAttendeeRoom => 'sală';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ai acceptat o versiune anterioară.',
      'tentative': 'Ai acceptat provizoriu o versiune anterioară.',
      'declined': 'Ai refuzat o versiune anterioară.',
      'delegated': 'Ai delegat o versiune anterioară.',
      'other': 'Nu ai răspuns la o versiune anterioară.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Acceptă';

  @override
  String get calendarMaybe => 'Poate';

  @override
  String get calendarDecline => 'Refuză';

  @override
  String get calendarCommentHint => 'Comentariu pentru organizator (opțional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Răspunsul tău ajunge la $organizer de pe $address.';
  }

  @override
  String get calendarAddComment => 'Adaugă un comentariu';

  @override
  String get calendarAddToCalendar => 'Adaugă în calendar';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Și încă $count de evenimente în fișier',
      few: 'Și încă $count evenimente în fișier',
      one: 'Și încă un eveniment în fișier',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Nu există nicio aplicație de calendar în care să adaugi evenimentul.';

  @override
  String get calendarCantOpenCalendar => 'Calendarul nu a putut fi deschis.';

  @override
  String get calendarCantOpenLink => 'Linkul nu a putut fi deschis.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Participi la întâlnirea $provider?';
  }

  @override
  String get calendarJoinTitle => 'Participi la întâlnire?';

  @override
  String calendarJoinOpens(String host) {
    return 'Deschide $host în browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Atenție: această adresă imită $site cu litere asemănătoare.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Atenție: această adresă imită alt site cu litere asemănătoare.';

  @override
  String calendarJoinOpen(String host) {
    return 'Deschide $host';
  }

  @override
  String get calendarNoOrganizer => 'Această invitație nu are un organizator căruia să-i răspunzi.';

  @override
  String get calendarNoAccount => 'Nu există niciun cont de pe care să răspunzi.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Acceptat', 'tentative': 'Poate', 'other': 'Refuzat'});
    return '$_temp0 · se trimite răspunsul către $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Acceptat', 'tentative': 'Poate', 'other': 'Refuzat'});
    return '$_temp0 · răspuns trimis';
  }

  @override
  String get calendarReplyAlreadySent => 'Răspunsul a fost deja trimis.';

  @override
  String get calendarReplyNotSent => 'Răspunsul nu a fost trimis.';

  @override
  String get dataSmimeNeedsDevice =>
      'Certificatul tău S/MIME este pe acest dispozitiv: deschide Loupe ca să semnezi și să trimiți acest mesaj.';

  @override
  String dataSigningFailed(String error) {
    return 'Semnarea nu a reușit: $error';
  }

  @override
  String get keyboardShortcuts => 'Scurtături de tastatură';

  @override
  String get keyboardGroupGeneral => 'General';

  @override
  String get keyboardGroupMessages => 'Mesaje';

  @override
  String get keyboardGroupCompose => 'Scriere';

  @override
  String get keyboardCommandPalette => 'Paleta de comenzi';

  @override
  String get keyboardBackClose => 'Înapoi, închide';

  @override
  String get keyboardNextMessage => 'Mesajul următor';

  @override
  String get keyboardPreviousMessage => 'Mesajul anterior';

  @override
  String get keyboardOpenMessage => 'Deschide mesajul';

  @override
  String get keyboardMoveToTrash => 'Mută în Coșul de gunoi';

  @override
  String get keyboardToggleRead => 'Marchează ca citit sau necitit';

  @override
  String get keyboardToggleFlag => 'Pune sau elimină stegulețul';

  @override
  String get keyboardCloseDraft => 'Închide (salvează sau șterge ciorna)';

  @override
  String get keyboardOr => 'sau';

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
  String get mailingListsMuted => 'Fir ignorat. Mesajele noi din el sosesc deja citite.';

  @override
  String get mailingListsUnmuted => 'Firul nu mai este ignorat.';

  @override
  String get mailingListsMuteThread => 'Ignoră firul';

  @override
  String get mailingListsUnmuteThread => 'Nu mai ignora firul';

  @override
  String get mailingListsPin => 'Fixează în Căsuțe poștale';

  @override
  String get mailingListsUnpin => 'Anulează fixarea din Căsuțe poștale';

  @override
  String get mailingListsDefaultView => 'Deschide în vizualizarea implicită';

  @override
  String get mailingListsPlainText => 'Deschide ca text simplu (Mono)';

  @override
  String get mailingListsShowMuted => 'Afișează firele ignorate';

  @override
  String get mailingListsHideMuted => 'Ascunde firele ignorate';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratează ca newsletter';

  @override
  String get mailingListsOptions => 'Opțiunile listei';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted necitite',
      one: '$formatted necitit',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Mesaj nou către listă';

  @override
  String get mailingListsRowUnread => 'Necitit';

  @override
  String get mailingListsRowMuted => 'Ignorat';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de răspunsuri',
      few: '$count răspunsuri',
      one: '$count răspuns',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Niciun fir';

  @override
  String get mailingListsMutedHidden => 'Firele ignorate sunt ascunse.';

  @override
  String get mailingListsTechnicalTitle => 'Liste tehnice';

  @override
  String get mailingListsTechnicalEmpty => 'Listele de e-mail apar aici după ce sosesc e-mailurile lor.';

  @override
  String get mailingListsTechnicalFooter =>
      'Mesajele din aceste liste se deschid ca text simplu, cu font monospațiat, iar patch-urile sunt afișate ca diff-uri. Butonul Aa schimbă în continuare vizualizarea oricărui mesaj.';

  @override
  String get paletteMoveToMailbox => 'Mută în căsuța poștală…';

  @override
  String get paletteMarkAllRead => 'Marchează tot ca citit';

  @override
  String get paletteExportFolder => 'Exportă dosarul…';

  @override
  String get paletteGetNewMail => 'Preia e-mailurile noi';

  @override
  String get paletteSnoozed => 'Amânate';

  @override
  String get paletteSubscriptions => 'Abonamente';

  @override
  String get paletteDiscussions => 'Discuții';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Listă de e-mail';

  @override
  String get paletteTag => 'Etichetă';

  @override
  String get paletteSwipeActions => 'Acțiuni de glisare';

  @override
  String get paletteNotifications => 'Notificări';

  @override
  String get paletteRules => 'Reguli';

  @override
  String get paletteEncryption => 'Criptare end-to-end';

  @override
  String get paletteAdvanced => 'Avansate';

  @override
  String get paletteAddAccount => 'Adaugă un cont';

  @override
  String get paletteAccount => 'Cont';

  @override
  String get paletteFolders => 'Dosare';

  @override
  String get paletteRecentSearch => 'Căutare recentă';

  @override
  String paletteSearchMail(String query) {
    return 'Caută „$query” în e-mailuri';
  }

  @override
  String get palettePlaceholder => 'Caută acțiuni, căsuțe poștale, setări';

  @override
  String get paletteNothingFound => 'Nu s-a găsit nimic';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox nou';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Afișează tot ce se potrivește cu „$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name” a fost salvat în Căsuțe poștale';
  }

  @override
  String get searchMakeRule => 'Transformă în regulă';

  @override
  String get searchSaveSmartMailbox => 'Salvează ca Smart Mailbox';

  @override
  String get searchNegate => 'Neagă';

  @override
  String get searchDontNegate => 'Nu nega';

  @override
  String get searchAllMailboxes => 'Toate căsuțele poștale';

  @override
  String get searchRecent => 'Căutări recente';

  @override
  String get searchClear => 'Șterge';

  @override
  String get searchSuggestions => 'Sugestii';

  @override
  String get searchUnreadMessages => 'Mesaje necitite';

  @override
  String get searchFlaggedMessages => 'Mesaje cu steguleț';

  @override
  String get searchWithAttachments => 'Mesaje cu atașamente';

  @override
  String get searchUnrepliedMessages => 'Mesaje fără răspuns';

  @override
  String get searchTags => 'Etichete';

  @override
  String get searchPeople => 'Persoane';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De la: $name';
  }

  @override
  String get searchSearching => 'Se caută…';

  @override
  String get searchNoResults => 'Niciun rezultat';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted de rezultate',
      few: '$formatted rezultate',
      one: '$formatted rezultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Meniul căutării';

  @override
  String searchSearchingAccount(String account) {
    return 'Se caută în $account pe server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Se caută în cont pe server…';

  @override
  String searchAccountFailed(String account) {
    return 'Căutarea în $account pe server nu a reușit';
  }

  @override
  String get searchUnknownAccountFailed => 'Căutarea în cont pe server nu a reușit';

  @override
  String searchChip(String term) {
    return '$term. Atinge de două ori ca să editezi.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nu $term. Atinge de două ori ca să editezi.';
  }

  @override
  String get searchReadAndUnread =>
      'Inboxul lui Schrödinger: fiecare mesaj de aici este citit și necitit până când îl deschizi.';

  @override
  String searchContradiction(String term) {
    return 'Niciun mesaj nu poate fi „$term” și totodată nu.';
  }

  @override
  String get searchSyncDeviceOnly => 'Doar pe acest dispozitiv';

  @override
  String searchSyncUnsupported(String account) {
    return 'Doar pe acest dispozitiv: $account nu îl poate păstra';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nesincronizat: $account are un format mai nou';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Se așteaptă sincronizarea cu $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronizat cu $account';
  }

  @override
  String get searchRename => 'Redenumește';

  @override
  String get searchEditSearch => 'Editează căutarea';

  @override
  String get searchDeleteSmartMailbox => 'Șterge Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Redenumește Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Acest Smart Mailbox a fost șters.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes rămân pe acest dispozitiv.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes sunt păstrate pe serverul tău de e-mail, așa că le au și celelalte dispozitive, precum și Thunderbird cu Expression Search Reloaded. Cele care caută în toate conturile sunt păstrate în $account; cele ale unui dosar, în contul acelui dosar.';
  }

  @override
  String get searchSyncVia => 'Sincronizează prin';

  @override
  String get searchSyncViaFooter => 'Alege același cont pe toate dispozitivele.';

  @override
  String get searchGmailCantKeep => 'Gmail nu poate păstra Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Păstrează Smart Mailboxes doar pe acest dispozitiv';

  @override
  String get searchOnTheServer => 'Pe server';

  @override
  String get searchServerFooter =>
      'Metadatele serverului (IMAP METADATA) nu apar în nicio aplicație de e-mail. Serverele care nu le acceptă primesc un dosar „Loupe Settings” care conține un mesaj; Loupe îl ascunde din Căsuțe poștale.';

  @override
  String get searchSyncNow => 'Sincronizează acum';

  @override
  String get searchStateUnsupported => 'Neacceptat';

  @override
  String get searchStateNewerFormat => 'Format mai nou';

  @override
  String get searchStateFailed => 'Sincronizarea nu a reușit';

  @override
  String get searchStateSyncing => 'Se sincronizează…';

  @override
  String get searchStateWaiting => 'În așteptare';

  @override
  String get searchStateMetadata => 'Metadatele serverului';

  @override
  String get searchStateFolder => 'Dosarul Loupe Settings';

  @override
  String get searchStateNothing => 'Nimic stocat';

  @override
  String get sharedBack => 'Înapoi';

  @override
  String get sharedYesterday => 'Ieri';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, la $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de byți',
      few: '$count byți',
      one: '$count byte',
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
  String get sharedSyncNoAccounts => 'Niciun cont';

  @override
  String get sharedSyncChecking => 'Se caută e-mailuri…';

  @override
  String get sharedSyncFailed => 'Căutarea e-mailurilor nu a reușit';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Actualizat chiar acum';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Actualizat acum $minutes de minute',
      few: 'Actualizat acum $minutes minute',
      one: 'Actualizat acum $minutes minut',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Actualizat la $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Actualizat pe $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Toate inboxurile';

  @override
  String get sharedMailboxUnread => 'Necitite';

  @override
  String get sharedMailboxFlagged => 'Cu steguleț';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Toate ciornele';

  @override
  String get sharedMailboxAllSent => 'Toate cele trimise';

  @override
  String get sharedMailboxUntitled => 'Căsuță poștală';

  @override
  String get sharedTagImportant => 'Important';

  @override
  String get sharedTagWork => 'Serviciu';

  @override
  String get sharedTagPersonal => 'Personal';

  @override
  String get sharedTagToDo => 'De făcut';

  @override
  String get sharedTagLater => 'Mai târziu';

  @override
  String get sharedTags => 'Etichete';

  @override
  String get sharedMoveTo => 'Mută în…';

  @override
  String get sharedNoRecipients => 'Niciun destinatar';

  @override
  String get sharedUnknownSender => 'Expeditor necunoscut';

  @override
  String get sharedOnServer => 'Pe server';

  @override
  String get sharedAttachment => 'Atașament';

  @override
  String get sharedSnoozedBadge => 'Amânat';

  @override
  String get sharedRowUnread => 'Necitit';

  @override
  String get sharedRowBackFromSnooze => 'Revenit după amânare';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Cu steguleț';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje arhivate',
      few: '$count mesaje arhivate',
      one: '$count mesaj arhivat',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje șterse',
      few: '$count mesaje șterse',
      one: '$count mesaj șters',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje mutate în Inbox',
      few: '$count mesaje mutate în Inbox',
      one: '$count mesaj mutat în Inbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje mutate în Coșul de gunoi',
      few: '$count mesaje mutate în Coșul de gunoi',
      one: '$count mesaj mutat în Coșul de gunoi',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje mutate în Spam',
      few: '$count mesaje mutate în Spam',
      one: '$count mesaj mutat în Spam',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje mutate în $mailbox',
      few: '$count mesaje mutate în $mailbox',
      one: '$count mesaj mutat în $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje mutate în căsuța poștală',
      few: '$count mesaje mutate în căsuța poștală',
      one: '$count mesaj mutat în căsuța poștală',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje amânate până la $time',
      few: '$count mesaje amânate până la $time',
      one: '$count mesaj amânat până la $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Amânat până la $time doar pe acest dispozitiv: serverul nu poate stoca orele de amânare.';
  }

  @override
  String get sharedMoveOneAccount => 'Selectează mesaje dintr-un singur cont ca să le muți.';

  @override
  String get sharedSnoozeTitle => 'Amână';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Schimbă ora amânării';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ștergi definitiv $count de mesaje?',
      few: 'Ștergi definitiv $count mesaje?',
      one: 'Ștergi definitiv acest mesaj?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Această acțiune nu poate fi anulată.';

  @override
  String get sharedDeletePermanently => 'Șterge definitiv';

  @override
  String get sharedSwipeRead => 'Citit';

  @override
  String get sharedSwipeUnread => 'Necitit';

  @override
  String get sharedSwipeInbox => 'Inbox';

  @override
  String get sharedSwipeDelete => 'Șterge';

  @override
  String get sharedTrash => 'Coș de gunoi';

  @override
  String get sharedSwipeSnooze => 'Amână';

  @override
  String get sharedWakeNow => 'Readu acum';

  @override
  String get sharedChangeSnoozeTime => 'Schimbă ora amânării…';

  @override
  String get sharedSnooze => 'Amână…';

  @override
  String get sharedTag => 'Etichetează…';

  @override
  String get sharedMoveMessage => 'Mută mesajul…';

  @override
  String get sharedNotJunk => 'Nu este spam';

  @override
  String get accountSetupTitle => 'Adaugă un cont';

  @override
  String get accountSetupTitleDone => 'Cont adăugat';

  @override
  String get accountSetupAddressTitle => 'Adaugă un cont de e-mail';

  @override
  String get accountSetupAddressText => 'Loupe găsește setările pentru majoritatea furnizorilor.';

  @override
  String get accountSetupNameHint => 'Numele tău';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'nume@example.com';

  @override
  String get accountSetupContinue => 'Continuă';

  @override
  String get accountSetupLookingUp => 'Se caută setările…';

  @override
  String get accountSetupImport => 'Importă din Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Introdu o adresă de e-mail validă.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nu s-au găsit setări pentru $domain. Introdu-le mai jos.';
  }

  @override
  String get accountSetupCheckServers => 'Verifică numele serverelor și porturile.';

  @override
  String get accountSetupEnterPassword => 'Introdu parola.';

  @override
  String get accountSetupConnecting => 'Se conectează…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Se așteaptă $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Pagina nu a putut fi deschisă.';

  @override
  String get accountSetupCouldNotSaveName => 'Numele nu a putut fi salvat.';

  @override
  String get accountSetupTrustCertificate => 'Ai încredere în acest certificat';

  @override
  String get accountSetupPasswordRequired => 'Obligatoriu';

  @override
  String get accountSetupShowPassword => 'Afișează parola';

  @override
  String get accountSetupHidePassword => 'Ascunde parola';

  @override
  String get accountSetupAppPassword => 'Parolă de aplicație';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Intrare · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Ieșire · SMTP';

  @override
  String get accountSetupSignIn => 'Conectează-te';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Conectează-te cu $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Folosește o parolă de aplicație';

  @override
  String get accountSetupUseAppPasswordInstead => 'Folosește în schimb o parolă de aplicație';

  @override
  String get accountSetupUseDifferentAddress => 'Folosește altă adresă';

  @override
  String get accountSetupHowToCreateAppPassword => 'Cum creezi o parolă de aplicație';

  @override
  String get accountSetupHowToCreateOne => 'Cum creezi una';

  @override
  String get accountSetupGoogleNote =>
      'Te conectezi pe pagina Google, iar Loupe nu îți vede niciodată parola. Permite-i lui Loupe să-ți citească, să-ți trimită și să-ți organizeze e-mailurile.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Conectează-te cu Google” nu este încă disponibil în această versiune. Te poți conecta în schimb cu o parolă de aplicație (necesită Verificarea în doi pași în Contul Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Creează o parolă de aplicație în Contul Google și lipește-o mai jos.';

  @override
  String get accountSetupMicrosoftNote =>
      'Te conectezi pe pagina Microsoft, iar Loupe nu îți vede niciodată parola. Funcționează pentru Outlook.com și Hotmail, precum și pentru conturile de serviciu sau de școală din Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Autentificarea Microsoft vine într-o versiune ulterioară. Conturile Outlook, Hotmail și Microsoft 365 au nevoie de ea: nu mai acceptă parole din aplicațiile de e-mail.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail necesită o parolă specifică aplicației, nu parola contului tău Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail necesită o parolă de aplicație, nu parola contului tău.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se conectează la Fastmail prin JMAP cu un token API: Settings › Privacy & Security › Manage API tokens, pentru JMAP, cu acces la e-mailuri și la trimitere.';

  @override
  String get accountSetupFastmailNote => 'Fastmail necesită o parolă de aplicație pentru aplicațiile de e-mail.';

  @override
  String get accountSetupServerSettings => 'Setările serverului';

  @override
  String get accountSetupSettingsNotFound => 'Negăsite automat';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Găsite prin $source';
  }

  @override
  String get accountSetupEditSettings => 'Editează setările';

  @override
  String get accountSetupSyncing => 'E-mailurile tale se sincronizează.';

  @override
  String get accountSetupDescription => 'Descriere';

  @override
  String get accountSetupDescriptionHint => 'Serviciu, Personal…';

  @override
  String get accountSetupColour => 'Culoare';

  @override
  String accountSetupColourNumber(int number) {
    return 'Culoarea $number';
  }

  @override
  String get accountSetupSaving => 'Se salvează…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nu și-a putut deschide baza de date cu e-mailuri pe acest telefon. Închide Loupe, deschide-o din nou și reîncearcă.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Ceva nu a mers bine ($error). Încearcă din nou.';
  }

  @override
  String get accountSetupSecurityNone => 'Niciuna';

  @override
  String get accountSetupProtocol => 'Protocol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Securitate';

  @override
  String get accountSetupUsername => 'Nume de utilizator';

  @override
  String get accountSetupUsernameHint => 'Adresa ta de e-mail';

  @override
  String get accountSetupNoEncryptionTitle => 'Te conectezi fără criptare?';

  @override
  String get accountSetupNoEncryptionText =>
      'Parola și fiecare mesaj ar circula ca text necriptat. Oricine din rețea, de exemplu dintr-o rețea Wi-Fi publică, le-ar putea citi. Folosește asta doar pentru un server din propria rețea.';

  @override
  String get accountSetupUseWithoutEncryption => 'Folosește fără criptare';

  @override
  String get accountSetupApiTokenRejected =>
      'Token API respins. Creează un token API Fastmail pentru JMAP, cu acces la e-mailuri, și lipește-l.';

  @override
  String get accountSetupAppPasswordRejected => 'Parolă respinsă. Folosește o parolă de aplicație, nu parola contului.';

  @override
  String get accountSetupPasswordRejected => 'Parolă respinsă. Verific-o și încearcă din nou.';

  @override
  String get accountSetupServerUnreachable =>
      'Serverul nu poate fi contactat. Verifică setările serverului și conexiunea.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certificatul serverului nu este de încredere. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Conectarea a fost anulată. Atinge „Conectează-te cu $provider” ca să încerci din nou.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe are nevoie de permisiune ca să-ți citească și să-ți trimită e-mailurile Gmail. Conectează-te din nou și permite accesul, cu caseta Gmail bifată.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe are nevoie de permisiune ca să-ți citească și să-ți trimită e-mailurile. Conectează-te din nou și acceptă permisiunile.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Organizația ta trebuie să aprobe Loupe înainte să o poți folosi cu acest cont. Roagă administratorul IT să acorde consimțământul de administrator pentru Loupe în Microsoft Entra ID, apoi încearcă din nou.';

  @override
  String get accountSetupOAuthBlocked =>
      'Regulile de autentificare ale organizației tale nu permit Loupe pe acest dispozitiv. Adresează-te administratorului IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider nu a putut fi contactat. Verifică conexiunea la internet și încearcă din nou.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Conectarea cu $provider nu este configurată corect în această versiune Loupe. Te rugăm să raportezi problema.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Conectarea cu $provider nu a reușit. Încearcă din nou.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider te-a conectat, dar Gmail a refuzat accesul pentru această adresă. Alege același cont când te conectezi. La conturile de serviciu sau de școală, este posibil ca administratorul să fi dezactivat IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider te-a conectat, dar serverul de e-mail a refuzat accesul pentru această adresă. Alege același cont când te conectezi. La conturile de serviciu sau de școală, este posibil ca administratorul să fi dezactivat IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Serverul de e-mail nu poate fi contactat. Verifică conexiunea și încearcă din nou.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Conectarea cu $provider nu este disponibilă în această versiune.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Te-ai conectat din nou. $account se sincronizează.';
  }

  @override
  String get accountSetupSignInAgain => 'Conectează-te din nou';

  @override
  String get accountSetupSigningIn => 'Se conectează…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider nu mai acceptă autentificarea Loupe pentru $email, așa că $account nu se sincronizează. Conectează-te din nou ca să primești e-mailurile.';
  }

  @override
  String get accountImportTitle => 'Importă din Thunderbird';

  @override
  String get accountImportPointCamera => 'Îndreaptă camera spre codul QR afișat de Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Scanate: $scanned din $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Scanate: $scanned din $total de coduri',
      few: 'Scanate: $scanned din $total coduri',
      one: 'Scanate: $scanned din $total cod',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de conturi până acum',
      few: '$count conturi până acum',
      one: '$count cont până acum',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Pe computer, deschide Thunderbird și alege Instrumente › Exportă pentru mobil. Selectează conturile, apoi scanează fiecare cod afișat. Codurile pot fi scanate în orice ordine.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuă cu $count de conturi',
      few: 'Continuă cu $count conturi',
      one: 'Continuă cu $count cont',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Lipește textul în schimb';

  @override
  String get accountImportStartOver => 'Ia-o de la capăt';

  @override
  String get accountImportDuplicateCode => 'Codul a fost deja adăugat.';

  @override
  String get accountImportRestarted =>
      'Acest cod provine dintr-un export nou, așa că codurile scanate anterior au fost puse deoparte.';

  @override
  String get accountImportNotThunderbird => 'Acesta nu este un cod de cont Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Acest cod provine dintr-o versiune mai nouă de Thunderbird. Actualizează Loupe ca să-l imporți.';

  @override
  String get accountImportDamaged => 'Acest cod Thunderbird nu a putut fi citit.';

  @override
  String get accountImportTooLarge => 'Acest cod este prea mare ca să fie un export Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Setările nu au putut fi deschise.';

  @override
  String get accountImportCameraOffTitle => 'Accesul la cameră este dezactivat';

  @override
  String get accountImportCameraOffText =>
      'Permite-i lui Loupe să folosească camera din Setări ca să scanezi codul sau lipește în schimb textul codului.';

  @override
  String get accountImportNoCameraTitle => 'Nicio cameră';

  @override
  String get accountImportNoCameraText => 'Loupe nu poate folosi o cameră aici. Lipește în schimb textul codului.';

  @override
  String get accountImportCameraFailedTitle => 'Camera nu a pornit';

  @override
  String get accountImportCameraFailedText => 'Încearcă din nou sau lipește în schimb textul codului.';

  @override
  String get accountImportOpenSettings => 'Deschide Setările';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de conturi găsite',
      few: '$count conturi găsite',
      one: '$count cont găsit',
      zero: 'Niciun cont găsit',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Niciunul dintre conturile din aceste coduri nu a putut fi citit.';

  @override
  String get accountImportChoose => 'Alege conturile pe care să le adaugi în Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Codurile $codes din $total nu au fost scanate, așa că nu apar conturile din ele.',
      few: 'Codurile $codes din $total nu au fost scanate, așa că nu apar conturile din ele.',
      one: 'Codul $codes din $total nu a fost scanat, așa că nu apar conturile din el.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes și $last';
  }

  @override
  String get accountImportScanMore => 'Scanează mai multe coduri';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count de conturi din coduri nu au putut fi citite. Pot folosi setări dintr-o versiune mai nouă de Thunderbird.',
      few:
          '$count conturi din coduri nu au putut fi citite. Pot folosi setări dintr-o versiune mai nouă de Thunderbird.',
      one: 'Un cont din coduri nu a putut fi citit. Poate folosi setări dintr-o versiune mai nouă de Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scanează din nou';

  @override
  String get accountImportAlreadyAdded => 'Un cont cu această adresă există deja în Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Te vei conecta cu $provider când contul este adăugat, ca în Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Adaugă contul cu o parolă de aplicație (necesită Verificarea în doi pași).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se conectează la Gmail prin Google. „Conectează-te cu Google” vine într-o versiune ulterioară; până atunci, adaugă contul cu o parolă de aplicație (necesită Verificarea în doi pași).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se conectează la acest cont în browser. Loupe nu poate face asta încă: folosește o parolă de aplicație, dacă furnizorul tău oferă una.';

  @override
  String get accountImportUnencrypted => 'Se conectează fără criptare. Folosește asta doar în propria rețea.';

  @override
  String get accountImportEnterAgain => 'Introdu-o din nou';

  @override
  String get accountImportAdded => 'Adăugat';

  @override
  String accountImportAdding(int index, int total) {
    return 'Se adaugă $index din $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Adaugă $count de conturi',
      few: 'Adaugă $count conturi',
      one: 'Adaugă $count cont',
      zero: 'Adaugă conturi',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Lipește textul exportului';

  @override
  String get accountImportPasteText => 'Lipește textul unui cod de export Thunderbird, câte un cod pe rând.';

  @override
  String get accountImportPop3 => 'Conturile POP3 nu sunt acceptate. Loupe păstrează e-mailurile pe server cu IMAP.';

  @override
  String get accountImportKerberos => 'Acest cont se conectează cu Kerberos, pe care Loupe nu îl acceptă.';

  @override
  String get accountImportNtlm => 'Acest cont se conectează cu NTLM, pe care Loupe nu îl acceptă.';

  @override
  String get accountImportClientCertificate =>
      'Acest cont se conectează cu un certificat de client, pe care Loupe nu îl acceptă încă.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Autentificarea Microsoft vine într-o versiune ulterioară. Conturile Outlook și Microsoft 365 nu mai acceptă parole din aplicațiile de e-mail.';

  @override
  String get accountImportEnterPassword => 'Introdu parola.';

  @override
  String get accountImportEnterAppPassword => 'Introdu parola de aplicație.';

  @override
  String get accountImportEnterApiToken => 'Introdu tokenul API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe nu a putut deschide spațiul de stocare a conturilor. Încearcă din nou mai târziu.';

  @override
  String get accountImportFailed => 'Contul nu a putut fi adăugat. Încearcă din nou sau adaugă-l manual.';

  @override
  String get composeNewMessageTitle => 'Mesaj nou';

  @override
  String get composeAttach => 'Atașează';

  @override
  String get composeSendLater => 'Trimite mai târziu';

  @override
  String composeSendAt(String time) {
    return 'Trimite $time';
  }

  @override
  String get composeSendHint => 'Apasă lung ca să trimiți mai târziu';

  @override
  String get composeNoAccount => 'Adaugă un cont ca să trimiți e-mailuri.';

  @override
  String get composeTo => 'Către:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, De la: $email';
  }

  @override
  String get composeFromLabel => 'De la:';

  @override
  String get composeSubjectLabel => 'Subiect:';

  @override
  String composeReplyTo(String address) {
    return 'Răspuns către: $address';
  }

  @override
  String get composeFrom => 'De la';

  @override
  String composeReplyFrom(String email) {
    return 'Răspunde de pe $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Trimite de pe $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Răspunzi de pe $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Trimiți de pe $email?';
  }

  @override
  String get composeDismiss => 'Închide';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nesalvată ca identitate · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Salvează ca identitate';

  @override
  String composeAliasSaved(String email) {
    return '$email a fost salvată ca identitate.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Adresă nevalidă $address';
  }

  @override
  String get composeOriginalNotFound => 'Mesajul original nu a putut fi găsit.';

  @override
  String get composeDraftNotFound => 'Ciorna nu a putut fi găsită.';

  @override
  String get composeAttachmentsLost => 'Atașamentele nu au putut fi recuperate. Adaugă-le din nou.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Unele atașamente nu au putut fi adăugate: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Atașamentele au în total $size; unele servere refuză mesajele atât de mari.';
  }

  @override
  String get composeAttachFailed => 'Fișierul nu a putut fi atașat.';

  @override
  String get composeInvalidAddressTitle => 'Adresă nevalidă';

  @override
  String composeInvalidAddress(String address) {
    return '„$address” nu este o adresă de e-mail validă.';
  }

  @override
  String get composeNoSubjectTitle => 'Fără subiect';

  @override
  String get composeNoSubjectText => 'Acest mesaj nu are subiect. Îl trimiți oricum?';

  @override
  String get composeSentBeforeChanges => 'A fost trimis înainte de modificările tale, care sunt salvate în Ciorne.';

  @override
  String composeScheduled(String time) {
    return 'Programat pentru $time';
  }

  @override
  String get composeSending => 'Se trimite…';

  @override
  String get composeSent => 'Trimis';

  @override
  String get composeSendFailed => 'Nu s-a putut trimite. Încearcă din nou.';

  @override
  String get composeAlreadySent => 'Deja trimis.';

  @override
  String get composeDiscardChanges => 'Renunță la modificări';

  @override
  String get composeSaveChanges => 'Salvează modificările';

  @override
  String get composeDeleteDraft => 'Șterge ciorna';

  @override
  String get composeSaveDraft => 'Salvează ciorna';

  @override
  String get composeDraftSaved => 'Ciorna a fost salvată';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Pe $date, la $time, $name a scris:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Pe $date, la $time, cineva a scris:';
  }

  @override
  String get composeForwardHeader => '---------- Mesaj redirecționat ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De la: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dată: $date, la $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Subiect: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Către: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Mai târziu azi';

  @override
  String get composeTomorrowMorning => 'Mâine dimineață';

  @override
  String get composeMondayMorning => 'Luni dimineață';

  @override
  String get composePickDateTime => 'Alege data și ora…';

  @override
  String get composeSendWithoutDelay => 'Trimite imediat';

  @override
  String composeSendTimeToday(String time) {
    return 'Azi, la $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Mâine, la $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day, la $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Azi $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Mâine $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Continui editarea ciornei?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Un mesaj nu a fost trimis când s-a închis Loupe.',
      'one': 'Un mesaj către $name nu a fost trimis când s-a închis Loupe.',
      'other': 'Un mesaj către $name și alții nu a fost trimis când s-a închis Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject” nu a fost trimis când s-a închis Loupe.',
      'one': '„$subject” către $name nu a fost trimis când s-a închis Loupe.',
      'other': '„$subject” către $name și alții nu a fost trimis când s-a închis Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Continuă editarea';

  @override
  String get composeRecoverySave => 'Salvează în Ciorne';

  @override
  String get composeRecoveryDiscard => 'Renunță';

  @override
  String get composeRecoverySaved => 'Salvat în Ciorne';

  @override
  String get outboxSectionFailed => 'Netrimise';

  @override
  String get outboxSectionSending => 'Se trimit';

  @override
  String get outboxSectionScheduled => 'Programate';

  @override
  String get outboxStatusQueued => 'Se trimite în curând';

  @override
  String get outboxStatusSending => 'Se trimite…';

  @override
  String get outboxStatusFailed => 'Netrimis';

  @override
  String get outboxNoRecipients => 'Niciun destinatar';

  @override
  String get outboxNoSubject => '(Fără subiect)';

  @override
  String get outboxSendingFailed => 'Trimiterea nu a reușit.';

  @override
  String get outboxEmptyTitle => 'Nimic de trimis';

  @override
  String get outboxEmptyText => 'Mesajele pe care le trimiți mai târziu așteaptă aici până le vine vremea.';

  @override
  String get outboxSendNow => 'Trimite acum';

  @override
  String get outboxReschedule => 'Reprogramează';

  @override
  String get outboxRescheduleMenu => 'Reprogramează…';

  @override
  String get outboxRescheduleTitle => 'Reprogramează';

  @override
  String outboxRescheduled(String time) {
    return 'Reprogramat pentru $time';
  }

  @override
  String get outboxCancel => 'Anulează';

  @override
  String get outboxCancelSending => 'Anulează trimiterea…';

  @override
  String get outboxCancelTitle => 'Anulezi trimiterea?';

  @override
  String get outboxMoveToDrafts => 'Mută în Ciorne';

  @override
  String get outboxDiscard => 'Renunță la mesaj';

  @override
  String get outboxMovedToDrafts => 'Mutat în Ciorne';

  @override
  String get outboxDiscarded => 'S-a renunțat la mesaj';

  @override
  String get outboxAlreadySent => 'Deja trimis.';

  @override
  String get outboxBeingSent => 'Acest mesaj se trimite acum.';

  @override
  String get outboxActionFailed => 'Nu a funcționat. Mesajul este încă în Căsuța de ieșire.';

  @override
  String get notificationsBadgeInboxes => 'Necitite din inboxuri';

  @override
  String get notificationsBadgeVip => 'Necitite de la VIP-uri';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'E-mailuri noi de la VIP-urile tale, din orice cont';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'E-mailuri noi în $email';
  }

  @override
  String get notificationsUnknownSender => 'Expeditor necunoscut';

  @override
  String get notificationsNoSubject => '(Fără subiect)';

  @override
  String get notificationsEncryptedMessage => 'Mesaj criptat';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Mesaj nou de la $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje noi',
      few: '$count mesaje noi',
      one: '$count mesaj nou',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Mesaje noi în $account';
  }

  @override
  String get platformInstantChannel => 'Livrare instantanee';

  @override
  String get platformInstantChannelDescription => 'Apare cât timp Loupe urmărește inboxurile pentru e-mailuri noi';

  @override
  String get platformInstantTitle => 'Se așteaptă e-mailuri noi';

  @override
  String get platformInstantText => 'Livrarea instantanee este activată';

  @override
  String get platformErrorBox => 'Ceva nu a mers bine la afișare. Întoarce-te și încearcă din nou.';

  @override
  String get welcomeTagline => 'E-mail simplu la suprafață\nși puternic în profunzime.';

  @override
  String get welcomeAccountsTitle => 'Toate conturile, un singur inbox liniștit';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail și orice server IMAP sau JMAP.';

  @override
  String get welcomeSearchTitle => 'O căutare care găsește';

  @override
  String get welcomeSearchText => 'Rezultate instantanee de pe telefon, apoi cele de pe server.';

  @override
  String get welcomePrivacyTitle => 'Gândită pentru confidențialitate';

  @override
  String get welcomePrivacyText => 'Fără urmărire. Imaginile externe rămân blocate până decizi tu altfel.';

  @override
  String get welcomeAddAccount => 'Adaugă un cont';

  @override
  String get welcomeImport => 'Importă din Thunderbird';

  @override
  String get welcomeTryDemo => 'Încearcă cu e-mailuri demo';
}
