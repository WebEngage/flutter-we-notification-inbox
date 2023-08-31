package com.webengage.we_notificationinbox_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WeNotificationinboxFlutterPlugin */
class WeNotificationinboxFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var weNotification = WENotification();
  private lateinit var context: Context;

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("WebEngage","AKC: onAttatchedToEngine!!");
    context = flutterPluginBinding.applicationContext
    weNotification.attachContext(context);
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "we_notificationinbox_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    Log.d("WebEngage", "AKC: onMethodCall!! " + call.method)

    when (call.method) {
      Constants.METHOD_NAME_INIT -> weNotification.initialization()
      Constants.METHOD_NAME_GET_NOTIFICATION_COUNT -> weNotification.getNotificationCount(result)
      Constants.METHOD_NAME_GET_NOTIFICATION_LIST -> weNotification.getNotificationList(call.arguments as HashMap<String, *>, result)
      Constants.METHOD_NAME_MARK_READ -> weNotification.markRead(call.arguments as HashMap<String, String>)
      Constants.METHOD_NAME_MARK_UNREAD -> weNotification.markUnread(call.arguments as HashMap<String, String>)
      Constants.METHOD_NAME_TRACK_CLICK -> weNotification.trackClick(call.arguments as HashMap<String, String>)
      Constants.METHOD_NAME_TRACK_VIEW -> weNotification.trackView(call.arguments as HashMap<String, String>)
      Constants.METHOD_NAME_MARK_DELETE -> weNotification.markDelete(call.arguments as HashMap<String, String>)
      Constants.METHOD_NAME_READ_ALL -> weNotification.readAll(call.arguments as List<HashMap<String,String>>)
      Constants.METHOD_NAME_UNREAD_ALL -> weNotification.unReadAll(call.arguments as List<HashMap<String, String>>)
      Constants.METHOD_NAME_DELETE_ALL -> weNotification.deleteAll(call.arguments as List<HashMap<String, String>>)
      Constants.METHOD_NAME_RESET_NOTIFICATION_COUNT -> weNotification.resetNotificationCount()
      else -> result.notImplemented()
    }

//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    } (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("WebEngage","AKC: onDetachedFromEngine!!");

    channel.setMethodCallHandler(null)
  }
}
