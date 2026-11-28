import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mail_model/mail_model.dart';

import '../../demo/demo_files.dart';
import '../../l10n/l10n.dart';
import '../../settings/app_mode.dart';
import '../../shared/format.dart';
import '../../theme/loupe_icons.dart';
import '../attachments/attachment_icon.dart';
import '../conversation/sheets.dart';

/// Files the demo offers when attaching (compose's paper clip): Sam's
/// documents of the Private AI storyline, so Reply Check can be tried
/// without such files on the phone. Empty outside the demo, where the paper
/// clip opens the phone's file picker at once.
final demoAttachmentsProvider = Provider<List<OutgoingAttachment>>(
  (ref) => ref.watch(appModeProvider) == AppMode.demo ? DemoFiles.all() : const [],
);

/// What was picked in [showDemoAttachSheet]: one of the demo's files, or
/// [browse] for the phone's file picker.
typedef DemoAttachChoice = ({OutgoingAttachment? file, bool browse});

/// The demo's attach sheet: its documents, then Browse Files… for the
/// phone's own. Null when it is closed without a choice.
Future<DemoAttachChoice?> showDemoAttachSheet(BuildContext context, List<OutgoingAttachment> files) =>
    showLoupeSheet<DemoAttachChoice>(
      context,
      builder: (context) {
        final l10n = context.l10n;
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SheetGroup(
                  header: l10n.composeReplyCheckDemoFiles,
                  children: [
                    for (final f in files)
                      SheetRow(
                        key: ValueKey('demo-file-${f.filename}'),
                        icon: attachmentIcon(f.mimeType, f.filename),
                        label: f.filename,
                        subtitle: formatBytes(f.data.length),
                        onTap: () => Navigator.of(context).pop((file: f, browse: false)),
                      ),
                  ],
                ),
                SheetGroup(
                  children: [
                    SheetRow(
                      key: const Key('demo-file-browse'),
                      icon: LoupeIcons.folder,
                      label: l10n.composeReplyCheckBrowseFiles,
                      onTap: () => Navigator.of(context).pop((file: null, browse: true)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
