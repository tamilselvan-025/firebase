import 'package:firebase/main.dart';
import 'package:flutter/material.dart';

import '../model/chat_user_model.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  var userSurya = ChatUserModel("Surya", 2);
  var userVicky = ChatUserModel("Vicky", 5);
  var userTamil = ChatUserModel("Tamil", 10);
  List<ChatUserModel> chatUsers = [];

  @override
  void initState() {
    chatUsers = [userSurya, userVicky, userTamil];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: chatUsers.length,
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return getChatUserListView(index);
  }

  Widget getChatUserListView(int index) {
    return ListTile(
      onTap: () async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatUserModel: chatUsers[index],
            ),
          ),
        );
        chatUsers[index].unReadMessages=0;
        setState(() {});
      },
      tileColor: Colors.green[300],
      horizontalTitleGap: 30,
      leading: Text("${index + 1}"),
      title: Text(chatUsers[index].name),
      trailing: CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(chatUsers[index].unReadMessages.toString()),
      ),
    );
  }
}
