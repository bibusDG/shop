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
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (BuildContext context) {
          return  SizedBox(
            height: 450,
            child: Column(
              children: [
                const SizedBox(height: 20.0,),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(controller.productData.productName,
                        style: const TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w200),),
                      Text('${controller.productData.productPrice.toString()} PLN',
                          style: const TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w700)
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0,),
                Expanded(
                  flex:4,
                  child: SizedBox(
                      height: 330,
                      child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 40.0, right: 40.0),
                            child: Text(controller.productData.productDescription, textAlign: TextAlign.justify,style:
                            const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),),
                          ))),
                ),
                // const SizedBox(height: 30.0,),
                Expanded(
                  flex:2,
                  child: Row(
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
                ),
              ],
            ),
          );
        },
      ),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: CustomAppBar(appBarTitle: controller.productData.productName)),
          body: AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child:CustomPhotoView(galleryItems: myImages),
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

