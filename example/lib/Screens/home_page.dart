import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import 'package:we_notificationinbox_flutter_example/Screens/login.dart';
import 'package:we_notificationinbox_flutter_example/Screens/notification_inbox.dart';
import 'package:we_notificationinbox_flutter_example/Utils/Constants.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'package:we_notificationinbox_flutter/src/we_notification_response.dart';
import '../Utils/Utils.dart';
import '../Widgets/Button.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: APP_TITLE),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _weNotificationInboxFlutterPlugin = WENotificationinboxFlutter();
  int _notificationCount = 0;
  var _cuidValue = "";
  var _isLoggedIn = false;
  late WebEngagePlugin _webEngagePlugin;

  @override
  void initState() {
    super.initState();
    WENotificationInbox().init(enableLogs: true);
    initSharedPref();
    _init();
    _webEngagePlugin = new WebEngagePlugin();
    _webEngagePlugin.tokenInvalidatedCallback(_onTokenInvalidated);
  }

  void _onTokenInvalidated(Map<String, dynamic>? message) {
    print("tokenInvalidated callback received " + message.toString());
    // Reset with new Security Token in the callback
    // WebEngagePlugin.setSecureToken("USER_NAME", "REPLACE_JWT_TOKEN_HERE");
  }

  void initSharedPref() {
    Utils.initSharedPref();
  }

  Future<void> _init() async {
    var isLoggedIn = await Utils.isLoggedIn();

    setState(() {
      _isLoggedIn = isLoggedIn;
      if (_isLoggedIn) {
        getNotificationCount();
        _cuidValue = Utils.getCuid() as String;
      }
    });
  }

  Future<void> getNotificationCount() async {
    String notificationCount = "0";
    WENotificationResponse weNotificationResponse =
        await _weNotificationInboxFlutterPlugin.getNotificationCount();
    if (weNotificationResponse.isSuccess) {
      if (kDebugMode) {
        print(
            "WebEngage-Sample-App: notificationCount in the sample App \n ${weNotificationResponse.response}");
      }
    } else {
      if (kDebugMode) {
        print(
            "WebEngage-Sample-App: Exception occurred while accessing Notification Count \n ${weNotificationResponse.errorMessage} ");
      }
    }
    if (!mounted) return;
    setState(() {
      _notificationCount = int.parse(notificationCount);
    });
  }

  Future<void> resetNotificationCount() async {
    try {
      await _weNotificationInboxFlutterPlugin.resetNotificationCount();
    } catch (error) {
      if (kDebugMode) {
        print("WebEngage-Sample-App: Error while reseting Notification count");
      }
    }
    if (!mounted) return;

    setState(() {
      _notificationCount = 0;
    });
  }

  NotificationInbox _navigateToNotificationInbox() {
    resetNotificationCount();
    return const NotificationInbox();
  }

  void toggleLogin() {
    if (_isLoggedIn) {
      setState(() {
        _isLoggedIn = false;
      });
      WebEngagePlugin.userLogout();
      Utils.setIsLoggedIn(false);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () async {
                    setState(() {
                      _notificationCount = 0;
                    });
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _navigateToNotificationInbox(),
                      ),
                    );
                    getNotificationCount();
                  }),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$_notificationCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                _isLoggedIn
                                    ? 'Welcome $_cuidValue,'
                                    : 'Guest User',
                                style: const TextStyle(
                                  color: Color.fromRGBO(100, 145, 222, 1),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: CustomWidgets.button(
                                  _isLoggedIn ? LOGOUT : LOGIN, toggleLogin),
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Image.asset('assets/images/banner1.png'),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset('assets/images/card1.webp'),
                              ),
                              Expanded(
                                child: Image.asset('assets/images/card2.jpeg'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
