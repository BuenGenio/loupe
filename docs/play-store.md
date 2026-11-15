# Publishing Loupe on Google Play

What is ready in the repository, and the steps in Play Console that only the owner can do.

## Ready

- **App bundle.** Every release (a tag `v<version>`, [releasing.md](releasing.md)) builds `loupe-nonfree-<version>.aab`, the NonFree release type (with Push), signed with the release key (also Play's upload key, step 3), in the Release workflow's artifact `loupe-<version>` (kept 90 days). Its version code is ten times `app/pubspec.yaml`'s build number, which each release raises (the APKs add 1, 2 or 4 for their ABI).
- **Automatic uploads.** Once the `PLAY_SERVICE_ACCOUNT_JSON` secret exists, each release's bundle goes to the **internal testing** track (`.github/workflows/release.yml`, step "Upload to Google Play"). Nightlies don't: their version codes repeat the release's.
- **Store listing in 32 languages** (every website language Play supports; Bosnian, Irish, Luxembourgish, Maltese and Welsh have no Play listing language): `fastlane/metadata/android/<locale>/` holds `title.txt` (30 characters at most), `short_description.txt` (80) and `full_description.txt` (4,000), generated from the website's translations by `marketing/creative/play.mjs`. Edit the website strings and re-run it, or edit the files.
- **Store graphics**, regenerated from the app screenshots when the listing is pushed: a feature graphic (1024 × 500) per language, eight phone screenshots (1080 × 1920) with captions in each language, two tablet screenshots and the 512 px icon (default language only; Play shows those wherever a language has none).
- **Pushing the listing:** the manual workflow **Play listing** (`.github/workflows/play-listing.yml`) runs fastlane supply. Run it with "validate only" first.
- **Privacy policy:** <https://loupe.mx/privacy/>.

## Steps in Play Console

1. **Developer account.** A personal account costs $25 and needs identity verification. Personal accounts created after November 2023 must run a **closed test with at least 12 testers, opted in for 14 days in a row**, before production or open testing unlock. Organisation accounts (they need a D-U-N-S number) are exempt.
2. **Create the app:** name *Loupe*, default language English (United States), App, Free.
3. **App signing: with our own key, before the first upload.** Play signs the copies it installs. By default it uses a key Google generates. Then Play's copy and the GitHub and F-Droid copies would have different signatures (F-Droid ships ours, [releasing.md](releasing.md#the-build-recipe)). Moving between them would mean uninstalling Loupe, losing its local mailbox and adding every account again. So give Play a copy of the release key instead:
   - **Choose our key.** In Play Console › Protected with Play › Play Store protection › **Manage Play app signing**, choose **Change key** › **Provide a copy of your app signing key**.
   - **Upload it with PEPK.** Play Console shows the PEPK tool, an encryption key and the command to run. Run it on a computer with the release keystore and its passwords, the ones in the `LOUPE_KEYSTORE_*` secrets. Use your own copy of the keystore: GitHub secrets can't be read back.
   - **Do it before anything reaches open testing or production.** After that it can't be changed. Doing it before the first upload is simplest.
   - **Check the result.** The page should list our certificate, SHA-256 `fe1a03a79bbe05775a0bbeee7d995c9107d5db143121e2ac3ab8275f164e5bd1`, the same as `AllowedAPKSigningKeys` in the F-Droid recipe. New apps start on Google's "hybrid" signing: an RSA key plus a post-quantum one. If the page still lists a key of Google's beside ours, Play copies on newer Android versions may carry a second signature. Run the check in step 4 on the newest Android you have before going further.
   - **The upload key is the release key itself.** The Release workflow already signs the bundle with it. Google recommends a separate upload key, which protects a signing key kept offline. Loupe's release key has to be in CI anyway, to sign the APKs.
   - **The trade-off:** Google then holds a copy of the key that the GitHub and F-Droid copies are signed with. In principle it could sign an update that installs over them.
4. **First release by hand.** A new app's first bundle has to be uploaded in the console: download `loupe-<version>` from the latest Release workflow run and create an **Internal testing** release with it. Add yourself as a tester. Then check step 3 on a phone:
   - Install the previous version's GitHub APK and add an account.
   - Install the internal-testing release from Play. It should update Loupe in place, account and mail intact. The new bundle counts as newer: 0.2.2's bundle, for example, is 5030, and 0.2.1's APKs are 5021–5024.
5. **Automation.** In Google Cloud, create a service account and a JSON key. In Play Console › Users and permissions, invite the service account's address with *Release apps to testing tracks* and *Manage store presence* for Loupe. Add the JSON as the repository secret `PLAY_SERVICE_ACCOUNT_JSON`. From then on every release lands in internal testing. New apps only accept **draft** releases until the first release is published; after that, set the repository variable `PLAY_RELEASE_STATUS` to `completed`.
6. **Store listing:** run the **Play listing** workflow (validate only, then for real), or paste the texts. Category *Communication*; contact e-mail `hello@loupe.mx`; website `https://loupe.mx`; privacy policy `https://loupe.mx/privacy/`.
7. **App content** (Policy › App content):
   - **Ads:** no ads.
   - **App access:** a mail account is needed for real use. For review, use demo mode: *On first launch, choose "Try with demo mail". No account or login is needed; every screen works with demo data.*
   - **Target audience:** 18 and over (not designed for children).
   - **Content rating:** answer the questionnaire; Loupe lets users exchange messages with others (e-mail), and has no other content of its own.
   - **News, health, financial features, government:** no.
   - **Data safety:** Loupe has no servers and no analytics or crash-reporting SDKs. Mail and credentials go only between the phone and the mail provider the user signs in to, at the user's request; nothing reaches the developer. If review disagrees, also declare *Emails* and *Email address*, collected for *App functionality*, not shared, encrypted in transit, deletable.
     - **Push** ([push.md](push.md)) is the one thing to declare: Firebase Cloud Messaging sends Google, as Loupe's service provider, a Firebase installation ID and a push token ([Firebase's disclosure guide](https://firebase.google.com/docs/android/play-data-disclosure)). Declare *Device or other IDs*: collected, not shared, for *App functionality*, encrypted in transit, optional (Settings › Notifications › Push turns it off).
   - **Foreground service declaration:** Instant Delivery (experimental, off by default) uses a foreground service of type `specialUse` (`PROPERTY_SPECIAL_USE_FGS_SUBTYPE` in the manifest). Play asks for a description and a short screen recording: *keeps an IMAP IDLE connection to the user's inbox so new mail notifies within seconds; started only when the user turns on Instant Delivery; a persistent notification says "Watching for new mail".*
   - The camera (QR import) and notifications are ordinary runtime permissions; App Lock's biometric prompt needs no declaration.
8. **Testing tracks:** internal testing (up to 100 people, no review) → closed testing (the 12-tester, 14-day rule for personal accounts) → open testing or production.
9. **After it's listed:**
   - Put the Play URL in `site/src/config.ts` → `stores.googlePlay`: the website's badge turns from "Coming soon" into a link.
   - **Sign in with Google** (#2) needs no change: Play's app signing certificate is the release certificate, whose SHA-1 the Android OAuth client already has. Only if Play Console › Test and release › App integrity lists other keys (step 3), add their SHA-1s to the client too.
