// Message bodies of the demo mailbox that exercise the Readable reader: nested
// layout tables, data tables, inline images, Outlook markup, hostile colours,
// deceptive links, hidden preheaders, tracking pixels and plain text quirks.
// All people, companies and domains are fictional (.example and friends).

/// Marketing newsletter: nested layout tables, two product columns, a hidden
/// preheader, `cid:` images and a remote tracking pixel.
const trailheadNewsletterHtml = r'''<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Trailhead</title>
<style>
  .btn { background:#2f6f4f; color:#ffffff !important; padding:12px 22px; border-radius:6px; text-decoration:none; font-weight:bold; }
  @media (max-width:600px) { .col { display:block !important; width:100% !important; } }
</style></head>
<body style="margin:0;padding:0;background:#efeee9;">
<div style="display:none;max-height:0;overflow:hidden;mso-hide:all;font-size:1px;color:#efeee9;line-height:1px;">
Members get 20% off layers this weekend — plus our autumn layering guide inside.&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;
</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#efeee9">
<tr><td align="center" style="padding:24px 8px;">
  <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="width:600px;max-width:600px;background:#ffffff;">
    <tr><td style="padding:20px 24px;border-bottom:1px solid #e3e1da;">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0"><tr>
        <td align="left"><img src="cid:trailhead-logo@demo" width="180" height="40" alt="Trailhead Outfitters" style="display:block;border:0;"></td>
        <td align="right" style="font-family:Helvetica,Arial,sans-serif;font-size:12px;color:#7a776d;">
          <a href="https://trailhead.example/web/oct-26?utm_source=email" style="color:#7a776d;">View in browser</a>
        </td>
      </tr></table>
    </td></tr>
    <tr><td><img src="cid:trailhead-hero@demo" width="600" height="260" alt="Into the cold: the autumn layering guide" style="display:block;width:100%;height:auto;border:0;"></td></tr>
    <tr><td style="padding:28px 32px 8px 32px;font-family:Georgia,serif;font-size:28px;line-height:34px;color:#1f2a24;">
      Three layers, every trail.
    </td></tr>
    <tr><td style="padding:0 32px 20px 32px;font-family:Helvetica,Arial,sans-serif;font-size:16px;line-height:24px;color:#4a4f4b;">
      Mornings are getting sharper. Our guides tested this season's kit on the ridge above Hollow Lake so you don't
      have to guess: a wicking base, a warm mid and a shell that actually breathes. <b>Members save 20% on all
      layers through Sunday.</b>
    </td></tr>
    <tr><td align="center" style="padding:0 32px 28px 32px;">
      <table role="presentation" cellpadding="0" cellspacing="0"><tr><td bgcolor="#2f6f4f" style="border-radius:6px;">
        <a class="btn" href="https://click.trailhead.example/c/8f2a91?u=sam" style="display:inline-block;background:#2f6f4f;color:#ffffff;padding:12px 22px;border-radius:6px;font-family:Helvetica,Arial,sans-serif;font-size:16px;font-weight:bold;text-decoration:none;">Shop the guide</a>
      </td></tr></table>
    </td></tr>
    <tr><td style="padding:0 16px 24px 16px;">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0"><tr>
        <td class="col" width="50%" valign="top" style="padding:8px;">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f6f5f1;">
            <tr><td><img src="cid:product-jacket@demo" width="268" alt="Ridgeline insulated jacket" style="display:block;width:100%;height:auto;"></td></tr>
            <tr><td style="padding:12px 14px 4px;font-family:Helvetica,Arial,sans-serif;font-size:15px;font-weight:bold;color:#1f2a24;">Ridgeline Insulated Jacket</td></tr>
            <tr><td style="padding:0 14px 14px;font-family:Helvetica,Arial,sans-serif;font-size:14px;color:#6b6f6a;">
              <span style="text-decoration:line-through;">$229</span> <span style="color:#b4472a;font-weight:bold;">$183 for members</span>
            </td></tr>
          </table>
        </td>
        <td class="col" width="50%" valign="top" style="padding:8px;">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f6f5f1;">
            <tr><td><img src="cid:product-pack@demo" width="268" alt="Summit 28 L daypack" style="display:block;width:100%;height:auto;"></td></tr>
            <tr><td style="padding:12px 14px 4px;font-family:Helvetica,Arial,sans-serif;font-size:15px;font-weight:bold;color:#1f2a24;">Summit 28 L Daypack</td></tr>
            <tr><td style="padding:0 14px 14px;font-family:Helvetica,Arial,sans-serif;font-size:14px;color:#6b6f6a;">$119 · new colours</td></tr>
          </table>
        </td>
      </tr></table>
    </td></tr>
    <tr><td style="padding:20px 32px;background:#1f2a24;font-family:Helvetica,Arial,sans-serif;font-size:12px;line-height:18px;color:#b9c2bc;">
      Trailhead Outfitters · 14 Quarry Lane, Fernbrook<br>
      You're receiving this because you joined Trailhead Members.
      <a href="https://trailhead.example/preferences?u=sam" style="color:#ffffff;">Preferences</a> ·
      <a href="https://trailhead.example/unsubscribe?u=sam" style="color:#ffffff;">Unsubscribe</a>
    </td></tr>
  </table>
</td></tr>
</table>
<img src="https://open.trailhead.example/o/8f2a91.gif?u=sam&amp;c=oct26" width="1" height="1" alt="" style="display:block;width:1px;height:1px;border:0;">
</body></html>''';

