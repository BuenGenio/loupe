package io.github.buengenio.loupe.minusone

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView
import io.github.buengenio.loupe.MainActivity

/**
 * What the minus-one page shows: a header and a list of cards, built in code so the panel needs no
 * resources of its own (it is drawn into the launcher's window, not into a Loupe activity, so it
 * cannot use the app's Flutter widgets or its theme).
 *
 * This is the **sample** content of [MinusOneOverlayService]: [SampleCard.sample] is a fixed list,
 * not real mail. Loupe's messages live in the encrypted drift database on the Dart side, which this
 * process cannot read; giving the panel real mail means having the app write a small snapshot
 * (sender, subject, time, unread count) somewhere this service can read it - the sync engine's
 * `onNewMail` is the place - and calling [setCards] with it. Everything else here stays as it is.
 *
 * Tapping a card opens Loupe. The panel never shows message bodies: the launcher's minus-one page
 * is visible from the lock-screen-adjacent home screen, so it holds only what a notification would.
 */
class MinusOnePanelView(context: Context) : FrameLayout(context) {

    /** One row of the panel. */
    data class SampleCard(val from: String, val subject: String, val when_: String) {
        companion object {
            val sample = listOf(
                SampleCard("Thunderbird Council", "Re: Expression search in the quick filter bar", "09:12"),
                SampleCard("Stalwart Labs", "JMAP push: your account is set up", "08:40"),
                SampleCard("Anna", "Tickets for Saturday", "Yesterday"),
            )
        }
    }

    private val cards = LinearLayout(context).apply {
        orientation = LinearLayout.VERTICAL
    }

    init {
        // Opaque, so the launcher's wallpaper does not show through the text while the panel slides.
        setBackgroundColor(BACKGROUND)
        val column = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(20), dp(56), dp(20), dp(24))
        }
        column.addView(
            TextView(context).apply {
                text = "Loupe"
                setTextColor(FOREGROUND)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 28f)
                typeface = android.graphics.Typeface.DEFAULT_BOLD
            },
        )
        column.addView(
            TextView(context).apply {
                text = "Sample panel - not your mail yet"
                setTextColor(MUTED)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
                setPadding(0, dp(4), 0, dp(20))
            },
        )
        column.addView(cards, LinearLayout.LayoutParams(MATCH_PARENT, WRAP_CONTENT))
        addView(
            ScrollView(context).apply {
                isFillViewport = true
                addView(column, LayoutParams(MATCH_PARENT, WRAP_CONTENT))
            },
            LayoutParams(MATCH_PARENT, MATCH_PARENT),
        )
        setCards(SampleCard.sample)
    }

    /** Replaces the rows. Call on the main thread. */
    fun setCards(list: List<SampleCard>) {
        cards.removeAllViews()
        list.forEach { cards.addView(cardView(it), rowParams()) }
    }

    private fun rowParams() = LinearLayout.LayoutParams(MATCH_PARENT, WRAP_CONTENT).apply {
        bottomMargin = dp(10)
    }

    private fun cardView(card: SampleCard): View {
        val row = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(16), dp(14), dp(16), dp(14))
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = dp(18).toFloat()
                setColor(CARD)
            }
            isClickable = true
            setOnClickListener { openLoupe() }
        }
        val head = LinearLayout(context).apply { orientation = LinearLayout.HORIZONTAL }
        head.addView(
            TextView(context).apply {
                text = card.from
                setTextColor(FOREGROUND)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 15f)
                typeface = android.graphics.Typeface.DEFAULT_BOLD
                maxLines = 1
            },
            LinearLayout.LayoutParams(0, WRAP_CONTENT, 1f),
        )
        head.addView(
            TextView(context).apply {
                text = card.when_
                setTextColor(MUTED)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 13f)
                gravity = Gravity.END
            },
        )
        row.addView(head, LinearLayout.LayoutParams(MATCH_PARENT, WRAP_CONTENT))
        row.addView(
            TextView(context).apply {
                text = card.subject
                setTextColor(MUTED)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 14f)
                maxLines = 2
                setPadding(0, dp(3), 0, 0)
            },
            LinearLayout.LayoutParams(MATCH_PARENT, WRAP_CONTENT),
        )
        return row
    }

    /**
     * Opens the app. The panel runs inside the launcher's window, not an activity of ours, so the
     * intent needs its own task.
     */
    private fun openLoupe() {
        val intent = Intent(context, MainActivity::class.java)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)
        context.startActivity(intent)
    }

    private fun dp(value: Int): Int =
        (value * resources.displayMetrics.density).toInt()

    private companion object {
        /** Loupe's dark surface colours; the panel is dark whatever the launcher does. */
        val BACKGROUND = Color.parseColor("#FF101418")
        val CARD = Color.parseColor("#FF1C2228")
        val FOREGROUND = Color.parseColor("#FFF2F5F7")
        val MUTED = Color.parseColor("#FF9BA6B2")

        const val MATCH_PARENT = ViewGroup.LayoutParams.MATCH_PARENT
        const val WRAP_CONTENT = ViewGroup.LayoutParams.WRAP_CONTENT
    }
}
