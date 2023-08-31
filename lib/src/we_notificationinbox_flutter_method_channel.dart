import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'we_notificationinbox_flutter_platform_interface.dart';
import '../utils/Constants.dart';
import '../utils/WELogger.dart';

/// An implementation of [WeNotificationinboxFlutterPlatform] that uses method channels.
class MethodChannelWeNotificationinboxFlutter
    extends WeNotificationinboxFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(METHOD_CHANNEL_WE_NOTIFICATIONINBOX_FLUTTER);

  @override
  Future<bool> initNotificationInbox() async {
    WELogger.v("WE NI MethodChannel init Notification Inbox");
    final registered = await methodChannel
        .invokeMethod<dynamic>(METHOD_NAME_INIT_NOTIFICATION_INBOX, {});
    return registered as bool;
  }

  @override
  Future<String> getNotificationCount() async {
    try {
      final result =
          await methodChannel.invokeMethod(METHOD_NAME_GET_NOTIFICATION_COUNT);
      return result;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    try {
      WELogger.v("JSON offset passed to Native- $offsetJSON");
      // TODO - check if this is creating issue for iOS
      String jsonString = jsonEncode(offsetJSON);
      final dynamic result = await methodChannel.invokeMethod(
          METHOD_NAME_GET_NOTIFICATION_LIST, {OFFSETJSON: jsonString});
      if (result != null) {
        final Map<String, dynamic> response = notificationListResponse(result);
        return response;
      }
    } catch (error) {
      WELogger.e('Error in NotficationListResponse - $error');
      throw error;
    }
  }

  @override
  Future<void> markRead(Map<String, dynamic> readMap) async {
    if (readMap.isEmpty) {
      WELogger.v("No Notification Item passed to markRead");
      return;
    }

    String status = readMap['status'] ?? "";
    if (status.toLowerCase() != "read") {
      await methodChannel.invokeMethod(METHOD_NAME_MARK_READ, readMap);
    } else {
      WELogger.e("markRead - status is already read");
    }
  }

  @override
  Future<void> markUnread(Map<String, dynamic> readMap) async {
    if (readMap.isEmpty) {
      WELogger.v("No Notification Item passed to markUnread");
      return;
    }

    String status = readMap['status'] ?? "";
    if (status.toLowerCase() != "unread") {
      await methodChannel.invokeMethod(METHOD_NAME_MARK_UNREAD, readMap);
    } else {
      WELogger.e("markRead - status is already unread");
    }
  }

  @override
  Future<void> trackClick(Map<String, dynamic> readMap) async {
    if (readMap.isEmpty) {
      WELogger.v("No Notification Item passed to trackClick");
    } else {
      await methodChannel.invokeMethod(METHOD_NAME_TRACK_CLICK, readMap);
    }
  }

  @override
  Future<void> trackView(Map<String, dynamic> readMap) async {
    if (readMap.isEmpty) {
      WELogger.v("No Notification Item passed to trackView");
    } else {
      await methodChannel.invokeMethod(METHOD_NAME_TRACK_VIEW, readMap);
    }
  }

  @override
  Future<void> markDelete(Map<String, dynamic> readMap) async {
    if (readMap.isEmpty) {
      WELogger.v("No Notification Item passed to markDelete");
    } else {
      await methodChannel.invokeMethod(METHOD_NAME_MARK_DELETE, readMap);
    }
  }

  @override
  Future<void> readAll(List<dynamic> notificationList) async {
    if (notificationList.isNotEmpty) {
      await methodChannel.invokeMethod(METHOD_NAME_READ_ALL, notificationList);
    } else {
      WELogger.v('readAll - list is empty');
    }
  }

  @override
  Future<void> unReadAll(List<dynamic> notificationList) async {
    if (notificationList.isNotEmpty) {
      await methodChannel.invokeMethod(
          METHOD_NAME_UNREAD_ALL, notificationList);
    } else {
      WELogger.v('unReadAll - list is empty');
    }
  }

  @override
  Future<void> deleteAll(List<dynamic> notificationList) async {
    if (notificationList.isNotEmpty) {
      await methodChannel.invokeMethod(
          METHOD_NAME_DELETE_ALL, notificationList);
    } else {
      WELogger.v('deleteAll - list is empty');
    }
  }

  @override
  Future<void> resetNotificationCount() async {
    await methodChannel.invokeMethod(METHOD_NAME_RESET_NOTIFICATION_COUNT);
  }

  dynamic notificationListResponse(dynamic result) {
    var ml = result[MESSAGELIST];
    var mlStr = result[MESSAGELIST] as String;
    WELogger.v('notificationListResponse received result-$result');
    WELogger.v('notificationListResponse received result[ml] -$ml');
    WELogger.v('notificationListResponse received mlStr-$mlStr');
    // WELogger.v('notificationListResponse received mlStr-$mlStr');
    Map<String, dynamic> responseData = {};
    final messageString = result[MESSAGELIST] as String;
    final hasNextPage = result[HASNEXT] as bool;
    if (messageString != null) {
      final messageList = jsonDecode(messageString);
      responseData[MESSAGELIST] = messageList;
      responseData[HASNEXT] = hasNextPage;
    }
    WELogger.v('notificationList -$responseData');
    return responseData;
  }
}
