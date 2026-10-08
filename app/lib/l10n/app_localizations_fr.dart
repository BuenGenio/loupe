// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonMore => 'Plus';

  @override
  String get commonMove => 'Déplacer';

  @override
  String get commonName => 'Nom';

  @override
  String get commonNone => 'Aucun';

  @override
  String get commonOff => 'Désactivé';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Activé';

  @override
  String get commonOptional => 'Facultatif';

  @override
  String get commonPassword => 'Mot de passe';

  @override
  String get commonRemove => 'Retirer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get commonServer => 'Serveur';

  @override
  String get commonSettings => 'Paramètres';

  @override
  String get commonShare => 'Partager';

  @override
  String get commonTryAgain => 'Réessayer';

  @override
  String get commonUndo => 'Annuler';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      many: '$count de messages',
      one: '$count message',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archiver';

  @override
  String get mailDelete => 'Supprimer';

  @override
  String get mailFlag => 'Ajouter un drapeau';

  @override
  String get mailForward => 'Transférer';

  @override
  String get mailMarkAsRead => 'Marquer comme lu';

  @override
  String get mailMarkAsUnread => 'Marquer comme non lu';

  @override
  String get mailMoveToJunk => 'Déplacer vers Indésirables';

  @override
  String get mailNewMessage => 'Nouveau message';

  @override
  String get mailNoSubject => 'Sans objet';

  @override
  String get mailReply => 'Répondre';

  @override
  String get mailReplyAll => 'Répondre à tous';

  @override
  String get mailSend => 'Envoyer';

  @override
  String get mailUnflag => 'Retirer le drapeau';

  @override
  String get mailboxArchive => 'Archives';

  @override
  String get mailboxDrafts => 'Brouillons';

  @override
  String get mailboxInbox => 'Boîte de réception';

  @override
  String get mailboxJunk => 'Indésirables';

  @override
  String get mailboxOutbox => 'Boîte d’envoi';

  @override
  String get mailboxSent => 'Envoyés';

  @override
  String get mailboxTrash => 'Corbeille';

  @override
  String get conversationSomethingWentWrong => 'Un problème est survenu. Réessayez.';

  @override
  String get conversationReplyToList => 'Répondre à la liste';

  @override
  String get conversationReplyList => 'Répondre à la liste';

  @override
  String get conversationThreadMuted => 'Fil mis en sourdine. Ses nouveaux messages arriveront déjà lus.';

  @override
  String get conversationThreadUnmuted => 'Le fil n’est plus en sourdine.';

  @override
  String get conversationLinkFailed => 'Impossible d’ouvrir le lien.';

  @override
  String get conversationGoneTitle => 'Aucun message';

  @override
  String get conversationGoneText => 'Ce message a été déplacé ou supprimé.';

  @override
  String get conversationMuted => 'En sourdine';

  @override
  String get conversationReaderOptions => 'Options de lecture';

  @override
  String get conversationReaderOptionsHint => 'Taille du texte et affichage';

  @override
  String get conversationTrash => 'Corbeille';

  @override
  String get conversationReplyHint => 'Appuyez longuement pour Répondre à tous ou Transférer';

  @override
  String get conversationOfflineTitle => 'Vous êtes hors ligne';

  @override
  String get conversationOfflineText =>
      'Cette conversation n’est pas encore téléchargée. Elle se chargera dès que vous serez de nouveau en ligne.';

  @override
  String get conversationErrorTitle => 'Impossible d’afficher ce message';

  @override
  String get conversationErrorText => 'Un problème est survenu.';

  @override
  String get conversationOfflineBanner => 'Vous êtes hors ligne';

  @override
  String get conversationNotUpdated => 'Non mis à jour';

  @override
  String get conversationMe => 'moi';

  @override
  String get conversationNoSender => '(aucun expéditeur)';

  @override
  String get conversationNoRecipients => 'aucun destinataire';

  @override
  String conversationRecipients(String names) {
    return 'à $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'à $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'De';

  @override
  String get conversationHeaderTo => 'À';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Cci';

  @override
  String get conversationHeaderReplyTo => 'Répondre à';

  @override
  String get conversationHeaderDate => 'Date';

  @override
  String get conversationHeaderSecurity => 'Sécurité';

  @override
  String get conversationVerifiedSender => 'Expéditeur vérifié';

  @override
  String get conversationUnverifiedSender => 'Expéditeur non vérifié';

  @override
  String get conversationLoadingMessage => 'Chargement du message';

  @override
  String get conversationBodyError => 'Impossible de charger ce message.';

  @override
  String get conversationBodyOffline =>
      'Vous êtes hors ligne. Le message se chargera dès que vous serez de nouveau en ligne.';

  @override
  String get conversationOriginalHint => 'S’affiche mieux en vue Original';

  @override
  String get conversationShowOriginal => 'Afficher l’original';

  @override
  String get conversationScrollToTop => 'Remonter en haut';

  @override
  String get conversationTagsMenu => 'Étiquettes…';

  @override
  String get conversationMuteThread => 'Mettre le fil en sourdine';

  @override
  String get conversationUnmuteThread => 'Désactiver la sourdine du fil';

  @override
  String get conversationMoveMenu => 'Déplacer…';

  @override
  String get conversationDeletePermanently => 'Supprimer définitivement';

  @override
  String get conversationMoveToTrash => 'Mettre à la corbeille';

  @override
  String get conversationNotJunk => 'Pas indésirable';

  @override
  String get conversationShowAllHeaders => 'Afficher tous les en-têtes';

  @override
  String get conversationViewSource => 'Afficher la source';

  @override
  String get conversationSaveAsFile => 'Enregistrer comme fichier…';

  @override
  String get conversationShareAsFile => 'Partager comme fichier…';

  @override
  String get conversationSearchFromMessageMenu => 'Rechercher à partir de ce message…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Copier l’adresse';

  @override
  String get conversationAddressCopied => 'Adresse copiée';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Rechercher les messages de $name';
  }

  @override
  String get conversationTags => 'Étiquettes';

  @override
  String get conversationAllHeaders => 'Tous les en-têtes';

  @override
  String get conversationCopyAll => 'Tout copier';

  @override
  String get conversationHeadersCopied => 'En-têtes copiés';

  @override
  String get conversationNoHeaders => 'Aucun en-tête';

  @override
  String get conversationSearchFromMessageTitle => 'Rechercher à partir de ce message';

  @override
  String conversationSearchFrom(String name) {
    return 'De $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'À $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Objet « $subject »';
  }

  @override
  String get conversationSourceTitle => 'Source';

  @override
  String get conversationSourceCopied => 'Source copiée';

  @override
  String get conversationShareFailed => 'Impossible de partager le message.';

  @override
  String get conversationWrapLines => 'Activer le retour à la ligne';

  @override
  String get conversationDontWrapLines => 'Désactiver le retour à la ligne';

  @override
  String get conversationSourceError => 'Impossible de charger la source.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Affichage des premiers $shown sur $total. Copiez ou partagez pour tout obtenir.';
  }

  @override
  String get conversationAttachmentUntitled => 'Sans titre';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Plus d’actions pour $name';
  }

  @override
  String get conversationMoveTo => 'Déplacer vers…';

  @override
  String get conversationMailboxesError => 'Impossible de charger les boîtes aux lettres.';

  @override
  String get conversationReaderReadable => 'Lisible';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Texte brut';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Conserver les couleurs d’origine';

  @override
  String get conversationReaderRemember => 'Mémoriser pour cet expéditeur';

  @override
  String get conversationSecurityPossiblePhishing => 'Phishing possible';

  @override
  String get conversationSecurityBeCareful => 'Prudence';

  @override
  String get conversationSecurityVerified => 'Vérifié';

  @override
  String get conversationSecurityNoIssues => 'Aucun problème détecté';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count traqueurs',
      many: '$count de traqueurs',
      one: '$count traqueur',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Explique pourquoi';

  @override
  String get conversationPhishingBannerTitle => 'Ce message ressemble à du phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Les liens et les images sont désactivés.';
  }

  @override
  String get conversationPhishingBannerText => 'Les liens et les images sont désactivés.';

  @override
  String get conversationPhishingWhy => 'Pourquoi ?';

  @override
  String get conversationPhishingShowAnyway => 'Afficher quand même';

  @override
  String get conversationSecurityPhishingTitle => 'Cela ressemble à du phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Plusieurs signes indiquent que ce message n’est pas ce qu’il prétend être.';

  @override
  String get conversationSecurityCarefulTitle => 'Méfiez-vous de ce message';

  @override
  String get conversationSecurityCarefulText => 'Un détail mérite un second regard.';

  @override
  String get conversationSecurityVerifiedText => 'L’expéditeur est vérifié et rien ne semble suspect.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Rien ne semble suspect. Votre serveur de messagerie n’a pas indiqué si l’expéditeur est vérifié.';

  @override
  String get conversationSecurityNothingSuspicious => 'Rien ne semble suspect.';

  @override
  String get conversationSecurityWhy => 'Pourquoi';

  @override
  String get conversationSecurityPrivacy => 'Confidentialité';

  @override
  String get conversationSecurityNoTrackingPixels => 'Aucun pixel espion';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pixels espions supprimés',
      many: '$count de pixels espions supprimés',
      one: '$count pixel espion supprimé',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Ils auraient signalé à l’expéditeur que vous avez ouvert ce message.';

  @override
  String get conversationSecurityNoRemoteImages => 'Aucune image distante';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count images distantes',
      many: '$count d’images distantes',
      one: '$count image distante',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Les charger indique à l’expéditeur quand vous lisez ce message, ainsi que votre adresse IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Aucun suivi des clics';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count liens passant par des traqueurs de clics',
      many: '$count de liens passant par des traqueurs de clics',
      one: '$count lien passant par un traqueur de clics',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services enregistrerait votre clic. Appuyez longuement sur un lien pour ouvrir directement sa destination.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Détails techniques';

  @override
  String get conversationSecurityCheckedLocally => 'Vérifié sur cet appareil. Rien n’a été envoyé nulle part.';

  @override
  String get conversationSecurityTrackersLabel => 'Traqueurs';

  @override
  String get conversationSecurityImagesFrom => 'Images de';

  @override
  String get conversationSecuritySenderHistory => 'Historique de l’expéditeur';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'reçus : $received, envoyés : $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Les liens mènent à';

  @override
  String get conversationSecurityHidden => 'Masqué';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements éléments',
      many: '$elements d’éléments',
      one: '$elements élément',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters caractères',
      many: '$characters de caractères',
      one: '$characters caractère',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Expéditeur non vérifié';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Votre serveur de messagerie n’a pas pu confirmer que ce message provient bien de $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Votre serveur de messagerie n’a pas pu confirmer que ce message provient bien de son expéditeur.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Votre serveur de messagerie n’a pas pu confirmer que ce message provient de $domain. C’est courant pour les listes de diffusion.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Votre serveur de messagerie n’a pas pu confirmer que ce message provient de son expéditeur. C’est courant pour les listes de diffusion.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'N’y donnez pas suite si vous ne l’attendiez pas. En cas de doute, contactez l’expéditeur par un autre moyen.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Signé par un autre domaine';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Le message est signé par $signer, et non par $domain. Les services d’envoi d’e-mails procèdent ainsi, mais cela ne prouve pas qui l’a écrit.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Le message est signé par un autre domaine que $domain. Les services d’envoi d’e-mails procèdent ainsi, mais cela ne prouve pas qui l’a écrit.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Le nom affiche une autre adresse';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Le nom de l’expéditeur indique « $shown », mais le message provient de $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Fiez-vous à l’adresse, pas au nom.';

  @override
  String get conversationSecurityReplyToTitle => 'Les réponses partent ailleurs';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'En répondant, vous enverriez votre réponse à $address, et non à $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Vérifiez l’adresse avant de répondre avec des informations personnelles.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Utilise votre nom';

  @override
  String get conversationSecurityImpersonationTitle => 'Utilise le nom d’une personne que vous connaissez';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Il est signé « $name », comme votre propre nom, mais provient d’une nouvelle adresse : $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Il est signé « $name », comme votre VIP $knownName ($knownEmail), mais provient d’une nouvelle adresse : $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Il est signé « $name », comme $knownName ($knownEmail), mais provient d’une nouvelle adresse : $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Et les réponses iraient à encore une autre adresse.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'S’il demande de l’argent, des codes ou des fichiers, vérifiez d’abord auprès de cette personne par un autre moyen.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Adresse connue : $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Cette adresse : $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Premier message de cet expéditeur';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Vous n’avez encore jamais reçu d’e-mail de $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Méfiez-vous des demandes de personnes que vous ne connaissez pas encore.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Lettres sosies dans l’adresse de l’expéditeur';

  @override
  String get conversationSecurityLinkHomographTitle => 'Lettres sosies dans un lien';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mélange des lettres de différents alphabets pour imiter une autre adresse.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host utilise des lettres sosies : ce n’est pas $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Supprimez-le ou signalez-le comme indésirable.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Ne l’ouvrez pas.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domaine : $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domaine sosie';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Utilise un nom familier dans son domaine';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain ressemble à votre propre domaine, $real, mais c’est un domaine différent.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain ressemble à $brand ($real), mais c’est un domaine différent.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain utilise le nom de votre propre domaine, $real, mais ne lui appartient pas.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain utilise le nom de $brand ($real), mais ne lui appartient pas.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Les vrais messages de votre organisation proviennent de $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Les vrais messages de $brand proviennent de $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domaine de l’expéditeur : $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imite : $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count liens cachent leur destination',
      many: '$count de liens cachent leur destination',
      one: '$count lien cache sa destination',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Un lien affiche $shown, mais ouvre $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Ne vous connectez pas et ne payez pas via ces liens. Tapez plutôt l’adresse vous-même.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '« $text » → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Impossible de vérifier la destination d’un lien';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Un lien affiche $shown, mais passe par $host, qui enregistre le clic avant de le transmettre.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Un lien pointe vers une simple adresse IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts n’est pas un site web nommé. Les vraies entreprises utilisent rarement ce type de lien.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Un lien déguisé';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Un lien commence par « $shown@ » pour ressembler à $shown, mais il ouvre $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Une page cachée a été désactivée';

  @override
  String get conversationSecurityDataLinkText =>
      'Un lien aurait ouvert une page intégrée au message, un moyen de contourner la vérification des liens.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Demande un mot de passe';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Le message contenait un champ de mot de passe. Loupe l’a supprimé.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Ne saisissez jamais de mot de passe dans un e-mail.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Un lien qui exécute du code a été désactivé';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe n’exécute jamais le code contenu dans les messages.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Liens raccourcis',
      one: '$count lien raccourci',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts masque la vraie destination jusqu’à ce que vous l’ouvriez.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Adresse web internationale';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts utilise des lettres non latines. C’est normal pour de nombreuses langues ; vérifiez qu’il s’agit bien du site attendu.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Beaucoup de texte caché';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count caractères de texte invisible ont été supprimés. Ce genre de texte caché sert à tromper les filtres antispam.',
      many:
          '$count de caractères de texte invisible ont été supprimés. Ce genre de texte caché sert à tromper les filtres antispam.',
      one:
          '$count caractère de texte invisible a été supprimé. Ce genre de texte caché sert à tromper les filtres antispam.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Texte caché supprimé';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count caractères de texte invisible ont été supprimés.',
      many: '$count de caractères de texte invisible ont été supprimés.',
      one: '$count caractère de texte invisible a été supprimé.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Impossible de télécharger le message. Vérifiez la connexion et réessayez.';

  @override
  String exportSaved(String name) {
    return '« $name » enregistré';
  }

  @override
  String get exportSaveFailed => 'Impossible d’enregistrer le message.';

  @override
  String exportFailed(String folder) {
    return 'Impossible d’exporter « $folder ».';
  }

  @override
  String exportEmpty(String folder) {
    return '« $folder » ne contient aucun message à exporter.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Impossible d’exporter « $folder » : aucun message n’a pu être téléchargé. Vérifiez la connexion et réessayez.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '« $name » enregistré sans $formattedCount messages qui n’ont pas pu être téléchargés.',
      many: '« $name » enregistré sans $formattedCount de messages qui n’ont pas pu être téléchargés.',
      one: '« $name » enregistré sans $count message qui n’a pas pu être téléchargé.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Impossible d’enregistrer « $name ».';
  }

  @override
  String exportTitle(String folder) {
    return 'Exportation de « $folder »';
  }

  @override
  String get exportListing => 'Recherche des messages…';

  @override
  String exportProgress(String current, String total) {
    return 'Exportation de $current sur $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount messages n’ont pas pu être téléchargés',
      many: '$formattedCount de messages n’ont pas pu être téléchargés',
      one: '$count message n’a pas pu être téléchargé',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Boîtes aux lettres';

  @override
  String get mailboxesShown => 'Affichée';

  @override
  String get mailboxesHidden => 'Masquée';

  @override
  String get mailboxesCollapse => 'Réduire';

  @override
  String get mailboxesExpand => 'Développer';

  @override
  String get mailboxesManageVips => 'Gérer les VIP';

  @override
  String get mailboxesSubscriptions => 'Abonnements';

  @override
  String mailboxesShowAccount(String account) {
    return 'Afficher $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Masquer $account';
  }

  @override
  String get mailboxesExportFolder => 'Exporter le dossier…';

  @override
  String get mailboxesUnpin => 'Désépingler';

  @override
  String get mailboxesLists => 'Listes';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Enregistrez une recherche pour la retrouver ici.';

  @override
  String get mailboxesTags => 'Étiquettes';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Vous pouvez aussi toucher le nom d’un expéditeur dans un message et activer VIP.';

  @override
  String get mailboxesAddVip => 'Ajouter un VIP…';

  @override
  String get mailboxesAddVipTitle => 'Ajouter un VIP';

  @override
  String get mailboxesAddVipText =>
      'Les e-mails de cette adresse reçoivent une étoile et apparaissent dans la boîte aux lettres VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'nom@example.com';

  @override
  String get messageListFilterUnread => 'Non lus';

  @override
  String get messageListFilterFlagged => 'Avec drapeau';

  @override
  String get messageListFilterToMe => 'À : moi';

  @override
  String get messageListFilterCcMe => 'Cc : moi';

  @override
  String get messageListFilterWithAttachments => 'Avec pièces jointes';

  @override
  String get messageListFilterUnreplied => 'Sans réponse';

  @override
  String get messageListFilterFromVips => 'Expéditeurs VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages marqués comme lus',
      many: '$count de messages marqués comme lus',
      one: '$count message marqué comme lu',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Impossible de charger les e-mails plus anciens.';

  @override
  String get messageListSelectMessages => 'Sélectionner des messages';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sélectionnés',
      one: '$count sélectionné',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Tout sélectionner';

  @override
  String get messageListDeselectAll => 'Tout désélectionner';

  @override
  String get messageListLoadFailed => 'Impossible de charger les e-mails';

  @override
  String get messageListNoUnread => 'Aucun e-mail non lu';

  @override
  String get messageListNoMatches => 'Aucun e-mail correspondant';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtré par : $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Désactiver le filtre';

  @override
  String get messageListEmpty => 'Aucun e-mail';

  @override
  String get messageListFilter => 'Filtrer';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Critères de filtre : $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtré par :';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount non lus',
      one: '$count non lu',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Marquer';

  @override
  String get messageListTrash => 'Corbeille';

  @override
  String get messageListFilterTitle => 'Filtre';

  @override
  String get messageListFilterInclude => 'INCLURE';

  @override
  String get panesHideMailboxes => 'Masquer les boîtes aux lettres';

  @override
  String get panesShowMailboxes => 'Afficher les boîtes aux lettres';

  @override
  String get panesMailboxesWidth => 'Largeur des boîtes aux lettres';

  @override
  String get panesListWidth => 'Largeur de la liste des messages';

  @override
  String get panesNoMessageSelected => 'Aucun message sélectionné';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      many: '$count de messages',
      one: '$count message',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'En attente';

  @override
  String get snoozeSheetTitle => 'Mettre en attente';

  @override
  String get snoozeLaterToday => 'Plus tard aujourd’hui';

  @override
  String get snoozeThisEvening => 'Ce soir';

  @override
  String get snoozeTomorrow => 'Demain';

  @override
  String get snoozeThisWeekend => 'Ce week-end';

  @override
  String get snoozeNextWeek => 'La semaine prochaine';

  @override
  String get snoozePickDateTime => 'Choisir la date et l’heure…';

  @override
  String get snoozeMenu => 'Mettre en attente…';

  @override
  String get snoozeWakeNow => 'Réactiver maintenant';

  @override
  String get snoozeChangeTimeMenu => 'Modifier l’heure de mise en attente…';

  @override
  String get snoozeChangeTime => 'Modifier l’heure';

  @override
  String get snoozeNoTime => 'Aucune heure définie';

  @override
  String get snoozeFooter =>
      'Les messages mis en attente reviennent dans la boîte de réception, non lus, à l’heure prévue.';

  @override
  String get snoozeEmptyTitle => 'Aucun message en attente';

  @override
  String get snoozeEmptyText =>
      'Mettez un message en attente pour qu’il revienne dans la boîte de réception quand vous en avez besoin.';

  @override
  String get appLockUnlock => 'Déverrouiller';

  @override
  String get appLockFailed => 'Loupe n’a pas pu confirmer votre identité.';

  @override
  String get appLockLockedOut => 'Trop de tentatives. Réessayez plus tard.';

  @override
  String get appLockPromptError => 'Impossible d’afficher la demande. Réessayez.';

  @override
  String get appLockNoScreenLock => 'Ce téléphone n’a pas de verrouillage de l’écran.';

  @override
  String get appLockUnlockPromptTitle => 'Déverrouiller Loupe';

  @override
  String get appLockUnlockPromptReason => 'Confirmez votre identité pour voir vos e-mails.';

  @override
  String get appLockTurnOnPromptTitle => 'Activer le verrouillage de l’application';

  @override
  String get appLockTurnOnPromptReason => 'Confirmez votre identité pour activer le verrouillage de l’application.';

  @override
  String get appLockScreenLockRemoved =>
      'Le verrouillage de l’application est désactivé : ce téléphone n’a plus de verrouillage de l’écran. Configurez-en un pour réactiver le verrouillage de l’application.';

  @override
  String get appLockAfterImmediately => 'Immédiatement';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      many: '$count de minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      many: '$count d’heures',
      one: '$count heure',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Chiffré';

  @override
  String get openpgpEncryptedInPart => 'Partiellement chiffré';

  @override
  String get openpgpEncryptedLocked => 'Chiffré · verrouillé';

  @override
  String get openpgpEncryptedNoKey => 'Chiffré · aucune clé';

  @override
  String get openpgpEncryptedDamaged => 'Chiffré · endommagé';

  @override
  String get openpgpEncryptedUnsupported => 'Chiffré · non pris en charge';

  @override
  String get openpgpUnknownSigner => 'inconnu';

  @override
  String get openpgpUnknownKey => 'Clé inconnue';

  @override
  String get openpgpSignatureInvalid => 'Signature non valide';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signé par $name, et non par l’expéditeur';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Partiellement signé par $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signé par $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Signé avec une clé rejetée';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signé par $name · clé non acceptée';
  }

  @override
  String get openpgpUnlock => 'Déverrouiller';

  @override
  String get openpgpCantDecrypt => 'Impossible de déchiffrer ce message';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Chiffré avec OpenPGP';

  @override
  String get openpgpEncryption => 'Chiffrement';

  @override
  String get openpgpDecryptedHere => 'Déchiffré sur cet appareil';

  @override
  String get openpgpNotDecrypted => 'Non déchiffré';

  @override
  String get openpgpKeyLocked => 'Votre clé est verrouillée.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clés : $keys',
      one: '$count clé : $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Objet protégé';

  @override
  String get openpgpUnlockKey => 'Déverrouiller la clé';

  @override
  String get openpgpSignature => 'Signature';

  @override
  String get openpgpFingerprint => 'Empreinte';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID de clé $id';
  }

  @override
  String get openpgpSigned => 'Signé';

  @override
  String get openpgpProblem => 'Problème';

  @override
  String get openpgpAcceptance => 'Acceptation';

  @override
  String get openpgpChangeAcceptance => 'Modifier l’acceptation…';

  @override
  String get openpgpCheckedFooter => 'Vérifié sur cet appareil avec OpenPGP, compatible avec Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Votre clé est verrouillée. Déverrouillez-la avec sa phrase de passe pour lire ce message.';

  @override
  String get openpgpSummaryNoSecretKey => 'Il a été chiffré pour une clé qui n’est pas sur cet appareil.';

  @override
  String get openpgpSummaryDamaged => 'Les données chiffrées sont endommagées ou ont été modifiées en chemin.';

  @override
  String get openpgpSummaryUnsupported => 'Il utilise un algorithme que Loupe ne prend pas en charge.';

  @override
  String get openpgpSummaryEncrypted => 'Seuls vous et les autres destinataires pouvez le lire.';

  @override
  String get openpgpSummaryNotSigned => 'Il n’est pas signé : l’expéditeur n’est donc pas confirmé.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Il est signé, mais avec une clé que vous n’avez pas : la signature ne peut donc pas être vérifiée.';

  @override
  String get openpgpSummaryBadSignature => 'La signature ne correspond pas : le message a peut-être été modifié.';

  @override
  String get openpgpSummaryMismatch =>
      'La signature est valide, mais la clé appartient à une autre adresse que celle de l’expéditeur.';

  @override
  String get openpgpSummaryPartial =>
      'Seule une partie du message est signée. Le texte en dehors de la signature (le pied de page d’une liste de diffusion, par exemple) est affiché sous la ligne « Unsigned content », et les autres parties du message, comme les pièces jointes, ne sont pas couvertes non plus.';

  @override
  String get openpgpSummaryOwnKey => 'Signé avec votre propre clé.';

  @override
  String get openpgpSummaryVerified => 'La signature est valide et vous avez vérifié l’empreinte de la clé.';

  @override
  String get openpgpSummaryUnverified =>
      'La signature est valide. Vous avez accepté la clé sans vérifier son empreinte.';

  @override
  String get openpgpSummaryRejected => 'La signature est valide, mais vous avez rejeté cette clé.';

  @override
  String get openpgpSummaryUndecided =>
      'La signature est valide, mais vous n’avez pas encore accepté cette clé. Comparez son empreinte avec l’expéditeur.';

  @override
  String get openpgpAcceptanceRejected => 'Rejetée';

  @override
  String get openpgpAcceptanceUndecided => 'Non acceptée';

  @override
  String get openpgpAcceptanceUnverified => 'Acceptée';

  @override
  String get openpgpAcceptanceVerified => 'Acceptée et vérifiée';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Accepter la clé de $name ?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Empreinte $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Oui, j’ai vérifié l’empreinte';

  @override
  String get openpgpAcceptUnverified => 'Oui, sans vérifier';

  @override
  String get openpgpAcceptLater => 'Pas encore';

  @override
  String get openpgpRejectKey => 'Rejeter cette clé';

  @override
  String get openpgpNoSubject => '(sans objet)';

  @override
  String get openpgpEncryptionTitle => 'Chiffrement de bout en bout';

  @override
  String get openpgpMyKeys => 'Mes clés OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Avec une clé, vous pouvez lire les e-mails chiffrés, et signer et chiffrer les vôtres. Vous utilisez Thunderbird ? Exportez-y votre clé (Paramètres des comptes › Chiffrement de bout en bout › Exporter la clé secrète) et importez-la ici.';

  @override
  String get openpgpAddKey => 'Ajouter une clé…';

  @override
  String get openpgpAddresses => 'Adresses';

  @override
  String get openpgpAddressesFooter => 'La clé utilisée par chaque adresse, et quand elle chiffre et signe.';

  @override
  String get openpgpCorrespondentsKeys => 'Clés OpenPGP des correspondants';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Acceptez une clé dès que vous êtes sûr qu’elle appartient à son propriétaire ; comparez l’empreinte avec cette personne pour la marquer comme vérifiée.';

  @override
  String get openpgpImportPublicKey => 'Importer une clé publique…';

  @override
  String get openpgpCollected => 'Collectées via Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Des clés arrivées avec des messages. Loupe peut chiffrer pour elles lorsque les deux parties le demandent.';

  @override
  String get openpgpOnThisDevice => 'Sur cet appareil';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Les messages chiffrés masquent leur objet. Loupe conserve l’objet de chaque message que vous ouvrez dans sa base de données chiffrée sur cet appareil, pour que la liste, la recherche et les notifications l’affichent. En arrière-plan, Loupe peut aussi déchiffrer l’objet des nouveaux messages avec les clés sans phrase de passe ; elle télécharge pour cela chaque message (jusqu’à 1 Mo).';

  @override
  String get openpgpDecryptSubjects => 'Déchiffrer les objets en arrière-plan';

  @override
  String get openpgpIndexFooter =>
      'La recherche trouve les messages chiffrés par leur expéditeur, leurs destinataires et leur objet. Avec cette option, Loupe ajoute aussi le texte de chaque message chiffré qu’elle déchiffre à l’index de recherche de sa base de données chiffrée sur cet appareil, pour que la recherche le trouve aussi par son texte. La désactiver retire ce texte de l’index.';

  @override
  String get openpgpIndexDecrypted => 'Indexer les messages déchiffrés pour la recherche';

  @override
  String get openpgpPassphrases => 'Phrases de passe';

  @override
  String get openpgpPassphrasesFooter =>
      'Les clés OpenPGP et les certificats S/MIME que vous protégez par une phrase de passe sont déverrouillés au besoin. Sans « Mémoriser », ils sont de nouveau verrouillés deux minutes après chaque utilisation.';

  @override
  String get openpgpRememberPassphrases => 'Mémoriser les phrases de passe';

  @override
  String get openpgpRememberPassphrasesDetail => 'Jusqu’à la fermeture de Loupe';

  @override
  String get openpgpLockKeysNow => 'Verrouiller les clés maintenant';

  @override
  String get openpgpKeysLocked => 'Clés verrouillées.';

  @override
  String get openpgpKeyStateRevoked => 'révoquée';

  @override
  String get openpgpKeyStateExpired => 'expirée';

  @override
  String get openpgpKeyStateNeverExpires => 'n’expire jamais';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'expire le $date';
  }

  @override
  String get openpgpNoKey => 'Aucune clé';

  @override
  String get openpgpAlwaysEncrypt => 'Toujours chiffrer';

  @override
  String get openpgpAddKeyTitle => 'Ajouter une clé OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importez la clé que vous utilisez dans Thunderbird, ou créez-en une nouvelle.';

  @override
  String get openpgpImportFromClipboard => 'Importer depuis le presse-papiers';

  @override
  String get openpgpImportFromFile => 'Importer depuis un fichier';

  @override
  String get openpgpGenerateNewKey => 'Générer une nouvelle clé';

  @override
  String get openpgpImportPublicKeyTitle => 'Importer une clé publique';

  @override
  String get openpgpFromClipboard => 'Depuis le presse-papiers';

  @override
  String get openpgpFromFile => 'Depuis un fichier';

  @override
  String get openpgpClipboardEmpty => 'Le presse-papiers est vide. Copiez d’abord la clé.';

  @override
  String get openpgpKey => 'Clé';

  @override
  String get openpgpValidityRevoked => 'Révoquée';

  @override
  String openpgpValidityExpired(String date) {
    return 'Expirée le $date';
  }

  @override
  String get openpgpNeverExpires => 'N’expire jamais';

  @override
  String openpgpValidUntil(String date) {
    return 'Valide jusqu’au $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Empreinte copiée.';

  @override
  String get openpgpAlgorithm => 'Algorithme';

  @override
  String get openpgpCreated => 'Création';

  @override
  String get openpgpValidity => 'Validité';

  @override
  String get openpgpProtection => 'Protection';

  @override
  String get openpgpProtectionPassphrase => 'Phrase de passe';

  @override
  String get openpgpProtectionKeychain => 'Stockage sécurisé uniquement';

  @override
  String get openpgpKeyDetailsFooter =>
      'Partagez votre clé publique pour que d’autres puissent vous envoyer des messages chiffrés. La sauvegarde est votre clé secrète, protégée par sa phrase de passe si elle en a une : gardez-la privée.';

  @override
  String get openpgpSharePublicKey => 'Partager la clé publique';

  @override
  String get openpgpCopyPublicKey => 'Copier la clé publique';

  @override
  String get openpgpPublicKeyCopied => 'Clé publique copiée.';

  @override
  String get openpgpBackUpSecretKey => 'Sauvegarder la clé secrète';

  @override
  String get openpgpDeleteKey => 'Supprimer la clé';

  @override
  String get openpgpRemoveKey => 'Retirer la clé';

  @override
  String get openpgpBackUpTitle => 'Sauvegarder la clé secrète ?';

  @override
  String get openpgpBackUpProtected =>
      'La sauvegarde est protégée par la phrase de passe de votre clé. Quiconque possède les deux peut lire vos e-mails.';

  @override
  String get openpgpBackUpUnprotected =>
      'Cette clé n’a pas de phrase de passe : quiconque possède la sauvegarde peut lire vos e-mails et signer en votre nom.';

  @override
  String get openpgpBackUp => 'Sauvegarder';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Supprimer votre clé $name ?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Retirer la clé de $name ?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Les e-mails chiffrés pour cette clé ne pourront plus être lus sur cet appareil, sauf si vous l’importez de nouveau.';

  @override
  String get openpgpRemoveKeyMessage => 'Vous pourrez l’importer de nouveau plus tard.';

  @override
  String get openpgpKeyHeader => 'Clé OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Ajoutez une clé dans Chiffrement de bout en bout pour chiffrer et signer les e-mails envoyés depuis cette adresse.';

  @override
  String get openpgpGenerateAKey => 'Générer une clé…';

  @override
  String get openpgpSending => 'Envoi';

  @override
  String get openpgpSendingFooter =>
      'Le chiffrement automatique s’active lorsque chaque destinataire a une clé acceptée ou un certificat approuvé, ou lorsque Autocrypt indique que les deux parties le souhaitent. Les e-mails chiffrés sont toujours signés.';

  @override
  String get openpgpEncryptAutomatically => 'Chiffrer automatiquement';

  @override
  String get openpgpAlwaysEncryptDetail => 'Refuse d’envoyer si un destinataire n’a pas de clé';

  @override
  String get openpgpSignUnencrypted => 'Signer les e-mails non chiffrés';

  @override
  String get openpgpAttachPublicKey => 'Joindre ma clé publique';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt envoie votre clé publique avec chaque message, pour que d’autres applications puissent vous écrire de façon chiffrée sans aucune configuration.';

  @override
  String get openpgpSendMyKey => 'Envoyer ma clé avec les e-mails';

  @override
  String get openpgpPreferEncryption => 'Préférer le chiffrement';

  @override
  String get openpgpPreferEncryptionDetail => 'Demander aux autres de chiffrer quand ils le peuvent';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      many: '$count d’ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Les phrases de passe ne correspondent pas.';

  @override
  String openpgpKeyReady(String id) {
    return 'Votre clé $id est prête.';
  }

  @override
  String get openpgpNewKey => 'Nouvelle clé';

  @override
  String get openpgpNewKeyFor => 'Pour';

  @override
  String get openpgpYourName => 'Votre nom';

  @override
  String get openpgpAddress => 'Adresse';

  @override
  String get openpgpPassphrase => 'Phrase de passe';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Facultatif. Sans phrase de passe, seul le stockage sécurisé de votre téléphone protège la clé, et Loupe ne vous demande jamais rien. Avec une phrase de passe, Loupe vous la demande quand la clé est nécessaire.';

  @override
  String get openpgpRepeatPassphrase => 'Confirmer';

  @override
  String get openpgpExpires => 'Expiration';

  @override
  String get openpgpExpiresFooter =>
      'Vous pourrez créer une nouvelle clé avant son expiration. Thunderbird utilise aussi une durée de trois ans.';

  @override
  String get openpgpGenerateKey => 'Générer la clé';

  @override
  String get openpgpKeyFor => 'Clé pour';

  @override
  String get openpgpCantEncrypt => 'Chiffrement impossible';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Il n’y a aucune clé OpenPGP pour $names, et cette adresse chiffre toujours. Retirez ce destinataire, ou importez sa clé dans Paramètres › Chiffrement de bout en bout.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Il n’y a aucun certificat S/MIME valide pour $names, et cette adresse chiffre toujours. Retirez ce destinataire, ou importez son certificat dans Paramètres › Chiffrement de bout en bout.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Il n’y a aucune clé OpenPGP pour $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Il n’y a aucun certificat S/MIME valide pour $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Envoyer sans chiffrement';

  @override
  String get openpgpCantSign => 'Signature impossible';

  @override
  String get openpgpCantSignMessage =>
      'La clé privée de votre certificat S/MIME n’est pas sur cet appareil. Importez de nouveau le certificat (un fichier .p12 ou .pfx) dans Paramètres › Chiffrement de bout en bout.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Aucune clé pour $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Aucun certificat pour $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Clés issues d’Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Tout le monde a une clé';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Tout le monde a un certificat';

  @override
  String get openpgpComposeEncrypt => 'Chiffrer';

  @override
  String get openpgpComposeSign => 'Signer';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, changer';
  }

  @override
  String get openpgpNoKeyFound => 'Aucune clé OpenPGP trouvée.';

  @override
  String get openpgpImportSecretKeyTitle => 'Importer une clé secrète ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Cette pièce jointe contient une clé secrète ($names). Importez-la comme votre propre clé uniquement si vous l’avez exportée vous-même, depuis Thunderbird par exemple.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importer comme ma clé';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'votre clé $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importer $count clés ($names) ?',
      one: 'Importer $count clé ($names) ?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importer et accepter';

  @override
  String get openpgpImportDecideLater => 'Importer, décider plus tard';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'la clé de $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importé : $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clés OpenPGP sont jointes.',
      one: '$count clé OpenPGP est jointe.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importer';

  @override
  String get openpgpUnlockKeyTitle => 'Déverrouiller la clé OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Saisissez la phrase de passe de la clé de $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Cette phrase de passe est incorrecte. Réessayez.';

  @override
  String get openpgpExplainLocked => 'Ce message est chiffré. Déverrouillez votre clé OpenPGP pour le lire.';

  @override
  String get openpgpExplainNoKey =>
      'Ce message est chiffré, mais pour aucune des clés OpenPGP de cet appareil. Si vous le lisez dans Thunderbird, importez la clé que vous y utilisez : Paramètres › Chiffrement de bout en bout.';

  @override
  String get openpgpExplainDamaged =>
      'Ce message chiffré est endommagé : il ne peut pas être déchiffré en toute sécurité.';

  @override
  String get openpgpExplainUnsupported => 'Ce message utilise un chiffrement que Loupe ne sait pas encore lire.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ce message est chiffré avec S/MIME, mais pour aucun des certificats de cet appareil. Importez votre certificat (un fichier .p12 ou .pfx) dans Paramètres › Chiffrement de bout en bout.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ce message est chiffré. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Déverrouillez votre certificat S/MIME pour le lire.';

  @override
  String get openpgpAttachmentGone => 'Cette pièce jointe n’est plus disponible.';

  @override
  String get smimeEncrypted => 'Chiffré (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Chiffré (S/MIME) · aucun certificat';

  @override
  String get smimeEncryptedDamaged => 'Chiffré (S/MIME) · endommagé';

  @override
  String get smimeEncryptedUnsupported => 'Chiffré (S/MIME) · non pris en charge';

  @override
  String get smimeEncryptedLocked => 'Chiffré (S/MIME) · verrouillé';

  @override
  String get smimeUnknownSigner => 'inconnu';

  @override
  String get smimeSignatureModified => 'Signature non valide : message modifié';

  @override
  String get smimeSignatureWeak => 'Signature peu sûre : algorithme obsolète';

  @override
  String get smimeSignatureUncheckable => 'Impossible de vérifier la signature';

  @override
  String get smimeSignedCertificateMissing => 'Signé · certificat manquant';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signé par $name · certificat révoqué';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signé par $name · à une autre date';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signé par $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signé par $name · certificat non valide';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signé par $name · non approuvé';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signé par $name · certificat expiré';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signé par $name · certificat pas encore valide';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signé par $name · certificat non destiné aux e-mails';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signé par $name, et non par l’expéditeur';
  }

  @override
  String get smimeCantDecrypt => 'Impossible de déchiffrer ce message';

  @override
  String get smimeEncryptedWithSmime => 'Chiffré avec S/MIME';

  @override
  String get smimeEncryption => 'Chiffrement';

  @override
  String get smimeDecryptedHere => 'Déchiffré sur cet appareil';

  @override
  String get smimeNotDecrypted => 'Non déchiffré';

  @override
  String get smimeAuthenticated => 'authentifié';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pour $count certificats',
      many: 'pour $count de certificats',
      one: 'pour $count certificat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signature';

  @override
  String get smimeIssuedBy => 'Émis par';

  @override
  String get smimeValid => 'Validité';

  @override
  String smimeValidRange(String from, String to) {
    return 'du $from au $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Empreinte SHA-256';

  @override
  String get smimeSigned => 'Signé';

  @override
  String get smimeProblem => 'Problème';

  @override
  String get smimeCheckingRevocation => 'Vérification de la révocation…';

  @override
  String get smimeNotRevoked => 'Non révoqué';

  @override
  String get smimeRevoked => 'Révoqué';

  @override
  String get smimeRevocationUnknown => 'Révocation inconnue';

  @override
  String smimeRevokedSince(String date) {
    return 'Depuis le $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Autorité interrogée (sa liste de révocation), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Autorité interrogée (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Approuver « $name »…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Approuver ce certificat…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Vérifié sur cet appareil avec S/MIME, compatible avec Outlook et Thunderbird ; révocation vérifiée auprès de l’autorité de certification.';

  @override
  String get smimeCheckedFooter =>
      'Vérifié sur cet appareil avec S/MIME, compatible avec Outlook et Thunderbird. La révocation n’est pas vérifiée (Paramètres › Chiffrement de bout en bout).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Approuver $name pour les e-mails ?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Approuver le certificat de $name ?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Tous les certificats émis par cette autorité seront approuvés, comme ceux de l’autorité de certification de votre entreprise. Comparez d’abord l’empreinte avec son propriétaire :\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Comparez d’abord l’empreinte avec son propriétaire :\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Approuver';

  @override
  String get smimeSummaryNoKey => 'Il a été chiffré pour un certificat qui n’est pas sur cet appareil.';

  @override
  String get smimeSummaryDamaged => 'Les données chiffrées sont endommagées ou ont été modifiées en chemin.';

  @override
  String get smimeSummaryUnsupported => 'Il utilise un algorithme que Loupe ne prend pas en charge.';

  @override
  String get smimeSummaryLocked => 'Votre certificat S/MIME est verrouillé.';

  @override
  String get smimeSummaryEncrypted => 'Seuls vous et les autres destinataires pouvez le lire.';

  @override
  String get smimeSummaryNotSigned => 'Il n’est pas signé : l’expéditeur n’est donc pas confirmé.';

  @override
  String get smimeSummaryModified => 'La signature ne correspond pas : le message a été modifié après sa signature.';

  @override
  String get smimeSummaryUncheckable => 'La signature ne peut pas être vérifiée.';

  @override
  String get smimeSummaryNoCertificate =>
      'Le certificat du signataire ne figure pas dans le message : il ne peut donc pas être vérifié.';

  @override
  String get smimeSummaryRevoked =>
      'L’autorité de certification a révoqué le certificat du signataire : la signature n’est pas fiable.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'L’autorité de certification a révoqué le certificat du signataire ($reason) : la signature n’est pas fiable.';
  }

  @override
  String get smimeDateMismatch =>
      'Il a été signé plus d’une heure avant ou après la date du message : il peut s’agir d’un ancien message renvoyé.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'La signature est valide, et $issuer garantit que le certificat appartient à l’expéditeur.';
  }

  @override
  String get smimeProblemInvalidChain => 'Le certificat ou l’un de ses émetteurs n’est pas valide.';

  @override
  String get smimeProblemUntrusted => 'Le certificat provient d’une autorité que Loupe n’approuve pas.';

  @override
  String get smimeProblemExpired => 'Le certificat avait expiré.';

  @override
  String get smimeProblemNotYetValid => 'Le certificat n’était pas encore valide.';

  @override
  String get smimeProblemWrongUsage => 'Le certificat n’est pas destiné aux e-mails.';

  @override
  String get smimeProblemWrongAddress => 'Le certificat appartient à une autre adresse que celle de l’expéditeur.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Approuvé · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Non approuvé · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Expiré le $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Valide à partir du $date';
  }

  @override
  String get smimeTrustInvalid => 'Non valide';

  @override
  String get smimeTrustNotForMail => 'Non destiné aux e-mails';

  @override
  String get smimeTrustAnotherAddress => 'Autre adresse';

  @override
  String get smimeMyCertificates => 'Mes certificats S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Pour S/MIME, tel qu’utilisé par Outlook et de nombreuses entreprises. Importez votre certificat avec sa clé privée (un fichier .p12 ou .pfx), exporté depuis Outlook, Windows, macOS ou Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Pour S/MIME, tel qu’utilisé par Outlook et de nombreuses entreprises. Importez votre certificat avec sa clé privée (un fichier .p12 ou .pfx), exporté depuis Outlook, Windows, macOS ou Thunderbird, ou utilisez-en un que votre entreprise ou vous-même avez installé sur cet appareil.';

  @override
  String get smimeCertificateExpired => 'expiré';

  @override
  String smimeCertificateUntil(String date) {
    return 'jusqu’au $date';
  }

  @override
  String get smimeCertificateOnDevice => 'sur cet appareil';

  @override
  String get smimeImportCertificateEllipsis => 'Importer un certificat…';

  @override
  String get smimeUseDeviceCertificate => 'Utiliser un certificat de cet appareil…';

  @override
  String get smimeCorrespondentsCertificates => 'Certificats des correspondants';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Collectés depuis les e-mails signés, comme le font Outlook et Thunderbird. Les e-mails ne sont chiffrés que pour des certificats approuvés : Loupe approuve les autorités que Mozilla approuve pour les e-mails, ainsi que celles que vous ajoutez.';

  @override
  String get smimeRevocation => 'Révocation';

  @override
  String get smimeRevocationFooter =>
      'Quand vous ouvrez un e-mail signé, Loupe demande à l’autorité qui a émis le certificat du signataire s’il a été révoqué (via son répondeur OCSP ou sa liste de révocation). L’autorité peut alors savoir quand quelqu’un lit, depuis votre adresse IP, un e-mail signé avec ce certificat. Les réponses sont conservées sur cet appareil jusqu’à leur expiration. Un certificat révoqué apparaît comme « Révoqué » dans l’en-tête du message.';

  @override
  String get smimeCheckRevocation => 'Vérifier la révocation des certificats en ligne';

  @override
  String get smimeTrustedAuthorities => 'Autorités approuvées';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Approuvées par vous, en plus des $count que Mozilla approuve pour les e-mails.',
      one: 'Approuvées par vous, en plus de l’autorité ($count) que Mozilla approuve pour les e-mails.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autorité de certification';

  @override
  String get smimeImportACertificate => 'Importer un certificat';

  @override
  String get smimeImportContactMessage =>
      'Le certificat d’un correspondant (.cer, .crt, .pem) ou celui d’une autorité de certification.';

  @override
  String get smimeFromClipboard => 'Depuis le presse-papiers';

  @override
  String get smimeFromFile => 'Depuis un fichier';

  @override
  String get smimeClipboardEmpty => 'Le presse-papiers est vide. Copiez d’abord le certificat.';

  @override
  String get smimeCertificate => 'Certificat';

  @override
  String get smimeOnDeviceFooter =>
      'Sa clé privée reste dans le stockage des identifiants d’Android, où vous ou votre entreprise l’avez installée : Loupe demande à Android de signer et de déchiffrer avec. Les e-mails signés le sont au moment de l’envoi.';

  @override
  String get smimeAddresses => 'Adresses';

  @override
  String get smimeUsage => 'Utilisation';

  @override
  String get smimeUsageNone => 'Rien que Loupe utilise';

  @override
  String get smimeUsageSigning => 'Signature';

  @override
  String get smimeUsageEncryption => 'Chiffrement';

  @override
  String get smimeUsageCertificates => 'Certificats';

  @override
  String get smimeAlgorithm => 'Algorithme';

  @override
  String get smimeSerialNumber => 'Numéro de série';

  @override
  String get smimeFingerprintCopied => 'Empreinte copiée.';

  @override
  String get smimeSha1Thumbprint => 'Empreinte numérique SHA-1';

  @override
  String get smimePrivateKey => 'Clé privée';

  @override
  String get smimeKeyOnDevice => 'Sur cet appareil';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Dans Loupe, avec une phrase de passe';

  @override
  String get smimeKeyInLoupe => 'Dans Loupe';

  @override
  String get smimeSource => 'Provenance';

  @override
  String get smimeSourceSignedMail => 'E-mail signé';

  @override
  String get smimeSourceImported => 'Importé';

  @override
  String get smimeTrustHeader => 'Confiance';

  @override
  String get smimeTrustedRoot => 'Racine approuvée';

  @override
  String get smimeIssuer => 'Émetteur';

  @override
  String smimeTrustNamed(String name) {
    return 'Approuver « $name »';
  }

  @override
  String get smimeTrustThisAuthority => 'Approuver cette autorité';

  @override
  String get smimeTrustThisCertificate => 'Approuver ce certificat';

  @override
  String get smimeStopTrusting => 'Ne plus approuver';

  @override
  String get smimePassphrase => 'Phrase de passe';

  @override
  String get smimePassphraseFooter =>
      'Facultatif. Avec une phrase de passe, la clé privée est en plus chiffrée sur cet appareil (Argon2id et AES-256), et Loupe la demande pour signer et déchiffrer ; « Mémoriser les phrases de passe » indique pendant combien de temps. Les e-mails que vous envoyez sont signés au moment de l’envoi ; les tâches en arrière-plan ne peuvent pas utiliser la clé.';

  @override
  String get smimeChangePassphrase => 'Modifier la phrase de passe…';

  @override
  String get smimeSetPassphraseEllipsis => 'Définir une phrase de passe…';

  @override
  String get smimeRemovePassphrase => 'Supprimer la phrase de passe';

  @override
  String get smimeShareCertificate => 'Partager le certificat';

  @override
  String get smimeDeleteCertificate => 'Supprimer le certificat';

  @override
  String get smimeRemoveCertificate => 'Retirer le certificat';

  @override
  String get smimePassphraseChanged => 'Phrase de passe modifiée.';

  @override
  String get smimePassphraseSet => 'Phrase de passe définie.';

  @override
  String get smimeRemovePassphraseTitle => 'Supprimer la phrase de passe ?';

  @override
  String get smimeRemovePassphraseMessage =>
      'La clé privée n’est alors protégée que par le stockage sécurisé, comme sans phrase de passe : Loupe ne la demande plus, et les tâches en arrière-plan peuvent l’utiliser.';

  @override
  String get smimePassphraseRemoved => 'Phrase de passe supprimée.';

  @override
  String smimeTrustTitle(String name) {
    return 'Approuver $name ?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Tous les certificats qu’elle émet seront approuvés pour les e-mails. Comparez d’abord l’empreinte avec son propriétaire :\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Supprimer votre certificat $name ?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Retirer le certificat de $name ?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe cesse de l’utiliser : les e-mails chiffrés pour ce certificat ne pourront plus être lus dans Loupe. Le certificat reste sur cet appareil (Paramètres › Sécurité › Chiffrement et identifiants).';

  @override
  String get smimeDeleteOwnMessage =>
      'Sa clé privée est supprimée de cet appareil : les e-mails chiffrés pour ce certificat ne pourront plus y être lus, sauf si vous l’importez de nouveau.';

  @override
  String get smimeRemoveContactMessage => 'Il reviendra avec le prochain message signé de cette personne.';

  @override
  String get smimeAddressImportFooter =>
      'Importez un certificat pour cette adresse afin de signer et chiffrer avec S/MIME, comme le fait Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importer un certificat…';

  @override
  String get smimePreferFooter =>
      'Quand les deux peuvent protéger un message, la norme préférée est utilisée, sauf si seule l’autre dispose d’une clé ou d’un certificat pour chaque destinataire.';

  @override
  String get smimePreferSmime => 'Préférer S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Plutôt qu’OpenPGP';

  @override
  String get smimeCertificatePassword => 'Mot de passe du certificat';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Saisissez le mot de passe utilisé lors de l’exportation du fichier de certificat.';

  @override
  String get smimeImport => 'Importer';

  @override
  String get smimeWrongPassword => 'Ce mot de passe est incorrect. Réessayez.';

  @override
  String get smimeNoCertificateFound => 'Aucun certificat trouvé.';

  @override
  String smimeCertificateOf(String name) {
    return 'le certificat de $name';
  }

  @override
  String get smimeNothingNew => 'Rien de nouveau à importer.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importé : $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count autorités approuvées importées.',
      one: '$count autorité approuvée importée.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importé : $certificates et $count autorités approuvées.',
      one: 'Importé : $certificates et $count autorité approuvée.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Ce fichier ne contient pas de clé privée. Exportez votre certificat avec sa clé privée.';

  @override
  String get smimeImportAsYoursTitle => 'Importer comme votre certificat ?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Cette pièce jointe contient un certificat avec sa clé privée : $names. Ne l’importez que si vous l’avez exporté vous-même, depuis Outlook ou Thunderbird par exemple.';
  }

  @override
  String get smimeImportAsMine => 'Importer comme mon certificat';

  @override
  String smimeImportedOwn(String names) {
    return 'Votre certificat $names a été importé.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Votre certificat $name ($addresses) a été ajouté depuis cet appareil.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Approuver « $name » pour les e-mails ?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe ne connaît pas cette autorité de certification (peut-être celle d’une entreprise). Approuvez-la pour vérifier les certificats qu’elle émet. Comparez d’abord son empreinte avec votre service informatique :\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certificats sont joints.',
      one: '$count certificat est joint.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importer le certificat';

  @override
  String get smimeUnlockTitle => 'Déverrouiller le certificat S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Saisissez la phrase de passe du certificat de $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Cette phrase de passe est incorrecte. Réessayez.';

  @override
  String get smimeUnlock => 'Déverrouiller';

  @override
  String get smimeEnterAPassphrase => 'Saisissez une phrase de passe.';

  @override
  String get smimePassphrasesDiffer => 'Les deux phrases de passe sont différentes.';

  @override
  String get smimeSetPassphraseTitle => 'Définir une phrase de passe';

  @override
  String get smimeSetPassphraseText =>
      'Loupe la demandera pour signer et déchiffrer. Si vous l’oubliez, importez de nouveau le certificat depuis son fichier .p12.';

  @override
  String get smimePassphraseAgain => 'Confirmer';

  @override
  String get smimeSetPassphraseButton => 'Définir';

  @override
  String get smimeLockedOpenAgain =>
      'Votre certificat S/MIME est verrouillé. Rouvrez le message pour le déverrouiller.';

  @override
  String get smimeDeviceHasNoCertificates => 'Cet appareil ne propose pas ses certificats.';

  @override
  String get smimeCantReadCertificate => 'Loupe ne peut pas lire ce certificat.';

  @override
  String get smimeCertificateNotForMail =>
      'Ce certificat n’est pas destiné aux e-mails : il n’a pas d’adresse e-mail, ou n’est pas prévu pour signer ou chiffrer.';

  @override
  String get smimeDeviceCertificateGone =>
      'Le certificat n’est plus sur cet appareil, ou Loupe n’a plus le droit de l’utiliser. Choisissez-le de nouveau dans Paramètres › Chiffrement de bout en bout.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Le certificat de cet appareil ne peut être utilisé que lorsque Loupe est ouverte.';

  @override
  String get smimeDeviceKeyDamaged => 'La clé chiffrée est endommagée.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Le certificat de cet appareil ne peut pas faire cela : $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'non pris en charge';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Le certificat de cet appareil a échoué : $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'L’adresse de l’autorité n’est pas une adresse web.';

  @override
  String get smimeAuthorityTimeout => 'L’autorité de certification n’a pas répondu à temps.';

  @override
  String get smimeAuthorityUnreachable => 'Impossible de joindre l’autorité de certification.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'L’autorité de certification a répondu $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'La réponse de l’autorité de certification est trop volumineuse.';

  @override
  String get smimeRevocationNotChecked =>
      'Non vérifié : seuls les certificats d’une autorité approuvée par Loupe sont vérifiés.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Comme le téléphone';

  @override
  String get settingsLanguageFooter =>
      'Loupe utilise la langue de votre téléphone si elle la propose, et l’anglais sinon. La langue choisie ici ne s’applique qu’à Loupe, notifications comprises.';

  @override
  String get settingsAccountsHeader => 'Comptes';

  @override
  String get settingsAddAccount => 'Ajouter un compte';

  @override
  String get settingsMailHeader => 'Messagerie';

  @override
  String get settingsSwipeActions => 'Actions de balayage';

  @override
  String get settingsSwipeLeft => 'Balayer vers la gauche';

  @override
  String get settingsSwipeLeftFooter =>
      'Un balayage complet exécute cette action. « Ajouter un drapeau » et « Plus » sont toujours à portée d’un court balayage.';

  @override
  String get settingsSwipeRight => 'Balayer vers la droite';

  @override
  String get settingsSwipeRightFooter => 'Un balayage complet exécute cette action.';

  @override
  String get settingsSwipeToggleRead => 'Marquer comme lu / non lu';

  @override
  String get settingsSwipeTrash => 'Mettre à la corbeille';

  @override
  String get settingsSwipeMove => 'Déplacer le message';

  @override
  String get settingsSwipeSnooze => 'Mettre en attente';

  @override
  String get settingsThreaded => 'Regrouper par conversation';

  @override
  String get settingsUndoSendDelay => 'Délai d’annulation de l’envoi';

  @override
  String get settingsUndoSendDelayFooter =>
      'Les messages envoyés patientent pendant ce délai, pour que vous puissiez les rattraper.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds secondes',
      many: '$seconds de secondes',
      one: '$seconds seconde',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Apparence';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeSystem => 'Automatique';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsDensity => 'Liste des messages';

  @override
  String get settingsDensityComfortable => 'Confortable';

  @override
  String get settingsDensityCompact => 'Compacte';

  @override
  String get settingsReadingHeader => 'Lecture';

  @override
  String get settingsReadingFooter =>
      'Les images distantes peuvent indiquer aux expéditeurs quand et où vous avez ouvert un message.';

  @override
  String get settingsDefaultView => 'Affichage par défaut';

  @override
  String get settingsDefaultViewFooter =>
      'Vous pouvez changer l’affichage de n’importe quel message avec le bouton Aa.';

  @override
  String get settingsViewReadable => 'Lisible';

  @override
  String get settingsViewReadableDetail => 'Épuré, lisible, suit le mode sombre';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Exactement tel que l’expéditeur l’a conçu';

  @override
  String get settingsViewPlain => 'Texte brut';

  @override
  String get settingsViewPlainDetail => 'Juste les mots';

  @override
  String get settingsPlainTextFont => 'Police du texte brut';

  @override
  String get settingsFontSans => 'Sans empattement';

  @override
  String get settingsFontMono => 'Chasse fixe';

  @override
  String get settingsFontMonoDetail => 'Garde l’art ASCII et les tableaux alignés';

  @override
  String get settingsTechnicalLists => 'Listes techniques';

  @override
  String get settingsLoadRemoteImages => 'Charger les images distantes';

  @override
  String get settingsOpenLinksDirectly => 'Ouvrir les liens directement';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Contourner les traqueurs de clics quand la destination est connue';

  @override
  String get settingsSecurityHeader => 'Sécurité';

  @override
  String get settingsAppLock => 'Verrouillage de l’application';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe le demande au démarrage, et quand vous revenez après une absence plus longue que le délai « Verrouiller après ».';

  @override
  String get settingsAppLockFooterOff =>
      'Le verrouillage de l’application demande votre empreinte digitale, votre visage ou le verrouillage de l’écran avant d’afficher vos e-mails.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Le verrouillage de l’application est toujours désactivé. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Configurer un code';

  @override
  String get settingsScreenLockTextIos =>
      'Le verrouillage de l’application utilise Face ID, Touch ID ou votre code, et cet iPhone n’a pas de code. Configurez-en un dans l’app Réglages, puis activez le verrouillage de l’application.';

  @override
  String get settingsScreenLockTitleAndroid => 'Configurer le verrouillage de l’écran';

  @override
  String get settingsScreenLockTextAndroid =>
      'Le verrouillage de l’application utilise le verrouillage de l’écran de votre téléphone, ou une empreinte digitale ou un visage enregistré, et ce téléphone n’en a pas. Configurez un code PIN, un schéma ou un mot de passe dans les paramètres d’Android, puis activez le verrouillage de l’application.';

  @override
  String get settingsOpenSystemSettings => 'Ouvrir les paramètres';

  @override
  String get settingsOpenAndroidSettings => 'Ouvrir les paramètres d’Android';

  @override
  String get settingsLockAfter => 'Verrouiller après';

  @override
  String get settingsLockAfterFooter =>
      'Durée pendant laquelle Loupe peut rester en arrière-plan avant de vous redemander.';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsEncryption => 'Chiffrement de bout en bout';

  @override
  String get settingsAdvanced => 'Avancé';

  @override
  String get settingsDemoHeader => 'Démo';

  @override
  String get settingsDemoFooter =>
      'Les e-mails de démonstration forment une boîte fictive qui n’existe que sur ce téléphone. Rien n’est envoyé nulle part.';

  @override
  String get settingsDemoMode => 'Mode démo';

  @override
  String get settingsResetApp => 'Réinitialiser l’application';

  @override
  String get settingsResetFooter => 'Oublie tous les paramètres et revient à l’écran d’accueil.';

  @override
  String get settingsResetTitle => 'Réinitialiser Loupe ?';

  @override
  String get settingsResetMessage =>
      'Tous les paramètres, Smart Mailboxes et recherches récentes seront oubliés, et vous reviendrez à l’écran d’accueil.';

  @override
  String get settingsAboutHeader => 'À propos';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicences => 'Licences';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacyDetail =>
      'Loupe n’a ni statistiques ni pistage. Vos e-mails ne vont que vers vos serveurs de messagerie.';

  @override
  String get settingsNotificationsOffIos => 'Les notifications de Loupe sont désactivées dans Réglages.';

  @override
  String get settingsNotificationsOffAndroid =>
      'Les notifications de Loupe sont désactivées dans les paramètres d’Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system n’autorise pas Loupe à afficher des notifications. Autorisez-les dans les paramètres.';
  }

  @override
  String get settingsNewMailHeader => 'Nouveaux e-mails';

  @override
  String get settingsNewMailFooterDemo =>
      'Les e-mails de démonstration n’arrivent pas en arrière-plan. Envoyez une notification de test pour voir à quoi ressemble un nouvel e-mail.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe vérifie les nouveaux e-mails en arrière-plan quand iOS le permet, parfois à plusieurs heures d’intervalle pour les applications que vous ouvrez rarement. Vous êtes averti des nouveaux messages dans vos boîtes de réception, et de ceux des VIP dans n’importe quel dossier.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe vérifie les nouveaux e-mails environ toutes les 15 minutes, quand Android le permet. Vous êtes averti des nouveaux messages dans vos boîtes de réception, et de ceux des VIP dans n’importe quel dossier.';

  @override
  String get settingsNoAccounts => 'Aucun compte';

  @override
  String get settingsVipOnly => 'VIP uniquement';

  @override
  String get settingsVipOnlyDetail => 'Seulement les messages de vos VIP';

  @override
  String get settingsHideContent => 'Masquer le contenu';

  @override
  String get settingsHideContentFooterOn =>
      'Les notifications indiquent seulement « Nouveau message de » et le compte, sans dire qui a écrit ni à quel sujet.';

  @override
  String get settingsHideContentFooterOff =>
      '« Masquer le contenu » garde l’expéditeur, l’objet et l’aperçu hors de l’écran de verrouillage et des notifications.';

  @override
  String get settingsBackgroundAppRefresh => 'Actualisation en arrière-plan';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Les nouveaux e-mails n’arrivent en arrière-plan que si l’actualisation en arrière-plan est activée pour Loupe dans Réglages. iOS ne peut pas garder une connexion ouverte avec vos boîtes de réception : la réception instantanée n’est donc pas disponible.';

  @override
  String get settingsInstantDelivery => 'Réception instantanée';

  @override
  String get settingsInstantDeliveryFooter =>
      'La réception instantanée (expérimentale) garde une connexion ouverte avec vos boîtes de réception, pour que les nouveaux e-mails arrivent en quelques secondes. Elle affiche une notification discrète « Surveillance des nouveaux e-mails » et consomme plus de batterie.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android peut arrêter la réception instantanée pour économiser la batterie. Autorisez Loupe à utiliser la batterie sans restrictions pour qu’elle continue de fonctionner.';

  @override
  String get settingsExperimental => 'Expérimental';

  @override
  String get settingsComingSoon => 'Bientôt disponible';

  @override
  String get settingsAllowUnrestrictedBattery => 'Autoriser l’utilisation de la batterie sans restrictions';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Le push permet aux nouveaux e-mails de réveiller Loupe immédiatement, si votre service de messagerie le prend en charge. Les push passent par le service push de Google et ne contiennent aucun e-mail, seulement « vérifier maintenant ».';

  @override
  String get settingsPushUnavailableFooter =>
      'Ce téléphone ne peut pas recevoir de push : il faut les services Google Play et une connexion réseau. Loupe vérifie quand même les e-mails environ toutes les 15 minutes.';

  @override
  String get settingsCopyPushToken => 'Copier le jeton push';

  @override
  String get settingsPushTokenCopied => 'Jeton push copié';

  @override
  String get settingsSendTestNotification => 'Envoyer une notification de test';

  @override
  String get settingsAppIconBadge => 'Pastille de l’icône';

  @override
  String get settingsBadgeNote =>
      'La pastille se met à jour chaque fois que Loupe vérifie les e-mails, y compris en arrière-plan.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'L’écran d’accueil de ce téléphone n’affiche pas de chiffres sur les icônes des applications. La pastille se met à jour chaque fois que Loupe vérifie les e-mails, y compris en arrière-plan.';

  @override
  String get settingsTestNotificationBody => 'Les notifications de nouveaux e-mails ressemblent à ceci.';

  @override
  String get settingsAccountRemoved => 'Ce compte a été supprimé.';

  @override
  String get settingsAccountHeader => 'Compte';

  @override
  String get settingsAccountDescription => 'Description';

  @override
  String get settingsAccountDescriptionHint => 'Travail, Personnel…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Couleur';

  @override
  String get settingsColourFooter => 'Signale les messages de ce compte dans Toutes les boîtes de réception.';

  @override
  String settingsColourNumber(int number) {
    return 'Couleur $number';
  }

  @override
  String get settingsSendingHeader => 'Envoi';

  @override
  String get settingsSendingFooter =>
      'Chaque identité a sa propre signature. Les réponses partent de l’adresse à laquelle le message a été envoyé.';

  @override
  String get settingsFoldersHeader => 'Dossiers';

  @override
  String get settingsFoldersFooter =>
      'Loupe affiche et synchronise les dossiers auxquels vous êtes abonné, comme Thunderbird. Boîte de réception, Brouillons, Envoyés, Indésirables, Corbeille et Archives sont toujours affichés.';

  @override
  String get settingsShowAllFolders => 'Afficher tous les dossiers';

  @override
  String get settingsIncoming => 'Entrant';

  @override
  String get settingsOutgoing => 'Sortant';

  @override
  String get settingsConnectionNotEncrypted => 'Non chiffrée';

  @override
  String get settingsSignIn => 'Connexion';

  @override
  String get settingsSignInExpired => 'Expirée';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider n’accepte plus la connexion de Loupe pour ce compte : ses e-mails ne sont donc plus synchronisés. Reconnectez-vous pour régler le problème.';
  }

  @override
  String get settingsSignInAgain => 'Se reconnecter';

  @override
  String get settingsSigningIn => 'Connexion…';

  @override
  String get settingsRemoveAccount => 'Supprimer le compte';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Supprimer « $account » ?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Ses e-mails et ses paramètres sont supprimés de ce téléphone. Rien n’est supprimé sur le serveur.';

  @override
  String get settingsManageFolders => 'Gérer les dossiers';

  @override
  String get settingsNoFolders => 'Aucun dossier pour l’instant.';

  @override
  String get settingsManageFoldersFooter =>
      'Les dossiers auxquels vous êtes abonné apparaissent sur l’écran Boîtes aux lettres et se synchronisent en arrière-plan. Les autres applications de messagerie utilisant le même compte suivent généralement aussi ces abonnements.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Conserve vos Smart Mailboxes pour vos autres appareils. Masqué sur l’écran Boîtes aux lettres.';

  @override
  String get settingsFolderAlwaysShown => 'Toujours affiché';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'S’abonner à $folder';
  }

  @override
  String get settingsIdentities => 'Identités';

  @override
  String get settingsIdentitiesFooterReorder =>
      'La première identité est celle utilisée par défaut pour les nouveaux messages. Faites glisser pour modifier l’ordre.';

  @override
  String get settingsIdentitiesFooterSingle => 'L’identité par défaut pour les nouveaux messages.';

  @override
  String get settingsIdentitiesReplyFooter => 'Une réponse part de l’identité à laquelle le message a été envoyé.';

  @override
  String get settingsIdentityDefault => 'Par défaut';

  @override
  String settingsIdentityReorder(String email) {
    return 'Déplacer $email';
  }

  @override
  String get settingsAddIdentity => 'Ajouter une identité';

  @override
  String get settingsNewIdentity => 'Nouvelle identité';

  @override
  String get settingsIdentity => 'Identité';

  @override
  String get settingsIdentityNameHint => 'Votre nom';

  @override
  String get settingsReplyTo => 'Répondre à';

  @override
  String get settingsSignature => 'Signature';

  @override
  String get settingsSignatureFooter => 'Ajoutée sous « --  » dans les messages de cette identité.';

  @override
  String get settingsNoSignature => 'Aucune signature';

  @override
  String get settingsCopyToMyself => 'Copie à moi-même';

  @override
  String get settingsCopyToMyselfFooter => 'Ajoutée à chaque message de cette identité.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Cci';

  @override
  String get settingsReplyPatterns => 'Utiliser pour les réponses à';

  @override
  String get settingsReplyPatternsFooter =>
      'Les réponses aux messages envoyés à ces adresses partent de cette identité. * remplace n’importe quoi : *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Une adresse, ou un modèle où * remplace n’importe quoi.';

  @override
  String get settingsAddReplyPattern => 'Ajouter une adresse ou un modèle';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Retirer $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Modèle non valide';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '« $input » n’est ni une adresse ni un modèle comme *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Aucune adresse';

  @override
  String get settingsIdentityNoAddressMessage => 'Saisissez l’adresse e-mail d’envoi.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Adresse non valide';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '« $address » dans Répondre à n’est pas une adresse e-mail valide.',
      'cc': '« $address » dans Cc n’est pas une adresse e-mail valide.',
      'bcc': '« $address » dans Cci n’est pas une adresse e-mail valide.',
      'other': '« $address » n’est pas une adresse e-mail valide.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Enregistrer l’identité';

  @override
  String get settingsDiscardChanges => 'Abandonner les modifications';

  @override
  String get settingsDeleteIdentity => 'Supprimer l’identité';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Supprimer « $email » ?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Les messages déjà envoyés depuis cette identité restent inchangés.';

  @override
  String get settingsLastIdentityFooter => 'Un compte doit avoir au moins une identité.';

  @override
  String get rulesTitle => 'Règles';

  @override
  String get rulesNewRule => 'Nouvelle règle';

  @override
  String get rulesLoadError => 'Impossible de charger les règles.';

  @override
  String get rulesEmptyTitle => 'Aucune règle';

  @override
  String get rulesEmptyText =>
      'Les règles classent, étiquettent et marquent d’un drapeau les nouveaux e-mails pour vous. Créez-en une avec le bouton de rédaction ci-dessus, ou à partir d’une recherche avec « Transformer en règle ».';

  @override
  String get rulesListFooter =>
      'Les règles s’exécutent de haut en bas sur les nouveaux e-mails de la boîte de réception. Appuyez longuement sur une règle pour la déplacer.';

  @override
  String get rulesChangeError => 'Impossible de modifier la règle';

  @override
  String get rulesConditionEveryMessage => 'Tous les messages';

  @override
  String rulesMoveRule(String rule) {
    return 'Déplacer $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule activée';
  }

  @override
  String get rulesServerRulesHeader => 'Règles sur le serveur';

  @override
  String get rulesServerRulesFooter =>
      'Les règles sur le serveur s’exécutent sur le serveur de messagerie à l’arrivée des e-mails, même quand ce téléphone est éteint. Elles sont conservées dans un script Sieve nommé « loupe ».';

  @override
  String get rulesStatusUnknown => 'Inconnu';

  @override
  String get rulesStatusError => 'Impossible d’interroger le serveur.';

  @override
  String get rulesStatusChecking => 'Vérification…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Exécutées depuis « $script ».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '« $script » est le script actif. Touchez pour qu’il exécute aussi les règles de Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Aucun script n’est actif sur le serveur. Enregistrer une règle sur le serveur active celui de Loupe.';

  @override
  String get rulesStatusUnavailable => 'Non disponible';

  @override
  String get rulesStatusNoSieve => 'Le serveur de ce compte ne propose pas Sieve (ManageSieve ou JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Déplacer vers $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Déplacer vers un dossier';

  @override
  String rulesActionTag(String tag) {
    return 'Étiqueter $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Retirer l’étiquette $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Garder dans la boîte de réception';

  @override
  String rulesActionForward(String address) {
    return 'Transférer à $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Transférer à $address, sans garder de copie';
  }

  @override
  String get rulesActionStop => 'Arrêter';

  @override
  String get rulesNoActions => 'Ne fait rien pour l’instant';

  @override
  String get rulesLocationDevice => 'Appareil';

  @override
  String get rulesLocationServer => 'Serveur';

  @override
  String get rulesLocationThisDevice => 'Cet appareil';

  @override
  String get rulesNewRuleTitle => 'Nouvelle règle';

  @override
  String get rulesEditRuleTitle => 'Modifier la règle';

  @override
  String get rulesDefaultNameEveryMessage => 'Tous les messages';

  @override
  String get rulesConditionHeader => 'Quand un nouveau message correspond à';

  @override
  String get rulesConditionFooter =>
      'Écrivez-la comme une recherche : from:, to:, s: (objet), b: (corps), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:facture';

  @override
  String get rulesAccounts => 'Comptes';

  @override
  String get rulesAllAccounts => 'Tous les comptes';

  @override
  String get rulesRemovedAccount => 'Compte supprimé';

  @override
  String get rulesAccountsFooter =>
      'Une règle pour tous les comptes s’applique aussi aux comptes que vous ajouterez plus tard.';

  @override
  String get rulesActionsHeader => 'Alors';

  @override
  String get rulesForwardingFooter =>
      'Le transfert envoie chaque message correspondant à une autre adresse dès son arrivée, même quand ce téléphone est éteint. Certains fournisseurs limitent la quantité d’e-mails pouvant être transférés.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Le transfert ne fonctionne que dans les règles sur le serveur ; il n’est donc pas proposé ici.';

  @override
  String rulesRemoveAction(String action) {
    return 'Retirer $action';
  }

  @override
  String get rulesAddAction => 'Ajouter une action';

  @override
  String get rulesAddMove => 'Déplacer vers un dossier…';

  @override
  String get rulesAddTagMenu => 'Ajouter une étiquette…';

  @override
  String get rulesRemoveTagMenu => 'Retirer une étiquette…';

  @override
  String get rulesAddForward => 'Transférer à…';

  @override
  String get rulesStopProcessing => 'Ne pas appliquer les règles suivantes';

  @override
  String get rulesRunOnHeader => 'Exécuter sur';

  @override
  String get rulesRunOnDeviceFooter =>
      'Cet appareil exécute la règle sur les nouveaux e-mails de la boîte de réception chaque fois que Loupe vérifie les e-mails.';

  @override
  String get rulesRunOnServerFooter =>
      'Le serveur de messagerie exécute la règle à l’arrivée des e-mails, même quand ce téléphone est éteint. Nécessite Sieve, via ManageSieve (Dovecot, mailcow) ou JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Appliquer aux messages existants…';

  @override
  String get rulesDeleteRule => 'Supprimer la règle';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Supprimer « $rule » ?';
  }

  @override
  String get rulesMoveAccountTitle => 'Dossier de quel compte ?';

  @override
  String get rulesMoveAccountMessage =>
      'Les e-mails des autres comptes vont dans le dossier du même nom de ces comptes.';

  @override
  String get rulesAddTag => 'Ajouter une étiquette';

  @override
  String get rulesRemoveTag => 'Retirer une étiquette';

  @override
  String get rulesForwardTo => 'Transférer à';

  @override
  String get rulesForwardToMessage =>
      'Le serveur transfère chaque message correspondant à cette adresse, même quand ce téléphone est éteint. Utilisez une adresse qui vous appartient ou en laquelle vous avez confiance.';

  @override
  String get rulesNotAnAddressTitle => 'Adresse e-mail non valide';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '« $address » n’est pas une adresse vers laquelle transférer.';
  }

  @override
  String get rulesKeepCopyTitle => 'Garder une copie ici ?';

  @override
  String get rulesKeepCopy => 'Garder une copie';

  @override
  String get rulesDontKeepCopy => 'Ne pas garder de copie';

  @override
  String get rulesCheckCondition => 'Vérifiez la condition';

  @override
  String get rulesChooseActionTitle => 'Choisissez une action';

  @override
  String get rulesChooseActionMessage => 'Ajoutez ce que la règle fait des messages qui correspondent.';

  @override
  String get rulesSaveError => 'Impossible d’enregistrer la règle';

  @override
  String get rulesSaveServerError => 'Impossible d’enregistrer la règle sur le serveur';

  @override
  String get rulesRunOnDeviceInstead => 'Exécuter plutôt sur cet appareil';

  @override
  String get rulesNothingToApplyTitle => 'Rien à appliquer';

  @override
  String get rulesNothingToApplyMessage => 'Donnez d’abord à la règle une condition valide et une action.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Appliquer « $rule » aux messages de…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Boîtes de réception';

  @override
  String get rulesApplyScopeAll => 'Toutes les boîtes aux lettres';

  @override
  String get rulesFindingMessages => 'Recherche des messages…';

  @override
  String get rulesSearchError => 'Impossible de rechercher';

  @override
  String get rulesSearchErrorUnknown => 'Un problème est survenu.';

  @override
  String get rulesNoMatchesTitle => 'Aucun message correspondant';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Rien ne correspond à « $condition ».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Appliquer « $rule » à $countString messages ?',
      many: 'Appliquer « $rule » à $countString de messages ?',
      one: 'Appliquer « $rule » à $countString message ?',
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
      other: 'Appliquer à $countString messages',
      many: 'Appliquer à $countString de messages',
      one: 'Appliquer à $countString message',
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
      other: '« $rule » appliquée à $countString messages',
      many: '« $rule » appliquée à $countString de messages',
      one: '« $rule » appliquée à $countString message',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Interrogation du serveur sur ses capacités…';

  @override
  String get rulesServerUnreachable => 'Impossible de joindre le serveur.';

  @override
  String rulesServerProblem(String problem) {
    return 'Exécution impossible sur le serveur : $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Exécution impossible sur le serveur de $account : $problem';
  }

  @override
  String get rulesShowScript => 'Afficher le script';

  @override
  String get rulesHideScript => 'Masquer le script';

  @override
  String get rulesMatchingHeader => 'Messages correspondants';

  @override
  String get rulesMatchingHeaderLoading => 'Messages correspondants…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString messages correspondants',
      many: '$countString de messages correspondants',
      one: '$countString message correspondant',
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
      other: '$countString+ messages correspondants',
      one: '$countString+ message correspondant',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Des 30 derniers jours. La règle elle-même n’agit que sur les nouveaux e-mails, sauf si vous l’appliquez aux messages existants.';

  @override
  String rulesConditionError(String error) {
    return 'La condition contient une erreur : $error';
  }

  @override
  String get rulesPreviewNoSender => '(aucun expéditeur)';

  @override
  String get rulesPreviewNoSubject => '(sans objet)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'et $countString autres',
      one: 'et $countString autre',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Rien sur les 30 derniers jours.';

  @override
  String get rulesIncludeTitle => 'Activer les règles sur le serveur';

  @override
  String get rulesIncludeLeaveOff => 'Laisser désactivé';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Le serveur exécute déjà les règles de Loupe pour $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '« $script » est le script actif sur le serveur de $account : le serveur l’exécute à la place des règles de Loupe. Loupe ne le remplacera pas. Elle peut y ajouter ces lignes ; le serveur exécutera alors les règles de Loupe après celles du script :';
  }

  @override
  String get rulesShowWholeScript => 'Afficher tout le script';

  @override
  String get rulesHideWholeScript => 'Masquer tout le script';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Rien d’autre ne change dans « $script ». Si ses filtres sont modifiés plus tard dans le webmail, celui-ci risque de le réécrire sans ces lignes ; Loupe affichera alors de nouveau les règles sur le serveur comme désactivées.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Ajouter à « $script »';
  }

  @override
  String get subscriptionsTitle => 'Abonnements';

  @override
  String get subscriptionsNewsletters => 'Newsletters';

  @override
  String get subscriptionsDiscussions => 'Discussions';

  @override
  String get subscriptionsFilter => 'Filtrer';

  @override
  String get subscriptionsFilterNeverRead => 'Jamais lues';

  @override
  String get subscriptionsFilterRarelyRead => 'Rarement lues';

  @override
  String get subscriptionsFilterAll => 'Toutes';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Impossible de compter les abonnements';

  @override
  String get subscriptionsNoMatches => 'Aucun résultat';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Aucune newsletter ne s’appelle « $text ».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Aucune liste ne s’appelle « $text ».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Aucune newsletter';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Les newsletters et autres envois en masse apparaissent ici dès leur arrivée.';

  @override
  String get subscriptionsNothingNeverRead => 'Rien dans « Jamais lues »';

  @override
  String get subscriptionsNothingRarelyRead => 'Rien dans « Rarement lues »';

  @override
  String get subscriptionsNothingFilteredDetail => 'Vous lisez un peu de tout ce que vous recevez.';

  @override
  String get subscriptionsNoDiscussions => 'Aucune discussion';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Les listes de diffusion auxquelles vous pouvez écrire apparaissent ici dès l’arrivée de leurs e-mails.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Des listes auxquelles plusieurs personnes écrivent. Appuyez longuement sur l’une d’elles pour l’épingler aux boîtes aux lettres, la lire en texte brut ou la déplacer vers Newsletters.';

  @override
  String get subscriptionsPrivacyNote =>
      'Calculé sur ce téléphone à partir des e-mails qu’il a téléchargés ; rien n’est envoyé nulle part pour cela. Loupe ne contacte un expéditeur que lorsque vous touchez « Se désabonner » : le désabonnement en un clic envoie uniquement « List-Unsubscribe=One-Click » à l’adresse indiquée par l’expéditeur, sans cookies ni aucune autre information vous concernant, et ne charge jamais ses pages ni ses images.';

  @override
  String get subscriptionsVolumeNone => 'Aucun récemment';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mois';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mois';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '< 1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'lu à $percent';
  }

  @override
  String get subscriptionsStillSending => 'Envoie toujours';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Désabonné le $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Page de désabonnement ouverte le $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Un geste · contacte $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Par e-mail à $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Sur le site $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Se désabonner';

  @override
  String get subscriptionsUnsubscribeAgain => 'Se désabonner à nouveau';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archiver $countString messages de la boîte de réception',
      many: 'Archiver $countString de messages de la boîte de réception',
      one: 'Archiver $countString message de la boîte de réception',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Créer une règle…';

  @override
  String get subscriptionsCreateRuleDetail => 'Déplacer ou archiver ses futurs e-mails';

  @override
  String get subscriptionsTreatAsDiscussion => 'Traiter comme une discussion';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Une liste à laquelle on écrit : la lire comme un forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Traiter comme une newsletter';

  @override
  String get subscriptionsBlockSender => 'Bloquer l’expéditeur';

  @override
  String get subscriptionsBlock => 'Bloquer';

  @override
  String get subscriptionsBlocked => 'Bloqué';

  @override
  String get subscriptionsBlockedDetail => 'Les nouveaux e-mails vont dans Indésirables';

  @override
  String get subscriptionsPin => 'Épingler aux boîtes aux lettres';

  @override
  String get subscriptionsUnpin => 'Désépingler des boîtes aux lettres';

  @override
  String get subscriptionsOpenDefaultView => 'Ouvrir dans l’affichage par défaut';

  @override
  String get subscriptionsOpenPlainText => 'Ouvrir en texte brut (Mono)';

  @override
  String get subscriptionsPinned => 'Épinglée';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString non lus',
      one: '$countString non lu',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Aucun e-mail de cet expéditeur pour le moment.';

  @override
  String get subscriptionsLatestMessages => 'DERNIERS MESSAGES';

  @override
  String get subscriptionsMail => 'E-mails';

  @override
  String get subscriptionsNoneIn90Days => 'Aucun en 90 jours';

  @override
  String get subscriptionsRead => 'Lus';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString sur $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Dernière réception';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count dossiers', one: '$count dossier');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Envoie toujours';

  @override
  String get subscriptionsUnsubscribedTitle => 'Désabonné';

  @override
  String subscriptionsSince(String date) {
    return 'depuis le $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'page ouverte le $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender n’indique pas comment se désabonner.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender n’indique pas comment se désabonner. Vous pouvez le bloquer à la place.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Désabonnement de $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Désabonné de $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Impossible de se désabonner : $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Impossible de se désabonner automatiquement';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Envoyer un e-mail de désabonnement';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Ouvrir $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Ouvrir $site ?';
  }

  @override
  String get subscriptionsOpen => 'Ouvrir';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender gère les désabonnements sur son site web. La page s’ouvre dans le navigateur de Loupe ; terminez la procédure là-bas.';
  }

  @override
  String get subscriptionsWebInsecure => 'La connexion à ce site n’est pas chiffrée.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Attention : cette adresse imite $site avec des lettres sosies.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Attention : cette adresse imite un autre site avec des lettres sosies.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Impossible d’ouvrir $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe note la date d’aujourd’hui et vous prévient si $sender continue d’écrire.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Se désabonner de $sender ?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe va contacter $site pour vous désabonner.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'C’est la seule fois où Loupe contacte le site web d’un expéditeur. Elle envoie uniquement « List-Unsubscribe=One-Click » à l’adresse indiquée par $sender, sans cookies ni aucune autre information vous concernant, et ne charge pas la page.';
  }

  @override
  String get subscriptionsOneClickNotAllowed =>
      'Le lien de désabonnement n’est pas une adresse sécurisée sur internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site n’a pas répondu à temps.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Impossible de joindre $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site a renvoyé la demande vers une autre page, que Loupe ne suit pas.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site a refusé la demande (erreur $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Aucun compte ne permet d’envoyer l’e-mail de désabonnement.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe va envoyer un e-mail à $to depuis $from, avec l’objet « $subject ».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'E-mail de désabonnement envoyé à $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Bloquer $sender ?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Les nouveaux e-mails de cette liste iront dans Indésirables. Vous pouvez modifier cela dans Paramètres › Règles.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Les nouveaux e-mails de $address iront dans Indésirables. Vous pouvez modifier cela dans Paramètres › Règles.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender bloqué.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Déplacer $count vers Indésirables');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Bloquer $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender est maintenant dans Newsletters.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender est maintenant dans Discussions.';
  }

  @override
  String get appLiveGateTitle => 'Impossible d’ouvrir vos comptes';

  @override
  String get appLiveGateUnavailableBuild => 'Les vrais comptes ne sont pas encore disponibles dans cette version.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe n’a pas pu lire la clé qui protège vos e-mails sur ce téléphone. C’est souvent temporaire : réessayez ou redémarrez le téléphone.';

  @override
  String get appLiveGateKeyMissing =>
      'La clé qui protège vos e-mails sur ce téléphone a disparu, ce qui peut arriver après la restauration d’une sauvegarde. Vos e-mails sont toujours sur le serveur.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'La base de données des e-mails de ce téléphone est illisible : elle est endommagée, ou sa clé a changé. Vos e-mails sont toujours sur le serveur.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Un problème est survenu à l’ouverture de vos comptes ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Cette opération supprime vos comptes et les e-mails stockés sur ce téléphone, y compris les messages en attente dans la boîte d’envoi. Les e-mails sur vos serveurs ne sont pas concernés ; ajoutez de nouveau vos comptes ensuite.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Tout supprimer et recommencer';

  @override
  String get appLiveGateUseDemo => 'Utiliser les e-mails de démonstration';

  @override
  String get appLiveGateReset => 'Réinitialiser les e-mails de ce téléphone…';

  @override
  String get attachmentsUntitled => 'Pièce jointe';

  @override
  String get attachmentsUntitledFile => 'Sans titre';

  @override
  String get attachmentsOpenIn => 'Ouvrir dans…';

  @override
  String get attachmentsSaveToFiles => 'Enregistrer dans les fichiers';

  @override
  String get attachmentsShareMenu => 'Partager…';

  @override
  String get attachmentsDownloadError =>
      'Impossible de télécharger la pièce jointe. Vérifiez la connexion et réessayez.';

  @override
  String get attachmentsShareError => 'Impossible de partager la pièce jointe.';

  @override
  String attachmentsNoApp(String type) {
    return 'Aucune application de cet appareil n’ouvre ce fichier ($type). Essayez plutôt « Partager ».';
  }

  @override
  String get attachmentsOpenInError => 'Impossible d’ouvrir la pièce jointe dans une autre application.';

  @override
  String attachmentsSaved(String name) {
    return '« $name » enregistré';
  }

  @override
  String get attachmentsSaveError => 'Impossible d’enregistrer la pièce jointe.';

  @override
  String get attachmentsGone => 'Cette pièce jointe n’est plus disponible.';

  @override
  String get attachmentsDownloadFailed => 'La pièce jointe n’a pas pu être téléchargée.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      many: '$count de pages',
      one: '$count page',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size en données mobiles';
  }

  @override
  String get attachmentsLargeDownload =>
      'Cette pièce jointe est volumineuse. Téléchargez-la maintenant, ou plus tard en Wi-Fi.';

  @override
  String get attachmentsDownload => 'Télécharger';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Téléchargement de $size…';
  }

  @override
  String get attachmentsDownloading => 'Téléchargement…';

  @override
  String get attachmentsTooLarge => 'Trop volumineux pour être prévisualisé ici.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Affichage des premiers $shown sur $total. Copiez, partagez ou enregistrez pour tout obtenir.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Ce PDF ne peut pas être affiché ici (il est peut-être protégé par un mot de passe).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page sur $count';
  }

  @override
  String get attachmentsModeTable => 'Tableau';

  @override
  String get attachmentsModeText => 'Texte';

  @override
  String get attachmentsModeMessage => 'Message';

  @override
  String get attachmentsModeSource => 'Source';

  @override
  String get attachmentsDontWrap => 'Désactiver le retour à la ligne';

  @override
  String get attachmentsWrap => 'Activer le retour à la ligne';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines lignes', one: '$count ligne');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Tout copier';

  @override
  String get attachmentsCopied => 'Copié';

  @override
  String get attachmentsImageUnavailable => 'Cette image ne peut pas être affichée ici. Essayez « Ouvrir dans… ».';

  @override
  String get attachmentsEmlNoSubject => '(Sans objet)';

  @override
  String get attachmentsEmlFrom => 'De';

  @override
  String get attachmentsEmlTo => 'À';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Date';

  @override
  String get attachmentsEmlNoText => 'Ce message ne contient pas de texte.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pièces jointes : $names',
      one: '$count pièce jointe : $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organisateur : $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Et $count autres événements',
      one: 'Et $count autre événement',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Image';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Image $format';
  }

  @override
  String get attachmentsTypePdf => 'Document PDF';

  @override
  String get attachmentsTypeTsv => 'Valeurs séparées par des tabulations';

  @override
  String get attachmentsTypeCsv => 'Feuille de calcul CSV';

  @override
  String get attachmentsTypeCalendar => 'Événement d’agenda';

  @override
  String get attachmentsTypeEmail => 'E-mail';

  @override
  String get attachmentsTypeContact => 'Fiche de contact';

  @override
  String get attachmentsTypeLog => 'Fichier journal';

  @override
  String get attachmentsTypeText => 'Texte';

  @override
  String get attachmentsTypeZip => 'Archive ZIP';

  @override
  String get attachmentsTypeArchive => 'Archive';

  @override
  String get attachmentsTypeWord => 'Document Word';

  @override
  String get attachmentsTypeExcel => 'Feuille de calcul Excel';

  @override
  String get attachmentsTypePowerPoint => 'Présentation PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Page web';

  @override
  String get attachmentsTypeVideo => 'Vidéo';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Fichier $extension';
  }

  @override
  String get attachmentsTypeFile => 'Fichier';

  @override
  String get calendarUntitledEvent => 'Événement';

  @override
  String get calendarAllDay => 'Toute la journée';

  @override
  String calendarYourTime(String time) {
    return '$time (votre heure)';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Rejoindre : $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a accepté : $details',
      'tentative': '$name a accepté provisoirement : $details',
      'declined': '$name a refusé : $details',
      'delegated': '$name a délégué : $details',
      'other': '$name n’a pas répondu à : $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a accepté l’invitation',
      'tentative': '$name a accepté provisoirement l’invitation',
      'declined': '$name a refusé l’invitation',
      'delegated': '$name a délégué l’invitation',
      'other': '$name n’a pas répondu à l’invitation',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Carte';

  @override
  String get calendarJoin => 'Rejoindre';

  @override
  String get calendarOnlineMeeting => 'Réunion en ligne';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Réunion $provider';
  }

  @override
  String get calendarOrganizerYou => 'Vous';

  @override
  String get calendarOrganizerLabel => 'organisateur';

  @override
  String get calendarStatusAccepted => 'Accepté';

  @override
  String get calendarStatusMaybe => 'Peut-être';

  @override
  String get calendarStatusDeclined => 'Refusé';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a accepté',
      'tentative': '$name a accepté provisoirement',
      'declined': '$name a refusé',
      'delegated': '$name a délégué',
      'other': '$name n’a pas répondu',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name a accepté :',
      'tentative': '$name a accepté provisoirement :',
      'declined': '$name a refusé :',
      'delegated': '$name a délégué :',
      'other': '$name n’a pas répondu :',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '« $comment »';
  }

  @override
  String calendarCounter(String name) {
    return '$name propose un nouvel horaire';
  }

  @override
  String get calendarCounterUnknown => 'Un participant propose un nouvel horaire';

  @override
  String get calendarDeclineCounter => 'L’organisateur a maintenu l’horaire';

  @override
  String calendarRefresh(String name) {
    return '$name demande la dernière version';
  }

  @override
  String get calendarRefreshUnknown => 'Un participant demande la dernière version';

  @override
  String get calendarCancelled => 'Annulé';

  @override
  String get calendarCancelledByOrganizer => 'L’organisateur a annulé cet événement.';

  @override
  String get calendarCancelledLater => 'Cet événement a été annulé par la suite.';

  @override
  String get calendarOutdated => 'Obsolète';

  @override
  String get calendarOutdatedDetail => 'Cette invitation a été mise à jour depuis ; c’est la plus récente qui compte.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Lieu supprimé (auparavant : $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Lieu supprimé (aucun auparavant)';

  @override
  String calendarLocationChanged(String location) {
    return 'Lieu changé en $location';
  }

  @override
  String get calendarNewTitle => 'Nouveau titre';

  @override
  String get calendarRepeatChanged => 'La répétition a changé';

  @override
  String get calendarUpdated => 'Mis à jour';

  @override
  String get calendarUpdatedInvitation => 'Invitation mise à jour';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Horaire changé de $before à $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Fuseau horaire « $zone » inconnu : heures telles qu’écrites';
  }

  @override
  String calendarNext(String when) {
    return 'Prochaine occurrence : $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invités',
      many: '$count d’invités',
      one: '$count invité',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ont accepté',
      one: '$count a accepté',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count peut-être');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ont refusé',
      one: '$count a refusé',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (vous)';
  }

  @override
  String get calendarAttendeeOptional => 'facultatif';

  @override
  String get calendarAttendeeRoom => 'salle';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Vous avez accepté une version antérieure.',
      'tentative': 'Vous avez accepté provisoirement une version antérieure.',
      'declined': 'Vous avez refusé une version antérieure.',
      'delegated': 'Vous avez délégué une version antérieure.',
      'other': 'Vous n’avez pas répondu à une version antérieure.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Accepter';

  @override
  String get calendarMaybe => 'Peut-être';

  @override
  String get calendarDecline => 'Refuser';

  @override
  String get calendarCommentHint => 'Commentaire pour l’organisateur (facultatif)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Votre réponse sera envoyée à $organizer depuis $address.';
  }

  @override
  String get calendarAddComment => 'Ajouter un commentaire';

  @override
  String get calendarAddToCalendar => 'Ajouter à l’agenda';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Et $count autres événements dans le fichier',
      one: 'Et $count autre événement dans le fichier',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Aucune application d’agenda ne permet d’ajouter l’événement.';

  @override
  String get calendarCantOpenCalendar => 'Impossible d’ouvrir l’agenda.';

  @override
  String get calendarCantOpenLink => 'Impossible d’ouvrir le lien.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Rejoindre la réunion $provider ?';
  }

  @override
  String get calendarJoinTitle => 'Rejoindre la réunion ?';

  @override
  String calendarJoinOpens(String host) {
    return 'Ouvre $host dans votre navigateur.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Attention : cette adresse imite $site avec des lettres sosies.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Attention : cette adresse imite un autre site avec des lettres sosies.';

  @override
  String calendarJoinOpen(String host) {
    return 'Ouvrir $host';
  }

  @override
  String get calendarNoOrganizer => 'Cette invitation n’a pas d’organisateur à qui répondre.';

  @override
  String get calendarNoAccount => 'Aucun compte ne permet de répondre.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepté', 'tentative': 'Peut-être', 'other': 'Refusé'});
    return '$_temp0 · envoi de la réponse à $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Accepté', 'tentative': 'Peut-être', 'other': 'Refusé'});
    return '$_temp0 · réponse envoyée';
  }

  @override
  String get calendarReplyAlreadySent => 'La réponse a déjà été envoyée.';

  @override
  String get calendarReplyNotSent => 'Réponse non envoyée.';

  @override
  String get dataSmimeNeedsDevice =>
      'Votre certificat S/MIME est sur cet appareil : ouvrez Loupe pour signer et envoyer ce message.';

  @override
  String dataSigningFailed(String error) {
    return 'Échec de la signature : $error';
  }

  @override
  String get keyboardShortcuts => 'Raccourcis clavier';

  @override
  String get keyboardGroupGeneral => 'Général';

  @override
  String get keyboardGroupMessages => 'Messages';

  @override
  String get keyboardGroupCompose => 'Rédaction';

  @override
  String get keyboardCommandPalette => 'Palette de commandes';

  @override
  String get keyboardBackClose => 'Retour, fermer';

  @override
  String get keyboardNextMessage => 'Message suivant';

  @override
  String get keyboardPreviousMessage => 'Message précédent';

  @override
  String get keyboardOpenMessage => 'Ouvrir le message';

  @override
  String get keyboardMoveToTrash => 'Mettre à la corbeille';

  @override
  String get keyboardToggleRead => 'Marquer comme lu ou non lu';

  @override
  String get keyboardToggleFlag => 'Ajouter ou retirer le drapeau';

  @override
  String get keyboardCloseDraft => 'Fermer (enregistrer ou supprimer le brouillon)';

  @override
  String get keyboardOr => 'ou';

  @override
  String get keyboardKeyCtrl => 'Ctrl';

  @override
  String get keyboardKeyShift => 'Maj';

  @override
  String get keyboardKeyEnter => 'Entrée';

  @override
  String get keyboardKeyEsc => 'Échap';

  @override
  String get keyboardKeyDelete => 'Suppr';

  @override
  String get keyboardKeyBackspace => 'Retour arrière';

  @override
  String get mailingListsMuted => 'Fil mis en sourdine. Ses nouveaux messages arriveront déjà lus.';

  @override
  String get mailingListsUnmuted => 'Le fil n’est plus en sourdine.';

  @override
  String get mailingListsMuteThread => 'Mettre le fil en sourdine';

  @override
  String get mailingListsUnmuteThread => 'Désactiver la sourdine du fil';

  @override
  String get mailingListsPin => 'Épingler aux boîtes aux lettres';

  @override
  String get mailingListsUnpin => 'Désépingler des boîtes aux lettres';

  @override
  String get mailingListsDefaultView => 'Ouvrir dans l’affichage par défaut';

  @override
  String get mailingListsPlainText => 'Ouvrir en texte brut (Mono)';

  @override
  String get mailingListsShowMuted => 'Afficher les fils en sourdine';

  @override
  String get mailingListsHideMuted => 'Masquer les fils en sourdine';

  @override
  String get mailingListsTreatAsNewsletter => 'Traiter comme une newsletter';

  @override
  String get mailingListsOptions => 'Options de la liste';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$formatted non lus', one: '$count non lu');
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nouveau message à la liste';

  @override
  String get mailingListsRowUnread => 'Non lu';

  @override
  String get mailingListsRowMuted => 'En sourdine';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count réponses',
      many: '$count de réponses',
      one: '$count réponse',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Aucun fil';

  @override
  String get mailingListsMutedHidden => 'Les fils en sourdine sont masqués.';

  @override
  String get mailingListsTechnicalTitle => 'Listes techniques';

  @override
  String get mailingListsTechnicalEmpty => 'Les listes de diffusion apparaissent ici dès l’arrivée de leurs e-mails.';

  @override
  String get mailingListsTechnicalFooter =>
      'Les messages de ces listes s’ouvrent en texte brut dans une police à chasse fixe, avec les patchs affichés en diffs. Le bouton Aa permet toujours de changer l’affichage de n’importe quel message.';

  @override
  String get paletteMoveToMailbox => 'Déplacer vers une boîte aux lettres…';

  @override
  String get paletteMarkAllRead => 'Tout marquer comme lu';

  @override
  String get paletteExportFolder => 'Exporter le dossier…';

  @override
  String get paletteGetNewMail => 'Relever les nouveaux e-mails';

  @override
  String get paletteSnoozed => 'En attente';

  @override
  String get paletteSubscriptions => 'Abonnements';

  @override
  String get paletteDiscussions => 'Discussions';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Liste de diffusion';

  @override
  String get paletteTag => 'Étiquette';

  @override
  String get paletteSwipeActions => 'Actions de balayage';

  @override
  String get paletteNotifications => 'Notifications';

  @override
  String get paletteRules => 'Règles';

  @override
  String get paletteEncryption => 'Chiffrement de bout en bout';

  @override
  String get paletteAdvanced => 'Avancé';

  @override
  String get paletteAddAccount => 'Ajouter un compte';

  @override
  String get paletteAccount => 'Compte';

  @override
  String get paletteFolders => 'Dossiers';

  @override
  String get paletteRecentSearch => 'Recherche récente';

  @override
  String paletteSearchMail(String query) {
    return 'Rechercher « $query » dans les e-mails';
  }

  @override
  String get palettePlaceholder => 'Rechercher des actions, boîtes aux lettres, paramètres';

  @override
  String get paletteNothingFound => 'Aucun résultat';

  @override
  String get searchNewSmartMailbox => 'Nouvelle Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Affiche tout ce qui correspond à « $query ».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '« $name » enregistrée dans les boîtes aux lettres';
  }

  @override
  String get searchMakeRule => 'Transformer en règle';

  @override
  String get searchSaveSmartMailbox => 'Enregistrer comme Smart Mailbox';

  @override
  String get searchNegate => 'Inverser';

  @override
  String get searchDontNegate => 'Ne pas inverser';

  @override
  String get searchAllMailboxes => 'Toutes les boîtes aux lettres';

  @override
  String get searchRecent => 'Recherches récentes';

  @override
  String get searchClear => 'Effacer';

  @override
  String get searchSuggestions => 'Suggestions';

  @override
  String get searchUnreadMessages => 'Messages non lus';

  @override
  String get searchFlaggedMessages => 'Messages avec drapeau';

  @override
  String get searchWithAttachments => 'Messages avec pièces jointes';

  @override
  String get searchUnrepliedMessages => 'Messages sans réponse';

  @override
  String get searchTags => 'Étiquettes';

  @override
  String get searchPeople => 'Personnes';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'De : $name';
  }

  @override
  String get searchSearching => 'Recherche…';

  @override
  String get searchNoResults => 'Aucun résultat';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted résultats',
      many: '$formatted de résultats',
      one: '$count résultat',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menu de recherche';

  @override
  String searchSearchingAccount(String account) {
    return 'Recherche dans $account sur le serveur…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Recherche dans le compte sur le serveur…';

  @override
  String searchAccountFailed(String account) {
    return 'Impossible de rechercher dans $account sur le serveur';
  }

  @override
  String get searchUnknownAccountFailed => 'Impossible de rechercher dans le compte sur le serveur';

  @override
  String searchChip(String term) {
    return '$term. Touchez deux fois pour modifier.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Sauf $term. Touchez deux fois pour modifier.';
  }

  @override
  String get searchReadAndUnread =>
      'La boîte de réception de Schrödinger : chaque message ici est à la fois lu et non lu jusqu’à ce que vous l’ouvriez.';

  @override
  String searchContradiction(String term) {
    return 'Aucun message ne peut être à la fois « $term » et son contraire.';
  }

  @override
  String get searchSyncDeviceOnly => 'Sur cet appareil uniquement';

  @override
  String searchSyncUnsupported(String account) {
    return 'Sur cet appareil uniquement : $account ne peut pas la conserver';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Non synchronisée : $account utilise un format plus récent';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'En attente de synchronisation avec $account';
  }

  @override
  String searchSynced(String account) {
    return 'Synchronisée avec $account';
  }

  @override
  String get searchRename => 'Renommer';

  @override
  String get searchEditSearch => 'Modifier la recherche';

  @override
  String get searchDeleteSmartMailbox => 'Supprimer la Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Renommer la Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Cette Smart Mailbox a été supprimée.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Les Smart Mailboxes restent sur cet appareil.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Les Smart Mailboxes sont conservées sur votre serveur de messagerie : vos autres appareils les ont aussi, tout comme Thunderbird avec Expression Search Reloaded. Celles qui cherchent dans tous les comptes sont conservées sur $account ; celles d’un seul dossier, sur le compte de ce dossier.';
  }

  @override
  String get searchSyncVia => 'Synchroniser via';

  @override
  String get searchSyncViaFooter => 'Choisissez le même compte sur chaque appareil.';

  @override
  String get searchGmailCantKeep => 'Gmail ne peut pas conserver les Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Conserver les Smart Mailboxes sur cet appareil uniquement';

  @override
  String get searchOnTheServer => 'Sur le serveur';

  @override
  String get searchServerFooter =>
      'Les métadonnées du serveur (IMAP METADATA) n’apparaissent dans aucune application de messagerie. Les serveurs qui ne les prennent pas en charge reçoivent un dossier « Loupe Settings » contenant un message ; Loupe le masque dans les boîtes aux lettres.';

  @override
  String get searchSyncNow => 'Synchroniser maintenant';

  @override
  String get searchStateUnsupported => 'Non pris en charge';

  @override
  String get searchStateNewerFormat => 'Format plus récent';

  @override
  String get searchStateFailed => 'Échec de la synchronisation';

  @override
  String get searchStateSyncing => 'Synchronisation…';

  @override
  String get searchStateWaiting => 'En attente';

  @override
  String get searchStateMetadata => 'Métadonnées du serveur';

  @override
  String get searchStateFolder => 'Dossier Loupe Settings';

  @override
  String get searchStateNothing => 'Rien d’enregistré';

  @override
  String get sharedBack => 'Retour';

  @override
  String get sharedYesterday => 'Hier';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date à $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count octets', one: '$count octet');
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size Ko';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size Mo';
  }

  @override
  String get sharedSyncNoAccounts => 'Aucun compte';

  @override
  String get sharedSyncChecking => 'Relève des e-mails…';

  @override
  String get sharedSyncFailed => 'Impossible de relever les e-mails';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account : $error';
  }

  @override
  String get sharedSyncOffline => 'Hors ligne';

  @override
  String get sharedSyncJustNow => 'Mis à jour à l’instant';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Mis à jour il y a $minutes minutes',
      one: 'Mis à jour il y a $minutes minute',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Mis à jour à $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Mis à jour le $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Toutes les boîtes de réception';

  @override
  String get sharedMailboxUnread => 'Non lus';

  @override
  String get sharedMailboxFlagged => 'Avec drapeau';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Tous les brouillons';

  @override
  String get sharedMailboxAllSent => 'Tous les envoyés';

  @override
  String get sharedMailboxUntitled => 'Boîte aux lettres';

  @override
  String get sharedTagImportant => 'Important';

  @override
  String get sharedTagWork => 'Travail';

  @override
  String get sharedTagPersonal => 'Personnel';

  @override
  String get sharedTagToDo => 'À faire';

  @override
  String get sharedTagLater => 'Plus tard';

  @override
  String get sharedTags => 'Étiquettes';

  @override
  String get sharedMoveTo => 'Déplacer vers…';

  @override
  String get sharedNoRecipients => 'Aucun destinataire';

  @override
  String get sharedUnknownSender => 'Expéditeur inconnu';

  @override
  String get sharedOnServer => 'Sur le serveur';

  @override
  String get sharedAttachment => 'Pièce jointe';

  @override
  String get sharedSnoozedBadge => 'Mis en attente';

  @override
  String get sharedRowUnread => 'Non lu';

  @override
  String get sharedRowBackFromSnooze => 'Revenu de la mise en attente';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Avec drapeau';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages archivés',
      many: '$count de messages archivés',
      one: '$count message archivé',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages supprimés',
      many: '$count de messages supprimés',
      one: '$count message supprimé',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages déplacés vers la boîte de réception',
      many: '$count de messages déplacés vers la boîte de réception',
      one: '$count message déplacé vers la boîte de réception',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages mis à la corbeille',
      many: '$count de messages mis à la corbeille',
      one: '$count message mis à la corbeille',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages déplacés vers Indésirables',
      many: '$count de messages déplacés vers Indésirables',
      one: '$count message déplacé vers Indésirables',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages déplacés vers $mailbox',
      many: '$count de messages déplacés vers $mailbox',
      one: '$count message déplacé vers $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages déplacés vers une boîte aux lettres',
      many: '$count de messages déplacés vers une boîte aux lettres',
      one: '$count message déplacé vers une boîte aux lettres',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages mis en attente jusqu’à $time',
      many: '$count de messages mis en attente jusqu’à $time',
      one: '$count message mis en attente jusqu’à $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Mis en attente jusqu’à $time sur cet appareil uniquement : le serveur ne peut pas enregistrer les heures de mise en attente.';
  }

  @override
  String get sharedMoveOneAccount => 'Sélectionnez des messages d’un seul compte pour les déplacer.';

  @override
  String get sharedSnoozeTitle => 'Mettre en attente';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Modifier l’heure de mise en attente';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer définitivement $count messages ?',
      many: 'Supprimer définitivement $count de messages ?',
      one: 'Supprimer définitivement $count message ?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Cette action est irréversible.';

  @override
  String get sharedDeletePermanently => 'Supprimer définitivement';

  @override
  String get sharedSwipeRead => 'Lu';

  @override
  String get sharedSwipeUnread => 'Non lu';

  @override
  String get sharedSwipeInbox => 'Réception';

  @override
  String get sharedSwipeDelete => 'Supprimer';

  @override
  String get sharedTrash => 'Corbeille';

  @override
  String get sharedSwipeSnooze => 'En attente';

  @override
  String get sharedWakeNow => 'Réactiver maintenant';

  @override
  String get sharedChangeSnoozeTime => 'Modifier l’heure de mise en attente…';

  @override
  String get sharedSnooze => 'Mettre en attente…';

  @override
  String get sharedTag => 'Étiqueter…';

  @override
  String get sharedMoveMessage => 'Déplacer le message…';

  @override
  String get sharedNotJunk => 'Pas indésirable';

  @override
  String get accountSetupTitle => 'Ajouter un compte';

  @override
  String get accountSetupTitleDone => 'Compte ajouté';

  @override
  String get accountSetupAddressTitle => 'Ajouter un compte de messagerie';

  @override
  String get accountSetupAddressText => 'Loupe trouve les paramètres de la plupart des fournisseurs.';

  @override
  String get accountSetupNameHint => 'Votre nom';

  @override
  String get accountSetupEmail => 'Adresse e-mail';

  @override
  String get accountSetupEmailHint => 'nom@example.com';

  @override
  String get accountSetupContinue => 'Continuer';

  @override
  String get accountSetupLookingUp => 'Recherche des paramètres…';

  @override
  String get accountSetupImport => 'Importer depuis Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Impossible de trouver les paramètres de $domain. Saisissez-les ci-dessous.';
  }

  @override
  String get accountSetupCheckServers => 'Vérifiez les noms des serveurs et les ports.';

  @override
  String get accountSetupEnterPassword => 'Saisissez votre mot de passe.';

  @override
  String get accountSetupConnecting => 'Connexion…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'En attente de $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Impossible d’ouvrir la page.';

  @override
  String get accountSetupCouldNotSaveName => 'Impossible d’enregistrer le nom.';

  @override
  String get accountSetupTrustCertificate => 'Approuver ce certificat';

  @override
  String get accountSetupPasswordRequired => 'Obligatoire';

  @override
  String get accountSetupShowPassword => 'Afficher le mot de passe';

  @override
  String get accountSetupHidePassword => 'Masquer le mot de passe';

  @override
  String get accountSetupAppPassword => 'Mot de passe d’application';

  @override
  String get accountSetupApiToken => 'Jeton d’API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Entrant · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Sortant · SMTP';

  @override
  String get accountSetupSignIn => 'Se connecter';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Se connecter avec $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Utiliser un mot de passe d’application';

  @override
  String get accountSetupUseAppPasswordInstead => 'Utiliser plutôt un mot de passe d’application';

  @override
  String get accountSetupUseDifferentAddress => 'Utiliser une autre adresse';

  @override
  String get accountSetupHowToCreateAppPassword => 'Comment créer un mot de passe d’application';

  @override
  String get accountSetupHowToCreateOne => 'Comment en créer un';

  @override
  String get accountSetupGoogleNote =>
      'Vous vous connectez sur la page de Google, et Loupe ne voit jamais votre mot de passe. Autorisez Loupe à lire, envoyer et organiser vos e-mails.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '« Se connecter avec Google » n’est pas encore disponible dans cette version. Vous pouvez vous connecter avec un mot de passe d’application à la place (la validation en deux étapes doit être activée sur votre compte Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Créez un mot de passe d’application dans votre compte Google et collez-le ci-dessous.';

  @override
  String get accountSetupMicrosoftNote =>
      'Vous vous connectez sur la page de Microsoft, et Loupe ne voit jamais votre mot de passe. Cela fonctionne avec Outlook.com et Hotmail, ainsi qu’avec les comptes professionnels ou scolaires Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'La connexion avec Microsoft arrivera dans une prochaine version. Les comptes Outlook, Hotmail et Microsoft 365 en ont besoin : ils n’acceptent plus les mots de passe des applications de messagerie.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail nécessite un mot de passe pour app, et non le mot de passe de votre compte Apple.';

  @override
  String get accountSetupYahooNote =>
      'Yahoo Mail nécessite un mot de passe d’application, et non celui de votre compte.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe se connecte à Fastmail via JMAP avec un jeton d’API : Settings › Privacy & Security › Manage API tokens, pour JMAP, avec accès aux e-mails et à l’envoi.';

  @override
  String get accountSetupFastmailNote =>
      'Fastmail nécessite un mot de passe d’application pour les applications de messagerie.';

  @override
  String get accountSetupServerSettings => 'Paramètres du serveur';

  @override
  String get accountSetupSettingsNotFound => 'Non trouvés automatiquement';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Trouvés via $source';
  }

  @override
  String get accountSetupEditSettings => 'Modifier les paramètres';

  @override
  String get accountSetupSyncing => 'Vos e-mails sont en cours de synchronisation.';

  @override
  String get accountSetupDescription => 'Description';

  @override
  String get accountSetupDescriptionHint => 'Travail, Personnel…';

  @override
  String get accountSetupColour => 'Couleur';

  @override
  String accountSetupColourNumber(int number) {
    return 'Couleur $number';
  }

  @override
  String get accountSetupSaving => 'Enregistrement…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe n’a pas pu ouvrir sa base de données des e-mails sur ce téléphone. Fermez Loupe, rouvrez-la et réessayez.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Un problème est survenu ($error). Réessayez.';
  }

  @override
  String get accountSetupSecurityNone => 'Aucune';

  @override
  String get accountSetupProtocol => 'Protocole';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sécurité';

  @override
  String get accountSetupUsername => 'Nom d’utilisateur';

  @override
  String get accountSetupUsernameHint => 'Votre adresse e-mail';

  @override
  String get accountSetupNoEncryptionTitle => 'Se connecter sans chiffrement ?';

  @override
  String get accountSetupNoEncryptionText =>
      'Votre mot de passe et chaque message transiteraient en clair. N’importe qui sur le réseau, par exemple un Wi-Fi public, pourrait les lire. N’utilisez cette option que pour un serveur de votre propre réseau.';

  @override
  String get accountSetupUseWithoutEncryption => 'Utiliser sans chiffrement';

  @override
  String get accountSetupApiTokenRejected =>
      'Jeton d’API refusé. Créez un jeton d’API Fastmail pour JMAP avec accès aux e-mails, et collez-le.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Mot de passe refusé. Utilisez un mot de passe d’application, et non celui de votre compte.';

  @override
  String get accountSetupPasswordRejected => 'Mot de passe refusé. Vérifiez-le et réessayez.';

  @override
  String get accountSetupServerUnreachable =>
      'Impossible de joindre le serveur. Vérifiez les paramètres du serveur et votre connexion.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Le certificat du serveur n’est pas approuvé. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'La connexion a été annulée. Touchez « Se connecter avec $provider » pour réessayer.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe a besoin de l’autorisation de lire et d’envoyer vos e-mails Gmail. Reconnectez-vous et autorisez l’accès, en cochant la case Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe a besoin de l’autorisation de lire et d’envoyer vos e-mails. Reconnectez-vous et acceptez les autorisations.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Votre organisation doit approuver Loupe avant que vous puissiez l’utiliser avec ce compte. Demandez à votre administrateur informatique d’accorder le consentement administrateur pour Loupe dans Microsoft Entra ID, puis réessayez.';

  @override
  String get accountSetupOAuthBlocked =>
      'Les règles de connexion de votre organisation n’autorisent pas Loupe sur cet appareil. Contactez votre administrateur informatique.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Impossible de joindre $provider. Vérifiez votre connexion internet et réessayez.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'La connexion avec $provider n’est pas correctement configurée dans cette version de Loupe. Merci de le signaler.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'La connexion avec $provider n’a pas fonctionné. Réessayez.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider vous a connecté, mais Gmail a refusé l’accès pour cette adresse. Choisissez le même compte lors de la connexion. Sur les comptes professionnels ou scolaires, l’administrateur a peut-être désactivé l’IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider vous a connecté, mais le serveur de messagerie a refusé l’accès pour cette adresse. Choisissez le même compte lors de la connexion. Sur les comptes professionnels ou scolaires, l’administrateur a peut-être désactivé l’IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Impossible de joindre le serveur de messagerie. Vérifiez votre connexion et réessayez.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'La connexion avec $provider n’est pas disponible dans cette version.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Reconnecté. $account est en cours de synchronisation.';
  }

  @override
  String get accountSetupSignInAgain => 'Se reconnecter';

  @override
  String get accountSetupSigningIn => 'Connexion…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider n’accepte plus la connexion de Loupe pour $email : $account n’est donc plus synchronisé. Reconnectez-vous pour recevoir ses e-mails.';
  }

  @override
  String get accountImportTitle => 'Importer depuis Thunderbird';

  @override
  String get accountImportPointCamera => 'Pointez l’appareil photo vers le code QR affiché par Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned sur $total scannés';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned codes scannés sur $total',
      one: '$scanned code scanné sur $total',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes pour l’instant',
      one: '$count compte pour l’instant',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Sur votre ordinateur, ouvrez Thunderbird et choisissez Outils › Exporter pour mobile. Sélectionnez vos comptes, puis scannez chaque code affiché. Les codes peuvent être scannés dans n’importe quel ordre.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continuer avec $count comptes',
      one: 'Continuer avec $count compte',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Coller le texte à la place';

  @override
  String get accountImportStartOver => 'Recommencer';

  @override
  String get accountImportDuplicateCode => 'Ce code a déjà été ajouté.';

  @override
  String get accountImportRestarted =>
      'Ce code provient d’une nouvelle exportation : les codes scannés auparavant ont été mis de côté.';

  @override
  String get accountImportNotThunderbird => 'Ce n’est pas un code de compte Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Ce code provient d’une version plus récente de Thunderbird. Mettez Loupe à jour pour l’importer.';

  @override
  String get accountImportDamaged => 'Ce code Thunderbird n’a pas pu être lu.';

  @override
  String get accountImportTooLarge => 'Ce code est trop volumineux pour être une exportation Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Impossible d’ouvrir les paramètres.';

  @override
  String get accountImportCameraOffTitle => 'L’accès à l’appareil photo est désactivé';

  @override
  String get accountImportCameraOffText =>
      'Autorisez Loupe à utiliser l’appareil photo dans les paramètres pour scanner le code, ou collez plutôt le texte du code.';

  @override
  String get accountImportNoCameraTitle => 'Aucun appareil photo';

  @override
  String get accountImportNoCameraText =>
      'Loupe ne peut pas utiliser d’appareil photo ici. Collez plutôt le texte du code.';

  @override
  String get accountImportCameraFailedTitle => 'L’appareil photo n’a pas démarré';

  @override
  String get accountImportCameraFailedText => 'Réessayez, ou collez plutôt le texte du code.';

  @override
  String get accountImportOpenSettings => 'Ouvrir les paramètres';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes trouvés',
      one: '$count compte trouvé',
      zero: 'Aucun compte trouvé',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Aucun des comptes de ces codes n’a pu être lu.';

  @override
  String get accountImportChoose => 'Choisissez les comptes à ajouter à Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count codes ($codes sur $total) n’ont pas été scannés : leurs comptes ne sont donc pas listés.',
      one: '$count code ($codes sur $total) n’a pas été scanné : ses comptes ne sont donc pas listés.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes et $last';
  }

  @override
  String get accountImportScanMore => 'Scanner d’autres codes';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count comptes des codes n’ont pas pu être lus. Ils utilisent peut-être des paramètres d’une version plus récente de Thunderbird.',
      one:
          '$count compte des codes n’a pas pu être lu. Il utilise peut-être des paramètres d’une version plus récente de Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Scanner à nouveau';

  @override
  String get accountImportAlreadyAdded => 'Un compte avec cette adresse existe déjà dans Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Vous vous connecterez avec $provider une fois le compte ajouté, comme dans Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Ajoutez le compte avec un mot de passe d’application (la validation en deux étapes est nécessaire).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird se connecte à Gmail avec Google. « Se connecter avec Google » arrivera dans une prochaine version ; d’ici là, ajoutez le compte avec un mot de passe d’application (la validation en deux étapes est nécessaire).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird se connecte à ce compte dans le navigateur. Loupe ne sait pas encore le faire : utilisez un mot de passe d’application si votre fournisseur en propose.';

  @override
  String get accountImportUnencrypted =>
      'Connexion sans chiffrement. N’utilisez cette option que sur votre propre réseau.';

  @override
  String get accountImportEnterAgain => 'Saisissez-le à nouveau';

  @override
  String get accountImportAdded => 'Ajouté';

  @override
  String accountImportAdding(int index, int total) {
    return 'Ajout de $index sur $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ajouter $count comptes',
      one: 'Ajouter $count compte',
      zero: 'Ajouter des comptes',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Coller le texte d’exportation';

  @override
  String get accountImportPasteText => 'Collez le texte d’un code d’exportation Thunderbird, un code par ligne.';

  @override
  String get accountImportPop3 =>
      'Les comptes POP3 ne sont pas pris en charge. Loupe garde les e-mails sur le serveur avec IMAP.';

  @override
  String get accountImportKerberos => 'Ce compte se connecte avec Kerberos, que Loupe ne prend pas en charge.';

  @override
  String get accountImportNtlm => 'Ce compte se connecte avec NTLM, que Loupe ne prend pas en charge.';

  @override
  String get accountImportClientCertificate =>
      'Ce compte se connecte avec un certificat client, que Loupe ne prend pas encore en charge.';

  @override
  String get accountImportMicrosoftSignIn =>
      'La connexion avec Microsoft arrivera dans une prochaine version. Les comptes Outlook et Microsoft 365 n’acceptent plus les mots de passe des applications de messagerie.';

  @override
  String get accountImportEnterPassword => 'Saisissez le mot de passe.';

  @override
  String get accountImportEnterAppPassword => 'Saisissez le mot de passe d’application.';

  @override
  String get accountImportEnterApiToken => 'Saisissez le jeton d’API.';

  @override
  String get accountImportStorageFailed => 'Loupe n’a pas pu ouvrir le stockage de ses comptes. Réessayez plus tard.';

  @override
  String get accountImportFailed => 'Le compte n’a pas pu être ajouté. Réessayez, ou ajoutez-le manuellement.';

  @override
  String get composeNewMessageTitle => 'Nouveau message';

  @override
  String get composeAttach => 'Joindre';

  @override
  String get composeSendLater => 'Envoyer plus tard';

  @override
  String composeSendAt(String time) {
    return 'Envoyer $time';
  }

  @override
  String get composeSendHint => 'Appuyez longuement pour envoyer plus tard';

  @override
  String get composeNoAccount => 'Ajoutez un compte pour envoyer des e-mails.';

  @override
  String get composeTo => 'À :';

  @override
  String get composeCc => 'Cc :';

  @override
  String get composeBcc => 'Cci :';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Cci, De : $email';
  }

  @override
  String get composeFromLabel => 'De :';

  @override
  String get composeSubjectLabel => 'Objet :';

  @override
  String composeReplyTo(String address) {
    return 'Répondre à : $address';
  }

  @override
  String get composeFrom => 'De';

  @override
  String composeReplyFrom(String email) {
    return 'Répondre depuis $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Envoyer depuis $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Répondre depuis $email ?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Envoyer depuis $email ?';
  }

  @override
  String get composeDismiss => 'Ignorer';

  @override
  String composeAliasNotSaved(String account) {
    return 'Non enregistrée comme identité · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Enregistrer comme identité';

  @override
  String composeAliasSaved(String email) {
    return '$email est enregistrée comme identité.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Adresse non valide $address';
  }

  @override
  String get composeOriginalNotFound => 'Impossible de trouver le message d’origine.';

  @override
  String get composeDraftNotFound => 'Impossible de trouver le brouillon.';

  @override
  String get composeAttachmentsLost => 'Les pièces jointes n’ont pas pu être récupérées. Ajoutez-les de nouveau.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Certaines pièces jointes n’ont pas pu être ajoutées : $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Les pièces jointes totalisent $size ; certains serveurs refusent les messages aussi volumineux.';
  }

  @override
  String get composeAttachFailed => 'Impossible de joindre le fichier.';

  @override
  String get composeInvalidAddressTitle => 'Adresse non valide';

  @override
  String composeInvalidAddress(String address) {
    return '« $address » n’est pas une adresse e-mail valide.';
  }

  @override
  String get composeNoSubjectTitle => 'Sans objet';

  @override
  String get composeNoSubjectText => 'Ce message n’a pas d’objet. L’envoyer quand même ?';

  @override
  String get composeSentBeforeChanges =>
      'Il a été envoyé avant vos modifications, qui sont enregistrées dans Brouillons.';

  @override
  String composeScheduled(String time) {
    return 'Programmé pour $time';
  }

  @override
  String get composeSending => 'Envoi…';

  @override
  String get composeSent => 'Envoyé';

  @override
  String get composeSendFailed => 'Impossible d’envoyer. Réessayez.';

  @override
  String get composeAlreadySent => 'Déjà envoyé.';

  @override
  String get composeDiscardChanges => 'Abandonner les modifications';

  @override
  String get composeSaveChanges => 'Enregistrer les modifications';

  @override
  String get composeDeleteDraft => 'Supprimer le brouillon';

  @override
  String get composeSaveDraft => 'Enregistrer le brouillon';

  @override
  String get composeDraftSaved => 'Brouillon enregistré';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Le $date à $time, $name a écrit :';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Le $date à $time, quelqu’un a écrit :';
  }

  @override
  String get composeForwardHeader => '---------- Message transféré ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'De : $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Date : $date à $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Objet : $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'À : $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc : $addresses';
  }

  @override
  String get composeLaterToday => 'Plus tard aujourd’hui';

  @override
  String get composeTomorrowMorning => 'Demain matin';

  @override
  String get composeMondayMorning => 'Lundi matin';

  @override
  String get composePickDateTime => 'Choisir la date et l’heure…';

  @override
  String get composeSendWithoutDelay => 'Envoyer sans attendre';

  @override
  String composeSendTimeToday(String time) {
    return 'Aujourd’hui à $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Demain à $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day à $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Aujourd’hui $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Demain $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Reprendre la rédaction de votre brouillon ?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Un message n’a pas été envoyé lors de la fermeture de Loupe.',
      'one': 'Un message à $name n’a pas été envoyé lors de la fermeture de Loupe.',
      'other': 'Un message à $name et à d’autres destinataires n’a pas été envoyé lors de la fermeture de Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '« $subject » n’a pas été envoyé lors de la fermeture de Loupe.',
      'one': '« $subject » à $name n’a pas été envoyé lors de la fermeture de Loupe.',
      'other': '« $subject » à $name et à d’autres destinataires n’a pas été envoyé lors de la fermeture de Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Reprendre la rédaction';

  @override
  String get composeRecoverySave => 'Enregistrer dans Brouillons';

  @override
  String get composeRecoveryDiscard => 'Supprimer';

  @override
  String get composeRecoverySaved => 'Enregistré dans Brouillons';

  @override
  String get outboxSectionFailed => 'Non envoyés';

  @override
  String get outboxSectionSending => 'Envoi en cours';

  @override
  String get outboxSectionScheduled => 'Programmés';

  @override
  String get outboxStatusQueued => 'Envoi imminent';

  @override
  String get outboxStatusSending => 'Envoi…';

  @override
  String get outboxStatusFailed => 'Non envoyé';

  @override
  String get outboxNoRecipients => 'Aucun destinataire';

  @override
  String get outboxNoSubject => '(Sans objet)';

  @override
  String get outboxSendingFailed => 'Échec de l’envoi.';

  @override
  String get outboxEmptyTitle => 'Rien à envoyer';

  @override
  String get outboxEmptyText => 'Les messages que vous envoyez plus tard attendent ici jusqu’à l’heure prévue.';

  @override
  String get outboxSendNow => 'Envoyer maintenant';

  @override
  String get outboxReschedule => 'Reprogrammer';

  @override
  String get outboxRescheduleMenu => 'Reprogrammer…';

  @override
  String get outboxRescheduleTitle => 'Reprogrammer';

  @override
  String outboxRescheduled(String time) {
    return 'Reprogrammé pour $time';
  }

  @override
  String get outboxCancel => 'Annuler';

  @override
  String get outboxCancelSending => 'Annuler l’envoi…';

  @override
  String get outboxCancelTitle => 'Annuler l’envoi ?';

  @override
  String get outboxMoveToDrafts => 'Déplacer vers Brouillons';

  @override
  String get outboxDiscard => 'Supprimer le message';

  @override
  String get outboxMovedToDrafts => 'Déplacé vers Brouillons';

  @override
  String get outboxDiscarded => 'Message supprimé';

  @override
  String get outboxAlreadySent => 'Déjà envoyé.';

  @override
  String get outboxBeingSent => 'Ce message est en cours d’envoi.';

  @override
  String get outboxActionFailed => 'L’opération a échoué. Le message est toujours dans la boîte d’envoi.';

  @override
  String get notificationsBadgeInboxes => 'Non lus dans les boîtes de réception';

  @override
  String get notificationsBadgeVip => 'Non lus des VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nouveaux e-mails de vos VIP, dans tous les comptes';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nouveaux e-mails dans $email';
  }

  @override
  String get notificationsUnknownSender => 'Expéditeur inconnu';

  @override
  String get notificationsNoSubject => '(Sans objet)';

  @override
  String get notificationsEncryptedMessage => 'Message chiffré';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nouveau message de $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nouveaux messages',
      many: '$count de nouveaux messages',
      one: '$count nouveau message',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nouveaux messages dans $account';
  }

  @override
  String get platformInstantChannel => 'Réception instantanée';

  @override
  String get platformInstantChannelDescription =>
      'S’affiche quand Loupe surveille l’arrivée de nouveaux e-mails dans vos boîtes de réception';

  @override
  String get platformInstantTitle => 'Surveillance des nouveaux e-mails';

  @override
  String get platformInstantText => 'La réception instantanée est activée';

  @override
  String get platformErrorBox => 'Un problème est survenu lors de l’affichage. Revenez en arrière et réessayez.';

  @override
  String get welcomeTagline => 'Une messagerie simple en surface\net puissante en profondeur.';

  @override
  String get welcomeAccountsTitle => 'Tous vos comptes, une seule boîte de réception sereine';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail et tout serveur IMAP ou JMAP.';

  @override
  String get welcomeSearchTitle => 'Une recherche qui trouve';

  @override
  String get welcomeSearchText => 'Des résultats instantanés sur votre téléphone, puis ceux du serveur.';

  @override
  String get welcomePrivacyTitle => 'Privée dès la conception';

  @override
  String get welcomePrivacyText =>
      'Aucun pistage. Les images distantes restent bloquées tant que vous ne le décidez pas.';

  @override
  String get welcomeAddAccount => 'Ajouter un compte';

  @override
  String get welcomeImport => 'Importer depuis Thunderbird';

  @override
  String get welcomeTryDemo => 'Essayer avec des e-mails de démonstration';
}
