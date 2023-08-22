import Flutter
import UIKit
import WENotificationInbox

public class WeNotificationinboxFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: WEConstants.WE_NOTIFICATIONINBOX_FLUTTER, binaryMessenger: registrar.messenger())
    let instance = WeNotificationinboxFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
        case WEConstants.METHOD_NAME_GET_NOTIFICATION_COUNT:
            getNotificationCount(result: result)
        case WEConstants.METHOD_NAME_GET_NOTIFICATION_LIST:
            if let args = call.arguments as? [String: Any?],let offsetJSON = args[WEConstants.OFFSETJSON] as? String {
                getNotificationList(offsetJSON, result: result)
            }
            getNotificationList(result: result)  
        case WEConstants.METHOD_NAME_MARK_READ:
            if let readMap = call.arguments as? NSDictionary {
                markRead(readMap)
            }
        case WEConstants.METHOD_NAME_MARK_UNREAD:
            if let readMap = call.arguments as? NSDictionary {
                markUnread(readMap)
            }
        case WEConstants.METHOD_NAME_TRACK_CLICK:
            if let readMap = call.arguments as? NSDictionary {
                trackClick(readMap)
            }  
        case WEConstants.METHOD_NAME_TRACK_VIEW:
            if let readMap = call.arguments as? NSDictionary {
                trackView(readMap)
            }
        case WEConstants.METHOD_NAME_MARK_DELETE:
            if let readMap = call.arguments as? NSDictionary {
                markDelete(readMap)
            }
        case WEConstants.METHOD_NAME_READ_ALL:
            if let notificationList = call.arguments as? NSArray {
                readAll(notificationList)
            }
        case WEConstants.METHOD_NAME_UNREAD_ALL:
            if let notificationList = call.arguments as? NSArray {
                unReadAll(notificationList)
            }
        case WEConstants.METHOD_NAME_DELETE_ALL:
            if let notificationList = call.arguments as? NSArray {
                deleteAll(notificationList: notificationList)
            }  
        case WEConstants.METHOD_NAME_RESET_NOTIFICATION_COUNT:
            resetNotificationCount(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
  }

    @objc func getNotificationCount(result: @escaping FlutterResult) {
        WENotificationInbox.shared.getUserNotificationCount { data, error in
            if let count = data {
                result(count)        
            } else {
                if let errorMap = error {
                     self.handleNotificationError(error: errorMap, result)
                }
            }
        }
    }

    @objc func getNotificationList(_ offsetJSON: String? = nil, result: @escaping FlutterResult) {
        var lastInboxMessage: WEInboxMessage? = nil
        if let offset = offsetJSON, let jsonData = offset.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    lastInboxMessage = WEInboxMessage(param: json)
                } else {
                    print("WebEngage-Inbox: Invalid offset JSON")
                }
            } catch {
                print("WebEngage-Inbox: Error parsing JSON - \(error)")
            }
        }
        WENotificationInbox.shared.getNotificationList(lastInboxData: lastInboxMessage) { response, error in
            if let response = response {
                self.handleNotificationListSuccess(response: response, result)
            } else if let error = error {
                self.handleNotificationError(error: error, result)
            }
        }
    }

    @objc func markRead(_ readMap: NSDictionary) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_READ, map: readMap)
    }
    
    @objc func markUnread(_ readMap: NSDictionary) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_UNREAD, map: readMap)
        
    }
    
    @objc func trackClick(_ readMap: NSDictionary) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_TRACK_CLICK, map: readMap)
        
    }
    
    @objc func trackView(_ readMap: NSDictionary) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_TRACK_VIEW, map: readMap)
    }
    
    @objc func markDelete(_ readMap: NSDictionary) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_DELETE, map: readMap)
    }
    
    @objc func readAll(_ notificationList: NSArray) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_READ, notificationList: notificationList)
    }
  
    @objc func unReadAll(_ notificationList: NSArray) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_UNREAD, notificationList: notificationList)
    }
      
    @objc func deleteAll(notificationList: NSArray) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_DELETE_ALL, notificationList: notificationList)
    }

    @objc func resetNotificationCount(result: @escaping FlutterResult) {
        WENotificationInbox.shared.onNotificationIconClick()
    }
    
    private func handleNotificationError(error: WEInboxError, _ result: @escaping FlutterResult) {
        let errorMap: [String: Any] = [
            "error": [
                "response": [
                    "status": error.status,
                    "message": error.localizedDescription
                ]
            ]
        ]
        result(FlutterError(code: "NOTIFICATION_COUNT_ERROR", message: "Notification count error", details: errorMap))
    }

    func handleNotificationListSuccess(response: WEInboxData, _ result: @escaping FlutterResult) {
        let messageList = response.messageList
        let jsonArray = messageList.map { $0.jsonData }
        let jsonString = convertToJsonString(jsonArray: jsonArray)
        let apiResponse: [String: Any] = [WEConstants.HASNEXT: response.hasNextPage, WEConstants.MESSAGELIST: jsonString]
        result(apiResponse)
        
    }

    func convertToJsonString(jsonArray: Any) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("WebEngage-Inbox: Error converting messageListData to JSON: \(error)")
        }
        return ""
    }
}
