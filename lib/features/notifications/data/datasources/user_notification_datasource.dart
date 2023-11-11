import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop/core/constants/constants.dart';

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
    // TODO: implement sendNotificationToUser
    throw UnimplementedError();
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