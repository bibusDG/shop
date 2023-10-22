import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';
import '../../../product/domain/entities/product.dart';


class BasketPage extends GetView<BasketController> {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    OrderController orderController = Get.find();
    UserDataController userDataController = Get.find();

    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Koszyk')),
        body: Obx(() {
          if (controller.listOfProducts.isEmpty) {
            return const Center(child: Text('Koszyk jest pusty'),);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemExtent: 200,
                    itemCount: controller.listOfProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      List listOfKeys = controller.listOfProducts.keys.toList();
                      Product? product = controller.listOfProducts[listOfKeys[index]];
                      return Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Card(
                            child: Row(
                              children: [
                                const SizedBox(width: 20.0,),
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,),
                                ),
                                const SizedBox(width: 30.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product!.productName),
                                    Text('${product.productPrice} PLN'),
                                    Text('Dostępność: ${product.productAvailability}'),
                                    Row(
                                      children: [
                                        Obx(() {
                                          return Text('${controller.productCounter[product.productID]}');
                                        }),
                                        const SizedBox(width: 20.0,),
                                        Column(
                                          children: [
                                            GestureDetector(child: const Icon(Icons.add), onTap: () async{
                                              if(product.productAvailability > controller.productCounter[product.productID]!) {
                                                controller.productCounter.update(product.productID, (value) => value + 1);
                                                controller.finalPrice.value += product.productPrice;
                                              }
                                            },),
                                            GestureDetector(child: const Icon(Icons.remove),onTap: () async{
                                              if(controller.productCounter[product.productID]! > 1){
                                                controller.productCounter.update(product.productID, (value) => value - 1);
                                                controller.finalPrice.value -= product.productPrice;
                                              }

                                            },),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20.0,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.cancel, size: 40,),
                              onPressed: () async {
                                await controller.removeProductFromBasket(productID: listOfKeys[index]);
                                controller.finalPrice.value -= controller.productCounter[product.productID]! * product.productPrice;
                              }
                          )
                        ],
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Cena całkowita: ${controller.finalPrice.abs().toStringAsFixed(2)} PLN'),
                  IconButton(
                    onPressed: () async{
                      orderController.deliveryData.value = ''
                          '${userDataController.userData.userName} ${userDataController.userData.userSurname}, '
                          '${userDataController.userData.userPostalCode}, ${userDataController.userData.userCity}\n'
                          'ul. ${userDataController.userData.userAddress}';
                      orderController.orderValue.value = controller.finalPrice.value;
                      orderController.totalValue.value = controller.finalPrice.value + orderController.deliveryCost.value;
                      Get.toNamed('/order_page');
                    }, icon: const Icon(Icons.check_circle_outline_outlined), iconSize: 50,),
                ],
              ),
              const SizedBox(height: 30.0,)
            ],
          );
        }),
      ),
    );
  }
}
