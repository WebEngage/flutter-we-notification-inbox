import Flutter
import WENotificationInbox

class WENotification{
    
    
    private init(){}
    
    static let shared = WENotification()

     @objc func getNotificationCount(result: @escaping FlutterResult) {
        WENotificationInbox.shared.getUserNotificationCount { data, error in
            if let count = data {
                WELogger.d("WebEngage-inbox count - \(count)");
                result(count)
            } else {
                if let errorMap = error {
                    WELogger.d("WebEngage-inbox getNotificationCount - error_code: $errorCode \n Error -  \(String(describing: error))")
                     self.handleNotificationCountError(error: errorMap, result)
                }
            }
        }
    }

    @objc func getNotificationList(_ offsetJSON: String? = nil, result: @escaping FlutterResult) {
        var lastInboxMessage: WEInboxMessage? = nil
        if offsetJSON != WEConstants.NULL {
        if let offset = offsetJSON, let jsonData = offset.data(using: .utf8) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        lastInboxMessage = WEInboxMessage(param: json)
                    } else {
                        let errorResponse = ["error": "JSON parsing failed"]
                        result(FlutterError(code: "JSON_PARSE_ERROR", message: "Failed to parse JSON", details: errorResponse))
                    }
                } catch {
                    let errorResponse = ["error": "JSON parsing error"]
                    WELogger.d("WebEngage-inbox Exception while parsing json data to WEInboxData $e");
                    result(FlutterError(code: "JSON_PARSE_ERROR", message: "Error parsing JSON", details: errorResponse))
                }
            }
        }
        WENotificationInbox.shared.getNotificationList(lastInboxData: lastInboxMessage) { response, error in
            if let response = response {
                self.handleNotificationListSuccess(response: response, result)
            } else if let error = error {
                WELogger.d("WebEngage-inbox  getNotificationList - error_code: $errorCode \n Error - \(error)")
                self.handleNotificationListError(error: error, result)
            }
        }
    }

    @objc func markRead(_ readMap: NSDictionary,result: @escaping FlutterResult) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_READ, map: readMap)
        result(nil)
    }
    
    @objc func markUnread(_ readMap: NSDictionary, result: @escaping FlutterResult) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_UNREAD, map: readMap)
        result(nil)
    }
    
    @objc func trackClick(_ readMap: NSDictionary, result: @escaping FlutterResult) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_TRACK_CLICK, map: readMap)
        result(nil)
    }
    
    @objc func trackView(_ readMap: NSDictionary, result: @escaping FlutterResult) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_TRACK_VIEW, map: readMap)
        result(nil)
    }
    
    @objc func markDelete(_ readMap: NSDictionary, result: @escaping FlutterResult) {
        WENIHelper.shared.handleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_DELETE, map: readMap)
        result(nil)
    }
    
    @objc func readAll(_ notificationList: NSArray, result: @escaping FlutterResult) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_READ, notificationList: notificationList)
        result(nil)
    }
  
    @objc func unReadAll(_ notificationList: NSArray, result: @escaping FlutterResult) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_MARK_UNREAD, notificationList: notificationList)
        result(nil)
    }
      
    @objc func deleteAll(notificationList: NSArray, result: @escaping FlutterResult) {
        WENIHelper.shared.handleMultipleInboxEvent(event_name: WEConstants.METHOD_NAME_DELETE_ALL, notificationList: notificationList)
        result(nil)
    }

    @objc func resetNotificationCount(result: @escaping FlutterResult) {
        WENotificationInbox.shared.onNotificationIconClick()
        result(nil)
    }
    
    private func handleNotificationListError(error: WEInboxError, _ result: @escaping FlutterResult) {
         let errorCode:String = "\(error.code)"
        result(FlutterError(code: errorCode, message: "Notification List: Resource Fetching failed", details: error))
    }
    
    private func handleNotificationCountError(error: WEInboxError, _ result: @escaping FlutterResult) {
        let errorCode:String = "\(error.code)"
        result(FlutterError(code: errorCode, message: "Notification Count: Resource Fetching failed", details: error))
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
