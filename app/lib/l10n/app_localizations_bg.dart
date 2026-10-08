// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get commonAdd => 'Добавяне';

  @override
  String get commonCancel => 'Отказ';

  @override
  String get commonClose => 'Затваряне';

  @override
  String get commonDelete => 'Изтриване';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonEdit => 'Редактиране';

  @override
  String get commonMore => 'Още';

  @override
  String get commonMove => 'Преместване';

  @override
  String get commonName => 'Име';

  @override
  String get commonNone => 'Няма';

  @override
  String get commonOff => 'Изкл.';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Вкл.';

  @override
  String get commonOptional => 'По избор';

  @override
  String get commonPassword => 'Парола';

  @override
  String get commonRemove => 'Премахване';

  @override
  String get commonRetry => 'Нов опит';

  @override
  String get commonSave => 'Запазване';

  @override
  String get commonSearch => 'Търсене';

  @override
  String get commonServer => 'Сървър';

  @override
  String get commonSettings => 'Настройки';

  @override
  String get commonShare => 'Споделяне';

  @override
  String get commonTryAgain => 'Опитайте отново';

  @override
  String get commonUndo => 'Отмяна';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count писма', one: '1 писмо');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Архивиране';

  @override
  String get mailDelete => 'Изтриване';

  @override
  String get mailFlag => 'Маркиране с флаг';

  @override
  String get mailForward => 'Препращане';

  @override
  String get mailMarkAsRead => 'Маркиране като прочетено';

  @override
  String get mailMarkAsUnread => 'Маркиране като непрочетено';

  @override
  String get mailMoveToJunk => 'Преместване в спам';

  @override
  String get mailNewMessage => 'Ново писмо';

  @override
  String get mailNoSubject => 'Без тема';

  @override
  String get mailReply => 'Отговор';

  @override
  String get mailReplyAll => 'Отговор до всички';

  @override
  String get mailSend => 'Изпращане';

  @override
  String get mailUnflag => 'Премахване на флага';

  @override
  String get mailboxArchive => 'Архив';

  @override
  String get mailboxDrafts => 'Чернови';

  @override
  String get mailboxInbox => 'Входящи';

  @override
  String get mailboxJunk => 'Спам';

  @override
  String get mailboxOutbox => 'Изходящи';

  @override
  String get mailboxSent => 'Изпратени';

  @override
  String get mailboxTrash => 'Кошче';

  @override
  String get conversationSomethingWentWrong => 'Нещо се обърка. Опитайте отново.';

  @override
  String get conversationReplyToList => 'Отговор до списъка';

  @override
  String get conversationReplyList => 'До списъка';

  @override
  String get conversationThreadMuted => 'Нишката е заглушена. Новите писма в нея пристигат като прочетени.';

  @override
  String get conversationThreadUnmuted => 'Нишката вече не е заглушена.';

  @override
  String get conversationLinkFailed => 'Връзката не можа да се отвори.';

  @override
  String get conversationGoneTitle => 'Няма писмо';

  @override
  String get conversationGoneText => 'Това писмо е преместено или изтрито.';

  @override
  String get conversationMuted => 'Заглушена';

  @override
  String get conversationReaderOptions => 'Опции за четене';

  @override
  String get conversationReaderOptionsHint => 'Размер на текста и изглед';

  @override
  String get conversationTrash => 'В кошчето';

  @override
  String get conversationReplyHint => 'Задръжте за „Отговор до всички“ и „Препращане“';

  @override
  String get conversationOfflineTitle => 'Няма връзка';

  @override
  String get conversationOfflineText => 'Този разговор още не е изтеглен. Ще се зареди, когато връзката се възстанови.';

  @override
  String get conversationErrorTitle => 'Писмото не може да се покаже';

  @override
  String get conversationErrorText => 'Нещо се обърка.';

  @override
  String get conversationOfflineBanner => 'Няма връзка';

  @override
  String get conversationNotUpdated => 'Не е обновено';

  @override
  String get conversationMe => 'мен';

  @override
  String get conversationNoSender => '(без подател)';

  @override
  String get conversationNoRecipients => 'без получатели';

  @override
  String conversationRecipients(String names) {
    return 'до $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'до $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'От';

  @override
  String get conversationHeaderTo => 'До';

  @override
  String get conversationHeaderCc => 'Копие';

  @override
  String get conversationHeaderBcc => 'Скрито копие';

  @override
  String get conversationHeaderReplyTo => 'Отговор до';

  @override
  String get conversationHeaderDate => 'Дата';

  @override
  String get conversationHeaderSecurity => 'Сигурност';

  @override
  String get conversationVerifiedSender => 'Потвърден подател';

  @override
  String get conversationUnverifiedSender => 'Непотвърден подател';

  @override
  String get conversationLoadingMessage => 'Писмото се зарежда';

  @override
  String get conversationBodyError => 'Писмото не можа да се зареди.';

  @override
  String get conversationBodyOffline => 'Няма връзка. Писмото ще се зареди, когато връзката се възстанови.';

  @override
  String get conversationOriginalHint => 'Изглежда по-добре в изгледа „Оригинален“';

  @override
  String get conversationShowOriginal => 'Показване на оригинала';

  @override
  String get conversationScrollToTop => 'Превъртане до началото';

  @override
  String get conversationTagsMenu => 'Етикети…';

  @override
  String get conversationMuteThread => 'Заглушаване на нишката';

  @override
  String get conversationUnmuteThread => 'Отмяна на заглушаването';

  @override
  String get conversationMoveMenu => 'Преместване…';

  @override
  String get conversationDeletePermanently => 'Окончателно изтриване';

  @override
  String get conversationMoveToTrash => 'Преместване в кошчето';

  @override
  String get conversationNotJunk => 'Не е спам';

  @override
  String get conversationShowAllHeaders => 'Показване на всички заглавки';

  @override
  String get conversationViewSource => 'Преглед на изходния код';

  @override
  String get conversationSaveAsFile => 'Запазване като файл…';

  @override
  String get conversationShareAsFile => 'Споделяне като файл…';

  @override
  String get conversationSearchFromMessageMenu => 'Търсене по това писмо…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Копиране на адреса';

  @override
  String get conversationAddressCopied => 'Адресът е копиран';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Търсене на писма от $name';
  }

  @override
  String get conversationTags => 'Етикети';

  @override
  String get conversationAllHeaders => 'Всички заглавки';

  @override
  String get conversationCopyAll => 'Копиране на всичко';

  @override
  String get conversationHeadersCopied => 'Заглавките са копирани';

  @override
  String get conversationNoHeaders => 'Няма заглавки';

  @override
  String get conversationSearchFromMessageTitle => 'Търсене по това писмо';

  @override
  String conversationSearchFrom(String name) {
    return 'От $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'До $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Тема „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Изходен код';

  @override
  String get conversationSourceCopied => 'Изходният код е копиран';

  @override
  String get conversationShareFailed => 'Писмото не можа да се сподели.';

  @override
  String get conversationWrapLines => 'Пренасяне на редовете';

  @override
  String get conversationDontWrapLines => 'Без пренасяне на редовете';

  @override
  String get conversationSourceError => 'Изходният код не можа да се зареди.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Показани са първите $shown от $total. Копирайте или споделете, за да получите всичко.';
  }

  @override
  String get conversationAttachmentUntitled => 'Без име';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Още действия за $name';
  }

  @override
  String get conversationMoveTo => 'Преместване в…';

  @override
  String get conversationMailboxesError => 'Папките не можаха да се заредят.';

  @override
  String get conversationReaderReadable => 'Четлив';

  @override
  String get conversationReaderOriginal => 'Оригинален';

  @override
  String get conversationReaderPlain => 'Текст';

  @override
  String get conversationReaderSans => 'Безсерифен';

  @override
  String get conversationReaderMono => 'Моноширинен';

  @override
  String get conversationReaderKeepColours => 'Запазване на оригиналните цветове';

  @override
  String get conversationReaderRemember => 'Запомняне за този подател';

  @override
  String get conversationSecurityPossiblePhishing => 'Възможен фишинг';

  @override
  String get conversationSecurityBeCareful => 'Внимавайте';

  @override
  String get conversationSecurityVerified => 'Потвърден';

  @override
  String get conversationSecurityNoIssues => 'Не са открити проблеми';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count проследяващи елемента',
      one: '1 проследяващ елемент',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Показва защо';

  @override
  String get conversationPhishingBannerTitle => 'Това писмо прилича на фишинг';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Връзките и изображенията са изключени.';
  }

  @override
  String get conversationPhishingBannerText => 'Връзките и изображенията са изключени.';

  @override
  String get conversationPhishingWhy => 'Защо?';

  @override
  String get conversationPhishingShowAnyway => 'Показване въпреки това';

  @override
  String get conversationSecurityPhishingTitle => 'Това прилича на фишинг';

  @override
  String get conversationSecurityPhishingText =>
      'Няколко признака показват, че това писмо не е това, за което се представя.';

  @override
  String get conversationSecurityCarefulTitle => 'Внимавайте с това писмо';

  @override
  String get conversationSecurityCarefulText => 'Нещо в него заслужава втори поглед.';

  @override
  String get conversationSecurityVerifiedText => 'Подателят е потвърден и нищо не изглежда подозрително.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Нищо не изглежда подозрително. Пощенският ви сървър не съобщи дали подателят е потвърден.';

  @override
  String get conversationSecurityNothingSuspicious => 'Нищо не изглежда подозрително.';

  @override
  String get conversationSecurityWhy => 'Защо';

  @override
  String get conversationSecurityPrivacy => 'Поверителност';

  @override
  String get conversationSecurityNoTrackingPixels => 'Няма проследяващи пиксели';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премахнати са $count проследяващи пиксела',
      one: 'Премахнат е 1 проследяващ пиксел',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Те щяха да съобщят на подателя кога сте отворили това писмо.';

  @override
  String get conversationSecurityNoRemoteImages => 'Няма отдалечени изображения';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count отдалечени изображения',
      one: '1 отдалечено изображение',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Зареждането им съобщава на подателя кога четете това писмо, както и IP адреса ви.';

  @override
  String get conversationSecurityNoClickTracking => 'Няма проследяване на кликванията';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count връзки минават през проследяване на кликванията',
      one: '1 връзка минава през проследяване на кликванията',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services биха записали кликването ви. Задръжте върху връзка, за да отворите направо адреса, към който води.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Технически подробности';

  @override
  String get conversationSecurityCheckedLocally => 'Проверено на това устройство. Нищо не е изпратено никъде.';

  @override
  String get conversationSecurityTrackersLabel => 'Проследяващи елементи';

  @override
  String get conversationSecurityImagesFrom => 'Изображения от';

  @override
  String get conversationSecuritySenderHistory => 'История с подателя';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'получени: $received, изпратени: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Връзките водят към';

  @override
  String get conversationSecurityHidden => 'Скрито';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements елемента', one: '1 елемент');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters знака', one: '1 знак');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Подателят не е потвърден';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Пощенският ви сървър не можа да потвърди, че това писмо наистина идва от $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Пощенският ви сървър не можа да потвърди, че това писмо наистина идва от подателя си.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Пощенският ви сървър не можа да потвърди, че това писмо идва от $domain. Често срещано при пощенските списъци.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Пощенският ви сървър не можа да потвърди, че това писмо идва от подателя си. Често срещано при пощенските списъци.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Не предприемайте нищо по него, освен ако не сте го очаквали. Ако се съмнявате, свържете се с подателя по друг начин.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Подписано от друг домейн';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Писмото е подписано от $signer, а не от $domain. Услугите за масово разпращане правят така, но това не доказва кой го е написал.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Писмото е подписано от друг домейн, а не от $domain. Услугите за масово разпращане правят така, но това не доказва кой го е написал.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Името показва друг адрес';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Името на подателя гласи „$shown“, но писмото идва от $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Вярвайте на адреса, а не на името.';

  @override
  String get conversationSecurityReplyToTitle => 'Отговорите отиват другаде';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Ако отговорите, отговорът ви ще отиде до $address, а не до $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Проверете адреса, преди да изпратите в отговор нещо лично.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Използва вашето име';

  @override
  String get conversationSecurityImpersonationTitle => 'Използва името на човек, когото познавате';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Подписано е „$name“ като собственото ви име, но идва от нов адрес: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Подписано е „$name“ като вашия VIP контакт $knownName ($knownEmail), но идва от нов адрес: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Подписано е „$name“ като вашия контакт $knownName ($knownEmail), но идва от нов адрес: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'А отговорите биха отишли на още един, различен адрес.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ако иска пари, кодове или файлове, първо проверете с човека по друг начин.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Познат адрес: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Този адрес: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Първо писмо от този подател';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Досега не сте получавали писма от $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Внимавайте с молби от хора, които още не познавате.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Подобни на вид букви в адреса на подателя';

  @override
  String get conversationSecurityLinkHomographTitle => 'Подобни на вид букви във връзка';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host смесва букви от различни азбуки, за да имитира друг адрес.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host използва подобни на вид букви: това не е $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Изтрийте го или го докладвайте като спам.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Не я отваряйте.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Домейн: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Домейн двойник';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Използва познато име в домейна си';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain прилича на собствения ви домейн $real, но е друг домейн.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain прилича на $brand ($real), но е друг домейн.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain използва името на собствения ви домейн $real, но не е част от него.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain използва името на $brand ($real), но не е техен.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Истинските писма от вашата организация идват от $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Истинските писма от $brand идват от $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Домейн на подателя: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Имитира: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count връзки крият накъде водят',
      one: 'Връзка крие накъде води',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Връзка показва $shown, но отваря $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Не влизайте в профил и не плащайте чрез тези връзки. Вместо това въведете адреса сами.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Накъде води връзката, не може да се провери';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Връзка показва $shown, но минава през $host, който записва кликването, преди да го препрати.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Връзка сочи към гол IP адрес';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts не е уебсайт с име. Истинските компании рядко поставят такива връзки.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Маскирана връзка';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Връзка започва с „$shown@“, за да изглежда като $shown, но отваря $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Скрита страница беше изключена';

  @override
  String get conversationSecurityDataLinkText =>
      'Връзка щеше да отвори страница, вградена в самото писмо — начин да се заобиколят проверките на връзките.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Иска парола';

  @override
  String get conversationSecurityPasswordFieldText => 'Писмото съдържаше поле за парола. Loupe го премахна.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Никога не въвеждайте парола в имейл.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Връзка, която изпълнява код, беше изключена';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe никога не изпълнява код от писма.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Съкратени връзки',
      one: 'Съкратена връзка',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts крие истинския адрес, докато не го отворите.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Международен уеб адрес';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts използва нелатински букви. Това е нормално за много езици; проверете дали това е сайтът, който очаквате.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Много скрит текст';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премахнати са $count знака невидим текст. Такъв скрит текст цели да заблуди филтрите за спам.',
      one: 'Премахнат е 1 знак невидим текст. Такъв скрит текст цели да заблуди филтрите за спам.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Премахнат скрит текст';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премахнати са $count знака невидим текст.',
      one: 'Премахнат е 1 знак невидим текст.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Писмото не можа да се изтегли. Проверете връзката и опитайте отново.';

  @override
  String exportSaved(String name) {
    return 'Запазено: „$name“';
  }

  @override
  String get exportSaveFailed => 'Писмото не можа да се запази.';

  @override
  String exportFailed(String folder) {
    return '„$folder“ не можа да се експортира.';
  }

  @override
  String exportEmpty(String folder) {
    return 'В „$folder“ няма писма за експортиране.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '„$folder“ не можа да се експортира: нито едно писмо не можа да се изтегли. Проверете връзката и опитайте отново.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '„$name“ е запазен без $formattedCount писма, които не можаха да се изтеглят.',
      one: '„$name“ е запазен без 1 писмо, което не можа да се изтегли.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '„$name“ не можа да се запази.';
  }

  @override
  String exportTitle(String folder) {
    return 'Експортиране на „$folder“';
  }

  @override
  String get exportListing => 'Търсене на писмата…';

  @override
  String exportProgress(String current, String total) {
    return 'Експортиране на $current от $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount писма не можаха да се изтеглят',
      one: '1 писмо не можа да се изтегли',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Пощенски кутии';

  @override
  String get mailboxesShown => 'Показана';

  @override
  String get mailboxesHidden => 'Скрита';

  @override
  String get mailboxesCollapse => 'Свиване';

  @override
  String get mailboxesExpand => 'Разгъване';

  @override
  String get mailboxesManageVips => 'Управление на VIP контактите';

  @override
  String get mailboxesSubscriptions => 'Абонаменти';

  @override
  String mailboxesShowAccount(String account) {
    return 'Показване на $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Скриване на $account';
  }

  @override
  String get mailboxesExportFolder => 'Експортиране на папката…';

  @override
  String get mailboxesUnpin => 'Откачване';

  @override
  String get mailboxesLists => 'Списъци';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Запазете търсене, за да го държите тук.';

  @override
  String get mailboxesTags => 'Етикети';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Можете също да докоснете името на подател в писмо и да включите VIP.';

  @override
  String get mailboxesAddVip => 'Добавяне на VIP…';

  @override
  String get mailboxesAddVipTitle => 'Добавяне на VIP';

  @override
  String get mailboxesAddVipText => 'Писмата от този адрес получават звезда и се показват в пощенската кутия VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Непрочетени';

  @override
  String get messageListFilterFlagged => 'С флаг';

  @override
  String get messageListFilterToMe => 'До: мен';

  @override
  String get messageListFilterCcMe => 'Копие: мен';

  @override
  String get messageListFilterWithAttachments => 'С прикачени файлове';

  @override
  String get messageListFilterUnreplied => 'Без отговор';

  @override
  String get messageListFilterFromVips => 'От VIP контакти';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са маркирани като прочетени',
      one: '1 писмо е маркирано като прочетено',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'По-старата поща не можа да се зареди.';

  @override
  String get messageListSelectMessages => 'Избиране на писма';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Избрани: $count');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Избиране на всички';

  @override
  String get messageListDeselectAll => 'Премахване на избора';

  @override
  String get messageListLoadFailed => 'Пощата не можа да се зареди';

  @override
  String get messageListNoUnread => 'Няма непрочетени писма';

  @override
  String get messageListNoMatches => 'Няма съвпадащи писма';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Филтрирано по: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Изключване на филтъра';

  @override
  String get messageListEmpty => 'Няма писма';

  @override
  String get messageListFilter => 'Филтър';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Критерии на филтъра: $filters';
  }

  @override
  String get messageListFilteredBy => 'Филтрирано по:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Непрочетени: $formattedCount');
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Маркиране';

  @override
  String get messageListTrash => 'В кошчето';

  @override
  String get messageListFilterTitle => 'Филтър';

  @override
  String get messageListFilterInclude => 'ВКЛЮЧВАНЕ';

  @override
  String get panesHideMailboxes => 'Скриване на пощенските кутии';

  @override
  String get panesShowMailboxes => 'Показване на пощенските кутии';

  @override
  String get panesMailboxesWidth => 'Ширина на пощенските кутии';

  @override
  String get panesListWidth => 'Ширина на списъка с писма';

  @override
  String get panesNoMessageSelected => 'Няма избрано писмо';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count писма', one: '1 писмо');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Отложени';

  @override
  String get snoozeSheetTitle => 'Отлагане';

  @override
  String get snoozeLaterToday => 'По-късно днес';

  @override
  String get snoozeThisEvening => 'Тази вечер';

  @override
  String get snoozeTomorrow => 'Утре';

  @override
  String get snoozeThisWeekend => 'Този уикенд';

  @override
  String get snoozeNextWeek => 'Следващата седмица';

  @override
  String get snoozePickDateTime => 'Избор на дата и час…';

  @override
  String get snoozeMenu => 'Отлагане…';

  @override
  String get snoozeWakeNow => 'Връщане сега';

  @override
  String get snoozeChangeTimeMenu => 'Промяна на часа на отлагане…';

  @override
  String get snoozeChangeTime => 'Промяна на часа';

  @override
  String get snoozeNoTime => 'Няма зададен час';

  @override
  String get snoozeFooter => 'Отложените писма се връщат във „Входящи“ като непрочетени в зададения час.';

  @override
  String get snoozeEmptyTitle => 'Няма отложени писма';

  @override
  String get snoozeEmptyText => 'Отложете писмо, за да се върне във „Входящи“, когато ви потрябва.';

  @override
  String get appLockUnlock => 'Отключване';

  @override
  String get appLockFailed => 'Loupe не можа да потвърди, че сте вие.';

  @override
  String get appLockLockedOut => 'Твърде много опити. Опитайте отново по-късно.';

  @override
  String get appLockPromptError => 'Проверката не можа да се покаже. Опитайте отново.';

  @override
  String get appLockNoScreenLock => 'Този телефон няма заключване на екрана.';

  @override
  String get appLockUnlockPromptTitle => 'Отключване на Loupe';

  @override
  String get appLockUnlockPromptReason => 'Потвърдете, че сте вие, за да видите пощата си.';

  @override
  String get appLockTurnOnPromptTitle => 'Включване на заключването на приложението';

  @override
  String get appLockTurnOnPromptReason => 'Потвърдете, че сте вие, за да включите заключването на приложението.';

  @override
  String get appLockScreenLockRemoved =>
      'Заключването на приложението е изключено: този телефон вече няма заключване на екрана. Настройте такова, за да го включите отново.';

  @override
  String get appLockAfterImmediately => 'Веднага';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count минути', one: '1 минута');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count часа', one: '1 час');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Шифровано';

  @override
  String get openpgpEncryptedInPart => 'Частично шифровано';

  @override
  String get openpgpEncryptedLocked => 'Шифровано · заключено';

  @override
  String get openpgpEncryptedNoKey => 'Шифровано · няма ключ';

  @override
  String get openpgpEncryptedDamaged => 'Шифровано · повредено';

  @override
  String get openpgpEncryptedUnsupported => 'Шифровано · не се поддържа';

  @override
  String get openpgpUnknownSigner => 'непознат';

  @override
  String get openpgpUnknownKey => 'Непознат ключ';

  @override
  String get openpgpSignatureInvalid => 'Невалиден подпис';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Подписано от $name, а не от подателя';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Частично подписано от $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Подписано от $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Подписано с отхвърлен ключ';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Подписано от $name · ключът не е приет';
  }

  @override
  String get openpgpUnlock => 'Отключване';

  @override
  String get openpgpCantDecrypt => 'Писмото не може да се дешифрира';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Шифровано с OpenPGP';

  @override
  String get openpgpEncryption => 'Шифроване';

  @override
  String get openpgpDecryptedHere => 'Дешифрирано на това устройство';

  @override
  String get openpgpNotDecrypted => 'Не е дешифрирано';

  @override
  String get openpgpKeyLocked => 'Ключът ви е заключен.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'За ключове $keys', one: 'За ключ $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Защитена тема';

  @override
  String get openpgpUnlockKey => 'Отключване на ключа';

  @override
  String get openpgpSignature => 'Подпис';

  @override
  String get openpgpFingerprint => 'Отпечатък';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID на ключа $id';
  }

  @override
  String get openpgpSigned => 'Подписано';

  @override
  String get openpgpProblem => 'Проблем';

  @override
  String get openpgpAcceptance => 'Приемане';

  @override
  String get openpgpChangeAcceptance => 'Промяна на приемането…';

  @override
  String get openpgpCheckedFooter => 'Проверено на това устройство с OpenPGP, съвместимо с Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Ключът ви е заключен. Отключете го с паролната му фраза, за да прочетете това писмо.';

  @override
  String get openpgpSummaryNoSecretKey => 'Шифровано е за ключ, който не е на това устройство.';

  @override
  String get openpgpSummaryDamaged => 'Шифрованите данни са повредени или са променени по пътя.';

  @override
  String get openpgpSummaryUnsupported => 'Използва алгоритъм, който Loupe не поддържа.';

  @override
  String get openpgpSummaryEncrypted => 'Само вие и другите получатели можете да го прочетете.';

  @override
  String get openpgpSummaryNotSigned => 'Не е подписано, така че подателят не е потвърден.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Подписано е, но с ключ, който нямате, така че подписът не може да се провери.';

  @override
  String get openpgpSummaryBadSignature => 'Подписът не съвпада: писмото може да е било променено.';

  @override
  String get openpgpSummaryMismatch =>
      'Подписът е валиден, но ключът принадлежи на адрес, различен от този на подателя.';

  @override
  String get openpgpSummaryPartial =>
      'Само част от писмото е подписана. Текстът извън подписа (например долният текст на пощенски списък) се показва под реда „Unsigned content“, а другите части на писмото, като прикачените файлове, също не са обхванати.';

  @override
  String get openpgpSummaryOwnKey => 'Подписано със собствения ви ключ.';

  @override
  String get openpgpSummaryVerified => 'Подписът е валиден и сте проверили отпечатъка на ключа.';

  @override
  String get openpgpSummaryUnverified => 'Подписът е валиден. Приели сте ключа, без да проверите отпечатъка му.';

  @override
  String get openpgpSummaryRejected => 'Подписът е валиден, но сте отхвърлили този ключ.';

  @override
  String get openpgpSummaryUndecided =>
      'Подписът е валиден, но още не сте приели този ключ. Сравнете отпечатъка му с подателя.';

  @override
  String get openpgpAcceptanceRejected => 'Отхвърлен';

  @override
  String get openpgpAcceptanceUndecided => 'Не е приет';

  @override
  String get openpgpAcceptanceUnverified => 'Приет';

  @override
  String get openpgpAcceptanceVerified => 'Приет и проверен';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Да се приеме ли ключът на $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Отпечатък $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Да, проверих отпечатъка';

  @override
  String get openpgpAcceptUnverified => 'Да, без проверка';

  @override
  String get openpgpAcceptLater => 'Не сега';

  @override
  String get openpgpRejectKey => 'Отхвърляне на ключа';

  @override
  String get openpgpNoSubject => '(без тема)';

  @override
  String get openpgpEncryptionTitle => 'Шифроване от край до край';

  @override
  String get openpgpMyKeys => 'Моите ключове OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'С ключ можете да четете шифровани писма, както и да подписвате и шифровате своите. Използвате Thunderbird? Изнесете ключа си там (Настройки на сметката › Шифроване от край до край › Изнасяне на секретния ключ) и го импортирайте тук.';

  @override
  String get openpgpAddKey => 'Добавяне на ключ…';

  @override
  String get openpgpAddresses => 'Адреси';

  @override
  String get openpgpAddressesFooter => 'Кой ключ използва всеки адрес и кога шифрова и подписва.';

  @override
  String get openpgpCorrespondentsKeys => 'Ключове OpenPGP на кореспондентите';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Приемете ключ, щом сте сигурни, че принадлежи на собственика си; сравнете отпечатъка с него, за да го маркирате като проверен.';

  @override
  String get openpgpImportPublicKey => 'Импортиране на публичен ключ…';

  @override
  String get openpgpCollected => 'Събрани чрез Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Ключове, пристигнали с писма. Loupe може да шифрова за тях, когато и двете страни го искат.';

  @override
  String get openpgpOnThisDevice => 'На това устройство';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Шифрованите писма крият темата си. Loupe пази темата на всяко писмо, което отворите, в шифрованата си база данни на това устройство, за да я показват списъкът, търсенето и известията. На заден план Loupe може също да дешифрира темите на новите писма с ключове без паролна фраза; за целта изтегля всяко писмо (до 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Дешифриране на темите на заден план';

  @override
  String get openpgpIndexFooter =>
      'Търсенето намира шифровани писма по подател, получатели и тема. Когато това е включено, Loupe добавя и текста на всяко шифровано писмо, което дешифрира, към индекса за търсене в шифрованата си база данни на това устройство, така че търсенето да го намира и по текста му. Изключването премахва този текст от индекса.';

  @override
  String get openpgpIndexDecrypted => 'Индексиране на дешифрираните писма за търсене';

  @override
  String get openpgpPassphrases => 'Паролни фрази';

  @override
  String get openpgpPassphrasesFooter =>
      'Ключовете OpenPGP и сертификатите S/MIME, защитени с паролна фраза, се отключват при нужда. Без „Запомняне на паролните фрази“ те се заключват отново две минути след всяко използване.';

  @override
  String get openpgpRememberPassphrases => 'Запомняне на паролните фрази';

  @override
  String get openpgpRememberPassphrasesDetail => 'Докато Loupe не се затвори';

  @override
  String get openpgpLockKeysNow => 'Заключване на ключовете сега';

  @override
  String get openpgpKeysLocked => 'Ключовете са заключени.';

  @override
  String get openpgpKeyStateRevoked => 'отменен';

  @override
  String get openpgpKeyStateExpired => 'изтекъл';

  @override
  String get openpgpKeyStateNeverExpires => 'безсрочен';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'изтича на $date';
  }

  @override
  String get openpgpNoKey => 'Няма ключ';

  @override
  String get openpgpAlwaysEncrypt => 'Винаги шифроване';

  @override
  String get openpgpAddKeyTitle => 'Добавяне на ключ OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Импортирайте ключа, който използвате в Thunderbird, или създайте нов.';

  @override
  String get openpgpImportFromClipboard => 'Импортиране от буфера';

  @override
  String get openpgpImportFromFile => 'Импортиране от файл';

  @override
  String get openpgpGenerateNewKey => 'Създаване на нов ключ';

  @override
  String get openpgpImportPublicKeyTitle => 'Импортиране на публичен ключ';

  @override
  String get openpgpFromClipboard => 'От буфера';

  @override
  String get openpgpFromFile => 'От файл';

  @override
  String get openpgpClipboardEmpty => 'Буферът е празен. Първо копирайте ключа.';

  @override
  String get openpgpKey => 'Ключ';

  @override
  String get openpgpValidityRevoked => 'Отменен';

  @override
  String openpgpValidityExpired(String date) {
    return 'Изтекъл на $date';
  }

  @override
  String get openpgpNeverExpires => 'Безсрочен';

  @override
  String openpgpValidUntil(String date) {
    return 'Валиден до $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Отпечатъкът е копиран.';

  @override
  String get openpgpAlgorithm => 'Алгоритъм';

  @override
  String get openpgpCreated => 'Създаден';

  @override
  String get openpgpValidity => 'Валидност';

  @override
  String get openpgpProtection => 'Защита';

  @override
  String get openpgpProtectionPassphrase => 'Паролна фраза';

  @override
  String get openpgpProtectionKeychain => 'Само хранилището за ключове';

  @override
  String get openpgpKeyDetailsFooter =>
      'Споделете публичния си ключ, за да могат другите да ви пишат шифровано. Резервното копие е секретният ви ключ, защитен с паролната му фраза, ако има такава: пазете го само за себе си.';

  @override
  String get openpgpSharePublicKey => 'Споделяне на публичния ключ';

  @override
  String get openpgpCopyPublicKey => 'Копиране на публичния ключ';

  @override
  String get openpgpPublicKeyCopied => 'Публичният ключ е копиран.';

  @override
  String get openpgpBackUpSecretKey => 'Резервно копие на секретния ключ';

  @override
  String get openpgpDeleteKey => 'Изтриване на ключа';

  @override
  String get openpgpRemoveKey => 'Премахване на ключа';

  @override
  String get openpgpBackUpTitle => 'Резервно копие на секретния ключ?';

  @override
  String get openpgpBackUpProtected =>
      'Резервното копие е защитено с паролната фраза на ключа ви. Всеки, който има и двете, може да чете пощата ви.';

  @override
  String get openpgpBackUpUnprotected =>
      'Този ключ няма паролна фраза: всеки с резервното копие може да чете пощата ви и да подписва от ваше име.';

  @override
  String get openpgpBackUp => 'Създаване на копие';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Да се изтрие ли ключът ви $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Да се премахне ли ключът на $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Писмата, шифровани за този ключ, вече няма да могат да се четат на това устройство, освен ако не го импортирате отново.';

  @override
  String get openpgpRemoveKeyMessage => 'Можете да го импортирате отново по-късно.';

  @override
  String get openpgpKeyHeader => 'Ключ OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Добавете ключ в „Шифроване от край до край“, за да шифровате и подписвате писмата от този адрес.';

  @override
  String get openpgpGenerateAKey => 'Създаване на ключ…';

  @override
  String get openpgpSending => 'Изпращане';

  @override
  String get openpgpSendingFooter =>
      'Автоматичното шифроване се включва, когато всеки получател има приет ключ или доверен сертификат или когато Autocrypt показва, че и двете страни го искат. Шифрованите писма винаги се подписват.';

  @override
  String get openpgpEncryptAutomatically => 'Автоматично шифроване';

  @override
  String get openpgpAlwaysEncryptDetail => 'Не изпраща, ако някой получател няма ключ';

  @override
  String get openpgpSignUnencrypted => 'Подписване на нешифрованите писма';

  @override
  String get openpgpAttachPublicKey => 'Прикачване на публичния ми ключ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt изпраща публичния ви ключ с всяко писмо, така че други приложения да могат да ви пишат шифровано без никаква настройка.';

  @override
  String get openpgpSendMyKey => 'Изпращане на ключа ми с писмата';

  @override
  String get openpgpPreferEncryption => 'Предпочитане на шифроване';

  @override
  String get openpgpPreferEncryptionDetail => 'Другите се молят да шифроват, когато могат';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count години', one: '1 година');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Паролните фрази не съвпадат.';

  @override
  String openpgpKeyReady(String id) {
    return 'Ключът ви $id е готов.';
  }

  @override
  String get openpgpNewKey => 'Нов ключ';

  @override
  String get openpgpNewKeyFor => 'За';

  @override
  String get openpgpYourName => 'Вашето име';

  @override
  String get openpgpAddress => 'Адрес';

  @override
  String get openpgpPassphrase => 'Паролна фраза';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'По избор. Без нея ключът се защитава само от хранилището за ключове на телефона и Loupe никога не пита. С нея Loupe ще я иска, когато ключът е нужен.';

  @override
  String get openpgpRepeatPassphrase => 'Повторете';

  @override
  String get openpgpExpires => 'Изтича';

  @override
  String get openpgpExpiresFooter =>
      'Можете да създадете нов ключ, преди този да изтече. Thunderbird също използва три години.';

  @override
  String get openpgpGenerateKey => 'Създаване на ключ';

  @override
  String get openpgpKeyFor => 'Ключ за';

  @override
  String get openpgpCantEncrypt => 'Не може да се шифрова';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Няма ключ OpenPGP за $names, а този адрес винаги шифрова. Премахнете получателя или импортирайте ключа му в „Настройки › Шифроване от край до край“.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Няма валиден сертификат S/MIME за $names, а този адрес винаги шифрова. Премахнете получателя или импортирайте сертификата му в „Настройки › Шифроване от край до край“.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Няма ключ OpenPGP за $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Няма валиден сертификат S/MIME за $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Изпращане без шифроване';

  @override
  String get openpgpCantSign => 'Не може да се подпише';

  @override
  String get openpgpCantSignMessage =>
      'Частният ключ на сертификата ви S/MIME не е на това устройство. Импортирайте сертификата отново (файл .p12 или .pfx) в „Настройки › Шифроване от край до край“.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Няма ключ за $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Няма сертификат за $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Ключове от Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Всички имат ключ';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Всички имат сертификат';

  @override
  String get openpgpComposeEncrypt => 'Шифроване';

  @override
  String get openpgpComposeSign => 'Подписване';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, превключване';
  }

  @override
  String get openpgpNoKeyFound => 'Не е намерен ключ OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Импортиране на секретен ключ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Този прикачен файл съдържа секретен ключ ($names). Импортирайте го като свой ключ само ако сами сте го изнесли, например от Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Импортиране като мой ключ';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'вашият ключ $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Импортиране на $count ключа ($names)?',
      one: 'Импортиране на ключа на $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Импортиране и приемане';

  @override
  String get openpgpImportDecideLater => 'Импортиране, решение по-късно';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'ключът на $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Импортирано: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикачени са $count ключа OpenPGP.',
      one: 'Прикачен е ключ OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Импортиране';

  @override
  String get openpgpUnlockKeyTitle => 'Отключване на ключ OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Въведете паролната фраза на ключа на $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Паролната фраза е грешна. Опитайте отново.';

  @override
  String get openpgpExplainLocked => 'Това писмо е шифровано. Отключете ключа си OpenPGP, за да го прочетете.';

  @override
  String get openpgpExplainNoKey =>
      'Това писмо е шифровано, но не за ключ OpenPGP на това устройство. Ако го четете в Thunderbird, импортирайте ключа си оттам: „Настройки › Шифроване от край до край“.';

  @override
  String get openpgpExplainDamaged => 'Това шифровано писмо е повредено и не може да се дешифрира безопасно.';

  @override
  String get openpgpExplainUnsupported => 'Това писмо използва шифроване, което Loupe още не може да чете.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Това писмо е шифровано с S/MIME, но не за сертификат на това устройство. Импортирайте сертификата си (файл .p12 или .pfx) в „Настройки › Шифроване от край до край“.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Това писмо е шифровано. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Отключете сертификата си S/MIME, за да го прочетете.';

  @override
  String get openpgpAttachmentGone => 'Този прикачен файл вече не е наличен.';

  @override
  String get smimeEncrypted => 'Шифровано (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Шифровано (S/MIME) · няма сертификат';

  @override
  String get smimeEncryptedDamaged => 'Шифровано (S/MIME) · повредено';

  @override
  String get smimeEncryptedUnsupported => 'Шифровано (S/MIME) · не се поддържа';

  @override
  String get smimeEncryptedLocked => 'Шифровано (S/MIME) · заключено';

  @override
  String get smimeUnknownSigner => 'непознат';

  @override
  String get smimeSignatureModified => 'Невалиден подпис: писмото е променено';

  @override
  String get smimeSignatureWeak => 'Несигурен подпис: остарял алгоритъм';

  @override
  String get smimeSignatureUncheckable => 'Подписът не може да се провери';

  @override
  String get smimeSignedCertificateMissing => 'Подписано · липсва сертификат';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Подписано от $name · сертификатът е отменен';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Подписано от $name · на друга дата';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Подписано от $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Подписано от $name · невалиден сертификат';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Подписано от $name · няма доверие';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Подписано от $name · сертификатът е изтекъл';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Подписано от $name · сертификатът още не е валиден';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Подписано от $name · сертификатът не е за поща';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Подписано от $name, а не от подателя';
  }

  @override
  String get smimeCantDecrypt => 'Писмото не може да се дешифрира';

  @override
  String get smimeEncryptedWithSmime => 'Шифровано с S/MIME';

  @override
  String get smimeEncryption => 'Шифроване';

  @override
  String get smimeDecryptedHere => 'Дешифрирано на това устройство';

  @override
  String get smimeNotDecrypted => 'Не е дешифрирано';

  @override
  String get smimeAuthenticated => 'с удостоверяване';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count сертификата',
      one: 'за 1 сертификат',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Подпис';

  @override
  String get smimeIssuedBy => 'Издаден от';

  @override
  String get smimeValid => 'Валиден';

  @override
  String smimeValidRange(String from, String to) {
    return 'от $from до $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Отпечатък SHA-256';

  @override
  String get smimeSigned => 'Подписано';

  @override
  String get smimeProblem => 'Проблем';

  @override
  String get smimeCheckingRevocation => 'Проверка за отмяна…';

  @override
  String get smimeNotRevoked => 'Не е отменен';

  @override
  String get smimeRevoked => 'Отменен';

  @override
  String get smimeRevocationUnknown => 'Не е известно дали е отменен';

  @override
  String smimeRevokedSince(String date) {
    return 'От $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Проверено при издателя (списък с отменени сертификати), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Проверено при издателя (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Доверие към „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Доверие към този сертификат…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Проверено на това устройство с S/MIME, съвместимо с Outlook и Thunderbird; отмяната е проверена при сертифициращия орган.';

  @override
  String get smimeCheckedFooter =>
      'Проверено на това устройство с S/MIME, съвместимо с Outlook и Thunderbird. Отмяната не се проверява („Настройки › Шифроване от край до край“).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Доверие към $name за поща?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Доверие към сертификата на $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Всеки сертификат, издаден от този орган, ще се смята за доверен, както при сертифициращия орган на фирмата ви. Първо сравнете отпечатъка със собственика му:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Първо сравнете отпечатъка със собственика му:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Доверие';

  @override
  String get smimeSummaryNoKey => 'Шифровано е за сертификат, който не е на това устройство.';

  @override
  String get smimeSummaryDamaged => 'Шифрованите данни са повредени или са променени по пътя.';

  @override
  String get smimeSummaryUnsupported => 'Използва алгоритъм, който Loupe не поддържа.';

  @override
  String get smimeSummaryLocked => 'Сертификатът ви S/MIME е заключен.';

  @override
  String get smimeSummaryEncrypted => 'Само вие и другите получатели можете да го прочетете.';

  @override
  String get smimeSummaryNotSigned => 'Не е подписано, така че подателят не е потвърден.';

  @override
  String get smimeSummaryModified => 'Подписът не съвпада: писмото е променено, след като е подписано.';

  @override
  String get smimeSummaryUncheckable => 'Подписът не може да се провери.';

  @override
  String get smimeSummaryNoCertificate => 'Сертификатът на подписващия не е в писмото, така че не може да се провери.';

  @override
  String get smimeSummaryRevoked =>
      'Сертифициращият орган е отменил сертификата на подписващия: на подписа не може да се вярва.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Сертифициращият орган е отменил сертификата на подписващия ($reason): на подписа не може да се вярва.';
  }

  @override
  String get smimeDateMismatch =>
      'Подписано е с повече от час разлика от датата на писмото: може да е старо писмо, изпратено отново.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Подписът е валиден и $issuer гарантира, че сертификатът принадлежи на подателя.';
  }

  @override
  String get smimeProblemInvalidChain => 'Сертификатът или някой от издателите му е невалиден.';

  @override
  String get smimeProblemUntrusted => 'Сертификатът е от орган, на който Loupe няма доверие.';

  @override
  String get smimeProblemExpired => 'Сертификатът е бил изтекъл.';

  @override
  String get smimeProblemNotYetValid => 'Сертификатът още не е бил валиден.';

  @override
  String get smimeProblemWrongUsage => 'Сертификатът не е предназначен за поща.';

  @override
  String get smimeProblemWrongAddress => 'Сертификатът принадлежи на адрес, различен от този на подателя.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Доверен · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Недоверен · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Изтекъл на $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Валиден от $date';
  }

  @override
  String get smimeTrustInvalid => 'Невалиден';

  @override
  String get smimeTrustNotForMail => 'Не е за поща';

  @override
  String get smimeTrustAnotherAddress => 'Друг адрес';

  @override
  String get smimeMyCertificates => 'Моите сертификати S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'За S/MIME, както го използват Outlook и много фирми. Импортирайте сертификата си с частния му ключ (файл .p12 или .pfx), изнесен от Outlook, Windows, macOS или Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'За S/MIME, както го използват Outlook и много фирми. Импортирайте сертификата си с частния му ключ (файл .p12 или .pfx), изнесен от Outlook, Windows, macOS или Thunderbird, или използвайте сертификат, който вие или фирмата ви сте инсталирали на това устройство.';

  @override
  String get smimeCertificateExpired => 'изтекъл';

  @override
  String smimeCertificateUntil(String date) {
    return 'до $date';
  }

  @override
  String get smimeCertificateOnDevice => 'на това устройство';

  @override
  String get smimeImportCertificateEllipsis => 'Импортиране на сертификат…';

  @override
  String get smimeUseDeviceCertificate => 'Използване на сертификат от това устройство…';

  @override
  String get smimeCorrespondentsCertificates => 'Сертификати на кореспондентите';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Събрани от подписани писма, както правят Outlook и Thunderbird. Писмата се шифроват само за доверени сертификати: Loupe има доверие на органите, на които Mozilla има доверие за имейл, и на тези, които добавите вие.';

  @override
  String get smimeRevocation => 'Отмяна';

  @override
  String get smimeRevocationFooter =>
      'Когато отворите подписано писмо, Loupe пита органа, издал сертификата на подписващия, дали той е отменен (чрез OCSP сървъра му или списъка му с отменени сертификати). Така органът може да види кога някой от вашия интернет адрес чете писма, подписани с този сертификат. Отговорите се пазят на това устройство, докато изтекат. Отмененият сертификат се показва като „сертификатът е отменен“ в заглавката на писмото.';

  @override
  String get smimeCheckRevocation => 'Онлайн проверка за отменени сертификати';

  @override
  String get smimeTrustedAuthorities => 'Доверени органи';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Доверени от вас, освен $count органа, на които Mozilla има доверие за имейл.',
      one: 'Доверени от вас, освен 1 орган, на който Mozilla има доверие за имейл.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Сертифициращ орган';

  @override
  String get smimeImportACertificate => 'Импортиране на сертификат';

  @override
  String get smimeImportContactMessage => 'Сертификат на кореспондент (.cer, .crt, .pem) или на сертифициращ орган.';

  @override
  String get smimeFromClipboard => 'От буфера';

  @override
  String get smimeFromFile => 'От файл';

  @override
  String get smimeClipboardEmpty => 'Буферът е празен. Първо копирайте сертификата.';

  @override
  String get smimeCertificate => 'Сертификат';

  @override
  String get smimeOnDeviceFooter =>
      'Частният му ключ остава в хранилището за идентификационни данни на Android, където вие или фирмата ви сте го инсталирали: Loupe моли Android да подписва и дешифрира с него. Подписаните писма се подписват при изпращането им.';

  @override
  String get smimeAddresses => 'Адреси';

  @override
  String get smimeUsage => 'За';

  @override
  String get smimeUsageNone => 'Нищо, което Loupe използва';

  @override
  String get smimeUsageSigning => 'Подписване';

  @override
  String get smimeUsageEncryption => 'Шифроване';

  @override
  String get smimeUsageCertificates => 'Сертификати';

  @override
  String get smimeAlgorithm => 'Алгоритъм';

  @override
  String get smimeSerialNumber => 'Сериен номер';

  @override
  String get smimeFingerprintCopied => 'Отпечатъкът е копиран.';

  @override
  String get smimeSha1Thumbprint => 'Отпечатък SHA-1';

  @override
  String get smimePrivateKey => 'Частен ключ';

  @override
  String get smimeKeyOnDevice => 'На това устройство';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'В Loupe, с паролна фраза';

  @override
  String get smimeKeyInLoupe => 'В Loupe';

  @override
  String get smimeSource => 'Източник';

  @override
  String get smimeSourceSignedMail => 'Подписано писмо';

  @override
  String get smimeSourceImported => 'Импортиран';

  @override
  String get smimeTrustHeader => 'Доверие';

  @override
  String get smimeTrustedRoot => 'Доверен корен';

  @override
  String get smimeIssuer => 'Издател';

  @override
  String smimeTrustNamed(String name) {
    return 'Доверие към „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Доверие към този орган';

  @override
  String get smimeTrustThisCertificate => 'Доверие към този сертификат';

  @override
  String get smimeStopTrusting => 'Спиране на доверието';

  @override
  String get smimePassphrase => 'Паролна фраза';

  @override
  String get smimePassphraseFooter =>
      'По избор. С паролна фраза частният ключ е шифрован и на това устройство (Argon2id и AES-256) и Loupe я иска, за да подписва и дешифрира; „Запомняне на паролните фрази“ определя за колко време. Писмата, които изпращате, се подписват при изпращане; фоновите задачи не могат да използват ключа.';

  @override
  String get smimeChangePassphrase => 'Промяна на паролната фраза…';

  @override
  String get smimeSetPassphraseEllipsis => 'Задаване на паролна фраза…';

  @override
  String get smimeRemovePassphrase => 'Премахване на паролната фраза';

  @override
  String get smimeShareCertificate => 'Споделяне на сертификата';

  @override
  String get smimeDeleteCertificate => 'Изтриване на сертификата';

  @override
  String get smimeRemoveCertificate => 'Премахване на сертификата';

  @override
  String get smimePassphraseChanged => 'Паролната фраза е променена.';

  @override
  String get smimePassphraseSet => 'Паролната фраза е зададена.';

  @override
  String get smimeRemovePassphraseTitle => 'Премахване на паролната фраза?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Тогава частният ключ се защитава само от хранилището за ключове, както без паролна фраза: Loupe вече не я иска и фоновите задачи могат да го използват.';

  @override
  String get smimePassphraseRemoved => 'Паролната фраза е премахната.';

  @override
  String smimeTrustTitle(String name) {
    return 'Доверие към $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Всеки сертификат, който издава, ще бъде доверен за поща. Първо сравнете отпечатъка със собственика му:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Да се изтрие ли сертификатът ви $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Да се премахне ли сертификатът на $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe спира да го използва: писмата, шифровани за него, вече не могат да се четат в Loupe. Сертификатът остава на това устройство (Настройки › Сигурност › Шифроване и идентификационни данни).';

  @override
  String get smimeDeleteOwnMessage =>
      'Частният му ключ се изтрива от това устройство: писмата, шифровани за него, вече не могат да се четат тук, освен ако не го импортирате отново.';

  @override
  String get smimeRemoveContactMessage => 'Ще се появи отново със следващото подписано писмо от този човек.';

  @override
  String get smimeAddressImportFooter =>
      'Импортирайте сертификат за този адрес, за да подписвате и шифровате с S/MIME, както прави Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Импортиране на сертификат…';

  @override
  String get smimePreferFooter =>
      'Когато и двата стандарта могат да защитят писмото, се използва предпочитаният, освен ако само другият има ключ или сертификат за всеки получател.';

  @override
  String get smimePreferSmime => 'Предпочитане на S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Пред OpenPGP';

  @override
  String get smimeCertificatePassword => 'Парола на сертификата';

  @override
  String get smimeCertificatePasswordPrompt => 'Въведете паролата, с която е изнесен файлът на сертификата.';

  @override
  String get smimeImport => 'Импортиране';

  @override
  String get smimeWrongPassword => 'Паролата е грешна. Опитайте отново.';

  @override
  String get smimeNoCertificateFound => 'Не е намерен сертификат.';

  @override
  String smimeCertificateOf(String name) {
    return 'сертификатът на $name';
  }

  @override
  String get smimeNothingNew => 'Няма нищо ново за импортиране.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Импортирано: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Импортирани са $count доверени органа.',
      one: 'Импортиран е 1 доверен орган.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Импортирано: $certificates и $count доверени органа.',
      one: 'Импортирано: $certificates и 1 доверен орган.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Този файл няма частен ключ. Изнесете сертификата си заедно с частния му ключ.';

  @override
  String get smimeImportAsYoursTitle => 'Импортиране като ваш сертификат?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Този прикачен файл съдържа сертификат с частния му ключ: $names. Импортирайте го само ако сами сте го изнесли, например от Outlook или Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Импортиране като мой сертификат';

  @override
  String smimeImportedOwn(String names) {
    return 'Сертификатът ви $names е импортиран.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Сертификатът ви $name ($addresses) е добавен от това устройство.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Доверие към „$name“ за поща?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe не познава този сертифициращ орган (може би е собствен на някоя фирма). Доверете му се, за да се проверяват сертификатите, които издава. Първо сравнете отпечатъка му с ИТ отдела си:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикачени са $count сертификата.',
      one: 'Прикачен е сертификат.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Импортиране на сертификата';

  @override
  String get smimeUnlockTitle => 'Отключване на сертификат S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Въведете паролната фраза на сертификата на $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Паролната фраза е грешна. Опитайте отново.';

  @override
  String get smimeUnlock => 'Отключване';

  @override
  String get smimeEnterAPassphrase => 'Въведете паролна фраза.';

  @override
  String get smimePassphrasesDiffer => 'Двете паролни фрази се различават.';

  @override
  String get smimeSetPassphraseTitle => 'Задаване на паролна фраза';

  @override
  String get smimeSetPassphraseText =>
      'Loupe ще я иска, за да подписва и дешифрира. Ако я забравите, импортирайте сертификата отново от файла .p12.';

  @override
  String get smimePassphraseAgain => 'Отново';

  @override
  String get smimeSetPassphraseButton => 'Задаване';

  @override
  String get smimeLockedOpenAgain => 'Сертификатът ви S/MIME е заключен. Отворете писмото отново, за да го отключите.';

  @override
  String get smimeDeviceHasNoCertificates => 'Това устройство не предоставя сертификатите си.';

  @override
  String get smimeCantReadCertificate => 'Loupe не може да прочете този сертификат.';

  @override
  String get smimeCertificateNotForMail =>
      'Този сертификат не е за поща: няма имейл адрес или не е предназначен за подписване или шифроване.';

  @override
  String get smimeDeviceCertificateGone =>
      'Сертификатът вече не е на това устройство или Loupe може би вече няма право да го използва. Изберете го отново в „Настройки › Шифроване от край до край“.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Сертификатът на това устройство може да се използва само докато Loupe е отворено.';

  @override
  String get smimeDeviceKeyDamaged => 'Шифрованият ключ е повреден.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Сертификатът на това устройство не може да направи това: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'не се поддържа';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Сертификатът на това устройство даде грешка: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Адресът на органа не е уеб адрес.';

  @override
  String get smimeAuthorityTimeout => 'Сертифициращият орган не отговори навреме.';

  @override
  String get smimeAuthorityUnreachable => 'Няма връзка със сертифициращия орган.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Сертифициращият орган отговори с $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Отговорът на сертифициращия орган е твърде голям.';

  @override
  String get smimeRevocationNotChecked =>
      'Не е проверено: проверяват се само сертификати от органи, на които Loupe има доверие.';

  @override
  String get settingsLanguage => 'Език';

  @override
  String get settingsLanguageSystem => 'Като на телефона';

  @override
  String get settingsLanguageFooter =>
      'Loupe използва езика на телефона ви, когато го поддържа, а иначе – английски. Езикът, който изберете тук, е само за Loupe, включително известията.';

  @override
  String get settingsAccountsHeader => 'Профили';

  @override
  String get settingsAddAccount => 'Добавяне на профил';

  @override
  String get settingsMailHeader => 'Поща';

  @override
  String get settingsSwipeActions => 'Действия при плъзгане';

  @override
  String get settingsSwipeLeft => 'Плъзгане наляво';

  @override
  String get settingsSwipeLeftFooter =>
      'Пълното плъзгане изпълнява това действие. „Маркиране с флаг“ и „Още“ винаги са на едно кратко плъзгане разстояние.';

  @override
  String get settingsSwipeRight => 'Плъзгане надясно';

  @override
  String get settingsSwipeRightFooter => 'Пълното плъзгане изпълнява това действие.';

  @override
  String get settingsSwipeToggleRead => 'Маркиране като прочетено/непрочетено';

  @override
  String get settingsSwipeTrash => 'В кошчето';

  @override
  String get settingsSwipeMove => 'Преместване на писмото';

  @override
  String get settingsSwipeSnooze => 'Отлагане';

  @override
  String get settingsThreaded => 'Групиране по разговори';

  @override
  String get settingsUndoSendDelay => 'Време за отмяна на изпращането';

  @override
  String get settingsUndoSendDelayFooter => 'Изпратените писма изчакват толкова време, за да можете да ги върнете.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds секунди', one: '1 секунда');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Облик';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSystem => 'Автоматична';

  @override
  String get settingsThemeLight => 'Светла';

  @override
  String get settingsThemeDark => 'Тъмна';

  @override
  String get settingsDensity => 'Списък с писма';

  @override
  String get settingsDensityComfortable => 'Просторен';

  @override
  String get settingsDensityCompact => 'Компактен';

  @override
  String get settingsReadingHeader => 'Четене';

  @override
  String get settingsReadingFooter =>
      'Отдалечените изображения могат да съобщят на подателите кога и къде сте отворили писмо.';

  @override
  String get settingsDefaultView => 'Изглед по подразбиране';

  @override
  String get settingsDefaultViewFooter => 'Можете да превключите изгледа на всяко писмо с бутона Aa.';

  @override
  String get settingsViewReadable => 'Четлив';

  @override
  String get settingsViewReadableDetail => 'Изчистен, лесен за четене, следва тъмния режим';

  @override
  String get settingsViewOriginal => 'Оригинален';

  @override
  String get settingsViewOriginalDetail => 'Точно както го е оформил подателят';

  @override
  String get settingsViewPlain => 'Обикновен текст';

  @override
  String get settingsViewPlainDetail => 'Само думите';

  @override
  String get settingsPlainTextFont => 'Шрифт за обикновен текст';

  @override
  String get settingsFontSans => 'Безсерифен';

  @override
  String get settingsFontMono => 'Моноширинен';

  @override
  String get settingsFontMonoDetail => 'Запазва подравняването на ASCII рисунки и таблици';

  @override
  String get settingsTechnicalLists => 'Технически списъци';

  @override
  String get settingsLoadRemoteImages => 'Зареждане на отдалечени изображения';

  @override
  String get settingsOpenLinksDirectly => 'Директно отваряне на връзките';

  @override
  String get settingsOpenLinksDirectlyDetail =>
      'Прескачане на проследяването на кликванията, когато адресът е известен';

  @override
  String get settingsSecurityHeader => 'Сигурност';

  @override
  String get settingsAppLock => 'Заключване на приложението';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe пита при стартиране и когато се върнете след отсъствие, по-дълго от „Заключване след“.';

  @override
  String get settingsAppLockFooterOff =>
      'Заключването на приложението иска пръстов отпечатък, лице или заключването на екрана, преди да се покаже пощата ви.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Заключването на приложението все още е изключено. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Задайте код за достъп';

  @override
  String get settingsScreenLockTextIos =>
      'Заключването на приложението използва Face ID, Touch ID или кода ви за достъп, а този iPhone няма код. Задайте такъв в приложението „Настройки“ и след това включете заключването на приложението.';

  @override
  String get settingsScreenLockTitleAndroid => 'Задайте заключване на екрана';

  @override
  String get settingsScreenLockTextAndroid =>
      'Заключването на приложението използва заключването на екрана на телефона ви или добавен към него пръстов отпечатък или лице, а този телефон няма такова. Задайте ПИН, фигура или парола в настройките на Android и след това включете заключването на приложението.';

  @override
  String get settingsOpenSystemSettings => 'Отваряне на настройките';

  @override
  String get settingsOpenAndroidSettings => 'Отваряне на настройките на Android';

  @override
  String get settingsLockAfter => 'Заключване след';

  @override
  String get settingsLockAfterFooter => 'Колко време Loupe може да е на заден план, преди да попита отново.';

  @override
  String get settingsNotifications => 'Известия';

  @override
  String get settingsEncryption => 'Шифроване от край до край';

  @override
  String get settingsAdvanced => 'Разширени';

  @override
  String get settingsDemoHeader => 'Демо';

  @override
  String get settingsDemoFooter =>
      'Демо пощата е измислена пощенска кутия, която съществува само на този телефон. Нищо не се изпраща никъде.';

  @override
  String get settingsDemoMode => 'Демо режим';

  @override
  String get settingsResetApp => 'Нулиране на приложението';

  @override
  String get settingsResetFooter => 'Забравя всички настройки и се връща към началния екран.';

  @override
  String get settingsResetTitle => 'Нулиране на Loupe?';

  @override
  String get settingsResetMessage =>
      'Това забравя всички настройки, Smart Mailboxes и скорошни търсения и се връща към началния екран.';

  @override
  String get settingsAboutHeader => 'Информация';

  @override
  String get settingsVersion => 'Версия';

  @override
  String get settingsLicences => 'Лицензи';

  @override
  String get settingsPrivacy => 'Поверителност';

  @override
  String get settingsPrivacyDetail =>
      'Loupe няма анализи и проследяване. Пощата ви отива само до вашите пощенски сървъри.';

  @override
  String get settingsNotificationsOffIos => 'Известията за Loupe са изключени в „Настройки“.';

  @override
  String get settingsNotificationsOffAndroid => 'Известията за Loupe са изключени в настройките на Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system не позволява на Loupe да показва известия. Разрешете ги в настройките.';
  }

  @override
  String get settingsNewMailHeader => 'Нова поща';

  @override
  String get settingsNewMailFooterDemo =>
      'Демо пощата не пристига на заден план. Изпратете пробно известие, за да видите как изглежда новата поща.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe проверява за нова поща на заден план, когато iOS позволи, а при приложения, които не отваряте често, това може да е през часове. Получавате известия за нови писма във входящите си пощи и от VIP контакти във всяка папка.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe проверява за нова поща приблизително на всеки 15 минути, когато Android позволи. Получавате известия за нови писма във входящите си пощи и от VIP контакти във всяка папка.';

  @override
  String get settingsNoAccounts => 'Няма профили';

  @override
  String get settingsVipOnly => 'Само VIP';

  @override
  String get settingsVipOnlyDetail => 'Само писма от вашите VIP контакти';

  @override
  String get settingsHideContent => 'Скриване на съдържанието';

  @override
  String get settingsHideContentFooterOn =>
      'Известията казват само „Ново писмо от“ и профила, без кой е писал и за какво.';

  @override
  String get settingsHideContentFooterOff =>
      '„Скриване на съдържанието“ не показва подателя, темата и откъса на заключения екран и в известията.';

  @override
  String get settingsBackgroundAppRefresh => 'Опресняване на приложенията във фонов режим';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Новата поща пристига на заден план само докато „Опресняване на приложенията във фонов режим“ е включено за Loupe в „Настройки“. iOS не може да поддържа отворена връзка с входящите ви пощи, затова няма „Незабавна доставка“.';

  @override
  String get settingsInstantDelivery => 'Незабавна доставка';

  @override
  String get settingsInstantDeliveryFooter =>
      '„Незабавна доставка“ (експериментално) поддържа отворена връзка с входящите ви пощи, така че новата поща пристига до секунди. Показва тихо известие „Следене за нова поща“ и използва повече батерия.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android може да спре „Незабавна доставка“, за да пести батерия. Позволете на Loupe да използва батерията без ограничения, за да продължи да работи.';

  @override
  String get settingsExperimental => 'Експериментално';

  @override
  String get settingsComingSoon => 'Очаквайте скоро';

  @override
  String get settingsAllowUnrestrictedBattery => 'Разрешаване на неограничено използване на батерията';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push позволява на новата поща да събужда Loupe веднага, ако пощенската ви услуга го поддържа. Push съобщенията минават през услугата на Google и не съдържат поща, а само „провери сега“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Този телефон не може да получава push съобщения: те изискват услугите на Google Play и връзка с мрежата. Loupe пак проверява за поща приблизително на всеки 15 минути.';

  @override
  String get settingsCopyPushToken => 'Копиране на push токена';

  @override
  String get settingsPushTokenCopied => 'Push токенът е копиран';

  @override
  String get settingsSendTestNotification => 'Изпращане на пробно известие';

  @override
  String get settingsAppIconBadge => 'Значка на иконата';

  @override
  String get settingsBadgeNote =>
      'Значката се обновява всеки път, когато Loupe проверява за поща, включително на заден план.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Началният екран на този телефон не показва числа върху иконите на приложенията. Значката се обновява всеки път, когато Loupe проверява за поща, включително на заден план.';

  @override
  String get settingsTestNotificationBody => 'Известията за нова поща изглеждат така.';

  @override
  String get settingsAccountRemoved => 'Този профил е премахнат.';

  @override
  String get settingsAccountHeader => 'Профил';

  @override
  String get settingsAccountDescription => 'Описание';

  @override
  String get settingsAccountDescriptionHint => 'Работа, Лични…';

  @override
  String get settingsEmail => 'Имейл';

  @override
  String get settingsColour => 'Цвят';

  @override
  String get settingsColourFooter => 'Отбелязва писмата от този профил във „Всички входящи“.';

  @override
  String settingsColourNumber(int number) {
    return 'Цвят $number';
  }

  @override
  String get settingsSendingHeader => 'Изпращане';

  @override
  String get settingsSendingFooter =>
      'Всяка самоличност има собствен подпис. Отговорите се изпращат от адреса, до който е изпратено писмото.';

  @override
  String get settingsFoldersHeader => 'Папки';

  @override
  String get settingsFoldersFooter =>
      'Loupe показва и синхронизира папките, за които сте абонирани, както прави Thunderbird. „Входящи“, „Чернови“, „Изпратени“, „Спам“, „Кошче“ и „Архив“ се показват винаги.';

  @override
  String get settingsShowAllFolders => 'Показване на всички папки';

  @override
  String get settingsIncoming => 'Входящ сървър';

  @override
  String get settingsOutgoing => 'Изходящ сървър';

  @override
  String get settingsConnectionNotEncrypted => 'Без шифроване';

  @override
  String get settingsSignIn => 'Вход';

  @override
  String get settingsSignInExpired => 'Изтекъл';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider вече не приема входа на Loupe за този профил, така че пощата му не се синхронизира. Влезте отново, за да го оправите.';
  }

  @override
  String get settingsSignInAgain => 'Повторен вход';

  @override
  String get settingsSigningIn => 'Влизане…';

  @override
  String get settingsRemoveAccount => 'Премахване на профила';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Да се премахне ли „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Пощата и настройките му се премахват от този телефон. Нищо не се изтрива на сървъра.';

  @override
  String get settingsManageFolders => 'Управление на папките';

  @override
  String get settingsNoFolders => 'Още няма папки.';

  @override
  String get settingsManageFoldersFooter =>
      'Папките, за които сте абонирани, се показват на екрана „Пощенски кутии“ и се синхронизират на заден план. Другите пощенски приложения за същия профил обикновено също следват тези абонаменти.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Пази вашите Smart Mailboxes за другите ви устройства. Скрита на екрана „Пощенски кутии“.';

  @override
  String get settingsFolderAlwaysShown => 'Винаги се показва';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Абониране за $folder';
  }

  @override
  String get settingsIdentities => 'Самоличности';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Първата самоличност е тази по подразбиране за нови писма. Плъзнете, за да промените реда.';

  @override
  String get settingsIdentitiesFooterSingle => 'Самоличността по подразбиране за нови писма.';

  @override
  String get settingsIdentitiesReplyFooter => 'Отговорът се изпраща от самоличността, до която е изпратено писмото.';

  @override
  String get settingsIdentityDefault => 'По подразбиране';

  @override
  String settingsIdentityReorder(String email) {
    return 'Преместване на $email';
  }

  @override
  String get settingsAddIdentity => 'Добавяне на самоличност';

  @override
  String get settingsNewIdentity => 'Нова самоличност';

  @override
  String get settingsIdentity => 'Самоличност';

  @override
  String get settingsIdentityNameHint => 'Вашето име';

  @override
  String get settingsReplyTo => 'Отговор до';

  @override
  String get settingsSignature => 'Подпис';

  @override
  String get settingsSignatureFooter => 'Добавя се под „-- “ в писмата от тази самоличност.';

  @override
  String get settingsNoSignature => 'Без подпис';

  @override
  String get settingsCopyToMyself => 'Копие до мен';

  @override
  String get settingsCopyToMyselfFooter => 'Добавя се към всяко писмо от тази самоличност.';

  @override
  String get settingsCc => 'Копие';

  @override
  String get settingsBcc => 'Скрито копие';

  @override
  String get settingsReplyPatterns => 'Използване за отговори до';

  @override
  String get settingsReplyPatternsFooter =>
      'Отговорите на писма, изпратени до тези адреси, се изпращат от тази самоличност. * означава каквото и да е: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Адрес или шаблон, в който * означава каквото и да е.';

  @override
  String get settingsAddReplyPattern => 'Добавяне на адрес или шаблон';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Премахване на $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Невалиден шаблон';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ не е адрес или шаблон като *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Няма адрес';

  @override
  String get settingsIdentityNoAddressMessage => 'Въведете имейл адреса, от който да се изпраща.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Невалиден адрес';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '„$address“ в „Отговор до“ не е валиден имейл адрес.',
      'cc': '„$address“ в „Копие“ не е валиден имейл адрес.',
      'bcc': '„$address“ в „Скрито копие“ не е валиден имейл адрес.',
      'other': '„$address“ не е валиден имейл адрес.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Запазване на самоличността';

  @override
  String get settingsDiscardChanges => 'Отхвърляне на промените';

  @override
  String get settingsDeleteIdentity => 'Изтриване на самоличността';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Да се изтрие ли „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Вече изпратените от нея писма остават непроменени.';

  @override
  String get settingsLastIdentityFooter => 'Всеки профил има нужда от поне една самоличност.';

  @override
  String get rulesTitle => 'Правила';

  @override
  String get rulesNewRule => 'Ново правило';

  @override
  String get rulesLoadError => 'Правилата не можаха да се заредят.';

  @override
  String get rulesEmptyTitle => 'Няма правила';

  @override
  String get rulesEmptyText =>
      'Правилата разпределят новата поща по папки, слагат ѝ етикети и флагове вместо вас. Създайте правило с бутона за писане горе или от търсене с „Превръщане в правило“.';

  @override
  String get rulesListFooter =>
      'Правилата се изпълняват отгоре надолу върху новата поща във „Входящи“. Докоснете и задръжте правило, за да го преместите.';

  @override
  String get rulesChangeError => 'Правилото не можа да се промени';

  @override
  String get rulesConditionEveryMessage => 'Всяко писмо';

  @override
  String rulesMoveRule(String rule) {
    return 'Преместване на $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule – вкл.';
  }

  @override
  String get rulesServerRulesHeader => 'Правила на сървъра';

  @override
  String get rulesServerRulesFooter =>
      'Правилата на сървъра се изпълняват на пощенския сървър при пристигане на пощата, дори когато телефонът е изключен. Пазят се в скрипт Sieve с име „loupe“.';

  @override
  String get rulesStatusUnknown => 'Неизвестно';

  @override
  String get rulesStatusError => 'Сървърът не можа да бъде попитан.';

  @override
  String get rulesStatusChecking => 'Проверка…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Изпълняват се от „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Активният скрипт е „$script“. Докоснете, за да изпълнява и правилата на Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'На сървъра няма активен скрипт. Запазването на правило на сървъра ще активира скрипта на Loupe.';

  @override
  String get rulesStatusUnavailable => 'Не е налично';

  @override
  String get rulesStatusNoSieve => 'Сървърът на този профил не предлага Sieve (ManageSieve или JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Преместване в $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Преместване в папка';

  @override
  String rulesActionTag(String tag) {
    return 'Етикет $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Премахване на етикета $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Оставяне във „Входящи“';

  @override
  String rulesActionForward(String address) {
    return 'Препращане до $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Препращане до $address без копие';
  }

  @override
  String get rulesActionStop => 'Стоп';

  @override
  String get rulesNoActions => 'Още не прави нищо';

  @override
  String get rulesLocationDevice => 'Устройство';

  @override
  String get rulesLocationServer => 'Сървър';

  @override
  String get rulesLocationThisDevice => 'Това устройство';

  @override
  String get rulesNewRuleTitle => 'Ново правило';

  @override
  String get rulesEditRuleTitle => 'Редактиране на правило';

  @override
  String get rulesDefaultNameEveryMessage => 'Всяко писмо';

  @override
  String get rulesConditionHeader => 'Когато ново писмо отговаря на';

  @override
  String get rulesConditionFooter =>
      'Пишете го като търсене: from:, to:, s: (тема), b: (текст), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:фактура';

  @override
  String get rulesAccounts => 'Профили';

  @override
  String get rulesAllAccounts => 'Всички профили';

  @override
  String get rulesRemovedAccount => 'Премахнат профил';

  @override
  String get rulesAccountsFooter => 'Правило за всички профили обхваща и профилите, които добавите по-късно.';

  @override
  String get rulesActionsHeader => 'Тогава';

  @override
  String get rulesForwardingFooter =>
      'Препращането изпраща всяко съвпадащо писмо на друг адрес веднага щом пристигне, дори когато телефонът е изключен. Някои доставчици ограничават колко поща може да се препраща.';

  @override
  String get rulesForwardingHiddenFooter => 'Препращането работи само в правилата на сървъра, затова тук е пропуснато.';

  @override
  String rulesRemoveAction(String action) {
    return 'Премахване на „$action“';
  }

  @override
  String get rulesAddAction => 'Добавяне на действие';

  @override
  String get rulesAddMove => 'Преместване в папка…';

  @override
  String get rulesAddTagMenu => 'Добавяне на етикет…';

  @override
  String get rulesRemoveTagMenu => 'Премахване на етикет…';

  @override
  String get rulesAddForward => 'Препращане до…';

  @override
  String get rulesStopProcessing => 'Без обработка с други правила';

  @override
  String get rulesRunOnHeader => 'Изпълнение на';

  @override
  String get rulesRunOnDeviceFooter =>
      'Това устройство изпълнява правилото върху новата поща във „Входящи“ всеки път, когато Loupe проверява за поща.';

  @override
  String get rulesRunOnServerFooter =>
      'Пощенският сървър изпълнява правилото при пристигане на пощата, дори когато телефонът е изключен. Изисква Sieve чрез ManageSieve (Dovecot, mailcow) или JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Прилагане към съществуващите писма…';

  @override
  String get rulesDeleteRule => 'Изтриване на правилото';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Да се изтрие ли „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Папка в кой профил?';

  @override
  String get rulesMoveAccountMessage => 'Пощата на другите профили отива в папката със същото име там.';

  @override
  String get rulesAddTag => 'Добавяне на етикет';

  @override
  String get rulesRemoveTag => 'Премахване на етикет';

  @override
  String get rulesForwardTo => 'Препращане до';

  @override
  String get rulesForwardToMessage =>
      'Сървърът препраща всяко съвпадащо писмо на този адрес, дори когато телефонът е изключен. Използвайте адрес, който е ваш или на който имате доверие.';

  @override
  String get rulesNotAnAddressTitle => 'Това не е имейл адрес';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ не е адрес, до който може да се препраща.';
  }

  @override
  String get rulesKeepCopyTitle => 'Да се пази ли копие тук?';

  @override
  String get rulesKeepCopy => 'Запазване на копие';

  @override
  String get rulesDontKeepCopy => 'Без копие';

  @override
  String get rulesCheckCondition => 'Проверете условието';

  @override
  String get rulesChooseActionTitle => 'Изберете действие';

  @override
  String get rulesChooseActionMessage => 'Добавете какво да прави правилото със съвпадащите писма.';

  @override
  String get rulesSaveError => 'Правилото не можа да се запази';

  @override
  String get rulesSaveServerError => 'Правилото на сървъра не можа да се запази';

  @override
  String get rulesRunOnDeviceInstead => 'Изпълнение на това устройство';

  @override
  String get rulesNothingToApplyTitle => 'Няма какво да се приложи';

  @override
  String get rulesNothingToApplyMessage => 'Първо задайте на правилото работещо условие и действие.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Прилагане на „$rule“ към писмата в…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Входящите пощи';

  @override
  String get rulesApplyScopeAll => 'Всички пощенски кутии';

  @override
  String get rulesFindingMessages => 'Търсене на писмата…';

  @override
  String get rulesSearchError => 'Търсенето е неуспешно';

  @override
  String get rulesSearchErrorUnknown => 'Нещо се обърка.';

  @override
  String get rulesNoMatchesTitle => 'Няма съвпадащи писма';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Нищо там не отговаря на „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прилагане на „$rule“ към $countString писма?',
      one: 'Прилагане на „$rule“ към $countString писмо?',
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
      other: 'Прилагане към $countString писма',
      one: 'Прилагане към $countString писмо',
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
      other: '„$rule“ е приложено към $countString писма',
      one: '„$rule“ е приложено към $countString писмо',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Сървърът се пита какво поддържа…';

  @override
  String get rulesServerUnreachable => 'Няма връзка със сървъра.';

  @override
  String rulesServerProblem(String problem) {
    return 'Не може да се изпълнява на сървъра: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Не може да се изпълнява на сървъра на $account: $problem';
  }

  @override
  String get rulesShowScript => 'Показване на скрипта';

  @override
  String get rulesHideScript => 'Скриване на скрипта';

  @override
  String get rulesMatchingHeader => 'Съвпадащи писма';

  @override
  String get rulesMatchingHeaderLoading => 'Съвпадащи писма…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString съвпадащи писма',
      one: '$countString съвпадащо писмо',
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
      other: '$countString+ съвпадащи писма',
      one: '$countString+ съвпадащо писмо',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'От последните 30 дни. Самото правило действа само върху новата поща, освен ако не го приложите към съществуващите писма.';

  @override
  String rulesConditionError(String error) {
    return 'Условието съдържа грешка: $error';
  }

  @override
  String get rulesPreviewNoSender => '(без подател)';

  @override
  String get rulesPreviewNoSubject => '(без тема)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'и още $countString');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Нищо от последните 30 дни.';

  @override
  String get rulesIncludeTitle => 'Включване на правилата на сървъра';

  @override
  String get rulesIncludeLeaveOff => 'Без включване';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Сървърът вече изпълнява правилата на Loupe за $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '„$script“ е активният скрипт на сървъра на $account, така че сървърът изпълнява него, а не правилата на Loupe. Loupe няма да го замени. Може да добави към него тези редове и тогава сървърът ще изпълнява правилата на Loupe след собствените правила на скрипта:';
  }

  @override
  String get rulesShowWholeScript => 'Показване на целия скрипт';

  @override
  String get rulesHideWholeScript => 'Скриване на целия скрипт';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Нищо друго в „$script“ не се променя. Ако филтрите му бъдат редактирани по-късно в уеб пощата, тя може да го презапише без тези редове; тогава Loupe отново ще показва правилата на сървъра като изключени.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Добавяне към „$script“';
  }

  @override
  String get subscriptionsTitle => 'Абонаменти';

  @override
  String get subscriptionsNewsletters => 'Бюлетини';

  @override
  String get subscriptionsDiscussions => 'Дискусии';

  @override
  String get subscriptionsFilter => 'Филтър';

  @override
  String get subscriptionsFilterNeverRead => 'Нечетени';

  @override
  String get subscriptionsFilterRarelyRead => 'Рядко четени';

  @override
  String get subscriptionsFilterAll => 'Всички';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Абонаментите не можаха да се преброят';

  @override
  String get subscriptionsNoMatches => 'Няма съвпадения';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Няма бюлетин с име „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Няма списък с име „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Няма бюлетини';

  @override
  String get subscriptionsNoNewslettersDetail => 'Бюлетините и другата масова поща ще се появят тук, щом пристигнат.';

  @override
  String get subscriptionsNothingNeverRead => 'Няма нечетени';

  @override
  String get subscriptionsNothingRarelyRead => 'Няма рядко четени';

  @override
  String get subscriptionsNothingFilteredDetail => 'Четете по нещо от всичко, което получавате.';

  @override
  String get subscriptionsNoDiscussions => 'Няма дискусии';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Пощенските списъци, в които можете да пишете, ще се появят тук, щом пристигне поща от тях.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Списъци, в които пишат няколко души. Докоснете и задръжте някой, за да го закачите в „Пощенски кутии“, да го четете като обикновен текст или да го преместите в „Бюлетини“.';

  @override
  String get subscriptionsPrivacyNote =>
      'Преброено на този телефон от изтеглената поща; за това нищо не се изпраща никъде. Loupe се свързва с подател само когато докоснете „Отписване“: отписването с едно докосване изпраща само „List-Unsubscribe=One-Click“ до адреса, посочен от подателя, без бисквитки и без нищо друго за вас, и никога не зарежда страниците или изображенията му.';

  @override
  String get subscriptionsVolumeNone => 'Нищо напоследък';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / месец';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / месец';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'прочетени $percent';
  }

  @override
  String get subscriptionsStillSending => 'Продължава да изпраща';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Отписване на $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Страницата за отписване е отворена на $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'С едно докосване · връзка с $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'С имейл до $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'На уебсайта $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Отписване';

  @override
  String get subscriptionsUnsubscribeAgain => 'Повторно отписване';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Архивиране на $countString във „Входящи“');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Създаване на правило…';

  @override
  String get subscriptionsCreateRuleDetail => 'Преместване или архивиране на бъдещата му поща';

  @override
  String get subscriptionsTreatAsDiscussion => 'Третиране като дискусия';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Списък, в който пишат хора: четене като във форум';

  @override
  String get subscriptionsTreatAsNewsletter => 'Третиране като бюлетин';

  @override
  String get subscriptionsBlockSender => 'Блокиране на подателя';

  @override
  String get subscriptionsBlock => 'Блокиране';

  @override
  String get subscriptionsBlocked => 'Блокиран';

  @override
  String get subscriptionsBlockedDetail => 'Новата поща отива в „Спам“';

  @override
  String get subscriptionsPin => 'Закачане в „Пощенски кутии“';

  @override
  String get subscriptionsUnpin => 'Откачване от „Пощенски кутии“';

  @override
  String get subscriptionsOpenDefaultView => 'Отваряне в изгледа по подразбиране';

  @override
  String get subscriptionsOpenPlainText => 'Отваряне като обикновен текст (моноширинен)';

  @override
  String get subscriptionsPinned => 'Закачен';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString непрочетени',
      one: '$countString непрочетено',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'В момента няма поща от този подател.';

  @override
  String get subscriptionsLatestMessages => 'ПОСЛЕДНИ ПИСМА';

  @override
  String get subscriptionsMail => 'Поща';

  @override
  String get subscriptionsNoneIn90Days => 'Нищо за 90 дни';

  @override
  String get subscriptionsRead => 'Прочетени';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString от $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Последно получено';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Папки', one: 'Папка');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Продължава да изпраща';

  @override
  String get subscriptionsUnsubscribedTitle => 'Отписан';

  @override
  String subscriptionsSince(String date) {
    return 'от $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'страницата е отворена на $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender не посочва как да се отпишете.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender не посочва как да се отпишете. Вместо това можете да го блокирате.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Отписване от $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Отписахте се от $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Отписването е неуспешно: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Автоматичното отписване е неуспешно';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Изпращане на имейл за отписване';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Отваряне на $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Да се отвори ли $site?';
  }

  @override
  String get subscriptionsOpen => 'Отваряне';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender отписва на уебсайта си. Страницата се отваря в браузъра на Loupe; довършете там.';
  }

  @override
  String get subscriptionsWebInsecure => 'Връзката с този сайт не е шифрована.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Внимание: този адрес имитира $site с подобни на вид букви.';
  }

  @override
  String get subscriptionsHomographWarningUnknown => 'Внимание: този адрес имитира друг сайт с подобни на вид букви.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site не можа да се отвори.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe отбелязва днешната дата и ще ви каже, ако $sender продължи да пише.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Отписване от $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe ще се свърже с $site, за да ви отпише.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Това е единственият случай, в който Loupe се свързва с уебсайта на подател. Изпраща само „List-Unsubscribe=One-Click“ до адреса, посочен от $sender, без бисквитки или нещо друго за вас, и не зарежда страницата.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Връзката за отписване не е защитен интернет адрес.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site не отговори навреме.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Няма връзка с $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site пренасочи заявката към друга страница, а Loupe не следва пренасочвания.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site отказа заявката (грешка $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Няма профил, от който да се изпрати имейлът за отписване.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe ще изпрати имейл до $to от $from с тема „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Имейлът за отписване е изпратен до $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Блокиране на $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Новата поща от този списък ще отива в „Спам“. Можете да промените това в „Настройки › Правила“.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Новата поща от $address ще отива в „Спам“. Можете да промените това в „Настройки › Правила“.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender е блокиран.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Преместване на $count в „Спам“');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Блокиране на $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender вече е в „Бюлетини“.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender вече е в „Дискусии“.';
  }

  @override
  String get appLiveGateTitle => 'Профилите ви не можаха да се отворят';

  @override
  String get appLiveGateUnavailableBuild => 'Истинските профили още не са налични в тази компилация.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe не можа да прочете ключа, който защитава пощата ви на този телефон. Често това е временно: опитайте отново или рестартирайте телефона.';

  @override
  String get appLiveGateKeyMissing =>
      'Ключът, който защитава пощата ви на този телефон, липсва, което може да се случи след възстановяване от резервно копие. Пощата ви все още е на сървъра.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Базата данни с пощата на този телефон не може да се прочете: повредена е или ключът ѝ е променен. Пощата ви все още е на сървъра.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Нещо се обърка при отварянето на профилите ви ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Това изтрива профилите ви и пощата, съхранена на този телефон, включително писмата, чакащи в „Изходящи“. Пощата на сървърите ви не се засяга; след това добавете профилите си отново.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Изтриване и започване отначало';

  @override
  String get appLiveGateUseDemo => 'Използване на демо пощата';

  @override
  String get appLiveGateReset => 'Нулиране на пощата на този телефон…';

  @override
  String get attachmentsUntitled => 'Прикачен файл';

  @override
  String get attachmentsUntitledFile => 'Без име';

  @override
  String get attachmentsOpenIn => 'Отваряне с…';

  @override
  String get attachmentsSaveToFiles => 'Запазване в устройството';

  @override
  String get attachmentsShareMenu => 'Споделяне…';

  @override
  String get attachmentsDownloadError =>
      'Прикаченият файл не можа да се изтегли. Проверете връзката и опитайте отново.';

  @override
  String get attachmentsShareError => 'Прикаченият файл не можа да се сподели.';

  @override
  String attachmentsNoApp(String type) {
    return 'Няма приложение на това устройство, което да отваря този файл ($type). Опитайте със „Споделяне“.';
  }

  @override
  String get attachmentsOpenInError => 'Прикаченият файл не можа да се отвори в друго приложение.';

  @override
  String attachmentsSaved(String name) {
    return 'Запазено: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Прикаченият файл не можа да се запази.';

  @override
  String get attachmentsGone => 'Този прикачен файл вече не е наличен.';

  @override
  String get attachmentsDownloadFailed => 'Прикаченият файл не можа да се изтегли.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count страници', one: '1 страница');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size през мобилни данни';
  }

  @override
  String get attachmentsLargeDownload => 'Този прикачен файл е голям. Изтеглете го сега или по-късно през Wi-Fi.';

  @override
  String get attachmentsDownload => 'Изтегляне';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Изтегляне на $size…';
  }

  @override
  String get attachmentsDownloading => 'Изтегляне…';

  @override
  String get attachmentsTooLarge => 'Твърде голям за преглед тук.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Показани са първите $shown от $total. Копирайте, споделете или запазете, за да получите всичко.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Този PDF не може да се покаже тук (може да е защитен с парола).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page от $count';
  }

  @override
  String get attachmentsModeTable => 'Таблица';

  @override
  String get attachmentsModeText => 'Текст';

  @override
  String get attachmentsModeMessage => 'Писмо';

  @override
  String get attachmentsModeSource => 'Изходен код';

  @override
  String get attachmentsDontWrap => 'Без пренасяне на редовете';

  @override
  String get attachmentsWrap => 'Пренасяне на редовете';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines реда', one: '$lines ред');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Копиране на всичко';

  @override
  String get attachmentsCopied => 'Копирано';

  @override
  String get attachmentsImageUnavailable => 'Това изображение не може да се покаже тук. Опитайте „Отваряне с…“.';

  @override
  String get attachmentsEmlNoSubject => '(Без тема)';

  @override
  String get attachmentsEmlFrom => 'От';

  @override
  String get attachmentsEmlTo => 'До';

  @override
  String get attachmentsEmlCc => 'Копие';

  @override
  String get attachmentsEmlDate => 'Дата';

  @override
  String get attachmentsEmlNoText => 'Това писмо няма текст.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикачени файлове: $names',
      one: 'Прикачен файл: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Организатор: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'И още $count събития',
      one: 'И още 1 събитие',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Изображение';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Изображение $format';
  }

  @override
  String get attachmentsTypePdf => 'Документ PDF';

  @override
  String get attachmentsTypeTsv => 'Стойности, разделени с табулация';

  @override
  String get attachmentsTypeCsv => 'Таблица CSV';

  @override
  String get attachmentsTypeCalendar => 'Събитие в календар';

  @override
  String get attachmentsTypeEmail => 'Имейл';

  @override
  String get attachmentsTypeContact => 'Визитка';

  @override
  String get attachmentsTypeLog => 'Файл с журнал';

  @override
  String get attachmentsTypeText => 'Текст';

  @override
  String get attachmentsTypeZip => 'Архив ZIP';

  @override
  String get attachmentsTypeArchive => 'Архив';

  @override
  String get attachmentsTypeWord => 'Документ на Word';

  @override
  String get attachmentsTypeExcel => 'Таблица на Excel';

  @override
  String get attachmentsTypePowerPoint => 'Презентация на PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Уеб страница';

  @override
  String get attachmentsTypeVideo => 'Видео';

  @override
  String get attachmentsTypeAudio => 'Аудио';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Файл $extension';
  }

  @override
  String get attachmentsTypeFile => 'Файл';

  @override
  String get calendarUntitledEvent => 'Събитие';

  @override
  String get calendarAllDay => 'Цял ден';

  @override
  String calendarYourTime(String time) {
    return '$time ваше време';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Присъединяване: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прие: $details',
      'tentative': '$name прие условно: $details',
      'declined': '$name отказа: $details',
      'delegated': '$name делегира: $details',
      'other': 'Няма отговор от $name на: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прие поканата',
      'tentative': '$name прие поканата условно',
      'declined': '$name отказа поканата',
      'delegated': '$name делегира поканата',
      'other': 'Няма отговор от $name на поканата',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Карта';

  @override
  String get calendarJoin => 'Включване';

  @override
  String get calendarOnlineMeeting => 'Онлайн среща';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Среща в $provider';
  }

  @override
  String get calendarOrganizerYou => 'Вие';

  @override
  String get calendarOrganizerLabel => 'организатор';

  @override
  String get calendarStatusAccepted => 'Прието';

  @override
  String get calendarStatusMaybe => 'Може би';

  @override
  String get calendarStatusDeclined => 'Отказано';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прие',
      'tentative': '$name прие условно',
      'declined': '$name отказа',
      'delegated': '$name делегира',
      'other': 'Няма отговор от $name',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прие:',
      'tentative': '$name прие условно:',
      'declined': '$name отказа:',
      'delegated': '$name делегира:',
      'other': 'Няма отговор от $name:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name предлага нов час';
  }

  @override
  String get calendarCounterUnknown => 'Участник предлага нов час';

  @override
  String get calendarDeclineCounter => 'Организаторът запази часа';

  @override
  String calendarRefresh(String name) {
    return '$name иска най-новата версия';
  }

  @override
  String get calendarRefreshUnknown => 'Участник иска най-новата версия';

  @override
  String get calendarCancelled => 'Отменено';

  @override
  String get calendarCancelledByOrganizer => 'Организаторът отмени това събитие.';

  @override
  String get calendarCancelledLater => 'Това събитие беше отменено по-късно.';

  @override
  String get calendarOutdated => 'Остаряло';

  @override
  String get calendarOutdatedDetail => 'Тази покана беше обновена по-късно; важи по-новата.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Мястото е премахнато (беше $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Мястото е премахнато (нямаше такова)';

  @override
  String calendarLocationChanged(String location) {
    return 'Мястото е променено на $location';
  }

  @override
  String get calendarNewTitle => 'Ново заглавие';

  @override
  String get calendarRepeatChanged => 'Повторението е променено';

  @override
  String get calendarUpdated => 'Обновено';

  @override
  String get calendarUpdatedInvitation => 'Обновена покана';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Часът е променен от $before на $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Неизвестна часова зона „$zone“: часовете са както са написани';
  }

  @override
  String calendarNext(String when) {
    return 'Следващо: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count гости', one: '1 гост');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count приели', one: '1 приел');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count може би');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count отказали', one: '1 отказал');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (вие)';
  }

  @override
  String get calendarAttendeeOptional => 'по избор';

  @override
  String get calendarAttendeeRoom => 'зала';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Приехте по-ранна версия.',
      'tentative': 'Приехте условно по-ранна версия.',
      'declined': 'Отказахте по-ранна версия.',
      'delegated': 'Делегирахте по-ранна версия.',
      'other': 'Не отговорихте на по-ранна версия.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Приемане';

  @override
  String get calendarMaybe => 'Може би';

  @override
  String get calendarDecline => 'Отхвърляне';

  @override
  String get calendarCommentHint => 'Коментар за организатора (по избор)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Отговорът ви отива до $organizer от $address.';
  }

  @override
  String get calendarAddComment => 'Добавяне на коментар';

  @override
  String get calendarAddToCalendar => 'Добавяне в календара';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'И още $count събития във файла',
      one: 'И още 1 събитие във файла',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Няма приложение за календар, в което да се добави събитието.';

  @override
  String get calendarCantOpenCalendar => 'Календарът не можа да се отвори.';

  @override
  String get calendarCantOpenLink => 'Връзката не можа да се отвори.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Включване в среща в $provider?';
  }

  @override
  String get calendarJoinTitle => 'Включване в срещата?';

  @override
  String calendarJoinOpens(String host) {
    return 'Отваря $host в браузъра ви.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Внимание: този адрес имитира $site с подобни на вид букви.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Внимание: този адрес имитира друг сайт с подобни на вид букви.';

  @override
  String calendarJoinOpen(String host) {
    return 'Отваряне на $host';
  }

  @override
  String get calendarNoOrganizer => 'Тази покана няма организатор, на когото да се отговори.';

  @override
  String get calendarNoAccount => 'Няма профил, от който да се отговори.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прието',
      'tentative': 'Може би',
      'other': 'Отхвърлено',
    });
    return '$_temp0 · отговорът до $name се изпраща…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прието',
      'tentative': 'Може би',
      'other': 'Отхвърлено',
    });
    return '$_temp0 · отговорът е изпратен';
  }

  @override
  String get calendarReplyAlreadySent => 'Отговорът вече е изпратен.';

  @override
  String get calendarReplyNotSent => 'Отговорът не е изпратен.';

  @override
  String get dataSmimeNeedsDevice =>
      'Сертификатът ви S/MIME е на това устройство: отворете Loupe, за да подпишете и изпратите това писмо.';

  @override
  String dataSigningFailed(String error) {
    return 'Подписването е неуспешно: $error';
  }

  @override
  String get keyboardShortcuts => 'Клавишни комбинации';

  @override
  String get keyboardGroupGeneral => 'Общи';

  @override
  String get keyboardGroupMessages => 'Писма';

  @override
  String get keyboardGroupCompose => 'Писане';

  @override
  String get keyboardCommandPalette => 'Палитра с команди';

  @override
  String get keyboardBackClose => 'Назад, затваряне';

  @override
  String get keyboardNextMessage => 'Следващо писмо';

  @override
  String get keyboardPreviousMessage => 'Предишно писмо';

  @override
  String get keyboardOpenMessage => 'Отваряне на писмото';

  @override
  String get keyboardMoveToTrash => 'Преместване в кошчето';

  @override
  String get keyboardToggleRead => 'Маркиране като прочетено или непрочетено';

  @override
  String get keyboardToggleFlag => 'Поставяне или премахване на флаг';

  @override
  String get keyboardCloseDraft => 'Затваряне (запазване или изтриване на черновата)';

  @override
  String get keyboardOr => 'или';

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
  String get mailingListsMuted => 'Нишката е заглушена. Новите писма в нея пристигат като прочетени.';

  @override
  String get mailingListsUnmuted => 'Нишката вече не е заглушена.';

  @override
  String get mailingListsMuteThread => 'Заглушаване на нишката';

  @override
  String get mailingListsUnmuteThread => 'Отмяна на заглушаването';

  @override
  String get mailingListsPin => 'Закачане в „Пощенски кутии“';

  @override
  String get mailingListsUnpin => 'Откачване от „Пощенски кутии“';

  @override
  String get mailingListsDefaultView => 'Отваряне в изгледа по подразбиране';

  @override
  String get mailingListsPlainText => 'Отваряне като обикновен текст (моноширинен)';

  @override
  String get mailingListsShowMuted => 'Показване на заглушените нишки';

  @override
  String get mailingListsHideMuted => 'Скриване на заглушените нишки';

  @override
  String get mailingListsTreatAsNewsletter => 'Третиране като бюлетин';

  @override
  String get mailingListsOptions => 'Опции на списъка';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Непрочетени: $formatted');
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Ново писмо до списъка';

  @override
  String get mailingListsRowUnread => 'Непрочетена';

  @override
  String get mailingListsRowMuted => 'Заглушена';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count отговора', one: '1 отговор');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Няма нишки';

  @override
  String get mailingListsMutedHidden => 'Заглушените нишки са скрити.';

  @override
  String get mailingListsTechnicalTitle => 'Технически списъци';

  @override
  String get mailingListsTechnicalEmpty => 'Пощенските списъци се появяват тук, щом пристигне поща от тях.';

  @override
  String get mailingListsTechnicalFooter =>
      'Писмата от тези списъци се отварят като обикновен текст с моноширинен шрифт, а кръпките се показват като diff. Бутонът Aa все така превключва изгледа на всяко писмо.';

  @override
  String get paletteMoveToMailbox => 'Преместване в пощенска кутия…';

  @override
  String get paletteMarkAllRead => 'Маркиране на всички като прочетени';

  @override
  String get paletteExportFolder => 'Експортиране на папката…';

  @override
  String get paletteGetNewMail => 'Получаване на нова поща';

  @override
  String get paletteSnoozed => 'Отложени';

  @override
  String get paletteSubscriptions => 'Абонаменти';

  @override
  String get paletteDiscussions => 'Дискусии';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Пощенски списък';

  @override
  String get paletteTag => 'Етикет';

  @override
  String get paletteSwipeActions => 'Действия при плъзгане';

  @override
  String get paletteNotifications => 'Известия';

  @override
  String get paletteRules => 'Правила';

  @override
  String get paletteEncryption => 'Шифроване от край до край';

  @override
  String get paletteAdvanced => 'Разширени';

  @override
  String get paletteAddAccount => 'Добавяне на профил';

  @override
  String get paletteAccount => 'Профил';

  @override
  String get paletteFolders => 'Папки';

  @override
  String get paletteRecentSearch => 'Скорошно търсене';

  @override
  String paletteSearchMail(String query) {
    return 'Търсене на „$query“ в пощата';
  }

  @override
  String get palettePlaceholder => 'Търсене на действия, пощенски кутии, настройки';

  @override
  String get paletteNothingFound => 'Нищо не е намерено';

  @override
  String get searchNewSmartMailbox => 'Нов Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Показва всичко, което отговаря на „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ е запазено в „Пощенски кутии“';
  }

  @override
  String get searchMakeRule => 'Превръщане в правило';

  @override
  String get searchSaveSmartMailbox => 'Запазване като Smart Mailbox';

  @override
  String get searchNegate => 'Отрицание';

  @override
  String get searchDontNegate => 'Без отрицание';

  @override
  String get searchAllMailboxes => 'Всички пощенски кутии';

  @override
  String get searchRecent => 'Скорошни търсения';

  @override
  String get searchClear => 'Изчистване';

  @override
  String get searchSuggestions => 'Предложения';

  @override
  String get searchUnreadMessages => 'Непрочетени писма';

  @override
  String get searchFlaggedMessages => 'Писма с флаг';

  @override
  String get searchWithAttachments => 'Писма с прикачени файлове';

  @override
  String get searchUnrepliedMessages => 'Писма без отговор';

  @override
  String get searchTags => 'Етикети';

  @override
  String get searchPeople => 'Хора';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'От: $name';
  }

  @override
  String get searchSearching => 'Търсене…';

  @override
  String get searchNoResults => 'Няма резултати';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted резултата',
      one: '$formatted резултат',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Меню за търсене';

  @override
  String searchSearchingAccount(String account) {
    return 'Търсене в $account на сървъра…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Търсене в профила на сървъра…';

  @override
  String searchAccountFailed(String account) {
    return 'Търсенето в $account на сървъра е неуспешно';
  }

  @override
  String get searchUnknownAccountFailed => 'Търсенето в профила на сървъра е неуспешно';

  @override
  String searchChip(String term) {
    return '$term. Докоснете два пъти, за да редактирате.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Не $term. Докоснете два пъти, за да редактирате.';
  }

  @override
  String get searchReadAndUnread =>
      'Входящата поща на Шрьодингер: всяко писмо тук е едновременно прочетено и непрочетено, докато не го отворите.';

  @override
  String searchContradiction(String term) {
    return 'Никое писмо не може да бъде едновременно „$term“ и не.';
  }

  @override
  String get searchSyncDeviceOnly => 'Само на това устройство';

  @override
  String searchSyncUnsupported(String account) {
    return 'Само на това устройство: $account не може да го пази';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Не се синхронизира: $account има по-нов формат';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Чака синхронизиране с $account';
  }

  @override
  String searchSynced(String account) {
    return 'Синхронизирано с $account';
  }

  @override
  String get searchRename => 'Преименуване';

  @override
  String get searchEditSearch => 'Редактиране на търсенето';

  @override
  String get searchDeleteSmartMailbox => 'Изтриване на Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Преименуване на Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Този Smart Mailbox е изтрит.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes остават на това устройство.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes се пазят на пощенския ви сървър, така че ги имат и другите ви устройства, а също и Thunderbird с Expression Search Reloaded. Тези, които търсят във всички профили, се пазят в $account; тези за една папка — в профила на тази папка.';
  }

  @override
  String get searchSyncVia => 'Синхронизиране чрез';

  @override
  String get searchSyncViaFooter => 'Изберете един и същ профил на всяко устройство.';

  @override
  String get searchGmailCantKeep => 'Gmail не може да пази Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Пазене на Smart Mailboxes само на това устройство';

  @override
  String get searchOnTheServer => 'На сървъра';

  @override
  String get searchServerFooter =>
      'Метаданните на сървъра (IMAP METADATA) не се виждат в никое пощенско приложение. Сървърите без тях получават папка „Loupe Settings“ с едно писмо; Loupe я скрива от „Пощенски кутии“.';

  @override
  String get searchSyncNow => 'Синхронизиране сега';

  @override
  String get searchStateUnsupported => 'Не се поддържа';

  @override
  String get searchStateNewerFormat => 'По-нов формат';

  @override
  String get searchStateFailed => 'Неуспешно синхронизиране';

  @override
  String get searchStateSyncing => 'Синхронизиране…';

  @override
  String get searchStateWaiting => 'Изчакване';

  @override
  String get searchStateMetadata => 'Метаданни на сървъра';

  @override
  String get searchStateFolder => 'Папка „Loupe Settings“';

  @override
  String get searchStateNothing => 'Нищо не е запазено';

  @override
  String get sharedBack => 'Назад';

  @override
  String get sharedYesterday => 'Вчера';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date в $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count байта', one: '1 байт');
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
  String get sharedSyncNoAccounts => 'Няма профили';

  @override
  String get sharedSyncChecking => 'Проверка за поща…';

  @override
  String get sharedSyncFailed => 'Проверката за поща е неуспешна';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Няма връзка';

  @override
  String get sharedSyncJustNow => 'Обновено току-що';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Обновено преди $minutes минути',
      one: 'Обновено преди 1 минута',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Обновено в $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Обновено на $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Всички входящи';

  @override
  String get sharedMailboxUnread => 'Непрочетени';

  @override
  String get sharedMailboxFlagged => 'С флаг';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Всички чернови';

  @override
  String get sharedMailboxAllSent => 'Всички изпратени';

  @override
  String get sharedMailboxUntitled => 'Пощенска кутия';

  @override
  String get sharedTagImportant => 'Важно';

  @override
  String get sharedTagWork => 'Работа';

  @override
  String get sharedTagPersonal => 'Лично';

  @override
  String get sharedTagToDo => 'За вършене';

  @override
  String get sharedTagLater => 'По-късно';

  @override
  String get sharedTags => 'Етикети';

  @override
  String get sharedMoveTo => 'Преместване в…';

  @override
  String get sharedNoRecipients => 'Няма получатели';

  @override
  String get sharedUnknownSender => 'Неизвестен подател';

  @override
  String get sharedOnServer => 'На сървъра';

  @override
  String get sharedAttachment => 'Прикачен файл';

  @override
  String get sharedSnoozedBadge => 'Отложено';

  @override
  String get sharedRowUnread => 'Непрочетено';

  @override
  String get sharedRowBackFromSnooze => 'Върнато от отлагане';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'С флаг';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Архивирани са $count писма',
      one: 'Архивирано е 1 писмо',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изтрити са $count писма',
      one: 'Изтрито е 1 писмо',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са преместени във „Входящи“',
      one: '1 писмо е преместено във „Входящи“',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са преместени в кошчето',
      one: '1 писмо е преместено в кошчето',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са преместени в „Спам“',
      one: '1 писмо е преместено в „Спам“',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са преместени в $mailbox',
      one: '1 писмо е преместено в $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са преместени в пощенска кутия',
      one: '1 писмо е преместено в пощенска кутия',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count писма са отложени до $time',
      one: '1 писмо е отложено до $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Отложено до $time само на това устройство: сървърът не може да пази часовете на отлагане.';
  }

  @override
  String get sharedMoveOneAccount => 'Изберете писма от един профил, за да ги преместите.';

  @override
  String get sharedSnoozeTitle => 'Отлагане';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Промяна на часа на отлагане';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Окончателно изтриване на $count писма?',
      one: 'Окончателно изтриване на това писмо?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Това не може да се отмени.';

  @override
  String get sharedDeletePermanently => 'Окончателно изтриване';

  @override
  String get sharedSwipeRead => 'Прочетено';

  @override
  String get sharedSwipeUnread => 'Непрочетено';

  @override
  String get sharedSwipeInbox => 'Входящи';

  @override
  String get sharedSwipeDelete => 'Изтриване';

  @override
  String get sharedTrash => 'В кошчето';

  @override
  String get sharedSwipeSnooze => 'Отлагане';

  @override
  String get sharedWakeNow => 'Връщане сега';

  @override
  String get sharedChangeSnoozeTime => 'Промяна на часа на отлагане…';

  @override
  String get sharedSnooze => 'Отлагане…';

  @override
  String get sharedTag => 'Етикет…';

  @override
  String get sharedMoveMessage => 'Преместване на писмото…';

  @override
  String get sharedNotJunk => 'Не е спам';

  @override
  String get accountSetupTitle => 'Добавяне на профил';

  @override
  String get accountSetupTitleDone => 'Профилът е добавен';

  @override
  String get accountSetupAddressTitle => 'Добавяне на пощенски профил';

  @override
  String get accountSetupAddressText => 'Loupe намира настройките за повечето доставчици.';

  @override
  String get accountSetupNameHint => 'Вашето име';

  @override
  String get accountSetupEmail => 'Имейл';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Напред';

  @override
  String get accountSetupLookingUp => 'Търсене на настройките…';

  @override
  String get accountSetupImport => 'Импортиране от Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Въведете валиден имейл адрес.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Не бяха намерени настройки за $domain. Въведете ги по-долу.';
  }

  @override
  String get accountSetupCheckServers => 'Проверете имената на сървърите и портовете.';

  @override
  String get accountSetupEnterPassword => 'Въведете паролата си.';

  @override
  String get accountSetupConnecting => 'Свързване…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Изчакване на $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Страницата не можа да се отвори.';

  @override
  String get accountSetupCouldNotSaveName => 'Името не можа да се запази.';

  @override
  String get accountSetupTrustCertificate => 'Доверие към този сертификат';

  @override
  String get accountSetupPasswordRequired => 'Задължително';

  @override
  String get accountSetupShowPassword => 'Показване на паролата';

  @override
  String get accountSetupHidePassword => 'Скриване на паролата';

  @override
  String get accountSetupAppPassword => 'Парола за приложение';

  @override
  String get accountSetupApiToken => 'API токен';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Входящ · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Изходящ · SMTP';

  @override
  String get accountSetupSignIn => 'Вход';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Вход с $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Използване на парола за приложение';

  @override
  String get accountSetupUseAppPasswordInstead => 'Използване на парола за приложение вместо това';

  @override
  String get accountSetupUseDifferentAddress => 'Използване на друг адрес';

  @override
  String get accountSetupHowToCreateAppPassword => 'Как да създадете парола за приложение';

  @override
  String get accountSetupHowToCreateOne => 'Как да я създадете';

  @override
  String get accountSetupGoogleNote =>
      'Влизате на страницата на Google и Loupe никога не вижда паролата ви. Разрешете на Loupe да чете, изпраща и подрежда пощата ви.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Вход с Google“ още не е наличен в тази компилация. Вместо това можете да се свържете с парола за приложение (изисква потвърждаване в две стъпки в профила ви в Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Създайте парола за приложение в профила си в Google и я поставете по-долу.';

  @override
  String get accountSetupMicrosoftNote =>
      'Влизате на страницата на Microsoft и Loupe никога не вижда паролата ви. Това работи за Outlook.com и Hotmail, както и за служебни или учебни профили в Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Входът с Microsoft идва в по-късна компилация. Профилите в Outlook, Hotmail и Microsoft 365 се нуждаят от него: те вече не приемат пароли от пощенски приложения.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail изисква парола за конкретно приложение, а не паролата на профила ви в Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail изисква парола за приложение, а не паролата на профила ви.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe се свързва с Fastmail чрез JMAP с API токен: Settings › Privacy & Security › Manage API tokens, за JMAP, с достъп до имейла и изпращането.';

  @override
  String get accountSetupFastmailNote => 'Fastmail изисква парола за приложение за пощенските приложения.';

  @override
  String get accountSetupServerSettings => 'Настройки на сървъра';

  @override
  String get accountSetupSettingsNotFound => 'Не са намерени автоматично';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Намерени чрез $source';
  }

  @override
  String get accountSetupEditSettings => 'Редактиране на настройките';

  @override
  String get accountSetupSyncing => 'Пощата ви се синхронизира.';

  @override
  String get accountSetupDescription => 'Описание';

  @override
  String get accountSetupDescriptionHint => 'Работа, Лични…';

  @override
  String get accountSetupColour => 'Цвят';

  @override
  String accountSetupColourNumber(int number) {
    return 'Цвят $number';
  }

  @override
  String get accountSetupSaving => 'Запазване…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe не можа да отвори базата си данни с пощата на този телефон. Затворете Loupe, отворете го отново и опитайте пак.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Нещо се обърка ($error). Опитайте отново.';
  }

  @override
  String get accountSetupSecurityNone => 'Без';

  @override
  String get accountSetupProtocol => 'Протокол';

  @override
  String get accountSetupPort => 'Порт';

  @override
  String get accountSetupSecurity => 'Сигурност';

  @override
  String get accountSetupUsername => 'Потребителско име';

  @override
  String get accountSetupUsernameHint => 'Вашият имейл адрес';

  @override
  String get accountSetupNoEncryptionTitle => 'Свързване без шифроване?';

  @override
  String get accountSetupNoEncryptionText =>
      'Паролата ви и всяко писмо ще се предават като обикновен текст. Всеки в мрежата, например в обществена Wi-Fi мрежа, може да ги прочете. Използвайте това само за сървър във вашата собствена мрежа.';

  @override
  String get accountSetupUseWithoutEncryption => 'Използване без шифроване';

  @override
  String get accountSetupApiTokenRejected =>
      'API токенът е отхвърлен. Създайте API токен на Fastmail за JMAP с достъп до имейла и го поставете.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Паролата е отхвърлена. Използвайте парола за приложение, а не паролата на профила си.';

  @override
  String get accountSetupPasswordRejected => 'Паролата е отхвърлена. Проверете я и опитайте отново.';

  @override
  String get accountSetupServerUnreachable =>
      'Няма връзка със сървъра. Проверете настройките на сървъра и връзката си.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Сертификатът на сървъра не е доверен. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Входът беше отменен. Докоснете „Вход с $provider“, за да опитате отново.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe се нуждае от разрешение да чете и изпраща пощата ви в Gmail. Влезте отново и разрешете достъпа, като отметнете полето за Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe се нуждае от разрешение да чете и изпраща пощата ви. Влезте отново и приемете разрешенията.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Организацията ви трябва да одобри Loupe, преди да можете да го използвате с този профил. Помолете ИТ администратора си да даде съгласие на администратор за Loupe в Microsoft Entra ID и опитайте отново.';

  @override
  String get accountSetupOAuthBlocked =>
      'Правилата за вход на организацията ви не позволяват Loupe на това устройство. Обърнете се към ИТ администратора си.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Няма връзка с $provider. Проверете интернет връзката си и опитайте отново.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Входът с $provider не е настроен правилно в тази версия на Loupe. Моля, съобщете за това.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Входът с $provider не беше успешен. Опитайте отново.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider ви вписа, но Gmail отказа достъп за този адрес. Изберете същия профил при влизане. При служебни или учебни профили администраторът може да е изключил IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider ви вписа, но пощенският сървър отказа достъп за този адрес. Изберете същия профил при влизане. При служебни или учебни профили администраторът може да е изключил IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Няма връзка с пощенския сървър. Проверете връзката си и опитайте отново.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Входът с $provider не е наличен в тази версия.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Влязохте отново. $account се синхронизира.';
  }

  @override
  String get accountSetupSignInAgain => 'Повторен вход';

  @override
  String get accountSetupSigningIn => 'Влизане…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider вече не приема входа на Loupe за $email, така че $account не се синхронизира. Влезте отново, за да получавате пощата му.';
  }

  @override
  String get accountImportTitle => 'Импортиране от Thunderbird';

  @override
  String get accountImportPointCamera => 'Насочете камерата към QR кода, който Thunderbird показва.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Сканирани $scanned от $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Сканирани $scanned от $total кода');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Засега $count профила',
      one: 'Засега 1 профил',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'На компютъра си отворете Thunderbird и изберете „Инструменти › Изнасяне за мобилно устройство“. Изберете профилите си и сканирайте всеки код, който се покаже. Кодовете могат да се сканират в произволен ред.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Продължаване с $count профила',
      one: 'Продължаване с 1 профил',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Поставяне на текст вместо това';

  @override
  String get accountImportStartOver => 'Започване отначало';

  @override
  String get accountImportDuplicateCode => 'Този код вече е добавен.';

  @override
  String get accountImportRestarted =>
      'Този код е от нов експорт, затова сканираните преди това кодове бяха оставени настрана.';

  @override
  String get accountImportNotThunderbird => 'Това не е код на профил от Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Този код е от по-нова версия на Thunderbird. Обновете Loupe, за да го импортирате.';

  @override
  String get accountImportDamaged => 'Този код на Thunderbird не можа да се прочете.';

  @override
  String get accountImportTooLarge => 'Този код е твърде голям, за да е експорт от Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Настройките не можаха да се отворят.';

  @override
  String get accountImportCameraOffTitle => 'Достъпът до камерата е изключен';

  @override
  String get accountImportCameraOffText =>
      'Разрешете на Loupe да използва камерата в настройките, за да сканира кода, или вместо това поставете текста на кода.';

  @override
  String get accountImportNoCameraTitle => 'Няма камера';

  @override
  String get accountImportNoCameraText => 'Loupe не може да използва камера тук. Вместо това поставете текста на кода.';

  @override
  String get accountImportCameraFailedTitle => 'Камерата не се стартира';

  @override
  String get accountImportCameraFailedText => 'Опитайте отново или вместо това поставете текста на кода.';

  @override
  String get accountImportOpenSettings => 'Отваряне на настройките';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Намерени са $count профила',
      one: 'Намерен е 1 профил',
      zero: 'Не са намерени профили',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Нито един от профилите в тези кодове не можа да се прочете.';

  @override
  String get accountImportChoose => 'Изберете профилите, които да добавите в Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Кодове $codes от $total не са сканирани, затова профилите в тях не са показани.',
      one: 'Код $codes от $total не е сканиран, затова профилите в него не са показани.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes и $last';
  }

  @override
  String get accountImportScanMore => 'Сканиране на още кодове';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count профила в кодовете не можаха да се прочетат. Може да използват настройки от по-нова версия на Thunderbird.',
      one: '1 профил в кодовете не можа да се прочете. Може да използва настройки от по-нова версия на Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Повторно сканиране';

  @override
  String get accountImportAlreadyAdded => 'Профил с този адрес вече има в Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Ще влезете с $provider, когато бъде добавен, както в Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Добавете профила с парола за приложение (изисква потвърждаване в две стъпки).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird влиза в Gmail чрез Google. „Вход с Google“ идва в по-късна компилация; дотогава добавете профила с парола за приложение (изисква потвърждаване в две стъпки).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird влиза в този профил през браузъра. Loupe още не може да прави това: използвайте парола за приложение, ако доставчикът ви предлага такава.';

  @override
  String get accountImportUnencrypted => 'Свързва се без шифроване. Използвайте това само във вашата собствена мрежа.';

  @override
  String get accountImportEnterAgain => 'Въведете я отново';

  @override
  String get accountImportAdded => 'Добавен';

  @override
  String accountImportAdding(int index, int total) {
    return 'Добавяне на $index от $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Добавяне на $count профила',
      one: 'Добавяне на 1 профил',
      zero: 'Добавяне на профили',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Поставяне на текст от експорт';

  @override
  String get accountImportPasteText => 'Поставете текста на код за експорт от Thunderbird, по един код на ред.';

  @override
  String get accountImportPop3 => 'Профилите POP3 не се поддържат. Loupe пази пощата на сървъра чрез IMAP.';

  @override
  String get accountImportKerberos => 'Този профил влиза с Kerberos, който Loupe не поддържа.';

  @override
  String get accountImportNtlm => 'Този профил влиза с NTLM, който Loupe не поддържа.';

  @override
  String get accountImportClientCertificate => 'Този профил влиза с клиентски сертификат, който Loupe още не поддържа.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Входът с Microsoft идва в по-късна компилация. Профилите в Outlook и Microsoft 365 вече не приемат пароли от пощенски приложения.';

  @override
  String get accountImportEnterPassword => 'Въведете паролата.';

  @override
  String get accountImportEnterAppPassword => 'Въведете паролата за приложение.';

  @override
  String get accountImportEnterApiToken => 'Въведете API токена.';

  @override
  String get accountImportStorageFailed =>
      'Loupe не можа да отвори хранилището си за профили. Опитайте отново по-късно.';

  @override
  String get accountImportFailed => 'Профилът не можа да се добави. Опитайте отново или го добавете ръчно.';

  @override
  String get composeNewMessageTitle => 'Ново писмо';

  @override
  String get composeAttach => 'Прикачване';

  @override
  String get composeSendLater => 'Изпращане по-късно';

  @override
  String composeSendAt(String time) {
    return 'Изпращане $time';
  }

  @override
  String get composeSendHint => 'Задръжте, за да изпратите по-късно';

  @override
  String get composeNoAccount => 'Добавете профил, за да изпращате поща.';

  @override
  String get composeTo => 'До:';

  @override
  String get composeCc => 'Копие:';

  @override
  String get composeBcc => 'Скрито копие:';

  @override
  String composeCcBccFrom(String email) {
    return 'Копие/Скрито копие, От: $email';
  }

  @override
  String get composeFromLabel => 'От:';

  @override
  String get composeSubjectLabel => 'Тема:';

  @override
  String composeReplyTo(String address) {
    return 'Отговор до: $address';
  }

  @override
  String get composeFrom => 'От';

  @override
  String composeReplyFrom(String email) {
    return 'Отговор от $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Изпращане от $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Отговор от $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Изпращане от $email?';
  }

  @override
  String get composeDismiss => 'Скриване';

  @override
  String composeAliasNotSaved(String account) {
    return 'Не е запазен като самоличност · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Запазване като самоличност';

  @override
  String composeAliasSaved(String email) {
    return '$email е запазен като самоличност.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Невалиден адрес $address';
  }

  @override
  String get composeOriginalNotFound => 'Оригиналното писмо не беше намерено.';

  @override
  String get composeDraftNotFound => 'Черновата не беше намерена.';

  @override
  String get composeAttachmentsLost => 'Прикачените файлове не можаха да се възстановят. Добавете ги отново.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Някои прикачени файлове не можаха да се добавят: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Прикачените файлове са общо $size; някои сървъри отказват толкова големи писма.';
  }

  @override
  String get composeAttachFailed => 'Файлът не можа да се прикачи.';

  @override
  String get composeInvalidAddressTitle => 'Невалиден адрес';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ не е валиден имейл адрес.';
  }

  @override
  String get composeNoSubjectTitle => 'Без тема';

  @override
  String get composeNoSubjectText => 'Това писмо няма тема. Да се изпрати ли въпреки това?';

  @override
  String get composeSentBeforeChanges => 'Писмото беше изпратено преди промените ви, които са запазени в „Чернови“.';

  @override
  String composeScheduled(String time) {
    return 'Насрочено за $time';
  }

  @override
  String get composeSending => 'Изпращане…';

  @override
  String get composeSent => 'Изпратено';

  @override
  String get composeSendFailed => 'Изпращането е неуспешно. Опитайте отново.';

  @override
  String get composeAlreadySent => 'Вече е изпратено.';

  @override
  String get composeDiscardChanges => 'Отхвърляне на промените';

  @override
  String get composeSaveChanges => 'Запазване на промените';

  @override
  String get composeDeleteDraft => 'Изтриване на черновата';

  @override
  String get composeSaveDraft => 'Запазване на черновата';

  @override
  String get composeDraftSaved => 'Черновата е запазена';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'На $date в $time $name написа:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'На $date в $time някой написа:';
  }

  @override
  String get composeForwardHeader => '---------- Препратено писмо ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'От: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Дата: $date в $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Тема: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'До: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Копие: $addresses';
  }

  @override
  String get composeLaterToday => 'По-късно днес';

  @override
  String get composeTomorrowMorning => 'Утре сутрин';

  @override
  String get composeMondayMorning => 'В понеделник сутрин';

  @override
  String get composePickDateTime => 'Избор на дата и час…';

  @override
  String get composeSendWithoutDelay => 'Изпращане без забавяне';

  @override
  String composeSendTimeToday(String time) {
    return 'Днес в $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Утре в $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day в $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Днес $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Утре $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Да продължите ли с черновата си?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Едно писмо не беше изпратено, когато Loupe се затвори.',
      'one': 'Писмо до $name не беше изпратено, когато Loupe се затвори.',
      'other': 'Писмо до $name и други не беше изпратено, когато Loupe се затвори.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '„$subject“ не беше изпратено, когато Loupe се затвори.',
      'one': '„$subject“ до $name не беше изпратено, когато Loupe се затвори.',
      'other': '„$subject“ до $name и други не беше изпратено, когато Loupe се затвори.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Продължаване на редактирането';

  @override
  String get composeRecoverySave => 'Запазване в „Чернови“';

  @override
  String get composeRecoveryDiscard => 'Отхвърляне';

  @override
  String get composeRecoverySaved => 'Запазено в „Чернови“';

  @override
  String get outboxSectionFailed => 'Неизпратени';

  @override
  String get outboxSectionSending => 'Изпращат се';

  @override
  String get outboxSectionScheduled => 'Насрочени';

  @override
  String get outboxStatusQueued => 'Скоро ще се изпрати';

  @override
  String get outboxStatusSending => 'Изпращане…';

  @override
  String get outboxStatusFailed => 'Не е изпратено';

  @override
  String get outboxNoRecipients => 'Няма получатели';

  @override
  String get outboxNoSubject => '(Без тема)';

  @override
  String get outboxSendingFailed => 'Изпращането е неуспешно.';

  @override
  String get outboxEmptyTitle => 'Няма нищо за изпращане';

  @override
  String get outboxEmptyText => 'Писмата, които изпращате по-късно, чакат тук, докато дойде време.';

  @override
  String get outboxSendNow => 'Изпращане сега';

  @override
  String get outboxReschedule => 'Нов час';

  @override
  String get outboxRescheduleMenu => 'Промяна на часа…';

  @override
  String get outboxRescheduleTitle => 'Промяна на часа';

  @override
  String outboxRescheduled(String time) {
    return 'Пренасрочено за $time';
  }

  @override
  String get outboxCancel => 'Отказ';

  @override
  String get outboxCancelSending => 'Отказ от изпращане…';

  @override
  String get outboxCancelTitle => 'Отказ от изпращането?';

  @override
  String get outboxMoveToDrafts => 'Преместване в „Чернови“';

  @override
  String get outboxDiscard => 'Отхвърляне на писмото';

  @override
  String get outboxMovedToDrafts => 'Преместено в „Чернови“';

  @override
  String get outboxDiscarded => 'Писмото е отхвърлено';

  @override
  String get outboxAlreadySent => 'Вече е изпратено.';

  @override
  String get outboxBeingSent => 'Това писмо се изпраща в момента.';

  @override
  String get outboxActionFailed => 'Това не сработи. Писмото все още е в „Изходящи“.';

  @override
  String get notificationsBadgeInboxes => 'Непрочетени във входящите';

  @override
  String get notificationsBadgeVip => 'Непрочетени от VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Нова поща от вашите VIP контакти във всеки профил';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Нова поща в $email';
  }

  @override
  String get notificationsUnknownSender => 'Неизвестен подател';

  @override
  String get notificationsNoSubject => '(Без тема)';

  @override
  String get notificationsEncryptedMessage => 'Шифровано писмо';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Ново писмо от $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count нови писма', one: '1 ново писмо');
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Нови писма в $account';
  }

  @override
  String get platformInstantChannel => 'Незабавна доставка';

  @override
  String get platformInstantChannelDescription => 'Показва се, докато Loupe следи входящите ви пощи за нова поща';

  @override
  String get platformInstantTitle => 'Следене за нова поща';

  @override
  String get platformInstantText => '„Незабавна доставка“ е включена';

  @override
  String get platformErrorBox => 'Нещо се обърка при показването. Върнете се назад и опитайте отново.';

  @override
  String get welcomeTagline => 'Поща, която е проста отгоре\nи мощна отвътре.';

  @override
  String get welcomeAccountsTitle => 'Всички профили, една спокойна входяща поща';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail и всеки сървър с IMAP или JMAP.';

  @override
  String get welcomeSearchTitle => 'Търсене, което намира';

  @override
  String get welcomeSearchText => 'Мигновени резултати от телефона ви, после и от сървъра.';

  @override
  String get welcomePrivacyTitle => 'Поверителност по замисъл';

  @override
  String get welcomePrivacyText =>
      'Без проследяване. Отдалечените изображения остават блокирани, докато не решите друго.';

  @override
  String get welcomeAddAccount => 'Добавяне на профил';

  @override
  String get welcomeImport => 'Импортиране от Thunderbird';

  @override
  String get welcomeTryDemo => 'Изпробване с демо поща';
}
