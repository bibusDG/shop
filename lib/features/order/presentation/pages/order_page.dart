import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/bindings/payment_bindings.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/stripe_payments/presentation/getx/payment_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../../../core/classes/notification_text.dart';
import '../getx/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserDataController userDataController = Get.find();
    BasketController basketController = Get.find();

    // bool? isVoucher = basketController.listOfProducts.values.elementAt(0).productName.contains('Voucher');


    return Scaffold(
          appBar: const PreferredSize(preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Zamówienie',),),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: deliveryAddress()),
              Expanded(flex:1, child: paymentMethod(basketController.voucherInBasket)),
              Expanded(flex:1, child: deliveryMethod(basketController.voucherInBasket)),
              Expanded(flex:1, child: orderSummary(userDataController)),

            ],
          ),
    );

  }
///method responsible for order summary view
  Column orderSummary(UserDataController userDataController) {
    PaymentController paymentController = Get.find();
    return Column(
              children: [
                // const SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(width: 20.0,),
                      const Text('Koszt zamówienia'),
                      Text(controller.orderValue.value.toStringAsFixed(2), style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(width: 20.0,),
                      const Text('Koszt dostawy'),
                      Obx(() {
                        return Text(controller.deliveryCost.value.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700));
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const SizedBox(width: 20.0,),
                      const Text('Całkowity koszt'),
                      Obx(() {
                        return Text(controller.totalValue.value.toStringAsFixed(2),
                          style: const TextStyle(color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.w700),);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0,),
                CupertinoButton(
                  color: Colors.black,
                    onPressed: () async{
                  ModifyUserController modifyUserController = Get.find();
                  if(controller.paymentMethod.value == 'voucher'){
                    await controller.createNewOrder();
                    userDataController.voucherValue.value -= controller.totalValue.value;
                    await modifyUserController.modifyUserValue(
                        userID: userDataController.userData.userID,
                        value: userDataController.voucherValue.value,
                        valueID: 'voucherValue');

                  }else{
                    await controller.createNewOrder();

                    // ///Stripe payment
                    // final intent = await paymentController.createPaymentIntent();
                    // await paymentController.initPaymentSheet(paymentIntent: intent);
                    // await paymentController.displayPaymentSheet();
                    // ///payment STRIPE
                  }
                  if(userDataController.bonusPointsValue.value == 7){
                    userDataController.freeProducts.value += 1;
                    userDataController.bonusPointsValue.value = 0;
                      await modifyUserController.modifyUserValue(
                      userID: userDataController.userData.userID,
                      valueID: 'userBonusPoints',
                      value: userDataController.bonusPointsValue.value,
                    );
                      modifyUserController.modifyUserValue(
                      userID: userDataController.userData.userID,
                      valueID: 'productsForFree',
                      value: userDataController.freeProducts.value,
                    );
                  }else{
                    userDataController.bonusPointsValue.value += 1;
                    modifyUserController.modifyUserValue(
                        userID: userDataController.userData.userID,
                        valueID: 'userBonusPoints',
                        value: userDataController.bonusPointsValue.value
                    );
                  }
                  OrderController orderController = Get.find();
                  ///send notification to user about next steps
                  await NotificationText(
                    orderValue: orderController.orderValue.value.toString(),
                    mobileToken: userDataController.userData.mobileToken,
                    orderNumber: orderController.orderNumber,
                    paymentMethod: orderController.paymentMethod.value,
                  ).sendNotificationInfoAboutOrder();
                  ///send notification to admin about new order
                  await NotificationText(
                    mobileToken: '',
                    orderNumber: orderController.orderNumber,
                    orderValue: orderController.orderValue.value.toString()
                  ).sendNotificationToAdmin();

                  Get.toNamed('/start_page');

                }, child: const Text('Zamawiam')),
              ],
            );
  }
///method responsible for delivery method view
  Column deliveryMethod(bool isVoucher) {
    return Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 20.0,),
                    Text('Dostawa: '),
                  ],
                ),
                const SizedBox(height: 20.0,),
                isVoucher? const Center(child: Text('Dostawa elektroniczna')) : Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomOrderWidget(
                        key: const Key('courier'),
                        text1: 'Kurier',
                        text2: '$COURIER_COST PLN',
                        icon: Icon(Icons.drive_eta_outlined,
                          size: controller.deliveryMethod.value == 'courier' ? 60 : 30,),
                        size: 120.0,),
                      CustomOrderWidget(
                          key: Key('own_transport'),
                          text1: 'Odbiór własny',
                          text2: '0 PLN',
                          icon: Icon(Icons.handshake_outlined,
                            size: controller.deliveryMethod.value == 'own_transport' ? 60 : 30,),
                          size: 120.0),

                    ],
                  );
                }),
              ],
            );
  }
