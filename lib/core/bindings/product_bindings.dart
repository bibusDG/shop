import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop/features/product/domain/usecases/create_product_usecase.dart';
import 'package:shop/features/product/domain/usecases/get_product_usecase.dart';

import '../../features/product/data/datasources/product_data_source.dart';
import '../../features/product/data/repositories/product_repo_imp.dart';
import '../../features/product/domain/repositories/product_repo.dart';
import '../../features/product/domain/usecases/stream_product_usecase.dart';
import '../../features/product/presentation/getx/product_controller.dart';
import '../../features/product_categories/data/datasources/product_category_data_source.dart';

class ProductBindings implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ProductDataSource>(() => ProductDataSourceImp());
    Get.lazyPut<ProductRepo>(() => ProductRepoImp(productDataSource: Get.find()));
    Get.lazyPut(() => StreamProductUseCase(productRepo: Get.find()));
    Get.lazyPut(() => GetProductUseCase(productRepo: Get.find()));
    Get.lazyPut(()=> CreateProductUseCase(productRepo: Get.find()));

    Get.lazyPut(() => ProductController(
      streamProductUseCase: Get.find(), getProductUseCase: Get.find(),
      createProductUseCase: Get.find(),
    ));
    // TODO: implement dependencies
  }

}