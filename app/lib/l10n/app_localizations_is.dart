// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get commonAdd => 'Bæta við';

  @override
  String get commonCancel => 'Hætta við';

  @override
  String get commonClose => 'Loka';

  @override
  String get commonDelete => 'Eyða';

  @override
  String get commonDone => 'Lokið';

  @override
  String get commonEdit => 'Breyta';

  @override
  String get commonMore => 'Meira';

  @override
  String get commonMove => 'Færa';

  @override
  String get commonName => 'Nafn';

  @override
  String get commonNone => 'Ekkert';

  @override
  String get commonOff => 'Slökkt';

  @override
  String get commonOk => 'Í lagi';

  @override
  String get commonOn => 'Kveikt';

  @override
  String get commonOptional => 'Valfrjálst';

  @override
  String get commonPassword => 'Lykilorð';

  @override
  String get commonRemove => 'Fjarlægja';

  @override
  String get commonRetry => 'Reyna aftur';

  @override
  String get commonSave => 'Vista';

  @override
  String get commonSearch => 'Leita';

  @override
  String get commonServer => 'Netþjónn';

  @override
  String get commonSettings => 'Stillingar';

  @override
  String get commonShare => 'Deila';

  @override
  String get commonTryAgain => 'Reyna aftur';

  @override
  String get commonUndo => 'Afturkalla';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count skilaboð', one: '$count skilaboð');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Setja í geymslu';

  @override
  String get mailDelete => 'Eyða';

  @override
  String get mailFlag => 'Flagga';

  @override
  String get mailForward => 'Áframsenda';

  @override
  String get mailMarkAsRead => 'Merkja sem lesið';

  @override
  String get mailMarkAsUnread => 'Merkja sem ólesið';

  @override
  String get mailMoveToJunk => 'Færa í ruslpóst';

  @override
  String get mailNewMessage => 'Ný skilaboð';

  @override
  String get mailNoSubject => 'Ekkert efni';

  @override
  String get mailReply => 'Svara';

  @override
  String get mailReplyAll => 'Svara öllum';

  @override
  String get mailSend => 'Senda';

  @override
  String get mailUnflag => 'Fjarlægja flagg';

  @override
  String get mailboxArchive => 'Geymsla';

  @override
  String get mailboxDrafts => 'Drög';

  @override
  String get mailboxInbox => 'Innhólf';

  @override
  String get mailboxJunk => 'Ruslpóstur';

  @override
  String get mailboxOutbox => 'Úthólf';

  @override
  String get mailboxSent => 'Sendur póstur';

  @override
  String get mailboxTrash => 'Rusl';

  @override
  String get conversationSomethingWentWrong => 'Eitthvað fór úrskeiðis. Reyndu aftur.';

  @override
  String get conversationReplyToList => 'Svara póstlistanum';

  @override
  String get conversationReplyList => 'Svara lista';

  @override
  String get conversationThreadMuted => 'Þráðurinn er þaggaður. Ný skilaboð í honum berast sem lesin.';

  @override
  String get conversationThreadUnmuted => 'Þráðurinn er ekki lengur þaggaður.';

  @override
  String get conversationLinkFailed => 'Ekki tókst að opna tengilinn.';

  @override
  String get conversationGoneTitle => 'Engin skilaboð';

  @override
  String get conversationGoneText => 'Þessi skilaboð voru færð eða þeim eytt.';

  @override
  String get conversationMuted => 'Þaggað';

  @override
  String get conversationReaderOptions => 'Lestrarvalkostir';

  @override
  String get conversationReaderOptionsHint => 'Textastærð og sýn';

  @override
  String get conversationTrash => 'Henda';

  @override
  String get conversationReplyHint => 'Haltu inni fyrir Svara öllum og Áframsenda';

  @override
  String get conversationOfflineTitle => 'Engin nettenging';

  @override
  String get conversationOfflineText =>
      'Þetta samtal hefur ekki verið sótt enn. Það hleðst inn þegar nettengingin kemst aftur á.';

  @override
  String get conversationErrorTitle => 'Ekki hægt að sýna þessi skilaboð';

  @override
  String get conversationErrorText => 'Eitthvað fór úrskeiðis.';

  @override
  String get conversationOfflineBanner => 'Engin nettenging';

  @override
  String get conversationNotUpdated => 'Ekki uppfært';

  @override
  String get conversationMe => 'ég';

  @override
  String get conversationNoSender => '(enginn sendandi)';

  @override
  String get conversationNoRecipients => 'engir viðtakendur';

  @override
  String conversationRecipients(String names) {
    return 'til: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'til: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Frá';

  @override
  String get conversationHeaderTo => 'Til';

  @override
  String get conversationHeaderCc => 'Afrit';

  @override
  String get conversationHeaderBcc => 'Falið afrit';

  @override
  String get conversationHeaderReplyTo => 'Svara til';

  @override
  String get conversationHeaderDate => 'Dagsetning';

  @override
  String get conversationHeaderSecurity => 'Öryggi';

  @override
  String get conversationVerifiedSender => 'Staðfestur sendandi';

  @override
  String get conversationUnverifiedSender => 'Óstaðfestur sendandi';

  @override
  String get conversationLoadingMessage => 'Hleð inn skilaboðum';

  @override
  String get conversationBodyError => 'Ekki tókst að hlaða inn þessum skilaboðum.';

  @override
  String get conversationBodyOffline => 'Engin nettenging. Skilaboðin hlaðast inn þegar tengingin kemst aftur á.';

  @override
  String get conversationOriginalHint => 'Lítur betur út í sýninni Upprunalegt';

  @override
  String get conversationShowOriginal => 'Sýna upprunalegt';

  @override
  String get conversationScrollToTop => 'Skruna efst';

  @override
  String get conversationTagsMenu => 'Merki…';

  @override
  String get conversationMuteThread => 'Þagga þráð';

  @override
  String get conversationUnmuteThread => 'Hætta að þagga þráð';

  @override
  String get conversationMoveMenu => 'Færa…';

  @override
  String get conversationDeletePermanently => 'Eyða varanlega';

  @override
  String get conversationMoveToTrash => 'Færa í rusl';

  @override
  String get conversationNotJunk => 'Ekki ruslpóstur';

  @override
  String get conversationShowAllHeaders => 'Sýna alla hausa';

  @override
  String get conversationViewSource => 'Skoða frumtexta';

  @override
  String get conversationSaveAsFile => 'Vista sem skrá…';

  @override
  String get conversationShareAsFile => 'Deila sem skrá…';

  @override
  String get conversationSearchFromMessageMenu => 'Leita út frá þessum skilaboðum…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Afrita netfang';

  @override
  String get conversationAddressCopied => 'Netfang afritað';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Leita að skilaboðum frá $name';
  }

  @override
  String get conversationTags => 'Merki';

  @override
  String get conversationAllHeaders => 'Allir hausar';

  @override
  String get conversationCopyAll => 'Afrita allt';

  @override
  String get conversationHeadersCopied => 'Hausar afritaðir';

  @override
  String get conversationNoHeaders => 'Engir hausar';

  @override
  String get conversationSearchFromMessageTitle => 'Leita út frá þessum skilaboðum';

  @override
  String conversationSearchFrom(String name) {
    return 'Frá $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Til $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Efni „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Frumtexti';

  @override
  String get conversationSourceCopied => 'Frumtexti afritaður';

  @override
  String get conversationShareFailed => 'Ekki tókst að deila skilaboðunum.';

  @override
  String get conversationWrapLines => 'Brjóta línur';

  @override
  String get conversationDontWrapLines => 'Ekki brjóta línur';

  @override
  String get conversationSourceError => 'Ekki tókst að hlaða inn frumtextanum.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Sýni fyrstu $shown af $total. Afritaðu eða deildu til að fá allt.';
  }

  @override
  String get conversationAttachmentUntitled => 'Ónefnt';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Fleiri aðgerðir fyrir $name';
  }

  @override
  String get conversationMoveTo => 'Færa í…';

  @override
  String get conversationMailboxesError => 'Ekki tókst að hlaða inn pósthólfum.';

  @override
  String get conversationReaderReadable => 'Læsilegt';

  @override
  String get conversationReaderOriginal => 'Upprunalegt';

  @override
  String get conversationReaderPlain => 'Einfalt';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Halda upprunalegum litum';

  @override
  String get conversationReaderRemember => 'Muna fyrir þennan sendanda';

  @override
  String get conversationSecurityPossiblePhishing => 'Mögulegar vefveiðar';

  @override
  String get conversationSecurityBeCareful => 'Farðu varlega';

  @override
  String get conversationSecurityVerified => 'Staðfest';

  @override
  String get conversationSecurityNoIssues => 'Ekkert athugavert fannst';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count rekjarar', one: '$count rekjari');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Sýnir ástæðuna';

  @override
  String get conversationPhishingBannerTitle => 'Þessi skilaboð líta út fyrir að vera vefveiðar';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Slökkt er á tenglum og myndum.';
  }

  @override
  String get conversationPhishingBannerText => 'Slökkt er á tenglum og myndum.';

  @override
  String get conversationPhishingWhy => 'Af hverju?';

  @override
  String get conversationPhishingShowAnyway => 'Sýna samt';

  @override
  String get conversationSecurityPhishingTitle => 'Þetta lítur út fyrir að vera vefveiðar';

  @override
  String get conversationSecurityPhishingText =>
      'Ýmis merki benda til þess að þessi skilaboð séu ekki það sem þau segjast vera.';

  @override
  String get conversationSecurityCarefulTitle => 'Farðu varlega með þessi skilaboð';

  @override
  String get conversationSecurityCarefulText => 'Eitthvað við þau verðskuldar nánari skoðun.';

  @override
  String get conversationSecurityVerifiedText => 'Sendandinn er staðfestur og ekkert virðist grunsamlegt.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ekkert virðist grunsamlegt. Póstþjónninn þinn gaf ekki upp hvort sendandinn sé staðfestur.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ekkert virðist grunsamlegt.';

  @override
  String get conversationSecurityWhy => 'Af hverju';

  @override
  String get conversationSecurityPrivacy => 'Persónuvernd';

  @override
  String get conversationSecurityNoTrackingPixels => 'Engir rakningarpixlar';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rakningarpixlar fjarlægðir',
      one: '$count rakningarpixill fjarlægður',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Þeir hefðu látið sendandann vita þegar þú opnaðir þessi skilaboð.';

  @override
  String get conversationSecurityNoRemoteImages => 'Engar fjartengdar myndir';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fjartengdar myndir',
      one: '$count fjartengd mynd',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ef þær eru sóttar fær sendandinn að vita hvenær þú lest þessi skilaboð, og IP-töluna þína.';

  @override
  String get conversationSecurityNoClickTracking => 'Engin smellarakning';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tenglar fara í gegnum smellirekjara',
      one: '$count tengill fer í gegnum smellirekjara',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Smellurinn þinn yrði skráður hjá $services. Haltu inni tengli til að opna áfangastaðinn beint.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Tæknilegar upplýsingar';

  @override
  String get conversationSecurityCheckedLocally => 'Athugað í þessu tæki. Ekkert var sent úr tækinu.';

  @override
  String get conversationSecurityTrackersLabel => 'Rekjarar';

  @override
  String get conversationSecurityImagesFrom => 'Myndir frá';

  @override
  String get conversationSecuritySenderHistory => 'Saga sendanda';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received móttekin, $sent send';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Tenglar vísa á';

  @override
  String get conversationSecurityHidden => 'Falið';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements stök', one: '$elements stak');
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters stafir',
      one: '$characters stafur',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Sendandi ekki staðfestur';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Póstþjónninn þinn gat ekki staðfest að þessi skilaboð komi í raun frá $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Póstþjónninn þinn gat ekki staðfest að þessi skilaboð komi í raun frá sendandanum.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Póstþjónninn þinn gat ekki staðfest að þessi skilaboð komi frá $domain. Algengt hjá póstlistum.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Póstþjónninn þinn gat ekki staðfest að þessi skilaboð komi frá sendandanum. Algengt hjá póstlistum.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ekki bregðast við þeim nema þú hafir átt von á þeim. Ef þú ert í vafa skaltu hafa samband við sendandann eftir annarri leið.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Undirritað af öðru léni';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Skilaboðin eru undirrituð af $signer, ekki $domain. Póstsendingarþjónustur gera þetta, en það sannar ekki hver skrifaði þau.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Skilaboðin eru undirrituð af öðru léni, ekki $domain. Póstsendingarþjónustur gera þetta, en það sannar ekki hver skrifaði þau.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Nafnið sýnir annað netfang';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Nafn sendandans er „$shown“, en skilaboðin koma frá $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Treystu netfanginu, ekki nafninu.';

  @override
  String get conversationSecurityReplyToTitle => 'Svör fara annað';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Ef þú svarar fer svarið til $address, ekki til $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Athugaðu netfangið áður en þú svarar með einhverju persónulegu.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Notar nafnið þitt';

  @override
  String get conversationSecurityImpersonationTitle => 'Notar nafn einhvers sem þú þekkir';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Sendandinn kallar sig „$name“, eins og þú heitir, en skrifar frá nýju netfangi: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Sendandinn kallar sig „$name“, eins og VIP-tengiliðurinn þinn $knownName ($knownEmail), en skrifar frá nýju netfangi: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Sendandinn kallar sig „$name“, eins og $knownName ($knownEmail), en skrifar frá nýju netfangi: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Og svör færu á enn annað netfang.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ef beðið er um peninga, kóða eða skrár skaltu fyrst athuga málið hjá viðkomandi eftir annarri leið.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Þekkt netfang: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Þetta netfang: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Fyrstu skilaboð frá þessum sendanda';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Þú hefur ekki fengið póst frá $email áður.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Farðu varlega með beiðnir frá fólki sem þú þekkir ekki enn.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Stafir sem líkja eftir öðrum í netfangi sendandans';

  @override
  String get conversationSecurityLinkHomographTitle => 'Stafir sem líkja eftir öðrum í tengli';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host blandar saman stöfum úr ólíkum stafrófum til að líkja eftir öðru léni.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host notar stafi sem líkja eftir öðrum: þetta er ekki $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Eyddu skilaboðunum eða tilkynntu þau sem ruslpóst.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ekki opna hann.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Lén: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Lén sem líkir eftir öðru';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Notar þekkt nafn í léninu';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain líkist þínu eigin léni, $real, en er annað lén.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain líkist $brand ($real), en er annað lén.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain notar nafn þíns eigin léns, $real, en tilheyrir því ekki.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain notar nafnið $brand ($real) en er ekki á þeirra vegum.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Raunveruleg skilaboð frá fyrirtækinu þínu koma frá $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Raunveruleg skilaboð frá $brand koma frá $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Lén sendanda: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Líkir eftir: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tenglar fela hvert þeir vísa',
      one: '$count tengill felur hvert hann vísar',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Tengill sýnir $shown en opnar $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ekki skrá þig inn eða greiða í gegnum þessa tengla. Sláðu frekar slóðina inn handvirkt.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Ekki er hægt að athuga hvert tengill vísar';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Tengill sýnir $shown en fer í gegnum $host, sem skráir smellinn áður en hann sendir hann áfram.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Tengill vísar beint á IP-tölu';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts er ekki vefsvæði með nafni. Raunveruleg fyrirtæki nota sjaldan svona tengla.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Dulbúinn tengill';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Tengill byrjar á „$shown@“ til að líta út eins og $shown, en opnar $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Falin síða var gerð óvirk';

  @override
  String get conversationSecurityDataLinkText =>
      'Tengill hefði opnað síðu sem var pakkað inn í skilaboðin, leið fram hjá tenglaathugunum.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Biður um lykilorð';

  @override
  String get conversationSecurityPasswordFieldText => 'Skilaboðin innihéldu lykilorðsreit. Loupe fjarlægði hann.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Sláðu aldrei lykilorð inn í tölvupóst.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Tengill sem keyrir kóða var gerður óvirkur';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe keyrir aldrei kóða úr skilaboðum.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count styttir tenglar',
      one: '$count styttur tengill',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return 'Raunverulegi áfangastaðurinn er falinn á bak við $hosts þar til þú opnar tengilinn.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Alþjóðlegt veffang';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return 'Í $hosts eru stafir utan latneska stafrófsins. Það er eðlilegt á mörgum tungumálum; athugaðu að þetta sé vefurinn sem þú átt von á.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mikið af földum texta';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stafir af ósýnilegum texta voru fjarlægðir. Falinn texti af þessu tagi á að blekkja ruslpóstsíur.',
      one: '$count stafur af ósýnilegum texta var fjarlægður. Falinn texti af þessu tagi á að blekkja ruslpóstsíur.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Falinn texti fjarlægður';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stafir af ósýnilegum texta voru fjarlægðir.',
      one: '$count stafur af ósýnilegum texta var fjarlægður.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Ekki tókst að sækja skilaboðin. Athugaðu tenginguna og reyndu aftur.';

  @override
  String exportSaved(String name) {
    return 'Vistað: „$name“';
  }

  @override
  String get exportSaveFailed => 'Ekki tókst að vista skilaboðin.';

  @override
  String exportFailed(String folder) {
    return 'Ekki tókst að flytja út „$folder“.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Engin skilaboð til að flytja út í „$folder“.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Ekki tókst að flytja út „$folder“: ekki var hægt að sækja nein skilaboð. Athugaðu tenginguna og reyndu aftur.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vistað: „$name“, án $formattedCount skilaboða sem ekki tókst að sækja.',
      one: 'Vistað: „$name“, án $count skilaboða sem ekki tókst að sækja.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Ekki tókst að vista „$name“.';
  }

  @override
  String exportTitle(String folder) {
    return 'Útflutningur á „$folder“';
  }

  @override
  String get exportListing => 'Leita að skilaboðum…';

  @override
  String exportProgress(String current, String total) {
    return 'Flyt út $current af $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ekki tókst að sækja $formattedCount skilaboð',
      one: 'Ekki tókst að sækja $count skilaboð',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Pósthólf';

  @override
  String get mailboxesShown => 'Sýnt';

  @override
  String get mailboxesHidden => 'Falið';

  @override
  String get mailboxesCollapse => 'Draga saman';

  @override
  String get mailboxesExpand => 'Stækka';

  @override
  String get mailboxesManageVips => 'Stjórna VIP-tengiliðum';

  @override
  String get mailboxesSubscriptions => 'Áskriftir';

  @override
  String mailboxesShowAccount(String account) {
    return 'Sýna $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Fela $account';
  }

  @override
  String get mailboxesExportFolder => 'Flytja út möppu…';

  @override
  String get mailboxesUnpin => 'Losa';

  @override
  String get mailboxesLists => 'Póstlistar';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Vistaðu leit til að geyma hana hér.';

  @override
  String get mailboxesTags => 'Merki';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Þú getur líka ýtt á nafn sendanda í skilaboðum og kveikt á VIP.';

  @override
  String get mailboxesAddVip => 'Bæta við VIP…';

  @override
  String get mailboxesAddVipTitle => 'Bæta við VIP';

  @override
  String get mailboxesAddVipText => 'Póstur frá þessu netfangi fær stjörnu og birtist í VIP-pósthólfinu.';

  @override
  String get mailboxesAddVipPlaceholder => 'nafn@example.com';

  @override
  String get messageListFilterUnread => 'Ólesið';

  @override
  String get messageListFilterFlagged => 'Flaggað';

  @override
  String get messageListFilterToMe => 'Til mín';

  @override
  String get messageListFilterCcMe => 'Afrit til mín';

  @override
  String get messageListFilterWithAttachments => 'Með viðhengjum';

  @override
  String get messageListFilterUnreplied => 'Ósvarað';

  @override
  String get messageListFilterFromVips => 'Frá VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð merkt sem lesin',
      one: '$count skilaboð merkt sem lesin',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Ekki tókst að hlaða inn eldri pósti.';

  @override
  String get messageListSelectMessages => 'Velja skilaboð';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count valin', one: '$count valið');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Velja allt';

  @override
  String get messageListDeselectAll => 'Afvelja allt';

  @override
  String get messageListLoadFailed => 'Ekki tókst að hlaða inn pósti';

  @override
  String get messageListNoUnread => 'Enginn ólesinn póstur';

  @override
  String get messageListNoMatches => 'Enginn póstur passar';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Síað eftir: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Slökkva á síu';

  @override
  String get messageListEmpty => 'Enginn póstur';

  @override
  String get messageListFilter => 'Sía';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Síuskilyrði: $filters';
  }

  @override
  String get messageListFilteredBy => 'Síað eftir:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ólesin',
      one: '$count ólesið',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Merkja';

  @override
  String get messageListTrash => 'Henda';

  @override
  String get messageListFilterTitle => 'Sía';

  @override
  String get messageListFilterInclude => 'TAKA MEÐ';

  @override
  String get panesHideMailboxes => 'Fela pósthólf';

  @override
  String get panesShowMailboxes => 'Sýna pósthólf';

  @override
  String get panesMailboxesWidth => 'Breidd pósthólfa';

  @override
  String get panesListWidth => 'Breidd skilaboðalista';

  @override
  String get panesNoMessageSelected => 'Engin skilaboð valin';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count skilaboð', one: '$count skilaboð');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Blundað';

  @override
  String get snoozeSheetTitle => 'Blunda';

  @override
  String get snoozeLaterToday => 'Seinna í dag';

  @override
  String get snoozeThisEvening => 'Í kvöld';

  @override
  String get snoozeTomorrow => 'Á morgun';

  @override
  String get snoozeThisWeekend => 'Um helgina';

  @override
  String get snoozeNextWeek => 'Í næstu viku';

  @override
  String get snoozePickDateTime => 'Velja dagsetningu og tíma…';

  @override
  String get snoozeMenu => 'Blunda…';

  @override
  String get snoozeWakeNow => 'Vekja núna';

  @override
  String get snoozeChangeTimeMenu => 'Breyta blundtíma…';

  @override
  String get snoozeChangeTime => 'Breyta tíma';

  @override
  String get snoozeNoTime => 'Enginn tími stilltur';

  @override
  String get snoozeFooter => 'Skilaboð í blundi koma aftur í innhólfið, ólesin, á tilsettum tíma.';

  @override
  String get snoozeEmptyTitle => 'Ekkert í blundi';

  @override
  String get snoozeEmptyText =>
      'Settu skilaboð í blund til að fá þau aftur í innhólfið þegar þú þarft á þeim að halda.';

  @override
  String get appLockUnlock => 'Taka úr lás';

  @override
  String get appLockFailed => 'Loupe gat ekki staðfest að þetta sért þú.';

  @override
  String get appLockLockedOut => 'Of margar tilraunir. Reyndu aftur síðar.';

  @override
  String get appLockPromptError => 'Ekki tókst að birta auðkenningargluggann. Reyndu aftur.';

  @override
  String get appLockNoScreenLock => 'Enginn skjálás er á þessum síma.';

  @override
  String get appLockUnlockPromptTitle => 'Taka Loupe úr lás';

  @override
  String get appLockUnlockPromptReason => 'Staðfestu að þetta sért þú til að sjá póstinn þinn.';

  @override
  String get appLockTurnOnPromptTitle => 'Kveikja á forritalás';

  @override
  String get appLockTurnOnPromptReason => 'Staðfestu að þetta sért þú til að kveikja á forritalás.';

  @override
  String get appLockScreenLockRemoved =>
      'Slökkt er á forritalás: enginn skjálás er lengur á þessum síma. Settu upp skjálás til að kveikja aftur á forritalás.';

  @override
  String get appLockAfterImmediately => 'Strax';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mínútur', one: '$count mínúta');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count klukkustundir',
      one: '$count klukkustund',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Dulkóðað';

  @override
  String get openpgpEncryptedInPart => 'Dulkóðað að hluta';

  @override
  String get openpgpEncryptedLocked => 'Dulkóðað · læst';

  @override
  String get openpgpEncryptedNoKey => 'Dulkóðað · enginn lykill';

  @override
  String get openpgpEncryptedDamaged => 'Dulkóðað · skemmt';

  @override
  String get openpgpEncryptedUnsupported => 'Dulkóðað · ekki stutt';

  @override
  String get openpgpUnknownSigner => 'óþekktum aðila';

  @override
  String get openpgpUnknownKey => 'Óþekktur lykill';

  @override
  String get openpgpSignatureInvalid => 'Ógild undirritun';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Undirritað af $name, ekki sendandanum';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Undirritað að hluta af $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Undirritað af $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Undirritað með höfnuðum lykli';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Undirritað af $name · lykill ekki samþykktur';
  }

  @override
  String get openpgpUnlock => 'Taka úr lás';

  @override
  String get openpgpCantDecrypt => 'Ekki hægt að afkóða þessi skilaboð';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Dulkóðað með OpenPGP';

  @override
  String get openpgpEncryption => 'Dulkóðun';

  @override
  String get openpgpDecryptedHere => 'Afkóðað í þessu tæki';

  @override
  String get openpgpNotDecrypted => 'Ekki afkóðað';

  @override
  String get openpgpKeyLocked => 'Lykillinn þinn er læstur.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fyrir $count lykla: $keys',
      one: 'Fyrir $count lykil: $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Varin efnislína';

  @override
  String get openpgpUnlockKey => 'Taka lykil úr lás';

  @override
  String get openpgpSignature => 'Undirritun';

  @override
  String get openpgpFingerprint => 'Fingrafar';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Lykilauðkenni $id';
  }

  @override
  String get openpgpSigned => 'Undirritað';

  @override
  String get openpgpProblem => 'Vandamál';

  @override
  String get openpgpAcceptance => 'Samþykki';

  @override
  String get openpgpChangeAcceptance => 'Breyta samþykki…';

  @override
  String get openpgpCheckedFooter => 'Athugað í þessu tæki með OpenPGP, samhæft Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Lykillinn þinn er læstur. Taktu hann úr lás með lykilfrasanum til að lesa þessi skilaboð.';

  @override
  String get openpgpSummaryNoSecretKey => 'Þau voru dulkóðuð fyrir lykil sem er ekki í þessu tæki.';

  @override
  String get openpgpSummaryDamaged => 'Dulkóðuðu gögnin eru skemmd eða þeim var breytt á leiðinni.';

  @override
  String get openpgpSummaryUnsupported => 'Þau nota reiknirit sem Loupe styður ekki.';

  @override
  String get openpgpSummaryEncrypted => 'Aðeins þú og hinir viðtakendurnir geta lesið þau.';

  @override
  String get openpgpSummaryNotSigned => 'Þau eru ekki undirrituð, svo sendandinn er ekki staðfestur.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Þau eru undirrituð, en með lykli sem þú ert ekki með, svo ekki er hægt að athuga undirritunina.';

  @override
  String get openpgpSummaryBadSignature => 'Undirritunin passar ekki: skilaboðunum gæti hafa verið breytt.';

  @override
  String get openpgpSummaryMismatch => 'Undirritunin er gild, en lykillinn tilheyrir öðru netfangi en sendandans.';

  @override
  String get openpgpSummaryPartial =>
      'Aðeins hluti skilaboðanna er undirritaður. Texti utan undirritunarinnar (til dæmis síðufótur póstlista) er sýndur fyrir neðan línuna „Unsigned content“, og aðrir hlutar skilaboðanna, svo sem viðhengi, falla ekki heldur undir hana.';

  @override
  String get openpgpSummaryOwnKey => 'Undirritað með þínum eigin lykli.';

  @override
  String get openpgpSummaryVerified => 'Undirritunin er gild og þú hefur staðfest fingrafar lykilsins.';

  @override
  String get openpgpSummaryUnverified =>
      'Undirritunin er gild. Þú samþykktir lykilinn án þess að athuga fingrafar hans.';

  @override
  String get openpgpSummaryRejected => 'Undirritunin er gild, en þú hafnaðir þessum lykli.';

  @override
  String get openpgpSummaryUndecided =>
      'Undirritunin er gild, en þú hefur ekki samþykkt þennan lykil enn. Berðu fingrafar hans saman við það sem sendandinn gefur upp.';

  @override
  String get openpgpAcceptanceRejected => 'Hafnað';

  @override
  String get openpgpAcceptanceUndecided => 'Ekki samþykktur';

  @override
  String get openpgpAcceptanceUnverified => 'Samþykktur';

  @override
  String get openpgpAcceptanceVerified => 'Samþykktur og staðfestur';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Samþykkja lykil $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingrafar $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Já, ég staðfesti fingrafarið';

  @override
  String get openpgpAcceptUnverified => 'Já, án þess að athuga';

  @override
  String get openpgpAcceptLater => 'Ekki enn';

  @override
  String get openpgpRejectKey => 'Hafna þessum lykli';

  @override
  String get openpgpNoSubject => '(ekkert efni)';

  @override
  String get openpgpEncryptionTitle => 'Dulkóðun enda á milli';

  @override
  String get openpgpMyKeys => 'Mínir OpenPGP-lyklar';

  @override
  String get openpgpMyKeysFooter =>
      'Með lykli geturðu lesið dulkóðaðan póst og undirritað og dulkóðað þinn eigin. Notarðu Thunderbird? Flyttu lykilinn þinn út þar (Stillingar reiknings › Enda-í-enda dulritun › Öryggisafrita leynilykil í skrá) og fluttu hann inn hér.';

  @override
  String get openpgpAddKey => 'Bæta við lykli…';

  @override
  String get openpgpAddresses => 'Netföng';

  @override
  String get openpgpAddressesFooter => 'Hvaða lykil hvert netfang notar, og hvenær það dulkóðar og undirritar.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP-lyklar bréfritara';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Samþykktu lykil þegar þú treystir því að hann tilheyri eiganda sínum; berðu fingrafarið saman við eigandann til að merkja hann sem staðfestan.';

  @override
  String get openpgpImportPublicKey => 'Flytja inn dreifilykil…';

  @override
  String get openpgpCollected => 'Safnað með Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Lyklar sem bárust með skilaboðum. Loupe getur dulkóðað fyrir þá þegar báðir aðilar óska þess.';

  @override
  String get openpgpOnThisDevice => 'Í þessu tæki';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Dulkóðuð skilaboð fela efnislínuna sína. Loupe geymir efnislínu hverra skilaboða sem þú opnar í dulkóðuðum gagnagrunni sínum í þessu tæki, svo hún birtist í listanum, leitinni og tilkynningum. Í bakgrunni getur Loupe líka afkóðað efnislínur nýrra skilaboða með lyklum sem hafa engan lykilfrasa; til þess sækir það hver skilaboð (allt að 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Afkóða efnislínur í bakgrunni';

  @override
  String get openpgpIndexFooter =>
      'Leitin finnur dulkóðuð skilaboð eftir sendanda, viðtakendum og efnislínu. Þegar kveikt er á þessu bætir Loupe líka texta hverra dulkóðaðra skilaboða sem það afkóðar við leitarskrána í dulkóðuðum gagnagrunni sínum í þessu tæki, svo leitin finnur þau líka eftir texta. Ef slökkt er á þessu er sá texti fjarlægður úr leitarskránni.';

  @override
  String get openpgpIndexDecrypted => 'Setja afkóðuð skilaboð í leitarskrá';

  @override
  String get openpgpPassphrases => 'Lykilfrasar';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-lyklar og S/MIME-skilríki sem þú verndar með lykilfrasa eru tekin úr lás þegar þörf er á. Án „Muna lykilfrasa“ eru þau læst aftur tveimur mínútum eftir hverja notkun.';

  @override
  String get openpgpRememberPassphrases => 'Muna lykilfrasa';

  @override
  String get openpgpRememberPassphrasesDetail => 'Þar til Loupe lokast';

  @override
  String get openpgpLockKeysNow => 'Læsa lyklum núna';

  @override
  String get openpgpKeysLocked => 'Lyklum læst.';

  @override
  String get openpgpKeyStateRevoked => 'afturkallaður';

  @override
  String get openpgpKeyStateExpired => 'útrunninn';

  @override
  String get openpgpKeyStateNeverExpires => 'rennur aldrei út';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'rennur út $date';
  }

  @override
  String get openpgpNoKey => 'Enginn lykill';

  @override
  String get openpgpAlwaysEncrypt => 'Dulkóða alltaf';

  @override
  String get openpgpAddKeyTitle => 'Bæta við OpenPGP-lykli';

  @override
  String get openpgpAddKeyMessage => 'Fluttu inn lykilinn sem þú notar í Thunderbird, eða búðu til nýjan.';

  @override
  String get openpgpImportFromClipboard => 'Flytja inn af klippiborði';

  @override
  String get openpgpImportFromFile => 'Flytja inn úr skrá';

  @override
  String get openpgpGenerateNewKey => 'Búa til nýjan lykil';

  @override
  String get openpgpImportPublicKeyTitle => 'Flytja inn dreifilykil';

  @override
  String get openpgpFromClipboard => 'Af klippiborði';

  @override
  String get openpgpFromFile => 'Úr skrá';

  @override
  String get openpgpClipboardEmpty => 'Klippiborðið er tómt. Afritaðu lykilinn fyrst.';

  @override
  String get openpgpKey => 'Lykill';

  @override
  String get openpgpValidityRevoked => 'Afturkallaður';

  @override
  String openpgpValidityExpired(String date) {
    return 'Rann út $date';
  }

  @override
  String get openpgpNeverExpires => 'Rennur aldrei út';

  @override
  String openpgpValidUntil(String date) {
    return 'Gildir til $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingrafar afritað.';

  @override
  String get openpgpAlgorithm => 'Reiknirit';

  @override
  String get openpgpCreated => 'Búinn til';

  @override
  String get openpgpValidity => 'Gildistími';

  @override
  String get openpgpProtection => 'Vernd';

  @override
  String get openpgpProtectionPassphrase => 'Lykilfrasi';

  @override
  String get openpgpProtectionKeychain => 'Aðeins lyklageymsla';

  @override
  String get openpgpKeyDetailsFooter =>
      'Deildu dreifilyklinum þínum svo aðrir geti dulkóðað fyrir þig. Öryggisafritið er leynilykillinn þinn, varinn með lykilfrasa hans ef hann er með slíkan: haltu því út af fyrir þig.';

  @override
  String get openpgpSharePublicKey => 'Deila dreifilykli';

  @override
  String get openpgpCopyPublicKey => 'Afrita dreifilykil';

  @override
  String get openpgpPublicKeyCopied => 'Dreifilykill afritaður.';

  @override
  String get openpgpBackUpSecretKey => 'Öryggisafrita leynilykil';

  @override
  String get openpgpDeleteKey => 'Eyða lykli';

  @override
  String get openpgpRemoveKey => 'Fjarlægja lykil';

  @override
  String get openpgpBackUpTitle => 'Öryggisafrita leynilykil?';

  @override
  String get openpgpBackUpProtected =>
      'Öryggisafritið er varið með lykilfrasa lykilsins. Hver sem hefur hvort tveggja getur lesið póstinn þinn.';

  @override
  String get openpgpBackUpUnprotected =>
      'Þessi lykill hefur engan lykilfrasa: hver sem hefur öryggisafritið getur lesið póstinn þinn og undirritað í þínu nafni.';

  @override
  String get openpgpBackUp => 'Öryggisafrita';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Eyða lyklinum þínum $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Fjarlægja lykil $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Ekki verður lengur hægt að lesa póst sem er dulkóðaður fyrir þennan lykil í þessu tæki, nema þú flytjir hann inn aftur.';

  @override
  String get openpgpRemoveKeyMessage => 'Þú getur flutt hann inn aftur síðar.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-lykill';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Bættu við lykli í „Dulkóðun enda á milli“ til að dulkóða og undirrita póst frá þessu netfangi.';

  @override
  String get openpgpGenerateAKey => 'Búa til lykil…';

  @override
  String get openpgpSending => 'Sending';

  @override
  String get openpgpSendingFooter =>
      'Sjálfvirk dulkóðun kviknar þegar allir viðtakendur hafa samþykktan lykil eða traust skilríki, eða þegar Autocrypt segir að báðir aðilar vilji hana. Dulkóðaður póstur er alltaf undirritaður.';

  @override
  String get openpgpEncryptAutomatically => 'Dulkóða sjálfkrafa';

  @override
  String get openpgpAlwaysEncryptDetail => 'Neitar að senda þegar viðtakandi hefur engan lykil';

  @override
  String get openpgpSignUnencrypted => 'Undirrita ódulkóðaðan póst';

  @override
  String get openpgpAttachPublicKey => 'Hengja dreifilykilinn minn við';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt sendir dreifilykilinn þinn með hverjum skilaboðum, svo önnur forrit geti dulkóðað fyrir þig án nokkurrar uppsetningar.';

  @override
  String get openpgpSendMyKey => 'Senda lykilinn minn með pósti';

  @override
  String get openpgpPreferEncryption => 'Kjósa dulkóðun';

  @override
  String get openpgpPreferEncryptionDetail => 'Biðja aðra um að dulkóða þegar þeir geta';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ár', one: '$count ár');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Lykilfrasarnir passa ekki saman.';

  @override
  String openpgpKeyReady(String id) {
    return 'Lykillinn þinn $id er tilbúinn.';
  }

  @override
  String get openpgpNewKey => 'Nýr lykill';

  @override
  String get openpgpNewKeyFor => 'Fyrir';

  @override
  String get openpgpYourName => 'Nafnið þitt';

  @override
  String get openpgpAddress => 'Netfang';

  @override
  String get openpgpPassphrase => 'Lykilfrasi';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Valfrjálst. Án hans verndar lyklageymsla símans lykilinn ein og Loupe spyr aldrei. Með honum spyr Loupe um hann þegar þörf er á lyklinum.';

  @override
  String get openpgpRepeatPassphrase => 'Endurtaka';

  @override
  String get openpgpExpires => 'Rennur út';

  @override
  String get openpgpExpiresFooter =>
      'Þú getur búið til nýjan lykil áður en hann rennur út. Thunderbird notar líka þrjú ár.';

  @override
  String get openpgpGenerateKey => 'Búa til lykil';

  @override
  String get openpgpKeyFor => 'Lykill fyrir';

  @override
  String get openpgpCantEncrypt => 'Ekki hægt að dulkóða';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Enginn OpenPGP-lykill er til fyrir $names, og þetta netfang dulkóðar alltaf. Fjarlægðu viðtakandann, eða fluttu inn lykil viðkomandi í Stillingar › Dulkóðun enda á milli.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Engin gild S/MIME-skilríki eru til fyrir $names, og þetta netfang dulkóðar alltaf. Fjarlægðu viðtakandann, eða fluttu inn skilríki viðkomandi í Stillingar › Dulkóðun enda á milli.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Enginn OpenPGP-lykill er til fyrir $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Engin gild S/MIME-skilríki eru til fyrir $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Senda ódulkóðað';

  @override
  String get openpgpCantSign => 'Ekki hægt að undirrita';

  @override
  String get openpgpCantSignMessage =>
      'Einkalykill S/MIME-skilríkjanna þinna er ekki í þessu tæki. Fluttu skilríkin inn aftur (.p12- eða .pfx-skrá) í Stillingar › Dulkóðun enda á milli.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Enginn lykill fyrir $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Engin skilríki fyrir $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Lyklar frá Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Allir eru með lykil';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Allir eru með skilríki';

  @override
  String get openpgpComposeEncrypt => 'Dulkóða';

  @override
  String get openpgpComposeSign => 'Undirrita';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, skipta';
  }

  @override
  String get openpgpNoKeyFound => 'Enginn OpenPGP-lykill fannst.';

  @override
  String get openpgpImportSecretKeyTitle => 'Flytja inn leynilykil?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Þetta viðhengi inniheldur leynilykil ($names). Fluttu hann aðeins inn sem þinn eigin lykil ef það varst þú sem fluttir hann út, til dæmis úr Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Flytja inn sem minn lykil';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'lykillinn þinn $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Flytja inn $count lykla ($names)?',
      one: 'Flytja inn $count lykil ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Flytja inn og samþykkja';

  @override
  String get openpgpImportDecideLater => 'Flytja inn, ákveða síðar';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'lykill $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Flutt inn: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-lyklar fylgja.',
      one: '$count OpenPGP-lykill fylgir.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Flytja inn';

  @override
  String get openpgpUnlockKeyTitle => 'Taka OpenPGP-lykil úr lás';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Sláðu inn lykilfrasa lykils $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Rangur lykilfrasi. Reyndu aftur.';

  @override
  String get openpgpExplainLocked => 'Þessi skilaboð eru dulkóðuð. Taktu OpenPGP-lykilinn þinn úr lás til að lesa þau.';

  @override
  String get openpgpExplainNoKey =>
      'Þessi skilaboð eru dulkóðuð, en ekki fyrir neinn OpenPGP-lykil í þessu tæki. Ef þú lest þau í Thunderbird skaltu flytja lykilinn þinn inn þaðan: Stillingar › Dulkóðun enda á milli.';

  @override
  String get openpgpExplainDamaged =>
      'Þessi dulkóðuðu skilaboð eru skemmd, svo ekki er hægt að afkóða þau á öruggan hátt.';

  @override
  String get openpgpExplainUnsupported => 'Þessi skilaboð nota dulkóðun sem Loupe getur ekki lesið enn.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Þessi skilaboð eru dulkóðuð með S/MIME, en ekki fyrir nein skilríki í þessu tæki. Fluttu inn skilríkin þín (.p12- eða .pfx-skrá) í Stillingar › Dulkóðun enda á milli.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Þessi skilaboð eru dulkóðuð. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Taktu S/MIME-skilríkin þín úr lás til að lesa þau.';

  @override
  String get openpgpAttachmentGone => 'Þetta viðhengi er ekki lengur tiltækt.';

  @override
  String get smimeEncrypted => 'Dulkóðað (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Dulkóðað (S/MIME) · engin skilríki';

  @override
  String get smimeEncryptedDamaged => 'Dulkóðað (S/MIME) · skemmt';

  @override
  String get smimeEncryptedUnsupported => 'Dulkóðað (S/MIME) · ekki stutt';

  @override
  String get smimeEncryptedLocked => 'Dulkóðað (S/MIME) · læst';

  @override
  String get smimeUnknownSigner => 'óþekktum aðila';

  @override
  String get smimeSignatureModified => 'Ógild undirritun: skilaboðunum var breytt';

  @override
  String get smimeSignatureWeak => 'Óörugg undirritun: úrelt reiknirit';

  @override
  String get smimeSignatureUncheckable => 'Ekki hægt að athuga undirritun';

  @override
  String get smimeSignedCertificateMissing => 'Undirritað · skilríki vantar';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Undirritað af $name · skilríki afturkölluð';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Undirritað af $name · á öðrum degi';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Undirritað af $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Undirritað af $name · ógild skilríki';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Undirritað af $name · ekki treyst';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Undirritað af $name · skilríki útrunnin';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Undirritað af $name · skilríki ekki enn gild';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Undirritað af $name · skilríki ekki ætluð fyrir póst';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Undirritað af $name, ekki sendandanum';
  }

  @override
  String get smimeCantDecrypt => 'Ekki hægt að afkóða þessi skilaboð';

  @override
  String get smimeEncryptedWithSmime => 'Dulkóðað með S/MIME';

  @override
  String get smimeEncryption => 'Dulkóðun';

  @override
  String get smimeDecryptedHere => 'Afkóðað í þessu tæki';

  @override
  String get smimeNotDecrypted => 'Ekki afkóðað';

  @override
  String get smimeAuthenticated => 'sannvottað';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fyrir $count skilríki',
      one: 'fyrir $count skilríki',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Undirritun';

  @override
  String get smimeIssuedBy => 'Útgefandi';

  @override
  String get smimeValid => 'Gildistími';

  @override
  String smimeValidRange(String from, String to) {
    return '$from til $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-fingrafar';

  @override
  String get smimeSigned => 'Undirritað';

  @override
  String get smimeProblem => 'Vandamál';

  @override
  String get smimeCheckingRevocation => 'Athuga afturköllun…';

  @override
  String get smimeNotRevoked => 'Ekki afturkölluð';

  @override
  String get smimeRevoked => 'Afturkölluð';

  @override
  String get smimeRevocationUnknown => 'Afturköllun óþekkt';

  @override
  String smimeRevokedSince(String date) {
    return 'Frá $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Spurði vottunarstöðina (afturköllunarlista hennar), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Spurði vottunarstöðina (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Treysta „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Treysta þessum skilríkjum…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Athugað í þessu tæki með S/MIME, samhæft Outlook og Thunderbird; afturköllun athuguð hjá vottunarstöðinni.';

  @override
  String get smimeCheckedFooter =>
      'Athugað í þessu tæki með S/MIME, samhæft Outlook og Thunderbird. Afturköllun er ekki athuguð (Stillingar › Dulkóðun enda á milli).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Treysta $name fyrir póst?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Treysta skilríkjum $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Öllum skilríkjum sem þessi vottunarstöð gefur út verður treyst, eins og vottunarstöð fyrirtækisins þíns. Berðu fyrst fingrafarið saman við eigandann:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Berðu fyrst fingrafarið saman við eigandann:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Treysta';

  @override
  String get smimeSummaryNoKey => 'Þau voru dulkóðuð fyrir skilríki sem eru ekki í þessu tæki.';

  @override
  String get smimeSummaryDamaged => 'Dulkóðuðu gögnin eru skemmd eða þeim var breytt á leiðinni.';

  @override
  String get smimeSummaryUnsupported => 'Þau nota reiknirit sem Loupe styður ekki.';

  @override
  String get smimeSummaryLocked => 'S/MIME-skilríkin þín eru læst.';

  @override
  String get smimeSummaryEncrypted => 'Aðeins þú og hinir viðtakendurnir geta lesið þau.';

  @override
  String get smimeSummaryNotSigned => 'Þau eru ekki undirrituð, svo sendandinn er ekki staðfestur.';

  @override
  String get smimeSummaryModified => 'Undirritunin passar ekki: skilaboðunum var breytt eftir að þau voru undirrituð.';

  @override
  String get smimeSummaryUncheckable => 'Ekki er hægt að athuga undirritunina.';

  @override
  String get smimeSummaryNoCertificate =>
      'Skilríki undirritandans eru ekki í skilaboðunum, svo ekki er hægt að athuga undirritunina.';

  @override
  String get smimeSummaryRevoked =>
      'Vottunarstöðin afturkallaði skilríki undirritandans: ekki er hægt að treysta undirrituninni.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Vottunarstöðin afturkallaði skilríki undirritandans ($reason): ekki er hægt að treysta undirrituninni.';
  }

  @override
  String get smimeDateMismatch =>
      'Þau voru undirrituð meira en klukkustund frá dagsetningu skilaboðanna: þetta gætu verið gömul skilaboð send aftur.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Undirritunin er gild og $issuer ábyrgist að skilríkin tilheyri sendandanum.';
  }

  @override
  String get smimeProblemInvalidChain => 'Skilríkin, eða einhver útgefandi þeirra, eru ógild.';

  @override
  String get smimeProblemUntrusted => 'Skilríkin koma frá vottunarstöð sem Loupe treystir ekki.';

  @override
  String get smimeProblemExpired => 'Skilríkin voru útrunnin.';

  @override
  String get smimeProblemNotYetValid => 'Skilríkin voru ekki enn gild.';

  @override
  String get smimeProblemWrongUsage => 'Skilríkin eru ekki ætluð fyrir póst.';

  @override
  String get smimeProblemWrongAddress => 'Skilríkin tilheyra öðru netfangi en sendandans.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Treyst · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Ekki treyst · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Runnu út $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Gild frá $date';
  }

  @override
  String get smimeTrustInvalid => 'Ógild';

  @override
  String get smimeTrustNotForMail => 'Ekki fyrir póst';

  @override
  String get smimeTrustAnotherAddress => 'Annað netfang';

  @override
  String get smimeMyCertificates => 'Mín S/MIME-skilríki';

  @override
  String get smimeMyCertificatesFooter =>
      'Fyrir S/MIME, eins og Outlook og mörg fyrirtæki nota það. Fluttu inn skilríkin þín ásamt einkalyklinum (.p12- eða .pfx-skrá), flutt út úr Outlook, Windows, macOS eða Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Fyrir S/MIME, eins og Outlook og mörg fyrirtæki nota það. Fluttu inn skilríkin þín ásamt einkalyklinum (.p12- eða .pfx-skrá), flutt út úr Outlook, Windows, macOS eða Thunderbird, eða notaðu skilríki sem þú eða fyrirtækið þitt settuð upp í þessu tæki.';

  @override
  String get smimeCertificateExpired => 'útrunnin';

  @override
  String smimeCertificateUntil(String date) {
    return 'til $date';
  }

  @override
  String get smimeCertificateOnDevice => 'í þessu tæki';

  @override
  String get smimeImportCertificateEllipsis => 'Flytja inn skilríki…';

  @override
  String get smimeUseDeviceCertificate => 'Nota skilríki úr þessu tæki…';

  @override
  String get smimeCorrespondentsCertificates => 'Skilríki bréfritara';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Safnað úr undirrituðum pósti, eins og Outlook og Thunderbird gera. Póstur er aðeins dulkóðaður fyrir traust skilríki: Loupe treystir vottunarstöðvunum sem Mozilla treystir fyrir tölvupóst, og þeim sem þú bætir við.';

  @override
  String get smimeRevocation => 'Afturköllun';

  @override
  String get smimeRevocationFooter =>
      'Þegar þú opnar undirritaðan póst spyr Loupe vottunarstöðina sem gaf út skilríki undirritandans hvort þau hafi verið afturkölluð (OCSP-svarþjón hennar eða afturköllunarlista). Vottunarstöðin getur þá séð hvenær einhver á IP-tölunni þinni les póst sem er undirritaður með þessum skilríkjum. Svör eru geymd í þessu tæki þar til þau renna út. Afturkölluð skilríki eru merkt „afturkölluð“ í haus skilaboðanna.';

  @override
  String get smimeCheckRevocation => 'Athuga afturköllun skilríkja á netinu';

  @override
  String get smimeTrustedAuthorities => 'Traustar vottunarstöðvar';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Treyst af þér, auk þeirra $count sem Mozilla treystir fyrir tölvupóst.',
      one: 'Treyst af þér, auk þeirra $count sem Mozilla treystir fyrir tölvupóst.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Vottunarstöð';

  @override
  String get smimeImportACertificate => 'Flytja inn skilríki';

  @override
  String get smimeImportContactMessage => 'Skilríki bréfritara (.cer, .crt, .pem) eða vottunarstöðvar.';

  @override
  String get smimeFromClipboard => 'Af klippiborði';

  @override
  String get smimeFromFile => 'Úr skrá';

  @override
  String get smimeClipboardEmpty => 'Klippiborðið er tómt. Afritaðu skilríkin fyrst.';

  @override
  String get smimeCertificate => 'Skilríki';

  @override
  String get smimeOnDeviceFooter =>
      'Einkalykill þeirra er áfram í skilríkjageymslu Android, þar sem þú eða fyrirtækið þitt settuð þau upp: Loupe biður Android um að undirrita og afkóða með honum. Undirritaður póstur er undirritaður þegar þú sendir hann.';

  @override
  String get smimeAddresses => 'Netföng';

  @override
  String get smimeUsage => 'Fyrir';

  @override
  String get smimeUsageNone => 'Ekkert sem Loupe notar';

  @override
  String get smimeUsageSigning => 'Undirritun';

  @override
  String get smimeUsageEncryption => 'Dulkóðun';

  @override
  String get smimeUsageCertificates => 'Skilríki';

  @override
  String get smimeAlgorithm => 'Reiknirit';

  @override
  String get smimeSerialNumber => 'Raðnúmer';

  @override
  String get smimeFingerprintCopied => 'Fingrafar afritað.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-þumalfar';

  @override
  String get smimePrivateKey => 'Einkalykill';

  @override
  String get smimeKeyOnDevice => 'Í þessu tæki';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Í Loupe, með lykilfrasa';

  @override
  String get smimeKeyInLoupe => 'Í Loupe';

  @override
  String get smimeSource => 'Uppruni';

  @override
  String get smimeSourceSignedMail => 'Undirritaður póstur';

  @override
  String get smimeSourceImported => 'Innflutt';

  @override
  String get smimeTrustHeader => 'Traust';

  @override
  String get smimeTrustedRoot => 'Traust rót';

  @override
  String get smimeIssuer => 'Útgefandi';

  @override
  String smimeTrustNamed(String name) {
    return 'Treysta „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Treysta þessari vottunarstöð';

  @override
  String get smimeTrustThisCertificate => 'Treysta þessum skilríkjum';

  @override
  String get smimeStopTrusting => 'Hætta að treysta';

  @override
  String get smimePassphrase => 'Lykilfrasi';

  @override
  String get smimePassphraseFooter =>
      'Valfrjálst. Með lykilfrasa er einkalykillinn líka dulkóðaður í þessu tæki (Argon2id og AES-256) og Loupe biður um hann til að undirrita og afkóða; „Muna lykilfrasa“ segir til um hve lengi. Póstur sem þú sendir er undirritaður um leið og þú sendir hann; vinnsla í bakgrunni getur ekki notað lykilinn.';

  @override
  String get smimeChangePassphrase => 'Breyta lykilfrasa…';

  @override
  String get smimeSetPassphraseEllipsis => 'Stilla lykilfrasa…';

  @override
  String get smimeRemovePassphrase => 'Fjarlægja lykilfrasa';

  @override
  String get smimeShareCertificate => 'Deila skilríkjum';

  @override
  String get smimeDeleteCertificate => 'Eyða skilríkjum';

  @override
  String get smimeRemoveCertificate => 'Fjarlægja skilríki';

  @override
  String get smimePassphraseChanged => 'Lykilfrasa breytt.';

  @override
  String get smimePassphraseSet => 'Lykilfrasi stilltur.';

  @override
  String get smimeRemovePassphraseTitle => 'Fjarlægja lykilfrasann?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Einkalykillinn er þá aðeins varinn af lyklageymslunni, eins og án lykilfrasa: Loupe biður ekki lengur um hann og vinnsla í bakgrunni getur notað hann.';

  @override
  String get smimePassphraseRemoved => 'Lykilfrasi fjarlægður.';

  @override
  String smimeTrustTitle(String name) {
    return 'Treysta $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Öllum skilríkjum sem hún gefur út verður treyst fyrir póst. Berðu fyrst fingrafarið saman við eigandann:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Eyða skilríkjunum þínum $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Fjarlægja skilríki $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe hættir að nota þau: ekki verður lengur hægt að lesa póst sem er dulkóðaður fyrir þau í Loupe. Skilríkin verða áfram í þessu tæki (Stillingar › Öryggi › Dulkóðun og skilríki).';

  @override
  String get smimeDeleteOwnMessage =>
      'Einkalykli þeirra er eytt úr þessu tæki: ekki verður lengur hægt að lesa póst sem er dulkóðaður fyrir þau hér, nema þú flytjir þau inn aftur.';

  @override
  String get smimeRemoveContactMessage => 'Þau koma aftur með næstu undirrituðu skilaboðum viðkomandi.';

  @override
  String get smimeAddressImportFooter =>
      'Fluttu inn skilríki fyrir þetta netfang til að undirrita og dulkóða með S/MIME, eins og Outlook gerir.';

  @override
  String get smimeImportACertificateEllipsis => 'Flytja inn skilríki…';

  @override
  String get smimePreferFooter =>
      'Þegar hvort tveggja gæti varið skilaboð er það sem er valið notað, nema aðeins hitt hafi lykil eða skilríki fyrir alla viðtakendur.';

  @override
  String get smimePreferSmime => 'Kjósa S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Frekar en OpenPGP';

  @override
  String get smimeCertificatePassword => 'Lykilorð skilríkja';

  @override
  String get smimeCertificatePasswordPrompt => 'Sláðu inn lykilorðið sem skilríkjaskráin var flutt út með.';

  @override
  String get smimeImport => 'Flytja inn';

  @override
  String get smimeWrongPassword => 'Rangt lykilorð. Reyndu aftur.';

  @override
  String get smimeNoCertificateFound => 'Engin skilríki fundust.';

  @override
  String smimeCertificateOf(String name) {
    return 'skilríki $name';
  }

  @override
  String get smimeNothingNew => 'Ekkert nýtt til að flytja inn.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Flutt inn: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count traustar vottunarstöðvar fluttar inn.',
      one: '$count traust vottunarstöð flutt inn.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Flutt inn: $certificates og $count traustar vottunarstöðvar.',
      one: 'Flutt inn: $certificates og $count traust vottunarstöð.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Þessi skrá er ekki með einkalykil. Fluttu skilríkin þín út ásamt einkalyklinum.';

  @override
  String get smimeImportAsYoursTitle => 'Flytja inn sem þín skilríki?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Þetta viðhengi inniheldur skilríki ásamt einkalykli: $names. Fluttu þau aðeins inn ef það varst þú sem fluttir þau út, til dæmis úr Outlook eða Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Flytja inn sem mín skilríki';

  @override
  String smimeImportedOwn(String names) {
    return 'Skilríkin þín $names voru flutt inn.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Skilríkjunum þínum $name ($addresses) var bætt við úr þessu tæki.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Treysta „$name“ fyrir póst?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe þekkir ekki þessa vottunarstöð (kannski vottunarstöð fyrirtækis). Treystu henni til að athuga skilríkin sem hún gefur út. Berðu fingrafar hennar fyrst saman við það sem tölvudeildin þín gefur upp:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilríki fylgja.',
      one: '$count skilríki fylgja.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Flytja inn skilríki';

  @override
  String get smimeUnlockTitle => 'Taka S/MIME-skilríki úr lás';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Sláðu inn lykilfrasa skilríkja $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Rangur lykilfrasi. Reyndu aftur.';

  @override
  String get smimeUnlock => 'Taka úr lás';

  @override
  String get smimeEnterAPassphrase => 'Sláðu inn lykilfrasa.';

  @override
  String get smimePassphrasesDiffer => 'Lykilfrasarnir eru ekki eins.';

  @override
  String get smimeSetPassphraseTitle => 'Stilla lykilfrasa';

  @override
  String get smimeSetPassphraseText =>
      'Loupe biður um hann til að undirrita og afkóða. Ef þú gleymir honum skaltu flytja skilríkin inn aftur úr .p12-skránni.';

  @override
  String get smimePassphraseAgain => 'Aftur';

  @override
  String get smimeSetPassphraseButton => 'Stilla';

  @override
  String get smimeLockedOpenAgain => 'S/MIME-skilríkin þín eru læst. Opnaðu skilaboðin aftur til að taka þau úr lás.';

  @override
  String get smimeDeviceHasNoCertificates => 'Þetta tæki býður ekki upp á skilríkin sín.';

  @override
  String get smimeCantReadCertificate => 'Loupe getur ekki lesið þessi skilríki.';

  @override
  String get smimeCertificateNotForMail =>
      'Þessi skilríki eru ekki fyrir póst: þau hafa ekkert netfang eða eru ekki ætluð til undirritunar eða dulkóðunar.';

  @override
  String get smimeDeviceCertificateGone =>
      'Skilríkin eru ekki lengur í þessu tæki, eða Loupe má ekki lengur nota þau. Veldu þau aftur í Stillingar › Dulkóðun enda á milli.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Aðeins er hægt að nota skilríkin í þessu tæki á meðan Loupe er opið.';

  @override
  String get smimeDeviceKeyDamaged => 'Dulkóðaði lykillinn er skemmdur.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Skilríkin í þessu tæki geta ekki gert þetta: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'ekki stutt';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Villa kom upp í skilríkjunum í þessu tæki: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Slóð vottunarstöðvarinnar er ekki veffang.';

  @override
  String get smimeAuthorityTimeout => 'Vottunarstöðin svaraði ekki í tæka tíð.';

  @override
  String get smimeAuthorityUnreachable => 'Ekki náðist samband við vottunarstöðina.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Vottunarstöðin svaraði með $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Svar vottunarstöðvarinnar er of stórt.';

  @override
  String get smimeRevocationNotChecked =>
      'Ekki athugað: aðeins skilríki frá vottunarstöð sem Loupe treystir eru athuguð.';

  @override
  String get settingsLanguage => 'Tungumál';

  @override
  String get settingsLanguageSystem => 'Sama og í símanum';

  @override
  String get settingsLanguageFooter =>
      'Loupe notar tungumál símans ef það er í boði, annars ensku. Tungumálið sem þú velur hér gildir aðeins um Loupe, tilkynningar meðtaldar.';

  @override
  String get settingsAccountsHeader => 'Aðgangar';

  @override
  String get settingsAddAccount => 'Bæta við aðgangi';

  @override
  String get settingsMailHeader => 'Póstur';

  @override
  String get settingsSwipeActions => 'Strokuaðgerðir';

  @override
  String get settingsSwipeLeft => 'Strjúka til vinstri';

  @override
  String get settingsSwipeLeftFooter =>
      'Full stroka keyrir þessa aðgerð. Flagga og Meira eru alltaf aðeins einni stuttri stroku frá.';

  @override
  String get settingsSwipeRight => 'Strjúka til hægri';

  @override
  String get settingsSwipeRightFooter => 'Full stroka keyrir þessa aðgerð.';

  @override
  String get settingsSwipeToggleRead => 'Merkja sem lesið / ólesið';

  @override
  String get settingsSwipeTrash => 'Henda';

  @override
  String get settingsSwipeMove => 'Færa skilaboð';

  @override
  String get settingsSwipeSnooze => 'Blunda';

  @override
  String get settingsThreaded => 'Raða eftir samtölum';

  @override
  String get settingsUndoSendDelay => 'Tími til að afturkalla';

  @override
  String get settingsUndoSendDelayFooter => 'Send skilaboð bíða svona lengi, svo þú getir dregið þau til baka.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekúndur',
      one: '$seconds sekúnda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Útlit';

  @override
  String get settingsTheme => 'Þema';

  @override
  String get settingsThemeSystem => 'Sjálfvirkt';

  @override
  String get settingsThemeLight => 'Ljóst';

  @override
  String get settingsThemeDark => 'Dökkt';

  @override
  String get settingsDensity => 'Skilaboðalisti';

  @override
  String get settingsDensityComfortable => 'Rúmgóður';

  @override
  String get settingsDensityCompact => 'Þéttur';

  @override
  String get settingsReadingHeader => 'Lestur';

  @override
  String get settingsReadingFooter => 'Fjartengdar myndir geta sagt sendendum hvenær og hvar þú opnaðir skilaboð.';

  @override
  String get settingsDefaultView => 'Sjálfgefin sýn';

  @override
  String get settingsDefaultViewFooter => 'Þú getur skipt um sýn á hvaða skilaboðum sem er með Aa-hnappnum.';

  @override
  String get settingsViewReadable => 'Læsilegt';

  @override
  String get settingsViewReadableDetail => 'Hreint, læsilegt, fylgir dökkum ham';

  @override
  String get settingsViewOriginal => 'Upprunalegt';

  @override
  String get settingsViewOriginalDetail => 'Nákvæmlega eins og sendandinn hannaði það';

  @override
  String get settingsViewPlain => 'Einfaldur texti';

  @override
  String get settingsViewPlainDetail => 'Bara orðin';

  @override
  String get settingsPlainTextFont => 'Letur fyrir einfaldan texta';

  @override
  String get settingsFontSans => 'Steinskrift';

  @override
  String get settingsFontMono => 'Jafnbreitt letur';

  @override
  String get settingsFontMonoDetail => 'Heldur ASCII-myndum og töflum í réttum skorðum';

  @override
  String get settingsTechnicalLists => 'Tæknilegir póstlistar';

  @override
  String get settingsLoadRemoteImages => 'Hlaða inn fjartengdum myndum';

  @override
  String get settingsOpenLinksDirectly => 'Opna tengla beint';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Sleppa smellirekjurum þegar áfangastaðurinn er þekktur';

  @override
  String get settingsSecurityHeader => 'Öryggi';

  @override
  String get settingsAppLock => 'Forritalás';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe spyr þegar það ræsist, og þegar þú kemur aftur eftir að hafa verið í burtu lengur en tíminn í „Læsa eftir“.';

  @override
  String get settingsAppLockFooterOff =>
      'Forritalás biður um fingrafar, andlit eða skjálás áður en pósturinn þinn birtist.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Enn er slökkt á forritalás. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Setja upp aðgangskóða';

  @override
  String get settingsScreenLockTextIos =>
      'Forritalás notar Face ID, Touch ID eða aðgangskóðann þinn, og enginn aðgangskóði er á þessum iPhone. Settu hann upp í Stillingaforritinu og kveiktu svo á forritalás.';

  @override
  String get settingsScreenLockTitleAndroid => 'Setja upp skjálás';

  @override
  String get settingsScreenLockTextAndroid =>
      'Forritalás notar skjálás símans, eða fingrafar eða andlit sem bætt hefur verið við hann, og enginn skjálás er á þessum síma. Settu upp PIN-númer, mynstur eða aðgangsorð í stillingum Android og kveiktu svo á forritalás.';

  @override
  String get settingsOpenSystemSettings => 'Opna stillingar';

  @override
  String get settingsOpenAndroidSettings => 'Opna stillingar Android';

  @override
  String get settingsLockAfter => 'Læsa eftir';

  @override
  String get settingsLockAfterFooter => 'Hve lengi Loupe má vera í bakgrunni áður en það spyr aftur.';

  @override
  String get settingsNotifications => 'Tilkynningar';

  @override
  String get settingsEncryption => 'Dulkóðun enda á milli';

  @override
  String get settingsAdvanced => 'Ítarlegt';

  @override
  String get settingsDemoHeader => 'Sýnipósthólf';

  @override
  String get settingsDemoFooter =>
      'Sýnipóstur er tilbúið pósthólf sem er aðeins til í þessum síma. Ekkert er sent úr símanum.';

  @override
  String get settingsDemoMode => 'Sýnihamur';

  @override
  String get settingsResetApp => 'Endurstilla forritið';

  @override
  String get settingsResetFooter => 'Gleymir öllum stillingum og fer aftur á upphafsskjáinn.';

  @override
  String get settingsResetTitle => 'Endurstilla Loupe?';

  @override
  String get settingsResetMessage =>
      'Þetta gleymir öllum stillingum, Smart Mailboxes og nýlegum leitum, og fer aftur á upphafsskjáinn.';

  @override
  String get settingsAboutHeader => 'Um forritið';

  @override
  String get settingsVersion => 'Útgáfa';

  @override
  String get settingsLicences => 'Leyfi';

  @override
  String get settingsPrivacy => 'Persónuvernd';

  @override
  String get settingsPrivacyDetail =>
      'Loupe er hvorki með greiningu né rakningu. Pósturinn þinn fer aðeins á póstþjónana þína.';

  @override
  String get settingsNotificationsOffIos => 'Slökkt er á tilkynningum fyrir Loupe í Stillingum.';

  @override
  String get settingsNotificationsOffAndroid => 'Slökkt er á tilkynningum fyrir Loupe í stillingum Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system leyfir Loupe ekki að birta tilkynningar. Leyfðu þær í stillingunum.';
  }

  @override
  String get settingsNewMailHeader => 'Nýr póstur';

  @override
  String get settingsNewMailFooterDemo =>
      'Sýnipóstur berst ekki í bakgrunni. Sendu prufutilkynningu til að sjá hvernig nýr póstur lítur út.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe athugar með nýjan póst í bakgrunni þegar iOS leyfir það, en það geta liðið klukkustundir á milli hjá forritum sem þú opnar sjaldan. Þú færð tilkynningu um ný skilaboð í innhólfunum þínum, og frá VIP-tengiliðum í hvaða möppu sem er.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe athugar með nýjan póst á um það bil 15 mínútna fresti, þegar Android leyfir. Þú færð tilkynningu um ný skilaboð í innhólfunum þínum, og frá VIP-tengiliðum í hvaða möppu sem er.';

  @override
  String get settingsNoAccounts => 'Engir aðgangar';

  @override
  String get settingsVipOnly => 'Aðeins VIP';

  @override
  String get settingsVipOnlyDetail => 'Aðeins skilaboð frá VIP-tengiliðunum þínum';

  @override
  String get settingsHideContent => 'Fela efni';

  @override
  String get settingsHideContentFooterOn =>
      'Tilkynningar segja aðeins „Ný skilaboð frá“ og aðganginn, ekki hver skrifaði eða um hvað.';

  @override
  String get settingsHideContentFooterOff =>
      '„Fela efni“ heldur sendanda, efni og forskoðun frá lásskjánum og utan tilkynninga.';

  @override
  String get settingsBackgroundAppRefresh => 'Endurnýjun forrita í bakgrunni';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nýr póstur berst aðeins í bakgrunni á meðan kveikt er á „Endurnýjun forrita í bakgrunni“ fyrir Loupe í Stillingum. iOS getur ekki haldið tengingu við innhólfin þín opinni, svo þar er engin tafarlaus afhending.';

  @override
  String get settingsInstantDelivery => 'Tafarlaus afhending';

  @override
  String get settingsInstantDeliveryFooter =>
      'Tafarlaus afhending (á tilraunastigi) heldur tengingu við innhólfin þín opinni, svo nýr póstur berst innan nokkurra sekúndna. Hún birtir hljóðláta tilkynningu, „Fylgist með nýjum pósti“, og notar meiri rafhlöðu.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android gæti stöðvað tafarlausa afhendingu til að spara rafhlöðu. Leyfðu Loupe að nota rafhlöðuna án takmarkana til að halda henni gangandi.';

  @override
  String get settingsExperimental => 'Á tilraunastigi';

  @override
  String get settingsComingSoon => 'Væntanlegt';

  @override
  String get settingsAllowUnrestrictedBattery => 'Leyfa ótakmarkaða rafhlöðunotkun';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push gerir nýjum pósti kleift að vekja Loupe samstundis, þar sem póstþjónustan þín styður það. Push-skeyti fara í gegnum push-þjónustu Google og innihalda engan póst, aðeins „athugaðu núna“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Þessi sími getur ekki tekið við push-skeytum: þau þurfa Google Play-þjónustur og nettengingu. Loupe athugar samt með nýjan póst á um það bil 15 mínútna fresti.';

  @override
  String get settingsCopyPushToken => 'Afrita push-tóka';

  @override
  String get settingsPushTokenCopied => 'Push-tóki afritaður';

  @override
  String get settingsSendTestNotification => 'Senda prufutilkynningu';

  @override
  String get settingsAppIconBadge => 'Merki á forritstákni';

  @override
  String get settingsBadgeNote => 'Merkið uppfærist í hvert sinn sem Loupe athugar með póst, líka í bakgrunni.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Heimaskjár þessa síma sýnir ekki tölur á forritstáknum. Merkið uppfærist í hvert sinn sem Loupe athugar með póst, líka í bakgrunni.';

  @override
  String get settingsTestNotificationBody => 'Tilkynningar um nýjan póst líta svona út.';

  @override
  String get settingsAccountRemoved => 'Þessi aðgangur var fjarlægður.';

  @override
  String get settingsAccountHeader => 'Aðgangur';

  @override
  String get settingsAccountDescription => 'Lýsing';

  @override
  String get settingsAccountDescriptionHint => 'Vinna, einka…';

  @override
  String get settingsEmail => 'Netfang';

  @override
  String get settingsColour => 'Litur';

  @override
  String get settingsColourFooter => 'Merkir skilaboð þessa aðgangs í Öllum innhólfum.';

  @override
  String settingsColourNumber(int number) {
    return 'Litur $number';
  }

  @override
  String get settingsSendingHeader => 'Sending';

  @override
  String get settingsSendingFooter =>
      'Hvert auðkenni hefur sína eigin undirskrift. Svör eru send frá netfanginu sem skilaboðin voru send á.';

  @override
  String get settingsFoldersHeader => 'Möppur';

  @override
  String get settingsFoldersFooter =>
      'Loupe sýnir og samstillir möppurnar sem þú ert áskrifandi að, eins og Thunderbird gerir. Innhólf, Drög, Sendur póstur, Ruslpóstur, Rusl og Geymsla birtast alltaf.';

  @override
  String get settingsShowAllFolders => 'Sýna allar möppur';

  @override
  String get settingsIncoming => 'Móttökuþjónn';

  @override
  String get settingsOutgoing => 'Sendiþjónn';

  @override
  String get settingsConnectionNotEncrypted => 'Ekki dulkóðuð';

  @override
  String get settingsSignIn => 'Innskráning';

  @override
  String get settingsSignInExpired => 'Útrunnin';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider samþykkir ekki lengur innskráningu Loupe fyrir þennan aðgang, svo pósturinn samstillist ekki. Skráðu þig inn aftur til að laga það.';
  }

  @override
  String get settingsSignInAgain => 'Skrá inn aftur';

  @override
  String get settingsSigningIn => 'Skrái inn…';

  @override
  String get settingsRemoveAccount => 'Fjarlægja aðgang';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Fjarlægja „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Póstur hans og stillingar eru fjarlægð úr þessum síma. Engu er eytt á netþjóninum.';

  @override
  String get settingsManageFolders => 'Sýsla með möppur';

  @override
  String get settingsNoFolders => 'Engar möppur enn.';

  @override
  String get settingsManageFoldersFooter =>
      'Möppur í áskrift birtast á pósthólfaskjánum og samstillast í bakgrunni. Önnur póstforrit á sama aðgangi fylgja yfirleitt þessum áskriftum líka.';

  @override
  String get settingsSmartMailboxesFolder => 'Geymir Smart Mailboxes fyrir önnur tæki þín. Falin á pósthólfaskjánum.';

  @override
  String get settingsFolderAlwaysShown => 'Alltaf sýnd';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Gerast áskrifandi að $folder';
  }

  @override
  String get settingsIdentities => 'Auðkenni';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Fyrsta auðkennið er sjálfgefið fyrir ný skilaboð. Dragðu til að breyta röðinni.';

  @override
  String get settingsIdentitiesFooterSingle => 'Sjálfgefna auðkennið fyrir ný skilaboð.';

  @override
  String get settingsIdentitiesReplyFooter => 'Svar er sent frá auðkenninu sem skilaboðin voru send á.';

  @override
  String get settingsIdentityDefault => 'Sjálfgefið';

  @override
  String settingsIdentityReorder(String email) {
    return 'Endurraða $email';
  }

  @override
  String get settingsAddIdentity => 'Bæta við auðkenni';

  @override
  String get settingsNewIdentity => 'Nýtt auðkenni';

  @override
  String get settingsIdentity => 'Auðkenni';

  @override
  String get settingsIdentityNameHint => 'Nafnið þitt';

  @override
  String get settingsReplyTo => 'Svara til';

  @override
  String get settingsSignature => 'Undirskrift';

  @override
  String get settingsSignatureFooter => 'Bætt við fyrir neðan „-- “ í skilaboðum frá þessu auðkenni.';

  @override
  String get settingsNoSignature => 'Engin undirskrift';

  @override
  String get settingsCopyToMyself => 'Afrit til mín';

  @override
  String get settingsCopyToMyselfFooter => 'Bætt við öll skilaboð frá þessu auðkenni.';

  @override
  String get settingsCc => 'Afrit';

  @override
  String get settingsBcc => 'Falið afrit';

  @override
  String get settingsReplyPatterns => 'Nota fyrir svör til';

  @override
  String get settingsReplyPatternsFooter =>
      'Svör við skilaboðum sem send voru á þessi netföng eru send frá þessu auðkenni. * stendur fyrir hvað sem er: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Netfang, eða mynstur þar sem * stendur fyrir hvað sem er.';

  @override
  String get settingsAddReplyPattern => 'Bæta við netfangi eða mynstri';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Fjarlægja $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ógilt mynstur';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ er hvorki netfang né mynstur eins og *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Ekkert netfang';

  @override
  String get settingsIdentityNoAddressMessage => 'Sláðu inn netfangið sem á að senda frá.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ógilt netfang';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Svara til: „$address“ er ekki gilt netfang.',
      'cc': 'Afrit: „$address“ er ekki gilt netfang.',
      'bcc': 'Falið afrit: „$address“ er ekki gilt netfang.',
      'other': '„$address“ er ekki gilt netfang.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Vista auðkenni';

  @override
  String get settingsDiscardChanges => 'Henda breytingum';

  @override
  String get settingsDeleteIdentity => 'Eyða auðkenni';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Eyða „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Skilaboð sem þegar hafa verið send frá því haldast óbreytt.';

  @override
  String get settingsLastIdentityFooter => 'Aðgangur þarf að minnsta kosti eitt auðkenni.';

  @override
  String get rulesTitle => 'Reglur';

  @override
  String get rulesNewRule => 'Ný regla';

  @override
  String get rulesLoadError => 'Ekki tókst að hlaða inn reglunum.';

  @override
  String get rulesEmptyTitle => 'Engar reglur';

  @override
  String get rulesEmptyText =>
      'Reglur flokka, merkja og flagga nýjan póst fyrir þig. Búðu til reglu með skrifhnappnum hér fyrir ofan, eða úr leit með „Gera að reglu“.';

  @override
  String get rulesListFooter =>
      'Reglur keyra ofan frá og niður á nýjan póst í innhólfinu. Haltu fingri á reglu til að færa hana.';

  @override
  String get rulesChangeError => 'Ekki tókst að breyta reglunni';

  @override
  String get rulesConditionEveryMessage => 'Öll skilaboð';

  @override
  String rulesMoveRule(String rule) {
    return 'Færa $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Kveikt á $rule';
  }

  @override
  String get rulesServerRulesHeader => 'Reglur á netþjóni';

  @override
  String get rulesServerRulesFooter =>
      'Reglur á netþjóni keyra á póstþjóninum um leið og póstur berst, líka á meðan slökkt er á þessum síma. Þær eru geymdar í Sieve-skriftu sem heitir „loupe“.';

  @override
  String get rulesStatusUnknown => 'Óþekkt';

  @override
  String get rulesStatusError => 'Ekki tókst að spyrja netþjóninn.';

  @override
  String get rulesStatusChecking => 'Athuga…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Keyrt úr „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script“ er virka skriftan. Ýttu til að láta hana líka keyra reglur Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Engin skrifta er virk á netþjóninum. Ef þú vistar reglu á netþjóni verður kveikt á skriftu Loupe.';

  @override
  String get rulesStatusUnavailable => 'Ekki í boði';

  @override
  String get rulesStatusNoSieve => 'Netþjónn þessa aðgangs býður ekki upp á Sieve (ManageSieve eða JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Færa í $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Færa í möppu';

  @override
  String rulesActionTag(String tag) {
    return 'Merkja með $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Fjarlægja merkið $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Halda í innhólfi';

  @override
  String rulesActionForward(String address) {
    return 'Áframsenda til $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Áframsenda til $address, geyma ekkert afrit';
  }

  @override
  String get rulesActionStop => 'Stöðva';

  @override
  String get rulesNoActions => 'Gerir ekkert enn';

  @override
  String get rulesLocationDevice => 'Tæki';

  @override
  String get rulesLocationServer => 'Netþjónn';

  @override
  String get rulesLocationThisDevice => 'Þetta tæki';

  @override
  String get rulesNewRuleTitle => 'Ný regla';

  @override
  String get rulesEditRuleTitle => 'Breyta reglu';

  @override
  String get rulesDefaultNameEveryMessage => 'Öll skilaboð';

  @override
  String get rulesConditionHeader => 'Þegar ný skilaboð passa við';

  @override
  String get rulesConditionFooter =>
      'Skrifaðu það eins og þú myndir leita: from:, to:, s: (efni), b: (meginmál), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:anna@example.com s:reikningur';

  @override
  String get rulesAccounts => 'Aðgangar';

  @override
  String get rulesAllAccounts => 'Allir aðgangar';

  @override
  String get rulesRemovedAccount => 'Fjarlægður aðgangur';

  @override
  String get rulesAccountsFooter => 'Regla fyrir alla aðganga nær líka yfir aðganga sem þú bætir við síðar.';

  @override
  String get rulesActionsHeader => 'Þá';

  @override
  String get rulesForwardingFooter =>
      'Áframsending sendir hver samsvarandi skilaboð á annað netfang um leið og þau berast, líka á meðan slökkt er á þessum síma. Sumar þjónustur takmarka hve mikinn póst má áframsenda.';

  @override
  String get rulesForwardingHiddenFooter => 'Áframsending keyrir aðeins í reglum á netþjóni, svo henni er sleppt hér.';

  @override
  String rulesRemoveAction(String action) {
    return 'Fjarlægja $action';
  }

  @override
  String get rulesAddAction => 'Bæta við aðgerð';

  @override
  String get rulesAddMove => 'Færa í möppu…';

  @override
  String get rulesAddTagMenu => 'Bæta við merki…';

  @override
  String get rulesRemoveTagMenu => 'Fjarlægja merki…';

  @override
  String get rulesAddForward => 'Áframsenda til…';

  @override
  String get rulesStopProcessing => 'Hætta að keyra fleiri reglur';

  @override
  String get rulesRunOnHeader => 'Keyra á';

  @override
  String get rulesRunOnDeviceFooter =>
      'Þetta tæki keyrir regluna á nýjan póst í innhólfinu í hvert sinn sem Loupe athugar með póst.';

  @override
  String get rulesRunOnServerFooter =>
      'Póstþjónninn keyrir regluna um leið og póstur berst, líka á meðan slökkt er á þessum síma. Krefst Sieve, um ManageSieve (Dovecot, mailcow) eða JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Beita á fyrirliggjandi skilaboð…';

  @override
  String get rulesDeleteRule => 'Eyða reglu';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Eyða „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Mappa í hvaða aðgangi?';

  @override
  String get rulesMoveAccountMessage => 'Póstur hinna aðganganna fer í möppuna með sama nafni þar.';

  @override
  String get rulesAddTag => 'Bæta við merki';

  @override
  String get rulesRemoveTag => 'Fjarlægja merki';

  @override
  String get rulesForwardTo => 'Áframsenda til';

  @override
  String get rulesForwardToMessage =>
      'Netþjónninn sendir hver samsvarandi skilaboð áfram á þetta netfang, líka á meðan slökkt er á þessum síma. Notaðu netfang sem þú átt eða treystir.';

  @override
  String get rulesNotAnAddressTitle => 'Ekki netfang';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ er ekki netfang sem hægt er að áframsenda til.';
  }

  @override
  String get rulesKeepCopyTitle => 'Geyma afrit hér?';

  @override
  String get rulesKeepCopy => 'Geyma afrit';

  @override
  String get rulesDontKeepCopy => 'Ekki geyma afrit';

  @override
  String get rulesCheckCondition => 'Athugaðu skilyrðið';

  @override
  String get rulesChooseActionTitle => 'Veldu aðgerð';

  @override
  String get rulesChooseActionMessage => 'Bættu við því sem reglan gerir við skilaboðin sem passa.';

  @override
  String get rulesSaveError => 'Ekki tókst að vista regluna';

  @override
  String get rulesSaveServerError => 'Ekki tókst að vista regluna á netþjóninum';

  @override
  String get rulesRunOnDeviceInstead => 'Keyra frekar á þessu tæki';

  @override
  String get rulesNothingToApplyTitle => 'Ekkert til að beita';

  @override
  String get rulesNothingToApplyMessage => 'Gefðu reglunni fyrst skilyrði sem virkar og aðgerð.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Beita „$rule“ á skilaboð í…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Innhólfum';

  @override
  String get rulesApplyScopeAll => 'Öllum pósthólfum';

  @override
  String get rulesFindingMessages => 'Leita að skilaboðum…';

  @override
  String get rulesSearchError => 'Ekki tókst að leita';

  @override
  String get rulesSearchErrorUnknown => 'Eitthvað fór úrskeiðis.';

  @override
  String get rulesNoMatchesTitle => 'Engin skilaboð passa';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ekkert þar passar við „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Beita „$rule“ á $countString skilaboð?',
      one: 'Beita „$rule“ á $countString skilaboð?',
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
      other: 'Beita á $countString skilaboð',
      one: 'Beita á $countString skilaboð',
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
      other: '„$rule“ beitt á $countString skilaboð',
      one: '„$rule“ beitt á $countString skilaboð',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Spyr netþjóninn hvað hann getur…';

  @override
  String get rulesServerUnreachable => 'Ekki náðist í netþjóninn.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ekki hægt að keyra á netþjóninum: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ekki hægt að keyra á netþjóni $account: $problem';
  }

  @override
  String get rulesShowScript => 'Sýna skriftu';

  @override
  String get rulesHideScript => 'Fela skriftu';

  @override
  String get rulesMatchingHeader => 'Skilaboð sem passa';

  @override
  String get rulesMatchingHeaderLoading => 'Skilaboð sem passa…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString skilaboð passa',
      one: '$countString skilaboð passa',
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
      other: '$countString+ skilaboð passa',
      one: '$countString+ skilaboð passa',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Frá síðustu 30 dögum. Reglan sjálf virkar aðeins á nýjan póst, nema þú beitir henni á fyrirliggjandi skilaboð.';

  @override
  String rulesConditionError(String error) {
    return 'Villa er í skilyrðinu: $error';
  }

  @override
  String get rulesPreviewNoSender => '(enginn sendandi)';

  @override
  String get rulesPreviewNoSubject => '(ekkert efni)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'og $countString í viðbót',
      one: 'og $countString í viðbót',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ekkert frá síðustu 30 dögum.';

  @override
  String get rulesIncludeTitle => 'Kveikja á reglum á netþjóni';

  @override
  String get rulesIncludeLeaveOff => 'Hafa slökkt';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Netþjónninn keyrir nú þegar reglur Loupe fyrir $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ er virka skriftan á netþjóni $account, svo netþjónninn keyrir hana en ekki reglur Loupe. Loupe skiptir henni ekki út. Það getur bætt þessum línum við hana, og netþjónninn keyrir þá reglur Loupe á eftir reglum skriftunnar sjálfrar:';
  }

  @override
  String get rulesShowWholeScript => 'Sýna alla skriftuna';

  @override
  String get rulesHideWholeScript => 'Fela alla skriftuna';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Engu öðru í „$script“ er breytt. Ef síum hennar er síðar breytt í vefpóstinum gæti vefpósturinn endurskrifað hana án þessara lína; Loupe sýnir þá aftur slökkt á reglum á netþjóni.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Bæta við „$script“';
  }

  @override
  String get subscriptionsTitle => 'Áskriftir';

  @override
  String get subscriptionsNewsletters => 'Fréttabréf';

  @override
  String get subscriptionsDiscussions => 'Umræður';

  @override
  String get subscriptionsFilter => 'Sía';

  @override
  String get subscriptionsFilterNeverRead => 'Aldrei lesið';

  @override
  String get subscriptionsFilterRarelyRead => 'Sjaldan lesið';

  @override
  String get subscriptionsFilterAll => 'Öll';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Ekki tókst að telja áskriftir';

  @override
  String get subscriptionsNoMatches => 'Ekkert passar';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ekkert fréttabréf heitir „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Enginn listi heitir „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Engin fréttabréf';

  @override
  String get subscriptionsNoNewslettersDetail => 'Fréttabréf og annar fjöldapóstur birtast hér þegar þau berast.';

  @override
  String get subscriptionsNothingNeverRead => 'Ekkert sem aldrei er lesið';

  @override
  String get subscriptionsNothingRarelyRead => 'Ekkert sem sjaldan er lesið';

  @override
  String get subscriptionsNothingFilteredDetail => 'Þú lest eitthvað af öllu sem þú færð.';

  @override
  String get subscriptionsNoDiscussions => 'Engar umræður';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Póstlistar sem þú getur skrifað á birtast hér þegar póstur frá þeim berst.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listar sem margir skrifa á. Haltu fingri á einum til að festa hann við Pósthólf, lesa hann sem einfaldan texta eða færa hann í Fréttabréf.';

  @override
  String get subscriptionsPrivacyNote =>
      'Talið í þessum síma út frá póstinum sem hann hefur sótt; ekkert er sent úr símanum til að reikna þetta út. Loupe hefur aðeins samband við sendanda þegar þú ýtir á Afskrá: með einum smelli er aðeins „List-Unsubscribe=One-Click“ sent á slóðina sem sendandinn gaf upp, án vefkaka og án nokkurs annars um þig, og síður hans eða myndir eru aldrei sóttar.';

  @override
  String get subscriptionsVolumeNone => 'Ekkert nýlega';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mán.';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mán.';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'lesið $percent';
  }

  @override
  String get subscriptionsStillSending => 'Sendir enn';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Afskráð $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Afskráningarsíða opnuð $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ein snerting · hefur samband við $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Með tölvupósti til $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Á vefsvæðinu $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Afskrá';

  @override
  String get subscriptionsUnsubscribeAgain => 'Afskrá aftur';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Setja $countString í geymslu úr innhólfi',
      one: 'Setja $countString í geymslu úr innhólfi',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Búa til reglu…';

  @override
  String get subscriptionsCreateRuleDetail => 'Færa framtíðarpóst eða setja hann í geymslu';

  @override
  String get subscriptionsTreatAsDiscussion => 'Meðhöndla sem umræðu';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Listi sem fólk skrifar á: lestu hann eins og spjallborð';

  @override
  String get subscriptionsTreatAsNewsletter => 'Meðhöndla sem fréttabréf';

  @override
  String get subscriptionsBlockSender => 'Loka á sendanda';

  @override
  String get subscriptionsBlock => 'Loka á';

  @override
  String get subscriptionsBlocked => 'Lokað á';

  @override
  String get subscriptionsBlockedDetail => 'Nýr póstur fer í ruslpóst';

  @override
  String get subscriptionsPin => 'Festa við Pósthólf';

  @override
  String get subscriptionsUnpin => 'Losa frá Pósthólfum';

  @override
  String get subscriptionsOpenDefaultView => 'Opna í sjálfgefinni sýn';

  @override
  String get subscriptionsOpenPlainText => 'Opna sem einfaldan texta (Mono)';

  @override
  String get subscriptionsPinned => 'Fest';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ólesin',
      one: '$countString ólesið',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Enginn póstur frá þessum sendanda núna.';

  @override
  String get subscriptionsLatestMessages => 'NÝJUSTU SKILABOÐ';

  @override
  String get subscriptionsMail => 'Póstur';

  @override
  String get subscriptionsNoneIn90Days => 'Ekkert á 90 dögum';

  @override
  String get subscriptionsRead => 'Lesið';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString af $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Síðast móttekið';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count möppur', one: '$count mappa');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Sendir enn';

  @override
  String get subscriptionsUnsubscribedTitle => 'Afskráð';

  @override
  String subscriptionsSince(String date) {
    return 'frá $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'síða opnuð $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender gefur ekki upp hvernig á að afskrá sig.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender gefur ekki upp hvernig á að afskrá sig. Þú getur lokað á sendandann í staðinn.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Afskrái frá $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Afskráð frá $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Ekki tókst að afskrá: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Ekki tókst að afskrá sjálfkrafa';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Senda afskráningarpóst';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Opna $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Opna $site?';
  }

  @override
  String get subscriptionsOpen => 'Opna';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender afskráir á vefsvæði sínu. Síðan opnast í vafra Loupe; ljúktu við þar.';
  }

  @override
  String get subscriptionsWebInsecure => 'Tengingin við þetta vefsvæði er ekki dulkóðuð.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Varúð: þessi slóð líkir eftir $site með stöfum sem líkjast öðrum.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Varúð: þessi slóð líkir eftir öðru vefsvæði með stöfum sem líkjast öðrum.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Ekki tókst að opna $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe skráir dagsetninguna í dag og lætur þig vita ef $sender heldur áfram að senda.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Afskrá frá $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe hefur samband við $site til að afskrá.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Þetta er eina skiptið sem Loupe hefur samband við vefsvæði sendanda. Það sendir aðeins „List-Unsubscribe=One-Click“ á slóðina sem $sender gaf upp, án vefkaka eða nokkurs annars um þig, og hleður ekki inn síðunni.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Afskráningartengillinn er ekki örugg slóð á netinu.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site svaraði ekki í tæka tíð.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Ekki náðist í $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site sendi beiðnina áfram á aðra síðu, sem Loupe fylgir ekki.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site hafnaði beiðninni (villa $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Enginn aðgangur er til að senda afskráningarpóstinn frá.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe sendir tölvupóst til $to frá $from, með efnislínunni „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Afskráningarpóstur sendur til $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Loka á $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nýr póstur frá þessum lista fer í ruslpóst. Þú getur breytt þessu í Stillingar › Reglur.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nýr póstur frá $address fer í ruslpóst. Þú getur breytt þessu í Stillingar › Reglur.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Lokað á $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Færa $count í ruslpóst',
      one: 'Færa $count í ruslpóst',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Loka á $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender er núna í Fréttabréfum.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender er núna í Umræðum.';
  }

  @override
  String get appLiveGateTitle => 'Ekki tókst að opna aðgangana þína';

  @override
  String get appLiveGateUnavailableBuild => 'Raunverulegir aðgangar eru ekki enn í boði í þessari útgáfu.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe gat ekki lesið lykilinn sem verndar póstinn þinn í þessum síma. Þetta er oft tímabundið: reyndu aftur eða endurræstu símann.';

  @override
  String get appLiveGateKeyMissing =>
      'Lykillinn sem verndar póstinn þinn í þessum síma er horfinn, sem getur gerst eftir að öryggisafrit er endurheimt. Pósturinn þinn er enn á netþjóninum.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Ekki er hægt að lesa póstgagnagrunninn í þessum síma: hann er skemmdur eða lykill hans breyttist. Pósturinn þinn er enn á netþjóninum.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Eitthvað fór úrskeiðis við að opna aðgangana þína ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Þetta eyðir aðgöngunum þínum og póstinum sem er geymdur í þessum síma, þar á meðal skilaboðum sem bíða í úthólfinu. Póstur á netþjónunum þínum verður ekki fyrir áhrifum; bættu aðgöngunum þínum við aftur á eftir.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Eyða og byrja upp á nýtt';

  @override
  String get appLiveGateUseDemo => 'Nota sýnipóst';

  @override
  String get appLiveGateReset => 'Endurstilla póst í þessum síma…';

  @override
  String get attachmentsUntitled => 'Viðhengi';

  @override
  String get attachmentsUntitledFile => 'Ónefnt';

  @override
  String get attachmentsOpenIn => 'Opna í…';

  @override
  String get attachmentsSaveToFiles => 'Vista í skrár';

  @override
  String get attachmentsShareMenu => 'Deila…';

  @override
  String get attachmentsDownloadError => 'Ekki tókst að sækja viðhengið. Athugaðu tenginguna og reyndu aftur.';

  @override
  String get attachmentsShareError => 'Ekki tókst að deila viðhenginu.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ekkert forrit í þessu tæki opnar þessa skrá ($type). Prófaðu frekar að deila henni.';
  }

  @override
  String get attachmentsOpenInError => 'Ekki tókst að opna viðhengið í öðru forriti.';

  @override
  String attachmentsSaved(String name) {
    return 'Vistað: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Ekki tókst að vista viðhengið.';

  @override
  String get attachmentsGone => 'Þetta viðhengi er ekki lengur tiltækt.';

  @override
  String get attachmentsDownloadFailed => 'Ekki tókst að sækja viðhengið.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count síður', one: '$count síða');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size um farsímagögn';
  }

  @override
  String get attachmentsLargeDownload => 'Þetta viðhengi er stórt. Sæktu það núna, eða síðar á Wi-Fi.';

  @override
  String get attachmentsDownload => 'Sækja';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Sæki $size…';
  }

  @override
  String get attachmentsDownloading => 'Sæki…';

  @override
  String get attachmentsTooLarge => 'Of stórt til að forskoða hér.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Sýni fyrstu $shown af $total. Afritaðu, deildu eða vistaðu til að fá allt.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Ekki er hægt að sýna þetta PDF-skjal hér (það gæti verið varið með lykilorði).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page af $count';
  }

  @override
  String get attachmentsModeTable => 'Tafla';

  @override
  String get attachmentsModeText => 'Texti';

  @override
  String get attachmentsModeMessage => 'Skilaboð';

  @override
  String get attachmentsModeSource => 'Frumtexti';

  @override
  String get attachmentsDontWrap => 'Ekki brjóta línur';

  @override
  String get attachmentsWrap => 'Brjóta línur';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines línur', one: '$count lína');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Afrita allt';

  @override
  String get attachmentsCopied => 'Afritað';

  @override
  String get attachmentsImageUnavailable => 'Ekki er hægt að sýna þessa mynd hér. Prófaðu „Opna í…“.';

  @override
  String get attachmentsEmlNoSubject => '(Ekkert efni)';

  @override
  String get attachmentsEmlFrom => 'Frá';

  @override
  String get attachmentsEmlTo => 'Til';

  @override
  String get attachmentsEmlCc => 'Afrit';

  @override
  String get attachmentsEmlDate => 'Dagsetning';

  @override
  String get attachmentsEmlNoText => 'Þessi skilaboð eru án texta.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Viðhengi ($count): $names',
      one: 'Viðhengi ($count): $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Skipuleggjandi: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Og $count viðburðir í viðbót',
      one: 'Og $count viðburður í viðbót',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Mynd';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-mynd';
  }

  @override
  String get attachmentsTypePdf => 'PDF-skjal';

  @override
  String get attachmentsTypeTsv => 'TSV-tafla';

  @override
  String get attachmentsTypeCsv => 'CSV-tafla';

  @override
  String get attachmentsTypeCalendar => 'Dagatalsviðburður';

  @override
  String get attachmentsTypeEmail => 'Tölvupóstur';

  @override
  String get attachmentsTypeContact => 'Nafnspjald';

  @override
  String get attachmentsTypeLog => 'Annálsskrá';

  @override
  String get attachmentsTypeText => 'Texti';

  @override
  String get attachmentsTypeZip => 'ZIP-safn';

  @override
  String get attachmentsTypeArchive => 'Þjappað safn';

  @override
  String get attachmentsTypeWord => 'Word-skjal';

  @override
  String get attachmentsTypeExcel => 'Excel-tafla';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-kynning';

  @override
  String get attachmentsTypeWebPage => 'Vefsíða';

  @override
  String get attachmentsTypeVideo => 'Myndskeið';

  @override
  String get attachmentsTypeAudio => 'Hljóð';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-skrá';
  }

  @override
  String get attachmentsTypeFile => 'Skrá';

  @override
  String get calendarUntitledEvent => 'Viðburður';

  @override
  String get calendarAllDay => 'Allan daginn';

  @override
  String calendarYourTime(String time) {
    return '$time að þínum tíma';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Taka þátt: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hefur samþykkt: $details',
      'tentative': '$name hefur samþykkt með fyrirvara: $details',
      'declined': '$name hefur hafnað: $details',
      'delegated': '$name hefur framselt: $details',
      'other': '$name hefur ekki svarað: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hefur samþykkt boðið',
      'tentative': '$name hefur samþykkt boðið með fyrirvara',
      'declined': '$name hefur hafnað boðinu',
      'delegated': '$name hefur framselt boðið',
      'other': '$name hefur ekki svarað boðinu',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Kort';

  @override
  String get calendarJoin => 'Taka þátt';

  @override
  String get calendarOnlineMeeting => 'Netfundur';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-fundur';
  }

  @override
  String get calendarOrganizerYou => 'Þú';

  @override
  String get calendarOrganizerLabel => 'skipuleggjandi';

  @override
  String get calendarStatusAccepted => 'Samþykkt';

  @override
  String get calendarStatusMaybe => 'Kannski';

  @override
  String get calendarStatusDeclined => 'Hafnað';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name samþykkti',
      'tentative': '$name samþykkti með fyrirvara',
      'declined': '$name hafnaði',
      'delegated': '$name framseldi',
      'other': '$name hefur ekki svarað',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name samþykkti:',
      'tentative': '$name samþykkti með fyrirvara:',
      'declined': '$name hafnaði:',
      'delegated': '$name framseldi:',
      'other': '$name hefur ekki svarað:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name stingur upp á nýjum tíma';
  }

  @override
  String get calendarCounterUnknown => 'Þátttakandi stingur upp á nýjum tíma';

  @override
  String get calendarDeclineCounter => 'Skipuleggjandinn hélt tímanum';

  @override
  String calendarRefresh(String name) {
    return '$name biður um nýjustu útgáfuna';
  }

  @override
  String get calendarRefreshUnknown => 'Þátttakandi biður um nýjustu útgáfuna';

  @override
  String get calendarCancelled => 'Aflýst';

  @override
  String get calendarCancelledByOrganizer => 'Skipuleggjandinn aflýsti þessum viðburði.';

  @override
  String get calendarCancelledLater => 'Þessum viðburði var aflýst síðar.';

  @override
  String get calendarOutdated => 'Úrelt';

  @override
  String get calendarOutdatedDetail => 'Þessu boði var breytt síðar; nýrra boðið gildir.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Staðsetning fjarlægð (var $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Staðsetning fjarlægð (var engin)';

  @override
  String calendarLocationChanged(String location) {
    return 'Staðsetningu breytt í $location';
  }

  @override
  String get calendarNewTitle => 'Nýr titill';

  @override
  String get calendarRepeatChanged => 'Endurtekningunni var breytt';

  @override
  String get calendarUpdated => 'Uppfært';

  @override
  String get calendarUpdatedInvitation => 'Uppfært boð';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Tíma breytt úr $before í $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Tímabeltið „$zone“ er óþekkt: tímar eins og þeir eru skráðir';
  }

  @override
  String calendarNext(String when) {
    return 'Næst: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gestir', one: '$count gestur');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count samþykktu',
      one: '$count samþykkti',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kannski', one: '$count kannski');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count höfnuðu', one: '$count hafnaði');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (þú)';
  }

  @override
  String get calendarAttendeeOptional => 'valfrjálst';

  @override
  String get calendarAttendeeRoom => 'fundarherbergi';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Þú samþykktir eldri útgáfu.',
      'tentative': 'Þú samþykktir eldri útgáfu með fyrirvara.',
      'declined': 'Þú hafnaðir eldri útgáfu.',
      'delegated': 'Þú framseldir eldri útgáfu.',
      'other': 'Þú svaraðir ekki eldri útgáfu.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Samþykkja';

  @override
  String get calendarMaybe => 'Kannski';

  @override
  String get calendarDecline => 'Hafna';

  @override
  String get calendarCommentHint => 'Athugasemd til skipuleggjanda (valfrjálst)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Svarið þitt fer til $organizer frá $address.';
  }

  @override
  String get calendarAddComment => 'Bæta við athugasemd';

  @override
  String get calendarAddToCalendar => 'Bæta við dagatal';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Og $count viðburðir í viðbót í skránni',
      one: 'Og $count viðburður í viðbót í skránni',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Ekkert dagatalsforrit er til að bæta viðburðinum við.';

  @override
  String get calendarCantOpenCalendar => 'Ekki tókst að opna dagatalið.';

  @override
  String get calendarCantOpenLink => 'Ekki tókst að opna tengilinn.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Taka þátt í $provider-fundi?';
  }

  @override
  String get calendarJoinTitle => 'Taka þátt í fundinum?';

  @override
  String calendarJoinOpens(String host) {
    return 'Opnar $host í vafranum þínum.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Varúð: þessi slóð líkir eftir $site með stöfum sem líkjast öðrum.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Varúð: þessi slóð líkir eftir öðru vefsvæði með stöfum sem líkjast öðrum.';

  @override
  String calendarJoinOpen(String host) {
    return 'Opna $host';
  }

  @override
  String get calendarNoOrganizer => 'Þetta boð hefur engan skipuleggjanda til að svara.';

  @override
  String get calendarNoAccount => 'Enginn aðgangur er til að svara frá.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Samþykkt', 'tentative': 'Kannski', 'other': 'Hafnað'});
    return '$_temp0 · sendi svar til $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Samþykkt', 'tentative': 'Kannski', 'other': 'Hafnað'});
    return '$_temp0 · svar sent';
  }

  @override
  String get calendarReplyAlreadySent => 'Svarið var þegar sent.';

  @override
  String get calendarReplyNotSent => 'Svar ekki sent.';

  @override
  String get dataSmimeNeedsDevice =>
      'S/MIME-skilríkin þín eru í þessu tæki: opnaðu Loupe til að undirrita og senda þessi skilaboð.';

  @override
  String dataSigningFailed(String error) {
    return 'Undirritun mistókst: $error';
  }

  @override
  String get keyboardShortcuts => 'Flýtilyklar';

  @override
  String get keyboardGroupGeneral => 'Almennt';

  @override
  String get keyboardGroupMessages => 'Skilaboð';

  @override
  String get keyboardGroupCompose => 'Skrif';

  @override
  String get keyboardCommandPalette => 'Skipanaspjald';

  @override
  String get keyboardBackClose => 'Til baka, loka';

  @override
  String get keyboardNextMessage => 'Næstu skilaboð';

  @override
  String get keyboardPreviousMessage => 'Fyrri skilaboð';

  @override
  String get keyboardOpenMessage => 'Opna skilaboð';

  @override
  String get keyboardMoveToTrash => 'Færa í rusl';

  @override
  String get keyboardToggleRead => 'Merkja sem lesið eða ólesið';

  @override
  String get keyboardToggleFlag => 'Flagga eða fjarlægja flagg';

  @override
  String get keyboardCloseDraft => 'Loka (vista eða eyða drögum)';

  @override
  String get keyboardOr => 'eða';

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
  String get mailingListsMuted => 'Þráðurinn er þaggaður. Ný skilaboð í honum berast sem lesin.';

  @override
  String get mailingListsUnmuted => 'Þráðurinn er ekki lengur þaggaður.';

  @override
  String get mailingListsMuteThread => 'Þagga þráð';

  @override
  String get mailingListsUnmuteThread => 'Hætta að þagga þráð';

  @override
  String get mailingListsPin => 'Festa við Pósthólf';

  @override
  String get mailingListsUnpin => 'Losa frá Pósthólfum';

  @override
  String get mailingListsDefaultView => 'Opna í sjálfgefinni sýn';

  @override
  String get mailingListsPlainText => 'Opna sem einfaldan texta (Mono)';

  @override
  String get mailingListsShowMuted => 'Sýna þaggaða þræði';

  @override
  String get mailingListsHideMuted => 'Fela þaggaða þræði';

  @override
  String get mailingListsTreatAsNewsletter => 'Meðhöndla sem fréttabréf';

  @override
  String get mailingListsOptions => 'Valkostir lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$formatted ólesin', one: '$count ólesið');
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Ný skilaboð á listann';

  @override
  String get mailingListsRowUnread => 'Ólesið';

  @override
  String get mailingListsRowMuted => 'Þaggað';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count svör', one: '$count svar');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Engir þræðir';

  @override
  String get mailingListsMutedHidden => 'Þaggaðir þræðir eru faldir.';

  @override
  String get mailingListsTechnicalTitle => 'Tæknilegir póstlistar';

  @override
  String get mailingListsTechnicalEmpty => 'Póstlistar birtast hér þegar póstur frá þeim berst.';

  @override
  String get mailingListsTechnicalFooter =>
      'Skilaboð frá þessum listum opnast sem einfaldur texti með jafnbreiðu letri, og plástrar eru sýndir sem diff. Aa-hnappurinn skiptir enn um sýn á hvaða skilaboðum sem er.';

  @override
  String get paletteMoveToMailbox => 'Færa í pósthólf…';

  @override
  String get paletteMarkAllRead => 'Merkja allt sem lesið';

  @override
  String get paletteExportFolder => 'Flytja út möppu…';

  @override
  String get paletteGetNewMail => 'Sækja nýjan póst';

  @override
  String get paletteSnoozed => 'Blundað';

  @override
  String get paletteSubscriptions => 'Áskriftir';

  @override
  String get paletteDiscussions => 'Umræður';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Póstlisti';

  @override
  String get paletteTag => 'Merki';

  @override
  String get paletteSwipeActions => 'Strokuaðgerðir';

  @override
  String get paletteNotifications => 'Tilkynningar';

  @override
  String get paletteRules => 'Reglur';

  @override
  String get paletteEncryption => 'Dulkóðun enda á milli';

  @override
  String get paletteAdvanced => 'Ítarlegt';

  @override
  String get paletteAddAccount => 'Bæta við aðgangi';

  @override
  String get paletteAccount => 'Aðgangur';

  @override
  String get paletteFolders => 'Möppur';

  @override
  String get paletteRecentSearch => 'Nýleg leit';

  @override
  String paletteSearchMail(String query) {
    return 'Leita í pósti að „$query“';
  }

  @override
  String get palettePlaceholder => 'Leita að aðgerðum, pósthólfum, stillingum';

  @override
  String get paletteNothingFound => 'Ekkert fannst';

  @override
  String get searchNewSmartMailbox => 'Nýtt Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Sýnir allt sem passar við „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ vistað í Pósthólf';
  }

  @override
  String get searchMakeRule => 'Gera að reglu';

  @override
  String get searchSaveSmartMailbox => 'Vista sem Smart Mailbox';

  @override
  String get searchNegate => 'Útiloka';

  @override
  String get searchDontNegate => 'Hætta að útiloka';

  @override
  String get searchAllMailboxes => 'Öll pósthólf';

  @override
  String get searchRecent => 'Nýlegar leitir';

  @override
  String get searchClear => 'Hreinsa';

  @override
  String get searchSuggestions => 'Tillögur';

  @override
  String get searchUnreadMessages => 'Ólesin skilaboð';

  @override
  String get searchFlaggedMessages => 'Flögguð skilaboð';

  @override
  String get searchWithAttachments => 'Skilaboð með viðhengjum';

  @override
  String get searchUnrepliedMessages => 'Ósvöruð skilaboð';

  @override
  String get searchTags => 'Merki';

  @override
  String get searchPeople => 'Fólk';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Frá: $name';
  }

  @override
  String get searchSearching => 'Leita…';

  @override
  String get searchNoResults => 'Engar niðurstöður';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted niðurstöður',
      one: '$count niðurstaða',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Leitarvalmynd';

  @override
  String searchSearchingAccount(String account) {
    return 'Leita í $account á netþjóninum…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Leita í aðgangi á netþjóninum…';

  @override
  String searchAccountFailed(String account) {
    return 'Ekki tókst að leita í $account á netþjóninum';
  }

  @override
  String get searchUnknownAccountFailed => 'Ekki tókst að leita í aðgangi á netþjóninum';

  @override
  String searchChip(String term) {
    return '$term. Ýttu tvisvar til að breyta.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ekki $term. Ýttu tvisvar til að breyta.';
  }

  @override
  String get searchReadAndUnread =>
      'Innhólf Schrödingers: hver skilaboð hér eru bæði lesin og ólesin þar til þú opnar þau.';

  @override
  String searchContradiction(String term) {
    return 'Engin skilaboð geta bæði verið „$term“ og ekki.';
  }

  @override
  String get searchSyncDeviceOnly => 'Aðeins í þessu tæki';

  @override
  String searchSyncUnsupported(String account) {
    return 'Aðeins í þessu tæki: $account getur ekki geymt það';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Ekki samstillt: $account er með nýrra snið';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Bíður eftir samstillingu við $account';
  }

  @override
  String searchSynced(String account) {
    return 'Samstillt við $account';
  }

  @override
  String get searchRename => 'Endurnefna';

  @override
  String get searchEditSearch => 'Breyta leit';

  @override
  String get searchDeleteSmartMailbox => 'Eyða Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Endurnefna Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Þessu Smart Mailbox var eytt.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes eru geymd í þessu tæki.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes eru geymd á póstþjóninum þínum, svo önnur tæki þín hafa þau líka, og sömuleiðis Thunderbird með Expression Search Reloaded. Þau sem leita í öllum aðgöngum eru geymd á $account; þau sem ná yfir eina möppu, á aðgangi þeirrar möppu.';
  }

  @override
  String get searchSyncVia => 'Samstilla í gegnum';

  @override
  String get searchSyncViaFooter => 'Veldu sama aðgang í öllum tækjum.';

  @override
  String get searchGmailCantKeep => 'Gmail getur ekki geymt Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Geyma Smart Mailboxes aðeins í þessu tæki';

  @override
  String get searchOnTheServer => 'Á netþjóninum';

  @override
  String get searchServerFooter =>
      'Lýsigögn á netþjóni (IMAP METADATA) birtast ekki í neinu póstforriti. Netþjónar án þeirra fá möppuna „Loupe Settings“ með einum skilaboðum; Loupe felur hana í Pósthólfum.';

  @override
  String get searchSyncNow => 'Samstilla núna';

  @override
  String get searchStateUnsupported => 'Ekki stutt';

  @override
  String get searchStateNewerFormat => 'Nýrra snið';

  @override
  String get searchStateFailed => 'Ekki tókst að samstilla';

  @override
  String get searchStateSyncing => 'Samstilli…';

  @override
  String get searchStateWaiting => 'Bíður';

  @override
  String get searchStateMetadata => 'Lýsigögn á netþjóni';

  @override
  String get searchStateFolder => 'Mappan „Loupe Settings“';

  @override
  String get searchStateNothing => 'Ekkert geymt';

  @override
  String get sharedBack => 'Til baka';

  @override
  String get sharedYesterday => 'Í gær';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date kl. $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bæti', one: '$count bæti');
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
  String get sharedSyncNoAccounts => 'Engir aðgangar';

  @override
  String get sharedSyncChecking => 'Athuga með póst…';

  @override
  String get sharedSyncFailed => 'Ekki tókst að athuga með póst';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Ótengt';

  @override
  String get sharedSyncJustNow => 'Uppfært rétt í þessu';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Uppfært fyrir $minutes mínútum',
      one: 'Uppfært fyrir $minutes mínútu',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Uppfært kl. $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Uppfært $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Öll innhólf';

  @override
  String get sharedMailboxUnread => 'Ólesið';

  @override
  String get sharedMailboxFlagged => 'Flaggað';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Öll drög';

  @override
  String get sharedMailboxAllSent => 'Allur sendur póstur';

  @override
  String get sharedMailboxUntitled => 'Pósthólf';

  @override
  String get sharedTagImportant => 'Mikilvægt';

  @override
  String get sharedTagWork => 'Vinna';

  @override
  String get sharedTagPersonal => 'Persónulegt';

  @override
  String get sharedTagToDo => 'Verkþáttur';

  @override
  String get sharedTagLater => 'Seinna';

  @override
  String get sharedTags => 'Merki';

  @override
  String get sharedMoveTo => 'Færa í…';

  @override
  String get sharedNoRecipients => 'Engir viðtakendur';

  @override
  String get sharedUnknownSender => 'Óþekktur sendandi';

  @override
  String get sharedOnServer => 'Á netþjóni';

  @override
  String get sharedAttachment => 'Viðhengi';

  @override
  String get sharedSnoozedBadge => 'Blundað';

  @override
  String get sharedRowUnread => 'Ólesið';

  @override
  String get sharedRowBackFromSnooze => 'Komið úr blundi';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Flaggað';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð sett í geymslu',
      one: '$count skilaboð sett í geymslu',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboðum eytt',
      one: '$count skilaboðum eytt',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð færð í innhólf',
      one: '$count skilaboð færð í innhólf',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð færð í rusl',
      one: '$count skilaboð færð í rusl',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð færð í ruslpóst',
      one: '$count skilaboð færð í ruslpóst',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð færð í $mailbox',
      one: '$count skilaboð færð í $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð færð í pósthólf',
      one: '$count skilaboð færð í pósthólf',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count skilaboð í blundi · $time',
      one: '$count skilaboð í blundi · $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Í blundi ($time) aðeins í þessu tæki: netþjónninn getur ekki geymt blundtíma.';
  }

  @override
  String get sharedMoveOneAccount => 'Veldu skilaboð úr einum aðgangi til að færa þau.';

  @override
  String get sharedSnoozeTitle => 'Blunda';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Breyta blundtíma';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eyða $count skilaboðum varanlega?',
      one: 'Eyða $count skilaboðum varanlega?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ekki er hægt að afturkalla þetta.';

  @override
  String get sharedDeletePermanently => 'Eyða varanlega';

  @override
  String get sharedSwipeRead => 'Lesið';

  @override
  String get sharedSwipeUnread => 'Ólesið';

  @override
  String get sharedSwipeInbox => 'Innhólf';

  @override
  String get sharedSwipeDelete => 'Eyða';

  @override
  String get sharedTrash => 'Henda';

  @override
  String get sharedSwipeSnooze => 'Blunda';

  @override
  String get sharedWakeNow => 'Vekja núna';

  @override
  String get sharedChangeSnoozeTime => 'Breyta blundtíma…';

  @override
  String get sharedSnooze => 'Blunda…';

  @override
  String get sharedTag => 'Merkja…';

  @override
  String get sharedMoveMessage => 'Færa skilaboð…';

  @override
  String get sharedNotJunk => 'Ekki ruslpóstur';

  @override
  String get accountSetupTitle => 'Bæta við aðgangi';

  @override
  String get accountSetupTitleDone => 'Aðgangi bætt við';

  @override
  String get accountSetupAddressTitle => 'Bæta við póstaðgangi';

  @override
  String get accountSetupAddressText => 'Loupe finnur stillingarnar fyrir flestar póstþjónustur.';

  @override
  String get accountSetupNameHint => 'Nafnið þitt';

  @override
  String get accountSetupEmail => 'Netfang';

  @override
  String get accountSetupEmailHint => 'nafn@example.com';

  @override
  String get accountSetupContinue => 'Halda áfram';

  @override
  String get accountSetupLookingUp => 'Leita að stillingum…';

  @override
  String get accountSetupImport => 'Flytja inn úr Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Sláðu inn gilt netfang.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Engar stillingar fundust fyrir $domain. Sláðu þær inn hér fyrir neðan.';
  }

  @override
  String get accountSetupCheckServers => 'Athugaðu heiti netþjóna og gáttir.';

  @override
  String get accountSetupEnterPassword => 'Sláðu inn lykilorðið þitt.';

  @override
  String get accountSetupConnecting => 'Tengist…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Bíð eftir $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Ekki tókst að opna síðuna.';

  @override
  String get accountSetupCouldNotSaveName => 'Ekki tókst að vista nafnið.';

  @override
  String get accountSetupTrustCertificate => 'Treysta þessum skilríkjum';

  @override
  String get accountSetupPasswordRequired => 'Áskilið';

  @override
  String get accountSetupShowPassword => 'Sýna lykilorð';

  @override
  String get accountSetupHidePassword => 'Fela lykilorð';

  @override
  String get accountSetupAppPassword => 'Forritslykilorð';

  @override
  String get accountSetupApiToken => 'API-tóki';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Móttaka · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Sending · SMTP';

  @override
  String get accountSetupSignIn => 'Skrá inn';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Skrá inn með $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Nota forritslykilorð';

  @override
  String get accountSetupUseAppPasswordInstead => 'Nota forritslykilorð í staðinn';

  @override
  String get accountSetupUseDifferentAddress => 'Nota annað netfang';

  @override
  String get accountSetupHowToCreateAppPassword => 'Hvernig á að búa til forritslykilorð';

  @override
  String get accountSetupHowToCreateOne => 'Leiðbeiningar';

  @override
  String get accountSetupGoogleNote =>
      'Þú skráir þig inn á síðu Google og Loupe sér aldrei lykilorðið þitt. Leyfðu Loupe að lesa, senda og skipuleggja póstinn þinn.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Skrá inn með Google“ er ekki enn í boði í þessari útgáfu. Þú getur tengst með forritslykilorði í staðinn (það krefst staðfestingar í tveimur skrefum á Google-reikningnum þínum).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Búðu til forritslykilorð á Google-reikningnum þínum og límdu það hér fyrir neðan.';

  @override
  String get accountSetupMicrosoftNote =>
      'Þú skráir þig inn á síðu Microsoft og Loupe sér aldrei lykilorðið þitt. Þetta virkar fyrir Outlook.com og Hotmail, og fyrir vinnu- eða skólaaðganga á Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Innskráning með Microsoft kemur í síðari útgáfu. Outlook-, Hotmail- og Microsoft 365-aðgangar þurfa hana: þeir taka ekki lengur við lykilorðum frá póstforritum.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail þarf sérstakt forritslykilorð, ekki lykilorð Apple-reikningsins þíns.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail þarf forritslykilorð, ekki lykilorð aðgangsins þíns.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe tengist Fastmail um JMAP með API-tóka: Settings › Privacy & Security › Manage API tokens, fyrir JMAP, með aðgangi að tölvupósti og sendingu.';

  @override
  String get accountSetupFastmailNote => 'Fastmail þarf forritslykilorð fyrir póstforrit.';

  @override
  String get accountSetupServerSettings => 'Stillingar netþjóns';

  @override
  String get accountSetupSettingsNotFound => 'Fannst ekki sjálfkrafa';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Fannst í gegnum $source';
  }

  @override
  String get accountSetupEditSettings => 'Breyta stillingum';

  @override
  String get accountSetupSyncing => 'Pósturinn þinn er að samstillast.';

  @override
  String get accountSetupDescription => 'Lýsing';

  @override
  String get accountSetupDescriptionHint => 'Vinna, einka…';

  @override
  String get accountSetupColour => 'Litur';

  @override
  String accountSetupColourNumber(int number) {
    return 'Litur $number';
  }

  @override
  String get accountSetupSaving => 'Vista…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe gat ekki opnað póstgagnagrunninn sinn í þessum síma. Lokaðu Loupe, opnaðu það aftur og reyndu aftur.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Eitthvað fór úrskeiðis ($error). Reyndu aftur.';
  }

  @override
  String get accountSetupSecurityNone => 'Engin';

  @override
  String get accountSetupProtocol => 'Samskiptaregla';

  @override
  String get accountSetupPort => 'Gátt';

  @override
  String get accountSetupSecurity => 'Öryggi';

  @override
  String get accountSetupUsername => 'Notandanafn';

  @override
  String get accountSetupUsernameHint => 'Netfangið þitt';

  @override
  String get accountSetupNoEncryptionTitle => 'Tengjast án dulkóðunar?';

  @override
  String get accountSetupNoEncryptionText =>
      'Lykilorðið þitt og öll skilaboð færu um sem ódulkóðaður texti. Hver sem er á netinu, til dæmis á almennu Wi-Fi, gæti lesið þau. Notaðu þetta aðeins fyrir netþjón á þínu eigin neti.';

  @override
  String get accountSetupUseWithoutEncryption => 'Nota án dulkóðunar';

  @override
  String get accountSetupApiTokenRejected =>
      'API-tóka hafnað. Búðu til Fastmail API-tóka fyrir JMAP með aðgangi að tölvupósti og límdu hann inn.';

  @override
  String get accountSetupAppPasswordRejected => 'Lykilorði hafnað. Notaðu forritslykilorð, ekki lykilorð aðgangsins.';

  @override
  String get accountSetupPasswordRejected => 'Lykilorði hafnað. Athugaðu það og reyndu aftur.';

  @override
  String get accountSetupServerUnreachable =>
      'Ekki næst í netþjóninn. Athugaðu stillingar netþjónsins og tenginguna þína.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Skilríki netþjónsins eru ekki traust. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Hætt var við innskráninguna. Ýttu á „Skrá inn með $provider“ til að reyna aftur.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe þarf heimild til að lesa og senda Gmail-póstinn þinn. Skráðu þig inn aftur og leyfðu aðgang, með hakað í Gmail-reitinn.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe þarf heimild til að lesa og senda póstinn þinn. Skráðu þig inn aftur og samþykktu heimildirnar.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Fyrirtækið þitt þarf að samþykkja Loupe áður en þú getur notað það með þessum aðgangi. Biddu kerfisstjórann þinn um að veita stjórnandasamþykki fyrir Loupe í Microsoft Entra ID og reyndu svo aftur.';

  @override
  String get accountSetupOAuthBlocked =>
      'Innskráningarreglur fyrirtækisins þíns leyfa ekki Loupe í þessu tæki. Hafðu samband við kerfisstjórann þinn.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Ekki náðist í $provider. Athugaðu nettenginguna þína og reyndu aftur.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Innskráning með $provider er ekki rétt uppsett í þessari útgáfu Loupe. Vinsamlegast tilkynntu þetta.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Innskráning með $provider tókst ekki. Reyndu aftur.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider skráði þig inn, en Gmail hafnaði aðgangi fyrir þetta netfang. Veldu sama aðgang þegar þú skráir þig inn. Kerfisstjórar vinnu- eða skólaaðganga gætu hafa slökkt á IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider skráði þig inn, en póstþjónninn hafnaði aðgangi fyrir þetta netfang. Veldu sama aðgang þegar þú skráir þig inn. Kerfisstjórar vinnu- eða skólaaðganga gætu hafa slökkt á IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Ekki næst í póstþjóninn. Athugaðu tenginguna og reyndu aftur.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Innskráning með $provider er ekki í boði í þessari útgáfu.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Innskráning tókst. $account er að samstillast.';
  }

  @override
  String get accountSetupSignInAgain => 'Skrá inn aftur';

  @override
  String get accountSetupSigningIn => 'Skrái inn…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider samþykkir ekki lengur innskráningu Loupe fyrir $email, svo $account samstillist ekki. Skráðu þig inn aftur til að fá póstinn.';
  }

  @override
  String get accountImportTitle => 'Flytja inn úr Thunderbird';

  @override
  String get accountImportPointCamera => 'Beindu myndavélinni að QR-kóðanum sem Thunderbird sýnir.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned af $total skannaðir';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Skannað: $scanned af $total kóðum',
      one: 'Skannað: $scanned af $total kóða',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aðgangar hingað til',
      one: '$count aðgangur hingað til',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Opnaðu Thunderbird í tölvunni og veldu Verkfæri › Útflutningur fyrir farsíma. Veldu aðgangana þína og skannaðu svo hvern kóða sem birtist. Kóðana má skanna í hvaða röð sem er.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Halda áfram með $count aðganga',
      one: 'Halda áfram með $count aðgang',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Líma texta í staðinn';

  @override
  String get accountImportStartOver => 'Byrja upp á nýtt';

  @override
  String get accountImportDuplicateCode => 'Þessum kóða var þegar bætt við.';

  @override
  String get accountImportRestarted =>
      'Þessi kóði er úr nýjum útflutningi, svo kóðarnir sem voru skannaðir áður voru lagðir til hliðar.';

  @override
  String get accountImportNotThunderbird => 'Þetta er ekki aðgangskóði frá Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Þessi kóði kemur úr nýrri útgáfu af Thunderbird. Uppfærðu Loupe til að flytja hann inn.';

  @override
  String get accountImportDamaged => 'Ekki tókst að lesa þennan Thunderbird-kóða.';

  @override
  String get accountImportTooLarge => 'Þessi kóði er of stór til að vera útflutningur úr Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Ekki tókst að opna stillingar.';

  @override
  String get accountImportCameraOffTitle => 'Slökkt er á aðgangi að myndavél';

  @override
  String get accountImportCameraOffText =>
      'Leyfðu Loupe að nota myndavélina í stillingunum til að skanna kóðann, eða límdu inn texta kóðans í staðinn.';

  @override
  String get accountImportNoCameraTitle => 'Engin myndavél';

  @override
  String get accountImportNoCameraText => 'Loupe getur ekki notað myndavél hér. Límdu inn texta kóðans í staðinn.';

  @override
  String get accountImportCameraFailedTitle => 'Myndavélin ræstist ekki';

  @override
  String get accountImportCameraFailedText => 'Reyndu aftur, eða límdu inn texta kóðans í staðinn.';

  @override
  String get accountImportOpenSettings => 'Opna stillingar';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aðgangar fundust',
      one: '$count aðgangur fannst',
      zero: 'Engir aðgangar fundust',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ekki var hægt að lesa neinn af aðgöngunum í þessum kóðum.';

  @override
  String get accountImportChoose => 'Veldu aðgangana sem á að bæta við Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kóðar af $total voru ekki skannaðir (nr. $codes), svo aðgangar þeirra eru ekki á listanum.',
      one: '$count kóði af $total var ekki skannaður (nr. $codes), svo aðgangar hans eru ekki á listanum.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes og $last';
  }

  @override
  String get accountImportScanMore => 'Skanna fleiri kóða';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Ekki var hægt að lesa $count aðganga í kóðunum. Þeir gætu notað stillingar úr nýrri útgáfu af Thunderbird.',
      one: 'Ekki var hægt að lesa $count aðgang í kóðunum. Hann gæti notað stillingar úr nýrri útgáfu af Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skanna aftur';

  @override
  String get accountImportAlreadyAdded => 'Aðgangur með þessu netfangi er þegar í Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Þú skráir þig inn með $provider þegar honum er bætt við, eins og í Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Bættu aðganginum við með forritslykilorði (það krefst staðfestingar í tveimur skrefum).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird skráir sig inn í Gmail með Google. „Skrá inn með Google“ kemur í síðari útgáfu; þangað til skaltu bæta aðganginum við með forritslykilorði (það krefst staðfestingar í tveimur skrefum).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird skráir sig inn á þennan aðgang í vafranum. Loupe getur það ekki enn: notaðu forritslykilorð ef þjónustan þín býður upp á slíkt.';

  @override
  String get accountImportUnencrypted => 'Tengist án dulkóðunar. Notaðu þetta aðeins á þínu eigin neti.';

  @override
  String get accountImportEnterAgain => 'Sláðu það inn aftur';

  @override
  String get accountImportAdded => 'Bætt við';

  @override
  String accountImportAdding(int index, int total) {
    return 'Bæti við $index af $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bæta við $count aðgöngum',
      one: 'Bæta við $count aðgangi',
      zero: 'Bæta við aðgöngum',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Líma útflutningstexta';

  @override
  String get accountImportPasteText => 'Límdu inn texta útflutningskóða úr Thunderbird, einn kóða í hverja línu.';

  @override
  String get accountImportPop3 => 'POP3-aðgangar eru ekki studdir. Loupe geymir póstinn á netþjóninum með IMAP.';

  @override
  String get accountImportKerberos => 'Þessi aðgangur skráir sig inn með Kerberos, sem Loupe styður ekki.';

  @override
  String get accountImportNtlm => 'Þessi aðgangur skráir sig inn með NTLM, sem Loupe styður ekki.';

  @override
  String get accountImportClientCertificate =>
      'Þessi aðgangur skráir sig inn með biðlaraskilríkjum, sem Loupe styður ekki enn.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Innskráning með Microsoft kemur í síðari útgáfu. Outlook- og Microsoft 365-aðgangar taka ekki lengur við lykilorðum frá póstforritum.';

  @override
  String get accountImportEnterPassword => 'Sláðu inn lykilorðið.';

  @override
  String get accountImportEnterAppPassword => 'Sláðu inn forritslykilorðið.';

  @override
  String get accountImportEnterApiToken => 'Sláðu inn API-tókann.';

  @override
  String get accountImportStorageFailed => 'Loupe gat ekki opnað aðgangageymsluna sína. Reyndu aftur síðar.';

  @override
  String get accountImportFailed => 'Ekki tókst að bæta aðganginum við. Reyndu aftur eða bættu honum við handvirkt.';

  @override
  String get composeNewMessageTitle => 'Ný skilaboð';

  @override
  String get composeAttach => 'Hengja við';

  @override
  String get composeSendLater => 'Senda síðar';

  @override
  String composeSendAt(String time) {
    return 'Senda $time';
  }

  @override
  String get composeSendHint => 'Haltu inni til að senda síðar';

  @override
  String get composeNoAccount => 'Bættu við aðgangi til að senda póst.';

  @override
  String get composeTo => 'Til:';

  @override
  String get composeCc => 'Afrit:';

  @override
  String get composeBcc => 'Falið afrit:';

  @override
  String composeCcBccFrom(String email) {
    return 'Afrit/Falið afrit, Frá: $email';
  }

  @override
  String get composeFromLabel => 'Frá:';

  @override
  String get composeSubjectLabel => 'Efni:';

  @override
  String composeReplyTo(String address) {
    return 'Svara til: $address';
  }

  @override
  String get composeFrom => 'Frá';

  @override
  String composeReplyFrom(String email) {
    return 'Svara frá $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Senda frá $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Svara frá $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Senda frá $email?';
  }

  @override
  String get composeDismiss => 'Hunsa';

  @override
  String composeAliasNotSaved(String account) {
    return 'Ekki vistað sem auðkenni · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Vista sem auðkenni';

  @override
  String composeAliasSaved(String email) {
    return '$email er vistað sem auðkenni.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ógilt netfang $address';
  }

  @override
  String get composeOriginalNotFound => 'Upprunalegu skilaboðin fundust ekki.';

  @override
  String get composeDraftNotFound => 'Drögin fundust ekki.';

  @override
  String get composeAttachmentsLost => 'Ekki tókst að endurheimta viðhengin. Bættu þeim við aftur.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Ekki tókst að bæta sumum viðhengjum við: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Viðhengin eru samtals $size; sumir netþjónar hafna svona stórum skilaboðum.';
  }

  @override
  String get composeAttachFailed => 'Ekki tókst að hengja skrána við.';

  @override
  String get composeInvalidAddressTitle => 'Ógilt netfang';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ er ekki gilt netfang.';
  }

  @override
  String get composeNoSubjectTitle => 'Ekkert efni';

  @override
  String get composeNoSubjectText => 'Þessi skilaboð hafa ekkert efni. Senda samt?';

  @override
  String get composeSentBeforeChanges => 'Þau voru send áður en þú gerðir breytingarnar, sem eru vistaðar í Drögum.';

  @override
  String composeScheduled(String time) {
    return 'Tímasett: $time';
  }

  @override
  String get composeSending => 'Sendi…';

  @override
  String get composeSent => 'Sent';

  @override
  String get composeSendFailed => 'Ekki tókst að senda. Reyndu aftur.';

  @override
  String get composeAlreadySent => 'Þegar sent.';

  @override
  String get composeDiscardChanges => 'Henda breytingum';

  @override
  String get composeSaveChanges => 'Vista breytingar';

  @override
  String get composeDeleteDraft => 'Eyða drögum';

  @override
  String get composeSaveDraft => 'Vista drög';

  @override
  String get composeDraftSaved => 'Drög vistuð';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Þann $date kl. $time skrifaði $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Þann $date kl. $time skrifaði einhver:';
  }

  @override
  String get composeForwardHeader => '---------- Áframsend skilaboð ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Frá: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dagsetning: $date kl. $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Efni: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Til: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Afrit: $addresses';
  }

  @override
  String get composeLaterToday => 'Seinna í dag';

  @override
  String get composeTomorrowMorning => 'Í fyrramálið';

  @override
  String get composeMondayMorning => 'Á mánudagsmorgun';

  @override
  String get composePickDateTime => 'Velja dagsetningu og tíma…';

  @override
  String get composeSendWithoutDelay => 'Senda strax';

  @override
  String composeSendTimeToday(String time) {
    return 'Í dag kl. $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Á morgun kl. $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day kl. $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Í dag $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Á morgun $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Halda áfram með drögin?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Skilaboð voru ekki send þegar Loupe lokaðist.',
      'one': 'Skilaboð til $name voru ekki send þegar Loupe lokaðist.',
      'other': 'Skilaboð til $name og fleiri voru ekki send þegar Loupe lokaðist.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Skilaboðin „$subject“ voru ekki send þegar Loupe lokaðist.',
      'one': 'Skilaboðin „$subject“ til $name voru ekki send þegar Loupe lokaðist.',
      'other': 'Skilaboðin „$subject“ til $name og fleiri voru ekki send þegar Loupe lokaðist.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Halda áfram að breyta';

  @override
  String get composeRecoverySave => 'Vista í Drög';

  @override
  String get composeRecoveryDiscard => 'Henda';

  @override
  String get composeRecoverySaved => 'Vistað í Drög';

  @override
  String get outboxSectionFailed => 'Ekki sent';

  @override
  String get outboxSectionSending => 'Í sendingu';

  @override
  String get outboxSectionScheduled => 'Tímasett';

  @override
  String get outboxStatusQueued => 'Sendist bráðum';

  @override
  String get outboxStatusSending => 'Sendi…';

  @override
  String get outboxStatusFailed => 'Ekki sent';

  @override
  String get outboxNoRecipients => 'Engir viðtakendur';

  @override
  String get outboxNoSubject => '(Ekkert efni)';

  @override
  String get outboxSendingFailed => 'Sending mistókst.';

  @override
  String get outboxEmptyTitle => 'Ekkert að senda';

  @override
  String get outboxEmptyText => 'Skilaboð sem þú sendir síðar bíða hér þar til tími er kominn.';

  @override
  String get outboxSendNow => 'Senda núna';

  @override
  String get outboxReschedule => 'Breyta tíma';

  @override
  String get outboxRescheduleMenu => 'Breyta tíma…';

  @override
  String get outboxRescheduleTitle => 'Breyta tíma';

  @override
  String outboxRescheduled(String time) {
    return 'Nýr tími: $time';
  }

  @override
  String get outboxCancel => 'Hætta við';

  @override
  String get outboxCancelSending => 'Hætta við sendingu…';

  @override
  String get outboxCancelTitle => 'Hætta við sendingu?';

  @override
  String get outboxMoveToDrafts => 'Færa í Drög';

  @override
  String get outboxDiscard => 'Henda skilaboðum';

  @override
  String get outboxMovedToDrafts => 'Fært í Drög';

  @override
  String get outboxDiscarded => 'Skilaboðum hent';

  @override
  String get outboxAlreadySent => 'Þegar sent.';

  @override
  String get outboxBeingSent => 'Verið er að senda þessi skilaboð.';

  @override
  String get outboxActionFailed => 'Það tókst ekki. Skilaboðin eru enn í úthólfinu.';

  @override
  String get notificationsBadgeInboxes => 'Ólesið í innhólfum';

  @override
  String get notificationsBadgeVip => 'Ólesið í VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nýr póstur frá VIP-tengiliðunum þínum, í hvaða aðgangi sem er';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nýr póstur í $email';
  }

  @override
  String get notificationsUnknownSender => 'Óþekktur sendandi';

  @override
  String get notificationsNoSubject => '(Ekkert efni)';

  @override
  String get notificationsEncryptedMessage => 'Dulkóðuð skilaboð';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Ný skilaboð frá $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ný skilaboð',
      one: '$count ný skilaboð',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Ný skilaboð í $account';
  }

  @override
  String get platformInstantChannel => 'Tafarlaus afhending';

  @override
  String get platformInstantChannelDescription => 'Birtist á meðan Loupe fylgist með nýjum pósti í innhólfunum þínum';

  @override
  String get platformInstantTitle => 'Fylgist með nýjum pósti';

  @override
  String get platformInstantText => 'Kveikt er á tafarlausri afhendingu';

  @override
  String get platformErrorBox => 'Eitthvað fór úrskeiðis við að birta þetta. Farðu til baka og reyndu aftur.';

  @override
  String get welcomeTagline => 'Póstur sem er einfaldur á yfirborðinu\nog öflugur undir niðri.';

  @override
  String get welcomeAccountsTitle => 'Allir aðgangar, eitt rólegt innhólf';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail og hvaða IMAP- eða JMAP-netþjónn sem er.';

  @override
  String get welcomeSearchTitle => 'Leit sem finnur';

  @override
  String get welcomeSearchText => 'Tafarlausar niðurstöður úr símanum, síðan frá netþjóninum.';

  @override
  String get welcomePrivacyTitle => 'Persónuvernd frá grunni';

  @override
  String get welcomePrivacyText => 'Engin rakning. Fjartengdar myndir eru lokaðar þar til þú segir annað.';

  @override
  String get welcomeAddAccount => 'Bæta við aðgangi';

  @override
  String get welcomeImport => 'Flytja inn úr Thunderbird';

  @override
  String get welcomeTryDemo => 'Prófa með sýnipósti';
}
