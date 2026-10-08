// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class AppLocalizationsGa extends AppLocalizations {
  AppLocalizationsGa([String locale = 'ga']) : super(locale);

  @override
  String get commonAdd => 'Cuir leis';

  @override
  String get commonCancel => 'Cealaigh';

  @override
  String get commonClose => 'Dún';

  @override
  String get commonDelete => 'Scrios';

  @override
  String get commonDone => 'Déanta';

  @override
  String get commonEdit => 'Cuir in eagar';

  @override
  String get commonMore => 'Tuilleadh';

  @override
  String get commonMove => 'Bog';

  @override
  String get commonName => 'Ainm';

  @override
  String get commonNone => 'Dada';

  @override
  String get commonOff => 'As';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Ar siúl';

  @override
  String get commonOptional => 'Roghnach';

  @override
  String get commonPassword => 'Pasfhocal';

  @override
  String get commonRemove => 'Bain';

  @override
  String get commonRetry => 'Atriail';

  @override
  String get commonSave => 'Sábháil';

  @override
  String get commonSearch => 'Cuardaigh';

  @override
  String get commonServer => 'Freastalaí';

  @override
  String get commonSettings => 'Socruithe';

  @override
  String get commonShare => 'Comhroinn';

  @override
  String get commonTryAgain => 'Bain triail eile as';

  @override
  String get commonUndo => 'Cealaigh';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachtaireacht',
      many: '$count dteachtaireacht',
      few: '$count theachtaireacht',
      two: '$count theachtaireacht',
      one: '$count teachtaireacht',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Cartlannaigh';

  @override
  String get mailDelete => 'Scrios';

  @override
  String get mailFlag => 'Cuir bratach';

  @override
  String get mailForward => 'Seol ar aghaidh';

  @override
  String get mailMarkAsRead => 'Marcáil mar léite';

  @override
  String get mailMarkAsUnread => 'Marcáil mar neamhléite';

  @override
  String get mailMoveToJunk => 'Bog go dtí Turscar';

  @override
  String get mailNewMessage => 'Teachtaireacht nua';

  @override
  String get mailNoSubject => 'Gan ábhar';

  @override
  String get mailReply => 'Freagair';

  @override
  String get mailReplyAll => 'Freagair cách';

  @override
  String get mailSend => 'Seol';

  @override
  String get mailUnflag => 'Bain an bhratach';

  @override
  String get mailboxArchive => 'Cartlann';

  @override
  String get mailboxDrafts => 'Dréachtaí';

  @override
  String get mailboxInbox => 'Bosca Isteach';

  @override
  String get mailboxJunk => 'Turscar';

  @override
  String get mailboxOutbox => 'Bosca Amach';

  @override
  String get mailboxSent => 'Seolta';

  @override
  String get mailboxTrash => 'Bruscar';

  @override
  String get conversationSomethingWentWrong => 'Chuaigh rud éigin mícheart. Bain triail eile as.';

  @override
  String get conversationReplyToList => 'Freagair an liosta';

  @override
  String get conversationReplyList => 'Freagair liosta';

  @override
  String get conversationThreadMuted =>
      'Snáithe balbhaithe. Beidh teachtaireachtaí nua ann léite cheana nuair a thagann siad.';

  @override
  String get conversationThreadUnmuted => 'Snáithe díbhalbhaithe.';

  @override
  String get conversationLinkFailed => 'Níorbh fhéidir an nasc a oscailt.';

  @override
  String get conversationGoneTitle => 'Gan teachtaireacht';

  @override
  String get conversationGoneText => 'Bogadh nó scriosadh an teachtaireacht seo.';

  @override
  String get conversationMuted => 'Balbhaithe';

  @override
  String get conversationReaderOptions => 'Roghanna léitheoireachta';

  @override
  String get conversationReaderOptionsHint => 'Méid an téacs agus an t-amharc';

  @override
  String get conversationTrash => 'Cuir sa bhruscar';

  @override
  String get conversationReplyHint => 'Brúigh go fada le haghaidh Freagair cách agus Seol ar aghaidh';

  @override
  String get conversationOfflineTitle => 'Tá tú as líne';

  @override
  String get conversationOfflineText => 'Níl an comhrá seo íoslódáilte fós. Lódálfar é nuair a bheidh tú ar líne arís.';

  @override
  String get conversationErrorTitle => 'Ní féidir an teachtaireacht seo a thaispeáint';

  @override
  String get conversationErrorText => 'Chuaigh rud éigin mícheart.';

  @override
  String get conversationOfflineBanner => 'Tá tú as líne';

  @override
  String get conversationNotUpdated => 'Gan nuashonrú';

  @override
  String get conversationMe => 'mise';

  @override
  String get conversationNoSender => '(gan seoltóir)';

  @override
  String get conversationNoRecipients => 'gan faighteoirí';

  @override
  String conversationRecipients(String names) {
    return 'chuig $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'chuig $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Ó';

  @override
  String get conversationHeaderTo => 'Chuig';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Freagra chuig';

  @override
  String get conversationHeaderDate => 'Dáta';

  @override
  String get conversationHeaderSecurity => 'Slándáil';

  @override
  String get conversationVerifiedSender => 'Seoltóir fíoraithe';

  @override
  String get conversationUnverifiedSender => 'Seoltóir gan fíorú';

  @override
  String get conversationLoadingMessage => 'Teachtaireacht á lódáil';

  @override
  String get conversationBodyError => 'Níorbh fhéidir an teachtaireacht seo a lódáil.';

  @override
  String get conversationBodyOffline => 'Tá tú as líne. Lódálfar an teachtaireacht nuair a bheidh tú ar líne arís.';

  @override
  String get conversationOriginalHint => 'Is fearr a bhreathnaíonn sé san amharc Bunaidh';

  @override
  String get conversationShowOriginal => 'Taispeáin an bunleagan';

  @override
  String get conversationScrollToTop => 'Scrollaigh go dtí an barr';

  @override
  String get conversationTagsMenu => 'Clibeanna…';

  @override
  String get conversationMuteThread => 'Balbhaigh an snáithe';

  @override
  String get conversationUnmuteThread => 'Díbhalbhaigh an snáithe';

  @override
  String get conversationMoveMenu => 'Bog…';

  @override
  String get conversationDeletePermanently => 'Scrios go buan';

  @override
  String get conversationMoveToTrash => 'Bog go dtí an Bruscar';

  @override
  String get conversationNotJunk => 'Ní turscar é';

  @override
  String get conversationShowAllHeaders => 'Taispeáin gach ceanntásc';

  @override
  String get conversationViewSource => 'Féach ar an bhfoinse';

  @override
  String get conversationSaveAsFile => 'Sábháil mar chomhad…';

  @override
  String get conversationShareAsFile => 'Comhroinn mar chomhad…';

  @override
  String get conversationSearchFromMessageMenu => 'Cuardaigh ón teachtaireacht seo…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Cóipeáil an seoladh';

  @override
  String get conversationAddressCopied => 'Seoladh cóipeáilte';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Cuardaigh teachtaireachtaí ó $name';
  }

  @override
  String get conversationTags => 'Clibeanna';

  @override
  String get conversationAllHeaders => 'Gach ceanntásc';

  @override
  String get conversationCopyAll => 'Cóipeáil gach rud';

  @override
  String get conversationHeadersCopied => 'Ceanntáisc cóipeáilte';

  @override
  String get conversationNoHeaders => 'Gan cheanntáisc';

  @override
  String get conversationSearchFromMessageTitle => 'Cuardaigh ón teachtaireacht seo';

  @override
  String conversationSearchFrom(String name) {
    return 'Ó $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Chuig $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Ábhar “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Foinse';

  @override
  String get conversationSourceCopied => 'Foinse cóipeáilte';

  @override
  String get conversationShareFailed => 'Níorbh fhéidir an teachtaireacht a chomhroinnt.';

  @override
  String get conversationWrapLines => 'Timfhill línte';

  @override
  String get conversationDontWrapLines => 'Ná timfhill línte';

  @override
  String get conversationSourceError => 'Níorbh fhéidir an fhoinse a lódáil.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'An chéad $shown as $total á thaispeáint. Cóipeáil nó comhroinn é chun é ar fad a fháil.';
  }

  @override
  String get conversationAttachmentUntitled => 'Gan teideal';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Tuilleadh gníomhartha do $name';
  }

  @override
  String get conversationMoveTo => 'Bog go…';

  @override
  String get conversationMailboxesError => 'Níorbh fhéidir na boscaí poist a lódáil.';

  @override
  String get conversationReaderReadable => 'Inléite';

  @override
  String get conversationReaderOriginal => 'Bunaidh';

  @override
  String get conversationReaderPlain => 'Gnáth-théacs';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Coinnigh na dathanna bunaidh';

  @override
  String get conversationReaderRemember => 'Cuimhnigh don seoltóir seo';

  @override
  String get conversationSecurityPossiblePhishing => 'Fioscaireacht, b’fhéidir';

  @override
  String get conversationSecurityBeCareful => 'Bí cúramach';

  @override
  String get conversationSecurityVerified => 'Fíoraithe';

  @override
  String get conversationSecurityNoIssues => 'Níor aimsíodh fadhb ar bith';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rianaire',
      many: '$count rianaire',
      few: '$count rianaire',
      two: '$count rianaire',
      one: '$count rianaire',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Taispeánann sé an fáth';

  @override
  String get conversationPhishingBannerTitle => 'Tá cuma fhioscaireachta ar an teachtaireacht seo';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Tá naisc agus íomhánna múchta.';
  }

  @override
  String get conversationPhishingBannerText => 'Tá naisc agus íomhánna múchta.';

  @override
  String get conversationPhishingWhy => 'Cén fáth?';

  @override
  String get conversationPhishingShowAnyway => 'Taispeáin mar sin féin';

  @override
  String get conversationSecurityPhishingTitle => 'Tá cuma fhioscaireachta air seo';

  @override
  String get conversationSecurityPhishingText =>
      'Léiríonn roinnt comharthaí nach bhfuil an teachtaireacht seo mar a mhaíonn sí a bheith.';

  @override
  String get conversationSecurityCarefulTitle => 'Bí cúramach leis an teachtaireacht seo';

  @override
  String get conversationSecurityCarefulText => 'Is fiú súil eile a chaitheamh ar rud éigin inti.';

  @override
  String get conversationSecurityVerifiedText => 'Tá an seoltóir fíoraithe agus níl aon rud amhrasach le feiceáil.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Níl aon rud amhrasach le feiceáil. Níor dhúirt d’fhreastalaí ríomhphoist an bhfuil an seoltóir fíoraithe.';

  @override
  String get conversationSecurityNothingSuspicious => 'Níl aon rud amhrasach le feiceáil.';

  @override
  String get conversationSecurityWhy => 'Cén fáth';

  @override
  String get conversationSecurityPrivacy => 'Príobháideachas';

  @override
  String get conversationSecurityNoTrackingPixels => 'Gan picteilíní rianaithe';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Baineadh $count picteilín rianaithe',
      many: 'Baineadh $count bpicteilín rianaithe',
      few: 'Baineadh $count phicteilín rianaithe',
      two: 'Baineadh $count phicteilín rianaithe',
      one: 'Baineadh $count picteilín rianaithe',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'D’inseoidís don seoltóir cathain a d’oscail tú an teachtaireacht seo.';

  @override
  String get conversationSecurityNoRemoteImages => 'Gan íomhánna cianda';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count íomhá chianda',
      many: '$count n-íomhá chianda',
      few: '$count íomhá chianda',
      two: '$count íomhá chianda',
      one: '$count íomhá chianda',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Má lódáiltear iad, insítear don seoltóir cathain a léann tú an teachtaireacht seo, agus cad é do sheoladh IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Gan rianú cliceanna';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nasc trí rianairí cliceanna',
      many: '$count nasc trí rianairí cliceanna',
      few: '$count nasc trí rianairí cliceanna',
      two: '$count nasc trí rianairí cliceanna',
      one: '$count nasc trí rianairí cliceanna',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Thaifeadfadh $services do chliceáil. Brúigh go fada ar nasc chun a cheann scríbe a oscailt go díreach.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Sonraí teicniúla';

  @override
  String get conversationSecurityCheckedLocally => 'Seiceáilte ar an ngléas seo. Níor seoladh aon rud áit ar bith.';

  @override
  String get conversationSecurityTrackersLabel => 'Rianairí';

  @override
  String get conversationSecurityImagesFrom => 'Íomhánna ó';

  @override
  String get conversationSecuritySenderHistory => 'Stair an tseoltóra';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received faighte, $sent seolta';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Téann naisc chuig';

  @override
  String get conversationSecurityHidden => 'Folaithe';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements eilimint',
      many: '$elements n-eilimint',
      few: '$elements eilimint',
      two: '$elements eilimint',
      one: '$elements eilimint',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters carachtar',
      many: '$characters gcarachtar',
      few: '$characters charachtar',
      two: '$characters charachtar',
      one: '$characters carachtar',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Seoltóir gan fíorú';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Níorbh fhéidir le d’fhreastalaí ríomhphoist a dhearbhú gur ó $domain a tháinig an teachtaireacht seo i ndáiríre.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Níorbh fhéidir le d’fhreastalaí ríomhphoist a dhearbhú gur óna seoltóir a tháinig an teachtaireacht seo i ndáiríre.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Níorbh fhéidir le d’fhreastalaí ríomhphoist a dhearbhú gur ó $domain a tháinig an teachtaireacht seo. Tarlaíonn sé seo go minic le liostaí ríomhphoist.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Níorbh fhéidir le d’fhreastalaí ríomhphoist a dhearbhú gur óna seoltóir a tháinig an teachtaireacht seo. Tarlaíonn sé seo go minic le liostaí ríomhphoist.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Ná déan dada faoi mura raibh tú ag súil leis. Má tá amhras ort, déan teagmháil leis an seoltóir ar bhealach eile.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Sínithe ag fearann eile';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Tá an teachtaireacht sínithe ag $signer, ní ag $domain. Déanann seirbhísí ríomhphoist é seo, ach ní chruthaíonn sé cé a scríobh í.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Tá an teachtaireacht sínithe ag fearann eile, ní ag $domain. Déanann seirbhísí ríomhphoist é seo, ach ní chruthaíonn sé cé a scríobh í.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Taispeánann an t-ainm seoladh eile';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Is é “$shown” ainm an tseoltóra, ach tagann an teachtaireacht ó $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Cuir muinín sa seoladh, ní san ainm.';

  @override
  String get conversationSecurityReplyToTitle => 'Téann freagraí áit eile';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Dá bhfreagrófá, rachadh d’fhreagra chuig $address, ní chuig $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Seiceáil an seoladh sula gcuireann tú aon rud pearsanta i bhfreagra.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Úsáideann sé d’ainm';

  @override
  String get conversationSecurityImpersonationTitle => 'Úsáideann sé ainm duine a bhfuil aithne agat air';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Tá sé sínithe “$name”, cosúil le d’ainm féin, ach tagann sé ó sheoladh nua: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Tá sé sínithe “$name”, cosúil le do VIP $knownName ($knownEmail), ach tagann sé ó sheoladh nua: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Tá sé sínithe “$name”, cosúil le $knownName ($knownEmail), ach tagann sé ó sheoladh nua: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Agus rachadh freagraí chuig seoladh eile fós.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Má iarrann sé airgead, cóid nó comhaid, seiceáil leo ar bhealach eile ar dtús.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Seoladh aitheanta: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'An seoladh seo: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'An chéad teachtaireacht ón seoltóir seo';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Ní bhfuair tú ríomhphost ó $email riamh roimhe seo.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Bí cúramach le hiarratais ó dhaoine nach bhfuil aithne agat orthu fós.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Litreacha cosúla i seoladh an tseoltóra';

  @override
  String get conversationSecurityLinkHomographTitle => 'Litreacha cosúla i nasc';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Meascann $host litreacha ó aibítreacha éagsúla chun aithris a dhéanamh ar sheoladh eile.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Úsáideann $host litreacha atá cosúil le litreacha eile: ní $real é.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Scrios í nó tuairiscigh mar thurscar í.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ná hoscail é.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Fearann: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Fearann a bhfuil cuma fhearainn eile air';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Úsáideann sé ainm aitheanta ina fhearann';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Tá $domain cosúil le d’fhearann féin, $real, ach is fearann eile é.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Tá $domain cosúil le $brand ($real), ach is fearann eile é.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Úsáideann $domain ainm d’fhearainn féin, $real, ach ní bhaineann sé leis.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Úsáideann $domain ainm $brand ($real), ach ní bhaineann sé leis.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Tagann fíor-theachtaireachtaí ó d’eagraíocht ó $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Tagann fíor-theachtaireachtaí ó $brand ó $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Fearann an tseoltóra: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Aithris ar: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ceileann $count nasc cá dtéann siad',
      many: 'Ceileann $count nasc cá dtéann siad',
      few: 'Ceileann $count nasc cá dtéann siad',
      two: 'Ceileann $count nasc cá dtéann siad',
      one: 'Ceileann nasc cá dtéann sé',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Taispeánann nasc $shown, ach osclaíonn sé $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ná sínigh isteach agus ná híoc trí na naisc seo. Clóscríobh an seoladh tú féin ina ionad sin.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Ní féidir ceann scríbe naisc a sheiceáil';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Taispeánann nasc $shown, ach téann sé trí $host, a thaifeadann an cliceáil sula seolann sé ar aghaidh é.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Díríonn nasc ar sheoladh IP lom';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return 'Ní suíomh gréasáin le hainm é $hosts. Is annamh a nascann fíorchomhlachtaí mar seo.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Nasc faoi cheilt';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Tosaíonn nasc le “$shown@” ionas go mbeidh cuma $shown air, ach osclaíonn sé $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Díchumasaíodh leathanach folaithe';

  @override
  String get conversationSecurityDataLinkText =>
      'D’osclódh nasc leathanach atá pacáilte taobh istigh den teachtaireacht, bealach chun seiceálacha naisc a sheachaint.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Iarrann sé pasfhocal';

  @override
  String get conversationSecurityPasswordFieldText => 'Bhí réimse pasfhocail sa teachtaireacht. Bhain Loupe é.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Ná clóscríobh pasfhocal i ríomhphost choíche.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Díchumasaíodh nasc a ritheann cód';

  @override
  String get conversationSecurityScriptLinkText => 'Ní ritheann Loupe cód ó theachtaireachtaí riamh.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Naisc ghiorraithe',
      many: 'Naisc ghiorraithe',
      few: 'Naisc ghiorraithe',
      two: 'Naisc ghiorraithe',
      one: 'Nasc giorraithe',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return 'Ceileann $hosts an fíorcheann scríbe go dtí go n-osclaíonn tú é.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Seoladh gréasáin idirnáisiúnta';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return 'Úsáideann $hosts litreacha nach litreacha Laidine iad. Is gnách é sin i go leor teangacha; seiceáil gurb é an suíomh a bhfuil tú ag súil leis.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Go leor téacs folaithe';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Baineadh $count carachtar de théacs dofheicthe. Tá téacs folaithe mar seo ceaptha chun scagairí turscair a mhealladh.',
      many:
          'Baineadh $count gcarachtar de théacs dofheicthe. Tá téacs folaithe mar seo ceaptha chun scagairí turscair a mhealladh.',
      few:
          'Baineadh $count charachtar de théacs dofheicthe. Tá téacs folaithe mar seo ceaptha chun scagairí turscair a mhealladh.',
      two:
          'Baineadh $count charachtar de théacs dofheicthe. Tá téacs folaithe mar seo ceaptha chun scagairí turscair a mhealladh.',
      one:
          'Baineadh $count carachtar de théacs dofheicthe. Tá téacs folaithe mar seo ceaptha chun scagairí turscair a mhealladh.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Baineadh téacs folaithe';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Baineadh $count carachtar de théacs dofheicthe.',
      many: 'Baineadh $count gcarachtar de théacs dofheicthe.',
      few: 'Baineadh $count charachtar de théacs dofheicthe.',
      two: 'Baineadh $count charachtar de théacs dofheicthe.',
      one: 'Baineadh $count carachtar de théacs dofheicthe.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Níorbh fhéidir an teachtaireacht a íoslódáil. Seiceáil do cheangal agus bain triail eile as.';

  @override
  String exportSaved(String name) {
    return 'Sábháladh “$name”';
  }

  @override
  String get exportSaveFailed => 'Níorbh fhéidir an teachtaireacht a shábháil.';

  @override
  String exportFailed(String folder) {
    return 'Níorbh fhéidir “$folder” a easpórtáil.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Níl aon teachtaireacht in “$folder” le heaspórtáil.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Níorbh fhéidir “$folder” a easpórtáil: níorbh fhéidir aon teachtaireacht a íoslódáil. Seiceáil do cheangal agus bain triail eile as.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sábháladh “$name” gan $formattedCount teachtaireacht nárbh fhéidir a íoslódáil.',
      many: 'Sábháladh “$name” gan $formattedCount dteachtaireacht nárbh fhéidir a íoslódáil.',
      few: 'Sábháladh “$name” gan $formattedCount theachtaireacht nárbh fhéidir a íoslódáil.',
      two: 'Sábháladh “$name” gan $formattedCount theachtaireacht nárbh fhéidir a íoslódáil.',
      one: 'Sábháladh “$name” gan 1 teachtaireacht nárbh fhéidir a íoslódáil.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Níorbh fhéidir “$name” a shábháil.';
  }

  @override
  String exportTitle(String folder) {
    return '“$folder” á easpórtáil';
  }

  @override
  String get exportListing => 'Teachtaireachtaí á n-aimsiú…';

  @override
  String exportProgress(String current, String total) {
    return '$current as $total á easpórtáil…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Níorbh fhéidir $formattedCount teachtaireacht a íoslódáil',
      many: 'Níorbh fhéidir $formattedCount dteachtaireacht a íoslódáil',
      few: 'Níorbh fhéidir $formattedCount theachtaireacht a íoslódáil',
      two: 'Níorbh fhéidir $formattedCount theachtaireacht a íoslódáil',
      one: 'Níorbh fhéidir 1 teachtaireacht a íoslódáil',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Boscaí poist';

  @override
  String get mailboxesShown => 'Ar taispeáint';

  @override
  String get mailboxesHidden => 'I bhfolach';

  @override
  String get mailboxesCollapse => 'Laghdaigh';

  @override
  String get mailboxesExpand => 'Leathnaigh';

  @override
  String get mailboxesManageVips => 'Bainistigh VIPanna';

  @override
  String get mailboxesSubscriptions => 'Síntiúis';

  @override
  String mailboxesShowAccount(String account) {
    return 'Taispeáin $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Folaigh $account';
  }

  @override
  String get mailboxesExportFolder => 'Easpórtáil an fillteán…';

  @override
  String get mailboxesUnpin => 'Díphionnáil';

  @override
  String get mailboxesLists => 'Liostaí';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Sábháil cuardach chun é a choinneáil anseo.';

  @override
  String get mailboxesTags => 'Clibeanna';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter =>
      'Is féidir leat freisin ainm seoltóra a thapáil i dteachtaireacht agus VIP a chur ar siúl.';

  @override
  String get mailboxesAddVip => 'Cuir VIP leis…';

  @override
  String get mailboxesAddVipTitle => 'Cuir VIP leis';

  @override
  String get mailboxesAddVipText =>
      'Faigheann ríomhphost ón seoladh seo réalta agus taispeántar é sa bhosca poist VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Neamhléite';

  @override
  String get messageListFilterFlagged => 'Le bratach';

  @override
  String get messageListFilterToMe => 'Chuig: Mise';

  @override
  String get messageListFilterCcMe => 'Cc: Mise';

  @override
  String get messageListFilterWithAttachments => 'Le ceangaltáin';

  @override
  String get messageListFilterUnreplied => 'Gan freagra';

  @override
  String get messageListFilterFromVips => 'Ó VIPanna';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Marcáladh $count teachtaireacht mar léite',
      many: 'Marcáladh $count dteachtaireacht mar léite',
      few: 'Marcáladh $count theachtaireacht mar léite',
      two: 'Marcáladh $count theachtaireacht mar léite',
      one: 'Marcáladh 1 teachtaireacht mar léite',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Níorbh fhéidir ríomhphost níos sine a lódáil.';

  @override
  String get messageListSelectMessages => 'Roghnaigh teachtaireachtaí';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count roghnaithe',
      many: '$count roghnaithe',
      few: '$count roghnaithe',
      two: '$count roghnaithe',
      one: '$count roghnaithe',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Roghnaigh gach ceann';

  @override
  String get messageListDeselectAll => 'Díroghnaigh gach ceann';

  @override
  String get messageListLoadFailed => 'Níorbh fhéidir ríomhphost a lódáil';

  @override
  String get messageListNoUnread => 'Gan ríomhphost neamhléite';

  @override
  String get messageListNoMatches => 'Gan ríomhphost comhoiriúnach';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Scagtha de réir: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Múch an scagaire';

  @override
  String get messageListEmpty => 'Gan ríomhphost';

  @override
  String get messageListFilter => 'Scagaire';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Critéir scagtha: $filters';
  }

  @override
  String get messageListFilteredBy => 'Scagtha de réir:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount neamhléite',
      many: '$formattedCount neamhléite',
      few: '$formattedCount neamhléite',
      two: '$formattedCount neamhléite',
      one: '$formattedCount neamhléite',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marcáil';

  @override
  String get messageListTrash => 'Cuir sa bhruscar';

  @override
  String get messageListFilterTitle => 'Scagaire';

  @override
  String get messageListFilterInclude => 'CUIR SAN ÁIREAMH';

  @override
  String get panesHideMailboxes => 'Folaigh na boscaí poist';

  @override
  String get panesShowMailboxes => 'Taispeáin na boscaí poist';

  @override
  String get panesMailboxesWidth => 'Leithead na mboscaí poist';

  @override
  String get panesListWidth => 'Leithead liosta na dteachtaireachtaí';

  @override
  String get panesNoMessageSelected => 'Níl aon teachtaireacht roghnaithe';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachtaireacht',
      many: '$count dteachtaireacht',
      few: '$count theachtaireacht',
      two: '$count theachtaireacht',
      one: '1 teachtaireacht',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Ar athló';

  @override
  String get snoozeSheetTitle => 'Cuir ar athló';

  @override
  String get snoozeLaterToday => 'Níos déanaí inniu';

  @override
  String get snoozeThisEvening => 'Tráthnóna inniu';

  @override
  String get snoozeTomorrow => 'Amárach';

  @override
  String get snoozeThisWeekend => 'An deireadh seachtaine seo';

  @override
  String get snoozeNextWeek => 'An tseachtain seo chugainn';

  @override
  String get snoozePickDateTime => 'Roghnaigh dáta agus am…';

  @override
  String get snoozeMenu => 'Cuir ar athló…';

  @override
  String get snoozeWakeNow => 'Dúisigh anois';

  @override
  String get snoozeChangeTimeMenu => 'Athraigh am an athló…';

  @override
  String get snoozeChangeTime => 'Athraigh an t-am';

  @override
  String get snoozeNoTime => 'Níl am socraithe';

  @override
  String get snoozeFooter =>
      'Filleann teachtaireachtaí atá ar athló ar an mBosca Isteach, neamhléite, ag an am a socraíodh dóibh.';

  @override
  String get snoozeEmptyTitle => 'Níl aon rud ar athló';

  @override
  String get snoozeEmptyText =>
      'Cuir teachtaireacht ar athló chun go bhfillfidh sí ar an mBosca Isteach nuair a bheidh sí uait.';

  @override
  String get appLockUnlock => 'Díghlasáil';

  @override
  String get appLockFailed => 'Níorbh fhéidir le Loupe a dhearbhú gur tusa atá ann.';

  @override
  String get appLockLockedOut => 'An iomarca iarrachtaí. Bain triail eile as ar ball.';

  @override
  String get appLockPromptError => 'Níorbh fhéidir an fhuinneog fíordheimhnithe a thaispeáint. Bain triail eile as.';

  @override
  String get appLockNoScreenLock => 'Níl glas scáileáin ar an bhfón seo.';

  @override
  String get appLockUnlockPromptTitle => 'Díghlasáil Loupe';

  @override
  String get appLockUnlockPromptReason => 'Dearbhaigh gur tusa atá ann chun do ríomhphost a fheiceáil.';

  @override
  String get appLockTurnOnPromptTitle => 'Cuir Glas Aipe ar siúl';

  @override
  String get appLockTurnOnPromptReason => 'Dearbhaigh gur tusa atá ann chun Glas Aipe a chur ar siúl.';

  @override
  String get appLockScreenLockRemoved =>
      'Tá Glas Aipe as: níl glas scáileáin ar an bhfón seo a thuilleadh. Socraigh ceann chun Glas Aipe a chur ar siúl arís.';

  @override
  String get appLockAfterImmediately => 'Láithreach';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nóiméad',
      many: '$count nóiméad',
      few: '$count nóiméad',
      two: '$count nóiméad',
      one: '1 nóiméad',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uair an chloig',
      many: '$count n-uaire an chloig',
      few: '$count huaire an chloig',
      two: '$count uair an chloig',
      one: '1 uair an chloig',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Criptithe';

  @override
  String get openpgpEncryptedInPart => 'Criptithe go páirteach';

  @override
  String get openpgpEncryptedLocked => 'Criptithe · faoi ghlas';

  @override
  String get openpgpEncryptedNoKey => 'Criptithe · gan eochair';

  @override
  String get openpgpEncryptedDamaged => 'Criptithe · damáistithe';

  @override
  String get openpgpEncryptedUnsupported => 'Criptithe · gan tacaíocht';

  @override
  String get openpgpUnknownSigner => 'anaithnid';

  @override
  String get openpgpUnknownKey => 'Eochair anaithnid';

  @override
  String get openpgpSignatureInvalid => 'Síniú neamhbhailí';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Sínithe ag $name, ní ag an seoltóir';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Sínithe go páirteach ag $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Sínithe ag $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Sínithe le heochair dhiúltaithe';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Sínithe ag $name · eochair gan glacadh léi';
  }

  @override
  String get openpgpUnlock => 'Díghlasáil';

  @override
  String get openpgpCantDecrypt => 'Ní féidir an teachtaireacht seo a dhíchriptiú';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Criptithe le OpenPGP';

  @override
  String get openpgpEncryption => 'Criptiú';

  @override
  String get openpgpDecryptedHere => 'Díchriptithe ar an ngléas seo';

  @override
  String get openpgpNotDecrypted => 'Gan díchriptiú';

  @override
  String get openpgpKeyLocked => 'Tá d’eochair faoi ghlas.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Do na heochracha $keys',
      many: 'Do na heochracha $keys',
      few: 'Do na heochracha $keys',
      two: 'Do na heochracha $keys',
      one: 'Don eochair $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Ábhar cosanta';

  @override
  String get openpgpUnlockKey => 'Díghlasáil an eochair';

  @override
  String get openpgpSignature => 'Síniú';

  @override
  String get openpgpFingerprint => 'Méarlorg';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Aitheantas eochrach $id';
  }

  @override
  String get openpgpSigned => 'Sínithe';

  @override
  String get openpgpProblem => 'Fadhb';

  @override
  String get openpgpAcceptance => 'Glacadh';

  @override
  String get openpgpChangeAcceptance => 'Athraigh an glacadh…';

  @override
  String get openpgpCheckedFooter => 'Seiceáilte ar an ngléas seo le OpenPGP, comhoiriúnach le Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Tá d’eochair faoi ghlas. Díghlasáil í lena pasfhrása chun an teachtaireacht seo a léamh.';

  @override
  String get openpgpSummaryNoSecretKey => 'Criptíodh í d’eochair nach bhfuil ar an ngléas seo.';

  @override
  String get openpgpSummaryDamaged => 'Tá na sonraí criptithe damáistithe nó athraíodh iad ar an mbealach.';

  @override
  String get openpgpSummaryUnsupported => 'Úsáideann sí algartam nach dtacaíonn Loupe leis.';

  @override
  String get openpgpSummaryEncrypted => 'Ní féidir í a léamh ach agatsa agus ag na faighteoirí eile.';

  @override
  String get openpgpSummaryNotSigned => 'Níl sí sínithe, mar sin níl an seoltóir dearbhaithe.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Tá sí sínithe, ach le heochair nach bhfuil agat, mar sin ní féidir an síniú a sheiceáil.';

  @override
  String get openpgpSummaryBadSignature => 'Ní mheaitseálann an síniú: b’fhéidir gur athraíodh an teachtaireacht.';

  @override
  String get openpgpSummaryMismatch =>
      'Tá an síniú bailí, ach baineann an eochair le seoladh eile seachas seoladh an tseoltóra.';

  @override
  String get openpgpSummaryPartial =>
      'Níl ach cuid den teachtaireacht sínithe. Taispeántar téacs lasmuigh den síniú (buntásc liosta ríomhphoist, mar shampla) faoin líne “Unsigned content”, agus níl codanna eile den teachtaireacht, ar nós ceangaltán, clúdaithe ach oiread.';

  @override
  String get openpgpSummaryOwnKey => 'Sínithe le d’eochair féin.';

  @override
  String get openpgpSummaryVerified => 'Tá an síniú bailí, agus d’fhíoraigh tú méarlorg na heochrach.';

  @override
  String get openpgpSummaryUnverified => 'Tá an síniú bailí. Ghlac tú leis an eochair gan a méarlorg a sheiceáil.';

  @override
  String get openpgpSummaryRejected => 'Tá an síniú bailí, ach dhiúltaigh tú don eochair seo.';

  @override
  String get openpgpSummaryUndecided =>
      'Tá an síniú bailí, ach níor ghlac tú leis an eochair seo fós. Cuir a méarlorg i gcomparáid leis an seoltóir.';

  @override
  String get openpgpAcceptanceRejected => 'Diúltaithe';

  @override
  String get openpgpAcceptanceUndecided => 'Gan glacadh léi';

  @override
  String get openpgpAcceptanceUnverified => 'Glactha';

  @override
  String get openpgpAcceptanceVerified => 'Glactha agus fíoraithe';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Glacadh le heochair $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Méarlorg $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Glac léi, d’fhíoraigh mé an méarlorg';

  @override
  String get openpgpAcceptUnverified => 'Glac léi, gan seiceáil';

  @override
  String get openpgpAcceptLater => 'Ní fós';

  @override
  String get openpgpRejectKey => 'Diúltaigh don eochair seo';

  @override
  String get openpgpNoSubject => '(gan ábhar)';

  @override
  String get openpgpEncryptionTitle => 'Criptiú ó cheann go ceann';

  @override
  String get openpgpMyKeys => 'Mo chuid eochracha OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Le heochair, is féidir leat ríomhphost criptithe a léamh agus do chuid ríomhphoist féin a shíniú agus a chriptiú. An úsáideann tú Thunderbird? Easpórtáil d’eochair ansin (Socruithe Cuntais › Criptiú ó Cheann go Ceann › Easpórtáil Eochair Rúnda) agus iompórtáil anseo í.';

  @override
  String get openpgpAddKey => 'Cuir eochair leis…';

  @override
  String get openpgpAddresses => 'Seoltaí';

  @override
  String get openpgpAddressesFooter =>
      'An eochair a úsáideann gach seoladh, agus cathain a chriptíonn agus a shíníonn sé.';

  @override
  String get openpgpCorrespondentsKeys => 'Eochracha OpenPGP do chomhfhreagraithe';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Glac le heochair nuair atá muinín agat gur lena húinéir í; cuir an méarlorg i gcomparáid leo chun í a mharcáil mar fhíoraithe.';

  @override
  String get openpgpImportPublicKey => 'Iompórtáil eochair phoiblí…';

  @override
  String get openpgpCollected => 'Bailithe ó Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Eochracha a tháinig le teachtaireachtaí. Is féidir le Loupe criptiú chucu nuair a iarrann an dá thaobh é.';

  @override
  String get openpgpOnThisDevice => 'Ar an ngléas seo';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Ceileann teachtaireachtaí criptithe a n-ábhar. Coinníonn Loupe ábhar gach teachtaireachta a osclaíonn tú ina bhunachar sonraí criptithe ar an ngléas seo, ionas go dtaispeánann an liosta, an cuardach agus na fógraí é. Sa chúlra, is féidir le Loupe ábhair teachtaireachtaí nua a dhíchriptiú freisin le heochracha nach bhfuil pasfhrása acu; íoslódálann sé gach teachtaireacht (suas le 1 MB) chuige sin.';

  @override
  String get openpgpDecryptSubjects => 'Díchriptigh ábhair sa chúlra';

  @override
  String get openpgpIndexFooter =>
      'Aimsíonn an cuardach teachtaireachtaí criptithe de réir a seoltóra, a bhfaighteoirí agus a n-ábhair. Nuair atá sé seo ar siúl, cuireann Loupe téacs gach teachtaireachta criptithe a dhíchriptíonn sé leis an innéacs cuardaigh ina bhunachar sonraí criptithe ar an ngléas seo freisin, ionas go n-aimsíonn an cuardach í de réir a téacs freisin. Má mhúchann tú é, bainfear an téacs sin den innéacs.';

  @override
  String get openpgpIndexDecrypted => 'Innéacsaigh teachtaireachtaí díchriptithe don chuardach';

  @override
  String get openpgpPassphrases => 'Pasfhrásaí';

  @override
  String get openpgpPassphrasesFooter =>
      'Díghlasáiltear eochracha OpenPGP agus teastais S/MIME a chosnaíonn tú le pasfhrása nuair is gá. Gan “Cuimhnigh ar phasfhrásaí”, cuirtear faoi ghlas arís iad dhá nóiméad tar éis gach úsáide.';

  @override
  String get openpgpRememberPassphrases => 'Cuimhnigh ar phasfhrásaí';

  @override
  String get openpgpRememberPassphrasesDetail => 'Go dtí go ndúnann Loupe';

  @override
  String get openpgpLockKeysNow => 'Cuir na heochracha faoi ghlas anois';

  @override
  String get openpgpKeysLocked => 'Eochracha faoi ghlas.';

  @override
  String get openpgpKeyStateRevoked => 'cúlghairthe';

  @override
  String get openpgpKeyStateExpired => 'imithe as feidhm';

  @override
  String get openpgpKeyStateNeverExpires => 'ní théann as feidhm choíche';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'téann as feidhm $date';
  }

  @override
  String get openpgpNoKey => 'Gan eochair';

  @override
  String get openpgpAlwaysEncrypt => 'Criptigh i gcónaí';

  @override
  String get openpgpAddKeyTitle => 'Cuir eochair OpenPGP leis';

  @override
  String get openpgpAddKeyMessage => 'Iompórtáil an eochair a úsáideann tú in Thunderbird, nó cruthaigh ceann nua.';

  @override
  String get openpgpImportFromClipboard => 'Iompórtáil ón ngearrthaisce';

  @override
  String get openpgpImportFromFile => 'Iompórtáil ó chomhad';

  @override
  String get openpgpGenerateNewKey => 'Gin eochair nua';

  @override
  String get openpgpImportPublicKeyTitle => 'Iompórtáil eochair phoiblí';

  @override
  String get openpgpFromClipboard => 'Ón ngearrthaisce';

  @override
  String get openpgpFromFile => 'Ó chomhad';

  @override
  String get openpgpClipboardEmpty => 'Tá an ghearrthaisce folamh. Cóipeáil an eochair ar dtús.';

  @override
  String get openpgpKey => 'Eochair';

  @override
  String get openpgpValidityRevoked => 'Cúlghairthe';

  @override
  String openpgpValidityExpired(String date) {
    return 'Imithe as feidhm $date';
  }

  @override
  String get openpgpNeverExpires => 'Ní théann as feidhm choíche';

  @override
  String openpgpValidUntil(String date) {
    return 'Bailí go dtí $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Méarlorg cóipeáilte.';

  @override
  String get openpgpAlgorithm => 'Algartam';

  @override
  String get openpgpCreated => 'Cruthaithe';

  @override
  String get openpgpValidity => 'Bailíocht';

  @override
  String get openpgpProtection => 'Cosaint';

  @override
  String get openpgpProtectionPassphrase => 'Pasfhrása';

  @override
  String get openpgpProtectionKeychain => 'Slabhra eochrach amháin';

  @override
  String get openpgpKeyDetailsFooter =>
      'Comhroinn d’eochair phoiblí ionas gur féidir le daoine eile criptiú chugat. Is é an cúltaca d’eochair rúnda, cosanta ag a pasfhrása má tá ceann aici: coinnigh príobháideach é.';

  @override
  String get openpgpSharePublicKey => 'Comhroinn an eochair phoiblí';

  @override
  String get openpgpCopyPublicKey => 'Cóipeáil an eochair phoiblí';

  @override
  String get openpgpPublicKeyCopied => 'Eochair phoiblí cóipeáilte.';

  @override
  String get openpgpBackUpSecretKey => 'Déan cúltaca den eochair rúnda';

  @override
  String get openpgpDeleteKey => 'Scrios an eochair';

  @override
  String get openpgpRemoveKey => 'Bain an eochair';

  @override
  String get openpgpBackUpTitle => 'Cúltaca a dhéanamh den eochair rúnda?';

  @override
  String get openpgpBackUpProtected =>
      'Tá an cúltaca cosanta ag pasfhrása d’eochrach. Is féidir le duine ar bith a bhfuil an dá rud aige do ríomhphost a léamh.';

  @override
  String get openpgpBackUpUnprotected =>
      'Níl pasfhrása ag an eochair seo: is féidir le duine ar bith a bhfuil an cúltaca aige do ríomhphost a léamh agus síniú i d’ainm.';

  @override
  String get openpgpBackUp => 'Déan cúltaca';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'D’eochair $name a scriosadh?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Eochair $name a bhaint?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Ní féidir ríomhphost a criptíodh don eochair seo a léamh ar an ngléas seo a thuilleadh, mura n-iompórtálann tú arís í.';

  @override
  String get openpgpRemoveKeyMessage => 'Is féidir leat í a iompórtáil arís níos déanaí.';

  @override
  String get openpgpKeyHeader => 'Eochair OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Cuir eochair leis in Criptiú ó cheann go ceann chun ríomhphost ón seoladh seo a chriptiú agus a shíniú.';

  @override
  String get openpgpGenerateAKey => 'Gin eochair…';

  @override
  String get openpgpSending => 'Seoladh';

  @override
  String get openpgpSendingFooter =>
      'Cuirtear criptiú uathoibríoch ar siúl nuair a bhíonn eochair ghlactha nó teastas iontaofa ag gach faighteoir, nó nuair a deir Autocrypt gur mian leis an dá thaobh é. Sínítear ríomhphost criptithe i gcónaí.';

  @override
  String get openpgpEncryptAutomatically => 'Criptigh go huathoibríoch';

  @override
  String get openpgpAlwaysEncryptDetail => 'Diúltaíonn sé seoladh nuair nach bhfuil eochair ag faighteoir';

  @override
  String get openpgpSignUnencrypted => 'Sínigh ríomhphost neamhchriptithe';

  @override
  String get openpgpAttachPublicKey => 'Ceangail m’eochair phoiblí';

  @override
  String get openpgpAutocryptFooter =>
      'Seolann Autocrypt d’eochair phoiblí le gach teachtaireacht, ionas gur féidir le haipeanna eile criptiú chugat gan aon socrú.';

  @override
  String get openpgpSendMyKey => 'Seol m’eochair le ríomhphost';

  @override
  String get openpgpPreferEncryption => 'B’fhearr liom criptiú';

  @override
  String get openpgpPreferEncryptionDetail => 'Iarr ar dhaoine eile criptiú nuair is féidir leo';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bliain',
      many: '$count mbliana',
      few: '$count bliana',
      two: '$count bhliain',
      one: '1 bhliain',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Ní mheaitseálann na pasfhrásaí.';

  @override
  String openpgpKeyReady(String id) {
    return 'Tá d’eochair $id réidh.';
  }

  @override
  String get openpgpNewKey => 'Eochair nua';

  @override
  String get openpgpNewKeyFor => 'Do';

  @override
  String get openpgpYourName => 'D’ainm';

  @override
  String get openpgpAddress => 'Seoladh';

  @override
  String get openpgpPassphrase => 'Pasfhrása';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Roghnach. Gan ceann, ní chosnaíonn ach slabhra eochrach d’fhóin an eochair agus ní iarrann Loupe é choíche. Le ceann, iarrann Loupe é nuair a theastaíonn an eochair.';

  @override
  String get openpgpRepeatPassphrase => 'Arís';

  @override
  String get openpgpExpires => 'Téann as feidhm';

  @override
  String get openpgpExpiresFooter =>
      'Is féidir leat eochair nua a dhéanamh sula dtéann sí as feidhm. Úsáideann Thunderbird trí bliana freisin.';

  @override
  String get openpgpGenerateKey => 'Gin eochair';

  @override
  String get openpgpKeyFor => 'Eochair do';

  @override
  String get openpgpCantEncrypt => 'Ní féidir criptiú';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Níl eochair OpenPGP ann do $names, agus criptíonn an seoladh seo i gcónaí. Bain an faighteoir, nó iompórtáil a n-eochair in Socruithe › Criptiú ó cheann go ceann.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Níl teastas S/MIME bailí ann do $names, agus criptíonn an seoladh seo i gcónaí. Bain an faighteoir, nó iompórtáil a dteastas in Socruithe › Criptiú ó cheann go ceann.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Níl eochair OpenPGP ann do $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Níl teastas S/MIME bailí ann do $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Seol gan chriptiú';

  @override
  String get openpgpCantSign => 'Ní féidir síniú';

  @override
  String get openpgpCantSignMessage =>
      'Níl eochair phríobháideach do theastais S/MIME ar an ngléas seo. Iompórtáil an teastas arís (comhad .p12 nó .pfx) in Socruithe › Criptiú ó cheann go ceann.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Gan eochair do $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Gan teastas do $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Eochracha ó Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Tá eochair ag gach duine';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Tá teastas ag gach duine';

  @override
  String get openpgpComposeEncrypt => 'Criptigh';

  @override
  String get openpgpComposeSign => 'Sínigh';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, athraigh';
  }

  @override
  String get openpgpNoKeyFound => 'Níor aimsíodh eochair OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Eochair rúnda a iompórtáil?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Tá eochair rúnda sa cheangaltán seo ($names). Ná hiompórtáil í mar d’eochair féin ach amháin má d’easpórtáil tú féin í, ó Thunderbird mar shampla.';
  }

  @override
  String get openpgpImportAsMyKey => 'Iompórtáil mar m’eochair';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'd’eochair $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eochair ($names) a iompórtáil?',
      many: '$count n-eochair ($names) a iompórtáil?',
      few: '$count eochair ($names) a iompórtáil?',
      two: '$count eochair ($names) a iompórtáil?',
      one: 'Eochair $names a iompórtáil?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Iompórtáil agus glac leo';

  @override
  String get openpgpImportDecideLater => 'Iompórtáil, cinneadh níos déanaí';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'eochair $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Iompórtáladh $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tá $count eochair OpenPGP ceangailte.',
      many: 'Tá $count n-eochair OpenPGP ceangailte.',
      few: 'Tá $count eochair OpenPGP ceangailte.',
      two: 'Tá $count eochair OpenPGP ceangailte.',
      one: 'Tá eochair OpenPGP ceangailte.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Iompórtáil';

  @override
  String get openpgpUnlockKeyTitle => 'Díghlasáil eochair OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Cuir isteach pasfhrása eochair $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Tá an pasfhrása sin mícheart. Bain triail eile as.';

  @override
  String get openpgpExplainLocked => 'Tá an teachtaireacht seo criptithe. Díghlasáil d’eochair OpenPGP chun í a léamh.';

  @override
  String get openpgpExplainNoKey =>
      'Tá an teachtaireacht seo criptithe, ach ní d’aon eochair OpenPGP ar an ngléas seo. Má léann tú in Thunderbird í, iompórtáil d’eochair as sin: Socruithe › Criptiú ó cheann go ceann.';

  @override
  String get openpgpExplainDamaged =>
      'Tá damáiste déanta don teachtaireacht chriptithe seo, mar sin ní féidir í a dhíchriptiú go sábháilte.';

  @override
  String get openpgpExplainUnsupported => 'Úsáideann an teachtaireacht seo criptiú nach féidir le Loupe a léamh fós.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Tá an teachtaireacht seo criptithe le S/MIME, ach ní d’aon teastas ar an ngléas seo. Iompórtáil do theastas (comhad .p12 nó .pfx) in Socruithe › Criptiú ó cheann go ceann.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Tá an teachtaireacht seo criptithe. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Díghlasáil do theastas S/MIME chun í a léamh.';

  @override
  String get openpgpAttachmentGone => 'Níl an ceangaltán seo ar fáil a thuilleadh.';

  @override
  String get smimeEncrypted => 'Criptithe (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Criptithe (S/MIME) · gan teastas';

  @override
  String get smimeEncryptedDamaged => 'Criptithe (S/MIME) · damáistithe';

  @override
  String get smimeEncryptedUnsupported => 'Criptithe (S/MIME) · gan tacaíocht';

  @override
  String get smimeEncryptedLocked => 'Criptithe (S/MIME) · faoi ghlas';

  @override
  String get smimeUnknownSigner => 'anaithnid';

  @override
  String get smimeSignatureModified => 'Síniú neamhbhailí: athraíodh an teachtaireacht';

  @override
  String get smimeSignatureWeak => 'Síniú neamhshlán: algartam as dáta';

  @override
  String get smimeSignatureUncheckable => 'Ní féidir an síniú a sheiceáil';

  @override
  String get smimeSignedCertificateMissing => 'Sínithe · teastas ar iarraidh';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Sínithe ag $name · teastas cúlghairthe';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Sínithe ag $name · ar dháta eile';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Sínithe ag $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Sínithe ag $name · teastas neamhbhailí';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Sínithe ag $name · neamhiontaofa';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Sínithe ag $name · teastas imithe as feidhm';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Sínithe ag $name · teastas nach bhfuil bailí fós';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Sínithe ag $name · teastas nach bhfuil do ríomhphost';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Sínithe ag $name, ní ag an seoltóir';
  }

  @override
  String get smimeCantDecrypt => 'Ní féidir an teachtaireacht seo a dhíchriptiú';

  @override
  String get smimeEncryptedWithSmime => 'Criptithe le S/MIME';

  @override
  String get smimeEncryption => 'Criptiú';

  @override
  String get smimeDecryptedHere => 'Díchriptithe ar an ngléas seo';

  @override
  String get smimeNotDecrypted => 'Gan díchriptiú';

  @override
  String get smimeAuthenticated => 'fíordheimhnithe';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'do $count teastas',
      many: 'do $count dteastas',
      few: 'do $count theastas',
      two: 'do $count theastas',
      one: 'do 1 teastas',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Síniú';

  @override
  String get smimeIssuedBy => 'Eisithe ag';

  @override
  String get smimeValid => 'Bailí';

  @override
  String smimeValidRange(String from, String to) {
    return '$from go $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Méarlorg SHA-256';

  @override
  String get smimeSigned => 'Sínithe';

  @override
  String get smimeProblem => 'Fadhb';

  @override
  String get smimeCheckingRevocation => 'Cúlghairm á seiceáil…';

  @override
  String get smimeNotRevoked => 'Gan chúlghairm';

  @override
  String get smimeRevoked => 'Cúlghairthe';

  @override
  String get smimeRevocationUnknown => 'Cúlghairm anaithnid';

  @override
  String smimeRevokedSince(String date) {
    return 'Ó $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Fiafraíodh den údarás (a liosta cúlghairme), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Fiafraíodh den údarás (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Cuir muinín in “$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Cuir muinín sa teastas seo…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Seiceáilte ar an ngléas seo le S/MIME, comhoiriúnach le Outlook agus Thunderbird; cúlghairm leis an údarás deimhnithe.';

  @override
  String get smimeCheckedFooter =>
      'Seiceáilte ar an ngléas seo le S/MIME, comhoiriúnach le Outlook agus Thunderbird. Ní sheiceáiltear cúlghairm (Socruithe › Criptiú ó cheann go ceann).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Muinín a chur in $name do ríomhphost?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Muinín a chur i dteastas $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Beidh muinín as gach teastas a eisíonn an t-údarás seo, cosúil le CA do chomhlachta. Cuir an méarlorg i gcomparáid lena úinéir ar dtús:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Cuir an méarlorg i gcomparáid lena úinéir ar dtús:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Cuir muinín ann';

  @override
  String get smimeSummaryNoKey => 'Criptíodh í do theastas nach bhfuil ar an ngléas seo.';

  @override
  String get smimeSummaryDamaged => 'Tá na sonraí criptithe damáistithe nó athraíodh iad ar an mbealach.';

  @override
  String get smimeSummaryUnsupported => 'Úsáideann sí algartam nach dtacaíonn Loupe leis.';

  @override
  String get smimeSummaryLocked => 'Tá do theastas S/MIME faoi ghlas.';

  @override
  String get smimeSummaryEncrypted => 'Ní féidir í a léamh ach agatsa agus ag na faighteoirí eile.';

  @override
  String get smimeSummaryNotSigned => 'Níl sí sínithe, mar sin níl an seoltóir dearbhaithe.';

  @override
  String get smimeSummaryModified => 'Ní mheaitseálann an síniú: athraíodh an teachtaireacht tar éis í a shíniú.';

  @override
  String get smimeSummaryUncheckable => 'Ní féidir an síniú a sheiceáil.';

  @override
  String get smimeSummaryNoCertificate =>
      'Níl teastas an tsínitheora sa teachtaireacht, mar sin ní féidir é a sheiceáil.';

  @override
  String get smimeSummaryRevoked =>
      'Chúlghair an t-údarás deimhnithe teastas an tsínitheora: ní féidir muinín a bheith agat as an síniú.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Chúlghair an t-údarás deimhnithe teastas an tsínitheora ($reason): ní féidir muinín a bheith agat as an síniú.';
  }

  @override
  String get smimeDateMismatch =>
      'Síníodh í níos mó ná uair an chloig ó dháta na teachtaireachta: b’fhéidir gur seanteachtaireacht í a seoladh arís.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Tá an síniú bailí, agus dearbhaíonn $issuer gur leis an seoltóir an teastas.';
  }

  @override
  String get smimeProblemInvalidChain => 'Tá an teastas nó ceann dá eisitheoirí neamhbhailí.';

  @override
  String get smimeProblemUntrusted => 'Tagann an teastas ó údarás nach bhfuil muinín ag Loupe as.';

  @override
  String get smimeProblemExpired => 'Bhí an teastas imithe as feidhm.';

  @override
  String get smimeProblemNotYetValid => 'Ní raibh an teastas bailí fós.';

  @override
  String get smimeProblemWrongUsage => 'Níl an teastas ceaptha do ríomhphost.';

  @override
  String get smimeProblemWrongAddress => 'Baineann an teastas le seoladh eile seachas seoladh an tseoltóra.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Iontaofa · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Neamhiontaofa · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Imithe as feidhm $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Bailí ó $date';
  }

  @override
  String get smimeTrustInvalid => 'Neamhbhailí';

  @override
  String get smimeTrustNotForMail => 'Ní do ríomhphost';

  @override
  String get smimeTrustAnotherAddress => 'Seoladh eile';

  @override
  String get smimeMyCertificates => 'Mo theastais S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Le haghaidh S/MIME, mar a úsáideann Outlook agus go leor comhlachtaí é. Iompórtáil do theastas lena eochair phríobháideach (comhad .p12 nó .pfx), easpórtáilte ó Outlook, Windows, macOS nó Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Le haghaidh S/MIME, mar a úsáideann Outlook agus go leor comhlachtaí é. Iompórtáil do theastas lena eochair phríobháideach (comhad .p12 nó .pfx), easpórtáilte ó Outlook, Windows, macOS nó Thunderbird, nó úsáid ceann a shuiteáil do chomhlacht nó tú féin ar an ngléas seo.';

  @override
  String get smimeCertificateExpired => 'imithe as feidhm';

  @override
  String smimeCertificateUntil(String date) {
    return 'go dtí $date';
  }

  @override
  String get smimeCertificateOnDevice => 'ar an ngléas seo';

  @override
  String get smimeImportCertificateEllipsis => 'Iompórtáil teastas…';

  @override
  String get smimeUseDeviceCertificate => 'Úsáid teastas ón ngléas seo…';

  @override
  String get smimeCorrespondentsCertificates => 'Teastais do chomhfhreagraithe';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Bailithe ó ríomhphost sínithe, mar a dhéanann Outlook agus Thunderbird. Ní chriptítear ríomhphost ach do theastais iontaofa: bíonn muinín ag Loupe as na húdaráis a bhfuil muinín ag Mozilla astu don ríomhphost, agus as na cinn a chuireann tú leis.';

  @override
  String get smimeRevocation => 'Cúlghairm';

  @override
  String get smimeRevocationFooter =>
      'Nuair a osclaíonn tú ríomhphost sínithe, fiafraíonn Loupe den údarás a d’eisigh teastas an tsínitheora ar cúlghaireadh é (trína fhreagróir OCSP, nó trína liosta cúlghairme). Is féidir leis an údarás a fheiceáil ansin cathain a léann duine ag do sheoladh idirlín ríomhphost atá sínithe leis an teastas sin. Coinnítear freagraí ar an ngléas seo go dtí go dtéann siad as feidhm. Taispeántar teastas cúlghairthe mar “Cúlghairthe” i gceanntásc na teachtaireachta.';

  @override
  String get smimeCheckRevocation => 'Seiceáil cúlghairm teastas ar líne';

  @override
  String get smimeTrustedAuthorities => 'Údaráis iontaofa';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Iontaofa duitse, chomh maith leis na $count údarás a bhfuil muinín ag Mozilla astu don ríomhphost.',
      many: 'Iontaofa duitse, chomh maith leis na $count n-údarás a bhfuil muinín ag Mozilla astu don ríomhphost.',
      few: 'Iontaofa duitse, chomh maith leis na $count údarás a bhfuil muinín ag Mozilla astu don ríomhphost.',
      two: 'Iontaofa duitse, chomh maith leis an $count údarás a bhfuil muinín ag Mozilla astu don ríomhphost.',
      one: 'Iontaofa duitse, chomh maith leis an $count údarás a bhfuil muinín ag Mozilla astu don ríomhphost.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Údarás deimhnithe';

  @override
  String get smimeImportACertificate => 'Iompórtáil teastas';

  @override
  String get smimeImportContactMessage => 'Teastas comhfhreagraí (.cer, .crt, .pem) nó teastas údaráis deimhnithe.';

  @override
  String get smimeFromClipboard => 'Ón ngearrthaisce';

  @override
  String get smimeFromFile => 'Ó chomhad';

  @override
  String get smimeClipboardEmpty => 'Tá an ghearrthaisce folamh. Cóipeáil an teastas ar dtús.';

  @override
  String get smimeCertificate => 'Teastas';

  @override
  String get smimeOnDeviceFooter =>
      'Fanann a eochair phríobháideach i stóras dintiúr Android, áit ar shuiteáil do chomhlacht nó tú féin é: iarrann Loupe ar Android síniú agus díchriptiú leis. Sínítear ríomhphost sínithe nuair a sheolann tú é.';

  @override
  String get smimeAddresses => 'Seoltaí';

  @override
  String get smimeUsage => 'Le haghaidh';

  @override
  String get smimeUsageNone => 'Rud ar bith a úsáideann Loupe';

  @override
  String get smimeUsageSigning => 'Síniú';

  @override
  String get smimeUsageEncryption => 'Criptiú';

  @override
  String get smimeUsageCertificates => 'Teastais';

  @override
  String get smimeAlgorithm => 'Algartam';

  @override
  String get smimeSerialNumber => 'Sraithuimhir';

  @override
  String get smimeFingerprintCopied => 'Méarlorg cóipeáilte.';

  @override
  String get smimeSha1Thumbprint => 'Ordlorg SHA-1';

  @override
  String get smimePrivateKey => 'Eochair phríobháideach';

  @override
  String get smimeKeyOnDevice => 'Ar an ngléas seo';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'In Loupe, le pasfhrása';

  @override
  String get smimeKeyInLoupe => 'In Loupe';

  @override
  String get smimeSource => 'Ó';

  @override
  String get smimeSourceSignedMail => 'Ríomhphost sínithe';

  @override
  String get smimeSourceImported => 'Iompórtáilte';

  @override
  String get smimeTrustHeader => 'Muinín';

  @override
  String get smimeTrustedRoot => 'Fréamh iontaofa';

  @override
  String get smimeIssuer => 'Eisitheoir';

  @override
  String smimeTrustNamed(String name) {
    return 'Cuir muinín in “$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Cuir muinín san údarás seo';

  @override
  String get smimeTrustThisCertificate => 'Cuir muinín sa teastas seo';

  @override
  String get smimeStopTrusting => 'Ná cuir muinín ann níos mó';

  @override
  String get smimePassphrase => 'Pasfhrása';

  @override
  String get smimePassphraseFooter =>
      'Roghnach. Le pasfhrása, criptítear an eochair phríobháideach ar an ngléas seo freisin (Argon2id agus AES-256), agus iarrann Loupe é chun síniú agus díchriptiú; socraíonn Cuimhnigh ar phasfhrásaí cá fhad. Sínítear ríomhphost a sheolann tú nuair a sheolann tú é; ní féidir le hobair sa chúlra an eochair a úsáid.';

  @override
  String get smimeChangePassphrase => 'Athraigh an pasfhrása…';

  @override
  String get smimeSetPassphraseEllipsis => 'Socraigh pasfhrása…';

  @override
  String get smimeRemovePassphrase => 'Bain an pasfhrása';

  @override
  String get smimeShareCertificate => 'Comhroinn an teastas';

  @override
  String get smimeDeleteCertificate => 'Scrios an teastas';

  @override
  String get smimeRemoveCertificate => 'Bain an teastas';

  @override
  String get smimePassphraseChanged => 'Athraíodh an pasfhrása.';

  @override
  String get smimePassphraseSet => 'Socraíodh an pasfhrása.';

  @override
  String get smimeRemovePassphraseTitle => 'An pasfhrása a bhaint?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Ansin ní chosnaíonn ach an slabhra eochrach an eochair phríobháideach, mar a bheadh gan phasfhrása: ní iarrann Loupe é níos mó, agus is féidir le hobair sa chúlra í a úsáid.';

  @override
  String get smimePassphraseRemoved => 'Baineadh an pasfhrása.';

  @override
  String smimeTrustTitle(String name) {
    return 'Muinín a chur in $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Beidh muinín as gach teastas a eisíonn sé don ríomhphost. Cuir an méarlorg i gcomparáid lena úinéir ar dtús:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Do theastas $name a scriosadh?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Teastas $name a bhaint?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Stopann Loupe é a úsáid: ní féidir ríomhphost a criptíodh dó a léamh in Loupe a thuilleadh. Fanann an teastas ar an ngléas seo (Socruithe › Slándáil › Criptiú agus dintiúir).';

  @override
  String get smimeDeleteOwnMessage =>
      'Scriostar a eochair phríobháideach ón ngléas seo: ní féidir ríomhphost a criptíodh dó a léamh anseo a thuilleadh, mura n-iompórtálann tú arís é.';

  @override
  String get smimeRemoveContactMessage => 'Tagann sé ar ais lena gcéad teachtaireacht shínithe eile.';

  @override
  String get smimeAddressImportFooter =>
      'Iompórtáil teastas don seoladh seo chun síniú agus criptiú le S/MIME, mar a dhéanann Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Iompórtáil teastas…';

  @override
  String get smimePreferFooter =>
      'Nuair is féidir leis an dá cheann teachtaireacht a chosaint, úsáidtear an ceann is fearr leat, mura bhfuil eochair nó teastas ag an gceann eile amháin do gach faighteoir.';

  @override
  String get smimePreferSmime => 'B’fhearr liom S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Seachas OpenPGP';

  @override
  String get smimeCertificatePassword => 'Pasfhocal an teastais';

  @override
  String get smimeCertificatePasswordPrompt => 'Cuir isteach an pasfhocal lenar easpórtáladh comhad an teastais.';

  @override
  String get smimeImport => 'Iompórtáil';

  @override
  String get smimeWrongPassword => 'Tá an pasfhocal sin mícheart. Bain triail eile as.';

  @override
  String get smimeNoCertificateFound => 'Níor aimsíodh teastas.';

  @override
  String smimeCertificateOf(String name) {
    return 'teastas $name';
  }

  @override
  String get smimeNothingNew => 'Níl aon rud nua le hiompórtáil.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Iompórtáladh $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Iompórtáladh $count údarás iontaofa.',
      many: 'Iompórtáladh $count n-údarás iontaofa.',
      few: 'Iompórtáladh $count údarás iontaofa.',
      two: 'Iompórtáladh $count údarás iontaofa.',
      one: 'Iompórtáladh údarás iontaofa.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Iompórtáladh $certificates agus $count údarás iontaofa.',
      many: 'Iompórtáladh $certificates agus $count n-údarás iontaofa.',
      few: 'Iompórtáladh $certificates agus $count údarás iontaofa.',
      two: 'Iompórtáladh $certificates agus $count údarás iontaofa.',
      one: 'Iompórtáladh $certificates agus údarás iontaofa.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Níl eochair phríobháideach sa chomhad seo. Easpórtáil do theastas lena eochair phríobháideach.';

  @override
  String get smimeImportAsYoursTitle => 'Iompórtáil mar do theastas?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Tá teastas lena eochair phríobháideach sa cheangaltán seo: $names. Ná hiompórtáil é ach amháin má d’easpórtáil tú féin é, ó Outlook nó Thunderbird mar shampla.';
  }

  @override
  String get smimeImportAsMine => 'Iompórtáil mar mo theastas';

  @override
  String smimeImportedOwn(String names) {
    return 'Iompórtáladh do theastas $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Cuireadh do theastas $name ($addresses) leis ón ngléas seo.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Muinín a chur in “$name” do ríomhphost?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Níl aithne ag Loupe ar an údarás deimhnithe seo (údarás comhlachta féin, b’fhéidir). Cuir muinín ann chun na teastais a eisíonn sé a sheiceáil. Cuir a mhéarlorg i gcomparáid le do roinn TF ar dtús:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tá $count teastas ceangailte.',
      many: 'Tá $count dteastas ceangailte.',
      few: 'Tá $count theastas ceangailte.',
      two: 'Tá $count theastas ceangailte.',
      one: 'Tá teastas ceangailte.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Iompórtáil an teastas';

  @override
  String get smimeUnlockTitle => 'Díghlasáil teastas S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Cuir isteach pasfhrása theastas $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Tá an pasfhrása sin mícheart. Bain triail eile as.';

  @override
  String get smimeUnlock => 'Díghlasáil';

  @override
  String get smimeEnterAPassphrase => 'Cuir isteach pasfhrása.';

  @override
  String get smimePassphrasesDiffer => 'Tá an dá phasfhrása difriúil.';

  @override
  String get smimeSetPassphraseTitle => 'Socraigh pasfhrása';

  @override
  String get smimeSetPassphraseText =>
      'Iarrfaidh Loupe é chun síniú agus díchriptiú. Má dhéanann tú dearmad air, iompórtáil an teastas arís óna chomhad .p12.';

  @override
  String get smimePassphraseAgain => 'Arís';

  @override
  String get smimeSetPassphraseButton => 'Socraigh';

  @override
  String get smimeLockedOpenAgain =>
      'Tá do theastas S/MIME faoi ghlas. Oscail an teachtaireacht arís chun é a dhíghlasáil.';

  @override
  String get smimeDeviceHasNoCertificates => 'Ní thairgeann an gléas seo a chuid teastas.';

  @override
  String get smimeCantReadCertificate => 'Ní féidir le Loupe an teastas seo a léamh.';

  @override
  String get smimeCertificateNotForMail =>
      'Níl an teastas seo do ríomhphost: níl seoladh ríomhphoist ann, nó níl sé ceaptha do shíniú nó do chriptiú.';

  @override
  String get smimeDeviceCertificateGone =>
      'Níl an teastas ar an ngléas seo a thuilleadh, nó b’fhéidir nach féidir le Loupe é a úsáid níos mó. Roghnaigh arís é in Socruithe › Criptiú ó cheann go ceann.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Ní féidir an teastas ar an ngléas seo a úsáid ach amháin nuair atá Loupe oscailte.';

  @override
  String get smimeDeviceKeyDamaged => 'Tá an eochair chriptithe damáistithe.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Ní féidir leis an teastas ar an ngléas seo é seo a dhéanamh: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'gan tacaíocht';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Theip ar an teastas ar an ngléas seo: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Ní seoladh gréasáin é seoladh an údaráis.';

  @override
  String get smimeAuthorityTimeout => 'Níor fhreagair an t-údarás deimhnithe in am.';

  @override
  String get smimeAuthorityUnreachable => 'Níorbh fhéidir teagmháil a dhéanamh leis an údarás deimhnithe.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'D’fhreagair an t-údarás deimhnithe $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Tá freagra an údaráis dheimhnithe rómhór.';

  @override
  String get smimeRevocationNotChecked =>
      'Gan seiceáil: ní sheiceáiltear ach teastais ó údarás a bhfuil muinín ag Loupe as.';

  @override
  String get settingsLanguage => 'Teanga';

  @override
  String get settingsLanguageSystem => 'Mar an gcéanna leis an bhfón';

  @override
  String get settingsLanguageFooter =>
      'Úsáideann Loupe teanga d’fhóin nuair atá sí aige, agus Béarla nuair nach bhfuil. Is do Loupe amháin an teanga a roghnaíonn tú anseo, fógraí san áireamh.';

  @override
  String get settingsAccountsHeader => 'Cuntais';

  @override
  String get settingsAddAccount => 'Cuir cuntas leis';

  @override
  String get settingsMailHeader => 'Ríomhphost';

  @override
  String get settingsSwipeActions => 'Gníomhartha svaidhpeála';

  @override
  String get settingsSwipeLeft => 'Svaidhpeáil ar chlé';

  @override
  String get settingsSwipeLeftFooter =>
      'Ritheann svaidhpeáil iomlán an gníomh seo. Níl Cuir bratach agus Tuilleadh ach svaidhpeáil ghearr uait i gcónaí.';

  @override
  String get settingsSwipeRight => 'Svaidhpeáil ar dheis';

  @override
  String get settingsSwipeRightFooter => 'Ritheann svaidhpeáil iomlán an gníomh seo.';

  @override
  String get settingsSwipeToggleRead => 'Marcáil mar léite / neamhléite';

  @override
  String get settingsSwipeTrash => 'Cuir sa bhruscar';

  @override
  String get settingsSwipeMove => 'Bog an teachtaireacht';

  @override
  String get settingsSwipeSnooze => 'Cuir ar athló';

  @override
  String get settingsThreaded => 'Eagraigh de réir comhrá';

  @override
  String get settingsUndoSendDelay => 'Moill chun seoladh a chealú';

  @override
  String get settingsUndoSendDelayFooter =>
      'Fanann teachtaireachtaí seolta an fad seo, ionas gur féidir leat iad a tharraingt siar.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds soicind',
      many: '$seconds soicind',
      few: '$seconds shoicind',
      two: '$seconds shoicind',
      one: '1 soicind',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Cuma';

  @override
  String get settingsTheme => 'Téama';

  @override
  String get settingsThemeSystem => 'Uathoibríoch';

  @override
  String get settingsThemeLight => 'Geal';

  @override
  String get settingsThemeDark => 'Dorcha';

  @override
  String get settingsDensity => 'Liosta teachtaireachtaí';

  @override
  String get settingsDensityComfortable => 'Compordach';

  @override
  String get settingsDensityCompact => 'Dlúth';

  @override
  String get settingsReadingHeader => 'Léamh';

  @override
  String get settingsReadingFooter =>
      'Is féidir le híomhánna cianda a insint do sheoltóirí cathain agus cén áit ar oscail tú teachtaireacht.';

  @override
  String get settingsDefaultView => 'Amharc réamhshocraithe';

  @override
  String get settingsDefaultViewFooter => 'Is féidir leat aon teachtaireacht a athrú leis an gcnaipe Aa.';

  @override
  String get settingsViewReadable => 'Inléite';

  @override
  String get settingsViewReadableDetail => 'Glan, soléite, leanann sé an mód dorcha';

  @override
  String get settingsViewOriginal => 'Bunaidh';

  @override
  String get settingsViewOriginalDetail => 'Díreach mar a dhear an seoltóir é';

  @override
  String get settingsViewPlain => 'Gnáth-théacs';

  @override
  String get settingsViewPlainDetail => 'Na focail amháin';

  @override
  String get settingsPlainTextFont => 'Cló gnáth-théacs';

  @override
  String get settingsFontSans => 'Sans Serif';

  @override
  String get settingsFontMono => 'Aonleithid';

  @override
  String get settingsFontMonoDetail => 'Coinníonn sé líníocht ASCII agus táblaí ailínithe';

  @override
  String get settingsTechnicalLists => 'Liostaí teicniúla';

  @override
  String get settingsLoadRemoteImages => 'Lódáil íomhánna cianda';

  @override
  String get settingsOpenLinksDirectly => 'Oscail naisc go díreach';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Seachain rianairí cliceanna nuair is eol an ceann scríbe';

  @override
  String get settingsSecurityHeader => 'Slándáil';

  @override
  String get settingsAppLock => 'Glas Aipe';

  @override
  String get settingsAppLockFooterOn =>
      'Iarrann Loupe nuair a thosaíonn sé, agus nuair a fhilleann tú tar éis a bheith ar shiúl ar feadh am Cuir faoi ghlas tar éis.';

  @override
  String get settingsAppLockFooterOff =>
      'Iarrann Glas Aipe do mhéarlorg, d’aghaidh nó do ghlas scáileáin sula dtaispeántar do ríomhphost.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Tá Glas Aipe as fós. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Socraigh paschód';

  @override
  String get settingsScreenLockTextIos =>
      'Úsáideann Glas Aipe Face ID, Touch ID nó do phaschód, agus níl paschód ar an iPhone seo. Socraigh ceann san aip Settings, agus ansin cuir Glas Aipe ar siúl.';

  @override
  String get settingsScreenLockTitleAndroid => 'Socraigh glas scáileáin';

  @override
  String get settingsScreenLockTextAndroid =>
      'Úsáideann Glas Aipe glas scáileáin d’fhóin, nó méarlorg nó aghaidh a cuireadh leis, agus níl ceann ar bith ar an bhfón seo. Socraigh PIN, patrún nó pasfhocal i socruithe Android, agus ansin cuir Glas Aipe ar siúl.';

  @override
  String get settingsOpenSystemSettings => 'Oscail Socruithe';

  @override
  String get settingsOpenAndroidSettings => 'Oscail socruithe Android';

  @override
  String get settingsLockAfter => 'Cuir faoi ghlas tar éis';

  @override
  String get settingsLockAfterFooter => 'An fad is féidir le Loupe a bheith sa chúlra sula n-iarrann sé arís.';

  @override
  String get settingsNotifications => 'Fógraí';

  @override
  String get settingsEncryption => 'Criptiú ó cheann go ceann';

  @override
  String get settingsAdvanced => 'Ardsocruithe';

  @override
  String get settingsDemoHeader => 'Taispeántas';

  @override
  String get settingsDemoFooter =>
      'Is bosca poist samhailteach é an ríomhphost taispeántais nach bhfuil ach ar an bhfón seo. Ní sheoltar aon rud áit ar bith.';

  @override
  String get settingsDemoMode => 'Mód taispeántais';

  @override
  String get settingsResetApp => 'Athshocraigh an aip';

  @override
  String get settingsResetFooter => 'Déanann sé dearmad ar gach socrú agus filleann sé ar an scáileán fáilte.';

  @override
  String get settingsResetTitle => 'Loupe a athshocrú?';

  @override
  String get settingsResetMessage =>
      'Déanann sé seo dearmad ar gach socrú, gach Smart Mailbox agus gach cuardach le déanaí, agus filleann sé ar an scáileán fáilte.';

  @override
  String get settingsAboutHeader => 'Maidir le';

  @override
  String get settingsVersion => 'Leagan';

  @override
  String get settingsLicences => 'Ceadúnais';

  @override
  String get settingsPrivacy => 'Príobháideachas';

  @override
  String get settingsPrivacyDetail =>
      'Níl anailísíocht ná rianú ar bith in Loupe. Ní théann do ríomhphost ach chuig d’fhreastalaithe ríomhphoist.';

  @override
  String get settingsNotificationsOffIos => 'Tá fógraí as do Loupe in Settings.';

  @override
  String get settingsNotificationsOffAndroid => 'Tá fógraí as do Loupe i Socruithe Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return 'Ní ligeann $system do Loupe fógraí a thaispeáint. Ceadaigh iad i Socruithe.';
  }

  @override
  String get settingsNewMailHeader => 'Ríomhphost nua';

  @override
  String get settingsNewMailFooterDemo =>
      'Ní thagann ríomhphost taispeántais sa chúlra. Seol fógra tástála le feiceáil conas a bhreathnaíonn ríomhphost nua.';

  @override
  String get settingsNewMailFooterIos =>
      'Seiceálann Loupe le haghaidh ríomhphoist nua sa chúlra nuair a ligeann iOS dó, agus d’fhéadfadh uaireanta an chloig a bheith eatarthu d’aipeanna nach n-osclaíonn tú go minic. Cuirtear in iúl duit faoi theachtaireachtaí nua i do bhoscaí isteach, agus ó VIPanna in aon fhillteán.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Seiceálann Loupe le haghaidh ríomhphoist nua timpeall gach 15 nóiméad, nuair a cheadaíonn Android é. Cuirtear in iúl duit faoi theachtaireachtaí nua i do bhoscaí isteach, agus ó VIPanna in aon fhillteán.';

  @override
  String get settingsNoAccounts => 'Gan chuntais';

  @override
  String get settingsVipOnly => 'VIP amháin';

  @override
  String get settingsVipOnlyDetail => 'Teachtaireachtaí ó do VIPanna amháin';

  @override
  String get settingsHideContent => 'Folaigh an t-ábhar';

  @override
  String get settingsHideContentFooterOn =>
      'Ní deir fógraí ach “Teachtaireacht nua ó” agus an cuntas, ní cé a scríobh ná cad faoi.';

  @override
  String get settingsHideContentFooterOff =>
      'Coinníonn Folaigh an t-ábhar an seoltóir, an t-ábhar agus an réamhamharc den scáileán glasála agus as fógraí.';

  @override
  String get settingsBackgroundAppRefresh => 'Athnuachan aipe sa chúlra';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Ní thagann ríomhphost nua sa chúlra ach nuair atá Athnuachan aipe sa chúlra ar siúl do Loupe in Settings. Ní féidir le iOS ceangal le do bhoscaí isteach a choinneáil oscailte, mar sin níl Seachadadh láithreach ann.';

  @override
  String get settingsInstantDelivery => 'Seachadadh láithreach';

  @override
  String get settingsInstantDeliveryFooter =>
      'Coinníonn Seachadadh láithreach (turgnamhach) ceangal le do bhoscaí isteach oscailte, ionas go dtagann ríomhphost nua laistigh de shoicindí. Taispeánann sé fógra ciúin “Ag faire ar ríomhphost nua” agus úsáideann sé níos mó ceallra.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'D’fhéadfadh Android Seachadadh láithreach a stopadh chun ceallra a spáráil. Lig do Loupe an ceallra a úsáid gan srianta chun é a choinneáil ag rith.';

  @override
  String get settingsExperimental => 'Turgnamhach';

  @override
  String get settingsComingSoon => 'Ar fáil go luath';

  @override
  String get settingsAllowUnrestrictedBattery => 'Ceadaigh úsáid ceallra gan srian';

  @override
  String get settingsPush => 'Brú';

  @override
  String get settingsPushFooter =>
      'Ligeann Brú do ríomhphost nua Loupe a dhúiseacht láithreach, nuair a thacaíonn do sheirbhís ríomhphoist leis. Téann brúnna trí sheirbhís bhrú Google agus ní iompraíonn siad ríomhphost ar bith, ach “seiceáil anois” amháin.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ní féidir leis an bhfón seo brúnna a fháil: teastaíonn seirbhísí Google Play agus ceangal líonra uathu. Seiceálann Loupe le haghaidh ríomhphoist timpeall gach 15 nóiméad fós.';

  @override
  String get settingsCopyPushToken => 'Cóipeáil an comhartha brú';

  @override
  String get settingsPushTokenCopied => 'Comhartha brú cóipeáilte';

  @override
  String get settingsSendTestNotification => 'Seol fógra tástála';

  @override
  String get settingsAppIconBadge => 'Suaitheantas ar dheilbhín na haipe';

  @override
  String get settingsBadgeNote =>
      'Nuashonraítear an suaitheantas gach uair a sheiceálann Loupe le haghaidh ríomhphoist, sa chúlra freisin.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Ní thaispeánann scáileán baile an fhóin seo uimhreacha ar dheilbhíní aipeanna. Nuashonraítear an suaitheantas gach uair a sheiceálann Loupe le haghaidh ríomhphoist, sa chúlra freisin.';

  @override
  String get settingsTestNotificationBody => 'Seo an chuma atá ar fhógraí faoi ríomhphost nua.';

  @override
  String get settingsAccountRemoved => 'Baineadh an cuntas seo.';

  @override
  String get settingsAccountHeader => 'Cuntas';

  @override
  String get settingsAccountDescription => 'Cur síos';

  @override
  String get settingsAccountDescriptionHint => 'Obair, Pearsanta…';

  @override
  String get settingsEmail => 'Ríomhphost';

  @override
  String get settingsColour => 'Dath';

  @override
  String get settingsColourFooter => 'Marcálann sé teachtaireachtaí an chuntais seo in Gach Bosca Isteach.';

  @override
  String settingsColourNumber(int number) {
    return 'Dath $number';
  }

  @override
  String get settingsSendingHeader => 'Seoladh';

  @override
  String get settingsSendingFooter =>
      'Tá a síniú féin ag gach aitheantas. Seoltar freagraí ón seoladh ar seoladh an teachtaireacht chuige.';

  @override
  String get settingsFoldersHeader => 'Fillteáin';

  @override
  String get settingsFoldersFooter =>
      'Taispeánann agus sioncrónaíonn Loupe na fillteáin a bhfuil tú liostáilte leo, mar a dhéanann Thunderbird. Taispeántar Bosca Isteach, Dréachtaí, Seolta, Turscar, Bruscar agus Cartlann i gcónaí.';

  @override
  String get settingsShowAllFolders => 'Taispeáin gach fillteán';

  @override
  String get settingsIncoming => 'Isteach';

  @override
  String get settingsOutgoing => 'Amach';

  @override
  String get settingsConnectionNotEncrypted => 'Gan chriptiú';

  @override
  String get settingsSignIn => 'Síniú isteach';

  @override
  String get settingsSignInExpired => 'Imithe as feidhm';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return 'Ní ghlacann $provider le síniú isteach Loupe don chuntas seo a thuilleadh, mar sin níl a ríomhphost á shioncrónú. Sínigh isteach arís chun é a dheisiú.';
  }

  @override
  String get settingsSignInAgain => 'Sínigh isteach arís';

  @override
  String get settingsSigningIn => 'Ag síniú isteach…';

  @override
  String get settingsRemoveAccount => 'Bain an cuntas';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '“$account” a bhaint?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Baintear a ríomhphost agus a shocruithe den fhón seo. Ní scriostar aon rud ar an bhfreastalaí.';

  @override
  String get settingsManageFolders => 'Bainistigh fillteáin';

  @override
  String get settingsNoFolders => 'Gan fillteáin fós.';

  @override
  String get settingsManageFoldersFooter =>
      'Taispeántar fillteáin liostáilte ar an scáileán Boscaí poist agus sioncrónaítear iad sa chúlra. De ghnáth leanann aipeanna ríomhphoist eile ar an gcuntas céanna na liostálacha seo freisin.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Coinníonn sé na Smart Mailboxes atá agat do do ghléasanna eile. I bhfolach ar an scáileán Boscaí poist.';

  @override
  String get settingsFolderAlwaysShown => 'Ar taispeáint i gcónaí';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Liostáil le $folder';
  }

  @override
  String get settingsIdentities => 'Aitheantais';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Is é an chéad aitheantas an réamhshocrú do theachtaireachtaí nua. Tarraing chun an t-ord a athrú.';

  @override
  String get settingsIdentitiesFooterSingle => 'An t-aitheantas réamhshocraithe do theachtaireachtaí nua.';

  @override
  String get settingsIdentitiesReplyFooter => 'Seoltar freagra ón aitheantas ar seoladh an teachtaireacht chuige.';

  @override
  String get settingsIdentityDefault => 'Réamhshocrú';

  @override
  String settingsIdentityReorder(String email) {
    return 'Athordaigh $email';
  }

  @override
  String get settingsAddIdentity => 'Cuir aitheantas leis';

  @override
  String get settingsNewIdentity => 'Aitheantas nua';

  @override
  String get settingsIdentity => 'Aitheantas';

  @override
  String get settingsIdentityNameHint => 'D’ainm';

  @override
  String get settingsReplyTo => 'Freagra chuig';

  @override
  String get settingsSignature => 'Síniú';

  @override
  String get settingsSignatureFooter => 'Curtha faoi “-- ” i dteachtaireachtaí ón aitheantas seo.';

  @override
  String get settingsNoSignature => 'Gan síniú';

  @override
  String get settingsCopyToMyself => 'Cóip chugam féin';

  @override
  String get settingsCopyToMyselfFooter => 'Curtha le gach teachtaireacht ón aitheantas seo.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Úsáid le haghaidh freagraí chuig';

  @override
  String get settingsReplyPatternsFooter =>
      'Seoltar freagraí ar theachtaireachtaí a seoladh chuig na seoltaí seo ón aitheantas seo. Seasann * do rud ar bith: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Seoladh, nó patrún ina seasann * do rud ar bith.';

  @override
  String get settingsAddReplyPattern => 'Cuir seoladh nó patrún leis';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Bain $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Patrún neamhbhailí';

  @override
  String settingsInvalidPatternMessage(String input) {
    return 'Ní seoladh ná patrún cosúil le *@example.com é “$input”.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Gan seoladh';

  @override
  String get settingsIdentityNoAddressMessage => 'Cuir isteach an seoladh ríomhphoist le seoladh uaidh.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Seoladh neamhbhailí';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Ní seoladh ríomhphoist bailí é Freagra chuig “$address”.',
      'cc': 'Ní seoladh ríomhphoist bailí é Cc “$address”.',
      'bcc': 'Ní seoladh ríomhphoist bailí é Bcc “$address”.',
      'other': 'Ní seoladh ríomhphoist bailí é “$address”.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Sábháil an t-aitheantas';

  @override
  String get settingsDiscardChanges => 'Caith na hathruithe uait';

  @override
  String get settingsDeleteIdentity => 'Scrios an t-aitheantas';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '“$email” a scriosadh?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Fanann teachtaireachtaí a seoladh uaidh cheana mar atá siad.';

  @override
  String get settingsLastIdentityFooter => 'Tá aitheantas amháin ar a laghad de dhíth ar chuntas.';

  @override
  String get rulesTitle => 'Rialacha';

  @override
  String get rulesNewRule => 'Riail nua';

  @override
  String get rulesLoadError => 'Níorbh fhéidir na rialacha a lódáil.';

  @override
  String get rulesEmptyTitle => 'Gan rialacha';

  @override
  String get rulesEmptyText =>
      'Comhdaíonn, clibeálann agus cuireann rialacha bratach ar ríomhphost nua duit. Déan ceann leis an gcnaipe cumadóireachta thuas, nó ó chuardach le “Déan riail de seo”.';

  @override
  String get rulesListFooter =>
      'Ritheann rialacha ó bharr go bun ar ríomhphost nua sa Bhosca Isteach. Brúigh agus coinnigh riail chun í a bhogadh.';

  @override
  String get rulesChangeError => 'Níorbh fhéidir an riail a athrú';

  @override
  String get rulesConditionEveryMessage => 'Gach teachtaireacht';

  @override
  String rulesMoveRule(String rule) {
    return 'Bog $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule ar siúl';
  }

  @override
  String get rulesServerRulesHeader => 'Rialacha freastalaí';

  @override
  String get rulesServerRulesFooter =>
      'Ritheann rialacha freastalaí ar an bhfreastalaí ríomhphoist de réir mar a thagann ríomhphost, fiú nuair atá an fón seo múchta. Coinnítear iad i script Sieve darb ainm “loupe”.';

  @override
  String get rulesStatusUnknown => 'Anaithnid';

  @override
  String get rulesStatusError => 'Níorbh fhéidir ceist a chur ar an bhfreastalaí.';

  @override
  String get rulesStatusChecking => 'Á seiceáil…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Á rith ó “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Is é “$script” an script ghníomhach. Tapáil chun ligean dó rialacha Loupe a rith freisin.';
  }

  @override
  String get rulesStatusNoScript =>
      'Níl aon script ghníomhach ar an bhfreastalaí. Cuireann sábháil riail freastalaí script Loupe ar siúl.';

  @override
  String get rulesStatusUnavailable => 'Níl ar fáil';

  @override
  String get rulesStatusNoSieve => 'Ní thairgeann freastalaí an chuntais seo Sieve (ManageSieve ná JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Bog go $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Bog go fillteán';

  @override
  String rulesActionTag(String tag) {
    return 'Clib $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Bain an chlib $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Coinnigh sa Bhosca Isteach';

  @override
  String rulesActionForward(String address) {
    return 'Seol ar aghaidh chuig $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Seol ar aghaidh chuig $address, gan cóip a choinneáil';
  }

  @override
  String get rulesActionStop => 'Stop';

  @override
  String get rulesNoActions => 'Ní dhéanann sé aon rud fós';

  @override
  String get rulesLocationDevice => 'Gléas';

  @override
  String get rulesLocationServer => 'Freastalaí';

  @override
  String get rulesLocationThisDevice => 'An gléas seo';

  @override
  String get rulesNewRuleTitle => 'Riail nua';

  @override
  String get rulesEditRuleTitle => 'Cuir an riail in eagar';

  @override
  String get rulesDefaultNameEveryMessage => 'Gach teachtaireacht';

  @override
  String get rulesConditionHeader => 'Nuair a mheaitseálann teachtaireacht nua';

  @override
  String get rulesConditionFooter =>
      'Scríobh é mar a dhéanfá cuardach: from:, to:, s: (ábhar), b: (corp), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:sonrasc';

  @override
  String get rulesAccounts => 'Cuntais';

  @override
  String get rulesAllAccounts => 'Gach cuntas';

  @override
  String get rulesRemovedAccount => 'Cuntas bainte';

  @override
  String get rulesAccountsFooter =>
      'Clúdaíonn riail do gach cuntas na cuntais a chuireann tú leis níos déanaí freisin.';

  @override
  String get rulesActionsHeader => 'Ansin';

  @override
  String get rulesForwardingFooter =>
      'Seolann seoladh ar aghaidh gach teachtaireacht chomhoiriúnach chuig seoladh eile de réir mar a thagann sí, fiú nuair atá an fón seo múchta. Cuireann roinnt soláthraithe teorainn leis an méid ríomhphoist is féidir a sheoladh ar aghaidh.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Ní ritheann seoladh ar aghaidh ach i rialacha freastalaí, mar sin fágtar ar lár anseo é.';

  @override
  String rulesRemoveAction(String action) {
    return 'Bain $action';
  }

  @override
  String get rulesAddAction => 'Cuir gníomh leis';

  @override
  String get rulesAddMove => 'Bog go fillteán…';

  @override
  String get rulesAddTagMenu => 'Cuir clib leis…';

  @override
  String get rulesRemoveTagMenu => 'Bain clib…';

  @override
  String get rulesAddForward => 'Seol ar aghaidh chuig…';

  @override
  String get rulesStopProcessing => 'Stop ag próiseáil rialacha eile';

  @override
  String get rulesRunOnHeader => 'Rith ar';

  @override
  String get rulesRunOnDeviceFooter =>
      'Ritheann an gléas seo an riail ar ríomhphost nua sa Bhosca Isteach gach uair a sheiceálann Loupe le haghaidh ríomhphoist.';

  @override
  String get rulesRunOnServerFooter =>
      'Ritheann an freastalaí ríomhphoist an riail de réir mar a thagann ríomhphost, fiú nuair atá an fón seo múchta. Teastaíonn Sieve, thar ManageSieve (Dovecot, mailcow) nó JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Cuir i bhfeidhm ar theachtaireachtaí atá ann…';

  @override
  String get rulesDeleteRule => 'Scrios an riail';

  @override
  String rulesDeleteTitle(String rule) {
    return '“$rule” a scriosadh?';
  }

  @override
  String get rulesMoveAccountTitle => 'Fillteán i gcén cuntas?';

  @override
  String get rulesMoveAccountMessage =>
      'Téann ríomhphost na gcuntas eile chuig an bhfillteán darb ainm céanna iontu siúd.';

  @override
  String get rulesAddTag => 'Cuir clib leis';

  @override
  String get rulesRemoveTag => 'Bain clib';

  @override
  String get rulesForwardTo => 'Seol ar aghaidh chuig';

  @override
  String get rulesForwardToMessage =>
      'Seolann an freastalaí gach teachtaireacht chomhoiriúnach ar aghaidh chuig an seoladh seo, fiú nuair atá an fón seo múchta. Úsáid seoladh is leat nó a bhfuil muinín agat as.';

  @override
  String get rulesNotAnAddressTitle => 'Ní seoladh ríomhphoist é';

  @override
  String rulesNotAnAddressMessage(String address) {
    return 'Ní seoladh é “$address” ar féidir seoladh ar aghaidh chuige.';
  }

  @override
  String get rulesKeepCopyTitle => 'Cóip a choinneáil anseo?';

  @override
  String get rulesKeepCopy => 'Coinnigh cóip';

  @override
  String get rulesDontKeepCopy => 'Ná coinnigh cóip';

  @override
  String get rulesCheckCondition => 'Seiceáil an coinníoll';

  @override
  String get rulesChooseActionTitle => 'Roghnaigh gníomh';

  @override
  String get rulesChooseActionMessage =>
      'Cuir leis cad a dhéanann an riail leis na teachtaireachtaí a mheaitseálann sí.';

  @override
  String get rulesSaveError => 'Níorbh fhéidir an riail a shábháil';

  @override
  String get rulesSaveServerError => 'Níorbh fhéidir riail an fhreastalaí a shábháil';

  @override
  String get rulesRunOnDeviceInstead => 'Rith ar an ngléas seo ina ionad';

  @override
  String get rulesNothingToApplyTitle => 'Níl aon rud le cur i bhfeidhm';

  @override
  String get rulesNothingToApplyMessage => 'Tabhair coinníoll a oibríonn agus gníomh don riail ar dtús.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Cuir “$rule” i bhfeidhm ar theachtaireachtaí i…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Boscaí isteach';

  @override
  String get rulesApplyScopeAll => 'Gach bosca poist';

  @override
  String get rulesFindingMessages => 'Teachtaireachtaí á n-aimsiú…';

  @override
  String get rulesSearchError => 'Níorbh fhéidir cuardach a dhéanamh';

  @override
  String get rulesSearchErrorUnknown => 'Chuaigh rud éigin mícheart.';

  @override
  String get rulesNoMatchesTitle => 'Ní mheaitseálann aon teachtaireacht';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Ní mheaitseálann aon rud ansin “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$rule” a chur i bhfeidhm ar $countString teachtaireacht?',
      many: '“$rule” a chur i bhfeidhm ar $countString dteachtaireacht?',
      few: '“$rule” a chur i bhfeidhm ar $countString theachtaireacht?',
      two: '“$rule” a chur i bhfeidhm ar $countString theachtaireacht?',
      one: '“$rule” a chur i bhfeidhm ar $countString teachtaireacht?',
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
      other: 'Cuir i bhfeidhm ar $countString teachtaireacht',
      many: 'Cuir i bhfeidhm ar $countString dteachtaireacht',
      few: 'Cuir i bhfeidhm ar $countString theachtaireacht',
      two: 'Cuir i bhfeidhm ar $countString theachtaireacht',
      one: 'Cuir i bhfeidhm ar $countString teachtaireacht',
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
      other: 'Cuireadh “$rule” i bhfeidhm ar $countString teachtaireacht',
      many: 'Cuireadh “$rule” i bhfeidhm ar $countString dteachtaireacht',
      few: 'Cuireadh “$rule” i bhfeidhm ar $countString theachtaireacht',
      two: 'Cuireadh “$rule” i bhfeidhm ar $countString theachtaireacht',
      one: 'Cuireadh “$rule” i bhfeidhm ar $countString teachtaireacht',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Ag fiafraí den fhreastalaí cad is féidir leis a dhéanamh…';

  @override
  String get rulesServerUnreachable => 'Níorbh fhéidir teagmháil a dhéanamh leis an bhfreastalaí.';

  @override
  String rulesServerProblem(String problem) {
    return 'Ní féidir é a rith ar an bhfreastalaí: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Ní féidir é a rith ar fhreastalaí $account: $problem';
  }

  @override
  String get rulesShowScript => 'Taispeáin an script';

  @override
  String get rulesHideScript => 'Folaigh an script';

  @override
  String get rulesMatchingHeader => 'Teachtaireachtaí comhoiriúnacha';

  @override
  String get rulesMatchingHeaderLoading => 'Teachtaireachtaí comhoiriúnacha…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString teachtaireacht chomhoiriúnach',
      many: '$countString dteachtaireacht chomhoiriúnacha',
      few: '$countString theachtaireacht chomhoiriúnacha',
      two: '$countString theachtaireacht chomhoiriúnacha',
      one: '$countString teachtaireacht chomhoiriúnach',
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
      other: '$countString+ teachtaireacht chomhoiriúnach',
      many: '$countString+ dteachtaireacht chomhoiriúnacha',
      few: '$countString+ theachtaireacht chomhoiriúnacha',
      two: '$countString+ theachtaireacht chomhoiriúnacha',
      one: '$countString+ teachtaireacht chomhoiriúnach',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Ó na 30 lá seo caite. Ní ghníomhaíonn an riail féin ach ar ríomhphost nua, mura gcuireann tú i bhfeidhm í ar theachtaireachtaí atá ann.';

  @override
  String rulesConditionError(String error) {
    return 'Tá earráid sa choinníoll: $error';
  }

  @override
  String get rulesPreviewNoSender => '(gan seoltóir)';

  @override
  String get rulesPreviewNoSubject => '(gan ábhar)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'agus $countString eile',
      many: 'agus $countString eile',
      few: 'agus $countString eile',
      two: 'agus $countString eile',
      one: 'agus $countString eile',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Dada ó na 30 lá seo caite.';

  @override
  String get rulesIncludeTitle => 'Cuir rialacha freastalaí ar siúl';

  @override
  String get rulesIncludeLeaveOff => 'Fág as';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Ritheann an freastalaí rialacha Loupe do $account cheana.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return 'Is é “$script” an script ghníomhach ar fhreastalaí $account, mar sin ritheann an freastalaí í agus ní rialacha Loupe. Ní chuirfidh Loupe ceann eile ina háit. Is féidir leis na línte seo a chur léi, agus ritheann an freastalaí rialacha Loupe ansin tar éis rialacha na scripte féin:';
  }

  @override
  String get rulesShowWholeScript => 'Taispeáin an script ar fad';

  @override
  String get rulesHideWholeScript => 'Folaigh an script ar fad';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ní athraíonn aon rud eile in “$script”. Má chuirtear a scagairí in eagar sa ríomhphost gréasáin níos déanaí, d’fhéadfadh an ríomhphost gréasáin í a athscríobh gan na línte seo; taispeánann Loupe rialacha freastalaí mar mhúchta arís ansin.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Cuir le “$script”';
  }

  @override
  String get subscriptionsTitle => 'Síntiúis';

  @override
  String get subscriptionsNewsletters => 'Nuachtlitreacha';

  @override
  String get subscriptionsDiscussions => 'Díospóireachtaí';

  @override
  String get subscriptionsFilter => 'Scag';

  @override
  String get subscriptionsFilterNeverRead => 'Gan léamh riamh';

  @override
  String get subscriptionsFilterRarelyRead => 'Léite go hannamh';

  @override
  String get subscriptionsFilterAll => 'Gach ceann';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Níorbh fhéidir na síntiúis a chomhaireamh';

  @override
  String get subscriptionsNoMatches => 'Gan torthaí';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Níl aon nuachtlitir darb ainm “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Níl aon liosta darb ainm “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Gan nuachtlitreacha';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Taispeántar nuachtlitreacha agus mórphost eile anseo nuair a thagann siad.';

  @override
  String get subscriptionsNothingNeverRead => 'Níl aon rud nár léadh riamh';

  @override
  String get subscriptionsNothingRarelyRead => 'Níl aon rud is annamh a léitear';

  @override
  String get subscriptionsNothingFilteredDetail => 'Léann tú cuid de gach rud a fhaigheann tú.';

  @override
  String get subscriptionsNoDiscussions => 'Gan díospóireachtaí';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Taispeántar liostaí ríomhphoist ar féidir leat scríobh chucu anseo nuair a thagann a ríomhphost.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Liostaí a scríobhann roinnt daoine chucu. Brúigh agus coinnigh ceann chun é a phionnáil ar Boscaí poist, é a léamh mar ghnáth-théacs, nó é a bhogadh go Nuachtlitreacha.';

  @override
  String get subscriptionsPrivacyNote =>
      'Comhairithe ar an bhfón seo ón ríomhphost atá íoslódáilte aige; ní sheoltar aon rud áit ar bith chun é seo a oibriú amach. Ní dhéanann Loupe teagmháil le seoltóir ach amháin nuair a thapálann tú Díliostáil: ní sheolann díliostáil aon chliceála ach “List-Unsubscribe=One-Click” chuig an seoladh a thug an seoltóir, gan fianáin ná aon rud eile fút, agus ní lódálann sé a leathanaigh ná a íomhánna riamh.';

  @override
  String get subscriptionsVolumeNone => 'Dada le déanaí';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mí';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mí';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'léite $percent';
  }

  @override
  String get subscriptionsStillSending => 'Ag seoladh fós';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Díliostáilte ar $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Leathanach díliostála oscailte $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Cnag amháin · déanann teagmháil le $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Trí ríomhphost chuig $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Ar an suíomh gréasáin $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Díliostáil';

  @override
  String get subscriptionsUnsubscribeAgain => 'Díliostáil arís';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cartlannaigh $countString sa Bhosca Isteach',
      many: 'Cartlannaigh $countString sa Bhosca Isteach',
      few: 'Cartlannaigh $countString sa Bhosca Isteach',
      two: 'Cartlannaigh $countString sa Bhosca Isteach',
      one: 'Cartlannaigh $countString sa Bhosca Isteach',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Cruthaigh riail…';

  @override
  String get subscriptionsCreateRuleDetail => 'Bog nó cartlannaigh a ríomhphost amach anseo';

  @override
  String get subscriptionsTreatAsDiscussion => 'Láimhseáil mar dhíospóireacht';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Liosta a scríobhann daoine chuige: léigh é mar fhóram';

  @override
  String get subscriptionsTreatAsNewsletter => 'Láimhseáil mar nuachtlitir';

  @override
  String get subscriptionsBlockSender => 'Blocáil an seoltóir';

  @override
  String get subscriptionsBlock => 'Blocáil';

  @override
  String get subscriptionsBlocked => 'Blocáilte';

  @override
  String get subscriptionsBlockedDetail => 'Téann ríomhphost nua go Turscar';

  @override
  String get subscriptionsPin => 'Pionnáil ar Boscaí poist';

  @override
  String get subscriptionsUnpin => 'Díphionnáil ó Boscaí poist';

  @override
  String get subscriptionsOpenDefaultView => 'Oscail san amharc réamhshocraithe';

  @override
  String get subscriptionsOpenPlainText => 'Oscail mar ghnáth-théacs (aonleithid)';

  @override
  String get subscriptionsPinned => 'Pionnáilte';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString neamhléite',
      many: '$countString neamhléite',
      few: '$countString neamhléite',
      two: '$countString neamhléite',
      one: '$countString neamhléite',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Níl ríomhphost ón seoltóir seo anois.';

  @override
  String get subscriptionsLatestMessages => 'NA TEACHTAIREACHTAÍ IS DÉANAÍ';

  @override
  String get subscriptionsMail => 'Ríomhphost';

  @override
  String get subscriptionsNoneIn90Days => 'Dada le 90 lá';

  @override
  String get subscriptionsRead => 'Léite';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString as $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Faighte go deireanach';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fillteáin',
      many: 'Fillteáin',
      few: 'Fillteáin',
      two: 'Fillteáin',
      one: 'Fillteán',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Ag seoladh fós';

  @override
  String get subscriptionsUnsubscribedTitle => 'Díliostáilte';

  @override
  String subscriptionsSince(String date) {
    return 'ó $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'leathanach oscailte $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return 'Ní deir $sender conas díliostáil.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return 'Ní deir $sender conas díliostáil. Is féidir leat é a bhlocáil ina ionad.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Ag díliostáil ó $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Díliostáladh ó $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Níorbh fhéidir díliostáil: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Níorbh fhéidir díliostáil go huathoibríoch';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Seol ríomhphost díliostála';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Oscail $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site a oscailt?';
  }

  @override
  String get subscriptionsOpen => 'Oscail';

  @override
  String subscriptionsWebExplanation(String sender) {
    return 'Díliostálann $sender ar a shuíomh gréasáin. Osclaítear an leathanach i mbrabhsálaí Loupe; críochnaigh ansin é.';
  }

  @override
  String get subscriptionsWebInsecure => 'Níl an ceangal leis an suíomh seo criptithe.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Bí cúramach: déanann an seoladh seo aithris ar $site le litreacha cosúla.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Bí cúramach: déanann an seoladh seo aithris ar shuíomh eile le litreacha cosúla.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Níorbh fhéidir $site a oscailt.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Breacann Loupe dáta an lae inniu síos agus inseoidh sé duit má leanann $sender ag scríobh.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Díliostáil ó $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Déanfaidh Loupe teagmháil le $site chun díliostáil.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Seo an t-aon uair a dhéanann Loupe teagmháil le suíomh gréasáin seoltóra. Ní sheolann sé ach “List-Unsubscribe=One-Click” chuig an seoladh a thug $sender, gan fianáin ná aon rud eile fút, agus ní lódálann sé an leathanach.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Ní seoladh slán ar an idirlíon é an nasc díliostála.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Níor fhreagair $site in am.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Níorbh fhéidir teagmháil a dhéanamh le $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Sheol $site an t-iarratas ar aghaidh chuig leathanach eile, rud nach leanann Loupe.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Dhiúltaigh $site don iarratas (earráid $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Níl aon chuntas ann chun an ríomhphost díliostála a sheoladh uaidh.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Seolfaidh Loupe ríomhphost chuig $to ó $from, leis an ábhar “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Seoladh ríomhphost díliostála chuig $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender a bhlocáil?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Téann ríomhphost nua ón liosta seo go Turscar. Is féidir leat é seo a athrú in Socruithe › Rialacha.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Téann ríomhphost nua ó $address go Turscar. Is féidir leat é seo a athrú in Socruithe › Rialacha.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Blocáladh $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bog $count go Turscar',
      many: 'Bog $count go Turscar',
      few: 'Bog $count go Turscar',
      two: 'Bog $count go Turscar',
      one: 'Bog $count go Turscar',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blocáil $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return 'Tá $sender in Nuachtlitreacha anois.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return 'Tá $sender in Díospóireachtaí anois.';
  }

  @override
  String get appLiveGateTitle => 'Níorbh fhéidir do chuntais a oscailt';

  @override
  String get appLiveGateUnavailableBuild => 'Níl fíorchuntais ar fáil sa leagan seo fós.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Níorbh fhéidir le Loupe an eochair a chosnaíonn do ríomhphost ar an bhfón seo a léamh. Is minic gur rud sealadach é seo: bain triail eile as, nó atosaigh an fón.';

  @override
  String get appLiveGateKeyMissing =>
      'Tá an eochair a chosnaíonn do ríomhphost ar an bhfón seo imithe, rud a tharlaíonn uaireanta tar éis cúltaca a athchóiriú. Tá do ríomhphost ar an bhfreastalaí fós.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Ní féidir bunachar sonraí an ríomhphoist ar an bhfón seo a léamh: tá sé damáistithe, nó athraíodh a eochair. Tá do ríomhphost ar an bhfreastalaí fós.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Chuaigh rud éigin mícheart agus do chuntais á n-oscailt ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Scriosann sé seo do chuntais agus an ríomhphost atá stóráilte ar an bhfón seo, teachtaireachtaí atá ag fanacht sa Bhosca Amach san áireamh. Ní dhéantar difear do ríomhphost ar d’fhreastalaithe; cuir do chuntais leis arís ina dhiaidh sin.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Scrios agus tosaigh as an nua';

  @override
  String get appLiveGateUseDemo => 'Úsáid ríomhphost taispeántais';

  @override
  String get appLiveGateReset => 'Athshocraigh an ríomhphost ar an bhfón seo…';

  @override
  String get attachmentsUntitled => 'Ceangaltán';

  @override
  String get attachmentsUntitledFile => 'Gan teideal';

  @override
  String get attachmentsOpenIn => 'Oscail i…';

  @override
  String get attachmentsSaveToFiles => 'Sábháil i gComhaid';

  @override
  String get attachmentsShareMenu => 'Comhroinn…';

  @override
  String get attachmentsDownloadError =>
      'Níorbh fhéidir an ceangaltán a íoslódáil. Seiceáil do cheangal agus bain triail eile as.';

  @override
  String get attachmentsShareError => 'Níorbh fhéidir an ceangaltán a chomhroinnt.';

  @override
  String attachmentsNoApp(String type) {
    return 'Níl aip ar an ngléas seo a osclaíonn an comhad seo ($type). Bain triail as Comhroinn ina ionad.';
  }

  @override
  String get attachmentsOpenInError => 'Níorbh fhéidir an ceangaltán a oscailt in aip eile.';

  @override
  String attachmentsSaved(String name) {
    return 'Sábháladh “$name”';
  }

  @override
  String get attachmentsSaveError => 'Níorbh fhéidir an ceangaltán a shábháil.';

  @override
  String get attachmentsGone => 'Níl an ceangaltán seo ar fáil a thuilleadh.';

  @override
  String get attachmentsDownloadFailed => 'Níorbh fhéidir an ceangaltán a íoslódáil.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count leathanach',
      many: '$count leathanach',
      few: '$count leathanach',
      two: '$count leathanach',
      one: '1 leathanach',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size ar shonraí móibíleacha';
  }

  @override
  String get attachmentsLargeDownload => 'Tá an ceangaltán seo mór. Íoslódáil anois é, nó níos déanaí ar Wi-Fi.';

  @override
  String get attachmentsDownload => 'Íoslódáil';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size á íoslódáil…';
  }

  @override
  String get attachmentsDownloading => 'Á íoslódáil…';

  @override
  String get attachmentsTooLarge => 'Rómhór le réamhamharc a fháil air anseo.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'An chéad $shown as $total á thaispeáint. Cóipeáil, comhroinn nó sábháil é chun é ar fad a fháil.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Ní féidir an PDF seo a thaispeáint anseo (b’fhéidir go bhfuil sé cosanta le pasfhocal).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page as $count';
  }

  @override
  String get attachmentsModeTable => 'Tábla';

  @override
  String get attachmentsModeText => 'Téacs';

  @override
  String get attachmentsModeMessage => 'Teachtaireacht';

  @override
  String get attachmentsModeSource => 'Foinse';

  @override
  String get attachmentsDontWrap => 'Ná timfhill línte';

  @override
  String get attachmentsWrap => 'Timfhill línte';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines líne',
      many: '$lines líne',
      few: '$lines líne',
      two: '$lines líne',
      one: '$lines líne',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Cóipeáil gach rud';

  @override
  String get attachmentsCopied => 'Cóipeáilte';

  @override
  String get attachmentsImageUnavailable => 'Ní féidir an íomhá seo a thaispeáint anseo. Bain triail as Oscail i….';

  @override
  String get attachmentsEmlNoSubject => '(Gan ábhar)';

  @override
  String get attachmentsEmlFrom => 'Ó';

  @override
  String get attachmentsEmlTo => 'Chuig';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Dáta';

  @override
  String get attachmentsEmlNoText => 'Níl téacs ar bith sa teachtaireacht seo.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ceangaltáin: $names',
      many: 'Ceangaltáin: $names',
      few: 'Ceangaltáin: $names',
      two: 'Ceangaltáin: $names',
      one: 'Ceangaltán: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Eagraí: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Agus $count imeacht eile',
      many: 'Agus $count n-imeacht eile',
      few: 'Agus $count imeacht eile',
      two: 'Agus $count imeacht eile',
      one: 'Agus 1 imeacht eile',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Íomhá';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Íomhá $format';
  }

  @override
  String get attachmentsTypePdf => 'Doiciméad PDF';

  @override
  String get attachmentsTypeTsv => 'Luachanna scartha le táib';

  @override
  String get attachmentsTypeCsv => 'Scarbhileog CSV';

  @override
  String get attachmentsTypeCalendar => 'Imeacht féilire';

  @override
  String get attachmentsTypeEmail => 'Teachtaireacht ríomhphoist';

  @override
  String get attachmentsTypeContact => 'Cárta teagmhála';

  @override
  String get attachmentsTypeLog => 'Comhad logála';

  @override
  String get attachmentsTypeText => 'Téacs';

  @override
  String get attachmentsTypeZip => 'Cartlann ZIP';

  @override
  String get attachmentsTypeArchive => 'Cartlann';

  @override
  String get attachmentsTypeWord => 'Doiciméad Word';

  @override
  String get attachmentsTypeExcel => 'Scarbhileog Excel';

  @override
  String get attachmentsTypePowerPoint => 'Láithreoireacht PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Leathanach gréasáin';

  @override
  String get attachmentsTypeVideo => 'Físeán';

  @override
  String get attachmentsTypeAudio => 'Fuaim';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Comhad $extension';
  }

  @override
  String get attachmentsTypeFile => 'Comhad';

  @override
  String get calendarUntitledEvent => 'Imeacht';

  @override
  String get calendarAllDay => 'Lá iomlán';

  @override
  String calendarYourTime(String time) {
    return '$time d’am féin';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Glac páirt: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ghlac $name le: $details',
      'tentative': 'Ghlac $name go sealadach le: $details',
      'declined': 'Dhiúltaigh $name do: $details',
      'delegated': 'Tharmligh $name: $details',
      'other': 'Níor fhreagair $name: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ghlac $name leis an gcuireadh',
      'tentative': 'Ghlac $name go sealadach leis an gcuireadh',
      'declined': 'Dhiúltaigh $name don chuireadh',
      'delegated': 'Tharmligh $name an cuireadh',
      'other': 'Níor fhreagair $name an cuireadh',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Léarscáil';

  @override
  String get calendarJoin => 'Glac páirt';

  @override
  String get calendarOnlineMeeting => 'Cruinniú ar líne';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Cruinniú $provider';
  }

  @override
  String get calendarOrganizerYou => 'Tusa';

  @override
  String get calendarOrganizerLabel => 'eagraí';

  @override
  String get calendarStatusAccepted => 'Glactha';

  @override
  String get calendarStatusMaybe => 'B’fhéidir';

  @override
  String get calendarStatusDeclined => 'Diúltaithe';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ghlac $name leis',
      'tentative': 'Ghlac $name leis go sealadach',
      'declined': 'Dhiúltaigh $name dó',
      'delegated': 'Tharmligh $name é',
      'other': 'Níor fhreagair $name',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ghlac $name leis:',
      'tentative': 'Ghlac $name leis go sealadach:',
      'declined': 'Dhiúltaigh $name dó:',
      'delegated': 'Tharmligh $name é:',
      'other': 'Níor fhreagair $name:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return 'Molann $name am nua';
  }

  @override
  String get calendarCounterUnknown => 'Molann rannpháirtí am nua';

  @override
  String get calendarDeclineCounter => 'Choinnigh an t-eagraí an t-am';

  @override
  String calendarRefresh(String name) {
    return 'Iarrann $name an leagan is déanaí';
  }

  @override
  String get calendarRefreshUnknown => 'Iarrann rannpháirtí an leagan is déanaí';

  @override
  String get calendarCancelled => 'Curtha ar ceal';

  @override
  String get calendarCancelledByOrganizer => 'Chuir an t-eagraí an t-imeacht seo ar ceal.';

  @override
  String get calendarCancelledLater => 'Cuireadh an t-imeacht seo ar ceal níos déanaí.';

  @override
  String get calendarOutdated => 'As dáta';

  @override
  String get calendarOutdatedDetail =>
      'Nuashonraíodh an cuireadh seo níos déanaí; is é an ceann is nuaí atá i bhfeidhm.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Baineadh an suíomh (bhí sé $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Baineadh an suíomh (ní raibh ceann ann)';

  @override
  String calendarLocationChanged(String location) {
    return 'Athraíodh an suíomh go $location';
  }

  @override
  String get calendarNewTitle => 'Teideal nua';

  @override
  String get calendarRepeatChanged => 'Athraíodh an athdhéanamh';

  @override
  String get calendarUpdated => 'Nuashonraithe';

  @override
  String get calendarUpdatedInvitation => 'Cuireadh nuashonraithe';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Athraíodh an t-am ó $before go $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Crios ama “$zone” anaithnid: amanna mar a scríobhadh iad';
  }

  @override
  String calendarNext(String when) {
    return 'An chéad cheann eile: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aoi',
      many: '$count n-aoi',
      few: '$count aoi',
      two: '$count aoi',
      one: '1 aoi',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count glactha',
      many: '$count glactha',
      few: '$count glactha',
      two: '$count glactha',
      one: '$count glactha',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count b’fhéidir',
      many: '$count b’fhéidir',
      few: '$count b’fhéidir',
      two: '$count b’fhéidir',
      one: '$count b’fhéidir',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count diúltaithe',
      many: '$count diúltaithe',
      few: '$count diúltaithe',
      two: '$count diúltaithe',
      one: '$count diúltaithe',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (tusa)';
  }

  @override
  String get calendarAttendeeOptional => 'roghnach';

  @override
  String get calendarAttendeeRoom => 'seomra';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ghlac tú le leagan níos luaithe.',
      'tentative': 'Ghlac tú go sealadach le leagan níos luaithe.',
      'declined': 'Dhiúltaigh tú do leagan níos luaithe.',
      'delegated': 'Tharmlig tú leagan níos luaithe.',
      'other': 'Níor fhreagair tú leagan níos luaithe.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Glac leis';

  @override
  String get calendarMaybe => 'B’fhéidir';

  @override
  String get calendarDecline => 'Diúltaigh';

  @override
  String get calendarCommentHint => 'Nóta don eagraí (roghnach)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Téann d’fhreagra chuig $organizer ó $address.';
  }

  @override
  String get calendarAddComment => 'Cuir nóta leis';

  @override
  String get calendarAddToCalendar => 'Cuir leis an bhféilire';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Agus $count imeacht eile sa chomhad',
      many: 'Agus $count n-imeacht eile sa chomhad',
      few: 'Agus $count imeacht eile sa chomhad',
      two: 'Agus $count imeacht eile sa chomhad',
      one: 'Agus 1 imeacht eile sa chomhad',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Níl aip féilire ann chun an t-imeacht a chur leis.';

  @override
  String get calendarCantOpenCalendar => 'Níorbh fhéidir an féilire a oscailt.';

  @override
  String get calendarCantOpenLink => 'Níorbh fhéidir an nasc a oscailt.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Páirt a ghlacadh i gcruinniú $provider?';
  }

  @override
  String get calendarJoinTitle => 'Páirt a ghlacadh sa chruinniú?';

  @override
  String calendarJoinOpens(String host) {
    return 'Osclaíonn sé $host i do bhrabhsálaí.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Bí cúramach: déanann an seoladh seo aithris ar $site le litreacha cosúla.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Bí cúramach: déanann an seoladh seo aithris ar shuíomh eile le litreacha cosúla.';

  @override
  String calendarJoinOpen(String host) {
    return 'Oscail $host';
  }

  @override
  String get calendarNoOrganizer => 'Níl eagraí ag an gcuireadh seo le freagra a thabhairt air.';

  @override
  String get calendarNoAccount => 'Níl aon chuntas ann le freagra a sheoladh uaidh.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Glactha',
      'tentative': 'B’fhéidir',
      'other': 'Diúltaithe',
    });
    return '$_temp0 · freagra á sheoladh chuig $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Glactha',
      'tentative': 'B’fhéidir',
      'other': 'Diúltaithe',
    });
    return '$_temp0 · freagra seolta';
  }

  @override
  String get calendarReplyAlreadySent => 'Seoladh an freagra cheana.';

  @override
  String get calendarReplyNotSent => 'Níor seoladh an freagra.';

  @override
  String get dataSmimeNeedsDevice =>
      'Tá do theastas S/MIME ar an ngléas seo: oscail Loupe chun an teachtaireacht seo a shíniú agus a sheoladh.';

  @override
  String dataSigningFailed(String error) {
    return 'Theip ar an síniú: $error';
  }

  @override
  String get keyboardShortcuts => 'Aicearraí méarchláir';

  @override
  String get keyboardGroupGeneral => 'Ginearálta';

  @override
  String get keyboardGroupMessages => 'Teachtaireachtaí';

  @override
  String get keyboardGroupCompose => 'Scríobh';

  @override
  String get keyboardCommandPalette => 'Pailéad orduithe';

  @override
  String get keyboardBackClose => 'Siar, Dún';

  @override
  String get keyboardNextMessage => 'An chéad teachtaireacht eile';

  @override
  String get keyboardPreviousMessage => 'An teachtaireacht roimhe';

  @override
  String get keyboardOpenMessage => 'Oscail teachtaireacht';

  @override
  String get keyboardMoveToTrash => 'Bog go dtí an Bruscar';

  @override
  String get keyboardToggleRead => 'Marcáil mar léite nó neamhléite';

  @override
  String get keyboardToggleFlag => 'Cuir bratach nó bain í';

  @override
  String get keyboardCloseDraft => 'Dún (sábháil nó scrios an dréacht)';

  @override
  String get keyboardOr => 'nó';

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
  String get mailingListsMuted =>
      'Snáithe balbhaithe. Beidh teachtaireachtaí nua ann léite cheana nuair a thagann siad.';

  @override
  String get mailingListsUnmuted => 'Snáithe díbhalbhaithe.';

  @override
  String get mailingListsMuteThread => 'Balbhaigh an snáithe';

  @override
  String get mailingListsUnmuteThread => 'Díbhalbhaigh an snáithe';

  @override
  String get mailingListsPin => 'Pionnáil ar Boscaí poist';

  @override
  String get mailingListsUnpin => 'Díphionnáil ó Boscaí poist';

  @override
  String get mailingListsDefaultView => 'Oscail san amharc réamhshocraithe';

  @override
  String get mailingListsPlainText => 'Oscail mar ghnáth-théacs (aonleithid)';

  @override
  String get mailingListsShowMuted => 'Taispeáin snáitheanna balbhaithe';

  @override
  String get mailingListsHideMuted => 'Folaigh snáitheanna balbhaithe';

  @override
  String get mailingListsTreatAsNewsletter => 'Láimhseáil mar nuachtlitir';

  @override
  String get mailingListsOptions => 'Roghanna an liosta';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted neamhléite',
      many: '$formatted neamhléite',
      few: '$formatted neamhléite',
      two: '$formatted neamhléite',
      one: '$formatted neamhléite',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Teachtaireacht nua chuig an liosta';

  @override
  String get mailingListsRowUnread => 'Neamhléite';

  @override
  String get mailingListsRowMuted => 'Balbhaithe';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count freagra',
      many: '$count bhfreagra',
      few: '$count fhreagra',
      two: '$count fhreagra',
      one: '1 freagra',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Gan snáitheanna';

  @override
  String get mailingListsMutedHidden => 'Tá snáitheanna balbhaithe i bhfolach.';

  @override
  String get mailingListsTechnicalTitle => 'Liostaí teicniúla';

  @override
  String get mailingListsTechnicalEmpty => 'Taispeántar liostaí ríomhphoist anseo nuair a thagann a ríomhphost.';

  @override
  String get mailingListsTechnicalFooter =>
      'Osclaítear teachtaireachtaí ó na liostaí seo mar ghnáth-théacs i gcló aonleithid, agus paistí taispeánta mar dhifríochtaí. Athraíonn an cnaipe Aa aon teachtaireacht fós.';

  @override
  String get paletteMoveToMailbox => 'Bog go bosca poist…';

  @override
  String get paletteMarkAllRead => 'Marcáil gach ceann mar léite';

  @override
  String get paletteExportFolder => 'Easpórtáil an fillteán…';

  @override
  String get paletteGetNewMail => 'Faigh ríomhphost nua';

  @override
  String get paletteSnoozed => 'Ar athló';

  @override
  String get paletteSubscriptions => 'Síntiúis';

  @override
  String get paletteDiscussions => 'Díospóireachtaí';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Liosta ríomhphoist';

  @override
  String get paletteTag => 'Clib';

  @override
  String get paletteSwipeActions => 'Gníomhartha svaidhpeála';

  @override
  String get paletteNotifications => 'Fógraí';

  @override
  String get paletteRules => 'Rialacha';

  @override
  String get paletteEncryption => 'Criptiú ó cheann go ceann';

  @override
  String get paletteAdvanced => 'Ardsocruithe';

  @override
  String get paletteAddAccount => 'Cuir cuntas leis';

  @override
  String get paletteAccount => 'Cuntas';

  @override
  String get paletteFolders => 'Fillteáin';

  @override
  String get paletteRecentSearch => 'Cuardach le déanaí';

  @override
  String paletteSearchMail(String query) {
    return 'Cuardaigh ríomhphost le haghaidh “$query”';
  }

  @override
  String get palettePlaceholder => 'Cuardaigh gníomhartha, boscaí poist, socruithe';

  @override
  String get paletteNothingFound => 'Níor aimsíodh aon rud';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox nua';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Taispeánann sé gach rud a mheaitseálann “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Sábháladh “$name” in Boscaí poist';
  }

  @override
  String get searchMakeRule => 'Déan riail de seo';

  @override
  String get searchSaveSmartMailbox => 'Sábháil mar Smart Mailbox';

  @override
  String get searchNegate => 'Diúltaigh';

  @override
  String get searchDontNegate => 'Ná diúltaigh';

  @override
  String get searchAllMailboxes => 'Gach bosca poist';

  @override
  String get searchRecent => 'Cuardaigh le déanaí';

  @override
  String get searchClear => 'Glan';

  @override
  String get searchSuggestions => 'Moltaí';

  @override
  String get searchUnreadMessages => 'Teachtaireachtaí neamhléite';

  @override
  String get searchFlaggedMessages => 'Teachtaireachtaí le bratach';

  @override
  String get searchWithAttachments => 'Teachtaireachtaí le ceangaltáin';

  @override
  String get searchUnrepliedMessages => 'Teachtaireachtaí gan freagra';

  @override
  String get searchTags => 'Clibeanna';

  @override
  String get searchPeople => 'Daoine';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Ó: $name';
  }

  @override
  String get searchSearching => 'Á chuardach…';

  @override
  String get searchNoResults => 'Gan torthaí';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted toradh',
      many: '$formatted dtoradh',
      few: '$formatted thoradh',
      two: '$formatted thoradh',
      one: '$formatted toradh',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Roghchlár cuardaigh';

  @override
  String searchSearchingAccount(String account) {
    return '$account á chuardach ar an bhfreastalaí…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Cuntas á chuardach ar an bhfreastalaí…';

  @override
  String searchAccountFailed(String account) {
    return 'Níorbh fhéidir $account a chuardach ar an bhfreastalaí';
  }

  @override
  String get searchUnknownAccountFailed => 'Níorbh fhéidir an cuntas a chuardach ar an bhfreastalaí';

  @override
  String searchChip(String term) {
    return '$term. Tapáil faoi dhó chun é a chur in eagar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Ní $term. Tapáil faoi dhó chun é a chur in eagar.';
  }

  @override
  String get searchReadAndUnread =>
      'Bosca isteach Schrödinger: tá gach teachtaireacht anseo léite agus neamhléite go dtí go n-osclaíonn tú í.';

  @override
  String searchContradiction(String term) {
    return 'Ní féidir le teachtaireacht ar bith a bheith “$term” agus gan a bheith.';
  }

  @override
  String get searchSyncDeviceOnly => 'Ar an ngléas seo amháin';

  @override
  String searchSyncUnsupported(String account) {
    return 'Ar an ngléas seo amháin: ní féidir le $account é a choinneáil';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Gan sioncrónú: tá formáid níos nuaí ag $account';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Ag fanacht le sioncrónú le $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sioncrónaithe le $account';
  }

  @override
  String get searchRename => 'Athainmnigh';

  @override
  String get searchEditSearch => 'Cuir an cuardach in eagar';

  @override
  String get searchDeleteSmartMailbox => 'Scrios an Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Athainmnigh an Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Scriosadh an Smart Mailbox seo.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Fanann Smart Mailboxes ar an ngléas seo.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Coinnítear Smart Mailboxes ar d’fhreastalaí ríomhphoist, ionas go mbíonn siad ag do ghléasanna eile freisin, agus ag Thunderbird le Expression Search Reloaded. Coinnítear na cinn a chuardaíonn gach cuntas ar $account; na cinn a bhaineann le fillteán amháin, ar chuntas an fhillteáin sin.';
  }

  @override
  String get searchSyncVia => 'Sioncrónaigh trí';

  @override
  String get searchSyncViaFooter => 'Roghnaigh an cuntas céanna ar gach gléas.';

  @override
  String get searchGmailCantKeep => 'Ní féidir le Gmail Smart Mailboxes a choinneáil';

  @override
  String get searchKeepOnDevice => 'Coinnigh Smart Mailboxes ar an ngléas seo amháin';

  @override
  String get searchOnTheServer => 'Ar an bhfreastalaí';

  @override
  String get searchServerFooter =>
      'Ní thaispeántar meiteashonraí freastalaí (IMAP METADATA) in aon aip ríomhphoist. Faigheann freastalaithe nach bhfuil sé acu fillteán “Loupe Settings” ina bhfuil teachtaireacht amháin; folaíonn Loupe é ó Boscaí poist.';

  @override
  String get searchSyncNow => 'Sioncrónaigh anois';

  @override
  String get searchStateUnsupported => 'Gan tacaíocht';

  @override
  String get searchStateNewerFormat => 'Formáid níos nuaí';

  @override
  String get searchStateFailed => 'Níorbh fhéidir sioncrónú';

  @override
  String get searchStateSyncing => 'Á shioncrónú…';

  @override
  String get searchStateWaiting => 'Ag fanacht';

  @override
  String get searchStateMetadata => 'Meiteashonraí freastalaí';

  @override
  String get searchStateFolder => 'Fillteán Loupe Settings';

  @override
  String get searchStateNothing => 'Dada stóráilte';

  @override
  String get sharedBack => 'Siar';

  @override
  String get sharedYesterday => 'Inné';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date ag $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beart',
      many: '$count mbeart',
      few: '$count bheart',
      two: '$count bheart',
      one: '$count beart',
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
  String get sharedSyncNoAccounts => 'Gan chuntais';

  @override
  String get sharedSyncChecking => 'Ag seiceáil le haghaidh ríomhphoist…';

  @override
  String get sharedSyncFailed => 'Níorbh fhéidir seiceáil le haghaidh ríomhphoist';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'As líne';

  @override
  String get sharedSyncJustNow => 'Nuashonraithe díreach anois';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Nuashonraithe $minutes nóiméad ó shin',
      many: 'Nuashonraithe $minutes nóiméad ó shin',
      few: 'Nuashonraithe $minutes nóiméad ó shin',
      two: 'Nuashonraithe $minutes nóiméad ó shin',
      one: 'Nuashonraithe 1 nóiméad ó shin',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Nuashonraithe ag $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Nuashonraithe $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Gach Bosca Isteach';

  @override
  String get sharedMailboxUnread => 'Neamhléite';

  @override
  String get sharedMailboxFlagged => 'Le bratach';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Gach Dréacht';

  @override
  String get sharedMailboxAllSent => 'Gach Ríomhphost Seolta';

  @override
  String get sharedMailboxUntitled => 'Bosca poist';

  @override
  String get sharedTagImportant => 'Tábhachtach';

  @override
  String get sharedTagWork => 'Obair';

  @override
  String get sharedTagPersonal => 'Pearsanta';

  @override
  String get sharedTagToDo => 'Le déanamh';

  @override
  String get sharedTagLater => 'Níos déanaí';

  @override
  String get sharedTags => 'Clibeanna';

  @override
  String get sharedMoveTo => 'Bog go…';

  @override
  String get sharedNoRecipients => 'Gan faighteoirí';

  @override
  String get sharedUnknownSender => 'Seoltóir anaithnid';

  @override
  String get sharedOnServer => 'Ar an bhfreastalaí';

  @override
  String get sharedAttachment => 'Ceangaltán';

  @override
  String get sharedSnoozedBadge => 'Ar athló';

  @override
  String get sharedRowUnread => 'Neamhléite';

  @override
  String get sharedRowBackFromSnooze => 'Ar ais ón athló';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Le bratach';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cartlannaíodh $count teachtaireacht',
      many: 'Cartlannaíodh $count dteachtaireacht',
      few: 'Cartlannaíodh $count theachtaireacht',
      two: 'Cartlannaíodh $count theachtaireacht',
      one: 'Cartlannaíodh 1 teachtaireacht',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Scriosadh $count teachtaireacht',
      many: 'Scriosadh $count dteachtaireacht',
      few: 'Scriosadh $count theachtaireacht',
      two: 'Scriosadh $count theachtaireacht',
      one: 'Scriosadh 1 teachtaireacht',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bogadh $count teachtaireacht go dtí an Bosca Isteach',
      many: 'Bogadh $count dteachtaireacht go dtí an Bosca Isteach',
      few: 'Bogadh $count theachtaireacht go dtí an Bosca Isteach',
      two: 'Bogadh $count theachtaireacht go dtí an Bosca Isteach',
      one: 'Bogadh 1 teachtaireacht go dtí an Bosca Isteach',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bogadh $count teachtaireacht go dtí an Bruscar',
      many: 'Bogadh $count dteachtaireacht go dtí an Bruscar',
      few: 'Bogadh $count theachtaireacht go dtí an Bruscar',
      two: 'Bogadh $count theachtaireacht go dtí an Bruscar',
      one: 'Bogadh 1 teachtaireacht go dtí an Bruscar',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bogadh $count teachtaireacht go dtí Turscar',
      many: 'Bogadh $count dteachtaireacht go dtí Turscar',
      few: 'Bogadh $count theachtaireacht go dtí Turscar',
      two: 'Bogadh $count theachtaireacht go dtí Turscar',
      one: 'Bogadh 1 teachtaireacht go dtí Turscar',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bogadh $count teachtaireacht go $mailbox',
      many: 'Bogadh $count dteachtaireacht go $mailbox',
      few: 'Bogadh $count theachtaireacht go $mailbox',
      two: 'Bogadh $count theachtaireacht go $mailbox',
      one: 'Bogadh 1 teachtaireacht go $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bogadh $count teachtaireacht go bosca poist',
      many: 'Bogadh $count dteachtaireacht go bosca poist',
      few: 'Bogadh $count theachtaireacht go bosca poist',
      two: 'Bogadh $count theachtaireacht go bosca poist',
      one: 'Bogadh 1 teachtaireacht go bosca poist',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cuireadh $count teachtaireacht ar athló go $time',
      many: 'Cuireadh $count dteachtaireacht ar athló go $time',
      few: 'Cuireadh $count theachtaireacht ar athló go $time',
      two: 'Cuireadh $count theachtaireacht ar athló go $time',
      one: 'Cuireadh 1 teachtaireacht ar athló go $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Ar athló go $time ar an ngléas seo amháin: ní féidir leis an bhfreastalaí amanna athló a stóráil.';
  }

  @override
  String get sharedMoveOneAccount => 'Roghnaigh teachtaireachtaí ó chuntas amháin chun iad a bhogadh.';

  @override
  String get sharedSnoozeTitle => 'Cuir ar athló';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Athraigh am an athló';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachtaireacht a scriosadh go buan?',
      many: '$count dteachtaireacht a scriosadh go buan?',
      few: '$count theachtaireacht a scriosadh go buan?',
      two: '$count theachtaireacht a scriosadh go buan?',
      one: 'An teachtaireacht seo a scriosadh go buan?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ní féidir é seo a chealú.';

  @override
  String get sharedDeletePermanently => 'Scrios go buan';

  @override
  String get sharedSwipeRead => 'Léite';

  @override
  String get sharedSwipeUnread => 'Neamhléite';

  @override
  String get sharedSwipeInbox => 'Bosca Isteach';

  @override
  String get sharedSwipeDelete => 'Scrios';

  @override
  String get sharedTrash => 'Cuir sa bhruscar';

  @override
  String get sharedSwipeSnooze => 'Athló';

  @override
  String get sharedWakeNow => 'Dúisigh anois';

  @override
  String get sharedChangeSnoozeTime => 'Athraigh am an athló…';

  @override
  String get sharedSnooze => 'Cuir ar athló…';

  @override
  String get sharedTag => 'Clibeáil…';

  @override
  String get sharedMoveMessage => 'Bog an teachtaireacht…';

  @override
  String get sharedNotJunk => 'Ní turscar é';

  @override
  String get accountSetupTitle => 'Cuir cuntas leis';

  @override
  String get accountSetupTitleDone => 'Cuntas curtha leis';

  @override
  String get accountSetupAddressTitle => 'Cuir cuntas ríomhphoist leis';

  @override
  String get accountSetupAddressText => 'Aimsíonn Loupe na socruithe don chuid is mó de sholáthraithe.';

  @override
  String get accountSetupNameHint => 'D’ainm';

  @override
  String get accountSetupEmail => 'Ríomhphost';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Lean ar aghaidh';

  @override
  String get accountSetupLookingUp => 'Socruithe á lorg…';

  @override
  String get accountSetupImport => 'Iompórtáil ó Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Cuir isteach seoladh ríomhphoist bailí.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Níorbh fhéidir socruithe a aimsiú do $domain. Cuir isteach thíos iad.';
  }

  @override
  String get accountSetupCheckServers => 'Seiceáil ainmneacha agus calafoirt na bhfreastalaithe.';

  @override
  String get accountSetupEnterPassword => 'Cuir isteach do phasfhocal.';

  @override
  String get accountSetupConnecting => 'Ag ceangal…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Ag fanacht le $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Níorbh fhéidir an leathanach a oscailt.';

  @override
  String get accountSetupCouldNotSaveName => 'Níorbh fhéidir an t-ainm a shábháil.';

  @override
  String get accountSetupTrustCertificate => 'Cuir muinín sa teastas seo';

  @override
  String get accountSetupPasswordRequired => 'Riachtanach';

  @override
  String get accountSetupShowPassword => 'Taispeáin an pasfhocal';

  @override
  String get accountSetupHidePassword => 'Folaigh an pasfhocal';

  @override
  String get accountSetupAppPassword => 'Pasfhocal aipe';

  @override
  String get accountSetupApiToken => 'Comhartha API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Isteach · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Amach · SMTP';

  @override
  String get accountSetupSignIn => 'Sínigh isteach';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Sínigh isteach le $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Úsáid pasfhocal aipe';

  @override
  String get accountSetupUseAppPasswordInstead => 'Úsáid pasfhocal aipe ina ionad';

  @override
  String get accountSetupUseDifferentAddress => 'Úsáid seoladh eile';

  @override
  String get accountSetupHowToCreateAppPassword => 'Conas pasfhocal aipe a chruthú';

  @override
  String get accountSetupHowToCreateOne => 'Conas ceann a chruthú';

  @override
  String get accountSetupGoogleNote =>
      'Síníonn tú isteach ar leathanach Google, agus ní fheiceann Loupe do phasfhocal riamh. Lig do Loupe do ríomhphost a léamh, a sheoladh agus a eagrú.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      'Níl “Sínigh isteach le Google” ar fáil sa leagan seo fós. Is féidir leat ceangal le pasfhocal aipe ina ionad (teastaíonn Fíorú Dhá Chéim ar do chuntas Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Cruthaigh pasfhocal aipe i do chuntas Google agus greamaigh thíos é.';

  @override
  String get accountSetupMicrosoftNote =>
      'Síníonn tú isteach ar leathanach Microsoft, agus ní fheiceann Loupe do phasfhocal riamh. Oibríonn sé seo do Outlook.com agus Hotmail, agus do chuntais oibre nó scoile ar Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Tiocfaidh síniú isteach Microsoft i leagan níos déanaí. Teastaíonn sé ó chuntais Outlook, Hotmail agus Microsoft 365: ní ghlacann siad le pasfhocail ó aipeanna ríomhphoist a thuilleadh.';

  @override
  String get accountSetupICloudNote =>
      'Teastaíonn pasfhocal aip-shonrach ó iCloud Mail, ní pasfhocal do Chuntais Apple.';

  @override
  String get accountSetupYahooNote => 'Teastaíonn pasfhocal aipe ó Yahoo Mail, ní pasfhocal do chuntais.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Ceanglaíonn Loupe le Fastmail thar JMAP le comhartha API: Settings › Privacy & Security › Manage API tokens, do JMAP, le rochtain ar ríomhphost agus ar sheoladh.';

  @override
  String get accountSetupFastmailNote => 'Teastaíonn pasfhocal aipe ó Fastmail d’aipeanna ríomhphoist.';

  @override
  String get accountSetupServerSettings => 'Socruithe freastalaí';

  @override
  String get accountSetupSettingsNotFound => 'Níor aimsíodh go huathoibríoch';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Aimsithe trí $source';
  }

  @override
  String get accountSetupEditSettings => 'Cuir na socruithe in eagar';

  @override
  String get accountSetupSyncing => 'Tá do ríomhphost á shioncrónú.';

  @override
  String get accountSetupDescription => 'Cur síos';

  @override
  String get accountSetupDescriptionHint => 'Obair, Pearsanta…';

  @override
  String get accountSetupColour => 'Dath';

  @override
  String accountSetupColourNumber(int number) {
    return 'Dath $number';
  }

  @override
  String get accountSetupSaving => 'Á shábháil…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Níorbh fhéidir le Loupe a bhunachar sonraí ríomhphoist a oscailt ar an bhfón seo. Dún Loupe, oscail arís é agus bain triail eile as.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Chuaigh rud éigin mícheart ($error). Bain triail eile as.';
  }

  @override
  String get accountSetupSecurityNone => 'Dada';

  @override
  String get accountSetupProtocol => 'Prótacal';

  @override
  String get accountSetupPort => 'Calafort';

  @override
  String get accountSetupSecurity => 'Slándáil';

  @override
  String get accountSetupUsername => 'Ainm úsáideora';

  @override
  String get accountSetupUsernameHint => 'Do sheoladh ríomhphoist';

  @override
  String get accountSetupNoEncryptionTitle => 'Ceangal gan chriptiú?';

  @override
  String get accountSetupNoEncryptionText =>
      'Thaistealódh do phasfhocal agus gach teachtaireacht mar ghnáth-théacs. D’fhéadfadh duine ar bith ar an líonra, ar Wi-Fi poiblí mar shampla, iad a léamh. Ná húsáid é seo ach le freastalaí ar do líonra féin.';

  @override
  String get accountSetupUseWithoutEncryption => 'Úsáid gan chriptiú';

  @override
  String get accountSetupApiTokenRejected =>
      'Diúltaíodh don chomhartha API. Cruthaigh comhartha API Fastmail do JMAP le rochtain ar ríomhphost, agus greamaigh é.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Diúltaíodh don phasfhocal. Úsáid pasfhocal aipe, ní pasfhocal do chuntais.';

  @override
  String get accountSetupPasswordRejected => 'Diúltaíodh don phasfhocal. Seiceáil é agus bain triail eile as.';

  @override
  String get accountSetupServerUnreachable =>
      'Ní féidir teagmháil a dhéanamh leis an bhfreastalaí. Seiceáil socruithe an fhreastalaí agus do cheangal.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Níl muinín as teastas an fhreastalaí. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Cealaíodh an síniú isteach. Tapáil “Sínigh isteach le $provider” chun triail eile a bhaint as.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Teastaíonn cead ó Loupe do Gmail a léamh agus a sheoladh. Sínigh isteach arís agus ceadaigh rochtain, le tic i mbosca Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Teastaíonn cead ó Loupe do ríomhphost a léamh agus a sheoladh. Sínigh isteach arís agus glac leis na ceadanna.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Caithfidh d’eagraíocht Loupe a cheadú sular féidir leat é a úsáid leis an gcuntas seo. Iarr ar do riarthóir TF toiliú riarthóra a thabhairt do Loupe in Microsoft Entra ID, agus ansin bain triail eile as.';

  @override
  String get accountSetupOAuthBlocked =>
      'Ní cheadaíonn rialacha síniú isteach d’eagraíochta Loupe ar an ngléas seo. Labhair le do riarthóir TF.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Níorbh fhéidir teagmháil a dhéanamh le $provider. Seiceáil do cheangal idirlín agus bain triail eile as.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Níl síniú isteach le $provider socraithe i gceart sa leagan seo de Loupe. Tuairiscigh é seo, le do thoil.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Níor oibrigh síniú isteach le $provider. Bain triail eile as.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Shínigh $provider isteach thú, ach dhiúltaigh Gmail rochtain don seoladh seo. Roghnaigh an cuntas céanna agus tú ag síniú isteach. D’fhéadfadh go bhfuil IMAP múchta ag an riarthóir ar chuntais oibre nó scoile.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Shínigh $provider isteach thú, ach dhiúltaigh an freastalaí ríomhphoist rochtain don seoladh seo. Roghnaigh an cuntas céanna agus tú ag síniú isteach. D’fhéadfadh go bhfuil IMAP múchta ag an riarthóir ar chuntais oibre nó scoile.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Ní féidir teagmháil a dhéanamh leis an bhfreastalaí ríomhphoist. Seiceáil do cheangal agus bain triail eile as.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Níl síniú isteach le $provider ar fáil sa leagan seo.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Sínithe isteach arís. Tá $account á shioncrónú.';
  }

  @override
  String get accountSetupSignInAgain => 'Sínigh isteach arís';

  @override
  String get accountSetupSigningIn => 'Ag síniú isteach…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return 'Ní ghlacann $provider le síniú isteach Loupe do $email a thuilleadh, mar sin níl $account á shioncrónú. Sínigh isteach arís chun a ríomhphost a fháil.';
  }

  @override
  String get accountImportTitle => 'Iompórtáil ó Thunderbird';

  @override
  String get accountImportPointCamera => 'Dírigh an ceamara ar an gcód QR a thaispeánann Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Scanadh $scanned as $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Scanadh $scanned as $total cód',
      many: 'Scanadh $scanned as $total gcód',
      few: 'Scanadh $scanned as $total chód',
      two: 'Scanadh $scanned as $total chód',
      one: 'Scanadh $scanned as $total cód',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cuntas go dtí seo',
      many: '$count gcuntas go dtí seo',
      few: '$count chuntas go dtí seo',
      two: '$count chuntas go dtí seo',
      one: '1 chuntas go dtí seo',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Ar do ríomhaire, oscail Thunderbird agus roghnaigh Uirlisí › Easpórtáil le haghaidh Fóin Phóca. Roghnaigh do chuntais, agus ansin scan gach cód a thaispeánann sé. Is féidir na cóid a scanadh in ord ar bith.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lean ar aghaidh le $count cuntas',
      many: 'Lean ar aghaidh le $count gcuntas',
      few: 'Lean ar aghaidh le $count chuntas',
      two: 'Lean ar aghaidh le $count chuntas',
      one: 'Lean ar aghaidh le 1 chuntas',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Greamaigh téacs ina ionad';

  @override
  String get accountImportStartOver => 'Tosaigh as an nua';

  @override
  String get accountImportDuplicateCode => 'Cuireadh an cód sin leis cheana.';

  @override
  String get accountImportRestarted =>
      'Is ó easpórtáil nua an cód seo, mar sin cuireadh na cóid a scanadh roimhe i leataobh.';

  @override
  String get accountImportNotThunderbird => 'Ní cód cuntais Thunderbird é seo.';

  @override
  String get accountImportNewerVersion =>
      'Tagann an cód seo ó leagan níos nuaí de Thunderbird. Nuashonraigh Loupe chun é a iompórtáil.';

  @override
  String get accountImportDamaged => 'Níorbh fhéidir an cód Thunderbird seo a léamh.';

  @override
  String get accountImportTooLarge => 'Tá an cód seo rómhór le bheith ina easpórtáil Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Níorbh fhéidir Socruithe a oscailt.';

  @override
  String get accountImportCameraOffTitle => 'Tá rochtain ar an gceamara múchta';

  @override
  String get accountImportCameraOffText =>
      'Lig do Loupe an ceamara a úsáid i Socruithe chun an cód a scanadh, nó greamaigh téacs an chóid ina ionad.';

  @override
  String get accountImportNoCameraTitle => 'Gan cheamara';

  @override
  String get accountImportNoCameraText =>
      'Ní féidir le Loupe ceamara a úsáid anseo. Greamaigh téacs an chóid ina ionad.';

  @override
  String get accountImportCameraFailedTitle => 'Níor thosaigh an ceamara';

  @override
  String get accountImportCameraFailedText => 'Bain triail eile as, nó greamaigh téacs an chóid ina ionad.';

  @override
  String get accountImportOpenSettings => 'Oscail Socruithe';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aimsíodh $count cuntas',
      many: 'Aimsíodh $count gcuntas',
      few: 'Aimsíodh $count chuntas',
      two: 'Aimsíodh $count chuntas',
      one: 'Aimsíodh 1 chuntas',
      zero: 'Níor aimsíodh cuntas ar bith',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Níorbh fhéidir aon cheann de na cuntais sna cóid seo a léamh.';

  @override
  String get accountImportChoose => 'Roghnaigh na cuntais le cur le Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Níor scanadh cóid $codes as $total, mar sin níl a gcuntais liostaithe.',
      many: 'Níor scanadh cóid $codes as $total, mar sin níl a gcuntais liostaithe.',
      few: 'Níor scanadh cóid $codes as $total, mar sin níl a gcuntais liostaithe.',
      two: 'Níor scanadh cóid $codes as $total, mar sin níl a gcuntais liostaithe.',
      one: 'Níor scanadh cód $codes as $total, mar sin níl a chuntais liostaithe.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes agus $last';
  }

  @override
  String get accountImportScanMore => 'Scan tuilleadh cód';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Níorbh fhéidir $count cuntas sna cóid a léamh. D’fhéadfadh go n-úsáideann siad socruithe ó leagan níos nuaí de Thunderbird.',
      many:
          'Níorbh fhéidir $count gcuntas sna cóid a léamh. D’fhéadfadh go n-úsáideann siad socruithe ó leagan níos nuaí de Thunderbird.',
      few:
          'Níorbh fhéidir $count chuntas sna cóid a léamh. D’fhéadfadh go n-úsáideann siad socruithe ó leagan níos nuaí de Thunderbird.',
      two:
          'Níorbh fhéidir $count chuntas sna cóid a léamh. D’fhéadfadh go n-úsáideann siad socruithe ó leagan níos nuaí de Thunderbird.',
      one: 'Níorbh fhéidir 1 chuntas sna cóid a léamh. D’fhéadfadh go n-úsáideann sé socruithe ó leagan níos nuaí de Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scan arís';

  @override
  String get accountImportAlreadyAdded => 'Tá cuntas leis an seoladh seo in Loupe cheana.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Síneoidh tú isteach le $provider nuair a chuirtear leis é, mar a dhéantar in Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword => 'Cuir an cuntas leis le pasfhocal aipe (teastaíonn Fíorú Dhá Chéim).';

  @override
  String get accountImportGmailNoSignIn =>
      'Síníonn Thunderbird isteach in Gmail le Google. Tiocfaidh “Sínigh isteach le Google” i leagan níos déanaí; go dtí sin, cuir an cuntas leis le pasfhocal aipe (teastaíonn Fíorú Dhá Chéim).';

  @override
  String get accountImportBrowserSignIn =>
      'Síníonn Thunderbird isteach sa chuntas seo sa bhrabhsálaí. Ní féidir le Loupe é sin a dhéanamh fós: úsáid pasfhocal aipe má thairgeann do sholáthraí ceann.';

  @override
  String get accountImportUnencrypted => 'Ceanglaíonn sé gan chriptiú. Ná húsáid é seo ach ar do líonra féin.';

  @override
  String get accountImportEnterAgain => 'Cuir isteach arís é';

  @override
  String get accountImportAdded => 'Curtha leis';

  @override
  String accountImportAdding(int index, int total) {
    return '$index as $total á chur leis…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cuir $count cuntas leis',
      many: 'Cuir $count gcuntas leis',
      few: 'Cuir $count chuntas leis',
      two: 'Cuir $count chuntas leis',
      one: 'Cuir 1 chuntas leis',
      zero: 'Cuir cuntais leis',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Greamaigh téacs easpórtála';

  @override
  String get accountImportPasteText => 'Greamaigh téacs chód easpórtála Thunderbird, cód amháin ar gach líne.';

  @override
  String get accountImportPop3 =>
      'Ní thacaítear le cuntais POP3. Coinníonn Loupe ríomhphost ar an bhfreastalaí le IMAP.';

  @override
  String get accountImportKerberos => 'Síníonn an cuntas seo isteach le Kerberos, rud nach dtacaíonn Loupe leis.';

  @override
  String get accountImportNtlm => 'Síníonn an cuntas seo isteach le NTLM, rud nach dtacaíonn Loupe leis.';

  @override
  String get accountImportClientCertificate =>
      'Síníonn an cuntas seo isteach le teastas cliaint, rud nach dtacaíonn Loupe leis fós.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Tiocfaidh síniú isteach Microsoft i leagan níos déanaí. Ní ghlacann cuntais Outlook agus Microsoft 365 le pasfhocail ó aipeanna ríomhphoist a thuilleadh.';

  @override
  String get accountImportEnterPassword => 'Cuir isteach an pasfhocal.';

  @override
  String get accountImportEnterAppPassword => 'Cuir isteach an pasfhocal aipe.';

  @override
  String get accountImportEnterApiToken => 'Cuir isteach an comhartha API.';

  @override
  String get accountImportStorageFailed =>
      'Níorbh fhéidir le Loupe a stóras cuntas a oscailt. Bain triail eile as ar ball.';

  @override
  String get accountImportFailed =>
      'Níorbh fhéidir an cuntas a chur leis. Bain triail eile as, nó cuir leis de láimh é.';

  @override
  String get composeNewMessageTitle => 'Teachtaireacht nua';

  @override
  String get composeAttach => 'Ceangail';

  @override
  String get composeSendLater => 'Seol níos déanaí';

  @override
  String composeSendAt(String time) {
    return 'Seol $time';
  }

  @override
  String get composeSendHint => 'Brúigh go fada chun seoladh níos déanaí';

  @override
  String get composeNoAccount => 'Cuir cuntas leis chun ríomhphost a sheoladh.';

  @override
  String get composeTo => 'Chuig:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Ó: $email';
  }

  @override
  String get composeFromLabel => 'Ó:';

  @override
  String get composeSubjectLabel => 'Ábhar:';

  @override
  String composeReplyTo(String address) {
    return 'Freagra chuig: $address';
  }

  @override
  String get composeFrom => 'Ó';

  @override
  String composeReplyFrom(String email) {
    return 'Freagair ó $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Seol ó $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Freagra a thabhairt ó $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Seoladh ó $email?';
  }

  @override
  String get composeDismiss => 'Ruaig';

  @override
  String composeAliasNotSaved(String account) {
    return 'Gan sábháil mar aitheantas · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Sábháil mar aitheantas';

  @override
  String composeAliasSaved(String email) {
    return 'Tá $email sábháilte mar aitheantas.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Seoladh neamhbhailí $address';
  }

  @override
  String get composeOriginalNotFound => 'Níorbh fhéidir an bunteachtaireacht a aimsiú.';

  @override
  String get composeDraftNotFound => 'Níorbh fhéidir an dréacht a aimsiú.';

  @override
  String get composeAttachmentsLost => 'Níorbh fhéidir na ceangaltáin a aisghabháil. Cuir leis arís iad.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Níorbh fhéidir roinnt ceangaltán a chur leis: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return '$size ceangaltán san iomlán; diúltaíonn roinnt freastalaithe do theachtaireachtaí chomh mór seo.';
  }

  @override
  String get composeAttachFailed => 'Níorbh fhéidir an comhad a cheangal.';

  @override
  String get composeInvalidAddressTitle => 'Seoladh neamhbhailí';

  @override
  String composeInvalidAddress(String address) {
    return 'Ní seoladh ríomhphoist bailí é “$address”.';
  }

  @override
  String get composeNoSubjectTitle => 'Gan ábhar';

  @override
  String get composeNoSubjectText => 'Níl ábhar ag an teachtaireacht seo. Í a sheoladh mar sin féin?';

  @override
  String get composeSentBeforeChanges => 'Seoladh í roimh d’athruithe, atá sábháilte in Dréachtaí.';

  @override
  String composeScheduled(String time) {
    return 'Sceidealaithe do $time';
  }

  @override
  String get composeSending => 'Á seoladh…';

  @override
  String get composeSent => 'Seolta';

  @override
  String get composeSendFailed => 'Níorbh fhéidir í a sheoladh. Bain triail eile as.';

  @override
  String get composeAlreadySent => 'Seolta cheana.';

  @override
  String get composeDiscardChanges => 'Caith na hathruithe uait';

  @override
  String get composeSaveChanges => 'Sábháil na hathruithe';

  @override
  String get composeDeleteDraft => 'Scrios an dréacht';

  @override
  String get composeSaveDraft => 'Sábháil an dréacht';

  @override
  String get composeDraftSaved => 'Dréacht sábháilte';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Ar $date ag $time, scríobh $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Ar $date ag $time, scríobh duine éigin:';
  }

  @override
  String get composeForwardHeader => '---------- Teachtaireacht curtha ar aghaidh ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Ó: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Dáta: $date ag $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Ábhar: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Chuig: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Níos déanaí inniu';

  @override
  String get composeTomorrowMorning => 'Maidin amárach';

  @override
  String get composeMondayMorning => 'Maidin Dé Luain';

  @override
  String get composePickDateTime => 'Roghnaigh dáta agus am…';

  @override
  String get composeSendWithoutDelay => 'Seol gan mhoill';

  @override
  String composeSendTimeToday(String time) {
    return 'Inniu ag $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Amárach ag $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day ag $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Inniu $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Amárach $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Leanúint ar aghaidh ag cur do dhréachta in eagar?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Níor seoladh teachtaireacht nuair a dhún Loupe.',
      'one': 'Níor seoladh teachtaireacht chuig $name nuair a dhún Loupe.',
      'other': 'Níor seoladh teachtaireacht chuig $name agus daoine eile nuair a dhún Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Níor seoladh “$subject” nuair a dhún Loupe.',
      'one': 'Níor seoladh “$subject” chuig $name nuair a dhún Loupe.',
      'other': 'Níor seoladh “$subject” chuig $name agus daoine eile nuair a dhún Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Lean ar aghaidh ag cur in eagar';

  @override
  String get composeRecoverySave => 'Sábháil in Dréachtaí';

  @override
  String get composeRecoveryDiscard => 'Caith uait';

  @override
  String get composeRecoverySaved => 'Sábháilte in Dréachtaí';

  @override
  String get outboxSectionFailed => 'Gan seoladh';

  @override
  String get outboxSectionSending => 'Á seoladh';

  @override
  String get outboxSectionScheduled => 'Sceidealaithe';

  @override
  String get outboxStatusQueued => 'Á seoladh go luath';

  @override
  String get outboxStatusSending => 'Á seoladh…';

  @override
  String get outboxStatusFailed => 'Gan seoladh';

  @override
  String get outboxNoRecipients => 'Gan faighteoirí';

  @override
  String get outboxNoSubject => '(Gan ábhar)';

  @override
  String get outboxSendingFailed => 'Theip ar an seoladh.';

  @override
  String get outboxEmptyTitle => 'Níl aon rud le seoladh';

  @override
  String get outboxEmptyText => 'Fanann teachtaireachtaí a sheolann tú níos déanaí anseo go dtí go mbíonn sé in am.';

  @override
  String get outboxSendNow => 'Seol anois';

  @override
  String get outboxReschedule => 'Athsceidealaigh';

  @override
  String get outboxRescheduleMenu => 'Athsceidealaigh…';

  @override
  String get outboxRescheduleTitle => 'Athsceidealaigh';

  @override
  String outboxRescheduled(String time) {
    return 'Athsceidealaithe do $time';
  }

  @override
  String get outboxCancel => 'Cealaigh';

  @override
  String get outboxCancelSending => 'Cealaigh an seoladh…';

  @override
  String get outboxCancelTitle => 'An seoladh a chealú?';

  @override
  String get outboxMoveToDrafts => 'Bog go Dréachtaí';

  @override
  String get outboxDiscard => 'Caith an teachtaireacht uait';

  @override
  String get outboxMovedToDrafts => 'Bogtha go Dréachtaí';

  @override
  String get outboxDiscarded => 'Teachtaireacht caite uait';

  @override
  String get outboxAlreadySent => 'Seolta cheana.';

  @override
  String get outboxBeingSent => 'Tá an teachtaireacht seo á seoladh.';

  @override
  String get outboxActionFailed => 'Níor oibrigh sé sin. Tá an teachtaireacht sa Bhosca Amach fós.';

  @override
  String get notificationsBadgeInboxes => 'Neamhléite sna boscaí isteach';

  @override
  String get notificationsBadgeVip => 'Neamhléite in VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Ríomhphost nua ó do VIPanna, in aon chuntas';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Ríomhphost nua in $email';
  }

  @override
  String get notificationsUnknownSender => 'Seoltóir anaithnid';

  @override
  String get notificationsNoSubject => '(Gan ábhar)';

  @override
  String get notificationsEncryptedMessage => 'Teachtaireacht chriptithe';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Teachtaireacht nua ó $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachtaireacht nua',
      many: '$count dteachtaireacht nua',
      few: '$count theachtaireacht nua',
      two: '$count theachtaireacht nua',
      one: '1 teachtaireacht nua',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Teachtaireachtaí nua in $account';
  }

  @override
  String get platformInstantChannel => 'Seachadadh láithreach';

  @override
  String get platformInstantChannelDescription =>
      'Taispeántar é fad is atá Loupe ag faire ar do bhoscaí isteach le haghaidh ríomhphoist nua';

  @override
  String get platformInstantTitle => 'Ag faire ar ríomhphost nua';

  @override
  String get platformInstantText => 'Tá Seachadadh láithreach ar siúl';

  @override
  String get platformErrorBox =>
      'Chuaigh rud éigin mícheart agus é seo á thaispeáint. Téigh siar agus bain triail eile as.';

  @override
  String get welcomeTagline => 'Ríomhphost simplí ar an dromchla\nagus cumhachtach ina chroí.';

  @override
  String get welcomeAccountsTitle => 'Gach cuntas, bosca isteach socair amháin';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail agus aon fhreastalaí IMAP nó JMAP.';

  @override
  String get welcomeSearchTitle => 'Cuardach a aimsíonn é';

  @override
  String get welcomeSearchText => 'Torthaí láithreacha ar d’fhón, agus ansin torthaí an fhreastalaí.';

  @override
  String get welcomePrivacyTitle => 'Príobháideach ó dhearadh';

  @override
  String get welcomePrivacyText => 'Gan rianú. Fanann íomhánna cianda blocáilte go dtí go ndeir tú a mhalairt.';

  @override
  String get welcomeAddAccount => 'Cuir cuntas leis';

  @override
  String get welcomeImport => 'Iompórtáil ó Thunderbird';

  @override
  String get welcomeTryDemo => 'Bain triail as le ríomhphost taispeántais';
}
