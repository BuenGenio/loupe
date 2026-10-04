import 'package:mail_model/mail_model.dart';

import 'demo_data.dart';

/// Messages that show the phishing check and the privacy report: a
/// newsletter whose links go through click trackers (no issues, just
/// privacy), an impostor using a VIP's name (be careful) and a look-alike
/// of the work domain (likely phishing). The parcel scam in the personal
/// inbox shows a failing authentication check.
extension DemoSecurityCases on DemoSeed {
  static const impostor = EmailAddress('dana.okafor.office@fastpost.example', 'Dana Okafor');
  static const lookalikeIt = EmailAddress('it-help@northwlnd.example', 'Northwind IT');

  void securityCases() {
    add(
      account: DemoAccounts.personal,
      box: 'INBOX',
      at: at(1, 8, 12),
      from: DemoPeople.run,
      subject: 'Race recap: Riverside 10K results and photos',
      html: _trackedNewsletterHtml,
      unread: true,
      headers: const [
        ('List-Unsubscribe', '<https://striderun.example/unsubscribe?u=sam>, <mailto:unsubscribe@striderun.example>'),
        ('List-Unsubscribe-Post', 'List-Unsubscribe=One-Click'),
        ('Precedence', 'bulk'),
      ],
    );
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(1, 9, 41),
      from: impostor,
      subject: 'Quick favour',
      text:
          'Hi Sam,\n\nAre you at your desk? I need a quick favour before my 2 pm. Can you pick up six \$100 gift '
          'cards for a client thank-you? I will pay you back today.\n\nPlease keep it between us for now, it is a '
          'surprise. Write back to this address, I am on my personal email while travelling.\n\nDana\n\n'
          'Sent from my phone',
      unread: true,
    );
    add(
      account: DemoAccounts.work,
      box: 'INBOX',
      at: at(1, 7, 58),
      from: lookalikeIt,
      replyTo: const [EmailAddress('helpdesk@northwind-support.example', 'Northwind IT')],
      subject: 'Action needed: your mailbox password expires today',
      html: _lookalikeHtml,
      unread: true,
    );
  }
}

const _ses = 'https://k3x9q2.r.eu-west-1.awstrack.me/L0';
const _sesTail = '/1/0102018f3b2a4c1d-9e8f7a6b-5c4d-4e3f-8a9b-0c1d2e3f4a5b-000000/Ab3dEf=401';

/// Every link goes through Amazon SES click tracking; one also through a
/// Google redirect (pasted from a shared document), and the destinations
/// carry utm_ parameters. A pixel counts the open.
const _trackedNewsletterHtml =
    '''
<div style="max-width:560px;font-family:Helvetica,Arial,sans-serif;font-size:16px;line-height:1.5;color:#222">
<div style="display:none;max-height:0;overflow:hidden">Results, photos and the winter plan.</div>
<h1 style="font-size:24px">Riverside 10K: what a morning</h1>
<p>Hi runners! 214 of you crossed the line on Saturday, 31 of them for the first time. Thank you to every
volunteer who stood in the cold with cups of water.</p>
<p><a href="$_ses/https:%2F%2Fstriderun.example%2Fresults%2Friverside-10k%3Futm_source=newsletter%26utm_medium=email%26utm_campaign=recap$_sesTail"
style="background:#e4572e;color:#ffffff;padding:12px 20px;border-radius:6px;text-decoration:none;font-weight:bold">See your results</a></p>
<p>Ana took wonderful photos at the finish:
<a href="$_ses/https:%2F%2Fwww.google.com%2Furl%3Fq%3Dhttps%253A%252F%252Fphotos.example%252Falbum%252Friverside-10k%26sa%3DD$_sesTail">the album</a>.</p>
<p><b>Winter plan.</b> Thursday tempo runs move to 6 pm from November. Details and sign-up on
<a href="$_ses/https:%2F%2Fstriderun.example%2Fwinter%3Futm_source=newsletter%26utm_medium=email$_sesTail">striderun.example</a>.</p>
<p>See you out there!<br>Stride Run Club</p>
<p style="font-size:12px;color:#888888">You get this because you are a club member.
<a href="https://striderun.example/unsubscribe?u=sam">Unsubscribe</a></p>
<img src="https://k3x9q2.r.eu-west-1.awstrack.me/I0/0102018f3b2a4c1d-9e8f7a6b/xVz=401" width="1" height="1" alt="">
</div>''';

/// IT's look: the work domain with an l for the i.
const _lookalikeHtml = '''
<div style="font-family:Segoe UI,Arial,sans-serif;font-size:15px;color:#222">
<p style="font-size:20px;font-weight:600;color:#0f4c81">Northwind IT Service Desk</p>
<p>Hello Sam,</p>
<p>The password for <b>sam.rivera@northwind.example</b> expires <b>today at 17:00</b>. To keep your current
password and avoid losing access to email and Teams, confirm it below.</p>
<p><a href="https://northwlnd.example/owa/auth/keep-password?user=sam.rivera"
style="background:#0f4c81;color:#ffffff;padding:10px 18px;border-radius:4px;text-decoration:none">Keep my current password</a></p>
<p>Thank you,<br>Northwind IT</p>
<p style="font-size:11px;color:#888">This is an automated message from the IT Service Desk.</p>
</div>''';
