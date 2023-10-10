import '../../src/we_notificationinbox_flutter_platform_interface.dart';
import '../utils/WELogger.dart';

class WENotificationInbox {
  static final WENotificationInbox _singleton = WENotificationInbox._internal();

  factory WENotificationInbox() {
    return _singleton;
  }
  WENotificationInbox._internal();

  void init({bool enableLogs = false}) {
    WELogger.enableLogs(enableLogs);
    WeNotificationinboxFlutterPlatform.instance.initNotificationInbox();
  }

  Future<dynamic> getNotificationCount() async{
    var countMethod = await WeNotificationinboxFlutterPlatform.instance.getNotificationCount();
    return countMethod;
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    var listMethod = await WeNotificationinboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
    return listMethod;

  }

  Future<dynamic> markRead(Map<String, dynamic> readMap) async {
    var readEvent = await WeNotificationinboxFlutterPlatform.instance.markRead(readMap);
    return readEvent;
  }

  Future<dynamic> markUnread(Map<String, dynamic> readMap) async {
    var unReadEvent = await WeNotificationinboxFlutterPlatform.instance.markUnread(readMap);
    return unReadEvent;
  }

  Future<dynamic> trackClick(Map<String, dynamic> readMap) async {
    var clickEvent = await WeNotificationinboxFlutterPlatform.instance.trackClick(readMap);
    return clickEvent;
  }

  Future<dynamic> trackView(Map<String, dynamic> readMap) async {
   var viewEvent = await WeNotificationinboxFlutterPlatform.instance.trackView(readMap);
   return viewEvent;
  }

  Future<dynamic> markDelete(Map<String, dynamic> readMap) async {
    var deleteEvent = await WeNotificationinboxFlutterPlatform.instance.markDelete(readMap);
    return deleteEvent;
  }

  Future<dynamic> readAll(List<dynamic> notificationList) async {
   var readAllEvent = await WeNotificationinboxFlutterPlatform.instance.readAll(notificationList);
   return readAllEvent;
  }

  Future<dynamic> unReadAll(List<dynamic> notificationList) async {
    var unreadAllEvent = WeNotificationinboxFlutterPlatform.instance.unReadAll(notificationList);
    return unreadAllEvent;
  }

  Future<dynamic> deleteAll(List<dynamic> notificationList) async {
    var deleteAllEvent = await WeNotificationinboxFlutterPlatform.instance.deleteAll(notificationList);
    return deleteAllEvent;
  }

  Future<dynamic> resetNotificationCount() async {
    var resetCount = await WeNotificationinboxFlutterPlatform.instance.resetNotificationCount();
    return resetCount;
  }
}
