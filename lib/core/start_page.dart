import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'custom_widgets/custom_app_bar.dart';

class StartPage extends GetView {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
          child: CustomAppBar(appBarTitle: 'SKLEP',)),
      body: CupertinoButton(onPressed: () async{
        // controller.createUser();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                child: Text('Cześć'), onTap: (){Get.toNamed('/product_category');},),
          ],
        ),
      ),),
    );
  }
}


