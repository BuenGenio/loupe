import 'keywords.dart';

/// Projects group the conversations about one thing across folders and
/// accounts (docs/projects-format.md). A message is in a project when it has
/// the project's keyword, `$loupe-project-<id>`; the projects themselves
/// (name, colour) are a document on the home account's server.
abstract final class Projects {
  /// Project keywords start with this; the rest is the project's id.
  static const keywordPrefix = r'$loupe-project-';

  static final _id = RegExp(r'^[a-z0-9_-]{1,64}$');

  /// Whether [id] can name a project: lower-case letters, digits, `_` and
  /// `-`, so that its keyword is a valid IMAP atom and JMAP keyword.
  static bool isValidId(String id) => _id.hasMatch(id);

  /// The keyword of project [id] (a [isValidId] id).
  static String keyword(String id) => '$keywordPrefix$id';

  /// The project [keyword] marks, or null for other keywords.
  static String? idOf(String keyword) {
    final k = Keywords.normalize(keyword);
    if (!k.startsWith(keywordPrefix)) return null;
    final id = k.substring(keywordPrefix.length);
    return isValidId(id) ? id : null;
  }

  static bool isProjectKeyword(String keyword) => Keywords.normalize(keyword).startsWith(keywordPrefix);

  /// The ids of the projects among [keywords].
  static Set<String> idsIn(Iterable<String> keywords) => {for (final k in keywords) ?idOf(k)};
}
