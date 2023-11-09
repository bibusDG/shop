import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/order/data/models/user_order_model.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../../../core/classes/sms_class.dart';

class OrderDetailPage extends GetView<OrderController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserDataController userDataController = Get.find();
    ModifyUserController modifyUserController = Get.find();

    UserOrderModel order = Get.arguments;
    controller.orderStatus.value = order.orderStatus;
    var deliveryAddress = order.deliveryAddress.split(',').join(' ');

    return Scaffold(
          bottomSheet: userDataController.userData.isAdmin == true ?
          OrderModificationWidget(controller: controller, order: order, modifyUserController: modifyUserController,) : const SizedBox(),
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(appBarTitle: 'Szczegóły zamówienia')),
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      children: [
                        const Text('Adres dostawy: '),
                        const SizedBox(height: 15.0,),
                        Text(deliveryAddress, style: const TextStyle(fontSize: 20.0),),
                        const SizedBox(height: 20.0,),
                        const Text('Zamówione produkty: '),
                        const SizedBox(height: 20.0,),
                        SizedBox(
                          width: 300,
                          height: 160,
                          child: ListView.builder(
                              itemCount: order.orderedProducts.length,
                              itemExtent: 70.0,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(order.orderedProducts[index], style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                                );
                              }),
                        ),
                        const Text('Całkowity koszt zamówienia:'),
                        const SizedBox(height: 20.0,),
                        Text('${order.orderPrice} PLN', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20.0,),
                        const Text('Data i numer zamówienia:'),
                        const SizedBox(height: 20.0,),
                        Text('${order.orderTime.substring(0, 10)}, nr.${order.orderNumber}',
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20.0,),
                        const Text('Rodzaj płatności:'),
                        const SizedBox(height: 20.0,),
                        Text(order.paymentMethod == 'cash' ? 'Gotówka' : order.paymentMethod == "blik" ? 'Blik na telefon' : order.paymentMethod == "voucher" ? 'Voucher' :'Przelew',
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20.0,),
                        const Text('Status zamówienia:'),
                        const SizedBox(height: 20.0,),
                        Text(order.orderStatus, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

                      ],
                    ),
                  ))
            ],
          ),
        );
  }
}

class OrderModificationWidget extends StatelessWidget {
  final OrderController controller;
  final UserOrderModel order;
  final ModifyUserController modifyUserController;

  const OrderModificationWidget({
    required this.modifyUserController,
    required this.controller,
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // OrderController orderController = Get.find();
    // ModifyUserController modifyUserController = Get.find();

    return SizedBox(
      height: 100,
      child: order.orderStatus == 'Gotowe' ?
      const SizedBox(
        width: double.infinity,
        child: Center(child: Text('Zamówienie zrealizowane', style: TextStyle(fontSize: 20.0),),),
      ) :Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                   controller.orderStatus.value = 'Złożono zamówienie';
                  },
                  child: Text('Zamówione', style: controller.orderStatus.value == 'Złożono zamówienie' ?
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w900) : const TextStyle(fontSize: 12),),
                ),
                GestureDetector(
                  onTap: () {
                    controller.orderStatus.value = 'W przygotowaniu';
                  },
                  child: Text('W przygotowaniu', style: controller.orderStatus.value == 'W przygotowaniu' ?
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w900) : const TextStyle(fontSize: 12)),
                ),
                GestureDetector(
                  onTap: () {
                    controller.orderStatus.value = 'Gotowe';
                  },
                  child: Text('Gotowe', style: controller.orderStatus.value == 'Gotowe' ?
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w900) : const TextStyle(fontSize: 12),),
                ),
              ],
            ),
            CupertinoButton(child: Text('Zapisz zmiany'), onPressed: () async{
              if(order.orderedProducts[0].contains('Voucher')){
                await modifyUserController.modifyUserValue(valueID: 'voucherValue', value: order.orderPrice, userID: order.userID);
                await controller.modifyOrderByAdmin(orderID: order.orderID, orderStatus: controller.orderStatus.value);
                await SendSms(
                  orderNumber: order.orderNumber,
                  mobilePhoneNumber: order.userMobile.removeAllWhitespace,
                  operationStatus: controller.orderStatus.value,
                ).sendSmsToUser();
              }else{
                await controller.modifyOrderByAdmin(orderID: order.orderID, orderStatus: controller.orderStatus.value);
                await SendSms(
                  orderNumber: order.orderNumber,
                  mobilePhoneNumber: order.userMobile.removeAllWhitespace,
                  operationStatus: controller.orderStatus.value,
                ).sendSmsToUser();
              }

            }),
          ],
        );
      }),
    );
  }
}
