import 'package:flutter/foundation.dart';

/// A simple logging utility for the WebEngage Notification Inbox plugin.
///
/// Provides verbose, warning, and error level logging that can be
/// enabled or disabled at runtime. Logs are only printed in debug mode.
class WELogger {
  static bool _enableLogs = false;

  /// Enables or disables logging output.
  ///
  /// Set [enable] to `true` to activate debug logs.
  static void enableLogs(bool enable) {
    _enableLogs = enable;
  }

  /// Logs a verbose-level message.
  ///
  /// Only prints when logging is enabled and the app is in debug mode.
  static void v(String text) {
    if (_enableLogs) {
      _printVerbose(getFormattedText(text));
    }
  }

  /// Logs an error-level message.
  ///
  /// Only prints when logging is enabled and the app is in debug mode.
  static void e(String text) {
    if (_enableLogs) {
      _printError(getFormattedText(text));
    }
  }

  /// Logs a warning-level message.
  ///
  /// Only prints when logging is enabled and the app is in debug mode.
  static void w(String text) {
    if (_enableLogs) {
      _printWarning(getFormattedText(text));
    }
  }

  /// Formats the log message with the WebEngage-Inbox prefix.
  static String getFormattedText(text) {
    return "WebEngage-Inbox: $text";
  }

  static void _printVerbose(String text) {
    if (kDebugMode) {
      print(text);
    }
  }

  static void _printWarning(String text) {
    if (kDebugMode) {
      print(text);
    }
  }

  static void _printError(String text) {
    if (kDebugMode) {
      print(text);
    }
  }
}
