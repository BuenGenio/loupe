package io.github.buengenio.loupe

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    /** S/MIME certificates from Android's KeyChain (KeyChainChannel.kt). */
    private var keyChain: KeyChainChannel? = null

    /** Saving exported folders where the user picks (SaveFileChannel.kt). */
    private var saveFile: SaveFileChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        keyChain = KeyChainChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        saveFile = SaveFileChannel(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keyChain?.dispose()
        keyChain = null
        saveFile?.dispose()
        saveFile = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (saveFile?.onActivityResult(requestCode, resultCode, data) == true) return
        super.onActivityResult(requestCode, resultCode, data)
    }
}
