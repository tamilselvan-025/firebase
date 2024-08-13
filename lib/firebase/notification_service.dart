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
    );

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
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse);
  }

  void showNotifications({int id = 10, String? title, String? body, String? payload,int? badge}) async {
    try {
      debugPrint("badgeCount in showNotifications : $badge");
      flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(count: badge),
        payload: payload,
      );
    } catch (error, stackTrace) {
      debugPrint("------------ERROR : $error---------------");
      debugPrint("------------stackTrace : $stackTrace---------------");
    }
  }

  void updateBadgeOnBackground(int count) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: false,
      playSound: false,
      silent: true,
      number: count,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    debugPrint("Silent Notification triggered with badge value : $count");
    await flutterLocalNotificationsPlugin.show(
     100, // Use a different notification ID for silent updates
      null, // Empty title for silent update
      null, // Empty body for silent update
      platformChannelSpecifics,
    );
    debugPrint("Silent Notification ended");
    debugPrint("flutterLocalNotificationsPlugin. cancel -----> triggered");
    await Future.delayed(const Duration(milliseconds:300));
    var variable=await flutterLocalNotificationsPlugin.getActiveNotifications();
    for(int i=0;i<variable.length;i++){
      if(variable[i].id==100){
        await flutterLocalNotificationsPlugin.cancel(100);
        debugPrint("flutterLocalNotificationsPlugin. cancel for index $i-----> ended");
      }
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
}
