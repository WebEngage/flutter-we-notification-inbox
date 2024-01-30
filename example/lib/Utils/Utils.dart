import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_notificationinbox_flutter_example/Utils/Constants.dart';

class Utils {
  static SharedPreferences? _prefs;

  static initSharedPref() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<bool> isLoggedIn() async {
    await initSharedPref();
    return _prefs!.getBool(IS_LOGIN) ?? false;
  }

  static void setIsLoggedIn(bool isLogin) {
    if (!isLogin) {
      _prefs?.remove(CUID);
    }
    _prefs?.setBool(IS_LOGIN, isLogin);
  }

  static void setCuid(String cuid) {
    _prefs?.setString(CUID, cuid);
  }

  static void setJwt(String jwt) {
    _prefs?.setString(JWT, jwt);
  }

  static void getJwt() {
    _prefs?.getString(JWT);
  }

  static String? getCuid() {
    return _prefs?.getString(CUID);
  }
}
