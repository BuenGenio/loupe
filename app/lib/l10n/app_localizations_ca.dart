// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get commonAdd => 'Afegeix';

  @override
  String get commonCancel => 'Cancel·la';

  @override
  String get commonClose => 'Tanca';

  @override
  String get commonDelete => 'Suprimeix';

  @override
  String get commonDone => 'Fet';

  @override
  String get commonEdit => 'Edita';

  @override
  String get commonMore => 'Més';

  @override
  String get commonMove => 'Mou';

  @override
  String get commonName => 'Nom';

  @override
  String get commonNone => 'Cap';

  @override
  String get commonOff => 'Desactivat';

  @override
  String get commonOk => 'D’acord';

  @override
  String get commonOn => 'Activat';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonPassword => 'Contrasenya';

  @override
  String get commonRemove => 'Elimina';

  @override
  String get commonRetry => 'Reintenta';

  @override
  String get commonSave => 'Desa';

  @override
  String get commonSearch => 'Cerca';

  @override
  String get commonServer => 'Servidor';

  @override
  String get commonSettings => 'Configuració';

  @override
  String get commonShare => 'Comparteix';

  @override
  String get commonTryAgain => 'Torna-ho a provar';

  @override
  String get commonUndo => 'Desfés';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count missatges', one: '1 missatge');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arxiva';

  @override
  String get mailDelete => 'Suprimeix';

  @override
  String get mailFlag => 'Marca amb bandera';

  @override
  String get mailForward => 'Reenvia';

  @override
  String get mailMarkAsRead => 'Marca com a llegit';

  @override
  String get mailMarkAsUnread => 'Marca com a no llegit';

  @override
  String get mailMoveToJunk => 'Mou a correu brossa';

  @override
  String get mailNewMessage => 'Missatge nou';

  @override
  String get mailNoSubject => 'Sense assumpte';

  @override
  String get mailReply => 'Respon';

  @override
  String get mailReplyAll => 'Respon a tots';

  @override
  String get mailSend => 'Envia';

  @override
  String get mailUnflag => 'Treu la bandera';

  @override
  String get mailboxArchive => 'Arxiu';

  @override
  String get mailboxDrafts => 'Esborranys';

  @override
  String get mailboxInbox => 'Safata d’entrada';

  @override
  String get mailboxJunk => 'Correu brossa';

  @override
  String get mailboxOutbox => 'Safata de sortida';

  @override
  String get mailboxSent => 'Enviats';

  @override
  String get mailboxTrash => 'Paperera';

  @override
  String get conversationSomethingWentWrong => 'Alguna cosa ha fallat. Torna-ho a provar.';

  @override
  String get conversationReplyToList => 'Respon a la llista';

  @override
  String get conversationReplyList => 'Respon a la llista';

  @override
  String get conversationThreadMuted => 'Fil silenciat. Els missatges nous hi arribaran com a llegits.';

  @override
  String get conversationThreadUnmuted => 'El fil ja no està silenciat.';

  @override
  String get conversationLinkFailed => 'No s’ha pogut obrir l’enllaç.';

  @override
  String get conversationGoneTitle => 'Cap missatge';

  @override
  String get conversationGoneText => 'Aquest missatge s’ha mogut o suprimit.';

  @override
  String get conversationMuted => 'Silenciat';

  @override
  String get conversationReaderOptions => 'Opcions de lectura';

  @override
  String get conversationReaderOptionsHint => 'Mida del text i vista';

  @override
  String get conversationTrash => 'Paperera';

  @override
  String get conversationReplyHint => 'Mantén premut per a Respon a tots i Reenvia';

  @override
  String get conversationOfflineTitle => 'Sense connexió';

  @override
  String get conversationOfflineText =>
      'Aquesta conversa encara no s’ha baixat. Es carregarà quan tornis a tenir connexió.';

  @override
  String get conversationErrorTitle => 'No es pot mostrar aquest missatge';

  @override
  String get conversationErrorText => 'Alguna cosa ha fallat.';

  @override
  String get conversationOfflineBanner => 'Sense connexió';

  @override
  String get conversationNotUpdated => 'No actualitzat';

  @override
  String get conversationMe => 'mi';

  @override
  String get conversationNoSender => '(sense remitent)';

  @override
  String get conversationNoRecipients => 'sense destinataris';

  @override
  String conversationRecipients(String names) {
    return 'per a $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'per a $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'De';

  @override
  String get conversationHeaderTo => 'Per a';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Cco';

  @override
  String get conversationHeaderReplyTo => 'Respon a';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Seguretat';

  @override
  String get conversationVerifiedSender => 'Remitent verificat';

  @override
  String get conversationUnverifiedSender => 'Remitent no verificat';

  @override
  String get conversationLoadingMessage => 'S’està carregant el missatge';

  @override
  String get conversationBodyError => 'No s’ha pogut carregar aquest missatge.';

  @override
  String get conversationBodyOffline => 'No tens connexió. El missatge es carregarà quan tornis a tenir-ne.';

  @override
  String get conversationOriginalHint => 'Es veu millor a la vista Original';

  @override
  String get conversationShowOriginal => 'Mostra l’original';

  @override
  String get conversationScrollToTop => 'Desplaça’t al principi';

  @override
  String get conversationTagsMenu => 'Etiquetes…';

  @override
  String get conversationMuteThread => 'Silencia el fil';

  @override
  String get conversationUnmuteThread => 'Deixa de silenciar el fil';

  @override
  String get conversationMoveMenu => 'Mou…';

  @override
  String get conversationDeletePermanently => 'Suprimeix definitivament';

  @override
  String get conversationMoveToTrash => 'Mou a la paperera';

  @override
  String get conversationNotJunk => 'No és correu brossa';

  @override
  String get conversationShowAllHeaders => 'Mostra totes les capçaleres';

  @override
  String get conversationViewSource => 'Mostra el codi font';

  @override
  String get conversationSaveAsFile => 'Desa com a fitxer…';

  @override
  String get conversationShareAsFile => 'Comparteix com a fitxer…';

  @override
  String get conversationSearchFromMessageMenu => 'Cerca a partir d’aquest missatge…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copia l’adreça';

  @override
  String get conversationAddressCopied => 'S’ha copiat l’adreça';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Cerca missatges de $name';
  }

  @override
  String get conversationTags => 'Etiquetes';

  @override
  String get conversationAllHeaders => 'Totes les capçaleres';

  @override
  String get conversationCopyAll => 'Copia-ho tot';

  @override
  String get conversationHeadersCopied => 'S’han copiat les capçaleres';

  @override
  String get conversationNoHeaders => 'Cap capçalera';

  @override
  String get conversationSearchFromMessageTitle => 'Cerca a partir d’aquest missatge';

  @override
  String conversationSearchFrom(String name) {
    return 'De $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Per a $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Assumpte «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Codi font';

  @override
  String get conversationSourceCopied => 'S’ha copiat el codi font';

  @override
  String get conversationShareFailed => 'No s’ha pogut compartir el missatge.';

  @override
  String get conversationWrapLines => 'Ajusta les línies';

  @override
  String get conversationDontWrapLines => 'No ajustis les línies';

  @override
  String get conversationSourceError => 'No s’ha pogut carregar el codi font.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Es mostren els primers $shown de $total. Copia’l o comparteix-lo per obtenir-lo sencer.';
  }

  @override
  String get conversationAttachmentUntitled => 'Sense títol';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Més accions per a $name';
  }

  @override
  String get conversationMoveTo => 'Mou a…';

  @override
  String get conversationMailboxesError => 'No s’han pogut carregar les bústies.';

  @override
  String get conversationReaderReadable => 'Llegible';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Sense format';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Mantén els colors originals';

  @override
  String get conversationReaderRemember => 'Recorda-ho per a aquest remitent';

  @override
  String get conversationSecurityPossiblePhishing => 'Possible phishing';

  @override
  String get conversationSecurityBeCareful => 'Vés amb compte';

  @override
  String get conversationSecurityVerified => 'Verificat';

  @override
  String get conversationSecurityNoIssues => 'No s’ha trobat cap problema';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rastrejadors',
      one: '1 rastrejador',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Mostra el motiu';

  @override
  String get conversationPhishingBannerTitle => 'Aquest missatge sembla phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Els enllaços i les imatges estan desactivats.';
  }

  @override
  String get conversationPhishingBannerText => 'Els enllaços i les imatges estan desactivats.';

  @override
  String get conversationPhishingWhy => 'Per què?';

  @override
  String get conversationPhishingShowAnyway => 'Mostra-ho igualment';

  @override
  String get conversationSecurityPhishingTitle => 'Això sembla phishing';

  @override
  String get conversationSecurityPhishingText => 'Diversos indicis apunten que aquest missatge no és el que diu ser.';

  @override
  String get conversationSecurityCarefulTitle => 'Vés amb compte amb aquest missatge';

  @override
  String get conversationSecurityCarefulText => 'Hi ha alguna cosa que val la pena mirar dues vegades.';

  @override
  String get conversationSecurityVerifiedText => 'El remitent està verificat i res no sembla sospitós.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Res no sembla sospitós. El teu servidor de correu no ha indicat si el remitent està verificat.';

  @override
  String get conversationSecurityNothingSuspicious => 'Res no sembla sospitós.';

  @override
  String get conversationSecurityWhy => 'Per què';

  @override
  String get conversationSecurityPrivacy => 'Privadesa';

  @override
  String get conversationSecurityNoTrackingPixels => 'Cap píxel de seguiment';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han eliminat $count píxels de seguiment',
      one: 'S’ha eliminat 1 píxel de seguiment',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Haurien dit al remitent quan obries aquest missatge.';

  @override
  String get conversationSecurityNoRemoteImages => 'Cap imatge remota';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imatges remotes',
      one: '1 imatge remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Si les carregues, el remitent sabrà quan llegeixes aquest missatge i quina és la teva adreça IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Cap seguiment de clics';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enllaços passen per rastrejadors de clics',
      one: '1 enllaç passa per rastrejadors de clics',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services registraria el teu clic. Mantén premut un enllaç per obrir-ne directament la destinació.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Detalls tècnics';

  @override
  String get conversationSecurityCheckedLocally => 'Comprovat en aquest dispositiu. No s’ha enviat res enlloc.';

  @override
  String get conversationSecurityTrackersLabel => 'Rastrejadors';

  @override
  String get conversationSecurityImagesFrom => 'Imatges de';

  @override
  String get conversationSecuritySenderHistory => 'Historial del remitent';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received rebuts, $sent enviats';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Els enllaços porten a';

  @override
  String get conversationSecurityHidden => 'Ocult';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elements',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters caràcters',
      one: '$characters caràcter',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Remitent no verificat';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'El teu servidor de correu no ha pogut confirmar que aquest missatge vingui realment de $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'El teu servidor de correu no ha pogut confirmar que aquest missatge vingui realment del seu remitent.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'El teu servidor de correu no ha pogut confirmar que aquest missatge vingui de $domain. És habitual a les llistes de correu.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'El teu servidor de correu no ha pogut confirmar que aquest missatge vingui del seu remitent. És habitual a les llistes de correu.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'No facis el que demana si no l’esperaves. Si tens dubtes, contacta amb el remitent per una altra via.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signat per un altre domini';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'El missatge està signat per $signer, no per $domain. Els serveis d’enviament massiu ho fan, però no demostra qui l’ha escrit.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'El missatge està signat per un altre domini, no per $domain. Els serveis d’enviament massiu ho fan, però no demostra qui l’ha escrit.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'El nom mostra una altra adreça';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'El nom del remitent diu «$shown», però el missatge ve de $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fia’t de l’adreça, no del nom.';

  @override
  String get conversationSecurityReplyToTitle => 'Les respostes van a un altre lloc';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Si hi respons, la resposta anirà a $address, no a $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Comprova l’adreça abans de respondre amb res personal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Fa servir el teu nom';

  @override
  String get conversationSecurityImpersonationTitle => 'Fa servir el nom d’algú que coneixes';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Està signat «$name», com el teu propi nom, però ve d’una adreça nova: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Està signat «$name», com el teu VIP $knownName ($knownEmail), però ve d’una adreça nova: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Està signat «$name», com $knownName ($knownEmail), però ve d’una adreça nova: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'I les respostes anirien a una altra adreça diferent.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Si demana diners, codis o fitxers, comprova-ho abans amb aquesta persona per una altra via.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Adreça coneguda: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Aquesta adreça: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primer missatge d’aquest remitent';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'No havies rebut mai correu de $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Vés amb compte amb les peticions de persones que encara no coneixes.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Lletres enganyoses a l’adreça del remitent';

  @override
  String get conversationSecurityLinkHomographTitle => 'Lletres enganyoses en un enllaç';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host barreja lletres de diferents alfabets per imitar una altra adreça.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host fa servir lletres que s’assemblen a unes altres: no és $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Suprimeix-lo o marca’l com a correu brossa.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'No l’obris.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domini: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domini que n’imita un altre';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Fa servir un nom conegut al domini';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain s’assembla al teu propi domini, $real, però és un domini diferent.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain s’assembla a $brand ($real), però és un domini diferent.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain fa servir el nom del teu propi domini, $real, però no n’és part.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain fa servir el nom de $brand ($real), però no n’és part.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Els missatges reals de la teva organització venen de $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Els missatges reals de $brand venen de $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domini del remitent: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imita: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enllaços amaguen on porten',
      one: 'Un enllaç amaga on porta',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Un enllaç mostra $shown, però obre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'No iniciïs la sessió ni paguis a través d’aquests enllaços. Escriu tu mateix l’adreça.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'No es pot comprovar la destinació d’un enllaç';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Un enllaç mostra $shown, però passa per $host, que registra el clic abans de redirigir-lo.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Un enllaç apunta directament a una adreça IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts no és un lloc web amb nom. Les empreses de debò gairebé mai no enllacen així.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Un enllaç disfressat';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Un enllaç comença per «$shown@» perquè sembli $shown, però obre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'S’ha desactivat una pàgina amagada';

  @override
  String get conversationSecurityDataLinkText =>
      'Un enllaç hauria obert una pàgina inclosa dins del missatge, una manera d’esquivar la comprovació d’enllaços.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Demana una contrasenya';

  @override
  String get conversationSecurityPasswordFieldText =>
      'El missatge contenia un camp de contrasenya. Loupe l’ha eliminat.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'No escriguis mai una contrasenya en un correu.';

  @override
  String get conversationSecurityScriptLinkTitle => 'S’ha desactivat un enllaç que executa codi';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe no executa mai codi dels missatges.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Enllaços escurçats',
      one: 'Un enllaç escurçat',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts amaga la destinació real fins que l’obres.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Adreça web internacional';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts fa servir lletres no llatines. És normal en molts idiomes; comprova que és el lloc que esperes.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Molt de text amagat';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'S’han eliminat $count caràcters de text invisible. Un text amagat com aquest serveix per enganyar els filtres de correu brossa.',
      one:
          'S’ha eliminat $count caràcter de text invisible. Un text amagat com aquest serveix per enganyar els filtres de correu brossa.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'S’ha eliminat text amagat';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han eliminat $count caràcters de text invisible.',
      one: 'S’ha eliminat $count caràcter de text invisible.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'No s’ha pogut baixar el missatge. Comprova la connexió i torna-ho a provar.';

  @override
  String exportSaved(String name) {
    return 'S’ha desat «$name»';
  }

  @override
  String get exportSaveFailed => 'No s’ha pogut desar el missatge.';

  @override
  String exportFailed(String folder) {
    return 'No s’ha pogut exportar «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» no té missatges per exportar.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'No s’ha pogut exportar «$folder»: no s’ha pogut baixar cap missatge. Comprova la connexió i torna-ho a provar.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’ha desat «$name» sense $formattedCount missatges que no s’han pogut baixar.',
      one: 'S’ha desat «$name» sense 1 missatge que no s’ha pogut baixar.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'No s’ha pogut desar «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'S’està exportant «$folder»';
  }

  @override
  String get exportListing => 'S’estan cercant els missatges…';

  @override
  String exportProgress(String current, String total) {
    return 'S’està exportant el $current de $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No s’han pogut baixar $formattedCount missatges',
      one: 'No s’ha pogut baixar 1 missatge',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Bústies';

  @override
  String get mailboxesShown => 'Visible';

  @override
  String get mailboxesHidden => 'Amagada';

  @override
  String get mailboxesCollapse => 'Replega';

  @override
  String get mailboxesExpand => 'Desplega';

  @override
  String get mailboxesManageVips => 'Gestiona els VIP';

  @override
  String get mailboxesSubscriptions => 'Subscripcions';

  @override
  String mailboxesShowAccount(String account) {
    return 'Mostra $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Amaga $account';
  }

  @override
  String get mailboxesExportFolder => 'Exporta la carpeta…';

  @override
  String get mailboxesUnpin => 'Deixa de fixar';

  @override
  String get mailboxesLists => 'Llistes';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Desa una cerca per tenir-la aquí.';

  @override
  String get mailboxesTags => 'Etiquetes';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'També pots tocar el nom d’un remitent en un missatge i activar VIP.';

  @override
  String get mailboxesAddVip => 'Afegeix un VIP…';

  @override
  String get mailboxesAddVipTitle => 'Afegeix un VIP';

  @override
  String get mailboxesAddVipText => 'El correu d’aquesta adreça té una estrella i apareix a la bústia VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'No llegits';

  @override
  String get messageListFilterFlagged => 'Amb bandera';

  @override
  String get messageListFilterToMe => 'Per a: mi';

  @override
  String get messageListFilterCcMe => 'Cc: mi';

  @override
  String get messageListFilterWithAttachments => 'Amb adjunts';

  @override
  String get messageListFilterUnreplied => 'Sense resposta';

  @override
  String get messageListFilterFromVips => 'De VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han marcat $count missatges com a llegits',
      one: 'S’ha marcat 1 missatge com a llegit',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'No s’ha pogut carregar el correu més antic.';

  @override
  String get messageListSelectMessages => 'Selecciona missatges';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionats',
      one: '$count seleccionat',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Selecciona-ho tot';

  @override
  String get messageListDeselectAll => 'Desselecciona-ho tot';

  @override
  String get messageListLoadFailed => 'No s’ha pogut carregar el correu';

  @override
  String get messageListNoUnread => 'Cap correu sense llegir';

  @override
  String get messageListNoMatches => 'Cap correu coincident';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrat per: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Desactiva el filtre';

  @override
  String get messageListEmpty => 'Cap correu';

  @override
  String get messageListFilter => 'Filtre';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Criteris del filtre: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrat per:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount no llegits',
      one: '$formattedCount no llegit',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marca';

  @override
  String get messageListTrash => 'Paperera';

  @override
  String get messageListFilterTitle => 'Filtre';

  @override
  String get messageListFilterInclude => 'INCLOU';

  @override
  String get panesHideMailboxes => 'Amaga les bústies';

  @override
  String get panesShowMailboxes => 'Mostra les bústies';

  @override
  String get panesMailboxesWidth => 'Amplada de les bústies';

  @override
  String get panesListWidth => 'Amplada de la llista de missatges';

  @override
  String get panesNoMessageSelected => 'Cap missatge seleccionat';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count missatges', one: '1 missatge');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Posposats';

  @override
  String get snoozeSheetTitle => 'Posposa';

  @override
  String get snoozeLaterToday => 'Més tard avui';

  @override
  String get snoozeThisEvening => 'Aquest vespre';

  @override
  String get snoozeTomorrow => 'Demà';

  @override
  String get snoozeThisWeekend => 'Aquest cap de setmana';

  @override
  String get snoozeNextWeek => 'La setmana que ve';

  @override
  String get snoozePickDateTime => 'Tria la data i l’hora…';

  @override
  String get snoozeMenu => 'Posposa…';

  @override
  String get snoozeWakeNow => 'Recupera’l ara';

  @override
  String get snoozeChangeTimeMenu => 'Canvia l’hora de posposició…';

  @override
  String get snoozeChangeTime => 'Canvia l’hora';

  @override
  String get snoozeNoTime => 'Sense hora definida';

  @override
  String get snoozeFooter => 'Els missatges posposats tornen a la safata d’entrada, sense llegir, a la seva hora.';

  @override
  String get snoozeEmptyTitle => 'Res posposat';

  @override
  String get snoozeEmptyText => 'Posposa un missatge perquè torni a la safata d’entrada quan el necessitis.';

  @override
  String get appLockUnlock => 'Desbloqueja';

  @override
  String get appLockFailed => 'Loupe no ha pogut confirmar que ets tu.';

  @override
  String get appLockLockedOut => 'Massa intents. Torna-ho a provar més tard.';

  @override
  String get appLockPromptError => 'No s’ha pogut mostrar la sol·licitud. Torna-ho a provar.';

  @override
  String get appLockNoScreenLock => 'Aquest telèfon no té bloqueig de pantalla.';

  @override
  String get appLockUnlockPromptTitle => 'Desbloqueja Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirma que ets tu per veure el teu correu.';

  @override
  String get appLockTurnOnPromptTitle => 'Activa el bloqueig de l’aplicació';

  @override
  String get appLockTurnOnPromptReason => 'Confirma que ets tu per activar el bloqueig de l’aplicació.';

  @override
  String get appLockScreenLockRemoved =>
      'El bloqueig de l’aplicació està desactivat: aquest telèfon ja no té bloqueig de pantalla. Configura’n un per tornar a activar el bloqueig de l’aplicació.';

  @override
  String get appLockAfterImmediately => 'Immediatament';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuts', one: '1 minut');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count hores', one: '1 hora');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Xifrat';

  @override
  String get openpgpEncryptedInPart => 'Xifrat en part';

  @override
  String get openpgpEncryptedLocked => 'Xifrat · bloquejat';

  @override
  String get openpgpEncryptedNoKey => 'Xifrat · sense clau';

  @override
  String get openpgpEncryptedDamaged => 'Xifrat · malmès';

  @override
  String get openpgpEncryptedUnsupported => 'Xifrat · no compatible';

  @override
  String get openpgpUnknownSigner => 'desconegut';

  @override
  String get openpgpUnknownKey => 'Clau desconeguda';

  @override
  String get openpgpSignatureInvalid => 'Signatura no vàlida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signat per $name, no pel remitent';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Signat en part per $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signat per $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signat amb una clau rebutjada';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signat per $name · clau no acceptada';
  }

  @override
  String get openpgpUnlock => 'Desbloqueja';

  @override
  String get openpgpCantDecrypt => 'No es pot desxifrar aquest missatge';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Xifrat amb OpenPGP';

  @override
  String get openpgpEncryption => 'Xifratge';

  @override
  String get openpgpDecryptedHere => 'Desxifrat en aquest dispositiu';

  @override
  String get openpgpNotDecrypted => 'No desxifrat';

  @override
  String get openpgpKeyLocked => 'La teva clau està bloquejada.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Per a les claus $keys',
      one: 'Per a la clau $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Assumpte protegit';

  @override
  String get openpgpUnlockKey => 'Desbloqueja la clau';

  @override
  String get openpgpSignature => 'Signatura';

  @override
  String get openpgpFingerprint => 'Empremta digital';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID de clau $id';
  }

  @override
  String get openpgpSigned => 'Signat';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Acceptació';

  @override
  String get openpgpChangeAcceptance => 'Canvia l’acceptació…';

  @override
  String get openpgpCheckedFooter => 'Comprovat en aquest dispositiu amb OpenPGP, compatible amb Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'La teva clau està bloquejada. Desbloqueja-la amb la frase de pas per llegir aquest missatge.';

  @override
  String get openpgpSummaryNoSecretKey => 'Es va xifrar per a una clau que no és en aquest dispositiu.';

  @override
  String get openpgpSummaryDamaged => 'Les dades xifrades estan malmeses o es van modificar pel camí.';

  @override
  String get openpgpSummaryUnsupported => 'Fa servir un algorisme que Loupe no admet.';

  @override
  String get openpgpSummaryEncrypted => 'Només tu i els altres destinataris el podeu llegir.';

  @override
  String get openpgpSummaryNotSigned => 'No està signat, així que el remitent no està confirmat.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Està signat, però amb una clau que no tens, així que no se’n pot comprovar la signatura.';

  @override
  String get openpgpSummaryBadSignature => 'La signatura no coincideix: és possible que el missatge s’hagi modificat.';

  @override
  String get openpgpSummaryMismatch =>
      'La signatura és vàlida, però la clau pertany a una adreça diferent de la del remitent.';

  @override
  String get openpgpSummaryPartial =>
      'Només una part del missatge està signada. El text de fora de la signatura (per exemple, el peu d’una llista de correu) es mostra sota la línia «Unsigned content», i les altres parts del missatge, com els adjunts, tampoc no hi queden cobertes.';

  @override
  String get openpgpSummaryOwnKey => 'Signat amb la teva pròpia clau.';

  @override
  String get openpgpSummaryVerified => 'La signatura és vàlida i has verificat l’empremta digital de la clau.';

  @override
  String get openpgpSummaryUnverified =>
      'La signatura és vàlida. Vas acceptar la clau sense comprovar-ne l’empremta digital.';

  @override
  String get openpgpSummaryRejected => 'La signatura és vàlida, però vas rebutjar aquesta clau.';

  @override
  String get openpgpSummaryUndecided =>
      'La signatura és vàlida, però encara no has acceptat aquesta clau. Compara’n l’empremta digital amb el remitent.';

  @override
  String get openpgpAcceptanceRejected => 'Rebutjada';

  @override
  String get openpgpAcceptanceUndecided => 'No acceptada';

  @override
  String get openpgpAcceptanceUnverified => 'Acceptada';

  @override
  String get openpgpAcceptanceVerified => 'Acceptada i verificada';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Vols acceptar la clau de $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Empremta digital $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Sí, he verificat l’empremta digital';

  @override
  String get openpgpAcceptUnverified => 'Sí, sense comprovar-la';

  @override
  String get openpgpAcceptLater => 'Encara no';

  @override
  String get openpgpRejectKey => 'Rebutja aquesta clau';

  @override
  String get openpgpNoSubject => '(sense assumpte)';

  @override
  String get openpgpEncryptionTitle => 'Xifratge d’extrem a extrem';

  @override
  String get openpgpMyKeys => 'Les meves claus OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Amb una clau, pots llegir correu xifrat i signar i xifrar el teu. Fas servir Thunderbird? Exporta-hi la clau (Paràmetres del compte › Xifratge d’extrem a extrem › Exporta la clau secreta) i importa-la aquí.';

  @override
  String get openpgpAddKey => 'Afegeix una clau…';

  @override
  String get openpgpAddresses => 'Adreces';

  @override
  String get openpgpAddressesFooter => 'Quina clau fa servir cada adreça, i quan xifra i signa.';

  @override
  String get openpgpCorrespondentsKeys => 'Claus OpenPGP dels teus contactes';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Accepta una clau quan confiïs que pertany al seu propietari; compara’n l’empremta digital amb aquesta persona per marcar-la com a verificada.';

  @override
  String get openpgpImportPublicKey => 'Importa una clau pública…';

  @override
  String get openpgpCollected => 'Recollides amb Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Claus que han arribat amb els missatges. Loupe pot xifrar-hi quan totes dues parts ho demanen.';

  @override
  String get openpgpOnThisDevice => 'En aquest dispositiu';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Els missatges xifrats amaguen l’assumpte. Loupe desa l’assumpte de cada missatge que obres a la seva base de dades xifrada d’aquest dispositiu, perquè la llista, la cerca i les notificacions el mostrin. En segon pla, Loupe també pot desxifrar els assumptes dels missatges nous amb claus sense frase de pas; per fer-ho, baixa cada missatge (fins a 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Desxifra els assumptes en segon pla';

  @override
  String get openpgpIndexFooter =>
      'La cerca troba els missatges xifrats pel remitent, els destinataris i l’assumpte. Amb aquesta opció activada, Loupe també afegeix el text de cada missatge xifrat que desxifra a l’índex de cerca de la seva base de dades xifrada d’aquest dispositiu, perquè la cerca també el trobi pel text. Si la desactives, aquest text se suprimeix de l’índex.';

  @override
  String get openpgpIndexDecrypted => 'Indexa els missatges desxifrats per a la cerca';

  @override
  String get openpgpPassphrases => 'Frases de pas';

  @override
  String get openpgpPassphrasesFooter =>
      'Les claus OpenPGP i els certificats S/MIME que protegeixes amb una frase de pas es desbloquegen quan cal. Sense «Recorda», es tornen a bloquejar dos minuts després de cada ús.';

  @override
  String get openpgpRememberPassphrases => 'Recorda les frases de pas';

  @override
  String get openpgpRememberPassphrasesDetail => 'Fins que es tanqui Loupe';

  @override
  String get openpgpLockKeysNow => 'Bloqueja les claus ara';

  @override
  String get openpgpKeysLocked => 'S’han bloquejat les claus.';

  @override
  String get openpgpKeyStateRevoked => 'revocada';

  @override
  String get openpgpKeyStateExpired => 'caducada';

  @override
  String get openpgpKeyStateNeverExpires => 'no caduca mai';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'caduca el $date';
  }

  @override
  String get openpgpNoKey => 'Sense clau';

  @override
  String get openpgpAlwaysEncrypt => 'Xifra sempre';

  @override
  String get openpgpAddKeyTitle => 'Afegeix una clau OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importa la clau que fas servir a Thunderbird o crea’n una de nova.';

  @override
  String get openpgpImportFromClipboard => 'Importa del porta-retalls';

  @override
  String get openpgpImportFromFile => 'Importa d’un fitxer';

  @override
  String get openpgpGenerateNewKey => 'Genera una clau nova';

  @override
  String get openpgpImportPublicKeyTitle => 'Importa una clau pública';

  @override
  String get openpgpFromClipboard => 'Del porta-retalls';

  @override
  String get openpgpFromFile => 'D’un fitxer';

  @override
  String get openpgpClipboardEmpty => 'El porta-retalls és buit. Copia primer la clau.';

  @override
  String get openpgpKey => 'Clau';

  @override
  String get openpgpValidityRevoked => 'Revocada';

  @override
  String openpgpValidityExpired(String date) {
    return 'Va caducar el $date';
  }

  @override
  String get openpgpNeverExpires => 'No caduca mai';

  @override
  String openpgpValidUntil(String date) {
    return 'Vàlida fins al $date';
  }

  @override
  String get openpgpFingerprintCopied => 'S’ha copiat l’empremta digital.';

  @override
  String get openpgpAlgorithm => 'Algorisme';

  @override
  String get openpgpCreated => 'Creada';

  @override
  String get openpgpValidity => 'Validesa';

  @override
  String get openpgpProtection => 'Protecció';

  @override
  String get openpgpProtectionPassphrase => 'Frase de pas';

  @override
  String get openpgpProtectionKeychain => 'Només el clauer';

  @override
  String get openpgpKeyDetailsFooter =>
      'Comparteix la teva clau pública perquè altres et puguin enviar missatges xifrats. La còpia de seguretat és la teva clau secreta, protegida amb la frase de pas si en té: guarda-la en privat.';

  @override
  String get openpgpSharePublicKey => 'Comparteix la clau pública';

  @override
  String get openpgpCopyPublicKey => 'Copia la clau pública';

  @override
  String get openpgpPublicKeyCopied => 'S’ha copiat la clau pública.';

  @override
  String get openpgpBackUpSecretKey => 'Fes una còpia de la clau secreta';

  @override
  String get openpgpDeleteKey => 'Suprimeix la clau';

  @override
  String get openpgpRemoveKey => 'Elimina la clau';

  @override
  String get openpgpBackUpTitle => 'Vols fer una còpia de la clau secreta?';

  @override
  String get openpgpBackUpProtected =>
      'La còpia de seguretat està protegida per la frase de pas de la teva clau. Qui tingui totes dues coses podrà llegir el teu correu.';

  @override
  String get openpgpBackUpUnprotected =>
      'Aquesta clau no té frase de pas: qui tingui la còpia de seguretat podrà llegir el teu correu i signar en nom teu.';

  @override
  String get openpgpBackUp => 'Fes la còpia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Vols suprimir la teva clau $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Vols eliminar la clau de $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'El correu xifrat per a aquesta clau ja no es podrà llegir en aquest dispositiu, tret que la tornis a importar.';

  @override
  String get openpgpRemoveKeyMessage => 'La pots tornar a importar més tard.';

  @override
  String get openpgpKeyHeader => 'Clau OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Afegeix una clau a Xifratge d’extrem a extrem per xifrar i signar el correu d’aquesta adreça.';

  @override
  String get openpgpGenerateAKey => 'Genera una clau…';

  @override
  String get openpgpSending => 'Enviament';

  @override
  String get openpgpSendingFooter =>
      'El xifratge automàtic s’activa quan tots els destinataris tenen una clau acceptada o un certificat de confiança, o quan Autocrypt indica que totes dues parts ho volen. El correu xifrat sempre es signa.';

  @override
  String get openpgpEncryptAutomatically => 'Xifra automàticament';

  @override
  String get openpgpAlwaysEncryptDetail => 'No s’envia si algun destinatari no té clau';

  @override
  String get openpgpSignUnencrypted => 'Signa el correu sense xifrar';

  @override
  String get openpgpAttachPublicKey => 'Adjunta la meva clau pública';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt envia la teva clau pública amb cada missatge, perquè altres aplicacions et puguin enviar missatges xifrats sense configurar res.';

  @override
  String get openpgpSendMyKey => 'Envia la meva clau amb el correu';

  @override
  String get openpgpPreferEncryption => 'Prefereix el xifratge';

  @override
  String get openpgpPreferEncryptionDetail => 'Demana als altres que xifrin quan puguin';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count anys', one: '1 any');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Les frases de pas no coincideixen.';

  @override
  String openpgpKeyReady(String id) {
    return 'La teva clau $id ja està a punt.';
  }

  @override
  String get openpgpNewKey => 'Clau nova';

  @override
  String get openpgpNewKeyFor => 'Per a';

  @override
  String get openpgpYourName => 'El teu nom';

  @override
  String get openpgpAddress => 'Adreça';

  @override
  String get openpgpPassphrase => 'Frase de pas';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opcional. Sense frase de pas, només el clauer del telèfon protegeix la clau i Loupe no te la demana mai. Amb frase de pas, Loupe te la demana quan cal la clau.';

  @override
  String get openpgpRepeatPassphrase => 'Repeteix-la';

  @override
  String get openpgpExpires => 'Caducitat';

  @override
  String get openpgpExpiresFooter =>
      'Pots crear una clau nova abans que caduqui. Thunderbird també fa servir tres anys.';

  @override
  String get openpgpGenerateKey => 'Genera la clau';

  @override
  String get openpgpKeyFor => 'Clau per a';

  @override
  String get openpgpCantEncrypt => 'No es pot xifrar';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'No hi ha cap clau OpenPGP per a $names, i aquesta adreça sempre xifra. Elimina el destinatari o importa’n la clau a Configuració › Xifratge d’extrem a extrem.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'No hi ha cap certificat S/MIME vàlid per a $names, i aquesta adreça sempre xifra. Elimina el destinatari o importa’n el certificat a Configuració › Xifratge d’extrem a extrem.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'No hi ha cap clau OpenPGP per a $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'No hi ha cap certificat S/MIME vàlid per a $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Envia sense xifrar';

  @override
  String get openpgpCantSign => 'No es pot signar';

  @override
  String get openpgpCantSignMessage =>
      'La clau privada del teu certificat S/MIME no és en aquest dispositiu. Torna a importar el certificat (un fitxer .p12 o .pfx) a Configuració › Xifratge d’extrem a extrem.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Sense clau per a $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sense certificat per a $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Claus d’Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Tothom té clau';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Tothom té certificat';

  @override
  String get openpgpComposeEncrypt => 'Xifra';

  @override
  String get openpgpComposeSign => 'Signa';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, canvia';
  }

  @override
  String get openpgpNoKeyFound => 'No s’ha trobat cap clau OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Vols importar una clau secreta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Aquest adjunt conté una clau secreta ($names). Importa-la com a clau teva només si l’has exportada tu mateix, des de Thunderbird, per exemple.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importa-la com a clau meva';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'la teva clau $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vols importar $count claus ($names)?',
      one: 'Vols importar la clau de $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importa i accepta';

  @override
  String get openpgpImportDecideLater => 'Importa i decideix més tard';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'la clau de $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'S’ha importat: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hi ha $count claus OpenPGP adjuntes.',
      one: 'Hi ha una clau OpenPGP adjunta.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importa';

  @override
  String get openpgpUnlockKeyTitle => 'Desbloqueja la clau OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Introdueix la frase de pas de la clau de $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'La frase de pas no és correcta. Torna-ho a provar.';

  @override
  String get openpgpExplainLocked => 'Aquest missatge està xifrat. Desbloqueja la teva clau OpenPGP per llegir-lo.';

  @override
  String get openpgpExplainNoKey =>
      'Aquest missatge està xifrat, però no per a cap clau OpenPGP d’aquest dispositiu. Si el llegeixes a Thunderbird, importa’n la clau des d’allà: Configuració › Xifratge d’extrem a extrem.';

  @override
  String get openpgpExplainDamaged => 'Aquest missatge xifrat està malmès, així que no es pot desxifrar amb seguretat.';

  @override
  String get openpgpExplainUnsupported => 'Aquest missatge fa servir un xifratge que Loupe encara no pot llegir.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Aquest missatge està xifrat amb S/MIME, però no per a cap certificat d’aquest dispositiu. Importa el teu certificat (un fitxer .p12 o .pfx) a Configuració › Xifratge d’extrem a extrem.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Aquest missatge està xifrat. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Desbloqueja el teu certificat S/MIME per llegir-lo.';

  @override
  String get openpgpAttachmentGone => 'Aquest adjunt ja no està disponible.';

  @override
  String get smimeEncrypted => 'Xifrat (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Xifrat (S/MIME) · sense certificat';

  @override
  String get smimeEncryptedDamaged => 'Xifrat (S/MIME) · malmès';

  @override
  String get smimeEncryptedUnsupported => 'Xifrat (S/MIME) · no compatible';

  @override
  String get smimeEncryptedLocked => 'Xifrat (S/MIME) · bloquejat';

  @override
  String get smimeUnknownSigner => 'desconegut';

  @override
  String get smimeSignatureModified => 'Signatura no vàlida: missatge modificat';

  @override
  String get smimeSignatureWeak => 'Signatura insegura: algorisme obsolet';

  @override
  String get smimeSignatureUncheckable => 'No es pot comprovar la signatura';

  @override
  String get smimeSignedCertificateMissing => 'Signat · falta el certificat';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signat per $name · certificat revocat';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signat per $name · en una altra data';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signat per $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signat per $name · certificat no vàlid';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signat per $name · no és de confiança';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signat per $name · certificat caducat';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signat per $name · certificat encara no vàlid';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signat per $name · certificat no apte per a correu';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signat per $name, no pel remitent';
  }

  @override
  String get smimeCantDecrypt => 'No es pot desxifrar aquest missatge';

  @override
  String get smimeEncryptedWithSmime => 'Xifrat amb S/MIME';

  @override
  String get smimeEncryption => 'Xifratge';

  @override
  String get smimeDecryptedHere => 'Desxifrat en aquest dispositiu';

  @override
  String get smimeNotDecrypted => 'No desxifrat';

  @override
  String get smimeAuthenticated => 'autenticat';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'per a $count certificats',
      one: 'per a 1 certificat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatura';

  @override
  String get smimeIssuedBy => 'Emès per';

  @override
  String get smimeValid => 'Vàlid';

  @override
  String smimeValidRange(String from, String to) {
    return 'Del $from al $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Empremta digital SHA-256';

  @override
  String get smimeSigned => 'Signat';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'S’està comprovant la revocació…';

  @override
  String get smimeNotRevoked => 'No revocat';

  @override
  String get smimeRevoked => 'Revocat';

  @override
  String get smimeRevocationUnknown => 'Revocació desconeguda';

  @override
  String smimeRevokedSince(String date) {
    return 'Des del $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'S’ha consultat l’autoritat (la llista de revocació), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'S’ha consultat l’autoritat (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Confia en «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Confia en aquest certificat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Comprovat en aquest dispositiu amb S/MIME, compatible amb Outlook i Thunderbird; la revocació, amb l’autoritat de certificació.';

  @override
  String get smimeCheckedFooter =>
      'Comprovat en aquest dispositiu amb S/MIME, compatible amb Outlook i Thunderbird. No es comprova la revocació (Configuració › Xifratge d’extrem a extrem).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Vols confiar en $name per al correu?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Vols confiar en el certificat de $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Es confiarà en tots els certificats que emeti aquesta autoritat, com l’autoritat de certificació de la teva empresa. Primer, compara’n l’empremta digital amb el propietari:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Primer, compara’n l’empremta digital amb el propietari:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Confia-hi';

  @override
  String get smimeSummaryNoKey => 'Es va xifrar per a un certificat que no és en aquest dispositiu.';

  @override
  String get smimeSummaryDamaged => 'Les dades xifrades estan malmeses o es van modificar pel camí.';

  @override
  String get smimeSummaryUnsupported => 'Fa servir un algorisme que Loupe no admet.';

  @override
  String get smimeSummaryLocked => 'El teu certificat S/MIME està bloquejat.';

  @override
  String get smimeSummaryEncrypted => 'Només tu i els altres destinataris el podeu llegir.';

  @override
  String get smimeSummaryNotSigned => 'No està signat, així que el remitent no està confirmat.';

  @override
  String get smimeSummaryModified => 'La signatura no coincideix: el missatge es va modificar després de signar-lo.';

  @override
  String get smimeSummaryUncheckable => 'No es pot comprovar la signatura.';

  @override
  String get smimeSummaryNoCertificate => 'El certificat del signant no és al missatge, així que no es pot comprovar.';

  @override
  String get smimeSummaryRevoked =>
      'L’autoritat de certificació ha revocat el certificat del signant: no es pot confiar en la signatura.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'L’autoritat de certificació ha revocat el certificat del signant ($reason): no es pot confiar en la signatura.';
  }

  @override
  String get smimeDateMismatch =>
      'Es va signar més d’una hora abans o després de la data del missatge: pot ser un missatge antic tornat a enviar.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'La signatura és vàlida i $issuer garanteix que el certificat pertany al remitent.';
  }

  @override
  String get smimeProblemInvalidChain => 'El certificat o algun dels seus emissors no és vàlid.';

  @override
  String get smimeProblemUntrusted => 'El certificat prové d’una autoritat en què Loupe no confia.';

  @override
  String get smimeProblemExpired => 'El certificat havia caducat.';

  @override
  String get smimeProblemNotYetValid => 'El certificat encara no era vàlid.';

  @override
  String get smimeProblemWrongUsage => 'El certificat no és apte per a correu.';

  @override
  String get smimeProblemWrongAddress => 'El certificat pertany a una adreça diferent de la del remitent.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'De confiança · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'No és de confiança · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Va caducar el $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Vàlid des del $date';
  }

  @override
  String get smimeTrustInvalid => 'No vàlid';

  @override
  String get smimeTrustNotForMail => 'No apte per a correu';

  @override
  String get smimeTrustAnotherAddress => 'Una altra adreça';

  @override
  String get smimeMyCertificates => 'Els meus certificats S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Per a S/MIME, tal com el fan servir Outlook i moltes empreses. Importa el teu certificat amb la clau privada (un fitxer .p12 o .pfx), exportat des d’Outlook, Windows, macOS o Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Per a S/MIME, tal com el fan servir Outlook i moltes empreses. Importa el teu certificat amb la clau privada (un fitxer .p12 o .pfx), exportat des d’Outlook, Windows, macOS o Thunderbird, o fes servir un que tu o la teva empresa hàgiu instal·lat en aquest dispositiu.';

  @override
  String get smimeCertificateExpired => 'caducat';

  @override
  String smimeCertificateUntil(String date) {
    return 'fins al $date';
  }

  @override
  String get smimeCertificateOnDevice => 'en aquest dispositiu';

  @override
  String get smimeImportCertificateEllipsis => 'Importa un certificat…';

  @override
  String get smimeUseDeviceCertificate => 'Fes servir un certificat d’aquest dispositiu…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificats dels teus contactes';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Recollits del correu signat, com fan Outlook i Thunderbird. El correu només es xifra per a certificats de confiança: Loupe confia en les autoritats en què Mozilla confia per al correu, i en les que hi afegeixis tu.';

  @override
  String get smimeRevocation => 'Revocació';

  @override
  String get smimeRevocationFooter =>
      'Quan obres correu signat, Loupe pregunta a l’autoritat que va emetre el certificat del signant si l’ha revocat (al seu servidor OCSP o a la seva llista de revocació). Aleshores l’autoritat pot veure quan algú des de la teva adreça d’internet llegeix correu signat amb aquest certificat. Les respostes es guarden en aquest dispositiu fins que caduquen. Un certificat revocat es mostra com a «certificat revocat» a la capçalera del missatge.';

  @override
  String get smimeCheckRevocation => 'Comprova la revocació en línia';

  @override
  String get smimeTrustedAuthorities => 'Autoritats de confiança';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'De la teva confiança, a més de les $count en què Mozilla confia per al correu.',
      one: 'De la teva confiança, a més de la $count en què Mozilla confia per al correu.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoritat de certificació';

  @override
  String get smimeImportACertificate => 'Importa un certificat';

  @override
  String get smimeImportContactMessage =>
      'El certificat d’un contacte (.cer, .crt, .pem) o el d’una autoritat de certificació.';

  @override
  String get smimeFromClipboard => 'Del porta-retalls';

  @override
  String get smimeFromFile => 'D’un fitxer';

  @override
  String get smimeClipboardEmpty => 'El porta-retalls és buit. Copia primer el certificat.';

  @override
  String get smimeCertificate => 'Certificat';

  @override
  String get smimeOnDeviceFooter =>
      'La clau privada es queda a l’emmagatzematge de credencials d’Android, on tu o la teva empresa la vau instal·lar: Loupe demana a Android que signi i desxifri amb ella. El correu signat se signa en enviar-lo.';

  @override
  String get smimeAddresses => 'Adreces';

  @override
  String get smimeUsage => 'Per a';

  @override
  String get smimeUsageNone => 'Res que Loupe faci servir';

  @override
  String get smimeUsageSigning => 'Signar';

  @override
  String get smimeUsageEncryption => 'Xifrar';

  @override
  String get smimeUsageCertificates => 'Certificats';

  @override
  String get smimeAlgorithm => 'Algorisme';

  @override
  String get smimeSerialNumber => 'Número de sèrie';

  @override
  String get smimeFingerprintCopied => 'S’ha copiat l’empremta digital.';

  @override
  String get smimeSha1Thumbprint => 'Empremta digital SHA-1';

  @override
  String get smimePrivateKey => 'Clau privada';

  @override
  String get smimeKeyOnDevice => 'En aquest dispositiu';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'A Loupe, amb frase de pas';

  @override
  String get smimeKeyInLoupe => 'A Loupe';

  @override
  String get smimeSource => 'Origen';

  @override
  String get smimeSourceSignedMail => 'Correu signat';

  @override
  String get smimeSourceImported => 'Importat';

  @override
  String get smimeTrustHeader => 'Confiança';

  @override
  String get smimeTrustedRoot => 'Arrel de confiança';

  @override
  String get smimeIssuer => 'Emissor';

  @override
  String smimeTrustNamed(String name) {
    return 'Confia en «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Confia en aquesta autoritat';

  @override
  String get smimeTrustThisCertificate => 'Confia en aquest certificat';

  @override
  String get smimeStopTrusting => 'Deixa de confiar-hi';

  @override
  String get smimePassphrase => 'Frase de pas';

  @override
  String get smimePassphraseFooter =>
      'Opcional. Amb una frase de pas, la clau privada també es xifra en aquest dispositiu (Argon2id i AES-256), i Loupe la demana per signar i desxifrar; Recorda les frases de pas indica durant quant de temps. El correu que envies se signa en enviar-lo; les tasques en segon pla no poden fer servir la clau.';

  @override
  String get smimeChangePassphrase => 'Canvia la frase de pas…';

  @override
  String get smimeSetPassphraseEllipsis => 'Defineix una frase de pas…';

  @override
  String get smimeRemovePassphrase => 'Elimina la frase de pas';

  @override
  String get smimeShareCertificate => 'Comparteix el certificat';

  @override
  String get smimeDeleteCertificate => 'Suprimeix el certificat';

  @override
  String get smimeRemoveCertificate => 'Elimina el certificat';

  @override
  String get smimePassphraseChanged => 'S’ha canviat la frase de pas.';

  @override
  String get smimePassphraseSet => 'S’ha definit la frase de pas.';

  @override
  String get smimeRemovePassphraseTitle => 'Vols eliminar la frase de pas?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Aleshores la clau privada només queda protegida pel clauer, com sense frase de pas: Loupe ja no la demana i les tasques en segon pla la poden fer servir.';

  @override
  String get smimePassphraseRemoved => 'S’ha eliminat la frase de pas.';

  @override
  String smimeTrustTitle(String name) {
    return 'Vols confiar en $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Es confiarà per al correu en tots els certificats que emeti. Primer, compara’n l’empremta digital amb el propietari:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Vols suprimir el teu certificat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Vols eliminar el certificat de $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe deixarà de fer-lo servir: el correu xifrat per a aquest certificat ja no es podrà llegir a Loupe. El certificat es queda en aquest dispositiu (Configuració › Seguretat › Encriptació i credencials).';

  @override
  String get smimeDeleteOwnMessage =>
      'La clau privada se suprimeix d’aquest dispositiu: el correu xifrat per a aquest certificat ja no s’hi podrà llegir, tret que el tornis a importar.';

  @override
  String get smimeRemoveContactMessage => 'Tornarà amb el pròxim missatge signat d’aquesta persona.';

  @override
  String get smimeAddressImportFooter =>
      'Importa un certificat per a aquesta adreça per signar i xifrar amb S/MIME, com fa Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importa un certificat…';

  @override
  String get smimePreferFooter =>
      'Quan tots dos poden protegir un missatge, es fa servir el preferit, tret que només l’altre tingui una clau o un certificat per a tots els destinataris.';

  @override
  String get smimePreferSmime => 'Prefereix S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Abans que OpenPGP';

  @override
  String get smimeCertificatePassword => 'Contrasenya del certificat';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Introdueix la contrasenya amb què es va exportar el fitxer del certificat.';

  @override
  String get smimeImport => 'Importa';

  @override
  String get smimeWrongPassword => 'La contrasenya no és correcta. Torna-ho a provar.';

  @override
  String get smimeNoCertificateFound => 'No s’ha trobat cap certificat.';

  @override
  String smimeCertificateOf(String name) {
    return 'el certificat de $name';
  }

  @override
  String get smimeNothingNew => 'No hi ha res de nou per importar.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'S’ha importat: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han importat $count autoritats de confiança.',
      one: 'S’ha importat una autoritat de confiança.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’ha importat: $certificates i $count autoritats de confiança.',
      one: 'S’ha importat: $certificates i una autoritat de confiança.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Aquest fitxer no té clau privada. Exporta el teu certificat amb la clau privada.';

  @override
  String get smimeImportAsYoursTitle => 'Vols importar-lo com a certificat teu?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Aquest adjunt conté un certificat amb la clau privada: $names. Importa’l només si l’has exportat tu mateix, des d’Outlook o Thunderbird, per exemple.';
  }

  @override
  String get smimeImportAsMine => 'Importa’l com a certificat meu';

  @override
  String smimeImportedOwn(String names) {
    return 'S’ha importat el teu certificat $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'S’ha afegit el teu certificat $name ($addresses) des d’aquest dispositiu.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Vols confiar en «$name» per al correu?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe no coneix aquesta autoritat de certificació (potser és la d’una empresa). Confia-hi per comprovar els certificats que emet. Primer, compara’n l’empremta digital amb el teu departament d’informàtica:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hi ha $count certificats adjunts.',
      one: 'Hi ha un certificat adjunt.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importa el certificat';

  @override
  String get smimeUnlockTitle => 'Desbloqueja el certificat S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Introdueix la frase de pas del certificat de $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'La frase de pas no és correcta. Torna-ho a provar.';

  @override
  String get smimeUnlock => 'Desbloqueja';

  @override
  String get smimeEnterAPassphrase => 'Introdueix una frase de pas.';

  @override
  String get smimePassphrasesDiffer => 'Les dues frases de pas no coincideixen.';

  @override
  String get smimeSetPassphraseTitle => 'Defineix una frase de pas';

  @override
  String get smimeSetPassphraseText =>
      'Loupe la demanarà per signar i desxifrar. Si l’oblides, torna a importar el certificat des del fitxer .p12.';

  @override
  String get smimePassphraseAgain => 'Un altre cop';

  @override
  String get smimeSetPassphraseButton => 'Defineix';

  @override
  String get smimeLockedOpenAgain =>
      'El teu certificat S/MIME està bloquejat. Torna a obrir el missatge per desbloquejar-lo.';

  @override
  String get smimeDeviceHasNoCertificates => 'Aquest dispositiu no ofereix els seus certificats.';

  @override
  String get smimeCantReadCertificate => 'Loupe no pot llegir aquest certificat.';

  @override
  String get smimeCertificateNotForMail =>
      'Aquest certificat no és per a correu: no té cap adreça electrònica o no està pensat per signar ni xifrar.';

  @override
  String get smimeDeviceCertificateGone =>
      'El certificat ja no és en aquest dispositiu, o potser Loupe ja no el pot fer servir. Torna’l a triar a Configuració › Xifratge d’extrem a extrem.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'El certificat d’aquest dispositiu només es pot fer servir mentre Loupe està oberta.';

  @override
  String get smimeDeviceKeyDamaged => 'La clau xifrada està malmesa.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'El certificat d’aquest dispositiu no pot fer això: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'no és compatible';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'El certificat d’aquest dispositiu ha fallat: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'L’adreça de l’autoritat no és una adreça web.';

  @override
  String get smimeAuthorityTimeout => 'L’autoritat de certificació no ha respost a temps.';

  @override
  String get smimeAuthorityUnreachable => 'No s’ha pogut contactar amb l’autoritat de certificació.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'L’autoritat de certificació ha respost $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'La resposta de l’autoritat de certificació és massa gran.';

  @override
  String get smimeRevocationNotChecked =>
      'No comprovat: només es comproven els certificats d’autoritats en què Loupe confia.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'El mateix que el telèfon';

  @override
  String get settingsLanguageFooter =>
      'Loupe fa servir l’idioma del teu telèfon si el té, i l’anglès si no. L’idioma que triïs aquí és només per a Loupe, notificacions incloses.';

  @override
  String get settingsAccountsHeader => 'Comptes';

  @override
  String get settingsAddAccount => 'Afegeix un compte';

  @override
  String get settingsMailHeader => 'Correu';

  @override
  String get settingsSwipeActions => 'Accions en lliscar';

  @override
  String get settingsSwipeLeft => 'Llisca cap a l’esquerra';

  @override
  String get settingsSwipeLeftFooter =>
      'Si llisques fins al final, s’executa aquesta acció. Marca amb bandera i Més sempre són a un lliscament curt.';

  @override
  String get settingsSwipeRight => 'Llisca cap a la dreta';

  @override
  String get settingsSwipeRightFooter => 'Si llisques fins al final, s’executa aquesta acció.';

  @override
  String get settingsSwipeToggleRead => 'Marca com a llegit / no llegit';

  @override
  String get settingsSwipeTrash => 'Paperera';

  @override
  String get settingsSwipeMove => 'Mou el missatge';

  @override
  String get settingsSwipeSnooze => 'Posposa';

  @override
  String get settingsThreaded => 'Agrupa per conversa';

  @override
  String get settingsUndoSendDelay => 'Temps per desfer l’enviament';

  @override
  String get settingsUndoSendDelayFooter => 'Els missatges enviats esperen aquest temps, perquè els puguis recuperar.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds segons', one: '1 segon');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Aparença';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automàtic';

  @override
  String get settingsThemeLight => 'Clar';

  @override
  String get settingsThemeDark => 'Fosc';

  @override
  String get settingsDensity => 'Llista de missatges';

  @override
  String get settingsDensityComfortable => 'Àmplia';

  @override
  String get settingsDensityCompact => 'Compacta';

  @override
  String get settingsReadingHeader => 'Lectura';

  @override
  String get settingsReadingFooter => 'Les imatges remotes poden dir als remitents quan i on has obert un missatge.';

  @override
  String get settingsDefaultView => 'Vista per defecte';

  @override
  String get settingsDefaultViewFooter => 'Pots canviar la vista de qualsevol missatge amb el botó Aa.';

  @override
  String get settingsViewReadable => 'Llegible';

  @override
  String get settingsViewReadableDetail => 'Net, llegible i segueix el mode fosc';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exactament com el va dissenyar el remitent';

  @override
  String get settingsViewPlain => 'Text sense format';

  @override
  String get settingsViewPlainDetail => 'Només les paraules';

  @override
  String get settingsPlainTextFont => 'Lletra del text sense format';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monoespaiada';

  @override
  String get settingsFontMonoDetail => 'Manté alineats l’art ASCII i les taules';

  @override
  String get settingsTechnicalLists => 'Llistes tècniques';

  @override
  String get settingsLoadRemoteImages => 'Carrega les imatges remotes';

  @override
  String get settingsOpenLinksDirectly => 'Obre els enllaços directament';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Salta’t els rastrejadors de clics quan se’n coneix la destinació';

  @override
  String get settingsSecurityHeader => 'Seguretat';

  @override
  String get settingsAppLock => 'Bloqueig de l’aplicació';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe ho demana quan s’inicia, i quan hi tornes després d’haver estat fora el temps de Bloqueja després de.';

  @override
  String get settingsAppLockFooterOff =>
      'El bloqueig de l’aplicació et demana l’empremta digital, la cara o el bloqueig de pantalla abans de mostrar el teu correu.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'El bloqueig de l’aplicació continua desactivat. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configura un codi';

  @override
  String get settingsScreenLockTextIos =>
      'El bloqueig de l’aplicació fa servir Face ID, Touch ID o el codi, i aquest iPhone no té codi. Configura’n un a l’aplicació Configuració i després activa el bloqueig de l’aplicació.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configura un bloqueig de pantalla';

  @override
  String get settingsScreenLockTextAndroid =>
      'El bloqueig de l’aplicació fa servir el bloqueig de pantalla del telèfon, o una empremta digital o una cara que hi hagis afegit, i aquest telèfon no en té cap. Configura un PIN, un patró o una contrasenya a la configuració d’Android i després activa el bloqueig de l’aplicació.';

  @override
  String get settingsOpenSystemSettings => 'Obre Configuració';

  @override
  String get settingsOpenAndroidSettings => 'Obre la configuració d’Android';

  @override
  String get settingsLockAfter => 'Bloqueja després de';

  @override
  String get settingsLockAfterFooter => 'Quant de temps pot estar Loupe en segon pla abans de tornar-ho a demanar.';

  @override
  String get settingsNotifications => 'Notificacions';

  @override
  String get settingsEncryption => 'Xifratge d’extrem a extrem';

  @override
  String get settingsAdvanced => 'Opcions avançades';

  @override
  String get settingsDemoHeader => 'Demostració';

  @override
  String get settingsDemoFooter =>
      'El correu de demostració és una bústia inventada que només existeix en aquest telèfon. No s’envia res enlloc.';

  @override
  String get settingsDemoMode => 'Mode de demostració';

  @override
  String get settingsResetApp => 'Restableix l’aplicació';

  @override
  String get settingsResetFooter => 'Oblida tota la configuració i torna a la pantalla de benvinguda.';

  @override
  String get settingsResetTitle => 'Vols restablir Loupe?';

  @override
  String get settingsResetMessage =>
      'S’oblidarà tota la configuració, les Smart Mailboxes i les cerques recents, i es tornarà a la pantalla de benvinguda.';

  @override
  String get settingsAboutHeader => 'Quant a';

  @override
  String get settingsVersion => 'Versió';

  @override
  String get settingsLicences => 'Llicències';

  @override
  String get settingsPrivacy => 'Privadesa';

  @override
  String get settingsPrivacyDetail =>
      'Loupe no té analítiques ni seguiment. El teu correu només va als teus servidors de correu.';

  @override
  String get settingsNotificationsOffIos => 'Les notificacions de Loupe estan desactivades a Configuració.';

  @override
  String get settingsNotificationsOffAndroid =>
      'Les notificacions de Loupe estan desactivades a la configuració d’Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system no permet que Loupe mostri notificacions. Permet-les a la configuració.';
  }

  @override
  String get settingsNewMailHeader => 'Correu nou';

  @override
  String get settingsNewMailFooterDemo =>
      'El correu de demostració no arriba en segon pla. Envia una notificació de prova per veure com es mostra el correu nou.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe comprova si hi ha correu nou en segon pla quan iOS ho permet, cosa que pot passar amb hores de diferència en les aplicacions que no obres sovint. Rebràs avisos dels missatges nous a les safates d’entrada i dels dels teus VIP a qualsevol carpeta.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe comprova si hi ha correu nou cada 15 minuts aproximadament, quan Android ho permet. Rebràs avisos dels missatges nous a les safates d’entrada i dels dels teus VIP a qualsevol carpeta.';

  @override
  String get settingsNoAccounts => 'Cap compte';

  @override
  String get settingsVipOnly => 'Només VIP';

  @override
  String get settingsVipOnlyDetail => 'Només els missatges dels teus VIP';

  @override
  String get settingsHideContent => 'Amaga el contingut';

  @override
  String get settingsHideContentFooterOn =>
      'Les notificacions només diuen «Missatge nou de» i el compte, no qui l’ha escrit ni de què va.';

  @override
  String get settingsHideContentFooterOff =>
      'Amaga el contingut evita que el remitent, l’assumpte i la previsualització es vegin a la pantalla de bloqueig i a les notificacions.';

  @override
  String get settingsBackgroundAppRefresh => 'Actualització en segon pla';

  @override
  String get settingsBackgroundRefreshFooter =>
      'El correu nou només arriba en segon pla si l’actualització en segon pla està activada per a Loupe a Configuració. iOS no pot mantenir oberta una connexió amb les teves safates d’entrada, així que no hi ha lliurament instantani.';

  @override
  String get settingsInstantDelivery => 'Lliurament instantani';

  @override
  String get settingsInstantDeliveryFooter =>
      'El lliurament instantani (experimental) manté oberta una connexió amb les teves safates d’entrada perquè el correu nou arribi en pocs segons. Mostra una notificació discreta, «Pendent del correu nou», i consumeix més bateria.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android pot aturar el lliurament instantani per estalviar bateria. Permet que Loupe faci servir la bateria sense restriccions perquè continuï funcionant.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'Properament';

  @override
  String get settingsAllowUnrestrictedBattery => 'Permet l’ús de la bateria sense restriccions';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'El push permet que el correu nou desperti Loupe de seguida, si el teu servei de correu ho admet. Els avisos push passen pel servei push de Google i no porten cap correu, només «comprova-ho ara».';

  @override
  String get settingsPushUnavailableFooter =>
      'Aquest telèfon no pot rebre avisos push: necessiten els serveis de Google Play i una connexió de xarxa. Loupe continua comprovant si hi ha correu nou cada 15 minuts aproximadament.';

  @override
  String get settingsCopyPushToken => 'Copia el testimoni push';

  @override
  String get settingsPushTokenCopied => 'S’ha copiat el testimoni push';

  @override
  String get settingsSendTestNotification => 'Envia una notificació de prova';

  @override
  String get settingsAppIconBadge => 'Indicador a la icona de l’aplicació';

  @override
  String get settingsBadgeNote =>
      'L’indicador s’actualitza cada vegada que Loupe comprova el correu, també en segon pla.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'La pantalla d’inici d’aquest telèfon no mostra números a les icones de les aplicacions. L’indicador s’actualitza cada vegada que Loupe comprova el correu, també en segon pla.';

  @override
  String get settingsTestNotificationBody => 'Les notificacions de correu nou es veuen així.';

  @override
  String get settingsAccountRemoved => 'Aquest compte s’ha eliminat.';

  @override
  String get settingsAccountHeader => 'Compte';

  @override
  String get settingsAccountDescription => 'Descripció';

  @override
  String get settingsAccountDescriptionHint => 'Feina, Personal…';

  @override
  String get settingsEmail => 'Correu electrònic';

  @override
  String get settingsColour => 'Color';

  @override
  String get settingsColourFooter => 'Marca els missatges d’aquest compte a Totes les safates d’entrada.';

  @override
  String settingsColourNumber(int number) {
    return 'Color $number';
  }

  @override
  String get settingsSendingHeader => 'Enviament';

  @override
  String get settingsSendingFooter =>
      'Cada identitat té la seva pròpia signatura. Les respostes surten des de l’adreça a la qual es va enviar el missatge.';

  @override
  String get settingsFoldersHeader => 'Carpetes';

  @override
  String get settingsFoldersFooter =>
      'Loupe mostra i sincronitza les carpetes a què et subscrius, com fa Thunderbird. Safata d’entrada, Esborranys, Enviats, Correu brossa, Paperera i Arxiu sempre es mostren.';

  @override
  String get settingsShowAllFolders => 'Mostra totes les carpetes';

  @override
  String get settingsIncoming => 'Entrant';

  @override
  String get settingsOutgoing => 'Sortint';

  @override
  String get settingsConnectionNotEncrypted => 'Sense xifrar';

  @override
  String get settingsSignIn => 'Inici de sessió';

  @override
  String get settingsSignInExpired => 'Caducat';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider ja no accepta l’inici de sessió de Loupe per a aquest compte, així que el seu correu no s’està sincronitzant. Torna a iniciar la sessió per solucionar-ho.';
  }

  @override
  String get settingsSignInAgain => 'Torna a iniciar la sessió';

  @override
  String get settingsSigningIn => 'S’està iniciant la sessió…';

  @override
  String get settingsRemoveAccount => 'Elimina el compte';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Vols eliminar «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'El seu correu i la seva configuració s’eliminen d’aquest telèfon. No se suprimeix res del servidor.';

  @override
  String get settingsManageFolders => 'Gestiona les carpetes';

  @override
  String get settingsNoFolders => 'Encara no hi ha carpetes.';

  @override
  String get settingsManageFoldersFooter =>
      'Les carpetes subscrites es mostren a la pantalla Bústies i se sincronitzen en segon pla. Les altres aplicacions de correu amb el mateix compte normalment també segueixen aquestes subscripcions.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Guarda les teves Smart Mailboxes per als altres dispositius. Amagada a la pantalla Bústies.';

  @override
  String get settingsFolderAlwaysShown => 'Sempre visible';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Subscriu-te a $folder';
  }

  @override
  String get settingsIdentities => 'Identitats';

  @override
  String get settingsIdentitiesFooterReorder =>
      'La primera identitat és la predeterminada per als missatges nous. Arrossega per canviar-ne l’ordre.';

  @override
  String get settingsIdentitiesFooterSingle => 'La identitat predeterminada per als missatges nous.';

  @override
  String get settingsIdentitiesReplyFooter =>
      'Les respostes surten des de la identitat a la qual es va enviar el missatge.';

  @override
  String get settingsIdentityDefault => 'Predeterminada';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reordena $email';
  }

  @override
  String get settingsAddIdentity => 'Afegeix una identitat';

  @override
  String get settingsNewIdentity => 'Identitat nova';

  @override
  String get settingsIdentity => 'Identitat';

  @override
  String get settingsIdentityNameHint => 'El teu nom';

  @override
  String get settingsReplyTo => 'Respon a';

  @override
  String get settingsSignature => 'Signatura';

  @override
  String get settingsSignatureFooter => 'S’afegeix a sota de «-- » als missatges d’aquesta identitat.';

  @override
  String get settingsNoSignature => 'Sense signatura';

  @override
  String get settingsCopyToMyself => 'Còpia per a mi';

  @override
  String get settingsCopyToMyselfFooter => 'S’afegeix a tots els missatges d’aquesta identitat.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Cco';

  @override
  String get settingsReplyPatterns => 'Fes-la servir per respondre a';

  @override
  String get settingsReplyPatternsFooter =>
      'Les respostes als missatges enviats a aquestes adreces surten des d’aquesta identitat. * vol dir qualsevol cosa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Una adreça, o un patró en què * vol dir qualsevol cosa.';

  @override
  String get settingsAddReplyPattern => 'Afegeix una adreça o un patró';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Elimina $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Patró no vàlid';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» no és una adreça ni un patró com *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Cap adreça';

  @override
  String get settingsIdentityNoAddressMessage => 'Introdueix l’adreça electrònica des de la qual vols enviar.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Adreça no vàlida';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '«$address» a Respon a no és una adreça electrònica vàlida.',
      'cc': '«$address» a Cc no és una adreça electrònica vàlida.',
      'bcc': '«$address» a Cco no és una adreça electrònica vàlida.',
      'other': '«$address» no és una adreça electrònica vàlida.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Desa la identitat';

  @override
  String get settingsDiscardChanges => 'Descarta els canvis';

  @override
  String get settingsDeleteIdentity => 'Suprimeix la identitat';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Vols suprimir «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Els missatges que ja s’hi han enviat es queden com estan.';

  @override
  String get settingsLastIdentityFooter => 'Un compte necessita com a mínim una identitat.';

  @override
  String get rulesTitle => 'Regles';

  @override
  String get rulesNewRule => 'Regla nova';

  @override
  String get rulesLoadError => 'No s’han pogut carregar les regles.';

  @override
  String get rulesEmptyTitle => 'Cap regla';

  @override
  String get rulesEmptyText =>
      'Les regles arxiven, etiqueten i marquen amb bandera el correu nou per tu. Crea’n una amb el botó de redactar de dalt, o a partir d’una cerca amb «Converteix-la en una regla».';

  @override
  String get rulesListFooter =>
      'Les regles s’executen de dalt a baix sobre el correu nou de la safata d’entrada. Mantén premuda una regla per moure-la.';

  @override
  String get rulesChangeError => 'No s’ha pogut canviar la regla';

  @override
  String get rulesConditionEveryMessage => 'Tots els missatges';

  @override
  String rulesMoveRule(String rule) {
    return 'Mou $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule activada';
  }

  @override
  String get rulesServerRulesHeader => 'Regles del servidor';

  @override
  String get rulesServerRulesFooter =>
      'Les regles del servidor s’executen al servidor de correu a mesura que arriba el correu, també quan aquest telèfon està apagat. Es guarden en un script Sieve anomenat «loupe».';

  @override
  String get rulesStatusUnknown => 'Desconegut';

  @override
  String get rulesStatusError => 'No s’ha pogut consultar el servidor.';

  @override
  String get rulesStatusChecking => 'S’està comprovant…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'S’executen des de «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» és l’script actiu. Toca per fer que també executi les regles de Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'No hi ha cap script actiu al servidor. Si deses una regla del servidor, s’activa el de Loupe.';

  @override
  String get rulesStatusUnavailable => 'No disponible';

  @override
  String get rulesStatusNoSieve => 'El servidor d’aquest compte no ofereix Sieve (ni ManageSieve ni JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mou a $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mou a una carpeta';

  @override
  String rulesActionTag(String tag) {
    return 'Etiqueta com a $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Treu l’etiqueta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Mantén a la safata d’entrada';

  @override
  String rulesActionForward(String address) {
    return 'Reenvia a $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Reenvia a $address, sense guardar-ne còpia';
  }

  @override
  String get rulesActionStop => 'Atura';

  @override
  String get rulesNoActions => 'Encara no fa res';

  @override
  String get rulesLocationDevice => 'Dispositiu';

  @override
  String get rulesLocationServer => 'Servidor';

  @override
  String get rulesLocationThisDevice => 'Aquest dispositiu';

  @override
  String get rulesNewRuleTitle => 'Regla nova';

  @override
  String get rulesEditRuleTitle => 'Edita la regla';

  @override
  String get rulesDefaultNameEveryMessage => 'Tots els missatges';

  @override
  String get rulesConditionHeader => 'Quan un missatge nou coincideixi amb';

  @override
  String get rulesConditionFooter =>
      'Escriu-la com si cerquessis: from:, to:, s: (assumpte), b: (cos), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:factura';

  @override
  String get rulesAccounts => 'Comptes';

  @override
  String get rulesAllAccounts => 'Tots els comptes';

  @override
  String get rulesRemovedAccount => 'Compte eliminat';

  @override
  String get rulesAccountsFooter =>
      'Una regla per a tots els comptes també s’aplica als comptes que afegeixis més endavant.';

  @override
  String get rulesActionsHeader => 'Aleshores';

  @override
  String get rulesForwardingFooter =>
      'El reenviament envia cada missatge coincident a una altra adreça tan bon punt arriba, també quan aquest telèfon està apagat. Alguns proveïdors limiten quant correu es pot reenviar.';

  @override
  String get rulesForwardingHiddenFooter =>
      'El reenviament només funciona a les regles del servidor, així que aquí no hi apareix.';

  @override
  String rulesRemoveAction(String action) {
    return 'Elimina $action';
  }

  @override
  String get rulesAddAction => 'Afegeix una acció';

  @override
  String get rulesAddMove => 'Mou a una carpeta…';

  @override
  String get rulesAddTagMenu => 'Afegeix una etiqueta…';

  @override
  String get rulesRemoveTagMenu => 'Treu una etiqueta…';

  @override
  String get rulesAddForward => 'Reenvia a…';

  @override
  String get rulesStopProcessing => 'No processis més regles';

  @override
  String get rulesRunOnHeader => 'Executa a';

  @override
  String get rulesRunOnDeviceFooter =>
      'Aquest dispositiu executa la regla sobre el correu nou de la safata d’entrada cada vegada que Loupe comprova el correu.';

  @override
  String get rulesRunOnServerFooter =>
      'El servidor de correu executa la regla a mesura que arriba el correu, també quan aquest telèfon està apagat. Cal Sieve, mitjançant ManageSieve (Dovecot, mailcow) o JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Aplica als missatges existents…';

  @override
  String get rulesDeleteRule => 'Suprimeix la regla';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Vols suprimir «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => 'Carpeta de quin compte?';

  @override
  String get rulesMoveAccountMessage =>
      'El correu dels altres comptes va a la carpeta amb el mateix nom de cada compte.';

  @override
  String get rulesAddTag => 'Afegeix una etiqueta';

  @override
  String get rulesRemoveTag => 'Treu una etiqueta';

  @override
  String get rulesForwardTo => 'Reenvia a';

  @override
  String get rulesForwardToMessage =>
      'El servidor reenvia cada missatge coincident a aquesta adreça, també quan aquest telèfon està apagat. Fes servir una adreça teva o de confiança.';

  @override
  String get rulesNotAnAddressTitle => 'No és una adreça electrònica';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» no és una adreça a la qual es pugui reenviar.';
  }

  @override
  String get rulesKeepCopyTitle => 'Vols guardar-ne una còpia aquí?';

  @override
  String get rulesKeepCopy => 'Guarda’n una còpia';

  @override
  String get rulesDontKeepCopy => 'No en guardis cap còpia';

  @override
  String get rulesCheckCondition => 'Revisa la condició';

  @override
  String get rulesChooseActionTitle => 'Tria una acció';

  @override
  String get rulesChooseActionMessage => 'Afegeix què fa la regla amb els missatges que coincideixen.';

  @override
  String get rulesSaveError => 'No s’ha pogut desar la regla';

  @override
  String get rulesSaveServerError => 'No s’ha pogut desar la regla del servidor';

  @override
  String get rulesRunOnDeviceInstead => 'Executa-la en aquest dispositiu';

  @override
  String get rulesNothingToApplyTitle => 'Res per aplicar';

  @override
  String get rulesNothingToApplyMessage => 'Primer dona a la regla una condició que funcioni i una acció.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplica «$rule» als missatges de…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Safates d’entrada';

  @override
  String get rulesApplyScopeAll => 'Totes les bústies';

  @override
  String get rulesFindingMessages => 'S’estan cercant missatges…';

  @override
  String get rulesSearchError => 'No s’ha pogut cercar';

  @override
  String get rulesSearchErrorUnknown => 'Alguna cosa ha fallat.';

  @override
  String get rulesNoMatchesTitle => 'Cap missatge coincideix';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Res no coincideix amb «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vols aplicar «$rule» a $countString missatges?',
      one: 'Vols aplicar «$rule» a $countString missatge?',
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
      other: 'Aplica a $countString missatges',
      one: 'Aplica a $countString missatge',
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
      other: 'S’ha aplicat «$rule» a $countString missatges',
      one: 'S’ha aplicat «$rule» a $countString missatge',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'S’està preguntant al servidor què pot fer…';

  @override
  String get rulesServerUnreachable => 'No s’ha pogut connectar amb el servidor.';

  @override
  String rulesServerProblem(String problem) {
    return 'No es pot executar al servidor: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'No es pot executar al servidor de $account: $problem';
  }

  @override
  String get rulesShowScript => 'Mostra l’script';

  @override
  String get rulesHideScript => 'Amaga l’script';

  @override
  String get rulesMatchingHeader => 'Missatges coincidents';

  @override
  String get rulesMatchingHeaderLoading => 'Missatges coincidents…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString missatges coincidents',
      one: '$countString missatge coincident',
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
      other: 'Més de $countString missatges coincidents',
      one: 'Més de $countString missatge coincident',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Dels últims 30 dies. La regla en si només actua sobre el correu nou, tret que l’apliquis als missatges existents.';

  @override
  String rulesConditionError(String error) {
    return 'La condició té un error: $error';
  }

  @override
  String get rulesPreviewNoSender => '(sense remitent)';

  @override
  String get rulesPreviewNoSubject => '(sense assumpte)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'i $countString més',
      one: 'i $countString més',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Res dels últims 30 dies.';

  @override
  String get rulesIncludeTitle => 'Activa les regles del servidor';

  @override
  String get rulesIncludeLeaveOff => 'Deixa-les desactivades';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'El servidor ja executa les regles de Loupe per a $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» és l’script actiu al servidor de $account, així que el servidor executa aquest i no les regles de Loupe. Loupe no el substituirà. Hi pot afegir aquestes línies, i aleshores el servidor executarà les regles de Loupe després de les de l’script:';
  }

  @override
  String get rulesShowWholeScript => 'Mostra l’script sencer';

  @override
  String get rulesHideWholeScript => 'Amaga l’script sencer';

  @override
  String rulesIncludeFootnote(String script) {
    return 'No canvia res més de «$script». Si més endavant se n’editen els filtres al correu web, és possible que aquest el reescrigui sense aquestes línies; aleshores Loupe tornarà a mostrar les regles del servidor com a desactivades.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Afegeix a «$script»';
  }

  @override
  String get subscriptionsTitle => 'Subscripcions';

  @override
  String get subscriptionsNewsletters => 'Butlletins';

  @override
  String get subscriptionsDiscussions => 'Debats';

  @override
  String get subscriptionsFilter => 'Filtra';

  @override
  String get subscriptionsFilterNeverRead => 'Mai llegits';

  @override
  String get subscriptionsFilterRarelyRead => 'Poc llegits';

  @override
  String get subscriptionsFilterAll => 'Tots';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'No s’han pogut comptar les subscripcions';

  @override
  String get subscriptionsNoMatches => 'Cap coincidència';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Cap butlletí no es diu «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Cap llista no es diu «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Cap butlletí';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Els butlletins i la resta de correu massiu apareixen aquí quan arriben.';

  @override
  String get subscriptionsNothingNeverRead => 'Res sense llegir mai';

  @override
  String get subscriptionsNothingRarelyRead => 'Res poc llegit';

  @override
  String get subscriptionsNothingFilteredDetail => 'Llegeixes una mica de tot el que reps.';

  @override
  String get subscriptionsNoDiscussions => 'Cap debat';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Les llistes de correu on pots escriure apareixen aquí quan n’arriba el correu.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Llistes on escriuen diverses persones. Mantén-ne premuda una per fixar-la a Bústies, llegir-la com a text sense format o moure-la a Butlletins.';

  @override
  String get subscriptionsPrivacyNote =>
      'Es calcula en aquest telèfon a partir del correu baixat; no s’envia res enlloc per fer-ho. Loupe només contacta amb un remitent quan toques Dona’t de baixa: la baixa d’un clic envia només «List-Unsubscribe=One-Click» a l’adreça que ha indicat el remitent, sense galetes ni res més sobre tu, i no en carrega mai les pàgines ni les imatges.';

  @override
  String get subscriptionsVolumeNone => 'Res últimament';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mes';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mes';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'llegit $percent';
  }

  @override
  String get subscriptionsStillSending => 'Continua enviant';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Baixa el $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Pàgina de baixa oberta el $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Un toc · contacta amb $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Per correu a $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Al lloc web $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Dona’t de baixa';

  @override
  String get subscriptionsUnsubscribeAgain => 'Torna’t a donar de baixa';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arxiva’n $countString de la safata d’entrada',
      one: 'Arxiva’n $countString de la safata d’entrada',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Crea una regla…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mou o arxiva el seu correu futur';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tracta-la com a debat';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Una llista on escriu la gent: llegeix-la com un fòrum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tracta’l com a butlletí';

  @override
  String get subscriptionsBlockSender => 'Bloqueja el remitent';

  @override
  String get subscriptionsBlock => 'Bloqueja';

  @override
  String get subscriptionsBlocked => 'Bloquejat';

  @override
  String get subscriptionsBlockedDetail => 'El correu nou va a correu brossa';

  @override
  String get subscriptionsPin => 'Fixa a Bústies';

  @override
  String get subscriptionsUnpin => 'Deixa de fixar a Bústies';

  @override
  String get subscriptionsOpenDefaultView => 'Obre a la vista per defecte';

  @override
  String get subscriptionsOpenPlainText => 'Obre com a text sense format (Mono)';

  @override
  String get subscriptionsPinned => 'Fixada';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString sense llegir',
      one: '$countString sense llegir',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Ara no hi ha correu d’aquest remitent.';

  @override
  String get subscriptionsLatestMessages => 'ÚLTIMS MISSATGES';

  @override
  String get subscriptionsMail => 'Correu';

  @override
  String get subscriptionsNoneIn90Days => 'Cap en 90 dies';

  @override
  String get subscriptionsRead => 'Llegit';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString de $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Últim rebut';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Carpetes', one: 'Carpeta');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Continua enviant';

  @override
  String get subscriptionsUnsubscribedTitle => 'Baixa';

  @override
  String subscriptionsSince(String date) {
    return 'des del $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'pàgina oberta el $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender no indica com donar-se de baixa.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender no indica com donar-se de baixa. En comptes d’això, el pots bloquejar.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'S’està donant de baixa de $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'T’has donat de baixa de $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'No s’ha pogut donar de baixa: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'No s’ha pogut donar de baixa automàticament';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Envia un correu de baixa';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Obre $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Vols obrir $site?';
  }

  @override
  String get subscriptionsOpen => 'Obre';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender gestiona les baixes al seu lloc web. La pàgina s’obre al navegador de Loupe; acaba-ho allà.';
  }

  @override
  String get subscriptionsWebInsecure => 'La connexió amb aquest lloc no està xifrada.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Compte: aquesta adreça imita $site amb lletres que s’assemblen a unes altres.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Compte: aquesta adreça imita un altre lloc amb lletres que s’assemblen a unes altres.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'No s’ha pogut obrir $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe anota la data d’avui i t’avisarà si $sender continua escrivint.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Vols donar-te de baixa de $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe contactarà amb $site per donar-te de baixa.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Aquesta és l’única vegada que Loupe contacta amb el lloc web d’un remitent. Només envia «List-Unsubscribe=One-Click» a l’adreça que ha indicat $sender, sense galetes ni res més sobre tu, i no carrega la pàgina.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'L’enllaç per donar-se de baixa no és una adreça segura d’internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site no ha respost a temps.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'No s’ha pogut contactar amb $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site ha redirigit la petició a una altra pàgina, i Loupe no segueix redireccions.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site ha rebutjat la petició (error $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'No hi ha cap compte des del qual enviar el correu de baixa.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe enviarà un correu a $to des de $from, amb l’assumpte «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'S’ha enviat el correu de baixa a $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Vols bloquejar $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'El correu nou d’aquesta llista anirà a correu brossa. Ho pots canviar a Configuració › Regles.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'El correu nou de $address anirà a correu brossa. Ho pots canviar a Configuració › Regles.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'S’ha bloquejat $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mou-ne $count a correu brossa',
      one: 'Mou-ne $count a correu brossa',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloqueja $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender ara és a Butlletins.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender ara és a Debats.';
  }

  @override
  String get appLiveGateTitle => 'No s’han pogut obrir els teus comptes';

  @override
  String get appLiveGateUnavailableBuild => 'Els comptes reals encara no estan disponibles en aquesta versió.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe no ha pogut llegir la clau que protegeix el teu correu en aquest telèfon. Sovint és temporal: torna-ho a provar o reinicia el telèfon.';

  @override
  String get appLiveGateKeyMissing =>
      'La clau que protegeix el teu correu en aquest telèfon ha desaparegut, cosa que pot passar després de restaurar una còpia de seguretat. El teu correu continua al servidor.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'No es pot llegir la base de dades del correu d’aquest telèfon: està malmesa o la seva clau ha canviat. El teu correu continua al servidor.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Alguna cosa ha fallat en obrir els teus comptes ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Se suprimiran els teus comptes i el correu desat en aquest telèfon, inclosos els missatges que esperen a la safata de sortida. El correu dels teus servidors no es veu afectat; després torna a afegir els teus comptes.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Suprimeix-ho i torna a començar';

  @override
  String get appLiveGateUseDemo => 'Fes servir el correu de demostració';

  @override
  String get appLiveGateReset => 'Restableix el correu d’aquest telèfon…';

  @override
  String get attachmentsUntitled => 'Adjunt';

  @override
  String get attachmentsUntitledFile => 'Sense títol';

  @override
  String get attachmentsOpenIn => 'Obre amb…';

  @override
  String get attachmentsSaveToFiles => 'Desa a Fitxers';

  @override
  String get attachmentsShareMenu => 'Comparteix…';

  @override
  String get attachmentsDownloadError => 'No s’ha pogut baixar l’adjunt. Comprova la connexió i torna-ho a provar.';

  @override
  String get attachmentsShareError => 'No s’ha pogut compartir l’adjunt.';

  @override
  String attachmentsNoApp(String type) {
    return 'Cap aplicació d’aquest dispositiu no pot obrir aquest fitxer ($type). Prova amb Comparteix.';
  }

  @override
  String get attachmentsOpenInError => 'No s’ha pogut obrir l’adjunt amb una altra aplicació.';

  @override
  String attachmentsSaved(String name) {
    return 'S’ha desat «$name»';
  }

  @override
  String get attachmentsSaveError => 'No s’ha pogut desar l’adjunt.';

  @override
  String get attachmentsGone => 'Aquest adjunt ja no està disponible.';

  @override
  String get attachmentsDownloadFailed => 'No s’ha pogut baixar l’adjunt.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pàgines', one: '1 pàgina');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size amb dades mòbils';
  }

  @override
  String get attachmentsLargeDownload => 'Aquest adjunt és gran. Baixa’l ara, o més tard amb wifi.';

  @override
  String get attachmentsDownload => 'Baixa';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'S’estan baixant $size…';
  }

  @override
  String get attachmentsDownloading => 'S’està baixant…';

  @override
  String get attachmentsTooLarge => 'És massa gran per previsualitzar-lo aquí.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Es mostren els primers $shown de $total. Copia’l, comparteix-lo o desa’l per obtenir-lo sencer.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Aquest PDF no es pot mostrar aquí (potser està protegit amb contrasenya).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page de $count';
  }

  @override
  String get attachmentsModeTable => 'Taula';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Missatge';

  @override
  String get attachmentsModeSource => 'Codi font';

  @override
  String get attachmentsDontWrap => 'No ajustis les línies';

  @override
  String get attachmentsWrap => 'Ajusta les línies';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines línies', one: '$lines línia');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copia-ho tot';

  @override
  String get attachmentsCopied => 'S’ha copiat';

  @override
  String get attachmentsImageUnavailable => 'Aquesta imatge no es pot mostrar aquí. Prova amb Obre amb….';

  @override
  String get attachmentsEmlNoSubject => '(Sense assumpte)';

  @override
  String get attachmentsEmlFrom => 'De';

  @override
  String get attachmentsEmlTo => 'Per a';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Aquest missatge no té text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Adjunts: $names', one: 'Adjunt: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organitzador: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I $count esdeveniments més',
      one: 'I 1 esdeveniment més',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imatge';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imatge $format';
  }

  @override
  String get attachmentsTypePdf => 'Document PDF';

  @override
  String get attachmentsTypeTsv => 'Valors separats per tabulacions';

  @override
  String get attachmentsTypeCsv => 'Full de càlcul CSV';

  @override
  String get attachmentsTypeCalendar => 'Esdeveniment de calendari';

  @override
  String get attachmentsTypeEmail => 'Missatge de correu';

  @override
  String get attachmentsTypeContact => 'Targeta de contacte';

  @override
  String get attachmentsTypeLog => 'Fitxer de registre';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'Arxiu ZIP';

  @override
  String get attachmentsTypeArchive => 'Arxiu comprimit';

  @override
  String get attachmentsTypeWord => 'Document de Word';

  @override
  String get attachmentsTypeExcel => 'Full de càlcul d’Excel';

  @override
  String get attachmentsTypePowerPoint => 'Presentació de PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Pàgina web';

  @override
  String get attachmentsTypeVideo => 'Vídeo';

  @override
  String get attachmentsTypeAudio => 'Àudio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Fitxer $extension';
  }

  @override
  String get attachmentsTypeFile => 'Fitxer';

  @override
  String get calendarUntitledEvent => 'Esdeveniment';

  @override
  String get calendarAllDay => 'Tot el dia';

  @override
  String calendarYourTime(String time) {
    return '$time a la teva hora';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Uneix-t’hi: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha acceptat: $details',
      'tentative': '$name ha acceptat provisionalment: $details',
      'declined': '$name ha rebutjat: $details',
      'delegated': '$name ha delegat: $details',
      'other': '$name no ha respost a: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha acceptat la invitació',
      'tentative': '$name ha acceptat provisionalment la invitació',
      'declined': '$name ha rebutjat la invitació',
      'delegated': '$name ha delegat la invitació',
      'other': '$name no ha respost a la invitació',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Uneix-t’hi';

  @override
  String get calendarOnlineMeeting => 'Reunió en línia';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Reunió de $provider';
  }

  @override
  String get calendarOrganizerYou => 'Tu';

  @override
  String get calendarOrganizerLabel => 'organitzador';

  @override
  String get calendarStatusAccepted => 'Acceptada';

  @override
  String get calendarStatusMaybe => 'Potser';

  @override
  String get calendarStatusDeclined => 'Rebutjada';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha acceptat',
      'tentative': '$name ha acceptat provisionalment',
      'declined': '$name ha rebutjat',
      'delegated': '$name ha delegat',
      'other': '$name no ha respost',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha acceptat:',
      'tentative': '$name ha acceptat provisionalment:',
      'declined': '$name ha rebutjat:',
      'delegated': '$name ha delegat:',
      'other': '$name no ha respost:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name proposa una hora nova';
  }

  @override
  String get calendarCounterUnknown => 'Un assistent proposa una hora nova';

  @override
  String get calendarDeclineCounter => 'L’organitzador ha mantingut l’hora';

  @override
  String calendarRefresh(String name) {
    return '$name demana la versió més recent';
  }

  @override
  String get calendarRefreshUnknown => 'Un assistent demana la versió més recent';

  @override
  String get calendarCancelled => 'Cancel·lat';

  @override
  String get calendarCancelledByOrganizer => 'L’organitzador ha cancel·lat aquest esdeveniment.';

  @override
  String get calendarCancelledLater => 'Aquest esdeveniment es va cancel·lar més tard.';

  @override
  String get calendarOutdated => 'Obsoleta';

  @override
  String get calendarOutdatedDetail => 'Aquesta invitació es va actualitzar més tard; la que compta és la més nova.';

  @override
  String calendarLocationRemoved(String location) {
    return 'S’ha tret la ubicació (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'S’ha tret la ubicació (no n’hi havia)';

  @override
  String calendarLocationChanged(String location) {
    return 'La ubicació ha canviat a $location';
  }

  @override
  String get calendarNewTitle => 'Títol nou';

  @override
  String get calendarRepeatChanged => 'La repetició ha canviat';

  @override
  String get calendarUpdated => 'Actualitzada';

  @override
  String get calendarUpdatedInvitation => 'Invitació actualitzada';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'L’hora ha canviat de $before a $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Zona horària «$zone» desconeguda: hores tal com estan escrites';
  }

  @override
  String calendarNext(String when) {
    return 'Propera: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count convidats', one: '1 convidat');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count han acceptat',
      one: '$count ha acceptat',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count potser', one: '$count potser');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count han rebutjat',
      one: '$count ha rebutjat',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (tu)';
  }

  @override
  String get calendarAttendeeOptional => 'opcional';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Vas acceptar una versió anterior.',
      'tentative': 'Vas acceptar provisionalment una versió anterior.',
      'declined': 'Vas rebutjar una versió anterior.',
      'delegated': 'Vas delegar una versió anterior.',
      'other': 'No vas respondre a una versió anterior.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Accepta';

  @override
  String get calendarMaybe => 'Potser';

  @override
  String get calendarDecline => 'Rebutja';

  @override
  String get calendarCommentHint => 'Comentari per a l’organitzador (opcional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'La teva resposta anirà a $organizer des de $address.';
  }

  @override
  String get calendarAddComment => 'Afegeix un comentari';

  @override
  String get calendarAddToCalendar => 'Afegeix al calendari';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I $count esdeveniments més al fitxer',
      one: 'I 1 esdeveniment més al fitxer',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'No hi ha cap aplicació de calendari on afegir l’esdeveniment.';

  @override
  String get calendarCantOpenCalendar => 'No s’ha pogut obrir el calendari.';

  @override
  String get calendarCantOpenLink => 'No s’ha pogut obrir l’enllaç.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Vols unir-te a la reunió de $provider?';
  }

  @override
  String get calendarJoinTitle => 'Vols unir-te a la reunió?';

  @override
  String calendarJoinOpens(String host) {
    return 'Obre $host al navegador.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Compte: aquesta adreça imita $site amb lletres que s’assemblen a unes altres.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Compte: aquesta adreça imita un altre lloc amb lletres que s’assemblen a unes altres.';

  @override
  String calendarJoinOpen(String host) {
    return 'Obre $host';
  }

  @override
  String get calendarNoOrganizer => 'Aquesta invitació no té cap organitzador a qui respondre.';

  @override
  String get calendarNoAccount => 'No hi ha cap compte des del qual respondre.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Acceptada',
      'tentative': 'Potser',
      'other': 'Rebutjada',
    });
    return '$_temp0 · s’està enviant la resposta a $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Acceptada',
      'tentative': 'Potser',
      'other': 'Rebutjada',
    });
    return '$_temp0 · s’ha enviat la resposta';
  }

  @override
  String get calendarReplyAlreadySent => 'La resposta ja s’havia enviat.';

  @override
  String get calendarReplyNotSent => 'No s’ha enviat la resposta.';

  @override
  String get dataSmimeNeedsDevice =>
      'El teu certificat S/MIME és en aquest dispositiu: obre Loupe per signar i enviar aquest missatge.';

  @override
  String dataSigningFailed(String error) {
    return 'No s’ha pogut signar: $error';
  }

  @override
  String get keyboardShortcuts => 'Dreceres de teclat';

  @override
  String get keyboardGroupGeneral => 'General';

  @override
  String get keyboardGroupMessages => 'Missatges';

  @override
  String get keyboardGroupCompose => 'Redacció';

  @override
  String get keyboardCommandPalette => 'Paleta d’ordres';

  @override
  String get keyboardBackClose => 'Enrere, tanca';

  @override
  String get keyboardNextMessage => 'Missatge següent';

  @override
  String get keyboardPreviousMessage => 'Missatge anterior';

  @override
  String get keyboardOpenMessage => 'Obre el missatge';

  @override
  String get keyboardMoveToTrash => 'Mou a la paperera';

  @override
  String get keyboardToggleRead => 'Marca com a llegit o no llegit';

  @override
  String get keyboardToggleFlag => 'Posa o treu la bandera';

  @override
  String get keyboardCloseDraft => 'Tanca (desa o suprimeix l’esborrany)';

  @override
  String get keyboardOr => 'o';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Maj';

  @override
  String get keyboardKeyEnter => 'Retorn';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Supr';

  @override
  String get keyboardKeyBackspace => 'Retrocés';

  @override
  String get mailingListsMuted => 'Fil silenciat. Els missatges nous hi arribaran com a llegits.';

  @override
  String get mailingListsUnmuted => 'El fil ja no està silenciat.';

  @override
  String get mailingListsMuteThread => 'Silencia el fil';

  @override
  String get mailingListsUnmuteThread => 'Deixa de silenciar el fil';

  @override
  String get mailingListsPin => 'Fixa a Bústies';

  @override
  String get mailingListsUnpin => 'Deixa de fixar a Bústies';

  @override
  String get mailingListsDefaultView => 'Obre a la vista per defecte';

  @override
  String get mailingListsPlainText => 'Obre com a text sense format (Mono)';

  @override
  String get mailingListsShowMuted => 'Mostra els fils silenciats';

  @override
  String get mailingListsHideMuted => 'Amaga els fils silenciats';

  @override
  String get mailingListsTreatAsNewsletter => 'Tracta-la com a butlletí';

  @override
  String get mailingListsOptions => 'Opcions de la llista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted no llegits',
      one: '$formatted no llegit',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Missatge nou a la llista';

  @override
  String get mailingListsRowUnread => 'No llegit';

  @override
  String get mailingListsRowMuted => 'Silenciat';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count respostes', one: '1 resposta');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Cap fil';

  @override
  String get mailingListsMutedHidden => 'Els fils silenciats estan amagats.';

  @override
  String get mailingListsTechnicalTitle => 'Llistes tècniques';

  @override
  String get mailingListsTechnicalEmpty => 'Les llistes de correu apareixen aquí quan n’arriba el correu.';

  @override
  String get mailingListsTechnicalFooter =>
      'Els missatges d’aquestes llistes s’obren com a text sense format amb una lletra monoespaiada, i els pedaços es mostren com a diffs. El botó Aa continua canviant la vista de qualsevol missatge.';

  @override
  String get paletteMoveToMailbox => 'Mou a una bústia…';

  @override
  String get paletteMarkAllRead => 'Marca-ho tot com a llegit';

  @override
  String get paletteExportFolder => 'Exporta la carpeta…';

  @override
  String get paletteGetNewMail => 'Rep correu nou';

  @override
  String get paletteSnoozed => 'Posposats';

  @override
  String get paletteSubscriptions => 'Subscripcions';

  @override
  String get paletteDiscussions => 'Debats';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Llista de correu';

  @override
  String get paletteTag => 'Etiqueta';

  @override
  String get paletteSwipeActions => 'Accions en lliscar';

  @override
  String get paletteNotifications => 'Notificacions';

  @override
  String get paletteRules => 'Regles';

  @override
  String get paletteEncryption => 'Xifratge d’extrem a extrem';

  @override
  String get paletteAdvanced => 'Opcions avançades';

  @override
  String get paletteAddAccount => 'Afegeix un compte';

  @override
  String get paletteAccount => 'Compte';

  @override
  String get paletteFolders => 'Carpetes';

  @override
  String get paletteRecentSearch => 'Cerca recent';

  @override
  String paletteSearchMail(String query) {
    return 'Cerca «$query» al correu';
  }

  @override
  String get palettePlaceholder => 'Cerca accions, bústies, configuració';

  @override
  String get paletteNothingFound => 'No s’ha trobat res';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox nova';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Mostra tot el que coincideixi amb «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'S’ha desat «$name» a Bústies';
  }

  @override
  String get searchMakeRule => 'Converteix-la en una regla';

  @override
  String get searchSaveSmartMailbox => 'Desa com a Smart Mailbox';

  @override
  String get searchNegate => 'Nega';

  @override
  String get searchDontNegate => 'No neguis';

  @override
  String get searchAllMailboxes => 'Totes les bústies';

  @override
  String get searchRecent => 'Cerques recents';

  @override
  String get searchClear => 'Esborra';

  @override
  String get searchSuggestions => 'Suggeriments';

  @override
  String get searchUnreadMessages => 'Missatges no llegits';

  @override
  String get searchFlaggedMessages => 'Missatges amb bandera';

  @override
  String get searchWithAttachments => 'Missatges amb adjunts';

  @override
  String get searchUnrepliedMessages => 'Missatges sense resposta';

  @override
  String get searchTags => 'Etiquetes';

  @override
  String get searchPeople => 'Persones';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De: $name';
  }

  @override
  String get searchSearching => 'S’està cercant…';

  @override
  String get searchNoResults => 'Cap resultat';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted resultats',
      one: '$formatted resultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menú de cerca';

  @override
  String searchSearchingAccount(String account) {
    return 'S’està cercant a $account al servidor…';
  }

  @override
  String get searchSearchingUnknownAccount => 'S’està cercant al compte al servidor…';

  @override
  String searchAccountFailed(String account) {
    return 'No s’ha pogut cercar a $account al servidor';
  }

  @override
  String get searchUnknownAccountFailed => 'No s’ha pogut cercar al compte al servidor';

  @override
  String searchChip(String term) {
    return '$term. Fes doble toc per editar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'No $term. Fes doble toc per editar.';
  }

  @override
  String get searchReadAndUnread =>
      'La safata de Schrödinger: aquí cada missatge està llegit i no llegit fins que l’obres.';

  @override
  String searchContradiction(String term) {
    return 'Cap missatge no pot ser «$term» i no ser-ho alhora.';
  }

  @override
  String get searchSyncDeviceOnly => 'Només en aquest dispositiu';

  @override
  String searchSyncUnsupported(String account) {
    return 'Només en aquest dispositiu: $account no la pot guardar';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'No sincronitzada: $account té un format més nou';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Pendent de sincronitzar amb $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronitzada amb $account';
  }

  @override
  String get searchRename => 'Canvia el nom';

  @override
  String get searchEditSearch => 'Edita la cerca';

  @override
  String get searchDeleteSmartMailbox => 'Suprimeix la Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Canvia el nom de la Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Aquesta Smart Mailbox s’ha suprimit.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Les Smart Mailboxes es queden en aquest dispositiu.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Les Smart Mailboxes es guarden al teu servidor de correu, així que també les tenen els teus altres dispositius, i Thunderbird amb Expression Search Reloaded. Les que cerquen a tots els comptes es guarden a $account; les d’una sola carpeta, al compte d’aquesta carpeta.';
  }

  @override
  String get searchSyncVia => 'Sincronitza mitjançant';

  @override
  String get searchSyncViaFooter => 'Tria el mateix compte a tots els dispositius.';

  @override
  String get searchGmailCantKeep => 'Gmail no pot guardar Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Guarda les Smart Mailboxes només en aquest dispositiu';

  @override
  String get searchOnTheServer => 'Al servidor';

  @override
  String get searchServerFooter =>
      'Les metadades del servidor (IMAP METADATA) no es veuen a cap aplicació de correu. Els servidors que no en tenen reben una carpeta «Loupe Settings» amb un missatge; Loupe l’amaga a Bústies.';

  @override
  String get searchSyncNow => 'Sincronitza ara';

  @override
  String get searchStateUnsupported => 'No compatible';

  @override
  String get searchStateNewerFormat => 'Format més nou';

  @override
  String get searchStateFailed => 'No s’ha pogut sincronitzar';

  @override
  String get searchStateSyncing => 'S’està sincronitzant…';

  @override
  String get searchStateWaiting => 'Pendent';

  @override
  String get searchStateMetadata => 'Metadades del servidor';

  @override
  String get searchStateFolder => 'Carpeta Loupe Settings';

  @override
  String get searchStateNothing => 'No hi ha res guardat';

  @override
  String get sharedBack => 'Enrere';

  @override
  String get sharedYesterday => 'Ahir';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date a les $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bytes', one: '$count byte');
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size kB';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size MB';
  }

  @override
  String get sharedSyncNoAccounts => 'Cap compte';

  @override
  String get sharedSyncChecking => 'S’està comprovant el correu…';

  @override
  String get sharedSyncFailed => 'No s’ha pogut comprovar el correu';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Sense connexió';

  @override
  String get sharedSyncJustNow => 'Actualitzat ara mateix';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Actualitzat fa $minutes minuts',
      one: 'Actualitzat fa 1 minut',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Actualitzat a les $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Actualitzat el $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Totes les safates d’entrada';

  @override
  String get sharedMailboxUnread => 'No llegits';

  @override
  String get sharedMailboxFlagged => 'Amb bandera';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Tots els esborranys';

  @override
  String get sharedMailboxAllSent => 'Tots els enviats';

  @override
  String get sharedMailboxUntitled => 'Bústia';

  @override
  String get sharedTagImportant => 'Important';

  @override
  String get sharedTagWork => 'Feina';

  @override
  String get sharedTagPersonal => 'Personal';

  @override
  String get sharedTagToDo => 'Per fer';

  @override
  String get sharedTagLater => 'Més tard';

  @override
  String get sharedTags => 'Etiquetes';

  @override
  String get sharedMoveTo => 'Mou a…';

  @override
  String get sharedNoRecipients => 'Sense destinataris';

  @override
  String get sharedUnknownSender => 'Remitent desconegut';

  @override
  String get sharedOnServer => 'Al servidor';

  @override
  String get sharedAttachment => 'Adjunt';

  @override
  String get sharedSnoozedBadge => 'Posposat';

  @override
  String get sharedRowUnread => 'No llegit';

  @override
  String get sharedRowBackFromSnooze => 'Tornat de posposar';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Amb bandera';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han arxivat $count missatges',
      one: 'S’ha arxivat 1 missatge',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han suprimit $count missatges',
      one: 'S’ha suprimit 1 missatge',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han mogut $count missatges a la safata d’entrada',
      one: 'S’ha mogut 1 missatge a la safata d’entrada',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han mogut $count missatges a la paperera',
      one: 'S’ha mogut 1 missatge a la paperera',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han mogut $count missatges a correu brossa',
      one: 'S’ha mogut 1 missatge a correu brossa',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han mogut $count missatges a $mailbox',
      one: 'S’ha mogut 1 missatge a $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han mogut $count missatges a una bústia',
      one: 'S’ha mogut 1 missatge a una bústia',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han posposat $count missatges fins a $time',
      one: 'S’ha posposat 1 missatge fins a $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Posposat fins a $time només en aquest dispositiu: el servidor no pot guardar les hores de posposició.';
  }

  @override
  String get sharedMoveOneAccount => 'Selecciona missatges d’un sol compte per moure’ls.';

  @override
  String get sharedSnoozeTitle => 'Posposa';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Canvia l’hora de posposició';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vols suprimir definitivament $count missatges?',
      one: 'Vols suprimir definitivament aquest missatge?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Això no es pot desfer.';

  @override
  String get sharedDeletePermanently => 'Suprimeix definitivament';

  @override
  String get sharedSwipeRead => 'Llegit';

  @override
  String get sharedSwipeUnread => 'No llegit';

  @override
  String get sharedSwipeInbox => 'Entrada';

  @override
  String get sharedSwipeDelete => 'Suprimeix';

  @override
  String get sharedTrash => 'Paperera';

  @override
  String get sharedSwipeSnooze => 'Posposa';

  @override
  String get sharedWakeNow => 'Recupera’l ara';

  @override
  String get sharedChangeSnoozeTime => 'Canvia l’hora de posposició…';

  @override
  String get sharedSnooze => 'Posposa…';

  @override
  String get sharedTag => 'Etiqueta…';

  @override
  String get sharedMoveMessage => 'Mou el missatge…';

  @override
  String get sharedNotJunk => 'No és correu brossa';

  @override
  String get accountSetupTitle => 'Afegeix un compte';

  @override
  String get accountSetupTitleDone => 'S’ha afegit el compte';

  @override
  String get accountSetupAddressTitle => 'Afegeix un compte de correu';

  @override
  String get accountSetupAddressText => 'Loupe troba la configuració de la majoria de proveïdors.';

  @override
  String get accountSetupNameHint => 'El teu nom';

  @override
  String get accountSetupEmail => 'Correu electrònic';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Continua';

  @override
  String get accountSetupLookingUp => 'S’està cercant la configuració…';

  @override
  String get accountSetupImport => 'Importa de Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Introdueix una adreça electrònica vàlida.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'No s’ha trobat la configuració de $domain. Introdueix-la a continuació.';
  }

  @override
  String get accountSetupCheckServers => 'Comprova els noms dels servidors i els ports.';

  @override
  String get accountSetupEnterPassword => 'Introdueix la contrasenya.';

  @override
  String get accountSetupConnecting => 'S’està connectant…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'S’està esperant $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'No s’ha pogut obrir la pàgina.';

  @override
  String get accountSetupCouldNotSaveName => 'No s’ha pogut desar el nom.';

  @override
  String get accountSetupTrustCertificate => 'Confia en aquest certificat';

  @override
  String get accountSetupPasswordRequired => 'Obligatòria';

  @override
  String get accountSetupShowPassword => 'Mostra la contrasenya';

  @override
  String get accountSetupHidePassword => 'Amaga la contrasenya';

  @override
  String get accountSetupAppPassword => 'Contrasenya d’aplicació';

  @override
  String get accountSetupApiToken => 'Testimoni d’API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Entrant · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Sortint · SMTP';

  @override
  String get accountSetupSignIn => 'Inicia la sessió';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Inicia la sessió amb $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Fes servir una contrasenya d’aplicació';

  @override
  String get accountSetupUseAppPasswordInstead => 'Fes servir una contrasenya d’aplicació';

  @override
  String get accountSetupUseDifferentAddress => 'Fes servir una altra adreça';

  @override
  String get accountSetupHowToCreateAppPassword => 'Com crear una contrasenya d’aplicació';

  @override
  String get accountSetupHowToCreateOne => 'Com crear-ne una';

  @override
  String get accountSetupGoogleNote =>
      'Inicies la sessió a la pàgina de Google, i Loupe no veu mai la teva contrasenya. Permet que Loupe llegeixi, enviï i organitzi el teu correu.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Inicia la sessió amb Google» encara no està disponible en aquesta versió. Pots connectar-te amb una contrasenya d’aplicació (cal tenir activada la verificació en dos passos al teu compte de Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Crea una contrasenya d’aplicació al teu compte de Google i enganxa-la a continuació.';

  @override
  String get accountSetupMicrosoftNote =>
      'Inicies la sessió a la pàgina de Microsoft, i Loupe no veu mai la teva contrasenya. Funciona amb Outlook.com i Hotmail, i amb comptes de feina o de centres educatius de Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'L’inici de sessió de Microsoft arribarà en una versió posterior. Els comptes d’Outlook, Hotmail i Microsoft 365 el necessiten: ja no accepten contrasenyes de les aplicacions de correu.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail necessita una contrasenya específica per a aplicacions, no la contrasenya del teu compte d’Apple.';

  @override
  String get accountSetupYahooNote =>
      'Yahoo Mail necessita una contrasenya d’aplicació, no la contrasenya del teu compte.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe es connecta a Fastmail per JMAP amb un testimoni d’API: Settings › Privacy & Security › Manage API tokens, per a JMAP, amb accés al correu i a l’enviament.';

  @override
  String get accountSetupFastmailNote =>
      'Fastmail necessita una contrasenya d’aplicació per a les aplicacions de correu.';

  @override
  String get accountSetupServerSettings => 'Configuració del servidor';

  @override
  String get accountSetupSettingsNotFound => 'No s’ha trobat automàticament';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Trobada mitjançant $source';
  }

  @override
  String get accountSetupEditSettings => 'Edita la configuració';

  @override
  String get accountSetupSyncing => 'El teu correu s’està sincronitzant.';

  @override
  String get accountSetupDescription => 'Descripció';

  @override
  String get accountSetupDescriptionHint => 'Feina, Personal…';

  @override
  String get accountSetupColour => 'Color';

  @override
  String accountSetupColourNumber(int number) {
    return 'Color $number';
  }

  @override
  String get accountSetupSaving => 'S’està desant…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe no ha pogut obrir la seva base de dades de correu en aquest telèfon. Tanca Loupe, torna-la a obrir i torna-ho a provar.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Alguna cosa ha fallat ($error). Torna-ho a provar.';
  }

  @override
  String get accountSetupSecurityNone => 'Cap';

  @override
  String get accountSetupProtocol => 'Protocol';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Seguretat';

  @override
  String get accountSetupUsername => 'Nom d’usuari';

  @override
  String get accountSetupUsernameHint => 'La teva adreça electrònica';

  @override
  String get accountSetupNoEncryptionTitle => 'Vols connectar-te sense xifratge?';

  @override
  String get accountSetupNoEncryptionText =>
      'La teva contrasenya i tots els missatges viatjarien com a text sense xifrar. Qualsevol persona de la xarxa, com una wifi pública, els podria llegir. Fes-ho servir només amb un servidor de la teva pròpia xarxa.';

  @override
  String get accountSetupUseWithoutEncryption => 'Fes-lo servir sense xifratge';

  @override
  String get accountSetupApiTokenRejected =>
      'S’ha rebutjat el testimoni d’API. Crea un testimoni d’API de Fastmail per a JMAP amb accés al correu i enganxa’l.';

  @override
  String get accountSetupAppPasswordRejected =>
      'S’ha rebutjat la contrasenya. Fes servir una contrasenya d’aplicació, no la contrasenya del teu compte.';

  @override
  String get accountSetupPasswordRejected => 'S’ha rebutjat la contrasenya. Comprova-la i torna-ho a provar.';

  @override
  String get accountSetupServerUnreachable =>
      'No es pot connectar amb el servidor. Comprova la configuració del servidor i la connexió.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'El certificat del servidor no és de confiança. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'S’ha cancel·lat l’inici de sessió. Toca «Inicia la sessió amb $provider» per tornar-ho a provar.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe necessita permís per llegir i enviar el teu correu de Gmail. Torna a iniciar la sessió i permet l’accés, amb la casella de Gmail marcada.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe necessita permís per llegir i enviar el teu correu. Torna a iniciar la sessió i accepta els permisos.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'La teva organització ha d’aprovar Loupe abans que la puguis fer servir amb aquest compte. Demana a l’administrador d’informàtica que concedeixi el consentiment d’administrador a Loupe a Microsoft Entra ID i torna-ho a provar.';

  @override
  String get accountSetupOAuthBlocked =>
      'Les regles d’inici de sessió de la teva organització no permeten Loupe en aquest dispositiu. Pregunta-ho a l’administrador d’informàtica.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'No s’ha pogut connectar amb $provider. Comprova la connexió a internet i torna-ho a provar.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'L’inici de sessió amb $provider no està ben configurat en aquesta versió de Loupe. Informa’ns-en, si us plau.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'L’inici de sessió amb $provider no ha funcionat. Torna-ho a provar.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider t’ha iniciat la sessió, però Gmail ha denegat l’accés per a aquesta adreça. Tria el mateix compte quan iniciïs la sessió. És possible que l’administrador hagi desactivat IMAP als comptes de feina o de centres educatius.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider t’ha iniciat la sessió, però el servidor de correu ha denegat l’accés per a aquesta adreça. Tria el mateix compte quan iniciïs la sessió. És possible que l’administrador hagi desactivat IMAP als comptes de feina o de centres educatius.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'No es pot connectar amb el servidor de correu. Comprova la connexió i torna-ho a provar.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'L’inici de sessió amb $provider no està disponible en aquesta versió.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'S’ha tornat a iniciar la sessió. $account s’està sincronitzant.';
  }

  @override
  String get accountSetupSignInAgain => 'Torna a iniciar la sessió';

  @override
  String get accountSetupSigningIn => 'S’està iniciant la sessió…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider ja no accepta l’inici de sessió de Loupe per a $email, així que $account no s’està sincronitzant. Torna a iniciar la sessió per rebre’n el correu.';
  }

  @override
  String get accountImportTitle => 'Importa de Thunderbird';

  @override
  String get accountImportPointCamera => 'Apunta la càmera al codi QR que mostra Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned de $total escanejats';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned de $total codis escanejats',
      one: '$scanned de $total codi escanejat',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes fins ara',
      one: '1 compte fins ara',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'A l’ordinador, obre Thunderbird i tria Eines › Exporta per al mòbil. Selecciona els teus comptes i escaneja cada codi que mostri. Els codis es poden escanejar en qualsevol ordre.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continua amb $count comptes',
      one: 'Continua amb 1 compte',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Enganxa el text';

  @override
  String get accountImportStartOver => 'Torna a començar';

  @override
  String get accountImportDuplicateCode => 'Aquest codi ja s’havia afegit.';

  @override
  String get accountImportRestarted =>
      'Aquest codi és d’una exportació nova, així que s’han descartat els codis escanejats abans.';

  @override
  String get accountImportNotThunderbird => 'Aquest no és un codi de compte de Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Aquest codi prové d’un Thunderbird més nou. Actualitza Loupe per importar-lo.';

  @override
  String get accountImportDamaged => 'No s’ha pogut llegir aquest codi de Thunderbird.';

  @override
  String get accountImportTooLarge => 'Aquest codi és massa gran per ser una exportació de Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'No s’ha pogut obrir la configuració.';

  @override
  String get accountImportCameraOffTitle => 'L’accés a la càmera està desactivat';

  @override
  String get accountImportCameraOffText =>
      'Permet que Loupe faci servir la càmera a la configuració per escanejar el codi, o enganxa el text del codi.';

  @override
  String get accountImportNoCameraTitle => 'No hi ha càmera';

  @override
  String get accountImportNoCameraText => 'Loupe no pot fer servir cap càmera aquí. Enganxa el text del codi.';

  @override
  String get accountImportCameraFailedTitle => 'La càmera no s’ha iniciat';

  @override
  String get accountImportCameraFailedText => 'Torna-ho a provar, o enganxa el text del codi.';

  @override
  String get accountImportOpenSettings => 'Obre la configuració';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'S’han trobat $count comptes',
      one: 'S’ha trobat 1 compte',
      zero: 'No s’ha trobat cap compte',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'No s’ha pogut llegir cap dels comptes d’aquests codis.';

  @override
  String get accountImportChoose => 'Tria els comptes que vols afegir a Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Els codis $codes de $total no s’han escanejat, així que els seus comptes no hi apareixen.',
      one: 'El codi $codes de $total no s’ha escanejat, així que els seus comptes no hi apareixen.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes i $last';
  }

  @override
  String get accountImportScanMore => 'Escaneja més codis';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'No s’han pogut llegir $count comptes dels codis. Potser fan servir configuració d’un Thunderbird més nou.',
      one: 'No s’ha pogut llegir 1 compte dels codis. Potser fa servir configuració d’un Thunderbird més nou.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Torna a escanejar';

  @override
  String get accountImportAlreadyAdded => 'Ja hi ha un compte amb aquesta adreça a Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Iniciaràs la sessió amb $provider quan s’afegeixi, com a Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Afegeix el compte amb una contrasenya d’aplicació (cal tenir activada la verificació en dos passos).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird inicia la sessió a Gmail amb Google. «Inicia la sessió amb Google» arribarà en una versió posterior; fins aleshores, afegeix el compte amb una contrasenya d’aplicació (cal tenir activada la verificació en dos passos).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird inicia la sessió en aquest compte al navegador. Loupe encara no ho pot fer: fes servir una contrasenya d’aplicació si el teu proveïdor n’ofereix.';

  @override
  String get accountImportUnencrypted => 'Es connecta sense xifratge. Fes-ho servir només a la teva pròpia xarxa.';

  @override
  String get accountImportEnterAgain => 'Torna-la a introduir';

  @override
  String get accountImportAdded => 'Afegit';

  @override
  String accountImportAdding(int index, int total) {
    return 'S’està afegint el $index de $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Afegeix $count comptes',
      one: 'Afegeix 1 compte',
      zero: 'Afegeix comptes',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Enganxa el text d’exportació';

  @override
  String get accountImportPasteText => 'Enganxa el text d’un codi d’exportació de Thunderbird, un codi per línia.';

  @override
  String get accountImportPop3 => 'Els comptes POP3 no són compatibles. Loupe manté el correu al servidor amb IMAP.';

  @override
  String get accountImportKerberos => 'Aquest compte inicia la sessió amb Kerberos, que Loupe no admet.';

  @override
  String get accountImportNtlm => 'Aquest compte inicia la sessió amb NTLM, que Loupe no admet.';

  @override
  String get accountImportClientCertificate =>
      'Aquest compte inicia la sessió amb un certificat de client, que Loupe encara no admet.';

  @override
  String get accountImportMicrosoftSignIn =>
      'L’inici de sessió de Microsoft arribarà en una versió posterior. Els comptes d’Outlook i Microsoft 365 ja no accepten contrasenyes de les aplicacions de correu.';

  @override
  String get accountImportEnterPassword => 'Introdueix la contrasenya.';

  @override
  String get accountImportEnterAppPassword => 'Introdueix la contrasenya d’aplicació.';

  @override
  String get accountImportEnterApiToken => 'Introdueix el testimoni d’API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe no ha pogut obrir l’emmagatzematge de comptes. Torna-ho a provar més tard.';

  @override
  String get accountImportFailed => 'No s’ha pogut afegir el compte. Torna-ho a provar o afegeix-lo manualment.';

  @override
  String get composeNewMessageTitle => 'Missatge nou';

  @override
  String get composeAttach => 'Adjunta';

  @override
  String get composeSendLater => 'Envia més tard';

  @override
  String composeSendAt(String time) {
    return 'Envia $time';
  }

  @override
  String get composeSendHint => 'Mantén premut per enviar més tard';

  @override
  String get composeNoAccount => 'Afegeix un compte per enviar correu.';

  @override
  String get composeTo => 'Per a:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Cco:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Cco, De: $email';
  }

  @override
  String get composeFromLabel => 'De:';

  @override
  String get composeSubjectLabel => 'Assumpte:';

  @override
  String composeReplyTo(String address) {
    return 'Respon a: $address';
  }

  @override
  String get composeFrom => 'De';

  @override
  String composeReplyFrom(String email) {
    return 'Respon des de $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Envia des de $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Vols respondre des de $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Vols enviar des de $email?';
  }

  @override
  String get composeDismiss => 'Descarta';

  @override
  String composeAliasNotSaved(String account) {
    return 'No desada com a identitat · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Desa com a identitat';

  @override
  String composeAliasSaved(String email) {
    return '$email s’ha desat com a identitat.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Adreça no vàlida $address';
  }

  @override
  String get composeOriginalNotFound => 'No s’ha trobat el missatge original.';

  @override
  String get composeDraftNotFound => 'No s’ha trobat l’esborrany.';

  @override
  String get composeAttachmentsLost => 'No s’han pogut recuperar els adjunts. Torna’ls a afegir.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'No s’han pogut afegir alguns adjunts: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Els adjunts sumen $size; alguns servidors rebutgen missatges tan grans.';
  }

  @override
  String get composeAttachFailed => 'No s’ha pogut adjuntar el fitxer.';

  @override
  String get composeInvalidAddressTitle => 'Adreça no vàlida';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» no és una adreça electrònica vàlida.';
  }

  @override
  String get composeNoSubjectTitle => 'Sense assumpte';

  @override
  String get composeNoSubjectText => 'Aquest missatge no té assumpte. El vols enviar igualment?';

  @override
  String get composeSentBeforeChanges => 'S’ha enviat abans dels teus canvis, que s’han desat a Esborranys.';

  @override
  String composeScheduled(String time) {
    return 'Programat per a $time';
  }

  @override
  String get composeSending => 'S’està enviant…';

  @override
  String get composeSent => 'S’ha enviat';

  @override
  String get composeSendFailed => 'No s’ha pogut enviar. Torna-ho a provar.';

  @override
  String get composeAlreadySent => 'Ja s’ha enviat.';

  @override
  String get composeDiscardChanges => 'Descarta els canvis';

  @override
  String get composeSaveChanges => 'Desa els canvis';

  @override
  String get composeDeleteDraft => 'Suprimeix l’esborrany';

  @override
  String get composeSaveDraft => 'Desa l’esborrany';

  @override
  String get composeDraftSaved => 'S’ha desat l’esborrany';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'El $date a les $time, $name va escriure:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'El $date a les $time, algú va escriure:';
  }

  @override
  String get composeForwardHeader => '---------- Missatge reenviat ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date a les $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Assumpte: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Per a: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Més tard avui';

  @override
  String get composeTomorrowMorning => 'Demà al matí';

  @override
  String get composeMondayMorning => 'Dilluns al matí';

  @override
  String get composePickDateTime => 'Tria la data i l’hora…';

  @override
  String get composeSendWithoutDelay => 'Envia sense esperar';

  @override
  String composeSendTimeToday(String time) {
    return 'Avui a les $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Demà a les $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day a les $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Avui $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Demà $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Vols continuar editant l’esborrany?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Un missatge no es va enviar quan es va tancar Loupe.',
      'one': 'Un missatge per a $name no es va enviar quan es va tancar Loupe.',
      'other': 'Un missatge per a $name i altres no es va enviar quan es va tancar Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» no es va enviar quan es va tancar Loupe.',
      'one': '«$subject» per a $name no es va enviar quan es va tancar Loupe.',
      'other': '«$subject» per a $name i altres no es va enviar quan es va tancar Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Continua editant';

  @override
  String get composeRecoverySave => 'Desa a Esborranys';

  @override
  String get composeRecoveryDiscard => 'Descarta';

  @override
  String get composeRecoverySaved => 'S’ha desat a Esborranys';

  @override
  String get outboxSectionFailed => 'No enviats';

  @override
  String get outboxSectionSending => 'S’estan enviant';

  @override
  String get outboxSectionScheduled => 'Programats';

  @override
  String get outboxStatusQueued => 'S’enviarà aviat';

  @override
  String get outboxStatusSending => 'S’està enviant…';

  @override
  String get outboxStatusFailed => 'No enviat';

  @override
  String get outboxNoRecipients => 'Sense destinataris';

  @override
  String get outboxNoSubject => '(Sense assumpte)';

  @override
  String get outboxSendingFailed => 'No s’ha pogut enviar.';

  @override
  String get outboxEmptyTitle => 'Res per enviar';

  @override
  String get outboxEmptyText => 'Els missatges que envies més tard esperen aquí fins que arriba l’hora.';

  @override
  String get outboxSendNow => 'Envia ara';

  @override
  String get outboxReschedule => 'Reprograma';

  @override
  String get outboxRescheduleMenu => 'Reprograma…';

  @override
  String get outboxRescheduleTitle => 'Reprograma';

  @override
  String outboxRescheduled(String time) {
    return 'Reprogramat per a $time';
  }

  @override
  String get outboxCancel => 'Cancel·la';

  @override
  String get outboxCancelSending => 'Cancel·la l’enviament…';

  @override
  String get outboxCancelTitle => 'Vols cancel·lar l’enviament?';

  @override
  String get outboxMoveToDrafts => 'Mou a Esborranys';

  @override
  String get outboxDiscard => 'Descarta el missatge';

  @override
  String get outboxMovedToDrafts => 'S’ha mogut a Esborranys';

  @override
  String get outboxDiscarded => 'S’ha descartat el missatge';

  @override
  String get outboxAlreadySent => 'Ja s’ha enviat.';

  @override
  String get outboxBeingSent => 'Aquest missatge s’està enviant.';

  @override
  String get outboxActionFailed => 'No ha funcionat. El missatge continua a la safata de sortida.';

  @override
  String get notificationsBadgeInboxes => 'No llegits a les safates d’entrada';

  @override
  String get notificationsBadgeVip => 'No llegits de VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Correu nou dels teus VIP, a qualsevol compte';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Correu nou a $email';
  }

  @override
  String get notificationsUnknownSender => 'Remitent desconegut';

  @override
  String get notificationsNoSubject => '(Sense assumpte)';

  @override
  String get notificationsEncryptedMessage => 'Missatge xifrat';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Missatge nou de $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count missatges nous',
      one: '1 missatge nou',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Missatges nous a $account';
  }

  @override
  String get platformInstantChannel => 'Lliurament instantani';

  @override
  String get platformInstantChannelDescription =>
      'Es mostra mentre Loupe vigila si arriba correu nou a les teves safates d’entrada';

  @override
  String get platformInstantTitle => 'Pendent del correu nou';

  @override
  String get platformInstantText => 'El lliurament instantani està activat';

  @override
  String get platformErrorBox => 'Alguna cosa ha fallat en mostrar això. Torna enrere i torna-ho a provar.';

  @override
  String get welcomeTagline => 'Correu senzill per fora\ni potent per dins.';

  @override
  String get welcomeAccountsTitle => 'Tots els comptes, una safata serena';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail i qualsevol servidor IMAP o JMAP.';

  @override
  String get welcomeSearchTitle => 'Una cerca que ho troba';

  @override
  String get welcomeSearchText => 'Resultats a l’instant al telèfon i, després, els del servidor.';

  @override
  String get welcomePrivacyTitle => 'Privada per disseny';

  @override
  String get welcomePrivacyText => 'Sense seguiment. Les imatges remotes continuen bloquejades fins que tu ho diguis.';

  @override
  String get welcomeAddAccount => 'Afegeix un compte';

  @override
  String get welcomeImport => 'Importa de Thunderbird';

  @override
  String get welcomeTryDemo => 'Prova-ho amb correu de demostració';
}
