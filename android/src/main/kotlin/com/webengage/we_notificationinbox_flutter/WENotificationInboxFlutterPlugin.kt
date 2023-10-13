package com.webengage.we_notificationinbox_flutter

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class WENotificationInboxFlutterPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var weNotification = WENotification();
    private lateinit var context: Context;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        weNotification.attachContext(context);
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            Constants.WE_NOTIFICATION_INBOX_FLUTTER
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            Constants.METHOD_NAME_INIT -> weNotification.initialization()
            Constants.METHOD_NAME_GET_NOTIFICATION_COUNT -> weNotification.getNotificationCount(
                result
            )

            Constants.METHOD_NAME_GET_NOTIFICATION_LIST -> weNotification.getNotificationList(
                call.arguments as HashMap<String, *>,
                result
            )

            Constants.METHOD_NAME_MARK_READ -> weNotification.markRead(call.arguments as HashMap<String, String>, result)
            Constants.METHOD_NAME_MARK_UNREAD -> weNotification.markUnread(call.arguments as HashMap<String, String>, result)
            Constants.METHOD_NAME_TRACK_CLICK -> weNotification.trackClick(call.arguments as HashMap<String, String>, result)
            Constants.METHOD_NAME_TRACK_VIEW -> weNotification.trackView(call.arguments as HashMap<String, String>, result)
            Constants.METHOD_NAME_MARK_DELETE -> weNotification.markDelete(call.arguments as HashMap<String, String>, result)
            Constants.METHOD_NAME_READ_ALL -> weNotification.readAll(call.arguments as List<HashMap<String, String>>, result)
            Constants.METHOD_NAME_UNREAD_ALL -> weNotification.unReadAll(call.arguments as List<HashMap<String, String>>, result)
            Constants.METHOD_NAME_DELETE_ALL -> weNotification.deleteAll(call.arguments as List<HashMap<String, String>>, result)
            Constants.METHOD_NAME_RESET_NOTIFICATION_COUNT -> weNotification.resetNotificationCount(result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
