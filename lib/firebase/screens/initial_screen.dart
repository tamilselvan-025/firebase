import 'package:flutter/material.dart';
import '../../main.dart';
import '../notification_service.dart';
import 'notification_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      debugPrint("------------------ didChangeAppLifecycleState called ------------------");
    //  NotificationService().updateBadgeOnBackground(badgeCount);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      routes: {
        "notification_screen": (context) => const NotificationPage(),
      },
      navigatorKey: navigatorKey,
      title: "FirebaseProject",
    );
  }
}