///method responsible for payment method
  Column paymentMethod(bool isVoucher) {
    return Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 20.0,),
                    Text('Wybierz metodę płatności: '),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomOrderWidget(
                        key: const Key('cash'),
                        text1: 'Gotówka',
                        text2: '',
                        icon: Icon(Icons.money,
                            size: controller.paymentMethod.value == 'cash' ? 50 : 30),
                        size: 120.0,),
                      CustomOrderWidget(
                        key: const Key('blik'),
                        text1: 'Blik',
                        text2: '',
                        icon: Icon(Icons.install_mobile,
                          size: controller.paymentMethod.value == 'blik' ? 50 : 30,),
                        size: 120.0,),
                      CustomOrderWidget(
                        key: const Key('bank_account'),
                        text1: 'Przelew',
                        text2: '',
                        icon: Icon(Icons.payments_rounded,
                          size: controller.paymentMethod.value == 'bank_account' ? 50 : 30,),
                        size: 100,),
                      isVoucher ? const SizedBox(): CustomOrderWidget(
                        key: const Key('voucher'),
                        text1: 'Voucher',
                        text2: '',
                        icon: Icon(Icons.card_giftcard,
                          size: controller.paymentMethod.value == 'voucher' ? 50 : 30,),
                        size: 110.0,),
                    ],
                  );
                }),
              ],
            );
  }
///method responsible for delivery address vies
  Column deliveryAddress() {
    return Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 20.0,),
                    Text('Adres dostawy : '),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Center(
                  child: SizedBox(
                    height: 120.0,
                    width: 400,
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() {
                                return Text(controller.deliveryData.value, style: TextStyle(fontSize: 17.0),);
                              }),
                            ],
                          ),
                          Text('Zmień'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
  }
}
///widget/class responsible for payment and delivery icons on order page
class CustomOrderWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Icon icon;
  final double size;

  const CustomOrderWidget({
    required this.text1,
    required this.text2,
    required this.icon,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find();
    UserDataController userDataController = Get.find();

    return GestureDetector(
      onTap: () {
        if (key == const Key('cash')) {
          orderController.paymentMethod.value = 'cash';
        } else if (key == const Key('blik')) {
          orderController.paymentMethod.value = 'blik';
        } else if (key == const Key('bank_account')) {
          orderController.paymentMethod.value = 'bank_account';
        } else if (key == const Key('voucher')) {
          if(userDataController.voucherValue < orderController.totalValue.value){
            Get.defaultDialog(
              title: 'Uwaga',
              content: Text('Nie masz wystarczających środków na koncie'));}
          else{
            orderController.paymentMethod.value = 'voucher';
          }
        } else if (key == const Key('courier')) {
          orderController.deliveryMethod.value = 'courier';
          orderController.deliveryCost.value = COURIER_COST;
          orderController.totalValue.value += COURIER_COST;
        } else if (key == const Key('own_transport')) {
          orderController.deliveryMethod.value = 'own_transport';
          orderController.totalValue.value -= orderController.deliveryCost.value;
          orderController.deliveryCost.value = 0.0;
        }
      },
      child: SizedBox(
        height: size,
        width: size,
        child: Card(
          elevation: 0,
          // color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(text1),
              icon,
              Text(text2),
            ],
          ),
        ),
      ),
    );
  }

}
