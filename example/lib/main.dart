import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import 'package:we_notificationinbox_flutter_example/Screens/notification_inbox.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'Utils/Utils.dart';
import 'Widgets/Button.dart';
import 'Widgets/Edittext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NotificationInbox Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _weNotificationinboxFlutterPlugin = WENotificationinboxFlutter();
  String _notificationCount = "";
  var _cuidValue = "";
  var _isLogin = false;

  @override
  void initState() {
    super.initState();
    WebEngagePlugin _webenagePlugin = WebEngagePlugin();
    WENotificationInbox().init(enableLogs: true);
    initSharedPref();
    _init();
  }

  void initSharedPref() {
    Utils.initSharedPref();
  }

  Future<void> _init() async {
    var isLogin = await Utils.isLogin();

    setState(() {
      _isLogin = isLogin;
      if (_isLogin) {
        getNotificationCount();
        _cuidValue = Utils.getCuid() as String;
      }
    });
  }

  Future<void> getNotificationCount() async {
    String NotificationCount;
    try {
      NotificationCount =
          await _weNotificationinboxFlutterPlugin.getNotificationCount();
    } on PlatformException {
      NotificationCount = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _notificationCount = NotificationCount;
    });
  }

  Future<void> resetNotificationCount() async {
    try {
      await _weNotificationinboxFlutterPlugin.resetNotificationCount();
    } catch (error) {
      throw error;
    }
    if (!mounted) return;

    setState(() {
      _notificationCount = "0";
    });
  }

  void _login() {
    if (_cuidValue.isNotEmpty) {
      _isLogin = true;
      WebEngagePlugin.userLogin(_cuidValue);
      Utils.setIsLogin(_isLogin);
      Utils.setCuid(_cuidValue);
      getNotificationCount();
      setState(() {
        _isLogin = true;
      });
    }
  }

  void _logout() {
    setState(() {
      _isLogin = false;
    });
    WebEngagePlugin.userLogout();
    Utils.setIsLogin(false);
  }

  void _onValueChange(value) {
    _cuidValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationInbox(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: _isLogin
                  ? Column(
                      children: [
                        Container(
                          child: Text(
                              'Welcome,\n $_cuidValue you have $_notificationCount notifications.',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            child: CustomWidgets.button("Logout", _logout)),
                      ],
                    )
                  : Column(
                      children: [
                        Edittext(
                          title: "Enter cuid to login",
                          onChange: _onValueChange,
                        ),
                        CustomWidgets.button("Login", _login)
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
