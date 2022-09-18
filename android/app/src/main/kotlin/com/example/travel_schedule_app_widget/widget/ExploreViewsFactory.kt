package com.example.travel_schedule_app_widget.widget;

import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.RemoteViews;
import android.widget.RemoteViewsService;
import com.example.travel_schedule_app_widget.R

class ExploreViewsFactory(ctxt: Context?, intent: Intent) : RemoteViewsService.RemoteViewsFactory {
    private var ctxt: Context? = null
    private val appWidgetId: Int
    private var cardItemList: ArrayList<CardItemDTO>
    override fun onCreate() {}

    override fun onDestroy() {
        cardItemList.clear();
    }

    override fun getCount(): Int {
        return cardItemList.size
    }

    override fun getViewAt(position: Int): RemoteViews {
        val row = RemoteViews(
            ctxt!!.packageName,
            R.layout.app_widget_item_layout
        ).apply {
            setImageViewResource(R.id.idIvImage, cardItemList[position].icon)
            setTextViewText(R.id.idTvTitle, cardItemList[position].place)
            setTextViewText(R.id.idTvDate, cardItemList[position].date)
        }

        Intent().apply {
            val extras = Bundle()
            extras.putString(ctxt!!.getString(WidgetProvider.ITEM_CTA), cardItemList[position].place)
            putExtras(extras)
            row.setOnClickFillInIntent(R.id.cardItem, this)
        }
        return row
    }

    override fun getLoadingView(): RemoteViews? {
        return null
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }

    override fun onDataSetChanged() {
        // no-op
    }

    init {
        this.ctxt = ctxt
        appWidgetId = intent.getIntExtra(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        )
        cardItemList = ArrayList()
        val placesData = intent.getStringExtra(ctxt!!.getString(R.string.places_data))?.split(",")
        val datesData = intent.getStringExtra(ctxt.getString(R.string.dates_data))?.split(",")
        for (i in 0..(placesData!!.size-1)) {
            cardItemList.add(
                CardItemDTO(
                    icon = getDrawable(i),
                    place = placesData[i],
                    date = datesData?.get(i) ?: ""
                )
            )
        }
    }

    fun getDrawable(index: Int): Int {
        return when (index) {
            0 -> return R.drawable.app_widget_gridview1
            1 -> return R.drawable.app_widget_gridview2
            2 -> return R.drawable.app_widget_gridview3
            else -> {
                -1
            }
        }
    }
}