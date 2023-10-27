import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/login_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/logout_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBar({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {

    BasketController controller = Get.find();
    UserDataController userDataController = Get.find();

    return AppBar(
      automaticallyImplyLeading: Get.currentRoute == '/start_page'? false : true,
      centerTitle: true,
      title: Text(appBarTitle),
      actions: [
        Get.currentRoute == '/registration_page' || Get.currentRoute == '/login_page' ?
        const SizedBox() : Stack(
            children: [
              Obx(() {
                return controller.listOfProducts.isEmpty ? const SizedBox() :
                Text(controller.listOfProducts.length.toString());
              }),
              IconButton(onPressed: () {
                if (userDataController.userLoginStatus == false) {
                  Get.defaultDialog(
                    title: 'Uwaga',
                    content: const Text('Aby przejść do koszyka musisz być zalogowany'),
                  );
                } else {
                  Get.toNamed('/basket_page');
                }
              }, icon: const Icon(Icons.shopping_cart_rounded)),
            ]
        ),
        Obx(() {
          return buildPopupMenuButton(userDataController);
        }),
        const SizedBox(width: 10.0,)
        // const SizedBox(width: 10.0,)
      ],
    );
  }

  PopupMenuButton<int> buildPopupMenuButton(UserDataController userDataController) {

    LogOutUserController logOut = Get.find();
    LoginUserController logIn = Get.find();
    CreateUserController createUser = Get.find();

    return PopupMenuButton(
          onSelected: (value) async{
            if (value == 0) {
              Get.toNamed('/login_page');
            }
            if (value == 1){
              await logOut.logOutUser();
              Get.toNamed('/start_page');
            }
            if (value == 3) {
              await logIn.loginUser();
              Get.toNamed('/user_profile_page');
            }
            if (value == 2) {
              createUser.registrationPage = true;
              createUser.clearTextFields();
              Get.toNamed('/registration_page');
            }
            if (value == 4){
              Get.toNamed('/allOrders_page');
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                  value: 0,
                  enabled: userDataController.userLoginStatus.value == true? false : true,
                  child: Text('Zaloguj się')),
              PopupMenuItem(
                  enabled: userDataController.userLoginStatus.value == true? true : false,
                  value: 1,
                  child: Text('Wyloguj się')),
              PopupMenuItem(
                  value: 2,
                  enabled: userDataController.userLoginStatus.value == true? false : true,
                  child: Text('Zarejestruj sie')),
              PopupMenuItem(value: 3,
                enabled: userDataController.userLoginStatus.value == true? true : false,
                child: const Text('Mój profil'),),
              PopupMenuItem(value: 4,
                enabled: userDataController.userLoginStatus.value == true? true : false,
                child: const Text('Zamówienia'),)
            ];
          },
          child: ClipRect(
            child: userDataController.userLoginStatus == true ? CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Text(userDataController.userData.userName[0] + userDataController.userData.userSurname[0]),
            ) : const Icon(Icons.menu),
          ),);
  }
}