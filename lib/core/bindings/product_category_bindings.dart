import 'package:get/get.dart';
import 'package:shop/features/product_categories/data/datasources/product_category_data_source.dart';
import 'package:shop/features/product_categories/data/repositories/product_category_repo_imp.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';
import 'package:shop/features/product_categories/domain/usecases/stream_product_category_usecase.dart';
import 'package:shop/features/product_categories/presentation/getx/product_category_controller.dart';

class ProductCategoryBindings implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ProductCategoryDataSource>(() => ProductCategoryDataSourceImp());
    Get.lazyPut<ProductCategoryRepo>(() => ProductCategoryRepoImp(productCategoryDataSource: Get.find()));
    Get.lazyPut(() => StreamProductCategoryUseCase(productCategoryRepo: Get.find()));
    Get.lazyPut(() => ProductCategoryController(
      streamProductCategoryUseCase: Get.find(),
    ));
    // TODO: implement dependencies
  }

}