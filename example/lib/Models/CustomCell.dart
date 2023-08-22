import 'package:flutter/material.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';

class CustomCell extends StatelessWidget {
  final String title;
  final String description;
  final String experimentId;
  String status;
  final Map<String, dynamic> inboxMessage;
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();

  CustomCell(
      {super.key,
      required this.title,
      required this.description,
      required this.experimentId,
      required this.status,
      required this.inboxMessage});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ListTile(
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              Text('Experiment ID: $experimentId'),
              Text('Status: $status'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      status == "READ"
                          ? trackUnread(context, inboxMessage)
                          : trackRead(context, inboxMessage);
                    },
                    child: Text('Unread/Read'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackClick(context, inboxMessage);
                    },
                    child: Text('Click'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackView(context, inboxMessage);
                    },
                    child: Text('View'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      trackDelete(context, inboxMessage);
                    },
                    child: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void trackClick(BuildContext context, Map<String, dynamic> inboxMessage) {
    _weNotificationinboxFlutterPlugin.trackClick(inboxMessage);
    showAlertDialog(context, "Click tracked",
        "Click has been tracked for this notification.");
  }

  void trackView(BuildContext context, Map<String, dynamic> inboxMessage) {
    _weNotificationinboxFlutterPlugin.trackView(inboxMessage);
    showAlertDialog(context, "View tracked",
        "View has been tracked for this notification.");
  }

  void trackDelete(BuildContext context, Map<String, dynamic> inboxMessage) {
    _weNotificationinboxFlutterPlugin.markDelete(inboxMessage);
    showAlertDialog(context, "Marked as Deleted",
        "This notification has been marked as deleted.");
  }

  void trackRead(BuildContext context, Map<String, dynamic> inboxMessage) {
    _weNotificationinboxFlutterPlugin.markRead(inboxMessage);
    showAlertDialog(context, "Marked as Read",
        "This notification has been marked as read.");
    status = "UNREAD";
  }

  void trackUnread(BuildContext context, Map<String, dynamic> inboxMessage) {
    _weNotificationinboxFlutterPlugin.markUnread(inboxMessage);
    showAlertDialog(context, "Marked as Unread",
        "This notification has been marked as unread.");
    status = "READ";
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
