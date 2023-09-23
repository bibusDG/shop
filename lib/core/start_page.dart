import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import 'custom_widgets/custom_app_bar.dart';

class StartPage extends GetView {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Get.put(UserDataController());

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
          child: CustomAppBar(appBarTitle: 'SKLEP',)),
      body: CupertinoButton(onPressed: () async{
        // controller.createUser();
      },
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cześć'),
          ],
        ),
      ),),
    );
  }
}


