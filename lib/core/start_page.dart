import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/stripe_payments/presentation/getx/payment_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import 'custom_widgets/custom_app_bar.dart';

class StartPage extends GetView {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final user = Get.put(UserDataController());
    // ModifyUserController modifyUserController = Get.find();
    PaymentController paymentController = Get.find();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
          child: CustomAppBar(appBarTitle: 'SKLEP',)),
      body: CupertinoButton(onPressed: () async{
        // controller.createUser();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                child: Text('Cześć'), onTap: (){Get.toNamed('/product_category');},),
            GestureDetector(child: Text('pay'), onTap: () async{
              ///Stripe payment
              await paymentController.createPaymentIntent();
              await paymentController.initPaymentSheet(paymentIntent: paymentController.intent);
              paymentController.displayPaymentSheet();
              ///payment STRIPE
            },),
          ],
        ),
      ),),
    );
  }
}


