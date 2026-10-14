package io.github.buengenio.loupe.minusone

import android.animation.ValueAnimator
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.PixelFormat
import android.os.Binder
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.RemoteException
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import com.google.android.libraries.launcherclient.ILauncherOverlay
import com.google.android.libraries.launcherclient.ILauncherOverlayCallback

/**
 * Loupe on the home screen's leftmost page - the "minus one" screen, the one the Google app fills
 * with Discover on a Pixel.
 *
 * There is no public Android API for it. A launcher that wants a minus-one page binds a service in
 * another app that answers `com.android.launcher3.WINDOW_OVERLAY` and talks to it over Google's
 * private [ILauncherOverlay] interface (see the AIDL in `src/main/aidl/`). The launcher hands over
 * its own window token; the provider adds a sub-window to it and slides the panel in as the
 * launcher reports how far the user has dragged. That is what this service does, with
 * [MinusOnePanelView] as the content.
 *
 * Which launchers can use it: ones that let the user choose the provider - Lawnchair (Home screen >
 * Feed provider, after Ignore feed whitelist in the debug settings), Neo Launcher and other
 * Launcher3 forks. The Pixel and One UI launchers pin the provider to the Google app, so Loupe
 * cannot appear there however it is written. `docs/android-minus-one.md` has the setup.
 *
 * The protocol, as the launcher uses it:
 * - `windowAttached2(bundle, callback)` - the bundle's `layout_params` carries the launcher window's
 *   token. We add our window and answer `overlayStatusChanged(1)`, which is what makes the launcher
 *   show a page to the left at all.
 * - `startScroll`, `onScroll(progress)`, `endScroll` - the drag. 0 is closed, 1 is fully open.
 * - `endScroll` hands the gesture back to us: the panel settles itself, and reports every frame
 *   through `overlayScrollChanged` so the launcher's workspace keeps following it.
 * - `openOverlay` / `closeOverlay` - the launcher asks for the panel without a drag.
 * - `windowDetached` - the launcher's window is going away; our window goes with it.
 *
 * Only the current home app is served (see [isHomeApp]): binding is open to any app, and the panel
 * would otherwise render Loupe's content into a window that an arbitrary caller owns.
 *
 * Everything that touches the window runs on the main thread; Binder calls arrive on a pool thread.
 */
class MinusOneOverlayService : Service() {

    private val main = Handler(Looper.getMainLooper())
    private var panel: Panel? = null

    override fun onBind(intent: Intent?): IBinder = OverlayBinder()

    override fun onDestroy() {
        main.post { detach() }
        super.onDestroy()
    }

