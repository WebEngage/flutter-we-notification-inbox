import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'we_notificationinbox_flutter_method_channel.dart';

/// The platform interface for the WebEngage Notification Inbox Flutter plugin.
///
/// This abstract class defines the contract that platform-specific
/// implementations must fulfill. It uses [PlatformInterface] to ensure
/// that implementations extend rather than implement this class.
abstract class WENotificationInboxFlutterPlatform extends PlatformInterface {
  /// Constructs a [WENotificationInboxFlutterPlatform].
  WENotificationInboxFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WENotificationInboxFlutterPlatform _instance =
      MethodChannelWeNotificationinboxFlutter();

  /// The current platform-specific implementation instance.
  static WENotificationInboxFlutterPlatform get instance => _instance;

  /// Sets the platform-specific implementation to use.
  ///
  /// Platform-specific implementations should set this with their own
  /// class that extends [WENotificationInboxFlutterPlatform] during registration.
  static set instance(WENotificationInboxFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the notification inbox on the native platform.
  Future<bool> initNotificationInbox() {
    throw UnimplementedError(
        'webengage-inbox: initNotificationInbox() has not been implemented.');
  }

  /// Fetches the total unread notification count.
  Future<dynamic> getNotificationCount() {
    throw UnimplementedError(
        'webengage-inbox: getNotificationCount() has not been implemented.');
  }

  /// Fetches the notification list with optional pagination via [offsetJSON].
  Future<dynamic> getNotificationList({dynamic offsetJSON}) {
    throw UnimplementedError(
        'webengage-inbox: getNotificationList() has not been implemented.');
  }

  /// Marks a notification as read using the provided [readMap].
  Future<void> markRead(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markRead() has not been implemented.');
  }

  /// Marks a notification as unread using the provided [readMap].
  Future<void> markUnread(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markUnread() has not been implemented.');
  }

  /// Tracks a click event on a notification using the provided [readMap].
  Future<void> trackClick(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: trackClick() has not been implemented.');
  }

  /// Tracks a view event on a notification using the provided [readMap].
  Future<void> trackView(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: trackView() has not been implemented.');
  }

  /// Marks a notification as deleted using the provided [readMap].
  Future<void> markDelete(Map<String, dynamic> readMap) {
    throw UnimplementedError(
        'webengage-inbox: markDelete() has not been implemented.');
  }

  /// Marks all notifications in [notificationList] as read.
  Future<void> readAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: readAll() has not been implemented.');
  }

  /// Marks all notifications in [notificationList] as unread.
  Future<void> unReadAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: unReadAll() has not been implemented.');
  }

  /// Deletes all notifications in [notificationList].
  Future<void> deleteAll(List<dynamic> notificationList) {
    throw UnimplementedError(
        'webengage-inbox: deleteAll() has not been implemented.');
  }

  /// Resets the unread notification count on the native platform.
  Future<void> resetNotificationCount() {
    throw UnimplementedError(
        'webengage-inbox: resetNotificationCount() has not been implemented.');
  }
}
