import '../../src/we_notificationinbox_flutter_platform_interface.dart';
import '../utils/WELogger.dart';

/// The main entry point for the WebEngage Notification Inbox SDK.
///
/// Use this singleton class to initialize the inbox and perform operations
/// such as fetching notifications, marking them as read/unread, tracking
/// clicks and views, and deleting notifications.
///
/// Example usage:
/// ```dart
/// final inbox = WENotificationInbox();
/// inbox.init(enableLogs: true);
/// final count = await inbox.getNotificationCount();
/// ```
class WENotificationInbox {
  static final WENotificationInbox _singleton = WENotificationInbox._internal();

  /// Returns the singleton instance of [WENotificationInbox].
  factory WENotificationInbox() {
    return _singleton;
  }
  WENotificationInbox._internal();

  /// Initializes the WebEngage Notification Inbox.
  ///
  /// Must be called before using any other inbox methods.
  /// Set [enableLogs] to `true` to enable debug logging.
  void init({bool enableLogs = false}) {
    WELogger.enableLogs(enableLogs); // Enable only in Debug Mode
    WENotificationInboxFlutterPlatform.instance.initNotificationInbox();
  }

  /// Returns the total notification count from the WebEngage Inbox.
  ///
  /// Returns a [WENotificationResponse] with the count on success,
  /// or an error message on failure.
  Future<dynamic> getNotificationCount() async {
    var countMethod = await WENotificationInboxFlutterPlatform.instance.getNotificationCount();
    return countMethod;
  }

  /// Fetches the list of notifications from the WebEngage Inbox.
  ///
  /// Use [offsetJSON] for pagination. Pass the offset from a previous
  /// response to fetch the next page of results. Returns a
  /// [WENotificationResponse] containing the message list and pagination info.
  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    var listMethod = await WENotificationInboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
    return listMethod;
  }

  /// Marks a single notification as read.
  ///
  /// [readMap] should contain the notification data map including its identifier
  /// and current status.
  Future<dynamic> markRead(Map<String, dynamic> readMap) async {
    var readEvent = await WENotificationInboxFlutterPlatform.instance.markRead(readMap);
    return readEvent;
  }

  /// Marks a single notification as unread.
  ///
  /// [readMap] should contain the notification data map including its identifier
  /// and current status.
  Future<dynamic> markUnread(Map<String, dynamic> readMap) async {
    var unReadEvent = await WENotificationInboxFlutterPlatform.instance.markUnread(readMap);
    return unReadEvent;
  }

  /// Tracks a click event on a notification.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> trackClick(Map<String, dynamic> readMap) async {
    var clickEvent = await WENotificationInboxFlutterPlatform.instance.trackClick(readMap);
    return clickEvent;
  }

  /// Tracks a view/impression event on a notification.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> trackView(Map<String, dynamic> readMap) async {
   var viewEvent = await WENotificationInboxFlutterPlatform.instance.trackView(readMap);
   return viewEvent;
  }

  /// Marks a single notification as deleted.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> markDelete(Map<String, dynamic> readMap) async {
    var deleteEvent = await WENotificationInboxFlutterPlatform.instance.markDelete(readMap);
    return deleteEvent;
  }

  /// Marks all notifications in the provided list as read.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> readAll(List<dynamic> notificationList) async {
   var readAllEvent = await WENotificationInboxFlutterPlatform.instance.readAll(notificationList);
   return readAllEvent;
  }

  /// Marks all notifications in the provided list as unread.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> unReadAll(List<dynamic> notificationList) async {
    var unreadAllEvent = await WENotificationInboxFlutterPlatform.instance.unReadAll(notificationList);
    return unreadAllEvent;
  }

  /// Deletes all notifications in the provided list.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> deleteAll(List<dynamic> notificationList) async {
    var deleteAllEvent = await WENotificationInboxFlutterPlatform.instance.deleteAll(notificationList);
    return deleteAllEvent;
  }

  /// Resets the unread notification count.
  ///
  /// Typically called when the user opens the notification inbox UI
  /// to acknowledge that all notifications have been seen.
  Future<dynamic> resetNotificationCount() async {
    var resetCount = await WENotificationInboxFlutterPlatform.instance.resetNotificationCount();
    return resetCount;
  }
}
