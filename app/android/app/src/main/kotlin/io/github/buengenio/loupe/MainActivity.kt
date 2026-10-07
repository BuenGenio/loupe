package io.github.buengenio.loupe

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    /** S/MIME certificates from Android's KeyChain (KeyChainChannel.kt). */
    private var keyChain: KeyChainChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        keyChain = KeyChainChannel(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        keyChain?.dispose()
        keyChain = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
