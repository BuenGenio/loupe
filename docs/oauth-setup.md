# Sign in with Google and Microsoft: registration guide

The code is ready: account setup, the Thunderbird import, token refresh (also in background sync) and "Sign In Again" all work once the build has client ids. This guide is what the owner does by hand: register Loupe with Google and Microsoft, put the client ids into GitHub secrets, and test.

Issues: #2 (Google), #3 (Microsoft).

## At a glance

| | Google | Microsoft |
|---|---|---|
| Where | [Google Cloud console](https://console.cloud.google.com/) › Google Auth platform | [Microsoft Entra admin center](https://entra.microsoft.com/) › App registrations |
| Client | An **Android** client (custom URI scheme on) and an **iOS** client | One app registration, a public client |
| Redirect URI | `io.github.buengenio.loupe:/oauth2redirect` | `msauth.io.github.buengenio.loupe://auth` |
| Scopes | `https://mail.google.com/` | `IMAP.AccessAsUser.All`, `SMTP.Send`, `offline_access`, `openid`, `email` |
| Client secret | None | None |
| GitHub secret | `LOUPE_GOOGLE_CLIENT_ID` (Android client), `LOUPE_GOOGLE_IOS_CLIENT_ID` (iOS client) | `LOUPE_MICROSOFT_CLIENT_ID` (Android and iOS) |
| Facts | Package and bundle id `io.github.buengenio.loupe`; release SHA-1 `96:95:1E:A5:48:FB:41:B4:17:DE:D0:20:63:2E:BE:5A:8F:E2:EB:13` | |

Client ids aren't confidential: anyone can read them from the APK. The secrets keep them out of the repository and out of forks' builds. A build without one hides that provider's button and shows the old notes.

## How the code uses them

- **Build:** `--dart-define=LOUPE_GOOGLE_CLIENT_ID=…` and `--dart-define=LOUPE_MICROSOFT_CLIENT_ID=…`.
  - CI passes both from the secrets to `flutter build apk` (`.github/workflows/ci.yml`).
  - The iOS TestFlight job (commented out in `.github/workflows/ios.yml`) passes `LOUPE_GOOGLE_IOS_CLIENT_ID` as `LOUPE_GOOGLE_CLIENT_ID`.
  - Locally: `flutter run --dart-define=LOUPE_GOOGLE_CLIENT_ID=… --dart-define=LOUPE_MICROSOFT_CLIENT_ID=…`.
- **Sign-in** (`packages/mail_platform/lib/src/oauth.dart`):
  - Authorization code with PKCE in the system browser, through flutter_appauth (Custom Tabs on Android, `ASWebAuthenticationSession` on iOS).
  - The address the user typed goes along as `login_hint`.
  - Microsoft uses the `common` endpoint, so personal and work or school accounts need no choice.
- **Servers:**
  - Gmail: `imap.gmail.com:993` and `smtp.gmail.com:465`.
  - Microsoft: `outlook.office365.com:993` and `smtp.office365.com:587` (STARTTLS).
  - Both log in with XOAUTH2, the address as user name.
- **Refresh** (`packages/mail_platform/lib/src/token_endpoint.dart`):
  - A plain HTTPS POST to the token endpoint, with no plugin involved.
  - It works in the WorkManager, Instant Delivery and iOS background isolates.
  - A server that refuses a token gets one forced refresh.
- **Revoked grants:**
  - When the provider answers `invalid_grant` (or `interaction_required` and the like), the account is marked "Sign in again", and Loupe stops asking.
  - Mailboxes shows a banner, and Settings › account a Sign In Again button.
- **Redirects in the app:**
  - Android: the `appAuthRedirectScheme` placeholder in `app/android/app/build.gradle.kts` (Google), and an extra intent filter in `AndroidManifest.xml` (Microsoft).
  - iOS: two URL schemes in `Info.plist`.

## Why these redirect URIs

### Google: the package name as scheme, on an Android client with "Custom URI scheme" on

- **Google's state of play:**
  - Its [native-app guide](https://developers.google.com/identity/protocols/oauth2/native-app) (updated September 2026) accepts `com.example.app:/oauth2redirect` (reverse DNS of something you own) or `com.googleusercontent.apps.<id>:/oauth2redirect` (the reversed client id).
  - The same guide says custom URI schemes are "no longer supported on Android and Chrome apps". That is the *default*.
  - Since October 2023 new Android clients have them [off by default](https://developers.googleblog.com/en/improving-user-safety-in-oauth-flows-through-new-oauth-custom-uri-scheme-restrictions/). "If you're creating a new app and the recommended alternative doesn't work for your needs, you can enable the Custom URI scheme method" in the client's Advanced settings.
  - The Cloud console's [own help](https://support.google.com/googleapi/answer/6158849) still describes that setting: "Custom URI scheme: This setting enables custom URI schemes for your Android client."
- **Why not Google's recommended alternative:**
  - That is the Google Identity Services SDK (Credential Manager / `AuthorizationClient`). It runs in Google Play services and hands out access tokens instead of a refresh token.
  - Loupe avoids Play services (the QR scanner was chosen for that reason), and has to work on phones without them and on iOS.
  - It also can't share flutter_appauth's code path.
- **Why not the reversed client id:**
  - It isn't needed: the package name works on Android, as in [Thunderbird for Android](https://github.com/thunderbird/thunderbird-android/blob/main/app-thunderbird/src/release/kotlin/net/thunderbird/android/auth/TbOAuthConfigurationFactory.kt) (`net.thunderbird.android:/oauth2redirect`) and [FairEmail](https://github.com/M66B/FairEmail/blob/master/app/src/main/res/xml/providers.xml) (`eu.faircode.email:/`).
  - The bundle id works on iOS clients, as in [Thunderbird for iOS](https://github.com/thunderbird/thunderbird-ios/blob/main/Thunderbird/Thunderbird/Account/OAuth2.swift) (`net.thunderbird.ios:/oauth2redirect`).
  - The reversed client id would put the client id into the manifest and `Info.plist` at build time, so both would change with every client.
- **The SHA-1:**
  - Google's form requires it. In a browser flow Google can't check the signature, so it doesn't.
  - Debug builds signed with another key still sign in with the same client.

### Microsoft: `msauth.io.github.buengenio.loupe://auth`, registered as an iOS / macOS redirect

- **Why not Google's form:**
  - Entra refuses custom-scheme redirect URIs without `//`: `io.github.buengenio.loupe:/oauth2redirect` [can't be registered](https://www.traccar.org/forums/topic/mobile-app-openid-redirect-uri-incompatible-with-azure-ad/) in the portal, the CLI or Graph.
  - So issue #3's URI doesn't work.
- **What the redirect is:**
  - `msauth.<bundle id>://auth` is the redirect Entra itself generates when you add the "iOS / macOS" platform with the bundle id.
  - It is a public-client redirect, like those of "Mobile and desktop applications", the platform Microsoft [names](https://learn.microsoft.com/en-us/entra/identity-platform/reply-url) for "iOS apps using open source SDKs (AppAuth)" and "cross-plat tech we don't support (Flutter)".
- **It works on both platforms with AppAuth:**
  - [FairEmail](https://github.com/M66B/FairEmail/blob/master/app/src/main/res/xml/providers.xml) uses this very form on Android (`msauth.eu.faircode.email://auth`).
  - [Thunderbird for iOS](https://github.com/thunderbird/thunderbird-ios/blob/main/Thunderbird/Thunderbird/Account/OAuth2.swift) uses it on iOS.
- **Why not the Android platform's form:**
  - That is `msauth://io.github.buengenio.loupe/<signature hash>` (Thunderbird for Android's choice). It would tie the redirect to one signing key and to Android.
  - For the record, the release key's hash is `lpUepUj7QbQX3tAgYy6+Wo/i6xM=`, so the URI would be `msauth://io.github.buengenio.loupe/lpUepUj7QbQX3tAgYy6%2BWo%2Fi6xM%3D`.

---

## Google

Use the Google account that should own Loupe's registration for good. Add a second owner later (IAM › Grant access › role Owner) so the annual mails reach someone.

### 1. Project

1. Open <https://console.cloud.google.com/>, then project picker (top left) › **New project**.
2. Name: `Loupe`. Organisation: none (or yours). Click **Create**, then select the project.
3. Optional, but it makes the scope easy to find: **APIs & Services › Library** › search "Gmail API" › **Enable**.
   - IMAP and SMTP don't need the Gmail API.
   - With it enabled, the scope shows up in the scope picker.

### 2. Google Auth platform (the consent screen)

1. Menu › **Google Auth platform** › **Branding**. If it says "Google Auth platform not configured yet", click **Get started**:
   1. **App information:**
      - App name: `Loupe`.
      - User support email: the owner's address (it is shown to users).
      - Click **Next**.
   2. **Audience:** **External**. Click **Next**.
   3. **Contact information:** the owner's address. Click **Next**.
   4. **Finish:** tick "I agree to the Google API Services: User Data Policy", then **Continue** › **Create**.
2. **Branding**, the rest of the page (needed for verification; can wait for testing):
   - App logo: 120×120 PNG, from `app/assets/icon/`. A logo makes brand verification necessary, and that is needed anyway.
   - Application home page: the project page (see [7](#7-restricted-scope-verification)).
   - Application privacy policy link: the published `docs/privacy-policy.md`.
   - Authorized domains: the domain of both (for example `buengenio.github.io`, or your own domain).
   - Developer contact information: the owner's address.
   - Click **Save**.
3. **Data Access** › **Add or remove scopes**:
   1. At the bottom, under "Manually add scopes", paste `https://mail.google.com/`, then **Add to table**.
   2. It lands under "Your restricted scopes".
   3. Click **Update**, then **Save**.
4. **Audience** › **Test users** › **Add users**:
   1. Add the Gmail addresses that will test, the owner's included.
   2. Click **Save**.

### 3. Android client

1. **Google Auth platform** › **Clients** › **Create client**.
2. Fill in:
   - Application type: **Android**.
   - Name: `Loupe Android` (only shown in the console).
   - Package name: `io.github.buengenio.loupe`.
   - SHA-1 certificate fingerprint: `96:95:1E:A5:48:FB:41:B4:17:DE:D0:20:63:2E:BE:5A:8F:E2:EB:13`.
3. Open **Advanced settings** and turn on **Enable custom URI scheme**. Google warns that this isn't recommended; Loupe needs it (see [above](#google-the-package-name-as-scheme-on-an-android-client-with-custom-uri-scheme-on)).
   - On a client created with it off: Clients › `Loupe Android` › Advanced settings › tick it › **Save**.
4. Leave "Verify app ownership" alone: it needs a Play Store listing.
5. Click **Create**.
6. Copy the **Client ID**, `…apps.googleusercontent.com`. There is no secret.

### 4. iOS client

1. **Clients** › **Create client**.
2. Fill in:
   - Application type: **iOS**.
   - Name: `Loupe iOS`.
   - Bundle ID: `io.github.buengenio.loupe`.
   - App Store ID and Team ID: empty until the app exists in App Store Connect. Don't turn on App Check yet: it locks the bundle id.
3. Click **Create**, then copy the Client ID.

### 5. Secrets

Go to GitHub › BuenGenio/loupe › **Settings › Secrets and variables › Actions** › **New repository secret**:

| Secret | Value |
|---|---|
| `LOUPE_GOOGLE_CLIENT_ID` | the **Android** client's id |
| `LOUPE_GOOGLE_IOS_CLIENT_ID` | the **iOS** client's id (only read by the iOS TestFlight job) |

### 6. Testing, then production

**While the app is "Testing"** (Audience › Publishing status):

- Only the test users can sign in (at most 100 over the project's life), and they see a warning first.
- Google ends test users' grants **after 7 days**. The refresh token stops working, and Loupe shows "Sign in again" for the account. That is expected; sign in again from the banner.

**"Publish app"** (Audience › **Publish app**) before verification:

- Anyone can sign in after an "unverified app" screen (Advanced › Go to Loupe).
- Grants no longer expire after 7 days.
- At most **100 new users ever** until the scope is verified. The cap can't be reset.

Use this for a longer beta. Sources: [Manage app audience](https://support.google.com/cloud/answer/15549945), [unverified apps](https://support.google.com/cloud/answer/7454865).

### 7. Restricted-scope verification

`https://mail.google.com/` is a **restricted** scope. Without verification, the 100-user cap stays. Verification takes weeks, so start early.

Prepare:

1. **Home page:**
   - Public, on a domain you control, describing Loupe (what it does, that it is a mail client), with a link to the privacy policy.
   - A Google Play listing doesn't count.
   - GitHub Pages works if it is your own subdomain (`buengenio.github.io`, a separate domain since `github.io` is on the public suffix list) and verified in Search Console as below. A custom domain avoids the question.
2. **Privacy policy:**
   - [`docs/privacy-policy.md`](privacy-policy.md) is the draft: no servers, no telemetry, data only on the device and at the mail provider. It includes the Limited Use sentence Google looks for.
   - Fill in the bracketed parts and publish it **on the same domain** as the home page.
3. **Domain ownership:**
   - In [Google Search Console](https://search.google.com/search-console), add the home page's domain or URL-prefix property and verify it (HTML file or meta tag on GitHub Pages; DNS for a custom domain).
   - Do it with a Google account that is Owner or Editor of the Cloud project.
4. **Branding:**
   1. **Branding** › **Verify branding**. The automated check takes minutes.
   2. Then **Publish branding** within 7 days.
5. **Data access** (Menu › Google Auth platform › **Verification center**), once branding is published:
   - **Scope justification** (example): "Loupe is a mail client: users read, write, send, organise and delete their Gmail in the app. Gmail's IMAP and SMTP servers accept only the full `https://mail.google.com/` scope for XOAUTH2. Narrower Gmail API scopes don't work with IMAP and SMTP. All data stays on the user's device; Loupe has no server."
   - **App type:** "Built-in and web email clients that allow users to compose, send, read, and process email via a user interface" is an [approved use](https://developers.google.com/workspace/workspace-api-user-data-developer-policy) of Gmail scopes.
   - **Demo video:** YouTube, **Unlisted**, in English. [Google's checklist](https://developers.google.com/identity/protocols/oauth2/production-readiness/restricted-scope-verification):
     1. Start in Loupe: Add Account › a Gmail address › **Sign in with Google**.
     2. Show the consent screen with the app name "Loupe", and the browser's address bar long enough that the **client_id** in the URL can be read. A Custom Tab shows only the domain at first; tap the address to show the full URL. If the browser won't show it, say so in the form.
     3. Grant access, then show each use of the scope: the Inbox syncing, reading a message, sending one, moving to a folder, deleting from Trash.
     4. With two clients (Android and iOS), show the flow on both, or say in the form that iOS isn't released yet.
6. **CASA security assessment: not needed.**
   - Google requires it when "you store or transmit restricted scope data on servers" ([restricted scope verification](https://developers.google.com/identity/protocols/oauth2/production-readiness/restricted-scope-verification)).
   - No server of ours touches mail: say so in the form. That changes if a push relay (#18) ever handles mail data. A relay that only sends "sync now" without content shouldn't, but check again then.
7. **Afterwards:**
   - Keep the Branding and Data Access pages matching the app. A new scope means new verification.
   - Google mails Owners and Editors when re-verification is due.

---

## Microsoft

### 1. A tenant

- **The app must live in a Microsoft Entra tenant.** Registering apps with a personal Microsoft account outside a directory is no longer possible.
  - If you have no tenant, sign up for a free Azure account with the personal account. That creates one ("Default Directory").
- **For publisher verification** (step 6) the registration must be made by a **work account** of that tenant, not the personal account. In Entra:
  1. Users › New user.
  2. Give it the Application Administrator role.
  3. Register the app with that user.
  - To verify, the tenant also needs a DNS-verified custom domain (not `*.onmicrosoft.com`).

### 2. App registration

1. Go to <https://entra.microsoft.com/> › **Entra ID** › **App registrations** › **New registration**.
2. Fill in:
   - Name: `Loupe`.
   - Supported account types: **Accounts in any organizational directory (Any Microsoft Entra ID tenant – Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)**. In the manifest, that is `signInAudience: AzureADandPersonalMicrosoftAccount`.
   - Redirect URI: leave empty here.
3. Click **Register**.
4. Copy the **Application (client) ID** from the Overview page (a GUID).

### 3. Redirect URI

1. **Authentication** › **Add a platform** (or **Add Redirect URI**) › **iOS / macOS**.
2. Bundle ID: `io.github.buengenio.loupe`, then **Configure**.
3. Check that the generated redirect URI reads exactly `msauth.io.github.buengenio.loupe://auth`.
   - If the portal ever insists on a different platform: **Mobile and desktop applications** › custom redirect URI › the same string.
   - The same URI serves Android and iOS. Don't add the Android platform (see [above](#microsoft-msauthiogithubbuengenioloupeauth-registered-as-an-ios--macos-redirect)).
4. Under **Settings** (or "Advanced settings"), leave **Allow public client flows** at **No**.
   - It is for device code and password flows. The authorization code with PKCE from a mobile redirect needs no secret anyway.
5. **Certificates & secrets:** create **none**.

### 4. API permissions

1. **API permissions** › **Add a permission** › **Microsoft Graph** › **Delegated permissions**.
2. Tick `IMAP.AccessAsUser.All`, `SMTP.Send`, `offline_access`, `openid` and `email`, then **Add permissions**.
   - In the authorization request they are `https://outlook.office.com/IMAP.AccessAsUser.All` and `https://outlook.office.com/SMTP.Send`, as [Microsoft documents for IMAP and SMTP](https://learn.microsoft.com/en-us/exchange/client-developer/legacy-protocols/how-to-authenticate-an-imap-pop-smtp-application-by-using-oauth).
   - Listing them here makes the consent screen and an admin's "grant consent" show the right set.
3. Don't click "Grant admin consent" for your own tenant unless you want to skip the prompt there.

### 5. Branding

**Branding & properties:**

- Name `Loupe`, with the logo.
- Home page URL, Privacy statement URL (the same pages as for Google).
- Publisher domain: your verified custom domain.

### 6. Publisher verification (free)

- **Why:** since November 2020 users in other organisations [can't consent](https://learn.microsoft.com/en-us/entra/identity-platform/publisher-verification-overview) to new multi-tenant apps from unverified publishers when their tenant uses risk-based step-up consent (common). They'd see "Need admin approval".
- **Not affected:** personal Microsoft accounts. They only see "unverified".
- **Steps:**
  1. Enrol in the **Microsoft AI Cloud Partner Program** in [Partner Center](https://partner.microsoft.com/) (free), and complete its verification.
     - The account's email domain must match the app's publisher domain, or a DNS-verified domain in the tenant.
  2. Note the **Partner One ID** of the partner global account.
  3. Signed in with MFA as a user who is Application Administrator in Entra and Partner Admin or Account Admin in Partner Center, go to App registrations › Loupe › **Branding & properties** › **Add Partner ID to verify publisher**. Enter the ID, then **Verify and save**.
- **Result:** a blue "verified" badge appears on the consent prompt. Requirements in full: [Mark an app as publisher verified](https://learn.microsoft.com/en-us/entra/identity-platform/mark-app-as-publisher-verified).

### 7. Secret

| Secret | Value |
|---|---|
| `LOUPE_MICROSOFT_CLIENT_ID` | the Application (client) ID (used by the Android and iOS builds) |

### 8. Work and school accounts: what their admins may need to do

These aren't Loupe settings: they belong to the user's organisation. The app explains the first case itself.

- **"Your organisation must approve Loupe…"** (AADSTS65001, 90094 and the like): an admin grants consent.
  - Entra admin center › Enterprise applications › Loupe (it appears after one user tried) › Permissions › **Grant admin consent for <organisation>**.
- **Sending fails with `535 5.7.139 … SmtpClientAuthentication is disabled`:** SMTP AUTH is off, the default in many tenants.
  - The admin turns it on for the mailbox: `Set-CASMailbox -Identity <user> -SmtpClientAuthenticationDisabled $false`.
- **IMAP refused after a successful sign-in:** IMAP is off for the mailbox (`Set-CASMailbox -Identity <user> -ImapEnabled $true`), or a Conditional Access policy blocks it.

---

## Test after adding the secrets

1. **Add the secrets** ([Google step 5](#5-secrets) and [Microsoft step 7](#7-secret)). Secrets only reach workflows on this repository, not forks' pull requests.
2. **Build:**
   - Push any commit to `main`, or go to Actions › CI › **Run workflow** on `main`.
   - In the "Build APKs" step the log says `Sign in with Google: on` and `Sign in with Microsoft: on`.
3. **Install:** the "Nightly" pre-release's `loupe-<version>-arm64.apk` (Releases › Nightly). It installs over an older nightly.
4. **Gmail:**
   1. Add Account › your test user's Gmail address › **Sign in with Google**.
   2. Pick the same account in the browser (while "Testing", accept the test-user warning).
   3. Keep the Gmail box ticked, then **Continue**.
   4. Loupe lands on "Account Added", and the Inbox syncs.
   5. Send yourself a message. Settings › the account › Server shows "Sign-in: Google".
5. **Microsoft:**
   1. Add Account › an Outlook.com address › **Sign in with Microsoft**, and accept.
   2. Then a work account, if you have one: expect "Need admin approval" until publisher verification or admin consent.
6. **Revocation:**
   1. Remove Loupe at <https://myaccount.google.com/permissions> (or <https://account.live.com/consent/Manage>).
   2. Pull to refresh in Mailboxes. A "Sign In Again" banner appears, and Loupe stops trying.
   3. Tap **Sign In Again**: the account syncs again.
7. **Background:** close Loupe and wait for a background sync (15 minutes or more). A new mail notifies, which proves the HTTPS refresh works without the app open. An access token lasts about an hour.
8. **Import:** Thunderbird desktop › Tools › Export for Mobile, with a Gmail or Outlook account that uses OAuth in Thunderbird. Loupe's import shows "You'll sign in with Google when it's added".

### Troubleshooting

| Where | Message | Cause and fix |
|---|---|---|
| Google, in the browser | "Error 400: invalid_request … Custom URI scheme is not enabled for your Android client" | Advanced settings › **Enable custom URI scheme** on the Android client ([Google step 3](#3-android-client)). |
| Google | "Error 400: redirect_uri_mismatch" | Package name in the Android client isn't `io.github.buengenio.loupe`, or the build has the **iOS** client's id. |
| Google | "Access blocked: Loupe has not completed the Google verification process" | The account isn't a test user while "Testing" ([Google step 2](#2-google-auth-platform-the-consent-screen)), or the 100-user cap is reached. |
| Google, Workspace account | "Access blocked: your institution's admin needs to review Loupe" | The Workspace admin restricts third-party apps: Admin console › Security › API controls › trust Loupe's client id. |
| Microsoft | AADSTS50011 (redirect URI mismatch) | The iOS / macOS redirect `msauth.io.github.buengenio.loupe://auth` is missing ([Microsoft step 3](#3-redirect-uri)). |
| Microsoft | AADSTS700016 (application not found) | Wrong client id in the secret, or the registration doesn't allow that account type ([Microsoft step 2](#2-app-registration)). |
| Microsoft | AADSTS7000218 (client_assertion or client_secret required) | The redirect was added under "Web". Move it to iOS / macOS. If it persists, set Allow public client flows to Yes. |
| Microsoft | AADSTS65001, 90094 ("Need admin approval") | [Publisher verification](#6-publisher-verification-free), or [admin consent](#8-work-and-school-accounts-what-their-admins-may-need-to-do) in that organisation. |
| Loupe | "… signed you in, but Gmail refused access for this address" | Another account was picked in the browser than the address typed, or IMAP is off (Workspace or M365 admin). |
| Loupe, after a week | "Sign in again" banner on a Gmail account | Expected while the Google app is "Testing" ([Google step 6](#6-testing-then-production)). |

Nothing to change in code for any of these. If one of the providers ever refuses these redirects outright, the constants are `OAuthSignIn.googleRedirectUri` and `OAuthSignIn.microsoftRedirectUri` in `packages/mail_platform/lib/src/oauth.dart`, and the schemes in `build.gradle.kts`, `AndroidManifest.xml` and `Info.plist`.
