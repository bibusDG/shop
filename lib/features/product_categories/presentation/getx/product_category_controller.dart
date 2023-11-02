import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/usecases/stream_product_category_usecase.dart';

import '../../domain/usecases/create_product_category_usecase.dart';
import '../../domain/usecases/delete_product_category_usecase.dart';
import '../../domain/usecases/modify_product_category_usecase.dart';

class ProductCategoryController extends GetxController{
  final StreamProductCategoryUseCase streamProductCategoryUseCase;
  final CreateProductCategoryUseCase createProductCategoryUseCase;
  final DeleteProductCategoryUseCase deleteProductCategoryUseCase;
  final ModifyProductCategoryUseCase modifyProductCategoryUseCase;
  ProductCategoryController ({
    required this.streamProductCategoryUseCase,
    required this.createProductCategoryUseCase,
    required this.deleteProductCategoryUseCase,
    required this.modifyProductCategoryUseCase,
  });

  TextEditingController productCategoryName = TextEditingController();
  bool editCategory = false;
  RxString categoryImage = ''.obs;


   Stream<List<ProductCategory>> streamProductCategory() async*{
    final result =  await streamProductCategoryUseCase.productCategoryRepo.streamProductCategories();
    yield* result.fold((failure){
      // print(failure);
      return Stream.value([]);
    }, (stream){
      return stream;
    });
  }

  Future<void> createNewCategory() async{
     final result = await createProductCategoryUseCase(
         CreateProductCategoryUseCaseParams(
             productCategoryName: productCategoryName.text,
             productCategoryPicture: categoryImage.value,
             productCategoryID: ''));
     result.fold((failure){
       return Get.snackbar('Uwaga', 'Nie można utworzyć nowej kategorii');
     }, (result){
       Get.back();
       deleteControllerWhenSaved();
       return Get.snackbar('Udało się', 'nowa kategoria utworzona');
     });
  }

  Future<void> deleteCategory({productCategoryID}) async{
     final result = await deleteProductCategoryUseCase(DeleteProductCategoryParams(
         productCategoryID: productCategoryID));
     result.fold((l){
       return Get.snackbar('Uwaga', 'nie można usunąć kategorii');
     }, (result){
       Get.back();
       return Get.snackbar('Udało się', 'kategoria usunięta');
     });
  }

  Future<void> modifyCategory({required ProductCategory category, required String image}) async{
     final result = await modifyProductCategoryUseCase(
         ModifyProductCategoryParams(
             productCategoryID: category.productCategoryID,
             productCategoryPicture: image,
             productCategoryName: category.productCategoryName));
     result.fold((failure){
       return Get.snackbar('Uwaga', 'nie można zmienić zdjęcia');
     }, (result){
       return Get.snackbar('Udało się', 'usawiono nowe zdjęcie kategorii');
     });
  }

  Future<void> deleteControllerWhenSaved() async{
     productCategoryName.text = '';
     categoryImage.value = '';
  }

}