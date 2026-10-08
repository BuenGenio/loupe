// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get commonAdd => 'Gehitu';

  @override
  String get commonCancel => 'Utzi';

  @override
  String get commonClose => 'Itxi';

  @override
  String get commonDelete => 'Ezabatu';

  @override
  String get commonDone => 'Eginda';

  @override
  String get commonEdit => 'Editatu';

  @override
  String get commonMore => 'Gehiago';

  @override
  String get commonMove => 'Mugitu';

  @override
  String get commonName => 'Izena';

  @override
  String get commonNone => 'Bat ere ez';

  @override
  String get commonOff => 'Desaktibatuta';

  @override
  String get commonOk => 'Ados';

  @override
  String get commonOn => 'Aktibatuta';

  @override
  String get commonOptional => 'Aukerakoa';

  @override
  String get commonPassword => 'Pasahitza';

  @override
  String get commonRemove => 'Kendu';

  @override
  String get commonRetry => 'Saiatu berriro';

  @override
  String get commonSave => 'Gorde';

  @override
  String get commonSearch => 'Bilatu';

  @override
  String get commonServer => 'Zerbitzaria';

  @override
  String get commonSettings => 'Ezarpenak';

  @override
  String get commonShare => 'Partekatu';

  @override
  String get commonTryAgain => 'Saiatu berriro';

  @override
  String get commonUndo => 'Desegin';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mezu', one: 'mezu $count');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Artxibatu';

  @override
  String get mailDelete => 'Ezabatu';

  @override
  String get mailFlag => 'Markatu';

  @override
  String get mailForward => 'Birbidali';

  @override
  String get mailMarkAsRead => 'Markatu irakurritzat';

  @override
  String get mailMarkAsUnread => 'Markatu irakurri gabetzat';

  @override
  String get mailMoveToJunk => 'Eraman zabor-postara';

  @override
  String get mailNewMessage => 'Mezu berria';

  @override
  String get mailNoSubject => 'Gairik ez';

  @override
  String get mailReply => 'Erantzun';

  @override
  String get mailReplyAll => 'Erantzun guztiei';

  @override
  String get mailSend => 'Bidali';

  @override
  String get mailUnflag => 'Kendu marka';

  @override
  String get mailboxArchive => 'Artxiboa';

  @override
  String get mailboxDrafts => 'Zirriborroak';

  @override
  String get mailboxInbox => 'Sarrera-ontzia';

  @override
  String get mailboxJunk => 'Zabor-posta';

  @override
  String get mailboxOutbox => 'Irteera-ontzia';

  @override
  String get mailboxSent => 'Bidalitakoak';

  @override
  String get mailboxTrash => 'Zakarrontzia';

  @override
  String get conversationSomethingWentWrong => 'Zerbait gaizki joan da. Saiatu berriro.';

  @override
  String get conversationReplyToList => 'Erantzun zerrendari';

  @override
  String get conversationReplyList => 'Erantzun zerrendari';

  @override
  String get conversationThreadMuted => 'Haria isilarazi da. Bertako mezu berriak irakurrita iritsiko dira.';

  @override
  String get conversationThreadUnmuted => 'Haria jada ez dago isilarazita.';

  @override
  String get conversationLinkFailed => 'Ezin izan da esteka ireki.';

  @override
  String get conversationGoneTitle => 'Mezurik ez';

  @override
  String get conversationGoneText => 'Mezu hau mugitu edo ezabatu egin da.';

  @override
  String get conversationMuted => 'Isilarazita';

  @override
  String get conversationReaderOptions => 'Irakurtzeko aukerak';

  @override
  String get conversationReaderOptionsHint => 'Testuaren tamaina eta ikuspegia';

  @override
  String get conversationTrash => 'Zakarrontzia';

  @override
  String get conversationReplyHint => 'Sakatu luze Erantzun guztiei eta Birbidali aukeretarako';

  @override
  String get conversationOfflineTitle => 'Konexiorik gabe zaude';

  @override
  String get conversationOfflineText =>
      'Elkarrizketa hau ez da deskargatu oraindik. Berriro konektatzen zarenean kargatuko da.';

  @override
  String get conversationErrorTitle => 'Ezin da mezu hau erakutsi';

  @override
  String get conversationErrorText => 'Zerbait gaizki joan da.';

  @override
  String get conversationOfflineBanner => 'Konexiorik gabe zaude';

  @override
  String get conversationNotUpdated => 'Eguneratu gabe';

  @override
  String get conversationMe => 'ni';

  @override
  String get conversationNoSender => '(igorlerik ez)';

  @override
  String get conversationNoRecipients => 'hartzailerik ez';

  @override
  String conversationRecipients(String names) {
    return 'nori: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'nori: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Nork';

  @override
  String get conversationHeaderTo => 'Nori';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Erantzun honi';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Segurtasuna';

  @override
  String get conversationVerifiedSender => 'Igorle egiaztatua';

  @override
  String get conversationUnverifiedSender => 'Igorle egiaztatu gabea';

  @override
  String get conversationLoadingMessage => 'Mezua kargatzen';

  @override
  String get conversationBodyError => 'Ezin izan da mezu hau kargatu.';

  @override
  String get conversationBodyOffline => 'Konexiorik gabe zaude. Berriro konektatzen zarenean kargatuko da mezua.';

  @override
  String get conversationOriginalHint => 'Hobeto ikusten da Jatorrizkoa ikuspegian';

  @override
  String get conversationShowOriginal => 'Erakutsi jatorrizkoa';

  @override
  String get conversationScrollToTop => 'Joan gora';

  @override
  String get conversationTagsMenu => 'Etiketak…';

  @override
  String get conversationMuteThread => 'Isilarazi haria';

  @override
  String get conversationUnmuteThread => 'Kendu hariaren isilarazpena';

  @override
  String get conversationMoveMenu => 'Mugitu…';

  @override
  String get conversationDeletePermanently => 'Ezabatu betiko';

  @override
  String get conversationMoveToTrash => 'Bota zakarrontzira';

  @override
  String get conversationNotJunk => 'Ez da zabor-posta';

  @override
  String get conversationShowAllHeaders => 'Erakutsi goiburu guztiak';

  @override
  String get conversationViewSource => 'Ikusi iturburua';

  @override
  String get conversationSaveAsFile => 'Gorde fitxategi gisa…';

  @override
  String get conversationShareAsFile => 'Partekatu fitxategi gisa…';

  @override
  String get conversationSearchFromMessageMenu => 'Bilatu mezu honetatik abiatuta…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiatu helbidea';

  @override
  String get conversationAddressCopied => 'Helbidea kopiatu da';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Bilatu $name igorlearen mezuak';
  }

  @override
  String get conversationTags => 'Etiketak';

  @override
  String get conversationAllHeaders => 'Goiburu guztiak';

  @override
  String get conversationCopyAll => 'Kopiatu dena';

  @override
  String get conversationHeadersCopied => 'Goiburuak kopiatu dira';

  @override
  String get conversationNoHeaders => 'Goibururik ez';

  @override
  String get conversationSearchFromMessageTitle => 'Bilatu mezu honetatik abiatuta';

  @override
  String conversationSearchFrom(String name) {
    return 'Nork: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Nori: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Gaia: «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Iturburua';

  @override
  String get conversationSourceCopied => 'Iturburua kopiatu da';

  @override
  String get conversationShareFailed => 'Ezin izan da mezua partekatu.';

  @override
  String get conversationWrapLines => 'Doitu lerroak';

  @override
  String get conversationDontWrapLines => 'Ez doitu lerroak';

  @override
  String get conversationSourceError => 'Ezin izan da iturburua kargatu.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Lehen $shown erakusten dira, $total guztira. Kopiatu edo partekatu osorik lortzeko.';
  }

  @override
  String get conversationAttachmentUntitled => 'Izengabea';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Ekintza gehiago: $name';
  }

  @override
  String get conversationMoveTo => 'Mugitu hona…';

  @override
  String get conversationMailboxesError => 'Ezin izan dira postontziak kargatu.';

  @override
  String get conversationReaderReadable => 'Irakurgarria';

  @override
  String get conversationReaderOriginal => 'Jatorrizkoa';

  @override
  String get conversationReaderPlain => 'Testu soila';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Mantendu jatorrizko koloreak';

  @override
  String get conversationReaderRemember => 'Gogoratu igorle honentzat';

  @override
  String get conversationSecurityPossiblePhishing => 'Balizko phishinga';

  @override
  String get conversationSecurityBeCareful => 'Kontuz';

  @override
  String get conversationSecurityVerified => 'Egiaztatua';

  @override
  String get conversationSecurityNoIssues => 'Ez da arazorik aurkitu';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jarraitzaile',
      one: 'jarraitzaile $count',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Zergatik den erakusten du';

  @override
  String get conversationPhishingBannerTitle => 'Mezu honek phishing itxura du';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Estekak eta irudiak desaktibatuta daude.';
  }

  @override
  String get conversationPhishingBannerText => 'Estekak eta irudiak desaktibatuta daude.';

  @override
  String get conversationPhishingWhy => 'Zergatik?';

  @override
  String get conversationPhishingShowAnyway => 'Erakutsi hala ere';

  @override
  String get conversationSecurityPhishingTitle => 'Honek phishing itxura du';

  @override
  String get conversationSecurityPhishingText => 'Hainbat zantzuk adierazten dute mezu hau ez dela dirudiena.';

  @override
  String get conversationSecurityCarefulTitle => 'Kontuz mezu honekin';

  @override
  String get conversationSecurityCarefulText => 'Badago bigarren begirada bat merezi duen zerbait.';

  @override
  String get conversationSecurityVerifiedText => 'Igorlea egiaztatuta dago, eta ez dago ezer susmagarririk.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ez dago ezer susmagarririk. Zure posta-zerbitzariak ez du esan igorlea egiaztatuta dagoen.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ez dago ezer susmagarririk.';

  @override
  String get conversationSecurityWhy => 'Zergatik';

  @override
  String get conversationSecurityPrivacy => 'Pribatutasuna';

  @override
  String get conversationSecurityNoTrackingPixels => 'Jarraipen-pixelik ez';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jarraipen-pixel kendu dira',
      one: 'jarraipen-pixel $count kendu da',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Mezu hau noiz ireki duzun jakinaraziko zioten igorleari.';

  @override
  String get conversationSecurityNoRemoteImages => 'Urruneko irudirik ez';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count urruneko irudi',
      one: 'urruneko irudi $count',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Kargatzen badituzu, igorleak jakingo du noiz irakurtzen duzun mezu hau, baita zure IP helbidea ere.';

  @override
  String get conversationSecurityNoClickTracking => 'Klik-jarraipenik ez';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'klik-jarraitzaileetatik pasatzen diren $count esteka',
      one: 'klik-jarraitzaileetatik pasatzen den esteka $count',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Hauek erregistratuko lukete zure klika: $services. Sakatu luze esteka bat haren helmuga zuzenean irekitzeko.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Xehetasun teknikoak';

  @override
  String get conversationSecurityCheckedLocally => 'Gailu honetan egiaztatua. Ez da ezer inora bidali.';

  @override
  String get conversationSecurityTrackersLabel => 'Jarraitzaileak';

  @override
  String get conversationSecurityImagesFrom => 'Irudien jatorria';

  @override
  String get conversationSecuritySenderHistory => 'Igorlearen historia';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'jasoak: $received, bidaliak: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Esteken helmuga';

  @override
  String get conversationSecurityHidden => 'Ezkutuan';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementu',
      one: 'elementu $elements',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters karaktere',
      one: 'karaktere $characters',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Igorlea ez dago egiaztatuta';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Zure posta-zerbitzariak ezin izan du berretsi mezu hau benetan $domain domeinutik datorrela.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Zure posta-zerbitzariak ezin izan du berretsi mezu hau benetan bere igorlearengandik datorrela.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Zure posta-zerbitzariak ezin izan du berretsi mezu hau $domain domeinutik datorrela. Ohikoa da posta-zerrendetan.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Zure posta-zerbitzariak ezin izan du berretsi mezu hau bere igorlearengandik datorrela. Ohikoa da posta-zerrendetan.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ez egin ezer horren arabera, espero ez bazenuen. Zalantzarik baduzu, jarri harremanetan igorlearekin beste bide batetik.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Beste domeinu batek sinatua';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Mezua $signer domeinuak sinatu du, ez $domain domeinuak. Posta-zerbitzuek horrela egiten dute, baina horrek ez du frogatzen nork idatzi duen.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Mezua beste domeinu batek sinatu du, ez $domain domeinuak. Posta-zerbitzuek horrela egiten dute, baina horrek ez du frogatzen nork idatzi duen.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Izenak beste helbide bat erakusten du';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Igorlearen izenean «$shown» jartzen du, baina mezua $email helbidetik dator.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fidatu helbideaz, ez izenaz.';

  @override
  String get conversationSecurityReplyToTitle => 'Erantzunak beste nonbaitera doaz';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Erantzuten baduzu, zure erantzuna $address helbidera joango da, ez $domain domeinura.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Egiaztatu helbidea informazio pertsonala duen ezer erantzun aurretik.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Zure izena erabiltzen du';

  @override
  String get conversationSecurityImpersonationTitle => 'Ezagutzen duzun norbaiten izena erabiltzen du';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return '«$name» izenarekin sinatuta dago, zure izena bezala, baina helbide berri batetik dator: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return '«$name» izenarekin sinatuta dago, zure VIP $knownName ($knownEmail) bezala, baina helbide berri batetik dator: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return '«$name» izenarekin sinatuta dago, $knownName ($knownEmail) bezala, baina helbide berri batetik dator: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Eta erantzunak beste helbide batera joango lirateke.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Dirua, kodeak edo fitxategiak eskatzen baditu, egiaztatu lehenik pertsona horrekin beste bide batetik.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Helbide ezaguna: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Helbide hau: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Igorle honen lehen mezua';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Ez duzu inoiz posta jaso $email helbidetik.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Kontuz oraindik ezagutzen ez duzun jendearen eskaerekin.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Itxura bereko letrak igorlearen helbidean';

  @override
  String get conversationSecurityLinkHomographTitle => 'Itxura bereko letrak esteka batean';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host helbideak alfabeto desberdinetako letrak nahasten ditu beste helbide bat imitatzeko.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host helbideak itxura bereko letrak erabiltzen ditu: ez da $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Ezabatu, edo salatu zabor-posta gisa.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ez ireki.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domeinua: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Benetakoaren itxura duen domeinua';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Izen ezagun bat erabiltzen du domeinuan';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain zure domeinuaren ($real) antzekoa da, baina beste domeinu bat da.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain domeinuak $brand ($real) dirudi, baina beste domeinu bat da.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain domeinuak zure domeinuaren izena ($real) erabiltzen du, baina ez da zurea.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain domeinuak $brand ($real) izena erabiltzen du, baina ez da haiena.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Zure erakundearen benetako mezuak $real domeinutik datoz.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return '$brand markaren benetako mezuak $real domeinutik datoz.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Igorlearen domeinua: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imitatzen du: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estekak ezkutatu egiten dute nora doazen',
      one: 'Esteka batek ezkutatu egiten du nora doan',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Esteka batek $shown erakusten du, baina $host irekitzen du.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ez hasi saioa eta ez ordaindu esteka hauen bidez. Idatzi helbidea zuk zeuk.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Ezin da egiaztatu esteka baten helmuga';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Esteka batek $shown erakusten du, baina $host zerbitzaritik pasatzen da, eta horrek klika erregistratzen du aurrera bidali aurretik.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Esteka bat IP helbide huts batera doa';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts ez da izena duen webgune bat. Benetako enpresek oso gutxitan egiten dituzte horrelako estekak.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Esteka mozorrotua';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Esteka bat «$shown@» testuarekin hasten da $shown dela emateko, baina $host irekitzen du.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Orri ezkutu bat desgaitu da';

  @override
  String get conversationSecurityDataLinkText =>
      'Esteka batek mezuaren barruan bildutako orri bat irekiko zuen, esteken egiaztapena saihesteko modu bat.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Pasahitz bat eskatzen du';

  @override
  String get conversationSecurityPasswordFieldText => 'Mezuak pasahitz-eremu bat zuen. Loupe-k kendu egin du.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Ez idatzi inoiz pasahitzik mezu elektroniko batean.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Kodea exekutatzen duen esteka bat desgaitu da';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe-k ez du inoiz mezuetako koderik exekutatzen.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Esteka laburtuak',
      one: 'Esteka laburtu bat',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts zerbitzuak benetako helmuga ezkutatzen du ireki arte.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Web-helbide internazionala';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts helbideak latinoak ez diren letrak erabiltzen ditu. Normala da hizkuntza askotan; egiaztatu espero duzun webgunea dela.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Testu ezkutu asko';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Testu ikusezineko $count karaktere kendu dira. Horrelako testu ezkutuak spam-iragazkiak engainatzeko dira.',
      one: 'Testu ikusezineko karaktere $count kendu da. Horrelako testu ezkutuak spam-iragazkiak engainatzeko dira.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Testu ezkutua kendu da';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Testu ikusezineko $count karaktere kendu dira.',
      one: 'Testu ikusezineko karaktere $count kendu da.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Ezin izan da mezua deskargatu. Egiaztatu konexioa eta saiatu berriro.';

  @override
  String exportSaved(String name) {
    return '«$name» gorde da';
  }

  @override
  String get exportSaveFailed => 'Ezin izan da mezua gorde.';

  @override
  String exportFailed(String folder) {
    return 'Ezin izan da «$folder» esportatu.';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» karpetak ez du esportatzeko mezurik.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Ezin izan da «$folder» esportatu: ezin izan da mezurik deskargatu. Egiaztatu konexioa eta saiatu berriro.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '«$name» gorde da, deskargatu ezin izan diren $formattedCount mezu gabe.',
      one: '«$name» gorde da, deskargatu ezin izan den mezu $count gabe.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Ezin izan da «$name» gorde.';
  }

  @override
  String exportTitle(String folder) {
    return '«$folder» esportatzen';
  }

  @override
  String get exportListing => 'Mezuak bilatzen…';

  @override
  String exportProgress(String current, String total) {
    return '$current/$total esportatzen…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ezin izan dira $formattedCount mezu deskargatu',
      one: 'Ezin izan da mezu $count deskargatu',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postontziak';

  @override
  String get mailboxesShown => 'Ikusgai';

  @override
  String get mailboxesHidden => 'Ezkutatuta';

  @override
  String get mailboxesCollapse => 'Tolestu';

  @override
  String get mailboxesExpand => 'Zabaldu';

  @override
  String get mailboxesManageVips => 'Kudeatu VIPak';

  @override
  String get mailboxesSubscriptions => 'Harpidetzak';

  @override
  String mailboxesShowAccount(String account) {
    return 'Erakutsi $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ezkutatu $account';
  }

  @override
  String get mailboxesExportFolder => 'Esportatu karpeta…';

  @override
  String get mailboxesUnpin => 'Desainguratu';

  @override
  String get mailboxesLists => 'Zerrendak';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Gorde bilaketa bat hemen edukitzeko.';

  @override
  String get mailboxesTags => 'Etiketak';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Mezu bateko igorlearen izena ere saka dezakezu, eta VIP aktibatu.';

  @override
  String get mailboxesAddVip => 'Gehitu VIPa…';

  @override
  String get mailboxesAddVipTitle => 'Gehitu VIPa';

  @override
  String get mailboxesAddVipText => 'Helbide honetako mezuek izar bat izango dute eta VIP postontzian agertuko dira.';

  @override
  String get mailboxesAddVipPlaceholder => 'izena@example.com';

  @override
  String get messageListFilterUnread => 'Irakurri gabeak';

  @override
  String get messageListFilterFlagged => 'Markatuak';

  @override
  String get messageListFilterToMe => 'Nori: ni';

  @override
  String get messageListFilterCcMe => 'Cc: ni';

  @override
  String get messageListFilterWithAttachments => 'Eranskinekin';

  @override
  String get messageListFilterUnreplied => 'Erantzun gabeak';

  @override
  String get messageListFilterFromVips => 'VIPengandik';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu irakurritzat markatu dira',
      one: 'Mezu $count irakurritzat markatu da',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Ezin izan da posta zaharragoa kargatu.';

  @override
  String get messageListSelectMessages => 'Hautatu mezuak';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hautatuta',
      one: '$count hautatuta',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Hautatu guztiak';

  @override
  String get messageListDeselectAll => 'Desautatu guztiak';

  @override
  String get messageListLoadFailed => 'Ezin izan da posta kargatu';

  @override
  String get messageListNoUnread => 'Ez dago irakurri gabeko postarik';

  @override
  String get messageListNoMatches => 'Ez dago bat datorren postarik';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Iragazkiak: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Desaktibatu iragazkia';

  @override
  String get messageListEmpty => 'Postarik ez';

  @override
  String get messageListFilter => 'Iragazi';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Iragazki-irizpideak: $filters';
  }

  @override
  String get messageListFilteredBy => 'Iragazkiak:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount irakurri gabe',
      one: '$count irakurri gabe',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markatu';

  @override
  String get messageListTrash => 'Zakarrontzia';

  @override
  String get messageListFilterTitle => 'Iragazkia';

  @override
  String get messageListFilterInclude => 'BARNE HARTU';

  @override
  String get panesHideMailboxes => 'Ezkutatu postontziak';

  @override
  String get panesShowMailboxes => 'Erakutsi postontziak';

  @override
  String get panesMailboxesWidth => 'Postontzien zabalera';

  @override
  String get panesListWidth => 'Mezu-zerrendaren zabalera';

  @override
  String get panesNoMessageSelected => 'Ez da mezurik hautatu';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mezu', one: 'Mezu $count');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Atzeratuak';

  @override
  String get snoozeSheetTitle => 'Atzeratu';

  @override
  String get snoozeLaterToday => 'Gaur beranduago';

  @override
  String get snoozeThisEvening => 'Gaur arratsean';

  @override
  String get snoozeTomorrow => 'Bihar';

  @override
  String get snoozeThisWeekend => 'Asteburu honetan';

  @override
  String get snoozeNextWeek => 'Hurrengo astean';

  @override
  String get snoozePickDateTime => 'Aukeratu data eta ordua…';

  @override
  String get snoozeMenu => 'Atzeratu…';

  @override
  String get snoozeWakeNow => 'Ekarri orain';

  @override
  String get snoozeChangeTimeMenu => 'Aldatu atzeratze-ordua…';

  @override
  String get snoozeChangeTime => 'Aldatu ordua';

  @override
  String get snoozeNoTime => 'Ez da ordurik ezarri';

  @override
  String get snoozeFooter => 'Atzeratutako mezuak Sarrera-ontzira itzultzen dira, irakurri gabe, ezarritako orduan.';

  @override
  String get snoozeEmptyTitle => 'Ez dago ezer atzeratuta';

  @override
  String get snoozeEmptyText => 'Atzeratu mezu bat, behar duzunean Sarrera-ontzira itzul dadin.';

  @override
  String get appLockUnlock => 'Desblokeatu';

  @override
  String get appLockFailed => 'Loupe-k ezin izan du berretsi zu zarela.';

  @override
  String get appLockLockedOut => 'Saiakera gehiegi. Saiatu berriro geroago.';

  @override
  String get appLockPromptError => 'Ezin izan da eskaera erakutsi. Saiatu berriro.';

  @override
  String get appLockNoScreenLock => 'Telefono honek ez du pantailaren blokeorik.';

  @override
  String get appLockUnlockPromptTitle => 'Desblokeatu Loupe';

  @override
  String get appLockUnlockPromptReason => 'Berretsi zu zarela zure posta ikusteko.';

  @override
  String get appLockTurnOnPromptTitle => 'Aktibatu aplikazio-blokeoa';

  @override
  String get appLockTurnOnPromptReason => 'Berretsi zu zarela aplikazio-blokeoa aktibatzeko.';

  @override
  String get appLockScreenLockRemoved =>
      'Aplikazio-blokeoa desaktibatuta dago: telefono honek jada ez du pantailaren blokeorik. Konfiguratu bat aplikazio-blokeoa berriro aktibatzeko.';

  @override
  String get appLockAfterImmediately => 'Berehala';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutu', one: 'Minutu $count');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ordu', one: 'Ordu $count');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Zifratua';

  @override
  String get openpgpEncryptedInPart => 'Zati batean zifratua';

  @override
  String get openpgpEncryptedLocked => 'Zifratua · blokeatuta';

  @override
  String get openpgpEncryptedNoKey => 'Zifratua · gakorik ez';

  @override
  String get openpgpEncryptedDamaged => 'Zifratua · hondatuta';

  @override
  String get openpgpEncryptedUnsupported => 'Zifratua · onartu gabea';

  @override
  String get openpgpUnknownSigner => 'ezezaguna';

  @override
  String get openpgpUnknownKey => 'Gako ezezaguna';

  @override
  String get openpgpSignatureInvalid => 'Sinadura baliogabea';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Sinatzailea: $name, ez igorlea';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Zati batean sinatua. Sinatzailea: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Sinatzailea: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Baztertutako gako batekin sinatua';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Sinatzailea: $name · gakoa onartu gabe';
  }

  @override
  String get openpgpUnlock => 'Desblokeatu';

  @override
  String get openpgpCantDecrypt => 'Ezin da mezu hau deszifratu';

  @override
  String get openpgpEncryptedWithOpenPgp => 'OpenPGP bidez zifratua';

  @override
  String get openpgpEncryption => 'Zifratzea';

  @override
  String get openpgpDecryptedHere => 'Gailu honetan deszifratua';

  @override
  String get openpgpNotDecrypted => 'Deszifratu gabe';

  @override
  String get openpgpKeyLocked => 'Zure gakoa blokeatuta dago.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Gakoak: $keys', one: 'Gakoa: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Gai babestua';

  @override
  String get openpgpUnlockKey => 'Desblokeatu gakoa';

  @override
  String get openpgpSignature => 'Sinadura';

  @override
  String get openpgpFingerprint => 'Hatz-marka';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Gakoaren IDa: $id';
  }

  @override
  String get openpgpSigned => 'Sinatua';

  @override
  String get openpgpProblem => 'Arazoa';

  @override
  String get openpgpAcceptance => 'Onarpena';

  @override
  String get openpgpChangeAcceptance => 'Aldatu onarpena…';

  @override
  String get openpgpCheckedFooter => 'Gailu honetan egiaztatua OpenPGP bidez, Thunderbird-ekin bateragarria.';

  @override
  String get openpgpSummaryLocked =>
      'Zure gakoa blokeatuta dago. Desblokeatu bere pasaesaldiarekin mezu hau irakurtzeko.';

  @override
  String get openpgpSummaryNoSecretKey => 'Gailu honetan ez dagoen gako baterako zifratu zen.';

  @override
  String get openpgpSummaryDamaged => 'Zifratutako datuak hondatuta daude edo bidean aldatu dira.';

  @override
  String get openpgpSummaryUnsupported => 'Loupe-k onartzen ez duen algoritmo bat erabiltzen du.';

  @override
  String get openpgpSummaryEncrypted => 'Zuk eta beste hartzaileek bakarrik irakur dezakezue.';

  @override
  String get openpgpSummaryNotSigned => 'Ez dago sinatuta; beraz, igorlea ez dago berretsita.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Sinatuta dago, baina ez duzun gako batekin; beraz, ezin da sinadura egiaztatu.';

  @override
  String get openpgpSummaryBadSignature => 'Sinadura ez dator bat: baliteke mezua aldatu izana.';

  @override
  String get openpgpSummaryMismatch => 'Sinadura baliozkoa da, baina gakoa igorlearena ez den beste helbide batena da.';

  @override
  String get openpgpSummaryPartial =>
      'Mezuaren zati bat bakarrik dago sinatuta. Sinaduratik kanpoko testua (posta-zerrenda baten orri-oina, adibidez) «Unsigned content» lerroaren azpian erakusten da, eta mezuaren beste zatiak, eranskinak adibidez, ez daude sinaduraren barruan.';

  @override
  String get openpgpSummaryOwnKey => 'Zure gakoarekin sinatua.';

  @override
  String get openpgpSummaryVerified => 'Sinadura baliozkoa da, eta gakoaren hatz-marka egiaztatu duzu.';

  @override
  String get openpgpSummaryUnverified => 'Sinadura baliozkoa da. Gakoa onartu duzu hatz-marka egiaztatu gabe.';

  @override
  String get openpgpSummaryRejected => 'Sinadura baliozkoa da, baina gako hau baztertu duzu.';

  @override
  String get openpgpSummaryUndecided =>
      'Sinadura baliozkoa da, baina oraindik ez duzu gako hau onartu. Konparatu haren hatz-marka igorlearekin.';

  @override
  String get openpgpAcceptanceRejected => 'Baztertua';

  @override
  String get openpgpAcceptanceUndecided => 'Onartu gabea';

  @override
  String get openpgpAcceptanceUnverified => 'Onartua';

  @override
  String get openpgpAcceptanceVerified => 'Onartua eta egiaztatua';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return '$name pertsonaren gakoa onartu?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Hatz-marka: $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Bai, hatz-marka egiaztatu dut';

  @override
  String get openpgpAcceptUnverified => 'Bai, egiaztatu gabe';

  @override
  String get openpgpAcceptLater => 'Oraindik ez';

  @override
  String get openpgpRejectKey => 'Baztertu gako hau';

  @override
  String get openpgpNoSubject => '(gairik ez)';

  @override
  String get openpgpEncryptionTitle => 'Muturretik muturrerako zifratzea';

  @override
  String get openpgpMyKeys => 'Nire OpenPGP gakoak';

  @override
  String get openpgpMyKeysFooter =>
      'Gako batekin, posta zifratua irakur dezakezu, eta zurea sinatu eta zifratu. Thunderbird erabiltzen duzu? Esportatu gakoa han (Kontuaren ezarpenak › Muturretik muturrerako zifratzea › Esportatu gako sekretua) eta inportatu hemen.';

  @override
  String get openpgpAddKey => 'Gehitu gakoa…';

  @override
  String get openpgpAddresses => 'Helbideak';

  @override
  String get openpgpAddressesFooter =>
      'Helbide bakoitzak zer gako erabiltzen duen, eta noiz zifratzen eta sinatzen duen.';

  @override
  String get openpgpCorrespondentsKeys => 'Kontaktuen OpenPGP gakoak';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Onartu gako bat bere jabearena dela fidatzen zarenean; konparatu hatz-marka jabearekin egiaztatutzat markatzeko.';

  @override
  String get openpgpImportPublicKey => 'Inportatu gako publikoa…';

  @override
  String get openpgpCollected => 'Autocrypt bidez bildutakoak';

  @override
  String get openpgpCollectedFooter =>
      'Mezuekin iritsitako gakoak. Loupe-k haientzat zifra dezake bi aldeek hala eskatzen dutenean.';

  @override
  String get openpgpOnThisDevice => 'Gailu honetan';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Mezu zifratuek gaia ezkutatzen dute. Loupe-k irekitzen duzun mezu bakoitzaren gaia gordetzen du gailu honetako datu-base zifratuan, zerrendan, bilaketan eta jakinarazpenetan ager dadin. Atzeko planoan, Loupe-k mezu berrien gaiak ere deszifra ditzake pasaesaldirik gabeko gakoekin; horretarako, mezu bakoitza deskargatzen du (1 MB arte).';

  @override
  String get openpgpDecryptSubjects => 'Deszifratu gaiak atzeko planoan';

  @override
  String get openpgpIndexFooter =>
      'Bilaketak mezu zifratuak aurkitzen ditu igorlearen, hartzaileen eta gaiaren arabera. Hau aktibatuta, Loupe-k deszifratzen duen mezu zifratu bakoitzaren testua ere gehitzen dio gailu honetako datu-base zifratuko bilaketa-indizeari, bilaketak testuaren arabera ere aurki dezan. Desaktibatzen baduzu, testu hori indizetik kentzen da.';

  @override
  String get openpgpIndexDecrypted => 'Indexatu deszifratutako mezuak bilaketarako';

  @override
  String get openpgpPassphrases => 'Pasaesaldiak';

  @override
  String get openpgpPassphrasesFooter =>
      'Pasaesaldi batekin babesten dituzun OpenPGP gakoak eta S/MIME ziurtagiriak behar direnean desblokeatzen dira. «Gogoratu» gabe, berriro blokeatzen dira erabilera bakoitzetik bi minutura.';

  @override
  String get openpgpRememberPassphrases => 'Gogoratu pasaesaldiak';

  @override
  String get openpgpRememberPassphrasesDetail => 'Loupe itxi arte';

  @override
  String get openpgpLockKeysNow => 'Blokeatu gakoak orain';

  @override
  String get openpgpKeysLocked => 'Gakoak blokeatu dira.';

  @override
  String get openpgpKeyStateRevoked => 'baliogabetua';

  @override
  String get openpgpKeyStateExpired => 'iraungia';

  @override
  String get openpgpKeyStateNeverExpires => 'ez da inoiz iraungitzen';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'iraungitze-data: $date';
  }

  @override
  String get openpgpNoKey => 'Gakorik ez';

  @override
  String get openpgpAlwaysEncrypt => 'Zifratu beti';

  @override
  String get openpgpAddKeyTitle => 'Gehitu OpenPGP gako bat';

  @override
  String get openpgpAddKeyMessage => 'Inportatu Thunderbird-en erabiltzen duzun gakoa, edo sortu berri bat.';

  @override
  String get openpgpImportFromClipboard => 'Inportatu arbeletik';

  @override
  String get openpgpImportFromFile => 'Inportatu fitxategitik';

  @override
  String get openpgpGenerateNewKey => 'Sortu gako berria';

  @override
  String get openpgpImportPublicKeyTitle => 'Inportatu gako publiko bat';

  @override
  String get openpgpFromClipboard => 'Arbeletik';

  @override
  String get openpgpFromFile => 'Fitxategitik';

  @override
  String get openpgpClipboardEmpty => 'Arbela hutsik dago. Kopiatu gakoa lehenik.';

  @override
  String get openpgpKey => 'Gakoa';

  @override
  String get openpgpValidityRevoked => 'Baliogabetua';

  @override
  String openpgpValidityExpired(String date) {
    return 'Iraungia: $date';
  }

  @override
  String get openpgpNeverExpires => 'Ez da inoiz iraungitzen';

  @override
  String openpgpValidUntil(String date) {
    return 'Baliozkoa noiz arte: $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Hatz-marka kopiatu da.';

  @override
  String get openpgpAlgorithm => 'Algoritmoa';

  @override
  String get openpgpCreated => 'Sortze-data';

  @override
  String get openpgpValidity => 'Baliozkotasuna';

  @override
  String get openpgpProtection => 'Babesa';

  @override
  String get openpgpProtectionPassphrase => 'Pasaesaldia';

  @override
  String get openpgpProtectionKeychain => 'Biltegi segurua soilik';

  @override
  String get openpgpKeyDetailsFooter =>
      'Partekatu zure gako publikoa, besteek zuri zifratuta idatz diezazuten. Babeskopia zure gako sekretua da, pasaesaldiarekin babestua baldin badu: gorde ezkutuan.';

  @override
  String get openpgpSharePublicKey => 'Partekatu gako publikoa';

  @override
  String get openpgpCopyPublicKey => 'Kopiatu gako publikoa';

  @override
  String get openpgpPublicKeyCopied => 'Gako publikoa kopiatu da.';

  @override
  String get openpgpBackUpSecretKey => 'Egin gako sekretuaren babeskopia';

  @override
  String get openpgpDeleteKey => 'Ezabatu gakoa';

  @override
  String get openpgpRemoveKey => 'Kendu gakoa';

  @override
  String get openpgpBackUpTitle => 'Gako sekretuaren babeskopia egin?';

  @override
  String get openpgpBackUpProtected =>
      'Babeskopia zure gakoaren pasaesaldiarekin babestuta dago. Biak dituen edonork irakur dezake zure posta.';

  @override
  String get openpgpBackUpUnprotected =>
      'Gako honek ez du pasaesaldirik: babeskopia duen edonork irakur dezake zure posta eta zure izenean sinatu.';

  @override
  String get openpgpBackUp => 'Egin babeskopia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Zure $name gakoa ezabatu?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return '$name pertsonaren gakoa kendu?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Gako honetarako zifratutako posta ezin izango da gailu honetan irakurri, berriro inportatzen ez baduzu.';

  @override
  String get openpgpRemoveKeyMessage => 'Geroago berriro inporta dezakezu.';

  @override
  String get openpgpKeyHeader => 'OpenPGP gakoa';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Gehitu gako bat Muturretik muturrerako zifratzea atalean, helbide honetako posta zifratzeko eta sinatzeko.';

  @override
  String get openpgpGenerateAKey => 'Sortu gako bat…';

  @override
  String get openpgpSending => 'Bidalketa';

  @override
  String get openpgpSendingFooter =>
      'Zifratze automatikoa aktibatzen da hartzaile guztiek gako onartu bat edo ziurtagiri fidagarri bat dutenean, edo Autocrypt-ek bi aldeek hala nahi dutela dioenean. Posta zifratua beti sinatzen da.';

  @override
  String get openpgpEncryptAutomatically => 'Zifratu automatikoki';

  @override
  String get openpgpAlwaysEncryptDetail => 'Ez du bidaltzen hartzaileren batek gakorik ez badu';

  @override
  String get openpgpSignUnencrypted => 'Sinatu zifratu gabeko posta';

  @override
  String get openpgpAttachPublicKey => 'Erantsi nire gako publikoa';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt-ek zure gako publikoa bidaltzen du mezu bakoitzarekin, beste aplikazioek zuri zifratuta idatz diezazuten ezer konfiguratu gabe.';

  @override
  String get openpgpSendMyKey => 'Bidali nire gakoa postarekin';

  @override
  String get openpgpPreferEncryption => 'Hobetsi zifratzea';

  @override
  String get openpgpPreferEncryptionDetail => 'Eskatu besteei ahal dutenean zifratzeko';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count urte', one: 'Urte $count');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Pasaesaldiak ez datoz bat.';

  @override
  String openpgpKeyReady(String id) {
    return 'Zure $id gakoa prest dago.';
  }

  @override
  String get openpgpNewKey => 'Gako berria';

  @override
  String get openpgpNewKeyFor => 'Norentzat';

  @override
  String get openpgpYourName => 'Zure izena';

  @override
  String get openpgpAddress => 'Helbidea';

  @override
  String get openpgpPassphrase => 'Pasaesaldia';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Aukerakoa. Pasaesaldirik gabe, zure telefonoaren biltegi seguruak bakarrik babesten du gakoa, eta Loupe-k ez du inoiz ezer eskatzen. Pasaesaldiarekin, Loupe-k eskatu egingo dizu gakoa behar denean.';

  @override
  String get openpgpRepeatPassphrase => 'Errepikatu';

  @override
  String get openpgpExpires => 'Iraungitzea';

  @override
  String get openpgpExpiresFooter =>
      'Gako berri bat sor dezakezu iraungi aurretik. Thunderbird-ek ere hiru urte erabiltzen ditu.';

  @override
  String get openpgpGenerateKey => 'Sortu gakoa';

  @override
  String get openpgpKeyFor => 'Gakoa honentzat';

  @override
  String get openpgpCantEncrypt => 'Ezin da zifratu';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Ez dago OpenPGP gakorik hauentzat: $names, eta helbide honek beti zifratzen du. Kendu hartzailea, edo inportatu haren gakoa Ezarpenak › Muturretik muturrerako zifratzea atalean.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Ez dago S/MIME ziurtagiri baliozkorik hauentzat: $names, eta helbide honek beti zifratzen du. Kendu hartzailea, edo inportatu haren ziurtagiria Ezarpenak › Muturretik muturrerako zifratzea atalean.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Ez dago OpenPGP gakorik hauentzat: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Ez dago S/MIME ziurtagiri baliozkorik hauentzat: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Bidali zifratu gabe';

  @override
  String get openpgpCantSign => 'Ezin da sinatu';

  @override
  String get openpgpCantSignMessage =>
      'Zure S/MIME ziurtagiriaren gako pribatua ez dago gailu honetan. Inportatu berriro ziurtagiria (.p12 edo .pfx fitxategi bat) Ezarpenak › Muturretik muturrerako zifratzea atalean.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Gakorik ez: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Ziurtagiririk ez: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Autocrypt-eko gakoak';

  @override
  String get openpgpComposeEveryoneHasKey => 'Denek dute gakoa';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Denek dute ziurtagiria';

  @override
  String get openpgpComposeEncrypt => 'Zifratu';

  @override
  String get openpgpComposeSign => 'Sinatu';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, aldatu';
  }

  @override
  String get openpgpNoKeyFound => 'Ez da OpenPGP gakorik aurkitu.';

  @override
  String get openpgpImportSecretKeyTitle => 'Gako sekretu bat inportatu?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Eranskin honek gako sekretu bat dauka ($names). Inportatu zure gako gisa zuk zeuk esportatu baduzu soilik, Thunderbird-etik adibidez.';
  }

  @override
  String get openpgpImportAsMyKey => 'Inportatu nire gako gisa';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'zure $name gakoa';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gako inportatu? ($names)',
      one: 'Gako hau inportatu? ($names)',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Inportatu eta onartu';

  @override
  String get openpgpImportDecideLater => 'Inportatu, erabaki geroago';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name pertsonaren gakoa';
  }

  @override
  String openpgpImported(String keys) {
    return 'Inportatuta: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP gako daude erantsita.',
      one: 'OpenPGP gako bat dago erantsita.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Inportatu';

  @override
  String get openpgpUnlockKeyTitle => 'Desblokeatu OpenPGP gakoa';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Idatzi $name pertsonaren gakoaren pasaesaldia ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Pasaesaldi hori ez da zuzena. Saiatu berriro.';

  @override
  String get openpgpExplainLocked => 'Mezu hau zifratuta dago. Desblokeatu zure OpenPGP gakoa irakurtzeko.';

  @override
  String get openpgpExplainNoKey =>
      'Mezu hau zifratuta dago, baina ez gailu honetako OpenPGP gakoetako baterako. Thunderbird-en irakurtzen baduzu, inportatu han erabiltzen duzun gakoa: Ezarpenak › Muturretik muturrerako zifratzea.';

  @override
  String get openpgpExplainDamaged => 'Mezu zifratu hau hondatuta dago; beraz, ezin da segurtasunez deszifratu.';

  @override
  String get openpgpExplainUnsupported => 'Mezu honek Loupe-k oraindik irakurri ezin duen zifratze bat erabiltzen du.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Mezu hau S/MIME bidez zifratuta dago, baina ez gailu honetako ziurtagirietako baterako. Inportatu zure ziurtagiria (.p12 edo .pfx fitxategi bat) Ezarpenak › Muturretik muturrerako zifratzea atalean.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Mezu hau zifratuta dago. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Desblokeatu zure S/MIME ziurtagiria irakurtzeko.';

  @override
  String get openpgpAttachmentGone => 'Eranskin hau ez dago erabilgarri jada.';

  @override
  String get smimeEncrypted => 'Zifratua (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Zifratua (S/MIME) · ziurtagiririk ez';

  @override
  String get smimeEncryptedDamaged => 'Zifratua (S/MIME) · hondatuta';

  @override
  String get smimeEncryptedUnsupported => 'Zifratua (S/MIME) · onartu gabea';

  @override
  String get smimeEncryptedLocked => 'Zifratua (S/MIME) · blokeatuta';

  @override
  String get smimeUnknownSigner => 'ezezaguna';

  @override
  String get smimeSignatureModified => 'Sinadura baliogabea: mezua aldatu da';

  @override
  String get smimeSignatureWeak => 'Sinadura ez-segurua: algoritmo zaharkitua';

  @override
  String get smimeSignatureUncheckable => 'Ezin da sinadura egiaztatu';

  @override
  String get smimeSignedCertificateMissing => 'Sinatua · ziurtagiria falta da';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Sinatzailea: $name · ziurtagiri baliogabetua';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Sinatzailea: $name · beste data batean';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Sinatzailea: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Sinatzailea: $name · ziurtagiri baliogabea';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Sinatzailea: $name · ez da fidagarria';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Sinatzailea: $name · ziurtagiri iraungia';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Sinatzailea: $name · ziurtagiria oraindik ez da baliozkoa';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Sinatzailea: $name · ziurtagiria ez da postarako';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Sinatzailea: $name, ez igorlea';
  }

  @override
  String get smimeCantDecrypt => 'Ezin da mezu hau deszifratu';

  @override
  String get smimeEncryptedWithSmime => 'S/MIME bidez zifratua';

  @override
  String get smimeEncryption => 'Zifratzea';

  @override
  String get smimeDecryptedHere => 'Gailu honetan deszifratua';

  @override
  String get smimeNotDecrypted => 'Deszifratu gabe';

  @override
  String get smimeAuthenticated => 'autentifikatua';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziurtagiritarako',
      one: 'ziurtagiri baterako',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Sinadura';

  @override
  String get smimeIssuedBy => 'Jaulkitzailea';

  @override
  String get smimeValid => 'Baliozkotasuna';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 hatz-marka';

  @override
  String get smimeSigned => 'Sinatua';

  @override
  String get smimeProblem => 'Arazoa';

  @override
  String get smimeCheckingRevocation => 'Baliogabetzea egiaztatzen…';

  @override
  String get smimeNotRevoked => 'Baliogabetu gabea';

  @override
  String get smimeRevoked => 'Baliogabetua';

  @override
  String get smimeRevocationUnknown => 'Baliogabetzea ezezaguna';

  @override
  String smimeRevokedSince(String date) {
    return 'Noiztik: $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Autoritateari galdetu zaio (baliogabetze-zerrenda), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Autoritateari galdetu zaio (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Jo «$name» fidagarritzat…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Jo ziurtagiri hau fidagarritzat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Gailu honetan egiaztatua S/MIME bidez, Outlook eta Thunderbird-ekin bateragarria; baliogabetzea ziurtagiri-autoritatearekin egiaztatua.';

  @override
  String get smimeCheckedFooter =>
      'Gailu honetan egiaztatua S/MIME bidez, Outlook eta Thunderbird-ekin bateragarria. Baliogabetzea ez da egiaztatzen (Ezarpenak › Muturretik muturrerako zifratzea).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return '$name fidagarritzat jo postarako?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return '$name pertsonaren ziurtagiria fidagarritzat jo?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Autoritate honek jaulkitzen duen ziurtagiri oro fidagarritzat joko da, zure enpresaren ziurtagiri-autoritatearenak bezala. Konparatu lehenik hatz-marka jabearekin:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Konparatu lehenik hatz-marka jabearekin:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Jo fidagarritzat';

  @override
  String get smimeSummaryNoKey => 'Gailu honetan ez dagoen ziurtagiri baterako zifratu zen.';

  @override
  String get smimeSummaryDamaged => 'Zifratutako datuak hondatuta daude edo bidean aldatu dira.';

  @override
  String get smimeSummaryUnsupported => 'Loupe-k onartzen ez duen algoritmo bat erabiltzen du.';

  @override
  String get smimeSummaryLocked => 'Zure S/MIME ziurtagiria blokeatuta dago.';

  @override
  String get smimeSummaryEncrypted => 'Zuk eta beste hartzaileek bakarrik irakur dezakezue.';

  @override
  String get smimeSummaryNotSigned => 'Ez dago sinatuta; beraz, igorlea ez dago berretsita.';

  @override
  String get smimeSummaryModified => 'Sinadura ez dator bat: mezua sinatu ondoren aldatu da.';

  @override
  String get smimeSummaryUncheckable => 'Ezin da sinadura egiaztatu.';

  @override
  String get smimeSummaryNoCertificate => 'Sinatzailearen ziurtagiria ez dago mezuan; beraz, ezin da egiaztatu.';

  @override
  String get smimeSummaryRevoked =>
      'Ziurtagiri-autoritateak sinatzailearen ziurtagiria baliogabetu du: sinadura ez da fidagarria.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Ziurtagiri-autoritateak sinatzailearen ziurtagiria baliogabetu du ($reason): sinadura ez da fidagarria.';
  }

  @override
  String get smimeDateMismatch =>
      'Mezuaren datatik ordubete baino gehiagora sinatu zen: berriro bidalitako mezu zahar bat izan daiteke.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Sinadura baliozkoa da, eta $issuer jaulkitzaileak bermatzen du ziurtagiria igorlearena dela.';
  }

  @override
  String get smimeProblemInvalidChain => 'Ziurtagiria edo haren jaulkitzaileetako bat baliogabea da.';

  @override
  String get smimeProblemUntrusted => 'Ziurtagiria Loupe-k fidagarritzat jotzen ez duen autoritate batena da.';

  @override
  String get smimeProblemExpired => 'Ziurtagiria iraungita zegoen.';

  @override
  String get smimeProblemNotYetValid => 'Ziurtagiria oraindik ez zen baliozkoa.';

  @override
  String get smimeProblemWrongUsage => 'Ziurtagiria ez da postarako.';

  @override
  String get smimeProblemWrongAddress => 'Ziurtagiria igorlearena ez den beste helbide batena da.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Fidagarria · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ez fidagarria · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Iraungia: $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Baliozkoa noiztik: $date';
  }

  @override
  String get smimeTrustInvalid => 'Baliogabea';

  @override
  String get smimeTrustNotForMail => 'Ez da postarako';

  @override
  String get smimeTrustAnotherAddress => 'Beste helbide bat';

  @override
  String get smimeMyCertificates => 'Nire S/MIME ziurtagiriak';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME-rako, Outlook-ek eta enpresa askok erabiltzen duten bezala. Inportatu zure ziurtagiria bere gako pribatuarekin (.p12 edo .pfx fitxategi bat), Outlook, Windows, macOS edo Thunderbird-etik esportatuta.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME-rako, Outlook-ek eta enpresa askok erabiltzen duten bezala. Inportatu zure ziurtagiria bere gako pribatuarekin (.p12 edo .pfx fitxategi bat), Outlook, Windows, macOS edo Thunderbird-etik esportatuta, edo erabili zure enpresak edo zuk gailu honetan instalatutako bat.';

  @override
  String get smimeCertificateExpired => 'iraungia';

  @override
  String smimeCertificateUntil(String date) {
    return 'noiz arte: $date';
  }

  @override
  String get smimeCertificateOnDevice => 'gailu honetan';

  @override
  String get smimeImportCertificateEllipsis => 'Inportatu ziurtagiria…';

  @override
  String get smimeUseDeviceCertificate => 'Erabili gailu honetako ziurtagiri bat…';

  @override
  String get smimeCorrespondentsCertificates => 'Kontaktuen ziurtagiriak';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Sinatutako postatik bilduak, Outlook-ek eta Thunderbird-ek egiten duten bezala. Posta ziurtagiri fidagarrietarako soilik zifratzen da: Loupe-k Mozilla-k postarako fidagarritzat jotzen dituen autoritateak jotzen ditu fidagarritzat, baita zuk gehitzen dituzunak ere.';

  @override
  String get smimeRevocation => 'Baliogabetzea';

  @override
  String get smimeRevocationFooter =>
      'Sinatutako posta irekitzen duzunean, Loupe-k sinatzailearen ziurtagiria jaulki zuen autoritateari galdetzen dio baliogabetu ote den (bere OCSP erantzuleari edo bere baliogabetze-zerrendari). Hala, autoritateak jakin dezake noiz irakurtzen duen norbaitek, zure IP helbidetik, ziurtagiri horrekin sinatutako posta. Erantzunak gailu honetan gordetzen dira iraungi arte. Baliogabetutako ziurtagiri bat «Baliogabetua» gisa agertzen da mezuaren goiburuan.';

  @override
  String get smimeCheckRevocation => 'Egiaztatu ziurtagirien baliogabetzea linean';

  @override
  String get smimeTrustedAuthorities => 'Autoritate fidagarriak';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Zuk fidagarritzat jotakoak. Horiez gain, Mozilla-k beste $count autoritate jotzen ditu fidagarritzat postarako.',
      one:
          'Zuk fidagarritzat jotakoak. Horiez gain, Mozilla-k beste autoritate $count jotzen du fidagarritzat postarako.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Ziurtagiri-autoritatea';

  @override
  String get smimeImportACertificate => 'Inportatu ziurtagiri bat';

  @override
  String get smimeImportContactMessage =>
      'Kontaktu baten ziurtagiria (.cer, .crt, .pem) edo ziurtagiri-autoritate batena.';

  @override
  String get smimeFromClipboard => 'Arbeletik';

  @override
  String get smimeFromFile => 'Fitxategitik';

  @override
  String get smimeClipboardEmpty => 'Arbela hutsik dago. Kopiatu ziurtagiria lehenik.';

  @override
  String get smimeCertificate => 'Ziurtagiria';

  @override
  String get smimeOnDeviceFooter =>
      'Bere gako pribatua Android-en kredentzialen biltegian geratzen da, zure enpresak edo zuk instalatu zenuten tokian: Loupe-k Android-i eskatzen dio harekin sinatzeko eta deszifratzeko. Sinatutako posta bidaltzean sinatzen da.';

  @override
  String get smimeAddresses => 'Helbideak';

  @override
  String get smimeUsage => 'Erabilera';

  @override
  String get smimeUsageNone => 'Loupe-k erabiltzen duen ezer ez';

  @override
  String get smimeUsageSigning => 'Sinatzea';

  @override
  String get smimeUsageEncryption => 'Zifratzea';

  @override
  String get smimeUsageCertificates => 'Ziurtagiriak';

  @override
  String get smimeAlgorithm => 'Algoritmoa';

  @override
  String get smimeSerialNumber => 'Serie-zenbakia';

  @override
  String get smimeFingerprintCopied => 'Hatz-marka kopiatu da.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 hatz-marka digitala';

  @override
  String get smimePrivateKey => 'Gako pribatua';

  @override
  String get smimeKeyOnDevice => 'Gailu honetan';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupe-n, pasaesaldiarekin';

  @override
  String get smimeKeyInLoupe => 'Loupe-n';

  @override
  String get smimeSource => 'Jatorria';

  @override
  String get smimeSourceSignedMail => 'Sinatutako posta';

  @override
  String get smimeSourceImported => 'Inportatua';

  @override
  String get smimeTrustHeader => 'Konfiantza';

  @override
  String get smimeTrustedRoot => 'Erro fidagarria';

  @override
  String get smimeIssuer => 'Jaulkitzailea';

  @override
  String smimeTrustNamed(String name) {
    return 'Jo «$name» fidagarritzat';
  }

  @override
  String get smimeTrustThisAuthority => 'Jo autoritate hau fidagarritzat';

  @override
  String get smimeTrustThisCertificate => 'Jo ziurtagiri hau fidagarritzat';

  @override
  String get smimeStopTrusting => 'Utzi fidagarritzat jotzeari';

  @override
  String get smimePassphrase => 'Pasaesaldia';

  @override
  String get smimePassphraseFooter =>
      'Aukerakoa. Pasaesaldi batekin, gako pribatua gailu honetan ere zifratzen da (Argon2id eta AES-256), eta Loupe-k eskatu egiten du sinatzeko eta deszifratzeko; «Gogoratu pasaesaldiak» aukerak zehazten du zenbat denboraz. Bidaltzen duzun posta bidaltzean sinatzen da; atzeko planoko lanek ezin dute gakoa erabili.';

  @override
  String get smimeChangePassphrase => 'Aldatu pasaesaldia…';

  @override
  String get smimeSetPassphraseEllipsis => 'Ezarri pasaesaldia…';

  @override
  String get smimeRemovePassphrase => 'Kendu pasaesaldia';

  @override
  String get smimeShareCertificate => 'Partekatu ziurtagiria';

  @override
  String get smimeDeleteCertificate => 'Ezabatu ziurtagiria';

  @override
  String get smimeRemoveCertificate => 'Kendu ziurtagiria';

  @override
  String get smimePassphraseChanged => 'Pasaesaldia aldatu da.';

  @override
  String get smimePassphraseSet => 'Pasaesaldia ezarri da.';

  @override
  String get smimeRemovePassphraseTitle => 'Pasaesaldia kendu?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Orduan, gako pribatua biltegi seguruak bakarrik babestuko du, pasaesaldirik gabe bezala: Loupe-k ez du gehiago eskatuko, eta atzeko planoko lanek erabil dezakete.';

  @override
  String get smimePassphraseRemoved => 'Pasaesaldia kendu da.';

  @override
  String smimeTrustTitle(String name) {
    return '$name fidagarritzat jo?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Jaulkitzen duen ziurtagiri oro fidagarritzat joko da postarako. Konparatu lehenik hatz-marka jabearekin:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Zure $name ziurtagiria ezabatu?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return '$name pertsonaren ziurtagiria kendu?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe-k ez du gehiago erabiliko: harentzat zifratutako posta ezin izango da Loupe-n irakurri. Ziurtagiria gailu honetan geratzen da (Ezarpenak › Segurtasuna › Enkriptatzea eta kredentzialak).';

  @override
  String get smimeDeleteOwnMessage =>
      'Bere gako pribatua gailu honetatik ezabatzen da: harentzat zifratutako posta ezin izango da hemen irakurri, berriro inportatzen ez baduzu.';

  @override
  String get smimeRemoveContactMessage => 'Pertsona horren hurrengo mezu sinatuarekin itzuliko da.';

  @override
  String get smimeAddressImportFooter =>
      'Inportatu helbide honetarako ziurtagiri bat S/MIME bidez sinatzeko eta zifratzeko, Outlook-ek egiten duen bezala.';

  @override
  String get smimeImportACertificateEllipsis => 'Inportatu ziurtagiri bat…';

  @override
  String get smimePreferFooter =>
      'Biek mezu bat babes dezaketenean, hobetsitakoa erabiltzen da, besteak bakarrik badu hartzaile guztientzako gakoa edo ziurtagiria salbu.';

  @override
  String get smimePreferSmime => 'Hobetsi S/MIME';

  @override
  String get smimePreferSmimeDetail => 'OpenPGP-ren ordez';

  @override
  String get smimeCertificatePassword => 'Ziurtagiriaren pasahitza';

  @override
  String get smimeCertificatePasswordPrompt => 'Idatzi ziurtagiri-fitxategia esportatzean erabilitako pasahitza.';

  @override
  String get smimeImport => 'Inportatu';

  @override
  String get smimeWrongPassword => 'Pasahitz hori ez da zuzena. Saiatu berriro.';

  @override
  String get smimeNoCertificateFound => 'Ez da ziurtagiririk aurkitu.';

  @override
  String smimeCertificateOf(String name) {
    return '$name pertsonaren ziurtagiria';
  }

  @override
  String get smimeNothingNew => 'Ez dago inportatzeko ezer berririk.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Inportatuta: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count autoritate fidagarri inportatu dira.',
      one: 'Autoritate fidagarri bat inportatu da.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Inportatuta: $certificates eta $count autoritate fidagarri.',
      one: 'Inportatuta: $certificates eta autoritate fidagarri bat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Fitxategi honek ez du gako pribaturik. Esportatu zure ziurtagiria bere gako pribatuarekin.';

  @override
  String get smimeImportAsYoursTitle => 'Zure ziurtagiri gisa inportatu?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Eranskin honek ziurtagiri bat dauka bere gako pribatuarekin: $names. Inportatu zuk zeuk esportatu baduzu soilik, Outlook edo Thunderbird-etik adibidez.';
  }

  @override
  String get smimeImportAsMine => 'Inportatu nire ziurtagiri gisa';

  @override
  String smimeImportedOwn(String names) {
    return 'Zure $names ziurtagiria inportatu da.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Zure $name ($addresses) ziurtagiria gehitu da gailu honetatik.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return '«$name» fidagarritzat jo postarako?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe-k ez du ezagutzen ziurtagiri-autoritate hau (enpresa batena, agian). Jo fidagarritzat jaulkitzen dituen ziurtagiriak egiaztatzeko. Konparatu lehenik haren hatz-marka zure informatika-sailarekin:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ziurtagiri daude erantsita.',
      one: 'Ziurtagiri bat dago erantsita.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Inportatu ziurtagiria';

  @override
  String get smimeUnlockTitle => 'Desblokeatu S/MIME ziurtagiria';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Idatzi $name pertsonaren ziurtagiriaren pasaesaldia ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Pasaesaldi hori ez da zuzena. Saiatu berriro.';

  @override
  String get smimeUnlock => 'Desblokeatu';

  @override
  String get smimeEnterAPassphrase => 'Idatzi pasaesaldi bat.';

  @override
  String get smimePassphrasesDiffer => 'Bi pasaesaldiak desberdinak dira.';

  @override
  String get smimeSetPassphraseTitle => 'Ezarri pasaesaldia';

  @override
  String get smimeSetPassphraseText =>
      'Loupe-k eskatu egingo du sinatzeko eta deszifratzeko. Ahazten baduzu, inportatu berriro ziurtagiria bere .p12 fitxategitik.';

  @override
  String get smimePassphraseAgain => 'Berriro';

  @override
  String get smimeSetPassphraseButton => 'Ezarri';

  @override
  String get smimeLockedOpenAgain => 'Zure S/MIME ziurtagiria blokeatuta dago. Ireki berriro mezua desblokeatzeko.';

  @override
  String get smimeDeviceHasNoCertificates => 'Gailu honek ez ditu bere ziurtagiriak eskaintzen.';

  @override
  String get smimeCantReadCertificate => 'Loupe-k ezin du ziurtagiri hau irakurri.';

  @override
  String get smimeCertificateNotForMail =>
      'Ziurtagiri hau ez da postarako: ez du helbide elektronikorik, edo ez dago sinatzeko edo zifratzeko pentsatuta.';

  @override
  String get smimeDeviceCertificateGone =>
      'Ziurtagiria jada ez dago gailu honetan, edo Loupe-k ezin du gehiago erabili. Aukeratu berriro Ezarpenak › Muturretik muturrerako zifratzea atalean.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Gailu honetako ziurtagiria Loupe irekita dagoen bitartean bakarrik erabil daiteke.';

  @override
  String get smimeDeviceKeyDamaged => 'Gako zifratua hondatuta dago.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Gailu honetako ziurtagiriak ezin du hau egin: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'ez da onartzen';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Gailu honetako ziurtagiriak huts egin du: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Autoritatearen helbidea ez da web-helbide bat.';

  @override
  String get smimeAuthorityTimeout => 'Ziurtagiri-autoritateak ez du garaiz erantzun.';

  @override
  String get smimeAuthorityUnreachable => 'Ezin izan da ziurtagiri-autoritatearekin konektatu.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Ziurtagiri-autoritateak $status erantzun du.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Ziurtagiri-autoritatearen erantzuna handiegia da.';

  @override
  String get smimeRevocationNotChecked =>
      'Egiaztatu gabe: Loupe-k fidagarritzat jotzen dituen autoritateen ziurtagiriak bakarrik egiaztatzen dira.';

  @override
  String get settingsLanguage => 'Hizkuntza';

  @override
  String get settingsLanguageSystem => 'Telefonoaren bera';

  @override
  String get settingsLanguageFooter =>
      'Loupe-k zure telefonoaren hizkuntza erabiltzen du baldin badauka, eta ingelesa bestela. Hemen aukeratzen duzun hizkuntza Loupe-rentzat bakarrik da, jakinarazpenak barne.';

  @override
  String get settingsAccountsHeader => 'Kontuak';

  @override
  String get settingsAddAccount => 'Gehitu kontua';

  @override
  String get settingsMailHeader => 'Posta';

  @override
  String get settingsSwipeActions => 'Irristatze-ekintzak';

  @override
  String get settingsSwipeLeft => 'Irristatu ezkerrera';

  @override
  String get settingsSwipeLeftFooter =>
      'Irristatze osoak ekintza hau exekutatzen du. «Markatu» eta «Gehiago» irristatze labur batera daude beti.';

  @override
  String get settingsSwipeRight => 'Irristatu eskuinera';

  @override
  String get settingsSwipeRightFooter => 'Irristatze osoak ekintza hau exekutatzen du.';

  @override
  String get settingsSwipeToggleRead => 'Markatu irakurritzat / irakurri gabetzat';

  @override
  String get settingsSwipeTrash => 'Bota zakarrontzira';

  @override
  String get settingsSwipeMove => 'Mugitu mezua';

  @override
  String get settingsSwipeSnooze => 'Atzeratu';

  @override
  String get settingsThreaded => 'Antolatu elkarrizketaka';

  @override
  String get settingsUndoSendDelay => 'Bidalketa desegiteko tartea';

  @override
  String get settingsUndoSendDelayFooter =>
      'Bidalitako mezuek denbora hori itxaroten dute, atzera bota ahal izan ditzazun.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds segundo',
      one: 'Segundo $seconds',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Itxura';

  @override
  String get settingsTheme => 'Gaia';

  @override
  String get settingsThemeSystem => 'Automatikoa';

  @override
  String get settingsThemeLight => 'Argia';

  @override
  String get settingsThemeDark => 'Iluna';

  @override
  String get settingsDensity => 'Mezu-zerrenda';

  @override
  String get settingsDensityComfortable => 'Erosoa';

  @override
  String get settingsDensityCompact => 'Trinkoa';

  @override
  String get settingsReadingHeader => 'Irakurketa';

  @override
  String get settingsReadingFooter =>
      'Urruneko irudiek igorleei jakinaraz diezaiekete noiz eta non ireki duzun mezu bat.';

  @override
  String get settingsDefaultView => 'Ikuspegi lehenetsia';

  @override
  String get settingsDefaultViewFooter => 'Edozein mezuren ikuspegia alda dezakezu Aa botoiarekin.';

  @override
  String get settingsViewReadable => 'Irakurgarria';

  @override
  String get settingsViewReadableDetail => 'Garbia, irakurgarria, modu iluna jarraitzen du';

  @override
  String get settingsViewOriginal => 'Jatorrizkoa';

  @override
  String get settingsViewOriginalDetail => 'Igorleak diseinatu bezala';

  @override
  String get settingsViewPlain => 'Testu soila';

  @override
  String get settingsViewPlainDetail => 'Hitzak bakarrik';

  @override
  String get settingsPlainTextFont => 'Testu soilaren letra-tipoa';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Zabalera finkokoa';

  @override
  String get settingsFontMonoDetail => 'ASCII artea eta taulak lerrokatuta mantentzen ditu';

  @override
  String get settingsTechnicalLists => 'Zerrenda teknikoak';

  @override
  String get settingsLoadRemoteImages => 'Kargatu urruneko irudiak';

  @override
  String get settingsOpenLinksDirectly => 'Ireki estekak zuzenean';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Saltatu klik-jarraitzaileak helmuga ezaguna denean';

  @override
  String get settingsSecurityHeader => 'Segurtasuna';

  @override
  String get settingsAppLock => 'Aplikazio-blokeoa';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe-k abiaraztean eskatzen du, eta «Blokeatze-denbora» baino denbora gehiago kanpoan egon ondoren itzultzen zarenean.';

  @override
  String get settingsAppLockFooterOff =>
      'Aplikazio-blokeoak zure hatz-marka, aurpegia edo pantailaren blokeoa eskatzen du zure posta erakutsi aurretik.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Aplikazio-blokeoa desaktibatuta dago oraindik. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Konfiguratu pasakode bat';

  @override
  String get settingsScreenLockTextIos =>
      'Aplikazio-blokeoak Face ID, Touch ID edo zure pasakodea erabiltzen ditu, eta iPhone honek ez du pasakoderik. Konfiguratu bat Ezarpenak aplikazioan, eta gero aktibatu aplikazio-blokeoa.';

  @override
  String get settingsScreenLockTitleAndroid => 'Konfiguratu pantailaren blokeoa';

  @override
  String get settingsScreenLockTextAndroid =>
      'Aplikazio-blokeoak zure telefonoaren pantailaren blokeoa erabiltzen du, edo hari gehitutako hatz-marka edo aurpegia, eta telefono honek ez du halakorik. Konfiguratu PIN bat, eredu bat edo pasahitz bat Android-en ezarpenetan, eta gero aktibatu aplikazio-blokeoa.';

  @override
  String get settingsOpenSystemSettings => 'Ireki ezarpenak';

  @override
  String get settingsOpenAndroidSettings => 'Ireki Android-en ezarpenak';

  @override
  String get settingsLockAfter => 'Blokeatze-denbora';

  @override
  String get settingsLockAfterFooter => 'Loupe zenbat denbora egon daitekeen atzeko planoan berriro eskatu aurretik.';

  @override
  String get settingsNotifications => 'Jakinarazpenak';

  @override
  String get settingsEncryption => 'Muturretik muturrerako zifratzea';

  @override
  String get settingsAdvanced => 'Aurreratua';

  @override
  String get settingsDemoHeader => 'Demoa';

  @override
  String get settingsDemoFooter =>
      'Demo-posta telefono honetan bakarrik dagoen postontzi asmatu bat da. Ez da ezer inora bidaltzen.';

  @override
  String get settingsDemoMode => 'Demo modua';

  @override
  String get settingsResetApp => 'Berrezarri aplikazioa';

  @override
  String get settingsResetFooter => 'Ezarpen guztiak ahazten ditu eta ongietorri-pantailara itzultzen da.';

  @override
  String get settingsResetTitle => 'Loupe berrezarri?';

  @override
  String get settingsResetMessage =>
      'Ezarpen, Smart Mailbox eta azken bilaketa guztiak ahaztuko dira, eta ongietorri-pantailara itzuliko zara.';

  @override
  String get settingsAboutHeader => 'Honi buruz';

  @override
  String get settingsVersion => 'Bertsioa';

  @override
  String get settingsLicences => 'Lizentziak';

  @override
  String get settingsPrivacy => 'Pribatutasuna';

  @override
  String get settingsPrivacyDetail =>
      'Loupe-k ez du analitikarik ez jarraipenik. Zure posta zure posta-zerbitzarietara bakarrik doa.';

  @override
  String get settingsNotificationsOffIos => 'Loupe-ren jakinarazpenak desaktibatuta daude Ezarpenak aplikazioan.';

  @override
  String get settingsNotificationsOffAndroid => 'Loupe-ren jakinarazpenak desaktibatuta daude Android-en ezarpenetan.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system sistemak ez dio Loupe-ri jakinarazpenak erakusten uzten. Baimendu ezarpenetan.';
  }

  @override
  String get settingsNewMailHeader => 'Posta berria';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo-posta ez da atzeko planoan iristen. Bidali proba-jakinarazpen bat posta berria nolakoa den ikusteko.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe-k posta berria atzeko planoan begiratzen du iOS-ek uzten dionean, eta hori orduak igaro ondoren gerta daiteke gutxitan irekitzen dituzun aplikazioetan. Sarrera-ontzietako mezu berriak eta edozein karpetatako VIPen mezuak jakinarazten zaizkizu.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe-k posta berria 15 minuturo inguru begiratzen du, Android-ek uzten dionean. Sarrera-ontzietako mezu berriak eta edozein karpetatako VIPen mezuak jakinarazten zaizkizu.';

  @override
  String get settingsNoAccounts => 'Konturik ez';

  @override
  String get settingsVipOnly => 'VIPak soilik';

  @override
  String get settingsVipOnlyDetail => 'Zure VIPen mezuak soilik';

  @override
  String get settingsHideContent => 'Ezkutatu edukia';

  @override
  String get settingsHideContentFooterOn =>
      'Jakinarazpenek «Mezu berria» eta kontua bakarrik erakusten dituzte, ez nork idatzi duen edo zertaz.';

  @override
  String get settingsHideContentFooterOff =>
      '«Ezkutatu edukia» aukerak igorlea, gaia eta aurrebista blokeo-pantailatik eta jakinarazpenetatik kanpo uzten ditu.';

  @override
  String get settingsBackgroundAppRefresh => 'Atzeko planoko freskatzea';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Posta berria atzeko planoan iristen da soilik Atzeko planoko freskatzea Loupe-rentzat aktibatuta badago Ezarpenak aplikazioan. iOS-ek ezin du konexio bat irekita mantendu zure sarrera-ontziekin; beraz, ez dago Berehalako entregarik.';

  @override
  String get settingsInstantDelivery => 'Berehalako entrega';

  @override
  String get settingsInstantDeliveryFooter =>
      'Berehalako entregak (esperimentala) konexio bat irekita mantentzen du zure sarrera-ontziekin, posta berria segundo gutxitan irits dadin. «Posta berriaren zain» jakinarazpen isil bat erakusten du, eta bateria gehiago erabiltzen du.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android-ek Berehalako entrega gera dezake bateria aurrezteko. Utzi Loupe-ri bateria murriztapenik gabe erabiltzen, martxan jarrai dezan.';

  @override
  String get settingsExperimental => 'Esperimentala';

  @override
  String get settingsComingSoon => 'Laster';

  @override
  String get settingsAllowUnrestrictedBattery => 'Baimendu bateria murriztapenik gabe erabiltzea';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push aukerari esker, posta berriak berehala esnatzen du Loupe, zure posta-zerbitzuak onartzen badu. Push mezuak Google-ren push zerbitzutik pasatzen dira eta ez dute postarik, «begiratu orain» besterik ez.';

  @override
  String get settingsPushUnavailableFooter =>
      'Telefono honek ezin du push mezurik jaso: Google Play zerbitzuak eta sareko konexioa behar dira. Hala ere, Loupe-k 15 minuturo inguru begiratzen du posta.';

  @override
  String get settingsCopyPushToken => 'Kopiatu push tokena';

  @override
  String get settingsPushTokenCopied => 'Push tokena kopiatu da';

  @override
  String get settingsSendTestNotification => 'Bidali proba-jakinarazpena';

  @override
  String get settingsAppIconBadge => 'Aplikazio-ikonoaren bereizgarria';

  @override
  String get settingsBadgeNote =>
      'Bereizgarria eguneratu egiten da Loupe-k posta begiratzen duen bakoitzean, atzeko planoan ere bai.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Telefono honen hasierako pantailak ez du zenbakirik erakusten aplikazioen ikonoetan. Bereizgarria eguneratu egiten da Loupe-k posta begiratzen duen bakoitzean, atzeko planoan ere bai.';

  @override
  String get settingsTestNotificationBody => 'Posta berriaren jakinarazpenak horrelakoak dira.';

  @override
  String get settingsAccountRemoved => 'Kontu hau kendu da.';

  @override
  String get settingsAccountHeader => 'Kontua';

  @override
  String get settingsAccountDescription => 'Deskribapena';

  @override
  String get settingsAccountDescriptionHint => 'Lana, Pertsonala…';

  @override
  String get settingsEmail => 'Helbide elektronikoa';

  @override
  String get settingsColour => 'Kolorea';

  @override
  String get settingsColourFooter => 'Kontu honen mezuak markatzen ditu Sarrera-ontzi guztiak atalean.';

  @override
  String settingsColourNumber(int number) {
    return 'Kolorea $number';
  }

  @override
  String get settingsSendingHeader => 'Bidalketa';

  @override
  String get settingsSendingFooter =>
      'Identitate bakoitzak bere sinadura du. Erantzunak mezua jaso zen helbidetik bidaltzen dira.';

  @override
  String get settingsFoldersHeader => 'Karpetak';

  @override
  String get settingsFoldersFooter =>
      'Loupe-k harpidetutako karpetak erakusten eta sinkronizatzen ditu, Thunderbird-ek bezala. Sarrera-ontzia, Zirriborroak, Bidalitakoak, Zabor-posta, Zakarrontzia eta Artxiboa beti agertzen dira.';

  @override
  String get settingsShowAllFolders => 'Erakutsi karpeta guztiak';

  @override
  String get settingsIncoming => 'Sarrerakoa';

  @override
  String get settingsOutgoing => 'Irteerakoa';

  @override
  String get settingsConnectionNotEncrypted => 'Zifratu gabea';

  @override
  String get settingsSignIn => 'Saio-hasiera';

  @override
  String get settingsSignInExpired => 'Iraungita';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider zerbitzuak jada ez du onartzen Loupe-ren saio-hasiera kontu honetarako; beraz, bere posta ez da sinkronizatzen ari. Hasi saioa berriro konpontzeko.';
  }

  @override
  String get settingsSignInAgain => 'Hasi saioa berriro';

  @override
  String get settingsSigningIn => 'Saioa hasten…';

  @override
  String get settingsRemoveAccount => 'Kendu kontua';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '«$account» kendu?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Bere posta eta ezarpenak telefono honetatik kentzen dira. Zerbitzarian ez da ezer ezabatzen.';

  @override
  String get settingsManageFolders => 'Kudeatu karpetak';

  @override
  String get settingsNoFolders => 'Ez dago karpetarik oraindik.';

  @override
  String get settingsManageFoldersFooter =>
      'Harpidetutako karpetak Postontziak pantailan agertzen dira eta atzeko planoan sinkronizatzen dira. Kontu bera erabiltzen duten beste posta-aplikazioek ere harpidetza horiei jarraitu ohi diete.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Zure Smart Mailboxes gordetzen ditu zure beste gailuetarako. Ezkutatuta dago Postontziak pantailan.';

  @override
  String get settingsFolderAlwaysShown => 'Beti ikusgai';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Harpidetu $folder karpetara';
  }

  @override
  String get settingsIdentities => 'Identitateak';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Lehen identitatea da mezu berrietarako lehenetsia. Arrastatu ordena aldatzeko.';

  @override
  String get settingsIdentitiesFooterSingle => 'Mezu berrietarako identitate lehenetsia.';

  @override
  String get settingsIdentitiesReplyFooter => 'Erantzun bat mezua jaso zuen identitatetik bidaltzen da.';

  @override
  String get settingsIdentityDefault => 'Lehenetsia';

  @override
  String settingsIdentityReorder(String email) {
    return 'Lekuz aldatu: $email';
  }

  @override
  String get settingsAddIdentity => 'Gehitu identitatea';

  @override
  String get settingsNewIdentity => 'Identitate berria';

  @override
  String get settingsIdentity => 'Identitatea';

  @override
  String get settingsIdentityNameHint => 'Zure izena';

  @override
  String get settingsReplyTo => 'Erantzun honi';

  @override
  String get settingsSignature => 'Sinadura';

  @override
  String get settingsSignatureFooter => '«-- » marraren azpian gehitzen da identitate honetako mezuetan.';

  @override
  String get settingsNoSignature => 'Sinadurarik ez';

  @override
  String get settingsCopyToMyself => 'Kopia niri';

  @override
  String get settingsCopyToMyselfFooter => 'Identitate honetako mezu guztiei gehitzen zaie.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Erabili hauei erantzuteko';

  @override
  String get settingsReplyPatternsFooter =>
      'Helbide hauetara bidalitako mezuei emandako erantzunak identitate honetatik bidaltzen dira. * ikurrak edozer adierazten du: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Helbide bat, edo * ikurrak edozer adierazten duen eredu bat.';

  @override
  String get settingsAddReplyPattern => 'Gehitu helbidea edo eredua';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Kendu $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Eredu baliogabea';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» ez da helbide bat, ezta *@example.com bezalako eredu bat ere.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Helbiderik ez';

  @override
  String get settingsIdentityNoAddressMessage => 'Idatzi bidaltzeko helbide elektronikoa.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Helbide baliogabea';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Erantzun honi: «$address» ez da baliozko helbide elektronikoa.',
      'cc': 'Cc: «$address» ez da baliozko helbide elektronikoa.',
      'bcc': 'Bcc: «$address» ez da baliozko helbide elektronikoa.',
      'other': '«$address» ez da baliozko helbide elektronikoa.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Gorde identitatea';

  @override
  String get settingsDiscardChanges => 'Baztertu aldaketak';

  @override
  String get settingsDeleteIdentity => 'Ezabatu identitatea';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '«$email» ezabatu?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Hortik dagoeneko bidalitako mezuak dauden bezala geratzen dira.';

  @override
  String get settingsLastIdentityFooter => 'Kontu batek identitate bat behar du gutxienez.';

  @override
  String get rulesTitle => 'Arauak';

  @override
  String get rulesNewRule => 'Arau berria';

  @override
  String get rulesLoadError => 'Ezin izan dira arauak kargatu.';

  @override
  String get rulesEmptyTitle => 'Araurik ez';

  @override
  String get rulesEmptyText =>
      'Arauek posta berria antolatu, etiketatu eta markatu egiten dute zuretzat. Sortu bat goiko idazteko botoiarekin, edo bilaketa batetik «Bihurtu arau» aukerarekin.';

  @override
  String get rulesListFooter =>
      'Arauak goitik behera exekutatzen dira Sarrera-ontziko posta berrian. Eduki sakatuta arau bat lekuz aldatzeko.';

  @override
  String get rulesChangeError => 'Ezin izan da araua aldatu';

  @override
  String get rulesConditionEveryMessage => 'Mezu guztiak';

  @override
  String rulesMoveRule(String rule) {
    return 'Lekuz aldatu: $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule aktibatuta';
  }

  @override
  String get rulesServerRulesHeader => 'Zerbitzariko arauak';

  @override
  String get rulesServerRulesFooter =>
      'Zerbitzariko arauak posta-zerbitzarian exekutatzen dira posta iristen den heinean, baita telefono hau itzalita dagoenean ere. «loupe» izeneko Sieve script batean gordetzen dira.';

  @override
  String get rulesStatusUnknown => 'Ezezaguna';

  @override
  String get rulesStatusError => 'Ezin izan zaio zerbitzariari galdetu.';

  @override
  String get rulesStatusChecking => 'Egiaztatzen…';

  @override
  String rulesStatusViaInclude(String script) {
    return '«$script» scriptetik exekutatzen dira.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» da script aktiboa. Sakatu Loupe-ren arauak ere exekuta ditzan.';
  }

  @override
  String get rulesStatusNoScript =>
      'Zerbitzarian ez dago script aktiborik. Zerbitzariko arau bat gordetzean Loupe-rena aktibatzen da.';

  @override
  String get rulesStatusUnavailable => 'Ez dago erabilgarri';

  @override
  String get rulesStatusNoSieve => 'Kontu honen zerbitzariak ez du Sieve eskaintzen (ManageSieve edo JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mugitu hona: $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mugitu karpeta batera';

  @override
  String rulesActionTag(String tag) {
    return 'Etiketatu: $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Kendu etiketa: $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Utzi Sarrera-ontzian';

  @override
  String rulesActionForward(String address) {
    return 'Birbidali hona: $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Birbidali hona: $address, kopiarik gorde gabe';
  }

  @override
  String get rulesActionStop => 'Gelditu';

  @override
  String get rulesNoActions => 'Ez du ezer egiten oraindik';

  @override
  String get rulesLocationDevice => 'Gailua';

  @override
  String get rulesLocationServer => 'Zerbitzaria';

  @override
  String get rulesLocationThisDevice => 'Gailu hau';

  @override
  String get rulesNewRuleTitle => 'Arau berria';

  @override
  String get rulesEditRuleTitle => 'Editatu araua';

  @override
  String get rulesDefaultNameEveryMessage => 'Mezu guztiak';

  @override
  String get rulesConditionHeader => 'Mezu berri bat honekin bat datorrenean';

  @override
  String get rulesConditionFooter =>
      'Idatzi bilaketa batean bezala: from:, to:, s: (gaia), b: (gorputza), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Kontuak';

  @override
  String get rulesAllAccounts => 'Kontu guztiak';

  @override
  String get rulesRemovedAccount => 'Kendutako kontua';

  @override
  String get rulesAccountsFooter => 'Kontu guztietarako arau batek geroago gehitzen dituzun kontuak ere hartzen ditu.';

  @override
  String get rulesActionsHeader => 'Orduan';

  @override
  String get rulesForwardingFooter =>
      'Birbidaltzeak bat datorren mezu bakoitza beste helbide batera bidaltzen du iristen den unean, baita telefono hau itzalita dagoenean ere. Hornitzaile batzuek mugatu egiten dute zenbat posta birbidal daitekeen.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Birbidaltzea zerbitzariko arauetan bakarrik dabil; beraz, hemen ez da agertzen.';

  @override
  String rulesRemoveAction(String action) {
    return 'Kendu: $action';
  }

  @override
  String get rulesAddAction => 'Gehitu ekintza';

  @override
  String get rulesAddMove => 'Mugitu karpetara…';

  @override
  String get rulesAddTagMenu => 'Gehitu etiketa…';

  @override
  String get rulesRemoveTagMenu => 'Kendu etiketa…';

  @override
  String get rulesAddForward => 'Birbidali hona…';

  @override
  String get rulesStopProcessing => 'Ez prozesatu arau gehiago';

  @override
  String get rulesRunOnHeader => 'Non exekutatu';

  @override
  String get rulesRunOnDeviceFooter =>
      'Gailu honek araua exekutatzen du Sarrera-ontziko posta berrian, Loupe-k posta begiratzen duen bakoitzean.';

  @override
  String get rulesRunOnServerFooter =>
      'Posta-zerbitzariak araua exekutatzen du posta iristen den heinean, baita telefono hau itzalita dagoenean ere. Sieve behar du, ManageSieve (Dovecot, mailcow) edo JMAP (Stalwart) bidez.';

  @override
  String get rulesApplyToExisting => 'Aplikatu lehendik dauden mezuei…';

  @override
  String get rulesDeleteRule => 'Ezabatu araua';

  @override
  String rulesDeleteTitle(String rule) {
    return '«$rule» ezabatu?';
  }

  @override
  String get rulesMoveAccountTitle => 'Zein kontutako karpeta?';

  @override
  String get rulesMoveAccountMessage => 'Beste kontuetako posta izen bereko karpetara joango da kontu horietan.';

  @override
  String get rulesAddTag => 'Gehitu etiketa';

  @override
  String get rulesRemoveTag => 'Kendu etiketa';

  @override
  String get rulesForwardTo => 'Birbidali hona';

  @override
  String get rulesForwardToMessage =>
      'Zerbitzariak bat datorren mezu bakoitza helbide honetara birbidaltzen du, baita telefono hau itzalita dagoenean ere. Erabili zurea den edo fidagarria den helbide bat.';

  @override
  String get rulesNotAnAddressTitle => 'Ez da helbide elektroniko bat';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» ez da birbidaltzeko helbide bat.';
  }

  @override
  String get rulesKeepCopyTitle => 'Kopia bat gorde hemen?';

  @override
  String get rulesKeepCopy => 'Gorde kopia bat';

  @override
  String get rulesDontKeepCopy => 'Ez gorde kopiarik';

  @override
  String get rulesCheckCondition => 'Egiaztatu baldintza';

  @override
  String get rulesChooseActionTitle => 'Aukeratu ekintza bat';

  @override
  String get rulesChooseActionMessage => 'Gehitu arauak bat datozen mezuekin zer egiten duen.';

  @override
  String get rulesSaveError => 'Ezin izan da araua gorde';

  @override
  String get rulesSaveServerError => 'Ezin izan da zerbitzariko araua gorde';

  @override
  String get rulesRunOnDeviceInstead => 'Exekutatu gailu honetan horren ordez';

  @override
  String get rulesNothingToApplyTitle => 'Ez dago aplikatzeko ezer';

  @override
  String get rulesNothingToApplyMessage => 'Eman lehenik arauari funtzionatzen duen baldintza bat eta ekintza bat.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplikatu «$rule» hemengo mezuei…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Sarrera-ontziak';

  @override
  String get rulesApplyScopeAll => 'Postontzi guztiak';

  @override
  String get rulesFindingMessages => 'Mezuak bilatzen…';

  @override
  String get rulesSearchError => 'Ezin izan da bilatu';

  @override
  String get rulesSearchErrorUnknown => 'Zerbait gaizki joan da.';

  @override
  String get rulesNoMatchesTitle => 'Ez dago bat datorren mezurik';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Han ez dago «$condition» baldintzarekin bat datorren ezer.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '«$rule» $countString mezuri aplikatu?',
      one: '«$rule» mezu bati aplikatu?',
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
      other: 'Aplikatu $countString mezuri',
      one: 'Aplikatu mezu bati',
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
      other: '«$rule» $countString mezuri aplikatu zaie',
      one: '«$rule» mezu bati aplikatu zaio',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Zerbitzariari zer egin dezakeen galdetzen…';

  @override
  String get rulesServerUnreachable => 'Ezin izan da zerbitzaria atzitu.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ezin da zerbitzarian exekutatu: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ezin da $account kontuaren zerbitzarian exekutatu: $problem';
  }

  @override
  String get rulesShowScript => 'Erakutsi scripta';

  @override
  String get rulesHideScript => 'Ezkutatu scripta';

  @override
  String get rulesMatchingHeader => 'Bat datozen mezuak';

  @override
  String get rulesMatchingHeaderLoading => 'Bat datozen mezuak…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bat datozen $countString mezu',
      one: 'Bat datorren mezu $countString',
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
      other: 'Bat datozen $countString+ mezu',
      one: 'Bat datorren $countString+ mezu',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Azken 30 egunetakoak. Arauak berak posta berrian bakarrik jarduten du, lehendik dauden mezuei aplikatzen ez badiezu.';

  @override
  String rulesConditionError(String error) {
    return 'Baldintzak errore bat du: $error';
  }

  @override
  String get rulesPreviewNoSender => '(igorlerik ez)';

  @override
  String get rulesPreviewNoSubject => '(gairik ez)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'eta beste $countString',
      one: 'eta beste $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ezer ez azken 30 egunetan.';

  @override
  String get rulesIncludeTitle => 'Aktibatu zerbitzariko arauak';

  @override
  String get rulesIncludeLeaveOff => 'Utzi desaktibatuta';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Zerbitzariak dagoeneko exekutatzen ditu Loupe-ren arauak $account kontuan.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» da $account kontuaren zerbitzariko script aktiboa; beraz, zerbitzariak hura exekutatzen du, eta ez Loupe-ren arauak. Loupe-k ez du ordeztuko. Lerro hauek gehi diezazkioke, eta orduan zerbitzariak Loupe-ren arauak exekutatuko ditu scriptaren beraren arauen ondoren:';
  }

  @override
  String get rulesShowWholeScript => 'Erakutsi script osoa';

  @override
  String get rulesHideWholeScript => 'Ezkutatu script osoa';

  @override
  String rulesIncludeFootnote(String script) {
    return '«$script» scriptean ez da beste ezer aldatzen. Geroago bere iragazkiak webmailean editatzen badira, baliteke webmailak lerro hauek gabe berridaztea; orduan, Loupe-k zerbitzariko arauak desaktibatuta erakutsiko ditu berriro.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Gehitu «$script» scriptari';
  }

  @override
  String get subscriptionsTitle => 'Harpidetzak';

  @override
  String get subscriptionsNewsletters => 'Buletinak';

  @override
  String get subscriptionsDiscussions => 'Eztabaidak';

  @override
  String get subscriptionsFilter => 'Iragazi';

  @override
  String get subscriptionsFilterNeverRead => 'Inoiz irakurri gabeak';

  @override
  String get subscriptionsFilterRarelyRead => 'Gutxitan irakurriak';

  @override
  String get subscriptionsFilterAll => 'Denak';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Ezin izan dira harpidetzak zenbatu';

  @override
  String get subscriptionsNoMatches => 'Emaitzarik ez';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ez dago «$text» izeneko buletinik.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ez dago «$text» izeneko zerrendarik.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Buletinik ez';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Buletinak eta beste posta masiboa hemen agertzen dira iristen direnean.';

  @override
  String get subscriptionsNothingNeverRead => 'Ezer ez «Inoiz irakurri gabeak» atalean';

  @override
  String get subscriptionsNothingRarelyRead => 'Ezer ez «Gutxitan irakurriak» atalean';

  @override
  String get subscriptionsNothingFilteredDetail => 'Jasotzen duzun guztitik zerbait irakurtzen duzu.';

  @override
  String get subscriptionsNoDiscussions => 'Eztabaidarik ez';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Idatz diezaiekezun posta-zerrendak hemen agertzen dira haien posta iristen denean.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Hainbat pertsonak idazten dieten zerrendak. Eduki sakatuta bat Postontziak pantailan ainguratzeko, testu soil gisa irakurtzeko edo Buletinak fitxara eramateko.';

  @override
  String get subscriptionsPrivacyNote =>
      'Telefono honetan zenbatua, deskargatutako postatik; ez da ezer inora bidaltzen horretarako. Loupe igorle batekin harremanetan jartzen da «Kendu harpidetza» sakatzen duzunean bakarrik: klik bakarreko aukerak «List-Unsubscribe=One-Click» bakarrik bidaltzen du igorleak emandako helbidera, cookierik eta zuri buruzko beste ezer gabe, eta ez ditu inoiz bere orriak edo irudiak kargatzen.';

  @override
  String get subscriptionsVolumeNone => 'Azkenaldian ezer ez';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / hilean';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / hilean';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '%$percent';
  }

  @override
  String get subscriptionsPercentUnderOne => '< %1';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'irakurria: $percent';
  }

  @override
  String get subscriptionsStillSending => 'Bidaltzen jarraitzen du';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Harpidetza kenduta: $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Harpidetza kentzeko orria irekita: $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ukitu bakarra · $site webgunearekin konektatzen da';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Posta bidez, hona: $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Webgunean: $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Kendu harpidetza';

  @override
  String get subscriptionsUnsubscribeAgain => 'Kendu harpidetza berriro';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Artxibatu Sarrera-ontziko $countString mezu',
      one: 'Artxibatu Sarrera-ontziko mezu bat',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Sortu araua…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mugitu edo artxibatu bere etorkizuneko posta';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratatu eztabaida gisa';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Jendeak idazten dion zerrenda bat: irakurri foro gisa';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratatu buletin gisa';

  @override
  String get subscriptionsBlockSender => 'Blokeatu igorlea';

  @override
  String get subscriptionsBlock => 'Blokeatu';

  @override
  String get subscriptionsBlocked => 'Blokeatuta';

  @override
  String get subscriptionsBlockedDetail => 'Posta berria Zabor-postara doa';

  @override
  String get subscriptionsPin => 'Ainguratu Postontziak pantailan';

  @override
  String get subscriptionsUnpin => 'Desainguratu Postontziak pantailatik';

  @override
  String get subscriptionsOpenDefaultView => 'Ireki ikuspegi lehenetsian';

  @override
  String get subscriptionsOpenPlainText => 'Ireki testu soil gisa (Mono)';

  @override
  String get subscriptionsPinned => 'Ainguratuta';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString irakurri gabe',
      one: '$countString irakurri gabe',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Orain ez dago igorle honen postarik.';

  @override
  String get subscriptionsLatestMessages => 'AZKEN MEZUAK';

  @override
  String get subscriptionsMail => 'Posta';

  @override
  String get subscriptionsNoneIn90Days => 'Ezer ez 90 egunetan';

  @override
  String get subscriptionsRead => 'Irakurria';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString/$totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Azkena jasoa';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Karpetak', one: 'Karpeta');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Bidaltzen jarraitzen du';

  @override
  String get subscriptionsUnsubscribedTitle => 'Harpidetza kenduta';

  @override
  String subscriptionsSince(String date) {
    return 'noiztik: $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'orria irekita: $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender igorleak ez du esaten nola kendu harpidetza.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender igorleak ez du esaten nola kendu harpidetza. Horren ordez, blokea dezakezu.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return '$sender igorlearen harpidetza kentzen…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return '$sender igorlearen harpidetza kendu da.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Ezin izan da harpidetza kendu: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Ezin izan da harpidetza automatikoki kendu';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Bidali harpidetza kentzeko mezua';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Ireki $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site ireki?';
  }

  @override
  String get subscriptionsOpen => 'Ireki';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender igorleak bere webgunean kentzen ditu harpidetzak. Orria Loupe-ren arakatzailean irekiko da; amaitu han.';
  }

  @override
  String get subscriptionsWebInsecure => 'Webgune honekiko konexioa ez dago zifratuta.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Kontuz: helbide honek $site imitatzen du itxura bereko letrekin.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Kontuz: helbide honek beste webgune bat imitatzen du itxura bereko letrekin.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Ezin izan da $site ireki.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe-k gaurko data gordetzen du, eta $sender igorleak idazten jarraitzen badu jakinaraziko dizu.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return '$sender igorlearen harpidetza kendu?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe $site webgunearekin konektatuko da harpidetza kentzeko.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Hau da Loupe igorle baten webgunearekin konektatzen den aldi bakarra. «List-Unsubscribe=One-Click» bakarrik bidaltzen du $sender igorleak emandako helbidera, cookierik eta zuri buruzko beste ezer gabe, eta ez du orria kargatzen.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Harpidetza kentzeko esteka ez da interneteko helbide segurua.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site webguneak ez du garaiz erantzun.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Ezin izan da $site atzitu.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site webguneak eskaera beste orri batera bidali du, eta Loupe-k ez du hura jarraitzen.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site webguneak eskaera ukatu du ($status errorea).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Ez dago harpidetza kentzeko mezua bidaltzeko konturik.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe-k mezu bat bidaliko du $from helbidetik $to helbidera, «$subject» gaiarekin.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Harpidetza kentzeko mezua bidali da hona: $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender blokeatu?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Zerrenda honetako posta berria Zabor-postara joango da. Hori Ezarpenak › Arauak atalean alda dezakezu.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return '$address helbideko posta berria Zabor-postara joango da. Hori Ezarpenak › Arauak atalean alda dezakezu.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender blokeatu da.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eraman $count Zabor-postara',
      one: 'Eraman bat Zabor-postara',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokeatu $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender Buletinak atalean dago orain.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender Eztabaidak atalean dago orain.';
  }

  @override
  String get appLiveGateTitle => 'Ezin izan dira zure kontuak ireki';

  @override
  String get appLiveGateUnavailableBuild => 'Benetako kontuak ez daude erabilgarri bertsio honetan oraindik.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe-k ezin izan du irakurri telefono honetan zure posta babesten duen gakoa. Askotan aldi baterakoa da: saiatu berriro, edo berrabiarazi telefonoa.';

  @override
  String get appLiveGateKeyMissing =>
      'Telefono honetan zure posta babesten duen gakoa desagertu egin da; babeskopia bat leheneratu ondoren gerta daiteke. Zure posta zerbitzarian dago oraindik.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Ezin da telefono honetako posta-datu-basea irakurri: hondatuta dago, edo bere gakoa aldatu da. Zure posta zerbitzarian dago oraindik.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Zerbait gaizki joan da zure kontuak irekitzean ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Honek zure kontuak eta telefono honetan gordetako posta ezabatzen ditu, Irteera-ontzian zain dauden mezuak barne. Zure zerbitzarietako posta ez da ukitzen; gehitu berriro zure kontuak gero.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Ezabatu eta hasi berriro';

  @override
  String get appLiveGateUseDemo => 'Erabili demo-posta';

  @override
  String get appLiveGateReset => 'Berrezarri telefono honetako posta…';

  @override
  String get attachmentsUntitled => 'Eranskina';

  @override
  String get attachmentsUntitledFile => 'Izengabea';

  @override
  String get attachmentsOpenIn => 'Ireki honekin…';

  @override
  String get attachmentsSaveToFiles => 'Gorde fitxategietan';

  @override
  String get attachmentsShareMenu => 'Partekatu…';

  @override
  String get attachmentsDownloadError => 'Ezin izan da eranskina deskargatu. Egiaztatu konexioa eta saiatu berriro.';

  @override
  String get attachmentsShareError => 'Ezin izan da eranskina partekatu.';

  @override
  String attachmentsNoApp(String type) {
    return 'Gailu honetako aplikazio batek ere ez du fitxategi hau irekitzen ($type). Probatu «Partekatu» horren ordez.';
  }

  @override
  String get attachmentsOpenInError => 'Ezin izan da eranskina beste aplikazio batean ireki.';

  @override
  String attachmentsSaved(String name) {
    return '«$name» gorde da';
  }

  @override
  String get attachmentsSaveError => 'Ezin izan da eranskina gorde.';

  @override
  String get attachmentsGone => 'Eranskin hau ez dago erabilgarri jada.';

  @override
  String get attachmentsDownloadFailed => 'Ezin izan da eranskina deskargatu.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count orri', one: 'Orri $count');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size datu mugikorrekin';
  }

  @override
  String get attachmentsLargeDownload => 'Eranskin hau handia da. Deskargatu orain, edo geroago Wi-Fi bidez.';

  @override
  String get attachmentsDownload => 'Deskargatu';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size deskargatzen…';
  }

  @override
  String get attachmentsDownloading => 'Deskargatzen…';

  @override
  String get attachmentsTooLarge => 'Handiegia hemen aurrebista erakusteko.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Lehen $shown erakusten dira, $total guztira. Kopiatu, partekatu edo gorde osorik lortzeko.';
  }

  @override
  String get attachmentsPdfUnavailable => 'PDF hau ezin da hemen erakutsi (baliteke pasahitzez babestuta egotea).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page/$count';
  }

  @override
  String get attachmentsModeTable => 'Taula';

  @override
  String get attachmentsModeText => 'Testua';

  @override
  String get attachmentsModeMessage => 'Mezua';

  @override
  String get attachmentsModeSource => 'Iturburua';

  @override
  String get attachmentsDontWrap => 'Ez doitu lerroak';

  @override
  String get attachmentsWrap => 'Doitu lerroak';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines lerro', one: 'lerro $lines');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiatu dena';

  @override
  String get attachmentsCopied => 'Kopiatuta';

  @override
  String get attachmentsImageUnavailable => 'Irudi hau ezin da hemen erakutsi. Probatu «Ireki honekin…».';

  @override
  String get attachmentsEmlNoSubject => '(Gairik ez)';

  @override
  String get attachmentsEmlFrom => 'Nork';

  @override
  String get attachmentsEmlTo => 'Nori';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Mezu honek ez du testurik.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eranskinak: $names',
      one: 'Eranskina: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Antolatzailea: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eta beste $count gertaera',
      one: 'Eta gertaera bat gehiago',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Irudia';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format irudia';
  }

  @override
  String get attachmentsTypePdf => 'PDF dokumentua';

  @override
  String get attachmentsTypeTsv => 'Tabulazioz bereizitako balioak';

  @override
  String get attachmentsTypeCsv => 'CSV kalkulu-orria';

  @override
  String get attachmentsTypeCalendar => 'Egutegiko gertaera';

  @override
  String get attachmentsTypeEmail => 'Mezu elektronikoa';

  @override
  String get attachmentsTypeContact => 'Kontaktu-txartela';

  @override
  String get attachmentsTypeLog => 'Egunkari-fitxategia';

  @override
  String get attachmentsTypeText => 'Testua';

  @override
  String get attachmentsTypeZip => 'ZIP artxiboa';

  @override
  String get attachmentsTypeArchive => 'Artxibo konprimitua';

  @override
  String get attachmentsTypeWord => 'Word dokumentua';

  @override
  String get attachmentsTypeExcel => 'Excel kalkulu-orria';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint aurkezpena';

  @override
  String get attachmentsTypeWebPage => 'Web-orria';

  @override
  String get attachmentsTypeVideo => 'Bideoa';

  @override
  String get attachmentsTypeAudio => 'Audioa';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension fitxategia';
  }

  @override
  String get attachmentsTypeFile => 'Fitxategia';

  @override
  String get calendarUntitledEvent => 'Gertaera';

  @override
  String get calendarAllDay => 'Egun osoa';

  @override
  String calendarYourTime(String time) {
    return '$time zure orduan';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Sartu: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pertsonak onartu du: $details',
      'tentative': '$name pertsonak behin-behinean onartu du: $details',
      'declined': '$name pertsonak ukatu du: $details',
      'delegated': '$name pertsonak eskuordetu du: $details',
      'other': '$name pertsonak ez du erantzun: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pertsonak gonbidapena onartu du',
      'tentative': '$name pertsonak gonbidapena behin-behinean onartu du',
      'declined': '$name pertsonak gonbidapena ukatu du',
      'delegated': '$name pertsonak gonbidapena eskuordetu du',
      'other': '$name pertsonak ez dio gonbidapenari erantzun',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Sartu';

  @override
  String get calendarOnlineMeeting => 'Lineako bilera';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider bilera';
  }

  @override
  String get calendarOrganizerYou => 'Zu';

  @override
  String get calendarOrganizerLabel => 'antolatzailea';

  @override
  String get calendarStatusAccepted => 'Onartua';

  @override
  String get calendarStatusMaybe => 'Agian';

  @override
  String get calendarStatusDeclined => 'Ukatua';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pertsonak onartu du',
      'tentative': '$name pertsonak behin-behinean onartu du',
      'declined': '$name pertsonak ukatu du',
      'delegated': '$name pertsonak eskuordetu du',
      'other': '$name pertsonak ez du erantzun',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pertsonak onartu du:',
      'tentative': '$name pertsonak behin-behinean onartu du:',
      'declined': '$name pertsonak ukatu du:',
      'delegated': '$name pertsonak eskuordetu du:',
      'other': '$name pertsonak ez du erantzun:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name pertsonak ordu berri bat proposatzen du';
  }

  @override
  String get calendarCounterUnknown => 'Parte-hartzaile batek ordu berri bat proposatzen du';

  @override
  String get calendarDeclineCounter => 'Antolatzaileak ordua mantendu du';

  @override
  String calendarRefresh(String name) {
    return '$name pertsonak azken bertsioa eskatzen du';
  }

  @override
  String get calendarRefreshUnknown => 'Parte-hartzaile batek azken bertsioa eskatzen du';

  @override
  String get calendarCancelled => 'Bertan behera utzita';

  @override
  String get calendarCancelledByOrganizer => 'Antolatzaileak gertaera hau bertan behera utzi du.';

  @override
  String get calendarCancelledLater => 'Gertaera hau geroago bertan behera utzi zen.';

  @override
  String get calendarOutdated => 'Zaharkituta';

  @override
  String get calendarOutdatedDetail => 'Gonbidapen hau geroago eguneratu zen; berriena da baliozkoa.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Kokapena kendu da (lehen: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Kokapena kendu da (lehen: bat ere ez)';

  @override
  String calendarLocationChanged(String location) {
    return 'Kokapen berria: $location';
  }

  @override
  String get calendarNewTitle => 'Izenburu berria';

  @override
  String get calendarRepeatChanged => 'Errepikapena aldatu da';

  @override
  String get calendarUpdated => 'Eguneratua';

  @override
  String get calendarUpdatedInvitation => 'Gonbidapen eguneratua';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Ordu-aldaketa: $before → $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return '«$zone» ordu-zona ezezaguna: orduak idatzi bezala';
  }

  @override
  String calendarNext(String when) {
    return 'Hurrengoa: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gonbidatu',
      one: 'Gonbidatu $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count onartuta');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count agian');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ukatuta');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (zu)';
  }

  @override
  String get calendarAttendeeOptional => 'aukerakoa';

  @override
  String get calendarAttendeeRoom => 'gela';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aurreko bertsio bat onartu zenuen.',
      'tentative': 'Aurreko bertsio bat behin-behinean onartu zenuen.',
      'declined': 'Aurreko bertsio bat ukatu zenuen.',
      'delegated': 'Aurreko bertsio bat eskuordetu zenuen.',
      'other': 'Ez zenion aurreko bertsio bati erantzun.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Onartu';

  @override
  String get calendarMaybe => 'Agian';

  @override
  String get calendarDecline => 'Ukatu';

  @override
  String get calendarCommentHint => 'Iruzkina antolatzailearentzat (aukerakoa)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Zure erantzuna $organizer pertsonari bidaliko zaio $address helbidetik.';
  }

  @override
  String get calendarAddComment => 'Gehitu iruzkina';

  @override
  String get calendarAddToCalendar => 'Gehitu egutegira';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eta beste $count gertaera fitxategian',
      one: 'Eta gertaera bat gehiago fitxategian',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Ez dago gertaera gehitzeko egutegi-aplikaziorik.';

  @override
  String get calendarCantOpenCalendar => 'Ezin izan da egutegia ireki.';

  @override
  String get calendarCantOpenLink => 'Ezin izan da esteka ireki.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return '$provider bilerara sartu?';
  }

  @override
  String get calendarJoinTitle => 'Bilerara sartu?';

  @override
  String calendarJoinOpens(String host) {
    return '$host irekiko du zure arakatzailean.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Kontuz: helbide honek $site imitatzen du itxura bereko letrekin.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Kontuz: helbide honek beste webgune bat imitatzen du itxura bereko letrekin.';

  @override
  String calendarJoinOpen(String host) {
    return 'Ireki $host';
  }

  @override
  String get calendarNoOrganizer => 'Gonbidapen honek ez du erantzuteko antolatzailerik.';

  @override
  String get calendarNoAccount => 'Ez dago erantzuteko konturik.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Onartua', 'tentative': 'Agian', 'other': 'Ukatua'});
    return '$_temp0 · erantzuna bidaltzen honi: $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Onartua', 'tentative': 'Agian', 'other': 'Ukatua'});
    return '$_temp0 · erantzuna bidali da';
  }

  @override
  String get calendarReplyAlreadySent => 'Erantzuna bidalita zegoen jada.';

  @override
  String get calendarReplyNotSent => 'Erantzuna ez da bidali.';

  @override
  String get dataSmimeNeedsDevice =>
      'Zure S/MIME ziurtagiria gailu honetan dago: ireki Loupe mezu hau sinatu eta bidaltzeko.';

  @override
  String dataSigningFailed(String error) {
    return 'Sinatzeak huts egin du: $error';
  }

  @override
  String get keyboardShortcuts => 'Lasterbideak';

  @override
  String get keyboardGroupGeneral => 'Orokorra';

  @override
  String get keyboardGroupMessages => 'Mezuak';

  @override
  String get keyboardGroupCompose => 'Idazketa';

  @override
  String get keyboardCommandPalette => 'Komando-paleta';

  @override
  String get keyboardBackClose => 'Atzera, itxi';

  @override
  String get keyboardNextMessage => 'Hurrengo mezua';

  @override
  String get keyboardPreviousMessage => 'Aurreko mezua';

  @override
  String get keyboardOpenMessage => 'Ireki mezua';

  @override
  String get keyboardMoveToTrash => 'Bota zakarrontzira';

  @override
  String get keyboardToggleRead => 'Markatu irakurritzat edo irakurri gabetzat';

  @override
  String get keyboardToggleFlag => 'Markatu edo kendu marka';

  @override
  String get keyboardCloseDraft => 'Itxi (gorde edo ezabatu zirriborroa)';

  @override
  String get keyboardOr => 'edo';

  @override
  String get keyboardKeyCtrl => 'Ktrl';

  @override
  String get keyboardKeyShift => 'Maius';

  @override
  String get keyboardKeyEnter => 'Sartu';

  @override
  String get keyboardKeyEsc => 'Ihes';

  @override
  String get keyboardKeyDelete => 'Ezabatu';

  @override
  String get keyboardKeyBackspace => 'Atzera-tekla';

  @override
  String get mailingListsMuted => 'Haria isilarazi da. Bertako mezu berriak irakurrita iritsiko dira.';

  @override
  String get mailingListsUnmuted => 'Haria jada ez dago isilarazita.';

  @override
  String get mailingListsMuteThread => 'Isilarazi haria';

  @override
  String get mailingListsUnmuteThread => 'Kendu hariaren isilarazpena';

  @override
  String get mailingListsPin => 'Ainguratu Postontziak pantailan';

  @override
  String get mailingListsUnpin => 'Desainguratu Postontziak pantailatik';

  @override
  String get mailingListsDefaultView => 'Ireki ikuspegi lehenetsian';

  @override
  String get mailingListsPlainText => 'Ireki testu soil gisa (Mono)';

  @override
  String get mailingListsShowMuted => 'Erakutsi isilarazitako hariak';

  @override
  String get mailingListsHideMuted => 'Ezkutatu isilarazitako hariak';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratatu buletin gisa';

  @override
  String get mailingListsOptions => 'Zerrendaren aukerak';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$formatted irakurri gabe');
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Mezu berria zerrendara';

  @override
  String get mailingListsRowUnread => 'Irakurri gabea';

  @override
  String get mailingListsRowMuted => 'Isilarazita';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count erantzun', one: 'Erantzun $count');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Haririk ez';

  @override
  String get mailingListsMutedHidden => 'Isilarazitako hariak ezkutatuta daude.';

  @override
  String get mailingListsTechnicalTitle => 'Zerrenda teknikoak';

  @override
  String get mailingListsTechnicalEmpty => 'Posta-zerrendak hemen agertzen dira haien posta iristen denean.';

  @override
  String get mailingListsTechnicalFooter =>
      'Zerrenda hauetako mezuak testu soil gisa irekitzen dira zabalera finkoko letra-tipoan, eta adabakiak diff gisa erakusten dira. Aa botoiarekin edozein mezuren ikuspegia alda dezakezu oraindik.';

  @override
  String get paletteMoveToMailbox => 'Mugitu postontzira…';

  @override
  String get paletteMarkAllRead => 'Markatu denak irakurritzat';

  @override
  String get paletteExportFolder => 'Esportatu karpeta…';

  @override
  String get paletteGetNewMail => 'Jaso posta berria';

  @override
  String get paletteSnoozed => 'Atzeratuak';

  @override
  String get paletteSubscriptions => 'Harpidetzak';

  @override
  String get paletteDiscussions => 'Eztabaidak';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Posta-zerrenda';

  @override
  String get paletteTag => 'Etiketa';

  @override
  String get paletteSwipeActions => 'Irristatze-ekintzak';

  @override
  String get paletteNotifications => 'Jakinarazpenak';

  @override
  String get paletteRules => 'Arauak';

  @override
  String get paletteEncryption => 'Muturretik muturrerako zifratzea';

  @override
  String get paletteAdvanced => 'Aurreratua';

  @override
  String get paletteAddAccount => 'Gehitu kontua';

  @override
  String get paletteAccount => 'Kontua';

  @override
  String get paletteFolders => 'Karpetak';

  @override
  String get paletteRecentSearch => 'Azken bilaketa';

  @override
  String paletteSearchMail(String query) {
    return 'Bilatu «$query» postan';
  }

  @override
  String get palettePlaceholder => 'Bilatu ekintzak, postontziak, ezarpenak';

  @override
  String get paletteNothingFound => 'Ez da ezer aurkitu';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox berria';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return '«$query» bilaketarekin bat datorren guztia erakusten du.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» Postontziak pantailan gorde da';
  }

  @override
  String get searchMakeRule => 'Bihurtu arau';

  @override
  String get searchSaveSmartMailbox => 'Gorde Smart Mailbox gisa';

  @override
  String get searchNegate => 'Ezeztatu';

  @override
  String get searchDontNegate => 'Ez ezeztatu';

  @override
  String get searchAllMailboxes => 'Postontzi guztiak';

  @override
  String get searchRecent => 'Azken bilaketak';

  @override
  String get searchClear => 'Garbitu';

  @override
  String get searchSuggestions => 'Iradokizunak';

  @override
  String get searchUnreadMessages => 'Irakurri gabeko mezuak';

  @override
  String get searchFlaggedMessages => 'Mezu markatuak';

  @override
  String get searchWithAttachments => 'Eranskinak dituzten mezuak';

  @override
  String get searchUnrepliedMessages => 'Erantzun gabeko mezuak';

  @override
  String get searchTags => 'Etiketak';

  @override
  String get searchPeople => 'Jendea';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Nork: $name';
  }

  @override
  String get searchSearching => 'Bilatzen…';

  @override
  String get searchNoResults => 'Emaitzarik ez';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted emaitza',
      one: 'Emaitza $formatted',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Bilaketa-menua';

  @override
  String searchSearchingAccount(String account) {
    return '$account zerbitzarian bilatzen…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Kontua zerbitzarian bilatzen…';

  @override
  String searchAccountFailed(String account) {
    return 'Ezin izan da $account zerbitzarian bilatu';
  }

  @override
  String get searchUnknownAccountFailed => 'Ezin izan da kontua zerbitzarian bilatu';

  @override
  String searchChip(String term) {
    return '$term. Sakatu birritan editatzeko.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ez: $term. Sakatu birritan editatzeko.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerren sarrera-ontzia: hemengo mezu guztiak irakurrita eta irakurri gabe daude, ireki arte.';

  @override
  String searchContradiction(String term) {
    return 'Mezu bat ezin da aldi berean «$term» izan eta ez izan.';
  }

  @override
  String get searchSyncDeviceOnly => 'Gailu honetan soilik';

  @override
  String searchSyncUnsupported(String account) {
    return 'Gailu honetan soilik: $account kontuak ezin du gorde';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Sinkronizatu gabe: $account kontuak formatu berriago bat du';
  }

  @override
  String searchSyncWaiting(String account) {
    return '$account kontuarekin sinkronizatzeko zain';
  }

  @override
  String searchSynced(String account) {
    return '$account kontuarekin sinkronizatuta';
  }

  @override
  String get searchRename => 'Aldatu izena';

  @override
  String get searchEditSearch => 'Editatu bilaketa';

  @override
  String get searchDeleteSmartMailbox => 'Ezabatu Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Aldatu Smart Mailbox-aren izena';

  @override
  String get searchSmartMailboxDeleted => 'Smart Mailbox hau ezabatu egin da.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes gailu honetan geratzen dira.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes zure posta-zerbitzarian gordetzen dira; beraz, zure beste gailuek ere badituzte, baita Thunderbird-ek ere Expression Search Reloaded-ekin. Kontu guztietan bilatzen dutenak $account kontuan gordetzen dira; karpeta bakarrekoak, karpeta horren kontuan.';
  }

  @override
  String get searchSyncVia => 'Sinkronizatu honen bidez';

  @override
  String get searchSyncViaFooter => 'Aukeratu kontu bera gailu guztietan.';

  @override
  String get searchGmailCantKeep => 'Gmail-ek ezin ditu Smart Mailboxes gorde';

  @override
  String get searchKeepOnDevice => 'Gorde Smart Mailboxes gailu honetan soilik';

  @override
  String get searchOnTheServer => 'Zerbitzarian';

  @override
  String get searchServerFooter =>
      'Zerbitzariaren metadatuak (IMAP METADATA) ez dira inongo posta-aplikaziotan ikusten. Metadaturik gabeko zerbitzariek «Loupe Settings» karpeta bat jasotzen dute mezu batekin; Loupe-k Postontziak pantailan ezkutatzen du.';

  @override
  String get searchSyncNow => 'Sinkronizatu orain';

  @override
  String get searchStateUnsupported => 'Ez da onartzen';

  @override
  String get searchStateNewerFormat => 'Formatu berriagoa';

  @override
  String get searchStateFailed => 'Ezin izan da sinkronizatu';

  @override
  String get searchStateSyncing => 'Sinkronizatzen…';

  @override
  String get searchStateWaiting => 'Zain';

  @override
  String get searchStateMetadata => 'Zerbitzariaren metadatuak';

  @override
  String get searchStateFolder => 'Loupe Settings karpeta';

  @override
  String get searchStateNothing => 'Ezer gorde gabe';

  @override
  String get sharedBack => 'Atzera';

  @override
  String get sharedYesterday => 'Atzo';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count byte', one: 'Byte $count');
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
  String get sharedSyncNoAccounts => 'Konturik ez';

  @override
  String get sharedSyncChecking => 'Posta begiratzen…';

  @override
  String get sharedSyncFailed => 'Ezin izan da posta begiratu';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Konexiorik gabe';

  @override
  String get sharedSyncJustNow => 'Oraintxe eguneratua';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Duela $minutes minutu eguneratua',
      one: 'Duela minutu $minutes eguneratua',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Eguneratua: $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Eguneratua: $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Sarrera-ontzi guztiak';

  @override
  String get sharedMailboxUnread => 'Irakurri gabeak';

  @override
  String get sharedMailboxFlagged => 'Markatuak';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Zirriborro guztiak';

  @override
  String get sharedMailboxAllSent => 'Bidalitako guztiak';

  @override
  String get sharedMailboxUntitled => 'Postontzia';

  @override
  String get sharedTagImportant => 'Garrantzitsua';

  @override
  String get sharedTagWork => 'Lana';

  @override
  String get sharedTagPersonal => 'Pertsonala';

  @override
  String get sharedTagToDo => 'Egitekoa';

  @override
  String get sharedTagLater => 'Geroago';

  @override
  String get sharedTags => 'Etiketak';

  @override
  String get sharedMoveTo => 'Mugitu hona…';

  @override
  String get sharedNoRecipients => 'Hartzailerik ez';

  @override
  String get sharedUnknownSender => 'Igorle ezezaguna';

  @override
  String get sharedOnServer => 'Zerbitzarian';

  @override
  String get sharedAttachment => 'Eranskina';

  @override
  String get sharedSnoozedBadge => 'Atzeratua';

  @override
  String get sharedRowUnread => 'Irakurri gabea';

  @override
  String get sharedRowBackFromSnooze => 'Atzeratzetik itzulia';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Markatua';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu artxibatu dira',
      one: 'Mezu $count artxibatu da',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu ezabatu dira',
      one: 'Mezu $count ezabatu da',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu Sarrera-ontzira mugitu dira',
      one: 'Mezu $count Sarrera-ontzira mugitu da',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu zakarrontzira bota dira',
      one: 'Mezu $count zakarrontzira bota da',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu zabor-postara eraman dira',
      one: 'Mezu $count zabor-postara eraman da',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu hona mugitu dira: $mailbox',
      one: 'Mezu $count hona mugitu da: $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu postontzi batera mugitu dira',
      one: 'Mezu $count postontzi batera mugitu da',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu atzeratu dira, noiz arte: $time',
      one: 'Mezu $count atzeratu da, noiz arte: $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Gailu honetan soilik atzeratuta, noiz arte: $time. Zerbitzariak ezin ditu atzeratze-orduak gorde.';
  }

  @override
  String get sharedMoveOneAccount => 'Hautatu kontu bakarreko mezuak mugitzeko.';

  @override
  String get sharedSnoozeTitle => 'Atzeratu';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Aldatu atzeratze-ordua';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu betiko ezabatu?',
      one: 'Mezu hau betiko ezabatu?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ezin da desegin.';

  @override
  String get sharedDeletePermanently => 'Ezabatu betiko';

  @override
  String get sharedSwipeRead => 'Irakurria';

  @override
  String get sharedSwipeUnread => 'Irakurri gabea';

  @override
  String get sharedSwipeInbox => 'Sarrera';

  @override
  String get sharedSwipeDelete => 'Ezabatu';

  @override
  String get sharedTrash => 'Zakarrontzia';

  @override
  String get sharedSwipeSnooze => 'Atzeratu';

  @override
  String get sharedWakeNow => 'Ekarri orain';

  @override
  String get sharedChangeSnoozeTime => 'Aldatu atzeratze-ordua…';

  @override
  String get sharedSnooze => 'Atzeratu…';

  @override
  String get sharedTag => 'Etiketatu…';

  @override
  String get sharedMoveMessage => 'Mugitu mezua…';

  @override
  String get sharedNotJunk => 'Ez da zabor-posta';

  @override
  String get accountSetupTitle => 'Gehitu kontua';

  @override
  String get accountSetupTitleDone => 'Kontua gehitu da';

  @override
  String get accountSetupAddressTitle => 'Gehitu posta-kontu bat';

  @override
  String get accountSetupAddressText => 'Loupe-k hornitzaile gehienen ezarpenak aurkitzen ditu.';

  @override
  String get accountSetupNameHint => 'Zure izena';

  @override
  String get accountSetupEmail => 'Helbide elektronikoa';

  @override
  String get accountSetupEmailHint => 'izena@example.com';

  @override
  String get accountSetupContinue => 'Jarraitu';

  @override
  String get accountSetupLookingUp => 'Ezarpenak bilatzen…';

  @override
  String get accountSetupImport => 'Inportatu Thunderbird-etik';

  @override
  String get accountSetupInvalidEmail => 'Idatzi baliozko helbide elektroniko bat.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Ezin izan dira $domain domeinuaren ezarpenak aurkitu. Idatzi behean.';
  }

  @override
  String get accountSetupCheckServers => 'Egiaztatu zerbitzarien izenak eta atakak.';

  @override
  String get accountSetupEnterPassword => 'Idatzi zure pasahitza.';

  @override
  String get accountSetupConnecting => 'Konektatzen…';

  @override
  String accountSetupWaitingFor(String provider) {
    return '$provider zerbitzuaren zain…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Ezin izan da orria ireki.';

  @override
  String get accountSetupCouldNotSaveName => 'Ezin izan da izena gorde.';

  @override
  String get accountSetupTrustCertificate => 'Jo ziurtagiri hau fidagarritzat';

  @override
  String get accountSetupPasswordRequired => 'Derrigorrezkoa';

  @override
  String get accountSetupShowPassword => 'Erakutsi pasahitza';

  @override
  String get accountSetupHidePassword => 'Ezkutatu pasahitza';

  @override
  String get accountSetupAppPassword => 'Aplikazio-pasahitza';

  @override
  String get accountSetupApiToken => 'API tokena';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Sarrerakoa · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Irteerakoa · SMTP';

  @override
  String get accountSetupSignIn => 'Hasi saioa';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Hasi saioa $provider erabiliz';
  }

  @override
  String get accountSetupUseAppPassword => 'Erabili aplikazio-pasahitz bat';

  @override
  String get accountSetupUseAppPasswordInstead => 'Erabili aplikazio-pasahitz bat horren ordez';

  @override
  String get accountSetupUseDifferentAddress => 'Erabili beste helbide bat';

  @override
  String get accountSetupHowToCreateAppPassword => 'Nola sortu aplikazio-pasahitz bat';

  @override
  String get accountSetupHowToCreateOne => 'Nola sortu';

  @override
  String get accountSetupGoogleNote =>
      'Google-ren orrian hasten duzu saioa, eta Loupe-k ez du inoiz zure pasahitza ikusten. Baimendu Loupe-ri zure posta irakurtzen, bidaltzen eta antolatzen.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Hasi saioa Google erabiliz» ez dago erabilgarri bertsio honetan oraindik. Aplikazio-pasahitz batekin konekta zaitezke horren ordez (zure Google kontuan bi urratseko egiaztapena behar da).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Sortu aplikazio-pasahitz bat zure Google kontuan eta itsatsi behean.';

  @override
  String get accountSetupMicrosoftNote =>
      'Microsoft-en orrian hasten duzu saioa, eta Loupe-k ez du inoiz zure pasahitza ikusten. Outlook.com eta Hotmail-ekin dabil, baita Microsoft 365eko laneko edo ikastetxeko kontuekin ere.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Microsoft-ekin saioa hastea geroagoko bertsio batean iritsiko da. Outlook, Hotmail eta Microsoft 365 kontuek behar dute: jada ez dituzte posta-aplikazioen pasahitzak onartzen.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail-ek aplikazio-pasahitz espezifiko bat behar du, ez zure Apple kontuaren pasahitza.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail-ek aplikazio-pasahitz bat behar du, ez zure kontuaren pasahitza.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe Fastmail-era JMAP bidez konektatzen da API token batekin: Settings › Privacy & Security › Manage API tokens, JMAPerako, posta eta bidalketarako sarbidearekin.';

  @override
  String get accountSetupFastmailNote => 'Fastmail-ek aplikazio-pasahitz bat behar du posta-aplikazioetarako.';

  @override
  String get accountSetupServerSettings => 'Zerbitzariaren ezarpenak';

  @override
  String get accountSetupSettingsNotFound => 'Ez dira automatikoki aurkitu';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Hemen aurkituak: $source';
  }

  @override
  String get accountSetupEditSettings => 'Editatu ezarpenak';

  @override
  String get accountSetupSyncing => 'Zure posta sinkronizatzen ari da.';

  @override
  String get accountSetupDescription => 'Deskribapena';

  @override
  String get accountSetupDescriptionHint => 'Lana, Pertsonala…';

  @override
  String get accountSetupColour => 'Kolorea';

  @override
  String accountSetupColourNumber(int number) {
    return 'Kolorea $number';
  }

  @override
  String get accountSetupSaving => 'Gordetzen…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe-k ezin izan du bere posta-datu-basea ireki telefono honetan. Itxi Loupe, ireki berriro eta saiatu berriro.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Zerbait gaizki joan da ($error). Saiatu berriro.';
  }

  @override
  String get accountSetupSecurityNone => 'Bat ere ez';

  @override
  String get accountSetupProtocol => 'Protokoloa';

  @override
  String get accountSetupPort => 'Ataka';

  @override
  String get accountSetupSecurity => 'Segurtasuna';

  @override
  String get accountSetupUsername => 'Erabiltzaile-izena';

  @override
  String get accountSetupUsernameHint => 'Zure helbide elektronikoa';

  @override
  String get accountSetupNoEncryptionTitle => 'Zifratu gabe konektatu?';

  @override
  String get accountSetupNoEncryptionText =>
      'Zure pasahitza eta mezu guztiak testu arrunt gisa bidaiatuko lirateke. Sareko edonork, Wi-Fi publiko batean adibidez, irakur litzake. Erabili hau zure sare propioko zerbitzari baterako soilik.';

  @override
  String get accountSetupUseWithoutEncryption => 'Erabili zifratu gabe';

  @override
  String get accountSetupApiTokenRejected =>
      'API tokena baztertu da. Sortu JMAPerako Fastmail API token bat postarako sarbidearekin, eta itsatsi.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Pasahitza baztertu da. Erabili aplikazio-pasahitz bat, ez zure kontuaren pasahitza.';

  @override
  String get accountSetupPasswordRejected => 'Pasahitza baztertu da. Egiaztatu eta saiatu berriro.';

  @override
  String get accountSetupServerUnreachable =>
      'Ezin da zerbitzaria atzitu. Egiaztatu zerbitzariaren ezarpenak eta zure konexioa.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Zerbitzariaren ziurtagiria ez da fidagarria. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Saio-hasiera bertan behera utzi da. Sakatu «Hasi saioa $provider erabiliz» berriro saiatzeko.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe-k baimena behar du zure Gmail posta irakurtzeko eta bidaltzeko. Hasi saioa berriro eta baimendu sarbidea, Gmail laukia markatuta.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe-k baimena behar du zure posta irakurtzeko eta bidaltzeko. Hasi saioa berriro eta onartu baimenak.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Zure erakundeak Loupe onartu behar du kontu honekin erabili aurretik. Eskatu zure informatika-administratzaileari Loupe-ri administratzaile-baimena emateko Microsoft Entra ID-n, eta saiatu berriro.';

  @override
  String get accountSetupOAuthBlocked =>
      'Zure erakundearen saio-hasierako arauek ez dute Loupe baimentzen gailu honetan. Galdetu zure informatika-administratzaileari.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Ezin izan da $provider atzitu. Egiaztatu zure Interneteko konexioa eta saiatu berriro.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return '$provider bidezko saio-hasiera ez dago ondo konfiguratuta Loupe-ren bertsio honetan. Mesedez, jakinarazi.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return '$provider bidezko saio-hasierak ez du funtzionatu. Saiatu berriro.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider zerbitzuak saioa hasi dizu, baina Gmail-ek sarbidea ukatu du helbide honetarako. Aukeratu kontu bera saioa hastean. Laneko edo ikastetxeko kontuetan, administratzaileak IMAP desaktibatuta izan dezake.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider zerbitzuak saioa hasi dizu, baina posta-zerbitzariak sarbidea ukatu du helbide honetarako. Aukeratu kontu bera saioa hastean. Laneko edo ikastetxeko kontuetan, administratzaileak IMAP desaktibatuta izan dezake.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Ezin da posta-zerbitzaria atzitu. Egiaztatu zure konexioa eta saiatu berriro.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return '$provider bidezko saio-hasiera ez dago erabilgarri bertsio honetan.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Saioa berriro hasi da. $account sinkronizatzen ari da.';
  }

  @override
  String get accountSetupSignInAgain => 'Hasi saioa berriro';

  @override
  String get accountSetupSigningIn => 'Saioa hasten…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider zerbitzuak jada ez du onartzen Loupe-ren saio-hasiera $email helbiderako; beraz, $account ez da sinkronizatzen ari. Hasi saioa berriro bere posta jasotzeko.';
  }

  @override
  String get accountImportTitle => 'Inportatu Thunderbird-etik';

  @override
  String get accountImportPointCamera => 'Zuzendu kamera Thunderbird-ek erakusten duen QR kodera.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned/$total eskaneatuta';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: '$scanned/$total kode eskaneatuta');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kontu orain arte',
      one: 'Kontu $count orain arte',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Ordenagailuan, ireki Thunderbird eta aukeratu Tresnak › Esportatu mugikorrerako. Hautatu zure kontuak, eta eskaneatu erakusten duen kode bakoitza. Kodeak edozein ordenatan eskanea daitezke.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jarraitu $count konturekin',
      one: 'Jarraitu kontu batekin',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Itsatsi testua horren ordez';

  @override
  String get accountImportStartOver => 'Hasi berriro';

  @override
  String get accountImportDuplicateCode => 'Kode hori gehituta dago jada.';

  @override
  String get accountImportRestarted =>
      'Kode hau esportazio berri batekoa da; beraz, aurretik eskaneatutako kodeak alde batera utzi dira.';

  @override
  String get accountImportNotThunderbird => 'Hau ez da Thunderbird-en kontu-kode bat.';

  @override
  String get accountImportNewerVersion =>
      'Kode hau Thunderbird-en bertsio berriago batekoa da. Eguneratu Loupe inportatzeko.';

  @override
  String get accountImportDamaged => 'Ezin izan da Thunderbird kode hau irakurri.';

  @override
  String get accountImportTooLarge => 'Kode hau handiegia da Thunderbird-en esportazio bat izateko.';

  @override
  String get accountImportCouldNotOpenSettings => 'Ezin izan dira ezarpenak ireki.';

  @override
  String get accountImportCameraOffTitle => 'Kamerarako sarbidea desaktibatuta dago';

  @override
  String get accountImportCameraOffText =>
      'Baimendu Loupe-ri kamera erabiltzen ezarpenetan kodea eskaneatzeko, edo itsatsi kodearen testua horren ordez.';

  @override
  String get accountImportNoCameraTitle => 'Kamerarik ez';

  @override
  String get accountImportNoCameraText =>
      'Loupe-k ezin du hemen kamerarik erabili. Itsatsi kodearen testua horren ordez.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera ez da abiarazi';

  @override
  String get accountImportCameraFailedText => 'Saiatu berriro, edo itsatsi kodearen testua horren ordez.';

  @override
  String get accountImportOpenSettings => 'Ireki ezarpenak';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kontu aurkitu dira',
      one: 'Kontu $count aurkitu da',
      zero: 'Ez da konturik aurkitu',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Kode hauetako kontu bat ere ezin izan da irakurri.';

  @override
  String get accountImportChoose => 'Aukeratu Loupe-ra gehitzeko kontuak.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$total kodeetatik, $codes kodeak ez dira eskaneatu; beraz, haien kontuak ez daude zerrendan.',
      one: '$total kodeetatik, $codes. kodea ez da eskaneatu; beraz, bere kontuak ez daude zerrendan.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes eta $last';
  }

  @override
  String get accountImportScanMore => 'Eskaneatu kode gehiago';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Kodeetako $count kontu ezin izan dira irakurri. Baliteke Thunderbird-en bertsio berriago bateko ezarpenak erabiltzea.',
      one: 'Kodeetako kontu bat ezin izan da irakurri. Baliteke Thunderbird-en bertsio berriago bateko ezarpenak erabiltzea.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Eskaneatu berriro';

  @override
  String get accountImportAlreadyAdded => 'Helbide hau duen kontu bat badago Loupe-n.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Gehitzean, $provider erabiliz hasiko duzu saioa, Thunderbird-en bezala.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Gehitu kontua aplikazio-pasahitz batekin (bi urratseko egiaztapena behar da).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird-ek Google bidez hasten du saioa Gmail-en. «Hasi saioa Google erabiliz» geroagoko bertsio batean iritsiko da; bitartean, gehitu kontua aplikazio-pasahitz batekin (bi urratseko egiaztapena behar da).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird-ek arakatzailean hasten du saioa kontu honetan. Loupe-k ezin du hori egin oraindik: erabili aplikazio-pasahitz bat zure hornitzaileak eskaintzen badu.';

  @override
  String get accountImportUnencrypted => 'Zifratu gabe konektatzen da. Erabili hau zure sare propioan soilik.';

  @override
  String get accountImportEnterAgain => 'Idatzi berriro';

  @override
  String get accountImportAdded => 'Gehituta';

  @override
  String accountImportAdding(int index, int total) {
    return '$index/$total gehitzen…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gehitu $count kontu',
      one: 'Gehitu kontu $count',
      zero: 'Gehitu kontuak',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Itsatsi esportazio-testua';

  @override
  String get accountImportPasteText =>
      'Itsatsi Thunderbird-en esportazio-kode baten testua, kode bat lerro bakoitzeko.';

  @override
  String get accountImportPop3 => 'POP3 kontuak ez dira onartzen. Loupe-k posta zerbitzarian gordetzen du IMAP bidez.';

  @override
  String get accountImportKerberos => 'Kontu honek Kerberos bidez hasten du saioa, eta Loupe-k ez du hori onartzen.';

  @override
  String get accountImportNtlm => 'Kontu honek NTLM bidez hasten du saioa, eta Loupe-k ez du hori onartzen.';

  @override
  String get accountImportClientCertificate =>
      'Kontu honek bezero-ziurtagiri batekin hasten du saioa, eta Loupe-k ez du hori onartzen oraindik.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Microsoft-ekin saioa hastea geroagoko bertsio batean iritsiko da. Outlook eta Microsoft 365 kontuek jada ez dituzte posta-aplikazioen pasahitzak onartzen.';

  @override
  String get accountImportEnterPassword => 'Idatzi pasahitza.';

  @override
  String get accountImportEnterAppPassword => 'Idatzi aplikazio-pasahitza.';

  @override
  String get accountImportEnterApiToken => 'Idatzi API tokena.';

  @override
  String get accountImportStorageFailed => 'Loupe-k ezin izan du bere kontuen biltegia ireki. Saiatu berriro geroago.';

  @override
  String get accountImportFailed => 'Ezin izan da kontua gehitu. Saiatu berriro, edo gehitu eskuz.';

  @override
  String get composeNewMessageTitle => 'Mezu berria';

  @override
  String get composeAttach => 'Erantsi';

  @override
  String get composeSendLater => 'Bidali geroago';

  @override
  String composeSendAt(String time) {
    return 'Bidali: $time';
  }

  @override
  String get composeSendHint => 'Sakatu luze geroago bidaltzeko';

  @override
  String get composeNoAccount => 'Gehitu kontu bat posta bidaltzeko.';

  @override
  String get composeTo => 'Nori:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Nork: $email';
  }

  @override
  String get composeFromLabel => 'Nork:';

  @override
  String get composeSubjectLabel => 'Gaia:';

  @override
  String composeReplyTo(String address) {
    return 'Erantzun honi: $address';
  }

  @override
  String get composeFrom => 'Nork';

  @override
  String composeReplyFrom(String email) {
    return 'Erantzun helbide honetatik: $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Bidali helbide honetatik: $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return '$email helbidetik erantzun?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return '$email helbidetik bidali?';
  }

  @override
  String get composeDismiss => 'Baztertu';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ez dago identitate gisa gordeta · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Gorde identitate gisa';

  @override
  String composeAliasSaved(String email) {
    return '$email identitate gisa gorde da.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Helbide baliogabea: $address';
  }

  @override
  String get composeOriginalNotFound => 'Ezin izan da jatorrizko mezua aurkitu.';

  @override
  String get composeDraftNotFound => 'Ezin izan da zirriborroa aurkitu.';

  @override
  String get composeAttachmentsLost => 'Ezin izan dira eranskinak berreskuratu. Gehitu berriro.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Ezin izan dira eranskin batzuk gehitu: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Eranskinek $size dituzte guztira; zerbitzari batzuek ez dituzte hain mezu handiak onartzen.';
  }

  @override
  String get composeAttachFailed => 'Ezin izan da fitxategia erantsi.';

  @override
  String get composeInvalidAddressTitle => 'Helbide baliogabea';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» ez da baliozko helbide elektronikoa.';
  }

  @override
  String get composeNoSubjectTitle => 'Gairik ez';

  @override
  String get composeNoSubjectText => 'Mezu honek ez du gairik. Bidali hala ere?';

  @override
  String get composeSentBeforeChanges =>
      'Zure aldaketak egin aurretik bidali zen; aldaketak Zirriborroak karpetan gorde dira.';

  @override
  String composeScheduled(String time) {
    return 'Programatuta: $time';
  }

  @override
  String get composeSending => 'Bidaltzen…';

  @override
  String get composeSent => 'Bidalita';

  @override
  String get composeSendFailed => 'Ezin izan da bidali. Saiatu berriro.';

  @override
  String get composeAlreadySent => 'Bidalita dago jada.';

  @override
  String get composeDiscardChanges => 'Baztertu aldaketak';

  @override
  String get composeSaveChanges => 'Gorde aldaketak';

  @override
  String get composeDeleteDraft => 'Ezabatu zirriborroa';

  @override
  String get composeSaveDraft => 'Gorde zirriborroa';

  @override
  String get composeDraftSaved => 'Zirriborroa gorde da';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date, $time. $name pertsonak idatzi zuen:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date, $time. Norbaitek idatzi zuen:';
  }

  @override
  String get composeForwardHeader => '---------- Birbidalitako mezua ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Nork: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date, $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Gaia: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Nori: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Gaur beranduago';

  @override
  String get composeTomorrowMorning => 'Bihar goizean';

  @override
  String get composeMondayMorning => 'Astelehen goizean';

  @override
  String get composePickDateTime => 'Aukeratu data eta ordua…';

  @override
  String get composeSendWithoutDelay => 'Bidali berehala';

  @override
  String composeSendTimeToday(String time) {
    return 'Gaur, $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Bihar, $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day, $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Gaur $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Bihar $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Zirriborroa editatzen jarraitu?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Mezu bat ez zen bidali Loupe itxi zenean.',
      'one': '$name pertsonarentzako mezu bat ez zen bidali Loupe itxi zenean.',
      'other': '$name eta beste batzuentzako mezu bat ez zen bidali Loupe itxi zenean.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» ez zen bidali Loupe itxi zenean.',
      'one': '$name pertsonarentzako «$subject» ez zen bidali Loupe itxi zenean.',
      'other': '$name eta beste batzuentzako «$subject» ez zen bidali Loupe itxi zenean.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Jarraitu editatzen';

  @override
  String get composeRecoverySave => 'Gorde zirriborroetan';

  @override
  String get composeRecoveryDiscard => 'Baztertu';

  @override
  String get composeRecoverySaved => 'Zirriborroetan gorde da';

  @override
  String get outboxSectionFailed => 'Bidali gabeak';

  @override
  String get outboxSectionSending => 'Bidaltzen';

  @override
  String get outboxSectionScheduled => 'Programatuak';

  @override
  String get outboxStatusQueued => 'Laster bidaliko da';

  @override
  String get outboxStatusSending => 'Bidaltzen…';

  @override
  String get outboxStatusFailed => 'Bidali gabe';

  @override
  String get outboxNoRecipients => 'Hartzailerik ez';

  @override
  String get outboxNoSubject => '(Gairik ez)';

  @override
  String get outboxSendingFailed => 'Bidalketak huts egin du.';

  @override
  String get outboxEmptyTitle => 'Ez dago bidaltzeko ezer';

  @override
  String get outboxEmptyText => 'Geroago bidaltzen dituzun mezuak hemen itxaroten dute ordua iritsi arte.';

  @override
  String get outboxSendNow => 'Bidali orain';

  @override
  String get outboxReschedule => 'Programatu berriro';

  @override
  String get outboxRescheduleMenu => 'Programatu berriro…';

  @override
  String get outboxRescheduleTitle => 'Programatu berriro';

  @override
  String outboxRescheduled(String time) {
    return 'Berriro programatuta: $time';
  }

  @override
  String get outboxCancel => 'Utzi';

  @override
  String get outboxCancelSending => 'Utzi bidaltzeari…';

  @override
  String get outboxCancelTitle => 'Bidaltzeari utzi?';

  @override
  String get outboxMoveToDrafts => 'Eraman Zirriborroak karpetara';

  @override
  String get outboxDiscard => 'Baztertu mezua';

  @override
  String get outboxMovedToDrafts => 'Zirriborroak karpetara eraman da';

  @override
  String get outboxDiscarded => 'Mezua baztertu da';

  @override
  String get outboxAlreadySent => 'Bidalita dago jada.';

  @override
  String get outboxBeingSent => 'Mezu hau bidaltzen ari da.';

  @override
  String get outboxActionFailed => 'Ez du funtzionatu. Mezua Irteera-ontzian dago oraindik.';

  @override
  String get notificationsBadgeInboxes => 'Sarrera-ontzietako irakurri gabeak';

  @override
  String get notificationsBadgeVip => 'VIPen irakurri gabeak';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Zure VIPen posta berria, edozein kontutan';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Posta berria: $email';
  }

  @override
  String get notificationsUnknownSender => 'Igorle ezezaguna';

  @override
  String get notificationsNoSubject => '(Gairik ez)';

  @override
  String get notificationsEncryptedMessage => 'Mezu zifratua';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Mezu berria: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mezu berri',
      one: 'Mezu berri $count',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Mezu berriak: $account';
  }

  @override
  String get platformInstantChannel => 'Berehalako entrega';

  @override
  String get platformInstantChannelDescription =>
      'Loupe zure sarrera-ontzietan posta berriaren zain dagoen bitartean agertzen da';

  @override
  String get platformInstantTitle => 'Posta berriaren zain';

  @override
  String get platformInstantText => 'Berehalako entrega aktibatuta dago';

  @override
  String get platformErrorBox => 'Zerbait gaizki joan da hau erakustean. Itzuli atzera eta saiatu berriro.';

  @override
  String get welcomeTagline => 'Posta, sinplea azalean\neta indartsua barruan.';

  @override
  String get welcomeAccountsTitle => 'Kontu guztiak, sarrera-ontzi lasai bakarrean';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail eta edozein IMAP edo JMAP zerbitzari.';

  @override
  String get welcomeSearchTitle => 'Aurkitzen duen bilaketa';

  @override
  String get welcomeSearchText => 'Berehalako emaitzak zure telefonoan, eta gero zerbitzarikoak.';

  @override
  String get welcomePrivacyTitle => 'Pribatua diseinuz';

  @override
  String get welcomePrivacyText => 'Jarraipenik ez. Urruneko irudiak blokeatuta daude zuk esan arte.';

  @override
  String get welcomeAddAccount => 'Gehitu kontua';

  @override
  String get welcomeImport => 'Inportatu Thunderbird-etik';

  @override
  String get welcomeTryDemo => 'Probatu demo-postarekin';
}
