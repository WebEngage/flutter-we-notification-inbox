/// WebEngage Notification Inbox plugin for Flutter.
///
/// This library provides access to the WebEngage Notification Inbox,
/// allowing you to fetch, manage, and track in-app notification messages.
library we_notificationinbox_flutter;

export 'package:we_notificationinbox_flutter/src/WENotificationInbox.dart';
export 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_method_channel.dart';
import 'src/we_notificationinbox_flutter_platform_interface.dart';

/// Primary class for interacting with the WebEngage Notification Inbox.
///
/// Provides methods to fetch notification counts, retrieve notification lists,
/// and perform actions such as marking notifications as read, unread, or deleted.
class WENotificationinboxFlutter {
  /// Returns the total notification count from the WebEngage Inbox.
  ///
  /// Returns a [WENotificationResponse] with the count on success,
  /// or an error message on failure.
  Future<dynamic> getNotificationCount() async {
    var notificationCount = await WENotificationInboxFlutterPlatform.instance
        .getNotificationCount();
    return notificationCount;
  }

  /// Fetches the list of notifications from the WebEngage Inbox.
  ///
  /// Use [offsetJSON] for pagination. Pass the offset from a previous
  /// response to fetch the next page of results.
  Future<dynamic> getNotificationList({dynamic offsetJSON}) async {
    var notificationList = await WENotificationInboxFlutterPlatform.instance
        .getNotificationList(offsetJSON: offsetJSON);
    return notificationList;
  }

  /// Marks a single notification as read.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> markRead(Map<String, dynamic> readMap) async {
    var readEvent =
        await WENotificationInboxFlutterPlatform.instance.markRead(readMap);
    return readEvent;
  }

  /// Marks a single notification as unread.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> markUnread(Map<String, dynamic> readMap) async {
    var unReadEvent =
        await WENotificationInboxFlutterPlatform.instance.markUnread(readMap);
    return unReadEvent;
  }

  /// Tracks a click event on a notification.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> trackClick(Map<String, dynamic> readMap) async {
    var clickEvent =
        await WENotificationInboxFlutterPlatform.instance.trackClick(readMap);
    return clickEvent;
  }

  /// Tracks a view/impression event on a notification.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> trackView(Map<String, dynamic> readMap) async {
    var viewEvent =
        await WENotificationInboxFlutterPlatform.instance.trackView(readMap);
    return viewEvent;
  }

  /// Marks a single notification as deleted.
  ///
  /// [readMap] should contain the notification data map including its identifier.
  Future<dynamic> markDelete(Map<String, dynamic> readMap) async {
    var deleteEvent =
        await WENotificationInboxFlutterPlatform.instance.markDelete(readMap);
    return deleteEvent;
  }

  /// Marks all notifications in the provided list as read.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> readAll(List<dynamic> notificationList) async {
    var readAllEvent = await WENotificationInboxFlutterPlatform.instance
        .readAll(notificationList);
    return readAllEvent;
  }

  /// Marks all notifications in the provided list as unread.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> unReadAll(List<dynamic> notificationList) async {
    var unreadAllEvent = await WENotificationInboxFlutterPlatform.instance
        .unReadAll(notificationList);
    return unreadAllEvent;
  }

  /// Deletes all notifications in the provided list.
  ///
  /// [notificationList] should contain a list of notification data maps.
  Future<dynamic> deleteAll(List<dynamic> notificationList) async {
    var deleteAllEvent = await WENotificationInboxFlutterPlatform.instance
        .deleteAll(notificationList);
    return deleteAllEvent;
  }

  /// Resets the unread notification count.
  ///
  /// Typically called when the user opens the notification inbox UI.
  Future<dynamic> resetNotificationCount() async {
    var resetCount =
        await WENotificationInboxFlutterPlatform.instance.resetNotificationCount();
    return resetCount;
  }
}
