import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop/core/classes/sms_class.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/order/domain/usecases/create_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/stream_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/update_order_by_admin_usecase.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../domain/entities/user_order.dart';

class OrderController extends GetxController{
  final CreateOrderUseCase createOrderUseCase;
  final UpdateOrderByAdminUseCase updateOrderByAdminUseCase;
  final StreamOrdersUseCase streamOrdersUseCase;
  OrderController({
    required this.streamOrdersUseCase,
    required this.updateOrderByAdminUseCase,
    required this.createOrderUseCase,
});


  // RxMap<String, dynamic> orderSummary = <String, dynamic>{}.obs;

  ///observable values for order page
  RxDouble orderValue = 0.0.obs;
  RxDouble deliveryCost = 0.0.obs;
  RxDouble totalValue = 0.0.obs;
  RxString paymentMethod = 'cash'.obs;
  RxString deliveryMethod = 'own_transport'.obs;
  RxString deliveryData = ''.obs;
  List<String> listOfProducts = [];
  RxString orderStatus = ''.obs;
  String orderNumber = '';



  Future<void> modifyOrderByAdmin({orderID, orderStatus}) async{
    final result = await updateOrderByAdminUseCase(
        UpdateOrderParams(orderID: orderID, orderStatus: orderStatus));
    result.fold((failure){
      return Get.snackbar('Uwaga', 'Coś poszło nie tak');
    }, (update){
      return Get.snackbar('Udało się', 'pomyślnie zauktualizowano status');
    });
  }

  Future<void> createNewOrder() async{

    UserDataController userDataController = Get.find();
    BasketController basketController = Get.find();

    await getListOfProducts();

    generateRandomNumber();

    final result = await createOrderUseCase(
        CreateOrderParams(
        userID: userDataController.userData.userID,
        deliveryMethod: deliveryMethod.value,
        userMobile: userDataController.userData.userMobilePhone,
        orderedProducts: listOfProducts,
        orderNumber: orderNumber,
        orderStatus: 'Złożono zamówienie',
        orderID: '',
        orderPrice: totalValue.value.toPrecision(2),
        paymentMethod: paymentMethod.value,
        userEmail: userDataController.userData.userEmail,
        orderTime: DateTime.now().toString(),
        deliveryAddress: deliveryData.value));

    result.fold((failure){
      return Get.snackbar('Uwaga', 'Coś poszło nie tak');

    }, (newOrder) async{

      ProductController productController = Get.find();

      await productController.updateAvailability();

      ///todo Update user bonus points

      ///reset basket controller (list of products and product counter)
      basketController.listOfProducts.value = {};
      basketController.productCounter.value = {};
      basketController.finalPrice.value = 0.0;

      // return Get.snackbar('Udało się!', 'Zamówienie nr $orderNumber złożono pomyślnie');
      return Get.defaultDialog(
        title: 'Dziękujemy',
        content: SizedBox(child: Text(SendSms(
            paymentMethod: paymentMethod.value,
            orderNumber: orderNumber,
            orderValue: totalValue.value.toString(),
            mobilePhoneNumber: '').sendInfoAboutOrder())),
      );
    });
  }


  Stream<List<UserOrder>> streamOrders() async*{

    UserDataController userDataController = Get.find();

    final result = await streamOrdersUseCase(
        StreamOrderParams(
            userEmail: userDataController.userData.userEmail,
            isAdmin: userDataController.userData.isAdmin));
      yield* result.fold((failed){
        return Stream.value([]);
      }, (stream){
        return stream;
      });
  }

  ///function, that generates random six digit order number
  void generateRandomNumber() async{
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    orderNumber = code.toString();
    // return  code.toString();
  }

  ///function, that generates string list of products with amount
  getListOfProducts(){
    listOfProducts = [];
    BasketController basketController = Get.find();
    for(var item in basketController.listOfProducts.values){
      listOfProducts.add('${basketController.productCounter[item.productID]} x ${item.productName}');
    }

  }

}