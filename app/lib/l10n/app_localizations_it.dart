// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get commonAdd => 'Aggiungi';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonDone => 'Fine';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonMore => 'Altro';

  @override
  String get commonMove => 'Sposta';

  @override
  String get commonName => 'Nome';

  @override
  String get commonNone => 'Nessuno';

  @override
  String get commonOff => 'Disattivato';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Attivato';

  @override
  String get commonOptional => 'Facoltativo';

  @override
  String get commonPassword => 'Password';

  @override
  String get commonRemove => 'Rimuovi';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonSearch => 'Cerca';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Impostazioni';

  @override
  String get commonShare => 'Condividi';

  @override
  String get commonTryAgain => 'Riprova';

  @override
  String get commonUndo => 'Annulla';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count messaggi', one: '$count messaggio');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivia';

  @override
  String get mailDelete => 'Elimina';

  @override
  String get mailFlag => 'Contrassegna';

  @override
  String get mailForward => 'Inoltra';

  @override
  String get mailMarkAsRead => 'Segna come letto';

  @override
  String get mailMarkAsUnread => 'Segna come non letto';

  @override
  String get mailMoveToJunk => 'Sposta in Spam';

  @override
  String get mailNewMessage => 'Nuovo messaggio';

  @override
  String get mailNoSubject => 'Nessun oggetto';

  @override
  String get mailReply => 'Rispondi';

  @override
  String get mailReplyAll => 'Rispondi a tutti';

  @override
  String get mailSend => 'Invia';

  @override
  String get mailUnflag => 'Rimuovi contrassegno';

  @override
  String get mailboxArchive => 'Archivio';

  @override
  String get mailboxDrafts => 'Bozze';

  @override
  String get mailboxInbox => 'Posta in arrivo';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Posta in uscita';

  @override
  String get mailboxSent => 'Inviati';

  @override
  String get mailboxTrash => 'Cestino';

  @override
  String get conversationSomethingWentWrong => 'Si è verificato un errore. Riprova.';

  @override
  String get conversationReplyToList => 'Rispondi alla lista';

  @override
  String get conversationReplyList => 'Rispondi alla lista';

  @override
  String get conversationThreadMuted => 'Thread silenziato. I nuovi messaggi arriveranno già letti.';

  @override
  String get conversationThreadUnmuted => 'Thread non più silenziato.';

  @override
  String get conversationLinkFailed => 'Impossibile aprire il link.';

  @override
  String get conversationGoneTitle => 'Nessun messaggio';

  @override
  String get conversationGoneText => 'Questo messaggio è stato spostato o eliminato.';

  @override
  String get conversationMuted => 'Silenziato';

  @override
  String get conversationReaderOptions => 'Opzioni di lettura';

  @override
  String get conversationReaderOptionsHint => 'Dimensione del testo e vista';

  @override
  String get conversationTrash => 'Cestino';

  @override
  String get conversationReplyHint => 'Pressione prolungata per Rispondi a tutti e Inoltra';

  @override
  String get conversationOfflineTitle => 'Sei offline';

  @override
  String get conversationOfflineText =>
      'Questa conversazione non è ancora stata scaricata. Verrà caricata quando tornerai online.';

  @override
  String get conversationErrorTitle => 'Impossibile mostrare questo messaggio';

  @override
  String get conversationErrorText => 'Si è verificato un errore.';

  @override
  String get conversationOfflineBanner => 'Sei offline';

  @override
  String get conversationNotUpdated => 'Non aggiornata';

  @override
  String get conversationMe => 'me';

  @override
  String get conversationNoSender => '(nessun mittente)';

  @override
  String get conversationNoRecipients => 'nessun destinatario';

  @override
  String conversationRecipients(String names) {
    return 'a $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'a $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Da';

  @override
  String get conversationHeaderTo => 'A';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Ccn';

  @override
  String get conversationHeaderReplyTo => 'Rispondi a';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Sicurezza';

  @override
  String get conversationVerifiedSender => 'Mittente verificato';

  @override
  String get conversationUnverifiedSender => 'Mittente non verificato';

  @override
  String get conversationLoadingMessage => 'Caricamento del messaggio';

  @override
  String get conversationBodyError => 'Impossibile caricare questo messaggio.';

  @override
  String get conversationBodyOffline => 'Sei offline. Il messaggio verrà caricato quando tornerai online.';

  @override
  String get conversationOriginalHint => 'Si vede meglio nella vista Originale';

  @override
  String get conversationShowOriginal => 'Mostra originale';

  @override
  String get conversationScrollToTop => 'Torna all’inizio';

  @override
  String get conversationTagsMenu => 'Tag…';

  @override
  String get conversationMuteThread => 'Silenzia thread';

  @override
  String get conversationUnmuteThread => 'Riattiva thread';

  @override
  String get conversationMoveMenu => 'Sposta…';

  @override
  String get conversationDeletePermanently => 'Elimina definitivamente';

  @override
  String get conversationMoveToTrash => 'Sposta nel Cestino';

  @override
  String get conversationNotJunk => 'Non è spam';

  @override
  String get conversationShowAllHeaders => 'Mostra tutte le intestazioni';

  @override
  String get conversationViewSource => 'Visualizza sorgente';

  @override
  String get conversationSaveAsFile => 'Salva come file…';

  @override
  String get conversationShareAsFile => 'Condividi come file…';

  @override
  String get conversationSearchFromMessageMenu => 'Cerca a partire da questo messaggio…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copia indirizzo';

  @override
  String get conversationAddressCopied => 'Indirizzo copiato';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Cerca messaggi da $name';
  }

  @override
  String get conversationTags => 'Tag';

  @override
  String get conversationAllHeaders => 'Tutte le intestazioni';

  @override
  String get conversationCopyAll => 'Copia tutto';

  @override
  String get conversationHeadersCopied => 'Intestazioni copiate';

  @override
  String get conversationNoHeaders => 'Nessuna intestazione';

  @override
  String get conversationSearchFromMessageTitle => 'Cerca a partire da questo messaggio';

  @override
  String conversationSearchFrom(String name) {
    return 'Da $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'A $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Oggetto «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Sorgente';

  @override
  String get conversationSourceCopied => 'Sorgente copiato';

  @override
  String get conversationShareFailed => 'Impossibile condividere il messaggio.';

  @override
  String get conversationWrapLines => 'A capo automatico';

  @override
  String get conversationDontWrapLines => 'Disattiva a capo automatico';

  @override
  String get conversationSourceError => 'Impossibile caricare il sorgente.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Vengono mostrati i primi $shown di $total. Copia o condividi per averlo tutto.';
  }

  @override
  String get conversationAttachmentUntitled => 'Senza titolo';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Altre azioni per $name';
  }

  @override
  String get conversationMoveTo => 'Sposta in…';

  @override
  String get conversationMailboxesError => 'Impossibile caricare le caselle.';

  @override
  String get conversationReaderReadable => 'Leggibile';

  @override
  String get conversationReaderOriginal => 'Originale';

  @override
  String get conversationReaderPlain => 'Testo';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Mantieni i colori originali';

  @override
  String get conversationReaderRemember => 'Ricorda per questo mittente';

  @override
  String get conversationSecurityPossiblePhishing => 'Possibile phishing';

  @override
  String get conversationSecurityBeCareful => 'Attenzione';

  @override
  String get conversationSecurityVerified => 'Verificato';

  @override
  String get conversationSecurityNoIssues => 'Nessun problema rilevato';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tracker', one: '$count tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Mostra il motivo';

  @override
  String get conversationPhishingBannerTitle => 'Questo messaggio sembra phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Link e immagini sono disattivati.';
  }

  @override
  String get conversationPhishingBannerText => 'Link e immagini sono disattivati.';

  @override
  String get conversationPhishingWhy => 'Perché?';

  @override
  String get conversationPhishingShowAnyway => 'Mostra comunque';

  @override
  String get conversationSecurityPhishingTitle => 'Sembra phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Diversi indizi dicono che questo messaggio non è ciò che afferma di essere.';

  @override
  String get conversationSecurityCarefulTitle => 'Attenzione a questo messaggio';

  @override
  String get conversationSecurityCarefulText => 'C’è qualcosa che merita un secondo sguardo.';

  @override
  String get conversationSecurityVerifiedText => 'Il mittente è verificato e niente sembra sospetto.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Niente sembra sospetto. Il tuo server di posta non ha indicato se il mittente è verificato.';

  @override
  String get conversationSecurityNothingSuspicious => 'Niente sembra sospetto.';

  @override
  String get conversationSecurityWhy => 'Perché';

  @override
  String get conversationSecurityPrivacy => 'Privacy';

  @override
  String get conversationSecurityNoTrackingPixels => 'Nessun pixel di tracciamento';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pixel di tracciamento rimossi',
      one: '$count pixel di tracciamento rimosso',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Avrebbero detto al mittente quando hai aperto questo messaggio.';

  @override
  String get conversationSecurityNoRemoteImages => 'Nessuna immagine remota';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count immagini remote',
      one: '$count immagine remota',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Caricarle comunica al mittente quando leggi questo messaggio, e il tuo indirizzo IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Nessun tracciamento dei clic';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count link passano da tracker dei clic',
      one: '$count link passa da tracker dei clic',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Il tuo clic verrebbe registrato da $services. Tieni premuto un link per aprire direttamente la destinazione.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Dettagli tecnici';

  @override
  String get conversationSecurityCheckedLocally => 'Controllato su questo dispositivo. Non è stato inviato nulla.';

  @override
  String get conversationSecurityTrackersLabel => 'Tracker';

  @override
  String get conversationSecurityImagesFrom => 'Immagini da';

  @override
  String get conversationSecuritySenderHistory => 'Cronologia del mittente';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received ricevuti, $sent inviati';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'I link portano a';

  @override
  String get conversationSecurityHidden => 'Nascosti';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementi',
      one: '$elements elemento',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters caratteri',
      one: '$characters carattere',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Mittente non verificato';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Il tuo server di posta non ha potuto confermare che questo messaggio provenga davvero da $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Il tuo server di posta non ha potuto confermare che questo messaggio provenga davvero dal suo mittente.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Il tuo server di posta non ha potuto confermare che questo messaggio provenga da $domain. Succede spesso con le mailing list.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Il tuo server di posta non ha potuto confermare che questo messaggio provenga dal suo mittente. Succede spesso con le mailing list.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Non dargli seguito se non te lo aspettavi. Nel dubbio, contatta il mittente in un altro modo.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Firmato da un altro dominio';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Il messaggio è firmato da $signer, non da $domain. I servizi di invio lo fanno, ma questo non dimostra chi l’ha scritto.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Il messaggio è firmato da un altro dominio, non da $domain. I servizi di invio lo fanno, ma questo non dimostra chi l’ha scritto.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Il nome mostra un altro indirizzo';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Il nome del mittente è «$shown», ma il messaggio proviene da $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fidati dell’indirizzo, non del nome.';

  @override
  String get conversationSecurityReplyToTitle => 'Le risposte vanno altrove';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Se rispondi, la tua risposta andrà a $address, non a $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Controlla l’indirizzo prima di rispondere con qualcosa di personale.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Usa il tuo nome';

  @override
  String get conversationSecurityImpersonationTitle => 'Usa il nome di qualcuno che conosci';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'È firmato «$name», come il tuo nome, ma arriva da un nuovo indirizzo: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'È firmato «$name», come il tuo VIP $knownName ($knownEmail), ma arriva da un nuovo indirizzo: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'È firmato «$name», come $knownName ($knownEmail), ma arriva da un nuovo indirizzo: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'E le risposte andrebbero a un altro indirizzo ancora.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Se chiede soldi, codici o file, verifica prima con la persona in un altro modo.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Indirizzo noto: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Questo indirizzo: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Primo messaggio da questo mittente';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Non hai mai ricevuto posta da $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Fai attenzione alle richieste di persone che non conosci ancora.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Lettere ingannevoli nell’indirizzo del mittente';

  @override
  String get conversationSecurityLinkHomographTitle => 'Lettere ingannevoli in un link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mescola lettere di alfabeti diversi per imitare un altro indirizzo.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host usa lettere simili: non è $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Eliminalo o segnalalo come spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Non aprirlo.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Dominio: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Dominio sosia';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Usa un nome familiare nel dominio';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain somiglia al tuo dominio, $real, ma è un dominio diverso.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain somiglia a $brand ($real), ma è un dominio diverso.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain usa il nome del tuo dominio, $real, ma non gli appartiene.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain usa il nome di $brand ($real), ma non gli appartiene.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'I messaggi autentici della tua organizzazione arrivano da $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'I messaggi autentici di $brand arrivano da $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Dominio del mittente: $domain';
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
      other: '$count link nascondono dove portano',
      one: 'Un link nasconde dove porta',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Un link mostra $shown, ma apre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Non accedere e non pagare tramite questi link. Digita tu stesso l’indirizzo.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Impossibile verificare la destinazione di un link';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Un link mostra $shown, ma passa da $host, che registra il clic prima di inoltrarlo.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Un link punta a un semplice indirizzo IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts non è un sito con un nome. Le aziende vere usano raramente link di questo tipo.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Un link camuffato';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Un link inizia con «$shown@» per sembrare $shown, ma apre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Una pagina nascosta è stata disattivata';

  @override
  String get conversationSecurityDataLinkText =>
      'Un link avrebbe aperto una pagina contenuta nel messaggio, un modo per aggirare i controlli sui link.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Chiede una password';

  @override
  String get conversationSecurityPasswordFieldText => 'Il messaggio conteneva un campo password. Loupe l’ha rimosso.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Non digitare mai una password in un’email.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Un link che esegue codice è stato disattivato';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe non esegue mai codice proveniente dai messaggi.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Link abbreviati',
      one: 'Un link abbreviato',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts nasconde la destinazione reale finché non lo apri.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Indirizzo web internazionale';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts usa lettere non latine. È normale per molte lingue; verifica che sia il sito che ti aspetti.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Molto testo nascosto';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Sono stati rimossi $count caratteri di testo invisibile. Il testo nascosto come questo serve a ingannare i filtri antispam.',
      one:
          'È stato rimosso $count carattere di testo invisibile. Il testo nascosto come questo serve a ingannare i filtri antispam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Testo nascosto rimosso';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sono stati rimossi $count caratteri di testo invisibile.',
      one: 'È stato rimosso $count carattere di testo invisibile.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Impossibile scaricare il messaggio. Controlla la connessione e riprova.';

  @override
  String exportSaved(String name) {
    return '«$name» salvato';
  }

  @override
  String get exportSaveFailed => 'Impossibile salvare il messaggio.';

  @override
  String exportFailed(String folder) {
    return 'Impossibile esportare «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return '«$folder» non contiene messaggi da esportare.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Impossibile esportare «$folder»: non è stato possibile scaricare nessun messaggio. Controlla la connessione e riprova.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '«$name» salvato senza $formattedCount messaggi che non è stato possibile scaricare.',
      one: '«$name» salvato senza $count messaggio che non è stato possibile scaricare.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Impossibile salvare «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'Esportazione di «$folder»';
  }

  @override
  String get exportListing => 'Ricerca dei messaggi…';

  @override
  String exportProgress(String current, String total) {
    return 'Esportazione di $current su $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Impossibile scaricare $formattedCount messaggi',
      one: 'Impossibile scaricare $count messaggio',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Caselle';

  @override
  String get mailboxesShown => 'Visibile';

  @override
  String get mailboxesHidden => 'Nascosta';

  @override
  String get mailboxesCollapse => 'Comprimi';

  @override
  String get mailboxesExpand => 'Espandi';

  @override
  String get mailboxesManageVips => 'Gestisci VIP';

  @override
  String get mailboxesSubscriptions => 'Iscrizioni';

  @override
  String mailboxesShowAccount(String account) {
    return 'Mostra $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Nascondi $account';
  }

  @override
  String get mailboxesExportFolder => 'Esporta cartella…';

  @override
  String get mailboxesUnpin => 'Rimuovi';

  @override
  String get mailboxesLists => 'Liste';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Salva una ricerca per tenerla qui.';

  @override
  String get mailboxesTags => 'Tag';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Puoi anche toccare il nome di un mittente in un messaggio e attivare VIP.';

  @override
  String get mailboxesAddVip => 'Aggiungi VIP…';

  @override
  String get mailboxesAddVipTitle => 'Aggiungi VIP';

  @override
  String get mailboxesAddVipText => 'La posta da questo indirizzo riceve una stella e compare nella casella VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'nome@example.com';

  @override
  String get messageListFilterUnread => 'Non letti';

  @override
  String get messageListFilterFlagged => 'Contrassegnati';

  @override
  String get messageListFilterToMe => 'A: me';

  @override
  String get messageListFilterCcMe => 'Cc: me';

  @override
  String get messageListFilterWithAttachments => 'Con allegati';

  @override
  String get messageListFilterUnreplied => 'Senza risposta';

  @override
  String get messageListFilterFromVips => 'Da VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi segnati come letti',
      one: '$count messaggio segnato come letto',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Impossibile caricare la posta meno recente.';

  @override
  String get messageListSelectMessages => 'Seleziona messaggi';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selezionate',
      one: '$count selezionata',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Seleziona tutto';

  @override
  String get messageListDeselectAll => 'Deseleziona tutto';

  @override
  String get messageListLoadFailed => 'Impossibile caricare la posta';

  @override
  String get messageListNoUnread => 'Nessun messaggio non letto';

  @override
  String get messageListNoMatches => 'Nessun messaggio corrispondente';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtrato per: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Disattiva filtro';

  @override
  String get messageListEmpty => 'Nessun messaggio';

  @override
  String get messageListFilter => 'Filtra';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Criteri del filtro: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtrato per:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount non letti',
      one: '$formattedCount non letto',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Segna';

  @override
  String get messageListTrash => 'Cestino';

  @override
  String get messageListFilterTitle => 'Filtra';

  @override
  String get messageListFilterInclude => 'INCLUDI';

  @override
  String get panesHideMailboxes => 'Nascondi caselle';

  @override
  String get panesShowMailboxes => 'Mostra caselle';

  @override
  String get panesMailboxesWidth => 'Larghezza delle caselle';

  @override
  String get panesListWidth => 'Larghezza dell’elenco dei messaggi';

  @override
  String get panesNoMessageSelected => 'Nessun messaggio selezionato';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count messaggi', one: '$count messaggio');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Posticipati';

  @override
  String get snoozeSheetTitle => 'Posticipa';

  @override
  String get snoozeLaterToday => 'Più tardi oggi';

  @override
  String get snoozeThisEvening => 'Stasera';

  @override
  String get snoozeTomorrow => 'Domani';

  @override
  String get snoozeThisWeekend => 'Questo fine settimana';

  @override
  String get snoozeNextWeek => 'Settimana prossima';

  @override
  String get snoozePickDateTime => 'Scegli data e ora…';

  @override
  String get snoozeMenu => 'Posticipa…';

  @override
  String get snoozeWakeNow => 'Riporta ora';

  @override
  String get snoozeChangeTimeMenu => 'Cambia orario del posticipo…';

  @override
  String get snoozeChangeTime => 'Cambia orario';

  @override
  String get snoozeNoTime => 'Nessun orario impostato';

  @override
  String get snoozeFooter =>
      'I messaggi posticipati tornano nella Posta in arrivo, come non letti, all’orario stabilito.';

  @override
  String get snoozeEmptyTitle => 'Niente di posticipato';

  @override
  String get snoozeEmptyText => 'Posticipa un messaggio per farlo tornare nella Posta in arrivo quando ti serve.';

  @override
  String get appLockUnlock => 'Sblocca';

  @override
  String get appLockFailed => 'Loupe non è riuscita a confermare che sei tu.';

  @override
  String get appLockLockedOut => 'Troppi tentativi. Riprova più tardi.';

  @override
  String get appLockPromptError => 'Impossibile mostrare la richiesta. Riprova.';

  @override
  String get appLockNoScreenLock => 'Questo telefono non ha un blocco schermo.';

  @override
  String get appLockUnlockPromptTitle => 'Sblocca Loupe';

  @override
  String get appLockUnlockPromptReason => 'Conferma che sei tu per vedere la tua posta.';

  @override
  String get appLockTurnOnPromptTitle => 'Attiva Blocco app';

  @override
  String get appLockTurnOnPromptReason => 'Conferma che sei tu per attivare Blocco app.';

  @override
  String get appLockScreenLockRemoved =>
      'Blocco app è disattivato: questo telefono non ha più un blocco schermo. Impostane uno per riattivare Blocco app.';

  @override
  String get appLockAfterImmediately => 'Subito';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuti', one: '$count minuto');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ore', one: '$count ora');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Cifrato';

  @override
  String get openpgpEncryptedInPart => 'Cifrato in parte';

  @override
  String get openpgpEncryptedLocked => 'Cifrato · bloccato';

  @override
  String get openpgpEncryptedNoKey => 'Cifrato · nessuna chiave';

  @override
  String get openpgpEncryptedDamaged => 'Cifrato · danneggiato';

  @override
  String get openpgpEncryptedUnsupported => 'Cifrato · non supportato';

  @override
  String get openpgpUnknownSigner => 'sconosciuto';

  @override
  String get openpgpUnknownKey => 'Chiave sconosciuta';

  @override
  String get openpgpSignatureInvalid => 'Firma non valida';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Firmato da $name, non dal mittente';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Firmato in parte da $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Firmato da $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Firmato con una chiave rifiutata';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Firmato da $name · chiave non accettata';
  }

  @override
  String get openpgpUnlock => 'Sblocca';

  @override
  String get openpgpCantDecrypt => 'Impossibile decifrare questo messaggio';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Cifrato con OpenPGP';

  @override
  String get openpgpEncryption => 'Crittografia';

  @override
  String get openpgpDecryptedHere => 'Decifrato su questo dispositivo';

  @override
  String get openpgpNotDecrypted => 'Non decifrato';

  @override
  String get openpgpKeyLocked => 'La tua chiave è bloccata.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Per le chiavi $keys',
      one: 'Per la chiave $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Oggetto protetto';

  @override
  String get openpgpUnlockKey => 'Sblocca chiave';

  @override
  String get openpgpSignature => 'Firma';

  @override
  String get openpgpFingerprint => 'Impronta digitale';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID chiave $id';
  }

  @override
  String get openpgpSigned => 'Firmato il';

  @override
  String get openpgpProblem => 'Problema';

  @override
  String get openpgpAcceptance => 'Accettazione';

  @override
  String get openpgpChangeAcceptance => 'Cambia accettazione…';

  @override
  String get openpgpCheckedFooter => 'Verificato su questo dispositivo con OpenPGP, compatibile con Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'La tua chiave è bloccata. Sbloccala con la sua passphrase per leggere questo messaggio.';

  @override
  String get openpgpSummaryNoSecretKey => 'È stato cifrato per una chiave che non si trova su questo dispositivo.';

  @override
  String get openpgpSummaryDamaged => 'I dati cifrati sono danneggiati o sono stati modificati lungo il percorso.';

  @override
  String get openpgpSummaryUnsupported => 'Usa un algoritmo che Loupe non supporta.';

  @override
  String get openpgpSummaryEncrypted => 'Solo tu e gli altri destinatari potete leggerlo.';

  @override
  String get openpgpSummaryNotSigned => 'Non è firmato, quindi il mittente non è confermato.';

  @override
  String get openpgpSummaryUnknownKey =>
      'È firmato, ma con una chiave che non hai, quindi la firma non può essere verificata.';

  @override
  String get openpgpSummaryBadSignature => 'La firma non corrisponde: il messaggio potrebbe essere stato modificato.';

  @override
  String get openpgpSummaryMismatch =>
      'La firma è valida, ma la chiave appartiene a un indirizzo diverso da quello del mittente.';

  @override
  String get openpgpSummaryPartial =>
      'Solo una parte del messaggio è firmata. Il testo al di fuori della firma (ad esempio il piè di pagina di una mailing list) è mostrato sotto la riga «Unsigned content», e anche altre parti del messaggio, come gli allegati, non sono coperte.';

  @override
  String get openpgpSummaryOwnKey => 'Firmato con la tua chiave.';

  @override
  String get openpgpSummaryVerified => 'La firma è valida e hai verificato l’impronta digitale della chiave.';

  @override
  String get openpgpSummaryUnverified =>
      'La firma è valida. Hai accettato la chiave senza controllarne l’impronta digitale.';

  @override
  String get openpgpSummaryRejected => 'La firma è valida, ma hai rifiutato questa chiave.';

  @override
  String get openpgpSummaryUndecided =>
      'La firma è valida, ma non hai ancora accettato questa chiave. Confronta la sua impronta digitale con il mittente.';

  @override
  String get openpgpAcceptanceRejected => 'Rifiutata';

  @override
  String get openpgpAcceptanceUndecided => 'Non accettata';

  @override
  String get openpgpAcceptanceUnverified => 'Accettata';

  @override
  String get openpgpAcceptanceVerified => 'Accettata e verificata';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Accettare la chiave di $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Impronta digitale $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Sì, ho verificato l’impronta digitale';

  @override
  String get openpgpAcceptUnverified => 'Sì, senza controllare';

  @override
  String get openpgpAcceptLater => 'Non ancora';

  @override
  String get openpgpRejectKey => 'Rifiuta questa chiave';

  @override
  String get openpgpNoSubject => '(nessun oggetto)';

  @override
  String get openpgpEncryptionTitle => 'Crittografia end-to-end';

  @override
  String get openpgpMyKeys => 'Le mie chiavi OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Con una chiave puoi leggere la posta cifrata e firmare e cifrare la tua. Usi Thunderbird? Esporta lì la tua chiave (Impostazioni account › Crittografia end-to-end › Esporta chiave segreta) e importala qui.';

  @override
  String get openpgpAddKey => 'Aggiungi chiave…';

  @override
  String get openpgpAddresses => 'Indirizzi';

  @override
  String get openpgpAddressesFooter => 'Quale chiave usa ogni indirizzo, e quando cifra e firma.';

  @override
  String get openpgpCorrespondentsKeys => 'Chiavi OpenPGP dei corrispondenti';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Accetta una chiave quando sei certo che appartenga al suo proprietario; confronta l’impronta digitale con il proprietario per segnarla come verificata.';

  @override
  String get openpgpImportPublicKey => 'Importa chiave pubblica…';

  @override
  String get openpgpCollected => 'Raccolte da Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Chiavi arrivate con i messaggi. Loupe può cifrare per loro quando entrambe le parti lo chiedono.';

  @override
  String get openpgpOnThisDevice => 'Su questo dispositivo';

  @override
  String get openpgpOnThisDeviceFooter =>
      'I messaggi cifrati nascondono l’oggetto. Loupe conserva l’oggetto di ogni messaggio che apri nel suo database cifrato su questo dispositivo, così l’elenco, la ricerca e le notifiche possono mostrarlo. In background, Loupe può anche decifrare l’oggetto dei nuovi messaggi con le chiavi senza passphrase; per farlo scarica ogni messaggio (fino a 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Decifra gli oggetti in background';

  @override
  String get openpgpIndexFooter =>
      'La ricerca trova i messaggi cifrati in base a mittente, destinatari e oggetto. Con questa opzione attiva, Loupe aggiunge anche il testo di ogni messaggio cifrato che decifra all’indice di ricerca nel suo database cifrato su questo dispositivo, così la ricerca lo trova anche in base al testo. Disattivandola, quel testo viene rimosso dall’indice.';

  @override
  String get openpgpIndexDecrypted => 'Indicizza i messaggi decifrati per la ricerca';

  @override
  String get openpgpPassphrases => 'Passphrase';

  @override
  String get openpgpPassphrasesFooter =>
      'Le chiavi OpenPGP e i certificati S/MIME protetti da una passphrase vengono sbloccati quando servono. Senza «Ricorda», vengono bloccati di nuovo due minuti dopo ogni utilizzo.';

  @override
  String get openpgpRememberPassphrases => 'Ricorda le passphrase';

  @override
  String get openpgpRememberPassphrasesDetail => 'Fino alla chiusura di Loupe';

  @override
  String get openpgpLockKeysNow => 'Blocca le chiavi ora';

  @override
  String get openpgpKeysLocked => 'Chiavi bloccate.';

  @override
  String get openpgpKeyStateRevoked => 'revocata';

  @override
  String get openpgpKeyStateExpired => 'scaduta';

  @override
  String get openpgpKeyStateNeverExpires => 'non scade mai';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'scade il $date';
  }

  @override
  String get openpgpNoKey => 'Nessuna chiave';

  @override
  String get openpgpAlwaysEncrypt => 'Cifra sempre';

  @override
  String get openpgpAddKeyTitle => 'Aggiungi una chiave OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importa la chiave che usi in Thunderbird, oppure creane una nuova.';

  @override
  String get openpgpImportFromClipboard => 'Importa dagli appunti';

  @override
  String get openpgpImportFromFile => 'Importa da file';

  @override
  String get openpgpGenerateNewKey => 'Genera nuova chiave';

  @override
  String get openpgpImportPublicKeyTitle => 'Importa una chiave pubblica';

  @override
  String get openpgpFromClipboard => 'Dagli appunti';

  @override
  String get openpgpFromFile => 'Da file';

  @override
  String get openpgpClipboardEmpty => 'Gli appunti sono vuoti. Copia prima la chiave.';

  @override
  String get openpgpKey => 'Chiave';

  @override
  String get openpgpValidityRevoked => 'Revocata';

  @override
  String openpgpValidityExpired(String date) {
    return 'Scaduta il $date';
  }

  @override
  String get openpgpNeverExpires => 'Non scade mai';

  @override
  String openpgpValidUntil(String date) {
    return 'Valida fino al $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Impronta digitale copiata.';

  @override
  String get openpgpAlgorithm => 'Algoritmo';

  @override
  String get openpgpCreated => 'Creata';

  @override
  String get openpgpValidity => 'Validità';

  @override
  String get openpgpProtection => 'Protezione';

  @override
  String get openpgpProtectionPassphrase => 'Passphrase';

  @override
  String get openpgpProtectionKeychain => 'Solo archivio sicuro';

  @override
  String get openpgpKeyDetailsFooter =>
      'Condividi la tua chiave pubblica perché gli altri possano cifrare per te. Il backup è la tua chiave segreta, protetta dalla sua passphrase se ne ha una: tienilo riservato.';

  @override
  String get openpgpSharePublicKey => 'Condividi chiave pubblica';

  @override
  String get openpgpCopyPublicKey => 'Copia chiave pubblica';

  @override
  String get openpgpPublicKeyCopied => 'Chiave pubblica copiata.';

  @override
  String get openpgpBackUpSecretKey => 'Esegui il backup della chiave segreta';

  @override
  String get openpgpDeleteKey => 'Elimina chiave';

  @override
  String get openpgpRemoveKey => 'Rimuovi chiave';

  @override
  String get openpgpBackUpTitle => 'Eseguire il backup della chiave segreta?';

  @override
  String get openpgpBackUpProtected =>
      'Il backup è protetto dalla passphrase della tua chiave. Chi possiede entrambi può leggere la tua posta.';

  @override
  String get openpgpBackUpUnprotected =>
      'Questa chiave non ha una passphrase: chiunque abbia il backup può leggere la tua posta e firmare a tuo nome.';

  @override
  String get openpgpBackUp => 'Esegui backup';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Eliminare la tua chiave $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Rimuovere la chiave di $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'La posta cifrata per questa chiave non potrà più essere letta su questo dispositivo, a meno che tu non la importi di nuovo.';

  @override
  String get openpgpRemoveKeyMessage => 'Potrai importarla di nuovo in seguito.';

  @override
  String get openpgpKeyHeader => 'Chiave OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Aggiungi una chiave in Crittografia end-to-end per cifrare e firmare la posta da questo indirizzo.';

  @override
  String get openpgpGenerateAKey => 'Genera una chiave…';

  @override
  String get openpgpSending => 'Invio';

  @override
  String get openpgpSendingFooter =>
      'La crittografia automatica si attiva quando ogni destinatario ha una chiave accettata o un certificato attendibile, o quando Autocrypt indica che entrambe le parti la vogliono. La posta cifrata è sempre firmata.';

  @override
  String get openpgpEncryptAutomatically => 'Cifra automaticamente';

  @override
  String get openpgpAlwaysEncryptDetail => 'Rifiuta l’invio se un destinatario non ha una chiave';

  @override
  String get openpgpSignUnencrypted => 'Firma la posta non cifrata';

  @override
  String get openpgpAttachPublicKey => 'Allega la mia chiave pubblica';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt invia la tua chiave pubblica con ogni messaggio, così le altre app possono cifrare per te senza alcuna configurazione.';

  @override
  String get openpgpSendMyKey => 'Invia la mia chiave con la posta';

  @override
  String get openpgpPreferEncryption => 'Preferisci la crittografia';

  @override
  String get openpgpPreferEncryptionDetail => 'Chiedi agli altri di cifrare quando possono';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count anni', one: '$count anno');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Le passphrase non corrispondono.';

  @override
  String openpgpKeyReady(String id) {
    return 'La tua chiave $id è pronta.';
  }

  @override
  String get openpgpNewKey => 'Nuova chiave';

  @override
  String get openpgpNewKeyFor => 'Per';

  @override
  String get openpgpYourName => 'Il tuo nome';

  @override
  String get openpgpAddress => 'Indirizzo';

  @override
  String get openpgpPassphrase => 'Passphrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Facoltativa. Senza passphrase, la chiave è protetta solo dall’archivio sicuro del telefono e Loupe non la chiede mai. Con una passphrase, Loupe te la chiede quando serve la chiave.';

  @override
  String get openpgpRepeatPassphrase => 'Ripeti';

  @override
  String get openpgpExpires => 'Scadenza';

  @override
  String get openpgpExpiresFooter => 'Puoi creare una nuova chiave prima che scada. Anche Thunderbird usa tre anni.';

  @override
  String get openpgpGenerateKey => 'Genera chiave';

  @override
  String get openpgpKeyFor => 'Chiave per';

  @override
  String get openpgpCantEncrypt => 'Impossibile cifrare';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Non c’è una chiave OpenPGP per $names, e questo indirizzo cifra sempre. Rimuovi il destinatario o importa la sua chiave in Impostazioni › Crittografia end-to-end.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Non c’è un certificato S/MIME valido per $names, e questo indirizzo cifra sempre. Rimuovi il destinatario o importa il suo certificato in Impostazioni › Crittografia end-to-end.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Non c’è una chiave OpenPGP per $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Non c’è un certificato S/MIME valido per $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Invia senza cifrare';

  @override
  String get openpgpCantSign => 'Impossibile firmare';

  @override
  String get openpgpCantSignMessage =>
      'La chiave privata del tuo certificato S/MIME non è su questo dispositivo. Importa di nuovo il certificato (un file .p12 o .pfx) in Impostazioni › Crittografia end-to-end.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Nessuna chiave per $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Nessun certificato per $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Chiavi da Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Tutti hanno una chiave';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Tutti hanno un certificato';

  @override
  String get openpgpComposeEncrypt => 'Cifra';

  @override
  String get openpgpComposeSign => 'Firma';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, cambia';
  }

  @override
  String get openpgpNoKeyFound => 'Nessuna chiave OpenPGP trovata.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importare una chiave segreta?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Questo allegato contiene una chiave segreta ($names). Importala come tua chiave solo se l’hai esportata tu, ad esempio da Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importa come mia chiave';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'la tua chiave $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importare $count chiavi ($names)?',
      one: 'Importare la chiave di $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importa e accetta';

  @override
  String get openpgpImportDecideLater => 'Importa, decidi dopo';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'la chiave di $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importate: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sono allegate $count chiavi OpenPGP.',
      one: 'È allegata una chiave OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importa';

  @override
  String get openpgpUnlockKeyTitle => 'Sblocca chiave OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Inserisci la passphrase della chiave di $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Passphrase errata. Riprova.';

  @override
  String get openpgpExplainLocked => 'Questo messaggio è cifrato. Sblocca la tua chiave OpenPGP per leggerlo.';

  @override
  String get openpgpExplainNoKey =>
      'Questo messaggio è cifrato, ma non per una chiave OpenPGP presente su questo dispositivo. Se lo leggi in Thunderbird, importa la tua chiave da lì: Impostazioni › Crittografia end-to-end.';

  @override
  String get openpgpExplainDamaged =>
      'Questo messaggio cifrato è danneggiato, quindi non può essere decifrato in sicurezza.';

  @override
  String get openpgpExplainUnsupported => 'Questo messaggio usa una crittografia che Loupe non sa ancora leggere.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Questo messaggio è cifrato con S/MIME, ma non per un certificato presente su questo dispositivo. Importa il tuo certificato (un file .p12 o .pfx) in Impostazioni › Crittografia end-to-end.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Questo messaggio è cifrato. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Sblocca il tuo certificato S/MIME per leggerlo.';

  @override
  String get openpgpAttachmentGone => 'Questo allegato non è più disponibile.';

  @override
  String get smimeEncrypted => 'Cifrato (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Cifrato (S/MIME) · nessun certificato';

  @override
  String get smimeEncryptedDamaged => 'Cifrato (S/MIME) · danneggiato';

  @override
  String get smimeEncryptedUnsupported => 'Cifrato (S/MIME) · non supportato';

  @override
  String get smimeEncryptedLocked => 'Cifrato (S/MIME) · bloccato';

  @override
  String get smimeUnknownSigner => 'sconosciuto';

  @override
  String get smimeSignatureModified => 'Firma non valida: messaggio modificato';

  @override
  String get smimeSignatureWeak => 'Firma non sicura: algoritmo obsoleto';

  @override
  String get smimeSignatureUncheckable => 'Impossibile verificare la firma';

  @override
  String get smimeSignedCertificateMissing => 'Firmato · certificato mancante';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Firmato da $name · certificato revocato';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Firmato da $name · in un’altra data';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Firmato da $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Firmato da $name · certificato non valido';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Firmato da $name · non attendibile';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Firmato da $name · certificato scaduto';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Firmato da $name · certificato non ancora valido';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Firmato da $name · certificato non per la posta';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Firmato da $name, non dal mittente';
  }

  @override
  String get smimeCantDecrypt => 'Impossibile decifrare questo messaggio';

  @override
  String get smimeEncryptedWithSmime => 'Cifrato con S/MIME';

  @override
  String get smimeEncryption => 'Crittografia';

  @override
  String get smimeDecryptedHere => 'Decifrato su questo dispositivo';

  @override
  String get smimeNotDecrypted => 'Non decifrato';

  @override
  String get smimeAuthenticated => 'autenticata';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'per $count certificati',
      one: 'per $count certificato',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Firma';

  @override
  String get smimeIssuedBy => 'Emesso da';

  @override
  String get smimeValid => 'Validità';

  @override
  String smimeValidRange(String from, String to) {
    return 'dal $from al $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Impronta digitale SHA-256';

  @override
  String get smimeSigned => 'Firmato il';

  @override
  String get smimeProblem => 'Problema';

  @override
  String get smimeCheckingRevocation => 'Verifica della revoca…';

  @override
  String get smimeNotRevoked => 'Non revocato';

  @override
  String get smimeRevoked => 'Revocato';

  @override
  String get smimeRevocationUnknown => 'Revoca sconosciuta';

  @override
  String smimeRevokedSince(String date) {
    return 'Dal $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Chiesto all’autorità (lista di revoca), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Chiesto all’autorità (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Considera attendibile «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Considera attendibile questo certificato…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Verificato su questo dispositivo con S/MIME, compatibile con Outlook e Thunderbird; revoca verificata presso l’autorità di certificazione.';

  @override
  String get smimeCheckedFooter =>
      'Verificato su questo dispositivo con S/MIME, compatibile con Outlook e Thunderbird. La revoca non viene verificata (Impostazioni › Crittografia end-to-end).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Considerare attendibile $name per la posta?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Considerare attendibile il certificato di $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Ogni certificato emesso da questa autorità sarà considerato attendibile, come la CA della tua azienda. Prima confronta l’impronta digitale con il proprietario:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Prima confronta l’impronta digitale con il proprietario:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Considera attendibile';

  @override
  String get smimeSummaryNoKey => 'È stato cifrato per un certificato che non si trova su questo dispositivo.';

  @override
  String get smimeSummaryDamaged => 'I dati cifrati sono danneggiati o sono stati modificati lungo il percorso.';

  @override
  String get smimeSummaryUnsupported => 'Usa un algoritmo che Loupe non supporta.';

  @override
  String get smimeSummaryLocked => 'Il tuo certificato S/MIME è bloccato.';

  @override
  String get smimeSummaryEncrypted => 'Solo tu e gli altri destinatari potete leggerlo.';

  @override
  String get smimeSummaryNotSigned => 'Non è firmato, quindi il mittente non è confermato.';

  @override
  String get smimeSummaryModified => 'La firma non corrisponde: il messaggio è stato modificato dopo la firma.';

  @override
  String get smimeSummaryUncheckable => 'Impossibile verificare la firma.';

  @override
  String get smimeSummaryNoCertificate =>
      'Il certificato del firmatario non è nel messaggio, quindi la firma non può essere verificata.';

  @override
  String get smimeSummaryRevoked =>
      'L’autorità di certificazione ha revocato il certificato del firmatario: la firma non è attendibile.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'L’autorità di certificazione ha revocato il certificato del firmatario ($reason): la firma non è attendibile.';
  }

  @override
  String get smimeDateMismatch =>
      'È stato firmato più di un’ora prima o dopo la data del messaggio: potrebbe essere un vecchio messaggio inviato di nuovo.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'La firma è valida e $issuer garantisce che il certificato appartiene al mittente.';
  }

  @override
  String get smimeProblemInvalidChain => 'Il certificato o uno dei suoi emittenti non è valido.';

  @override
  String get smimeProblemUntrusted => 'Il certificato proviene da un’autorità che Loupe non considera attendibile.';

  @override
  String get smimeProblemExpired => 'Il certificato era scaduto.';

  @override
  String get smimeProblemNotYetValid => 'Il certificato non era ancora valido.';

  @override
  String get smimeProblemWrongUsage => 'Il certificato non è destinato alla posta.';

  @override
  String get smimeProblemWrongAddress => 'Il certificato appartiene a un indirizzo diverso da quello del mittente.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Attendibile · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Non attendibile · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Scaduto il $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Valido dal $date';
  }

  @override
  String get smimeTrustInvalid => 'Non valido';

  @override
  String get smimeTrustNotForMail => 'Non per la posta';

  @override
  String get smimeTrustAnotherAddress => 'Un altro indirizzo';

  @override
  String get smimeMyCertificates => 'I miei certificati S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Per S/MIME, come lo usano Outlook e molte aziende. Importa il tuo certificato con la sua chiave privata (un file .p12 o .pfx), esportato da Outlook, Windows, macOS o Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Per S/MIME, come lo usano Outlook e molte aziende. Importa il tuo certificato con la sua chiave privata (un file .p12 o .pfx), esportato da Outlook, Windows, macOS o Thunderbird, oppure usane uno installato su questo dispositivo da te o dalla tua azienda.';

  @override
  String get smimeCertificateExpired => 'scaduto';

  @override
  String smimeCertificateUntil(String date) {
    return 'fino al $date';
  }

  @override
  String get smimeCertificateOnDevice => 'su questo dispositivo';

  @override
  String get smimeImportCertificateEllipsis => 'Importa certificato…';

  @override
  String get smimeUseDeviceCertificate => 'Usa un certificato di questo dispositivo…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificati dei corrispondenti';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Raccolti dalla posta firmata, come fanno Outlook e Thunderbird. La posta viene cifrata solo per certificati attendibili: Loupe considera attendibili le autorità che Mozilla ritiene attendibili per la posta, e quelle che aggiungi tu.';

  @override
  String get smimeRevocation => 'Revoca';

  @override
  String get smimeRevocationFooter =>
      'Quando apri posta firmata, Loupe chiede all’autorità che ha emesso il certificato del firmatario se è stato revocato (tramite il suo servizio OCSP o la sua lista di revoca). L’autorità può così vedere quando qualcuno dal tuo indirizzo internet legge posta firmata con quel certificato. Le risposte restano su questo dispositivo fino alla loro scadenza. Un certificato revocato compare come «certificato revocato» nell’intestazione del messaggio.';

  @override
  String get smimeCheckRevocation => 'Verifica online la revoca dei certificati';

  @override
  String get smimeTrustedAuthorities => 'Autorità attendibili';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Scelte da te, oltre alle $count che Mozilla ritiene attendibili per la posta.',
      one: 'Scelte da te, oltre a quella che Mozilla ritiene attendibile per la posta.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autorità di certificazione';

  @override
  String get smimeImportACertificate => 'Importa un certificato';

  @override
  String get smimeImportContactMessage =>
      'Il certificato di un corrispondente (.cer, .crt, .pem) o di un’autorità di certificazione.';

  @override
  String get smimeFromClipboard => 'Dagli appunti';

  @override
  String get smimeFromFile => 'Da file';

  @override
  String get smimeClipboardEmpty => 'Gli appunti sono vuoti. Copia prima il certificato.';

  @override
  String get smimeCertificate => 'Certificato';

  @override
  String get smimeOnDeviceFooter =>
      'La sua chiave privata resta nell’archivio credenziali di Android, dove l’hai installata tu o la tua azienda: Loupe chiede ad Android di firmare e decifrare con essa. La posta firmata viene firmata al momento dell’invio.';

  @override
  String get smimeAddresses => 'Indirizzi';

  @override
  String get smimeUsage => 'Per';

  @override
  String get smimeUsageNone => 'Niente che Loupe usi';

  @override
  String get smimeUsageSigning => 'Firma';

  @override
  String get smimeUsageEncryption => 'Crittografia';

  @override
  String get smimeUsageCertificates => 'Certificati';

  @override
  String get smimeAlgorithm => 'Algoritmo';

  @override
  String get smimeSerialNumber => 'Numero di serie';

  @override
  String get smimeFingerprintCopied => 'Impronta digitale copiata.';

  @override
  String get smimeSha1Thumbprint => 'Identificazione personale SHA-1';

  @override
  String get smimePrivateKey => 'Chiave privata';

  @override
  String get smimeKeyOnDevice => 'Su questo dispositivo';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'In Loupe, con una passphrase';

  @override
  String get smimeKeyInLoupe => 'In Loupe';

  @override
  String get smimeSource => 'Origine';

  @override
  String get smimeSourceSignedMail => 'Posta firmata';

  @override
  String get smimeSourceImported => 'Importato';

  @override
  String get smimeTrustHeader => 'Attendibilità';

  @override
  String get smimeTrustedRoot => 'Radice attendibile';

  @override
  String get smimeIssuer => 'Emittente';

  @override
  String smimeTrustNamed(String name) {
    return 'Considera attendibile «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Considera attendibile questa autorità';

  @override
  String get smimeTrustThisCertificate => 'Considera attendibile questo certificato';

  @override
  String get smimeStopTrusting => 'Non considerare più attendibile';

  @override
  String get smimePassphrase => 'Passphrase';

  @override
  String get smimePassphraseFooter =>
      'Facoltativa. Con una passphrase, la chiave privata è cifrata anche su questo dispositivo (Argon2id e AES-256) e Loupe te la chiede per firmare e decifrare; Ricorda le passphrase stabilisce per quanto tempo. La posta che invii viene firmata al momento dell’invio; le attività in background non possono usare la chiave.';

  @override
  String get smimeChangePassphrase => 'Cambia passphrase…';

  @override
  String get smimeSetPassphraseEllipsis => 'Imposta passphrase…';

  @override
  String get smimeRemovePassphrase => 'Rimuovi passphrase';

  @override
  String get smimeShareCertificate => 'Condividi certificato';

  @override
  String get smimeDeleteCertificate => 'Elimina certificato';

  @override
  String get smimeRemoveCertificate => 'Rimuovi certificato';

  @override
  String get smimePassphraseChanged => 'Passphrase cambiata.';

  @override
  String get smimePassphraseSet => 'Passphrase impostata.';

  @override
  String get smimeRemovePassphraseTitle => 'Rimuovere la passphrase?';

  @override
  String get smimeRemovePassphraseMessage =>
      'La chiave privata sarà quindi protetta solo dall’archivio sicuro, come senza passphrase: Loupe non la chiederà più e le attività in background potranno usarla.';

  @override
  String get smimePassphraseRemoved => 'Passphrase rimossa.';

  @override
  String smimeTrustTitle(String name) {
    return 'Considerare attendibile $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Ogni certificato che emette sarà considerato attendibile per la posta. Prima confronta l’impronta digitale con il proprietario:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Eliminare il tuo certificato $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Rimuovere il certificato di $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe smette di usarlo: la posta cifrata per questo certificato non potrà più essere letta in Loupe. Il certificato resta su questo dispositivo (Impostazioni › Sicurezza › Crittografia e credenziali).';

  @override
  String get smimeDeleteOwnMessage =>
      'La sua chiave privata viene eliminata da questo dispositivo: la posta cifrata per questo certificato non potrà più essere letta qui, a meno che tu non lo importi di nuovo.';

  @override
  String get smimeRemoveContactMessage => 'Tornerà con il suo prossimo messaggio firmato.';

  @override
  String get smimeAddressImportFooter =>
      'Importa un certificato per questo indirizzo per firmare e cifrare con S/MIME, come fa Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importa un certificato…';

  @override
  String get smimePreferFooter =>
      'Quando entrambi possono proteggere un messaggio, viene usato quello preferito, a meno che solo l’altro abbia una chiave o un certificato per ogni destinatario.';

  @override
  String get smimePreferSmime => 'Preferisci S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Anziché OpenPGP';

  @override
  String get smimeCertificatePassword => 'Password del certificato';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Inserisci la password con cui è stato esportato il file del certificato.';

  @override
  String get smimeImport => 'Importa';

  @override
  String get smimeWrongPassword => 'Password errata. Riprova.';

  @override
  String get smimeNoCertificateFound => 'Nessun certificato trovato.';

  @override
  String smimeCertificateOf(String name) {
    return 'il certificato di $name';
  }

  @override
  String get smimeNothingNew => 'Niente di nuovo da importare.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importati: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importate $count autorità attendibili.',
      one: 'Importata un’autorità attendibile.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importati $certificates e $count autorità attendibili.',
      one: 'Importati $certificates e un’autorità attendibile.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Questo file non contiene la chiave privata. Esporta il tuo certificato con la sua chiave privata.';

  @override
  String get smimeImportAsYoursTitle => 'Importare come tuo certificato?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Questo allegato contiene un certificato con la sua chiave privata: $names. Importalo solo se l’hai esportato tu, ad esempio da Outlook o Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importa come mio certificato';

  @override
  String smimeImportedOwn(String names) {
    return 'Importato il tuo certificato $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Aggiunto il tuo certificato $name ($addresses) da questo dispositivo.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Considerare attendibile «$name» per la posta?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe non conosce questa autorità di certificazione (forse è quella di un’azienda). Considerala attendibile per verificare i certificati che emette. Prima confronta la sua impronta digitale con il tuo reparto IT:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sono allegati $count certificati.',
      one: 'È allegato un certificato.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importa certificato';

  @override
  String get smimeUnlockTitle => 'Sblocca certificato S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Inserisci la passphrase del certificato di $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Passphrase errata. Riprova.';

  @override
  String get smimeUnlock => 'Sblocca';

  @override
  String get smimeEnterAPassphrase => 'Inserisci una passphrase.';

  @override
  String get smimePassphrasesDiffer => 'Le due passphrase sono diverse.';

  @override
  String get smimeSetPassphraseTitle => 'Imposta passphrase';

  @override
  String get smimeSetPassphraseText =>
      'Loupe la chiederà per firmare e decifrare. Se la dimentichi, importa di nuovo il certificato dal suo file .p12.';

  @override
  String get smimePassphraseAgain => 'Ripeti';

  @override
  String get smimeSetPassphraseButton => 'Imposta';

  @override
  String get smimeLockedOpenAgain => 'Il tuo certificato S/MIME è bloccato. Apri di nuovo il messaggio per sbloccarlo.';

  @override
  String get smimeDeviceHasNoCertificates => 'Questo dispositivo non mette a disposizione i suoi certificati.';

  @override
  String get smimeCantReadCertificate => 'Loupe non riesce a leggere questo certificato.';

  @override
  String get smimeCertificateNotForMail =>
      'Questo certificato non è per la posta: non ha un indirizzo email, oppure non è destinato a firmare o cifrare.';

  @override
  String get smimeDeviceCertificateGone =>
      'Il certificato non è più su questo dispositivo, oppure Loupe non può più usarlo. Sceglilo di nuovo in Impostazioni › Crittografia end-to-end.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Il certificato di questo dispositivo può essere usato solo mentre Loupe è aperta.';

  @override
  String get smimeDeviceKeyDamaged => 'La chiave cifrata è danneggiata.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Il certificato di questo dispositivo non può farlo: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'non supportato';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Errore del certificato di questo dispositivo: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'L’indirizzo dell’autorità non è un indirizzo web.';

  @override
  String get smimeAuthorityTimeout => 'L’autorità di certificazione non ha risposto in tempo.';

  @override
  String get smimeAuthorityUnreachable => 'Impossibile raggiungere l’autorità di certificazione.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'L’autorità di certificazione ha risposto $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'La risposta dell’autorità di certificazione è troppo grande.';

  @override
  String get smimeRevocationNotChecked =>
      'Non verificata: vengono verificati solo i certificati di autorità che Loupe considera attendibili.';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSystem => 'Come il telefono';

  @override
  String get settingsLanguageFooter =>
      'Loupe usa la lingua del telefono quando è disponibile, altrimenti l’inglese. La lingua che scegli qui vale solo per Loupe, notifiche comprese.';

  @override
  String get settingsAccountsHeader => 'Account';

  @override
  String get settingsAddAccount => 'Aggiungi account';

  @override
  String get settingsMailHeader => 'Posta';

  @override
  String get settingsSwipeActions => 'Azioni di scorrimento';

  @override
  String get settingsSwipeLeft => 'Scorri a sinistra';

  @override
  String get settingsSwipeLeftFooter =>
      'Uno scorrimento completo esegue questa azione. Contrassegna e Altro sono sempre a portata di uno scorrimento breve.';

  @override
  String get settingsSwipeRight => 'Scorri a destra';

  @override
  String get settingsSwipeRightFooter => 'Uno scorrimento completo esegue questa azione.';

  @override
  String get settingsSwipeToggleRead => 'Segna come letto / non letto';

  @override
  String get settingsSwipeTrash => 'Sposta nel Cestino';

  @override
  String get settingsSwipeMove => 'Sposta messaggio';

  @override
  String get settingsSwipeSnooze => 'Posticipa';

  @override
  String get settingsThreaded => 'Organizza per conversazione';

  @override
  String get settingsUndoSendDelay => 'Ritardo per annullare l’invio';

  @override
  String get settingsUndoSendDelayFooter => 'I messaggi inviati attendono questo tempo, così puoi annullarne l’invio.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds secondi',
      one: '$seconds secondo',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Aspetto';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatico';

  @override
  String get settingsThemeLight => 'Chiaro';

  @override
  String get settingsThemeDark => 'Scuro';

  @override
  String get settingsDensity => 'Elenco messaggi';

  @override
  String get settingsDensityComfortable => 'Spazioso';

  @override
  String get settingsDensityCompact => 'Compatto';

  @override
  String get settingsReadingHeader => 'Lettura';

  @override
  String get settingsReadingFooter =>
      'Le immagini remote possono dire ai mittenti quando e dove hai aperto un messaggio.';

  @override
  String get settingsDefaultView => 'Vista predefinita';

  @override
  String get settingsDefaultViewFooter => 'Puoi cambiare la vista di qualsiasi messaggio con il pulsante Aa.';

  @override
  String get settingsViewReadable => 'Leggibile';

  @override
  String get settingsViewReadableDetail => 'Pulita, leggibile, segue la modalità scura';

  @override
  String get settingsViewOriginal => 'Originale';

  @override
  String get settingsViewOriginalDetail => 'Esattamente come l’ha pensato il mittente';

  @override
  String get settingsViewPlain => 'Testo semplice';

  @override
  String get settingsViewPlainDetail => 'Solo le parole';

  @override
  String get settingsPlainTextFont => 'Carattere del testo semplice';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Monospaziato';

  @override
  String get settingsFontMonoDetail => 'Mantiene allineate tabelle e ASCII art';

  @override
  String get settingsTechnicalLists => 'Liste tecniche';

  @override
  String get settingsLoadRemoteImages => 'Carica immagini remote';

  @override
  String get settingsOpenLinksDirectly => 'Apri i link direttamente';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Salta i tracker dei clic quando la destinazione è nota';

  @override
  String get settingsSecurityHeader => 'Sicurezza';

  @override
  String get settingsAppLock => 'Blocco app';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe lo chiede all’avvio e quando torni dopo un’assenza più lunga del tempo di «Blocca dopo».';

  @override
  String get settingsAppLockFooterOff =>
      'Blocco app chiede l’impronta digitale, il volto o il blocco schermo prima di mostrare la tua posta.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Blocco app è ancora disattivato. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Imposta un codice';

  @override
  String get settingsScreenLockTextIos =>
      'Blocco app usa Face ID, Touch ID o il codice, e questo iPhone non ha un codice. Impostane uno nell’app Impostazioni, poi attiva Blocco app.';

  @override
  String get settingsScreenLockTitleAndroid => 'Imposta un blocco schermo';

  @override
  String get settingsScreenLockTextAndroid =>
      'Blocco app usa il blocco schermo del telefono, o un’impronta digitale o un volto aggiunti, e questo telefono non ne ha. Imposta un PIN, una sequenza o una password nelle impostazioni di Android, poi attiva Blocco app.';

  @override
  String get settingsOpenSystemSettings => 'Apri Impostazioni';

  @override
  String get settingsOpenAndroidSettings => 'Apri impostazioni di Android';

  @override
  String get settingsLockAfter => 'Blocca dopo';

  @override
  String get settingsLockAfterFooter => 'Per quanto tempo Loupe può restare in background prima di chiedere di nuovo.';

  @override
  String get settingsNotifications => 'Notifiche';

  @override
  String get settingsEncryption => 'Crittografia end-to-end';

  @override
  String get settingsAdvanced => 'Avanzate';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'La posta demo è una casella inventata che esiste solo su questo telefono. Non viene inviato nulla.';

  @override
  String get settingsDemoMode => 'Modalità demo';

  @override
  String get settingsResetApp => 'Ripristina app';

  @override
  String get settingsResetFooter => 'Dimentica tutte le impostazioni e torna alla schermata di benvenuto.';

  @override
  String get settingsResetTitle => 'Ripristinare Loupe?';

  @override
  String get settingsResetMessage =>
      'Verranno dimenticate tutte le impostazioni, le Smart Mailboxes e le ricerche recenti, e tornerai alla schermata di benvenuto.';

  @override
  String get settingsAboutHeader => 'Informazioni';

  @override
  String get settingsVersion => 'Versione';

  @override
  String get settingsLicences => 'Licenze';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyDetail =>
      'Loupe non ha statistiche né tracciamento. La tua posta va solo ai tuoi server di posta.';

  @override
  String get settingsNotificationsOffIos => 'Le notifiche di Loupe sono disattivate in Impostazioni.';

  @override
  String get settingsNotificationsOffAndroid => 'Le notifiche di Loupe sono disattivate nelle impostazioni di Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system non consente a Loupe di mostrare notifiche. Consentile in Impostazioni.';
  }

  @override
  String get settingsNewMailHeader => 'Nuova posta';

  @override
  String get settingsNewMailFooterDemo =>
      'La posta demo non arriva in background. Invia una notifica di prova per vedere come appare la nuova posta.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe controlla la nuova posta in background quando iOS lo consente, anche a ore di distanza per le app che non apri spesso. Ricevi un avviso per i nuovi messaggi nelle caselle in arrivo e per quelli dei VIP in qualsiasi cartella.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe controlla la nuova posta circa ogni 15 minuti, quando Android lo consente. Ricevi un avviso per i nuovi messaggi nelle caselle in arrivo e per quelli dei VIP in qualsiasi cartella.';

  @override
  String get settingsNoAccounts => 'Nessun account';

  @override
  String get settingsVipOnly => 'Solo VIP';

  @override
  String get settingsVipOnlyDetail => 'Solo i messaggi dei tuoi VIP';

  @override
  String get settingsHideContent => 'Nascondi contenuto';

  @override
  String get settingsHideContentFooterOn =>
      'Le notifiche dicono solo «Nuovo messaggio da» e l’account, non chi ha scritto né di cosa si tratta.';

  @override
  String get settingsHideContentFooterOff =>
      'Nascondi contenuto tiene mittente, oggetto e anteprima fuori dalla schermata di blocco e dalle notifiche.';

  @override
  String get settingsBackgroundAppRefresh => 'Aggiorna app in background';

  @override
  String get settingsBackgroundRefreshFooter =>
      'La nuova posta arriva in background solo se Aggiorna app in background è attivo per Loupe in Impostazioni. iOS non può tenere aperta una connessione alle tue caselle in arrivo, quindi non c’è la Consegna immediata.';

  @override
  String get settingsInstantDelivery => 'Consegna immediata';

  @override
  String get settingsInstantDeliveryFooter =>
      'La Consegna immediata (sperimentale) tiene aperta una connessione alle tue caselle in arrivo, così la nuova posta arriva in pochi secondi. Mostra una notifica discreta «In attesa di nuova posta» e consuma più batteria.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android potrebbe interrompere la Consegna immediata per risparmiare batteria. Consenti a Loupe di usare la batteria senza restrizioni per mantenerla attiva.';

  @override
  String get settingsExperimental => 'Sperimentale';

  @override
  String get settingsComingSoon => 'Prossimamente';

  @override
  String get settingsAllowUnrestrictedBattery => 'Consenti uso della batteria senza restrizioni';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Il push permette alla nuova posta di attivare subito Loupe, se il tuo servizio di posta lo supporta. Le notifiche push passano dal servizio push di Google e non contengono posta, solo «controlla ora».';

  @override
  String get settingsPushUnavailableFooter =>
      'Questo telefono non può ricevere notifiche push: servono Google Play Services e una connessione di rete. Loupe controlla comunque la posta circa ogni 15 minuti.';

  @override
  String get settingsCopyPushToken => 'Copia token push';

  @override
  String get settingsPushTokenCopied => 'Token push copiato';

  @override
  String get settingsSendTestNotification => 'Invia notifica di prova';

  @override
  String get settingsAppIconBadge => 'Badge sull’icona dell’app';

  @override
  String get settingsBadgeNote => 'Il badge si aggiorna ogni volta che Loupe controlla la posta, anche in background.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'La schermata Home di questo telefono non mostra numeri sulle icone delle app. Il badge si aggiorna ogni volta che Loupe controlla la posta, anche in background.';

  @override
  String get settingsTestNotificationBody => 'Le notifiche della nuova posta appaiono così.';

  @override
  String get settingsAccountRemoved => 'Questo account è stato rimosso.';

  @override
  String get settingsAccountHeader => 'Account';

  @override
  String get settingsAccountDescription => 'Descrizione';

  @override
  String get settingsAccountDescriptionHint => 'Lavoro, Personale…';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsColour => 'Colore';

  @override
  String get settingsColourFooter => 'Distingue i messaggi di questo account in Tutte le caselle in arrivo.';

  @override
  String settingsColourNumber(int number) {
    return 'Colore $number';
  }

  @override
  String get settingsSendingHeader => 'Invio';

  @override
  String get settingsSendingFooter =>
      'Ogni identità ha la propria firma. Le risposte partono dall’indirizzo a cui è stato inviato il messaggio.';

  @override
  String get settingsFoldersHeader => 'Cartelle';

  @override
  String get settingsFoldersFooter =>
      'Loupe mostra e sincronizza le cartelle a cui sei iscritto, come fa Thunderbird. Posta in arrivo, Bozze, Inviati, Spam, Cestino e Archivio sono sempre visibili.';

  @override
  String get settingsShowAllFolders => 'Mostra tutte le cartelle';

  @override
  String get settingsIncoming => 'In arrivo';

  @override
  String get settingsOutgoing => 'In uscita';

  @override
  String get settingsConnectionNotEncrypted => 'Non cifrata';

  @override
  String get settingsSignIn => 'Accesso';

  @override
  String get settingsSignInExpired => 'Scaduto';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider non accetta più l’accesso di Loupe per questo account, quindi la posta non si sincronizza. Accedi di nuovo per risolvere.';
  }

  @override
  String get settingsSignInAgain => 'Accedi di nuovo';

  @override
  String get settingsSigningIn => 'Accesso in corso…';

  @override
  String get settingsRemoveAccount => 'Rimuovi account';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Rimuovere «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'La posta e le impostazioni dell’account vengono rimosse da questo telefono. Sul server non viene eliminato nulla.';

  @override
  String get settingsManageFolders => 'Gestisci cartelle';

  @override
  String get settingsNoFolders => 'Ancora nessuna cartella.';

  @override
  String get settingsManageFoldersFooter =>
      'Le cartelle a cui sei iscritto compaiono nella schermata Caselle e si sincronizzano in background. Di solito anche le altre app di posta sullo stesso account seguono queste iscrizioni.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Conserva le tue Smart Mailboxes per gli altri tuoi dispositivi. Nascosta nella schermata Caselle.';

  @override
  String get settingsFolderAlwaysShown => 'Sempre visibile';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Iscriviti a $folder';
  }

  @override
  String get settingsIdentities => 'Identità';

  @override
  String get settingsIdentitiesFooterReorder =>
      'La prima identità è quella predefinita per i nuovi messaggi. Trascina per cambiare l’ordine.';

  @override
  String get settingsIdentitiesFooterSingle => 'L’identità predefinita per i nuovi messaggi.';

  @override
  String get settingsIdentitiesReplyFooter => 'Una risposta parte dall’identità a cui è stato inviato il messaggio.';

  @override
  String get settingsIdentityDefault => 'Predefinita';

  @override
  String settingsIdentityReorder(String email) {
    return 'Riordina $email';
  }

  @override
  String get settingsAddIdentity => 'Aggiungi identità';

  @override
  String get settingsNewIdentity => 'Nuova identità';

  @override
  String get settingsIdentity => 'Identità';

  @override
  String get settingsIdentityNameHint => 'Il tuo nome';

  @override
  String get settingsReplyTo => 'Rispondi a';

  @override
  String get settingsSignature => 'Firma';

  @override
  String get settingsSignatureFooter => 'Aggiunta sotto «-- » nei messaggi di questa identità.';

  @override
  String get settingsNoSignature => 'Nessuna firma';

  @override
  String get settingsCopyToMyself => 'Copia per me';

  @override
  String get settingsCopyToMyselfFooter => 'Aggiunti a ogni messaggio di questa identità.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Ccn';

  @override
  String get settingsReplyPatterns => 'Usa per le risposte a';

  @override
  String get settingsReplyPatternsFooter =>
      'Le risposte ai messaggi inviati a questi indirizzi partono da questa identità. * sta per qualsiasi cosa: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Un indirizzo, o un modello in cui * sta per qualsiasi cosa.';

  @override
  String get settingsAddReplyPattern => 'Aggiungi indirizzo o modello';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Rimuovi $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Modello non valido';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» non è un indirizzo né un modello come *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Nessun indirizzo';

  @override
  String get settingsIdentityNoAddressMessage => 'Inserisci l’indirizzo email da cui inviare.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Indirizzo non valido';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'In Rispondi a, «$address» non è un indirizzo email valido.',
      'cc': 'In Cc, «$address» non è un indirizzo email valido.',
      'bcc': 'In Ccn, «$address» non è un indirizzo email valido.',
      'other': '«$address» non è un indirizzo email valido.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Salva identità';

  @override
  String get settingsDiscardChanges => 'Annulla modifiche';

  @override
  String get settingsDeleteIdentity => 'Elimina identità';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Eliminare «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'I messaggi già inviati da questa identità restano come sono.';

  @override
  String get settingsLastIdentityFooter => 'Un account ha bisogno di almeno un’identità.';

  @override
  String get rulesTitle => 'Regole';

  @override
  String get rulesNewRule => 'Nuova regola';

  @override
  String get rulesLoadError => 'Impossibile caricare le regole.';

  @override
  String get rulesEmptyTitle => 'Nessuna regola';

  @override
  String get rulesEmptyText =>
      'Le regole smistano, aggiungono tag e contrassegnano la nuova posta per te. Creane una con il pulsante di scrittura qui sopra, oppure da una ricerca con «Trasforma in regola».';

  @override
  String get rulesListFooter =>
      'Le regole vengono eseguite dall’alto verso il basso sulla nuova posta nella Posta in arrivo. Tieni premuta una regola per spostarla.';

  @override
  String get rulesChangeError => 'Impossibile modificare la regola';

  @override
  String get rulesConditionEveryMessage => 'Ogni messaggio';

  @override
  String rulesMoveRule(String rule) {
    return 'Sposta $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule attiva';
  }

  @override
  String get rulesServerRulesHeader => 'Regole sul server';

  @override
  String get rulesServerRulesFooter =>
      'Le regole sul server vengono eseguite sul server di posta all’arrivo della posta, anche quando questo telefono è spento. Sono conservate in uno script Sieve chiamato «loupe».';

  @override
  String get rulesStatusUnknown => 'Sconosciuto';

  @override
  String get rulesStatusError => 'Impossibile interrogare il server.';

  @override
  String get rulesStatusChecking => 'Verifica in corso…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Eseguite da «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '«$script» è lo script attivo. Tocca per fargli eseguire anche le regole di Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Nessuno script è attivo sul server. Salvando una regola sul server si attiva quello di Loupe.';

  @override
  String get rulesStatusUnavailable => 'Non disponibile';

  @override
  String get rulesStatusNoSieve => 'Il server di questo account non offre Sieve (ManageSieve o JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Sposta in $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Sposta in una cartella';

  @override
  String rulesActionTag(String tag) {
    return 'Aggiungi tag $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Rimuovi tag $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Mantieni in Posta in arrivo';

  @override
  String rulesActionForward(String address) {
    return 'Inoltra a $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Inoltra a $address, senza tenere una copia';
  }

  @override
  String get rulesActionStop => 'Interrompi';

  @override
  String get rulesNoActions => 'Non fa ancora nulla';

  @override
  String get rulesLocationDevice => 'Dispositivo';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Questo dispositivo';

  @override
  String get rulesNewRuleTitle => 'Nuova regola';

  @override
  String get rulesEditRuleTitle => 'Modifica regola';

  @override
  String get rulesDefaultNameEveryMessage => 'Ogni messaggio';

  @override
  String get rulesConditionHeader => 'Quando un nuovo messaggio corrisponde a';

  @override
  String get rulesConditionFooter =>
      'Scrivila come una ricerca: from:, to:, s: (oggetto), b: (corpo), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:fattura';

  @override
  String get rulesAccounts => 'Account';

  @override
  String get rulesAllAccounts => 'Tutti gli account';

  @override
  String get rulesRemovedAccount => 'Account rimosso';

  @override
  String get rulesAccountsFooter =>
      'Una regola per tutti gli account vale anche per quelli che aggiungerai in seguito.';

  @override
  String get rulesActionsHeader => 'Allora';

  @override
  String get rulesForwardingFooter =>
      'L’inoltro invia ogni messaggio corrispondente a un altro indirizzo appena arriva, anche quando questo telefono è spento. Alcuni provider limitano la quantità di posta che può essere inoltrata.';

  @override
  String get rulesForwardingHiddenFooter => 'L’inoltro funziona solo nelle regole sul server, quindi qui è escluso.';

  @override
  String rulesRemoveAction(String action) {
    return 'Rimuovi $action';
  }

  @override
  String get rulesAddAction => 'Aggiungi azione';

  @override
  String get rulesAddMove => 'Sposta in una cartella…';

  @override
  String get rulesAddTagMenu => 'Aggiungi tag…';

  @override
  String get rulesRemoveTagMenu => 'Rimuovi tag…';

  @override
  String get rulesAddForward => 'Inoltra a…';

  @override
  String get rulesStopProcessing => 'Non elaborare altre regole';

  @override
  String get rulesRunOnHeader => 'Esegui su';

  @override
  String get rulesRunOnDeviceFooter =>
      'Questo dispositivo esegue la regola sulla nuova posta della Posta in arrivo ogni volta che Loupe controlla la posta.';

  @override
  String get rulesRunOnServerFooter =>
      'Il server di posta esegue la regola all’arrivo della posta, anche quando questo telefono è spento. Richiede Sieve, tramite ManageSieve (Dovecot, mailcow) o JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Applica ai messaggi esistenti…';

  @override
  String get rulesDeleteRule => 'Elimina regola';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Eliminare «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => 'Cartella di quale account?';

  @override
  String get rulesMoveAccountMessage =>
      'La posta degli altri account va nella cartella con lo stesso nome in quegli account.';

  @override
  String get rulesAddTag => 'Aggiungi tag';

  @override
  String get rulesRemoveTag => 'Rimuovi tag';

  @override
  String get rulesForwardTo => 'Inoltra a';

  @override
  String get rulesForwardToMessage =>
      'Il server inoltra ogni messaggio corrispondente a questo indirizzo, anche quando questo telefono è spento. Usa un indirizzo che ti appartiene o di cui ti fidi.';

  @override
  String get rulesNotAnAddressTitle => 'Non è un indirizzo email';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» non è un indirizzo a cui inoltrare.';
  }

  @override
  String get rulesKeepCopyTitle => 'Tenere una copia qui?';

  @override
  String get rulesKeepCopy => 'Tieni una copia';

  @override
  String get rulesDontKeepCopy => 'Non tenere una copia';

  @override
  String get rulesCheckCondition => 'Controlla la condizione';

  @override
  String get rulesChooseActionTitle => 'Scegli un’azione';

  @override
  String get rulesChooseActionMessage => 'Aggiungi ciò che la regola fa con i messaggi che corrispondono.';

  @override
  String get rulesSaveError => 'Impossibile salvare la regola';

  @override
  String get rulesSaveServerError => 'Impossibile salvare la regola sul server';

  @override
  String get rulesRunOnDeviceInstead => 'Esegui invece su questo dispositivo';

  @override
  String get rulesNothingToApplyTitle => 'Niente da applicare';

  @override
  String get rulesNothingToApplyMessage => 'Prima assegna alla regola una condizione valida e un’azione.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Applica «$rule» ai messaggi in…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Posta in arrivo';

  @override
  String get rulesApplyScopeAll => 'Tutte le caselle';

  @override
  String get rulesFindingMessages => 'Ricerca dei messaggi…';

  @override
  String get rulesSearchError => 'Impossibile eseguire la ricerca';

  @override
  String get rulesSearchErrorUnknown => 'Si è verificato un errore.';

  @override
  String get rulesNoMatchesTitle => 'Nessun messaggio corrispondente';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Lì niente corrisponde a «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Applicare «$rule» a $countString messaggi?',
      one: 'Applicare «$rule» a $countString messaggio?',
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
      other: 'Applica a $countString messaggi',
      one: 'Applica a $countString messaggio',
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
      other: '«$rule» applicata a $countString messaggi',
      one: '«$rule» applicata a $countString messaggio',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Verifica di cosa può fare il server…';

  @override
  String get rulesServerUnreachable => 'Impossibile raggiungere il server.';

  @override
  String rulesServerProblem(String problem) {
    return 'Impossibile eseguire sul server: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Impossibile eseguire sul server di $account: $problem';
  }

  @override
  String get rulesShowScript => 'Mostra script';

  @override
  String get rulesHideScript => 'Nascondi script';

  @override
  String get rulesMatchingHeader => 'Messaggi corrispondenti';

  @override
  String get rulesMatchingHeaderLoading => 'Messaggi corrispondenti…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString messaggi corrispondenti',
      one: '$countString messaggio corrispondente',
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
      other: '$countString+ messaggi corrispondenti',
      one: '$countString+ messaggio corrispondente',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Degli ultimi 30 giorni. La regola agisce solo sulla nuova posta, a meno che tu non la applichi ai messaggi esistenti.';

  @override
  String rulesConditionError(String error) {
    return 'La condizione contiene un errore: $error';
  }

  @override
  String get rulesPreviewNoSender => '(nessun mittente)';

  @override
  String get rulesPreviewNoSubject => '(nessun oggetto)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'e altri $countString', one: 'e un altro');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Niente negli ultimi 30 giorni.';

  @override
  String get rulesIncludeTitle => 'Attiva le regole sul server';

  @override
  String get rulesIncludeLeaveOff => 'Lascia disattivate';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Il server esegue già le regole di Loupe per $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» è lo script attivo sul server di $account, quindi il server esegue quello e non le regole di Loupe. Loupe non lo sostituirà. Può aggiungervi queste righe, e il server eseguirà poi le regole di Loupe dopo quelle dello script:';
  }

  @override
  String get rulesShowWholeScript => 'Mostra tutto lo script';

  @override
  String get rulesHideWholeScript => 'Nascondi tutto lo script';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nient’altro cambia in «$script». Se in seguito i suoi filtri vengono modificati nella webmail, la webmail potrebbe riscriverlo senza queste righe; in quel caso Loupe mostrerà di nuovo le regole sul server come disattivate.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Aggiungi a «$script»';
  }

  @override
  String get subscriptionsTitle => 'Iscrizioni';

  @override
  String get subscriptionsNewsletters => 'Newsletter';

  @override
  String get subscriptionsDiscussions => 'Discussioni';

  @override
  String get subscriptionsFilter => 'Filtra';

  @override
  String get subscriptionsFilterNeverRead => 'Mai lette';

  @override
  String get subscriptionsFilterRarelyRead => 'Lette di rado';

  @override
  String get subscriptionsFilterAll => 'Tutte';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Impossibile contare le iscrizioni';

  @override
  String get subscriptionsNoMatches => 'Nessun risultato';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Nessuna newsletter si chiama «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Nessuna lista si chiama «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Nessuna newsletter';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Le newsletter e l’altra posta di massa compaiono qui appena arrivano.';

  @override
  String get subscriptionsNothingNeverRead => 'Niente in «Mai lette»';

  @override
  String get subscriptionsNothingRarelyRead => 'Niente in «Lette di rado»';

  @override
  String get subscriptionsNothingFilteredDetail => 'Leggi almeno un po’ di tutto ciò che ricevi.';

  @override
  String get subscriptionsNoDiscussions => 'Nessuna discussione';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Le mailing list a cui puoi scrivere compaiono qui appena arriva la loro posta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Liste a cui scrivono diverse persone. Tienine premuta una per fissarla in Caselle, leggerla come testo semplice o spostarla in Newsletter.';

  @override
  String get subscriptionsPrivacyNote =>
      'Calcolato su questo telefono a partire dalla posta che ha scaricato; per farlo non viene inviato nulla. Loupe contatta un mittente solo quando tocchi Annulla iscrizione: l’annullamento con un clic invia soltanto «List-Unsubscribe=One-Click» all’indirizzo indicato dal mittente, senza cookie né altro su di te, e non carica mai le sue pagine o immagini.';

  @override
  String get subscriptionsVolumeNone => 'Niente di recente';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mese';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mese';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'letti $percent';
  }

  @override
  String get subscriptionsStillSending => 'Continua a inviare';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Iscrizione annullata il $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Pagina di annullamento aperta il $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Un tocco · contatta $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Via email a $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Sul sito $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Annulla iscrizione';

  @override
  String get subscriptionsUnsubscribeAgain => 'Annulla di nuovo l’iscrizione';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archivia $countString dalla Posta in arrivo',
      one: 'Archivia $countString dalla Posta in arrivo',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Crea regola…';

  @override
  String get subscriptionsCreateRuleDetail => 'Sposta o archivia la sua posta futura';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tratta come discussione';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Una lista a cui le persone scrivono: leggila come un forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Tratta come newsletter';

  @override
  String get subscriptionsBlockSender => 'Blocca mittente';

  @override
  String get subscriptionsBlock => 'Blocca';

  @override
  String get subscriptionsBlocked => 'Bloccato';

  @override
  String get subscriptionsBlockedDetail => 'La nuova posta va in Spam';

  @override
  String get subscriptionsPin => 'Fissa in Caselle';

  @override
  String get subscriptionsUnpin => 'Rimuovi da Caselle';

  @override
  String get subscriptionsOpenDefaultView => 'Apri nella vista predefinita';

  @override
  String get subscriptionsOpenPlainText => 'Apri come testo semplice (Mono)';

  @override
  String get subscriptionsPinned => 'Fissata';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString non letti',
      one: '$countString non letto',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Al momento nessun messaggio da questo mittente.';

  @override
  String get subscriptionsLatestMessages => 'ULTIMI MESSAGGI';

  @override
  String get subscriptionsMail => 'Posta';

  @override
  String get subscriptionsNoneIn90Days => 'Nessuno in 90 giorni';

  @override
  String get subscriptionsRead => 'Letti';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString su $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Ultima ricezione';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Cartelle', one: 'Cartella');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Continua a inviare';

  @override
  String get subscriptionsUnsubscribedTitle => 'Iscrizione annullata';

  @override
  String subscriptionsSince(String date) {
    return 'dal $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'pagina aperta il $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender non indica come annullare l’iscrizione.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender non indica come annullare l’iscrizione. Puoi invece bloccarlo.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Annullamento dell’iscrizione a $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Iscrizione a $sender annullata.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Impossibile annullare l’iscrizione: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Impossibile annullare l’iscrizione automaticamente';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Invia email di annullamento';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Apri $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Aprire $site?';
  }

  @override
  String get subscriptionsOpen => 'Apri';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender gestisce l’annullamento dell’iscrizione sul suo sito. La pagina si apre nel browser di Loupe; completa lì la procedura.';
  }

  @override
  String get subscriptionsWebInsecure => 'La connessione a questo sito non è cifrata.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Attenzione: questo indirizzo imita $site con lettere simili.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Attenzione: questo indirizzo imita un altro sito con lettere simili.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Impossibile aprire $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe annota la data di oggi e ti avvisa se $sender continua a scrivere.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Annullare l’iscrizione a $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe contatterà $site per annullare l’iscrizione.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'È l’unica volta in cui Loupe contatta il sito di un mittente. Invia soltanto «List-Unsubscribe=One-Click» all’indirizzo indicato da $sender, senza cookie né altro su di te, e non carica la pagina.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Il link di annullamento non è un indirizzo sicuro su internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site non ha risposto in tempo.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Impossibile raggiungere $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site ha inoltrato la richiesta a un’altra pagina, che Loupe non segue.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site ha rifiutato la richiesta (errore $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Non c’è un account da cui inviare l’email di annullamento.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe invierà un’email a $to da $from, con oggetto «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Email di annullamento inviata a $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Bloccare $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'La nuova posta da questa lista va in Spam. Puoi cambiarlo in Impostazioni › Regole.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'La nuova posta da $address va in Spam. Puoi cambiarlo in Impostazioni › Regole.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender bloccato.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sposta $count in Spam',
      one: 'Sposta $count in Spam',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blocca $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender ora è in Newsletter.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender ora è in Discussioni.';
  }

  @override
  String get appLiveGateTitle => 'Impossibile aprire i tuoi account';

  @override
  String get appLiveGateUnavailableBuild => 'Gli account reali non sono ancora disponibili in questa build.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe non è riuscita a leggere la chiave che protegge la tua posta su questo telefono. Spesso è un problema temporaneo: riprova o riavvia il telefono.';

  @override
  String get appLiveGateKeyMissing =>
      'La chiave che protegge la tua posta su questo telefono non c’è più, cosa che può succedere dopo il ripristino di un backup. La tua posta è ancora sul server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Il database della posta su questo telefono non può essere letto: è danneggiato, o la sua chiave è cambiata. La tua posta è ancora sul server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Si è verificato un errore durante l’apertura dei tuoi account ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Verranno eliminati i tuoi account e la posta salvata su questo telefono, compresi i messaggi in attesa nella Posta in uscita. La posta sui tuoi server non viene toccata; dopo, aggiungi di nuovo i tuoi account.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Elimina e ricomincia';

  @override
  String get appLiveGateUseDemo => 'Usa la posta demo';

  @override
  String get appLiveGateReset => 'Ripristina la posta su questo telefono…';

  @override
  String get attachmentsUntitled => 'Allegato';

  @override
  String get attachmentsUntitledFile => 'Senza titolo';

  @override
  String get attachmentsOpenIn => 'Apri in…';

  @override
  String get attachmentsSaveToFiles => 'Salva nei file';

  @override
  String get attachmentsShareMenu => 'Condividi…';

  @override
  String get attachmentsDownloadError => 'Impossibile scaricare l’allegato. Controlla la connessione e riprova.';

  @override
  String get attachmentsShareError => 'Impossibile condividere l’allegato.';

  @override
  String attachmentsNoApp(String type) {
    return 'Nessuna app su questo dispositivo apre questo file ($type). Prova invece con Condividi.';
  }

  @override
  String get attachmentsOpenInError => 'Impossibile aprire l’allegato in un’altra app.';

  @override
  String attachmentsSaved(String name) {
    return '«$name» salvato';
  }

  @override
  String get attachmentsSaveError => 'Impossibile salvare l’allegato.';

  @override
  String get attachmentsGone => 'Questo allegato non è più disponibile.';

  @override
  String get attachmentsDownloadFailed => 'Impossibile scaricare l’allegato.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pagine', one: '$count pagina');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size con i dati mobili';
  }

  @override
  String get attachmentsLargeDownload => 'Questo allegato è grande. Scaricalo ora, o più tardi con il Wi-Fi.';

  @override
  String get attachmentsDownload => 'Scarica';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Download di $size…';
  }

  @override
  String get attachmentsDownloading => 'Download in corso…';

  @override
  String get attachmentsTooLarge => 'Troppo grande per l’anteprima.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Vengono mostrati i primi $shown di $total. Copia, condividi o salva per averlo tutto.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Impossibile mostrare questo PDF qui (potrebbe essere protetto da password).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page di $count';
  }

  @override
  String get attachmentsModeTable => 'Tabella';

  @override
  String get attachmentsModeText => 'Testo';

  @override
  String get attachmentsModeMessage => 'Messaggio';

  @override
  String get attachmentsModeSource => 'Sorgente';

  @override
  String get attachmentsDontWrap => 'Disattiva a capo automatico';

  @override
  String get attachmentsWrap => 'A capo automatico';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines righe', one: '$lines riga');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Copia tutto';

  @override
  String get attachmentsCopied => 'Copiato';

  @override
  String get attachmentsImageUnavailable => 'Impossibile mostrare questa immagine qui. Prova Apri in….';

  @override
  String get attachmentsEmlNoSubject => '(Nessun oggetto)';

  @override
  String get attachmentsEmlFrom => 'Da';

  @override
  String get attachmentsEmlTo => 'A';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Questo messaggio non contiene testo.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Allegati: $names',
      one: 'Allegato: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizzatore: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'E altri $count eventi',
      one: 'E un altro evento',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Immagine';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Immagine $format';
  }

  @override
  String get attachmentsTypePdf => 'Documento PDF';

  @override
  String get attachmentsTypeTsv => 'Valori separati da tabulazioni';

  @override
  String get attachmentsTypeCsv => 'Foglio di calcolo CSV';

  @override
  String get attachmentsTypeCalendar => 'Evento del calendario';

  @override
  String get attachmentsTypeEmail => 'Messaggio email';

  @override
  String get attachmentsTypeContact => 'Biglietto da visita';

  @override
  String get attachmentsTypeLog => 'File di log';

  @override
  String get attachmentsTypeText => 'Testo';

  @override
  String get attachmentsTypeZip => 'Archivio ZIP';

  @override
  String get attachmentsTypeArchive => 'Archivio compresso';

  @override
  String get attachmentsTypeWord => 'Documento Word';

  @override
  String get attachmentsTypeExcel => 'Foglio di calcolo Excel';

  @override
  String get attachmentsTypePowerPoint => 'Presentazione PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Pagina web';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'File $extension';
  }

  @override
  String get attachmentsTypeFile => 'File';

  @override
  String get calendarUntitledEvent => 'Evento';

  @override
  String get calendarAllDay => 'Tutto il giorno';

  @override
  String calendarYourTime(String time) {
    return '$time ora locale';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Partecipa: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha accettato: $details',
      'tentative': '$name ha accettato provvisoriamente: $details',
      'declined': '$name ha rifiutato: $details',
      'delegated': '$name ha delegato: $details',
      'other': '$name non ha risposto a: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha accettato l’invito',
      'tentative': '$name ha accettato provvisoriamente l’invito',
      'declined': '$name ha rifiutato l’invito',
      'delegated': '$name ha delegato l’invito',
      'other': '$name non ha risposto all’invito',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mappa';

  @override
  String get calendarJoin => 'Partecipa';

  @override
  String get calendarOnlineMeeting => 'Riunione online';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Riunione $provider';
  }

  @override
  String get calendarOrganizerYou => 'Tu';

  @override
  String get calendarOrganizerLabel => 'organizzatore';

  @override
  String get calendarStatusAccepted => 'Accettato';

  @override
  String get calendarStatusMaybe => 'Forse';

  @override
  String get calendarStatusDeclined => 'Rifiutato';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha accettato',
      'tentative': '$name ha accettato provvisoriamente',
      'declined': '$name ha rifiutato',
      'delegated': '$name ha delegato',
      'other': '$name non ha risposto',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ha accettato:',
      'tentative': '$name ha accettato provvisoriamente:',
      'declined': '$name ha rifiutato:',
      'delegated': '$name ha delegato:',
      'other': '$name non ha risposto:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name propone un nuovo orario';
  }

  @override
  String get calendarCounterUnknown => 'Un partecipante propone un nuovo orario';

  @override
  String get calendarDeclineCounter => 'L’organizzatore ha mantenuto l’orario';

  @override
  String calendarRefresh(String name) {
    return '$name chiede la versione più recente';
  }

  @override
  String get calendarRefreshUnknown => 'Un partecipante chiede la versione più recente';

  @override
  String get calendarCancelled => 'Annullato';

  @override
  String get calendarCancelledByOrganizer => 'L’organizzatore ha annullato questo evento.';

  @override
  String get calendarCancelledLater => 'Questo evento è stato annullato in seguito.';

  @override
  String get calendarOutdated => 'Non aggiornato';

  @override
  String get calendarOutdatedDetail => 'Questo invito è stato aggiornato in seguito; vale quello più recente.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Luogo rimosso (era $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Luogo rimosso (non c’era)';

  @override
  String calendarLocationChanged(String location) {
    return 'Luogo cambiato in $location';
  }

  @override
  String get calendarNewTitle => 'Nuovo titolo';

  @override
  String get calendarRepeatChanged => 'La ripetizione è cambiata';

  @override
  String get calendarUpdated => 'Aggiornato';

  @override
  String get calendarUpdatedInvitation => 'Invito aggiornato';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Orario cambiato da $before a $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Fuso orario «$zone» sconosciuto: orari come scritti';
  }

  @override
  String calendarNext(String when) {
    return 'Prossimo: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count invitati', one: '$count invitato');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hanno accettato',
      one: '$count ha accettato',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count forse', one: '$count forse');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hanno rifiutato',
      one: '$count ha rifiutato',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (tu)';
  }

  @override
  String get calendarAttendeeOptional => 'facoltativo';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Hai accettato una versione precedente.',
      'tentative': 'Hai accettato provvisoriamente una versione precedente.',
      'declined': 'Hai rifiutato una versione precedente.',
      'delegated': 'Hai delegato una versione precedente.',
      'other': 'Non hai risposto a una versione precedente.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Accetta';

  @override
  String get calendarMaybe => 'Forse';

  @override
  String get calendarDecline => 'Rifiuta';

  @override
  String get calendarCommentHint => 'Commento per l’organizzatore (facoltativo)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'La tua risposta va a $organizer da $address.';
  }

  @override
  String get calendarAddComment => 'Aggiungi un commento';

  @override
  String get calendarAddToCalendar => 'Aggiungi al calendario';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'E altri $count eventi nel file',
      one: 'E un altro evento nel file',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Non c’è un’app di calendario a cui aggiungere l’evento.';

  @override
  String get calendarCantOpenCalendar => 'Impossibile aprire il calendario.';

  @override
  String get calendarCantOpenLink => 'Impossibile aprire il link.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Partecipare alla riunione $provider?';
  }

  @override
  String get calendarJoinTitle => 'Partecipare alla riunione?';

  @override
  String calendarJoinOpens(String host) {
    return 'Apre $host nel browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Attenzione: questo indirizzo imita $site con lettere simili.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Attenzione: questo indirizzo imita un altro sito con lettere simili.';

  @override
  String calendarJoinOpen(String host) {
    return 'Apri $host';
  }

  @override
  String get calendarNoOrganizer => 'Questo invito non ha un organizzatore a cui rispondere.';

  @override
  String get calendarNoAccount => 'Non c’è un account da cui rispondere.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Accettato',
      'tentative': 'Forse',
      'other': 'Rifiutato',
    });
    return '$_temp0 · invio della risposta a $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Accettato',
      'tentative': 'Forse',
      'other': 'Rifiutato',
    });
    return '$_temp0 · risposta inviata';
  }

  @override
  String get calendarReplyAlreadySent => 'La risposta è già stata inviata.';

  @override
  String get calendarReplyNotSent => 'Risposta non inviata.';

  @override
  String get dataSmimeNeedsDevice =>
      'Il tuo certificato S/MIME è su questo dispositivo: apri Loupe per firmare e inviare questo messaggio.';

  @override
  String dataSigningFailed(String error) {
    return 'Firma non riuscita: $error';
  }

  @override
  String get keyboardShortcuts => 'Scorciatoie da tastiera';

  @override
  String get keyboardGroupGeneral => 'Generale';

  @override
  String get keyboardGroupMessages => 'Messaggi';

  @override
  String get keyboardGroupCompose => 'Scrittura';

  @override
  String get keyboardCommandPalette => 'Palette dei comandi';

  @override
  String get keyboardBackClose => 'Indietro, chiudi';

  @override
  String get keyboardNextMessage => 'Messaggio successivo';

  @override
  String get keyboardPreviousMessage => 'Messaggio precedente';

  @override
  String get keyboardOpenMessage => 'Apri messaggio';

  @override
  String get keyboardMoveToTrash => 'Sposta nel Cestino';

  @override
  String get keyboardToggleRead => 'Segna come letto o non letto';

  @override
  String get keyboardToggleFlag => 'Aggiungi o rimuovi contrassegno';

  @override
  String get keyboardCloseDraft => 'Chiudi (salva o elimina la bozza)';

  @override
  String get keyboardOr => 'o';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Maiusc';

  @override
  String get keyboardKeyEnter => 'Invio';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Canc';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get mailingListsMuted => 'Thread silenziato. I nuovi messaggi arriveranno già letti.';

  @override
  String get mailingListsUnmuted => 'Thread non più silenziato.';

  @override
  String get mailingListsMuteThread => 'Silenzia thread';

  @override
  String get mailingListsUnmuteThread => 'Riattiva thread';

  @override
  String get mailingListsPin => 'Fissa in Caselle';

  @override
  String get mailingListsUnpin => 'Rimuovi da Caselle';

  @override
  String get mailingListsDefaultView => 'Apri nella vista predefinita';

  @override
  String get mailingListsPlainText => 'Apri come testo semplice (Mono)';

  @override
  String get mailingListsShowMuted => 'Mostra i thread silenziati';

  @override
  String get mailingListsHideMuted => 'Nascondi i thread silenziati';

  @override
  String get mailingListsTreatAsNewsletter => 'Tratta come newsletter';

  @override
  String get mailingListsOptions => 'Opzioni della lista';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted non letti',
      one: '$formatted non letto',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nuovo messaggio alla lista';

  @override
  String get mailingListsRowUnread => 'Non letto';

  @override
  String get mailingListsRowMuted => 'Silenziato';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count risposte', one: '$count risposta');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Nessun thread';

  @override
  String get mailingListsMutedHidden => 'I thread silenziati sono nascosti.';

  @override
  String get mailingListsTechnicalTitle => 'Liste tecniche';

  @override
  String get mailingListsTechnicalEmpty => 'Le mailing list compaiono qui appena arriva la loro posta.';

  @override
  String get mailingListsTechnicalFooter =>
      'I messaggi di queste liste si aprono come testo semplice in un carattere monospaziato, con le patch mostrate come diff. Il pulsante Aa cambia comunque la vista di qualsiasi messaggio.';

  @override
  String get paletteMoveToMailbox => 'Sposta in una casella…';

  @override
  String get paletteMarkAllRead => 'Segna tutto come letto';

  @override
  String get paletteExportFolder => 'Esporta cartella…';

  @override
  String get paletteGetNewMail => 'Scarica nuova posta';

  @override
  String get paletteSnoozed => 'Posticipati';

  @override
  String get paletteSubscriptions => 'Iscrizioni';

  @override
  String get paletteDiscussions => 'Discussioni';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailing list';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Azioni di scorrimento';

  @override
  String get paletteNotifications => 'Notifiche';

  @override
  String get paletteRules => 'Regole';

  @override
  String get paletteEncryption => 'Crittografia end-to-end';

  @override
  String get paletteAdvanced => 'Avanzate';

  @override
  String get paletteAddAccount => 'Aggiungi account';

  @override
  String get paletteAccount => 'Account';

  @override
  String get paletteFolders => 'Cartelle';

  @override
  String get paletteRecentSearch => 'Ricerca recente';

  @override
  String paletteSearchMail(String query) {
    return 'Cerca «$query» nella posta';
  }

  @override
  String get palettePlaceholder => 'Cerca azioni, caselle, impostazioni';

  @override
  String get paletteNothingFound => 'Nessun risultato';

  @override
  String get searchNewSmartMailbox => 'Nuova Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Mostra tutto ciò che corrisponde a «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» salvata in Caselle';
  }

  @override
  String get searchMakeRule => 'Trasforma in regola';

  @override
  String get searchSaveSmartMailbox => 'Salva come Smart Mailbox';

  @override
  String get searchNegate => 'Nega';

  @override
  String get searchDontNegate => 'Non negare';

  @override
  String get searchAllMailboxes => 'Tutte le caselle';

  @override
  String get searchRecent => 'Ricerche recenti';

  @override
  String get searchClear => 'Cancella';

  @override
  String get searchSuggestions => 'Suggerimenti';

  @override
  String get searchUnreadMessages => 'Messaggi non letti';

  @override
  String get searchFlaggedMessages => 'Messaggi contrassegnati';

  @override
  String get searchWithAttachments => 'Messaggi con allegati';

  @override
  String get searchUnrepliedMessages => 'Messaggi senza risposta';

  @override
  String get searchTags => 'Tag';

  @override
  String get searchPeople => 'Persone';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Da: $name';
  }

  @override
  String get searchSearching => 'Ricerca in corso…';

  @override
  String get searchNoResults => 'Nessun risultato';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted risultati',
      one: '$formatted risultato',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menu di ricerca';

  @override
  String searchSearchingAccount(String account) {
    return 'Ricerca in $account sul server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Ricerca nell’account sul server…';

  @override
  String searchAccountFailed(String account) {
    return 'Impossibile cercare in $account sul server';
  }

  @override
  String get searchUnknownAccountFailed => 'Impossibile cercare nell’account sul server';

  @override
  String searchChip(String term) {
    return '$term. Tocca due volte per modificare.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Non $term. Tocca due volte per modificare.';
  }

  @override
  String get searchReadAndUnread =>
      'La posta in arrivo di Schrödinger: ogni messaggio qui è letto e non letto finché non lo apri.';

  @override
  String searchContradiction(String term) {
    return 'Nessun messaggio può essere «$term» e non esserlo allo stesso tempo.';
  }

  @override
  String get searchSyncDeviceOnly => 'Solo su questo dispositivo';

  @override
  String searchSyncUnsupported(String account) {
    return 'Solo su questo dispositivo: $account non può conservarla';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Non sincronizzata: $account ha un formato più recente';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'In attesa di sincronizzazione con $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sincronizzata con $account';
  }

  @override
  String get searchRename => 'Rinomina';

  @override
  String get searchEditSearch => 'Modifica ricerca';

  @override
  String get searchDeleteSmartMailbox => 'Elimina Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Rinomina Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Questa Smart Mailbox è stata eliminata.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Le Smart Mailboxes restano su questo dispositivo.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Le Smart Mailboxes sono conservate sul tuo server di posta, così le hanno anche gli altri tuoi dispositivi, e anche Thunderbird con Expression Search Reloaded. Quelle che cercano in tutti gli account sono conservate su $account; quelle di una cartella, sull’account di quella cartella.';
  }

  @override
  String get searchSyncVia => 'Sincronizza tramite';

  @override
  String get searchSyncViaFooter => 'Scegli lo stesso account su tutti i dispositivi.';

  @override
  String get searchGmailCantKeep => 'Gmail non può conservare le Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Conserva le Smart Mailboxes solo su questo dispositivo';

  @override
  String get searchOnTheServer => 'Sul server';

  @override
  String get searchServerFooter =>
      'I metadati del server (IMAP METADATA) non compaiono in nessuna app di posta. I server che non li supportano ricevono una cartella «Loupe Settings» con un messaggio; Loupe la nasconde in Caselle.';

  @override
  String get searchSyncNow => 'Sincronizza ora';

  @override
  String get searchStateUnsupported => 'Non supportato';

  @override
  String get searchStateNewerFormat => 'Formato più recente';

  @override
  String get searchStateFailed => 'Sincronizzazione non riuscita';

  @override
  String get searchStateSyncing => 'Sincronizzazione…';

  @override
  String get searchStateWaiting => 'In attesa';

  @override
  String get searchStateMetadata => 'Metadati del server';

  @override
  String get searchStateFolder => 'Cartella Loupe Settings';

  @override
  String get searchStateNothing => 'Niente di salvato';

  @override
  String get sharedBack => 'Indietro';

  @override
  String get sharedYesterday => 'Ieri';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date alle $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count byte', one: '$count byte');
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
  String get sharedSyncNoAccounts => 'Nessun account';

  @override
  String get sharedSyncChecking => 'Controllo della posta…';

  @override
  String get sharedSyncFailed => 'Impossibile controllare la posta';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Aggiornato ora';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Aggiornato $minutes minuti fa',
      one: 'Aggiornato $minutes minuto fa',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Aggiornato alle $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Aggiornato il $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Tutte le caselle in arrivo';

  @override
  String get sharedMailboxUnread => 'Non letti';

  @override
  String get sharedMailboxFlagged => 'Contrassegnati';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Tutte le bozze';

  @override
  String get sharedMailboxAllSent => 'Tutti gli inviati';

  @override
  String get sharedMailboxUntitled => 'Casella';

  @override
  String get sharedTagImportant => 'Importante';

  @override
  String get sharedTagWork => 'Lavoro';

  @override
  String get sharedTagPersonal => 'Personale';

  @override
  String get sharedTagToDo => 'Da fare';

  @override
  String get sharedTagLater => 'In attesa';

  @override
  String get sharedTags => 'Tag';

  @override
  String get sharedMoveTo => 'Sposta in…';

  @override
  String get sharedNoRecipients => 'Nessun destinatario';

  @override
  String get sharedUnknownSender => 'Mittente sconosciuto';

  @override
  String get sharedOnServer => 'Sul server';

  @override
  String get sharedAttachment => 'Allegato';

  @override
  String get sharedSnoozedBadge => 'Posticipato';

  @override
  String get sharedRowUnread => 'Non letto';

  @override
  String get sharedRowBackFromSnooze => 'Tornato dal posticipo';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Contrassegnato';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi archiviati',
      one: '$count messaggio archiviato',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi eliminati',
      one: '$count messaggio eliminato',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi spostati in Posta in arrivo',
      one: '$count messaggio spostato in Posta in arrivo',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi spostati nel Cestino',
      one: '$count messaggio spostato nel Cestino',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi spostati in Spam',
      one: '$count messaggio spostato in Spam',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi spostati in $mailbox',
      one: '$count messaggio spostato in $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi spostati nella casella',
      one: '$count messaggio spostato nella casella',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi posticipati fino a $time',
      one: '$count messaggio posticipato fino a $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Posticipato fino a $time solo su questo dispositivo: il server non può memorizzare gli orari dei posticipi.';
  }

  @override
  String get sharedMoveOneAccount => 'Seleziona messaggi di un solo account per spostarli.';

  @override
  String get sharedSnoozeTitle => 'Posticipa';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Cambia orario del posticipo';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eliminare definitivamente $count messaggi?',
      one: 'Eliminare definitivamente questo messaggio?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'L’operazione non può essere annullata.';

  @override
  String get sharedDeletePermanently => 'Elimina definitivamente';

  @override
  String get sharedSwipeRead => 'Letto';

  @override
  String get sharedSwipeUnread => 'Non letto';

  @override
  String get sharedSwipeInbox => 'In arrivo';

  @override
  String get sharedSwipeDelete => 'Elimina';

  @override
  String get sharedTrash => 'Cestina';

  @override
  String get sharedSwipeSnooze => 'Posticipa';

  @override
  String get sharedWakeNow => 'Riporta ora';

  @override
  String get sharedChangeSnoozeTime => 'Cambia orario del posticipo…';

  @override
  String get sharedSnooze => 'Posticipa…';

  @override
  String get sharedTag => 'Tag…';

  @override
  String get sharedMoveMessage => 'Sposta messaggio…';

  @override
  String get sharedNotJunk => 'Non è spam';

  @override
  String get accountSetupTitle => 'Aggiungi account';

  @override
  String get accountSetupTitleDone => 'Account aggiunto';

  @override
  String get accountSetupAddressTitle => 'Aggiungi un account di posta';

  @override
  String get accountSetupAddressText => 'Loupe trova le impostazioni per la maggior parte dei provider.';

  @override
  String get accountSetupNameHint => 'Il tuo nome';

  @override
  String get accountSetupEmail => 'Email';

  @override
  String get accountSetupEmailHint => 'nome@example.com';

  @override
  String get accountSetupContinue => 'Continua';

  @override
  String get accountSetupLookingUp => 'Ricerca delle impostazioni…';

  @override
  String get accountSetupImport => 'Importa da Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Inserisci un indirizzo email valido.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Impossibile trovare le impostazioni per $domain. Inseriscile qui sotto.';
  }

  @override
  String get accountSetupCheckServers => 'Controlla i nomi dei server e le porte.';

  @override
  String get accountSetupEnterPassword => 'Inserisci la password.';

  @override
  String get accountSetupConnecting => 'Connessione…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'In attesa di $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Impossibile aprire la pagina.';

  @override
  String get accountSetupCouldNotSaveName => 'Impossibile salvare il nome.';

  @override
  String get accountSetupTrustCertificate => 'Considera attendibile questo certificato';

  @override
  String get accountSetupPasswordRequired => 'Obbligatoria';

  @override
  String get accountSetupShowPassword => 'Mostra password';

  @override
  String get accountSetupHidePassword => 'Nascondi password';

  @override
  String get accountSetupAppPassword => 'Password per le app';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'In arrivo · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'In uscita · SMTP';

  @override
  String get accountSetupSignIn => 'Accedi';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Accedi con $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Usa una password per le app';

  @override
  String get accountSetupUseAppPasswordInstead => 'Usa invece una password per le app';

  @override
  String get accountSetupUseDifferentAddress => 'Usa un altro indirizzo';

  @override
  String get accountSetupHowToCreateAppPassword => 'Come creare una password per le app';

  @override
  String get accountSetupHowToCreateOne => 'Come crearne una';

  @override
  String get accountSetupGoogleNote =>
      'Accedi sulla pagina di Google e Loupe non vede mai la tua password. Consenti a Loupe di leggere, inviare e organizzare la tua posta.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Accedi con Google» non è ancora disponibile in questa build. Puoi invece connetterti con una password per le app (richiede la Verifica in due passaggi sul tuo account Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Crea una password per le app nel tuo account Google e incollala qui sotto.';

  @override
  String get accountSetupMicrosoftNote =>
      'Accedi sulla pagina di Microsoft e Loupe non vede mai la tua password. Funziona con Outlook.com e Hotmail, e con gli account aziendali o dell’istituto di istruzione su Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'L’accesso con Microsoft arriverà in una build successiva. Gli account Outlook, Hotmail e Microsoft 365 ne hanno bisogno: non accettano più le password dalle app di posta.';

  @override
  String get accountSetupICloudNote =>
      'Mail di iCloud richiede una password specifica per l’app, non la password del tuo Account Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail richiede una password per le app, non la password del tuo account.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe si connette a Fastmail tramite JMAP con un token API: Settings › Privacy & Security › Manage API tokens, per JMAP, con accesso alla posta e all’invio.';

  @override
  String get accountSetupFastmailNote => 'Fastmail richiede una password per le app di posta.';

  @override
  String get accountSetupServerSettings => 'Impostazioni del server';

  @override
  String get accountSetupSettingsNotFound => 'Non trovate automaticamente';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Trovate tramite $source';
  }

  @override
  String get accountSetupEditSettings => 'Modifica impostazioni';

  @override
  String get accountSetupSyncing => 'La tua posta si sta sincronizzando.';

  @override
  String get accountSetupDescription => 'Descrizione';

  @override
  String get accountSetupDescriptionHint => 'Lavoro, Personale…';

  @override
  String get accountSetupColour => 'Colore';

  @override
  String accountSetupColourNumber(int number) {
    return 'Colore $number';
  }

  @override
  String get accountSetupSaving => 'Salvataggio…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe non è riuscita ad aprire il suo database della posta su questo telefono. Chiudi Loupe, riaprila e riprova.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Si è verificato un errore ($error). Riprova.';
  }

  @override
  String get accountSetupSecurityNone => 'Nessuna';

  @override
  String get accountSetupProtocol => 'Protocollo';

  @override
  String get accountSetupPort => 'Porta';

  @override
  String get accountSetupSecurity => 'Sicurezza';

  @override
  String get accountSetupUsername => 'Nome utente';

  @override
  String get accountSetupUsernameHint => 'Il tuo indirizzo email';

  @override
  String get accountSetupNoEncryptionTitle => 'Connettersi senza crittografia?';

  @override
  String get accountSetupNoEncryptionText =>
      'La tua password e ogni messaggio viaggerebbero in chiaro. Chiunque sulla rete, ad esempio su un Wi-Fi pubblico, potrebbe leggerli. Usa questa opzione solo per un server sulla tua rete.';

  @override
  String get accountSetupUseWithoutEncryption => 'Usa senza crittografia';

  @override
  String get accountSetupApiTokenRejected =>
      'Token API rifiutato. Crea un token API di Fastmail per JMAP con accesso alla posta e incollalo.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Password rifiutata. Usa una password per le app, non la password del tuo account.';

  @override
  String get accountSetupPasswordRejected => 'Password rifiutata. Controllala e riprova.';

  @override
  String get accountSetupServerUnreachable =>
      'Impossibile raggiungere il server. Controlla le impostazioni del server e la connessione.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Il certificato del server non è attendibile. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'L’accesso è stato annullato. Tocca «Accedi con $provider» per riprovare.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe ha bisogno dell’autorizzazione per leggere e inviare la tua posta Gmail. Accedi di nuovo e consenti l’accesso, con la casella di Gmail selezionata.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe ha bisogno dell’autorizzazione per leggere e inviare la tua posta. Accedi di nuovo e accetta le autorizzazioni.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'La tua organizzazione deve approvare Loupe prima che tu possa usarla con questo account. Chiedi al tuo amministratore IT di concedere il consenso amministratore per Loupe in Microsoft Entra ID, poi riprova.';

  @override
  String get accountSetupOAuthBlocked =>
      'Le regole di accesso della tua organizzazione non consentono Loupe su questo dispositivo. Rivolgiti al tuo amministratore IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Impossibile raggiungere $provider. Controlla la connessione a internet e riprova.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'L’accesso con $provider non è configurato correttamente in questa versione di Loupe. Segnala il problema.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'L’accesso con $provider non è riuscito. Riprova.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider ti ha fatto accedere, ma Gmail ha rifiutato l’accesso per questo indirizzo. Scegli lo stesso account quando accedi. Negli account aziendali o dell’istituto di istruzione l’amministratore potrebbe aver disattivato IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider ti ha fatto accedere, ma il server di posta ha rifiutato l’accesso per questo indirizzo. Scegli lo stesso account quando accedi. Negli account aziendali o dell’istituto di istruzione l’amministratore potrebbe aver disattivato IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Impossibile raggiungere il server di posta. Controlla la connessione e riprova.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'L’accesso con $provider non è disponibile in questa versione.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Accesso eseguito di nuovo. $account si sta sincronizzando.';
  }

  @override
  String get accountSetupSignInAgain => 'Accedi di nuovo';

  @override
  String get accountSetupSigningIn => 'Accesso in corso…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider non accetta più l’accesso di Loupe per $email, quindi $account non si sincronizza. Accedi di nuovo per ricevere la posta.';
  }

  @override
  String get accountImportTitle => 'Importa da Thunderbird';

  @override
  String get accountImportPointCamera => 'Inquadra il codice QR mostrato da Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned su $total scansionati';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned su $total codici scansionati',
      one: '$scanned su $total codice scansionato',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count account finora',
      one: '$count account finora',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Sul computer, apri Thunderbird e scegli Strumenti › Esporta per dispositivi mobili. Seleziona i tuoi account, poi scansiona ogni codice mostrato. I codici possono essere scansionati in qualsiasi ordine.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continua con $count account',
      one: 'Continua con $count account',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Incolla invece il testo';

  @override
  String get accountImportStartOver => 'Ricomincia';

  @override
  String get accountImportDuplicateCode => 'Questo codice è già stato aggiunto.';

  @override
  String get accountImportRestarted =>
      'Questo codice proviene da una nuova esportazione, quindi i codici scansionati prima sono stati messi da parte.';

  @override
  String get accountImportNotThunderbird => 'Questo non è un codice di account di Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Questo codice proviene da una versione più recente di Thunderbird. Aggiorna Loupe per importarlo.';

  @override
  String get accountImportDamaged => 'Impossibile leggere questo codice di Thunderbird.';

  @override
  String get accountImportTooLarge => 'Questo codice è troppo grande per essere un’esportazione di Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Impossibile aprire Impostazioni.';

  @override
  String get accountImportCameraOffTitle => 'L’accesso alla fotocamera è disattivato';

  @override
  String get accountImportCameraOffText =>
      'Consenti a Loupe di usare la fotocamera in Impostazioni per scansionare il codice, oppure incolla invece il testo del codice.';

  @override
  String get accountImportNoCameraTitle => 'Nessuna fotocamera';

  @override
  String get accountImportNoCameraText => 'Loupe non può usare una fotocamera qui. Incolla invece il testo del codice.';

  @override
  String get accountImportCameraFailedTitle => 'La fotocamera non si è avviata';

  @override
  String get accountImportCameraFailedText => 'Riprova, oppure incolla invece il testo del codice.';

  @override
  String get accountImportOpenSettings => 'Apri Impostazioni';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count account trovati',
      one: '$count account trovato',
      zero: 'Nessun account trovato',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable =>
      'Non è stato possibile leggere nessuno degli account contenuti in questi codici.';

  @override
  String get accountImportChoose => 'Scegli gli account da aggiungere a Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I codici $codes di $total non sono stati scansionati, quindi i loro account non sono elencati.',
      one: 'Il codice $codes di $total non è stato scansionato, quindi i suoi account non sono elencati.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes e $last';
  }

  @override
  String get accountImportScanMore => 'Scansiona altri codici';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Non è stato possibile leggere $count account nei codici. Potrebbero usare impostazioni di una versione più recente di Thunderbird.',
      one: 'Non è stato possibile leggere un account nei codici. Potrebbe usare impostazioni di una versione più recente di Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scansiona di nuovo';

  @override
  String get accountImportAlreadyAdded => 'Un account con questo indirizzo è già presente in Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Accederai con $provider quando verrà aggiunto, come in Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Aggiungi l’account con una password per le app (richiede la Verifica in due passaggi).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird accede a Gmail con Google. «Accedi con Google» arriverà in una build successiva; fino ad allora, aggiungi l’account con una password per le app (richiede la Verifica in due passaggi).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird accede a questo account nel browser. Loupe non può ancora farlo: usa una password per le app se il tuo provider la offre.';

  @override
  String get accountImportUnencrypted => 'Si connette senza crittografia. Usalo solo sulla tua rete.';

  @override
  String get accountImportEnterAgain => 'Inseriscila di nuovo';

  @override
  String get accountImportAdded => 'Aggiunto';

  @override
  String accountImportAdding(int index, int total) {
    return 'Aggiunta di $index su $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aggiungi $count account',
      one: 'Aggiungi $count account',
      zero: 'Aggiungi account',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Incolla il testo dell’esportazione';

  @override
  String get accountImportPasteText =>
      'Incolla il testo di un codice di esportazione di Thunderbird, un codice per riga.';

  @override
  String get accountImportPop3 => 'Gli account POP3 non sono supportati. Loupe tiene la posta sul server con IMAP.';

  @override
  String get accountImportKerberos => 'Questo account accede con Kerberos, che Loupe non supporta.';

  @override
  String get accountImportNtlm => 'Questo account accede con NTLM, che Loupe non supporta.';

  @override
  String get accountImportClientCertificate =>
      'Questo account accede con un certificato client, che Loupe non supporta ancora.';

  @override
  String get accountImportMicrosoftSignIn =>
      'L’accesso con Microsoft arriverà in una build successiva. Gli account Outlook e Microsoft 365 non accettano più le password dalle app di posta.';

  @override
  String get accountImportEnterPassword => 'Inserisci la password.';

  @override
  String get accountImportEnterAppPassword => 'Inserisci la password per le app.';

  @override
  String get accountImportEnterApiToken => 'Inserisci il token API.';

  @override
  String get accountImportStorageFailed =>
      'Loupe non è riuscita ad aprire l’archivio degli account. Riprova più tardi.';

  @override
  String get accountImportFailed => 'Impossibile aggiungere l’account. Riprova, oppure aggiungilo manualmente.';

  @override
  String get composeNewMessageTitle => 'Nuovo messaggio';

  @override
  String get composeAttach => 'Allega';

  @override
  String get composeSendLater => 'Invia più tardi';

  @override
  String composeSendAt(String time) {
    return 'Invia $time';
  }

  @override
  String get composeSendHint => 'Tieni premuto per inviare più tardi';

  @override
  String get composeNoAccount => 'Aggiungi un account per inviare posta.';

  @override
  String get composeTo => 'A:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Ccn:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Ccn, Da: $email';
  }

  @override
  String get composeFromLabel => 'Da:';

  @override
  String get composeSubjectLabel => 'Oggetto:';

  @override
  String composeReplyTo(String address) {
    return 'Rispondi a: $address';
  }

  @override
  String get composeFrom => 'Da';

  @override
  String composeReplyFrom(String email) {
    return 'Rispondi da $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Invia da $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Rispondere da $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Inviare da $email?';
  }

  @override
  String get composeDismiss => 'Ignora';

  @override
  String composeAliasNotSaved(String account) {
    return 'Non salvato come identità · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Salva come identità';

  @override
  String composeAliasSaved(String email) {
    return '$email è stato salvato come identità.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Indirizzo non valido $address';
  }

  @override
  String get composeOriginalNotFound => 'Impossibile trovare il messaggio originale.';

  @override
  String get composeDraftNotFound => 'Impossibile trovare la bozza.';

  @override
  String get composeAttachmentsLost => 'Impossibile recuperare gli allegati. Aggiungili di nuovo.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Impossibile aggiungere alcuni allegati: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Gli allegati occupano in totale $size; alcuni server rifiutano messaggi così grandi.';
  }

  @override
  String get composeAttachFailed => 'Impossibile allegare il file.';

  @override
  String get composeInvalidAddressTitle => 'Indirizzo non valido';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» non è un indirizzo email valido.';
  }

  @override
  String get composeNoSubjectTitle => 'Nessun oggetto';

  @override
  String get composeNoSubjectText => 'Questo messaggio non ha un oggetto. Inviarlo comunque?';

  @override
  String get composeSentBeforeChanges => 'È stato inviato prima delle tue modifiche, che sono salvate in Bozze.';

  @override
  String composeScheduled(String time) {
    return 'Programmato per $time';
  }

  @override
  String get composeSending => 'Invio in corso…';

  @override
  String get composeSent => 'Inviato';

  @override
  String get composeSendFailed => 'Impossibile inviare. Riprova.';

  @override
  String get composeAlreadySent => 'Già inviato.';

  @override
  String get composeDiscardChanges => 'Annulla modifiche';

  @override
  String get composeSaveChanges => 'Salva modifiche';

  @override
  String get composeDeleteDraft => 'Elimina bozza';

  @override
  String get composeSaveDraft => 'Salva bozza';

  @override
  String get composeDraftSaved => 'Bozza salvata';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Il $date alle $time, $name ha scritto:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Il $date alle $time, qualcuno ha scritto:';
  }

  @override
  String get composeForwardHeader => '---------- Messaggio inoltrato ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Da: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date alle $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Oggetto: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'A: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Più tardi oggi';

  @override
  String get composeTomorrowMorning => 'Domani mattina';

  @override
  String get composeMondayMorning => 'Lunedì mattina';

  @override
  String get composePickDateTime => 'Scegli data e ora…';

  @override
  String get composeSendWithoutDelay => 'Invia subito';

  @override
  String composeSendTimeToday(String time) {
    return 'Oggi alle $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Domani alle $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day alle $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Oggi $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Domani $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Continuare a modificare la bozza?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Un messaggio non è stato inviato quando Loupe si è chiusa.',
      'one': 'Un messaggio a $name non è stato inviato quando Loupe si è chiusa.',
      'other': 'Un messaggio a $name e altri non è stato inviato quando Loupe si è chiusa.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '«$subject» non è stato inviato quando Loupe si è chiusa.',
      'one': '«$subject» a $name non è stato inviato quando Loupe si è chiusa.',
      'other': '«$subject» a $name e altri non è stato inviato quando Loupe si è chiusa.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Continua a modificare';

  @override
  String get composeRecoverySave => 'Salva in Bozze';

  @override
  String get composeRecoveryDiscard => 'Elimina';

  @override
  String get composeRecoverySaved => 'Salvato in Bozze';

  @override
  String get outboxSectionFailed => 'Non inviati';

  @override
  String get outboxSectionSending => 'In invio';

  @override
  String get outboxSectionScheduled => 'Programmati';

  @override
  String get outboxStatusQueued => 'Invio a breve';

  @override
  String get outboxStatusSending => 'Invio in corso…';

  @override
  String get outboxStatusFailed => 'Non inviato';

  @override
  String get outboxNoRecipients => 'Nessun destinatario';

  @override
  String get outboxNoSubject => '(Nessun oggetto)';

  @override
  String get outboxSendingFailed => 'Invio non riuscito.';

  @override
  String get outboxEmptyTitle => 'Niente da inviare';

  @override
  String get outboxEmptyText => 'I messaggi che invii più tardi aspettano qui fino al momento giusto.';

  @override
  String get outboxSendNow => 'Invia ora';

  @override
  String get outboxReschedule => 'Riprogramma';

  @override
  String get outboxRescheduleMenu => 'Riprogramma…';

  @override
  String get outboxRescheduleTitle => 'Riprogramma';

  @override
  String outboxRescheduled(String time) {
    return 'Riprogrammato per $time';
  }

  @override
  String get outboxCancel => 'Annulla';

  @override
  String get outboxCancelSending => 'Annulla invio…';

  @override
  String get outboxCancelTitle => 'Annullare l’invio?';

  @override
  String get outboxMoveToDrafts => 'Sposta in Bozze';

  @override
  String get outboxDiscard => 'Elimina messaggio';

  @override
  String get outboxMovedToDrafts => 'Spostato in Bozze';

  @override
  String get outboxDiscarded => 'Messaggio eliminato';

  @override
  String get outboxAlreadySent => 'Già inviato.';

  @override
  String get outboxBeingSent => 'Questo messaggio è in fase di invio.';

  @override
  String get outboxActionFailed => 'Non ha funzionato. Il messaggio è ancora nella Posta in uscita.';

  @override
  String get notificationsBadgeInboxes => 'Non letti in Posta in arrivo';

  @override
  String get notificationsBadgeVip => 'Non letti dei VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nuova posta dai tuoi VIP, in qualsiasi account';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nuova posta in $email';
  }

  @override
  String get notificationsUnknownSender => 'Mittente sconosciuto';

  @override
  String get notificationsNoSubject => '(Nessun oggetto)';

  @override
  String get notificationsEncryptedMessage => 'Messaggio cifrato';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nuovo messaggio da $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuovi messaggi',
      one: '$count nuovo messaggio',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nuovi messaggi in $account';
  }

  @override
  String get platformInstantChannel => 'Consegna immediata';

  @override
  String get platformInstantChannelDescription =>
      'Compare mentre Loupe controlla le tue caselle in arrivo in attesa di nuova posta';

  @override
  String get platformInstantTitle => 'In attesa di nuova posta';

  @override
  String get platformInstantText => 'La Consegna immediata è attiva';

  @override
  String get platformErrorBox => 'Si è verificato un errore durante la visualizzazione. Torna indietro e riprova.';

  @override
  String get welcomeTagline => 'Posta semplice fuori\ne potente dentro.';

  @override
  String get welcomeAccountsTitle => 'Tutti gli account, un’unica posta in arrivo tranquilla';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail e qualsiasi server IMAP o JMAP.';

  @override
  String get welcomeSearchTitle => 'Una ricerca che trova';

  @override
  String get welcomeSearchText => 'Risultati immediati dal telefono, poi quelli del server.';

  @override
  String get welcomePrivacyTitle => 'Pensata per la privacy';

  @override
  String get welcomePrivacyText => 'Nessun tracciamento. Le immagini remote restano bloccate finché non decidi tu.';

  @override
  String get welcomeAddAccount => 'Aggiungi account';

  @override
  String get welcomeImport => 'Importa da Thunderbird';

  @override
  String get welcomeTryDemo => 'Prova con la posta demo';
}
