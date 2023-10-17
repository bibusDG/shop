import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
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

    return ResponsiveScaledBox(
        width: 430,
        child: Scaffold(
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
                        const SizedBox(height: 30.0,),
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
                        const SizedBox(height: 50.0,),
                        SizedBox(
                            height: 260,
                            child: Text(controller.productData.productDescription)),
                        const SizedBox(height: 20.0,),
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
                                    await basketController.addProductToBasket(product: controller.productData);
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

        ));
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