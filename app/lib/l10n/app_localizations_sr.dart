// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

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
  String get commonMore => 'Још';

  @override
  String get commonMove => 'Премести';

  @override
  String get commonName => 'Име';

  @override
  String get commonNone => 'Нема';

  @override
  String get commonOff => 'Искључено';

  @override
  String get commonOk => 'У реду';

  @override
  String get commonOn => 'Укључено';

  @override
  String get commonOptional => 'Опционално';

  @override
  String get commonPassword => 'Лозинка';

  @override
  String get commonRemove => 'Уклони';

  @override
  String get commonRetry => 'Покушај поново';

  @override
  String get commonSave => 'Сачувај';

  @override
  String get commonSearch => 'Претрага';

  @override
  String get commonServer => 'Сервер';

  @override
  String get commonSettings => 'Подешавања';

  @override
  String get commonShare => 'Дели';

  @override
  String get commonTryAgain => 'Покушај поново';

  @override
  String get commonUndo => 'Опозови';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука',
      few: '$count поруке',
      one: '$count порука',
    );
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Архивирај';

  @override
  String get mailDelete => 'Избриши';

  @override
  String get mailFlag => 'Означи заставицом';

  @override
  String get mailForward => 'Проследи';

  @override
  String get mailMarkAsRead => 'Означи као прочитано';

  @override
  String get mailMarkAsUnread => 'Означи као непрочитано';

  @override
  String get mailMoveToJunk => 'Премести у Непожељно';

  @override
  String get mailNewMessage => 'Нова порука';

  @override
  String get mailNoSubject => 'Без теме';

  @override
  String get mailReply => 'Одговори';

  @override
  String get mailReplyAll => 'Одговори свима';

  @override
  String get mailSend => 'Пошаљи';

  @override
  String get mailUnflag => 'Уклони заставицу';

  @override
  String get mailboxArchive => 'Архива';

  @override
  String get mailboxDrafts => 'Нацрти';

  @override
  String get mailboxInbox => 'Пријемно сандуче';

  @override
  String get mailboxJunk => 'Непожељно';

  @override
  String get mailboxOutbox => 'Пошта за слање';

  @override
  String get mailboxSent => 'Послато';

  @override
  String get mailboxTrash => 'Смеће';

  @override
  String get conversationSomethingWentWrong => 'Дошло је до грешке. Покушајте поново.';

  @override
  String get conversationReplyToList => 'Одговори листи';

  @override
  String get conversationReplyList => 'Одговори листи';

  @override
  String get conversationThreadMuted => 'Нит је утишана. Нове поруке у њој стижу као прочитане.';

  @override
  String get conversationThreadUnmuted => 'Утишавање нити је укинуто.';

  @override
  String get conversationLinkFailed => 'Отварање линка није успело.';

  @override
  String get conversationGoneTitle => 'Нема поруке';

  @override
  String get conversationGoneText => 'Ова порука је премештена или избрисана.';

  @override
  String get conversationMuted => 'Утишано';

  @override
  String get conversationReaderOptions => 'Опције читања';

  @override
  String get conversationReaderOptionsHint => 'Величина текста и приказ';

  @override
  String get conversationTrash => 'У смеће';

  @override
  String get conversationReplyHint => 'Дуго притисните за „Одговори свима“ и „Проследи“';

  @override
  String get conversationOfflineTitle => 'Нисте на мрежи';

  @override
  String get conversationOfflineText => 'Овај разговор још није преузет. Учитаће се када се поново повежете.';

  @override
  String get conversationErrorTitle => 'Порука не може да се прикаже';

  @override
  String get conversationErrorText => 'Дошло је до грешке.';

  @override
  String get conversationOfflineBanner => 'Нисте на мрежи';

  @override
  String get conversationNotUpdated => 'Није ажурирано';

  @override
  String get conversationMe => 'ја';

  @override
  String get conversationNoSender => '(без пошиљаоца)';

  @override
  String get conversationNoRecipients => 'без прималаца';

  @override
  String conversationRecipients(String names) {
    return 'за: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'за: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Од';

  @override
  String get conversationHeaderTo => 'За';

  @override
  String get conversationHeaderCc => 'Копија';

  @override
  String get conversationHeaderBcc => 'Скривена копија';

  @override
  String get conversationHeaderReplyTo => 'Одговор на';

  @override
  String get conversationHeaderDate => 'Датум';

  @override
  String get conversationHeaderSecurity => 'Безбедност';

  @override
  String get conversationVerifiedSender => 'Потврђен пошиљалац';

  @override
  String get conversationUnverifiedSender => 'Непотврђен пошиљалац';

  @override
  String get conversationLoadingMessage => 'Учитавање поруке';

  @override
  String get conversationBodyError => 'Ова порука није могла да се учита.';

  @override
  String get conversationBodyOffline => 'Нисте на мрежи. Порука ће се учитати када се поново повежете.';

  @override
  String get conversationOriginalHint => 'Боље изгледа у приказу „Оригинал“';

  @override
  String get conversationShowOriginal => 'Прикажи оригинал';

  @override
  String get conversationScrollToTop => 'Помера на врх';

  @override
  String get conversationTagsMenu => 'Ознаке…';

  @override
  String get conversationMuteThread => 'Утишај нит';

  @override
  String get conversationUnmuteThread => 'Укини утишавање нити';

  @override
  String get conversationMoveMenu => 'Премести…';

  @override
  String get conversationDeletePermanently => 'Трајно избриши';

  @override
  String get conversationMoveToTrash => 'Премести у смеће';

  @override
  String get conversationNotJunk => 'Није непожељно';

  @override
  String get conversationShowAllHeaders => 'Прикажи сва заглавља';

  @override
  String get conversationViewSource => 'Прикажи извор';

  @override
  String get conversationSaveAsFile => 'Сачувај као датотеку…';

  @override
  String get conversationShareAsFile => 'Дели као датотеку…';

  @override
  String get conversationSearchFromMessageMenu => 'Претражи на основу ове поруке…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Копирај адресу';

  @override
  String get conversationAddressCopied => 'Адреса је копирана';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Претражи поруке пошиљаоца $name';
  }

  @override
  String get conversationTags => 'Ознаке';

  @override
  String get conversationAllHeaders => 'Сва заглавља';

  @override
  String get conversationCopyAll => 'Копирај све';

  @override
  String get conversationHeadersCopied => 'Заглавља су копирана';

  @override
  String get conversationNoHeaders => 'Нема заглавља';

  @override
  String get conversationSearchFromMessageTitle => 'Претрага на основу ове поруке';

  @override
  String conversationSearchFrom(String name) {
    return 'Од: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'За: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Тема „$subject“';
  }

  @override
  String get conversationSourceTitle => 'Извор';

  @override
  String get conversationSourceCopied => 'Извор је копиран';

  @override
  String get conversationShareFailed => 'Дељење поруке није успело.';

  @override
  String get conversationWrapLines => 'Преламај редове';

  @override
  String get conversationDontWrapLines => 'Не преламај редове';

  @override
  String get conversationSourceError => 'Извор није могао да се учита.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Приказано је првих $shown од $total. Копирајте или поделите да бисте добили све.';
  }

  @override
  String get conversationAttachmentUntitled => 'Без назива';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Још радњи за $name';
  }

  @override
  String get conversationMoveTo => 'Премести у…';

  @override
  String get conversationMailboxesError => 'Учитавање сандучића није успело.';

  @override
  String get conversationReaderReadable => 'Читљиво';

  @override
  String get conversationReaderOriginal => 'Оригинал';

  @override
  String get conversationReaderPlain => 'Обичан текст';

  @override
  String get conversationReaderSans => 'Бесерифни';

  @override
  String get conversationReaderMono => 'Моно';

  @override
  String get conversationReaderKeepColours => 'Задржи оригиналне боје';

  @override
  String get conversationReaderRemember => 'Запамти за овог пошиљаоца';

  @override
  String get conversationSecurityPossiblePhishing => 'Могући фишинг';

  @override
  String get conversationSecurityBeCareful => 'Будите опрезни';

  @override
  String get conversationSecurityVerified => 'Потврђено';

  @override
  String get conversationSecurityNoIssues => 'Нису пронађени проблеми';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count елемената за праћење',
      few: '$count елемента за праћење',
      one: '$count елемент за праћење',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Приказује разлог';

  @override
  String get conversationPhishingBannerTitle => 'Ова порука изгледа као фишинг';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Линкови и слике су искључени.';
  }

  @override
  String get conversationPhishingBannerText => 'Линкови и слике су искључени.';

  @override
  String get conversationPhishingWhy => 'Зашто?';

  @override
  String get conversationPhishingShowAnyway => 'Ипак прикажи';

  @override
  String get conversationSecurityPhishingTitle => 'Ово изгледа као фишинг';

  @override
  String get conversationSecurityPhishingText =>
      'Више знакова указује на то да ова порука није оно за шта се представља.';

  @override
  String get conversationSecurityCarefulTitle => 'Будите опрезни са овом поруком';

  @override
  String get conversationSecurityCarefulText => 'Нешто у њој заслужује да се боље погледа.';

  @override
  String get conversationSecurityVerifiedText => 'Пошиљалац је потврђен и ништа не изгледа сумњиво.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Ништа не изгледа сумњиво. Ваш сервер е-поште није навео да ли је пошиљалац потврђен.';

  @override
  String get conversationSecurityNothingSuspicious => 'Ништа не изгледа сумњиво.';

  @override
  String get conversationSecurityWhy => 'Зашто';

  @override
  String get conversationSecurityPrivacy => 'Приватност';

  @override
  String get conversationSecurityNoTrackingPixels => 'Нема пиксела за праћење';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Уклоњено је $count пиксела за праћење',
      few: 'Уклоњена су $count пиксела за праћење',
      one: 'Уклоњен је $count пиксел за праћење',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Они би пошиљаоцу јавили када сте отворили ову поруку.';

  @override
  String get conversationSecurityNoRemoteImages => 'Нема удаљених слика';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count удаљених слика',
      few: '$count удаљене слике',
      one: '$count удаљена слика',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ако их учитате, пошиљалац сазнаје када читате ову поруку, као и вашу IP адресу.';

  @override
  String get conversationSecurityNoClickTracking => 'Нема праћења кликова';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count линкова са праћењем кликова',
      few: '$count линка са праћењем кликова',
      one: '$count линк са праћењем кликова',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Ваш клик би забележили: $services. Дуго притисните линк да бисте директно отворили његово одредиште.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Технички детаљи';

  @override
  String get conversationSecurityCheckedLocally => 'Проверено на овом уређају. Ништа није никуда послато.';

  @override
  String get conversationSecurityTrackersLabel => 'Елементи за праћење';

  @override
  String get conversationSecurityImagesFrom => 'Слике са';

  @override
  String get conversationSecuritySenderHistory => 'Историја пошиљаоца';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'примљено: $received, послато: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Линкови воде на';

  @override
  String get conversationSecurityHidden => 'Скривено';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(
      elements,
      locale: localeName,
      other: '$elements елемената',
      few: '$elements елемента',
      one: '$elements елемент',
    );
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters знакова',
      few: '$characters знака',
      one: '$characters знак',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Пошиљалац није потврђен';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Ваш сервер е-поште није могао да потврди да ова порука заиста долази са домена $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Ваш сервер е-поште није могао да потврди да ова порука заиста долази од наведеног пошиљаоца.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Ваш сервер е-поште није могао да потврди да ова порука долази са домена $domain. То је често код мејлинг листа.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Ваш сервер е-поште није могао да потврди да ова порука долази од наведеног пошиљаоца. То је често код мејлинг листа.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Не поступајте по њој осим ако сте је очекивали. Ако нисте сигурни, контактирајте пошиљаоца на други начин.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Потписао други домен';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Поруку је потписао домен $signer, а не $domain. Сервиси за слање поште то раде, али то не доказује ко ју је написао.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Поруку је потписао други домен, а не $domain. Сервиси за слање поште то раде, али то не доказује ко ју је написао.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Име приказује другу адресу';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'У имену пошиљаоца пише „$shown“, али порука долази са адресе $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Верујте адреси, а не имену.';

  @override
  String get conversationSecurityReplyToTitle => 'Одговори иду на другу адресу';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Ваш одговор би отишао на адресу $address, а не на домен $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Проверите адресу пре него што у одговору пошаљете било шта лично.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Користи ваше име';

  @override
  String get conversationSecurityImpersonationTitle => 'Користи име особе коју познајете';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Потписана је именом „$name“, истим као ваше, али долази са нове адресе: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Потписана је именом „$name“, као ваш VIP контакт $knownName ($knownEmail), али долази са нове адресе: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Потписана је именом „$name“, као $knownName ($knownEmail), али долази са нове адресе: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Уз то, одговори би ишли на још једну другу адресу.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Ако тражи новац, кодове или датотеке, прво проверите са том особом на други начин.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Позната адреса: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Ова адреса: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Прва порука од овог пошиљаоца';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Досад нисте примали пошту са адресе $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Будите опрезни са захтевима људи које још не познајете.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Слова сличног изгледа у адреси пошиљаоца';

  @override
  String get conversationSecurityLinkHomographTitle => 'Слова сличног изгледа у линку';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Адреса $host меша слова из различитих писама како би опонашала неку другу.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Адреса $host користи слова сличног изгледа: то није $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Избришите је или је пријавите као непожељну.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Не отварајте га.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Домен: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Домен који опонаша други';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Користи познато име у домену';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Домен $domain личи на ваш домен $real, али је то други домен.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Домен $domain личи на домен $real ($brand), али је то други домен.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Домен $domain користи име вашег домена $real, али није ваш.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Домен $domain користи назив $brand ($real), али није њихов.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Праве поруке ваше организације стижу са домена $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Праве поруке које шаље $brand стижу са домена $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Домен пошиљаоца: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Опонаша: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count линкова скрива своје одредиште',
      few: '$count линка скривају своје одредиште',
      one: '$count линк скрива своје одредиште',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Линк приказује $shown, али отвара $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Не пријављујте се и не плаћајте преко ових линкова. Уместо тога, сами укуцајте адресу.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '„$text“ → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Одредиште линка не може да се провери';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Линк приказује $shown, али иде преко домена $host, који бележи клик пре него што га проследи даље.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Линк води директно на IP адресу';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts није веб-сајт са именом. Праве компаније ретко тако постављају линкове.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Прикривен линк';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Линк почиње са „$shown@“ да би личио на $shown, али отвара $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Скривена страница је онемогућена';

  @override
  String get conversationSecurityDataLinkText =>
      'Линк би отворио страницу упаковану у саму поруку, што је начин да се заобиђу провере линкова.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Тражи лозинку';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Порука је садржала поље за лозинку. Апликација Loupe га је уклонила.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Никада не уносите лозинку у поруку е-поште.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Линк који покреће код је онемогућен';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe никада не покреће код из порука.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count скраћених линкова',
      few: '$count скраћена линка',
      one: '$count скраћени линк',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts крије право одредиште док не отворите линк.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Међународна веб-адреса';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts користи слова која нису латинична. То је уобичајено за многе језике; проверите да ли је то сајт који очекујете.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Много скривеног текста';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Уклоњено је $count знакова невидљивог текста. Овакав скривени текст служи да превари филтере за непожељну пошту.',
      few:
          'Уклоњена су $count знака невидљивог текста. Овакав скривени текст служи да превари филтере за непожељну пошту.',
      one:
          'Уклоњен је $count знак невидљивог текста. Овакав скривени текст служи да превари филтере за непожељну пошту.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Скривени текст је уклоњен';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Уклоњено је $count знакова невидљивог текста.',
      few: 'Уклоњена су $count знака невидљивог текста.',
      one: 'Уклоњен је $count знак невидљивог текста.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Преузимање поруке није успело. Проверите везу и покушајте поново.';

  @override
  String exportSaved(String name) {
    return 'Сачувано: „$name“';
  }

  @override
  String get exportSaveFailed => 'Порука није могла да се сачува.';

  @override
  String exportFailed(String folder) {
    return 'Извоз фасцикле „$folder“ није успео.';
  }

  @override
  String exportEmpty(String folder) {
    return 'Фасцикла „$folder“ нема порука за извоз.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Извоз фасцикле „$folder“ није успео: ниједна порука није могла да се преузме. Проверите везу и покушајте поново.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Сачувано: „$name“, без $formattedCount порука које нису могле да се преузму.',
      few: 'Сачувано: „$name“, без $formattedCount поруке које нису могле да се преузму.',
      one: 'Сачувано: „$name“, без $count поруке која није могла да се преузме.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Датотека „$name“ није могла да се сачува.';
  }

  @override
  String exportTitle(String folder) {
    return 'Извоз фасцикле „$folder“';
  }

  @override
  String get exportListing => 'Тражење порука…';

  @override
  String exportProgress(String current, String total) {
    return 'Извоз: $current од $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount порука није могло да се преузме',
      few: '$formattedCount поруке нису могле да се преузму',
      one: '$count порука није могла да се преузме',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Сандучићи';

  @override
  String get mailboxesShown => 'Приказано';

  @override
  String get mailboxesHidden => 'Скривено';

  @override
  String get mailboxesCollapse => 'Скупи';

  @override
  String get mailboxesExpand => 'Прошири';

  @override
  String get mailboxesManageVips => 'Управљај VIP контактима';

  @override
  String get mailboxesSubscriptions => 'Претплате';

  @override
  String mailboxesShowAccount(String account) {
    return 'Прикажи налог $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Сакриј налог $account';
  }

  @override
  String get mailboxesExportFolder => 'Извези фасциклу…';

  @override
  String get mailboxesUnpin => 'Откачи';

  @override
  String get mailboxesLists => 'Листе';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Сачувајте претрагу да бисте је имали овде.';

  @override
  String get mailboxesTags => 'Ознаке';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Можете и да додирнете име пошиљаоца у поруци и да укључите VIP.';

  @override
  String get mailboxesAddVip => 'Додај VIP контакт…';

  @override
  String get mailboxesAddVipTitle => 'Додај VIP контакт';

  @override
  String get mailboxesAddVipText => 'Пошта са ове адресе добија звездицу и појављује се у сандучету VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Непрочитано';

  @override
  String get messageListFilterFlagged => 'Са заставицом';

  @override
  String get messageListFilterToMe => 'За мене';

  @override
  String get messageListFilterCcMe => 'Копија мени';

  @override
  String get messageListFilterWithAttachments => 'Са прилозима';

  @override
  String get messageListFilterUnreplied => 'Без одговора';

  @override
  String get messageListFilterFromVips => 'Од VIP контаката';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је означено као прочитано',
      few: '$count поруке су означене као прочитане',
      one: '$count порука је означена као прочитана',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Учитавање старије поште није успело.';

  @override
  String get messageListSelectMessages => 'Изаберите поруке';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изабрано: $count',
      few: 'Изабрано: $count',
      one: 'Изабрано: $count',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Изабери све';

  @override
  String get messageListDeselectAll => 'Поништи избор';

  @override
  String get messageListLoadFailed => 'Учитавање поште није успело';

  @override
  String get messageListNoUnread => 'Нема непрочитане поште';

  @override
  String get messageListNoMatches => 'Нема одговарајуће поште';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Филтрирано по: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Искључи филтер';

  @override
  String get messageListEmpty => 'Нема поште';

  @override
  String get messageListFilter => 'Филтер';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Критеријуми филтера: $filters';
  }

  @override
  String get messageListFilteredBy => 'Филтрирано по:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount непрочитаних',
      few: '$formattedCount непрочитане',
      one: '$count непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Означи';

  @override
  String get messageListTrash => 'У смеће';

  @override
  String get messageListFilterTitle => 'Филтер';

  @override
  String get messageListFilterInclude => 'ПРИКАЖИ';

  @override
  String get panesHideMailboxes => 'Сакриј сандучиће';

  @override
  String get panesShowMailboxes => 'Прикажи сандучиће';

  @override
  String get panesMailboxesWidth => 'Ширина колоне сандучића';

  @override
  String get panesListWidth => 'Ширина листе порука';

  @override
  String get panesNoMessageSelected => 'Ниједна порука није изабрана';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука',
      few: '$count поруке',
      one: '$count порука',
    );
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Одложено';

  @override
  String get snoozeSheetTitle => 'Одлагање';

  @override
  String get snoozeLaterToday => 'Касније данас';

  @override
  String get snoozeThisEvening => 'Вечерас';

  @override
  String get snoozeTomorrow => 'Сутра';

  @override
  String get snoozeThisWeekend => 'Овог викенда';

  @override
  String get snoozeNextWeek => 'Следеће недеље';

  @override
  String get snoozePickDateTime => 'Изабери датум и време…';

  @override
  String get snoozeMenu => 'Одложи…';

  @override
  String get snoozeWakeNow => 'Врати сада';

  @override
  String get snoozeChangeTimeMenu => 'Промени време одлагања…';

  @override
  String get snoozeChangeTime => 'Промени време';

  @override
  String get snoozeNoTime => 'Време није подешено';

  @override
  String get snoozeFooter =>
      'Одложене поруке се враћају у Пријемно сандуче као непрочитане, у време које сте одредили.';

  @override
  String get snoozeEmptyTitle => 'Нема одложених порука';

  @override
  String get snoozeEmptyText => 'Одложите поруку и она ће се вратити у Пријемно сандуче када вам затреба.';

  @override
  String get appLockUnlock => 'Откључај';

  @override
  String get appLockFailed => 'Није могуће потврдити да сте то ви.';

  @override
  String get appLockLockedOut => 'Превише покушаја. Покушајте поново касније.';

  @override
  String get appLockPromptError => 'Није могуће приказати прозор за потврду. Покушајте поново.';

  @override
  String get appLockNoScreenLock => 'Овај телефон нема закључавање екрана.';

  @override
  String get appLockUnlockPromptTitle => 'Откључај Loupe';

  @override
  String get appLockUnlockPromptReason => 'Потврдите да сте то ви да бисте видели своју пошту.';

  @override
  String get appLockTurnOnPromptTitle => 'Укључи закључавање апликације';

  @override
  String get appLockTurnOnPromptReason => 'Потврдите да сте то ви да бисте укључили закључавање апликације.';

  @override
  String get appLockScreenLockRemoved =>
      'Закључавање апликације је искључено: овај телефон више нема закључавање екрана. Подесите га да бисте поново укључили закључавање апликације.';

  @override
  String get appLockAfterImmediately => 'Одмах';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минута',
      few: '$count минута',
      one: '$count минут',
    );
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сати',
      few: '$count сата',
      one: '$count сат',
    );
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Шифровано';

  @override
  String get openpgpEncryptedInPart => 'Делимично шифровано';

  @override
  String get openpgpEncryptedLocked => 'Шифровано · закључано';

  @override
  String get openpgpEncryptedNoKey => 'Шифровано · нема кључа';

  @override
  String get openpgpEncryptedDamaged => 'Шифровано · оштећено';

  @override
  String get openpgpEncryptedUnsupported => 'Шифровано · није подржано';

  @override
  String get openpgpUnknownSigner => 'непознат';

  @override
  String get openpgpUnknownKey => 'Непознат кључ';

  @override
  String get openpgpSignatureInvalid => 'Неважећи потпис';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Потписник: $name, а не пошиљалац';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Потписник дела поруке: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Потписник: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Потписано одбаченим кључем';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Потписник: $name · кључ није прихваћен';
  }

  @override
  String get openpgpUnlock => 'Откључај';

  @override
  String get openpgpCantDecrypt => 'Ова порука не може да се дешифрује';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Шифровано стандардом OpenPGP';

  @override
  String get openpgpEncryption => 'Шифровање';

  @override
  String get openpgpDecryptedHere => 'Дешифровано на овом уређају';

  @override
  String get openpgpNotDecrypted => 'Није дешифровано';

  @override
  String get openpgpKeyLocked => 'Ваш кључ је закључан.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Шифровано за: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Заштићена тема';

  @override
  String get openpgpUnlockKey => 'Откључај кључ';

  @override
  String get openpgpSignature => 'Потпис';

  @override
  String get openpgpFingerprint => 'Отисак';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ИД кључа: $id';
  }

  @override
  String get openpgpSigned => 'Потписано';

  @override
  String get openpgpProblem => 'Проблем';

  @override
  String get openpgpAcceptance => 'Прихватање';

  @override
  String get openpgpChangeAcceptance => 'Промени прихватање…';

  @override
  String get openpgpCheckedFooter =>
      'Проверено на овом уређају помоћу стандарда OpenPGP, компатибилно са програмом Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Ваш кључ је закључан. Откључајте га приступном фразом да бисте прочитали ову поруку.';

  @override
  String get openpgpSummaryNoSecretKey => 'Шифрована је за кључ који није на овом уређају.';

  @override
  String get openpgpSummaryDamaged => 'Шифровани подаци су оштећени или измењени током преноса.';

  @override
  String get openpgpSummaryUnsupported => 'Користи алгоритам који Loupe не подржава.';

  @override
  String get openpgpSummaryEncrypted => 'Само ви и остали примаоци можете да је прочитате.';

  @override
  String get openpgpSummaryNotSigned => 'Није потписана, па пошиљалац није потврђен.';

  @override
  String get openpgpSummaryUnknownKey => 'Потписана је, али кључем који немате, па потпис не може да се провери.';

  @override
  String get openpgpSummaryBadSignature => 'Потпис се не поклапа: порука је можда измењена.';

  @override
  String get openpgpSummaryMismatch => 'Потпис је важећи, али кључ припада другој адреси, а не адреси пошиљаоца.';

  @override
  String get openpgpSummaryPartial =>
      'Потписан је само део поруке. Текст изван потписа (на пример, подножје мејлинг листе) приказује се испод линије „Unsigned content“, а ни остали делови поруке, као што су прилози, нису обухваћени потписом.';

  @override
  String get openpgpSummaryOwnKey => 'Потписано вашим кључем.';

  @override
  String get openpgpSummaryVerified => 'Потпис је важећи и проверили сте отисак кључа.';

  @override
  String get openpgpSummaryUnverified => 'Потпис је важећи. Прихватили сте кључ без провере отиска.';

  @override
  String get openpgpSummaryRejected => 'Потпис је важећи, али сте одбацили овај кључ.';

  @override
  String get openpgpSummaryUndecided =>
      'Потпис је важећи, али још нисте прихватили овај кључ. Упоредите његов отисак са пошиљаоцем.';

  @override
  String get openpgpAcceptanceRejected => 'Одбачен';

  @override
  String get openpgpAcceptanceUndecided => 'Није прихваћен';

  @override
  String get openpgpAcceptanceUnverified => 'Прихваћен';

  @override
  String get openpgpAcceptanceVerified => 'Прихваћен и проверен';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Прихватити кључ контакта $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Отисак: $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Да, отисак је проверен';

  @override
  String get openpgpAcceptUnverified => 'Да, без провере';

  @override
  String get openpgpAcceptLater => 'Још не';

  @override
  String get openpgpRejectKey => 'Одбаци овај кључ';

  @override
  String get openpgpNoSubject => '(без теме)';

  @override
  String get openpgpEncryptionTitle => 'Шифровање с краја на крај';

  @override
  String get openpgpMyKeys => 'Моји OpenPGP кључеви';

  @override
  String get openpgpMyKeysFooter =>
      'Уз кључ можете да читате шифровану пошту и да потписујете и шифрујете своју. Користите Thunderbird? Извезите кључ тамо (Подешавања налога › Шифровање с краја на крај › Направи резервну копију тајног кључа у датотеку) и увезите га овде.';

  @override
  String get openpgpAddKey => 'Додај кључ…';

  @override
  String get openpgpAddresses => 'Адресе';

  @override
  String get openpgpAddressesFooter => 'Који кључ користи свака адреса и када шифрује и потписује.';

  @override
  String get openpgpCorrespondentsKeys => 'OpenPGP кључеви контаката';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Прихватите кључ када се уверите да припада свом власнику, а отисак упоредите са власником да бисте кључ означили као проверен.';

  @override
  String get openpgpImportPublicKey => 'Увези јавни кључ…';

  @override
  String get openpgpCollected => 'Прикупљени Autocrypt кључеви';

  @override
  String get openpgpCollectedFooter =>
      'Кључеви који су стигли уз поруке. Loupe може да шифрује за њих када то обе стране желе.';

  @override
  String get openpgpOnThisDevice => 'На овом уређају';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Шифроване поруке скривају своју тему. Loupe чува тему сваке поруке коју отворите у својој шифрованој бази података на овом уређају, како би се приказивала у листи, претрази и обавештењима. У позадини Loupe може да дешифрује и теме нових порука помоћу кључева без приступне фразе; за то преузима сваку поруку (до 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Дешифруј теме у позадини';

  @override
  String get openpgpIndexFooter =>
      'Претрага проналази шифроване поруке по пошиљаоцу, примаоцима и теми. Када је ово укључено, Loupe додаје и текст сваке шифроване поруке коју дешифрује у индекс претраге у својој шифрованој бази података на овом уређају, па претрага проналази поруку и по тексту. Искључивањем се тај текст уклања из индекса.';

  @override
  String get openpgpIndexDecrypted => 'Индексирај дешифроване поруке за претрагу';

  @override
  String get openpgpPassphrases => 'Приступне фразе';

  @override
  String get openpgpPassphrasesFooter =>
      'OpenPGP кључеви и S/MIME сертификати које штитите приступном фразом откључавају се по потреби. Без опције „Запамти приступне фразе“ поново се закључавају два минута после сваке употребе.';

  @override
  String get openpgpRememberPassphrases => 'Запамти приступне фразе';

  @override
  String get openpgpRememberPassphrasesDetail => 'Док се Loupe не затвори';

  @override
  String get openpgpLockKeysNow => 'Закључај кључеве сада';

  @override
  String get openpgpKeysLocked => 'Кључеви су закључани.';

  @override
  String get openpgpKeyStateRevoked => 'опозван';

  @override
  String get openpgpKeyStateExpired => 'истекао';

  @override
  String get openpgpKeyStateNeverExpires => 'не истиче';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'истиче $date';
  }

  @override
  String get openpgpNoKey => 'Нема кључа';

  @override
  String get openpgpAlwaysEncrypt => 'Увек шифруј';

  @override
  String get openpgpAddKeyTitle => 'Додавање OpenPGP кључа';

  @override
  String get openpgpAddKeyMessage => 'Увезите кључ који користите у програму Thunderbird или направите нови.';

  @override
  String get openpgpImportFromClipboard => 'Увези из привремене меморије';

  @override
  String get openpgpImportFromFile => 'Увези из датотеке';

  @override
  String get openpgpGenerateNewKey => 'Направи нови кључ';

  @override
  String get openpgpImportPublicKeyTitle => 'Увоз јавног кључа';

  @override
  String get openpgpFromClipboard => 'Из привремене меморије';

  @override
  String get openpgpFromFile => 'Из датотеке';

  @override
  String get openpgpClipboardEmpty => 'Привремена меморија је празна. Прво копирајте кључ.';

  @override
  String get openpgpKey => 'Кључ';

  @override
  String get openpgpValidityRevoked => 'Опозван';

  @override
  String openpgpValidityExpired(String date) {
    return 'Истекао $date';
  }

  @override
  String get openpgpNeverExpires => 'Не истиче';

  @override
  String openpgpValidUntil(String date) {
    return 'Важи до $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Отисак је копиран.';

  @override
  String get openpgpAlgorithm => 'Алгоритам';

  @override
  String get openpgpCreated => 'Направљен';

  @override
  String get openpgpValidity => 'Важење';

  @override
  String get openpgpProtection => 'Заштита';

  @override
  String get openpgpProtectionPassphrase => 'Приступна фраза';

  @override
  String get openpgpProtectionKeychain => 'Само складиште кључева';

  @override
  String get openpgpKeyDetailsFooter =>
      'Поделите јавни кључ да би други могли да вам шаљу шифровану пошту. Резервна копија је ваш тајни кључ, заштићен приступном фразом ако је има: не делите је ни са ким.';

  @override
  String get openpgpSharePublicKey => 'Подели јавни кључ';

  @override
  String get openpgpCopyPublicKey => 'Копирај јавни кључ';

  @override
  String get openpgpPublicKeyCopied => 'Јавни кључ је копиран.';

  @override
  String get openpgpBackUpSecretKey => 'Направи резервну копију тајног кључа';

  @override
  String get openpgpDeleteKey => 'Избриши кључ';

  @override
  String get openpgpRemoveKey => 'Уклони кључ';

  @override
  String get openpgpBackUpTitle => 'Направити резервну копију тајног кључа?';

  @override
  String get openpgpBackUpProtected =>
      'Резервна копија је заштићена приступном фразом вашег кључа. Ко има обоје, може да чита вашу пошту.';

  @override
  String get openpgpBackUpUnprotected =>
      'Овај кључ нема приступну фразу: свако ко има резервну копију може да чита вашу пошту и да потписује у ваше име.';

  @override
  String get openpgpBackUp => 'Направи копију';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Избрисати ваш кључ $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Уклонити кључ контакта $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Пошта шифрована за овај кључ више неће моћи да се чита на овом уређају, осим ако га поново не увезете.';

  @override
  String get openpgpRemoveKeyMessage => 'Касније можете поново да га увезете.';

  @override
  String get openpgpKeyHeader => 'OpenPGP кључ';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Додајте кључ на екрану „Шифровање с краја на крај“ да бисте шифровали и потписивали пошту са ове адресе.';

  @override
  String get openpgpGenerateAKey => 'Направи кључ…';

  @override
  String get openpgpSending => 'Слање';

  @override
  String get openpgpSendingFooter =>
      'Аутоматско шифровање се укључује када сваки прималац има прихваћен кључ или поуздан сертификат, или када Autocrypt покаже да то обе стране желе. Шифрована пошта је увек потписана.';

  @override
  String get openpgpEncryptAutomatically => 'Шифруј аутоматски';

  @override
  String get openpgpAlwaysEncryptDetail => 'Не шаље ако неки прималац нема кључ';

  @override
  String get openpgpSignUnencrypted => 'Потписуј нешифровану пошту';

  @override
  String get openpgpAttachPublicKey => 'Приложи мој јавни кључ';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt шаље ваш јавни кључ уз сваку поруку, па друге апликације могу да шифрују за вас без икаквог подешавања.';

  @override
  String get openpgpSendMyKey => 'Шаљи мој кључ уз пошту';

  @override
  String get openpgpPreferEncryption => 'Дај предност шифровању';

  @override
  String get openpgpPreferEncryptionDetail => 'Тражи од других да шифрују кад могу';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count година',
      few: '$count године',
      one: '$count година',
    );
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Приступне фразе се не поклапају.';

  @override
  String openpgpKeyReady(String id) {
    return 'Ваш кључ $id је спреман.';
  }

  @override
  String get openpgpNewKey => 'Нови кључ';

  @override
  String get openpgpNewKeyFor => 'Власник кључа';

  @override
  String get openpgpYourName => 'Ваше име';

  @override
  String get openpgpAddress => 'Адреса';

  @override
  String get openpgpPassphrase => 'Приступна фраза';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Опционално. Без ње кључ штити само складиште кључева на телефону, а Loupe никада не пита за фразу. Са њом Loupe тражи фразу када је кључ потребан.';

  @override
  String get openpgpRepeatPassphrase => 'Понови';

  @override
  String get openpgpExpires => 'Рок важења';

  @override
  String get openpgpExpiresFooter => 'Пре истека можете да направите нови кључ. И Thunderbird користи три године.';

  @override
  String get openpgpGenerateKey => 'Направи кључ';

  @override
  String get openpgpKeyFor => 'Кључ за адресу';

  @override
  String get openpgpCantEncrypt => 'Шифровање није могуће';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Нема OpenPGP кључа за $names, а ова адреса увек шифрује. Уклоните примаоца или увезите кључ у „Подешавања › Шифровање с краја на крај“.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Нема важећег S/MIME сертификата за $names, а ова адреса увек шифрује. Уклоните примаоца или увезите сертификат у „Подешавања › Шифровање с краја на крај“.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Нема OpenPGP кључа за $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Нема важећег S/MIME сертификата за $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Пошаљи нешифровано';

  @override
  String get openpgpCantSign => 'Потписивање није могуће';

  @override
  String get openpgpCantSignMessage =>
      'Приватни кључ вашег S/MIME сертификата није на овом уређају. Поново увезите сертификат (датотеку .p12 или .pfx) у „Подешавања › Шифровање с краја на крај“.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Нема кључа за $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Нема сертификата за $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Autocrypt кључеви';

  @override
  String get openpgpComposeEveryoneHasKey => 'Сви имају кључ';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Сви имају сертификат';

  @override
  String get openpgpComposeEncrypt => 'Шифруј';

  @override
  String get openpgpComposeSign => 'Потпиши';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, промени стандард';
  }

  @override
  String get openpgpNoKeyFound => 'Није пронађен ниједан OpenPGP кључ.';

  @override
  String get openpgpImportSecretKeyTitle => 'Увести тајни кључ?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Овај прилог садржи тајни кључ ($names). Увезите га као свој кључ само ако сте га сами извезли, на пример из програма Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Увези као мој кључ';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'ваш кључ $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Увести $count кључева ($names)?',
      few: 'Увести $count кључа ($names)?',
      one: 'Увести $count кључ ($names)?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Увези и прихвати';

  @override
  String get openpgpImportDecideLater => 'Увези, одлучи касније';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'кључ контакта $name';
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
      other: 'Приложено је $count OpenPGP кључева.',
      few: 'Приложена су $count OpenPGP кључа.',
      one: 'Приложен је $count OpenPGP кључ.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Увези';

  @override
  String get openpgpUnlockKeyTitle => 'Откључавање OpenPGP кључа';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Унесите приступну фразу за кључ $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Приступна фраза није тачна. Покушајте поново.';

  @override
  String get openpgpExplainLocked => 'Ова порука је шифрована. Откључајте свој OpenPGP кључ да бисте је прочитали.';

  @override
  String get openpgpExplainNoKey =>
      'Ова порука је шифрована, али ни за један OpenPGP кључ на овом уређају. Ако је читате у програму Thunderbird, увезите свој кључ одатле у „Подешавања › Шифровање с краја на крај“.';

  @override
  String get openpgpExplainDamaged => 'Ова шифрована порука је оштећена, па не може безбедно да се дешифрује.';

  @override
  String get openpgpExplainUnsupported => 'Ова порука користи шифровање које Loupe још не може да прочита.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ова порука је шифрована стандардом S/MIME, али ни за један сертификат на овом уређају. Увезите свој сертификат (датотеку .p12 или .pfx) у „Подешавања › Шифровање с краја на крај“.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ова порука је шифрована. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Откључајте свој S/MIME сертификат да бисте је прочитали.';

  @override
  String get openpgpAttachmentGone => 'Овај прилог више није доступан.';

  @override
  String get smimeEncrypted => 'Шифровано (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Шифровано (S/MIME) · нема сертификата';

  @override
  String get smimeEncryptedDamaged => 'Шифровано (S/MIME) · оштећено';

  @override
  String get smimeEncryptedUnsupported => 'Шифровано (S/MIME) · није подржано';

  @override
  String get smimeEncryptedLocked => 'Шифровано (S/MIME) · закључано';

  @override
  String get smimeUnknownSigner => 'непознат';

  @override
  String get smimeSignatureModified => 'Неважећи потпис: порука је измењена';

  @override
  String get smimeSignatureWeak => 'Небезбедан потпис: застарео алгоритам';

  @override
  String get smimeSignatureUncheckable => 'Потпис не може да се провери';

  @override
  String get smimeSignedCertificateMissing => 'Потписано · недостаје сертификат';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Потписник: $name · сертификат је опозван';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Потписник: $name · потписано другог датума';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Потписник: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Потписник: $name · неважећи сертификат';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Потписник: $name · сертификат није поуздан';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Потписник: $name · сертификат је истекао';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Потписник: $name · сертификат још не важи';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Потписник: $name · сертификат није за пошту';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Потписник: $name, а не пошиљалац';
  }

  @override
  String get smimeCantDecrypt => 'Ова порука не може да се дешифрује';

  @override
  String get smimeEncryptedWithSmime => 'Шифровано стандардом S/MIME';

  @override
  String get smimeEncryption => 'Шифровање';

  @override
  String get smimeDecryptedHere => 'Дешифровано на овом уређају';

  @override
  String get smimeNotDecrypted => 'Није дешифровано';

  @override
  String get smimeAuthenticated => 'аутентификовано';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count сертификата',
      few: 'за $count сертификата',
      one: 'за $count сертификат',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Потпис';

  @override
  String get smimeIssuedBy => 'Издавалац';

  @override
  String get smimeValid => 'Важи';

  @override
  String smimeValidRange(String from, String to) {
    return 'од $from до $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 отисак';

  @override
  String get smimeSigned => 'Потписано';

  @override
  String get smimeProblem => 'Проблем';

  @override
  String get smimeCheckingRevocation => 'Проверава се опозив…';

  @override
  String get smimeNotRevoked => 'Није опозван';

  @override
  String get smimeRevoked => 'Опозван';

  @override
  String get smimeRevocationUnknown => 'Непознато да ли је опозван';

  @override
  String smimeRevokedSince(String date) {
    return 'Од $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Проверено код сертификационог тела (листа опозваних сертификата), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Проверено код сертификационог тела (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Веруј издаваоцу „$name“…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Веруј овом сертификату…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Проверено на овом уређају помоћу стандарда S/MIME, компатибилно са програмима Outlook и Thunderbird; опозив је проверен код сертификационог тела.';

  @override
  String get smimeCheckedFooter =>
      'Проверено на овом уређају помоћу стандарда S/MIME, компатибилно са програмима Outlook и Thunderbird. Опозив се не проверава (Подешавања › Шифровање с краја на крај).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Веровати сертификационом телу $name за пошту?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Веровати сертификату контакта $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Сви сертификати које ово тело издаје биће поуздани, као код сертификационог тела ваше фирме. Прво упоредите отисак са власником:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Прво упоредите отисак са власником:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Веруј';

  @override
  String get smimeSummaryNoKey => 'Шифрована је за сертификат који није на овом уређају.';

  @override
  String get smimeSummaryDamaged => 'Шифровани подаци су оштећени или измењени током преноса.';

  @override
  String get smimeSummaryUnsupported => 'Користи алгоритам који Loupe не подржава.';

  @override
  String get smimeSummaryLocked => 'Ваш S/MIME сертификат је закључан.';

  @override
  String get smimeSummaryEncrypted => 'Само ви и остали примаоци можете да је прочитате.';

  @override
  String get smimeSummaryNotSigned => 'Није потписана, па пошиљалац није потврђен.';

  @override
  String get smimeSummaryModified => 'Потпис се не поклапа: порука је измењена након потписивања.';

  @override
  String get smimeSummaryUncheckable => 'Потпис не може да се провери.';

  @override
  String get smimeSummaryNoCertificate => 'Сертификат потписника није у поруци, па потпис не може да се провери.';

  @override
  String get smimeSummaryRevoked =>
      'Сертификационо тело је опозвало сертификат потписника: потпису се не може веровати.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Сертификационо тело је опозвало сертификат потписника ($reason): потпису се не може веровати.';
  }

  @override
  String get smimeDateMismatch =>
      'Потписана је више од сат времена пре или после датума поруке: можда је то стара порука поново послата.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Потпис је важећи и $issuer гарантује да сертификат припада пошиљаоцу.';
  }

  @override
  String get smimeProblemInvalidChain => 'Сертификат или неки од његових издавалаца није важећи.';

  @override
  String get smimeProblemUntrusted => 'Сертификат потиче од сертификационог тела коме Loupe не верује.';

  @override
  String get smimeProblemExpired => 'Сертификат је већ био истекао.';

  @override
  String get smimeProblemNotYetValid => 'Сертификат још није важио.';

  @override
  String get smimeProblemWrongUsage => 'Сертификат није намењен за пошту.';

  @override
  String get smimeProblemWrongAddress => 'Сертификат припада другој адреси, а не адреси пошиљаоца.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Поуздан · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Није поуздан · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Истекао $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Важи од $date';
  }

  @override
  String get smimeTrustInvalid => 'Неважећи';

  @override
  String get smimeTrustNotForMail => 'Није за пошту';

  @override
  String get smimeTrustAnotherAddress => 'Друга адреса';

  @override
  String get smimeMyCertificates => 'Моји S/MIME сертификати';

  @override
  String get smimeMyCertificatesFooter =>
      'За S/MIME, који користе Outlook и многе фирме. Увезите свој сертификат са приватним кључем (датотеку .p12 или .pfx), извезен из програма Outlook и Thunderbird или из система Windows и macOS.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'За S/MIME, који користе Outlook и многе фирме. Увезите свој сертификат са приватним кључем (датотеку .p12 или .pfx), извезен из програма Outlook и Thunderbird или из система Windows и macOS, или користите сертификат који сте ви или ваша фирма инсталирали на овај уређај.';

  @override
  String get smimeCertificateExpired => 'истекао';

  @override
  String smimeCertificateUntil(String date) {
    return 'важи до $date';
  }

  @override
  String get smimeCertificateOnDevice => 'на овом уређају';

  @override
  String get smimeImportCertificateEllipsis => 'Увези сертификат…';

  @override
  String get smimeUseDeviceCertificate => 'Користи сертификат са овог уређаја…';

  @override
  String get smimeCorrespondentsCertificates => 'Сертификати контаката';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Прикупљени из потписане поште, као што то раде Outlook и Thunderbird. Пошта се шифрује само за поуздане сертификате: Loupe верује сертификационим телима којима Mozilla верује за е-пошту, као и онима које ви додате.';

  @override
  String get smimeRevocation => 'Опозив';

  @override
  String get smimeRevocationFooter =>
      'Када отворите потписану пошту, Loupe пита сертификационо тело које је издало сертификат потписника да ли је тај сертификат опозван (преко његовог OCSP сервера или листе опозваних сертификата). Тело тада може да види када неко са ваше интернет адресе чита пошту потписану тим сертификатом. Одговори се чувају на овом уређају док не истекну. Опозван сертификат се у заглављу поруке приказује као „сертификат је опозван“.';

  @override
  String get smimeCheckRevocation => 'Проверавај опозив сертификата преко интернета';

  @override
  String get smimeTrustedAuthorities => 'Поуздана сертификациона тела';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Поуздана по вашем избору, поред $count тела којима Mozilla верује за е-пошту.',
      few: 'Поуздана по вашем избору, поред $count тела којима Mozilla верује за е-пошту.',
      one: 'Поуздана по вашем избору, поред $count тела коме Mozilla верује за е-пошту.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Сертификационо тело';

  @override
  String get smimeImportACertificate => 'Увоз сертификата';

  @override
  String get smimeImportContactMessage => 'Сертификат контакта (.cer, .crt, .pem) или сертификационог тела.';

  @override
  String get smimeFromClipboard => 'Из привремене меморије';

  @override
  String get smimeFromFile => 'Из датотеке';

  @override
  String get smimeClipboardEmpty => 'Привремена меморија је празна. Прво копирајте сертификат.';

  @override
  String get smimeCertificate => 'Сертификат';

  @override
  String get smimeOnDeviceFooter =>
      'Његов приватни кључ остаје у складишту акредитива система Android, где сте га ви или ваша фирма инсталирали: Loupe тражи од система Android да њиме потписује и дешифрује. Потписана пошта се потписује у тренутку слања.';

  @override
  String get smimeAddresses => 'Адресе';

  @override
  String get smimeUsage => 'Намена';

  @override
  String get smimeUsageNone => 'Ништа што Loupe користи';

  @override
  String get smimeUsageSigning => 'Потписивање';

  @override
  String get smimeUsageEncryption => 'Шифровање';

  @override
  String get smimeUsageCertificates => 'Издавање сертификата';

  @override
  String get smimeAlgorithm => 'Алгоритам';

  @override
  String get smimeSerialNumber => 'Серијски број';

  @override
  String get smimeFingerprintCopied => 'Отисак је копиран.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 отисак';

  @override
  String get smimePrivateKey => 'Приватни кључ';

  @override
  String get smimeKeyOnDevice => 'На овом уређају';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'У апликацији Loupe, са приступном фразом';

  @override
  String get smimeKeyInLoupe => 'У апликацији Loupe';

  @override
  String get smimeSource => 'Извор';

  @override
  String get smimeSourceSignedMail => 'Потписана пошта';

  @override
  String get smimeSourceImported => 'Увезен';

  @override
  String get smimeTrustHeader => 'Поверење';

  @override
  String get smimeTrustedRoot => 'Поуздани корени сертификат';

  @override
  String get smimeIssuer => 'Издавалац';

  @override
  String smimeTrustNamed(String name) {
    return 'Веруј издаваоцу „$name“';
  }

  @override
  String get smimeTrustThisAuthority => 'Веруј овом сертификационом телу';

  @override
  String get smimeTrustThisCertificate => 'Веруј овом сертификату';

  @override
  String get smimeStopTrusting => 'Уклони поверење';

  @override
  String get smimePassphrase => 'Приступна фраза';

  @override
  String get smimePassphraseFooter =>
      'Опционално. Са приступном фразом приватни кључ је на овом уређају додатно шифрован (Argon2id и AES-256), а Loupe је тражи за потписивање и дешифровање; колико дуго је памти, одређује „Запамти приступне фразе“. Пошта коју шаљете потписује се у тренутку слања; послови у позадини не могу да користе кључ.';

  @override
  String get smimeChangePassphrase => 'Промени приступну фразу…';

  @override
  String get smimeSetPassphraseEllipsis => 'Постави приступну фразу…';

  @override
  String get smimeRemovePassphrase => 'Уклони приступну фразу';

  @override
  String get smimeShareCertificate => 'Подели сертификат';

  @override
  String get smimeDeleteCertificate => 'Избриши сертификат';

  @override
  String get smimeRemoveCertificate => 'Уклони сертификат';

  @override
  String get smimePassphraseChanged => 'Приступна фраза је промењена.';

  @override
  String get smimePassphraseSet => 'Приступна фраза је постављена.';

  @override
  String get smimeRemovePassphraseTitle => 'Уклонити приступну фразу?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Приватни кључ ће тада штитити само складиште кључева на телефону, као када нема приступне фразе: Loupe је више неће тражити, а послови у позадини моћи ће да га користе.';

  @override
  String get smimePassphraseRemoved => 'Приступна фраза је уклоњена.';

  @override
  String smimeTrustTitle(String name) {
    return 'Веровати сертификату $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Сви сертификати које издаје биће поуздани за пошту. Прво упоредите отисак са власником:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Избрисати ваш сертификат $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Уклонити сертификат контакта $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe престаје да га користи: пошта шифрована за њега више не може да се чита у апликацији Loupe. Сертификат остаје на овом уређају (Подешавања › Безбедност › Шифровање и акредитиви).';

  @override
  String get smimeDeleteOwnMessage =>
      'Његов приватни кључ се брише са овог уређаја: пошта шифрована за њега више неће моћи да се чита овде, осим ако га поново не увезете.';

  @override
  String get smimeRemoveContactMessage => 'Вратиће се уз следећу потписану поруку тог контакта.';

  @override
  String get smimeAddressImportFooter =>
      'Увезите сертификат за ову адресу да бисте потписивали и шифровали помоћу стандарда S/MIME, као што то ради Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Увези сертификат…';

  @override
  String get smimePreferFooter =>
      'Када поруку могу да заштите оба стандарда, користи се онај коме сте дали предност, осим ако само други има кључ или сертификат за сваког примаоца.';

  @override
  String get smimePreferSmime => 'Дај предност стандарду S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Уместо стандарда OpenPGP';

  @override
  String get smimeCertificatePassword => 'Лозинка сертификата';

  @override
  String get smimeCertificatePasswordPrompt => 'Унесите лозинку којом је датотека сертификата заштићена при извозу.';

  @override
  String get smimeImport => 'Увези';

  @override
  String get smimeWrongPassword => 'Лозинка није тачна. Покушајте поново.';

  @override
  String get smimeNoCertificateFound => 'Није пронађен ниједан сертификат.';

  @override
  String smimeCertificateOf(String name) {
    return 'сертификат контакта $name';
  }

  @override
  String get smimeNothingNew => 'Нема ничег новог за увоз.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Увезено: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Увезено је $count поузданих сертификационих тела.',
      few: 'Увезена су $count поуздана сертификациона тела.',
      one: 'Увезено је $count поуздано сертификационо тело.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Увезено: $certificates и $count поузданих сертификационих тела.',
      few: 'Увезено: $certificates и $count поуздана сертификациона тела.',
      one: 'Увезено: $certificates и $count поуздано сертификационо тело.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Ова датотека нема приватни кључ. Извезите сертификат заједно са приватним кључем.';

  @override
  String get smimeImportAsYoursTitle => 'Увести као ваш сертификат?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Овај прилог садржи сертификат са приватним кључем: $names. Увезите га само ако сте га сами извезли, на пример из програма Outlook или Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Увези као мој сертификат';

  @override
  String smimeImportedOwn(String names) {
    return 'Увезен је ваш сертификат $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Ваш сертификат $name ($addresses) је додат са овог уређаја.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Веровати сертификационом телу „$name“ за пошту?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe не познаје ово сертификационо тело (можда је то интерно тело неке фирме). Ако му верујете, сертификати које издаје моћи ће да се провере. Прво упоредите његов отисак са својим ИТ одељењем:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Приложено је $count сертификата.',
      few: 'Приложена су $count сертификата.',
      one: 'Приложен је $count сертификат.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Увези сертификат';

  @override
  String get smimeUnlockTitle => 'Откључавање S/MIME сертификата';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Унесите приступну фразу за сертификат $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Приступна фраза није тачна. Покушајте поново.';

  @override
  String get smimeUnlock => 'Откључај';

  @override
  String get smimeEnterAPassphrase => 'Унесите приступну фразу.';

  @override
  String get smimePassphrasesDiffer => 'Приступне фразе се не поклапају.';

  @override
  String get smimeSetPassphraseTitle => 'Постављање приступне фразе';

  @override
  String get smimeSetPassphraseText =>
      'Loupe ће је тражити за потписивање и дешифровање. Ако је заборавите, поново увезите сертификат из његове датотеке .p12.';

  @override
  String get smimePassphraseAgain => 'Понови';

  @override
  String get smimeSetPassphraseButton => 'Постави';

  @override
  String get smimeLockedOpenAgain => 'Ваш S/MIME сертификат је закључан. Поново отворите поруку да бисте га откључали.';

  @override
  String get smimeDeviceHasNoCertificates => 'Овај уређај не нуди своје сертификате.';

  @override
  String get smimeCantReadCertificate => 'Loupe не може да прочита овај сертификат.';

  @override
  String get smimeCertificateNotForMail =>
      'Овај сертификат није за пошту: нема адресу е-поште или није намењен за потписивање или шифровање.';

  @override
  String get smimeDeviceCertificateGone =>
      'Сертификат више није на овом уређају или Loupe више не сме да га користи. Поново га изаберите у „Подешавања › Шифровање с краја на крај“.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Сертификат на овом уређају може да се користи само док је Loupe отворен.';

  @override
  String get smimeDeviceKeyDamaged => 'Шифровани кључ је оштећен.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Сертификат на овом уређају не може ово да уради: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'није подржано';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Грешка сертификата на овом уређају: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Адреса сертификационог тела није веб адреса.';

  @override
  String get smimeAuthorityTimeout => 'Сертификационо тело није одговорило на време.';

  @override
  String get smimeAuthorityUnreachable => 'Није могуће повезати се са сертификационим телом.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Сертификационо тело је одговорило кодом $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Одговор сертификационог тела је превелик.';

  @override
  String get smimeRevocationNotChecked =>
      'Није проверено: проверавају се само сертификати које издају сертификациона тела којима Loupe верује.';

  @override
  String get settingsLanguage => 'Језик';

  @override
  String get settingsLanguageSystem => 'Као на телефону';

  @override
  String get settingsLanguageFooter =>
      'Loupe користи језик телефона када га има, а енглески када га нема. Језик који овде изаберете важи само за Loupe, укључујући обавештења.';

  @override
  String get settingsAccountsHeader => 'Налози';

  @override
  String get settingsAddAccount => 'Додај налог';

  @override
  String get settingsMailHeader => 'Пошта';

  @override
  String get settingsSwipeActions => 'Радње превлачења';

  @override
  String get settingsSwipeLeft => 'Превлачење улево';

  @override
  String get settingsSwipeLeftFooter =>
      'Потпуно превлачење покреће ову радњу. Кратко превлачење увек открива заставицу и „Још“.';

  @override
  String get settingsSwipeRight => 'Превлачење удесно';

  @override
  String get settingsSwipeRightFooter => 'Потпуно превлачење покреће ову радњу.';

  @override
  String get settingsSwipeToggleRead => 'Означи као прочитано / непрочитано';

  @override
  String get settingsSwipeTrash => 'Премести у смеће';

  @override
  String get settingsSwipeMove => 'Премести поруку';

  @override
  String get settingsSwipeSnooze => 'Одложи';

  @override
  String get settingsThreaded => 'Групиши по разговорима';

  @override
  String get settingsUndoSendDelay => 'Време за опозив слања';

  @override
  String get settingsUndoSendDelayFooter => 'Послате поруке чекају оволико дуго, па слање можете опозвати.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds секунди',
      few: '$seconds секунде',
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
  String get settingsThemeSystem => 'Аутоматска';

  @override
  String get settingsThemeLight => 'Светла';

  @override
  String get settingsThemeDark => 'Тамна';

  @override
  String get settingsDensity => 'Листа порука';

  @override
  String get settingsDensityComfortable => 'Пространа';

  @override
  String get settingsDensityCompact => 'Компактна';

  @override
  String get settingsReadingHeader => 'Читање';

  @override
  String get settingsReadingFooter => 'Удаљене слике могу пошиљаоцима да открију када и где сте отворили поруку.';

  @override
  String get settingsDefaultView => 'Подразумевани приказ';

  @override
  String get settingsDefaultViewFooter => 'Приказ сваке поруке можете променити дугметом Aa.';

  @override
  String get settingsViewReadable => 'Читљиво';

  @override
  String get settingsViewReadableDetail => 'Уредно, читко, прати тамну тему';

  @override
  String get settingsViewOriginal => 'Оригинал';

  @override
  String get settingsViewOriginalDetail => 'Тачно онако како га је пошиљалац осмислио';

  @override
  String get settingsViewPlain => 'Обичан текст';

  @override
  String get settingsViewPlainDetail => 'Само речи';

  @override
  String get settingsPlainTextFont => 'Фонт за обичан текст';

  @override
  String get settingsFontSans => 'Бесерифни';

  @override
  String get settingsFontMono => 'Фиксне ширине';

  @override
  String get settingsFontMonoDetail => 'ASCII цртежи и табеле остају поравнати';

  @override
  String get settingsTechnicalLists => 'Техничке листе';

  @override
  String get settingsLoadRemoteImages => 'Учитај удаљене слике';

  @override
  String get settingsOpenLinksDirectly => 'Отвори линкове директно';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Заобилази праћење кликова кад је одредиште познато';

  @override
  String get settingsSecurityHeader => 'Безбедност';

  @override
  String get settingsAppLock => 'Закључавање апликације';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe тражи откључавање при покретању и кад се вратите након одсуства дужег од времена у „Закључај након“.';

  @override
  String get settingsAppLockFooterOff =>
      'Закључавање апликације тражи отисак прста, лице или закључавање екрана пре него што се прикаже пошта.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Закључавање апликације је и даље искључено. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Подесите шифру';

  @override
  String get settingsScreenLockTextIos =>
      'Закључавање апликације користи Face ID, Touch ID или вашу шифру, а овај iPhone нема шифру. Подесите је у апликацији Подешавања, па укључите закључавање апликације.';

  @override
  String get settingsScreenLockTitleAndroid => 'Подесите закључавање екрана';

  @override
  String get settingsScreenLockTextAndroid =>
      'Закључавање апликације користи закључавање екрана телефона, као и отисак прста или лице додато уз њега, а овај телефон га нема. Подесите PIN, шаблон или лозинку у Android подешавањима, па укључите закључавање апликације.';

  @override
  String get settingsOpenSystemSettings => 'Отвори подешавања';

  @override
  String get settingsOpenAndroidSettings => 'Отвори Android подешавања';

  @override
  String get settingsLockAfter => 'Закључај након';

  @override
  String get settingsLockAfterFooter =>
      'Колико дуго Loupe може бити у позадини пре него што поново затражи откључавање.';

  @override
  String get settingsNotifications => 'Обавештења';

  @override
  String get settingsEncryption => 'Шифровање с краја на крај';

  @override
  String get settingsAdvanced => 'Напредно';

  @override
  String get settingsDemoHeader => 'Демо';

  @override
  String get settingsDemoFooter =>
      'Демо пошта је измишљено сандуче које постоји само на овом телефону. Ништа се никуд не шаље.';

  @override
  String get settingsDemoMode => 'Демо режим';

  @override
  String get settingsResetApp => 'Ресетуј апликацију';

  @override
  String get settingsResetFooter => 'Брише сва подешавања и враћа на екран добродошлице.';

  @override
  String get settingsResetTitle => 'Ресетовати Loupe?';

  @override
  String get settingsResetMessage =>
      'Бришу се сва подешавања, Smart Mailboxes и недавне претраге, а апликација се враћа на екран добродошлице.';

  @override
  String get settingsAboutHeader => 'О апликацији';

  @override
  String get settingsVersion => 'Верзија';

  @override
  String get settingsLicences => 'Лиценце';

  @override
  String get settingsPrivacy => 'Приватност';

  @override
  String get settingsPrivacyDetail => 'Loupe нема аналитику ни праћење. Ваша пошта иде само на ваше сервере е-поште.';

  @override
  String get settingsNotificationsOffIos => 'Обавештења за Loupe су искључена у Подешавањима.';

  @override
  String get settingsNotificationsOffAndroid => 'Обавештења за Loupe су искључена у Android подешавањима.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system не дозвољава да Loupe приказује обавештења. Дозволите их у Подешавањима.';
  }

  @override
  String get settingsNewMailHeader => 'Нова пошта';

  @override
  String get settingsNewMailFooterDemo =>
      'Демо пошта не стиже у позадини. Пошаљите пробно обавештење да видите како изгледа нова пошта.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe проверава нову пошту у позадини кад то iOS дозволи, а код апликација које ретко отварате између провера могу проћи и сати. Добијате обавештења о новим порукама у пријемним сандучићима, као и о порукама VIP контаката у било којој фасцикли.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe проверава нову пошту отприлике на сваких 15 минута, кад Android дозволи. Добијате обавештења о новим порукама у пријемним сандучићима, као и о порукама VIP контаката у било којој фасцикли.';

  @override
  String get settingsNoAccounts => 'Нема налога';

  @override
  String get settingsVipOnly => 'Само VIP';

  @override
  String get settingsVipOnlyDetail => 'Само поруке од ваших VIP контаката';

  @override
  String get settingsHideContent => 'Сакриј садржај';

  @override
  String get settingsHideContentFooterOn => 'Обавештења приказују само „Нова порука“ и налог, без пошиљаоца и теме.';

  @override
  String get settingsHideContentFooterOff =>
      '„Сакриј садржај“ уклања пошиљаоца, тему и преглед са закључаног екрана и из обавештења.';

  @override
  String get settingsBackgroundAppRefresh => 'Освежавање апликација у позадини';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Нова пошта стиже у позадини само док је „Освежавање апликација у позадини“ укључено за Loupe у Подешавањима. iOS не може да држи отворену везу са пријемним сандучићима, па „Тренутна испорука“ није доступна.';

  @override
  String get settingsInstantDelivery => 'Тренутна испорука';

  @override
  String get settingsInstantDeliveryFooter =>
      'Тренутна испорука (експериментално) држи отворену везу са пријемним сандучићима, па нова пошта стиже за неколико секунди. Приказује ненаметљиво обавештење „Праћење нове поште“ и троши више батерије.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android може да заустави тренутну испоруку ради уштеде батерије. Да би она радила без прекида, дозволите да Loupe користи батерију без ограничења.';

  @override
  String get settingsExperimental => 'Експериментално';

  @override
  String get settingsComingSoon => 'Ускоро';

  @override
  String get settingsAllowUnrestrictedBattery => 'Дозволи неограничено коришћење батерије';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push омогућава да нова пошта одмах пробуди Loupe, ако то ваша услуга е-поште подржава. Push поруке иду преко Google услуге за push и не садрже пошту, само „провери сада“.';

  @override
  String get settingsPushUnavailableFooter =>
      'Овај телефон не може да прима push поруке: потребне су услуге Google Play и мрежна веза. Loupe и даље проверава пошту отприлике на сваких 15 минута.';

  @override
  String get settingsCopyPushToken => 'Копирај push токен';

  @override
  String get settingsPushTokenCopied => 'Push токен је копиран';

  @override
  String get settingsSendTestNotification => 'Пошаљи пробно обавештење';

  @override
  String get settingsAppIconBadge => 'Број на икони апликације';

  @override
  String get settingsBadgeNote => 'Број се ажурира сваки пут кад Loupe провери пошту, и у позадини.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Почетни екран овог телефона не приказује бројеве на иконама апликација. Број се ажурира сваки пут кад Loupe провери пошту, и у позадини.';

  @override
  String get settingsTestNotificationBody => 'Обавештења о новој пошти изгледају овако.';

  @override
  String get settingsAccountRemoved => 'Овај налог је уклоњен.';

  @override
  String get settingsAccountHeader => 'Налог';

  @override
  String get settingsAccountDescription => 'Опис';

  @override
  String get settingsAccountDescriptionHint => 'Посао, Лично…';

  @override
  String get settingsEmail => 'Е-пошта';

  @override
  String get settingsColour => 'Боја';

  @override
  String get settingsColourFooter => 'Означава поруке овог налога у приказу „Сви пријемни сандучићи“.';

  @override
  String settingsColourNumber(int number) {
    return 'Боја $number';
  }

  @override
  String get settingsSendingHeader => 'Слање';

  @override
  String get settingsSendingFooter =>
      'Сваки идентитет има свој потпис. Одговори се шаљу са адресе на коју је порука послата.';

  @override
  String get settingsFoldersHeader => 'Фасцикле';

  @override
  String get settingsFoldersFooter =>
      'Loupe приказује и синхронизује фасцикле на које сте претплаћени, као и Thunderbird. Пријемно сандуче, Нацрти, Послато, Непожељно, Смеће и Архива увек се приказују.';

  @override
  String get settingsShowAllFolders => 'Прикажи све фасцикле';

  @override
  String get settingsIncoming => 'Долазна пошта';

  @override
  String get settingsOutgoing => 'Одлазна пошта';

  @override
  String get settingsConnectionNotEncrypted => 'Без шифровања';

  @override
  String get settingsSignIn => 'Пријава';

  @override
  String get settingsSignInExpired => 'Истекла';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider више не прихвата пријаву апликације Loupe за овај налог, па се његова пошта не синхронизује. Пријавите се поново да бисте то решили.';
  }

  @override
  String get settingsSignInAgain => 'Пријави се поново';

  @override
  String get settingsSigningIn => 'Пријављивање…';

  @override
  String get settingsRemoveAccount => 'Уклони налог';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Уклонити „$account“?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Пошта и подешавања овог налога биће уклоњени са овог телефона. На серверу се ништа не брише.';

  @override
  String get settingsManageFolders => 'Управљање фасциклама';

  @override
  String get settingsNoFolders => 'Још нема фасцикли.';

  @override
  String get settingsManageFoldersFooter =>
      'Фасцикле на које сте претплаћени приказују се на екрану „Сандучићи“ и синхронизују у позадини. Друге апликације за пошту на истом налогу обично такође поштују ове претплате.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Чува ваше Smart Mailboxes за друге уређаје. Скривена на екрану „Сандучићи“.';

  @override
  String get settingsFolderAlwaysShown => 'Увек се приказује';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Претплати се на фасциклу $folder';
  }

  @override
  String get settingsIdentities => 'Идентитети';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Први идентитет је подразумевани за нове поруке. Превуците да бисте променили редослед.';

  @override
  String get settingsIdentitiesFooterSingle => 'Подразумевани идентитет за нове поруке.';

  @override
  String get settingsIdentitiesReplyFooter => 'Одговор се шаље са идентитета на који је порука послата.';

  @override
  String get settingsIdentityDefault => 'Подразумевани';

  @override
  String settingsIdentityReorder(String email) {
    return 'Промени редослед: $email';
  }

  @override
  String get settingsAddIdentity => 'Додај идентитет';

  @override
  String get settingsNewIdentity => 'Нови идентитет';

  @override
  String get settingsIdentity => 'Идентитет';

  @override
  String get settingsIdentityNameHint => 'Ваше име';

  @override
  String get settingsReplyTo => 'Адреса за одговор';

  @override
  String get settingsSignature => 'Потпис';

  @override
  String get settingsSignatureFooter => 'Додаје се испод „-- “ у порукама са овог идентитета.';

  @override
  String get settingsNoSignature => 'Без потписа';

  @override
  String get settingsCopyToMyself => 'Копија за мене';

  @override
  String get settingsCopyToMyselfFooter => 'Додаје се свакој поруци са овог идентитета.';

  @override
  String get settingsCc => 'Копија';

  @override
  String get settingsBcc => 'Скривена копија';

  @override
  String get settingsReplyPatterns => 'Користи за одговоре на адресе';

  @override
  String get settingsReplyPatternsFooter =>
      'Одговори на поруке послате на ове адресе шаљу се са овог идентитета. * замењује било шта: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Адреса или образац у ком * замењује било шта.';

  @override
  String get settingsAddReplyPattern => 'Додај адресу или образац';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Уклони $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Неисправан образац';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '„$input“ није адреса ни образац попут *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Нема адресе';

  @override
  String get settingsIdentityNoAddressMessage => 'Унесите адресу е-поште са које се шаље.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Неисправна адреса';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Адреса за одговор: „$address“ није исправна адреса е-поште.',
      'cc': 'Копија: „$address“ није исправна адреса е-поште.',
      'bcc': 'Скривена копија: „$address“ није исправна адреса е-поште.',
      'other': '„$address“ није исправна адреса е-поште.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Сачувај идентитет';

  @override
  String get settingsDiscardChanges => 'Одбаци измене';

  @override
  String get settingsDeleteIdentity => 'Избриши идентитет';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Избрисати „$email“?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Поруке које су већ послате са њега остају непромењене.';

  @override
  String get settingsLastIdentityFooter => 'Налог мора имати бар један идентитет.';

  @override
  String get rulesTitle => 'Правила';

  @override
  String get rulesNewRule => 'Ново правило';

  @override
  String get rulesLoadError => 'Учитавање правила није успело.';

  @override
  String get rulesEmptyTitle => 'Нема правила';

  @override
  String get rulesEmptyText =>
      'Правила уместо вас разврставају нову пошту по фасциклама и додају јој ознаке и заставице. Направите правило дугметом за писање горе или из претраге помоћу „Направи правило“.';

  @override
  String get rulesListFooter =>
      'Правила се примењују одозго надоле на нову пошту у пријемном сандучету. Додирните и задржите правило да бисте га померили.';

  @override
  String get rulesChangeError => 'Измена правила није успела';

  @override
  String get rulesConditionEveryMessage => 'Свака порука';

  @override
  String rulesMoveRule(String rule) {
    return 'Помери правило $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return 'Правило $rule укључено';
  }

  @override
  String get rulesServerRulesHeader => 'Правила на серверу';

  @override
  String get rulesServerRulesFooter =>
      'Правила на серверу извршава сервер е-поште чим пошта стигне, чак и када је овај телефон искључен. Чувају се у Sieve скрипти под именом „loupe“.';

  @override
  String get rulesStatusUnknown => 'Непознато';

  @override
  String get rulesStatusError => 'Упит серверу није успео.';

  @override
  String get rulesStatusChecking => 'Провера…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Извршава их скрипта „$script“.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Активна скрипта је „$script“. Додирните да би извршавала и правила апликације Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'На серверу није активна ниједна скрипта. Када сачувате правило на серверу, укључује се скрипта апликације Loupe.';

  @override
  String get rulesStatusUnavailable => 'Није доступно';

  @override
  String get rulesStatusNoSieve => 'Сервер овог налога не нуди Sieve (ManageSieve или JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Премести у фасциклу $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Премести у фасциклу';

  @override
  String rulesActionTag(String tag) {
    return 'Додај ознаку $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Уклони ознаку $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Задржи у пријемном сандучету';

  @override
  String rulesActionForward(String address) {
    return 'Проследи на $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Проследи на $address, без копије';
  }

  @override
  String get rulesActionStop => 'Без даљих правила';

  @override
  String get rulesNoActions => 'Још не ради ништа';

  @override
  String get rulesLocationDevice => 'Уређај';

  @override
  String get rulesLocationServer => 'Сервер';

  @override
  String get rulesLocationThisDevice => 'Овај уређај';

  @override
  String get rulesNewRuleTitle => 'Ново правило';

  @override
  String get rulesEditRuleTitle => 'Уреди правило';

  @override
  String get rulesDefaultNameEveryMessage => 'Свака порука';

  @override
  String get rulesConditionHeader => 'Када нова порука одговара услову';

  @override
  String get rulesConditionFooter =>
      'Пишите као у претрази: from:, to:, s: (тема), b: (тело), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:рачун';

  @override
  String get rulesAccounts => 'Налози';

  @override
  String get rulesAllAccounts => 'Сви налози';

  @override
  String get rulesRemovedAccount => 'Уклоњен налог';

  @override
  String get rulesAccountsFooter => 'Правило за све налоге важи и за налоге које додате касније.';

  @override
  String get rulesActionsHeader => 'Тада';

  @override
  String get rulesForwardingFooter =>
      'Прослеђивање шаље сваку поруку која одговара услову на другу адресу чим стигне, чак и када је овај телефон искључен. Неки пружаоци услуга ограничавају колико поште може да се проследи.';

  @override
  String get rulesForwardingHiddenFooter => 'Прослеђивање ради само у правилима на серверу, па овде није понуђено.';

  @override
  String rulesRemoveAction(String action) {
    return 'Уклони: $action';
  }

  @override
  String get rulesAddAction => 'Додај радњу';

  @override
  String get rulesAddMove => 'Премести у фасциклу…';

  @override
  String get rulesAddTagMenu => 'Додај ознаку…';

  @override
  String get rulesRemoveTagMenu => 'Уклони ознаку…';

  @override
  String get rulesAddForward => 'Проследи на…';

  @override
  String get rulesStopProcessing => 'Не извршавај следећа правила';

  @override
  String get rulesRunOnHeader => 'Где се извршава';

  @override
  String get rulesRunOnDeviceFooter =>
      'Овај уређај примењује правило на нову пошту у пријемном сандучету сваки пут када Loupe провери пошту.';

  @override
  String get rulesRunOnServerFooter =>
      'Сервер е-поште извршава правило чим пошта стигне, чак и када је овај телефон искључен. Потребан је Sieve, преко ManageSieve (Dovecot, mailcow) или JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Примени на постојеће поруке…';

  @override
  String get rulesDeleteRule => 'Избриши правило';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Избрисати правило „$rule“?';
  }

  @override
  String get rulesMoveAccountTitle => 'Фасцикла у ком налогу?';

  @override
  String get rulesMoveAccountMessage => 'Пошта осталих налога иде у истоимену фасциклу у тим налозима.';

  @override
  String get rulesAddTag => 'Додај ознаку';

  @override
  String get rulesRemoveTag => 'Уклони ознаку';

  @override
  String get rulesForwardTo => 'Проследи на';

  @override
  String get rulesForwardToMessage =>
      'Сервер прослеђује сваку поруку која одговара услову на ову адресу, чак и када је овај телефон искључен. Унесите адресу која је ваша или којој верујете.';

  @override
  String get rulesNotAnAddressTitle => 'Није адреса е-поште';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '„$address“ није адреса на коју се може прослеђивати.';
  }

  @override
  String get rulesKeepCopyTitle => 'Задржати копију овде?';

  @override
  String get rulesKeepCopy => 'Задржи копију';

  @override
  String get rulesDontKeepCopy => 'Без копије';

  @override
  String get rulesCheckCondition => 'Проверите услов';

  @override
  String get rulesChooseActionTitle => 'Изаберите радњу';

  @override
  String get rulesChooseActionMessage => 'Додајте шта правило ради с порукама које одговарају услову.';

  @override
  String get rulesSaveError => 'Чување правила није успело';

  @override
  String get rulesSaveServerError => 'Чување правила на серверу није успело';

  @override
  String get rulesRunOnDeviceInstead => 'Пребаци на овај уређај';

  @override
  String get rulesNothingToApplyTitle => 'Нема шта да се примени';

  @override
  String get rulesNothingToApplyMessage => 'Прво правилу задајте исправан услов и радњу.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Где применити „$rule“?';
  }

  @override
  String get rulesApplyScopeInboxes => 'Пријемни сандучићи';

  @override
  String get rulesApplyScopeAll => 'Сви сандучићи';

  @override
  String get rulesFindingMessages => 'Тражење порука…';

  @override
  String get rulesSearchError => 'Претрага није успела';

  @override
  String get rulesSearchErrorUnknown => 'Дошло је до грешке.';

  @override
  String get rulesNoMatchesTitle => 'Нема одговарајућих порука';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Тамо ниједна порука не одговара услову „$condition“.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Применити „$rule“ на $countString порука?',
      few: 'Применити „$rule“ на $countString поруке?',
      one: 'Применити „$rule“ на $countString поруку?',
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
      other: 'Примени на $countString порука',
      few: 'Примени на $countString поруке',
      one: 'Примени на $countString поруку',
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
      other: 'Правило „$rule“ примењено је на $countString порука',
      few: 'Правило „$rule“ примењено је на $countString поруке',
      one: 'Правило „$rule“ примењено је на $countString поруку',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Провера могућности сервера…';

  @override
  String get rulesServerUnreachable => 'Повезивање са сервером није успело.';

  @override
  String rulesServerProblem(String problem) {
    return 'Не може да се извршава на серверу: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Не може да се извршава на серверу налога $account: $problem';
  }

  @override
  String get rulesShowScript => 'Прикажи скрипту';

  @override
  String get rulesHideScript => 'Сакриј скрипту';

  @override
  String get rulesMatchingHeader => 'Одговарајуће поруке';

  @override
  String get rulesMatchingHeaderLoading => 'Одговарајуће поруке…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString одговарајућих порука',
      few: '$countString одговарајуће поруке',
      one: '$countString одговарајућа порука',
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
      other: '$countString+ одговарајућих порука',
      few: '$countString+ одговарајуће поруке',
      one: '$countString+ одговарајућа порука',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Из последњих 30 дана. Правило иначе делује само на нову пошту, осим ако га не примените и на постојеће поруке.';

  @override
  String rulesConditionError(String error) {
    return 'Услов садржи грешку: $error';
  }

  @override
  String get rulesPreviewNoSender => '(без пошиљаоца)';

  @override
  String get rulesPreviewNoSubject => '(без теме)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'и још $countString',
      few: 'и још $countString',
      one: 'и још $countString',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Ништа из последњих 30 дана.';

  @override
  String get rulesIncludeTitle => 'Укључивање правила на серверу';

  @override
  String get rulesIncludeLeaveOff => 'Не укључуј';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Сервер већ извршава правила апликације Loupe за налог $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return 'На серверу налога $account активна је скрипта „$script“, па сервер извршава њу, а не правила апликације Loupe. Loupe је неће заменити. Може да јој дода ове редове, па ће сервер извршавати правила апликације Loupe после правила саме скрипте:';
  }

  @override
  String get rulesShowWholeScript => 'Прикажи целу скрипту';

  @override
  String get rulesHideWholeScript => 'Сакриј целу скрипту';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Ништа друго у скрипти „$script“ се не мења. Ако се њени филтери касније измене у веб-пошти, веб-пошта може да је препише без ових редова; Loupe ће тада поново приказати правила на серверу као искључена.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Додај у скрипту „$script“';
  }

  @override
  String get subscriptionsTitle => 'Претплате';

  @override
  String get subscriptionsNewsletters => 'Билтени';

  @override
  String get subscriptionsDiscussions => 'Дискусије';

  @override
  String get subscriptionsFilter => 'Филтер';

  @override
  String get subscriptionsFilterNeverRead => 'Никад читани';

  @override
  String get subscriptionsFilterRarelyRead => 'Ретко читани';

  @override
  String get subscriptionsFilterAll => 'Сви';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Бројање претплата није успело';

  @override
  String get subscriptionsNoMatches => 'Нема резултата';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Ниједан билтен се не зове „$text“.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Ниједна листа се не зове „$text“.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Нема билтена';

  @override
  String get subscriptionsNoNewslettersDetail => 'Билтени и друга масовна пошта појављују се овде чим стигну.';

  @override
  String get subscriptionsNothingNeverRead => 'Нема билтена које никад не читате';

  @override
  String get subscriptionsNothingRarelyRead => 'Нема билтена које ретко читате';

  @override
  String get subscriptionsNothingFilteredDetail => 'Од свега што добијате понешто и прочитате.';

  @override
  String get subscriptionsNoDiscussions => 'Нема дискусија';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Мејлинг листе на које можете да пишете појављују се овде чим стигне њихова пошта.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Листе на које пише више људи. Додирните и задржите листу да бисте је закачили у Сандучиће, читали као обичан текст или преместили у Билтене.';

  @override
  String get subscriptionsPrivacyNote =>
      'Пребројано на овом телефону из преузете поште; ништа се никуда не шаље да би се ово израчунало. Loupe контактира пошиљаоца само када додирнете „Одјави се“: одјава једним додиром шаље само „List-Unsubscribe=One-Click“ на адресу коју наводи пошиљалац, без колачића и без ичега другог о вама, и никад не учитава његове странице ни слике.';

  @override
  String get subscriptionsVolumeNone => 'Ништа у последње време';

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
  String get subscriptionsStillSending => 'И даље шаље';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Одјављено $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Страница за одјаву отворена $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Једним додиром · контактира $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Е-поштом на $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'На веб-сајту $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Одјави се';

  @override
  String get subscriptionsUnsubscribeAgain => 'Одјави се поново';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Архивирај $countString из пријемног сандучета',
      few: 'Архивирај $countString из пријемног сандучета',
      one: 'Архивирај $countString из пријемног сандучета',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Направи правило…';

  @override
  String get subscriptionsCreateRuleDetail => 'Премести или архивирај будућу пошту';

  @override
  String get subscriptionsTreatAsDiscussion => 'Сматрај дискусијом';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Листа на коју људи пишу: читајте је као форум';

  @override
  String get subscriptionsTreatAsNewsletter => 'Сматрај билтеном';

  @override
  String get subscriptionsBlockSender => 'Блокирај пошиљаоца';

  @override
  String get subscriptionsBlock => 'Блокирај';

  @override
  String get subscriptionsBlocked => 'Блокирано';

  @override
  String get subscriptionsBlockedDetail => 'Нове поруке иду у Непожељно';

  @override
  String get subscriptionsPin => 'Закачи у Сандучиће';

  @override
  String get subscriptionsUnpin => 'Откачи из Сандучића';

  @override
  String get subscriptionsOpenDefaultView => 'Отвори у подразумеваном приказу';

  @override
  String get subscriptionsOpenPlainText => 'Отвори као обичан текст (моно)';

  @override
  String get subscriptionsPinned => 'Закачено';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString непрочитаних',
      few: '$countString непрочитане',
      one: '$countString непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Тренутно нема поште овог пошиљаоца.';

  @override
  String get subscriptionsLatestMessages => 'НАЈНОВИЈЕ ПОРУКЕ';

  @override
  String get subscriptionsMail => 'Пошта';

  @override
  String get subscriptionsNoneIn90Days => 'Ништа у последњих 90 дана';

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
  String get subscriptionsLastReceived => 'Последња порука';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count фасцикли',
      few: '$count фасцикле',
      one: '$count фасцикла',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'И даље шаље';

  @override
  String get subscriptionsUnsubscribedTitle => 'Одјављено';

  @override
  String subscriptionsSince(String date) {
    return 'од $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'страница отворена $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender не наводи како да се одјавите.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender не наводи како да се одјавите. Уместо тога, можете да га блокирате.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Одјављивање од пошиљаоца $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Одјављено од пошиљаоца $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Одјава није успела: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Аутоматска одјава није успела';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Пошаљи поруку за одјаву';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Отвори $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Отворити $site?';
  }

  @override
  String get subscriptionsOpen => 'Отвори';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender нуди одјаву на свом веб-сајту. Страница се отвара у прегледачу апликације Loupe; тамо довршите одјаву.';
  }

  @override
  String get subscriptionsWebInsecure => 'Веза са овим сајтом није шифрована.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Пажња: ова адреса опонаша $site помоћу слова сличног изгледа.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Пажња: ова адреса опонаша други сајт помоћу слова сличног изгледа.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Није могуће отворити $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe бележи данашњи датум и обавестиће вас ако $sender настави да шаље пошту.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Одјавити се од пошиљаоца $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe ће контактирати $site ради одјаве.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Ово је једини случај када Loupe контактира веб-сајт пошиљаоца. Шаље само „List-Unsubscribe=One-Click“ на адресу коју наводи $sender, без колачића и без ичега другог о вама, и не учитава страницу.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Линк за одјаву није безбедна адреса на интернету.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Сајт $site није одговорио на време.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Сајт $site није доступан.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Сајт $site је проследио захтев на другу страницу, а Loupe не прати преусмеравања.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Сајт $site је одбио захтев (грешка $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Нема налога са ког би се послала порука за одјаву.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe ће послати поруку на $to са адресе $from, са темом „$subject“.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Порука за одјаву послата је на $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Блокирати пошиљаоца $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Нове поруке са ове листе ићи ће у Непожељно. То можете да промените у „Подешавања › Правила“.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Нове поруке са адресе $address ићи ће у Непожељно. То можете да промените у „Подешавања › Правила“.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Пошиљалац $sender је блокиран.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премести $count у Непожељно',
      few: 'Премести $count у Непожељно',
      one: 'Премести $count у Непожељно',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Блокирај $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender је сада у Билтенима.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender је сада у Дискусијама.';
  }

  @override
  String get appLiveGateTitle => 'Ваши налози нису могли да се отворе';

  @override
  String get appLiveGateUnavailableBuild => 'Прави налози још нису доступни у овој верзији.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe није могао да прочита кључ који штити вашу пошту на овом телефону. То је често привремено: покушајте поново или поново покрените телефон.';

  @override
  String get appLiveGateKeyMissing =>
      'Кључ који штити вашу пошту на овом телефону је нестао, што се може десити после враћања резервне копије. Ваша пошта је и даље на серверу.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'База поште на овом телефону не може да се прочита: оштећена је или јој се кључ променио. Ваша пошта је и даље на серверу.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Дошло је до грешке при отварању ваших налога ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Овим се бришу ваши налози и пошта сачувана на овом телефону, укључујући поруке које чекају у фасцикли Пошта за слање. Пошта на вашим серверима остаје нетакнута; после тога поново додајте налоге.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Избриши и почни испочетка';

  @override
  String get appLiveGateUseDemo => 'Користи демо пошту';

  @override
  String get appLiveGateReset => 'Ресетуј пошту на овом телефону…';

  @override
  String get attachmentsUntitled => 'Прилог';

  @override
  String get attachmentsUntitledFile => 'Без назива';

  @override
  String get attachmentsOpenIn => 'Отвори у…';

  @override
  String get attachmentsSaveToFiles => 'Сачувај у датотеке';

  @override
  String get attachmentsShareMenu => 'Дели…';

  @override
  String get attachmentsDownloadError => 'Прилог није могао да се преузме. Проверите везу и покушајте поново.';

  @override
  String get attachmentsShareError => 'Прилог није могао да се дели.';

  @override
  String attachmentsNoApp(String type) {
    return 'Ниједна апликација на овом уређају не отвара ову датотеку ($type). Пробајте „Дели“.';
  }

  @override
  String get attachmentsOpenInError => 'Прилог није могао да се отвори у другој апликацији.';

  @override
  String attachmentsSaved(String name) {
    return 'Сачувано: „$name“';
  }

  @override
  String get attachmentsSaveError => 'Прилог није могао да се сачува.';

  @override
  String get attachmentsGone => 'Овај прилог више није доступан.';

  @override
  String get attachmentsDownloadFailed => 'Прилог није могао да се преузме.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count страница',
      few: '$count странице',
      one: '$count страница',
    );
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size преко мобилних података';
  }

  @override
  String get attachmentsLargeDownload => 'Овај прилог је велик. Преузмите га сада или касније преко Wi-Fi мреже.';

  @override
  String get attachmentsDownload => 'Преузми';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Преузима се $size…';
  }

  @override
  String get attachmentsDownloading => 'Преузимање…';

  @override
  String get attachmentsTooLarge => 'Превелико за преглед овде.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Приказано је првих $shown од $total. Копирајте, делите или сачувајте да бисте добили све.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Овај PDF не може да се прикаже овде (можда је заштићен лозинком).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page од $count';
  }

  @override
  String get attachmentsModeTable => 'Табела';

  @override
  String get attachmentsModeText => 'Текст';

  @override
  String get attachmentsModeMessage => 'Порука';

  @override
  String get attachmentsModeSource => 'Извор';

  @override
  String get attachmentsDontWrap => 'Не преламај редове';

  @override
  String get attachmentsWrap => 'Преламај редове';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$lines редова',
      few: '$lines реда',
      one: '$count ред',
    );
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Копирај све';

  @override
  String get attachmentsCopied => 'Копирано';

  @override
  String get attachmentsImageUnavailable => 'Ова слика не може да се прикаже овде. Пробајте „Отвори у…“.';

  @override
  String get attachmentsEmlNoSubject => '(Без теме)';

  @override
  String get attachmentsEmlFrom => 'Од';

  @override
  String get attachmentsEmlTo => 'За';

  @override
  String get attachmentsEmlCc => 'Копија';

  @override
  String get attachmentsEmlDate => 'Датум';

  @override
  String get attachmentsEmlNoText => 'Ова порука нема текст.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count прилога: $names',
      few: '$count прилога: $names',
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
      other: 'И још $count догађаја',
      few: 'И још $count догађаја',
      one: 'И још $count догађај',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Слика';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format слика';
  }

  @override
  String get attachmentsTypePdf => 'PDF документ';

  @override
  String get attachmentsTypeTsv => 'Вредности раздвојене табулатором';

  @override
  String get attachmentsTypeCsv => 'CSV табела';

  @override
  String get attachmentsTypeCalendar => 'Догађај у календару';

  @override
  String get attachmentsTypeEmail => 'Порука е-поште';

  @override
  String get attachmentsTypeContact => 'Контакт картица';

  @override
  String get attachmentsTypeLog => 'Датотека дневника';

  @override
  String get attachmentsTypeText => 'Текст';

  @override
  String get attachmentsTypeZip => 'ZIP архива';

  @override
  String get attachmentsTypeArchive => 'Архива';

  @override
  String get attachmentsTypeWord => 'Word документ';

  @override
  String get attachmentsTypeExcel => 'Excel табела';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint презентација';

  @override
  String get attachmentsTypeWebPage => 'Веб-страница';

  @override
  String get attachmentsTypeVideo => 'Видео';

  @override
  String get attachmentsTypeAudio => 'Аудио';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension датотека';
  }

  @override
  String get attachmentsTypeFile => 'Датотека';

  @override
  String get calendarUntitledEvent => 'Догађај';

  @override
  String get calendarAllDay => 'Цео дан';

  @override
  String calendarYourTime(String time) {
    return '$time по вашем времену';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Линк за састанак: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прихвата позив: $details',
      'tentative': '$name условно прихвата позив: $details',
      'declined': '$name одбија позив: $details',
      'delegated': '$name делегира позив: $details',
      'other': '$name – без одговора на позив: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прихвата позив',
      'tentative': '$name условно прихвата позив',
      'declined': '$name одбија позив',
      'delegated': '$name делегира позив',
      'other': '$name – без одговора на позив',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Мапа';

  @override
  String get calendarJoin => 'Придружи се';

  @override
  String get calendarOnlineMeeting => 'Онлајн састанак';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider састанак';
  }

  @override
  String get calendarOrganizerYou => 'Ви';

  @override
  String get calendarOrganizerLabel => 'организатор';

  @override
  String get calendarStatusAccepted => 'Прихваћено';

  @override
  String get calendarStatusMaybe => 'Можда';

  @override
  String get calendarStatusDeclined => 'Одбијено';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прихвата позив',
      'tentative': '$name условно прихвата позив',
      'declined': '$name одбија позив',
      'delegated': '$name делегира позив',
      'other': '$name – без одговора',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name прихвата позив:',
      'tentative': '$name условно прихвата позив:',
      'declined': '$name одбија позив:',
      'delegated': '$name делегира позив:',
      'other': '$name – без одговора:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '„$comment“';
  }

  @override
  String calendarCounter(String name) {
    return '$name предлаже нови термин';
  }

  @override
  String get calendarCounterUnknown => 'Учесник предлаже нови термин';

  @override
  String get calendarDeclineCounter => 'Организатор задржава првобитни термин';

  @override
  String calendarRefresh(String name) {
    return '$name тражи најновију верзију догађаја';
  }

  @override
  String get calendarRefreshUnknown => 'Учесник тражи најновију верзију догађаја';

  @override
  String get calendarCancelled => 'Отказано';

  @override
  String get calendarCancelledByOrganizer => 'Организатор је отказао овај догађај.';

  @override
  String get calendarCancelledLater => 'Овај догађај је касније отказан.';

  @override
  String get calendarOutdated => 'Застарело';

  @override
  String get calendarOutdatedDetail => 'Овај позив је касније ажуриран; важи новија верзија.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Локација је уклоњена (била је: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Локација је уклоњена (није ни била наведена)';

  @override
  String calendarLocationChanged(String location) {
    return 'Нова локација: $location';
  }

  @override
  String get calendarNewTitle => 'Нови наслов';

  @override
  String get calendarRepeatChanged => 'Понављање је промењено';

  @override
  String get calendarUpdated => 'Ажурирано';

  @override
  String get calendarUpdatedInvitation => 'Ажуриран позив';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Време је промењено са $before на $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Непозната временска зона „$zone“: времена су приказана онако како су написана';
  }

  @override
  String calendarNext(String when) {
    return 'Следеће: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count гостију',
      few: '$count госта',
      one: '$count гост',
    );
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'прихваћено: $count',
      few: 'прихваћено: $count',
      one: 'прихваћено: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'можда: $count',
      few: 'можда: $count',
      one: 'можда: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'одбијено: $count',
      few: 'одбијено: $count',
      one: 'одбијено: $count',
    );
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (ви)';
  }

  @override
  String get calendarAttendeeOptional => 'опционално';

  @override
  String get calendarAttendeeRoom => 'просторија';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прихватили сте ранију верзију.',
      'tentative': 'Условно сте прихватили ранију верзију.',
      'declined': 'Одбили сте ранију верзију.',
      'delegated': 'Делегирали сте ранију верзију.',
      'other': 'Нисте одговорили на ранију верзију.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Прихвати';

  @override
  String get calendarMaybe => 'Можда';

  @override
  String get calendarDecline => 'Одбиј';

  @override
  String get calendarCommentHint => 'Коментар за организатора (опционално)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Ваш одговор иде организатору $organizer са адресе $address.';
  }

  @override
  String get calendarAddComment => 'Додај коментар';

  @override
  String get calendarAddToCalendar => 'Додај у календар';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'И још $count догађаја у датотеци',
      few: 'И још $count догађаја у датотеци',
      one: 'И још $count догађај у датотеци',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Нема апликације за календар у коју би се додао догађај.';

  @override
  String get calendarCantOpenCalendar => 'Отварање календара није успело.';

  @override
  String get calendarCantOpenLink => 'Отварање линка није успело.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Придружити се $provider састанку?';
  }

  @override
  String get calendarJoinTitle => 'Придружити се састанку?';

  @override
  String calendarJoinOpens(String host) {
    return 'Отвара $host у вашем прегледачу.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Пажња: ова адреса опонаша $site помоћу слова сличног изгледа.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Пажња: ова адреса опонаша други сајт помоћу слова сличног изгледа.';

  @override
  String calendarJoinOpen(String host) {
    return 'Отвори $host';
  }

  @override
  String get calendarNoOrganizer => 'Овај позив нема организатора коме би се одговорило.';

  @override
  String get calendarNoAccount => 'Нема налога са ког би се послао одговор.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прихваћено',
      'tentative': 'Можда',
      'other': 'Одбијено',
    });
    return '$_temp0 · одговор се шаље организатору $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Прихваћено',
      'tentative': 'Можда',
      'other': 'Одбијено',
    });
    return '$_temp0 · одговор је послат';
  }

  @override
  String get calendarReplyAlreadySent => 'Одговор је већ послат.';

  @override
  String get calendarReplyNotSent => 'Одговор није послат.';

  @override
  String get dataSmimeNeedsDevice =>
      'Ваш S/MIME сертификат је на овом уређају: отворите Loupe да бисте потписали и послали ову поруку.';

  @override
  String dataSigningFailed(String error) {
    return 'Потписивање није успело: $error';
  }

  @override
  String get keyboardShortcuts => 'Пречице на тастатури';

  @override
  String get keyboardGroupGeneral => 'Опште';

  @override
  String get keyboardGroupMessages => 'Поруке';

  @override
  String get keyboardGroupCompose => 'Писање';

  @override
  String get keyboardCommandPalette => 'Палета команди';

  @override
  String get keyboardBackClose => 'Назад, затвори';

  @override
  String get keyboardNextMessage => 'Следећа порука';

  @override
  String get keyboardPreviousMessage => 'Претходна порука';

  @override
  String get keyboardOpenMessage => 'Отвори поруку';

  @override
  String get keyboardMoveToTrash => 'Премести у смеће';

  @override
  String get keyboardToggleRead => 'Означи као прочитано или непрочитано';

  @override
  String get keyboardToggleFlag => 'Додај или уклони заставицу';

  @override
  String get keyboardCloseDraft => 'Затвори (сачувај или избриши нацрт)';

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
  String get mailingListsMuted => 'Нит је утишана. Нове поруке у њој стижу као прочитане.';

  @override
  String get mailingListsUnmuted => 'Утишавање нити је укинуто.';

  @override
  String get mailingListsMuteThread => 'Утишај нит';

  @override
  String get mailingListsUnmuteThread => 'Укини утишавање нити';

  @override
  String get mailingListsPin => 'Закачи у Сандучиће';

  @override
  String get mailingListsUnpin => 'Откачи из Сандучића';

  @override
  String get mailingListsDefaultView => 'Отвори у подразумеваном приказу';

  @override
  String get mailingListsPlainText => 'Отвори као обичан текст (моно)';

  @override
  String get mailingListsShowMuted => 'Прикажи утишане нити';

  @override
  String get mailingListsHideMuted => 'Сакриј утишане нити';

  @override
  String get mailingListsTreatAsNewsletter => 'Сматрај билтеном';

  @override
  String get mailingListsOptions => 'Опције листе';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted непрочитаних',
      few: '$formatted непрочитане',
      one: '$count непрочитана',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Нова порука листи';

  @override
  String get mailingListsRowUnread => 'Непрочитано';

  @override
  String get mailingListsRowMuted => 'Утишано';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count одговора',
      few: '$count одговора',
      one: '$count одговор',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Нема нити';

  @override
  String get mailingListsMutedHidden => 'Утишане нити су скривене.';

  @override
  String get mailingListsTechnicalTitle => 'Техничке листе';

  @override
  String get mailingListsTechnicalEmpty => 'Мејлинг листе појављују се овде чим стигне њихова пошта.';

  @override
  String get mailingListsTechnicalFooter =>
      'Поруке са ових листа отварају се као обичан текст у фонту фиксне ширине, а закрпе се приказују као разлике (diff). Дугметом Aa и даље можете променити приказ било које поруке.';

  @override
  String get paletteMoveToMailbox => 'Премести у сандуче…';

  @override
  String get paletteMarkAllRead => 'Означи све као прочитано';

  @override
  String get paletteExportFolder => 'Извези фасциклу…';

  @override
  String get paletteGetNewMail => 'Преузми нову пошту';

  @override
  String get paletteSnoozed => 'Одложено';

  @override
  String get paletteSubscriptions => 'Претплате';

  @override
  String get paletteDiscussions => 'Дискусије';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Мејлинг листа';

  @override
  String get paletteTag => 'Ознака';

  @override
  String get paletteSwipeActions => 'Радње превлачења';

  @override
  String get paletteNotifications => 'Обавештења';

  @override
  String get paletteRules => 'Правила';

  @override
  String get paletteEncryption => 'Шифровање с краја на крај';

  @override
  String get paletteAdvanced => 'Напредно';

  @override
  String get paletteAddAccount => 'Додај налог';

  @override
  String get paletteAccount => 'Налог';

  @override
  String get paletteFolders => 'Фасцикле';

  @override
  String get paletteRecentSearch => 'Недавна претрага';

  @override
  String paletteSearchMail(String query) {
    return 'Претражи пошту: „$query“';
  }

  @override
  String get palettePlaceholder => 'Претражите радње, сандучиће, подешавања';

  @override
  String get paletteNothingFound => 'Ништа није пронађено';

  @override
  String get searchNewSmartMailbox => 'Нови Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Приказује све што одговара упиту „$query“.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '„$name“ је сачувано у Сандучиће';
  }

  @override
  String get searchMakeRule => 'Направи правило';

  @override
  String get searchSaveSmartMailbox => 'Сачувај као Smart Mailbox';

  @override
  String get searchNegate => 'Негирај';

  @override
  String get searchDontNegate => 'Укини негацију';

  @override
  String get searchAllMailboxes => 'Сви сандучићи';

  @override
  String get searchRecent => 'Недавне претраге';

  @override
  String get searchClear => 'Обриши';

  @override
  String get searchSuggestions => 'Предлози';

  @override
  String get searchUnreadMessages => 'Непрочитане поруке';

  @override
  String get searchFlaggedMessages => 'Поруке са заставицом';

  @override
  String get searchWithAttachments => 'Поруке са прилозима';

  @override
  String get searchUnrepliedMessages => 'Поруке без одговора';

  @override
  String get searchTags => 'Ознаке';

  @override
  String get searchPeople => 'Људи';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Од: $name';
  }

  @override
  String get searchSearching => 'Претраживање…';

  @override
  String get searchNoResults => 'Нема резултата';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted резултата',
      few: '$formatted резултата',
      one: '$count резултат',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Мени претраге';

  @override
  String searchSearchingAccount(String account) {
    return 'Претраживање налога $account на серверу…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Претраживање налога на серверу…';

  @override
  String searchAccountFailed(String account) {
    return 'Претрага налога $account на серверу није успела';
  }

  @override
  String get searchUnknownAccountFailed => 'Претрага налога на серверу није успела';

  @override
  String searchChip(String term) {
    return '$term. Двапут додирните за измену.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Негирано: $term. Двапут додирните за измену.';
  }

  @override
  String get searchReadAndUnread =>
      'Шредингерово пријемно сандуче: свака порука овде је и прочитана и непрочитана док је не отворите.';

  @override
  String searchContradiction(String term) {
    return 'Ниједна порука не може у исто време да јесте и да није „$term“.';
  }

  @override
  String get searchSyncDeviceOnly => 'Само на овом уређају';

  @override
  String searchSyncUnsupported(String account) {
    return 'Само на овом уређају: налог $account не може да га чува';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Није синхронизовано: налог $account има новији формат';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Чека синхронизацију са налогом $account';
  }

  @override
  String searchSynced(String account) {
    return 'Синхронизовано са налогом $account';
  }

  @override
  String get searchRename => 'Преименуј';

  @override
  String get searchEditSearch => 'Уреди претрагу';

  @override
  String get searchDeleteSmartMailbox => 'Избриши Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Преименуј Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Овај Smart Mailbox је избрисан.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes остају на овом уређају.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes се чувају на вашем серверу е-поште, па их имају и ваши други уређаји, као и Thunderbird са додатком Expression Search Reloaded. Они који претражују све налоге чувају се на налогу $account, а они за једну фасциклу на налогу те фасцикле.';
  }

  @override
  String get searchSyncVia => 'Синхронизуј преко';

  @override
  String get searchSyncViaFooter => 'Изаберите исти налог на сваком уређају.';

  @override
  String get searchGmailCantKeep => 'Gmail не може да чува Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Чувај Smart Mailboxes само на овом уређају';

  @override
  String get searchOnTheServer => 'На серверу';

  @override
  String get searchServerFooter =>
      'Метаподаци на серверу (IMAP METADATA) не приказују се ни у једној апликацији за пошту. На серверима без њих прави се фасцикла „Loupe Settings“ са једном поруком; Loupe је не приказује на екрану „Сандучићи“.';

  @override
  String get searchSyncNow => 'Синхронизуј сада';

  @override
  String get searchStateUnsupported => 'Није подржано';

  @override
  String get searchStateNewerFormat => 'Новији формат';

  @override
  String get searchStateFailed => 'Синхронизација није успела';

  @override
  String get searchStateSyncing => 'Синхронизација…';

  @override
  String get searchStateWaiting => 'На чекању';

  @override
  String get searchStateMetadata => 'Метаподаци на серверу';

  @override
  String get searchStateFolder => 'Фасцикла „Loupe Settings“';

  @override
  String get searchStateNothing => 'Ништа није сачувано';

  @override
  String get sharedBack => 'Назад';

  @override
  String get sharedYesterday => 'Јуче';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date у $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count бајтова',
      few: '$count бајта',
      one: '$count бајт',
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
  String get sharedSyncNoAccounts => 'Нема налога';

  @override
  String get sharedSyncChecking => 'Провера поште…';

  @override
  String get sharedSyncFailed => 'Провера поште није успела';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Нисте на мрежи';

  @override
  String get sharedSyncJustNow => 'Ажурирано управо сада';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ажурирано пре $minutes минута',
      few: 'Ажурирано пре $minutes минута',
      one: 'Ажурирано пре $minutes минута',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Ажурирано у $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Ажурирано $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Сви пријемни сандучићи';

  @override
  String get sharedMailboxUnread => 'Непрочитано';

  @override
  String get sharedMailboxFlagged => 'Са заставицом';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Сви нацрти';

  @override
  String get sharedMailboxAllSent => 'Све послато';

  @override
  String get sharedMailboxUntitled => 'Сандуче';

  @override
  String get sharedTagImportant => 'Важно';

  @override
  String get sharedTagWork => 'Посао';

  @override
  String get sharedTagPersonal => 'Лично';

  @override
  String get sharedTagToDo => 'За урадити';

  @override
  String get sharedTagLater => 'Касније';

  @override
  String get sharedTags => 'Ознаке';

  @override
  String get sharedMoveTo => 'Премести у…';

  @override
  String get sharedNoRecipients => 'Нема прималаца';

  @override
  String get sharedUnknownSender => 'Непознат пошиљалац';

  @override
  String get sharedOnServer => 'На серверу';

  @override
  String get sharedAttachment => 'Има прилог';

  @override
  String get sharedSnoozedBadge => 'Одложено';

  @override
  String get sharedRowUnread => 'Непрочитано';

  @override
  String get sharedRowBackFromSnooze => 'Враћено из одлагања';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Са заставицом';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је архивирано',
      few: '$count поруке су архивиране',
      one: '$count порука је архивирана',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је избрисано',
      few: '$count поруке су избрисане',
      one: '$count порука је избрисана',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је премештено у Пријемно сандуче',
      few: '$count поруке су премештене у Пријемно сандуче',
      one: '$count порука је премештена у Пријемно сандуче',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је премештено у смеће',
      few: '$count поруке су премештене у смеће',
      one: '$count порука је премештена у смеће',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је премештено у Непожељно',
      few: '$count поруке су премештене у Непожељно',
      one: '$count порука је премештена у Непожељно',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је премештено у фасциклу $mailbox',
      few: '$count поруке су премештене у фасциклу $mailbox',
      one: '$count порука је премештена у фасциклу $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је премештено у фасциклу',
      few: '$count поруке су премештене у фасциклу',
      one: '$count порука је премештена у фасциклу',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count порука је одложено до $time',
      few: '$count поруке су одложене до $time',
      one: '$count порука је одложена до $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Одложено до $time само на овом уређају: сервер не може да чува времена одлагања.';
  }

  @override
  String get sharedMoveOneAccount => 'Изаберите поруке из једног налога да бисте их преместили.';

  @override
  String get sharedSnoozeTitle => 'Одлагање';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Промени време одлагања';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Трајно избрисати $count порука?',
      few: 'Трајно избрисати $count поруке?',
      one: 'Трајно избрисати $count поруку?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Ово не може да се опозове.';

  @override
  String get sharedDeletePermanently => 'Трајно избриши';

  @override
  String get sharedSwipeRead => 'Прочитано';

  @override
  String get sharedSwipeUnread => 'Непрочитано';

  @override
  String get sharedSwipeInbox => 'У пријемно';

  @override
  String get sharedSwipeDelete => 'Избриши';

  @override
  String get sharedTrash => 'У смеће';

  @override
  String get sharedSwipeSnooze => 'Одложи';

  @override
  String get sharedWakeNow => 'Врати сада';

  @override
  String get sharedChangeSnoozeTime => 'Промени време одлагања…';

  @override
  String get sharedSnooze => 'Одложи…';

  @override
  String get sharedTag => 'Ознаке…';

  @override
  String get sharedMoveMessage => 'Премести поруку…';

  @override
  String get sharedNotJunk => 'Није непожељно';

  @override
  String get accountSetupTitle => 'Додавање налога';

  @override
  String get accountSetupTitleDone => 'Налог је додат';

  @override
  String get accountSetupAddressTitle => 'Додајте налог е-поште';

  @override
  String get accountSetupAddressText => 'Loupe проналази подешавања за већину добављача.';

  @override
  String get accountSetupNameHint => 'Ваше име';

  @override
  String get accountSetupEmail => 'Е-пошта';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Настави';

  @override
  String get accountSetupLookingUp => 'Тражење подешавања…';

  @override
  String get accountSetupImport => 'Увези из Thunderbird-а';

  @override
  String get accountSetupInvalidEmail => 'Унесите исправну адресу е-поште.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Подешавања за $domain нису пронађена. Унесите их испод.';
  }

  @override
  String get accountSetupCheckServers => 'Проверите називе сервера и портове.';

  @override
  String get accountSetupEnterPassword => 'Унесите лозинку.';

  @override
  String get accountSetupConnecting => 'Повезивање…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Чека се $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Страница није могла да се отвори.';

  @override
  String get accountSetupCouldNotSaveName => 'Име није могло да се сачува.';

  @override
  String get accountSetupTrustCertificate => 'Веруј овом сертификату';

  @override
  String get accountSetupPasswordRequired => 'Обавезно';

  @override
  String get accountSetupShowPassword => 'Прикажи лозинку';

  @override
  String get accountSetupHidePassword => 'Сакриј лозинку';

  @override
  String get accountSetupAppPassword => 'Лозинка за апликацију';

  @override
  String get accountSetupApiToken => 'API токен';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Долазна пошта · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Одлазна пошта · SMTP';

  @override
  String get accountSetupSignIn => 'Пријави се';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Пријави се преко $provider налога';
  }

  @override
  String get accountSetupUseAppPassword => 'Користи лозинку за апликацију';

  @override
  String get accountSetupUseAppPasswordInstead => 'Ипак користи лозинку за апликацију';

  @override
  String get accountSetupUseDifferentAddress => 'Користи другу адресу';

  @override
  String get accountSetupHowToCreateAppPassword => 'Како направити лозинку за апликацију';

  @override
  String get accountSetupHowToCreateOne => 'Упутство за прављење';

  @override
  String get accountSetupGoogleNote =>
      'Пријављујете се на страници компаније Google, а Loupe никада не види вашу лозинку. Дозволите апликацији Loupe да чита, шаље и организује вашу пошту.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '„Пријави се преко Google налога“ још није доступно у овој верзији. Уместо тога можете да се повежете лозинком за апликацију (потребна је верификација у 2 корака на вашем Google налогу).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Направите лозинку за апликацију у свом Google налогу и налепите је испод.';

  @override
  String get accountSetupMicrosoftNote =>
      'Пријављујете се на страници компаније Microsoft, а Loupe никада не види вашу лозинку. Ово ради за Outlook.com и Hotmail, као и за пословне или школске налоге на Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Пријављивање преко Microsoft налога стиже у једној од наредних верзија. Потребно је за Outlook, Hotmail и Microsoft 365 налоге: они више не прихватају лозинке из апликација за пошту.';

  @override
  String get accountSetupICloudNote =>
      'За iCloud Mail потребна је лозинка специфична за апликацију, а не лозинка вашег Apple налога.';

  @override
  String get accountSetupYahooNote => 'За Yahoo Mail потребна је лозинка за апликацију, а не лозинка вашег налога.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe се повезује на Fastmail преко протокола JMAP помоћу API токена: Settings › Privacy & Security › Manage API tokens, за JMAP, са приступом е-пошти и слању.';

  @override
  String get accountSetupFastmailNote => 'Fastmail за апликације за пошту тражи лозинку за апликацију.';

  @override
  String get accountSetupServerSettings => 'Подешавања сервера';

  @override
  String get accountSetupSettingsNotFound => 'Нису пронађена аутоматски';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Пронађено преко: $source';
  }

  @override
  String get accountSetupEditSettings => 'Уреди подешавања';

  @override
  String get accountSetupSyncing => 'Ваша пошта се синхронизује.';

  @override
  String get accountSetupDescription => 'Опис';

  @override
  String get accountSetupDescriptionHint => 'Посао, Лично…';

  @override
  String get accountSetupColour => 'Боја';

  @override
  String accountSetupColourNumber(int number) {
    return 'Боја $number';
  }

  @override
  String get accountSetupSaving => 'Чување…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe није могао да отвори базу поште на овом телефону. Затворите Loupe, поново га отворите и покушајте опет.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Дошло је до грешке ($error). Покушајте поново.';
  }

  @override
  String get accountSetupSecurityNone => 'Нема';

  @override
  String get accountSetupProtocol => 'Протокол';

  @override
  String get accountSetupPort => 'Порт';

  @override
  String get accountSetupSecurity => 'Безбедност';

  @override
  String get accountSetupUsername => 'Корисничко име';

  @override
  String get accountSetupUsernameHint => 'Ваша адреса е-поште';

  @override
  String get accountSetupNoEncryptionTitle => 'Повезати се без шифровања?';

  @override
  String get accountSetupNoEncryptionText =>
      'Ваша лозинка и свака порука преносиле би се као обичан текст. Свако на мрежи, на пример на јавној Wi-Fi мрежи, могао би да их прочита. Користите ово само за сервер на сопственој мрежи.';

  @override
  String get accountSetupUseWithoutEncryption => 'Користи без шифровања';

  @override
  String get accountSetupApiTokenRejected =>
      'API токен је одбијен. Направите Fastmail API токен за JMAP са приступом е-пошти и налепите га.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Лозинка је одбијена. Користите лозинку за апликацију, а не лозинку налога.';

  @override
  String get accountSetupPasswordRejected => 'Лозинка је одбијена. Проверите је и покушајте поново.';

  @override
  String get accountSetupServerUnreachable => 'Сервер није доступан. Проверите подешавања сервера и везу.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Сертификат сервера није поуздан. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Пријављивање је отказано. Додирните „Пријави се преко $provider налога“ да бисте покушали поново.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe мора да добије дозволу да чита и шаље вашу Gmail пошту. Пријавите се поново и дозволите приступ, са означеним пољем за Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe мора да добије дозволу да чита и шаље вашу пошту. Пријавите се поново и прихватите дозволе.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Ваша организација мора да одобри Loupe пре него што га будете могли да користите са овим налогом. Замолите свог IT администратора да у Microsoft Entra ID одобри Loupe за целу организацију (сагласност администратора), па покушајте поново.';

  @override
  String get accountSetupOAuthBlocked =>
      'Правила пријављивања ваше организације не дозвољавају Loupe на овом уређају. Обратите се свом IT администратору.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Услуга $provider није доступна. Проверите интернет везу и покушајте поново.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Пријављивање преко $provider налога није исправно подешено у овој верзији апликације Loupe. Пријавите нам то.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Пријављивање преко $provider налога није успело. Покушајте поново.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Пријављивање преко $provider налога је успело, али Gmail је одбио приступ за ову адресу. При пријављивању изаберите исти налог. Код пословних или школских налога администратор је можда искључио IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Пријављивање преко $provider налога је успело, али сервер поште је одбио приступ за ову адресу. При пријављивању изаберите исти налог. Код пословних или школских налога администратор је можда искључио IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable => 'Сервер поште није доступан. Проверите везу и покушајте поново.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Пријављивање преко $provider налога није доступно у овој верзији.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Поново сте пријављени. Налог $account се синхронизује.';
  }

  @override
  String get accountSetupSignInAgain => 'Пријави се поново';

  @override
  String get accountSetupSigningIn => 'Пријављивање…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider више не прихвата пријаву апликације Loupe за $email, па се налог $account не синхронизује. Пријавите се поново да бисте добијали пошту.';
  }

  @override
  String get accountImportTitle => 'Увоз из Thunderbird-а';

  @override
  String get accountImportPointCamera => 'Усмерите камеру ка QR коду који приказује Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Скенирано $scanned од $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Скенирано $scanned од $total кодова',
      few: 'Скенирано $scanned од $total кода',
      one: 'Скенирано $scanned од $total кода',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Засад $count налога',
      few: 'Засад $count налога',
      one: 'Засад $count налог',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'На рачунару отворите Thunderbird и изаберите Алатке › Извези за мобилни. Изаберите налоге, па скенирајте сваки код који прикаже. Кодови се могу скенирати било којим редом.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Настави са $count налога',
      few: 'Настави са $count налога',
      one: 'Настави са $count налогом',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Ипак налепи текст';

  @override
  String get accountImportStartOver => 'Почни испочетка';

  @override
  String get accountImportDuplicateCode => 'Тај код је већ додат.';

  @override
  String get accountImportRestarted => 'Овај код је из новог извоза, па су раније скенирани кодови стављени на страну.';

  @override
  String get accountImportNotThunderbird => 'Ово није код налога из Thunderbird-а.';

  @override
  String get accountImportNewerVersion =>
      'Овај код потиче из новије верзије Thunderbird-а. Ажурирајте Loupe да бисте га увезли.';

  @override
  String get accountImportDamaged => 'Овај Thunderbird код није могао да се прочита.';

  @override
  String get accountImportTooLarge => 'Овај код је превелик да би био извоз из Thunderbird-а.';

  @override
  String get accountImportCouldNotOpenSettings => 'Подешавања нису могла да се отворе.';

  @override
  String get accountImportCameraOffTitle => 'Приступ камери је искључен';

  @override
  String get accountImportCameraOffText =>
      'У подешавањима дозволите апликацији Loupe да користи камеру како бисте скенирали код или уместо тога налепите текст кода.';

  @override
  String get accountImportNoCameraTitle => 'Нема камере';

  @override
  String get accountImportNoCameraText => 'Loupe овде не може да користи камеру. Уместо тога налепите текст кода.';

  @override
  String get accountImportCameraFailedTitle => 'Камера се није покренула';

  @override
  String get accountImportCameraFailedText => 'Покушајте поново или уместо тога налепите текст кода.';

  @override
  String get accountImportOpenSettings => 'Отвори подешавања';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Пронађено $count налога',
      few: 'Пронађена $count налога',
      one: 'Пронађен $count налог',
      zero: 'Није пронађен ниједан налог',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Ниједан налог из ових кодова није могао да се прочита.';

  @override
  String get accountImportChoose => 'Изаберите налоге које желите да додате у Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Није скенирано $count кодова (бројеви $codes од $total), па њихови налози нису наведени.',
      few: 'Нису скенирана $count кода (бројеви $codes од $total), па њихови налози нису наведени.',
      one: 'Није скениран $count код (број $codes од $total), па његови налози нису наведени.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes и $last';
  }

  @override
  String get accountImportScanMore => 'Скенирај још кодова';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count налога из кодова није могло да се прочита. Можда користе подешавања из новије верзије апликације Thunderbird.',
      few:
          '$count налога из кодова нису могла да се прочитају. Можда користе подешавања из новије верзије апликације Thunderbird.',
      one:
          '$count налог из кодова није могао да се прочита. Можда користи подешавања из новије верзије апликације Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Скенирај поново';

  @override
  String get accountImportAlreadyAdded => 'Налог са овом адресом већ постоји у апликацији Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Када налог буде додат, пријавићете се преко $provider налога, као у Thunderbird-у.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Додајте налог помоћу лозинке за апликацију (потребна је верификација у 2 корака).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird се на Gmail пријављује преко Google налога. „Пријави се преко Google налога“ стиже у некој од наредних верзија; дотле додајте налог помоћу лозинке за апликацију (потребна је верификација у 2 корака).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird се на овај налог пријављује у прегледачу. Loupe то још не уме: користите лозинку за апликацију ако је ваш добављач нуди.';

  @override
  String get accountImportUnencrypted => 'Повезује се без шифровања. Користите ово само на сопственој мрежи.';

  @override
  String get accountImportEnterAgain => 'Унесите је поново';

  @override
  String get accountImportAdded => 'Додато';

  @override
  String accountImportAdding(int index, int total) {
    return 'Додавање $index од $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Додај $count налога',
      few: 'Додај $count налога',
      one: 'Додај $count налог',
      zero: 'Додај налоге',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Налепите текст извоза';

  @override
  String get accountImportPasteText => 'Налепите текст кода за извоз из Thunderbird-а, један код по реду.';

  @override
  String get accountImportPop3 => 'POP3 налози нису подржани. Loupe чува пошту на серверу преко протокола IMAP.';

  @override
  String get accountImportKerberos => 'Овај налог се пријављује помоћу протокола Kerberos, који Loupe не подржава.';

  @override
  String get accountImportNtlm => 'Овај налог се пријављује помоћу протокола NTLM, који Loupe не подржава.';

  @override
  String get accountImportClientCertificate =>
      'Овај налог се пријављује помоћу клијентског сертификата, који Loupe још не подржава.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Пријављивање преко Microsoft налога стиже у једној од наредних верзија. Outlook и Microsoft 365 налози више не прихватају лозинке из апликација за пошту.';

  @override
  String get accountImportEnterPassword => 'Унесите лозинку.';

  @override
  String get accountImportEnterAppPassword => 'Унесите лозинку за апликацију.';

  @override
  String get accountImportEnterApiToken => 'Унесите API токен.';

  @override
  String get accountImportStorageFailed => 'Loupe није могао да отвори складиште налога. Покушајте поново касније.';

  @override
  String get accountImportFailed => 'Налог није могао да се дода. Покушајте поново или га додајте ручно.';

  @override
  String get composeNewMessageTitle => 'Нова порука';

  @override
  String get composeAttach => 'Приложи';

  @override
  String get composeSendLater => 'Пошаљи касније';

  @override
  String composeSendAt(String time) {
    return 'Пошаљи: $time';
  }

  @override
  String get composeSendHint => 'Дуго притисните за касније слање';

  @override
  String get composeNoAccount => 'Додајте налог да бисте слали пошту.';

  @override
  String get composeTo => 'За:';

  @override
  String get composeCc => 'Копија:';

  @override
  String get composeBcc => 'Скривена копија:';

  @override
  String composeCcBccFrom(String email) {
    return 'Копија, скривена копија, Од: $email';
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
    return 'Одговори са $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Пошаљи са $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Одговорити са $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Послати са $email?';
  }

  @override
  String get composeDismiss => 'Одбаци';

  @override
  String composeAliasNotSaved(String account) {
    return 'Није сачувано као идентитет · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Сачувај као идентитет';

  @override
  String composeAliasSaved(String email) {
    return 'Адреса $email је сачувана као идентитет.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Неисправна адреса $address';
  }

  @override
  String get composeOriginalNotFound => 'Оригинална порука није пронађена.';

  @override
  String get composeDraftNotFound => 'Нацрт није пронађен.';

  @override
  String get composeAttachmentsLost => 'Прилози нису могли да се поврате. Додајте их поново.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Неки прилози нису могли да се додају: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Прилози укупно заузимају $size; неки сервери одбијају овако велике поруке.';
  }

  @override
  String get composeAttachFailed => 'Датотека није могла да се приложи.';

  @override
  String get composeInvalidAddressTitle => 'Неисправна адреса';

  @override
  String composeInvalidAddress(String address) {
    return '„$address“ није исправна адреса е-поште.';
  }

  @override
  String get composeNoSubjectTitle => 'Без теме';

  @override
  String get composeNoSubjectText => 'Ова порука нема тему. Ипак је послати?';

  @override
  String get composeSentBeforeChanges => 'Послата је пре ваших измена, које су сачуване у Нацртима.';

  @override
  String composeScheduled(String time) {
    return 'Заказано за $time';
  }

  @override
  String get composeSending => 'Слање…';

  @override
  String get composeSent => 'Послато';

  @override
  String get composeSendFailed => 'Слање није успело. Покушајте поново.';

  @override
  String get composeAlreadySent => 'Већ је послато.';

  @override
  String get composeDiscardChanges => 'Одбаци измене';

  @override
  String get composeSaveChanges => 'Сачувај измене';

  @override
  String get composeDeleteDraft => 'Избриши нацрт';

  @override
  String get composeSaveDraft => 'Сачувај нацрт';

  @override
  String get composeDraftSaved => 'Нацрт је сачуван';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date у $time, $name пише:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date у $time, неко пише:';
  }

  @override
  String get composeForwardHeader => '---------- Прослеђена порука ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Од: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Датум: $date у $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Тема: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'За: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Копија: $addresses';
  }

  @override
  String get composeLaterToday => 'Касније данас';

  @override
  String get composeTomorrowMorning => 'Сутра ујутру';

  @override
  String get composeMondayMorning => 'У понедељак ујутру';

  @override
  String get composePickDateTime => 'Изабери датум и време…';

  @override
  String get composeSendWithoutDelay => 'Пошаљи одмах';

  @override
  String composeSendTimeToday(String time) {
    return 'Данас у $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Сутра у $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day у $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Данас $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Сутра $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Наставити уређивање нацрта?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Порука није послата када се Loupe затворио.',
      'one': 'Порука за $name није послата када се Loupe затворио.',
      'other': 'Порука за $name и друге није послата када се Loupe затворио.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Порука „$subject“ није послата када се Loupe затворио.',
      'one': 'Порука „$subject“ за $name није послата када се Loupe затворио.',
      'other': 'Порука „$subject“ за $name и друге није послата када се Loupe затворио.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Настави уређивање';

  @override
  String get composeRecoverySave => 'Сачувај у нацрте';

  @override
  String get composeRecoveryDiscard => 'Одбаци';

  @override
  String get composeRecoverySaved => 'Сачувано у нацртима';

  @override
  String get outboxSectionFailed => 'Није послато';

  @override
  String get outboxSectionSending => 'Слање';

  @override
  String get outboxSectionScheduled => 'Заказано';

  @override
  String get outboxStatusQueued => 'Ускоро се шаље';

  @override
  String get outboxStatusSending => 'Слање…';

  @override
  String get outboxStatusFailed => 'Није послато';

  @override
  String get outboxNoRecipients => 'Нема прималаца';

  @override
  String get outboxNoSubject => '(Без теме)';

  @override
  String get outboxSendingFailed => 'Слање није успело.';

  @override
  String get outboxEmptyTitle => 'Нема ничег за слање';

  @override
  String get outboxEmptyText => 'Поруке које шаљете касније чекају овде док не дође време.';

  @override
  String get outboxSendNow => 'Пошаљи одмах';

  @override
  String get outboxReschedule => 'Промени време';

  @override
  String get outboxRescheduleMenu => 'Промени време…';

  @override
  String get outboxRescheduleTitle => 'Ново време слања';

  @override
  String outboxRescheduled(String time) {
    return 'Померено на $time';
  }

  @override
  String get outboxCancel => 'Откажи';

  @override
  String get outboxCancelSending => 'Откажи слање…';

  @override
  String get outboxCancelTitle => 'Отказати слање?';

  @override
  String get outboxMoveToDrafts => 'Премести у нацрте';

  @override
  String get outboxDiscard => 'Одбаци поруку';

  @override
  String get outboxMovedToDrafts => 'Премештено у нацрте';

  @override
  String get outboxDiscarded => 'Порука је одбачена';

  @override
  String get outboxAlreadySent => 'Већ је послато.';

  @override
  String get outboxBeingSent => 'Ова порука се управо шаље.';

  @override
  String get outboxActionFailed => 'То није успело. Порука је и даље у фасцикли Пошта за слање.';

  @override
  String get notificationsBadgeInboxes => 'Непрочитано у пријемним сандучићима';

  @override
  String get notificationsBadgeVip => 'Непрочитано у VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Нова пошта од ваших VIP контаката, на било ком налогу';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Нова пошта на $email';
  }

  @override
  String get notificationsUnknownSender => 'Непознат пошиљалац';

  @override
  String get notificationsNoSubject => '(Без теме)';

  @override
  String get notificationsEncryptedMessage => 'Шифрована порука';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Нова порука: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нових порука',
      few: '$count нове поруке',
      one: '$count нова порука',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Нове поруке: $account';
  }

  @override
  String get platformInstantChannel => 'Тренутна испорука';

  @override
  String get platformInstantChannelDescription =>
      'Приказује се док Loupe прати нову пошту у вашим пријемним сандучићима';

  @override
  String get platformInstantTitle => 'Праћење нове поште';

  @override
  String get platformInstantText => 'Тренутна испорука је укључена';

  @override
  String get platformErrorBox => 'Дошло је до грешке при приказу. Вратите се и покушајте поново.';

  @override
  String get welcomeTagline => 'Пошта која је једноставна споља\nи моћна изнутра.';

  @override
  String get welcomeAccountsTitle => 'Сви налози, једно мирно сандуче';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail и било који IMAP или JMAP сервер.';

  @override
  String get welcomeSearchTitle => 'Претрага која проналази';

  @override
  String get welcomeSearchText => 'Тренутни резултати на телефону, затим они са сервера.';

  @override
  String get welcomePrivacyTitle => 'Приватност по дизајну';

  @override
  String get welcomePrivacyText => 'Без праћења. Удаљене слике остају блокиране док не кажете другачије.';

  @override
  String get welcomeAddAccount => 'Додај налог';

  @override
  String get welcomeImport => 'Увези из Thunderbird-а';

  @override
  String get welcomeTryDemo => 'Испробај уз демо пошту';
}
