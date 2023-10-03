import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:we_notificationinbox_flutter/utils/WELogger.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import 'package:we_notificationinbox_flutter_example/Screens/notification_inbox.dart';
import 'package:we_notificationinbox_flutter_example/Utils/Constants.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'Utils/Utils.dart';
import 'Widgets/Button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  var _jwt = "";
  var _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    WENotificationInbox().init(enableLogs: true);
    initSharedPref();
    _init();
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
        _jwt = Utils.getJwt() as String;
      }
    });
  }

  Future<void> getNotificationCount() async {
    String notificationCount = "0";
    try {
      notificationCount =
          await _weNotificationInboxFlutterPlugin.getNotificationCount();
    } on PlatformException {
      WELogger.e("Exception occurred while getting platform version");
    }
    if (!mounted) return;

    // Updates count in success case
    setState(() {
      _notificationCount = int.parse(notificationCount);
    });
  }

  Future<void> resetNotificationCount() async {
    try {
      await _weNotificationInboxFlutterPlugin.resetNotificationCount();
    } catch (error) {
      rethrow;
    }
    if (!mounted) return;

    setState(() {
      _notificationCount = 0;
    });
  }

  void _login() {
    if (_cuidValue.isNotEmpty) {
      _isLoggedIn = true;
      if (_jwt.isNotEmpty) {
        WebEngagePlugin.userLoginWithSecureToken(_cuidValue, _jwt);
      } else {
        WebEngagePlugin.userLogin(_cuidValue);
      }
      Utils.setIsLoggedIn(_isLoggedIn);
      Utils.setCuid(_cuidValue);
      Utils.setJwt(_jwt);
      getNotificationCount();
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
    WebEngagePlugin.userLogout();
    Utils.setIsLoggedIn(false);
  }

  void _onValueChange(value) {
    _cuidValue = value;
  }

  void _onJwtChanged(value) {
    _jwt = value;
  }

  NotificationInbox _navigateToNotificationInbox() {
    resetNotificationCount();
    return const NotificationInbox();
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
                    final bool? shouldRefresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _navigateToNotificationInbox(),
                      ),
                    );
                    getNotificationCount();
                  }),
              _notificationCount != 0
                  ? Positioned(
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
                  : Container()
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: _isLoggedIn
                    ? SingleChildScrollView(
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
                                      'Welcome $_cuidValue,',
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
                                    child:
                                        CustomWidgets.button(LOGOUT, _logout),
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
                                      child: Image.asset(
                                          'assets/images/card1.webp'),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                          'assets/images/card2.jpeg'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/flutter_logo.png',
                              height: 350.0, width: 300.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Enter cuid to login",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: _onValueChange,
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Enter JWT (If required)",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: _onJwtChanged,
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: _login,
                            child: Text(LOGIN),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
