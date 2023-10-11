import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/basket/presentation/getx/basket_controller.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBar({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    BasketController controller = Get.find();
    return AppBar(
      centerTitle: true,
      title: Text(appBarTitle),
      actions: [
        Get.currentRoute == '/registration_page' || Get.currentRoute == '/login_page' ?
        const SizedBox() : Stack(
            children: [
              Obx(() {
                return controller.listOfProducts.isEmpty? const SizedBox() :
                Text(controller.listOfProducts.length.toString());
              }),
              IconButton(onPressed: () {
                Get.toNamed('/basket_page');

              }, icon: const Icon(Icons.shopping_cart_rounded)),
            ]
        ),
        PopupMenuButton(
          onSelected: (value) {
            if (value == 2) {
              Get.toNamed('/registration_page');
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                  value: 0,
                  child: Text('Zaloguj się')),
              const PopupMenuItem(
                  value: 1,
                  child: Text('Wyloguj się')),
              const PopupMenuItem(
                  value: 2,
                  child: Text('Zarejestruj sie'))
            ];
          },),
        // const SizedBox(width: 10.0,)
      ],
    );
  }
}