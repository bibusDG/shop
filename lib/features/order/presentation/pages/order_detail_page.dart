import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/notifications/presentation/getx/user_notification_controller.dart';
import 'package:shop/features/order/data/models/user_order_model.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../../../core/classes/notification_text.dart';

class OrderDetailPage extends GetView<OrderController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserDataController userDataController = Get.find();
    ModifyUserController modifyUserController = Get.find();
    UserNotificationController userNotificationController = Get.find();

    UserOrderModel order = Get.arguments;
    controller.orderStatus.value = order.orderStatus;
    var deliveryAddress = order.deliveryAddress.split(',').join(' ');

    return Scaffold(
          bottomSheet: userDataController.userData.isAdmin == true ?
          AdminOrderModification(
            controller: controller,
            order: order,
            modifyUserController: modifyUserController,
            userNotificationController: userNotificationController,
          ) : const SizedBox(),
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(appBarTitle: 'Szczegóły zamówienia')),
          body: Center(
                child: Column(
                  children: [
                    Expanded(flex:2, child: deliveryDestination(deliveryAddress)),
                    Expanded(flex:2, child: listOfOrderedProducts(order)),
                    Expanded(flex:1, child: orderCost(order)),
                    Expanded(flex:1, child: dateNumberOfDelivery(order)),
                    Expanded(flex:1, child: paymentMethod(order)),
                    Expanded(flex:1, child: orderStatus(order)),

                  ],
                ),
              )
        );
  }
///method responsible for delivery adress view
  Column deliveryDestination(String deliveryAddress) {
    return Column(children: [
                    const Text('Adres dostawy: '),
                    const SizedBox(height: 15.0,),
                    Text(deliveryAddress, style: const TextStyle(fontSize: 20.0),),
                  ],);
  }
///method responsible for list of orders view
  Column listOfOrderedProducts(UserOrderModel order) {
    return Column(children: [
                    const Text('Zamówione produkty: '),
                    const SizedBox(height: 20.0,),
                    Flexible(
                      child: SizedBox(
                        child: ListView.separated(
                            itemCount: order.orderedProducts.length,
                            // itemExtent: 70.0,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 0,
                                // color: Colors.white,
                                child: Center(
                                    child: Text(order.orderedProducts[index], style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return
                          const Divider(endIndent: 20.0, indent: 20.0, color: Colors.black, thickness: 0.5,);  },),
                      ),
                    ),
                  ],);
  }
///method responsible for total order cost view
  Column orderCost(UserOrderModel order) {
    return Column(children: [
                    const Text('Całkowity koszt zamówienia:'),
                    const SizedBox(height: 20.0,),
                    Text('${order.orderPrice} PLN', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  ],);
  }
///method responsible for order data (date, order number) view
  Column dateNumberOfDelivery(UserOrderModel order) {
    return Column(
                    children: [
                      const Text('Data i numer zamówienia:'),
                      const SizedBox(height: 20.0,),
                      Text('${order.orderTime.substring(0, 10)}, nr.${order.orderNumber}',
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ],
                  );
  }
///method responsible for payment view
  Column paymentMethod(UserOrderModel order) {
    return Column(
                    children: [
                      const Text('Rodzaj płatności:'),
                      const SizedBox(height: 20.0,),
                      Text(order.paymentMethod == 'cash' ? 'Gotówka' : order.paymentMethod == "blik" ? 'Blik na telefon' : order.paymentMethod == "voucher" ? 'Voucher' :'Przelew',
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ],
                  );
  }
///method responsible for order status
  Column orderStatus(UserOrderModel order) {
    return Column(
                    children: [
                      const Text('Status zamówienia:'),
                      const SizedBox(height: 20.0,),
                      Text(order.orderStatus, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ],
                  );
  }
}
///class responsible for admin panel in order detail page (modification of order status)
class AdminOrderModification extends StatelessWidget {
  final OrderController controller;
  final UserOrderModel order;
  final ModifyUserController modifyUserController;
  final UserNotificationController userNotificationController;

  const AdminOrderModification({
    required this.modifyUserController,
    required this.controller,
    required this.order,
    required this.userNotificationController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                ///get token from user
                String userToken = await getUserMobileToken();
                ///send notification to user abour order status
                NotificationText(
                    operationStatus: controller.orderStatus.value,
                    orderNumber: order.orderID,
                    mobileToken: userToken
                ).sendNotificationToUser();
                ///

              }else{
                await controller.modifyOrderByAdmin(orderID: order.orderID, orderStatus: controller.orderStatus.value);
                ///get user mobileToken
                String userToken = await getUserMobileToken();
                ///send notification about order status
                NotificationText(
                    operationStatus: controller.orderStatus.value,
                    orderNumber: order.orderNumber,
                    mobileToken: userToken
                ).sendNotificationToUser();
              }

            }),
          ],
        );
      }),
    );
  }

    getUserMobileToken() async{
    final user = await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).collection('users').doc(order.userID).get();
    Map<String, dynamic>? dd = user.data();
    return dd!['mobileToken'];
  }

}
