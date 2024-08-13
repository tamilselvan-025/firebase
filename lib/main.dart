import 'package:firebase/firebase/firebase_api.dart';
import 'package:firebase/firebase/notification_service.dart';
import 'package:firebase/firebase/screens/chat_list_screen.dart';
import 'package:firebase/firebase/screens/initial_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
String pathOfAppIcon='';
int badgeCount=0;
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage? message)async{
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform);
  if(message!=null){
    debugPrint("message.notification ${message.notification}");
    debugPrint("firebaseMessagingBackgroundHandler message is not null [MESSAGE: ${message.data}]");
    return NotificationService().showNotifications(id: message.data['id'],title: message.data['title'],body: message
        .data['body'],payload: message.data['payload']);
  }
  else{
    debugPrint("firebaseMessagingBackgroundHandler message is null");
  }
}
void onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) {
  debugPrint("----------------- onDidReceiveBackgroundNotificationResponse called -----------------");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotifications();
  FirebaseApi().initNotifications();
  FirebaseApi().initPushNotifications();
  FirebaseApi().configureFirebaseListeners();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    const InitialScreen()
  );
}

class Home extends StatefulWidget  {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Cloud Messaging"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset("assets/images/icon.png"),
            ),
            Text("BadgeCount : $badgeCount"),
            ElevatedButton(
              onPressed: () {
                badgeCount++;
                NotificationService().showNotifications(id: 1, title: "Title :Badge Add", body: "badge value : "
                    "$badgeCount",
                  payload: 'payload',badge: badgeCount);
                setState(() {});
              },
              child: const Text("Add Notification"),
            ),
            ElevatedButton(
              onPressed: () {
                badgeCount--;
                NotificationService().showNotifications(id: 1, title: "Title :Badge Sub", body: "badge value : "
                    "$badgeCount",
                    payload: 'payload',badge: badgeCount);
                setState(() {});
              },
              child: const Text("Decrement Notification"),
            ),
            ElevatedButton(
              onPressed: () async {
                badgeCount = 0;
                NotificationService().flutterLocalNotificationsPlugin.cancelAll();
                setState(() {});
              },
              child: const Text("Delete badge"),
            ),
            ElevatedButton(
              onPressed: () {
                var notification = NotificationService();
                notification.showNotifications(
                  body: "Notification Body",
                  title: "Notification Title",
                );
                setState(() {});
              },
              child: const Text("Push Local Notification"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
       Navigator.push(context,MaterialPageRoute(builder: (context)=>const ChatListScreen()));
      },
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}


//  Future<File?> _downloadAndSaveImage({required String url,required String fileName}) async {
//   try{
//   var directory = await getTemporaryDirectory();
//   var filePath = '${directory.path}/$fileName';
//   var file = File(filePath);
//   var assetAppIcon=File("/assets/images/icon.png");
//   var data=assetAppIcon.readAsBytesSync();
//   file.writeAsBytesSync(data);
//   return file;
// }catch(error,stackTrace){
//   debugPrint("--------------ERROR : $error------------------");
//   debugPrint("--------------StackTrace : $stackTrace------------------");
// }
// return null;
//
// }
