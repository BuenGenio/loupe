import com.android.build.api.variant.FilterConfiguration
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing: android/key.properties locally, or LOUPE_KEYSTORE_* environment
// variables in CI. Without either, release builds are unsigned, as F-Droid builds
// them (docs/releasing.md): `flutter run --release` then needs a key.
val keyProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}
fun signingValue(name: String, env: String): String? = keyProperties.getProperty(name) ?: System.getenv(env)

android {
    namespace = "io.github.buengenio.loupe"
    compileSdk = flutter.compileSdkVersion
    // Flutter 3.47's default, written out: releases and F-Droid's build must use the same NDK
    // (docs/releasing.md). tool/ci/android_sdk.sh reads it; F-Droid's recipe has it as `ndk:`.
    ndkVersion = "28.2.13676358"

    compileOptions {
        // flutter_local_notifications needs core library desugaring (java.time on older Android).
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "io.github.buengenio.loupe"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Ten times pubspec.yaml's build number; per-ABI APKs add their digit (androidComponents below).
        versionCode = flutter.versionCode * 10
        versionName = flutter.versionName
        // As flutter_local_notifications' setup asks, with desugaring.
        multiDexEnabled = true
        // flutter_appauth (mail_platform): Google's OAuth redirect io.github.buengenio.loupe:/oauth2redirect.
        // Google's Android client takes the package name as scheme once "Custom URI scheme" is on
        // (docs/oauth-setup.md). Microsoft's redirect has its own intent filter in AndroidManifest.xml.
        manifestPlaceholders["appAuthRedirectScheme"] = "io.github.buengenio.loupe"
    }

    signingConfigs {
        val storeFilePath = signingValue("storeFile", "LOUPE_KEYSTORE_FILE")
        if (storeFilePath != null) {
            create("release") {
                storeFile = file(storeFilePath)
                storePassword = signingValue("storePassword", "LOUPE_KEYSTORE_PASSWORD")
                keyAlias = signingValue("keyAlias", "LOUPE_KEY_ALIAS")
                keyPassword = signingValue("keyPassword", "LOUPE_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
        }
    }

    // No dependency list in APKs: AGP adds one encrypted with Google's public key, for Google Play only,
    // which nobody else can read and F-Droid's scanner reports. App bundles (Play) keep it.
    dependenciesInfo {
        includeInApk = false
    }
}

// Version codes (docs/releasing.md): ten times pubspec.yaml's build number, and the ABI in the last digit
// for per-ABI APKs (`--split-per-abi`), as F-Droid asks: then every APK of a version outranks every APK of
// the one before. Replaces Flutter's 1000/2000/4000 + build number, which force-version-code-ignoring-abi in
// gradle.properties turns off. App bundles and universal APKs end in 0.
val abiDigits = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86_64" to 4)
androidComponents {
    onVariants { variant ->
        for (output in variant.outputs) {
            val abi = output.filters.find { it.filterType == FilterConfiguration.FilterType.ABI }?.identifier
            output.versionCode.set(flutter.versionCode * 10 + (abiDigits[abi] ?: 0))
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    // flutter_local_notifications: the desugaring library its README pins.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    // The AppCompat themes in res/values*/styles.xml, which App Lock's prompt needs on Android 8 and earlier.
    // androidx.biometric (local_auth) brings it at run time already; listed because the app's own styles use it.
    implementation("androidx.appcompat:appcompat:1.7.1")
}
