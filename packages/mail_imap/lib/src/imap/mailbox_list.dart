/// LIST results → [RemoteMailbox]es with roles.
library;

import 'package:mail_model/mail_model.dart';

import '../util/modified_utf7.dart';
import 'parsers.dart';

const _specialUse = {
  r'\inbox': MailboxRole.inbox,
  r'\sent': MailboxRole.sent,
  r'\drafts': MailboxRole.drafts,
  r'\trash': MailboxRole.trash,
  r'\junk': MailboxRole.junk,
  r'\spam': MailboxRole.junk,
  r'\archive': MailboxRole.archive,
  r'\all': MailboxRole.all,
  r'\allmail': MailboxRole.all,
  r'\flagged': MailboxRole.flagged,
  r'\starred': MailboxRole.flagged,
  r'\important': MailboxRole.important,
};

/// Common (and localised) folder names of servers without SPECIAL-USE.
const _roleNames = <MailboxRole, List<String>>{
  MailboxRole.sent: [
    'sent',
    'sent items',
    'sent messages',
    'sent mail',
    'sent-mail',
    'gesendet',
    'gesendete objekte',
    'gesendete elemente',
    'gesendete nachrichten',
    'envoyés',
    'envoyes',
    'éléments envoyés',
    'messages envoyés',
    'enviados',
    'elementos enviados',
    'posta inviata',
    'inviati',
    'verzonden',
    'verzonden items',
    'skickat',
    'skickade objekt',
    'sendt',
    'sendte elementer',
    'lähetetyt',
    'wysłane',
    'odeslaná pošta',
    'elküldött',
    'отправленные',
    'enviadas',
    'itens enviados',
    'gönderilmiş öğeler',
    '送信済み',
    '已发送',
  ],
  MailboxRole.drafts: [
    'drafts',
    'draft',
    'entwürfe',
    'entwurf',
    'brouillons',
    'borradores',
    'bozze',
    'concepten',
    'utkast',
    'kladder',
    'luonnokset',
    'kopie robocze',
    'koncepty',
    'piszkozatok',
    'черновики',
    'rascunhos',
    'taslaklar',
    '下書き',
    '草稿',
  ],
  MailboxRole.trash: [
    'trash',
    'deleted items',
    'deleted messages',
    'deleted',
    'bin',
    'papierkorb',
    'gelöschte elemente',
    'gelöschte objekte',
    'gelöscht',
    'corbeille',
    'éléments supprimés',
    'papelera',
    'elementos eliminados',
    'cestino',
    'posta eliminata',
    'prullenbak',
    'verwijderde items',
    'papperskorgen',
    'borttagna objekt',
    'papirkurv',
    'slettede elementer',
    'roskakori',
    'kosz',
    'koš',
    'kuka',
    'корзина',
    'удаленные',
    'lixeira',
    'itens excluídos',
    'çöp kutusu',
    'ゴミ箱',
    '已删除',
  ],
  MailboxRole.junk: [
    'junk',
    'spam',
    'junk e-mail',
    'junk email',
    'junk mail',
    'bulk mail',
    'junk-e-mail',
    'spamverdacht',
    'unerwünscht',
    'courrier indésirable',
    'indésirables',
    'pourriel',
    'correo no deseado',
    'posta indesiderata',
    'ongewenste e-mail',
    'skräppost',
    'søppelpost',
    'roskaposti',
    'спам',
    'lixo eletrônico',
    '迷惑メール',
    '垃圾邮件',
  ],
  MailboxRole.archive: [
    'archive',
    'archives',
    'archiv',
    'archivo',
    'archivio',
    'archief',
    'arkiv',
    'archiwum',
    'архив',
  ],
  MailboxRole.all: ['all mail', 'alle nachrichten', 'tous les messages', 'todos', 'tutti i messaggi'],
  MailboxRole.flagged: ['starred', 'flagged'],
  MailboxRole.important: ['important'],
  MailboxRole.outbox: ['outbox', 'postausgang', "boîte d'envoi", 'bandeja de salida'],
};

