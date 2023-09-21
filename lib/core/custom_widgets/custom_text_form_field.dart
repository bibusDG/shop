import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String mustContainText;
  final String notAllowedText;
  final int textLength;
  final TextInputType keyboardType;
  const CustomTextForm({
    required this.obscureText,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.mustContainText,
    required this.notAllowedText,
    required this.textLength,
    required this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 340,
      child: TextFormField(
        autocorrect: false,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),),
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