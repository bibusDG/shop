import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  const CustomAppBar({
    super.key,
    required this.appBarTitle
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(appBarTitle),
      actions: [
        Get.currentRoute == '/registration_page' || Get.currentRoute == '/login_page' ?
        const SizedBox() : IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart_rounded)),
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(child: Text('Zaloguj się')),
              const PopupMenuItem(child: Text('Wyloguj się')),
              const PopupMenuItem(child: Text('Zarejestruj sie'))
            ];
          },),
        // const SizedBox(width: 10.0,)
      ],
    );
  }
}