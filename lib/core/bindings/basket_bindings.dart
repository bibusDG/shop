import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shop/features/basket/data/datasources/local_data_base.dart';
import 'package:shop/features/basket/data/repositories/basket_repo_imp.dart';
import 'package:shop/features/basket/domain/repositories/basket_repo.dart';
import 'package:shop/features/basket/domain/usecases/add_product_to_basket_usecase.dart';
import 'package:shop/features/basket/domain/usecases/remove_product_from_basket_usecase.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';

import '../../features/basket/data/datasources/basket_data_source.dart';


class BasketBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> LocalDataBase(), fenix: true);
    Get.lazyPut<BasketDataSource>(() => BasketDataSourceImp(dataBase: Get.find()));
    Get.lazyPut<BasketRepo>(() => BasketRepoImp(basketDataSource: Get.find()));
    Get.lazyPut(() => AddProductToBasketUseCase(repo: Get.find()));
    Get.lazyPut(() => RemoveProductFromBasketUseCase(repo: Get.find()));
    Get.put(BasketController(addProductToBasketUseCase: Get.find(), removeProductFromBasketUseCase: Get.find()), permanent: true);

    // TODO: implement dependencies
  }

}