// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get commonAdd => 'Dodaj';

  @override
  String get commonCancel => 'Anuluj';

  @override
  String get commonClose => 'Zamknij';

  @override
  String get commonDelete => 'Usuń';

  @override
  String get commonDone => 'Gotowe';

  @override
  String get commonEdit => 'Edytuj';

  @override
  String get commonMore => 'Więcej';

  @override
  String get commonMove => 'Przenieś';

  @override
  String get commonName => 'Nazwa';

  @override
  String get commonNone => 'Brak';

  @override
  String get commonOff => 'Wył.';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Wł.';

  @override
  String get commonOptional => 'Opcjonalnie';

  @override
  String get commonPassword => 'Hasło';

  @override
  String get commonRemove => 'Usuń';

  @override
  String get commonRetry => 'Ponów';

  @override
  String get commonSave => 'Zapisz';

  @override
  String get commonSearch => 'Szukaj';

  @override
  String get commonServer => 'Serwer';

  @override
  String get commonSettings => 'Ustawienia';

  @override
  String get commonShare => 'Udostępnij';

  @override
  String get commonTryAgain => 'Spróbuj ponownie';

  @override
  String get commonUndo => 'Cofnij';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wiadomości',
      few: '$count wiadomości',
      one: '$count wiadomość',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Archiwizuj';

  @override
  String get mailDelete => 'Usuń';

  @override
  String get mailFlag => 'Oflaguj';

  @override
  String get mailForward => 'Przekaż dalej';

  @override
  String get mailMarkAsRead => 'Oznacz jako przeczytane';

  @override
  String get mailMarkAsUnread => 'Oznacz jako nieprzeczytane';

  @override
  String get mailMoveToJunk => 'Przenieś do spamu';

  @override
  String get mailNewMessage => 'Nowa wiadomość';

  @override
  String get mailNoSubject => 'Bez tematu';

  @override
  String get mailReply => 'Odpowiedz';

  @override
  String get mailReplyAll => 'Odpowiedz wszystkim';

  @override
  String get mailSend => 'Wyślij';

  @override
  String get mailUnflag => 'Usuń flagę';

  @override
  String get mailboxArchive => 'Archiwum';

  @override
  String get mailboxDrafts => 'Wersje robocze';

  @override
  String get mailboxInbox => 'Odebrane';

  @override
  String get mailboxJunk => 'Spam';

  @override
  String get mailboxOutbox => 'Skrzynka nadawcza';

  @override
  String get mailboxSent => 'Wysłane';

  @override
  String get mailboxTrash => 'Kosz';

  @override
  String get conversationSomethingWentWrong => 'Coś poszło nie tak. Spróbuj ponownie.';

  @override
  String get conversationReplyToList => 'Odpowiedz na listę';

  @override
  String get conversationReplyList => 'Do listy';

  @override
  String get conversationThreadMuted => 'Wątek wyciszony. Nowe wiadomości w nim będą przychodzić jako przeczytane.';

  @override
  String get conversationThreadUnmuted => 'Wyciszenie wątku wyłączone.';

  @override
  String get conversationLinkFailed => 'Nie udało się otworzyć linku.';

  @override
  String get conversationGoneTitle => 'Brak wiadomości';

  @override
  String get conversationGoneText => 'Ta wiadomość została przeniesiona lub usunięta.';

  @override
  String get conversationMuted => 'Wyciszony';

  @override
  String get conversationReaderOptions => 'Opcje czytania';

  @override
  String get conversationReaderOptionsHint => 'Rozmiar tekstu i widok';

  @override
  String get conversationTrash => 'Do kosza';

  @override
  String get conversationReplyHint => 'Przytrzymaj, aby odpowiedzieć wszystkim lub przekazać dalej';

  @override
  String get conversationOfflineTitle => 'Jesteś offline';

  @override
  String get conversationOfflineText =>
      'Ta konwersacja nie jest jeszcze pobrana. Wczyta się, gdy znów będziesz online.';

  @override
  String get conversationErrorTitle => 'Nie można wyświetlić tej wiadomości';

  @override
  String get conversationErrorText => 'Coś poszło nie tak.';

  @override
  String get conversationOfflineBanner => 'Jesteś offline';

  @override
  String get conversationNotUpdated => 'Nie zaktualizowano';

  @override
  String get conversationMe => 'ja';

  @override
  String get conversationNoSender => '(brak nadawcy)';

  @override
  String get conversationNoRecipients => 'brak odbiorców';

  @override
  String conversationRecipients(String names) {
    return 'do: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'do: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Od';

  @override
  String get conversationHeaderTo => 'Do';

  @override
  String get conversationHeaderCc => 'DW';

  @override
  String get conversationHeaderBcc => 'UDW';

  @override
  String get conversationHeaderReplyTo => 'Odpowiedz do';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Bezpieczeństwo';

  @override
  String get conversationVerifiedSender => 'Zweryfikowany nadawca';

  @override
  String get conversationUnverifiedSender => 'Niezweryfikowany nadawca';

  @override
  String get conversationLoadingMessage => 'Wczytywanie wiadomości';

  @override
  String get conversationBodyError => 'Nie udało się wczytać tej wiadomości.';

  @override
  String get conversationBodyOffline => 'Jesteś offline. Wiadomość wczyta się, gdy znów będziesz online.';

  @override
  String get conversationOriginalHint => 'Lepiej wygląda w widoku „Oryginał”';

  @override
  String get conversationShowOriginal => 'Pokaż oryginał';

  @override
  String get conversationScrollToTop => 'Przewiń na górę';

  @override
  String get conversationTagsMenu => 'Tagi…';

  @override
  String get conversationMuteThread => 'Wycisz wątek';

  @override
  String get conversationUnmuteThread => 'Wyłącz wyciszenie wątku';

  @override
  String get conversationMoveMenu => 'Przenieś…';

  @override
  String get conversationDeletePermanently => 'Usuń trwale';

  @override
  String get conversationMoveToTrash => 'Przenieś do kosza';

  @override
  String get conversationNotJunk => 'To nie spam';

  @override
  String get conversationShowAllHeaders => 'Pokaż wszystkie nagłówki';

  @override
  String get conversationViewSource => 'Pokaż źródło';

  @override
  String get conversationSaveAsFile => 'Zapisz jako plik…';

  @override
  String get conversationShareAsFile => 'Udostępnij jako plik…';

  @override
  String get conversationSearchFromMessageMenu => 'Szukaj na podstawie wiadomości…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopiuj adres';

  @override
  String get conversationAddressCopied => 'Adres skopiowany';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Szukaj wiadomości od: $name';
  }

  @override
  String get conversationTags => 'Tagi';

  @override
  String get conversationAllHeaders => 'Wszystkie nagłówki';

  @override
  String get conversationCopyAll => 'Kopiuj wszystko';

  @override
  String get conversationHeadersCopied => 'Nagłówki skopiowane';

  @override
  String get conversationNoHeaders => 'Brak nagłówków';

  @override
  String get conversationSearchFromMessageTitle => 'Szukaj na podstawie wiadomości';

  @override
  String conversationSearchFrom(String name) {
    return 'Od: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Do: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Temat „$subject”';
  }

  @override
  String get conversationSourceTitle => 'Źródło';

  @override
  String get conversationSourceCopied => 'Źródło skopiowane';

  @override
  String get conversationShareFailed => 'Nie udało się udostępnić wiadomości.';

  @override
  String get conversationWrapLines => 'Zawijaj wiersze';

  @override
  String get conversationDontWrapLines => 'Nie zawijaj wierszy';

  @override
  String get conversationSourceError => 'Nie udało się wczytać źródła.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Pokazano pierwsze $shown z $total. Skopiuj lub udostępnij, aby uzyskać całość.';
  }

  @override
  String get conversationAttachmentUntitled => 'Bez nazwy';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Więcej działań: $name';
  }

  @override
  String get conversationMoveTo => 'Przenieś do…';

  @override
  String get conversationMailboxesError => 'Nie udało się wczytać skrzynek.';

  @override
  String get conversationReaderReadable => 'Czytelny';

  @override
  String get conversationReaderOriginal => 'Oryginał';

  @override
  String get conversationReaderPlain => 'Tekst';

  @override
  String get conversationReaderSans => 'Bezszeryfowa';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Zachowaj oryginalne kolory';

  @override
  String get conversationReaderRemember => 'Zapamiętaj dla tego nadawcy';

  @override
  String get conversationSecurityPossiblePhishing => 'Możliwy phishing';

  @override
  String get conversationSecurityBeCareful => 'Uważaj';

  @override
  String get conversationSecurityVerified => 'Zweryfikowano';

  @override
  String get conversationSecurityNoIssues => 'Nie znaleziono problemów';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count trackerów',
      few: '$count trackery',
      one: '$count tracker',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Pokazuje powód';

  @override
  String get conversationPhishingBannerTitle => 'Ta wiadomość wygląda na phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Linki i obrazy są wyłączone.';
  }

  @override
  String get conversationPhishingBannerText => 'Linki i obrazy są wyłączone.';

  @override
  String get conversationPhishingWhy => 'Dlaczego?';

  @override
  String get conversationPhishingShowAnyway => 'Pokaż mimo to';

  @override
  String get conversationSecurityPhishingTitle => 'To wygląda na phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Kilka oznak wskazuje, że ta wiadomość nie jest tym, za co się podaje.';

  @override
  String get conversationSecurityCarefulTitle => 'Uważaj na tę wiadomość';

  @override
  String get conversationSecurityCarefulText => 'Coś w niej warto sprawdzić jeszcze raz.';

  @override
  String get conversationSecurityVerifiedText => 'Nadawca jest zweryfikowany i nic nie wygląda podejrzanie.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Nic nie wygląda podejrzanie. Twój serwer pocztowy nie podał, czy nadawca jest zweryfikowany.';

  @override
  String get conversationSecurityNothingSuspicious => 'Nic nie wygląda podejrzanie.';

  @override
  String get conversationSecurityWhy => 'Dlaczego';

  @override
  String get conversationSecurityPrivacy => 'Prywatność';

  @override
  String get conversationSecurityNoTrackingPixels => 'Brak pikseli śledzących';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunięto $count pikseli śledzących',
      few: 'Usunięto $count piksele śledzące',
      one: 'Usunięto $count piksel śledzący',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Poinformowałyby nadawcę, kiedy otworzysz tę wiadomość.';

  @override
  String get conversationSecurityNoRemoteImages => 'Brak zdalnych obrazów';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zdalnych obrazów',
      few: '$count zdalne obrazy',
      one: '$count zdalny obraz',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ich wczytanie zdradza nadawcy, kiedy czytasz tę wiadomość, oraz twój adres IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Brak śledzenia kliknięć';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linków przez trackery kliknięć',
      few: '$count linki przez trackery kliknięć',
      one: '$count link przez trackery kliknięć',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Twoje kliknięcie zarejestrowałyby: $services. Przytrzymaj link, aby otworzyć jego cel bezpośrednio.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Szczegóły techniczne';

  @override
  String get conversationSecurityCheckedLocally => 'Sprawdzono na tym urządzeniu. Nic nie zostało nigdzie wysłane.';

  @override
  String get conversationSecurityTrackersLabel => 'Trackery';

  @override
  String get conversationSecurityImagesFrom => 'Obrazy z';

  @override
  String get conversationSecuritySenderHistory => 'Historia z nadawcą';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'odebrane: $received, wysłane: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Linki prowadzą do';

  @override
  String get conversationSecurityHidden => 'Ukryte';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements elementów',
      few: '$elements elementy',
      one: '$elements element',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters znaków',
      few: '$characters znaki',
      one: '$characters znak',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Nadawca niezweryfikowany';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Twój serwer pocztowy nie mógł potwierdzić, że ta wiadomość naprawdę pochodzi z $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Twój serwer pocztowy nie mógł potwierdzić, że ta wiadomość naprawdę pochodzi od swojego nadawcy.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Twój serwer pocztowy nie mógł potwierdzić, że ta wiadomość pochodzi z $domain. To częste w przypadku list mailingowych.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Twój serwer pocztowy nie mógł potwierdzić, że ta wiadomość pochodzi od swojego nadawcy. To częste w przypadku list mailingowych.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Nie reaguj na nią, jeśli nie była oczekiwana. W razie wątpliwości skontaktuj się z nadawcą w inny sposób.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Podpisana przez inną domenę';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Wiadomość jest podpisana przez $signer, a nie $domain. Tak robią serwisy mailingowe, ale nie dowodzi to, kto ją napisał.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Wiadomość jest podpisana przez inną domenę, a nie $domain. Tak robią serwisy mailingowe, ale nie dowodzi to, kto ją napisał.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Nazwa pokazuje inny adres';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Nazwa nadawcy brzmi „$shown”, ale wiadomość pochodzi z $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Ufaj adresowi, nie nazwie.';

  @override
  String get conversationSecurityReplyToTitle => 'Odpowiedzi trafią gdzie indziej';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Odpowiedź trafiłaby na $address, a nie do $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Sprawdź adres, zanim odpowiesz czymś osobistym.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Używa twojego imienia';

  @override
  String get conversationSecurityImpersonationTitle => 'Używa imienia kogoś, kogo znasz';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Jest podpisana „$name”, tak jak ty, ale pochodzi z nowego adresu: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Jest podpisana „$name”, tak jak twój VIP $knownName ($knownEmail), ale pochodzi z nowego adresu: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Jest podpisana „$name”, tak jak $knownName ($knownEmail), ale pochodzi z nowego adresu: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'A odpowiedzi trafiłyby na jeszcze inny adres.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Jeśli prosi o pieniądze, kody lub pliki, najpierw sprawdź to u tej osoby w inny sposób.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Znany adres: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ten adres: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Pierwsza wiadomość od tego nadawcy';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Nie było jeszcze poczty od $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Uważaj na prośby od osób, których jeszcze nie znasz.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Łudząco podobne litery w adresie nadawcy';

  @override
  String get conversationSecurityLinkHomographTitle => 'Łudząco podobne litery w linku';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host miesza litery z różnych alfabetów, aby udawać inny adres.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host używa łudząco podobnych liter: to nie jest $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Usuń ją lub zgłoś jako spam.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Nie otwieraj go.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domena: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Łudząco podobna domena';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Używa znanej nazwy w domenie';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain wygląda jak twoja własna domena $real, ale to inna domena.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain wygląda jak $brand ($real), ale to inna domena.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain używa nazwy twojej własnej domeny $real, ale do niej nie należy.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain używa nazwy $brand ($real), ale do niej nie należy.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Prawdziwe wiadomości od twojej organizacji przychodzą z $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Prawdziwe wiadomości od $brand przychodzą z $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domena nadawcy: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Udaje: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linków ukrywa, dokąd prowadzą',
      few: '$count linki ukrywają, dokąd prowadzą',
      one: 'Link ukrywa, dokąd prowadzi',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Link pokazuje $shown, ale otwiera $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Nie loguj się i nie płać przez te linki. Zamiast tego wpisz adres samodzielnie.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Nie można sprawdzić celu linku';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Link pokazuje $shown, ale prowadzi przez $host, który rejestruje kliknięcie, zanim przekaże je dalej.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Link prowadzi do samego adresu IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nie jest stroną z nazwą. Prawdziwe firmy rzadko tak linkują.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Zamaskowany link';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Link zaczyna się od „$shown@”, aby wyglądać jak $shown, ale otwiera $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Wyłączono ukrytą stronę';

  @override
  String get conversationSecurityDataLinkText =>
      'Link otworzyłby stronę zapakowaną w samej wiadomości, co pozwala obejść sprawdzanie linków.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Prosi o hasło';

  @override
  String get conversationSecurityPasswordFieldText => 'Wiadomość zawierała pole hasła. Loupe je usunęła.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Nigdy nie wpisuj hasła w e-mailu.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Wyłączono link uruchamiający kod';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nigdy nie uruchamia kodu z wiadomości.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Skrócone linki',
      few: 'Skrócone linki',
      one: 'Skrócony link',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts ukrywa prawdziwy cel, dopóki go nie otworzysz.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Międzynarodowy adres internetowy';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts używa liter spoza alfabetu łacińskiego. To normalne w wielu językach; sprawdź, czy to strona, której się spodziewasz.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Dużo ukrytego tekstu';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunięto $count znaków niewidocznego tekstu. Taki ukryty tekst ma oszukać filtry antyspamowe.',
      few: 'Usunięto $count znaki niewidocznego tekstu. Taki ukryty tekst ma oszukać filtry antyspamowe.',
      one: 'Usunięto $count znak niewidocznego tekstu. Taki ukryty tekst ma oszukać filtry antyspamowe.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Usunięto ukryty tekst';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunięto $count znaków niewidocznego tekstu.',
      few: 'Usunięto $count znaki niewidocznego tekstu.',
      one: 'Usunięto $count znak niewidocznego tekstu.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Nie udało się pobrać wiadomości. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String exportSaved(String name) {
    return 'Zapisano „$name”';
  }

  @override
  String get exportSaveFailed => 'Nie udało się zapisać wiadomości.';

  @override
  String exportFailed(String folder) {
    return 'Nie udało się wyeksportować „$folder”.';
  }

  @override
  String exportEmpty(String folder) {
    return '„$folder” nie zawiera wiadomości do wyeksportowania.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Nie udało się wyeksportować „$folder”: nie udało się pobrać żadnej wiadomości. Sprawdź połączenie i spróbuj ponownie.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zapisano „$name” bez $formattedCount wiadomości, których nie udało się pobrać.',
      few: 'Zapisano „$name” bez $formattedCount wiadomości, których nie udało się pobrać.',
      one: 'Zapisano „$name” bez $count wiadomości, której nie udało się pobrać.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Nie udało się zapisać „$name”.';
  }

  @override
  String exportTitle(String folder) {
    return 'Eksportowanie „$folder”';
  }

  @override
  String get exportListing => 'Wyszukiwanie wiadomości…';

  @override
  String exportProgress(String current, String total) {
    return 'Eksportowanie $current z $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nie udało się pobrać $formattedCount wiadomości',
      few: 'Nie udało się pobrać $formattedCount wiadomości',
      one: 'Nie udało się pobrać $count wiadomości',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Skrzynki';

  @override
  String get mailboxesShown => 'Widoczna';

  @override
  String get mailboxesHidden => 'Ukryta';

  @override
  String get mailboxesCollapse => 'Zwiń';

  @override
  String get mailboxesExpand => 'Rozwiń';

  @override
  String get mailboxesManageVips => 'Zarządzaj VIP-ami';

  @override
  String get mailboxesSubscriptions => 'Subskrypcje';

  @override
  String mailboxesShowAccount(String account) {
    return 'Pokaż $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Ukryj $account';
  }

  @override
  String get mailboxesExportFolder => 'Eksportuj folder…';

  @override
  String get mailboxesUnpin => 'Odepnij';

  @override
  String get mailboxesLists => 'Listy mailingowe';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Zapisz wyszukiwanie, aby trzymać je tutaj.';

  @override
  String get mailboxesTags => 'Tagi';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Możesz też stuknąć nazwę nadawcy w wiadomości i włączyć VIP.';

  @override
  String get mailboxesAddVip => 'Dodaj VIP…';

  @override
  String get mailboxesAddVipTitle => 'Dodaj VIP';

  @override
  String get mailboxesAddVipText => 'Poczta z tego adresu dostaje gwiazdkę i pojawia się w skrzynce VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Nieprzeczytane';

  @override
  String get messageListFilterFlagged => 'Oflagowane';

  @override
  String get messageListFilterToMe => 'Do: mnie';

  @override
  String get messageListFilterCcMe => 'DW: mnie';

  @override
  String get messageListFilterWithAttachments => 'Z załącznikami';

  @override
  String get messageListFilterUnreplied => 'Bez odpowiedzi';

  @override
  String get messageListFilterFromVips => 'Od VIP-ów';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Oznaczono $count wiadomości jako przeczytane',
      few: 'Oznaczono $count wiadomości jako przeczytane',
      one: 'Oznaczono $count wiadomość jako przeczytaną',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Nie udało się wczytać starszej poczty.';

  @override
  String get messageListSelectMessages => 'Zaznacz wiadomości';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaznaczono: $count',
      few: 'Zaznaczono: $count',
      one: 'Zaznaczono: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Zaznacz wszystko';

  @override
  String get messageListDeselectAll => 'Odznacz wszystko';

  @override
  String get messageListLoadFailed => 'Nie udało się wczytać poczty';

  @override
  String get messageListNoUnread => 'Brak nieprzeczytanych wiadomości';

  @override
  String get messageListNoMatches => 'Brak pasujących wiadomości';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtry: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Wyłącz filtr';

  @override
  String get messageListEmpty => 'Brak poczty';

  @override
  String get messageListFilter => 'Filtr';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kryteria filtra: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtry:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount nieprzeczytanych',
      few: '$formattedCount nieprzeczytane',
      one: '$formattedCount nieprzeczytana',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Oznacz';

  @override
  String get messageListTrash => 'Do kosza';

  @override
  String get messageListFilterTitle => 'Filtr';

  @override
  String get messageListFilterInclude => 'UWZGLĘDNIJ';

  @override
  String get panesHideMailboxes => 'Ukryj skrzynki';

  @override
  String get panesShowMailboxes => 'Pokaż skrzynki';

  @override
  String get panesMailboxesWidth => 'Szerokość kolumny skrzynek';

  @override
  String get panesListWidth => 'Szerokość listy wiadomości';

  @override
  String get panesNoMessageSelected => 'Nie wybrano wiadomości';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wiadomości',
      few: '$count wiadomości',
      one: '$count wiadomość',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Odłożone';

  @override
  String get snoozeSheetTitle => 'Odłóż';

  @override
  String get snoozeLaterToday => 'Później dzisiaj';

  @override
  String get snoozeThisEvening => 'Dziś wieczorem';

  @override
  String get snoozeTomorrow => 'Jutro';

  @override
  String get snoozeThisWeekend => 'W ten weekend';

  @override
  String get snoozeNextWeek => 'W przyszłym tygodniu';

  @override
  String get snoozePickDateTime => 'Wybierz datę i godzinę…';

  @override
  String get snoozeMenu => 'Odłóż…';

  @override
  String get snoozeWakeNow => 'Przywróć teraz';

  @override
  String get snoozeChangeTimeMenu => 'Zmień czas odłożenia…';

  @override
  String get snoozeChangeTime => 'Zmień czas';

  @override
  String get snoozeNoTime => 'Nie ustawiono godziny';

  @override
  String get snoozeFooter => 'Odłożone wiadomości wracają o ustalonej porze do Odebranych jako nieprzeczytane.';

  @override
  String get snoozeEmptyTitle => 'Nic nie odłożono';

  @override
  String get snoozeEmptyText => 'Odłóż wiadomość, a wróci do Odebranych, gdy będzie ci potrzebna.';

  @override
  String get appLockUnlock => 'Odblokuj';

  @override
  String get appLockFailed => 'Loupe nie mogła potwierdzić, że to ty.';

  @override
  String get appLockLockedOut => 'Zbyt wiele prób. Spróbuj później.';

  @override
  String get appLockPromptError => 'Nie udało się wyświetlić monitu. Spróbuj ponownie.';

  @override
  String get appLockNoScreenLock => 'Ten telefon nie ma blokady ekranu.';

  @override
  String get appLockUnlockPromptTitle => 'Odblokuj Loupe';

  @override
  String get appLockUnlockPromptReason => 'Potwierdź, że to ty, aby zobaczyć pocztę.';

  @override
  String get appLockTurnOnPromptTitle => 'Włącz blokadę aplikacji';

  @override
  String get appLockTurnOnPromptReason => 'Potwierdź, że to ty, aby włączyć blokadę aplikacji.';

  @override
  String get appLockScreenLockRemoved =>
      'Blokada aplikacji jest wyłączona: ten telefon nie ma już blokady ekranu. Ustaw ją, aby ponownie włączyć blokadę aplikacji.';

  @override
  String get appLockAfterImmediately => 'Natychmiast';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      few: '$count minuty',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count godzin',
      few: '$count godziny',
      one: '$count godzina',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Zaszyfrowana';

  @override
  String get openpgpEncryptedInPart => 'Częściowo zaszyfrowana';

  @override
  String get openpgpEncryptedLocked => 'Zaszyfrowana · zablokowana';

  @override
  String get openpgpEncryptedNoKey => 'Zaszyfrowana · brak klucza';

  @override
  String get openpgpEncryptedDamaged => 'Zaszyfrowana · uszkodzona';

  @override
  String get openpgpEncryptedUnsupported => 'Zaszyfrowana · nieobsługiwana';

  @override
  String get openpgpUnknownSigner => 'nieznany';

  @override
  String get openpgpUnknownKey => 'Nieznany klucz';

  @override
  String get openpgpSignatureInvalid => 'Nieprawidłowy podpis';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Podpisano: $name, nie nadawca';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Częściowo podpisano: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Podpisano: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Podpisano odrzuconym kluczem';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Podpisano: $name · klucz niezaakceptowany';
  }

  @override
  String get openpgpUnlock => 'Odblokuj';

  @override
  String get openpgpCantDecrypt => 'Nie można odszyfrować tej wiadomości';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Zaszyfrowana za pomocą OpenPGP';

  @override
  String get openpgpEncryption => 'Szyfrowanie';

  @override
  String get openpgpDecryptedHere => 'Odszyfrowano na tym urządzeniu';

  @override
  String get openpgpNotDecrypted => 'Nie odszyfrowano';

  @override
  String get openpgpKeyLocked => 'Twój klucz jest zablokowany.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dla kluczy $keys',
      few: 'Dla kluczy $keys',
      one: 'Dla klucza $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Chroniony temat';

  @override
  String get openpgpUnlockKey => 'Odblokuj klucz';

  @override
  String get openpgpSignature => 'Podpis';

  @override
  String get openpgpFingerprint => 'Odcisk';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID klucza $id';
  }

  @override
  String get openpgpSigned => 'Podpisano';

  @override
  String get openpgpProblem => 'Problem';

  @override
  String get openpgpAcceptance => 'Akceptacja';

  @override
  String get openpgpChangeAcceptance => 'Zmień akceptację…';

  @override
  String get openpgpCheckedFooter => 'Sprawdzono na tym urządzeniu za pomocą OpenPGP, zgodnie z Thunderbirdem.';

  @override
  String get openpgpSummaryLocked => 'Twój klucz jest zablokowany. Odblokuj go hasłem, aby przeczytać tę wiadomość.';

  @override
  String get openpgpSummaryNoSecretKey => 'Zaszyfrowano ją kluczem, którego nie ma na tym urządzeniu.';

  @override
  String get openpgpSummaryDamaged => 'Zaszyfrowane dane są uszkodzone lub zostały zmienione po drodze.';

  @override
  String get openpgpSummaryUnsupported => 'Używa algorytmu, którego Loupe nie obsługuje.';

  @override
  String get openpgpSummaryEncrypted => 'Mogą ją przeczytać tylko ty i pozostali odbiorcy.';

  @override
  String get openpgpSummaryNotSigned => 'Nie jest podpisana, więc nadawca nie jest potwierdzony.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Jest podpisana, ale kluczem, którego nie masz, więc nie można sprawdzić podpisu.';

  @override
  String get openpgpSummaryBadSignature => 'Podpis się nie zgadza: wiadomość mogła zostać zmieniona.';

  @override
  String get openpgpSummaryMismatch => 'Podpis jest prawidłowy, ale klucz należy do innego adresu niż adres nadawcy.';

  @override
  String get openpgpSummaryPartial =>
      'Podpisana jest tylko część wiadomości. Tekst poza podpisem (na przykład stopka listy mailingowej) jest pokazany pod wierszem „Unsigned content”, a inne części wiadomości, takie jak załączniki, również nie są nim objęte.';

  @override
  String get openpgpSummaryOwnKey => 'Podpisano twoim własnym kluczem.';

  @override
  String get openpgpSummaryVerified => 'Podpis jest prawidłowy, a odcisk klucza został przez ciebie zweryfikowany.';

  @override
  String get openpgpSummaryUnverified => 'Podpis jest prawidłowy. Klucz został zaakceptowany bez sprawdzenia odcisku.';

  @override
  String get openpgpSummaryRejected => 'Podpis jest prawidłowy, ale ten klucz został przez ciebie odrzucony.';

  @override
  String get openpgpSummaryUndecided =>
      'Podpis jest prawidłowy, ale ten klucz nie jest jeszcze zaakceptowany. Porównaj jego odcisk z nadawcą.';

  @override
  String get openpgpAcceptanceRejected => 'Odrzucony';

  @override
  String get openpgpAcceptanceUndecided => 'Niezaakceptowany';

  @override
  String get openpgpAcceptanceUnverified => 'Zaakceptowany';

  @override
  String get openpgpAcceptanceVerified => 'Zaakceptowany i zweryfikowany';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Zaakceptować klucz użytkownika $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Odcisk $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Tak, odcisk jest zweryfikowany';

  @override
  String get openpgpAcceptUnverified => 'Tak, bez sprawdzania';

  @override
  String get openpgpAcceptLater => 'Jeszcze nie';

  @override
  String get openpgpRejectKey => 'Odrzuć ten klucz';

  @override
  String get openpgpNoSubject => '(bez tematu)';

  @override
  String get openpgpEncryptionTitle => 'Szyfrowanie end-to-end';

  @override
  String get openpgpMyKeys => 'Moje klucze OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Mając klucz, możesz czytać zaszyfrowaną pocztę oraz podpisywać i szyfrować własną. Używasz Thunderbirda? Wyeksportuj tam swój klucz (Konfiguracja kont › Szyfrowanie end-to-end › Eksportuj klucz tajny) i zaimportuj go tutaj.';

  @override
  String get openpgpAddKey => 'Dodaj klucz…';

  @override
  String get openpgpAddresses => 'Adresy';

  @override
  String get openpgpAddressesFooter => 'Którego klucza używa każdy adres oraz kiedy szyfruje i podpisuje.';

  @override
  String get openpgpCorrespondentsKeys => 'Klucze OpenPGP korespondentów';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Zaakceptuj klucz, gdy masz pewność, że należy do właściciela; porównaj z nim odcisk, aby oznaczyć klucz jako zweryfikowany.';

  @override
  String get openpgpImportPublicKey => 'Importuj klucz publiczny…';

  @override
  String get openpgpCollected => 'Zebrane przez Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Klucze, które przyszły z wiadomościami. Loupe może szyfrować do nich, gdy obie strony o to proszą.';

  @override
  String get openpgpOnThisDevice => 'Na tym urządzeniu';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Zaszyfrowane wiadomości ukrywają swój temat. Loupe zachowuje temat każdej otwartej wiadomości w swojej zaszyfrowanej bazie danych na tym urządzeniu, aby pokazywały go lista, wyszukiwanie i powiadomienia. W tle Loupe może też odszyfrowywać tematy nowych wiadomości kluczami bez hasła; w tym celu pobiera każdą wiadomość (do 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Odszyfrowuj tematy w tle';

  @override
  String get openpgpIndexFooter =>
      'Wyszukiwanie znajduje zaszyfrowane wiadomości po nadawcy, odbiorcach i temacie. Gdy ta opcja jest włączona, Loupe dodaje też treść każdej odszyfrowanej wiadomości do indeksu wyszukiwania w swojej zaszyfrowanej bazie danych na tym urządzeniu, więc wyszukiwanie znajdzie ją również po treści. Wyłączenie usuwa tę treść z indeksu.';

  @override
  String get openpgpIndexDecrypted => 'Indeksuj odszyfrowane wiadomości do wyszukiwania';

  @override
  String get openpgpPassphrases => 'Hasła kluczy';

  @override
  String get openpgpPassphrasesFooter =>
      'Klucze OpenPGP i certyfikaty S/MIME chronione hasłem są odblokowywane w razie potrzeby. Bez opcji „Zapamiętuj” są ponownie blokowane dwie minuty po każdym użyciu.';

  @override
  String get openpgpRememberPassphrases => 'Zapamiętuj hasła kluczy';

  @override
  String get openpgpRememberPassphrasesDetail => 'Do zamknięcia Loupe';

  @override
  String get openpgpLockKeysNow => 'Zablokuj klucze teraz';

  @override
  String get openpgpKeysLocked => 'Klucze zablokowane.';

  @override
  String get openpgpKeyStateRevoked => 'unieważniony';

  @override
  String get openpgpKeyStateExpired => 'wygasł';

  @override
  String get openpgpKeyStateNeverExpires => 'nie wygasa';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'wygasa $date';
  }

  @override
  String get openpgpNoKey => 'Brak klucza';

  @override
  String get openpgpAlwaysEncrypt => 'Zawsze szyfruj';

  @override
  String get openpgpAddKeyTitle => 'Dodaj klucz OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Zaimportuj klucz, którego używasz w Thunderbirdzie, albo utwórz nowy.';

  @override
  String get openpgpImportFromClipboard => 'Importuj ze schowka';

  @override
  String get openpgpImportFromFile => 'Importuj z pliku';

  @override
  String get openpgpGenerateNewKey => 'Wygeneruj nowy klucz';

  @override
  String get openpgpImportPublicKeyTitle => 'Importuj klucz publiczny';

  @override
  String get openpgpFromClipboard => 'Ze schowka';

  @override
  String get openpgpFromFile => 'Z pliku';

  @override
  String get openpgpClipboardEmpty => 'Schowek jest pusty. Najpierw skopiuj klucz.';

  @override
  String get openpgpKey => 'Klucz';

  @override
  String get openpgpValidityRevoked => 'Unieważniony';

  @override
  String openpgpValidityExpired(String date) {
    return 'Wygasł $date';
  }

  @override
  String get openpgpNeverExpires => 'Nie wygasa';

  @override
  String openpgpValidUntil(String date) {
    return 'Ważny do $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Odcisk skopiowany.';

  @override
  String get openpgpAlgorithm => 'Algorytm';

  @override
  String get openpgpCreated => 'Utworzono';

  @override
  String get openpgpValidity => 'Ważność';

  @override
  String get openpgpProtection => 'Ochrona';

  @override
  String get openpgpProtectionPassphrase => 'Hasło';

  @override
  String get openpgpProtectionKeychain => 'Tylko magazyn kluczy';

  @override
  String get openpgpKeyDetailsFooter =>
      'Udostępnij swój klucz publiczny, aby inni mogli szyfrować wiadomości do ciebie. Kopia zapasowa to twój klucz tajny, chroniony hasłem, jeśli je ma: zachowaj ją dla siebie.';

  @override
  String get openpgpSharePublicKey => 'Udostępnij klucz publiczny';

  @override
  String get openpgpCopyPublicKey => 'Kopiuj klucz publiczny';

  @override
  String get openpgpPublicKeyCopied => 'Klucz publiczny skopiowany.';

  @override
  String get openpgpBackUpSecretKey => 'Utwórz kopię zapasową klucza tajnego';

  @override
  String get openpgpDeleteKey => 'Usuń klucz';

  @override
  String get openpgpRemoveKey => 'Usuń klucz';

  @override
  String get openpgpBackUpTitle => 'Utworzyć kopię zapasową klucza tajnego?';

  @override
  String get openpgpBackUpProtected =>
      'Kopia zapasowa jest chroniona hasłem klucza. Każdy, kto ma jedno i drugie, może czytać twoją pocztę.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ten klucz nie ma hasła: każdy, kto ma kopię zapasową, może czytać twoją pocztę i podpisywać się jako ty.';

  @override
  String get openpgpBackUp => 'Utwórz kopię';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Usunąć twój klucz $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Usunąć klucz użytkownika $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Poczty zaszyfrowanej tym kluczem nie da się już przeczytać na tym urządzeniu, chyba że zaimportujesz go ponownie.';

  @override
  String get openpgpRemoveKeyMessage => 'Możesz go później zaimportować ponownie.';

  @override
  String get openpgpKeyHeader => 'Klucz OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Dodaj klucz w sekcji „Szyfrowanie end-to-end”, aby szyfrować i podpisywać pocztę z tego adresu.';

  @override
  String get openpgpGenerateAKey => 'Wygeneruj klucz…';

  @override
  String get openpgpSending => 'Wysyłanie';

  @override
  String get openpgpSendingFooter =>
      'Automatyczne szyfrowanie włącza się, gdy każdy odbiorca ma zaakceptowany klucz lub zaufany certyfikat albo gdy Autocrypt wskazuje, że chcą tego obie strony. Zaszyfrowana poczta jest zawsze podpisana.';

  @override
  String get openpgpEncryptAutomatically => 'Szyfruj automatycznie';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nie wyśle, gdy odbiorca nie ma klucza';

  @override
  String get openpgpSignUnencrypted => 'Podpisuj niezaszyfrowaną pocztę';

  @override
  String get openpgpAttachPublicKey => 'Dołączaj mój klucz publiczny';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt wysyła twój klucz publiczny z każdą wiadomością, więc inne aplikacje mogą szyfrować do ciebie bez żadnej konfiguracji.';

  @override
  String get openpgpSendMyKey => 'Wysyłaj mój klucz z pocztą';

  @override
  String get openpgpPreferEncryption => 'Preferuj szyfrowanie';

  @override
  String get openpgpPreferEncryptionDetail => 'Proś innych o szyfrowanie, gdy to możliwe';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lat',
      few: '$count lata',
      one: '$count rok',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Hasła nie są zgodne.';

  @override
  String openpgpKeyReady(String id) {
    return 'Twój klucz $id jest gotowy.';
  }

  @override
  String get openpgpNewKey => 'Nowy klucz';

  @override
  String get openpgpNewKeyFor => 'Dla';

  @override
  String get openpgpYourName => 'Imię i nazwisko';

  @override
  String get openpgpAddress => 'Adres';

  @override
  String get openpgpPassphrase => 'Hasło';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opcjonalne. Bez hasła klucz chroni tylko magazyn kluczy telefonu, a Loupe nigdy o nie nie pyta. Z hasłem Loupe zapyta o nie, gdy klucz będzie potrzebny.';

  @override
  String get openpgpRepeatPassphrase => 'Powtórz';

  @override
  String get openpgpExpires => 'Wygasa';

  @override
  String get openpgpExpiresFooter =>
      'Możesz utworzyć nowy klucz, zanim ten wygaśnie. Thunderbird też stosuje trzy lata.';

  @override
  String get openpgpGenerateKey => 'Wygeneruj klucz';

  @override
  String get openpgpKeyFor => 'Klucz dla';

  @override
  String get openpgpCantEncrypt => 'Nie można zaszyfrować';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Brak klucza OpenPGP dla $names, a ten adres zawsze szyfruje. Usuń odbiorcę lub zaimportuj jego klucz w sekcji Ustawienia › Szyfrowanie end-to-end.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Brak ważnego certyfikatu S/MIME dla $names, a ten adres zawsze szyfruje. Usuń odbiorcę lub zaimportuj jego certyfikat w sekcji Ustawienia › Szyfrowanie end-to-end.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Brak klucza OpenPGP dla $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Brak ważnego certyfikatu S/MIME dla $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Wyślij bez szyfrowania';

  @override
  String get openpgpCantSign => 'Nie można podpisać';

  @override
  String get openpgpCantSignMessage =>
      'Klucza prywatnego twojego certyfikatu S/MIME nie ma na tym urządzeniu. Zaimportuj certyfikat ponownie (plik .p12 lub .pfx) w sekcji Ustawienia › Szyfrowanie end-to-end.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Brak klucza dla $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Brak certyfikatu dla $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Klucze z Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Wszyscy mają klucz';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Wszyscy mają certyfikat';

  @override
  String get openpgpComposeEncrypt => 'Szyfruj';

  @override
  String get openpgpComposeSign => 'Podpisz';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, przełącz';
  }

  @override
  String get openpgpNoKeyFound => 'Nie znaleziono klucza OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Zaimportować klucz tajny?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Ten załącznik zawiera klucz tajny ($names). Zaimportuj go jako własny klucz tylko wtedy, gdy pochodzi z twojego eksportu, na przykład z Thunderbirda.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importuj jako mój klucz';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'twój klucz $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaimportować $count kluczy ($names)?',
      few: 'Zaimportować $count klucze ($names)?',
      one: 'Zaimportować klucz użytkownika $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importuj i zaakceptuj';

  @override
  String get openpgpImportDecideLater => 'Importuj, zdecyduj później';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'klucz użytkownika $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Zaimportowano: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Załączono $count kluczy OpenPGP.',
      few: 'Załączono $count klucze OpenPGP.',
      one: 'Załączono klucz OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importuj';

  @override
  String get openpgpUnlockKeyTitle => 'Odblokuj klucz OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Wpisz hasło klucza użytkownika $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Nieprawidłowe hasło. Spróbuj ponownie.';

  @override
  String get openpgpExplainLocked => 'Ta wiadomość jest zaszyfrowana. Odblokuj swój klucz OpenPGP, aby ją przeczytać.';

  @override
  String get openpgpExplainNoKey =>
      'Ta wiadomość jest zaszyfrowana, ale nie dla żadnego klucza OpenPGP na tym urządzeniu. Jeśli czytasz ją w Thunderbirdzie, zaimportuj stamtąd swój klucz: Ustawienia › Szyfrowanie end-to-end.';

  @override
  String get openpgpExplainDamaged =>
      'Ta zaszyfrowana wiadomość jest uszkodzona, więc nie da się jej bezpiecznie odszyfrować.';

  @override
  String get openpgpExplainUnsupported => 'Ta wiadomość używa szyfrowania, którego Loupe jeszcze nie potrafi odczytać.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ta wiadomość jest zaszyfrowana za pomocą S/MIME, ale nie dla żadnego certyfikatu na tym urządzeniu. Zaimportuj swój certyfikat (plik .p12 lub .pfx) w sekcji Ustawienia › Szyfrowanie end-to-end.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ta wiadomość jest zaszyfrowana. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Odblokuj swój certyfikat S/MIME, aby ją przeczytać.';

  @override
  String get openpgpAttachmentGone => 'Ten załącznik nie jest już dostępny.';

  @override
  String get smimeEncrypted => 'Zaszyfrowana (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Zaszyfrowana (S/MIME) · brak certyfikatu';

  @override
  String get smimeEncryptedDamaged => 'Zaszyfrowana (S/MIME) · uszkodzona';

  @override
  String get smimeEncryptedUnsupported => 'Zaszyfrowana (S/MIME) · nieobsługiwana';

  @override
  String get smimeEncryptedLocked => 'Zaszyfrowana (S/MIME) · zablokowana';

  @override
  String get smimeUnknownSigner => 'nieznany';

  @override
  String get smimeSignatureModified => 'Nieprawidłowy podpis: wiadomość zmieniona';

  @override
  String get smimeSignatureWeak => 'Niebezpieczny podpis: przestarzały algorytm';

  @override
  String get smimeSignatureUncheckable => 'Nie można sprawdzić podpisu';

  @override
  String get smimeSignedCertificateMissing => 'Podpisano · brak certyfikatu';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Podpisano: $name · certyfikat odwołany';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Podpisano: $name · w innym terminie';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Podpisano: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Podpisano: $name · nieprawidłowy certyfikat';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Podpisano: $name · niezaufany';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Podpisano: $name · certyfikat wygasł';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Podpisano: $name · certyfikat jeszcze nieważny';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Podpisano: $name · certyfikat nie do poczty';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Podpisano: $name, nie nadawca';
  }

  @override
  String get smimeCantDecrypt => 'Nie można odszyfrować tej wiadomości';

  @override
  String get smimeEncryptedWithSmime => 'Zaszyfrowana za pomocą S/MIME';

  @override
  String get smimeEncryption => 'Szyfrowanie';

  @override
  String get smimeDecryptedHere => 'Odszyfrowano na tym urządzeniu';

  @override
  String get smimeNotDecrypted => 'Nie odszyfrowano';

  @override
  String get smimeAuthenticated => 'uwierzytelnione';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dla $count certyfikatów',
      few: 'dla $count certyfikatów',
      one: 'dla $count certyfikatu',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Podpis';

  @override
  String get smimeIssuedBy => 'Wystawca';

  @override
  String get smimeValid => 'Ważny';

  @override
  String smimeValidRange(String from, String to) {
    return 'od $from do $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Odcisk SHA-256';

  @override
  String get smimeSigned => 'Podpisano';

  @override
  String get smimeProblem => 'Problem';

  @override
  String get smimeCheckingRevocation => 'Sprawdzanie odwołania…';

  @override
  String get smimeNotRevoked => 'Nieodwołany';

  @override
  String get smimeRevoked => 'Odwołany';

  @override
  String get smimeRevocationUnknown => 'Stan odwołania nieznany';

  @override
  String smimeRevokedSince(String date) {
    return 'Od $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Zapytano urząd certyfikacji (lista odwołań), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Zapytano urząd certyfikacji (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Ufaj „$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Ufaj temu certyfikatowi…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Sprawdzono na tym urządzeniu za pomocą S/MIME, zgodnie z Outlookiem i Thunderbirdem; odwołanie sprawdzono w urzędzie certyfikacji.';

  @override
  String get smimeCheckedFooter =>
      'Sprawdzono na tym urządzeniu za pomocą S/MIME, zgodnie z Outlookiem i Thunderbirdem. Odwołanie nie jest sprawdzane (Ustawienia › Szyfrowanie end-to-end).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Ufać $name w przypadku poczty?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Ufać certyfikatowi użytkownika $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Każdy certyfikat wystawiony przez ten urząd będzie zaufany, tak jak urząd certyfikacji twojej firmy. Najpierw porównaj odcisk z właścicielem:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Najpierw porównaj odcisk z właścicielem:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Ufaj';

  @override
  String get smimeSummaryNoKey => 'Zaszyfrowano ją dla certyfikatu, którego nie ma na tym urządzeniu.';

  @override
  String get smimeSummaryDamaged => 'Zaszyfrowane dane są uszkodzone lub zostały zmienione po drodze.';

  @override
  String get smimeSummaryUnsupported => 'Używa algorytmu, którego Loupe nie obsługuje.';

  @override
  String get smimeSummaryLocked => 'Twój certyfikat S/MIME jest zablokowany.';

  @override
  String get smimeSummaryEncrypted => 'Mogą ją przeczytać tylko ty i pozostali odbiorcy.';

  @override
  String get smimeSummaryNotSigned => 'Nie jest podpisana, więc nadawca nie jest potwierdzony.';

  @override
  String get smimeSummaryModified => 'Podpis się nie zgadza: wiadomość została zmieniona po podpisaniu.';

  @override
  String get smimeSummaryUncheckable => 'Nie można sprawdzić podpisu.';

  @override
  String get smimeSummaryNoCertificate => 'Certyfikatu podpisującego nie ma w wiadomości, więc nie można go sprawdzić.';

  @override
  String get smimeSummaryRevoked => 'Urząd certyfikacji odwołał certyfikat podpisującego: podpisowi nie można ufać.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Urząd certyfikacji odwołał certyfikat podpisującego ($reason): podpisowi nie można ufać.';
  }

  @override
  String get smimeDateMismatch =>
      'Podpisano ją ponad godzinę przed datą wiadomości lub po niej: może to być stara wiadomość wysłana ponownie.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Podpis jest prawidłowy, a $issuer poświadcza, że certyfikat należy do nadawcy.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certyfikat lub jeden z jego wystawców jest nieprawidłowy.';

  @override
  String get smimeProblemUntrusted => 'Certyfikat pochodzi od urzędu, któremu Loupe nie ufa.';

  @override
  String get smimeProblemExpired => 'Certyfikat wygasł.';

  @override
  String get smimeProblemNotYetValid => 'Certyfikat nie był jeszcze ważny.';

  @override
  String get smimeProblemWrongUsage => 'Certyfikat nie jest przeznaczony do poczty.';

  @override
  String get smimeProblemWrongAddress => 'Certyfikat należy do innego adresu niż adres nadawcy.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Zaufany · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Niezaufany · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Wygasł $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Ważny od $date';
  }

  @override
  String get smimeTrustInvalid => 'Nieprawidłowy';

  @override
  String get smimeTrustNotForMail => 'Nie do poczty';

  @override
  String get smimeTrustAnotherAddress => 'Inny adres';

  @override
  String get smimeMyCertificates => 'Moje certyfikaty S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Dla S/MIME, którego używa Outlook i wiele firm. Zaimportuj swój certyfikat z kluczem prywatnym (plik .p12 lub .pfx), wyeksportowany z Outlooka, Windowsa, macOS lub Thunderbirda.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Dla S/MIME, którego używa Outlook i wiele firm. Zaimportuj swój certyfikat z kluczem prywatnym (plik .p12 lub .pfx), wyeksportowany z Outlooka, Windowsa, macOS lub Thunderbirda, albo użyj certyfikatu zainstalowanego na tym urządzeniu przez ciebie lub twoją firmę.';

  @override
  String get smimeCertificateExpired => 'wygasł';

  @override
  String smimeCertificateUntil(String date) {
    return 'do $date';
  }

  @override
  String get smimeCertificateOnDevice => 'na tym urządzeniu';

  @override
  String get smimeImportCertificateEllipsis => 'Importuj certyfikat…';

  @override
  String get smimeUseDeviceCertificate => 'Użyj certyfikatu z tego urządzenia…';

  @override
  String get smimeCorrespondentsCertificates => 'Certyfikaty korespondentów';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Zebrane z podpisanej poczty, tak jak robią to Outlook i Thunderbird. Poczta jest szyfrowana tylko dla zaufanych certyfikatów: Loupe ufa urzędom, którym Mozilla ufa w kwestii poczty e-mail, oraz tym, które dodasz.';

  @override
  String get smimeRevocation => 'Odwołanie';

  @override
  String get smimeRevocationFooter =>
      'Gdy otwierasz podpisaną pocztę, Loupe pyta urząd, który wystawił certyfikat podpisującego, czy go nie odwołał (przez jego serwer OCSP lub listę odwołań). Urząd może wtedy widzieć, kiedy ktoś z twojego adresu internetowego czyta pocztę podpisaną tym certyfikatem. Odpowiedzi są przechowywane na tym urządzeniu, dopóki nie wygasną. Odwołany certyfikat jest oznaczony w nagłówku wiadomości jako „certyfikat odwołany”.';

  @override
  String get smimeCheckRevocation => 'Sprawdzaj odwołanie certyfikatów online';

  @override
  String get smimeTrustedAuthorities => 'Zaufane urzędy certyfikacji';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaufane przez ciebie, oprócz $count urzędów, którym Mozilla ufa w kwestii poczty e-mail.',
      few: 'Zaufane przez ciebie, oprócz $count urzędów, którym Mozilla ufa w kwestii poczty e-mail.',
      one: 'Zaufane przez ciebie, oprócz $count urzędu, któremu Mozilla ufa w kwestii poczty e-mail.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Urząd certyfikacji';

  @override
  String get smimeImportACertificate => 'Importuj certyfikat';

  @override
  String get smimeImportContactMessage => 'Certyfikat korespondenta (.cer, .crt, .pem) lub urzędu certyfikacji.';

  @override
  String get smimeFromClipboard => 'Ze schowka';

  @override
  String get smimeFromFile => 'Z pliku';

  @override
  String get smimeClipboardEmpty => 'Schowek jest pusty. Najpierw skopiuj certyfikat.';

  @override
  String get smimeCertificate => 'Certyfikat';

  @override
  String get smimeOnDeviceFooter =>
      'Jego klucz prywatny pozostaje w magazynie danych logowania Androida, gdzie zainstalowała go twoja firma lub ty: Loupe prosi Androida o podpisywanie i odszyfrowywanie nim. Podpisana poczta jest podpisywana podczas wysyłania.';

  @override
  String get smimeAddresses => 'Adresy';

  @override
  String get smimeUsage => 'Przeznaczenie';

  @override
  String get smimeUsageNone => 'Nic, czego używa Loupe';

  @override
  String get smimeUsageSigning => 'Podpisywanie';

  @override
  String get smimeUsageEncryption => 'Szyfrowanie';

  @override
  String get smimeUsageCertificates => 'Certyfikaty';

  @override
  String get smimeAlgorithm => 'Algorytm';

  @override
  String get smimeSerialNumber => 'Numer seryjny';

  @override
  String get smimeFingerprintCopied => 'Odcisk skopiowany.';

  @override
  String get smimeSha1Thumbprint => 'Odcisk palca SHA-1';

  @override
  String get smimePrivateKey => 'Klucz prywatny';

  @override
  String get smimeKeyOnDevice => 'Na tym urządzeniu';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'W Loupe, z hasłem';

  @override
  String get smimeKeyInLoupe => 'W Loupe';

  @override
  String get smimeSource => 'Źródło';

  @override
  String get smimeSourceSignedMail => 'Podpisana poczta';

  @override
  String get smimeSourceImported => 'Zaimportowany';

  @override
  String get smimeTrustHeader => 'Zaufanie';

  @override
  String get smimeTrustedRoot => 'Zaufany główny';

  @override
  String get smimeIssuer => 'Wystawca';

  @override
  String smimeTrustNamed(String name) {
    return 'Ufaj „$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Ufaj temu urzędowi';

  @override
  String get smimeTrustThisCertificate => 'Ufaj temu certyfikatowi';

  @override
  String get smimeStopTrusting => 'Przestań ufać';

  @override
  String get smimePassphrase => 'Hasło';

  @override
  String get smimePassphraseFooter =>
      'Opcjonalne. Z hasłem klucz prywatny jest dodatkowo szyfrowany na tym urządzeniu (Argon2id i AES-256), a Loupe pyta o nie przy podpisywaniu i odszyfrowywaniu; jak długo je pamięta, określa opcja „Zapamiętuj hasła kluczy”. Wysyłana poczta jest podpisywana podczas wysyłania; procesy w tle nie mogą używać klucza.';

  @override
  String get smimeChangePassphrase => 'Zmień hasło…';

  @override
  String get smimeSetPassphraseEllipsis => 'Ustaw hasło…';

  @override
  String get smimeRemovePassphrase => 'Usuń hasło';

  @override
  String get smimeShareCertificate => 'Udostępnij certyfikat';

  @override
  String get smimeDeleteCertificate => 'Usuń certyfikat';

  @override
  String get smimeRemoveCertificate => 'Usuń certyfikat';

  @override
  String get smimePassphraseChanged => 'Hasło zmienione.';

  @override
  String get smimePassphraseSet => 'Hasło ustawione.';

  @override
  String get smimeRemovePassphraseTitle => 'Usunąć hasło?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Klucz prywatny będzie wtedy chroniony tylko przez magazyn kluczy, jak bez hasła: Loupe nie będzie już o nie pytać, a procesy w tle będą mogły go używać.';

  @override
  String get smimePassphraseRemoved => 'Hasło usunięte.';

  @override
  String smimeTrustTitle(String name) {
    return 'Ufać $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Każdy wystawiony przez niego certyfikat będzie zaufany w kwestii poczty. Najpierw porównaj odcisk z właścicielem:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Usunąć twój certyfikat $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Usunąć certyfikat użytkownika $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe przestanie go używać: poczty zaszyfrowanej dla niego nie da się już przeczytać w Loupe. Certyfikat pozostanie na tym urządzeniu (Ustawienia › Zabezpieczenia › Szyfrowanie i dane logowania).';

  @override
  String get smimeDeleteOwnMessage =>
      'Jego klucz prywatny zostanie usunięty z tego urządzenia: poczty zaszyfrowanej dla niego nie da się tu już przeczytać, chyba że zaimportujesz go ponownie.';

  @override
  String get smimeRemoveContactMessage => 'Wróci z następną podpisaną wiadomością od tej osoby.';

  @override
  String get smimeAddressImportFooter =>
      'Zaimportuj certyfikat dla tego adresu, aby podpisywać i szyfrować za pomocą S/MIME, tak jak Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importuj certyfikat…';

  @override
  String get smimePreferFooter =>
      'Gdy oba standardy mogą chronić wiadomość, używany jest preferowany, chyba że tylko drugi ma klucz lub certyfikat dla każdego odbiorcy.';

  @override
  String get smimePreferSmime => 'Preferuj S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Zamiast OpenPGP';

  @override
  String get smimeCertificatePassword => 'Hasło certyfikatu';

  @override
  String get smimeCertificatePasswordPrompt => 'Wpisz hasło, z którym wyeksportowano plik certyfikatu.';

  @override
  String get smimeImport => 'Importuj';

  @override
  String get smimeWrongPassword => 'Nieprawidłowe hasło. Spróbuj ponownie.';

  @override
  String get smimeNoCertificateFound => 'Nie znaleziono certyfikatu.';

  @override
  String smimeCertificateOf(String name) {
    return 'certyfikat użytkownika $name';
  }

  @override
  String get smimeNothingNew => 'Nie ma nic nowego do zaimportowania.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Zaimportowano: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaimportowano $count zaufanych urzędów certyfikacji.',
      few: 'Zaimportowano $count zaufane urzędy certyfikacji.',
      one: 'Zaimportowano zaufany urząd certyfikacji.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaimportowano: $certificates i $count zaufanych urzędów certyfikacji.',
      few: 'Zaimportowano: $certificates i $count zaufane urzędy certyfikacji.',
      one: 'Zaimportowano: $certificates i zaufany urząd certyfikacji.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Ten plik nie zawiera klucza prywatnego. Wyeksportuj certyfikat razem z kluczem prywatnym.';

  @override
  String get smimeImportAsYoursTitle => 'Zaimportować jako twój certyfikat?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Ten załącznik zawiera certyfikat z kluczem prywatnym: $names. Zaimportuj go tylko wtedy, gdy pochodzi z twojego eksportu, na przykład z Outlooka lub Thunderbirda.';
  }

  @override
  String get smimeImportAsMine => 'Importuj jako mój certyfikat';

  @override
  String smimeImportedOwn(String names) {
    return 'Zaimportowano twój certyfikat $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Dodano twój certyfikat $name ($addresses) z tego urządzenia.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Ufać „$name” w przypadku poczty?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe nie zna tego urzędu certyfikacji (może to własny urząd jakiejś firmy). Zaufaj mu, aby sprawdzać wystawiane przez niego certyfikaty. Najpierw porównaj jego odcisk ze swoim działem IT:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Załączono $count certyfikatów.',
      few: 'Załączono $count certyfikaty.',
      one: 'Załączono certyfikat.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importuj certyfikat';

  @override
  String get smimeUnlockTitle => 'Odblokuj certyfikat S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Wpisz hasło certyfikatu użytkownika $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Nieprawidłowe hasło. Spróbuj ponownie.';

  @override
  String get smimeUnlock => 'Odblokuj';

  @override
  String get smimeEnterAPassphrase => 'Wpisz hasło.';

  @override
  String get smimePassphrasesDiffer => 'Hasła się różnią.';

  @override
  String get smimeSetPassphraseTitle => 'Ustaw hasło';

  @override
  String get smimeSetPassphraseText =>
      'Loupe będzie o nie prosić przy podpisywaniu i odszyfrowywaniu. Jeśli je zapomnisz, zaimportuj certyfikat ponownie z pliku .p12.';

  @override
  String get smimePassphraseAgain => 'Ponownie';

  @override
  String get smimeSetPassphraseButton => 'Ustaw';

  @override
  String get smimeLockedOpenAgain =>
      'Twój certyfikat S/MIME jest zablokowany. Otwórz wiadomość ponownie, aby go odblokować.';

  @override
  String get smimeDeviceHasNoCertificates => 'To urządzenie nie udostępnia swoich certyfikatów.';

  @override
  String get smimeCantReadCertificate => 'Loupe nie może odczytać tego certyfikatu.';

  @override
  String get smimeCertificateNotForMail =>
      'Ten certyfikat nie jest przeznaczony do poczty: nie ma adresu e-mail albo nie służy do podpisywania ani szyfrowania.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certyfikatu nie ma już na tym urządzeniu lub Loupe nie może go już używać. Wybierz go ponownie w sekcji Ustawienia › Szyfrowanie end-to-end.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Certyfikatu na tym urządzeniu można używać tylko wtedy, gdy Loupe jest otwarta.';

  @override
  String get smimeDeviceKeyDamaged => 'Zaszyfrowany klucz jest uszkodzony.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certyfikat na tym urządzeniu nie może tego zrobić: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nieobsługiwane';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Błąd certyfikatu na tym urządzeniu: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adres urzędu certyfikacji nie jest adresem internetowym.';

  @override
  String get smimeAuthorityTimeout => 'Urząd certyfikacji nie odpowiedział na czas.';

  @override
  String get smimeAuthorityUnreachable => 'Nie udało się połączyć z urzędem certyfikacji.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Urząd certyfikacji odpowiedział kodem $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Odpowiedź urzędu certyfikacji jest za duża.';

  @override
  String get smimeRevocationNotChecked =>
      'Nie sprawdzono: sprawdzane są tylko certyfikaty od urzędów, którym ufa Loupe.';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsLanguageSystem => 'Jak w telefonie';

  @override
  String get settingsLanguageFooter =>
      'Loupe używa języka telefonu, jeśli go obsługuje, a w przeciwnym razie angielskiego. Język wybrany tutaj dotyczy tylko Loupe, łącznie z powiadomieniami.';

  @override
  String get settingsAccountsHeader => 'Konta';

  @override
  String get settingsAddAccount => 'Dodaj konto';

  @override
  String get settingsMailHeader => 'Poczta';

  @override
  String get settingsSwipeActions => 'Gesty przesunięcia';

  @override
  String get settingsSwipeLeft => 'Przesunięcie w lewo';

  @override
  String get settingsSwipeLeftFooter =>
      'Pełne przesunięcie wykonuje tę akcję. „Oflaguj” i „Więcej” są zawsze dostępne po krótkim przesunięciu.';

  @override
  String get settingsSwipeRight => 'Przesunięcie w prawo';

  @override
  String get settingsSwipeRightFooter => 'Pełne przesunięcie wykonuje tę akcję.';

  @override
  String get settingsSwipeToggleRead => 'Oznacz jako przeczytane / nieprzeczytane';

  @override
  String get settingsSwipeTrash => 'Do kosza';

  @override
  String get settingsSwipeMove => 'Przenieś wiadomość';

  @override
  String get settingsSwipeSnooze => 'Odłóż';

  @override
  String get settingsThreaded => 'Grupuj w konwersacje';

  @override
  String get settingsUndoSendDelay => 'Czas na cofnięcie wysyłki';

  @override
  String get settingsUndoSendDelayFooter => 'Wysłane wiadomości czekają tyle czasu, aby można je było wycofać.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds sekund',
      few: '$seconds sekundy',
      one: '$seconds sekunda',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Wygląd';

  @override
  String get settingsTheme => 'Motyw';

  @override
  String get settingsThemeSystem => 'Automatyczny';

  @override
  String get settingsThemeLight => 'Jasny';

  @override
  String get settingsThemeDark => 'Ciemny';

  @override
  String get settingsDensity => 'Lista wiadomości';

  @override
  String get settingsDensityComfortable => 'Przestronna';

  @override
  String get settingsDensityCompact => 'Kompaktowa';

  @override
  String get settingsReadingHeader => 'Czytanie';

  @override
  String get settingsReadingFooter => 'Zdalne obrazy mogą zdradzić nadawcom, kiedy i gdzie wiadomość została otwarta.';

  @override
  String get settingsDefaultView => 'Widok domyślny';

  @override
  String get settingsDefaultViewFooter => 'Każdą wiadomość możesz przełączyć przyciskiem Aa.';

  @override
  String get settingsViewReadable => 'Czytelny';

  @override
  String get settingsViewReadableDetail => 'Przejrzysty, czytelny, zgodny z trybem ciemnym';

  @override
  String get settingsViewOriginal => 'Oryginał';

  @override
  String get settingsViewOriginalDetail => 'Dokładnie tak, jak zaprojektował ją nadawca';

  @override
  String get settingsViewPlain => 'Zwykły tekst';

  @override
  String get settingsViewPlainDetail => 'Same słowa';

  @override
  String get settingsPlainTextFont => 'Czcionka zwykłego tekstu';

  @override
  String get settingsFontSans => 'Bezszeryfowa';

  @override
  String get settingsFontMono => 'O stałej szerokości';

  @override
  String get settingsFontMonoDetail => 'Zachowuje wyrównanie grafiki ASCII i tabel';

  @override
  String get settingsTechnicalLists => 'Listy techniczne';

  @override
  String get settingsLoadRemoteImages => 'Wczytuj zdalne obrazy';

  @override
  String get settingsOpenLinksDirectly => 'Otwieraj linki bezpośrednio';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Pomijaj trackery kliknięć, gdy cel jest znany';

  @override
  String get settingsSecurityHeader => 'Bezpieczeństwo';

  @override
  String get settingsAppLock => 'Blokada aplikacji';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe pyta przy uruchomieniu oraz po powrocie, jeśli nieobecność trwała dłużej niż czas w opcji „Blokuj po”.';

  @override
  String get settingsAppLockFooterOff =>
      'Blokada aplikacji prosi o odcisk palca, twarz lub blokadę ekranu, zanim pokaże pocztę.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Blokada aplikacji jest nadal wyłączona. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Ustaw kod';

  @override
  String get settingsScreenLockTextIos =>
      'Blokada aplikacji używa Face ID, Touch ID lub kodu, a ten iPhone nie ma kodu. Ustaw go w aplikacji Ustawienia, a potem włącz blokadę aplikacji.';

  @override
  String get settingsScreenLockTitleAndroid => 'Ustaw blokadę ekranu';

  @override
  String get settingsScreenLockTextAndroid =>
      'Blokada aplikacji używa blokady ekranu telefonu albo dodanego do niej odcisku palca lub twarzy, a ten telefon jej nie ma. Ustaw PIN, wzór lub hasło w ustawieniach Androida, a potem włącz blokadę aplikacji.';

  @override
  String get settingsOpenSystemSettings => 'Otwórz ustawienia';

  @override
  String get settingsOpenAndroidSettings => 'Otwórz ustawienia Androida';

  @override
  String get settingsLockAfter => 'Blokuj po';

  @override
  String get settingsLockAfterFooter => 'Jak długo Loupe może działać w tle, zanim znów zapyta.';

  @override
  String get settingsNotifications => 'Powiadomienia';

  @override
  String get settingsEncryption => 'Szyfrowanie end-to-end';

  @override
  String get settingsAdvanced => 'Zaawansowane';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Poczta demonstracyjna to wymyślona skrzynka, która istnieje tylko na tym telefonie. Nic nie jest nigdzie wysyłane.';

  @override
  String get settingsDemoMode => 'Tryb demonstracyjny';

  @override
  String get settingsResetApp => 'Zresetuj aplikację';

  @override
  String get settingsResetFooter => 'Zapomina wszystkie ustawienia i wraca do ekranu powitalnego.';

  @override
  String get settingsResetTitle => 'Zresetować Loupe?';

  @override
  String get settingsResetMessage =>
      'Zostaną zapomniane wszystkie ustawienia, skrzynki Smart Mailbox i ostatnie wyszukiwania, a aplikacja wróci do ekranu powitalnego.';

  @override
  String get settingsAboutHeader => 'Informacje';

  @override
  String get settingsVersion => 'Wersja';

  @override
  String get settingsLicences => 'Licencje';

  @override
  String get settingsPrivacy => 'Prywatność';

  @override
  String get settingsPrivacyDetail =>
      'Loupe nie ma analityki ani śledzenia. Twoja poczta trafia tylko na twoje serwery pocztowe.';

  @override
  String get settingsNotificationsOffIos => 'Powiadomienia dla Loupe są wyłączone w Ustawieniach.';

  @override
  String get settingsNotificationsOffAndroid => 'Powiadomienia dla Loupe są wyłączone w ustawieniach Androida.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nie pozwala Loupe wyświetlać powiadomień. Zezwól na nie w ustawieniach.';
  }

  @override
  String get settingsNewMailHeader => 'Nowa poczta';

  @override
  String get settingsNewMailFooterDemo =>
      'Poczta demonstracyjna nie przychodzi w tle. Wyślij powiadomienie testowe, aby zobaczyć, jak wygląda nowa poczta.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe sprawdza nową pocztę w tle, gdy pozwala na to iOS, co w przypadku rzadko otwieranych aplikacji może się zdarzać co kilka godzin. Dostajesz powiadomienia o nowych wiadomościach w skrzynkach odbiorczych oraz od VIP-ów w dowolnym folderze.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe sprawdza nową pocztę mniej więcej co 15 minut, gdy pozwala na to Android. Dostajesz powiadomienia o nowych wiadomościach w skrzynkach odbiorczych oraz od VIP-ów w dowolnym folderze.';

  @override
  String get settingsNoAccounts => 'Brak kont';

  @override
  String get settingsVipOnly => 'Tylko VIP';

  @override
  String get settingsVipOnlyDetail => 'Tylko wiadomości od twoich VIP-ów';

  @override
  String get settingsHideContent => 'Ukrywaj treść';

  @override
  String get settingsHideContentFooterOn =>
      'Powiadomienia mówią tylko „Nowa wiadomość od” i podają konto, ale nie kto pisze ani o czym.';

  @override
  String get settingsHideContentFooterOff =>
      '„Ukrywaj treść” usuwa nadawcę, temat i podgląd z ekranu blokady i powiadomień.';

  @override
  String get settingsBackgroundAppRefresh => 'Odświeżanie w tle';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Nowa poczta przychodzi w tle tylko wtedy, gdy w Ustawieniach jest włączone Odświeżanie w tle dla Loupe. iOS nie może utrzymywać otwartego połączenia z twoimi skrzynkami odbiorczymi, więc nie ma natychmiastowego dostarczania.';

  @override
  String get settingsInstantDelivery => 'Natychmiastowe dostarczanie';

  @override
  String get settingsInstantDeliveryFooter =>
      'Natychmiastowe dostarczanie (eksperymentalne) utrzymuje otwarte połączenie z twoimi skrzynkami odbiorczymi, więc nowa poczta przychodzi w ciągu kilku sekund. Wyświetla ciche powiadomienie „Oczekiwanie na nową pocztę” i zużywa więcej baterii.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android może zatrzymywać natychmiastowe dostarczanie, aby oszczędzać baterię. Pozwól Loupe używać baterii bez ograniczeń, aby działało bez przerw.';

  @override
  String get settingsExperimental => 'Eksperymentalne';

  @override
  String get settingsComingSoon => 'Wkrótce';

  @override
  String get settingsAllowUnrestrictedBattery => 'Zezwól na nieograniczone użycie baterii';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push pozwala nowej poczcie natychmiast wybudzić Loupe, jeśli twoja usługa poczty to obsługuje. Powiadomienia push idą przez usługę push Google i nie zawierają poczty, tylko „sprawdź teraz”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ten telefon nie może odbierać powiadomień push: wymagają one usług Google Play i połączenia z siecią. Loupe nadal sprawdza nową pocztę mniej więcej co 15 minut.';

  @override
  String get settingsCopyPushToken => 'Kopiuj token push';

  @override
  String get settingsPushTokenCopied => 'Token push skopiowany';

  @override
  String get settingsSendTestNotification => 'Wyślij powiadomienie testowe';

  @override
  String get settingsAppIconBadge => 'Plakietka na ikonie';

  @override
  String get settingsBadgeNote => 'Plakietka aktualizuje się przy każdym sprawdzaniu poczty przez Loupe, także w tle.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Ekran główny tego telefonu nie pokazuje liczb na ikonach aplikacji. Plakietka aktualizuje się przy każdym sprawdzaniu poczty przez Loupe, także w tle.';

  @override
  String get settingsTestNotificationBody => 'Tak wyglądają powiadomienia o nowej poczcie.';

  @override
  String get settingsAccountRemoved => 'To konto zostało usunięte.';

  @override
  String get settingsAccountHeader => 'Konto';

  @override
  String get settingsAccountDescription => 'Opis';

  @override
  String get settingsAccountDescriptionHint => 'Praca, prywatne…';

  @override
  String get settingsEmail => 'E-mail';

  @override
  String get settingsColour => 'Kolor';

  @override
  String get settingsColourFooter => 'Oznacza wiadomości z tego konta w widoku „Wszystkie odebrane”.';

  @override
  String settingsColourNumber(int number) {
    return 'Kolor $number';
  }

  @override
  String get settingsSendingHeader => 'Wysyłanie';

  @override
  String get settingsSendingFooter =>
      'Każda tożsamość ma własny podpis. Odpowiedzi wychodzą z adresu, na który przyszła wiadomość.';

  @override
  String get settingsFoldersHeader => 'Foldery';

  @override
  String get settingsFoldersFooter =>
      'Loupe pokazuje i synchronizuje subskrybowane foldery, tak jak Thunderbird. Odebrane, Wersje robocze, Wysłane, Spam, Kosz i Archiwum są zawsze widoczne.';

  @override
  String get settingsShowAllFolders => 'Pokazuj wszystkie foldery';

  @override
  String get settingsIncoming => 'Przychodząca';

  @override
  String get settingsOutgoing => 'Wychodząca';

  @override
  String get settingsConnectionNotEncrypted => 'Bez szyfrowania';

  @override
  String get settingsSignIn => 'Logowanie';

  @override
  String get settingsSignInExpired => 'Wygasło';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider nie akceptuje już logowania Loupe dla tego konta, więc jego poczta nie jest synchronizowana. Zaloguj się ponownie, aby to naprawić.';
  }

  @override
  String get settingsSignInAgain => 'Zaloguj się ponownie';

  @override
  String get settingsSigningIn => 'Logowanie…';

  @override
  String get settingsRemoveAccount => 'Usuń konto';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Usunąć „$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Jego poczta i ustawienia zostaną usunięte z tego telefonu. Na serwerze nic nie zostanie usunięte.';

  @override
  String get settingsManageFolders => 'Zarządzaj folderami';

  @override
  String get settingsNoFolders => 'Nie ma jeszcze folderów.';

  @override
  String get settingsManageFoldersFooter =>
      'Subskrybowane foldery są widoczne na ekranie Skrzynki i synchronizowane w tle. Inne aplikacje pocztowe na tym samym koncie zwykle też stosują te subskrypcje.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Przechowuje twoje skrzynki Smart Mailbox dla innych urządzeń. Ukryty na ekranie Skrzynki.';

  @override
  String get settingsFolderAlwaysShown => 'Zawsze widoczny';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Subskrybuj $folder';
  }

  @override
  String get settingsIdentities => 'Tożsamości';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Pierwsza tożsamość jest domyślna dla nowych wiadomości. Przeciągnij, aby zmienić kolejność.';

  @override
  String get settingsIdentitiesFooterSingle => 'Domyślna tożsamość dla nowych wiadomości.';

  @override
  String get settingsIdentitiesReplyFooter => 'Odpowiedź wychodzi z tożsamości, na którą przyszła wiadomość.';

  @override
  String get settingsIdentityDefault => 'Domyślna';

  @override
  String settingsIdentityReorder(String email) {
    return 'Zmień kolejność: $email';
  }

  @override
  String get settingsAddIdentity => 'Dodaj tożsamość';

  @override
  String get settingsNewIdentity => 'Nowa tożsamość';

  @override
  String get settingsIdentity => 'Tożsamość';

  @override
  String get settingsIdentityNameHint => 'Imię i nazwisko';

  @override
  String get settingsReplyTo => 'Odpowiedz do';

  @override
  String get settingsSignature => 'Podpis';

  @override
  String get settingsSignatureFooter => 'Dodawany pod „-- ” w wiadomościach z tej tożsamości.';

  @override
  String get settingsNoSignature => 'Brak podpisu';

  @override
  String get settingsCopyToMyself => 'Kopia do siebie';

  @override
  String get settingsCopyToMyselfFooter => 'Dodawane do każdej wiadomości z tej tożsamości.';

  @override
  String get settingsCc => 'DW';

  @override
  String get settingsBcc => 'UDW';

  @override
  String get settingsReplyPatterns => 'Używaj do odpowiedzi na';

  @override
  String get settingsReplyPatternsFooter =>
      'Odpowiedzi na wiadomości wysłane na te adresy wychodzą z tej tożsamości. * oznacza cokolwiek: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Adres lub wzorzec, w którym * oznacza cokolwiek.';

  @override
  String get settingsAddReplyPattern => 'Dodaj adres lub wzorzec';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Usuń $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Nieprawidłowy wzorzec';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input” nie jest adresem ani wzorcem typu *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Brak adresu';

  @override
  String get settingsIdentityNoAddressMessage => 'Wpisz adres e-mail, z którego chcesz wysyłać.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Nieprawidłowy adres';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Odpowiedz do: „$address” nie jest prawidłowym adresem e-mail.',
      'cc': 'DW: „$address” nie jest prawidłowym adresem e-mail.',
      'bcc': 'UDW: „$address” nie jest prawidłowym adresem e-mail.',
      'other': '„$address” nie jest prawidłowym adresem e-mail.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Zapisz tożsamość';

  @override
  String get settingsDiscardChanges => 'Odrzuć zmiany';

  @override
  String get settingsDeleteIdentity => 'Usuń tożsamość';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Usunąć „$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Wiadomości już z niej wysłane pozostaną bez zmian.';

  @override
  String get settingsLastIdentityFooter => 'Konto potrzebuje co najmniej jednej tożsamości.';

  @override
  String get rulesTitle => 'Reguły';

  @override
  String get rulesNewRule => 'Nowa reguła';

  @override
  String get rulesLoadError => 'Nie udało się wczytać reguł.';

  @override
  String get rulesEmptyTitle => 'Brak reguł';

  @override
  String get rulesEmptyText =>
      'Reguły za ciebie segregują, tagują i oflagowują nową pocztę. Utwórz regułę przyciskiem tworzenia powyżej albo z wyszukiwania za pomocą „Utwórz z tego regułę”.';

  @override
  String get rulesListFooter =>
      'Reguły działają od góry do dołu na nowej poczcie w Odebranych. Dotknij reguły i przytrzymaj, aby ją przenieść.';

  @override
  String get rulesChangeError => 'Nie udało się zmienić reguły';

  @override
  String get rulesConditionEveryMessage => 'Każda wiadomość';

  @override
  String rulesMoveRule(String rule) {
    return 'Przenieś $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule włączona';
  }

  @override
  String get rulesServerRulesHeader => 'Reguły na serwerze';

  @override
  String get rulesServerRulesFooter =>
      'Reguły na serwerze działają na serwerze pocztowym, gdy przychodzi poczta, także gdy ten telefon jest wyłączony. Są przechowywane w skrypcie Sieve o nazwie „loupe”.';

  @override
  String get rulesStatusUnknown => 'Nieznany';

  @override
  String get rulesStatusError => 'Nie udało się odpytać serwera.';

  @override
  String get rulesStatusChecking => 'Sprawdzanie…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Uruchamiane z „$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Aktywny skrypt to „$script”. Stuknij, aby uruchamiał też reguły Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Na serwerze nie ma aktywnego skryptu. Zapisanie reguły na serwerze włączy skrypt Loupe.';

  @override
  String get rulesStatusUnavailable => 'Niedostępne';

  @override
  String get rulesStatusNoSieve => 'Serwer tego konta nie obsługuje Sieve (ManageSieve ani JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Przenieś do $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Przenieś do folderu';

  @override
  String rulesActionTag(String tag) {
    return 'Dodaj tag $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Usuń tag $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Zostaw w Odebranych';

  @override
  String rulesActionForward(String address) {
    return 'Przekaż do $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Przekaż do $address, bez kopii';
  }

  @override
  String get rulesActionStop => 'Zatrzymaj';

  @override
  String get rulesNoActions => 'Na razie nic nie robi';

  @override
  String get rulesLocationDevice => 'Urządzenie';

  @override
  String get rulesLocationServer => 'Serwer';

  @override
  String get rulesLocationThisDevice => 'To urządzenie';

  @override
  String get rulesNewRuleTitle => 'Nowa reguła';

  @override
  String get rulesEditRuleTitle => 'Edytuj regułę';

  @override
  String get rulesDefaultNameEveryMessage => 'Każda wiadomość';

  @override
  String get rulesConditionHeader => 'Gdy nowa wiadomość pasuje do';

  @override
  String get rulesConditionFooter =>
      'Wpisz tak jak w wyszukiwaniu: from:, to:, s: (temat), b: (treść), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faktura';

  @override
  String get rulesAccounts => 'Konta';

  @override
  String get rulesAllAccounts => 'Wszystkie konta';

  @override
  String get rulesRemovedAccount => 'Usunięte konto';

  @override
  String get rulesAccountsFooter => 'Reguła dla wszystkich kont obejmuje też konta dodane później.';

  @override
  String get rulesActionsHeader => 'Wtedy';

  @override
  String get rulesForwardingFooter =>
      'Przekazywanie wysyła każdą pasującą wiadomość na inny adres, gdy tylko przyjdzie, także gdy ten telefon jest wyłączony. Niektórzy dostawcy ograniczają ilość przekazywanej poczty.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Przekazywanie działa tylko w regułach na serwerze, więc tutaj go pominięto.';

  @override
  String rulesRemoveAction(String action) {
    return 'Usuń $action';
  }

  @override
  String get rulesAddAction => 'Dodaj akcję';

  @override
  String get rulesAddMove => 'Przenieś do folderu…';

  @override
  String get rulesAddTagMenu => 'Dodaj tag…';

  @override
  String get rulesRemoveTagMenu => 'Usuń tag…';

  @override
  String get rulesAddForward => 'Przekaż do…';

  @override
  String get rulesStopProcessing => 'Nie stosuj kolejnych reguł';

  @override
  String get rulesRunOnHeader => 'Gdzie uruchamiać';

  @override
  String get rulesRunOnDeviceFooter =>
      'To urządzenie stosuje regułę do nowej poczty w Odebranych za każdym razem, gdy Loupe sprawdza pocztę.';

  @override
  String get rulesRunOnServerFooter =>
      'Serwer pocztowy stosuje regułę, gdy przychodzi poczta, także gdy ten telefon jest wyłączony. Wymaga Sieve przez ManageSieve (Dovecot, mailcow) lub JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Zastosuj do istniejących wiadomości…';

  @override
  String get rulesDeleteRule => 'Usuń regułę';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Usunąć „$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Folder na którym koncie?';

  @override
  String get rulesMoveAccountMessage => 'Poczta z pozostałych kont trafi tam do folderu o tej samej nazwie.';

  @override
  String get rulesAddTag => 'Dodaj tag';

  @override
  String get rulesRemoveTag => 'Usuń tag';

  @override
  String get rulesForwardTo => 'Przekaż do';

  @override
  String get rulesForwardToMessage =>
      'Serwer przekazuje każdą pasującą wiadomość na ten adres, także gdy ten telefon jest wyłączony. Użyj adresu, który należy do ciebie lub któremu ufasz.';

  @override
  String get rulesNotAnAddressTitle => 'To nie jest adres e-mail';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address” nie jest adresem, na który można przekazywać.';
  }

  @override
  String get rulesKeepCopyTitle => 'Zachować kopię tutaj?';

  @override
  String get rulesKeepCopy => 'Zachowaj kopię';

  @override
  String get rulesDontKeepCopy => 'Nie zachowuj kopii';

  @override
  String get rulesCheckCondition => 'Sprawdź warunek';

  @override
  String get rulesChooseActionTitle => 'Wybierz akcję';

  @override
  String get rulesChooseActionMessage => 'Dodaj, co reguła ma robić z pasującymi wiadomościami.';

  @override
  String get rulesSaveError => 'Nie udało się zapisać reguły';

  @override
  String get rulesSaveServerError => 'Nie udało się zapisać reguły na serwerze';

  @override
  String get rulesRunOnDeviceInstead => 'Uruchamiaj na tym urządzeniu';

  @override
  String get rulesNothingToApplyTitle => 'Nie ma czego zastosować';

  @override
  String get rulesNothingToApplyMessage => 'Najpierw nadaj regule działający warunek i akcję.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Zastosuj „$rule” do wiadomości w…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Odebrane';

  @override
  String get rulesApplyScopeAll => 'Wszystkie skrzynki';

  @override
  String get rulesFindingMessages => 'Wyszukiwanie wiadomości…';

  @override
  String get rulesSearchError => 'Nie udało się wyszukać';

  @override
  String get rulesSearchErrorUnknown => 'Coś poszło nie tak.';

  @override
  String get rulesNoMatchesTitle => 'Brak pasujących wiadomości';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Nic tam nie pasuje do „$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zastosować „$rule” do $countString wiadomości?',
      few: 'Zastosować „$rule” do $countString wiadomości?',
      one: 'Zastosować „$rule” do $countString wiadomości?',
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
      other: 'Zastosuj do $countString wiadomości',
      few: 'Zastosuj do $countString wiadomości',
      one: 'Zastosuj do $countString wiadomości',
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
      other: 'Zastosowano „$rule” do $countString wiadomości',
      few: 'Zastosowano „$rule” do $countString wiadomości',
      one: 'Zastosowano „$rule” do $countString wiadomości',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Sprawdzanie, co potrafi serwer…';

  @override
  String get rulesServerUnreachable => 'Nie udało się połączyć z serwerem.';

  @override
  String rulesServerProblem(String problem) {
    return 'Nie może działać na serwerze: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Nie może działać na serwerze konta $account: $problem';
  }

  @override
  String get rulesShowScript => 'Pokaż skrypt';

  @override
  String get rulesHideScript => 'Ukryj skrypt';

  @override
  String get rulesMatchingHeader => 'Pasujące wiadomości';

  @override
  String get rulesMatchingHeaderLoading => 'Pasujące wiadomości…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString pasujących wiadomości',
      few: '$countString pasujące wiadomości',
      one: '$countString pasująca wiadomość',
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
      other: '$countString+ pasujących wiadomości',
      few: '$countString+ pasujących wiadomości',
      one: '$countString+ pasujących wiadomości',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Z ostatnich 30 dni. Sama reguła działa tylko na nową pocztę, chyba że zastosujesz ją do istniejących wiadomości.';

  @override
  String rulesConditionError(String error) {
    return 'Warunek zawiera błąd: $error';
  }

  @override
  String get rulesPreviewNoSender => '(brak nadawcy)';

  @override
  String get rulesPreviewNoSubject => '(bez tematu)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'i jeszcze $countString',
      few: 'i jeszcze $countString',
      one: 'i jeszcze $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Nic z ostatnich 30 dni.';

  @override
  String get rulesIncludeTitle => 'Włącz reguły na serwerze';

  @override
  String get rulesIncludeLeaveOff => 'Pozostaw wyłączone';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serwer już uruchamia reguły Loupe dla konta $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script” to aktywny skrypt na serwerze konta $account, więc serwer uruchamia jego, a nie reguły Loupe. Loupe go nie zastąpi. Może dodać do niego te wiersze, a wtedy serwer uruchomi reguły Loupe po własnych regułach skryptu:';
  }

  @override
  String get rulesShowWholeScript => 'Pokaż cały skrypt';

  @override
  String get rulesHideWholeScript => 'Ukryj cały skrypt';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Nic innego w „$script” się nie zmieni. Jeśli jego filtry zostaną później zmienione w poczcie przeglądarkowej, może ona zapisać skrypt na nowo bez tych wierszy; Loupe pokaże wtedy, że reguły na serwerze znów są wyłączone.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Dodaj do „$script”';
  }

  @override
  String get subscriptionsTitle => 'Subskrypcje';

  @override
  String get subscriptionsNewsletters => 'Newslettery';

  @override
  String get subscriptionsDiscussions => 'Dyskusje';

  @override
  String get subscriptionsFilter => 'Filtruj';

  @override
  String get subscriptionsFilterNeverRead => 'Nigdy nieczytane';

  @override
  String get subscriptionsFilterRarelyRead => 'Rzadko czytane';

  @override
  String get subscriptionsFilterAll => 'Wszystkie';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Nie udało się policzyć subskrypcji';

  @override
  String get subscriptionsNoMatches => 'Brak wyników';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Żaden newsletter nie nazywa się „$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Żadna lista nie nazywa się „$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Brak newsletterów';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Newslettery i inna poczta masowa pojawią się tutaj, gdy tylko przyjdą.';

  @override
  String get subscriptionsNothingNeverRead => 'Brak nigdy nieczytanych';

  @override
  String get subscriptionsNothingRarelyRead => 'Brak rzadko czytanych';

  @override
  String get subscriptionsNothingFilteredDetail => 'Czytasz choć trochę wszystkiego, co dostajesz.';

  @override
  String get subscriptionsNoDiscussions => 'Brak dyskusji';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Listy mailingowe, na które można pisać, pojawią się tutaj, gdy przyjdzie z nich poczta.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Listy, na które pisze kilka osób. Dotknij listy i przytrzymaj, aby przypiąć ją do skrzynek, czytać jako zwykły tekst lub przenieść do newsletterów.';

  @override
  String get subscriptionsPrivacyNote =>
      'Policzone na tym telefonie na podstawie pobranej poczty; nic nie jest w tym celu nigdzie wysyłane. Loupe kontaktuje się z nadawcą tylko wtedy, gdy stukniesz „Wypisz się”: wypisanie jednym stuknięciem wysyła tylko „List-Unsubscribe=One-Click” na adres podany przez nadawcę, bez plików cookie i żadnych innych informacji o tobie, i nigdy nie wczytuje jego stron ani obrazów.';

  @override
  String get subscriptionsVolumeNone => 'Ostatnio nic';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / mies.';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / mies.';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'przeczytano $percent';
  }

  @override
  String get subscriptionsStillSending => 'Nadal wysyła';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Wypisano $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Strona wypisania otwarta $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Jednym stuknięciem · kontakt z $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-mailem na $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Na stronie $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Wypisz się';

  @override
  String get subscriptionsUnsubscribeAgain => 'Wypisz się ponownie';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Archiwizuj $countString w Odebranych',
      few: 'Archiwizuj $countString w Odebranych',
      one: 'Archiwizuj $countString w Odebranych',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Utwórz regułę…';

  @override
  String get subscriptionsCreateRuleDetail => 'Przenoś lub archiwizuj przyszłą pocztę';

  @override
  String get subscriptionsTreatAsDiscussion => 'Traktuj jako dyskusję';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Lista, na którą piszą ludzie: czytaj jak forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Traktuj jako newsletter';

  @override
  String get subscriptionsBlockSender => 'Zablokuj nadawcę';

  @override
  String get subscriptionsBlock => 'Zablokuj';

  @override
  String get subscriptionsBlocked => 'Zablokowany';

  @override
  String get subscriptionsBlockedDetail => 'Nowa poczta trafia do spamu';

  @override
  String get subscriptionsPin => 'Przypnij do skrzynek';

  @override
  String get subscriptionsUnpin => 'Odepnij od skrzynek';

  @override
  String get subscriptionsOpenDefaultView => 'Otwieraj w widoku domyślnym';

  @override
  String get subscriptionsOpenPlainText => 'Otwieraj jako zwykły tekst (mono)';

  @override
  String get subscriptionsPinned => 'Przypięta';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString nieprzeczytanych',
      few: '$countString nieprzeczytane',
      one: '$countString nieprzeczytana',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Obecnie brak poczty od tego nadawcy.';

  @override
  String get subscriptionsLatestMessages => 'OSTATNIE WIADOMOŚCI';

  @override
  String get subscriptionsMail => 'Poczta';

  @override
  String get subscriptionsNoneIn90Days => 'Nic od 90 dni';

  @override
  String get subscriptionsRead => 'Przeczytane';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString z $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Ostatnio odebrana';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Foldery', few: 'Foldery', one: 'Folder');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Nadal wysyła';

  @override
  String get subscriptionsUnsubscribedTitle => 'Wypisano';

  @override
  String subscriptionsSince(String date) {
    return 'od $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'strona otwarta $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nie podaje, jak się wypisać.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nie podaje, jak się wypisać. Zamiast tego możesz go zablokować.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Wypisywanie z $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Wypisano z $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Nie udało się wypisać: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Nie udało się wypisać automatycznie';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Wyślij e-mail z prośbą o wypisanie';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Otwórz $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Otworzyć $site?';
  }

  @override
  String get subscriptionsOpen => 'Otwórz';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender umożliwia wypisanie się na swojej stronie. Strona otworzy się w przeglądarce Loupe; dokończ tam.';
  }

  @override
  String get subscriptionsWebInsecure => 'Połączenie z tą stroną nie jest szyfrowane.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Uwaga: ten adres udaje $site za pomocą łudząco podobnych liter.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Uwaga: ten adres udaje inną stronę za pomocą łudząco podobnych liter.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Nie udało się otworzyć $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe zapisze dzisiejszą datę i da ci znać, jeśli $sender nadal będzie pisać.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Wypisać się z $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe skontaktuje się z $site, aby cię wypisać.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'To jedyny przypadek, gdy Loupe kontaktuje się ze stroną nadawcy. Wysyła tylko „List-Unsubscribe=One-Click” na adres podany przez $sender, bez plików cookie i żadnych innych informacji o tobie, i nie wczytuje strony.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Link do wypisania nie jest bezpiecznym adresem w internecie.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site nie odpowiedział na czas.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Nie udało się połączyć z $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site przekierował żądanie na inną stronę, a Loupe nie podąża za przekierowaniami.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site odrzucił żądanie (błąd $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Nie ma konta, z którego można wysłać e-mail z prośbą o wypisanie.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe wyśle e-mail na $to z adresu $from z tematem „$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Wysłano e-mail z prośbą o wypisanie na $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Zablokować $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Nowa poczta z tej listy będzie trafiać do spamu. Możesz to zmienić w sekcji Ustawienia › Reguły.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Nowa poczta z $address będzie trafiać do spamu. Możesz to zmienić w sekcji Ustawienia › Reguły.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Zablokowano $sender.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przenieś $count do spamu',
      few: 'Przenieś $count do spamu',
      one: 'Przenieś $count do spamu',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blokuj $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender jest teraz w newsletterach.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender jest teraz w dyskusjach.';
  }

  @override
  String get appLiveGateTitle => 'Nie udało się otworzyć twoich kont';

  @override
  String get appLiveGateUnavailableBuild => 'Prawdziwe konta nie są jeszcze dostępne w tej wersji.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nie mogła odczytać klucza, który chroni twoją pocztę na tym telefonie. Często jest to chwilowe: spróbuj ponownie lub uruchom telefon ponownie.';

  @override
  String get appLiveGateKeyMissing =>
      'Klucz, który chroni twoją pocztę na tym telefonie, zniknął, co może się zdarzyć po przywróceniu kopii zapasowej. Twoja poczta nadal jest na serwerze.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Nie można odczytać bazy danych poczty na tym telefonie: jest uszkodzona lub zmienił się jej klucz. Twoja poczta nadal jest na serwerze.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Coś poszło nie tak podczas otwierania twoich kont ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'To usunie twoje konta i pocztę zapisaną na tym telefonie, w tym wiadomości czekające w skrzynce nadawczej. Nie dotyczy to poczty na twoich serwerach; potem dodaj konta ponownie.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Usuń i zacznij od nowa';

  @override
  String get appLiveGateUseDemo => 'Użyj poczty demonstracyjnej';

  @override
  String get appLiveGateReset => 'Zresetuj pocztę na tym telefonie…';

  @override
  String get attachmentsUntitled => 'Załącznik';

  @override
  String get attachmentsUntitledFile => 'Bez nazwy';

  @override
  String get attachmentsOpenIn => 'Otwórz w…';

  @override
  String get attachmentsSaveToFiles => 'Zapisz w plikach';

  @override
  String get attachmentsShareMenu => 'Udostępnij…';

  @override
  String get attachmentsDownloadError => 'Nie udało się pobrać załącznika. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get attachmentsShareError => 'Nie udało się udostępnić załącznika.';

  @override
  String attachmentsNoApp(String type) {
    return 'Na tym urządzeniu nie ma aplikacji, która otwiera ten plik ($type). Spróbuj „Udostępnij”.';
  }

  @override
  String get attachmentsOpenInError => 'Nie udało się otworzyć załącznika w innej aplikacji.';

  @override
  String attachmentsSaved(String name) {
    return 'Zapisano „$name”';
  }

  @override
  String get attachmentsSaveError => 'Nie udało się zapisać załącznika.';

  @override
  String get attachmentsGone => 'Ten załącznik nie jest już dostępny.';

  @override
  String get attachmentsDownloadFailed => 'Nie udało się pobrać załącznika.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stron',
      few: '$count strony',
      one: '$count strona',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size przez dane komórkowe';
  }

  @override
  String get attachmentsLargeDownload => 'Ten załącznik jest duży. Pobierz go teraz albo później przez Wi-Fi.';

  @override
  String get attachmentsDownload => 'Pobierz';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Pobieranie $size…';
  }

  @override
  String get attachmentsDownloading => 'Pobieranie…';

  @override
  String get attachmentsTooLarge => 'Za duży, aby wyświetlić tu podgląd.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Pokazano pierwsze $shown z $total. Skopiuj, udostępnij lub zapisz, aby uzyskać całość.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Nie można tu wyświetlić tego pliku PDF (może być chroniony hasłem).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page z $count';
  }

  @override
  String get attachmentsModeTable => 'Tabela';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Wiadomość';

  @override
  String get attachmentsModeSource => 'Źródło';

  @override
  String get attachmentsDontWrap => 'Nie zawijaj wierszy';

  @override
  String get attachmentsWrap => 'Zawijaj wiersze';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines wierszy',
      few: '$lines wiersze',
      one: '$lines wiersz',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopiuj wszystko';

  @override
  String get attachmentsCopied => 'Skopiowano';

  @override
  String get attachmentsImageUnavailable => 'Tego obrazu nie można tu wyświetlić. Spróbuj „Otwórz w…”.';

  @override
  String get attachmentsEmlNoSubject => '(Bez tematu)';

  @override
  String get attachmentsEmlFrom => 'Od';

  @override
  String get attachmentsEmlTo => 'Do';

  @override
  String get attachmentsEmlCc => 'DW';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Ta wiadomość nie zawiera tekstu.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Załączniki: $names',
      few: 'Załączniki: $names',
      one: 'Załącznik: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Organizator: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I jeszcze $count wydarzeń',
      few: 'I jeszcze $count wydarzenia',
      one: 'I jeszcze $count wydarzenie',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Obraz';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Obraz $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Wartości rozdzielane tabulatorami';

  @override
  String get attachmentsTypeCsv => 'Arkusz CSV';

  @override
  String get attachmentsTypeCalendar => 'Wydarzenie kalendarza';

  @override
  String get attachmentsTypeEmail => 'Wiadomość e-mail';

  @override
  String get attachmentsTypeContact => 'Wizytówka';

  @override
  String get attachmentsTypeLog => 'Plik dziennika';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'Archiwum ZIP';

  @override
  String get attachmentsTypeArchive => 'Archiwum';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Arkusz Excel';

  @override
  String get attachmentsTypePowerPoint => 'Prezentacja PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Strona internetowa';

  @override
  String get attachmentsTypeVideo => 'Wideo';

  @override
  String get attachmentsTypeAudio => 'Dźwięk';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Plik $extension';
  }

  @override
  String get attachmentsTypeFile => 'Plik';

  @override
  String get calendarUntitledEvent => 'Wydarzenie';

  @override
  String get calendarAllDay => 'Cały dzień';

  @override
  String calendarYourTime(String time) {
    return '$time twojego czasu';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Dołącz: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name akceptuje zaproszenie: $details',
      'tentative': '$name wstępnie akceptuje zaproszenie: $details',
      'declined': '$name odrzuca zaproszenie: $details',
      'delegated': '$name deleguje zaproszenie: $details',
      'other': '$name nie odpowiada na zaproszenie: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name akceptuje zaproszenie',
      'tentative': '$name wstępnie akceptuje zaproszenie',
      'declined': '$name odrzuca zaproszenie',
      'delegated': '$name deleguje zaproszenie',
      'other': '$name nie odpowiada na zaproszenie',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Mapa';

  @override
  String get calendarJoin => 'Dołącz';

  @override
  String get calendarOnlineMeeting => 'Spotkanie online';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Spotkanie $provider';
  }

  @override
  String get calendarOrganizerYou => 'Ty';

  @override
  String get calendarOrganizerLabel => 'organizator';

  @override
  String get calendarStatusAccepted => 'Zaakceptowano';

  @override
  String get calendarStatusMaybe => 'Może';

  @override
  String get calendarStatusDeclined => 'Odrzucono';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name akceptuje zaproszenie',
      'tentative': '$name wstępnie akceptuje zaproszenie',
      'declined': '$name odrzuca zaproszenie',
      'delegated': '$name deleguje zaproszenie',
      'other': '$name nie odpowiada na zaproszenie',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name akceptuje zaproszenie:',
      'tentative': '$name wstępnie akceptuje zaproszenie:',
      'declined': '$name odrzuca zaproszenie:',
      'delegated': '$name deleguje zaproszenie:',
      'other': '$name nie odpowiada na zaproszenie:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name proponuje nowy termin';
  }

  @override
  String get calendarCounterUnknown => 'Uczestnik proponuje nowy termin';

  @override
  String get calendarDeclineCounter => 'Organizator pozostawił termin bez zmian';

  @override
  String calendarRefresh(String name) {
    return '$name prosi o najnowszą wersję';
  }

  @override
  String get calendarRefreshUnknown => 'Uczestnik prosi o najnowszą wersję';

  @override
  String get calendarCancelled => 'Odwołane';

  @override
  String get calendarCancelledByOrganizer => 'Organizator odwołał to wydarzenie.';

  @override
  String get calendarCancelledLater => 'To wydarzenie zostało później odwołane.';

  @override
  String get calendarOutdated => 'Nieaktualne';

  @override
  String get calendarOutdatedDetail => 'To zaproszenie zostało później zaktualizowane; obowiązuje nowsze.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Usunięto miejsce (było: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Usunięto miejsce (nie było podane)';

  @override
  String calendarLocationChanged(String location) {
    return 'Zmieniono miejsce na $location';
  }

  @override
  String get calendarNewTitle => 'Nowy tytuł';

  @override
  String get calendarRepeatChanged => 'Zmieniono powtarzanie';

  @override
  String get calendarUpdated => 'Zaktualizowano';

  @override
  String get calendarUpdatedInvitation => 'Zaktualizowane zaproszenie';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Zmieniono godzinę z $before na $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Nieznana strefa czasowa „$zone”: godziny tak, jak zapisano';
  }

  @override
  String calendarNext(String when) {
    return 'Następne: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gości',
      few: '$count gości',
      one: '$count gość',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'zaakceptowano: $count',
      few: 'zaakceptowano: $count',
      one: 'zaakceptowano: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'może: $count',
      few: 'może: $count',
      one: 'może: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'odrzucono: $count',
      few: 'odrzucono: $count',
      one: 'odrzucono: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (ty)';
  }

  @override
  String get calendarAttendeeOptional => 'opcjonalnie';

  @override
  String get calendarAttendeeRoom => 'sala';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Twoja odpowiedź na wcześniejszą wersję: akceptacja.',
      'tentative': 'Twoja odpowiedź na wcześniejszą wersję: wstępna akceptacja.',
      'declined': 'Twoja odpowiedź na wcześniejszą wersję: odmowa.',
      'delegated': 'Twoja odpowiedź na wcześniejszą wersję: delegowanie.',
      'other': 'Brak twojej odpowiedzi na wcześniejszą wersję.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Akceptuj';

  @override
  String get calendarMaybe => 'Może';

  @override
  String get calendarDecline => 'Odrzuć';

  @override
  String get calendarCommentHint => 'Komentarz dla organizatora (opcjonalnie)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Twoja odpowiedź trafi do: $organizer, z adresu $address.';
  }

  @override
  String get calendarAddComment => 'Dodaj komentarz';

  @override
  String get calendarAddToCalendar => 'Dodaj do kalendarza';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'I jeszcze $count wydarzeń w pliku',
      few: 'I jeszcze $count wydarzenia w pliku',
      one: 'I jeszcze $count wydarzenie w pliku',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Brak aplikacji kalendarza, do której można dodać wydarzenie.';

  @override
  String get calendarCantOpenCalendar => 'Nie udało się otworzyć kalendarza.';

  @override
  String get calendarCantOpenLink => 'Nie udało się otworzyć linku.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Dołączyć do spotkania $provider?';
  }

  @override
  String get calendarJoinTitle => 'Dołączyć do spotkania?';

  @override
  String calendarJoinOpens(String host) {
    return 'Otwiera $host w przeglądarce.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Uwaga: ten adres udaje $site za pomocą łudząco podobnych liter.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Uwaga: ten adres udaje inną stronę za pomocą łudząco podobnych liter.';

  @override
  String calendarJoinOpen(String host) {
    return 'Otwórz $host';
  }

  @override
  String get calendarNoOrganizer => 'To zaproszenie nie ma organizatora, któremu można odpowiedzieć.';

  @override
  String get calendarNoAccount => 'Nie ma konta, z którego można odpowiedzieć.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Zaakceptowano',
      'tentative': 'Może',
      'other': 'Odrzucono',
    });
    return '$_temp0 · wysyłanie odpowiedzi do: $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Zaakceptowano',
      'tentative': 'Może',
      'other': 'Odrzucono',
    });
    return '$_temp0 · odpowiedź wysłana';
  }

  @override
  String get calendarReplyAlreadySent => 'Odpowiedź została już wysłana.';

  @override
  String get calendarReplyNotSent => 'Nie wysłano odpowiedzi.';

  @override
  String get dataSmimeNeedsDevice =>
      'Twój certyfikat S/MIME jest na tym urządzeniu: otwórz Loupe, aby podpisać i wysłać tę wiadomość.';

  @override
  String dataSigningFailed(String error) {
    return 'Podpisywanie nie powiodło się: $error';
  }

  @override
  String get keyboardShortcuts => 'Skróty klawiszowe';

  @override
  String get keyboardGroupGeneral => 'Ogólne';

  @override
  String get keyboardGroupMessages => 'Wiadomości';

  @override
  String get keyboardGroupCompose => 'Pisanie';

  @override
  String get keyboardCommandPalette => 'Paleta poleceń';

  @override
  String get keyboardBackClose => 'Wstecz, zamknij';

  @override
  String get keyboardNextMessage => 'Następna wiadomość';

  @override
  String get keyboardPreviousMessage => 'Poprzednia wiadomość';

  @override
  String get keyboardOpenMessage => 'Otwórz wiadomość';

  @override
  String get keyboardMoveToTrash => 'Przenieś do kosza';

  @override
  String get keyboardToggleRead => 'Oznacz jako przeczytane lub nieprzeczytane';

  @override
  String get keyboardToggleFlag => 'Oflaguj lub usuń flagę';

  @override
  String get keyboardCloseDraft => 'Zamknij (zapisz lub usuń wersję roboczą)';

  @override
  String get keyboardOr => 'lub';

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
  String get mailingListsMuted => 'Wątek wyciszony. Nowe wiadomości w nim będą przychodzić jako przeczytane.';

  @override
  String get mailingListsUnmuted => 'Wyciszenie wątku wyłączone.';

  @override
  String get mailingListsMuteThread => 'Wycisz wątek';

  @override
  String get mailingListsUnmuteThread => 'Wyłącz wyciszenie wątku';

  @override
  String get mailingListsPin => 'Przypnij do skrzynek';

  @override
  String get mailingListsUnpin => 'Odepnij od skrzynek';

  @override
  String get mailingListsDefaultView => 'Otwieraj w widoku domyślnym';

  @override
  String get mailingListsPlainText => 'Otwieraj jako zwykły tekst (mono)';

  @override
  String get mailingListsShowMuted => 'Pokaż wyciszone wątki';

  @override
  String get mailingListsHideMuted => 'Ukryj wyciszone wątki';

  @override
  String get mailingListsTreatAsNewsletter => 'Traktuj jako newsletter';

  @override
  String get mailingListsOptions => 'Opcje listy';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted nieprzeczytanych',
      few: '$formatted nieprzeczytane',
      one: '$formatted nieprzeczytana',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Nowa wiadomość na listę';

  @override
  String get mailingListsRowUnread => 'Nieprzeczytany';

  @override
  String get mailingListsRowMuted => 'Wyciszony';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odpowiedzi',
      few: '$count odpowiedzi',
      one: '$count odpowiedź',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Brak wątków';

  @override
  String get mailingListsMutedHidden => 'Wyciszone wątki są ukryte.';

  @override
  String get mailingListsTechnicalTitle => 'Listy techniczne';

  @override
  String get mailingListsTechnicalEmpty => 'Listy mailingowe pojawią się tutaj, gdy przyjdzie z nich poczta.';

  @override
  String get mailingListsTechnicalFooter =>
      'Wiadomości z tych list otwierają się jako zwykły tekst czcionką o stałej szerokości, a łatki są pokazywane jako diffy. Przycisk Aa nadal przełącza każdą wiadomość.';

  @override
  String get paletteMoveToMailbox => 'Przenieś do skrzynki…';

  @override
  String get paletteMarkAllRead => 'Oznacz wszystkie jako przeczytane';

  @override
  String get paletteExportFolder => 'Eksportuj folder…';

  @override
  String get paletteGetNewMail => 'Pobierz nową pocztę';

  @override
  String get paletteSnoozed => 'Odłożone';

  @override
  String get paletteSubscriptions => 'Subskrypcje';

  @override
  String get paletteDiscussions => 'Dyskusje';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Lista mailingowa';

  @override
  String get paletteTag => 'Tag';

  @override
  String get paletteSwipeActions => 'Gesty przesunięcia';

  @override
  String get paletteNotifications => 'Powiadomienia';

  @override
  String get paletteRules => 'Reguły';

  @override
  String get paletteEncryption => 'Szyfrowanie end-to-end';

  @override
  String get paletteAdvanced => 'Zaawansowane';

  @override
  String get paletteAddAccount => 'Dodaj konto';

  @override
  String get paletteAccount => 'Konto';

  @override
  String get paletteFolders => 'Foldery';

  @override
  String get paletteRecentSearch => 'Ostatnie wyszukiwanie';

  @override
  String paletteSearchMail(String query) {
    return 'Szukaj w poczcie „$query”';
  }

  @override
  String get palettePlaceholder => 'Szukaj akcji, skrzynek, ustawień';

  @override
  String get paletteNothingFound => 'Nic nie znaleziono';

  @override
  String get searchNewSmartMailbox => 'Nowa skrzynka Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Pokazuje wszystko, co pasuje do „$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Zapisano „$name” w skrzynkach';
  }

  @override
  String get searchMakeRule => 'Utwórz z tego regułę';

  @override
  String get searchSaveSmartMailbox => 'Zapisz jako Smart Mailbox';

  @override
  String get searchNegate => 'Zaneguj';

  @override
  String get searchDontNegate => 'Nie neguj';

  @override
  String get searchAllMailboxes => 'Wszystkie skrzynki';

  @override
  String get searchRecent => 'Ostatnie wyszukiwania';

  @override
  String get searchClear => 'Wyczyść';

  @override
  String get searchSuggestions => 'Sugestie';

  @override
  String get searchUnreadMessages => 'Nieprzeczytane wiadomości';

  @override
  String get searchFlaggedMessages => 'Oflagowane wiadomości';

  @override
  String get searchWithAttachments => 'Wiadomości z załącznikami';

  @override
  String get searchUnrepliedMessages => 'Wiadomości bez odpowiedzi';

  @override
  String get searchTags => 'Tagi';

  @override
  String get searchPeople => 'Osoby';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Od: $name';
  }

  @override
  String get searchSearching => 'Wyszukiwanie…';

  @override
  String get searchNoResults => 'Brak wyników';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted wyników',
      few: '$formatted wyniki',
      one: '$formatted wynik',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menu wyszukiwania';

  @override
  String searchSearchingAccount(String account) {
    return 'Wyszukiwanie w $account na serwerze…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Wyszukiwanie w koncie na serwerze…';

  @override
  String searchAccountFailed(String account) {
    return 'Nie udało się przeszukać $account na serwerze';
  }

  @override
  String get searchUnknownAccountFailed => 'Nie udało się przeszukać konta na serwerze';

  @override
  String searchChip(String term) {
    return '$term. Stuknij dwukrotnie, aby edytować.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Nie $term. Stuknij dwukrotnie, aby edytować.';
  }

  @override
  String get searchReadAndUnread =>
      'Skrzynka Schrödingera: każda wiadomość tutaj jest jednocześnie przeczytana i nieprzeczytana, dopóki jej nie otworzysz.';

  @override
  String searchContradiction(String term) {
    return 'Żadna wiadomość nie może jednocześnie być i nie być „$term”.';
  }

  @override
  String get searchSyncDeviceOnly => 'Tylko na tym urządzeniu';

  @override
  String searchSyncUnsupported(String account) {
    return 'Tylko na tym urządzeniu: $account nie może jej przechowywać';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Nie zsynchronizowano: $account ma nowszy format';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Oczekuje na synchronizację z $account';
  }

  @override
  String searchSynced(String account) {
    return 'Zsynchronizowano z $account';
  }

  @override
  String get searchRename => 'Zmień nazwę';

  @override
  String get searchEditSearch => 'Edytuj wyszukiwanie';

  @override
  String get searchDeleteSmartMailbox => 'Usuń skrzynkę Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Zmień nazwę skrzynki Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Ta skrzynka Smart Mailbox została usunięta.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Skrzynki Smart Mailbox pozostają na tym urządzeniu.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Skrzynki Smart Mailbox są przechowywane na twoim serwerze pocztowym, więc mają je też twoje inne urządzenia oraz Thunderbird z dodatkiem Expression Search Reloaded. Te, które przeszukują wszystkie konta, są przechowywane na koncie $account; te dotyczące jednego folderu – na koncie tego folderu.';
  }

  @override
  String get searchSyncVia => 'Synchronizuj przez';

  @override
  String get searchSyncViaFooter => 'Wybierz to samo konto na każdym urządzeniu.';

  @override
  String get searchGmailCantKeep => 'Gmail nie może przechowywać skrzynek Smart Mailbox';

  @override
  String get searchKeepOnDevice => 'Przechowuj skrzynki Smart Mailbox tylko na tym urządzeniu';

  @override
  String get searchOnTheServer => 'Na serwerze';

  @override
  String get searchServerFooter =>
      'Metadane serwera (IMAP METADATA) nie są widoczne w żadnej aplikacji pocztowej. Serwery bez nich dostają folder „Loupe Settings” z jedną wiadomością; Loupe ukrywa go na ekranie Skrzynki.';

  @override
  String get searchSyncNow => 'Synchronizuj teraz';

  @override
  String get searchStateUnsupported => 'Nieobsługiwane';

  @override
  String get searchStateNewerFormat => 'Nowszy format';

  @override
  String get searchStateFailed => 'Nie udało się zsynchronizować';

  @override
  String get searchStateSyncing => 'Synchronizowanie…';

  @override
  String get searchStateWaiting => 'Oczekiwanie';

  @override
  String get searchStateMetadata => 'Metadane serwera';

  @override
  String get searchStateFolder => 'Folder Loupe Settings';

  @override
  String get searchStateNothing => 'Nic nie zapisano';

  @override
  String get sharedBack => 'Wstecz';

  @override
  String get sharedYesterday => 'Wczoraj';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date o $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bajtów',
      few: '$count bajty',
      one: '$count bajt',
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
  String get sharedSyncNoAccounts => 'Brak kont';

  @override
  String get sharedSyncChecking => 'Sprawdzanie poczty…';

  @override
  String get sharedSyncFailed => 'Nie udało się sprawdzić poczty';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Offline';

  @override
  String get sharedSyncJustNow => 'Zaktualizowano przed chwilą';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Zaktualizowano $minutes minut temu',
      few: 'Zaktualizowano $minutes minuty temu',
      one: 'Zaktualizowano $minutes minutę temu',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Zaktualizowano o $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Zaktualizowano $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Wszystkie odebrane';

  @override
  String get sharedMailboxUnread => 'Nieprzeczytane';

  @override
  String get sharedMailboxFlagged => 'Oflagowane';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Wszystkie wersje robocze';

  @override
  String get sharedMailboxAllSent => 'Wszystkie wysłane';

  @override
  String get sharedMailboxUntitled => 'Skrzynka';

  @override
  String get sharedTagImportant => 'Ważne';

  @override
  String get sharedTagWork => 'Praca';

  @override
  String get sharedTagPersonal => 'Osobiste';

  @override
  String get sharedTagToDo => 'Do zrobienia';

  @override
  String get sharedTagLater => 'Później';

  @override
  String get sharedTags => 'Tagi';

  @override
  String get sharedMoveTo => 'Przenieś do…';

  @override
  String get sharedNoRecipients => 'Brak odbiorców';

  @override
  String get sharedUnknownSender => 'Nieznany nadawca';

  @override
  String get sharedOnServer => 'Na serwerze';

  @override
  String get sharedAttachment => 'Załącznik';

  @override
  String get sharedSnoozedBadge => 'Odłożona';

  @override
  String get sharedRowUnread => 'Nieprzeczytana';

  @override
  String get sharedRowBackFromSnooze => 'Wróciła z odłożonych';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Oflagowana';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zarchiwizowano $count wiadomości',
      few: 'Zarchiwizowano $count wiadomości',
      one: 'Zarchiwizowano $count wiadomość',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunięto $count wiadomości',
      few: 'Usunięto $count wiadomości',
      one: 'Usunięto $count wiadomość',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeniesiono $count wiadomości do Odebranych',
      few: 'Przeniesiono $count wiadomości do Odebranych',
      one: 'Przeniesiono $count wiadomość do Odebranych',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeniesiono $count wiadomości do kosza',
      few: 'Przeniesiono $count wiadomości do kosza',
      one: 'Przeniesiono $count wiadomość do kosza',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeniesiono $count wiadomości do spamu',
      few: 'Przeniesiono $count wiadomości do spamu',
      one: 'Przeniesiono $count wiadomość do spamu',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeniesiono $count wiadomości do $mailbox',
      few: 'Przeniesiono $count wiadomości do $mailbox',
      one: 'Przeniesiono $count wiadomość do $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeniesiono $count wiadomości do skrzynki',
      few: 'Przeniesiono $count wiadomości do skrzynki',
      one: 'Przeniesiono $count wiadomość do skrzynki',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Odłożono $count wiadomości do $time',
      few: 'Odłożono $count wiadomości do $time',
      one: 'Odłożono $count wiadomość do $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Odłożono do $time tylko na tym urządzeniu: serwer nie może przechowywać czasu odłożenia.';
  }

  @override
  String get sharedMoveOneAccount => 'Aby przenieść wiadomości, zaznacz je z jednego konta.';

  @override
  String get sharedSnoozeTitle => 'Odłóż';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Zmień czas odłożenia';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunąć trwale $count wiadomości?',
      few: 'Usunąć trwale $count wiadomości?',
      one: 'Usunąć tę wiadomość trwale?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Tej operacji nie można cofnąć.';

  @override
  String get sharedDeletePermanently => 'Usuń trwale';

  @override
  String get sharedSwipeRead => 'Przeczytane';

  @override
  String get sharedSwipeUnread => 'Nieprzeczytane';

  @override
  String get sharedSwipeInbox => 'Odebrane';

  @override
  String get sharedSwipeDelete => 'Usuń';

  @override
  String get sharedTrash => 'Do kosza';

  @override
  String get sharedSwipeSnooze => 'Odłóż';

  @override
  String get sharedWakeNow => 'Przywróć teraz';

  @override
  String get sharedChangeSnoozeTime => 'Zmień czas odłożenia…';

  @override
  String get sharedSnooze => 'Odłóż…';

  @override
  String get sharedTag => 'Tagi…';

  @override
  String get sharedMoveMessage => 'Przenieś wiadomość…';

  @override
  String get sharedNotJunk => 'To nie spam';

  @override
  String get accountSetupTitle => 'Dodaj konto';

  @override
  String get accountSetupTitleDone => 'Dodano konto';

  @override
  String get accountSetupAddressTitle => 'Dodaj konto pocztowe';

  @override
  String get accountSetupAddressText => 'Loupe znajduje ustawienia większości dostawców.';

  @override
  String get accountSetupNameHint => 'Imię i nazwisko';

  @override
  String get accountSetupEmail => 'E-mail';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Dalej';

  @override
  String get accountSetupLookingUp => 'Wyszukiwanie ustawień…';

  @override
  String get accountSetupImport => 'Importuj z Thunderbirda';

  @override
  String get accountSetupInvalidEmail => 'Wpisz prawidłowy adres e-mail.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Nie udało się znaleźć ustawień dla $domain. Wpisz je poniżej.';
  }

  @override
  String get accountSetupCheckServers => 'Sprawdź nazwy serwerów i porty.';

  @override
  String get accountSetupEnterPassword => 'Wpisz hasło.';

  @override
  String get accountSetupConnecting => 'Łączenie…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Oczekiwanie na $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Nie udało się otworzyć strony.';

  @override
  String get accountSetupCouldNotSaveName => 'Nie udało się zapisać nazwy.';

  @override
  String get accountSetupTrustCertificate => 'Ufaj temu certyfikatowi';

  @override
  String get accountSetupPasswordRequired => 'Wymagane';

  @override
  String get accountSetupShowPassword => 'Pokaż hasło';

  @override
  String get accountSetupHidePassword => 'Ukryj hasło';

  @override
  String get accountSetupAppPassword => 'Hasło aplikacji';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Przychodząca · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Wychodząca · SMTP';

  @override
  String get accountSetupSignIn => 'Zaloguj się';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Zaloguj się przez $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Użyj hasła aplikacji';

  @override
  String get accountSetupUseAppPasswordInstead => 'Użyj zamiast tego hasła aplikacji';

  @override
  String get accountSetupUseDifferentAddress => 'Użyj innego adresu';

  @override
  String get accountSetupHowToCreateAppPassword => 'Jak utworzyć hasło aplikacji';

  @override
  String get accountSetupHowToCreateOne => 'Jak je utworzyć';

  @override
  String get accountSetupGoogleNote =>
      'Logujesz się na stronie Google, a Loupe nigdy nie widzi twojego hasła. Zezwól Loupe na odczytywanie, wysyłanie i porządkowanie twojej poczty.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Zaloguj się przez Google” nie jest jeszcze dostępne w tej wersji. Zamiast tego możesz połączyć się za pomocą hasła aplikacji (wymaga weryfikacji dwuetapowej na koncie Google).';

  @override
  String get accountSetupGmailAppPasswordNote => 'Utwórz hasło aplikacji na swoim koncie Google i wklej je poniżej.';

  @override
  String get accountSetupMicrosoftNote =>
      'Logujesz się na stronie Microsoftu, a Loupe nigdy nie widzi twojego hasła. Działa to dla Outlook.com i Hotmail oraz dla kont służbowych i szkolnych w Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Logowanie przez Microsoft pojawi się w późniejszej wersji. Potrzebują go konta Outlook, Hotmail i Microsoft 365: nie akceptują już haseł z aplikacji pocztowych.';

  @override
  String get accountSetupICloudNote => 'iCloud Mail wymaga hasła dla aplikacji, a nie hasła do konta Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail wymaga hasła aplikacji, a nie hasła do konta.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe łączy się z Fastmail przez JMAP za pomocą tokenu API: Settings › Privacy & Security › Manage API tokens, dla JMAP, z dostępem do poczty i wysyłania.';

  @override
  String get accountSetupFastmailNote => 'Fastmail wymaga hasła aplikacji dla programów pocztowych.';

  @override
  String get accountSetupServerSettings => 'Ustawienia serwera';

  @override
  String get accountSetupSettingsNotFound => 'Nie znaleziono automatycznie';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Znaleziono przez $source';
  }

  @override
  String get accountSetupEditSettings => 'Edytuj ustawienia';

  @override
  String get accountSetupSyncing => 'Twoja poczta jest synchronizowana.';

  @override
  String get accountSetupDescription => 'Opis';

  @override
  String get accountSetupDescriptionHint => 'Praca, prywatne…';

  @override
  String get accountSetupColour => 'Kolor';

  @override
  String accountSetupColourNumber(int number) {
    return 'Kolor $number';
  }

  @override
  String get accountSetupSaving => 'Zapisywanie…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nie mogła otworzyć swojej bazy danych poczty na tym telefonie. Zamknij Loupe, otwórz ją ponownie i spróbuj jeszcze raz.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Coś poszło nie tak ($error). Spróbuj ponownie.';
  }

  @override
  String get accountSetupSecurityNone => 'Brak';

  @override
  String get accountSetupProtocol => 'Protokół';

  @override
  String get accountSetupPort => 'Port';

  @override
  String get accountSetupSecurity => 'Zabezpieczenia';

  @override
  String get accountSetupUsername => 'Nazwa użytkownika';

  @override
  String get accountSetupUsernameHint => 'Twój adres e-mail';

  @override
  String get accountSetupNoEncryptionTitle => 'Połączyć bez szyfrowania?';

  @override
  String get accountSetupNoEncryptionText =>
      'Twoje hasło i każda wiadomość byłyby przesyłane otwartym tekstem. Każdy w sieci, na przykład w publicznym Wi-Fi, mógłby je odczytać. Używaj tego tylko dla serwera w twojej własnej sieci.';

  @override
  String get accountSetupUseWithoutEncryption => 'Używaj bez szyfrowania';

  @override
  String get accountSetupApiTokenRejected =>
      'Token API został odrzucony. Utwórz token API Fastmail dla JMAP z dostępem do poczty i wklej go.';

  @override
  String get accountSetupAppPasswordRejected => 'Hasło zostało odrzucone. Użyj hasła aplikacji, a nie hasła do konta.';

  @override
  String get accountSetupPasswordRejected => 'Hasło zostało odrzucone. Sprawdź je i spróbuj ponownie.';

  @override
  String get accountSetupServerUnreachable =>
      'Nie można połączyć się z serwerem. Sprawdź ustawienia serwera i połączenie.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certyfikat serwera nie jest zaufany. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Logowanie zostało anulowane. Stuknij „Zaloguj się przez $provider”, aby spróbować ponownie.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe potrzebuje uprawnień do odczytu i wysyłania twojej poczty Gmail. Zaloguj się ponownie i zezwól na dostęp, zaznaczając pole Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe potrzebuje uprawnień do odczytu i wysyłania twojej poczty. Zaloguj się ponownie i zaakceptuj uprawnienia.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Twoja organizacja musi zatwierdzić Loupe, zanim będzie można jej używać z tym kontem. Poproś administratora IT o udzielenie zgody administratora dla Loupe w Microsoft Entra ID, a potem spróbuj ponownie.';

  @override
  String get accountSetupOAuthBlocked =>
      'Zasady logowania twojej organizacji nie pozwalają na używanie Loupe na tym urządzeniu. Zwróć się do administratora IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Nie udało się połączyć z $provider. Sprawdź połączenie z internetem i spróbuj ponownie.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Logowanie przez $provider nie jest poprawnie skonfigurowane w tej wersji Loupe. Zgłoś to, proszę.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Logowanie przez $provider nie powiodło się. Spróbuj ponownie.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Logowanie przez $provider się udało, ale Gmail odmówił dostępu dla tego adresu. Podczas logowania wybierz to samo konto. W kontach służbowych lub szkolnych administrator mógł wyłączyć IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Logowanie przez $provider się udało, ale serwer pocztowy odmówił dostępu dla tego adresu. Podczas logowania wybierz to samo konto. W kontach służbowych lub szkolnych administrator mógł wyłączyć IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Nie można połączyć się z serwerem pocztowym. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Logowanie przez $provider nie jest dostępne w tej wersji.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Zalogowano ponownie. Konto $account jest synchronizowane.';
  }

  @override
  String get accountSetupSignInAgain => 'Zaloguj się ponownie';

  @override
  String get accountSetupSigningIn => 'Logowanie…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider nie akceptuje już logowania Loupe dla $email, więc konto $account nie jest synchronizowane. Zaloguj się ponownie, aby odbierać pocztę.';
  }

  @override
  String get accountImportTitle => 'Import z Thunderbirda';

  @override
  String get accountImportPointCamera => 'Skieruj aparat na kod QR wyświetlany przez Thunderbirda.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Zeskanowano $scanned z $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Zeskanowano $scanned z $total kodów',
      few: 'Zeskanowano $scanned z $total kodów',
      one: 'Zeskanowano $scanned z $total kodu',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Na razie $count kont',
      few: 'Na razie $count konta',
      one: 'Na razie $count konto',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Na komputerze otwórz Thunderbirda i wybierz Narzędzia › Eksport na urządzenia mobilne. Zaznacz swoje konta, a potem zeskanuj każdy wyświetlony kod. Kody można skanować w dowolnej kolejności.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kontynuuj z $count kontami',
      few: 'Kontynuuj z $count kontami',
      one: 'Kontynuuj z $count kontem',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Wklej tekst zamiast tego';

  @override
  String get accountImportStartOver => 'Zacznij od nowa';

  @override
  String get accountImportDuplicateCode => 'Ten kod został już dodany.';

  @override
  String get accountImportRestarted =>
      'Ten kod pochodzi z nowego eksportu, więc wcześniej zeskanowane kody zostały odłożone.';

  @override
  String get accountImportNotThunderbird => 'To nie jest kod konta Thunderbirda.';

  @override
  String get accountImportNewerVersion =>
      'Ten kod pochodzi z nowszego Thunderbirda. Zaktualizuj Loupe, aby go zaimportować.';

  @override
  String get accountImportDamaged => 'Nie udało się odczytać tego kodu Thunderbirda.';

  @override
  String get accountImportTooLarge => 'Ten kod jest za duży, aby był eksportem Thunderbirda.';

  @override
  String get accountImportCouldNotOpenSettings => 'Nie udało się otworzyć ustawień.';

  @override
  String get accountImportCameraOffTitle => 'Dostęp do aparatu jest wyłączony';

  @override
  String get accountImportCameraOffText =>
      'Zezwól Loupe na używanie aparatu w ustawieniach, aby zeskanować kod, albo zamiast tego wklej tekst kodu.';

  @override
  String get accountImportNoCameraTitle => 'Brak aparatu';

  @override
  String get accountImportNoCameraText => 'Loupe nie może tu używać aparatu. Zamiast tego wklej tekst kodu.';

  @override
  String get accountImportCameraFailedTitle => 'Aparat się nie uruchomił';

  @override
  String get accountImportCameraFailedText => 'Spróbuj ponownie albo zamiast tego wklej tekst kodu.';

  @override
  String get accountImportOpenSettings => 'Otwórz ustawienia';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Znaleziono $count kont',
      few: 'Znaleziono $count konta',
      one: 'Znaleziono $count konto',
      zero: 'Nie znaleziono kont',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Nie udało się odczytać żadnego konta z tych kodów.';

  @override
  String get accountImportChoose => 'Wybierz konta, które chcesz dodać do Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kody $codes z $total nie zostały zeskanowane, więc ich konta nie są wyświetlane.',
      few: 'Kody $codes z $total nie zostały zeskanowane, więc ich konta nie są wyświetlane.',
      one: 'Kod $codes z $total nie został zeskanowany, więc jego konta nie są wyświetlane.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes i $last';
  }

  @override
  String get accountImportScanMore => 'Skanuj kolejne kody';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nie udało się odczytać $count kont z kodów. Mogą używać ustawień z nowszego Thunderbirda.',
      few: 'Nie udało się odczytać $count kont z kodów. Mogą używać ustawień z nowszego Thunderbirda.',
      one: 'Nie udało się odczytać $count konta z kodów. Może używać ustawień z nowszego Thunderbirda.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skanuj ponownie';

  @override
  String get accountImportAlreadyAdded => 'Konto z tym adresem jest już w Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Po dodaniu zalogujesz się przez $provider, tak jak w Thunderbirdzie.';
  }

  @override
  String get accountImportGmailAppPassword => 'Dodaj konto za pomocą hasła aplikacji (wymaga weryfikacji dwuetapowej).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird loguje się do Gmaila przez Google. „Zaloguj się przez Google” pojawi się w późniejszej wersji; do tego czasu dodaj konto za pomocą hasła aplikacji (wymaga weryfikacji dwuetapowej).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird loguje się do tego konta w przeglądarce. Loupe jeszcze tego nie potrafi: użyj hasła aplikacji, jeśli twój dostawca je oferuje.';

  @override
  String get accountImportUnencrypted => 'Łączy się bez szyfrowania. Używaj tego tylko we własnej sieci.';

  @override
  String get accountImportEnterAgain => 'Wpisz je ponownie';

  @override
  String get accountImportAdded => 'Dodano';

  @override
  String accountImportAdding(int index, int total) {
    return 'Dodawanie $index z $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dodaj $count kont',
      few: 'Dodaj $count konta',
      one: 'Dodaj $count konto',
      zero: 'Dodaj konta',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Wklej tekst eksportu';

  @override
  String get accountImportPasteText => 'Wklej tekst kodu eksportu z Thunderbirda, jeden kod w wierszu.';

  @override
  String get accountImportPop3 => 'Konta POP3 nie są obsługiwane. Loupe przechowuje pocztę na serwerze przez IMAP.';

  @override
  String get accountImportKerberos => 'To konto loguje się przez Kerberos, którego Loupe nie obsługuje.';

  @override
  String get accountImportNtlm => 'To konto loguje się przez NTLM, którego Loupe nie obsługuje.';

  @override
  String get accountImportClientCertificate =>
      'To konto loguje się za pomocą certyfikatu klienta, którego Loupe jeszcze nie obsługuje.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Logowanie przez Microsoft pojawi się w późniejszej wersji. Konta Outlook i Microsoft 365 nie akceptują już haseł z aplikacji pocztowych.';

  @override
  String get accountImportEnterPassword => 'Wpisz hasło.';

  @override
  String get accountImportEnterAppPassword => 'Wpisz hasło aplikacji.';

  @override
  String get accountImportEnterApiToken => 'Wpisz token API.';

  @override
  String get accountImportStorageFailed => 'Loupe nie mogła otworzyć magazynu kont. Spróbuj później.';

  @override
  String get accountImportFailed => 'Nie udało się dodać konta. Spróbuj ponownie lub dodaj je ręcznie.';

  @override
  String get composeNewMessageTitle => 'Nowa wiadomość';

  @override
  String get composeAttach => 'Załącz';

  @override
  String get composeSendLater => 'Wyślij później';

  @override
  String composeSendAt(String time) {
    return 'Wyślij $time';
  }

  @override
  String get composeSendHint => 'Przytrzymaj, aby wysłać później';

  @override
  String get composeNoAccount => 'Dodaj konto, aby wysyłać pocztę.';

  @override
  String get composeTo => 'Do:';

  @override
  String get composeCc => 'DW:';

  @override
  String get composeBcc => 'UDW:';

  @override
  String composeCcBccFrom(String email) {
    return 'DW/UDW, od: $email';
  }

  @override
  String get composeFromLabel => 'Od:';

  @override
  String get composeSubjectLabel => 'Temat:';

  @override
  String composeReplyTo(String address) {
    return 'Odpowiedz do: $address';
  }

  @override
  String get composeFrom => 'Od';

  @override
  String composeReplyFrom(String email) {
    return 'Odpowiedz z $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Wyślij z $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Odpowiedzieć z $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Wysłać z $email?';
  }

  @override
  String get composeDismiss => 'Odrzuć';

  @override
  String composeAliasNotSaved(String account) {
    return 'Nie zapisano jako tożsamość · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Zapisz jako tożsamość';

  @override
  String composeAliasSaved(String email) {
    return 'Zapisano $email jako tożsamość.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Nieprawidłowy adres $address';
  }

  @override
  String get composeOriginalNotFound => 'Nie udało się znaleźć oryginalnej wiadomości.';

  @override
  String get composeDraftNotFound => 'Nie udało się znaleźć wersji roboczej.';

  @override
  String get composeAttachmentsLost => 'Nie udało się odzyskać załączników. Dodaj je ponownie.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Nie udało się dodać niektórych załączników: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Łączny rozmiar załączników to $size; niektóre serwery odrzucają tak duże wiadomości.';
  }

  @override
  String get composeAttachFailed => 'Nie udało się załączyć pliku.';

  @override
  String get composeInvalidAddressTitle => 'Nieprawidłowy adres';

  @override
  String composeInvalidAddress(String address) {
    return '„$address” nie jest prawidłowym adresem e-mail.';
  }

  @override
  String get composeNoSubjectTitle => 'Brak tematu';

  @override
  String get composeNoSubjectText => 'Ta wiadomość nie ma tematu. Wysłać mimo to?';

  @override
  String get composeSentBeforeChanges =>
      'Wiadomość została wysłana przed twoimi zmianami, które zapisano w Wersjach roboczych.';

  @override
  String composeScheduled(String time) {
    return 'Zaplanowano: $time';
  }

  @override
  String get composeSending => 'Wysyłanie…';

  @override
  String get composeSent => 'Wysłano';

  @override
  String get composeSendFailed => 'Nie udało się wysłać. Spróbuj ponownie.';

  @override
  String get composeAlreadySent => 'Już wysłano.';

  @override
  String get composeDiscardChanges => 'Odrzuć zmiany';

  @override
  String get composeSaveChanges => 'Zapisz zmiany';

  @override
  String get composeDeleteDraft => 'Usuń wersję roboczą';

  @override
  String get composeSaveDraft => 'Zapisz wersję roboczą';

  @override
  String get composeDraftSaved => 'Zapisano wersję roboczą';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date o $time $name napisał(a):';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date o $time ktoś napisał:';
  }

  @override
  String get composeForwardHeader => '---------- Przekazana wiadomość ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Od: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date o $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Temat: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Do: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'DW: $addresses';
  }

  @override
  String get composeLaterToday => 'Później dzisiaj';

  @override
  String get composeTomorrowMorning => 'Jutro rano';

  @override
  String get composeMondayMorning => 'W poniedziałek rano';

  @override
  String get composePickDateTime => 'Wybierz datę i godzinę…';

  @override
  String get composeSendWithoutDelay => 'Wyślij bez opóźnienia';

  @override
  String composeSendTimeToday(String time) {
    return 'Dziś o $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Jutro o $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day o $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Dziś $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Jutro $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Kontynuować edycję wersji roboczej?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Wiadomość nie została wysłana przed zamknięciem Loupe.',
      'one': 'Wiadomość do $name nie została wysłana przed zamknięciem Loupe.',
      'other': 'Wiadomość do $name i innych nie została wysłana przed zamknięciem Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Wiadomość „$subject” nie została wysłana przed zamknięciem Loupe.',
      'one': 'Wiadomość „$subject” do $name nie została wysłana przed zamknięciem Loupe.',
      'other': 'Wiadomość „$subject” do $name i innych nie została wysłana przed zamknięciem Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Kontynuuj edycję';

  @override
  String get composeRecoverySave => 'Zapisz w wersjach roboczych';

  @override
  String get composeRecoveryDiscard => 'Odrzuć';

  @override
  String get composeRecoverySaved => 'Zapisano w wersjach roboczych';

  @override
  String get outboxSectionFailed => 'Nie wysłano';

  @override
  String get outboxSectionSending => 'Wysyłanie';

  @override
  String get outboxSectionScheduled => 'Zaplanowane';

  @override
  String get outboxStatusQueued => 'Wkrótce zostanie wysłana';

  @override
  String get outboxStatusSending => 'Wysyłanie…';

  @override
  String get outboxStatusFailed => 'Nie wysłano';

  @override
  String get outboxNoRecipients => 'Brak odbiorców';

  @override
  String get outboxNoSubject => '(Bez tematu)';

  @override
  String get outboxSendingFailed => 'Wysyłanie nie powiodło się.';

  @override
  String get outboxEmptyTitle => 'Nic do wysłania';

  @override
  String get outboxEmptyText => 'Wiadomości wysyłane później czekają tu na swoją porę.';

  @override
  String get outboxSendNow => 'Wyślij teraz';

  @override
  String get outboxReschedule => 'Przełóż';

  @override
  String get outboxRescheduleMenu => 'Przełóż…';

  @override
  String get outboxRescheduleTitle => 'Przełóż';

  @override
  String outboxRescheduled(String time) {
    return 'Przełożono na: $time';
  }

  @override
  String get outboxCancel => 'Anuluj';

  @override
  String get outboxCancelSending => 'Anuluj wysyłanie…';

  @override
  String get outboxCancelTitle => 'Anulować wysyłanie?';

  @override
  String get outboxMoveToDrafts => 'Przenieś do wersji roboczych';

  @override
  String get outboxDiscard => 'Odrzuć wiadomość';

  @override
  String get outboxMovedToDrafts => 'Przeniesiono do wersji roboczych';

  @override
  String get outboxDiscarded => 'Wiadomość odrzucona';

  @override
  String get outboxAlreadySent => 'Już wysłano.';

  @override
  String get outboxBeingSent => 'Ta wiadomość jest właśnie wysyłana.';

  @override
  String get outboxActionFailed => 'Nie udało się. Wiadomość nadal jest w skrzynce nadawczej.';

  @override
  String get notificationsBadgeInboxes => 'Nieprzeczytane w Odebranych';

  @override
  String get notificationsBadgeVip => 'Nieprzeczytane od VIP-ów';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Nowa poczta od twoich VIP-ów na dowolnym koncie';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Nowa poczta na $email';
  }

  @override
  String get notificationsUnknownSender => 'Nieznany nadawca';

  @override
  String get notificationsNoSubject => '(Bez tematu)';

  @override
  String get notificationsEncryptedMessage => 'Zaszyfrowana wiadomość';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Nowa wiadomość od $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nowych wiadomości',
      few: '$count nowe wiadomości',
      one: '$count nowa wiadomość',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Nowe wiadomości na koncie $account';
  }

  @override
  String get platformInstantChannel => 'Natychmiastowe dostarczanie';

  @override
  String get platformInstantChannelDescription =>
      'Widoczne, gdy Loupe obserwuje twoje skrzynki odbiorcze w oczekiwaniu na nową pocztę';

  @override
  String get platformInstantTitle => 'Oczekiwanie na nową pocztę';

  @override
  String get platformInstantText => 'Natychmiastowe dostarczanie jest włączone';

  @override
  String get platformErrorBox => 'Coś poszło nie tak podczas wyświetlania. Wróć i spróbuj ponownie.';

  @override
  String get welcomeTagline => 'Poczta prosta na wierzchu,\na potężna pod spodem.';

  @override
  String get welcomeAccountsTitle => 'Wszystkie konta, jedna spokojna skrzynka';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail i dowolny serwer IMAP lub JMAP.';

  @override
  String get welcomeSearchTitle => 'Wyszukiwanie, które znajduje';

  @override
  String get welcomeSearchText => 'Natychmiastowe wyniki z telefonu, a potem z serwera.';

  @override
  String get welcomePrivacyTitle => 'Prywatność w standardzie';

  @override
  String get welcomePrivacyText => 'Bez śledzenia. Zdalne obrazy pozostają zablokowane, dopóki na nie nie pozwolisz.';

  @override
  String get welcomeAddAccount => 'Dodaj konto';

  @override
  String get welcomeImport => 'Importuj z Thunderbirda';

  @override
  String get welcomeTryDemo => 'Wypróbuj z pocztą demonstracyjną';
}
