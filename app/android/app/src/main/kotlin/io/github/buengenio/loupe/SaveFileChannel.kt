package io.github.buengenio.loupe

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import android.webkit.MimeTypeMap
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException
import java.util.Locale
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

/**
 * Saves a file from the app's cache where the user picks, with Android's save dialog
 * (ACTION_CREATE_DOCUMENT), copying it as a stream: an exported folder (an mbox file) can be far larger
 * than what fits in memory, and file_picker's saveFile takes the bytes. The Dart side is
 * app/lib/features/export/export_files.dart.
 *
 * Methods:
 * - `save {path, name}`: the dialog, suggesting `name`; true once the file is copied there, false when
 *   the user cancels. The type comes from the name's extension (as file_picker does it): a type the
 *   system doesn't know for it would make the dialog append that type's extension to the name.
 *
 * Errors: `busy` (the dialog is already open), `unavailable` (nothing on the device offers it),
 * `failed` (the copy failed; what was written is deleted).
 *
 * The copy runs on a worker thread; replies go back on the main thread.
 */
class SaveFileChannel(private val activity: Activity, messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, NAME)
    private val worker: ExecutorService = Executors.newSingleThreadExecutor()
    private val main = Handler(Looper.getMainLooper())

    /** The file of the open dialog, and who waits for it. */
    private var pending: Pair<String, MethodChannel.Result>? = null

    init {
        channel.setMethodCallHandler(this)
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
        pending = null
        worker.shutdown()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "save" -> save(call, result)
            else -> result.notImplemented()
        }
    }

    private fun save(call: MethodCall, result: MethodChannel.Result) {
        val path = call.argument<String>("path")
        val name = call.argument<String>("name")
        if (path == null || name == null) {
            result.error("failed", "No file", null)
            return
        }
        if (pending != null) {
            result.error("busy", "The save dialog is already open", null)
            return
        }
        val extension = name.substringAfterLast('.', "").lowercase(Locale.ROOT)
        val type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension) ?: "*/*"
        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT)
            .addCategory(Intent.CATEGORY_OPENABLE)
            .setType(type)
            .putExtra(Intent.EXTRA_TITLE, name)
        pending = Pair(path, result)
        try {
            activity.startActivityForResult(intent, REQUEST_CODE)
        } catch (e: ActivityNotFoundException) {
            pending = null
            result.error("unavailable", e.message, null)
        }
    }

    /** MainActivity hands every activity result here first; true when it was this channel's. */
    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val (path, result) = pending ?: return true
        pending = null
        val uri = data?.data
        if (resultCode != Activity.RESULT_OK || uri == null) {
            result.success(false)
            return true
        }
        worker.execute {
            try {
                copy(File(path), uri)
                main.post { result.success(true) }
            } catch (e: Exception) {
                try {
                    DocumentsContract.deleteDocument(activity.contentResolver, uri)
                } catch (ignored: Exception) {
                    // The provider may not allow it; the error is what matters.
                }
                main.post { result.error("failed", e.message, null) }
            }
        }
        return true
    }

    private fun copy(file: File, uri: Uri) {
        val out = activity.contentResolver.openOutputStream(uri, "w") ?: throw IOException("Can't write there")
        out.use { sink -> file.inputStream().use { it.copyTo(sink, BUFFER_SIZE) } }
    }

    companion object {
        const val NAME = "io.github.buengenio.loupe/save_file"

        /** Below 0x10000, as activity request codes must be. */
        private const val REQUEST_CODE = 0x4c53

        private const val BUFFER_SIZE = 256 * 1024
    }
}
