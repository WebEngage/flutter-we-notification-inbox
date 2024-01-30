class WENotificationResponse {
  final dynamic response;
  final String? errorMessage;
  final bool isSuccess;

  WENotificationResponse({
    required this.response,
    required this.errorMessage,
    required this.isSuccess,
  });
}
