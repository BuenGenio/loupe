import 'mailbox.dart';

/// Where a document Loupe keeps on a mail server is stored.
enum ServerStorage {
  /// A private server annotation (IMAP METADATA, RFC 5464) named
  /// [ServerDocuments.metadataEntry].
  metadata,

  /// A message in the [ServerDocuments.folderName] folder, for servers
  /// without METADATA.
  folder,
}

/// One stored copy of a document Loupe keeps on an account's server:
/// settings that follow the user to every device, such as Smart Mailboxes.
///
/// A server can hold several copies at once (two devices writing the folder
/// at the same moment, or a folder copy left from before METADATA was
/// enabled). Readers merge them all and pass the copies they merged as
/// `replaces` when they write the result, so nothing a reader hasn't seen is
/// ever removed.
final class ServerDocument {
  const ServerDocument({required this.content, required this.storage, this.ref});

  /// The document, e.g. JSON text.
  final String content;
  final ServerStorage storage;

  /// Identifies this copy for replacing it (for [ServerStorage.folder], the
  /// message's email id). Opaque to callers.
  final String? ref;

  @override
  String toString() => 'ServerDocument(${storage.name}${ref == null ? '' : ' $ref'}, ${content.length} chars)';
}

/// Names shared by the transports, the repositories and the app.
abstract final class ServerDocuments {
  /// The folder holding documents on servers without METADATA. Created
  /// unsubscribed; Loupe hides it on the Mailboxes screen.
  static const folderName = 'Loupe Settings';

  /// Smart Mailboxes (docs/smart-mailboxes-format.md).
  static const smartMailboxes = 'smart-mailboxes';

  /// The METADATA entry of document [name] on the server itself (the empty
  /// mailbox name).
  static String metadataEntry(String name) => '/private/vendor/loupe/$name';

  /// The message header naming the document a folder message holds.
  static const header = 'X-Loupe-Document';

  /// Whether a folder named [name] under [parentPath] is the documents
  /// folder: at the top level, or right under INBOX on servers that keep
  /// every folder there.
  static bool isFolderName(String name, String? parentPath) =>
      name == folderName && (parentPath == null || parentPath.toUpperCase() == 'INBOX');

  /// Whether [mailbox] is the documents folder (judged by its server path,
  /// whatever the hierarchy delimiter).
  static bool isFolder(Mailbox mailbox) {
    final path = mailbox.path;
    if (path == folderName) return true;
    return path.length == 6 + folderName.length && path.endsWith(folderName) && path.toUpperCase().startsWith('INBOX');
  }
}
