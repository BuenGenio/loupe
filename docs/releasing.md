# Releasing

How Loupe is versioned, built in two release types, released, and published on F-Droid.

## Release types

|  | **Free** | **NonFree** |
|---|---|---|
| What it is | The committed tree, unchanged | Free, plus `nonfree/` |
| Google code | None | Firebase Cloud Messaging (not free software; needs Google Play services) |
| Push ([push.md](push.md)) | None: Settings doesn't offer it | Yes |
| Where it goes | F-Droid; GitHub releases (`loupe-free-…`) | The Nightly; Google Play; GitHub releases (`loupe-nonfree-…`) |
| Who else gets it | `flutter run`, tests, iOS builds, forks | |

Both have the same application id, signing key and version codes, so either installs over the other, and over the Nightly.

### How the switch works

- `packages/push` and `nonfree/push` are two packages with the same name, `loupe_push`, and the same API (`PushService`, `startPush`). The app depends on `packages/push`, which has no push.
- `tool/release_type.sh nonfree` writes a `pubspec_overrides.yaml` (git-ignored) that replaces it with `nonfree/push`, and resolves. `nonfree/push` brings Firebase, and an Android module with Firebase's settings and manifest entry, so nothing in `app/android` names Google.
- `tool/release_type.sh free` removes the file again. A NonFree checkout changes `pubspec.lock`: switch back before committing. `tool/ci/check_free.sh` fails CI if a NonFree lockfile, a Google Gradle plugin or a downloaded SQLite gets in.
- Anything else non-free goes into `nonfree/` the same way: an API in a Free package, its non-free implementation beside it, swapped by the override. Never into `app/` or `packages/`.

## Versions

`app/pubspec.yaml` has `version: <name>+<build number>`, for example `0.2.0+500`.

- Releases are tagged `v<name>`.
- Android's version code is ten times the build number, plus 1 (armeabi-v7a), 2 (arm64-v8a) or 4 (x86_64) for the per-ABI APKs; 0 for app bundles (Google Play). So 0.2.0's APKs are 5001, 5002 and 5004.
  - The ABI goes in the last digit because F-Droid asks for it: every APK of a version then outranks every APK of the one before, which F-Droid relies on to keep the newest ones.
  - `app/android/app/build.gradle.kts` numbers them, in place of Flutter's own 1000/2000/4000 + build number (turned off in `gradle.properties`).
- Each new version name gets the next build number (`tool/release_prepare.sh` does it).
- Nightlies are `<name>-nightly.<run>` with the release's version code: a Nightly installs over the release it follows, and the next release over it.
- History: Nightlies until November 2026 were `0.1.<run>` with Flutter's numbering, up to 2099 (arm64) and 4099 (x86_64). Releases start at build 500 (5002 and 5004), so they install over them.

## Cutting a release

1. Write the release notes: plain text, 500 characters at most. F-Droid shows them as "What's new", and the GitHub release opens with them.
2. `tool/release_prepare.sh 0.3.0 notes.txt` sets the version and writes the notes to `fastlane/metadata/android/en-US/changelogs/<version code>.txt`, one per APK.
3. Commit, open a pull request, merge.
4. Tag the merge commit and push the tag: `git tag v0.3.0 && git push origin v0.3.0`.
5. The **Release** workflow (`.github/workflows/release.yml`) checks the tag against the pubspec and builds both types from that commit, signed with the release key. It publishes the GitHub release with all six APKs and `SHA256SUMS`, and sends the NonFree app bundle to Google Play's internal testing once that's set up ([play-store.md](play-store.md)).
6. F-Droid notices the tag by itself, once Loupe is in F-Droid (below).

## The Flutter version

CI builds with `FLUTTER_VERSION` in `.github/workflows/ci.yml`. Releases and F-Droid build with the `.flutter` submodule, which F-Droid asks Flutter apps for. `tool/ci/check_free.sh` checks that the two are the same version. To move both to a new version:

```sh
v=3.47.7
sed -i "s/FLUTTER_VERSION: \".*\"/FLUTTER_VERSION: \"$v\"/" .github/workflows/ci.yml
git update-index --cacheinfo 160000,$(git ls-remote https://github.com/flutter/flutter refs/tags/$v | cut -f1),.flutter
```

You don't need the submodule to work on Loupe (any Flutter of that version will do), and `git clone` doesn't fetch it. `git submodule update --init .flutter` does, if you want it.

## F-Droid

### What the repository gives F-Droid

