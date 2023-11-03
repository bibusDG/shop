import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/string_to_image.dart';
import 'package:shop/core/custom_widgets/custom_photo_view.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';
import '../../../../core/custom_widgets/custom_app_bar.dart';


class ProductDetailsPage extends GetView<ProductController> {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasketController basketController = Get.find();
    UserDataController userData = Get.find();

    // Image myImage = StringToImage().getSingleImage(image: );
    List<Image> myImages = const StringToImage().getListOfImage(listOfImage: controller.productData.productGallery);


    return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: CustomAppBar(appBarTitle: controller.productData.productName)),
          body: Center(
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                      child: CustomPhotoView(galleryItems: myImages),
                    )),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(controller.productData.productName,
                              style: const TextStyle(fontSize: 25.0, color: Colors.black),),
                            Text('${controller.productData.productPrice.toString()} PLN',
                                style: const TextStyle(fontSize: 25.0, color: Colors.black)
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        SizedBox(
                            height: 260,
                            child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.productData.productDescription, textAlign: TextAlign.justify,),
                                ))),
                        // const SizedBox(height: 20.0,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(controller.productData.productAvailability <= 0 ? 'Produkt niedostępny' :
                              'Dostępna ilość: ${controller.availability.value}'),
                              IconButton(
                                onPressed: controller.productData.productAvailability <= 0 ? null :
                                    () async {
                                  if (userData.userLoginStatus.value == false) {
                                    Get.defaultDialog(
                                        title: 'Uwaga',
                                        content: const Text('Aby dodać produkt do koszyka musisz być zalogowany')
                                    );
                                  } else {
                                    checkBasketProducts(basketController, controller);
                                      // await basketController.addProductToBasket(product: controller.productData);
                                    }
                                },
                                icon: const Icon(Icons.add_shopping_cart),
                                iconSize: 25,
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: Colors.black, // <-- Button color
                                  foregroundColor: Colors.white, // <-- Splash color
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Future<void> checkBasketProducts(BasketController basketController, ProductController productController) async{

    basketController.listOfProducts.isEmpty? basketController.voucherInBasket = false : null;

    if(basketController.voucherInBasket == false && basketController.listOfProducts.isEmpty){
      await basketController.addProductToBasket(product: controller.productData);
      if(productController.productData.productName.contains('Voucher')){
        basketController.voucherInBasket = true;
      }else{
        basketController.voucherInBasket = false;
      }
    }else if(basketController.voucherInBasket == false && productController.productData.productName.contains('Voucher')){
      Get.defaultDialog(
        title: 'Uwaga',
        content: const Text('Zakup voucherów zrealizuj w osobnym zamówieniu')
      );

    }else if(basketController.voucherInBasket == true && !productController.productData.productName.contains('Voucher')){
      Get.defaultDialog(
          title: 'Uwaga',
          content: const Text('Zamów vouchery, a resztę zrealizuj w innym zamówieniu')
      );
    }else if(basketController.voucherInBasket == false && !productController.productData.productName.contains('Voucher')){
      await basketController.addProductToBasket(product: controller.productData);
      basketController.voucherInBasket = false;
    }else if(basketController.voucherInBasket == true && productController.productData.productName.contains('Voucher')){
      await basketController.addProductToBasket(product: controller.productData);
      basketController.voucherInBasket = true;
    }


  }

}

// IconButton(
// onPressed: () async {
// if(userData.userLoginStatus.value == false){
// Get.defaultDialog(
// title: 'Uwaga',
// content: const Text('Aby dodać produkt do koszyka musisz być zalogowany')
// );
// }else{
// await basketController.addProductToBasket(
// product: controller.productData);
// }
// }, icon: Icon(Icons.add),)

