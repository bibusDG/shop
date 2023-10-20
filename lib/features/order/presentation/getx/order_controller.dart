import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/order/domain/usecases/create_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/stream_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/update_order_by_admin_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../domain/entities/user_order.dart';

class OrderController extends GetxController{
  final CreateOrderUseCase createOrderUseCase;
  final UpdateOrderByAdminUseCase orderByAdminUseCase;
  final StreamOrdersUseCase streamOrdersUseCase;
  OrderController({
    required this.streamOrdersUseCase,
    required this.orderByAdminUseCase,
    required this.createOrderUseCase,
});


  // RxMap<String, dynamic> orderSummary = <String, dynamic>{}.obs;
  RxDouble orderValue = 0.0.obs;
  RxDouble deliveryCost = 0.0.obs;
  RxDouble totalValue = 0.0.obs;
  RxString paymentMethod = 'cash'.obs;
  RxString deliveryMethod = 'own_transport'.obs;

  Future<void> createNewOrder() async{

    BasketController basketController = Get.find();
    UserDataController userDataController = Get.find();

    String randomNumber = generateRandomNumber();
    String deliveryAddress = '${userDataController.userData.userPostalCode}, ${userDataController.userData.userAddress}';
    final result = await createOrderUseCase(CreateOrderParams(
        orderNumber: randomNumber,
        orderStatus: 'Złożono zamówienie',
        orderID: '',
        orderPrice: basketController.finalPrice.value,
        paymentMethod: 'cash',
        userEmail: userDataController.userData.userEmail,
        orderTime: DateTime.now().toString(),
        deliveryAddress: deliveryAddress));

    result.fold((failure){
      return Get.snackbar('Uwaga', 'Coś poszło nie tak');

    }, (newOrder){
      return Get.snackbar('Udało się!', 'Zamówienie złożono pomyślnie');
    });
  }





  Stream<List<UserOrder>> streamOrders() async*{

    UserDataController userDataController = Get.find();

    final result = await streamOrdersUseCase(
        StreamOrderParams(userEmail: userDataController.userData.userEmail, isAdmin: userDataController.userData.isAdmin));
    result.fold((failed){

    }, (stream){

    });
  }

  String generateRandomNumber(){
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    return  code.toString();
  }

}