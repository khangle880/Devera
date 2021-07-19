import 'package:flutter/material.dart';
import 'package:laptop/widgets/custom_button.dart';
import 'package:laptop/widgets/custom_input.dart';
import 'package:laptop/widgets/custom_password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: "Login",
        onPressed: () {},
      ),
    ]);
  }
}
