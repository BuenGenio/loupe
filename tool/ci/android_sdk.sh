#!/usr/bin/env bash
# Sets up the Android SDK as F-Droid's build container has it, so that F-Droid's
# build of a release is identical to ours (docs/releasing.md):
#
# - In /opt/android-sdk. Paths into the SDK end up in native libraries (the
#   build ID of package:jni's libdartjni.so), so both builds need the same ones.
# - With one NDK, the app's (ndkVersion in app/android/app/build.gradle.kts).
#   Flutter's build hooks (package:sqlite3's) take ANDROID_NDK_HOME before the
#   app's NDK, and on GitHub's runners it names another one.
#
# For GitHub Actions: copies the runner's SDK licences, installs into
# /opt/android-sdk, and writes the variables to $GITHUB_ENV. Gradle installs
# the rest (platforms, CMake) there as it needs them, as in F-Droid's build.
# The command-line tools are for `flutter build appbundle`, which checks the
# bundle's native libraries are stripped with their apkanalyzer, and fails
# without it. They don't take part in the build, so the APKs stay F-Droid's.
set -euo pipefail
cd "$(dirname "$0")/../.."
sdk=/opt/android-sdk
ndk=$(sed -n 's/^ *ndkVersion = "\(.*\)"$/\1/p' app/android/app/build.gradle.kts)
[ -n "$ndk" ] || { echo "::error::No ndkVersion = \"…\" in app/android/app/build.gradle.kts"; exit 1; }

sudo mkdir -p "$sdk"
sudo chown "$(id -u):$(id -g)" "$sdk"
cp -r "${ANDROID_HOME:?}/licenses" "$sdk/"
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$sdk" \
  "cmdline-tools;latest" "platform-tools" "platforms;android-36" "build-tools;36.0.0" "ndk;$ndk" > /dev/null
[ -x "$sdk/cmdline-tools/latest/bin/apkanalyzer" ] || { echo "::error::No apkanalyzer in $sdk/cmdline-tools/latest"; exit 1; }

{
  echo "ANDROID_HOME=$sdk"
  echo "ANDROID_SDK_ROOT=$sdk"
  for name in ANDROID_NDK_HOME ANDROID_NDK_ROOT ANDROID_NDK ANDROID_NDK_LATEST_HOME; do
    echo "$name=$sdk/ndk/$ndk"
  done
} >> "${GITHUB_ENV:?}"
echo "Android SDK in $sdk, NDK $ndk"
