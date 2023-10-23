import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../getx/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDataController userDataController = Get.find();
    BasketController basketController = Get.find();

    return ResponsiveScaledBox(
        width: 430,
        child: Scaffold(
          appBar: const PreferredSize(preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Zamówienie',),),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0,),
                            Text('${userDataController.userData.userName} ${userDataController.userData.userSurname}', style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w800),),
                            Obx(() {
                              return Text(controller.deliveryData.value);
                            }),
                          ],
                        ),
                        Text('Zmień'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Row(
                children: [
                  SizedBox(width: 20.0,),
                  Text('Metoda płatności: '),
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
                      icon: const Icon(Icons.money, size: 70),
                      size: controller.paymentMethod.value == 'cash' ? 150.0 : 120.0,),
                    CustomOrderWidget(
                      key: const Key('blik'),
                      text1: 'Blik',
                      text2: '',
                      icon: const Icon(Icons.install_mobile, size: 70,),
                      size: controller.paymentMethod.value == 'blik' ? 150.0 : 120.0,),
                    CustomOrderWidget(
                      key: const Key('bank_account'),
                      text1: 'Przelew',
                      text2: '',
                      icon: const Icon(Icons.payments_rounded, size: 70,),
                      size: controller.paymentMethod.value == 'bank_account' ? 150.0 : 120.0,),
                  ],
                );
              }),
              const SizedBox(height: 20.0,),
              const Row(
                children: [
                  SizedBox(width: 20.0,),
                  Text('Dostawa: '),
                ],
              ),
              const SizedBox(height: 20.0,),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOrderWidget(
                      key: const Key('courier'),
                      text1: 'Kurier',
                      text2: '$COURIER_COST PLN',
                      icon: const Icon(Icons.drive_eta_outlined, size: 60,),
                      size: controller.deliveryMethod.value == 'courier' ? 150.0 : 120.0,),
                    CustomOrderWidget(
                        key: Key('own_transport'),
                        text1: 'Odbiór własny',
                        text2: '0 PLN',
                        icon: const Icon(Icons.handshake_outlined, size: 60,),
                        size: controller.deliveryMethod.value == 'own_transport' ? 150.0 : 120.0),

                  ],
                );
              }),
              const SizedBox(height: 30.0,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // const SizedBox(width: 20.0,),
                      const Text('Koszt zamówienia'),
                      Text(controller.orderValue.value.toStringAsFixed(2)),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // const SizedBox(width: 20.0,),
                      Text('Koszt dostawy'),
                      Obx(() {
                        return Text(controller.deliveryCost.value.toStringAsFixed(2));
                      }),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // const SizedBox(width: 20.0,),
                      Text('Całkowity koszt'),
                      Obx(() {
                        return Text(controller.totalValue.value.toStringAsFixed(2));
                      }),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(onPressed: () async{
                    await controller.createNewOrder();
                    Get.toNamed('/start_page');
                  }, child: const Text('Zamawiam')),
                ],
              ),

            ],
          ),
        )
    );
  }
}

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

    return GestureDetector(
      onTap: () {
        if (key == const Key('cash')) {
          orderController.paymentMethod.value = 'cash';
        } else if (key == const Key('blik')) {
          orderController.paymentMethod.value = 'blik';
        } else if (key == const Key('bank_account')) {
          orderController.paymentMethod.value = 'bank_account';
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
          elevation: 30.0,
          color: Colors.white,
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
