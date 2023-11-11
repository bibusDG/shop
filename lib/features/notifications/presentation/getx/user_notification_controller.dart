import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shop/features/notifications/domain/usecases/update_user_token_usecase.dart';

class UserNotificationController extends GetxController{
  final UpdateUserTokenUseCase updateUserTokenUseCase;
  UserNotificationController({required this.updateUserTokenUseCase});

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

}