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
    UserDataController userDataController = Get.put(UserDataController());
    final userData = await loginUserUseCase(
        LoginParams(
            userPassword: loginEmailTextInput.text,
            userEmail: loginPasswordTextInput.text));
    userData.fold((failure) {
      return Get.snackbar('Login', 'Something went wrong');
    }, (user) async{
      userDataController.userData = user;
    });
    return userDataController.userData;
  }
}