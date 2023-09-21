import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';

class CreateUserController extends GetxController{
  final CreateUserUseCase createUserUseCase;
  CreateUserController({
    required this.createUserUseCase,
  });

  // User? user;

  ///text fields for inserting user data

  final userNameTextField = TextEditingController();
  final userSurnameTextField = TextEditingController();
  final userEmailTextField = TextEditingController();
  final userPasswordTextField = TextEditingController();
  final userMobilePhoneTextField = TextEditingController(text: '+48 ');
  final userCityTextField = TextEditingController();
  final userAddressTextField = TextEditingController();
  final userPostalCodeTextField = TextEditingController();


  ///create user controller function

  Future<void> createUser() async{
    final user = await createUserUseCase(
        CreateUserParams(
            userID: "",
            userName: userNameTextField.text,
            userSurname: userSurnameTextField.text,
            userEmail: userEmailTextField.text,
            userPassword: userPasswordTextField.text,
            userMobilePhone: userMobilePhoneTextField.text,
            userCity: userCityTextField.text,
            userAddress: userAddressTextField.text,
            userPostalCode: userPostalCodeTextField.text,
            isAdmin: false));
    user.fold((failure) {
      return Get.snackbar('failure', "failure");
    }, (user) async {
      await Get.toNamed('/start_page');
      return Get.snackbar('success', 'well done');
    });
  }
}