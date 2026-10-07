package io.github.buengenio.loupe

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.security.KeyChain
import android.security.KeyChainException
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.GeneralSecurityException
import java.security.InvalidAlgorithmParameterException
import java.security.InvalidKeyException
import java.security.KeyFactory
import java.security.NoSuchAlgorithmException
import java.security.PrivateKey
import java.security.Signature
import java.security.spec.MGF1ParameterSpec
import java.security.spec.X509EncodedKeySpec
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import javax.crypto.BadPaddingException
import javax.crypto.Cipher
import javax.crypto.IllegalBlockSizeException
import javax.crypto.KeyAgreement
import javax.crypto.spec.OAEPParameterSpec
import javax.crypto.spec.PSource

/**
 * S/MIME certificates installed on the device (by a company's device management, or by the user in
 * Settings › Security › Encryption & credentials), through Android's KeyChain. Their private keys never
 * leave it: Loupe asks for what it needs (a signature over CMS signed attributes, a decrypted content key,
 * an ECDH secret) and does the rest in Dart. The Dart side is app/lib/features/smime/device_certificates.dart.
 *
 * Methods:
 * - `choose {alias?}`: KeyChain's own picker (RSA and EC keys); the alias, or null. Picking grants the use.
 * - `chain {alias}`: the certificate and its issuers, DER, the certificate first.
 * - `perform {alias, operation, input, keyType, digest?, mgfDigest?}`: `sign` (SHA-xxxwithRSA or
 *   SHA-xxxwithECDSA over input), `decryptPkcs1` (RSA/ECB/PKCS1Padding), `decryptOaep` (RSA/ECB/OAEPPadding
 *   with the digests, empty label), `agree` (ECDH with the peer's SubjectPublicKeyInfo in input).
 *
 * Errors: `unavailable` (no such key, or the grant was withdrawn), `badPadding`, `unsupported` (the key or
 * the platform can't do it, e.g. ECDH with a key not allowed to agree), `failed`.
 *
 * KeyChain calls block (they bind to the KeyChain service), so they run on a worker thread; replies go
 * back on the main thread.
 */
class KeyChainChannel(private val activity: Activity, messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, NAME)
    private val worker: ExecutorService = Executors.newSingleThreadExecutor()
    private val main = Handler(Looper.getMainLooper())

    init {
        channel.setMethodCallHandler(this)
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
        worker.shutdown()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "choose" -> choose(call.argument<String>("alias"), result)
            "chain" -> inBackground(result) { chain(call.argument<String>("alias") ?: throw Unavailable()) }
            "perform" -> inBackground(result) { perform(call) }
            else -> result.notImplemented()
        }
    }

    private fun choose(alias: String?, result: MethodChannel.Result) {
        try {
            KeyChain.choosePrivateKeyAlias(
                activity,
                { chosen -> main.post { result.success(chosen) } },
                arrayOf("RSA", "EC"),
                null,
                null,
                alias,
            )
        } catch (e: RuntimeException) {
            result.error("failed", e.message, null)
        }
    }

    private fun chain(alias: String): List<ByteArray> {
        val chain = KeyChain.getCertificateChain(activity, alias)
        if (chain == null || chain.isEmpty()) throw Unavailable()
        return chain.map { it.encoded }
    }

    private fun key(alias: String): PrivateKey = KeyChain.getPrivateKey(activity, alias) ?: throw Unavailable()

    private fun perform(call: MethodCall): ByteArray {
        val alias = call.argument<String>("alias") ?: throw Unavailable()
        val input = call.argument<ByteArray>("input") ?: throw IllegalArgumentException("No input")
        val digest = call.argument<String>("digest")
        val key = key(alias)
        return when (call.argument<String>("operation")) {
            "sign" -> {
                val hash = (digest ?: "SHA-256").replace("-", "")
                val algorithm = if (call.argument<String>("keyType") == "ec") "${hash}withECDSA" else "${hash}withRSA"
                Signature.getInstance(algorithm).run {
                    initSign(key)
                    update(input)
                    sign()
                }
            }
            "decryptPkcs1" -> Cipher.getInstance("RSA/ECB/PKCS1Padding").run {
                init(Cipher.DECRYPT_MODE, key)
                doFinal(input)
            }
            "decryptOaep" -> Cipher.getInstance("RSA/ECB/OAEPPadding").run {
                val md = digest ?: "SHA-1"
                val mgf = MGF1ParameterSpec(call.argument<String>("mgfDigest") ?: md)
                init(Cipher.DECRYPT_MODE, key, OAEPParameterSpec(md, "MGF1", mgf, PSource.PSpecified.DEFAULT))
                doFinal(input)
            }
            "agree" -> {
                val peer = KeyFactory.getInstance("EC").generatePublic(X509EncodedKeySpec(input))
                KeyAgreement.getInstance("ECDH").run {
                    init(key)
                    doPhase(peer, true)
                    generateSecret()
                }
            }
            else -> throw UnsupportedOperationException("Unknown operation")
        }
    }

    private fun inBackground(result: MethodChannel.Result, work: () -> Any?) {
        worker.execute {
            var value: Any? = null
            val failure: Pair<String, String?>? = try {
                value = work()
                null
            } catch (e: Unavailable) {
                "unavailable" to "The certificate isn't available"
            } catch (e: KeyChainException) {
                "unavailable" to e.message
            } catch (e: BadPaddingException) {
                "badPadding" to e.message
            } catch (e: IllegalBlockSizeException) {
                "badPadding" to e.message
            } catch (e: InvalidKeyException) {
                "unsupported" to e.message
            } catch (e: InvalidAlgorithmParameterException) {
                "unsupported" to e.message
            } catch (e: NoSuchAlgorithmException) {
                "unsupported" to e.message
            } catch (e: UnsupportedOperationException) {
                "unsupported" to e.message
            } catch (e: GeneralSecurityException) {
                "failed" to "${e.javaClass.simpleName}: ${e.message}"
            } catch (e: InterruptedException) {
                Thread.currentThread().interrupt()
                "unavailable" to "Interrupted"
            } catch (e: RuntimeException) {
                "failed" to "${e.javaClass.simpleName}: ${e.message}"
            }
            main.post {
                if (failure == null) result.success(value) else result.error(failure.first, failure.second, null)
            }
        }
    }

    /** No key or certificate under the alias, or Loupe may no longer use it. */
    private class Unavailable : Exception()

    companion object {
        const val NAME = "io.github.buengenio.loupe/keychain"
    }
}