    /** True when [uid] is the home app the user has chosen. */
    private fun isHomeApp(uid: Int): Boolean {
        val callers = packageManager.getPackagesForUid(uid) ?: return false
        val home = packageManager.resolveActivity(
            Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME),
            PackageManager.MATCH_DEFAULT_ONLY,
        )?.activityInfo?.packageName
        return home != null && home in callers
    }

    private fun attach(params: WindowManager.LayoutParams?, callback: ILauncherOverlayCallback?) {
        detach()
        if (params == null) return
        panel = try {
            Panel(params, callback)
        } catch (e: WindowManager.BadTokenException) {
            // A stale token: the launcher's window went away between its call and here.
            onAttachFailed(callback, e)
        } catch (e: WindowManager.InvalidDisplayException) {
            // The launcher's display went away with it.
            onAttachFailed(callback, e)
        }
    }

    private fun detach() {
        panel?.remove()
        panel = null
    }

    /**
     * Tells the launcher there is no overlay after all, so it drops its left page instead of
     * keeping one that never draws.
     */
    private fun onAttachFailed(callback: ILauncherOverlayCallback?, e: RuntimeException): Panel? {
        Log.w(TAG, "The launcher's window would not take the panel", e)
        callback?.statusChanged(0)
        return null
    }

    /** Swallows the launcher dying mid-call: there is nothing to tell it any more. */
    private fun ILauncherOverlayCallback.statusChanged(status: Int) = try {
        overlayStatusChanged(status)
    } catch (e: RemoteException) {
        Log.w(TAG, "The launcher went away", e)
    }

    /** The panel's window, added to the launcher's, and the slide. */
    private inner class Panel(
        launcherParams: WindowManager.LayoutParams,
        private val callback: ILauncherOverlayCallback?,
    ) {
        private val windowManager = getSystemService(WindowManager::class.java)
        private val view = MinusOnePanelView(this@MinusOneOverlayService)
        private var settle: ValueAnimator? = null

        /** 0 closed, 1 open. */
        private var progress = 0f

        private val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            // A sub-window of the launcher's window: that is what the handed-over token allows,
            // and it needs no overlay permission of our own.
            WindowManager.LayoutParams.TYPE_APPLICATION_SUB_PANEL,
            CLOSED_FLAGS,
            PixelFormat.TRANSLUCENT,
        ).apply {
            token = launcherParams.token
            gravity = Gravity.TOP or Gravity.START
            x = 0
            y = 0
            softInputMode = WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                layoutInDisplayCutoutMode =
                    WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
            }
        }

        init {
            // Added closed: off to the left, and not touchable, so the home screen behaves exactly
            // as it did until the user drags the page in.
            view.visibility = View.INVISIBLE
            windowManager.addView(view, params)
            view.post { place() }
            callback?.statusChanged(STATUS_ATTACHED)
        }

        private fun cancelSettle() {
            val running = settle
            settle = null
            running?.cancel()
        }

        fun remove() {
            cancelSettle()
            try {
                windowManager.removeViewImmediate(view)
            } catch (e: IllegalArgumentException) {
                Log.w(TAG, "The panel was already gone", e)
            }
        }

        fun startScroll() {
            cancelSettle()
            setTouchable(true)
            view.visibility = View.VISIBLE
        }

        fun scrollTo(value: Float) {
            progress = value.coerceIn(0f, 1f)
            place()
        }

        /** The drag ended: settle open or closed, and keep the launcher in step. */
        fun endScroll() {
            animateTo(if (progress > 0.5f) 1f else 0f, animate = true)
        }

        fun open(animate: Boolean) {
            setTouchable(true)
            view.visibility = View.VISIBLE
            animateTo(1f, animate)
        }

        fun close(animate: Boolean) {
            animateTo(0f, animate)
        }

        private fun animateTo(target: Float, animate: Boolean) {
            // Clear the field before cancelling: cancel() runs the listener below straight away,
            // and it must not settle the slide it is replacing.
            cancelSettle()
            if (!animate || progress == target) {
                scrollTo(target)
                finish(target)
                return
            }
            settle = ValueAnimator.ofFloat(progress, target).apply {
                duration = (SETTLE_MS * kotlin.math.abs(target - progress)).toLong().coerceAtLeast(1)
                addUpdateListener {
                    scrollTo(it.animatedValue as Float)
                    // The launcher moves its workspace to match, so the two slide together.
                    try {
                        callback?.overlayScrollChanged(progress)
                    } catch (e: RemoteException) {
                        Log.w(TAG, "The launcher went away mid-slide", e)
                        cancel()
                    }
                }
                addListener(
                    object : android.animation.AnimatorListenerAdapter() {
                        override fun onAnimationEnd(animation: android.animation.Animator) {
                            if (settle === animation) finish(target)
                        }
                    },
                )
                start()
            }
        }

        private fun finish(target: Float) {
            if (target == 0f) {
                view.visibility = View.INVISIBLE
                setTouchable(false)
            }
            try {
                callback?.overlayScrollChanged(target)
            } catch (e: RemoteException) {
                Log.w(TAG, "The launcher went away", e)
            }
        }

        /** Slides the panel to [progress]: fully off to the left at 0, in place at 1. */
        private fun place() {
            val width = if (view.width > 0) view.width else view.resources.displayMetrics.widthPixels
            view.translationX = -width * (1f - progress)
        }

        private fun setTouchable(touchable: Boolean) {
            val flags = if (touchable) OPEN_FLAGS else CLOSED_FLAGS
            if (params.flags == flags) return
            params.flags = flags
            try {
                windowManager.updateViewLayout(view, params)
            } catch (e: IllegalArgumentException) {
                Log.w(TAG, "The panel was already gone", e)
            }
        }
    }

    /**
     * The launcher's end of [ILauncherOverlay]. Calls arrive on a Binder thread and are posted to
     * the main thread, where the window lives.
     */
    private inner class OverlayBinder : ILauncherOverlay.Stub() {

        /** Runs [body] on the main thread, for the home app only. */
        private fun onMain(body: () -> Unit) {
            if (!isHomeApp(Binder.getCallingUid())) {
                Log.w(TAG, "Ignoring an overlay call from uid ${Binder.getCallingUid()}: not the home app")
                return
            }
            main.post(body)
        }

        override fun windowAttached(
            lp: WindowManager.LayoutParams?,
            cb: ILauncherOverlayCallback?,
            flags: Int,
        ) = onMain { attach(lp, cb) }

        // What launchers actually call (service.api.version 7); windowAttached above is the old form.
        override fun windowAttached2(bundle: Bundle?, cb: ILauncherOverlayCallback?) = onMain {
            attach(bundle?.layoutParams(), cb)
        }

        override fun windowDetached(isChangingConfigurations: Boolean) = onMain { detach() }

        override fun startScroll() = onMain { panel?.startScroll() }

        override fun onScroll(progress: Float) = onMain { panel?.scrollTo(progress) }

        override fun endScroll() = onMain { panel?.endScroll() }

        override fun openOverlay(flags: Int) = onMain { panel?.open(flags and FLAG_ANIMATE != 0) }

        override fun closeOverlay(flags: Int) = onMain { panel?.close(flags and FLAG_ANIMATE != 0) }

        override fun hasOverlayContent(): Boolean = true

        // The launcher's window came back or went to the background. The panel holds no data of its
        // own and nothing is polled while it is closed, so there is nothing to start or stop.
        override fun setActivityState(flags: Int) = Unit

        override fun onPause() = Unit

        override fun onResume() = Unit

        // Voice search and in-overlay search belong to the Google app's version of this interface.
        override fun requestVoiceDetection(start: Boolean) = Unit

        override fun getVoiceSearchLanguage(): String? = null

        override fun isVoiceDetectionRunning(): Boolean = false

        override fun startSearch(data: ByteArray?, bundle: Bundle?): Boolean = false

        override fun unusedMethod() = Unit
    }

    private fun Bundle.layoutParams(): WindowManager.LayoutParams? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getParcelable(KEY_LAYOUT_PARAMS, WindowManager.LayoutParams::class.java)
        } else {
            @Suppress("DEPRECATION")
            getParcelable(KEY_LAYOUT_PARAMS) as? WindowManager.LayoutParams
        }

    private companion object {
        const val TAG = "LoupeMinusOne"

        /** The launcher window's attributes, as the launcher puts them in the attach bundle. */
        const val KEY_LAYOUT_PARAMS = "layout_params"

        /** `overlayStatusChanged`: bit 0 is "the overlay is there", which enables the left page. */
        const val STATUS_ATTACHED = 1

        /** `openOverlay`/`closeOverlay`: bit 0 asks for the move to be animated. */
        const val FLAG_ANIMATE = 1

        const val SETTLE_MS = 300f

        const val CLOSED_FLAGS = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE

        const val OPEN_FLAGS = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
    }
}
