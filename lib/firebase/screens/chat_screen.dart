import 'package:firebase/firebase/model/chat_user_model.dart';
import 'package:flutter/material.dart';


import '../../main.dart';

class ChatScreen extends StatefulWidget {
  final ChatUserModel chatUserModel;

  const ChatScreen({required this.chatUserModel, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  late ChatUserModel chatUserModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    chatUserModel = widget.chatUserModel;
    debugPrint("chatUserModel.unReadMessages ${chatUserModel.unReadMessages}");
      badgeCount=badgeCount-chatUserModel.unReadMessages;
      debugPrint("(if called) badgeCount : $badgeCount");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatUserModel.name),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text("UnReadMessages : ${chatUserModel.unReadMessages}"),
      ),
    );
  }
}
