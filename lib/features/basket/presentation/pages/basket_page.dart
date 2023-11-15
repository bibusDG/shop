import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/classes/string_to_image.dart';
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

    return Scaffold(
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
                          elevation: 0,
                          child: Row(
                            children: [
                              const SizedBox(width: 20.0,),
                              product!.productGallery.isNotEmpty ?
                              Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: const StringToImage()
                                            .getSingleImage(image: product.productGallery[0])
                                            .image),
                                  )
                              ) : const SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Center(child: Text('No image'))),
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
                                          GestureDetector(child: const Icon(Icons.add), onTap: () async {
                                            if (product.productAvailability > controller.productCounter[product.productID]!) {
                                              controller.productCounter.update(product.productID, (value) => value + 1);
                                              controller.finalPrice.value += product.productPrice;
                                            }
                                          },),
                                          GestureDetector(child: const Icon(Icons.remove), onTap: () async {
                                            if (controller.productCounter[product.productID]! > 1) {
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
                        Column(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.cancel, size: 40,),
                                onPressed: () async {
                                  await SetFreeProduct(
                                    product: product,
                                    userDataController: userDataController,
                                    basketController: controller
                                  ).resetFreeProductBeforeDelete();
                                  await controller.removeProductFromBasket(productID: listOfKeys[index]);
                                  controller.finalPrice.value -= controller.productCounter[product.productID]! * product.productPrice;
                                }
                            ),
                            const SizedBox(height: 30.0,),
                            Obx(() {
                              return SizedBox(
                                child: SetFreeProduct(
                                    product: product,
                                    userDataController: userDataController,
                                    basketController: controller).setFreeProductIcon());
                            }),
                          ],
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
                  onPressed: () async {
                    orderController.deliveryData.value = ''
                        '${userDataController.userData.userName} ${userDataController.userData.userSurname}\n'
                        '${userDataController.userData.userPostalCode}  ${userDataController.userData.userCity}\n'
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
    );
  }
}



class SetFreeProduct{
  final UserDataController userDataController;
  final BasketController basketController;
  final Product product;
  const SetFreeProduct({
    required this.product,
    required this.basketController,
    required this.userDataController
});

  setFreeProductIcon(){
    if (userDataController.freeProducts.value > 0 && !basketController.productIsFree.contains(product.productID) && !product.productName.contains('Voucher')) {
      return GestureDetector(child: const Icon(Icons.star_outline, size: 35,), onTap: (){
        userDataController.freeProducts -= 1;
        basketController.productIsFree.add(product.productID);
        basketController.finalPrice.value -= product.productPrice;
      },);
    }else if(userDataController.freeProducts.value > 0 && basketController.productIsFree.contains(product.productID) && !product.productName.contains('Voucher')){
      return GestureDetector(child: const Icon(Icons.star, size: 35,), onTap: (){
        userDataController.freeProducts += 1;
        basketController.productIsFree.remove(product.productID);
        basketController.finalPrice.value += product.productPrice;
      },);
    }else if(userDataController.freeProducts.value == 0 && basketController.productIsFree.contains(product.productID) && !product.productName.contains('Voucher')){
      return GestureDetector(child: const Icon(Icons.star, size: 35,), onTap: (){
        userDataController.freeProducts += 1;
        basketController.productIsFree.remove(product.productID);
        basketController.finalPrice.value += product.productPrice;
      },);
    }else{
      return const SizedBox();
    }
  }

  resetFreeProductBeforeDelete(){
    if(basketController.productIsFree.contains(product.productID)){
      userDataController.freeProducts += 1;
      basketController.productIsFree.remove(product.productID);
      basketController.finalPrice.value += product.productPrice;
    }else{
      null;
    }
  }

}
