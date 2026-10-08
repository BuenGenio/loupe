# Push

Push lets something outside the phone wake Loupe the moment mail arrives: a content-free "check now" through Firebase Cloud Messaging (FCM). Loupe then syncs straight from the mail server, exactly as the 15-minute background sync does. A push never carries mail, and nothing in it is read.

Android only for now; iOS needs an APNs key first ([below](#ios)).

## In the app

- **Settings › Notifications › Push**, on by default. It only takes effect in live mode: a phone that only tries the demo never contacts Firebase (auto-init is off in `AndroidManifest.xml` until Loupe turns it on).
- **Copy Push Token** (live mode) copies the address pushes reach this phone at. Turning Push off deletes the token.
- **App in the background or closed:** `onBackgroundPush` (`app/lib/platform/push.dart`) asks WorkManager for a sync right away. The job does the rest, as every background sync does: the leases with the app and Instant Delivery, notifications, the badge, due sends. The handler itself gets only seconds.
- **App in the foreground:** the coordinator syncs, as pull to refresh does.
- **No Google Play services** (or no network): no token. Settings says so, and the 15-minute sync and Instant Delivery work as before.

## What sends pushes

Nothing yet: that is the push relay ([#18](https://github.com/BuenGenio/loupe/issues/18)). It should send **data-only** messages (no `notification` block) with Android priority `high`:

```json
{"message": {"token": "<token>", "data": {"loupe": "sync"}, "android": {"priority": "high"}}}
```

Loupe ignores the data; any data message wakes it.

## The Firebase project

- Project `loupe-18212` (Spark plan: FCM is free). Android app `io.github.buengenio.loupe`.
- `app/android/app/google-services.json` is committed. It holds the project's client settings, which ship inside every APK anyway, not secrets. To harden it, restrict its API key to the Android app in Google Cloud › APIs & Services › Credentials.
- **No Analytics, no Crashlytics.** `app/android/app/build.gradle.kts` also leaves out `firebase-measurement-connector`, an interface FCM brings along that does nothing without Analytics but makes tracker scanners such as Exodus report "Google Firebase Analytics".
  - So **never send Firebase console notification campaigns** to Loupe: they ask FCM to log to Analytics, which crashes without the connector. Send data messages ([below](#sending-a-test-push)).
- Sending needs a service account. Create its key only for the relay's deployment, and keep it out of the repository and the app.

## Sending a test push

1. Add an account, then copy the token: Settings › Notifications › **Copy Push Token**.
2. Open [projects.messages.send](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages/send) and use its **Try this method** panel, signed in with the Google account that owns the Firebase project:
   - `parent`: `projects/loupe-18212`
   - Request body: the JSON [above](#what-sends-pushes), with the token.
3. Send yourself a mail, put Loupe in the background, and send the push: Loupe syncs within seconds and notifies.

## iOS

To do when the Apple account exists ([ios.md](ios.md)):

1. Firebase: add the Apple app (bundle ID `io.github.buengenio.loupe`) and put its `GoogleService-Info.plist` in `app/ios/Runner/`.
2. Apple Developer › Keys: an APNs key. Upload it in Firebase › Project settings › Cloud Messaging, with its Key ID and the Team ID.
3. Xcode: the Push Notifications capability (`aps-environment`) and the `remote-notification` background mode.
4. `main.dart`: start `FirebasePushService` on iOS too, and offer Push in Settings there.
