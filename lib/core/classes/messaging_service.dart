// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class MessagingService {
//
//     void requestPermission() async {
//       FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         print('User granted permission');
//       } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//         print('User granted provisional permission');
//       } else {
//         print('User declined or has not accepted permission');
//       }
//     }
//     void listenFCM({channel, flutterLocalNotificationsPlugin}) async {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android;
//         if (notification != null && android != null && !kIsWeb) {
//           flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 // TODO add a proper drawable resource to android, for now using
//                 //      one that already exists in example app.
//                 icon: 'launch_background',
//               ),
//             ),
//           );
//         }
//       });
//     }
//     void loadFCM({channel, flutterLocalNotificationsPlugin}) async {
//       if (!kIsWeb) {
//         channel = const AndroidNotificationChannel(
//           'high_importance_channel', // id
//           'High Importance Notifications', // title
//           importance: Importance.high,
//           enableVibration: true,
//         );
//
//         flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//         /// Create an Android Notification Channel.
//         ///
//         /// We use this channel in the `AndroidManifest.xml` file to override the
//         /// default FCM channel to enable heads up notifications.
//         await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//             ?.createNotificationChannel(channel);
//
//         /// Update the iOS foreground notification presentation options to allow
//         /// heads up notifications.
//         await FirebaseMessaging.instance
//             .setForegroundNotificationPresentationOptions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//       }
//     }
// }