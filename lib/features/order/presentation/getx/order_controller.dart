import 'dart:math';
import 'package:get/get.dart';
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
  RxString deliveryData = ''.obs;

  Future<void> createNewOrder() async{

    UserDataController userDataController = Get.find();

    String randomNumber = generateRandomNumber();
    final result = await createOrderUseCase(CreateOrderParams(
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
      return Get.snackbar('Udało się!', 'Zamówienie nr $randomNumber złożono pomyślnie');
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