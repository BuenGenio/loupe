// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get commonAdd => 'Додати';

  @override
  String get commonCancel => 'Скасувати';

  @override
  String get commonClose => 'Закрити';

  @override
  String get commonDelete => 'Видалити';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonEdit => 'Змінити';

  @override
  String get commonMore => 'Більше';

  @override
  String get commonMove => 'Перемістити';

  @override
  String get commonName => 'Назва';

  @override
  String get commonNone => 'Немає';

  @override
  String get commonOff => 'Вимк.';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Увімк.';

  @override
  String get commonOptional => 'Необов’язково';

  @override
  String get commonPassword => 'Пароль';

  @override
  String get commonRemove => 'Вилучити';

  @override
  String get commonRetry => 'Повторити';

  @override
  String get commonSave => 'Зберегти';

  @override
  String get commonSearch => 'Пошук';

  @override
  String get commonServer => 'Сервер';

  @override
  String get commonSettings => 'Налаштування';

  @override
  String get commonShare => 'Поділитися';

  @override
  String get commonTryAgain => 'Спробувати ще раз';

  @override
  String get commonUndo => 'Скасувати';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count листів',
      few: '$count листи',
      one: '$count лист',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Архівувати';

  @override
  String get mailDelete => 'Видалити';

  @override
  String get mailFlag => 'Позначити прапорцем';

  @override
  String get mailForward => 'Переслати';

  @override
  String get mailMarkAsRead => 'Позначити як прочитане';

  @override
  String get mailMarkAsUnread => 'Позначити як непрочитане';

  @override
  String get mailMoveToJunk => 'Перемістити в спам';

  @override
  String get mailNewMessage => 'Новий лист';

  @override
  String get mailNoSubject => 'Без теми';

  @override
  String get mailReply => 'Відповісти';

  @override
  String get mailReplyAll => 'Відповісти всім';

  @override
  String get mailSend => 'Надіслати';

  @override
  String get mailUnflag => 'Зняти прапорець';

  @override
  String get mailboxArchive => 'Архів';

  @override
  String get mailboxDrafts => 'Чернетки';

  @override
  String get mailboxInbox => 'Вхідні';

  @override
  String get mailboxJunk => 'Спам';

  @override
  String get mailboxOutbox => 'Вихідні';

  @override
  String get mailboxSent => 'Надіслані';

  @override
  String get mailboxTrash => 'Кошик';

  @override
  String get conversationSomethingWentWrong => 'Щось пішло не так. Спробуйте ще раз.';

  @override
  String get conversationReplyToList => 'Відповісти в список розсилки';

  @override
  String get conversationReplyList => 'До списку';

  @override
  String get conversationThreadMuted => 'Гілку приглушено. Нові листи в ній надходитимуть прочитаними.';

  @override
  String get conversationThreadUnmuted => 'Приглушення гілки знято.';

  @override
  String get conversationLinkFailed => 'Не вдалося відкрити посилання.';

  @override
  String get conversationGoneTitle => 'Листа немає';

  @override
  String get conversationGoneText => 'Цей лист переміщено або видалено.';

  @override
  String get conversationMuted => 'Приглушено';

  @override
  String get conversationReaderOptions => 'Параметри читання';

  @override
  String get conversationReaderOptionsHint => 'Розмір тексту й вигляд';

  @override
  String get conversationTrash => 'У кошик';

  @override
  String get conversationReplyHint => 'Утримуйте, щоб відповісти всім або переслати';

  @override
  String get conversationOfflineTitle => 'Ви не в мережі';

  @override
  String get conversationOfflineText =>
      'Цю розмову ще не завантажено. Вона завантажиться, коли ви знову будете в мережі.';

  @override
  String get conversationErrorTitle => 'Не вдається показати цей лист';

  @override
  String get conversationErrorText => 'Щось пішло не так.';

  @override
  String get conversationOfflineBanner => 'Ви не в мережі';

  @override
  String get conversationNotUpdated => 'Не оновлено';

  @override
  String get conversationMe => 'я';

  @override
  String get conversationNoSender => '(без відправника)';

  @override
  String get conversationNoRecipients => 'без одержувачів';

  @override
  String conversationRecipients(String names) {
    return 'кому: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'кому: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Від';

  @override
  String get conversationHeaderTo => 'Кому';

  @override
  String get conversationHeaderCc => 'Копія';

  @override
  String get conversationHeaderBcc => 'Прихована копія';

  @override
  String get conversationHeaderReplyTo => 'Відповідати на';

  @override
  String get conversationHeaderDate => 'Дата';

  @override
  String get conversationHeaderSecurity => 'Безпека';

  @override
  String get conversationVerifiedSender => 'Перевірений відправник';

  @override
  String get conversationUnverifiedSender => 'Неперевірений відправник';

  @override
  String get conversationLoadingMessage => 'Завантаження листа';

  @override
  String get conversationBodyError => 'Не вдалося завантажити цей лист.';

  @override
  String get conversationBodyOffline => 'Ви не в мережі. Лист завантажиться, коли ви знову будете в мережі.';

  @override
  String get conversationOriginalHint => 'Краще виглядає в режимі «Оригінал»';

  @override
  String get conversationShowOriginal => 'Показати оригінал';

  @override
  String get conversationScrollToTop => 'Прокрутити на початок';

  @override
  String get conversationTagsMenu => 'Мітки…';

  @override
  String get conversationMuteThread => 'Приглушити гілку';

  @override
  String get conversationUnmuteThread => 'Зняти приглушення гілки';

  @override
  String get conversationMoveMenu => 'Перемістити…';

  @override
  String get conversationDeletePermanently => 'Видалити назавжди';

  @override
  String get conversationMoveToTrash => 'Перемістити в кошик';

  @override
  String get conversationNotJunk => 'Не спам';

  @override
  String get conversationShowAllHeaders => 'Показати всі заголовки';

  @override
  String get conversationViewSource => 'Переглянути джерело';

  @override
  String get conversationSaveAsFile => 'Зберегти як файл…';

  @override
  String get conversationShareAsFile => 'Поділитися як файлом…';

  @override
  String get conversationSearchFromMessageMenu => 'Шукати за цим листом…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Копіювати адресу';

  @override
  String get conversationAddressCopied => 'Адресу скопійовано';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Шукати листи від $name';
  }

  @override
  String get conversationTags => 'Мітки';

  @override
  String get conversationAllHeaders => 'Усі заголовки';

  @override
  String get conversationCopyAll => 'Копіювати все';

  @override
  String get conversationHeadersCopied => 'Заголовки скопійовано';

  @override
  String get conversationNoHeaders => 'Заголовків немає';

  @override
  String get conversationSearchFromMessageTitle => 'Шукати за цим листом';

  @override
  String conversationSearchFrom(String name) {
    return 'Від: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Кому: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Тема «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Джерело';

  @override
  String get conversationSourceCopied => 'Джерело скопійовано';

  @override
  String get conversationShareFailed => 'Не вдалося поділитися листом.';

  @override
  String get conversationWrapLines => 'Переносити рядки';

  @override
  String get conversationDontWrapLines => 'Не переносити рядки';

  @override
  String get conversationSourceError => 'Не вдалося завантажити джерело.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Показано перші $shown із $total. Скопіюйте або поділіться, щоб отримати все.';
  }

  @override
  String get conversationAttachmentUntitled => 'Без назви';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Інші дії з $name';
  }

  @override
  String get conversationMoveTo => 'Перемістити в…';

  @override
  String get conversationMailboxesError => 'Не вдалося завантажити скриньки.';

  @override
  String get conversationReaderReadable => 'Для читання';

  @override
  String get conversationReaderOriginal => 'Оригінал';

  @override
  String get conversationReaderPlain => 'Текст';

  @override
  String get conversationReaderSans => 'Без зарубок';

  @override
  String get conversationReaderMono => 'Моно';

  @override
  String get conversationReaderKeepColours => 'Зберігати оригінальні кольори';

  @override
  String get conversationReaderRemember => 'Запам’ятати для цього відправника';

  @override
  String get conversationSecurityPossiblePhishing => 'Можливий фішинг';

  @override
  String get conversationSecurityBeCareful => 'Будьте обережні';

  @override
  String get conversationSecurityVerified => 'Перевірено';

  @override
  String get conversationSecurityNoIssues => 'Проблем не виявлено';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count трекерів',
      few: '$count трекери',
      one: '$count трекер',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Пояснює причину';

  @override
  String get conversationPhishingBannerTitle => 'Цей лист схожий на фішинг';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Посилання й зображення вимкнено.';
  }

  @override
  String get conversationPhishingBannerText => 'Посилання й зображення вимкнено.';

  @override
  String get conversationPhishingWhy => 'Чому?';

  @override
  String get conversationPhishingShowAnyway => 'Усе одно показати';

  @override
  String get conversationSecurityPhishingTitle => 'Схоже на фішинг';

  @override
  String get conversationSecurityPhishingText => 'Кілька ознак свідчать, що цей лист не той, за кого себе видає.';

  @override
  String get conversationSecurityCarefulTitle => 'Будьте обережні з цим листом';

  @override
  String get conversationSecurityCarefulText => 'Щось у ньому варто перевірити ще раз.';

  @override
  String get conversationSecurityVerifiedText => 'Відправника перевірено, і нічого не виглядає підозрілим.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Нічого не виглядає підозрілим. Ваш поштовий сервер не повідомив, чи перевірено відправника.';

  @override
  String get conversationSecurityNothingSuspicious => 'Нічого не виглядає підозрілим.';

  @override
  String get conversationSecurityWhy => 'Чому';

  @override
  String get conversationSecurityPrivacy => 'Конфіденційність';

  @override
  String get conversationSecurityNoTrackingPixels => 'Пікселів стеження немає';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Видалено $count пікселів стеження',
      few: 'Видалено $count пікселі стеження',
      one: 'Видалено $count піксель стеження',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Вони повідомили б відправника, коли ви відкрили цей лист.';

  @override
  String get conversationSecurityNoRemoteImages => 'Віддалених зображень немає';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count віддалених зображень',
      few: '$count віддалені зображення',
      one: '$count віддалене зображення',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Якщо їх завантажити, відправник дізнається, коли ви прочитали цей лист, і вашу IP-адресу.';

  @override
  String get conversationSecurityNoClickTracking => 'Стеження за натисканнями немає';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count посилань через трекери натискань',
      few: '$count посилання через трекери натискань',
      one: '$count посилання через трекери натискань',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Ваше натискання зафіксували б: $services. Утримуйте посилання, щоб відкрити його адресу напряму.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Технічні подробиці';

  @override
  String get conversationSecurityCheckedLocally => 'Перевірено на цьому пристрої. Нічого нікуди не надсилалося.';

  @override
  String get conversationSecurityTrackersLabel => 'Трекери';

  @override
  String get conversationSecurityImagesFrom => 'Зображення з';

  @override
  String get conversationSecuritySenderHistory => 'Історія з відправником';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'отримано: $received, надіслано: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Посилання ведуть на';

  @override
  String get conversationSecurityHidden => 'Приховане';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements елементів',
      few: '$elements елементи',
      one: '$elements елемент',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters символів',
      few: '$characters символи',
      one: '$characters символ',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Відправника не перевірено';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Ваш поштовий сервер не зміг підтвердити, що цей лист справді надійшов від $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Ваш поштовий сервер не зміг підтвердити, що цей лист справді надійшов від свого відправника.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Ваш поштовий сервер не зміг підтвердити, що цей лист надійшов від $domain. Для списків розсилки це звична справа.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Ваш поштовий сервер не зміг підтвердити, що цей лист надійшов від свого відправника. Для списків розсилки це звична справа.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Не робіть нічого за ним, якщо ви його не чекали. Якщо сумніваєтеся, зв’яжіться з відправником іншим способом.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Підписано іншим доменом';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Лист підписано доменом $signer, а не $domain. Так роблять служби розсилок, але це не доводить, хто його написав.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Лист підписано іншим доменом, а не $domain. Так роблять служби розсилок, але це не доводить, хто його написав.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Ім’я показує іншу адресу';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Ім’я відправника — «$shown», але лист надійшов з $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Довіряйте адресі, а не імені.';

  @override
  String get conversationSecurityReplyToTitle => 'Відповіді підуть деінде';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Ваша відповідь піде на $address, а не на $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Перевірте адресу, перш ніж надсилати у відповідь щось особисте.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Використовує ваше ім’я';

  @override
  String get conversationSecurityImpersonationTitle => 'Використовує ім’я знайомої вам людини';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Лист підписано «$name», як ваше власне ім’я, але він надійшов із нової адреси: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Лист підписано «$name», як ваш VIP-контакт $knownName ($knownEmail), але він надійшов із нової адреси: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Лист підписано «$name», як $knownName ($knownEmail), але він надійшов із нової адреси: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'А відповіді підуть ще на іншу адресу.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Якщо в листі просять гроші, коди чи файли, спершу перевірте це в людини іншим способом.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Відома адреса: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ця адреса: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Перший лист від цього відправника';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Раніше ви не отримували листів від $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Будьте обережні з проханнями від людей, яких ви ще не знаєте.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Схожі літери в адресі відправника';

  @override
  String get conversationSecurityLinkHomographTitle => 'Схожі літери в посиланні';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host змішує літери з різних абеток, щоб імітувати іншу адресу.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host використовує схожі літери: це не $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Видаліть його або позначте як спам.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Не відкривайте його.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Домен: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Домен-двійник';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Знайома назва в домені';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain схожий на ваш власний домен $real, але це інший домен.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain схожий на $brand ($real), але це інший домен.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain використовує назву вашого власного домену $real, але не належить до нього.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain використовує назву $brand ($real), але не належить до нього.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Справжні листи від вашої організації надходять з $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Справжні листи від $brand надходять з $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Домен відправника: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Імітує: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count посилань приховують, куди ведуть',
      few: '$count посилання приховують, куди ведуть',
      one: '$count посилання приховує, куди веде',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Посилання показує $shown, але відкриває $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Не входьте в облікові записи й не платіть за цими посиланнями. Краще введіть адресу самостійно.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Не вдається перевірити, куди веде посилання';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Посилання показує $shown, але веде через $host, який фіксує натискання, перш ніж передати його далі.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Посилання веде на голу IP-адресу';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts — не сайт з назвою. Справжні компанії рідко дають такі посилання.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Замасковане посилання';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Посилання починається з «$shown@», щоб виглядати як $shown, але відкриває $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Приховану сторінку вимкнено';

  @override
  String get conversationSecurityDataLinkText =>
      'Посилання відкрило б сторінку, вбудовану в сам лист, — спосіб обійти перевірку посилань.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Просить пароль';

  @override
  String get conversationSecurityPasswordFieldText => 'Лист містив поле для пароля. Loupe його видалив.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Ніколи не вводьте пароль у листі.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Посилання, що запускає код, вимкнено';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe ніколи не запускає код із листів.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count скорочених посилань',
      few: '$count скорочені посилання',
      one: '$count скорочене посилання',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts приховує справжню адресу, доки ви не відкриєте посилання.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Міжнародна вебадреса';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts використовує нелатинські літери. Для багатьох мов це нормально; перевірте, що це саме той сайт, на який ви очікуєте.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Багато прихованого тексту';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Видалено $count символів невидимого тексту. Такий прихований текст призначений обдурити спам-фільтри.',
      few: 'Видалено $count символи невидимого тексту. Такий прихований текст призначений обдурити спам-фільтри.',
      one: 'Видалено $count символ невидимого тексту. Такий прихований текст призначений обдурити спам-фільтри.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Прихований текст видалено';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Видалено $count символів невидимого тексту.',
      few: 'Видалено $count символи невидимого тексту.',
      one: 'Видалено $count символ невидимого тексту.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Не вдалося завантажити лист. Перевірте з’єднання й спробуйте ще раз.';

  @override
  String exportSaved(String name) {
    return 'Збережено «$name»';
  }

  @override
  String get exportSaveFailed => 'Не вдалося зберегти лист.';

  @override
  String exportFailed(String folder) {
    return 'Не вдалося експортувати «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return 'У «$folder» немає листів для експорту.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Не вдалося експортувати «$folder»: жоден лист не вдалося завантажити. Перевірте з’єднання й спробуйте ще раз.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Збережено «$name» без $formattedCount листів, які не вдалося завантажити.',
      few: 'Збережено «$name» без $formattedCount листів, які не вдалося завантажити.',
      one: 'Збережено «$name» без $count листа, який не вдалося завантажити.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Не вдалося зберегти «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'Експорт «$folder»';
  }

  @override
  String get exportListing => 'Пошук листів…';

  @override
  String exportProgress(String current, String total) {
    return 'Експорт $current з $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Не вдалося завантажити $formattedCount листів',
      few: 'Не вдалося завантажити $formattedCount листи',
      one: 'Не вдалося завантажити $count лист',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Скриньки';

  @override
  String get mailboxesShown => 'Показано';

  @override
  String get mailboxesHidden => 'Приховано';

  @override
  String get mailboxesCollapse => 'Згорнути';

  @override
  String get mailboxesExpand => 'Розгорнути';

  @override
  String get mailboxesManageVips => 'Керувати VIP';

  @override
  String get mailboxesSubscriptions => 'Підписки';

  @override
  String mailboxesShowAccount(String account) {
    return 'Показати $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Приховати $account';
  }

  @override
  String get mailboxesExportFolder => 'Експортувати теку…';

  @override
  String get mailboxesUnpin => 'Відкріпити';

  @override
  String get mailboxesLists => 'Списки розсилки';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Збережіть пошук, щоб він з’явився тут.';

  @override
  String get mailboxesTags => 'Мітки';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Також можна торкнутися імені відправника в листі й увімкнути VIP.';

  @override
  String get mailboxesAddVip => 'Додати VIP…';

  @override
  String get mailboxesAddVipTitle => 'Додати VIP';

  @override
  String get mailboxesAddVipText => 'Листи з цієї адреси отримують зірочку й з’являються у скриньці VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Непрочитані';

  @override
  String get messageListFilterFlagged => 'З прапорцем';

  @override
  String get messageListFilterToMe => 'Кому: мені';

  @override
  String get messageListFilterCcMe => 'Копія: мені';

  @override
  String get messageListFilterWithAttachments => 'З вкладеннями';

  @override
  String get messageListFilterUnreplied => 'Без відповіді';

  @override
  String get messageListFilterFromVips => 'Від VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count листів позначено як прочитані',
      few: '$count листи позначено як прочитані',
      one: '$count лист позначено як прочитаний',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Не вдалося завантажити старіші листи.';

  @override
  String get messageListSelectMessages => 'Вибір листів';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Вибрано: $count',
      few: 'Вибрано: $count',
      one: 'Вибрано: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Вибрати все';

  @override
  String get messageListDeselectAll => 'Скасувати вибір';

  @override
  String get messageListLoadFailed => 'Не вдалося завантажити пошту';

  @override
  String get messageListNoUnread => 'Немає непрочитаних листів';

  @override
  String get messageListNoMatches => 'Немає відповідних листів';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Фільтри: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Вимкнути фільтр';

  @override
  String get messageListEmpty => 'Немає листів';

  @override
  String get messageListFilter => 'Фільтр';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Критерії фільтра: $filters';
  }

  @override
  String get messageListFilteredBy => 'Фільтри:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount непрочитаних',
      few: '$formattedCount непрочитані',
      one: '$count непрочитаний',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Позначити';

  @override
  String get messageListTrash => 'У кошик';

  @override
  String get messageListFilterTitle => 'Фільтр';

  @override
  String get messageListFilterInclude => 'ПОКАЗУВАТИ';

  @override
  String get panesHideMailboxes => 'Сховати скриньки';

  @override
  String get panesShowMailboxes => 'Показати скриньки';

  @override
  String get panesMailboxesWidth => 'Ширина колонки скриньок';

  @override
  String get panesListWidth => 'Ширина списку листів';

  @override
  String get panesNoMessageSelected => 'Лист не вибрано';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count листів',
      few: '$count листи',
      one: '$count лист',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Відкладені';

  @override
  String get snoozeSheetTitle => 'Відкласти';

  @override
  String get snoozeLaterToday => 'Пізніше сьогодні';

  @override
  String get snoozeThisEvening => 'Сьогодні ввечері';

  @override
  String get snoozeTomorrow => 'Завтра';

  @override
  String get snoozeThisWeekend => 'Цими вихідними';

  @override
  String get snoozeNextWeek => 'Наступного тижня';

  @override
  String get snoozePickDateTime => 'Вибрати дату й час…';

  @override
  String get snoozeMenu => 'Відкласти…';

  @override
  String get snoozeWakeNow => 'Повернути зараз';

  @override
  String get snoozeChangeTimeMenu => 'Змінити час відкладення…';

  @override
  String get snoozeChangeTime => 'Змінити час';

  @override
  String get snoozeNoTime => 'Час не встановлено';

  @override
  String get snoozeFooter => 'Відкладені листи повертаються у «Вхідні» непрочитаними у призначений час.';

  @override
  String get snoozeEmptyTitle => 'Нічого не відкладено';

  @override
  String get snoozeEmptyText => 'Відкладіть лист, і він повернеться у «Вхідні», коли знадобиться.';

  @override
  String get appLockUnlock => 'Розблокувати';

  @override
  String get appLockFailed => 'Loupe не вдалося підтвердити, що це ви.';

  @override
  String get appLockLockedOut => 'Забагато спроб. Спробуйте пізніше.';

  @override
  String get appLockPromptError => 'Не вдалося показати запит. Спробуйте ще раз.';

  @override
  String get appLockNoScreenLock => 'На цьому телефоні не налаштовано блокування екрана.';

  @override
  String get appLockUnlockPromptTitle => 'Розблокувати Loupe';

  @override
  String get appLockUnlockPromptReason => 'Підтвердьте, що це ви, щоб побачити пошту.';

  @override
  String get appLockTurnOnPromptTitle => 'Увімкнути блокування застосунку';

  @override
  String get appLockTurnOnPromptReason => 'Підтвердьте, що це ви, щоб увімкнути блокування застосунку.';

  @override
  String get appLockScreenLockRemoved =>
      'Блокування застосунку вимкнено: на цьому телефоні більше немає блокування екрана. Налаштуйте його, щоб знову ввімкнути блокування застосунку.';

  @override
  String get appLockAfterImmediately => 'Одразу';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хвилин',
      few: '$count хвилини',
      one: '$count хвилина',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count годин',
      few: '$count години',
      one: '$count година',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Зашифровано';

  @override
  String get openpgpEncryptedInPart => 'Частково зашифровано';

  @override
  String get openpgpEncryptedLocked => 'Зашифровано · заблоковано';

  @override
  String get openpgpEncryptedNoKey => 'Зашифровано · немає ключа';

  @override
  String get openpgpEncryptedDamaged => 'Зашифровано · пошкоджено';

  @override
  String get openpgpEncryptedUnsupported => 'Зашифровано · не підтримується';

  @override
  String get openpgpUnknownSigner => 'невідомий';

  @override
  String get openpgpUnknownKey => 'Невідомий ключ';

  @override
  String get openpgpSignatureInvalid => 'Недійсний підпис';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Підписано: $name, а не відправник';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Частково підписано: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Підписано: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Підписано відхиленим ключем';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Підписано: $name · ключ не прийнято';
  }

  @override
  String get openpgpUnlock => 'Розблокувати';

  @override
  String get openpgpCantDecrypt => 'Не вдається розшифрувати цей лист';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Зашифровано за допомогою OpenPGP';

  @override
  String get openpgpEncryption => 'Шифрування';

  @override
  String get openpgpDecryptedHere => 'Розшифровано на цьому пристрої';

  @override
  String get openpgpNotDecrypted => 'Не розшифровано';

  @override
  String get openpgpKeyLocked => 'Ваш ключ заблоковано.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Для ключів $keys',
      few: 'Для ключів $keys',
      one: 'Для $count ключа: $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Захищена тема';

  @override
  String get openpgpUnlockKey => 'Розблокувати ключ';

  @override
  String get openpgpSignature => 'Підпис';

  @override
  String get openpgpFingerprint => 'Відбиток';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID ключа $id';
  }

  @override
  String get openpgpSigned => 'Підписано';

  @override
  String get openpgpProblem => 'Проблема';

  @override
  String get openpgpAcceptance => 'Прийняття';

  @override
  String get openpgpChangeAcceptance => 'Змінити прийняття…';

  @override
  String get openpgpCheckedFooter => 'Перевірено на цьому пристрої за допомогою OpenPGP, сумісно з Thunderbird.';

  @override
  String get openpgpSummaryLocked => 'Ваш ключ заблоковано. Розблокуйте його парольною фразою, щоб прочитати цей лист.';

  @override
  String get openpgpSummaryNoSecretKey => 'Його зашифровано для ключа, якого немає на цьому пристрої.';

  @override
  String get openpgpSummaryDamaged => 'Зашифровані дані пошкоджено або змінено дорогою.';

  @override
  String get openpgpSummaryUnsupported => 'Він використовує алгоритм, який Loupe не підтримує.';

  @override
  String get openpgpSummaryEncrypted => 'Прочитати його можете лише ви та інші одержувачі.';

  @override
  String get openpgpSummaryNotSigned => 'Він не підписаний, тож відправника не підтверджено.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Він підписаний, але ключем, якого у вас немає, тож підпис не вдається перевірити.';

  @override
  String get openpgpSummaryBadSignature => 'Підпис не збігається: лист, можливо, змінили.';

  @override
  String get openpgpSummaryMismatch => 'Підпис дійсний, але ключ належить не адресі відправника, а іншій.';

  @override
  String get openpgpSummaryPartial =>
      'Підписано лише частину листа. Текст поза підписом (наприклад, підвал списку розсилки) показано під рядком «Unsigned content», а інші частини листа, як-от вкладення, підпис теж не охоплює.';

  @override
  String get openpgpSummaryOwnKey => 'Підписано вашим власним ключем.';

  @override
  String get openpgpSummaryVerified => 'Підпис дійсний, і ви перевірили відбиток ключа.';

  @override
  String get openpgpSummaryUnverified => 'Підпис дійсний. Ви прийняли ключ, не перевіривши його відбиток.';

  @override
  String get openpgpSummaryRejected => 'Підпис дійсний, але ви відхилили цей ключ.';

  @override
  String get openpgpSummaryUndecided =>
      'Підпис дійсний, але ви ще не прийняли цей ключ. Звірте його відбиток із відправником.';

  @override
  String get openpgpAcceptanceRejected => 'Відхилено';

  @override
  String get openpgpAcceptanceUndecided => 'Не прийнято';

  @override
  String get openpgpAcceptanceUnverified => 'Прийнято';

  @override
  String get openpgpAcceptanceVerified => 'Прийнято й перевірено';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Прийняти ключ $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Відбиток $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Так, відбиток перевірено';

  @override
  String get openpgpAcceptUnverified => 'Так, без перевірки';

  @override
  String get openpgpAcceptLater => 'Поки ні';

  @override
  String get openpgpRejectKey => 'Відхилити цей ключ';

  @override
  String get openpgpNoSubject => '(без теми)';

  @override
  String get openpgpEncryptionTitle => 'Наскрізне шифрування';

  @override
  String get openpgpMyKeys => 'Мої ключі OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Маючи ключ, ви можете читати зашифровані листи, а також підписувати й шифрувати власні. Користуєтеся Thunderbird? Експортуйте там свій ключ (Параметри облікового запису › Наскрізне шифрування › Експортувати секретний ключ) та імпортуйте його сюди.';

  @override
  String get openpgpAddKey => 'Додати ключ…';

  @override
  String get openpgpAddresses => 'Адреси';

  @override
  String get openpgpAddressesFooter => 'Який ключ використовує кожна адреса і коли вона шифрує та підписує.';

  @override
  String get openpgpCorrespondentsKeys => 'Ключі OpenPGP співрозмовників';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Прийміть ключ, коли довіряєте, що він належить своєму власникові; звірте з ним відбиток, щоб позначити ключ як перевірений.';

  @override
  String get openpgpImportPublicKey => 'Імпортувати відкритий ключ…';

  @override
  String get openpgpCollected => 'Зібрано через Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Ключі, що надійшли разом із листами. Loupe може шифрувати для них, коли обидві сторони цього просять.';

  @override
  String get openpgpOnThisDevice => 'На цьому пристрої';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Зашифровані листи приховують свою тему. Loupe зберігає тему кожного відкритого вами листа у своїй зашифрованій базі даних на цьому пристрої, щоб її показували список, пошук і сповіщення. У фоновому режимі Loupe також може розшифровувати теми нових листів ключами без парольної фрази; для цього він завантажує кожен лист (до 1 МБ).';

  @override
  String get openpgpDecryptSubjects => 'Розшифровувати теми у фоновому режимі';

  @override
  String get openpgpIndexFooter =>
      'Пошук знаходить зашифровані листи за відправником, одержувачами й темою. Якщо це ввімкнено, Loupe також додає текст кожного розшифрованого листа до пошукового індексу у своїй зашифрованій базі даних на цьому пристрої, тож пошук знаходить лист і за текстом. Якщо вимкнути, цей текст буде вилучено з індексу.';

  @override
  String get openpgpIndexDecrypted => 'Індексувати розшифровані листи для пошуку';

  @override
  String get openpgpPassphrases => 'Парольні фрази';

  @override
  String get openpgpPassphrasesFooter =>
      'Ключі OpenPGP і сертифікати S/MIME, захищені парольною фразою, розблоковуються, коли потрібно. Без «Запам’ятовувати» вони знову блокуються через дві хвилини після кожного використання.';

  @override
  String get openpgpRememberPassphrases => 'Запам’ятовувати парольні фрази';

  @override
  String get openpgpRememberPassphrasesDetail => 'Доки Loupe не закриється';

  @override
  String get openpgpLockKeysNow => 'Заблокувати ключі зараз';

  @override
  String get openpgpKeysLocked => 'Ключі заблоковано.';

  @override
  String get openpgpKeyStateRevoked => 'відкликано';

  @override
  String get openpgpKeyStateExpired => 'термін дії минув';

  @override
  String get openpgpKeyStateNeverExpires => 'безстроковий';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'діє до $date';
  }

  @override
  String get openpgpNoKey => 'Немає ключа';

  @override
  String get openpgpAlwaysEncrypt => 'Завжди шифрувати';

  @override
  String get openpgpAddKeyTitle => 'Додати ключ OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Імпортуйте ключ, який ви використовуєте в Thunderbird, або створіть новий.';

  @override
  String get openpgpImportFromClipboard => 'Імпортувати з буфера обміну';

  @override
  String get openpgpImportFromFile => 'Імпортувати з файлу';

  @override
  String get openpgpGenerateNewKey => 'Створити новий ключ';

  @override
  String get openpgpImportPublicKeyTitle => 'Імпортувати відкритий ключ';

  @override
  String get openpgpFromClipboard => 'З буфера обміну';

  @override
  String get openpgpFromFile => 'З файлу';

  @override
  String get openpgpClipboardEmpty => 'Буфер обміну порожній. Спершу скопіюйте ключ.';

  @override
  String get openpgpKey => 'Ключ';

  @override
  String get openpgpValidityRevoked => 'Відкликано';

  @override
  String openpgpValidityExpired(String date) {
    return 'Термін дії минув $date';
  }

  @override
  String get openpgpNeverExpires => 'Безстроковий';

  @override
  String openpgpValidUntil(String date) {
    return 'Дійсний до $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Відбиток скопійовано.';

  @override
  String get openpgpAlgorithm => 'Алгоритм';

  @override
  String get openpgpCreated => 'Створено';

  @override
  String get openpgpValidity => 'Термін дії';

  @override
  String get openpgpProtection => 'Захист';

  @override
  String get openpgpProtectionPassphrase => 'Парольна фраза';

  @override
  String get openpgpProtectionKeychain => 'Лише сховище ключів';

  @override
  String get openpgpKeyDetailsFooter =>
      'Поділіться відкритим ключем, щоб інші могли шифрувати листи для вас. Резервна копія — це ваш секретний ключ, захищений парольною фразою, якщо вона є: нікому її не давайте.';

  @override
  String get openpgpSharePublicKey => 'Поділитися відкритим ключем';

  @override
  String get openpgpCopyPublicKey => 'Копіювати відкритий ключ';

  @override
  String get openpgpPublicKeyCopied => 'Відкритий ключ скопійовано.';

  @override
  String get openpgpBackUpSecretKey => 'Резервна копія секретного ключа';

  @override
  String get openpgpDeleteKey => 'Видалити ключ';

  @override
  String get openpgpRemoveKey => 'Вилучити ключ';

  @override
  String get openpgpBackUpTitle => 'Створити резервну копію секретного ключа?';

  @override
  String get openpgpBackUpProtected =>
      'Резервну копію захищено парольною фразою ключа. Будь-хто, хто має і те, і те, зможе читати вашу пошту.';

  @override
  String get openpgpBackUpUnprotected =>
      'Цей ключ не має парольної фрази: будь-хто з резервною копією зможе читати вашу пошту й підписувати від вашого імені.';

  @override
  String get openpgpBackUp => 'Створити копію';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Видалити ваш ключ $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Вилучити ключ $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Листи, зашифровані для цього ключа, більше не можна буде прочитати на цьому пристрої, якщо ви не імпортуєте його знову.';

  @override
  String get openpgpRemoveKeyMessage => 'Пізніше його можна імпортувати знову.';

  @override
  String get openpgpKeyHeader => 'Ключ OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Додайте ключ у розділі «Наскрізне шифрування», щоб шифрувати й підписувати листи з цієї адреси.';

  @override
  String get openpgpGenerateAKey => 'Створити ключ…';

  @override
  String get openpgpSending => 'Надсилання';

  @override
  String get openpgpSendingFooter =>
      'Автоматичне шифрування вмикається, коли в кожного одержувача є прийнятий ключ або довірений сертифікат, або коли Autocrypt повідомляє, що цього хочуть обидві сторони. Зашифровані листи завжди підписуються.';

  @override
  String get openpgpEncryptAutomatically => 'Шифрувати автоматично';

  @override
  String get openpgpAlwaysEncryptDetail => 'Не надсилає, якщо в одержувача немає ключа';

  @override
  String get openpgpSignUnencrypted => 'Підписувати незашифровані листи';

  @override
  String get openpgpAttachPublicKey => 'Додавати мій відкритий ключ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt надсилає ваш відкритий ключ із кожним листом, тож інші застосунки можуть шифрувати для вас без жодного налаштування.';

  @override
  String get openpgpSendMyKey => 'Надсилати мій ключ із листами';

  @override
  String get openpgpPreferEncryption => 'Віддавати перевагу шифруванню';

  @override
  String get openpgpPreferEncryptionDetail => 'Просити інших шифрувати, коли можуть';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count років',
      few: '$count роки',
      one: '$count рік',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Парольні фрази не збігаються.';

  @override
  String openpgpKeyReady(String id) {
    return 'Ваш ключ $id готовий.';
  }

  @override
  String get openpgpNewKey => 'Новий ключ';

  @override
  String get openpgpNewKeyFor => 'Для';

  @override
  String get openpgpYourName => 'Ваше ім’я';

  @override
  String get openpgpAddress => 'Адреса';

  @override
  String get openpgpPassphrase => 'Парольна фраза';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Необов’язково. Без неї ключ захищає лише сховище ключів телефона, і Loupe ніколи її не запитує. З нею Loupe запитуватиме її, коли знадобиться ключ.';

  @override
  String get openpgpRepeatPassphrase => 'Повторіть';

  @override
  String get openpgpExpires => 'Термін дії';

  @override
  String get openpgpExpiresFooter =>
      'Новий ключ можна створити ще до закінчення терміну дії. Thunderbird теж використовує три роки.';

  @override
  String get openpgpGenerateKey => 'Створити ключ';

  @override
  String get openpgpKeyFor => 'Ключ для';

  @override
  String get openpgpCantEncrypt => 'Не вдається зашифрувати';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Немає ключа OpenPGP для $names, а ця адреса завжди шифрує. Вилучіть одержувача або імпортуйте його ключ у розділі Налаштування › Наскрізне шифрування.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Немає дійсного сертифіката S/MIME для $names, а ця адреса завжди шифрує. Вилучіть одержувача або імпортуйте його сертифікат у розділі Налаштування › Наскрізне шифрування.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Немає ключа OpenPGP для $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Немає дійсного сертифіката S/MIME для $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Надіслати без шифрування';

  @override
  String get openpgpCantSign => 'Не вдається підписати';

  @override
  String get openpgpCantSignMessage =>
      'Закритого ключа вашого сертифіката S/MIME немає на цьому пристрої. Імпортуйте сертифікат ще раз (файл .p12 або .pfx) у розділі Налаштування › Наскрізне шифрування.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Немає ключа для $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Немає сертифіката для $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Ключі з Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Ключ є в усіх';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Сертифікат є в усіх';

  @override
  String get openpgpComposeEncrypt => 'Шифрувати';

  @override
  String get openpgpComposeSign => 'Підписати';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, перемкнути';
  }

  @override
  String get openpgpNoKeyFound => 'Ключ OpenPGP не знайдено.';

  @override
  String get openpgpImportSecretKeyTitle => 'Імпортувати секретний ключ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Це вкладення містить секретний ключ ($names). Імпортуйте його як власний ключ, лише якщо ви самі його експортували, наприклад із Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Імпортувати як мій ключ';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'ваш ключ $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортувати $count ключів ($names)?',
      few: 'Імпортувати $count ключі ($names)?',
      one: 'Імпортувати $count ключ ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Імпортувати й прийняти';

  @override
  String get openpgpImportDecideLater => 'Імпортувати, вирішити пізніше';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'ключ $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Імпортовано: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикріплено $count ключів OpenPGP.',
      few: 'Прикріплено $count ключі OpenPGP.',
      one: 'Прикріплено $count ключ OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Імпортувати';

  @override
  String get openpgpUnlockKeyTitle => 'Розблокувати ключ OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Введіть парольну фразу ключа $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Неправильна парольна фраза. Спробуйте ще раз.';

  @override
  String get openpgpExplainLocked => 'Цей лист зашифровано. Розблокуйте свій ключ OpenPGP, щоб прочитати його.';

  @override
  String get openpgpExplainNoKey =>
      'Цей лист зашифровано, але не для жодного ключа OpenPGP на цьому пристрої. Якщо ви читаєте його в Thunderbird, імпортуйте звідти свій ключ: Налаштування › Наскрізне шифрування.';

  @override
  String get openpgpExplainDamaged => 'Цей зашифрований лист пошкоджено, тож його не можна безпечно розшифрувати.';

  @override
  String get openpgpExplainUnsupported => 'Цей лист використовує шифрування, яке Loupe поки не вміє читати.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Цей лист зашифровано за допомогою S/MIME, але не для жодного сертифіката на цьому пристрої. Імпортуйте свій сертифікат (файл .p12 або .pfx) у розділі Налаштування › Наскрізне шифрування.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Цей лист зашифровано. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Розблокуйте свій сертифікат S/MIME, щоб прочитати його.';

  @override
  String get openpgpAttachmentGone => 'Це вкладення більше недоступне.';

  @override
  String get smimeEncrypted => 'Зашифровано (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Зашифровано (S/MIME) · немає сертифіката';

  @override
  String get smimeEncryptedDamaged => 'Зашифровано (S/MIME) · пошкоджено';

  @override
  String get smimeEncryptedUnsupported => 'Зашифровано (S/MIME) · не підтримується';

  @override
  String get smimeEncryptedLocked => 'Зашифровано (S/MIME) · заблоковано';

  @override
  String get smimeUnknownSigner => 'невідомий';

  @override
  String get smimeSignatureModified => 'Недійсний підпис: лист змінено';

  @override
  String get smimeSignatureWeak => 'Ненадійний підпис: застарілий алгоритм';

  @override
  String get smimeSignatureUncheckable => 'Не вдається перевірити підпис';

  @override
  String get smimeSignedCertificateMissing => 'Підписано · немає сертифіката';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Підписано: $name · сертифікат відкликано';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Підписано: $name · в іншу дату';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Підписано: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Підписано: $name · недійсний сертифікат';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Підписано: $name · немає довіри';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Підписано: $name · термін дії сертифіката минув';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Підписано: $name · сертифікат ще не дійсний';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Підписано: $name · сертифікат не для пошти';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Підписано: $name, а не відправник';
  }

  @override
  String get smimeCantDecrypt => 'Не вдається розшифрувати цей лист';

  @override
  String get smimeEncryptedWithSmime => 'Зашифровано за допомогою S/MIME';

  @override
  String get smimeEncryption => 'Шифрування';

  @override
  String get smimeDecryptedHere => 'Розшифровано на цьому пристрої';

  @override
  String get smimeNotDecrypted => 'Не розшифровано';

  @override
  String get smimeAuthenticated => 'з автентифікацією';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'для $count сертифікатів',
      few: 'для $count сертифікатів',
      one: 'для $count сертифіката',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Підпис';

  @override
  String get smimeIssuedBy => 'Ким видано';

  @override
  String get smimeValid => 'Дійсний';

  @override
  String smimeValidRange(String from, String to) {
    return 'з $from до $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Відбиток SHA-256';

  @override
  String get smimeSigned => 'Підписано';

  @override
  String get smimeProblem => 'Проблема';

  @override
  String get smimeCheckingRevocation => 'Перевірка відкликання…';

  @override
  String get smimeNotRevoked => 'Не відкликано';

  @override
  String get smimeRevoked => 'Відкликано';

  @override
  String get smimeRevocationUnknown => 'Стан відкликання невідомий';

  @override
  String smimeRevokedSince(String date) {
    return 'З $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Запит до центру сертифікації (список відкликання), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Запит до центру сертифікації (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Довіряти «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Довіряти цьому сертифікату…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Перевірено на цьому пристрої за допомогою S/MIME, сумісно з Outlook і Thunderbird; відкликання — у центрі сертифікації.';

  @override
  String get smimeCheckedFooter =>
      'Перевірено на цьому пристрої за допомогою S/MIME, сумісно з Outlook і Thunderbird. Відкликання не перевіряється (Налаштування › Наскрізне шифрування).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Довіряти $name для пошти?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Довіряти сертифікату $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Довіра поширюватиметься на кожен сертифікат, виданий цим центром, як-от центром сертифікації вашої компанії. Спершу звірте відбиток із власником:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Спершу звірте відбиток із власником:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Довіряти';

  @override
  String get smimeSummaryNoKey => 'Його зашифровано для сертифіката, якого немає на цьому пристрої.';

  @override
  String get smimeSummaryDamaged => 'Зашифровані дані пошкоджено або змінено дорогою.';

  @override
  String get smimeSummaryUnsupported => 'Він використовує алгоритм, який Loupe не підтримує.';

  @override
  String get smimeSummaryLocked => 'Ваш сертифікат S/MIME заблоковано.';

  @override
  String get smimeSummaryEncrypted => 'Прочитати його можете лише ви та інші одержувачі.';

  @override
  String get smimeSummaryNotSigned => 'Він не підписаний, тож відправника не підтверджено.';

  @override
  String get smimeSummaryModified => 'Підпис не збігається: лист змінили після підписання.';

  @override
  String get smimeSummaryUncheckable => 'Підпис не вдається перевірити.';

  @override
  String get smimeSummaryNoCertificate => 'Сертифіката підписанта немає в листі, тож його не вдається перевірити.';

  @override
  String get smimeSummaryRevoked => 'Центр сертифікації відкликав сертифікат підписанта: підпису не можна довіряти.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Центр сертифікації відкликав сертифікат підписанта ($reason): підпису не можна довіряти.';
  }

  @override
  String get smimeDateMismatch =>
      'Його підписано більш ніж за годину від дати листа: можливо, це старий лист, надісланий повторно.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Підпис дійсний, і $issuer засвідчує, що сертифікат належить відправникові.';
  }

  @override
  String get smimeProblemInvalidChain => 'Сертифікат або один із його видавців недійсний.';

  @override
  String get smimeProblemUntrusted => 'Сертифікат видано центром, якому Loupe не довіряє.';

  @override
  String get smimeProblemExpired => 'Термін дії сертифіката минув.';

  @override
  String get smimeProblemNotYetValid => 'Сертифікат ще не був дійсним.';

  @override
  String get smimeProblemWrongUsage => 'Сертифікат не призначений для пошти.';

  @override
  String get smimeProblemWrongAddress => 'Сертифікат належить не адресі відправника, а іншій.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Довірений · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Недовірений · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Термін дії минув $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Дійсний з $date';
  }

  @override
  String get smimeTrustInvalid => 'Недійсний';

  @override
  String get smimeTrustNotForMail => 'Не для пошти';

  @override
  String get smimeTrustAnotherAddress => 'Інша адреса';

  @override
  String get smimeMyCertificates => 'Мої сертифікати S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Для S/MIME, як його використовують Outlook і багато компаній. Імпортуйте свій сертифікат разом із закритим ключем (файл .p12 або .pfx), експортований з Outlook, Windows, macOS чи Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Для S/MIME, як його використовують Outlook і багато компаній. Імпортуйте свій сертифікат разом із закритим ключем (файл .p12 або .pfx), експортований з Outlook, Windows, macOS чи Thunderbird, або скористайтеся сертифікатом, який ви чи ваша компанія встановили на цьому пристрої.';

  @override
  String get smimeCertificateExpired => 'термін дії минув';

  @override
  String smimeCertificateUntil(String date) {
    return 'до $date';
  }

  @override
  String get smimeCertificateOnDevice => 'на цьому пристрої';

  @override
  String get smimeImportCertificateEllipsis => 'Імпортувати сертифікат…';

  @override
  String get smimeUseDeviceCertificate => 'Використати сертифікат із цього пристрою…';

  @override
  String get smimeCorrespondentsCertificates => 'Сертифікати співрозмовників';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Зібрано з підписаних листів, як це роблять Outlook і Thunderbird. Листи шифруються лише для довірених сертифікатів: Loupe довіряє центрам сертифікації, яким Mozilla довіряє для пошти, і тим, які додали ви.';

  @override
  String get smimeRevocation => 'Відкликання';

  @override
  String get smimeRevocationFooter =>
      'Коли ви відкриваєте підписаний лист, Loupe запитує центр, що видав сертифікат підписанта, чи не відкликано його (через його OCSP-сервер або список відкликання). Тож центр може бачити, коли хтось із вашої інтернет-адреси читає листи, підписані цим сертифікатом. Відповіді зберігаються на цьому пристрої, доки не застаріють. Відкликаний сертифікат позначається в заголовку листа як «сертифікат відкликано».';

  @override
  String get smimeCheckRevocation => 'Перевіряти відкликання сертифікатів онлайн';

  @override
  String get smimeTrustedAuthorities => 'Довірені центри сертифікації';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ті, яким довіряєте ви, окрім $count центрів, яким Mozilla довіряє для пошти.',
      few: 'Ті, яким довіряєте ви, окрім $count центрів, яким Mozilla довіряє для пошти.',
      one: 'Ті, яким довіряєте ви, окрім $count центру, якому Mozilla довіряє для пошти.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Центр сертифікації';

  @override
  String get smimeImportACertificate => 'Імпортувати сертифікат';

  @override
  String get smimeImportContactMessage => 'Сертифікат співрозмовника (.cer, .crt, .pem) або центру сертифікації.';

  @override
  String get smimeFromClipboard => 'З буфера обміну';

  @override
  String get smimeFromFile => 'З файлу';

  @override
  String get smimeClipboardEmpty => 'Буфер обміну порожній. Спершу скопіюйте сертифікат.';

  @override
  String get smimeCertificate => 'Сертифікат';

  @override
  String get smimeOnDeviceFooter =>
      'Його закритий ключ залишається у сховищі облікових даних Android, де його встановили ви чи ваша компанія: Loupe просить Android підписувати й розшифровувати ним. Підписані листи підписуються під час надсилання.';

  @override
  String get smimeAddresses => 'Адреси';

  @override
  String get smimeUsage => 'Призначення';

  @override
  String get smimeUsageNone => 'Нічого, що використовує Loupe';

  @override
  String get smimeUsageSigning => 'Підписування';

  @override
  String get smimeUsageEncryption => 'Шифрування';

  @override
  String get smimeUsageCertificates => 'Сертифікати';

  @override
  String get smimeAlgorithm => 'Алгоритм';

  @override
  String get smimeSerialNumber => 'Серійний номер';

  @override
  String get smimeFingerprintCopied => 'Відбиток скопійовано.';

  @override
  String get smimeSha1Thumbprint => 'Відбиток SHA-1';

  @override
  String get smimePrivateKey => 'Закритий ключ';

  @override
  String get smimeKeyOnDevice => 'На цьому пристрої';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'У Loupe, з парольною фразою';

  @override
  String get smimeKeyInLoupe => 'У Loupe';

  @override
  String get smimeSource => 'Джерело';

  @override
  String get smimeSourceSignedMail => 'Підписаний лист';

  @override
  String get smimeSourceImported => 'Імпортовано';

  @override
  String get smimeTrustHeader => 'Довіра';

  @override
  String get smimeTrustedRoot => 'Довірений кореневий';

  @override
  String get smimeIssuer => 'Видавець';

  @override
  String smimeTrustNamed(String name) {
    return 'Довіряти «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Довіряти цьому центру';

  @override
  String get smimeTrustThisCertificate => 'Довіряти цьому сертифікату';

  @override
  String get smimeStopTrusting => 'Більше не довіряти';

  @override
  String get smimePassphrase => 'Парольна фраза';

  @override
  String get smimePassphraseFooter =>
      'Необов’язково. З парольною фразою закритий ключ додатково шифрується на цьому пристрої (Argon2id і AES-256), і Loupe запитує її, щоб підписувати й розшифровувати; як довго — визначає «Запам’ятовувати парольні фрази». Листи підписуються під час надсилання; фонові процеси не можуть використовувати ключ.';

  @override
  String get smimeChangePassphrase => 'Змінити парольну фразу…';

  @override
  String get smimeSetPassphraseEllipsis => 'Установити парольну фразу…';

  @override
  String get smimeRemovePassphrase => 'Вилучити парольну фразу';

  @override
  String get smimeShareCertificate => 'Поділитися сертифікатом';

  @override
  String get smimeDeleteCertificate => 'Видалити сертифікат';

  @override
  String get smimeRemoveCertificate => 'Вилучити сертифікат';

  @override
  String get smimePassphraseChanged => 'Парольну фразу змінено.';

  @override
  String get smimePassphraseSet => 'Парольну фразу встановлено.';

  @override
  String get smimeRemovePassphraseTitle => 'Вилучити парольну фразу?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Тоді закритий ключ захищатиме лише сховище ключів, як і без парольної фрази: Loupe більше не запитуватиме її, а фонові процеси зможуть використовувати ключ.';

  @override
  String get smimePassphraseRemoved => 'Парольну фразу вилучено.';

  @override
  String smimeTrustTitle(String name) {
    return 'Довіряти $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Кожен виданий ним сертифікат вважатиметься довіреним для пошти. Спершу звірте відбиток із власником:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Видалити ваш сертифікат $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Вилучити сертифікат $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe перестане його використовувати: листи, зашифровані для нього, більше не можна буде прочитати в Loupe. Сертифікат залишиться на цьому пристрої (Налаштування › Безпека › Шифрування та облікові дані).';

  @override
  String get smimeDeleteOwnMessage =>
      'Його закритий ключ буде видалено з цього пристрою: листи, зашифровані для нього, більше не можна буде прочитати тут, якщо ви не імпортуєте його знову.';

  @override
  String get smimeRemoveContactMessage => 'Він повернеться з наступним підписаним листом цієї людини.';

  @override
  String get smimeAddressImportFooter =>
      'Імпортуйте сертифікат для цієї адреси, щоб підписувати й шифрувати за допомогою S/MIME, як це робить Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Імпортувати сертифікат…';

  @override
  String get smimePreferFooter =>
      'Коли захистити лист можуть обидва стандарти, використовується бажаний, якщо тільки ключ чи сертифікат для кожного одержувача не має лише інший.';

  @override
  String get smimePreferSmime => 'Віддавати перевагу S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Замість OpenPGP';

  @override
  String get smimeCertificatePassword => 'Пароль сертифіката';

  @override
  String get smimeCertificatePasswordPrompt => 'Введіть пароль, з яким експортовано файл сертифіката.';

  @override
  String get smimeImport => 'Імпортувати';

  @override
  String get smimeWrongPassword => 'Неправильний пароль. Спробуйте ще раз.';

  @override
  String get smimeNoCertificateFound => 'Сертифікат не знайдено.';

  @override
  String smimeCertificateOf(String name) {
    return 'сертифікат $name';
  }

  @override
  String get smimeNothingNew => 'Немає нічого нового для імпорту.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Імпортовано: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортовано $count довірених центрів сертифікації.',
      few: 'Імпортовано $count довірені центри сертифікації.',
      one: 'Імпортовано $count довірений центр сертифікації.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Імпортовано: $certificates і $count довірених центрів сертифікації.',
      few: 'Імпортовано: $certificates і $count довірені центри сертифікації.',
      one: 'Імпортовано: $certificates і $count довірений центр сертифікації.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'У цьому файлі немає закритого ключа. Експортуйте сертифікат разом із закритим ключем.';

  @override
  String get smimeImportAsYoursTitle => 'Імпортувати як ваш сертифікат?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Це вкладення містить сертифікат із закритим ключем: $names. Імпортуйте його, лише якщо ви самі його експортували, наприклад з Outlook чи Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Імпортувати як мій сертифікат';

  @override
  String smimeImportedOwn(String names) {
    return 'Імпортовано ваш сертифікат $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Додано ваш сертифікат $name ($addresses) із цього пристрою.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Довіряти «$name» для пошти?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe не знає цього центру сертифікації (можливо, це власний центр якоїсь компанії). Довіртеся йому, щоб перевіряти видані ним сертифікати. Спершу звірте його відбиток зі своїм ІТ-відділом:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прикріплено $count сертифікатів.',
      few: 'Прикріплено $count сертифікати.',
      one: 'Прикріплено $count сертифікат.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Імпортувати сертифікат';

  @override
  String get smimeUnlockTitle => 'Розблокувати сертифікат S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Введіть парольну фразу сертифіката $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Неправильна парольна фраза. Спробуйте ще раз.';

  @override
  String get smimeUnlock => 'Розблокувати';

  @override
  String get smimeEnterAPassphrase => 'Введіть парольну фразу.';

  @override
  String get smimePassphrasesDiffer => 'Парольні фрази відрізняються.';

  @override
  String get smimeSetPassphraseTitle => 'Установити парольну фразу';

  @override
  String get smimeSetPassphraseText =>
      'Loupe запитуватиме її, щоб підписувати й розшифровувати. Якщо ви її забудете, імпортуйте сертифікат знову з файлу .p12.';

  @override
  String get smimePassphraseAgain => 'Ще раз';

  @override
  String get smimeSetPassphraseButton => 'Установити';

  @override
  String get smimeLockedOpenAgain => 'Ваш сертифікат S/MIME заблоковано. Відкрийте лист знову, щоб розблокувати його.';

  @override
  String get smimeDeviceHasNoCertificates => 'Цей пристрій не надає своїх сертифікатів.';

  @override
  String get smimeCantReadCertificate => 'Loupe не може прочитати цей сертифікат.';

  @override
  String get smimeCertificateNotForMail =>
      'Цей сертифікат не для пошти: у ньому немає адреси електронної пошти або він не призначений для підписування чи шифрування.';

  @override
  String get smimeDeviceCertificateGone =>
      'Сертифіката більше немає на цьому пристрої, або Loupe більше не може його використовувати. Виберіть його знову в розділі Налаштування › Наскрізне шифрування.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Сертифікат на цьому пристрої можна використовувати, лише поки Loupe відкритий.';

  @override
  String get smimeDeviceKeyDamaged => 'Зашифрований ключ пошкоджено.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Сертифікат на цьому пристрої не може цього зробити: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'не підтримується';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Помилка сертифіката на цьому пристрої: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Адреса центру сертифікації не є вебадресою.';

  @override
  String get smimeAuthorityTimeout => 'Центр сертифікації не відповів вчасно.';

  @override
  String get smimeAuthorityUnreachable => 'Не вдалося зв’язатися з центром сертифікації.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Центр сертифікації відповів кодом $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Відповідь центру сертифікації завелика.';

  @override
  String get smimeRevocationNotChecked =>
      'Не перевірено: перевіряються лише сертифікати від центрів, яким довіряє Loupe.';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageSystem => 'Як на телефоні';

  @override
  String get settingsLanguageFooter =>
      'Loupe використовує мову телефона, якщо підтримує її, а інакше — англійську. Мова, яку ви виберете тут, діятиме лише для Loupe, зокрема для сповіщень.';

  @override
  String get settingsAccountsHeader => 'Облікові записи';

  @override
  String get settingsAddAccount => 'Додати обліковий запис';

  @override
  String get settingsMailHeader => 'Пошта';

  @override
  String get settingsSwipeActions => 'Дії свайпу';

  @override
  String get settingsSwipeLeft => 'Свайп ліворуч';

  @override
  String get settingsSwipeLeftFooter =>
      'Повний свайп виконує цю дію. «Позначити прапорцем» і «Більше» завжди доступні коротким свайпом.';

  @override
  String get settingsSwipeRight => 'Свайп праворуч';

  @override
  String get settingsSwipeRightFooter => 'Повний свайп виконує цю дію.';

  @override
  String get settingsSwipeToggleRead => 'Позначити як прочитане / непрочитане';

  @override
  String get settingsSwipeTrash => 'У кошик';

  @override
  String get settingsSwipeMove => 'Перемістити лист';

  @override
  String get settingsSwipeSnooze => 'Відкласти';

  @override
  String get settingsThreaded => 'Групувати за розмовами';

  @override
  String get settingsUndoSendDelay => 'Час на скасування надсилання';

  @override
  String get settingsUndoSendDelayFooter => 'Надіслані листи чекають стільки часу, щоб ви могли їх відкликати.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds секунд',
      few: '$seconds секунди',
      one: '$seconds секунда',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Вигляд';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSystem => 'Автоматично';

  @override
  String get settingsThemeLight => 'Світла';

  @override
  String get settingsThemeDark => 'Темна';

  @override
  String get settingsDensity => 'Список листів';

  @override
  String get settingsDensityComfortable => 'Просторий';

  @override
  String get settingsDensityCompact => 'Компактний';

  @override
  String get settingsReadingHeader => 'Читання';

  @override
  String get settingsReadingFooter =>
      'Віддалені зображення можуть повідомляти відправникам, коли й де ви відкрили лист.';

  @override
  String get settingsDefaultView => 'Типовий вигляд';

  @override
  String get settingsDefaultViewFooter => 'Будь-який лист можна перемкнути кнопкою Aa.';

  @override
  String get settingsViewReadable => 'Для читання';

  @override
  String get settingsViewReadableDetail => 'Чисто, розбірливо, з підтримкою темного режиму';

  @override
  String get settingsViewOriginal => 'Оригінал';

  @override
  String get settingsViewOriginalDetail => 'Точно так, як задумав відправник';

  @override
  String get settingsViewPlain => 'Простий текст';

  @override
  String get settingsViewPlainDetail => 'Лише слова';

  @override
  String get settingsPlainTextFont => 'Шрифт простого тексту';

  @override
  String get settingsFontSans => 'Без зарубок';

  @override
  String get settingsFontMono => 'Моноширинний';

  @override
  String get settingsFontMonoDetail => 'Зберігає вирівнювання ASCII-графіки й таблиць';

  @override
  String get settingsTechnicalLists => 'Технічні списки розсилки';

  @override
  String get settingsLoadRemoteImages => 'Завантажувати віддалені зображення';

  @override
  String get settingsOpenLinksDirectly => 'Відкривати посилання напряму';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Оминати трекери натискань, коли адреса відома';

  @override
  String get settingsSecurityHeader => 'Безпека';

  @override
  String get settingsAppLock => 'Блокування застосунку';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe запитує під час запуску, а також коли ви повертаєтеся після відсутності, довшої за час у «Блокувати через».';

  @override
  String get settingsAppLockFooterOff =>
      'Блокування застосунку запитує відбиток пальця, обличчя чи блокування екрана, перш ніж показати пошту.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Блокування застосунку досі вимкнено. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Налаштуйте код-пароль';

  @override
  String get settingsScreenLockTextIos =>
      'Блокування застосунку використовує Face ID, Touch ID або код-пароль, а на цьому iPhone код-пароль не встановлено. Установіть його в застосунку «Параметри», а потім увімкніть блокування застосунку.';

  @override
  String get settingsScreenLockTitleAndroid => 'Налаштуйте блокування екрана';

  @override
  String get settingsScreenLockTextAndroid =>
      'Блокування застосунку використовує блокування екрана телефона або доданий до нього відбиток пальця чи обличчя, а на цьому телефоні його немає. Налаштуйте PIN-код, ключ або пароль у налаштуваннях Android, а потім увімкніть блокування застосунку.';

  @override
  String get settingsOpenSystemSettings => 'Відкрити налаштування';

  @override
  String get settingsOpenAndroidSettings => 'Відкрити налаштування Android';

  @override
  String get settingsLockAfter => 'Блокувати через';

  @override
  String get settingsLockAfterFooter => 'Як довго Loupe може бути у фоновому режимі, перш ніж знову запитати.';

  @override
  String get settingsNotifications => 'Сповіщення';

  @override
  String get settingsEncryption => 'Наскрізне шифрування';

  @override
  String get settingsAdvanced => 'Додатково';

  @override
  String get settingsDemoHeader => 'Демо';

  @override
  String get settingsDemoFooter =>
      'Демопошта — це вигадана скринька, що існує лише на цьому телефоні. Нічого нікуди не надсилається.';

  @override
  String get settingsDemoMode => 'Демонстраційний режим';

  @override
  String get settingsResetApp => 'Скинути застосунок';

  @override
  String get settingsResetFooter => 'Забуває всі налаштування й повертає до екрана привітання.';

  @override
  String get settingsResetTitle => 'Скинути Loupe?';

  @override
  String get settingsResetMessage =>
      'Буде забуто всі налаштування, скриньки Smart Mailbox і недавні пошуки, а застосунок повернеться до екрана привітання.';

  @override
  String get settingsAboutHeader => 'Про застосунок';

  @override
  String get settingsVersion => 'Версія';

  @override
  String get settingsLicences => 'Ліцензії';

  @override
  String get settingsPrivacy => 'Конфіденційність';

  @override
  String get settingsPrivacyDetail =>
      'У Loupe немає аналітики й стеження. Ваша пошта йде лише на ваші поштові сервери.';

  @override
  String get settingsNotificationsOffIos => 'Сповіщення для Loupe вимкнено в «Параметрах».';

  @override
  String get settingsNotificationsOffAndroid => 'Сповіщення для Loupe вимкнено в налаштуваннях Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system не дозволяє Loupe показувати сповіщення. Дозвольте їх у налаштуваннях.';
  }

  @override
  String get settingsNewMailHeader => 'Нова пошта';

  @override
  String get settingsNewMailFooterDemo =>
      'Демопошта не надходить у фоновому режимі. Надішліть тестове сповіщення, щоб побачити, як виглядає нова пошта.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe перевіряє нову пошту у фоновому режимі, коли це дозволяє iOS, а для застосунків, які ви відкриваєте нечасто, між перевірками можуть минати години. Ви отримуєте сповіщення про нові листи у вхідних, а також від VIP у будь-якій теці.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe перевіряє нову пошту приблизно кожні 15 хвилин, коли це дозволяє Android. Ви отримуєте сповіщення про нові листи у вхідних, а також від VIP у будь-якій теці.';

  @override
  String get settingsNoAccounts => 'Немає облікових записів';

  @override
  String get settingsVipOnly => 'Лише VIP';

  @override
  String get settingsVipOnlyDetail => 'Лише листи від ваших VIP';

  @override
  String get settingsHideContent => 'Приховувати вміст';

  @override
  String get settingsHideContentFooterOn =>
      'Сповіщення показують лише «Новий лист від» і обліковий запис, а не хто написав і про що.';

  @override
  String get settingsHideContentFooterOff =>
      '«Приховувати вміст» прибирає відправника, тему й попередній перегляд із заблокованого екрана та сповіщень.';

  @override
  String get settingsBackgroundAppRefresh => 'Фонове оновлення програм';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Нова пошта надходить у фоновому режимі, лише коли для Loupe ввімкнено «Фонове оновлення програм» у «Параметрах». iOS не може тримати відкритим з’єднання з вашими вхідними, тож миттєвої доставки немає.';

  @override
  String get settingsInstantDelivery => 'Миттєва доставка';

  @override
  String get settingsInstantDeliveryFooter =>
      'Миттєва доставка (експериментальна) тримає відкритим з’єднання з вашими вхідними, тож нова пошта надходить за лічені секунди. Вона показує тихе сповіщення «Очікування нової пошти» й витрачає більше заряду батареї.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android може зупиняти миттєву доставку, щоб заощадити заряд. Дозвольте Loupe використовувати батарею без обмежень, щоб доставка працювала.';

  @override
  String get settingsExperimental => 'Експериментальне';

  @override
  String get settingsComingSoon => 'Незабаром';

  @override
  String get settingsAllowUnrestrictedBattery => 'Дозволити необмежене використання батареї';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push дає новій пошті змогу одразу розбудити Loupe, якщо ваша поштова служба це підтримує. Push-сповіщення йдуть через службу push від Google і не несуть пошти, лише «перевір зараз».';

  @override
  String get settingsPushUnavailableFooter =>
      'Цей телефон не може отримувати push-сповіщення: для них потрібні служби Google Play і з’єднання з мережею. Loupe усе одно перевіряє пошту приблизно кожні 15 хвилин.';

  @override
  String get settingsCopyPushToken => 'Копіювати push-токен';

  @override
  String get settingsPushTokenCopied => 'Push-токен скопійовано';

  @override
  String get settingsSendTestNotification => 'Надіслати тестове сповіщення';

  @override
  String get settingsAppIconBadge => 'Лічильник на значку';

  @override
  String get settingsBadgeNote =>
      'Лічильник оновлюється щоразу, коли Loupe перевіряє пошту, зокрема у фоновому режимі.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Головний екран цього телефона не показує числа на значках застосунків. Лічильник оновлюється щоразу, коли Loupe перевіряє пошту, зокрема у фоновому режимі.';

  @override
  String get settingsTestNotificationBody => 'Так виглядають сповіщення про нову пошту.';

  @override
  String get settingsAccountRemoved => 'Цей обліковий запис вилучено.';

  @override
  String get settingsAccountHeader => 'Обліковий запис';

  @override
  String get settingsAccountDescription => 'Опис';

  @override
  String get settingsAccountDescriptionHint => 'Робота, особисте…';

  @override
  String get settingsEmail => 'Ел. пошта';

  @override
  String get settingsColour => 'Колір';

  @override
  String get settingsColourFooter => 'Позначає листи цього облікового запису в «Усіх вхідних».';

  @override
  String settingsColourNumber(int number) {
    return 'Колір $number';
  }

  @override
  String get settingsSendingHeader => 'Надсилання';

  @override
  String get settingsSendingFooter =>
      'Кожен профіль відправника має власний підпис. Відповіді надсилаються з тієї адреси, на яку надійшов лист.';

  @override
  String get settingsFoldersHeader => 'Теки';

  @override
  String get settingsFoldersFooter =>
      'Loupe показує й синхронізує теки, на які ви підписані, як і Thunderbird. «Вхідні», «Чернетки», «Надіслані», «Спам», «Кошик» і «Архів» показуються завжди.';

  @override
  String get settingsShowAllFolders => 'Показувати всі теки';

  @override
  String get settingsIncoming => 'Вхідна пошта';

  @override
  String get settingsOutgoing => 'Вихідна пошта';

  @override
  String get settingsConnectionNotEncrypted => 'Без шифрування';

  @override
  String get settingsSignIn => 'Вхід';

  @override
  String get settingsSignInExpired => 'Термін дії минув';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider більше не приймає вхід Loupe для цього облікового запису, тож його пошта не синхронізується. Увійдіть знову, щоб це виправити.';
  }

  @override
  String get settingsSignInAgain => 'Увійти знову';

  @override
  String get settingsSigningIn => 'Вхід…';

  @override
  String get settingsRemoveAccount => 'Вилучити обліковий запис';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Вилучити «$account»?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Його пошту й налаштування буде вилучено з цього телефона. На сервері нічого не видаляється.';

  @override
  String get settingsManageFolders => 'Керування теками';

  @override
  String get settingsNoFolders => 'Тек поки немає.';

  @override
  String get settingsManageFoldersFooter =>
      'Теки, на які ви підписані, показуються на екрані «Скриньки» й синхронізуються у фоновому режимі. Інші поштові застосунки з тим самим обліковим записом зазвичай теж дотримуються цих підписок.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Зберігає ваші скриньки Smart Mailbox для інших пристроїв. Прихована на екрані «Скриньки».';

  @override
  String get settingsFolderAlwaysShown => 'Показується завжди';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Підписатися на $folder';
  }

  @override
  String get settingsIdentities => 'Профілі відправника';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Перший профіль використовується за замовчуванням для нових листів. Перетягніть, щоб змінити порядок.';

  @override
  String get settingsIdentitiesFooterSingle => 'Профіль за замовчуванням для нових листів.';

  @override
  String get settingsIdentitiesReplyFooter => 'Відповідь надсилається з профілю, на адресу якого надійшов лист.';

  @override
  String get settingsIdentityDefault => 'За замовчуванням';

  @override
  String settingsIdentityReorder(String email) {
    return 'Змінити порядок: $email';
  }

  @override
  String get settingsAddIdentity => 'Додати профіль';

  @override
  String get settingsNewIdentity => 'Новий профіль';

  @override
  String get settingsIdentity => 'Профіль відправника';

  @override
  String get settingsIdentityNameHint => 'Ваше ім’я';

  @override
  String get settingsReplyTo => 'Відповідати на';

  @override
  String get settingsSignature => 'Підпис';

  @override
  String get settingsSignatureFooter => 'Додається під «-- » у листах із цього профілю.';

  @override
  String get settingsNoSignature => 'Без підпису';

  @override
  String get settingsCopyToMyself => 'Копія собі';

  @override
  String get settingsCopyToMyselfFooter => 'Додається до кожного листа з цього профілю.';

  @override
  String get settingsCc => 'Копія';

  @override
  String get settingsBcc => 'Прихована копія';

  @override
  String get settingsReplyPatterns => 'Використовувати для відповідей на';

  @override
  String get settingsReplyPatternsFooter =>
      'Відповіді на листи, надіслані на ці адреси, надсилаються з цього профілю. * означає будь-що: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Адреса або шаблон, де * означає будь-що.';

  @override
  String get settingsAddReplyPattern => 'Додати адресу або шаблон';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Вилучити $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Недійсний шаблон';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '«$input» — не адреса й не шаблон на кшталт *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Немає адреси';

  @override
  String get settingsIdentityNoAddressMessage => 'Введіть адресу електронної пошти, з якої надсилати.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Недійсна адреса';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Відповідати на: «$address» — недійсна адреса електронної пошти.',
      'cc': 'Копія: «$address» — недійсна адреса електронної пошти.',
      'bcc': 'Прихована копія: «$address» — недійсна адреса електронної пошти.',
      'other': '«$address» — недійсна адреса електронної пошти.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Зберегти профіль';

  @override
  String get settingsDiscardChanges => 'Відкинути зміни';

  @override
  String get settingsDeleteIdentity => 'Видалити профіль';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Видалити «$email»?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Уже надіслані з нього листи залишаться без змін.';

  @override
  String get settingsLastIdentityFooter => 'Обліковому запису потрібен принаймні один профіль.';

  @override
  String get rulesTitle => 'Правила';

  @override
  String get rulesNewRule => 'Нове правило';

  @override
  String get rulesLoadError => 'Не вдалося завантажити правила.';

  @override
  String get rulesEmptyTitle => 'Немає правил';

  @override
  String get rulesEmptyText =>
      'Правила розкладають нові листи по теках, додають мітки й прапорці за вас. Створіть правило кнопкою вгорі або з пошуку через «Створити з цього правило».';

  @override
  String get rulesListFooter =>
      'Правила застосовуються згори донизу до нових листів у «Вхідних». Торкніться правила й утримуйте, щоб перемістити його.';

  @override
  String get rulesChangeError => 'Не вдалося змінити правило';

  @override
  String get rulesConditionEveryMessage => 'Кожен лист';

  @override
  String rulesMoveRule(String rule) {
    return 'Перемістити $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule увімкнено';
  }

  @override
  String get rulesServerRulesHeader => 'Правила на сервері';

  @override
  String get rulesServerRulesFooter =>
      'Правила на сервері виконуються на поштовому сервері під час надходження пошти, навіть коли цей телефон вимкнено. Вони зберігаються у скрипті Sieve з назвою «loupe».';

  @override
  String get rulesStatusUnknown => 'Невідомо';

  @override
  String get rulesStatusError => 'Не вдалося опитати сервер.';

  @override
  String get rulesStatusChecking => 'Перевірка…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Запускаються з «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Активний скрипт — «$script». Торкніться, щоб він запускав і правила Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'На сервері немає активного скрипту. Збереження правила на сервері ввімкне скрипт Loupe.';

  @override
  String get rulesStatusUnavailable => 'Недоступно';

  @override
  String get rulesStatusNoSieve => 'Сервер цього облікового запису не підтримує Sieve (ManageSieve або JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Перемістити в $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Перемістити в теку';

  @override
  String rulesActionTag(String tag) {
    return 'Додати мітку $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Зняти мітку $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Залишити у «Вхідних»';

  @override
  String rulesActionForward(String address) {
    return 'Переслати на $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Переслати на $address без копії';
  }

  @override
  String get rulesActionStop => 'Зупинити';

  @override
  String get rulesNoActions => 'Поки нічого не робить';

  @override
  String get rulesLocationDevice => 'Пристрій';

  @override
  String get rulesLocationServer => 'Сервер';

  @override
  String get rulesLocationThisDevice => 'Цей пристрій';

  @override
  String get rulesNewRuleTitle => 'Нове правило';

  @override
  String get rulesEditRuleTitle => 'Редагувати правило';

  @override
  String get rulesDefaultNameEveryMessage => 'Кожен лист';

  @override
  String get rulesConditionHeader => 'Коли новий лист відповідає';

  @override
  String get rulesConditionFooter =>
      'Пишіть так само, як у пошуку: from:, to:, s: (тема), b: (текст), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:рахунок';

  @override
  String get rulesAccounts => 'Облікові записи';

  @override
  String get rulesAllAccounts => 'Усі облікові записи';

  @override
  String get rulesRemovedAccount => 'Вилучений обліковий запис';

  @override
  String get rulesAccountsFooter => 'Правило для всіх облікових записів охоплює й ті, які ви додасте пізніше.';

  @override
  String get rulesActionsHeader => 'Тоді';

  @override
  String get rulesForwardingFooter =>
      'Пересилання надсилає кожен відповідний лист на іншу адресу одразу після надходження, навіть коли цей телефон вимкнено. Деякі провайдери обмежують обсяг пересилання.';

  @override
  String get rulesForwardingHiddenFooter => 'Пересилання працює лише в правилах на сервері, тому тут його не показано.';

  @override
  String rulesRemoveAction(String action) {
    return 'Вилучити $action';
  }

  @override
  String get rulesAddAction => 'Додати дію';

  @override
  String get rulesAddMove => 'Перемістити в теку…';

  @override
  String get rulesAddTagMenu => 'Додати мітку…';

  @override
  String get rulesRemoveTagMenu => 'Зняти мітку…';

  @override
  String get rulesAddForward => 'Переслати на…';

  @override
  String get rulesStopProcessing => 'Не застосовувати наступні правила';

  @override
  String get rulesRunOnHeader => 'Де виконувати';

  @override
  String get rulesRunOnDeviceFooter =>
      'Цей пристрій застосовує правило до нових листів у «Вхідних» щоразу, коли Loupe перевіряє пошту.';

  @override
  String get rulesRunOnServerFooter =>
      'Поштовий сервер застосовує правило під час надходження пошти, навіть коли цей телефон вимкнено. Потрібен Sieve через ManageSieve (Dovecot, mailcow) або JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Застосувати до наявних листів…';

  @override
  String get rulesDeleteRule => 'Видалити правило';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Видалити «$rule»?';
  }

  @override
  String get rulesMoveAccountTitle => 'Тека в якому обліковому записі?';

  @override
  String get rulesMoveAccountMessage => 'Пошта інших облікових записів потрапить там у теку з такою самою назвою.';

  @override
  String get rulesAddTag => 'Додати мітку';

  @override
  String get rulesRemoveTag => 'Зняти мітку';

  @override
  String get rulesForwardTo => 'Переслати на';

  @override
  String get rulesForwardToMessage =>
      'Сервер пересилатиме кожен відповідний лист на цю адресу, навіть коли цей телефон вимкнено. Використовуйте адресу, яка належить вам або якій ви довіряєте.';

  @override
  String get rulesNotAnAddressTitle => 'Це не адреса електронної пошти';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '«$address» — не адреса для пересилання.';
  }

  @override
  String get rulesKeepCopyTitle => 'Зберігати копію тут?';

  @override
  String get rulesKeepCopy => 'Зберігати копію';

  @override
  String get rulesDontKeepCopy => 'Не зберігати копію';

  @override
  String get rulesCheckCondition => 'Перевірте умову';

  @override
  String get rulesChooseActionTitle => 'Виберіть дію';

  @override
  String get rulesChooseActionMessage => 'Додайте, що правило робить із листами, які відповідають умові.';

  @override
  String get rulesSaveError => 'Не вдалося зберегти правило';

  @override
  String get rulesSaveServerError => 'Не вдалося зберегти правило на сервері';

  @override
  String get rulesRunOnDeviceInstead => 'Натомість виконувати на цьому пристрої';

  @override
  String get rulesNothingToApplyTitle => 'Нічого застосовувати';

  @override
  String get rulesNothingToApplyMessage => 'Спершу задайте правилу робочу умову й дію.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Застосувати «$rule» до листів у…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Вхідні';

  @override
  String get rulesApplyScopeAll => 'Усі скриньки';

  @override
  String get rulesFindingMessages => 'Пошук листів…';

  @override
  String get rulesSearchError => 'Не вдалося виконати пошук';

  @override
  String get rulesSearchErrorUnknown => 'Щось пішло не так.';

  @override
  String get rulesNoMatchesTitle => 'Немає відповідних листів';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Там ніщо не відповідає «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Застосувати «$rule» до $countString листів?',
      few: 'Застосувати «$rule» до $countString листів?',
      one: 'Застосувати «$rule» до $countString листа?',
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
      other: 'Застосувати до $countString листів',
      few: 'Застосувати до $countString листів',
      one: 'Застосувати до $countString листа',
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
      other: '«$rule» застосовано до $countString листів',
      few: '«$rule» застосовано до $countString листів',
      one: '«$rule» застосовано до $countString листа',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Запит до сервера про його можливості…';

  @override
  String get rulesServerUnreachable => 'Не вдалося зв’язатися із сервером.';

  @override
  String rulesServerProblem(String problem) {
    return 'Не може виконуватися на сервері: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Не може виконуватися на сервері облікового запису $account: $problem';
  }

  @override
  String get rulesShowScript => 'Показати скрипт';

  @override
  String get rulesHideScript => 'Сховати скрипт';

  @override
  String get rulesMatchingHeader => 'Відповідні листи';

  @override
  String get rulesMatchingHeaderLoading => 'Відповідні листи…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString відповідних листів',
      few: '$countString відповідні листи',
      one: '$countString відповідний лист',
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
      other: '$countString+ відповідних листів',
      few: '$countString+ відповідних листів',
      one: '$countString+ відповідних листів',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'За останні 30 днів. Саме правило діє лише на нову пошту, якщо не застосувати його до наявних листів.';

  @override
  String rulesConditionError(String error) {
    return 'Помилка в умові: $error';
  }

  @override
  String get rulesPreviewNoSender => '(без відправника)';

  @override
  String get rulesPreviewNoSubject => '(без теми)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'і ще $countString',
      few: 'і ще $countString',
      one: 'і ще $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Нічого за останні 30 днів.';

  @override
  String get rulesIncludeTitle => 'Увімкнути правила на сервері';

  @override
  String get rulesIncludeLeaveOff => 'Залишити вимкненими';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Сервер уже виконує правила Loupe для $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '«$script» — активний скрипт на сервері облікового запису $account, тож сервер виконує його, а не правила Loupe. Loupe не замінюватиме його. Він може додати до нього ці рядки, і тоді сервер виконуватиме правила Loupe після власних правил скрипту:';
  }

  @override
  String get rulesShowWholeScript => 'Показати весь скрипт';

  @override
  String get rulesHideWholeScript => 'Сховати весь скрипт';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Більше нічого в «$script» не зміниться. Якщо згодом його фільтри змінять у вебпошті, вона може переписати скрипт без цих рядків; тоді Loupe знову покаже, що правила на сервері вимкнено.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Додати до «$script»';
  }

  @override
  String get subscriptionsTitle => 'Підписки';

  @override
  String get subscriptionsNewsletters => 'Розсилки';

  @override
  String get subscriptionsDiscussions => 'Обговорення';

  @override
  String get subscriptionsFilter => 'Фільтр';

  @override
  String get subscriptionsFilterNeverRead => 'Ніколи не прочитані';

  @override
  String get subscriptionsFilterRarelyRead => 'Рідко прочитані';

  @override
  String get subscriptionsFilterAll => 'Усі';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Не вдалося підрахувати підписки';

  @override
  String get subscriptionsNoMatches => 'Немає збігів';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Немає розсилки з назвою «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Немає списку з назвою «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Немає розсилок';

  @override
  String get subscriptionsNoNewslettersDetail => 'Розсилки та інша масова пошта з’являться тут, щойно надійдуть.';

  @override
  String get subscriptionsNothingNeverRead => 'Немає ніколи не прочитаних';

  @override
  String get subscriptionsNothingRarelyRead => 'Немає рідко прочитаних';

  @override
  String get subscriptionsNothingFilteredDetail => 'Ви читаєте хоч щось із усього, що отримуєте.';

  @override
  String get subscriptionsNoDiscussions => 'Немає обговорень';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Списки розсилки, у які можна писати, з’являться тут, щойно надійде їхня пошта.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Списки, у які пишуть кілька людей. Торкніться й утримуйте список, щоб закріпити його в скриньках, читати як простий текст або перемістити до розсилок.';

  @override
  String get subscriptionsPrivacyNote =>
      'Підраховано на цьому телефоні за завантаженою поштою; для цього нічого нікуди не надсилається. Loupe звертається до відправника, лише коли ви натискаєте «Відписатися»: відписка одним дотиком надсилає тільки «List-Unsubscribe=One-Click» на адресу, яку вказав відправник, без файлів cookie й будь-яких інших даних про вас, і ніколи не завантажує його сторінки чи зображення.';

  @override
  String get subscriptionsVolumeNone => 'Останнім часом нічого';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / міс.';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / міс.';
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
  String get subscriptionsStillSending => 'Досі надсилає';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Відписано $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Сторінку відписки відкрито $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Одним дотиком · звертається до $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Листом на $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'На сайті $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Відписатися';

  @override
  String get subscriptionsUnsubscribeAgain => 'Відписатися знову';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Архівувати $countString у «Вхідних»',
      few: 'Архівувати $countString у «Вхідних»',
      one: 'Архівувати $countString у «Вхідних»',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Створити правило…';

  @override
  String get subscriptionsCreateRuleDetail => 'Переміщувати або архівувати майбутні листи';

  @override
  String get subscriptionsTreatAsDiscussion => 'Вважати обговоренням';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Список, у який пишуть люди: читати як форум';

  @override
  String get subscriptionsTreatAsNewsletter => 'Вважати розсилкою';

  @override
  String get subscriptionsBlockSender => 'Заблокувати відправника';

  @override
  String get subscriptionsBlock => 'Заблокувати';

  @override
  String get subscriptionsBlocked => 'Заблоковано';

  @override
  String get subscriptionsBlockedDetail => 'Нова пошта йде в спам';

  @override
  String get subscriptionsPin => 'Закріпити в скриньках';

  @override
  String get subscriptionsUnpin => 'Відкріпити від скриньок';

  @override
  String get subscriptionsOpenDefaultView => 'Відкривати в типовому вигляді';

  @override
  String get subscriptionsOpenPlainText => 'Відкривати як простий текст (моно)';

  @override
  String get subscriptionsPinned => 'Закріплено';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString непрочитаних',
      few: '$countString непрочитані',
      one: '$countString непрочитаний',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Зараз немає листів від цього відправника.';

  @override
  String get subscriptionsLatestMessages => 'ОСТАННІ ЛИСТИ';

  @override
  String get subscriptionsMail => 'Пошта';

  @override
  String get subscriptionsNoneIn90Days => 'Нічого за 90 днів';

  @override
  String get subscriptionsRead => 'Прочитано';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString з $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Останній отриманий';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count тек',
      few: '$count теки',
      one: '$count тека',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Досі надсилає';

  @override
  String get subscriptionsUnsubscribedTitle => 'Відписано';

  @override
  String subscriptionsSince(String date) {
    return 'з $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'сторінку відкрито $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender не повідомляє, як відписатися.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender не повідомляє, як відписатися. Натомість його можна заблокувати.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Відписування від $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Ви відписалися від $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Не вдалося відписатися: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Не вдалося відписатися автоматично';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Надіслати лист про відписку';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Відкрити $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Відкрити $site?';
  }

  @override
  String get subscriptionsOpen => 'Відкрити';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender пропонує відписатися на своєму сайті. Сторінка відкриється в браузері Loupe; завершіть там.';
  }

  @override
  String get subscriptionsWebInsecure => 'З’єднання з цим сайтом не зашифроване.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Обережно: ця адреса імітує $site схожими літерами.';
  }

  @override
  String get subscriptionsHomographWarningUnknown => 'Обережно: ця адреса імітує інший сайт схожими літерами.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Не вдалося відкрити $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe запам’ятає сьогоднішню дату й повідомить, якщо $sender і далі писатиме.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Відписатися від $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe звернеться до $site, щоб відписатися.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Це єдиний випадок, коли Loupe звертається до сайту відправника. Він надсилає лише «List-Unsubscribe=One-Click» на адресу, яку вказав $sender, без файлів cookie й будь-яких інших даних про вас, і не завантажує сторінку.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Посилання для відписки не є безпечною адресою в інтернеті.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site не відповів вчасно.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Не вдалося зв’язатися з $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site переспрямував запит на іншу сторінку, а Loupe не переходить за переспрямуваннями.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site відхилив запит (помилка $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Немає облікового запису, з якого можна надіслати лист про відписку.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe надішле лист на $to з адреси $from з темою «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Лист про відписку надіслано на $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Заблокувати $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Нова пошта з цього списку йтиме в спам. Це можна змінити в розділі Налаштування › Правила.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Нова пошта з $address йтиме в спам. Це можна змінити в розділі Налаштування › Правила.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender заблоковано.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Перемістити $count у спам',
      few: 'Перемістити $count у спам',
      one: 'Перемістити $count у спам',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Блокувати $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender тепер у розсилках.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender тепер в обговореннях.';
  }

  @override
  String get appLiveGateTitle => 'Не вдалося відкрити ваші облікові записи';

  @override
  String get appLiveGateUnavailableBuild => 'Справжні облікові записи в цій збірці поки недоступні.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe не вдалося прочитати ключ, що захищає вашу пошту на цьому телефоні. Часто це тимчасово: спробуйте ще раз або перезапустіть телефон.';

  @override
  String get appLiveGateKeyMissing =>
      'Ключ, що захищає вашу пошту на цьому телефоні, зник — таке буває після відновлення з резервної копії. Ваша пошта досі на сервері.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Не вдається прочитати поштову базу даних на цьому телефоні: вона пошкоджена або змінився її ключ. Ваша пошта досі на сервері.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Під час відкриття облікових записів щось пішло не так ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Це видалить ваші облікові записи й пошту, збережену на цьому телефоні, зокрема листи, що чекають у «Вихідних». Пошти на ваших серверах це не стосується; потім додайте облікові записи знову.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Видалити й почати знову';

  @override
  String get appLiveGateUseDemo => 'Використати демопошту';

  @override
  String get appLiveGateReset => 'Скинути пошту на цьому телефоні…';

  @override
  String get attachmentsUntitled => 'Вкладення';

  @override
  String get attachmentsUntitledFile => 'Без назви';

  @override
  String get attachmentsOpenIn => 'Відкрити в…';

  @override
  String get attachmentsSaveToFiles => 'Зберегти у файли';

  @override
  String get attachmentsShareMenu => 'Поділитися…';

  @override
  String get attachmentsDownloadError => 'Не вдалося завантажити вкладення. Перевірте з’єднання й спробуйте ще раз.';

  @override
  String get attachmentsShareError => 'Не вдалося поділитися вкладенням.';

  @override
  String attachmentsNoApp(String type) {
    return 'На цьому пристрої немає застосунку, що відкриває цей файл ($type). Спробуйте «Поділитися».';
  }

  @override
  String get attachmentsOpenInError => 'Не вдалося відкрити вкладення в іншому застосунку.';

  @override
  String attachmentsSaved(String name) {
    return 'Збережено «$name»';
  }

  @override
  String get attachmentsSaveError => 'Не вдалося зберегти вкладення.';

  @override
  String get attachmentsGone => 'Це вкладення більше недоступне.';

  @override
  String get attachmentsDownloadFailed => 'Не вдалося завантажити вкладення.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сторінок',
      few: '$count сторінки',
      one: '$count сторінка',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size через мобільний інтернет';
  }

  @override
  String get attachmentsLargeDownload => 'Це вкладення велике. Завантажте його зараз або пізніше через Wi-Fi.';

  @override
  String get attachmentsDownload => 'Завантажити';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Завантаження $size…';
  }

  @override
  String get attachmentsDownloading => 'Завантаження…';

  @override
  String get attachmentsTooLarge => 'Завелике для попереднього перегляду тут.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Показано перші $shown із $total. Скопіюйте, поділіться або збережіть, щоб отримати все.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Цей PDF не можна показати тут (можливо, він захищений паролем).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page з $count';
  }

  @override
  String get attachmentsModeTable => 'Таблиця';

  @override
  String get attachmentsModeText => 'Текст';

  @override
  String get attachmentsModeMessage => 'Лист';

  @override
  String get attachmentsModeSource => 'Джерело';

  @override
  String get attachmentsDontWrap => 'Не переносити рядки';

  @override
  String get attachmentsWrap => 'Переносити рядки';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines рядків',
      few: '$lines рядки',
      one: '$count рядок',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Копіювати все';

  @override
  String get attachmentsCopied => 'Скопійовано';

  @override
  String get attachmentsImageUnavailable => 'Це зображення не можна показати тут. Спробуйте «Відкрити в…».';

  @override
  String get attachmentsEmlNoSubject => '(Без теми)';

  @override
  String get attachmentsEmlFrom => 'Від';

  @override
  String get attachmentsEmlTo => 'Кому';

  @override
  String get attachmentsEmlCc => 'Копія';

  @override
  String get attachmentsEmlDate => 'Дата';

  @override
  String get attachmentsEmlNoText => 'У цьому листі немає тексту.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Вкладення: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Організатор: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'І ще $count подій',
      few: 'І ще $count події',
      one: 'І ще $count подія',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Зображення';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Зображення $format';
  }

  @override
  String get attachmentsTypePdf => 'Документ PDF';

  @override
  String get attachmentsTypeTsv => 'Значення, розділені табуляцією';

  @override
  String get attachmentsTypeCsv => 'Таблиця CSV';

  @override
  String get attachmentsTypeCalendar => 'Подія календаря';

  @override
  String get attachmentsTypeEmail => 'Лист електронної пошти';

  @override
  String get attachmentsTypeContact => 'Картка контакту';

  @override
  String get attachmentsTypeLog => 'Файл журналу';

  @override
  String get attachmentsTypeText => 'Текст';

  @override
  String get attachmentsTypeZip => 'Архів ZIP';

  @override
  String get attachmentsTypeArchive => 'Архів';

  @override
  String get attachmentsTypeWord => 'Документ Word';

  @override
  String get attachmentsTypeExcel => 'Таблиця Excel';

  @override
  String get attachmentsTypePowerPoint => 'Презентація PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Вебсторінка';

  @override
  String get attachmentsTypeVideo => 'Відео';

  @override
  String get attachmentsTypeAudio => 'Аудіо';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Файл $extension';
  }

  @override
  String get attachmentsTypeFile => 'Файл';

  @override
  String get calendarUntitledEvent => 'Подія';

  @override
  String get calendarAllDay => 'Увесь день';

  @override
  String calendarYourTime(String time) {
    return '$time за вашим часом';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Приєднатися: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name приймає запрошення: $details',
      'tentative': '$name попередньо приймає запрошення: $details',
      'declined': '$name відхиляє запрошення: $details',
      'delegated': '$name делегує запрошення: $details',
      'other': '$name не відповідає на запрошення: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name приймає запрошення',
      'tentative': '$name попередньо приймає запрошення',
      'declined': '$name відхиляє запрошення',
      'delegated': '$name делегує запрошення',
      'other': '$name не відповідає на запрошення',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Карта';

  @override
  String get calendarJoin => 'Приєднатися';

  @override
  String get calendarOnlineMeeting => 'Онлайн-зустріч';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Зустріч $provider';
  }

  @override
  String get calendarOrganizerYou => 'Ви';

  @override
  String get calendarOrganizerLabel => 'організатор';

  @override
  String get calendarStatusAccepted => 'Прийнято';

  @override
  String get calendarStatusMaybe => 'Можливо';

  @override
  String get calendarStatusDeclined => 'Відхилено';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name приймає запрошення',
      'tentative': '$name попередньо приймає запрошення',
      'declined': '$name відхиляє запрошення',
      'delegated': '$name делегує запрошення',
      'other': '$name не відповідає на запрошення',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name приймає запрошення:',
      'tentative': '$name попередньо приймає запрошення:',
      'declined': '$name відхиляє запрошення:',
      'delegated': '$name делегує запрошення:',
      'other': '$name не відповідає на запрошення:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name пропонує новий час';
  }

  @override
  String get calendarCounterUnknown => 'Учасник пропонує новий час';

  @override
  String get calendarDeclineCounter => 'Організатор залишив час без змін';

  @override
  String calendarRefresh(String name) {
    return '$name просить найновішу версію';
  }

  @override
  String get calendarRefreshUnknown => 'Учасник просить найновішу версію';

  @override
  String get calendarCancelled => 'Скасовано';

  @override
  String get calendarCancelledByOrganizer => 'Організатор скасував цю подію.';

  @override
  String get calendarCancelledLater => 'Цю подію згодом скасовано.';

  @override
  String get calendarOutdated => 'Застаріло';

  @override
  String get calendarOutdatedDetail => 'Це запрошення згодом оновили; чинним є новіше.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Місце вилучено (було: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Місце вилучено (не було вказано)';

  @override
  String calendarLocationChanged(String location) {
    return 'Місце змінено на $location';
  }

  @override
  String get calendarNewTitle => 'Нова назва';

  @override
  String get calendarRepeatChanged => 'Змінено повторення';

  @override
  String get calendarUpdated => 'Оновлено';

  @override
  String get calendarUpdatedInvitation => 'Оновлене запрошення';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Час змінено з $before на $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Невідомий часовий пояс «$zone»: час як зазначено';
  }

  @override
  String calendarNext(String when) {
    return 'Наступна: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count гостей',
      few: '$count гості',
      one: '$count гість',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'прийнято: $count',
      few: 'прийнято: $count',
      one: 'прийнято: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'можливо: $count',
      few: 'можливо: $count',
      one: 'можливо: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'відхилено: $count',
      few: 'відхилено: $count',
      one: 'відхилено: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (ви)';
  }

  @override
  String get calendarAttendeeOptional => 'необов’язково';

  @override
  String get calendarAttendeeRoom => 'приміщення';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Ви прийняли попередню версію.',
      'tentative': 'Ви попередньо прийняли попередню версію.',
      'declined': 'Ви відхилили попередню версію.',
      'delegated': 'Ви делегували попередню версію.',
      'other': 'Ви не відповіли на попередню версію.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Прийняти';

  @override
  String get calendarMaybe => 'Можливо';

  @override
  String get calendarDecline => 'Відхилити';

  @override
  String get calendarCommentHint => 'Коментар для організатора (необов’язково)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Вашу відповідь буде надіслано $organizer з адреси $address.';
  }

  @override
  String get calendarAddComment => 'Додати коментар';

  @override
  String get calendarAddToCalendar => 'Додати в календар';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'І ще $count подій у файлі',
      few: 'І ще $count події у файлі',
      one: 'І ще $count подія у файлі',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Немає застосунку календаря, у який можна додати подію.';

  @override
  String get calendarCantOpenCalendar => 'Не вдалося відкрити календар.';

  @override
  String get calendarCantOpenLink => 'Не вдалося відкрити посилання.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Приєднатися до зустрічі $provider?';
  }

  @override
  String get calendarJoinTitle => 'Приєднатися до зустрічі?';

  @override
  String calendarJoinOpens(String host) {
    return 'Відкриває $host у браузері.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Обережно: ця адреса імітує $site схожими літерами.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Обережно: ця адреса імітує інший сайт схожими літерами.';

  @override
  String calendarJoinOpen(String host) {
    return 'Відкрити $host';
  }

  @override
  String get calendarNoOrganizer => 'У цьому запрошенні немає організатора, якому можна відповісти.';

  @override
  String get calendarNoAccount => 'Немає облікового запису, з якого можна відповісти.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прийнято',
      'tentative': 'Можливо',
      'other': 'Відхилено',
    });
    return '$_temp0 · надсилання відповіді для $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прийнято',
      'tentative': 'Можливо',
      'other': 'Відхилено',
    });
    return '$_temp0 · відповідь надіслано';
  }

  @override
  String get calendarReplyAlreadySent => 'Відповідь уже надіслано.';

  @override
  String get calendarReplyNotSent => 'Відповідь не надіслано.';

  @override
  String get dataSmimeNeedsDevice =>
      'Ваш сертифікат S/MIME зберігається на цьому пристрої: відкрийте Loupe, щоб підписати й надіслати цей лист.';

  @override
  String dataSigningFailed(String error) {
    return 'Не вдалося підписати: $error';
  }

  @override
  String get keyboardShortcuts => 'Клавіатурні скорочення';

  @override
  String get keyboardGroupGeneral => 'Загальні';

  @override
  String get keyboardGroupMessages => 'Листи';

  @override
  String get keyboardGroupCompose => 'Написання';

  @override
  String get keyboardCommandPalette => 'Палітра команд';

  @override
  String get keyboardBackClose => 'Назад, закрити';

  @override
  String get keyboardNextMessage => 'Наступний лист';

  @override
  String get keyboardPreviousMessage => 'Попередній лист';

  @override
  String get keyboardOpenMessage => 'Відкрити лист';

  @override
  String get keyboardMoveToTrash => 'Перемістити в кошик';

  @override
  String get keyboardToggleRead => 'Позначити як прочитане чи непрочитане';

  @override
  String get keyboardToggleFlag => 'Позначити прапорцем або зняти прапорець';

  @override
  String get keyboardCloseDraft => 'Закрити (зберегти або видалити чернетку)';

  @override
  String get keyboardOr => 'або';

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
  String get mailingListsMuted => 'Гілку приглушено. Нові листи в ній надходитимуть прочитаними.';

  @override
  String get mailingListsUnmuted => 'Приглушення гілки знято.';

  @override
  String get mailingListsMuteThread => 'Приглушити гілку';

  @override
  String get mailingListsUnmuteThread => 'Зняти приглушення гілки';

  @override
  String get mailingListsPin => 'Закріпити в скриньках';

  @override
  String get mailingListsUnpin => 'Відкріпити від скриньок';

  @override
  String get mailingListsDefaultView => 'Відкривати в типовому вигляді';

  @override
  String get mailingListsPlainText => 'Відкривати як простий текст (моно)';

  @override
  String get mailingListsShowMuted => 'Показати приглушені гілки';

  @override
  String get mailingListsHideMuted => 'Сховати приглушені гілки';

  @override
  String get mailingListsTreatAsNewsletter => 'Вважати розсилкою';

  @override
  String get mailingListsOptions => 'Параметри списку';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted непрочитаних',
      few: '$formatted непрочитані',
      one: '$count непрочитаний',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Новий лист у список';

  @override
  String get mailingListsRowUnread => 'Непрочитане';

  @override
  String get mailingListsRowMuted => 'Приглушено';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count відповідей',
      few: '$count відповіді',
      one: '$count відповідь',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Немає гілок';

  @override
  String get mailingListsMutedHidden => 'Приглушені гілки приховано.';

  @override
  String get mailingListsTechnicalTitle => 'Технічні списки розсилки';

  @override
  String get mailingListsTechnicalEmpty => 'Списки розсилки з’являться тут, щойно надійде їхня пошта.';

  @override
  String get mailingListsTechnicalFooter =>
      'Листи з цих списків відкриваються як простий текст моноширинним шрифтом, а патчі показуються як diff. Кнопка Aa, як і раніше, перемикає будь-який лист.';

  @override
  String get paletteMoveToMailbox => 'Перемістити до скриньки…';

  @override
  String get paletteMarkAllRead => 'Позначити все як прочитане';

  @override
  String get paletteExportFolder => 'Експортувати теку…';

  @override
  String get paletteGetNewMail => 'Отримати нову пошту';

  @override
  String get paletteSnoozed => 'Відкладені';

  @override
  String get paletteSubscriptions => 'Підписки';

  @override
  String get paletteDiscussions => 'Обговорення';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Список розсилки';

  @override
  String get paletteTag => 'Мітка';

  @override
  String get paletteSwipeActions => 'Дії свайпу';

  @override
  String get paletteNotifications => 'Сповіщення';

  @override
  String get paletteRules => 'Правила';

  @override
  String get paletteEncryption => 'Наскрізне шифрування';

  @override
  String get paletteAdvanced => 'Додатково';

  @override
  String get paletteAddAccount => 'Додати обліковий запис';

  @override
  String get paletteAccount => 'Обліковий запис';

  @override
  String get paletteFolders => 'Теки';

  @override
  String get paletteRecentSearch => 'Недавній пошук';

  @override
  String paletteSearchMail(String query) {
    return 'Шукати в пошті «$query»';
  }

  @override
  String get palettePlaceholder => 'Пошук дій, скриньок, налаштувань';

  @override
  String get paletteNothingFound => 'Нічого не знайдено';

  @override
  String get searchNewSmartMailbox => 'Нова скринька Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Показує все, що відповідає «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '«$name» збережено в скриньках';
  }

  @override
  String get searchMakeRule => 'Створити з цього правило';

  @override
  String get searchSaveSmartMailbox => 'Зберегти як Smart Mailbox';

  @override
  String get searchNegate => 'Заперечити';

  @override
  String get searchDontNegate => 'Не заперечувати';

  @override
  String get searchAllMailboxes => 'Усі скриньки';

  @override
  String get searchRecent => 'Недавні пошуки';

  @override
  String get searchClear => 'Очистити';

  @override
  String get searchSuggestions => 'Пропозиції';

  @override
  String get searchUnreadMessages => 'Непрочитані листи';

  @override
  String get searchFlaggedMessages => 'Листи з прапорцем';

  @override
  String get searchWithAttachments => 'Листи з вкладеннями';

  @override
  String get searchUnrepliedMessages => 'Листи без відповіді';

  @override
  String get searchTags => 'Мітки';

  @override
  String get searchPeople => 'Люди';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Від: $name';
  }

  @override
  String get searchSearching => 'Пошук…';

  @override
  String get searchNoResults => 'Немає результатів';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted результатів',
      few: '$formatted результати',
      one: '$count результат',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Меню пошуку';

  @override
  String searchSearchingAccount(String account) {
    return 'Пошук у $account на сервері…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Пошук в обліковому записі на сервері…';

  @override
  String searchAccountFailed(String account) {
    return 'Не вдалося виконати пошук у $account на сервері';
  }

  @override
  String get searchUnknownAccountFailed => 'Не вдалося виконати пошук в обліковому записі на сервері';

  @override
  String searchChip(String term) {
    return '$term. Двічі торкніться, щоб змінити.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Не $term. Двічі торкніться, щоб змінити.';
  }

  @override
  String get searchReadAndUnread =>
      'Скринька Шредінгера: кожен лист тут водночас прочитаний і непрочитаний, доки ви його не відкриєте.';

  @override
  String searchContradiction(String term) {
    return 'Жоден лист не може водночас бути й не бути «$term».';
  }

  @override
  String get searchSyncDeviceOnly => 'Лише на цьому пристрої';

  @override
  String searchSyncUnsupported(String account) {
    return 'Лише на цьому пристрої: $account не може її зберігати';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Не синхронізовано: $account має новіший формат';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Очікує синхронізації з $account';
  }

  @override
  String searchSynced(String account) {
    return 'Синхронізовано з $account';
  }

  @override
  String get searchRename => 'Перейменувати';

  @override
  String get searchEditSearch => 'Змінити пошук';

  @override
  String get searchDeleteSmartMailbox => 'Видалити скриньку Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Перейменувати скриньку Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Цю скриньку Smart Mailbox видалено.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Скриньки Smart Mailbox залишаються на цьому пристрої.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Скриньки Smart Mailbox зберігаються на вашому поштовому сервері, тож вони є й на інших ваших пристроях, а також у Thunderbird із доповненням Expression Search Reloaded. Ті, що шукають в усіх облікових записах, зберігаються в $account; ті, що стосуються однієї теки, — в обліковому записі цієї теки.';
  }

  @override
  String get searchSyncVia => 'Синхронізувати через';

  @override
  String get searchSyncViaFooter => 'Виберіть той самий обліковий запис на кожному пристрої.';

  @override
  String get searchGmailCantKeep => 'Gmail не може зберігати скриньки Smart Mailbox';

  @override
  String get searchKeepOnDevice => 'Зберігати скриньки Smart Mailbox лише на цьому пристрої';

  @override
  String get searchOnTheServer => 'На сервері';

  @override
  String get searchServerFooter =>
      'Метадані сервера (IMAP METADATA) не показуються в жодному поштовому застосунку. Сервери без них отримують теку «Loupe Settings» з одним листом; Loupe приховує її на екрані «Скриньки».';

  @override
  String get searchSyncNow => 'Синхронізувати зараз';

  @override
  String get searchStateUnsupported => 'Не підтримується';

  @override
  String get searchStateNewerFormat => 'Новіший формат';

  @override
  String get searchStateFailed => 'Не вдалося синхронізувати';

  @override
  String get searchStateSyncing => 'Синхронізація…';

  @override
  String get searchStateWaiting => 'Очікування';

  @override
  String get searchStateMetadata => 'Метадані сервера';

  @override
  String get searchStateFolder => 'Тека Loupe Settings';

  @override
  String get searchStateNothing => 'Нічого не збережено';

  @override
  String get sharedBack => 'Назад';

  @override
  String get sharedYesterday => 'Учора';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date о $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count байтів',
      few: '$count байти',
      one: '$count байт',
    );
    return '$_temp0';
  }

  @override
  String sharedKilobytes(String size) {
    return '$size КБ';
  }

  @override
  String sharedMegabytes(String size) {
    return '$size МБ';
  }

  @override
  String get sharedSyncNoAccounts => 'Немає облікових записів';

  @override
  String get sharedSyncChecking => 'Перевірка пошти…';

  @override
  String get sharedSyncFailed => 'Не вдалося перевірити пошту';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Не в мережі';

  @override
  String get sharedSyncJustNow => 'Щойно оновлено';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Оновлено $minutes хвилин тому',
      few: 'Оновлено $minutes хвилини тому',
      one: 'Оновлено $minutes хвилину тому',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Оновлено о $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Оновлено $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Усі вхідні';

  @override
  String get sharedMailboxUnread => 'Непрочитані';

  @override
  String get sharedMailboxFlagged => 'З прапорцем';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Усі чернетки';

  @override
  String get sharedMailboxAllSent => 'Усі надіслані';

  @override
  String get sharedMailboxUntitled => 'Скринька';

  @override
  String get sharedTagImportant => 'Важливо';

  @override
  String get sharedTagWork => 'Робота';

  @override
  String get sharedTagPersonal => 'Особисте';

  @override
  String get sharedTagToDo => 'Зробити';

  @override
  String get sharedTagLater => 'Пізніше';

  @override
  String get sharedTags => 'Мітки';

  @override
  String get sharedMoveTo => 'Перемістити в…';

  @override
  String get sharedNoRecipients => 'Без одержувачів';

  @override
  String get sharedUnknownSender => 'Невідомий відправник';

  @override
  String get sharedOnServer => 'На сервері';

  @override
  String get sharedAttachment => 'Вкладення';

  @override
  String get sharedSnoozedBadge => 'Відкладено';

  @override
  String get sharedRowUnread => 'Непрочитаний';

  @override
  String get sharedRowBackFromSnooze => 'Повернувся з відкладених';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'З прапорцем';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Архівовано $count листів',
      few: 'Архівовано $count листи',
      one: 'Архівовано $count лист',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Видалено $count листів',
      few: 'Видалено $count листи',
      one: 'Видалено $count лист',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переміщено $count листів у «Вхідні»',
      few: 'Переміщено $count листи у «Вхідні»',
      one: 'Переміщено $count лист у «Вхідні»',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переміщено $count листів у кошик',
      few: 'Переміщено $count листи у кошик',
      one: 'Переміщено $count лист у кошик',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переміщено $count листів у спам',
      few: 'Переміщено $count листи у спам',
      one: 'Переміщено $count лист у спам',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переміщено $count листів у $mailbox',
      few: 'Переміщено $count листи у $mailbox',
      one: 'Переміщено $count лист у $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переміщено $count листів у скриньку',
      few: 'Переміщено $count листи у скриньку',
      one: 'Переміщено $count лист у скриньку',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Відкладено $count листів до $time',
      few: 'Відкладено $count листи до $time',
      one: 'Відкладено $count лист до $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Відкладено до $time лише на цьому пристрої: сервер не може зберігати час відкладення.';
  }

  @override
  String get sharedMoveOneAccount => 'Щоб перемістити листи, виберіть їх з одного облікового запису.';

  @override
  String get sharedSnoozeTitle => 'Відкласти';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Змінити час відкладення';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Видалити $count листів назавжди?',
      few: 'Видалити $count листи назавжди?',
      one: 'Видалити $count лист назавжди?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Цю дію не можна скасувати.';

  @override
  String get sharedDeletePermanently => 'Видалити назавжди';

  @override
  String get sharedSwipeRead => 'Прочитане';

  @override
  String get sharedSwipeUnread => 'Непрочитане';

  @override
  String get sharedSwipeInbox => 'Вхідні';

  @override
  String get sharedSwipeDelete => 'Видалити';

  @override
  String get sharedTrash => 'У кошик';

  @override
  String get sharedSwipeSnooze => 'Відкласти';

  @override
  String get sharedWakeNow => 'Повернути зараз';

  @override
  String get sharedChangeSnoozeTime => 'Змінити час відкладення…';

  @override
  String get sharedSnooze => 'Відкласти…';

  @override
  String get sharedTag => 'Мітки…';

  @override
  String get sharedMoveMessage => 'Перемістити лист…';

  @override
  String get sharedNotJunk => 'Не спам';

  @override
  String get accountSetupTitle => 'Додати обліковий запис';

  @override
  String get accountSetupTitleDone => 'Обліковий запис додано';

  @override
  String get accountSetupAddressTitle => 'Додайте поштовий обліковий запис';

  @override
  String get accountSetupAddressText => 'Loupe знаходить налаштування для більшості провайдерів.';

  @override
  String get accountSetupNameHint => 'Ваше ім’я';

  @override
  String get accountSetupEmail => 'Ел. пошта';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Продовжити';

  @override
  String get accountSetupLookingUp => 'Пошук налаштувань…';

  @override
  String get accountSetupImport => 'Імпортувати з Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Введіть дійсну адресу електронної пошти.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Не вдалося знайти налаштування для $domain. Введіть їх нижче.';
  }

  @override
  String get accountSetupCheckServers => 'Перевірте назви серверів і порти.';

  @override
  String get accountSetupEnterPassword => 'Введіть пароль.';

  @override
  String get accountSetupConnecting => 'Підключення…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Очікування $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Не вдалося відкрити сторінку.';

  @override
  String get accountSetupCouldNotSaveName => 'Не вдалося зберегти назву.';

  @override
  String get accountSetupTrustCertificate => 'Довіряти цьому сертифікату';

  @override
  String get accountSetupPasswordRequired => 'Обов’язково';

  @override
  String get accountSetupShowPassword => 'Показати пароль';

  @override
  String get accountSetupHidePassword => 'Сховати пароль';

  @override
  String get accountSetupAppPassword => 'Пароль застосунку';

  @override
  String get accountSetupApiToken => 'API-токен';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Вхідна · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Вихідна · SMTP';

  @override
  String get accountSetupSignIn => 'Увійти';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Увійти через $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Використати пароль застосунку';

  @override
  String get accountSetupUseAppPasswordInstead => 'Натомість використати пароль застосунку';

  @override
  String get accountSetupUseDifferentAddress => 'Використати іншу адресу';

  @override
  String get accountSetupHowToCreateAppPassword => 'Як створити пароль застосунку';

  @override
  String get accountSetupHowToCreateOne => 'Як його створити';

  @override
  String get accountSetupGoogleNote =>
      'Ви входите на сторінці Google, і Loupe ніколи не бачить вашого пароля. Дозвольте Loupe читати, надсилати й упорядковувати вашу пошту.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '«Увійти через Google» у цій збірці поки недоступне. Натомість можна підключитися з паролем застосунку (для нього потрібна двоетапна перевірка в обліковому записі Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Створіть пароль застосунку в обліковому записі Google і вставте його нижче.';

  @override
  String get accountSetupMicrosoftNote =>
      'Ви входите на сторінці Microsoft, і Loupe ніколи не бачить вашого пароля. Це працює для Outlook.com і Hotmail, а також для робочих чи навчальних облікових записів Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Вхід через Microsoft з’явиться в одній із наступних збірок. Він потрібен для облікових записів Outlook, Hotmail і Microsoft 365: вони більше не приймають паролі від поштових застосунків.';

  @override
  String get accountSetupICloudNote =>
      'Для iCloud Mail потрібен пароль для програм, а не пароль облікового запису Apple.';

  @override
  String get accountSetupYahooNote => 'Для Yahoo Mail потрібен пароль застосунку, а не пароль облікового запису.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe підключається до Fastmail через JMAP з API-токеном: Settings › Privacy & Security › Manage API tokens, для JMAP, з доступом до пошти й надсилання.';

  @override
  String get accountSetupFastmailNote => 'Для поштових застосунків Fastmail потребує пароль застосунку.';

  @override
  String get accountSetupServerSettings => 'Налаштування сервера';

  @override
  String get accountSetupSettingsNotFound => 'Не знайдено автоматично';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Знайдено через $source';
  }

  @override
  String get accountSetupEditSettings => 'Змінити налаштування';

  @override
  String get accountSetupSyncing => 'Ваша пошта синхронізується.';

  @override
  String get accountSetupDescription => 'Опис';

  @override
  String get accountSetupDescriptionHint => 'Робота, особисте…';

  @override
  String get accountSetupColour => 'Колір';

  @override
  String accountSetupColourNumber(int number) {
    return 'Колір $number';
  }

  @override
  String get accountSetupSaving => 'Збереження…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe не вдалося відкрити свою поштову базу даних на цьому телефоні. Закрийте Loupe, відкрийте знову й повторіть спробу.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Щось пішло не так ($error). Спробуйте ще раз.';
  }

  @override
  String get accountSetupSecurityNone => 'Немає';

  @override
  String get accountSetupProtocol => 'Протокол';

  @override
  String get accountSetupPort => 'Порт';

  @override
  String get accountSetupSecurity => 'Безпека';

  @override
  String get accountSetupUsername => 'Ім’я користувача';

  @override
  String get accountSetupUsernameHint => 'Ваша адреса електронної пошти';

  @override
  String get accountSetupNoEncryptionTitle => 'Підключитися без шифрування?';

  @override
  String get accountSetupNoEncryptionText =>
      'Ваш пароль і кожен лист передаватимуться відкритим текстом. Будь-хто в мережі, наприклад у публічній Wi-Fi, зможе їх прочитати. Використовуйте це лише для сервера у вашій власній мережі.';

  @override
  String get accountSetupUseWithoutEncryption => 'Використовувати без шифрування';

  @override
  String get accountSetupApiTokenRejected =>
      'API-токен відхилено. Створіть API-токен Fastmail для JMAP з доступом до пошти й вставте його.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Пароль відхилено. Використовуйте пароль застосунку, а не пароль облікового запису.';

  @override
  String get accountSetupPasswordRejected => 'Пароль відхилено. Перевірте його й спробуйте ще раз.';

  @override
  String get accountSetupServerUnreachable =>
      'Не вдається зв’язатися із сервером. Перевірте налаштування сервера й підключення.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Сертифікат сервера не є довіреним. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Вхід скасовано. Торкніться «Увійти через $provider», щоб спробувати ще раз.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe потрібен дозвіл читати й надсилати вашу пошту Gmail. Увійдіть знову й дозвольте доступ, позначивши пункт Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe потрібен дозвіл читати й надсилати вашу пошту. Увійдіть знову й прийміть дозволи.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Ваша організація має схвалити Loupe, перш ніж ви зможете використовувати його з цим обліковим записом. Попросіть ІТ-адміністратора надати згоду адміністратора для Loupe в Microsoft Entra ID, а потім спробуйте ще раз.';

  @override
  String get accountSetupOAuthBlocked =>
      'Правила входу вашої організації не дозволяють використовувати Loupe на цьому пристрої. Зверніться до ІТ-адміністратора.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Не вдалося зв’язатися з $provider. Перевірте підключення до інтернету й спробуйте ще раз.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Вхід через $provider неправильно налаштовано в цій версії Loupe. Будь ласка, повідомте про це.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Вхід через $provider не вдався. Спробуйте ще раз.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Вхід через $provider виконано, але Gmail відмовив у доступі для цієї адреси. Під час входу виберіть той самий обліковий запис. У робочих чи навчальних облікових записах адміністратор може вимкнути IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Вхід через $provider виконано, але поштовий сервер відмовив у доступі для цієї адреси. Під час входу виберіть той самий обліковий запис. У робочих чи навчальних облікових записах адміністратор може вимкнути IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Не вдається зв’язатися з поштовим сервером. Перевірте підключення й спробуйте ще раз.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Вхід через $provider недоступний у цій версії.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Вхід виконано знову. $account синхронізується.';
  }

  @override
  String get accountSetupSignInAgain => 'Увійти знову';

  @override
  String get accountSetupSigningIn => 'Вхід…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider більше не приймає вхід Loupe для $email, тож $account не синхронізується. Увійдіть знову, щоб отримувати пошту.';
  }

  @override
  String get accountImportTitle => 'Імпорт із Thunderbird';

  @override
  String get accountImportPointCamera => 'Наведіть камеру на QR-код, який показує Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Відскановано $scanned з $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Відскановано $scanned з $total кодів',
      few: 'Відскановано $scanned з $total кодів',
      one: 'Відскановано $scanned з $total коду',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Поки $count облікових записів',
      few: 'Поки $count облікові записи',
      one: 'Поки $count обліковий запис',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'На комп’ютері відкрийте Thunderbird і виберіть Інструменти › Експорт для мобільних. Виберіть облікові записи, а потім відскануйте кожен показаний код. Коди можна сканувати в будь-якому порядку.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Продовжити з $count обліковими записами',
      few: 'Продовжити з $count обліковими записами',
      one: 'Продовжити з $count обліковим записом',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Натомість вставити текст';

  @override
  String get accountImportStartOver => 'Почати знову';

  @override
  String get accountImportDuplicateCode => 'Цей код уже додано.';

  @override
  String get accountImportRestarted => 'Цей код із нового експорту, тож раніше відскановані коди відкладено.';

  @override
  String get accountImportNotThunderbird => 'Це не код облікового запису Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Цей код створено новішою версією Thunderbird. Оновіть Loupe, щоб імпортувати його.';

  @override
  String get accountImportDamaged => 'Не вдалося прочитати цей код Thunderbird.';

  @override
  String get accountImportTooLarge => 'Цей код завеликий для експорту Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Не вдалося відкрити налаштування.';

  @override
  String get accountImportCameraOffTitle => 'Доступ до камери вимкнено';

  @override
  String get accountImportCameraOffText =>
      'Дозвольте Loupe використовувати камеру в налаштуваннях, щоб відсканувати код, або натомість вставте текст коду.';

  @override
  String get accountImportNoCameraTitle => 'Немає камери';

  @override
  String get accountImportNoCameraText => 'Loupe не може використовувати камеру тут. Натомість вставте текст коду.';

  @override
  String get accountImportCameraFailedTitle => 'Камера не запустилася';

  @override
  String get accountImportCameraFailedText => 'Спробуйте ще раз або натомість вставте текст коду.';

  @override
  String get accountImportOpenSettings => 'Відкрити налаштування';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Знайдено $count облікових записів',
      few: 'Знайдено $count облікові записи',
      one: 'Знайдено $count обліковий запис',
      zero: 'Облікових записів не знайдено',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Жоден обліковий запис у цих кодах не вдалося прочитати.';

  @override
  String get accountImportChoose => 'Виберіть облікові записи, які додати до Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Не відскановано $count кодів ($codes із $total), тож їхні облікові записи не показано.',
      few: 'Не відскановано $count коди ($codes із $total), тож їхні облікові записи не показано.',
      one: 'Не відскановано $count код ($codes із $total), тож його облікові записи не показано.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes і $last';
  }

  @override
  String get accountImportScanMore => 'Сканувати ще коди';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Не вдалося прочитати $count облікових записів у кодах. Можливо, у них використано налаштування новішого Thunderbird.',
      few:
          'Не вдалося прочитати $count облікові записи в кодах. Можливо, у них використано налаштування новішого Thunderbird.',
      one:
          'Не вдалося прочитати $count обліковий запис у кодах. Можливо, у ньому використано налаштування новішого Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Сканувати знову';

  @override
  String get accountImportAlreadyAdded => 'Обліковий запис із цією адресою вже є в Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Після додавання ви ввійдете через $provider, як у Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Додайте обліковий запис із паролем застосунку (потрібна двоетапна перевірка).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird входить у Gmail через Google. «Увійти через Google» з’явиться в одній із наступних збірок; доти додайте обліковий запис із паролем застосунку (потрібна двоетапна перевірка).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird входить у цей обліковий запис через браузер. Loupe поки так не вміє: скористайтеся паролем застосунку, якщо ваш провайдер його пропонує.';

  @override
  String get accountImportUnencrypted => 'Підключається без шифрування. Використовуйте це лише у власній мережі.';

  @override
  String get accountImportEnterAgain => 'Введіть його ще раз';

  @override
  String get accountImportAdded => 'Додано';

  @override
  String accountImportAdding(int index, int total) {
    return 'Додавання $index з $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Додати $count облікових записів',
      few: 'Додати $count облікові записи',
      one: 'Додати $count обліковий запис',
      zero: 'Додати облікові записи',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Вставте текст експорту';

  @override
  String get accountImportPasteText => 'Вставте текст коду експорту Thunderbird, по одному коду в рядку.';

  @override
  String get accountImportPop3 => 'Облікові записи POP3 не підтримуються. Loupe зберігає пошту на сервері через IMAP.';

  @override
  String get accountImportKerberos => 'Цей обліковий запис входить через Kerberos, який Loupe не підтримує.';

  @override
  String get accountImportNtlm => 'Цей обліковий запис входить через NTLM, який Loupe не підтримує.';

  @override
  String get accountImportClientCertificate =>
      'Цей обліковий запис входить із клієнтським сертифікатом, який Loupe поки не підтримує.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Вхід через Microsoft з’явиться в одній із наступних збірок. Облікові записи Outlook і Microsoft 365 більше не приймають паролі від поштових застосунків.';

  @override
  String get accountImportEnterPassword => 'Введіть пароль.';

  @override
  String get accountImportEnterAppPassword => 'Введіть пароль застосунку.';

  @override
  String get accountImportEnterApiToken => 'Введіть API-токен.';

  @override
  String get accountImportStorageFailed => 'Loupe не вдалося відкрити сховище облікових записів. Спробуйте пізніше.';

  @override
  String get accountImportFailed => 'Не вдалося додати обліковий запис. Спробуйте ще раз або додайте його вручну.';

  @override
  String get composeNewMessageTitle => 'Новий лист';

  @override
  String get composeAttach => 'Вкласти';

  @override
  String get composeSendLater => 'Надіслати пізніше';

  @override
  String composeSendAt(String time) {
    return 'Надіслати $time';
  }

  @override
  String get composeSendHint => 'Утримуйте, щоб надіслати пізніше';

  @override
  String get composeNoAccount => 'Додайте обліковий запис, щоб надсилати пошту.';

  @override
  String get composeTo => 'Кому:';

  @override
  String get composeCc => 'Копія:';

  @override
  String get composeBcc => 'Прихована копія:';

  @override
  String composeCcBccFrom(String email) {
    return 'Копія, прихована копія, від: $email';
  }

  @override
  String get composeFromLabel => 'Від:';

  @override
  String get composeSubjectLabel => 'Тема:';

  @override
  String composeReplyTo(String address) {
    return 'Відповідати на: $address';
  }

  @override
  String get composeFrom => 'Від';

  @override
  String composeReplyFrom(String email) {
    return 'Відповісти з $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Надіслати з $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Відповісти з $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Надіслати з $email?';
  }

  @override
  String get composeDismiss => 'Закрити';

  @override
  String composeAliasNotSaved(String account) {
    return 'Не збережено як профіль · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Зберегти як профіль';

  @override
  String composeAliasSaved(String email) {
    return '$email збережено як профіль.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Недійсна адреса $address';
  }

  @override
  String get composeOriginalNotFound => 'Не вдалося знайти оригінальний лист.';

  @override
  String get composeDraftNotFound => 'Не вдалося знайти чернетку.';

  @override
  String get composeAttachmentsLost => 'Не вдалося відновити вкладення. Додайте їх знову.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Не вдалося додати деякі вкладення: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Загальний розмір вкладень — $size; деякі сервери відхиляють такі великі листи.';
  }

  @override
  String get composeAttachFailed => 'Не вдалося вкласти файл.';

  @override
  String get composeInvalidAddressTitle => 'Недійсна адреса';

  @override
  String composeInvalidAddress(String address) {
    return '«$address» — недійсна адреса електронної пошти.';
  }

  @override
  String get composeNoSubjectTitle => 'Без теми';

  @override
  String get composeNoSubjectText => 'У цього листа немає теми. Усе одно надіслати?';

  @override
  String get composeSentBeforeChanges => 'Лист надіслано до ваших змін; їх збережено в «Чернетках».';

  @override
  String composeScheduled(String time) {
    return 'Заплановано: $time';
  }

  @override
  String get composeSending => 'Надсилання…';

  @override
  String get composeSent => 'Надіслано';

  @override
  String get composeSendFailed => 'Не вдалося надіслати. Спробуйте ще раз.';

  @override
  String get composeAlreadySent => 'Уже надіслано.';

  @override
  String get composeDiscardChanges => 'Відкинути зміни';

  @override
  String get composeSaveChanges => 'Зберегти зміни';

  @override
  String get composeDeleteDraft => 'Видалити чернетку';

  @override
  String get composeSaveDraft => 'Зберегти чернетку';

  @override
  String get composeDraftSaved => 'Чернетку збережено';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date о $time $name пише:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date о $time хтось пише:';
  }

  @override
  String get composeForwardHeader => '---------- Пересланий лист ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Від: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Дата: $date о $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Тема: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Кому: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Копія: $addresses';
  }

  @override
  String get composeLaterToday => 'Пізніше сьогодні';

  @override
  String get composeTomorrowMorning => 'Завтра вранці';

  @override
  String get composeMondayMorning => 'У понеділок уранці';

  @override
  String get composePickDateTime => 'Вибрати дату й час…';

  @override
  String get composeSendWithoutDelay => 'Надіслати без затримки';

  @override
  String composeSendTimeToday(String time) {
    return 'Сьогодні о $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Завтра о $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day о $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Сьогодні $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Завтра $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Продовжити редагування чернетки?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Лист не було надіслано, коли Loupe закрився.',
      'one': 'Лист для $name не було надіслано, коли Loupe закрився.',
      'other': 'Лист для $name та інших не було надіслано, коли Loupe закрився.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Лист «$subject» не було надіслано, коли Loupe закрився.',
      'one': 'Лист «$subject» для $name не було надіслано, коли Loupe закрився.',
      'other': 'Лист «$subject» для $name та інших не було надіслано, коли Loupe закрився.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Продовжити редагування';

  @override
  String get composeRecoverySave => 'Зберегти в чернетки';

  @override
  String get composeRecoveryDiscard => 'Відкинути';

  @override
  String get composeRecoverySaved => 'Збережено в чернетки';

  @override
  String get outboxSectionFailed => 'Не надіслано';

  @override
  String get outboxSectionSending => 'Надсилання';

  @override
  String get outboxSectionScheduled => 'Заплановано';

  @override
  String get outboxStatusQueued => 'Незабаром буде надіслано';

  @override
  String get outboxStatusSending => 'Надсилання…';

  @override
  String get outboxStatusFailed => 'Не надіслано';

  @override
  String get outboxNoRecipients => 'Без одержувачів';

  @override
  String get outboxNoSubject => '(Без теми)';

  @override
  String get outboxSendingFailed => 'Не вдалося надіслати.';

  @override
  String get outboxEmptyTitle => 'Нічого надсилати';

  @override
  String get outboxEmptyText => 'Листи, які ви надсилаєте пізніше, чекають тут свого часу.';

  @override
  String get outboxSendNow => 'Надіслати зараз';

  @override
  String get outboxReschedule => 'Перенести';

  @override
  String get outboxRescheduleMenu => 'Перенести…';

  @override
  String get outboxRescheduleTitle => 'Перенести';

  @override
  String outboxRescheduled(String time) {
    return 'Перенесено: $time';
  }

  @override
  String get outboxCancel => 'Скасувати';

  @override
  String get outboxCancelSending => 'Скасувати надсилання…';

  @override
  String get outboxCancelTitle => 'Скасувати надсилання?';

  @override
  String get outboxMoveToDrafts => 'Перемістити в чернетки';

  @override
  String get outboxDiscard => 'Відкинути лист';

  @override
  String get outboxMovedToDrafts => 'Переміщено в чернетки';

  @override
  String get outboxDiscarded => 'Лист відкинуто';

  @override
  String get outboxAlreadySent => 'Уже надіслано.';

  @override
  String get outboxBeingSent => 'Цей лист зараз надсилається.';

  @override
  String get outboxActionFailed => 'Не вдалося. Лист досі у «Вихідних».';

  @override
  String get notificationsBadgeInboxes => 'Непрочитані у вхідних';

  @override
  String get notificationsBadgeVip => 'Непрочитані від VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Нова пошта від ваших VIP у будь-якому обліковому записі';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Нова пошта в $email';
  }

  @override
  String get notificationsUnknownSender => 'Невідомий відправник';

  @override
  String get notificationsNoSubject => '(Без теми)';

  @override
  String get notificationsEncryptedMessage => 'Зашифрований лист';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Новий лист від $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нових листів',
      few: '$count нові листи',
      one: '$count новий лист',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Нові листи в $account';
  }

  @override
  String get platformInstantChannel => 'Миттєва доставка';

  @override
  String get platformInstantChannelDescription => 'Показується, поки Loupe стежить за новою поштою у ваших вхідних';

  @override
  String get platformInstantTitle => 'Очікування нової пошти';

  @override
  String get platformInstantText => 'Миттєву доставку ввімкнено';

  @override
  String get platformErrorBox => 'Не вдалося це показати. Поверніться назад і спробуйте ще раз.';

  @override
  String get welcomeTagline => 'Пошта, проста зовні\nй потужна всередині.';

  @override
  String get welcomeAccountsTitle => 'Усі облікові записи — одна спокійна скринька';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail і будь-який сервер IMAP чи JMAP.';

  @override
  String get welcomeSearchTitle => 'Пошук, який знаходить';

  @override
  String get welcomeSearchText => 'Миттєві результати на телефоні, а потім — із сервера.';

  @override
  String get welcomePrivacyTitle => 'Приватність за задумом';

  @override
  String get welcomePrivacyText => 'Без стеження. Віддалені зображення заблоковано, доки ви їх не дозволите.';

  @override
  String get welcomeAddAccount => 'Додати обліковий запис';

  @override
  String get welcomeImport => 'Імпортувати з Thunderbird';

  @override
  String get welcomeTryDemo => 'Спробувати з демопоштою';
}
