package io.github.buengenio.loupe

import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * A FlutterFragmentActivity, not a FlutterActivity: App Lock's prompt (local_auth, on androidx.biometric's
 * BiometricPrompt) needs a FragmentActivity. It hosts the same engine in a FlutterFragment, and passes activity
 * results, new intents (notification taps), permission results and the back button on to it, so plugins and the
 * channels below see no difference.
 */
class MainActivity : FlutterFragmentActivity() {
    /** S/MIME certificates from Android's KeyChain (KeyChainChannel.kt). */
    private var keyChain: KeyChainChannel? = null

    /** App Lock: no screenshot of Loupe in Recent Apps (RecentsChannel.kt). */
    private var recents: RecentsChannel? = null

    /** Saving exported folders where the user picks (SaveFileChannel.kt). */
    private var saveFile: SaveFileChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        keyChain = KeyChainChannel(this, messenger)
        recents = RecentsChannel(this, messenger)
        saveFile = SaveFileChannel(this, messenger)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keyChain?.dispose()
        keyChain = null
        recents?.dispose()
        recents = null
        saveFile?.dispose()
        saveFile = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (saveFile?.onActivityResult(requestCode, resultCode, data) == true) return
        super.onActivityResult(requestCode, resultCode, data)
    }
}
