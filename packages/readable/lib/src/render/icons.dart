import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

/// The reader's icons. The app keeps its own mapping (LoupeIcons, which
/// this package can't import); both use Fluent UI System Icons, 24 px
/// Regular.
abstract final class ReadableIcons {
  static const IconData remoteContent = FluentIcons.shield_24_regular;
  static const IconData image = FluentIcons.image_24_regular;
  static const IconData imageBroken = FluentIcons.image_off_24_regular;
  static const IconData close = FluentIcons.dismiss_24_regular;
  static const IconData warning = FluentIcons.warning_24_regular;
  static const IconData copy = FluentIcons.copy_24_regular;
  static const IconData open = FluentIcons.open_24_regular;
  static const IconData redirect = FluentIcons.arrow_routing_24_regular;
  static const IconData linkOff = FluentIcons.link_dismiss_24_regular;
  static const IconData file = FluentIcons.document_24_regular;
  static const IconData disclosure = FluentIcons.chevron_right_24_regular;
}
