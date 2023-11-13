import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shop/features/order/data/models/user_order_model.dart';

abstract class UserNotificationDataSource{
  const UserNotificationDataSource();

  Future<void> sendNotificationToUser({
    required String mobileToken,
    required String notificationText,
    required String notificationTopic,
});

  Future<void> updateUserMobileToken({
    required String userID,
    required String mobileToken,
});

}

class UserNotificationDataSourceImp implements UserNotificationDataSource{
  @override
  Future<void> sendNotificationToUser({
    required String mobileToken,
    required String notificationText,
    required String notificationTopic}) async{
    //
    // https://fcm.googleapis.com/v1/projects/shop-da808/messages:send
    // https://fcm.googleapis.com/fcm/send
    try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAARG-KYf0:APA91bFRqxEMWK8vhc7UzwGhNtp1XZNLTER9pBIK4tbRbXuFawDtdD_equmuYvWcEdVojR1gWhaCpjCvuihyv9uhIXN6MXjkfN9TqN9f_CzZkSJ0yRMu6aPfkQJXgKAMvfwDeK5BR3F7',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': notificationText,
            'title': notificationTopic,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": mobileToken,
        },
      ),
    );
    print('done');
  } catch (e) {
    print("error push notification");
  }

    // TODO: implement sendNotificationToUser
    // throw UnimplementedError();
  }

  @override
  Future<void> updateUserMobileToken({
    required String userID,
    required String mobileToken}) async{
    await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).
    collection('users').doc(userID).update({"mobileToken" : mobileToken});
    // // TODO: implement updateUserMobileToken
    // throw UnimplementedError();
  }

}
///get mobile token
// final String? token = await FirebaseMessaging.instance.getToken();

// void sendPushMessage(String body, String title, String token) async {
//   try {
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization':
//         'key=REPLACETHISWITHYOURAPIKEY',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': body,
//             'title': title,
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': '1',
//             'status': 'done'
//           },
//           "to": token,
//         },
//       ),
//     );
//     print('done');
//   } catch (e) {
//     print("error push notification");
//   }
// }