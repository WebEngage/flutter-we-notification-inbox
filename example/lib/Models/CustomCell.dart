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
    status = widget.status;
    inboxMessage = Map.from(widget.inboxMessage);
  }

  @override
  bool get wantKeepAlive => true; // Ensure the widget is kept alive

  @override
  Widget build(BuildContext context) {
    if (status != widget.status) {
      setState(() {
        status = widget.status;
      });
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      color: Colors.grey[300], // Slightly lighter grey for the card background
      child: InkWell(
        // TODO Check onTap and remove if not required
        onTap: () {
          // Handle card tap action here
        },
        child: Padding(
          padding: EdgeInsets.all(16.0), // Add padding for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8), // Add spacing below title
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8), // Add spacing below description
              Text(
                'Experiment ID: ${widget.experimentId}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Status: ${status}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16), // Add spacing between details and buttons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround, // Center buttons
                children: [
                  ElevatedButton(
                    onPressed: () {
                      status.toLowerCase() == "read"
                          ? trackUnread(context)
                          : trackRead(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue), // Blue button
                    ),
                    child: Text(
                      status.toLowerCase() == "read" ? 'UNREAD' : 'READ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      trackClick(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue), // Blue button
                    ),
                    child: Text(
                      'Click!!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      trackView(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue), // Blue button
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      trackDelete(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue), // Blue button
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
    print(
        "AKC: Current Status $status \n marking it as : READ \n inboxMessage.status ${inboxMessage["status"]}");
    print("-----------------------------------------------");

    _weNotificationinboxFlutterPlugin.markRead(inboxMessage);
    widget.updateStatus("READ");

    setState(() {
      // status = "READ";
      inboxMessage["status"] = "READ";
    });

    // showAlertDialog(context, "Marked as Read",
    //     "This notification has been marked as read.");
    // status = "UNREAD";
  }

  void trackUnread(BuildContext context) {
    print(
        "AKC: Current Status $status \n marking it as : UNREAD \n inboxMessage.status ${inboxMessage["status"]}");
    print("-----------------------------------------------");

    _weNotificationinboxFlutterPlugin.markUnread(inboxMessage);
    widget.updateStatus("UNREAD");

    // showAlertDialog(context, "Marked as Unread",
    //     "This notification has been marked as unread.");
    // status = "READ";

    setState(() {
      // status = "UNREAD";
      inboxMessage["status"] = "UNREAD";
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