/// A receipt with a real data table (items, quantities, prices, totals).
const bookshopReceiptHtml =
    r'''<html><body style="font-family:-apple-system,Segoe UI,Helvetica,Arial,sans-serif;color:#222;">
<table width="100%" cellpadding="0" cellspacing="0"><tr><td align="center">
<table width="560" cellpadding="0" cellspacing="0" style="max-width:560px;">
  <tr><td style="padding:16px 0;"><img src="cid:bookshop-logo@demo" width="240" height="64" alt="Corner Bookshop"></td></tr>
  <tr><td style="font-size:20px;font-weight:600;padding-bottom:4px;">Thanks for your order, Sam!</td></tr>
  <tr><td style="font-size:14px;color:#666;padding-bottom:16px;">Order <b>#10482</b> · Paid with Visa ending 4417 · Pickup at the Elm Street shop</td></tr>
  <tr><td>
    <table width="100%" cellpadding="8" cellspacing="0" style="border-collapse:collapse;font-size:14px;">
      <thead>
        <tr style="background:#f3efe8;text-align:left;">
          <th style="border-bottom:2px solid #d8d0c2;">Item</th>
          <th style="border-bottom:2px solid #d8d0c2;text-align:center;">Qty</th>
          <th style="border-bottom:2px solid #d8d0c2;text-align:right;">Price</th>
          <th style="border-bottom:2px solid #d8d0c2;text-align:right;">Total</th>
        </tr>
      </thead>
      <tbody>
        <tr><td style="border-bottom:1px solid #eee;">The Quiet Orchard (hardcover)</td><td align="center" style="border-bottom:1px solid #eee;">1</td><td align="right" style="border-bottom:1px solid #eee;">$27.00</td><td align="right" style="border-bottom:1px solid #eee;">$27.00</td></tr>
        <tr><td style="border-bottom:1px solid #eee;">Field Guide to Coastal Birds</td><td align="center" style="border-bottom:1px solid #eee;">1</td><td align="right" style="border-bottom:1px solid #eee;">$19.50</td><td align="right" style="border-bottom:1px solid #eee;">$19.50</td></tr>
        <tr><td style="border-bottom:1px solid #eee;">Notebook, dotted A5</td><td align="center" style="border-bottom:1px solid #eee;">2</td><td align="right" style="border-bottom:1px solid #eee;">$8.25</td><td align="right" style="border-bottom:1px solid #eee;">$16.50</td></tr>
        <tr><td style="border-bottom:1px solid #eee;">Gift wrap</td><td align="center" style="border-bottom:1px solid #eee;">1</td><td align="right" style="border-bottom:1px solid #eee;">$3.00</td><td align="right" style="border-bottom:1px solid #eee;">$3.00</td></tr>
      </tbody>
      <tfoot>
        <tr><td colspan="3" align="right">Subtotal</td><td align="right">$66.00</td></tr>
        <tr><td colspan="3" align="right">Members' discount (10%)</td><td align="right">−$6.60</td></tr>
        <tr><td colspan="3" align="right">Sales tax (8.5%)</td><td align="right">$5.05</td></tr>
        <tr><td colspan="3" align="right" style="font-weight:700;border-top:2px solid #222;">Total</td><td align="right" style="font-weight:700;border-top:2px solid #222;">$64.45</td></tr>
      </tfoot>
    </table>
  </td></tr>
  <tr><td style="font-size:13px;color:#666;padding-top:20px;line-height:19px;">
    Your books are ready for pickup from Thursday. Bring this email or your order number.<br>
    Questions? Reply to this message or call the shop.<br><br>
    Corner Bookshop · 210 Elm Street
  </td></tr>
</table>
</td></tr></table>
</body></html>''';

