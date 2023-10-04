package com.webengage.we_notificationinbox_flutter

import android.content.Context
import com.webengage.notification.inbox.WENotificationInbox.Companion.get
import com.webengage.notification.inbox.callbacks.WEInboxCallback
import com.webengage.notification.inbox.data.models.PushNotificationTemplateData
import com.webengage.notification.inbox.data.models.WEInboxData
import com.webengage.notification.inbox.data.models.WEInboxMessage
import com.webengage.notification.inbox.data.models.WEInboxMessageData
import com.webengage.notification.inbox.utils.WENIHelper.Companion.getInstance
import com.webengage.notification.inbox.utils.WEUtils.toMap
import com.webengage.sdk.android.Logger
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

class WENotification : WEInboxCallback<WEInboxData> {
    private lateinit var context: Context;
    private var listResultCallback: MethodChannel.Result? = null
    var helper = getInstance()


    fun initialization() {
        // Available for Future Initialization
        // Should work without Initialization as well
    }

    fun attachContext(flutterContext: Context) {
        context = flutterContext
    }

    fun getNotificationCount(result: MethodChannel.Result) {
        get(context).getUserNotificationCount(context, object : WEInboxCallback<String> {
            override fun onSuccess(counter: String) {
                Logger.d("WebEngage-inbox"," count - "+counter);
                result.success(counter)
            }

            override fun onError(errorCode: Int, error: Map<String, Any?>) {
                Logger.e(Constants.TAG, "count - error: $errorCode while fetching Count \n$error")
                result.error(errorCode.toString(), "Error!", error)
            }

        })
    }

    @Throws(JSONException::class)
    fun convertToWEInboxMessage(jsonObject: JSONObject): WEInboxMessage {
        var childExperimentId: String? = ""
        var childVariationId: String? = ""
        val experimentId = jsonObject.getString("experimentId")
        val variationId = jsonObject.getString("variationId")
        val status = jsonObject.getString("status")
        val channelType = jsonObject.getString("channelType")
        val creationTime = jsonObject.getString("creationTime")
        val scope = jsonObject.getString("scope")
        val category = jsonObject.getString("category")
        if (jsonObject.has("childExperimentId")) {
            childExperimentId = jsonObject.getString("childExperimentId")
        }
        if (jsonObject.has("childVariationId")) {
            childVariationId = jsonObject.getString("childVariationId")
        }
        val resultMap = toMap(jsonObject.getJSONObject("message"))
        val msg: WEInboxMessageData = PushNotificationTemplateData(java.util.HashMap(resultMap))
        return WEInboxMessage(
            experimentId,
            variationId,
            status,
            channelType,
            childExperimentId,
            childVariationId,
            creationTime,
            scope,
            category,
            msg,
            jsonObject
        )
    }

    fun getNotificationList(hashMap: HashMap<String, *>, result: MethodChannel.Result) {
        listResultCallback = result
        val jsonString: String? = hashMap["offsetJSON"] as String

        if (jsonString == null || jsonString == "null") {
            get(context).getNotificationList(context, this)
        } else {
            val jsonObject: JSONObject = JSONObject(jsonString)
            val weInboxMessage: WEInboxMessage = convertToWEInboxMessage(
                jsonObject
            )
            // call api with offset
            get(context).getNotificationList(context, weInboxMessage, this)
        }
    }

    fun markRead(hashMap: HashMap<String, String>) {
        helper.handleInboxEvent(Constants.METHOD_NAME_MARK_READ, hashMap)
    }

    fun markUnread(hashMap: HashMap<String, String>) {
        helper.handleInboxEvent(Constants.METHOD_NAME_MARK_UNREAD, hashMap)
    }

    fun trackClick(hashMap: HashMap<String, String>) {
        helper.handleInboxEvent(Constants.METHOD_NAME_TRACK_CLICK, hashMap)
    }

    fun trackView(hashMap: HashMap<String, String>) {
        helper.handleInboxEvent(Constants.METHOD_NAME_TRACK_VIEW, hashMap)
    }

    fun markDelete(hashMap: HashMap<String, String>) {
        helper.handleInboxEvent(Constants.METHOD_NAME_MARK_DELETE, hashMap)
    }

    fun readAll(messageList: List<HashMap<String, String>>) {
        helper.handleMultipleInboxEvent(Constants.METHOD_NAME_MARK_READ, messageList)
    }

    fun unReadAll(messageList: List<HashMap<String, String>>) {
        helper.handleMultipleInboxEvent(Constants.METHOD_NAME_MARK_UNREAD, messageList)
    }

    fun deleteAll(messageList: List<HashMap<String, String>>) {
        helper.handleMultipleInboxEvent(Constants.METHOD_NAME_DELETE_ALL, messageList)
    }

    fun resetNotificationCount() {
//        get(context).onNotificationIconClick()
    }

    private fun convertJsonToWriteableMap(weInboxData: WEInboxData): Map<String, Any>? {
        val jsonArray = JSONArray()
        for (weInboxMessage in weInboxData.messageList) {
            val jsonData: JSONObject = weInboxMessage.jsonData
            try {
                val jsonObject = JSONObject(jsonData.toString())
                jsonArray.put(jsonObject)
            } catch (e: JSONException) {
                e.printStackTrace()
            }
        }
        return mapOf<String, Any>(
            "hasNext" to weInboxData.hasNext,
            "messageList" to jsonArray.toString(),
        )
    }

    override fun onSuccess(result: WEInboxData) {
        val dataMap: Map<String, Any>? = convertJsonToWriteableMap(result)
        if (listResultCallback == null) {
            Logger.e(Constants.TAG, "listResultCallback: callback not attached $dataMap ")
        } else {
            listResultCallback?.success(dataMap)
        }
    }

    override fun onError(errorCode: Int, error: Map<String, Any?>) {
        Logger.e(Constants.TAG, "List - error: $errorCode while fetching Count \n$error")
        listResultCallback?.error(errorCode.toString(), "error_message_to_be_added", error)
    }
}