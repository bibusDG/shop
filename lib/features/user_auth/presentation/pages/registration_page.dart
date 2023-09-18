import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';

import '../../../../core/custom_widgets/custom_text_input_widget.dart';

class RegistrationPage extends GetView<CreateUserController> {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.person),
          SizedBox(width: 20.0,),
        ],
        centerTitle: true,
        title: const Text('Utwórz konto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextInput(
              controller: controller.userNameTextField,
              prefixText: ' imię: ',
              inputType: TextInputType.name,
              obscureText: false),
            const SizedBox(height: 10.0,),
            CustomTextInput(
                controller: controller.userSurnameTextField,
                prefixText: ' nazwisko: ',
                inputType: TextInputType.name,
                obscureText: false),
            const SizedBox(height: 10.0,),
            CustomTextInput(
                controller: controller.userEmailTextField,
                prefixText: ' e-mail: ',
                inputType: TextInputType.emailAddress,
                obscureText: false),
          ],
        ),
      ),
    );
  }
}