/// Photos sent inline: several `cid:` images for the reader's carousel.
const hikePhotosHtml = '''<div dir="ltr">Hey!<div><br></div>
<div>Finally got the photos off my camera. The light on the ridge was unreal &mdash; the second one is my favourite.</div>
<div><br></div>
<div><img src="cid:photo-mountains@demo" alt="IMG_2187.jpg" width="480"><br></div>
<div><img src="cid:photo-forest@demo" alt="IMG_2191.jpg" width="480"><br></div>
<div><img src="cid:photo-beach@demo" alt="IMG_2203.jpg" width="480"><br></div>
<div><img src="cid:photo-city@demo" alt="IMG_2219.jpg" width="480"><br></div>
<div><br></div>
<div>Can you send me the one you took at the lookout? Mine are all slightly crooked.</div>
<div><br></div><div>J</div></div>''';

/// Outlook / Word HTML: MsoNormal classes, fixed widths, tiny fonts, `o:p`.
const outlookSowHtml = r'''<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta name="Generator" content="Microsoft Word 15 (filtered medium)">
<style><!--
@font-face {font-family:"Cambria Math";}
@font-face {font-family:Calibri;}
p.MsoNormal, li.MsoNormal, div.MsoNormal {margin:0cm; font-size:11.0pt; font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink {mso-style-priority:99; color:#0563C1; text-decoration:underline;}
span.EmailStyle19 {mso-style-type:personal-reply; font-family:"Calibri",sans-serif; color:windowtext;}
.MsoChpDefault {mso-style-type:export-only; font-size:10.0pt;}
@page WordSection1 {size:612.0pt 792.0pt; margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1 {page:WordSection1;}
--></style></head>
<body lang="EN-US" link="#0563C1" vlink="#954F72" style="word-wrap:break-word">
<div class="WordSection1">
<table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="650" style="width:487.5pt">
<tr><td width="650" style="width:487.5pt;padding:0cm 0cm 0cm 0cm">
<p class="MsoNormal"><span style="font-size:10.0pt">Hi Sam,<o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt">Thanks for the call on Tuesday. As promised, here is the revised pricing for phase 2 of the integration work. We moved the data migration into a fixed-fee block and dropped the weekend support line, which brings the total down by about 12%.<o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<table class="MsoTableGrid" border="1" cellspacing="0" cellpadding="0" width="560" style="width:420.0pt;border-collapse:collapse;border:none">
<tr><td width="300" style="width:225.0pt;border:solid windowtext 1.0pt;background:#D9E2F3;padding:0cm 5.4pt"><p class="MsoNormal"><b><span style="font-size:9.0pt">Work package</span></b></p></td>
<td width="130" style="width:97.5pt;border:solid windowtext 1.0pt;border-left:none;background:#D9E2F3;padding:0cm 5.4pt"><p class="MsoNormal"><b><span style="font-size:9.0pt">Days</span></b></p></td>
<td width="130" style="width:97.5pt;border:solid windowtext 1.0pt;border-left:none;background:#D9E2F3;padding:0cm 5.4pt"><p class="MsoNormal" align="right" style="text-align:right"><b><span style="font-size:9.0pt">Fee (USD)</span></b></p></td></tr>
<tr><td style="border:solid windowtext 1.0pt;border-top:none;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">Discovery &amp; architecture review</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">6</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:9.0pt">10,800</span></p></td></tr>
<tr><td style="border:solid windowtext 1.0pt;border-top:none;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">Data migration (fixed fee)</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">&#8212;</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:9.0pt">24,000</span></p></td></tr>
<tr><td style="border:solid windowtext 1.0pt;border-top:none;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">Connector build &amp; QA</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal"><span style="font-size:9.0pt">18</span></p></td>
<td style="border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt"><p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:9.0pt">32,400</span></p></td></tr>
</table>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt">If this works for you I'll send the updated SOW for signature. We could start on the 3<sup>rd</sup>.<o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt">Best regards,<o:p></o:p></span></p>
<p class="MsoNormal"><b><span style="font-size:10.0pt;color:#1F3864">Olivia Grant</span></b><span style="font-size:10.0pt;color:#1F3864"><br>Engagement Manager | Fabrikam Consulting<br>M +1 555 0142 | <a href="https://fabrikam.example">fabrikam.example</a><o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
<p class="MsoNormal"><b><span style="font-size:11.0pt">From:</span></b><span style="font-size:11.0pt"> Sam Rivera &lt;sam.rivera@northwind.example&gt;<br><b>Sent:</b> Tuesday 10:12<br><b>To:</b> Olivia Grant &lt;olivia.grant@fabrikam.example&gt;<br><b>Subject:</b> Statement of work – phase 2<o:p></o:p></span></p></div>
<p class="MsoNormal"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></p>
<p class="MsoNormal"><span style="font-size:10.0pt">Hi Olivia, could you send a revised breakdown before Friday? Finance wants to close the Q4 budget.<o:p></o:p></span></p>
<p class="MsoNormal"><span style="font-size:7.5pt;font-family:Arial,sans-serif;color:gray">CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and may contain confidential and privileged information. Any unauthorized review, use, disclosure or distribution is prohibited. If you are not the intended recipient, please contact the sender by reply e-mail and destroy all copies of the original message.<o:p></o:p></span></p>
</td></tr></table>
</div></body></html>''';

