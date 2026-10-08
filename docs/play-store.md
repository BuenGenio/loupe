# Publishing Loupe on Google Play

What is ready in the repository, and the steps in Play Console that only the owner can do.

## Ready

- **App bundle.** Every push to `main` builds `loupe-0.1.<run>.aab`, signed with the release keystore (the upload key), as the CI artifact `loupe-aab-<run>` (kept 30 days). Version codes are the CI run number, so they always increase.
- **Automatic uploads.** Once the `PLAY_SERVICE_ACCOUNT_JSON` secret exists, CI uploads each bundle to the **internal testing** track (`.github/workflows/ci.yml`, step "Upload to Google Play").
- **Store listing in 32 languages** (every website language Play supports; Bosnian, Irish, Luxembourgish, Maltese and Welsh have no Play listing language): `app/android/fastlane/metadata/android/<locale>/` holds `title.txt` (30 characters at most), `short_description.txt` (80) and `full_description.txt` (4,000), generated from the website's translations by `marketing/creative/play.mjs`. Edit the website strings and re-run it, or edit the files.
- **Store graphics**, regenerated from the app screenshots when the listing is pushed: a feature graphic (1024 × 500) per language, eight phone screenshots (1080 × 1920) with captions in each language, two tablet screenshots and the 512 px icon (default language only; Play shows those wherever a language has none).
- **Pushing the listing:** the manual workflow **Play listing** (`.github/workflows/play-listing.yml`) runs fastlane supply. Run it with "validate only" first.
- **Privacy policy:** <https://loupe.mx/privacy/>.

## Steps in Play Console

1. **Developer account.** A personal account costs $25 and needs identity verification. Personal accounts created after November 2023 must run a **closed test with at least 12 testers, opted in for 14 days in a row**, before production or open testing unlock. Organisation accounts (they need a D-U-N-S number) are exempt.
2. **Create the app:** name *Loupe*, default language English (United States), App, Free.
3. **App signing:** keep **Play App Signing** (Google holds the app signing key; the release keystore in the CI secrets becomes the upload key).
4. **First release by hand.** A new app's first bundle has to be uploaded in the console: download `loupe-aab-<run>` from the latest `main` CI run and create an **Internal testing** release with it. Add yourself as a tester.
5. **Automation.** In Google Cloud, create a service account and a JSON key. In Play Console › Users and permissions, invite the service account's address with *Release apps to testing tracks* and *Manage store presence* for Loupe. Add the JSON as the repository secret `PLAY_SERVICE_ACCOUNT_JSON`. From then on every push to `main` lands in internal testing. New apps only accept **draft** releases until the first release is published; after that, set the repository variable `PLAY_RELEASE_STATUS` to `completed`.
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
   - For **Sign in with Google** (#2), add the **app signing** certificate's SHA-1 (Play Console › Test and release › App integrity) to the Android OAuth client, next to the upload key's.
