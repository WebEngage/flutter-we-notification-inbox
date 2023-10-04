import 'package:flutter/material.dart';

import 'package:we_notificationinbox_flutter_example/Utils/Constants.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import '../Utils/Utils.dart';
import 'home_page.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _cuidValue = "";
  var _jwt = "";
  var _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
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
      setState(() {
        _isLoggedIn = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _onCuidChange(value) {
    _cuidValue = value;
  }

  void _onJwtChanged(value) {
    _jwt = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/flutter_logo.png',
                        height: 350.0, width: 300.0),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Enter cuid to login",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _onCuidChange,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Enter JWT (If required)",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _onJwtChanged,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text(LOGIN),
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
