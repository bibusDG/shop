import 'package:get/get.dart';
import 'package:shop/features/order/data/datasources/user_order_data_source.dart';
import 'package:shop/features/order/data/repositories/user_order_repo_imp.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';
import 'package:shop/features/order/domain/usecases/create_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/stream_order_usecase.dart';
import 'package:shop/features/order/domain/usecases/update_order_by_admin_usecase.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';

class OrderBindings implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<UserOrderDataSource>(() => UserOrderDataSourceImp());
    Get.lazyPut<UserOrderRepo>(() => UserOrderRepoImp(dataSource: Get.find()));
    Get.lazyPut(() => CreateOrderUseCase(orderRepo: Get.find()));
    Get.lazyPut(() => UpdateOrderByAdminUseCase(orderRepo: Get.find()));
    Get.lazyPut(() => StreamOrdersUseCase(repo: Get.find()));
    Get.lazyPut(() => OrderController(
        streamOrdersUseCase: Get.find(),
        updateOrderByAdminUseCase: Get.find(),
        createOrderUseCase: Get.find()));

  }

}