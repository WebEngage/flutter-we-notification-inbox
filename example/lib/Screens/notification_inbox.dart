import 'package:flutter/material.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import '../Models/CustomCell.dart';
import '../Models/cell_model.dart';

class NotificationInbox extends StatefulWidget {
  @override
  _NotificationInboxState createState() => _NotificationInboxState();
}

class _NotificationInboxState extends State<NotificationInbox> {
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();
  List<dynamic> _notificationList = [];
  List<CellData> cellDataList = [];
  bool _hasNextPage = false;

  @override
  void initState() {
    super.initState();
    fetchNotificationList();
  }

  Future<void> fetchNotificationList() async {
    Map<String, dynamic> notificationList;
    try {
      notificationList =
          await _weNotificationinboxFlutterPlugin.getNotificationList();
      handleSuccess(notificationList);
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchNext() async {
    Map<String, dynamic> notificationList;
    var offset = _notificationList[_notificationList.length - 1];
    try {
      notificationList = await _weNotificationinboxFlutterPlugin
          .getNotificationList(offsetJSON: offset);
      print("Fetched more");
      handleSuccess(notificationList, isFetchMore: true);
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationInbox'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              handleMenuItemSelected(context, value);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'readAll',
                child: Text('Read All'),
              ),
              const PopupMenuItem<String>(
                value: 'unreadAll',
                child: Text('Unread All'),
              ),
              const PopupMenuItem<String>(
                value: 'deleteAll',
                child: Text('Delete All'),
              ),
              const PopupMenuItem<String>(
                value: 'fetchMore',
                child: Text('Fetch More'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cellDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCell(
            title: cellDataList[index].title,
            description: cellDataList[index].description,
            experimentId: cellDataList[index].experimentId,
            status: cellDataList[index].status,
            inboxMessage: cellDataList[index].inboxMessage,
          );
        },
      ),
    );
  }

  void handleMenuItemSelected(BuildContext context, String value) {
    switch (value) {
      case 'readAll':
        _weNotificationinboxFlutterPlugin.readAll(_notificationList);
        break;
      case 'unreadAll':
        _weNotificationinboxFlutterPlugin.unReadAll(_notificationList);
        break;
      case 'deleteAll':
        _weNotificationinboxFlutterPlugin.deleteAll(_notificationList);
        break;
      case 'fetchMore':
        if (_hasNextPage) {
          fetchNext();
        }
        break;
    }
  }

  Future<void> handleSuccess(Map<String, dynamic> notificationList,
      {bool isFetchMore = false}) async {
    List<dynamic> notificationItems =
        List<dynamic>.from(notificationList['messageList']);
    var hasNextPage = (notificationList['hasNext']);

    if (isFetchMore) {
      cellDataList.clear();
    }

    notificationItems.map((notificationItem) {
      final String status = notificationItem['status'] ?? '';
      final Map<String, dynamic> message = notificationItem['message'] ?? {};
      final String title = message['title'] ?? '';
      final String description = message['message'] ?? '';
      final String experimentId = notificationItem['experimentId'] ?? '';

      cellDataList.add(
        CellData(
            title: title,
            description: description,
            experimentId: experimentId,
            status: status,
            inboxMessage: notificationItem),
      );
    }).toList();
    setState(() {
      _notificationList = notificationItems;
      _hasNextPage = hasNextPage;
    });
  }
}
