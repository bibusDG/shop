import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/user_controller.dart';

class StartPage extends GetView<UserController> {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CupertinoButton(onPressed: () async{
        controller.createUser();
      },
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('create user'),
          ],
        ),
      ),),
    );
  }
}
