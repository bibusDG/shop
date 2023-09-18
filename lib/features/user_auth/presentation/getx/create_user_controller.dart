import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/logout_user_usecase.dart';
import '../../domain/usecases/user_login_usecase.dart';

class CreateUserController extends GetxController{
  final CreateUserUseCase createUserUseCase;
  // final LoginUserUseCase loginUserUseCase;
  // final LogOutUserUseCase logOutUserUseCase;
  CreateUserController({
    required this.createUserUseCase,
    // required this.loginUserUseCase,
    // required this.logOutUserUseCase
  });

  // User? user;

  ///text fields for inserting user data

  final userNameTextField = TextEditingController();
  final userSurnameTextField = TextEditingController();
  final userEmailTextField = TextEditingController();
  final userPasswordTextField = TextEditingController();
  final userMobilePhoneTextField = TextEditingController();
  final userCountryTextField = TextEditingController();
  final userAddressTextField = TextEditingController();
  final userPostalCodeTextField = TextEditingController();


  ///create user controller function

  Future<void> createUser() async{
    final user = await createUserUseCase(
        const CreateUserParams(
            userID: "",
            userName: "userName",
            userSurname: "userSurname",
            userEmail: "userEmail",
            userPassword: "userPassword",
            userMobilePhone: "userMobilePhone",
            userCountry: "userCountry",
            userAddress: "userAddress",
            userPostalCode: "userPostalCode",
            isAdmin: false));
    user.fold((failure) {
      return Get.snackbar('failure', "failure");
    }, (user) {
      return Get.snackbar('success', 'well done');
    });
  }


  // Future<User?> loginUser() async{
  //   final userLoggedIn = await loginUserUseCase(
  //       const LoginParams(
  //           userPassword: 'userPassword',
  //           userEmail: "userEmail"));
  //   userLoggedIn.fold((failure) {
  //     return Get.snackbar('Logg in', "unable to log in");
  //   }, (userLogged) {
  //     user = userLogged;
  //     return Get.snackbar("title", "message");
  //   });
  //   return user;
  // }

  // Future<void> logOutUser() async{
  //   final userLoggedOut = await logOutUserUseCase();
  //   userLoggedOut.fold((failure) {
  //     return Get.snackbar('Log out', 'Unable to log out user');
  //   }, (r) {
  //     user = EMPTY_USER;
  //     return Get.snackbar('Log out', 'Log out successful');
  //   });
  // }

}