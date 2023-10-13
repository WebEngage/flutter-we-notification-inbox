import '../../src/we_notificationinbox_flutter_platform_interface.dart';
import '../utils/WELogger.dart';

class WENotificationInbox {
  static final WENotificationInbox _singleton = WENotificationInbox._internal();

  factory WENotificationInbox() {
    return _singleton;
  }
  WENotificationInbox._internal();

  void init({bool enableLogs = false}) {
    WELogger.enableLogs(enableLogs); // Enable only in Debug Mode
    WENotificationInboxFlutterPlatform.instance.initNotificationInbox();
  }

  Future<dynamic> getNotificationCount() async{
    var countMethod = await WENotificationInboxFlutterPlatform.instance.getNotificationCount();
    return countMethod;
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    var listMethod = await WENotificationInboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
    return listMethod;
  }

  Future<dynamic> markRead(Map<String, dynamic> readMap) async {
    var readEvent = await WENotificationInboxFlutterPlatform.instance.markRead(readMap);
    return readEvent;
  }

  Future<dynamic> markUnread(Map<String, dynamic> readMap) async {
    var unReadEvent = await WENotificationInboxFlutterPlatform.instance.markUnread(readMap);
    return unReadEvent;
  }

  Future<dynamic> trackClick(Map<String, dynamic> readMap) async {
    var clickEvent = await WENotificationInboxFlutterPlatform.instance.trackClick(readMap);
    return clickEvent;
  }

  Future<dynamic> trackView(Map<String, dynamic> readMap) async {
   var viewEvent = await WENotificationInboxFlutterPlatform.instance.trackView(readMap);
   return viewEvent;
  }

  Future<dynamic> markDelete(Map<String, dynamic> readMap) async {
    var deleteEvent = await WENotificationInboxFlutterPlatform.instance.markDelete(readMap);
    return deleteEvent;
  }

  Future<dynamic> readAll(List<dynamic> notificationList) async {
   var readAllEvent = await WENotificationInboxFlutterPlatform.instance.readAll(notificationList);
   return readAllEvent;
  }

  Future<dynamic> unReadAll(List<dynamic> notificationList) async {
    var unreadAllEvent = WENotificationInboxFlutterPlatform.instance.unReadAll(notificationList);
    return unreadAllEvent;
  }

  Future<dynamic> deleteAll(List<dynamic> notificationList) async {
    var deleteAllEvent = await WENotificationInboxFlutterPlatform.instance.deleteAll(notificationList);
    return deleteAllEvent;
  }

  Future<dynamic> resetNotificationCount() async {
    var resetCount = await WENotificationInboxFlutterPlatform.instance.resetNotificationCount();
    return resetCount;
  }
}
