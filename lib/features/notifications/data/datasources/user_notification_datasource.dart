import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:http/http.dart' as http;

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
          "apns": {
            "payload": {
              "aps": {
                "alert": {
                  "body": notificationText,
                  "title": notificationTopic,
                },
                "badge" : 2,
                "sound" : "default"
              }
            }
          },
          'notification': <String, dynamic>{
            'sound': "default",
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
