# Loupe on the home screen's minus-one page (Android)

The "minus one" page is the screen to the left of the home screen — Discover on a Pixel, Samsung
Free on One UI. Loupe can fill it: `MinusOneOverlayService` serves the launcher a sliding panel of
its own.

This is a **sample panel** for now. It shows three fixed cards, not your mail; see
[Putting real mail in it](#putting-real-mail-in-it).

## How it works

There is no public Android API for this page, and there never has been. A launcher that offers one
binds a service in another app and drives it over `ILauncherOverlay`, Google's private AIDL
interface between a Launcher3 derivative and the Google app:

1. The launcher looks for a service answering `com.android.launcher3.WINDOW_OVERLAY` in the package
   the user chose, with an `app://<launcher package>:<uid>?v=7&cv=9` URI.
2. It binds and calls `windowAttached2`, handing over **its own window token**.
3. The provider adds a sub-window to that token — no overlay permission needed, because the window
   belongs to the launcher's — and answers `overlayStatusChanged(1)`. That is what makes the
   launcher show a page to the left at all.
4. As the user drags, the launcher calls `onScroll(progress)`, 0 closed to 1 open. On release it
   calls `endScroll` and the panel settles itself, reporting each frame back through
   `overlayScrollChanged` so the launcher's workspace keeps following it.

In the repo:

| Path | What |
|---|---|
| `app/android/app/src/main/aidl/com/google/android/libraries/launcherclient/` | The two AIDL files, reproduced from Lawnchair unchanged — method order fixes the Binder transaction codes |
| `app/android/app/src/main/kotlin/io/github/buengenio/loupe/minusone/MinusOneOverlayService.kt` | The service: the window on the launcher's token, the slide, the settle |
| `app/android/app/src/main/kotlin/io/github/buengenio/loupe/minusone/MinusOnePanelView.kt` | The panel's content |

`buildFeatures { aidl = true }` in `app/android/app/build.gradle.kts` is what makes AGP generate the
stubs; without it the service won't compile.

## Which launchers can show it

Only launchers that let the user choose the provider:

- **Lawnchair** — Home screen › Feed provider.
- **Neo Launcher**, **Omega**, other Launcher3 forks with the same setting.

The **Pixel Launcher and the One UI launcher cannot**. They pin the provider to
`com.google.android.googlequicksearchbox`, so no third-party app can take that page, however it is
written. On a Galaxy you need one of the launchers above as your home app to see this at all.

## Trying it on a device

1. Install Loupe and Lawnchair, and make Lawnchair the home app.
2. In Lawnchair, turn on **Ignore feed whitelist** (under the debug settings). Lawnchair otherwise
   only accepts providers whose signature hash is in `FeedBridge.initializeWhitelist`, which is a
   fixed list of seven packages that Loupe is not on.
3. Home screen › **Feed provider** › Loupe, then restart Lawnchair.
4. Swipe right from the first home screen.

If the page doesn't appear:

```sh
adb logcat -s LoupeMinusOne FeedBridge
```

`FeedBridge` logs `Feed provider io.github.buengenio.loupe(0x…) isn't whitelisted` when step 2 was
missed. `LoupeMinusOne` logs `The launcher's window would not take the panel` when the platform
refused the sub-window, and `Ignoring an overlay call from uid …` when the caller is not the current
home app — the service answers only the launcher the user actually chose, since any app may bind to
it.

## Putting real mail in it

The panel runs in Loupe's process but outside the Flutter engine, so it can reach neither the app's
widgets nor its encrypted drift database. Real mail means handing it a small snapshot:

- The Dart side writes sender, subject, time and the unread count where this service can read them
  (the sync engine's new-mail path is the moment to do it).
- `MinusOnePanelView.setCards` takes the list; nothing else in the panel changes.

Keep it to what a notification would show. The minus-one page sits one swipe from an unlocked home
screen, so no message bodies.

## Known limits

- Right-to-left layouts slide the panel the wrong way; the drag direction is not mirrored yet.
- Tapping a card starts `MainActivity` from a service context. Android's background-activity-start
  rules allow it while the panel is the window the user is touching, but this has not been tested
  across OEM builds.
- The panel is dark whatever the launcher's theme is.
