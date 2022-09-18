package com.example.travel_schedule_app_widget.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import android.widget.Toast
import com.example.travel_schedule_app_widget.MainActivity
import com.example.travel_schedule_app_widget.R
import es.antonborri.home_widget.HomeWidgetProvider


class WidgetProvider : HomeWidgetProvider() {

    companion object {
        const val ITEM_CTA = R.string.item_cta_key
        const val ACTION_CLICK = R.string.action_click
    }

    override fun onEnabled(context: Context?) {
        super.onEnabled(context)

    }

    override fun onReceive(context: Context?, intent: Intent?) {

        if (intent?.action == context?.getString(ACTION_CLICK)) {
            val cta: String? = intent?.getStringExtra(context?.getString(ITEM_CTA))
            Toast.makeText(context,"Clicked $cta",Toast.LENGTH_LONG).show()
            Intent(context, MainActivity::class.java).apply {
                action = context?.getString(R.string.app_widget_launch_action)
                data = Uri.parse("${context?.getString(R.string.app_widget_card_clicked_uri)}?${cta}")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context?.startActivity(this)
            }
        }
        super.onReceive(context, intent)

    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { appWidgetId ->
            RemoteViews(
                context.packageName,
                R.layout.app_widget_layout
            ).apply {

                val placesData = widgetData.getString(context.getString(R.string.places_data),"")
                val datesData = widgetData.getString(context.getString(R.string.dates_data),"")

                val svcIntent = Intent(context, WidgetService::class.java)
                svcIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
                svcIntent.data = Uri.parse(svcIntent.toUri(Intent.URI_INTENT_SCHEME))
                svcIntent.putExtra(context.getString(R.string.places_data),placesData)
                svcIntent.putExtra(context.getString(R.string.dates_data),datesData)

                setRemoteAdapter(
                    R.id.words,
                    svcIntent
                )

                val clickPendingIntent: PendingIntent = Intent(
                    context,
                    WidgetProvider::class.java
                ).run {
                    action = context.getString(ACTION_CLICK)
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
                    data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))

                    PendingIntent.getBroadcast(context, 0, this, PendingIntent.FLAG_UPDATE_CURRENT)
                }
                setPendingIntentTemplate(R.id.words,clickPendingIntent)
                appWidgetManager.updateAppWidget(appWidgetId, this)
            }
        }
    }
}