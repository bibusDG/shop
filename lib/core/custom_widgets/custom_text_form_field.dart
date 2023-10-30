import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';

class CustomTextForm extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;
  final CreateUserController? createUserController;
  final String hintText;
  final String labelText;
  final String mustContainText;
  final String notAllowedText;
  final int textLength;
  final TextInputType keyboardType;
  const CustomTextForm({
    Key? key,
    required this.textEditingController,
    required this.obscureText,
    this.createUserController,
    required this.hintText,
    required this.labelText,
    required this.mustContainText,
    required this.notAllowedText,
    required this.textLength,
    required this.keyboardType,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 340,
      child: TextFormField(
        onChanged: (value){
          if(Get.currentRoute == '/registration_page'){
            createUserController?.createUserButtonActive();
          }
        },
        autocorrect: false,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: textEditingController,
        decoration: InputDecoration(
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),),
          hintText: hintText,
          labelText: labelText,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == '') {
            return 'Uzupełnij pole';
          }else if (value != null && key == const Key('email') && !value.contains('@')){
            return 'Brakuje $mustContainText';
          }else if(value != null && key != const Key('email') && value.contains(notAllowedText) ){
            return 'Nie używaj $notAllowedText';
          }else if (key == const Key('password') && value!.length < 6){
            return 'Hasło za krótkie';
          }
        },
      ),
    );
  }
}