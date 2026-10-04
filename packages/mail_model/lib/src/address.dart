/// A mailbox address with an optional display name.
final class EmailAddress {
  const EmailAddress(this.email, [this.name]);

  /// The address itself, e.g. `alice@example.com`.
  final String email;

  /// The display name, e.g. `Alice Example`. Null or empty when absent.
  final String? name;

  /// The name if present, otherwise the part of the address before the `@`.
  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final at = email.indexOf('@');
    return at > 0 ? email.substring(0, at) : email;
  }

  /// The domain part, lower-cased (empty if there is none).
  String get domain {
    final at = email.lastIndexOf('@');
    return at >= 0 ? email.substring(at + 1).toLowerCase() : '';
  }

  @override
  bool operator ==(Object other) =>
      other is EmailAddress && other.email.toLowerCase() == email.toLowerCase() && other.name == name;

  @override
  int get hashCode => Object.hash(email.toLowerCase(), name);

  @override
  String toString() {
    final n = name?.trim();
    if (n == null || n.isEmpty) return email;
    final quoted = RegExp(r'[",;<>@()\[\]\\:]').hasMatch(n)
        ? '"${n.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"'
        : n;
    return '$quoted <$email>';
  }
}
