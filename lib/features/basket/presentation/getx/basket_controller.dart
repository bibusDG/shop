import 'package:get/get.dart';
import 'package:shop/features/basket/domain/usecases/add_product_to_basket_usecase.dart';
import 'package:shop/features/basket/domain/usecases/remove_product_from_basket_usecase.dart';

import '../../../product/domain/entities/product.dart';

class BasketController extends GetxController{
  final AddProductToBasketUseCase addProductToBasketUseCase;
  final RemoveProductFromBasketUseCase removeProductFromBasketUseCase;

  BasketController({
    required this.addProductToBasketUseCase,
    required this.removeProductFromBasketUseCase});


  RxMap<dynamic, dynamic> listOfProducts = {}.obs;


  Future<void> addProductToBasket({required Product product}) async{
    final result = await addProductToBasketUseCase(
        AddBasketParams(
        productID: product.productID,
        productName: product.productName,
        productDescription: product.productDescription,
        productPrice: product.productPrice,
        productAvailability: product.productAvailability,
        productGallery: product.productGallery,
        productCategory: product.productCategory));
    result.fold((failure){
        return Get.snackbar('failure', 'message');
        }, (success) async{
      listOfProducts[product.productID] = product;
      return Get.snackbar('success', 'message');
    });
    print(listOfProducts);
  }

  Future<void> removeProductFromBasket({productID}) async{
    final result = await removeProductFromBasketUseCase(RemoveBasketParams(productID: productID));
    result.fold((failure){
      return Get.snackbar('failed', 'message');
    }, (success){
      listOfProducts.remove(productID);
      return Get.snackbar('removed', 'message');
    });
  }
}