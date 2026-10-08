// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonDone => 'Bitti';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonMore => 'Diğer';

  @override
  String get commonMove => 'Taşı';

  @override
  String get commonName => 'Ad';

  @override
  String get commonNone => 'Yok';

  @override
  String get commonOff => 'Kapalı';

  @override
  String get commonOk => 'Tamam';

  @override
  String get commonOn => 'Açık';

  @override
  String get commonOptional => 'İsteğe bağlı';

  @override
  String get commonPassword => 'Parola';

  @override
  String get commonRemove => 'Kaldır';

  @override
  String get commonRetry => 'Yeniden dene';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonSearch => 'Ara';

  @override
  String get commonServer => 'Sunucu';

  @override
  String get commonSettings => 'Ayarlar';

  @override
  String get commonShare => 'Paylaş';

  @override
  String get commonTryAgain => 'Tekrar dene';

  @override
  String get commonUndo => 'Geri al';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ileti', one: '$count ileti');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arşivle';

  @override
  String get mailDelete => 'Sil';

  @override
  String get mailFlag => 'Bayrak koy';

  @override
  String get mailForward => 'İlet';

  @override
  String get mailMarkAsRead => 'Okundu olarak işaretle';

  @override
  String get mailMarkAsUnread => 'Okunmadı olarak işaretle';

  @override
  String get mailMoveToJunk => 'Gereksiz klasörüne taşı';

  @override
  String get mailNewMessage => 'Yeni ileti';

  @override
  String get mailNoSubject => 'Konu yok';

  @override
  String get mailReply => 'Yanıtla';

  @override
  String get mailReplyAll => 'Tümünü yanıtla';

  @override
  String get mailSend => 'Gönder';

  @override
  String get mailUnflag => 'Bayrağı kaldır';

  @override
  String get mailboxArchive => 'Arşiv';

  @override
  String get mailboxDrafts => 'Taslaklar';

  @override
  String get mailboxInbox => 'Gelen Kutusu';

  @override
  String get mailboxJunk => 'Gereksiz';

  @override
  String get mailboxOutbox => 'Giden Kutusu';

  @override
  String get mailboxSent => 'Gönderilmiş';

  @override
  String get mailboxTrash => 'Çöp Kutusu';

  @override
  String get conversationSomethingWentWrong => 'Bir sorun oluştu. Tekrar deneyin.';

  @override
  String get conversationReplyToList => 'Listeye yanıtla';

  @override
  String get conversationReplyList => 'Listeye yanıt';

  @override
  String get conversationThreadMuted => 'Yazışma sessize alındı. Yeni iletileri okunmuş olarak gelir.';

  @override
  String get conversationThreadUnmuted => 'Yazışmanın sesi açıldı.';

  @override
  String get conversationLinkFailed => 'Bağlantı açılamadı.';

  @override
  String get conversationGoneTitle => 'İleti yok';

  @override
  String get conversationGoneText => 'Bu ileti taşındı veya silindi.';

  @override
  String get conversationMuted => 'Sessize alındı';

  @override
  String get conversationReaderOptions => 'Okuma seçenekleri';

  @override
  String get conversationReaderOptionsHint => 'Metin boyutu ve görünüm';

  @override
  String get conversationTrash => 'Çöpe at';

  @override
  String get conversationReplyHint => 'Tümünü yanıtla ve İlet için uzun basın';

  @override
  String get conversationOfflineTitle => 'Çevrimdışısınız';

  @override
  String get conversationOfflineText => 'Bu yazışma henüz indirilmedi. Yeniden çevrimiçi olduğunuzda yüklenecek.';

  @override
  String get conversationErrorTitle => 'Bu ileti gösterilemiyor';

  @override
  String get conversationErrorText => 'Bir sorun oluştu.';

  @override
  String get conversationOfflineBanner => 'Çevrimdışısınız';

  @override
  String get conversationNotUpdated => 'Güncellenmedi';

  @override
  String get conversationMe => 'ben';

  @override
  String get conversationNoSender => '(gönderen yok)';

  @override
  String get conversationNoRecipients => 'alıcı yok';

  @override
  String conversationRecipients(String names) {
    return 'kime: $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'kime: $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Kimden';

  @override
  String get conversationHeaderTo => 'Kime';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Yanıt adresi';

  @override
  String get conversationHeaderDate => 'Tarih';

  @override
  String get conversationHeaderSecurity => 'Güvenlik';

  @override
  String get conversationVerifiedSender => 'Doğrulanmış gönderen';

  @override
  String get conversationUnverifiedSender => 'Doğrulanmamış gönderen';

  @override
  String get conversationLoadingMessage => 'İleti yükleniyor';

  @override
  String get conversationBodyError => 'Bu ileti yüklenemedi.';

  @override
  String get conversationBodyOffline => 'Çevrimdışısınız. İleti, yeniden çevrimiçi olduğunuzda yüklenecek.';

  @override
  String get conversationOriginalHint => 'Orijinal görünümde daha iyi görünür';

  @override
  String get conversationShowOriginal => 'Orijinali göster';

  @override
  String get conversationScrollToTop => 'En üste kaydır';

  @override
  String get conversationTagsMenu => 'Etiketler…';

  @override
  String get conversationMuteThread => 'Yazışmayı sessize al';

  @override
  String get conversationUnmuteThread => 'Yazışmanın sesini aç';

  @override
  String get conversationMoveMenu => 'Taşı…';

  @override
  String get conversationDeletePermanently => 'Kalıcı olarak sil';

  @override
  String get conversationMoveToTrash => 'Çöp Kutusu’na taşı';

  @override
  String get conversationNotJunk => 'Gereksiz değil';

  @override
  String get conversationShowAllHeaders => 'Tüm üst bilgileri göster';

  @override
  String get conversationViewSource => 'Kaynağı görüntüle';

  @override
  String get conversationSaveAsFile => 'Dosya olarak kaydet…';

  @override
  String get conversationShareAsFile => 'Dosya olarak paylaş…';

  @override
  String get conversationSearchFromMessageMenu => 'Bu iletiden yola çıkarak ara…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Adresi kopyala';

  @override
  String get conversationAddressCopied => 'Adres kopyalandı';

  @override
  String conversationSearchMessagesFrom(String name) {
    return '$name tarafından gönderilen iletileri ara';
  }

  @override
  String get conversationTags => 'Etiketler';

  @override
  String get conversationAllHeaders => 'Tüm üst bilgiler';

  @override
  String get conversationCopyAll => 'Tümünü kopyala';

  @override
  String get conversationHeadersCopied => 'Üst bilgiler kopyalandı';

  @override
  String get conversationNoHeaders => 'Üst bilgi yok';

  @override
  String get conversationSearchFromMessageTitle => 'Bu iletiden yola çıkarak ara';

  @override
  String conversationSearchFrom(String name) {
    return 'Kimden: $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Kime: $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Konu: “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Kaynak';

  @override
  String get conversationSourceCopied => 'Kaynak kopyalandı';

  @override
  String get conversationShareFailed => 'İleti paylaşılamadı.';

  @override
  String get conversationWrapLines => 'Satırları kaydır';

  @override
  String get conversationDontWrapLines => 'Satırları kaydırma';

  @override
  String get conversationSourceError => 'Kaynak yüklenemedi.';

  @override
  String conversationSourceCut(String shown, String total) {
    return '$total içinden ilk $shown gösteriliyor. Tamamı için kopyalayın veya paylaşın.';
  }

  @override
  String get conversationAttachmentUntitled => 'Adsız';

  @override
  String conversationAttachmentMoreActions(String name) {
    return '$name için diğer işlemler';
  }

  @override
  String get conversationMoveTo => 'Şuraya taşı…';

  @override
  String get conversationMailboxesError => 'Posta kutuları yüklenemedi.';

  @override
  String get conversationReaderReadable => 'Okunaklı';

  @override
  String get conversationReaderOriginal => 'Orijinal';

  @override
  String get conversationReaderPlain => 'Düz metin';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Orijinal renkleri koru';

  @override
  String get conversationReaderRemember => 'Bu gönderen için hatırla';

  @override
  String get conversationSecurityPossiblePhishing => 'Olası kimlik avı';

  @override
  String get conversationSecurityBeCareful => 'Dikkatli olun';

  @override
  String get conversationSecurityVerified => 'Doğrulandı';

  @override
  String get conversationSecurityNoIssues => 'Sorun bulunamadı';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count izleyici', one: '$count izleyici');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Nedenini gösterir';

  @override
  String get conversationPhishingBannerTitle => 'Bu ileti kimlik avı gibi görünüyor';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Bağlantılar ve görseller kapatıldı.';
  }

  @override
  String get conversationPhishingBannerText => 'Bağlantılar ve görseller kapatıldı.';

  @override
  String get conversationPhishingWhy => 'Neden?';

  @override
  String get conversationPhishingShowAnyway => 'Yine de göster';

  @override
  String get conversationSecurityPhishingTitle => 'Bu, kimlik avı gibi görünüyor';

  @override
  String get conversationSecurityPhishingText => 'Birçok işaret, bu iletinin iddia ettiği şey olmadığını gösteriyor.';

  @override
  String get conversationSecurityCarefulTitle => 'Bu iletiye dikkat edin';

  @override
  String get conversationSecurityCarefulText => 'İçinde ikinci kez bakmaya değer bir şey var.';

  @override
  String get conversationSecurityVerifiedText => 'Gönderen doğrulandı ve şüpheli bir şey görünmüyor.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Şüpheli bir şey görünmüyor. E-posta sunucunuz gönderenin doğrulanıp doğrulanmadığını belirtmedi.';

  @override
  String get conversationSecurityNothingSuspicious => 'Şüpheli bir şey görünmüyor.';

  @override
  String get conversationSecurityWhy => 'Neden';

  @override
  String get conversationSecurityPrivacy => 'Gizlilik';

  @override
  String get conversationSecurityNoTrackingPixels => 'İzleme pikseli yok';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count izleme pikseli kaldırıldı',
      one: '$count izleme pikseli kaldırıldı',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Bu iletiyi açtığınızda gönderene haber vereceklerdi.';

  @override
  String get conversationSecurityNoRemoteImages => 'Uzak görsel yok';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uzak görsel',
      one: '$count uzak görsel',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Bunları yüklemek, bu iletiyi ne zaman okuduğunuzu ve IP adresinizi gönderene bildirir.';

  @override
  String get conversationSecurityNoClickTracking => 'Tıklama izleme yok';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tıklama izleyicilerinden geçen $count bağlantı',
      one: 'Tıklama izleyicisinden geçen $count bağlantı',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services tıklamanızı kaydeder. Hedefini doğrudan açmak için bağlantıya uzun basın.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Teknik ayrıntılar';

  @override
  String get conversationSecurityCheckedLocally => 'Bu cihazda denetlendi. Hiçbir yere bir şey gönderilmedi.';

  @override
  String get conversationSecurityTrackersLabel => 'İzleyiciler';

  @override
  String get conversationSecurityImagesFrom => 'Görsellerin kaynağı';

  @override
  String get conversationSecuritySenderHistory => 'Gönderen geçmişi';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return '$received alındı, $sent gönderildi';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Bağlantıların hedefi';

  @override
  String get conversationSecurityHidden => 'Gizli';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements öğe', one: '$elements öğe');
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters karakter',
      one: '$characters karakter',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Gönderen doğrulanmadı';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'E-posta sunucunuz bu iletinin gerçekten $domain alan adından geldiğini doğrulayamadı.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'E-posta sunucunuz bu iletinin gerçekten göndereninden geldiğini doğrulayamadı.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'E-posta sunucunuz bu iletinin $domain alan adından geldiğini doğrulayamadı. E-posta listelerinde sık görülür.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'E-posta sunucunuz bu iletinin göndereninden geldiğini doğrulayamadı. E-posta listelerinde sık görülür.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Beklediğiniz bir ileti değilse ona göre hareket etmeyin. Emin değilseniz gönderenle başka bir yoldan iletişime geçin.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Başka bir alan adıyla imzalanmış';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'İleti $domain ile değil, $signer ile imzalanmış. E-posta hizmetleri bunu yapar ama bu, iletiyi kimin yazdığını kanıtlamaz.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'İleti $domain ile değil, başka bir alan adıyla imzalanmış. E-posta hizmetleri bunu yapar ama bu, iletiyi kimin yazdığını kanıtlamaz.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Ad farklı bir adres gösteriyor';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Gönderenin adı “$shown” olarak görünüyor ama ileti $email adresinden geliyor.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Ada değil, adrese güvenin.';

  @override
  String get conversationSecurityReplyToTitle => 'Yanıtlar başka yere gidiyor';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Yanıt verirseniz cevabınız $domain alan adına değil, $address adresine gider.';
  }

  @override
  String get conversationSecurityReplyToAdvice => 'Kişisel bir şeyle yanıt vermeden önce adresi kontrol edin.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Adınızı kullanıyor';

  @override
  String get conversationSecurityImpersonationTitle => 'Tanıdığınız birinin adını kullanıyor';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Tıpkı sizin adınız gibi “$name” imzasını taşıyor ama yeni bir adresten geliyor: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Tıpkı VIP kişiniz $knownName ($knownEmail) gibi “$name” imzasını taşıyor ama yeni bir adresten geliyor: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Tıpkı $knownName ($knownEmail) gibi “$name” imzasını taşıyor ama yeni bir adresten geliyor: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere => 'Üstelik yanıtlar da bambaşka bir adrese gider.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Para, kod veya dosya istiyorsa önce kişiyle başka bir yoldan teyit edin.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Bilinen adres: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Bu adres: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Bu gönderenden ilk ileti';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Daha önce $email adresinden e-posta almadınız.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Henüz tanımadığınız kişilerden gelen isteklere dikkat edin.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Gönderen adresinde benzer görünümlü harfler';

  @override
  String get conversationSecurityLinkHomographTitle => 'Bir bağlantıda benzer görünümlü harfler';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host, başka bir adresi taklit etmek için farklı alfabelerden harfleri karıştırıyor.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host benzer görünümlü harfler kullanıyor: $real değil.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Silin ya da gereksiz olarak bildirin.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Açmayın.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Alan adı: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Benzer görünümlü alan adı';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Alan adında tanıdık bir ad kullanıyor';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain, kendi alan adınız olan $real gibi görünüyor ama farklı bir alan adı.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain, $brand ($real) gibi görünüyor ama farklı bir alan adı.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain, kendi alan adınız olan $real adını kullanıyor ama ona ait değil.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain, $brand ($real) adını kullanıyor ama ona ait değil.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Kuruluşunuzdan gelen gerçek iletiler $real alan adından gelir.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return '$brand tarafından gönderilen gerçek iletiler $real alan adından gelir.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Gönderen alan adı: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Taklit ettiği: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bağlantı nereye gittiğini gizliyor',
      one: 'Bir bağlantı nereye gittiğini gizliyor',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Bir bağlantı $shown gösteriyor ama $host adresini açıyor.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Bu bağlantılar üzerinden oturum açmayın veya ödeme yapmayın. Bunun yerine adresi kendiniz yazın.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Bir bağlantının hedefi denetlenemiyor';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Bir bağlantı $shown gösteriyor ama tıklamayı kaydedip yönlendiren $host üzerinden geçiyor.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Bir bağlantı yalın bir IP adresine gidiyor';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts adı olan bir web sitesi değil. Gerçek şirketler nadiren böyle bağlantı verir.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Kılık değiştirmiş bir bağlantı';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Bir bağlantı $shown gibi görünmek için “$shown@” ile başlıyor ama $host adresini açıyor.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Gizli bir sayfa devre dışı bırakıldı';

  @override
  String get conversationSecurityDataLinkText =>
      'Bir bağlantı, iletinin içine gömülü bir sayfayı açacaktı. Bu, bağlantı denetimlerini atlatmanın bir yoludur.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Parola istiyor';

  @override
  String get conversationSecurityPasswordFieldText => 'İleti bir parola alanı içeriyordu. Loupe onu kaldırdı.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Bir e-postaya asla parola yazmayın.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Kod çalıştıran bir bağlantı devre dışı bırakıldı';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe iletilerdeki kodları asla çalıştırmaz.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kısaltılmış bağlantılar',
      one: 'Kısaltılmış bir bağlantı',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts, siz açana kadar gerçek hedefi gizler.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Uluslararası web adresi';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts Latin alfabesi dışında harfler kullanıyor. Birçok dil için normaldir; beklediğiniz site olduğunu kontrol edin.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Çok fazla gizli metin';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count karakterlik görünmez metin kaldırıldı. Bu tür gizli metinler spam filtrelerini kandırmak içindir.',
      one: '$count karakterlik görünmez metin kaldırıldı. Bu tür gizli metinler spam filtrelerini kandırmak içindir.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Gizli metin kaldırıldı';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count karakterlik görünmez metin kaldırıldı.',
      one: '$count karakterlik görünmez metin kaldırıldı.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'İleti indirilemedi. Bağlantıyı kontrol edip tekrar deneyin.';

  @override
  String exportSaved(String name) {
    return '“$name” kaydedildi';
  }

  @override
  String get exportSaveFailed => 'İleti kaydedilemedi.';

  @override
  String exportFailed(String folder) {
    return '“$folder” dışa aktarılamadı.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” klasöründe dışa aktarılacak ileti yok.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '“$folder” dışa aktarılamadı: hiçbir ileti indirilemedi. Bağlantıyı kontrol edip tekrar deneyin.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$name” kaydedildi; indirilemeyen $formattedCount ileti hariç.',
      one: '“$name” kaydedildi; indirilemeyen 1 ileti hariç.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '“$name” kaydedilemedi.';
  }

  @override
  String exportTitle(String folder) {
    return '“$folder” dışa aktarılıyor';
  }

  @override
  String get exportListing => 'İletiler bulunuyor…';

  @override
  String exportProgress(String current, String total) {
    return '$current / $total dışa aktarılıyor…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount ileti indirilemedi',
      one: '1 ileti indirilemedi',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Posta kutuları';

  @override
  String get mailboxesShown => 'Gösteriliyor';

  @override
  String get mailboxesHidden => 'Gizli';

  @override
  String get mailboxesCollapse => 'Daralt';

  @override
  String get mailboxesExpand => 'Genişlet';

  @override
  String get mailboxesManageVips => 'VIP’leri yönet';

  @override
  String get mailboxesSubscriptions => 'Abonelikler';

  @override
  String mailboxesShowAccount(String account) {
    return '$account hesabını göster';
  }

  @override
  String mailboxesHideAccount(String account) {
    return '$account hesabını gizle';
  }

  @override
  String get mailboxesExportFolder => 'Klasörü dışa aktar…';

  @override
  String get mailboxesUnpin => 'Sabitlemeyi kaldır';

  @override
  String get mailboxesLists => 'Listeler';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Burada tutmak için bir aramayı kaydedin.';

  @override
  String get mailboxesTags => 'Etiketler';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter => 'Bir iletide gönderenin adına dokunup VIP’yi de açabilirsiniz.';

  @override
  String get mailboxesAddVip => 'VIP ekle…';

  @override
  String get mailboxesAddVipTitle => 'VIP ekle';

  @override
  String get mailboxesAddVipText => 'Bu adresten gelen e-postalar yıldız alır ve VIP posta kutusunda görünür.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Okunmamış';

  @override
  String get messageListFilterFlagged => 'Bayraklı';

  @override
  String get messageListFilterToMe => 'Kime: Ben';

  @override
  String get messageListFilterCcMe => 'Cc: Ben';

  @override
  String get messageListFilterWithAttachments => 'Ekli';

  @override
  String get messageListFilterUnreplied => 'Yanıtlanmamış';

  @override
  String get messageListFilterFromVips => 'VIP’lerden';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti okundu olarak işaretlendi',
      one: '1 ileti okundu olarak işaretlendi',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Daha eski e-postalar yüklenemedi.';

  @override
  String get messageListSelectMessages => 'İleti seçin';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count seçildi', one: '$count seçildi');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Tümünü seç';

  @override
  String get messageListDeselectAll => 'Seçimi kaldır';

  @override
  String get messageListLoadFailed => 'E-postalar yüklenemedi';

  @override
  String get messageListNoUnread => 'Okunmamış e-posta yok';

  @override
  String get messageListNoMatches => 'Eşleşen e-posta yok';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtre: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Filtreyi kapat';

  @override
  String get messageListEmpty => 'E-posta yok';

  @override
  String get messageListFilter => 'Filtre';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Filtre ölçütleri: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtre:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount okunmamış',
      one: '$formattedCount okunmamış',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'İşaretle';

  @override
  String get messageListTrash => 'Çöpe at';

  @override
  String get messageListFilterTitle => 'Filtre';

  @override
  String get messageListFilterInclude => 'DAHİL ET';

  @override
  String get panesHideMailboxes => 'Posta kutularını gizle';

  @override
  String get panesShowMailboxes => 'Posta kutularını göster';

  @override
  String get panesMailboxesWidth => 'Posta kutuları genişliği';

  @override
  String get panesListWidth => 'İleti listesi genişliği';

  @override
  String get panesNoMessageSelected => 'Seçili ileti yok';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ileti', one: '1 ileti');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Ertelenenler';

  @override
  String get snoozeSheetTitle => 'Ertele';

  @override
  String get snoozeLaterToday => 'Bugün daha sonra';

  @override
  String get snoozeThisEvening => 'Bu akşam';

  @override
  String get snoozeTomorrow => 'Yarın';

  @override
  String get snoozeThisWeekend => 'Bu hafta sonu';

  @override
  String get snoozeNextWeek => 'Gelecek hafta';

  @override
  String get snoozePickDateTime => 'Tarih ve saat seç…';

  @override
  String get snoozeMenu => 'Ertele…';

  @override
  String get snoozeWakeNow => 'Şimdi geri getir';

  @override
  String get snoozeChangeTimeMenu => 'Erteleme zamanını değiştir…';

  @override
  String get snoozeChangeTime => 'Zamanı değiştir';

  @override
  String get snoozeNoTime => 'Zaman belirlenmedi';

  @override
  String get snoozeFooter => 'Ertelenen iletiler, zamanı geldiğinde okunmamış olarak Gelen Kutusu’na döner.';

  @override
  String get snoozeEmptyTitle => 'Ertelenen ileti yok';

  @override
  String get snoozeEmptyText => 'Bir iletiyi erteleyin, ihtiyacınız olduğunda Gelen Kutusu’na geri gelsin.';

  @override
  String get appLockUnlock => 'Kilidi aç';

  @override
  String get appLockFailed => 'Loupe kimliğinizi doğrulayamadı.';

  @override
  String get appLockLockedOut => 'Çok fazla deneme yapıldı. Daha sonra tekrar deneyin.';

  @override
  String get appLockPromptError => 'Doğrulama penceresi gösterilemedi. Tekrar deneyin.';

  @override
  String get appLockNoScreenLock => 'Bu telefonda ekran kilidi yok.';

  @override
  String get appLockUnlockPromptTitle => 'Loupe’un kilidini aç';

  @override
  String get appLockUnlockPromptReason => 'E-postalarınızı görmek için kimliğinizi doğrulayın.';

  @override
  String get appLockTurnOnPromptTitle => 'Uygulama Kilidi’ni aç';

  @override
  String get appLockTurnOnPromptReason => 'Uygulama Kilidi’ni açmak için kimliğinizi doğrulayın.';

  @override
  String get appLockScreenLockRemoved =>
      'Uygulama Kilidi kapandı: bu telefonda artık ekran kilidi yok. Uygulama Kilidi’ni yeniden açmak için bir ekran kilidi ayarlayın.';

  @override
  String get appLockAfterImmediately => 'Hemen';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count dakika', one: '1 dakika');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count saat', one: '1 saat');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Şifreli';

  @override
  String get openpgpEncryptedInPart => 'Kısmen şifreli';

  @override
  String get openpgpEncryptedLocked => 'Şifreli · kilitli';

  @override
  String get openpgpEncryptedNoKey => 'Şifreli · anahtar yok';

  @override
  String get openpgpEncryptedDamaged => 'Şifreli · hasarlı';

  @override
  String get openpgpEncryptedUnsupported => 'Şifreli · desteklenmiyor';

  @override
  String get openpgpUnknownSigner => 'bilinmeyen';

  @override
  String get openpgpUnknownKey => 'Bilinmeyen anahtar';

  @override
  String get openpgpSignatureInvalid => 'İmza geçersiz';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'İmzalayan: $name (gönderen değil)';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Kısmen imzalayan: $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'İmzalayan: $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Reddedilmiş bir anahtarla imzalanmış';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'İmzalayan: $name · anahtar kabul edilmedi';
  }

  @override
  String get openpgpUnlock => 'Kilidi aç';

  @override
  String get openpgpCantDecrypt => 'Bu iletinin şifresi çözülemiyor';

  @override
  String get openpgpEncryptedWithOpenPgp => 'OpenPGP ile şifrelenmiş';

  @override
  String get openpgpEncryption => 'Şifreleme';

  @override
  String get openpgpDecryptedHere => 'Şifresi bu cihazda çözüldü';

  @override
  String get openpgpNotDecrypted => 'Şifresi çözülmedi';

  @override
  String get openpgpKeyLocked => 'Anahtarınız kilitli.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Anahtarlar: $keys', one: 'Anahtar: $keys');
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Korumalı konu';

  @override
  String get openpgpUnlockKey => 'Anahtarın kilidini aç';

  @override
  String get openpgpSignature => 'İmza';

  @override
  String get openpgpFingerprint => 'Parmak izi';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Anahtar kimliği $id';
  }

  @override
  String get openpgpSigned => 'İmzalanma';

  @override
  String get openpgpProblem => 'Sorun';

  @override
  String get openpgpAcceptance => 'Kabul';

  @override
  String get openpgpChangeAcceptance => 'Kabul durumunu değiştir…';

  @override
  String get openpgpCheckedFooter => 'Bu cihazda, Thunderbird ile uyumlu OpenPGP ile denetlendi.';

  @override
  String get openpgpSummaryLocked => 'Anahtarınız kilitli. Bu iletiyi okumak için parolasıyla kilidini açın.';

  @override
  String get openpgpSummaryNoSecretKey => 'Bu cihazda olmayan bir anahtar için şifrelenmiş.';

  @override
  String get openpgpSummaryDamaged => 'Şifreli veriler hasarlı ya da yolda değiştirilmiş.';

  @override
  String get openpgpSummaryUnsupported => 'Loupe’un desteklemediği bir algoritma kullanıyor.';

  @override
  String get openpgpSummaryEncrypted => 'Yalnızca siz ve diğer alıcılar okuyabilir.';

  @override
  String get openpgpSummaryNotSigned => 'İmzalı değil, bu yüzden gönderen doğrulanmadı.';

  @override
  String get openpgpSummaryUnknownKey => 'İmzalı, ancak sizde olmayan bir anahtarla; bu yüzden imza denetlenemiyor.';

  @override
  String get openpgpSummaryBadSignature => 'İmza eşleşmiyor: ileti değiştirilmiş olabilir.';

  @override
  String get openpgpSummaryMismatch => 'İmza geçerli, ancak anahtar gönderenin adresine değil, başka bir adrese ait.';

  @override
  String get openpgpSummaryPartial =>
      'İletinin yalnızca bir kısmı imzalı. İmzanın dışındaki metin (örneğin bir e-posta listesinin alt bilgisi) “Unsigned content” satırının altında gösterilir; ekler gibi iletinin diğer kısımları da imzanın kapsamında değildir.';

  @override
  String get openpgpSummaryOwnKey => 'Kendi anahtarınızla imzalanmış.';

  @override
  String get openpgpSummaryVerified => 'İmza geçerli ve anahtarın parmak izini doğruladınız.';

  @override
  String get openpgpSummaryUnverified => 'İmza geçerli. Anahtarı, parmak izini denetlemeden kabul ettiniz.';

  @override
  String get openpgpSummaryRejected => 'İmza geçerli, ancak bu anahtarı reddettiniz.';

  @override
  String get openpgpSummaryUndecided =>
      'İmza geçerli, ancak bu anahtarı henüz kabul etmediniz. Parmak izini gönderenle karşılaştırın.';

  @override
  String get openpgpAcceptanceRejected => 'Reddedildi';

  @override
  String get openpgpAcceptanceUndecided => 'Kabul edilmedi';

  @override
  String get openpgpAcceptanceUnverified => 'Kabul edildi';

  @override
  String get openpgpAcceptanceVerified => 'Kabul edildi ve doğrulandı';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return '$name kişisinin anahtarı kabul edilsin mi?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Parmak izi $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Evet, parmak izini doğruladım';

  @override
  String get openpgpAcceptUnverified => 'Evet, denetlemeden';

  @override
  String get openpgpAcceptLater => 'Henüz değil';

  @override
  String get openpgpRejectKey => 'Bu anahtarı reddet';

  @override
  String get openpgpNoSubject => '(konu yok)';

  @override
  String get openpgpEncryptionTitle => 'Uçtan uca şifreleme';

  @override
  String get openpgpMyKeys => 'OpenPGP anahtarlarım';

  @override
  String get openpgpMyKeysFooter =>
      'Bir anahtarla şifreli e-postaları okuyabilir, kendi e-postalarınızı imzalayıp şifreleyebilirsiniz. Thunderbird mı kullanıyorsunuz? Anahtarınızı orada dışa aktarın (Hesap Ayarları › Uçtan Uca Şifreleme › Gizli Anahtarı Dışa Aktar) ve buraya içe aktarın.';

  @override
  String get openpgpAddKey => 'Anahtar ekle…';

  @override
  String get openpgpAddresses => 'Adresler';

  @override
  String get openpgpAddressesFooter => 'Her adresin hangi anahtarı kullandığı ve ne zaman şifreleyip imzaladığı.';

  @override
  String get openpgpCorrespondentsKeys => 'Yazıştığınız kişilerin OpenPGP anahtarları';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Sahibine ait olduğuna güvendiğinizde bir anahtarı kabul edin; doğrulandı olarak işaretlemek için parmak izini sahibiyle karşılaştırın.';

  @override
  String get openpgpImportPublicKey => 'Açık anahtar içe aktar…';

  @override
  String get openpgpCollected => 'Autocrypt ile toplananlar';

  @override
  String get openpgpCollectedFooter =>
      'İletilerle gelen anahtarlar. İki taraf da istediğinde Loupe bu anahtarlarla şifreleyebilir.';

  @override
  String get openpgpOnThisDevice => 'Bu cihazda';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Şifreli iletiler konularını gizler. Loupe, açtığınız her iletinin konusunu bu cihazdaki şifreli veritabanında saklar; böylece liste, arama ve bildirimler konuyu gösterebilir. Loupe arka planda, parolası olmayan anahtarlarla yeni iletilerin konularının şifresini de çözebilir; bunun için her iletiyi (en fazla 1 MB) indirir.';

  @override
  String get openpgpDecryptSubjects => 'Konuların şifresini arka planda çöz';

  @override
  String get openpgpIndexFooter =>
      'Arama, şifreli iletileri gönderenine, alıcılarına ve konusuna göre bulur. Bu açıkken Loupe, şifresini çözdüğü her şifreli iletinin metnini de bu cihazdaki şifreli veritabanında bulunan arama dizinine ekler; böylece arama, iletileri metinlerine göre de bulur. Kapatırsanız bu metin dizinden kaldırılır.';

  @override
  String get openpgpIndexDecrypted => 'Şifresi çözülen iletileri aramaya dizinle';

  @override
  String get openpgpPassphrases => 'Parolalar';

  @override
  String get openpgpPassphrasesFooter =>
      'Parolayla koruduğunuz OpenPGP anahtarları ve S/MIME sertifikalarının kilidi gerektiğinde açılır. “Parolaları hatırla” kapalıyken her kullanımdan iki dakika sonra yeniden kilitlenirler.';

  @override
  String get openpgpRememberPassphrases => 'Parolaları hatırla';

  @override
  String get openpgpRememberPassphrasesDetail => 'Loupe kapanana kadar';

  @override
  String get openpgpLockKeysNow => 'Anahtarları şimdi kilitle';

  @override
  String get openpgpKeysLocked => 'Anahtarlar kilitlendi.';

  @override
  String get openpgpKeyStateRevoked => 'iptal edildi';

  @override
  String get openpgpKeyStateExpired => 'süresi doldu';

  @override
  String get openpgpKeyStateNeverExpires => 'süresi dolmaz';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'son geçerlilik: $date';
  }

  @override
  String get openpgpNoKey => 'Anahtar yok';

  @override
  String get openpgpAlwaysEncrypt => 'Her zaman şifrele';

  @override
  String get openpgpAddKeyTitle => 'OpenPGP anahtarı ekle';

  @override
  String get openpgpAddKeyMessage =>
      'Thunderbird’de kullandığınız anahtarı içe aktarın ya da yeni bir anahtar oluşturun.';

  @override
  String get openpgpImportFromClipboard => 'Panodan içe aktar';

  @override
  String get openpgpImportFromFile => 'Dosyadan içe aktar';

  @override
  String get openpgpGenerateNewKey => 'Yeni anahtar oluştur';

  @override
  String get openpgpImportPublicKeyTitle => 'Açık anahtar içe aktar';

  @override
  String get openpgpFromClipboard => 'Panodan';

  @override
  String get openpgpFromFile => 'Dosyadan';

  @override
  String get openpgpClipboardEmpty => 'Pano boş. Önce anahtarı kopyalayın.';

  @override
  String get openpgpKey => 'Anahtar';

  @override
  String get openpgpValidityRevoked => 'İptal edildi';

  @override
  String openpgpValidityExpired(String date) {
    return 'Süresi doldu: $date';
  }

  @override
  String get openpgpNeverExpires => 'Süresi dolmaz';

  @override
  String openpgpValidUntil(String date) {
    return 'Son geçerlilik: $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Parmak izi kopyalandı.';

  @override
  String get openpgpAlgorithm => 'Algoritma';

  @override
  String get openpgpCreated => 'Oluşturulma';

  @override
  String get openpgpValidity => 'Geçerlilik';

  @override
  String get openpgpProtection => 'Koruma';

  @override
  String get openpgpProtectionPassphrase => 'Parola';

  @override
  String get openpgpProtectionKeychain => 'Yalnızca anahtar deposu';

  @override
  String get openpgpKeyDetailsFooter =>
      'Başkalarının size şifreli ileti gönderebilmesi için açık anahtarınızı paylaşın. Yedek, varsa parolasıyla korunan gizli anahtarınızdır: onu kimseyle paylaşmayın.';

  @override
  String get openpgpSharePublicKey => 'Açık anahtarı paylaş';

  @override
  String get openpgpCopyPublicKey => 'Açık anahtarı kopyala';

  @override
  String get openpgpPublicKeyCopied => 'Açık anahtar kopyalandı.';

  @override
  String get openpgpBackUpSecretKey => 'Gizli anahtarı yedekle';

  @override
  String get openpgpDeleteKey => 'Anahtarı sil';

  @override
  String get openpgpRemoveKey => 'Anahtarı kaldır';

  @override
  String get openpgpBackUpTitle => 'Gizli anahtar yedeklensin mi?';

  @override
  String get openpgpBackUpProtected =>
      'Yedek, anahtarınızın parolasıyla korunur. İkisine birden sahip olan herkes e-postalarınızı okuyabilir.';

  @override
  String get openpgpBackUpUnprotected =>
      'Bu anahtarın parolası yok: yedeği eline geçiren herkes e-postalarınızı okuyabilir ve sizin adınıza imza atabilir.';

  @override
  String get openpgpBackUp => 'Yedekle';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return '$name anahtarınız silinsin mi?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return '$name kişisinin anahtarı kaldırılsın mı?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Anahtarı yeniden içe aktarmadığınız sürece, bu anahtar için şifrelenmiş e-postalar bu cihazda artık okunamaz.';

  @override
  String get openpgpRemoveKeyMessage => 'Daha sonra yeniden içe aktarabilirsiniz.';

  @override
  String get openpgpKeyHeader => 'OpenPGP anahtarı';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Bu adresten gönderilen e-postaları şifrelemek ve imzalamak için Uçtan uca şifreleme bölümünden bir anahtar ekleyin.';

  @override
  String get openpgpGenerateAKey => 'Anahtar oluştur…';

  @override
  String get openpgpSending => 'Gönderme';

  @override
  String get openpgpSendingFooter =>
      'Otomatik şifreleme, her alıcının kabul edilmiş bir anahtarı ya da güvenilir bir sertifikası olduğunda veya Autocrypt iki tarafın da bunu istediğini söylediğinde açılır. Şifreli e-postalar her zaman imzalanır.';

  @override
  String get openpgpEncryptAutomatically => 'Otomatik şifrele';

  @override
  String get openpgpAlwaysEncryptDetail => 'Bir alıcının anahtarı yoksa göndermeyi reddeder';

  @override
  String get openpgpSignUnencrypted => 'Şifresiz e-postaları imzala';

  @override
  String get openpgpAttachPublicKey => 'Açık anahtarımı ekle';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt, açık anahtarınızı her iletiyle birlikte gönderir; böylece diğer uygulamalar hiçbir ayar yapmadan size şifreli ileti gönderebilir.';

  @override
  String get openpgpSendMyKey => 'Anahtarımı e-postayla gönder';

  @override
  String get openpgpPreferEncryption => 'Şifrelemeyi tercih et';

  @override
  String get openpgpPreferEncryptionDetail => 'Başkalarından, mümkün olduğunda şifrelemelerini iste';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count yıl', one: '1 yıl');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Parolalar eşleşmiyor.';

  @override
  String openpgpKeyReady(String id) {
    return '$id anahtarınız hazır.';
  }

  @override
  String get openpgpNewKey => 'Yeni anahtar';

  @override
  String get openpgpNewKeyFor => 'Kimin için';

  @override
  String get openpgpYourName => 'Adınız';

  @override
  String get openpgpAddress => 'Adres';

  @override
  String get openpgpPassphrase => 'Parola';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'İsteğe bağlı. Parola yoksa anahtarı yalnızca telefonunuzun anahtar deposu korur ve Loupe hiçbir zaman sormaz. Parola varsa Loupe, anahtar gerektiğinde onu sorar.';

  @override
  String get openpgpRepeatPassphrase => 'Tekrar';

  @override
  String get openpgpExpires => 'Geçerlilik süresi';

  @override
  String get openpgpExpiresFooter =>
      'Süresi dolmadan yeni bir anahtar oluşturabilirsiniz. Thunderbird da üç yıl kullanır.';

  @override
  String get openpgpGenerateKey => 'Anahtar oluştur';

  @override
  String get openpgpKeyFor => 'Anahtarın adresi';

  @override
  String get openpgpCantEncrypt => 'Şifrelenemiyor';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return '$names için OpenPGP anahtarı yok ve bu adres her zaman şifreliyor. Alıcıyı kaldırın ya da anahtarını Ayarlar › Uçtan uca şifreleme bölümünden içe aktarın.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return '$names için geçerli bir S/MIME sertifikası yok ve bu adres her zaman şifreliyor. Alıcıyı kaldırın ya da sertifikasını Ayarlar › Uçtan uca şifreleme bölümünden içe aktarın.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return '$names için OpenPGP anahtarı yok.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return '$names için geçerli bir S/MIME sertifikası yok.';
  }

  @override
  String get openpgpSendUnencrypted => 'Şifrelemeden gönder';

  @override
  String get openpgpCantSign => 'İmzalanamıyor';

  @override
  String get openpgpCantSignMessage =>
      'S/MIME sertifikanızın özel anahtarı bu cihazda değil. Sertifikayı (.p12 veya .pfx dosyası) Ayarlar › Uçtan uca şifreleme bölümünden yeniden içe aktarın.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Anahtarı olmayanlar: $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Sertifikası olmayanlar: $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Autocrypt anahtarları';

  @override
  String get openpgpComposeEveryoneHasKey => 'Herkesin anahtarı var';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Herkesin sertifikası var';

  @override
  String get openpgpComposeEncrypt => 'Şifrele';

  @override
  String get openpgpComposeSign => 'İmzala';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, değiştir';
  }

  @override
  String get openpgpNoKeyFound => 'OpenPGP anahtarı bulunamadı.';

  @override
  String get openpgpImportSecretKeyTitle => 'Gizli anahtar içe aktarılsın mı?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Bu ek bir gizli anahtar ($names) içeriyor. Bunu yalnızca kendiniz dışa aktardıysanız (örneğin Thunderbird’den) kendi anahtarınız olarak içe aktarın.';
  }

  @override
  String get openpgpImportAsMyKey => 'Anahtarım olarak içe aktar';

  @override
  String openpgpImportedOwnKey(String name) {
    return '$name anahtarınız';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anahtar ($names) içe aktarılsın mı?',
      one: '$names kişisinin anahtarı içe aktarılsın mı?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'İçe aktar ve kabul et';

  @override
  String get openpgpImportDecideLater => 'İçe aktar, sonra karar ver';

  @override
  String openpgpImportedPublicKey(String name) {
    return '$name kişisinin anahtarı';
  }

  @override
  String openpgpImported(String keys) {
    return 'İçe aktarıldı: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count OpenPGP anahtarı ekli.',
      one: 'Bir OpenPGP anahtarı ekli.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'İçe aktar';

  @override
  String get openpgpUnlockKeyTitle => 'OpenPGP anahtarının kilidini aç';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return '$name kişisinin anahtarının ($id) parolasını girin.';
  }

  @override
  String get openpgpWrongPassphrase => 'Parola yanlış. Tekrar deneyin.';

  @override
  String get openpgpExplainLocked => 'Bu ileti şifreli. Okumak için OpenPGP anahtarınızın kilidini açın.';

  @override
  String get openpgpExplainNoKey =>
      'Bu ileti şifreli, ancak bu cihazdaki hiçbir OpenPGP anahtarı için şifrelenmemiş. İletiyi Thunderbird’de okuyorsanız anahtarınızı oradan içe aktarın: Ayarlar › Uçtan uca şifreleme.';

  @override
  String get openpgpExplainDamaged => 'Bu şifreli ileti hasarlı, bu yüzden şifresi güvenle çözülemiyor.';

  @override
  String get openpgpExplainUnsupported => 'Bu ileti, Loupe’un henüz okuyamadığı bir şifreleme kullanıyor.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Bu ileti S/MIME ile şifrelenmiş, ancak bu cihazdaki hiçbir sertifika için değil. Sertifikanızı (.p12 veya .pfx dosyası) Ayarlar › Uçtan uca şifreleme bölümünden içe aktarın.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Bu ileti şifreli. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Okumak için S/MIME sertifikanızın kilidini açın.';

  @override
  String get openpgpAttachmentGone => 'Bu ek artık kullanılamıyor.';

  @override
  String get smimeEncrypted => 'Şifreli (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Şifreli (S/MIME) · sertifika yok';

  @override
  String get smimeEncryptedDamaged => 'Şifreli (S/MIME) · hasarlı';

  @override
  String get smimeEncryptedUnsupported => 'Şifreli (S/MIME) · desteklenmiyor';

  @override
  String get smimeEncryptedLocked => 'Şifreli (S/MIME) · kilitli';

  @override
  String get smimeUnknownSigner => 'bilinmeyen';

  @override
  String get smimeSignatureModified => 'İmza geçersiz: ileti değiştirilmiş';

  @override
  String get smimeSignatureWeak => 'İmza güvensiz: eski algoritma';

  @override
  String get smimeSignatureUncheckable => 'İmza denetlenemiyor';

  @override
  String get smimeSignedCertificateMissing => 'İmzalı · sertifika eksik';

  @override
  String smimeSignedByRevoked(String name) {
    return 'İmzalayan: $name · sertifika iptal edilmiş';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'İmzalayan: $name · başka bir tarihte';
  }

  @override
  String smimeSignedBy(String name) {
    return 'İmzalayan: $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'İmzalayan: $name · geçersiz sertifika';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'İmzalayan: $name · güvenilmiyor';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'İmzalayan: $name · sertifikanın süresi dolmuş';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'İmzalayan: $name · sertifika henüz geçerli değil';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'İmzalayan: $name · sertifika e-posta için değil';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'İmzalayan: $name (gönderen değil)';
  }

  @override
  String get smimeCantDecrypt => 'Bu iletinin şifresi çözülemiyor';

  @override
  String get smimeEncryptedWithSmime => 'S/MIME ile şifrelenmiş';

  @override
  String get smimeEncryption => 'Şifreleme';

  @override
  String get smimeDecryptedHere => 'Şifresi bu cihazda çözüldü';

  @override
  String get smimeNotDecrypted => 'Şifresi çözülmedi';

  @override
  String get smimeAuthenticated => 'kimliği doğrulanmış';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifika için',
      one: '1 sertifika için',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'İmza';

  @override
  String get smimeIssuedBy => 'Veren';

  @override
  String get smimeValid => 'Geçerlilik';

  @override
  String smimeValidRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get smimeSha256Fingerprint => 'SHA-256 parmak izi';

  @override
  String get smimeSigned => 'İmzalanma';

  @override
  String get smimeProblem => 'Sorun';

  @override
  String get smimeCheckingRevocation => 'İptal durumu denetleniyor…';

  @override
  String get smimeNotRevoked => 'İptal edilmemiş';

  @override
  String get smimeRevoked => 'İptal edilmiş';

  @override
  String get smimeRevocationUnknown => 'İptal durumu bilinmiyor';

  @override
  String smimeRevokedSince(String date) {
    return '$date tarihinden beri';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Sertifika yetkilisine soruldu (iptal listesi), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Sertifika yetkilisine soruldu (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return '“$name” yetkilisine güven…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Bu sertifikaya güven…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Bu cihazda, Outlook ve Thunderbird ile uyumlu S/MIME ile denetlendi; iptal durumu sertifika yetkilisine soruldu.';

  @override
  String get smimeCheckedFooter =>
      'Bu cihazda, Outlook ve Thunderbird ile uyumlu S/MIME ile denetlendi. İptal durumu denetlenmiyor (Ayarlar › Uçtan uca şifreleme).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'E-posta için $name yetkilisine güvenilsin mi?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return '$name kişisinin sertifikasına güvenilsin mi?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Şirketinizin sertifika yetkilisi gibi, bu yetkilinin verdiği her sertifikaya güvenilecek. Önce parmak izini sahibiyle karşılaştırın:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Önce parmak izini sahibiyle karşılaştırın:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Güven';

  @override
  String get smimeSummaryNoKey => 'Bu cihazda olmayan bir sertifika için şifrelenmiş.';

  @override
  String get smimeSummaryDamaged => 'Şifreli veriler hasarlı ya da yolda değiştirilmiş.';

  @override
  String get smimeSummaryUnsupported => 'Loupe’un desteklemediği bir algoritma kullanıyor.';

  @override
  String get smimeSummaryLocked => 'S/MIME sertifikanız kilitli.';

  @override
  String get smimeSummaryEncrypted => 'Yalnızca siz ve diğer alıcılar okuyabilir.';

  @override
  String get smimeSummaryNotSigned => 'İmzalı değil, bu yüzden gönderen doğrulanmadı.';

  @override
  String get smimeSummaryModified => 'İmza eşleşmiyor: ileti imzalandıktan sonra değiştirilmiş.';

  @override
  String get smimeSummaryUncheckable => 'İmza denetlenemiyor.';

  @override
  String get smimeSummaryNoCertificate => 'İmzalayanın sertifikası iletide yok, bu yüzden denetlenemiyor.';

  @override
  String get smimeSummaryRevoked => 'Sertifika yetkilisi, imzalayanın sertifikasını iptal etmiş: imzaya güvenilemez.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Sertifika yetkilisi, imzalayanın sertifikasını iptal etmiş ($reason): imzaya güvenilemez.';
  }

  @override
  String get smimeDateMismatch =>
      'İleti, tarihinden bir saatten fazla farkla imzalanmış: yeniden gönderilmiş eski bir ileti olabilir.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'İmza geçerli ve $issuer, sertifikanın gönderene ait olduğunu onaylıyor.';
  }

  @override
  String get smimeProblemInvalidChain => 'Sertifika ya da onu verenlerden biri geçersiz.';

  @override
  String get smimeProblemUntrusted => 'Sertifika, Loupe’un güvenmediği bir yetkiliden geliyor.';

  @override
  String get smimeProblemExpired => 'Sertifikanın süresi dolmuştu.';

  @override
  String get smimeProblemNotYetValid => 'Sertifika henüz geçerli değildi.';

  @override
  String get smimeProblemWrongUsage => 'Sertifika e-posta için tasarlanmamış.';

  @override
  String get smimeProblemWrongAddress => 'Sertifika, gönderenin adresine değil, başka bir adrese ait.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Güvenilir · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Güvenilmiyor · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Süresi doldu: $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Geçerlilik başlangıcı: $date';
  }

  @override
  String get smimeTrustInvalid => 'Geçersiz';

  @override
  String get smimeTrustNotForMail => 'E-posta için değil';

  @override
  String get smimeTrustAnotherAddress => 'Başka bir adres';

  @override
  String get smimeMyCertificates => 'S/MIME sertifikalarım';

  @override
  String get smimeMyCertificatesFooter =>
      'Outlook ve birçok şirketin kullandığı S/MIME için. Sertifikanızı özel anahtarıyla birlikte (.p12 veya .pfx dosyası) Outlook, Windows, macOS ya da Thunderbird’den dışa aktarıp içe aktarın.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Outlook ve birçok şirketin kullandığı S/MIME için. Sertifikanızı özel anahtarıyla birlikte (.p12 veya .pfx dosyası) Outlook, Windows, macOS ya da Thunderbird’den dışa aktarıp içe aktarın veya şirketinizin ya da sizin bu cihaza yüklediğiniz bir sertifikayı kullanın.';

  @override
  String get smimeCertificateExpired => 'süresi doldu';

  @override
  String smimeCertificateUntil(String date) {
    return 'son geçerlilik: $date';
  }

  @override
  String get smimeCertificateOnDevice => 'bu cihazda';

  @override
  String get smimeImportCertificateEllipsis => 'Sertifika içe aktar…';

  @override
  String get smimeUseDeviceCertificate => 'Bu cihazdaki bir sertifikayı kullan…';

  @override
  String get smimeCorrespondentsCertificates => 'Yazıştığınız kişilerin sertifikaları';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Outlook ve Thunderbird’ün yaptığı gibi, imzalı e-postalardan toplanır. E-postalar yalnızca güvenilir sertifikalar için şifrelenir: Loupe, Mozilla’nın e-posta için güvendiği yetkililere ve sizin eklediklerinize güvenir.';

  @override
  String get smimeRevocation => 'İptal denetimi';

  @override
  String get smimeRevocationFooter =>
      'İmzalı bir e-postayı açtığınızda Loupe, imzalayanın sertifikasını veren yetkiliye sertifikanın iptal edilip edilmediğini sorar (OCSP yanıtlayıcısı ya da iptal listesi aracılığıyla). Yetkili böylece internet adresinizdeki birinin o sertifikayla imzalanmış bir e-postayı ne zaman okuduğunu görebilir. Yanıtlar, süreleri dolana kadar bu cihazda saklanır. İptal edilmiş bir sertifika, ileti başlığında “İptal edilmiş” olarak görünür.';

  @override
  String get smimeCheckRevocation => 'Sertifika iptalini çevrimiçi denetle';

  @override
  String get smimeTrustedAuthorities => 'Güvenilir yetkililer';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mozilla’nın e-posta için güvendiği $count yetkilinin yanı sıra sizin güvendikleriniz.',
      one: 'Mozilla’nın e-posta için güvendiği $count yetkilinin yanı sıra sizin güvendikleriniz.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Sertifika yetkilisi';

  @override
  String get smimeImportACertificate => 'Sertifika içe aktar';

  @override
  String get smimeImportContactMessage =>
      'Yazıştığınız bir kişinin sertifikası (.cer, .crt, .pem) ya da bir sertifika yetkilisinin sertifikası.';

  @override
  String get smimeFromClipboard => 'Panodan';

  @override
  String get smimeFromFile => 'Dosyadan';

  @override
  String get smimeClipboardEmpty => 'Pano boş. Önce sertifikayı kopyalayın.';

  @override
  String get smimeCertificate => 'Sertifika';

  @override
  String get smimeOnDeviceFooter =>
      'Özel anahtarı, şirketinizin ya da sizin yüklediğiniz Android kimlik bilgisi deposunda kalır: Loupe, onunla imzalamasını ve şifre çözmesini Android’den ister. İmzalı e-postalar gönderdiğiniz anda imzalanır.';

  @override
  String get smimeAddresses => 'Adresler';

  @override
  String get smimeUsage => 'Kullanım';

  @override
  String get smimeUsageNone => 'Loupe’un kullandığı bir şey yok';

  @override
  String get smimeUsageSigning => 'İmzalama';

  @override
  String get smimeUsageEncryption => 'Şifreleme';

  @override
  String get smimeUsageCertificates => 'Sertifikalar';

  @override
  String get smimeAlgorithm => 'Algoritma';

  @override
  String get smimeSerialNumber => 'Seri numarası';

  @override
  String get smimeFingerprintCopied => 'Parmak izi kopyalandı.';

  @override
  String get smimeSha1Thumbprint => 'SHA-1 parmak izi';

  @override
  String get smimePrivateKey => 'Özel anahtar';

  @override
  String get smimeKeyOnDevice => 'Bu cihazda';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Loupe’ta, parolayla';

  @override
  String get smimeKeyInLoupe => 'Loupe’ta';

  @override
  String get smimeSource => 'Kaynak';

  @override
  String get smimeSourceSignedMail => 'İmzalı e-posta';

  @override
  String get smimeSourceImported => 'İçe aktarıldı';

  @override
  String get smimeTrustHeader => 'Güven';

  @override
  String get smimeTrustedRoot => 'Güvenilir kök';

  @override
  String get smimeIssuer => 'Veren';

  @override
  String smimeTrustNamed(String name) {
    return '“$name” yetkilisine güven';
  }

  @override
  String get smimeTrustThisAuthority => 'Bu yetkiliye güven';

  @override
  String get smimeTrustThisCertificate => 'Bu sertifikaya güven';

  @override
  String get smimeStopTrusting => 'Güvenmeyi bırak';

  @override
  String get smimePassphrase => 'Parola';

  @override
  String get smimePassphraseFooter =>
      'İsteğe bağlı. Parolayla özel anahtar bu cihazda ayrıca şifrelenir (Argon2id ve AES-256) ve Loupe imzalamak ve şifre çözmek için parolayı sorar; ne kadar süre hatırlanacağını Parolaları hatırla belirler. Gönderdiğiniz e-postalar gönderim anında imzalanır; arka plan işleri anahtarı kullanamaz.';

  @override
  String get smimeChangePassphrase => 'Parolayı değiştir…';

  @override
  String get smimeSetPassphraseEllipsis => 'Parola belirle…';

  @override
  String get smimeRemovePassphrase => 'Parolayı kaldır';

  @override
  String get smimeShareCertificate => 'Sertifikayı paylaş';

  @override
  String get smimeDeleteCertificate => 'Sertifikayı sil';

  @override
  String get smimeRemoveCertificate => 'Sertifikayı kaldır';

  @override
  String get smimePassphraseChanged => 'Parola değiştirildi.';

  @override
  String get smimePassphraseSet => 'Parola belirlendi.';

  @override
  String get smimeRemovePassphraseTitle => 'Parola kaldırılsın mı?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Bu durumda özel anahtarı, parola yokmuş gibi yalnızca anahtar deposu korur: Loupe artık parola sormaz ve arka plan işleri anahtarı kullanabilir.';

  @override
  String get smimePassphraseRemoved => 'Parola kaldırıldı.';

  @override
  String smimeTrustTitle(String name) {
    return '$name yetkilisine güvenilsin mi?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Verdiği her sertifikaya e-posta için güvenilecek. Önce parmak izini sahibiyle karşılaştırın:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return '$name sertifikanız silinsin mi?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return '$name kişisinin sertifikası kaldırılsın mı?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe onu kullanmayı bırakır: onun için şifrelenmiş e-postalar artık Loupe’ta okunamaz. Sertifika bu cihazda kalır (Ayarlar › Güvenlik › Şifreleme ve kimlik bilgileri).';

  @override
  String get smimeDeleteOwnMessage =>
      'Özel anahtarı bu cihazdan silinir: yeniden içe aktarmadığınız sürece, onun için şifrelenmiş e-postalar burada artık okunamaz.';

  @override
  String get smimeRemoveContactMessage => 'Kişinin bir sonraki imzalı iletisiyle geri gelir.';

  @override
  String get smimeAddressImportFooter =>
      'Outlook’taki gibi S/MIME ile imzalamak ve şifrelemek için bu adrese bir sertifika içe aktarın.';

  @override
  String get smimeImportACertificateEllipsis => 'Sertifika içe aktar…';

  @override
  String get smimePreferFooter =>
      'İkisi de bir iletiyi koruyabildiğinde tercih edilen kullanılır; yalnızca diğerinin her alıcı için anahtarı veya sertifikası varsa o kullanılır.';

  @override
  String get smimePreferSmime => 'S/MIME’ı tercih et';

  @override
  String get smimePreferSmimeDetail => 'OpenPGP yerine';

  @override
  String get smimeCertificatePassword => 'Sertifika parolası';

  @override
  String get smimeCertificatePasswordPrompt => 'Sertifika dosyası dışa aktarılırken kullanılan parolayı girin.';

  @override
  String get smimeImport => 'İçe aktar';

  @override
  String get smimeWrongPassword => 'Parola yanlış. Tekrar deneyin.';

  @override
  String get smimeNoCertificateFound => 'Sertifika bulunamadı.';

  @override
  String smimeCertificateOf(String name) {
    return '$name kişisinin sertifikası';
  }

  @override
  String get smimeNothingNew => 'İçe aktarılacak yeni bir şey yok.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'İçe aktarıldı: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count güvenilir yetkili içe aktarıldı.',
      one: 'Bir güvenilir yetkili içe aktarıldı.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'İçe aktarıldı: $certificates ve $count güvenilir yetkili.',
      one: 'İçe aktarıldı: $certificates ve bir güvenilir yetkili.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey => 'Bu dosyada özel anahtar yok. Sertifikanızı özel anahtarıyla birlikte dışa aktarın.';

  @override
  String get smimeImportAsYoursTitle => 'Sertifikanız olarak içe aktarılsın mı?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Bu ek, özel anahtarıyla birlikte bir sertifika içeriyor: $names. Bunu yalnızca kendiniz dışa aktardıysanız (örneğin Outlook ya da Thunderbird’den) içe aktarın.';
  }

  @override
  String get smimeImportAsMine => 'Sertifikam olarak içe aktar';

  @override
  String smimeImportedOwn(String names) {
    return '$names sertifikanız içe aktarıldı.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return '$name ($addresses) sertifikanız bu cihazdan eklendi.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'E-posta için “$name” yetkilisine güvenilsin mi?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe bu sertifika yetkilisini tanımıyor (belki bir şirketin kendi yetkilisidir). Verdiği sertifikaları denetlemek için ona güvenin. Önce parmak izini BT bölümünüzle karşılaştırın:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sertifika ekli.',
      one: 'Bir sertifika ekli.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Sertifikayı içe aktar';

  @override
  String get smimeUnlockTitle => 'S/MIME sertifikasının kilidini aç';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return '$name kişisinin sertifikasının ($addresses) parolasını girin.';
  }

  @override
  String get smimeWrongPassphrase => 'Parola yanlış. Tekrar deneyin.';

  @override
  String get smimeUnlock => 'Kilidi aç';

  @override
  String get smimeEnterAPassphrase => 'Bir parola girin.';

  @override
  String get smimePassphrasesDiffer => 'İki parola farklı.';

  @override
  String get smimeSetPassphraseTitle => 'Parola belirle';

  @override
  String get smimeSetPassphraseText =>
      'Loupe imzalamak ve şifre çözmek için bu parolayı soracak. Unutursanız sertifikayı .p12 dosyasından yeniden içe aktarın.';

  @override
  String get smimePassphraseAgain => 'Tekrar';

  @override
  String get smimeSetPassphraseButton => 'Belirle';

  @override
  String get smimeLockedOpenAgain => 'S/MIME sertifikanız kilitli. Kilidini açmak için iletiyi yeniden açın.';

  @override
  String get smimeDeviceHasNoCertificates => 'Bu cihaz sertifikalarını sunmuyor.';

  @override
  String get smimeCantReadCertificate => 'Loupe bu sertifikayı okuyamıyor.';

  @override
  String get smimeCertificateNotForMail =>
      'Bu sertifika e-posta için değil: e-posta adresi yok ya da imzalama veya şifreleme için tasarlanmamış.';

  @override
  String get smimeDeviceCertificateGone =>
      'Sertifika artık bu cihazda değil ya da Loupe artık onu kullanamıyor olabilir. Ayarlar › Uçtan uca şifreleme bölümünden yeniden seçin.';

  @override
  String get smimeDeviceCertificateAppOnly => 'Bu cihazdaki sertifika yalnızca Loupe açıkken kullanılabilir.';

  @override
  String get smimeDeviceKeyDamaged => 'Şifreli anahtar hasarlı.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Bu cihazdaki sertifika bunu yapamıyor: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'desteklenmiyor';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Bu cihazdaki sertifika başarısız oldu: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Yetkilinin adresi bir web adresi değil.';

  @override
  String get smimeAuthorityTimeout => 'Sertifika yetkilisi zamanında yanıt vermedi.';

  @override
  String get smimeAuthorityUnreachable => 'Sertifika yetkilisine ulaşılamadı.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Sertifika yetkilisi $status yanıtını verdi.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Sertifika yetkilisinin yanıtı çok büyük.';

  @override
  String get smimeRevocationNotChecked =>
      'Denetlenmedi: yalnızca Loupe’un güvendiği bir yetkilinin sertifikaları denetlenir.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Telefonla aynı';

  @override
  String get settingsLanguageFooter =>
      'Loupe, telefonunuzun dili varsa onu, yoksa İngilizceyi kullanır. Burada seçtiğiniz dil, bildirimler dahil yalnızca Loupe içindir.';

  @override
  String get settingsAccountsHeader => 'Hesaplar';

  @override
  String get settingsAddAccount => 'Hesap ekle';

  @override
  String get settingsMailHeader => 'E-posta';

  @override
  String get settingsSwipeActions => 'Kaydırma işlemleri';

  @override
  String get settingsSwipeLeft => 'Sola kaydırma';

  @override
  String get settingsSwipeLeftFooter =>
      'Sonuna kadar kaydırmak bu işlemi çalıştırır. Bayrak koy ve Diğer her zaman kısa bir kaydırma uzaklığındadır.';

  @override
  String get settingsSwipeRight => 'Sağa kaydırma';

  @override
  String get settingsSwipeRightFooter => 'Sonuna kadar kaydırmak bu işlemi çalıştırır.';

  @override
  String get settingsSwipeToggleRead => 'Okundu / okunmadı olarak işaretle';

  @override
  String get settingsSwipeTrash => 'Çöpe at';

  @override
  String get settingsSwipeMove => 'İletiyi taşı';

  @override
  String get settingsSwipeSnooze => 'Ertele';

  @override
  String get settingsThreaded => 'Yazışmalara göre düzenle';

  @override
  String get settingsUndoSendDelay => 'Gönderimi geri alma süresi';

  @override
  String get settingsUndoSendDelayFooter => 'Gönderilen iletiler bu kadar bekler; böylece onları geri alabilirsiniz.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds saniye', one: '1 saniye');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Görünüm';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Otomatik';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsDensity => 'İleti listesi';

  @override
  String get settingsDensityComfortable => 'Ferah';

  @override
  String get settingsDensityCompact => 'Sıkışık';

  @override
  String get settingsReadingHeader => 'Okuma';

  @override
  String get settingsReadingFooter =>
      'Uzak görseller, bir iletiyi ne zaman ve nerede açtığınızı gönderene bildirebilir.';

  @override
  String get settingsDefaultView => 'Varsayılan görünüm';

  @override
  String get settingsDefaultViewFooter => 'Her iletinin görünümünü Aa düğmesiyle değiştirebilirsiniz.';

  @override
  String get settingsViewReadable => 'Okunaklı';

  @override
  String get settingsViewReadableDetail => 'Sade, okunaklı, koyu moda uyar';

  @override
  String get settingsViewOriginal => 'Orijinal';

  @override
  String get settingsViewOriginalDetail => 'Tam olarak gönderenin tasarladığı gibi';

  @override
  String get settingsViewPlain => 'Düz metin';

  @override
  String get settingsViewPlainDetail => 'Yalnızca sözcükler';

  @override
  String get settingsPlainTextFont => 'Düz metin yazı tipi';

  @override
  String get settingsFontSans => 'Sans serif';

  @override
  String get settingsFontMono => 'Eş aralıklı';

  @override
  String get settingsFontMonoDetail => 'ASCII çizimleri ve tabloları hizalı tutar';

  @override
  String get settingsTechnicalLists => 'Teknik listeler';

  @override
  String get settingsLoadRemoteImages => 'Uzak görselleri yükle';

  @override
  String get settingsOpenLinksDirectly => 'Bağlantıları doğrudan aç';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Hedef biliniyorsa tıklama izleyicilerini atla';

  @override
  String get settingsSecurityHeader => 'Güvenlik';

  @override
  String get settingsAppLock => 'Uygulama Kilidi';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe, açılırken ve Kilitleme süresi kadar uzak kaldıktan sonra geri döndüğünüzde sorar.';

  @override
  String get settingsAppLockFooterOff =>
      'Uygulama Kilidi, e-postalarınız görünmeden önce parmak izinizi, yüzünüzü veya ekran kilidinizi ister.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Uygulama Kilidi hâlâ kapalı. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Parola ayarlayın';

  @override
  String get settingsScreenLockTextIos =>
      'Uygulama Kilidi Face ID, Touch ID veya parolanızı kullanır ve bu iPhone’da parola yok. Ayarlar uygulamasında bir parola ayarlayın, ardından Uygulama Kilidi’ni açın.';

  @override
  String get settingsScreenLockTitleAndroid => 'Ekran kilidi ayarlayın';

  @override
  String get settingsScreenLockTextAndroid =>
      'Uygulama Kilidi, telefonunuzun ekran kilidini ya da ona eklenmiş bir parmak izini veya yüzü kullanır ve bu telefonda ekran kilidi yok. Android ayarlarında bir PIN, desen veya şifre ayarlayın, ardından Uygulama Kilidi’ni açın.';

  @override
  String get settingsOpenSystemSettings => 'Ayarları aç';

  @override
  String get settingsOpenAndroidSettings => 'Android ayarlarını aç';

  @override
  String get settingsLockAfter => 'Kilitleme süresi';

  @override
  String get settingsLockAfterFooter => 'Loupe’un yeniden sormadan önce arka planda ne kadar kalabileceği.';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsEncryption => 'Uçtan uca şifreleme';

  @override
  String get settingsAdvanced => 'Gelişmiş';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Demo e-postalar, yalnızca bu telefonda bulunan uydurma bir posta kutusudur. Hiçbir yere bir şey gönderilmez.';

  @override
  String get settingsDemoMode => 'Demo modu';

  @override
  String get settingsResetApp => 'Uygulamayı sıfırla';

  @override
  String get settingsResetFooter => 'Tüm ayarları unutur ve karşılama ekranına döner.';

  @override
  String get settingsResetTitle => 'Loupe sıfırlansın mı?';

  @override
  String get settingsResetMessage =>
      'Bu işlem tüm ayarları, Smart Mailbox’ları ve son aramaları unutur ve karşılama ekranına döner.';

  @override
  String get settingsAboutHeader => 'Hakkında';

  @override
  String get settingsVersion => 'Sürüm';

  @override
  String get settingsLicences => 'Lisanslar';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsPrivacyDetail =>
      'Loupe’ta analiz ve izleme yok. E-postalarınız yalnızca e-posta sunucularınıza gider.';

  @override
  String get settingsNotificationsOffIos => 'Ayarlar’da Loupe için bildirimler kapalı.';

  @override
  String get settingsNotificationsOffAndroid => 'Android Ayarları’nda Loupe için bildirimler kapalı.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system, Loupe’un bildirim göstermesine izin vermiyor. Ayarlar’dan izin verin.';
  }

  @override
  String get settingsNewMailHeader => 'Yeni e-posta';

  @override
  String get settingsNewMailFooterDemo =>
      'Demo e-postalar arka planda gelmez. Yeni e-postaların nasıl göründüğünü görmek için bir test bildirimi gönderin.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe, iOS izin verdiğinde arka planda yeni e-postaları denetler; sık açmadığınız uygulamalarda bu, saatler arayla olabilir. Gelen kutularınızdaki yeni iletiler ve herhangi bir klasördeki VIP iletileri size bildirilir.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe, Android izin verdiğinde yaklaşık 15 dakikada bir yeni e-postaları denetler. Gelen kutularınızdaki yeni iletiler ve herhangi bir klasördeki VIP iletileri size bildirilir.';

  @override
  String get settingsNoAccounts => 'Hesap yok';

  @override
  String get settingsVipOnly => 'Yalnızca VIP';

  @override
  String get settingsVipOnlyDetail => 'Yalnızca VIP’lerinizden gelen iletiler';

  @override
  String get settingsHideContent => 'İçeriği gizle';

  @override
  String get settingsHideContentFooterOn =>
      'Bildirimler kimin ne hakkında yazdığını değil, yalnızca “Yeni ileti” ve hesabı gösterir.';

  @override
  String get settingsHideContentFooterOff =>
      'İçeriği gizle, göndereni, konuyu ve önizlemeyi kilit ekranından ve bildirimlerden uzak tutar.';

  @override
  String get settingsBackgroundAppRefresh => 'Arka Planda Uygulama Yenileme';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Yeni e-postalar, yalnızca Ayarlar’da Loupe için Arka Planda Uygulama Yenileme açıkken arka planda gelir. iOS gelen kutularınıza bağlantıyı açık tutamaz, bu yüzden Anında teslim yok.';

  @override
  String get settingsInstantDelivery => 'Anında teslim';

  @override
  String get settingsInstantDeliveryFooter =>
      'Anında teslim (deneysel), gelen kutularınıza bağlantıyı açık tutar; böylece yeni e-postalar saniyeler içinde gelir. Sessiz bir “Yeni e-postalar bekleniyor” bildirimi gösterir ve daha fazla pil kullanır.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android, pil tasarrufu için Anında teslimi durdurabilir. Çalışmaya devam etmesi için Loupe’un pili kısıtlama olmadan kullanmasına izin verin.';

  @override
  String get settingsExperimental => 'Deneysel';

  @override
  String get settingsComingSoon => 'Yakında';

  @override
  String get settingsAllowUnrestrictedBattery => 'Kısıtlamasız pil kullanımına izin ver';

  @override
  String get settingsPush => 'Anlık bildirim';

  @override
  String get settingsPushFooter =>
      'Anlık bildirim, e-posta hizmetiniz destekliyorsa yeni e-postaların Loupe’u hemen uyandırmasını sağlar. Anlık bildirimler Google’ın anlık bildirim hizmeti üzerinden gider ve e-posta taşımaz, yalnızca “şimdi denetle” der.';

  @override
  String get settingsPushUnavailableFooter =>
      'Bu telefon anlık bildirim alamıyor: bunun için Google Play hizmetleri ve bir ağ bağlantısı gerekir. Loupe yine de yaklaşık 15 dakikada bir yeni e-postaları denetler.';

  @override
  String get settingsCopyPushToken => 'Anlık bildirim belirtecini kopyala';

  @override
  String get settingsPushTokenCopied => 'Anlık bildirim belirteci kopyalandı';

  @override
  String get settingsSendTestNotification => 'Test bildirimi gönder';

  @override
  String get settingsAppIconBadge => 'Uygulama simgesi rozeti';

  @override
  String get settingsBadgeNote => 'Rozet, Loupe her e-posta denetlediğinde güncellenir; arka planda da.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Bu telefonun ana ekranı uygulama simgelerinde sayı göstermiyor. Rozet, Loupe her e-posta denetlediğinde güncellenir; arka planda da.';

  @override
  String get settingsTestNotificationBody => 'Yeni e-posta bildirimleri böyle görünür.';

  @override
  String get settingsAccountRemoved => 'Bu hesap kaldırıldı.';

  @override
  String get settingsAccountHeader => 'Hesap';

  @override
  String get settingsAccountDescription => 'Açıklama';

  @override
  String get settingsAccountDescriptionHint => 'İş, Kişisel…';

  @override
  String get settingsEmail => 'E-posta';

  @override
  String get settingsColour => 'Renk';

  @override
  String get settingsColourFooter => 'Bu hesabın iletilerini Tüm Gelen Kutuları’nda işaretler.';

  @override
  String settingsColourNumber(int number) {
    return 'Renk $number';
  }

  @override
  String get settingsSendingHeader => 'Gönderme';

  @override
  String get settingsSendingFooter =>
      'Her kimliğin kendi imzası vardır. Yanıtlar, iletinin gönderildiği adresten gider.';

  @override
  String get settingsFoldersHeader => 'Klasörler';

  @override
  String get settingsFoldersFooter =>
      'Loupe, Thunderbird gibi abone olduğunuz klasörleri gösterir ve eşitler. Gelen Kutusu, Taslaklar, Gönderilmiş, Gereksiz, Çöp Kutusu ve Arşiv her zaman görünür.';

  @override
  String get settingsShowAllFolders => 'Tüm klasörleri göster';

  @override
  String get settingsIncoming => 'Gelen';

  @override
  String get settingsOutgoing => 'Giden';

  @override
  String get settingsConnectionNotEncrypted => 'Şifrelenmemiş';

  @override
  String get settingsSignIn => 'Oturum açma';

  @override
  String get settingsSignInExpired => 'Süresi doldu';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider artık bu hesap için Loupe’un oturum açmasını kabul etmiyor, bu yüzden e-postaları eşitlenmiyor. Düzeltmek için yeniden oturum açın.';
  }

  @override
  String get settingsSignInAgain => 'Yeniden oturum aç';

  @override
  String get settingsSigningIn => 'Oturum açılıyor…';

  @override
  String get settingsRemoveAccount => 'Hesabı kaldır';

  @override
  String settingsRemoveAccountTitle(String account) {
    return '“$account” kaldırılsın mı?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'E-postaları ve ayarları bu telefondan kaldırılır. Sunucuda hiçbir şey silinmez.';

  @override
  String get settingsManageFolders => 'Klasörleri yönet';

  @override
  String get settingsNoFolders => 'Henüz klasör yok.';

  @override
  String get settingsManageFoldersFooter =>
      'Abone olunan klasörler Posta kutuları ekranında görünür ve arka planda eşitlenir. Aynı hesaptaki diğer e-posta uygulamaları da genellikle bu abonelikleri izler.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Smart Mailbox’larınızı diğer cihazlarınız için saklar. Posta kutuları ekranında gizlidir.';

  @override
  String get settingsFolderAlwaysShown => 'Her zaman gösterilir';

  @override
  String settingsSubscribeToFolder(String folder) {
    return '$folder klasörüne abone ol';
  }

  @override
  String get settingsIdentities => 'Kimlikler';

  @override
  String get settingsIdentitiesFooterReorder =>
      'İlk kimlik, yeni iletiler için varsayılandır. Sırayı değiştirmek için sürükleyin.';

  @override
  String get settingsIdentitiesFooterSingle => 'Yeni iletiler için varsayılan kimlik.';

  @override
  String get settingsIdentitiesReplyFooter => 'Yanıt, iletinin gönderildiği kimlikten gider.';

  @override
  String get settingsIdentityDefault => 'Varsayılan';

  @override
  String settingsIdentityReorder(String email) {
    return '$email sırasını değiştir';
  }

  @override
  String get settingsAddIdentity => 'Kimlik ekle';

  @override
  String get settingsNewIdentity => 'Yeni kimlik';

  @override
  String get settingsIdentity => 'Kimlik';

  @override
  String get settingsIdentityNameHint => 'Adınız';

  @override
  String get settingsReplyTo => 'Yanıt adresi';

  @override
  String get settingsSignature => 'İmza';

  @override
  String get settingsSignatureFooter => 'Bu kimlikten gönderilen iletilerde “-- ” satırının altına eklenir.';

  @override
  String get settingsNoSignature => 'İmza yok';

  @override
  String get settingsCopyToMyself => 'Kendime kopya';

  @override
  String get settingsCopyToMyselfFooter => 'Bu kimlikten gönderilen her iletiye eklenir.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Şunlara yanıtlarda kullan';

  @override
  String get settingsReplyPatternsFooter =>
      'Bu adreslere gönderilmiş iletilere verilen yanıtlar bu kimlikten gider. * her şeyin yerini tutar: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Bir adres ya da * işaretinin her şeyin yerini tuttuğu bir kalıp.';

  @override
  String get settingsAddReplyPattern => 'Adres veya kalıp ekle';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return '$pattern öğesini kaldır';
  }

  @override
  String get settingsInvalidPatternTitle => 'Geçersiz kalıp';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” bir adres ya da *@example.com gibi bir kalıp değil.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Adres yok';

  @override
  String get settingsIdentityNoAddressMessage => 'Gönderimde kullanılacak e-posta adresini girin.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Geçersiz adres';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Yanıt adresi “$address” geçerli bir e-posta adresi değil.',
      'cc': 'Cc “$address” geçerli bir e-posta adresi değil.',
      'bcc': 'Bcc “$address” geçerli bir e-posta adresi değil.',
      'other': '“$address” geçerli bir e-posta adresi değil.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Kimliği kaydet';

  @override
  String get settingsDiscardChanges => 'Değişiklikleri at';

  @override
  String get settingsDeleteIdentity => 'Kimliği sil';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return '“$email” silinsin mi?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Bu kimlikten önceden gönderilmiş iletiler olduğu gibi kalır.';

  @override
  String get settingsLastIdentityFooter => 'Bir hesabın en az bir kimliği olmalıdır.';

  @override
  String get rulesTitle => 'Kurallar';

  @override
  String get rulesNewRule => 'Yeni kural';

  @override
  String get rulesLoadError => 'Kurallar yüklenemedi.';

  @override
  String get rulesEmptyTitle => 'Kural yok';

  @override
  String get rulesEmptyText =>
      'Kurallar yeni e-postaları sizin için dosyalar, etiketler ve bayraklar. Yukarıdaki oluştur düğmesiyle ya da bir aramadan “Bunu kural yap” ile bir kural oluşturun.';

  @override
  String get rulesListFooter =>
      'Kurallar, Gelen Kutusu’na gelen yeni e-postalarda yukarıdan aşağıya çalışır. Bir kuralı taşımak için ona dokunup basılı tutun.';

  @override
  String get rulesChangeError => 'Kural değiştirilemedi';

  @override
  String get rulesConditionEveryMessage => 'Her ileti';

  @override
  String rulesMoveRule(String rule) {
    return '$rule kuralını taşı';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule açık';
  }

  @override
  String get rulesServerRulesHeader => 'Sunucu kuralları';

  @override
  String get rulesServerRulesFooter =>
      'Sunucu kuralları, e-postalar gelirken e-posta sunucusunda çalışır; bu telefon kapalıyken de. “loupe” adlı bir Sieve betiğinde saklanırlar.';

  @override
  String get rulesStatusUnknown => 'Bilinmiyor';

  @override
  String get rulesStatusError => 'Sunucuya sorulamadı.';

  @override
  String get rulesStatusChecking => 'Denetleniyor…';

  @override
  String rulesStatusViaInclude(String script) {
    return '“$script” üzerinden çalışıyor.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Etkin betik “$script”. Loupe’un kurallarını da çalıştırmasına izin vermek için dokunun.';
  }

  @override
  String get rulesStatusNoScript =>
      'Sunucuda etkin betik yok. Bir sunucu kuralı kaydetmek Loupe’un betiğini etkinleştirir.';

  @override
  String get rulesStatusUnavailable => 'Kullanılamıyor';

  @override
  String get rulesStatusNoSieve => 'Bu hesabın sunucusu Sieve sunmuyor (ManageSieve veya JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Taşı: $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Bir klasöre taşı';

  @override
  String rulesActionTag(String tag) {
    return 'Etiketle: $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Etiketi kaldır: $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Gelen Kutusu’nda tut';

  @override
  String rulesActionForward(String address) {
    return 'İlet: $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'İlet: $address, kopya tutma';
  }

  @override
  String get rulesActionStop => 'Dur';

  @override
  String get rulesNoActions => 'Henüz bir şey yapmıyor';

  @override
  String get rulesLocationDevice => 'Cihaz';

  @override
  String get rulesLocationServer => 'Sunucu';

  @override
  String get rulesLocationThisDevice => 'Bu cihaz';

  @override
  String get rulesNewRuleTitle => 'Yeni kural';

  @override
  String get rulesEditRuleTitle => 'Kuralı düzenle';

  @override
  String get rulesDefaultNameEveryMessage => 'Her ileti';

  @override
  String get rulesConditionHeader => 'Yeni bir ileti şununla eşleştiğinde';

  @override
  String get rulesConditionFooter =>
      'Arama yapar gibi yazın: from:, to:, s: (konu), b: (gövde), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:fatura';

  @override
  String get rulesAccounts => 'Hesaplar';

  @override
  String get rulesAllAccounts => 'Tüm hesaplar';

  @override
  String get rulesRemovedAccount => 'Kaldırılmış hesap';

  @override
  String get rulesAccountsFooter => 'Tüm hesaplar için bir kural, sonradan eklediğiniz hesapları da kapsar.';

  @override
  String get rulesActionsHeader => 'O zaman';

  @override
  String get rulesForwardingFooter =>
      'Yönlendirme, eşleşen her iletiyi geldiği anda başka bir adrese gönderir; bu telefon kapalıyken de. Bazı sağlayıcılar ne kadar e-posta yönlendirilebileceğini sınırlar.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Yönlendirme yalnızca sunucu kurallarında çalışır, bu yüzden burada yer almıyor.';

  @override
  String rulesRemoveAction(String action) {
    return '$action işlemini kaldır';
  }

  @override
  String get rulesAddAction => 'İşlem ekle';

  @override
  String get rulesAddMove => 'Klasöre taşı…';

  @override
  String get rulesAddTagMenu => 'Etiket ekle…';

  @override
  String get rulesRemoveTagMenu => 'Etiketi kaldır…';

  @override
  String get rulesAddForward => 'Şuraya ilet…';

  @override
  String get rulesStopProcessing => 'Diğer kuralları işlemeyi durdur';

  @override
  String get rulesRunOnHeader => 'Çalıştığı yer';

  @override
  String get rulesRunOnDeviceFooter =>
      'Bu cihaz, Loupe her e-posta denetlediğinde kuralı Gelen Kutusu’ndaki yeni e-postalarda çalıştırır.';

  @override
  String get rulesRunOnServerFooter =>
      'E-posta sunucusu kuralı e-postalar gelirken çalıştırır; bu telefon kapalıyken de. ManageSieve (Dovecot, mailcow) veya JMAP (Stalwart) üzerinden Sieve gerektirir.';

  @override
  String get rulesApplyToExisting => 'Mevcut iletilere uygula…';

  @override
  String get rulesDeleteRule => 'Kuralı sil';

  @override
  String rulesDeleteTitle(String rule) {
    return '“$rule” silinsin mi?';
  }

  @override
  String get rulesMoveAccountTitle => 'Hangi hesaptaki klasör?';

  @override
  String get rulesMoveAccountMessage => 'Diğer hesapların e-postaları, oradaki aynı adlı klasöre gider.';

  @override
  String get rulesAddTag => 'Etiket ekle';

  @override
  String get rulesRemoveTag => 'Etiketi kaldır';

  @override
  String get rulesForwardTo => 'Şuraya ilet';

  @override
  String get rulesForwardToMessage =>
      'Sunucu, eşleşen her iletiyi bu adrese iletir; bu telefon kapalıyken de. Size ait ya da güvendiğiniz bir adres kullanın.';

  @override
  String get rulesNotAnAddressTitle => 'E-posta adresi değil';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address”, iletilebilecek bir adres değil.';
  }

  @override
  String get rulesKeepCopyTitle => 'Burada bir kopya tutulsun mu?';

  @override
  String get rulesKeepCopy => 'Kopya tut';

  @override
  String get rulesDontKeepCopy => 'Kopya tutma';

  @override
  String get rulesCheckCondition => 'Koşulu kontrol edin';

  @override
  String get rulesChooseActionTitle => 'Bir işlem seçin';

  @override
  String get rulesChooseActionMessage => 'Kuralın eşleştiği iletilerle ne yapacağını ekleyin.';

  @override
  String get rulesSaveError => 'Kural kaydedilemedi';

  @override
  String get rulesSaveServerError => 'Sunucu kuralı kaydedilemedi';

  @override
  String get rulesRunOnDeviceInstead => 'Bunun yerine bu cihazda çalıştır';

  @override
  String get rulesNothingToApplyTitle => 'Uygulanacak bir şey yok';

  @override
  String get rulesNothingToApplyMessage => 'Önce kurala çalışan bir koşul ve bir işlem verin.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return '“$rule” kuralını şuradaki iletilere uygula…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Gelen kutuları';

  @override
  String get rulesApplyScopeAll => 'Tüm posta kutuları';

  @override
  String get rulesFindingMessages => 'İletiler bulunuyor…';

  @override
  String get rulesSearchError => 'Arama yapılamadı';

  @override
  String get rulesSearchErrorUnknown => 'Bir sorun oluştu.';

  @override
  String get rulesNoMatchesTitle => 'Eşleşen ileti yok';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Orada “$condition” ile eşleşen bir şey yok.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“$rule” $countString iletiye uygulansın mı?',
      one: '“$rule” $countString iletiye uygulansın mı?',
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
      other: '$countString iletiye uygula',
      one: '$countString iletiye uygula',
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
      other: '“$rule” $countString iletiye uygulandı',
      one: '“$rule” $countString iletiye uygulandı',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Sunucuya neler yapabildiği soruluyor…';

  @override
  String get rulesServerUnreachable => 'Sunucuya ulaşılamadı.';

  @override
  String rulesServerProblem(String problem) {
    return 'Sunucuda çalışamaz: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return '$account hesabının sunucusunda çalışamaz: $problem';
  }

  @override
  String get rulesShowScript => 'Betiği göster';

  @override
  String get rulesHideScript => 'Betiği gizle';

  @override
  String get rulesMatchingHeader => 'Eşleşen iletiler';

  @override
  String get rulesMatchingHeaderLoading => 'Eşleşen iletiler…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString eşleşen ileti',
      one: '$countString eşleşen ileti',
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
      other: '$countString+ eşleşen ileti',
      one: '$countString+ eşleşen ileti',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Son 30 günden. Kuralın kendisi, mevcut iletilere uygulamadığınız sürece yalnızca yeni e-postalara uygulanır.';

  @override
  String rulesConditionError(String error) {
    return 'Koşulda bir hata var: $error';
  }

  @override
  String get rulesPreviewNoSender => '(gönderen yok)';

  @override
  String get rulesPreviewNoSubject => '(konu yok)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 've $countString tane daha',
      one: 've $countString tane daha',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Son 30 günden bir şey yok.';

  @override
  String get rulesIncludeTitle => 'Sunucu kurallarını aç';

  @override
  String get rulesIncludeLeaveOff => 'Kapalı bırak';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Sunucu, $account için Loupe’un kurallarını zaten çalıştırıyor.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script”, $account hesabının sunucusundaki etkin betik; bu yüzden sunucu Loupe’un kurallarını değil, onu çalıştırıyor. Loupe onun yerine geçmez. Ona şu satırları ekleyebilir; ardından sunucu Loupe’un kurallarını betiğin kendi kurallarından sonra çalıştırır:';
  }

  @override
  String get rulesShowWholeScript => 'Betiğin tamamını göster';

  @override
  String get rulesHideWholeScript => 'Betiğin tamamını gizle';

  @override
  String rulesIncludeFootnote(String script) {
    return '“$script” içinde başka hiçbir şey değişmez. Filtreleri daha sonra web postasında düzenlenirse, web postası betiği bu satırlar olmadan yeniden yazabilir; Loupe da sunucu kurallarını yeniden kapalı gösterir.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return '“$script” betiğine ekle';
  }

  @override
  String get subscriptionsTitle => 'Abonelikler';

  @override
  String get subscriptionsNewsletters => 'Bültenler';

  @override
  String get subscriptionsDiscussions => 'Tartışmalar';

  @override
  String get subscriptionsFilter => 'Filtrele';

  @override
  String get subscriptionsFilterNeverRead => 'Hiç okunmamış';

  @override
  String get subscriptionsFilterRarelyRead => 'Nadiren okunan';

  @override
  String get subscriptionsFilterAll => 'Tümü';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonelikler sayılamadı';

  @override
  String get subscriptionsNoMatches => 'Eşleşme yok';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return '“$text” adlı bir bülten yok.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return '“$text” adlı bir liste yok.';
  }

  @override
  String get subscriptionsNoNewsletters => 'Bülten yok';

  @override
  String get subscriptionsNoNewslettersDetail => 'Bültenler ve diğer toplu e-postalar geldiklerinde burada görünür.';

  @override
  String get subscriptionsNothingNeverRead => 'Hiç okunmamış bülten yok';

  @override
  String get subscriptionsNothingRarelyRead => 'Nadiren okunan bülten yok';

  @override
  String get subscriptionsNothingFilteredDetail => 'Size gelen her şeyin bir kısmını okuyorsunuz.';

  @override
  String get subscriptionsNoDiscussions => 'Tartışma yok';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Yazabileceğiniz e-posta listeleri, e-postaları geldiğinde burada görünür.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Birçok kişinin yazdığı listeler. Posta kutularına sabitlemek, düz metin olarak okumak ya da Bültenler’e taşımak için birine dokunup basılı tutun.';

  @override
  String get subscriptionsPrivacyNote =>
      'Bu telefonda, indirilmiş e-postalardan sayılır; bunu hesaplamak için hiçbir yere bir şey gönderilmez. Loupe bir gönderenle yalnızca Abonelikten çık’a dokunduğunuzda iletişime geçer: tek tıklama yöntemi, gönderenin verdiği adrese yalnızca “List-Unsubscribe=One-Click” gönderir; çerez ya da sizinle ilgili başka hiçbir bilgi göndermez ve sayfalarını veya görsellerini asla yüklemez.';

  @override
  String get subscriptionsVolumeNone => 'Son zamanlarda yok';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / ay';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / ay';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '%$percent';
  }

  @override
  String get subscriptionsPercentUnderOne => '<%1';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'okunma $percent';
  }

  @override
  String get subscriptionsStillSending => 'Göndermeye devam ediyor';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Abonelikten çıkıldı: $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Abonelikten çıkma sayfası açıldı: $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Tek dokunuş · $site ile iletişime geçer';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'E-postayla: $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Web sitesinde: $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Abonelikten çık';

  @override
  String get subscriptionsUnsubscribeAgain => 'Yeniden abonelikten çık';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gelen Kutusu’ndaki $countString iletiyi arşivle',
      one: 'Gelen Kutusu’ndaki $countString iletiyi arşivle',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Kural oluştur…';

  @override
  String get subscriptionsCreateRuleDetail => 'Gelecekteki e-postalarını taşı veya arşivle';

  @override
  String get subscriptionsTreatAsDiscussion => 'Tartışma olarak ele al';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'İnsanların yazdığı bir liste: forum gibi okuyun';

  @override
  String get subscriptionsTreatAsNewsletter => 'Bülten olarak ele al';

  @override
  String get subscriptionsBlockSender => 'Göndereni engelle';

  @override
  String get subscriptionsBlock => 'Engelle';

  @override
  String get subscriptionsBlocked => 'Engellendi';

  @override
  String get subscriptionsBlockedDetail => 'Yeni e-postalar Gereksiz klasörüne gider';

  @override
  String get subscriptionsPin => 'Posta kutularına sabitle';

  @override
  String get subscriptionsUnpin => 'Posta kutularından kaldır';

  @override
  String get subscriptionsOpenDefaultView => 'Varsayılan görünümde aç';

  @override
  String get subscriptionsOpenPlainText => 'Düz metin olarak aç (eş aralıklı)';

  @override
  String get subscriptionsPinned => 'Sabitlendi';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString okunmamış',
      one: '$countString okunmamış',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Şu anda bu gönderenden e-posta yok.';

  @override
  String get subscriptionsLatestMessages => 'SON İLETİLER';

  @override
  String get subscriptionsMail => 'E-posta';

  @override
  String get subscriptionsNoneIn90Days => '90 gündür yok';

  @override
  String get subscriptionsRead => 'Okunma';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $totalString iletiden $readString';
  }

  @override
  String get subscriptionsLastReceived => 'Son alınan';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Klasörler', one: 'Klasör');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Göndermeye devam ediyor';

  @override
  String get subscriptionsUnsubscribedTitle => 'Abonelikten çıkıldı';

  @override
  String subscriptionsSince(String date) {
    return '$date tarihinden beri';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'sayfa açıldı: $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender, abonelikten nasıl çıkılacağını belirtmiyor.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender, abonelikten nasıl çıkılacağını belirtmiyor. Bunun yerine engelleyebilirsiniz.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return '$sender aboneliğinden çıkılıyor…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return '$sender aboneliğinden çıkıldı.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Abonelikten çıkılamadı: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Abonelikten otomatik olarak çıkılamadı';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Abonelikten çıkma e-postası gönder';

  @override
  String subscriptionsOpenSite(String site) {
    return '$site sitesini aç';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return '$site açılsın mı?';
  }

  @override
  String get subscriptionsOpen => 'Aç';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender abonelikten çıkma işlemini web sitesinde yapıyor. Sayfa Loupe’un tarayıcısında açılır; işlemi orada tamamlayın.';
  }

  @override
  String get subscriptionsWebInsecure => 'Bu siteyle bağlantı şifrelenmemiş.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Dikkat: bu adres, benzer görünümlü harflerle $site adresini taklit ediyor.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Dikkat: bu adres, benzer görünümlü harflerle başka bir siteyi taklit ediyor.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site açılamadı.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe bugünün tarihini not eder ve $sender yazmaya devam ederse size bildirir.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return '$sender aboneliğinden çıkılsın mı?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe, abonelikten çıkmak için $site ile iletişime geçecek.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Loupe’un bir gönderenin web sitesiyle iletişime geçtiği tek durum budur. $sender tarafından verilen adrese yalnızca “List-Unsubscribe=One-Click” gönderir; çerez ya da sizinle ilgili başka hiçbir bilgi göndermez ve sayfayı yüklemez.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Abonelikten çıkma bağlantısı internette güvenli bir adres değil.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site zamanında yanıt vermedi.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site sitesine ulaşılamadı.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site isteği başka bir sayfaya yönlendirdi; Loupe yönlendirmeleri izlemez.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site isteği reddetti (hata $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Abonelikten çıkma e-postasını gönderecek bir hesap yok.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe, “$subject” konulu bir e-postayı $from adresinden $to adresine gönderecek.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Abonelikten çıkma e-postası gönderildi: $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return '$sender engellensin mi?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Bu listeden gelen yeni e-postalar Gereksiz klasörüne gider. Bunu Ayarlar › Kurallar bölümünden değiştirebilirsiniz.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return '$address adresinden gelen yeni e-postalar Gereksiz klasörüne gider. Bunu Ayarlar › Kurallar bölümünden değiştirebilirsiniz.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender engellendi.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count iletiyi Gereksiz’e taşı',
      one: '$count iletiyi Gereksiz’e taşı',
    );
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Engelle: $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender artık Bültenler’de.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender artık Tartışmalar’da.';
  }

  @override
  String get appLiveGateTitle => 'Hesaplarınız açılamadı';

  @override
  String get appLiveGateUnavailableBuild => 'Gerçek hesaplar bu sürümde henüz kullanılamıyor.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe, bu telefondaki e-postalarınızı koruyan anahtarı okuyamadı. Bu genellikle geçicidir: tekrar deneyin ya da telefonu yeniden başlatın.';

  @override
  String get appLiveGateKeyMissing =>
      'Bu telefondaki e-postalarınızı koruyan anahtar kayboldu; bu, bir yedeği geri yükledikten sonra olabilir. E-postalarınız hâlâ sunucuda.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Bu telefondaki e-posta veritabanı okunamıyor: hasarlı ya da anahtarı değişmiş. E-postalarınız hâlâ sunucuda.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Hesaplarınız açılırken bir sorun oluştu ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Bu işlem hesaplarınızı ve bu telefonda saklanan e-postaları, Giden Kutusu’nda bekleyen iletiler dahil, siler. Sunucularınızdaki e-postalar etkilenmez; ardından hesaplarınızı yeniden ekleyin.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Sil ve baştan başla';

  @override
  String get appLiveGateUseDemo => 'Demo e-postayı kullan';

  @override
  String get appLiveGateReset => 'Bu telefondaki e-postaları sıfırla…';

  @override
  String get attachmentsUntitled => 'Ek';

  @override
  String get attachmentsUntitledFile => 'Adsız';

  @override
  String get attachmentsOpenIn => 'Şununla aç…';

  @override
  String get attachmentsSaveToFiles => 'Dosyalara kaydet';

  @override
  String get attachmentsShareMenu => 'Paylaş…';

  @override
  String get attachmentsDownloadError => 'Ek indirilemedi. Bağlantıyı kontrol edip tekrar deneyin.';

  @override
  String get attachmentsShareError => 'Ek paylaşılamadı.';

  @override
  String attachmentsNoApp(String type) {
    return 'Bu cihazda bu dosyayı ($type) açan bir uygulama yok. Bunun yerine Paylaş’ı deneyin.';
  }

  @override
  String get attachmentsOpenInError => 'Ek başka bir uygulamada açılamadı.';

  @override
  String attachmentsSaved(String name) {
    return '“$name” kaydedildi';
  }

  @override
  String get attachmentsSaveError => 'Ek kaydedilemedi.';

  @override
  String get attachmentsGone => 'Bu ek artık kullanılamıyor.';

  @override
  String get attachmentsDownloadFailed => 'Ek indirilemedi.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sayfa', one: '1 sayfa');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return 'Mobil veride $size';
  }

  @override
  String get attachmentsLargeDownload => 'Bu ek büyük. Şimdi ya da daha sonra Wi-Fi’de indirin.';

  @override
  String get attachmentsDownload => 'İndir';

  @override
  String attachmentsDownloadingSize(String size) {
    return '$size indiriliyor…';
  }

  @override
  String get attachmentsDownloading => 'İndiriliyor…';

  @override
  String get attachmentsTooLarge => 'Burada önizlemek için çok büyük.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return '$total içinden ilk $shown gösteriliyor. Tamamı için kopyalayın, paylaşın veya kaydedin.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Bu PDF burada gösterilemiyor (parolayla korunuyor olabilir).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page / $count';
  }

  @override
  String get attachmentsModeTable => 'Tablo';

  @override
  String get attachmentsModeText => 'Metin';

  @override
  String get attachmentsModeMessage => 'İleti';

  @override
  String get attachmentsModeSource => 'Kaynak';

  @override
  String get attachmentsDontWrap => 'Satırları kaydırma';

  @override
  String get attachmentsWrap => 'Satırları kaydır';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines satır', one: '$lines satır');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Tümünü kopyala';

  @override
  String get attachmentsCopied => 'Kopyalandı';

  @override
  String get attachmentsImageUnavailable => 'Bu görsel burada gösterilemiyor. Şununla aç… seçeneğini deneyin.';

  @override
  String get attachmentsEmlNoSubject => '(Konu yok)';

  @override
  String get attachmentsEmlFrom => 'Kimden';

  @override
  String get attachmentsEmlTo => 'Kime';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Tarih';

  @override
  String get attachmentsEmlNoText => 'Bu iletide metin yok.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Ekler: $names', one: 'Ek: $names');
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Düzenleyen: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ve $count etkinlik daha',
      one: 'Ve 1 etkinlik daha',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Görsel';

  @override
  String attachmentsTypeNamedImage(String format) {
    return '$format görseli';
  }

  @override
  String get attachmentsTypePdf => 'PDF belgesi';

  @override
  String get attachmentsTypeTsv => 'Sekmeyle ayrılmış değerler';

  @override
  String get attachmentsTypeCsv => 'CSV tablosu';

  @override
  String get attachmentsTypeCalendar => 'Takvim etkinliği';

  @override
  String get attachmentsTypeEmail => 'E-posta iletisi';

  @override
  String get attachmentsTypeContact => 'Kişi kartı';

  @override
  String get attachmentsTypeLog => 'Günlük dosyası';

  @override
  String get attachmentsTypeText => 'Metin';

  @override
  String get attachmentsTypeZip => 'ZIP arşivi';

  @override
  String get attachmentsTypeArchive => 'Arşiv';

  @override
  String get attachmentsTypeWord => 'Word belgesi';

  @override
  String get attachmentsTypeExcel => 'Excel tablosu';

  @override
  String get attachmentsTypePowerPoint => 'PowerPoint sunusu';

  @override
  String get attachmentsTypeWebPage => 'Web sayfası';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Ses';

  @override
  String attachmentsTypeExtension(String extension) {
    return '$extension dosyası';
  }

  @override
  String get attachmentsTypeFile => 'Dosya';

  @override
  String get calendarUntitledEvent => 'Etkinlik';

  @override
  String get calendarAllDay => 'Tüm gün';

  @override
  String calendarYourTime(String time) {
    return 'Sizin saatinizle $time';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Katıl: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name kabul etti: $details',
      'tentative': '$name geçici olarak kabul etti: $details',
      'declined': '$name reddetti: $details',
      'delegated': '$name başkasına devretti: $details',
      'other': '$name yanıt vermedi: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name daveti kabul etti',
      'tentative': '$name daveti geçici olarak kabul etti',
      'declined': '$name daveti reddetti',
      'delegated': '$name daveti başkasına devretti',
      'other': '$name davete yanıt vermedi',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Harita';

  @override
  String get calendarJoin => 'Katıl';

  @override
  String get calendarOnlineMeeting => 'Çevrimiçi toplantı';

  @override
  String calendarProviderMeeting(String provider) {
    return '$provider toplantısı';
  }

  @override
  String get calendarOrganizerYou => 'Siz';

  @override
  String get calendarOrganizerLabel => 'düzenleyen';

  @override
  String get calendarStatusAccepted => 'Kabul edildi';

  @override
  String get calendarStatusMaybe => 'Belki';

  @override
  String get calendarStatusDeclined => 'Reddedildi';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name kabul etti',
      'tentative': '$name geçici olarak kabul etti',
      'declined': '$name reddetti',
      'delegated': '$name başkasına devretti',
      'other': '$name yanıt vermedi',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name kabul etti:',
      'tentative': '$name geçici olarak kabul etti:',
      'declined': '$name reddetti:',
      'delegated': '$name başkasına devretti:',
      'other': '$name yanıt vermedi:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name yeni bir zaman öneriyor';
  }

  @override
  String get calendarCounterUnknown => 'Bir katılımcı yeni bir zaman öneriyor';

  @override
  String get calendarDeclineCounter => 'Düzenleyen zamanı değiştirmedi';

  @override
  String calendarRefresh(String name) {
    return '$name en son sürümü istiyor';
  }

  @override
  String get calendarRefreshUnknown => 'Bir katılımcı en son sürümü istiyor';

  @override
  String get calendarCancelled => 'İptal edildi';

  @override
  String get calendarCancelledByOrganizer => 'Düzenleyen bu etkinliği iptal etti.';

  @override
  String get calendarCancelledLater => 'Bu etkinlik daha sonra iptal edildi.';

  @override
  String get calendarOutdated => 'Güncel değil';

  @override
  String get calendarOutdatedDetail => 'Bu davet daha sonra güncellendi; yenisi geçerlidir.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Konum kaldırıldı (önceki: $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Konum kaldırıldı (önceden yoktu)';

  @override
  String calendarLocationChanged(String location) {
    return 'Konum değişti: $location';
  }

  @override
  String get calendarNewTitle => 'Yeni başlık';

  @override
  String get calendarRepeatChanged => 'Tekrarlama değişti';

  @override
  String get calendarUpdated => 'Güncellendi';

  @override
  String get calendarUpdatedInvitation => 'Güncellenmiş davet';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Saat değişti: $before → $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return '“$zone” saat dilimi bilinmiyor: saatler yazıldığı gibi';
  }

  @override
  String calendarNext(String when) {
    return 'Sonraki: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count konuk', one: '1 konuk');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count kabul', one: '$count kabul');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count belki', one: '$count belki');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ret', one: '$count ret');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (siz)';
  }

  @override
  String get calendarAttendeeOptional => 'isteğe bağlı';

  @override
  String get calendarAttendeeRoom => 'oda';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Daha önceki bir sürümü kabul ettiniz.',
      'tentative': 'Daha önceki bir sürümü geçici olarak kabul ettiniz.',
      'declined': 'Daha önceki bir sürümü reddettiniz.',
      'delegated': 'Daha önceki bir sürümü başkasına devrettiniz.',
      'other': 'Daha önceki bir sürüme yanıt vermediniz.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Kabul et';

  @override
  String get calendarMaybe => 'Belki';

  @override
  String get calendarDecline => 'Reddet';

  @override
  String get calendarCommentHint => 'Düzenleyen için yorum (isteğe bağlı)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Yanıtınız $address adresinden $organizer kişisine gider.';
  }

  @override
  String get calendarAddComment => 'Yorum ekle';

  @override
  String get calendarAddToCalendar => 'Takvime ekle';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dosyada $count etkinlik daha var',
      one: 'Dosyada 1 etkinlik daha var',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Etkinliğin ekleneceği bir takvim uygulaması yok.';

  @override
  String get calendarCantOpenCalendar => 'Takvim açılamadı.';

  @override
  String get calendarCantOpenLink => 'Bağlantı açılamadı.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return '$provider toplantısına katılınsın mı?';
  }

  @override
  String get calendarJoinTitle => 'Toplantıya katılınsın mı?';

  @override
  String calendarJoinOpens(String host) {
    return '$host tarayıcınızda açılır.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Dikkat: bu adres, benzer görünümlü harflerle $site adresini taklit ediyor.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Dikkat: bu adres, benzer görünümlü harflerle başka bir siteyi taklit ediyor.';

  @override
  String calendarJoinOpen(String host) {
    return '$host aç';
  }

  @override
  String get calendarNoOrganizer => 'Bu davette yanıtlanacak bir düzenleyen yok.';

  @override
  String get calendarNoAccount => 'Yanıt verilecek bir hesap yok.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Kabul edildi',
      'tentative': 'Belki',
      'other': 'Reddedildi',
    });
    return '$_temp0 · yanıt $name kişisine gönderiliyor…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Kabul edildi',
      'tentative': 'Belki',
      'other': 'Reddedildi',
    });
    return '$_temp0 · yanıt gönderildi';
  }

  @override
  String get calendarReplyAlreadySent => 'Yanıt zaten gönderildi.';

  @override
  String get calendarReplyNotSent => 'Yanıt gönderilmedi.';

  @override
  String get dataSmimeNeedsDevice =>
      'S/MIME sertifikanız bu cihazda: bu iletiyi imzalayıp göndermek için Loupe’u açın.';

  @override
  String dataSigningFailed(String error) {
    return 'İmzalama başarısız oldu: $error';
  }

  @override
  String get keyboardShortcuts => 'Klavye kısayolları';

  @override
  String get keyboardGroupGeneral => 'Genel';

  @override
  String get keyboardGroupMessages => 'İletiler';

  @override
  String get keyboardGroupCompose => 'Yazma';

  @override
  String get keyboardCommandPalette => 'Komut paleti';

  @override
  String get keyboardBackClose => 'Geri, Kapat';

  @override
  String get keyboardNextMessage => 'Sonraki ileti';

  @override
  String get keyboardPreviousMessage => 'Önceki ileti';

  @override
  String get keyboardOpenMessage => 'İletiyi aç';

  @override
  String get keyboardMoveToTrash => 'Çöp Kutusu’na taşı';

  @override
  String get keyboardToggleRead => 'Okundu veya okunmadı olarak işaretle';

  @override
  String get keyboardToggleFlag => 'Bayrak koy veya kaldır';

  @override
  String get keyboardCloseDraft => 'Kapat (taslağı kaydet veya sil)';

  @override
  String get keyboardOr => 'veya';

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
  String get mailingListsMuted => 'Yazışma sessize alındı. Yeni iletileri okunmuş olarak gelir.';

  @override
  String get mailingListsUnmuted => 'Yazışmanın sesi açıldı.';

  @override
  String get mailingListsMuteThread => 'Yazışmayı sessize al';

  @override
  String get mailingListsUnmuteThread => 'Yazışmanın sesini aç';

  @override
  String get mailingListsPin => 'Posta kutularına sabitle';

  @override
  String get mailingListsUnpin => 'Posta kutularından kaldır';

  @override
  String get mailingListsDefaultView => 'Varsayılan görünümde aç';

  @override
  String get mailingListsPlainText => 'Düz metin olarak aç (eş aralıklı)';

  @override
  String get mailingListsShowMuted => 'Sessize alınan yazışmaları göster';

  @override
  String get mailingListsHideMuted => 'Sessize alınan yazışmaları gizle';

  @override
  String get mailingListsTreatAsNewsletter => 'Bülten olarak ele al';

  @override
  String get mailingListsOptions => 'Liste seçenekleri';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted okunmamış',
      one: '$formatted okunmamış',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Listeye yeni ileti';

  @override
  String get mailingListsRowUnread => 'Okunmamış';

  @override
  String get mailingListsRowMuted => 'Sessize alındı';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count yanıt', one: '1 yanıt');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Yazışma yok';

  @override
  String get mailingListsMutedHidden => 'Sessize alınan yazışmalar gizli.';

  @override
  String get mailingListsTechnicalTitle => 'Teknik listeler';

  @override
  String get mailingListsTechnicalEmpty => 'E-posta listeleri, e-postaları geldiğinde burada görünür.';

  @override
  String get mailingListsTechnicalFooter =>
      'Bu listelerden gelen iletiler eş aralıklı yazı tipiyle düz metin olarak açılır; yamalar diff olarak gösterilir. Aa düğmesi yine de her iletinin görünümünü değiştirir.';

  @override
  String get paletteMoveToMailbox => 'Posta kutusuna taşı…';

  @override
  String get paletteMarkAllRead => 'Tümünü okundu olarak işaretle';

  @override
  String get paletteExportFolder => 'Klasörü dışa aktar…';

  @override
  String get paletteGetNewMail => 'Yeni e-postaları al';

  @override
  String get paletteSnoozed => 'Ertelenenler';

  @override
  String get paletteSubscriptions => 'Abonelikler';

  @override
  String get paletteDiscussions => 'Tartışmalar';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'E-posta listesi';

  @override
  String get paletteTag => 'Etiket';

  @override
  String get paletteSwipeActions => 'Kaydırma işlemleri';

  @override
  String get paletteNotifications => 'Bildirimler';

  @override
  String get paletteRules => 'Kurallar';

  @override
  String get paletteEncryption => 'Uçtan uca şifreleme';

  @override
  String get paletteAdvanced => 'Gelişmiş';

  @override
  String get paletteAddAccount => 'Hesap ekle';

  @override
  String get paletteAccount => 'Hesap';

  @override
  String get paletteFolders => 'Klasörler';

  @override
  String get paletteRecentSearch => 'Son arama';

  @override
  String paletteSearchMail(String query) {
    return 'E-postalarda “$query” ara';
  }

  @override
  String get palettePlaceholder => 'İşlem, posta kutusu, ayar ara';

  @override
  String get paletteNothingFound => 'Hiçbir şey bulunamadı';

  @override
  String get searchNewSmartMailbox => 'Yeni Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return '“$query” ile eşleşen her şeyi gösterir.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '“$name” Posta kutularına kaydedildi';
  }

  @override
  String get searchMakeRule => 'Bunu kural yap';

  @override
  String get searchSaveSmartMailbox => 'Smart Mailbox olarak kaydet';

  @override
  String get searchNegate => 'Tersine çevir';

  @override
  String get searchDontNegate => 'Tersine çevirme';

  @override
  String get searchAllMailboxes => 'Tüm posta kutuları';

  @override
  String get searchRecent => 'Son aramalar';

  @override
  String get searchClear => 'Temizle';

  @override
  String get searchSuggestions => 'Öneriler';

  @override
  String get searchUnreadMessages => 'Okunmamış iletiler';

  @override
  String get searchFlaggedMessages => 'Bayraklı iletiler';

  @override
  String get searchWithAttachments => 'Ekli iletiler';

  @override
  String get searchUnrepliedMessages => 'Yanıtlanmamış iletiler';

  @override
  String get searchTags => 'Etiketler';

  @override
  String get searchPeople => 'Kişiler';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Kimden: $name';
  }

  @override
  String get searchSearching => 'Aranıyor…';

  @override
  String get searchNoResults => 'Sonuç yok';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted sonuç',
      one: '$formatted sonuç',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Arama menüsü';

  @override
  String searchSearchingAccount(String account) {
    return 'Sunucuda $account hesabında aranıyor…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Sunucuda hesapta aranıyor…';

  @override
  String searchAccountFailed(String account) {
    return 'Sunucuda $account hesabında aranamadı';
  }

  @override
  String get searchUnknownAccountFailed => 'Sunucuda hesapta aranamadı';

  @override
  String searchChip(String term) {
    return '$term. Düzenlemek için iki kez dokunun.';
  }

  @override
  String searchChipNegated(String term) {
    return '$term değil. Düzenlemek için iki kez dokunun.';
  }

  @override
  String get searchReadAndUnread =>
      'Schrödinger’in gelen kutusu: buradaki her ileti, siz açana kadar hem okunmuş hem okunmamıştır.';

  @override
  String searchContradiction(String term) {
    return 'Hiçbir ileti hem “$term” hem de değil olamaz.';
  }

  @override
  String get searchSyncDeviceOnly => 'Yalnızca bu cihazda';

  @override
  String searchSyncUnsupported(String account) {
    return 'Yalnızca bu cihazda: $account bunu saklayamıyor';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Eşitlenmedi: $account hesabında daha yeni bir biçim var';
  }

  @override
  String searchSyncWaiting(String account) {
    return '$account ile eşitlenmeyi bekliyor';
  }

  @override
  String searchSynced(String account) {
    return '$account ile eşitlendi';
  }

  @override
  String get searchRename => 'Yeniden adlandır';

  @override
  String get searchEditSearch => 'Aramayı düzenle';

  @override
  String get searchDeleteSmartMailbox => 'Smart Mailbox’ı sil';

  @override
  String get searchRenameSmartMailbox => 'Smart Mailbox’ı yeniden adlandır';

  @override
  String get searchSmartMailboxDeleted => 'Bu Smart Mailbox silindi.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes bu cihazda kalır.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes e-posta sunucunuzda saklanır; böylece diğer cihazlarınızda ve Expression Search Reloaded eklentisiyle Thunderbird’de de bulunur. Tüm hesaplarda arama yapanlar $account hesabında, tek bir klasördekiler ise o klasörün hesabında saklanır.';
  }

  @override
  String get searchSyncVia => 'Eşitleme hesabı';

  @override
  String get searchSyncViaFooter => 'Her cihazda aynı hesabı seçin.';

  @override
  String get searchGmailCantKeep => 'Gmail, Smart Mailbox’ları saklayamaz';

  @override
  String get searchKeepOnDevice => 'Smart Mailbox’ları yalnızca bu cihazda tut';

  @override
  String get searchOnTheServer => 'Sunucuda';

  @override
  String get searchServerFooter =>
      'Sunucu meta verileri (IMAP METADATA) hiçbir e-posta uygulamasında görünmez. Bunu desteklemeyen sunucularda tek bir ileti içeren bir “Loupe Settings” klasörü oluşturulur; Loupe bunu Posta kutularında gizler.';

  @override
  String get searchSyncNow => 'Şimdi eşitle';

  @override
  String get searchStateUnsupported => 'Desteklenmiyor';

  @override
  String get searchStateNewerFormat => 'Daha yeni biçim';

  @override
  String get searchStateFailed => 'Eşitlenemedi';

  @override
  String get searchStateSyncing => 'Eşitleniyor…';

  @override
  String get searchStateWaiting => 'Bekliyor';

  @override
  String get searchStateMetadata => 'Sunucu meta verileri';

  @override
  String get searchStateFolder => 'Loupe Settings klasörü';

  @override
  String get searchStateNothing => 'Saklanan bir şey yok';

  @override
  String get sharedBack => 'Geri';

  @override
  String get sharedYesterday => 'Dün';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bayt', one: '$count bayt');
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
  String get sharedSyncNoAccounts => 'Hesap yok';

  @override
  String get sharedSyncChecking => 'E-postalar denetleniyor…';

  @override
  String get sharedSyncFailed => 'E-postalar denetlenemedi';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Çevrimdışı';

  @override
  String get sharedSyncJustNow => 'Az önce güncellendi';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes dakika önce güncellendi',
      one: '1 dakika önce güncellendi',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Güncellenme: $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Güncellenme: $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Tüm Gelen Kutuları';

  @override
  String get sharedMailboxUnread => 'Okunmamış';

  @override
  String get sharedMailboxFlagged => 'Bayraklı';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Tüm Taslaklar';

  @override
  String get sharedMailboxAllSent => 'Tüm Gönderilmişler';

  @override
  String get sharedMailboxUntitled => 'Posta kutusu';

  @override
  String get sharedTagImportant => 'Önemli';

  @override
  String get sharedTagWork => 'İş';

  @override
  String get sharedTagPersonal => 'Kişisel';

  @override
  String get sharedTagToDo => 'Yapılacak';

  @override
  String get sharedTagLater => 'Sonra';

  @override
  String get sharedTags => 'Etiketler';

  @override
  String get sharedMoveTo => 'Şuraya taşı…';

  @override
  String get sharedNoRecipients => 'Alıcı yok';

  @override
  String get sharedUnknownSender => 'Bilinmeyen gönderen';

  @override
  String get sharedOnServer => 'Sunucuda';

  @override
  String get sharedAttachment => 'Ek';

  @override
  String get sharedSnoozedBadge => 'Ertelendi';

  @override
  String get sharedRowUnread => 'Okunmamış';

  @override
  String get sharedRowBackFromSnooze => 'Ertelemeden döndü';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Bayraklı';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti arşivlendi',
      one: '1 ileti arşivlendi',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti silindi',
      one: '1 ileti silindi',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti Gelen Kutusu’na taşındı',
      one: '1 ileti Gelen Kutusu’na taşındı',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti Çöp Kutusu’na taşındı',
      one: '1 ileti Çöp Kutusu’na taşındı',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti Gereksiz klasörüne taşındı',
      one: '1 ileti Gereksiz klasörüne taşındı',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti şuraya taşındı: $mailbox',
      one: '1 ileti şuraya taşındı: $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti posta kutusuna taşındı',
      one: '1 ileti posta kutusuna taşındı',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti şu zamana kadar ertelendi: $time',
      one: '1 ileti şu zamana kadar ertelendi: $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Yalnızca bu cihazda şu zamana kadar ertelendi: $time. Sunucu erteleme zamanlarını saklayamıyor.';
  }

  @override
  String get sharedMoveOneAccount => 'Taşımak için tek bir hesaptan ileti seçin.';

  @override
  String get sharedSnoozeTitle => 'Ertele';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Erteleme zamanını değiştir';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ileti kalıcı olarak silinsin mi?',
      one: 'Bu ileti kalıcı olarak silinsin mi?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Bu işlem geri alınamaz.';

  @override
  String get sharedDeletePermanently => 'Kalıcı olarak sil';

  @override
  String get sharedSwipeRead => 'Okundu';

  @override
  String get sharedSwipeUnread => 'Okunmadı';

  @override
  String get sharedSwipeInbox => 'Gelen Kutusu';

  @override
  String get sharedSwipeDelete => 'Sil';

  @override
  String get sharedTrash => 'Çöpe at';

  @override
  String get sharedSwipeSnooze => 'Ertele';

  @override
  String get sharedWakeNow => 'Şimdi geri getir';

  @override
  String get sharedChangeSnoozeTime => 'Erteleme zamanını değiştir…';

  @override
  String get sharedSnooze => 'Ertele…';

  @override
  String get sharedTag => 'Etiketle…';

  @override
  String get sharedMoveMessage => 'İletiyi taşı…';

  @override
  String get sharedNotJunk => 'Gereksiz değil';

  @override
  String get accountSetupTitle => 'Hesap ekle';

  @override
  String get accountSetupTitleDone => 'Hesap eklendi';

  @override
  String get accountSetupAddressTitle => 'E-posta hesabı ekleyin';

  @override
  String get accountSetupAddressText => 'Loupe çoğu sağlayıcının ayarlarını bulur.';

  @override
  String get accountSetupNameHint => 'Adınız';

  @override
  String get accountSetupEmail => 'E-posta';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Devam';

  @override
  String get accountSetupLookingUp => 'Ayarlar aranıyor…';

  @override
  String get accountSetupImport => 'Thunderbird’den içe aktar';

  @override
  String get accountSetupInvalidEmail => 'Geçerli bir e-posta adresi girin.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return '$domain için ayarlar bulunamadı. Aşağıya girin.';
  }

  @override
  String get accountSetupCheckServers => 'Sunucu adlarını ve bağlantı noktalarını kontrol edin.';

  @override
  String get accountSetupEnterPassword => 'Parolanızı girin.';

  @override
  String get accountSetupConnecting => 'Bağlanılıyor…';

  @override
  String accountSetupWaitingFor(String provider) {
    return '$provider bekleniyor…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Sayfa açılamadı.';

  @override
  String get accountSetupCouldNotSaveName => 'Ad kaydedilemedi.';

  @override
  String get accountSetupTrustCertificate => 'Bu sertifikaya güven';

  @override
  String get accountSetupPasswordRequired => 'Gerekli';

  @override
  String get accountSetupShowPassword => 'Parolayı göster';

  @override
  String get accountSetupHidePassword => 'Parolayı gizle';

  @override
  String get accountSetupAppPassword => 'Uygulama şifresi';

  @override
  String get accountSetupApiToken => 'API belirteci';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Gelen · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Giden · SMTP';

  @override
  String get accountSetupSignIn => 'Oturum aç';

  @override
  String accountSetupSignInWith(String provider) {
    return '$provider ile oturum aç';
  }

  @override
  String get accountSetupUseAppPassword => 'Uygulama şifresi kullan';

  @override
  String get accountSetupUseAppPasswordInstead => 'Bunun yerine uygulama şifresi kullan';

  @override
  String get accountSetupUseDifferentAddress => 'Farklı bir adres kullan';

  @override
  String get accountSetupHowToCreateAppPassword => 'Uygulama şifresi nasıl oluşturulur';

  @override
  String get accountSetupHowToCreateOne => 'Nasıl oluşturulur';

  @override
  String get accountSetupGoogleNote =>
      'Oturumu Google’ın sayfasında açarsınız ve Loupe parolanızı asla görmez. Loupe’un e-postalarınızı okumasına, göndermesine ve düzenlemesine izin verin.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Google ile oturum aç” bu sürümde henüz kullanılamıyor. Bunun yerine bir uygulama şifresiyle bağlanabilirsiniz (Google hesabınızda 2 Adımlı Doğrulama gerekir).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Google hesabınızda bir uygulama şifresi oluşturun ve aşağıya yapıştırın.';

  @override
  String get accountSetupMicrosoftNote =>
      'Oturumu Microsoft’un sayfasında açarsınız ve Loupe parolanızı asla görmez. Bu, Outlook.com ve Hotmail ile Microsoft 365’teki iş veya okul hesapları için çalışır.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Microsoft ile oturum açma daha sonraki bir sürümde gelecek. Outlook, Hotmail ve Microsoft 365 hesapları buna ihtiyaç duyar: artık e-posta uygulamalarından parola kabul etmiyorlar.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail, Apple Hesabı parolanızı değil, uygulamaya özel bir parola gerektirir.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail, hesap parolanızı değil, bir uygulama şifresi gerektirir.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe, Fastmail’e JMAP üzerinden bir API belirteciyle bağlanır: Settings › Privacy & Security › Manage API tokens; JMAP için, e-posta ve gönderme erişimiyle.';

  @override
  String get accountSetupFastmailNote => 'Fastmail, e-posta uygulamaları için bir uygulama şifresi gerektirir.';

  @override
  String get accountSetupServerSettings => 'Sunucu ayarları';

  @override
  String get accountSetupSettingsNotFound => 'Otomatik olarak bulunamadı';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Bulunduğu yer: $source';
  }

  @override
  String get accountSetupEditSettings => 'Ayarları düzenle';

  @override
  String get accountSetupSyncing => 'E-postalarınız eşitleniyor.';

  @override
  String get accountSetupDescription => 'Açıklama';

  @override
  String get accountSetupDescriptionHint => 'İş, Kişisel…';

  @override
  String get accountSetupColour => 'Renk';

  @override
  String accountSetupColourNumber(int number) {
    return 'Renk $number';
  }

  @override
  String get accountSetupSaving => 'Kaydediliyor…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe bu telefondaki e-posta veritabanını açamadı. Loupe’u kapatıp yeniden açın ve tekrar deneyin.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Bir sorun oluştu ($error). Tekrar deneyin.';
  }

  @override
  String get accountSetupSecurityNone => 'Yok';

  @override
  String get accountSetupProtocol => 'Protokol';

  @override
  String get accountSetupPort => 'Bağlantı noktası';

  @override
  String get accountSetupSecurity => 'Güvenlik';

  @override
  String get accountSetupUsername => 'Kullanıcı adı';

  @override
  String get accountSetupUsernameHint => 'E-posta adresiniz';

  @override
  String get accountSetupNoEncryptionTitle => 'Şifreleme olmadan bağlanılsın mı?';

  @override
  String get accountSetupNoEncryptionText =>
      'Parolanız ve her ileti düz metin olarak iletilir. Ağdaki herkes, örneğin herkese açık bir Wi-Fi’de, bunları okuyabilir. Bunu yalnızca kendi ağınızdaki bir sunucu için kullanın.';

  @override
  String get accountSetupUseWithoutEncryption => 'Şifrelemeden kullan';

  @override
  String get accountSetupApiTokenRejected =>
      'API belirteci reddedildi. E-posta erişimi olan, JMAP için bir Fastmail API belirteci oluşturun ve yapıştırın.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Parola reddedildi. Hesap parolanızı değil, bir uygulama şifresi kullanın.';

  @override
  String get accountSetupPasswordRejected => 'Parola reddedildi. Kontrol edip tekrar deneyin.';

  @override
  String get accountSetupServerUnreachable => 'Sunucuya ulaşılamıyor. Sunucu ayarlarını ve bağlantınızı kontrol edin.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Sunucunun sertifikasına güvenilmiyor. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Oturum açma iptal edildi. Tekrar denemek için “$provider ile oturum aç” düğmesine dokunun.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe’un Gmail’inizi okuma ve gönderme izni olması gerekir. Yeniden oturum açın ve Gmail kutusu işaretliyken erişime izin verin.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe’un e-postalarınızı okuma ve gönderme izni olması gerekir. Yeniden oturum açın ve izinleri kabul edin.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Bu hesapla kullanabilmeniz için kuruluşunuzun Loupe’u onaylaması gerekir. BT yöneticinizden Microsoft Entra ID’de Loupe için yönetici onayı vermesini isteyin, ardından tekrar deneyin.';

  @override
  String get accountSetupOAuthBlocked =>
      'Kuruluşunuzun oturum açma kuralları bu cihazda Loupe’a izin vermiyor. BT yöneticinize danışın.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider ile bağlantı kurulamadı. İnternet bağlantınızı kontrol edip tekrar deneyin.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return '$provider ile oturum açma, Loupe’un bu sürümünde doğru ayarlanmamış. Lütfen bunu bildirin.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return '$provider ile oturum açma işe yaramadı. Tekrar deneyin.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider oturumunuzu açtı ama Gmail bu adres için erişimi reddetti. Oturum açarken aynı hesabı seçin. İş veya okul hesaplarında IMAP, yöneticileri tarafından kapatılmış olabilir.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider oturumunuzu açtı ama e-posta sunucusu bu adres için erişimi reddetti. Oturum açarken aynı hesabı seçin. İş veya okul hesaplarında IMAP, yöneticileri tarafından kapatılmış olabilir.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'E-posta sunucusuna ulaşılamıyor. Bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return '$provider ile oturum açma bu sürümde kullanılamıyor.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Yeniden oturum açıldı. $account eşitleniyor.';
  }

  @override
  String get accountSetupSignInAgain => 'Yeniden oturum aç';

  @override
  String get accountSetupSigningIn => 'Oturum açılıyor…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider artık $email için Loupe’un oturum açmasını kabul etmiyor, bu yüzden $account eşitlenmiyor. E-postalarını almak için yeniden oturum açın.';
  }

  @override
  String get accountImportTitle => 'Thunderbird’den içe aktar';

  @override
  String get accountImportPointCamera => 'Kamerayı Thunderbird’ün gösterdiği QR koduna doğrultun.';

  @override
  String accountImportProgress(int scanned, int total) {
    return '$total koddan $scanned tarandı';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total koddan $scanned tarandı',
      one: '$total koddan $scanned tarandı',
    );
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Şu ana kadar $count hesap',
      one: 'Şu ana kadar 1 hesap',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Bilgisayarınızda Thunderbird’ü açın ve Araçlar › Mobil için dışa aktar’ı seçin. Hesaplarınızı seçin, ardından gösterdiği her kodu tarayın. Kodlar herhangi bir sırayla taranabilir.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hesapla devam et',
      one: '1 hesapla devam et',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Bunun yerine metni yapıştır';

  @override
  String get accountImportStartOver => 'Baştan başla';

  @override
  String get accountImportDuplicateCode => 'Bu kod zaten eklendi.';

  @override
  String get accountImportRestarted =>
      'Bu kod yeni bir dışa aktarmadan geliyor, bu yüzden daha önce taranan kodlar bir kenara bırakıldı.';

  @override
  String get accountImportNotThunderbird => 'Bu bir Thunderbird hesap kodu değil.';

  @override
  String get accountImportNewerVersion =>
      'Bu kod daha yeni bir Thunderbird’den geliyor. İçe aktarmak için Loupe’u güncelleyin.';

  @override
  String get accountImportDamaged => 'Bu Thunderbird kodu okunamadı.';

  @override
  String get accountImportTooLarge => 'Bu kod, bir Thunderbird dışa aktarımı olamayacak kadar büyük.';

  @override
  String get accountImportCouldNotOpenSettings => 'Ayarlar açılamadı.';

  @override
  String get accountImportCameraOffTitle => 'Kamera erişimi kapalı';

  @override
  String get accountImportCameraOffText =>
      'Kodu taramak için Ayarlar’da Loupe’un kamerayı kullanmasına izin verin ya da bunun yerine kodun metnini yapıştırın.';

  @override
  String get accountImportNoCameraTitle => 'Kamera yok';

  @override
  String get accountImportNoCameraText => 'Loupe burada kamera kullanamıyor. Bunun yerine kodun metnini yapıştırın.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera başlamadı';

  @override
  String get accountImportCameraFailedText => 'Tekrar deneyin ya da bunun yerine kodun metnini yapıştırın.';

  @override
  String get accountImportOpenSettings => 'Ayarları aç';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hesap bulundu',
      one: '1 hesap bulundu',
      zero: 'Hesap bulunamadı',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Bu kodlardaki hesapların hiçbiri okunamadı.';

  @override
  String get accountImportChoose => 'Loupe’a eklenecek hesapları seçin.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$total koddan $codes numaralı kodlar taranmadı, bu yüzden hesapları listelenmiyor.',
      one: '$total koddan $codes. kod taranmadı, bu yüzden hesapları listelenmiyor.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes ve $last';
  }

  @override
  String get accountImportScanMore => 'Daha fazla kod tara';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kodlardaki $count hesap okunamadı. Daha yeni bir Thunderbird’ün ayarlarını kullanıyor olabilirler.',
      one: 'Kodlardaki 1 hesap okunamadı. Daha yeni bir Thunderbird’ün ayarlarını kullanıyor olabilir.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Yeniden tara';

  @override
  String get accountImportAlreadyAdded => 'Bu adrese sahip bir hesap zaten Loupe’ta.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Hesap eklendiğinde, Thunderbird’deki gibi $provider ile oturum açacaksınız.';
  }

  @override
  String get accountImportGmailAppPassword => 'Hesabı bir uygulama şifresiyle ekleyin (2 Adımlı Doğrulama gerekir).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird, Gmail’de Google ile oturum açar. “Google ile oturum aç” daha sonraki bir sürümde gelecek; o zamana kadar hesabı bir uygulama şifresiyle ekleyin (2 Adımlı Doğrulama gerekir).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird bu hesapta tarayıcıda oturum açar. Loupe bunu henüz yapamıyor: sağlayıcınız sunuyorsa bir uygulama şifresi kullanın.';

  @override
  String get accountImportUnencrypted => 'Şifreleme olmadan bağlanır. Bunu yalnızca kendi ağınızda kullanın.';

  @override
  String get accountImportEnterAgain => 'Yeniden girin';

  @override
  String get accountImportAdded => 'Eklendi';

  @override
  String accountImportAdding(int index, int total) {
    return '$total hesaptan $index. ekleniyor…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hesap ekle',
      one: '1 hesap ekle',
      zero: 'Hesap ekle',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Dışa aktarma metnini yapıştır';

  @override
  String get accountImportPasteText => 'Bir Thunderbird dışa aktarma kodunun metnini yapıştırın; her satıra bir kod.';

  @override
  String get accountImportPop3 => 'POP3 hesapları desteklenmiyor. Loupe, IMAP ile e-postaları sunucuda tutar.';

  @override
  String get accountImportKerberos => 'Bu hesap, Loupe’un desteklemediği Kerberos ile oturum açıyor.';

  @override
  String get accountImportNtlm => 'Bu hesap, Loupe’un desteklemediği NTLM ile oturum açıyor.';

  @override
  String get accountImportClientCertificate =>
      'Bu hesap, Loupe’un henüz desteklemediği bir istemci sertifikasıyla oturum açıyor.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Microsoft ile oturum açma daha sonraki bir sürümde gelecek. Outlook ve Microsoft 365 hesapları artık e-posta uygulamalarından parola kabul etmiyor.';

  @override
  String get accountImportEnterPassword => 'Parolayı girin.';

  @override
  String get accountImportEnterAppPassword => 'Uygulama şifresini girin.';

  @override
  String get accountImportEnterApiToken => 'API belirtecini girin.';

  @override
  String get accountImportStorageFailed => 'Loupe hesap deposunu açamadı. Daha sonra tekrar deneyin.';

  @override
  String get accountImportFailed => 'Hesap eklenemedi. Tekrar deneyin ya da elle ekleyin.';

  @override
  String get composeNewMessageTitle => 'Yeni ileti';

  @override
  String get composeAttach => 'Ekle';

  @override
  String get composeSendLater => 'Daha sonra gönder';

  @override
  String composeSendAt(String time) {
    return 'Gönder: $time';
  }

  @override
  String get composeSendHint => 'Daha sonra göndermek için uzun basın';

  @override
  String get composeNoAccount => 'E-posta göndermek için bir hesap ekleyin.';

  @override
  String get composeTo => 'Kime:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Kimden: $email';
  }

  @override
  String get composeFromLabel => 'Kimden:';

  @override
  String get composeSubjectLabel => 'Konu:';

  @override
  String composeReplyTo(String address) {
    return 'Yanıt adresi: $address';
  }

  @override
  String get composeFrom => 'Kimden';

  @override
  String composeReplyFrom(String email) {
    return '$email adresinden yanıtla';
  }

  @override
  String composeSendFrom(String email) {
    return '$email adresinden gönder';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return '$email adresinden yanıtlansın mı?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return '$email adresinden gönderilsin mi?';
  }

  @override
  String get composeDismiss => 'Kapat';

  @override
  String composeAliasNotSaved(String account) {
    return 'Kimlik olarak kaydedilmedi · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Kimlik olarak kaydet';

  @override
  String composeAliasSaved(String email) {
    return '$email kimlik olarak kaydedildi.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Geçersiz adres: $address';
  }

  @override
  String get composeOriginalNotFound => 'Özgün ileti bulunamadı.';

  @override
  String get composeDraftNotFound => 'Taslak bulunamadı.';

  @override
  String get composeAttachmentsLost => 'Ekler kurtarılamadı. Yeniden ekleyin.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Bazı ekler eklenemedi: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Eklerin toplamı $size; bazı sunucular bu kadar büyük iletileri reddeder.';
  }

  @override
  String get composeAttachFailed => 'Dosya eklenemedi.';

  @override
  String get composeInvalidAddressTitle => 'Geçersiz adres';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” geçerli bir e-posta adresi değil.';
  }

  @override
  String get composeNoSubjectTitle => 'Konu yok';

  @override
  String get composeNoSubjectText => 'Bu iletinin konusu yok. Yine de gönderilsin mi?';

  @override
  String get composeSentBeforeChanges =>
      'İleti, değişikliklerinizden önce gönderildi; değişiklikleriniz Taslaklar’a kaydedildi.';

  @override
  String composeScheduled(String time) {
    return 'Şu zamana planlandı: $time';
  }

  @override
  String get composeSending => 'Gönderiliyor…';

  @override
  String get composeSent => 'Gönderildi';

  @override
  String get composeSendFailed => 'Gönderilemedi. Tekrar deneyin.';

  @override
  String get composeAlreadySent => 'Zaten gönderildi.';

  @override
  String get composeDiscardChanges => 'Değişiklikleri at';

  @override
  String get composeSaveChanges => 'Değişiklikleri kaydet';

  @override
  String get composeDeleteDraft => 'Taslağı sil';

  @override
  String get composeSaveDraft => 'Taslağı kaydet';

  @override
  String get composeDraftSaved => 'Taslak kaydedildi';

  @override
  String composeAttribution(String date, String time, String name) {
    return '$date $time tarihinde $name şunu yazdı:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return '$date $time tarihinde biri şunu yazdı:';
  }

  @override
  String get composeForwardHeader => '---------- İletilen ileti ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Kimden: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Tarih: $date $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Konu: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Kime: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Bugün daha sonra';

  @override
  String get composeTomorrowMorning => 'Yarın sabah';

  @override
  String get composeMondayMorning => 'Pazartesi sabahı';

  @override
  String get composePickDateTime => 'Tarih ve saat seç…';

  @override
  String get composeSendWithoutDelay => 'Beklemeden gönder';

  @override
  String composeSendTimeToday(String time) {
    return 'Bugün $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Yarın $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Bugün $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Yarın $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Taslağınızı düzenlemeye devam edilsin mi?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Loupe kapandığında bir ileti gönderilmemişti.',
      'one': 'Loupe kapandığında $name kişisine bir ileti gönderilmemişti.',
      'other': 'Loupe kapandığında $name ve diğerlerine bir ileti gönderilmemişti.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Loupe kapandığında “$subject” gönderilmemişti.',
      'one': 'Loupe kapandığında $name kişisine “$subject” gönderilmemişti.',
      'other': 'Loupe kapandığında $name ve diğerlerine “$subject” gönderilmemişti.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Düzenlemeye devam et';

  @override
  String get composeRecoverySave => 'Taslaklar’a kaydet';

  @override
  String get composeRecoveryDiscard => 'At';

  @override
  String get composeRecoverySaved => 'Taslaklar’a kaydedildi';

  @override
  String get outboxSectionFailed => 'Gönderilmedi';

  @override
  String get outboxSectionSending => 'Gönderiliyor';

  @override
  String get outboxSectionScheduled => 'Planlandı';

  @override
  String get outboxStatusQueued => 'Birazdan gönderilecek';

  @override
  String get outboxStatusSending => 'Gönderiliyor…';

  @override
  String get outboxStatusFailed => 'Gönderilmedi';

  @override
  String get outboxNoRecipients => 'Alıcı yok';

  @override
  String get outboxNoSubject => '(Konu yok)';

  @override
  String get outboxSendingFailed => 'Gönderme başarısız oldu.';

  @override
  String get outboxEmptyTitle => 'Gönderilecek bir şey yok';

  @override
  String get outboxEmptyText => 'Daha sonra gönderdiğiniz iletiler, zamanı gelene kadar burada bekler.';

  @override
  String get outboxSendNow => 'Şimdi gönder';

  @override
  String get outboxReschedule => 'Yeniden planla';

  @override
  String get outboxRescheduleMenu => 'Yeniden planla…';

  @override
  String get outboxRescheduleTitle => 'Yeniden planla';

  @override
  String outboxRescheduled(String time) {
    return 'Şu zamana yeniden planlandı: $time';
  }

  @override
  String get outboxCancel => 'İptal';

  @override
  String get outboxCancelSending => 'Göndermeyi iptal et…';

  @override
  String get outboxCancelTitle => 'Gönderme iptal edilsin mi?';

  @override
  String get outboxMoveToDrafts => 'Taslaklar’a taşı';

  @override
  String get outboxDiscard => 'İletiyi at';

  @override
  String get outboxMovedToDrafts => 'Taslaklar’a taşındı';

  @override
  String get outboxDiscarded => 'İleti atıldı';

  @override
  String get outboxAlreadySent => 'Zaten gönderildi.';

  @override
  String get outboxBeingSent => 'Bu ileti gönderiliyor.';

  @override
  String get outboxActionFailed => 'Bu işe yaramadı. İleti hâlâ Giden Kutusu’nda.';

  @override
  String get notificationsBadgeInboxes => 'Gelen kutularındaki okunmamışlar';

  @override
  String get notificationsBadgeVip => 'VIP’deki okunmamışlar';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Herhangi bir hesapta VIP’lerinizden gelen yeni e-postalar';

  @override
  String notificationsAccountChannelDescription(String email) {
    return '$email hesabındaki yeni e-postalar';
  }

  @override
  String get notificationsUnknownSender => 'Bilinmeyen gönderen';

  @override
  String get notificationsNoSubject => '(Konu yok)';

  @override
  String get notificationsEncryptedMessage => 'Şifreli ileti';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Yeni ileti: $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count yeni ileti', one: '1 yeni ileti');
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return '$account hesabında yeni iletiler';
  }

  @override
  String get platformInstantChannel => 'Anında teslim';

  @override
  String get platformInstantChannelDescription => 'Loupe gelen kutularınızda yeni e-posta beklerken görünür';

  @override
  String get platformInstantTitle => 'Yeni e-postalar bekleniyor';

  @override
  String get platformInstantText => 'Anında teslim açık';

  @override
  String get platformErrorBox => 'Bu bölüm gösterilirken bir sorun oluştu. Geri gidip tekrar deneyin.';

  @override
  String get welcomeTagline => 'Yüzeyde sade,\nderinde güçlü e-posta.';

  @override
  String get welcomeAccountsTitle => 'Tüm hesaplar, tek ve sakin bir gelen kutusu';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail ve her IMAP veya JMAP sunucusu.';

  @override
  String get welcomeSearchTitle => 'Bulan arama';

  @override
  String get welcomeSearchText => 'Önce telefonunuzda anında sonuçlar, ardından sunucununkiler.';

  @override
  String get welcomePrivacyTitle => 'Tasarımı gereği gizli';

  @override
  String get welcomePrivacyText => 'İzleme yok. Uzak görseller siz izin verene kadar engelli kalır.';

  @override
  String get welcomeAddAccount => 'Hesap ekle';

  @override
  String get welcomeImport => 'Thunderbird’den içe aktar';

  @override
  String get welcomeTryDemo => 'Demo e-postayla deneyin';
}
