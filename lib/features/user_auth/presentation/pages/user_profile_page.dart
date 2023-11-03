import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

class UserProfilePage extends GetView<ModifyUserController> {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDataController userDataController = Get.find();
    CreateUserController createUserController = Get.find();

    return ResponsiveScaledBox(
        width: 430,
        child: Scaffold(
          appBar: const PreferredSize(preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Mój profil'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 40.0,),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 180,
                  child: Card(
                    shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 5.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Dane osobowe:'),
                            Text('${userDataController.userData.userName} ${userDataController.userData.userSurname}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            Text('${userDataController.userData.userPostalCode} ${userDataController.userData.userCity}'),
                            Text('ul. ${userDataController.userData.userAddress}'),
                            Text('tel. ${userDataController.userData.userMobilePhone}'),
                            Text('email: ${userDataController.userData.userEmail}')
                          ],
                        ),
                        GestureDetector(
                            onTap: () async {
                              await controller.setTextValues();
                              createUserController.registrationPage = false;
                              await Get.toNamed('/registration_page');
                            },
                            child: const Text('Zmień')),
                        const SizedBox(width: 5.0,)

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0,),
              const Text('Punkty premiowe:'),
              const SizedBox(height: 20.0,),
              RatingBarIndicator(
                itemCount: 8,
                itemSize: 40,
                rating: userDataController.userData.userBonusPoints.toDouble(),
                itemBuilder: (context, index) =>
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 20.0,),
              const Text('Vouchery'),
              const SizedBox(height: 20.0,),
              SizedBox(
                width: 250,
                height: 150,
                child: Card(
                  color: Colors.teal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Text('${userDataController.voucherValue.value.toString()} PLN',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35));
                      })
                    ],
                  ),
                ),

              ),
            ],
          ),
        )
    );
  }
}
