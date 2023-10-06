import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/features/basket/data/datasources/local_data_base.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';

import '../../../../core/custom_widgets/custom_app_bar.dart';

class ProductDetailsPage extends GetView<ProductController> {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BasketController basketController = Get.find();

    return ResponsiveScaledBox(
      width: 430,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: CustomAppBar(appBarTitle: controller.productData.productName)),
          body: Center(child: IconButton(
              onPressed: () async{
                await basketController.addProductToBasket(
                    product: controller.productData);
                Get.toNamed('/basket_page');
              }, icon: Icon(Icons.add),)),
        ));
  }
}
