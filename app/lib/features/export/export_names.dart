/// File names for saved messages and exported folders.
library;

/// Characters no file system takes (Windows' set; Android's FAT and exFAT
/// storage refuses them too), and control characters.
final _forbidden = RegExp(r'[\x00-\x1f\x7f/\\:*?"<>|]');

/// The longest name before the extension, in characters.
const maxFileNameLength = 80;

/// [text] made safe as a file name: runs of white space (tabs and line
/// breaks too) become one space, other forbidden characters `_`, without
/// leading dots (hidden files) or trailing dots and spaces (Windows drops
/// them), cut to [maxLength] characters without splitting one. Empty when
/// nothing is left.
String sanitiseFileName(String text, {int maxLength = maxFileNameLength}) {
  var name = text.replaceAll(RegExp(r'\s+'), ' ').replaceAll(_forbidden, '_').trim();
  name = name.replaceFirst(RegExp(r'^[.\s]+'), '');
  final runes = name.runes;
  if (runes.length > maxLength) name = String.fromCharCodes(runes.take(maxLength));
  return name.replaceFirst(RegExp(r'[.\s]+$'), '');
}

/// The name of a message saved as a file: `<subject>.eml`, or `message.eml`
/// (file names stay plain ASCII, the same in every language).
String messageFileName(String subject) {
  final name = sanitiseFileName(subject);
  return '${name.isEmpty ? 'message' : name}.eml';
}

/// The name of an exported folder: `<account> - <folder>.mbox`.
String folderFileName(String account, String folder) {
  final a = sanitiseFileName(account, maxLength: maxFileNameLength ~/ 2);
  final f = sanitiseFileName(folder, maxLength: maxFileNameLength ~/ 2);
  final name = [a, f].where((s) => s.isNotEmpty).join(' - ');
  return '${name.isEmpty ? 'mail' : name}.mbox';
}
