import 'package:get/get.dart';
import 'package:shop/features/basket/domain/usecases/add_product_to_basket_usecase.dart';
import 'package:shop/features/basket/domain/usecases/remove_product_from_basket_usecase.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../../product/domain/entities/product.dart';
import '../../domain/entities/basket.dart';

class BasketController extends GetxController{
  final AddProductToBasketUseCase addProductToBasketUseCase;
  final RemoveProductFromBasketUseCase removeProductFromBasketUseCase;

  BasketController({
    required this.addProductToBasketUseCase,
    required this.removeProductFromBasketUseCase});


  RxMap<String, Product> listOfProducts = <String, Product>{}.obs;
  RxMap<String, int> productCounter = <String, int>{}.obs;
  RxDouble finalPrice = 0.0.obs;
  bool voucherInBasket = false;
  
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
      }else{
        listOfProducts[product.productID] = product;
        productCounter[product.productID] = 1;
        finalPrice.value += product.productPrice;
        return Get.snackbar(product.productName, 'pomyślnie dodano do koszyka');
      }

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