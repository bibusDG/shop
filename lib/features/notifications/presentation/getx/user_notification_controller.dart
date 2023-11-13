import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shop/features/notifications/domain/usecases/update_user_token_usecase.dart';

import '../../domain/usecases/send_notification_usecase.dart';

class UserNotificationController extends GetxController{
  final UpdateUserTokenUseCase updateUserTokenUseCase;
  final SendNotificationUseCase sendNotificationUseCase;
  UserNotificationController({
    required this.updateUserTokenUseCase,
    required this.sendNotificationUseCase,
  });

  Future<void> updateMobileToken({userID}) async{
    final String? token = await FirebaseMessaging.instance.getToken();
    final result = await updateUserTokenUseCase(TokenParams(
        mobileToken: token!,
        userID: userID));
    result.fold((failed){
      return null;
    }, (result){
      return null;
    });
  }

  Future<void> sendNotificationToUser({mobileToken, notificationTopic, notificationText}) async{

    final result = await sendNotificationUseCase(
        NotificationParams(
            mobileToken: mobileToken,
            notificationTopic: notificationTopic,
            notificationText: notificationText));
    result.fold((failure){
      return null;
    }, (result){
      return null;
    });

  }

  Future<void> sendNotificationToAdmin({mobileToken, notificationTopic, notificationText}) async{

    final result = await sendNotificationUseCase(
        NotificationParams(
            mobileToken: mobileToken,
            notificationTopic: notificationTopic,
            notificationText: notificationText));
    result.fold((failure){
      return null;
    }, (result){
      return null;
    });

  }

}