// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get commonAdd => 'Προσθήκη';

  @override
  String get commonCancel => 'Ακύρωση';

  @override
  String get commonClose => 'Κλείσιμο';

  @override
  String get commonDelete => 'Διαγραφή';

  @override
  String get commonDone => 'Τέλος';

  @override
  String get commonEdit => 'Επεξεργασία';

  @override
  String get commonMore => 'Περισσότερα';

  @override
  String get commonMove => 'Μετακίνηση';

  @override
  String get commonName => 'Όνομα';

  @override
  String get commonNone => 'Κανένα';

  @override
  String get commonOff => 'Ανενεργό';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOn => 'Ενεργό';

  @override
  String get commonOptional => 'Προαιρετικό';

  @override
  String get commonPassword => 'Κωδικός πρόσβασης';

  @override
  String get commonRemove => 'Αφαίρεση';

  @override
  String get commonRetry => 'Επανάληψη';

  @override
  String get commonSave => 'Αποθήκευση';

  @override
  String get commonSearch => 'Αναζήτηση';

  @override
  String get commonServer => 'Διακομιστής';

  @override
  String get commonSettings => 'Ρυθμίσεις';

  @override
  String get commonShare => 'Κοινοποίηση';

  @override
  String get commonTryAgain => 'Δοκιμάστε ξανά';

  @override
  String get commonUndo => 'Αναίρεση';

  @override
  String commonMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count μηνύματα', one: '1 μήνυμα');
    return '$_temp0';
  }

  @override
  String get mailArchive => 'Αρχειοθέτηση';

  @override
  String get mailDelete => 'Διαγραφή';

  @override
  String get mailFlag => 'Προσθήκη σημαίας';

  @override
  String get mailForward => 'Προώθηση';

  @override
  String get mailMarkAsRead => 'Σήμανση ως αναγνωσμένο';

  @override
  String get mailMarkAsUnread => 'Σήμανση ως μη αναγνωσμένο';

  @override
  String get mailMoveToJunk => 'Μετακίνηση στα ανεπιθύμητα';

  @override
  String get mailNewMessage => 'Νέο μήνυμα';

  @override
  String get mailNoSubject => 'Χωρίς θέμα';

  @override
  String get mailReply => 'Απάντηση';

  @override
  String get mailReplyAll => 'Απάντηση σε όλους';

  @override
  String get mailSend => 'Αποστολή';

  @override
  String get mailUnflag => 'Αφαίρεση σημαίας';

  @override
  String get mailboxArchive => 'Αρχειοθήκη';

  @override
  String get mailboxDrafts => 'Πρόχειρα';

  @override
  String get mailboxInbox => 'Εισερχόμενα';

  @override
  String get mailboxJunk => 'Ανεπιθύμητα';

  @override
  String get mailboxOutbox => 'Εξερχόμενα';

  @override
  String get mailboxSent => 'Απεσταλμένα';

  @override
  String get mailboxTrash => 'Κάδος απορριμμάτων';

  @override
  String get conversationSomethingWentWrong => 'Κάτι πήγε στραβά. Δοκιμάστε ξανά.';

  @override
  String get conversationReplyToList => 'Απάντηση στη λίστα';

  @override
  String get conversationReplyList => 'Στη λίστα';

  @override
  String get conversationThreadMuted => 'Το νήμα τέθηκε σε σίγαση. Τα νέα μηνύματά του θα φτάνουν ως αναγνωσμένα.';

  @override
  String get conversationThreadUnmuted => 'Η σίγαση του νήματος καταργήθηκε.';

  @override
  String get conversationLinkFailed => 'Δεν ήταν δυνατό το άνοιγμα του συνδέσμου.';

  @override
  String get conversationGoneTitle => 'Κανένα μήνυμα';

  @override
  String get conversationGoneText => 'Αυτό το μήνυμα μετακινήθηκε ή διαγράφηκε.';

  @override
  String get conversationMuted => 'Σε σίγαση';

  @override
  String get conversationReaderOptions => 'Επιλογές ανάγνωσης';

  @override
  String get conversationReaderOptionsHint => 'Μέγεθος κειμένου και προβολή';

  @override
  String get conversationTrash => 'Στον κάδο';

  @override
  String get conversationReplyHint => 'Παρατεταμένο πάτημα για «Απάντηση σε όλους» και «Προώθηση»';

  @override
  String get conversationOfflineTitle => 'Είστε εκτός σύνδεσης';

  @override
  String get conversationOfflineText => 'Αυτή η συζήτηση δεν έχει ληφθεί ακόμη. Θα φορτωθεί όταν συνδεθείτε ξανά.';

  @override
  String get conversationErrorTitle => 'Δεν είναι δυνατή η εμφάνιση του μηνύματος';

  @override
  String get conversationErrorText => 'Κάτι πήγε στραβά.';

  @override
  String get conversationOfflineBanner => 'Είστε εκτός σύνδεσης';

  @override
  String get conversationNotUpdated => 'Δεν ενημερώθηκε';

  @override
  String get conversationMe => 'εμένα';

  @override
  String get conversationNoSender => '(χωρίς αποστολέα)';

  @override
  String get conversationNoRecipients => 'χωρίς παραλήπτες';

  @override
  String conversationRecipients(String names) {
    return 'προς $names';
  }

  @override
  String conversationRecipientsMore(String names, int more) {
    return 'προς $names +$more';
  }

  @override
  String get conversationHeaderFrom => 'Από';

  @override
  String get conversationHeaderTo => 'Προς';

  @override
  String get conversationHeaderCc => 'Κοιν.';

  @override
  String get conversationHeaderBcc => 'Ιδιαίτ. κοιν.';

  @override
  String get conversationHeaderReplyTo => 'Απάντηση προς';

  @override
  String get conversationHeaderDate => 'Ημερομηνία';

  @override
  String get conversationHeaderSecurity => 'Ασφάλεια';

  @override
  String get conversationVerifiedSender => 'Επαληθευμένος αποστολέας';

  @override
  String get conversationUnverifiedSender => 'Μη επαληθευμένος αποστολέας';

  @override
  String get conversationLoadingMessage => 'Φόρτωση μηνύματος';

  @override
  String get conversationBodyError => 'Δεν ήταν δυνατή η φόρτωση αυτού του μηνύματος.';

  @override
  String get conversationBodyOffline => 'Είστε εκτός σύνδεσης. Το μήνυμα θα φορτωθεί όταν συνδεθείτε ξανά.';

  @override
  String get conversationOriginalHint => 'Φαίνεται καλύτερα στην προβολή «Πρωτότυπη»';

  @override
  String get conversationShowOriginal => 'Εμφάνιση πρωτότυπου';

  @override
  String get conversationScrollToTop => 'Κύλιση στην αρχή';

  @override
  String get conversationTagsMenu => 'Ετικέτες…';

  @override
  String get conversationMuteThread => 'Σίγαση νήματος';

  @override
  String get conversationUnmuteThread => 'Κατάργηση σίγασης νήματος';

  @override
  String get conversationMoveMenu => 'Μετακίνηση…';

  @override
  String get conversationDeletePermanently => 'Οριστική διαγραφή';

  @override
  String get conversationMoveToTrash => 'Μετακίνηση στον κάδο';

  @override
  String get conversationNotJunk => 'Όχι ανεπιθύμητο';

  @override
  String get conversationShowAllHeaders => 'Εμφάνιση όλων των κεφαλίδων';

  @override
  String get conversationViewSource => 'Προβολή πηγαίου κώδικα';

  @override
  String get conversationSaveAsFile => 'Αποθήκευση ως αρχείο…';

  @override
  String get conversationShareAsFile => 'Κοινοποίηση ως αρχείο…';

  @override
  String get conversationSearchFromMessageMenu => 'Αναζήτηση με βάση αυτό το μήνυμα…';

  @override
  String get conversationVip => 'VIP';

  @override
  String get conversationCopyAddress => 'Αντιγραφή διεύθυνσης';

  @override
  String get conversationAddressCopied => 'Η διεύθυνση αντιγράφηκε';

  @override
  String conversationSearchMessagesFrom(String name) {
    return 'Αναζήτηση μηνυμάτων από $name';
  }

  @override
  String get conversationTags => 'Ετικέτες';

  @override
  String get conversationAllHeaders => 'Όλες οι κεφαλίδες';

  @override
  String get conversationCopyAll => 'Αντιγραφή όλων';

  @override
  String get conversationHeadersCopied => 'Οι κεφαλίδες αντιγράφηκαν';

  @override
  String get conversationNoHeaders => 'Δεν υπάρχουν κεφαλίδες';

  @override
  String get conversationSearchFromMessageTitle => 'Αναζήτηση με βάση αυτό το μήνυμα';

  @override
  String conversationSearchFrom(String name) {
    return 'Από $name';
  }

  @override
  String conversationSearchTo(String name) {
    return 'Προς $name';
  }

  @override
  String conversationSearchSubject(String subject) {
    return 'Θέμα «$subject»';
  }

  @override
  String get conversationSourceTitle => 'Πηγαίος κώδικας';

  @override
  String get conversationSourceCopied => 'Ο πηγαίος κώδικας αντιγράφηκε';

  @override
  String get conversationShareFailed => 'Δεν ήταν δυνατή η κοινοποίηση του μηνύματος.';

  @override
  String get conversationWrapLines => 'Αναδίπλωση γραμμών';

  @override
  String get conversationDontWrapLines => 'Χωρίς αναδίπλωση γραμμών';

  @override
  String get conversationSourceError => 'Δεν ήταν δυνατή η φόρτωση του πηγαίου κώδικα.';

  @override
  String conversationSourceCut(String shown, String total) {
    return 'Εμφανίζονται τα πρώτα $shown από $total. Αντιγράψτε ή κοινοποιήστε για να τα πάρετε όλα.';
  }

  @override
  String get conversationAttachmentUntitled => 'Χωρίς τίτλο';

  @override
  String conversationAttachmentMoreActions(String name) {
    return 'Περισσότερες ενέργειες για $name';
  }

  @override
  String get conversationMoveTo => 'Μετακίνηση σε…';

  @override
  String get conversationMailboxesError => 'Δεν ήταν δυνατή η φόρτωση των φακέλων.';

  @override
  String get conversationReaderReadable => 'Ευανάγνωστη';

  @override
  String get conversationReaderOriginal => 'Πρωτότυπη';

  @override
  String get conversationReaderPlain => 'Απλό κείμενο';

  @override
  String get conversationReaderSans => 'Sans';

  @override
  String get conversationReaderMono => 'Mono';

  @override
  String get conversationReaderKeepColours => 'Διατήρηση αρχικών χρωμάτων';

  @override
  String get conversationReaderRemember => 'Απομνημόνευση για αυτόν τον αποστολέα';

  @override
  String get conversationSecurityPossiblePhishing => 'Πιθανό phishing';

  @override
  String get conversationSecurityBeCareful => 'Προσοχή';

  @override
  String get conversationSecurityVerified => 'Επαληθευμένο';

  @override
  String get conversationSecurityNoIssues => 'Δεν βρέθηκαν προβλήματα';

  @override
  String conversationSecurityTrackers(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ιχνηλάτες', one: '1 ιχνηλάτης');
    return '$_temp0';
  }

  @override
  String get conversationSecurityBadgeHint => 'Εμφανίζει τον λόγο';

  @override
  String get conversationPhishingBannerTitle => 'Αυτό το μήνυμα μοιάζει με phishing';

  @override
  String conversationPhishingBannerReason(String reason) {
    return '$reason. Οι σύνδεσμοι και οι εικόνες έχουν απενεργοποιηθεί.';
  }

  @override
  String get conversationPhishingBannerText => 'Οι σύνδεσμοι και οι εικόνες έχουν απενεργοποιηθεί.';

  @override
  String get conversationPhishingWhy => 'Γιατί;';

  @override
  String get conversationPhishingShowAnyway => 'Εμφάνιση παρ’ όλα αυτά';

  @override
  String get conversationSecurityPhishingTitle => 'Αυτό μοιάζει με phishing';

  @override
  String get conversationSecurityPhishingText =>
      'Αρκετές ενδείξεις δείχνουν ότι αυτό το μήνυμα δεν είναι αυτό που ισχυρίζεται.';

  @override
  String get conversationSecurityCarefulTitle => 'Προσοχή με αυτό το μήνυμα';

  @override
  String get conversationSecurityCarefulText => 'Κάτι σε αυτό αξίζει μια δεύτερη ματιά.';

  @override
  String get conversationSecurityVerifiedText => 'Ο αποστολέας είναι επαληθευμένος και τίποτα δεν φαίνεται ύποπτο.';

  @override
  String get conversationSecurityUnverifiedText =>
      'Τίποτα δεν φαίνεται ύποπτο. Ο διακομιστής αλληλογραφίας σας δεν ανέφερε αν ο αποστολέας είναι επαληθευμένος.';

  @override
  String get conversationSecurityNothingSuspicious => 'Τίποτα δεν φαίνεται ύποπτο.';

  @override
  String get conversationSecurityWhy => 'Γιατί';

  @override
  String get conversationSecurityPrivacy => 'Απόρρητο';

  @override
  String get conversationSecurityNoTrackingPixels => 'Κανένα pixel παρακολούθησης';

  @override
  String conversationSecurityTrackingPixels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αφαιρέθηκαν $count pixel παρακολούθησης',
      one: 'Αφαιρέθηκε 1 pixel παρακολούθησης',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityTrackingPixelsText => 'Θα ενημέρωναν τον αποστολέα πότε ανοίξατε αυτό το μήνυμα.';

  @override
  String get conversationSecurityNoRemoteImages => 'Καμία απομακρυσμένη εικόνα';

  @override
  String conversationSecurityRemoteImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count απομακρυσμένες εικόνες',
      one: '1 απομακρυσμένη εικόνα',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityRemoteImagesText =>
      'Η φόρτωσή τους ενημερώνει τον αποστολέα πότε διαβάζετε αυτό το μήνυμα και του αποκαλύπτει τη διεύθυνση IP σας.';

  @override
  String get conversationSecurityNoClickTracking => 'Καμία παρακολούθηση κλικ';

  @override
  String conversationSecurityTrackedLinks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count σύνδεσμοι μέσω παρακολούθησης κλικ',
      one: '1 σύνδεσμος μέσω παρακολούθησης κλικ',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityTrackedLinksText(String services) {
    return 'Οι υπηρεσίες $services θα κατέγραφαν το κλικ σας. Πατήστε παρατεταμένα έναν σύνδεσμο για να ανοίξετε απευθείας τον προορισμό του.';
  }

  @override
  String get conversationSecurityTechnicalDetails => 'Τεχνικές λεπτομέρειες';

  @override
  String get conversationSecurityCheckedLocally => 'Ελέγχθηκε σε αυτή τη συσκευή. Δεν στάλθηκε τίποτα πουθενά.';

  @override
  String get conversationSecurityTrackersLabel => 'Ιχνηλάτες';

  @override
  String get conversationSecurityImagesFrom => 'Εικόνες από';

  @override
  String get conversationSecuritySenderHistory => 'Ιστορικό αποστολέα';

  @override
  String conversationSecuritySenderHistoryValue(int received, int sent) {
    return 'ληφθέντα: $received, σταλθέντα: $sent';
  }

  @override
  String get conversationSecurityLinksLeadTo => 'Οι σύνδεσμοι οδηγούν σε';

  @override
  String get conversationSecurityHidden => 'Κρυφά';

  @override
  String conversationSecurityHiddenValue(int elements, int characters) {
    String _temp0 = intl.Intl.pluralLogic(elements, locale: localeName, other: '$elements στοιχεία', one: '1 στοιχείο');
    String _temp1 = intl.Intl.pluralLogic(
      characters,
      locale: localeName,
      other: '$characters χαρακτήρες',
      one: '1 χαρακτήρας',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String get conversationSecurityAuthFailedTitle => 'Ο αποστολέας δεν επαληθεύτηκε';

  @override
  String conversationSecurityAuthFailedText(String domain) {
    return 'Ο διακομιστής αλληλογραφίας σας δεν μπόρεσε να επιβεβαιώσει ότι αυτό το μήνυμα προέρχεται πράγματι από το $domain.';
  }

  @override
  String get conversationSecurityAuthFailedTextNoDomain =>
      'Ο διακομιστής αλληλογραφίας σας δεν μπόρεσε να επιβεβαιώσει ότι αυτό το μήνυμα προέρχεται πράγματι από τον αποστολέα του.';

  @override
  String conversationSecurityAuthFailedListText(String domain) {
    return 'Ο διακομιστής αλληλογραφίας σας δεν μπόρεσε να επιβεβαιώσει ότι αυτό το μήνυμα προέρχεται από το $domain. Συνηθισμένο στις λίστες αλληλογραφίας.';
  }

  @override
  String get conversationSecurityAuthFailedListTextNoDomain =>
      'Ο διακομιστής αλληλογραφίας σας δεν μπόρεσε να επιβεβαιώσει ότι αυτό το μήνυμα προέρχεται από τον αποστολέα του. Συνηθισμένο στις λίστες αλληλογραφίας.';

  @override
  String get conversationSecurityAuthFailedAdvice =>
      'Μην κάνετε τίποτα με βάση αυτό, εκτός αν το περιμένατε. Αν έχετε αμφιβολίες, επικοινωνήστε με τον αποστολέα με άλλον τρόπο.';

  @override
  String get conversationSecurityAuthUnalignedTitle => 'Υπογεγραμμένο από άλλον τομέα';

  @override
  String conversationSecurityAuthUnalignedText(String signer, String domain) {
    return 'Το μήνυμα είναι υπογεγραμμένο από το $signer, όχι από το $domain. Οι υπηρεσίες μαζικής αποστολής το κάνουν αυτό, αλλά δεν αποδεικνύει ποιος το έγραψε.';
  }

  @override
  String conversationSecurityAuthUnalignedTextNoSigner(String domain) {
    return 'Το μήνυμα είναι υπογεγραμμένο από άλλον τομέα, όχι από το $domain. Οι υπηρεσίες μαζικής αποστολής το κάνουν αυτό, αλλά δεν αποδεικνύει ποιος το έγραψε.';
  }

  @override
  String get conversationSecurityNameShowsAddressTitle => 'Το όνομα δείχνει άλλη διεύθυνση';

  @override
  String conversationSecurityNameShowsAddressText(String shown, String email) {
    return 'Το όνομα του αποστολέα γράφει «$shown», αλλά το μήνυμα προέρχεται από το $email.';
  }

  @override
  String get conversationSecurityNameShowsAddressAdvice => 'Εμπιστευτείτε τη διεύθυνση, όχι το όνομα.';

  @override
  String get conversationSecurityReplyToTitle => 'Οι απαντήσεις πηγαίνουν αλλού';

  @override
  String conversationSecurityReplyToText(String address, String domain) {
    return 'Αν απαντήσετε, η απάντησή σας θα σταλεί στο $address, όχι στο $domain.';
  }

  @override
  String get conversationSecurityReplyToAdvice =>
      'Ελέγξτε τη διεύθυνση πριν στείλετε στην απάντηση οτιδήποτε προσωπικό.';

  @override
  String get conversationSecurityImpersonationYouTitle => 'Χρησιμοποιεί το όνομά σας';

  @override
  String get conversationSecurityImpersonationTitle => 'Χρησιμοποιεί το όνομα κάποιου που γνωρίζετε';

  @override
  String conversationSecurityImpersonationYouText(String name, String email) {
    return 'Είναι υπογεγραμμένο «$name», όπως το δικό σας όνομα, αλλά προέρχεται από νέα διεύθυνση: $email.';
  }

  @override
  String conversationSecurityImpersonationVipText(String name, String knownName, String knownEmail, String email) {
    return 'Είναι υπογεγραμμένο «$name», όπως η επαφή VIP σας $knownName ($knownEmail), αλλά προέρχεται από νέα διεύθυνση: $email.';
  }

  @override
  String conversationSecurityImpersonationText(String name, String knownName, String knownEmail, String email) {
    return 'Είναι υπογεγραμμένο «$name», όπως η επαφή σας $knownName ($knownEmail), αλλά προέρχεται από νέα διεύθυνση: $email.';
  }

  @override
  String get conversationSecurityImpersonationRepliesElsewhere =>
      'Και οι απαντήσεις θα πήγαιναν σε μια ακόμη διαφορετική διεύθυνση.';

  @override
  String get conversationSecurityImpersonationAdvice =>
      'Αν ζητά χρήματα, κωδικούς ή αρχεία, επιβεβαιώστε πρώτα με το άτομο με άλλον τρόπο.';

  @override
  String conversationSecurityKnownAddress(String address) {
    return 'Γνωστή διεύθυνση: $address';
  }

  @override
  String conversationSecurityThisAddress(String address) {
    return 'Αυτή η διεύθυνση: $address';
  }

  @override
  String get conversationSecurityFirstTimeTitle => 'Πρώτο μήνυμα από αυτόν τον αποστολέα';

  @override
  String conversationSecurityFirstTimeText(String email) {
    return 'Δεν έχετε λάβει ξανά μηνύματα από το $email.';
  }

  @override
  String get conversationSecurityFirstTimeAdvice => 'Προσέχετε τα αιτήματα από άτομα που δεν γνωρίζετε ακόμη.';

  @override
  String get conversationSecuritySenderHomographTitle => 'Γράμματα που μοιάζουν στη διεύθυνση του αποστολέα';

  @override
  String get conversationSecurityLinkHomographTitle => 'Γράμματα που μοιάζουν σε σύνδεσμο';

  @override
  String conversationSecurityHomographText(String host) {
    return 'Το $host αναμειγνύει γράμματα από διαφορετικά αλφάβητα για να μιμηθεί άλλη διεύθυνση.';
  }

  @override
  String conversationSecurityHomographImitatesText(String host, String real) {
    return 'Το $host χρησιμοποιεί γράμματα που μοιάζουν: δεν είναι το $real.';
  }

  @override
  String get conversationSecuritySenderHomographAdvice => 'Διαγράψτε το ή αναφέρετέ το ως ανεπιθύμητο.';

  @override
  String get conversationSecurityLinkHomographAdvice => 'Μην τον ανοίξετε.';

  @override
  String conversationSecurityDomainDetail(String domain) {
    return 'Τομέας: $domain';
  }

  @override
  String get conversationSecurityLookalikeTitle => 'Τομέας που μιμείται άλλον';

  @override
  String get conversationSecurityFamiliarNameTitle => 'Χρησιμοποιεί γνωστό όνομα στον τομέα του';

  @override
  String conversationSecurityLookalikeOwnText(String domain, String real) {
    return 'Το $domain μοιάζει με τον δικό σας τομέα, $real, αλλά είναι διαφορετικός τομέας.';
  }

  @override
  String conversationSecurityLookalikeText(String domain, String brand, String real) {
    return 'Το $domain μοιάζει με $brand ($real), αλλά είναι διαφορετικός τομέας.';
  }

  @override
  String conversationSecurityFamiliarNameOwnText(String domain, String real) {
    return 'Το $domain χρησιμοποιεί το όνομα του δικού σας τομέα, $real, αλλά δεν ανήκει σε αυτόν.';
  }

  @override
  String conversationSecurityFamiliarNameText(String domain, String brand, String real) {
    return 'Το $domain χρησιμοποιεί το όνομα $brand ($real), αλλά δεν σχετίζεται με αυτό.';
  }

  @override
  String conversationSecurityLookalikeOwnAdvice(String real) {
    return 'Τα γνήσια μηνύματα του οργανισμού σας προέρχονται από το $real.';
  }

  @override
  String conversationSecurityLookalikeAdvice(String brand, String real) {
    return 'Τα γνήσια μηνύματα από $brand προέρχονται από το $real.';
  }

  @override
  String conversationSecuritySenderDomain(String domain) {
    return 'Τομέας αποστολέα: $domain';
  }

  @override
  String conversationSecurityImitates(String domain) {
    return 'Μιμείται: $domain';
  }

  @override
  String conversationSecurityLinkMismatchTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count σύνδεσμοι κρύβουν πού οδηγούν',
      one: 'Ένας σύνδεσμος κρύβει πού οδηγεί',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityLinkMismatchText(String shown, String host) {
    return 'Ένας σύνδεσμος δείχνει $shown, αλλά ανοίγει το $host.';
  }

  @override
  String get conversationSecurityLinkMismatchAdvice =>
      'Μη συνδεθείτε και μην πληρώσετε μέσω αυτών των συνδέσμων. Πληκτρολογήστε καλύτερα τη διεύθυνση μόνοι σας.';

  @override
  String conversationSecurityLinkDetail(String text, String url) {
    return '«$text» → $url';
  }

  @override
  String get conversationSecurityLinkUncheckableTitle => 'Ο προορισμός ενός συνδέσμου δεν μπορεί να ελεγχθεί';

  @override
  String conversationSecurityLinkUncheckableText(String shown, String host) {
    return 'Ένας σύνδεσμος δείχνει $shown, αλλά περνά μέσω του $host, που καταγράφει το κλικ πριν το προωθήσει.';
  }

  @override
  String get conversationSecurityIpAddressTitle => 'Ένας σύνδεσμος οδηγεί σε σκέτη διεύθυνση IP';

  @override
  String conversationSecurityIpAddressText(String hosts) {
    return 'Το $hosts δεν είναι ιστότοπος με όνομα. Οι πραγματικές εταιρείες σπάνια βάζουν τέτοιους συνδέσμους.';
  }

  @override
  String get conversationSecurityUserInfoTitle => 'Ένας μεταμφιεσμένος σύνδεσμος';

  @override
  String conversationSecurityUserInfoText(String shown, String host) {
    return 'Ένας σύνδεσμος ξεκινά με «$shown@» για να μοιάζει με $shown, αλλά ανοίγει το $host.';
  }

  @override
  String get conversationSecurityDataLinkTitle => 'Μια κρυφή σελίδα απενεργοποιήθηκε';

  @override
  String get conversationSecurityDataLinkText =>
      'Ένας σύνδεσμος θα άνοιγε μια σελίδα κρυμμένη μέσα στο μήνυμα, έναν τρόπο να παρακαμφθούν οι έλεγχοι συνδέσμων.';

  @override
  String get conversationSecurityPasswordFieldTitle => 'Ζητά κωδικό πρόσβασης';

  @override
  String get conversationSecurityPasswordFieldText =>
      'Το μήνυμα περιείχε πεδίο κωδικού πρόσβασης. Το Loupe το αφαίρεσε.';

  @override
  String get conversationSecurityPasswordFieldAdvice => 'Μην πληκτρολογείτε ποτέ κωδικό πρόσβασης μέσα σε email.';

  @override
  String get conversationSecurityScriptLinkTitle => 'Ένας σύνδεσμος που εκτελεί κώδικα απενεργοποιήθηκε';

  @override
  String get conversationSecurityScriptLinkText => 'Το Loupe δεν εκτελεί ποτέ κώδικα από μηνύματα.';

  @override
  String conversationSecurityShortenerTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Συντομευμένοι σύνδεσμοι',
      one: 'Συντομευμένος σύνδεσμος',
    );
    return '$_temp0';
  }

  @override
  String conversationSecurityShortenerText(String hosts) {
    return 'Το $hosts κρύβει τον πραγματικό προορισμό μέχρι να τον ανοίξετε.';
  }

  @override
  String get conversationSecurityInternationalTitle => 'Διεθνής διεύθυνση ιστού';

  @override
  String conversationSecurityInternationalText(String hosts) {
    return 'Το $hosts χρησιμοποιεί μη λατινικά γράμματα. Είναι φυσιολογικό για πολλές γλώσσες· ελέγξτε ότι είναι ο ιστότοπος που περιμένετε.';
  }

  @override
  String get conversationSecurityLotsOfHiddenTextTitle => 'Πολύ κρυφό κείμενο';

  @override
  String conversationSecurityLotsOfHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Αφαιρέθηκαν $count χαρακτήρες αόρατου κειμένου. Τέτοιο κρυφό κείμενο έχει σκοπό να ξεγελάσει τα φίλτρα ανεπιθύμητων.',
      one: 'Αφαιρέθηκε 1 χαρακτήρας αόρατου κειμένου. Τέτοιο κρυφό κείμενο έχει σκοπό να ξεγελάσει τα φίλτρα ανεπιθύμητων.',
    );
    return '$_temp0';
  }

  @override
  String get conversationSecurityHiddenTextTitle => 'Αφαιρέθηκε κρυφό κείμενο';

  @override
  String conversationSecurityHiddenTextText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αφαιρέθηκαν $count χαρακτήρες αόρατου κειμένου.',
      one: 'Αφαιρέθηκε 1 χαρακτήρας αόρατου κειμένου.',
    );
    return '$_temp0';
  }

  @override
  String get exportDownloadFailed => 'Δεν ήταν δυνατή η λήψη του μηνύματος. Ελέγξτε τη σύνδεση και δοκιμάστε ξανά.';

  @override
  String exportSaved(String name) {
    return 'Αποθηκεύτηκε το «$name»';
  }

  @override
  String get exportSaveFailed => 'Δεν ήταν δυνατή η αποθήκευση του μηνύματος.';

  @override
  String exportFailed(String folder) {
    return 'Δεν ήταν δυνατή η εξαγωγή του «$folder».';
  }

  @override
  String exportEmpty(String folder) {
    return 'Ο φάκελος «$folder» δεν έχει μηνύματα για εξαγωγή.';
  }

  @override
  String exportNothingDownloaded(String folder) {
    return 'Δεν ήταν δυνατή η εξαγωγή του «$folder»: δεν ήταν δυνατή η λήψη κανενός μηνύματος. Ελέγξτε τη σύνδεση και δοκιμάστε ξανά.';
  }

  @override
  String exportSavedWithout(int count, String formattedCount, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Το «$name» αποθηκεύτηκε χωρίς $formattedCount μηνύματα που δεν ήταν δυνατό να ληφθούν.',
      one: 'Το «$name» αποθηκεύτηκε χωρίς 1 μήνυμα που δεν ήταν δυνατό να ληφθεί.',
    );
    return '$_temp0';
  }

  @override
  String exportSaveFileFailed(String name) {
    return 'Δεν ήταν δυνατή η αποθήκευση του «$name».';
  }

  @override
  String exportTitle(String folder) {
    return 'Εξαγωγή του «$folder»';
  }

  @override
  String get exportListing => 'Εύρεση μηνυμάτων…';

  @override
  String exportProgress(String current, String total) {
    return 'Εξαγωγή $current από $total…';
  }

  @override
  String exportFailedCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Δεν ήταν δυνατή η λήψη $formattedCount μηνυμάτων',
      one: 'Δεν ήταν δυνατή η λήψη 1 μηνύματος',
    );
    return '$_temp0';
  }

  @override
  String get mailboxesTitle => 'Γραμματοκιβώτια';

  @override
  String get mailboxesShown => 'Εμφανίζεται';

  @override
  String get mailboxesHidden => 'Κρυφό';

  @override
  String get mailboxesCollapse => 'Σύμπτυξη';

  @override
  String get mailboxesExpand => 'Ανάπτυξη';

  @override
  String get mailboxesManageVips => 'Διαχείριση VIP';

  @override
  String get mailboxesSubscriptions => 'Συνδρομές';

  @override
  String mailboxesShowAccount(String account) {
    return 'Εμφάνιση $account';
  }

  @override
  String mailboxesHideAccount(String account) {
    return 'Απόκρυψη $account';
  }

  @override
  String get mailboxesExportFolder => 'Εξαγωγή φακέλου…';

  @override
  String get mailboxesUnpin => 'Ξεκαρφίτσωμα';

  @override
  String get mailboxesLists => 'Λίστες';

  @override
  String get mailboxesSmartMailboxes => 'Smart Mailboxes';

  @override
  String get mailboxesSmartMailboxesEmpty => 'Αποθηκεύστε μια αναζήτηση για να τη βρίσκετε εδώ.';

  @override
  String get mailboxesTags => 'Ετικέτες';

  @override
  String get mailboxesVipTitle => 'VIP';

  @override
  String get mailboxesVipFooter =>
      'Μπορείτε επίσης να πατήσετε το όνομα ενός αποστολέα σε ένα μήνυμα και να ενεργοποιήσετε το VIP.';

  @override
  String get mailboxesAddVip => 'Προσθήκη VIP…';

  @override
  String get mailboxesAddVipTitle => 'Προσθήκη VIP';

  @override
  String get mailboxesAddVipText =>
      'Τα μηνύματα από αυτή τη διεύθυνση παίρνουν αστέρι και εμφανίζονται στο γραμματοκιβώτιο VIP.';

  @override
  String get mailboxesAddVipPlaceholder => 'name@example.com';

  @override
  String get messageListFilterUnread => 'Μη αναγνωσμένα';

  @override
  String get messageListFilterFlagged => 'Με σημαία';

  @override
  String get messageListFilterToMe => 'Προς: εμένα';

  @override
  String get messageListFilterCcMe => 'Κοιν.: εμένα';

  @override
  String get messageListFilterWithAttachments => 'Με συνημμένα';

  @override
  String get messageListFilterUnreplied => 'Χωρίς απάντηση';

  @override
  String get messageListFilterFromVips => 'Από VIP';

  @override
  String messageListMarkedRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count μηνύματα σημάνθηκαν ως αναγνωσμένα',
      one: '1 μήνυμα σημάνθηκε ως αναγνωσμένο',
    );
    return '$_temp0';
  }

  @override
  String get messageListLoadOlderFailed => 'Δεν ήταν δυνατή η φόρτωση παλαιότερων μηνυμάτων.';

  @override
  String get messageListSelectMessages => 'Επιλογή μηνυμάτων';

  @override
  String messageListSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count επιλεγμένες', one: '1 επιλεγμένη');
    return '$_temp0';
  }

  @override
  String get messageListSelectAll => 'Επιλογή όλων';

  @override
  String get messageListDeselectAll => 'Αποεπιλογή όλων';

  @override
  String get messageListLoadFailed => 'Δεν ήταν δυνατή η φόρτωση της αλληλογραφίας';

  @override
  String get messageListNoUnread => 'Κανένα μη αναγνωσμένο μήνυμα';

  @override
  String get messageListNoMatches => 'Κανένα μήνυμα δεν ταιριάζει';

  @override
  String messageListFilteredByDetail(String filters) {
    return 'Φιλτράρισμα κατά: $filters';
  }

  @override
  String get messageListTurnOffFilter => 'Απενεργοποίηση φίλτρου';

  @override
  String get messageListEmpty => 'Κανένα μήνυμα';

  @override
  String get messageListFilter => 'Φίλτρο';

  @override
  String messageListFilterCriteria(String filters) {
    return 'Κριτήρια φίλτρου: $filters';
  }

  @override
  String get messageListFilteredBy => 'Φιλτράρισμα κατά:';

  @override
  String messageListUnreadCount(int count, String formattedCount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formattedCount μη αναγνωσμένα',
      one: '$formattedCount μη αναγνωσμένο',
    );
    return '$_temp0';
  }

  @override
  String get messageListMark => 'Σήμανση';

  @override
  String get messageListTrash => 'Στον κάδο';

  @override
  String get messageListFilterTitle => 'Φίλτρο';

  @override
  String get messageListFilterInclude => 'ΣΥΜΠΕΡΙΛΗΨΗ';

  @override
  String get panesHideMailboxes => 'Απόκρυψη γραμματοκιβωτίων';

  @override
  String get panesShowMailboxes => 'Εμφάνιση γραμματοκιβωτίων';

  @override
  String get panesMailboxesWidth => 'Πλάτος γραμματοκιβωτίων';

  @override
  String get panesListWidth => 'Πλάτος λίστας μηνυμάτων';

  @override
  String get panesNoMessageSelected => 'Δεν επιλέχθηκε μήνυμα';

  @override
  String panesDragCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count μηνύματα', one: '1 μήνυμα');
    return '$_temp0';
  }

  @override
  String get snoozeTitle => 'Σε αναβολή';

  @override
  String get snoozeSheetTitle => 'Αναβολή';

  @override
  String get snoozeLaterToday => 'Αργότερα σήμερα';

  @override
  String get snoozeThisEvening => 'Απόψε';

  @override
  String get snoozeTomorrow => 'Αύριο';

  @override
  String get snoozeThisWeekend => 'Αυτό το Σαββατοκύριακο';

  @override
  String get snoozeNextWeek => 'Επόμενη εβδομάδα';

  @override
  String get snoozePickDateTime => 'Επιλογή ημερομηνίας και ώρας…';

  @override
  String get snoozeMenu => 'Αναβολή…';

  @override
  String get snoozeWakeNow => 'Επαναφορά τώρα';

  @override
  String get snoozeChangeTimeMenu => 'Αλλαγή ώρας αναβολής…';

  @override
  String get snoozeChangeTime => 'Αλλαγή ώρας';

  @override
  String get snoozeNoTime => 'Δεν έχει οριστεί ώρα';

  @override
  String get snoozeFooter =>
      'Τα μηνύματα σε αναβολή επιστρέφουν στα Εισερχόμενα, ως μη αναγνωσμένα, την ώρα που ορίσατε.';

  @override
  String get snoozeEmptyTitle => 'Τίποτα σε αναβολή';

  @override
  String get snoozeEmptyText => 'Αναβάλετε ένα μήνυμα για να επιστρέψει στα Εισερχόμενα όταν το χρειάζεστε.';

  @override
  String get appLockUnlock => 'Ξεκλείδωμα';

  @override
  String get appLockFailed => 'Το Loupe δεν μπόρεσε να επιβεβαιώσει ότι είστε εσείς.';

  @override
  String get appLockLockedOut => 'Πάρα πολλές προσπάθειες. Δοκιμάστε ξανά αργότερα.';

  @override
  String get appLockPromptError => 'Δεν ήταν δυνατή η εμφάνιση του παραθύρου επιβεβαίωσης. Δοκιμάστε ξανά.';

  @override
  String get appLockNoScreenLock => 'Αυτό το τηλέφωνο δεν έχει κλείδωμα οθόνης.';

  @override
  String get appLockUnlockPromptTitle => 'Ξεκλείδωμα του Loupe';

  @override
  String get appLockUnlockPromptReason => 'Επιβεβαιώστε ότι είστε εσείς για να δείτε την αλληλογραφία σας.';

  @override
  String get appLockTurnOnPromptTitle => 'Ενεργοποίηση κλειδώματος εφαρμογής';

  @override
  String get appLockTurnOnPromptReason => 'Επιβεβαιώστε ότι είστε εσείς για να ενεργοποιήσετε το κλείδωμα εφαρμογής.';

  @override
  String get appLockScreenLockRemoved =>
      'Το κλείδωμα εφαρμογής απενεργοποιήθηκε: αυτό το τηλέφωνο δεν έχει πλέον κλείδωμα οθόνης. Ορίστε ένα για να ενεργοποιήσετε ξανά το κλείδωμα εφαρμογής.';

  @override
  String get appLockAfterImmediately => 'Αμέσως';

  @override
  String appLockAfterMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count λεπτά', one: '1 λεπτό');
    return '$_temp0';
  }

  @override
  String appLockAfterHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ώρες', one: '1 ώρα');
    return '$_temp0';
  }

  @override
  String get openpgpEncrypted => 'Κρυπτογραφημένο';

  @override
  String get openpgpEncryptedInPart => 'Μερικώς κρυπτογραφημένο';

  @override
  String get openpgpEncryptedLocked => 'Κρυπτογραφημένο · κλειδωμένο';

  @override
  String get openpgpEncryptedNoKey => 'Κρυπτογραφημένο · χωρίς κλειδί';

  @override
  String get openpgpEncryptedDamaged => 'Κρυπτογραφημένο · κατεστραμμένο';

  @override
  String get openpgpEncryptedUnsupported => 'Κρυπτογραφημένο · δεν υποστηρίζεται';

  @override
  String get openpgpUnknownSigner => 'άγνωστο';

  @override
  String get openpgpUnknownKey => 'Άγνωστο κλειδί';

  @override
  String get openpgpSignatureInvalid => 'Μη έγκυρη υπογραφή';

  @override
  String openpgpSignedByNotSender(String name) {
    return 'Υπογεγραμμένο από $name, όχι από τον αποστολέα';
  }

  @override
  String openpgpSignedInPartBy(String name) {
    return 'Μερικώς υπογεγραμμένο από $name';
  }

  @override
  String openpgpSignedBy(String name) {
    return 'Υπογεγραμμένο από $name';
  }

  @override
  String get openpgpSignedWithRejectedKey => 'Υπογεγραμμένο με απορριφθέν κλειδί';

  @override
  String openpgpSignedByNotAccepted(String name) {
    return 'Υπογεγραμμένο από $name · το κλειδί δεν έχει γίνει αποδεκτό';
  }

  @override
  String get openpgpUnlock => 'Ξεκλείδωμα';

  @override
  String get openpgpCantDecrypt => 'Δεν είναι δυνατή η αποκρυπτογράφηση αυτού του μηνύματος';

  @override
  String get openpgpEncryptedWithOpenPgp => 'Κρυπτογραφημένο με OpenPGP';

  @override
  String get openpgpEncryption => 'Κρυπτογράφηση';

  @override
  String get openpgpDecryptedHere => 'Αποκρυπτογραφήθηκε σε αυτή τη συσκευή';

  @override
  String get openpgpNotDecrypted => 'Δεν αποκρυπτογραφήθηκε';

  @override
  String get openpgpKeyLocked => 'Το κλειδί σας είναι κλειδωμένο.';

  @override
  String openpgpForKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Για τα κλειδιά $keys',
      one: 'Για το κλειδί $keys',
    );
    return '$_temp0';
  }

  @override
  String get openpgpProtectedSubject => 'Προστατευμένο θέμα';

  @override
  String get openpgpUnlockKey => 'Ξεκλείδωμα κλειδιού';

  @override
  String get openpgpSignature => 'Υπογραφή';

  @override
  String get openpgpFingerprint => 'Αποτύπωμα';

  @override
  String openpgpKeyIdValue(String id) {
    return 'Αναγνωριστικό κλειδιού $id';
  }

  @override
  String get openpgpSigned => 'Υπογράφηκε';

  @override
  String get openpgpProblem => 'Πρόβλημα';

  @override
  String get openpgpAcceptance => 'Αποδοχή';

  @override
  String get openpgpChangeAcceptance => 'Αλλαγή αποδοχής…';

  @override
  String get openpgpCheckedFooter => 'Ελέγχθηκε σε αυτή τη συσκευή με OpenPGP, συμβατό με το Thunderbird.';

  @override
  String get openpgpSummaryLocked =>
      'Το κλειδί σας είναι κλειδωμένο. Ξεκλειδώστε το με τη φράση πρόσβασής του για να διαβάσετε αυτό το μήνυμα.';

  @override
  String get openpgpSummaryNoSecretKey => 'Κρυπτογραφήθηκε για ένα κλειδί που δεν υπάρχει σε αυτή τη συσκευή.';

  @override
  String get openpgpSummaryDamaged => 'Τα κρυπτογραφημένα δεδομένα είναι κατεστραμμένα ή άλλαξαν στη διαδρομή.';

  @override
  String get openpgpSummaryUnsupported => 'Χρησιμοποιεί αλγόριθμο που το Loupe δεν υποστηρίζει.';

  @override
  String get openpgpSummaryEncrypted => 'Μόνο εσείς και οι άλλοι παραλήπτες μπορείτε να το διαβάσετε.';

  @override
  String get openpgpSummaryNotSigned => 'Δεν είναι υπογεγραμμένο, οπότε ο αποστολέας δεν είναι επιβεβαιωμένος.';

  @override
  String get openpgpSummaryUnknownKey =>
      'Είναι υπογεγραμμένο, αλλά με κλειδί που δεν έχετε, οπότε η υπογραφή δεν μπορεί να ελεγχθεί.';

  @override
  String get openpgpSummaryBadSignature => 'Η υπογραφή δεν ταιριάζει: το μήνυμα μπορεί να έχει αλλοιωθεί.';

  @override
  String get openpgpSummaryMismatch =>
      'Η υπογραφή είναι έγκυρη, αλλά το κλειδί ανήκει σε άλλη διεύθυνση από αυτή του αποστολέα.';

  @override
  String get openpgpSummaryPartial =>
      'Μόνο μέρος του μηνύματος είναι υπογεγραμμένο. Το κείμενο εκτός της υπογραφής (για παράδειγμα, το υποσέλιδο μιας λίστας αλληλογραφίας) εμφανίζεται κάτω από τη γραμμή «Unsigned content», ενώ ούτε τα άλλα μέρη του μηνύματος, όπως τα συνημμένα, καλύπτονται.';

  @override
  String get openpgpSummaryOwnKey => 'Υπογεγραμμένο με το δικό σας κλειδί.';

  @override
  String get openpgpSummaryVerified => 'Η υπογραφή είναι έγκυρη και έχετε επαληθεύσει το αποτύπωμα του κλειδιού.';

  @override
  String get openpgpSummaryUnverified =>
      'Η υπογραφή είναι έγκυρη. Αποδεχτήκατε το κλειδί χωρίς να ελέγξετε το αποτύπωμά του.';

  @override
  String get openpgpSummaryRejected => 'Η υπογραφή είναι έγκυρη, αλλά έχετε απορρίψει αυτό το κλειδί.';

  @override
  String get openpgpSummaryUndecided =>
      'Η υπογραφή είναι έγκυρη, αλλά δεν έχετε αποδεχτεί ακόμη αυτό το κλειδί. Συγκρίνετε το αποτύπωμά του με τον αποστολέα.';

  @override
  String get openpgpAcceptanceRejected => 'Απορρίφθηκε';

  @override
  String get openpgpAcceptanceUndecided => 'Δεν έγινε αποδεκτό';

  @override
  String get openpgpAcceptanceUnverified => 'Αποδεκτό';

  @override
  String get openpgpAcceptanceVerified => 'Αποδεκτό και επαληθευμένο';

  @override
  String openpgpAcceptKeyTitle(String name) {
    return 'Αποδοχή του κλειδιού της επαφής $name;';
  }

  @override
  String openpgpFingerprintValue(String fingerprint) {
    return 'Αποτύπωμα $fingerprint';
  }

  @override
  String get openpgpAcceptVerified => 'Ναι, επαλήθευσα το αποτύπωμα';

  @override
  String get openpgpAcceptUnverified => 'Ναι, χωρίς έλεγχο';

  @override
  String get openpgpAcceptLater => 'Όχι ακόμη';

  @override
  String get openpgpRejectKey => 'Απόρριψη αυτού του κλειδιού';

  @override
  String get openpgpNoSubject => '(χωρίς θέμα)';

  @override
  String get openpgpEncryptionTitle => 'Κρυπτογράφηση από άκρο σε άκρο';

  @override
  String get openpgpMyKeys => 'Τα κλειδιά μου OpenPGP';

  @override
  String get openpgpMyKeysFooter =>
      'Με ένα κλειδί μπορείτε να διαβάζετε κρυπτογραφημένα μηνύματα και να υπογράφετε και να κρυπτογραφείτε τα δικά σας. Χρησιμοποιείτε το Thunderbird; Εξαγάγετε το κλειδί σας από εκεί (Ρυθμίσεις λογαριασμού › Κρυπτογράφηση από άκρο σε άκρο › Εξαγωγή μυστικού κλειδιού) και εισαγάγετέ το εδώ.';

  @override
  String get openpgpAddKey => 'Προσθήκη κλειδιού…';

  @override
  String get openpgpAddresses => 'Διευθύνσεις';

  @override
  String get openpgpAddressesFooter => 'Ποιο κλειδί χρησιμοποιεί κάθε διεύθυνση και πότε κρυπτογραφεί και υπογράφει.';

  @override
  String get openpgpCorrespondentsKeys => 'Κλειδιά OpenPGP επαφών';

  @override
  String get openpgpCorrespondentsKeysFooter =>
      'Αποδεχτείτε ένα κλειδί μόλις βεβαιωθείτε ότι ανήκει στον κάτοχό του· συγκρίνετε το αποτύπωμα μαζί του για να το σημειώσετε ως επαληθευμένο.';

  @override
  String get openpgpImportPublicKey => 'Εισαγωγή δημόσιου κλειδιού…';

  @override
  String get openpgpCollected => 'Συλλέχθηκαν μέσω Autocrypt';

  @override
  String get openpgpCollectedFooter =>
      'Κλειδιά που ήρθαν μαζί με μηνύματα. Το Loupe μπορεί να κρυπτογραφεί για αυτά όταν το ζητούν και οι δύο πλευρές.';

  @override
  String get openpgpOnThisDevice => 'Σε αυτή τη συσκευή';

  @override
  String get openpgpOnThisDeviceFooter =>
      'Τα κρυπτογραφημένα μηνύματα κρύβουν το θέμα τους. Το Loupe κρατά το θέμα κάθε μηνύματος που ανοίγετε στην κρυπτογραφημένη βάση δεδομένων του σε αυτή τη συσκευή, ώστε να εμφανίζεται στη λίστα, στην αναζήτηση και στις ειδοποιήσεις. Στο παρασκήνιο, το Loupe μπορεί επίσης να αποκρυπτογραφεί τα θέματα νέων μηνυμάτων με κλειδιά χωρίς φράση πρόσβασης· για τον σκοπό αυτό κατεβάζει κάθε μήνυμα (έως 1 MB).';

  @override
  String get openpgpDecryptSubjects => 'Αποκρυπτογράφηση θεμάτων στο παρασκήνιο';

  @override
  String get openpgpIndexFooter =>
      'Η αναζήτηση βρίσκει κρυπτογραφημένα μηνύματα με βάση τον αποστολέα, τους παραλήπτες και το θέμα. Με αυτή τη ρύθμιση ενεργή, το Loupe προσθέτει επίσης το κείμενο κάθε κρυπτογραφημένου μηνύματος που αποκρυπτογραφεί στο ευρετήριο αναζήτησης της κρυπτογραφημένης βάσης δεδομένων του σε αυτή τη συσκευή, ώστε η αναζήτηση να το βρίσκει και από το κείμενό του. Η απενεργοποίηση αφαιρεί αυτό το κείμενο από το ευρετήριο.';

  @override
  String get openpgpIndexDecrypted => 'Ευρετηρίαση αποκρυπτογραφημένων μηνυμάτων για αναζήτηση';

  @override
  String get openpgpPassphrases => 'Φράσεις πρόσβασης';

  @override
  String get openpgpPassphrasesFooter =>
      'Τα κλειδιά OpenPGP και τα πιστοποιητικά S/MIME που προστατεύετε με φράση πρόσβασης ξεκλειδώνονται όταν χρειάζεται. Χωρίς την «Απομνημόνευση φράσεων πρόσβασης», κλειδώνουν ξανά δύο λεπτά μετά από κάθε χρήση.';

  @override
  String get openpgpRememberPassphrases => 'Απομνημόνευση φράσεων πρόσβασης';

  @override
  String get openpgpRememberPassphrasesDetail => 'Μέχρι να κλείσει το Loupe';

  @override
  String get openpgpLockKeysNow => 'Κλείδωμα κλειδιών τώρα';

  @override
  String get openpgpKeysLocked => 'Τα κλειδιά κλειδώθηκαν.';

  @override
  String get openpgpKeyStateRevoked => 'ανακλήθηκε';

  @override
  String get openpgpKeyStateExpired => 'έληξε';

  @override
  String get openpgpKeyStateNeverExpires => 'δεν λήγει ποτέ';

  @override
  String openpgpKeyStateExpires(String date) {
    return 'λήγει $date';
  }

  @override
  String get openpgpNoKey => 'Χωρίς κλειδί';

  @override
  String get openpgpAlwaysEncrypt => 'Πάντα κρυπτογράφηση';

  @override
  String get openpgpAddKeyTitle => 'Προσθήκη κλειδιού OpenPGP';

  @override
  String get openpgpAddKeyMessage => 'Εισαγάγετε το κλειδί που χρησιμοποιείτε στο Thunderbird ή δημιουργήστε ένα νέο.';

  @override
  String get openpgpImportFromClipboard => 'Εισαγωγή από το πρόχειρο';

  @override
  String get openpgpImportFromFile => 'Εισαγωγή από αρχείο';

  @override
  String get openpgpGenerateNewKey => 'Δημιουργία νέου κλειδιού';

  @override
  String get openpgpImportPublicKeyTitle => 'Εισαγωγή δημόσιου κλειδιού';

  @override
  String get openpgpFromClipboard => 'Από το πρόχειρο';

  @override
  String get openpgpFromFile => 'Από αρχείο';

  @override
  String get openpgpClipboardEmpty => 'Το πρόχειρο είναι κενό. Αντιγράψτε πρώτα το κλειδί.';

  @override
  String get openpgpKey => 'Κλειδί';

  @override
  String get openpgpValidityRevoked => 'Ανακλήθηκε';

  @override
  String openpgpValidityExpired(String date) {
    return 'Έληξε στις $date';
  }

  @override
  String get openpgpNeverExpires => 'Δεν λήγει ποτέ';

  @override
  String openpgpValidUntil(String date) {
    return 'Ισχύει έως $date';
  }

  @override
  String get openpgpFingerprintCopied => 'Το αποτύπωμα αντιγράφηκε.';

  @override
  String get openpgpAlgorithm => 'Αλγόριθμος';

  @override
  String get openpgpCreated => 'Δημιουργήθηκε';

  @override
  String get openpgpValidity => 'Ισχύς';

  @override
  String get openpgpProtection => 'Προστασία';

  @override
  String get openpgpProtectionPassphrase => 'Φράση πρόσβασης';

  @override
  String get openpgpProtectionKeychain => 'Μόνο κλειδοθήκη';

  @override
  String get openpgpKeyDetailsFooter =>
      'Κοινοποιήστε το δημόσιο κλειδί σας ώστε οι άλλοι να μπορούν να σας στέλνουν κρυπτογραφημένα μηνύματα. Το αντίγραφο ασφαλείας είναι το μυστικό σας κλειδί, προστατευμένο με τη φράση πρόσβασής του αν έχει: κρατήστε το για τον εαυτό σας.';

  @override
  String get openpgpSharePublicKey => 'Κοινοποίηση δημόσιου κλειδιού';

  @override
  String get openpgpCopyPublicKey => 'Αντιγραφή δημόσιου κλειδιού';

  @override
  String get openpgpPublicKeyCopied => 'Το δημόσιο κλειδί αντιγράφηκε.';

  @override
  String get openpgpBackUpSecretKey => 'Αντίγραφο ασφαλείας μυστικού κλειδιού';

  @override
  String get openpgpDeleteKey => 'Διαγραφή κλειδιού';

  @override
  String get openpgpRemoveKey => 'Αφαίρεση κλειδιού';

  @override
  String get openpgpBackUpTitle => 'Δημιουργία αντιγράφου ασφαλείας του μυστικού κλειδιού;';

  @override
  String get openpgpBackUpProtected =>
      'Το αντίγραφο ασφαλείας προστατεύεται με τη φράση πρόσβασης του κλειδιού σας. Όποιος έχει και τα δύο μπορεί να διαβάσει την αλληλογραφία σας.';

  @override
  String get openpgpBackUpUnprotected =>
      'Αυτό το κλειδί δεν έχει φράση πρόσβασης: όποιος έχει το αντίγραφο ασφαλείας μπορεί να διαβάσει την αλληλογραφία σας και να υπογράφει ως εσείς.';

  @override
  String get openpgpBackUp => 'Δημιουργία αντιγράφου';

  @override
  String openpgpDeleteOwnKeyTitle(String name) {
    return 'Διαγραφή του κλειδιού σας $name;';
  }

  @override
  String openpgpRemoveKeyTitle(String name) {
    return 'Αφαίρεση του κλειδιού της επαφής $name;';
  }

  @override
  String get openpgpDeleteOwnKeyMessage =>
      'Τα μηνύματα που κρυπτογραφήθηκαν για αυτό το κλειδί δεν θα μπορούν πλέον να διαβαστούν σε αυτή τη συσκευή, εκτός αν το εισαγάγετε ξανά.';

  @override
  String get openpgpRemoveKeyMessage => 'Μπορείτε να το εισαγάγετε ξανά αργότερα.';

  @override
  String get openpgpKeyHeader => 'Κλειδί OpenPGP';

  @override
  String get openpgpAddressNoKeyFooter =>
      'Προσθέστε ένα κλειδί στην «Κρυπτογράφηση από άκρο σε άκρο» για να κρυπτογραφείτε και να υπογράφετε τα μηνύματα από αυτή τη διεύθυνση.';

  @override
  String get openpgpGenerateAKey => 'Δημιουργία κλειδιού…';

  @override
  String get openpgpSending => 'Αποστολή';

  @override
  String get openpgpSendingFooter =>
      'Η αυτόματη κρυπτογράφηση ενεργοποιείται όταν κάθε παραλήπτης έχει αποδεκτό κλειδί ή αξιόπιστο πιστοποιητικό, ή όταν το Autocrypt δείχνει ότι το θέλουν και οι δύο πλευρές. Τα κρυπτογραφημένα μηνύματα υπογράφονται πάντα.';

  @override
  String get openpgpEncryptAutomatically => 'Αυτόματη κρυπτογράφηση';

  @override
  String get openpgpAlwaysEncryptDetail => 'Δεν γίνεται αποστολή αν ένας παραλήπτης δεν έχει κλειδί';

  @override
  String get openpgpSignUnencrypted => 'Υπογραφή μη κρυπτογραφημένων μηνυμάτων';

  @override
  String get openpgpAttachPublicKey => 'Επισύναψη του δημόσιου κλειδιού μου';

  @override
  String get openpgpAutocryptFooter =>
      'Το Autocrypt στέλνει το δημόσιο κλειδί σας μαζί με κάθε μήνυμα, ώστε άλλες εφαρμογές να μπορούν να σας στέλνουν κρυπτογραφημένα μηνύματα χωρίς καμία ρύθμιση.';

  @override
  String get openpgpSendMyKey => 'Αποστολή του κλειδιού μου με τα μηνύματα';

  @override
  String get openpgpPreferEncryption => 'Προτίμηση κρυπτογράφησης';

  @override
  String get openpgpPreferEncryptionDetail => 'Ζητά από τους άλλους να κρυπτογραφούν όταν μπορούν';

  @override
  String openpgpValidityYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count έτη', one: '1 έτος');
    return '$_temp0';
  }

  @override
  String get openpgpPassphrasesDontMatch => 'Οι φράσεις πρόσβασης δεν ταιριάζουν.';

  @override
  String openpgpKeyReady(String id) {
    return 'Το κλειδί σας $id είναι έτοιμο.';
  }

  @override
  String get openpgpNewKey => 'Νέο κλειδί';

  @override
  String get openpgpNewKeyFor => 'Για';

  @override
  String get openpgpYourName => 'Το όνομά σας';

  @override
  String get openpgpAddress => 'Διεύθυνση';

  @override
  String get openpgpPassphrase => 'Φράση πρόσβασης';

  @override
  String get openpgpNewKeyPassphraseFooter =>
      'Προαιρετικό. Χωρίς φράση πρόσβασης, το κλειδί προστατεύεται μόνο από την κλειδοθήκη του τηλεφώνου σας και το Loupe δεν ρωτά ποτέ. Με φράση πρόσβασης, το Loupe τη ζητά όταν χρειάζεται το κλειδί.';

  @override
  String get openpgpRepeatPassphrase => 'Επανάληψη';

  @override
  String get openpgpExpires => 'Λήξη';

  @override
  String get openpgpExpiresFooter =>
      'Μπορείτε να δημιουργήσετε νέο κλειδί πριν λήξει. Και το Thunderbird χρησιμοποιεί τρία έτη.';

  @override
  String get openpgpGenerateKey => 'Δημιουργία κλειδιού';

  @override
  String get openpgpKeyFor => 'Κλειδί για';

  @override
  String get openpgpCantEncrypt => 'Αδυναμία κρυπτογράφησης';

  @override
  String openpgpNoKeyAlwaysEncrypt(String names) {
    return 'Δεν υπάρχει κλειδί OpenPGP για $names, και αυτή η διεύθυνση κρυπτογραφεί πάντα. Αφαιρέστε τον παραλήπτη ή εισαγάγετε το κλειδί του στις Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';
  }

  @override
  String openpgpNoCertificateAlwaysEncrypt(String names) {
    return 'Δεν υπάρχει έγκυρο πιστοποιητικό S/MIME για $names, και αυτή η διεύθυνση κρυπτογραφεί πάντα. Αφαιρέστε τον παραλήπτη ή εισαγάγετε το πιστοποιητικό του στις Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';
  }

  @override
  String openpgpNoKeyFor(String names) {
    return 'Δεν υπάρχει κλειδί OpenPGP για $names.';
  }

  @override
  String openpgpNoCertificateFor(String names) {
    return 'Δεν υπάρχει έγκυρο πιστοποιητικό S/MIME για $names.';
  }

  @override
  String get openpgpSendUnencrypted => 'Αποστολή χωρίς κρυπτογράφηση';

  @override
  String get openpgpCantSign => 'Αδυναμία υπογραφής';

  @override
  String get openpgpCantSignMessage =>
      'Το ιδιωτικό κλειδί του πιστοποιητικού S/MIME σας δεν υπάρχει σε αυτή τη συσκευή. Εισαγάγετε ξανά το πιστοποιητικό (αρχείο .p12 ή .pfx) στις Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';

  @override
  String openpgpComposeNoKey(String names) {
    return 'Χωρίς κλειδί για $names';
  }

  @override
  String openpgpComposeNoCertificate(String names) {
    return 'Χωρίς πιστοποιητικό για $names';
  }

  @override
  String get openpgpComposeAutocryptKeys => 'Κλειδιά από Autocrypt';

  @override
  String get openpgpComposeEveryoneHasKey => 'Όλοι έχουν κλειδί';

  @override
  String get openpgpComposeEveryoneHasCertificate => 'Όλοι έχουν πιστοποιητικό';

  @override
  String get openpgpComposeEncrypt => 'Κρυπτογράφηση';

  @override
  String get openpgpComposeSign => 'Υπογραφή';

  @override
  String openpgpComposeSwitchStandard(String standard) {
    return '$standard, εναλλαγή';
  }

  @override
  String get openpgpNoKeyFound => 'Δεν βρέθηκε κλειδί OpenPGP.';

  @override
  String get openpgpImportSecretKeyTitle => 'Εισαγωγή μυστικού κλειδιού;';

  @override
  String openpgpImportSecretKeyMessage(String names) {
    return 'Αυτό το συνημμένο περιέχει ένα μυστικό κλειδί ($names). Εισαγάγετέ το ως δικό σας κλειδί μόνο αν το εξαγάγατε εσείς, για παράδειγμα από το Thunderbird.';
  }

  @override
  String get openpgpImportAsMyKey => 'Εισαγωγή ως δικό μου κλειδί';

  @override
  String openpgpImportedOwnKey(String name) {
    return 'το κλειδί σας $name';
  }

  @override
  String openpgpImportPublicKeysTitle(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Εισαγωγή $count κλειδιών ($names);',
      one: 'Εισαγωγή του κλειδιού της επαφής $names;',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImportAndAccept => 'Εισαγωγή και αποδοχή';

  @override
  String get openpgpImportDecideLater => 'Εισαγωγή, απόφαση αργότερα';

  @override
  String openpgpImportedPublicKey(String name) {
    return 'το κλειδί της επαφής $name';
  }

  @override
  String openpgpImported(String keys) {
    return 'Εισήχθησαν: $keys.';
  }

  @override
  String openpgpKeysAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Έχουν επισυναφθεί $count κλειδιά OpenPGP.',
      one: 'Έχει επισυναφθεί ένα κλειδί OpenPGP.',
    );
    return '$_temp0';
  }

  @override
  String get openpgpImport => 'Εισαγωγή';

  @override
  String get openpgpUnlockKeyTitle => 'Ξεκλείδωμα κλειδιού OpenPGP';

  @override
  String openpgpEnterPassphrase(String name, String id) {
    return 'Εισαγάγετε τη φράση πρόσβασης του κλειδιού «$name» ($id).';
  }

  @override
  String get openpgpWrongPassphrase => 'Λανθασμένη φράση πρόσβασης. Δοκιμάστε ξανά.';

  @override
  String get openpgpExplainLocked =>
      'Αυτό το μήνυμα είναι κρυπτογραφημένο. Ξεκλειδώστε το κλειδί OpenPGP σας για να το διαβάσετε.';

  @override
  String get openpgpExplainNoKey =>
      'Αυτό το μήνυμα είναι κρυπτογραφημένο, αλλά όχι για κάποιο κλειδί OpenPGP αυτής της συσκευής. Αν το διαβάζετε στο Thunderbird, εισαγάγετε το κλειδί σας από εκεί: Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';

  @override
  String get openpgpExplainDamaged =>
      'Αυτό το κρυπτογραφημένο μήνυμα είναι κατεστραμμένο, οπότε δεν μπορεί να αποκρυπτογραφηθεί με ασφάλεια.';

  @override
  String get openpgpExplainUnsupported =>
      'Αυτό το μήνυμα χρησιμοποιεί κρυπτογράφηση που το Loupe δεν μπορεί ακόμη να διαβάσει.';

  @override
  String get openpgpExplainSmimeNoKey =>
      'Αυτό το μήνυμα είναι κρυπτογραφημένο με S/MIME, αλλά όχι για κάποιο πιστοποιητικό αυτής της συσκευής. Εισαγάγετε το πιστοποιητικό σας (αρχείο .p12 ή .pfx) στις Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';

  @override
  String openpgpExplainSmimeLocked(String reason) {
    return 'Αυτό το μήνυμα είναι κρυπτογραφημένο. $reason';
  }

  @override
  String get openpgpExplainSmimeUnlock => 'Ξεκλειδώστε το πιστοποιητικό S/MIME σας για να το διαβάσετε.';

  @override
  String get openpgpAttachmentGone => 'Αυτό το συνημμένο δεν είναι πλέον διαθέσιμο.';

  @override
  String get smimeEncrypted => 'Κρυπτογραφημένο (S/MIME)';

  @override
  String get smimeEncryptedNoCertificate => 'Κρυπτογραφημένο (S/MIME) · χωρίς πιστοποιητικό';

  @override
  String get smimeEncryptedDamaged => 'Κρυπτογραφημένο (S/MIME) · κατεστραμμένο';

  @override
  String get smimeEncryptedUnsupported => 'Κρυπτογραφημένο (S/MIME) · δεν υποστηρίζεται';

  @override
  String get smimeEncryptedLocked => 'Κρυπτογραφημένο (S/MIME) · κλειδωμένο';

  @override
  String get smimeUnknownSigner => 'άγνωστο';

  @override
  String get smimeSignatureModified => 'Μη έγκυρη υπογραφή: το μήνυμα τροποποιήθηκε';

  @override
  String get smimeSignatureWeak => 'Μη ασφαλής υπογραφή: παρωχημένος αλγόριθμος';

  @override
  String get smimeSignatureUncheckable => 'Η υπογραφή δεν μπορεί να ελεγχθεί';

  @override
  String get smimeSignedCertificateMissing => 'Υπογεγραμμένο · λείπει το πιστοποιητικό';

  @override
  String smimeSignedByRevoked(String name) {
    return 'Υπογεγραμμένο από $name · το πιστοποιητικό ανακλήθηκε';
  }

  @override
  String smimeSignedByOtherDate(String name) {
    return 'Υπογεγραμμένο από $name · σε άλλη ημερομηνία';
  }

  @override
  String smimeSignedBy(String name) {
    return 'Υπογεγραμμένο από $name';
  }

  @override
  String smimeSignedByInvalid(String name) {
    return 'Υπογεγραμμένο από $name · μη έγκυρο πιστοποιητικό';
  }

  @override
  String smimeSignedByUntrusted(String name) {
    return 'Υπογεγραμμένο από $name · μη αξιόπιστο';
  }

  @override
  String smimeSignedByExpired(String name) {
    return 'Υπογεγραμμένο από $name · το πιστοποιητικό έληξε';
  }

  @override
  String smimeSignedByNotYetValid(String name) {
    return 'Υπογεγραμμένο από $name · το πιστοποιητικό δεν ισχύει ακόμη';
  }

  @override
  String smimeSignedByNotForMail(String name) {
    return 'Υπογεγραμμένο από $name · το πιστοποιητικό δεν είναι για email';
  }

  @override
  String smimeSignedByNotSender(String name) {
    return 'Υπογεγραμμένο από $name, όχι από τον αποστολέα';
  }

  @override
  String get smimeCantDecrypt => 'Δεν είναι δυνατή η αποκρυπτογράφηση αυτού του μηνύματος';

  @override
  String get smimeEncryptedWithSmime => 'Κρυπτογραφημένο με S/MIME';

  @override
  String get smimeEncryption => 'Κρυπτογράφηση';

  @override
  String get smimeDecryptedHere => 'Αποκρυπτογραφήθηκε σε αυτή τη συσκευή';

  @override
  String get smimeNotDecrypted => 'Δεν αποκρυπτογραφήθηκε';

  @override
  String get smimeAuthenticated => 'με έλεγχο ακεραιότητας';

  @override
  String smimeForCertificates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'για $count πιστοποιητικά',
      one: 'για 1 πιστοποιητικό',
    );
    return '$_temp0';
  }

  @override
  String get smimeSignature => 'Υπογραφή';

  @override
  String get smimeIssuedBy => 'Εκδότης';

  @override
  String get smimeValid => 'Ισχύς';

  @override
  String smimeValidRange(String from, String to) {
    return '$from έως $to';
  }

  @override
  String get smimeSha256Fingerprint => 'Αποτύπωμα SHA-256';

  @override
  String get smimeSigned => 'Υπογράφηκε';

  @override
  String get smimeProblem => 'Πρόβλημα';

  @override
  String get smimeCheckingRevocation => 'Έλεγχος ανάκλησης…';

  @override
  String get smimeNotRevoked => 'Δεν έχει ανακληθεί';

  @override
  String get smimeRevoked => 'Ανακλήθηκε';

  @override
  String get smimeRevocationUnknown => 'Άγνωστη κατάσταση ανάκλησης';

  @override
  String smimeRevokedSince(String date) {
    return 'Από $date';
  }

  @override
  String smimeAskedAuthorityCrl(String date) {
    return 'Ερώτημα στην αρχή (λίστα ανάκλησης), $date';
  }

  @override
  String smimeAskedAuthorityOcsp(String date) {
    return 'Ερώτημα στην αρχή (OCSP), $date';
  }

  @override
  String smimeTrustIssuer(String name) {
    return 'Εμπιστοσύνη στο «$name»…';
  }

  @override
  String get smimeTrustThisCertificateEllipsis => 'Εμπιστοσύνη σε αυτό το πιστοποιητικό…';

  @override
  String get smimeCheckedFooterRevocation =>
      'Ελέγχθηκε σε αυτή τη συσκευή με S/MIME, συμβατό με Outlook και Thunderbird· η ανάκληση ελέγχθηκε στην αρχή πιστοποίησης.';

  @override
  String get smimeCheckedFooter =>
      'Ελέγχθηκε σε αυτή τη συσκευή με S/MIME, συμβατό με Outlook και Thunderbird. Η ανάκληση δεν ελέγχεται (Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο).';

  @override
  String smimeTrustAuthorityTitle(String name) {
    return 'Εμπιστοσύνη στο $name για email;';
  }

  @override
  String smimeTrustCertificateTitle(String name) {
    return 'Εμπιστοσύνη στο πιστοποιητικό της επαφής $name;';
  }

  @override
  String smimeTrustAuthorityMessage(String fingerprint) {
    return 'Κάθε πιστοποιητικό που εκδίδει αυτή η αρχή θα θεωρείται αξιόπιστο, όπως με την αρχή πιστοποίησης της εταιρείας σας. Συγκρίνετε πρώτα το αποτύπωμα με τον κάτοχό του:\n$fingerprint';
  }

  @override
  String smimeTrustMessage(String fingerprint) {
    return 'Συγκρίνετε πρώτα το αποτύπωμα με τον κάτοχό του:\n$fingerprint';
  }

  @override
  String get smimeTrust => 'Εμπιστοσύνη';

  @override
  String get smimeSummaryNoKey => 'Κρυπτογραφήθηκε για ένα πιστοποιητικό που δεν υπάρχει σε αυτή τη συσκευή.';

  @override
  String get smimeSummaryDamaged => 'Τα κρυπτογραφημένα δεδομένα είναι κατεστραμμένα ή άλλαξαν στη διαδρομή.';

  @override
  String get smimeSummaryUnsupported => 'Χρησιμοποιεί αλγόριθμο που το Loupe δεν υποστηρίζει.';

  @override
  String get smimeSummaryLocked => 'Το πιστοποιητικό S/MIME σας είναι κλειδωμένο.';

  @override
  String get smimeSummaryEncrypted => 'Μόνο εσείς και οι άλλοι παραλήπτες μπορείτε να το διαβάσετε.';

  @override
  String get smimeSummaryNotSigned => 'Δεν είναι υπογεγραμμένο, οπότε ο αποστολέας δεν είναι επιβεβαιωμένος.';

  @override
  String get smimeSummaryModified => 'Η υπογραφή δεν ταιριάζει: το μήνυμα άλλαξε αφού υπογράφηκε.';

  @override
  String get smimeSummaryUncheckable => 'Η υπογραφή δεν μπορεί να ελεγχθεί.';

  @override
  String get smimeSummaryNoCertificate =>
      'Το πιστοποιητικό του υπογράφοντος δεν περιλαμβάνεται στο μήνυμα, οπότε δεν μπορεί να ελεγχθεί.';

  @override
  String get smimeSummaryRevoked =>
      'Η αρχή πιστοποίησης ανακάλεσε το πιστοποιητικό του υπογράφοντος: η υπογραφή δεν είναι αξιόπιστη.';

  @override
  String smimeSummaryRevokedReason(String reason) {
    return 'Η αρχή πιστοποίησης ανακάλεσε το πιστοποιητικό του υπογράφοντος ($reason): η υπογραφή δεν είναι αξιόπιστη.';
  }

  @override
  String get smimeDateMismatch =>
      'Υπογράφηκε περισσότερο από μία ώρα πριν ή μετά την ημερομηνία του μηνύματος: μπορεί να είναι παλιό μήνυμα που στάλθηκε ξανά.';

  @override
  String smimeSummaryValid(String issuer) {
    return 'Η υπογραφή είναι έγκυρη και η αρχή $issuer εγγυάται ότι το πιστοποιητικό ανήκει στον αποστολέα.';
  }

  @override
  String get smimeProblemInvalidChain => 'Το πιστοποιητικό ή κάποιος από τους εκδότες του δεν είναι έγκυρος.';

  @override
  String get smimeProblemUntrusted => 'Το πιστοποιητικό προέρχεται από αρχή που το Loupe δεν εμπιστεύεται.';

  @override
  String get smimeProblemExpired => 'Το πιστοποιητικό είχε λήξει.';

  @override
  String get smimeProblemNotYetValid => 'Το πιστοποιητικό δεν ίσχυε ακόμη.';

  @override
  String get smimeProblemWrongUsage => 'Το πιστοποιητικό δεν προορίζεται για email.';

  @override
  String get smimeProblemWrongAddress => 'Το πιστοποιητικό ανήκει σε άλλη διεύθυνση από αυτή του αποστολέα.';

  @override
  String smimeTrustedBy(String issuer) {
    return 'Αξιόπιστο · $issuer';
  }

  @override
  String smimeNotTrustedBy(String issuer) {
    return 'Μη αξιόπιστο · $issuer';
  }

  @override
  String smimeExpiredOn(String date) {
    return 'Έληξε στις $date';
  }

  @override
  String smimeValidFrom(String date) {
    return 'Ισχύει από $date';
  }

  @override
  String get smimeTrustInvalid => 'Μη έγκυρο';

  @override
  String get smimeTrustNotForMail => 'Όχι για email';

  @override
  String get smimeTrustAnotherAddress => 'Άλλη διεύθυνση';

  @override
  String get smimeMyCertificates => 'Τα πιστοποιητικά μου S/MIME';

  @override
  String get smimeMyCertificatesFooter =>
      'Για S/MIME, όπως το χρησιμοποιούν το Outlook και πολλές εταιρείες. Εισαγάγετε το πιστοποιητικό σας με το ιδιωτικό του κλειδί (αρχείο .p12 ή .pfx), εξαγμένο από Outlook, Windows, macOS ή Thunderbird.';

  @override
  String get smimeMyCertificatesFooterDevice =>
      'Για S/MIME, όπως το χρησιμοποιούν το Outlook και πολλές εταιρείες. Εισαγάγετε το πιστοποιητικό σας με το ιδιωτικό του κλειδί (αρχείο .p12 ή .pfx), εξαγμένο από Outlook, Windows, macOS ή Thunderbird, ή χρησιμοποιήστε ένα που εγκαταστήσατε εσείς ή η εταιρεία σας σε αυτή τη συσκευή.';

  @override
  String get smimeCertificateExpired => 'έληξε';

  @override
  String smimeCertificateUntil(String date) {
    return 'έως $date';
  }

  @override
  String get smimeCertificateOnDevice => 'σε αυτή τη συσκευή';

  @override
  String get smimeImportCertificateEllipsis => 'Εισαγωγή πιστοποιητικού…';

  @override
  String get smimeUseDeviceCertificate => 'Χρήση πιστοποιητικού από αυτή τη συσκευή…';

  @override
  String get smimeCorrespondentsCertificates => 'Πιστοποιητικά επαφών';

  @override
  String get smimeCorrespondentsCertificatesFooter =>
      'Συλλέγονται από υπογεγραμμένα μηνύματα, όπως κάνουν το Outlook και το Thunderbird. Τα μηνύματα κρυπτογραφούνται μόνο για αξιόπιστα πιστοποιητικά: το Loupe εμπιστεύεται τις αρχές που εμπιστεύεται η Mozilla για email, καθώς και όσες προσθέτετε εσείς.';

  @override
  String get smimeRevocation => 'Ανάκληση';

  @override
  String get smimeRevocationFooter =>
      'Όταν ανοίγετε ένα υπογεγραμμένο μήνυμα, το Loupe ρωτά την αρχή που εξέδωσε το πιστοποιητικό του υπογράφοντος αν έχει ανακληθεί (μέσω του διακομιστή OCSP της ή της λίστας ανάκλησής της). Έτσι η αρχή μπορεί να δει πότε κάποιος από τη δική σας διεύθυνση internet διαβάζει μηνύματα υπογεγραμμένα με αυτό το πιστοποιητικό. Οι απαντήσεις φυλάσσονται σε αυτή τη συσκευή μέχρι να λήξουν. Ένα ανακληθέν πιστοποιητικό εμφανίζεται ως «το πιστοποιητικό ανακλήθηκε» στην κεφαλίδα του μηνύματος.';

  @override
  String get smimeCheckRevocation => 'Ηλεκτρονικός έλεγχος ανάκλησης πιστοποιητικών';

  @override
  String get smimeTrustedAuthorities => 'Αξιόπιστες αρχές';

  @override
  String smimeTrustedAuthoritiesFooter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αξιόπιστες για εσάς, πέρα από τις $count που εμπιστεύεται η Mozilla για email.',
      one: 'Αξιόπιστες για εσάς, πέρα από τη μία που εμπιστεύεται η Mozilla για email.',
    );
    return '$_temp0';
  }

  @override
  String get smimeCertificateAuthority => 'Αρχή πιστοποίησης';

  @override
  String get smimeImportACertificate => 'Εισαγωγή πιστοποιητικού';

  @override
  String get smimeImportContactMessage => 'Πιστοποιητικό επαφής (.cer, .crt, .pem) ή αρχής πιστοποίησης.';

  @override
  String get smimeFromClipboard => 'Από το πρόχειρο';

  @override
  String get smimeFromFile => 'Από αρχείο';

  @override
  String get smimeClipboardEmpty => 'Το πρόχειρο είναι κενό. Αντιγράψτε πρώτα το πιστοποιητικό.';

  @override
  String get smimeCertificate => 'Πιστοποιητικό';

  @override
  String get smimeOnDeviceFooter =>
      'Το ιδιωτικό του κλειδί μένει στον χώρο αποθήκευσης διαπιστευτηρίων του Android, όπου το εγκαταστήσατε εσείς ή η εταιρεία σας: το Loupe ζητά από το Android να υπογράφει και να αποκρυπτογραφεί με αυτό. Τα υπογεγραμμένα μηνύματα υπογράφονται κατά την αποστολή τους.';

  @override
  String get smimeAddresses => 'Διευθύνσεις';

  @override
  String get smimeUsage => 'Για';

  @override
  String get smimeUsageNone => 'Τίποτα που χρησιμοποιεί το Loupe';

  @override
  String get smimeUsageSigning => 'Υπογραφή';

  @override
  String get smimeUsageEncryption => 'Κρυπτογράφηση';

  @override
  String get smimeUsageCertificates => 'Πιστοποιητικά';

  @override
  String get smimeAlgorithm => 'Αλγόριθμος';

  @override
  String get smimeSerialNumber => 'Σειριακός αριθμός';

  @override
  String get smimeFingerprintCopied => 'Το αποτύπωμα αντιγράφηκε.';

  @override
  String get smimeSha1Thumbprint => 'Αποτύπωμα SHA-1';

  @override
  String get smimePrivateKey => 'Ιδιωτικό κλειδί';

  @override
  String get smimeKeyOnDevice => 'Σε αυτή τη συσκευή';

  @override
  String get smimeKeyInLoupeWithPassphrase => 'Στο Loupe, με φράση πρόσβασης';

  @override
  String get smimeKeyInLoupe => 'Στο Loupe';

  @override
  String get smimeSource => 'Προέλευση';

  @override
  String get smimeSourceSignedMail => 'Υπογεγραμμένο μήνυμα';

  @override
  String get smimeSourceImported => 'Εισαγωγή';

  @override
  String get smimeTrustHeader => 'Εμπιστοσύνη';

  @override
  String get smimeTrustedRoot => 'Αξιόπιστη ρίζα';

  @override
  String get smimeIssuer => 'Εκδότης';

  @override
  String smimeTrustNamed(String name) {
    return 'Εμπιστοσύνη στο «$name»';
  }

  @override
  String get smimeTrustThisAuthority => 'Εμπιστοσύνη σε αυτή την αρχή';

  @override
  String get smimeTrustThisCertificate => 'Εμπιστοσύνη σε αυτό το πιστοποιητικό';

  @override
  String get smimeStopTrusting => 'Διακοπή εμπιστοσύνης';

  @override
  String get smimePassphrase => 'Φράση πρόσβασης';

  @override
  String get smimePassphraseFooter =>
      'Προαιρετικό. Με φράση πρόσβασης, το ιδιωτικό κλειδί κρυπτογραφείται επιπλέον σε αυτή τη συσκευή (Argon2id και AES-256) και το Loupe τη ζητά για να υπογράψει και να αποκρυπτογραφήσει· η «Απομνημόνευση φράσεων πρόσβασης» ορίζει για πόσο. Τα μηνύματα που στέλνετε υπογράφονται κατά την αποστολή· οι εργασίες στο παρασκήνιο δεν μπορούν να χρησιμοποιήσουν το κλειδί.';

  @override
  String get smimeChangePassphrase => 'Αλλαγή φράσης πρόσβασης…';

  @override
  String get smimeSetPassphraseEllipsis => 'Ορισμός φράσης πρόσβασης…';

  @override
  String get smimeRemovePassphrase => 'Κατάργηση φράσης πρόσβασης';

  @override
  String get smimeShareCertificate => 'Κοινοποίηση πιστοποιητικού';

  @override
  String get smimeDeleteCertificate => 'Διαγραφή πιστοποιητικού';

  @override
  String get smimeRemoveCertificate => 'Αφαίρεση πιστοποιητικού';

  @override
  String get smimePassphraseChanged => 'Η φράση πρόσβασης άλλαξε.';

  @override
  String get smimePassphraseSet => 'Η φράση πρόσβασης ορίστηκε.';

  @override
  String get smimeRemovePassphraseTitle => 'Κατάργηση της φράσης πρόσβασης;';

  @override
  String get smimeRemovePassphraseMessage =>
      'Το ιδιωτικό κλειδί θα προστατεύεται τότε μόνο από την κλειδοθήκη, όπως χωρίς φράση πρόσβασης: το Loupe δεν θα τη ζητά πλέον και οι εργασίες στο παρασκήνιο θα μπορούν να το χρησιμοποιούν.';

  @override
  String get smimePassphraseRemoved => 'Η φράση πρόσβασης καταργήθηκε.';

  @override
  String smimeTrustTitle(String name) {
    return 'Εμπιστοσύνη στο $name;';
  }

  @override
  String smimeTrustCaMessage(String fingerprint) {
    return 'Κάθε πιστοποιητικό που εκδίδει θα θεωρείται αξιόπιστο για email. Συγκρίνετε πρώτα το αποτύπωμα με τον κάτοχό του:\n$fingerprint';
  }

  @override
  String smimeDeleteOwnTitle(String name) {
    return 'Διαγραφή του πιστοποιητικού σας $name;';
  }

  @override
  String smimeRemoveContactTitle(String name) {
    return 'Αφαίρεση του πιστοποιητικού της επαφής $name;';
  }

  @override
  String get smimeDeleteDeviceMessage =>
      'Το Loupe σταματά να το χρησιμοποιεί: τα μηνύματα που κρυπτογραφήθηκαν για αυτό δεν θα διαβάζονται πλέον στο Loupe. Το πιστοποιητικό μένει σε αυτή τη συσκευή (Ρυθμίσεις › Ασφάλεια › Κρυπτογράφηση και διαπιστευτήρια).';

  @override
  String get smimeDeleteOwnMessage =>
      'Το ιδιωτικό του κλειδί διαγράφεται από αυτή τη συσκευή: τα μηνύματα που κρυπτογραφήθηκαν για αυτό δεν θα διαβάζονται πλέον εδώ, εκτός αν το εισαγάγετε ξανά.';

  @override
  String get smimeRemoveContactMessage => 'Θα επιστρέψει με το επόμενο υπογεγραμμένο μήνυμα της επαφής.';

  @override
  String get smimeAddressImportFooter =>
      'Εισαγάγετε ένα πιστοποιητικό για αυτή τη διεύθυνση για να υπογράφετε και να κρυπτογραφείτε με S/MIME, όπως το Outlook.';

  @override
  String get smimeImportACertificateEllipsis => 'Εισαγωγή πιστοποιητικού…';

  @override
  String get smimePreferFooter =>
      'Όταν και τα δύο μπορούν να προστατέψουν ένα μήνυμα, χρησιμοποιείται το προτιμώμενο, εκτός αν μόνο το άλλο έχει κλειδί ή πιστοποιητικό για κάθε παραλήπτη.';

  @override
  String get smimePreferSmime => 'Προτίμηση S/MIME';

  @override
  String get smimePreferSmimeDetail => 'Αντί για OpenPGP';

  @override
  String get smimeCertificatePassword => 'Κωδικός πιστοποιητικού';

  @override
  String get smimeCertificatePasswordPrompt =>
      'Εισαγάγετε τον κωδικό με τον οποίο εξήχθη το αρχείο του πιστοποιητικού.';

  @override
  String get smimeImport => 'Εισαγωγή';

  @override
  String get smimeWrongPassword => 'Λανθασμένος κωδικός. Δοκιμάστε ξανά.';

  @override
  String get smimeNoCertificateFound => 'Δεν βρέθηκε πιστοποιητικό.';

  @override
  String smimeCertificateOf(String name) {
    return 'το πιστοποιητικό της επαφής $name';
  }

  @override
  String get smimeNothingNew => 'Τίποτα νέο για εισαγωγή.';

  @override
  String smimeImportedCertificates(String certificates) {
    return 'Εισήχθησαν: $certificates.';
  }

  @override
  String smimeImportedAuthorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Εισήχθησαν $count αξιόπιστες αρχές.',
      one: 'Εισήχθη μία αξιόπιστη αρχή.',
    );
    return '$_temp0';
  }

  @override
  String smimeImportedCertificatesAndAuthorities(int count, String certificates) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Εισήχθησαν: $certificates και $count αξιόπιστες αρχές.',
      one: 'Εισήχθησαν: $certificates και μία αξιόπιστη αρχή.',
    );
    return '$_temp0';
  }

  @override
  String get smimeNoPrivateKey =>
      'Αυτό το αρχείο δεν έχει ιδιωτικό κλειδί. Εξαγάγετε το πιστοποιητικό σας μαζί με το ιδιωτικό του κλειδί.';

  @override
  String get smimeImportAsYoursTitle => 'Εισαγωγή ως δικό σας πιστοποιητικό;';

  @override
  String smimeImportAsYoursMessage(String names) {
    return 'Αυτό το συνημμένο περιέχει ένα πιστοποιητικό με το ιδιωτικό του κλειδί: $names. Εισαγάγετέ το μόνο αν το εξαγάγατε εσείς, για παράδειγμα από το Outlook ή το Thunderbird.';
  }

  @override
  String get smimeImportAsMine => 'Εισαγωγή ως δικό μου πιστοποιητικό';

  @override
  String smimeImportedOwn(String names) {
    return 'Εισήχθη το πιστοποιητικό σας $names.';
  }

  @override
  String smimeAddedFromDevice(String name, String addresses) {
    return 'Προστέθηκε το πιστοποιητικό σας $name ($addresses) από αυτή τη συσκευή.';
  }

  @override
  String smimeTrustUnknownAuthorityTitle(String name) {
    return 'Εμπιστοσύνη στο «$name» για email;';
  }

  @override
  String smimeTrustUnknownAuthorityMessage(String fingerprint) {
    return 'Το Loupe δεν γνωρίζει αυτή την αρχή πιστοποίησης (ίσως είναι εταιρική). Εμπιστευτείτε την για να ελέγχονται τα πιστοποιητικά που εκδίδει. Συγκρίνετε πρώτα το αποτύπωμά της με το τμήμα πληροφορικής σας:\n$fingerprint';
  }

  @override
  String smimeCertificatesAttached(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Έχουν επισυναφθεί $count πιστοποιητικά.',
      one: 'Έχει επισυναφθεί ένα πιστοποιητικό.',
    );
    return '$_temp0';
  }

  @override
  String get smimeImportCertificate => 'Εισαγωγή πιστοποιητικού';

  @override
  String get smimeUnlockTitle => 'Ξεκλείδωμα πιστοποιητικού S/MIME';

  @override
  String smimeEnterPassphrase(String name, String addresses) {
    return 'Εισαγάγετε τη φράση πρόσβασης του πιστοποιητικού «$name» ($addresses).';
  }

  @override
  String get smimeWrongPassphrase => 'Λανθασμένη φράση πρόσβασης. Δοκιμάστε ξανά.';

  @override
  String get smimeUnlock => 'Ξεκλείδωμα';

  @override
  String get smimeEnterAPassphrase => 'Εισαγάγετε μια φράση πρόσβασης.';

  @override
  String get smimePassphrasesDiffer => 'Οι δύο φράσεις πρόσβασης διαφέρουν.';

  @override
  String get smimeSetPassphraseTitle => 'Ορισμός φράσης πρόσβασης';

  @override
  String get smimeSetPassphraseText =>
      'Το Loupe θα τη ζητά για να υπογράφει και να αποκρυπτογραφεί. Αν την ξεχάσετε, εισαγάγετε ξανά το πιστοποιητικό από το αρχείο .p12.';

  @override
  String get smimePassphraseAgain => 'Ξανά';

  @override
  String get smimeSetPassphraseButton => 'Ορισμός';

  @override
  String get smimeLockedOpenAgain =>
      'Το πιστοποιητικό S/MIME σας είναι κλειδωμένο. Ανοίξτε ξανά το μήνυμα για να το ξεκλειδώσετε.';

  @override
  String get smimeDeviceHasNoCertificates => 'Αυτή η συσκευή δεν παρέχει τα πιστοποιητικά της.';

  @override
  String get smimeCantReadCertificate => 'Το Loupe δεν μπορεί να διαβάσει αυτό το πιστοποιητικό.';

  @override
  String get smimeCertificateNotForMail =>
      'Αυτό το πιστοποιητικό δεν είναι για email: δεν έχει διεύθυνση email ή δεν προορίζεται για υπογραφή ή κρυπτογράφηση.';

  @override
  String get smimeDeviceCertificateGone =>
      'Το πιστοποιητικό δεν υπάρχει πλέον σε αυτή τη συσκευή ή το Loupe ίσως δεν έχει πια άδεια να το χρησιμοποιεί. Επιλέξτε το ξανά στις Ρυθμίσεις › Κρυπτογράφηση από άκρο σε άκρο.';

  @override
  String get smimeDeviceCertificateAppOnly =>
      'Το πιστοποιητικό αυτής της συσκευής μπορεί να χρησιμοποιηθεί μόνο όσο το Loupe είναι ανοιχτό.';

  @override
  String get smimeDeviceKeyDamaged => 'Το κρυπτογραφημένο κλειδί είναι κατεστραμμένο.';

  @override
  String smimeDeviceCertificateCantDo(String reason) {
    return 'Το πιστοποιητικό αυτής της συσκευής δεν μπορεί να το κάνει αυτό: $reason.';
  }

  @override
  String get smimeDeviceNotSupported => 'δεν υποστηρίζεται';

  @override
  String smimeDeviceCertificateFailed(String reason) {
    return 'Το πιστοποιητικό αυτής της συσκευής απέτυχε: $reason.';
  }

  @override
  String get smimeAuthorityNotWebAddress => 'Η διεύθυνση της αρχής δεν είναι διεύθυνση ιστού.';

  @override
  String get smimeAuthorityTimeout => 'Η αρχή πιστοποίησης δεν απάντησε εγκαίρως.';

  @override
  String get smimeAuthorityUnreachable => 'Δεν ήταν δυνατή η επικοινωνία με την αρχή πιστοποίησης.';

  @override
  String smimeAuthorityStatus(String status) {
    return 'Η αρχή πιστοποίησης απάντησε με $status.';
  }

  @override
  String get smimeAuthorityAnswerTooLarge => 'Η απάντηση της αρχής πιστοποίησης είναι πολύ μεγάλη.';

  @override
  String get smimeRevocationNotChecked =>
      'Δεν ελέγχθηκε: ελέγχονται μόνο πιστοποιητικά από αρχές που εμπιστεύεται το Loupe.';

  @override
  String get settingsLanguage => 'Γλώσσα';

  @override
  String get settingsLanguageSystem => 'Ίδια με το τηλέφωνο';

  @override
  String get settingsLanguageFooter =>
      'Το Loupe χρησιμοποιεί τη γλώσσα του τηλεφώνου σας όταν τη διαθέτει, αλλιώς τα αγγλικά. Η γλώσσα που επιλέγετε εδώ ισχύει μόνο για το Loupe, μαζί με τις ειδοποιήσεις.';

  @override
  String get settingsAccountsHeader => 'Λογαριασμοί';

  @override
  String get settingsAddAccount => 'Προσθήκη λογαριασμού';

  @override
  String get settingsMailHeader => 'Αλληλογραφία';

  @override
  String get settingsSwipeActions => 'Ενέργειες σάρωσης';

  @override
  String get settingsSwipeLeft => 'Σάρωση αριστερά';

  @override
  String get settingsSwipeLeftFooter =>
      'Μια πλήρης σάρωση εκτελεί αυτή την ενέργεια. Η «Προσθήκη σημαίας» και τα «Περισσότερα» απέχουν πάντα μία σύντομη σάρωση.';

  @override
  String get settingsSwipeRight => 'Σάρωση δεξιά';

  @override
  String get settingsSwipeRightFooter => 'Μια πλήρης σάρωση εκτελεί αυτή την ενέργεια.';

  @override
  String get settingsSwipeToggleRead => 'Σήμανση ως αναγνωσμένο / μη αναγνωσμένο';

  @override
  String get settingsSwipeTrash => 'Στον κάδο';

  @override
  String get settingsSwipeMove => 'Μετακίνηση μηνύματος';

  @override
  String get settingsSwipeSnooze => 'Αναβολή';

  @override
  String get settingsThreaded => 'Οργάνωση ανά συζήτηση';

  @override
  String get settingsUndoSendDelay => 'Καθυστέρηση αναίρεσης αποστολής';

  @override
  String get settingsUndoSendDelayFooter =>
      'Τα απεσταλμένα μηνύματα περιμένουν τόσο, ώστε να μπορείτε να τα πάρετε πίσω.';

  @override
  String settingsUndoSendSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds δευτερόλεπτα',
      one: '1 δευτερόλεπτο',
    );
    return '$_temp0';
  }

  @override
  String get settingsSmartMailboxes => 'Smart Mailboxes';

  @override
  String get settingsAppearanceHeader => 'Εμφάνιση';

  @override
  String get settingsTheme => 'Θέμα';

  @override
  String get settingsThemeSystem => 'Αυτόματο';

  @override
  String get settingsThemeLight => 'Ανοιχτόχρωμο';

  @override
  String get settingsThemeDark => 'Σκουρόχρωμο';

  @override
  String get settingsDensity => 'Λίστα μηνυμάτων';

  @override
  String get settingsDensityComfortable => 'Άνετη';

  @override
  String get settingsDensityCompact => 'Συμπαγής';

  @override
  String get settingsReadingHeader => 'Ανάγνωση';

  @override
  String get settingsReadingFooter =>
      'Οι απομακρυσμένες εικόνες μπορούν να ενημερώσουν τους αποστολείς πότε και πού ανοίξατε ένα μήνυμα.';

  @override
  String get settingsDefaultView => 'Προεπιλεγμένη προβολή';

  @override
  String get settingsDefaultViewFooter => 'Μπορείτε να αλλάξετε την προβολή κάθε μηνύματος με το κουμπί Aa.';

  @override
  String get settingsViewReadable => 'Ευανάγνωστη';

  @override
  String get settingsViewReadableDetail => 'Καθαρή, ευκρινής, ακολουθεί τη σκοτεινή λειτουργία';

  @override
  String get settingsViewOriginal => 'Πρωτότυπη';

  @override
  String get settingsViewOriginalDetail => 'Ακριβώς όπως τη σχεδίασε ο αποστολέας';

  @override
  String get settingsViewPlain => 'Απλό κείμενο';

  @override
  String get settingsViewPlainDetail => 'Μόνο οι λέξεις';

  @override
  String get settingsPlainTextFont => 'Γραμματοσειρά απλού κειμένου';

  @override
  String get settingsFontSans => 'Sans Serif';

  @override
  String get settingsFontMono => 'Σταθερού πλάτους';

  @override
  String get settingsFontMonoDetail => 'Διατηρεί στοιχισμένα τα σχέδια ASCII και τους πίνακες';

  @override
  String get settingsTechnicalLists => 'Τεχνικές λίστες';

  @override
  String get settingsLoadRemoteImages => 'Φόρτωση απομακρυσμένων εικόνων';

  @override
  String get settingsOpenLinksDirectly => 'Απευθείας άνοιγμα συνδέσμων';

  @override
  String get settingsOpenLinksDirectlyDetail => 'Παράκαμψη της παρακολούθησης κλικ όταν ο προορισμός είναι γνωστός';

  @override
  String get settingsSecurityHeader => 'Ασφάλεια';

  @override
  String get settingsAppLock => 'Κλείδωμα εφαρμογής';

  @override
  String get settingsAppLockFooterOn =>
      'Το Loupe ρωτά όταν ξεκινά και όταν επιστρέφετε μετά από απουσία μεγαλύτερη από τον χρόνο «Κλείδωμα μετά από».';

  @override
  String get settingsAppLockFooterOff =>
      'Το κλείδωμα εφαρμογής ζητά δακτυλικό αποτύπωμα, πρόσωπο ή κλείδωμα οθόνης πριν εμφανιστεί η αλληλογραφία σας.';

  @override
  String settingsAppLockStillOff(String reason) {
    return 'Το κλείδωμα εφαρμογής παραμένει απενεργοποιημένο. $reason';
  }

  @override
  String get settingsScreenLockTitleIos => 'Ορίστε κωδικό';

  @override
  String get settingsScreenLockTextIos =>
      'Το κλείδωμα εφαρμογής χρησιμοποιεί Face ID, Touch ID ή τον κωδικό σας, και αυτό το iPhone δεν έχει κωδικό. Ορίστε έναν στην εφαρμογή Ρυθμίσεις και μετά ενεργοποιήστε το κλείδωμα εφαρμογής.';

  @override
  String get settingsScreenLockTitleAndroid => 'Ορίστε κλείδωμα οθόνης';

  @override
  String get settingsScreenLockTextAndroid =>
      'Το κλείδωμα εφαρμογής χρησιμοποιεί το κλείδωμα οθόνης του τηλεφώνου σας ή ένα δακτυλικό αποτύπωμα ή πρόσωπο που έχει προστεθεί σε αυτό, και αυτό το τηλέφωνο δεν έχει κανένα. Ορίστε PIN, μοτίβο ή κωδικό πρόσβασης στις ρυθμίσεις του Android και μετά ενεργοποιήστε το κλείδωμα εφαρμογής.';

  @override
  String get settingsOpenSystemSettings => 'Άνοιγμα Ρυθμίσεων';

  @override
  String get settingsOpenAndroidSettings => 'Άνοιγμα ρυθμίσεων Android';

  @override
  String get settingsLockAfter => 'Κλείδωμα μετά από';

  @override
  String get settingsLockAfterFooter => 'Πόση ώρα μπορεί το Loupe να είναι στο παρασκήνιο πριν ρωτήσει ξανά.';

  @override
  String get settingsNotifications => 'Ειδοποιήσεις';

  @override
  String get settingsEncryption => 'Κρυπτογράφηση από άκρο σε άκρο';

  @override
  String get settingsAdvanced => 'Για προχωρημένους';

  @override
  String get settingsDemoHeader => 'Επίδειξη';

  @override
  String get settingsDemoFooter =>
      'Η αλληλογραφία επίδειξης είναι ένα φανταστικό γραμματοκιβώτιο που υπάρχει μόνο σε αυτό το τηλέφωνο. Δεν στέλνεται τίποτα πουθενά.';

  @override
  String get settingsDemoMode => 'Λειτουργία επίδειξης';

  @override
  String get settingsResetApp => 'Επαναφορά εφαρμογής';

  @override
  String get settingsResetFooter => 'Ξεχνά όλες τις ρυθμίσεις και επιστρέφει στην οθόνη καλωσορίσματος.';

  @override
  String get settingsResetTitle => 'Επαναφορά του Loupe;';

  @override
  String get settingsResetMessage =>
      'Αυτό ξεχνά κάθε ρύθμιση, Smart Mailbox και πρόσφατη αναζήτηση, και επιστρέφει στην οθόνη καλωσορίσματος.';

  @override
  String get settingsAboutHeader => 'Σχετικά';

  @override
  String get settingsVersion => 'Έκδοση';

  @override
  String get settingsLicences => 'Άδειες';

  @override
  String get settingsPrivacy => 'Απόρρητο';

  @override
  String get settingsPrivacyDetail =>
      'Το Loupe δεν έχει στατιστικά χρήσης ούτε παρακολούθηση. Η αλληλογραφία σας πηγαίνει μόνο στους διακομιστές αλληλογραφίας σας.';

  @override
  String get settingsNotificationsOffIos => 'Οι ειδοποιήσεις για το Loupe είναι απενεργοποιημένες στις Ρυθμίσεις.';

  @override
  String get settingsNotificationsOffAndroid =>
      'Οι ειδοποιήσεις για το Loupe είναι απενεργοποιημένες στις ρυθμίσεις του Android.';

  @override
  String settingsNotificationsBlockedFooter(String system) {
    return 'Το $system δεν επιτρέπει στο Loupe να εμφανίζει ειδοποιήσεις. Επιτρέψτε τις στις Ρυθμίσεις.';
  }

  @override
  String get settingsNewMailHeader => 'Νέα μηνύματα';

  @override
  String get settingsNewMailFooterDemo =>
      'Η αλληλογραφία επίδειξης δεν φτάνει στο παρασκήνιο. Στείλτε μια δοκιμαστική ειδοποίηση για να δείτε πώς φαίνονται τα νέα μηνύματα.';

  @override
  String get settingsNewMailFooterIos =>
      'Το Loupe ελέγχει για νέα μηνύματα στο παρασκήνιο όταν το επιτρέπει το iOS, κάτι που για εφαρμογές που δεν ανοίγετε συχνά μπορεί να γίνεται με διαφορά ωρών. Ειδοποιείστε για νέα μηνύματα στα εισερχόμενά σας και από επαφές VIP σε οποιονδήποτε φάκελο.';

  @override
  String get settingsNewMailFooterAndroid =>
      'Το Loupe ελέγχει για νέα μηνύματα περίπου κάθε 15 λεπτά, όταν το επιτρέπει το Android. Ειδοποιείστε για νέα μηνύματα στα εισερχόμενά σας και από επαφές VIP σε οποιονδήποτε φάκελο.';

  @override
  String get settingsNoAccounts => 'Κανένας λογαριασμός';

  @override
  String get settingsVipOnly => 'Μόνο VIP';

  @override
  String get settingsVipOnlyDetail => 'Μόνο μηνύματα από τις επαφές VIP σας';

  @override
  String get settingsHideContent => 'Απόκρυψη περιεχομένου';

  @override
  String get settingsHideContentFooterOn =>
      'Οι ειδοποιήσεις λένε μόνο «Νέο μήνυμα από» και τον λογαριασμό, όχι ποιος έγραψε ή για ποιο θέμα.';

  @override
  String get settingsHideContentFooterOff =>
      'Η «Απόκρυψη περιεχομένου» κρατά τον αποστολέα, το θέμα και την προεπισκόπηση έξω από την οθόνη κλειδώματος και τις ειδοποιήσεις.';

  @override
  String get settingsBackgroundAppRefresh => 'Ανανέωση εφαρμογών στο παρασκήνιο';

  @override
  String get settingsBackgroundRefreshFooter =>
      'Τα νέα μηνύματα φτάνουν στο παρασκήνιο μόνο όσο η «Ανανέωση εφαρμογών στο παρασκήνιο» είναι ενεργή για το Loupe στις Ρυθμίσεις. Το iOS δεν μπορεί να κρατά ανοιχτή σύνδεση με τα εισερχόμενά σας, οπότε δεν υπάρχει «Άμεση παράδοση».';

  @override
  String get settingsInstantDelivery => 'Άμεση παράδοση';

  @override
  String get settingsInstantDeliveryFooter =>
      'Η «Άμεση παράδοση» (πειραματική) κρατά ανοιχτή μια σύνδεση με τα εισερχόμενά σας, ώστε τα νέα μηνύματα να φτάνουν μέσα σε δευτερόλεπτα. Εμφανίζει μια αθόρυβη ειδοποίηση «Αναμονή για νέα μηνύματα» και καταναλώνει περισσότερη μπαταρία.';

  @override
  String get settingsBatteryRestrictedFooter =>
      'Το Android μπορεί να σταματήσει την «Άμεση παράδοση» για εξοικονόμηση μπαταρίας. Επιτρέψτε στο Loupe να χρησιμοποιεί την μπαταρία χωρίς περιορισμούς για να συνεχίσει να λειτουργεί.';

  @override
  String get settingsExperimental => 'Πειραματικό';

  @override
  String get settingsComingSoon => 'Έρχεται σύντομα';

  @override
  String get settingsAllowUnrestrictedBattery => 'Να επιτρέπεται απεριόριστη χρήση μπαταρίας';

  @override
  String get settingsPush => 'Push';

  @override
  String get settingsPushFooter =>
      'Το push επιτρέπει στα νέα μηνύματα να ξυπνούν αμέσως το Loupe, όπου το υποστηρίζει η υπηρεσία αλληλογραφίας σας. Τα push περνούν από την υπηρεσία push της Google και δεν μεταφέρουν μηνύματα, μόνο ένα «έλεγξε τώρα».';

  @override
  String get settingsPushUnavailableFooter =>
      'Αυτό το τηλέφωνο δεν μπορεί να λαμβάνει push: χρειάζονται οι υπηρεσίες Google Play και σύνδεση δικτύου. Το Loupe εξακολουθεί να ελέγχει για μηνύματα περίπου κάθε 15 λεπτά.';

  @override
  String get settingsCopyPushToken => 'Αντιγραφή διακριτικού push';

  @override
  String get settingsPushTokenCopied => 'Το διακριτικό push αντιγράφηκε';

  @override
  String get settingsSendTestNotification => 'Αποστολή δοκιμαστικής ειδοποίησης';

  @override
  String get settingsAppIconBadge => 'Σήμα εικονιδίου εφαρμογής';

  @override
  String get settingsBadgeNote =>
      'Το σήμα ενημερώνεται κάθε φορά που το Loupe ελέγχει για μηνύματα, και στο παρασκήνιο.';

  @override
  String get settingsBadgeUnsupportedFooter =>
      'Η αρχική οθόνη αυτού του τηλεφώνου δεν εμφανίζει αριθμούς στα εικονίδια εφαρμογών. Το σήμα ενημερώνεται κάθε φορά που το Loupe ελέγχει για μηνύματα, και στο παρασκήνιο.';

  @override
  String get settingsTestNotificationBody => 'Έτσι φαίνονται οι ειδοποιήσεις για νέα μηνύματα.';

  @override
  String get settingsAccountRemoved => 'Αυτός ο λογαριασμός αφαιρέθηκε.';

  @override
  String get settingsAccountHeader => 'Λογαριασμός';

  @override
  String get settingsAccountDescription => 'Περιγραφή';

  @override
  String get settingsAccountDescriptionHint => 'Εργασία, Προσωπικό…';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsColour => 'Χρώμα';

  @override
  String get settingsColourFooter => 'Σημαδεύει τα μηνύματα αυτού του λογαριασμού στα «Όλα τα εισερχόμενα».';

  @override
  String settingsColourNumber(int number) {
    return 'Χρώμα $number';
  }

  @override
  String get settingsSendingHeader => 'Αποστολή';

  @override
  String get settingsSendingFooter =>
      'Κάθε ταυτότητα έχει τη δική της υπογραφή. Οι απαντήσεις στέλνονται από τη διεύθυνση στην οποία στάλθηκε το μήνυμα.';

  @override
  String get settingsFoldersHeader => 'Φάκελοι';

  @override
  String get settingsFoldersFooter =>
      'Το Loupe εμφανίζει και συγχρονίζει τους φακέλους στους οποίους είστε εγγεγραμμένοι, όπως το Thunderbird. Τα Εισερχόμενα, τα Πρόχειρα, τα Απεσταλμένα, τα Ανεπιθύμητα, ο Κάδος απορριμμάτων και η Αρχειοθήκη εμφανίζονται πάντα.';

  @override
  String get settingsShowAllFolders => 'Εμφάνιση όλων των φακέλων';

  @override
  String get settingsIncoming => 'Διακομιστής εισερχομένων';

  @override
  String get settingsOutgoing => 'Διακομιστής εξερχομένων';

  @override
  String get settingsConnectionNotEncrypted => 'Χωρίς κρυπτογράφηση';

  @override
  String get settingsSignIn => 'Σύνδεση';

  @override
  String get settingsSignInExpired => 'Έληξε';

  @override
  String settingsSignInExpiredFooter(String provider) {
    return 'Ο πάροχος $provider δεν δέχεται πλέον τη σύνδεση του Loupe για αυτόν τον λογαριασμό, οπότε η αλληλογραφία του δεν συγχρονίζεται. Συνδεθείτε ξανά για να το διορθώσετε.';
  }

  @override
  String get settingsSignInAgain => 'Επανασύνδεση';

  @override
  String get settingsSigningIn => 'Σύνδεση…';

  @override
  String get settingsRemoveAccount => 'Αφαίρεση λογαριασμού';

  @override
  String settingsRemoveAccountTitle(String account) {
    return 'Αφαίρεση του «$account»;';
  }

  @override
  String get settingsRemoveAccountMessage =>
      'Τα μηνύματα και οι ρυθμίσεις του αφαιρούνται από αυτό το τηλέφωνο. Τίποτα δεν διαγράφεται στον διακομιστή.';

  @override
  String get settingsManageFolders => 'Διαχείριση φακέλων';

  @override
  String get settingsNoFolders => 'Δεν υπάρχουν ακόμη φάκελοι.';

  @override
  String get settingsManageFoldersFooter =>
      'Οι φάκελοι στους οποίους είστε εγγεγραμμένοι εμφανίζονται στην οθόνη Γραμματοκιβώτια και συγχρονίζονται στο παρασκήνιο. Άλλες εφαρμογές αλληλογραφίας στον ίδιο λογαριασμό συνήθως ακολουθούν κι αυτές τις εγγραφές.';

  @override
  String get settingsSmartMailboxesFolder =>
      'Κρατά τα Smart Mailboxes σας για τις άλλες συσκευές σας. Κρυφός στην οθόνη Γραμματοκιβώτια.';

  @override
  String get settingsFolderAlwaysShown => 'Εμφανίζεται πάντα';

  @override
  String settingsSubscribeToFolder(String folder) {
    return 'Εγγραφή στο $folder';
  }

  @override
  String get settingsIdentities => 'Ταυτότητες';

  @override
  String get settingsIdentitiesFooterReorder =>
      'Η πρώτη ταυτότητα είναι η προεπιλογή για νέα μηνύματα. Σύρετε για να αλλάξετε τη σειρά.';

  @override
  String get settingsIdentitiesFooterSingle => 'Η προεπιλεγμένη ταυτότητα για νέα μηνύματα.';

  @override
  String get settingsIdentitiesReplyFooter => 'Η απάντηση στέλνεται από την ταυτότητα στην οποία στάλθηκε το μήνυμα.';

  @override
  String get settingsIdentityDefault => 'Προεπιλογή';

  @override
  String settingsIdentityReorder(String email) {
    return 'Αλλαγή σειράς $email';
  }

  @override
  String get settingsAddIdentity => 'Προσθήκη ταυτότητας';

  @override
  String get settingsNewIdentity => 'Νέα ταυτότητα';

  @override
  String get settingsIdentity => 'Ταυτότητα';

  @override
  String get settingsIdentityNameHint => 'Το όνομά σας';

  @override
  String get settingsReplyTo => 'Απάντηση προς';

  @override
  String get settingsSignature => 'Υπογραφή';

  @override
  String get settingsSignatureFooter => 'Προστίθεται κάτω από το «-- » στα μηνύματα από αυτή την ταυτότητα.';

  @override
  String get settingsNoSignature => 'Χωρίς υπογραφή';

  @override
  String get settingsCopyToMyself => 'Αντίγραφο σε εμένα';

  @override
  String get settingsCopyToMyselfFooter => 'Προστίθεται σε κάθε μήνυμα από αυτή την ταυτότητα.';

  @override
  String get settingsCc => 'Κοιν.';

  @override
  String get settingsBcc => 'Ιδιαίτ. κοιν.';

  @override
  String get settingsReplyPatterns => 'Χρήση για απαντήσεις προς';

  @override
  String get settingsReplyPatternsFooter =>
      'Οι απαντήσεις σε μηνύματα που στάλθηκαν σε αυτές τις διευθύνσεις στέλνονται από αυτή την ταυτότητα. Το * σημαίνει οτιδήποτε: *@example.com, me+*@example.com.';

  @override
  String get settingsReplyPatternPrompt => 'Μια διεύθυνση ή ένα μοτίβο όπου το * σημαίνει οτιδήποτε.';

  @override
  String get settingsAddReplyPattern => 'Προσθήκη διεύθυνσης ή μοτίβου';

  @override
  String settingsRemoveReplyPattern(String pattern) {
    return 'Αφαίρεση $pattern';
  }

  @override
  String get settingsInvalidPatternTitle => 'Μη έγκυρο μοτίβο';

  @override
  String settingsInvalidPatternMessage(String input) {
    return 'Το «$input» δεν είναι διεύθυνση ούτε μοτίβο όπως *@example.com.';
  }

  @override
  String get settingsIdentityNoAddressTitle => 'Χωρίς διεύθυνση';

  @override
  String get settingsIdentityNoAddressMessage => 'Εισαγάγετε τη διεύθυνση email από την οποία θα γίνεται η αποστολή.';

  @override
  String get settingsIdentityInvalidAddressTitle => 'Μη έγκυρη διεύθυνση';

  @override
  String settingsIdentityInvalidAddress(String field, String address) {
    String _temp0 = intl.Intl.selectLogic(field, {
      'replyTo': 'Το «$address» στο πεδίο «Απάντηση προς» δεν είναι έγκυρη διεύθυνση email.',
      'cc': 'Το «$address» στο πεδίο «Κοιν.» δεν είναι έγκυρη διεύθυνση email.',
      'bcc': 'Το «$address» στο πεδίο «Ιδιαίτ. κοιν.» δεν είναι έγκυρη διεύθυνση email.',
      'other': 'Το «$address» δεν είναι έγκυρη διεύθυνση email.',
    });
    return '$_temp0';
  }

  @override
  String get settingsSaveIdentity => 'Αποθήκευση ταυτότητας';

  @override
  String get settingsDiscardChanges => 'Απόρριψη αλλαγών';

  @override
  String get settingsDeleteIdentity => 'Διαγραφή ταυτότητας';

  @override
  String settingsDeleteIdentityTitle(String email) {
    return 'Διαγραφή του «$email»;';
  }

  @override
  String get settingsDeleteIdentityMessage => 'Τα μηνύματα που έχουν ήδη σταλεί από αυτή παραμένουν ως έχουν.';

  @override
  String get settingsLastIdentityFooter => 'Ένας λογαριασμός χρειάζεται τουλάχιστον μία ταυτότητα.';

  @override
  String get rulesTitle => 'Κανόνες';

  @override
  String get rulesNewRule => 'Νέος κανόνας';

  @override
  String get rulesLoadError => 'Δεν ήταν δυνατή η φόρτωση των κανόνων.';

  @override
  String get rulesEmptyTitle => 'Κανένας κανόνας';

  @override
  String get rulesEmptyText =>
      'Οι κανόνες ταξινομούν τα νέα μηνύματα και τους βάζουν ετικέτες και σημαίες για εσάς. Δημιουργήστε έναν με το κουμπί σύνταξης παραπάνω ή από μια αναζήτηση με τη «Μετατροπή σε κανόνα».';

  @override
  String get rulesListFooter =>
      'Οι κανόνες εκτελούνται από πάνω προς τα κάτω στα νέα μηνύματα των Εισερχομένων. Αγγίξτε παρατεταμένα έναν κανόνα για να τον μετακινήσετε.';

  @override
  String get rulesChangeError => 'Δεν ήταν δυνατή η αλλαγή του κανόνα';

  @override
  String get rulesConditionEveryMessage => 'Κάθε μήνυμα';

  @override
  String rulesMoveRule(String rule) {
    return 'Μετακίνηση $rule';
  }

  @override
  String rulesRuleOn(String rule) {
    return '$rule ενεργός';
  }

  @override
  String get rulesServerRulesHeader => 'Κανόνες διακομιστή';

  @override
  String get rulesServerRulesFooter =>
      'Οι κανόνες διακομιστή εκτελούνται στον διακομιστή αλληλογραφίας καθώς φτάνουν τα μηνύματα, ακόμη και όταν αυτό το τηλέφωνο είναι κλειστό. Φυλάσσονται σε ένα σενάριο Sieve με όνομα «loupe».';

  @override
  String get rulesStatusUnknown => 'Άγνωστο';

  @override
  String get rulesStatusError => 'Δεν ήταν δυνατή η επικοινωνία με τον διακομιστή.';

  @override
  String get rulesStatusChecking => 'Έλεγχος…';

  @override
  String rulesStatusViaInclude(String script) {
    return 'Εκτελούνται από το «$script».';
  }

  @override
  String rulesStatusOtherScript(String script) {
    return 'Το ενεργό σενάριο είναι το «$script». Πατήστε για να εκτελεί και τους κανόνες του Loupe.';
  }

  @override
  String get rulesStatusNoScript =>
      'Δεν υπάρχει ενεργό σενάριο στον διακομιστή. Η αποθήκευση ενός κανόνα διακομιστή ενεργοποιεί το σενάριο του Loupe.';

  @override
  String get rulesStatusUnavailable => 'Μη διαθέσιμο';

  @override
  String get rulesStatusNoSieve => 'Ο διακομιστής αυτού του λογαριασμού δεν προσφέρει Sieve (ManageSieve ή JMAP).';

  @override
  String rulesActionMove(String folder) {
    return 'Μετακίνηση στο $folder';
  }

  @override
  String get rulesActionMoveUnknown => 'Μετακίνηση σε φάκελο';

  @override
  String rulesActionTag(String tag) {
    return 'Ετικέτα $tag';
  }

  @override
  String rulesActionRemoveTag(String tag) {
    return 'Αφαίρεση ετικέτας $tag';
  }

  @override
  String get rulesActionKeepInInbox => 'Διατήρηση στα Εισερχόμενα';

  @override
  String rulesActionForward(String address) {
    return 'Προώθηση στο $address';
  }

  @override
  String rulesActionForwardNoCopy(String address) {
    return 'Προώθηση στο $address, χωρίς αντίγραφο';
  }

  @override
  String get rulesActionStop => 'Διακοπή';

  @override
  String get rulesNoActions => 'Δεν κάνει τίποτα ακόμη';

  @override
  String get rulesLocationDevice => 'Συσκευή';

  @override
  String get rulesLocationServer => 'Διακομιστής';

  @override
  String get rulesLocationThisDevice => 'Αυτή η συσκευή';

  @override
  String get rulesNewRuleTitle => 'Νέος κανόνας';

  @override
  String get rulesEditRuleTitle => 'Επεξεργασία κανόνα';

  @override
  String get rulesDefaultNameEveryMessage => 'Κάθε μήνυμα';

  @override
  String get rulesConditionHeader => 'Όταν ένα νέο μήνυμα ταιριάζει με';

  @override
  String get rulesConditionFooter =>
      'Γράψτε το όπως θα κάνατε αναζήτηση: from:, to:, s: (θέμα), b: (κείμενο), tag:, has:attachment, larger:2M…';

  @override
  String get rulesConditionHint => 'from:alice@example.com s:τιμολόγιο';

  @override
  String get rulesAccounts => 'Λογαριασμοί';

  @override
  String get rulesAllAccounts => 'Όλοι οι λογαριασμοί';

  @override
  String get rulesRemovedAccount => 'Λογαριασμός που αφαιρέθηκε';

  @override
  String get rulesAccountsFooter =>
      'Ένας κανόνας για όλους τους λογαριασμούς καλύπτει και λογαριασμούς που θα προσθέσετε αργότερα.';

  @override
  String get rulesActionsHeader => 'Τότε';

  @override
  String get rulesForwardingFooter =>
      'Η προώθηση στέλνει κάθε μήνυμα που ταιριάζει σε άλλη διεύθυνση μόλις φτάσει, ακόμη και όταν αυτό το τηλέφωνο είναι κλειστό. Ορισμένοι πάροχοι περιορίζουν πόσα μηνύματα μπορούν να προωθηθούν.';

  @override
  String get rulesForwardingHiddenFooter =>
      'Η προώθηση λειτουργεί μόνο σε κανόνες διακομιστή, γι’ αυτό παραλείπεται εδώ.';

  @override
  String rulesRemoveAction(String action) {
    return 'Αφαίρεση: $action';
  }

  @override
  String get rulesAddAction => 'Προσθήκη ενέργειας';

  @override
  String get rulesAddMove => 'Μετακίνηση σε φάκελο…';

  @override
  String get rulesAddTagMenu => 'Προσθήκη ετικέτας…';

  @override
  String get rulesRemoveTagMenu => 'Αφαίρεση ετικέτας…';

  @override
  String get rulesAddForward => 'Προώθηση σε…';

  @override
  String get rulesStopProcessing => 'Διακοπή επεξεργασίας άλλων κανόνων';

  @override
  String get rulesRunOnHeader => 'Εκτέλεση σε';

  @override
  String get rulesRunOnDeviceFooter =>
      'Αυτή η συσκευή εκτελεί τον κανόνα στα νέα μηνύματα των Εισερχομένων κάθε φορά που το Loupe ελέγχει για μηνύματα.';

  @override
  String get rulesRunOnServerFooter =>
      'Ο διακομιστής αλληλογραφίας εκτελεί τον κανόνα καθώς φτάνουν τα μηνύματα, ακόμη και όταν αυτό το τηλέφωνο είναι κλειστό. Απαιτεί Sieve, μέσω ManageSieve (Dovecot, mailcow) ή JMAP (Stalwart).';

  @override
  String get rulesApplyToExisting => 'Εφαρμογή σε υπάρχοντα μηνύματα…';

  @override
  String get rulesDeleteRule => 'Διαγραφή κανόνα';

  @override
  String rulesDeleteTitle(String rule) {
    return 'Διαγραφή του «$rule»;';
  }

  @override
  String get rulesMoveAccountTitle => 'Φάκελος σε ποιον λογαριασμό;';

  @override
  String get rulesMoveAccountMessage =>
      'Τα μηνύματα των άλλων λογαριασμών πηγαίνουν στον φάκελο με το ίδιο όνομα εκεί.';

  @override
  String get rulesAddTag => 'Προσθήκη ετικέτας';

  @override
  String get rulesRemoveTag => 'Αφαίρεση ετικέτας';

  @override
  String get rulesForwardTo => 'Προώθηση σε';

  @override
  String get rulesForwardToMessage =>
      'Ο διακομιστής προωθεί κάθε μήνυμα που ταιριάζει σε αυτή τη διεύθυνση, ακόμη και όταν αυτό το τηλέφωνο είναι κλειστό. Χρησιμοποιήστε μια διεύθυνση που σας ανήκει ή που εμπιστεύεστε.';

  @override
  String get rulesNotAnAddressTitle => 'Δεν είναι διεύθυνση email';

  @override
  String rulesNotAnAddressMessage(String address) {
    return 'Το «$address» δεν είναι διεύθυνση για προώθηση.';
  }

  @override
  String get rulesKeepCopyTitle => 'Διατήρηση αντιγράφου εδώ;';

  @override
  String get rulesKeepCopy => 'Διατήρηση αντιγράφου';

  @override
  String get rulesDontKeepCopy => 'Χωρίς αντίγραφο';

  @override
  String get rulesCheckCondition => 'Ελέγξτε τη συνθήκη';

  @override
  String get rulesChooseActionTitle => 'Επιλέξτε ενέργεια';

  @override
  String get rulesChooseActionMessage => 'Προσθέστε τι κάνει ο κανόνας με τα μηνύματα που ταιριάζουν.';

  @override
  String get rulesSaveError => 'Δεν ήταν δυνατή η αποθήκευση του κανόνα';

  @override
  String get rulesSaveServerError => 'Δεν ήταν δυνατή η αποθήκευση του κανόνα διακομιστή';

  @override
  String get rulesRunOnDeviceInstead => 'Εκτέλεση σε αυτή τη συσκευή';

  @override
  String get rulesNothingToApplyTitle => 'Τίποτα για εφαρμογή';

  @override
  String get rulesNothingToApplyMessage => 'Δώστε πρώτα στον κανόνα μια συνθήκη που λειτουργεί και μια ενέργεια.';

  @override
  String rulesApplyScopeTitle(String rule) {
    return 'Εφαρμογή του «$rule» σε μηνύματα σε…';
  }

  @override
  String get rulesApplyScopeInboxes => 'Εισερχόμενα';

  @override
  String get rulesApplyScopeAll => 'Όλα τα γραμματοκιβώτια';

  @override
  String get rulesFindingMessages => 'Εύρεση μηνυμάτων…';

  @override
  String get rulesSearchError => 'Η αναζήτηση απέτυχε';

  @override
  String get rulesSearchErrorUnknown => 'Κάτι πήγε στραβά.';

  @override
  String get rulesNoMatchesTitle => 'Κανένα μήνυμα δεν ταιριάζει';

  @override
  String rulesNoMatchesMessage(String condition) {
    return 'Τίποτα εκεί δεν ταιριάζει με το «$condition».';
  }

  @override
  String rulesApplyConfirmTitle(int count, String rule) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Εφαρμογή του «$rule» σε $countString μηνύματα;',
      one: 'Εφαρμογή του «$rule» σε $countString μήνυμα;',
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
      other: 'Εφαρμογή σε $countString μηνύματα',
      one: 'Εφαρμογή σε $countString μήνυμα',
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
      other: 'Το «$rule» εφαρμόστηκε σε $countString μηνύματα',
      one: 'Το «$rule» εφαρμόστηκε σε $countString μήνυμα',
    );
    return '$_temp0';
  }

  @override
  String get rulesServerChecking => 'Ερώτηση στον διακομιστή για τις δυνατότητές του…';

  @override
  String get rulesServerUnreachable => 'Δεν ήταν δυνατή η σύνδεση με τον διακομιστή.';

  @override
  String rulesServerProblem(String problem) {
    return 'Δεν μπορεί να εκτελεστεί στον διακομιστή: $problem';
  }

  @override
  String rulesServerProblemOf(String account, String problem) {
    return 'Δεν μπορεί να εκτελεστεί στον διακομιστή του λογαριασμού $account: $problem';
  }

  @override
  String get rulesShowScript => 'Εμφάνιση σεναρίου';

  @override
  String get rulesHideScript => 'Απόκρυψη σεναρίου';

  @override
  String get rulesMatchingHeader => 'Μηνύματα που ταιριάζουν';

  @override
  String get rulesMatchingHeaderLoading => 'Μηνύματα που ταιριάζουν…';

  @override
  String rulesMatchingCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString μηνύματα ταιριάζουν',
      one: '$countString μήνυμα ταιριάζει',
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
      other: '$countString+ μηνύματα ταιριάζουν',
      one: '$countString+ μήνυμα ταιριάζει',
    );
    return '$_temp0';
  }

  @override
  String get rulesPreviewFooter =>
      'Από τις τελευταίες 30 ημέρες. Ο ίδιος ο κανόνας ενεργεί μόνο σε νέα μηνύματα, εκτός αν τον εφαρμόσετε σε υπάρχοντα.';

  @override
  String rulesConditionError(String error) {
    return 'Η συνθήκη έχει σφάλμα: $error';
  }

  @override
  String get rulesPreviewNoSender => '(χωρίς αποστολέα)';

  @override
  String get rulesPreviewNoSubject => '(χωρίς θέμα)';

  @override
  String rulesPreviewMore(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'και $countString ακόμη');
    return '$_temp0';
  }

  @override
  String get rulesPreviewEmpty => 'Τίποτα από τις τελευταίες 30 ημέρες.';

  @override
  String get rulesIncludeTitle => 'Ενεργοποίηση κανόνων διακομιστή';

  @override
  String get rulesIncludeLeaveOff => 'Να μείνουν ανενεργοί';

  @override
  String rulesIncludeAlreadyOn(String account) {
    return 'Ο διακομιστής εκτελεί ήδη τους κανόνες του Loupe για τον λογαριασμό $account.';
  }

  @override
  String rulesIncludeExplanation(String script, String account) {
    return 'Το «$script» είναι το ενεργό σενάριο στον διακομιστή του λογαριασμού $account, οπότε ο διακομιστής εκτελεί αυτό και όχι τους κανόνες του Loupe. Το Loupe δεν θα το αντικαταστήσει. Μπορεί να του προσθέσει αυτές τις γραμμές, και τότε ο διακομιστής θα εκτελεί τους κανόνες του Loupe μετά από αυτούς του σεναρίου:';
  }

  @override
  String get rulesShowWholeScript => 'Εμφάνιση ολόκληρου του σεναρίου';

  @override
  String get rulesHideWholeScript => 'Απόκρυψη ολόκληρου του σεναρίου';

  @override
  String rulesIncludeFootnote(String script) {
    return 'Τίποτε άλλο στο «$script» δεν αλλάζει. Αν τα φίλτρα του επεξεργαστούν αργότερα στο webmail, το webmail μπορεί να το ξαναγράψει χωρίς αυτές τις γραμμές· τότε το Loupe θα δείχνει ξανά τους κανόνες διακομιστή ως ανενεργούς.';
  }

  @override
  String rulesIncludeAdd(String script) {
    return 'Προσθήκη στο «$script»';
  }

  @override
  String get subscriptionsTitle => 'Συνδρομές';

  @override
  String get subscriptionsNewsletters => 'Newsletter';

  @override
  String get subscriptionsDiscussions => 'Συζητήσεις';

  @override
  String get subscriptionsFilter => 'Φίλτρο';

  @override
  String get subscriptionsFilterNeverRead => 'Δεν διαβάζονται ποτέ';

  @override
  String get subscriptionsFilterRarelyRead => 'Διαβάζονται σπάνια';

  @override
  String get subscriptionsFilterAll => 'Όλα';

  @override
  String subscriptionsFilterChip(String filter, int count) {
    return '$filter, $count';
  }

  @override
  String get subscriptionsCountError => 'Δεν ήταν δυνατή η καταμέτρηση των συνδρομών';

  @override
  String get subscriptionsNoMatches => 'Δεν βρέθηκαν αποτελέσματα';

  @override
  String subscriptionsNoNewsletterMatch(String text) {
    return 'Κανένα newsletter δεν ονομάζεται «$text».';
  }

  @override
  String subscriptionsNoListMatch(String text) {
    return 'Καμία λίστα δεν ονομάζεται «$text».';
  }

  @override
  String get subscriptionsNoNewsletters => 'Κανένα newsletter';

  @override
  String get subscriptionsNoNewslettersDetail =>
      'Τα newsletter και η άλλη μαζική αλληλογραφία εμφανίζονται εδώ μόλις φτάσουν.';

  @override
  String get subscriptionsNothingNeverRead => 'Τίποτα που δεν διαβάζεται ποτέ';

  @override
  String get subscriptionsNothingRarelyRead => 'Τίποτα που διαβάζεται σπάνια';

  @override
  String get subscriptionsNothingFilteredDetail => 'Διαβάζετε λίγο από όλα όσα λαμβάνετε.';

  @override
  String get subscriptionsNoDiscussions => 'Καμία συζήτηση';

  @override
  String get subscriptionsNoDiscussionsDetail =>
      'Οι λίστες αλληλογραφίας στις οποίες μπορείτε να γράψετε εμφανίζονται εδώ μόλις φτάσουν τα μηνύματά τους.';

  @override
  String get subscriptionsDiscussionsFootnote =>
      'Λίστες στις οποίες γράφουν αρκετά άτομα. Αγγίξτε παρατεταμένα μία για να την καρφιτσώσετε στα Γραμματοκιβώτια, να τη διαβάζετε ως απλό κείμενο ή να τη μετακινήσετε στα Newsletter.';

  @override
  String get subscriptionsPrivacyNote =>
      'Μετριέται σε αυτό το τηλέφωνο από τα μηνύματα που έχει κατεβάσει· τίποτα δεν στέλνεται πουθενά για αυτό. Το Loupe επικοινωνεί με έναν αποστολέα μόνο όταν πατάτε «Απεγγραφή»: η απεγγραφή με ένα πάτημα στέλνει μόνο το «List-Unsubscribe=One-Click» στη διεύθυνση που έδωσε ο αποστολέας, χωρίς cookies και τίποτε άλλο για εσάς, και δεν φορτώνει ποτέ τις σελίδες ή τις εικόνες του.';

  @override
  String get subscriptionsVolumeNone => 'Τίποτα πρόσφατα';

  @override
  String get subscriptionsVolumeUnderOne => '< 1 / μήνα';

  @override
  String subscriptionsVolumePerMonth(int count) {
    return '≈ $count / μήνα';
  }

  @override
  String subscriptionsPercent(int percent) {
    return '$percent%';
  }

  @override
  String get subscriptionsPercentUnderOne => '<1%';

  @override
  String subscriptionsReadLabel(String percent) {
    return 'αναγνωσμένα $percent';
  }

  @override
  String get subscriptionsStillSending => 'Συνεχίζει να στέλνει';

  @override
  String subscriptionsUnsubscribedOn(String date) {
    return 'Απεγγραφή στις $date';
  }

  @override
  String subscriptionsUnsubscribePageOpened(String date) {
    return 'Η σελίδα απεγγραφής άνοιξε στις $date';
  }

  @override
  String subscriptionsMethodOneClick(String site) {
    return 'Ένα πάτημα · επικοινωνία με $site';
  }

  @override
  String subscriptionsMethodMail(String addresses) {
    return 'Με email στο $addresses';
  }

  @override
  String subscriptionsMethodWeb(String site) {
    return 'Στον ιστότοπο $site';
  }

  @override
  String get subscriptionsUnsubscribe => 'Απεγγραφή';

  @override
  String get subscriptionsUnsubscribeAgain => 'Νέα απεγγραφή';

  @override
  String subscriptionsArchiveInbox(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αρχειοθέτηση $countString στα Εισερχόμενα',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsCreateRule => 'Δημιουργία κανόνα…';

  @override
  String get subscriptionsCreateRuleDetail => 'Μετακίνηση ή αρχειοθέτηση των μελλοντικών μηνυμάτων του';

  @override
  String get subscriptionsTreatAsDiscussion => 'Χειρισμός ως συζήτηση';

  @override
  String get subscriptionsTreatAsDiscussionDetail => 'Λίστα στην οποία γράφουν άτομα: ανάγνωση σαν φόρουμ';

  @override
  String get subscriptionsTreatAsNewsletter => 'Χειρισμός ως newsletter';

  @override
  String get subscriptionsBlockSender => 'Αποκλεισμός αποστολέα';

  @override
  String get subscriptionsBlock => 'Αποκλεισμός';

  @override
  String get subscriptionsBlocked => 'Αποκλεισμένος';

  @override
  String get subscriptionsBlockedDetail => 'Τα νέα μηνύματα πηγαίνουν στα Ανεπιθύμητα';

  @override
  String get subscriptionsPin => 'Καρφίτσωμα στα Γραμματοκιβώτια';

  @override
  String get subscriptionsUnpin => 'Ξεκαρφίτσωμα από τα Γραμματοκιβώτια';

  @override
  String get subscriptionsOpenDefaultView => 'Άνοιγμα στην προεπιλεγμένη προβολή';

  @override
  String get subscriptionsOpenPlainText => 'Άνοιγμα ως απλό κείμενο (σταθερού πλάτους)';

  @override
  String get subscriptionsPinned => 'Καρφιτσωμένη';

  @override
  String subscriptionsUnreadCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString μη αναγνωσμένα',
      one: '$countString μη αναγνωσμένο',
    );
    return '$_temp0';
  }

  @override
  String get subscriptionsNoMailNow => 'Δεν υπάρχουν τώρα μηνύματα από αυτόν τον αποστολέα.';

  @override
  String get subscriptionsLatestMessages => 'ΤΕΛΕΥΤΑΙΑ ΜΗΝΥΜΑΤΑ';

  @override
  String get subscriptionsMail => 'Μηνύματα';

  @override
  String get subscriptionsNoneIn90Days => 'Κανένα σε 90 ημέρες';

  @override
  String get subscriptionsRead => 'Αναγνωσμένα';

  @override
  String subscriptionsReadDetail(String percent, int read, int total) {
    final intl.NumberFormat readNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String readString = readNumberFormat.format(read);
    final intl.NumberFormat totalNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$percent · $readString από $totalString';
  }

  @override
  String get subscriptionsLastReceived => 'Τελευταία λήψη';

  @override
  String subscriptionsFolders(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Φάκελοι', one: 'Φάκελος');
    return '$_temp0';
  }

  @override
  String get subscriptionsStillSendingTitle => 'Συνεχίζει να στέλνει';

  @override
  String get subscriptionsUnsubscribedTitle => 'Απεγγραφή';

  @override
  String subscriptionsSince(String date) {
    return 'από $date';
  }

  @override
  String subscriptionsPageOpened(String date) {
    return 'η σελίδα άνοιξε στις $date';
  }

  @override
  String subscriptionsNoMethod(String sender) {
    return 'Ο αποστολέας $sender δεν αναφέρει πώς να κάνετε απεγγραφή.';
  }

  @override
  String subscriptionsNoMethodBlock(String sender) {
    return 'Ο αποστολέας $sender δεν αναφέρει πώς να κάνετε απεγγραφή. Μπορείτε όμως να τον αποκλείσετε.';
  }

  @override
  String subscriptionsUnsubscribing(String sender) {
    return 'Απεγγραφή από $sender…';
  }

  @override
  String subscriptionsUnsubscribed(String sender) {
    return 'Έγινε απεγγραφή από $sender.';
  }

  @override
  String subscriptionsUnsubscribeFailed(String reason) {
    return 'Η απεγγραφή απέτυχε: $reason';
  }

  @override
  String get subscriptionsOneClickFailedTitle => 'Η αυτόματη απεγγραφή απέτυχε';

  @override
  String get subscriptionsSendUnsubscribeEmail => 'Αποστολή email απεγγραφής';

  @override
  String subscriptionsOpenSite(String site) {
    return 'Άνοιγμα $site';
  }

  @override
  String subscriptionsOpenSiteTitle(String site) {
    return 'Άνοιγμα του $site;';
  }

  @override
  String get subscriptionsOpen => 'Άνοιγμα';

  @override
  String subscriptionsWebExplanation(String sender) {
    return 'Ο αποστολέας $sender κάνει την απεγγραφή στον ιστότοπό του. Η σελίδα ανοίγει στο πρόγραμμα περιήγησης του Loupe· ολοκληρώστε εκεί.';
  }

  @override
  String get subscriptionsWebInsecure => 'Η σύνδεση με αυτόν τον ιστότοπο δεν είναι κρυπτογραφημένη.';

  @override
  String subscriptionsHomographWarning(String site) {
    return 'Προσοχή: αυτή η διεύθυνση μιμείται το $site με γράμματα που μοιάζουν.';
  }

  @override
  String get subscriptionsHomographWarningUnknown =>
      'Προσοχή: αυτή η διεύθυνση μιμείται άλλον ιστότοπο με γράμματα που μοιάζουν.';

  @override
  String subscriptionsOpenSiteFailed(String site) {
    return 'Δεν ήταν δυνατό το άνοιγμα του $site.';
  }

  @override
  String subscriptionsWebOpened(String sender) {
    return 'Το Loupe σημειώνει τη σημερινή ημερομηνία και θα σας ενημερώσει αν ο αποστολέας $sender συνεχίσει να γράφει.';
  }

  @override
  String subscriptionsUnsubscribeTitle(String sender) {
    return 'Απεγγραφή από $sender;';
  }

  @override
  String subscriptionsOneClickContact(String site) {
    return 'Το Loupe θα επικοινωνήσει με το $site για την απεγγραφή.';
  }

  @override
  String subscriptionsOneClickExplanation(String sender) {
    return 'Είναι η μόνη φορά που το Loupe επικοινωνεί με τον ιστότοπο ενός αποστολέα. Στέλνει μόνο το «List-Unsubscribe=One-Click» στη διεύθυνση που έδωσε ο αποστολέας $sender, χωρίς cookies ή οτιδήποτε άλλο για εσάς, και δεν φορτώνει τη σελίδα.';
  }

  @override
  String get subscriptionsOneClickNotAllowed => 'Ο σύνδεσμος απεγγραφής δεν είναι ασφαλής διεύθυνση στο internet.';

  @override
  String subscriptionsOneClickTimeout(String site) {
    return 'Το $site δεν απάντησε εγκαίρως.';
  }

  @override
  String subscriptionsOneClickUnreachable(String site) {
    return 'Δεν ήταν δυνατή η σύνδεση με το $site.';
  }

  @override
  String subscriptionsOneClickRedirected(String site) {
    return 'Το $site προώθησε το αίτημα σε άλλη σελίδα, την οποία το Loupe δεν ακολουθεί.';
  }

  @override
  String subscriptionsOneClickRefused(String site, int status) {
    return 'Το $site απέρριψε το αίτημα (σφάλμα $status).';
  }

  @override
  String get subscriptionsNoAccountToSend => 'Δεν υπάρχει λογαριασμός από τον οποίο να σταλεί το email απεγγραφής.';

  @override
  String subscriptionsMailConfirm(String to, String from, String subject) {
    return 'Το Loupe θα στείλει ένα email στο $to από το $from, με θέμα «$subject».';
  }

  @override
  String subscriptionsMailSent(String address) {
    return 'Το email απεγγραφής στάλθηκε στο $address.';
  }

  @override
  String subscriptionsBlockTitle(String sender) {
    return 'Αποκλεισμός του $sender;';
  }

  @override
  String get subscriptionsBlockListMessage =>
      'Τα νέα μηνύματα από αυτή τη λίστα θα πηγαίνουν στα Ανεπιθύμητα. Μπορείτε να το αλλάξετε στις Ρυθμίσεις › Κανόνες.';

  @override
  String subscriptionsBlockSenderMessage(String address) {
    return 'Τα νέα μηνύματα από το $address θα πηγαίνουν στα Ανεπιθύμητα. Μπορείτε να το αλλάξετε στις Ρυθμίσεις › Κανόνες.';
  }

  @override
  String subscriptionsBlockedSender(String sender) {
    return 'Ο αποστολέας $sender αποκλείστηκε.';
  }

  @override
  String subscriptionsMoveToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Μετακίνηση $count στα Ανεπιθύμητα');
    return '$_temp0';
  }

  @override
  String subscriptionsBlockRuleName(String sender) {
    return 'Αποκλεισμός $sender';
  }

  @override
  String subscriptionsNowNewsletter(String sender) {
    return 'Το $sender είναι τώρα στα Newsletter.';
  }

  @override
  String subscriptionsNowDiscussion(String sender) {
    return 'Το $sender είναι τώρα στις Συζητήσεις.';
  }

  @override
  String get appLiveGateTitle => 'Δεν ήταν δυνατό το άνοιγμα των λογαριασμών σας';

  @override
  String get appLiveGateUnavailableBuild => 'Οι πραγματικοί λογαριασμοί δεν είναι ακόμη διαθέσιμοι σε αυτή την έκδοση.';

  @override
  String get appLiveGateKeyUnreadable =>
      'Το Loupe δεν μπόρεσε να διαβάσει το κλειδί που προστατεύει την αλληλογραφία σας σε αυτό το τηλέφωνο. Συχνά αυτό είναι προσωρινό: δοκιμάστε ξανά ή επανεκκινήστε το τηλέφωνο.';

  @override
  String get appLiveGateKeyMissing =>
      'Το κλειδί που προστατεύει την αλληλογραφία σας σε αυτό το τηλέφωνο χάθηκε, κάτι που μπορεί να συμβεί μετά από επαναφορά αντιγράφου ασφαλείας. Η αλληλογραφία σας βρίσκεται ακόμη στον διακομιστή.';

  @override
  String get appLiveGateDatabaseDamaged =>
      'Η βάση δεδομένων αλληλογραφίας σε αυτό το τηλέφωνο δεν μπορεί να διαβαστεί: είναι κατεστραμμένη ή άλλαξε το κλειδί της. Η αλληλογραφία σας βρίσκεται ακόμη στον διακομιστή.';

  @override
  String appLiveGateUnknownError(String error) {
    return 'Κάτι πήγε στραβά κατά το άνοιγμα των λογαριασμών σας ($error).';
  }

  @override
  String get appLiveGateResetWarning =>
      'Αυτό διαγράφει τους λογαριασμούς σας και την αλληλογραφία που είναι αποθηκευμένη σε αυτό το τηλέφωνο, μαζί με τα μηνύματα που περιμένουν στα Εξερχόμενα. Η αλληλογραφία στους διακομιστές σας δεν επηρεάζεται· προσθέστε ξανά τους λογαριασμούς σας μετά.';

  @override
  String get appLiveGateDeleteAndStartOver => 'Διαγραφή και νέα αρχή';

  @override
  String get appLiveGateUseDemo => 'Χρήση αλληλογραφίας επίδειξης';

  @override
  String get appLiveGateReset => 'Επαναφορά αλληλογραφίας σε αυτό το τηλέφωνο…';

  @override
  String get attachmentsUntitled => 'Συνημμένο';

  @override
  String get attachmentsUntitledFile => 'Χωρίς τίτλο';

  @override
  String get attachmentsOpenIn => 'Άνοιγμα με…';

  @override
  String get attachmentsSaveToFiles => 'Αποθήκευση στη συσκευή';

  @override
  String get attachmentsShareMenu => 'Κοινοποίηση…';

  @override
  String get attachmentsDownloadError =>
      'Δεν ήταν δυνατή η λήψη του συνημμένου. Ελέγξτε τη σύνδεση και δοκιμάστε ξανά.';

  @override
  String get attachmentsShareError => 'Δεν ήταν δυνατή η κοινοποίηση του συνημμένου.';

  @override
  String attachmentsNoApp(String type) {
    return 'Καμία εφαρμογή σε αυτή τη συσκευή δεν ανοίγει αυτό το αρχείο ($type). Δοκιμάστε την «Κοινοποίηση».';
  }

  @override
  String get attachmentsOpenInError => 'Δεν ήταν δυνατό το άνοιγμα του συνημμένου σε άλλη εφαρμογή.';

  @override
  String attachmentsSaved(String name) {
    return 'Αποθηκεύτηκε το «$name»';
  }

  @override
  String get attachmentsSaveError => 'Δεν ήταν δυνατή η αποθήκευση του συνημμένου.';

  @override
  String get attachmentsGone => 'Αυτό το συνημμένο δεν είναι πλέον διαθέσιμο.';

  @override
  String get attachmentsDownloadFailed => 'Δεν ήταν δυνατή η λήψη του συνημμένου.';

  @override
  String attachmentsPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count σελίδες', one: '1 σελίδα');
    return '$_temp0';
  }

  @override
  String attachmentsOnMobileData(String size) {
    return '$size μέσω δεδομένων κινητής';
  }

  @override
  String get attachmentsLargeDownload => 'Αυτό το συνημμένο είναι μεγάλο. Κατεβάστε το τώρα ή αργότερα μέσω Wi-Fi.';

  @override
  String get attachmentsDownload => 'Λήψη';

  @override
  String attachmentsDownloadingSize(String size) {
    return 'Λήψη $size…';
  }

  @override
  String get attachmentsDownloading => 'Λήψη…';

  @override
  String get attachmentsTooLarge => 'Πολύ μεγάλο για προεπισκόπηση εδώ.';

  @override
  String attachmentsTruncated(String shown, String total) {
    return 'Εμφανίζονται τα πρώτα $shown από $total. Αντιγράψτε, κοινοποιήστε ή αποθηκεύστε για να τα πάρετε όλα.';
  }

  @override
  String get attachmentsPdfUnavailable =>
      'Αυτό το PDF δεν μπορεί να εμφανιστεί εδώ (ίσως προστατεύεται με κωδικό πρόσβασης).';

  @override
  String attachmentsPageOf(int page, int count) {
    return '$page από $count';
  }

  @override
  String get attachmentsModeTable => 'Πίνακας';

  @override
  String get attachmentsModeText => 'Κείμενο';

  @override
  String get attachmentsModeMessage => 'Μήνυμα';

  @override
  String get attachmentsModeSource => 'Πηγαίος κώδικας';

  @override
  String get attachmentsDontWrap => 'Χωρίς αναδίπλωση γραμμών';

  @override
  String get attachmentsWrap => 'Αναδίπλωση γραμμών';

  @override
  String attachmentsTextInfo(String charset, int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$lines γραμμές', one: '$lines γραμμή');
    return '$charset · $_temp0';
  }

  @override
  String get attachmentsCopyAll => 'Αντιγραφή όλων';

  @override
  String get attachmentsCopied => 'Αντιγράφηκε';

  @override
  String get attachmentsImageUnavailable => 'Αυτή η εικόνα δεν μπορεί να εμφανιστεί εδώ. Δοκιμάστε το «Άνοιγμα με…».';

  @override
  String get attachmentsEmlNoSubject => '(Χωρίς θέμα)';

  @override
  String get attachmentsEmlFrom => 'Από';

  @override
  String get attachmentsEmlTo => 'Προς';

  @override
  String get attachmentsEmlCc => 'Κοιν.';

  @override
  String get attachmentsEmlDate => 'Ημερομηνία';

  @override
  String get attachmentsEmlNoText => 'Αυτό το μήνυμα δεν έχει κείμενο.';

  @override
  String attachmentsEmlAttachments(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Συνημμένα: $names',
      one: 'Συνημμένο: $names',
    );
    return '$_temp0';
  }

  @override
  String attachmentsEventOrganizer(String name) {
    return 'Διοργανωτής: $name';
  }

  @override
  String attachmentsEventMore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Και $count ακόμη συμβάντα',
      one: 'Και 1 ακόμη συμβάν',
    );
    return '$_temp0';
  }

  @override
  String get attachmentsTypeImage => 'Εικόνα';

  @override
  String attachmentsTypeNamedImage(String format) {
    return 'Εικόνα $format';
  }

  @override
  String get attachmentsTypePdf => 'Έγγραφο PDF';

  @override
  String get attachmentsTypeTsv => 'Τιμές διαχωρισμένες με tab';

  @override
  String get attachmentsTypeCsv => 'Υπολογιστικό φύλλο CSV';

  @override
  String get attachmentsTypeCalendar => 'Συμβάν ημερολογίου';

  @override
  String get attachmentsTypeEmail => 'Μήνυμα email';

  @override
  String get attachmentsTypeContact => 'Κάρτα επαφής';

  @override
  String get attachmentsTypeLog => 'Αρχείο καταγραφής';

  @override
  String get attachmentsTypeText => 'Κείμενο';

  @override
  String get attachmentsTypeZip => 'Αρχείο ZIP';

  @override
  String get attachmentsTypeArchive => 'Συμπιεσμένο αρχείο';

  @override
  String get attachmentsTypeWord => 'Έγγραφο Word';

  @override
  String get attachmentsTypeExcel => 'Υπολογιστικό φύλλο Excel';

  @override
  String get attachmentsTypePowerPoint => 'Παρουσίαση PowerPoint';

  @override
  String get attachmentsTypeWebPage => 'Ιστοσελίδα';

  @override
  String get attachmentsTypeVideo => 'Βίντεο';

  @override
  String get attachmentsTypeAudio => 'Ήχος';

  @override
  String attachmentsTypeExtension(String extension) {
    return 'Αρχείο $extension';
  }

  @override
  String get attachmentsTypeFile => 'Αρχείο';

  @override
  String get calendarUntitledEvent => 'Συμβάν';

  @override
  String get calendarAllDay => 'Ολοήμερο';

  @override
  String calendarYourTime(String time) {
    return '$time τοπική ώρα';
  }

  @override
  String calendarJoinNote(String link) {
    return 'Συμμετοχή: $link';
  }

  @override
  String calendarReplyText(String answer, String name, String details) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: αποδοχή – $details',
      'tentative': '$name: αποδοχή με επιφύλαξη – $details',
      'declined': '$name: απόρριψη – $details',
      'delegated': '$name: ανάθεση σε άλλον – $details',
      'other': '$name: καμία απάντηση – $details',
    });
    return '$_temp0';
  }

  @override
  String calendarReplyTextNoDetails(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: αποδοχή της πρόσκλησης',
      'tentative': '$name: αποδοχή της πρόσκλησης με επιφύλαξη',
      'declined': '$name: απόρριψη της πρόσκλησης',
      'delegated': '$name: ανάθεση της πρόσκλησης σε άλλον',
      'other': '$name: καμία απάντηση στην πρόσκληση',
    });
    return '$_temp0';
  }

  @override
  String get calendarMap => 'Χάρτης';

  @override
  String get calendarJoin => 'Συμμετοχή';

  @override
  String get calendarOnlineMeeting => 'Διαδικτυακή σύσκεψη';

  @override
  String calendarProviderMeeting(String provider) {
    return 'Σύσκεψη $provider';
  }

  @override
  String get calendarOrganizerYou => 'Εσείς';

  @override
  String get calendarOrganizerLabel => 'διοργανωτής';

  @override
  String get calendarStatusAccepted => 'Αποδοχή';

  @override
  String get calendarStatusMaybe => 'Ίσως';

  @override
  String get calendarStatusDeclined => 'Απόρριψη';

  @override
  String calendarAttendeeAnswer(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: αποδοχή',
      'tentative': '$name: αποδοχή με επιφύλαξη',
      'declined': '$name: απόρριψη',
      'delegated': '$name: ανάθεση σε άλλον',
      'other': '$name: καμία απάντηση',
    });
    return '$_temp0';
  }

  @override
  String calendarAttendeeAnswerWithComment(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': '$name: αποδοχή:',
      'tentative': '$name: αποδοχή με επιφύλαξη:',
      'declined': '$name: απόρριψη:',
      'delegated': '$name: ανάθεση σε άλλον:',
      'other': '$name: καμία απάντηση:',
    });
    return '$_temp0';
  }

  @override
  String calendarQuotedComment(String comment) {
    return '«$comment»';
  }

  @override
  String calendarCounter(String name) {
    return '$name: πρόταση για νέα ώρα';
  }

  @override
  String get calendarCounterUnknown => 'Ένας συμμετέχων προτείνει νέα ώρα';

  @override
  String get calendarDeclineCounter => 'Ο διοργανωτής διατήρησε την ώρα';

  @override
  String calendarRefresh(String name) {
    return '$name: αίτημα για την πιο πρόσφατη έκδοση';
  }

  @override
  String get calendarRefreshUnknown => 'Ένας συμμετέχων ζητά την πιο πρόσφατη έκδοση';

  @override
  String get calendarCancelled => 'Ακυρώθηκε';

  @override
  String get calendarCancelledByOrganizer => 'Ο διοργανωτής ακύρωσε αυτό το συμβάν.';

  @override
  String get calendarCancelledLater => 'Αυτό το συμβάν ακυρώθηκε αργότερα.';

  @override
  String get calendarOutdated => 'Παρωχημένη';

  @override
  String get calendarOutdatedDetail => 'Αυτή η πρόσκληση ενημερώθηκε αργότερα· ισχύει η νεότερη.';

  @override
  String calendarLocationRemoved(String location) {
    return 'Η τοποθεσία αφαιρέθηκε (ήταν $location)';
  }

  @override
  String get calendarLocationRemovedNone => 'Η τοποθεσία αφαιρέθηκε (δεν υπήρχε)';

  @override
  String calendarLocationChanged(String location) {
    return 'Η τοποθεσία άλλαξε σε $location';
  }

  @override
  String get calendarNewTitle => 'Νέος τίτλος';

  @override
  String get calendarRepeatChanged => 'Η επανάληψη άλλαξε';

  @override
  String get calendarUpdated => 'Ενημερώθηκε';

  @override
  String get calendarUpdatedInvitation => 'Ενημερωμένη πρόσκληση';

  @override
  String calendarTimeChanged(String before, String after) {
    return 'Η ώρα άλλαξε από $before σε $after';
  }

  @override
  String calendarUnknownZone(String zone) {
    return 'Άγνωστη ζώνη ώρας «$zone»: οι ώρες όπως γράφτηκαν';
  }

  @override
  String calendarNext(String when) {
    return 'Επόμενο: $when';
  }

  @override
  String calendarGuestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count καλεσμένοι', one: '1 καλεσμένος');
    return '$_temp0';
  }

  @override
  String calendarAcceptedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count αποδέχτηκαν', one: '1 αποδέχτηκε');
    return '$_temp0';
  }

  @override
  String calendarMaybeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ίσως');
    return '$_temp0';
  }

  @override
  String calendarDeclinedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count απέρριψαν', one: '1 απέρριψε');
    return '$_temp0';
  }

  @override
  String calendarAttendeeYou(String name) {
    return '$name (εσείς)';
  }

  @override
  String get calendarAttendeeOptional => 'προαιρετικά';

  @override
  String get calendarAttendeeRoom => 'αίθουσα';

  @override
  String calendarEarlierAnswer(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {
      'accepted': 'Αποδεχτήκατε μια προηγούμενη έκδοση.',
      'tentative': 'Αποδεχτήκατε με επιφύλαξη μια προηγούμενη έκδοση.',
      'declined': 'Απορρίψατε μια προηγούμενη έκδοση.',
      'delegated': 'Αναθέσατε σε άλλον μια προηγούμενη έκδοση.',
      'other': 'Δεν απαντήσατε σε μια προηγούμενη έκδοση.',
    });
    return '$_temp0';
  }

  @override
  String get calendarAccept => 'Αποδοχή';

  @override
  String get calendarMaybe => 'Ίσως';

  @override
  String get calendarDecline => 'Απόρριψη';

  @override
  String get calendarCommentHint => 'Σχόλιο για τον διοργανωτή (προαιρετικό)';

  @override
  String calendarReplyFrom(String organizer, String address) {
    return 'Η απάντησή σας θα σταλεί στον διοργανωτή $organizer από το $address.';
  }

  @override
  String get calendarAddComment => 'Προσθήκη σχολίου';

  @override
  String get calendarAddToCalendar => 'Προσθήκη στο ημερολόγιο';

  @override
  String calendarMoreEventsInFile(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Και $count ακόμη συμβάντα στο αρχείο',
      one: 'Και 1 ακόμη συμβάν στο αρχείο',
    );
    return '$_temp0';
  }

  @override
  String get calendarNoCalendarApp => 'Δεν υπάρχει εφαρμογή ημερολογίου για να προστεθεί το συμβάν.';

  @override
  String get calendarCantOpenCalendar => 'Δεν ήταν δυνατό το άνοιγμα του ημερολογίου.';

  @override
  String get calendarCantOpenLink => 'Δεν ήταν δυνατό το άνοιγμα του συνδέσμου.';

  @override
  String calendarJoinProviderTitle(String provider) {
    return 'Συμμετοχή στη σύσκεψη $provider;';
  }

  @override
  String get calendarJoinTitle => 'Συμμετοχή στη σύσκεψη;';

  @override
  String calendarJoinOpens(String host) {
    return 'Ανοίγει το $host στο πρόγραμμα περιήγησής σας.';
  }

  @override
  String calendarJoinHomograph(String site) {
    return 'Προσοχή: αυτή η διεύθυνση μιμείται το $site με γράμματα που μοιάζουν.';
  }

  @override
  String get calendarJoinHomographUnknown =>
      'Προσοχή: αυτή η διεύθυνση μιμείται άλλον ιστότοπο με γράμματα που μοιάζουν.';

  @override
  String calendarJoinOpen(String host) {
    return 'Άνοιγμα $host';
  }

  @override
  String get calendarNoOrganizer => 'Αυτή η πρόσκληση δεν έχει διοργανωτή στον οποίο να απαντήσετε.';

  @override
  String get calendarNoAccount => 'Δεν υπάρχει λογαριασμός από τον οποίο να απαντήσετε.';

  @override
  String calendarReplySending(String answer, String name) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Αποδοχή', 'tentative': 'Ίσως', 'other': 'Απόρριψη'});
    return '$_temp0 · αποστολή απάντησης σε $name…';
  }

  @override
  String calendarReplySent(String answer) {
    String _temp0 = intl.Intl.selectLogic(answer, {'accepted': 'Αποδοχή', 'tentative': 'Ίσως', 'other': 'Απόρριψη'});
    return '$_temp0 · η απάντηση στάλθηκε';
  }

  @override
  String get calendarReplyAlreadySent => 'Η απάντηση έχει ήδη σταλεί.';

  @override
  String get calendarReplyNotSent => 'Η απάντηση δεν στάλθηκε.';

  @override
  String get dataSmimeNeedsDevice =>
      'Το πιστοποιητικό S/MIME σας βρίσκεται σε αυτή τη συσκευή: ανοίξτε το Loupe για να υπογράψετε και να στείλετε αυτό το μήνυμα.';

  @override
  String dataSigningFailed(String error) {
    return 'Η υπογραφή απέτυχε: $error';
  }

  @override
  String get keyboardShortcuts => 'Συντομεύσεις πληκτρολογίου';

  @override
  String get keyboardGroupGeneral => 'Γενικά';

  @override
  String get keyboardGroupMessages => 'Μηνύματα';

  @override
  String get keyboardGroupCompose => 'Σύνταξη';

  @override
  String get keyboardCommandPalette => 'Παλέτα εντολών';

  @override
  String get keyboardBackClose => 'Πίσω, κλείσιμο';

  @override
  String get keyboardNextMessage => 'Επόμενο μήνυμα';

  @override
  String get keyboardPreviousMessage => 'Προηγούμενο μήνυμα';

  @override
  String get keyboardOpenMessage => 'Άνοιγμα μηνύματος';

  @override
  String get keyboardMoveToTrash => 'Μετακίνηση στον κάδο';

  @override
  String get keyboardToggleRead => 'Σήμανση ως αναγνωσμένο ή μη αναγνωσμένο';

  @override
  String get keyboardToggleFlag => 'Προσθήκη ή αφαίρεση σημαίας';

  @override
  String get keyboardCloseDraft => 'Κλείσιμο (αποθήκευση ή διαγραφή πρόχειρου)';

  @override
  String get keyboardOr => 'ή';

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
  String get mailingListsMuted => 'Το νήμα τέθηκε σε σίγαση. Τα νέα μηνύματά του θα φτάνουν ως αναγνωσμένα.';

  @override
  String get mailingListsUnmuted => 'Η σίγαση του νήματος καταργήθηκε.';

  @override
  String get mailingListsMuteThread => 'Σίγαση νήματος';

  @override
  String get mailingListsUnmuteThread => 'Κατάργηση σίγασης νήματος';

  @override
  String get mailingListsPin => 'Καρφίτσωμα στα Γραμματοκιβώτια';

  @override
  String get mailingListsUnpin => 'Ξεκαρφίτσωμα από τα Γραμματοκιβώτια';

  @override
  String get mailingListsDefaultView => 'Άνοιγμα στην προεπιλεγμένη προβολή';

  @override
  String get mailingListsPlainText => 'Άνοιγμα ως απλό κείμενο (σταθερού πλάτους)';

  @override
  String get mailingListsShowMuted => 'Εμφάνιση νημάτων σε σίγαση';

  @override
  String get mailingListsHideMuted => 'Απόκρυψη νημάτων σε σίγαση';

  @override
  String get mailingListsTreatAsNewsletter => 'Χειρισμός ως newsletter';

  @override
  String get mailingListsOptions => 'Επιλογές λίστας';

  @override
  String mailingListsUnreadCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted μη αναγνωσμένα',
      one: '$formatted μη αναγνωσμένο',
    );
    return '$_temp0';
  }

  @override
  String get mailingListsNewMessage => 'Νέο μήνυμα στη λίστα';

  @override
  String get mailingListsRowUnread => 'Μη αναγνωσμένο';

  @override
  String get mailingListsRowMuted => 'Σε σίγαση';

  @override
  String mailingListsReplyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count απαντήσεις', one: '1 απάντηση');
    return '$_temp0';
  }

  @override
  String get mailingListsNoThreads => 'Κανένα νήμα';

  @override
  String get mailingListsMutedHidden => 'Τα νήματα σε σίγαση είναι κρυφά.';

  @override
  String get mailingListsTechnicalTitle => 'Τεχνικές λίστες';

  @override
  String get mailingListsTechnicalEmpty => 'Οι λίστες αλληλογραφίας εμφανίζονται εδώ μόλις φτάσουν τα μηνύματά τους.';

  @override
  String get mailingListsTechnicalFooter =>
      'Τα μηνύματα από αυτές τις λίστες ανοίγουν ως απλό κείμενο σε γραμματοσειρά σταθερού πλάτους, με τα patch να εμφανίζονται ως diff. Το κουμπί Aa εξακολουθεί να αλλάζει την προβολή κάθε μηνύματος.';

  @override
  String get paletteMoveToMailbox => 'Μετακίνηση σε γραμματοκιβώτιο…';

  @override
  String get paletteMarkAllRead => 'Σήμανση όλων ως αναγνωσμένων';

  @override
  String get paletteExportFolder => 'Εξαγωγή φακέλου…';

  @override
  String get paletteGetNewMail => 'Λήψη νέων μηνυμάτων';

  @override
  String get paletteSnoozed => 'Σε αναβολή';

  @override
  String get paletteSubscriptions => 'Συνδρομές';

  @override
  String get paletteDiscussions => 'Συζητήσεις';

  @override
  String get paletteSmartMailbox => 'Smart Mailbox';

  @override
  String get paletteMailingList => 'Λίστα αλληλογραφίας';

  @override
  String get paletteTag => 'Ετικέτα';

  @override
  String get paletteSwipeActions => 'Ενέργειες σάρωσης';

  @override
  String get paletteNotifications => 'Ειδοποιήσεις';

  @override
  String get paletteRules => 'Κανόνες';

  @override
  String get paletteEncryption => 'Κρυπτογράφηση από άκρο σε άκρο';

  @override
  String get paletteAdvanced => 'Για προχωρημένους';

  @override
  String get paletteAddAccount => 'Προσθήκη λογαριασμού';

  @override
  String get paletteAccount => 'Λογαριασμός';

  @override
  String get paletteFolders => 'Φάκελοι';

  @override
  String get paletteRecentSearch => 'Πρόσφατη αναζήτηση';

  @override
  String paletteSearchMail(String query) {
    return 'Αναζήτηση για «$query» στην αλληλογραφία';
  }

  @override
  String get palettePlaceholder => 'Αναζήτηση ενεργειών, γραμματοκιβωτίων, ρυθμίσεων';

  @override
  String get paletteNothingFound => 'Δεν βρέθηκε τίποτα';

  @override
  String get searchNewSmartMailbox => 'Νέο Smart Mailbox';

  @override
  String searchNewSmartMailboxMessage(String query) {
    return 'Εμφανίζει ό,τι ταιριάζει με «$query».';
  }

  @override
  String searchSavedToMailboxes(String name) {
    return 'Το «$name» αποθηκεύτηκε στα Γραμματοκιβώτια';
  }

  @override
  String get searchMakeRule => 'Μετατροπή σε κανόνα';

  @override
  String get searchSaveSmartMailbox => 'Αποθήκευση ως Smart Mailbox';

  @override
  String get searchNegate => 'Άρνηση';

  @override
  String get searchDontNegate => 'Κατάργηση άρνησης';

  @override
  String get searchAllMailboxes => 'Όλα τα γραμματοκιβώτια';

  @override
  String get searchRecent => 'Πρόσφατες αναζητήσεις';

  @override
  String get searchClear => 'Εκκαθάριση';

  @override
  String get searchSuggestions => 'Προτάσεις';

  @override
  String get searchUnreadMessages => 'Μη αναγνωσμένα μηνύματα';

  @override
  String get searchFlaggedMessages => 'Μηνύματα με σημαία';

  @override
  String get searchWithAttachments => 'Μηνύματα με συνημμένα';

  @override
  String get searchUnrepliedMessages => 'Μηνύματα χωρίς απάντηση';

  @override
  String get searchTags => 'Ετικέτες';

  @override
  String get searchPeople => 'Άτομα';

  @override
  String get searchSmartMailboxes => 'Smart Mailboxes';

  @override
  String searchFromPerson(String name) {
    return 'Από: $name';
  }

  @override
  String get searchSearching => 'Αναζήτηση…';

  @override
  String get searchNoResults => 'Κανένα αποτέλεσμα';

  @override
  String searchResultCount(int count, String formatted) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$formatted αποτελέσματα',
      one: '$formatted αποτέλεσμα',
    );
    return '$_temp0';
  }

  @override
  String get searchMenu => 'Μενού αναζήτησης';

  @override
  String searchSearchingAccount(String account) {
    return 'Αναζήτηση στον λογαριασμό $account στον διακομιστή…';
  }

  @override
  String get searchSearchingUnknownAccount => 'Αναζήτηση λογαριασμού στον διακομιστή…';

  @override
  String searchAccountFailed(String account) {
    return 'Η αναζήτηση στον λογαριασμό $account στον διακομιστή απέτυχε';
  }

  @override
  String get searchUnknownAccountFailed => 'Η αναζήτηση λογαριασμού στον διακομιστή απέτυχε';

  @override
  String searchChip(String term) {
    return '$term. Πατήστε δύο φορές για επεξεργασία.';
  }

  @override
  String searchChipNegated(String term) {
    return 'Όχι $term. Πατήστε δύο φορές για επεξεργασία.';
  }

  @override
  String get searchReadAndUnread =>
      'Τα εισερχόμενα του Σρέντινγκερ: κάθε μήνυμα εδώ είναι ταυτόχρονα αναγνωσμένο και μη αναγνωσμένο, μέχρι να το ανοίξετε.';

  @override
  String searchContradiction(String term) {
    return 'Κανένα μήνυμα δεν μπορεί να είναι ταυτόχρονα «$term» και όχι.';
  }

  @override
  String get searchSyncDeviceOnly => 'Μόνο σε αυτή τη συσκευή';

  @override
  String searchSyncUnsupported(String account) {
    return 'Μόνο σε αυτή τη συσκευή: ο λογαριασμός $account δεν μπορεί να το κρατήσει';
  }

  @override
  String searchSyncNewerFormat(String account) {
    return 'Δεν συγχρονίστηκε: ο λογαριασμός $account έχει νεότερη μορφή';
  }

  @override
  String searchSyncWaiting(String account) {
    return 'Αναμονή συγχρονισμού με $account';
  }

  @override
  String searchSynced(String account) {
    return 'Συγχρονίστηκε με $account';
  }

  @override
  String get searchRename => 'Μετονομασία';

  @override
  String get searchEditSearch => 'Επεξεργασία αναζήτησης';

  @override
  String get searchDeleteSmartMailbox => 'Διαγραφή του Smart Mailbox';

  @override
  String get searchRenameSmartMailbox => 'Μετονομασία του Smart Mailbox';

  @override
  String get searchSmartMailboxDeleted => 'Αυτό το Smart Mailbox διαγράφηκε.';

  @override
  String get searchSettingsTitle => 'Smart Mailboxes';

  @override
  String get searchSettingsLocalFooter => 'Τα Smart Mailboxes μένουν σε αυτή τη συσκευή.';

  @override
  String searchSettingsServerFooter(String account) {
    return 'Τα Smart Mailboxes φυλάσσονται στον διακομιστή αλληλογραφίας σας, ώστε να τα έχουν και οι άλλες συσκευές σας, καθώς και το Thunderbird με το Expression Search Reloaded. Όσα κάνουν αναζήτηση σε όλους τους λογαριασμούς φυλάσσονται στον λογαριασμό $account· όσα αφορούν έναν φάκελο, στον λογαριασμό εκείνου του φακέλου.';
  }

  @override
  String get searchSyncVia => 'Συγχρονισμός μέσω';

  @override
  String get searchSyncViaFooter => 'Επιλέξτε τον ίδιο λογαριασμό σε κάθε συσκευή.';

  @override
  String get searchGmailCantKeep => 'Το Gmail δεν μπορεί να κρατήσει Smart Mailboxes';

  @override
  String get searchKeepOnDevice => 'Διατήρηση των Smart Mailboxes μόνο σε αυτή τη συσκευή';

  @override
  String get searchOnTheServer => 'Στον διακομιστή';

  @override
  String get searchServerFooter =>
      'Τα μεταδεδομένα διακομιστή (IMAP METADATA) δεν εμφανίζονται σε καμία εφαρμογή αλληλογραφίας. Οι διακομιστές χωρίς αυτά αποκτούν έναν φάκελο «Loupe Settings» με ένα μήνυμα· το Loupe τον κρύβει από τα Γραμματοκιβώτια.';

  @override
  String get searchSyncNow => 'Συγχρονισμός τώρα';

  @override
  String get searchStateUnsupported => 'Δεν υποστηρίζεται';

  @override
  String get searchStateNewerFormat => 'Νεότερη μορφή';

  @override
  String get searchStateFailed => 'Ο συγχρονισμός απέτυχε';

  @override
  String get searchStateSyncing => 'Συγχρονισμός…';

  @override
  String get searchStateWaiting => 'Σε αναμονή';

  @override
  String get searchStateMetadata => 'Μεταδεδομένα διακομιστή';

  @override
  String get searchStateFolder => 'Φάκελος «Loupe Settings»';

  @override
  String get searchStateNothing => 'Δεν έχει αποθηκευτεί τίποτα';

  @override
  String get sharedBack => 'Πίσω';

  @override
  String get sharedYesterday => 'Χθες';

  @override
  String sharedDateAtTime(String date, String time) {
    return '$date στις $time';
  }

  @override
  String sharedBytes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count byte', one: '1 byte');
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
  String get sharedSyncNoAccounts => 'Κανένας λογαριασμός';

  @override
  String get sharedSyncChecking => 'Έλεγχος για μηνύματα…';

  @override
  String get sharedSyncFailed => 'Ο έλεγχος για μηνύματα απέτυχε';

  @override
  String sharedSyncAccountError(String account, String error) {
    return '$account: $error';
  }

  @override
  String get sharedSyncOffline => 'Εκτός σύνδεσης';

  @override
  String get sharedSyncJustNow => 'Ενημερώθηκε μόλις τώρα';

  @override
  String sharedSyncMinutesAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Ενημερώθηκε πριν από $minutes λεπτά',
      one: 'Ενημερώθηκε πριν από 1 λεπτό',
    );
    return '$_temp0';
  }

  @override
  String sharedSyncAtTime(String time) {
    return 'Ενημερώθηκε στις $time';
  }

  @override
  String sharedSyncOnDate(String date) {
    return 'Ενημερώθηκε $date';
  }

  @override
  String get sharedMailboxAllInboxes => 'Όλα τα εισερχόμενα';

  @override
  String get sharedMailboxUnread => 'Μη αναγνωσμένα';

  @override
  String get sharedMailboxFlagged => 'Με σημαία';

  @override
  String get sharedMailboxVip => 'VIP';

  @override
  String get sharedMailboxAllDrafts => 'Όλα τα πρόχειρα';

  @override
  String get sharedMailboxAllSent => 'Όλα τα απεσταλμένα';

  @override
  String get sharedMailboxUntitled => 'Γραμματοκιβώτιο';

  @override
  String get sharedTagImportant => 'Σημαντικό';

  @override
  String get sharedTagWork => 'Εργασία';

  @override
  String get sharedTagPersonal => 'Προσωπικό';

  @override
  String get sharedTagToDo => 'Προς εκτέλεση';

  @override
  String get sharedTagLater => 'Αργότερα';

  @override
  String get sharedTags => 'Ετικέτες';

  @override
  String get sharedMoveTo => 'Μετακίνηση σε…';

  @override
  String get sharedNoRecipients => 'Χωρίς παραλήπτες';

  @override
  String get sharedUnknownSender => 'Άγνωστος αποστολέας';

  @override
  String get sharedOnServer => 'Στον διακομιστή';

  @override
  String get sharedAttachment => 'Συνημμένο';

  @override
  String get sharedSnoozedBadge => 'Σε αναβολή';

  @override
  String get sharedRowUnread => 'Μη αναγνωσμένο';

  @override
  String get sharedRowBackFromSnooze => 'Επέστρεψε από αναβολή';

  @override
  String get sharedRowVip => 'VIP';

  @override
  String get sharedRowFlagged => 'Με σημαία';

  @override
  String sharedArchived(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αρχειοθετήθηκαν $count μηνύματα',
      one: 'Αρχειοθετήθηκε 1 μήνυμα',
    );
    return '$_temp0';
  }

  @override
  String sharedDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Διαγράφηκαν $count μηνύματα',
      one: 'Διαγράφηκε 1 μήνυμα',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToInbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Μετακινήθηκαν $count μηνύματα στα Εισερχόμενα',
      one: 'Μετακινήθηκε 1 μήνυμα στα Εισερχόμενα',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToTrash(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Μετακινήθηκαν $count μηνύματα στον κάδο',
      one: 'Μετακινήθηκε 1 μήνυμα στον κάδο',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToJunk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Μετακινήθηκαν $count μηνύματα στα Ανεπιθύμητα',
      one: 'Μετακινήθηκε 1 μήνυμα στα Ανεπιθύμητα',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToMailbox(int count, String mailbox) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Μετακινήθηκαν $count μηνύματα στο $mailbox',
      one: 'Μετακινήθηκε 1 μήνυμα στο $mailbox',
    );
    return '$_temp0';
  }

  @override
  String sharedMovedToUnknownMailbox(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Μετακινήθηκαν $count μηνύματα σε γραμματοκιβώτιο',
      one: 'Μετακινήθηκε 1 μήνυμα σε γραμματοκιβώτιο',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedUntil(int count, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Αναβλήθηκαν $count μηνύματα έως $time',
      one: 'Αναβλήθηκε 1 μήνυμα έως $time',
    );
    return '$_temp0';
  }

  @override
  String sharedSnoozedOnDeviceOnly(String time) {
    return 'Σε αναβολή έως $time μόνο σε αυτή τη συσκευή: ο διακομιστής δεν μπορεί να αποθηκεύσει χρόνους αναβολής.';
  }

  @override
  String get sharedMoveOneAccount => 'Επιλέξτε μηνύματα από έναν λογαριασμό για να τα μετακινήσετε.';

  @override
  String get sharedSnoozeTitle => 'Αναβολή';

  @override
  String get sharedChangeSnoozeTimeTitle => 'Αλλαγή ώρας αναβολής';

  @override
  String sharedDeletePermanentlyQuestion(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Οριστική διαγραφή $count μηνυμάτων;',
      one: 'Οριστική διαγραφή αυτού του μηνύματος;',
    );
    return '$_temp0';
  }

  @override
  String get sharedCantBeUndone => 'Αυτό δεν μπορεί να αναιρεθεί.';

  @override
  String get sharedDeletePermanently => 'Οριστική διαγραφή';

  @override
  String get sharedSwipeRead => 'Αναγνωσμένο';

  @override
  String get sharedSwipeUnread => 'Μη αναγνωσμένο';

  @override
  String get sharedSwipeInbox => 'Εισερχόμενα';

  @override
  String get sharedSwipeDelete => 'Διαγραφή';

  @override
  String get sharedTrash => 'Στον κάδο';

  @override
  String get sharedSwipeSnooze => 'Αναβολή';

  @override
  String get sharedWakeNow => 'Επαναφορά τώρα';

  @override
  String get sharedChangeSnoozeTime => 'Αλλαγή ώρας αναβολής…';

  @override
  String get sharedSnooze => 'Αναβολή…';

  @override
  String get sharedTag => 'Ετικέτα…';

  @override
  String get sharedMoveMessage => 'Μετακίνηση μηνύματος…';

  @override
  String get sharedNotJunk => 'Όχι ανεπιθύμητο';

  @override
  String get accountSetupTitle => 'Προσθήκη λογαριασμού';

  @override
  String get accountSetupTitleDone => 'Ο λογαριασμός προστέθηκε';

  @override
  String get accountSetupAddressTitle => 'Προσθήκη λογαριασμού αλληλογραφίας';

  @override
  String get accountSetupAddressText => 'Το Loupe βρίσκει τις ρυθμίσεις για τους περισσότερους παρόχους.';

  @override
  String get accountSetupNameHint => 'Το όνομά σας';

  @override
  String get accountSetupEmail => 'Email';

  @override
  String get accountSetupEmailHint => 'name@example.com';

  @override
  String get accountSetupContinue => 'Συνέχεια';

  @override
  String get accountSetupLookingUp => 'Αναζήτηση ρυθμίσεων…';

  @override
  String get accountSetupImport => 'Εισαγωγή από το Thunderbird';

  @override
  String get accountSetupInvalidEmail => 'Εισαγάγετε μια έγκυρη διεύθυνση email.';

  @override
  String accountSetupSettingsNotFoundFor(String domain) {
    return 'Δεν βρέθηκαν ρυθμίσεις για το $domain. Εισαγάγετέ τες παρακάτω.';
  }

  @override
  String get accountSetupCheckServers => 'Ελέγξτε τα ονόματα των διακομιστών και τις θύρες.';

  @override
  String get accountSetupEnterPassword => 'Εισαγάγετε τον κωδικό πρόσβασής σας.';

  @override
  String get accountSetupConnecting => 'Σύνδεση…';

  @override
  String accountSetupWaitingFor(String provider) {
    return 'Αναμονή για $provider…';
  }

  @override
  String get accountSetupCouldNotOpenPage => 'Δεν ήταν δυνατό το άνοιγμα της σελίδας.';

  @override
  String get accountSetupCouldNotSaveName => 'Δεν ήταν δυνατή η αποθήκευση του ονόματος.';

  @override
  String get accountSetupTrustCertificate => 'Εμπιστοσύνη σε αυτό το πιστοποιητικό';

  @override
  String get accountSetupPasswordRequired => 'Απαιτείται';

  @override
  String get accountSetupShowPassword => 'Εμφάνιση κωδικού πρόσβασης';

  @override
  String get accountSetupHidePassword => 'Απόκρυψη κωδικού πρόσβασης';

  @override
  String get accountSetupAppPassword => 'Κωδικός εφαρμογής';

  @override
  String get accountSetupApiToken => 'Διακριτικό API';

  @override
  String accountSetupIncoming(String protocol) {
    return 'Εισερχόμενη · $protocol';
  }

  @override
  String get accountSetupOutgoing => 'Εξερχόμενη · SMTP';

  @override
  String get accountSetupSignIn => 'Σύνδεση';

  @override
  String accountSetupSignInWith(String provider) {
    return 'Σύνδεση με $provider';
  }

  @override
  String get accountSetupUseAppPassword => 'Χρήση κωδικού εφαρμογής';

  @override
  String get accountSetupUseAppPasswordInstead => 'Χρήση κωδικού εφαρμογής αντί γι’ αυτό';

  @override
  String get accountSetupUseDifferentAddress => 'Χρήση άλλης διεύθυνσης';

  @override
  String get accountSetupHowToCreateAppPassword => 'Πώς να δημιουργήσετε κωδικό εφαρμογής';

  @override
  String get accountSetupHowToCreateOne => 'Πώς να τον δημιουργήσετε';

  @override
  String get accountSetupGoogleNote =>
      'Συνδέεστε στη σελίδα της Google και το Loupe δεν βλέπει ποτέ τον κωδικό πρόσβασής σας. Επιτρέψτε στο Loupe να διαβάζει, να στέλνει και να οργανώνει την αλληλογραφία σας.';

  @override
  String get accountSetupGmailAppPasswordOnlyNote =>
      'Η «Σύνδεση με Google» δεν είναι ακόμη διαθέσιμη σε αυτή την έκδοση. Μπορείτε να συνδεθείτε με κωδικό εφαρμογής (απαιτεί Επαλήθευση σε 2 βήματα στον λογαριασμό σας Google).';

  @override
  String get accountSetupGmailAppPasswordNote =>
      'Δημιουργήστε έναν κωδικό εφαρμογής στον λογαριασμό σας Google και επικολλήστε τον παρακάτω.';

  @override
  String get accountSetupMicrosoftNote =>
      'Συνδέεστε στη σελίδα της Microsoft και το Loupe δεν βλέπει ποτέ τον κωδικό πρόσβασής σας. Λειτουργεί για Outlook.com και Hotmail, καθώς και για εταιρικούς ή σχολικούς λογαριασμούς στο Microsoft 365.';

  @override
  String get accountSetupMicrosoftUnavailableNote =>
      'Η σύνδεση με Microsoft έρχεται σε επόμενη έκδοση. Οι λογαριασμοί Outlook, Hotmail και Microsoft 365 τη χρειάζονται: δεν δέχονται πλέον κωδικούς πρόσβασης από εφαρμογές αλληλογραφίας.';

  @override
  String get accountSetupICloudNote =>
      'Το iCloud Mail χρειάζεται κωδικό για συγκεκριμένη εφαρμογή, όχι τον κωδικό του λογαριασμού σας Apple.';

  @override
  String get accountSetupYahooNote => 'Το Yahoo Mail χρειάζεται κωδικό εφαρμογής, όχι τον κωδικό του λογαριασμού σας.';

  @override
  String get accountSetupFastmailJmapNote =>
      'Το Loupe συνδέεται με το Fastmail μέσω JMAP με διακριτικό API: Settings › Privacy & Security › Manage API tokens, για JMAP, με πρόσβαση στο email και στην αποστολή.';

  @override
  String get accountSetupFastmailNote => 'Το Fastmail χρειάζεται κωδικό εφαρμογής για τις εφαρμογές αλληλογραφίας.';

  @override
  String get accountSetupServerSettings => 'Ρυθμίσεις διακομιστή';

  @override
  String get accountSetupSettingsNotFound => 'Δεν βρέθηκαν αυτόματα';

  @override
  String accountSetupSettingsFoundVia(String source) {
    return 'Βρέθηκαν μέσω $source';
  }

  @override
  String get accountSetupEditSettings => 'Επεξεργασία ρυθμίσεων';

  @override
  String get accountSetupSyncing => 'Η αλληλογραφία σας συγχρονίζεται.';

  @override
  String get accountSetupDescription => 'Περιγραφή';

  @override
  String get accountSetupDescriptionHint => 'Εργασία, Προσωπικό…';

  @override
  String get accountSetupColour => 'Χρώμα';

  @override
  String accountSetupColourNumber(int number) {
    return 'Χρώμα $number';
  }

  @override
  String get accountSetupSaving => 'Αποθήκευση…';

  @override
  String get accountSetupDatabaseUnavailable =>
      'Το Loupe δεν μπόρεσε να ανοίξει τη βάση δεδομένων αλληλογραφίας του σε αυτό το τηλέφωνο. Κλείστε το Loupe, ανοίξτε το ξανά και δοκιμάστε πάλι.';

  @override
  String accountSetupUnexpectedError(String error) {
    return 'Κάτι πήγε στραβά ($error). Δοκιμάστε ξανά.';
  }

  @override
  String get accountSetupSecurityNone => 'Καμία';

  @override
  String get accountSetupProtocol => 'Πρωτόκολλο';

  @override
  String get accountSetupPort => 'Θύρα';

  @override
  String get accountSetupSecurity => 'Ασφάλεια';

  @override
  String get accountSetupUsername => 'Όνομα χρήστη';

  @override
  String get accountSetupUsernameHint => 'Η διεύθυνση email σας';

  @override
  String get accountSetupNoEncryptionTitle => 'Σύνδεση χωρίς κρυπτογράφηση;';

  @override
  String get accountSetupNoEncryptionText =>
      'Ο κωδικός πρόσβασής σας και κάθε μήνυμα θα μεταδίδονταν ως απλό κείμενο. Οποιοσδήποτε στο δίκτυο, όπως σε δημόσιο Wi-Fi, θα μπορούσε να τα διαβάσει. Χρησιμοποιήστε το μόνο για διακομιστή στο δικό σας δίκτυο.';

  @override
  String get accountSetupUseWithoutEncryption => 'Χρήση χωρίς κρυπτογράφηση';

  @override
  String get accountSetupApiTokenRejected =>
      'Το διακριτικό API απορρίφθηκε. Δημιουργήστε ένα διακριτικό API του Fastmail για JMAP με πρόσβαση στο email και επικολλήστε το.';

  @override
  String get accountSetupAppPasswordRejected =>
      'Ο κωδικός απορρίφθηκε. Χρησιμοποιήστε κωδικό εφαρμογής, όχι τον κωδικό του λογαριασμού σας.';

  @override
  String get accountSetupPasswordRejected => 'Ο κωδικός απορρίφθηκε. Ελέγξτε τον και δοκιμάστε ξανά.';

  @override
  String get accountSetupServerUnreachable =>
      'Δεν είναι δυνατή η σύνδεση με τον διακομιστή. Ελέγξτε τις ρυθμίσεις διακομιστή και τη σύνδεσή σας.';

  @override
  String accountSetupCertificateUntrusted(String details) {
    return 'Το πιστοποιητικό του διακομιστή δεν είναι αξιόπιστο. $details';
  }

  @override
  String accountSetupOAuthCancelled(String provider) {
    return 'Η σύνδεση ακυρώθηκε. Πατήστε «Σύνδεση με $provider» για να δοκιμάσετε ξανά.';
  }

  @override
  String get accountSetupOAuthDeniedGmail =>
      'Το Loupe χρειάζεται άδεια για να διαβάζει και να στέλνει τα μηνύματά σας στο Gmail. Συνδεθείτε ξανά και επιτρέψτε την πρόσβαση, με επιλεγμένο το πλαίσιο του Gmail.';

  @override
  String get accountSetupOAuthDenied =>
      'Το Loupe χρειάζεται άδεια για να διαβάζει και να στέλνει την αλληλογραφία σας. Συνδεθείτε ξανά και αποδεχτείτε τις άδειες.';

  @override
  String get accountSetupOAuthAdminApproval =>
      'Ο οργανισμός σας πρέπει να εγκρίνει το Loupe για να το χρησιμοποιήσετε με αυτόν τον λογαριασμό. Ζητήστε από τον διαχειριστή IT να δώσει συναίνεση διαχειριστή για το Loupe στο Microsoft Entra ID και δοκιμάστε ξανά.';

  @override
  String get accountSetupOAuthBlocked =>
      'Οι κανόνες σύνδεσης του οργανισμού σας δεν επιτρέπουν το Loupe σε αυτή τη συσκευή. Απευθυνθείτε στον διαχειριστή IT.';

  @override
  String accountSetupOAuthNetwork(String provider) {
    return 'Δεν ήταν δυνατή η σύνδεση με $provider. Ελέγξτε τη σύνδεσή σας στο internet και δοκιμάστε ξανά.';
  }

  @override
  String accountSetupOAuthMisconfigured(String provider) {
    return 'Η σύνδεση με $provider δεν έχει ρυθμιστεί σωστά σε αυτή την έκδοση του Loupe. Αναφέρετέ το.';
  }

  @override
  String accountSetupOAuthFailed(String provider) {
    return 'Η σύνδεση με $provider δεν λειτούργησε. Δοκιμάστε ξανά.';
  }

  @override
  String accountSetupOAuthRefusedGmail(String provider) {
    return 'Η σύνδεση στο $provider έγινε, αλλά το Gmail αρνήθηκε την πρόσβαση για αυτή τη διεύθυνση. Επιλέξτε τον ίδιο λογαριασμό κατά τη σύνδεση. Σε εταιρικούς ή σχολικούς λογαριασμούς, ο διαχειριστής μπορεί να έχει απενεργοποιήσει το IMAP.';
  }

  @override
  String accountSetupOAuthRefused(String provider) {
    return 'Η σύνδεση στο $provider έγινε, αλλά ο διακομιστής αλληλογραφίας αρνήθηκε την πρόσβαση για αυτή τη διεύθυνση. Επιλέξτε τον ίδιο λογαριασμό κατά τη σύνδεση. Σε εταιρικούς ή σχολικούς λογαριασμούς, ο διαχειριστής μπορεί να έχει απενεργοποιήσει το IMAP.';
  }

  @override
  String get accountSetupOAuthServerUnreachable =>
      'Δεν είναι δυνατή η σύνδεση με τον διακομιστή αλληλογραφίας. Ελέγξτε τη σύνδεσή σας και δοκιμάστε ξανά.';

  @override
  String accountSetupSignInUnavailable(String provider) {
    return 'Η σύνδεση με $provider δεν είναι διαθέσιμη σε αυτή την έκδοση.';
  }

  @override
  String accountSetupSignedInAgain(String account) {
    return 'Συνδεθήκατε ξανά. Ο λογαριασμός $account συγχρονίζεται.';
  }

  @override
  String get accountSetupSignInAgain => 'Επανασύνδεση';

  @override
  String get accountSetupSigningIn => 'Σύνδεση…';

  @override
  String accountSetupSignInExpired(String provider, String email, String account) {
    return 'Ο πάροχος $provider δεν δέχεται πλέον τη σύνδεση του Loupe για το $email, οπότε ο λογαριασμός $account δεν συγχρονίζεται. Συνδεθείτε ξανά για να λαμβάνετε τα μηνύματά του.';
  }

  @override
  String get accountImportTitle => 'Εισαγωγή από το Thunderbird';

  @override
  String get accountImportPointCamera => 'Στρέψτε την κάμερα στον κωδικό QR που εμφανίζει το Thunderbird.';

  @override
  String accountImportProgress(int scanned, int total) {
    return 'Σαρώθηκαν $scanned από $total';
  }

  @override
  String accountImportProgressLabel(int scanned, int total) {
    String _temp0 = intl.Intl.pluralLogic(total, locale: localeName, other: 'Σαρώθηκαν $scanned από $total κωδικούς');
    return '$_temp0';
  }

  @override
  String accountImportAccountsSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count λογαριασμοί μέχρι στιγμής',
      one: '1 λογαριασμός μέχρι στιγμής',
    );
    return '$_temp0';
  }

  @override
  String get accountImportInstructions =>
      'Στον υπολογιστή σας, ανοίξτε το Thunderbird και επιλέξτε Εργαλεία › Εξαγωγή για κινητό. Επιλέξτε τους λογαριασμούς σας και σαρώστε κάθε κωδικό που εμφανίζει. Οι κωδικοί μπορούν να σαρωθούν με οποιαδήποτε σειρά.';

  @override
  String accountImportContinueWith(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Συνέχεια με $count λογαριασμούς',
      one: 'Συνέχεια με 1 λογαριασμό',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteInstead => 'Επικόλληση κειμένου';

  @override
  String get accountImportStartOver => 'Από την αρχή';

  @override
  String get accountImportDuplicateCode => 'Αυτός ο κωδικός έχει ήδη προστεθεί.';

  @override
  String get accountImportRestarted =>
      'Αυτός ο κωδικός προέρχεται από νέα εξαγωγή, οπότε οι κωδικοί που σαρώθηκαν πριν μπήκαν στην άκρη.';

  @override
  String get accountImportNotThunderbird => 'Αυτός δεν είναι κωδικός λογαριασμού του Thunderbird.';

  @override
  String get accountImportNewerVersion =>
      'Αυτός ο κωδικός προέρχεται από νεότερο Thunderbird. Ενημερώστε το Loupe για να τον εισαγάγετε.';

  @override
  String get accountImportDamaged => 'Δεν ήταν δυνατή η ανάγνωση αυτού του κωδικού του Thunderbird.';

  @override
  String get accountImportTooLarge => 'Αυτός ο κωδικός είναι πολύ μεγάλος για να είναι εξαγωγή του Thunderbird.';

  @override
  String get accountImportCouldNotOpenSettings => 'Δεν ήταν δυνατό το άνοιγμα των Ρυθμίσεων.';

  @override
  String get accountImportCameraOffTitle => 'Η πρόσβαση στην κάμερα είναι απενεργοποιημένη';

  @override
  String get accountImportCameraOffText =>
      'Επιτρέψτε στο Loupe να χρησιμοποιεί την κάμερα στις Ρυθμίσεις για να σαρώσει τον κωδικό ή επικολλήστε το κείμενο του κωδικού.';

  @override
  String get accountImportNoCameraTitle => 'Δεν υπάρχει κάμερα';

  @override
  String get accountImportNoCameraText =>
      'Το Loupe δεν μπορεί να χρησιμοποιήσει κάμερα εδώ. Επικολλήστε το κείμενο του κωδικού.';

  @override
  String get accountImportCameraFailedTitle => 'Η κάμερα δεν ξεκίνησε';

  @override
  String get accountImportCameraFailedText => 'Δοκιμάστε ξανά ή επικολλήστε το κείμενο του κωδικού.';

  @override
  String get accountImportOpenSettings => 'Άνοιγμα Ρυθμίσεων';

  @override
  String accountImportFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Βρέθηκαν $count λογαριασμοί',
      one: 'Βρέθηκε 1 λογαριασμός',
      zero: 'Δεν βρέθηκαν λογαριασμοί',
    );
    return '$_temp0';
  }

  @override
  String get accountImportNoneReadable =>
      'Κανένας από τους λογαριασμούς σε αυτούς τους κωδικούς δεν ήταν δυνατό να διαβαστεί.';

  @override
  String get accountImportChoose => 'Επιλέξτε τους λογαριασμούς που θα προστεθούν στο Loupe.';

  @override
  String accountImportMissingCodes(int count, String codes, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Οι κωδικοί $codes από $total δεν σαρώθηκαν, οπότε οι λογαριασμοί τους δεν εμφανίζονται.',
      one: 'Ο κωδικός $codes από $total δεν σαρώθηκε, οπότε οι λογαριασμοί του δεν εμφανίζονται.',
    );
    return '$_temp0';
  }

  @override
  String accountImportCodeList(String codes, String last) {
    return '$codes και $last';
  }

  @override
  String get accountImportScanMore => 'Σάρωση περισσότερων κωδικών';

  @override
  String accountImportSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count λογαριασμοί στους κωδικούς δεν ήταν δυνατό να διαβαστούν. Ίσως χρησιμοποιούν ρυθμίσεις από νεότερο Thunderbird.',
      one: '1 λογαριασμός στους κωδικούς δεν ήταν δυνατό να διαβαστεί. Ίσως χρησιμοποιεί ρυθμίσεις από νεότερο Thunderbird.',
    );
    return '$_temp0';
  }

  @override
  String get accountImportScanAgain => 'Νέα σάρωση';

  @override
  String get accountImportAlreadyAdded => 'Υπάρχει ήδη λογαριασμός με αυτή τη διεύθυνση στο Loupe.';

  @override
  String accountImportSignsInWith(String provider) {
    return 'Θα συνδεθείτε με $provider όταν προστεθεί, όπως στο Thunderbird.';
  }

  @override
  String get accountImportGmailAppPassword =>
      'Προσθέστε τον λογαριασμό με κωδικό εφαρμογής (απαιτεί Επαλήθευση σε 2 βήματα).';

  @override
  String get accountImportGmailNoSignIn =>
      'Το Thunderbird συνδέεται στο Gmail μέσω Google. Η «Σύνδεση με Google» έρχεται σε επόμενη έκδοση· μέχρι τότε, προσθέστε τον λογαριασμό με κωδικό εφαρμογής (απαιτεί Επαλήθευση σε 2 βήματα).';

  @override
  String get accountImportBrowserSignIn =>
      'Το Thunderbird συνδέεται σε αυτόν τον λογαριασμό μέσω του προγράμματος περιήγησης. Το Loupe δεν μπορεί ακόμη να το κάνει αυτό: χρησιμοποιήστε κωδικό εφαρμογής, αν τον προσφέρει ο πάροχός σας.';

  @override
  String get accountImportUnencrypted => 'Συνδέεται χωρίς κρυπτογράφηση. Χρησιμοποιήστε το μόνο στο δικό σας δίκτυο.';

  @override
  String get accountImportEnterAgain => 'Εισαγάγετέ τον ξανά';

  @override
  String get accountImportAdded => 'Προστέθηκε';

  @override
  String accountImportAdding(int index, int total) {
    return 'Προσθήκη $index από $total…';
  }

  @override
  String accountImportAddAccounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Προσθήκη $count λογαριασμών',
      one: 'Προσθήκη 1 λογαριασμού',
      zero: 'Προσθήκη λογαριασμών',
    );
    return '$_temp0';
  }

  @override
  String get accountImportPasteTitle => 'Επικόλληση κειμένου εξαγωγής';

  @override
  String get accountImportPasteText =>
      'Επικολλήστε το κείμενο ενός κωδικού εξαγωγής του Thunderbird, έναν κωδικό ανά γραμμή.';

  @override
  String get accountImportPop3 =>
      'Οι λογαριασμοί POP3 δεν υποστηρίζονται. Το Loupe κρατά την αλληλογραφία στον διακομιστή με IMAP.';

  @override
  String get accountImportKerberos => 'Αυτός ο λογαριασμός συνδέεται με Kerberos, που το Loupe δεν υποστηρίζει.';

  @override
  String get accountImportNtlm => 'Αυτός ο λογαριασμός συνδέεται με NTLM, που το Loupe δεν υποστηρίζει.';

  @override
  String get accountImportClientCertificate =>
      'Αυτός ο λογαριασμός συνδέεται με πιστοποιητικό πελάτη, που το Loupe δεν υποστηρίζει ακόμη.';

  @override
  String get accountImportMicrosoftSignIn =>
      'Η σύνδεση με Microsoft έρχεται σε επόμενη έκδοση. Οι λογαριασμοί Outlook και Microsoft 365 δεν δέχονται πλέον κωδικούς πρόσβασης από εφαρμογές αλληλογραφίας.';

  @override
  String get accountImportEnterPassword => 'Εισαγάγετε τον κωδικό πρόσβασης.';

  @override
  String get accountImportEnterAppPassword => 'Εισαγάγετε τον κωδικό εφαρμογής.';

  @override
  String get accountImportEnterApiToken => 'Εισαγάγετε το διακριτικό API.';

  @override
  String get accountImportStorageFailed =>
      'Το Loupe δεν μπόρεσε να ανοίξει τον χώρο αποθήκευσης λογαριασμών του. Δοκιμάστε ξανά αργότερα.';

  @override
  String get accountImportFailed =>
      'Δεν ήταν δυνατή η προσθήκη του λογαριασμού. Δοκιμάστε ξανά ή προσθέστε τον χειροκίνητα.';

  @override
  String get composeNewMessageTitle => 'Νέο μήνυμα';

  @override
  String get composeAttach => 'Επισύναψη';

  @override
  String get composeSendLater => 'Αποστολή αργότερα';

  @override
  String composeSendAt(String time) {
    return 'Αποστολή $time';
  }

  @override
  String get composeSendHint => 'Πατήστε παρατεταμένα για αποστολή αργότερα';

  @override
  String get composeNoAccount => 'Προσθέστε έναν λογαριασμό για να στέλνετε μηνύματα.';

  @override
  String get composeTo => 'Προς:';

  @override
  String get composeCc => 'Κοιν.:';

  @override
  String get composeBcc => 'Ιδιαίτ. κοιν.:';

  @override
  String composeCcBccFrom(String email) {
    return 'Κοιν./Ιδιαίτ. κοιν., Από: $email';
  }

  @override
  String get composeFromLabel => 'Από:';

  @override
  String get composeSubjectLabel => 'Θέμα:';

  @override
  String composeReplyTo(String address) {
    return 'Απάντηση προς: $address';
  }

  @override
  String get composeFrom => 'Από';

  @override
  String composeReplyFrom(String email) {
    return 'Απάντηση από $email';
  }

  @override
  String composeSendFrom(String email) {
    return 'Αποστολή από $email';
  }

  @override
  String composeReplyFromSuggestion(String email) {
    return 'Απάντηση από $email;';
  }

  @override
  String composeSendFromSuggestion(String email) {
    return 'Αποστολή από $email;';
  }

  @override
  String get composeDismiss => 'Παράβλεψη';

  @override
  String composeAliasNotSaved(String account) {
    return 'Δεν έχει αποθηκευτεί ως ταυτότητα · $account';
  }

  @override
  String get composeSaveAsIdentity => 'Αποθήκευση ως ταυτότητα';

  @override
  String composeAliasSaved(String email) {
    return 'Το $email αποθηκεύτηκε ως ταυτότητα.';
  }

  @override
  String composeInvalidAddressLabel(String address) {
    return 'Μη έγκυρη διεύθυνση $address';
  }

  @override
  String get composeOriginalNotFound => 'Δεν βρέθηκε το αρχικό μήνυμα.';

  @override
  String get composeDraftNotFound => 'Δεν βρέθηκε το πρόχειρο.';

  @override
  String get composeAttachmentsLost => 'Δεν ήταν δυνατή η ανάκτηση των συνημμένων. Προσθέστε τα ξανά.';

  @override
  String composeSomeAttachmentsFailed(String error) {
    return 'Ορισμένα συνημμένα δεν ήταν δυνατό να προστεθούν: $error';
  }

  @override
  String composeAttachmentsLarge(String size) {
    return 'Τα συνημμένα είναι συνολικά $size· ορισμένοι διακομιστές απορρίπτουν τόσο μεγάλα μηνύματα.';
  }

  @override
  String get composeAttachFailed => 'Δεν ήταν δυνατή η επισύναψη του αρχείου.';

  @override
  String get composeInvalidAddressTitle => 'Μη έγκυρη διεύθυνση';

  @override
  String composeInvalidAddress(String address) {
    return 'Το «$address» δεν είναι έγκυρη διεύθυνση email.';
  }

  @override
  String get composeNoSubjectTitle => 'Χωρίς θέμα';

  @override
  String get composeNoSubjectText => 'Αυτό το μήνυμα δεν έχει θέμα. Να σταλεί παρ’ όλα αυτά;';

  @override
  String get composeSentBeforeChanges => 'Στάλθηκε πριν από τις αλλαγές σας, οι οποίες αποθηκεύτηκαν στα Πρόχειρα.';

  @override
  String composeScheduled(String time) {
    return 'Προγραμματίστηκε για $time';
  }

  @override
  String get composeSending => 'Αποστολή…';

  @override
  String get composeSent => 'Στάλθηκε';

  @override
  String get composeSendFailed => 'Η αποστολή απέτυχε. Δοκιμάστε ξανά.';

  @override
  String get composeAlreadySent => 'Έχει ήδη σταλεί.';

  @override
  String get composeDiscardChanges => 'Απόρριψη αλλαγών';

  @override
  String get composeSaveChanges => 'Αποθήκευση αλλαγών';

  @override
  String get composeDeleteDraft => 'Διαγραφή πρόχειρου';

  @override
  String get composeSaveDraft => 'Αποθήκευση πρόχειρου';

  @override
  String get composeDraftSaved => 'Το πρόχειρο αποθηκεύτηκε';

  @override
  String composeAttribution(String date, String time, String name) {
    return 'Στις $date, $time, ο χρήστης $name έγραψε:';
  }

  @override
  String composeAttributionUnknown(String date, String time) {
    return 'Στις $date, $time, κάποιος έγραψε:';
  }

  @override
  String get composeForwardHeader => '---------- Προωθημένο μήνυμα ----------';

  @override
  String composeForwardFrom(String addresses) {
    return 'Από: $addresses';
  }

  @override
  String composeForwardDate(String date, String time) {
    return 'Ημερομηνία: $date, $time';
  }

  @override
  String composeForwardSubject(String subject) {
    return 'Θέμα: $subject';
  }

  @override
  String composeForwardTo(String addresses) {
    return 'Προς: $addresses';
  }

  @override
  String composeForwardCc(String addresses) {
    return 'Κοιν.: $addresses';
  }

  @override
  String get composeLaterToday => 'Αργότερα σήμερα';

  @override
  String get composeTomorrowMorning => 'Αύριο το πρωί';

  @override
  String get composeMondayMorning => 'Δευτέρα πρωί';

  @override
  String get composePickDateTime => 'Επιλογή ημερομηνίας και ώρας…';

  @override
  String get composeSendWithoutDelay => 'Αποστολή χωρίς καθυστέρηση';

  @override
  String composeSendTimeToday(String time) {
    return 'Σήμερα στις $time';
  }

  @override
  String composeSendTimeTomorrow(String time) {
    return 'Αύριο στις $time';
  }

  @override
  String composeSendTimeDay(String day, String time) {
    return '$day στις $time';
  }

  @override
  String composeSendTimeTodayShort(String time) {
    return 'Σήμερα $time';
  }

  @override
  String composeSendTimeTomorrowShort(String time) {
    return 'Αύριο $time';
  }

  @override
  String composeSendTimeDayShort(String day, String time) {
    return '$day $time';
  }

  @override
  String get composeRecoveryTitle => 'Συνέχεια επεξεργασίας του πρόχειρού σας;';

  @override
  String composeRecoveryUntitled(String recipients, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Ένα μήνυμα δεν στάλθηκε όταν έκλεισε το Loupe.',
      'one': 'Ένα μήνυμα προς $name δεν στάλθηκε όταν έκλεισε το Loupe.',
      'other': 'Ένα μήνυμα προς $name και άλλους δεν στάλθηκε όταν έκλεισε το Loupe.',
    });
    return '$_temp0';
  }

  @override
  String composeRecoveryWithSubject(String recipients, String subject, String name) {
    String _temp0 = intl.Intl.selectLogic(recipients, {
      'none': 'Το «$subject» δεν στάλθηκε όταν έκλεισε το Loupe.',
      'one': 'Το «$subject» προς $name δεν στάλθηκε όταν έκλεισε το Loupe.',
      'other': 'Το «$subject» προς $name και άλλους δεν στάλθηκε όταν έκλεισε το Loupe.',
    });
    return '$_temp0';
  }

  @override
  String get composeRecoveryContinue => 'Συνέχεια επεξεργασίας';

  @override
  String get composeRecoverySave => 'Αποθήκευση στα Πρόχειρα';

  @override
  String get composeRecoveryDiscard => 'Απόρριψη';

  @override
  String get composeRecoverySaved => 'Αποθηκεύτηκε στα Πρόχειρα';

  @override
  String get outboxSectionFailed => 'Δεν στάλθηκαν';

  @override
  String get outboxSectionSending => 'Αποστολή';

  @override
  String get outboxSectionScheduled => 'Προγραμματισμένα';

  @override
  String get outboxStatusQueued => 'Θα σταλεί σύντομα';

  @override
  String get outboxStatusSending => 'Αποστολή…';

  @override
  String get outboxStatusFailed => 'Δεν στάλθηκε';

  @override
  String get outboxNoRecipients => 'Χωρίς παραλήπτες';

  @override
  String get outboxNoSubject => '(Χωρίς θέμα)';

  @override
  String get outboxSendingFailed => 'Η αποστολή απέτυχε.';

  @override
  String get outboxEmptyTitle => 'Τίποτα για αποστολή';

  @override
  String get outboxEmptyText => 'Τα μηνύματα που στέλνετε αργότερα περιμένουν εδώ μέχρι να έρθει η ώρα τους.';

  @override
  String get outboxSendNow => 'Αποστολή τώρα';

  @override
  String get outboxReschedule => 'Νέα ώρα';

  @override
  String get outboxRescheduleMenu => 'Αλλαγή ώρας…';

  @override
  String get outboxRescheduleTitle => 'Αλλαγή ώρας αποστολής';

  @override
  String outboxRescheduled(String time) {
    return 'Επαναπρογραμματίστηκε για $time';
  }

  @override
  String get outboxCancel => 'Ακύρωση';

  @override
  String get outboxCancelSending => 'Ακύρωση αποστολής…';

  @override
  String get outboxCancelTitle => 'Ακύρωση αποστολής;';

  @override
  String get outboxMoveToDrafts => 'Μετακίνηση στα Πρόχειρα';

  @override
  String get outboxDiscard => 'Απόρριψη μηνύματος';

  @override
  String get outboxMovedToDrafts => 'Μετακινήθηκε στα Πρόχειρα';

  @override
  String get outboxDiscarded => 'Το μήνυμα απορρίφθηκε';

  @override
  String get outboxAlreadySent => 'Έχει ήδη σταλεί.';

  @override
  String get outboxBeingSent => 'Αυτό το μήνυμα αποστέλλεται.';

  @override
  String get outboxActionFailed => 'Αυτό δεν λειτούργησε. Το μήνυμα είναι ακόμη στα Εξερχόμενα.';

  @override
  String get notificationsBadgeInboxes => 'Μη αναγνωσμένα στα Εισερχόμενα';

  @override
  String get notificationsBadgeVip => 'Μη αναγνωσμένα VIP';

  @override
  String get notificationsVipChannel => 'VIP';

  @override
  String get notificationsVipChannelDescription => 'Νέα μηνύματα από τις επαφές VIP σας, σε οποιονδήποτε λογαριασμό';

  @override
  String notificationsAccountChannelDescription(String email) {
    return 'Νέα μηνύματα στο $email';
  }

  @override
  String get notificationsUnknownSender => 'Άγνωστος αποστολέας';

  @override
  String get notificationsNoSubject => '(Χωρίς θέμα)';

  @override
  String get notificationsEncryptedMessage => 'Κρυπτογραφημένο μήνυμα';

  @override
  String notificationsHiddenMessage(String account) {
    return 'Νέο μήνυμα από $account';
  }

  @override
  String notificationsNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count νέα μηνύματα', one: '1 νέο μήνυμα');
    return '$_temp0';
  }

  @override
  String notificationsHiddenSummary(String account) {
    return 'Νέα μηνύματα στο $account';
  }

  @override
  String get platformInstantChannel => 'Άμεση παράδοση';

  @override
  String get platformInstantChannelDescription =>
      'Εμφανίζεται όσο το Loupe παρακολουθεί τα εισερχόμενά σας για νέα μηνύματα';

  @override
  String get platformInstantTitle => 'Αναμονή για νέα μηνύματα';

  @override
  String get platformInstantText => 'Η Άμεση παράδοση είναι ενεργή';

  @override
  String get platformErrorBox => 'Κάτι πήγε στραβά κατά την εμφάνιση. Επιστρέψτε και δοκιμάστε ξανά.';

  @override
  String get welcomeTagline => 'Αλληλογραφία απλή στην επιφάνεια\nκαι ισχυρή στο βάθος.';

  @override
  String get welcomeAccountsTitle => 'Όλοι οι λογαριασμοί σε ενιαία, ήρεμα εισερχόμενα';

  @override
  String get welcomeAccountsText => 'Gmail, Outlook, iCloud, Fastmail και κάθε διακομιστής IMAP ή JMAP.';

  @override
  String get welcomeSearchTitle => 'Αναζήτηση που βρίσκει';

  @override
  String get welcomeSearchText => 'Άμεσα αποτελέσματα στο τηλέφωνό σας και μετά από τον διακομιστή.';

  @override
  String get welcomePrivacyTitle => 'Ιδιωτικότητα από τον σχεδιασμό';

  @override
  String get welcomePrivacyText =>
      'Χωρίς παρακολούθηση. Οι απομακρυσμένες εικόνες μένουν αποκλεισμένες μέχρι να πείτε εσείς.';

  @override
  String get welcomeAddAccount => 'Προσθήκη λογαριασμού';

  @override
  String get welcomeImport => 'Εισαγωγή από το Thunderbird';

  @override
  String get welcomeTryDemo => 'Δοκιμή με αλληλογραφία επίδειξης';
}
