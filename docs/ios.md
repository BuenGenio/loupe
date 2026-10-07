# iOS

Everything for iOS that doesn't need an Apple account is in place. Once the account exists, the first TestFlight upload needs only credentials: follow the [checklist](#checklist-from-here-to-testflight).

Nothing here has been built on a Mac yet. The [first run of the iOS workflow](#what-only-a-mac-can-verify) is the first real compile.

## What is set up

| What | Value | Where |
|---|---|---|
| Bundle ID | `io.github.buengenio.loupe` | `Runner.xcodeproj` (`PRODUCT_BUNDLE_IDENTIFIER`) |
| Name on the home screen | Loupe | `Info.plist` (`CFBundleDisplayName`, `CFBundleName`) |
| Minimum iOS | 15.0 | `Runner.xcodeproj` (`IPHONEOS_DEPLOYMENT_TARGET`) |
| Life cycle | UIScene (`SceneDelegate`, implicit engine) | `AppDelegate.swift`, `Info.plist` |
| Plugins | Swift Package Manager | `FlutterGeneratedPluginSwiftPackage` in the project |
| Background | One BGAppRefreshTask, `io.github.buengenio.loupe.sync` | `Info.plist`, `AppDelegate.swift`, `app/lib/platform/work_scheduler.dart` |
| Notifications | flutter_local_notifications, with the Archive, Mark as Read and Reply buttons | `AppDelegate.swift`, `app/lib/platform/local_notifications.dart` |
| Privacy manifest | No tracking and no collected data. Declares file timestamps and user defaults. | `Runner/PrivacyInfo.xcprivacy` |
| Launch screen | The app icon's navy, `#0C2238` | `LaunchScreen.storyboard` |
| App icon | The Loupe logo in every size, without alpha | `Assets.xcassets/AppIcon.appiconset` (from `flutter_launcher_icons`) |

### Minimum iOS and why there is no Podfile

Flutter 3.47 itself needs iOS 15. The most any plugin here asks for is iOS 14 (`workmanager_apple` and `file_picker`, which uses `PHPickerViewController`). So iOS 15.0 it is.

Flutter 3.47 builds plugins with Swift Package Manager by default, and every iOS plugin Loupe uses ships a `Package.swift`. Flutter therefore doesn't use CocoaPods and doesn't generate a Podfile. Adding one would bring `pod install` back for nothing, and Flutter would print that the CocoaPods integration can be removed.

The generated plugin package takes its minimum iOS from the project, so the project setting is the only one.

If Swift Package Manager ever has to be switched off (`flutter config --no-enable-swift-package-manager`):

- Flutter generates `ios/Podfile` from its template. Its `platform :ios` line is commented out: set it to `'15.0'`.
- The iOS workflow's `cocoapods` option does exactly this.

### Info.plist

| Key | Why |
|---|---|
| `CFBundleURLTypes` → `io.github.buengenio.loupe`, `msauth.io.github.buengenio.loupe` | The OAuth redirects for flutter_appauth: Google's `io.github.buengenio.loupe:/oauth2redirect` and Microsoft's `msauth.io.github.buengenio.loupe://auth`. The same as on Android; see [oauth-setup.md](oauth-setup.md). |
| `CFBundleAllowMixedLocalizations` | Loupe is English-only. This key lets system UI (the share sheet, permission alerts) follow the phone's language, as share_plus's README advises. |
| `NSCameraUsageDescription` | Scanning Thunderbird's "Export for Mobile" QR codes. |
| `NSPhotoLibraryAddUsageDescription` | "Save Image" in the share sheet writes to Photos. Without this key iOS ends the app when the user taps it. |
| `NSPhotoLibraryUsageDescription` | `image_picker` comes in through `flutter_zxing` (its scan-from-photo feature, which Loupe doesn't use). App Store Connect flags a binary that links it without the key (ITMS-90683, "Missing purpose string"), and image_picker's README requires it. Loupe never asks for it. |
| `NSMicrophoneUsageDescription` | The `camera` plugin can record video with sound, so its README asks for this key. Loupe opens the camera without audio (`enableAudio: false`) and never asks. |
| `UIBackgroundModes` → `fetch` | Needed for BGAppRefreshTask. There is no `remote-notification` until the push relay (#18) exists, and no `processing`. |
| `BGTaskSchedulerPermittedIdentifiers` | `io.github.buengenio.loupe.sync`, workmanager's periodic task. Every listed identifier must get a launch handler during launch; `AppDelegate.swift` registers it. |

Deliberately left out:

- **`NSFaceIDUsageDescription`:** there is no app lock yet, and nothing uses `local_auth`. Add the key when the biometric lock arrives.
- **`LSApplicationQueriesSchemes`:** Loupe calls `launchUrl`, never `canLaunchUrl`, and only the latter needs it.
- **`ITSAppUsesNonExemptEncryption`:** it depends on a decision; see [Export compliance](#export-compliance-encryption).

### Background refresh

- **Persistent IDLE is impossible on iOS.** Loupe asks for a BGAppRefreshTask instead.
- **Timing:** iOS runs it when it sees fit, never sooner than 15 minutes after the last run. In practice that depends on how often the app is used, the battery and the network. It can be hours apart.
- **Time limit:** each run gets about 30 seconds, engine start-up included, and iOS ends the app if the run isn't done by then. Loupe stops a run after 20 seconds (`iosRefreshBudget`).
  - A run cut short doesn't notify. The next run, which continues the sync, does, because nothing new was marked as seen.
- **No wake-ups at a set time.** iOS has no equivalent of WorkManager's one-off jobs; workmanager's one-off tasks would only run inside a running app. So `AppRefreshScheduler.scheduleWakeUp` does nothing. A scheduled send or a snooze that falls due goes out at the next refresh, or when the app opens.
- **Order matters in `AppDelegate.swift`:** BGTaskScheduler takes launch handlers only until `didFinishLaunching` returns. With the UIScene life cycle, plugins register later than that, during scene connection. So, following the workmanager docs, AppDelegate does all of this up front:
  - registers the periodic task with a 15-minute earliest start;
  - calls `registerLaunchHandlers()`;
  - sets the plugin registrant for the headless engine.
- **Instant Delivery is Android only.** It doesn't appear in iOS Settings; the Notifications page points to Background App Refresh instead.

`flutter_foreground_task` (Instant Delivery) has to stay in `pubspec.yaml` for Android, so its iOS half is linked too. That half registers a BGTaskScheduler handler of its own when it receives the app-launch event.

With UIScene, Flutter sends that event after launch, which BGTaskScheduler doesn't allow. `AppDelegate.swift` therefore makes that call during launch, where iOS declines it: the identifier isn't permitted. The later call then does nothing.

The plugin's iOS service is never started.

### Notifications

- **Same code as Android.** They are posted through flutter_local_notifications (`LocalMailNotifier`).
- **Permission:** asked for alert, sound and badge at the same moment as on Android: right after the first account that notifies is added, or when an account switch is turned on. Never at first launch. The badge (`app_badge_plus`) needs that permission too.
- **Buttons:**
  - iOS defines them per category: `loupe.message` (Archive, Mark as Read, Reply) and `loupe.message.noArchive`.
  - Archive and Mark as Read run in a background engine.
  - Reply opens the app.
- **Grouping:** iOS groups each account's notifications by thread and sums them up itself, so the Android summary notification isn't posted.
- **App delegate:** `AppDelegate.swift` makes the app delegate the `UNUserNotificationCenter` delegate, before launch finishes. It also sets the plugin registrant for the button engine, per the flutter_local_notifications README.

### Keychain and files

- **Keychain:** credentials and the database key use `KeychainAccessibility.first_unlock_this_device`. They can be read in the background once the phone has been unlocked after a restart. They never move to another device, either through iCloud Keychain or through a backup restored elsewhere.
  - A single app needs no access-group entitlement.
  - Keychain items outlive an uninstall on iOS. After a reinstall, the new database reuses the old key, and the old accounts' passwords stay in the Keychain, unused, until they are cleared.
- **S/MIME certificates from device management** (not yet, #26): on Android, Loupe uses certificates from the
  system's KeyChain (`KeyChainChannel.kt`). iOS apps can't use the identities a configuration profile installs for
  Mail. It needs an MDM profile that installs the identity into a keychain access group Loupe shares (the
  `keychain-access-groups` entitlement, which also needs Keychain Sharing on the App ID). Loupe would then find it with
  `SecItemCopyMatching` (`kSecClassIdentity`) and use it with `SecKeyCreateSignature`, `SecKeyCreateDecryptedData` and
  `SecKeyCopyKeyExchangeResult`, behind the same `DeviceCertificates` interface
  (`app/lib/features/smime/device_certificates.dart`, `NoDeviceCertificates` until then).
- **Files:** they keep iOS's default data protection (complete until first user authentication). That is what background refresh needs. PLAN §8 wants complete protection for the attachment cache; that needs native code and isn't done.

### Plugins with iOS caveats

| Plugin | Note |
|---|---|
| camera, flutter_zxing | iOS 13+. zxing-cpp is compiled from source by its Swift package, as a dynamic framework so the release strip keeps its FFI symbols. The Simulator has no camera: the scanner shows its "camera unavailable" state there. Nothing limits the Simulator architectures: zxing-cpp is built from source, and sqlite3mc ships arm64 and x64 Simulator libraries. |
| image_picker (through flutter_zxing) | Not used, but linked: hence the photo library key. |
| pdfx | Renders with Apple's PDF framework; nothing to bundle. |
| open_file | "Open in…" through `UIDocumentInteractionController`. No permissions. |
| share_plus | The share sheet; "Save Image" needs `NSPhotoLibraryAddUsageDescription`. On iPad the sheet is a popover anchored to `sharePositionOrigin`. The attachment viewer passes it; Share in the raw source screen doesn't yet, so there it opens in the middle of the screen. That is a small follow-up. |
| file_picker | Saving uses the document picker, with no permissions. Attaching in Compose uses the Files picker, which doesn't show Photos. Picking photos (`FileType.media`) would be a follow-up. |
| app_badge_plus | Needs the notification permission (badge). If every account is muted, Loupe never asks, and the badge stays off. |
| webview_flutter | WKWebView for the Original view, with JavaScript off. App Transport Security blocks `http:` images there, even when remote content is allowed (Readable mode loads them through Dart and is unaffected). Text size follows the reader setting on Android only. Both need checking on a device (#7). |
| url_launcher | `launchUrl` only; no query schemes needed. |
| flutter_appauth | Uses `ASWebAuthenticationSession`. Google needs an **iOS** OAuth client (see step 4). |
| sqlite3 (SQLite3MultipleCiphers) | A build hook downloads the prebuilt, hash-checked `libsqlite3mc` for iOS (device arm64; Simulator arm64 and x64) while building. |
| workmanager, flutter_local_notifications, flutter_foreground_task | See above. |
| flutter_secure_storage | See [Keychain and files](#keychain-and-files). |

### Export compliance (encryption)

**Short answer:**

- Loupe uses standard encryption that isn't Apple's own. So `ITSAppUsesNonExemptEncryption = NO` (`false`) is only correct if Loupe is **not** offered on the App Store in France.
- The key is not set yet, because that is the owner's choice.
- Until it is set, App Store Connect asks the export questions once per uploaded build ("Missing Compliance" in TestFlight).

**What Loupe encrypts with:**

- TLS for IMAP, SMTP and HTTPS goes through Dart's `SecureSocket`. That is BoringSSL built into the Flutter engine, not Apple's TLS. Security.framework only checks the certificate chain.
- The database is encrypted with SQLite3MultipleCiphers (AES-256 or ChaCha20).
- OpenPGP (RFC 9580) is coming, implemented in Dart.

All are internationally standard algorithms. None is "encryption limited to that within the Apple operating system."

**What Apple says:**

- **[`ITSAppUsesNonExemptEncryption`](https://developer.apple.com/documentation/bundleresources/information-property-list/itsappusesnonexemptencryption):** `NO` means the app "either uses no encryption, or only uses encryption that's exempt from export compliance requirements." Apple's [encryption export page](https://developer.apple.com/documentation/security/complying-with-encryption-export-regulations) defines exempt as exempt from the *documentation* requirements.
- **[Required documentation](https://developer.apple.com/help/app-store-connect/reference/app-information/export-compliance-documentation-for-encryption):**
  - OS-only encryption: "No documentation required."
  - "An industry standard algorithm, not provided within the Apple operating system": "Upload your French encryption declaration." That applies "only… if you're distributing your app on the App Store in France."

**Two ways forward:**

1. **Leave France out of the app's availability.**
   - In App Store Connect, answer "Standard encryption algorithms instead of, or in addition to, using or accessing the encryption within Apple's operating system", then "not available in France".
   - Then add `ITSAppUsesNonExemptEncryption` = `NO` to `Info.plist`, so builds stop asking.
2. **Offer it in France.**
   - File the French encryption declaration with ANSSI and upload it in App Store Connect.
   - Apple then issues a code. Set `ITSAppUsesNonExemptEncryption` = `YES` and `ITSEncryptionExportComplianceCode` to that code.
   - The declaration should cover OpenPGP before that ships.

**United States (EAR), for the record** (eCFR, current to October 2026):

- Loupe is open source with standard cryptography. Publicly available encryption source code is "not subject to the EAR" (§742.15(b)).
- Since the 29 March 2021 rule, the e-mail notification to BIS and NSA is only required for non-standard cryptography.
- Taken conservatively, the App Store binary is a mass-market item (5D992.c), with no licence needed outside embargoed destinations.
- The self-classification report (§740.17(e)(3)) now covers only components and "executable software", not a finished app.
- OpenPGP changes none of this.

This is research, not legal advice; the French choice is a business one.

## Checklist: from here to TestFlight

### 1. Enrol in the Apple Developer Program

- Go to developer.apple.com/programs/enroll. It costs 99 USD a year.
- **As an individual:** the App Store shows your legal name as the seller.
- **As an organisation:** it shows the company name, but needs a D-U-N-S number and takes longer.
- Two-factor authentication on the Apple Account is required.

### 2. Register the App ID

In Certificates, Identifiers & Profiles › Identifiers › **+** › App IDs › App:

- **Description:** Loupe.
- **Bundle ID:** Explicit, `io.github.buengenio.loupe`.
- **Capabilities:**
  - **Push Notifications:** tick it now. Nothing uses it until the push relay (#18), which will also need the `aps-environment` entitlement in the app.
  - **Background App Refresh is not a capability.** It is the `UIBackgroundModes` key, already in `Info.plist`.
  - **Leave the rest off:** no App Groups and no Keychain Sharing.

### 3. Signing

Pick one:

- **Automatic (local builds from Xcode):**
  1. On a Mac, run `flutter build ios --config-only`, then open `app/ios/Runner.xcworkspace`.
  2. Under Runner › Signing & Capabilities, pick the team.
  3. Commit the `DEVELOPMENT_TEAM` this adds to `project.pbxproj`.
  4. Product › Archive, then Distribute App › App Store Connect.
- **Manual (CI, what the TestFlight job expects):**
  1. Create an **Apple Distribution** certificate. In Xcode: Settings › Accounts › Manage Certificates › **+**. Or from a CSR in Certificates › **+**.
  2. Export the certificate with its private key from Keychain Access as a `.p12`, with a password.
  3. Create a **distribution profile** of type **App Store Connect** for `io.github.buengenio.loupe`, and download the `.mobileprovision`.

### 4. App Store Connect

1. **Create the app:** Apps › **+** › New App. Platform iOS, name "Loupe" (it must be free on the store), bundle ID `io.github.buengenio.loupe`, any SKU.
2. **Create an API key:**
   - Go to Users and Access › Integrations › App Store Connect API › Team Keys › **+**, with role **App Manager**.
   - Note the **Key ID** and the **Issuer ID**.
   - Download `AuthKey_<KeyID>.p8`. It can only be downloaded once.
3. **Add the repository secrets** (Settings › Secrets and variables › Actions). Files go in as base64 (`base64 -i file | pbcopy`).

| Secret | Value |
|---|---|
| `APP_STORE_CONNECT_API_KEY_ID` | Key ID |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID |
| `APP_STORE_CONNECT_API_KEY` | the `.p8`, base64 |
| `IOS_DISTRIBUTION_CERTIFICATE` | the `.p12`, base64 |
| `IOS_DISTRIBUTION_CERTIFICATE_PASSWORD` | its password |
| `IOS_PROVISIONING_PROFILE` | the `.mobileprovision`, base64 |
| `APPLE_TEAM_ID` | the 10-character Team ID (Membership details) |
| `LOUPE_GOOGLE_IOS_CLIENT_ID` | optional, see below |
| `LOUPE_MICROSOFT_CLIENT_ID` | optional, the same client ID as on Android |

**Sign-in with Google and Microsoft:** [oauth-setup.md](oauth-setup.md) has the steps.

- **Google** needs its own **iOS** OAuth client, with bundle ID `io.github.buengenio.loupe`.
  - It takes the bundle id as the redirect scheme (`io.github.buengenio.loupe:/oauth2redirect`), like Thunderbird for iOS. No reversed client id is needed.
  - Its id goes into `LOUPE_GOOGLE_IOS_CLIENT_ID`.
- **Microsoft** uses the same registration and client id as Android. Its iOS / macOS redirect `msauth.io.github.buengenio.loupe://auth` serves both.

### 5. Turn on the TestFlight job

1. Uncomment the `testflight` job at the bottom of `.github/workflows/ios.yml`.
2. Run Actions › iOS › Run workflow.
3. The job:
   - imports the certificate and profile into a temporary keychain;
   - signs only the Runner target, through `app/ios/Flutter/Signing.xcconfig` (written in CI);
   - runs `flutter build ipa`;
   - uploads with `xcrun altool` and the API key.

Then, in App Store Connect › TestFlight:

1. Answer the export compliance questions for the build (see [above](#export-compliance-encryption)).
2. Add internal testers: up to 100 App Store Connect users, with no review.
3. External testers (up to 10,000) need test information and a Beta App Review of the first build.

Builds expire after 90 days. Since 28 April 2026, App Store Connect only accepts builds made with Xcode 26 and the iOS 26 SDK or later ([upcoming requirements](https://developer.apple.com/news/upcoming-requirements/)). The workflow prints the runner's `xcodebuild -version`.

### 6. App privacy ("nutrition label")

Answer **Data Not Collected**. Apple's [definitions](https://developer.apple.com/app-store/app-privacy-details/):

- "'Collect' refers to transmitting data off the device in a way that allows you and/or your third-party partners to access it for a period longer than what is necessary to service the transmitted request in real time."
- "Third-party partners" are "analytics tools, advertising networks, third-party SDKs, or other external vendors whose code you've added to your app."
- "Data that is processed only on device is not 'collected'."

Loupe has no servers, no analytics, no advertising, no crash reporting and no third-party SDKs that phone home:

- **Mail:** goes straight between the phone and the mail servers the user chose.
- **Sign-in:** happens in the system browser with Google or Microsoft, as the user's own account.
- **Account discovery:** asks Thunderbird's ISPDB and the mail domain's own autoconfig for server settings. It sends only the domain (and the address to the domain's own server), and nothing is kept for Loupe.

**Revisit the answer** when any of these arrive:

- opt-in crash reporting (PLAN §8);
- the push relay (#18), which would hold a device token and an account identifier;
- any other server the project runs.

The privacy manifest says the same (no tracking, no collected data types). The App Store listing needs a privacy policy URL; PLAN §8 already plans one.

### 7. What iOS users will notice

- **New mail can be late.** iOS decides when the background check runs, often hours apart for an app that is rarely opened, and never while Background App Refresh is off (Settings › Loupe, or Settings › General). Opening Loupe always syncs at once.
- **No Instant Delivery.** iOS doesn't let an app keep a connection open in the background. Real-time notifications need the push relay (#18): a small service that forwards content-free "sync now" pushes through APNs. Until then the setting doesn't appear on iOS.
- **Scheduled sends and snoozes** go out or come back at the next background check or when the app opens, not to the minute as on Android.
- **Badges and notifications** need the permission Loupe asks for once an account notifies.

## What only a Mac can verify

The first run of `.github/workflows/ios.yml` (Actions › iOS › Run workflow, about 15–25 minutes) checks that:

- the Swift packages resolve and every plugin compiles, zxing-cpp included;
- `AppDelegate.swift` compiles against the plugins' Swift APIs: `WorkmanagerPlugin.registerPeriodicTask(withIdentifier:earliestBeginInSeconds:)`, `FlutterLocalNotificationsPlugin.setPluginRegistrantCallback`, and the `SwiftFlutterForegroundTaskPlugin` launch call;
- the sqlite3mc build hook fetches the iOS library and it gets embedded;
- the bundle has the right identifier, iOS 15 minimum, background mode, identifiers and privacy manifest. The workflow prints them.

On a device (the open items of #7):

- **Background refresh:** pause in the debugger and run `e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"io.github.buengenio.loupe.sync"]`, then resume. Check that a sync runs, notifies, and ends within the 30 seconds.
- **Notifications:** Archive and Mark as Read on a notification, both while Loupe is suspended and after it was swiped away. Reply opens Compose.
- **Keychain:** credentials can be read in the background after a restart and the first unlock; check after a reinstall too.
- **Original view (WKWebView):** remote images over `http:`, text size, and the height measurement.
- **Camera:** the QR scan and the permission-denied path; Save Image from the share sheet.
- **Launch:** no crash at start. This also confirms the flutter_foreground_task workaround above.
