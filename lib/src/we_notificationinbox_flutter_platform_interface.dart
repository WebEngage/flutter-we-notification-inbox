import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'we_notificationinbox_flutter_method_channel.dart';

abstract class WeNotificationinboxFlutterPlatform extends PlatformInterface {
  WeNotificationinboxFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WeNotificationinboxFlutterPlatform _instance =
      MethodChannelWeNotificationinboxFlutter();

  static WeNotificationinboxFlutterPlatform get instance => _instance;

  static set instance(WeNotificationinboxFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> initNotificationInbox() {
    throw UnimplementedError(
        'initNotificationInbox() has not been implemented.');
  }

  Future<String> getNotificationCount() {
    throw UnimplementedError(
        'getNotificationCount() has not been implemented.');
  }

  Future<dynamic> getNotificationList({dynamic offsetJSON}) {
    throw UnimplementedError('getNotificationList() has not been implemented.');
  }

  Future<void> markRead(Map<String, dynamic> readMap) {
    throw UnimplementedError('markRead() has not been implemented.');
  }

  Future<void> markUnread(Map<String, dynamic> readMap) {
    throw UnimplementedError('markUnread() has not been implemented.');
  }

  Future<void> trackClick(Map<String, dynamic> readMap) {
    throw UnimplementedError('trackClick() has not been implemented.');
  }

  Future<void> trackView(Map<String, dynamic> readMap) {
    throw UnimplementedError('trackView() has not been implemented.');
  }

  Future<void> markDelete(Map<String, dynamic> readMap) {
    throw UnimplementedError('markDelete() has not been implemented.');
  }

  Future<void> readAll(List<dynamic> notificationList) {
    throw UnimplementedError('readAll() has not been implemented.');
  }

  Future<void> unReadAll(List<dynamic> notificationList) {
    throw UnimplementedError('unReadAll() has not been implemented.');
  }

  Future<void> deleteAll(List<dynamic> notificationList) {
    throw UnimplementedError('deleteAll() has not been implemented.');
  }

  Future<void> resetNotificationCount() {
    throw UnimplementedError(
        'resetNotificationCount() has not been implemented.');
  }
}
