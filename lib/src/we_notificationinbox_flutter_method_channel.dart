import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'we_notificationinbox_flutter_platform_interface.dart';
import '../utils/Constants.dart';

/// An implementation of [WeNotificationinboxFlutterPlatform] that uses method channels.
class MethodChannelWeNotificationinboxFlutter
    extends WeNotificationinboxFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(METHOD_CHANNEL_WE_NOTIFICATIONINBOX_FLUTTER);

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
      final dynamic result = await methodChannel.invokeMethod(
          METHOD_NAME_GET_NOTIFICATION_LIST, {OFFSETJSON: offsetJSON});
      if (result != null) {
        final Map<String, dynamic> response = notificationListResponse(result);
        return response;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> markRead(Map<String, dynamic> readMap) async {
    await methodChannel.invokeMethod(METHOD_NAME_MARK_READ, readMap);
  }

  @override
  Future<void> markUnread(Map<String, dynamic> readMap) async {
    await methodChannel.invokeMethod(METHOD_NAME_MARK_UNREAD, readMap);
  }

  @override
  Future<void> trackClick(Map<String, dynamic> readMap) async {
    await methodChannel.invokeMethod(METHOD_NAME_TRACK_CLICK, readMap);
  }

  @override
  Future<void> trackView(Map<String, dynamic> readMap) async {
    await methodChannel.invokeMethod(METHOD_NAME_TRACK_VIEW, readMap);
  }

  @override
  Future<void> markDelete(Map<String, dynamic> readMap) async {
    await methodChannel.invokeMethod(METHOD_NAME_MARK_DELETE, readMap);
  }

  @override
  Future<void> readAll(List<dynamic> notificationList) async {
    await methodChannel.invokeMethod(METHOD_NAME_READ_ALL, notificationList);
  }

  @override
  Future<void> unReadAll(List<dynamic> notificationList) async {
    await methodChannel.invokeMethod(METHOD_NAME_UNREAD_ALL, notificationList);
  }

  @override
  Future<void> deleteAll(List<dynamic> notificationList) async {
    await methodChannel.invokeMethod(METHOD_NAME_DELETE_ALL, notificationList);
  }

  @override
  Future<void> resetNotificationCount() async {
    await methodChannel.invokeMethod(METHOD_NAME_RESET_NOTIFICATION_COUNT);
  }

  dynamic notificationListResponse(dynamic result) {
    Map<String, dynamic> responseData = {};
    final messageString = result[MESSAGELIST] as String;
    final hasNextPage = result[HASNEXT] as bool;
    if (messageString != null) {
      final messageList = jsonDecode(messageString);
      responseData[MESSAGELIST] = messageList;
      responseData[HASNEXT] = hasNextPage;
    }
    return responseData;
  }
}