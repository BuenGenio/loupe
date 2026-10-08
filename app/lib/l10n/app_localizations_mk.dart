// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get commonAdd => 'Додај';

  @override
  String get commonCancel => 'Откажи';

  @override
  String get commonClose => 'Затвори';

  @override
  String get commonDelete => 'Избриши';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonEdit => 'Уреди';

  @override
  String get commonMore => 'Повеќе';

  @override
  String get commonMove => 'Премести';

  @override
  String get commonName => 'Име';

  @override
  String get commonNone => 'Нема';

  @override
  String get commonOff => 'Исклучено';

  @override
  String get commonOk => 'Во ред';

  @override
  String get commonOn => 'Вклучено';

  @override
  String get commonOptional => 'Незадолжително';

  @override
  String get commonPassword => 'Лозинка';

  @override
  String get commonRemove => 'Отстрани';

  @override
  String get commonRetry => 'Обиди се повторно';

  @override
  String get commonSave => 'Зачувај';

  @override
  String get commonSearch => 'Пребарување';

  @override
  String get commonServer => 'Сервер';

  @override
  String get commonSettings => 'Поставки';

  @override
  String get commonShare => 'Сподели';

  @override
  String get commonTryAgain => 'Обиди се повторно';

  @override
  String get commonUndo => 'Поништи';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count пораки', one: '$count порака');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Архивирај';

  @override
  String get mailDelete => 'Избриши';

  @override
  String get mailFlag => 'Означи со знаменце';

  @override
  String get mailForward => 'Препрати';

  @override
  String get mailMarkAsRead => 'Означи како прочитано';

  @override
  String get mailMarkAsUnread => 'Означи како непрочитано';

  @override
  String get mailMoveToJunk => 'Премести во несакана пошта';

  @override
  String get mailNewMessage => 'Нова порака';

  @override
  String get mailNoSubject => 'Без тема';

  @override
  String get mailReply => 'Одговори';

  @override
  String get mailReplyAll => 'Одговори на сите';

  @override
  String get mailSend => 'Испрати';

  @override
  String get mailUnflag => 'Отстрани знаменце';

  @override
  String get mailboxArchive => 'Архива';

  @override
  String get mailboxDrafts => 'Нацрти';

  @override
  String get mailboxInbox => 'Влезно сандаче';

  @override
  String get mailboxJunk => 'Несакана пошта';

  @override
  String get mailboxOutbox => 'Излезно сандаче';

  @override
  String get mailboxSent => 'Испратени';

  @override
  String get mailboxTrash => 'Корпа';

  @override
  String get conversationSomethingWentWrong => 'Настана грешка. Обидете се повторно.';

  @override
  String get conversationReplyToList => 'Одговори на листата';

  @override
  String get conversationReplyList => 'Одговори на листата';

  @override
  String get conversationThreadMuted => 'Нишката е стишена. Новите пораки во неа пристигнуваат како прочитани.';

  @override
  String get conversationThreadUnmuted => 'Стишувањето на нишката е откажано.';

  @override
  String get conversationLinkFailed => 'Линкот не можеше да се отвори.';

  @override
  String get conversationGoneTitle => 'Нема порака';

  @override
  String get conversationGoneText => 'Оваа порака е преместена или избришана.';

  @override
  String get conversationMuted => 'Стишено';

  @override
  String get conversationReaderOptions => 'Опции за читање';

  @override
  String get conversationReaderOptionsHint => 'Големина на текстот и приказ';

  @override
  String get conversationTrash => 'Во корпа';

  @override
  String get conversationReplyHint => 'Притиснете долго за „Одговори на сите“ и „Препрати“';

  @override
  String get conversationOfflineTitle => 'Не сте поврзани';

  @override
  String get conversationOfflineText =>
      'Овој разговор сè уште не е преземен. Ќе се вчита кога повторно ќе се поврзете.';

  @override
  String get conversationErrorTitle => 'Пораката не може да се прикаже';

  @override
  String get conversationErrorText => 'Настана грешка.';

  @override
  String get conversationOfflineBanner => 'Не сте поврзани';

  @override
  String get conversationNotUpdated => 'Не е ажурирано';

  @override
  String get conversationMe => 'јас';

  @override
  String get conversationNoSender => '(без испраќач)';

  @override
  String get conversationNoRecipients => 'без примачи';

  @override
  String conversationRecipients(String names) {
    return 'до: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'до: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Од';

  @override
  String get conversationHeaderTo => 'До';

  @override
  String get conversationHeaderCc => 'Копија';

  @override
  String get conversationHeaderBcc => 'Скриена копија';

  @override
  String get conversationHeaderReplyTo => 'Одговор до';

  @override
  String get conversationHeaderDate => 'Датум';

  @override
  String get conversationHeaderSecurity => 'Безбедност';

  @override
  String get conversationVerifiedSender => 'Потврден испраќач';

  @override
  String get conversationUnverifiedSender => 'Непотврден испраќач';

  @override
  String get conversationLoadingMessage => 'Се вчитува пораката';

  @override
  String get conversationBodyError => 'Оваа порака не можеше да се вчита.';

  @override
  String get conversationBodyOffline => 'Не сте поврзани. Пораката ќе се вчита кога повторно ќе се поврзете.';

  @override
  String get conversationOriginalHint => 'Изгледа подобро во приказот „Оригинал“';

  @override
  String get conversationShowOriginal => 'Прикажи оригинал';

  @override
  String get conversationScrollToTop => 'Оди на врвот';

  @override
  String get conversationTagsMenu => 'Ознаки…';

  @override
  String get conversationMuteThread => 'Стиши ја нишката';

  @override
  String get conversationUnmuteThread => 'Откажи го стишувањето';

  @override
  String get conversationMoveMenu => 'Премести…';

  @override
  String get conversationDeletePermanently => 'Избриши трајно';

  @override
  String get conversationMoveToTrash => 'Премести во корпа';

  @override
  String get conversationNotJunk => 'Не е несакана пошта';

  @override
  String get conversationShowAllHeaders => 'Прикажи ги сите заглавија';

  @override
  String get conversationViewSource => 'Прикажи извор';

  @override
  String get conversationSaveAsFile => 'Зачувај како датотека…';

  @override
  String get conversationShareAsFile => 'Сподели како датотека…';

  @override
  String get conversationSearchFromMessageMenu => 'Пребарај врз основа на пораката…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Копирај ја адресата';

  @override
  String get conversationAddressCopied => 'Адресата е копирана';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Пребарај пораки од $name';
  }

  @override
  String get conversationTags => 'Ознаки';

  @override
  String get conversationAllHeaders => 'Сите заглавија';

  @override
  String get conversationCopyAll => 'Копирај сè';

  @override
  String get conversationHeadersCopied => 'Заглавијата се копирани';

  @override
  String get conversationNoHeaders => 'Нема заглавија';

  @override
  String get conversationSearchFromMessageTitle => 'Пребарување врз основа на пораката';

  @override
  String conversationSearchFrom(String name) {
    return 'Од $name';
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
  String get conversationSourceTitle => 'Извор';

  @override
  String get conversationSourceCopied => 'Изворот е копиран';

  @override
  String get conversationShareFailed => 'Пораката не можеше да се сподели.';

  @override
  String get conversationWrapLines => 'Прекршувај ги редовите';

  @override
  String get conversationDontWrapLines => 'Не прекршувај ги редовите';

  @override
  String get conversationSourceError => 'Изворот не можеше да се вчита.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Прикажани се првите $shown од $total. Копирајте или споделете за да добиете сè.';
  }

  @override
  String get conversationAttachmentUntitled => 'Без име';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Повеќе дејства за $name';
  }

  @override
  String get conversationMoveTo => 'Премести во…';

  @override
  String get conversationMailboxesError => 'Сандачињата не можеа да се вчитаат.';

  @override
  String get conversationReaderReadable => 'Читливо';

  @override
  String get conversationReaderOriginal => 'Оригинал';

  @override
  String get conversationReaderPlain => 'Обичен текст';

  @override
  String get conversationReaderSans => 'Без серифи';

  @override
  String get conversationReaderMono => 'Моно';

  @override
  String get conversationReaderKeepColours => 'Задржи ги оригиналните бои';

  @override
  String get conversationReaderRemember => 'Запомни за овој испраќач';

  @override
  String get conversationSecurityPossiblePhishing => 'Можен фишинг';

  @override
  String get conversationSecurityBeCareful => 'Бидете внимателни';

  @override
  String get conversationSecurityVerified => 'Потврдено';

  @override
  String get conversationSecurityNoIssues => 'Не се пронајдени проблеми';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count елементи за следење',
      one: '$count елемент за следење',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Покажува зошто';

  @override
  String get conversationPhishingBannerTitle => 'Оваа порака изгледа како фишинг';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Линковите и сликите се исклучени.';
  }

  @override
  String get conversationPhishingBannerText => 'Линковите и сликите се исклучени.';

  @override
  String get conversationPhishingWhy => 'Зошто?';

  @override
  String get conversationPhishingShowAnyway => 'Сепак прикажи';

  @override
  String get conversationSecurityPhishingTitle => 'Ова изгледа како фишинг';

  @override
  String get conversationSecurityPhishingText => 'Повеќе знаци укажуваат дека оваа порака не е тоа што тврди дека е.';

  @override
  String get conversationSecurityCarefulTitle => 'Бидете внимателни со оваа порака';

  @override
  String get conversationSecurityCarefulText => 'Нешто во неа заслужува подобро да се погледне.';

  @override
  String get conversationSecurityVerifiedText => 'Испраќачот е потврден и ништо не изгледа сомнително.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ништо не изгледа сомнително. Вашиот сервер за е-пошта не наведе дали испраќачот е потврден.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ништо не изгледа сомнително.';

  @override
  String get conversationSecurityWhy => 'Зошто';

  @override
  String get conversationSecurityPrivacy => 'Приватност';

  @override
  String get conversationSecurityNoTrackingPixels => 'Нема пиксели за следење';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Отстранети се $count пиксели за следење',
      one: 'Отстранет е $count пиксел за следење',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText =>
      'Тие би му јавиле на испраќачот кога сте ја отвориле оваа порака.';

  @override
  String get conversationSecurityNoRemoteImages => 'Нема далечински слики';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count далечински слики',
      one: '$count далечинска слика',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ако ги вчитате, испраќачот дознава кога ја читате оваа порака, како и вашата IP-адреса.';

  @override
  String get conversationSecurityNoClickTracking => 'Нема следење на кликови';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count линкови со следење на кликови',
      one: '$count линк со следење на кликови',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Вашиот клик би го забележале: $services. Притиснете долго на линкот за директно да го отворите неговото одредиште.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Технички детали';

  @override
  String get conversationSecurityCheckedLocally => 'Проверено на овој уред. Ништо не е испратено никаде.';

  @override
  String get conversationSecurityTrackersLabel => 'Елементи за следење';

  @override
  String get conversationSecurityImagesFrom => 'Слики од';

  @override
  String get conversationSecuritySenderHistory => 'Историја на испраќачот';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'примени: $received, испратени: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Линковите водат до';

  @override
  String get conversationSecurityHidden => 'Скриено';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements елементи',
      one: '$elements елемент',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters знаци',
      one: '$characters знак',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Испраќачот не е потврден';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Вашиот сервер за е-пошта не можеше да потврди дека оваа порака навистина доаѓа од доменот $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Вашиот сервер за е-пошта не можеше да потврди дека оваа порака навистина доаѓа од наведениот испраќач.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Вашиот сервер за е-пошта не можеше да потврди дека оваа порака доаѓа од доменот $domain. Тоа е често кај мејлинг-листите.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Вашиот сервер за е-пошта не можеше да потврди дека оваа порака доаѓа од наведениот испраќач. Тоа е често кај мејлинг-листите.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Не постапувајте според неа, освен ако не сте ја очекувале. Ако не сте сигурни, контактирајте го испраќачот на друг начин.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Потпишано од друг домен';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Пораката е потпишана од $signer, а не од $domain. Сервисите за масовно испраќање пошта го прават тоа, но тоа не докажува кој ја напишал.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Пораката е потпишана од друг домен, а не од $domain. Сервисите за масовно испраќање пошта го прават тоа, но тоа не докажува кој ја напишал.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Името прикажува друга адреса';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Во името на испраќачот пишува „$shown“, но пораката доаѓа од $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Верувајте ѝ на адресата, а не на името.';

  @override
  String get conversationSecurityReplyToTitle => 'Одговорите одат на друга адреса';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Вашиот одговор би отишол на $address, а не на $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Проверете ја адресата пред да одговорите со нешто лично.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Го користи вашето име';

  @override
  String get conversationSecurityImpersonationTitle => 'Го користи името на некој што го познавате';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Потпишана е со „$name“, исто како вашето име, но доаѓа од нова адреса: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Потпишана е со „$name“, како вашиот VIP-контакт $knownName ($knownEmail), но доаѓа од нова адреса: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Потпишана е со „$name“, како $knownName ($knownEmail), но доаѓа од нова адреса: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Освен тоа, одговорите би оделе на уште една друга адреса.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ако бара пари, кодови или датотеки, прво проверете со таа личност на друг начин.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Позната адреса: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Оваа адреса: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Прва порака од овој испраќач';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Досега не сте примале пошта од $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice =>
      'Бидете внимателни со барањата од луѓе што сè уште не ги познавате.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Букви со сличен изглед во адресата на испраќачот';

  @override
  String get conversationSecurityLinkHomographTitle => 'Букви со сличен изглед во линк';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Адресата $host меша букви од различни писма за да имитира друга адреса.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Адресата $host користи букви со сличен изглед: тоа не е $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Избришете ја или пријавете ја како несакана пошта.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Не отворајте го.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Домен: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Домен што имитира друг';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Користи познато име во доменот';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Доменот $domain личи на вашиот домен $real, но е друг домен.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Доменот $domain личи на $brand ($real), но е друг домен.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Доменот $domain го користи името на вашиот домен $real, но не е ваш.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Доменот $domain го користи името $brand ($real), но не е нивен.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Вистинските пораки од вашата организација доаѓаат од $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Вистинските пораки од $brand доаѓаат од $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Домен на испраќачот: $domain';
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
      other: '$count линкови кријат каде водат',
      one: '$count линк крие каде води',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Линкот прикажува $shown, но отвора $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Не најавувајте се и не плаќајте преку овие линкови. Наместо тоа, внесете ја адресата сами.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Одредиштето на линкот не може да се провери';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Линкот прикажува $shown, но минува преку $host, што го бележи кликот пред да го препрати понатаму.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Линкот води директно до IP-адреса';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts не е веб-страница со име. Вистинските компании ретко поставуваат вакви линкови.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Прикриен линк';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Линкот започнува со „$shown@“ за да личи на $shown, но отвора $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Оневозможена е скриена страница';

  @override
  String get conversationSecurityDataLinkText =>
      'Линкот би отворил страница спакувана во самата порака, што е начин да се заобиколат проверките на линковите.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Бара лозинка';

  @override
  String get conversationSecurityPasswordFieldText => 'Пораката содржеше поле за лозинка. Loupe го отстрани.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Никогаш не внесувајте лозинка во е-порака.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Оневозможен е линк што извршува код';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe никогаш не извршува код од пораките.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count скратени линкови',
      one: '$count скратен линк',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts го крие вистинското одредиште додека не го отворите линкот.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Меѓународна веб-адреса';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts користи букви што не се латинични. Тоа е вообичаено за многу јазици; проверете дали е тоа страницата што ја очекувате.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Многу скриен текст';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Отстранети се $count знаци невидлив текст. Ваквиот скриен текст е наменет да ги измами филтрите за несакана пошта.',
      one:
          'Отстранет е $count знак невидлив текст. Ваквиот скриен текст е наменет да ги измами филтрите за несакана пошта.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Отстранет е скриен текст';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Отстранети се $count знаци невидлив текст.',
      one: 'Отстранет е $count знак невидлив текст.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed =>
      'Пораката не можеше да се преземе. Проверете ја врската со интернет и обидете се повторно.';

  @override
  String exportSaved(String name) {
    return 'Зачувано: „$name“';
  }

  @override
  String get exportSaveFailed => 'Пораката не можеше да се зачува.';

  @override
  String exportFailed(String folder) {
    return 'Папката „$folder“ не можеше да се извезе.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Папката „$folder“ нема пораки за извоз.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Папката „$folder“ не можеше да се извезе: ниту една порака не можеше да се преземе. Проверете ја врската со интернет и обидете се повторно.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Зачувано: „$name“, без $formattedCount пораки што не можеа да се преземат.',
      one: 'Зачувано: „$name“, без $count порака што не можеше да се преземе.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Датотеката „$name“ не можеше да се зачува.';
  }

  @override
  String exportTitle(String folder) {
    return 'Извоз на папката „$folder“';
  }

  @override
  String get exportListing => 'Се бараат пораките…';

  @override
  String exportProgress(String current, String total) {
    return 'Се извезува $current од $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount пораки не можеа да се преземат',
      one: '$count порака не можеше да се преземе',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Сандачиња';

  @override
  String get mailboxesShown => 'Прикажано';

  @override
  String get mailboxesHidden => 'Скриено';

  @override
  String get mailboxesCollapse => 'Собери';

  @override
  String get mailboxesExpand => 'Прошири';

  @override
  String get mailboxesManageVips => 'Управувај со VIP-контактите';

  @override
  String get mailboxesSubscriptions => 'Претплати';

  @override
  String mailboxesShowAccount(String account) {
    return 'Прикажи ја сметката $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Скриј ја сметката $account';
  }

  @override
  String get mailboxesExportFolder => 'Извези ја папката…';

  @override
  String get mailboxesUnpin => 'Откачи';

  @override
  String get mailboxesLists => 'Листи';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Зачувајте пребарување за да го имате тука.';

  @override
  String get mailboxesTags => 'Ознаки';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Може и да допрете на името на испраќачот во пораката и да вклучите VIP.';

  @override
  String get mailboxesAddVip => 'Додај VIP-контакт…';

  @override
  String get mailboxesAddVipTitle => 'Додај VIP-контакт';

  @override
  String get mailboxesAddVipText => 'Поштата од оваа адреса добива ѕвездичка и се појавува во сандачето VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Непрочитано';

  @override
  String get messageListFilterFlagged => 'Со знаменце';

  @override
  String get messageListFilterToMe => 'До мене';

  @override
  String get messageListFilterCcMe => 'Копија до мене';

  @override
  String get messageListFilterWithAttachments => 'Со прилози';

  @override
  String get messageListFilterUnreplied => 'Без одговор';

  @override
  String get messageListFilterFromVips => 'Од VIP-контакти';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се означени како прочитани',
      one: '$count порака е означена како прочитана',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Постарата пошта не можеше да се вчита.';

  @override
  String get messageListSelectMessages => 'Изберете пораки';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Избрано: $count', one: 'Избрано: $count');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Избери ги сите';

  @override
  String get messageListDeselectAll => 'Поништи го изборот';

  @override
  String get messageListLoadFailed => 'Поштата не можеше да се вчита';

  @override
  String get messageListNoUnread => 'Нема непрочитана пошта';

  @override
  String get messageListNoMatches => 'Нема соодветна пошта';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Филтрирано по: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Исклучи го филтерот';

  @override
  String get messageListEmpty => 'Нема пошта';

  @override
  String get messageListFilter => 'Филтер';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Критериуми за филтрирање: $filters';
  }

  @override
  String get messageListFilteredBy => 'Филтрирано по:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount непрочитани',
      one: '$count непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Означи';

  @override
  String get messageListTrash => 'Во корпа';

  @override
  String get messageListFilterTitle => 'Филтер';

  @override
  String get messageListFilterInclude => 'ПРИКАЖИ';

  @override
  String get panesHideMailboxes => 'Скриј ги сандачињата';

  @override
  String get panesShowMailboxes => 'Прикажи ги сандачињата';

  @override
  String get panesMailboxesWidth => 'Ширина на колоната со сандачиња';

  @override
  String get panesListWidth => 'Ширина на листата пораки';

  @override
  String get panesNoMessageSelected => 'Не е избрана порака';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count пораки', one: '$count порака');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Одложени';

  @override
  String get snoozeSheetTitle => 'Одложување';

  @override
  String get snoozeLaterToday => 'Подоцна денес';

  @override
  String get snoozeThisEvening => 'Вечерва';

  @override
  String get snoozeTomorrow => 'Утре';

  @override
  String get snoozeThisWeekend => 'Овој викенд';

  @override
  String get snoozeNextWeek => 'Следната недела';

  @override
  String get snoozePickDateTime => 'Избери датум и време…';

  @override
  String get snoozeMenu => 'Одложи…';

  @override
  String get snoozeWakeNow => 'Врати сега';

  @override
  String get snoozeChangeTimeMenu => 'Промени го времето на одложување…';

  @override
  String get snoozeChangeTime => 'Промени време';

  @override
  String get snoozeNoTime => 'Нема поставено време';

  @override
  String get snoozeFooter =>
      'Одложените пораки се враќаат во Влезното сандаче како непрочитани, во времето што сте го одредиле.';

  @override
  String get snoozeEmptyTitle => 'Нема одложени пораки';

  @override
  String get snoozeEmptyText => 'Одложете ја пораката и таа ќе се врати во Влезното сандаче кога ќе ви треба.';

  @override
  String get appLockUnlock => 'Отклучи';

  @override
  String get appLockFailed => 'Loupe не можеше да потврди дека сте вие.';

  @override
  String get appLockLockedOut => 'Премногу обиди. Обидете се повторно подоцна.';

  @override
  String get appLockPromptError => 'Прозорецот за потврда не можеше да се прикаже. Обидете се повторно.';

  @override
  String get appLockNoScreenLock => 'Овој телефон нема заклучување на екранот.';

  @override
  String get appLockUnlockPromptTitle => 'Отклучи го Loupe';

  @override
  String get appLockUnlockPromptReason => 'Потврдете дека сте вие за да ја видите вашата пошта.';

  @override
  String get appLockTurnOnPromptTitle => 'Вклучи заклучување на апликацијата';

  @override
  String get appLockTurnOnPromptReason => 'Потврдете дека сте вие за да го вклучите заклучувањето на апликацијата.';

  @override
  String get appLockScreenLockRemoved =>
      'Заклучувањето на апликацијата е исклучено: овој телефон веќе нема заклучување на екранот. Поставете го за повторно да го вклучите заклучувањето на апликацијата.';

  @override
  String get appLockAfterImmediately => 'Веднаш';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count минути', one: '$count минута');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count часа', one: '$count час');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Шифрирано';

  @override
  String get openpgpEncryptedInPart => 'Делумно шифрирано';

  @override
  String get openpgpEncryptedLocked => 'Шифрирано · заклучено';

  @override
  String get openpgpEncryptedNoKey => 'Шифрирано · нема клуч';

  @override
  String get openpgpEncryptedDamaged => 'Шифрирано · оштетено';

  @override
  String get openpgpEncryptedUnsupported => 'Шифрирано · не е поддржано';

  @override
  String get openpgpUnknownSigner => 'непознато лице';

  @override
  String get openpgpUnknownKey => 'Непознат клуч';

  @override
  String get openpgpSignatureInvalid => 'Неважечки потпис';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Потпишано од $name, не од испраќачот';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Делумно потпишано од $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Потпишано од $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Потпишано со отфрлен клуч';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Потпишано од $name · клучот не е прифатен';
  }

  @override
  String get openpgpUnlock => 'Отклучи';

  @override
  String get openpgpCantDecrypt => 'Пораката не може да се дешифрира';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Шифрирано со OpenPGP';

  @override
  String get openpgpEncryption => 'Шифрирање';

  @override
  String get openpgpDecryptedHere => 'Дешифрирано на овој уред';

  @override
  String get openpgpNotDecrypted => 'Не е дешифрирано';

  @override
  String get openpgpKeyLocked => 'Вашиот клуч е заклучен.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Шифрирано за: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Заштитена тема';

  @override
  String get openpgpUnlockKey => 'Отклучи го клучот';

  @override
  String get openpgpSignature => 'Потпис';

  @override
  String get openpgpFingerprint => 'Отпечаток';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ИД на клучот: $id';
  }

  @override
  String get openpgpSigned => 'Потпишано';

  @override
  String get openpgpProblem => 'Проблем';

  @override
  String get openpgpAcceptance => 'Прифаќање';

  @override
  String get openpgpChangeAcceptance => 'Промени го прифаќањето…';

  @override
  String get openpgpCheckedFooter => 'Проверено на овој уред со OpenPGP, компатибилно со Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Вашиот клуч е заклучен. Отклучете го со неговата тајна фраза за да ја прочитате пораката.';

  @override
  String get openpgpSummaryNoSecretKey => 'Шифрирана е за клуч што не е на овој уред.';

  @override
  String get openpgpSummaryDamaged => 'Шифрираните податоци се оштетени или изменети при преносот.';

  @override
  String get openpgpSummaryUnsupported => 'Користи алгоритам што Loupe не го поддржува.';

  @override
  String get openpgpSummaryEncrypted => 'Само вие и другите примачи можете да ја прочитате.';

  @override
  String get openpgpSummaryNotSigned => 'Не е потпишана, па испраќачот не е потврден.';

  @override
  String get openpgpSummaryUnknownKey => 'Потпишана е, но со клуч што го немате, па потписот не може да се провери.';

  @override
  String get openpgpSummaryBadSignature => 'Потписот не се совпаѓа: пораката можеби е изменета.';

  @override
  String get openpgpSummaryMismatch =>
      'Потписот е важечки, но клучот припаѓа на друга адреса, а не на адресата на испраќачот.';

  @override
  String get openpgpSummaryPartial =>
      'Потпишан е само дел од пораката. Текстот надвор од потписот (на пример, подножјето на мејлинг-листа) се прикажува под линијата „Unsigned content“, а потписот не ги опфаќа ни другите делови од пораката, како што се прилозите.';

  @override
  String get openpgpSummaryOwnKey => 'Потпишано со вашиот клуч.';

  @override
  String get openpgpSummaryVerified => 'Потписот е важечки и го проверивте отпечатокот на клучот.';

  @override
  String get openpgpSummaryUnverified => 'Потписот е важечки. Го прифативте клучот без да го проверите отпечатокот.';

  @override
  String get openpgpSummaryRejected => 'Потписот е важечки, но го отфрливте овој клуч.';

  @override
  String get openpgpSummaryUndecided =>
      'Потписот е важечки, но сè уште не сте го прифатиле овој клуч. Споредете го неговиот отпечаток со испраќачот.';

  @override
  String get openpgpAcceptanceRejected => 'Отфрлен';

  @override
  String get openpgpAcceptanceUndecided => 'Не е прифатен';

  @override
  String get openpgpAcceptanceUnverified => 'Прифатен';

  @override
  String get openpgpAcceptanceVerified => 'Прифатен и проверен';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Да се прифати клучот на $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Отпечаток: $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Да, го проверив отпечатокот';

  @override
  String get openpgpAcceptUnverified => 'Да, без проверка';

  @override
  String get openpgpAcceptLater => 'Сè уште не';

  @override
  String get openpgpRejectKey => 'Отфрли го овој клуч';

  @override
  String get openpgpNoSubject => '(без тема)';

  @override
  String get openpgpEncryptionTitle => 'Шифрирање од крај до крај';

  @override
  String get openpgpMyKeys => 'Мои OpenPGP клучеви';

  @override
  String get openpgpMyKeysFooter =>
      'Со клуч можете да читате шифрирана пошта и да ја потпишувате и шифрирате својата. Користите Thunderbird? Таму извезете го клучот (Account Settings › End-To-End Encryption › Backup Secret Key To File) и увезете го овде.';

  @override
  String get openpgpAddKey => 'Додај клуч…';

  @override
  String get openpgpAddresses => 'Адреси';

  @override
  String get openpgpAddressesFooter => 'Кој клуч го користи секоја адреса и кога шифрира и потпишува.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP клучеви на контактите';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Прифатете го клучот кога ќе бидете сигурни дека му припаѓа на сопственикот, а споредете го отпечатокот со сопственикот за да го означите како проверен.';

  @override
  String get openpgpImportPublicKey => 'Увези јавен клуч…';

  @override
  String get openpgpCollected => 'Собрано преку Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Клучеви што пристигнаа со пораките. Loupe може да шифрира за нив кога двете страни го бараат тоа.';

  @override
  String get openpgpOnThisDevice => 'На овој уред';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Шифрираните пораки ја кријат својата тема. Loupe ја чува темата на секоја порака што ќе ја отворите во својата шифрирана база на податоци на овој уред, за да се прикажува во списокот, во пребарувањето и во известувањата. Во заднина, Loupe може да ги дешифрира и темите на новите пораки со клучеви без тајна фраза; за тоа ја презема секоја порака (до 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Дешифрирај ги темите во заднина';

  @override
  String get openpgpIndexFooter =>
      'Пребарувањето ги наоѓа шифрираните пораки според испраќачот, примачите и темата. Кога ова е вклучено, Loupe го додава и текстот на секоја шифрирана порака што ја дешифрира во индексот за пребарување во својата шифрирана база на податоци на овој уред, па пребарувањето ја наоѓа и според текстот. Со исклучување, тој текст се отстранува од индексот.';

  @override
  String get openpgpIndexDecrypted => 'Индексирај ги дешифрираните пораки за пребарување';

  @override
  String get openpgpPassphrases => 'Тајни фрази';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP клучевите и S/MIME сертификатите што ги штитите со тајна фраза се отклучуваат кога е потребно. Без „Запомни ги тајните фрази“, повторно се заклучуваат две минути по секоја употреба.';

  @override
  String get openpgpRememberPassphrases => 'Запомни ги тајните фрази';

  @override
  String get openpgpRememberPassphrasesDetail => 'Додека Loupe не се затвори';

  @override
  String get openpgpLockKeysNow => 'Заклучи ги клучевите сега';

  @override
  String get openpgpKeysLocked => 'Клучевите се заклучени.';

  @override
  String get openpgpKeyStateRevoked => 'отповикан';

  @override
  String get openpgpKeyStateExpired => 'истечен';

  @override
  String get openpgpKeyStateNeverExpires => 'не истекува';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'истекува на $date';
  }

  @override
  String get openpgpNoKey => 'Нема клуч';

  @override
  String get openpgpAlwaysEncrypt => 'Секогаш шифрирај';

  @override
  String get openpgpAddKeyTitle => 'Додавање OpenPGP клуч';

  @override
  String get openpgpAddKeyMessage => 'Увезете го клучот што го користите во Thunderbird или создадете нов.';

  @override
  String get openpgpImportFromClipboard => 'Увези од привремената меморија';

  @override
  String get openpgpImportFromFile => 'Увези од датотека';

  @override
  String get openpgpGenerateNewKey => 'Создај нов клуч';

  @override
  String get openpgpImportPublicKeyTitle => 'Увоз на јавен клуч';

  @override
  String get openpgpFromClipboard => 'Од привремената меморија';

  @override
  String get openpgpFromFile => 'Од датотека';

  @override
  String get openpgpClipboardEmpty => 'Привремената меморија е празна. Прво копирајте го клучот.';

  @override
  String get openpgpKey => 'Клуч';

  @override
  String get openpgpValidityRevoked => 'Отповикан';

  @override
  String openpgpValidityExpired(String date) {
    return 'Истечен на $date';
  }

  @override
  String get openpgpNeverExpires => 'Не истекува';

  @override
  String openpgpValidUntil(String date) {
    return 'Важи до $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Отпечатокот е копиран.';

  @override
  String get openpgpAlgorithm => 'Алгоритам';

  @override
  String get openpgpCreated => 'Создаден';

  @override
  String get openpgpValidity => 'Важност';

  @override
  String get openpgpProtection => 'Заштита';

  @override
  String get openpgpProtectionPassphrase => 'Тајна фраза';

  @override
  String get openpgpProtectionKeychain => 'Само складиштето за клучеви';

  @override
  String get openpgpKeyDetailsFooter =>
      'Споделете го јавниот клуч за да можат другите да ви испраќаат шифрирана пошта. Резервната копија е вашиот таен клуч, заштитен со неговата тајна фраза ако ја има: не ја споделувајте со никого.';

  @override
  String get openpgpSharePublicKey => 'Сподели го јавниот клуч';

  @override
  String get openpgpCopyPublicKey => 'Копирај го јавниот клуч';

  @override
  String get openpgpPublicKeyCopied => 'Јавниот клуч е копиран.';

  @override
  String get openpgpBackUpSecretKey => 'Направи резервна копија од тајниот клуч';

  @override
  String get openpgpDeleteKey => 'Избриши го клучот';

  @override
  String get openpgpRemoveKey => 'Отстрани го клучот';

  @override
  String get openpgpBackUpTitle => 'Да се направи резервна копија од тајниот клуч?';

  @override
  String get openpgpBackUpProtected =>
      'Резервната копија е заштитена со тајната фраза на вашиот клуч. Секој што ги има и двете може да ја чита вашата пошта.';

  @override
  String get openpgpBackUpUnprotected =>
      'Овој клуч нема тајна фраза: секој што ја има резервната копија може да ја чита вашата пошта и да потпишува во ваше име.';

  @override
  String get openpgpBackUp => 'Направи копија';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Да се избрише вашиот клуч $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Да се отстрани клучот на $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Поштата шифрирана за овој клуч повеќе нема да може да се чита на овој уред, освен ако повторно не го увезете.';

  @override
  String get openpgpRemoveKeyMessage => 'Подоцна можете повторно да го увезете.';

  @override
  String get openpgpKeyHeader => 'OpenPGP клуч';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Додајте клуч во „Шифрирање од крај до крај“ за да шифрирате и потпишувате пошта од оваа адреса.';

  @override
  String get openpgpGenerateAKey => 'Создај клуч…';

  @override
  String get openpgpSending => 'Испраќање';

  @override
  String get openpgpSendingFooter =>
      'Автоматското шифрирање се вклучува кога секој примач има прифатен клуч или доверлив сертификат, или кога Autocrypt покажува дека двете страни го сакаат тоа. Шифрираната пошта секогаш е потпишана.';

  @override
  String get openpgpEncryptAutomatically => 'Шифрирај автоматски';

  @override
  String get openpgpAlwaysEncryptDetail => 'Не испраќа ако некој примач нема клуч';

  @override
  String get openpgpSignUnencrypted => 'Потпишувај нешифрирана пошта';

  @override
  String get openpgpAttachPublicKey => 'Приложи го мојот јавен клуч';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt го испраќа вашиот јавен клуч со секоја порака, па другите апликации можат да шифрираат за вас без никакво поставување.';

  @override
  String get openpgpSendMyKey => 'Испраќај го мојот клуч со поштата';

  @override
  String get openpgpPreferEncryption => 'Претпочитај шифрирање';

  @override
  String get openpgpPreferEncryptionDetail => 'Барај од другите да шифрираат кога можат';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count години', one: '$count година');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Тајните фрази не се совпаѓаат.';

  @override
  String openpgpKeyReady(String id) {
    return 'Вашиот клуч $id е подготвен.';
  }

  @override
  String get openpgpNewKey => 'Нов клуч';

  @override
  String get openpgpNewKeyFor => 'Сопственик на клучот';

  @override
  String get openpgpYourName => 'Вашето име';

  @override
  String get openpgpAddress => 'Адреса';

  @override
  String get openpgpPassphrase => 'Тајна фраза';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Незадолжително. Без неа, клучот го штити само складиштето за клучеви на телефонот и Loupe никогаш не ја бара. Со неа, Loupe ја бара кога е потребен клучот.';

  @override
  String get openpgpRepeatPassphrase => 'Повтори';

  @override
  String get openpgpExpires => 'Рок на важност';

  @override
  String get openpgpExpiresFooter => 'Можете да создадете нов клуч пред да истече. И Thunderbird користи три години.';

  @override
  String get openpgpGenerateKey => 'Создај клуч';

  @override
  String get openpgpKeyFor => 'Клуч за адреса';

  @override
  String get openpgpCantEncrypt => 'Не може да се шифрира';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Нема OpenPGP клуч за $names, а оваа адреса секогаш шифрира. Отстранете го примачот или увезете клуч во „Поставки › Шифрирање од крај до крај“.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Нема важечки S/MIME сертификат за $names, а оваа адреса секогаш шифрира. Отстранете го примачот или увезете сертификат во „Поставки › Шифрирање од крај до крај“.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Нема OpenPGP клуч за $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Нема важечки S/MIME сертификат за $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Испрати нешифрирано';

  @override
  String get openpgpCantSign => 'Не може да се потпише';

  @override
  String get openpgpCantSignMessage =>
      'Приватниот клуч на вашиот S/MIME сертификат не е на овој уред. Повторно увезете го сертификатот (датотека .p12 или .pfx) во „Поставки › Шифрирање од крај до крај“.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Нема клуч за $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Нема сертификат за $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Клучеви од Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Сите имаат клуч';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Сите имаат сертификат';

  @override
  String get openpgpComposeEncrypt => 'Шифрирај';

  @override
  String get openpgpComposeSign => 'Потпиши';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, промени стандард';
  }

  @override
  String get openpgpNoKeyFound => 'Не е пронајден OpenPGP клуч.';

  @override
  String get openpgpImportSecretKeyTitle => 'Да се увезе таен клуч?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Овој прилог содржи таен клуч ($names). Увезете го како свој клуч само ако самите сте го извезле, на пример од Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Увези како мој клуч';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'вашиот клуч $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Да се увезат $count клучеви ($names)?',
      one: 'Да се увезе $count клуч ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Увези и прифати';

  @override
  String get openpgpImportDecideLater => 'Увези, одлучи подоцна';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'клучот на $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Увезено: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Приложени се $count OpenPGP клучеви.',
      one: 'Приложен е $count OpenPGP клуч.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Увези';

  @override
  String get openpgpUnlockKeyTitle => 'Отклучување на OpenPGP клуч';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Внесете ја тајната фраза за клучот на $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Тајната фраза не е точна. Обидете се повторно.';

  @override
  String get openpgpExplainLocked => 'Оваа порака е шифрирана. Отклучете го вашиот OpenPGP клуч за да ја прочитате.';

  @override
  String get openpgpExplainNoKey =>
      'Оваа порака е шифрирана, но не за ниеден OpenPGP клуч на овој уред. Ако ја читате во Thunderbird, увезете го вашиот клуч оттаму во „Поставки › Шифрирање од крај до крај“.';

  @override
  String get openpgpExplainDamaged => 'Оваа шифрирана порака е оштетена, па не може безбедно да се дешифрира.';

  @override
  String get openpgpExplainUnsupported => 'Оваа порака користи шифрирање што Loupe сè уште не може да го прочита.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Оваа порака е шифрирана со S/MIME, но не за ниеден сертификат на овој уред. Увезете го вашиот сертификат (датотека .p12 или .pfx) во „Поставки › Шифрирање од крај до крај“.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Оваа порака е шифрирана. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Отклучете го вашиот S/MIME сертификат за да ја прочитате.';

  @override
  String get openpgpAttachmentGone => 'Овој прилог повеќе не е достапен.';

  @override
  String get smimeEncrypted => 'Шифрирано (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Шифрирано (S/MIME) · нема сертификат';

  @override
  String get smimeEncryptedDamaged => 'Шифрирано (S/MIME) · оштетено';

  @override
  String get smimeEncryptedUnsupported => 'Шифрирано (S/MIME) · не е поддржано';

  @override
  String get smimeEncryptedLocked => 'Шифрирано (S/MIME) · заклучено';

  @override
  String get smimeUnknownSigner => 'непознато лице';

  @override
  String get smimeSignatureModified => 'Неважечки потпис: пораката е изменета';

  @override
  String get smimeSignatureWeak => 'Небезбеден потпис: застарен алгоритам';

  @override
  String get smimeSignatureUncheckable => 'Потписот не може да се провери';

  @override
  String get smimeSignedCertificateMissing => 'Потпишано · недостасува сертификат';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Потпишано од $name · сертификатот е отповикан';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Потпишано од $name · на друг датум';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Потпишано од $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Потпишано од $name · неважечки сертификат';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Потпишано од $name · сертификатот не е доверлив';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Потпишано од $name · сертификатот е истечен';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Потпишано од $name · сертификатот сè уште не важи';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Потпишано од $name · сертификатот не е за пошта';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Потпишано од $name, не од испраќачот';
  }

  @override
  String get smimeCantDecrypt => 'Пораката не може да се дешифрира';

  @override
  String get smimeEncryptedWithSmime => 'Шифрирано со S/MIME';

  @override
  String get smimeEncryption => 'Шифрирање';

  @override
  String get smimeDecryptedHere => 'Дешифрирано на овој уред';

  @override
  String get smimeNotDecrypted => 'Не е дешифрирано';

  @override
  String get smimeAuthenticated => 'автентицирано';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count сертификати',
      one: 'за $count сертификат',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Потпис';

  @override
  String get smimeIssuedBy => 'Издавач';

  @override
  String get smimeValid => 'Важи';

  @override
  String smimeValidRange(String from, String to) {
    return 'од $from до $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 отпечаток';

  @override
  String get smimeSigned => 'Потпишано';

  @override
  String get smimeProblem => 'Проблем';

  @override
  String get smimeCheckingRevocation => 'Се проверува отповикувањето…';

  @override
  String get smimeNotRevoked => 'Не е отповикан';

  @override
  String get smimeRevoked => 'Отповикан';

  @override
  String get smimeRevocationUnknown => 'Непознато дали е отповикан';

  @override
  String smimeRevokedSince(String date) {
    return 'Од $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Проверено кај сертификациското тело (листа на отповикани сертификати), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Проверено кај сертификациското тело (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Верувај му на издавачот „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Верувај му на овој сертификат…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Проверено на овој уред со S/MIME, компатибилно со Outlook и Thunderbird; отповикувањето е проверено кај сертификациското тело.';

  @override
  String get smimeCheckedFooter =>
      'Проверено на овој уред со S/MIME, компатибилно со Outlook и Thunderbird. Отповикувањето не се проверува (Поставки › Шифрирање од крај до крај).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Да му се верува на сертификациското тело $name за пошта?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Да му се верува на сертификатот на $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Секој сертификат што го издава ова тело ќе се смета за доверлив, како кај сертификациското тело на вашата фирма. Прво споредете го отпечатокот со сопственикот:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Прво споредете го отпечатокот со сопственикот:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Верувај';

  @override
  String get smimeSummaryNoKey => 'Шифрирана е за сертификат што не е на овој уред.';

  @override
  String get smimeSummaryDamaged => 'Шифрираните податоци се оштетени или изменети при преносот.';

  @override
  String get smimeSummaryUnsupported => 'Користи алгоритам што Loupe не го поддржува.';

  @override
  String get smimeSummaryLocked => 'Вашиот S/MIME сертификат е заклучен.';

  @override
  String get smimeSummaryEncrypted => 'Само вие и другите примачи можете да ја прочитате.';

  @override
  String get smimeSummaryNotSigned => 'Не е потпишана, па испраќачот не е потврден.';

  @override
  String get smimeSummaryModified => 'Потписот не се совпаѓа: пораката е изменета откако е потпишана.';

  @override
  String get smimeSummaryUncheckable => 'Потписот не може да се провери.';

  @override
  String get smimeSummaryNoCertificate =>
      'Сертификатот на потписникот не е во пораката, па потписот не може да се провери.';

  @override
  String get smimeSummaryRevoked =>
      'Сертификациското тело го отповика сертификатот на потписникот: на потписот не може да му се верува.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Сертификациското тело го отповика сертификатот на потписникот ($reason): на потписот не може да му се верува.';
  }

  @override
  String get smimeDateMismatch =>
      'Потпишана е повеќе од еден час пред или по датумот на пораката: можеби е стара порака испратена повторно.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Потписот е важечки и $issuer гарантира дека сертификатот му припаѓа на испраќачот.';
  }

  @override
  String get smimeProblemInvalidChain => 'Сертификатот или некој од неговите издавачи не е важечки.';

  @override
  String get smimeProblemUntrusted => 'Сертификатот потекнува од сертификациско тело на кое Loupe не му верува.';

  @override
  String get smimeProblemExpired => 'Сертификатот веќе беше истечен.';

  @override
  String get smimeProblemNotYetValid => 'Сертификатот сè уште не важеше.';

  @override
  String get smimeProblemWrongUsage => 'Сертификатот не е наменет за пошта.';

  @override
  String get smimeProblemWrongAddress => 'Сертификатот припаѓа на друга адреса, а не на адресата на испраќачот.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Доверлив · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Не е доверлив · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Истечен на $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Важи од $date';
  }

  @override
  String get smimeTrustInvalid => 'Неважечки';

  @override
  String get smimeTrustNotForMail => 'Не е за пошта';

  @override
  String get smimeTrustAnotherAddress => 'Друга адреса';

  @override
  String get smimeMyCertificates => 'Мои S/MIME сертификати';

  @override
  String get smimeMyCertificatesFooter =>
      'За S/MIME, како што го користат Outlook и многу фирми. Увезете го вашиот сертификат со приватниот клуч (датотека .p12 или .pfx), извезен од Outlook, Windows, macOS или Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'За S/MIME, како што го користат Outlook и многу фирми. Увезете го вашиот сертификат со приватниот клуч (датотека .p12 или .pfx), извезен од Outlook, Windows, macOS или Thunderbird, или користете сертификат што е инсталиран на овој уред од вас или од вашата фирма.';

  @override
  String get smimeCertificateExpired => 'истечен';

  @override
  String smimeCertificateUntil(String date) {
    return 'важи до $date';
  }

  @override
  String get smimeCertificateOnDevice => 'на овој уред';

  @override
  String get smimeImportCertificateEllipsis => 'Увези сертификат…';

  @override
  String get smimeUseDeviceCertificate => 'Користи сертификат од овој уред…';

  @override
  String get smimeCorrespondentsCertificates => 'Сертификати на контактите';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Собрани од потпишана пошта, како што прават Outlook и Thunderbird. Поштата се шифрира само за доверливи сертификати: Loupe им верува на сертификациските тела на кои Mozilla им верува за е-пошта, како и на оние што ќе ги додадете вие.';

  @override
  String get smimeRevocation => 'Отповикување';

  @override
  String get smimeRevocationFooter =>
      'Кога ќе отворите потпишана пошта, Loupe го прашува сертификациското тело што го издало сертификатот на потписникот дали тој е отповикан (преку неговиот OCSP-сервер или листата на отповикани сертификати). Телото потоа може да види кога некој од вашата интернет-адреса чита пошта потпишана со тој сертификат. Одговорите се чуваат на овој уред додека не истечат. Отповиканиот сертификат во заглавјето на пораката се прикажува како „сертификатот е отповикан“.';

  @override
  String get smimeCheckRevocation => 'Проверувај го отповикувањето на сертификатите преку интернет';

  @override
  String get smimeTrustedAuthorities => 'Доверливи сертификациски тела';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Доверливи по ваш избор, покрај $count тела на кои Mozilla им верува за е-пошта.',
      one: 'Доверливи по ваш избор, покрај $count тело на кое Mozilla му верува за е-пошта.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Сертификациско тело';

  @override
  String get smimeImportACertificate => 'Увоз на сертификат';

  @override
  String get smimeImportContactMessage => 'Сертификат на контакт (.cer, .crt, .pem) или на сертификациско тело.';

  @override
  String get smimeFromClipboard => 'Од привремената меморија';

  @override
  String get smimeFromFile => 'Од датотека';

  @override
  String get smimeClipboardEmpty => 'Привремената меморија е празна. Прво копирајте го сертификатот.';

  @override
  String get smimeCertificate => 'Сертификат';

  @override
  String get smimeOnDeviceFooter =>
      'Неговиот приватен клуч останува во складиштето за акредитиви на Android, каде што е инсталиран од вас или од вашата фирма: Loupe бара од Android да потпишува и да дешифрира со него. Потпишаната пошта се потпишува во моментот на испраќање.';

  @override
  String get smimeAddresses => 'Адреси';

  @override
  String get smimeUsage => 'Намена';

  @override
  String get smimeUsageNone => 'Ништо што го користи Loupe';

  @override
  String get smimeUsageSigning => 'Потпишување';

  @override
  String get smimeUsageEncryption => 'Шифрирање';

  @override
  String get smimeUsageCertificates => 'Издавање сертификати';

  @override
  String get smimeAlgorithm => 'Алгоритам';

  @override
  String get smimeSerialNumber => 'Сериски број';

  @override
  String get smimeFingerprintCopied => 'Отпечатокот е копиран.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 отпечаток';

  @override
  String get smimePrivateKey => 'Приватен клуч';

  @override
  String get smimeKeyOnDevice => 'На овој уред';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Во Loupe, со тајна фраза';

  @override
  String get smimeKeyInLoupe => 'Во Loupe';

  @override
  String get smimeSource => 'Извор';

  @override
  String get smimeSourceSignedMail => 'Потпишана пошта';

  @override
  String get smimeSourceImported => 'Увезен';

  @override
  String get smimeTrustHeader => 'Доверба';

  @override
  String get smimeTrustedRoot => 'Доверлив коренски сертификат';

  @override
  String get smimeIssuer => 'Издавач';

  @override
  String smimeTrustNamed(String name) {
    return 'Верувај му на издавачот „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Верувај му на ова сертификациско тело';

  @override
  String get smimeTrustThisCertificate => 'Верувај му на овој сертификат';

  @override
  String get smimeStopTrusting => 'Отстрани ја довербата';

  @override
  String get smimePassphrase => 'Тајна фраза';

  @override
  String get smimePassphraseFooter =>
      'Незадолжително. Со тајна фраза, приватниот клуч е дополнително шифриран на овој уред (Argon2id и AES-256), а Loupe ја бара за потпишување и дешифрирање; колку долго ја памети, одредува „Запомни ги тајните фрази“. Поштата што ја испраќате се потпишува при испраќањето; задачите во заднина не можат да го користат клучот.';

  @override
  String get smimeChangePassphrase => 'Промени ја тајната фраза…';

  @override
  String get smimeSetPassphraseEllipsis => 'Постави тајна фраза…';

  @override
  String get smimeRemovePassphrase => 'Отстрани ја тајната фраза';

  @override
  String get smimeShareCertificate => 'Сподели го сертификатот';

  @override
  String get smimeDeleteCertificate => 'Избриши го сертификатот';

  @override
  String get smimeRemoveCertificate => 'Отстрани го сертификатот';

  @override
  String get smimePassphraseChanged => 'Тајната фраза е променета.';

  @override
  String get smimePassphraseSet => 'Тајната фраза е поставена.';

  @override
  String get smimeRemovePassphraseTitle => 'Да се отстрани тајната фраза?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Приватниот клуч тогаш ќе го штити само складиштето за клучеви на телефонот, како кога нема тајна фраза: Loupe повеќе нема да ја бара, а задачите во заднина ќе можат да го користат.';

  @override
  String get smimePassphraseRemoved => 'Тајната фраза е отстранета.';

  @override
  String smimeTrustTitle(String name) {
    return 'Да му се верува на сертификатот $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Секој сертификат што го издава ќе се смета за доверлив за пошта. Прво споредете го отпечатокот со сопственикот:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Да се избрише вашиот сертификат $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Да се отстрани сертификатот на $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe престанува да го користи: поштата шифрирана за него повеќе не може да се чита во Loupe. Сертификатот останува на овој уред (Поставки › Безбедност › Шифрирање и акредитиви).';

  @override
  String get smimeDeleteOwnMessage =>
      'Неговиот приватен клуч се брише од овој уред: поштата шифрирана за него повеќе нема да може да се чита тука, освен ако повторно не го увезете.';

  @override
  String get smimeRemoveContactMessage => 'Ќе се врати со следната потпишана порака од тој контакт.';

  @override
  String get smimeAddressImportFooter =>
      'Увезете сертификат за оваа адреса за да потпишувате и шифрирате со S/MIME, како што прави Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Увези сертификат…';

  @override
  String get smimePreferFooter =>
      'Кога пораката може да ја заштитат двата стандарда, се користи претпочитаниот, освен ако само другиот има клуч или сертификат за секој примач.';

  @override
  String get smimePreferSmime => 'Претпочитај S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Наместо OpenPGP';

  @override
  String get smimeCertificatePassword => 'Лозинка на сертификатот';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Внесете ја лозинката со која е заштитена датотеката на сертификатот при извозот.';

  @override
  String get smimeImport => 'Увези';

  @override
  String get smimeWrongPassword => 'Лозинката не е точна. Обидете се повторно.';

  @override
  String get smimeNoCertificateFound => 'Не е пронајден сертификат.';

  @override
  String smimeCertificateOf(String name) {
    return 'сертификатот на $name';
  }

  @override
  String get smimeNothingNew => 'Нема ништо ново за увоз.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Увезено: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Увезени се $count доверливи сертификациски тела.',
      one: 'Увезено е $count доверливо сертификациско тело.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Увезено: $certificates и $count доверливи сертификациски тела.',
      one: 'Увезено: $certificates и $count доверливо сертификациско тело.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Оваа датотека нема приватен клуч. Извезете го сертификатот заедно со приватниот клуч.';

  @override
  String get smimeImportAsYoursTitle => 'Да се увезе како ваш сертификат?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Овој прилог содржи сертификат со приватен клуч: $names. Увезете го само ако самите сте го извезле, на пример од Outlook или Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Увези како мој сертификат';

  @override
  String smimeImportedOwn(String names) {
    return 'Вашиот сертификат $names е увезен.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Вашиот сертификат $name ($addresses) е додаден од овој уред.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Да му се верува на сертификациското тело „$name“ за пошта?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe не го познава ова сертификациско тело (можеби е интерно тело на некоја фирма). Ако му верувате, ќе може да се проверуваат сертификатите што ги издава. Прво споредете го неговиот отпечаток со вашиот ИТ-оддел:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Приложени се $count сертификати.',
      one: 'Приложен е $count сертификат.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Увези сертификат';

  @override
  String get smimeUnlockTitle => 'Отклучување на S/MIME сертификат';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Внесете ја тајната фраза за сертификатот на $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Тајната фраза не е точна. Обидете се повторно.';

  @override
  String get smimeUnlock => 'Отклучи';

  @override
  String get smimeEnterAPassphrase => 'Внесете тајна фраза.';

  @override
  String get smimePassphrasesDiffer => 'Тајните фрази не се совпаѓаат.';

  @override
  String get smimeSetPassphraseTitle => 'Поставување тајна фраза';

  @override
  String get smimeSetPassphraseText =>
      'Loupe ќе ја бара за потпишување и дешифрирање. Ако ја заборавите, повторно увезете го сертификатот од неговата датотека .p12.';

  @override
  String get smimePassphraseAgain => 'Повтори';

  @override
  String get smimeSetPassphraseButton => 'Постави';

  @override
  String get smimeLockedOpenAgain =>
      'Вашиот S/MIME сертификат е заклучен. Повторно отворете ја пораката за да го отклучите.';

  @override
  String get smimeDeviceHasNoCertificates => 'Овој уред не ги нуди своите сертификати.';

  @override
  String get smimeCantReadCertificate => 'Loupe не може да го прочита овој сертификат.';

  @override
  String get smimeCertificateNotForMail =>
      'Овој сертификат не е за пошта: нема адреса на е-пошта или не е наменет за потпишување или шифрирање.';

  @override
  String get smimeDeviceCertificateGone =>
      'Сертификатот повеќе не е на овој уред или Loupe повеќе не смее да го користи. Изберете го повторно во „Поставки › Шифрирање од крај до крај“.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Сертификатот на овој уред може да се користи само додека Loupe е отворен.';

  @override
  String get smimeDeviceKeyDamaged => 'Шифрираниот клуч е оштетен.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Сертификатот на овој уред не може да го направи ова: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'не е поддржано';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Грешка во сертификатот на овој уред: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Адресата на сертификациското тело не е веб-адреса.';

  @override
  String get smimeAuthorityTimeout => 'Сертификациското тело не одговори навреме.';

  @override
  String get smimeAuthorityUnreachable => 'Не може да се воспостави врска со сертификациското тело.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Сертификациското тело одговори со код $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Одговорот на сертификациското тело е преголем.';

  @override
  String get smimeRevocationNotChecked =>
      'Не е проверено: се проверуваат само сертификати издадени од сертификациски тела на кои Loupe им верува.';

  @override
  String get settingsLanguage => 'Јазик';

  @override
  String get settingsLanguageSystem => 'Како на телефонот';

  @override
  String get settingsLanguageFooter =>
      'Loupe го користи јазикот на телефонот кога го има, а англиски кога го нема. Јазикот што ќе го изберете тука важи само за Loupe, вклучително и за известувањата.';

  @override
  String get settingsAccountsHeader => 'Сметки';

  @override
  String get settingsAddAccount => 'Додај сметка';

  @override
  String get settingsMailHeader => 'Пошта';

  @override
  String get settingsSwipeActions => 'Дејства при лизгање';

  @override
  String get settingsSwipeLeft => 'Лизгање налево';

  @override
  String get settingsSwipeLeftFooter =>
      'Целосното лизгање го извршува ова дејство. Краткото лизгање секогаш ги открива знаменцето и „Повеќе“.';

  @override
  String get settingsSwipeRight => 'Лизгање надесно';

  @override
  String get settingsSwipeRightFooter => 'Целосното лизгање го извршува ова дејство.';

  @override
  String get settingsSwipeToggleRead => 'Означи како прочитано / непрочитано';

  @override
  String get settingsSwipeTrash => 'Премести во корпа';

  @override
  String get settingsSwipeMove => 'Премести порака';

  @override
  String get settingsSwipeSnooze => 'Одложи';

  @override
  String get settingsThreaded => 'Групирај по разговори';

  @override
  String get settingsUndoSendDelay => 'Време за поништување на испраќањето';

  @override
  String get settingsUndoSendDelayFooter =>
      'Испратените пораки чекаат толку долго, за да можете да го поништите испраќањето.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds секунди',
      one: '$seconds секунда',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Изглед';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSystem => 'Автоматска';

  @override
  String get settingsThemeLight => 'Светла';

  @override
  String get settingsThemeDark => 'Темна';

  @override
  String get settingsDensity => 'Листа на пораки';

  @override
  String get settingsDensityComfortable => 'Пространа';

  @override
  String get settingsDensityCompact => 'Компактна';

  @override
  String get settingsReadingHeader => 'Читање';

  @override
  String get settingsReadingFooter =>
      'Далечинските слики можат да им откријат на испраќачите кога и каде сте ја отвориле пораката.';

  @override
  String get settingsDefaultView => 'Стандарден приказ';

  @override
  String get settingsDefaultViewFooter => 'Приказот на секоја порака може да го промените со копчето Aa.';

  @override
  String get settingsViewReadable => 'Читливо';

  @override
  String get settingsViewReadableDetail => 'Уредно, читливо, ја следи темната тема';

  @override
  String get settingsViewOriginal => 'Оригинал';

  @override
  String get settingsViewOriginalDetail => 'Точно како што го осмислил испраќачот';

  @override
  String get settingsViewPlain => 'Обичен текст';

  @override
  String get settingsViewPlainDetail => 'Само зборовите';

  @override
  String get settingsPlainTextFont => 'Фонт за обичен текст';

  @override
  String get settingsFontSans => 'Без серифи';

  @override
  String get settingsFontMono => 'Со фиксна ширина';

  @override
  String get settingsFontMonoDetail => 'ASCII цртежите и табелите остануваат порамнети';

  @override
  String get settingsTechnicalLists => 'Технички листи';

  @override
  String get settingsLoadRemoteImages => 'Вчитај далечински слики';

  @override
  String get settingsOpenLinksDirectly => 'Отвори ги линковите директно';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Го заобиколува следењето на кликови кога одредиштето е познато';

  @override
  String get settingsSecurityHeader => 'Безбедност';

  @override
  String get settingsAppLock => 'Заклучување на апликацијата';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe бара отклучување при стартување и кога ќе се вратите по отсуство подолго од времето во „Заклучи по“.';

  @override
  String get settingsAppLockFooterOff =>
      'Заклучувањето на апликацијата бара отпечаток од прст, лице или заклучување на екранот пред да се прикаже поштата.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Заклучувањето на апликацијата е сè уште исклучено. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Поставете код';

  @override
  String get settingsScreenLockTextIos =>
      'Заклучувањето на апликацијата користи Face ID, Touch ID или вашиот код, а овој iPhone нема код. Поставете го во апликацијата Поставки, па вклучете го заклучувањето на апликацијата.';

  @override
  String get settingsScreenLockTitleAndroid => 'Поставете заклучување на екранот';

  @override
  String get settingsScreenLockTextAndroid =>
      'Заклучувањето на апликацијата го користи заклучувањето на екранот на телефонот, како и отпечатокот од прст или лицето додадени кон него, а овој телефон го нема. Поставете PIN, шема или лозинка во поставките на Android, па вклучете го заклучувањето на апликацијата.';

  @override
  String get settingsOpenSystemSettings => 'Отвори поставки';

  @override
  String get settingsOpenAndroidSettings => 'Отвори поставки на Android';

  @override
  String get settingsLockAfter => 'Заклучи по';

  @override
  String get settingsLockAfterFooter =>
      'Колку долго Loupe може да биде во заднина пред повторно да побара отклучување.';

  @override
  String get settingsNotifications => 'Известувања';

  @override
  String get settingsEncryption => 'Шифрирање од крај до крај';

  @override
  String get settingsAdvanced => 'Напредно';

  @override
  String get settingsDemoHeader => 'Демо';

  @override
  String get settingsDemoFooter =>
      'Демо поштата е измислено сандаче што постои само на овој телефон. Ништо не се испраќа никаде.';

  @override
  String get settingsDemoMode => 'Демо режим';

  @override
  String get settingsResetApp => 'Ресетирај ја апликацијата';

  @override
  String get settingsResetFooter => 'Ги брише сите поставки и враќа на екранот за добредојде.';

  @override
  String get settingsResetTitle => 'Да се ресетира Loupe?';

  @override
  String get settingsResetMessage =>
      'Се бришат сите поставки, Smart Mailboxes и неодамнешни пребарувања, а апликацијата се враќа на екранот за добредојде.';

  @override
  String get settingsAboutHeader => 'За апликацијата';

  @override
  String get settingsVersion => 'Верзија';

  @override
  String get settingsLicences => 'Лиценци';

  @override
  String get settingsPrivacy => 'Приватност';

  @override
  String get settingsPrivacyDetail =>
      'Loupe нема аналитика ниту следење. Вашата пошта оди само до вашите сервери за е-пошта.';

  @override
  String get settingsNotificationsOffIos => 'Известувањата за Loupe се исклучени во Поставки.';

  @override
  String get settingsNotificationsOffAndroid => 'Известувањата за Loupe се исклучени во поставките на Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system не му дозволува на Loupe да прикажува известувања. Дозволете ги во Поставки.';
  }

  @override
  String get settingsNewMailHeader => 'Нова пошта';

  @override
  String get settingsNewMailFooterDemo =>
      'Демо поштата не пристигнува во заднина. Испратете пробно известување за да видите како изгледа новата пошта.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe проверува за нова пошта во заднина кога iOS ќе дозволи, а кај апликациите што ретко ги отворате меѓу проверките може да поминат и часови. Добивате известувања за новите пораки во влезните сандачиња, како и за пораките од VIP контактите во која било папка.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe проверува за нова пошта приближно на секои 15 минути, кога Android дозволува. Добивате известувања за новите пораки во влезните сандачиња, како и за пораките од VIP контактите во која било папка.';

  @override
  String get settingsNoAccounts => 'Нема сметки';

  @override
  String get settingsVipOnly => 'Само VIP';

  @override
  String get settingsVipOnlyDetail => 'Само пораки од вашите VIP контакти';

  @override
  String get settingsHideContent => 'Скриј содржина';

  @override
  String get settingsHideContentFooterOn =>
      'Известувањата прикажуваат само „Нова порака“ и сметката, без испраќачот и темата.';

  @override
  String get settingsHideContentFooterOff =>
      '„Скриј содржина“ ги отстранува испраќачот, темата и прегледот од заклучениот екран и од известувањата.';

  @override
  String get settingsBackgroundAppRefresh => 'Освежување на апликациите во заднина';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Новата пошта пристигнува во заднина само додека „Освежување на апликациите во заднина“ е вклучено за Loupe во Поставки. iOS не може да одржува отворена врска со влезните сандачиња, па „Моментална испорака“ не е достапна.';

  @override
  String get settingsInstantDelivery => 'Моментална испорака';

  @override
  String get settingsInstantDeliveryFooter =>
      'Моменталната испорака (експериментално) одржува отворена врска со влезните сандачиња, па новата пошта пристигнува за неколку секунди. Прикажува ненаметливо известување „Следење на нова пошта“ и троши повеќе батерија.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android може да ја запре моменталната испорака за да заштеди батерија. За таа да работи без прекин, дозволете Loupe да ја користи батеријата без ограничувања.';

  @override
  String get settingsExperimental => 'Експериментално';

  @override
  String get settingsComingSoon => 'Наскоро';

  @override
  String get settingsAllowUnrestrictedBattery => 'Дозволи неограничено користење на батеријата';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push овозможува новата пошта веднаш да го разбуди Loupe, ако тоа го поддржува вашата услуга за е-пошта. Push-известувањата одат преку услугата за push на Google и не носат пошта, само „провери сега“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Овој телефон не може да прима push-известувања: за нив се потребни услугите на Google Play и мрежна врска. Loupe и понатаму проверува за нова пошта приближно на секои 15 минути.';

  @override
  String get settingsCopyPushToken => 'Копирај го push токенот';

  @override
  String get settingsPushTokenCopied => 'Push токенот е копиран';

  @override
  String get settingsSendTestNotification => 'Испрати пробно известување';

  @override
  String get settingsAppIconBadge => 'Број на иконата на апликацијата';

  @override
  String get settingsBadgeNote => 'Бројот се ажурира секогаш кога Loupe ќе провери пошта, и во заднина.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Почетниот екран на овој телефон не прикажува бројки на иконите на апликациите. Бројот се ажурира секогаш кога Loupe ќе провери пошта, и во заднина.';

  @override
  String get settingsTestNotificationBody => 'Известувањата за нова пошта изгледаат вака.';

  @override
  String get settingsAccountRemoved => 'Оваа сметка е отстранета.';

  @override
  String get settingsAccountHeader => 'Сметка';

  @override
  String get settingsAccountDescription => 'Опис';

  @override
  String get settingsAccountDescriptionHint => 'Работа, Лично…';

  @override
  String get settingsEmail => 'Е-пошта';

  @override
  String get settingsColour => 'Боја';

  @override
  String get settingsColourFooter => 'Ги означува пораките од оваа сметка во „Сите влезни сандачиња“.';

  @override
  String settingsColourNumber(int number) {
    return 'Боја $number';
  }

  @override
  String get settingsSendingHeader => 'Испраќање';

  @override
  String get settingsSendingFooter =>
      'Секој идентитет има свој потпис. Одговорите се испраќаат од адресата на која е испратена пораката.';

  @override
  String get settingsFoldersHeader => 'Папки';

  @override
  String get settingsFoldersFooter =>
      'Loupe ги прикажува и синхронизира папките на кои сте претплатени, како и Thunderbird. Влезно сандаче, Нацрти, Испратени, Несакана пошта, Корпа и Архива секогаш се прикажуваат.';

  @override
  String get settingsShowAllFolders => 'Прикажи ги сите папки';

  @override
  String get settingsIncoming => 'Влезна пошта';

  @override
  String get settingsOutgoing => 'Излезна пошта';

  @override
  String get settingsConnectionNotEncrypted => 'Без шифрирање';

  @override
  String get settingsSignIn => 'Најава';

  @override
  String get settingsSignInExpired => 'Истечена';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider повеќе не ја прифаќа најавата на Loupe за оваа сметка, па нејзината пошта не се синхронизира. Најавете се повторно за да го решите тоа.';
  }

  @override
  String get settingsSignInAgain => 'Најави се повторно';

  @override
  String get settingsSigningIn => 'Се најавува…';

  @override
  String get settingsRemoveAccount => 'Отстрани сметка';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Да се отстрани „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Поштата и поставките на сметката ќе бидат отстранети од овој телефон. На серверот ништо не се брише.';

  @override
  String get settingsManageFolders => 'Управување со папки';

  @override
  String get settingsNoFolders => 'Сè уште нема папки.';

  @override
  String get settingsManageFoldersFooter =>
      'Папките на кои сте претплатени се прикажуваат на екранот „Сандачиња“ и се синхронизираат во заднина. Другите апликации за пошта на истата сметка обично исто така ги почитуваат овие претплати.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Ги чува вашите Smart Mailboxes за другите уреди. Скриена на екранот „Сандачиња“.';

  @override
  String get settingsFolderAlwaysShown => 'Секогаш се прикажува';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Претплати се на папката $folder';
  }

  @override
  String get settingsIdentities => 'Идентитети';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Првиот идентитет е стандарден за новите пораки. Повлечете за да го промените редоследот.';

  @override
  String get settingsIdentitiesFooterSingle => 'Стандардниот идентитет за новите пораки.';

  @override
  String get settingsIdentitiesReplyFooter => 'Одговорот се испраќа од идентитетот на кој е испратена пораката.';

  @override
  String get settingsIdentityDefault => 'Стандарден';

  @override
  String settingsIdentityReorder(String email) {
    return 'Промени го редоследот: $email';
  }

  @override
  String get settingsAddIdentity => 'Додај идентитет';

  @override
  String get settingsNewIdentity => 'Нов идентитет';

  @override
  String get settingsIdentity => 'Идентитет';

  @override
  String get settingsIdentityNameHint => 'Вашето име';

  @override
  String get settingsReplyTo => 'Адреса за одговор';

  @override
  String get settingsSignature => 'Потпис';

  @override
  String get settingsSignatureFooter => 'Се додава под „-- “ во пораките од овој идентитет.';

  @override
  String get settingsNoSignature => 'Без потпис';

  @override
  String get settingsCopyToMyself => 'Копија за мене';

  @override
  String get settingsCopyToMyselfFooter => 'Се додава на секоја порака од овој идентитет.';

  @override
  String get settingsCc => 'Копија';

  @override
  String get settingsBcc => 'Скриена копија';

  @override
  String get settingsReplyPatterns => 'Користи за одговори на адреси';

  @override
  String get settingsReplyPatternsFooter =>
      'Одговорите на пораките испратени на овие адреси се испраќаат од овој идентитет. * значи што било: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Адреса или шаблон во кој * значи што било.';

  @override
  String get settingsAddReplyPattern => 'Додај адреса или шаблон';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Отстрани $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Неважечки шаблон';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ не е адреса ниту шаблон како *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Нема адреса';

  @override
  String get settingsIdentityNoAddressMessage => 'Внесете ја адресата на е-пошта од која се испраќа.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Неважечка адреса';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Адреса за одговор: „$address“ не е важечка адреса на е-пошта.',
      'cc': 'Копија: „$address“ не е важечка адреса на е-пошта.',
      'bcc': 'Скриена копија: „$address“ не е важечка адреса на е-пошта.',
      'other': '„$address“ не е важечка адреса на е-пошта.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Зачувај идентитет';

  @override
  String get settingsDiscardChanges => 'Отфрли ги измените';

  @override
  String get settingsDeleteIdentity => 'Избриши идентитет';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Да се избрише „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Веќе испратените пораки од него остануваат непроменети.';

  @override
  String get settingsLastIdentityFooter => 'Сметката мора да има барем еден идентитет.';

  @override
  String get rulesTitle => 'Правила';

  @override
  String get rulesNewRule => 'Ново правило';

  @override
  String get rulesLoadError => 'Правилата не можеа да се вчитаат.';

  @override
  String get rulesEmptyTitle => 'Нема правила';

  @override
  String get rulesEmptyText =>
      'Правилата наместо вас ја распоредуваат новата пошта по папки и ѝ додаваат ознаки и знаменца. Направете правило со копчето за пишување горе или од пребарување со „Направи правило“.';

  @override
  String get rulesListFooter =>
      'Правилата се извршуваат одгоре надолу врз новата пошта во влезното сандаче. Допрете и задржете правило за да го преместите.';

  @override
  String get rulesChangeError => 'Правилото не можеше да се промени';

  @override
  String get rulesConditionEveryMessage => 'Секоја порака';

  @override
  String rulesMoveRule(String rule) {
    return 'Помести го правилото $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Правилото $rule вклучено';
  }

  @override
  String get rulesServerRulesHeader => 'Правила на серверот';

  @override
  String get rulesServerRulesFooter =>
      'Правилата на серверот ги извршува серверот за е-пошта штом ќе пристигне поштата, дури и кога телефонот е исклучен. Се чуваат во Sieve скрипта со име „loupe“.';

  @override
  String get rulesStatusUnknown => 'Непознато';

  @override
  String get rulesStatusError => 'Барањето до серверот не успеа.';

  @override
  String get rulesStatusChecking => 'Се проверува…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Ги извршува скриптата „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Активната скрипта е „$script“. Допрете за да ги извршува и правилата на Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'На серверот нема активна скрипта. Кога ќе зачувате правило на серверот, се вклучува скриптата на Loupe.';

  @override
  String get rulesStatusUnavailable => 'Не е достапно';

  @override
  String get rulesStatusNoSieve => 'Серверот на оваа сметка не нуди Sieve (ManageSieve или JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Премести во $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Премести во папка';

  @override
  String rulesActionTag(String tag) {
    return 'Додај ознака $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Отстрани ја ознаката $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Задржи во влезното сандаче';

  @override
  String rulesActionForward(String address) {
    return 'Препрати до $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Препрати до $address, без копија';
  }

  @override
  String get rulesActionStop => 'Без понатамошни правила';

  @override
  String get rulesNoActions => 'Сè уште не прави ништо';

  @override
  String get rulesLocationDevice => 'Уред';

  @override
  String get rulesLocationServer => 'Сервер';

  @override
  String get rulesLocationThisDevice => 'Овој уред';

  @override
  String get rulesNewRuleTitle => 'Ново правило';

  @override
  String get rulesEditRuleTitle => 'Уреди правило';

  @override
  String get rulesDefaultNameEveryMessage => 'Секоја порака';

  @override
  String get rulesConditionHeader => 'Кога нова порака се совпаѓа со условот';

  @override
  String get rulesConditionFooter =>
      'Пишувајте како при пребарување: from:, to:, s: (тема), b: (содржина), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:фактура';

  @override
  String get rulesAccounts => 'Сметки';

  @override
  String get rulesAllAccounts => 'Сите сметки';

  @override
  String get rulesRemovedAccount => 'Отстранета сметка';

  @override
  String get rulesAccountsFooter => 'Правило за сите сметки важи и за сметките што ќе ги додадете подоцна.';

  @override
  String get rulesActionsHeader => 'Тогаш';

  @override
  String get rulesForwardingFooter =>
      'Препраќањето ја испраќа секоја порака што се совпаѓа со условот на друга адреса штом ќе пристигне, дури и кога телефонот е исклучен. Некои даватели на услуги ограничуваат колку пошта може да се препрати.';

  @override
  String get rulesForwardingHiddenFooter => 'Препраќањето работи само во правилата на серверот, па тука го нема.';

  @override
  String rulesRemoveAction(String action) {
    return 'Отстрани: $action';
  }

  @override
  String get rulesAddAction => 'Додај дејство';

  @override
  String get rulesAddMove => 'Премести во папка…';

  @override
  String get rulesAddTagMenu => 'Додај ознака…';

  @override
  String get rulesRemoveTagMenu => 'Отстрани ознака…';

  @override
  String get rulesAddForward => 'Препрати до…';

  @override
  String get rulesStopProcessing => 'Не извршувај ги следните правила';

  @override
  String get rulesRunOnHeader => 'Каде се извршува';

  @override
  String get rulesRunOnDeviceFooter =>
      'Овој уред го извршува правилото врз новата пошта во влезното сандаче секојпат кога Loupe ќе провери за пошта.';

  @override
  String get rulesRunOnServerFooter =>
      'Серверот за е-пошта го извршува правилото штом ќе пристигне поштата, дури и кога телефонот е исклучен. Потребен е Sieve, преку ManageSieve (Dovecot, mailcow) или JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Примени на постоечките пораки…';

  @override
  String get rulesDeleteRule => 'Избриши правило';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Да се избрише правилото „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Папка во која сметка?';

  @override
  String get rulesMoveAccountMessage => 'Поштата од другите сметки оди во папката со исто име во нив.';

  @override
  String get rulesAddTag => 'Додај ознака';

  @override
  String get rulesRemoveTag => 'Отстрани ознака';

  @override
  String get rulesForwardTo => 'Препрати до';

  @override
  String get rulesForwardToMessage =>
      'Серверот ја препраќа секоја порака што се совпаѓа со условот на оваа адреса, дури и кога телефонот е исклучен. Внесете адреса што е ваша или на која ѝ верувате.';

  @override
  String get rulesNotAnAddressTitle => 'Не е адреса на е-пошта';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ не е адреса на која може да се препраќа.';
  }

  @override
  String get rulesKeepCopyTitle => 'Да се задржи копија тука?';

  @override
  String get rulesKeepCopy => 'Задржи копија';

  @override
  String get rulesDontKeepCopy => 'Без копија';

  @override
  String get rulesCheckCondition => 'Проверете го условот';

  @override
  String get rulesChooseActionTitle => 'Изберете дејство';

  @override
  String get rulesChooseActionMessage => 'Додајте што прави правилото со пораките што се совпаѓаат со условот.';

  @override
  String get rulesSaveError => 'Правилото не можеше да се зачува';

  @override
  String get rulesSaveServerError => 'Правилото на серверот не можеше да се зачува';

  @override
  String get rulesRunOnDeviceInstead => 'Префрли на овој уред';

  @override
  String get rulesNothingToApplyTitle => 'Нема што да се примени';

  @override
  String get rulesNothingToApplyMessage => 'Прво дајте му на правилото исправен услов и дејство.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Каде да се примени „$rule“?';
  }

  @override
  String get rulesApplyScopeInboxes => 'Влезни сандачиња';

  @override
  String get rulesApplyScopeAll => 'Сите сандачиња';

  @override
  String get rulesFindingMessages => 'Се бараат пораки…';

  @override
  String get rulesSearchError => 'Пребарувањето не успеа';

  @override
  String get rulesSearchErrorUnknown => 'Нешто тргна наопаку.';

  @override
  String get rulesNoMatchesTitle => 'Нема пораки што се совпаѓаат';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Таму ниедна порака не се совпаѓа со „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Да се примени „$rule“ на $countString пораки?',
      one: 'Да се примени „$rule“ на $countString порака?',
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
      other: 'Примени на $countString пораки',
      one: 'Примени на $countString порака',
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
      other: 'Правилото „$rule“ е применето на $countString пораки',
      one: 'Правилото „$rule“ е применето на $countString порака',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Се проверува што може серверот…';

  @override
  String get rulesServerUnreachable => 'Поврзувањето со серверот не успеа.';

  @override
  String rulesServerProblem(String problem) {
    return 'Не може да се извршува на серверот: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Не може да се извршува на серверот на сметката $account: $problem';
  }

  @override
  String get rulesShowScript => 'Прикажи ја скриптата';

  @override
  String get rulesHideScript => 'Скриј ја скриптата';

  @override
  String get rulesMatchingHeader => 'Пораки што се совпаѓаат';

  @override
  String get rulesMatchingHeaderLoading => 'Пораки што се совпаѓаат…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString пораки се совпаѓаат',
      one: '$countString порака се совпаѓа',
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
      other: '$countString+ пораки се совпаѓаат',
      one: '$countString+ порака се совпаѓа',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Од последните 30 дена. Самото правило важи само за новата пошта, освен ако не го примените и на постоечките пораки.';

  @override
  String rulesConditionError(String error) {
    return 'Условот има грешка: $error';
  }

  @override
  String get rulesPreviewNoSender => '(без испраќач)';

  @override
  String get rulesPreviewNoSubject => '(без тема)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'и уште $countString',
      one: 'и уште $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ништо од последните 30 дена.';

  @override
  String get rulesIncludeTitle => 'Вклучување на правилата на серверот';

  @override
  String get rulesIncludeLeaveOff => 'Не вклучувај';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Серверот веќе ги извршува правилата на Loupe за сметката $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return 'На серверот на сметката $account активна е скриптата „$script“, па серверот ја извршува неа, а не правилата на Loupe. Loupe нема да ја замени. Може да ѝ ги додаде овие редови, а серверот потоа ќе ги извршува правилата на Loupe по сопствените правила на скриптата:';
  }

  @override
  String get rulesShowWholeScript => 'Прикажи ја целата скрипта';

  @override
  String get rulesHideWholeScript => 'Скриј ја целата скрипта';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ништо друго во „$script“ не се менува. Ако нејзините филтри подоцна се изменат во веб-поштата, таа може да ја препише без овие редови; Loupe тогаш повторно ќе ги прикаже правилата на серверот како исклучени.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Додај во „$script“';
  }

  @override
  String get subscriptionsTitle => 'Претплати';

  @override
  String get subscriptionsNewsletters => 'Билтени';

  @override
  String get subscriptionsDiscussions => 'Дискусии';

  @override
  String get subscriptionsFilter => 'Филтер';

  @override
  String get subscriptionsFilterNeverRead => 'Никогаш читани';

  @override
  String get subscriptionsFilterRarelyRead => 'Ретко читани';

  @override
  String get subscriptionsFilterAll => 'Сите';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Претплатите не можеа да се пребројат';

  @override
  String get subscriptionsNoMatches => 'Нема резултати';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ниеден билтен не се вика „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ниедна листа не се вика „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Нема билтени';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Билтените и другата масовна пошта се појавуваат тука штом ќе пристигнат.';

  @override
  String get subscriptionsNothingNeverRead => 'Нема билтени што никогаш не ги читате';

  @override
  String get subscriptionsNothingRarelyRead => 'Нема билтени што ретко ги читате';

  @override
  String get subscriptionsNothingFilteredDetail => 'Од сè што добивате, понешто и читате.';

  @override
  String get subscriptionsNoDiscussions => 'Нема дискусии';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Мејлинг-листите на кои можете да пишувате се појавуваат тука штом ќе пристигне нивната пошта.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Листи на кои пишуваат повеќе луѓе. Допрете и задржете листа за да ја закачите во Сандачиња, да ја читате како обичен текст или да ја преместите во Билтени.';

  @override
  String get subscriptionsPrivacyNote =>
      'Пресметано на овој телефон од преземената пошта; ништо не се испраќа никаде за ова да се пресмета. Loupe го контактира испраќачот само кога ќе допрете „Откажи претплата“: откажувањето со еден допир испраќа само „List-Unsubscribe=One-Click“ на адресата што ја наведува испраќачот, без колачиња и без ништо друго за вас, и никогаш не ги вчитува неговите страници или слики.';

  @override
  String get subscriptionsVolumeNone => 'Ништо во последно време';

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
    return 'прочитано $percent';
  }

  @override
  String get subscriptionsStillSending => 'Сè уште испраќа';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Претплатата е откажана на $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Страницата за откажување е отворена на $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Со еден допир · го контактира $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Со е-пошта до $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'На веб-страницата $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Откажи претплата';

  @override
  String get subscriptionsUnsubscribeAgain => 'Повторно откажи претплата';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Архивирај $countString од влезното сандаче',
      one: 'Архивирај $countString од влезното сандаче',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Направи правило…';

  @override
  String get subscriptionsCreateRuleDetail => 'Премести ја или архивирај ја идната пошта';

  @override
  String get subscriptionsTreatAsDiscussion => 'Третирај како дискусија';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Листа на која пишуваат луѓе: читајте ја како форум';

  @override
  String get subscriptionsTreatAsNewsletter => 'Третирај како билтен';

  @override
  String get subscriptionsBlockSender => 'Блокирај го испраќачот';

  @override
  String get subscriptionsBlock => 'Блокирај';

  @override
  String get subscriptionsBlocked => 'Блокирано';

  @override
  String get subscriptionsBlockedDetail => 'Новите пораки одат во несакана пошта';

  @override
  String get subscriptionsPin => 'Закачи во Сандачиња';

  @override
  String get subscriptionsUnpin => 'Откачи од Сандачиња';

  @override
  String get subscriptionsOpenDefaultView => 'Отвори во стандардниот приказ';

  @override
  String get subscriptionsOpenPlainText => 'Отвори како обичен текст (моно)';

  @override
  String get subscriptionsPinned => 'Закачено';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString непрочитани',
      one: '$countString непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Моментално нема пошта од овој испраќач.';

  @override
  String get subscriptionsLatestMessages => 'НАЈНОВИ ПОРАКИ';

  @override
  String get subscriptionsMail => 'Пошта';

  @override
  String get subscriptionsNoneIn90Days => 'Ништо во последните 90 дена';

  @override
  String get subscriptionsRead => 'Прочитано';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString од $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Последна порака';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count папки', one: '$count папка');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Сè уште испраќа';

  @override
  String get subscriptionsUnsubscribedTitle => 'Претплатата е откажана';

  @override
  String subscriptionsSince(String date) {
    return 'од $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'страницата е отворена на $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender не наведува како да се откажете.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender не наведува како да се откажете. Наместо тоа, можете да го блокирате.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Се откажува претплатата за $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Претплатата за $sender е откажана.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Откажувањето не успеа: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Автоматското откажување не успеа';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Испрати порака за откажување';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Отвори $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Да се отвори $site?';
  }

  @override
  String get subscriptionsOpen => 'Отвори';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender нуди откажување на својата веб-страница. Страницата се отвора во прелистувачот на Loupe; таму довршете го откажувањето.';
  }

  @override
  String get subscriptionsWebInsecure => 'Врската со оваа страница не е шифрирана.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Внимание: оваа адреса го имитира $site со букви што изгледаат слично.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Внимание: оваа адреса имитира друга страница со букви што изгледаат слично.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site не може да се отвори.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe го бележи денешниот датум и ќе ве извести ако $sender продолжи да испраќа пошта.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Да се откажете од $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe ќе го контактира $site за да ја откаже претплатата.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Ова е единствениот случај кога Loupe ја контактира веб-страницата на испраќачот. Испраќа само „List-Unsubscribe=One-Click“ на адресата што ја наведува $sender, без колачиња и без ништо друго за вас, и не ја вчитува страницата.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Линкот за откажување не е безбедна адреса на интернет.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site не одговори навреме.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Не може да се пристапи до $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site го препрати барањето на друга страница, а Loupe не ги следи пренасочувањата.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site го одби барањето (грешка $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Нема сметка од која би се испратила пораката за откажување.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe ќе испрати порака до $to од $from, со тема „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Пораката за откажување е испратена до $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Да се блокира $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Новите пораки од оваа листа ќе одат во несакана пошта. Ова може да го промените во „Поставки › Правила“.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Новите пораки од $address ќе одат во несакана пошта. Ова може да го промените во „Поставки › Правила“.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Испраќачот $sender е блокиран.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премести $count во несакана пошта',
      one: 'Премести $count во несакана пошта',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Блокирај $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender сега е во Билтени.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender сега е во Дискусии.';
  }

  @override
  String get appLiveGateTitle => 'Вашите сметки не може да се отворат';

  @override
  String get appLiveGateUnavailableBuild => 'Вистинските сметки сè уште не се достапни во оваа верзија.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe не можеше да го прочита клучот што ја штити вашата пошта на овој телефон. Ова често е привремено: обидете се повторно или рестартирајте го телефонот.';

  @override
  String get appLiveGateKeyMissing =>
      'Клучот што ја штити вашата пошта на овој телефон исчезна, што може да се случи по враќање на резервна копија. Вашата пошта е сè уште на серверот.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Базата на пошта на овој телефон не може да се прочита: оштетена е или нејзиниот клуч е променет. Вашата пошта е сè уште на серверот.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Настана грешка при отворањето на вашите сметки ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Со ова се бришат вашите сметки и поштата зачувана на овој телефон, вклучително и пораките што чекаат во излезното сандаче. Поштата на вашите сервери не е засегната; потоа повторно додајте ги сметките.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Избриши и почни одново';

  @override
  String get appLiveGateUseDemo => 'Користи демо пошта';

  @override
  String get appLiveGateReset => 'Ресетирај ја поштата на овој телефон…';

  @override
  String get attachmentsUntitled => 'Прилог';

  @override
  String get attachmentsUntitledFile => 'Без име';

  @override
  String get attachmentsOpenIn => 'Отвори во…';

  @override
  String get attachmentsSaveToFiles => 'Зачувај во датотеки';

  @override
  String get attachmentsShareMenu => 'Сподели…';

  @override
  String get attachmentsDownloadError => 'Прилогот не може да се преземе. Проверете ја врската и обидете се повторно.';

  @override
  String get attachmentsShareError => 'Прилогот не може да се сподели.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ниедна апликација на овој уред не ја отвора оваа датотека ($type). Обидете се со „Сподели“.';
  }

  @override
  String get attachmentsOpenInError => 'Прилогот не може да се отвори во друга апликација.';

  @override
  String attachmentsSaved(String name) {
    return 'Зачувано: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Прилогот не може да се зачува.';

  @override
  String get attachmentsGone => 'Овој прилог повеќе не е достапен.';

  @override
  String get attachmentsDownloadFailed => 'Прилогот не може да се преземе.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count страници', one: '$count страница');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size преку мобилен интернет';
  }

  @override
  String get attachmentsLargeDownload => 'Овој прилог е голем. Преземете го сега или подоцна преку Wi-Fi.';

  @override
  String get attachmentsDownload => 'Преземи';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Се презема $size…';
  }

  @override
  String get attachmentsDownloading => 'Се презема…';

  @override
  String get attachmentsTooLarge => 'Премногу голем за преглед тука.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Се прикажуваат првите $shown од $total. Копирајте, споделете или зачувајте за да добиете сè.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Овој PDF не може да се прикаже тука (можеби е заштитен со лозинка).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page од $count';
  }

  @override
  String get attachmentsModeTable => 'Табела';

  @override
  String get attachmentsModeText => 'Текст';

  @override
  String get attachmentsModeMessage => 'Порака';

  @override
  String get attachmentsModeSource => 'Извор';

  @override
  String get attachmentsDontWrap => 'Не прекршувај ги редовите';

  @override
  String get attachmentsWrap => 'Прекршувај ги редовите';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines редови', one: '$count ред');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Копирај сè';

  @override
  String get attachmentsCopied => 'Копирано';

  @override
  String get attachmentsImageUnavailable => 'Оваа слика не може да се прикаже тука. Обидете се со „Отвори во…“.';

  @override
  String get attachmentsEmlNoSubject => '(Без тема)';

  @override
  String get attachmentsEmlFrom => 'Од';

  @override
  String get attachmentsEmlTo => 'До';

  @override
  String get attachmentsEmlCc => 'Копија';

  @override
  String get attachmentsEmlDate => 'Датум';

  @override
  String get attachmentsEmlNoText => 'Оваа порака нема текст.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count прилози: $names',
      one: '$count прилог: $names',
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
      other: 'И уште $count настани',
      one: 'И уште $count настан',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Слика';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Слика $format';
  }

  @override
  String get attachmentsTypePdf => 'PDF-документ';

  @override
  String get attachmentsTypeTsv => 'Вредности одделени со табулатор';

  @override
  String get attachmentsTypeCsv => 'CSV-табела';

  @override
  String get attachmentsTypeCalendar => 'Настан во календар';

  @override
  String get attachmentsTypeEmail => 'Порака од е-пошта';

  @override
  String get attachmentsTypeContact => 'Картичка за контакт';

  @override
  String get attachmentsTypeLog => 'Датотека со дневник';

  @override
  String get attachmentsTypeText => 'Текст';

  @override
  String get attachmentsTypeZip => 'ZIP-архива';

  @override
  String get attachmentsTypeArchive => 'Архива';

  @override
  String get attachmentsTypeWord => 'Word-документ';

  @override
  String get attachmentsTypeExcel => 'Excel-табела';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint-презентација';

  @override
  String get attachmentsTypeWebPage => 'Веб-страница';

  @override
  String get attachmentsTypeVideo => 'Видео';

  @override
  String get attachmentsTypeAudio => 'Аудио';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Датотека $extension';
  }

  @override
  String get attachmentsTypeFile => 'Датотека';

  @override
  String get calendarUntitledEvent => 'Настан';

  @override
  String get calendarAllDay => 'Цел ден';

  @override
  String calendarYourTime(String time) {
    return '$time според вашето време';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Врска за состанокот: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ја прифати поканата: $details',
      'tentative': '$name условно ја прифати поканата: $details',
      'declined': '$name ја одби поканата: $details',
      'delegated': '$name ја делегира поканата: $details',
      'other': '$name не одговори на поканата: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ја прифати поканата',
      'tentative': '$name условно ја прифати поканата',
      'declined': '$name ја одби поканата',
      'delegated': '$name ја делегира поканата',
      'other': '$name не одговори на поканата',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Мапа';

  @override
  String get calendarJoin => 'Приклучи се';

  @override
  String get calendarOnlineMeeting => 'Онлајн состанок';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Состанок на $provider';
  }

  @override
  String get calendarOrganizerYou => 'Вие';

  @override
  String get calendarOrganizerLabel => 'организатор';

  @override
  String get calendarStatusAccepted => 'Прифатено';

  @override
  String get calendarStatusMaybe => 'Можеби';

  @override
  String get calendarStatusDeclined => 'Одбиено';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ја прифати поканата',
      'tentative': '$name условно ја прифати поканата',
      'declined': '$name ја одби поканата',
      'delegated': '$name ја делегира поканата',
      'other': '$name не одговори на поканата',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name ја прифати поканата:',
      'tentative': '$name условно ја прифати поканата:',
      'declined': '$name ја одби поканата:',
      'delegated': '$name ја делегира поканата:',
      'other': '$name не одговори на поканата:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name предлага нов термин';
  }

  @override
  String get calendarCounterUnknown => 'Учесник предлага нов термин';

  @override
  String get calendarDeclineCounter => 'Организаторот го задржа терминот';

  @override
  String calendarRefresh(String name) {
    return '$name ја бара најновата верзија на настанот';
  }

  @override
  String get calendarRefreshUnknown => 'Учесник ја бара најновата верзија на настанот';

  @override
  String get calendarCancelled => 'Откажано';

  @override
  String get calendarCancelledByOrganizer => 'Организаторот го откажа овој настан.';

  @override
  String get calendarCancelledLater => 'Овој настан е откажан подоцна.';

  @override
  String get calendarOutdated => 'Застарено';

  @override
  String get calendarOutdatedDetail => 'Оваа покана е ажурирана подоцна; важи поновата верзија.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Локацијата е отстранета (беше: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Локацијата е отстранета (претходно немаше)';

  @override
  String calendarLocationChanged(String location) {
    return 'Нова локација: $location';
  }

  @override
  String get calendarNewTitle => 'Нов наслов';

  @override
  String get calendarRepeatChanged => 'Повторувањето е променето';

  @override
  String get calendarUpdated => 'Ажурирано';

  @override
  String get calendarUpdatedInvitation => 'Ажурирана покана';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Времето е променето од $before на $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Непозната временска зона „$zone“: времињата се прикажани како што се напишани';
  }

  @override
  String calendarNext(String when) {
    return 'Следно: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count гости', one: '$count гостин');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count прифатија', one: '$count прифати');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count можеби', one: '$count можеби');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count одбија', one: '$count одби');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (вие)';
  }

  @override
  String get calendarAttendeeOptional => 'незадолжително';

  @override
  String get calendarAttendeeRoom => 'просторија';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ја прифативте претходната верзија.',
      'tentative': 'Условно ја прифативте претходната верзија.',
      'declined': 'Ја одбивте претходната верзија.',
      'delegated': 'Ја делегиравте претходната верзија.',
      'other': 'Не одговоривте на претходната верзија.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Прифати';

  @override
  String get calendarMaybe => 'Можеби';

  @override
  String get calendarDecline => 'Одбиј';

  @override
  String get calendarCommentHint => 'Коментар за организаторот (незадолжително)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Вашиот одговор оди до $organizer од адресата $address.';
  }

  @override
  String get calendarAddComment => 'Додај коментар';

  @override
  String get calendarAddToCalendar => 'Додај во календар';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'И уште $count настани во датотеката',
      one: 'И уште $count настан во датотеката',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Нема апликација за календар во која може да се додаде настанот.';

  @override
  String get calendarCantOpenCalendar => 'Календарот не можеше да се отвори.';

  @override
  String get calendarCantOpenLink => 'Врската не можеше да се отвори.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Да се приклучите на состанокот на $provider?';
  }

  @override
  String get calendarJoinTitle => 'Да се приклучите на состанокот?';

  @override
  String calendarJoinOpens(String host) {
    return 'Се отвора $host во вашиот прелистувач.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Внимание: оваа адреса го имитира $site со букви што изгледаат слично.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Внимание: оваа адреса имитира друга страница со букви што изгледаат слично.';

  @override
  String calendarJoinOpen(String host) {
    return 'Отвори $host';
  }

  @override
  String get calendarNoOrganizer => 'Оваа покана нема организатор на кој би можеле да му одговорите.';

  @override
  String get calendarNoAccount => 'Нема сметка од која би се испратил одговорот.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Прифатено', 'tentative': 'Можеби', 'other': 'Одбиено'});
    return '$_temp0 · се испраќа одговор до $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Прифатено', 'tentative': 'Можеби', 'other': 'Одбиено'});
    return '$_temp0 · одговорот е испратен';
  }

  @override
  String get calendarReplyAlreadySent => 'Одговорот е веќе испратен.';

  @override
  String get calendarReplyNotSent => 'Одговорот не е испратен.';

  @override
  String get dataSmimeNeedsDevice =>
      'Вашиот S/MIME-сертификат е на овој уред: отворете го Loupe за да ја потпишете и испратите оваа порака.';

  @override
  String dataSigningFailed(String error) {
    return 'Потпишувањето не успеа: $error';
  }

  @override
  String get keyboardShortcuts => 'Кратенки на тастатурата';

  @override
  String get keyboardGroupGeneral => 'Општо';

  @override
  String get keyboardGroupMessages => 'Пораки';

  @override
  String get keyboardGroupCompose => 'Пишување';

  @override
  String get keyboardCommandPalette => 'Палета со команди';

  @override
  String get keyboardBackClose => 'Назад, затвори';

  @override
  String get keyboardNextMessage => 'Следна порака';

  @override
  String get keyboardPreviousMessage => 'Претходна порака';

  @override
  String get keyboardOpenMessage => 'Отвори порака';

  @override
  String get keyboardMoveToTrash => 'Премести во корпа';

  @override
  String get keyboardToggleRead => 'Означи како прочитано или непрочитано';

  @override
  String get keyboardToggleFlag => 'Додај или отстрани знаменце';

  @override
  String get keyboardCloseDraft => 'Затвори (зачувај или избриши нацрт)';

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
  String get mailingListsMuted => 'Нишката е стишена. Новите пораки во неа пристигнуваат како прочитани.';

  @override
  String get mailingListsUnmuted => 'Стишувањето на нишката е откажано.';

  @override
  String get mailingListsMuteThread => 'Стиши ја нишката';

  @override
  String get mailingListsUnmuteThread => 'Откажи го стишувањето';

  @override
  String get mailingListsPin => 'Закачи во Сандачиња';

  @override
  String get mailingListsUnpin => 'Откачи од Сандачиња';

  @override
  String get mailingListsDefaultView => 'Отвори во стандардниот приказ';

  @override
  String get mailingListsPlainText => 'Отвори како обичен текст (моно)';

  @override
  String get mailingListsShowMuted => 'Прикажи ги стишените нишки';

  @override
  String get mailingListsHideMuted => 'Скриј ги стишените нишки';

  @override
  String get mailingListsTreatAsNewsletter => 'Третирај како билтен';

  @override
  String get mailingListsOptions => 'Опции за листата';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted непрочитани',
      one: '$count непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Нова порака до листата';

  @override
  String get mailingListsRowUnread => 'Непрочитано';

  @override
  String get mailingListsRowMuted => 'Стишено';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count одговори', one: '$count одговор');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Нема нишки';

  @override
  String get mailingListsMutedHidden => 'Стишените нишки се скриени.';

  @override
  String get mailingListsTechnicalTitle => 'Технички листи';

  @override
  String get mailingListsTechnicalEmpty => 'Мејлинг-листите се појавуваат тука штом ќе пристигне нивната пошта.';

  @override
  String get mailingListsTechnicalFooter =>
      'Пораките од овие листи се отвораат како обичен текст со фонт со фиксна ширина, а закрпите се прикажуваат како разлики (diff). Со копчето Aa сè уште може да го промените приказот на секоја порака.';

  @override
  String get paletteMoveToMailbox => 'Премести во сандаче…';

  @override
  String get paletteMarkAllRead => 'Означи ги сите како прочитани';

  @override
  String get paletteExportFolder => 'Извези ја папката…';

  @override
  String get paletteGetNewMail => 'Преземи нова пошта';

  @override
  String get paletteSnoozed => 'Одложени';

  @override
  String get paletteSubscriptions => 'Претплати';

  @override
  String get paletteDiscussions => 'Дискусии';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Мејлинг-листа';

  @override
  String get paletteTag => 'Ознака';

  @override
  String get paletteSwipeActions => 'Дејства при лизгање';

  @override
  String get paletteNotifications => 'Известувања';

  @override
  String get paletteRules => 'Правила';

  @override
  String get paletteEncryption => 'Шифрирање од крај до крај';

  @override
  String get paletteAdvanced => 'Напредно';

  @override
  String get paletteAddAccount => 'Додај сметка';

  @override
  String get paletteAccount => 'Сметка';

  @override
  String get paletteFolders => 'Папки';

  @override
  String get paletteRecentSearch => 'Неодамнешно пребарување';

  @override
  String paletteSearchMail(String query) {
    return 'Пребарај „$query“ во поштата';
  }

  @override
  String get palettePlaceholder => 'Пребарајте дејства, сандачиња, поставки';

  @override
  String get paletteNothingFound => 'Ништо не е пронајдено';

  @override
  String get searchNewSmartMailbox => 'Нов Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Прикажува сè што се совпаѓа со „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ е зачувано во Сандачиња';
  }

  @override
  String get searchMakeRule => 'Направи правило';

  @override
  String get searchSaveSmartMailbox => 'Зачувај како Smart Mailbox';

  @override
  String get searchNegate => 'Негирај';

  @override
  String get searchDontNegate => 'Отстрани ја негацијата';

  @override
  String get searchAllMailboxes => 'Сите сандачиња';

  @override
  String get searchRecent => 'Неодамнешни пребарувања';

  @override
  String get searchClear => 'Исчисти';

  @override
  String get searchSuggestions => 'Предлози';

  @override
  String get searchUnreadMessages => 'Непрочитани пораки';

  @override
  String get searchFlaggedMessages => 'Пораки со знаменце';

  @override
  String get searchWithAttachments => 'Пораки со прилози';

  @override
  String get searchUnrepliedMessages => 'Пораки без одговор';

  @override
  String get searchTags => 'Ознаки';

  @override
  String get searchPeople => 'Луѓе';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Од: $name';
  }

  @override
  String get searchSearching => 'Се пребарува…';

  @override
  String get searchNoResults => 'Нема резултати';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted резултати',
      one: '$count резултат',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Мени за пребарување';

  @override
  String searchSearchingAccount(String account) {
    return 'Се пребарува сметката $account на серверот…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Се пребарува сметката на серверот…';

  @override
  String searchAccountFailed(String account) {
    return 'Сметката $account не можеше да се пребара на серверот';
  }

  @override
  String get searchUnknownAccountFailed => 'Сметката не можеше да се пребара на серверот';

  @override
  String searchChip(String term) {
    return '$term. Допрете двапати за уредување.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Негирано: $term. Допрете двапати за уредување.';
  }

  @override
  String get searchReadAndUnread =>
      'Шредингеровото влезно сандаче: секоја порака тука е и прочитана и непрочитана сè додека не ја отворите.';

  @override
  String searchContradiction(String term) {
    return 'Ниедна порака не може истовремено да биде и да не биде „$term“.';
  }

  @override
  String get searchSyncDeviceOnly => 'Само на овој уред';

  @override
  String searchSyncUnsupported(String account) {
    return 'Само на овој уред: сметката $account не може да го чува';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Не е синхронизирано: сметката $account има понов формат';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Чека синхронизација со сметката $account';
  }

  @override
  String searchSynced(String account) {
    return 'Синхронизирано со сметката $account';
  }

  @override
  String get searchRename => 'Преименувај';

  @override
  String get searchEditSearch => 'Уреди го пребарувањето';

  @override
  String get searchDeleteSmartMailbox => 'Избриши го Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Преименувај го Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Овој Smart Mailbox е избришан.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes остануваат на овој уред.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes се чуваат на вашиот сервер за е-пошта, па ги имаат и вашите други уреди, како и Thunderbird со додатокот Expression Search Reloaded. Оние што пребаруваат низ сите сметки се чуваат на сметката $account, а оние за една папка – на сметката на таа папка.';
  }

  @override
  String get searchSyncVia => 'Синхронизирај преку';

  @override
  String get searchSyncViaFooter => 'Изберете ја истата сметка на секој уред.';

  @override
  String get searchGmailCantKeep => 'Gmail не може да чува Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Чувај ги Smart Mailboxes само на овој уред';

  @override
  String get searchOnTheServer => 'На серверот';

  @override
  String get searchServerFooter =>
      'Метаподатоците на серверот (IMAP METADATA) не се прикажуваат во ниту една апликација за пошта. На серверите без нив се создава папка „Loupe Settings“ со една порака; Loupe не ја прикажува на екранот „Сандачиња“.';

  @override
  String get searchSyncNow => 'Синхронизирај сега';

  @override
  String get searchStateUnsupported => 'Не е поддржано';

  @override
  String get searchStateNewerFormat => 'Понов формат';

  @override
  String get searchStateFailed => 'Синхронизацијата не успеа';

  @override
  String get searchStateSyncing => 'Се синхронизира…';

  @override
  String get searchStateWaiting => 'Во исчекување';

  @override
  String get searchStateMetadata => 'Метаподатоци на серверот';

  @override
  String get searchStateFolder => 'Папка „Loupe Settings“';

  @override
  String get searchStateNothing => 'Ништо не е зачувано';

  @override
  String get sharedBack => 'Назад';

  @override
  String get sharedYesterday => 'Вчера';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date во $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count бајти', one: '$count бајт');
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
  String get sharedSyncNoAccounts => 'Нема сметки';

  @override
  String get sharedSyncChecking => 'Се проверува поштата…';

  @override
  String get sharedSyncFailed => 'Поштата не можеше да се провери';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Не сте поврзани';

  @override
  String get sharedSyncJustNow => 'Ажурирано токму сега';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ажурирано пред $minutes минути',
      one: 'Ажурирано пред $minutes минута',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Ажурирано во $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Ажурирано на $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Сите влезни сандачиња';

  @override
  String get sharedMailboxUnread => 'Непрочитани';

  @override
  String get sharedMailboxFlagged => 'Со знаменце';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Сите нацрти';

  @override
  String get sharedMailboxAllSent => 'Сите испратени';

  @override
  String get sharedMailboxUntitled => 'Сандаче';

  @override
  String get sharedTagImportant => 'Важна';

  @override
  String get sharedTagWork => 'Работа';

  @override
  String get sharedTagPersonal => 'Лична';

  @override
  String get sharedTagToDo => 'Задача';

  @override
  String get sharedTagLater => 'Подоцна';

  @override
  String get sharedTags => 'Ознаки';

  @override
  String get sharedMoveTo => 'Премести во…';

  @override
  String get sharedNoRecipients => 'Нема примачи';

  @override
  String get sharedUnknownSender => 'Непознат испраќач';

  @override
  String get sharedOnServer => 'На серверот';

  @override
  String get sharedAttachment => 'Има прилог';

  @override
  String get sharedSnoozedBadge => 'Одложено';

  @override
  String get sharedRowUnread => 'Непрочитано';

  @override
  String get sharedRowBackFromSnooze => 'Вратено од одложување';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Со знаменце';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се архивирани',
      one: '$count порака е архивирана',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се избришани',
      one: '$count порака е избришана',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се преместени во Влезното сандаче',
      one: '$count порака е преместена во Влезното сандаче',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се преместени во корпа',
      one: '$count порака е преместена во корпа',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се преместени во несакана пошта',
      one: '$count порака е преместена во несакана пошта',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се преместени во $mailbox',
      one: '$count порака е преместена во $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се преместени во папка',
      one: '$count порака е преместена во папка',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пораки се одложени до $time',
      one: '$count порака е одложена до $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Одложено до $time само на овој уред: серверот не може да чува времиња на одложување.';
  }

  @override
  String get sharedMoveOneAccount => 'Изберете пораки од една сметка за да ги преместите.';

  @override
  String get sharedSnoozeTitle => 'Одложување';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Промени го времето на одложување';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Да се избришат трајно $count пораки?',
      one: 'Да се избрише трајно $count порака?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ова не може да се поништи.';

  @override
  String get sharedDeletePermanently => 'Избриши трајно';

  @override
  String get sharedSwipeRead => 'Прочитано';

  @override
  String get sharedSwipeUnread => 'Непрочитано';

  @override
  String get sharedSwipeInbox => 'Во влезно';

  @override
  String get sharedSwipeDelete => 'Избриши';

  @override
  String get sharedTrash => 'Во корпа';

  @override
  String get sharedSwipeSnooze => 'Одложи';

  @override
  String get sharedWakeNow => 'Врати сега';

  @override
  String get sharedChangeSnoozeTime => 'Промени го времето на одложување…';

  @override
  String get sharedSnooze => 'Одложи…';

  @override
  String get sharedTag => 'Ознаки…';

  @override
  String get sharedMoveMessage => 'Премести порака…';

  @override
  String get sharedNotJunk => 'Не е несакана пошта';

  @override
  String get accountSetupTitle => 'Додавање сметка';

  @override
  String get accountSetupTitleDone => 'Сметката е додадена';

  @override
  String get accountSetupAddressTitle => 'Додајте сметка за е-пошта';

  @override
  String get accountSetupAddressText => 'Loupe ги наоѓа поставките за повеќето даватели на услуги.';

  @override
  String get accountSetupNameHint => 'Вашето име';

  @override
  String get accountSetupEmail => 'Е-пошта';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Продолжи';

  @override
  String get accountSetupLookingUp => 'Се бараат поставките…';

  @override
  String get accountSetupImport => 'Увези од Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Внесете важечка адреса на е-пошта.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Не се најдени поставки за $domain. Внесете ги подолу.';
  }

  @override
  String get accountSetupCheckServers => 'Проверете ги имињата на серверите и портите.';

  @override
  String get accountSetupEnterPassword => 'Внесете ја лозинката.';

  @override
  String get accountSetupConnecting => 'Се поврзува…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Се чека $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Страницата не може да се отвори.';

  @override
  String get accountSetupCouldNotSaveName => 'Името не може да се зачува.';

  @override
  String get accountSetupTrustCertificate => 'Верувај му на овој сертификат';

  @override
  String get accountSetupPasswordRequired => 'Задолжително';

  @override
  String get accountSetupShowPassword => 'Прикажи ја лозинката';

  @override
  String get accountSetupHidePassword => 'Скриј ја лозинката';

  @override
  String get accountSetupAppPassword => 'Лозинка за апликација';

  @override
  String get accountSetupApiToken => 'API токен';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Дојдовна пошта · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Појдовна пошта · SMTP';

  @override
  String get accountSetupSignIn => 'Најави се';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Најави се со $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Користи лозинка за апликација';

  @override
  String get accountSetupUseAppPasswordInstead => 'Користи лозинка за апликација наместо тоа';

  @override
  String get accountSetupUseDifferentAddress => 'Користи друга адреса';

  @override
  String get accountSetupHowToCreateAppPassword => 'Како да создадете лозинка за апликација';

  @override
  String get accountSetupHowToCreateOne => 'Упатство за создавање';

  @override
  String get accountSetupGoogleNote =>
      'Се најавувате на страницата на Google, а Loupe никогаш не ја гледа вашата лозинка. Дозволете му на Loupe да ја чита, испраќа и организира вашата пошта.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Најави се со Google“ сè уште не е достапно во оваа верзија. Наместо тоа, можете да се поврзете со лозинка за апликација (потребна е потврда во 2 чекори на вашата сметка на Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Создајте лозинка за апликација во вашата сметка на Google и залепете ја подолу.';

  @override
  String get accountSetupMicrosoftNote =>
      'Се најавувате на страницата на Microsoft, а Loupe никогаш не ја гледа вашата лозинка. Ова функционира за Outlook.com и Hotmail, како и за службени или училишни сметки на Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Најавата со Microsoft доаѓа во една од следните верзии. Ја бараат сметките на Outlook, Hotmail и Microsoft 365: тие повеќе не прифаќаат лозинки од апликации за пошта.';

  @override
  String get accountSetupICloudNote =>
      'За iCloud Mail е потребна лозинка специфична за апликацијата, а не лозинката за вашата сметка на Apple.';

  @override
  String get accountSetupYahooNote =>
      'За Yahoo Mail е потребна лозинка за апликација, а не лозинката за вашата сметка.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe се поврзува со Fastmail преку JMAP со API токен: Settings › Privacy & Security › Manage API tokens, за JMAP, со пристап до е-поштата и испраќањето.';

  @override
  String get accountSetupFastmailNote => 'Fastmail бара лозинка за апликација за апликациите за пошта.';

  @override
  String get accountSetupServerSettings => 'Поставки за серверот';

  @override
  String get accountSetupSettingsNotFound => 'Не се најдени автоматски';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Најдено преку $source';
  }

  @override
  String get accountSetupEditSettings => 'Уреди ги поставките';

  @override
  String get accountSetupSyncing => 'Вашата пошта се синхронизира.';

  @override
  String get accountSetupDescription => 'Опис';

  @override
  String get accountSetupDescriptionHint => 'Работа, Лично…';

  @override
  String get accountSetupColour => 'Боја';

  @override
  String accountSetupColourNumber(int number) {
    return 'Боја $number';
  }

  @override
  String get accountSetupSaving => 'Се зачувува…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe не можеше да ја отвори базата на пошта на овој телефон. Затворете го Loupe, отворете го повторно и обидете се пак.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Нешто тргна наопаку ($error). Обидете се повторно.';
  }

  @override
  String get accountSetupSecurityNone => 'Нема';

  @override
  String get accountSetupProtocol => 'Протокол';

  @override
  String get accountSetupPort => 'Порта';

  @override
  String get accountSetupSecurity => 'Безбедност';

  @override
  String get accountSetupUsername => 'Корисничко име';

  @override
  String get accountSetupUsernameHint => 'Вашата адреса на е-пошта';

  @override
  String get accountSetupNoEncryptionTitle => 'Поврзување без шифрирање?';

  @override
  String get accountSetupNoEncryptionText =>
      'Вашата лозинка и секоја порака би патувале како обичен текст. Секој на мрежата, на пример на јавна Wi-Fi мрежа, би можел да ги прочита. Користете го ова само за сервер на вашата сопствена мрежа.';

  @override
  String get accountSetupUseWithoutEncryption => 'Користи без шифрирање';

  @override
  String get accountSetupApiTokenRejected =>
      'API токенот е одбиен. Создајте API токен на Fastmail за JMAP со пристап до е-поштата и залепете го.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Лозинката е одбиена. Користете лозинка за апликација, а не лозинката за сметката.';

  @override
  String get accountSetupPasswordRejected => 'Лозинката е одбиена. Проверете ја и обидете се повторно.';

  @override
  String get accountSetupServerUnreachable => 'Серверот не е достапен. Проверете ги поставките за серверот и врската.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Сертификатот на серверот не е доверлив. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Најавата е откажана. Допрете „Најави се со $provider“ за да се обидете повторно.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'На Loupe му треба дозвола да ја чита и испраќа вашата пошта на Gmail. Најавете се повторно и дозволете пристап, со штиклирано поле за Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'На Loupe му треба дозвола да ја чита и испраќа вашата пошта. Најавете се повторно и прифатете ги дозволите.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Вашата организација мора да го одобри Loupe пред да можете да го користите со оваа сметка. Замолете го вашиот IT-администратор да додели административна согласност за Loupe во Microsoft Entra ID, па обидете се повторно.';

  @override
  String get accountSetupOAuthBlocked =>
      'Правилата за најавување на вашата организација не го дозволуваат Loupe на овој уред. Обратете се кај вашиот IT-администратор.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider не е достапен. Проверете ја интернет-врската и обидете се повторно.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Најавата со $provider не е правилно поставена во оваа верзија на Loupe. Ве молиме пријавете го ова.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Најавата со $provider не успеа. Обидете се повторно.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Најавата со $provider успеа, но Gmail го одби пристапот за оваа адреса. При најавувањето изберете ја истата сметка. Кај службените или училишните сметки администраторот можеби го исклучил IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Најавата со $provider успеа, но серверот за пошта го одби пристапот за оваа адреса. При најавувањето изберете ја истата сметка. Кај службените или училишните сметки администраторот можеби го исклучил IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Серверот за пошта не е достапен. Проверете ја врската и обидете се повторно.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Најавата со $provider не е достапна во оваа верзија.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Повторно сте најавени. Сметката $account се синхронизира.';
  }

  @override
  String get accountSetupSignInAgain => 'Најави се повторно';

  @override
  String get accountSetupSigningIn => 'Се најавува…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider повеќе не ја прифаќа најавата на Loupe за $email, па сметката $account не се синхронизира. Најавете се повторно за да ја добивате поштата.';
  }

  @override
  String get accountImportTitle => 'Увоз од Thunderbird';

  @override
  String get accountImportPointCamera => 'Насочете ја камерата кон QR-кодот што го прикажува Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Скенирани $scanned од $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Скенирани $scanned од $total кода',
      one: 'Скенирани $scanned од $total код',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Засега $count сметки',
      one: 'Засега $count сметка',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'На компјутерот отворете го Thunderbird и изберете Алатки › Export for Mobile. Изберете ги сметките, па скенирајте го секој код што ќе го прикаже. Кодовите може да се скенираат по кој било редослед.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Продолжи со $count сметки',
      one: 'Продолжи со $count сметка',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Залепи текст наместо тоа';

  @override
  String get accountImportStartOver => 'Почни одново';

  @override
  String get accountImportDuplicateCode => 'Тој код е веќе додаден.';

  @override
  String get accountImportRestarted => 'Овој код е од нов извоз, па претходно скенираните кодови се ставени настрана.';

  @override
  String get accountImportNotThunderbird => 'Ова не е код за сметка од Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Овој код е од понова верзија на Thunderbird. Ажурирајте го Loupe за да го увезете.';

  @override
  String get accountImportDamaged => 'Овој код од Thunderbird не може да се прочита.';

  @override
  String get accountImportTooLarge => 'Овој код е преголем за да биде извоз од Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Поставките не може да се отворат.';

  @override
  String get accountImportCameraOffTitle => 'Пристапот до камерата е исклучен';

  @override
  String get accountImportCameraOffText =>
      'Во поставките дозволете му на Loupe да ја користи камерата за да го скенирате кодот или наместо тоа залепете го текстот на кодот.';

  @override
  String get accountImportNoCameraTitle => 'Нема камера';

  @override
  String get accountImportNoCameraText =>
      'Loupe тука не може да користи камера. Наместо тоа залепете го текстот на кодот.';

  @override
  String get accountImportCameraFailedTitle => 'Камерата не се вклучи';

  @override
  String get accountImportCameraFailedText => 'Обидете се повторно или наместо тоа залепете го текстот на кодот.';

  @override
  String get accountImportOpenSettings => 'Отвори поставки';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Најдени се $count сметки',
      one: 'Најдена е $count сметка',
      zero: 'Не е најдена ниедна сметка',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ниедна сметка од овие кодови не може да се прочита.';

  @override
  String get accountImportChoose => 'Изберете ги сметките што сакате да ги додадете во Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Не се скенирани $count кода (броеви $codes од $total), па нивните сметки не се наведени.',
      one: 'Не е скениран $count код (број $codes од $total), па неговите сметки не се наведени.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes и $last';
  }

  @override
  String get accountImportScanMore => 'Скенирај уште кодови';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count сметки од кодовите не можеа да се прочитаат. Можеби користат поставки од понова верзија на Thunderbird.',
      one:
          '$count сметка од кодовите не можеше да се прочита. Можеби користи поставки од понова верзија на Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Скенирај повторно';

  @override
  String get accountImportAlreadyAdded => 'Сметка со оваа адреса веќе постои во Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Кога сметката ќе биде додадена, ќе се најавите со $provider, како во Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Додајте ја сметката со лозинка за апликација (потребна е потврда во 2 чекори).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird се најавува на Gmail со Google. „Најави се со Google“ доаѓа во една од следните верзии; дотогаш додајте ја сметката со лозинка за апликација (потребна е потврда во 2 чекори).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird се најавува на оваа сметка во прелистувачот. Loupe сè уште не го може тоа: користете лозинка за апликација ако вашиот давател ја нуди.';

  @override
  String get accountImportUnencrypted => 'Се поврзува без шифрирање. Користете го ова само на вашата сопствена мрежа.';

  @override
  String get accountImportEnterAgain => 'Внесете ја повторно';

  @override
  String get accountImportAdded => 'Додадено';

  @override
  String accountImportAdding(int index, int total) {
    return 'Се додава $index од $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Додај $count сметки',
      one: 'Додај $count сметка',
      zero: 'Додај сметки',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Залепете текст од извозот';

  @override
  String get accountImportPasteText =>
      'Залепете го текстот на кодот за извоз од Thunderbird, по еден код во секој ред.';

  @override
  String get accountImportPop3 => 'POP3-сметките не се поддржани. Loupe ја чува поштата на серверот преку IMAP.';

  @override
  String get accountImportKerberos => 'Оваа сметка се најавува со Kerberos, што Loupe не го поддржува.';

  @override
  String get accountImportNtlm => 'Оваа сметка се најавува со NTLM, што Loupe не го поддржува.';

  @override
  String get accountImportClientCertificate =>
      'Оваа сметка се најавува со клиентски сертификат, што Loupe сè уште не го поддржува.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Најавата со Microsoft доаѓа во една од следните верзии. Сметките на Outlook и Microsoft 365 повеќе не прифаќаат лозинки од апликации за пошта.';

  @override
  String get accountImportEnterPassword => 'Внесете ја лозинката.';

  @override
  String get accountImportEnterAppPassword => 'Внесете ја лозинката за апликација.';

  @override
  String get accountImportEnterApiToken => 'Внесете го API токенот.';

  @override
  String get accountImportStorageFailed =>
      'Loupe не можеше да го отвори складиштето за сметки. Обидете се повторно подоцна.';

  @override
  String get accountImportFailed => 'Сметката не може да се додаде. Обидете се повторно или додајте ја рачно.';

  @override
  String get composeNewMessageTitle => 'Нова порака';

  @override
  String get composeAttach => 'Прикачи';

  @override
  String get composeSendLater => 'Испрати подоцна';

  @override
  String composeSendAt(String time) {
    return 'Испрати: $time';
  }

  @override
  String get composeSendHint => 'Притиснете долго за да испратите подоцна';

  @override
  String get composeNoAccount => 'Додајте сметка за да испраќате пошта.';

  @override
  String get composeTo => 'До:';

  @override
  String get composeCc => 'Копија:';

  @override
  String get composeBcc => 'Скриена копија:';

  @override
  String composeCcBccFrom(String email) {
    return 'Копија, скриена копија, Од: $email';
  }

  @override
  String get composeFromLabel => 'Од:';

  @override
  String get composeSubjectLabel => 'Тема:';

  @override
  String composeReplyTo(String address) {
    return 'Адреса за одговор: $address';
  }

  @override
  String get composeFrom => 'Од';

  @override
  String composeReplyFrom(String email) {
    return 'Одговори од $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Испрати од $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Да се одговори од $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Да се испрати од $email?';
  }

  @override
  String get composeDismiss => 'Отфрли';

  @override
  String composeAliasNotSaved(String account) {
    return 'Не е зачувано како идентитет · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Зачувај како идентитет';

  @override
  String composeAliasSaved(String email) {
    return 'Адресата $email е зачувана како идентитет.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Неважечка адреса $address';
  }

  @override
  String get composeOriginalNotFound => 'Оригиналната порака не е најдена.';

  @override
  String get composeDraftNotFound => 'Нацртот не е најден.';

  @override
  String get composeAttachmentsLost => 'Прилозите не може да се вратат. Додајте ги повторно.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Некои прилози не може да се додадат: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Прилозите вкупно имаат $size; некои сервери одбиваат вакви големи пораки.';
  }

  @override
  String get composeAttachFailed => 'Датотеката не може да се прикачи.';

  @override
  String get composeInvalidAddressTitle => 'Неважечка адреса';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ не е важечка адреса на е-пошта.';
  }

  @override
  String get composeNoSubjectTitle => 'Без тема';

  @override
  String get composeNoSubjectText => 'Оваа порака нема тема. Сепак да се испрати?';

  @override
  String get composeSentBeforeChanges => 'Беше испратена пред вашите измени, кои се зачувани во Нацрти.';

  @override
  String composeScheduled(String time) {
    return 'Закажано за $time';
  }

  @override
  String get composeSending => 'Се испраќа…';

  @override
  String get composeSent => 'Испратено';

  @override
  String get composeSendFailed => 'Испраќањето не успеа. Обидете се повторно.';

  @override
  String get composeAlreadySent => 'Веќе е испратено.';

  @override
  String get composeDiscardChanges => 'Отфрли ги измените';

  @override
  String get composeSaveChanges => 'Зачувај ги измените';

  @override
  String get composeDeleteDraft => 'Избриши го нацртот';

  @override
  String get composeSaveDraft => 'Зачувај нацрт';

  @override
  String get composeDraftSaved => 'Нацртот е зачуван';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'На $date во $time, $name напиша:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'На $date во $time, некој напиша:';
  }

  @override
  String get composeForwardHeader => '---------- Препратена порака ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Од: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Датум: $date во $time';
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
    return 'Копија: $addresses';
  }

  @override
  String get composeLaterToday => 'Подоцна денес';

  @override
  String get composeTomorrowMorning => 'Утре наутро';

  @override
  String get composeMondayMorning => 'Во понеделник наутро';

  @override
  String get composePickDateTime => 'Избери датум и време…';

  @override
  String get composeSendWithoutDelay => 'Испрати веднаш';

  @override
  String composeSendTimeToday(String time) {
    return 'Денес во $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Утре во $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day во $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Денес $time';
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
  String get composeRecoveryTitle => 'Да продолжите со уредување на нацртот?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Една порака не беше испратена кога се затвори Loupe.',
      'one': 'Пораката до $name не беше испратена кога се затвори Loupe.',
      'other': 'Пораката до $name и други не беше испратена кога се затвори Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Пораката „$subject“ не беше испратена кога се затвори Loupe.',
      'one': 'Пораката „$subject“ до $name не беше испратена кога се затвори Loupe.',
      'other': 'Пораката „$subject“ до $name и други не беше испратена кога се затвори Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Продолжи со уредување';

  @override
  String get composeRecoverySave => 'Зачувај во нацрти';

  @override
  String get composeRecoveryDiscard => 'Отфрли';

  @override
  String get composeRecoverySaved => 'Зачувано во нацрти';

  @override
  String get outboxSectionFailed => 'Неиспратени';

  @override
  String get outboxSectionSending => 'Се испраќаат';

  @override
  String get outboxSectionScheduled => 'Закажани';

  @override
  String get outboxStatusQueued => 'Наскоро се испраќа';

  @override
  String get outboxStatusSending => 'Се испраќа…';

  @override
  String get outboxStatusFailed => 'Не е испратено';

  @override
  String get outboxNoRecipients => 'Нема примачи';

  @override
  String get outboxNoSubject => '(Без тема)';

  @override
  String get outboxSendingFailed => 'Испраќањето не успеа.';

  @override
  String get outboxEmptyTitle => 'Нема ништо за испраќање';

  @override
  String get outboxEmptyText => 'Пораките што ги испраќате подоцна чекаат тука додека не дојде времето.';

  @override
  String get outboxSendNow => 'Испрати веднаш';

  @override
  String get outboxReschedule => 'Промени време';

  @override
  String get outboxRescheduleMenu => 'Промени време…';

  @override
  String get outboxRescheduleTitle => 'Ново време на испраќање';

  @override
  String outboxRescheduled(String time) {
    return 'Повторно закажано за $time';
  }

  @override
  String get outboxCancel => 'Откажи';

  @override
  String get outboxCancelSending => 'Откажи испраќање…';

  @override
  String get outboxCancelTitle => 'Да се откаже испраќањето?';

  @override
  String get outboxMoveToDrafts => 'Премести во нацрти';

  @override
  String get outboxDiscard => 'Отфрли ја пораката';

  @override
  String get outboxMovedToDrafts => 'Преместено во нацрти';

  @override
  String get outboxDiscarded => 'Пораката е отфрлена';

  @override
  String get outboxAlreadySent => 'Веќе е испратено.';

  @override
  String get outboxBeingSent => 'Оваа порака токму се испраќа.';

  @override
  String get outboxActionFailed => 'Тоа не успеа. Пораката е сè уште во излезното сандаче.';

  @override
  String get notificationsBadgeInboxes => 'Непрочитани во влезните сандачиња';

  @override
  String get notificationsBadgeVip => 'Непрочитани во VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Нова пошта од вашите VIP-контакти, на која било сметка';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Нова пошта на $email';
  }

  @override
  String get notificationsUnknownSender => 'Непознат испраќач';

  @override
  String get notificationsNoSubject => '(Без тема)';

  @override
  String get notificationsEncryptedMessage => 'Шифрирана порака';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Нова порака: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нови пораки',
      one: '$count нова порака',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Нови пораки: $account';
  }

  @override
  String get platformInstantChannel => 'Моментална испорака';

  @override
  String get platformInstantChannelDescription =>
      'Се прикажува додека Loupe ги следи вашите влезни сандачиња за нова пошта';

  @override
  String get platformInstantTitle => 'Следење на нова пошта';

  @override
  String get platformInstantText => 'Моменталната испорака е вклучена';

  @override
  String get platformErrorBox => 'Настана грешка при прикажувањето. Вратете се назад и обидете се повторно.';

  @override
  String get welcomeTagline => 'Пошта што е едноставна однадвор\nи моќна одвнатре.';

  @override
  String get welcomeAccountsTitle => 'Сите сметки, едно мирно сандаче';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail и кој било IMAP- или JMAP-сервер.';

  @override
  String get welcomeSearchTitle => 'Пребарување што наоѓа';

  @override
  String get welcomeSearchText => 'Моментални резултати на телефонот, потоа од серверот.';

  @override
  String get welcomePrivacyTitle => 'Приватност по дизајн';

  @override
  String get welcomePrivacyText => 'Без следење. Далечинските слики остануваат блокирани додека не кажете поинаку.';

  @override
  String get welcomeAddAccount => 'Додај сметка';

  @override
  String get welcomeImport => 'Увези од Thunderbird';

  @override
  String get welcomeTryDemo => 'Пробај со демо пошта';
}
