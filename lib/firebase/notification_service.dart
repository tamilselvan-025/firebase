import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationService {
  NotificationService._();

  factory NotificationService() => NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    ); // Use the correct resource path

    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,);
       // onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse);
  }

  void onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) {
    debugPrint("----------------- onDidReceiveBackgroundNotificationResponse called -----------------");
  }

  void showNotifications({int id = 10, String? title, String? body, String? payload}) async {
    try {
      debugPrint("badgeCount in showNotifications : $badgeCount");

      flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(count: badgeCount),
        payload: payload,
      );
    } catch (error, stackTrace) {
      debugPrint("------------ERROR : $error---------------");
      debugPrint("------------stackTrace : $stackTrace---------------");
    }
  }

  NotificationDetails notificationDetails({int? count}) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "default_channel_id",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        subText: "subText in AndroidNotificationDetails",
        number: count,
        icon: "ic_launcher",
      ),
      iOS: DarwinNotificationDetails(badgeNumber: count),
    );
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    debugPrint("-----------------onDidReceiveLocalNotification--------------------");
    debugPrint("id : $id");
    debugPrint("title : $title");
    debugPrint("body : $body");
    debugPrint("payload : $payload");
    debugPrint("---------------------------------------------------------------------");
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    debugPrint("-----------------onDidReceiveNotificationResponse--------------------");

    debugPrint("notificationResponse : $notificationResponse");
    debugPrint("notificationResponse.actionId : ${notificationResponse.actionId}");
    debugPrint("notificationResponse.id : ${notificationResponse.id}");
    debugPrint("notificationResponse.input : ${notificationResponse.input}");
    debugPrint("notificationResponse.notificationResponseType : ${notificationResponse.notificationResponseType}");

    debugPrint("---------------------------------------------------------------------");
  }
// Future<void> updateBadgeCount(int? count) async {
//    showNotifications(
//     id: 1,
//     title: 'Badge Updated',
//     body: 'Badge count updated value : $count',
//     payload: 'payload',
//     badgeCount: count,
//   );
// }
}
