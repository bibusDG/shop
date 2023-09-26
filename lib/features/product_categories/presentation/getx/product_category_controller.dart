import 'package:get/get.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/usecases/stream_product_category_usecase.dart';

class ProductCategoryController extends GetxController{
  final StreamProductCategoryUseCase streamProductCategoryUseCase;
  ProductCategoryController ({required this.streamProductCategoryUseCase});

   Stream<List<ProductCategory>> streamProductCategory() async*{
    final result =  await streamProductCategoryUseCase.productCategoryRepo.streamProductCategories();
    yield* result.fold((failure){
      // print(failure);
      return Stream.value([]);
    }, (stream){
      return stream;
    });
  }

}