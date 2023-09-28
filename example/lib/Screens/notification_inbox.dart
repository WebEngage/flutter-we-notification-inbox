import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:we_notificationinbox_flutter/utils/WELogger.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import '../Models/CustomCell.dart';
import '../Models/cell_model.dart';

class NotificationInbox extends StatefulWidget {
  const NotificationInbox({super.key});

  @override
  _NotificationInboxState createState() => _NotificationInboxState();
}

class _NotificationInboxState extends State<NotificationInbox> {
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();
  List<dynamic> _notificationList = [];
  List<CellData> cellDataList = [];
  bool _hasNextPage = false;
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchNotificationList();
    // Add a listener to the ScrollController
    _scrollController.addListener(() {
      // Check if we have reached the end of the list
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // This means we have scrolled to the end of the list
        // You can perform your desired action here.
        // print("Reached the last cell!!!!!!!!");
        if (_hasNextPage) {
          setState(() {
            _isLoading = true;
          });
          fetchNext();
        } else {
          print("========End of the List=========");
        }
      }
    });
  }

  Future<void> fetchNotificationList() async {
    try {
      var notificationList =
          await _weNotificationinboxFlutterPlugin.getNotificationList();
      WELogger.v("WebEngage AKC: fetch list - $notificationList");
      handleSuccess(notificationList);
    } catch (error) {
      throw error;
    } finally {
      setState(() {
        _isLoading = false; // Fetching is complete, set loading to false
      });
    }
  }

  Future<void> fetchNext() async {
    Map<String, dynamic> notificationList;
    // var offset = _notificationList[0];
    var offset = _notificationList[_notificationList.length - 1];
    WELogger.v("WebEngage List Fetching with offset - $offset");

    try {
      notificationList = await _weNotificationinboxFlutterPlugin
          .getNotificationList(offsetJSON: offset);
      WELogger.v("WebEngage List with offset - $notificationList");

      handleSuccess(notificationList, isFetchMore: true);
    } catch (error) {
      rethrow;
    } finally {
      setState(() {
        _isLoading = false; // Fetching is complete, set loading to false
      });
    }
  }

  void updateCellDataList(int index, String newStatus) {
    // print("AKC: updateCellDataList - ${cellDataList[index].status} to $newStatus");
    setState(() {
      _notificationList[index]["status"] = newStatus;
    });
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
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_notificationList.isNotEmpty)
            ListView.builder(
              controller: _scrollController,
              itemCount: _notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                final notificationItem = _notificationList[index];
                final Map<String, dynamic> message =
                    notificationItem["message"] ?? {};
                final String title = message["title"] ?? "";
                final String description = message["message"] ?? "";
                final String experimentId =
                    notificationItem["experimentId"] ?? "";
                final String status = notificationItem["status"] ?? "";
                return CustomCell(
                    title: title,
                    description: description,
                    experimentId: experimentId,
                    status: status,
                    inboxMessage: notificationItem,
                    updateStatus: (newStatus) {
                      updateCellDataList(index, newStatus);
                    });
              },
            )
          else if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (!_isLoading)
            const Center(
              child: Text("Sorry! You don't have any List available!"),
            ),
          if (_isLoading && _notificationList.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: _isLoading
                  ? Container(
                      color: Colors.black.withOpacity(0.1),
                      child: Center(
                        child: Transform.scale(
                          scale:
                              2.0, // Increase the scale value to increase the size
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : const SizedBox
                      .shrink(), // Hide the spinner when not loading
              // Hide the spinner when not loading
            ),
        ],
      ),
    );
  }

  void showToastMessage() {
    Fluttertoast.showToast(
      msg: "You have reached the end of the message list!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void handleMenuItemSelected(BuildContext context, String value) {
    switch (value) {
      case 'readAll':
        var _cloneNotificationList = _notificationList;
        _weNotificationinboxFlutterPlugin.readAll(_notificationList);

        // for(var i=0; i<cellDataList.length;i++) {
        //   updateCellDataList(i,"read");
        // }
        for (var i = 0; i < _cloneNotificationList.length; i++) {
          print("AKC NI ${_cloneNotificationList[i]["status"]}");
          _cloneNotificationList[i]["status"] = "READ";
        }
        setState(() {
          _notificationList = _cloneNotificationList;
        });
        break;
      case 'unreadAll':
        var _cloneNotificationList = _notificationList;
        _weNotificationinboxFlutterPlugin.unReadAll(_notificationList);
        // for(var i=0; i<cellDataList.length;i++) {
        //   updateCellDataList(i,"unread");
        // }

        for (var i = 0; i < _cloneNotificationList.length; i++) {
          print("AKC NI ${_cloneNotificationList[i]["status"]}");

          _cloneNotificationList[i]["status"] = "UNREAD";
        }
        setState(() {
          _notificationList = _cloneNotificationList;
        });
        break;
      case 'deleteAll':
        _weNotificationinboxFlutterPlugin.deleteAll(_notificationList);
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
    if (!hasNextPage && _notificationList.length > 0) {
      showToastMessage();
    }

    setState(() {
      _notificationList.addAll(notificationItems);
      _hasNextPage = hasNextPage;
    });
  }
}
