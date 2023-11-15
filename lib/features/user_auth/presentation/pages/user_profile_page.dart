import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
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

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Mój profil'),
        ),
        body: Obx(() {
          return Column(
            children: [
              const SizedBox(height: 40.0,),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 180,
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    // shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 5.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Text('Dane osobowe:'),
                            Text('${userDataController.userData.userName} ${userDataController.userData.userSurname}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),),
                            Text('${userDataController.userData.userPostalCode} ${userDataController.userData.userCity}', style: const TextStyle(fontWeight: FontWeight.w200),),
                            Text('ul. ${userDataController.userData.userAddress}', style: const TextStyle(fontWeight: FontWeight.w200),),
                            Text('tel. ${userDataController.userData.userMobilePhone}', style: const TextStyle(fontWeight: FontWeight.w200),),
                            Text('email: ${userDataController.userData.userEmail}', style: const TextStyle(fontWeight: FontWeight.w200),)
                          ],
                        ),
                        GestureDetector(
                            onTap: () async {
                              await controller.setTextValues();
                              createUserController.registrationPage = false;
                              await Get.toNamed('/registration_page');
                            },
                            child: const Text('Zmień', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),)),
                        const SizedBox(width: 5.0,)

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0,),
              const Text('Punkty premiowe:', style: TextStyle(fontSize: 20.0),),
              const SizedBox(height: 20.0,),
              RatingBarIndicator(
                itemCount: 8,
                itemSize: 40,
                rating: userDataController.bonusPointsValue.value.toDouble(),
                itemBuilder: (context, index) =>
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text('Vouchery', style: TextStyle(fontSize: 20.0)),
              const SizedBox(height: 20.0,),
              SizedBox(
                width: 250,
                height: 150,
                child: Card(
                  color: Colors.cyan,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Text('${userDataController.voucherValue.value.toString()} PLN',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30));
                      })
                    ],
                  ),
                ),

              ),
              const SizedBox(height: 40.0,),
              const Text('Darmowe produkty do wybrania:', style: TextStyle(fontSize: 20.0)),
              const SizedBox(height: 15.0,),
              Text(userDataController.freeProducts.value.toString(), style: const TextStyle(fontSize: 50),),
            ],
          );
        }),
      ),
    );
  }
}
