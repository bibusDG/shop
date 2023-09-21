import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';

import '../../../../core/custom_widgets/custom_text_form_field.dart';
import '../../../../core/custom_widgets/custom_text_input_widget.dart';

class RegistrationPage extends GetView<CreateUserController> {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomAppBar(appBarTitle: 'REJESTRACJA',),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10.0,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('userName'),
                  controller: controller.userNameTextField,
                  hintText: 'Podaj imię',
                  labelText: 'imię *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.text,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('userSurname'),
                  controller: controller.userSurnameTextField,
                  hintText: 'Podaj nazwisko',
                  labelText: 'nazwisko *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.text,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('email'),
                  controller: controller.userEmailTextField,
                  hintText: 'Podaj email',
                  labelText: 'email *',
                  mustContainText: '@',
                  notAllowedText: ' ',
                  textLength: 5,
                  keyboardType: TextInputType.emailAddress,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('cityName'),
                  controller: controller.userCityTextField,
                  hintText: 'Podaj miejscowość',
                  labelText: 'miasto *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.text),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('postalCode'),
                  controller: controller.userPostalCodeTextField,
                  hintText: 'Podaj kod pocztowy',
                  labelText: 'kod *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.number,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('address'),
                  controller: controller.userAddressTextField,
                  hintText: 'Podaj adres',
                  labelText: 'adres *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.streetAddress,),
                CustomTextForm(
                  obscureText: false,
                  key: const Key('phone'),
                  controller: controller.userMobilePhoneTextField,
                  hintText: 'Podaj numer telefonu',
                  labelText: '+telefon *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.number,),
                CustomTextForm(
                  obscureText: true,
                  key: const Key('password'),
                  controller: controller.userPasswordTextField,
                  hintText: 'Podaj hasło',
                  labelText: 'hasło *',
                  mustContainText: '',
                  notAllowedText: '@',
                  textLength: 1,
                  keyboardType: TextInputType.text,),
                const SizedBox(height: 5,),
                CupertinoButton(child: const Text('Zarejestruj'), onPressed: () async{
                  await controller.createUser();
                }),

              ],
            ),

          ),
        ),
      ),
    );
  }
}




// SingleChildScrollView(
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const SizedBox(height: 50.0,),
// CustomTextInput(
// controller: controller.userNameTextField,
// prefixText: ' imię: ',
// inputType: TextInputType.name,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userSurnameTextField,
// prefixText: ' nazwisko: ',
// inputType: TextInputType.name,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userEmailTextField,
// prefixText: ' e-mail: ',
// inputType: TextInputType.emailAddress,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userCountryTextField,
// prefixText: ' miasto: ',
// inputType: TextInputType.text,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userPostalCodeTextField,
// prefixText: ' kod pocztowy: ',
// inputType: TextInputType.number,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userAddressTextField,
// prefixText: ' adres: ',
// inputType: TextInputType.streetAddress,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userMobilePhoneTextField,
// prefixText: ' telefon: ',
// inputType: TextInputType.phone,
// obscureText: false),
// const SizedBox(height: 10.0,),
// CustomTextInput(
// controller: controller.userPasswordTextField,
// prefixText: ' hasło: ',
// inputType: TextInputType.text,
// obscureText: true),
// const SizedBox(height: 30.0,),
// CupertinoButton(child: const Text('Zarejstruj'), onPressed: () async{
// await controller.createUser();
// }),
// ],
// ),
// ),
// )