import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';

import '../../../product/domain/entities/product.dart';


class BasketPage extends GetView<BasketController> {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Koszyk')),
        body: Obx(() {
          if(controller.listOfProducts.isEmpty){
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
                      return Card(
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
                                Text('Ilość sztuk'),
                              ],
                            ),
                            const SizedBox(width: 80.0,),
                            Center(child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeProductFromBasket(productID: listOfKeys[index]);
                                }
                            )),
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Cena całkowita: 1234 PLN'),
                  IconButton(
                    onPressed: (){

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
