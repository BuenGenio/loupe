import 'package:flutter/material.dart';
import 'package:mail_model/mail_model.dart';

/// A round avatar with the sender's initials on a colour derived from the address.
class SenderAvatar extends StatelessWidget {
  const SenderAvatar({super.key, required this.address, this.size = 40});

  final EmailAddress? address;
  final double size;

  static const _palette = [
    Color(0xFF8E8E93),
    Color(0xFF5AC8FA),
    Color(0xFF34C759),
    Color(0xFFFF9500),
    Color(0xFFFF2D55),
    Color(0xFFAF52DE),
    Color(0xFF5856D6),
    Color(0xFF30B0C7),
  ];

  static String initials(EmailAddress? address) {
    if (address == null) return '?';
    final words = address.displayName.split(RegExp(r'[\s._-]+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    final first = words.first.characters.first;
    final last = words.length > 1 ? words.last.characters.first : '';
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final email = address?.email.toLowerCase() ?? '';
    final color = _palette[email.hashCode.abs() % _palette.length];
    return Semantics(
      label: address?.displayName,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.75), color],
          ),
        ),
        child: Text(
          initials(address),
          style: TextStyle(color: Colors.white, fontSize: size * 0.4, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
