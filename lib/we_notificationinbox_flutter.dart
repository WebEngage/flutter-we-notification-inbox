export 'package:we_notificationinbox_flutter/src/WENotificationInbox.dart';
export 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_method_channel.dart';
import 'src/we_notificationinbox_flutter_platform_interface.dart';

class WENotificationinboxFlutter {
  Future<String?> getPlatformVersion() {
    return WeNotificationinboxFlutterPlatform.instance.getPlatformVersion();
  }

  Future<String> getNotificationCount() {
    return WeNotificationinboxFlutterPlatform.instance.getNotificationCount();
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    return WeNotificationinboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
  }

  Future<void> markRead(Map<String, dynamic> readMap) async {
    WeNotificationinboxFlutterPlatform.instance.markRead(readMap);
  }

  Future<void> markUnread(Map<String, dynamic> readMap) async {
    WeNotificationinboxFlutterPlatform.instance.markUnread(readMap);
  }

  Future<void> trackClick(Map<String, dynamic> readMap) async {
    WeNotificationinboxFlutterPlatform.instance.trackClick(readMap);
  }

  Future<void> trackView(Map<String, dynamic> readMap) async {
    WeNotificationinboxFlutterPlatform.instance.trackView(readMap);
  }

  Future<void> markDelete(Map<String, dynamic> readMap) async {
    WeNotificationinboxFlutterPlatform.instance.markDelete(readMap);
  }

  Future<void> readAll(List<dynamic> notificationList) async {
    WeNotificationinboxFlutterPlatform.instance.readAll(notificationList);
  }

  Future<void> unReadAll(List<dynamic> notificationList) async {
    WeNotificationinboxFlutterPlatform.instance.unReadAll(notificationList);
  }

  Future<void> deleteAll(List<dynamic> notificationList) async {
    WeNotificationinboxFlutterPlatform.instance.deleteAll(notificationList);
  }

  Future<void> resetNotificationCount() async {
    WeNotificationinboxFlutterPlatform.instance.resetNotificationCount();
  }
}