- **Source only.** No Google libraries in the Free type, and SQLite3 Multiple Ciphers compiled from `third_party/sqlite3mc` rather than downloaded ([third_party/sqlite3mc/README.md](../third_party/sqlite3mc/README.md)).
- **Store listing:** `fastlane/metadata/android/<locale>/`, the same texts as Google Play (`marketing/creative/play.mjs`). en-US's images are committed, since F-Droid can't generate them: icon, feature graphic, phone and tablet screenshots. Re-run `play.mjs` and commit them when the screenshots change.
- **What's new:** `fastlane/metadata/android/en-US/changelogs/<version code>.txt`.
- **No dependency list in APKs:** the Android Gradle plugin's blob, encrypted for Google Play, is left out (`dependenciesInfo` in `app/android/app/build.gradle.kts`).
- **The same app as ours:** the OAuth client ids are in the source ([oauth-setup.md](oauth-setup.md)), and release builds without a key are unsigned, as F-Droid wants them.

### The build recipe

[`docs/fdroid/io.github.buengenio.loupe.yml`](fdroid/io.github.buengenio.loupe.yml) is the draft of Loupe's file in [fdroiddata](https://gitlab.com/fdroid/fdroiddata). It follows F-Droid's Flutter template:

- It builds the Free type from the tag, one build per ABI, with Flutter from `.flutter` and the pub cache inside the checkout.
- It removes `nonfree/`, `site/`, `marketing/` and `app/ios` first.
- **Reproducible builds:** it builds at `/home/runner/work/loupe/loupe`, where the Release workflow builds, with JDK 17 as the workflow does. The Release workflow also puts the Android SDK where F-Droid's container has it, `/opt/android-sdk`, with only the app's NDK (`tool/ci/android_sdk.sh`; `ndkVersion` in `app/android/app/build.gradle.kts` and the recipe's `ndk:` must agree). Without that, 0.2.0 wasn't reproducible. On GitHub's runners, Flutter's build hooks compiled SQLite with the runner's default NDK (r27) rather than the app's. And the SDK's path ended up in package:jni's `libdartjni.so` (its build ID). With `binary:` and `AllowedAPKSigningKeys` (our release certificate's SHA-256), F-Droid compares its APK with ours. When they are identical, it ships ours, with our signature. So F-Droid, GitHub and the Nightly install over one another, and Sign in with Google (bound to our certificate) works in F-Droid's copy.
- Checking for updates: `UpdateCheckMode: Tags`, with `VercodeOperation` `10 * %c + 1`, `+ 2` and `+ 4` on the build number from `app/pubspec.yaml`, so new tags are picked up without a merge request.

If F-Droid's build ever isn't identical to ours, it won't publish that version. The fix is to find the difference (`diffoscope` on the two APKs) and remove it. The fallback is to drop `binary:` and `AllowedAPKSigningKeys`, so that F-Droid signs with its own key. F-Droid's copy then can't update ours or be updated by it, and Google sign-in fails in it.

### Submitting

**Where it stands.** Loupe was submitted on 12 November 2026 with 0.2.1, the first reproducible release: [fdroiddata!57027](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/57027). Every job in its pipeline passed, F-Droid's build server included, and its APKs were identical to ours. A reviewer closed it the same day, for two reasons:

- **Under three months old.** The inclusion policy's Quality point 6 asks for "at least 3 months" of active development. The exceptions are proven users, an author who already maintains other F-Droid apps, or an app made only for an event. Loupe's first commit was on 4 October 2026, so it can go back **from 4 January 2027**.
- **The template wasn't filled in.** GitLab put the blank **Default** template into the merge request, all boxes unticked. The text has to be the template's own, every line kept, each box ticked, with notes added beneath.

To go back: update the recipe to the newest release (only the latest versions; `commit:` the full hash, never the tag) and lint it. Then push it to the same branch, paste [`fdroid/merge-request.md`](fdroid/merge-request.md) (the template, filled in) as the description, and reopen !57027 with a line saying the three months have passed. The pipeline's Reports tab lists the APK's permissions, and the description explains them: check it against a new permission there.

How the submission works:

1. The **F-Droid check** workflow (`.github/workflows/fdroid-check.yml`) runs after each Release, and by hand for a tag. It builds every APK in F-Droid's own build container from the recipe, as F-Droid's servers do (`fdroid build --on-server`: the scanner, the build, and the comparison with the APK on the GitHub release). Green means F-Droid will ship our APKs: its log says `compared built binary to supplied reference binary successfully` for each. Its artifacts keep F-Droid's APK and logs for `diffoscope` when not. It needs an x86-64 machine, so it doesn't run on the Asahi laptop.
2. Fork fdroiddata on GitLab, add the recipe as `metadata/io.github.buengenio.loupe.yml` (on a branch named `io.github.buengenio.loupe`), commit as `New App: io.github.buengenio.loupe`, and open a merge request with fdroiddata's **Default** template, filled in. Its pipeline builds the app again; reviewers may ask for changes. Its `fdroid rewritemeta` job formats with Debian's `ruamel.yaml`, which wraps long lines differently from newer ones (the `binary:` URLs). When it fails, its `tmp/` artifact has the file as it wants it.
3. No anti-features are expected for the Free type. When Private AI's cloud providers (Anthropic, OpenAI-compatible) ship, F-Droid will likely add **NonFreeNet**: it connects to non-free network services, even though only when the user sets one up.
