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
    'posta inviata',
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
List<RemoteMailbox> buildRemoteMailboxes(List<ListEntry> entries, {Set<String>? subscribedRawNames}) {
  final flagsKnown = entries.any((e) => e.flags.contains(r'\subscribed'));
  final byPath = <String, RemoteMailbox>{};
  final delimiters = <String, String?>{};
  for (final e in entries) {
    final isInbox = e.rawName.toUpperCase() == 'INBOX';
    final path = isInbox ? 'INBOX' : decodeModifiedUtf7(e.rawName);
    if (byPath.containsKey(path)) continue;
    final d = e.delimiter;
    final cut = d == null || d.isEmpty ? -1 : path.lastIndexOf(d);
    final parent = cut > 0 ? path.substring(0, cut) : null;
    final leaf = cut > 0 ? path.substring(cut + d!.length) : path;
    var role = MailboxRole.none;
    for (final f in e.flags) {
      final r = _specialUse[f];
      if (r != null) {
        role = r;
        break;
      }
    }
    if (isInbox) role = MailboxRole.inbox;
    final subscribed =
        isInbox ||
        switch (subscribedRawNames) {
          final names? => names.contains(e.rawName),
          null => !flagsKnown || e.flags.contains(r'\subscribed'),
        };
    byPath[path] = RemoteMailbox(
      path: path,
      name: isInbox ? 'Inbox' : leaf,
      role: role,
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
  _assignRolesByName(byPath);
  return byPath.values.toList();
}

void _assignRolesByName(Map<String, RemoteMailbox> byPath) {
  final taken = {for (final b in byPath.values) b.role};
  for (final entry in _roleNames.entries) {
    if (taken.contains(entry.key)) continue;
    RemoteMailbox? best;
    for (final box in byPath.values) {
      if (box.role != MailboxRole.none || !box.isSelectable) continue;
      if (!entry.value.contains(box.name.toLowerCase())) continue;
      // Top-level or directly under INBOX (Courier/Cyrus style) only.
      final parent = box.parentPath;
      if (parent != null && parent != 'INBOX' && !parent.startsWith('[')) continue;
      if (best == null || box.path.length < best.path.length) best = box;
    }
    if (best != null) {
      byPath[best.path] = RemoteMailbox(
        path: best.path,
        name: best.name,
        role: entry.key,
        parentPath: best.parentPath,
        isSelectable: best.isSelectable,
        isSubscribed: best.isSubscribed,
      );
    }
  }
}
