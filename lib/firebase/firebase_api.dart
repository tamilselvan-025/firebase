import 'package:firebase/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'notification_service.dart';

//Test notification link -> https://console.firebase.google.com/project/fir-77db1/notification/compose
class FirebaseApi {
  FirebaseApi._();
  final firebaseMessaging = FirebaseMessaging.instance;

  factory FirebaseApi() => FirebaseApi._();
  void initPushNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    firebaseMessaging.getInitialMessage().then(handleMessage);
  }
  void handleMessage(RemoteMessage? remoteMessage) {
    if (remoteMessage != null) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("notification_screen", (context) => false, arguments: remoteMessage);
    } else {
      debugPrint("----------------else called in FirebaseAPI.handleMessage-----------------");
    }
  }

  Future<void> configureFirebaseListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      debugPrint("configureFirebaseListeners called");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        badgeCount++;
        debugPrint("message.data['badge'] : ${message.data['badge']}");
         NotificationService().showNotifications(id: message.data['id']??10,title: message.data['title']??"Title "
            "Null",body:
        message
            .data['body']??"Body is null",payload: message.data['payload']??"payload is null", badge: badgeCount);
         await Future.delayed(const Duration(seconds: 10));
         NotificationService().flutterLocalNotificationsPlugin.cancel(message.data['id']??10);

      }
    });
  }

  void initNotifications() async {
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
     alert: true,
    );
    // debugPrint("-----------------NotificationSettings-------------------");
    // debugPrint("notificationSettings.alert : ${notificationSettings.alert}");
    // debugPrint("notificationSettings.announcement : ${notificationSettings.announcement}");
    // debugPrint("notificationSettings.authorizationStatus :${notificationSettings.authorizationStatus}");
    // debugPrint("notificationSettings.badge : ${notificationSettings.badge}");
    // debugPrint("notificationSettings.carPlay : ${notificationSettings.carPlay}");
    // debugPrint("notificationSettings.criticalAlert : ${notificationSettings.criticalAlert}");
    // debugPrint("notificationSettings.lockScreen : ${notificationSettings.lockScreen}");
    // debugPrint("notificationSettings.notificationCenter : ${notificationSettings.notificationCenter}");
    // debugPrint("notificationSettings.showPreviews ${notificationSettings.showPreviews}");
    // debugPrint("notificationSettings.sound : ${notificationSettings.sound}");
    // debugPrint("notificationSettings.timeSensitive : ${notificationSettings.timeSensitive}");
    // debugPrint("--------------------------------------------------------");
    final fcmToken = await firebaseMessaging.getToken();
    debugPrint("fcmToken : $fcmToken");
  }

}
