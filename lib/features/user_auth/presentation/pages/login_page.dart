import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/core/custom_widgets/custom_text_form_field.dart';
import 'package:shop/features/user_auth/presentation/getx/login_user_controller.dart';

class LoginPage extends GetView<LoginUserController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(appBarTitle: 'Strona logowania',),),
        body: Center(
            child: Column(
              children: [
                const SizedBox(height: 20.0,),
                CustomTextForm(
                    key: const Key('email'),
                    textEditingController: controller.loginEmailTextInput,
                    obscureText: false,
                    hintText: '',
                    labelText: 'e-mail',
                    mustContainText: '@',
                    notAllowedText: ' ',
                    textLength: 6,
                    keyboardType: TextInputType.emailAddress),
                CustomTextForm(
                    key: Key('password'),
                    textEditingController: controller.loginPasswordTextInput,
                    obscureText: true,
                    hintText: '',
                    labelText: 'hasło',
                    mustContainText: '',
                    notAllowedText: ' ',
                    textLength: 6,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 30.0,),
                CupertinoButton(child: Text('Zaloguj'), onPressed: (){
                  controller.loginUser();
                }),
              ],
            )),
      );
  }
}
