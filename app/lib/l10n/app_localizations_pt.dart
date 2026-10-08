// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonDone => 'Concluído';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonMore => 'Mais';

  @override
  String get commonMove => 'Mover';

  @override
  String get commonName => 'Nome';

  @override
  String get commonNone => 'Nenhum';

  @override
  String get commonOff => 'Desativado';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Ativado';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonPassword => 'Palavra-passe';

  @override
  String get commonRemove => 'Remover';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonSearch => 'Pesquisar';

  @override
  String get commonServer => 'Servidor';

  @override
  String get commonSettings => 'Definições';

  @override
  String get commonShare => 'Partilhar';

  @override
  String get commonTryAgain => 'Tentar novamente';

  @override
  String get commonUndo => 'Anular';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensagens', one: '$count mensagem');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arquivar';

  @override
  String get mailDelete => 'Eliminar';

  @override
  String get mailFlag => 'Sinalizar';

  @override
  String get mailForward => 'Encaminhar';

  @override
  String get mailMarkAsRead => 'Marcar como lida';

  @override
  String get mailMarkAsUnread => 'Marcar como não lida';

  @override
  String get mailMoveToJunk => 'Mover para Spam';

  @override
  String get mailNewMessage => 'Nova mensagem';

  @override
  String get mailNoSubject => 'Sem assunto';

  @override
  String get mailReply => 'Responder';

  @override
  String get mailReplyAll => 'Responder a todos';

  @override
  String get mailSend => 'Enviar';

  @override
  String get mailUnflag => 'Remover sinalização';

  @override
  String get mailboxArchive => 'Arquivo';

  @override
  String get mailboxDrafts => 'Rascunhos';

  @override
  String get mailboxInbox => 'Caixa de entrada';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Caixa de saída';

  @override
  String get mailboxSent => 'Enviados';

  @override
  String get mailboxTrash => 'Lixo';

  @override
  String get conversationSomethingWentWrong => 'Ocorreu um erro. Tente novamente.';

  @override
  String get conversationReplyToList => 'Responder à lista';

  @override
  String get conversationReplyList => 'Responder à lista';

  @override
  String get conversationThreadMuted => 'Conversa silenciada. As novas mensagens nela chegam como lidas.';

  @override
  String get conversationThreadUnmuted => 'A conversa deixou de estar silenciada.';

  @override
  String get conversationLinkFailed => 'Não foi possível abrir a ligação.';

  @override
  String get conversationGoneTitle => 'Sem mensagem';

  @override
  String get conversationGoneText => 'Esta mensagem foi movida ou eliminada.';

  @override
  String get conversationMuted => 'Silenciada';

  @override
  String get conversationReaderOptions => 'Opções de leitura';

  @override
  String get conversationReaderOptionsHint => 'Tamanho do texto e vista';

  @override
  String get conversationTrash => 'Lixo';

  @override
  String get conversationReplyHint => 'Toque longo para Responder a todos e Encaminhar';

  @override
  String get conversationOfflineTitle => 'Está offline';

  @override
  String get conversationOfflineText =>
      'Esta conversa ainda não foi transferida. Vai carregar quando voltar a estar online.';

  @override
  String get conversationErrorTitle => 'Não é possível mostrar esta mensagem';

  @override
  String get conversationErrorText => 'Ocorreu um erro.';

  @override
  String get conversationOfflineBanner => 'Está offline';

  @override
  String get conversationNotUpdated => 'Não atualizada';

  @override
  String get conversationMe => 'mim';

  @override
  String get conversationNoSender => '(sem remetente)';

  @override
  String get conversationNoRecipients => 'sem destinatários';

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
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Responder a';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Segurança';

  @override
  String get conversationVerifiedSender => 'Remetente verificado';

  @override
  String get conversationUnverifiedSender => 'Remetente não verificado';

  @override
  String get conversationLoadingMessage => 'A carregar a mensagem';

  @override
  String get conversationBodyError => 'Não foi possível carregar esta mensagem.';

  @override
  String get conversationBodyOffline => 'Está offline. A mensagem vai carregar quando voltar a estar online.';

  @override
  String get conversationOriginalHint => 'Fica melhor na vista Original';

  @override
  String get conversationShowOriginal => 'Mostrar original';

  @override
  String get conversationScrollToTop => 'Ir para o início';

  @override
  String get conversationTagsMenu => 'Etiquetas…';

  @override
  String get conversationMuteThread => 'Silenciar conversa';

  @override
  String get conversationUnmuteThread => 'Deixar de silenciar conversa';

  @override
  String get conversationMoveMenu => 'Mover…';

  @override
  String get conversationDeletePermanently => 'Eliminar definitivamente';

  @override
  String get conversationMoveToTrash => 'Mover para o Lixo';

  @override
  String get conversationNotJunk => 'Não é spam';

  @override
  String get conversationShowAllHeaders => 'Mostrar todos os cabeçalhos';

  @override
  String get conversationViewSource => 'Ver código-fonte';

  @override
  String get conversationSaveAsFile => 'Guardar como ficheiro…';

  @override
  String get conversationShareAsFile => 'Partilhar como ficheiro…';

  @override
  String get conversationSearchFromMessageMenu => 'Pesquisar a partir desta mensagem…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copiar endereço';

  @override
  String get conversationAddressCopied => 'Endereço copiado';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Pesquisar mensagens de $name';
  }

  @override
  String get conversationTags => 'Etiquetas';

  @override
  String get conversationAllHeaders => 'Todos os cabeçalhos';

  @override
  String get conversationCopyAll => 'Copiar tudo';

  @override
  String get conversationHeadersCopied => 'Cabeçalhos copiados';

  @override
  String get conversationNoHeaders => 'Sem cabeçalhos';

  @override
  String get conversationSearchFromMessageTitle => 'Pesquisar a partir desta mensagem';

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
    return 'Assunto «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Código-fonte';

  @override
  String get conversationSourceCopied => 'Código-fonte copiado';

  @override
  String get conversationShareFailed => 'Não foi possível partilhar a mensagem.';

  @override
  String get conversationWrapLines => 'Quebrar linhas';

  @override
  String get conversationDontWrapLines => 'Não quebrar linhas';

  @override
  String get conversationSourceError => 'Não foi possível carregar o código-fonte.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'A mostrar os primeiros $shown de $total. Copie ou partilhe para obter tudo.';
  }

  @override
  String get conversationAttachmentUntitled => 'Sem título';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Mais ações para $name';
  }

  @override
  String get conversationMoveTo => 'Mover para…';

  @override
  String get conversationMailboxesError => 'Não foi possível carregar as caixas de correio.';

  @override
  String get conversationReaderReadable => 'Legível';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Texto';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Manter as cores originais';

  @override
  String get conversationReaderRemember => 'Lembrar para este remetente';

  @override
  String get conversationSecurityPossiblePhishing => 'Possível phishing';

  @override
  String get conversationSecurityBeCareful => 'Cuidado';

  @override
  String get conversationSecurityVerified => 'Verificado';

  @override
  String get conversationSecurityNoIssues => 'Nenhum problema encontrado';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rastreadores',
      one: '$count rastreador',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Mostra porquê';

  @override
  String get conversationPhishingBannerTitle => 'Esta mensagem parece phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. As ligações e as imagens estão desativadas.';
  }

  @override
  String get conversationPhishingBannerText => 'As ligações e as imagens estão desativadas.';

  @override
  String get conversationPhishingWhy => 'Porquê?';

  @override
  String get conversationPhishingShowAnyway => 'Mostrar mesmo assim';

  @override
  String get conversationSecurityPhishingTitle => 'Isto parece phishing';

  @override
  String get conversationSecurityPhishingText => 'Vários sinais indicam que esta mensagem não é o que diz ser.';

  @override
  String get conversationSecurityCarefulTitle => 'Cuidado com esta mensagem';

  @override
  String get conversationSecurityCarefulText => 'Há algo nela que merece uma segunda análise.';

  @override
  String get conversationSecurityVerifiedText => 'O remetente está verificado e nada parece suspeito.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nada parece suspeito. O seu servidor de e-mail não indicou se o remetente está verificado.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nada parece suspeito.';

  @override
  String get conversationSecurityWhy => 'Porquê';

  @override
  String get conversationSecurityPrivacy => 'Privacidade';

  @override
  String get conversationSecurityNoTrackingPixels => 'Sem píxeis de rastreio';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count píxeis de rastreio removidos',
      one: '$count píxel de rastreio removido',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Teriam avisado o remetente quando abrisse esta mensagem.';

  @override
  String get conversationSecurityNoRemoteImages => 'Sem imagens remotas';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imagens remotas',
      one: '$count imagem remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Carregá-las revela ao remetente quando lê esta mensagem, bem como o seu endereço IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Sem rastreio de cliques';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ligações passam por rastreadores de cliques',
      one: '$count ligação passa por rastreadores de cliques',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'O seu clique ficaria registado por $services. Faça um toque longo numa ligação para abrir diretamente o destino.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Detalhes técnicos';

  @override
  String get conversationSecurityCheckedLocally => 'Verificado neste dispositivo. Nada foi enviado para lado nenhum.';

  @override
  String get conversationSecurityTrackersLabel => 'Rastreadores';

  @override
  String get conversationSecurityImagesFrom => 'Imagens de';

  @override
  String get conversationSecuritySenderHistory => 'Histórico do remetente';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received recebidas, $sent enviadas';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'As ligações levam a';

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
  String get conversationSecurityAuthFailedTitle => 'Remetente não verificado';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'O seu servidor de e-mail não conseguiu confirmar que esta mensagem vem realmente de $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'O seu servidor de e-mail não conseguiu confirmar que esta mensagem vem realmente do remetente.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'O seu servidor de e-mail não conseguiu confirmar que esta mensagem vem de $domain. É comum nas listas de correio.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'O seu servidor de e-mail não conseguiu confirmar que esta mensagem vem do remetente. É comum nas listas de correio.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Não aja com base nela, a não ser que a estivesse à espera. Em caso de dúvida, contacte o remetente de outra forma.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Assinada por outro domínio';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'A mensagem está assinada por $signer, e não por $domain. Os serviços de envio de e-mail fazem isto, mas não prova quem a escreveu.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'A mensagem está assinada por outro domínio, e não por $domain. Os serviços de envio de e-mail fazem isto, mas não prova quem a escreveu.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'O nome mostra outro endereço';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'O nome do remetente diz «$shown», mas a mensagem vem de $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Confie no endereço, não no nome.';

  @override
  String get conversationSecurityReplyToTitle => 'As respostas vão para outro lado';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Se responder, a sua resposta vai para $address, e não para $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Verifique o endereço antes de responder com algo pessoal.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Usa o seu nome';

  @override
  String get conversationSecurityImpersonationTitle => 'Usa o nome de alguém que conhece';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Está assinada «$name», como o seu próprio nome, mas vem de um endereço novo: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Está assinada «$name», como o seu VIP $knownName ($knownEmail), mas vem de um endereço novo: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Está assinada «$name», como $knownName ($knownEmail), mas vem de um endereço novo: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'E as respostas iriam para ainda outro endereço.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Se pedir dinheiro, códigos ou ficheiros, confirme primeiro com essa pessoa por outra via.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Endereço conhecido: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Este endereço: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primeira mensagem deste remetente';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Nunca recebeu e-mail de $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Tenha cuidado com pedidos de pessoas que ainda não conhece.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Letras parecidas no endereço do remetente';

  @override
  String get conversationSecurityLinkHomographTitle => 'Letras parecidas numa ligação';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mistura letras de alfabetos diferentes para imitar outro endereço.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host usa letras parecidas: não é $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Elimine-a ou denuncie-a como spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Não a abra.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domínio: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domínio que imita outro';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Usa um nome conhecido no domínio';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain parece o seu próprio domínio, $real, mas é um domínio diferente.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain parece $brand ($real), mas é um domínio diferente.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain usa o nome do seu próprio domínio, $real, mas não lhe pertence.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain usa o nome de $brand ($real), mas não lhe pertence.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'As mensagens verdadeiras da sua organização vêm de $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'As mensagens verdadeiras de $brand vêm de $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domínio do remetente: $domain';
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
      other: '$count ligações escondem o seu destino',
      one: '$count ligação esconde o seu destino',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Uma ligação mostra $shown, mas abre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Não inicie sessão nem pague através destas ligações. Em vez disso, escreva o endereço manualmente.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Não é possível verificar o destino de uma ligação';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Uma ligação mostra $shown, mas passa por $host, que regista o clique antes de o reencaminhar.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Uma ligação aponta para um simples endereço IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts não é um site com nome. As empresas verdadeiras raramente usam ligações assim.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Uma ligação disfarçada';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Uma ligação começa por «$shown@» para parecer $shown, mas abre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Foi desativada uma página oculta';

  @override
  String get conversationSecurityDataLinkText =>
      'Uma ligação teria aberto uma página embutida na mensagem, uma forma de contornar a verificação de ligações.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Pede uma palavra-passe';

  @override
  String get conversationSecurityPasswordFieldText =>
      'A mensagem continha um campo de palavra-passe. O Loupe removeu-o.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nunca escreva uma palavra-passe num e-mail.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Foi desativada uma ligação que executa código';

  @override
  String get conversationSecurityScriptLinkText => 'O Loupe nunca executa código das mensagens.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ligações encurtadas',
      one: '$count ligação encurtada',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts esconde o destino real até a abrir.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Endereço web internacional';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts usa letras não latinas. É normal em muitas línguas; confirme que é o site que espera.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Muito texto oculto';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Foram removidos $count caracteres de texto invisível. Texto oculto como este serve para enganar os filtros de spam.',
      one:
          'Foi removido $count carácter de texto invisível. Texto oculto como este serve para enganar os filtros de spam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Texto oculto removido';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Foram removidos $count caracteres de texto invisível.',
      one: 'Foi removido $count carácter de texto invisível.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Não foi possível transferir a mensagem. Verifique a ligação à Internet e tente novamente.';

  @override
  String exportSaved(String name) {
    return '«$name» guardado';
  }

  @override
  String get exportSaveFailed => 'Não foi possível guardar a mensagem.';

  @override
  String exportFailed(String folder) {
    return 'Não foi possível exportar «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» não tem mensagens para exportar.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Não foi possível exportar «$folder»: não foi possível transferir nenhuma mensagem. Verifique a ligação à Internet e tente novamente.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '«$name» guardado sem $formattedCount mensagens que não foi possível transferir.',
      one: '«$name» guardado sem $count mensagem que não foi possível transferir.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Não foi possível guardar «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'A exportar «$folder»';
  }

  @override
  String get exportListing => 'A procurar mensagens…';

  @override
  String exportProgress(String current, String total) {
    return 'A exportar $current de $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Não foi possível transferir $formattedCount mensagens',
      one: 'Não foi possível transferir $count mensagem',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Caixas de correio';

  @override
  String get mailboxesShown => 'Visível';

  @override
  String get mailboxesHidden => 'Oculta';

  @override
  String get mailboxesCollapse => 'Recolher';

  @override
  String get mailboxesExpand => 'Expandir';

  @override
  String get mailboxesManageVips => 'Gerir VIPs';

  @override
  String get mailboxesSubscriptions => 'Subscrições';

  @override
  String mailboxesShowAccount(String account) {
    return 'Mostrar $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ocultar $account';
  }

  @override
  String get mailboxesExportFolder => 'Exportar pasta…';

  @override
  String get mailboxesUnpin => 'Desafixar';

  @override
  String get mailboxesLists => 'Listas';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Guarde uma pesquisa para a manter aqui.';

  @override
  String get mailboxesTags => 'Etiquetas';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Também pode tocar no nome de um remetente numa mensagem e ativar VIP.';

  @override
  String get mailboxesAddVip => 'Adicionar VIP…';

  @override
  String get mailboxesAddVipTitle => 'Adicionar VIP';

  @override
  String get mailboxesAddVipText => 'O e-mail deste endereço recebe uma estrela e aparece na caixa de correio VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'nome@example.com';

  @override
  String get messageListFilterUnread => 'Não lidas';

  @override
  String get messageListFilterFlagged => 'Sinalizadas';

  @override
  String get messageListFilterToMe => 'Para: mim';

  @override
  String get messageListFilterCcMe => 'Cc: mim';

  @override
  String get messageListFilterWithAttachments => 'Com anexos';

  @override
  String get messageListFilterUnreplied => 'Sem resposta';

  @override
  String get messageListFilterFromVips => 'De VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens marcadas como lidas',
      one: '$count mensagem marcada como lida',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Não foi possível carregar e-mail mais antigo.';

  @override
  String get messageListSelectMessages => 'Selecionar mensagens';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionadas',
      one: '$count selecionada',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Selecionar tudo';

  @override
  String get messageListDeselectAll => 'Desmarcar tudo';

  @override
  String get messageListLoadFailed => 'Não foi possível carregar o e-mail';

  @override
  String get messageListNoUnread => 'Sem e-mail não lido';

  @override
  String get messageListNoMatches => 'Nenhum e-mail corresponde';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrado por: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Desativar filtro';

  @override
  String get messageListEmpty => 'Sem e-mail';

  @override
  String get messageListFilter => 'Filtrar';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Critérios do filtro: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrado por:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount não lidas',
      one: '$count não lida',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marcar';

  @override
  String get messageListTrash => 'Lixo';

  @override
  String get messageListFilterTitle => 'Filtrar';

  @override
  String get messageListFilterInclude => 'INCLUIR';

  @override
  String get panesHideMailboxes => 'Ocultar caixas de correio';

  @override
  String get panesShowMailboxes => 'Mostrar caixas de correio';

  @override
  String get panesMailboxesWidth => 'Largura das caixas de correio';

  @override
  String get panesListWidth => 'Largura da lista de mensagens';

  @override
  String get panesNoMessageSelected => 'Nenhuma mensagem selecionada';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mensagens', one: '$count mensagem');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Adiadas';

  @override
  String get snoozeSheetTitle => 'Adiar';

  @override
  String get snoozeLaterToday => 'Mais tarde hoje';

  @override
  String get snoozeThisEvening => 'Esta noite';

  @override
  String get snoozeTomorrow => 'Amanhã';

  @override
  String get snoozeThisWeekend => 'Este fim de semana';

  @override
  String get snoozeNextWeek => 'Próxima semana';

  @override
  String get snoozePickDateTime => 'Escolher data e hora…';

  @override
  String get snoozeMenu => 'Adiar…';

  @override
  String get snoozeWakeNow => 'Devolver agora';

  @override
  String get snoozeChangeTimeMenu => 'Alterar hora do adiamento…';

  @override
  String get snoozeChangeTime => 'Alterar hora';

  @override
  String get snoozeNoTime => 'Sem hora definida';

  @override
  String get snoozeFooter => 'As mensagens adiadas voltam à Caixa de entrada, como não lidas, à hora marcada.';

  @override
  String get snoozeEmptyTitle => 'Nada adiado';

  @override
  String get snoozeEmptyText => 'Adie uma mensagem para que volte à Caixa de entrada quando precisar dela.';

  @override
  String get appLockUnlock => 'Desbloquear';

  @override
  String get appLockFailed => 'O Loupe não conseguiu confirmar que é você.';

  @override
  String get appLockLockedOut => 'Demasiadas tentativas. Tente novamente mais tarde.';

  @override
  String get appLockPromptError => 'Não foi possível mostrar o pedido. Tente novamente.';

  @override
  String get appLockNoScreenLock => 'Este dispositivo não tem bloqueio de ecrã.';

  @override
  String get appLockUnlockPromptTitle => 'Desbloquear o Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirme que é você para ver o seu e-mail.';

  @override
  String get appLockTurnOnPromptTitle => 'Ativar o Bloqueio da aplicação';

  @override
  String get appLockTurnOnPromptReason => 'Confirme que é você para ativar o Bloqueio da aplicação.';

  @override
  String get appLockScreenLockRemoved =>
      'O Bloqueio da aplicação foi desativado: este dispositivo já não tem bloqueio de ecrã. Configure um para voltar a ativar o Bloqueio da aplicação.';

  @override
  String get appLockAfterImmediately => 'Imediatamente';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutos', one: '$count minuto');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count horas', one: '$count hora');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Encriptada';

  @override
  String get openpgpEncryptedInPart => 'Encriptada em parte';

  @override
  String get openpgpEncryptedLocked => 'Encriptada · bloqueada';

  @override
  String get openpgpEncryptedNoKey => 'Encriptada · sem chave';

  @override
  String get openpgpEncryptedDamaged => 'Encriptada · danificada';

  @override
  String get openpgpEncryptedUnsupported => 'Encriptada · não suportada';

  @override
  String get openpgpUnknownSigner => 'desconhecido';

  @override
  String get openpgpUnknownKey => 'Chave desconhecida';

  @override
  String get openpgpSignatureInvalid => 'Assinatura inválida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Assinada por $name, não pelo remetente';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Assinada em parte por $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Assinada por $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Assinada com uma chave rejeitada';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Assinada por $name · chave não aceite';
  }

  @override
  String get openpgpUnlock => 'Desbloquear';

  @override
  String get openpgpCantDecrypt => 'Não é possível desencriptar esta mensagem';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Encriptada com OpenPGP';

  @override
  String get openpgpEncryption => 'Encriptação';

  @override
  String get openpgpDecryptedHere => 'Desencriptada neste dispositivo';

  @override
  String get openpgpNotDecrypted => 'Não desencriptada';

  @override
  String get openpgpKeyLocked => 'A sua chave está bloqueada.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Para $count chaves: $keys',
      one: 'Para $count chave: $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Assunto protegido';

  @override
  String get openpgpUnlockKey => 'Desbloquear chave';

  @override
  String get openpgpSignature => 'Assinatura';

  @override
  String get openpgpFingerprint => 'Impressão digital';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID da chave $id';
  }

  @override
  String get openpgpSigned => 'Assinada em';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Aceitação';

  @override
  String get openpgpChangeAcceptance => 'Alterar aceitação…';

  @override
  String get openpgpCheckedFooter => 'Verificado neste dispositivo com OpenPGP, compatível com o Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'A sua chave está bloqueada. Desbloqueie-a com a frase de acesso para ler esta mensagem.';

  @override
  String get openpgpSummaryNoSecretKey => 'Foi encriptada para uma chave que não está neste dispositivo.';

  @override
  String get openpgpSummaryDamaged => 'Os dados encriptados estão danificados ou foram alterados pelo caminho.';

  @override
  String get openpgpSummaryUnsupported => 'Usa um algoritmo que o Loupe não suporta.';

  @override
  String get openpgpSummaryEncrypted => 'Só você e os outros destinatários a podem ler.';

  @override
  String get openpgpSummaryNotSigned => 'Não está assinada, por isso o remetente não está confirmado.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Está assinada, mas com uma chave que não tem, por isso não é possível verificar a assinatura.';

  @override
  String get openpgpSummaryBadSignature => 'A assinatura não corresponde: a mensagem pode ter sido alterada.';

  @override
  String get openpgpSummaryMismatch =>
      'A assinatura é válida, mas a chave pertence a um endereço diferente do do remetente.';

  @override
  String get openpgpSummaryPartial =>
      'Só parte da mensagem está assinada. O texto fora da assinatura (o rodapé de uma lista de correio, por exemplo) aparece abaixo da linha «Unsigned content», e outras partes da mensagem, como os anexos, também não estão abrangidas.';

  @override
  String get openpgpSummaryOwnKey => 'Assinada com a sua própria chave.';

  @override
  String get openpgpSummaryVerified => 'A assinatura é válida e verificou a impressão digital da chave.';

  @override
  String get openpgpSummaryUnverified => 'A assinatura é válida. Aceitou a chave sem verificar a impressão digital.';

  @override
  String get openpgpSummaryRejected => 'A assinatura é válida, mas rejeitou esta chave.';

  @override
  String get openpgpSummaryUndecided =>
      'A assinatura é válida, mas ainda não aceitou esta chave. Compare a impressão digital com o remetente.';

  @override
  String get openpgpAcceptanceRejected => 'Rejeitada';

  @override
  String get openpgpAcceptanceUndecided => 'Não aceite';

  @override
  String get openpgpAcceptanceUnverified => 'Aceite';

  @override
  String get openpgpAcceptanceVerified => 'Aceite e verificada';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Aceitar a chave de $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Impressão digital $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Sim, verifiquei a impressão digital';

  @override
  String get openpgpAcceptUnverified => 'Sim, sem verificar';

  @override
  String get openpgpAcceptLater => 'Ainda não';

  @override
  String get openpgpRejectKey => 'Rejeitar esta chave';

  @override
  String get openpgpNoSubject => '(sem assunto)';

  @override
  String get openpgpEncryptionTitle => 'Encriptação ponta a ponta';

  @override
  String get openpgpMyKeys => 'As minhas chaves OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Com uma chave, pode ler e-mail encriptado e assinar e encriptar o seu. Usa o Thunderbird? Exporte lá a sua chave (Definições da conta › Encriptação ponta-a-ponta › Exportar chave secreta) e importe-a aqui.';

  @override
  String get openpgpAddKey => 'Adicionar chave…';

  @override
  String get openpgpAddresses => 'Endereços';

  @override
  String get openpgpAddressesFooter => 'A chave que cada endereço usa e quando encripta e assina.';

  @override
  String get openpgpCorrespondentsKeys => 'Chaves OpenPGP dos correspondentes';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Aceite uma chave quando confiar que pertence ao seu dono; compare a impressão digital com essa pessoa para a marcar como verificada.';

  @override
  String get openpgpImportPublicKey => 'Importar chave pública…';

  @override
  String get openpgpCollected => 'Obtidas através do Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Chaves que chegaram com mensagens. O Loupe pode encriptar para elas quando ambos os lados o pedem.';

  @override
  String get openpgpOnThisDevice => 'Neste dispositivo';

  @override
  String get openpgpOnThisDeviceFooter =>
      'As mensagens encriptadas escondem o assunto. O Loupe guarda o assunto de cada mensagem que abre na sua base de dados encriptada neste dispositivo, para que a lista, a pesquisa e as notificações o mostrem. Em segundo plano, o Loupe também pode desencriptar os assuntos de novas mensagens com chaves sem frase de acesso; para isso, transfere cada mensagem (até 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Desencriptar assuntos em segundo plano';

  @override
  String get openpgpIndexFooter =>
      'A pesquisa encontra mensagens encriptadas pelo remetente, pelos destinatários e pelo assunto. Com esta opção ativada, o Loupe também adiciona o texto de cada mensagem encriptada que desencripta ao índice de pesquisa da sua base de dados encriptada neste dispositivo, para que a pesquisa a encontre também pelo texto. Desativá-la remove esse texto do índice.';

  @override
  String get openpgpIndexDecrypted => 'Indexar mensagens desencriptadas para pesquisa';

  @override
  String get openpgpPassphrases => 'Frases de acesso';

  @override
  String get openpgpPassphrasesFooter =>
      'As chaves OpenPGP e os certificados S/MIME que protege com uma frase de acesso são desbloqueados quando necessário. Sem «Lembrar», voltam a ser bloqueados dois minutos após cada utilização.';

  @override
  String get openpgpRememberPassphrases => 'Lembrar frases de acesso';

  @override
  String get openpgpRememberPassphrasesDetail => 'Até o Loupe fechar';

  @override
  String get openpgpLockKeysNow => 'Bloquear chaves agora';

  @override
  String get openpgpKeysLocked => 'Chaves bloqueadas.';

  @override
  String get openpgpKeyStateRevoked => 'revogada';

  @override
  String get openpgpKeyStateExpired => 'expirada';

  @override
  String get openpgpKeyStateNeverExpires => 'nunca expira';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'expira em $date';
  }

  @override
  String get openpgpNoKey => 'Sem chave';

  @override
  String get openpgpAlwaysEncrypt => 'Encriptar sempre';

  @override
  String get openpgpAddKeyTitle => 'Adicionar uma chave OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importe a chave que usa no Thunderbird ou crie uma nova.';

  @override
  String get openpgpImportFromClipboard => 'Importar da área de transferência';

  @override
  String get openpgpImportFromFile => 'Importar de ficheiro';

  @override
  String get openpgpGenerateNewKey => 'Gerar nova chave';

  @override
  String get openpgpImportPublicKeyTitle => 'Importar uma chave pública';

  @override
  String get openpgpFromClipboard => 'Da área de transferência';

  @override
  String get openpgpFromFile => 'De ficheiro';

  @override
  String get openpgpClipboardEmpty => 'A área de transferência está vazia. Copie primeiro a chave.';

  @override
  String get openpgpKey => 'Chave';

  @override
  String get openpgpValidityRevoked => 'Revogada';

  @override
  String openpgpValidityExpired(String date) {
    return 'Expirou em $date';
  }

  @override
  String get openpgpNeverExpires => 'Nunca expira';

  @override
  String openpgpValidUntil(String date) {
    return 'Válida até $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Impressão digital copiada.';

  @override
  String get openpgpAlgorithm => 'Algoritmo';

  @override
  String get openpgpCreated => 'Criada';

  @override
  String get openpgpValidity => 'Validade';

  @override
  String get openpgpProtection => 'Proteção';

  @override
  String get openpgpProtectionPassphrase => 'Frase de acesso';

  @override
  String get openpgpProtectionKeychain => 'Só o armazenamento seguro';

  @override
  String get openpgpKeyDetailsFooter =>
      'Partilhe a sua chave pública para que outros possam encriptar para si. A cópia de segurança é a sua chave secreta, protegida pela frase de acesso, se tiver uma: mantenha-a privada.';

  @override
  String get openpgpSharePublicKey => 'Partilhar chave pública';

  @override
  String get openpgpCopyPublicKey => 'Copiar chave pública';

  @override
  String get openpgpPublicKeyCopied => 'Chave pública copiada.';

  @override
  String get openpgpBackUpSecretKey => 'Fazer cópia de segurança da chave secreta';

  @override
  String get openpgpDeleteKey => 'Eliminar chave';

  @override
  String get openpgpRemoveKey => 'Remover chave';

  @override
  String get openpgpBackUpTitle => 'Fazer cópia de segurança da chave secreta?';

  @override
  String get openpgpBackUpProtected =>
      'A cópia de segurança está protegida pela frase de acesso da sua chave. Quem tiver as duas pode ler o seu e-mail.';

  @override
  String get openpgpBackUpUnprotected =>
      'Esta chave não tem frase de acesso: quem tiver a cópia de segurança pode ler o seu e-mail e assinar em seu nome.';

  @override
  String get openpgpBackUp => 'Fazer cópia';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Eliminar a sua chave $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Remover a chave de $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'O e-mail encriptado para esta chave deixa de poder ser lido neste dispositivo, a não ser que a volte a importar.';

  @override
  String get openpgpRemoveKeyMessage => 'Pode voltar a importá-la mais tarde.';

  @override
  String get openpgpKeyHeader => 'Chave OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Adicione uma chave em Encriptação ponta a ponta para encriptar e assinar o e-mail deste endereço.';

  @override
  String get openpgpGenerateAKey => 'Gerar uma chave…';

  @override
  String get openpgpSending => 'Envio';

  @override
  String get openpgpSendingFooter =>
      'A encriptação automática é ativada quando todos os destinatários têm uma chave aceite ou um certificado fidedigno, ou quando o Autocrypt indica que ambos os lados a querem. O e-mail encriptado é sempre assinado.';

  @override
  String get openpgpEncryptAutomatically => 'Encriptar automaticamente';

  @override
  String get openpgpAlwaysEncryptDetail => 'Recusa enviar quando um destinatário não tem chave';

  @override
  String get openpgpSignUnencrypted => 'Assinar e-mail não encriptado';

  @override
  String get openpgpAttachPublicKey => 'Anexar a minha chave pública';

  @override
  String get openpgpAutocryptFooter =>
      'O Autocrypt envia a sua chave pública com cada mensagem, para que outras aplicações possam encriptar para si sem qualquer configuração.';

  @override
  String get openpgpSendMyKey => 'Enviar a minha chave com o e-mail';

  @override
  String get openpgpPreferEncryption => 'Preferir encriptação';

  @override
  String get openpgpPreferEncryptionDetail => 'Pedir aos outros que encriptem quando puderem';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count anos', one: '$count ano');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'As frases de acesso não coincidem.';

  @override
  String openpgpKeyReady(String id) {
    return 'A sua chave $id está pronta.';
  }

  @override
  String get openpgpNewKey => 'Nova chave';

  @override
  String get openpgpNewKeyFor => 'Para';

  @override
  String get openpgpYourName => 'O seu nome';

  @override
  String get openpgpAddress => 'Endereço';

  @override
  String get openpgpPassphrase => 'Frase de acesso';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opcional. Sem ela, só o armazenamento seguro do dispositivo protege a chave e o Loupe nunca a pede. Com ela, o Loupe pede-a quando a chave é necessária.';

  @override
  String get openpgpRepeatPassphrase => 'Repetir';

  @override
  String get openpgpExpires => 'Expira';

  @override
  String get openpgpExpiresFooter =>
      'Pode criar uma nova chave antes de esta expirar. O Thunderbird também usa três anos.';

  @override
  String get openpgpGenerateKey => 'Gerar chave';

  @override
  String get openpgpKeyFor => 'Chave para';

  @override
  String get openpgpCantEncrypt => 'Não é possível encriptar';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Não há nenhuma chave OpenPGP para $names, e este endereço encripta sempre. Remova o destinatário ou importe a respetiva chave em Definições › Encriptação ponta a ponta.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Não há nenhum certificado S/MIME válido para $names, e este endereço encripta sempre. Remova o destinatário ou importe o respetivo certificado em Definições › Encriptação ponta a ponta.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Não há nenhuma chave OpenPGP para $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Não há nenhum certificado S/MIME válido para $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Enviar sem encriptação';

  @override
  String get openpgpCantSign => 'Não é possível assinar';

  @override
  String get openpgpCantSignMessage =>
      'A chave privada do seu certificado S/MIME não está neste dispositivo. Volte a importar o certificado (um ficheiro .p12 ou .pfx) em Definições › Encriptação ponta a ponta.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Sem chave para $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sem certificado para $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Chaves do Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Todos têm uma chave';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Todos têm um certificado';

  @override
  String get openpgpComposeEncrypt => 'Encriptar';

  @override
  String get openpgpComposeSign => 'Assinar';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, alternar';
  }

  @override
  String get openpgpNoKeyFound => 'Nenhuma chave OpenPGP encontrada.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importar uma chave secreta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Este anexo contém uma chave secreta ($names). Importe-a como sua apenas se a tiver exportado você mesmo, do Thunderbird, por exemplo.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importar como minha chave';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'a sua chave $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importar $count chaves ($names)?',
      one: 'Importar $count chave ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importar e aceitar';

  @override
  String get openpgpImportDecideLater => 'Importar e decidir depois';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'a chave de $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importou $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Estão anexadas $count chaves OpenPGP.',
      one: 'Está anexada $count chave OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importar';

  @override
  String get openpgpUnlockKeyTitle => 'Desbloquear chave OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Introduza a frase de acesso da chave de $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Essa frase de acesso está errada. Tente novamente.';

  @override
  String get openpgpExplainLocked => 'Esta mensagem está encriptada. Desbloqueie a sua chave OpenPGP para a ler.';

  @override
  String get openpgpExplainNoKey =>
      'Esta mensagem está encriptada, mas não para nenhuma chave OpenPGP deste dispositivo. Se a lê no Thunderbird, importe a sua chave de lá: Definições › Encriptação ponta a ponta.';

  @override
  String get openpgpExplainDamaged =>
      'Esta mensagem encriptada está danificada, por isso não pode ser desencriptada com segurança.';

  @override
  String get openpgpExplainUnsupported => 'Esta mensagem usa uma encriptação que o Loupe ainda não consegue ler.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Esta mensagem está encriptada com S/MIME, mas não para nenhum certificado deste dispositivo. Importe o seu certificado (um ficheiro .p12 ou .pfx) em Definições › Encriptação ponta a ponta.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Esta mensagem está encriptada. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Desbloqueie o seu certificado S/MIME para a ler.';

  @override
  String get openpgpAttachmentGone => 'Este anexo já não está disponível.';

  @override
  String get smimeEncrypted => 'Encriptada (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Encriptada (S/MIME) · sem certificado';

  @override
  String get smimeEncryptedDamaged => 'Encriptada (S/MIME) · danificada';

  @override
  String get smimeEncryptedUnsupported => 'Encriptada (S/MIME) · não suportada';

  @override
  String get smimeEncryptedLocked => 'Encriptada (S/MIME) · bloqueada';

  @override
  String get smimeUnknownSigner => 'desconhecido';

  @override
  String get smimeSignatureModified => 'Assinatura inválida: mensagem alterada';

  @override
  String get smimeSignatureWeak => 'Assinatura insegura: algoritmo desatualizado';

  @override
  String get smimeSignatureUncheckable => 'Não é possível verificar a assinatura';

  @override
  String get smimeSignedCertificateMissing => 'Assinada · certificado em falta';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Assinada por $name · certificado revogado';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Assinada por $name · noutra data';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Assinada por $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Assinada por $name · certificado inválido';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Assinada por $name · não fidedigno';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Assinada por $name · certificado expirado';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Assinada por $name · certificado ainda não válido';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Assinada por $name · certificado não destinado a e-mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Assinada por $name, não pelo remetente';
  }

  @override
  String get smimeCantDecrypt => 'Não é possível desencriptar esta mensagem';

  @override
  String get smimeEncryptedWithSmime => 'Encriptada com S/MIME';

  @override
  String get smimeEncryption => 'Encriptação';

  @override
  String get smimeDecryptedHere => 'Desencriptada neste dispositivo';

  @override
  String get smimeNotDecrypted => 'Não desencriptada';

  @override
  String get smimeAuthenticated => 'autenticada';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'para $count certificados',
      one: 'para $count certificado',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Assinatura';

  @override
  String get smimeIssuedBy => 'Emitido por';

  @override
  String get smimeValid => 'Validade';

  @override
  String smimeValidRange(String from, String to) {
    return '$from a $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Impressão digital SHA-256';

  @override
  String get smimeSigned => 'Assinada em';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'A verificar a revogação…';

  @override
  String get smimeNotRevoked => 'Não revogado';

  @override
  String get smimeRevoked => 'Revogado';

  @override
  String get smimeRevocationUnknown => 'Revogação desconhecida';

  @override
  String smimeRevokedSince(String date) {
    return 'Desde $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Autoridade consultada (lista de revogação), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Autoridade consultada (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Confiar em «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Confiar neste certificado…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Verificado neste dispositivo com S/MIME, compatível com o Outlook e o Thunderbird; revogação verificada junto da autoridade de certificação.';

  @override
  String get smimeCheckedFooter =>
      'Verificado neste dispositivo com S/MIME, compatível com o Outlook e o Thunderbird. A revogação não é verificada (Definições › Encriptação ponta a ponta).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Confiar em $name para e-mail?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Confiar no certificado de $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Todos os certificados emitidos por esta autoridade passam a ser fidedignos, como a AC da sua empresa. Compare primeiro a impressão digital com o respetivo dono:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Compare primeiro a impressão digital com o respetivo dono:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Confiar';

  @override
  String get smimeSummaryNoKey => 'Foi encriptada para um certificado que não está neste dispositivo.';

  @override
  String get smimeSummaryDamaged => 'Os dados encriptados estão danificados ou foram alterados pelo caminho.';

  @override
  String get smimeSummaryUnsupported => 'Usa um algoritmo que o Loupe não suporta.';

  @override
  String get smimeSummaryLocked => 'O seu certificado S/MIME está bloqueado.';

  @override
  String get smimeSummaryEncrypted => 'Só você e os outros destinatários a podem ler.';

  @override
  String get smimeSummaryNotSigned => 'Não está assinada, por isso o remetente não está confirmado.';

  @override
  String get smimeSummaryModified => 'A assinatura não corresponde: a mensagem foi alterada depois de ser assinada.';

  @override
  String get smimeSummaryUncheckable => 'Não é possível verificar a assinatura.';

  @override
  String get smimeSummaryNoCertificate =>
      'O certificado do signatário não está na mensagem, por isso não é possível verificá-la.';

  @override
  String get smimeSummaryRevoked =>
      'A autoridade de certificação revogou o certificado do signatário: não se pode confiar na assinatura.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'A autoridade de certificação revogou o certificado do signatário ($reason): não se pode confiar na assinatura.';
  }

  @override
  String get smimeDateMismatch =>
      'Foi assinada mais de uma hora antes ou depois da data da mensagem: pode ser uma mensagem antiga reenviada.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'A assinatura é válida e $issuer garante que o certificado pertence ao remetente.';
  }

  @override
  String get smimeProblemInvalidChain => 'O certificado ou um dos seus emissores é inválido.';

  @override
  String get smimeProblemUntrusted => 'O certificado vem de uma autoridade em que o Loupe não confia.';

  @override
  String get smimeProblemExpired => 'O certificado tinha expirado.';

  @override
  String get smimeProblemNotYetValid => 'O certificado ainda não era válido.';

  @override
  String get smimeProblemWrongUsage => 'O certificado não se destina a e-mail.';

  @override
  String get smimeProblemWrongAddress => 'O certificado pertence a um endereço diferente do do remetente.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Fidedigno · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Não fidedigno · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Expirou em $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Válido a partir de $date';
  }

  @override
  String get smimeTrustInvalid => 'Inválido';

  @override
  String get smimeTrustNotForMail => 'Não destinado a e-mail';

  @override
  String get smimeTrustAnotherAddress => 'Outro endereço';

  @override
  String get smimeMyCertificates => 'Os meus certificados S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Para S/MIME, tal como o usam o Outlook e muitas empresas. Importe o seu certificado com a chave privada (um ficheiro .p12 ou .pfx), exportado do Outlook, do Windows, do macOS ou do Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Para S/MIME, tal como o usam o Outlook e muitas empresas. Importe o seu certificado com a chave privada (um ficheiro .p12 ou .pfx), exportado do Outlook, do Windows, do macOS ou do Thunderbird, ou use um que a sua empresa ou você tenha instalado neste dispositivo.';

  @override
  String get smimeCertificateExpired => 'expirado';

  @override
  String smimeCertificateUntil(String date) {
    return 'até $date';
  }

  @override
  String get smimeCertificateOnDevice => 'neste dispositivo';

  @override
  String get smimeImportCertificateEllipsis => 'Importar certificado…';

  @override
  String get smimeUseDeviceCertificate => 'Usar um certificado deste dispositivo…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificados dos correspondentes';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Obtidos a partir de e-mail assinado, tal como fazem o Outlook e o Thunderbird. O e-mail só é encriptado para certificados fidedignos: o Loupe confia nas autoridades em que a Mozilla confia para e-mail e nas que adicionar.';

  @override
  String get smimeRevocation => 'Revogação';

  @override
  String get smimeRevocationFooter =>
      'Quando abre e-mail assinado, o Loupe pergunta à autoridade que emitiu o certificado do signatário se este foi revogado (através do respetivo serviço OCSP ou da lista de revogação). A autoridade pode assim saber quando alguém no seu endereço de Internet lê e-mail assinado com esse certificado. As respostas ficam guardadas neste dispositivo até expirarem. Um certificado revogado aparece como «certificado revogado» no cabeçalho da mensagem.';

  @override
  String get smimeCheckRevocation => 'Verificar a revogação de certificados online';

  @override
  String get smimeTrustedAuthorities => 'Autoridades fidedignas';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Autoridades em que confia, além das $count em que a Mozilla confia para e-mail.',
      one: 'Autoridades em que confia, além da $count em que a Mozilla confia para e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoridade de certificação';

  @override
  String get smimeImportACertificate => 'Importar um certificado';

  @override
  String get smimeImportContactMessage =>
      'O certificado de um correspondente (.cer, .crt, .pem) ou de uma autoridade de certificação.';

  @override
  String get smimeFromClipboard => 'Da área de transferência';

  @override
  String get smimeFromFile => 'De ficheiro';

  @override
  String get smimeClipboardEmpty => 'A área de transferência está vazia. Copie primeiro o certificado.';

  @override
  String get smimeCertificate => 'Certificado';

  @override
  String get smimeOnDeviceFooter =>
      'A chave privada fica no armazenamento de credenciais do Android, onde a sua empresa ou você a instalou: o Loupe pede ao Android que assine e desencripte com ela. O e-mail assinado é assinado no momento do envio.';

  @override
  String get smimeAddresses => 'Endereços';

  @override
  String get smimeUsage => 'Para';

  @override
  String get smimeUsageNone => 'Nada que o Loupe use';

  @override
  String get smimeUsageSigning => 'Assinatura';

  @override
  String get smimeUsageEncryption => 'Encriptação';

  @override
  String get smimeUsageCertificates => 'Certificados';

  @override
  String get smimeAlgorithm => 'Algoritmo';

  @override
  String get smimeSerialNumber => 'Número de série';

  @override
  String get smimeFingerprintCopied => 'Impressão digital copiada.';

  @override
  String get smimeSha1Thumbprint => 'Impressão digital SHA-1';

  @override
  String get smimePrivateKey => 'Chave privada';

  @override
  String get smimeKeyOnDevice => 'Neste dispositivo';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'No Loupe, com frase de acesso';

  @override
  String get smimeKeyInLoupe => 'No Loupe';

  @override
  String get smimeSource => 'Origem';

  @override
  String get smimeSourceSignedMail => 'E-mail assinado';

  @override
  String get smimeSourceImported => 'Importado';

  @override
  String get smimeTrustHeader => 'Confiança';

  @override
  String get smimeTrustedRoot => 'Raiz fidedigna';

  @override
  String get smimeIssuer => 'Emissor';

  @override
  String smimeTrustNamed(String name) {
    return 'Confiar em «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Confiar nesta autoridade';

  @override
  String get smimeTrustThisCertificate => 'Confiar neste certificado';

  @override
  String get smimeStopTrusting => 'Deixar de confiar';

  @override
  String get smimePassphrase => 'Frase de acesso';

  @override
  String get smimePassphraseFooter =>
      'Opcional. Com uma frase de acesso, a chave privada é também encriptada neste dispositivo (Argon2id e AES-256), e o Loupe pede-a para assinar e desencriptar; Lembrar frases de acesso define durante quanto tempo. O e-mail que envia é assinado no momento do envio; as tarefas em segundo plano não podem usar a chave.';

  @override
  String get smimeChangePassphrase => 'Alterar frase de acesso…';

  @override
  String get smimeSetPassphraseEllipsis => 'Definir frase de acesso…';

  @override
  String get smimeRemovePassphrase => 'Remover frase de acesso';

  @override
  String get smimeShareCertificate => 'Partilhar certificado';

  @override
  String get smimeDeleteCertificate => 'Eliminar certificado';

  @override
  String get smimeRemoveCertificate => 'Remover certificado';

  @override
  String get smimePassphraseChanged => 'Frase de acesso alterada.';

  @override
  String get smimePassphraseSet => 'Frase de acesso definida.';

  @override
  String get smimeRemovePassphraseTitle => 'Remover a frase de acesso?';

  @override
  String get smimeRemovePassphraseMessage =>
      'A chave privada passa então a estar protegida apenas pelo armazenamento seguro, como sem frase de acesso: o Loupe deixa de a pedir e as tarefas em segundo plano podem usá-la.';

  @override
  String get smimePassphraseRemoved => 'Frase de acesso removida.';

  @override
  String smimeTrustTitle(String name) {
    return 'Confiar em $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Todos os certificados que emitir passam a ser fidedignos para e-mail. Compare primeiro a impressão digital com o respetivo dono:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Eliminar o seu certificado $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Remover o certificado de $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'O Loupe deixa de o usar: o e-mail encriptado para ele deixa de poder ser lido no Loupe. O certificado continua neste dispositivo (Definições › Segurança › Encriptação e credenciais).';

  @override
  String get smimeDeleteOwnMessage =>
      'A chave privada é eliminada deste dispositivo: o e-mail encriptado para ele deixa de poder ser lido aqui, a não ser que o volte a importar.';

  @override
  String get smimeRemoveContactMessage => 'Volta com a próxima mensagem assinada dessa pessoa.';

  @override
  String get smimeAddressImportFooter =>
      'Importe um certificado para este endereço para assinar e encriptar com S/MIME, tal como faz o Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importar um certificado…';

  @override
  String get smimePreferFooter =>
      'Quando ambos podem proteger uma mensagem, é usado o preferido, a não ser que só o outro tenha uma chave ou um certificado para todos os destinatários.';

  @override
  String get smimePreferSmime => 'Preferir S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Em vez de OpenPGP';

  @override
  String get smimeCertificatePassword => 'Palavra-passe do certificado';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Introduza a palavra-passe com que o ficheiro do certificado foi exportado.';

  @override
  String get smimeImport => 'Importar';

  @override
  String get smimeWrongPassword => 'Essa palavra-passe está errada. Tente novamente.';

  @override
  String get smimeNoCertificateFound => 'Nenhum certificado encontrado.';

  @override
  String smimeCertificateOf(String name) {
    return 'o certificado de $name';
  }

  @override
  String get smimeNothingNew => 'Nada de novo para importar.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importou $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importou $count autoridades fidedignas.',
      one: 'Importou $count autoridade fidedigna.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importou $certificates e $count autoridades fidedignas.',
      one: 'Importou $certificates e $count autoridade fidedigna.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Este ficheiro não tem chave privada. Exporte o seu certificado com a chave privada.';

  @override
  String get smimeImportAsYoursTitle => 'Importar como o seu certificado?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Este anexo contém um certificado com a respetiva chave privada: $names. Importe-o apenas se o tiver exportado você mesmo, do Outlook ou do Thunderbird, por exemplo.';
  }

  @override
  String get smimeImportAsMine => 'Importar como meu certificado';

  @override
  String smimeImportedOwn(String names) {
    return 'Importou o seu certificado $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Adicionou o seu certificado $name ($addresses) a partir deste dispositivo.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Confiar em «$name» para e-mail?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'O Loupe não conhece esta autoridade de certificação (talvez seja a de uma empresa). Confie nela para verificar os certificados que emite. Compare primeiro a impressão digital com o seu departamento de informática:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Estão anexados $count certificados.',
      one: 'Está anexado $count certificado.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importar certificado';

  @override
  String get smimeUnlockTitle => 'Desbloquear certificado S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Introduza a frase de acesso do certificado de $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Essa frase de acesso está errada. Tente novamente.';

  @override
  String get smimeUnlock => 'Desbloquear';

  @override
  String get smimeEnterAPassphrase => 'Introduza uma frase de acesso.';

  @override
  String get smimePassphrasesDiffer => 'As duas frases de acesso são diferentes.';

  @override
  String get smimeSetPassphraseTitle => 'Definir frase de acesso';

  @override
  String get smimeSetPassphraseText =>
      'O Loupe vai pedi-la para assinar e desencriptar. Se a esquecer, volte a importar o certificado a partir do ficheiro .p12.';

  @override
  String get smimePassphraseAgain => 'Novamente';

  @override
  String get smimeSetPassphraseButton => 'Definir';

  @override
  String get smimeLockedOpenAgain =>
      'O seu certificado S/MIME está bloqueado. Abra novamente a mensagem para o desbloquear.';

  @override
  String get smimeDeviceHasNoCertificates => 'Este dispositivo não disponibiliza os seus certificados.';

  @override
  String get smimeCantReadCertificate => 'O Loupe não consegue ler este certificado.';

  @override
  String get smimeCertificateNotForMail =>
      'Este certificado não se destina a e-mail: não tem endereço de e-mail ou não serve para assinar nem encriptar.';

  @override
  String get smimeDeviceCertificateGone =>
      'O certificado já não está neste dispositivo, ou o Loupe já não o pode usar. Escolha-o novamente em Definições › Encriptação ponta a ponta.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'O certificado deste dispositivo só pode ser usado enquanto o Loupe estiver aberto.';

  @override
  String get smimeDeviceKeyDamaged => 'A chave encriptada está danificada.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'O certificado deste dispositivo não consegue fazer isto: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'não suportado';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'O certificado deste dispositivo falhou: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'O endereço da autoridade não é um endereço web.';

  @override
  String get smimeAuthorityTimeout => 'A autoridade de certificação não respondeu a tempo.';

  @override
  String get smimeAuthorityUnreachable => 'Não foi possível contactar a autoridade de certificação.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'A autoridade de certificação respondeu $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'A resposta da autoridade de certificação é demasiado grande.';

  @override
  String get smimeRevocationNotChecked =>
      'Não verificado: só são verificados os certificados de autoridades em que o Loupe confia.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Idioma do dispositivo';

  @override
  String get settingsLanguageFooter =>
      'O Loupe usa o idioma do seu dispositivo quando o tem, e inglês quando não o tem. O idioma que escolher aqui aplica-se apenas ao Loupe, incluindo as notificações.';

  @override
  String get settingsAccountsHeader => 'Contas';

  @override
  String get settingsAddAccount => 'Adicionar conta';

  @override
  String get settingsMailHeader => 'E-mail';

  @override
  String get settingsSwipeActions => 'Ações de deslizar';

  @override
  String get settingsSwipeLeft => 'Deslizar para a esquerda';

  @override
  String get settingsSwipeLeftFooter =>
      'Um deslize completo executa esta ação. Sinalizar e Mais estão sempre à distância de um deslize curto.';

  @override
  String get settingsSwipeRight => 'Deslizar para a direita';

  @override
  String get settingsSwipeRightFooter => 'Um deslize completo executa esta ação.';

  @override
  String get settingsSwipeToggleRead => 'Marcar como lida / não lida';

  @override
  String get settingsSwipeTrash => 'Mover para o Lixo';

  @override
  String get settingsSwipeMove => 'Mover mensagem';

  @override
  String get settingsSwipeSnooze => 'Adiar';

  @override
  String get settingsThreaded => 'Organizar por conversa';

  @override
  String get settingsUndoSendDelay => 'Tempo para anular o envio';

  @override
  String get settingsUndoSendDelayFooter => 'As mensagens enviadas esperam este tempo, para que as possa recuperar.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds segundos',
      one: '$seconds segundo',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Aparência';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automático';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsDensity => 'Lista de mensagens';

  @override
  String get settingsDensityComfortable => 'Confortável';

  @override
  String get settingsDensityCompact => 'Compacta';

  @override
  String get settingsReadingHeader => 'Leitura';

  @override
  String get settingsReadingFooter =>
      'As imagens remotas podem revelar aos remetentes quando e onde abriu uma mensagem.';

  @override
  String get settingsDefaultView => 'Vista predefinida';

  @override
  String get settingsDefaultViewFooter => 'Pode mudar a vista de qualquer mensagem com o botão Aa.';

  @override
  String get settingsViewReadable => 'Legível';

  @override
  String get settingsViewReadableDetail => 'Limpa, legível, acompanha o modo escuro';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exatamente como o remetente a criou';

  @override
  String get settingsViewPlain => 'Texto simples';

  @override
  String get settingsViewPlainDetail => 'Só as palavras';

  @override
  String get settingsPlainTextFont => 'Tipo de letra do texto simples';

  @override
  String get settingsFontSans => 'Sem serifa';

  @override
  String get settingsFontMono => 'Monoespaçado';

  @override
  String get settingsFontMonoDetail => 'Mantém alinhadas as tabelas e a arte ASCII';

  @override
  String get settingsTechnicalLists => 'Listas técnicas';

  @override
  String get settingsLoadRemoteImages => 'Carregar imagens remotas';

  @override
  String get settingsOpenLinksDirectly => 'Abrir ligações diretamente';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Saltar os rastreadores de cliques quando o destino é conhecido';

  @override
  String get settingsSecurityHeader => 'Segurança';

  @override
  String get settingsAppLock => 'Bloqueio da aplicação';

  @override
  String get settingsAppLockFooterOn =>
      'O Loupe pede-o ao iniciar e quando volta após uma ausência superior ao tempo de «Bloquear após».';

  @override
  String get settingsAppLockFooterOff =>
      'O Bloqueio da aplicação pede a sua impressão digital, rosto ou bloqueio de ecrã antes de mostrar o seu e-mail.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'O Bloqueio da aplicação continua desativado. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configurar um código';

  @override
  String get settingsScreenLockTextIos =>
      'O Bloqueio da aplicação usa o Face ID, o Touch ID ou o código, e este iPhone não tem código. Configure um na aplicação Definições e depois ative o Bloqueio da aplicação.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configurar um bloqueio de ecrã';

  @override
  String get settingsScreenLockTextAndroid =>
      'O Bloqueio da aplicação usa o bloqueio de ecrã do dispositivo, ou uma impressão digital ou um rosto adicionados a ele, e este dispositivo não tem nenhum. Configure um PIN, padrão ou palavra-passe nas definições do Android e depois ative o Bloqueio da aplicação.';

  @override
  String get settingsOpenSystemSettings => 'Abrir Definições';

  @override
  String get settingsOpenAndroidSettings => 'Abrir definições do Android';

  @override
  String get settingsLockAfter => 'Bloquear após';

  @override
  String get settingsLockAfterFooter => 'Quanto tempo o Loupe pode estar em segundo plano antes de voltar a pedir.';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsEncryption => 'Encriptação ponta a ponta';

  @override
  String get settingsAdvanced => 'Avançadas';

  @override
  String get settingsDemoHeader => 'Demonstração';

  @override
  String get settingsDemoFooter =>
      'O e-mail de demonstração é uma caixa de correio fictícia que existe apenas neste dispositivo. Nada é enviado para lado nenhum.';

  @override
  String get settingsDemoMode => 'Modo de demonstração';

  @override
  String get settingsResetApp => 'Repor aplicação';

  @override
  String get settingsResetFooter => 'Esquece todas as definições e volta ao ecrã de boas-vindas.';

  @override
  String get settingsResetTitle => 'Repor o Loupe?';

  @override
  String get settingsResetMessage =>
      'Esta ação esquece todas as definições, Smart Mailboxes e pesquisas recentes, e volta ao ecrã de boas-vindas.';

  @override
  String get settingsAboutHeader => 'Sobre';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicences => 'Licenças';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsPrivacyDetail =>
      'O Loupe não tem estatísticas nem rastreio. O seu e-mail vai apenas para os seus servidores de e-mail.';

  @override
  String get settingsNotificationsOffIos => 'As notificações do Loupe estão desativadas nas Definições.';

  @override
  String get settingsNotificationsOffAndroid => 'As notificações do Loupe estão desativadas nas definições do Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return 'O $system não permite que o Loupe mostre notificações. Permita-as nas Definições.';
  }

  @override
  String get settingsNewMailHeader => 'E-mail novo';

  @override
  String get settingsNewMailFooterDemo =>
      'O e-mail de demonstração não chega em segundo plano. Envie uma notificação de teste para ver como aparece o e-mail novo.';

  @override
  String get settingsNewMailFooterIos =>
      'O Loupe procura e-mail novo em segundo plano quando o iOS o permite, o que pode acontecer com horas de intervalo nas aplicações que não abre com frequência. É avisado das novas mensagens nas suas caixas de entrada e das mensagens de VIPs em qualquer pasta.';

  @override
  String get settingsNewMailFooterAndroid =>
      'O Loupe procura e-mail novo aproximadamente a cada 15 minutos, quando o Android o permite. É avisado das novas mensagens nas suas caixas de entrada e das mensagens de VIPs em qualquer pasta.';

  @override
  String get settingsNoAccounts => 'Sem contas';

  @override
  String get settingsVipOnly => 'Só VIP';

  @override
  String get settingsVipOnlyDetail => 'Apenas mensagens dos seus VIPs';

  @override
  String get settingsHideContent => 'Ocultar conteúdo';

  @override
  String get settingsHideContentFooterOn =>
      'As notificações dizem apenas «Nova mensagem de» e a conta, sem indicar quem escreveu nem sobre o quê.';

  @override
  String get settingsHideContentFooterOff =>
      'Ocultar conteúdo mantém o remetente, o assunto e a pré-visualização fora do ecrã de bloqueio e das notificações.';

  @override
  String get settingsBackgroundAppRefresh => 'Atualização em segundo plano';

  @override
  String get settingsBackgroundRefreshFooter =>
      'O e-mail novo só chega em segundo plano enquanto a Atualização em segundo plano estiver ativada para o Loupe nas Definições. O iOS não permite manter uma ligação aberta às suas caixas de entrada, por isso não há Entrega instantânea.';

  @override
  String get settingsInstantDelivery => 'Entrega instantânea';

  @override
  String get settingsInstantDeliveryFooter =>
      'A Entrega instantânea (experimental) mantém uma ligação aberta às suas caixas de entrada, para que o e-mail novo chegue em segundos. Mostra uma notificação discreta «À espera de e-mail novo» e gasta mais bateria.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'O Android pode parar a Entrega instantânea para poupar bateria. Permita que o Loupe use a bateria sem restrições para a manter a funcionar.';

  @override
  String get settingsExperimental => 'Experimental';

  @override
  String get settingsComingSoon => 'Em breve';

  @override
  String get settingsAllowUnrestrictedBattery => 'Permitir utilização da bateria sem restrições';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'O push permite que o e-mail novo acorde o Loupe de imediato, se o seu serviço de e-mail o suportar. Os pushes passam pelo serviço de push da Google e não transportam e-mail, apenas «verifique agora».';

  @override
  String get settingsPushUnavailableFooter =>
      'Este dispositivo não pode receber pushes: precisam dos serviços do Google Play e de uma ligação de rede. O Loupe continua a procurar e-mail aproximadamente a cada 15 minutos.';

  @override
  String get settingsCopyPushToken => 'Copiar token de push';

  @override
  String get settingsPushTokenCopied => 'Token de push copiado';

  @override
  String get settingsSendTestNotification => 'Enviar notificação de teste';

  @override
  String get settingsAppIconBadge => 'Emblema no ícone da aplicação';

  @override
  String get settingsBadgeNote => 'O emblema é atualizado sempre que o Loupe procura e-mail, também em segundo plano.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'O ecrã principal deste dispositivo não mostra números nos ícones das aplicações. O emblema é atualizado sempre que o Loupe procura e-mail, também em segundo plano.';

  @override
  String get settingsTestNotificationBody => 'As notificações de e-mail novo são assim.';

  @override
  String get settingsAccountRemoved => 'Esta conta foi removida.';

  @override
  String get settingsAccountHeader => 'Conta';

  @override
  String get settingsAccountDescription => 'Descrição';

  @override
  String get settingsAccountDescriptionHint => 'Trabalho, Pessoal…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Cor';

  @override
  String get settingsColourFooter => 'Identifica as mensagens desta conta em Todas as caixas de entrada.';

  @override
  String settingsColourNumber(int number) {
    return 'Cor $number';
  }

  @override
  String get settingsSendingHeader => 'Envio';

  @override
  String get settingsSendingFooter =>
      'Cada identidade tem a sua própria assinatura. As respostas saem do endereço para onde a mensagem foi enviada.';

  @override
  String get settingsFoldersHeader => 'Pastas';

  @override
  String get settingsFoldersFooter =>
      'O Loupe mostra e sincroniza as pastas que subscreve, tal como o Thunderbird. Caixa de entrada, Rascunhos, Enviados, Spam, Lixo e Arquivo aparecem sempre.';

  @override
  String get settingsShowAllFolders => 'Mostrar todas as pastas';

  @override
  String get settingsIncoming => 'Entrada';

  @override
  String get settingsOutgoing => 'Saída';

  @override
  String get settingsConnectionNotEncrypted => 'Não encriptada';

  @override
  String get settingsSignIn => 'Início de sessão';

  @override
  String get settingsSignInExpired => 'Expirado';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider já não aceita o início de sessão do Loupe para esta conta, por isso o e-mail não está a ser sincronizado. Inicie sessão novamente para resolver.';
  }

  @override
  String get settingsSignInAgain => 'Iniciar sessão novamente';

  @override
  String get settingsSigningIn => 'A iniciar sessão…';

  @override
  String get settingsRemoveAccount => 'Remover conta';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Remover «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'O e-mail e as definições da conta são removidos deste dispositivo. Nada é eliminado no servidor.';

  @override
  String get settingsManageFolders => 'Gerir pastas';

  @override
  String get settingsNoFolders => 'Ainda não há pastas.';

  @override
  String get settingsManageFoldersFooter =>
      'As pastas subscritas aparecem no ecrã Caixas de correio e são sincronizadas em segundo plano. Normalmente, outras aplicações de e-mail na mesma conta também seguem estas subscrições.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Guarda as suas Smart Mailboxes para os seus outros dispositivos. Oculta no ecrã Caixas de correio.';

  @override
  String get settingsFolderAlwaysShown => 'Sempre visível';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Subscrever $folder';
  }

  @override
  String get settingsIdentities => 'Identidades';

  @override
  String get settingsIdentitiesFooterReorder =>
      'A primeira identidade é a predefinida para novas mensagens. Arraste para mudar a ordem.';

  @override
  String get settingsIdentitiesFooterSingle => 'A identidade predefinida para novas mensagens.';

  @override
  String get settingsIdentitiesReplyFooter => 'Uma resposta sai da identidade para onde a mensagem foi enviada.';

  @override
  String get settingsIdentityDefault => 'Predefinida';

  @override
  String settingsIdentityReorder(String email) {
    return 'Reordenar $email';
  }

  @override
  String get settingsAddIdentity => 'Adicionar identidade';

  @override
  String get settingsNewIdentity => 'Nova identidade';

  @override
  String get settingsIdentity => 'Identidade';

  @override
  String get settingsIdentityNameHint => 'O seu nome';

  @override
  String get settingsReplyTo => 'Responder a';

  @override
  String get settingsSignature => 'Assinatura';

  @override
  String get settingsSignatureFooter => 'Adicionada abaixo de «-- » nas mensagens desta identidade.';

  @override
  String get settingsNoSignature => 'Sem assinatura';

  @override
  String get settingsCopyToMyself => 'Cópia para mim';

  @override
  String get settingsCopyToMyselfFooter => 'Adicionados a todas as mensagens desta identidade.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Usar nas respostas a';

  @override
  String get settingsReplyPatternsFooter =>
      'As respostas a mensagens enviadas para estes endereços saem desta identidade. * representa qualquer coisa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Um endereço, ou um padrão em que * representa qualquer coisa.';

  @override
  String get settingsAddReplyPattern => 'Adicionar endereço ou padrão';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Remover $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Padrão inválido';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» não é um endereço nem um padrão como *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Sem endereço';

  @override
  String get settingsIdentityNoAddressMessage => 'Introduza o endereço de e-mail a partir do qual quer enviar.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Endereço inválido';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Em Responder a, «$address» não é um endereço de e-mail válido.',
      'cc': 'Em Cc, «$address» não é um endereço de e-mail válido.',
      'bcc': 'Em Bcc, «$address» não é um endereço de e-mail válido.',
      'other': '«$address» não é um endereço de e-mail válido.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Guardar identidade';

  @override
  String get settingsDiscardChanges => 'Descartar alterações';

  @override
  String get settingsDeleteIdentity => 'Eliminar identidade';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Eliminar «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'As mensagens já enviadas a partir dela ficam como estão.';

  @override
  String get settingsLastIdentityFooter => 'Uma conta precisa de pelo menos uma identidade.';

  @override
  String get rulesTitle => 'Regras';

  @override
  String get rulesNewRule => 'Nova regra';

  @override
  String get rulesLoadError => 'Não foi possível carregar as regras.';

  @override
  String get rulesEmptyTitle => 'Sem regras';

  @override
  String get rulesEmptyText =>
      'As regras organizam em pastas, etiquetam e sinalizam o e-mail novo por si. Crie uma com o botão de escrever acima, ou a partir de uma pesquisa com «Transformar numa regra».';

  @override
  String get rulesListFooter =>
      'As regras são executadas de cima para baixo no e-mail novo da Caixa de entrada. Toque sem soltar numa regra para a mover.';

  @override
  String get rulesChangeError => 'Não foi possível alterar a regra';

  @override
  String get rulesConditionEveryMessage => 'Todas as mensagens';

  @override
  String rulesMoveRule(String rule) {
    return 'Mover $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule ativada';
  }

  @override
  String get rulesServerRulesHeader => 'Regras no servidor';

  @override
  String get rulesServerRulesFooter =>
      'As regras no servidor são executadas no servidor de e-mail à medida que o e-mail chega, mesmo com este dispositivo desligado. Ficam guardadas num script Sieve chamado «loupe».';

  @override
  String get rulesStatusUnknown => 'Desconhecido';

  @override
  String get rulesStatusError => 'Não foi possível consultar o servidor.';

  @override
  String get rulesStatusChecking => 'A verificar…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Executadas a partir de «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» é o script ativo. Toque para que também execute as regras do Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Não há nenhum script ativo no servidor. Guardar uma regra no servidor ativa o do Loupe.';

  @override
  String get rulesStatusUnavailable => 'Não disponível';

  @override
  String get rulesStatusNoSieve => 'O servidor desta conta não oferece Sieve (ManageSieve ou JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Mover para $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Mover para uma pasta';

  @override
  String rulesActionTag(String tag) {
    return 'Etiquetar com $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Remover etiqueta $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Manter na Caixa de entrada';

  @override
  String rulesActionForward(String address) {
    return 'Encaminhar para $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Encaminhar para $address, sem guardar cópia';
  }

  @override
  String get rulesActionStop => 'Parar';

  @override
  String get rulesNoActions => 'Ainda não faz nada';

  @override
  String get rulesLocationDevice => 'Dispositivo';

  @override
  String get rulesLocationServer => 'Servidor';

  @override
  String get rulesLocationThisDevice => 'Este dispositivo';

  @override
  String get rulesNewRuleTitle => 'Nova regra';

  @override
  String get rulesEditRuleTitle => 'Editar regra';

  @override
  String get rulesDefaultNameEveryMessage => 'Todas as mensagens';

  @override
  String get rulesConditionHeader => 'Quando uma nova mensagem corresponde a';

  @override
  String get rulesConditionFooter =>
      'Escreva-a como numa pesquisa: from:, to:, s: (assunto), b: (corpo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:fatura';

  @override
  String get rulesAccounts => 'Contas';

  @override
  String get rulesAllAccounts => 'Todas as contas';

  @override
  String get rulesRemovedAccount => 'Conta removida';

  @override
  String get rulesAccountsFooter => 'Uma regra para todas as contas também abrange as contas que adicionar mais tarde.';

  @override
  String get rulesActionsHeader => 'Então';

  @override
  String get rulesForwardingFooter =>
      'O encaminhamento envia cada mensagem correspondente para outro endereço à medida que chega, mesmo com este dispositivo desligado. Alguns fornecedores limitam a quantidade de e-mail que pode ser encaminhada.';

  @override
  String get rulesForwardingHiddenFooter =>
      'O encaminhamento só funciona em regras no servidor, por isso não aparece aqui.';

  @override
  String rulesRemoveAction(String action) {
    return 'Remover $action';
  }

  @override
  String get rulesAddAction => 'Adicionar ação';

  @override
  String get rulesAddMove => 'Mover para pasta…';

  @override
  String get rulesAddTagMenu => 'Adicionar etiqueta…';

  @override
  String get rulesRemoveTagMenu => 'Remover etiqueta…';

  @override
  String get rulesAddForward => 'Encaminhar para…';

  @override
  String get rulesStopProcessing => 'Não processar mais regras';

  @override
  String get rulesRunOnHeader => 'Executar em';

  @override
  String get rulesRunOnDeviceFooter =>
      'Este dispositivo executa a regra no e-mail novo da Caixa de entrada sempre que o Loupe procura e-mail.';

  @override
  String get rulesRunOnServerFooter =>
      'O servidor de e-mail executa a regra à medida que o e-mail chega, mesmo com este dispositivo desligado. Requer Sieve, através de ManageSieve (Dovecot, mailcow) ou JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Aplicar às mensagens existentes…';

  @override
  String get rulesDeleteRule => 'Eliminar regra';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Eliminar «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => 'Pasta de que conta?';

  @override
  String get rulesMoveAccountMessage => 'O e-mail das outras contas vai para a pasta com o mesmo nome nessas contas.';

  @override
  String get rulesAddTag => 'Adicionar etiqueta';

  @override
  String get rulesRemoveTag => 'Remover etiqueta';

  @override
  String get rulesForwardTo => 'Encaminhar para';

  @override
  String get rulesForwardToMessage =>
      'O servidor reencaminha cada mensagem correspondente para este endereço, mesmo com este dispositivo desligado. Use um endereço que seja seu ou em que confie.';

  @override
  String get rulesNotAnAddressTitle => 'Não é um endereço de e-mail';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» não é um endereço para onde encaminhar.';
  }

  @override
  String get rulesKeepCopyTitle => 'Manter uma cópia aqui?';

  @override
  String get rulesKeepCopy => 'Manter uma cópia';

  @override
  String get rulesDontKeepCopy => 'Não manter cópia';

  @override
  String get rulesCheckCondition => 'Verifique a condição';

  @override
  String get rulesChooseActionTitle => 'Escolha uma ação';

  @override
  String get rulesChooseActionMessage => 'Adicione o que a regra faz com as mensagens que lhe correspondem.';

  @override
  String get rulesSaveError => 'Não foi possível guardar a regra';

  @override
  String get rulesSaveServerError => 'Não foi possível guardar a regra no servidor';

  @override
  String get rulesRunOnDeviceInstead => 'Executar neste dispositivo';

  @override
  String get rulesNothingToApplyTitle => 'Nada para aplicar';

  @override
  String get rulesNothingToApplyMessage => 'Primeiro, dê à regra uma condição válida e uma ação.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Aplicar «$rule» às mensagens em…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Caixas de entrada';

  @override
  String get rulesApplyScopeAll => 'Todas as caixas de correio';

  @override
  String get rulesFindingMessages => 'A procurar mensagens…';

  @override
  String get rulesSearchError => 'Não foi possível pesquisar';

  @override
  String get rulesSearchErrorUnknown => 'Ocorreu um erro.';

  @override
  String get rulesNoMatchesTitle => 'Nenhuma mensagem corresponde';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nada aí corresponde a «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aplicar «$rule» a $countString mensagens?',
      one: 'Aplicar «$rule» a $countString mensagem?',
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
      other: 'Aplicar a $countString mensagens',
      one: 'Aplicar a $countString mensagem',
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
      other: '«$rule» aplicada a $countString mensagens',
      one: '«$rule» aplicada a $countString mensagem',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'A perguntar ao servidor o que consegue fazer…';

  @override
  String get rulesServerUnreachable => 'Não foi possível contactar o servidor.';

  @override
  String rulesServerProblem(String problem) {
    return 'Não é possível executar no servidor: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Não é possível executar no servidor de $account: $problem';
  }

  @override
  String get rulesShowScript => 'Mostrar script';

  @override
  String get rulesHideScript => 'Ocultar script';

  @override
  String get rulesMatchingHeader => 'Mensagens correspondentes';

  @override
  String get rulesMatchingHeaderLoading => 'Mensagens correspondentes…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString mensagens correspondentes',
      one: '$countString mensagem correspondente',
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
      other: '$countString+ mensagens correspondentes',
      one: '$countString+ mensagem correspondente',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Dos últimos 30 dias. A regra em si só atua sobre o e-mail novo, a não ser que a aplique às mensagens existentes.';

  @override
  String rulesConditionError(String error) {
    return 'A condição tem um erro: $error';
  }

  @override
  String get rulesPreviewNoSender => '(sem remetente)';

  @override
  String get rulesPreviewNoSubject => '(sem assunto)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'e mais $countString',
      one: 'e mais $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nada dos últimos 30 dias.';

  @override
  String get rulesIncludeTitle => 'Ativar regras no servidor';

  @override
  String get rulesIncludeLeaveOff => 'Deixar desativadas';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'O servidor já executa as regras do Loupe para $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» é o script ativo no servidor de $account, por isso o servidor executa-o a ele e não às regras do Loupe. O Loupe não o vai substituir. Pode acrescentar-lhe estas linhas, e o servidor passa então a executar as regras do Loupe depois das do próprio script:';
  }

  @override
  String get rulesShowWholeScript => 'Mostrar o script completo';

  @override
  String get rulesHideWholeScript => 'Ocultar o script completo';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nada mais muda em «$script». Se os filtros forem editados mais tarde no webmail, este pode reescrevê-lo sem estas linhas; nesse caso, o Loupe volta a mostrar as regras no servidor como desativadas.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Adicionar a «$script»';
  }

  @override
  String get subscriptionsTitle => 'Subscrições';

  @override
  String get subscriptionsNewsletters => 'Newsletters';

  @override
  String get subscriptionsDiscussions => 'Discussões';

  @override
  String get subscriptionsFilter => 'Filtrar';

  @override
  String get subscriptionsFilterNeverRead => 'Nunca lidas';

  @override
  String get subscriptionsFilterRarelyRead => 'Raramente lidas';

  @override
  String get subscriptionsFilterAll => 'Todas';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Não foi possível contar as subscrições';

  @override
  String get subscriptionsNoMatches => 'Sem resultados';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nenhuma newsletter se chama «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nenhuma lista se chama «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Sem newsletters';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'As newsletters e outro e-mail em massa aparecem aqui quando chegarem.';

  @override
  String get subscriptionsNothingNeverRead => 'Nada em «Nunca lidas»';

  @override
  String get subscriptionsNothingRarelyRead => 'Nada em «Raramente lidas»';

  @override
  String get subscriptionsNothingFilteredDetail => 'Lê alguma coisa de tudo o que recebe.';

  @override
  String get subscriptionsNoDiscussions => 'Sem discussões';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'As listas de correio onde pode escrever aparecem aqui quando o e-mail delas chegar.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listas onde várias pessoas escrevem. Toque sem soltar numa delas para a afixar nas Caixas de correio, lê-la como texto simples ou movê-la para Newsletters.';

  @override
  String get subscriptionsPrivacyNote =>
      'Contabilizado neste dispositivo a partir do e-mail que já transferiu; nada é enviado para lado nenhum para o calcular. O Loupe só contacta um remetente quando toca em Cancelar subscrição: o cancelamento com um clique envia apenas «List-Unsubscribe=One-Click» para o endereço indicado pelo remetente, sem cookies nem mais nada sobre si, e nunca carrega as páginas ou as imagens dele.';

  @override
  String get subscriptionsVolumeNone => 'Nada recentemente';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mês';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mês';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'lidas $percent';
  }

  @override
  String get subscriptionsStillSending => 'Continua a enviar';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Subscrição cancelada em $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Página de cancelamento aberta em $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Um toque · contacta $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Por e-mail para $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'No site $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Cancelar subscrição';

  @override
  String get subscriptionsUnsubscribeAgain => 'Cancelar subscrição novamente';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Arquivar $countString da Caixa de entrada',
      one: 'Arquivar $countString da Caixa de entrada',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Criar regra…';

  @override
  String get subscriptionsCreateRuleDetail => 'Mover ou arquivar o e-mail futuro';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratar como discussão';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Uma lista onde as pessoas escrevem: leia-a como um fórum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratar como newsletter';

  @override
  String get subscriptionsBlockSender => 'Bloquear remetente';

  @override
  String get subscriptionsBlock => 'Bloquear';

  @override
  String get subscriptionsBlocked => 'Bloqueado';

  @override
  String get subscriptionsBlockedDetail => 'O e-mail novo vai para Spam';

  @override
  String get subscriptionsPin => 'Afixar nas Caixas de correio';

  @override
  String get subscriptionsUnpin => 'Desafixar das Caixas de correio';

  @override
  String get subscriptionsOpenDefaultView => 'Abrir na vista predefinida';

  @override
  String get subscriptionsOpenPlainText => 'Abrir como texto simples (Mono)';

  @override
  String get subscriptionsPinned => 'Afixada';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString não lidas',
      one: '$countString não lida',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'De momento, não há e-mail deste remetente.';

  @override
  String get subscriptionsLatestMessages => 'ÚLTIMAS MENSAGENS';

  @override
  String get subscriptionsMail => 'E-mail';

  @override
  String get subscriptionsNoneIn90Days => 'Nada em 90 dias';

  @override
  String get subscriptionsRead => 'Lidas';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString de $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Última recebida';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Guardadas em');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Continua a enviar';

  @override
  String get subscriptionsUnsubscribedTitle => 'Subscrição cancelada';

  @override
  String subscriptionsSince(String date) {
    return 'desde $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'página aberta em $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender não indica como cancelar a subscrição.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender não indica como cancelar a subscrição. Em alternativa, pode bloqueá-lo.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'A cancelar a subscrição de $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Subscrição de $sender cancelada.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Não foi possível cancelar a subscrição: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Não foi possível cancelar automaticamente';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Enviar e-mail de cancelamento';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Abrir $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Abrir $site?';
  }

  @override
  String get subscriptionsOpen => 'Abrir';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender cancela subscrições no seu site. A página abre no navegador do Loupe; conclua lá.';
  }

  @override
  String get subscriptionsWebInsecure => 'A ligação a este site não é encriptada.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Atenção: este endereço imita $site com letras parecidas.';
  }

  @override
  String get subscriptionsHomographWarningUnknown => 'Atenção: este endereço imita outro site com letras parecidas.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Não foi possível abrir $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'O Loupe regista a data de hoje e avisa-o se $sender continuar a escrever.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Cancelar a subscrição de $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'O Loupe vai contactar $site para cancelar a subscrição.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Esta é a única vez que o Loupe contacta o site de um remetente. Envia apenas «List-Unsubscribe=One-Click» para o endereço indicado por $sender, sem cookies nem mais nada sobre si, e não carrega a página.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'A ligação de cancelamento não é um endereço seguro na Internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site não respondeu a tempo.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Não foi possível contactar $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site reencaminhou o pedido para outra página, que o Loupe não segue.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site recusou o pedido (erro $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Não há nenhuma conta a partir da qual enviar o e-mail de cancelamento.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'O Loupe vai enviar um e-mail para $to a partir de $from, com o assunto «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-mail de cancelamento enviado para $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Bloquear $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'O e-mail novo desta lista vai para Spam. Pode alterar isto em Definições › Regras.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'O e-mail novo de $address vai para Spam. Pode alterar isto em Definições › Regras.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender bloqueado.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mover $count para Spam',
      one: 'Mover $count para Spam',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloquear $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender está agora em Newsletters.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender está agora em Discussões.';
  }

  @override
  String get appLiveGateTitle => 'Não foi possível abrir as suas contas';

  @override
  String get appLiveGateUnavailableBuild => 'As contas reais ainda não estão disponíveis nesta versão.';

  @override
  String get appLiveGateKeyUnreadable =>
      'O Loupe não conseguiu ler a chave que protege o seu e-mail neste dispositivo. Muitas vezes é temporário: tente novamente ou reinicie o dispositivo.';

  @override
  String get appLiveGateKeyMissing =>
      'A chave que protege o seu e-mail neste dispositivo desapareceu, o que pode acontecer depois de restaurar uma cópia de segurança. O seu e-mail continua no servidor.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Não é possível ler a base de dados de e-mail deste dispositivo: está danificada ou a chave mudou. O seu e-mail continua no servidor.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Ocorreu um erro ao abrir as suas contas ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Isto elimina as suas contas e o e-mail guardado neste dispositivo, incluindo as mensagens à espera na Caixa de saída. O e-mail nos seus servidores não é afetado; depois, adicione novamente as suas contas.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Eliminar e recomeçar';

  @override
  String get appLiveGateUseDemo => 'Usar e-mail de demonstração';

  @override
  String get appLiveGateReset => 'Repor o e-mail neste dispositivo…';

  @override
  String get attachmentsUntitled => 'Anexo';

  @override
  String get attachmentsUntitledFile => 'Sem título';

  @override
  String get attachmentsOpenIn => 'Abrir em…';

  @override
  String get attachmentsSaveToFiles => 'Guardar nos ficheiros';

  @override
  String get attachmentsShareMenu => 'Partilhar…';

  @override
  String get attachmentsDownloadError =>
      'Não foi possível transferir o anexo. Verifique a ligação à Internet e tente novamente.';

  @override
  String get attachmentsShareError => 'Não foi possível partilhar o anexo.';

  @override
  String attachmentsNoApp(String type) {
    return 'Nenhuma aplicação deste dispositivo abre este ficheiro ($type). Experimente Partilhar.';
  }

  @override
  String get attachmentsOpenInError => 'Não foi possível abrir o anexo noutra aplicação.';

  @override
  String attachmentsSaved(String name) {
    return '«$name» guardado';
  }

  @override
  String get attachmentsSaveError => 'Não foi possível guardar o anexo.';

  @override
  String get attachmentsGone => 'Este anexo já não está disponível.';

  @override
  String get attachmentsDownloadFailed => 'Não foi possível transferir o anexo.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count páginas', one: '$count página');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size em dados móveis';
  }

  @override
  String get attachmentsLargeDownload => 'Este anexo é grande. Transfira-o agora, ou mais tarde por Wi-Fi.';

  @override
  String get attachmentsDownload => 'Transferir';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'A transferir $size…';
  }

  @override
  String get attachmentsDownloading => 'A transferir…';

  @override
  String get attachmentsTooLarge => 'Demasiado grande para pré-visualizar aqui.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'A mostrar os primeiros $shown de $total. Copie, partilhe ou guarde para obter tudo.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Não é possível mostrar este PDF aqui (pode estar protegido por palavra-passe).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page de $count';
  }

  @override
  String get attachmentsModeTable => 'Tabela';

  @override
  String get attachmentsModeText => 'Texto';

  @override
  String get attachmentsModeMessage => 'Mensagem';

  @override
  String get attachmentsModeSource => 'Código-fonte';

  @override
  String get attachmentsDontWrap => 'Não quebrar linhas';

  @override
  String get attachmentsWrap => 'Quebrar linhas';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines linhas', one: '$count linha');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copiar tudo';

  @override
  String get attachmentsCopied => 'Copiado';

  @override
  String get attachmentsImageUnavailable => 'Não é possível mostrar esta imagem aqui. Experimente Abrir em….';

  @override
  String get attachmentsEmlNoSubject => '(Sem assunto)';

  @override
  String get attachmentsEmlFrom => 'De';

  @override
  String get attachmentsEmlTo => 'Para';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Esta mensagem não tem texto.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anexos: $names',
      one: '$count anexo: $names',
    );
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
      other: 'E mais $count eventos',
      one: 'E mais $count evento',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imagem';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imagem $format';
  }

  @override
  String get attachmentsTypePdf => 'Documento PDF';

  @override
  String get attachmentsTypeTsv => 'Valores separados por tabulações';

  @override
  String get attachmentsTypeCsv => 'Tabela CSV';

  @override
  String get attachmentsTypeCalendar => 'Evento de calendário';

  @override
  String get attachmentsTypeEmail => 'Mensagem de e-mail';

  @override
  String get attachmentsTypeContact => 'Cartão de contacto';

  @override
  String get attachmentsTypeLog => 'Ficheiro de registo';

  @override
  String get attachmentsTypeText => 'Texto';

  @override
  String get attachmentsTypeZip => 'Arquivo ZIP';

  @override
  String get attachmentsTypeArchive => 'Arquivo comprimido';

  @override
  String get attachmentsTypeWord => 'Documento do Word';

  @override
  String get attachmentsTypeExcel => 'Documento do Excel';

  @override
  String get attachmentsTypePowerPoint => 'Apresentação do PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Página web';

  @override
  String get attachmentsTypeVideo => 'Vídeo';

  @override
  String get attachmentsTypeAudio => 'Áudio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Ficheiro $extension';
  }

  @override
  String get attachmentsTypeFile => 'Ficheiro';

  @override
  String get calendarUntitledEvent => 'Evento';

  @override
  String get calendarAllDay => 'Dia inteiro';

  @override
  String calendarYourTime(String time) {
    return '$time no seu fuso horário';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Participar: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceitou: $details',
      'tentative': '$name aceitou provisoriamente: $details',
      'declined': '$name recusou: $details',
      'delegated': '$name delegou: $details',
      'other': '$name não respondeu a: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceitou o convite',
      'tentative': '$name aceitou provisoriamente o convite',
      'declined': '$name recusou o convite',
      'delegated': '$name delegou o convite',
      'other': '$name não respondeu ao convite',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Participar';

  @override
  String get calendarOnlineMeeting => 'Reunião online';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Reunião $provider';
  }

  @override
  String get calendarOrganizerYou => 'Você';

  @override
  String get calendarOrganizerLabel => 'organizador';

  @override
  String get calendarStatusAccepted => 'Aceite';

  @override
  String get calendarStatusMaybe => 'Talvez';

  @override
  String get calendarStatusDeclined => 'Recusado';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceitou',
      'tentative': '$name aceitou provisoriamente',
      'declined': '$name recusou',
      'delegated': '$name delegou',
      'other': '$name não respondeu',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name aceitou:',
      'tentative': '$name aceitou provisoriamente:',
      'declined': '$name recusou:',
      'delegated': '$name delegou:',
      'other': '$name não respondeu:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name propõe uma nova hora';
  }

  @override
  String get calendarCounterUnknown => 'Um participante propõe uma nova hora';

  @override
  String get calendarDeclineCounter => 'O organizador manteve a hora';

  @override
  String calendarRefresh(String name) {
    return '$name pede a versão mais recente';
  }

  @override
  String get calendarRefreshUnknown => 'Um participante pede a versão mais recente';

  @override
  String get calendarCancelled => 'Cancelado';

  @override
  String get calendarCancelledByOrganizer => 'O organizador cancelou este evento.';

  @override
  String get calendarCancelledLater => 'Este evento foi cancelado posteriormente.';

  @override
  String get calendarOutdated => 'Desatualizado';

  @override
  String get calendarOutdatedDetail => 'Este convite foi atualizado posteriormente; conta o mais recente.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Local removido (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Local removido (não havia nenhum)';

  @override
  String calendarLocationChanged(String location) {
    return 'Local alterado para $location';
  }

  @override
  String get calendarNewTitle => 'Novo título';

  @override
  String get calendarRepeatChanged => 'A repetição mudou';

  @override
  String get calendarUpdated => 'Atualizado';

  @override
  String get calendarUpdatedInvitation => 'Convite atualizado';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Hora alterada de $before para $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Fuso horário «$zone» desconhecido: horas tal como estão escritas';
  }

  @override
  String calendarNext(String when) {
    return 'Próximo: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count convidados',
      one: '$count convidado',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count aceitaram', one: '$count aceitou');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count talvez', one: '$count talvez');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count recusaram', one: '$count recusou');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (você)';
  }

  @override
  String get calendarAttendeeOptional => 'opcional';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Aceitou uma versão anterior.',
      'tentative': 'Aceitou provisoriamente uma versão anterior.',
      'declined': 'Recusou uma versão anterior.',
      'delegated': 'Delegou uma versão anterior.',
      'other': 'Não respondeu a uma versão anterior.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Aceitar';

  @override
  String get calendarMaybe => 'Talvez';

  @override
  String get calendarDecline => 'Recusar';

  @override
  String get calendarCommentHint => 'Comentário para o organizador (opcional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'A sua resposta vai para $organizer a partir de $address.';
  }

  @override
  String get calendarAddComment => 'Adicionar um comentário';

  @override
  String get calendarAddToCalendar => 'Adicionar ao calendário';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'E mais $count eventos no ficheiro',
      one: 'E mais $count evento no ficheiro',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Não há nenhuma aplicação de calendário onde adicionar o evento.';

  @override
  String get calendarCantOpenCalendar => 'Não foi possível abrir o calendário.';

  @override
  String get calendarCantOpenLink => 'Não foi possível abrir a ligação.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Participar na reunião $provider?';
  }

  @override
  String get calendarJoinTitle => 'Participar na reunião?';

  @override
  String calendarJoinOpens(String host) {
    return 'Abre $host no seu navegador.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Atenção: este endereço imita $site com letras parecidas.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Atenção: este endereço imita outro site com letras parecidas.';

  @override
  String calendarJoinOpen(String host) {
    return 'Abrir $host';
  }

  @override
  String get calendarNoOrganizer => 'Este convite não tem organizador a quem responder.';

  @override
  String get calendarNoAccount => 'Não há nenhuma conta a partir da qual responder.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Aceite', 'tentative': 'Talvez', 'other': 'Recusado'});
    return '$_temp0 · a enviar resposta a $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Aceite', 'tentative': 'Talvez', 'other': 'Recusado'});
    return '$_temp0 · resposta enviada';
  }

  @override
  String get calendarReplyAlreadySent => 'A resposta já foi enviada.';

  @override
  String get calendarReplyNotSent => 'Resposta não enviada.';

  @override
  String get dataSmimeNeedsDevice =>
      'O seu certificado S/MIME está neste dispositivo: abra o Loupe para assinar e enviar esta mensagem.';

  @override
  String dataSigningFailed(String error) {
    return 'A assinatura falhou: $error';
  }

  @override
  String get keyboardShortcuts => 'Atalhos de teclado';

  @override
  String get keyboardGroupGeneral => 'Geral';

  @override
  String get keyboardGroupMessages => 'Mensagens';

  @override
  String get keyboardGroupCompose => 'Escrever';

  @override
  String get keyboardCommandPalette => 'Paleta de comandos';

  @override
  String get keyboardBackClose => 'Voltar, fechar';

  @override
  String get keyboardNextMessage => 'Mensagem seguinte';

  @override
  String get keyboardPreviousMessage => 'Mensagem anterior';

  @override
  String get keyboardOpenMessage => 'Abrir mensagem';

  @override
  String get keyboardMoveToTrash => 'Mover para o Lixo';

  @override
  String get keyboardToggleRead => 'Marcar como lida ou não lida';

  @override
  String get keyboardToggleFlag => 'Sinalizar ou remover sinalização';

  @override
  String get keyboardCloseDraft => 'Fechar (guardar ou eliminar rascunho)';

  @override
  String get keyboardOr => 'ou';

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
  String get mailingListsMuted => 'Conversa silenciada. As novas mensagens nela chegam como lidas.';

  @override
  String get mailingListsUnmuted => 'A conversa deixou de estar silenciada.';

  @override
  String get mailingListsMuteThread => 'Silenciar conversa';

  @override
  String get mailingListsUnmuteThread => 'Deixar de silenciar conversa';

  @override
  String get mailingListsPin => 'Afixar nas Caixas de correio';

  @override
  String get mailingListsUnpin => 'Desafixar das Caixas de correio';

  @override
  String get mailingListsDefaultView => 'Abrir na vista predefinida';

  @override
  String get mailingListsPlainText => 'Abrir como texto simples (Mono)';

  @override
  String get mailingListsShowMuted => 'Mostrar conversas silenciadas';

  @override
  String get mailingListsHideMuted => 'Ocultar conversas silenciadas';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratar como newsletter';

  @override
  String get mailingListsOptions => 'Opções da lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted não lidas',
      one: '$count não lida',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nova mensagem para a lista';

  @override
  String get mailingListsRowUnread => 'Não lida';

  @override
  String get mailingListsRowMuted => 'Silenciada';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count respostas', one: '$count resposta');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Sem conversas';

  @override
  String get mailingListsMutedHidden => 'As conversas silenciadas estão ocultas.';

  @override
  String get mailingListsTechnicalTitle => 'Listas técnicas';

  @override
  String get mailingListsTechnicalEmpty => 'As listas de correio aparecem aqui quando o e-mail delas chegar.';

  @override
  String get mailingListsTechnicalFooter =>
      'As mensagens destas listas abrem como texto simples num tipo de letra monoespaçado, com os patches apresentados como diffs. O botão Aa continua a mudar a vista de qualquer mensagem.';

  @override
  String get paletteMoveToMailbox => 'Mover para caixa de correio…';

  @override
  String get paletteMarkAllRead => 'Marcar tudo como lido';

  @override
  String get paletteExportFolder => 'Exportar pasta…';

  @override
  String get paletteGetNewMail => 'Obter e-mail novo';

  @override
  String get paletteSnoozed => 'Adiadas';

  @override
  String get paletteSubscriptions => 'Subscrições';

  @override
  String get paletteDiscussions => 'Discussões';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Lista de correio';

  @override
  String get paletteTag => 'Etiqueta';

  @override
  String get paletteSwipeActions => 'Ações de deslizar';

  @override
  String get paletteNotifications => 'Notificações';

  @override
  String get paletteRules => 'Regras';

  @override
  String get paletteEncryption => 'Encriptação ponta a ponta';

  @override
  String get paletteAdvanced => 'Avançadas';

  @override
  String get paletteAddAccount => 'Adicionar conta';

  @override
  String get paletteAccount => 'Conta';

  @override
  String get paletteFolders => 'Pastas';

  @override
  String get paletteRecentSearch => 'Pesquisa recente';

  @override
  String paletteSearchMail(String query) {
    return 'Pesquisar e-mail por «$query»';
  }

  @override
  String get palettePlaceholder => 'Pesquisar ações, caixas de correio, definições';

  @override
  String get paletteNothingFound => 'Nada encontrado';

  @override
  String get searchNewSmartMailbox => 'Nova Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Mostra tudo o que corresponde a «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» guardada nas Caixas de correio';
  }

  @override
  String get searchMakeRule => 'Transformar numa regra';

  @override
  String get searchSaveSmartMailbox => 'Guardar como Smart Mailbox';

  @override
  String get searchNegate => 'Negar';

  @override
  String get searchDontNegate => 'Não negar';

  @override
  String get searchAllMailboxes => 'Todas as caixas de correio';

  @override
  String get searchRecent => 'Pesquisas recentes';

  @override
  String get searchClear => 'Limpar';

  @override
  String get searchSuggestions => 'Sugestões';

  @override
  String get searchUnreadMessages => 'Mensagens não lidas';

  @override
  String get searchFlaggedMessages => 'Mensagens sinalizadas';

  @override
  String get searchWithAttachments => 'Mensagens com anexos';

  @override
  String get searchUnrepliedMessages => 'Mensagens sem resposta';

  @override
  String get searchTags => 'Etiquetas';

  @override
  String get searchPeople => 'Pessoas';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De: $name';
  }

  @override
  String get searchSearching => 'A pesquisar…';

  @override
  String get searchNoResults => 'Sem resultados';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted resultados',
      one: '$count resultado',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menu de pesquisa';

  @override
  String searchSearchingAccount(String account) {
    return 'A pesquisar $account no servidor…';
  }

  @override
  String get searchSearchingUnknownAccount => 'A pesquisar a conta no servidor…';

  @override
  String searchAccountFailed(String account) {
    return 'Não foi possível pesquisar $account no servidor';
  }

  @override
  String get searchUnknownAccountFailed => 'Não foi possível pesquisar a conta no servidor';

  @override
  String searchChip(String term) {
    return '$term. Toque duas vezes para editar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Não $term. Toque duas vezes para editar.';
  }

  @override
  String get searchReadAndUnread =>
      'A caixa de entrada de Schrödinger: cada mensagem aqui está lida e não lida até a abrir.';

  @override
  String searchContradiction(String term) {
    return 'Nenhuma mensagem pode ser «$term» e não o ser ao mesmo tempo.';
  }

  @override
  String get searchSyncDeviceOnly => 'Só neste dispositivo';

  @override
  String searchSyncUnsupported(String account) {
    return 'Só neste dispositivo: $account não a consegue guardar';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Não sincronizada: $account tem um formato mais recente';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'À espera de sincronizar com $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronizada com $account';
  }

  @override
  String get searchRename => 'Mudar o nome';

  @override
  String get searchEditSearch => 'Editar pesquisa';

  @override
  String get searchDeleteSmartMailbox => 'Eliminar Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Mudar o nome da Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Esta Smart Mailbox foi eliminada.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'As Smart Mailboxes ficam neste dispositivo.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'As Smart Mailboxes ficam guardadas no seu servidor de e-mail, para que os seus outros dispositivos também as tenham, tal como o Thunderbird com o Expression Search Reloaded. As que pesquisam todas as contas ficam guardadas em $account; as de uma pasta, na conta dessa pasta.';
  }

  @override
  String get searchSyncVia => 'Sincronizar através de';

  @override
  String get searchSyncViaFooter => 'Escolha a mesma conta em todos os dispositivos.';

  @override
  String get searchGmailCantKeep => 'O Gmail não consegue guardar Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Guardar as Smart Mailboxes só neste dispositivo';

  @override
  String get searchOnTheServer => 'No servidor';

  @override
  String get searchServerFooter =>
      'Os metadados do servidor (IMAP METADATA) não aparecem em nenhuma aplicação de e-mail. Os servidores sem eles recebem uma pasta «Loupe Settings» com uma mensagem; o Loupe oculta-a nas Caixas de correio.';

  @override
  String get searchSyncNow => 'Sincronizar agora';

  @override
  String get searchStateUnsupported => 'Não suportado';

  @override
  String get searchStateNewerFormat => 'Formato mais recente';

  @override
  String get searchStateFailed => 'Não foi possível sincronizar';

  @override
  String get searchStateSyncing => 'A sincronizar…';

  @override
  String get searchStateWaiting => 'À espera';

  @override
  String get searchStateMetadata => 'Metadados do servidor';

  @override
  String get searchStateFolder => 'Pasta Loupe Settings';

  @override
  String get searchStateNothing => 'Nada guardado';

  @override
  String get sharedBack => 'Voltar';

  @override
  String get sharedYesterday => 'Ontem';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date às $time';
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
  String get sharedSyncNoAccounts => 'Sem contas';

  @override
  String get sharedSyncChecking => 'A procurar e-mail…';

  @override
  String get sharedSyncFailed => 'Não foi possível procurar e-mail';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Atualizado agora mesmo';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Atualizado há $minutes minutos',
      one: 'Atualizado há $minutes minuto',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Atualizado às $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Atualizado em $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Todas as caixas de entrada';

  @override
  String get sharedMailboxUnread => 'Não lidas';

  @override
  String get sharedMailboxFlagged => 'Sinalizadas';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Todos os rascunhos';

  @override
  String get sharedMailboxAllSent => 'Todos os enviados';

  @override
  String get sharedMailboxUntitled => 'Caixa de correio';

  @override
  String get sharedTagImportant => 'Importante';

  @override
  String get sharedTagWork => 'Trabalho';

  @override
  String get sharedTagPersonal => 'Pessoal';

  @override
  String get sharedTagToDo => 'A fazer';

  @override
  String get sharedTagLater => 'Mais tarde';

  @override
  String get sharedTags => 'Etiquetas';

  @override
  String get sharedMoveTo => 'Mover para…';

  @override
  String get sharedNoRecipients => 'Sem destinatários';

  @override
  String get sharedUnknownSender => 'Remetente desconhecido';

  @override
  String get sharedOnServer => 'No servidor';

  @override
  String get sharedAttachment => 'Anexo';

  @override
  String get sharedSnoozedBadge => 'Adiada';

  @override
  String get sharedRowUnread => 'Não lida';

  @override
  String get sharedRowBackFromSnooze => 'Regressou do adiamento';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Sinalizada';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens arquivadas',
      one: '$count mensagem arquivada',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens eliminadas',
      one: '$count mensagem eliminada',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens movidas para a Caixa de entrada',
      one: '$count mensagem movida para a Caixa de entrada',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens movidas para o Lixo',
      one: '$count mensagem movida para o Lixo',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens movidas para Spam',
      one: '$count mensagem movida para Spam',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens movidas para $mailbox',
      one: '$count mensagem movida para $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens movidas para a caixa de correio',
      one: '$count mensagem movida para a caixa de correio',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens adiadas até $time',
      one: '$count mensagem adiada até $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Adiada até $time só neste dispositivo: o servidor não consegue guardar as horas de adiamento.';
  }

  @override
  String get sharedMoveOneAccount => 'Selecione mensagens de uma só conta para as mover.';

  @override
  String get sharedSnoozeTitle => 'Adiar';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Alterar hora do adiamento';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eliminar $count mensagens definitivamente?',
      one: 'Eliminar $count mensagem definitivamente?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Esta ação não pode ser anulada.';

  @override
  String get sharedDeletePermanently => 'Eliminar definitivamente';

  @override
  String get sharedSwipeRead => 'Lida';

  @override
  String get sharedSwipeUnread => 'Não lida';

  @override
  String get sharedSwipeInbox => 'Entrada';

  @override
  String get sharedSwipeDelete => 'Eliminar';

  @override
  String get sharedTrash => 'Lixo';

  @override
  String get sharedSwipeSnooze => 'Adiar';

  @override
  String get sharedWakeNow => 'Devolver agora';

  @override
  String get sharedChangeSnoozeTime => 'Alterar hora do adiamento…';

  @override
  String get sharedSnooze => 'Adiar…';

  @override
  String get sharedTag => 'Etiquetar…';

  @override
  String get sharedMoveMessage => 'Mover mensagem…';

  @override
  String get sharedNotJunk => 'Não é spam';

  @override
  String get accountSetupTitle => 'Adicionar conta';

  @override
  String get accountSetupTitleDone => 'Conta adicionada';

  @override
  String get accountSetupAddressTitle => 'Adicionar uma conta de e-mail';

  @override
  String get accountSetupAddressText => 'O Loupe encontra as definições da maioria dos fornecedores.';

  @override
  String get accountSetupNameHint => 'O seu nome';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'nome@example.com';

  @override
  String get accountSetupContinue => 'Continuar';

  @override
  String get accountSetupLookingUp => 'A procurar definições…';

  @override
  String get accountSetupImport => 'Importar do Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Introduza um endereço de e-mail válido.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Não foi possível encontrar as definições de $domain. Introduza-as abaixo.';
  }

  @override
  String get accountSetupCheckServers => 'Verifique os nomes dos servidores e as portas.';

  @override
  String get accountSetupEnterPassword => 'Introduza a sua palavra-passe.';

  @override
  String get accountSetupConnecting => 'A estabelecer ligação…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'A aguardar $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Não foi possível abrir a página.';

  @override
  String get accountSetupCouldNotSaveName => 'Não foi possível guardar o nome.';

  @override
  String get accountSetupTrustCertificate => 'Confiar neste certificado';

  @override
  String get accountSetupPasswordRequired => 'Obrigatória';

  @override
  String get accountSetupShowPassword => 'Mostrar palavra-passe';

  @override
  String get accountSetupHidePassword => 'Ocultar palavra-passe';

  @override
  String get accountSetupAppPassword => 'Palavra-passe de aplicação';

  @override
  String get accountSetupApiToken => 'Token de API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Entrada · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Saída · SMTP';

  @override
  String get accountSetupSignIn => 'Iniciar sessão';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Iniciar sessão com $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Usar uma palavra-passe de aplicação';

  @override
  String get accountSetupUseAppPasswordInstead => 'Usar uma palavra-passe de aplicação em vez disso';

  @override
  String get accountSetupUseDifferentAddress => 'Usar outro endereço';

  @override
  String get accountSetupHowToCreateAppPassword => 'Como criar uma palavra-passe de aplicação';

  @override
  String get accountSetupHowToCreateOne => 'Como criar uma';

  @override
  String get accountSetupGoogleNote =>
      'Inicia sessão na página da Google e o Loupe nunca vê a sua palavra-passe. Permita que o Loupe leia, envie e organize o seu e-mail.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Iniciar sessão com Google» ainda não está disponível nesta versão. Em alternativa, pode ligar-se com uma palavra-passe de aplicação (requer a Validação em dois passos na sua Conta Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Crie uma palavra-passe de aplicação na sua Conta Google e cole-a abaixo.';

  @override
  String get accountSetupMicrosoftNote =>
      'Inicia sessão na página da Microsoft e o Loupe nunca vê a sua palavra-passe. Funciona com Outlook.com e Hotmail, e com contas profissionais ou escolares do Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'O início de sessão com Microsoft chega numa versão posterior. As contas Outlook, Hotmail e Microsoft 365 precisam dele: já não aceitam palavras-passe de aplicações de e-mail.';

  @override
  String get accountSetupICloudNote =>
      'O iCloud Mail precisa de uma palavra-passe específica da app, e não da palavra-passe da sua Conta Apple.';

  @override
  String get accountSetupYahooNote =>
      'O Yahoo Mail precisa de uma palavra-passe de aplicação, e não da palavra-passe da sua conta.';

  @override
  String get accountSetupFastmailJmapNote =>
      'O Loupe liga-se ao Fastmail por JMAP com um token de API: Settings › Privacy & Security › Manage API tokens, para JMAP, com acesso ao e-mail e ao envio.';

  @override
  String get accountSetupFastmailNote =>
      'O Fastmail precisa de uma palavra-passe de aplicação para aplicações de e-mail.';

  @override
  String get accountSetupServerSettings => 'Definições do servidor';

  @override
  String get accountSetupSettingsNotFound => 'Não encontradas automaticamente';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Encontradas através de $source';
  }

  @override
  String get accountSetupEditSettings => 'Editar definições';

  @override
  String get accountSetupSyncing => 'O seu e-mail está a ser sincronizado.';

  @override
  String get accountSetupDescription => 'Descrição';

  @override
  String get accountSetupDescriptionHint => 'Trabalho, Pessoal…';

  @override
  String get accountSetupColour => 'Cor';

  @override
  String accountSetupColourNumber(int number) {
    return 'Cor $number';
  }

  @override
  String get accountSetupSaving => 'A guardar…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'O Loupe não conseguiu abrir a sua base de dados de e-mail neste dispositivo. Feche o Loupe, abra-o novamente e tente outra vez.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Ocorreu um erro ($error). Tente novamente.';
  }

  @override
  String get accountSetupSecurityNone => 'Nenhuma';

  @override
  String get accountSetupProtocol => 'Protocolo';

  @override
  String get accountSetupPort => 'Porta';

  @override
  String get accountSetupSecurity => 'Segurança';

  @override
  String get accountSetupUsername => 'Nome de utilizador';

  @override
  String get accountSetupUsernameHint => 'O seu endereço de e-mail';

  @override
  String get accountSetupNoEncryptionTitle => 'Ligar sem encriptação?';

  @override
  String get accountSetupNoEncryptionText =>
      'A sua palavra-passe e todas as mensagens circulariam como texto simples. Qualquer pessoa na rede, como uma rede Wi-Fi pública, poderia lê-las. Use isto apenas para um servidor na sua própria rede.';

  @override
  String get accountSetupUseWithoutEncryption => 'Usar sem encriptação';

  @override
  String get accountSetupApiTokenRejected =>
      'Token de API rejeitado. Crie um token de API do Fastmail para JMAP com acesso ao e-mail e cole-o.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Palavra-passe rejeitada. Use uma palavra-passe de aplicação, e não a palavra-passe da sua conta.';

  @override
  String get accountSetupPasswordRejected => 'Palavra-passe rejeitada. Verifique-a e tente novamente.';

  @override
  String get accountSetupServerUnreachable =>
      'Não é possível contactar o servidor. Verifique as definições do servidor e a sua ligação.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'O certificado do servidor não é fidedigno. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'O início de sessão foi cancelado. Toque em «Iniciar sessão com $provider» para tentar novamente.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'O Loupe precisa de permissão para ler e enviar o seu e-mail do Gmail. Inicie sessão novamente e permita o acesso, com a caixa do Gmail assinalada.';

  @override
  String get accountSetupOAuthDenied =>
      'O Loupe precisa de permissão para ler e enviar o seu e-mail. Inicie sessão novamente e aceite as permissões.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'A sua organização tem de aprovar o Loupe antes de o poder usar com esta conta. Peça ao seu administrador de TI que conceda o consentimento de administrador ao Loupe no Microsoft Entra ID e tente novamente.';

  @override
  String get accountSetupOAuthBlocked =>
      'As regras de início de sessão da sua organização não permitem o Loupe neste dispositivo. Fale com o seu administrador de TI.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Não foi possível contactar $provider. Verifique a ligação à Internet e tente novamente.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'O início de sessão com $provider não está configurado corretamente nesta versão do Loupe. Comunique este problema.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'O início de sessão com $provider não funcionou. Tente novamente.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider iniciou a sua sessão, mas o Gmail recusou o acesso a este endereço. Escolha a mesma conta ao iniciar sessão. Nas contas profissionais ou escolares, o administrador pode ter desativado o IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider iniciou a sua sessão, mas o servidor de e-mail recusou o acesso a este endereço. Escolha a mesma conta ao iniciar sessão. Nas contas profissionais ou escolares, o administrador pode ter desativado o IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Não é possível contactar o servidor de e-mail. Verifique a sua ligação e tente novamente.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'O início de sessão com $provider não está disponível nesta versão.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Sessão iniciada novamente. $account está a ser sincronizada.';
  }

  @override
  String get accountSetupSignInAgain => 'Iniciar sessão novamente';

  @override
  String get accountSetupSigningIn => 'A iniciar sessão…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider já não aceita o início de sessão do Loupe para $email, por isso $account não está a ser sincronizada. Inicie sessão novamente para receber o e-mail.';
  }

  @override
  String get accountImportTitle => 'Importar do Thunderbird';

  @override
  String get accountImportPointCamera => 'Aponte a câmara para o código QR que o Thunderbird mostra.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned de $total lidos';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned de $total códigos lidos',
      one: '$scanned de $total código lido',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas até agora',
      one: '$count conta até agora',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'No computador, abra o Thunderbird e escolha Ferramentas › Exportar para dispositivos móveis. Selecione as suas contas e leia cada código que aparecer. Os códigos podem ser lidos por qualquer ordem.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuar com $count contas',
      one: 'Continuar com $count conta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Colar texto em vez disso';

  @override
  String get accountImportStartOver => 'Recomeçar';

  @override
  String get accountImportDuplicateCode => 'Esse código já foi adicionado.';

  @override
  String get accountImportRestarted =>
      'Este código é de uma nova exportação, por isso os códigos lidos antes foram postos de parte.';

  @override
  String get accountImportNotThunderbird => 'Este não é um código de conta do Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Este código vem de um Thunderbird mais recente. Atualize o Loupe para o importar.';

  @override
  String get accountImportDamaged => 'Não foi possível ler este código do Thunderbird.';

  @override
  String get accountImportTooLarge => 'Este código é demasiado grande para ser uma exportação do Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Não foi possível abrir as Definições.';

  @override
  String get accountImportCameraOffTitle => 'O acesso à câmara está desativado';

  @override
  String get accountImportCameraOffText =>
      'Permita que o Loupe use a câmara nas Definições para ler o código, ou cole antes o texto do código.';

  @override
  String get accountImportNoCameraTitle => 'Sem câmara';

  @override
  String get accountImportNoCameraText => 'O Loupe não consegue usar uma câmara aqui. Cole antes o texto do código.';

  @override
  String get accountImportCameraFailedTitle => 'Não foi possível iniciar a câmara';

  @override
  String get accountImportCameraFailedText => 'Tente novamente ou cole antes o texto do código.';

  @override
  String get accountImportOpenSettings => 'Abrir Definições';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas encontradas',
      one: '$count conta encontrada',
      zero: 'Nenhuma conta encontrada',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Não foi possível ler nenhuma das contas destes códigos.';

  @override
  String get accountImportChoose => 'Escolha as contas a adicionar ao Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Não foram lidos $count códigos ($codes de $total), por isso as respetivas contas não aparecem.',
      one: 'Não foi lido $count código ($codes de $total), por isso as respetivas contas não aparecem.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes e $last';
  }

  @override
  String get accountImportScanMore => 'Ler mais códigos';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Não foi possível ler $count contas dos códigos. Podem usar definições de um Thunderbird mais recente.',
      one: 'Não foi possível ler $count conta dos códigos. Pode usar definições de um Thunderbird mais recente.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Ler novamente';

  @override
  String get accountImportAlreadyAdded => 'Já existe uma conta com este endereço no Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Vai iniciar sessão com $provider quando a conta for adicionada, tal como no Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Adicione a conta com uma palavra-passe de aplicação (requer a Validação em dois passos).';

  @override
  String get accountImportGmailNoSignIn =>
      'O Thunderbird inicia sessão no Gmail com a Google. «Iniciar sessão com Google» chega numa versão posterior; até lá, adicione a conta com uma palavra-passe de aplicação (requer a Validação em dois passos).';

  @override
  String get accountImportBrowserSignIn =>
      'O Thunderbird inicia sessão nesta conta no navegador. O Loupe ainda não consegue fazê-lo: use uma palavra-passe de aplicação se o seu fornecedor oferecer uma.';

  @override
  String get accountImportUnencrypted => 'Liga-se sem encriptação. Use isto apenas na sua própria rede.';

  @override
  String get accountImportEnterAgain => 'Introduza-a novamente';

  @override
  String get accountImportAdded => 'Adicionada';

  @override
  String accountImportAdding(int index, int total) {
    return 'A adicionar $index de $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Adicionar $count contas',
      one: 'Adicionar $count conta',
      zero: 'Adicionar contas',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Colar texto da exportação';

  @override
  String get accountImportPasteText => 'Cole o texto de um código de exportação do Thunderbird, um código por linha.';

  @override
  String get accountImportPop3 => 'As contas POP3 não são suportadas. O Loupe mantém o e-mail no servidor com IMAP.';

  @override
  String get accountImportKerberos => 'Esta conta inicia sessão com Kerberos, que o Loupe não suporta.';

  @override
  String get accountImportNtlm => 'Esta conta inicia sessão com NTLM, que o Loupe não suporta.';

  @override
  String get accountImportClientCertificate =>
      'Esta conta inicia sessão com um certificado de cliente, que o Loupe ainda não suporta.';

  @override
  String get accountImportMicrosoftSignIn =>
      'O início de sessão com Microsoft chega numa versão posterior. As contas Outlook e Microsoft 365 já não aceitam palavras-passe de aplicações de e-mail.';

  @override
  String get accountImportEnterPassword => 'Introduza a palavra-passe.';

  @override
  String get accountImportEnterAppPassword => 'Introduza a palavra-passe de aplicação.';

  @override
  String get accountImportEnterApiToken => 'Introduza o token de API.';

  @override
  String get accountImportStorageFailed =>
      'O Loupe não conseguiu abrir o armazenamento de contas. Tente novamente mais tarde.';

  @override
  String get accountImportFailed => 'Não foi possível adicionar a conta. Tente novamente ou adicione-a manualmente.';

  @override
  String get composeNewMessageTitle => 'Nova mensagem';

  @override
  String get composeAttach => 'Anexar';

  @override
  String get composeSendLater => 'Enviar mais tarde';

  @override
  String composeSendAt(String time) {
    return 'Enviar $time';
  }

  @override
  String get composeSendHint => 'Toque longo para enviar mais tarde';

  @override
  String get composeNoAccount => 'Adicione uma conta para enviar e-mail.';

  @override
  String get composeTo => 'Para:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, De: $email';
  }

  @override
  String get composeFromLabel => 'De:';

  @override
  String get composeSubjectLabel => 'Assunto:';

  @override
  String composeReplyTo(String address) {
    return 'Responder a: $address';
  }

  @override
  String get composeFrom => 'De';

  @override
  String composeReplyFrom(String email) {
    return 'Responder a partir de $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Enviar a partir de $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Responder a partir de $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Enviar a partir de $email?';
  }

  @override
  String get composeDismiss => 'Ignorar';

  @override
  String composeAliasNotSaved(String account) {
    return 'Não guardado como identidade · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Guardar como identidade';

  @override
  String composeAliasSaved(String email) {
    return '$email foi guardado como identidade.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Endereço inválido $address';
  }

  @override
  String get composeOriginalNotFound => 'Não foi possível encontrar a mensagem original.';

  @override
  String get composeDraftNotFound => 'Não foi possível encontrar o rascunho.';

  @override
  String get composeAttachmentsLost => 'Não foi possível recuperar os anexos. Adicione-os novamente.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Não foi possível adicionar alguns anexos: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Os anexos totalizam $size; alguns servidores recusam mensagens deste tamanho.';
  }

  @override
  String get composeAttachFailed => 'Não foi possível anexar o ficheiro.';

  @override
  String get composeInvalidAddressTitle => 'Endereço inválido';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» não é um endereço de e-mail válido.';
  }

  @override
  String get composeNoSubjectTitle => 'Sem assunto';

  @override
  String get composeNoSubjectText => 'Esta mensagem não tem assunto. Enviar mesmo assim?';

  @override
  String get composeSentBeforeChanges => 'Foi enviada antes das suas alterações, que estão guardadas em Rascunhos.';

  @override
  String composeScheduled(String time) {
    return 'Agendada para $time';
  }

  @override
  String get composeSending => 'A enviar…';

  @override
  String get composeSent => 'Enviada';

  @override
  String get composeSendFailed => 'Não foi possível enviar. Tente novamente.';

  @override
  String get composeAlreadySent => 'Já foi enviada.';

  @override
  String get composeDiscardChanges => 'Descartar alterações';

  @override
  String get composeSaveChanges => 'Guardar alterações';

  @override
  String get composeDeleteDraft => 'Eliminar rascunho';

  @override
  String get composeSaveDraft => 'Guardar rascunho';

  @override
  String get composeDraftSaved => 'Rascunho guardado';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date, às $time, $name escreveu:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date, às $time, alguém escreveu:';
  }

  @override
  String get composeForwardHeader => '---------- Mensagem encaminhada ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date, às $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Assunto: $subject';
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
  String get composeLaterToday => 'Mais tarde hoje';

  @override
  String get composeTomorrowMorning => 'Amanhã de manhã';

  @override
  String get composeMondayMorning => 'Segunda-feira de manhã';

  @override
  String get composePickDateTime => 'Escolher data e hora…';

  @override
  String get composeSendWithoutDelay => 'Enviar imediatamente';

  @override
  String composeSendTimeToday(String time) {
    return 'Hoje às $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Amanhã às $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day às $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Hoje $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Amanhã $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Continuar a editar o rascunho?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Uma mensagem não foi enviada quando o Loupe fechou.',
      'one': 'Uma mensagem para $name não foi enviada quando o Loupe fechou.',
      'other': 'Uma mensagem para $name e outros não foi enviada quando o Loupe fechou.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» não foi enviada quando o Loupe fechou.',
      'one': '«$subject» para $name não foi enviada quando o Loupe fechou.',
      'other': '«$subject» para $name e outros não foi enviada quando o Loupe fechou.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Continuar a editar';

  @override
  String get composeRecoverySave => 'Guardar em Rascunhos';

  @override
  String get composeRecoveryDiscard => 'Descartar';

  @override
  String get composeRecoverySaved => 'Guardada em Rascunhos';

  @override
  String get outboxSectionFailed => 'Não enviadas';

  @override
  String get outboxSectionSending => 'A enviar';

  @override
  String get outboxSectionScheduled => 'Agendadas';

  @override
  String get outboxStatusQueued => 'Envio em breve';

  @override
  String get outboxStatusSending => 'A enviar…';

  @override
  String get outboxStatusFailed => 'Não enviada';

  @override
  String get outboxNoRecipients => 'Sem destinatários';

  @override
  String get outboxNoSubject => '(Sem assunto)';

  @override
  String get outboxSendingFailed => 'O envio falhou.';

  @override
  String get outboxEmptyTitle => 'Nada para enviar';

  @override
  String get outboxEmptyText => 'As mensagens que envia mais tarde esperam aqui até chegar a hora.';

  @override
  String get outboxSendNow => 'Enviar agora';

  @override
  String get outboxReschedule => 'Reagendar';

  @override
  String get outboxRescheduleMenu => 'Reagendar…';

  @override
  String get outboxRescheduleTitle => 'Reagendar';

  @override
  String outboxRescheduled(String time) {
    return 'Reagendada para $time';
  }

  @override
  String get outboxCancel => 'Cancelar';

  @override
  String get outboxCancelSending => 'Cancelar envio…';

  @override
  String get outboxCancelTitle => 'Cancelar o envio?';

  @override
  String get outboxMoveToDrafts => 'Mover para Rascunhos';

  @override
  String get outboxDiscard => 'Descartar mensagem';

  @override
  String get outboxMovedToDrafts => 'Movida para Rascunhos';

  @override
  String get outboxDiscarded => 'Mensagem descartada';

  @override
  String get outboxAlreadySent => 'Já foi enviada.';

  @override
  String get outboxBeingSent => 'Esta mensagem está a ser enviada.';

  @override
  String get outboxActionFailed => 'Não funcionou. A mensagem continua na Caixa de saída.';

  @override
  String get notificationsBadgeInboxes => 'Não lidas nas caixas de entrada';

  @override
  String get notificationsBadgeVip => 'Não lidas de VIPs';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'E-mail novo dos seus VIPs, em qualquer conta';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'E-mail novo em $email';
  }

  @override
  String get notificationsUnknownSender => 'Remetente desconhecido';

  @override
  String get notificationsNoSubject => '(Sem assunto)';

  @override
  String get notificationsEncryptedMessage => 'Mensagem encriptada';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nova mensagem de $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens novas',
      one: '$count mensagem nova',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Novas mensagens em $account';
  }

  @override
  String get platformInstantChannel => 'Entrega instantânea';

  @override
  String get platformInstantChannelDescription =>
      'Aparece enquanto o Loupe vigia as suas caixas de entrada à espera de e-mail novo';

  @override
  String get platformInstantTitle => 'À espera de e-mail novo';

  @override
  String get platformInstantText => 'A Entrega instantânea está ativada';

  @override
  String get platformErrorBox => 'Ocorreu um erro ao mostrar isto. Volte atrás e tente novamente.';

  @override
  String get welcomeTagline => 'E-mail simples por fora\ne poderoso por dentro.';

  @override
  String get welcomeAccountsTitle => 'Todas as contas, uma caixa de entrada tranquila';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail e qualquer servidor IMAP ou JMAP.';

  @override
  String get welcomeSearchTitle => 'Pesquisa que encontra';

  @override
  String get welcomeSearchText => 'Resultados instantâneos no seu dispositivo e depois os do servidor.';

  @override
  String get welcomePrivacyTitle => 'Privado de raiz';

  @override
  String get welcomePrivacyText => 'Sem rastreio. As imagens remotas ficam bloqueadas até decidir o contrário.';

  @override
  String get welcomeAddAccount => 'Adicionar conta';

  @override
  String get welcomeImport => 'Importar do Thunderbird';

  @override
  String get welcomeTryDemo => 'Experimentar com e-mail de demonstração';
}
