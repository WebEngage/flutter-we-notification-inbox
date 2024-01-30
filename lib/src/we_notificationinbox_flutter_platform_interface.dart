import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'we_notificationinbox_flutter_method_channel.dart';

abstract class WENotificationInboxFlutterPlatform extends PlatformInterface {
  WENotificationInboxFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WENotificationInboxFlutterPlatform _instance =
      MethodChannelWeNotificationinboxFlutter();

  static WENotificationInboxFlutterPlatform get instance => _instance;

  static set instance(WENotificationInboxFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initNotificationInbox() {
    throw UnimplementedError(
        'webengage-inbox: initNotificationInbox() has not been implemented.');
  }

  Future<dynamic> getNotificationCount() {
    throw UnimplementedError(
        'webengage-inbox: getNotificationCount() has not been implemented.');
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) {
    throw UnimplementedError(
        'webengage-inbox: getNotificationList() has not been implemented.');
  }

  Future<void> markRead(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markRead() has not been implemented.');
  }

  Future<void> markUnread(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markUnread() has not been implemented.');
  }

  Future<void> trackClick(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: trackClick() has not been implemented.');
  }

  Future<void> trackView(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: trackView() has not been implemented.');
  }

  Future<void> markDelete(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markDelete() has not been implemented.');
  }

  Future<void> readAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: readAll() has not been implemented.');
  }

  Future<void> unReadAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: unReadAll() has not been implemented.');
  }

  Future<void> deleteAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: deleteAll() has not been implemented.');
  }

  Future<void> resetNotificationCount() {
    throw UnimplementedError(
        'webengage-inbox: resetNotificationCount() has not been implemented.');
  }
}
