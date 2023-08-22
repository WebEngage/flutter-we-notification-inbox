import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static SharedPreferences? _prefs;

  static initSharedPref() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static var IS_LOGIN = "isLogin";
  static var CUID = "cuid";

  static Future<bool> isLogin() async {
    await initSharedPref();
    return _prefs!.getBool(IS_LOGIN) ?? false;
  }

  static void setIsLogin(bool isLogin) {
    if (!isLogin) {
      _prefs?.remove(CUID);
    }
    _prefs?.setBool(IS_LOGIN, isLogin);
  }

  static void setCuid(String cuid) {
    _prefs?.setString(CUID, cuid);
  }

  static String? getCuid() {
    return _prefs?.getString(CUID);
  }
}
