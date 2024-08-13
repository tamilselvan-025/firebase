// // import 'package:app_badge_plus/app_badge_plus.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// //
// // import 'firebase_options.dart';
// //
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   bool isSupported =await AppBadgePlus.isSupported();
// //   debugPrint("--------AppBadgePlus.isSupported() : $isSupported----------");
// //   runApp(
// //     const MaterialApp(
// //       home: Home(),
// //     ),
// //   );
// // }
// //
// // class Home extends StatefulWidget {
// //   const Home({super.key});
// //
// //   @override
// //   State<Home> createState() => _HomeState();
// // }
// //
// // class _HomeState extends State<Home> {
// //   int badgeCount = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("App Badge Plus package"),
// //         backgroundColor: Colors.teal,
// //       ),
// //       body: Center(
// //         child: Text("badgeCount : $badgeCount"),
// //       ),
// //       floatingActionButton: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           FloatingActionButton(
// //             onPressed: () {
// //               badgeCount++;
// //               AppBadgePlus.updateBadge(badgeCount);
// //               setState(() {});
// //             },
// //             child: const Icon(Icons.add),
// //           ),
// //           FloatingActionButton(
// //             onPressed: () {
// //               badgeCount--;
// //               AppBadgePlus.updateBadge(badgeCount);
// //               setState(() {});
// //             },
// //             child: const Icon(Icons.minimize),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int badgeCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     check();
//   }
//   void check()async{
//    bool isAppBadgeSupported =await FlutterAppBadger.isAppBadgeSupported();
//    debugPrint("isAppBadgeSupported : $isAppBadgeSupported");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () async{
//                   badgeCount++;
//                   await FlutterAppBadger.updateBadgeCount(badgeCount);
//                   debugPrint("badgeCount : $badgeCount");
//                 },
//                 child: const Text("Increment"),
//               ),
//               ElevatedButton(
//                 onPressed: () async{
//                   badgeCount--;
//                   await FlutterAppBadger.updateBadgeCount(badgeCount);
//                   debugPrint("badgeCount : $badgeCount");
//
//                 },
//                 child: const Text("Decrement"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   badgeCount=0;
//                   FlutterAppBadger.removeBadge();
//                 },
//                 child: const Text("Remove All"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