/// A club newsletter whose colours only work on white: near-black text with
/// no background, navy font tags, a black box with dark grey text and
/// highlighted passages.
const bookClubHtml = r'''<html><body>
<table width="640" cellpadding="0" cellspacing="0" style="width:640px;font-family:Verdana,sans-serif;">
<tr><td style="padding:12px 0;"><font face="Georgia" size="6" color="#000080"><b>Riverside Book Club</b></font><br>
<font size="2" color="#333333">November picks &amp; meeting notes</font></td></tr>
<tr><td style="color:#111111;font-size:14px;line-height:21px;padding:8px 0;">
Hello readers,<br><br>
Thanks to everyone who came out in the rain on Thursday. We had <span style="background-color:#ffff00;">fourteen people</span>,
which is a record for a weeknight! The vote was close, but <b>November's book is <span style="background:#ffff00;color:#000000;">The Lantern Keepers</span></b>.
</td></tr>
<tr><td style="background:#000000;padding:14px;">
<p style="color:#333333;font-size:14px;margin:0;">Meeting: <b style="color:#444444;">Thursday the 20th, 7 pm</b>, upstairs at the Riverside café. Bring a snack to share.</p>
</td></tr>
<tr><td style="color:#1a1a1a;font-size:14px;line-height:21px;padding:12px 0;">
<b>Discussion questions</b> (spoilers from chapter 9 on):
<ol>
<li>Why does Mara keep the lighthouse log even after the keepers leave?</li>
<li>Is the <mark>ending hopeful or resigned</mark>? Defend your answer with one quote.</li>
<li>Which of the three timelines worked best for you?</li>
</ol>
<font color="#000080">Next month's shortlist:</font> <i>Salt and Iron</i>, <i>The Glass Orchard</i>, <i>Night Ferry</i>.
<br><br>
<span style="color:#c0c0c0;font-size:11px;">Riverside Book Club · reply to this email to leave the list.</span>
</td></tr></table>
</body></html>''';

/// A phishing-style message: the visible link text shows one domain, the
/// href points to another.
const parcelPhishHtml = r'''<html><body style="font-family:Arial,sans-serif;font-size:15px;color:#222;">
<table width="100%" cellpadding="0" cellspacing="0"><tr><td style="background:#ffcc00;padding:14px 20px;font-size:22px;font-weight:bold;color:#c00000;">PARCEL POST</td></tr></table>
<p>Dear customer,</p>
<p>We attempted to deliver your parcel <b>PP-88213-US</b> today but nobody was available to sign for it.
A <b>redelivery fee of $1.99</b> is required to reschedule. Unpaid parcels are returned to the sender after 48 hours.</p>
<p>Track and reschedule your delivery here:<br>
<a href="https://parcelpost-redelivery.example.net/login?ref=88213&amp;session=4f9a">https://www.parcelpost.example/track/PP-88213-US</a></p>
<p>Thank you for choosing Parcel Post.</p>
<p style="font-size:11px;color:#888;">This is an automated message. Please do not reply.</p>
</body></html>''';

