import 'dart:math';
import 'package:get/get.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/order/domain/usecases/create_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/stream_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/update_order_by_admin_usecase.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';
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

  ///observable values for order page
  RxDouble orderValue = 0.0.obs;
  RxDouble deliveryCost = 0.0.obs;
  RxDouble totalValue = 0.0.obs;
  RxString paymentMethod = 'cash'.obs;
  RxString deliveryMethod = 'own_transport'.obs;
  RxString deliveryData = ''.obs;
  List<String> listOfProducts = [];
  RxString orderStatus = ''.obs;



  Future<void> createNewOrder() async{

    UserDataController userDataController = Get.find();
    BasketController basketController = Get.find();

    await getListOfProducts();

    final String randomNumber = generateRandomNumber();

    final result = await createOrderUseCase(
        CreateOrderParams(
        deliveryMethod: deliveryMethod.value,
        userMobile: userDataController.userData.userMobilePhone,
        orderedProducts: listOfProducts,
        orderNumber: randomNumber,
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

      return Get.snackbar('Udało się!', 'Zamówienie nr $randomNumber złożono pomyślnie');
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
  String generateRandomNumber(){
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    return  code.toString();
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