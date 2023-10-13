import 'package:flutter_test/flutter_test.dart';
import 'package:we_notificationinbox_flutter/we_notificationinbox_flutter.dart';
import 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_platform_interface.dart';
import 'package:we_notificationinbox_flutter/src/we_notificationinbox_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWeNotificationinboxFlutterPlatform
    with MockPlatformInterfaceMixin
    implements WENotificationInboxFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> initNotificationInbox() {
    // TODO: implement initNotificationInbox
    throw UnimplementedError();
  }

  @override
  Future<String> getNotificationCount() {
    // TODO: implement getNotificationCount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll(List notificationList) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> markDelete(Map<String, dynamic> readMap) {
    // TODO: implement markDelete
    throw UnimplementedError();
  }

  @override
  Future<void> markRead(Map<String, dynamic> readMap) {
    // TODO: implement markRead
    throw UnimplementedError();
  }

  @override
  Future<void> markUnread(Map<String, dynamic> readMap) {
    // TODO: implement markUnread
    throw UnimplementedError();
  }

  @override
  Future<void> readAll(List notificationList) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> trackClick(Map<String, dynamic> readMap) {
    // TODO: implement trackClick
    throw UnimplementedError();
  }

  @override
  Future<void> trackView(Map<String, dynamic> readMap) {
    // TODO: implement trackView
    throw UnimplementedError();
  }

  @override
  Future<void> unReadAll(List notificationList) {
    // TODO: implement unReadAll
    throw UnimplementedError();
  }

  @override
  Future<void> resetNotificationCount() {
    // TODO: implement resetNotificationCount
    throw UnimplementedError();
  }

  @override
  Future getNotificationList({offsetJSON}) {
    // TODO: implement getNotificationList
    throw UnimplementedError();
  }
}

void main() {
  final WENotificationInboxFlutterPlatform initialPlatform =
      WENotificationInboxFlutterPlatform.instance;

  test('$MethodChannelWeNotificationinboxFlutter is the default instance', () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelWeNotificationinboxFlutter>());
  });

  test('getPlatformVersion', () async {
    WENotificationinboxFlutter weNotificationinboxFlutterPlugin =
        WENotificationinboxFlutter();
    MockWeNotificationinboxFlutterPlatform fakePlatform =
        MockWeNotificationinboxFlutterPlatform();
    WENotificationInboxFlutterPlatform.instance = fakePlatform;

    expect(await weNotificationinboxFlutterPlugin.getPlatformVersion(), '42');
  });
}
