import Flutter
import UIKit
import WENotificationInbox
import WebEngage

public class WENotificationInboxFlutterPlugin: NSObject, FlutterPlugin {

  static let WEGPluginVersion: String = "1.0.0"
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: WEConstants.WE_NOTIFICATIONINBOX_FLUTTER, binaryMessenger: registrar.messenger())
    let instance = WENotificationInboxFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
        case WEConstants.METHOD_NAME_INIT:
            WELogger.initLogger()
            WELogger.d("WE-NI I \(call.method) \(String(describing: call.arguments))")
            WENotificationInbox.initialize()
            initialiseWEGVersion()
        case WEConstants.METHOD_NAME_GET_NOTIFICATION_COUNT:
            WENotification.shared.getNotificationCount(result: result)
        case WEConstants.METHOD_NAME_GET_NOTIFICATION_LIST:
            if let args = call.arguments as? [String: Any?],let offsetJSON = args[WEConstants.OFFSETJSON] as? String {
                WENotification.shared.getNotificationList(offsetJSON, result: result)
            } else {
                WENotification.shared.getNotificationList(result: result)
            }
        case WEConstants.METHOD_NAME_MARK_READ:
            if let readMap = call.arguments as? NSDictionary {
                WENotification.shared.markRead(readMap, result: result)
            }
        case WEConstants.METHOD_NAME_MARK_UNREAD:
            if let readMap = call.arguments as? NSDictionary {
                WENotification.shared.markUnread(readMap, result: result)
            }
        case WEConstants.METHOD_NAME_TRACK_CLICK:
            if let readMap = call.arguments as? NSDictionary {
                WENotification.shared.trackClick(readMap, result: result)
            }
        case WEConstants.METHOD_NAME_TRACK_VIEW:
            if let readMap = call.arguments as? NSDictionary {
                WENotification.shared.trackView(readMap, result: result)
            }
        case WEConstants.METHOD_NAME_MARK_DELETE:
            if let readMap = call.arguments as? NSDictionary {
                WENotification.shared.markDelete(readMap, result: result)
            }
        case WEConstants.METHOD_NAME_READ_ALL:
            if let notificationList = call.arguments as? NSArray {
                WENotification.shared.readAll(notificationList, result: result)
            }
        case WEConstants.METHOD_NAME_UNREAD_ALL:
            if let notificationList = call.arguments as? NSArray {
                WENotification.shared.unReadAll(notificationList, result: result)
            }
        case WEConstants.METHOD_NAME_DELETE_ALL:
            if let notificationList = call.arguments as? NSArray {
                WENotification.shared.deleteAll(notificationList: notificationList, result: result)
            }
        case WEConstants.METHOD_NAME_RESET_NOTIFICATION_COUNT:
                WENotification.shared.resetNotificationCount(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
  }
  
  func initialiseWEGVersion() {
        let key: WegVersionKey = .FLNI
      WebEngage.sharedInstance().setVersionForChildSDK(WENotificationInboxFlutterPlugin.WEGPluginVersion, for: key)
   }
}
