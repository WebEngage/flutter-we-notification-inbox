import 'package:flutter/material.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';

class CustomCell extends StatefulWidget {
  final String title;
  final String description;
  final String experimentId;
  String status;
  Map<String, dynamic> inboxMessage;

  Function updateStatus;



  CustomCell(
      {super.key,
      required this.title,
      required this.description,
      required this.experimentId,
      required this.status,
      required this.inboxMessage,
      required this.updateStatus});

  @override
  State<CustomCell> createState() => _CustomCellState();
}

class _CustomCellState extends State<CustomCell> {
  String status = "";
  Map<String, dynamic> inboxMessage = {};
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();

  @override
  void initState() {
    super.initState();
    print("AKC: initState called "+widget.status);
    status = widget.status;
    inboxMessage = Map.from(widget.inboxMessage);
  }

  @override
  bool get wantKeepAlive => true; // Ensure the widget is kept alive


  @override
  Widget build(BuildContext context) {
    print("AKC: building called "+widget.status);
    if(status != widget.status) {
      setState(() {
        status = widget.status;
      });
    }

    // print("AKC: building customCell");
    return Card(
        elevation: 2,
        child: ListTile(
          title: Text(widget.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.description),
              Text('Experiment ID: ${widget.experimentId}'),
              Text('Status: ${status}'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      status.toLowerCase() == "read"
                          ? trackUnread(context)
                          : trackRead(context);
                    },
                    child: status.toLowerCase() == "read" ? Text('Unread') : Text('Read'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackClick(context);
                    },
                    child: Text('Click!!'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackView(context);
                    },
                    child: Text('View'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackDelete(context);
                    },
                    child: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void trackClick(BuildContext context) {
    _weNotificationinboxFlutterPlugin.trackClick(inboxMessage);
    showAlertDialog(context, "Click tracked",
        "Click has been tracked for this notification.");
  }

  void trackView(BuildContext context) {
    _weNotificationinboxFlutterPlugin.trackView(inboxMessage);
    showAlertDialog(context, "View tracked",
        "View has been tracked for this notification.");
  }

  void trackDelete(BuildContext context) {
    _weNotificationinboxFlutterPlugin.markDelete(inboxMessage);
    showAlertDialog(context, "Marked as Deleted",
        "This notification has been marked as deleted.");
  }

  void trackRead(BuildContext context) {
    print("AKC: Current Status $status \n marking it as : READ \n inboxMessage.status ${inboxMessage["status"]}");
    print("-----------------------------------------------");

    _weNotificationinboxFlutterPlugin.markRead(inboxMessage);
    widget.updateStatus("read");

    setState(() {
      // status = "READ";
      inboxMessage["status"] = "read";
    });

    // showAlertDialog(context, "Marked as Read",
    //     "This notification has been marked as read.");
    // status = "UNREAD";

  }

  void trackUnread(BuildContext context) {
    print("AKC: Current Status $status \n marking it as : UNREAD \n inboxMessage.status ${inboxMessage["status"]}");
    print("-----------------------------------------------");

    _weNotificationinboxFlutterPlugin.markUnread(inboxMessage);
    widget.updateStatus("unread");

    // showAlertDialog(context, "Marked as Unread",
    //     "This notification has been marked as unread.");
    // status = "READ";

    setState(() {
      // status = "UNREAD";
      inboxMessage["status"] = "unread";

    });
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
