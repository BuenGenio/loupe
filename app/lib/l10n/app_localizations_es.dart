// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commonAdd => 'Añadir';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonDone => 'Hecho';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonMore => 'Más';

  @override
  String get commonMove => 'Mover';

  @override
  String get commonName => 'Nombre';

  @override
  String get commonNone => 'Ninguno';

  @override
  String get commonOff => 'Desactivado';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonOn => 'Activado';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonPassword => 'Contraseña';

  @override
  String get commonRemove => 'Quitar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonServer => 'Servidor';

  @override
  String get commonSettings => 'Ajustes';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonTryAgain => 'Volver a intentarlo';

  @override
  String get commonUndo => 'Deshacer';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensajes', one: '1 mensaje');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivar';

  @override
  String get mailDelete => 'Eliminar';

  @override
  String get mailFlag => 'Marcar con bandera';

  @override
  String get mailForward => 'Reenviar';

  @override
  String get mailMarkAsRead => 'Marcar como leído';

  @override
  String get mailMarkAsUnread => 'Marcar como no leído';

  @override
  String get mailMoveToJunk => 'Mover a correo no deseado';

  @override
  String get mailNewMessage => 'Mensaje nuevo';

  @override
  String get mailNoSubject => 'Sin asunto';

  @override
  String get mailReply => 'Responder';

  @override
  String get mailReplyAll => 'Responder a todos';

  @override
  String get mailSend => 'Enviar';

  @override
  String get mailUnflag => 'Quitar bandera';

  @override
  String get mailboxArchive => 'Archivo';

  @override
  String get mailboxDrafts => 'Borradores';

  @override
  String get mailboxInbox => 'Bandeja de entrada';

  @override
  String get mailboxJunk => 'Correo no deseado';

  @override
  String get mailboxOutbox => 'Bandeja de salida';

  @override
  String get mailboxSent => 'Enviados';

  @override
  String get mailboxTrash => 'Papelera';

  @override
  String get conversationSomethingWentWrong => 'Algo ha fallado. Vuelve a intentarlo.';

  @override
  String get conversationReplyToList => 'Responder a la lista';

  @override
  String get conversationReplyList => 'Responder a lista';

  @override
  String get conversationThreadMuted => 'Hilo silenciado. Sus mensajes nuevos llegarán como leídos.';

  @override
  String get conversationThreadUnmuted => 'Hilo ya no silenciado.';

  @override
  String get conversationLinkFailed => 'No se ha podido abrir el enlace.';

  @override
  String get conversationGoneTitle => 'Sin mensaje';

  @override
  String get conversationGoneText => 'Este mensaje se ha movido o eliminado.';

  @override
  String get conversationMuted => 'Silenciado';

  @override
  String get conversationReaderOptions => 'Opciones de lectura';

  @override
  String get conversationReaderOptionsHint => 'Tamaño del texto y vista';

  @override
  String get conversationTrash => 'Papelera';

  @override
  String get conversationReplyHint => 'Mantén pulsado para Responder a todos y Reenviar';

  @override
  String get conversationOfflineTitle => 'Sin conexión';

  @override
  String get conversationOfflineText =>
      'Esta conversación aún no se ha descargado. Se cargará cuando vuelvas a tener conexión.';

  @override
  String get conversationErrorTitle => 'No se puede mostrar este mensaje';

  @override
  String get conversationErrorText => 'Algo ha fallado.';

  @override
  String get conversationOfflineBanner => 'Sin conexión';

  @override
  String get conversationNotUpdated => 'Sin actualizar';

  @override
  String get conversationMe => 'mí';

  @override
  String get conversationNoSender => '(sin remitente)';

  @override
  String get conversationNoRecipients => 'sin destinatarios';

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
  String get conversationHeaderDate => 'Fecha';

  @override
  String get conversationHeaderSecurity => 'Seguridad';

  @override
  String get conversationVerifiedSender => 'Remitente verificado';

  @override
  String get conversationUnverifiedSender => 'Remitente no verificado';

  @override
  String get conversationLoadingMessage => 'Cargando el mensaje';

  @override
  String get conversationBodyError => 'No se ha podido cargar este mensaje.';

  @override
  String get conversationBodyOffline => 'No tienes conexión. El mensaje se cargará cuando vuelvas a tenerla.';

  @override
  String get conversationOriginalHint => 'Se ve mejor en la vista Original';

  @override
  String get conversationShowOriginal => 'Ver original';

  @override
  String get conversationScrollToTop => 'Desplazarse al principio';

  @override
  String get conversationTagsMenu => 'Etiquetas…';

  @override
  String get conversationMuteThread => 'Silenciar hilo';

  @override
  String get conversationUnmuteThread => 'Dejar de silenciar hilo';

  @override
  String get conversationMoveMenu => 'Mover…';

  @override
  String get conversationDeletePermanently => 'Eliminar definitivamente';

  @override
  String get conversationMoveToTrash => 'Mover a la papelera';

  @override
  String get conversationNotJunk => 'No es correo no deseado';

  @override
  String get conversationShowAllHeaders => 'Ver todas las cabeceras';

  @override
  String get conversationViewSource => 'Ver código fuente';

  @override
  String get conversationSaveAsFile => 'Guardar como archivo…';

  @override
  String get conversationShareAsFile => 'Compartir como archivo…';

  @override
  String get conversationSearchFromMessageMenu => 'Buscar a partir de este mensaje…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copiar dirección';

  @override
  String get conversationAddressCopied => 'Dirección copiada';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Buscar mensajes de $name';
  }

  @override
  String get conversationTags => 'Etiquetas';

  @override
  String get conversationAllHeaders => 'Todas las cabeceras';

  @override
  String get conversationCopyAll => 'Copiar todo';

  @override
  String get conversationHeadersCopied => 'Cabeceras copiadas';

  @override
  String get conversationNoHeaders => 'Sin cabeceras';

  @override
  String get conversationSearchFromMessageTitle => 'Buscar a partir de este mensaje';

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
    return 'Asunto «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Código fuente';

  @override
  String get conversationSourceCopied => 'Código fuente copiado';

  @override
  String get conversationShareFailed => 'No se ha podido compartir el mensaje.';

  @override
  String get conversationWrapLines => 'Ajustar líneas';

  @override
  String get conversationDontWrapLines => 'No ajustar líneas';

  @override
  String get conversationSourceError => 'No se ha podido cargar el código fuente.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Se muestran los primeros $shown de $total. Cópialo o compártelo para obtenerlo entero.';
  }

  @override
  String get conversationAttachmentUntitled => 'Sin título';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Más acciones para $name';
  }

  @override
  String get conversationMoveTo => 'Mover a…';

  @override
  String get conversationMailboxesError => 'No se han podido cargar los buzones.';

  @override
  String get conversationReaderReadable => 'Legible';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Sin formato';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Mantener los colores originales';

  @override
  String get conversationReaderRemember => 'Recordar para este remitente';

  @override
  String get conversationSecurityPossiblePhishing => 'Posible phishing';

  @override
  String get conversationSecurityBeCareful => 'Ten cuidado';

  @override
  String get conversationSecurityVerified => 'Verificado';

  @override
  String get conversationSecurityNoIssues => 'No se han encontrado problemas';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count rastreadores', one: '1 rastreador');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Muestra el motivo';

  @override
  String get conversationPhishingBannerTitle => 'Este mensaje parece phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Los enlaces y las imágenes están desactivados.';
  }

  @override
  String get conversationPhishingBannerText => 'Los enlaces y las imágenes están desactivados.';

  @override
  String get conversationPhishingWhy => '¿Por qué?';

  @override
  String get conversationPhishingShowAnyway => 'Mostrar de todos modos';

  @override
  String get conversationSecurityPhishingTitle => 'Esto parece phishing';

  @override
  String get conversationSecurityPhishingText => 'Varias señales indican que este mensaje no es lo que dice ser.';

  @override
  String get conversationSecurityCarefulTitle => 'Ten cuidado con este mensaje';

  @override
  String get conversationSecurityCarefulText => 'Hay algo en él que merece una segunda mirada.';

  @override
  String get conversationSecurityVerifiedText => 'El remitente está verificado y nada parece sospechoso.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nada parece sospechoso. Tu servidor de correo no ha indicado si el remitente está verificado.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nada parece sospechoso.';

  @override
  String get conversationSecurityWhy => 'Por qué';

  @override
  String get conversationSecurityPrivacy => 'Privacidad';

  @override
  String get conversationSecurityNoTrackingPixels => 'Sin píxeles de seguimiento';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count píxeles de seguimiento eliminados',
      one: '1 píxel de seguimiento eliminado',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Le habrían dicho al remitente cuándo abriste este mensaje.';

  @override
  String get conversationSecurityNoRemoteImages => 'Sin imágenes remotas';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imágenes remotas',
      one: '1 imagen remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Cargarlas le dice al remitente cuándo lees este mensaje, y tu dirección IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Sin seguimiento de clics';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enlaces pasan por rastreadores de clics',
      one: '1 enlace pasa por rastreadores de clics',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services registraría tu clic. Mantén pulsado un enlace para abrir directamente su destino.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Detalles técnicos';

  @override
  String get conversationSecurityCheckedLocally =>
      'Comprobado en este dispositivo. No se ha enviado nada a ningún sitio.';

  @override
  String get conversationSecurityTrackersLabel => 'Rastreadores';

  @override
  String get conversationSecurityImagesFrom => 'Imágenes de';

  @override
  String get conversationSecuritySenderHistory => 'Historial del remitente';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received recibidos, $sent enviados';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Los enlaces llevan a';

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
  String get conversationSecurityAuthFailedTitle => 'Remitente no verificado';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Tu servidor de correo no ha podido confirmar que este mensaje venga realmente de $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Tu servidor de correo no ha podido confirmar que este mensaje venga realmente de su remitente.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Tu servidor de correo no ha podido confirmar que este mensaje venga de $domain. Es habitual en las listas de correo.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Tu servidor de correo no ha podido confirmar que este mensaje venga de su remitente. Es habitual en las listas de correo.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'No hagas nada de lo que pide salvo que lo esperaras. Si tienes dudas, contacta con el remitente por otra vía.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Firmado por otro dominio';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'El mensaje está firmado por $signer, no por $domain. Los servicios de envío masivo lo hacen, pero no demuestra quién lo escribió.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'El mensaje está firmado por otro dominio, no por $domain. Los servicios de envío masivo lo hacen, pero no demuestra quién lo escribió.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'El nombre muestra otra dirección';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'El nombre del remitente dice «$shown», pero el mensaje viene de $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fíate de la dirección, no del nombre.';

  @override
  String get conversationSecurityReplyToTitle => 'Las respuestas van a otro sitio';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Si respondes, tu respuesta irá a $address, no a $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Comprueba la dirección antes de responder con algo personal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Usa tu nombre';

  @override
  String get conversationSecurityImpersonationTitle => 'Usa el nombre de alguien que conoces';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Está firmado como «$name», igual que tu nombre, pero viene de una dirección nueva: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Está firmado como «$name», igual que tu VIP $knownName ($knownEmail), pero viene de una dirección nueva: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Está firmado como «$name», igual que $knownName ($knownEmail), pero viene de una dirección nueva: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Y las respuestas irían a otra dirección más.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Si pide dinero, códigos o archivos, confírmalo antes con esa persona por otra vía.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Dirección conocida: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Esta dirección: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primer mensaje de este remitente';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Hasta ahora no habías recibido correo de $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Ten cuidado con las peticiones de personas que aún no conoces.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Letras engañosas en la dirección del remitente';

  @override
  String get conversationSecurityLinkHomographTitle => 'Letras engañosas en un enlace';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mezcla letras de distintos alfabetos para imitar otra dirección.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host usa letras que parecen otras: no es $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Elimínalo o márcalo como correo no deseado.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'No lo abras.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Dominio: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Dominio que imita a otro';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Usa un nombre conocido en su dominio';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain se parece a tu propio dominio, $real, pero es un dominio distinto.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain se parece a $brand ($real), pero es un dominio distinto.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain usa el nombre de tu propio dominio, $real, pero no le pertenece.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain usa el nombre de $brand ($real), pero no le pertenece.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Los mensajes reales de tu organización vienen de $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Los mensajes reales de $brand vienen de $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Dominio del remitente: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imita a: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enlaces ocultan adónde llevan',
      one: 'Un enlace oculta adónde lleva',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Un enlace muestra $shown, pero abre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'No inicies sesión ni pagues a través de estos enlaces. Escribe tú mismo la dirección.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'No se puede comprobar el destino de un enlace';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Un enlace muestra $shown, pero pasa por $host, que registra el clic antes de redirigirlo.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Un enlace apunta a una dirección IP sin más';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts no es un sitio web con nombre. Las empresas reales casi nunca enlazan así.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Un enlace disfrazado';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Un enlace empieza por «$shown@» para parecer $shown, pero abre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Se ha desactivado una página oculta';

  @override
  String get conversationSecurityDataLinkText =>
      'Un enlace habría abierto una página incrustada en el mensaje, una forma de esquivar la comprobación de enlaces.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Pide una contraseña';

  @override
  String get conversationSecurityPasswordFieldText =>
      'El mensaje contenía un campo de contraseña. Loupe lo ha eliminado.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nunca escribas una contraseña en un correo.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Se ha desactivado un enlace que ejecuta código';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nunca ejecuta código de los mensajes.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Enlaces acortados',
      one: 'Un enlace acortado',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts oculta el destino real hasta que lo abres.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Dirección web internacional';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts usa letras no latinas. Es normal en muchos idiomas; comprueba que es el sitio que esperas.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Mucho texto oculto';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Se han eliminado $count caracteres de texto invisible. Un texto oculto así sirve para engañar a los filtros de spam.',
      one:
          'Se ha eliminado $count carácter de texto invisible. Un texto oculto así sirve para engañar a los filtros de spam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Texto oculto eliminado';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se han eliminado $count caracteres de texto invisible.',
      one: 'Se ha eliminado $count carácter de texto invisible.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'No se ha podido descargar el mensaje. Comprueba la conexión y vuelve a intentarlo.';

  @override
  String exportSaved(String name) {
    return 'Se ha guardado «$name»';
  }

  @override
  String get exportSaveFailed => 'No se ha podido guardar el mensaje.';

  @override
  String exportFailed(String folder) {
    return 'No se ha podido exportar «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» no tiene mensajes que exportar.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'No se ha podido exportar «$folder»: no se ha podido descargar ningún mensaje. Comprueba la conexión y vuelve a intentarlo.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se ha guardado «$name» sin $formattedCount mensajes que no se han podido descargar.',
      one: 'Se ha guardado «$name» sin 1 mensaje que no se ha podido descargar.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'No se ha podido guardar «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'Exportando «$folder»';
  }

  @override
  String get exportListing => 'Buscando mensajes…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportando $current de $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'No se han podido descargar $formattedCount mensajes',
      one: 'No se ha podido descargar 1 mensaje',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Buzones';

  @override
  String get mailboxesShown => 'Visible';

  @override
  String get mailboxesHidden => 'Oculto';

  @override
  String get mailboxesCollapse => 'Contraer';

  @override
  String get mailboxesExpand => 'Expandir';

  @override
  String get mailboxesManageVips => 'Gestionar VIP';

  @override
  String get mailboxesSubscriptions => 'Suscripciones';

  @override
  String mailboxesShowAccount(String account) {
    return 'Mostrar $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ocultar $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportar carpeta…';

  @override
  String get mailboxesUnpin => 'Dejar de fijar';

  @override
  String get mailboxesLists => 'Listas';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Guarda una búsqueda para tenerla aquí.';

  @override
  String get mailboxesTags => 'Etiquetas';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'También puedes tocar el nombre de un remitente en un mensaje y activar VIP.';

  @override
  String get mailboxesAddVip => 'Añadir VIP…';

  @override
  String get mailboxesAddVipTitle => 'Añadir VIP';

  @override
  String get mailboxesAddVipText => 'El correo de esta dirección lleva una estrella y aparece en el buzón VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'No leídos';

  @override
  String get messageListFilterFlagged => 'Con bandera';

  @override
  String get messageListFilterToMe => 'Para: mí';

  @override
  String get messageListFilterCcMe => 'Cc: mí';

  @override
  String get messageListFilterWithAttachments => 'Con adjuntos';

  @override
  String get messageListFilterUnreplied => 'Sin responder';

  @override
  String get messageListFilterFromVips => 'De VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes marcados como leídos',
      one: '1 mensaje marcado como leído',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'No se ha podido cargar el correo más antiguo.';

  @override
  String get messageListSelectMessages => 'Seleccionar mensajes';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionados',
      one: '$count seleccionado',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Seleccionar todo';

  @override
  String get messageListDeselectAll => 'Deseleccionar todo';

  @override
  String get messageListLoadFailed => 'No se ha podido cargar el correo';

  @override
  String get messageListNoUnread => 'No hay correo sin leer';

  @override
  String get messageListNoMatches => 'No hay correo que coincida';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrado por: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Desactivar filtro';

  @override
  String get messageListEmpty => 'No hay correo';

  @override
  String get messageListFilter => 'Filtrar';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Criterios de filtro: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrado por:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount no leídos',
      one: '$formattedCount no leído',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marcar';

  @override
  String get messageListTrash => 'Papelera';

  @override
  String get messageListFilterTitle => 'Filtro';

  @override
  String get messageListFilterInclude => 'INCLUIR';

  @override
  String get panesHideMailboxes => 'Ocultar buzones';

  @override
  String get panesShowMailboxes => 'Mostrar buzones';

  @override
  String get panesMailboxesWidth => 'Ancho de los buzones';

  @override
  String get panesListWidth => 'Ancho de la lista de mensajes';

  @override
  String get panesNoMessageSelected => 'Ningún mensaje seleccionado';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensajes', one: '1 mensaje');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Pospuestos';

  @override
  String get snoozeSheetTitle => 'Posponer';

  @override
  String get snoozeLaterToday => 'Más tarde hoy';

  @override
  String get snoozeThisEvening => 'Esta tarde';

  @override
  String get snoozeTomorrow => 'Mañana';

  @override
  String get snoozeThisWeekend => 'Este fin de semana';

  @override
  String get snoozeNextWeek => 'La semana que viene';

  @override
  String get snoozePickDateTime => 'Elegir fecha y hora…';

  @override
  String get snoozeMenu => 'Posponer…';

  @override
  String get snoozeWakeNow => 'Recuperar ahora';

  @override
  String get snoozeChangeTimeMenu => 'Cambiar hora de posposición…';

  @override
  String get snoozeChangeTime => 'Cambiar hora';

  @override
  String get snoozeNoTime => 'Sin hora fijada';

  @override
  String get snoozeFooter => 'Los mensajes pospuestos vuelven a la bandeja de entrada, como no leídos, a su hora.';

  @override
  String get snoozeEmptyTitle => 'Nada pospuesto';

  @override
  String get snoozeEmptyText => 'Pospón un mensaje para que vuelva a la bandeja de entrada cuando lo necesites.';

  @override
  String get appLockUnlock => 'Desbloquear';

  @override
  String get appLockFailed => 'Loupe no ha podido confirmar que eres tú.';

  @override
  String get appLockLockedOut => 'Demasiados intentos. Vuelve a intentarlo más tarde.';

  @override
  String get appLockPromptError => 'No se ha podido mostrar la solicitud. Vuelve a intentarlo.';

  @override
  String get appLockNoScreenLock => 'Este teléfono no tiene bloqueo de pantalla.';

  @override
  String get appLockUnlockPromptTitle => 'Desbloquear Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirma que eres tú para ver tu correo.';

  @override
  String get appLockTurnOnPromptTitle => 'Activar el bloqueo de la app';

  @override
  String get appLockTurnOnPromptReason => 'Confirma que eres tú para activar el bloqueo de la app.';

  @override
  String get appLockScreenLockRemoved =>
      'El bloqueo de la app está desactivado: este teléfono ya no tiene bloqueo de pantalla. Configura uno para volver a activar el bloqueo de la app.';

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
  String get openpgpEncrypted => 'Cifrado';

  @override
  String get openpgpEncryptedInPart => 'Cifrado en parte';

  @override
  String get openpgpEncryptedLocked => 'Cifrado · bloqueado';

  @override
  String get openpgpEncryptedNoKey => 'Cifrado · sin clave';

  @override
  String get openpgpEncryptedDamaged => 'Cifrado · dañado';

  @override
  String get openpgpEncryptedUnsupported => 'Cifrado · no compatible';

  @override
  String get openpgpUnknownSigner => 'desconocido';

  @override
  String get openpgpUnknownKey => 'Clave desconocida';

  @override
  String get openpgpSignatureInvalid => 'Firma no válida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Firmado por $name, no por el remitente';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Firmado en parte por $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Firmado por $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Firmado con una clave rechazada';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Firmado por $name · clave no aceptada';
  }

  @override
  String get openpgpUnlock => 'Desbloquear';

  @override
  String get openpgpCantDecrypt => 'No se puede descifrar este mensaje';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Cifrado con OpenPGP';

  @override
  String get openpgpEncryption => 'Cifrado';

  @override
  String get openpgpDecryptedHere => 'Descifrado en este dispositivo';

  @override
  String get openpgpNotDecrypted => 'Sin descifrar';

  @override
  String get openpgpKeyLocked => 'Tu clave está bloqueada.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Para las claves $keys',
      one: 'Para la clave $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Asunto protegido';

  @override
  String get openpgpUnlockKey => 'Desbloquear clave';

  @override
  String get openpgpSignature => 'Firma';

  @override
  String get openpgpFingerprint => 'Huella digital';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID de clave $id';
  }

  @override
  String get openpgpSigned => 'Firmado';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Aceptación';

  @override
  String get openpgpChangeAcceptance => 'Cambiar aceptación…';

  @override
  String get openpgpCheckedFooter => 'Comprobado en este dispositivo con OpenPGP, compatible con Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Tu clave está bloqueada. Desbloquéala con su frase de contraseña para leer este mensaje.';

  @override
  String get openpgpSummaryNoSecretKey => 'Se cifró para una clave que no está en este dispositivo.';

  @override
  String get openpgpSummaryDamaged => 'Los datos cifrados están dañados o se modificaron por el camino.';

  @override
  String get openpgpSummaryUnsupported => 'Usa un algoritmo que Loupe no admite.';

  @override
  String get openpgpSummaryEncrypted => 'Solo tú y los demás destinatarios podéis leerlo.';

  @override
  String get openpgpSummaryNotSigned => 'No está firmado, así que el remitente no está confirmado.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Está firmado, pero con una clave que no tienes, así que no se puede comprobar la firma.';

  @override
  String get openpgpSummaryBadSignature => 'La firma no coincide: puede que el mensaje se haya modificado.';

  @override
  String get openpgpSummaryMismatch =>
      'La firma es válida, pero la clave pertenece a una dirección distinta de la del remitente.';

  @override
  String get openpgpSummaryPartial =>
      'Solo una parte del mensaje está firmada. El texto fuera de la firma (por ejemplo, el pie de una lista de correo) se muestra debajo de la línea «Unsigned content», y otras partes del mensaje, como los adjuntos, tampoco están cubiertas.';

  @override
  String get openpgpSummaryOwnKey => 'Firmado con tu propia clave.';

  @override
  String get openpgpSummaryVerified => 'La firma es válida y has verificado la huella digital de la clave.';

  @override
  String get openpgpSummaryUnverified => 'La firma es válida. Aceptaste la clave sin comprobar su huella digital.';

  @override
  String get openpgpSummaryRejected => 'La firma es válida, pero rechazaste esta clave.';

  @override
  String get openpgpSummaryUndecided =>
      'La firma es válida, pero aún no has aceptado esta clave. Compara su huella digital con el remitente.';

  @override
  String get openpgpAcceptanceRejected => 'Rechazada';

  @override
  String get openpgpAcceptanceUndecided => 'No aceptada';

  @override
  String get openpgpAcceptanceUnverified => 'Aceptada';

  @override
  String get openpgpAcceptanceVerified => 'Aceptada y verificada';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return '¿Aceptar la clave de $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Huella digital $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Sí, he verificado la huella digital';

  @override
  String get openpgpAcceptUnverified => 'Sí, sin comprobarla';

  @override
  String get openpgpAcceptLater => 'Todavía no';

  @override
  String get openpgpRejectKey => 'Rechazar esta clave';

  @override
  String get openpgpNoSubject => '(sin asunto)';

  @override
  String get openpgpEncryptionTitle => 'Cifrado de extremo a extremo';

  @override
  String get openpgpMyKeys => 'Mis claves OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Con una clave puedes leer correo cifrado y firmar y cifrar el tuyo. ¿Usas Thunderbird? Exporta allí tu clave (Configuración de la cuenta › Cifrado de extremo a extremo › Exportar clave secreta) e impórtala aquí.';

  @override
  String get openpgpAddKey => 'Añadir clave…';

  @override
  String get openpgpAddresses => 'Direcciones';

  @override
  String get openpgpAddressesFooter => 'Qué clave usa cada dirección y cuándo cifra y firma.';

  @override
  String get openpgpCorrespondentsKeys => 'Claves OpenPGP de tus contactos';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Acepta una clave cuando confíes en que pertenece a su propietario; compara la huella digital con esa persona para marcarla como verificada.';

  @override
  String get openpgpImportPublicKey => 'Importar clave pública…';

  @override
  String get openpgpCollected => 'Recogidas con Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Claves que llegaron con los mensajes. Loupe puede cifrar para ellas cuando ambas partes lo piden.';

  @override
  String get openpgpOnThisDevice => 'En este dispositivo';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Los mensajes cifrados ocultan su asunto. Loupe guarda el asunto de cada mensaje que abres en su base de datos cifrada de este dispositivo, para que la lista, la búsqueda y las notificaciones lo muestren. En segundo plano, Loupe también puede descifrar los asuntos de los mensajes nuevos con claves sin frase de contraseña; para ello descarga cada mensaje (hasta 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Descifrar asuntos en segundo plano';

  @override
  String get openpgpIndexFooter =>
      'La búsqueda encuentra los mensajes cifrados por su remitente, sus destinatarios y su asunto. Con esta opción activada, Loupe también añade el texto de cada mensaje cifrado que descifra al índice de búsqueda de su base de datos cifrada de este dispositivo, para que la búsqueda también lo encuentre por su texto. Al desactivarla, ese texto se quita del índice.';

  @override
  String get openpgpIndexDecrypted => 'Indexar mensajes descifrados para la búsqueda';

  @override
  String get openpgpPassphrases => 'Frases de contraseña';

  @override
  String get openpgpPassphrasesFooter =>
      'Las claves OpenPGP y los certificados S/MIME que proteges con una frase de contraseña se desbloquean cuando hace falta. Sin «Recordar», se vuelven a bloquear dos minutos después de cada uso.';

  @override
  String get openpgpRememberPassphrases => 'Recordar frases de contraseña';

  @override
  String get openpgpRememberPassphrasesDetail => 'Hasta que Loupe se cierre';

  @override
  String get openpgpLockKeysNow => 'Bloquear claves ahora';

  @override
  String get openpgpKeysLocked => 'Claves bloqueadas.';

  @override
  String get openpgpKeyStateRevoked => 'revocada';

  @override
  String get openpgpKeyStateExpired => 'caducada';

  @override
  String get openpgpKeyStateNeverExpires => 'no caduca nunca';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'caduca el $date';
  }

  @override
  String get openpgpNoKey => 'Sin clave';

  @override
  String get openpgpAlwaysEncrypt => 'Cifrar siempre';

  @override
  String get openpgpAddKeyTitle => 'Añadir una clave OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importa la clave que usas en Thunderbird o crea una nueva.';

  @override
  String get openpgpImportFromClipboard => 'Importar del portapapeles';

  @override
  String get openpgpImportFromFile => 'Importar de un archivo';

  @override
  String get openpgpGenerateNewKey => 'Generar clave nueva';

  @override
  String get openpgpImportPublicKeyTitle => 'Importar una clave pública';

  @override
  String get openpgpFromClipboard => 'Del portapapeles';

  @override
  String get openpgpFromFile => 'De un archivo';

  @override
  String get openpgpClipboardEmpty => 'El portapapeles está vacío. Copia primero la clave.';

  @override
  String get openpgpKey => 'Clave';

  @override
  String get openpgpValidityRevoked => 'Revocada';

  @override
  String openpgpValidityExpired(String date) {
    return 'Caducó el $date';
  }

  @override
  String get openpgpNeverExpires => 'No caduca nunca';

  @override
  String openpgpValidUntil(String date) {
    return 'Válida hasta el $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Huella digital copiada.';

  @override
  String get openpgpAlgorithm => 'Algoritmo';

  @override
  String get openpgpCreated => 'Creada';

  @override
  String get openpgpValidity => 'Validez';

  @override
  String get openpgpProtection => 'Protección';

  @override
  String get openpgpProtectionPassphrase => 'Frase de contraseña';

  @override
  String get openpgpProtectionKeychain => 'Solo el llavero';

  @override
  String get openpgpKeyDetailsFooter =>
      'Comparte tu clave pública para que otros puedan cifrarte mensajes. La copia de seguridad es tu clave secreta, protegida por su frase de contraseña si la tiene: no la compartas.';

  @override
  String get openpgpSharePublicKey => 'Compartir clave pública';

  @override
  String get openpgpCopyPublicKey => 'Copiar clave pública';

  @override
  String get openpgpPublicKeyCopied => 'Clave pública copiada.';

  @override
  String get openpgpBackUpSecretKey => 'Hacer copia de la clave secreta';

  @override
  String get openpgpDeleteKey => 'Eliminar clave';

  @override
  String get openpgpRemoveKey => 'Quitar clave';

  @override
  String get openpgpBackUpTitle => '¿Hacer copia de la clave secreta?';

  @override
  String get openpgpBackUpProtected =>
      'La copia de seguridad está protegida por la frase de contraseña de tu clave. Quien tenga ambas podrá leer tu correo.';

  @override
  String get openpgpBackUpUnprotected =>
      'Esta clave no tiene frase de contraseña: quien tenga la copia de seguridad podrá leer tu correo y firmar en tu nombre.';

  @override
  String get openpgpBackUp => 'Hacer copia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return '¿Eliminar tu clave $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return '¿Quitar la clave de $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'El correo cifrado para esta clave ya no se podrá leer en este dispositivo, salvo que vuelvas a importarla.';

  @override
  String get openpgpRemoveKeyMessage => 'Puedes volver a importarla más tarde.';

  @override
  String get openpgpKeyHeader => 'Clave OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Añade una clave en Cifrado de extremo a extremo para cifrar y firmar el correo de esta dirección.';

  @override
  String get openpgpGenerateAKey => 'Generar una clave…';

  @override
  String get openpgpSending => 'Envío';

  @override
  String get openpgpSendingFooter =>
      'El cifrado automático se activa cuando todos los destinatarios tienen una clave aceptada o un certificado de confianza, o cuando Autocrypt indica que ambas partes lo quieren. El correo cifrado siempre se firma.';

  @override
  String get openpgpEncryptAutomatically => 'Cifrar automáticamente';

  @override
  String get openpgpAlwaysEncryptDetail => 'No envía si algún destinatario no tiene clave';

  @override
  String get openpgpSignUnencrypted => 'Firmar el correo sin cifrar';

  @override
  String get openpgpAttachPublicKey => 'Adjuntar mi clave pública';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt envía tu clave pública con cada mensaje, para que otras apps puedan cifrarte mensajes sin configurar nada.';

  @override
  String get openpgpSendMyKey => 'Enviar mi clave con el correo';

  @override
  String get openpgpPreferEncryption => 'Preferir cifrado';

  @override
  String get openpgpPreferEncryptionDetail => 'Pedir a los demás que cifren cuando puedan';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count años', one: '1 año');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Las frases de contraseña no coinciden.';

  @override
  String openpgpKeyReady(String id) {
    return 'Tu clave $id está lista.';
  }

  @override
  String get openpgpNewKey => 'Clave nueva';

  @override
  String get openpgpNewKeyFor => 'Para';

  @override
  String get openpgpYourName => 'Tu nombre';

  @override
  String get openpgpAddress => 'Dirección';

  @override
  String get openpgpPassphrase => 'Frase de contraseña';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opcional. Sin ella, solo el llavero del teléfono protege la clave y Loupe nunca la pide. Con ella, Loupe te la pide cuando se necesita la clave.';

  @override
  String get openpgpRepeatPassphrase => 'Repetir';

  @override
  String get openpgpExpires => 'Caducidad';

  @override
  String get openpgpExpiresFooter =>
      'Puedes crear una clave nueva antes de que caduque. Thunderbird también usa tres años.';

  @override
  String get openpgpGenerateKey => 'Generar clave';

  @override
  String get openpgpKeyFor => 'Clave para';

  @override
  String get openpgpCantEncrypt => 'No se puede cifrar';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'No hay ninguna clave OpenPGP para $names y esta dirección siempre cifra. Quita el destinatario o importa su clave en Ajustes › Cifrado de extremo a extremo.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'No hay ningún certificado S/MIME válido para $names y esta dirección siempre cifra. Quita el destinatario o importa su certificado en Ajustes › Cifrado de extremo a extremo.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'No hay ninguna clave OpenPGP para $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'No hay ningún certificado S/MIME válido para $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Enviar sin cifrar';

  @override
  String get openpgpCantSign => 'No se puede firmar';

  @override
  String get openpgpCantSignMessage =>
      'La clave privada de tu certificado S/MIME no está en este dispositivo. Vuelve a importar el certificado (un archivo .p12 o .pfx) en Ajustes › Cifrado de extremo a extremo.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Sin clave para $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sin certificado para $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Claves de Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Todos tienen clave';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Todos tienen certificado';

  @override
  String get openpgpComposeEncrypt => 'Cifrar';

  @override
  String get openpgpComposeSign => 'Firmar';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, cambiar';
  }

  @override
  String get openpgpNoKeyFound => 'No se ha encontrado ninguna clave OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => '¿Importar una clave secreta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Este adjunto contiene una clave secreta ($names). Impórtala como tu propia clave solo si la exportaste tú, desde Thunderbird por ejemplo.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importar como mi clave';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'tu clave $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¿Importar $count claves ($names)?',
      one: '¿Importar la clave de $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importar y aceptar';

  @override
  String get openpgpImportDecideLater => 'Importar y decidir después';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'la clave de $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importado: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hay $count claves OpenPGP adjuntas.',
      one: 'Hay una clave OpenPGP adjunta.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importar';

  @override
  String get openpgpUnlockKeyTitle => 'Desbloquear clave OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Introduce la frase de contraseña de la clave de $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Esa frase de contraseña no es correcta. Vuelve a intentarlo.';

  @override
  String get openpgpExplainLocked => 'Este mensaje está cifrado. Desbloquea tu clave OpenPGP para leerlo.';

  @override
  String get openpgpExplainNoKey =>
      'Este mensaje está cifrado, pero no para ninguna clave OpenPGP de este dispositivo. Si lo lees en Thunderbird, importa tu clave desde allí: Ajustes › Cifrado de extremo a extremo.';

  @override
  String get openpgpExplainDamaged =>
      'Este mensaje cifrado está dañado, así que no se puede descifrar de forma segura.';

  @override
  String get openpgpExplainUnsupported => 'Este mensaje usa un cifrado que Loupe aún no puede leer.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Este mensaje está cifrado con S/MIME, pero no para ningún certificado de este dispositivo. Importa tu certificado (un archivo .p12 o .pfx) en Ajustes › Cifrado de extremo a extremo.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Este mensaje está cifrado. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Desbloquea tu certificado S/MIME para leerlo.';

  @override
  String get openpgpAttachmentGone => 'Este adjunto ya no está disponible.';

  @override
  String get smimeEncrypted => 'Cifrado (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Cifrado (S/MIME) · sin certificado';

  @override
  String get smimeEncryptedDamaged => 'Cifrado (S/MIME) · dañado';

  @override
  String get smimeEncryptedUnsupported => 'Cifrado (S/MIME) · no compatible';

  @override
  String get smimeEncryptedLocked => 'Cifrado (S/MIME) · bloqueado';

  @override
  String get smimeUnknownSigner => 'desconocido';

  @override
  String get smimeSignatureModified => 'Firma no válida: mensaje modificado';

  @override
  String get smimeSignatureWeak => 'Firma insegura: algoritmo obsoleto';

  @override
  String get smimeSignatureUncheckable => 'No se puede comprobar la firma';

  @override
  String get smimeSignedCertificateMissing => 'Firmado · falta el certificado';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Firmado por $name · certificado revocado';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Firmado por $name · en otra fecha';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Firmado por $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Firmado por $name · certificado no válido';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Firmado por $name · no es de confianza';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Firmado por $name · certificado caducado';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Firmado por $name · certificado aún no válido';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Firmado por $name · certificado no apto para correo';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Firmado por $name, no por el remitente';
  }

  @override
  String get smimeCantDecrypt => 'No se puede descifrar este mensaje';

  @override
  String get smimeEncryptedWithSmime => 'Cifrado con S/MIME';

  @override
  String get smimeEncryption => 'Cifrado';

  @override
  String get smimeDecryptedHere => 'Descifrado en este dispositivo';

  @override
  String get smimeNotDecrypted => 'Sin descifrar';

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
  String get smimeSignature => 'Firma';

  @override
  String get smimeIssuedBy => 'Emitido por';

  @override
  String get smimeValid => 'Válido';

  @override
  String smimeValidRange(String from, String to) {
    return 'Del $from al $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Huella digital SHA-256';

  @override
  String get smimeSigned => 'Firmado';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'Comprobando la revocación…';

  @override
  String get smimeNotRevoked => 'No revocado';

  @override
  String get smimeRevoked => 'Revocado';

  @override
  String get smimeRevocationUnknown => 'Revocación desconocida';

  @override
  String smimeRevokedSince(String date) {
    return 'Desde el $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Consultado a la autoridad (su lista de revocación), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Consultado a la autoridad (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Confiar en «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Confiar en este certificado…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Comprobado en este dispositivo con S/MIME, compatible con Outlook y Thunderbird; la revocación, con la autoridad de certificación.';

  @override
  String get smimeCheckedFooter =>
      'Comprobado en este dispositivo con S/MIME, compatible con Outlook y Thunderbird. La revocación no se comprueba (Ajustes › Cifrado de extremo a extremo).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return '¿Confiar en $name para el correo?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return '¿Confiar en el certificado de $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Se confiará en todos los certificados que emita esta autoridad, como la CA de tu empresa. Antes, compara la huella digital con su propietario:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Antes, compara la huella digital con su propietario:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Confiar';

  @override
  String get smimeSummaryNoKey => 'Se cifró para un certificado que no está en este dispositivo.';

  @override
  String get smimeSummaryDamaged => 'Los datos cifrados están dañados o se modificaron por el camino.';

  @override
  String get smimeSummaryUnsupported => 'Usa un algoritmo que Loupe no admite.';

  @override
  String get smimeSummaryLocked => 'Tu certificado S/MIME está bloqueado.';

  @override
  String get smimeSummaryEncrypted => 'Solo tú y los demás destinatarios podéis leerlo.';

  @override
  String get smimeSummaryNotSigned => 'No está firmado, así que el remitente no está confirmado.';

  @override
  String get smimeSummaryModified => 'La firma no coincide: el mensaje se modificó después de firmarse.';

  @override
  String get smimeSummaryUncheckable => 'No se puede comprobar la firma.';

  @override
  String get smimeSummaryNoCertificate =>
      'El certificado del firmante no está en el mensaje, así que no se puede comprobar.';

  @override
  String get smimeSummaryRevoked =>
      'La autoridad de certificación revocó el certificado del firmante: no se puede confiar en la firma.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'La autoridad de certificación revocó el certificado del firmante ($reason): no se puede confiar en la firma.';
  }

  @override
  String get smimeDateMismatch =>
      'Se firmó más de una hora antes o después de la fecha del mensaje: puede ser un mensaje antiguo enviado de nuevo.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'La firma es válida y $issuer garantiza que el certificado pertenece al remitente.';
  }

  @override
  String get smimeProblemInvalidChain => 'El certificado o uno de sus emisores no es válido.';

  @override
  String get smimeProblemUntrusted => 'El certificado procede de una autoridad en la que Loupe no confía.';

  @override
  String get smimeProblemExpired => 'El certificado había caducado.';

  @override
  String get smimeProblemNotYetValid => 'El certificado aún no era válido.';

  @override
  String get smimeProblemWrongUsage => 'El certificado no es apto para correo.';

  @override
  String get smimeProblemWrongAddress => 'El certificado pertenece a una dirección distinta de la del remitente.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'De confianza · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'No es de confianza · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Caducó el $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Válido desde el $date';
  }

  @override
  String get smimeTrustInvalid => 'No válido';

  @override
  String get smimeTrustNotForMail => 'No apto para correo';

  @override
  String get smimeTrustAnotherAddress => 'Otra dirección';

  @override
  String get smimeMyCertificates => 'Mis certificados S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Para S/MIME, como lo usan Outlook y muchas empresas. Importa tu certificado con su clave privada (un archivo .p12 o .pfx), exportado desde Outlook, Windows, macOS o Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Para S/MIME, como lo usan Outlook y muchas empresas. Importa tu certificado con su clave privada (un archivo .p12 o .pfx), exportado desde Outlook, Windows, macOS o Thunderbird, o usa uno que tu empresa o tú hayáis instalado en este dispositivo.';

  @override
  String get smimeCertificateExpired => 'caducado';

  @override
  String smimeCertificateUntil(String date) {
    return 'hasta el $date';
  }

  @override
  String get smimeCertificateOnDevice => 'en este dispositivo';

  @override
  String get smimeImportCertificateEllipsis => 'Importar certificado…';

  @override
  String get smimeUseDeviceCertificate => 'Usar un certificado de este dispositivo…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificados de tus contactos';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Recogidos del correo firmado, como hacen Outlook y Thunderbird. El correo solo se cifra para certificados de confianza: Loupe confía en las autoridades en las que Mozilla confía para el correo, y en las que tú añadas.';

  @override
  String get smimeRevocation => 'Revocación';

  @override
  String get smimeRevocationFooter =>
      'Cuando abres correo firmado, Loupe pregunta a la autoridad que emitió el certificado del firmante si lo ha revocado (a su servidor OCSP o a su lista de revocación). La autoridad puede ver entonces cuándo alguien desde tu dirección de internet lee correo firmado con ese certificado. Las respuestas se guardan en este dispositivo hasta que caducan. Un certificado revocado aparece como «certificado revocado» en la cabecera del mensaje.';

  @override
  String get smimeCheckRevocation => 'Comprobar la revocación en línea';

  @override
  String get smimeTrustedAuthorities => 'Autoridades de confianza';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'De tu confianza, además de las $count en las que Mozilla confía para el correo.',
      one: 'De tu confianza, además de la $count en la que Mozilla confía para el correo.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoridad de certificación';

  @override
  String get smimeImportACertificate => 'Importar un certificado';

  @override
  String get smimeImportContactMessage =>
      'El certificado de un contacto (.cer, .crt, .pem) o el de una autoridad de certificación.';

  @override
  String get smimeFromClipboard => 'Del portapapeles';

  @override
  String get smimeFromFile => 'De un archivo';

  @override
  String get smimeClipboardEmpty => 'El portapapeles está vacío. Copia primero el certificado.';

  @override
  String get smimeCertificate => 'Certificado';

  @override
  String get smimeOnDeviceFooter =>
      'Su clave privada se queda en el almacenamiento de credenciales de Android, donde tu empresa o tú la instalasteis: Loupe le pide a Android que firme y descifre con ella. El correo firmado se firma al enviarlo.';

  @override
  String get smimeAddresses => 'Direcciones';

  @override
  String get smimeUsage => 'Para';

  @override
  String get smimeUsageNone => 'Nada que Loupe use';

  @override
  String get smimeUsageSigning => 'Firmar';

  @override
  String get smimeUsageEncryption => 'Cifrar';

  @override
  String get smimeUsageCertificates => 'Certificados';

  @override
  String get smimeAlgorithm => 'Algoritmo';

  @override
  String get smimeSerialNumber => 'Número de serie';

  @override
  String get smimeFingerprintCopied => 'Huella digital copiada.';

  @override
  String get smimeSha1Thumbprint => 'Huella digital SHA-1';

  @override
  String get smimePrivateKey => 'Clave privada';

  @override
  String get smimeKeyOnDevice => 'En este dispositivo';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'En Loupe, con frase de contraseña';

  @override
  String get smimeKeyInLoupe => 'En Loupe';

  @override
  String get smimeSource => 'Origen';

  @override
  String get smimeSourceSignedMail => 'Correo firmado';

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
    return 'Confiar en «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Confiar en esta autoridad';

  @override
  String get smimeTrustThisCertificate => 'Confiar en este certificado';

  @override
  String get smimeStopTrusting => 'Dejar de confiar';

  @override
  String get smimePassphrase => 'Frase de contraseña';

  @override
  String get smimePassphraseFooter =>
      'Opcional. Con una frase de contraseña, la clave privada también se cifra en este dispositivo (Argon2id y AES-256) y Loupe la pide para firmar y descifrar; Recordar frases de contraseña indica durante cuánto tiempo. El correo que envías se firma al enviarlo; las tareas en segundo plano no pueden usar la clave.';

  @override
  String get smimeChangePassphrase => 'Cambiar frase de contraseña…';

  @override
  String get smimeSetPassphraseEllipsis => 'Establecer frase de contraseña…';

  @override
  String get smimeRemovePassphrase => 'Quitar frase de contraseña';

  @override
  String get smimeShareCertificate => 'Compartir certificado';

  @override
  String get smimeDeleteCertificate => 'Eliminar certificado';

  @override
  String get smimeRemoveCertificate => 'Quitar certificado';

  @override
  String get smimePassphraseChanged => 'Frase de contraseña cambiada.';

  @override
  String get smimePassphraseSet => 'Frase de contraseña establecida.';

  @override
  String get smimeRemovePassphraseTitle => '¿Quitar la frase de contraseña?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Entonces la clave privada solo estará protegida por el llavero, como sin frase de contraseña: Loupe ya no la pedirá y las tareas en segundo plano podrán usarla.';

  @override
  String get smimePassphraseRemoved => 'Frase de contraseña quitada.';

  @override
  String smimeTrustTitle(String name) {
    return '¿Confiar en $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Se confiará para el correo en todos los certificados que emita. Antes, compara la huella digital con su propietario:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return '¿Eliminar tu certificado $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return '¿Quitar el certificado de $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe dejará de usarlo: el correo cifrado para él ya no se podrá leer en Loupe. El certificado se queda en este dispositivo (Ajustes › Seguridad › Cifrado y credenciales).';

  @override
  String get smimeDeleteOwnMessage =>
      'Su clave privada se eliminará de este dispositivo: el correo cifrado para él ya no se podrá leer aquí, salvo que vuelvas a importarlo.';

  @override
  String get smimeRemoveContactMessage => 'Volverá con su próximo mensaje firmado.';

  @override
  String get smimeAddressImportFooter =>
      'Importa un certificado para esta dirección para firmar y cifrar con S/MIME, como hace Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importar un certificado…';

  @override
  String get smimePreferFooter =>
      'Cuando ambos pueden proteger un mensaje, se usa el preferido, salvo que solo el otro tenga una clave o un certificado para todos los destinatarios.';

  @override
  String get smimePreferSmime => 'Preferir S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Antes que OpenPGP';

  @override
  String get smimeCertificatePassword => 'Contraseña del certificado';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Introduce la contraseña con la que se exportó el archivo del certificado.';

  @override
  String get smimeImport => 'Importar';

  @override
  String get smimeWrongPassword => 'Esa contraseña no es correcta. Vuelve a intentarlo.';

  @override
  String get smimeNoCertificateFound => 'No se ha encontrado ningún certificado.';

  @override
  String smimeCertificateOf(String name) {
    return 'el certificado de $name';
  }

  @override
  String get smimeNothingNew => 'No hay nada nuevo que importar.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importado: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se han importado $count autoridades de confianza.',
      one: 'Se ha importado una autoridad de confianza.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importado: $certificates y $count autoridades de confianza.',
      one: 'Importado: $certificates y una autoridad de confianza.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Este archivo no tiene clave privada. Exporta tu certificado con su clave privada.';

  @override
  String get smimeImportAsYoursTitle => '¿Importar como tu certificado?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Este adjunto contiene un certificado con su clave privada: $names. Impórtalo solo si lo exportaste tú, desde Outlook o Thunderbird por ejemplo.';
  }

  @override
  String get smimeImportAsMine => 'Importar como mi certificado';

  @override
  String smimeImportedOwn(String names) {
    return 'Se ha importado tu certificado $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Se ha añadido tu certificado $name ($addresses) desde este dispositivo.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return '¿Confiar en «$name» para el correo?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe no conoce esta autoridad de certificación (quizá sea la de una empresa). Confía en ella para comprobar los certificados que emite. Antes, compara su huella digital con tu departamento de informática:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hay $count certificados adjuntos.',
      one: 'Hay un certificado adjunto.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importar certificado';

  @override
  String get smimeUnlockTitle => 'Desbloquear certificado S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Introduce la frase de contraseña del certificado de $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Esa frase de contraseña no es correcta. Vuelve a intentarlo.';

  @override
  String get smimeUnlock => 'Desbloquear';

  @override
  String get smimeEnterAPassphrase => 'Introduce una frase de contraseña.';

  @override
  String get smimePassphrasesDiffer => 'Las dos frases de contraseña no coinciden.';

  @override
  String get smimeSetPassphraseTitle => 'Establecer frase de contraseña';

  @override
  String get smimeSetPassphraseText =>
      'Loupe la pedirá para firmar y descifrar. Si la olvidas, vuelve a importar el certificado desde su archivo .p12.';

  @override
  String get smimePassphraseAgain => 'Otra vez';

  @override
  String get smimeSetPassphraseButton => 'Establecer';

  @override
  String get smimeLockedOpenAgain =>
      'Tu certificado S/MIME está bloqueado. Vuelve a abrir el mensaje para desbloquearlo.';

  @override
  String get smimeDeviceHasNoCertificates => 'Este dispositivo no ofrece sus certificados.';

  @override
  String get smimeCantReadCertificate => 'Loupe no puede leer este certificado.';

  @override
  String get smimeCertificateNotForMail =>
      'Este certificado no es para correo: no tiene dirección de correo o no está pensado para firmar ni cifrar.';

  @override
  String get smimeDeviceCertificateGone =>
      'El certificado ya no está en este dispositivo, o puede que Loupe ya no pueda usarlo. Vuelve a elegirlo en Ajustes › Cifrado de extremo a extremo.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'El certificado de este dispositivo solo se puede usar mientras Loupe está abierta.';

  @override
  String get smimeDeviceKeyDamaged => 'La clave cifrada está dañada.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'El certificado de este dispositivo no puede hacer esto: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'no compatible';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'El certificado de este dispositivo ha fallado: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'La dirección de la autoridad no es una dirección web.';

  @override
  String get smimeAuthorityTimeout => 'La autoridad de certificación no ha respondido a tiempo.';

  @override
  String get smimeAuthorityUnreachable => 'No se ha podido contactar con la autoridad de certificación.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'La autoridad de certificación ha respondido $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'La respuesta de la autoridad de certificación es demasiado grande.';

  @override
  String get smimeRevocationNotChecked =>
      'No comprobado: solo se comprueban los certificados de autoridades en las que Loupe confía.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'El mismo que el teléfono';

  @override
  String get settingsLanguageFooter =>
      'Loupe usa el idioma de tu teléfono si lo tiene, y el inglés si no. El idioma que elijas aquí es solo para Loupe, notificaciones incluidas.';

  @override
  String get settingsAccountsHeader => 'Cuentas';

  @override
  String get settingsAddAccount => 'Añadir cuenta';

  @override
  String get settingsMailHeader => 'Correo';

  @override
  String get settingsSwipeActions => 'Acciones al deslizar';

  @override
  String get settingsSwipeLeft => 'Deslizar a la izquierda';

  @override
  String get settingsSwipeLeftFooter =>
      'Al deslizar hasta el final se ejecuta esta acción. Marcar con bandera y Más están siempre a un deslizamiento corto.';

  @override
  String get settingsSwipeRight => 'Deslizar a la derecha';

  @override
  String get settingsSwipeRightFooter => 'Al deslizar hasta el final se ejecuta esta acción.';

  @override
  String get settingsSwipeToggleRead => 'Marcar como leído / no leído';

  @override
  String get settingsSwipeTrash => 'Papelera';

  @override
  String get settingsSwipeMove => 'Mover mensaje';

  @override
  String get settingsSwipeSnooze => 'Posponer';

  @override
  String get settingsThreaded => 'Agrupar por conversación';

  @override
  String get settingsUndoSendDelay => 'Tiempo para deshacer el envío';

  @override
  String get settingsUndoSendDelayFooter => 'Los mensajes enviados esperan este tiempo, para que puedas recuperarlos.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Apariencia';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automático';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsDensity => 'Lista de mensajes';

  @override
  String get settingsDensityComfortable => 'Amplia';

  @override
  String get settingsDensityCompact => 'Compacta';

  @override
  String get settingsReadingHeader => 'Lectura';

  @override
  String get settingsReadingFooter =>
      'Las imágenes remotas pueden decir a los remitentes cuándo y dónde abriste un mensaje.';

  @override
  String get settingsDefaultView => 'Vista predeterminada';

  @override
  String get settingsDefaultViewFooter => 'Puedes cambiar la vista de cualquier mensaje con el botón Aa.';

  @override
  String get settingsViewReadable => 'Legible';

  @override
  String get settingsViewReadableDetail => 'Limpia, legible y sigue el modo oscuro';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Tal como lo diseñó el remitente';

  @override
  String get settingsViewPlain => 'Texto sin formato';

  @override
  String get settingsViewPlainDetail => 'Solo las palabras';

  @override
  String get settingsPlainTextFont => 'Fuente del texto sin formato';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monoespaciada';

  @override
  String get settingsFontMonoDetail => 'Mantiene alineados el arte ASCII y las tablas';

  @override
  String get settingsTechnicalLists => 'Listas técnicas';

  @override
  String get settingsLoadRemoteImages => 'Cargar imágenes remotas';

  @override
  String get settingsOpenLinksDirectly => 'Abrir enlaces directamente';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Saltarse los rastreadores de clics cuando se conoce el destino';

  @override
  String get settingsSecurityHeader => 'Seguridad';

  @override
  String get settingsAppLock => 'Bloqueo de la app';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe lo pide al iniciarse y cuando vuelves tras estar fuera el tiempo de Bloquear después de.';

  @override
  String get settingsAppLockFooterOff =>
      'El bloqueo de la app pide tu huella dactilar, tu cara o el bloqueo de pantalla antes de mostrar tu correo.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'El bloqueo de la app sigue desactivado. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configura un código';

  @override
  String get settingsScreenLockTextIos =>
      'El bloqueo de la app usa Face ID, Touch ID o tu código, y este iPhone no tiene código. Configura uno en la app Ajustes y luego activa el bloqueo de la app.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configura un bloqueo de pantalla';

  @override
  String get settingsScreenLockTextAndroid =>
      'El bloqueo de la app usa el bloqueo de pantalla del teléfono, o una huella dactilar o una cara añadidas a él, y este teléfono no tiene ninguno. Configura un PIN, un patrón o una contraseña en los ajustes de Android y luego activa el bloqueo de la app.';

  @override
  String get settingsOpenSystemSettings => 'Abrir Ajustes';

  @override
  String get settingsOpenAndroidSettings => 'Abrir los ajustes de Android';

  @override
  String get settingsLockAfter => 'Bloquear después de';

  @override
  String get settingsLockAfterFooter => 'Cuánto tiempo puede estar Loupe en segundo plano antes de volver a pedirlo.';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsEncryption => 'Cifrado de extremo a extremo';

  @override
  String get settingsAdvanced => 'Avanzado';

  @override
  String get settingsDemoHeader => 'Demostración';

  @override
  String get settingsDemoFooter =>
      'El correo de demostración es un buzón inventado que solo existe en este teléfono. No se envía nada a ningún sitio.';

  @override
  String get settingsDemoMode => 'Modo de demostración';

  @override
  String get settingsResetApp => 'Restablecer la app';

  @override
  String get settingsResetFooter => 'Olvida todos los ajustes y vuelve a la pantalla de bienvenida.';

  @override
  String get settingsResetTitle => '¿Restablecer Loupe?';

  @override
  String get settingsResetMessage =>
      'Se olvidarán todos los ajustes, los Smart Mailboxes y las búsquedas recientes, y se volverá a la pantalla de bienvenida.';

  @override
  String get settingsAboutHeader => 'Información';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsLicences => 'Licencias';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsPrivacyDetail =>
      'Loupe no tiene analíticas ni rastreo. Tu correo solo va a tus servidores de correo.';

  @override
  String get settingsNotificationsOffIos => 'Las notificaciones de Loupe están desactivadas en Ajustes.';

  @override
  String get settingsNotificationsOffAndroid =>
      'Las notificaciones de Loupe están desactivadas en los ajustes de Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system no permite que Loupe muestre notificaciones. Permítelas en los ajustes.';
  }

  @override
  String get settingsNewMailHeader => 'Correo nuevo';

  @override
  String get settingsNewMailFooterDemo =>
      'El correo de demostración no llega en segundo plano. Envía una notificación de prueba para ver cómo se ve el correo nuevo.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe busca correo nuevo en segundo plano cuando iOS se lo permite, lo que puede tardar horas en las apps que no abres a menudo. Se te avisa de los mensajes nuevos en tus bandejas de entrada y de los de tus VIP en cualquier carpeta.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe busca correo nuevo cada 15 minutos aproximadamente, cuando Android lo permite. Se te avisa de los mensajes nuevos en tus bandejas de entrada y de los de tus VIP en cualquier carpeta.';

  @override
  String get settingsNoAccounts => 'No hay cuentas';

  @override
  String get settingsVipOnly => 'Solo VIP';

  @override
  String get settingsVipOnlyDetail => 'Solo los mensajes de tus VIP';

  @override
  String get settingsHideContent => 'Ocultar contenido';

  @override
  String get settingsHideContentFooterOn =>
      'Las notificaciones solo dicen «Mensaje nuevo de» y la cuenta, no quién lo ha escrito ni de qué trata.';

  @override
  String get settingsHideContentFooterOff =>
      'Ocultar contenido mantiene el remitente, el asunto y la vista previa fuera de la pantalla de bloqueo y de las notificaciones.';

  @override
  String get settingsBackgroundAppRefresh => 'Actualización en segundo plano';

  @override
  String get settingsBackgroundRefreshFooter =>
      'El correo nuevo solo llega en segundo plano si la actualización en segundo plano está activada para Loupe en Ajustes. iOS no puede mantener abierta una conexión con tus bandejas de entrada, así que no hay entrega instantánea.';

  @override
  String get settingsInstantDelivery => 'Entrega instantánea';

  @override
  String get settingsInstantDeliveryFooter =>
      'La entrega instantánea (experimental) mantiene abierta una conexión con tus bandejas de entrada para que el correo nuevo llegue en segundos. Muestra una notificación discreta, «Atento al correo nuevo», y consume más batería.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android puede detener la entrega instantánea para ahorrar batería. Permite que Loupe use la batería sin restricciones para que siga funcionando.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'Próximamente';

  @override
  String get settingsAllowUnrestrictedBattery => 'Permitir uso de batería sin restricciones';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'El push permite que el correo nuevo despierte Loupe al instante, si tu servicio de correo lo admite. Los avisos push pasan por el servicio push de Google y no llevan correo, solo «comprueba ahora».';

  @override
  String get settingsPushUnavailableFooter =>
      'Este teléfono no puede recibir avisos push: necesitan los servicios de Google Play y una conexión de red. Loupe sigue buscando correo nuevo cada 15 minutos aproximadamente.';

  @override
  String get settingsCopyPushToken => 'Copiar token de push';

  @override
  String get settingsPushTokenCopied => 'Token de push copiado';

  @override
  String get settingsSendTestNotification => 'Enviar notificación de prueba';

  @override
  String get settingsAppIconBadge => 'Globo en el icono de la app';

  @override
  String get settingsBadgeNote => 'El globo se actualiza cada vez que Loupe busca correo, también en segundo plano.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'La pantalla de inicio de este teléfono no muestra números en los iconos de las apps. El globo se actualiza cada vez que Loupe busca correo, también en segundo plano.';

  @override
  String get settingsTestNotificationBody => 'Así se ven las notificaciones de correo nuevo.';

  @override
  String get settingsAccountRemoved => 'Esta cuenta se ha quitado.';

  @override
  String get settingsAccountHeader => 'Cuenta';

  @override
  String get settingsAccountDescription => 'Descripción';

  @override
  String get settingsAccountDescriptionHint => 'Trabajo, Personal…';

  @override
  String get settingsEmail => 'Correo electrónico';

  @override
  String get settingsColour => 'Color';

  @override
  String get settingsColourFooter => 'Marca los mensajes de esta cuenta en Todas las bandejas de entrada.';

  @override
  String settingsColourNumber(int number) {
    return 'Color $number';
  }

  @override
  String get settingsSendingHeader => 'Envío';

  @override
  String get settingsSendingFooter =>
      'Cada identidad tiene su propia firma. Las respuestas salen desde la dirección a la que se envió el mensaje.';

  @override
  String get settingsFoldersHeader => 'Carpetas';

  @override
  String get settingsFoldersFooter =>
      'Loupe muestra y sincroniza las carpetas a las que te suscribes, como Thunderbird. Bandeja de entrada, Borradores, Enviados, Correo no deseado, Papelera y Archivo siempre se muestran.';

  @override
  String get settingsShowAllFolders => 'Mostrar todas las carpetas';

  @override
  String get settingsIncoming => 'Entrante';

  @override
  String get settingsOutgoing => 'Saliente';

  @override
  String get settingsConnectionNotEncrypted => 'Sin cifrar';

  @override
  String get settingsSignIn => 'Inicio de sesión';

  @override
  String get settingsSignInExpired => 'Caducado';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider ya no acepta el inicio de sesión de Loupe para esta cuenta, así que su correo no se está sincronizando. Vuelve a iniciar sesión para solucionarlo.';
  }

  @override
  String get settingsSignInAgain => 'Volver a iniciar sesión';

  @override
  String get settingsSigningIn => 'Iniciando sesión…';

  @override
  String get settingsRemoveAccount => 'Quitar cuenta';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '¿Quitar «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Su correo y sus ajustes se quitarán de este teléfono. No se elimina nada en el servidor.';

  @override
  String get settingsManageFolders => 'Gestionar carpetas';

  @override
  String get settingsNoFolders => 'Aún no hay carpetas.';

  @override
  String get settingsManageFoldersFooter =>
      'Las carpetas suscritas se muestran en la pantalla Buzones y se sincronizan en segundo plano. Otras apps de correo con la misma cuenta suelen seguir también estas suscripciones.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Guarda tus Smart Mailboxes para tus otros dispositivos. Oculta en la pantalla Buzones.';

  @override
  String get settingsFolderAlwaysShown => 'Siempre visible';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Suscribirse a $folder';
  }

  @override
  String get settingsIdentities => 'Identidades';

  @override
  String get settingsIdentitiesFooterReorder =>
      'La primera identidad es la predeterminada para los mensajes nuevos. Arrastra para cambiar el orden.';

  @override
  String get settingsIdentitiesFooterSingle => 'La identidad predeterminada para los mensajes nuevos.';

  @override
  String get settingsIdentitiesReplyFooter => 'Las respuestas salen desde la identidad a la que se envió el mensaje.';

  @override
  String get settingsIdentityDefault => 'Predeterminada';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reordenar $email';
  }

  @override
  String get settingsAddIdentity => 'Añadir identidad';

  @override
  String get settingsNewIdentity => 'Identidad nueva';

  @override
  String get settingsIdentity => 'Identidad';

  @override
  String get settingsIdentityNameHint => 'Tu nombre';

  @override
  String get settingsReplyTo => 'Responder a';

  @override
  String get settingsSignature => 'Firma';

  @override
  String get settingsSignatureFooter => 'Se añade debajo de «-- » en los mensajes de esta identidad.';

  @override
  String get settingsNoSignature => 'Sin firma';

  @override
  String get settingsCopyToMyself => 'Copia para mí';

  @override
  String get settingsCopyToMyselfFooter => 'Se añade a todos los mensajes de esta identidad.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Cco';

  @override
  String get settingsReplyPatterns => 'Usar para responder a';

  @override
  String get settingsReplyPatternsFooter =>
      'Las respuestas a los mensajes enviados a estas direcciones salen desde esta identidad. * equivale a cualquier cosa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Una dirección, o un patrón en el que * equivale a cualquier cosa.';

  @override
  String get settingsAddReplyPattern => 'Añadir dirección o patrón';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Quitar $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Patrón no válido';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» no es una dirección ni un patrón como *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Sin dirección';

  @override
  String get settingsIdentityNoAddressMessage => 'Introduce la dirección de correo desde la que enviar.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Dirección no válida';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '«$address» en Responder a no es una dirección de correo válida.',
      'cc': '«$address» en Cc no es una dirección de correo válida.',
      'bcc': '«$address» en Cco no es una dirección de correo válida.',
      'other': '«$address» no es una dirección de correo válida.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Guardar identidad';

  @override
  String get settingsDiscardChanges => 'Descartar cambios';

  @override
  String get settingsDeleteIdentity => 'Eliminar identidad';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '¿Eliminar «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Los mensajes ya enviados desde ella se quedan como están.';

  @override
  String get settingsLastIdentityFooter => 'Una cuenta necesita al menos una identidad.';

  @override
  String get rulesTitle => 'Reglas';

  @override
  String get rulesNewRule => 'Regla nueva';

  @override
  String get rulesLoadError => 'No se han podido cargar las reglas.';

  @override
  String get rulesEmptyTitle => 'No hay reglas';

  @override
  String get rulesEmptyText =>
      'Las reglas archivan, etiquetan y marcan con bandera el correo nuevo por ti. Crea una con el botón de redactar de arriba, o a partir de una búsqueda con «Convertir en regla».';

  @override
  String get rulesListFooter =>
      'Las reglas se ejecutan de arriba abajo sobre el correo nuevo de la bandeja de entrada. Mantén pulsada una regla para moverla.';

  @override
  String get rulesChangeError => 'No se ha podido cambiar la regla';

  @override
  String get rulesConditionEveryMessage => 'Todos los mensajes';

  @override
  String rulesMoveRule(String rule) {
    return 'Mover $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule activada';
  }

  @override
  String get rulesServerRulesHeader => 'Reglas del servidor';

  @override
  String get rulesServerRulesFooter =>
      'Las reglas del servidor se ejecutan en el servidor de correo a medida que llega el correo, también con este teléfono apagado. Se guardan en un script Sieve llamado «loupe».';

  @override
  String get rulesStatusUnknown => 'Desconocido';

  @override
  String get rulesStatusError => 'No se ha podido consultar al servidor.';

  @override
  String get rulesStatusChecking => 'Comprobando…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Se ejecutan desde «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» es el script activo. Toca para que también ejecute las reglas de Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'No hay ningún script activo en el servidor. Al guardar una regla del servidor se activa el de Loupe.';

  @override
  String get rulesStatusUnavailable => 'No disponible';

  @override
  String get rulesStatusNoSieve => 'El servidor de esta cuenta no ofrece Sieve (ManageSieve ni JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mover a $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mover a una carpeta';

  @override
  String rulesActionTag(String tag) {
    return 'Etiquetar como $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Quitar la etiqueta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Dejar en la bandeja de entrada';

  @override
  String rulesActionForward(String address) {
    return 'Reenviar a $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Reenviar a $address, sin guardar copia';
  }

  @override
  String get rulesActionStop => 'Parar';

  @override
  String get rulesNoActions => 'Aún no hace nada';

  @override
  String get rulesLocationDevice => 'Dispositivo';

  @override
  String get rulesLocationServer => 'Servidor';

  @override
  String get rulesLocationThisDevice => 'Este dispositivo';

  @override
  String get rulesNewRuleTitle => 'Regla nueva';

  @override
  String get rulesEditRuleTitle => 'Editar regla';

  @override
  String get rulesDefaultNameEveryMessage => 'Todos los mensajes';

  @override
  String get rulesConditionHeader => 'Cuando un mensaje nuevo coincida con';

  @override
  String get rulesConditionFooter =>
      'Escríbela como si buscaras: from:, to:, s: (asunto), b: (cuerpo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:factura';

  @override
  String get rulesAccounts => 'Cuentas';

  @override
  String get rulesAllAccounts => 'Todas las cuentas';

  @override
  String get rulesRemovedAccount => 'Cuenta quitada';

  @override
  String get rulesAccountsFooter =>
      'Una regla para todas las cuentas también se aplica a las cuentas que añadas más adelante.';

  @override
  String get rulesActionsHeader => 'Entonces';

  @override
  String get rulesForwardingFooter =>
      'El reenvío manda cada mensaje que coincide a otra dirección en cuanto llega, también con este teléfono apagado. Algunos proveedores limitan cuánto correo se puede reenviar.';

  @override
  String get rulesForwardingHiddenFooter =>
      'El reenvío solo funciona en las reglas del servidor, así que aquí no aparece.';

  @override
  String rulesRemoveAction(String action) {
    return 'Quitar $action';
  }

  @override
  String get rulesAddAction => 'Añadir acción';

  @override
  String get rulesAddMove => 'Mover a una carpeta…';

  @override
  String get rulesAddTagMenu => 'Añadir etiqueta…';

  @override
  String get rulesRemoveTagMenu => 'Quitar etiqueta…';

  @override
  String get rulesAddForward => 'Reenviar a…';

  @override
  String get rulesStopProcessing => 'No procesar más reglas';

  @override
  String get rulesRunOnHeader => 'Ejecutar en';

  @override
  String get rulesRunOnDeviceFooter =>
      'Este dispositivo ejecuta la regla sobre el correo nuevo de la bandeja de entrada cada vez que Loupe busca correo.';

  @override
  String get rulesRunOnServerFooter =>
      'El servidor de correo ejecuta la regla a medida que llega el correo, también con este teléfono apagado. Necesita Sieve, mediante ManageSieve (Dovecot, mailcow) o JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Aplicar a los mensajes existentes…';

  @override
  String get rulesDeleteRule => 'Eliminar regla';

  @override
  String rulesDeleteTitle(String rule) {
    return '¿Eliminar «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => '¿Carpeta de qué cuenta?';

  @override
  String get rulesMoveAccountMessage =>
      'El correo de las demás cuentas va a la carpeta con el mismo nombre en cada una.';

  @override
  String get rulesAddTag => 'Añadir etiqueta';

  @override
  String get rulesRemoveTag => 'Quitar etiqueta';

  @override
  String get rulesForwardTo => 'Reenviar a';

  @override
  String get rulesForwardToMessage =>
      'El servidor reenvía cada mensaje que coincide a esta dirección, también con este teléfono apagado. Usa una dirección tuya o de confianza.';

  @override
  String get rulesNotAnAddressTitle => 'No es una dirección de correo';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» no es una dirección a la que se pueda reenviar.';
  }

  @override
  String get rulesKeepCopyTitle => '¿Guardar una copia aquí?';

  @override
  String get rulesKeepCopy => 'Guardar una copia';

  @override
  String get rulesDontKeepCopy => 'No guardar copia';

  @override
  String get rulesCheckCondition => 'Revisa la condición';

  @override
  String get rulesChooseActionTitle => 'Elige una acción';

  @override
  String get rulesChooseActionMessage => 'Añade lo que la regla hace con los mensajes que coinciden.';

  @override
  String get rulesSaveError => 'No se ha podido guardar la regla';

  @override
  String get rulesSaveServerError => 'No se ha podido guardar la regla del servidor';

  @override
  String get rulesRunOnDeviceInstead => 'Ejecutar en este dispositivo';

  @override
  String get rulesNothingToApplyTitle => 'Nada que aplicar';

  @override
  String get rulesNothingToApplyMessage => 'Dale antes a la regla una condición que funcione y una acción.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplicar «$rule» a los mensajes de…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Bandejas de entrada';

  @override
  String get rulesApplyScopeAll => 'Todos los buzones';

  @override
  String get rulesFindingMessages => 'Buscando mensajes…';

  @override
  String get rulesSearchError => 'No se ha podido buscar';

  @override
  String get rulesSearchErrorUnknown => 'Algo ha fallado.';

  @override
  String get rulesNoMatchesTitle => 'Ningún mensaje coincide';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nada coincide con «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¿Aplicar «$rule» a $countString mensajes?',
      one: '¿Aplicar «$rule» a $countString mensaje?',
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
      other: 'Aplicar a $countString mensajes',
      one: 'Aplicar a $countString mensaje',
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
      other: 'Se ha aplicado «$rule» a $countString mensajes',
      one: 'Se ha aplicado «$rule» a $countString mensaje',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Preguntando al servidor qué puede hacer…';

  @override
  String get rulesServerUnreachable => 'No se ha podido conectar con el servidor.';

  @override
  String rulesServerProblem(String problem) {
    return 'No se puede ejecutar en el servidor: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'No se puede ejecutar en el servidor de $account: $problem';
  }

  @override
  String get rulesShowScript => 'Mostrar script';

  @override
  String get rulesHideScript => 'Ocultar script';

  @override
  String get rulesMatchingHeader => 'Mensajes que coinciden';

  @override
  String get rulesMatchingHeaderLoading => 'Mensajes que coinciden…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString mensajes coinciden',
      one: '$countString mensaje coincide',
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
      other: 'Más de $countString mensajes coinciden',
      one: 'Más de $countString mensaje coincide',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'De los últimos 30 días. La regla en sí solo actúa sobre el correo nuevo, salvo que la apliques a los mensajes existentes.';

  @override
  String rulesConditionError(String error) {
    return 'La condición tiene un error: $error';
  }

  @override
  String get rulesPreviewNoSender => '(sin remitente)';

  @override
  String get rulesPreviewNoSubject => '(sin asunto)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'y $countString más',
      one: 'y $countString más',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nada de los últimos 30 días.';

  @override
  String get rulesIncludeTitle => 'Activar las reglas del servidor';

  @override
  String get rulesIncludeLeaveOff => 'Dejar desactivadas';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'El servidor ya ejecuta las reglas de Loupe para $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» es el script activo en el servidor de $account, así que el servidor lo ejecuta a él y no las reglas de Loupe. Loupe no lo sustituirá. Puede añadirle estas líneas, y entonces el servidor ejecutará las reglas de Loupe después de las del propio script:';
  }

  @override
  String get rulesShowWholeScript => 'Mostrar el script completo';

  @override
  String get rulesHideWholeScript => 'Ocultar el script completo';

  @override
  String rulesIncludeFootnote(String script) {
    return 'No cambia nada más en «$script». Si más adelante se editan sus filtros en el webmail, puede que este lo reescriba sin estas líneas; Loupe mostrará entonces de nuevo las reglas del servidor como desactivadas.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Añadir a «$script»';
  }

  @override
  String get subscriptionsTitle => 'Suscripciones';

  @override
  String get subscriptionsNewsletters => 'Newsletters';

  @override
  String get subscriptionsDiscussions => 'Debates';

  @override
  String get subscriptionsFilter => 'Filtrar';

  @override
  String get subscriptionsFilterNeverRead => 'Nunca leídas';

  @override
  String get subscriptionsFilterRarelyRead => 'Poco leídas';

  @override
  String get subscriptionsFilterAll => 'Todas';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'No se han podido contar las suscripciones';

  @override
  String get subscriptionsNoMatches => 'Sin coincidencias';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ninguna newsletter se llama «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ninguna lista se llama «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'No hay newsletters';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Las newsletters y el resto del correo masivo aparecen aquí en cuanto llegan.';

  @override
  String get subscriptionsNothingNeverRead => 'Nada sin leer nunca';

  @override
  String get subscriptionsNothingRarelyRead => 'Nada poco leído';

  @override
  String get subscriptionsNothingFilteredDetail => 'Lees algo de todo lo que recibes.';

  @override
  String get subscriptionsNoDiscussions => 'No hay debates';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Las listas de correo en las que puedes escribir aparecen aquí en cuanto llega su correo.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listas en las que escriben varias personas. Mantén pulsada una para fijarla en Buzones, leerla como texto sin formato o moverla a Newsletters.';

  @override
  String get subscriptionsPrivacyNote =>
      'Se calcula en este teléfono a partir del correo descargado; no se envía nada a ningún sitio para ello. Loupe solo contacta con un remitente cuando tocas Darse de baja: la baja en un clic envía únicamente «List-Unsubscribe=One-Click» a la dirección que indicó el remitente, sin cookies ni nada más sobre ti, y nunca carga sus páginas ni sus imágenes.';

  @override
  String get subscriptionsVolumeNone => 'Nada últimamente';

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
    return 'leído $percent';
  }

  @override
  String get subscriptionsStillSending => 'Sigue enviando';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Baja el $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Página de baja abierta el $date';
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
    return 'En el sitio web $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Darse de baja';

  @override
  String get subscriptionsUnsubscribeAgain => 'Volver a darse de baja';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivar $countString de la bandeja de entrada',
      one: 'Archivar $countString de la bandeja de entrada',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Crear regla…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mover o archivar su correo futuro';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratar como debate';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Una lista en la que escribe la gente: léela como un foro';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratar como newsletter';

  @override
  String get subscriptionsBlockSender => 'Bloquear remitente';

  @override
  String get subscriptionsBlock => 'Bloquear';

  @override
  String get subscriptionsBlocked => 'Bloqueado';

  @override
  String get subscriptionsBlockedDetail => 'El correo nuevo va a correo no deseado';

  @override
  String get subscriptionsPin => 'Fijar en Buzones';

  @override
  String get subscriptionsUnpin => 'Dejar de fijar en Buzones';

  @override
  String get subscriptionsOpenDefaultView => 'Abrir en la vista predeterminada';

  @override
  String get subscriptionsOpenPlainText => 'Abrir como texto sin formato (Mono)';

  @override
  String get subscriptionsPinned => 'Fijada';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString sin leer',
      one: '$countString sin leer',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Ahora no hay correo de este remitente.';

  @override
  String get subscriptionsLatestMessages => 'ÚLTIMOS MENSAJES';

  @override
  String get subscriptionsMail => 'Correo';

  @override
  String get subscriptionsNoneIn90Days => 'Ninguno en 90 días';

  @override
  String get subscriptionsRead => 'Leído';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString de $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Último recibido';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Carpetas', one: 'Carpeta');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Sigue enviando';

  @override
  String get subscriptionsUnsubscribedTitle => 'Baja';

  @override
  String subscriptionsSince(String date) {
    return 'desde el $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'página abierta el $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender no indica cómo darse de baja.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender no indica cómo darse de baja. Puedes bloquearlo en su lugar.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Dándote de baja de $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Te has dado de baja de $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'No se ha podido dar de baja: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'No se ha podido dar de baja automáticamente';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Enviar correo de baja';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Abrir $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '¿Abrir $site?';
  }

  @override
  String get subscriptionsOpen => 'Abrir';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender gestiona las bajas en su sitio web. La página se abre en el navegador de Loupe; termina allí.';
  }

  @override
  String get subscriptionsWebInsecure => 'La conexión con este sitio no está cifrada.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Cuidado: esta dirección imita a $site con letras que parecen otras.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Cuidado: esta dirección imita a otro sitio con letras que parecen otras.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'No se ha podido abrir $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe anota la fecha de hoy y te avisará si $sender sigue escribiendo.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return '¿Darse de baja de $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe contactará con $site para darte de baja.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Es la única vez que Loupe contacta con el sitio web de un remitente. Solo envía «List-Unsubscribe=One-Click» a la dirección que indicó $sender, sin cookies ni nada más sobre ti, y no carga la página.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'El enlace para darse de baja no es una dirección segura de internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site no ha respondido a tiempo.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'No se ha podido contactar con $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site ha redirigido la petición a otra página, y Loupe no sigue redirecciones.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site ha rechazado la petición (error $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'No hay ninguna cuenta desde la que enviar el correo de baja.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe enviará un correo a $to desde $from, con el asunto «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Correo de baja enviado a $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '¿Bloquear a $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'El correo nuevo de esta lista irá a correo no deseado. Puedes cambiarlo en Ajustes › Reglas.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'El correo nuevo de $address irá a correo no deseado. Puedes cambiarlo en Ajustes › Reglas.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Se ha bloqueado a $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mover $count a no deseado',
      one: 'Mover $count a no deseado',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloquear a $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender está ahora en Newsletters.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender está ahora en Debates.';
  }

  @override
  String get appLiveGateTitle => 'No se han podido abrir tus cuentas';

  @override
  String get appLiveGateUnavailableBuild => 'Las cuentas reales aún no están disponibles en esta versión.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe no ha podido leer la clave que protege tu correo en este teléfono. Suele ser algo temporal: vuelve a intentarlo o reinicia el teléfono.';

  @override
  String get appLiveGateKeyMissing =>
      'La clave que protege tu correo en este teléfono ha desaparecido, algo que puede pasar tras restaurar una copia de seguridad. Tu correo sigue en el servidor.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'No se puede leer la base de datos del correo de este teléfono: está dañada o su clave ha cambiado. Tu correo sigue en el servidor.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Algo ha fallado al abrir tus cuentas ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Se eliminarán tus cuentas y el correo guardado en este teléfono, incluidos los mensajes que esperan en la bandeja de salida. El correo de tus servidores no se ve afectado; después vuelve a añadir tus cuentas.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Eliminar y empezar de nuevo';

  @override
  String get appLiveGateUseDemo => 'Usar el correo de demostración';

  @override
  String get appLiveGateReset => 'Restablecer el correo de este teléfono…';

  @override
  String get attachmentsUntitled => 'Adjunto';

  @override
  String get attachmentsUntitledFile => 'Sin título';

  @override
  String get attachmentsOpenIn => 'Abrir en…';

  @override
  String get attachmentsSaveToFiles => 'Guardar en Archivos';

  @override
  String get attachmentsShareMenu => 'Compartir…';

  @override
  String get attachmentsDownloadError =>
      'No se ha podido descargar el adjunto. Comprueba la conexión y vuelve a intentarlo.';

  @override
  String get attachmentsShareError => 'No se ha podido compartir el adjunto.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ninguna app de este dispositivo abre este archivo ($type). Prueba con Compartir.';
  }

  @override
  String get attachmentsOpenInError => 'No se ha podido abrir el adjunto en otra app.';

  @override
  String attachmentsSaved(String name) {
    return 'Se ha guardado «$name»';
  }

  @override
  String get attachmentsSaveError => 'No se ha podido guardar el adjunto.';

  @override
  String get attachmentsGone => 'Este adjunto ya no está disponible.';

  @override
  String get attachmentsDownloadFailed => 'No se ha podido descargar el adjunto.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count páginas', one: '1 página');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size con datos móviles';
  }

  @override
  String get attachmentsLargeDownload => 'Este adjunto es grande. Descárgalo ahora o más tarde con wifi.';

  @override
  String get attachmentsDownload => 'Descargar';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Descargando $size…';
  }

  @override
  String get attachmentsDownloading => 'Descargando…';

  @override
  String get attachmentsTooLarge => 'Demasiado grande para la vista previa.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Se muestran los primeros $shown de $total. Cópialo, compártelo o guárdalo para obtenerlo entero.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Este PDF no se puede mostrar aquí (puede que esté protegido con contraseña).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page de $count';
  }

  @override
  String get attachmentsModeTable => 'Tabla';

  @override
  String get attachmentsModeText => 'Texto';

  @override
  String get attachmentsModeMessage => 'Mensaje';

  @override
  String get attachmentsModeSource => 'Código fuente';

  @override
  String get attachmentsDontWrap => 'No ajustar líneas';

  @override
  String get attachmentsWrap => 'Ajustar líneas';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines líneas', one: '$lines línea');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copiar todo';

  @override
  String get attachmentsCopied => 'Copiado';

  @override
  String get attachmentsImageUnavailable => 'Esta imagen no se puede mostrar aquí. Prueba con Abrir en….';

  @override
  String get attachmentsEmlNoSubject => '(Sin asunto)';

  @override
  String get attachmentsEmlFrom => 'De';

  @override
  String get attachmentsEmlTo => 'Para';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Fecha';

  @override
  String get attachmentsEmlNoText => 'Este mensaje no tiene texto.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Adjuntos: $names', one: 'Adjunto: $names');
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
      other: 'Y $count eventos más',
      one: 'Y 1 evento más',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imagen';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imagen $format';
  }

  @override
  String get attachmentsTypePdf => 'Documento PDF';

  @override
  String get attachmentsTypeTsv => 'Valores separados por tabulaciones';

  @override
  String get attachmentsTypeCsv => 'Hoja de cálculo CSV';

  @override
  String get attachmentsTypeCalendar => 'Evento de calendario';

  @override
  String get attachmentsTypeEmail => 'Mensaje de correo';

  @override
  String get attachmentsTypeContact => 'Tarjeta de contacto';

  @override
  String get attachmentsTypeLog => 'Archivo de registro';

  @override
  String get attachmentsTypeText => 'Texto';

  @override
  String get attachmentsTypeZip => 'Archivo ZIP';

  @override
  String get attachmentsTypeArchive => 'Archivo comprimido';

  @override
  String get attachmentsTypeWord => 'Documento de Word';

  @override
  String get attachmentsTypeExcel => 'Hoja de cálculo de Excel';

  @override
  String get attachmentsTypePowerPoint => 'Presentación de PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Página web';

  @override
  String get attachmentsTypeVideo => 'Vídeo';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Archivo $extension';
  }

  @override
  String get attachmentsTypeFile => 'Archivo';

  @override
  String get calendarUntitledEvent => 'Evento';

  @override
  String get calendarAllDay => 'Todo el día';

  @override
  String calendarYourTime(String time) {
    return '$time en tu hora';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Unirse: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha aceptado: $details',
      'tentative': '$name ha aceptado provisionalmente: $details',
      'declined': '$name ha rechazado: $details',
      'delegated': '$name ha delegado: $details',
      'other': '$name no ha respondido a: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha aceptado la invitación',
      'tentative': '$name ha aceptado provisionalmente la invitación',
      'declined': '$name ha rechazado la invitación',
      'delegated': '$name ha delegado la invitación',
      'other': '$name no ha respondido a la invitación',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Unirse';

  @override
  String get calendarOnlineMeeting => 'Reunión en línea';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Reunión de $provider';
  }

  @override
  String get calendarOrganizerYou => 'Tú';

  @override
  String get calendarOrganizerLabel => 'organizador';

  @override
  String get calendarStatusAccepted => 'Aceptada';

  @override
  String get calendarStatusMaybe => 'Quizás';

  @override
  String get calendarStatusDeclined => 'Rechazada';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha aceptado',
      'tentative': '$name ha aceptado provisionalmente',
      'declined': '$name ha rechazado',
      'delegated': '$name ha delegado',
      'other': '$name no ha respondido',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha aceptado:',
      'tentative': '$name ha aceptado provisionalmente:',
      'declined': '$name ha rechazado:',
      'delegated': '$name ha delegado:',
      'other': '$name no ha respondido:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name propone una nueva hora';
  }

  @override
  String get calendarCounterUnknown => 'Un asistente propone una nueva hora';

  @override
  String get calendarDeclineCounter => 'El organizador ha mantenido la hora';

  @override
  String calendarRefresh(String name) {
    return '$name pide la última versión';
  }

  @override
  String get calendarRefreshUnknown => 'Un asistente pide la última versión';

  @override
  String get calendarCancelled => 'Cancelado';

  @override
  String get calendarCancelledByOrganizer => 'El organizador ha cancelado este evento.';

  @override
  String get calendarCancelledLater => 'Este evento se canceló más tarde.';

  @override
  String get calendarOutdated => 'Desactualizada';

  @override
  String get calendarOutdatedDetail => 'Esta invitación se actualizó después; la más reciente es la que cuenta.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Ubicación quitada (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Ubicación quitada (no había ninguna)';

  @override
  String calendarLocationChanged(String location) {
    return 'Ubicación cambiada a $location';
  }

  @override
  String get calendarNewTitle => 'Título nuevo';

  @override
  String get calendarRepeatChanged => 'La repetición ha cambiado';

  @override
  String get calendarUpdated => 'Actualizada';

  @override
  String get calendarUpdatedInvitation => 'Invitación actualizada';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Hora cambiada de $before a $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Zona horaria «$zone» desconocida: horas tal como están escritas';
  }

  @override
  String calendarNext(String when) {
    return 'Próximo: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count invitados', one: '1 invitado');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count han aceptado',
      one: '$count ha aceptado',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count quizás', one: '$count quizás');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count han rechazado',
      one: '$count ha rechazado',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (tú)';
  }

  @override
  String get calendarAttendeeOptional => 'opcional';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptaste una versión anterior.',
      'tentative': 'Aceptaste provisionalmente una versión anterior.',
      'declined': 'Rechazaste una versión anterior.',
      'delegated': 'Delegaste una versión anterior.',
      'other': 'No respondiste a una versión anterior.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Aceptar';

  @override
  String get calendarMaybe => 'Quizás';

  @override
  String get calendarDecline => 'Rechazar';

  @override
  String get calendarCommentHint => 'Comentario para el organizador (opcional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Tu respuesta irá a $organizer desde $address.';
  }

  @override
  String get calendarAddComment => 'Añadir un comentario';

  @override
  String get calendarAddToCalendar => 'Añadir al calendario';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Y $count eventos más en el archivo',
      one: 'Y 1 evento más en el archivo',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'No hay ninguna app de calendario a la que añadir el evento.';

  @override
  String get calendarCantOpenCalendar => 'No se ha podido abrir el calendario.';

  @override
  String get calendarCantOpenLink => 'No se ha podido abrir el enlace.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return '¿Unirse a la reunión de $provider?';
  }

  @override
  String get calendarJoinTitle => '¿Unirse a la reunión?';

  @override
  String calendarJoinOpens(String host) {
    return 'Abre $host en tu navegador.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Cuidado: esta dirección imita a $site con letras que parecen otras.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Cuidado: esta dirección imita a otro sitio con letras que parecen otras.';

  @override
  String calendarJoinOpen(String host) {
    return 'Abrir $host';
  }

  @override
  String get calendarNoOrganizer => 'Esta invitación no tiene organizador al que responder.';

  @override
  String get calendarNoAccount => 'No hay ninguna cuenta desde la que responder.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptada',
      'tentative': 'Quizás',
      'other': 'Rechazada',
    });
    return '$_temp0 · enviando respuesta a $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceptada',
      'tentative': 'Quizás',
      'other': 'Rechazada',
    });
    return '$_temp0 · respuesta enviada';
  }

  @override
  String get calendarReplyAlreadySent => 'La respuesta ya se había enviado.';

  @override
  String get calendarReplyNotSent => 'Respuesta no enviada.';

  @override
  String get dataSmimeNeedsDevice =>
      'Tu certificado S/MIME está en este dispositivo: abre Loupe para firmar y enviar este mensaje.';

  @override
  String dataSigningFailed(String error) {
    return 'No se ha podido firmar: $error';
  }

  @override
  String get keyboardShortcuts => 'Atajos de teclado';

  @override
  String get keyboardGroupGeneral => 'General';

  @override
  String get keyboardGroupMessages => 'Mensajes';

  @override
  String get keyboardGroupCompose => 'Redacción';

  @override
  String get keyboardCommandPalette => 'Paleta de comandos';

  @override
  String get keyboardBackClose => 'Atrás, cerrar';

  @override
  String get keyboardNextMessage => 'Mensaje siguiente';

  @override
  String get keyboardPreviousMessage => 'Mensaje anterior';

  @override
  String get keyboardOpenMessage => 'Abrir mensaje';

  @override
  String get keyboardMoveToTrash => 'Mover a la papelera';

  @override
  String get keyboardToggleRead => 'Marcar como leído o no leído';

  @override
  String get keyboardToggleFlag => 'Marcar con bandera o quitarla';

  @override
  String get keyboardCloseDraft => 'Cerrar (guardar o eliminar el borrador)';

  @override
  String get keyboardOr => 'o';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Mayús';

  @override
  String get keyboardKeyEnter => 'Intro';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Supr';

  @override
  String get keyboardKeyBackspace => 'Retroceso';

  @override
  String get mailingListsMuted => 'Hilo silenciado. Sus mensajes nuevos llegarán como leídos.';

  @override
  String get mailingListsUnmuted => 'Hilo ya no silenciado.';

  @override
  String get mailingListsMuteThread => 'Silenciar hilo';

  @override
  String get mailingListsUnmuteThread => 'Dejar de silenciar hilo';

  @override
  String get mailingListsPin => 'Fijar en Buzones';

  @override
  String get mailingListsUnpin => 'Dejar de fijar en Buzones';

  @override
  String get mailingListsDefaultView => 'Abrir en la vista predeterminada';

  @override
  String get mailingListsPlainText => 'Abrir como texto sin formato (Mono)';

  @override
  String get mailingListsShowMuted => 'Mostrar hilos silenciados';

  @override
  String get mailingListsHideMuted => 'Ocultar hilos silenciados';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratar como newsletter';

  @override
  String get mailingListsOptions => 'Opciones de la lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted no leídos',
      one: '$formatted no leído',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Mensaje nuevo a la lista';

  @override
  String get mailingListsRowUnread => 'No leído';

  @override
  String get mailingListsRowMuted => 'Silenciado';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count respuestas', one: '1 respuesta');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'No hay hilos';

  @override
  String get mailingListsMutedHidden => 'Los hilos silenciados están ocultos.';

  @override
  String get mailingListsTechnicalTitle => 'Listas técnicas';

  @override
  String get mailingListsTechnicalEmpty => 'Las listas de correo aparecen aquí en cuanto llega su correo.';

  @override
  String get mailingListsTechnicalFooter =>
      'Los mensajes de estas listas se abren como texto sin formato con una fuente monoespaciada, y los parches se muestran como diffs. El botón Aa sigue cambiando la vista de cualquier mensaje.';

  @override
  String get paletteMoveToMailbox => 'Mover a un buzón…';

  @override
  String get paletteMarkAllRead => 'Marcar todo como leído';

  @override
  String get paletteExportFolder => 'Exportar carpeta…';

  @override
  String get paletteGetNewMail => 'Recibir correo nuevo';

  @override
  String get paletteSnoozed => 'Pospuestos';

  @override
  String get paletteSubscriptions => 'Suscripciones';

  @override
  String get paletteDiscussions => 'Debates';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Lista de correo';

  @override
  String get paletteTag => 'Etiqueta';

  @override
  String get paletteSwipeActions => 'Acciones al deslizar';

  @override
  String get paletteNotifications => 'Notificaciones';

  @override
  String get paletteRules => 'Reglas';

  @override
  String get paletteEncryption => 'Cifrado de extremo a extremo';

  @override
  String get paletteAdvanced => 'Avanzado';

  @override
  String get paletteAddAccount => 'Añadir cuenta';

  @override
  String get paletteAccount => 'Cuenta';

  @override
  String get paletteFolders => 'Carpetas';

  @override
  String get paletteRecentSearch => 'Búsqueda reciente';

  @override
  String paletteSearchMail(String query) {
    return 'Buscar «$query» en el correo';
  }

  @override
  String get palettePlaceholder => 'Buscar acciones, buzones, ajustes';

  @override
  String get paletteNothingFound => 'No se ha encontrado nada';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox nuevo';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Muestra todo lo que coincida con «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» guardado en Buzones';
  }

  @override
  String get searchMakeRule => 'Convertir en regla';

  @override
  String get searchSaveSmartMailbox => 'Guardar como Smart Mailbox';

  @override
  String get searchNegate => 'Negar';

  @override
  String get searchDontNegate => 'No negar';

  @override
  String get searchAllMailboxes => 'Todos los buzones';

  @override
  String get searchRecent => 'Búsquedas recientes';

  @override
  String get searchClear => 'Borrar';

  @override
  String get searchSuggestions => 'Sugerencias';

  @override
  String get searchUnreadMessages => 'Mensajes no leídos';

  @override
  String get searchFlaggedMessages => 'Mensajes con bandera';

  @override
  String get searchWithAttachments => 'Mensajes con adjuntos';

  @override
  String get searchUnrepliedMessages => 'Mensajes sin responder';

  @override
  String get searchTags => 'Etiquetas';

  @override
  String get searchPeople => 'Personas';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De: $name';
  }

  @override
  String get searchSearching => 'Buscando…';

  @override
  String get searchNoResults => 'No hay resultados';

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
  String get searchMenu => 'Menú de búsqueda';

  @override
  String searchSearchingAccount(String account) {
    return 'Buscando en $account en el servidor…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Buscando en la cuenta en el servidor…';

  @override
  String searchAccountFailed(String account) {
    return 'No se ha podido buscar en $account en el servidor';
  }

  @override
  String get searchUnknownAccountFailed => 'No se ha podido buscar en la cuenta en el servidor';

  @override
  String searchChip(String term) {
    return '$term. Toca dos veces para editar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'No $term. Toca dos veces para editar.';
  }

  @override
  String get searchReadAndUnread =>
      'La bandeja de entrada de Schrödinger: aquí cada mensaje está leído y no leído hasta que lo abres.';

  @override
  String searchContradiction(String term) {
    return 'Ningún mensaje puede ser «$term» y no serlo a la vez.';
  }

  @override
  String get searchSyncDeviceOnly => 'Solo en este dispositivo';

  @override
  String searchSyncUnsupported(String account) {
    return 'Solo en este dispositivo: $account no puede guardarlo';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Sin sincronizar: $account tiene un formato más reciente';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Esperando para sincronizar con $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronizado con $account';
  }

  @override
  String get searchRename => 'Cambiar nombre';

  @override
  String get searchEditSearch => 'Editar búsqueda';

  @override
  String get searchDeleteSmartMailbox => 'Eliminar Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Cambiar nombre del Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Este Smart Mailbox se ha eliminado.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Los Smart Mailboxes se quedan en este dispositivo.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Los Smart Mailboxes se guardan en tu servidor de correo, así que también los tienen tus otros dispositivos, y Thunderbird con Expression Search Reloaded. Los que buscan en todas las cuentas se guardan en $account; los de una sola carpeta, en la cuenta de esa carpeta.';
  }

  @override
  String get searchSyncVia => 'Sincronizar mediante';

  @override
  String get searchSyncViaFooter => 'Elige la misma cuenta en todos los dispositivos.';

  @override
  String get searchGmailCantKeep => 'Gmail no puede guardar Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Guardar los Smart Mailboxes solo en este dispositivo';

  @override
  String get searchOnTheServer => 'En el servidor';

  @override
  String get searchServerFooter =>
      'Los metadatos del servidor (IMAP METADATA) no se ven en ninguna app de correo. Los servidores sin ellos reciben una carpeta «Loupe Settings» con un mensaje; Loupe la oculta en Buzones.';

  @override
  String get searchSyncNow => 'Sincronizar ahora';

  @override
  String get searchStateUnsupported => 'No compatible';

  @override
  String get searchStateNewerFormat => 'Formato más reciente';

  @override
  String get searchStateFailed => 'No se ha podido sincronizar';

  @override
  String get searchStateSyncing => 'Sincronizando…';

  @override
  String get searchStateWaiting => 'En espera';

  @override
  String get searchStateMetadata => 'Metadatos del servidor';

  @override
  String get searchStateFolder => 'Carpeta Loupe Settings';

  @override
  String get searchStateNothing => 'Nada guardado';

  @override
  String get sharedBack => 'Atrás';

  @override
  String get sharedYesterday => 'Ayer';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date a las $time';
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
  String get sharedSyncNoAccounts => 'No hay cuentas';

  @override
  String get sharedSyncChecking => 'Buscando correo…';

  @override
  String get sharedSyncFailed => 'No se ha podido buscar correo';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Sin conexión';

  @override
  String get sharedSyncJustNow => 'Actualizado ahora mismo';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Actualizado hace $minutes minutos',
      one: 'Actualizado hace 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Actualizado a las $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Actualizado el $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Todas las bandejas de entrada';

  @override
  String get sharedMailboxUnread => 'No leídos';

  @override
  String get sharedMailboxFlagged => 'Con bandera';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Todos los borradores';

  @override
  String get sharedMailboxAllSent => 'Todos los enviados';

  @override
  String get sharedMailboxUntitled => 'Buzón';

  @override
  String get sharedTagImportant => 'Importante';

  @override
  String get sharedTagWork => 'Trabajo';

  @override
  String get sharedTagPersonal => 'Personal';

  @override
  String get sharedTagToDo => 'Por hacer';

  @override
  String get sharedTagLater => 'Más tarde';

  @override
  String get sharedTags => 'Etiquetas';

  @override
  String get sharedMoveTo => 'Mover a…';

  @override
  String get sharedNoRecipients => 'Sin destinatarios';

  @override
  String get sharedUnknownSender => 'Remitente desconocido';

  @override
  String get sharedOnServer => 'En el servidor';

  @override
  String get sharedAttachment => 'Adjunto';

  @override
  String get sharedSnoozedBadge => 'Pospuesto';

  @override
  String get sharedRowUnread => 'No leído';

  @override
  String get sharedRowBackFromSnooze => 'Vuelto de posponer';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Con bandera';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes archivados',
      one: '1 mensaje archivado',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes eliminados',
      one: '1 mensaje eliminado',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes movidos a la bandeja de entrada',
      one: '1 mensaje movido a la bandeja de entrada',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes movidos a la papelera',
      one: '1 mensaje movido a la papelera',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes movidos a correo no deseado',
      one: '1 mensaje movido a correo no deseado',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes movidos a $mailbox',
      one: '1 mensaje movido a $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes movidos a un buzón',
      one: '1 mensaje movido a un buzón',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes pospuestos hasta $time',
      one: '1 mensaje pospuesto hasta $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Pospuesto hasta $time solo en este dispositivo: el servidor no puede guardar horas de posposición.';
  }

  @override
  String get sharedMoveOneAccount => 'Selecciona mensajes de una sola cuenta para moverlos.';

  @override
  String get sharedSnoozeTitle => 'Posponer';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Cambiar hora de posposición';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¿Eliminar $count mensajes definitivamente?',
      one: '¿Eliminar este mensaje definitivamente?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Esta acción no se puede deshacer.';

  @override
  String get sharedDeletePermanently => 'Eliminar definitivamente';

  @override
  String get sharedSwipeRead => 'Leído';

  @override
  String get sharedSwipeUnread => 'No leído';

  @override
  String get sharedSwipeInbox => 'Entrada';

  @override
  String get sharedSwipeDelete => 'Eliminar';

  @override
  String get sharedTrash => 'Papelera';

  @override
  String get sharedSwipeSnooze => 'Posponer';

  @override
  String get sharedWakeNow => 'Recuperar ahora';

  @override
  String get sharedChangeSnoozeTime => 'Cambiar hora de posposición…';

  @override
  String get sharedSnooze => 'Posponer…';

  @override
  String get sharedTag => 'Etiquetar…';

  @override
  String get sharedMoveMessage => 'Mover mensaje…';

  @override
  String get sharedNotJunk => 'No es correo no deseado';

  @override
  String get accountSetupTitle => 'Añadir cuenta';

  @override
  String get accountSetupTitleDone => 'Cuenta añadida';

  @override
  String get accountSetupAddressTitle => 'Añadir una cuenta de correo';

  @override
  String get accountSetupAddressText => 'Loupe encuentra los ajustes de la mayoría de los proveedores.';

  @override
  String get accountSetupNameHint => 'Tu nombre';

  @override
  String get accountSetupEmail => 'Correo electrónico';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Continuar';

  @override
  String get accountSetupLookingUp => 'Buscando los ajustes…';

  @override
  String get accountSetupImport => 'Importar de Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Introduce una dirección de correo válida.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'No se han encontrado los ajustes de $domain. Introdúcelos abajo.';
  }

  @override
  String get accountSetupCheckServers => 'Comprueba los nombres de los servidores y los puertos.';

  @override
  String get accountSetupEnterPassword => 'Introduce tu contraseña.';

  @override
  String get accountSetupConnecting => 'Conectando…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Esperando a $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'No se ha podido abrir la página.';

  @override
  String get accountSetupCouldNotSaveName => 'No se ha podido guardar el nombre.';

  @override
  String get accountSetupTrustCertificate => 'Confiar en este certificado';

  @override
  String get accountSetupPasswordRequired => 'Obligatoria';

  @override
  String get accountSetupShowPassword => 'Mostrar contraseña';

  @override
  String get accountSetupHidePassword => 'Ocultar contraseña';

  @override
  String get accountSetupAppPassword => 'Contraseña de aplicación';

  @override
  String get accountSetupApiToken => 'Token de API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Entrante · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Saliente · SMTP';

  @override
  String get accountSetupSignIn => 'Iniciar sesión';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Iniciar sesión con $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Usar una contraseña de aplicación';

  @override
  String get accountSetupUseAppPasswordInstead => 'Usar una contraseña de aplicación';

  @override
  String get accountSetupUseDifferentAddress => 'Usar otra dirección';

  @override
  String get accountSetupHowToCreateAppPassword => 'Cómo crear una contraseña de aplicación';

  @override
  String get accountSetupHowToCreateOne => 'Cómo crear una';

  @override
  String get accountSetupGoogleNote =>
      'Inicias sesión en la página de Google y Loupe nunca ve tu contraseña. Permite que Loupe lea, envíe y organice tu correo.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Iniciar sesión con Google» aún no está disponible en esta versión. Puedes conectarte con una contraseña de aplicación (requiere la verificación en dos pasos en tu cuenta de Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Crea una contraseña de aplicación en tu cuenta de Google y pégala abajo.';

  @override
  String get accountSetupMicrosoftNote =>
      'Inicias sesión en la página de Microsoft y Loupe nunca ve tu contraseña. Funciona con Outlook.com y Hotmail, y con cuentas de trabajo o de centros educativos de Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'El inicio de sesión de Microsoft llegará en una versión posterior. Las cuentas de Outlook, Hotmail y Microsoft 365 lo necesitan: ya no aceptan contraseñas de las apps de correo.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail necesita una contraseña específica para apps, no la contraseña de tu cuenta de Apple.';

  @override
  String get accountSetupYahooNote =>
      'Yahoo Mail necesita una contraseña de aplicación, no la contraseña de tu cuenta.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se conecta a Fastmail por JMAP con un token de API: Settings › Privacy & Security › Manage API tokens, para JMAP, con acceso al correo y al envío.';

  @override
  String get accountSetupFastmailNote => 'Fastmail necesita una contraseña de aplicación para las apps de correo.';

  @override
  String get accountSetupServerSettings => 'Ajustes del servidor';

  @override
  String get accountSetupSettingsNotFound => 'No se han encontrado automáticamente';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Encontrados mediante $source';
  }

  @override
  String get accountSetupEditSettings => 'Editar ajustes';

  @override
  String get accountSetupSyncing => 'Tu correo se está sincronizando.';

  @override
  String get accountSetupDescription => 'Descripción';

  @override
  String get accountSetupDescriptionHint => 'Trabajo, Personal…';

  @override
  String get accountSetupColour => 'Color';

  @override
  String accountSetupColourNumber(int number) {
    return 'Color $number';
  }

  @override
  String get accountSetupSaving => 'Guardando…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe no ha podido abrir su base de datos de correo en este teléfono. Cierra Loupe, vuelve a abrirla e inténtalo de nuevo.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Algo ha fallado ($error). Vuelve a intentarlo.';
  }

  @override
  String get accountSetupSecurityNone => 'Ninguna';

  @override
  String get accountSetupProtocol => 'Protocolo';

  @override
  String get accountSetupPort => 'Puerto';

  @override
  String get accountSetupSecurity => 'Seguridad';

  @override
  String get accountSetupUsername => 'Nombre de usuario';

  @override
  String get accountSetupUsernameHint => 'Tu dirección de correo';

  @override
  String get accountSetupNoEncryptionTitle => '¿Conectar sin cifrado?';

  @override
  String get accountSetupNoEncryptionText =>
      'Tu contraseña y todos los mensajes viajarían como texto sin cifrar. Cualquiera en la red, como una wifi pública, podría leerlos. Úsalo solo con un servidor de tu propia red.';

  @override
  String get accountSetupUseWithoutEncryption => 'Usar sin cifrado';

  @override
  String get accountSetupApiTokenRejected =>
      'Token de API rechazado. Crea un token de API de Fastmail para JMAP con acceso al correo y pégalo.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Contraseña rechazada. Usa una contraseña de aplicación, no la contraseña de tu cuenta.';

  @override
  String get accountSetupPasswordRejected => 'Contraseña rechazada. Compruébala y vuelve a intentarlo.';

  @override
  String get accountSetupServerUnreachable =>
      'No se puede conectar con el servidor. Comprueba los ajustes del servidor y tu conexión.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'El certificado del servidor no es de confianza. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Se ha cancelado el inicio de sesión. Toca «Iniciar sesión con $provider» para volver a intentarlo.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe necesita permiso para leer y enviar tu correo de Gmail. Vuelve a iniciar sesión y permite el acceso, con la casilla de Gmail marcada.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe necesita permiso para leer y enviar tu correo. Vuelve a iniciar sesión y acepta los permisos.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Tu organización debe aprobar Loupe antes de que puedas usarla con esta cuenta. Pide a tu administrador de informática que conceda el consentimiento de administrador a Loupe en Microsoft Entra ID y vuelve a intentarlo.';

  @override
  String get accountSetupOAuthBlocked =>
      'Las reglas de inicio de sesión de tu organización no permiten Loupe en este dispositivo. Pregunta a tu administrador de informática.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'No se ha podido conectar con $provider. Comprueba tu conexión a internet y vuelve a intentarlo.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'El inicio de sesión con $provider no está bien configurado en esta versión de Loupe. Por favor, infórmanos.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'El inicio de sesión con $provider no ha funcionado. Vuelve a intentarlo.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider ha iniciado tu sesión, pero Gmail ha denegado el acceso para esta dirección. Elige la misma cuenta al iniciar sesión. En las cuentas de trabajo o de centros educativos, puede que el administrador haya desactivado IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider ha iniciado tu sesión, pero el servidor de correo ha denegado el acceso para esta dirección. Elige la misma cuenta al iniciar sesión. En las cuentas de trabajo o de centros educativos, puede que el administrador haya desactivado IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'No se puede conectar con el servidor de correo. Comprueba tu conexión y vuelve a intentarlo.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'El inicio de sesión con $provider no está disponible en esta versión.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Sesión iniciada de nuevo. $account se está sincronizando.';
  }

  @override
  String get accountSetupSignInAgain => 'Volver a iniciar sesión';

  @override
  String get accountSetupSigningIn => 'Iniciando sesión…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider ya no acepta el inicio de sesión de Loupe para $email, así que $account no se está sincronizando. Vuelve a iniciar sesión para recibir su correo.';
  }

  @override
  String get accountImportTitle => 'Importar de Thunderbird';

  @override
  String get accountImportPointCamera => 'Apunta la cámara al código QR que muestra Thunderbird.';

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
      other: '$count cuentas hasta ahora',
      one: '1 cuenta hasta ahora',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'En tu ordenador, abre Thunderbird y elige Herramientas › Exportar para móvil. Selecciona tus cuentas y escanea cada código que muestre. Los códigos se pueden escanear en cualquier orden.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar con $count cuentas',
      one: 'Continuar con 1 cuenta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Pegar el texto';

  @override
  String get accountImportStartOver => 'Empezar de nuevo';

  @override
  String get accountImportDuplicateCode => 'Ese código ya se ha añadido.';

  @override
  String get accountImportRestarted =>
      'Este código es de una exportación nueva, así que los códigos escaneados antes se han descartado.';

  @override
  String get accountImportNotThunderbird => 'Este no es un código de cuenta de Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Este código procede de un Thunderbird más reciente. Actualiza Loupe para importarlo.';

  @override
  String get accountImportDamaged => 'No se ha podido leer este código de Thunderbird.';

  @override
  String get accountImportTooLarge => 'Este código es demasiado grande para ser una exportación de Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'No se han podido abrir los ajustes.';

  @override
  String get accountImportCameraOffTitle => 'El acceso a la cámara está desactivado';

  @override
  String get accountImportCameraOffText =>
      'Permite que Loupe use la cámara en los ajustes para escanear el código, o pega el texto del código.';

  @override
  String get accountImportNoCameraTitle => 'No hay cámara';

  @override
  String get accountImportNoCameraText => 'Loupe no puede usar una cámara aquí. Pega el texto del código.';

  @override
  String get accountImportCameraFailedTitle => 'La cámara no se ha iniciado';

  @override
  String get accountImportCameraFailedText => 'Vuelve a intentarlo o pega el texto del código.';

  @override
  String get accountImportOpenSettings => 'Abrir ajustes';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se han encontrado $count cuentas',
      one: 'Se ha encontrado 1 cuenta',
      zero: 'No se han encontrado cuentas',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'No se ha podido leer ninguna de las cuentas de estos códigos.';

  @override
  String get accountImportChoose => 'Elige las cuentas que quieres añadir a Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Los códigos $codes de $total no se han escaneado, así que sus cuentas no aparecen.',
      one: 'El código $codes de $total no se ha escaneado, así que sus cuentas no aparecen.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes y $last';
  }

  @override
  String get accountImportScanMore => 'Escanear más códigos';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'No se han podido leer $count cuentas de los códigos. Puede que usen ajustes de un Thunderbird más reciente.',
      one: 'No se ha podido leer 1 cuenta de los códigos. Puede que use ajustes de un Thunderbird más reciente.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Volver a escanear';

  @override
  String get accountImportAlreadyAdded => 'Ya hay en Loupe una cuenta con esta dirección.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Iniciarás sesión con $provider cuando se añada, como en Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Añade la cuenta con una contraseña de aplicación (requiere la verificación en dos pasos).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird inicia sesión en Gmail con Google. «Iniciar sesión con Google» llegará en una versión posterior; hasta entonces, añade la cuenta con una contraseña de aplicación (requiere la verificación en dos pasos).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird inicia sesión en esta cuenta en el navegador. Loupe aún no puede hacerlo: usa una contraseña de aplicación si tu proveedor la ofrece.';

  @override
  String get accountImportUnencrypted => 'Se conecta sin cifrado. Úsalo solo en tu propia red.';

  @override
  String get accountImportEnterAgain => 'Vuelve a introducirla';

  @override
  String get accountImportAdded => 'Añadida';

  @override
  String accountImportAdding(int index, int total) {
    return 'Añadiendo $index de $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Añadir $count cuentas',
      one: 'Añadir 1 cuenta',
      zero: 'Añadir cuentas',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Pegar el texto de exportación';

  @override
  String get accountImportPasteText => 'Pega el texto de un código de exportación de Thunderbird, un código por línea.';

  @override
  String get accountImportPop3 =>
      'Las cuentas POP3 no son compatibles. Loupe mantiene el correo en el servidor con IMAP.';

  @override
  String get accountImportKerberos => 'Esta cuenta inicia sesión con Kerberos, que Loupe no admite.';

  @override
  String get accountImportNtlm => 'Esta cuenta inicia sesión con NTLM, que Loupe no admite.';

  @override
  String get accountImportClientCertificate =>
      'Esta cuenta inicia sesión con un certificado de cliente, que Loupe aún no admite.';

  @override
  String get accountImportMicrosoftSignIn =>
      'El inicio de sesión de Microsoft llegará en una versión posterior. Las cuentas de Outlook y Microsoft 365 ya no aceptan contraseñas de las apps de correo.';

  @override
  String get accountImportEnterPassword => 'Introduce la contraseña.';

  @override
  String get accountImportEnterAppPassword => 'Introduce la contraseña de aplicación.';

  @override
  String get accountImportEnterApiToken => 'Introduce el token de API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe no ha podido abrir su almacenamiento de cuentas. Vuelve a intentarlo más tarde.';

  @override
  String get accountImportFailed => 'No se ha podido añadir la cuenta. Vuelve a intentarlo o añádela manualmente.';

  @override
  String get composeNewMessageTitle => 'Mensaje nuevo';

  @override
  String get composeAttach => 'Adjuntar';

  @override
  String get composeSendLater => 'Enviar más tarde';

  @override
  String composeSendAt(String time) {
    return 'Enviar $time';
  }

  @override
  String get composeSendHint => 'Mantén pulsado para enviar más tarde';

  @override
  String get composeNoAccount => 'Añade una cuenta para enviar correo.';

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
    return '¿Responder desde $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return '¿Enviar desde $email?';
  }

  @override
  String get composeDismiss => 'Descartar';

  @override
  String composeAliasNotSaved(String account) {
    return 'No guardada como identidad · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Guardar como identidad';

  @override
  String composeAliasSaved(String email) {
    return '$email se ha guardado como identidad.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Dirección no válida $address';
  }

  @override
  String get composeOriginalNotFound => 'No se ha encontrado el mensaje original.';

  @override
  String get composeDraftNotFound => 'No se ha encontrado el borrador.';

  @override
  String get composeAttachmentsLost => 'No se han podido recuperar los adjuntos. Vuelve a añadirlos.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'No se han podido añadir algunos adjuntos: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Los adjuntos suman $size; algunos servidores rechazan mensajes tan grandes.';
  }

  @override
  String get composeAttachFailed => 'No se ha podido adjuntar el archivo.';

  @override
  String get composeInvalidAddressTitle => 'Dirección no válida';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» no es una dirección de correo válida.';
  }

  @override
  String get composeNoSubjectTitle => 'Sin asunto';

  @override
  String get composeNoSubjectText => 'Este mensaje no tiene asunto. ¿Enviarlo de todos modos?';

  @override
  String get composeSentBeforeChanges => 'Se envió antes de tus cambios, que se han guardado en Borradores.';

  @override
  String composeScheduled(String time) {
    return 'Programado para $time';
  }

  @override
  String get composeSending => 'Enviando…';

  @override
  String get composeSent => 'Enviado';

  @override
  String get composeSendFailed => 'No se ha podido enviar. Vuelve a intentarlo.';

  @override
  String get composeAlreadySent => 'Ya se ha enviado.';

  @override
  String get composeDiscardChanges => 'Descartar cambios';

  @override
  String get composeSaveChanges => 'Guardar cambios';

  @override
  String get composeDeleteDraft => 'Eliminar borrador';

  @override
  String get composeSaveDraft => 'Guardar borrador';

  @override
  String get composeDraftSaved => 'Borrador guardado';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'El $date a las $time, $name escribió:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'El $date a las $time, alguien escribió:';
  }

  @override
  String get composeForwardHeader => '---------- Mensaje reenviado ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Fecha: $date a las $time';
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
  String get composeLaterToday => 'Más tarde hoy';

  @override
  String get composeTomorrowMorning => 'Mañana por la mañana';

  @override
  String get composeMondayMorning => 'El lunes por la mañana';

  @override
  String get composePickDateTime => 'Elegir fecha y hora…';

  @override
  String get composeSendWithoutDelay => 'Enviar sin esperar';

  @override
  String composeSendTimeToday(String time) {
    return 'Hoy a las $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Mañana a las $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day a las $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Hoy $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Mañana $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => '¿Seguir editando tu borrador?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Un mensaje no se envió al cerrarse Loupe.',
      'one': 'Un mensaje para $name no se envió al cerrarse Loupe.',
      'other': 'Un mensaje para $name y otros no se envió al cerrarse Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» no se envió al cerrarse Loupe.',
      'one': '«$subject» para $name no se envió al cerrarse Loupe.',
      'other': '«$subject» para $name y otros no se envió al cerrarse Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Seguir editando';

  @override
  String get composeRecoverySave => 'Guardar en Borradores';

  @override
  String get composeRecoveryDiscard => 'Descartar';

  @override
  String get composeRecoverySaved => 'Guardado en Borradores';

  @override
  String get outboxSectionFailed => 'No enviados';

  @override
  String get outboxSectionSending => 'Enviando';

  @override
  String get outboxSectionScheduled => 'Programados';

  @override
  String get outboxStatusQueued => 'Se enviará pronto';

  @override
  String get outboxStatusSending => 'Enviando…';

  @override
  String get outboxStatusFailed => 'No enviado';

  @override
  String get outboxNoRecipients => 'Sin destinatarios';

  @override
  String get outboxNoSubject => '(Sin asunto)';

  @override
  String get outboxSendingFailed => 'No se ha podido enviar.';

  @override
  String get outboxEmptyTitle => 'Nada que enviar';

  @override
  String get outboxEmptyText => 'Los mensajes que envías más tarde esperan aquí hasta que llega su hora.';

  @override
  String get outboxSendNow => 'Enviar ahora';

  @override
  String get outboxReschedule => 'Reprogramar';

  @override
  String get outboxRescheduleMenu => 'Reprogramar…';

  @override
  String get outboxRescheduleTitle => 'Reprogramar';

  @override
  String outboxRescheduled(String time) {
    return 'Reprogramado para $time';
  }

  @override
  String get outboxCancel => 'Cancelar';

  @override
  String get outboxCancelSending => 'Cancelar envío…';

  @override
  String get outboxCancelTitle => '¿Cancelar el envío?';

  @override
  String get outboxMoveToDrafts => 'Mover a Borradores';

  @override
  String get outboxDiscard => 'Descartar mensaje';

  @override
  String get outboxMovedToDrafts => 'Movido a Borradores';

  @override
  String get outboxDiscarded => 'Mensaje descartado';

  @override
  String get outboxAlreadySent => 'Ya se ha enviado.';

  @override
  String get outboxBeingSent => 'Este mensaje se está enviando.';

  @override
  String get outboxActionFailed => 'No ha funcionado. El mensaje sigue en la bandeja de salida.';

  @override
  String get notificationsBadgeInboxes => 'No leídos en las bandejas de entrada';

  @override
  String get notificationsBadgeVip => 'No leídos de VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Correo nuevo de tus VIP, en cualquier cuenta';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Correo nuevo en $email';
  }

  @override
  String get notificationsUnknownSender => 'Remitente desconocido';

  @override
  String get notificationsNoSubject => '(Sin asunto)';

  @override
  String get notificationsEncryptedMessage => 'Mensaje cifrado';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Mensaje nuevo de $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes nuevos',
      one: '1 mensaje nuevo',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Mensajes nuevos en $account';
  }

  @override
  String get platformInstantChannel => 'Entrega instantánea';

  @override
  String get platformInstantChannelDescription =>
      'Se muestra mientras Loupe vigila si llega correo nuevo a tus bandejas de entrada';

  @override
  String get platformInstantTitle => 'Atento al correo nuevo';

  @override
  String get platformInstantText => 'La entrega instantánea está activada';

  @override
  String get platformErrorBox => 'Algo ha fallado al mostrar esto. Vuelve atrás e inténtalo de nuevo.';

  @override
  String get welcomeTagline => 'Correo sencillo en la superficie\ny potente por dentro.';

  @override
  String get welcomeAccountsTitle => 'Todas tus cuentas, una bandeja tranquila';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail y cualquier servidor IMAP o JMAP.';

  @override
  String get welcomeSearchTitle => 'Una búsqueda que lo encuentra';

  @override
  String get welcomeSearchText => 'Resultados al instante en tu teléfono y, después, los del servidor.';

  @override
  String get welcomePrivacyTitle => 'Privada por diseño';

  @override
  String get welcomePrivacyText => 'Sin rastreo. Las imágenes remotas siguen bloqueadas hasta que tú digas.';

  @override
  String get welcomeAddAccount => 'Añadir cuenta';

  @override
  String get welcomeImport => 'Importar de Thunderbird';

  @override
  String get welcomeTryDemo => 'Probar con correo de demostración';
}
