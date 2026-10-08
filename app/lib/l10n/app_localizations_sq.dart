// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get commonAdd => 'Shto';

  @override
  String get commonCancel => 'Anulo';

  @override
  String get commonClose => 'Mbyll';

  @override
  String get commonDelete => 'Fshi';

  @override
  String get commonDone => 'U krye';

  @override
  String get commonEdit => 'Redakto';

  @override
  String get commonMore => 'Më shumë';

  @override
  String get commonMove => 'Zhvendos';

  @override
  String get commonName => 'Emri';

  @override
  String get commonNone => 'Asnjë';

  @override
  String get commonOff => 'Joaktiv';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Aktiv';

  @override
  String get commonOptional => 'Opsionale';

  @override
  String get commonPassword => 'Fjalëkalimi';

  @override
  String get commonRemove => 'Hiq';

  @override
  String get commonRetry => 'Riprovo';

  @override
  String get commonSave => 'Ruaj';

  @override
  String get commonSearch => 'Kërko';

  @override
  String get commonServer => 'Serveri';

  @override
  String get commonSettings => 'Cilësimet';

  @override
  String get commonShare => 'Ndaj';

  @override
  String get commonTryAgain => 'Provo sërish';

  @override
  String get commonUndo => 'Zhbëj';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mesazhe', one: '1 mesazh');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Arkivo';

  @override
  String get mailDelete => 'Fshi';

  @override
  String get mailFlag => 'Vër flamurkë';

  @override
  String get mailForward => 'Përcill';

  @override
  String get mailMarkAsRead => 'Shëno si të lexuar';

  @override
  String get mailMarkAsUnread => 'Shëno si të palexuar';

  @override
  String get mailMoveToJunk => 'Zhvendos te të padëshiruarat';

  @override
  String get mailNewMessage => 'Mesazh i ri';

  @override
  String get mailNoSubject => 'Pa subjekt';

  @override
  String get mailReply => 'Përgjigju';

  @override
  String get mailReplyAll => 'Përgjigju të gjithëve';

  @override
  String get mailSend => 'Dërgo';

  @override
  String get mailUnflag => 'Hiq flamurkën';

  @override
  String get mailboxArchive => 'Arkivi';

  @override
  String get mailboxDrafts => 'Skica';

  @override
  String get mailboxInbox => 'Kutia hyrëse';

  @override
  String get mailboxJunk => 'Të padëshiruara';

  @override
  String get mailboxOutbox => 'Kutia dalëse';

  @override
  String get mailboxSent => 'Të dërguara';

  @override
  String get mailboxTrash => 'Koshi';

  @override
  String get conversationSomethingWentWrong => 'Diçka shkoi keq. Provoni sërish.';

  @override
  String get conversationReplyToList => 'Përgjigju listës';

  @override
  String get conversationReplyList => 'Listës';

  @override
  String get conversationThreadMuted => 'Rrjedha u heshtua. Mesazhet e reja në të vijnë si të lexuara.';

  @override
  String get conversationThreadUnmuted => 'Rrjedhës iu hoq heshtja.';

  @override
  String get conversationLinkFailed => 'Lidhja nuk u hap dot.';

  @override
  String get conversationGoneTitle => 'S’ka mesazh';

  @override
  String get conversationGoneText => 'Ky mesazh është zhvendosur ose fshirë.';

  @override
  String get conversationMuted => 'E heshtur';

  @override
  String get conversationReaderOptions => 'Opsionet e leximit';

  @override
  String get conversationReaderOptionsHint => 'Madhësia e tekstit dhe pamja';

  @override
  String get conversationTrash => 'Në kosh';

  @override
  String get conversationReplyHint => 'Shtypni gjatë për “Përgjigju të gjithëve” dhe “Përcill”';

  @override
  String get conversationOfflineTitle => 'Jeni jashtë linje';

  @override
  String get conversationOfflineText =>
      'Kjo bisedë s’është shkarkuar ende. Do të ngarkohet kur të riktheheni në linjë.';

  @override
  String get conversationErrorTitle => 'Ky mesazh s’mund të shfaqet';

  @override
  String get conversationErrorText => 'Diçka shkoi keq.';

  @override
  String get conversationOfflineBanner => 'Jeni jashtë linje';

  @override
  String get conversationNotUpdated => 'S’u përditësua';

  @override
  String get conversationMe => 'mua';

  @override
  String get conversationNoSender => '(pa dërgues)';

  @override
  String get conversationNoRecipients => 'pa marrës';

  @override
  String conversationRecipients(String names) {
    return 'për $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'për $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Nga';

  @override
  String get conversationHeaderTo => 'Për';

  @override
  String get conversationHeaderCc => 'Cc';

  @override
  String get conversationHeaderBcc => 'Bcc';

  @override
  String get conversationHeaderReplyTo => 'Përgjigju te';

  @override
  String get conversationHeaderDate => 'Data';

  @override
  String get conversationHeaderSecurity => 'Siguria';

  @override
  String get conversationVerifiedSender => 'Dërgues i verifikuar';

  @override
  String get conversationUnverifiedSender => 'Dërgues i paverifikuar';

  @override
  String get conversationLoadingMessage => 'Po ngarkohet mesazhi';

  @override
  String get conversationBodyError => 'Ky mesazh nuk u ngarkua dot.';

  @override
  String get conversationBodyOffline => 'Jeni jashtë linje. Mesazhi do të ngarkohet kur të riktheheni në linjë.';

  @override
  String get conversationOriginalHint => 'Duket më mirë në pamjen “Origjinale”';

  @override
  String get conversationShowOriginal => 'Shfaq origjinalin';

  @override
  String get conversationScrollToTop => 'Shko në krye';

  @override
  String get conversationTagsMenu => 'Etiketat…';

  @override
  String get conversationMuteThread => 'Heshtoje rrjedhën';

  @override
  String get conversationUnmuteThread => 'Hiqi heshtjen rrjedhës';

  @override
  String get conversationMoveMenu => 'Zhvendos…';

  @override
  String get conversationDeletePermanently => 'Fshije përgjithmonë';

  @override
  String get conversationMoveToTrash => 'Zhvendos në kosh';

  @override
  String get conversationNotJunk => 'Jo i padëshiruar';

  @override
  String get conversationShowAllHeaders => 'Shfaq të gjitha kryet';

  @override
  String get conversationViewSource => 'Shih burimin';

  @override
  String get conversationSaveAsFile => 'Ruaje si skedar…';

  @override
  String get conversationShareAsFile => 'Ndaje si skedar…';

  @override
  String get conversationSearchFromMessageMenu => 'Kërko sipas këtij mesazhi…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Kopjo adresën';

  @override
  String get conversationAddressCopied => 'Adresa u kopjua';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Kërko mesazhe nga $name';
  }

  @override
  String get conversationTags => 'Etiketat';

  @override
  String get conversationAllHeaders => 'Të gjitha kryet';

  @override
  String get conversationCopyAll => 'Kopjoji të gjitha';

  @override
  String get conversationHeadersCopied => 'Kryet u kopjuan';

  @override
  String get conversationNoHeaders => 'S’ka krye';

  @override
  String get conversationSearchFromMessageTitle => 'Kërko sipas këtij mesazhi';

  @override
  String conversationSearchFrom(String name) {
    return 'Nga $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Për $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Subjekti “$subject”';
  }

  @override
  String get conversationSourceTitle => 'Burimi';

  @override
  String get conversationSourceCopied => 'Burimi u kopjua';

  @override
  String get conversationShareFailed => 'Mesazhi nuk u nda dot.';

  @override
  String get conversationWrapLines => 'Mbështill rreshtat';

  @override
  String get conversationDontWrapLines => 'Mos i mbështill rreshtat';

  @override
  String get conversationSourceError => 'Burimi nuk u ngarkua dot.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Po shfaqen $shown të parat nga $total. Kopjojeni ose ndajeni për ta marrë të plotë.';
  }

  @override
  String get conversationAttachmentUntitled => 'Pa titull';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Më shumë veprime për $name';
  }

  @override
  String get conversationMoveTo => 'Zhvendos te…';

  @override
  String get conversationMailboxesError => 'Dosjet nuk u ngarkuan dot.';

  @override
  String get conversationReaderReadable => 'E lexueshme';

  @override
  String get conversationReaderOriginal => 'Origjinale';

  @override
  String get conversationReaderPlain => 'Tekst i thjeshtë';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Mbaj ngjyrat origjinale';

  @override
  String get conversationReaderRemember => 'Mbaje mend për këtë dërgues';

  @override
  String get conversationSecurityPossiblePhishing => 'Phishing i mundshëm';

  @override
  String get conversationSecurityBeCareful => 'Kini kujdes';

  @override
  String get conversationSecurityVerified => 'I verifikuar';

  @override
  String get conversationSecurityNoIssues => 'S’u gjet asnjë problem';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gjurmues', one: '1 gjurmues');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Tregon arsyen';

  @override
  String get conversationPhishingBannerTitle => 'Ky mesazh duket si phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Lidhjet dhe imazhet janë çaktivizuar.';
  }

  @override
  String get conversationPhishingBannerText => 'Lidhjet dhe imazhet janë çaktivizuar.';

  @override
  String get conversationPhishingWhy => 'Pse?';

  @override
  String get conversationPhishingShowAnyway => 'Shfaqe sidoqoftë';

  @override
  String get conversationSecurityPhishingTitle => 'Kjo duket si phishing';

  @override
  String get conversationSecurityPhishingText => 'Disa shenja tregojnë se ky mesazh nuk është ai që pretendon të jetë.';

  @override
  String get conversationSecurityCarefulTitle => 'Kini kujdes me këtë mesazh';

  @override
  String get conversationSecurityCarefulText => 'Diçka në të meriton një shikim të dytë.';

  @override
  String get conversationSecurityVerifiedText => 'Dërguesi është i verifikuar dhe asgjë nuk duket e dyshimtë.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Asgjë nuk duket e dyshimtë. Serveri juaj i postës nuk tregoi nëse dërguesi është i verifikuar.';

  @override
  String get conversationSecurityNothingSuspicious => 'Asgjë nuk duket e dyshimtë.';

  @override
  String get conversationSecurityWhy => 'Pse';

  @override
  String get conversationSecurityPrivacy => 'Privatësia';

  @override
  String get conversationSecurityNoTrackingPixels => 'Asnjë piksel gjurmimi';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U hoqën $count piksela gjurmimi',
      one: 'U hoq 1 piksel gjurmimi',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Ata do t’i tregonin dërguesit kur e hapët këtë mesazh.';

  @override
  String get conversationSecurityNoRemoteImages => 'Asnjë imazh i largët';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imazhe të largëta',
      one: '1 imazh i largët',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Ngarkimi i tyre i tregon dërguesit kur e lexoni këtë mesazh, si dhe adresën tuaj IP.';

  @override
  String get conversationSecurityNoClickTracking => 'Pa gjurmim klikimesh';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lidhje përmes gjurmuesve të klikimeve',
      one: '1 lidhje përmes gjurmuesve të klikimeve',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return '$services do ta regjistronin klikimin tuaj. Shtypni gjatë mbi një lidhje për të hapur drejtpërdrejt destinacionin e saj.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Hollësi teknike';

  @override
  String get conversationSecurityCheckedLocally => 'U kontrollua në këtë pajisje. Asgjë nuk u dërgua askund.';

  @override
  String get conversationSecurityTrackersLabel => 'Gjurmues';

  @override
  String get conversationSecurityImagesFrom => 'Imazhe nga';

  @override
  String get conversationSecuritySenderHistory => 'Historiku i dërguesit';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'marrë: $received, dërguar: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Lidhjet çojnë te';

  @override
  String get conversationSecurityHidden => 'Të fshehura';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements elemente', one: '1 element');
    String _temp1 = intl.Intl.pluralLogic(characters, locale: localeName, other: '$characters shenja', one: '1 shenjë');
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Dërgues i paverifikuar';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Serveri juaj i postës nuk mundi të konfirmojë që ky mesazh vjen vërtet nga $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Serveri juaj i postës nuk mundi të konfirmojë që ky mesazh vjen vërtet nga dërguesi i tij.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Serveri juaj i postës nuk mundi të konfirmojë që ky mesazh vjen nga $domain. E zakonshme për listat e postimeve.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Serveri juaj i postës nuk mundi të konfirmojë që ky mesazh vjen nga dërguesi i tij. E zakonshme për listat e postimeve.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Mos veproni sipas tij, përveç nëse e prisnit. Nëse keni dyshime, kontaktoni dërguesin në një mënyrë tjetër.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Nënshkruar nga një domen tjetër';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Mesazhi është nënshkruar nga $signer, jo nga $domain. Shërbimet e postimeve masive e bëjnë këtë, por kjo nuk provon se kush e ka shkruar.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Mesazhi është nënshkruar nga një domen tjetër, jo nga $domain. Shërbimet e postimeve masive e bëjnë këtë, por kjo nuk provon se kush e ka shkruar.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Emri tregon një adresë tjetër';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Emri i dërguesit thotë “$shown”, por mesazhi vjen nga $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Besojini adresës, jo emrit.';

  @override
  String get conversationSecurityReplyToTitle => 'Përgjigjet shkojnë diku tjetër';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Po të përgjigjeni, përgjigja juaj do të shkojë te $address, jo te $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Kontrolloni adresën përpara se të dërgoni diçka personale në përgjigje.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Përdor emrin tuaj';

  @override
  String get conversationSecurityImpersonationTitle => 'Përdor emrin e dikujt që njihni';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Është nënshkruar “$name”, si emri juaj, por vjen nga një adresë e re: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Është nënshkruar “$name”, si kontakti juaj VIP $knownName ($knownEmail), por vjen nga një adresë e re: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Është nënshkruar “$name”, si kontakti juaj $knownName ($knownEmail), por vjen nga një adresë e re: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Dhe përgjigjet do të shkonin në një adresë tjetër akoma.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Nëse kërkon para, kode ose skedarë, verifikojeni fillimisht me personin në një mënyrë tjetër.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Adresa e njohur: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Kjo adresë: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Mesazhi i parë nga ky dërgues';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'S’keni marrë më parë postë nga $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Kini kujdes me kërkesat nga njerëz që s’i njihni ende.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Shkronja të ngjashme në adresën e dërguesit';

  @override
  String get conversationSecurityLinkHomographTitle => 'Shkronja të ngjashme në një lidhje';

  @override
  String conversationSecurityHomographText(String host) {
    return '$host përzien shkronja nga alfabete të ndryshme për të imituar një adresë tjetër.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return '$host përdor shkronja të ngjashme: nuk është $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Fshijeni ose raportojeni si të padëshiruar.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Mos e hapni.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Domeni: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Domen imitues';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Përdor një emër të njohur në domenin e vet';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return '$domain ngjan me domenin tuaj, $real, por është një domen tjetër.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return '$domain ngjan me $brand ($real), por është një domen tjetër.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return '$domain përdor emrin e domenit tuaj, $real, por nuk i përket atij.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return '$domain përdor emrin e $brand ($real), por nuk i përket.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Mesazhet e vërteta nga organizata juaj vijnë nga $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Mesazhet e vërteta nga $brand vijnë nga $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Domeni i dërguesit: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Imiton: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lidhje fshehin se ku të çojnë',
      one: 'Një lidhje fsheh se ku të çon',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Një lidhje tregon $shown, por hap $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Mos hyni në llogari dhe mos paguani përmes këtyre lidhjeve. Shkruajeni vetë adresën.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '“$text” → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Destinacioni i një lidhjeje s’mund të kontrollohet';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Një lidhje tregon $shown, por kalon përmes $host, që e regjistron klikimin përpara se ta përcjellë.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Një lidhje të çon te një adresë IP e zhveshur';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return '$hosts nuk është sajt me emër. Kompanitë e vërteta rrallë vendosin lidhje të tilla.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Një lidhje e maskuar';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Një lidhje fillon me “$shown@” për t’u dukur si $shown, por hap $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Një faqe e fshehur u çaktivizua';

  @override
  String get conversationSecurityDataLinkText =>
      'Një lidhje do të hapte një faqe të paketuar brenda mesazhit, një mënyrë për t’u shmangur kontrolleve të lidhjeve.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Kërkon fjalëkalim';

  @override
  String get conversationSecurityPasswordFieldText => 'Mesazhi përmbante një fushë fjalëkalimi. Loupe e hoqi.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Mos shkruani kurrë fjalëkalim në një email.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Një lidhje që ekzekuton kod u çaktivizua';

  @override
  String get conversationSecurityScriptLinkText => 'Loupe nuk ekzekuton kurrë kod nga mesazhet.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lidhje të shkurtuara',
      one: 'Një lidhje e shkurtuar',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return '$hosts e fsheh destinacionin e vërtetë derisa ta hapni.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Adresë uebi ndërkombëtare';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return '$hosts përdor shkronja jolatine. Normale për shumë gjuhë; kontrolloni që është sajti që prisni.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Shumë tekst i fshehur';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'U hoqën $count shenja teksti të padukshëm. Teksti i fshehur si ky synon të mashtrojë filtrat e postës së padëshiruar.',
      one: 'U hoq 1 shenjë teksti të padukshëm. Teksti i fshehur si ky synon të mashtrojë filtrat e postës së padëshiruar.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'U hoq tekst i fshehur';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U hoqën $count shenja teksti të padukshëm.',
      one: 'U hoq 1 shenjë teksti të padukshëm.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Mesazhi nuk u shkarkua dot. Kontrolloni lidhjen dhe provoni sërish.';

  @override
  String exportSaved(String name) {
    return 'U ruajt “$name”';
  }

  @override
  String get exportSaveFailed => 'Mesazhi nuk u ruajt dot.';

  @override
  String exportFailed(String folder) {
    return '“$folder” nuk u eksportua dot.';
  }

  @override
  String exportEmpty(String folder) {
    return '“$folder” s’ka mesazhe për eksportim.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return '“$folder” nuk u eksportua dot: s’u shkarkua dot asnjë mesazh. Kontrolloni lidhjen dhe provoni sërish.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U ruajt “$name” pa $formattedCount mesazhe që nuk u shkarkuan dot.',
      one: 'U ruajt “$name” pa 1 mesazh që nuk u shkarkua dot.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return '“$name” nuk u ruajt dot.';
  }

  @override
  String exportTitle(String folder) {
    return 'Po eksportohet “$folder”';
  }

  @override
  String get exportListing => 'Po gjenden mesazhet…';

  @override
  String exportProgress(String current, String total) {
    return 'Po eksportohet $current nga $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount mesazhe nuk u shkarkuan dot',
      one: '1 mesazh nuk u shkarkua dot',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Kutitë postare';

  @override
  String get mailboxesShown => 'E shfaqur';

  @override
  String get mailboxesHidden => 'E fshehur';

  @override
  String get mailboxesCollapse => 'Palos';

  @override
  String get mailboxesExpand => 'Hap';

  @override
  String get mailboxesManageVips => 'Menaxho VIP-at';

  @override
  String get mailboxesSubscriptions => 'Abonimet';

  @override
  String mailboxesShowAccount(String account) {
    return 'Shfaq $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Fshih $account';
  }

  @override
  String get mailboxesExportFolder => 'Eksporto dosjen…';

  @override
  String get mailboxesUnpin => 'Shfiksoje';

  @override
  String get mailboxesLists => 'Listat';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Ruani një kërkim për ta mbajtur këtu.';

  @override
  String get mailboxesTags => 'Etiketat';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter =>
      'Mund të prekni gjithashtu emrin e një dërguesi në një mesazh dhe të aktivizoni VIP.';

  @override
  String get mailboxesAddVip => 'Shto VIP…';

  @override
  String get mailboxesAddVipTitle => 'Shto VIP';

  @override
  String get mailboxesAddVipText => 'Posta nga kjo adresë merr një yll dhe shfaqet te kutia postare VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Të palexuara';

  @override
  String get messageListFilterFlagged => 'Me flamurkë';

  @override
  String get messageListFilterToMe => 'Për: mua';

  @override
  String get messageListFilterCcMe => 'CC: mua';

  @override
  String get messageListFilterWithAttachments => 'Me bashkëngjitje';

  @override
  String get messageListFilterUnreplied => 'Pa përgjigje';

  @override
  String get messageListFilterFromVips => 'Nga VIP-at';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesazhe u shënuan si të lexuar',
      one: '1 mesazh u shënua si i lexuar',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Posta më e vjetër nuk u ngarkua dot.';

  @override
  String get messageListSelectMessages => 'Përzgjidh mesazhe';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count të përzgjedhura',
      one: '1 e përzgjedhur',
    );
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Përzgjidhi të gjitha';

  @override
  String get messageListDeselectAll => 'Hiq përzgjedhjen';

  @override
  String get messageListLoadFailed => 'Posta nuk u ngarkua dot';

  @override
  String get messageListNoUnread => 'S’ka postë të palexuar';

  @override
  String get messageListNoMatches => 'S’ka postë që përputhet';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Filtruar sipas: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Çaktivizo filtrin';

  @override
  String get messageListEmpty => 'S’ka postë';

  @override
  String get messageListFilter => 'Filtro';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Kriteret e filtrit: $filters';
  }

  @override
  String get messageListFilteredBy => 'Filtruar sipas:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount të palexuara',
      one: '$formattedCount i palexuar',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Shëno';

  @override
  String get messageListTrash => 'Në kosh';

  @override
  String get messageListFilterTitle => 'Filtri';

  @override
  String get messageListFilterInclude => 'PËRFSHI';

  @override
  String get panesHideMailboxes => 'Fshih kutitë postare';

  @override
  String get panesShowMailboxes => 'Shfaq kutitë postare';

  @override
  String get panesMailboxesWidth => 'Gjerësia e kutive postare';

  @override
  String get panesListWidth => 'Gjerësia e listës së mesazheve';

  @override
  String get panesNoMessageSelected => 'S’është përzgjedhur mesazh';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count mesazhe', one: '1 mesazh');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Të shtyra';

  @override
  String get snoozeSheetTitle => 'Shtyrje';

  @override
  String get snoozeLaterToday => 'Më vonë sot';

  @override
  String get snoozeThisEvening => 'Këtë mbrëmje';

  @override
  String get snoozeTomorrow => 'Nesër';

  @override
  String get snoozeThisWeekend => 'Këtë fundjavë';

  @override
  String get snoozeNextWeek => 'Javën tjetër';

  @override
  String get snoozePickDateTime => 'Zgjidh datë dhe orë…';

  @override
  String get snoozeMenu => 'Shtyje…';

  @override
  String get snoozeWakeNow => 'Ktheje tani';

  @override
  String get snoozeChangeTimeMenu => 'Ndrysho kohën e shtyrjes…';

  @override
  String get snoozeChangeTime => 'Ndrysho kohën';

  @override
  String get snoozeNoTime => 'S’ka kohë të caktuar';

  @override
  String get snoozeFooter => 'Mesazhet e shtyra kthehen te Kutia hyrëse, të palexuara, në kohën e caktuar.';

  @override
  String get snoozeEmptyTitle => 'S’ka gjë të shtyrë';

  @override
  String get snoozeEmptyText => 'Shtyni një mesazh që të kthehet te Kutia hyrëse kur t’ju duhet.';

  @override
  String get appLockUnlock => 'Shkyç';

  @override
  String get appLockFailed => 'Loupe nuk mundi të konfirmojë se jeni ju.';

  @override
  String get appLockLockedOut => 'Shumë përpjekje. Provoni sërish më vonë.';

  @override
  String get appLockPromptError => 'Kërkesa për verifikim nuk u shfaq dot. Provoni sërish.';

  @override
  String get appLockNoScreenLock => 'Ky telefon s’ka kyçje ekrani.';

  @override
  String get appLockUnlockPromptTitle => 'Shkyçni Loupe';

  @override
  String get appLockUnlockPromptReason => 'Konfirmoni se jeni ju për të parë postën tuaj.';

  @override
  String get appLockTurnOnPromptTitle => 'Aktivizoni kyçjen e aplikacionit';

  @override
  String get appLockTurnOnPromptReason => 'Konfirmoni se jeni ju për të aktivizuar kyçjen e aplikacionit.';

  @override
  String get appLockScreenLockRemoved =>
      'Kyçja e aplikacionit është çaktivizuar: ky telefon s’ka më kyçje ekrani. Caktoni një të tillë për ta aktivizuar sërish kyçjen e aplikacionit.';

  @override
  String get appLockAfterImmediately => 'Menjëherë';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuta', one: '1 minutë');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count orë', one: '1 orë');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'I enkriptuar';

  @override
  String get openpgpEncryptedInPart => 'Pjesërisht i enkriptuar';

  @override
  String get openpgpEncryptedLocked => 'I enkriptuar · i kyçur';

  @override
  String get openpgpEncryptedNoKey => 'I enkriptuar · pa çelës';

  @override
  String get openpgpEncryptedDamaged => 'I enkriptuar · i dëmtuar';

  @override
  String get openpgpEncryptedUnsupported => 'I enkriptuar · i pambuluar';

  @override
  String get openpgpUnknownSigner => 'i panjohur';

  @override
  String get openpgpUnknownKey => 'Çelës i panjohur';

  @override
  String get openpgpSignatureInvalid => 'Nënshkrim i pavlefshëm';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Nënshkruar nga $name, jo nga dërguesi';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Nënshkruar pjesërisht nga $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Nënshkruar nga $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Nënshkruar me një çelës të hedhur poshtë';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Nënshkruar nga $name · çelësi s’është pranuar';
  }

  @override
  String get openpgpUnlock => 'Shkyç';

  @override
  String get openpgpCantDecrypt => 'Ky mesazh s’mund të deshifrohet';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Enkriptuar me OpenPGP';

  @override
  String get openpgpEncryption => 'Enkriptimi';

  @override
  String get openpgpDecryptedHere => 'Deshifruar në këtë pajisje';

  @override
  String get openpgpNotDecrypted => 'I padeshifruar';

  @override
  String get openpgpKeyLocked => 'Çelësi juaj është i kyçur.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Për çelësat $keys',
      one: 'Për çelësin $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Subjekt i mbrojtur';

  @override
  String get openpgpUnlockKey => 'Shkyç çelësin';

  @override
  String get openpgpSignature => 'Nënshkrimi';

  @override
  String get openpgpFingerprint => 'Gjurma e gishtit';

  @override
  String openpgpKeyIdValue(String id) {
    return 'ID e çelësit $id';
  }

  @override
  String get openpgpSigned => 'Nënshkruar më';

  @override
  String get openpgpProblem => 'Problemi';

  @override
  String get openpgpAcceptance => 'Pranimi';

  @override
  String get openpgpChangeAcceptance => 'Ndrysho pranimin…';

  @override
  String get openpgpCheckedFooter => 'U kontrollua në këtë pajisje me OpenPGP, në përputhje me Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Çelësi juaj është i kyçur. Shkyçeni me frazëkalimin e tij për ta lexuar këtë mesazh.';

  @override
  String get openpgpSummaryNoSecretKey => 'U enkriptua për një çelës që s’është në këtë pajisje.';

  @override
  String get openpgpSummaryDamaged => 'Të dhënat e enkriptuara janë dëmtuar ose u ndryshuan gjatë rrugës.';

  @override
  String get openpgpSummaryUnsupported => 'Përdor një algoritëm që Loupe nuk e mbulon.';

  @override
  String get openpgpSummaryEncrypted => 'Vetëm ju dhe marrësit e tjerë mund ta lexoni.';

  @override
  String get openpgpSummaryNotSigned => 'Nuk është i nënshkruar, ndaj dërguesi nuk është konfirmuar.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Është i nënshkruar, por me një çelës që s’e keni, ndaj nënshkrimi s’mund të kontrollohet.';

  @override
  String get openpgpSummaryBadSignature => 'Nënshkrimi nuk përputhet: mesazhi mund të jetë ndryshuar.';

  @override
  String get openpgpSummaryMismatch =>
      'Nënshkrimi është i vlefshëm, por çelësi i përket një adrese tjetër nga ajo e dërguesit.';

  @override
  String get openpgpSummaryPartial =>
      'Vetëm një pjesë e mesazhit është e nënshkruar. Teksti jashtë nënshkrimit (për shembull, fundfaqja e një liste postimesh) shfaqet poshtë rreshtit “Unsigned content”, dhe as pjesët e tjera të mesazhit, si bashkëngjitjet, nuk mbulohen.';

  @override
  String get openpgpSummaryOwnKey => 'Nënshkruar me çelësin tuaj.';

  @override
  String get openpgpSummaryVerified =>
      'Nënshkrimi është i vlefshëm dhe e keni verifikuar gjurmën e gishtit të çelësit.';

  @override
  String get openpgpSummaryUnverified =>
      'Nënshkrimi është i vlefshëm. E pranuat çelësin pa e kontrolluar gjurmën e gishtit.';

  @override
  String get openpgpSummaryRejected => 'Nënshkrimi është i vlefshëm, por e keni hedhur poshtë këtë çelës.';

  @override
  String get openpgpSummaryUndecided =>
      'Nënshkrimi është i vlefshëm, por s’e keni pranuar ende këtë çelës. Krahasoni gjurmën e gishtit me dërguesin.';

  @override
  String get openpgpAcceptanceRejected => 'I hedhur poshtë';

  @override
  String get openpgpAcceptanceUndecided => 'I papranuar';

  @override
  String get openpgpAcceptanceUnverified => 'I pranuar';

  @override
  String get openpgpAcceptanceVerified => 'I pranuar dhe i verifikuar';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Të pranohet çelësi i $name?';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Gjurma e gishtit $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Po, e verifikova gjurmën e gishtit';

  @override
  String get openpgpAcceptUnverified => 'Po, pa e kontrolluar';

  @override
  String get openpgpAcceptLater => 'Jo ende';

  @override
  String get openpgpRejectKey => 'Hidhe poshtë këtë çelës';

  @override
  String get openpgpNoSubject => '(pa subjekt)';

  @override
  String get openpgpEncryptionTitle => 'Enkriptim skaj-më-skaj';

  @override
  String get openpgpMyKeys => 'Çelësat e mi OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Me një çelës mund të lexoni postë të enkriptuar dhe të nënshkruani e enkriptoni postën tuaj. Përdorni Thunderbird? Eksportoni çelësin tuaj atje (Rregullime Llogarie › Fshehtëzim Skaj-Më-Skaj › Eksportoni Kyç të Fshehtë) dhe importojeni këtu.';

  @override
  String get openpgpAddKey => 'Shto çelës…';

  @override
  String get openpgpAddresses => 'Adresat';

  @override
  String get openpgpAddressesFooter => 'Cilin çelës përdor secila adresë dhe kur enkripton e nënshkruan.';

  @override
  String get openpgpCorrespondentsKeys => 'Çelësat OpenPGP të korrespondentëve';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Pranojeni një çelës sapo të besoni se i përket pronarit të tij; krahasoni gjurmën e gishtit me të për ta shënuar si të verifikuar.';

  @override
  String get openpgpImportPublicKey => 'Importo çelës publik…';

  @override
  String get openpgpCollected => 'Mbledhur nga Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Çelësa që erdhën me mesazhet. Loupe mund të enkriptojë për ta kur e kërkojnë të dyja palët.';

  @override
  String get openpgpOnThisDevice => 'Në këtë pajisje';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Mesazhet e enkriptuara e fshehin subjektin e tyre. Loupe e ruan subjektin e çdo mesazhi që hapni në bazën e vet të të dhënave të enkriptuar në këtë pajisje, që ta shfaqin lista, kërkimi dhe njoftimet. Në sfond, Loupe mund të deshifrojë edhe subjektet e mesazheve të reja me çelësa pa frazëkalim; për këtë shkarkon çdo mesazh (deri në 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Deshifro subjektet në sfond';

  @override
  String get openpgpIndexFooter =>
      'Kërkimi i gjen mesazhet e enkriptuara sipas dërguesit, marrësve dhe subjektit. Kur kjo është aktive, Loupe shton edhe tekstin e çdo mesazhi të enkriptuar që deshifron në indeksin e kërkimit në bazën e vet të të dhënave të enkriptuar në këtë pajisje, që kërkimi ta gjejë edhe sipas tekstit. Çaktivizimi e heq këtë tekst nga indeksi.';

  @override
  String get openpgpIndexDecrypted => 'Indekso mesazhet e deshifruara për kërkim';

  @override
  String get openpgpPassphrases => 'Frazëkalimet';

  @override
  String get openpgpPassphrasesFooter =>
      'Çelësat OpenPGP dhe certifikatat S/MIME që i mbroni me frazëkalim shkyçen kur duhet. Pa “Mbaj mend frazëkalimet”, ata kyçen sërish dy minuta pas çdo përdorimi.';

  @override
  String get openpgpRememberPassphrases => 'Mbaj mend frazëkalimet';

  @override
  String get openpgpRememberPassphrasesDetail => 'Derisa të mbyllet Loupe';

  @override
  String get openpgpLockKeysNow => 'Kyçi çelësat tani';

  @override
  String get openpgpKeysLocked => 'Çelësat u kyçën.';

  @override
  String get openpgpKeyStateRevoked => 'i shfuqizuar';

  @override
  String get openpgpKeyStateExpired => 'i skaduar';

  @override
  String get openpgpKeyStateNeverExpires => 's’skadon kurrë';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'skadon më $date';
  }

  @override
  String get openpgpNoKey => 'Pa çelës';

  @override
  String get openpgpAlwaysEncrypt => 'Enkripto gjithmonë';

  @override
  String get openpgpAddKeyTitle => 'Shtoni një çelës OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Importoni çelësin që përdorni në Thunderbird ose krijoni një të ri.';

  @override
  String get openpgpImportFromClipboard => 'Importo nga e papastra';

  @override
  String get openpgpImportFromFile => 'Importo nga skedar';

  @override
  String get openpgpGenerateNewKey => 'Krijo çelës të ri';

  @override
  String get openpgpImportPublicKeyTitle => 'Importoni një çelës publik';

  @override
  String get openpgpFromClipboard => 'Nga e papastra';

  @override
  String get openpgpFromFile => 'Nga skedar';

  @override
  String get openpgpClipboardEmpty => 'E papastra është bosh. Kopjoni fillimisht çelësin.';

  @override
  String get openpgpKey => 'Çelësi';

  @override
  String get openpgpValidityRevoked => 'I shfuqizuar';

  @override
  String openpgpValidityExpired(String date) {
    return 'Skadoi më $date';
  }

  @override
  String get openpgpNeverExpires => 'S’skadon kurrë';

  @override
  String openpgpValidUntil(String date) {
    return 'I vlefshëm deri më $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Gjurma e gishtit u kopjua.';

  @override
  String get openpgpAlgorithm => 'Algoritmi';

  @override
  String get openpgpCreated => 'Krijuar më';

  @override
  String get openpgpValidity => 'Vlefshmëria';

  @override
  String get openpgpProtection => 'Mbrojtja';

  @override
  String get openpgpProtectionPassphrase => 'Frazëkalim';

  @override
  String get openpgpProtectionKeychain => 'Vetëm depoja e çelësave';

  @override
  String get openpgpKeyDetailsFooter =>
      'Ndani çelësin tuaj publik që të tjerët t’ju dërgojnë postë të enkriptuar. Kopjeruajtja është çelësi juaj i fshehtë, i mbrojtur me frazëkalimin e tij nëse e ka: mbajeni privat.';

  @override
  String get openpgpSharePublicKey => 'Ndaj çelësin publik';

  @override
  String get openpgpCopyPublicKey => 'Kopjo çelësin publik';

  @override
  String get openpgpPublicKeyCopied => 'Çelësi publik u kopjua.';

  @override
  String get openpgpBackUpSecretKey => 'Kopjeruaj çelësin e fshehtë';

  @override
  String get openpgpDeleteKey => 'Fshi çelësin';

  @override
  String get openpgpRemoveKey => 'Hiq çelësin';

  @override
  String get openpgpBackUpTitle => 'Të kopjeruhet çelësi i fshehtë?';

  @override
  String get openpgpBackUpProtected =>
      'Kopjeruajtja mbrohet nga frazëkalimi i çelësit tuaj. Kushdo që i ka të dyja mund ta lexojë postën tuaj.';

  @override
  String get openpgpBackUpUnprotected =>
      'Ky çelës s’ka frazëkalim: kushdo që ka kopjeruajtjen mund ta lexojë postën tuaj dhe të nënshkruajë në emrin tuaj.';

  @override
  String get openpgpBackUp => 'Kopjeruaje';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Të fshihet çelësi juaj $name?';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Të hiqet çelësi i $name?';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Posta e enkriptuar për këtë çelës s’do të mund të lexohet më në këtë pajisje, veç nëse e importoni sërish.';

  @override
  String get openpgpRemoveKeyMessage => 'Mund ta importoni sërish më vonë.';

  @override
  String get openpgpKeyHeader => 'Çelësi OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Shtoni një çelës te “Enkriptim skaj-më-skaj” për të enkriptuar dhe nënshkruar postën nga kjo adresë.';

  @override
  String get openpgpGenerateAKey => 'Krijo një çelës…';

  @override
  String get openpgpSending => 'Dërgimi';

  @override
  String get openpgpSendingFooter =>
      'Enkriptimi automatik aktivizohet kur çdo marrës ka një çelës të pranuar ose një certifikatë të besuar, ose kur Autocrypt tregon se e duan të dyja palët. Posta e enkriptuar nënshkruhet gjithmonë.';

  @override
  String get openpgpEncryptAutomatically => 'Enkripto automatikisht';

  @override
  String get openpgpAlwaysEncryptDetail => 'Nuk dërgon kur një marrës s’ka çelës';

  @override
  String get openpgpSignUnencrypted => 'Nënshkruaj postën e paenkriptuar';

  @override
  String get openpgpAttachPublicKey => 'Bashkëngjit çelësin tim publik';

  @override
  String get openpgpAutocryptFooter =>
      'Autocrypt e dërgon çelësin tuaj publik me çdo mesazh, që aplikacionet e tjera t’ju dërgojnë postë të enkriptuar pa asnjë konfigurim.';

  @override
  String get openpgpSendMyKey => 'Dërgo çelësin tim me postën';

  @override
  String get openpgpPreferEncryption => 'Parapëlqe enkriptimin';

  @override
  String get openpgpPreferEncryptionDetail => 'U kërkon të tjerëve të enkriptojnë kur munden';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vjet', one: '1 vit');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Frazëkalimet nuk përputhen.';

  @override
  String openpgpKeyReady(String id) {
    return 'Çelësi juaj $id është gati.';
  }

  @override
  String get openpgpNewKey => 'Çelës i ri';

  @override
  String get openpgpNewKeyFor => 'Për';

  @override
  String get openpgpYourName => 'Emri juaj';

  @override
  String get openpgpAddress => 'Adresa';

  @override
  String get openpgpPassphrase => 'Frazëkalimi';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Opsional. Pa të, çelësin e mbron vetëm depoja e çelësave e telefonit tuaj dhe Loupe s’pyet kurrë. Me të, Loupe jua kërkon kur duhet çelësi.';

  @override
  String get openpgpRepeatPassphrase => 'Përsëriteni';

  @override
  String get openpgpExpires => 'Skadimi';

  @override
  String get openpgpExpiresFooter =>
      'Mund të krijoni një çelës të ri para se të skadojë. Edhe Thunderbird përdor tre vjet.';

  @override
  String get openpgpGenerateKey => 'Krijo çelësin';

  @override
  String get openpgpKeyFor => 'Çelës për';

  @override
  String get openpgpCantEncrypt => 'S’mund të enkriptohet';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'S’ka çelës OpenPGP për $names, dhe kjo adresë enkripton gjithmonë. Hiqeni marrësin ose importoni çelësin e tij te Cilësimet › Enkriptim skaj-më-skaj.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'S’ka certifikatë të vlefshme S/MIME për $names, dhe kjo adresë enkripton gjithmonë. Hiqeni marrësin ose importoni certifikatën e tij te Cilësimet › Enkriptim skaj-më-skaj.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'S’ka çelës OpenPGP për $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'S’ka certifikatë të vlefshme S/MIME për $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Dërgoje pa enkriptim';

  @override
  String get openpgpCantSign => 'S’mund të nënshkruhet';

  @override
  String get openpgpCantSignMessage =>
      'Çelësi privat i certifikatës suaj S/MIME s’është në këtë pajisje. Importojeni sërish certifikatën (një skedar .p12 ose .pfx) te Cilësimet › Enkriptim skaj-më-skaj.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'S’ka çelës për $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'S’ka certifikatë për $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Çelësa nga Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Të gjithë kanë çelës';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Të gjithë kanë certifikatë';

  @override
  String get openpgpComposeEncrypt => 'Enkripto';

  @override
  String get openpgpComposeSign => 'Nënshkruaj';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, ndërro';
  }

  @override
  String get openpgpNoKeyFound => 'S’u gjet çelës OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Të importohet një çelës i fshehtë?';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Kjo bashkëngjitje përmban një çelës të fshehtë ($names). Importojeni si çelësin tuaj vetëm nëse e keni eksportuar vetë, për shembull nga Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Importoje si çelësin tim';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'çelësi juaj $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Të importohen $count çelësa ($names)?',
      one: 'Të importohet çelësi i $names?',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Importo dhe prano';

  @override
  String get openpgpImportDecideLater => 'Importo, vendos më vonë';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'çelësi i $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'U importuan: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Janë bashkëngjitur $count çelësa OpenPGP.',
      one: 'Është bashkëngjitur një çelës OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Importo';

  @override
  String get openpgpUnlockKeyTitle => 'Shkyçni çelësin OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Jepni frazëkalimin e çelësit të $name ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Ky frazëkalim është i gabuar. Provoni sërish.';

  @override
  String get openpgpExplainLocked => 'Ky mesazh është i enkriptuar. Shkyçni çelësin tuaj OpenPGP për ta lexuar.';

  @override
  String get openpgpExplainNoKey =>
      'Ky mesazh është i enkriptuar, por jo për ndonjë çelës OpenPGP në këtë pajisje. Nëse e lexoni në Thunderbird, importoni çelësin tuaj prej andej: Cilësimet › Enkriptim skaj-më-skaj.';

  @override
  String get openpgpExplainDamaged =>
      'Ky mesazh i enkriptuar është i dëmtuar, ndaj s’mund të deshifrohet në mënyrë të sigurt.';

  @override
  String get openpgpExplainUnsupported => 'Ky mesazh përdor një enkriptim që Loupe s’e lexon dot ende.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Ky mesazh është i enkriptuar me S/MIME, por jo për ndonjë certifikatë në këtë pajisje. Importoni certifikatën tuaj (një skedar .p12 ose .pfx) te Cilësimet › Enkriptim skaj-më-skaj.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Ky mesazh është i enkriptuar. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Shkyçni certifikatën tuaj S/MIME për ta lexuar.';

  @override
  String get openpgpAttachmentGone => 'Kjo bashkëngjitje s’është më e disponueshme.';

  @override
  String get smimeEncrypted => 'I enkriptuar (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'I enkriptuar (S/MIME) · pa certifikatë';

  @override
  String get smimeEncryptedDamaged => 'I enkriptuar (S/MIME) · i dëmtuar';

  @override
  String get smimeEncryptedUnsupported => 'I enkriptuar (S/MIME) · i pambuluar';

  @override
  String get smimeEncryptedLocked => 'I enkriptuar (S/MIME) · i kyçur';

  @override
  String get smimeUnknownSigner => 'i panjohur';

  @override
  String get smimeSignatureModified => 'Nënshkrim i pavlefshëm: mesazhi është ndryshuar';

  @override
  String get smimeSignatureWeak => 'Nënshkrim i pasigurt: algoritëm i vjetruar';

  @override
  String get smimeSignatureUncheckable => 'Nënshkrimi s’mund të kontrollohet';

  @override
  String get smimeSignedCertificateMissing => 'Nënshkruar · mungon certifikata';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Nënshkruar nga $name · certifikata është shfuqizuar';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Nënshkruar nga $name · në një datë tjetër';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Nënshkruar nga $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Nënshkruar nga $name · certifikatë e pavlefshme';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Nënshkruar nga $name · jo i besuar';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Nënshkruar nga $name · certifikata ka skaduar';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Nënshkruar nga $name · certifikata s’është ende e vlefshme';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Nënshkruar nga $name · certifikata s’është për postë';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Nënshkruar nga $name, jo nga dërguesi';
  }

  @override
  String get smimeCantDecrypt => 'Ky mesazh s’mund të deshifrohet';

  @override
  String get smimeEncryptedWithSmime => 'Enkriptuar me S/MIME';

  @override
  String get smimeEncryption => 'Enkriptimi';

  @override
  String get smimeDecryptedHere => 'Deshifruar në këtë pajisje';

  @override
  String get smimeNotDecrypted => 'I padeshifruar';

  @override
  String get smimeAuthenticated => 'i mirëfilltësuar';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'për $count certifikata',
      one: 'për 1 certifikatë',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Nënshkrimi';

  @override
  String get smimeIssuedBy => 'Lëshuar nga';

  @override
  String get smimeValid => 'E vlefshme';

  @override
  String smimeValidRange(String from, String to) {
    return '$from deri më $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Gjurma e gishtit SHA-256';

  @override
  String get smimeSigned => 'Nënshkruar më';

  @override
  String get smimeProblem => 'Problemi';

  @override
  String get smimeCheckingRevocation => 'Po kontrollohet shfuqizimi…';

  @override
  String get smimeNotRevoked => 'E pashfuqizuar';

  @override
  String get smimeRevoked => 'E shfuqizuar';

  @override
  String get smimeRevocationUnknown => 'Shfuqizimi i panjohur';

  @override
  String smimeRevokedSince(String date) {
    return 'Që më $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'U pyet autoriteti (lista e shfuqizimeve), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'U pyet autoriteti (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Besoji “$name”…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Besoji kësaj certifikate…';

  @override
  String get smimeCheckedFooterRevocation =>
      'U kontrollua në këtë pajisje me S/MIME, në përputhje me Outlook dhe Thunderbird; shfuqizimi u kontrollua te autoriteti i certifikatave.';

  @override
  String get smimeCheckedFooter =>
      'U kontrollua në këtë pajisje me S/MIME, në përputhje me Outlook dhe Thunderbird. Shfuqizimi nuk kontrollohet (Cilësimet › Enkriptim skaj-më-skaj).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'T’i besohet $name për postën?';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'T’i besohet certifikatës së $name?';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Çdo certifikatë që lëshon ky autoritet do të besohet, si me CA-në e kompanisë suaj. Krahasoni fillimisht gjurmën e gishtit me pronarin e saj:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Krahasoni fillimisht gjurmën e gishtit me pronarin e saj:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Besoji';

  @override
  String get smimeSummaryNoKey => 'U enkriptua për një certifikatë që s’është në këtë pajisje.';

  @override
  String get smimeSummaryDamaged => 'Të dhënat e enkriptuara janë dëmtuar ose u ndryshuan gjatë rrugës.';

  @override
  String get smimeSummaryUnsupported => 'Përdor një algoritëm që Loupe nuk e mbulon.';

  @override
  String get smimeSummaryLocked => 'Certifikata juaj S/MIME është e kyçur.';

  @override
  String get smimeSummaryEncrypted => 'Vetëm ju dhe marrësit e tjerë mund ta lexoni.';

  @override
  String get smimeSummaryNotSigned => 'Nuk është i nënshkruar, ndaj dërguesi nuk është konfirmuar.';

  @override
  String get smimeSummaryModified => 'Nënshkrimi nuk përputhet: mesazhi u ndryshua pasi u nënshkrua.';

  @override
  String get smimeSummaryUncheckable => 'Nënshkrimi s’mund të kontrollohet.';

  @override
  String get smimeSummaryNoCertificate => 'Certifikata e nënshkruesit s’është në mesazh, ndaj s’mund të kontrollohet.';

  @override
  String get smimeSummaryRevoked =>
      'Autoriteti i certifikatave e shfuqizoi certifikatën e nënshkruesit: nënshkrimit s’mund t’i besohet.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Autoriteti i certifikatave e shfuqizoi certifikatën e nënshkruesit ($reason): nënshkrimit s’mund t’i besohet.';
  }

  @override
  String get smimeDateMismatch =>
      'U nënshkrua më shumë se një orë larg datës së mesazhit: mund të jetë një mesazh i vjetër i dërguar sërish.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Nënshkrimi është i vlefshëm dhe $issuer garanton se certifikata i përket dërguesit.';
  }

  @override
  String get smimeProblemInvalidChain => 'Certifikata ose një nga lëshuesit e saj është e pavlefshme.';

  @override
  String get smimeProblemUntrusted => 'Certifikata vjen nga një autoritet të cilit Loupe nuk i beson.';

  @override
  String get smimeProblemExpired => 'Certifikata kishte skaduar.';

  @override
  String get smimeProblemNotYetValid => 'Certifikata s’ishte ende e vlefshme.';

  @override
  String get smimeProblemWrongUsage => 'Certifikata s’është menduar për postë.';

  @override
  String get smimeProblemWrongAddress => 'Certifikata i përket një adrese tjetër nga ajo e dërguesit.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'E besuar · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Jo e besuar · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Skadoi më $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'E vlefshme nga $date';
  }

  @override
  String get smimeTrustInvalid => 'E pavlefshme';

  @override
  String get smimeTrustNotForMail => 'Jo për postë';

  @override
  String get smimeTrustAnotherAddress => 'Adresë tjetër';

  @override
  String get smimeMyCertificates => 'Certifikatat e mia S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Për S/MIME, siç e përdorin Outlook dhe shumë kompani. Importoni certifikatën tuaj me çelësin e saj privat (një skedar .p12 ose .pfx), eksportuar nga Outlook, Windows, macOS ose Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Për S/MIME, siç e përdorin Outlook dhe shumë kompani. Importoni certifikatën tuaj me çelësin e saj privat (një skedar .p12 ose .pfx), eksportuar nga Outlook, Windows, macOS ose Thunderbird, ose përdorni një që e keni instaluar ju ose kompania juaj në këtë pajisje.';

  @override
  String get smimeCertificateExpired => 'e skaduar';

  @override
  String smimeCertificateUntil(String date) {
    return 'deri më $date';
  }

  @override
  String get smimeCertificateOnDevice => 'në këtë pajisje';

  @override
  String get smimeImportCertificateEllipsis => 'Importo certifikatë…';

  @override
  String get smimeUseDeviceCertificate => 'Përdor një certifikatë nga kjo pajisje…';

  @override
  String get smimeCorrespondentsCertificates => 'Certifikatat e korrespondentëve';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Mbledhur nga posta e nënshkruar, siç bëjnë Outlook dhe Thunderbird. Posta enkriptohet vetëm për certifikata të besuara: Loupe u beson autoriteteve që u beson Mozilla për email-in, si dhe atyre që shtoni ju.';

  @override
  String get smimeRevocation => 'Shfuqizimi';

  @override
  String get smimeRevocationFooter =>
      'Kur hapni postë të nënshkruar, Loupe e pyet autoritetin që lëshoi certifikatën e nënshkruesit nëse është shfuqizuar (përmes shërbyesit të tij OCSP ose listës së tij të shfuqizimeve). Kështu autoriteti mund të shohë kur dikush nga adresa juaj e internetit lexon postë të nënshkruar me atë certifikatë. Përgjigjet ruhen në këtë pajisje derisa të skadojnë. Një certifikatë e shfuqizuar shfaqet si “certifikata është shfuqizuar” në kryet e mesazhit.';

  @override
  String get smimeCheckRevocation => 'Kontrollo shfuqizimin e certifikatave në internet';

  @override
  String get smimeTrustedAuthorities => 'Autoritete të besuara';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Të besuara nga ju, përveç $count autoriteteve që u beson Mozilla për email-in.',
      one: 'Të besuara nga ju, përveç 1 autoriteti që i beson Mozilla për email-in.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Autoritet certifikatash';

  @override
  String get smimeImportACertificate => 'Importoni një certifikatë';

  @override
  String get smimeImportContactMessage =>
      'Certifikata e një korrespondenti (.cer, .crt, .pem) ose e një autoriteti certifikatash.';

  @override
  String get smimeFromClipboard => 'Nga e papastra';

  @override
  String get smimeFromFile => 'Nga skedar';

  @override
  String get smimeClipboardEmpty => 'E papastra është bosh. Kopjoni fillimisht certifikatën.';

  @override
  String get smimeCertificate => 'Certifikata';

  @override
  String get smimeOnDeviceFooter =>
      'Çelësi i saj privat mbetet në depon e kredencialeve të Android, ku e keni instaluar ju ose kompania juaj: Loupe i kërkon Android-it të nënshkruajë dhe deshifrojë me të. Posta e nënshkruar nënshkruhet kur e dërgoni.';

  @override
  String get smimeAddresses => 'Adresat';

  @override
  String get smimeUsage => 'Për';

  @override
  String get smimeUsageNone => 'Asgjë që përdor Loupe';

  @override
  String get smimeUsageSigning => 'Nënshkrim';

  @override
  String get smimeUsageEncryption => 'Enkriptim';

  @override
  String get smimeUsageCertificates => 'Certifikata';

  @override
  String get smimeAlgorithm => 'Algoritmi';

  @override
  String get smimeSerialNumber => 'Numri serial';

  @override
  String get smimeFingerprintCopied => 'Gjurma e gishtit u kopjua.';

  @override
  String get smimeSha1Thumbprint => 'Gjurma SHA-1';

  @override
  String get smimePrivateKey => 'Çelësi privat';

  @override
  String get smimeKeyOnDevice => 'Në këtë pajisje';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Në Loupe, me frazëkalim';

  @override
  String get smimeKeyInLoupe => 'Në Loupe';

  @override
  String get smimeSource => 'Burimi';

  @override
  String get smimeSourceSignedMail => 'Postë e nënshkruar';

  @override
  String get smimeSourceImported => 'I importuar';

  @override
  String get smimeTrustHeader => 'Besimi';

  @override
  String get smimeTrustedRoot => 'Rrënjë e besuar';

  @override
  String get smimeIssuer => 'Lëshuesi';

  @override
  String smimeTrustNamed(String name) {
    return 'Besoji “$name”';
  }

  @override
  String get smimeTrustThisAuthority => 'Besoji këtij autoriteti';

  @override
  String get smimeTrustThisCertificate => 'Besoji kësaj certifikate';

  @override
  String get smimeStopTrusting => 'Mos i beso më';

  @override
  String get smimePassphrase => 'Frazëkalimi';

  @override
  String get smimePassphraseFooter =>
      'Opsional. Me frazëkalim, çelësi privat enkriptohet edhe në këtë pajisje (Argon2id dhe AES-256), dhe Loupe jua kërkon për të nënshkruar e deshifruar; “Mbaj mend frazëkalimet” përcakton për sa kohë. Posta që dërgoni nënshkruhet gjatë dërgimit; punët në sfond s’mund ta përdorin çelësin.';

  @override
  String get smimeChangePassphrase => 'Ndrysho frazëkalimin…';

  @override
  String get smimeSetPassphraseEllipsis => 'Cakto frazëkalim…';

  @override
  String get smimeRemovePassphrase => 'Hiq frazëkalimin';

  @override
  String get smimeShareCertificate => 'Ndaj certifikatën';

  @override
  String get smimeDeleteCertificate => 'Fshi certifikatën';

  @override
  String get smimeRemoveCertificate => 'Hiq certifikatën';

  @override
  String get smimePassphraseChanged => 'Frazëkalimi u ndryshua.';

  @override
  String get smimePassphraseSet => 'Frazëkalimi u caktua.';

  @override
  String get smimeRemovePassphraseTitle => 'Të hiqet frazëkalimi?';

  @override
  String get smimeRemovePassphraseMessage =>
      'Atëherë çelësin privat e mbron vetëm depoja e çelësave, si pa frazëkalim: Loupe s’jua kërkon më dhe punët në sfond mund ta përdorin.';

  @override
  String get smimePassphraseRemoved => 'Frazëkalimi u hoq.';

  @override
  String smimeTrustTitle(String name) {
    return 'T’i besohet $name?';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Çdo certifikatë që lëshon do të besohet për postën. Krahasoni fillimisht gjurmën e gishtit me pronarin e saj:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Të fshihet certifikata juaj $name?';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Të hiqet certifikata e $name?';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Loupe ndalon së përdoruri: posta e enkriptuar për të s’mund të lexohet më në Loupe. Certifikata mbetet në këtë pajisje (Cilësimet › Siguria › Enkriptimi dhe kredencialet).';

  @override
  String get smimeDeleteOwnMessage =>
      'Çelësi i saj privat fshihet nga kjo pajisje: posta e enkriptuar për të s’mund të lexohet më këtu, veç nëse e importoni sërish.';

  @override
  String get smimeRemoveContactMessage => 'Rikthehet me mesazhin e ardhshëm të nënshkruar prej tyre.';

  @override
  String get smimeAddressImportFooter =>
      'Importoni një certifikatë për këtë adresë që të nënshkruani dhe enkriptoni me S/MIME, siç bën Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Importo një certifikatë…';

  @override
  String get smimePreferFooter =>
      'Kur të dy mund ta mbrojnë një mesazh, përdoret ai i parapëlqyer, përveç nëse vetëm tjetri ka çelës ose certifikatë për çdo marrës.';

  @override
  String get smimePreferSmime => 'Parapëlqe S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Në vend të OpenPGP';

  @override
  String get smimeCertificatePassword => 'Fjalëkalimi i certifikatës';

  @override
  String get smimeCertificatePasswordPrompt => 'Jepni fjalëkalimin me të cilin u eksportua skedari i certifikatës.';

  @override
  String get smimeImport => 'Importo';

  @override
  String get smimeWrongPassword => 'Ky fjalëkalim është i gabuar. Provoni sërish.';

  @override
  String get smimeNoCertificateFound => 'S’u gjet certifikatë.';

  @override
  String smimeCertificateOf(String name) {
    return 'certifikata e $name';
  }

  @override
  String get smimeNothingNew => 'S’ka asgjë të re për importim.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'U importuan: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U importuan $count autoritete të besuara.',
      one: 'U importua një autoritet i besuar.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U importuan $certificates dhe $count autoritete të besuara.',
      one: 'U importuan $certificates dhe një autoritet i besuar.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Ky skedar s’ka çelës privat. Eksportojeni certifikatën tuaj bashkë me çelësin e saj privat.';

  @override
  String get smimeImportAsYoursTitle => 'Të importohet si certifikata juaj?';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Kjo bashkëngjitje përmban një certifikatë me çelësin e saj privat: $names. Importojeni vetëm nëse e keni eksportuar vetë, për shembull nga Outlook ose Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Importoje si certifikatën time';

  @override
  String smimeImportedOwn(String names) {
    return 'U importua certifikata juaj $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'U shtua certifikata juaj $name ($addresses) nga kjo pajisje.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'T’i besohet “$name” për postën?';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Loupe nuk e njeh këtë autoritet certifikatash (ndoshta është i vetë një kompanie). Besojini që të kontrollohen certifikatat që lëshon. Krahasoni fillimisht gjurmën e gishtit me departamentin tuaj të IT-së:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Janë bashkëngjitur $count certifikata.',
      one: 'Është bashkëngjitur një certifikatë.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Importo certifikatën';

  @override
  String get smimeUnlockTitle => 'Shkyçni certifikatën S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Jepni frazëkalimin e certifikatës së $name ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Ky frazëkalim është i gabuar. Provoni sërish.';

  @override
  String get smimeUnlock => 'Shkyç';

  @override
  String get smimeEnterAPassphrase => 'Jepni një frazëkalim.';

  @override
  String get smimePassphrasesDiffer => 'Dy frazëkalimet ndryshojnë.';

  @override
  String get smimeSetPassphraseTitle => 'Caktoni frazëkalim';

  @override
  String get smimeSetPassphraseText =>
      'Loupe do jua kërkojë për të nënshkruar e deshifruar. Nëse e harroni, importojeni sërish certifikatën nga skedari i saj .p12.';

  @override
  String get smimePassphraseAgain => 'Sërish';

  @override
  String get smimeSetPassphraseButton => 'Cakto';

  @override
  String get smimeLockedOpenAgain => 'Certifikata juaj S/MIME është e kyçur. Hapeni sërish mesazhin për ta shkyçur.';

  @override
  String get smimeDeviceHasNoCertificates => 'Kjo pajisje nuk i ofron certifikatat e saj.';

  @override
  String get smimeCantReadCertificate => 'Loupe s’e lexon dot këtë certifikatë.';

  @override
  String get smimeCertificateNotForMail =>
      'Kjo certifikatë s’është për postë: s’ka adresë email-i ose s’është menduar për nënshkrim apo enkriptim.';

  @override
  String get smimeDeviceCertificateGone =>
      'Certifikata s’është më në këtë pajisje, ose Loupe ndoshta s’ka më leje ta përdorë. Zgjidheni sërish te Cilësimet › Enkriptim skaj-më-skaj.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Certifikata në këtë pajisje mund të përdoret vetëm ndërsa Loupe është i hapur.';

  @override
  String get smimeDeviceKeyDamaged => 'Çelësi i enkriptuar është i dëmtuar.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Certifikata në këtë pajisje s’mund ta bëjë këtë: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'nuk mbulohet';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Certifikata në këtë pajisje dështoi: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Adresa e autoritetit s’është adresë uebi.';

  @override
  String get smimeAuthorityTimeout => 'Autoriteti i certifikatave nuk u përgjigj në kohë.';

  @override
  String get smimeAuthorityUnreachable => 'Autoriteti i certifikatave s’u arrit dot.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Autoriteti i certifikatave u përgjigj me $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Përgjigjja e autoritetit të certifikatave është shumë e madhe.';

  @override
  String get smimeRevocationNotChecked =>
      'S’u kontrollua: kontrollohen vetëm certifikatat nga autoritete që Loupe u beson.';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSystem => 'Si telefoni';

  @override
  String get settingsLanguageFooter =>
      'Loupe përdor gjuhën e telefonit tuaj kur e ka, ndryshe anglishten. Gjuha që zgjidhni këtu vlen vetëm për Loupe, përfshirë njoftimet.';

  @override
  String get settingsAccountsHeader => 'Llogaritë';

  @override
  String get settingsAddAccount => 'Shto llogari';

  @override
  String get settingsMailHeader => 'Posta';

  @override
  String get settingsSwipeActions => 'Veprimet me rrëshqitje';

  @override
  String get settingsSwipeLeft => 'Rrëshqitje majtas';

  @override
  String get settingsSwipeLeftFooter =>
      'Një rrëshqitje e plotë e kryen këtë veprim. “Vër flamurkë” dhe “Më shumë” janë gjithmonë një rrëshqitje e shkurtër larg.';

  @override
  String get settingsSwipeRight => 'Rrëshqitje djathtas';

  @override
  String get settingsSwipeRightFooter => 'Një rrëshqitje e plotë e kryen këtë veprim.';

  @override
  String get settingsSwipeToggleRead => 'Shëno si të lexuar / të palexuar';

  @override
  String get settingsSwipeTrash => 'Në kosh';

  @override
  String get settingsSwipeMove => 'Zhvendos mesazhin';

  @override
  String get settingsSwipeSnooze => 'Shtyje';

  @override
  String get settingsThreaded => 'Organizo sipas bisedave';

  @override
  String get settingsUndoSendDelay => 'Vonesa për zhbërjen e dërgimit';

  @override
  String get settingsUndoSendDelayFooter => 'Mesazhet e dërguara presin kaq gjatë, që t’i tërhiqni dot.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(seconds, locale: localeName, other: '$seconds sekonda', one: '1 sekondë');
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Pamja';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Automatike';

  @override
  String get settingsThemeLight => 'E çelët';

  @override
  String get settingsThemeDark => 'E errët';

  @override
  String get settingsDensity => 'Lista e mesazheve';

  @override
  String get settingsDensityComfortable => 'E rehatshme';

  @override
  String get settingsDensityCompact => 'Kompakte';

  @override
  String get settingsReadingHeader => 'Leximi';

  @override
  String get settingsReadingFooter => 'Imazhet e largëta mund t’u tregojnë dërguesve kur dhe ku e hapët një mesazh.';

  @override
  String get settingsDefaultView => 'Pamja parazgjedhje';

  @override
  String get settingsDefaultViewFooter => 'Mund ta ndërroni pamjen e çdo mesazhi me butonin Aa.';

  @override
  String get settingsViewReadable => 'E lexueshme';

  @override
  String get settingsViewReadableDetail => 'E pastër, e qartë, ndjek mënyrën e errët';

  @override
  String get settingsViewOriginal => 'Origjinale';

  @override
  String get settingsViewOriginalDetail => 'Saktësisht siç e projektoi dërguesi';

  @override
  String get settingsViewPlain => 'Tekst i thjeshtë';

  @override
  String get settingsViewPlainDetail => 'Vetëm fjalët';

  @override
  String get settingsPlainTextFont => 'Shkronjat e tekstit të thjeshtë';

  @override
  String get settingsFontSans => 'Sans Serif';

  @override
  String get settingsFontMono => 'Me gjerësi fikse';

  @override
  String get settingsFontMonoDetail => 'I mban të radhitura vizatimet ASCII dhe tabelat';

  @override
  String get settingsTechnicalLists => 'Listat teknike';

  @override
  String get settingsLoadRemoteImages => 'Ngarko imazhet e largëta';

  @override
  String get settingsOpenLinksDirectly => 'Hap lidhjet drejtpërdrejt';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Anashkalo gjurmuesit e klikimeve kur destinacioni dihet';

  @override
  String get settingsSecurityHeader => 'Siguria';

  @override
  String get settingsAppLock => 'Kyçja e aplikacionit';

  @override
  String get settingsAppLockFooterOn =>
      'Loupe pyet kur niset dhe kur riktheheni pasi keni qenë larg më shumë se koha te “Kyç pas”.';

  @override
  String get settingsAppLockFooterOff =>
      'Kyçja e aplikacionit kërkon gjurmën e gishtit, fytyrën ose kyçjen e ekranit përpara se të shfaqet posta juaj.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Kyçja e aplikacionit është ende joaktive. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Caktoni një kod kalimi';

  @override
  String get settingsScreenLockTextIos =>
      'Kyçja e aplikacionit përdor Face ID, Touch ID ose kodin tuaj të kalimit, dhe ky iPhone s’ka kod kalimi. Caktoni një te aplikacioni Settings, pastaj aktivizoni kyçjen e aplikacionit.';

  @override
  String get settingsScreenLockTitleAndroid => 'Caktoni një kyçje ekrani';

  @override
  String get settingsScreenLockTextAndroid =>
      'Kyçja e aplikacionit përdor kyçjen e ekranit të telefonit tuaj, ose një gjurmë gishti a fytyrë të shtuar në të, dhe ky telefon s’ka asnjë. Caktoni një PIN, motiv ose fjalëkalim te cilësimet e Android-it, pastaj aktivizoni kyçjen e aplikacionit.';

  @override
  String get settingsOpenSystemSettings => 'Hap cilësimet';

  @override
  String get settingsOpenAndroidSettings => 'Hap cilësimet e Android-it';

  @override
  String get settingsLockAfter => 'Kyç pas';

  @override
  String get settingsLockAfterFooter => 'Sa gjatë mund të jetë Loupe në sfond përpara se të pyesë sërish.';

  @override
  String get settingsNotifications => 'Njoftimet';

  @override
  String get settingsEncryption => 'Enkriptim skaj-më-skaj';

  @override
  String get settingsAdvanced => 'Të avancuara';

  @override
  String get settingsDemoHeader => 'Demo';

  @override
  String get settingsDemoFooter =>
      'Posta demo është një kuti postare e sajuar që ekziston vetëm në këtë telefon. Asgjë nuk dërgohet askund.';

  @override
  String get settingsDemoMode => 'Mënyra demo';

  @override
  String get settingsResetApp => 'Rikthe aplikacionin në fillim';

  @override
  String get settingsResetFooter => 'Harron të gjitha cilësimet dhe kthehet te ekrani i mirëseardhjes.';

  @override
  String get settingsResetTitle => 'Të rikthehet Loupe në fillim?';

  @override
  String get settingsResetMessage =>
      'Kjo harron çdo cilësim, Smart Mailbox dhe kërkim të fundit, dhe kthehet te ekrani i mirëseardhjes.';

  @override
  String get settingsAboutHeader => 'Rreth';

  @override
  String get settingsVersion => 'Versioni';

  @override
  String get settingsLicences => 'Licencat';

  @override
  String get settingsPrivacy => 'Privatësia';

  @override
  String get settingsPrivacyDetail =>
      'Loupe s’ka analitikë dhe s’bën gjurmim. Posta juaj shkon vetëm te serverët tuaj të postës.';

  @override
  String get settingsNotificationsOffIos => 'Njoftimet për Loupe janë çaktivizuar te Settings.';

  @override
  String get settingsNotificationsOffAndroid => 'Njoftimet për Loupe janë çaktivizuar te cilësimet e Android-it.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return '$system nuk e lejon Loupe të shfaqë njoftime. Lejojini te cilësimet.';
  }

  @override
  String get settingsNewMailHeader => 'Posta e re';

  @override
  String get settingsNewMailFooterDemo =>
      'Posta demo nuk vjen në sfond. Dërgoni një njoftim provë për të parë si duket posta e re.';

  @override
  String get settingsNewMailFooterIos =>
      'Loupe kontrollon për postë të re në sfond kur e lejon iOS, gjë që për aplikacionet që s’i hapni shpesh mund të ndodhë me orë diferencë. Njoftoheni për mesazhet e reja në kutitë tuaja hyrëse dhe nga VIP-at në çdo dosje.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Loupe kontrollon për postë të re afërsisht çdo 15 minuta, kur e lejon Android. Njoftoheni për mesazhet e reja në kutitë tuaja hyrëse dhe nga VIP-at në çdo dosje.';

  @override
  String get settingsNoAccounts => 'S’ka llogari';

  @override
  String get settingsVipOnly => 'Vetëm VIP';

  @override
  String get settingsVipOnlyDetail => 'Vetëm mesazhet nga VIP-at tuaj';

  @override
  String get settingsHideContent => 'Fshih përmbajtjen';

  @override
  String get settingsHideContentFooterOn =>
      'Njoftimet thonë vetëm “Mesazh i ri nga” dhe llogarinë, jo kush shkroi apo për çfarë.';

  @override
  String get settingsHideContentFooterOff =>
      '“Fshih përmbajtjen” e mban dërguesin, subjektin dhe paraparjen larg ekranit të kyçjes dhe njoftimeve.';

  @override
  String get settingsBackgroundAppRefresh => 'Background App Refresh';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Posta e re vjen në sfond vetëm kur Background App Refresh është aktiv për Loupe te Settings. iOS nuk mund ta mbajë të hapur një lidhje me kutitë tuaja hyrëse, ndaj s’ka “Dorëzim i menjëhershëm”.';

  @override
  String get settingsInstantDelivery => 'Dorëzim i menjëhershëm';

  @override
  String get settingsInstantDeliveryFooter =>
      '“Dorëzim i menjëhershëm” (eksperimental) mban të hapur një lidhje me kutitë tuaja hyrëse, që posta e re të vijë brenda pak sekondash. Shfaq një njoftim të qetë “Në pritje të postës së re” dhe harxhon më shumë bateri.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Android mund ta ndalë “Dorëzim i menjëhershëm” për të kursyer bateri. Lejojeni Loupe të përdorë baterinë pa kufizime, që të vazhdojë të punojë.';

  @override
  String get settingsExperimental => 'Eksperimentale';

  @override
  String get settingsComingSoon => 'Së shpejti';

  @override
  String get settingsAllowUnrestrictedBattery => 'Lejo përdorim të pakufizuar të baterisë';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Push-i bën që posta e re ta zgjojë Loupe menjëherë, kur shërbimi juaj i postës e mbulon. Push-et kalojnë përmes shërbimit të push-eve të Google dhe nuk mbartin postë, vetëm një “kontrollo tani”.';

  @override
  String get settingsPushUnavailableFooter =>
      'Ky telefon s’mund të marrë push-e: duhen shërbimet Google Play dhe një lidhje me rrjetin. Loupe vazhdon të kontrollojë për postë afërsisht çdo 15 minuta.';

  @override
  String get settingsCopyPushToken => 'Kopjo token-in e push-it';

  @override
  String get settingsPushTokenCopied => 'Token-i i push-it u kopjua';

  @override
  String get settingsSendTestNotification => 'Dërgo njoftim provë';

  @override
  String get settingsAppIconBadge => 'Distinktivi i ikonës';

  @override
  String get settingsBadgeNote => 'Distinktivi përditësohet sa herë që Loupe kontrollon për postë, edhe në sfond.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Ekrani bazë i këtij telefoni nuk shfaq numra mbi ikonat e aplikacioneve. Distinktivi përditësohet sa herë që Loupe kontrollon për postë, edhe në sfond.';

  @override
  String get settingsTestNotificationBody => 'Njoftimet për postë të re duken kështu.';

  @override
  String get settingsAccountRemoved => 'Kjo llogari u hoq.';

  @override
  String get settingsAccountHeader => 'Llogaria';

  @override
  String get settingsAccountDescription => 'Përshkrimi';

  @override
  String get settingsAccountDescriptionHint => 'Punë, Personale…';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsColour => 'Ngjyra';

  @override
  String get settingsColourFooter => 'Shënon mesazhet e kësaj llogarie te “Të gjitha kutitë hyrëse”.';

  @override
  String settingsColourNumber(int number) {
    return 'Ngjyra $number';
  }

  @override
  String get settingsSendingHeader => 'Dërgimi';

  @override
  String get settingsSendingFooter =>
      'Çdo identitet ka nënshkrimin e vet. Përgjigjet dërgohen nga adresa ku u dërgua mesazhi.';

  @override
  String get settingsFoldersHeader => 'Dosjet';

  @override
  String get settingsFoldersFooter =>
      'Loupe shfaq dhe sinkronizon dosjet në të cilat jeni pajtuar, siç bën Thunderbird. Kutia hyrëse, Skica, Të dërguara, Të padëshiruara, Koshi dhe Arkivi shfaqen gjithmonë.';

  @override
  String get settingsShowAllFolders => 'Shfaq të gjitha dosjet';

  @override
  String get settingsIncoming => 'Hyrëse';

  @override
  String get settingsOutgoing => 'Dalëse';

  @override
  String get settingsConnectionNotEncrypted => 'Pa enkriptim';

  @override
  String get settingsSignIn => 'Hyrja';

  @override
  String get settingsSignInExpired => 'Ka skaduar';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return '$provider s’e pranon më hyrjen e Loupe për këtë llogari, ndaj posta e saj s’po sinkronizohet. Hyni sërish për ta ndrequr.';
  }

  @override
  String get settingsSignInAgain => 'Hyni sërish';

  @override
  String get settingsSigningIn => 'Po hyhet…';

  @override
  String get settingsRemoveAccount => 'Hiq llogarinë';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Të hiqet “$account”?';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Posta dhe cilësimet e saj hiqen nga ky telefon. Asgjë nuk fshihet në server.';

  @override
  String get settingsManageFolders => 'Menaxho dosjet';

  @override
  String get settingsNoFolders => 'Ende s’ka dosje.';

  @override
  String get settingsManageFoldersFooter =>
      'Dosjet ku jeni pajtuar shfaqen në ekranin Kutitë postare dhe sinkronizohen në sfond. Aplikacionet e tjera të postës në të njëjtën llogari zakonisht i ndjekin edhe ato këto pajtime.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Ruan Smart Mailboxes për pajisjet tuaja të tjera. E fshehur në ekranin Kutitë postare.';

  @override
  String get settingsFolderAlwaysShown => 'Shfaqet gjithmonë';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Pajtohu në $folder';
  }

  @override
  String get settingsIdentities => 'Identitetet';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Identiteti i parë është parazgjedhja për mesazhet e reja. Tërhiqeni për të ndryshuar radhën.';

  @override
  String get settingsIdentitiesFooterSingle => 'Identiteti parazgjedhje për mesazhet e reja.';

  @override
  String get settingsIdentitiesReplyFooter => 'Një përgjigje dërgohet nga identiteti ku u dërgua mesazhi.';

  @override
  String get settingsIdentityDefault => 'Parazgjedhje';

  @override
  String settingsIdentityReorder(String email) {
    return 'Ndrysho radhën e $email';
  }

  @override
  String get settingsAddIdentity => 'Shto identitet';

  @override
  String get settingsNewIdentity => 'Identitet i ri';

  @override
  String get settingsIdentity => 'Identiteti';

  @override
  String get settingsIdentityNameHint => 'Emri juaj';

  @override
  String get settingsReplyTo => 'Përgjigju te';

  @override
  String get settingsSignature => 'Nënshkrimi';

  @override
  String get settingsSignatureFooter => 'Shtohet poshtë “-- ” në mesazhet nga ky identitet.';

  @override
  String get settingsNoSignature => 'Pa nënshkrim';

  @override
  String get settingsCopyToMyself => 'Kopje për veten';

  @override
  String get settingsCopyToMyselfFooter => 'Shtohet në çdo mesazh nga ky identitet.';

  @override
  String get settingsCc => 'Cc';

  @override
  String get settingsBcc => 'Bcc';

  @override
  String get settingsReplyPatterns => 'Përdore për përgjigjet te';

  @override
  String get settingsReplyPatternsFooter =>
      'Përgjigjet ndaj mesazheve të dërguara te këto adresa dërgohen nga ky identitet. * do të thotë çfarëdo: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Një adresë, ose një model ku * do të thotë çfarëdo.';

  @override
  String get settingsAddReplyPattern => 'Shto adresë ose model';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Hiq $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Model i pavlefshëm';

  @override
  String settingsInvalidPatternMessage(String input) {
    return '“$input” s’është adresë ose model si *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'S’ka adresë';

  @override
  String get settingsIdentityNoAddressMessage => 'Jepni adresën email nga e cila do të dërgohet.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Adresë e pavlefshme';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': '“$address” te “Përgjigju te” s’është adresë email e vlefshme.',
      'cc': '“$address” te Cc s’është adresë email e vlefshme.',
      'bcc': '“$address” te Bcc s’është adresë email e vlefshme.',
      'other': '“$address” s’është adresë email e vlefshme.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Ruaj identitetin';

  @override
  String get settingsDiscardChanges => 'Hidhi poshtë ndryshimet';

  @override
  String get settingsDeleteIdentity => 'Fshi identitetin';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Të fshihet “$email”?';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Mesazhet e dërguara tashmë prej tij mbeten siç janë.';

  @override
  String get settingsLastIdentityFooter => 'Një llogari ka nevojë për të paktën një identitet.';

  @override
  String get rulesTitle => 'Rregullat';

  @override
  String get rulesNewRule => 'Rregull i ri';

  @override
  String get rulesLoadError => 'Rregullat nuk u ngarkuan dot.';

  @override
  String get rulesEmptyTitle => 'S’ka rregulla';

  @override
  String get rulesEmptyText =>
      'Rregullat e vendosin postën e re në dosje, e etiketojnë dhe i vënë flamurkë për ju. Krijoni një me butonin e hartimit sipër, ose nga një kërkim me “Bëje rregull”.';

  @override
  String get rulesListFooter =>
      'Rregullat zbatohen nga lart poshtë mbi postën e re te Kutia hyrëse. Prekni dhe mbani të shtypur një rregull për ta zhvendosur.';

  @override
  String get rulesChangeError => 'Rregulli nuk u ndryshua dot';

  @override
  String get rulesConditionEveryMessage => 'Çdo mesazh';

  @override
  String rulesMoveRule(String rule) {
    return 'Zhvendos $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule aktiv';
  }

  @override
  String get rulesServerRulesHeader => 'Rregullat e serverit';

  @override
  String get rulesServerRulesFooter =>
      'Rregullat e serverit zbatohen në serverin e postës kur mbërrin posta, edhe kur ky telefon është i fikur. Ruhen në një skript Sieve me emrin “loupe”.';

  @override
  String get rulesStatusUnknown => 'E panjohur';

  @override
  String get rulesStatusError => 'Serveri nuk u pyet dot.';

  @override
  String get rulesStatusChecking => 'Po kontrollohet…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Zbatohen nga “$script”.';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return '“$script” është skripti aktiv. Prekeni që të zbatojë edhe rregullat e Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'S’ka skript aktiv në server. Ruajtja e një rregulli serveri aktivizon skriptin e Loupe.';

  @override
  String get rulesStatusUnavailable => 'Jo i disponueshëm';

  @override
  String get rulesStatusNoSieve => 'Serveri i kësaj llogarie nuk ofron Sieve (ManageSieve ose JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Zhvendos te $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Zhvendos te një dosje';

  @override
  String rulesActionTag(String tag) {
    return 'Etiketo me $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Hiq etiketën $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Mbaje te Kutia hyrëse';

  @override
  String rulesActionForward(String address) {
    return 'Përcill te $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Përcill te $address, pa mbajtur kopje';
  }

  @override
  String get rulesActionStop => 'Ndal';

  @override
  String get rulesNoActions => 'Ende s’bën asgjë';

  @override
  String get rulesLocationDevice => 'Pajisje';

  @override
  String get rulesLocationServer => 'Server';

  @override
  String get rulesLocationThisDevice => 'Kjo pajisje';

  @override
  String get rulesNewRuleTitle => 'Rregull i ri';

  @override
  String get rulesEditRuleTitle => 'Redakto rregullin';

  @override
  String get rulesDefaultNameEveryMessage => 'Çdo mesazh';

  @override
  String get rulesConditionHeader => 'Kur një mesazh i ri përputhet me';

  @override
  String get rulesConditionFooter =>
      'Shkruajeni siç do të kërkonit: from:, to:, s: (subjekti), b: (teksti), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:faturë';

  @override
  String get rulesAccounts => 'Llogaritë';

  @override
  String get rulesAllAccounts => 'Të gjitha llogaritë';

  @override
  String get rulesRemovedAccount => 'Llogari e hequr';

  @override
  String get rulesAccountsFooter => 'Një rregull për të gjitha llogaritë mbulon edhe llogaritë që shtoni më vonë.';

  @override
  String get rulesActionsHeader => 'Atëherë';

  @override
  String get rulesForwardingFooter =>
      'Përcjellja dërgon çdo mesazh që përputhet në një adresë tjetër sapo mbërrin, edhe kur ky telefon është i fikur. Disa ofrues kufizojnë sa postë mund të përcillet.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Përcjellja funksionon vetëm në rregullat e serverit, ndaj këtu është lënë jashtë.';

  @override
  String rulesRemoveAction(String action) {
    return 'Hiq “$action”';
  }

  @override
  String get rulesAddAction => 'Shto veprim';

  @override
  String get rulesAddMove => 'Zhvendos te dosja…';

  @override
  String get rulesAddTagMenu => 'Shto etiketë…';

  @override
  String get rulesRemoveTagMenu => 'Hiq etiketë…';

  @override
  String get rulesAddForward => 'Përcill te…';

  @override
  String get rulesStopProcessing => 'Ndal përpunimin me rregulla të tjera';

  @override
  String get rulesRunOnHeader => 'Zbatoje në';

  @override
  String get rulesRunOnDeviceFooter =>
      'Kjo pajisje e zbaton rregullin mbi postën e re te Kutia hyrëse sa herë që Loupe kontrollon për postë.';

  @override
  String get rulesRunOnServerFooter =>
      'Serveri i postës e zbaton rregullin kur mbërrin posta, edhe kur ky telefon është i fikur. Kërkon Sieve, përmes ManageSieve (Dovecot, mailcow) ose JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Zbatoje te mesazhet ekzistuese…';

  @override
  String get rulesDeleteRule => 'Fshi rregullin';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Të fshihet “$rule”?';
  }

  @override
  String get rulesMoveAccountTitle => 'Dosje në cilën llogari?';

  @override
  String get rulesMoveAccountMessage => 'Posta e llogarive të tjera shkon te dosja me të njëjtin emër atje.';

  @override
  String get rulesAddTag => 'Shto etiketë';

  @override
  String get rulesRemoveTag => 'Hiq etiketë';

  @override
  String get rulesForwardTo => 'Përcill te';

  @override
  String get rulesForwardToMessage =>
      'Serveri e përcjell çdo mesazh që përputhet te kjo adresë, edhe kur ky telefon është i fikur. Përdorni një adresë që e keni ose që i besoni.';

  @override
  String get rulesNotAnAddressTitle => 'S’është adresë email';

  @override
  String rulesNotAnAddressMessage(String address) {
    return '“$address” s’është adresë ku mund të përcillet.';
  }

  @override
  String get rulesKeepCopyTitle => 'Të mbahet një kopje këtu?';

  @override
  String get rulesKeepCopy => 'Mbaj një kopje';

  @override
  String get rulesDontKeepCopy => 'Mos mbaj kopje';

  @override
  String get rulesCheckCondition => 'Kontrolloni kushtin';

  @override
  String get rulesChooseActionTitle => 'Zgjidhni një veprim';

  @override
  String get rulesChooseActionMessage => 'Shtoni se çfarë bën rregulli me mesazhet që përputhen.';

  @override
  String get rulesSaveError => 'Rregulli nuk u ruajt dot';

  @override
  String get rulesSaveServerError => 'Rregulli i serverit nuk u ruajt dot';

  @override
  String get rulesRunOnDeviceInstead => 'Zbatoje në këtë pajisje';

  @override
  String get rulesNothingToApplyTitle => 'S’ka ç’të zbatohet';

  @override
  String get rulesNothingToApplyMessage => 'Jepini fillimisht rregullit një kusht që funksionon dhe një veprim.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Zbato “$rule” te mesazhet në…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Kutitë hyrëse';

  @override
  String get rulesApplyScopeAll => 'Të gjitha kutitë postare';

  @override
  String get rulesFindingMessages => 'Po gjenden mesazhet…';

  @override
  String get rulesSearchError => 'Kërkimi dështoi';

  @override
  String get rulesSearchErrorUnknown => 'Diçka shkoi keq.';

  @override
  String get rulesNoMatchesTitle => 'S’përputhet asnjë mesazh';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Asgjë atje nuk përputhet me “$condition”.';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Të zbatohet “$rule” te $countString mesazhe?',
      one: 'Të zbatohet “$rule” te $countString mesazh?',
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
      other: 'Zbatoje te $countString mesazhe',
      one: 'Zbatoje te $countString mesazh',
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
      other: '“$rule” u zbatua te $countString mesazhe',
      one: '“$rule” u zbatua te $countString mesazh',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Po pyetet serveri se çfarë mund të bëjë…';

  @override
  String get rulesServerUnreachable => 'Serveri s’u arrit dot.';

  @override
  String rulesServerProblem(String problem) {
    return 'S’mund të zbatohet në server: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'S’mund të zbatohet në serverin e $account: $problem';
  }

  @override
  String get rulesShowScript => 'Shfaq skriptin';

  @override
  String get rulesHideScript => 'Fshih skriptin';

  @override
  String get rulesMatchingHeader => 'Mesazhet që përputhen';

  @override
  String get rulesMatchingHeaderLoading => 'Mesazhet që përputhen…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString mesazhe që përputhen',
      one: '$countString mesazh që përputhet',
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
      other: '$countString+ mesazhe që përputhen',
      one: '$countString+ mesazh që përputhet',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Nga 30 ditët e fundit. Vetë rregulli vepron vetëm mbi postën e re, përveç nëse e zbatoni te mesazhet ekzistuese.';

  @override
  String rulesConditionError(String error) {
    return 'Kushti ka një gabim: $error';
  }

  @override
  String get rulesPreviewNoSender => '(pa dërgues)';

  @override
  String get rulesPreviewNoSubject => '(pa subjekt)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dhe $countString të tjera',
      one: 'dhe $countString tjetër',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Asgjë nga 30 ditët e fundit.';

  @override
  String get rulesIncludeTitle => 'Aktivizoni rregullat e serverit';

  @override
  String get rulesIncludeLeaveOff => 'Lëri joaktive';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Serveri i zbaton tashmë rregullat e Loupe për $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return '“$script” është skripti aktiv në serverin e $account, ndaj serveri zbaton atë dhe jo rregullat e Loupe. Loupe nuk do ta zëvendësojë. Mund t’i shtojë këto rreshta, dhe atëherë serveri zbaton rregullat e Loupe pas atyre të vetë skriptit:';
  }

  @override
  String get rulesShowWholeScript => 'Shfaq gjithë skriptin';

  @override
  String get rulesHideWholeScript => 'Fshih gjithë skriptin';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Asgjë tjetër në “$script” nuk ndryshon. Nëse filtrat e tij redaktohen më vonë në webmail, webmail-i mund ta rishkruajë pa këto rreshta; atëherë Loupe i shfaq sërish rregullat e serverit si joaktive.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Shto te “$script”';
  }

  @override
  String get subscriptionsTitle => 'Abonimet';

  @override
  String get subscriptionsNewsletters => 'Buletinet';

  @override
  String get subscriptionsDiscussions => 'Diskutimet';

  @override
  String get subscriptionsFilter => 'Filtro';

  @override
  String get subscriptionsFilterNeverRead => 'S’lexohen kurrë';

  @override
  String get subscriptionsFilterRarelyRead => 'Lexohen rrallë';

  @override
  String get subscriptionsFilterAll => 'Të gjitha';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Abonimet nuk u numëruan dot';

  @override
  String get subscriptionsNoMatches => 'S’ka përputhje';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Asnjë buletin nuk quhet “$text”.';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Asnjë listë nuk quhet “$text”.';
  }

  @override
  String get subscriptionsNoNewsletters => 'S’ka buletine';

  @override
  String get subscriptionsNoNewslettersDetail => 'Buletinet dhe posta tjetër masive shfaqen këtu sapo të mbërrijnë.';

  @override
  String get subscriptionsNothingNeverRead => 'S’ka gjë që s’lexohet kurrë';

  @override
  String get subscriptionsNothingRarelyRead => 'S’ka gjë që lexohet rrallë';

  @override
  String get subscriptionsNothingFilteredDetail => 'Lexoni pak nga gjithçka që merrni.';

  @override
  String get subscriptionsNoDiscussions => 'S’ka diskutime';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Listat e postimeve ku mund të shkruani shfaqen këtu sapo të mbërrijë posta e tyre.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Lista ku shkruajnë disa njerëz. Prekni dhe mbani të shtypur njërën për ta fiksuar te Kutitë postare, për ta lexuar si tekst të thjeshtë ose për ta zhvendosur te Buletinet.';

  @override
  String get subscriptionsPrivacyNote =>
      'Numëruar në këtë telefon nga posta që ka shkarkuar; asgjë nuk dërgohet askund për këtë. Loupe kontakton një dërgues vetëm kur prekni “Çabonohu”: çabonimi me një prekje dërgon vetëm “List-Unsubscribe=One-Click” te adresa që dha dërguesi, pa cookies dhe pa asgjë tjetër për ju, dhe s’ngarkon kurrë faqet apo imazhet e tij.';

  @override
  String get subscriptionsVolumeNone => 'Asgjë së fundi';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / muaj';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / muaj';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'lexuar $percent';
  }

  @override
  String get subscriptionsStillSending => 'Vazhdon të dërgojë';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Çabonuar më $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Faqja e çabonimit u hap më $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Një prekje · kontakton $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Me email te $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Në sajtin $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Çabonohu';

  @override
  String get subscriptionsUnsubscribeAgain => 'Çabonohu sërish';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Arkivo $countString te Kutia hyrëse');
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Krijo rregull…';

  @override
  String get subscriptionsCreateRuleDetail => 'Zhvendos ose arkivo postën e tij të ardhshme';

  @override
  String get subscriptionsTreatAsDiscussion => 'Trajtoje si diskutim';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Një listë ku shkruajnë njerëz: lexojeni si forum';

  @override
  String get subscriptionsTreatAsNewsletter => 'Trajtoje si buletin';

  @override
  String get subscriptionsBlockSender => 'Blloko dërguesin';

  @override
  String get subscriptionsBlock => 'Blloko';

  @override
  String get subscriptionsBlocked => 'I bllokuar';

  @override
  String get subscriptionsBlockedDetail => 'Posta e re shkon te Të padëshiruara';

  @override
  String get subscriptionsPin => 'Fiksoje te Kutitë postare';

  @override
  String get subscriptionsUnpin => 'Shfiksoje nga Kutitë postare';

  @override
  String get subscriptionsOpenDefaultView => 'Hape në pamjen parazgjedhje';

  @override
  String get subscriptionsOpenPlainText => 'Hape si tekst të thjeshtë (Mono)';

  @override
  String get subscriptionsPinned => 'E fiksuar';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString të palexuar',
      one: '$countString i palexuar',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Tani s’ka postë nga ky dërgues.';

  @override
  String get subscriptionsLatestMessages => 'MESAZHET E FUNDIT';

  @override
  String get subscriptionsMail => 'Posta';

  @override
  String get subscriptionsNoneIn90Days => 'Asnjë në 90 ditë';

  @override
  String get subscriptionsRead => 'Lexuar';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString nga $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Marrë së fundi';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Dosjet', one: 'Dosja');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Vazhdon të dërgojë';

  @override
  String get subscriptionsUnsubscribedTitle => 'Çabonuar';

  @override
  String subscriptionsSince(String date) {
    return 'që më $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'faqja u hap më $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return '$sender nuk tregon si të çabonoheni.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return '$sender nuk tregon si të çabonoheni. Mund ta bllokoni në vend të kësaj.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Po çabonoheni nga $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'U çabonuat nga $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Çabonimi dështoi: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Çabonimi automatik dështoi';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Dërgo email çabonimi';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Hap $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Të hapet $site?';
  }

  @override
  String get subscriptionsOpen => 'Hape';

  @override
  String subscriptionsWebExplanation(String sender) {
    return '$sender e bën çabonimin në sajtin e vet. Faqja hapet në shfletuesin e Loupe; përfundojeni atje.';
  }

  @override
  String get subscriptionsWebInsecure => 'Lidhja me këtë sajt s’është e enkriptuar.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Kujdes: kjo adresë imiton $site me shkronja të ngjashme.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Kujdes: kjo adresë imiton një sajt tjetër me shkronja të ngjashme.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return '$site nuk u hap dot.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Loupe shënon datën e sotme dhe ju njofton nëse $sender vazhdon të shkruajë.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Të çabonoheni nga $sender?';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Loupe do të kontaktojë $site për çabonimin.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Kjo është e vetmja herë që Loupe kontakton sajtin e një dërguesi. Dërgon vetëm “List-Unsubscribe=One-Click” te adresa që dha $sender, pa cookies apo ndonjë gjë tjetër për ju, dhe nuk e ngarkon faqen.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Lidhja e çabonimit s’është adresë e sigurt në internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return '$site nuk u përgjigj në kohë.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return '$site s’u arrit dot.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return '$site e kaloi kërkesën te një faqe tjetër, të cilën Loupe nuk e ndjek.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return '$site e refuzoi kërkesën (gabim $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'S’ka llogari nga e cila të dërgohet email-i i çabonimit.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Loupe do të dërgojë një email te $to nga $from, me subjektin “$subject”.';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Email-i i çabonimit u dërgua te $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Të bllokohet $sender?';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Posta e re nga kjo listë shkon te Të padëshiruara. Mund ta ndryshoni këtë te Cilësimet › Rregullat.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Posta e re nga $address shkon te Të padëshiruara. Mund ta ndryshoni këtë te Cilësimet › Rregullat.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return '$sender u bllokua.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Zhvendos $count te Të padëshiruara');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Blloko $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return '$sender tani është te Buletinet.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return '$sender tani është te Diskutimet.';
  }

  @override
  String get appLiveGateTitle => 'Llogaritë tuaja nuk u hapën dot';

  @override
  String get appLiveGateUnavailableBuild => 'Llogaritë e vërteta ende s’janë të disponueshme në këtë version.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Loupe nuk e lexoi dot çelësin që mbron postën tuaj në këtë telefon. Shpesh kjo është e përkohshme: provoni sërish ose rinisni telefonin.';

  @override
  String get appLiveGateKeyMissing =>
      'Çelësi që mbron postën tuaj në këtë telefon ka humbur, gjë që mund të ndodhë pas rikthimit të një kopjeruajtjeje. Posta juaj është ende në server.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Baza e të dhënave të postës në këtë telefon s’mund të lexohet: është dëmtuar ose i ka ndryshuar çelësi. Posta juaj është ende në server.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Diçka shkoi keq gjatë hapjes së llogarive tuaja ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Kjo fshin llogaritë tuaja dhe postën e ruajtur në këtë telefon, përfshirë mesazhet që presin te Kutia dalëse. Posta në serverët tuaj nuk preket; shtojini sërish llogaritë më pas.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Fshi dhe fillo nga e para';

  @override
  String get appLiveGateUseDemo => 'Përdor postën demo';

  @override
  String get appLiveGateReset => 'Rikthe postën në këtë telefon…';

  @override
  String get attachmentsUntitled => 'Bashkëngjitje';

  @override
  String get attachmentsUntitledFile => 'Pa titull';

  @override
  String get attachmentsOpenIn => 'Hape me…';

  @override
  String get attachmentsSaveToFiles => 'Ruaje në pajisje';

  @override
  String get attachmentsShareMenu => 'Ndaj…';

  @override
  String get attachmentsDownloadError => 'Bashkëngjitja nuk u shkarkua dot. Kontrolloni lidhjen dhe provoni sërish.';

  @override
  String get attachmentsShareError => 'Bashkëngjitja nuk u nda dot.';

  @override
  String attachmentsNoApp(String type) {
    return 'S’ka aplikacion në këtë pajisje që e hap këtë skedar ($type). Provoni “Ndaj”.';
  }

  @override
  String get attachmentsOpenInError => 'Bashkëngjitja nuk u hap dot në një aplikacion tjetër.';

  @override
  String attachmentsSaved(String name) {
    return 'U ruajt “$name”';
  }

  @override
  String get attachmentsSaveError => 'Bashkëngjitja nuk u ruajt dot.';

  @override
  String get attachmentsGone => 'Kjo bashkëngjitje s’është më e disponueshme.';

  @override
  String get attachmentsDownloadFailed => 'Bashkëngjitja nuk u shkarkua dot.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count faqe', one: '1 faqe');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size me të dhëna celulare';
  }

  @override
  String get attachmentsLargeDownload => 'Kjo bashkëngjitje është e madhe. Shkarkojeni tani, ose më vonë me Wi-Fi.';

  @override
  String get attachmentsDownload => 'Shkarko';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Po shkarkohen $size…';
  }

  @override
  String get attachmentsDownloading => 'Po shkarkohet…';

  @override
  String get attachmentsTooLarge => 'Shumë e madhe për paraparje këtu.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Po shfaqen $shown të parat nga $total. Kopjojeni, ndajeni ose ruajeni për ta marrë të plotë.';
  }

  @override
  String get attachmentsPdfUnavailable => 'Ky PDF s’mund të shfaqet këtu (mund të jetë i mbrojtur me fjalëkalim).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page nga $count';
  }

  @override
  String get attachmentsModeTable => 'Tabelë';

  @override
  String get attachmentsModeText => 'Tekst';

  @override
  String get attachmentsModeMessage => 'Mesazh';

  @override
  String get attachmentsModeSource => 'Burim';

  @override
  String get attachmentsDontWrap => 'Mos i mbështill rreshtat';

  @override
  String get attachmentsWrap => 'Mbështill rreshtat';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines rreshta', one: '$lines rresht');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Kopjoji të gjitha';

  @override
  String get attachmentsCopied => 'U kopjua';

  @override
  String get attachmentsImageUnavailable => 'Ky imazh s’mund të shfaqet këtu. Provoni “Hape me…”.';

  @override
  String get attachmentsEmlNoSubject => '(Pa subjekt)';

  @override
  String get attachmentsEmlFrom => 'Nga';

  @override
  String get attachmentsEmlTo => 'Për';

  @override
  String get attachmentsEmlCc => 'Cc';

  @override
  String get attachmentsEmlDate => 'Data';

  @override
  String get attachmentsEmlNoText => 'Ky mesazh s’ka tekst.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Bashkëngjitje: $names');
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
      other: 'Dhe $count ngjarje të tjera',
      one: 'Dhe 1 ngjarje tjetër',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Imazh';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Imazh $format';
  }

  @override
  String get attachmentsTypePdf => 'Dokument PDF';

  @override
  String get attachmentsTypeTsv => 'Vlera të ndara me tabulacion';

  @override
  String get attachmentsTypeCsv => 'Fletë llogaritëse CSV';

  @override
  String get attachmentsTypeCalendar => 'Ngjarje kalendari';

  @override
  String get attachmentsTypeEmail => 'Mesazh email';

  @override
  String get attachmentsTypeContact => 'Kartë kontakti';

  @override
  String get attachmentsTypeLog => 'Skedar regjistri';

  @override
  String get attachmentsTypeText => 'Tekst';

  @override
  String get attachmentsTypeZip => 'Arkiv ZIP';

  @override
  String get attachmentsTypeArchive => 'Arkiv';

  @override
  String get attachmentsTypeWord => 'Dokument Word';

  @override
  String get attachmentsTypeExcel => 'Fletë llogaritëse Excel';

  @override
  String get attachmentsTypePowerPoint => 'Prezantim PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Faqe uebi';

  @override
  String get attachmentsTypeVideo => 'Video';

  @override
  String get attachmentsTypeAudio => 'Audio';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Skedar $extension';
  }

  @override
  String get attachmentsTypeFile => 'Skedar';

  @override
  String get calendarUntitledEvent => 'Ngjarje';

  @override
  String get calendarAllDay => 'Gjithë ditën';

  @override
  String calendarYourTime(String time) {
    return '$time sipas orës suaj';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Bashkohu: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name e pranoi: $details',
      'tentative': '$name e pranoi me rezervë: $details',
      'declined': '$name e refuzoi: $details',
      'delegated': '$name ia delegoi dikujt tjetër: $details',
      'other': '$name nuk është përgjigjur për: $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name e pranoi ftesën',
      'tentative': '$name e pranoi ftesën me rezervë',
      'declined': '$name e refuzoi ftesën',
      'delegated': '$name ia delegoi ftesën dikujt tjetër',
      'other': '$name nuk i është përgjigjur ftesës',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Hartë';

  @override
  String get calendarJoin => 'Bashkohu';

  @override
  String get calendarOnlineMeeting => 'Takim në internet';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Takim $provider';
  }

  @override
  String get calendarOrganizerYou => 'Ju';

  @override
  String get calendarOrganizerLabel => 'organizator';

  @override
  String get calendarStatusAccepted => 'Pranuar';

  @override
  String get calendarStatusMaybe => 'Ndoshta';

  @override
  String get calendarStatusDeclined => 'Refuzuar';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pranoi',
      'tentative': '$name pranoi me rezervë',
      'declined': '$name refuzoi',
      'delegated': '$name e delegoi',
      'other': '$name nuk u përgjigj',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name pranoi:',
      'tentative': '$name pranoi me rezervë:',
      'declined': '$name refuzoi:',
      'delegated': '$name e delegoi:',
      'other': '$name nuk u përgjigj:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '“$comment”';
  }

  @override
  String calendarCounter(String name) {
    return '$name propozon një orë të re';
  }

  @override
  String get calendarCounterUnknown => 'Një pjesëmarrës propozon një orë të re';

  @override
  String get calendarDeclineCounter => 'Organizatori e mbajti orën';

  @override
  String calendarRefresh(String name) {
    return '$name kërkon versionin më të fundit';
  }

  @override
  String get calendarRefreshUnknown => 'Një pjesëmarrës kërkon versionin më të fundit';

  @override
  String get calendarCancelled => 'Anuluar';

  @override
  String get calendarCancelledByOrganizer => 'Organizatori e anuloi këtë ngjarje.';

  @override
  String get calendarCancelledLater => 'Kjo ngjarje u anulua më vonë.';

  @override
  String get calendarOutdated => 'E vjetruar';

  @override
  String get calendarOutdatedDetail => 'Kjo ftesë u përditësua më vonë; vlen ajo më e reja.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Vendndodhja u hoq (ishte $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Vendndodhja u hoq (s’kishte)';

  @override
  String calendarLocationChanged(String location) {
    return 'Vendndodhja u ndryshua në $location';
  }

  @override
  String get calendarNewTitle => 'Titull i ri';

  @override
  String get calendarRepeatChanged => 'Përsëritja ndryshoi';

  @override
  String get calendarUpdated => 'Përditësuar';

  @override
  String get calendarUpdatedInvitation => 'Ftesë e përditësuar';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Ora ndryshoi nga $before në $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Zona kohore “$zone” e panjohur: orët siç janë shkruar';
  }

  @override
  String calendarNext(String when) {
    return 'Tjetra: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count të ftuar', one: '1 i ftuar');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pranuan', one: '1 pranoi');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ndoshta');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count refuzuan', one: '1 refuzoi');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (ju)';
  }

  @override
  String get calendarAttendeeOptional => 'opsional';

  @override
  String get calendarAttendeeRoom => 'sallë';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Pranuat një version të mëparshëm.',
      'tentative': 'Pranuat me rezervë një version të mëparshëm.',
      'declined': 'Refuzuat një version të mëparshëm.',
      'delegated': 'Ia deleguat dikujt tjetër një version të mëparshëm.',
      'other': 'Nuk iu përgjigjët një versioni të mëparshëm.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Prano';

  @override
  String get calendarMaybe => 'Ndoshta';

  @override
  String get calendarDecline => 'Refuzo';

  @override
  String get calendarCommentHint => 'Koment për organizatorin (opsional)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Përgjigja juaj shkon te $organizer nga $address.';
  }

  @override
  String get calendarAddComment => 'Shto një koment';

  @override
  String get calendarAddToCalendar => 'Shto në kalendar';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dhe $count ngjarje të tjera në skedar',
      one: 'Dhe 1 ngjarje tjetër në skedar',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'S’ka aplikacion kalendari ku të shtohet ngjarja.';

  @override
  String get calendarCantOpenCalendar => 'Kalendari nuk u hap dot.';

  @override
  String get calendarCantOpenLink => 'Lidhja nuk u hap dot.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Të bashkoheni në takimin $provider?';
  }

  @override
  String get calendarJoinTitle => 'Të bashkoheni në takim?';

  @override
  String calendarJoinOpens(String host) {
    return 'Hap $host në shfletuesin tuaj.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Kujdes: kjo adresë imiton $site me shkronja të ngjashme.';
  }

  @override
  String get calendarJoinHomographUnknown => 'Kujdes: kjo adresë imiton një sajt tjetër me shkronja të ngjashme.';

  @override
  String calendarJoinOpen(String host) {
    return 'Hap $host';
  }

  @override
  String get calendarNoOrganizer => 'Kjo ftesë s’ka organizator të cilit t’i përgjigjeni.';

  @override
  String get calendarNoAccount => 'S’ka llogari nga e cila të përgjigjeni.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Pranuar', 'tentative': 'Ndoshta', 'other': 'Refuzuar'});
    return '$_temp0 · po dërgohet përgjigja te $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Pranuar', 'tentative': 'Ndoshta', 'other': 'Refuzuar'});
    return '$_temp0 · përgjigja u dërgua';
  }

  @override
  String get calendarReplyAlreadySent => 'Përgjigja është dërguar tashmë.';

  @override
  String get calendarReplyNotSent => 'Përgjigja nuk u dërgua.';

  @override
  String get dataSmimeNeedsDevice =>
      'Certifikata juaj S/MIME është në këtë pajisje: hapni Loupe për ta nënshkruar dhe dërguar këtë mesazh.';

  @override
  String dataSigningFailed(String error) {
    return 'Nënshkrimi dështoi: $error';
  }

  @override
  String get keyboardShortcuts => 'Shkurtoret e tastierës';

  @override
  String get keyboardGroupGeneral => 'Të përgjithshme';

  @override
  String get keyboardGroupMessages => 'Mesazhet';

  @override
  String get keyboardGroupCompose => 'Hartimi';

  @override
  String get keyboardCommandPalette => 'Paleta e komandave';

  @override
  String get keyboardBackClose => 'Prapa, mbyll';

  @override
  String get keyboardNextMessage => 'Mesazhi tjetër';

  @override
  String get keyboardPreviousMessage => 'Mesazhi i mëparshëm';

  @override
  String get keyboardOpenMessage => 'Hap mesazhin';

  @override
  String get keyboardMoveToTrash => 'Zhvendos në kosh';

  @override
  String get keyboardToggleRead => 'Shëno si të lexuar ose të palexuar';

  @override
  String get keyboardToggleFlag => 'Vër ose hiq flamurkën';

  @override
  String get keyboardCloseDraft => 'Mbyll (ruaj ose fshi skicën)';

  @override
  String get keyboardOr => 'ose';

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
  String get mailingListsMuted => 'Rrjedha u heshtua. Mesazhet e reja në të vijnë si të lexuara.';

  @override
  String get mailingListsUnmuted => 'Rrjedhës iu hoq heshtja.';

  @override
  String get mailingListsMuteThread => 'Heshtoje rrjedhën';

  @override
  String get mailingListsUnmuteThread => 'Hiqi heshtjen rrjedhës';

  @override
  String get mailingListsPin => 'Fiksoje te Kutitë postare';

  @override
  String get mailingListsUnpin => 'Shfiksoje nga Kutitë postare';

  @override
  String get mailingListsDefaultView => 'Hape në pamjen parazgjedhje';

  @override
  String get mailingListsPlainText => 'Hape si tekst të thjeshtë (Mono)';

  @override
  String get mailingListsShowMuted => 'Shfaq rrjedhat e heshtura';

  @override
  String get mailingListsHideMuted => 'Fshih rrjedhat e heshtura';

  @override
  String get mailingListsTreatAsNewsletter => 'Trajtoje si buletin';

  @override
  String get mailingListsOptions => 'Opsionet e listës';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted të palexuar',
      one: '$formatted i palexuar',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Mesazh i ri në listë';

  @override
  String get mailingListsRowUnread => 'E palexuar';

  @override
  String get mailingListsRowMuted => 'E heshtur';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count përgjigje', one: '1 përgjigje');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'S’ka rrjedha';

  @override
  String get mailingListsMutedHidden => 'Rrjedhat e heshtura janë fshehur.';

  @override
  String get mailingListsTechnicalTitle => 'Listat teknike';

  @override
  String get mailingListsTechnicalEmpty => 'Listat e postimeve shfaqen këtu sapo të mbërrijë posta e tyre.';

  @override
  String get mailingListsTechnicalFooter =>
      'Mesazhet nga këto lista hapen si tekst i thjeshtë me shkronja me gjerësi fikse, me patch-et të shfaqura si diff. Butoni Aa vazhdon ta ndërrojë pamjen e çdo mesazhi.';

  @override
  String get paletteMoveToMailbox => 'Zhvendos te kutia postare…';

  @override
  String get paletteMarkAllRead => 'Shënoji të gjitha si të lexuara';

  @override
  String get paletteExportFolder => 'Eksporto dosjen…';

  @override
  String get paletteGetNewMail => 'Merr postën e re';

  @override
  String get paletteSnoozed => 'Të shtyra';

  @override
  String get paletteSubscriptions => 'Abonimet';

  @override
  String get paletteDiscussions => 'Diskutimet';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Listë postimesh';

  @override
  String get paletteTag => 'Etiketë';

  @override
  String get paletteSwipeActions => 'Veprimet me rrëshqitje';

  @override
  String get paletteNotifications => 'Njoftimet';

  @override
  String get paletteRules => 'Rregullat';

  @override
  String get paletteEncryption => 'Enkriptim skaj-më-skaj';

  @override
  String get paletteAdvanced => 'Të avancuara';

  @override
  String get paletteAddAccount => 'Shto llogari';

  @override
  String get paletteAccount => 'Llogari';

  @override
  String get paletteFolders => 'Dosjet';

  @override
  String get paletteRecentSearch => 'Kërkim i fundit';

  @override
  String paletteSearchMail(String query) {
    return 'Kërko në postë për “$query”';
  }

  @override
  String get palettePlaceholder => 'Kërkoni veprime, kuti postare, cilësime';

  @override
  String get paletteNothingFound => 'S’u gjet asgjë';

  @override
  String get searchNewSmartMailbox => 'Smart Mailbox i ri';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Shfaq gjithçka që përputhet me “$query”.';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return '“$name” u ruajt te Kutitë postare';
  }

  @override
  String get searchMakeRule => 'Bëje rregull';

  @override
  String get searchSaveSmartMailbox => 'Ruaje si Smart Mailbox';

  @override
  String get searchNegate => 'Mohoje';

  @override
  String get searchDontNegate => 'Mos e moho';

  @override
  String get searchAllMailboxes => 'Të gjitha kutitë postare';

  @override
  String get searchRecent => 'Kërkimet e fundit';

  @override
  String get searchClear => 'Pastro';

  @override
  String get searchSuggestions => 'Sugjerime';

  @override
  String get searchUnreadMessages => 'Mesazhe të palexuara';

  @override
  String get searchFlaggedMessages => 'Mesazhe me flamurkë';

  @override
  String get searchWithAttachments => 'Mesazhe me bashkëngjitje';

  @override
  String get searchUnrepliedMessages => 'Mesazhe pa përgjigje';

  @override
  String get searchTags => 'Etiketat';

  @override
  String get searchPeople => 'Njerëzit';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Nga: $name';
  }

  @override
  String get searchSearching => 'Po kërkohet…';

  @override
  String get searchNoResults => 'S’ka përfundime';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted përfundime',
      one: '$formatted përfundim',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Menuja e kërkimit';

  @override
  String searchSearchingAccount(String account) {
    return 'Po kërkohet në $account në server…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Po kërkohet në llogari në server…';

  @override
  String searchAccountFailed(String account) {
    return 'Kërkimi në $account në server dështoi';
  }

  @override
  String get searchUnknownAccountFailed => 'Kërkimi në llogari në server dështoi';

  @override
  String searchChip(String term) {
    return '$term. Prekni dy herë për ta redaktuar.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Jo $term. Prekni dy herë për ta redaktuar.';
  }

  @override
  String get searchReadAndUnread =>
      'Kutia hyrëse e Shrëdingerit: çdo mesazh këtu është njëkohësisht i lexuar dhe i palexuar, derisa ta hapni.';

  @override
  String searchContradiction(String term) {
    return 'Asnjë mesazh s’mund të jetë njëkohësisht “$term” dhe jo.';
  }

  @override
  String get searchSyncDeviceOnly => 'Vetëm në këtë pajisje';

  @override
  String searchSyncUnsupported(String account) {
    return 'Vetëm në këtë pajisje: $account s’mund ta mbajë';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Pa sinkronizim: $account ka një format më të ri';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Në pritje të sinkronizimit me $account';
  }

  @override
  String searchSynced(String account) {
    return 'Sinkronizuar me $account';
  }

  @override
  String get searchRename => 'Riemërto';

  @override
  String get searchEditSearch => 'Redakto kërkimin';

  @override
  String get searchDeleteSmartMailbox => 'Fshi Smart Mailbox-in';

  @override
  String get searchRenameSmartMailbox => 'Riemërto Smart Mailbox-in';

  @override
  String get searchSmartMailboxDeleted => 'Ky Smart Mailbox u fshi.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Smart Mailboxes mbeten në këtë pajisje.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Smart Mailboxes ruhen në serverin tuaj të postës, që t’i kenë edhe pajisjet tuaja të tjera, si dhe Thunderbird me Expression Search Reloaded. Ato që kërkojnë në çdo llogari ruhen te $account; ato të një dosjeje, te llogaria e asaj dosjeje.';
  }

  @override
  String get searchSyncVia => 'Sinkronizo përmes';

  @override
  String get searchSyncViaFooter => 'Zgjidhni të njëjtën llogari në çdo pajisje.';

  @override
  String get searchGmailCantKeep => 'Gmail s’mund të mbajë Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Mbaji Smart Mailboxes vetëm në këtë pajisje';

  @override
  String get searchOnTheServer => 'Në server';

  @override
  String get searchServerFooter =>
      'Meta të dhënat e serverit (IMAP METADATA) nuk shfaqen në asnjë aplikacion poste. Serverët pa to marrin një dosje “Loupe Settings” me një mesazh; Loupe e fsheh nga Kutitë postare.';

  @override
  String get searchSyncNow => 'Sinkronizo tani';

  @override
  String get searchStateUnsupported => 'Nuk mbulohet';

  @override
  String get searchStateNewerFormat => 'Format më i ri';

  @override
  String get searchStateFailed => 'Sinkronizimi dështoi';

  @override
  String get searchStateSyncing => 'Po sinkronizohet…';

  @override
  String get searchStateWaiting => 'Në pritje';

  @override
  String get searchStateMetadata => 'Meta të dhëna serveri';

  @override
  String get searchStateFolder => 'Dosja “Loupe Settings”';

  @override
  String get searchStateNothing => 'S’ka gjë të ruajtur';

  @override
  String get sharedBack => 'Prapa';

  @override
  String get sharedYesterday => 'Dje';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date, ora $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bajte', one: '1 bajt');
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
  String get sharedSyncNoAccounts => 'S’ka llogari';

  @override
  String get sharedSyncChecking => 'Po kontrollohet për postë…';

  @override
  String get sharedSyncFailed => 'Kontrolli për postë dështoi';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Jashtë linje';

  @override
  String get sharedSyncJustNow => 'Përditësuar pak më parë';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Përditësuar $minutes minuta më parë',
      one: 'Përditësuar 1 minutë më parë',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Përditësuar në $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Përditësuar më $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Të gjitha kutitë hyrëse';

  @override
  String get sharedMailboxUnread => 'Të palexuara';

  @override
  String get sharedMailboxFlagged => 'Me flamurkë';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Të gjitha skicat';

  @override
  String get sharedMailboxAllSent => 'Të gjitha të dërguarat';

  @override
  String get sharedMailboxUntitled => 'Kuti postare';

  @override
  String get sharedTagImportant => 'E rëndësishme';

  @override
  String get sharedTagWork => 'Punë';

  @override
  String get sharedTagPersonal => 'Personale';

  @override
  String get sharedTagToDo => 'Për t’u bërë';

  @override
  String get sharedTagLater => 'Më vonë';

  @override
  String get sharedTags => 'Etiketat';

  @override
  String get sharedMoveTo => 'Zhvendos te…';

  @override
  String get sharedNoRecipients => 'Pa marrës';

  @override
  String get sharedUnknownSender => 'Dërgues i panjohur';

  @override
  String get sharedOnServer => 'Në server';

  @override
  String get sharedAttachment => 'Bashkëngjitje';

  @override
  String get sharedSnoozedBadge => 'E shtyrë';

  @override
  String get sharedRowUnread => 'I palexuar';

  @override
  String get sharedRowBackFromSnooze => 'U kthye nga shtyrja';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Me flamurkë';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U arkivuan $count mesazhe',
      one: 'U arkivua 1 mesazh',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U fshinë $count mesazhe',
      one: 'U fshi 1 mesazh',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U zhvendosën $count mesazhe te Kutia hyrëse',
      one: 'U zhvendos 1 mesazh te Kutia hyrëse',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U zhvendosën $count mesazhe në kosh',
      one: 'U zhvendos 1 mesazh në kosh',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U zhvendosën $count mesazhe te Të padëshiruara',
      one: 'U zhvendos 1 mesazh te Të padëshiruara',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U zhvendosën $count mesazhe te $mailbox',
      one: 'U zhvendos 1 mesazh te $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U zhvendosën $count mesazhe te një kuti postare',
      one: 'U zhvendos 1 mesazh te një kuti postare',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U shtynë $count mesazhe deri më $time',
      one: 'U shty 1 mesazh deri më $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'U shty deri më $time vetëm në këtë pajisje: serveri s’mund të ruajë kohët e shtyrjes.';
  }

  @override
  String get sharedMoveOneAccount => 'Përzgjidhni mesazhe nga një llogari për t’i zhvendosur.';

  @override
  String get sharedSnoozeTitle => 'Shtyrje';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Ndrysho kohën e shtyrjes';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Të fshihen përgjithmonë $count mesazhe?',
      one: 'Të fshihet përgjithmonë ky mesazh?',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Kjo s’mund të zhbëhet.';

  @override
  String get sharedDeletePermanently => 'Fshije përgjithmonë';

  @override
  String get sharedSwipeRead => 'Lexuar';

  @override
  String get sharedSwipeUnread => 'Palexuar';

  @override
  String get sharedSwipeInbox => 'Kutia hyrëse';

  @override
  String get sharedSwipeDelete => 'Fshi';

  @override
  String get sharedTrash => 'Në kosh';

  @override
  String get sharedSwipeSnooze => 'Shtyje';

  @override
  String get sharedWakeNow => 'Ktheje tani';

  @override
  String get sharedChangeSnoozeTime => 'Ndrysho kohën e shtyrjes…';

  @override
  String get sharedSnooze => 'Shtyje…';

  @override
  String get sharedTag => 'Etiketo…';

  @override
  String get sharedMoveMessage => 'Zhvendos mesazhin…';

  @override
  String get sharedNotJunk => 'Jo i padëshiruar';

  @override
  String get accountSetupTitle => 'Shto llogari';

  @override
  String get accountSetupTitleDone => 'Llogaria u shtua';

  @override
  String get accountSetupAddressTitle => 'Shtoni një llogari poste';

  @override
  String get accountSetupAddressText => 'Loupe i gjen cilësimet për shumicën e ofruesve.';

  @override
  String get accountSetupNameHint => 'Emri juaj';

  @override
  String get accountSetupEmail => 'Email';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Vazhdo';

  @override
  String get accountSetupLookingUp => 'Po kërkohen cilësimet…';

  @override
  String get accountSetupImport => 'Importo nga Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Jepni një adresë email të vlefshme.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'S’u gjetën cilësime për $domain. Jepini më poshtë.';
  }

  @override
  String get accountSetupCheckServers => 'Kontrolloni emrat e serverëve dhe portat.';

  @override
  String get accountSetupEnterPassword => 'Jepni fjalëkalimin tuaj.';

  @override
  String get accountSetupConnecting => 'Po lidhet…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Në pritje të $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Faqja nuk u hap dot.';

  @override
  String get accountSetupCouldNotSaveName => 'Emri nuk u ruajt dot.';

  @override
  String get accountSetupTrustCertificate => 'Besoji kësaj certifikate';

  @override
  String get accountSetupPasswordRequired => 'I domosdoshëm';

  @override
  String get accountSetupShowPassword => 'Shfaq fjalëkalimin';

  @override
  String get accountSetupHidePassword => 'Fshih fjalëkalimin';

  @override
  String get accountSetupAppPassword => 'Fjalëkalim aplikacioni';

  @override
  String get accountSetupApiToken => 'Token API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Hyrëse · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Dalëse · SMTP';

  @override
  String get accountSetupSignIn => 'Hyni';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Hyni me $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Përdor një fjalëkalim aplikacioni';

  @override
  String get accountSetupUseAppPasswordInstead => 'Përdor më mirë një fjalëkalim aplikacioni';

  @override
  String get accountSetupUseDifferentAddress => 'Përdor një adresë tjetër';

  @override
  String get accountSetupHowToCreateAppPassword => 'Si të krijoni një fjalëkalim aplikacioni';

  @override
  String get accountSetupHowToCreateOne => 'Si ta krijoni';

  @override
  String get accountSetupGoogleNote =>
      'Hyni në faqen e Google-it dhe Loupe s’e sheh kurrë fjalëkalimin tuaj. Lejojeni Loupe ta lexojë, dërgojë dhe organizojë postën tuaj.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      '“Hyni me Google” ende s’është i disponueshëm në këtë version. Mund të lidheni me një fjalëkalim aplikacioni (kërkon Verifikimin me 2 hapa në llogarinë tuaj Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Krijoni një fjalëkalim aplikacioni në llogarinë tuaj Google dhe ngjiteni më poshtë.';

  @override
  String get accountSetupMicrosoftNote =>
      'Hyni në faqen e Microsoft-it dhe Loupe s’e sheh kurrë fjalëkalimin tuaj. Kjo funksionon për Outlook.com dhe Hotmail, si dhe për llogari pune ose shkolle në Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Hyrja me Microsoft vjen në një version të mëvonshëm. Llogaritë Outlook, Hotmail dhe Microsoft 365 kanë nevojë për të: nuk pranojnë më fjalëkalime nga aplikacionet e postës.';

  @override
  String get accountSetupICloudNote =>
      'iCloud Mail kërkon një fjalëkalim specifik për aplikacionin, jo fjalëkalimin e llogarisë suaj Apple.';

  @override
  String get accountSetupYahooNote => 'Yahoo Mail kërkon një fjalëkalim aplikacioni, jo fjalëkalimin e llogarisë suaj.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Loupe lidhet me Fastmail përmes JMAP me një token API: Settings › Privacy & Security › Manage API tokens, për JMAP, me qasje te email-i dhe dërgimi.';

  @override
  String get accountSetupFastmailNote => 'Fastmail kërkon një fjalëkalim aplikacioni për aplikacionet e postës.';

  @override
  String get accountSetupServerSettings => 'Cilësimet e serverit';

  @override
  String get accountSetupSettingsNotFound => 'S’u gjetën automatikisht';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'U gjetën përmes $source';
  }

  @override
  String get accountSetupEditSettings => 'Redakto cilësimet';

  @override
  String get accountSetupSyncing => 'Posta juaj po sinkronizohet.';

  @override
  String get accountSetupDescription => 'Përshkrimi';

  @override
  String get accountSetupDescriptionHint => 'Punë, Personale…';

  @override
  String get accountSetupColour => 'Ngjyra';

  @override
  String accountSetupColourNumber(int number) {
    return 'Ngjyra $number';
  }

  @override
  String get accountSetupSaving => 'Po ruhet…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Loupe nuk e hapi dot bazën e vet të të dhënave të postës në këtë telefon. Mbyllni Loupe, hapeni sërish dhe riprovoni.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Diçka shkoi keq ($error). Provoni sërish.';
  }

  @override
  String get accountSetupSecurityNone => 'Asnjë';

  @override
  String get accountSetupProtocol => 'Protokolli';

  @override
  String get accountSetupPort => 'Porta';

  @override
  String get accountSetupSecurity => 'Siguria';

  @override
  String get accountSetupUsername => 'Emri i përdoruesit';

  @override
  String get accountSetupUsernameHint => 'Adresa juaj email';

  @override
  String get accountSetupNoEncryptionTitle => 'Të lidhet pa enkriptim?';

  @override
  String get accountSetupNoEncryptionText =>
      'Fjalëkalimi juaj dhe çdo mesazh do të udhëtonin si tekst i thjeshtë. Kushdo në rrjet, si në një Wi-Fi publik, mund t’i lexonte. Përdoreni këtë vetëm për një server në rrjetin tuaj.';

  @override
  String get accountSetupUseWithoutEncryption => 'Përdore pa enkriptim';

  @override
  String get accountSetupApiTokenRejected =>
      'Token-i API u refuzua. Krijoni një token API të Fastmail për JMAP me qasje te email-i dhe ngjiteni.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Fjalëkalimi u refuzua. Përdorni një fjalëkalim aplikacioni, jo fjalëkalimin e llogarisë.';

  @override
  String get accountSetupPasswordRejected => 'Fjalëkalimi u refuzua. Kontrollojeni dhe provoni sërish.';

  @override
  String get accountSetupServerUnreachable => 'Serveri s’arrihet. Kontrolloni cilësimet e serverit dhe lidhjen tuaj.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Certifikata e serverit s’është e besuar. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Hyrja u anulua. Prekni “Hyni me $provider” për të provuar sërish.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Loupe ka nevojë për leje për të lexuar dhe dërguar postën tuaj Gmail. Hyni sërish dhe lejoni qasjen, me kutizën e Gmail-it të shënuar.';

  @override
  String get accountSetupOAuthDenied =>
      'Loupe ka nevojë për leje për të lexuar dhe dërguar postën tuaj. Hyni sërish dhe pranoni lejet.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Organizata juaj duhet ta miratojë Loupe përpara se ta përdorni me këtë llogari. Kërkojini administratorit tuaj të IT-së të japë miratimin e administratorit për Loupe në Microsoft Entra ID, pastaj provoni sërish.';

  @override
  String get accountSetupOAuthBlocked =>
      'Rregullat e hyrjes të organizatës suaj nuk e lejojnë Loupe në këtë pajisje. Pyesni administratorin tuaj të IT-së.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return '$provider s’u arrit dot. Kontrolloni lidhjen tuaj me internetin dhe provoni sërish.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Hyrja me $provider s’është konfiguruar si duhet në këtë version të Loupe. Ju lutemi, raportojeni këtë.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Hyrja me $provider nuk funksionoi. Provoni sërish.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return '$provider ju futi, por Gmail e refuzoi qasjen për këtë adresë. Zgjidhni të njëjtën llogari kur hyni. Llogaritë e punës ose shkollës mund ta kenë IMAP-in të çaktivizuar nga administratori.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return '$provider ju futi, por serveri i postës e refuzoi qasjen për këtë adresë. Zgjidhni të njëjtën llogari kur hyni. Llogaritë e punës ose shkollës mund ta kenë IMAP-in të çaktivizuar nga administratori.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Serveri i postës s’arrihet. Kontrolloni lidhjen tuaj dhe provoni sërish.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Hyrja me $provider s’është e disponueshme në këtë version.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'U hytë sërish. $account po sinkronizohet.';
  }

  @override
  String get accountSetupSignInAgain => 'Hyni sërish';

  @override
  String get accountSetupSigningIn => 'Po hyhet…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return '$provider s’e pranon më hyrjen e Loupe për $email, ndaj $account s’po sinkronizohet. Hyni sërish për të marrë postën e saj.';
  }

  @override
  String get accountImportTitle => 'Importo nga Thunderbird';

  @override
  String get accountImportPointCamera => 'Drejtojeni kamerën te kodi QR që shfaq Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'U skanuan $scanned nga $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'U skanuan $scanned nga $total kode');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llogari deri tani',
      one: '1 llogari deri tani',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Në kompjuter, hapni Thunderbird dhe zgjidhni Mjete › Eksportoje për Celular. Përzgjidhni llogaritë tuaja, pastaj skanoni çdo kod që shfaq. Kodet mund të skanohen në çfarëdo radhe.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vazhdo me $count llogari',
      one: 'Vazhdo me 1 llogari',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Ngjit tekst në vend të kësaj';

  @override
  String get accountImportStartOver => 'Fillo nga e para';

  @override
  String get accountImportDuplicateCode => 'Ky kod është shtuar tashmë.';

  @override
  String get accountImportRestarted =>
      'Ky kod është nga një eksport i ri, ndaj kodet e skanuara më parë u lanë mënjanë.';

  @override
  String get accountImportNotThunderbird => 'Ky s’është kod llogarie Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Ky kod vjen nga një Thunderbird më i ri. Përditësoni Loupe për ta importuar.';

  @override
  String get accountImportDamaged => 'Ky kod Thunderbird nuk u lexua dot.';

  @override
  String get accountImportTooLarge => 'Ky kod është shumë i madh për të qenë eksport Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Cilësimet nuk u hapën dot.';

  @override
  String get accountImportCameraOffTitle => 'Qasja te kamera është çaktivizuar';

  @override
  String get accountImportCameraOffText =>
      'Lejojeni Loupe të përdorë kamerën te cilësimet për të skanuar kodin, ose ngjitni tekstin e kodit.';

  @override
  String get accountImportNoCameraTitle => 'S’ka kamerë';

  @override
  String get accountImportNoCameraText => 'Loupe s’mund të përdorë kamerë këtu. Ngjitni tekstin e kodit.';

  @override
  String get accountImportCameraFailedTitle => 'Kamera nuk u nis';

  @override
  String get accountImportCameraFailedText => 'Provoni sërish, ose ngjitni tekstin e kodit.';

  @override
  String get accountImportOpenSettings => 'Hap cilësimet';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'U gjetën $count llogari',
      one: 'U gjet 1 llogari',
      zero: 'S’u gjet asnjë llogari',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable => 'Asnjë nga llogaritë në këto kode nuk u lexua dot.';

  @override
  String get accountImportChoose => 'Zgjidhni llogaritë që do të shtohen në Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kodet $codes nga $total nuk u skanuan, ndaj llogaritë e tyre nuk shfaqen.',
      one: 'Kodi $codes nga $total nuk u skanua, ndaj llogaritë e tij nuk shfaqen.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes dhe $last';
  }

  @override
  String get accountImportScanMore => 'Skano kode të tjera';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count llogari në kode nuk u lexuan dot. Mund të përdorin cilësime nga një Thunderbird më i ri.',
      one: '1 llogari në kode nuk u lexua dot. Mund të përdorë cilësime nga një Thunderbird më i ri.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Skano sërish';

  @override
  String get accountImportAlreadyAdded => 'Një llogari me këtë adresë është tashmë në Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Do të hyni me $provider kur të shtohet, si në Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Shtojeni llogarinë me një fjalëkalim aplikacioni (kërkon Verifikimin me 2 hapa).';

  @override
  String get accountImportGmailNoSignIn =>
      'Thunderbird hyn në Gmail me Google. “Hyni me Google” vjen në një version të mëvonshëm; deri atëherë, shtojeni llogarinë me një fjalëkalim aplikacioni (kërkon Verifikimin me 2 hapa).';

  @override
  String get accountImportBrowserSignIn =>
      'Thunderbird hyn në këtë llogari përmes shfletuesit. Loupe s’e bën dot ende këtë: përdorni një fjalëkalim aplikacioni, nëse e ofron ofruesi juaj.';

  @override
  String get accountImportUnencrypted => 'Lidhet pa enkriptim. Përdoreni vetëm në rrjetin tuaj.';

  @override
  String get accountImportEnterAgain => 'Jepeni sërish';

  @override
  String get accountImportAdded => 'U shtua';

  @override
  String accountImportAdding(int index, int total) {
    return 'Po shtohet $index nga $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Shto $count llogari',
      one: 'Shto 1 llogari',
      zero: 'Shto llogari',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Ngjitni tekstin e eksportit';

  @override
  String get accountImportPasteText => 'Ngjitni tekstin e një kodi eksporti Thunderbird, një kod për rresht.';

  @override
  String get accountImportPop3 => 'Llogaritë POP3 nuk mbulohen. Loupe e mban postën në server me IMAP.';

  @override
  String get accountImportKerberos => 'Kjo llogari hyn me Kerberos, që Loupe nuk e mbulon.';

  @override
  String get accountImportNtlm => 'Kjo llogari hyn me NTLM, që Loupe nuk e mbulon.';

  @override
  String get accountImportClientCertificate =>
      'Kjo llogari hyn me një certifikatë klienti, që Loupe ende nuk e mbulon.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Hyrja me Microsoft vjen në një version të mëvonshëm. Llogaritë Outlook dhe Microsoft 365 nuk pranojnë më fjalëkalime nga aplikacionet e postës.';

  @override
  String get accountImportEnterPassword => 'Jepni fjalëkalimin.';

  @override
  String get accountImportEnterAppPassword => 'Jepni fjalëkalimin e aplikacionit.';

  @override
  String get accountImportEnterApiToken => 'Jepni token-in API.';

  @override
  String get accountImportStorageFailed => 'Loupe nuk e hapi dot depon e vet të llogarive. Provoni sërish më vonë.';

  @override
  String get accountImportFailed => 'Llogaria nuk u shtua dot. Provoni sërish, ose shtojeni dorazi.';

  @override
  String get composeNewMessageTitle => 'Mesazh i ri';

  @override
  String get composeAttach => 'Bashkëngjit';

  @override
  String get composeSendLater => 'Dërgo më vonë';

  @override
  String composeSendAt(String time) {
    return 'Dërgo $time';
  }

  @override
  String get composeSendHint => 'Shtypni gjatë për ta dërguar më vonë';

  @override
  String get composeNoAccount => 'Shtoni një llogari për të dërguar postë.';

  @override
  String get composeTo => 'Për:';

  @override
  String get composeCc => 'Cc:';

  @override
  String get composeBcc => 'Bcc:';

  @override
  String composeCcBccFrom(String email) {
    return 'Cc/Bcc, Nga: $email';
  }

  @override
  String get composeFromLabel => 'Nga:';

  @override
  String get composeSubjectLabel => 'Subjekti:';

  @override
  String composeReplyTo(String address) {
    return 'Përgjigju te: $address';
  }

  @override
  String get composeFrom => 'Nga';

  @override
  String composeReplyFrom(String email) {
    return 'Përgjigju nga $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Dërgo nga $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Të përgjigjeni nga $email?';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Të dërgohet nga $email?';
  }

  @override
  String get composeDismiss => 'Hidhe tej';

  @override
  String composeAliasNotSaved(String account) {
    return 'S’është ruajtur si identitet · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Ruaje si identitet';

  @override
  String composeAliasSaved(String email) {
    return '$email u ruajt si identitet.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Adresë e pavlefshme $address';
  }

  @override
  String get composeOriginalNotFound => 'Mesazhi origjinal nuk u gjet.';

  @override
  String get composeDraftNotFound => 'Skica nuk u gjet.';

  @override
  String get composeAttachmentsLost => 'Bashkëngjitjet nuk u rikthyen dot. Shtojini sërish.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Disa bashkëngjitje nuk u shtuan dot: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Bashkëngjitjet arrijnë gjithsej $size; disa serverë refuzojnë mesazhe kaq të mëdha.';
  }

  @override
  String get composeAttachFailed => 'Skedari nuk u bashkëngjit dot.';

  @override
  String get composeInvalidAddressTitle => 'Adresë e pavlefshme';

  @override
  String composeInvalidAddress(String address) {
    return '“$address” s’është adresë email e vlefshme.';
  }

  @override
  String get composeNoSubjectTitle => 'Pa subjekt';

  @override
  String get composeNoSubjectText => 'Ky mesazh s’ka subjekt. Të dërgohet sidoqoftë?';

  @override
  String get composeSentBeforeChanges => 'U dërgua përpara ndryshimeve tuaja, të cilat janë ruajtur te Skica.';

  @override
  String composeScheduled(String time) {
    return 'Planifikuar për $time';
  }

  @override
  String get composeSending => 'Po dërgohet…';

  @override
  String get composeSent => 'U dërgua';

  @override
  String get composeSendFailed => 'Dërgimi dështoi. Provoni sërish.';

  @override
  String get composeAlreadySent => 'Është dërguar tashmë.';

  @override
  String get composeDiscardChanges => 'Hidhi poshtë ndryshimet';

  @override
  String get composeSaveChanges => 'Ruaj ndryshimet';

  @override
  String get composeDeleteDraft => 'Fshi skicën';

  @override
  String get composeSaveDraft => 'Ruaj skicën';

  @override
  String get composeDraftSaved => 'Skica u ruajt';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Më $date, në $time, $name shkroi:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Më $date, në $time, dikush shkroi:';
  }

  @override
  String get composeForwardHeader => '---------- Mesazh i përcjellë ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Nga: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Data: $date, ora $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Subjekti: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Për: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Cc: $addresses';
  }

  @override
  String get composeLaterToday => 'Më vonë sot';

  @override
  String get composeTomorrowMorning => 'Nesër në mëngjes';

  @override
  String get composeMondayMorning => 'Të hënën në mëngjes';

  @override
  String get composePickDateTime => 'Zgjidh datë dhe orë…';

  @override
  String get composeSendWithoutDelay => 'Dërgo pa vonesë';

  @override
  String composeSendTimeToday(String time) {
    return 'Sot në $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Nesër në $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day në $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Sot $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Nesër $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Të vazhdoni redaktimin e skicës?';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Një mesazh nuk u dërgua kur u mbyll Loupe.',
      'one': 'Një mesazh për $name nuk u dërgua kur u mbyll Loupe.',
      'other': 'Një mesazh për $name dhe të tjerë nuk u dërgua kur u mbyll Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': '“$subject” nuk u dërgua kur u mbyll Loupe.',
      'one': '“$subject” për $name nuk u dërgua kur u mbyll Loupe.',
      'other': '“$subject” për $name dhe të tjerë nuk u dërgua kur u mbyll Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Vazhdo redaktimin';

  @override
  String get composeRecoverySave => 'Ruaje te Skica';

  @override
  String get composeRecoveryDiscard => 'Hidhe poshtë';

  @override
  String get composeRecoverySaved => 'U ruajt te Skica';

  @override
  String get outboxSectionFailed => 'Të padërguara';

  @override
  String get outboxSectionSending => 'Po dërgohen';

  @override
  String get outboxSectionScheduled => 'Të planifikuara';

  @override
  String get outboxStatusQueued => 'Dërgohet së shpejti';

  @override
  String get outboxStatusSending => 'Po dërgohet…';

  @override
  String get outboxStatusFailed => 'I padërguar';

  @override
  String get outboxNoRecipients => 'Pa marrës';

  @override
  String get outboxNoSubject => '(Pa subjekt)';

  @override
  String get outboxSendingFailed => 'Dërgimi dështoi.';

  @override
  String get outboxEmptyTitle => 'S’ka gjë për të dërguar';

  @override
  String get outboxEmptyText => 'Mesazhet që i dërgoni më vonë presin këtu deri në kohën e tyre.';

  @override
  String get outboxSendNow => 'Dërgo tani';

  @override
  String get outboxReschedule => 'Riplanifiko';

  @override
  String get outboxRescheduleMenu => 'Riplanifiko…';

  @override
  String get outboxRescheduleTitle => 'Riplanifiko';

  @override
  String outboxRescheduled(String time) {
    return 'Riplanifikuar për $time';
  }

  @override
  String get outboxCancel => 'Anulo';

  @override
  String get outboxCancelSending => 'Anulo dërgimin…';

  @override
  String get outboxCancelTitle => 'Të anulohet dërgimi?';

  @override
  String get outboxMoveToDrafts => 'Zhvendos te Skica';

  @override
  String get outboxDiscard => 'Hidhe poshtë mesazhin';

  @override
  String get outboxMovedToDrafts => 'U zhvendos te Skica';

  @override
  String get outboxDiscarded => 'Mesazhi u hodh poshtë';

  @override
  String get outboxAlreadySent => 'Është dërguar tashmë.';

  @override
  String get outboxBeingSent => 'Ky mesazh po dërgohet.';

  @override
  String get outboxActionFailed => 'Kjo nuk funksionoi. Mesazhi është ende te Kutia dalëse.';

  @override
  String get notificationsBadgeInboxes => 'Të palexuara te kutitë hyrëse';

  @override
  String get notificationsBadgeVip => 'Të palexuara nga VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Postë e re nga VIP-at tuaj, në çdo llogari';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Postë e re te $email';
  }

  @override
  String get notificationsUnknownSender => 'Dërgues i panjohur';

  @override
  String get notificationsNoSubject => '(Pa subjekt)';

  @override
  String get notificationsEncryptedMessage => 'Mesazh i enkriptuar';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Mesazh i ri nga $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesazhe të reja',
      one: '1 mesazh i ri',
    );
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Mesazhe të reja te $account';
  }

  @override
  String get platformInstantChannel => 'Dorëzim i menjëhershëm';

  @override
  String get platformInstantChannelDescription => 'Shfaqet ndërsa Loupe i vëzhgon kutitë tuaja hyrëse për postë të re';

  @override
  String get platformInstantTitle => 'Në pritje të postës së re';

  @override
  String get platformInstantText => 'Dorëzimi i menjëhershëm është aktiv';

  @override
  String get platformErrorBox => 'Diçka shkoi keq gjatë shfaqjes. Kthehuni prapa dhe provoni sërish.';

  @override
  String get welcomeTagline => 'Postë e thjeshtë në sipërfaqe\ndhe e fuqishme në thellësi.';

  @override
  String get welcomeAccountsTitle => 'Çdo llogari, një kuti hyrëse e qetë';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail dhe çdo server IMAP ose JMAP.';

  @override
  String get welcomeSearchTitle => 'Kërkim që e gjen';

  @override
  String get welcomeSearchText => 'Përfundime të menjëhershme në telefon, pastaj ato të serverit.';

  @override
  String get welcomePrivacyTitle => 'Privat që nga projektimi';

  @override
  String get welcomePrivacyText => 'Pa gjurmim. Imazhet e largëta mbeten të bllokuara derisa ta vendosni ju.';

  @override
  String get welcomeAddAccount => 'Shto llogari';

  @override
  String get welcomeImport => 'Importo nga Thunderbird';

  @override
  String get welcomeTryDemo => 'Provojeni me postë demo';
}
