import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_method_channel.dart';

void main() {
  MethodChannelWeNotificationinboxFlutter platform =
      MethodChannelWeNotificationinboxFlutter();
  const MethodChannel channel = MethodChannel('we_notificationinbox_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
