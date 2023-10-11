import 'package:get/get.dart';
import 'package:shop/features/basket/domain/usecases/add_product_to_basket_usecase.dart';
import 'package:shop/features/basket/domain/usecases/remove_product_from_basket_usecase.dart';

import '../../../product/domain/entities/product.dart';
import '../../domain/entities/basket.dart';

class BasketController extends GetxController{
  final AddProductToBasketUseCase addProductToBasketUseCase;
  final RemoveProductFromBasketUseCase removeProductFromBasketUseCase;

  BasketController({
    required this.addProductToBasketUseCase,
    required this.removeProductFromBasketUseCase});


  RxMap<String, Product> listOfProducts = <String, Product>{}.obs;

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
      if(listOfProducts.keys.contains(product.productID)){
        return Get.snackbar(product.productName, 'produkt jest już w koszyku');
      }
      listOfProducts[product.productID] = product;
      return Get.snackbar(product.productName, 'pomyślnie dodano do koszyka');
    });
  }

  Future<void> removeProductFromBasket({productID}) async{
    final result = await removeProductFromBasketUseCase(RemoveBasketParams(productID: productID));
    result.fold((failure){
      return Get.snackbar('Błąd', 'nie można usunąć produktu');
    }, (success){
      listOfProducts.remove(productID);
      return Get.snackbar('Udało się', 'produkt usunięty z koszyka');
    });
  }
}