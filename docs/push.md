# Push

Push lets something outside the phone wake Loupe the moment mail arrives: a content-free "check now" through Firebase Cloud Messaging (FCM). Loupe then syncs straight from the mail server, exactly as the 15-minute background sync does. A push never carries mail, and nothing in it is read.

Only in the **NonFree** release type ([releasing.md](releasing.md)), since Firebase isn't free software; Free builds, F-Droid's among them, have no Push and Settings doesn't show it. Android only for now; iOS needs an APNs key first ([below](#ios)).

## In the code

- `packages/push` (package `loupe_push`): the API, `PushService` and `startPush`, with no push. The app is written against it, and Free builds use it.
- `nonfree/push` (also `loupe_push`): the same API through FCM, plus an Android module with nothing but Firebase's settings (`res/values/firebase.xml`) and its manifest entry. `tool/release_type.sh nonfree` swaps it in.
- `app/lib/platform/push.dart`: the providers and `onBackgroundPush`; `main.dart` starts whichever push the build has.

## In the app

- **Settings › Notifications › Push** (NonFree builds), on by default. It only takes effect in live mode: a phone that only tries the demo never contacts Firebase (auto-init is off in `nonfree/push/android/src/main/AndroidManifest.xml` until Loupe turns it on).
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
- Its client settings are in `nonfree/push/android/src/main/res/values/firebase.xml`: the values the google-services Gradle plugin used to generate from `google-services.json`, written out so that no Google Gradle plugin is needed. They ship inside every NonFree APK anyway, not secrets. To harden them, restrict the API key to the Android app in Google Cloud › APIs & Services › Credentials. If the Firebase project changes, copy the new values from its `google-services.json` (`mobilesdk_app_id`, `project_number`, `current_key`, `project_id`, `storage_bucket`).
- **No Analytics, no Crashlytics.** FCM still brings `firebase-measurement-connector`, an interface that does nothing without the Analytics SDK. It can't be left out: FCM asks for it when it starts (`FirebaseMessaging.shouldRetainProxyNotifications`). Tracker scanners such as Exodus would report its package name (`com.google.firebase.analytics.connector`) as "Google Firebase Analytics", but R8 renames it in release builds: build 84's APK has no `com/google/firebase/analytics` class, no Play services measurement and no `AD_ID`. Check again after Firebase updates.
- Test with data messages ([below](#sending-a-test-push)), not Firebase console notification campaigns: those show their own notification, and Loupe never sends that kind.
- Sending needs a service account. Create its key only for the relay's deployment, and keep it out of the repository and the app.

## Sending a test push

1. Add an account, then copy the token: Settings › Notifications › **Copy Push Token**.
2. Open [projects.messages.send](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages/send) and use its **Try this method** panel, signed in with the Google account that owns the Firebase project:
   - `parent`: `projects/loupe-18212`
   - Request body: the JSON [above](#what-sends-pushes), with the token.
3. Send yourself a mail, put Loupe in the background, and send the push: Loupe syncs within seconds and notifies.

## iOS

To do when the Apple account exists ([ios.md](ios.md)):

1. Firebase: add the Apple app (bundle ID `io.github.buengenio.loupe`) and give `nonfree/push` its settings (an `ios/` part of the plugin, or `FirebaseOptions` in `startPush`).
2. Apple Developer › Keys: an APNs key. Upload it in Firebase › Project settings › Cloud Messaging, with its Key ID and the Team ID.
3. Xcode: the Push Notifications capability (`aps-environment`) and the `remote-notification` background mode.
4. `nonfree/push`'s `startPush`: start on iOS too; `main.dart`: offer Push in Settings there. iOS builds would then be NonFree builds (`tool/release_type.sh nonfree` before `flutter build ios`).
