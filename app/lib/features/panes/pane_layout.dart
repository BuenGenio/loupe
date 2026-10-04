import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/app_mode.dart';
import '../../settings/app_settings.dart';

/// How the mail screens are arranged for a width.
enum PaneLayout {
  /// Phones: one screen at a time, as a stack of pages.
  stack,

  /// 840–1100 dp: list and conversation side by side; Mailboxes slides in.
  split,

  /// From 1100 dp: Mailboxes, list and conversation.
  threePane;

  static const splitWidth = 840.0;
  static const threePaneWidth = 1100.0;

  static PaneLayout forWidth(double width) => width >= threePaneWidth
      ? PaneLayout.threePane
      : width >= splitWidth
      ? PaneLayout.split
      : PaneLayout.stack;

  static PaneLayout of(BuildContext context) => forWidth(MediaQuery.sizeOf(context).width);

  bool get wide => this != PaneLayout.stack;
}

/// The widths the user dragged the dividers to, kept across launches.
@immutable
final class PaneWidths {
  const PaneWidths({this.mailboxes = defaultMailboxes, this.list = defaultList, this.mailboxesHidden = false});

  static const defaultMailboxes = 280.0;
  static const defaultList = 380.0;
  static const minMailboxes = 220.0;
  static const maxMailboxes = 420.0;
  static const minList = 300.0;
  static const maxList = 560.0;

  /// The conversation never gets narrower than this.
  static const minConversation = 380.0;

  final double mailboxes;
  final double list;

  /// The Mailboxes column of the three-pane layout, hidden from the
  /// sidebar button.
  final bool mailboxesHidden;

  /// The Mailboxes column's width within [total].
  double mailboxesIn(double total) =>
      mailboxes.clamp(minMailboxes, math.max(minMailboxes, math.min(maxMailboxes, total - minList - minConversation)));

  /// The list's width when [used] of [total] already went to Mailboxes.
  double listIn(double total, {double used = 0}) =>
      list.clamp(minList, math.max(minList, math.min(maxList, total - used - minConversation)));

  PaneWidths copyWith({double? mailboxes, double? list, bool? mailboxesHidden}) => PaneWidths(
    mailboxes: mailboxes ?? this.mailboxes,
    list: list ?? this.list,
    mailboxesHidden: mailboxesHidden ?? this.mailboxesHidden,
  );

  @override
  bool operator ==(Object other) =>
      other is PaneWidths &&
      other.mailboxes == mailboxes &&
      other.list == list &&
      other.mailboxesHidden == mailboxesHidden;

  @override
  int get hashCode => Object.hash(mailboxes, list, mailboxesHidden);
}

final paneWidthsProvider = NotifierProvider<PaneWidthsController, PaneWidths>(PaneWidthsController.new);

class PaneWidthsController extends Notifier<PaneWidths> {
  static const mailboxesKey = 'layout.mailboxesWidth';
  static const listKey = 'layout.listWidth';
  static const hiddenKey = 'layout.mailboxesHidden';

  @override
  PaneWidths build() {
    ref.watch(prefsEpochProvider);
    final p = ref.watch(sharedPreferencesProvider);
    return PaneWidths(
      mailboxes: p.getDouble(mailboxesKey) ?? PaneWidths.defaultMailboxes,
      list: p.getDouble(listKey) ?? PaneWidths.defaultList,
      mailboxesHidden: p.getBool(hiddenKey) ?? false,
    );
  }

  /// While dragging: only the state changes.
  void resize({double? mailboxes, double? list}) => state = state.copyWith(
    mailboxes: mailboxes?.clamp(PaneWidths.minMailboxes, PaneWidths.maxMailboxes),
    list: list?.clamp(PaneWidths.minList, PaneWidths.maxList),
  );

  /// After dragging: keeps the widths for the next launch.
  Future<void> save() async {
    final p = ref.read(sharedPreferencesProvider);
    await p.setDouble(mailboxesKey, state.mailboxes);
    await p.setDouble(listKey, state.list);
  }

  Future<void> setMailboxesHidden(bool hidden) async {
    state = state.copyWith(mailboxesHidden: hidden);
    await ref.read(sharedPreferencesProvider).setBool(hiddenKey, hidden);
  }
}

/// The panes of the wide layout.
enum MailPane { mailboxes, list, conversation }

/// Tells a screen it is a pane of the wide layout, and which.
class MailPaneScope extends InheritedWidget {
  const MailPaneScope({super.key, required this.pane, required this.layout, this.titleLeading, required super.child});

  final MailPane pane;
  final PaneLayout layout;

  /// Leads the pane's title bar when its screen has no button there: the
  /// sidebar button of the list pane.
  final Widget? titleLeading;

  static MailPaneScope? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MailPaneScope>();

  /// The pane [context] is in, without depending on it (for callbacks).
  static MailPane? paneOf(BuildContext context) => context.getInheritedWidgetOfExactType<MailPaneScope>()?.pane;

  @override
  bool updateShouldNotify(MailPaneScope oldWidget) =>
      pane != oldWidget.pane || layout != oldWidget.layout || titleLeading != oldWidget.titleLeading;
}