/// Builds mailboxes from LIST entries. [subscribedRawNames] is the LSUB
/// result when the server lacks LIST-EXTENDED (then `\Subscribed` flags are
/// absent); null means "use the `\Subscribed` flags if any entry has them,
/// else treat everything as subscribed".
///
/// Each role goes to at most one mailbox (see [_assignRoles]); the other
/// candidates keep [MailboxRole.none].
List<RemoteMailbox> buildRemoteMailboxes(List<ListEntry> entries, {Set<String>? subscribedRawNames}) {
  final flagsKnown = entries.any((e) => e.flags.contains(r'\subscribed'));
  final byPath = <String, RemoteMailbox>{};
  final delimiters = <String, String?>{};
  final specialUse = <String, MailboxRole>{};
  for (final e in entries) {
    final isInbox = e.rawName.toUpperCase() == 'INBOX';
    final path = isInbox ? 'INBOX' : decodeModifiedUtf7(e.rawName);
    if (byPath.containsKey(path)) continue;
    final d = e.delimiter;
    final cut = d == null || d.isEmpty ? -1 : path.lastIndexOf(d);
    final parent = cut > 0 ? path.substring(0, cut) : null;
    final leaf = cut > 0 ? path.substring(cut + d!.length) : path;
    for (final f in e.flags) {
      final r = _specialUse[f];
      if (r != null) {
        specialUse[path] = r;
        break;
      }
    }
    final subscribed =
        isInbox ||
        switch (subscribedRawNames) {
          final names? => names.contains(e.rawName),
          null => !flagsKnown || e.flags.contains(r'\subscribed'),
        };
    byPath[path] = RemoteMailbox(
      path: path,
      name: isInbox ? 'Inbox' : leaf,
      role: isInbox ? MailboxRole.inbox : MailboxRole.none,
      parentPath: parent,
      isSelectable: !e.flags.contains(r'\noselect') && !e.flags.contains(r'\nonexistent'),
      isSubscribed: subscribed,
    );
    delimiters[path] = d;
  }
  // Parents a server didn't list (e.g. LIST "%" gaps): add them as containers.
  for (final box in byPath.values.toList()) {
    var parent = box.parentPath;
    final d = delimiters[box.path];
    while (parent != null && !byPath.containsKey(parent) && d != null) {
      final cut = parent.lastIndexOf(d);
      final grand = cut > 0 ? parent.substring(0, cut) : null;
      byPath[parent] = RemoteMailbox(
        path: parent,
        name: cut > 0 ? parent.substring(cut + d.length) : parent,
        parentPath: grand,
        isSelectable: false,
      );
      parent = grand;
    }
  }
  _assignRoles(byPath, specialUse);
  return byPath.values.toList();
}

/// The SUBSCRIBE or UNSUBSCRIBE command for [mailboxArg], an encoded and
/// quoted mailbox name (`ImapConnection.mailboxArg`).
String subscriptionCommand(String mailboxArg, {required bool subscribe}) =>
    '${subscribe ? 'SUBSCRIBE' : 'UNSUBSCRIBE'} $mailboxArg';

/// Gives each role to at most one mailbox. Servers can flag several
/// mailboxes with one SPECIAL-USE attribute (mailcow marks "Archive",
/// "Archiv" and "Archives" `\Archive`), and folders named like a role may
/// exist next to the flagged one. The preference: the SPECIAL-USE flag, then
/// the role's usual name ("Archive" before "Archives"), then the shortest
/// path. Folders without SPECIAL-USE only qualify by name, at the top level
/// or directly under INBOX (Courier/Cyrus style). INBOX is the only inbox.
void _assignRoles(Map<String, RemoteMailbox> byPath, Map<String, MailboxRole> specialUse) {
  int nameRank(RemoteMailbox box, MailboxRole role) {
    final names = _roleNames[role] ?? const <String>[];
    final i = names.indexOf(box.name.toLowerCase());
    return i < 0 ? 2 : (i == 0 ? 0 : 1);
  }

  int compare(RemoteMailbox a, RemoteMailbox b, MailboxRole role) {
    var c = nameRank(a, role).compareTo(nameRank(b, role));
    if (c != 0) return c;
    c = a.path.length.compareTo(b.path.length);
    return c != 0 ? c : a.path.compareTo(b.path);
  }

  final holders = <MailboxRole, RemoteMailbox>{};
  void pick(MailboxRole role, Iterable<RemoteMailbox> candidates) {
    RemoteMailbox? best;
    for (final box in candidates) {
      if (best == null || compare(box, best, role) < 0) best = box;
    }
    if (best != null) holders[role] = best;
  }

  final assignable = byPath.values.where((b) => b.isSelectable && b.role != MailboxRole.inbox).toList();
  for (final role in MailboxRole.values) {
    if (role == MailboxRole.none || role == MailboxRole.inbox) continue;
    pick(role, assignable.where((b) => specialUse[b.path] == role));
  }
  final taken = {for (final b in holders.values) b.path};
  for (final MapEntry(key: role, value: names) in _roleNames.entries) {
    if (holders.containsKey(role)) continue;
    pick(
      role,
      assignable.where((b) {
        // Flagged for another role, or already holding one.
        if (specialUse.containsKey(b.path) || taken.contains(b.path)) return false;
        if (!names.contains(b.name.toLowerCase())) return false;
        final parent = b.parentPath;
        return parent == null || parent == 'INBOX' || parent.startsWith('[');
      }),
    );
    if (holders[role] case final box?) taken.add(box.path);
  }
  for (final MapEntry(key: role, value: box) in holders.entries) {
    byPath[box.path] = RemoteMailbox(
      path: box.path,
      name: box.name,
      role: role,
      parentPath: box.parentPath,
      isSelectable: box.isSelectable,
      isSubscribed: box.isSubscribed,
    );
  }
}
