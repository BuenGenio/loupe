// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonDone => 'Fertig';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonMore => 'Mehr';

  @override
  String get commonMove => 'Verschieben';

  @override
  String get commonName => 'Name';

  @override
  String get commonNone => 'Keine';

  @override
  String get commonOff => 'Aus';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'An';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonPassword => 'Passwort';

  @override
  String get commonRemove => 'Entfernen';

  @override
  String get commonRetry => 'Wiederholen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonSearch => 'Suchen';

  @override
  String get commonServer => 'Server';

  @override
  String get commonSettings => 'Einstellungen';

  @override
  String get commonShare => 'Teilen';

  @override
  String get commonTryAgain => 'Erneut versuchen';

  @override
  String get commonUndo => 'Rückgängig';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten',
      one: '$count Nachricht',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archivieren';

  @override
  String get mailDelete => 'Löschen';

  @override
  String get mailFlag => 'Kennzeichnen';

  @override
  String get mailForward => 'Weiterleiten';

  @override
  String get mailMarkAsRead => 'Als gelesen markieren';

  @override
  String get mailMarkAsUnread => 'Als ungelesen markieren';

  @override
  String get mailMoveToJunk => 'In Spam verschieben';

  @override
  String get mailNewMessage => 'Neue Nachricht';

  @override
  String get mailNoSubject => 'Kein Betreff';

  @override
  String get mailReply => 'Antworten';

  @override
  String get mailReplyAll => 'Allen antworten';

  @override
  String get mailSend => 'Senden';

  @override
  String get mailUnflag => 'Kennzeichnung entfernen';

  @override
  String get mailboxArchive => 'Archiv';

  @override
  String get mailboxDrafts => 'Entwürfe';

  @override
  String get mailboxInbox => 'Posteingang';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Postausgang';

  @override
  String get mailboxSent => 'Gesendet';

  @override
  String get mailboxTrash => 'Papierkorb';

  @override
  String get conversationSomethingWentWrong => 'Etwas ist schiefgelaufen. Versuche es erneut.';

  @override
  String get conversationReplyToList => 'An Liste antworten';

  @override
  String get conversationReplyList => 'Antwort an Liste';

  @override
  String get conversationThreadMuted => 'Thread stummgeschaltet. Neue Nachrichten darin kommen als gelesen an.';

  @override
  String get conversationThreadUnmuted => 'Stummschaltung des Threads aufgehoben.';

  @override
  String get conversationLinkFailed => 'Der Link konnte nicht geöffnet werden.';

  @override
  String get conversationGoneTitle => 'Keine Nachricht';

  @override
  String get conversationGoneText => 'Diese Nachricht wurde verschoben oder gelöscht.';

  @override
  String get conversationMuted => 'Stummgeschaltet';

  @override
  String get conversationReaderOptions => 'Leseoptionen';

  @override
  String get conversationReaderOptionsHint => 'Textgröße und Ansicht';

  @override
  String get conversationTrash => 'In den Papierkorb';

  @override
  String get conversationReplyHint => 'Lange drücken für „Allen antworten“ und „Weiterleiten“';

  @override
  String get conversationOfflineTitle => 'Du bist offline';

  @override
  String get conversationOfflineText =>
      'Diese Konversation ist noch nicht heruntergeladen. Sie wird geladen, sobald du wieder online bist.';

  @override
  String get conversationErrorTitle => 'Nachricht kann nicht angezeigt werden';

  @override
  String get conversationErrorText => 'Etwas ist schiefgelaufen.';

  @override
  String get conversationOfflineBanner => 'Du bist offline';

  @override
  String get conversationNotUpdated => 'Nicht aktualisiert';

  @override
  String get conversationMe => 'mich';

  @override
  String get conversationNoSender => '(kein Absender)';

  @override
  String get conversationNoRecipients => 'keine Empfänger';

  @override
  String conversationRecipients(String names) {
    return 'an $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'an $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Von';

  @override
  String get conversationHeaderTo => 'An';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Antwort an';

  @override
  String get conversationHeaderDate => 'Datum';

  @override
  String get conversationHeaderSecurity => 'Sicherheit';

  @override
  String get conversationVerifiedSender => 'Verifizierter Absender';

  @override
  String get conversationUnverifiedSender => 'Nicht verifizierter Absender';

  @override
  String get conversationLoadingMessage => 'Nachricht wird geladen';

  @override
  String get conversationBodyError => 'Diese Nachricht konnte nicht geladen werden.';

  @override
  String get conversationBodyOffline => 'Du bist offline. Die Nachricht wird geladen, sobald du wieder online bist.';

  @override
  String get conversationOriginalHint => 'Sieht in der Ansicht „Original“ besser aus';

  @override
  String get conversationShowOriginal => 'Original anzeigen';

  @override
  String get conversationScrollToTop => 'Nach oben scrollen';

  @override
  String get conversationTagsMenu => 'Schlagwörter…';

  @override
  String get conversationMuteThread => 'Thread stummschalten';

  @override
  String get conversationUnmuteThread => 'Stummschaltung aufheben';

  @override
  String get conversationMoveMenu => 'Verschieben…';

  @override
  String get conversationDeletePermanently => 'Endgültig löschen';

  @override
  String get conversationMoveToTrash => 'In den Papierkorb verschieben';

  @override
  String get conversationNotJunk => 'Kein Spam';

  @override
  String get conversationShowAllHeaders => 'Alle Kopfzeilen anzeigen';

  @override
  String get conversationViewSource => 'Quelltext anzeigen';

  @override
  String get conversationSaveAsFile => 'Als Datei speichern…';

  @override
  String get conversationShareAsFile => 'Als Datei teilen…';

  @override
  String get conversationSearchFromMessageMenu => 'Von dieser Nachricht aus suchen…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Adresse kopieren';

  @override
  String get conversationAddressCopied => 'Adresse kopiert';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Nachrichten von $name suchen';
  }

  @override
  String get conversationTags => 'Schlagwörter';

  @override
  String get conversationAllHeaders => 'Alle Kopfzeilen';

  @override
  String get conversationCopyAll => 'Alles kopieren';

  @override
  String get conversationHeadersCopied => 'Kopfzeilen kopiert';

  @override
  String get conversationNoHeaders => 'Keine Kopfzeilen';

  @override
  String get conversationSearchFromMessageTitle => 'Von dieser Nachricht aus suchen';

  @override
  String conversationSearchFrom(String name) {
    return 'Von $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'An $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Betreff „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Quelltext';

  @override
  String get conversationSourceCopied => 'Quelltext kopiert';

  @override
  String get conversationShareFailed => 'Die Nachricht konnte nicht geteilt werden.';

  @override
  String get conversationWrapLines => 'Zeilen umbrechen';

  @override
  String get conversationDontWrapLines => 'Zeilen nicht umbrechen';

  @override
  String get conversationSourceError => 'Der Quelltext konnte nicht geladen werden.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Angezeigt werden die ersten $shown von $total. Kopiere oder teile den Quelltext, um alles zu erhalten.';
  }

  @override
  String get conversationAttachmentUntitled => 'Unbenannt';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Weitere Aktionen für $name';
  }

  @override
  String get conversationMoveTo => 'Verschieben nach…';

  @override
  String get conversationMailboxesError => 'Postfächer konnten nicht geladen werden.';

  @override
  String get conversationReaderReadable => 'Lesbar';

  @override
  String get conversationReaderOriginal => 'Original';

  @override
  String get conversationReaderPlain => 'Nur Text';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Originalfarben beibehalten';

  @override
  String get conversationReaderRemember => 'Für diesen Absender merken';

  @override
  String get conversationSecurityPossiblePhishing => 'Möglicherweise Phishing';

  @override
  String get conversationSecurityBeCareful => 'Vorsicht';

  @override
  String get conversationSecurityVerified => 'Verifiziert';

  @override
  String get conversationSecurityNoIssues => 'Keine Probleme gefunden';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Tracker', one: '$count Tracker');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Zeigt den Grund';

  @override
  String get conversationPhishingBannerTitle => 'Diese Nachricht sieht nach Phishing aus';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Links und Bilder sind deaktiviert.';
  }

  @override
  String get conversationPhishingBannerText => 'Links und Bilder sind deaktiviert.';

  @override
  String get conversationPhishingWhy => 'Warum?';

  @override
  String get conversationPhishingShowAnyway => 'Trotzdem anzeigen';

  @override
  String get conversationSecurityPhishingTitle => 'Das sieht nach Phishing aus';

  @override
  String get conversationSecurityPhishingText =>
      'Mehrere Anzeichen sprechen dafür, dass diese Nachricht nicht ist, was sie vorgibt.';

  @override
  String get conversationSecurityCarefulTitle => 'Vorsicht bei dieser Nachricht';

  @override
  String get conversationSecurityCarefulText => 'Irgendetwas daran verdient einen zweiten Blick.';

  @override
  String get conversationSecurityVerifiedText => 'Der Absender ist verifiziert und nichts wirkt verdächtig.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nichts wirkt verdächtig. Dein Mailserver hat nicht angegeben, ob der Absender verifiziert ist.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nichts wirkt verdächtig.';

  @override
  String get conversationSecurityWhy => 'Gründe';

  @override
  String get conversationSecurityPrivacy => 'Datenschutz';

  @override
  String get conversationSecurityNoTrackingPixels => 'Keine Tracking-Pixel';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tracking-Pixel entfernt',
      one: '$count Tracking-Pixel entfernt',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Sie hätten dem Absender verraten, wann du diese Nachricht geöffnet hast.';

  @override
  String get conversationSecurityNoRemoteImages => 'Keine externen Bilder';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count externe Bilder',
      one: '$count externes Bild',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Wenn du sie lädst, erfährt der Absender, wann du diese Nachricht liest, und deine IP-Adresse.';

  @override
  String get conversationSecurityNoClickTracking => 'Kein Klick-Tracking';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Links über Klick-Tracker',
      one: '$count Link über Klick-Tracker',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Dein Klick würde von $services erfasst. Drücke lange auf einen Link, um sein Ziel direkt zu öffnen.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Technische Details';

  @override
  String get conversationSecurityCheckedLocally => 'Auf diesem Gerät geprüft. Es wurde nichts verschickt.';

  @override
  String get conversationSecurityTrackersLabel => 'Tracker';

  @override
  String get conversationSecurityImagesFrom => 'Bilder von';

  @override
  String get conversationSecuritySenderHistory => 'Absenderverlauf';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received empfangen, $sent gesendet';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Links führen zu';

  @override
  String get conversationSecurityHidden => 'Versteckt';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements Elemente',
      one: '$elements Element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters Zeichen',
      one: '$characters Zeichen',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Absender nicht verifiziert';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Dein Mailserver konnte nicht bestätigen, dass diese Nachricht wirklich von $domain stammt.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Dein Mailserver konnte nicht bestätigen, dass diese Nachricht wirklich von ihrem Absender stammt.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Dein Mailserver konnte nicht bestätigen, dass diese Nachricht von $domain stammt. Bei Mailinglisten üblich.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Dein Mailserver konnte nicht bestätigen, dass diese Nachricht von ihrem Absender stammt. Bei Mailinglisten üblich.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Reagiere nur darauf, wenn du sie erwartet hast. Kontaktiere den Absender im Zweifel auf anderem Weg.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Von einer anderen Domain signiert';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Die Nachricht ist von $signer signiert, nicht von $domain. Versanddienste machen das, aber es beweist nicht, wer sie geschrieben hat.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Die Nachricht ist von einer anderen Domain signiert, nicht von $domain. Versanddienste machen das, aber es beweist nicht, wer sie geschrieben hat.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Name zeigt eine andere Adresse';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Der Name des Absenders lautet „$shown“, aber die Nachricht kommt von $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Vertraue der Adresse, nicht dem Namen.';

  @override
  String get conversationSecurityReplyToTitle => 'Antworten gehen woandershin';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Eine Antwort würde an $address gehen, nicht an $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Prüfe die Adresse, bevor du mit etwas Persönlichem antwortest.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Verwendet deinen Namen';

  @override
  String get conversationSecurityImpersonationTitle => 'Verwendet den Namen einer Person, die du kennst';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Sie ist mit „$name“ unterschrieben, wie dein eigener Name, kommt aber von einer neuen Adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Sie ist mit „$name“ unterschrieben, wie dein VIP $knownName ($knownEmail), kommt aber von einer neuen Adresse: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Sie ist mit „$name“ unterschrieben, wie $knownName ($knownEmail), kommt aber von einer neuen Adresse: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Und Antworten würden an noch eine andere Adresse gehen.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Wenn sie nach Geld, Codes oder Dateien fragt, frag zuerst auf anderem Weg bei der Person nach.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Bekannte Adresse: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Diese Adresse: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Erste Nachricht von diesem Absender';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Du hast bisher keine Mail von $email erhalten.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Sei vorsichtig mit Anfragen von Personen, die du noch nicht kennst.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Ähnlich aussehende Buchstaben in der Absenderadresse';

  @override
  String get conversationSecurityLinkHomographTitle => 'Ähnlich aussehende Buchstaben in einem Link';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host mischt Buchstaben aus verschiedenen Alphabeten, um eine andere Adresse nachzuahmen.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host verwendet ähnlich aussehende Buchstaben: Es ist nicht $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Lösche sie oder melde sie als Spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Öffne ihn nicht.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domain: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Doppelgänger-Domain';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Verwendet einen bekannten Namen in der Domain';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain sieht aus wie deine eigene Domain $real, ist aber eine andere Domain.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain sieht aus wie $brand ($real), ist aber eine andere Domain.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain verwendet den Namen deiner eigenen Domain $real, gehört aber nicht dazu.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain verwendet den Namen von $brand ($real), gehört aber nicht dazu.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Echte Nachrichten deiner Organisation kommen von $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Echte Nachrichten von $brand kommen von $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Absenderdomain: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imitiert: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Links verbergen ihr Ziel',
      one: 'Ein Link verbirgt sein Ziel',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Ein Link zeigt $shown, öffnet aber $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Melde dich nicht über diese Links an und bezahle nichts darüber. Gib die Adresse stattdessen selbst ein.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Das Ziel eines Links kann nicht geprüft werden';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Ein Link zeigt $shown, läuft aber über $host, das den Klick erfasst, bevor es weiterleitet.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Ein Link führt zu einer reinen IP-Adresse';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts ist keine Website mit Namen. Seriöse Unternehmen verlinken selten so.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Ein getarnter Link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Ein Link beginnt mit „$shown@“, um wie $shown auszusehen, öffnet aber $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Eine versteckte Seite wurde deaktiviert';

  @override
  String get conversationSecurityDataLinkText =>
      'Ein Link hätte eine in der Nachricht verpackte Seite geöffnet, ein Trick, um Linkprüfungen zu umgehen.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Fragt nach einem Passwort';

  @override
  String get conversationSecurityPasswordFieldText => 'Die Nachricht enthielt ein Passwortfeld. Loupe hat es entfernt.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Gib niemals ein Passwort in eine E-Mail ein.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Ein Link, der Code ausführt, wurde deaktiviert';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe führt niemals Code aus Nachrichten aus.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gekürzte Links',
      one: 'Ein gekürzter Link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts verbirgt das echte Ziel, bis du den Link öffnest.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Internationale Webadresse';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts verwendet nicht-lateinische Buchstaben. In vielen Sprachen normal; prüfe, ob es die erwartete Website ist.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Viel versteckter Text';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeichen unsichtbarer Text wurden entfernt. Solcher versteckter Text soll Spamfilter täuschen.',
      one: '$count Zeichen unsichtbarer Text wurde entfernt. Solcher versteckter Text soll Spamfilter täuschen.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Versteckter Text entfernt';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeichen unsichtbarer Text wurden entfernt.',
      one: '$count Zeichen unsichtbarer Text wurde entfernt.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Die Nachricht konnte nicht heruntergeladen werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String exportSaved(String name) {
    return '„$name“ gespeichert';
  }

  @override
  String get exportSaveFailed => 'Die Nachricht konnte nicht gespeichert werden.';

  @override
  String exportFailed(String folder) {
    return '„$folder“ konnte nicht exportiert werden.';
  }

  @override
  String exportEmpty(String folder) {
    return '„$folder“ enthält keine Nachrichten zum Exportieren.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '„$folder“ konnte nicht exportiert werden: Keine Nachricht konnte heruntergeladen werden. Prüfe die Verbindung und versuche es erneut.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$name“ gespeichert, ohne $formattedCount Nachrichten, die nicht heruntergeladen werden konnten.',
      one: '„$name“ gespeichert, ohne eine Nachricht, die nicht heruntergeladen werden konnte.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ konnte nicht gespeichert werden.';
  }

  @override
  String exportTitle(String folder) {
    return '„$folder“ wird exportiert';
  }

  @override
  String get exportListing => 'Nachrichten werden gesucht…';

  @override
  String exportProgress(String current, String total) {
    return '$current von $total wird exportiert…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount Nachrichten konnten nicht heruntergeladen werden',
      one: '1 Nachricht konnte nicht heruntergeladen werden',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Postfächer';

  @override
  String get mailboxesShown => 'Angezeigt';

  @override
  String get mailboxesHidden => 'Ausgeblendet';

  @override
  String get mailboxesCollapse => 'Einklappen';

  @override
  String get mailboxesExpand => 'Ausklappen';

  @override
  String get mailboxesManageVips => 'VIPs verwalten';

  @override
  String get mailboxesSubscriptions => 'Abonnements';

  @override
  String mailboxesShowAccount(String account) {
    return '$account anzeigen';
  }

  @override
  String mailboxesHideAccount(String account) {
    return '$account ausblenden';
  }

  @override
  String get mailboxesExportFolder => 'Ordner exportieren…';

  @override
  String get mailboxesUnpin => 'Nicht mehr anheften';

  @override
  String get mailboxesLists => 'Listen';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Speichere eine Suche, um sie hier abzulegen.';

  @override
  String get mailboxesTags => 'Schlagwörter';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter =>
      'Du kannst auch in einer Nachricht auf den Namen eines Absenders tippen und VIP einschalten.';

  @override
  String get mailboxesAddVip => 'VIP hinzufügen…';

  @override
  String get mailboxesAddVipTitle => 'VIP hinzufügen';

  @override
  String get mailboxesAddVipText => 'Mails von dieser Adresse erhalten einen Stern und erscheinen im VIP-Postfach.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Ungelesen';

  @override
  String get messageListFilterFlagged => 'Gekennzeichnet';

  @override
  String get messageListFilterToMe => 'An: mich';

  @override
  String get messageListFilterCcMe => 'Cc: mich';

  @override
  String get messageListFilterWithAttachments => 'Mit Anhängen';

  @override
  String get messageListFilterUnreplied => 'Unbeantwortet';

  @override
  String get messageListFilterFromVips => 'Von VIPs';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten als gelesen markiert',
      one: '$count Nachricht als gelesen markiert',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Ältere Mails konnten nicht geladen werden.';

  @override
  String get messageListSelectMessages => 'Nachrichten auswählen';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgewählt',
      one: '$count ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Alle auswählen';

  @override
  String get messageListDeselectAll => 'Auswahl aufheben';

  @override
  String get messageListLoadFailed => 'Mails konnten nicht geladen werden';

  @override
  String get messageListNoUnread => 'Keine ungelesenen Mails';

  @override
  String get messageListNoMatches => 'Keine passenden Mails';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Gefiltert nach: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Filter ausschalten';

  @override
  String get messageListEmpty => 'Keine Mails';

  @override
  String get messageListFilter => 'Filter';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filterkriterien: $filters';
  }

  @override
  String get messageListFilteredBy => 'Gefiltert nach:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ungelesen',
      one: '$formattedCount ungelesen',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Markieren';

  @override
  String get messageListTrash => 'In den Papierkorb';

  @override
  String get messageListFilterTitle => 'Filter';

  @override
  String get messageListFilterInclude => 'ANZEIGEN';

  @override
  String get panesHideMailboxes => 'Postfächer ausblenden';

  @override
  String get panesShowMailboxes => 'Postfächer einblenden';

  @override
  String get panesMailboxesWidth => 'Breite der Postfächer';

  @override
  String get panesListWidth => 'Breite der Nachrichtenliste';

  @override
  String get panesNoMessageSelected => 'Keine Nachricht ausgewählt';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten',
      one: '$count Nachricht',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Zurückgestellt';

  @override
  String get snoozeSheetTitle => 'Zurückstellen';

  @override
  String get snoozeLaterToday => 'Später heute';

  @override
  String get snoozeThisEvening => 'Heute Abend';

  @override
  String get snoozeTomorrow => 'Morgen';

  @override
  String get snoozeThisWeekend => 'Dieses Wochenende';

  @override
  String get snoozeNextWeek => 'Nächste Woche';

  @override
  String get snoozePickDateTime => 'Datum und Uhrzeit wählen…';

  @override
  String get snoozeMenu => 'Zurückstellen…';

  @override
  String get snoozeWakeNow => 'Jetzt zurückholen';

  @override
  String get snoozeChangeTimeMenu => 'Zeitpunkt ändern…';

  @override
  String get snoozeChangeTime => 'Zeit ändern';

  @override
  String get snoozeNoTime => 'Keine Zeit festgelegt';

  @override
  String get snoozeFooter =>
      'Zurückgestellte Nachrichten kehren zur gewählten Zeit ungelesen in den Posteingang zurück.';

  @override
  String get snoozeEmptyTitle => 'Nichts zurückgestellt';

  @override
  String get snoozeEmptyText =>
      'Stelle eine Nachricht zurück, damit sie wieder im Posteingang auftaucht, wenn du sie brauchst.';

  @override
  String get appLockUnlock => 'Entsperren';

  @override
  String get appLockFailed => 'Loupe konnte nicht bestätigen, dass du es bist.';

  @override
  String get appLockLockedOut => 'Zu viele Versuche. Versuche es später erneut.';

  @override
  String get appLockPromptError => 'Die Abfrage konnte nicht angezeigt werden. Versuche es erneut.';

  @override
  String get appLockNoScreenLock => 'Dieses Smartphone hat keine Displaysperre.';

  @override
  String get appLockUnlockPromptTitle => 'Loupe entsperren';

  @override
  String get appLockUnlockPromptReason => 'Bestätige, dass du es bist, um deine Mails zu sehen.';

  @override
  String get appLockTurnOnPromptTitle => 'App-Sperre einschalten';

  @override
  String get appLockTurnOnPromptReason => 'Bestätige, dass du es bist, um die App-Sperre einzuschalten.';

  @override
  String get appLockScreenLockRemoved =>
      'Die App-Sperre ist aus: Dieses Smartphone hat keine Displaysperre mehr. Richte eine ein, um die App-Sperre wieder einzuschalten.';

  @override
  String get appLockAfterImmediately => 'Sofort';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Minuten', one: '$count Minute');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Stunden', one: '$count Stunde');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Verschlüsselt';

  @override
  String get openpgpEncryptedInPart => 'Teilweise verschlüsselt';

  @override
  String get openpgpEncryptedLocked => 'Verschlüsselt · gesperrt';

  @override
  String get openpgpEncryptedNoKey => 'Verschlüsselt · kein Schlüssel';

  @override
  String get openpgpEncryptedDamaged => 'Verschlüsselt · beschädigt';

  @override
  String get openpgpEncryptedUnsupported => 'Verschlüsselt · nicht unterstützt';

  @override
  String get openpgpUnknownSigner => 'unbekannt';

  @override
  String get openpgpUnknownKey => 'Unbekannter Schlüssel';

  @override
  String get openpgpSignatureInvalid => 'Signatur ungültig';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Signiert von $name, nicht vom Absender';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Teilweise signiert von $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Signiert von $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Mit einem zurückgewiesenen Schlüssel signiert';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Signiert von $name · Schlüssel nicht akzeptiert';
  }

  @override
  String get openpgpUnlock => 'Entsperren';

  @override
  String get openpgpCantDecrypt => 'Diese Nachricht kann nicht entschlüsselt werden';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Mit OpenPGP verschlüsselt';

  @override
  String get openpgpEncryption => 'Verschlüsselung';

  @override
  String get openpgpDecryptedHere => 'Auf diesem Gerät entschlüsselt';

  @override
  String get openpgpNotDecrypted => 'Nicht entschlüsselt';

  @override
  String get openpgpKeyLocked => 'Dein Schlüssel ist gesperrt.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Für die Schlüssel $keys',
      one: 'Für Schlüssel $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Geschützter Betreff';

  @override
  String get openpgpUnlockKey => 'Schlüssel entsperren';

  @override
  String get openpgpSignature => 'Signatur';

  @override
  String get openpgpFingerprint => 'Fingerabdruck';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Schlüssel-ID $id';
  }

  @override
  String get openpgpSigned => 'Signiert';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Akzeptanz';

  @override
  String get openpgpChangeAcceptance => 'Akzeptanz ändern…';

  @override
  String get openpgpCheckedFooter => 'Auf diesem Gerät mit OpenPGP geprüft, kompatibel mit Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Dein Schlüssel ist gesperrt. Entsperre ihn mit seiner Passphrase, um diese Nachricht zu lesen.';

  @override
  String get openpgpSummaryNoSecretKey =>
      'Sie wurde für einen Schlüssel verschlüsselt, der nicht auf diesem Gerät ist.';

  @override
  String get openpgpSummaryDamaged => 'Die verschlüsselten Daten sind beschädigt oder wurden unterwegs verändert.';

  @override
  String get openpgpSummaryUnsupported => 'Sie verwendet einen Algorithmus, den Loupe nicht unterstützt.';

  @override
  String get openpgpSummaryEncrypted => 'Nur du und die anderen Empfänger können sie lesen.';

  @override
  String get openpgpSummaryNotSigned => 'Sie ist nicht signiert, daher ist der Absender nicht bestätigt.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Sie ist signiert, aber mit einem Schlüssel, den du nicht hast, daher kann die Signatur nicht geprüft werden.';

  @override
  String get openpgpSummaryBadSignature => 'Die Signatur passt nicht: Die Nachricht wurde möglicherweise verändert.';

  @override
  String get openpgpSummaryMismatch =>
      'Die Signatur ist gültig, aber der Schlüssel gehört zu einer anderen Adresse als der des Absenders.';

  @override
  String get openpgpSummaryPartial =>
      'Nur ein Teil der Nachricht ist signiert. Text außerhalb der Signatur (zum Beispiel die Fußzeile einer Mailingliste) wird unter der Zeile „Unsigned content“ angezeigt, und andere Teile der Nachricht, etwa Anhänge, sind ebenfalls nicht abgedeckt.';

  @override
  String get openpgpSummaryOwnKey => 'Mit deinem eigenen Schlüssel signiert.';

  @override
  String get openpgpSummaryVerified =>
      'Die Signatur ist gültig, und du hast den Fingerabdruck des Schlüssels verifiziert.';

  @override
  String get openpgpSummaryUnverified =>
      'Die Signatur ist gültig. Du hast den Schlüssel akzeptiert, ohne seinen Fingerabdruck zu prüfen.';

  @override
  String get openpgpSummaryRejected => 'Die Signatur ist gültig, aber du hast diesen Schlüssel zurückgewiesen.';

  @override
  String get openpgpSummaryUndecided =>
      'Die Signatur ist gültig, aber du hast diesen Schlüssel noch nicht akzeptiert. Vergleiche seinen Fingerabdruck mit dem Absender.';

  @override
  String get openpgpAcceptanceRejected => 'Zurückgewiesen';

  @override
  String get openpgpAcceptanceUndecided => 'Nicht akzeptiert';

  @override
  String get openpgpAcceptanceUnverified => 'Akzeptiert';

  @override
  String get openpgpAcceptanceVerified => 'Akzeptiert und verifiziert';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Schlüssel von $name akzeptieren?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Fingerabdruck $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ja, ich habe den Fingerabdruck verifiziert';

  @override
  String get openpgpAcceptUnverified => 'Ja, ohne Prüfung';

  @override
  String get openpgpAcceptLater => 'Noch nicht';

  @override
  String get openpgpRejectKey => 'Diesen Schlüssel zurückweisen';

  @override
  String get openpgpNoSubject => '(kein Betreff)';

  @override
  String get openpgpEncryptionTitle => 'Ende-zu-Ende-Verschlüsselung';

  @override
  String get openpgpMyKeys => 'Meine OpenPGP-Schlüssel';

  @override
  String get openpgpMyKeysFooter =>
      'Mit einem Schlüssel kannst du verschlüsselte Mails lesen und deine eigenen signieren und verschlüsseln. Du nutzt Thunderbird? Exportiere deinen Schlüssel dort (Konten-Einstellungen › Ende-zu-Ende-Verschlüsselung › Sicherheitskopie für geheimen Schlüssel erstellen) und importiere ihn hier.';

  @override
  String get openpgpAddKey => 'Schlüssel hinzufügen…';

  @override
  String get openpgpAddresses => 'Adressen';

  @override
  String get openpgpAddressesFooter =>
      'Welchen Schlüssel jede Adresse verwendet und wann sie verschlüsselt und signiert.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP-Schlüssel deiner Kontakte';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Akzeptiere einen Schlüssel, sobald du darauf vertraust, dass er seinem Besitzer gehört; vergleiche den Fingerabdruck mit ihm, um ihn als verifiziert zu markieren.';

  @override
  String get openpgpImportPublicKey => 'Öffentlichen Schlüssel importieren…';

  @override
  String get openpgpCollected => 'Über Autocrypt gesammelt';

  @override
  String get openpgpCollectedFooter =>
      'Schlüssel, die mit Nachrichten angekommen sind. Loupe kann an sie verschlüsseln, wenn beide Seiten es wünschen.';

  @override
  String get openpgpOnThisDevice => 'Auf diesem Gerät';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Verschlüsselte Nachrichten verbergen ihren Betreff. Loupe speichert den Betreff jeder Nachricht, die du öffnest, in seiner verschlüsselten Datenbank auf diesem Gerät, damit Liste, Suche und Benachrichtigungen ihn anzeigen. Im Hintergrund kann Loupe mit Schlüsseln ohne Passphrase auch die Betreffs neuer Nachrichten entschlüsseln; dazu lädt es jede Nachricht (bis zu 1 MB) herunter.';

  @override
  String get openpgpDecryptSubjects => 'Betreffs im Hintergrund entschlüsseln';

  @override
  String get openpgpIndexFooter =>
      'Die Suche findet verschlüsselte Nachrichten über Absender, Empfänger und Betreff. Ist dies eingeschaltet, nimmt Loupe außerdem den Text jeder verschlüsselten Nachricht, die es entschlüsselt, in den Suchindex seiner verschlüsselten Datenbank auf diesem Gerät auf, sodass die Suche sie auch über ihren Text findet. Beim Ausschalten wird dieser Text aus dem Index entfernt.';

  @override
  String get openpgpIndexDecrypted => 'Entschlüsselte Nachrichten für die Suche indexieren';

  @override
  String get openpgpPassphrases => 'Passphrasen';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP-Schlüssel und S/MIME-Zertifikate, die du mit einer Passphrase schützt, werden bei Bedarf entsperrt. Ohne „Passphrasen merken“ werden sie zwei Minuten nach jeder Verwendung wieder gesperrt.';

  @override
  String get openpgpRememberPassphrases => 'Passphrasen merken';

  @override
  String get openpgpRememberPassphrasesDetail => 'Bis Loupe geschlossen wird';

  @override
  String get openpgpLockKeysNow => 'Schlüssel jetzt sperren';

  @override
  String get openpgpKeysLocked => 'Schlüssel gesperrt.';

  @override
  String get openpgpKeyStateRevoked => 'widerrufen';

  @override
  String get openpgpKeyStateExpired => 'abgelaufen';

  @override
  String get openpgpKeyStateNeverExpires => 'läuft nie ab';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'läuft ab am $date';
  }

  @override
  String get openpgpNoKey => 'Kein Schlüssel';

  @override
  String get openpgpAlwaysEncrypt => 'Immer verschlüsseln';

  @override
  String get openpgpAddKeyTitle => 'OpenPGP-Schlüssel hinzufügen';

  @override
  String get openpgpAddKeyMessage =>
      'Importiere den Schlüssel, den du in Thunderbird verwendest, oder erzeuge einen neuen.';

  @override
  String get openpgpImportFromClipboard => 'Aus der Zwischenablage importieren';

  @override
  String get openpgpImportFromFile => 'Aus Datei importieren';

  @override
  String get openpgpGenerateNewKey => 'Neuen Schlüssel erzeugen';

  @override
  String get openpgpImportPublicKeyTitle => 'Öffentlichen Schlüssel importieren';

  @override
  String get openpgpFromClipboard => 'Aus der Zwischenablage';

  @override
  String get openpgpFromFile => 'Aus Datei';

  @override
  String get openpgpClipboardEmpty => 'Die Zwischenablage ist leer. Kopiere zuerst den Schlüssel.';

  @override
  String get openpgpKey => 'Schlüssel';

  @override
  String get openpgpValidityRevoked => 'Widerrufen';

  @override
  String openpgpValidityExpired(String date) {
    return 'Abgelaufen am $date';
  }

  @override
  String get openpgpNeverExpires => 'Läuft nie ab';

  @override
  String openpgpValidUntil(String date) {
    return 'Gültig bis $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Fingerabdruck kopiert.';

  @override
  String get openpgpAlgorithm => 'Algorithmus';

  @override
  String get openpgpCreated => 'Erstellt';

  @override
  String get openpgpValidity => 'Gültigkeit';

  @override
  String get openpgpProtection => 'Schutz';

  @override
  String get openpgpProtectionPassphrase => 'Passphrase';

  @override
  String get openpgpProtectionKeychain => 'Nur Schlüsselbund';

  @override
  String get openpgpKeyDetailsFooter =>
      'Teile deinen öffentlichen Schlüssel, damit andere an dich verschlüsseln können. Die Sicherheitskopie ist dein geheimer Schlüssel, geschützt durch seine Passphrase, falls er eine hat: Halte sie privat.';

  @override
  String get openpgpSharePublicKey => 'Öffentlichen Schlüssel teilen';

  @override
  String get openpgpCopyPublicKey => 'Öffentlichen Schlüssel kopieren';

  @override
  String get openpgpPublicKeyCopied => 'Öffentlicher Schlüssel kopiert.';

  @override
  String get openpgpBackUpSecretKey => 'Geheimen Schlüssel sichern';

  @override
  String get openpgpDeleteKey => 'Schlüssel löschen';

  @override
  String get openpgpRemoveKey => 'Schlüssel entfernen';

  @override
  String get openpgpBackUpTitle => 'Geheimen Schlüssel sichern?';

  @override
  String get openpgpBackUpProtected =>
      'Die Sicherheitskopie ist durch die Passphrase deines Schlüssels geschützt. Wer beides hat, kann deine Mails lesen.';

  @override
  String get openpgpBackUpUnprotected =>
      'Dieser Schlüssel hat keine Passphrase: Wer die Sicherheitskopie hat, kann deine Mails lesen und in deinem Namen signieren.';

  @override
  String get openpgpBackUp => 'Sichern';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Deinen Schlüssel $name löschen?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Schlüssel von $name entfernen?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Mails, die an diesen Schlüssel verschlüsselt sind, können auf diesem Gerät nicht mehr gelesen werden, es sei denn, du importierst ihn erneut.';

  @override
  String get openpgpRemoveKeyMessage => 'Du kannst ihn später erneut importieren.';

  @override
  String get openpgpKeyHeader => 'OpenPGP-Schlüssel';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Füge unter „Ende-zu-Ende-Verschlüsselung“ einen Schlüssel hinzu, um Mails von dieser Adresse zu verschlüsseln und zu signieren.';

  @override
  String get openpgpGenerateAKey => 'Schlüssel erzeugen…';

  @override
  String get openpgpSending => 'Senden';

  @override
  String get openpgpSendingFooter =>
      'Die automatische Verschlüsselung schaltet sich ein, wenn jeder Empfänger einen akzeptierten Schlüssel oder ein vertrauenswürdiges Zertifikat hat oder wenn Autocrypt meldet, dass beide Seiten es wünschen. Verschlüsselte Mails werden immer signiert.';

  @override
  String get openpgpEncryptAutomatically => 'Automatisch verschlüsseln';

  @override
  String get openpgpAlwaysEncryptDetail => 'Verweigert das Senden, wenn ein Empfänger keinen Schlüssel hat';

  @override
  String get openpgpSignUnencrypted => 'Unverschlüsselte Mails signieren';

  @override
  String get openpgpAttachPublicKey => 'Meinen öffentlichen Schlüssel anhängen';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt sendet deinen öffentlichen Schlüssel mit jeder Nachricht mit, sodass andere Apps ohne Einrichtung an dich verschlüsseln können.';

  @override
  String get openpgpSendMyKey => 'Meinen Schlüssel mit Mails senden';

  @override
  String get openpgpPreferEncryption => 'Verschlüsselung bevorzugen';

  @override
  String get openpgpPreferEncryptionDetail => 'Andere bitten, wenn möglich zu verschlüsseln';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Jahre', one: '$count Jahr');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Die Passphrasen stimmen nicht überein.';

  @override
  String openpgpKeyReady(String id) {
    return 'Dein Schlüssel $id ist bereit.';
  }

  @override
  String get openpgpNewKey => 'Neuer Schlüssel';

  @override
  String get openpgpNewKeyFor => 'Für';

  @override
  String get openpgpYourName => 'Dein Name';

  @override
  String get openpgpAddress => 'Adresse';

  @override
  String get openpgpPassphrase => 'Passphrase';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Optional. Ohne Passphrase schützt allein der Schlüsselbund deines Smartphones den Schlüssel, und Loupe fragt nie danach. Mit Passphrase fragt Loupe danach, wenn der Schlüssel gebraucht wird.';

  @override
  String get openpgpRepeatPassphrase => 'Wiederholen';

  @override
  String get openpgpExpires => 'Ablauf';

  @override
  String get openpgpExpiresFooter =>
      'Du kannst einen neuen Schlüssel erzeugen, bevor er abläuft. Thunderbird verwendet ebenfalls drei Jahre.';

  @override
  String get openpgpGenerateKey => 'Schlüssel erzeugen';

  @override
  String get openpgpKeyFor => 'Schlüssel für';

  @override
  String get openpgpCantEncrypt => 'Verschlüsseln nicht möglich';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Für $names gibt es keinen OpenPGP-Schlüssel, und diese Adresse verschlüsselt immer. Entferne den Empfänger oder importiere den Schlüssel unter Einstellungen › Ende-zu-Ende-Verschlüsselung.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Für $names gibt es kein gültiges S/MIME-Zertifikat, und diese Adresse verschlüsselt immer. Entferne den Empfänger oder importiere das Zertifikat unter Einstellungen › Ende-zu-Ende-Verschlüsselung.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Für $names gibt es keinen OpenPGP-Schlüssel.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Für $names gibt es kein gültiges S/MIME-Zertifikat.';
  }

  @override
  String get openpgpSendUnencrypted => 'Unverschlüsselt senden';

  @override
  String get openpgpCantSign => 'Signieren nicht möglich';

  @override
  String get openpgpCantSignMessage =>
      'Der private Schlüssel deines S/MIME-Zertifikats ist nicht auf diesem Gerät. Importiere das Zertifikat erneut (eine .p12- oder .pfx-Datei) unter Einstellungen › Ende-zu-Ende-Verschlüsselung.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Kein Schlüssel für $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Kein Zertifikat für $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Schlüssel aus Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Alle haben einen Schlüssel';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Alle haben ein Zertifikat';

  @override
  String get openpgpComposeEncrypt => 'Verschlüsseln';

  @override
  String get openpgpComposeSign => 'Signieren';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, wechseln';
  }

  @override
  String get openpgpNoKeyFound => 'Kein OpenPGP-Schlüssel gefunden.';

  @override
  String get openpgpImportSecretKeyTitle => 'Geheimen Schlüssel importieren?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Dieser Anhang enthält einen geheimen Schlüssel ($names). Importiere ihn nur dann als deinen eigenen Schlüssel, wenn du ihn selbst exportiert hast, zum Beispiel aus Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Als meinen Schlüssel importieren';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'dein Schlüssel $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schlüssel importieren ($names)?',
      one: 'Schlüssel von $names importieren?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importieren und akzeptieren';

  @override
  String get openpgpImportDecideLater => 'Importieren, später entscheiden';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'Schlüssel von $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Importiert: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP-Schlüssel sind angehängt.',
      one: 'Ein OpenPGP-Schlüssel ist angehängt.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importieren';

  @override
  String get openpgpUnlockKeyTitle => 'OpenPGP-Schlüssel entsperren';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Gib die Passphrase des Schlüssels von $name ($id) ein.';
  }

  @override
  String get openpgpWrongPassphrase => 'Diese Passphrase ist falsch. Versuche es erneut.';

  @override
  String get openpgpExplainLocked =>
      'Diese Nachricht ist verschlüsselt. Entsperre deinen OpenPGP-Schlüssel, um sie zu lesen.';

  @override
  String get openpgpExplainNoKey =>
      'Diese Nachricht ist verschlüsselt, aber für keinen OpenPGP-Schlüssel auf diesem Gerät. Wenn du sie in Thunderbird liest, importiere deinen Schlüssel von dort: Einstellungen › Ende-zu-Ende-Verschlüsselung.';

  @override
  String get openpgpExplainDamaged =>
      'Diese verschlüsselte Nachricht ist beschädigt und kann daher nicht sicher entschlüsselt werden.';

  @override
  String get openpgpExplainUnsupported =>
      'Diese Nachricht verwendet eine Verschlüsselung, die Loupe noch nicht lesen kann.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Diese Nachricht ist mit S/MIME verschlüsselt, aber für kein Zertifikat auf diesem Gerät. Importiere dein Zertifikat (eine .p12- oder .pfx-Datei) unter Einstellungen › Ende-zu-Ende-Verschlüsselung.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Diese Nachricht ist verschlüsselt. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Entsperre dein S/MIME-Zertifikat, um sie zu lesen.';

  @override
  String get openpgpAttachmentGone => 'Dieser Anhang ist nicht mehr verfügbar.';

  @override
  String get smimeEncrypted => 'Verschlüsselt (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Verschlüsselt (S/MIME) · kein Zertifikat';

  @override
  String get smimeEncryptedDamaged => 'Verschlüsselt (S/MIME) · beschädigt';

  @override
  String get smimeEncryptedUnsupported => 'Verschlüsselt (S/MIME) · nicht unterstützt';

  @override
  String get smimeEncryptedLocked => 'Verschlüsselt (S/MIME) · gesperrt';

  @override
  String get smimeUnknownSigner => 'unbekannt';

  @override
  String get smimeSignatureModified => 'Signatur ungültig: Nachricht verändert';

  @override
  String get smimeSignatureWeak => 'Signatur unsicher: veralteter Algorithmus';

  @override
  String get smimeSignatureUncheckable => 'Signatur kann nicht geprüft werden';

  @override
  String get smimeSignedCertificateMissing => 'Signiert · Zertifikat fehlt';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Signiert von $name · Zertifikat widerrufen';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Signiert von $name · zu einem anderen Datum';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Signiert von $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Signiert von $name · ungültiges Zertifikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Signiert von $name · nicht vertrauenswürdig';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Signiert von $name · Zertifikat abgelaufen';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Signiert von $name · Zertifikat noch nicht gültig';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Signiert von $name · Zertifikat nicht für Mail';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Signiert von $name, nicht vom Absender';
  }

  @override
  String get smimeCantDecrypt => 'Diese Nachricht kann nicht entschlüsselt werden';

  @override
  String get smimeEncryptedWithSmime => 'Mit S/MIME verschlüsselt';

  @override
  String get smimeEncryption => 'Verschlüsselung';

  @override
  String get smimeDecryptedHere => 'Auf diesem Gerät entschlüsselt';

  @override
  String get smimeNotDecrypted => 'Nicht entschlüsselt';

  @override
  String get smimeAuthenticated => 'authentifiziert';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'für $count Zertifikate',
      one: 'für $count Zertifikat',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Signatur';

  @override
  String get smimeIssuedBy => 'Ausgestellt von';

  @override
  String get smimeValid => 'Gültig';

  @override
  String smimeValidRange(String from, String to) {
    return '$from bis $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256-Fingerabdruck';

  @override
  String get smimeSigned => 'Signiert';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Widerruf wird geprüft…';

  @override
  String get smimeNotRevoked => 'Nicht widerrufen';

  @override
  String get smimeRevoked => 'Widerrufen';

  @override
  String get smimeRevocationUnknown => 'Widerrufsstatus unbekannt';

  @override
  String smimeRevokedSince(String date) {
    return 'Seit $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Bei der Zertifizierungsstelle angefragt (Sperrliste), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Bei der Zertifizierungsstelle angefragt (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return '„$name“ vertrauen…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Diesem Zertifikat vertrauen…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Auf diesem Gerät mit S/MIME geprüft, kompatibel mit Outlook und Thunderbird; Widerruf bei der Zertifizierungsstelle.';

  @override
  String get smimeCheckedFooter =>
      'Auf diesem Gerät mit S/MIME geprüft, kompatibel mit Outlook und Thunderbird. Der Widerruf wird nicht geprüft (Einstellungen › Ende-zu-Ende-Verschlüsselung).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return '$name für Mails vertrauen?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Dem Zertifikat von $name vertrauen?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Jedem Zertifikat, das diese Stelle ausstellt, wird vertraut, wie bei der Zertifizierungsstelle deines Unternehmens. Vergleiche zuerst den Fingerabdruck mit dem Besitzer:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Vergleiche zuerst den Fingerabdruck mit dem Besitzer:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Vertrauen';

  @override
  String get smimeSummaryNoKey => 'Sie wurde für ein Zertifikat verschlüsselt, das nicht auf diesem Gerät ist.';

  @override
  String get smimeSummaryDamaged => 'Die verschlüsselten Daten sind beschädigt oder wurden unterwegs verändert.';

  @override
  String get smimeSummaryUnsupported => 'Sie verwendet einen Algorithmus, den Loupe nicht unterstützt.';

  @override
  String get smimeSummaryLocked => 'Dein S/MIME-Zertifikat ist gesperrt.';

  @override
  String get smimeSummaryEncrypted => 'Nur du und die anderen Empfänger können sie lesen.';

  @override
  String get smimeSummaryNotSigned => 'Sie ist nicht signiert, daher ist der Absender nicht bestätigt.';

  @override
  String get smimeSummaryModified => 'Die Signatur passt nicht: Die Nachricht wurde nach dem Signieren verändert.';

  @override
  String get smimeSummaryUncheckable => 'Die Signatur kann nicht geprüft werden.';

  @override
  String get smimeSummaryNoCertificate =>
      'Das Zertifikat des Unterzeichners ist nicht in der Nachricht enthalten und kann daher nicht geprüft werden.';

  @override
  String get smimeSummaryRevoked =>
      'Die Zertifizierungsstelle hat das Zertifikat des Unterzeichners widerrufen: Der Signatur kann nicht vertraut werden.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Die Zertifizierungsstelle hat das Zertifikat des Unterzeichners widerrufen ($reason): Der Signatur kann nicht vertraut werden.';
  }

  @override
  String get smimeDateMismatch =>
      'Sie wurde mehr als eine Stunde vor oder nach dem Datum der Nachricht signiert: Es könnte eine alte, erneut gesendete Nachricht sein.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Die Signatur ist gültig, und $issuer bürgt dafür, dass das Zertifikat dem Absender gehört.';
  }

  @override
  String get smimeProblemInvalidChain => 'Das Zertifikat oder einer seiner Aussteller ist ungültig.';

  @override
  String get smimeProblemUntrusted => 'Das Zertifikat stammt von einer Stelle, der Loupe nicht vertraut.';

  @override
  String get smimeProblemExpired => 'Das Zertifikat war abgelaufen.';

  @override
  String get smimeProblemNotYetValid => 'Das Zertifikat war noch nicht gültig.';

  @override
  String get smimeProblemWrongUsage => 'Das Zertifikat ist nicht für Mails gedacht.';

  @override
  String get smimeProblemWrongAddress => 'Das Zertifikat gehört zu einer anderen Adresse als der des Absenders.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Vertrauenswürdig · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Nicht vertrauenswürdig · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Abgelaufen am $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Gültig ab $date';
  }

  @override
  String get smimeTrustInvalid => 'Ungültig';

  @override
  String get smimeTrustNotForMail => 'Nicht für Mail';

  @override
  String get smimeTrustAnotherAddress => 'Andere Adresse';

  @override
  String get smimeMyCertificates => 'Meine S/MIME-Zertifikate';

  @override
  String get smimeMyCertificatesFooter =>
      'Für S/MIME, wie es Outlook und viele Unternehmen nutzen. Importiere dein Zertifikat mit seinem privaten Schlüssel (eine .p12- oder .pfx-Datei), exportiert aus Outlook, Windows, macOS oder Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Für S/MIME, wie es Outlook und viele Unternehmen nutzen. Importiere dein Zertifikat mit seinem privaten Schlüssel (eine .p12- oder .pfx-Datei), exportiert aus Outlook, Windows, macOS oder Thunderbird, oder verwende eines, das dein Unternehmen oder du auf diesem Gerät installiert hast.';

  @override
  String get smimeCertificateExpired => 'abgelaufen';

  @override
  String smimeCertificateUntil(String date) {
    return 'bis $date';
  }

  @override
  String get smimeCertificateOnDevice => 'auf diesem Gerät';

  @override
  String get smimeImportCertificateEllipsis => 'Zertifikat importieren…';

  @override
  String get smimeUseDeviceCertificate => 'Zertifikat von diesem Gerät verwenden…';

  @override
  String get smimeCorrespondentsCertificates => 'Zertifikate deiner Kontakte';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Aus signierten Mails gesammelt, wie es Outlook und Thunderbird tun. Mails werden nur an vertrauenswürdige Zertifikate verschlüsselt: Loupe vertraut den Zertifizierungsstellen, denen Mozilla für E-Mail vertraut, und denen, die du hinzufügst.';

  @override
  String get smimeRevocation => 'Widerruf';

  @override
  String get smimeRevocationFooter =>
      'Wenn du eine signierte Mail öffnest, fragt Loupe bei der Zertifizierungsstelle, die das Zertifikat des Unterzeichners ausgestellt hat, nach, ob es widerrufen wurde (über ihren OCSP-Responder oder ihre Sperrliste). Die Stelle kann dann sehen, wann jemand unter deiner Internetadresse eine mit diesem Zertifikat signierte Mail liest. Die Antworten bleiben bis zu ihrem Ablauf auf diesem Gerät gespeichert. Ein widerrufenes Zertifikat wird in der Kopfzeile der Nachricht als „Widerrufen“ angezeigt.';

  @override
  String get smimeCheckRevocation => 'Zertifikatswiderruf online prüfen';

  @override
  String get smimeTrustedAuthorities => 'Vertrauenswürdige Zertifizierungsstellen';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Von dir als vertrauenswürdig eingestuft, zusätzlich zu den $count Stellen, denen Mozilla für E-Mail vertraut.',
      one: 'Von dir als vertrauenswürdig eingestuft, zusätzlich zu der $count Stelle, der Mozilla für E-Mail vertraut.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Zertifizierungsstelle';

  @override
  String get smimeImportACertificate => 'Zertifikat importieren';

  @override
  String get smimeImportContactMessage =>
      'Das Zertifikat eines Kontakts (.cer, .crt, .pem) oder einer Zertifizierungsstelle.';

  @override
  String get smimeFromClipboard => 'Aus der Zwischenablage';

  @override
  String get smimeFromFile => 'Aus Datei';

  @override
  String get smimeClipboardEmpty => 'Die Zwischenablage ist leer. Kopiere zuerst das Zertifikat.';

  @override
  String get smimeCertificate => 'Zertifikat';

  @override
  String get smimeOnDeviceFooter =>
      'Sein privater Schlüssel bleibt im Anmeldedatenspeicher von Android, wo dein Unternehmen oder du ihn installiert hat: Loupe bittet Android, damit zu signieren und zu entschlüsseln. Signierte Mails werden beim Senden signiert.';

  @override
  String get smimeAddresses => 'Adressen';

  @override
  String get smimeUsage => 'Für';

  @override
  String get smimeUsageNone => 'Nichts, was Loupe nutzt';

  @override
  String get smimeUsageSigning => 'Signieren';

  @override
  String get smimeUsageEncryption => 'Verschlüsselung';

  @override
  String get smimeUsageCertificates => 'Zertifikate';

  @override
  String get smimeAlgorithm => 'Algorithmus';

  @override
  String get smimeSerialNumber => 'Seriennummer';

  @override
  String get smimeFingerprintCopied => 'Fingerabdruck kopiert.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1-Fingerabdruck';

  @override
  String get smimePrivateKey => 'Privater Schlüssel';

  @override
  String get smimeKeyOnDevice => 'Auf diesem Gerät';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'In Loupe, mit Passphrase';

  @override
  String get smimeKeyInLoupe => 'In Loupe';

  @override
  String get smimeSource => 'Herkunft';

  @override
  String get smimeSourceSignedMail => 'Signierte Mail';

  @override
  String get smimeSourceImported => 'Importiert';

  @override
  String get smimeTrustHeader => 'Vertrauen';

  @override
  String get smimeTrustedRoot => 'Vertrauenswürdige Stammstelle';

  @override
  String get smimeIssuer => 'Aussteller';

  @override
  String smimeTrustNamed(String name) {
    return '„$name“ vertrauen';
  }

  @override
  String get smimeTrustThisAuthority => 'Dieser Stelle vertrauen';

  @override
  String get smimeTrustThisCertificate => 'Diesem Zertifikat vertrauen';

  @override
  String get smimeStopTrusting => 'Nicht mehr vertrauen';

  @override
  String get smimePassphrase => 'Passphrase';

  @override
  String get smimePassphraseFooter =>
      'Optional. Mit einer Passphrase wird der private Schlüssel auf diesem Gerät zusätzlich verschlüsselt (Argon2id und AES-256), und Loupe fragt zum Signieren und Entschlüsseln danach; „Passphrasen merken“ legt fest, wie lange. Mails, die du sendest, werden beim Senden signiert; Hintergrundaufgaben können den Schlüssel nicht verwenden.';

  @override
  String get smimeChangePassphrase => 'Passphrase ändern…';

  @override
  String get smimeSetPassphraseEllipsis => 'Passphrase festlegen…';

  @override
  String get smimeRemovePassphrase => 'Passphrase entfernen';

  @override
  String get smimeShareCertificate => 'Zertifikat teilen';

  @override
  String get smimeDeleteCertificate => 'Zertifikat löschen';

  @override
  String get smimeRemoveCertificate => 'Zertifikat entfernen';

  @override
  String get smimePassphraseChanged => 'Passphrase geändert.';

  @override
  String get smimePassphraseSet => 'Passphrase festgelegt.';

  @override
  String get smimeRemovePassphraseTitle => 'Passphrase entfernen?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Der private Schlüssel ist dann nur noch durch den Schlüsselbund geschützt, wie ohne Passphrase: Loupe fragt nicht mehr danach, und Hintergrundaufgaben können ihn verwenden.';

  @override
  String get smimePassphraseRemoved => 'Passphrase entfernt.';

  @override
  String smimeTrustTitle(String name) {
    return '$name vertrauen?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Jedem Zertifikat, das sie ausstellt, wird für Mails vertraut. Vergleiche zuerst den Fingerabdruck mit dem Besitzer:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Dein Zertifikat $name löschen?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Zertifikat von $name entfernen?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe verwendet es nicht mehr: Mails, die dafür verschlüsselt sind, können in Loupe nicht mehr gelesen werden. Das Zertifikat bleibt auf diesem Gerät (Einstellungen › Sicherheit › Verschlüsselung und Anmeldedaten).';

  @override
  String get smimeDeleteOwnMessage =>
      'Sein privater Schlüssel wird von diesem Gerät gelöscht: Mails, die dafür verschlüsselt sind, können hier nicht mehr gelesen werden, es sei denn, du importierst es erneut.';

  @override
  String get smimeRemoveContactMessage => 'Es kommt mit der nächsten signierten Nachricht dieser Person zurück.';

  @override
  String get smimeAddressImportFooter =>
      'Importiere ein Zertifikat für diese Adresse, um wie Outlook mit S/MIME zu signieren und zu verschlüsseln.';

  @override
  String get smimeImportACertificateEllipsis => 'Zertifikat importieren…';

  @override
  String get smimePreferFooter =>
      'Wenn beide eine Nachricht schützen könnten, wird das bevorzugte verwendet, es sei denn, nur das andere hat einen Schlüssel oder ein Zertifikat für jeden Empfänger.';

  @override
  String get smimePreferSmime => 'S/MIME bevorzugen';

  @override
  String get smimePreferSmimeDetail => 'Statt OpenPGP';

  @override
  String get smimeCertificatePassword => 'Zertifikatspasswort';

  @override
  String get smimeCertificatePasswordPrompt => 'Gib das Passwort ein, mit dem die Zertifikatsdatei exportiert wurde.';

  @override
  String get smimeImport => 'Importieren';

  @override
  String get smimeWrongPassword => 'Dieses Passwort ist falsch. Versuche es erneut.';

  @override
  String get smimeNoCertificateFound => 'Kein Zertifikat gefunden.';

  @override
  String smimeCertificateOf(String name) {
    return 'Zertifikat von $name';
  }

  @override
  String get smimeNothingNew => 'Nichts Neues zu importieren.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Importiert: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vertrauenswürdige Zertifizierungsstellen importiert.',
      one: 'Eine vertrauenswürdige Zertifizierungsstelle importiert.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Importiert: $certificates und $count vertrauenswürdige Zertifizierungsstellen.',
      one: 'Importiert: $certificates und eine vertrauenswürdige Zertifizierungsstelle.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Diese Datei enthält keinen privaten Schlüssel. Exportiere dein Zertifikat mit seinem privaten Schlüssel.';

  @override
  String get smimeImportAsYoursTitle => 'Als dein Zertifikat importieren?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Dieser Anhang enthält ein Zertifikat mit seinem privaten Schlüssel: $names. Importiere es nur, wenn du es selbst exportiert hast, zum Beispiel aus Outlook oder Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Als mein Zertifikat importieren';

  @override
  String smimeImportedOwn(String names) {
    return 'Dein Zertifikat $names wurde importiert.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Dein Zertifikat $name ($addresses) wurde von diesem Gerät hinzugefügt.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return '„$name“ für Mails vertrauen?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe kennt diese Zertifizierungsstelle nicht (vielleicht die eigene eines Unternehmens). Vertraue ihr, um die von ihr ausgestellten Zertifikate zu prüfen. Vergleiche zuerst ihren Fingerabdruck mit deiner IT-Abteilung:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zertifikate sind angehängt.',
      one: 'Ein Zertifikat ist angehängt.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Zertifikat importieren';

  @override
  String get smimeUnlockTitle => 'S/MIME-Zertifikat entsperren';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Gib die Passphrase des Zertifikats von $name ($addresses) ein.';
  }

  @override
  String get smimeWrongPassphrase => 'Diese Passphrase ist falsch. Versuche es erneut.';

  @override
  String get smimeUnlock => 'Entsperren';

  @override
  String get smimeEnterAPassphrase => 'Gib eine Passphrase ein.';

  @override
  String get smimePassphrasesDiffer => 'Die beiden Passphrasen unterscheiden sich.';

  @override
  String get smimeSetPassphraseTitle => 'Passphrase festlegen';

  @override
  String get smimeSetPassphraseText =>
      'Loupe fragt zum Signieren und Entschlüsseln danach. Wenn du sie vergisst, importiere das Zertifikat erneut aus seiner .p12-Datei.';

  @override
  String get smimePassphraseAgain => 'Wiederholen';

  @override
  String get smimeSetPassphraseButton => 'Festlegen';

  @override
  String get smimeLockedOpenAgain =>
      'Dein S/MIME-Zertifikat ist gesperrt. Öffne die Nachricht erneut, um es zu entsperren.';

  @override
  String get smimeDeviceHasNoCertificates => 'Dieses Gerät stellt seine Zertifikate nicht bereit.';

  @override
  String get smimeCantReadCertificate => 'Loupe kann dieses Zertifikat nicht lesen.';

  @override
  String get smimeCertificateNotForMail =>
      'Dieses Zertifikat ist nicht für Mails: Es hat keine E-Mail-Adresse oder ist nicht zum Signieren oder Verschlüsseln gedacht.';

  @override
  String get smimeDeviceCertificateGone =>
      'Das Zertifikat ist nicht mehr auf diesem Gerät, oder Loupe darf es nicht mehr verwenden. Wähle es unter Einstellungen › Ende-zu-Ende-Verschlüsselung erneut aus.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Das Zertifikat auf diesem Gerät kann nur verwendet werden, während Loupe geöffnet ist.';

  @override
  String get smimeDeviceKeyDamaged => 'Der verschlüsselte Schlüssel ist beschädigt.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Das Zertifikat auf diesem Gerät kann das nicht: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nicht unterstützt';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Das Zertifikat auf diesem Gerät ist fehlgeschlagen: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Die Adresse der Zertifizierungsstelle ist keine Webadresse.';

  @override
  String get smimeAuthorityTimeout => 'Die Zertifizierungsstelle hat nicht rechtzeitig geantwortet.';

  @override
  String get smimeAuthorityUnreachable => 'Die Zertifizierungsstelle war nicht erreichbar.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Die Zertifizierungsstelle hat mit $status geantwortet.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Die Antwort der Zertifizierungsstelle ist zu groß.';

  @override
  String get smimeRevocationNotChecked =>
      'Nicht geprüft: Nur Zertifikate von Stellen, denen Loupe vertraut, werden geprüft.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Wie Smartphone';

  @override
  String get settingsLanguageFooter =>
      'Loupe verwendet die Sprache deines Smartphones, wenn es sie hat, und sonst Englisch. Die Sprache, die du hier wählst, gilt nur für Loupe, Benachrichtigungen eingeschlossen.';

  @override
  String get settingsAccountsHeader => 'Konten';

  @override
  String get settingsAddAccount => 'Konto hinzufügen';

  @override
  String get settingsMailHeader => 'Mail';

  @override
  String get settingsSwipeActions => 'Wischgesten';

  @override
  String get settingsSwipeLeft => 'Nach links wischen';

  @override
  String get settingsSwipeLeftFooter =>
      'Ein vollständiges Wischen führt diese Aktion aus. „Kennzeichnen“ und „Mehr“ sind immer nur ein kurzes Wischen entfernt.';

  @override
  String get settingsSwipeRight => 'Nach rechts wischen';

  @override
  String get settingsSwipeRightFooter => 'Ein vollständiges Wischen führt diese Aktion aus.';

  @override
  String get settingsSwipeToggleRead => 'Als gelesen/ungelesen markieren';

  @override
  String get settingsSwipeTrash => 'In den Papierkorb';

  @override
  String get settingsSwipeMove => 'Nachricht verschieben';

  @override
  String get settingsSwipeSnooze => 'Zurückstellen';

  @override
  String get settingsThreaded => 'Nach Konversation gruppieren';

  @override
  String get settingsUndoSendDelay => 'Zeit zum Rückgängigmachen';

  @override
  String get settingsUndoSendDelayFooter => 'Gesendete Nachrichten warten so lange, damit du sie zurückholen kannst.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds Sekunden',
      one: '$seconds Sekunde',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Darstellung';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSystem => 'Automatisch';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsDensity => 'Nachrichtenliste';

  @override
  String get settingsDensityComfortable => 'Komfortabel';

  @override
  String get settingsDensityCompact => 'Kompakt';

  @override
  String get settingsReadingHeader => 'Lesen';

  @override
  String get settingsReadingFooter =>
      'Externe Bilder können Absendern verraten, wann und wo du eine Nachricht geöffnet hast.';

  @override
  String get settingsDefaultView => 'Standardansicht';

  @override
  String get settingsDefaultViewFooter => 'Du kannst jede Nachricht mit der Aa-Schaltfläche umschalten.';

  @override
  String get settingsViewReadable => 'Lesbar';

  @override
  String get settingsViewReadableDetail => 'Aufgeräumt, gut lesbar, folgt dem Dunkelmodus';

  @override
  String get settingsViewOriginal => 'Original';

  @override
  String get settingsViewOriginalDetail => 'Genau so, wie der Absender sie gestaltet hat';

  @override
  String get settingsViewPlain => 'Nur Text';

  @override
  String get settingsViewPlainDetail => 'Nur die Worte';

  @override
  String get settingsPlainTextFont => 'Schriftart für Nur-Text';

  @override
  String get settingsFontSans => 'Serifenlos';

  @override
  String get settingsFontMono => 'Festbreite';

  @override
  String get settingsFontMonoDetail => 'Hält ASCII-Art und Tabellen ausgerichtet';

  @override
  String get settingsTechnicalLists => 'Technische Listen';

  @override
  String get settingsLoadRemoteImages => 'Externe Bilder laden';

  @override
  String get settingsOpenLinksDirectly => 'Links direkt öffnen';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Klick-Tracker überspringen, wenn das Ziel bekannt ist';

  @override
  String get settingsSecurityHeader => 'Sicherheit';

  @override
  String get settingsAppLock => 'App-Sperre';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe fragt beim Start und wenn du nach Ablauf der Zeit unter „Sperren nach“ zurückkehrst.';

  @override
  String get settingsAppLockFooterOff =>
      'Die App-Sperre fragt nach deinem Fingerabdruck, deinem Gesicht oder deiner Displaysperre, bevor deine Mails angezeigt werden.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Die App-Sperre ist noch aus. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Code einrichten';

  @override
  String get settingsScreenLockTextIos =>
      'Die App-Sperre verwendet Face ID, Touch ID oder deinen Code, und dieses iPhone hat keinen Code. Richte in der App „Einstellungen“ einen ein und schalte dann die App-Sperre ein.';

  @override
  String get settingsScreenLockTitleAndroid => 'Displaysperre einrichten';

  @override
  String get settingsScreenLockTextAndroid =>
      'Die App-Sperre verwendet die Displaysperre deines Smartphones oder einen dort hinzugefügten Fingerabdruck oder ein Gesicht, und dieses Smartphone hat keine. Richte in den Android-Einstellungen eine PIN, ein Muster oder ein Passwort ein und schalte dann die App-Sperre ein.';

  @override
  String get settingsOpenSystemSettings => 'Einstellungen öffnen';

  @override
  String get settingsOpenAndroidSettings => 'Android-Einstellungen öffnen';

  @override
  String get settingsLockAfter => 'Sperren nach';

  @override
  String get settingsLockAfterFooter => 'Wie lange Loupe im Hintergrund sein darf, bevor es erneut fragt.';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsEncryption => 'Ende-zu-Ende-Verschlüsselung';

  @override
  String get settingsAdvanced => 'Erweitert';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo-Mail ist ein erfundenes Postfach, das nur auf diesem Smartphone existiert. Es wird nichts verschickt.';

  @override
  String get settingsDemoMode => 'Demomodus';

  @override
  String get settingsResetApp => 'App zurücksetzen';

  @override
  String get settingsResetFooter => 'Vergisst alle Einstellungen und kehrt zum Willkommensbildschirm zurück.';

  @override
  String get settingsResetTitle => 'Loupe zurücksetzen?';

  @override
  String get settingsResetMessage =>
      'Dadurch werden alle Einstellungen, Smart Mailboxes und letzten Suchen vergessen, und du kehrst zum Willkommensbildschirm zurück.';

  @override
  String get settingsAboutHeader => 'Über';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicences => 'Lizenzen';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsPrivacyDetail =>
      'Loupe hat keine Analyse und kein Tracking. Deine Mails gehen nur an deine Mailserver.';

  @override
  String get settingsNotificationsOffIos => 'Benachrichtigungen für Loupe sind in den Einstellungen deaktiviert.';

  @override
  String get settingsNotificationsOffAndroid =>
      'Benachrichtigungen für Loupe sind in den Android-Einstellungen deaktiviert.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system erlaubt Loupe nicht, Benachrichtigungen anzuzeigen. Erlaube sie in den Einstellungen.';
  }

  @override
  String get settingsNewMailHeader => 'Neue Mails';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo-Mails kommen nicht im Hintergrund an. Sende eine Testbenachrichtigung, um zu sehen, wie neue Mails aussehen.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe sucht im Hintergrund nach neuen Mails, wenn iOS es zulässt, was bei selten geöffneten Apps Stunden auseinanderliegen kann. Du wirst über neue Nachrichten in deinen Posteingängen und über Nachrichten von VIPs in jedem Ordner informiert.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe sucht etwa alle 15 Minuten nach neuen Mails, wenn Android es zulässt. Du wirst über neue Nachrichten in deinen Posteingängen und über Nachrichten von VIPs in jedem Ordner informiert.';

  @override
  String get settingsNoAccounts => 'Keine Konten';

  @override
  String get settingsVipOnly => 'Nur VIP';

  @override
  String get settingsVipOnlyDetail => 'Nur Nachrichten von deinen VIPs';

  @override
  String get settingsHideContent => 'Inhalt ausblenden';

  @override
  String get settingsHideContentFooterOn =>
      'Benachrichtigungen sagen nur „Neue Nachricht von“ und das Konto, aber nicht, wer geschrieben hat oder worum es geht.';

  @override
  String get settingsHideContentFooterOff =>
      '„Inhalt ausblenden“ hält Absender, Betreff und Vorschau vom Sperrbildschirm und aus den Benachrichtigungen fern.';

  @override
  String get settingsBackgroundAppRefresh => 'Hintergrundaktualisierung';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Neue Mails kommen im Hintergrund nur an, solange die Hintergrundaktualisierung für Loupe in den Einstellungen eingeschaltet ist. iOS kann keine Verbindung zu deinen Posteingängen offen halten, daher gibt es keine sofortige Zustellung.';

  @override
  String get settingsInstantDelivery => 'Sofortige Zustellung';

  @override
  String get settingsInstantDeliveryFooter =>
      'Die sofortige Zustellung (experimentell) hält eine Verbindung zu deinen Posteingängen offen, sodass neue Mails innerhalb von Sekunden ankommen. Sie zeigt eine unauffällige Benachrichtigung „Wartet auf neue Mails“ an und verbraucht mehr Akku.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android beendet die sofortige Zustellung möglicherweise, um Akku zu sparen. Erlaube Loupe die uneingeschränkte Akkunutzung, damit sie weiterläuft.';

  @override
  String get settingsExperimental => 'Experimentell';

  @override
  String get settingsComingSoon => 'Demnächst';

  @override
  String get settingsAllowUnrestrictedBattery => 'Uneingeschränkte Akkunutzung erlauben';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Mit Push wecken neue Mails Loupe sofort auf, wo dein Mail-Dienst das unterstützt. Pushes laufen über Googles Push-Dienst und enthalten keine Mails, nur „Jetzt nachsehen“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Dieses Smartphone kann keine Pushes empfangen: Sie brauchen die Google Play-Dienste und eine Netzwerkverbindung. Loupe sucht weiterhin etwa alle 15 Minuten nach neuen Mails.';

  @override
  String get settingsCopyPushToken => 'Push-Token kopieren';

  @override
  String get settingsPushTokenCopied => 'Push-Token kopiert';

  @override
  String get settingsSendTestNotification => 'Testbenachrichtigung senden';

  @override
  String get settingsAppIconBadge => 'App-Symbol-Badge';

  @override
  String get settingsBadgeNote =>
      'Das Badge wird aktualisiert, wann immer Loupe nach Mails sucht, auch im Hintergrund.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Der Startbildschirm dieses Smartphones zeigt keine Zahlen auf App-Symbolen an. Das Badge wird aktualisiert, wann immer Loupe nach Mails sucht, auch im Hintergrund.';

  @override
  String get settingsTestNotificationBody => 'So sehen Benachrichtigungen für neue Mails aus.';

  @override
  String get settingsAccountRemoved => 'Dieses Konto wurde entfernt.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Beschreibung';

  @override
  String get settingsAccountDescriptionHint => 'Arbeit, Privat…';

  @override
  String get settingsEmail => 'E-Mail';

  @override
  String get settingsColour => 'Farbe';

  @override
  String get settingsColourFooter => 'Markiert die Nachrichten dieses Kontos in „Alle Posteingänge“.';

  @override
  String settingsColourNumber(int number) {
    return 'Farbe $number';
  }

  @override
  String get settingsSendingHeader => 'Senden';

  @override
  String get settingsSendingFooter =>
      'Jede Identität hat ihre eigene Signatur. Antworten werden von der Adresse gesendet, an die eine Nachricht ging.';

  @override
  String get settingsFoldersHeader => 'Ordner';

  @override
  String get settingsFoldersFooter =>
      'Loupe zeigt und synchronisiert die Ordner, die du abonniert hast, wie Thunderbird. Posteingang, Entwürfe, Gesendet, Spam, Papierkorb und Archiv werden immer angezeigt.';

  @override
  String get settingsShowAllFolders => 'Alle Ordner anzeigen';

  @override
  String get settingsIncoming => 'Eingehend';

  @override
  String get settingsOutgoing => 'Ausgehend';

  @override
  String get settingsConnectionNotEncrypted => 'Nicht verschlüsselt';

  @override
  String get settingsSignIn => 'Anmeldung';

  @override
  String get settingsSignInExpired => 'Abgelaufen';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider akzeptiert die Anmeldung von Loupe für dieses Konto nicht mehr, daher werden seine Mails nicht synchronisiert. Melde dich erneut an, um das zu beheben.';
  }

  @override
  String get settingsSignInAgain => 'Erneut anmelden';

  @override
  String get settingsSigningIn => 'Anmeldung läuft…';

  @override
  String get settingsRemoveAccount => 'Konto entfernen';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '„$account“ entfernen?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Seine Mails und Einstellungen werden von diesem Smartphone entfernt. Auf dem Server wird nichts gelöscht.';

  @override
  String get settingsManageFolders => 'Ordner verwalten';

  @override
  String get settingsNoFolders => 'Noch keine Ordner.';

  @override
  String get settingsManageFoldersFooter =>
      'Abonnierte Ordner erscheinen auf dem Postfächer-Bildschirm und werden im Hintergrund synchronisiert. Andere Mail-Apps mit demselben Konto folgen diesen Abonnements meist auch.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Bewahrt deine Smart Mailboxes für deine anderen Geräte auf. Auf dem Postfächer-Bildschirm ausgeblendet.';

  @override
  String get settingsFolderAlwaysShown => 'Immer angezeigt';

  @override
  String settingsSubscribeToFolder(String folder) {
    return '$folder abonnieren';
  }

  @override
  String get settingsIdentities => 'Identitäten';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Die erste Identität ist der Standard für neue Nachrichten. Ziehe, um die Reihenfolge zu ändern.';

  @override
  String get settingsIdentitiesFooterSingle => 'Die Standardidentität für neue Nachrichten.';

  @override
  String get settingsIdentitiesReplyFooter =>
      'Eine Antwort wird von der Identität gesendet, an die die Nachricht ging.';

  @override
  String get settingsIdentityDefault => 'Standard';

  @override
  String settingsIdentityReorder(String email) {
    return '$email verschieben';
  }

  @override
  String get settingsAddIdentity => 'Identität hinzufügen';

  @override
  String get settingsNewIdentity => 'Neue Identität';

  @override
  String get settingsIdentity => 'Identität';

  @override
  String get settingsIdentityNameHint => 'Dein Name';

  @override
  String get settingsReplyTo => 'Antwort an';

  @override
  String get settingsSignature => 'Signatur';

  @override
  String get settingsSignatureFooter => 'Wird in Nachrichten von dieser Identität unter „-- “ eingefügt.';

  @override
  String get settingsNoSignature => 'Keine Signatur';

  @override
  String get settingsCopyToMyself => 'Kopie an mich';

  @override
  String get settingsCopyToMyselfFooter => 'Wird zu jeder Nachricht von dieser Identität hinzugefügt.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Für Antworten an';

  @override
  String get settingsReplyPatternsFooter =>
      'Antworten auf Nachrichten an diese Adressen werden von dieser Identität gesendet. * steht für beliebige Zeichen: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Eine Adresse oder ein Muster, in dem * für beliebige Zeichen steht.';

  @override
  String get settingsAddReplyPattern => 'Adresse oder Muster hinzufügen';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return '$pattern entfernen';
  }

  @override
  String get settingsInvalidPatternTitle => 'Ungültiges Muster';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ ist keine Adresse und kein Muster wie *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Keine Adresse';

  @override
  String get settingsIdentityNoAddressMessage => 'Gib die E-Mail-Adresse ein, von der gesendet werden soll.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Ungültige Adresse';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„Antwort an“-Adresse „$address“ ist keine gültige E-Mail-Adresse.',
      'cc': 'Cc-Adresse „$address“ ist keine gültige E-Mail-Adresse.',
      'bcc': 'Bcc-Adresse „$address“ ist keine gültige E-Mail-Adresse.',
      'other': '„$address“ ist keine gültige E-Mail-Adresse.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Identität speichern';

  @override
  String get settingsDiscardChanges => 'Änderungen verwerfen';

  @override
  String get settingsDeleteIdentity => 'Identität löschen';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '„$email“ löschen?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Bereits davon gesendete Nachrichten bleiben unverändert.';

  @override
  String get settingsLastIdentityFooter => 'Ein Konto braucht mindestens eine Identität.';

  @override
  String get rulesTitle => 'Regeln';

  @override
  String get rulesNewRule => 'Neue Regel';

  @override
  String get rulesLoadError => 'Die Regeln konnten nicht geladen werden.';

  @override
  String get rulesEmptyTitle => 'Keine Regeln';

  @override
  String get rulesEmptyText =>
      'Regeln sortieren, verschlagworten und kennzeichnen neue Mails für dich. Erstelle eine mit der Schaltfläche oben oder aus einer Suche mit „Daraus eine Regel machen“.';

  @override
  String get rulesListFooter =>
      'Regeln laufen von oben nach unten auf neuen Mails im Posteingang. Halte eine Regel gedrückt, um sie zu verschieben.';

  @override
  String get rulesChangeError => 'Die Regel konnte nicht geändert werden';

  @override
  String get rulesConditionEveryMessage => 'Jede Nachricht';

  @override
  String rulesMoveRule(String rule) {
    return '$rule verschieben';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule an';
  }

  @override
  String get rulesServerRulesHeader => 'Serverregeln';

  @override
  String get rulesServerRulesFooter =>
      'Serverregeln laufen auf dem Mailserver, wenn Mails ankommen, auch während dieses Smartphone aus ist. Sie liegen in einem Sieve-Skript namens „loupe“.';

  @override
  String get rulesStatusUnknown => 'Unbekannt';

  @override
  String get rulesStatusError => 'Der Server konnte nicht abgefragt werden.';

  @override
  String get rulesStatusChecking => 'Wird geprüft…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Läuft über „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '„$script“ ist das aktive Skript. Tippe, damit es auch die Regeln von Loupe ausführt.';
  }

  @override
  String get rulesStatusNoScript =>
      'Auf dem Server ist kein Skript aktiv. Wenn du eine Serverregel speicherst, wird das von Loupe aktiviert.';

  @override
  String get rulesStatusUnavailable => 'Nicht verfügbar';

  @override
  String get rulesStatusNoSieve => 'Der Server dieses Kontos bietet kein Sieve (ManageSieve oder JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Nach $folder verschieben';
  }

  @override
  String get rulesActionMoveUnknown => 'In einen Ordner verschieben';

  @override
  String rulesActionTag(String tag) {
    return 'Schlagwort $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Schlagwort $tag entfernen';
  }

  @override
  String get rulesActionKeepInInbox => 'Im Posteingang behalten';

  @override
  String rulesActionForward(String address) {
    return 'Weiterleiten an $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Weiterleiten an $address, keine Kopie behalten';
  }

  @override
  String get rulesActionStop => 'Stopp';

  @override
  String get rulesNoActions => 'Tut noch nichts';

  @override
  String get rulesLocationDevice => 'Gerät';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Dieses Gerät';

  @override
  String get rulesNewRuleTitle => 'Neue Regel';

  @override
  String get rulesEditRuleTitle => 'Regel bearbeiten';

  @override
  String get rulesDefaultNameEveryMessage => 'Jede Nachricht';

  @override
  String get rulesConditionHeader => 'Wenn eine neue Nachricht passt';

  @override
  String get rulesConditionFooter =>
      'Schreib sie wie eine Suche: from:, to:, s: (Betreff), b: (Text), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:rechnung';

  @override
  String get rulesAccounts => 'Konten';

  @override
  String get rulesAllAccounts => 'Alle Konten';

  @override
  String get rulesRemovedAccount => 'Entferntes Konto';

  @override
  String get rulesAccountsFooter => 'Eine Regel für alle Konten gilt auch für Konten, die du später hinzufügst.';

  @override
  String get rulesActionsHeader => 'Dann';

  @override
  String get rulesForwardingFooter =>
      'Weiterleiten sendet jede passende Nachricht beim Eintreffen an eine andere Adresse, auch während dieses Smartphone aus ist. Manche Anbieter begrenzen, wie viele Mails weitergeleitet werden dürfen.';

  @override
  String get rulesForwardingHiddenFooter => 'Weiterleiten funktioniert nur in Serverregeln und fehlt daher hier.';

  @override
  String rulesRemoveAction(String action) {
    return '$action entfernen';
  }

  @override
  String get rulesAddAction => 'Aktion hinzufügen';

  @override
  String get rulesAddMove => 'In Ordner verschieben…';

  @override
  String get rulesAddTagMenu => 'Schlagwort hinzufügen…';

  @override
  String get rulesRemoveTagMenu => 'Schlagwort entfernen…';

  @override
  String get rulesAddForward => 'Weiterleiten an…';

  @override
  String get rulesStopProcessing => 'Keine weiteren Regeln ausführen';

  @override
  String get rulesRunOnHeader => 'Ausführen auf';

  @override
  String get rulesRunOnDeviceFooter =>
      'Dieses Gerät führt die Regel auf neuen Mails im Posteingang aus, wann immer Loupe nach Mails sucht.';

  @override
  String get rulesRunOnServerFooter =>
      'Der Mailserver führt die Regel aus, wenn Mails ankommen, auch während dieses Smartphone aus ist. Benötigt Sieve, über ManageSieve (Dovecot, mailcow) oder JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Auf vorhandene Nachrichten anwenden…';

  @override
  String get rulesDeleteRule => 'Regel löschen';

  @override
  String rulesDeleteTitle(String rule) {
    return '„$rule“ löschen?';
  }

  @override
  String get rulesMoveAccountTitle => 'Ordner in welchem Konto?';

  @override
  String get rulesMoveAccountMessage => 'Mails der anderen Konten landen dort im Ordner mit demselben Namen.';

  @override
  String get rulesAddTag => 'Schlagwort hinzufügen';

  @override
  String get rulesRemoveTag => 'Schlagwort entfernen';

  @override
  String get rulesForwardTo => 'Weiterleiten an';

  @override
  String get rulesForwardToMessage =>
      'Der Server leitet jede passende Nachricht an diese Adresse weiter, auch während dieses Smartphone aus ist. Verwende eine Adresse, die dir gehört oder der du vertraust.';

  @override
  String get rulesNotAnAddressTitle => 'Keine E-Mail-Adresse';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ ist keine Adresse, an die weitergeleitet werden kann.';
  }

  @override
  String get rulesKeepCopyTitle => 'Hier eine Kopie behalten?';

  @override
  String get rulesKeepCopy => 'Kopie behalten';

  @override
  String get rulesDontKeepCopy => 'Keine Kopie behalten';

  @override
  String get rulesCheckCondition => 'Bedingung prüfen';

  @override
  String get rulesChooseActionTitle => 'Aktion wählen';

  @override
  String get rulesChooseActionMessage => 'Lege fest, was die Regel mit den passenden Nachrichten tut.';

  @override
  String get rulesSaveError => 'Die Regel konnte nicht gespeichert werden';

  @override
  String get rulesSaveServerError => 'Die Serverregel konnte nicht gespeichert werden';

  @override
  String get rulesRunOnDeviceInstead => 'Stattdessen auf diesem Gerät ausführen';

  @override
  String get rulesNothingToApplyTitle => 'Nichts anzuwenden';

  @override
  String get rulesNothingToApplyMessage => 'Gib der Regel zuerst eine funktionierende Bedingung und eine Aktion.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return '„$rule“ auf Nachrichten anwenden in…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Posteingängen';

  @override
  String get rulesApplyScopeAll => 'Allen Postfächern';

  @override
  String get rulesFindingMessages => 'Nachrichten werden gesucht…';

  @override
  String get rulesSearchError => 'Suche fehlgeschlagen';

  @override
  String get rulesSearchErrorUnknown => 'Etwas ist schiefgelaufen.';

  @override
  String get rulesNoMatchesTitle => 'Keine passenden Nachrichten';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Dort passt nichts zu „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$rule“ auf $countString Nachrichten anwenden?',
      one: '„$rule“ auf $countString Nachricht anwenden?',
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
      other: 'Auf $countString Nachrichten anwenden',
      one: 'Auf $countString Nachricht anwenden',
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
      other: '„$rule“ auf $countString Nachrichten angewendet',
      one: '„$rule“ auf $countString Nachricht angewendet',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Server wird gefragt, was er kann…';

  @override
  String get rulesServerUnreachable => 'Der Server war nicht erreichbar.';

  @override
  String rulesServerProblem(String problem) {
    return 'Kann nicht auf dem Server laufen: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Kann nicht auf dem Server von $account laufen: $problem';
  }

  @override
  String get rulesShowScript => 'Skript anzeigen';

  @override
  String get rulesHideScript => 'Skript ausblenden';

  @override
  String get rulesMatchingHeader => 'Passende Nachrichten';

  @override
  String get rulesMatchingHeaderLoading => 'Passende Nachrichten…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString passende Nachrichten',
      one: '$countString passende Nachricht',
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
      other: '$countString+ passende Nachrichten',
      one: '$countString+ passende Nachricht',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Aus den letzten 30 Tagen. Die Regel selbst wirkt nur auf neue Mails, es sei denn, du wendest sie auf vorhandene Nachrichten an.';

  @override
  String rulesConditionError(String error) {
    return 'Die Bedingung enthält einen Fehler: $error';
  }

  @override
  String get rulesPreviewNoSender => '(kein Absender)';

  @override
  String get rulesPreviewNoSubject => '(kein Betreff)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'und $countString weitere',
      one: 'und $countString weitere',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nichts aus den letzten 30 Tagen.';

  @override
  String get rulesIncludeTitle => 'Serverregeln einschalten';

  @override
  String get rulesIncludeLeaveOff => 'Aus lassen';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Der Server führt die Regeln von Loupe für $account bereits aus.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ ist das aktive Skript auf dem Server von $account, daher führt der Server dieses aus und nicht die Regeln von Loupe. Loupe ersetzt es nicht. Es kann ihm diese Zeilen hinzufügen, dann führt der Server die Regeln von Loupe nach denen des Skripts aus:';
  }

  @override
  String get rulesShowWholeScript => 'Ganzes Skript anzeigen';

  @override
  String get rulesHideWholeScript => 'Ganzes Skript ausblenden';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Sonst ändert sich nichts an „$script“. Wenn seine Filter später im Webmail bearbeitet werden, schreibt das Webmail es womöglich ohne diese Zeilen neu; Loupe zeigt die Serverregeln dann wieder als aus an.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Zu „$script“ hinzufügen';
  }

  @override
  String get subscriptionsTitle => 'Abonnements';

  @override
  String get subscriptionsNewsletters => 'Newsletter';

  @override
  String get subscriptionsDiscussions => 'Diskussionen';

  @override
  String get subscriptionsFilter => 'Filtern';

  @override
  String get subscriptionsFilterNeverRead => 'Nie gelesen';

  @override
  String get subscriptionsFilterRarelyRead => 'Selten gelesen';

  @override
  String get subscriptionsFilterAll => 'Alle';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonnements konnten nicht gezählt werden';

  @override
  String get subscriptionsNoMatches => 'Keine Treffer';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Kein Newsletter heißt „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Keine Liste heißt „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Keine Newsletter';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Newsletter und andere Massenmails erscheinen hier, sobald sie ankommen.';

  @override
  String get subscriptionsNothingNeverRead => 'Nichts nie gelesen';

  @override
  String get subscriptionsNothingRarelyRead => 'Nichts selten gelesen';

  @override
  String get subscriptionsNothingFilteredDetail => 'Du liest von allem, was du bekommst, zumindest etwas.';

  @override
  String get subscriptionsNoDiscussions => 'Keine Diskussionen';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Mailinglisten, an die du schreiben kannst, erscheinen hier, sobald ihre Mails ankommen.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listen, in die mehrere Personen schreiben. Halte eine gedrückt, um sie an die Postfächer anzuheften, als reinen Text zu lesen oder zu den Newslettern zu verschieben.';

  @override
  String get subscriptionsPrivacyNote =>
      'Auf diesem Smartphone anhand der heruntergeladenen Mails gezählt; dafür wird nichts verschickt. Loupe kontaktiert einen Absender nur, wenn du auf „Abmelden“ tippst: Die Ein-Klick-Abmeldung sendet nur „List-Unsubscribe=One-Click“ an die vom Absender angegebene Adresse, ohne Cookies und ohne sonstige Angaben über dich, und lädt nie seine Seiten oder Bilder.';

  @override
  String get subscriptionsVolumeNone => 'Zuletzt keine';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / Monat';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / Monat';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent %';
  }

  @override
  String get subscriptionsPercentUnderOne => '< 1 %';

  @override
  String subscriptionsReadLabel(String percent) {
    return '$percent gelesen';
  }

  @override
  String get subscriptionsStillSending => 'Sendet weiterhin';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Abgemeldet am $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Abmeldeseite am $date geöffnet';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ein Tipp · kontaktiert $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Per E-Mail an $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Auf der Website $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Abmelden';

  @override
  String get subscriptionsUnsubscribeAgain => 'Erneut abmelden';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString im Posteingang archivieren',
      one: '$countString im Posteingang archivieren',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Regel erstellen…';

  @override
  String get subscriptionsCreateRuleDetail => 'Künftige Mails verschieben oder archivieren';

  @override
  String get subscriptionsTreatAsDiscussion => 'Als Diskussion behandeln';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Eine Liste, in die Leute schreiben: wie ein Forum lesen';

  @override
  String get subscriptionsTreatAsNewsletter => 'Als Newsletter behandeln';

  @override
  String get subscriptionsBlockSender => 'Absender blockieren';

  @override
  String get subscriptionsBlock => 'Blockieren';

  @override
  String get subscriptionsBlocked => 'Blockiert';

  @override
  String get subscriptionsBlockedDetail => 'Neue Mails landen im Spam';

  @override
  String get subscriptionsPin => 'An Postfächer anheften';

  @override
  String get subscriptionsUnpin => 'Von Postfächern lösen';

  @override
  String get subscriptionsOpenDefaultView => 'In Standardansicht öffnen';

  @override
  String get subscriptionsOpenPlainText => 'Als reinen Text öffnen (Mono)';

  @override
  String get subscriptionsPinned => 'Angeheftet';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ungelesen',
      one: '$countString ungelesen',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Derzeit keine Mails von diesem Absender.';

  @override
  String get subscriptionsLatestMessages => 'NEUESTE NACHRICHTEN';

  @override
  String get subscriptionsMail => 'Mails';

  @override
  String get subscriptionsNoneIn90Days => 'Keine in 90 Tagen';

  @override
  String get subscriptionsRead => 'Gelesen';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString von $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Zuletzt empfangen';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Ordner', one: 'Ordner');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Sendet weiterhin';

  @override
  String get subscriptionsUnsubscribedTitle => 'Abgemeldet';

  @override
  String subscriptionsSince(String date) {
    return 'seit $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'Seite am $date geöffnet';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender gibt nicht an, wie man sich abmeldet.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender gibt nicht an, wie man sich abmeldet. Du kannst den Absender stattdessen blockieren.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Abmeldung von $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Von $sender abgemeldet.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Abmeldung fehlgeschlagen: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Automatische Abmeldung fehlgeschlagen';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Abmelde-E-Mail senden';

  @override
  String subscriptionsOpenSite(String site) {
    return '$site öffnen';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site öffnen?';
  }

  @override
  String get subscriptionsOpen => 'Öffnen';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender meldet auf seiner Website ab. Die Seite öffnet sich im Browser von Loupe; schließe den Vorgang dort ab.';
  }

  @override
  String get subscriptionsWebInsecure => 'Die Verbindung zu dieser Website ist nicht verschlüsselt.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Vorsicht: Diese Adresse imitiert $site mit ähnlich aussehenden Buchstaben.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Vorsicht: Diese Adresse imitiert eine andere Website mit ähnlich aussehenden Buchstaben.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site konnte nicht geöffnet werden.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe merkt sich das heutige Datum und sagt dir Bescheid, wenn $sender weiter schreibt.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Von $sender abmelden?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe kontaktiert $site, um dich abzumelden.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Nur in diesem Fall kontaktiert Loupe die Website eines Absenders. Es sendet nur „List-Unsubscribe=One-Click“ an die von $sender angegebene Adresse, ohne Cookies oder sonstige Angaben über dich, und lädt die Seite nicht.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Der Abmeldelink ist keine sichere Adresse im Internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site hat nicht rechtzeitig geantwortet.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site war nicht erreichbar.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site hat die Anfrage an eine andere Seite weitergeleitet, der Loupe nicht folgt.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site hat die Anfrage abgelehnt (Fehler $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Es gibt kein Konto, von dem die Abmelde-E-Mail gesendet werden kann.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe sendet eine E-Mail an $to von $from mit dem Betreff „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Abmelde-E-Mail an $address gesendet.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender blockieren?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Neue Mails von dieser Liste landen im Spam. Du kannst das unter Einstellungen › Regeln ändern.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Neue Mails von $address landen im Spam. Du kannst das unter Einstellungen › Regeln ändern.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender blockiert.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count in Spam verschieben',
      one: '$count in Spam verschieben',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return '$sender blockieren';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender ist jetzt bei den Newslettern.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender ist jetzt bei den Diskussionen.';
  }

  @override
  String get appLiveGateTitle => 'Deine Konten konnten nicht geöffnet werden';

  @override
  String get appLiveGateUnavailableBuild => 'Echte Konten sind in diesem Build noch nicht verfügbar.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe konnte den Schlüssel, der deine Mails auf diesem Smartphone schützt, nicht lesen. Das ist oft vorübergehend: Versuche es erneut oder starte das Smartphone neu.';

  @override
  String get appLiveGateKeyMissing =>
      'Der Schlüssel, der deine Mails auf diesem Smartphone schützt, ist weg. Das kann nach dem Wiederherstellen einer Sicherung passieren. Deine Mails sind noch auf dem Server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Die Mail-Datenbank auf diesem Smartphone kann nicht gelesen werden: Sie ist beschädigt oder ihr Schlüssel hat sich geändert. Deine Mails sind noch auf dem Server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Beim Öffnen deiner Konten ist etwas schiefgelaufen ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Dadurch werden deine Konten und die auf diesem Smartphone gespeicherten Mails gelöscht, auch Nachrichten, die im Postausgang warten. Mails auf deinen Servern sind nicht betroffen; füge deine Konten danach erneut hinzu.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Löschen und neu beginnen';

  @override
  String get appLiveGateUseDemo => 'Demo-Mail verwenden';

  @override
  String get appLiveGateReset => 'Mails auf diesem Smartphone zurücksetzen…';

  @override
  String get attachmentsUntitled => 'Anhang';

  @override
  String get attachmentsUntitledFile => 'Unbenannt';

  @override
  String get attachmentsOpenIn => 'Öffnen in…';

  @override
  String get attachmentsSaveToFiles => 'In Dateien speichern';

  @override
  String get attachmentsShareMenu => 'Teilen…';

  @override
  String get attachmentsDownloadError =>
      'Der Anhang konnte nicht heruntergeladen werden. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get attachmentsShareError => 'Der Anhang konnte nicht geteilt werden.';

  @override
  String attachmentsNoApp(String type) {
    return 'Keine App auf diesem Gerät öffnet diese Datei ($type). Versuche stattdessen „Teilen“.';
  }

  @override
  String get attachmentsOpenInError => 'Der Anhang konnte nicht in einer anderen App geöffnet werden.';

  @override
  String attachmentsSaved(String name) {
    return '„$name“ gespeichert';
  }

  @override
  String get attachmentsSaveError => 'Der Anhang konnte nicht gespeichert werden.';

  @override
  String get attachmentsGone => 'Dieser Anhang ist nicht mehr verfügbar.';

  @override
  String get attachmentsDownloadFailed => 'Der Anhang konnte nicht heruntergeladen werden.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Seiten', one: '$count Seite');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size über mobile Daten';
  }

  @override
  String get attachmentsLargeDownload => 'Dieser Anhang ist groß. Lade ihn jetzt herunter oder später über WLAN.';

  @override
  String get attachmentsDownload => 'Herunterladen';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size wird heruntergeladen…';
  }

  @override
  String get attachmentsDownloading => 'Wird heruntergeladen…';

  @override
  String get attachmentsTooLarge => 'Zu groß für eine Vorschau hier.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Angezeigt werden die ersten $shown von $total. Kopiere, teile oder speichere den Anhang, um alles zu erhalten.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Dieses PDF kann hier nicht angezeigt werden (es ist möglicherweise passwortgeschützt).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page von $count';
  }

  @override
  String get attachmentsModeTable => 'Tabelle';

  @override
  String get attachmentsModeText => 'Text';

  @override
  String get attachmentsModeMessage => 'Nachricht';

  @override
  String get attachmentsModeSource => 'Quelltext';

  @override
  String get attachmentsDontWrap => 'Zeilen nicht umbrechen';

  @override
  String get attachmentsWrap => 'Zeilen umbrechen';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines Zeilen', one: '$lines Zeile');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Alles kopieren';

  @override
  String get attachmentsCopied => 'Kopiert';

  @override
  String get attachmentsImageUnavailable => 'Dieses Bild kann hier nicht angezeigt werden. Versuche „Öffnen in…“.';

  @override
  String get attachmentsEmlNoSubject => '(Kein Betreff)';

  @override
  String get attachmentsEmlFrom => 'Von';

  @override
  String get attachmentsEmlTo => 'An';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Datum';

  @override
  String get attachmentsEmlNoText => 'Diese Nachricht hat keinen Text.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Anhänge: $names', one: 'Anhang: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organisator: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Und $count weitere Termine',
      one: 'Und $count weiterer Termin',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Bild';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format-Bild';
  }

  @override
  String get attachmentsTypePdf => 'PDF-Dokument';

  @override
  String get attachmentsTypeTsv => 'Tabulatorgetrennte Werte';

  @override
  String get attachmentsTypeCsv => 'CSV-Tabelle';

  @override
  String get attachmentsTypeCalendar => 'Kalendertermin';

  @override
  String get attachmentsTypeEmail => 'E-Mail-Nachricht';

  @override
  String get attachmentsTypeContact => 'Kontaktkarte';

  @override
  String get attachmentsTypeLog => 'Protokolldatei';

  @override
  String get attachmentsTypeText => 'Text';

  @override
  String get attachmentsTypeZip => 'ZIP-Archiv';

  @override
  String get attachmentsTypeArchive => 'Archiv';

  @override
  String get attachmentsTypeWord => 'Word-Dokument';

  @override
  String get attachmentsTypeExcel => 'Excel-Tabelle';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-Präsentation';

  @override
  String get attachmentsTypeWebPage => 'Webseite';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension-Datei';
  }

  @override
  String get attachmentsTypeFile => 'Datei';

  @override
  String get calendarUntitledEvent => 'Termin';

  @override
  String get calendarAllDay => 'Ganztägig';

  @override
  String calendarYourTime(String time) {
    return '$time deine Zeit';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Teilnehmen: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hat angenommen: $details',
      'tentative': '$name hat vorläufig angenommen: $details',
      'declined': '$name hat abgelehnt: $details',
      'delegated': '$name hat delegiert: $details',
      'other': '$name hat nicht geantwortet auf: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hat die Einladung angenommen',
      'tentative': '$name hat die Einladung vorläufig angenommen',
      'declined': '$name hat die Einladung abgelehnt',
      'delegated': '$name hat die Einladung delegiert',
      'other': '$name hat nicht auf die Einladung geantwortet',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Karte';

  @override
  String get calendarJoin => 'Teilnehmen';

  @override
  String get calendarOnlineMeeting => 'Online-Meeting';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider-Meeting';
  }

  @override
  String get calendarOrganizerYou => 'Du';

  @override
  String get calendarOrganizerLabel => 'Organisator';

  @override
  String get calendarStatusAccepted => 'Angenommen';

  @override
  String get calendarStatusMaybe => 'Vielleicht';

  @override
  String get calendarStatusDeclined => 'Abgelehnt';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hat angenommen',
      'tentative': '$name hat vorläufig angenommen',
      'declined': '$name hat abgelehnt',
      'delegated': '$name hat delegiert',
      'other': '$name hat nicht geantwortet',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name hat angenommen:',
      'tentative': '$name hat vorläufig angenommen:',
      'declined': '$name hat abgelehnt:',
      'delegated': '$name hat delegiert:',
      'other': '$name hat nicht geantwortet:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name schlägt eine neue Zeit vor';
  }

  @override
  String get calendarCounterUnknown => 'Ein Teilnehmer schlägt eine neue Zeit vor';

  @override
  String get calendarDeclineCounter => 'Der Organisator hat die Zeit beibehalten';

  @override
  String calendarRefresh(String name) {
    return '$name bittet um die neueste Version';
  }

  @override
  String get calendarRefreshUnknown => 'Ein Teilnehmer bittet um die neueste Version';

  @override
  String get calendarCancelled => 'Abgesagt';

  @override
  String get calendarCancelledByOrganizer => 'Der Organisator hat diesen Termin abgesagt.';

  @override
  String get calendarCancelledLater => 'Dieser Termin wurde später abgesagt.';

  @override
  String get calendarOutdated => 'Veraltet';

  @override
  String get calendarOutdatedDetail => 'Diese Einladung wurde später aktualisiert; die neuere gilt.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Ort entfernt (war $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Ort entfernt (war keiner)';

  @override
  String calendarLocationChanged(String location) {
    return 'Ort geändert in $location';
  }

  @override
  String get calendarNewTitle => 'Neuer Titel';

  @override
  String get calendarRepeatChanged => 'Die Wiederholung hat sich geändert';

  @override
  String get calendarUpdated => 'Aktualisiert';

  @override
  String get calendarUpdatedInvitation => 'Aktualisierte Einladung';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Zeit geändert von $before auf $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Zeitzone „$zone“ unbekannt: Zeiten wie angegeben';
  }

  @override
  String calendarNext(String when) {
    return 'Nächster: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Gäste', one: '$count Gast');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count zugesagt', one: '$count zugesagt');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vielleicht',
      one: '$count vielleicht',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count abgesagt', one: '$count abgesagt');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (du)';
  }

  @override
  String get calendarAttendeeOptional => 'optional';

  @override
  String get calendarAttendeeRoom => 'Raum';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Du hast eine frühere Version angenommen.',
      'tentative': 'Du hast eine frühere Version vorläufig angenommen.',
      'declined': 'Du hast eine frühere Version abgelehnt.',
      'delegated': 'Du hast eine frühere Version delegiert.',
      'other': 'Du hast auf eine frühere Version nicht geantwortet.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Annehmen';

  @override
  String get calendarMaybe => 'Vielleicht';

  @override
  String get calendarDecline => 'Ablehnen';

  @override
  String get calendarCommentHint => 'Kommentar für den Organisator (optional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Deine Antwort geht von $address an $organizer.';
  }

  @override
  String get calendarAddComment => 'Kommentar hinzufügen';

  @override
  String get calendarAddToCalendar => 'Zum Kalender hinzufügen';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Und $count weitere Termine in der Datei',
      one: 'Und $count weiterer Termin in der Datei',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Es gibt keine Kalender-App, zu der der Termin hinzugefügt werden kann.';

  @override
  String get calendarCantOpenCalendar => 'Der Kalender konnte nicht geöffnet werden.';

  @override
  String get calendarCantOpenLink => 'Der Link konnte nicht geöffnet werden.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'An $provider-Meeting teilnehmen?';
  }

  @override
  String get calendarJoinTitle => 'Am Meeting teilnehmen?';

  @override
  String calendarJoinOpens(String host) {
    return 'Öffnet $host in deinem Browser.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Vorsicht: Diese Adresse imitiert $site mit ähnlich aussehenden Buchstaben.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Vorsicht: Diese Adresse imitiert eine andere Website mit ähnlich aussehenden Buchstaben.';

  @override
  String calendarJoinOpen(String host) {
    return '$host öffnen';
  }

  @override
  String get calendarNoOrganizer => 'Diese Einladung hat keinen Organisator, dem geantwortet werden kann.';

  @override
  String get calendarNoAccount => 'Es gibt kein Konto, von dem geantwortet werden kann.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Angenommen',
      'tentative': 'Vielleicht',
      'other': 'Abgelehnt',
    });
    return '$_temp0 · Antwort an $name wird gesendet…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Angenommen',
      'tentative': 'Vielleicht',
      'other': 'Abgelehnt',
    });
    return '$_temp0 · Antwort gesendet';
  }

  @override
  String get calendarReplyAlreadySent => 'Die Antwort wurde bereits gesendet.';

  @override
  String get calendarReplyNotSent => 'Antwort nicht gesendet.';

  @override
  String get dataSmimeNeedsDevice =>
      'Dein S/MIME-Zertifikat ist auf diesem Gerät: Öffne Loupe, um diese Nachricht zu signieren und zu senden.';

  @override
  String dataSigningFailed(String error) {
    return 'Signieren fehlgeschlagen: $error';
  }

  @override
  String get keyboardShortcuts => 'Tastenkürzel';

  @override
  String get keyboardGroupGeneral => 'Allgemein';

  @override
  String get keyboardGroupMessages => 'Nachrichten';

  @override
  String get keyboardGroupCompose => 'Verfassen';

  @override
  String get keyboardCommandPalette => 'Befehlspalette';

  @override
  String get keyboardBackClose => 'Zurück, Schließen';

  @override
  String get keyboardNextMessage => 'Nächste Nachricht';

  @override
  String get keyboardPreviousMessage => 'Vorherige Nachricht';

  @override
  String get keyboardOpenMessage => 'Nachricht öffnen';

  @override
  String get keyboardMoveToTrash => 'In den Papierkorb verschieben';

  @override
  String get keyboardToggleRead => 'Als gelesen oder ungelesen markieren';

  @override
  String get keyboardToggleFlag => 'Kennzeichnen oder Kennzeichnung entfernen';

  @override
  String get keyboardCloseDraft => 'Schließen (Entwurf speichern oder löschen)';

  @override
  String get keyboardOr => 'oder';

  @override
  String get keyboardKeyCtrl => 'Strg';

  @override
  String get keyboardKeyShift => 'Umschalt';

  @override
  String get keyboardKeyEnter => 'Eingabe';

  @override
  String get keyboardKeyEsc => 'Esc';

  @override
  String get keyboardKeyDelete => 'Entf';

  @override
  String get keyboardKeyBackspace => 'Rücktaste';

  @override
  String get mailingListsMuted => 'Thread stummgeschaltet. Neue Nachrichten darin kommen als gelesen an.';

  @override
  String get mailingListsUnmuted => 'Stummschaltung des Threads aufgehoben.';

  @override
  String get mailingListsMuteThread => 'Thread stummschalten';

  @override
  String get mailingListsUnmuteThread => 'Stummschaltung aufheben';

  @override
  String get mailingListsPin => 'An Postfächer anheften';

  @override
  String get mailingListsUnpin => 'Von Postfächern lösen';

  @override
  String get mailingListsDefaultView => 'In Standardansicht öffnen';

  @override
  String get mailingListsPlainText => 'Als reinen Text öffnen (Mono)';

  @override
  String get mailingListsShowMuted => 'Stummgeschaltete Threads anzeigen';

  @override
  String get mailingListsHideMuted => 'Stummgeschaltete Threads ausblenden';

  @override
  String get mailingListsTreatAsNewsletter => 'Als Newsletter behandeln';

  @override
  String get mailingListsOptions => 'Listenoptionen';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted ungelesen',
      one: '$formatted ungelesen',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Neue Nachricht an Liste';

  @override
  String get mailingListsRowUnread => 'Ungelesen';

  @override
  String get mailingListsRowMuted => 'Stummgeschaltet';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Antworten', one: '$count Antwort');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Keine Threads';

  @override
  String get mailingListsMutedHidden => 'Stummgeschaltete Threads sind ausgeblendet.';

  @override
  String get mailingListsTechnicalTitle => 'Technische Listen';

  @override
  String get mailingListsTechnicalEmpty => 'Mailinglisten erscheinen hier, sobald ihre Mails ankommen.';

  @override
  String get mailingListsTechnicalFooter =>
      'Nachrichten dieser Listen öffnen sich als reiner Text in einer Festbreitenschrift, Patches werden als Diffs angezeigt. Mit der Aa-Schaltfläche lässt sich jede Nachricht trotzdem umschalten.';

  @override
  String get paletteMoveToMailbox => 'In Postfach verschieben…';

  @override
  String get paletteMarkAllRead => 'Alle als gelesen markieren';

  @override
  String get paletteExportFolder => 'Ordner exportieren…';

  @override
  String get paletteGetNewMail => 'Neue Mails abrufen';

  @override
  String get paletteSnoozed => 'Zurückgestellt';

  @override
  String get paletteSubscriptions => 'Abonnements';

  @override
  String get paletteDiscussions => 'Diskussionen';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Mailingliste';

  @override
  String get paletteTag => 'Schlagwort';

  @override
  String get paletteSwipeActions => 'Wischgesten';

  @override
  String get paletteNotifications => 'Benachrichtigungen';

  @override
  String get paletteRules => 'Regeln';

  @override
  String get paletteEncryption => 'Ende-zu-Ende-Verschlüsselung';

  @override
  String get paletteAdvanced => 'Erweitert';

  @override
  String get paletteAddAccount => 'Konto hinzufügen';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Ordner';

  @override
  String get paletteRecentSearch => 'Letzte Suche';

  @override
  String paletteSearchMail(String query) {
    return 'Mails nach „$query“ durchsuchen';
  }

  @override
  String get palettePlaceholder => 'Aktionen, Postfächer, Einstellungen suchen';

  @override
  String get paletteNothingFound => 'Nichts gefunden';

  @override
  String get searchNewSmartMailbox => 'Neue Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Zeigt alles, was zu „$query“ passt.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ in Postfächern gespeichert';
  }

  @override
  String get searchMakeRule => 'Daraus eine Regel machen';

  @override
  String get searchSaveSmartMailbox => 'Als Smart Mailbox speichern';

  @override
  String get searchNegate => 'Umkehren';

  @override
  String get searchDontNegate => 'Nicht umkehren';

  @override
  String get searchAllMailboxes => 'Alle Postfächer';

  @override
  String get searchRecent => 'Letzte Suchen';

  @override
  String get searchClear => 'Löschen';

  @override
  String get searchSuggestions => 'Vorschläge';

  @override
  String get searchUnreadMessages => 'Ungelesene Nachrichten';

  @override
  String get searchFlaggedMessages => 'Gekennzeichnete Nachrichten';

  @override
  String get searchWithAttachments => 'Nachrichten mit Anhängen';

  @override
  String get searchUnrepliedMessages => 'Unbeantwortete Nachrichten';

  @override
  String get searchTags => 'Schlagwörter';

  @override
  String get searchPeople => 'Personen';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Von: $name';
  }

  @override
  String get searchSearching => 'Suche läuft…';

  @override
  String get searchNoResults => 'Keine Ergebnisse';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted Ergebnisse',
      one: '$formatted Ergebnis',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Suchmenü';

  @override
  String searchSearchingAccount(String account) {
    return '$account wird auf dem Server durchsucht…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Konto wird auf dem Server durchsucht…';

  @override
  String searchAccountFailed(String account) {
    return '$account konnte auf dem Server nicht durchsucht werden';
  }

  @override
  String get searchUnknownAccountFailed => 'Konto konnte auf dem Server nicht durchsucht werden';

  @override
  String searchChip(String term) {
    return '$term. Zum Bearbeiten doppeltippen.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nicht $term. Zum Bearbeiten doppeltippen.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödingers Posteingang: Jede Nachricht hier ist gelesen und ungelesen, bis du sie öffnest.';

  @override
  String searchContradiction(String term) {
    return 'Keine Nachricht kann zugleich „$term“ und nicht „$term“ sein.';
  }

  @override
  String get searchSyncDeviceOnly => 'Nur auf diesem Gerät';

  @override
  String searchSyncUnsupported(String account) {
    return 'Nur auf diesem Gerät: $account kann sie nicht speichern';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nicht synchronisiert: $account hat ein neueres Format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Wartet auf Synchronisierung mit $account';
  }

  @override
  String searchSynced(String account) {
    return 'Mit $account synchronisiert';
  }

  @override
  String get searchRename => 'Umbenennen';

  @override
  String get searchEditSearch => 'Suche bearbeiten';

  @override
  String get searchDeleteSmartMailbox => 'Smart Mailbox löschen';

  @override
  String get searchRenameSmartMailbox => 'Smart Mailbox umbenennen';

  @override
  String get searchSmartMailboxDeleted => 'Diese Smart Mailbox wurde gelöscht.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes bleiben auf diesem Gerät.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes werden auf deinem Mailserver gespeichert, sodass deine anderen Geräte sie auch haben, ebenso Thunderbird mit Expression Search Reloaded. Die, die alle Konten durchsuchen, liegen auf $account; die eines einzelnen Ordners auf dem Konto dieses Ordners.';
  }

  @override
  String get searchSyncVia => 'Synchronisieren über';

  @override
  String get searchSyncViaFooter => 'Wähle auf jedem Gerät dasselbe Konto.';

  @override
  String get searchGmailCantKeep => 'Gmail kann keine Smart Mailboxes speichern';

  @override
  String get searchKeepOnDevice => 'Smart Mailboxes nur auf diesem Gerät speichern';

  @override
  String get searchOnTheServer => 'Auf dem Server';

  @override
  String get searchServerFooter =>
      'Server-Metadaten (IMAP METADATA) werden in keiner Mail-App angezeigt. Server ohne diese Funktion erhalten einen Ordner „Loupe Settings“ mit einer Nachricht; Loupe blendet ihn in den Postfächern aus.';

  @override
  String get searchSyncNow => 'Jetzt synchronisieren';

  @override
  String get searchStateUnsupported => 'Nicht unterstützt';

  @override
  String get searchStateNewerFormat => 'Neueres Format';

  @override
  String get searchStateFailed => 'Synchronisierung fehlgeschlagen';

  @override
  String get searchStateSyncing => 'Wird synchronisiert…';

  @override
  String get searchStateWaiting => 'Wartet';

  @override
  String get searchStateMetadata => 'Server-Metadaten';

  @override
  String get searchStateFolder => 'Ordner „Loupe Settings“';

  @override
  String get searchStateNothing => 'Nichts gespeichert';

  @override
  String get sharedBack => 'Zurück';

  @override
  String get sharedYesterday => 'Gestern';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date um $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count Byte', one: '$count Byte');
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
  String get sharedSyncNoAccounts => 'Keine Konten';

  @override
  String get sharedSyncChecking => 'Suche nach Mails…';

  @override
  String get sharedSyncFailed => 'Mails konnten nicht abgerufen werden';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Gerade aktualisiert';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Vor $minutes Minuten aktualisiert',
      one: 'Vor $minutes Minute aktualisiert',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Um $time aktualisiert';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Am $date aktualisiert';
  }

  @override
  String get sharedMailboxAllInboxes => 'Alle Posteingänge';

  @override
  String get sharedMailboxUnread => 'Ungelesen';

  @override
  String get sharedMailboxFlagged => 'Gekennzeichnet';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Alle Entwürfe';

  @override
  String get sharedMailboxAllSent => 'Alle Gesendeten';

  @override
  String get sharedMailboxUntitled => 'Postfach';

  @override
  String get sharedTagImportant => 'Wichtig';

  @override
  String get sharedTagWork => 'Dienstlich';

  @override
  String get sharedTagPersonal => 'Persönlich';

  @override
  String get sharedTagToDo => 'Zu erledigen';

  @override
  String get sharedTagLater => 'Später';

  @override
  String get sharedTags => 'Schlagwörter';

  @override
  String get sharedMoveTo => 'Verschieben nach…';

  @override
  String get sharedNoRecipients => 'Keine Empfänger';

  @override
  String get sharedUnknownSender => 'Unbekannter Absender';

  @override
  String get sharedOnServer => 'Auf dem Server';

  @override
  String get sharedAttachment => 'Anhang';

  @override
  String get sharedSnoozedBadge => 'Zurückgestellt';

  @override
  String get sharedRowUnread => 'Ungelesen';

  @override
  String get sharedRowBackFromSnooze => 'Zurück aus der Zurückstellung';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Gekennzeichnet';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten archiviert',
      one: '$count Nachricht archiviert',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten gelöscht',
      one: '$count Nachricht gelöscht',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten in den Posteingang verschoben',
      one: '$count Nachricht in den Posteingang verschoben',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten in den Papierkorb verschoben',
      one: '$count Nachricht in den Papierkorb verschoben',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten in Spam verschoben',
      one: '$count Nachricht in Spam verschoben',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten nach $mailbox verschoben',
      one: '$count Nachricht nach $mailbox verschoben',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten in ein Postfach verschoben',
      one: '$count Nachricht in ein Postfach verschoben',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten bis $time zurückgestellt',
      one: '$count Nachricht bis $time zurückgestellt',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Nur auf diesem Gerät bis $time zurückgestellt: Der Server kann keine Zurückstellzeiten speichern.';
  }

  @override
  String get sharedMoveOneAccount => 'Wähle Nachrichten aus einem Konto aus, um sie zu verschieben.';

  @override
  String get sharedSnoozeTitle => 'Zurückstellen';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Zeitpunkt ändern';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten endgültig löschen?',
      one: 'Diese Nachricht endgültig löschen?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get sharedDeletePermanently => 'Endgültig löschen';

  @override
  String get sharedSwipeRead => 'Gelesen';

  @override
  String get sharedSwipeUnread => 'Ungelesen';

  @override
  String get sharedSwipeInbox => 'Posteingang';

  @override
  String get sharedSwipeDelete => 'Löschen';

  @override
  String get sharedTrash => 'Papierkorb';

  @override
  String get sharedSwipeSnooze => 'Zurückstellen';

  @override
  String get sharedWakeNow => 'Jetzt zurückholen';

  @override
  String get sharedChangeSnoozeTime => 'Zeitpunkt ändern…';

  @override
  String get sharedSnooze => 'Zurückstellen…';

  @override
  String get sharedTag => 'Verschlagworten…';

  @override
  String get sharedMoveMessage => 'Nachricht verschieben…';

  @override
  String get sharedNotJunk => 'Kein Spam';

  @override
  String get accountSetupTitle => 'Konto hinzufügen';

  @override
  String get accountSetupTitleDone => 'Konto hinzugefügt';

  @override
  String get accountSetupAddressTitle => 'Mailkonto hinzufügen';

  @override
  String get accountSetupAddressText => 'Loupe findet die Einstellungen für die meisten Anbieter.';

  @override
  String get accountSetupNameHint => 'Dein Name';

  @override
  String get accountSetupEmail => 'E-Mail';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Weiter';

  @override
  String get accountSetupLookingUp => 'Einstellungen werden gesucht…';

  @override
  String get accountSetupImport => 'Aus Thunderbird importieren';

  @override
  String get accountSetupInvalidEmail => 'Gib eine gültige E-Mail-Adresse ein.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Für $domain wurden keine Einstellungen gefunden. Gib sie unten ein.';
  }

  @override
  String get accountSetupCheckServers => 'Prüfe die Servernamen und Ports.';

  @override
  String get accountSetupEnterPassword => 'Gib dein Passwort ein.';

  @override
  String get accountSetupConnecting => 'Verbindung wird hergestellt…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Warten auf $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Die Seite konnte nicht geöffnet werden.';

  @override
  String get accountSetupCouldNotSaveName => 'Der Name konnte nicht gespeichert werden.';

  @override
  String get accountSetupTrustCertificate => 'Diesem Zertifikat vertrauen';

  @override
  String get accountSetupPasswordRequired => 'Erforderlich';

  @override
  String get accountSetupShowPassword => 'Passwort anzeigen';

  @override
  String get accountSetupHidePassword => 'Passwort ausblenden';

  @override
  String get accountSetupAppPassword => 'App-Passwort';

  @override
  String get accountSetupApiToken => 'API-Token';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Eingehend · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Ausgehend · SMTP';

  @override
  String get accountSetupSignIn => 'Anmelden';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Mit $provider anmelden';
  }

  @override
  String get accountSetupUseAppPassword => 'App-Passwort verwenden';

  @override
  String get accountSetupUseAppPasswordInstead => 'Stattdessen App-Passwort verwenden';

  @override
  String get accountSetupUseDifferentAddress => 'Andere Adresse verwenden';

  @override
  String get accountSetupHowToCreateAppPassword => 'So erstellst du ein App-Passwort';

  @override
  String get accountSetupHowToCreateOne => 'So erstellst du eins';

  @override
  String get accountSetupGoogleNote =>
      'Du meldest dich auf der Seite von Google an, und Loupe sieht dein Passwort nie. Erlaube Loupe, deine Mails zu lesen, zu senden und zu organisieren.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Mit Google anmelden“ ist in diesem Build noch nicht verfügbar. Du kannst dich stattdessen mit einem App-Passwort verbinden (dafür ist die Bestätigung in zwei Schritten in deinem Google-Konto nötig).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Erstelle in deinem Google-Konto ein App-Passwort und füge es unten ein.';

  @override
  String get accountSetupMicrosoftNote =>
      'Du meldest dich auf der Seite von Microsoft an, und Loupe sieht dein Passwort nie. Das funktioniert für Outlook.com und Hotmail sowie für Arbeits- oder Schulkonten bei Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Die Anmeldung mit Microsoft kommt in einem späteren Build. Outlook-, Hotmail- und Microsoft-365-Konten brauchen sie: Sie akzeptieren keine Passwörter von Mail-Apps mehr.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail benötigt ein app-spezifisches Passwort, nicht das Passwort deines Apple Accounts.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail benötigt ein App-Passwort, nicht dein Kontopasswort.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe verbindet sich über JMAP mit einem API-Token mit Fastmail: Settings › Privacy & Security › Manage API tokens, für JMAP, mit Zugriff auf E-Mail und Senden.';

  @override
  String get accountSetupFastmailNote => 'Fastmail benötigt für Mail-Apps ein App-Passwort.';

  @override
  String get accountSetupServerSettings => 'Servereinstellungen';

  @override
  String get accountSetupSettingsNotFound => 'Nicht automatisch gefunden';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Gefunden über $source';
  }

  @override
  String get accountSetupEditSettings => 'Einstellungen bearbeiten';

  @override
  String get accountSetupSyncing => 'Deine Mails werden synchronisiert.';

  @override
  String get accountSetupDescription => 'Beschreibung';

  @override
  String get accountSetupDescriptionHint => 'Arbeit, Privat…';

  @override
  String get accountSetupColour => 'Farbe';

  @override
  String accountSetupColourNumber(int number) {
    return 'Farbe $number';
  }

  @override
  String get accountSetupSaving => 'Wird gespeichert…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe konnte seine Mail-Datenbank auf diesem Smartphone nicht öffnen. Schließe Loupe, öffne es erneut und versuche es noch einmal.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Etwas ist schiefgelaufen ($error). Versuche es erneut.';
  }

  @override
  String get accountSetupSecurityNone => 'Keine';

  @override
  String get accountSetupProtocol => 'Protokoll';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Sicherheit';

  @override
  String get accountSetupUsername => 'Benutzername';

  @override
  String get accountSetupUsernameHint => 'Deine E-Mail-Adresse';

  @override
  String get accountSetupNoEncryptionTitle => 'Ohne Verschlüsselung verbinden?';

  @override
  String get accountSetupNoEncryptionText =>
      'Dein Passwort und jede Nachricht würden als Klartext übertragen. Jeder im Netzwerk, etwa in einem öffentlichen WLAN, könnte sie lesen. Verwende das nur für einen Server in deinem eigenen Netzwerk.';

  @override
  String get accountSetupUseWithoutEncryption => 'Ohne Verschlüsselung verwenden';

  @override
  String get accountSetupApiTokenRejected =>
      'API-Token abgelehnt. Erstelle ein Fastmail-API-Token für JMAP mit Zugriff auf E-Mail und füge es ein.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Passwort abgelehnt. Verwende ein App-Passwort, nicht dein Kontopasswort.';

  @override
  String get accountSetupPasswordRejected => 'Passwort abgelehnt. Prüfe es und versuche es erneut.';

  @override
  String get accountSetupServerUnreachable =>
      'Server nicht erreichbar. Prüfe die Servereinstellungen und deine Verbindung.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Dem Zertifikat des Servers wird nicht vertraut. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Die Anmeldung wurde abgebrochen. Tippe auf „Mit $provider anmelden“, um es erneut zu versuchen.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe braucht die Berechtigung, dein Gmail zu lesen und zu senden. Melde dich erneut an und erlaube den Zugriff, mit angehaktem Gmail-Kästchen.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe braucht die Berechtigung, deine Mails zu lesen und zu senden. Melde dich erneut an und akzeptiere die Berechtigungen.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Deine Organisation muss Loupe genehmigen, bevor du es mit diesem Konto verwenden kannst. Bitte deinen IT-Administrator, in Microsoft Entra ID die Administratorzustimmung für Loupe zu erteilen, und versuche es dann erneut.';

  @override
  String get accountSetupOAuthBlocked =>
      'Die Anmelderegeln deiner Organisation erlauben Loupe auf diesem Gerät nicht. Wende dich an deinen IT-Administrator.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider war nicht erreichbar. Prüfe deine Internetverbindung und versuche es erneut.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Die Anmeldung mit $provider ist in dieser Version von Loupe nicht richtig eingerichtet. Bitte melde das.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Die Anmeldung mit $provider hat nicht funktioniert. Versuche es erneut.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider hat dich angemeldet, aber Gmail hat den Zugriff für diese Adresse verweigert. Wähle bei der Anmeldung dasselbe Konto. Bei Arbeits- oder Schulkonten hat der Administrator IMAP möglicherweise deaktiviert.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider hat dich angemeldet, aber der Mailserver hat den Zugriff für diese Adresse verweigert. Wähle bei der Anmeldung dasselbe Konto. Bei Arbeits- oder Schulkonten hat der Administrator IMAP möglicherweise deaktiviert.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Der Mailserver ist nicht erreichbar. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Die Anmeldung mit $provider ist in dieser Version nicht verfügbar.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Erneut angemeldet. $account wird synchronisiert.';
  }

  @override
  String get accountSetupSignInAgain => 'Erneut anmelden';

  @override
  String get accountSetupSigningIn => 'Anmeldung läuft…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider akzeptiert die Anmeldung von Loupe für $email nicht mehr, daher wird $account nicht synchronisiert. Melde dich erneut an, um die Mails zu erhalten.';
  }

  @override
  String get accountImportTitle => 'Aus Thunderbird importieren';

  @override
  String get accountImportPointCamera => 'Richte die Kamera auf den QR-Code, den Thunderbird anzeigt.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$scanned von $total gescannt';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$scanned von $total Codes gescannt',
      one: '$scanned von $total Code gescannt',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bisher $count Konten',
      one: 'Bisher $count Konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Öffne auf deinem Computer Thunderbird und wähle Extras › Auf Mobilgerät exportieren. Wähle deine Konten aus und scanne dann jeden angezeigten Code. Die Codes können in beliebiger Reihenfolge gescannt werden.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mit $count Konten fortfahren',
      one: 'Mit $count Konto fortfahren',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Stattdessen Text einfügen';

  @override
  String get accountImportStartOver => 'Neu beginnen';

  @override
  String get accountImportDuplicateCode => 'Dieser Code wurde bereits hinzugefügt.';

  @override
  String get accountImportRestarted =>
      'Dieser Code stammt aus einem neuen Export, daher wurden die zuvor gescannten Codes beiseitegelegt.';

  @override
  String get accountImportNotThunderbird => 'Das ist kein Thunderbird-Kontocode.';

  @override
  String get accountImportNewerVersion =>
      'Dieser Code stammt aus einem neueren Thunderbird. Aktualisiere Loupe, um ihn zu importieren.';

  @override
  String get accountImportDamaged => 'Dieser Thunderbird-Code konnte nicht gelesen werden.';

  @override
  String get accountImportTooLarge => 'Dieser Code ist zu groß für einen Thunderbird-Export.';

  @override
  String get accountImportCouldNotOpenSettings => 'Die Einstellungen konnten nicht geöffnet werden.';

  @override
  String get accountImportCameraOffTitle => 'Kamerazugriff ist aus';

  @override
  String get accountImportCameraOffText =>
      'Erlaube Loupe in den Einstellungen, die Kamera zum Scannen des Codes zu verwenden, oder füge stattdessen den Text des Codes ein.';

  @override
  String get accountImportNoCameraTitle => 'Keine Kamera';

  @override
  String get accountImportNoCameraText =>
      'Loupe kann hier keine Kamera verwenden. Füge stattdessen den Text des Codes ein.';

  @override
  String get accountImportCameraFailedTitle => 'Die Kamera ist nicht gestartet';

  @override
  String get accountImportCameraFailedText => 'Versuche es erneut oder füge stattdessen den Text des Codes ein.';

  @override
  String get accountImportOpenSettings => 'Einstellungen öffnen';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten gefunden',
      one: '$count Konto gefunden',
      zero: 'Keine Konten gefunden',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Keines der Konten in diesen Codes konnte gelesen werden.';

  @override
  String get accountImportChoose => 'Wähle die Konten aus, die zu Loupe hinzugefügt werden sollen.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Codes $codes von $total wurden nicht gescannt, daher sind ihre Konten nicht aufgeführt.',
      one: 'Code $codes von $total wurde nicht gescannt, daher sind seine Konten nicht aufgeführt.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes und $last';
  }

  @override
  String get accountImportScanMore => 'Weitere Codes scannen';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Konten in den Codes konnten nicht gelesen werden. Sie verwenden möglicherweise Einstellungen aus einem neueren Thunderbird.',
      one:
          '$count Konto in den Codes konnte nicht gelesen werden. Es verwendet möglicherweise Einstellungen aus einem neueren Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Erneut scannen';

  @override
  String get accountImportAlreadyAdded => 'Ein Konto mit dieser Adresse ist bereits in Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Du meldest dich nach dem Hinzufügen mit $provider an, wie in Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Füge das Konto mit einem App-Passwort hinzu (dafür ist die Bestätigung in zwei Schritten nötig).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird meldet sich bei Gmail mit Google an. „Mit Google anmelden“ kommt in einem späteren Build; bis dahin füge das Konto mit einem App-Passwort hinzu (dafür ist die Bestätigung in zwei Schritten nötig).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird meldet sich bei diesem Konto im Browser an. Loupe kann das noch nicht: Verwende ein App-Passwort, falls dein Anbieter eines anbietet.';

  @override
  String get accountImportUnencrypted =>
      'Verbindet sich ohne Verschlüsselung. Verwende das nur in deinem eigenen Netzwerk.';

  @override
  String get accountImportEnterAgain => 'Erneut eingeben';

  @override
  String get accountImportAdded => 'Hinzugefügt';

  @override
  String accountImportAdding(int index, int total) {
    return '$index von $total wird hinzugefügt…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten hinzufügen',
      one: '$count Konto hinzufügen',
      zero: 'Konten hinzufügen',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Exporttext einfügen';

  @override
  String get accountImportPasteText => 'Füge den Text eines Thunderbird-Exportcodes ein, einen Code pro Zeile.';

  @override
  String get accountImportPop3 => 'POP3-Konten werden nicht unterstützt. Loupe behält Mails mit IMAP auf dem Server.';

  @override
  String get accountImportKerberos => 'Dieses Konto meldet sich mit Kerberos an, was Loupe nicht unterstützt.';

  @override
  String get accountImportNtlm => 'Dieses Konto meldet sich mit NTLM an, was Loupe nicht unterstützt.';

  @override
  String get accountImportClientCertificate =>
      'Dieses Konto meldet sich mit einem Client-Zertifikat an, was Loupe noch nicht unterstützt.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Die Anmeldung mit Microsoft kommt in einem späteren Build. Outlook- und Microsoft-365-Konten akzeptieren keine Passwörter von Mail-Apps mehr.';

  @override
  String get accountImportEnterPassword => 'Gib das Passwort ein.';

  @override
  String get accountImportEnterAppPassword => 'Gib das App-Passwort ein.';

  @override
  String get accountImportEnterApiToken => 'Gib das API-Token ein.';

  @override
  String get accountImportStorageFailed => 'Loupe konnte seinen Kontospeicher nicht öffnen. Versuche es später erneut.';

  @override
  String get accountImportFailed =>
      'Das Konto konnte nicht hinzugefügt werden. Versuche es erneut oder füge es manuell hinzu.';

  @override
  String get composeNewMessageTitle => 'Neue Nachricht';

  @override
  String get composeAttach => 'Anhängen';

  @override
  String get composeSendLater => 'Später senden';

  @override
  String composeSendAt(String time) {
    return '$time senden';
  }

  @override
  String get composeSendHint => 'Lange drücken, um später zu senden';

  @override
  String get composeNoAccount => 'Füge ein Konto hinzu, um Mails zu senden.';

  @override
  String get composeTo => 'An:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Von: $email';
  }

  @override
  String get composeFromLabel => 'Von:';

  @override
  String get composeSubjectLabel => 'Betreff:';

  @override
  String composeReplyTo(String address) {
    return 'Antwort an: $address';
  }

  @override
  String get composeFrom => 'Von';

  @override
  String composeReplyFrom(String email) {
    return 'Von $email antworten';
  }

  @override
  String composeSendFrom(String email) {
    return 'Von $email senden';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Von $email antworten?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Von $email senden?';
  }

  @override
  String get composeDismiss => 'Ausblenden';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nicht als Identität gespeichert · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Als Identität speichern';

  @override
  String composeAliasSaved(String email) {
    return '$email ist als Identität gespeichert.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Ungültige Adresse $address';
  }

  @override
  String get composeOriginalNotFound => 'Die ursprüngliche Nachricht wurde nicht gefunden.';

  @override
  String get composeDraftNotFound => 'Der Entwurf wurde nicht gefunden.';

  @override
  String get composeAttachmentsLost => 'Die Anhänge konnten nicht wiederhergestellt werden. Füge sie erneut hinzu.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Einige Anhänge konnten nicht hinzugefügt werden: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Die Anhänge sind insgesamt $size groß; manche Server lehnen so große Nachrichten ab.';
  }

  @override
  String get composeAttachFailed => 'Die Datei konnte nicht angehängt werden.';

  @override
  String get composeInvalidAddressTitle => 'Ungültige Adresse';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ ist keine gültige E-Mail-Adresse.';
  }

  @override
  String get composeNoSubjectTitle => 'Kein Betreff';

  @override
  String get composeNoSubjectText => 'Diese Nachricht hat keinen Betreff. Trotzdem senden?';

  @override
  String get composeSentBeforeChanges =>
      'Sie wurde vor deinen Änderungen gesendet; diese sind in den Entwürfen gespeichert.';

  @override
  String composeScheduled(String time) {
    return 'Geplant für $time';
  }

  @override
  String get composeSending => 'Wird gesendet…';

  @override
  String get composeSent => 'Gesendet';

  @override
  String get composeSendFailed => 'Senden fehlgeschlagen. Versuche es erneut.';

  @override
  String get composeAlreadySent => 'Bereits gesendet.';

  @override
  String get composeDiscardChanges => 'Änderungen verwerfen';

  @override
  String get composeSaveChanges => 'Änderungen speichern';

  @override
  String get composeDeleteDraft => 'Entwurf löschen';

  @override
  String get composeSaveDraft => 'Entwurf speichern';

  @override
  String get composeDraftSaved => 'Entwurf gespeichert';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Am $date um $time schrieb $name:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Am $date um $time schrieb jemand:';
  }

  @override
  String get composeForwardHeader => '---------- Weitergeleitete Nachricht ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Von: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Datum: $date um $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Betreff: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'An: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Später heute';

  @override
  String get composeTomorrowMorning => 'Morgen früh';

  @override
  String get composeMondayMorning => 'Montagmorgen';

  @override
  String get composePickDateTime => 'Datum und Uhrzeit wählen…';

  @override
  String get composeSendWithoutDelay => 'Ohne Verzögerung senden';

  @override
  String composeSendTimeToday(String time) {
    return 'Heute um $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Morgen um $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day um $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Heute $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Morgen $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Entwurf weiter bearbeiten?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Eine Nachricht wurde nicht gesendet, als Loupe geschlossen wurde.',
      'one': 'Eine Nachricht an $name wurde nicht gesendet, als Loupe geschlossen wurde.',
      'other': 'Eine Nachricht an $name und andere wurde nicht gesendet, als Loupe geschlossen wurde.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject“ wurde nicht gesendet, als Loupe geschlossen wurde.',
      'one': '„$subject“ an $name wurde nicht gesendet, als Loupe geschlossen wurde.',
      'other': '„$subject“ an $name und andere wurde nicht gesendet, als Loupe geschlossen wurde.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Weiter bearbeiten';

  @override
  String get composeRecoverySave => 'In Entwürfen speichern';

  @override
  String get composeRecoveryDiscard => 'Verwerfen';

  @override
  String get composeRecoverySaved => 'In Entwürfen gespeichert';

  @override
  String get outboxSectionFailed => 'Nicht gesendet';

  @override
  String get outboxSectionSending => 'Wird gesendet';

  @override
  String get outboxSectionScheduled => 'Geplant';

  @override
  String get outboxStatusQueued => 'Wird gleich gesendet';

  @override
  String get outboxStatusSending => 'Wird gesendet…';

  @override
  String get outboxStatusFailed => 'Nicht gesendet';

  @override
  String get outboxNoRecipients => 'Keine Empfänger';

  @override
  String get outboxNoSubject => '(Kein Betreff)';

  @override
  String get outboxSendingFailed => 'Senden fehlgeschlagen.';

  @override
  String get outboxEmptyTitle => 'Nichts zu senden';

  @override
  String get outboxEmptyText => 'Nachrichten, die du später sendest, warten hier, bis es so weit ist.';

  @override
  String get outboxSendNow => 'Jetzt senden';

  @override
  String get outboxReschedule => 'Neu planen';

  @override
  String get outboxRescheduleMenu => 'Neu planen…';

  @override
  String get outboxRescheduleTitle => 'Neu planen';

  @override
  String outboxRescheduled(String time) {
    return 'Neu geplant für $time';
  }

  @override
  String get outboxCancel => 'Abbrechen';

  @override
  String get outboxCancelSending => 'Senden abbrechen…';

  @override
  String get outboxCancelTitle => 'Senden abbrechen?';

  @override
  String get outboxMoveToDrafts => 'In Entwürfe verschieben';

  @override
  String get outboxDiscard => 'Nachricht verwerfen';

  @override
  String get outboxMovedToDrafts => 'In Entwürfe verschoben';

  @override
  String get outboxDiscarded => 'Nachricht verworfen';

  @override
  String get outboxAlreadySent => 'Bereits gesendet.';

  @override
  String get outboxBeingSent => 'Diese Nachricht wird gerade gesendet.';

  @override
  String get outboxActionFailed => 'Das hat nicht funktioniert. Die Nachricht ist noch im Postausgang.';

  @override
  String get notificationsBadgeInboxes => 'Ungelesen in Posteingängen';

  @override
  String get notificationsBadgeVip => 'Ungelesen in VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Neue Mails von deinen VIPs, in jedem Konto';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Neue Mails in $email';
  }

  @override
  String get notificationsUnknownSender => 'Unbekannter Absender';

  @override
  String get notificationsNoSubject => '(Kein Betreff)';

  @override
  String get notificationsEncryptedMessage => 'Verschlüsselte Nachricht';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Neue Nachricht von $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count neue Nachrichten',
      one: '$count neue Nachricht',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Neue Nachrichten in $account';
  }

  @override
  String get platformInstantChannel => 'Sofortige Zustellung';

  @override
  String get platformInstantChannelDescription =>
      'Wird angezeigt, während Loupe deine Posteingänge auf neue Mails überwacht';

  @override
  String get platformInstantTitle => 'Wartet auf neue Mails';

  @override
  String get platformInstantText => 'Sofortige Zustellung ist an';

  @override
  String get platformErrorBox => 'Beim Anzeigen ist etwas schiefgelaufen. Geh zurück und versuche es erneut.';

  @override
  String get welcomeTagline => 'Mail, die außen einfach\nund innen leistungsstark ist.';

  @override
  String get welcomeAccountsTitle => 'Alle Konten, ein ruhiger Posteingang';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail und jeder IMAP- oder JMAP-Server.';

  @override
  String get welcomeSearchTitle => 'Eine Suche, die findet';

  @override
  String get welcomeSearchText => 'Sofortige Ergebnisse auf deinem Smartphone, dann die vom Server.';

  @override
  String get welcomePrivacyTitle => 'Privat von Grund auf';

  @override
  String get welcomePrivacyText => 'Kein Tracking. Externe Bilder bleiben blockiert, bis du es sagst.';

  @override
  String get welcomeAddAccount => 'Konto hinzufügen';

  @override
  String get welcomeImport => 'Aus Thunderbird importieren';

  @override
  String get welcomeTryDemo => 'Mit Demo-Mails ausprobieren';
}
