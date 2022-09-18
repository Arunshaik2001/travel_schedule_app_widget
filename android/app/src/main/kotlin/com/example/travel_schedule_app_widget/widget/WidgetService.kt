package com.example.travel_schedule_app_widget.widget

import android.content.Intent
import android.widget.RemoteViewsService
import com.example.travel_schedule_app_widget.widget.ExploreViewsFactory

class WidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return ExploreViewsFactory(
            this.applicationContext,
            intent
        )
    }
}