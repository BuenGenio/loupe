import 'package:flutter_test/flutter_test.dart';
import 'package:loupe/shared/mailbox_ref_codec.dart';
import 'package:mail_model/mail_model.dart';

void main() {
  test('round-trips real and virtual refs, even after an extra decode', () {
    final refs = [
      RealMailboxRef(MailIds.mailbox('work', 'Projects/Atlas/Design Reviews')),
      RealMailboxRef(MailIds.mailbox('personal', '[Gmail]/Sent Mail')),
      const VirtualMailboxRef(VirtualMailbox.allInboxes),
    ];
    for (final ref in refs) {
      final encoded = MailboxRefCodec.encode(ref);
      expect(MailboxRefCodec.decode(encoded), ref);
      expect(MailboxRefCodec.decode(Uri.decodeComponent(encoded)), ref);
      expect(encoded, isNot(contains('/')));
    }
  });

  test('still reads the original m. form', () {
    final id = MailIds.mailbox('work', 'Projects/Atlas');
    expect(MailboxRefCodec.decode('m.${Uri.encodeComponent(id)}'), RealMailboxRef(id));
  });
}
