import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';


class BasketPage extends GetView<BasketController> {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Koszyk')),
      body: Obx(() {
        return ListView.builder(
            itemExtent: 120,
            itemCount: controller.listOfProducts.length,
            itemBuilder: (BuildContext context, int index) {
              List listOfKeys = controller.listOfProducts.keys.toList();
              return Card(
                child: Center(child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      controller.listOfProducts.remove(listOfKeys[index]);
                    }
                )),
              );
            });
      }),
    );
  }
}
