package io.github.buengenio.loupe

import android.app.Activity
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Whether Recent Apps shows a screenshot of Loupe. While App Lock is on it doesn't: the switcher, and the preview
 * Android shows while Loupe comes back, are a blank card instead of mail. Screenshots inside the app stay allowed
 * (no FLAG_SECURE). The Dart side is app/lib/platform/recents_privacy.dart.
 *
 * Methods:
 * - `setRecentsScreenshotEnabled {enabled}`: Activity.setRecentsScreenshotEnabled, Android 13 (API 33) and later.
 *   True when it was set, false on earlier versions, which always take the screenshot.
 */
class RecentsChannel(private val activity: Activity, messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, NAME)

    init {
        channel.setMethodCallHandler(this)
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setRecentsScreenshotEnabled" -> {
                val enabled = call.argument<Boolean>("enabled") ?: true
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    activity.setRecentsScreenshotEnabled(enabled)
                    result.success(true)
                } else {
                    result.success(false)
                }
            }
            else -> result.notImplemented()
        }
    }

    companion object {
        const val NAME = "io.github.buengenio.loupe/recents"
    }
}