/// format=flowed plain text with `> ` quotes (a reply from a text-only client).
/// Lines ending in a space are soft breaks that a reader may reflow.
const felixFlowedText =
    'Hi Sam,\r\n'
    '\r\n'
    'On Sunday, Sam Rivera wrote:\r\n'
    '> I finally set up the little server in the closet. It runs the backups \r\n'
    '> and the photo library, and it is so quiet I keep forgetting it is \r\n'
    '> there. Do you still run yours on the old laptop?\r\n'
    '>\r\n'
    '>> Felix wrote earlier:\r\n'
    '>> The trick is to give it a UPS. Learned that one the hard way.\r\n'
    '\r\n'
    'Yes, still the 2014 laptop, and still with the battery as a free UPS. \r\n'
    'It has outlived two "proper" servers at this point, which says \r\n'
    'something about either the laptop or my patience.\r\n'
    '\r\n'
    'Two suggestions, since you asked about the backups last time:\r\n'
    '\r\n'
    '  1. Test a restore. Not "look at the files", actually restore a \r\n'
    '     folder somewhere else and open a few.\r\n'
    '  2. Keep one copy that the server cannot delete. A USB disk you \r\n'
    '     plug in once a month is fine.\r\n'
    '\r\n'
    'Also: are you coming to the repair café on the 15th? I am bringing \r\n'
    'the radio again. Third time lucky.\r\n'
    '\r\n'
    'Felix\r\n'
    '\r\n'
    '-- \r\n'
    'Felix Brandt\r\n'
    'gpg: 4B1C 22D0 9E7A 51F3\r\n';

/// A long mailing-list post in plain text with a signature.
const gardenListLongText = '''Hi all,

Following last week's call, here is the write-up for the plugin manifest v2
proposal. Sorry it is long; the short version is at the top.

TL;DR
-----

  * Manifests become declarative: no code runs before the user grants
    permissions.
  * Permissions are scoped per garden ("beds"), not per installation.
  * We keep v1 manifests working for at least two releases.

Background
----------

Today a plugin's manifest is a JavaScript file that registers hooks when
it is loaded. That makes it impossible to show a permission prompt before
any of the plugin's code runs, and it means a broken plugin can take the
whole scheduler down on startup (see the irrigation timer incident in
August).

Proposal
--------

A v2 manifest is a TOML file:

    [plugin]
    id = "org.example.frost-alerts"
    version = "1.4.0"
    min_core = "3.2"

    [permissions]
    sensors = ["temperature", "humidity"]
    notify = true
    beds = "ask"

The core reads it, shows the permissions, and only then loads the code.
The "beds" key means the plugin asks per bed, so a frost alert plugin can
watch the tomato bed without seeing the greenhouse cameras.

Migration
---------

v1 plugins keep loading, with a yellow "legacy" badge in the plugin list.
`garden plugin migrate` writes a v2 manifest from the hooks a v1 plugin
registers at runtime. Kai tried it on the twelve most popular plugins;
ten converted cleanly, two need a manual tweak because they register
hooks lazily.

Open questions
--------------

1. Should "beds = ask" be the default, or "all"? Asking is safer but
   noisier for people with one bed.
2. Do we sign manifests? Noor pointed out that a signed manifest without
   a signed bundle buys us little.
3. Naming: is "beds" too cute for the permissions UI? "Areas" was
   suggested.

Timeline
--------

If nobody objects by the 20th I will open the PR against core. The v1
deprecation warning would land in 3.4, removal no earlier than 3.6.

Comments very welcome, here or on the tracker (#1182).

Thanks,
Wren

--
Wren Abbott · Open Garden maintainer
"Plant trees whose shade you will never sit in."

_______________________________________________
open-garden mailing list
open-garden@lists.opengarden.example
https://lists.opengarden.example/listinfo/open-garden
''';

/// Plain text with a forwarded block and a quoted reply, for quote collapsing.
const momTextWithQuote = '''Hi sweetheart,

Here is the photo from Grandpa's birthday that I promised. Doesn't he look
well? Your aunt says hello and asks when you're visiting.

Also, did you get the recipe for the lemon cake? I sent it last week but
my email has been acting strange.

Love,
Mom

On Sat, Sam Rivera wrote:
> Thanks Mom! Can you send me the picture with everyone on the porch?
> I'd like to print it for the hallway.
''';
