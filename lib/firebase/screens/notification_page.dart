import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final message=ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification page"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("message.category : ${message.category}"),
            Text("message.collapseKey : ${message.collapseKey}"),
            Text("message.contentAvailable : ${message.contentAvailable}"),
            Text("message.data : ${message.data}"),
            Text("message.from : ${message.from}"),
            Text("message.messageId : ${message.messageId}"),
            Text("message.messageType : ${message.messageType}"),
            Text("message.mutableContent : ${message.mutableContent}"),
            Text("message.notification : ${message.notification}"),
            Text("message.senderId : ${message.senderId}"),
            Text("message.sentTime : ${message.sentTime}"),
            Text("message.threadId : ${message.threadId}"),
            Text("message.ttl : ${message.ttl}"),
          ],
        ),
      ),
    );
  }
}
