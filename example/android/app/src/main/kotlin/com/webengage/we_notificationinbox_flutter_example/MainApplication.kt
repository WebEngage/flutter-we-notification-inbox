package com.webengage.we_notificationinbox_flutter_example

import com.webengage.sdk.android.LocationTrackingStrategy
import com.webengage.sdk.android.WebEngageConfig
import com.webengage.sdk.android.actions.database.ReportingStrategy
import com.webengage.webengage_plugin.WebengageInitializer
import io.flutter.app.FlutterApplication


public class MainApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        val webEngageConfig = WebEngageConfig.Builder()
            .setWebEngageKey("aa131d2c")
            .setAutoGCMRegistrationFlag(false)
            .setLocationTrackingStrategy(LocationTrackingStrategy.ACCURACY_BEST)
            .setEventReportingStrategy(ReportingStrategy.FORCE_SYNC)
            .setDebugMode(true) // only in development mode
            .build()
        WebengageInitializer.initialize(this, webEngageConfig)

    }
}