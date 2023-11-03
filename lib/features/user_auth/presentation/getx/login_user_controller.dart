import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/user_login_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../domain/entities/user.dart';

class LoginUserController extends GetxController{
  final LoginUserUseCase loginUserUseCase;
  LoginUserController({required this.loginUserUseCase});

  final loginEmailTextInput = TextEditingController();
  final loginPasswordTextInput = TextEditingController();

  Future<User> loginUser() async{
    UserDataController userDataController = Get.find();
    final userData = await loginUserUseCase(
        LoginParams(
            userPassword: loginPasswordTextInput.text,
            userEmail: loginEmailTextInput.text));
    userData.fold((failure) {
      return Get.snackbar('Błąd', 'Logowanie nie powiodło się');
    }, (user) async{
      userDataController.userData = user;
      userDataController.userLoginStatus.value = true;
      userDataController.voucherValue.value = user.voucherValue;
    });
    if(Get.currentRoute == '/login_page'){
      Get.back();
      Get.snackbar('Witaj ${userDataController.userData.userName}', 'Logowanie pomyślne');
      return userDataController.userData;
    }else{
      return userDataController.userData;
    }

  }
}