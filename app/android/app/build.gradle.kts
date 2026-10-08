import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Push (docs/push.md): turns google-services.json (the Firebase project's public client settings) into
    // resources Firebase starts from.
    id("com.google.gms.google-services")
}

// Release signing: android/key.properties locally, or LOUPE_KEYSTORE_* environment
// variables in CI. Without either, release builds fall back to the debug key.
val keyProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}
fun signingValue(name: String, env: String): String? = keyProperties.getProperty(name) ?: System.getenv(env)

android {
    namespace = "io.github.buengenio.loupe"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

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
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
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
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")
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
