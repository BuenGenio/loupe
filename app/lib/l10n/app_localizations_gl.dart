// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get commonAdd => 'Engadir';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Pechar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonDone => 'Feito';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonMore => 'Máis';

  @override
  String get commonMove => 'Mover';

  @override
  String get commonName => 'Nome';

  @override
  String get commonNone => 'Ningún';

  @override
  String get commonOff => 'Desactivado';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonOn => 'Activado';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonPassword => 'Contrasinal';

  @override
  String get commonRemove => 'Quitar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonSave => 'Gardar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonServer => 'Servidor';

  @override
  String get commonSettings => 'Configuración';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonTryAgain => 'Tentar de novo';

  @override
  String get commonUndo => 'Desfacer';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensaxes', one: '1 mensaxe');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arquivar';

  @override
  String get mailDelete => 'Eliminar';

  @override
  String get mailFlag => 'Marcar cunha bandeira';

  @override
  String get mailForward => 'Reenviar';

  @override
  String get mailMarkAsRead => 'Marcar como lida';

  @override
  String get mailMarkAsUnread => 'Marcar como sen ler';

  @override
  String get mailMoveToJunk => 'Mover ao correo lixo';

  @override
  String get mailNewMessage => 'Nova mensaxe';

  @override
  String get mailNoSubject => 'Sen asunto';

  @override
  String get mailReply => 'Responder';

  @override
  String get mailReplyAll => 'Responder a todos';

  @override
  String get mailSend => 'Enviar';

  @override
  String get mailUnflag => 'Quitar a bandeira';

  @override
  String get mailboxArchive => 'Arquivo';

  @override
  String get mailboxDrafts => 'Borradores';

  @override
  String get mailboxInbox => 'Caixa de entrada';

  @override
  String get mailboxJunk => 'Correo lixo';

  @override
  String get mailboxOutbox => 'Caixa de saída';

  @override
  String get mailboxSent => 'Enviados';

  @override
  String get mailboxTrash => 'Papeleira';

  @override
  String get conversationSomethingWentWrong => 'Algo fallou. Téntao de novo.';

  @override
  String get conversationReplyToList => 'Responder á lista';

  @override
  String get conversationReplyList => 'Responder á lista';

  @override
  String get conversationThreadMuted => 'Fío silenciado. As novas mensaxes del chegarán como lidas.';

  @override
  String get conversationThreadUnmuted => 'O fío xa non está silenciado.';

  @override
  String get conversationLinkFailed => 'Non se puido abrir a ligazón.';

  @override
  String get conversationGoneTitle => 'Sen mensaxe';

  @override
  String get conversationGoneText => 'Esta mensaxe moveuse ou eliminouse.';

  @override
  String get conversationMuted => 'Silenciado';

  @override
  String get conversationReaderOptions => 'Opcións de lectura';

  @override
  String get conversationReaderOptionsHint => 'Tamaño do texto e vista';

  @override
  String get conversationTrash => 'Papeleira';

  @override
  String get conversationReplyHint => 'Mantén premido para Responder a todos e Reenviar';

  @override
  String get conversationOfflineTitle => 'Sen conexión';

  @override
  String get conversationOfflineText => 'Esta conversa aínda non se descargou. Cargarase cando volvas ter conexión.';

  @override
  String get conversationErrorTitle => 'Non se pode mostrar esta mensaxe';

  @override
  String get conversationErrorText => 'Algo fallou.';

  @override
  String get conversationOfflineBanner => 'Sen conexión';

  @override
  String get conversationNotUpdated => 'Sen actualizar';

  @override
  String get conversationMe => 'min';

  @override
  String get conversationNoSender => '(sen remitente)';

  @override
  String get conversationNoRecipients => 'sen destinatarios';

  @override
  String conversationRecipients(String names) {
    return 'para $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'para $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'De';

  @override
  String get conversationHeaderTo => 'Para';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Cco';

  @override
  String get conversationHeaderReplyTo => 'Responder a';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Seguridade';

  @override
  String get conversationVerifiedSender => 'Remitente verificado';

  @override
  String get conversationUnverifiedSender => 'Remitente sen verificar';

  @override
  String get conversationLoadingMessage => 'Cargando a mensaxe';

  @override
  String get conversationBodyError => 'Non se puido cargar esta mensaxe.';

  @override
  String get conversationBodyOffline => 'Estás sen conexión. A mensaxe cargarase cando volvas ter conexión.';

  @override
  String get conversationOriginalHint => 'Vese mellor na vista Orixinal';

  @override
  String get conversationShowOriginal => 'Ver o orixinal';

  @override
  String get conversationScrollToTop => 'Desprazarse ao principio';

  @override
  String get conversationTagsMenu => 'Etiquetas…';

  @override
  String get conversationMuteThread => 'Silenciar o fío';

  @override
  String get conversationUnmuteThread => 'Deixar de silenciar o fío';

  @override
  String get conversationMoveMenu => 'Mover…';

  @override
  String get conversationDeletePermanently => 'Eliminar definitivamente';

  @override
  String get conversationMoveToTrash => 'Mover á papeleira';

  @override
  String get conversationNotJunk => 'Non é correo lixo';

  @override
  String get conversationShowAllHeaders => 'Ver todas as cabeceiras';

  @override
  String get conversationViewSource => 'Ver o código fonte';

  @override
  String get conversationSaveAsFile => 'Gardar como ficheiro…';

  @override
  String get conversationShareAsFile => 'Compartir como ficheiro…';

  @override
  String get conversationSearchFromMessageMenu => 'Buscar a partir desta mensaxe…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copiar o enderezo';

  @override
  String get conversationAddressCopied => 'Enderezo copiado';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Buscar mensaxes de $name';
  }

  @override
  String get conversationTags => 'Etiquetas';

  @override
  String get conversationAllHeaders => 'Todas as cabeceiras';

  @override
  String get conversationCopyAll => 'Copiar todo';

  @override
  String get conversationHeadersCopied => 'Cabeceiras copiadas';

  @override
  String get conversationNoHeaders => 'Sen cabeceiras';

  @override
  String get conversationSearchFromMessageTitle => 'Buscar a partir desta mensaxe';

  @override
  String conversationSearchFrom(String name) {
    return 'De $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Para $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Asunto “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Código fonte';

  @override
  String get conversationSourceCopied => 'Código fonte copiado';

  @override
  String get conversationShareFailed => 'Non se puido compartir a mensaxe.';

  @override
  String get conversationWrapLines => 'Axustar as liñas';

  @override
  String get conversationDontWrapLines => 'Non axustar as liñas';

  @override
  String get conversationSourceError => 'Non se puido cargar o código fonte.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Móstranse os primeiros $shown de $total. Cópiao ou compárteo para telo completo.';
  }

  @override
  String get conversationAttachmentUntitled => 'Sen título';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Máis accións para $name';
  }

  @override
  String get conversationMoveTo => 'Mover a…';

  @override
  String get conversationMailboxesError => 'Non se puideron cargar as caixas de correo.';

  @override
  String get conversationReaderReadable => 'Lexible';

  @override
  String get conversationReaderOriginal => 'Orixinal';

  @override
  String get conversationReaderPlain => 'Sen formato';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Manter as cores orixinais';

  @override
  String get conversationReaderRemember => 'Lembrar para este remitente';

  @override
  String get conversationSecurityPossiblePhishing => 'Posible phishing';

  @override
  String get conversationSecurityBeCareful => 'Ten coidado';

  @override
  String get conversationSecurityVerified => 'Verificado';

  @override
  String get conversationSecurityNoIssues => 'Non se atopou ningún problema';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rastrexadores',
      one: '1 rastrexador',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Mostra o motivo';

  @override
  String get conversationPhishingBannerTitle => 'Esta mensaxe parece phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. As ligazóns e as imaxes están desactivadas.';
  }

  @override
  String get conversationPhishingBannerText => 'As ligazóns e as imaxes están desactivadas.';

  @override
  String get conversationPhishingWhy => 'Por que?';

  @override
  String get conversationPhishingShowAnyway => 'Mostrar igualmente';

  @override
  String get conversationSecurityPhishingTitle => 'Isto parece phishing';

  @override
  String get conversationSecurityPhishingText => 'Varios indicios din que esta mensaxe non é o que di ser.';

  @override
  String get conversationSecurityCarefulTitle => 'Ten coidado con esta mensaxe';

  @override
  String get conversationSecurityCarefulText => 'Hai algo nela que merece unha segunda ollada.';

  @override
  String get conversationSecurityVerifiedText => 'O remitente está verificado e nada parece sospeitoso.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nada parece sospeitoso. O teu servidor de correo non indicou se o remitente está verificado.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nada parece sospeitoso.';

  @override
  String get conversationSecurityWhy => 'Por que';

  @override
  String get conversationSecurityPrivacy => 'Privacidade';

  @override
  String get conversationSecurityNoTrackingPixels => 'Sen píxeles de rastrexo';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Elimináronse $count píxeles de rastrexo',
      one: 'Eliminouse 1 píxel de rastrexo',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Diríanlle ao remitente cando abriches esta mensaxe.';

  @override
  String get conversationSecurityNoRemoteImages => 'Sen imaxes remotas';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imaxes remotas',
      one: '1 imaxe remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Se as cargas, o remitente saberá cando les esta mensaxe e cal é o teu enderezo IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Sen rastrexo de clics';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ligazóns pasan por rastrexadores de clics',
      one: '1 ligazón pasa por rastrexadores de clics',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services rexistraría o teu clic. Mantén premida unha ligazón para abrir directamente o seu destino.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Detalles técnicos';

  @override
  String get conversationSecurityCheckedLocally => 'Comprobado neste dispositivo. Non se enviou nada a ningures.';

  @override
  String get conversationSecurityTrackersLabel => 'Rastrexadores';

  @override
  String get conversationSecurityImagesFrom => 'Imaxes de';

  @override
  String get conversationSecuritySenderHistory => 'Historial do remitente';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received recibidas, $sent enviadas';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'As ligazóns levan a';

  @override
  String get conversationSecurityHidden => 'Oculto';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementos',
      one: '$elements elemento',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters caracteres',
      one: '$characters carácter',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Remitente sen verificar';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'O teu servidor de correo non puido confirmar que esta mensaxe veña realmente de $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'O teu servidor de correo non puido confirmar que esta mensaxe veña realmente do seu remitente.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'O teu servidor de correo non puido confirmar que esta mensaxe veña de $domain. É habitual nas listas de correo.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'O teu servidor de correo non puido confirmar que esta mensaxe veña do seu remitente. É habitual nas listas de correo.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Non fagas o que pide se non a agardabas. Se tes dúbidas, contacta co remitente por outra vía.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Asinada por outro dominio';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'A mensaxe está asinada por $signer, non por $domain. Os servizos de envíos masivos fano, pero iso non demostra quen a escribiu.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'A mensaxe está asinada por outro dominio, non por $domain. Os servizos de envíos masivos fano, pero iso non demostra quen a escribiu.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'O nome mostra outro enderezo';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'O nome do remitente di “$shown”, pero a mensaxe vén de $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fíate do enderezo, non do nome.';

  @override
  String get conversationSecurityReplyToTitle => 'As respostas van a outro sitio';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Se respondes, a túa resposta irá a $address, non a $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Comproba o enderezo antes de responder con algo persoal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Usa o teu nome';

  @override
  String get conversationSecurityImpersonationTitle => 'Usa o nome de alguén que coñeces';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Está asinada como “$name”, igual que o teu nome, pero vén dun enderezo novo: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Está asinada como “$name”, igual que o teu VIP $knownName ($knownEmail), pero vén dun enderezo novo: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Está asinada como “$name”, igual que $knownName ($knownEmail), pero vén dun enderezo novo: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'E as respostas irían a outro enderezo distinto.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Se pide cartos, códigos ou ficheiros, compróbao antes con esa persoa por outra vía.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Enderezo coñecido: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Este enderezo: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primeira mensaxe deste remitente';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Ata agora non recibiras correo de $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Ten coidado coas peticións de persoas que aínda non coñeces.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Letras enganosas no enderezo do remitente';

  @override
  String get conversationSecurityLinkHomographTitle => 'Letras enganosas nunha ligazón';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mestura letras de distintos alfabetos para imitar outro enderezo.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host usa letras que se parecen a outras: non é $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Elimínaa ou márcaa como correo lixo.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Non a abras.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Dominio: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Dominio que imita outro';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Usa un nome coñecido no seu dominio';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain parécese ao teu propio dominio, $real, pero é un dominio distinto.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain parécese a $brand ($real), pero é un dominio distinto.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain usa o nome do teu propio dominio, $real, pero non lle pertence.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain usa o nome de $brand ($real), pero non lle pertence.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'As mensaxes reais da túa organización veñen de $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'As mensaxes reais de $brand veñen de $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Dominio do remitente: $domain';
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
      other: '$count ligazóns ocultan a onde levan',
      one: 'Unha ligazón oculta a onde leva',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Unha ligazón mostra $shown, pero abre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Non inicies sesión nin pagues a través destas ligazóns. Escribe ti mesmo o enderezo.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Non se pode comprobar o destino dunha ligazón';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Unha ligazón mostra $shown, pero pasa por $host, que rexistra o clic antes de redirixilo.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Unha ligazón apunta a un simple enderezo IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts non é un sitio web con nome. As empresas reais case nunca ligan así.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Unha ligazón disfrazada';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Unha ligazón comeza por “$shown@” para parecer $shown, pero abre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Desactivouse unha páxina oculta';

  @override
  String get conversationSecurityDataLinkText =>
      'Unha ligazón abriría unha páxina incluída dentro da mensaxe, unha forma de esquivar a comprobación de ligazóns.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Pide un contrasinal';

  @override
  String get conversationSecurityPasswordFieldText => 'A mensaxe contiña un campo de contrasinal. Loupe eliminouno.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nunca escribas un contrasinal nun correo.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Desactivouse unha ligazón que executa código';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nunca executa código das mensaxes.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ligazóns acurtadas',
      one: 'Unha ligazón acurtada',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts oculta o destino real ata que a abres.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Enderezo web internacional';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts usa letras non latinas. É normal en moitos idiomas; comproba que é o sitio que esperas.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Moito texto oculto';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Elimináronse $count caracteres de texto invisible. Un texto oculto así serve para enganar os filtros de spam.',
      one: 'Eliminouse $count carácter de texto invisible. Un texto oculto así serve para enganar os filtros de spam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Eliminouse texto oculto';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Elimináronse $count caracteres de texto invisible.',
      one: 'Eliminouse $count carácter de texto invisible.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Non se puido descargar a mensaxe. Comproba a conexión e téntao de novo.';

  @override
  String exportSaved(String name) {
    return 'Gardouse “$name”';
  }

  @override
  String get exportSaveFailed => 'Non se puido gardar a mensaxe.';

  @override
  String exportFailed(String folder) {
    return 'Non se puido exportar “$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” non ten mensaxes para exportar.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Non se puido exportar “$folder”: non se puido descargar ningunha mensaxe. Comproba a conexión e téntao de novo.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gardouse “$name” sen $formattedCount mensaxes que non se puideron descargar.',
      one: 'Gardouse “$name” sen 1 mensaxe que non se puido descargar.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Non se puido gardar “$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Exportando “$folder”';
  }

  @override
  String get exportListing => 'Buscando mensaxes…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportando $current de $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Non se puideron descargar $formattedCount mensaxes',
      one: 'Non se puido descargar 1 mensaxe',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Caixas de correo';

  @override
  String get mailboxesShown => 'Visible';

  @override
  String get mailboxesHidden => 'Oculta';

  @override
  String get mailboxesCollapse => 'Contraer';

  @override
  String get mailboxesExpand => 'Expandir';

  @override
  String get mailboxesManageVips => 'Xestionar VIP';

  @override
  String get mailboxesSubscriptions => 'Subscricións';

  @override
  String mailboxesShowAccount(String account) {
    return 'Mostrar $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ocultar $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportar o cartafol…';

  @override
  String get mailboxesUnpin => 'Desfixar';

  @override
  String get mailboxesLists => 'Listas';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Garda unha busca para tela aquí.';

  @override
  String get mailboxesTags => 'Etiquetas';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Tamén podes tocar o nome dun remitente nunha mensaxe e activar VIP.';

  @override
  String get mailboxesAddVip => 'Engadir VIP…';

  @override
  String get mailboxesAddVipTitle => 'Engadir VIP';

  @override
  String get mailboxesAddVipText => 'O correo deste enderezo leva unha estrela e aparece na caixa VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Sen ler';

  @override
  String get messageListFilterFlagged => 'Con bandeira';

  @override
  String get messageListFilterToMe => 'Para: min';

  @override
  String get messageListFilterCcMe => 'Cc: min';

  @override
  String get messageListFilterWithAttachments => 'Con anexos';

  @override
  String get messageListFilterUnreplied => 'Sen responder';

  @override
  String get messageListFilterFromVips => 'De VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Marcáronse $count mensaxes como lidas',
      one: 'Marcouse 1 mensaxe como lida',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Non se puido cargar o correo máis antigo.';

  @override
  String get messageListSelectMessages => 'Seleccionar mensaxes';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionadas',
      one: '$count seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Seleccionar todo';

  @override
  String get messageListDeselectAll => 'Deseleccionar todo';

  @override
  String get messageListLoadFailed => 'Non se puido cargar o correo';

  @override
  String get messageListNoUnread => 'Non hai correo sen ler';

  @override
  String get messageListNoMatches => 'Non hai correo que coincida';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrado por: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Desactivar o filtro';

  @override
  String get messageListEmpty => 'Non hai correo';

  @override
  String get messageListFilter => 'Filtrar';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Criterios do filtro: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrado por:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount sen ler',
      one: '$formattedCount sen ler',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marcar';

  @override
  String get messageListTrash => 'Papeleira';

  @override
  String get messageListFilterTitle => 'Filtro';

  @override
  String get messageListFilterInclude => 'INCLUÍR';

  @override
  String get panesHideMailboxes => 'Ocultar as caixas de correo';

  @override
  String get panesShowMailboxes => 'Mostrar as caixas de correo';

  @override
  String get panesMailboxesWidth => 'Largura das caixas de correo';

  @override
  String get panesListWidth => 'Largura da lista de mensaxes';

  @override
  String get panesNoMessageSelected => 'Ningunha mensaxe seleccionada';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensaxes', one: '1 mensaxe');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Adiadas';

  @override
  String get snoozeSheetTitle => 'Adiar';

  @override
  String get snoozeLaterToday => 'Hoxe máis tarde';

  @override
  String get snoozeThisEvening => 'Esta tarde';

  @override
  String get snoozeTomorrow => 'Mañá';

  @override
  String get snoozeThisWeekend => 'Este fin de semana';

  @override
  String get snoozeNextWeek => 'A próxima semana';

  @override
  String get snoozePickDateTime => 'Escoller data e hora…';

  @override
  String get snoozeMenu => 'Adiar…';

  @override
  String get snoozeWakeNow => 'Recuperar agora';

  @override
  String get snoozeChangeTimeMenu => 'Cambiar a hora do adiamento…';

  @override
  String get snoozeChangeTime => 'Cambiar a hora';

  @override
  String get snoozeNoTime => 'Sen hora definida';

  @override
  String get snoozeFooter => 'As mensaxes adiadas volven á caixa de entrada, sen ler, á súa hora.';

  @override
  String get snoozeEmptyTitle => 'Nada adiado';

  @override
  String get snoozeEmptyText => 'Adia unha mensaxe para que volva á caixa de entrada cando a precises.';

  @override
  String get appLockUnlock => 'Desbloquear';

  @override
  String get appLockFailed => 'Loupe non puido confirmar que es ti.';

  @override
  String get appLockLockedOut => 'Demasiados intentos. Téntao de novo máis tarde.';

  @override
  String get appLockPromptError => 'Non se puido mostrar a solicitude. Téntao de novo.';

  @override
  String get appLockNoScreenLock => 'Este teléfono non ten bloqueo de pantalla.';

  @override
  String get appLockUnlockPromptTitle => 'Desbloquear Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirma que es ti para ver o teu correo.';

  @override
  String get appLockTurnOnPromptTitle => 'Activar o bloqueo da aplicación';

  @override
  String get appLockTurnOnPromptReason => 'Confirma que es ti para activar o bloqueo da aplicación.';

  @override
  String get appLockScreenLockRemoved =>
      'O bloqueo da aplicación está desactivado: este teléfono xa non ten bloqueo de pantalla. Configura un para volver activar o bloqueo da aplicación.';

  @override
  String get appLockAfterImmediately => 'Inmediatamente';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutos', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count horas', one: '1 hora');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Cifrada';

  @override
  String get openpgpEncryptedInPart => 'Cifrada en parte';

  @override
  String get openpgpEncryptedLocked => 'Cifrada · bloqueada';

  @override
  String get openpgpEncryptedNoKey => 'Cifrada · sen chave';

  @override
  String get openpgpEncryptedDamaged => 'Cifrada · danada';

  @override
  String get openpgpEncryptedUnsupported => 'Cifrada · non compatible';

  @override
  String get openpgpUnknownSigner => 'descoñecido';

  @override
  String get openpgpUnknownKey => 'Chave descoñecida';

  @override
  String get openpgpSignatureInvalid => 'Sinatura non válida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Asinada por $name, non polo remitente';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Asinada en parte por $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Asinada por $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Asinada cunha chave rexeitada';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Asinada por $name · chave non aceptada';
  }

  @override
  String get openpgpUnlock => 'Desbloquear';

  @override
  String get openpgpCantDecrypt => 'Non se pode descifrar esta mensaxe';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Cifrada con OpenPGP';

  @override
  String get openpgpEncryption => 'Cifrado';

  @override
  String get openpgpDecryptedHere => 'Descifrada neste dispositivo';

  @override
  String get openpgpNotDecrypted => 'Sen descifrar';

  @override
  String get openpgpKeyLocked => 'A túa chave está bloqueada.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Para as chaves $keys',
      one: 'Para a chave $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Asunto protexido';

  @override
  String get openpgpUnlockKey => 'Desbloquear a chave';

  @override
  String get openpgpSignature => 'Sinatura';

  @override
  String get openpgpFingerprint => 'Impresión dixital';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID da chave $id';
  }

  @override
  String get openpgpSigned => 'Asinada';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Aceptación';

  @override
  String get openpgpChangeAcceptance => 'Cambiar a aceptación…';

  @override
  String get openpgpCheckedFooter => 'Comprobado neste dispositivo con OpenPGP, compatible con Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'A túa chave está bloqueada. Desbloquéaa coa súa frase de paso para ler esta mensaxe.';

  @override
  String get openpgpSummaryNoSecretKey => 'Cifrouse para unha chave que non está neste dispositivo.';

  @override
  String get openpgpSummaryDamaged => 'Os datos cifrados están danados ou modificáronse polo camiño.';

  @override
  String get openpgpSummaryUnsupported => 'Usa un algoritmo que Loupe non admite.';

  @override
  String get openpgpSummaryEncrypted => 'Só ti e os demais destinatarios podedes lela.';

  @override
  String get openpgpSummaryNotSigned => 'Non está asinada, así que o remitente non está confirmado.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Está asinada, pero cunha chave que non tes, así que non se pode comprobar a sinatura.';

  @override
  String get openpgpSummaryBadSignature => 'A sinatura non coincide: é posible que a mensaxe se modificase.';

  @override
  String get openpgpSummaryMismatch =>
      'A sinatura é válida, pero a chave pertence a un enderezo distinto do do remitente.';

  @override
  String get openpgpSummaryPartial =>
      'Só unha parte da mensaxe está asinada. O texto fóra da sinatura (por exemplo, o pé dunha lista de correo) móstrase debaixo da liña “Unsigned content”, e outras partes da mensaxe, como os anexos, tampouco quedan cubertas.';

  @override
  String get openpgpSummaryOwnKey => 'Asinada coa túa propia chave.';

  @override
  String get openpgpSummaryVerified => 'A sinatura é válida e verificaches a impresión dixital da chave.';

  @override
  String get openpgpSummaryUnverified =>
      'A sinatura é válida. Aceptaches a chave sen comprobar a súa impresión dixital.';

  @override
  String get openpgpSummaryRejected => 'A sinatura é válida, pero rexeitaches esta chave.';

  @override
  String get openpgpSummaryUndecided =>
      'A sinatura é válida, pero aínda non aceptaches esta chave. Compara a súa impresión dixital co remitente.';

  @override
  String get openpgpAcceptanceRejected => 'Rexeitada';

  @override
  String get openpgpAcceptanceUndecided => 'Non aceptada';

  @override
  String get openpgpAcceptanceUnverified => 'Aceptada';

  @override
  String get openpgpAcceptanceVerified => 'Aceptada e verificada';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Queres aceptar a chave de $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Impresión dixital $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Si, verifiquei a impresión dixital';

  @override
  String get openpgpAcceptUnverified => 'Si, sen comprobala';

  @override
  String get openpgpAcceptLater => 'Aínda non';

  @override
  String get openpgpRejectKey => 'Rexeitar esta chave';

  @override
  String get openpgpNoSubject => '(sen asunto)';

  @override
  String get openpgpEncryptionTitle => 'Cifrado de extremo a extremo';

  @override
  String get openpgpMyKeys => 'As miñas chaves OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Cunha chave podes ler correo cifrado e asinar e cifrar o teu. Usas Thunderbird? Exporta alí a túa chave (Configuración da conta › Cifrado de extremo a extremo › Exportar a chave secreta) e impórtaa aquí.';

  @override
  String get openpgpAddKey => 'Engadir chave…';

  @override
  String get openpgpAddresses => 'Enderezos';

  @override
  String get openpgpAddressesFooter => 'Que chave usa cada enderezo e cando cifra e asina.';

  @override
  String get openpgpCorrespondentsKeys => 'Chaves OpenPGP dos teus contactos';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Acepta unha chave cando confíes en que pertence ao seu propietario; compara a impresión dixital con esa persoa para marcala como verificada.';

  @override
  String get openpgpImportPublicKey => 'Importar chave pública…';

  @override
  String get openpgpCollected => 'Recollidas de Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Chaves que chegaron coas mensaxes. Loupe pode cifrar para elas cando ambas as partes o piden.';

  @override
  String get openpgpOnThisDevice => 'Neste dispositivo';

  @override
  String get openpgpOnThisDeviceFooter =>
      'As mensaxes cifradas ocultan o seu asunto. Loupe garda o asunto de cada mensaxe que abres na súa base de datos cifrada deste dispositivo, para que a lista, a busca e as notificacións o mostren. En segundo plano, Loupe tamén pode descifrar os asuntos das mensaxes novas con chaves sen frase de paso; para iso descarga cada mensaxe (ata 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Descifrar os asuntos en segundo plano';

  @override
  String get openpgpIndexFooter =>
      'A busca atopa as mensaxes cifradas polo remitente, os destinatarios e o asunto. Con isto activado, Loupe tamén engade o texto de cada mensaxe cifrada que descifra ao índice de busca da súa base de datos cifrada deste dispositivo, para que a busca a atope tamén polo texto. Se o desactivas, ese texto quítase do índice.';

  @override
  String get openpgpIndexDecrypted => 'Indexar as mensaxes descifradas para a busca';

  @override
  String get openpgpPassphrases => 'Frases de paso';

  @override
  String get openpgpPassphrasesFooter =>
      'As chaves OpenPGP e os certificados S/MIME que protexes cunha frase de paso desbloquéanse cando fai falta. Sen “Lembrar”, vólvense bloquear dous minutos despois de cada uso.';

  @override
  String get openpgpRememberPassphrases => 'Lembrar as frases de paso';

  @override
  String get openpgpRememberPassphrasesDetail => 'Ata que se peche Loupe';

  @override
  String get openpgpLockKeysNow => 'Bloquear as chaves agora';

  @override
  String get openpgpKeysLocked => 'Chaves bloqueadas.';

  @override
  String get openpgpKeyStateRevoked => 'revogada';

  @override
  String get openpgpKeyStateExpired => 'caducada';

  @override
  String get openpgpKeyStateNeverExpires => 'non caduca nunca';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'caduca o $date';
  }

  @override
  String get openpgpNoKey => 'Sen chave';

  @override
  String get openpgpAlwaysEncrypt => 'Cifrar sempre';

  @override
  String get openpgpAddKeyTitle => 'Engadir unha chave OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importa a chave que usas en Thunderbird ou crea unha nova.';

  @override
  String get openpgpImportFromClipboard => 'Importar do portapapeis';

  @override
  String get openpgpImportFromFile => 'Importar dun ficheiro';

  @override
  String get openpgpGenerateNewKey => 'Xerar unha chave nova';

  @override
  String get openpgpImportPublicKeyTitle => 'Importar unha chave pública';

  @override
  String get openpgpFromClipboard => 'Do portapapeis';

  @override
  String get openpgpFromFile => 'Dun ficheiro';

  @override
  String get openpgpClipboardEmpty => 'O portapapeis está baleiro. Copia primeiro a chave.';

  @override
  String get openpgpKey => 'Chave';

  @override
  String get openpgpValidityRevoked => 'Revogada';

  @override
  String openpgpValidityExpired(String date) {
    return 'Caducou o $date';
  }

  @override
  String get openpgpNeverExpires => 'Non caduca nunca';

  @override
  String openpgpValidUntil(String date) {
    return 'Válida ata o $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Impresión dixital copiada.';

  @override
  String get openpgpAlgorithm => 'Algoritmo';

  @override
  String get openpgpCreated => 'Creada';

  @override
  String get openpgpValidity => 'Validez';

  @override
  String get openpgpProtection => 'Protección';

  @override
  String get openpgpProtectionPassphrase => 'Frase de paso';

  @override
  String get openpgpProtectionKeychain => 'Só o chaveiro';

  @override
  String get openpgpKeyDetailsFooter =>
      'Comparte a túa chave pública para que outras persoas poidan enviarche mensaxes cifradas. A copia de seguranza é a túa chave secreta, protexida pola súa frase de paso se ten unha: gárdaa en privado.';

  @override
  String get openpgpSharePublicKey => 'Compartir a chave pública';

  @override
  String get openpgpCopyPublicKey => 'Copiar a chave pública';

  @override
  String get openpgpPublicKeyCopied => 'Chave pública copiada.';

  @override
  String get openpgpBackUpSecretKey => 'Facer copia da chave secreta';

  @override
  String get openpgpDeleteKey => 'Eliminar a chave';

  @override
  String get openpgpRemoveKey => 'Quitar a chave';

  @override
  String get openpgpBackUpTitle => 'Queres facer copia da chave secreta?';

  @override
  String get openpgpBackUpProtected =>
      'A copia de seguranza está protexida pola frase de paso da túa chave. Quen teña ambas as dúas poderá ler o teu correo.';

  @override
  String get openpgpBackUpUnprotected =>
      'Esta chave non ten frase de paso: quen teña a copia de seguranza poderá ler o teu correo e asinar no teu nome.';

  @override
  String get openpgpBackUp => 'Facer copia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Queres eliminar a túa chave $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Queres quitar a chave de $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'O correo cifrado para esta chave xa non se poderá ler neste dispositivo, salvo que a volvas importar.';

  @override
  String get openpgpRemoveKeyMessage => 'Podes volver importala máis tarde.';

  @override
  String get openpgpKeyHeader => 'Chave OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Engade unha chave en Cifrado de extremo a extremo para cifrar e asinar o correo deste enderezo.';

  @override
  String get openpgpGenerateAKey => 'Xerar unha chave…';

  @override
  String get openpgpSending => 'Envío';

  @override
  String get openpgpSendingFooter =>
      'O cifrado automático actívase cando todos os destinatarios teñen unha chave aceptada ou un certificado de confianza, ou cando Autocrypt indica que ambas as partes o queren. O correo cifrado sempre se asina.';

  @override
  String get openpgpEncryptAutomatically => 'Cifrar automaticamente';

  @override
  String get openpgpAlwaysEncryptDetail => 'Non envía se algún destinatario non ten chave';

  @override
  String get openpgpSignUnencrypted => 'Asinar o correo sen cifrar';

  @override
  String get openpgpAttachPublicKey => 'Anexar a miña chave pública';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt envía a túa chave pública con cada mensaxe, para que outras aplicacións poidan enviarche mensaxes cifradas sen configurar nada.';

  @override
  String get openpgpSendMyKey => 'Enviar a miña chave co correo';

  @override
  String get openpgpPreferEncryption => 'Preferir o cifrado';

  @override
  String get openpgpPreferEncryptionDetail => 'Pedir aos demais que cifren cando poidan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count anos', one: '1 ano');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'As frases de paso non coinciden.';

  @override
  String openpgpKeyReady(String id) {
    return 'A túa chave $id está lista.';
  }

  @override
  String get openpgpNewKey => 'Nova chave';

  @override
  String get openpgpNewKeyFor => 'Para';

  @override
  String get openpgpYourName => 'O teu nome';

  @override
  String get openpgpAddress => 'Enderezo';

  @override
  String get openpgpPassphrase => 'Frase de paso';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opcional. Sen ela, só o chaveiro do teléfono protexe a chave e Loupe nunca a pide. Con ela, Loupe pídea cando se precisa a chave.';

  @override
  String get openpgpRepeatPassphrase => 'Repetir';

  @override
  String get openpgpExpires => 'Caducidade';

  @override
  String get openpgpExpiresFooter =>
      'Podes crear unha chave nova antes de que caduque. Thunderbird tamén usa tres anos.';

  @override
  String get openpgpGenerateKey => 'Xerar a chave';

  @override
  String get openpgpKeyFor => 'Chave para';

  @override
  String get openpgpCantEncrypt => 'Non se pode cifrar';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Non hai ningunha chave OpenPGP para $names, e este enderezo sempre cifra. Quita o destinatario ou importa a súa chave en Configuración › Cifrado de extremo a extremo.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Non hai ningún certificado S/MIME válido para $names, e este enderezo sempre cifra. Quita o destinatario ou importa o seu certificado en Configuración › Cifrado de extremo a extremo.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Non hai ningunha chave OpenPGP para $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Non hai ningún certificado S/MIME válido para $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Enviar sen cifrar';

  @override
  String get openpgpCantSign => 'Non se pode asinar';

  @override
  String get openpgpCantSignMessage =>
      'A chave privada do teu certificado S/MIME non está neste dispositivo. Volve importar o certificado (un ficheiro .p12 ou .pfx) en Configuración › Cifrado de extremo a extremo.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Sen chave para $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sen certificado para $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Chaves de Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Todos teñen chave';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Todos teñen certificado';

  @override
  String get openpgpComposeEncrypt => 'Cifrar';

  @override
  String get openpgpComposeSign => 'Asinar';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, cambiar';
  }

  @override
  String get openpgpNoKeyFound => 'Non se atopou ningunha chave OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Queres importar unha chave secreta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Este anexo contén unha chave secreta ($names). Impórtaa como chave túa só se a exportaches ti, desde Thunderbird, por exemplo.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importar como a miña chave';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'a túa chave $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Queres importar $count chaves ($names)?',
      one: 'Queres importar a chave de $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importar e aceptar';

  @override
  String get openpgpImportDecideLater => 'Importar e decidir despois';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'a chave de $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importouse: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hai $count chaves OpenPGP anexas.',
      one: 'Hai unha chave OpenPGP anexa.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importar';

  @override
  String get openpgpUnlockKeyTitle => 'Desbloquear a chave OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Introduce a frase de paso da chave de $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Esa frase de paso non é correcta. Téntao de novo.';

  @override
  String get openpgpExplainLocked => 'Esta mensaxe está cifrada. Desbloquea a túa chave OpenPGP para lela.';

  @override
  String get openpgpExplainNoKey =>
      'Esta mensaxe está cifrada, pero non para ningunha chave OpenPGP deste dispositivo. Se a les en Thunderbird, importa a túa chave desde alí: Configuración › Cifrado de extremo a extremo.';

  @override
  String get openpgpExplainDamaged => 'Esta mensaxe cifrada está danada, así que non se pode descifrar con seguridade.';

  @override
  String get openpgpExplainUnsupported => 'Esta mensaxe usa un cifrado que Loupe aínda non pode ler.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Esta mensaxe está cifrada con S/MIME, pero non para ningún certificado deste dispositivo. Importa o teu certificado (un ficheiro .p12 ou .pfx) en Configuración › Cifrado de extremo a extremo.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Esta mensaxe está cifrada. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Desbloquea o teu certificado S/MIME para lela.';

  @override
  String get openpgpAttachmentGone => 'Este anexo xa non está dispoñible.';

  @override
  String get smimeEncrypted => 'Cifrada (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Cifrada (S/MIME) · sen certificado';

  @override
  String get smimeEncryptedDamaged => 'Cifrada (S/MIME) · danada';

  @override
  String get smimeEncryptedUnsupported => 'Cifrada (S/MIME) · non compatible';

  @override
  String get smimeEncryptedLocked => 'Cifrada (S/MIME) · bloqueada';

  @override
  String get smimeUnknownSigner => 'descoñecido';

  @override
  String get smimeSignatureModified => 'Sinatura non válida: mensaxe modificada';

  @override
  String get smimeSignatureWeak => 'Sinatura insegura: algoritmo obsoleto';

  @override
  String get smimeSignatureUncheckable => 'Non se pode comprobar a sinatura';

  @override
  String get smimeSignedCertificateMissing => 'Asinada · falta o certificado';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Asinada por $name · certificado revogado';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Asinada por $name · noutra data';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Asinada por $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Asinada por $name · certificado non válido';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Asinada por $name · non é de confianza';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Asinada por $name · certificado caducado';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Asinada por $name · certificado aínda non válido';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Asinada por $name · certificado non apto para correo';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Asinada por $name, non polo remitente';
  }

  @override
  String get smimeCantDecrypt => 'Non se pode descifrar esta mensaxe';

  @override
  String get smimeEncryptedWithSmime => 'Cifrada con S/MIME';

  @override
  String get smimeEncryption => 'Cifrado';

  @override
  String get smimeDecryptedHere => 'Descifrada neste dispositivo';

  @override
  String get smimeNotDecrypted => 'Sen descifrar';

  @override
  String get smimeAuthenticated => 'autenticado';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'para $count certificados',
      one: 'para 1 certificado',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Sinatura';

  @override
  String get smimeIssuedBy => 'Emitido por';

  @override
  String get smimeValid => 'Válido';

  @override
  String smimeValidRange(String from, String to) {
    return 'Do $from ao $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Impresión dixital SHA-256';

  @override
  String get smimeSigned => 'Asinada';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'Comprobando a revogación…';

  @override
  String get smimeNotRevoked => 'Non revogado';

  @override
  String get smimeRevoked => 'Revogado';

  @override
  String get smimeRevocationUnknown => 'Revogación descoñecida';

  @override
  String smimeRevokedSince(String date) {
    return 'Desde o $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Consultouse a autoridade (a súa lista de revogación), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Consultouse a autoridade (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Confiar en “$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Confiar neste certificado…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Comprobado neste dispositivo con S/MIME, compatible con Outlook e Thunderbird; a revogación, coa autoridade de certificación.';

  @override
  String get smimeCheckedFooter =>
      'Comprobado neste dispositivo con S/MIME, compatible con Outlook e Thunderbird. Non se comproba a revogación (Configuración › Cifrado de extremo a extremo).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Queres confiar en $name para o correo?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Queres confiar no certificado de $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Confiarase en todos os certificados que emita esta autoridade, como a autoridade de certificación da túa empresa. Antes, compara a impresión dixital co seu propietario:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Antes, compara a impresión dixital co seu propietario:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Confiar';

  @override
  String get smimeSummaryNoKey => 'Cifrouse para un certificado que non está neste dispositivo.';

  @override
  String get smimeSummaryDamaged => 'Os datos cifrados están danados ou modificáronse polo camiño.';

  @override
  String get smimeSummaryUnsupported => 'Usa un algoritmo que Loupe non admite.';

  @override
  String get smimeSummaryLocked => 'O teu certificado S/MIME está bloqueado.';

  @override
  String get smimeSummaryEncrypted => 'Só ti e os demais destinatarios podedes lela.';

  @override
  String get smimeSummaryNotSigned => 'Non está asinada, así que o remitente non está confirmado.';

  @override
  String get smimeSummaryModified => 'A sinatura non coincide: a mensaxe modificouse despois de asinala.';

  @override
  String get smimeSummaryUncheckable => 'Non se pode comprobar a sinatura.';

  @override
  String get smimeSummaryNoCertificate =>
      'O certificado do asinante non está na mensaxe, así que non se pode comprobar.';

  @override
  String get smimeSummaryRevoked =>
      'A autoridade de certificación revogou o certificado do asinante: non se pode confiar na sinatura.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'A autoridade de certificación revogou o certificado do asinante ($reason): non se pode confiar na sinatura.';
  }

  @override
  String get smimeDateMismatch =>
      'Asinouse máis dunha hora antes ou despois da data da mensaxe: pode ser unha mensaxe antiga enviada de novo.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'A sinatura é válida e $issuer garante que o certificado pertence ao remitente.';
  }

  @override
  String get smimeProblemInvalidChain => 'O certificado ou un dos seus emisores non é válido.';

  @override
  String get smimeProblemUntrusted => 'O certificado procede dunha autoridade na que Loupe non confía.';

  @override
  String get smimeProblemExpired => 'O certificado caducara.';

  @override
  String get smimeProblemNotYetValid => 'O certificado aínda non era válido.';

  @override
  String get smimeProblemWrongUsage => 'O certificado non é apto para correo.';

  @override
  String get smimeProblemWrongAddress => 'O certificado pertence a un enderezo distinto do do remitente.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'De confianza · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Non é de confianza · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Caducou o $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Válido desde o $date';
  }

  @override
  String get smimeTrustInvalid => 'Non válido';

  @override
  String get smimeTrustNotForMail => 'Non apto para correo';

  @override
  String get smimeTrustAnotherAddress => 'Outro enderezo';

  @override
  String get smimeMyCertificates => 'Os meus certificados S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Para S/MIME, tal como o usan Outlook e moitas empresas. Importa o teu certificado coa súa chave privada (un ficheiro .p12 ou .pfx), exportado desde Outlook, Windows, macOS ou Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Para S/MIME, tal como o usan Outlook e moitas empresas. Importa o teu certificado coa súa chave privada (un ficheiro .p12 ou .pfx), exportado desde Outlook, Windows, macOS ou Thunderbird, ou usa un que ti ou a túa empresa instalastes neste dispositivo.';

  @override
  String get smimeCertificateExpired => 'caducado';

  @override
  String smimeCertificateUntil(String date) {
    return 'ata o $date';
  }

  @override
  String get smimeCertificateOnDevice => 'neste dispositivo';

  @override
  String get smimeImportCertificateEllipsis => 'Importar certificado…';

  @override
  String get smimeUseDeviceCertificate => 'Usar un certificado deste dispositivo…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificados dos teus contactos';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Recollidos do correo asinado, como fan Outlook e Thunderbird. O correo só se cifra para certificados de confianza: Loupe confía nas autoridades nas que Mozilla confía para o correo, e nas que ti engadas.';

  @override
  String get smimeRevocation => 'Revogación';

  @override
  String get smimeRevocationFooter =>
      'Cando abres correo asinado, Loupe pregunta á autoridade que emitiu o certificado do asinante se o revogou (ao seu servidor OCSP ou á súa lista de revogación). A autoridade pode ver entón cando alguén desde o teu enderezo de internet le correo asinado con ese certificado. As respostas gárdanse neste dispositivo ata que caducan. Un certificado revogado móstrase como “certificado revogado” na cabeceira da mensaxe.';

  @override
  String get smimeCheckRevocation => 'Comprobar a revogación en liña';

  @override
  String get smimeTrustedAuthorities => 'Autoridades de confianza';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Da túa confianza, ademais das $count nas que Mozilla confía para o correo.',
      one: 'Da túa confianza, ademais da $count na que Mozilla confía para o correo.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoridade de certificación';

  @override
  String get smimeImportACertificate => 'Importar un certificado';

  @override
  String get smimeImportContactMessage =>
      'O certificado dun contacto (.cer, .crt, .pem) ou o dunha autoridade de certificación.';

  @override
  String get smimeFromClipboard => 'Do portapapeis';

  @override
  String get smimeFromFile => 'Dun ficheiro';

  @override
  String get smimeClipboardEmpty => 'O portapapeis está baleiro. Copia primeiro o certificado.';

  @override
  String get smimeCertificate => 'Certificado';

  @override
  String get smimeOnDeviceFooter =>
      'A súa chave privada queda no almacenamento de credenciais de Android, onde ti ou a túa empresa a instalastes: Loupe pídelle a Android que asine e descifre con ela. O correo asinado asínase ao envialo.';

  @override
  String get smimeAddresses => 'Enderezos';

  @override
  String get smimeUsage => 'Para';

  @override
  String get smimeUsageNone => 'Nada que use Loupe';

  @override
  String get smimeUsageSigning => 'Asinar';

  @override
  String get smimeUsageEncryption => 'Cifrar';

  @override
  String get smimeUsageCertificates => 'Certificados';

  @override
  String get smimeAlgorithm => 'Algoritmo';

  @override
  String get smimeSerialNumber => 'Número de serie';

  @override
  String get smimeFingerprintCopied => 'Impresión dixital copiada.';

  @override
  String get smimeSha1Thumbprint => 'Impresión dixital SHA-1';

  @override
  String get smimePrivateKey => 'Chave privada';

  @override
  String get smimeKeyOnDevice => 'Neste dispositivo';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'En Loupe, con frase de paso';

  @override
  String get smimeKeyInLoupe => 'En Loupe';

  @override
  String get smimeSource => 'Orixe';

  @override
  String get smimeSourceSignedMail => 'Correo asinado';

  @override
  String get smimeSourceImported => 'Importado';

  @override
  String get smimeTrustHeader => 'Confianza';

  @override
  String get smimeTrustedRoot => 'Raíz de confianza';

  @override
  String get smimeIssuer => 'Emisor';

  @override
  String smimeTrustNamed(String name) {
    return 'Confiar en “$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Confiar nesta autoridade';

  @override
  String get smimeTrustThisCertificate => 'Confiar neste certificado';

  @override
  String get smimeStopTrusting => 'Deixar de confiar';

  @override
  String get smimePassphrase => 'Frase de paso';

  @override
  String get smimePassphraseFooter =>
      'Opcional. Cunha frase de paso, a chave privada tamén se cifra neste dispositivo (Argon2id e AES-256) e Loupe pídea para asinar e descifrar; Lembrar as frases de paso indica durante canto tempo. O correo que envías asínase ao envialo; as tarefas en segundo plano non poden usar a chave.';

  @override
  String get smimeChangePassphrase => 'Cambiar a frase de paso…';

  @override
  String get smimeSetPassphraseEllipsis => 'Definir unha frase de paso…';

  @override
  String get smimeRemovePassphrase => 'Quitar a frase de paso';

  @override
  String get smimeShareCertificate => 'Compartir o certificado';

  @override
  String get smimeDeleteCertificate => 'Eliminar o certificado';

  @override
  String get smimeRemoveCertificate => 'Quitar o certificado';

  @override
  String get smimePassphraseChanged => 'Cambiouse a frase de paso.';

  @override
  String get smimePassphraseSet => 'Definiuse a frase de paso.';

  @override
  String get smimeRemovePassphraseTitle => 'Queres quitar a frase de paso?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Entón a chave privada só estará protexida polo chaveiro, como sen frase de paso: Loupe xa non a pedirá e as tarefas en segundo plano poderán usala.';

  @override
  String get smimePassphraseRemoved => 'Quitouse a frase de paso.';

  @override
  String smimeTrustTitle(String name) {
    return 'Queres confiar en $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Confiarase para o correo en todos os certificados que emita. Antes, compara a impresión dixital co seu propietario:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Queres eliminar o teu certificado $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Queres quitar o certificado de $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe deixará de usalo: o correo cifrado para el xa non se poderá ler en Loupe. O certificado queda neste dispositivo (Configuración › Seguranza › Encriptación e credenciais).';

  @override
  String get smimeDeleteOwnMessage =>
      'A súa chave privada elimínase deste dispositivo: o correo cifrado para el xa non se poderá ler aquí, salvo que o volvas importar.';

  @override
  String get smimeRemoveContactMessage => 'Volverá coa súa próxima mensaxe asinada.';

  @override
  String get smimeAddressImportFooter =>
      'Importa un certificado para este enderezo para asinar e cifrar con S/MIME, como fai Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importar un certificado…';

  @override
  String get smimePreferFooter =>
      'Cando os dous poden protexer unha mensaxe, úsase o preferido, salvo que só o outro teña unha chave ou un certificado para todos os destinatarios.';

  @override
  String get smimePreferSmime => 'Preferir S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Antes que OpenPGP';

  @override
  String get smimeCertificatePassword => 'Contrasinal do certificado';

  @override
  String get smimeCertificatePasswordPrompt => 'Introduce o contrasinal co que se exportou o ficheiro do certificado.';

  @override
  String get smimeImport => 'Importar';

  @override
  String get smimeWrongPassword => 'Ese contrasinal non é correcto. Téntao de novo.';

  @override
  String get smimeNoCertificateFound => 'Non se atopou ningún certificado.';

  @override
  String smimeCertificateOf(String name) {
    return 'o certificado de $name';
  }

  @override
  String get smimeNothingNew => 'Non hai nada novo para importar.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importouse: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importáronse $count autoridades de confianza.',
      one: 'Importouse unha autoridade de confianza.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importouse: $certificates e $count autoridades de confianza.',
      one: 'Importouse: $certificates e unha autoridade de confianza.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Este ficheiro non ten chave privada. Exporta o teu certificado coa súa chave privada.';

  @override
  String get smimeImportAsYoursTitle => 'Queres importalo como o teu certificado?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Este anexo contén un certificado coa súa chave privada: $names. Impórtao só se o exportaches ti, desde Outlook ou Thunderbird, por exemplo.';
  }

  @override
  String get smimeImportAsMine => 'Importar como o meu certificado';

  @override
  String smimeImportedOwn(String names) {
    return 'Importouse o teu certificado $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Engadiuse o teu certificado $name ($addresses) desde este dispositivo.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Queres confiar en “$name” para o correo?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe non coñece esta autoridade de certificación (quizais sexa a dunha empresa). Confía nela para comprobar os certificados que emite. Antes, compara a súa impresión dixital co teu departamento de informática:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hai $count certificados anexos.',
      one: 'Hai un certificado anexo.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importar o certificado';

  @override
  String get smimeUnlockTitle => 'Desbloquear o certificado S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Introduce a frase de paso do certificado de $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Esa frase de paso non é correcta. Téntao de novo.';

  @override
  String get smimeUnlock => 'Desbloquear';

  @override
  String get smimeEnterAPassphrase => 'Introduce unha frase de paso.';

  @override
  String get smimePassphrasesDiffer => 'As dúas frases de paso non coinciden.';

  @override
  String get smimeSetPassphraseTitle => 'Definir unha frase de paso';

  @override
  String get smimeSetPassphraseText =>
      'Loupe pedirá a frase de paso para asinar e descifrar. Se a esqueces, volve importar o certificado desde o seu ficheiro .p12.';

  @override
  String get smimePassphraseAgain => 'De novo';

  @override
  String get smimeSetPassphraseButton => 'Definir';

  @override
  String get smimeLockedOpenAgain =>
      'O teu certificado S/MIME está bloqueado. Volve abrir a mensaxe para desbloquealo.';

  @override
  String get smimeDeviceHasNoCertificates => 'Este dispositivo non ofrece os seus certificados.';

  @override
  String get smimeCantReadCertificate => 'Loupe non pode ler este certificado.';

  @override
  String get smimeCertificateNotForMail =>
      'Este certificado non é para correo: non ten enderezo de correo ou non está pensado para asinar nin cifrar.';

  @override
  String get smimeDeviceCertificateGone =>
      'O certificado xa non está neste dispositivo, ou pode que Loupe xa non poida usalo. Volve escollelo en Configuración › Cifrado de extremo a extremo.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'O certificado deste dispositivo só se pode usar mentres Loupe está aberta.';

  @override
  String get smimeDeviceKeyDamaged => 'A chave cifrada está danada.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'O certificado deste dispositivo non pode facer isto: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'non compatible';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'O certificado deste dispositivo fallou: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'O enderezo da autoridade non é un enderezo web.';

  @override
  String get smimeAuthorityTimeout => 'A autoridade de certificación non respondeu a tempo.';

  @override
  String get smimeAuthorityUnreachable => 'Non se puido contactar coa autoridade de certificación.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'A autoridade de certificación respondeu $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'A resposta da autoridade de certificación é demasiado grande.';

  @override
  String get smimeRevocationNotChecked =>
      'Non comprobado: só se comproban os certificados de autoridades nas que Loupe confía.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'O mesmo que o teléfono';

  @override
  String get settingsLanguageFooter =>
      'Loupe usa o idioma do teu teléfono se o ten, e o inglés se non. O idioma que escollas aquí é só para Loupe, notificacións incluídas.';

  @override
  String get settingsAccountsHeader => 'Contas';

  @override
  String get settingsAddAccount => 'Engadir conta';

  @override
  String get settingsMailHeader => 'Correo';

  @override
  String get settingsSwipeActions => 'Accións ao deslizar';

  @override
  String get settingsSwipeLeft => 'Deslizar á esquerda';

  @override
  String get settingsSwipeLeftFooter =>
      'Ao deslizar ata o final execútase esta acción. Marcar cunha bandeira e Máis están sempre a un deslizamento curto.';

  @override
  String get settingsSwipeRight => 'Deslizar á dereita';

  @override
  String get settingsSwipeRightFooter => 'Ao deslizar ata o final execútase esta acción.';

  @override
  String get settingsSwipeToggleRead => 'Marcar como lida / sen ler';

  @override
  String get settingsSwipeTrash => 'Papeleira';

  @override
  String get settingsSwipeMove => 'Mover a mensaxe';

  @override
  String get settingsSwipeSnooze => 'Adiar';

  @override
  String get settingsThreaded => 'Agrupar por conversa';

  @override
  String get settingsUndoSendDelay => 'Tempo para desfacer o envío';

  @override
  String get settingsUndoSendDelayFooter => 'As mensaxes enviadas agardan este tempo, para que poidas recuperalas.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Aparencia';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automático';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsDensity => 'Lista de mensaxes';

  @override
  String get settingsDensityComfortable => 'Ampla';

  @override
  String get settingsDensityCompact => 'Compacta';

  @override
  String get settingsReadingHeader => 'Lectura';

  @override
  String get settingsReadingFooter =>
      'As imaxes remotas poden dicirlles aos remitentes cando e onde abriches unha mensaxe.';

  @override
  String get settingsDefaultView => 'Vista predeterminada';

  @override
  String get settingsDefaultViewFooter => 'Podes cambiar a vista de calquera mensaxe co botón Aa.';

  @override
  String get settingsViewReadable => 'Lexible';

  @override
  String get settingsViewReadableDetail => 'Limpa, lexible e segue o modo escuro';

  @override
  String get settingsViewOriginal => 'Orixinal';

  @override
  String get settingsViewOriginalDetail => 'Exactamente como a deseñou o remitente';

  @override
  String get settingsViewPlain => 'Texto sen formato';

  @override
  String get settingsViewPlainDetail => 'Só as palabras';

  @override
  String get settingsPlainTextFont => 'Fonte do texto sen formato';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monoespazada';

  @override
  String get settingsFontMonoDetail => 'Mantén aliñados a arte ASCII e as táboas';

  @override
  String get settingsTechnicalLists => 'Listas técnicas';

  @override
  String get settingsLoadRemoteImages => 'Cargar as imaxes remotas';

  @override
  String get settingsOpenLinksDirectly => 'Abrir as ligazóns directamente';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Saltar os rastrexadores de clics cando se coñece o destino';

  @override
  String get settingsSecurityHeader => 'Seguridade';

  @override
  String get settingsAppLock => 'Bloqueo da aplicación';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe pídeo ao iniciarse e cando volves despois de estar fóra o tempo de Bloquear despois de.';

  @override
  String get settingsAppLockFooterOff =>
      'O bloqueo da aplicación pide a túa pegada dixital, a túa cara ou o bloqueo de pantalla antes de mostrar o teu correo.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'O bloqueo da aplicación segue desactivado. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configura un código';

  @override
  String get settingsScreenLockTextIos =>
      'O bloqueo da aplicación usa Face ID, Touch ID ou o teu código, e este iPhone non ten código. Configura un na aplicación Configuración e despois activa o bloqueo da aplicación.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configura un bloqueo de pantalla';

  @override
  String get settingsScreenLockTextAndroid =>
      'O bloqueo da aplicación usa o bloqueo de pantalla do teléfono, ou unha pegada dixital ou unha cara engadidas a el, e este teléfono non ten ningún. Configura un PIN, un padrón ou un contrasinal na configuración de Android e despois activa o bloqueo da aplicación.';

  @override
  String get settingsOpenSystemSettings => 'Abrir Configuración';

  @override
  String get settingsOpenAndroidSettings => 'Abrir a configuración de Android';

  @override
  String get settingsLockAfter => 'Bloquear despois de';

  @override
  String get settingsLockAfterFooter => 'Canto tempo pode estar Loupe en segundo plano antes de volver pedilo.';

  @override
  String get settingsNotifications => 'Notificacións';

  @override
  String get settingsEncryption => 'Cifrado de extremo a extremo';

  @override
  String get settingsAdvanced => 'Opcións avanzadas';

  @override
  String get settingsDemoHeader => 'Demostración';

  @override
  String get settingsDemoFooter =>
      'O correo de demostración é unha caixa de correo inventada que só existe neste teléfono. Non se envía nada a ningures.';

  @override
  String get settingsDemoMode => 'Modo de demostración';

  @override
  String get settingsResetApp => 'Restablecer a aplicación';

  @override
  String get settingsResetFooter => 'Esquece toda a configuración e volve á pantalla de benvida.';

  @override
  String get settingsResetTitle => 'Queres restablecer Loupe?';

  @override
  String get settingsResetMessage =>
      'Esquecerase toda a configuración, as Smart Mailboxes e as buscas recentes, e volverase á pantalla de benvida.';

  @override
  String get settingsAboutHeader => 'Acerca de';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsLicences => 'Licenzas';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsPrivacyDetail =>
      'Loupe non ten analíticas nin rastrexo. O teu correo só vai aos teus servidores de correo.';

  @override
  String get settingsNotificationsOffIos => 'As notificacións de Loupe están desactivadas en Configuración.';

  @override
  String get settingsNotificationsOffAndroid =>
      'As notificacións de Loupe están desactivadas na configuración de Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system non permite que Loupe mostre notificacións. Permíteas na configuración.';
  }

  @override
  String get settingsNewMailHeader => 'Correo novo';

  @override
  String get settingsNewMailFooterDemo =>
      'O correo de demostración non chega en segundo plano. Envía unha notificación de proba para ver como se ve o correo novo.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe busca correo novo en segundo plano cando iOS llo permite, o que pode tardar horas nas aplicacións que non abres a miúdo. Avisarémoste das mensaxes novas nas túas caixas de entrada e das dos teus VIP en calquera cartafol.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe busca correo novo cada 15 minutos aproximadamente, cando Android o permite. Avisarémoste das mensaxes novas nas túas caixas de entrada e das dos teus VIP en calquera cartafol.';

  @override
  String get settingsNoAccounts => 'Non hai contas';

  @override
  String get settingsVipOnly => 'Só VIP';

  @override
  String get settingsVipOnlyDetail => 'Só as mensaxes dos teus VIP';

  @override
  String get settingsHideContent => 'Ocultar o contido';

  @override
  String get settingsHideContentFooterOn =>
      'As notificacións só din “Nova mensaxe de” e a conta, non quen a escribiu nin de que trata.';

  @override
  String get settingsHideContentFooterOff =>
      'Ocultar o contido mantén o remitente, o asunto e a vista previa fóra da pantalla de bloqueo e das notificacións.';

  @override
  String get settingsBackgroundAppRefresh => 'Actualización en segundo plano';

  @override
  String get settingsBackgroundRefreshFooter =>
      'O correo novo só chega en segundo plano se a actualización en segundo plano está activada para Loupe en Configuración. iOS non pode manter aberta unha conexión coas túas caixas de entrada, así que non hai entrega instantánea.';

  @override
  String get settingsInstantDelivery => 'Entrega instantánea';

  @override
  String get settingsInstantDeliveryFooter =>
      'A entrega instantánea (experimental) mantén aberta unha conexión coas túas caixas de entrada para que o correo novo chegue en segundos. Mostra unha notificación discreta, “Atento ao correo novo”, e consome máis batería.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android pode deter a entrega instantánea para aforrar batería. Permite que Loupe use a batería sen restricións para que siga funcionando.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'Proximamente';

  @override
  String get settingsAllowUnrestrictedBattery => 'Permitir o uso da batería sen restricións';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'O push permite que o correo novo esperte Loupe de inmediato, se o teu servizo de correo o admite. Os avisos push pasan polo servizo push de Google e non levan correo, só “comproba agora”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Este teléfono non pode recibir avisos push: precisan os servizos de Google Play e unha conexión de rede. Loupe segue buscando correo novo cada 15 minutos aproximadamente.';

  @override
  String get settingsCopyPushToken => 'Copiar o token de push';

  @override
  String get settingsPushTokenCopied => 'Token de push copiado';

  @override
  String get settingsSendTestNotification => 'Enviar unha notificación de proba';

  @override
  String get settingsAppIconBadge => 'Indicador na icona da aplicación';

  @override
  String get settingsBadgeNote => 'O indicador actualízase cada vez que Loupe busca correo, tamén en segundo plano.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'A pantalla de inicio deste teléfono non mostra números nas iconas das aplicacións. O indicador actualízase cada vez que Loupe busca correo, tamén en segundo plano.';

  @override
  String get settingsTestNotificationBody => 'As notificacións de correo novo vense así.';

  @override
  String get settingsAccountRemoved => 'Quitouse esta conta.';

  @override
  String get settingsAccountHeader => 'Conta';

  @override
  String get settingsAccountDescription => 'Descrición';

  @override
  String get settingsAccountDescriptionHint => 'Traballo, Persoal…';

  @override
  String get settingsEmail => 'Correo electrónico';

  @override
  String get settingsColour => 'Cor';

  @override
  String get settingsColourFooter => 'Marca as mensaxes desta conta en Todas as caixas de entrada.';

  @override
  String settingsColourNumber(int number) {
    return 'Cor $number';
  }

  @override
  String get settingsSendingHeader => 'Envío';

  @override
  String get settingsSendingFooter =>
      'Cada identidade ten a súa propia sinatura. As respostas saen desde o enderezo ao que se enviou a mensaxe.';

  @override
  String get settingsFoldersHeader => 'Cartafoles';

  @override
  String get settingsFoldersFooter =>
      'Loupe mostra e sincroniza os cartafoles aos que te subscribes, como fai Thunderbird. Caixa de entrada, Borradores, Enviados, Correo lixo, Papeleira e Arquivo sempre se mostran.';

  @override
  String get settingsShowAllFolders => 'Mostrar todos os cartafoles';

  @override
  String get settingsIncoming => 'Entrada';

  @override
  String get settingsOutgoing => 'Saída';

  @override
  String get settingsConnectionNotEncrypted => 'Sen cifrar';

  @override
  String get settingsSignIn => 'Inicio de sesión';

  @override
  String get settingsSignInExpired => 'Caducado';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider xa non acepta o inicio de sesión de Loupe para esta conta, así que o seu correo non se está a sincronizar. Volve iniciar sesión para solucionalo.';
  }

  @override
  String get settingsSignInAgain => 'Volver iniciar sesión';

  @override
  String get settingsSigningIn => 'Iniciando sesión…';

  @override
  String get settingsRemoveAccount => 'Quitar a conta';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Queres quitar “$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'O seu correo e a súa configuración quítanse deste teléfono. Non se elimina nada no servidor.';

  @override
  String get settingsManageFolders => 'Xestionar os cartafoles';

  @override
  String get settingsNoFolders => 'Aínda non hai cartafoles.';

  @override
  String get settingsManageFoldersFooter =>
      'Os cartafoles subscritos móstranse na pantalla Caixas de correo e sincronízanse en segundo plano. Outras aplicacións de correo coa mesma conta adoitan seguir tamén estas subscricións.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Garda as túas Smart Mailboxes para os teus outros dispositivos. Oculto na pantalla Caixas de correo.';

  @override
  String get settingsFolderAlwaysShown => 'Sempre visible';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Subscribirse a $folder';
  }

  @override
  String get settingsIdentities => 'Identidades';

  @override
  String get settingsIdentitiesFooterReorder =>
      'A primeira identidade é a predeterminada para as mensaxes novas. Arrastra para cambiar a orde.';

  @override
  String get settingsIdentitiesFooterSingle => 'A identidade predeterminada para as mensaxes novas.';

  @override
  String get settingsIdentitiesReplyFooter => 'As respostas saen desde a identidade á que se enviou a mensaxe.';

  @override
  String get settingsIdentityDefault => 'Predeterminada';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reordenar $email';
  }

  @override
  String get settingsAddIdentity => 'Engadir identidade';

  @override
  String get settingsNewIdentity => 'Nova identidade';

  @override
  String get settingsIdentity => 'Identidade';

  @override
  String get settingsIdentityNameHint => 'O teu nome';

  @override
  String get settingsReplyTo => 'Responder a';

  @override
  String get settingsSignature => 'Sinatura';

  @override
  String get settingsSignatureFooter => 'Engádese debaixo de “-- ” nas mensaxes desta identidade.';

  @override
  String get settingsNoSignature => 'Sen sinatura';

  @override
  String get settingsCopyToMyself => 'Copia para min';

  @override
  String get settingsCopyToMyselfFooter => 'Engádese a todas as mensaxes desta identidade.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Cco';

  @override
  String get settingsReplyPatterns => 'Usar para responder a';

  @override
  String get settingsReplyPatternsFooter =>
      'As respostas ás mensaxes enviadas a estes enderezos saen desde esta identidade. * significa calquera cousa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Un enderezo, ou un padrón no que * significa calquera cousa.';

  @override
  String get settingsAddReplyPattern => 'Engadir enderezo ou padrón';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Quitar $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Padrón non válido';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” non é un enderezo nin un padrón como *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Sen enderezo';

  @override
  String get settingsIdentityNoAddressMessage => 'Introduce o enderezo de correo desde o que enviar.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Enderezo non válido';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '“$address” en Responder a non é un enderezo de correo válido.',
      'cc': '“$address” en Cc non é un enderezo de correo válido.',
      'bcc': '“$address” en Cco non é un enderezo de correo válido.',
      'other': '“$address” non é un enderezo de correo válido.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Gardar a identidade';

  @override
  String get settingsDiscardChanges => 'Descartar os cambios';

  @override
  String get settingsDeleteIdentity => 'Eliminar a identidade';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Queres eliminar “$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'As mensaxes xa enviadas desde ela quedan como están.';

  @override
  String get settingsLastIdentityFooter => 'Unha conta necesita polo menos unha identidade.';

  @override
  String get rulesTitle => 'Regras';

  @override
  String get rulesNewRule => 'Nova regra';

  @override
  String get rulesLoadError => 'Non se puideron cargar as regras.';

  @override
  String get rulesEmptyTitle => 'Non hai regras';

  @override
  String get rulesEmptyText =>
      'As regras arquivan, etiquetan e marcan con bandeira o correo novo por ti. Crea unha co botón de redactar de arriba, ou a partir dunha busca con “Converter en regra”.';

  @override
  String get rulesListFooter =>
      'As regras execútanse de arriba abaixo sobre o correo novo da caixa de entrada. Mantén premida unha regra para movela.';

  @override
  String get rulesChangeError => 'Non se puido cambiar a regra';

  @override
  String get rulesConditionEveryMessage => 'Todas as mensaxes';

  @override
  String rulesMoveRule(String rule) {
    return 'Mover $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule activada';
  }

  @override
  String get rulesServerRulesHeader => 'Regras do servidor';

  @override
  String get rulesServerRulesFooter =>
      'As regras do servidor execútanse no servidor de correo a medida que chega o correo, tamén co teléfono apagado. Gárdanse nun script Sieve chamado “loupe”.';

  @override
  String get rulesStatusUnknown => 'Descoñecido';

  @override
  String get rulesStatusError => 'Non se puido consultar o servidor.';

  @override
  String get rulesStatusChecking => 'Comprobando…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Execútanse desde “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” é o script activo. Toca para que tamén execute as regras de Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Non hai ningún script activo no servidor. Ao gardar unha regra do servidor actívase o de Loupe.';

  @override
  String get rulesStatusUnavailable => 'Non dispoñible';

  @override
  String get rulesStatusNoSieve => 'O servidor desta conta non ofrece Sieve (nin ManageSieve nin JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mover a $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mover a un cartafol';

  @override
  String rulesActionTag(String tag) {
    return 'Etiquetar como $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Quitar a etiqueta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Manter na caixa de entrada';

  @override
  String rulesActionForward(String address) {
    return 'Reenviar a $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Reenviar a $address, sen gardar copia';
  }

  @override
  String get rulesActionStop => 'Parar';

  @override
  String get rulesNoActions => 'Aínda non fai nada';

  @override
  String get rulesLocationDevice => 'Dispositivo';

  @override
  String get rulesLocationServer => 'Servidor';

  @override
  String get rulesLocationThisDevice => 'Este dispositivo';

  @override
  String get rulesNewRuleTitle => 'Nova regra';

  @override
  String get rulesEditRuleTitle => 'Editar a regra';

  @override
  String get rulesDefaultNameEveryMessage => 'Todas as mensaxes';

  @override
  String get rulesConditionHeader => 'Cando unha mensaxe nova coincida con';

  @override
  String get rulesConditionFooter =>
      'Escríbea como se buscases: from:, to:, s: (asunto), b: (corpo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:factura';

  @override
  String get rulesAccounts => 'Contas';

  @override
  String get rulesAllAccounts => 'Todas as contas';

  @override
  String get rulesRemovedAccount => 'Conta quitada';

  @override
  String get rulesAccountsFooter =>
      'Unha regra para todas as contas tamén se aplica ás contas que engadas máis adiante.';

  @override
  String get rulesActionsHeader => 'Entón';

  @override
  String get rulesForwardingFooter =>
      'O reenvío manda cada mensaxe que coincide a outro enderezo en canto chega, tamén co teléfono apagado. Algúns provedores limitan canto correo se pode reenviar.';

  @override
  String get rulesForwardingHiddenFooter => 'O reenvío só funciona nas regras do servidor, así que aquí non aparece.';

  @override
  String rulesRemoveAction(String action) {
    return 'Quitar $action';
  }

  @override
  String get rulesAddAction => 'Engadir unha acción';

  @override
  String get rulesAddMove => 'Mover a un cartafol…';

  @override
  String get rulesAddTagMenu => 'Engadir unha etiqueta…';

  @override
  String get rulesRemoveTagMenu => 'Quitar unha etiqueta…';

  @override
  String get rulesAddForward => 'Reenviar a…';

  @override
  String get rulesStopProcessing => 'Non procesar máis regras';

  @override
  String get rulesRunOnHeader => 'Executar en';

  @override
  String get rulesRunOnDeviceFooter =>
      'Este dispositivo executa a regra sobre o correo novo da caixa de entrada cada vez que Loupe busca correo.';

  @override
  String get rulesRunOnServerFooter =>
      'O servidor de correo executa a regra a medida que chega o correo, tamén co teléfono apagado. Precisa Sieve, mediante ManageSieve (Dovecot, mailcow) ou JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Aplicar ás mensaxes existentes…';

  @override
  String get rulesDeleteRule => 'Eliminar a regra';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Queres eliminar “$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Cartafol de que conta?';

  @override
  String get rulesMoveAccountMessage => 'O correo das outras contas vai ao cartafol co mesmo nome en cada unha.';

  @override
  String get rulesAddTag => 'Engadir unha etiqueta';

  @override
  String get rulesRemoveTag => 'Quitar unha etiqueta';

  @override
  String get rulesForwardTo => 'Reenviar a';

  @override
  String get rulesForwardToMessage =>
      'O servidor reenvía cada mensaxe que coincide a este enderezo, tamén co teléfono apagado. Usa un enderezo teu ou de confianza.';

  @override
  String get rulesNotAnAddressTitle => 'Non é un enderezo de correo';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address” non é un enderezo ao que se poida reenviar.';
  }

  @override
  String get rulesKeepCopyTitle => 'Queres gardar unha copia aquí?';

  @override
  String get rulesKeepCopy => 'Gardar unha copia';

  @override
  String get rulesDontKeepCopy => 'Non gardar copia';

  @override
  String get rulesCheckCondition => 'Revisa a condición';

  @override
  String get rulesChooseActionTitle => 'Escolle unha acción';

  @override
  String get rulesChooseActionMessage => 'Engade o que fai a regra coas mensaxes que coinciden.';

  @override
  String get rulesSaveError => 'Non se puido gardar a regra';

  @override
  String get rulesSaveServerError => 'Non se puido gardar a regra do servidor';

  @override
  String get rulesRunOnDeviceInstead => 'Executar neste dispositivo';

  @override
  String get rulesNothingToApplyTitle => 'Nada que aplicar';

  @override
  String get rulesNothingToApplyMessage => 'Primeiro dálle á regra unha condición que funcione e unha acción.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplicar “$rule” ás mensaxes de…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Caixas de entrada';

  @override
  String get rulesApplyScopeAll => 'Todas as caixas de correo';

  @override
  String get rulesFindingMessages => 'Buscando mensaxes…';

  @override
  String get rulesSearchError => 'Non se puido buscar';

  @override
  String get rulesSearchErrorUnknown => 'Algo fallou.';

  @override
  String get rulesNoMatchesTitle => 'Ningunha mensaxe coincide';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nada coincide con “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Queres aplicar “$rule” a $countString mensaxes?',
      one: 'Queres aplicar “$rule” a $countString mensaxe?',
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
      other: 'Aplicar a $countString mensaxes',
      one: 'Aplicar a $countString mensaxe',
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
      other: 'Aplicouse “$rule” a $countString mensaxes',
      one: 'Aplicouse “$rule” a $countString mensaxe',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Preguntando ao servidor que pode facer…';

  @override
  String get rulesServerUnreachable => 'Non se puido conectar co servidor.';

  @override
  String rulesServerProblem(String problem) {
    return 'Non se pode executar no servidor: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Non se pode executar no servidor de $account: $problem';
  }

  @override
  String get rulesShowScript => 'Mostrar o script';

  @override
  String get rulesHideScript => 'Ocultar o script';

  @override
  String get rulesMatchingHeader => 'Mensaxes que coinciden';

  @override
  String get rulesMatchingHeaderLoading => 'Mensaxes que coinciden…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString mensaxes coinciden',
      one: '$countString mensaxe coincide',
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
      other: 'Máis de $countString mensaxes coinciden',
      one: 'Máis de $countString mensaxe coincide',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Dos últimos 30 días. A regra en si só actúa sobre o correo novo, salvo que a apliques ás mensaxes existentes.';

  @override
  String rulesConditionError(String error) {
    return 'A condición ten un erro: $error';
  }

  @override
  String get rulesPreviewNoSender => '(sen remitente)';

  @override
  String get rulesPreviewNoSubject => '(sen asunto)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'e $countString máis',
      one: 'e $countString máis',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nada dos últimos 30 días.';

  @override
  String get rulesIncludeTitle => 'Activar as regras do servidor';

  @override
  String get rulesIncludeLeaveOff => 'Deixalas desactivadas';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'O servidor xa executa as regras de Loupe para $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” é o script activo no servidor de $account, así que o servidor execútao a el e non as regras de Loupe. Loupe non o substituirá. Pode engadirlle estas liñas, e entón o servidor executará as regras de Loupe despois das do propio script:';
  }

  @override
  String get rulesShowWholeScript => 'Mostrar o script completo';

  @override
  String get rulesHideWholeScript => 'Ocultar o script completo';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Non cambia nada máis en “$script”. Se máis adiante se editan os seus filtros no correo web, pode que este o reescriba sen estas liñas; entón Loupe volverá mostrar as regras do servidor como desactivadas.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Engadir a “$script”';
  }

  @override
  String get subscriptionsTitle => 'Subscricións';

  @override
  String get subscriptionsNewsletters => 'Boletíns';

  @override
  String get subscriptionsDiscussions => 'Debates';

  @override
  String get subscriptionsFilter => 'Filtrar';

  @override
  String get subscriptionsFilterNeverRead => 'Nunca lidos';

  @override
  String get subscriptionsFilterRarelyRead => 'Pouco lidos';

  @override
  String get subscriptionsFilterAll => 'Todos';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Non se puideron contar as subscricións';

  @override
  String get subscriptionsNoMatches => 'Sen coincidencias';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ningún boletín se chama “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ningunha lista se chama “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Non hai boletíns';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Os boletíns e o resto do correo masivo aparecen aquí en canto chegan.';

  @override
  String get subscriptionsNothingNeverRead => 'Nada sen ler nunca';

  @override
  String get subscriptionsNothingRarelyRead => 'Nada pouco lido';

  @override
  String get subscriptionsNothingFilteredDetail => 'Les algo de todo o que recibes.';

  @override
  String get subscriptionsNoDiscussions => 'Non hai debates';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'As listas de correo nas que podes escribir aparecen aquí en canto chega o seu correo.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listas nas que escriben varias persoas. Mantén premida unha para fixala en Caixas de correo, lela como texto sen formato ou movela a Boletíns.';

  @override
  String get subscriptionsPrivacyNote =>
      'Calcúlase neste teléfono a partir do correo descargado; non se envía nada a ningures para iso. Loupe só contacta cun remitente cando tocas Darse de baixa: a baixa cun clic envía unicamente “List-Unsubscribe=One-Click” ao enderezo que indicou o remitente, sen cookies nin nada máis sobre ti, e nunca carga as súas páxinas nin as súas imaxes.';

  @override
  String get subscriptionsVolumeNone => 'Nada ultimamente';

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
    return 'lido $percent';
  }

  @override
  String get subscriptionsStillSending => 'Segue enviando';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Baixa o $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Páxina de baixa aberta o $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Un toque · contacta con $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Por correo a $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'No sitio web $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Darse de baixa';

  @override
  String get subscriptionsUnsubscribeAgain => 'Volver darse de baixa';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arquivar $countString da caixa de entrada',
      one: 'Arquivar $countString da caixa de entrada',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Crear unha regra…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mover ou arquivar o seu correo futuro';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratar como debate';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Unha lista na que escribe a xente: léa como un foro';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratar como boletín';

  @override
  String get subscriptionsBlockSender => 'Bloquear o remitente';

  @override
  String get subscriptionsBlock => 'Bloquear';

  @override
  String get subscriptionsBlocked => 'Bloqueado';

  @override
  String get subscriptionsBlockedDetail => 'O correo novo vai ao correo lixo';

  @override
  String get subscriptionsPin => 'Fixar en Caixas de correo';

  @override
  String get subscriptionsUnpin => 'Desfixar de Caixas de correo';

  @override
  String get subscriptionsOpenDefaultView => 'Abrir na vista predeterminada';

  @override
  String get subscriptionsOpenPlainText => 'Abrir como texto sen formato (Mono)';

  @override
  String get subscriptionsPinned => 'Fixada';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString sen ler',
      one: '$countString sen ler',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Agora non hai correo deste remitente.';

  @override
  String get subscriptionsLatestMessages => 'ÚLTIMAS MENSAXES';

  @override
  String get subscriptionsMail => 'Correo';

  @override
  String get subscriptionsNoneIn90Days => 'Ningunha en 90 días';

  @override
  String get subscriptionsRead => 'Lido';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString de $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Última recibida';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Cartafoles', one: 'Cartafol');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Segue enviando';

  @override
  String get subscriptionsUnsubscribedTitle => 'Baixa';

  @override
  String subscriptionsSince(String date) {
    return 'desde o $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'páxina aberta o $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender non indica como darse de baixa.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender non indica como darse de baixa. No seu lugar, podes bloquealo.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Dándote de baixa de $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Décheste de baixa de $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Non se puido tramitar a baixa: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Non se puido tramitar a baixa automaticamente';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Enviar un correo de baixa';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Abrir $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Queres abrir $site?';
  }

  @override
  String get subscriptionsOpen => 'Abrir';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender xestiona as baixas no seu sitio web. A páxina ábrese no navegador de Loupe; remata alí.';
  }

  @override
  String get subscriptionsWebInsecure => 'A conexión con este sitio non está cifrada.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Coidado: este enderezo imita $site con letras que se parecen a outras.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Coidado: este enderezo imita outro sitio con letras que se parecen a outras.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Non se puido abrir $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe anota a data de hoxe e avisarate se $sender segue escribindo.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Queres darte de baixa de $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe contactará con $site para darte de baixa.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Esta é a única vez que Loupe contacta co sitio web dun remitente. Só envía “List-Unsubscribe=One-Click” ao enderezo que indicou $sender, sen cookies nin nada máis sobre ti, e non carga a páxina.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'A ligazón para darse de baixa non é un enderezo seguro de internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site non respondeu a tempo.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Non se puido contactar con $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site redirixiu a solicitude a outra páxina, e Loupe non segue redireccións.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site rexeitou a solicitude (erro $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Non hai ningunha conta desde a que enviar o correo de baixa.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe enviará un correo a $to desde $from, co asunto “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Enviouse o correo de baixa a $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Queres bloquear $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'O correo novo desta lista irá ao correo lixo. Podes cambialo en Configuración › Regras.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'O correo novo de $address irá ao correo lixo. Podes cambialo en Configuración › Regras.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Bloqueouse $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mover $count ao correo lixo',
      one: 'Mover $count ao correo lixo',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloquear $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender está agora en Boletíns.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender está agora en Debates.';
  }

  @override
  String get appLiveGateTitle => 'Non se puideron abrir as túas contas';

  @override
  String get appLiveGateUnavailableBuild => 'As contas reais aínda non están dispoñibles nesta versión.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe non puido ler a chave que protexe o teu correo neste teléfono. Adoita ser temporal: téntao de novo ou reinicia o teléfono.';

  @override
  String get appLiveGateKeyMissing =>
      'A chave que protexe o teu correo neste teléfono desapareceu, algo que pode pasar despois de restaurar unha copia de seguranza. O teu correo segue no servidor.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Non se pode ler a base de datos do correo deste teléfono: está danada ou a súa chave cambiou. O teu correo segue no servidor.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Algo fallou ao abrir as túas contas ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Isto elimina as túas contas e o correo gardado neste teléfono, incluídas as mensaxes que agardan na caixa de saída. O correo dos teus servidores non se ve afectado; despois volve engadir as túas contas.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Eliminar e comezar de novo';

  @override
  String get appLiveGateUseDemo => 'Usar o correo de demostración';

  @override
  String get appLiveGateReset => 'Restablecer o correo deste teléfono…';

  @override
  String get attachmentsUntitled => 'Anexo';

  @override
  String get attachmentsUntitledFile => 'Sen título';

  @override
  String get attachmentsOpenIn => 'Abrir con…';

  @override
  String get attachmentsSaveToFiles => 'Gardar en Ficheiros';

  @override
  String get attachmentsShareMenu => 'Compartir…';

  @override
  String get attachmentsDownloadError => 'Non se puido descargar o anexo. Comproba a conexión e téntao de novo.';

  @override
  String get attachmentsShareError => 'Non se puido compartir o anexo.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ningunha aplicación deste dispositivo abre este ficheiro ($type). Proba con Compartir.';
  }

  @override
  String get attachmentsOpenInError => 'Non se puido abrir o anexo noutra aplicación.';

  @override
  String attachmentsSaved(String name) {
    return 'Gardouse “$name”';
  }

  @override
  String get attachmentsSaveError => 'Non se puido gardar o anexo.';

  @override
  String get attachmentsGone => 'Este anexo xa non está dispoñible.';

  @override
  String get attachmentsDownloadFailed => 'Non se puido descargar o anexo.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count páxinas', one: '1 páxina');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size con datos móbiles';
  }

  @override
  String get attachmentsLargeDownload => 'Este anexo é grande. Descárgao agora ou máis tarde con wifi.';

  @override
  String get attachmentsDownload => 'Descargar';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Descargando $size…';
  }

  @override
  String get attachmentsDownloading => 'Descargando…';

  @override
  String get attachmentsTooLarge => 'É demasiado grande para a vista previa.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Móstranse os primeiros $shown de $total. Cópiao, compárteo ou gárdao para telo completo.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Este PDF non se pode mostrar aquí (pode que estea protexido cun contrasinal).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page de $count';
  }

  @override
  String get attachmentsModeTable => 'Táboa';

  @override
  String get attachmentsModeText => 'Texto';

  @override
  String get attachmentsModeMessage => 'Mensaxe';

  @override
  String get attachmentsModeSource => 'Código fonte';

  @override
  String get attachmentsDontWrap => 'Non axustar as liñas';

  @override
  String get attachmentsWrap => 'Axustar as liñas';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines liñas', one: '$lines liña');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copiar todo';

  @override
  String get attachmentsCopied => 'Copiado';

  @override
  String get attachmentsImageUnavailable => 'Esta imaxe non se pode mostrar aquí. Proba con Abrir con….';

  @override
  String get attachmentsEmlNoSubject => '(Sen asunto)';

  @override
  String get attachmentsEmlFrom => 'De';

  @override
  String get attachmentsEmlTo => 'Para';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Esta mensaxe non ten texto.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Anexos: $names', one: 'Anexo: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizador: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'E $count eventos máis',
      one: 'E 1 evento máis',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imaxe';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imaxe $format';
  }

  @override
  String get attachmentsTypePdf => 'Documento PDF';

  @override
  String get attachmentsTypeTsv => 'Valores separados por tabulacións';

  @override
  String get attachmentsTypeCsv => 'Folla de cálculo CSV';

  @override
  String get attachmentsTypeCalendar => 'Evento do calendario';

  @override
  String get attachmentsTypeEmail => 'Mensaxe de correo';

  @override
  String get attachmentsTypeContact => 'Tarxeta de contacto';

  @override
  String get attachmentsTypeLog => 'Ficheiro de rexistro';

  @override
  String get attachmentsTypeText => 'Texto';

  @override
  String get attachmentsTypeZip => 'Arquivo ZIP';

  @override
  String get attachmentsTypeArchive => 'Arquivo comprimido';

  @override
  String get attachmentsTypeWord => 'Documento de Word';

  @override
  String get attachmentsTypeExcel => 'Folla de cálculo de Excel';

  @override
  String get attachmentsTypePowerPoint => 'Presentación de PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Páxina web';

  @override
  String get attachmentsTypeVideo => 'Vídeo';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Ficheiro $extension';
  }

  @override
  String get attachmentsTypeFile => 'Ficheiro';

  @override
  String get calendarUntitledEvent => 'Evento';

  @override
  String get calendarAllDay => 'Todo o día';

  @override
  String calendarYourTime(String time) {
    return '$time na túa hora';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Unirse: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceptou: $details',
      'tentative': '$name aceptou provisionalmente: $details',
      'declined': '$name rexeitou: $details',
      'delegated': '$name delegou: $details',
      'other': '$name non respondeu a: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceptou o convite',
      'tentative': '$name aceptou provisionalmente o convite',
      'declined': '$name rexeitou o convite',
      'delegated': '$name delegou o convite',
      'other': '$name non respondeu ao convite',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Unirse';

  @override
  String get calendarOnlineMeeting => 'Reunión en liña';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Reunión de $provider';
  }

  @override
  String get calendarOrganizerYou => 'Ti';

  @override
  String get calendarOrganizerLabel => 'organizador';

  @override
  String get calendarStatusAccepted => 'Aceptado';

  @override
  String get calendarStatusMaybe => 'Quizais';

  @override
  String get calendarStatusDeclined => 'Rexeitado';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceptou',
      'tentative': '$name aceptou provisionalmente',
      'declined': '$name rexeitou',
      'delegated': '$name delegou',
      'other': '$name non respondeu',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceptou:',
      'tentative': '$name aceptou provisionalmente:',
      'declined': '$name rexeitou:',
      'delegated': '$name delegou:',
      'other': '$name non respondeu:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name propón unha nova hora';
  }

  @override
  String get calendarCounterUnknown => 'Un asistente propón unha nova hora';

  @override
  String get calendarDeclineCounter => 'O organizador mantivo a hora';

  @override
  String calendarRefresh(String name) {
    return '$name pide a versión máis recente';
  }

  @override
  String get calendarRefreshUnknown => 'Un asistente pide a versión máis recente';

  @override
  String get calendarCancelled => 'Cancelado';

  @override
  String get calendarCancelledByOrganizer => 'O organizador cancelou este evento.';

  @override
  String get calendarCancelledLater => 'Este evento cancelouse máis tarde.';

  @override
  String get calendarOutdated => 'Desactualizado';

  @override
  String get calendarOutdatedDetail => 'Este convite actualizouse despois; o que conta é o máis recente.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Quitouse a localización (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Quitouse a localización (non había ningunha)';

  @override
  String calendarLocationChanged(String location) {
    return 'A localización cambiou a $location';
  }

  @override
  String get calendarNewTitle => 'Novo título';

  @override
  String get calendarRepeatChanged => 'A repetición cambiou';

  @override
  String get calendarUpdated => 'Actualizado';

  @override
  String get calendarUpdatedInvitation => 'Convite actualizado';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'A hora cambiou de $before a $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Fuso horario “$zone” descoñecido: horas tal como están escritas';
  }

  @override
  String calendarNext(String when) {
    return 'Próximo: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count convidados', one: '1 convidado');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count aceptaron', one: '$count aceptou');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count quizais', one: '$count quizais');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rexeitaron',
      one: '$count rexeitou',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (ti)';
  }

  @override
  String get calendarAttendeeOptional => 'opcional';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptaches unha versión anterior.',
      'tentative': 'Aceptaches provisionalmente unha versión anterior.',
      'declined': 'Rexeitaches unha versión anterior.',
      'delegated': 'Delegaches unha versión anterior.',
      'other': 'Non respondiches a unha versión anterior.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Aceptar';

  @override
  String get calendarMaybe => 'Quizais';

  @override
  String get calendarDecline => 'Rexeitar';

  @override
  String get calendarCommentHint => 'Comentario para o organizador (opcional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'A túa resposta irá a $organizer desde $address.';
  }

  @override
  String get calendarAddComment => 'Engadir un comentario';

  @override
  String get calendarAddToCalendar => 'Engadir ao calendario';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'E $count eventos máis no ficheiro',
      one: 'E 1 evento máis no ficheiro',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Non hai ningunha aplicación de calendario á que engadir o evento.';

  @override
  String get calendarCantOpenCalendar => 'Non se puido abrir o calendario.';

  @override
  String get calendarCantOpenLink => 'Non se puido abrir a ligazón.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Queres unirte á reunión de $provider?';
  }

  @override
  String get calendarJoinTitle => 'Queres unirte á reunión?';

  @override
  String calendarJoinOpens(String host) {
    return 'Abre $host no teu navegador.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Coidado: este enderezo imita $site con letras que se parecen a outras.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Coidado: este enderezo imita outro sitio con letras que se parecen a outras.';

  @override
  String calendarJoinOpen(String host) {
    return 'Abrir $host';
  }

  @override
  String get calendarNoOrganizer => 'Este convite non ten organizador ao que responder.';

  @override
  String get calendarNoAccount => 'Non hai ningunha conta desde a que responder.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptado',
      'tentative': 'Quizais',
      'other': 'Rexeitado',
    });
    return '$_temp0 · enviando a resposta a $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptado',
      'tentative': 'Quizais',
      'other': 'Rexeitado',
    });
    return '$_temp0 · resposta enviada';
  }

  @override
  String get calendarReplyAlreadySent => 'A resposta xa se enviara.';

  @override
  String get calendarReplyNotSent => 'Non se enviou a resposta.';

  @override
  String get dataSmimeNeedsDevice =>
      'O teu certificado S/MIME está neste dispositivo: abre Loupe para asinar e enviar esta mensaxe.';

  @override
  String dataSigningFailed(String error) {
    return 'Non se puido asinar: $error';
  }

  @override
  String get keyboardShortcuts => 'Atallos de teclado';

  @override
  String get keyboardGroupGeneral => 'Xeral';

  @override
  String get keyboardGroupMessages => 'Mensaxes';

  @override
  String get keyboardGroupCompose => 'Redacción';

  @override
  String get keyboardCommandPalette => 'Paleta de comandos';

  @override
  String get keyboardBackClose => 'Atrás, pechar';

  @override
  String get keyboardNextMessage => 'Mensaxe seguinte';

  @override
  String get keyboardPreviousMessage => 'Mensaxe anterior';

  @override
  String get keyboardOpenMessage => 'Abrir a mensaxe';

  @override
  String get keyboardMoveToTrash => 'Mover á papeleira';

  @override
  String get keyboardToggleRead => 'Marcar como lida ou sen ler';

  @override
  String get keyboardToggleFlag => 'Poñer ou quitar a bandeira';

  @override
  String get keyboardCloseDraft => 'Pechar (gardar ou eliminar o borrador)';

  @override
  String get keyboardOr => 'ou';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Maiús';

  @override
  String get keyboardKeyEnter => 'Intro';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Supr';

  @override
  String get keyboardKeyBackspace => 'Retroceso';

  @override
  String get mailingListsMuted => 'Fío silenciado. As novas mensaxes del chegarán como lidas.';

  @override
  String get mailingListsUnmuted => 'O fío xa non está silenciado.';

  @override
  String get mailingListsMuteThread => 'Silenciar o fío';

  @override
  String get mailingListsUnmuteThread => 'Deixar de silenciar o fío';

  @override
  String get mailingListsPin => 'Fixar en Caixas de correo';

  @override
  String get mailingListsUnpin => 'Desfixar de Caixas de correo';

  @override
  String get mailingListsDefaultView => 'Abrir na vista predeterminada';

  @override
  String get mailingListsPlainText => 'Abrir como texto sen formato (Mono)';

  @override
  String get mailingListsShowMuted => 'Mostrar os fíos silenciados';

  @override
  String get mailingListsHideMuted => 'Ocultar os fíos silenciados';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratar como boletín';

  @override
  String get mailingListsOptions => 'Opcións da lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted sen ler',
      one: '$formatted sen ler',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nova mensaxe á lista';

  @override
  String get mailingListsRowUnread => 'Sen ler';

  @override
  String get mailingListsRowMuted => 'Silenciado';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count respostas', one: '1 resposta');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Non hai fíos';

  @override
  String get mailingListsMutedHidden => 'Os fíos silenciados están ocultos.';

  @override
  String get mailingListsTechnicalTitle => 'Listas técnicas';

  @override
  String get mailingListsTechnicalEmpty => 'As listas de correo aparecen aquí en canto chega o seu correo.';

  @override
  String get mailingListsTechnicalFooter =>
      'As mensaxes destas listas ábrense como texto sen formato cunha fonte monoespazada, e os parches móstranse como diffs. O botón Aa segue cambiando a vista de calquera mensaxe.';

  @override
  String get paletteMoveToMailbox => 'Mover a unha caixa de correo…';

  @override
  String get paletteMarkAllRead => 'Marcar todo como lido';

  @override
  String get paletteExportFolder => 'Exportar o cartafol…';

  @override
  String get paletteGetNewMail => 'Recibir correo novo';

  @override
  String get paletteSnoozed => 'Adiadas';

  @override
  String get paletteSubscriptions => 'Subscricións';

  @override
  String get paletteDiscussions => 'Debates';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Lista de correo';

  @override
  String get paletteTag => 'Etiqueta';

  @override
  String get paletteSwipeActions => 'Accións ao deslizar';

  @override
  String get paletteNotifications => 'Notificacións';

  @override
  String get paletteRules => 'Regras';

  @override
  String get paletteEncryption => 'Cifrado de extremo a extremo';

  @override
  String get paletteAdvanced => 'Opcións avanzadas';

  @override
  String get paletteAddAccount => 'Engadir conta';

  @override
  String get paletteAccount => 'Conta';

  @override
  String get paletteFolders => 'Cartafoles';

  @override
  String get paletteRecentSearch => 'Busca recente';

  @override
  String paletteSearchMail(String query) {
    return 'Buscar “$query” no correo';
  }

  @override
  String get palettePlaceholder => 'Buscar accións, caixas de correo, configuración';

  @override
  String get paletteNothingFound => 'Non se atopou nada';

  @override
  String get searchNewSmartMailbox => 'Nova Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Mostra todo o que coincida con “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Gardouse “$name” en Caixas de correo';
  }

  @override
  String get searchMakeRule => 'Converter en regra';

  @override
  String get searchSaveSmartMailbox => 'Gardar como Smart Mailbox';

  @override
  String get searchNegate => 'Negar';

  @override
  String get searchDontNegate => 'Non negar';

  @override
  String get searchAllMailboxes => 'Todas as caixas de correo';

  @override
  String get searchRecent => 'Buscas recentes';

  @override
  String get searchClear => 'Borrar';

  @override
  String get searchSuggestions => 'Suxestións';

  @override
  String get searchUnreadMessages => 'Mensaxes sen ler';

  @override
  String get searchFlaggedMessages => 'Mensaxes con bandeira';

  @override
  String get searchWithAttachments => 'Mensaxes con anexos';

  @override
  String get searchUnrepliedMessages => 'Mensaxes sen responder';

  @override
  String get searchTags => 'Etiquetas';

  @override
  String get searchPeople => 'Persoas';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De: $name';
  }

  @override
  String get searchSearching => 'Buscando…';

  @override
  String get searchNoResults => 'Non hai resultados';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted resultados',
      one: '$formatted resultado',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menú da busca';

  @override
  String searchSearchingAccount(String account) {
    return 'Buscando en $account no servidor…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Buscando na conta no servidor…';

  @override
  String searchAccountFailed(String account) {
    return 'Non se puido buscar en $account no servidor';
  }

  @override
  String get searchUnknownAccountFailed => 'Non se puido buscar na conta no servidor';

  @override
  String searchChip(String term) {
    return '$term. Toca dúas veces para editar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Non $term. Toca dúas veces para editar.';
  }

  @override
  String get searchReadAndUnread =>
      'A caixa de entrada de Schrödinger: aquí cada mensaxe está lida e sen ler ata que a abres.';

  @override
  String searchContradiction(String term) {
    return 'Ningunha mensaxe pode ser “$term” e non selo á vez.';
  }

  @override
  String get searchSyncDeviceOnly => 'Só neste dispositivo';

  @override
  String searchSyncUnsupported(String account) {
    return 'Só neste dispositivo: $account non pode gardala';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Sen sincronizar: $account ten un formato máis recente';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Agardando para sincronizar con $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronizada con $account';
  }

  @override
  String get searchRename => 'Cambiar o nome';

  @override
  String get searchEditSearch => 'Editar a busca';

  @override
  String get searchDeleteSmartMailbox => 'Eliminar a Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Cambiar o nome da Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Esta Smart Mailbox eliminouse.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'As Smart Mailboxes quedan neste dispositivo.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'As Smart Mailboxes gárdanse no teu servidor de correo, así que tamén as teñen os teus outros dispositivos, e Thunderbird con Expression Search Reloaded. As que buscan en todas as contas gárdanse en $account; as dun só cartafol, na conta dese cartafol.';
  }

  @override
  String get searchSyncVia => 'Sincronizar mediante';

  @override
  String get searchSyncViaFooter => 'Escolle a mesma conta en todos os dispositivos.';

  @override
  String get searchGmailCantKeep => 'Gmail non pode gardar Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Gardar as Smart Mailboxes só neste dispositivo';

  @override
  String get searchOnTheServer => 'No servidor';

  @override
  String get searchServerFooter =>
      'Os metadatos do servidor (IMAP METADATA) non se ven en ningunha aplicación de correo. Os servidores sen eles reciben un cartafol “Loupe Settings” cunha mensaxe; Loupe ocúltao en Caixas de correo.';

  @override
  String get searchSyncNow => 'Sincronizar agora';

  @override
  String get searchStateUnsupported => 'Non compatible';

  @override
  String get searchStateNewerFormat => 'Formato máis recente';

  @override
  String get searchStateFailed => 'Non se puido sincronizar';

  @override
  String get searchStateSyncing => 'Sincronizando…';

  @override
  String get searchStateWaiting => 'En espera';

  @override
  String get searchStateMetadata => 'Metadatos do servidor';

  @override
  String get searchStateFolder => 'Cartafol Loupe Settings';

  @override
  String get searchStateNothing => 'Nada gardado';

  @override
  String get sharedBack => 'Atrás';

  @override
  String get sharedYesterday => 'Onte';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date ás $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bytes', one: '$count byte');
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
  String get sharedSyncNoAccounts => 'Non hai contas';

  @override
  String get sharedSyncChecking => 'Buscando correo…';

  @override
  String get sharedSyncFailed => 'Non se puido buscar correo';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Sen conexión';

  @override
  String get sharedSyncJustNow => 'Actualizado agora mesmo';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Actualizado hai $minutes minutos',
      one: 'Actualizado hai 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Actualizado ás $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Actualizado o $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Todas as caixas de entrada';

  @override
  String get sharedMailboxUnread => 'Sen ler';

  @override
  String get sharedMailboxFlagged => 'Con bandeira';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Todos os borradores';

  @override
  String get sharedMailboxAllSent => 'Todos os enviados';

  @override
  String get sharedMailboxUntitled => 'Caixa de correo';

  @override
  String get sharedTagImportant => 'Importante';

  @override
  String get sharedTagWork => 'Traballo';

  @override
  String get sharedTagPersonal => 'Persoal';

  @override
  String get sharedTagToDo => 'Por facer';

  @override
  String get sharedTagLater => 'Máis tarde';

  @override
  String get sharedTags => 'Etiquetas';

  @override
  String get sharedMoveTo => 'Mover a…';

  @override
  String get sharedNoRecipients => 'Sen destinatarios';

  @override
  String get sharedUnknownSender => 'Remitente descoñecido';

  @override
  String get sharedOnServer => 'No servidor';

  @override
  String get sharedAttachment => 'Anexo';

  @override
  String get sharedSnoozedBadge => 'Adiada';

  @override
  String get sharedRowUnread => 'Sen ler';

  @override
  String get sharedRowBackFromSnooze => 'Volveu do adiamento';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Con bandeira';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arquiváronse $count mensaxes',
      one: 'Arquivouse 1 mensaxe',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Elimináronse $count mensaxes',
      one: 'Eliminouse 1 mensaxe',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Movéronse $count mensaxes á caixa de entrada',
      one: 'Moveuse 1 mensaxe á caixa de entrada',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Movéronse $count mensaxes á papeleira',
      one: 'Moveuse 1 mensaxe á papeleira',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Movéronse $count mensaxes ao correo lixo',
      one: 'Moveuse 1 mensaxe ao correo lixo',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Movéronse $count mensaxes a $mailbox',
      one: 'Moveuse 1 mensaxe a $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Movéronse $count mensaxes a unha caixa de correo',
      one: 'Moveuse 1 mensaxe a unha caixa de correo',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Adiáronse $count mensaxes ata $time',
      one: 'Adiouse 1 mensaxe ata $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Adiada ata $time só neste dispositivo: o servidor non pode gardar as horas de adiamento.';
  }

  @override
  String get sharedMoveOneAccount => 'Selecciona mensaxes dunha soa conta para movelas.';

  @override
  String get sharedSnoozeTitle => 'Adiar';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Cambiar a hora do adiamento';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Queres eliminar definitivamente $count mensaxes?',
      one: 'Queres eliminar definitivamente esta mensaxe?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Isto non se pode desfacer.';

  @override
  String get sharedDeletePermanently => 'Eliminar definitivamente';

  @override
  String get sharedSwipeRead => 'Lida';

  @override
  String get sharedSwipeUnread => 'Sen ler';

  @override
  String get sharedSwipeInbox => 'Entrada';

  @override
  String get sharedSwipeDelete => 'Eliminar';

  @override
  String get sharedTrash => 'Papeleira';

  @override
  String get sharedSwipeSnooze => 'Adiar';

  @override
  String get sharedWakeNow => 'Recuperar agora';

  @override
  String get sharedChangeSnoozeTime => 'Cambiar a hora do adiamento…';

  @override
  String get sharedSnooze => 'Adiar…';

  @override
  String get sharedTag => 'Etiquetar…';

  @override
  String get sharedMoveMessage => 'Mover a mensaxe…';

  @override
  String get sharedNotJunk => 'Non é correo lixo';

  @override
  String get accountSetupTitle => 'Engadir conta';

  @override
  String get accountSetupTitleDone => 'Conta engadida';

  @override
  String get accountSetupAddressTitle => 'Engadir unha conta de correo';

  @override
  String get accountSetupAddressText => 'Loupe atopa a configuración da maioría dos provedores.';

  @override
  String get accountSetupNameHint => 'O teu nome';

  @override
  String get accountSetupEmail => 'Correo electrónico';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Continuar';

  @override
  String get accountSetupLookingUp => 'Buscando a configuración…';

  @override
  String get accountSetupImport => 'Importar de Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Introduce un enderezo de correo válido.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Non se atopou a configuración de $domain. Introdúcea abaixo.';
  }

  @override
  String get accountSetupCheckServers => 'Comproba os nomes dos servidores e os portos.';

  @override
  String get accountSetupEnterPassword => 'Introduce o teu contrasinal.';

  @override
  String get accountSetupConnecting => 'Conectando…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Agardando por $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Non se puido abrir a páxina.';

  @override
  String get accountSetupCouldNotSaveName => 'Non se puido gardar o nome.';

  @override
  String get accountSetupTrustCertificate => 'Confiar neste certificado';

  @override
  String get accountSetupPasswordRequired => 'Obrigatorio';

  @override
  String get accountSetupShowPassword => 'Mostrar o contrasinal';

  @override
  String get accountSetupHidePassword => 'Ocultar o contrasinal';

  @override
  String get accountSetupAppPassword => 'Contrasinal de aplicación';

  @override
  String get accountSetupApiToken => 'Token de API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Entrada · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Saída · SMTP';

  @override
  String get accountSetupSignIn => 'Iniciar sesión';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Iniciar sesión con $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Usar un contrasinal de aplicación';

  @override
  String get accountSetupUseAppPasswordInstead => 'Usar un contrasinal de aplicación';

  @override
  String get accountSetupUseDifferentAddress => 'Usar outro enderezo';

  @override
  String get accountSetupHowToCreateAppPassword => 'Como crear un contrasinal de aplicación';

  @override
  String get accountSetupHowToCreateOne => 'Como crear un';

  @override
  String get accountSetupGoogleNote =>
      'Inicias sesión na páxina de Google, e Loupe nunca ve o teu contrasinal. Permite que Loupe lea, envíe e organice o teu correo.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Iniciar sesión con Google” aínda non está dispoñible nesta versión. Podes conectarte cun contrasinal de aplicación (precisa a verificación en dous pasos na túa conta de Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Crea un contrasinal de aplicación na túa conta de Google e pégao abaixo.';

  @override
  String get accountSetupMicrosoftNote =>
      'Inicias sesión na páxina de Microsoft, e Loupe nunca ve o teu contrasinal. Funciona con Outlook.com e Hotmail, e con contas de traballo ou de centros educativos de Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'O inicio de sesión de Microsoft chegará nunha versión posterior. As contas de Outlook, Hotmail e Microsoft 365 necesítano: xa non aceptan contrasinais das aplicacións de correo.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail necesita un contrasinal específico para aplicacións, non o contrasinal da túa conta de Apple.';

  @override
  String get accountSetupYahooNote =>
      'Yahoo Mail necesita un contrasinal de aplicación, non o contrasinal da túa conta.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe conéctase a Fastmail por JMAP cun token de API: Settings › Privacy & Security › Manage API tokens, para JMAP, con acceso ao correo e ao envío.';

  @override
  String get accountSetupFastmailNote =>
      'Fastmail necesita un contrasinal de aplicación para as aplicacións de correo.';

  @override
  String get accountSetupServerSettings => 'Configuración do servidor';

  @override
  String get accountSetupSettingsNotFound => 'Non se atopou automaticamente';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Atopada mediante $source';
  }

  @override
  String get accountSetupEditSettings => 'Editar a configuración';

  @override
  String get accountSetupSyncing => 'O teu correo estase a sincronizar.';

  @override
  String get accountSetupDescription => 'Descrición';

  @override
  String get accountSetupDescriptionHint => 'Traballo, Persoal…';

  @override
  String get accountSetupColour => 'Cor';

  @override
  String accountSetupColourNumber(int number) {
    return 'Cor $number';
  }

  @override
  String get accountSetupSaving => 'Gardando…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe non puido abrir a súa base de datos de correo neste teléfono. Pecha Loupe, ábrea de novo e téntao outra vez.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Algo fallou ($error). Téntao de novo.';
  }

  @override
  String get accountSetupSecurityNone => 'Ningunha';

  @override
  String get accountSetupProtocol => 'Protocolo';

  @override
  String get accountSetupPort => 'Porto';

  @override
  String get accountSetupSecurity => 'Seguridade';

  @override
  String get accountSetupUsername => 'Nome de usuario';

  @override
  String get accountSetupUsernameHint => 'O teu enderezo de correo';

  @override
  String get accountSetupNoEncryptionTitle => 'Queres conectarte sen cifrado?';

  @override
  String get accountSetupNoEncryptionText =>
      'O teu contrasinal e todas as mensaxes viaxarían como texto sen cifrar. Calquera persoa na rede, como unha wifi pública, podería lelos. Úsao só cun servidor da túa propia rede.';

  @override
  String get accountSetupUseWithoutEncryption => 'Usar sen cifrado';

  @override
  String get accountSetupApiTokenRejected =>
      'Rexeitouse o token de API. Crea un token de API de Fastmail para JMAP con acceso ao correo e pégao.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Rexeitouse o contrasinal. Usa un contrasinal de aplicación, non o contrasinal da túa conta.';

  @override
  String get accountSetupPasswordRejected => 'Rexeitouse o contrasinal. Compróbao e téntao de novo.';

  @override
  String get accountSetupServerUnreachable =>
      'Non se pode conectar co servidor. Comproba a configuración do servidor e a túa conexión.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'O certificado do servidor non é de confianza. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Cancelouse o inicio de sesión. Toca “Iniciar sesión con $provider” para tentalo de novo.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe necesita permiso para ler e enviar o teu correo de Gmail. Volve iniciar sesión e permite o acceso, coa caixa de Gmail marcada.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe necesita permiso para ler e enviar o teu correo. Volve iniciar sesión e acepta os permisos.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'A túa organización debe aprobar Loupe antes de que poidas usala con esta conta. Pídelle ao teu administrador de informática que lle conceda o consentimento de administrador a Loupe en Microsoft Entra ID e téntao de novo.';

  @override
  String get accountSetupOAuthBlocked =>
      'As regras de inicio de sesión da túa organización non permiten Loupe neste dispositivo. Pregúntalle ao teu administrador de informática.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Non se puido conectar con $provider. Comproba a túa conexión a internet e téntao de novo.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'O inicio de sesión con $provider non está ben configurado nesta versión de Loupe. Infórmanos, por favor.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'O inicio de sesión con $provider non funcionou. Téntao de novo.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider iniciou a túa sesión, pero Gmail denegou o acceso para este enderezo. Escolle a mesma conta ao iniciar sesión. Nas contas de traballo ou de centros educativos, pode que o administrador desactivase IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider iniciou a túa sesión, pero o servidor de correo denegou o acceso para este enderezo. Escolle a mesma conta ao iniciar sesión. Nas contas de traballo ou de centros educativos, pode que o administrador desactivase IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Non se pode conectar co servidor de correo. Comproba a túa conexión e téntao de novo.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'O inicio de sesión con $provider non está dispoñible nesta versión.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Volveuse iniciar sesión. $account estase a sincronizar.';
  }

  @override
  String get accountSetupSignInAgain => 'Volver iniciar sesión';

  @override
  String get accountSetupSigningIn => 'Iniciando sesión…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider xa non acepta o inicio de sesión de Loupe para $email, así que $account non se está a sincronizar. Volve iniciar sesión para recibir o seu correo.';
  }

  @override
  String get accountImportTitle => 'Importar de Thunderbird';

  @override
  String get accountImportPointCamera => 'Apunta a cámara ao código QR que mostra Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned de $total escaneados';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned de $total códigos escaneados',
      one: '$scanned de $total código escaneado',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas ata agora',
      one: '1 conta ata agora',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'No teu ordenador, abre Thunderbird e escolle Ferramentas › Exportar para móbil. Selecciona as túas contas e escanea cada código que mostre. Os códigos pódense escanear en calquera orde.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar con $count contas',
      one: 'Continuar con 1 conta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Pegar o texto';

  @override
  String get accountImportStartOver => 'Comezar de novo';

  @override
  String get accountImportDuplicateCode => 'Ese código xa se engadiu.';

  @override
  String get accountImportRestarted =>
      'Este código é dunha exportación nova, así que se descartaron os códigos escaneados antes.';

  @override
  String get accountImportNotThunderbird => 'Este non é un código de conta de Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Este código procede dun Thunderbird máis recente. Actualiza Loupe para importalo.';

  @override
  String get accountImportDamaged => 'Non se puido ler este código de Thunderbird.';

  @override
  String get accountImportTooLarge => 'Este código é demasiado grande para ser unha exportación de Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Non se puido abrir a configuración.';

  @override
  String get accountImportCameraOffTitle => 'O acceso á cámara está desactivado';

  @override
  String get accountImportCameraOffText =>
      'Permite que Loupe use a cámara na configuración para escanear o código, ou pega o texto do código.';

  @override
  String get accountImportNoCameraTitle => 'Non hai cámara';

  @override
  String get accountImportNoCameraText => 'Loupe non pode usar unha cámara aquí. Pega o texto do código.';

  @override
  String get accountImportCameraFailedTitle => 'A cámara non se iniciou';

  @override
  String get accountImportCameraFailedText => 'Téntao de novo ou pega o texto do código.';

  @override
  String get accountImportOpenSettings => 'Abrir a configuración';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atopáronse $count contas',
      one: 'Atopouse 1 conta',
      zero: 'Non se atopou ningunha conta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Non se puido ler ningunha das contas destes códigos.';

  @override
  String get accountImportChoose => 'Escolle as contas que queres engadir a Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Os códigos $codes de $total non se escanearon, así que as súas contas non aparecen.',
      one: 'O código $codes de $total non se escaneou, así que as súas contas non aparecen.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes e $last';
  }

  @override
  String get accountImportScanMore => 'Escanear máis códigos';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Non se puideron ler $count contas dos códigos. Pode que usen configuración dun Thunderbird máis recente.',
      one: 'Non se puido ler 1 conta dos códigos. Pode que use configuración dun Thunderbird máis recente.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Escanear de novo';

  @override
  String get accountImportAlreadyAdded => 'Xa hai en Loupe unha conta con este enderezo.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Iniciarás sesión con $provider cando se engada, como en Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Engade a conta cun contrasinal de aplicación (precisa a verificación en dous pasos).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird inicia sesión en Gmail con Google. “Iniciar sesión con Google” chegará nunha versión posterior; ata entón, engade a conta cun contrasinal de aplicación (precisa a verificación en dous pasos).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird inicia sesión nesta conta no navegador. Loupe aínda non pode facelo: usa un contrasinal de aplicación se o teu provedor o ofrece.';

  @override
  String get accountImportUnencrypted => 'Conéctase sen cifrado. Úsao só na túa propia rede.';

  @override
  String get accountImportEnterAgain => 'Introdúceo de novo';

  @override
  String get accountImportAdded => 'Engadida';

  @override
  String accountImportAdding(int index, int total) {
    return 'Engadindo $index de $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Engadir $count contas',
      one: 'Engadir 1 conta',
      zero: 'Engadir contas',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Pegar o texto de exportación';

  @override
  String get accountImportPasteText => 'Pega o texto dun código de exportación de Thunderbird, un código por liña.';

  @override
  String get accountImportPop3 => 'As contas POP3 non son compatibles. Loupe mantén o correo no servidor con IMAP.';

  @override
  String get accountImportKerberos => 'Esta conta inicia sesión con Kerberos, que Loupe non admite.';

  @override
  String get accountImportNtlm => 'Esta conta inicia sesión con NTLM, que Loupe non admite.';

  @override
  String get accountImportClientCertificate =>
      'Esta conta inicia sesión cun certificado de cliente, que Loupe aínda non admite.';

  @override
  String get accountImportMicrosoftSignIn =>
      'O inicio de sesión de Microsoft chegará nunha versión posterior. As contas de Outlook e Microsoft 365 xa non aceptan contrasinais das aplicacións de correo.';

  @override
  String get accountImportEnterPassword => 'Introduce o contrasinal.';

  @override
  String get accountImportEnterAppPassword => 'Introduce o contrasinal de aplicación.';

  @override
  String get accountImportEnterApiToken => 'Introduce o token de API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe non puido abrir o seu almacenamento de contas. Téntao de novo máis tarde.';

  @override
  String get accountImportFailed => 'Non se puido engadir a conta. Téntao de novo ou engádea manualmente.';

  @override
  String get composeNewMessageTitle => 'Nova mensaxe';

  @override
  String get composeAttach => 'Anexar';

  @override
  String get composeSendLater => 'Enviar máis tarde';

  @override
  String composeSendAt(String time) {
    return 'Enviar $time';
  }

  @override
  String get composeSendHint => 'Mantén premido para enviar máis tarde';

  @override
  String get composeNoAccount => 'Engade unha conta para enviar correo.';

  @override
  String get composeTo => 'Para:';

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
  String get composeSubjectLabel => 'Asunto:';

  @override
  String composeReplyTo(String address) {
    return 'Responder a: $address';
  }

  @override
  String get composeFrom => 'De';

  @override
  String composeReplyFrom(String email) {
    return 'Responder desde $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Enviar desde $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Queres responder desde $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Queres enviar desde $email?';
  }

  @override
  String get composeDismiss => 'Descartar';

  @override
  String composeAliasNotSaved(String account) {
    return 'Non gardado como identidade · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Gardar como identidade';

  @override
  String composeAliasSaved(String email) {
    return '$email gardouse como identidade.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Enderezo non válido $address';
  }

  @override
  String get composeOriginalNotFound => 'Non se atopou a mensaxe orixinal.';

  @override
  String get composeDraftNotFound => 'Non se atopou o borrador.';

  @override
  String get composeAttachmentsLost => 'Non se puideron recuperar os anexos. Engádeos de novo.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Non se puideron engadir algúns anexos: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Os anexos suman $size; algúns servidores rexeitan mensaxes tan grandes.';
  }

  @override
  String get composeAttachFailed => 'Non se puido anexar o ficheiro.';

  @override
  String get composeInvalidAddressTitle => 'Enderezo non válido';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” non é un enderezo de correo válido.';
  }

  @override
  String get composeNoSubjectTitle => 'Sen asunto';

  @override
  String get composeNoSubjectText => 'Esta mensaxe non ten asunto. Queres enviala igualmente?';

  @override
  String get composeSentBeforeChanges => 'Enviouse antes dos teus cambios, que se gardaron en Borradores.';

  @override
  String composeScheduled(String time) {
    return 'Programada para $time';
  }

  @override
  String get composeSending => 'Enviando…';

  @override
  String get composeSent => 'Enviada';

  @override
  String get composeSendFailed => 'Non se puido enviar. Téntao de novo.';

  @override
  String get composeAlreadySent => 'Xa se enviou.';

  @override
  String get composeDiscardChanges => 'Descartar os cambios';

  @override
  String get composeSaveChanges => 'Gardar os cambios';

  @override
  String get composeDeleteDraft => 'Eliminar o borrador';

  @override
  String get composeSaveDraft => 'Gardar o borrador';

  @override
  String get composeDraftSaved => 'Borrador gardado';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'O $date ás $time, $name escribiu:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'O $date ás $time, alguén escribiu:';
  }

  @override
  String get composeForwardHeader => '---------- Mensaxe reenviada ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date ás $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Asunto: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Para: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Hoxe máis tarde';

  @override
  String get composeTomorrowMorning => 'Mañá pola mañá';

  @override
  String get composeMondayMorning => 'O luns pola mañá';

  @override
  String get composePickDateTime => 'Escoller data e hora…';

  @override
  String get composeSendWithoutDelay => 'Enviar sen agardar';

  @override
  String composeSendTimeToday(String time) {
    return 'Hoxe ás $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Mañá ás $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day ás $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Hoxe $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Mañá $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Queres seguir editando o teu borrador?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Unha mensaxe non se enviou ao pecharse Loupe.',
      'one': 'Unha mensaxe para $name non se enviou ao pecharse Loupe.',
      'other': 'Unha mensaxe para $name e outras persoas non se enviou ao pecharse Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '“$subject” non se enviou ao pecharse Loupe.',
      'one': '“$subject” para $name non se enviou ao pecharse Loupe.',
      'other': '“$subject” para $name e outras persoas non se enviou ao pecharse Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Seguir editando';

  @override
  String get composeRecoverySave => 'Gardar en Borradores';

  @override
  String get composeRecoveryDiscard => 'Descartar';

  @override
  String get composeRecoverySaved => 'Gardada en Borradores';

  @override
  String get outboxSectionFailed => 'Non enviadas';

  @override
  String get outboxSectionSending => 'Enviando';

  @override
  String get outboxSectionScheduled => 'Programadas';

  @override
  String get outboxStatusQueued => 'Enviarase pronto';

  @override
  String get outboxStatusSending => 'Enviando…';

  @override
  String get outboxStatusFailed => 'Non enviada';

  @override
  String get outboxNoRecipients => 'Sen destinatarios';

  @override
  String get outboxNoSubject => '(Sen asunto)';

  @override
  String get outboxSendingFailed => 'Non se puido enviar.';

  @override
  String get outboxEmptyTitle => 'Nada que enviar';

  @override
  String get outboxEmptyText => 'As mensaxes que envías máis tarde agardan aquí ata que chega a súa hora.';

  @override
  String get outboxSendNow => 'Enviar agora';

  @override
  String get outboxReschedule => 'Reprogramar';

  @override
  String get outboxRescheduleMenu => 'Reprogramar…';

  @override
  String get outboxRescheduleTitle => 'Reprogramar';

  @override
  String outboxRescheduled(String time) {
    return 'Reprogramada para $time';
  }

  @override
  String get outboxCancel => 'Cancelar';

  @override
  String get outboxCancelSending => 'Cancelar o envío…';

  @override
  String get outboxCancelTitle => 'Queres cancelar o envío?';

  @override
  String get outboxMoveToDrafts => 'Mover a Borradores';

  @override
  String get outboxDiscard => 'Descartar a mensaxe';

  @override
  String get outboxMovedToDrafts => 'Movida a Borradores';

  @override
  String get outboxDiscarded => 'Mensaxe descartada';

  @override
  String get outboxAlreadySent => 'Xa se enviou.';

  @override
  String get outboxBeingSent => 'Esta mensaxe estase a enviar.';

  @override
  String get outboxActionFailed => 'Non funcionou. A mensaxe segue na caixa de saída.';

  @override
  String get notificationsBadgeInboxes => 'Sen ler nas caixas de entrada';

  @override
  String get notificationsBadgeVip => 'Sen ler de VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Correo novo dos teus VIP, en calquera conta';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Correo novo en $email';
  }

  @override
  String get notificationsUnknownSender => 'Remitente descoñecido';

  @override
  String get notificationsNoSubject => '(Sen asunto)';

  @override
  String get notificationsEncryptedMessage => 'Mensaxe cifrada';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nova mensaxe de $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensaxes novas',
      one: '1 mensaxe nova',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Mensaxes novas en $account';
  }

  @override
  String get platformInstantChannel => 'Entrega instantánea';

  @override
  String get platformInstantChannelDescription =>
      'Móstrase mentres Loupe vixía se chega correo novo ás túas caixas de entrada';

  @override
  String get platformInstantTitle => 'Atento ao correo novo';

  @override
  String get platformInstantText => 'A entrega instantánea está activada';

  @override
  String get platformErrorBox => 'Algo fallou ao mostrar isto. Volve atrás e téntao de novo.';

  @override
  String get welcomeTagline => 'Correo sinxelo por fóra\ne potente por dentro.';

  @override
  String get welcomeAccountsTitle => 'Todas as contas, unha caixa tranquila';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail e calquera servidor IMAP ou JMAP.';

  @override
  String get welcomeSearchTitle => 'Unha busca que o atopa';

  @override
  String get welcomeSearchText => 'Resultados ao instante no teu teléfono e, despois, os do servidor.';

  @override
  String get welcomePrivacyTitle => 'Privada por deseño';

  @override
  String get welcomePrivacyText => 'Sen rastrexo. As imaxes remotas seguen bloqueadas ata que ti o digas.';

  @override
  String get welcomeAddAccount => 'Engadir conta';

  @override
  String get welcomeImport => 'Importar de Thunderbird';

  @override
  String get welcomeTryDemo => 'Probar co correo de demostración';
}
