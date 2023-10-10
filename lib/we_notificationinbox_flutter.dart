export 'package:we_notificationinbox_flutter/src/WENotificationInbox.dart';
export 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_method_channel.dart';
import 'src/we_notificationinbox_flutter_platform_interface.dart';

class WENotificationinboxFlutter {
  Future<dynamic> getNotificationCount() async {
    var notificationCount = await WeNotificationinboxFlutterPlatform.instance
        .getNotificationCount();
    return notificationCount;
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    var notificationList = await WeNotificationinboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
    return notificationList;
  }

  Future<dynamic> markRead(Map<String, dynamic> readMap) async {
    var readEvent =
        await WeNotificationinboxFlutterPlatform.instance.markRead(readMap);
    return readEvent;
  }

  Future<dynamic> markUnread(Map<String, dynamic> readMap) async {
    var unReadEvent =
        await WeNotificationinboxFlutterPlatform.instance.markUnread(readMap);
    return unReadEvent;
  }

  Future<dynamic> trackClick(Map<String, dynamic> readMap) async {
    var clickEvent =
        await WeNotificationinboxFlutterPlatform.instance.trackClick(readMap);
    return clickEvent;
  }

  Future<dynamic> trackView(Map<String, dynamic> readMap) async {
    var viewEvent =
        await WeNotificationinboxFlutterPlatform.instance.trackView(readMap);
    return viewEvent;
  }

  Future<dynamic> markDelete(Map<String, dynamic> readMap) async {
    var deleteEvent =
        await WeNotificationinboxFlutterPlatform.instance.markDelete(readMap);
    return deleteEvent;
  }

  Future<dynamic> readAll(List<dynamic> notificationList) async {
    var readAllEvent = await WeNotificationinboxFlutterPlatform.instance
        .readAll(notificationList);
    return readAllEvent;
  }

  Future<dynamic> unReadAll(List<dynamic> notificationList) async {
    var unreadAllEvent = await WeNotificationinboxFlutterPlatform.instance
        .unReadAll(notificationList);
    return unreadAllEvent;
  }

  Future<dynamic> deleteAll(List<dynamic> notificationList) async {
    var deleteAllEvent = await WeNotificationinboxFlutterPlatform.instance
        .deleteAll(notificationList);
    return deleteAllEvent;
  }

  Future<dynamic> resetNotificationCount() async {
    var resetCount =
        WeNotificationinboxFlutterPlatform.instance.resetNotificationCount();
    return resetCount;
  }
}
