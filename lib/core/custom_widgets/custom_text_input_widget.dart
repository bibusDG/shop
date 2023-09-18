import 'package:flutter/cupertino.dart';
import '../../features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.controller,
    required  this.prefixText,
    required this.inputType,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String prefixText;
  final TextInputType inputType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 60,
      child: CupertinoTextField(
        // onChanged: (inputText){print(inputText);},
        keyboardType: inputType,
        obscureText: obscureText,
        prefix: Text(prefixText),
        controller: controller,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}