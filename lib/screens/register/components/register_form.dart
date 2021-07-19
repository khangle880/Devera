import 'package:flutter/material.dart';
import 'package:laptop/widgets/custom_button.dart';
import 'package:laptop/widgets/custom_input.dart';
import 'package:laptop/widgets/custom_password_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CustomInput(
        hintText: "Email...",
      ),
      CustomPasswordInput(
        hintText: "Password...",
      ),
      CustomPasswordInput(
        hintText: "Re-enter...",
      ),
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: "Register",
        onPressed: () {},
      ),
    ]);
  }
}
