// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get commonAdd => 'Lisää';

  @override
  String get commonCancel => 'Peruuta';

  @override
  String get commonClose => 'Sulje';

  @override
  String get commonDelete => 'Poista';

  @override
  String get commonDone => 'Valmis';

  @override
  String get commonEdit => 'Muokkaa';

  @override
  String get commonMore => 'Lisää';

  @override
  String get commonMove => 'Siirrä';

  @override
  String get commonName => 'Nimi';

  @override
  String get commonNone => 'Ei mitään';

  @override
  String get commonOff => 'Pois päältä';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Päällä';

  @override
  String get commonOptional => 'Valinnainen';

  @override
  String get commonPassword => 'Salasana';

  @override
  String get commonRemove => 'Poista';

  @override
  String get commonRetry => 'Yritä uudelleen';

  @override
  String get commonSave => 'Tallenna';

  @override
  String get commonSearch => 'Hae';

  @override
  String get commonServer => 'Palvelin';

  @override
  String get commonSettings => 'Asetukset';

  @override
  String get commonShare => 'Jaa';

  @override
  String get commonTryAgain => 'Yritä uudelleen';

  @override
  String get commonUndo => 'Kumoa';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count viestiä', one: '$count viesti');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkistoi';

  @override
  String get mailDelete => 'Poista';

  @override
  String get mailFlag => 'Liputa';

  @override
  String get mailForward => 'Välitä';

  @override
  String get mailMarkAsRead => 'Merkitse luetuksi';

  @override
  String get mailMarkAsUnread => 'Merkitse lukemattomaksi';

  @override
  String get mailMoveToJunk => 'Siirrä roskapostiin';

  @override
  String get mailNewMessage => 'Uusi viesti';

  @override
  String get mailNoSubject => 'Ei aihetta';

  @override
  String get mailReply => 'Vastaa';

  @override
  String get mailReplyAll => 'Vastaa kaikille';

  @override
  String get mailSend => 'Lähetä';

  @override
  String get mailUnflag => 'Poista lippu';

  @override
  String get mailboxArchive => 'Arkisto';

  @override
  String get mailboxDrafts => 'Luonnokset';

  @override
  String get mailboxInbox => 'Saapuneet';

  @override
  String get mailboxJunk => 'Roskaposti';

  @override
  String get mailboxOutbox => 'Lähtevät';

  @override
  String get mailboxSent => 'Lähetetyt';

  @override
  String get mailboxTrash => 'Roskakori';

  @override
  String get conversationSomethingWentWrong => 'Jokin meni vikaan. Yritä uudelleen.';

  @override
  String get conversationReplyToList => 'Vastaa listalle';

  @override
  String get conversationReplyList => 'Vastaa listalle';

  @override
  String get conversationThreadMuted => 'Ketju mykistetty. Sen uudet viestit saapuvat luettuina.';

  @override
  String get conversationThreadUnmuted => 'Ketjun mykistys poistettu.';

  @override
  String get conversationLinkFailed => 'Linkkiä ei voitu avata.';

  @override
  String get conversationGoneTitle => 'Ei viestiä';

  @override
  String get conversationGoneText => 'Tämä viesti on siirretty tai poistettu.';

  @override
  String get conversationMuted => 'Mykistetty';

  @override
  String get conversationReaderOptions => 'Lukuasetukset';

  @override
  String get conversationReaderOptionsHint => 'Tekstin koko ja näkymä';

  @override
  String get conversationTrash => 'Roskakoriin';

  @override
  String get conversationReplyHint => 'Vastaa kaikille tai välitä painamalla pitkään';

  @override
  String get conversationOfflineTitle => 'Ei verkkoyhteyttä';

  @override
  String get conversationOfflineText => 'Tätä keskustelua ei ole vielä ladattu. Se latautuu, kun olet taas verkossa.';

  @override
  String get conversationErrorTitle => 'Viestiä ei voi näyttää';

  @override
  String get conversationErrorText => 'Jokin meni vikaan.';

  @override
  String get conversationOfflineBanner => 'Ei verkkoyhteyttä';

  @override
  String get conversationNotUpdated => 'Ei päivitetty';

  @override
  String get conversationMe => 'minä';

  @override
  String get conversationNoSender => '(ei lähettäjää)';

  @override
  String get conversationNoRecipients => 'ei vastaanottajia';

  @override
  String conversationRecipients(String names) {
    return 'vastaanottaja: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'vastaanottaja: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Lähettäjä';

  @override
  String get conversationHeaderTo => 'Vastaanottaja';

  @override
  String get conversationHeaderCc => 'Kopio';

  @override
  String get conversationHeaderBcc => 'Piilokopio';

  @override
  String get conversationHeaderReplyTo => 'Vastausosoite';

  @override
  String get conversationHeaderDate => 'Päivämäärä';

  @override
  String get conversationHeaderSecurity => 'Tietoturva';

  @override
  String get conversationVerifiedSender => 'Vahvistettu lähettäjä';

  @override
  String get conversationUnverifiedSender => 'Vahvistamaton lähettäjä';

  @override
  String get conversationLoadingMessage => 'Ladataan viestiä';

  @override
  String get conversationBodyError => 'Viestiä ei voitu ladata.';

  @override
  String get conversationBodyOffline => 'Ei verkkoyhteyttä. Viesti latautuu, kun olet taas verkossa.';

  @override
  String get conversationOriginalHint => 'Näyttää paremmalta Alkuperäinen-näkymässä';

  @override
  String get conversationShowOriginal => 'Näytä alkuperäinen';

  @override
  String get conversationScrollToTop => 'Vieritä alkuun';

  @override
  String get conversationTagsMenu => 'Tunnisteet…';

  @override
  String get conversationMuteThread => 'Mykistä ketju';

  @override
  String get conversationUnmuteThread => 'Poista ketjun mykistys';

  @override
  String get conversationMoveMenu => 'Siirrä…';

  @override
  String get conversationDeletePermanently => 'Poista pysyvästi';

  @override
  String get conversationMoveToTrash => 'Siirrä roskakoriin';

  @override
  String get conversationNotJunk => 'Ei roskapostia';

  @override
  String get conversationShowAllHeaders => 'Näytä kaikki otsakkeet';

  @override
  String get conversationViewSource => 'Näytä lähdekoodi';

  @override
  String get conversationSaveAsFile => 'Tallenna tiedostona…';

  @override
  String get conversationShareAsFile => 'Jaa tiedostona…';

  @override
  String get conversationSearchFromMessageMenu => 'Hae tämän viestin perusteella…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopioi osoite';

  @override
  String get conversationAddressCopied => 'Osoite kopioitu';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Hae viestejä lähettäjältä $name';
  }

  @override
  String get conversationTags => 'Tunnisteet';

  @override
  String get conversationAllHeaders => 'Kaikki otsakkeet';

  @override
  String get conversationCopyAll => 'Kopioi kaikki';

  @override
  String get conversationHeadersCopied => 'Otsakkeet kopioitu';

  @override
  String get conversationNoHeaders => 'Ei otsakkeita';

  @override
  String get conversationSearchFromMessageTitle => 'Hae tämän viestin perusteella';

  @override
  String conversationSearchFrom(String name) {
    return 'Lähettäjältä $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Vastaanottajalle $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Aihe ”$subject”';
  }

  @override
  String get conversationSourceTitle => 'Lähdekoodi';

  @override
  String get conversationSourceCopied => 'Lähdekoodi kopioitu';

  @override
  String get conversationShareFailed => 'Viestiä ei voitu jakaa.';

  @override
  String get conversationWrapLines => 'Rivitä';

  @override
  String get conversationDontWrapLines => 'Älä rivitä';

  @override
  String get conversationSourceError => 'Lähdekoodia ei voitu ladata.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Näytetään ensimmäiset $shown (yhteensä $total). Saat kaiken kopioimalla tai jakamalla.';
  }

  @override
  String get conversationAttachmentUntitled => 'Nimetön';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Lisätoiminnot: $name';
  }

  @override
  String get conversationMoveTo => 'Siirrä kansioon…';

  @override
  String get conversationMailboxesError => 'Postilaatikoita ei voitu ladata.';

  @override
  String get conversationReaderReadable => 'Luettava';

  @override
  String get conversationReaderOriginal => 'Alkuperäinen';

  @override
  String get conversationReaderPlain => 'Pelkkä teksti';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Säilytä alkuperäiset värit';

  @override
  String get conversationReaderRemember => 'Muista tälle lähettäjälle';

  @override
  String get conversationSecurityPossiblePhishing => 'Mahdollista tietojenkalastelua';

  @override
  String get conversationSecurityBeCareful => 'Ole varovainen';

  @override
  String get conversationSecurityVerified => 'Vahvistettu';

  @override
  String get conversationSecurityNoIssues => 'Ongelmia ei löytynyt';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count seurainta', one: '$count seurain');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Näyttää syyn';

  @override
  String get conversationPhishingBannerTitle => 'Tämä viesti näyttää tietojenkalastelulta';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Linkit ja kuvat on poistettu käytöstä.';
  }

  @override
  String get conversationPhishingBannerText => 'Linkit ja kuvat on poistettu käytöstä.';

  @override
  String get conversationPhishingWhy => 'Miksi?';

  @override
  String get conversationPhishingShowAnyway => 'Näytä silti';

  @override
  String get conversationSecurityPhishingTitle => 'Tämä näyttää tietojenkalastelulta';

  @override
  String get conversationSecurityPhishingText =>
      'Useat merkit viittaavat siihen, ettei tämä viesti ole sitä, mitä se väittää olevansa.';

  @override
  String get conversationSecurityCarefulTitle => 'Ole varovainen tämän viestin kanssa';

  @override
  String get conversationSecurityCarefulText => 'Siinä on jotain, mikä kannattaa katsoa tarkemmin.';

  @override
  String get conversationSecurityVerifiedText => 'Lähettäjä on vahvistettu, eikä mikään näytä epäilyttävältä.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Mikään ei näytä epäilyttävältä. Sähköpostipalvelimesi ei kertonut, onko lähettäjä vahvistettu.';

  @override
  String get conversationSecurityNothingSuspicious => 'Mikään ei näytä epäilyttävältä.';

  @override
  String get conversationSecurityWhy => 'Miksi';

  @override
  String get conversationSecurityPrivacy => 'Yksityisyys';

  @override
  String get conversationSecurityNoTrackingPixels => 'Ei seurantapikseleitä';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seurantapikseliä poistettu',
      one: '$count seurantapikseli poistettu',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Ne olisivat kertoneet lähettäjälle, milloin avasit tämän viestin.';

  @override
  String get conversationSecurityNoRemoteImages => 'Ei etäkuvia';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count etäkuvaa', one: '$count etäkuva');
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Niiden lataaminen kertoo lähettäjälle, milloin luet tämän viestin, sekä IP-osoitteesi.';

  @override
  String get conversationSecurityNoClickTracking => 'Ei klikkausten seurantaa';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linkkiä kulkee klikkausseurainten kautta',
      one: '$count linkki kulkee klikkausseurainten kautta',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Klikkauksesi kirjattaisiin seurantapalveluun ($services). Avaa linkin todellinen kohde suoraan painamalla linkkiä pitkään.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tekniset tiedot';

  @override
  String get conversationSecurityCheckedLocally => 'Tarkistettu tällä laitteella. Mitään ei lähetetty minnekään.';

  @override
  String get conversationSecurityTrackersLabel => 'Seuraimet';

  @override
  String get conversationSecurityImagesFrom => 'Kuvien lähteet';

  @override
  String get conversationSecuritySenderHistory => 'Lähettäjän historia';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'vastaanotettu $received, lähetetty $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linkkien kohteet';

  @override
  String get conversationSecurityHidden => 'Piilotettu sisältö';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementtiä',
      one: '$elements elementti',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters merkkiä',
      one: '$characters merkki',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Lähettäjää ei ole vahvistettu';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Sähköpostipalvelimesi ei voinut vahvistaa, että tämä viesti tulee todella verkkotunnuksesta $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Sähköpostipalvelimesi ei voinut vahvistaa, että tämä viesti tulee todella lähettäjältään.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Sähköpostipalvelimesi ei voinut vahvistaa, että tämä viesti tulee verkkotunnuksesta $domain. Tavallista postituslistoilla.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Sähköpostipalvelimesi ei voinut vahvistaa, että tämä viesti tulee lähettäjältään. Tavallista postituslistoilla.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Älä toimi viestin pohjalta, ellet odottanut sitä. Jos epäröit, ota yhteyttä lähettäjään muuta kautta.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Toisen verkkotunnuksen allekirjoittama';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Viestin on allekirjoittanut $signer, ei $domain. Postituspalvelut tekevät näin, mutta se ei todista, kuka viestin kirjoitti.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Viestin on allekirjoittanut jokin muu verkkotunnus kuin $domain. Postituspalvelut tekevät näin, mutta se ei todista, kuka viestin kirjoitti.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Nimessä näkyy eri osoite';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Lähettäjän nimenä näkyy ”$shown”, mutta viesti tulee osoitteesta $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Luota osoitteeseen, älä nimeen.';

  @override
  String get conversationSecurityReplyToTitle => 'Vastaukset menevät muualle';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Vastauksesi menisi osoitteeseen $address eikä verkkotunnukseen $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Tarkista osoite ennen kuin lähetät vastauksessa mitään henkilökohtaista.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Käyttää nimeäsi';

  @override
  String get conversationSecurityImpersonationTitle => 'Käyttää tuttusi nimeä';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Se on allekirjoitettu nimellä ”$name” kuten oma nimesi, mutta se tulee uudesta osoitteesta: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Se on allekirjoitettu nimellä ”$name” kuten VIP-henkilösi $knownName ($knownEmail), mutta se tulee uudesta osoitteesta: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Se on allekirjoitettu nimellä ”$name” kuten $knownName ($knownEmail), mutta se tulee uudesta osoitteesta: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Lisäksi vastaukset menisivät vielä eri osoitteeseen.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Jos siinä pyydetään rahaa, koodeja tai tiedostoja, varmista asia ensin henkilöltä muuta kautta.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Tunnettu osoite: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Tämä osoite: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Ensimmäinen viesti tältä lähettäjältä';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Et ole aiemmin saanut postia osoitteesta $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Suhtaudu varoen pyyntöihin ihmisiltä, joita et vielä tunne.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Samannäköisiä kirjaimia lähettäjän osoitteessa';

  @override
  String get conversationSecurityLinkHomographTitle => 'Samannäköisiä kirjaimia linkissä';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host sekoittaa eri aakkostojen kirjaimia ja jäljittelee näin toista osoitetta.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host käyttää samannäköisiä kirjaimia: se ei ole $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Poista se tai ilmoita se roskapostiksi.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Älä avaa sitä.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Verkkotunnus: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Aitoa jäljittelevä verkkotunnus';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Käyttää tuttua nimeä verkkotunnuksessaan';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain näyttää omalta verkkotunnukseltasi ($real), mutta se on eri verkkotunnus.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain näyttää samalta kuin $brand ($real), mutta se on eri verkkotunnus.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain käyttää oman verkkotunnuksesi ($real) nimeä, mutta ei kuulu siihen.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain käyttää nimeä $brand ($real), mutta ei kuulu sille.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Organisaatiosi aidot viestit tulevat verkkotunnuksesta $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Lähettäjän $brand aidot viestit tulevat verkkotunnuksesta $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Lähettäjän verkkotunnus: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Jäljittelee: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linkkiä piilottaa kohteensa',
      one: 'Linkki piilottaa kohteensa',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Linkissä näkyy $shown, mutta se avaa osoitteen $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Älä kirjaudu sisään tai maksa näiden linkkien kautta. Kirjoita osoite mieluummin itse.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '”$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Linkin kohdetta ei voi tarkistaa';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Linkissä näkyy $shown, mutta se kulkee palvelun $host kautta, joka kirjaa klikkauksen ennen kuin ohjaa sen eteenpäin.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Linkki osoittaa pelkkään IP-osoitteeseen';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts ei ole nimetty verkkosivusto. Oikeat yritykset linkittävät harvoin näin.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Naamioitu linkki';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Linkki alkaa ”$shown@”, jotta se näyttäisi osoitteelta $shown, mutta se avaa osoitteen $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Piilotettu sivu poistettiin käytöstä';

  @override
  String get conversationSecurityDataLinkText =>
      'Linkki olisi avannut viestin sisään pakatun sivun, jolla voi kiertää linkkien tarkistukset.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Pyytää salasanaa';

  @override
  String get conversationSecurityPasswordFieldText => 'Viestissä oli salasanakenttä. Loupe poisti sen.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Älä koskaan kirjoita salasanaa sähköpostiviestiin.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Koodia suorittava linkki poistettiin käytöstä';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe ei koskaan suorita viesteissä olevaa koodia.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lyhennettyjä linkkejä',
      one: 'Lyhennetty linkki',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts piilottaa todellisen kohteen, kunnes avaat linkin.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Kansainvälinen verkko-osoite';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts käyttää muita kuin latinalaisia kirjaimia. Se on tavallista monissa kielissä; tarkista, että sivusto on se, jota odotat.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Paljon piilotettua tekstiä';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count merkkiä näkymätöntä tekstiä poistettiin. Tällaisella piilotekstillä yritetään huijata roskapostisuodattimia.',
      one:
          '$count merkki näkymätöntä tekstiä poistettiin. Tällaisella piilotekstillä yritetään huijata roskapostisuodattimia.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Piilotettu teksti poistettu';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count merkkiä näkymätöntä tekstiä poistettiin.',
      one: '$count merkki näkymätöntä tekstiä poistettiin.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Viestiä ei voitu ladata. Tarkista yhteys ja yritä uudelleen.';

  @override
  String exportSaved(String name) {
    return '”$name” tallennettu';
  }

  @override
  String get exportSaveFailed => 'Viestiä ei voitu tallentaa.';

  @override
  String exportFailed(String folder) {
    return 'Kansiota ”$folder” ei voitu viedä.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Kansiossa ”$folder” ei ole vietäviä viestejä.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Kansiota ”$folder” ei voitu viedä: yhtään viestiä ei voitu ladata. Tarkista yhteys ja yritä uudelleen.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '”$name” tallennettu. $formattedCount viestiä jäi pois, koska niitä ei voitu ladata.',
      one: '”$name” tallennettu. $count viesti jäi pois, koska sitä ei voitu ladata.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Tiedostoa ”$name” ei voitu tallentaa.';
  }

  @override
  String exportTitle(String folder) {
    return 'Viedään kansiota ”$folder”';
  }

  @override
  String get exportListing => 'Etsitään viestejä…';

  @override
  String exportProgress(String current, String total) {
    return 'Viedään $current/$total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount viestiä ei voitu ladata',
      one: '$count viestiä ei voitu ladata',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postilaatikot';

  @override
  String get mailboxesShown => 'Näkyvissä';

  @override
  String get mailboxesHidden => 'Piilotettu';

  @override
  String get mailboxesCollapse => 'Tiivistä';

  @override
  String get mailboxesExpand => 'Laajenna';

  @override
  String get mailboxesManageVips => 'Hallitse VIP-henkilöitä';

  @override
  String get mailboxesSubscriptions => 'Tilaukset';

  @override
  String mailboxesShowAccount(String account) {
    return 'Näytä tili $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Piilota tili $account';
  }

  @override
  String get mailboxesExportFolder => 'Vie kansio…';

  @override
  String get mailboxesUnpin => 'Poista kiinnitys';

  @override
  String get mailboxesLists => 'Listat';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxit';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Tallenna haku, niin se näkyy täällä.';

  @override
  String get mailboxesTags => 'Tunnisteet';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Voit myös napauttaa lähettäjän nimeä viestissä ja laittaa VIP-valinnan päälle.';

  @override
  String get mailboxesAddVip => 'Lisää VIP…';

  @override
  String get mailboxesAddVipTitle => 'Lisää VIP';

  @override
  String get mailboxesAddVipText => 'Tästä osoitteesta tuleva posti saa tähden ja näkyy VIP-postilaatikossa.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Lukemattomat';

  @override
  String get messageListFilterFlagged => 'Liputetut';

  @override
  String get messageListFilterToMe => 'Vastaanottaja: minä';

  @override
  String get messageListFilterCcMe => 'Kopio: minä';

  @override
  String get messageListFilterWithAttachments => 'Liitteelliset';

  @override
  String get messageListFilterUnreplied => 'Vastaamattomat';

  @override
  String get messageListFilterFromVips => 'VIP-henkilöiltä';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä merkitty luetuksi',
      one: '$count viesti merkitty luetuksi',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Vanhempaa postia ei voitu ladata.';

  @override
  String get messageListSelectMessages => 'Valitse viestit';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count valittua', one: '$count valittu');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Valitse kaikki';

  @override
  String get messageListDeselectAll => 'Poista kaikki valinnat';

  @override
  String get messageListLoadFailed => 'Postia ei voitu ladata';

  @override
  String get messageListNoUnread => 'Ei lukemattomia viestejä';

  @override
  String get messageListNoMatches => 'Ei vastaavia viestejä';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Suodattimet: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Poista suodatin käytöstä';

  @override
  String get messageListEmpty => 'Ei postia';

  @override
  String get messageListFilter => 'Suodata';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Suodatusehdot: $filters';
  }

  @override
  String get messageListFilteredBy => 'Suodattimet:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount lukematonta',
      one: '$formattedCount lukematon',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Merkitse';

  @override
  String get messageListTrash => 'Roskakoriin';

  @override
  String get messageListFilterTitle => 'Suodatin';

  @override
  String get messageListFilterInclude => 'NÄYTÄ';

  @override
  String get panesHideMailboxes => 'Piilota postilaatikot';

  @override
  String get panesShowMailboxes => 'Näytä postilaatikot';

  @override
  String get panesMailboxesWidth => 'Postilaatikoiden leveys';

  @override
  String get panesListWidth => 'Viestilistan leveys';

  @override
  String get panesNoMessageSelected => 'Ei valittua viestiä';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count viestiä', one: '$count viesti');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Torkutetut';

  @override
  String get snoozeSheetTitle => 'Torkuta';

  @override
  String get snoozeLaterToday => 'Myöhemmin tänään';

  @override
  String get snoozeThisEvening => 'Tänä iltana';

  @override
  String get snoozeTomorrow => 'Huomenna';

  @override
  String get snoozeThisWeekend => 'Tänä viikonloppuna';

  @override
  String get snoozeNextWeek => 'Ensi viikolla';

  @override
  String get snoozePickDateTime => 'Valitse päivä ja aika…';

  @override
  String get snoozeMenu => 'Torkuta…';

  @override
  String get snoozeWakeNow => 'Herätä nyt';

  @override
  String get snoozeChangeTimeMenu => 'Muuta torkkuaikaa…';

  @override
  String get snoozeChangeTime => 'Muuta aikaa';

  @override
  String get snoozeNoTime => 'Aikaa ei asetettu';

  @override
  String get snoozeFooter => 'Torkutetut viestit palaavat lukemattomina Saapuneet-kansioon asetettuna aikana.';

  @override
  String get snoozeEmptyTitle => 'Ei torkutettuja';

  @override
  String get snoozeEmptyText => 'Torkuta viesti, niin se palaa Saapuneet-kansioon, kun tarvitset sitä.';

  @override
  String get appLockUnlock => 'Avaa lukitus';

  @override
  String get appLockFailed => 'Loupe ei voinut vahvistaa henkilöllisyyttäsi.';

  @override
  String get appLockLockedOut => 'Liian monta yritystä. Yritä myöhemmin uudelleen.';

  @override
  String get appLockPromptError => 'Kehotetta ei voitu näyttää. Yritä uudelleen.';

  @override
  String get appLockNoScreenLock => 'Tässä puhelimessa ei ole näytön lukitusta.';

  @override
  String get appLockUnlockPromptTitle => 'Avaa Loupen lukitus';

  @override
  String get appLockUnlockPromptReason => 'Vahvista henkilöllisyytesi nähdäksesi postisi.';

  @override
  String get appLockTurnOnPromptTitle => 'Ota sovelluslukitus käyttöön';

  @override
  String get appLockTurnOnPromptReason => 'Vahvista henkilöllisyytesi ottaaksesi sovelluslukituksen käyttöön.';

  @override
  String get appLockScreenLockRemoved =>
      'Sovelluslukitus on pois päältä: tässä puhelimessa ei ole enää näytön lukitusta. Määritä näytön lukitus, jos haluat ottaa sovelluslukituksen taas käyttöön.';

  @override
  String get appLockAfterImmediately => 'Heti';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuuttia', one: '$count minuutti');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tuntia', one: '$count tunti');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Salattu';

  @override
  String get openpgpEncryptedInPart => 'Osittain salattu';

  @override
  String get openpgpEncryptedLocked => 'Salattu · lukittu';

  @override
  String get openpgpEncryptedNoKey => 'Salattu · ei avainta';

  @override
  String get openpgpEncryptedDamaged => 'Salattu · vahingoittunut';

  @override
  String get openpgpEncryptedUnsupported => 'Salattu · ei tuettu';

  @override
  String get openpgpUnknownSigner => 'tuntematon';

  @override
  String get openpgpUnknownKey => 'Tuntematon avain';

  @override
  String get openpgpSignatureInvalid => 'Virheellinen allekirjoitus';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Allekirjoittaja: $name, ei lähettäjä';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Allekirjoittaja (osittain): $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Allekirjoittaja: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Allekirjoitettu hylätyllä avaimella';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Allekirjoittaja: $name · avainta ei hyväksytty';
  }

  @override
  String get openpgpUnlock => 'Avaa lukitus';

  @override
  String get openpgpCantDecrypt => 'Viestin salausta ei voi purkaa';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Salattu OpenPGP:llä';

  @override
  String get openpgpEncryption => 'Salaus';

  @override
  String get openpgpDecryptedHere => 'Salaus purettu tällä laitteella';

  @override
  String get openpgpNotDecrypted => 'Salausta ei purettu';

  @override
  String get openpgpKeyLocked => 'Avaimesi on lukittu.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Avaimille $keys', one: 'Avaimelle $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Suojattu aihe';

  @override
  String get openpgpUnlockKey => 'Avaa avaimen lukitus';

  @override
  String get openpgpSignature => 'Allekirjoitus';

  @override
  String get openpgpFingerprint => 'Sormenjälki';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Avaimen tunnus $id';
  }

  @override
  String get openpgpSigned => 'Allekirjoitettu';

  @override
  String get openpgpProblem => 'Ongelma';

  @override
  String get openpgpAcceptance => 'Hyväksyntä';

  @override
  String get openpgpChangeAcceptance => 'Muuta hyväksyntää…';

  @override
  String get openpgpCheckedFooter => 'Tarkistettu tällä laitteella OpenPGP:llä, yhteensopiva Thunderbirdin kanssa.';

  @override
  String get openpgpSummaryLocked =>
      'Avaimesi on lukittu. Avaa sen lukitus salalauseella, niin voit lukea tämän viestin.';

  @override
  String get openpgpSummaryNoSecretKey => 'Se on salattu avaimelle, jota ei ole tällä laitteella.';

  @override
  String get openpgpSummaryDamaged => 'Salatut tiedot ovat vahingoittuneet tai niitä on muutettu matkalla.';

  @override
  String get openpgpSummaryUnsupported => 'Se käyttää algoritmia, jota Loupe ei tue.';

  @override
  String get openpgpSummaryEncrypted => 'Vain sinä ja muut vastaanottajat voitte lukea sen.';

  @override
  String get openpgpSummaryNotSigned => 'Sitä ei ole allekirjoitettu, joten lähettäjää ei ole vahvistettu.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Se on allekirjoitettu, mutta avaimella, jota sinulla ei ole, joten allekirjoitusta ei voi tarkistaa.';

  @override
  String get openpgpSummaryBadSignature => 'Allekirjoitus ei täsmää: viestiä on ehkä muutettu.';

  @override
  String get openpgpSummaryMismatch =>
      'Allekirjoitus on kelvollinen, mutta avain kuuluu eri osoitteelle kuin lähettäjän.';

  @override
  String get openpgpSummaryPartial =>
      'Vain osa viestistä on allekirjoitettu. Allekirjoituksen ulkopuolinen teksti (esimerkiksi postituslistan alatunniste) näkyy ”Unsigned content” -rivin alla, eikä allekirjoitus kata muitakaan viestin osia, kuten liitteitä.';

  @override
  String get openpgpSummaryOwnKey => 'Allekirjoitettu omalla avaimellasi.';

  @override
  String get openpgpSummaryVerified => 'Allekirjoitus on kelvollinen, ja olet vahvistanut avaimen sormenjäljen.';

  @override
  String get openpgpSummaryUnverified =>
      'Allekirjoitus on kelvollinen. Hyväksyit avaimen tarkistamatta sen sormenjälkeä.';

  @override
  String get openpgpSummaryRejected => 'Allekirjoitus on kelvollinen, mutta olet hylännyt tämän avaimen.';

  @override
  String get openpgpSummaryUndecided =>
      'Allekirjoitus on kelvollinen, mutta et ole vielä hyväksynyt tätä avainta. Vertaa sen sormenjälkeä lähettäjän kanssa.';

  @override
  String get openpgpAcceptanceRejected => 'Hylätty';

  @override
  String get openpgpAcceptanceUndecided => 'Ei hyväksytty';

  @override
  String get openpgpAcceptanceUnverified => 'Hyväksytty';

  @override
  String get openpgpAcceptanceVerified => 'Hyväksytty ja vahvistettu';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Hyväksytäänkö henkilön $name avain?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Sormenjälki $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Kyllä, vahvistin sormenjäljen';

  @override
  String get openpgpAcceptUnverified => 'Kyllä, tarkistamatta';

  @override
  String get openpgpAcceptLater => 'Ei vielä';

  @override
  String get openpgpRejectKey => 'Hylkää tämä avain';

  @override
  String get openpgpNoSubject => '(ei aihetta)';

  @override
  String get openpgpEncryptionTitle => 'Päästä päähän -salaus';

  @override
  String get openpgpMyKeys => 'Omat OpenPGP-avaimet';

  @override
  String get openpgpMyKeysFooter =>
      'Avaimella voit lukea salattua postia sekä allekirjoittaa ja salata omasi. Käytätkö Thunderbirdiä? Vie avaimesi sieltä (Tilien asetukset › Päästä päähän -salaus › Varmuuskopioi salainen avain tiedostoon) ja tuo se tänne.';

  @override
  String get openpgpAddKey => 'Lisää avain…';

  @override
  String get openpgpAddresses => 'Osoitteet';

  @override
  String get openpgpAddressesFooter => 'Mitä avainta kukin osoite käyttää ja milloin se salaa ja allekirjoittaa.';

  @override
  String get openpgpCorrespondentsKeys => 'Yhteyshenkilöiden OpenPGP-avaimet';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Hyväksy avain, kun luotat sen kuuluvan omistajalleen; vertaa sormenjälkeä omistajan kanssa, niin voit merkitä sen vahvistetuksi.';

  @override
  String get openpgpImportPublicKey => 'Tuo julkinen avain…';

  @override
  String get openpgpCollected => 'Autocryptin kautta kerätyt';

  @override
  String get openpgpCollectedFooter =>
      'Viestien mukana tulleet avaimet. Loupe voi salata postin niillä, kun molemmat osapuolet pyytävät sitä.';

  @override
  String get openpgpOnThisDevice => 'Tällä laitteella';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Salatut viestit piilottavat aiheensa. Loupe tallentaa jokaisen avaamasi viestin aiheen salattuun tietokantaansa tällä laitteella, jotta lista, haku ja ilmoitukset voivat näyttää sen. Taustalla Loupe voi myös purkaa uusien viestien aiheiden salauksen avaimilla, joilla ei ole salalausetta; sitä varten se lataa jokaisen viestin (enintään 1 Mt).';

  @override
  String get openpgpDecryptSubjects => 'Pura aiheiden salaus taustalla';

  @override
  String get openpgpIndexFooter =>
      'Haku löytää salatut viestit lähettäjän, vastaanottajien ja aiheen perusteella. Kun tämä on päällä, Loupe lisää myös jokaisen purkamansa salatun viestin tekstin hakuindeksiin salattuun tietokantaansa tällä laitteella, jolloin haku löytää viestin myös sen tekstin perusteella. Kun asetus poistetaan käytöstä, teksti poistetaan indeksistä.';

  @override
  String get openpgpIndexDecrypted => 'Indeksoi puretut viestit hakua varten';

  @override
  String get openpgpPassphrases => 'Salalauseet';

  @override
  String get openpgpPassphrasesFooter =>
      'Salalauseella suojatut OpenPGP-avaimet ja S/MIME-varmenteet avataan tarvittaessa. Ilman ”Muista salalauseet” -asetusta ne lukitaan uudelleen kaksi minuuttia jokaisen käytön jälkeen.';

  @override
  String get openpgpRememberPassphrases => 'Muista salalauseet';

  @override
  String get openpgpRememberPassphrasesDetail => 'Kunnes Loupe suljetaan';

  @override
  String get openpgpLockKeysNow => 'Lukitse avaimet nyt';

  @override
  String get openpgpKeysLocked => 'Avaimet lukittu.';

  @override
  String get openpgpKeyStateRevoked => 'kumottu';

  @override
  String get openpgpKeyStateExpired => 'vanhentunut';

  @override
  String get openpgpKeyStateNeverExpires => 'ei vanhene';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'vanhenee $date';
  }

  @override
  String get openpgpNoKey => 'Ei avainta';

  @override
  String get openpgpAlwaysEncrypt => 'Salaa aina';

  @override
  String get openpgpAddKeyTitle => 'Lisää OpenPGP-avain';

  @override
  String get openpgpAddKeyMessage => 'Tuo Thunderbirdissä käyttämäsi avain tai luo uusi.';

  @override
  String get openpgpImportFromClipboard => 'Tuo leikepöydältä';

  @override
  String get openpgpImportFromFile => 'Tuo tiedostosta';

  @override
  String get openpgpGenerateNewKey => 'Luo uusi avain';

  @override
  String get openpgpImportPublicKeyTitle => 'Tuo julkinen avain';

  @override
  String get openpgpFromClipboard => 'Leikepöydältä';

  @override
  String get openpgpFromFile => 'Tiedostosta';

  @override
  String get openpgpClipboardEmpty => 'Leikepöytä on tyhjä. Kopioi avain ensin.';

  @override
  String get openpgpKey => 'Avain';

  @override
  String get openpgpValidityRevoked => 'Kumottu';

  @override
  String openpgpValidityExpired(String date) {
    return 'Vanhentunut $date';
  }

  @override
  String get openpgpNeverExpires => 'Ei vanhene';

  @override
  String openpgpValidUntil(String date) {
    return 'Voimassa $date asti';
  }

  @override
  String get openpgpFingerprintCopied => 'Sormenjälki kopioitu.';

  @override
  String get openpgpAlgorithm => 'Algoritmi';

  @override
  String get openpgpCreated => 'Luotu';

  @override
  String get openpgpValidity => 'Voimassaolo';

  @override
  String get openpgpProtection => 'Suojaus';

  @override
  String get openpgpProtectionPassphrase => 'Salalause';

  @override
  String get openpgpProtectionKeychain => 'Vain avainsäilö';

  @override
  String get openpgpKeyDetailsFooter =>
      'Jaa julkinen avaimesi, jotta muut voivat salata viestejä sinulle. Varmuuskopio on salainen avaimesi, joka on suojattu sen salalauseella, jos sellainen on: pidä se yksityisenä.';

  @override
  String get openpgpSharePublicKey => 'Jaa julkinen avain';

  @override
  String get openpgpCopyPublicKey => 'Kopioi julkinen avain';

  @override
  String get openpgpPublicKeyCopied => 'Julkinen avain kopioitu.';

  @override
  String get openpgpBackUpSecretKey => 'Varmuuskopioi salainen avain';

  @override
  String get openpgpDeleteKey => 'Poista avain';

  @override
  String get openpgpRemoveKey => 'Poista avain';

  @override
  String get openpgpBackUpTitle => 'Varmuuskopioidaanko salainen avain?';

  @override
  String get openpgpBackUpProtected =>
      'Varmuuskopio on suojattu avaimesi salalauseella. Kuka tahansa, jolla on molemmat, voi lukea postisi.';

  @override
  String get openpgpBackUpUnprotected =>
      'Tällä avaimella ei ole salalausetta: kuka tahansa, jolla on varmuuskopio, voi lukea postisi ja allekirjoittaa nimissäsi.';

  @override
  String get openpgpBackUp => 'Varmuuskopioi';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Poistetaanko avaimesi $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Poistetaanko henkilön $name avain?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Tälle avaimelle salattua postia ei voi enää lukea tällä laitteella, ellet tuo avainta uudelleen.';

  @override
  String get openpgpRemoveKeyMessage => 'Voit tuoda sen myöhemmin uudelleen.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-avain';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Lisää avain kohdassa Päästä päähän -salaus, niin voit salata ja allekirjoittaa tästä osoitteesta lähtevää postia.';

  @override
  String get openpgpGenerateAKey => 'Luo avain…';

  @override
  String get openpgpSending => 'Lähetys';

  @override
  String get openpgpSendingFooter =>
      'Automaattinen salaus otetaan käyttöön, kun jokaisella vastaanottajalla on hyväksytty avain tai luotettu varmenne tai kun Autocrypt kertoo molempien osapuolten haluavan sitä. Salattu posti allekirjoitetaan aina.';

  @override
  String get openpgpEncryptAutomatically => 'Salaa automaattisesti';

  @override
  String get openpgpAlwaysEncryptDetail => 'Estää lähettämisen, jos vastaanottajalla ei ole avainta';

  @override
  String get openpgpSignUnencrypted => 'Allekirjoita salaamaton posti';

  @override
  String get openpgpAttachPublicKey => 'Liitä julkinen avaimeni';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt lähettää julkisen avaimesi jokaisen viestin mukana, joten muut sovellukset voivat salata viestejä sinulle ilman erillisiä asetuksia.';

  @override
  String get openpgpSendMyKey => 'Lähetä avaimeni postin mukana';

  @override
  String get openpgpPreferEncryption => 'Suosi salausta';

  @override
  String get openpgpPreferEncryptionDetail => 'Pyydä muita salaamaan, kun he voivat';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vuotta', one: '$count vuosi');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Salalauseet eivät täsmää.';

  @override
  String openpgpKeyReady(String id) {
    return 'Avaimesi $id on valmis.';
  }

  @override
  String get openpgpNewKey => 'Uusi avain';

  @override
  String get openpgpNewKeyFor => 'Kenelle';

  @override
  String get openpgpYourName => 'Nimesi';

  @override
  String get openpgpAddress => 'Osoite';

  @override
  String get openpgpPassphrase => 'Salalause';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valinnainen. Ilman salalausetta avainta suojaa vain puhelimesi avainsäilö, eikä Loupe kysy mitään. Jos asetat salalauseen, Loupe kysyy sitä, kun avainta tarvitaan.';

  @override
  String get openpgpRepeatPassphrase => 'Toista';

  @override
  String get openpgpExpires => 'Vanhenee';

  @override
  String get openpgpExpiresFooter =>
      'Voit luoda uuden avaimen ennen kuin tämä vanhenee. Myös Thunderbird käyttää kolmea vuotta.';

  @override
  String get openpgpGenerateKey => 'Luo avain';

  @override
  String get openpgpKeyFor => 'Avain osoitteelle';

  @override
  String get openpgpCantEncrypt => 'Salaus ei onnistu';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'OpenPGP-avain puuttuu: $names. Tämä osoite salaa aina. Poista vastaanottaja tai tuo hänen avaimensa kohdassa Asetukset › Päästä päähän -salaus.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Kelvollinen S/MIME-varmenne puuttuu: $names. Tämä osoite salaa aina. Poista vastaanottaja tai tuo hänen varmenteensa kohdassa Asetukset › Päästä päähän -salaus.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'OpenPGP-avain puuttuu: $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Kelvollinen S/MIME-varmenne puuttuu: $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Lähetä salaamattomana';

  @override
  String get openpgpCantSign => 'Allekirjoitus ei onnistu';

  @override
  String get openpgpCantSignMessage =>
      'S/MIME-varmenteesi yksityinen avain ei ole tällä laitteella. Tuo varmenne uudelleen (.p12- tai .pfx-tiedosto) kohdassa Asetukset › Päästä päähän -salaus.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Ei avainta: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Ei varmennetta: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Avaimet Autocryptin kautta';

  @override
  String get openpgpComposeEveryoneHasKey => 'Kaikilla on avain';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Kaikilla on varmenne';

  @override
  String get openpgpComposeEncrypt => 'Salaa';

  @override
  String get openpgpComposeSign => 'Allekirjoita';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, vaihda';
  }

  @override
  String get openpgpNoKeyFound => 'OpenPGP-avainta ei löytynyt.';

  @override
  String get openpgpImportSecretKeyTitle => 'Tuodaanko salainen avain?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Tämä liite sisältää salaisen avaimen ($names). Tuo se omaksi avaimeksesi vain, jos olet itse vienyt sen esimerkiksi Thunderbirdistä.';
  }

  @override
  String get openpgpImportAsMyKey => 'Tuo omaksi avaimeksi';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'avaimesi $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tuodaanko $count avainta ($names)?',
      one: 'Tuodaanko henkilön $names avain?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Tuo ja hyväksy';

  @override
  String get openpgpImportDecideLater => 'Tuo, päätä myöhemmin';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'henkilön $name avain';
  }

  @override
  String openpgpImported(String keys) {
    return 'Tuotu: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Liitteenä on $count OpenPGP-avainta.',
      one: 'Liitteenä on OpenPGP-avain.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Tuo';

  @override
  String get openpgpUnlockKeyTitle => 'Avaa OpenPGP-avaimen lukitus';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Anna salalause avaimelle $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Salalause on väärä. Yritä uudelleen.';

  @override
  String get openpgpExplainLocked => 'Tämä viesti on salattu. Avaa OpenPGP-avaimesi lukitus, niin voit lukea sen.';

  @override
  String get openpgpExplainNoKey =>
      'Tämä viesti on salattu, mutta ei millekään tällä laitteella olevalle OpenPGP-avaimelle. Jos luet sitä Thunderbirdissä, tuo avaimesi sieltä: Asetukset › Päästä päähän -salaus.';

  @override
  String get openpgpExplainDamaged =>
      'Tämä salattu viesti on vahingoittunut, joten sen salausta ei voi purkaa turvallisesti.';

  @override
  String get openpgpExplainUnsupported => 'Tämä viesti käyttää salausta, jota Loupe ei vielä osaa lukea.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Tämä viesti on salattu S/MIME:llä, mutta ei millekään tällä laitteella olevalle varmenteelle. Tuo varmenteesi (.p12- tai .pfx-tiedosto) kohdassa Asetukset › Päästä päähän -salaus.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Tämä viesti on salattu. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Avaa S/MIME-varmenteesi lukitus, niin voit lukea sen.';

  @override
  String get openpgpAttachmentGone => 'Tämä liite ei ole enää saatavilla.';

  @override
  String get smimeEncrypted => 'Salattu (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Salattu (S/MIME) · ei varmennetta';

  @override
  String get smimeEncryptedDamaged => 'Salattu (S/MIME) · vahingoittunut';

  @override
  String get smimeEncryptedUnsupported => 'Salattu (S/MIME) · ei tuettu';

  @override
  String get smimeEncryptedLocked => 'Salattu (S/MIME) · lukittu';

  @override
  String get smimeUnknownSigner => 'tuntematon';

  @override
  String get smimeSignatureModified => 'Virheellinen allekirjoitus: viestiä muutettu';

  @override
  String get smimeSignatureWeak => 'Allekirjoitus ei ole turvallinen: vanhentunut algoritmi';

  @override
  String get smimeSignatureUncheckable => 'Allekirjoitusta ei voi tarkistaa';

  @override
  String get smimeSignedCertificateMissing => 'Allekirjoitettu · varmenne puuttuu';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Allekirjoittaja: $name · varmenne kumottu';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Allekirjoittaja: $name · eri ajankohtana';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Allekirjoittaja: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Allekirjoittaja: $name · virheellinen varmenne';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Allekirjoittaja: $name · ei luotettu';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Allekirjoittaja: $name · varmenne vanhentunut';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Allekirjoittaja: $name · varmenne ei vielä voimassa';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Allekirjoittaja: $name · varmenne ei ole postia varten';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Allekirjoittaja: $name, ei lähettäjä';
  }

  @override
  String get smimeCantDecrypt => 'Viestin salausta ei voi purkaa';

  @override
  String get smimeEncryptedWithSmime => 'Salattu S/MIME:llä';

  @override
  String get smimeEncryption => 'Salaus';

  @override
  String get smimeDecryptedHere => 'Salaus purettu tällä laitteella';

  @override
  String get smimeNotDecrypted => 'Salausta ei purettu';

  @override
  String get smimeAuthenticated => 'todennettu';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count varmenteelle',
      one: '$count varmenteelle',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Allekirjoitus';

  @override
  String get smimeIssuedBy => 'Myöntäjä';

  @override
  String get smimeValid => 'Voimassa';

  @override
  String smimeValidRange(String from, String to) {
    return '$from–$to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-sormenjälki';

  @override
  String get smimeSigned => 'Allekirjoitettu';

  @override
  String get smimeProblem => 'Ongelma';

  @override
  String get smimeCheckingRevocation => 'Tarkistetaan, onko varmenne kumottu…';

  @override
  String get smimeNotRevoked => 'Ei kumottu';

  @override
  String get smimeRevoked => 'Kumottu';

  @override
  String get smimeRevocationUnknown => 'Kumoamisen tila tuntematon';

  @override
  String smimeRevokedSince(String date) {
    return 'Alkaen $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Kysytty myöntäjältä (sulkulista), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Kysytty myöntäjältä (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Luota myöntäjään ”$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Luota tähän varmenteeseen…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Tarkistettu tällä laitteella S/MIME:llä, yhteensopiva Outlookin ja Thunderbirdin kanssa; kumoaminen tarkistettu varmenteen myöntäjältä.';

  @override
  String get smimeCheckedFooter =>
      'Tarkistettu tällä laitteella S/MIME:llä, yhteensopiva Outlookin ja Thunderbirdin kanssa. Kumoamista ei tarkisteta (Asetukset › Päästä päähän -salaus).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Luotetaanko myöntäjään $name postissa?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Luotetaanko henkilön $name varmenteeseen?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Jokaiseen tämän myöntäjän myöntämään varmenteeseen luotetaan, kuten yrityksesi varmentajaan (CA). Vertaa ensin sormenjälkeä omistajan kanssa:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Vertaa ensin sormenjälkeä omistajan kanssa:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Luota';

  @override
  String get smimeSummaryNoKey => 'Se on salattu varmenteelle, jota ei ole tällä laitteella.';

  @override
  String get smimeSummaryDamaged => 'Salatut tiedot ovat vahingoittuneet tai niitä on muutettu matkalla.';

  @override
  String get smimeSummaryUnsupported => 'Se käyttää algoritmia, jota Loupe ei tue.';

  @override
  String get smimeSummaryLocked => 'S/MIME-varmenteesi on lukittu.';

  @override
  String get smimeSummaryEncrypted => 'Vain sinä ja muut vastaanottajat voitte lukea sen.';

  @override
  String get smimeSummaryNotSigned => 'Sitä ei ole allekirjoitettu, joten lähettäjää ei ole vahvistettu.';

  @override
  String get smimeSummaryModified => 'Allekirjoitus ei täsmää: viestiä on muutettu allekirjoittamisen jälkeen.';

  @override
  String get smimeSummaryUncheckable => 'Allekirjoitusta ei voi tarkistaa.';

  @override
  String get smimeSummaryNoCertificate => 'Allekirjoittajan varmenne ei ole viestissä, joten sitä ei voi tarkistaa.';

  @override
  String get smimeSummaryRevoked =>
      'Varmenteen myöntäjä on kumonnut allekirjoittajan varmenteen: allekirjoitukseen ei voi luottaa.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Varmenteen myöntäjä on kumonnut allekirjoittajan varmenteen ($reason): allekirjoitukseen ei voi luottaa.';
  }

  @override
  String get smimeDateMismatch =>
      'Se on allekirjoitettu yli tunnin erossa viestin päiväyksestä: se voi olla uudelleen lähetetty vanha viesti.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Allekirjoitus on kelvollinen, ja $issuer takaa, että varmenne kuuluu lähettäjälle.';
  }

  @override
  String get smimeProblemInvalidChain => 'Varmenne tai jokin sen myöntäjistä on virheellinen.';

  @override
  String get smimeProblemUntrusted => 'Varmenne on peräisin myöntäjältä, johon Loupe ei luota.';

  @override
  String get smimeProblemExpired => 'Varmenne oli vanhentunut.';

  @override
  String get smimeProblemNotYetValid => 'Varmenne ei ollut vielä voimassa.';

  @override
  String get smimeProblemWrongUsage => 'Varmennetta ei ole tarkoitettu postille.';

  @override
  String get smimeProblemWrongAddress => 'Varmenne kuuluu eri osoitteelle kuin lähettäjän.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Luotettu · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ei luotettu · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Vanhentunut $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Voimassa alkaen $date';
  }

  @override
  String get smimeTrustInvalid => 'Virheellinen';

  @override
  String get smimeTrustNotForMail => 'Ei postille';

  @override
  String get smimeTrustAnotherAddress => 'Eri osoite';

  @override
  String get smimeMyCertificates => 'Omat S/MIME-varmenteet';

  @override
  String get smimeMyCertificatesFooter =>
      'S/MIME-salaukseen, jota Outlook ja monet yritykset käyttävät. Tuo varmenteesi yksityisen avaimen kanssa (.p12- tai .pfx-tiedosto) vietynä Outlookista, Windowsista, macOS:stä tai Thunderbirdistä.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'S/MIME-salaukseen, jota Outlook ja monet yritykset käyttävät. Tuo varmenteesi yksityisen avaimen kanssa (.p12- tai .pfx-tiedosto) vietynä Outlookista, Windowsista, macOS:stä tai Thunderbirdistä, tai käytä varmennetta, jonka yrityksesi tai sinä olette asentaneet tälle laitteelle.';

  @override
  String get smimeCertificateExpired => 'vanhentunut';

  @override
  String smimeCertificateUntil(String date) {
    return '$date asti';
  }

  @override
  String get smimeCertificateOnDevice => 'tällä laitteella';

  @override
  String get smimeImportCertificateEllipsis => 'Tuo varmenne…';

  @override
  String get smimeUseDeviceCertificate => 'Käytä tämän laitteen varmennetta…';

  @override
  String get smimeCorrespondentsCertificates => 'Yhteyshenkilöiden varmenteet';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Kerätty allekirjoitetuista viesteistä, kuten Outlook ja Thunderbird tekevät. Posti salataan vain luotetuille varmenteille: Loupe luottaa myöntäjiin, joihin Mozilla luottaa sähköpostissa, sekä lisäämiisi myöntäjiin.';

  @override
  String get smimeRevocation => 'Kumoamisen tarkistus';

  @override
  String get smimeRevocationFooter =>
      'Kun avaat allekirjoitetun viestin, Loupe kysyy allekirjoittajan varmenteen myöntäjältä, onko varmenne kumottu (myöntäjän OCSP-palvelimelta tai sulkulistasta). Myöntäjä näkee silloin, milloin joku IP-osoitteestasi lukee tällä varmenteella allekirjoitettua postia. Vastaukset säilytetään tällä laitteella, kunnes ne vanhenevat. Kumottu varmenne näkyy viestin otsakkeessa merkinnällä ”varmenne kumottu”.';

  @override
  String get smimeCheckRevocation => 'Tarkista varmenteiden kumoaminen verkossa';

  @override
  String get smimeTrustedAuthorities => 'Luotetut myöntäjät';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Itse luottamasi myöntäjät. Lisäksi luotetaan $count myöntäjään, joihin Mozilla luottaa sähköpostissa.',
      one: 'Itse luottamasi myöntäjät. Lisäksi luotetaan $count myöntäjään, johon Mozilla luottaa sähköpostissa.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Varmenteiden myöntäjä';

  @override
  String get smimeImportACertificate => 'Tuo varmenne';

  @override
  String get smimeImportContactMessage =>
      'Yhteyshenkilön varmenne (.cer, .crt, .pem) tai varmenteiden myöntäjän varmenne.';

  @override
  String get smimeFromClipboard => 'Leikepöydältä';

  @override
  String get smimeFromFile => 'Tiedostosta';

  @override
  String get smimeClipboardEmpty => 'Leikepöytä on tyhjä. Kopioi varmenne ensin.';

  @override
  String get smimeCertificate => 'Varmenne';

  @override
  String get smimeOnDeviceFooter =>
      'Sen yksityinen avain pysyy Androidin kirjautumistietojen tallennustilassa, johon yrityksesi tai sinä asensitte sen: Loupe pyytää Androidia allekirjoittamaan ja purkamaan salauksen sillä. Allekirjoitettu posti allekirjoitetaan, kun lähetät sen.';

  @override
  String get smimeAddresses => 'Osoitteet';

  @override
  String get smimeUsage => 'Käyttö';

  @override
  String get smimeUsageNone => 'Ei mitään, mitä Loupe käyttää';

  @override
  String get smimeUsageSigning => 'Allekirjoitus';

  @override
  String get smimeUsageEncryption => 'Salaus';

  @override
  String get smimeUsageCertificates => 'Varmenteet';

  @override
  String get smimeAlgorithm => 'Algoritmi';

  @override
  String get smimeSerialNumber => 'Sarjanumero';

  @override
  String get smimeFingerprintCopied => 'Sormenjälki kopioitu.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-tunniste';

  @override
  String get smimePrivateKey => 'Yksityinen avain';

  @override
  String get smimeKeyOnDevice => 'Tällä laitteella';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupessa, salalauseella suojattuna';

  @override
  String get smimeKeyInLoupe => 'Loupessa';

  @override
  String get smimeSource => 'Lähde';

  @override
  String get smimeSourceSignedMail => 'Allekirjoitettu posti';

  @override
  String get smimeSourceImported => 'Tuotu';

  @override
  String get smimeTrustHeader => 'Luottamus';

  @override
  String get smimeTrustedRoot => 'Luotettu juurivarmenne';

  @override
  String get smimeIssuer => 'Myöntäjä';

  @override
  String smimeTrustNamed(String name) {
    return 'Luota myöntäjään ”$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Luota tähän myöntäjään';

  @override
  String get smimeTrustThisCertificate => 'Luota tähän varmenteeseen';

  @override
  String get smimeStopTrusting => 'Lopeta luottaminen';

  @override
  String get smimePassphrase => 'Salalause';

  @override
  String get smimePassphraseFooter =>
      'Valinnainen. Salalauseen kanssa yksityinen avain salataan myös tällä laitteella (Argon2id ja AES-256), ja Loupe kysyy salalausetta allekirjoittaessaan ja purkaessaan salausta; Muista salalauseet -asetus määrää, kuinka pitkään se muistetaan. Lähettämäsi posti allekirjoitetaan lähetyshetkellä; taustatoiminnot eivät voi käyttää avainta.';

  @override
  String get smimeChangePassphrase => 'Vaihda salalause…';

  @override
  String get smimeSetPassphraseEllipsis => 'Aseta salalause…';

  @override
  String get smimeRemovePassphrase => 'Poista salalause';

  @override
  String get smimeShareCertificate => 'Jaa varmenne';

  @override
  String get smimeDeleteCertificate => 'Poista varmenne';

  @override
  String get smimeRemoveCertificate => 'Poista varmenne';

  @override
  String get smimePassphraseChanged => 'Salalause vaihdettu.';

  @override
  String get smimePassphraseSet => 'Salalause asetettu.';

  @override
  String get smimeRemovePassphraseTitle => 'Poistetaanko salalause?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Yksityistä avainta suojaa tämän jälkeen vain avainsäilö, kuten ilman salalausetta: Loupe ei enää kysy sitä, ja taustatoiminnot voivat käyttää avainta.';

  @override
  String get smimePassphraseRemoved => 'Salalause poistettu.';

  @override
  String smimeTrustTitle(String name) {
    return 'Luotetaanko varmenteeseen $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Jokaiseen sen myöntämään varmenteeseen luotetaan postissa. Vertaa ensin sormenjälkeä omistajan kanssa:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Poistetaanko varmenteesi $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Poistetaanko henkilön $name varmenne?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe lopettaa sen käytön: sille salattua postia ei voi enää lukea Loupessa. Varmenne jää tälle laitteelle (Asetukset › Tietoturva › Salaus ja kirjautumistiedot).';

  @override
  String get smimeDeleteOwnMessage =>
      'Sen yksityinen avain poistetaan tältä laitteelta: sille salattua postia ei voi enää lukea täällä, ellet tuo sitä uudelleen.';

  @override
  String get smimeRemoveContactMessage => 'Se palaa hänen seuraavan allekirjoitetun viestinsä mukana.';

  @override
  String get smimeAddressImportFooter =>
      'Tuo tälle osoitteelle varmenne, niin voit allekirjoittaa ja salata S/MIME:llä kuten Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Tuo varmenne…';

  @override
  String get smimePreferFooter =>
      'Kun molemmat voisivat suojata viestin, käytetään ensisijaista, paitsi jos vain toisella on avain tai varmenne jokaiselle vastaanottajalle.';

  @override
  String get smimePreferSmime => 'Suosi S/MIME:ä';

  @override
  String get smimePreferSmimeDetail => 'OpenPGP:n sijaan';

  @override
  String get smimeCertificatePassword => 'Varmenteen salasana';

  @override
  String get smimeCertificatePasswordPrompt => 'Anna salasana, jolla varmennetiedosto vietiin.';

  @override
  String get smimeImport => 'Tuo';

  @override
  String get smimeWrongPassword => 'Salasana on väärä. Yritä uudelleen.';

  @override
  String get smimeNoCertificateFound => 'Varmennetta ei löytynyt.';

  @override
  String smimeCertificateOf(String name) {
    return 'henkilön $name varmenne';
  }

  @override
  String get smimeNothingNew => 'Ei mitään uutta tuotavaa.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Tuotu: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tuotu $count luotettua myöntäjää.',
      one: 'Tuotu luotettu myöntäjä.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tuotu: $certificates ja $count luotettua myöntäjää.',
      one: 'Tuotu: $certificates ja luotettu myöntäjä.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Tiedostossa ei ole yksityistä avainta. Vie varmenteesi yksityisen avaimen kanssa.';

  @override
  String get smimeImportAsYoursTitle => 'Tuodaanko omaksi varmenteeksesi?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Tämä liite sisältää varmenteen yksityisen avaimen kanssa: $names. Tuo se vain, jos olet itse vienyt sen esimerkiksi Outlookista tai Thunderbirdistä.';
  }

  @override
  String get smimeImportAsMine => 'Tuo omaksi varmenteeksi';

  @override
  String smimeImportedOwn(String names) {
    return 'Varmenteesi $names tuotu.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Varmenteesi $name ($addresses) lisätty tältä laitteelta.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Luotetaanko myöntäjään ”$name” postissa?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ei tunne tätä varmenteiden myöntäjää (ehkä yrityksen oma). Luota siihen, jotta sen myöntämät varmenteet voidaan tarkistaa. Vertaa ensin sen sormenjälkeä IT-osastosi kanssa:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Liitteenä on $count varmennetta.',
      one: 'Liitteenä on varmenne.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Tuo varmenne';

  @override
  String get smimeUnlockTitle => 'Avaa S/MIME-varmenteen lukitus';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Anna salalause varmenteelle $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Salalause on väärä. Yritä uudelleen.';

  @override
  String get smimeUnlock => 'Avaa lukitus';

  @override
  String get smimeEnterAPassphrase => 'Anna salalause.';

  @override
  String get smimePassphrasesDiffer => 'Salalauseet eroavat toisistaan.';

  @override
  String get smimeSetPassphraseTitle => 'Aseta salalause';

  @override
  String get smimeSetPassphraseText =>
      'Loupe kysyy sitä allekirjoittaessaan ja purkaessaan salausta. Jos unohdat sen, tuo varmenne uudelleen sen .p12-tiedostosta.';

  @override
  String get smimePassphraseAgain => 'Uudelleen';

  @override
  String get smimeSetPassphraseButton => 'Aseta';

  @override
  String get smimeLockedOpenAgain =>
      'S/MIME-varmenteesi on lukittu. Avaa viesti uudelleen, niin voit avata lukituksen.';

  @override
  String get smimeDeviceHasNoCertificates => 'Tämä laite ei tarjoa varmenteitaan.';

  @override
  String get smimeCantReadCertificate => 'Loupe ei pysty lukemaan tätä varmennetta.';

  @override
  String get smimeCertificateNotForMail =>
      'Tämä varmenne ei ole postia varten: siinä ei ole sähköpostiosoitetta, tai sitä ei ole tarkoitettu allekirjoittamiseen tai salaamiseen.';

  @override
  String get smimeDeviceCertificateGone =>
      'Varmenne ei ole enää tällä laitteella, tai Loupe ei ehkä saa enää käyttää sitä. Valitse se uudelleen kohdassa Asetukset › Päästä päähän -salaus.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Tämän laitteen varmennetta voi käyttää vain, kun Loupe on auki.';

  @override
  String get smimeDeviceKeyDamaged => 'Salattu avain on vahingoittunut.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Tämän laitteen varmenne ei pysty tähän: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'ei tuettu';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Tämän laitteen varmenne epäonnistui: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Myöntäjän osoite ei ole verkko-osoite.';

  @override
  String get smimeAuthorityTimeout => 'Varmenteen myöntäjä ei vastannut ajoissa.';

  @override
  String get smimeAuthorityUnreachable => 'Varmenteen myöntäjään ei saatu yhteyttä.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Varmenteen myöntäjä vastasi koodilla $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Varmenteen myöntäjän vastaus on liian suuri.';

  @override
  String get smimeRevocationNotChecked =>
      'Ei tarkistettu: vain niiden myöntäjien varmenteet tarkistetaan, joihin Loupe luottaa.';

  @override
  String get settingsLanguage => 'Kieli';

  @override
  String get settingsLanguageSystem => 'Sama kuin puhelimessa';

  @override
  String get settingsLanguageFooter =>
      'Loupe käyttää puhelimesi kieltä, jos se on saatavilla, ja muuten englantia. Tässä valitsemasi kieli koskee vain Loupea, ilmoitukset mukaan lukien.';

  @override
  String get settingsAccountsHeader => 'Tilit';

  @override
  String get settingsAddAccount => 'Lisää tili';

  @override
  String get settingsMailHeader => 'Posti';

  @override
  String get settingsSwipeActions => 'Pyyhkäisytoiminnot';

  @override
  String get settingsSwipeLeft => 'Pyyhkäisy vasemmalle';

  @override
  String get settingsSwipeLeftFooter =>
      'Pitkä pyyhkäisy suorittaa tämän toiminnon. Liputa- ja Lisää-toiminnot ovat aina lyhyen pyyhkäisyn päässä.';

  @override
  String get settingsSwipeRight => 'Pyyhkäisy oikealle';

  @override
  String get settingsSwipeRightFooter => 'Pitkä pyyhkäisy suorittaa tämän toiminnon.';

  @override
  String get settingsSwipeToggleRead => 'Merkitse luetuksi / lukemattomaksi';

  @override
  String get settingsSwipeTrash => 'Roskakoriin';

  @override
  String get settingsSwipeMove => 'Siirrä viesti';

  @override
  String get settingsSwipeSnooze => 'Torkuta';

  @override
  String get settingsThreaded => 'Järjestä keskusteluittain';

  @override
  String get settingsUndoSendDelay => 'Lähetyksen perumisaika';

  @override
  String get settingsUndoSendDelayFooter => 'Lähetetyt viestit odottavat näin kauan, jotta voit perua ne.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekuntia',
      one: '$seconds sekunti',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxit';

  @override
  String get settingsAppearanceHeader => 'Ulkoasu';

  @override
  String get settingsTheme => 'Teema';

  @override
  String get settingsThemeSystem => 'Automaattinen';

  @override
  String get settingsThemeLight => 'Vaalea';

  @override
  String get settingsThemeDark => 'Tumma';

  @override
  String get settingsDensity => 'Viestilista';

  @override
  String get settingsDensityComfortable => 'Väljä';

  @override
  String get settingsDensityCompact => 'Tiivis';

  @override
  String get settingsReadingHeader => 'Lukeminen';

  @override
  String get settingsReadingFooter => 'Etäkuvat voivat kertoa lähettäjille, milloin ja missä avasit viestin.';

  @override
  String get settingsDefaultView => 'Oletusnäkymä';

  @override
  String get settingsDefaultViewFooter => 'Voit vaihtaa minkä tahansa viestin näkymää Aa-painikkeella.';

  @override
  String get settingsViewReadable => 'Luettava';

  @override
  String get settingsViewReadableDetail => 'Siisti, helppolukuinen, seuraa tummaa tilaa';

  @override
  String get settingsViewOriginal => 'Alkuperäinen';

  @override
  String get settingsViewOriginalDetail => 'Täsmälleen sellaisena kuin lähettäjä sen suunnitteli';

  @override
  String get settingsViewPlain => 'Pelkkä teksti';

  @override
  String get settingsViewPlainDetail => 'Vain sanat';

  @override
  String get settingsPlainTextFont => 'Pelkän tekstin fontti';

  @override
  String get settingsFontSans => 'Päätteetön';

  @override
  String get settingsFontMono => 'Tasalevyinen';

  @override
  String get settingsFontMonoDetail => 'Pitää ASCII-taiteen ja taulukot kohdallaan';

  @override
  String get settingsTechnicalLists => 'Tekniset listat';

  @override
  String get settingsLoadRemoteImages => 'Lataa etäkuvat';

  @override
  String get settingsOpenLinksDirectly => 'Avaa linkit suoraan';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Ohita klikkausseuraimet, kun kohde tiedetään';

  @override
  String get settingsSecurityHeader => 'Tietoturva';

  @override
  String get settingsAppLock => 'Sovelluslukitus';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe kysyy käynnistyessään ja kun palaat oltuasi poissa lukitusviiveen verran.';

  @override
  String get settingsAppLockFooterOff =>
      'Sovelluslukitus kysyy sormenjälkeä, kasvoja tai näytön lukitusta ennen kuin postisi näytetään.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Sovelluslukitus on edelleen pois päältä. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Ota pääsykoodi käyttöön';

  @override
  String get settingsScreenLockTextIos =>
      'Sovelluslukitus käyttää Face ID:tä, Touch ID:tä tai pääsykoodiasi, eikä tässä iPhonessa ole pääsykoodia. Määritä se Asetukset-apissa ja ota sitten sovelluslukitus käyttöön.';

  @override
  String get settingsScreenLockTitleAndroid => 'Määritä näytön lukitus';

  @override
  String get settingsScreenLockTextAndroid =>
      'Sovelluslukitus käyttää puhelimesi näytön lukitusta tai siihen lisättyä sormenjälkeä tai kasvoja, eikä tässä puhelimessa ole näytön lukitusta. Määritä PIN-koodi, kuvio tai salasana Androidin asetuksissa ja ota sitten sovelluslukitus käyttöön.';

  @override
  String get settingsOpenSystemSettings => 'Avaa Asetukset';

  @override
  String get settingsOpenAndroidSettings => 'Avaa Androidin asetukset';

  @override
  String get settingsLockAfter => 'Lukitusviive';

  @override
  String get settingsLockAfterFooter => 'Kuinka kauan Loupe voi olla taustalla, ennen kuin se kysyy uudelleen.';

  @override
  String get settingsNotifications => 'Ilmoitukset';

  @override
  String get settingsEncryption => 'Päästä päähän -salaus';

  @override
  String get settingsAdvanced => 'Lisäasetukset';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demoposti on keksitty postilaatikko, joka on vain tässä puhelimessa. Mitään ei lähetetä minnekään.';

  @override
  String get settingsDemoMode => 'Demotila';

  @override
  String get settingsResetApp => 'Nollaa sovellus';

  @override
  String get settingsResetFooter => 'Unohtaa kaikki asetukset ja palaa tervetulonäkymään.';

  @override
  String get settingsResetTitle => 'Nollataanko Loupe?';

  @override
  String get settingsResetMessage =>
      'Tämä unohtaa kaikki asetukset, Smart Mailboxit ja viimeisimmät haut ja palaa tervetulonäkymään.';

  @override
  String get settingsAboutHeader => 'Tietoja';

  @override
  String get settingsVersion => 'Versio';

  @override
  String get settingsLicences => 'Lisenssit';

  @override
  String get settingsPrivacy => 'Tietosuoja';

  @override
  String get settingsPrivacyDetail =>
      'Loupessa ei ole analytiikkaa eikä seurantaa. Postisi kulkee vain sähköpostipalvelimillesi.';

  @override
  String get settingsNotificationsOffIos => 'Loupen ilmoitukset on poistettu käytöstä Asetuksissa.';

  @override
  String get settingsNotificationsOffAndroid => 'Loupen ilmoitukset on poistettu käytöstä Androidin asetuksissa.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system ei salli Loupen näyttää ilmoituksia. Salli ne asetuksissa.';
  }

  @override
  String get settingsNewMailHeader => 'Uusi posti';

  @override
  String get settingsNewMailFooterDemo =>
      'Demoposti ei saavu taustalla. Lähetä testi-ilmoitus, niin näet, miltä uusi posti näyttää.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe tarkistaa uuden postin taustalla, kun iOS sallii sen, ja harvoin avattujen sovellusten kohdalla väli voi olla tunteja. Saat ilmoituksen uusista viesteistä Saapuneet-kansioissasi sekä VIP-henkilöiltä missä tahansa kansiossa.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe tarkistaa uuden postin noin 15 minuutin välein, kun Android sallii. Saat ilmoituksen uusista viesteistä Saapuneet-kansioissasi sekä VIP-henkilöiltä missä tahansa kansiossa.';

  @override
  String get settingsNoAccounts => 'Ei tilejä';

  @override
  String get settingsVipOnly => 'Vain VIP';

  @override
  String get settingsVipOnlyDetail => 'Vain VIP-henkilöiltäsi tulevat viestit';

  @override
  String get settingsHideContent => 'Piilota sisältö';

  @override
  String get settingsHideContentFooterOn =>
      'Ilmoituksissa lukee vain ”Uusi viesti tilille” ja tilin nimi, ei sitä, kuka kirjoitti ja mistä.';

  @override
  String get settingsHideContentFooterOff =>
      'Piilota sisältö -asetus pitää lähettäjän, aiheen ja esikatselun poissa lukitusnäytöltä ja ilmoituksista.';

  @override
  String get settingsBackgroundAppRefresh => 'Appien päivitys taustalla';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Uutta postia saapuu taustalla vain, kun Appien päivitys taustalla on Loupella päällä Asetuksissa. iOS ei voi pitää yhteyttä Saapuneet-kansioihisi auki, joten välitöntä toimitusta ei ole.';

  @override
  String get settingsInstantDelivery => 'Välitön toimitus';

  @override
  String get settingsInstantDeliveryFooter =>
      'Välitön toimitus (kokeellinen) pitää yhteyden Saapuneet-kansioihisi auki, joten uusi posti saapuu sekunneissa. Se näyttää hiljaisen ”Odotetaan uutta postia” -ilmoituksen ja kuluttaa enemmän akkua.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android voi pysäyttää välittömän toimituksen akun säästämiseksi. Salli Loupen käyttää akkua rajoituksetta, jotta toimitus pysyy käynnissä.';

  @override
  String get settingsExperimental => 'Kokeellinen';

  @override
  String get settingsComingSoon => 'Tulossa pian';

  @override
  String get settingsAllowUnrestrictedBattery => 'Salli rajoittamaton akun käyttö';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Pushin avulla uusi posti herättää Loupen heti, jos postipalvelusi tukee sitä. Push-ilmoitukset kulkevat Googlen push-palvelun kautta eivätkä sisällä postia, vain ”tarkista nyt”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Tämä puhelin ei voi vastaanottaa push-ilmoituksia: ne vaativat Google Play -palvelut ja verkkoyhteyden. Loupe tarkistaa uuden postin silti noin 15 minuutin välein.';

  @override
  String get settingsCopyPushToken => 'Kopioi push-tunnus';

  @override
  String get settingsPushTokenCopied => 'Push-tunnus kopioitu';

  @override
  String get settingsSendTestNotification => 'Lähetä testi-ilmoitus';

  @override
  String get settingsAppIconBadge => 'Sovelluskuvakkeen merkki';

  @override
  String get settingsBadgeNote => 'Merkki päivittyy aina, kun Loupe tarkistaa postin, myös taustalla.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Tämän puhelimen aloitusnäyttö ei näytä numeroita sovelluskuvakkeissa. Merkki päivittyy aina, kun Loupe tarkistaa postin, myös taustalla.';

  @override
  String get settingsTestNotificationBody => 'Uuden postin ilmoitukset näyttävät tältä.';

  @override
  String get settingsAccountRemoved => 'Tämä tili on poistettu.';

  @override
  String get settingsAccountHeader => 'Tili';

  @override
  String get settingsAccountDescription => 'Kuvaus';

  @override
  String get settingsAccountDescriptionHint => 'Työ, Henkilökohtainen…';

  @override
  String get settingsEmail => 'Sähköposti';

  @override
  String get settingsColour => 'Väri';

  @override
  String get settingsColourFooter => 'Merkitsee tämän tilin viestit Kaikki saapuneet -näkymässä.';

  @override
  String settingsColourNumber(int number) {
    return 'Väri $number';
  }

  @override
  String get settingsSendingHeader => 'Lähetys';

  @override
  String get settingsSendingFooter =>
      'Jokaisella identiteetillä on oma allekirjoituksensa. Vastaukset lähtevät osoitteesta, johon viesti lähetettiin.';

  @override
  String get settingsFoldersHeader => 'Kansiot';

  @override
  String get settingsFoldersFooter =>
      'Loupe näyttää ja synkronoi tilaamasi kansiot, kuten Thunderbird. Saapuneet, Luonnokset, Lähetetyt, Roskaposti, Roskakori ja Arkisto näkyvät aina.';

  @override
  String get settingsShowAllFolders => 'Näytä kaikki kansiot';

  @override
  String get settingsIncoming => 'Saapuva';

  @override
  String get settingsOutgoing => 'Lähtevä';

  @override
  String get settingsConnectionNotEncrypted => 'Salaamaton';

  @override
  String get settingsSignIn => 'Kirjautuminen';

  @override
  String get settingsSignInExpired => 'Vanhentunut';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider ei enää hyväksy Loupen kirjautumista tälle tilille, joten sen posti ei synkronoidu. Korjaa tilanne kirjautumalla uudelleen.';
  }

  @override
  String get settingsSignInAgain => 'Kirjaudu uudelleen';

  @override
  String get settingsSigningIn => 'Kirjaudutaan…';

  @override
  String get settingsRemoveAccount => 'Poista tili';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Poistetaanko ”$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Sen posti ja asetukset poistetaan tästä puhelimesta. Palvelimelta ei poisteta mitään.';

  @override
  String get settingsManageFolders => 'Hallitse kansioita';

  @override
  String get settingsNoFolders => 'Ei vielä kansioita.';

  @override
  String get settingsManageFoldersFooter =>
      'Tilatut kansiot näkyvät Postilaatikot-näkymässä ja synkronoidaan taustalla. Saman tilin muut sähköpostisovellukset noudattavat yleensä myös näitä tilauksia.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Säilyttää Smart Mailboxit muita laitteitasi varten. Piilotettu Postilaatikot-näkymässä.';

  @override
  String get settingsFolderAlwaysShown => 'Näytetään aina';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Tilaa kansio $folder';
  }

  @override
  String get settingsIdentities => 'Identiteetit';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Ensimmäinen identiteetti on uusien viestien oletus. Muuta järjestystä vetämällä.';

  @override
  String get settingsIdentitiesFooterSingle => 'Uusien viestien oletusidentiteetti.';

  @override
  String get settingsIdentitiesReplyFooter => 'Vastaus lähtee siitä identiteetistä, jolle viesti lähetettiin.';

  @override
  String get settingsIdentityDefault => 'Oletus';

  @override
  String settingsIdentityReorder(String email) {
    return 'Muuta järjestystä: $email';
  }

  @override
  String get settingsAddIdentity => 'Lisää identiteetti';

  @override
  String get settingsNewIdentity => 'Uusi identiteetti';

  @override
  String get settingsIdentity => 'Identiteetti';

  @override
  String get settingsIdentityNameHint => 'Nimesi';

  @override
  String get settingsReplyTo => 'Vastausosoite';

  @override
  String get settingsSignature => 'Allekirjoitus';

  @override
  String get settingsSignatureFooter => 'Lisätään tämän identiteetin viesteihin ”-- ”-rivin alle.';

  @override
  String get settingsNoSignature => 'Ei allekirjoitusta';

  @override
  String get settingsCopyToMyself => 'Kopio itselle';

  @override
  String get settingsCopyToMyselfFooter => 'Lisätään jokaiseen tämän identiteetin viestiin.';

  @override
  String get settingsCc => 'Kopio';

  @override
  String get settingsBcc => 'Piilokopio';

  @override
  String get settingsReplyPatterns => 'Käytä vastauksissa osoitteisiin';

  @override
  String get settingsReplyPatternsFooter =>
      'Vastaukset viesteihin, jotka on lähetetty näihin osoitteisiin, lähtevät tästä identiteetistä. * tarkoittaa mitä tahansa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Osoite tai malli, jossa * tarkoittaa mitä tahansa.';

  @override
  String get settingsAddReplyPattern => 'Lisää osoite tai malli';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Poista $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Virheellinen malli';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '”$input” ei ole osoite eikä malli, kuten *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ei osoitetta';

  @override
  String get settingsIdentityNoAddressMessage => 'Anna sähköpostiosoite, josta lähetetään.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Virheellinen osoite';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Vastausosoite ”$address” ei ole kelvollinen sähköpostiosoite.',
      'cc': 'Kopio-osoite ”$address” ei ole kelvollinen sähköpostiosoite.',
      'bcc': 'Piilokopio-osoite ”$address” ei ole kelvollinen sähköpostiosoite.',
      'other': '”$address” ei ole kelvollinen sähköpostiosoite.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Tallenna identiteetti';

  @override
  String get settingsDiscardChanges => 'Hylkää muutokset';

  @override
  String get settingsDeleteIdentity => 'Poista identiteetti';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Poistetaanko ”$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Siitä jo lähetetyt viestit säilyvät ennallaan.';

  @override
  String get settingsLastIdentityFooter => 'Tilillä on oltava vähintään yksi identiteetti.';

  @override
  String get rulesTitle => 'Säännöt';

  @override
  String get rulesNewRule => 'Uusi sääntö';

  @override
  String get rulesLoadError => 'Sääntöjä ei voitu ladata.';

  @override
  String get rulesEmptyTitle => 'Ei sääntöjä';

  @override
  String get rulesEmptyText =>
      'Säännöt lajittelevat kansioihin, lisäävät tunnisteita ja liputtavat uutta postia puolestasi. Luo sääntö yllä olevalla kirjoituspainikkeella tai hausta toiminnolla ”Tee tästä sääntö”.';

  @override
  String get rulesListFooter =>
      'Säännöt suoritetaan ylhäältä alas Saapuneet-kansion uudelle postille. Siirrä sääntöä koskettamalla sitä pitkään.';

  @override
  String get rulesChangeError => 'Sääntöä ei voitu muuttaa';

  @override
  String get rulesConditionEveryMessage => 'Jokainen viesti';

  @override
  String rulesMoveRule(String rule) {
    return 'Siirrä sääntöä $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Sääntö $rule päällä';
  }

  @override
  String get rulesServerRulesHeader => 'Palvelinsäännöt';

  @override
  String get rulesServerRulesFooter =>
      'Palvelinsäännöt suoritetaan sähköpostipalvelimella postin saapuessa, myös kun tämä puhelin on pois päältä. Ne säilytetään Sieve-skriptissä nimeltä ”loupe”.';

  @override
  String get rulesStatusUnknown => 'Tuntematon';

  @override
  String get rulesStatusError => 'Palvelimelta ei voitu kysyä.';

  @override
  String get rulesStatusChecking => 'Tarkistetaan…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Suoritetaan skriptistä ”$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '”$script” on aktiivinen skripti. Napauta, niin se suorittaa myös Loupen säännöt.';
  }

  @override
  String get rulesStatusNoScript =>
      'Palvelimella ei ole aktiivista skriptiä. Palvelinsäännön tallentaminen ottaa Loupen skriptin käyttöön.';

  @override
  String get rulesStatusUnavailable => 'Ei käytettävissä';

  @override
  String get rulesStatusNoSieve => 'Tämän tilin palvelin ei tarjoa Sieveä (ManageSieve tai JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Siirrä kansioon $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Siirrä kansioon';

  @override
  String rulesActionTag(String tag) {
    return 'Lisää tunniste $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Poista tunniste $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Pidä Saapuneet-kansiossa';

  @override
  String rulesActionForward(String address) {
    return 'Välitä osoitteeseen $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Välitä osoitteeseen $address, älä säilytä kopiota';
  }

  @override
  String get rulesActionStop => 'Lopeta';

  @override
  String get rulesNoActions => 'Ei vielä tee mitään';

  @override
  String get rulesLocationDevice => 'Laite';

  @override
  String get rulesLocationServer => 'Palvelin';

  @override
  String get rulesLocationThisDevice => 'Tämä laite';

  @override
  String get rulesNewRuleTitle => 'Uusi sääntö';

  @override
  String get rulesEditRuleTitle => 'Muokkaa sääntöä';

  @override
  String get rulesDefaultNameEveryMessage => 'Jokainen viesti';

  @override
  String get rulesConditionHeader => 'Kun uusi viesti täsmää';

  @override
  String get rulesConditionFooter =>
      'Kirjoita se kuin hakisit: from:, to:, s: (aihe), b: (sisältö), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:lasku';

  @override
  String get rulesAccounts => 'Tilit';

  @override
  String get rulesAllAccounts => 'Kaikki tilit';

  @override
  String get rulesRemovedAccount => 'Poistettu tili';

  @override
  String get rulesAccountsFooter => 'Kaikkia tilejä koskeva sääntö kattaa myös myöhemmin lisäämäsi tilit.';

  @override
  String get rulesActionsHeader => 'Silloin';

  @override
  String get rulesForwardingFooter =>
      'Edelleenlähetys lähettää jokaisen ehtoa vastaavan viestin toiseen osoitteeseen sen saapuessa, myös kun tämä puhelin on pois päältä. Jotkin palveluntarjoajat rajoittavat edelleenlähetettävän postin määrää.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Edelleenlähetys toimii vain palvelinsäännöissä, joten se on jätetty tästä pois.';

  @override
  String rulesRemoveAction(String action) {
    return 'Poista toiminto: $action';
  }

  @override
  String get rulesAddAction => 'Lisää toiminto';

  @override
  String get rulesAddMove => 'Siirrä kansioon…';

  @override
  String get rulesAddTagMenu => 'Lisää tunniste…';

  @override
  String get rulesRemoveTagMenu => 'Poista tunniste…';

  @override
  String get rulesAddForward => 'Välitä osoitteeseen…';

  @override
  String get rulesStopProcessing => 'Älä käsittele muita sääntöjä';

  @override
  String get rulesRunOnHeader => 'Suorituspaikka';

  @override
  String get rulesRunOnDeviceFooter =>
      'Tämä laite suorittaa säännön Saapuneet-kansion uudelle postille aina, kun Loupe tarkistaa postin.';

  @override
  String get rulesRunOnServerFooter =>
      'Sähköpostipalvelin suorittaa säännön postin saapuessa, myös kun tämä puhelin on pois päältä. Vaatii Sieven ManageSieven (Dovecot, mailcow) tai JMAP:n (Stalwart) kautta.';

  @override
  String get rulesApplyToExisting => 'Käytä olemassa oleviin viesteihin…';

  @override
  String get rulesDeleteRule => 'Poista sääntö';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Poistetaanko ”$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Minkä tilin kansioon?';

  @override
  String get rulesMoveAccountMessage => 'Muiden tilien posti siirretään niiden samannimiseen kansioon.';

  @override
  String get rulesAddTag => 'Lisää tunniste';

  @override
  String get rulesRemoveTag => 'Poista tunniste';

  @override
  String get rulesForwardTo => 'Välitä osoitteeseen';

  @override
  String get rulesForwardToMessage =>
      'Palvelin lähettää jokaisen ehtoa vastaavan viestin edelleen tähän osoitteeseen, myös kun tämä puhelin on pois päältä. Käytä osoitetta, jonka omistat tai johon luotat.';

  @override
  String get rulesNotAnAddressTitle => 'Ei sähköpostiosoite';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '”$address” ei ole osoite, johon voi välittää.';
  }

  @override
  String get rulesKeepCopyTitle => 'Säilytetäänkö kopio täällä?';

  @override
  String get rulesKeepCopy => 'Säilytä kopio';

  @override
  String get rulesDontKeepCopy => 'Älä säilytä kopiota';

  @override
  String get rulesCheckCondition => 'Tarkista ehto';

  @override
  String get rulesChooseActionTitle => 'Valitse toiminto';

  @override
  String get rulesChooseActionMessage => 'Lisää, mitä sääntö tekee ehtoa vastaaville viesteille.';

  @override
  String get rulesSaveError => 'Sääntöä ei voitu tallentaa';

  @override
  String get rulesSaveServerError => 'Palvelinsääntöä ei voitu tallentaa';

  @override
  String get rulesRunOnDeviceInstead => 'Suorita sen sijaan tällä laitteella';

  @override
  String get rulesNothingToApplyTitle => 'Ei mitään käytettävää';

  @override
  String get rulesNothingToApplyMessage => 'Anna säännölle ensin toimiva ehto ja toiminto.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Mihin viesteihin sääntöä ”$rule” käytetään?';
  }

  @override
  String get rulesApplyScopeInboxes => 'Saapuneet-kansiot';

  @override
  String get rulesApplyScopeAll => 'Kaikki postilaatikot';

  @override
  String get rulesFindingMessages => 'Etsitään viestejä…';

  @override
  String get rulesSearchError => 'Haku epäonnistui';

  @override
  String get rulesSearchErrorUnknown => 'Jokin meni vikaan.';

  @override
  String get rulesNoMatchesTitle => 'Ei vastaavia viestejä';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Mikään ei vastaa ehtoa ”$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Käytetäänkö sääntöä ”$rule” $countString viestiin?',
      one: 'Käytetäänkö sääntöä ”$rule” $countString viestiin?',
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
      other: 'Käytä $countString viestiin',
      one: 'Käytä $countString viestiin',
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
      other: 'Sääntöä ”$rule” käytetty $countString viestiin',
      one: 'Sääntöä ”$rule” käytetty $countString viestiin',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Kysytään palvelimelta, mihin se pystyy…';

  @override
  String get rulesServerUnreachable => 'Palvelimeen ei saatu yhteyttä.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ei voi suorittaa palvelimella: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ei voi suorittaa tilin $account palvelimella: $problem';
  }

  @override
  String get rulesShowScript => 'Näytä skripti';

  @override
  String get rulesHideScript => 'Piilota skripti';

  @override
  String get rulesMatchingHeader => 'Vastaavat viestit';

  @override
  String get rulesMatchingHeaderLoading => 'Vastaavat viestit…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString vastaavaa viestiä',
      one: '$countString vastaava viesti',
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
      other: '$countString+ vastaavaa viestiä',
      one: '$countString+ vastaavaa viestiä',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Viimeisten 30 päivän ajalta. Itse sääntö koskee vain uutta postia, ellet käytä sitä olemassa oleviin viesteihin.';

  @override
  String rulesConditionError(String error) {
    return 'Ehdossa on virhe: $error';
  }

  @override
  String get rulesPreviewNoSender => '(ei lähettäjää)';

  @override
  String get rulesPreviewNoSubject => '(ei aihetta)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ja $countString muuta',
      one: 'ja $countString muu',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ei mitään viimeisten 30 päivän ajalta.';

  @override
  String get rulesIncludeTitle => 'Ota palvelinsäännöt käyttöön';

  @override
  String get rulesIncludeLeaveOff => 'Jätä pois päältä';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Palvelin suorittaa jo Loupen säännöt tilille $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '”$script” on aktiivinen skripti tilin $account palvelimella, joten palvelin suorittaa sen eikä Loupen sääntöjä. Loupe ei korvaa sitä. Se voi lisätä siihen nämä rivit, jolloin palvelin suorittaa Loupen säännöt skriptin omien sääntöjen jälkeen:';
  }

  @override
  String get rulesShowWholeScript => 'Näytä koko skripti';

  @override
  String get rulesHideWholeScript => 'Piilota koko skripti';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Mitään muuta skriptissä ”$script” ei muuteta. Jos sen suodattimia muokataan myöhemmin webmailissa, webmail voi kirjoittaa sen uudelleen ilman näitä rivejä; silloin Loupe näyttää palvelinsäännöt taas pois päältä olevina.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Lisää skriptiin ”$script”';
  }

  @override
  String get subscriptionsTitle => 'Tilaukset';

  @override
  String get subscriptionsNewsletters => 'Uutiskirjeet';

  @override
  String get subscriptionsDiscussions => 'Keskustelut';

  @override
  String get subscriptionsFilter => 'Suodata';

  @override
  String get subscriptionsFilterNeverRead => 'Ei koskaan luettu';

  @override
  String get subscriptionsFilterRarelyRead => 'Harvoin luettu';

  @override
  String get subscriptionsFilterAll => 'Kaikki';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Tilauksia ei voitu laskea';

  @override
  String get subscriptionsNoMatches => 'Ei osumia';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Uutiskirjettä nimeltä ”$text” ei ole.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Listaa nimeltä ”$text” ei ole.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Ei uutiskirjeitä';

  @override
  String get subscriptionsNoNewslettersDetail => 'Uutiskirjeet ja muu joukkoposti näkyvät täällä, kun niitä saapuu.';

  @override
  String get subscriptionsNothingNeverRead => 'Ei kokonaan lukemattomia';

  @override
  String get subscriptionsNothingRarelyRead => 'Ei harvoin luettuja';

  @override
  String get subscriptionsNothingFilteredDetail => 'Luet jotain kaikesta saamastasi.';

  @override
  String get subscriptionsNoDiscussions => 'Ei keskusteluja';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Postituslistat, joille voit kirjoittaa, näkyvät täällä, kun niiden postia saapuu.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listat, joille useampi ihminen kirjoittaa. Koskettamalla listaa pitkään voit kiinnittää sen Postilaatikot-näkymään, lukea sitä pelkkänä tekstinä tai siirtää sen Uutiskirjeisiin.';

  @override
  String get subscriptionsPrivacyNote =>
      'Laskettu tässä puhelimessa sen lataamasta postista; mitään ei lähetetä minnekään tätä varten. Loupe ottaa yhteyttä lähettäjään vain, kun napautat Peru tilaus -painiketta: yhden napautuksen peruutus lähettää vain tekstin ”List-Unsubscribe=One-Click” lähettäjän ilmoittamaan osoitteeseen ilman evästeitä tai muita tietoja sinusta eikä koskaan lataa sen sivuja tai kuvia.';

  @override
  String get subscriptionsVolumeNone => 'Ei viime aikoina';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / kk';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / kk';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '< 1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'luettu $percent';
  }

  @override
  String get subscriptionsStillSending => 'Lähettää edelleen';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Tilaus peruttu $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Peruutussivu avattu $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Yksi napautus · yhteys: $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Sähköpostilla osoitteeseen $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Verkkosivustolla $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Peru tilaus';

  @override
  String get subscriptionsUnsubscribeAgain => 'Peru tilaus uudelleen';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arkistoi $countString Saapuneet-kansiosta',
      one: 'Arkistoi $countString Saapuneet-kansiosta',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Luo sääntö…';

  @override
  String get subscriptionsCreateRuleDetail => 'Siirrä tai arkistoi sen tuleva posti';

  @override
  String get subscriptionsTreatAsDiscussion => 'Käsittele keskusteluna';

  @override
  String get subscriptionsTreatAsDiscussionDetail =>
      'Lista, jolle ihmiset kirjoittavat: lue sitä keskustelupalstan tapaan';

  @override
  String get subscriptionsTreatAsNewsletter => 'Käsittele uutiskirjeenä';

  @override
  String get subscriptionsBlockSender => 'Estä lähettäjä';

  @override
  String get subscriptionsBlock => 'Estä';

  @override
  String get subscriptionsBlocked => 'Estetty';

  @override
  String get subscriptionsBlockedDetail => 'Uusi posti menee roskapostiin';

  @override
  String get subscriptionsPin => 'Kiinnitä Postilaatikoihin';

  @override
  String get subscriptionsUnpin => 'Poista kiinnitys Postilaatikoista';

  @override
  String get subscriptionsOpenDefaultView => 'Avaa oletusnäkymässä';

  @override
  String get subscriptionsOpenPlainText => 'Avaa pelkkänä tekstinä (Mono)';

  @override
  String get subscriptionsPinned => 'Kiinnitetty';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString lukematonta',
      one: '$countString lukematon',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Tältä lähettäjältä ei ole nyt postia.';

  @override
  String get subscriptionsLatestMessages => 'UUSIMMAT VIESTIT';

  @override
  String get subscriptionsMail => 'Posti';

  @override
  String get subscriptionsNoneIn90Days => 'Ei yhtään 90 päivään';

  @override
  String get subscriptionsRead => 'Luettu';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString/$totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Viimeksi vastaanotettu';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Kansiot', one: 'Kansio');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Lähettää edelleen';

  @override
  String get subscriptionsUnsubscribedTitle => 'Tilaus peruttu';

  @override
  String subscriptionsSince(String date) {
    return 'alkaen $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'sivu avattu $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender ei kerro, miten tilauksen voi perua.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender ei kerro, miten tilauksen voi perua. Voit sen sijaan estää lähettäjän.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Perutaan tilausta: $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Tilaus peruttu: $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Tilausta ei voitu perua: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automaattinen peruutus ei onnistunut';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Lähetä peruutusviesti';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Avaa $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Avataanko $site?';
  }

  @override
  String get subscriptionsOpen => 'Avaa';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender hoitaa tilausten perumisen verkkosivustollaan. Sivu avautuu Loupen selaimessa; viimeistele peruutus siellä.';
  }

  @override
  String get subscriptionsWebInsecure => 'Yhteys tähän sivustoon ei ole salattu.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Varo: tämä osoite jäljittelee sivustoa $site samannäköisillä kirjaimilla.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Varo: tämä osoite jäljittelee toista sivustoa samannäköisillä kirjaimilla.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Sivustoa $site ei voitu avata.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe merkitsee tämän päivän muistiin ja kertoo, jos $sender jatkaa lähettämistä.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Perutaanko lähettäjän $sender tilaus?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe ottaa yhteyttä sivustoon $site tilauksen perumiseksi.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Tämä on ainoa kerta, kun Loupe ottaa yhteyttä lähettäjän verkkosivustoon. Se lähettää vain tekstin ”List-Unsubscribe=One-Click” osoitteeseen, jonka $sender ilmoitti, ilman evästeitä tai muita tietoja sinusta, eikä lataa sivua.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Peruutuslinkki ei ole suojattu internetosoite.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site ei vastannut ajoissa.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Sivustoon $site ei saatu yhteyttä.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site ohjasi pyynnön toiselle sivulle, jota Loupe ei seuraa.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site hylkäsi pyynnön (virhe $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Ei tiliä, josta peruutusviestin voisi lähettää.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe lähettää viestin osoitteeseen $to osoitteesta $from aiheella ”$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Peruutusviesti lähetetty osoitteeseen $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Estetäänkö $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Tämän listan uusi posti menee roskapostiin. Voit muuttaa tätä kohdassa Asetukset › Säännöt.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Uusi posti osoitteesta $address menee roskapostiin. Voit muuttaa tätä kohdassa Asetukset › Säännöt.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender estetty.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Siirrä $count roskapostiin',
      one: 'Siirrä $count roskapostiin',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Estä $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender on nyt Uutiskirjeissä.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender on nyt Keskusteluissa.';
  }

  @override
  String get appLiveGateTitle => 'Tilejäsi ei voitu avata';

  @override
  String get appLiveGateUnavailableBuild => 'Oikeat tilit eivät ole vielä käytettävissä tässä versiossa.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe ei voinut lukea avainta, joka suojaa postiasi tässä puhelimessa. Tämä on usein tilapäistä: yritä uudelleen tai käynnistä puhelin uudelleen.';

  @override
  String get appLiveGateKeyMissing =>
      'Avain, joka suojaa postiasi tässä puhelimessa, on kadonnut. Näin voi käydä varmuuskopion palauttamisen jälkeen. Postisi on edelleen palvelimella.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Tämän puhelimen sähköpostitietokantaa ei voi lukea: se on vahingoittunut tai sen avain on vaihtunut. Postisi on edelleen palvelimella.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Jokin meni vikaan tilejäsi avattaessa ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Tämä poistaa tilisi ja tähän puhelimeen tallennetun postin, myös Lähtevät-kansiossa odottavat viestit. Palvelimillasi oleva posti säilyy; lisää tilisi sen jälkeen uudelleen.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Poista ja aloita alusta';

  @override
  String get appLiveGateUseDemo => 'Käytä demopostia';

  @override
  String get appLiveGateReset => 'Nollaa tämän puhelimen posti…';

  @override
  String get attachmentsUntitled => 'Liite';

  @override
  String get attachmentsUntitledFile => 'Nimetön';

  @override
  String get attachmentsOpenIn => 'Avaa sovelluksessa…';

  @override
  String get attachmentsSaveToFiles => 'Tallenna tiedostoihin';

  @override
  String get attachmentsShareMenu => 'Jaa…';

  @override
  String get attachmentsDownloadError => 'Liitettä ei voitu ladata. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get attachmentsShareError => 'Liitettä ei voitu jakaa.';

  @override
  String attachmentsNoApp(String type) {
    return 'Mikään tämän laitteen sovellus ei avaa tätä tiedostoa ($type). Kokeile sen sijaan jakamista.';
  }

  @override
  String get attachmentsOpenInError => 'Liitettä ei voitu avata toisessa sovelluksessa.';

  @override
  String attachmentsSaved(String name) {
    return '”$name” tallennettu';
  }

  @override
  String get attachmentsSaveError => 'Liitettä ei voitu tallentaa.';

  @override
  String get attachmentsGone => 'Tämä liite ei ole enää saatavilla.';

  @override
  String get attachmentsDownloadFailed => 'Liitettä ei voitu ladata.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sivua', one: '$count sivu');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size mobiilidatalla';
  }

  @override
  String get attachmentsLargeDownload => 'Tämä liite on suuri. Lataa se nyt tai myöhemmin Wi-Fi-yhteydellä.';

  @override
  String get attachmentsDownload => 'Lataa';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Ladataan $size…';
  }

  @override
  String get attachmentsDownloading => 'Ladataan…';

  @override
  String get attachmentsTooLarge => 'Liian suuri esikatseltavaksi tässä.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Näytetään ensimmäiset $shown (yhteensä $total). Saat kaiken kopioimalla, jakamalla tai tallentamalla.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Tätä PDF-tiedostoa ei voi näyttää tässä (se voi olla suojattu salasanalla).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page/$count';
  }

  @override
  String get attachmentsModeTable => 'Taulukko';

  @override
  String get attachmentsModeText => 'Teksti';

  @override
  String get attachmentsModeMessage => 'Viesti';

  @override
  String get attachmentsModeSource => 'Lähdekoodi';

  @override
  String get attachmentsDontWrap => 'Älä rivitä';

  @override
  String get attachmentsWrap => 'Rivitä';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines riviä', one: '$lines rivi');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopioi kaikki';

  @override
  String get attachmentsCopied => 'Kopioitu';

  @override
  String get attachmentsImageUnavailable => 'Tätä kuvaa ei voi näyttää tässä. Kokeile toimintoa ”Avaa sovelluksessa…”.';

  @override
  String get attachmentsEmlNoSubject => '(Ei aihetta)';

  @override
  String get attachmentsEmlFrom => 'Lähettäjä';

  @override
  String get attachmentsEmlTo => 'Vastaanottaja';

  @override
  String get attachmentsEmlCc => 'Kopio';

  @override
  String get attachmentsEmlDate => 'Päivämäärä';

  @override
  String get attachmentsEmlNoText => 'Tässä viestissä ei ole tekstiä.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Liitteet: $names', one: 'Liite: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Järjestäjä: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ja $count muuta tapahtumaa',
      one: 'Ja $count muu tapahtuma',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Kuva';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-kuva';
  }

  @override
  String get attachmentsTypePdf => 'PDF-asiakirja';

  @override
  String get attachmentsTypeTsv => 'Sarkaimin erotetut arvot';

  @override
  String get attachmentsTypeCsv => 'CSV-taulukko';

  @override
  String get attachmentsTypeCalendar => 'Kalenteritapahtuma';

  @override
  String get attachmentsTypeEmail => 'Sähköpostiviesti';

  @override
  String get attachmentsTypeContact => 'Yhteystietokortti';

  @override
  String get attachmentsTypeLog => 'Lokitiedosto';

  @override
  String get attachmentsTypeText => 'Teksti';

  @override
  String get attachmentsTypeZip => 'ZIP-arkisto';

  @override
  String get attachmentsTypeArchive => 'Pakattu arkisto';

  @override
  String get attachmentsTypeWord => 'Word-asiakirja';

  @override
  String get attachmentsTypeExcel => 'Excel-laskentataulukko';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-esitys';

  @override
  String get attachmentsTypeWebPage => 'Verkkosivu';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Ääni';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-tiedosto';
  }

  @override
  String get attachmentsTypeFile => 'Tiedosto';

  @override
  String get calendarUntitledEvent => 'Tapahtuma';

  @override
  String get calendarAllDay => 'Koko päivän';

  @override
  String calendarYourTime(String time) {
    return '$time omalla aikavyöhykkeelläsi';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Liity: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name on hyväksynyt kutsun: $details',
      'tentative': '$name on hyväksynyt kutsun alustavasti: $details',
      'declined': '$name on hylännyt kutsun: $details',
      'delegated': '$name on siirtänyt kutsun toiselle: $details',
      'other': '$name ei ole vastannut kutsuun: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name on hyväksynyt kutsun',
      'tentative': '$name on hyväksynyt kutsun alustavasti',
      'declined': '$name on hylännyt kutsun',
      'delegated': '$name on siirtänyt kutsun toiselle',
      'other': '$name ei ole vastannut kutsuun',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kartta';

  @override
  String get calendarJoin => 'Liity';

  @override
  String get calendarOnlineMeeting => 'Verkkokokous';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Verkkokokous ($provider)';
  }

  @override
  String get calendarOrganizerYou => 'Sinä';

  @override
  String get calendarOrganizerLabel => 'järjestäjä';

  @override
  String get calendarStatusAccepted => 'Hyväksytty';

  @override
  String get calendarStatusMaybe => 'Ehkä';

  @override
  String get calendarStatusDeclined => 'Hylätty';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hyväksyi',
      'tentative': '$name hyväksyi alustavasti',
      'declined': '$name hylkäsi',
      'delegated': '$name siirsi toiselle',
      'other': '$name ei vastannut',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hyväksyi:',
      'tentative': '$name hyväksyi alustavasti:',
      'declined': '$name hylkäsi:',
      'delegated': '$name siirsi toiselle:',
      'other': '$name ei vastannut:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '”$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name ehdottaa uutta aikaa';
  }

  @override
  String get calendarCounterUnknown => 'Osallistuja ehdottaa uutta aikaa';

  @override
  String get calendarDeclineCounter => 'Järjestäjä piti alkuperäisen ajan';

  @override
  String calendarRefresh(String name) {
    return '$name pyytää uusinta versiota';
  }

  @override
  String get calendarRefreshUnknown => 'Osallistuja pyytää uusinta versiota';

  @override
  String get calendarCancelled => 'Peruttu';

  @override
  String get calendarCancelledByOrganizer => 'Järjestäjä perui tämän tapahtuman.';

  @override
  String get calendarCancelledLater => 'Tämä tapahtuma peruttiin myöhemmin.';

  @override
  String get calendarOutdated => 'Vanhentunut';

  @override
  String get calendarOutdatedDetail => 'Tätä kutsua on päivitetty myöhemmin; uudempi on voimassa.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Paikka poistettu (oli $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Paikka poistettu (ei aiempaa paikkaa)';

  @override
  String calendarLocationChanged(String location) {
    return 'Paikka muutettu: $location';
  }

  @override
  String get calendarNewTitle => 'Uusi otsikko';

  @override
  String get calendarRepeatChanged => 'Toistuvuus muuttui';

  @override
  String get calendarUpdated => 'Päivitetty';

  @override
  String get calendarUpdatedInvitation => 'Päivitetty kutsu';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Aika muuttui: oli $before, nyt $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Aikavyöhyke ”$zone” tuntematon: ajat kuten kirjoitettu';
  }

  @override
  String calendarNext(String when) {
    return 'Seuraava: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count osallistujaa',
      one: '$count osallistuja',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count hyväksyi', one: '$count hyväksyi');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ehkä', one: '$count ehkä');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count hylkäsi', one: '$count hylkäsi');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (sinä)';
  }

  @override
  String get calendarAttendeeOptional => 'valinnainen';

  @override
  String get calendarAttendeeRoom => 'huone';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Hyväksyit aiemman version.',
      'tentative': 'Hyväksyit aiemman version alustavasti.',
      'declined': 'Hylkäsit aiemman version.',
      'delegated': 'Siirsit aiemman version toiselle.',
      'other': 'Et vastannut aiempaan versioon.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Hyväksy';

  @override
  String get calendarMaybe => 'Ehkä';

  @override
  String get calendarDecline => 'Hylkää';

  @override
  String get calendarCommentHint => 'Kommentti järjestäjälle (valinnainen)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Vastauksesi lähetetään henkilölle $organizer osoitteesta $address.';
  }

  @override
  String get calendarAddComment => 'Lisää kommentti';

  @override
  String get calendarAddToCalendar => 'Lisää kalenteriin';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ja $count muuta tapahtumaa tiedostossa',
      one: 'Ja $count muu tapahtuma tiedostossa',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Ei kalenterisovellusta, johon tapahtuman voisi lisätä.';

  @override
  String get calendarCantOpenCalendar => 'Kalenteria ei voitu avata.';

  @override
  String get calendarCantOpenLink => 'Linkkiä ei voitu avata.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Liitytäänkö kokoukseen ($provider)?';
  }

  @override
  String get calendarJoinTitle => 'Liitytäänkö kokoukseen?';

  @override
  String calendarJoinOpens(String host) {
    return 'Avaa sivuston $host selaimessasi.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Varo: tämä osoite jäljittelee sivustoa $site samannäköisillä kirjaimilla.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Varo: tämä osoite jäljittelee toista sivustoa samannäköisillä kirjaimilla.';

  @override
  String calendarJoinOpen(String host) {
    return 'Avaa $host';
  }

  @override
  String get calendarNoOrganizer => 'Tässä kutsussa ei ole järjestäjää, jolle vastata.';

  @override
  String get calendarNoAccount => 'Ei tiliä, josta vastata.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Hyväksytty', 'tentative': 'Ehkä', 'other': 'Hylätty'});
    return '$_temp0 · lähetetään vastausta henkilölle $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Hyväksytty', 'tentative': 'Ehkä', 'other': 'Hylätty'});
    return '$_temp0 · vastaus lähetetty';
  }

  @override
  String get calendarReplyAlreadySent => 'Vastaus oli jo lähetetty.';

  @override
  String get calendarReplyNotSent => 'Vastausta ei lähetetty.';

  @override
  String get dataSmimeNeedsDevice =>
      'S/MIME-varmenteesi on tällä laitteella: avaa Loupe, niin tämä viesti allekirjoitetaan ja lähetetään.';

  @override
  String dataSigningFailed(String error) {
    return 'Allekirjoitus epäonnistui: $error';
  }

  @override
  String get keyboardShortcuts => 'Pikanäppäimet';

  @override
  String get keyboardGroupGeneral => 'Yleiset';

  @override
  String get keyboardGroupMessages => 'Viestit';

  @override
  String get keyboardGroupCompose => 'Kirjoittaminen';

  @override
  String get keyboardCommandPalette => 'Komentopaletti';

  @override
  String get keyboardBackClose => 'Takaisin, sulje';

  @override
  String get keyboardNextMessage => 'Seuraava viesti';

  @override
  String get keyboardPreviousMessage => 'Edellinen viesti';

  @override
  String get keyboardOpenMessage => 'Avaa viesti';

  @override
  String get keyboardMoveToTrash => 'Siirrä roskakoriin';

  @override
  String get keyboardToggleRead => 'Merkitse luetuksi tai lukemattomaksi';

  @override
  String get keyboardToggleFlag => 'Liputa tai poista lippu';

  @override
  String get keyboardCloseDraft => 'Sulje (tallenna tai poista luonnos)';

  @override
  String get keyboardOr => 'tai';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Vaihto';

  @override
  String get keyboardKeyEnter => 'Enter';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyBackspace => 'Askelpalautin';

  @override
  String get mailingListsMuted => 'Ketju mykistetty. Sen uudet viestit saapuvat luettuina.';

  @override
  String get mailingListsUnmuted => 'Ketjun mykistys poistettu.';

  @override
  String get mailingListsMuteThread => 'Mykistä ketju';

  @override
  String get mailingListsUnmuteThread => 'Poista ketjun mykistys';

  @override
  String get mailingListsPin => 'Kiinnitä Postilaatikoihin';

  @override
  String get mailingListsUnpin => 'Poista kiinnitys Postilaatikoista';

  @override
  String get mailingListsDefaultView => 'Avaa oletusnäkymässä';

  @override
  String get mailingListsPlainText => 'Avaa pelkkänä tekstinä (Mono)';

  @override
  String get mailingListsShowMuted => 'Näytä mykistetyt ketjut';

  @override
  String get mailingListsHideMuted => 'Piilota mykistetyt ketjut';

  @override
  String get mailingListsTreatAsNewsletter => 'Käsittele uutiskirjeenä';

  @override
  String get mailingListsOptions => 'Listan asetukset';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted lukematonta',
      one: '$formatted lukematon',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Uusi viesti listalle';

  @override
  String get mailingListsRowUnread => 'Lukematon';

  @override
  String get mailingListsRowMuted => 'Mykistetty';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vastausta', one: '$count vastaus');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Ei ketjuja';

  @override
  String get mailingListsMutedHidden => 'Mykistetyt ketjut on piilotettu.';

  @override
  String get mailingListsTechnicalTitle => 'Tekniset listat';

  @override
  String get mailingListsTechnicalEmpty => 'Postituslistat näkyvät täällä, kun niiden postia saapuu.';

  @override
  String get mailingListsTechnicalFooter =>
      'Näiden listojen viestit avautuvat pelkkänä tekstinä tasalevyisellä fontilla, ja patchit näytetään diffeinä. Aa-painikkeella voit edelleen vaihtaa minkä tahansa viestin näkymää.';

  @override
  String get paletteMoveToMailbox => 'Siirrä postilaatikkoon…';

  @override
  String get paletteMarkAllRead => 'Merkitse kaikki luetuiksi';

  @override
  String get paletteExportFolder => 'Vie kansio…';

  @override
  String get paletteGetNewMail => 'Hae uudet viestit';

  @override
  String get paletteSnoozed => 'Torkutetut';

  @override
  String get paletteSubscriptions => 'Tilaukset';

  @override
  String get paletteDiscussions => 'Keskustelut';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Postituslista';

  @override
  String get paletteTag => 'Tunniste';

  @override
  String get paletteSwipeActions => 'Pyyhkäisytoiminnot';

  @override
  String get paletteNotifications => 'Ilmoitukset';

  @override
  String get paletteRules => 'Säännöt';

  @override
  String get paletteEncryption => 'Päästä päähän -salaus';

  @override
  String get paletteAdvanced => 'Lisäasetukset';

  @override
  String get paletteAddAccount => 'Lisää tili';

  @override
  String get paletteAccount => 'Tili';

  @override
  String get paletteFolders => 'Kansiot';

  @override
  String get paletteRecentSearch => 'Viimeaikainen haku';

  @override
  String paletteSearchMail(String query) {
    return 'Hae postista ”$query”';
  }

  @override
  String get palettePlaceholder => 'Hae toimintoja, postilaatikoita, asetuksia';

  @override
  String get paletteNothingFound => 'Mitään ei löytynyt';

  @override
  String get searchNewSmartMailbox => 'Uusi Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Näyttää kaiken, mikä vastaa hakua ”$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '”$name” tallennettu Postilaatikoihin';
  }

  @override
  String get searchMakeRule => 'Tee tästä sääntö';

  @override
  String get searchSaveSmartMailbox => 'Tallenna Smart Mailboxiksi';

  @override
  String get searchNegate => 'Sulje pois';

  @override
  String get searchDontNegate => 'Älä sulje pois';

  @override
  String get searchAllMailboxes => 'Kaikki postilaatikot';

  @override
  String get searchRecent => 'Viimeaikaiset haut';

  @override
  String get searchClear => 'Tyhjennä';

  @override
  String get searchSuggestions => 'Ehdotukset';

  @override
  String get searchUnreadMessages => 'Lukemattomat viestit';

  @override
  String get searchFlaggedMessages => 'Liputetut viestit';

  @override
  String get searchWithAttachments => 'Liitteelliset viestit';

  @override
  String get searchUnrepliedMessages => 'Vastaamattomat viestit';

  @override
  String get searchTags => 'Tunnisteet';

  @override
  String get searchPeople => 'Henkilöt';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxit';

  @override
  String searchFromPerson(String name) {
    return 'Lähettäjä: $name';
  }

  @override
  String get searchSearching => 'Haetaan…';

  @override
  String get searchNoResults => 'Ei tuloksia';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted tulosta',
      one: '$formatted tulos',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Hakuvalikko';

  @override
  String searchSearchingAccount(String account) {
    return 'Haetaan tilin $account palvelimelta…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Haetaan tilin palvelimelta…';

  @override
  String searchAccountFailed(String account) {
    return 'Tilin $account palvelimelta ei voitu hakea';
  }

  @override
  String get searchUnknownAccountFailed => 'Tilin palvelimelta ei voitu hakea';

  @override
  String searchChip(String term) {
    return '$term. Muokkaa kaksoisnapauttamalla.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Poissuljettu: $term. Muokkaa kaksoisnapauttamalla.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingerin postilaatikko: jokainen viesti täällä on sekä luettu että lukematon, kunnes avaat sen.';

  @override
  String searchContradiction(String term) {
    return 'Mikään viesti ei voi samaan aikaan täyttää ehtoa ”$term” ja olla täyttämättä sitä.';
  }

  @override
  String get searchSyncDeviceOnly => 'Vain tällä laitteella';

  @override
  String searchSyncUnsupported(String account) {
    return 'Vain tällä laitteella: tili $account ei voi säilyttää sitä';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Ei synkronoitu: tilillä $account on uudempi muoto';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Odottaa synkronointia tilille $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synkronoitu tilille $account';
  }

  @override
  String get searchRename => 'Nimeä uudelleen';

  @override
  String get searchEditSearch => 'Muokkaa hakua';

  @override
  String get searchDeleteSmartMailbox => 'Poista Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Nimeä Smart Mailbox uudelleen';

  @override
  String get searchSmartMailboxDeleted => 'Tämä Smart Mailbox on poistettu.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxit';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxit pysyvät tällä laitteella.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxit säilytetään sähköpostipalvelimellasi, joten ne ovat myös muilla laitteillasi, samoin Thunderbirdissä Expression Search Reloaded -lisäosan kanssa. Kaikista tileistä hakevat säilytetään tilillä $account, yhden kansion Smart Mailboxit kyseisen kansion tilillä.';
  }

  @override
  String get searchSyncVia => 'Synkronointitili';

  @override
  String get searchSyncViaFooter => 'Valitse sama tili jokaisella laitteella.';

  @override
  String get searchGmailCantKeep => 'Gmail ei voi säilyttää Smart Mailboxeja';

  @override
  String get searchKeepOnDevice => 'Säilytä Smart Mailboxit vain tällä laitteella';

  @override
  String get searchOnTheServer => 'Palvelimella';

  @override
  String get searchServerFooter =>
      'Palvelimen metatiedot (IMAP METADATA) eivät näy missään sähköpostisovelluksessa. Jos palvelin ei tue niitä, sille luodaan ”Loupe Settings” -kansio, jossa on yksi viesti; Loupe piilottaa sen Postilaatikot-näkymästä.';

  @override
  String get searchSyncNow => 'Synkronoi nyt';

  @override
  String get searchStateUnsupported => 'Ei tuettu';

  @override
  String get searchStateNewerFormat => 'Uudempi muoto';

  @override
  String get searchStateFailed => 'Synkronointi epäonnistui';

  @override
  String get searchStateSyncing => 'Synkronoidaan…';

  @override
  String get searchStateWaiting => 'Odottaa';

  @override
  String get searchStateMetadata => 'Palvelimen metatiedot';

  @override
  String get searchStateFolder => 'Loupe Settings -kansio';

  @override
  String get searchStateNothing => 'Ei tallennettu mitään';

  @override
  String get sharedBack => 'Takaisin';

  @override
  String get sharedYesterday => 'Eilen';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date klo $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tavua', one: '$count tavu');
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size kt';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size Mt';
  }

  @override
  String get sharedSyncNoAccounts => 'Ei tilejä';

  @override
  String get sharedSyncChecking => 'Tarkistetaan postia…';

  @override
  String get sharedSyncFailed => 'Postin tarkistus epäonnistui';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Ei verkkoyhteyttä';

  @override
  String get sharedSyncJustNow => 'Päivitetty juuri nyt';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Päivitetty $minutes minuuttia sitten',
      one: 'Päivitetty $minutes minuutti sitten',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Päivitetty klo $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Päivitetty $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Kaikki saapuneet';

  @override
  String get sharedMailboxUnread => 'Lukemattomat';

  @override
  String get sharedMailboxFlagged => 'Liputetut';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Kaikki luonnokset';

  @override
  String get sharedMailboxAllSent => 'Kaikki lähetetyt';

  @override
  String get sharedMailboxUntitled => 'Postilaatikko';

  @override
  String get sharedTagImportant => 'Tärkeä';

  @override
  String get sharedTagWork => 'Työ';

  @override
  String get sharedTagPersonal => 'Henkilökohtainen';

  @override
  String get sharedTagToDo => 'Tehtävää';

  @override
  String get sharedTagLater => 'Myöhemmin';

  @override
  String get sharedTags => 'Tunnisteet';

  @override
  String get sharedMoveTo => 'Siirrä kansioon…';

  @override
  String get sharedNoRecipients => 'Ei vastaanottajia';

  @override
  String get sharedUnknownSender => 'Tuntematon lähettäjä';

  @override
  String get sharedOnServer => 'Palvelimella';

  @override
  String get sharedAttachment => 'Liite';

  @override
  String get sharedSnoozedBadge => 'Torkutettu';

  @override
  String get sharedRowUnread => 'Lukematon';

  @override
  String get sharedRowBackFromSnooze => 'Palannut torkusta';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Liputettu';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä arkistoitu',
      one: '$count viesti arkistoitu',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä poistettu',
      one: '$count viesti poistettu',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä siirretty Saapuneet-kansioon',
      one: '$count viesti siirretty Saapuneet-kansioon',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä siirretty roskakoriin',
      one: '$count viesti siirretty roskakoriin',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä siirretty roskapostiin',
      one: '$count viesti siirretty roskapostiin',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä siirretty kansioon $mailbox',
      one: '$count viesti siirretty kansioon $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä siirretty postilaatikkoon',
      one: '$count viesti siirretty postilaatikkoon',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viestiä torkutettu, palaavat $time',
      one: '$count viesti torkutettu, palaa $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Torkutettu vain tällä laitteella, palaa $time: palvelin ei voi tallentaa torkkuaikoja.';
  }

  @override
  String get sharedMoveOneAccount => 'Valitse siirrettävät viestit yhdeltä tililtä.';

  @override
  String get sharedSnoozeTitle => 'Torkuta';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Muuta torkkuaikaa';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Poistetaanko $count viestiä pysyvästi?',
      one: 'Poistetaanko tämä viesti pysyvästi?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Tätä ei voi kumota.';

  @override
  String get sharedDeletePermanently => 'Poista pysyvästi';

  @override
  String get sharedSwipeRead => 'Luettu';

  @override
  String get sharedSwipeUnread => 'Lukematon';

  @override
  String get sharedSwipeInbox => 'Saapuneet';

  @override
  String get sharedSwipeDelete => 'Poista';

  @override
  String get sharedTrash => 'Roskakoriin';

  @override
  String get sharedSwipeSnooze => 'Torkuta';

  @override
  String get sharedWakeNow => 'Herätä nyt';

  @override
  String get sharedChangeSnoozeTime => 'Muuta torkkuaikaa…';

  @override
  String get sharedSnooze => 'Torkuta…';

  @override
  String get sharedTag => 'Tunnisteet…';

  @override
  String get sharedMoveMessage => 'Siirrä viesti…';

  @override
  String get sharedNotJunk => 'Ei roskapostia';

  @override
  String get accountSetupTitle => 'Lisää tili';

  @override
  String get accountSetupTitleDone => 'Tili lisätty';

  @override
  String get accountSetupAddressTitle => 'Lisää sähköpostitili';

  @override
  String get accountSetupAddressText => 'Loupe löytää asetukset useimmille palveluntarjoajille.';

  @override
  String get accountSetupNameHint => 'Nimesi';

  @override
  String get accountSetupEmail => 'Sähköposti';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Jatka';

  @override
  String get accountSetupLookingUp => 'Haetaan asetuksia…';

  @override
  String get accountSetupImport => 'Tuo Thunderbirdistä';

  @override
  String get accountSetupInvalidEmail => 'Anna kelvollinen sähköpostiosoite.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Verkkotunnukselle $domain ei löytynyt asetuksia. Anna ne alla.';
  }

  @override
  String get accountSetupCheckServers => 'Tarkista palvelinten nimet ja portit.';

  @override
  String get accountSetupEnterPassword => 'Anna salasanasi.';

  @override
  String get accountSetupConnecting => 'Yhdistetään…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Odotetaan palvelua $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Sivua ei voitu avata.';

  @override
  String get accountSetupCouldNotSaveName => 'Nimeä ei voitu tallentaa.';

  @override
  String get accountSetupTrustCertificate => 'Luota tähän varmenteeseen';

  @override
  String get accountSetupPasswordRequired => 'Pakollinen';

  @override
  String get accountSetupShowPassword => 'Näytä salasana';

  @override
  String get accountSetupHidePassword => 'Piilota salasana';

  @override
  String get accountSetupAppPassword => 'Sovellussalasana';

  @override
  String get accountSetupApiToken => 'API-tunnus';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Saapuva · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Lähtevä · SMTP';

  @override
  String get accountSetupSignIn => 'Kirjaudu sisään';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Kirjaudu palvelulla $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Käytä sovellussalasanaa';

  @override
  String get accountSetupUseAppPasswordInstead => 'Käytä sen sijaan sovellussalasanaa';

  @override
  String get accountSetupUseDifferentAddress => 'Käytä toista osoitetta';

  @override
  String get accountSetupHowToCreateAppPassword => 'Näin luot sovellussalasanan';

  @override
  String get accountSetupHowToCreateOne => 'Näin luot sellaisen';

  @override
  String get accountSetupGoogleNote =>
      'Kirjaudut Googlen sivulla, eikä Loupe koskaan näe salasanaasi. Salli Loupen lukea, lähettää ja järjestää postiasi.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '”Kirjaudu palvelulla Google” ei ole vielä käytettävissä tässä versiossa. Voit sen sijaan yhdistää sovellussalasanalla (se vaatii Google-tililtäsi 2-vaiheisen vahvistuksen).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Luo sovellussalasana Google-tililläsi ja liitä se alle.';

  @override
  String get accountSetupMicrosoftNote =>
      'Kirjaudut Microsoftin sivulla, eikä Loupe koskaan näe salasanaasi. Tämä toimii Outlook.comille ja Hotmailille sekä Microsoft 365:n työ- tai koulutileille.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Microsoft-kirjautuminen tulee myöhemmässä versiossa. Outlook-, Hotmail- ja Microsoft 365 -tilit tarvitsevat sitä: ne eivät enää hyväksy salasanoja sähköpostisovelluksista.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail vaatii appikohtaisen salasanan, ei Apple-tilisi salasanaa.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail vaatii sovellussalasanan, ei tilisi salasanaa.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe yhdistää Fastmailiin JMAP:n kautta API-tunnuksella: Settings › Privacy & Security › Manage API tokens, JMAP-käyttöön, sähköpostin ja lähettämisen oikeuksilla.';

  @override
  String get accountSetupFastmailNote => 'Fastmail vaatii sähköpostisovelluksille sovellussalasanan.';

  @override
  String get accountSetupServerSettings => 'Palvelimen asetukset';

  @override
  String get accountSetupSettingsNotFound => 'Ei löytynyt automaattisesti';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Löytyi lähteestä $source';
  }

  @override
  String get accountSetupEditSettings => 'Muokkaa asetuksia';

  @override
  String get accountSetupSyncing => 'Postiasi synkronoidaan.';

  @override
  String get accountSetupDescription => 'Kuvaus';

  @override
  String get accountSetupDescriptionHint => 'Työ, Henkilökohtainen…';

  @override
  String get accountSetupColour => 'Väri';

  @override
  String accountSetupColourNumber(int number) {
    return 'Väri $number';
  }

  @override
  String get accountSetupSaving => 'Tallennetaan…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe ei voinut avata sähköpostitietokantaansa tässä puhelimessa. Sulje Loupe, avaa se uudelleen ja yritä uudelleen.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Jokin meni vikaan ($error). Yritä uudelleen.';
  }

  @override
  String get accountSetupSecurityNone => 'Ei mitään';

  @override
  String get accountSetupProtocol => 'Protokolla';

  @override
  String get accountSetupPort => 'Portti';

  @override
  String get accountSetupSecurity => 'Suojaus';

  @override
  String get accountSetupUsername => 'Käyttäjänimi';

  @override
  String get accountSetupUsernameHint => 'Sähköpostiosoitteesi';

  @override
  String get accountSetupNoEncryptionTitle => 'Yhdistetäänkö ilman salausta?';

  @override
  String get accountSetupNoEncryptionText =>
      'Salasanasi ja jokainen viesti kulkisivat pelkkänä tekstinä. Kuka tahansa samassa verkossa, kuten julkisessa Wi-Fi-verkossa, voisi lukea ne. Käytä tätä vain oman verkkosi palvelimelle.';

  @override
  String get accountSetupUseWithoutEncryption => 'Käytä ilman salausta';

  @override
  String get accountSetupApiTokenRejected =>
      'API-tunnus hylättiin. Luo Fastmailissa JMAP-käyttöön API-tunnus, jolla on pääsy sähköpostiin, ja liitä se.';

  @override
  String get accountSetupAppPasswordRejected => 'Salasana hylättiin. Käytä sovellussalasanaa, älä tilisi salasanaa.';

  @override
  String get accountSetupPasswordRejected => 'Salasana hylättiin. Tarkista se ja yritä uudelleen.';

  @override
  String get accountSetupServerUnreachable =>
      'Palvelimeen ei saada yhteyttä. Tarkista palvelimen asetukset ja yhteytesi.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Palvelimen varmenteeseen ei luoteta. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Kirjautuminen peruttiin. Yritä uudelleen napauttamalla ”Kirjaudu palvelulla $provider”.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe tarvitsee luvan lukea ja lähettää Gmail-postiasi. Kirjaudu uudelleen ja salli käyttö niin, että Gmail-ruutu on valittuna.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe tarvitsee luvan lukea ja lähettää postiasi. Kirjaudu uudelleen ja hyväksy käyttöoikeudet.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Organisaatiosi on hyväksyttävä Loupe, ennen kuin voit käyttää sitä tällä tilillä. Pyydä IT-järjestelmänvalvojaasi myöntämään Loupelle järjestelmänvalvojan suostumus Microsoft Entra ID:ssä ja yritä sitten uudelleen.';

  @override
  String get accountSetupOAuthBlocked =>
      'Organisaatiosi kirjautumissäännöt eivät salli Loupea tällä laitteella. Kysy IT-järjestelmänvalvojaltasi.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Palveluun $provider ei saatu yhteyttä. Tarkista internetyhteytesi ja yritä uudelleen.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Kirjautumista palvelulla $provider ei ole määritetty oikein tässä Loupen versiossa. Ilmoita tästä meille.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Kirjautuminen palvelulla $provider ei onnistunut. Yritä uudelleen.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider kirjasi sinut sisään, mutta Gmail esti tämän osoitteen käytön. Valitse sama tili kirjautuessasi. Työ- tai koulutileillä järjestelmänvalvoja on voinut poistaa IMAP:n käytöstä.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider kirjasi sinut sisään, mutta sähköpostipalvelin esti tämän osoitteen käytön. Valitse sama tili kirjautuessasi. Työ- tai koulutileillä järjestelmänvalvoja on voinut poistaa IMAP:n käytöstä.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Sähköpostipalvelimeen ei saada yhteyttä. Tarkista yhteytesi ja yritä uudelleen.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Kirjautuminen palvelulla $provider ei ole käytettävissä tässä versiossa.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Kirjauduttu uudelleen. Tiliä $account synkronoidaan.';
  }

  @override
  String get accountSetupSignInAgain => 'Kirjaudu uudelleen';

  @override
  String get accountSetupSigningIn => 'Kirjaudutaan…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider ei enää hyväksy Loupen kirjautumista osoitteelle $email, joten tiliä $account ei synkronoida. Kirjaudu uudelleen, niin saat sen postin.';
  }

  @override
  String get accountImportTitle => 'Tuo Thunderbirdistä';

  @override
  String get accountImportPointCamera => 'Osoita kameralla Thunderbirdin näyttämää QR-koodia.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Skannattu $scanned/$total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned/$total koodia skannattu',
      one: '$scanned/$total koodi skannattu',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tiliä tähän mennessä',
      one: '$count tili tähän mennessä',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Avaa tietokoneellasi Thunderbird ja valitse Työkalut › Vie mobiililaitteelle. Valitse tilisi ja skannaa sitten jokainen näytetty koodi. Koodit voi skannata missä järjestyksessä tahansa.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jatka $count tilillä',
      one: 'Jatka $count tilillä',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Liitä teksti sen sijaan';

  @override
  String get accountImportStartOver => 'Aloita alusta';

  @override
  String get accountImportDuplicateCode => 'Tämä koodi on jo lisätty.';

  @override
  String get accountImportRestarted =>
      'Tämä koodi on uudesta viennistä, joten aiemmin skannatut koodit jätettiin sivuun.';

  @override
  String get accountImportNotThunderbird => 'Tämä ei ole Thunderbirdin tilikoodi.';

  @override
  String get accountImportNewerVersion =>
      'Tämä koodi on uudemmasta Thunderbirdistä. Päivitä Loupe, niin voit tuoda sen.';

  @override
  String get accountImportDamaged => 'Tätä Thunderbird-koodia ei voitu lukea.';

  @override
  String get accountImportTooLarge => 'Tämä koodi on liian suuri ollakseen Thunderbirdin vienti.';

  @override
  String get accountImportCouldNotOpenSettings => 'Asetuksia ei voitu avata.';

  @override
  String get accountImportCameraOffTitle => 'Kameran käyttö on estetty';

  @override
  String get accountImportCameraOffText =>
      'Salli Loupen käyttää kameraa asetuksissa, jotta voit skannata koodin, tai liitä koodin teksti sen sijaan.';

  @override
  String get accountImportNoCameraTitle => 'Ei kameraa';

  @override
  String get accountImportNoCameraText => 'Loupe ei voi käyttää kameraa tässä. Liitä koodin teksti sen sijaan.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera ei käynnistynyt';

  @override
  String get accountImportCameraFailedText => 'Yritä uudelleen tai liitä koodin teksti sen sijaan.';

  @override
  String get accountImportOpenSettings => 'Avaa asetukset';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Löytyi $count tiliä',
      one: 'Löytyi $count tili',
      zero: 'Tilejä ei löytynyt',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Mitään näiden koodien tileistä ei voitu lukea.';

  @override
  String get accountImportChoose => 'Valitse Loupeen lisättävät tilit.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Koodeja $codes (yhteensä $total) ei skannattu, joten niiden tilejä ei näytetä.',
      one: 'Koodia $codes (yhteensä $total) ei skannattu, joten sen tilejä ei näytetä.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes ja $last';
  }

  @override
  String get accountImportScanMore => 'Skannaa lisää koodeja';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count koodeissa olevaa tiliä ei voitu lukea. Ne saattavat käyttää uudemman Thunderbirdin asetuksia.',
      one: '$count koodeissa olevaa tiliä ei voitu lukea. Se saattaa käyttää uudemman Thunderbirdin asetuksia.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skannaa uudelleen';

  @override
  String get accountImportAlreadyAdded => 'Tällä osoitteella on jo tili Loupessa.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Kirjaudut palvelulla $provider, kun tili lisätään, kuten Thunderbirdissä.';
  }

  @override
  String get accountImportGmailAppPassword => 'Lisää tili sovellussalasanalla (se vaatii 2-vaiheisen vahvistuksen).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird kirjautuu Gmailiin Googlella. ”Kirjaudu palvelulla Google” tulee myöhemmässä versiossa; siihen asti lisää tili sovellussalasanalla (se vaatii 2-vaiheisen vahvistuksen).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird kirjautuu tälle tilille selaimessa. Loupe ei osaa sitä vielä: käytä sovellussalasanaa, jos palveluntarjoajasi tarjoaa sellaisen.';

  @override
  String get accountImportUnencrypted => 'Yhdistää ilman salausta. Käytä tätä vain omassa verkossasi.';

  @override
  String get accountImportEnterAgain => 'Anna se uudelleen';

  @override
  String get accountImportAdded => 'Lisätty';

  @override
  String accountImportAdding(int index, int total) {
    return 'Lisätään $index/$total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lisää $count tiliä',
      one: 'Lisää $count tili',
      zero: 'Lisää tilit',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Liitä vientiteksti';

  @override
  String get accountImportPasteText => 'Liitä Thunderbirdin vientikoodin teksti, yksi koodi riviä kohden.';

  @override
  String get accountImportPop3 => 'POP3-tilejä ei tueta. Loupe pitää postin palvelimella IMAP:n avulla.';

  @override
  String get accountImportKerberos => 'Tämä tili kirjautuu Kerberoksella, jota Loupe ei tue.';

  @override
  String get accountImportNtlm => 'Tämä tili kirjautuu NTLM:llä, jota Loupe ei tue.';

  @override
  String get accountImportClientCertificate => 'Tämä tili kirjautuu asiakasvarmenteella, jota Loupe ei vielä tue.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Microsoft-kirjautuminen tulee myöhemmässä versiossa. Outlook- ja Microsoft 365 -tilit eivät enää hyväksy salasanoja sähköpostisovelluksista.';

  @override
  String get accountImportEnterPassword => 'Anna salasana.';

  @override
  String get accountImportEnterAppPassword => 'Anna sovellussalasana.';

  @override
  String get accountImportEnterApiToken => 'Anna API-tunnus.';

  @override
  String get accountImportStorageFailed => 'Loupe ei voinut avata tilien tallennustilaa. Yritä myöhemmin uudelleen.';

  @override
  String get accountImportFailed => 'Tiliä ei voitu lisätä. Yritä uudelleen tai lisää se käsin.';

  @override
  String get composeNewMessageTitle => 'Uusi viesti';

  @override
  String get composeAttach => 'Liitä';

  @override
  String get composeSendLater => 'Lähetä myöhemmin';

  @override
  String composeSendAt(String time) {
    return 'Lähetä $time';
  }

  @override
  String get composeSendHint => 'Lähetä myöhemmin painamalla pitkään';

  @override
  String get composeNoAccount => 'Lisää tili, jotta voit lähettää postia.';

  @override
  String get composeTo => 'Vastaanottaja:';

  @override
  String get composeCc => 'Kopio:';

  @override
  String get composeBcc => 'Piilokopio:';

  @override
  String composeCcBccFrom(String email) {
    return 'Kopio/Piilokopio, Lähettäjä: $email';
  }

  @override
  String get composeFromLabel => 'Lähettäjä:';

  @override
  String get composeSubjectLabel => 'Aihe:';

  @override
  String composeReplyTo(String address) {
    return 'Vastausosoite: $address';
  }

  @override
  String get composeFrom => 'Lähettäjä';

  @override
  String composeReplyFrom(String email) {
    return 'Vastaa osoitteesta $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Lähetä osoitteesta $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vastataanko osoitteesta $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Lähetetäänkö osoitteesta $email?';
  }

  @override
  String get composeDismiss => 'Ohita';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ei tallennettu identiteetiksi · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Tallenna identiteetiksi';

  @override
  String composeAliasSaved(String email) {
    return '$email on tallennettu identiteetiksi.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Virheellinen osoite $address';
  }

  @override
  String get composeOriginalNotFound => 'Alkuperäistä viestiä ei löytynyt.';

  @override
  String get composeDraftNotFound => 'Luonnosta ei löytynyt.';

  @override
  String get composeAttachmentsLost => 'Liitteitä ei voitu palauttaa. Lisää ne uudelleen.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Kaikkia liitteitä ei voitu lisätä: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Liitteiden yhteiskoko on $size; jotkin palvelimet hylkäävät näin suuret viestit.';
  }

  @override
  String get composeAttachFailed => 'Tiedostoa ei voitu liittää.';

  @override
  String get composeInvalidAddressTitle => 'Virheellinen osoite';

  @override
  String composeInvalidAddress(String address) {
    return '”$address” ei ole kelvollinen sähköpostiosoite.';
  }

  @override
  String get composeNoSubjectTitle => 'Ei aihetta';

  @override
  String get composeNoSubjectText => 'Tässä viestissä ei ole aihetta. Lähetetäänkö silti?';

  @override
  String get composeSentBeforeChanges => 'Se lähetettiin ennen muutoksiasi, jotka on tallennettu luonnoksiin.';

  @override
  String composeScheduled(String time) {
    return 'Ajastettu: $time';
  }

  @override
  String get composeSending => 'Lähetetään…';

  @override
  String get composeSent => 'Lähetetty';

  @override
  String get composeSendFailed => 'Lähetys epäonnistui. Yritä uudelleen.';

  @override
  String get composeAlreadySent => 'Jo lähetetty.';

  @override
  String get composeDiscardChanges => 'Hylkää muutokset';

  @override
  String get composeSaveChanges => 'Tallenna muutokset';

  @override
  String get composeDeleteDraft => 'Poista luonnos';

  @override
  String get composeSaveDraft => 'Tallenna luonnos';

  @override
  String get composeDraftSaved => 'Luonnos tallennettu';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$name kirjoitti $date klo $time:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Joku kirjoitti $date klo $time:';
  }

  @override
  String get composeForwardHeader => '---------- Välitetty viesti ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Lähettäjä: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Päivämäärä: $date klo $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Aihe: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Vastaanottaja: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Kopio: $addresses';
  }

  @override
  String get composeLaterToday => 'Myöhemmin tänään';

  @override
  String get composeTomorrowMorning => 'Huomenaamulla';

  @override
  String get composeMondayMorning => 'Maanantaiaamuna';

  @override
  String get composePickDateTime => 'Valitse päivä ja aika…';

  @override
  String get composeSendWithoutDelay => 'Lähetä heti';

  @override
  String composeSendTimeToday(String time) {
    return 'Tänään klo $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Huomenna klo $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day klo $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Tänään $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Huomenna $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Jatketaanko luonnoksen muokkaamista?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Viestiä ei lähetetty, kun Loupe suljettiin.',
      'one': 'Viestiä vastaanottajalle $name ei lähetetty, kun Loupe suljettiin.',
      'other': 'Viestiä vastaanottajalle $name ja muille ei lähetetty, kun Loupe suljettiin.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Viestiä ”$subject” ei lähetetty, kun Loupe suljettiin.',
      'one': 'Viestiä ”$subject” vastaanottajalle $name ei lähetetty, kun Loupe suljettiin.',
      'other': 'Viestiä ”$subject” vastaanottajalle $name ja muille ei lähetetty, kun Loupe suljettiin.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Jatka muokkaamista';

  @override
  String get composeRecoverySave => 'Tallenna luonnoksiin';

  @override
  String get composeRecoveryDiscard => 'Hylkää';

  @override
  String get composeRecoverySaved => 'Tallennettu luonnoksiin';

  @override
  String get outboxSectionFailed => 'Ei lähetetty';

  @override
  String get outboxSectionSending => 'Lähetetään';

  @override
  String get outboxSectionScheduled => 'Ajastetut';

  @override
  String get outboxStatusQueued => 'Lähtee pian';

  @override
  String get outboxStatusSending => 'Lähetetään…';

  @override
  String get outboxStatusFailed => 'Ei lähetetty';

  @override
  String get outboxNoRecipients => 'Ei vastaanottajia';

  @override
  String get outboxNoSubject => '(Ei aihetta)';

  @override
  String get outboxSendingFailed => 'Lähetys epäonnistui.';

  @override
  String get outboxEmptyTitle => 'Ei lähetettävää';

  @override
  String get outboxEmptyText => 'Myöhemmin lähetettävät viestit odottavat täällä, kunnes on aika.';

  @override
  String get outboxSendNow => 'Lähetä nyt';

  @override
  String get outboxReschedule => 'Ajasta uudelleen';

  @override
  String get outboxRescheduleMenu => 'Ajasta uudelleen…';

  @override
  String get outboxRescheduleTitle => 'Ajasta uudelleen';

  @override
  String outboxRescheduled(String time) {
    return 'Ajastettu uudelleen: $time';
  }

  @override
  String get outboxCancel => 'Peru';

  @override
  String get outboxCancelSending => 'Peru lähetys…';

  @override
  String get outboxCancelTitle => 'Perutaanko lähetys?';

  @override
  String get outboxMoveToDrafts => 'Siirrä luonnoksiin';

  @override
  String get outboxDiscard => 'Hylkää viesti';

  @override
  String get outboxMovedToDrafts => 'Siirretty luonnoksiin';

  @override
  String get outboxDiscarded => 'Viesti hylätty';

  @override
  String get outboxAlreadySent => 'Jo lähetetty.';

  @override
  String get outboxBeingSent => 'Tätä viestiä lähetetään parhaillaan.';

  @override
  String get outboxActionFailed => 'Se ei onnistunut. Viesti on yhä Lähtevät-kansiossa.';

  @override
  String get notificationsBadgeInboxes => 'Lukemattomat Saapuneet-kansioissa';

  @override
  String get notificationsBadgeVip => 'Lukemattomat VIP-postilaatikossa';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Uusi posti VIP-henkilöiltäsi millä tahansa tilillä';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Uusi posti tilillä $email';
  }

  @override
  String get notificationsUnknownSender => 'Tuntematon lähettäjä';

  @override
  String get notificationsNoSubject => '(Ei aihetta)';

  @override
  String get notificationsEncryptedMessage => 'Salattu viesti';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Uusi viesti tilille $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uutta viestiä',
      one: '$count uusi viesti',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Uusia viestejä tilillä $account';
  }

  @override
  String get platformInstantChannel => 'Välitön toimitus';

  @override
  String get platformInstantChannelDescription => 'Näkyy, kun Loupe odottaa uutta postia Saapuneet-kansioihisi';

  @override
  String get platformInstantTitle => 'Odotetaan uutta postia';

  @override
  String get platformInstantText => 'Välitön toimitus on päällä';

  @override
  String get platformErrorBox => 'Tämän näyttämisessä tapahtui virhe. Palaa takaisin ja yritä uudelleen.';

  @override
  String get welcomeTagline => 'Sähköposti, joka on pinnalta yksinkertainen\nja pinnan alla tehokas.';

  @override
  String get welcomeAccountsTitle => 'Kaikki tilit, yksi rauhallinen postilaatikko';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail ja mikä tahansa IMAP- tai JMAP-palvelin.';

  @override
  String get welcomeSearchTitle => 'Haku, joka löytää';

  @override
  String get welcomeSearchText => 'Välittömät tulokset puhelimesta, sitten palvelimelta.';

  @override
  String get welcomePrivacyTitle => 'Suunniteltu yksityiseksi';

  @override
  String get welcomePrivacyText => 'Ei seurantaa. Etäkuvat pysyvät estettyinä, kunnes toisin päätät.';

  @override
  String get welcomeAddAccount => 'Lisää tili';

  @override
  String get welcomeImport => 'Tuo Thunderbirdistä';

  @override
  String get welcomeTryDemo => 'Kokeile demopostilla';
}
