import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/modify_user_controller.dart';
import '../../../../core/custom_widgets/custom_text_form_field.dart';

class RegistrationPage extends GetView<CreateUserController> {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ModifyUserController modifyUserController = Get.find();

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: CustomAppBar(appBarTitle: controller.registrationPage == true ? 'REJESTRACJA' : 'ZMIANA DANYCH',),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10.0,),
                  CustomTextForm(
                    textEditingController: controller.userNameTextField,
                    obscureText: false,
                    key: const Key('userName'),
                    createUserController: controller,
                    hintText: 'Podaj imię',
                    labelText: 'imię *',
                    mustContainText: '',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.text,),
                  CustomTextForm(
                    textEditingController: controller.userSurnameTextField,
                    obscureText: false,
                    key: const Key('userSurname'),
                    createUserController: controller,
                    hintText: 'Podaj nazwisko',
                    labelText: 'nazwisko *',
                    mustContainText: '',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.text,),
                  CustomTextForm(
                    textEditingController: controller.userEmailTextField,
                    obscureText: false,
                    key: const Key('email'),
                    createUserController: controller,
                    hintText: 'Podaj email',
                    labelText: 'email *',
                    mustContainText: '@',
                    notAllowedText: ' ',
                    textLength: 5,
                    keyboardType: TextInputType.emailAddress,),
                  CustomTextForm(
                    textEditingController: controller.userCityTextField,
                      obscureText: false,
                      key: const Key('cityName'),
                      createUserController: controller,
                      hintText: 'Podaj miejscowość',
                      labelText: 'miasto *',
                      mustContainText: '',
                      notAllowedText: '@',
                      textLength: 1,
                      keyboardType: TextInputType.text),
                  CustomTextForm(
                    textEditingController: controller.userPostalCodeTextField,
                    obscureText: false,
                    key: const Key('postalCode'),
                    createUserController: controller,
                    hintText: 'Podaj kod pocztowy',
                    labelText: 'kod *',
                    mustContainText: '',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.number,),
                  CustomTextForm(
                    textEditingController: controller.userAddressTextField,
                    obscureText: false,
                    key: const Key('address'),
                    createUserController: controller,
                    hintText: 'Podaj adres',
                    labelText: 'adres *',
                    mustContainText: '',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.streetAddress,),
                  CustomTextForm(
                    textEditingController: controller.userMobilePhoneTextField,
                    obscureText: false,
                    key: const Key('phone'),
                    createUserController: controller,
                    hintText: 'telefon',
                    labelText: 'telefon *',
                    mustContainText: '+48',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.number,),
                  CustomTextForm(
                    textEditingController: controller.userPasswordTextField,
                    obscureText: true,
                    key: const Key('password'),
                    createUserController: controller,
                    hintText: 'Podaj hasło',
                    labelText: 'hasło *',
                    mustContainText: '',
                    notAllowedText: '@',
                    textLength: 1,
                    keyboardType: TextInputType.text,),
                  const SizedBox(height: 5,),
                  Obx(() {
                    if(controller.registrationPage == true){
                      return CupertinoButton(onPressed: controller.activateRegistrationButton.value ? () async {
                        await controller.createUser();
                      } : null ,child: Text('Zarejestruj'),);
                    } else{
                      return CupertinoButton(onPressed: controller.activateRegistrationButton.value ? () async{
                        await modifyUserController.modifyUser();
                      } : null, child: Text('Zmień'));
                    }
                  })

                ],
              ),

            ),
          ),
      ),
    );
  }
}