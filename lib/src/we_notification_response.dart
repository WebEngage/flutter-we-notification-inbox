/// Represents the response from a WebEngage Notification Inbox API call.
///
/// Contains the result data, any error message, and a success flag
/// to indicate whether the operation completed successfully.
class WENotificationResponse {
  /// The response payload from the API call.
  ///
  /// Contains the notification count, list data, or `null` on failure.
  final dynamic response;

  /// The error message if the API call failed, or `null` on success.
  final String? errorMessage;

  /// Whether the API call completed successfully.
  final bool isSuccess;

  /// Creates a [WENotificationResponse].
  ///
  /// All parameters are required:
  /// - [response]: The API response data (or `null` on failure).
  /// - [errorMessage]: Error description (or `null` on success).
  /// - [isSuccess]: `true` if the call succeeded.
  WENotificationResponse({
    required this.response,
    required this.errorMessage,
    required this.isSuccess,
  });
}
