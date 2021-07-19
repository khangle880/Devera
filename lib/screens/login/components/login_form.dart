import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/widgets/custom_button.dart';
import 'package:laptop/widgets/custom_input.dart';
import 'package:laptop/widgets/custom_password_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool _needLoading = false;

  //? Focus node
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CustomInput(
          hintText: "Email...",
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocusNode,
          onSubmitted: (value) {
            _emailFocusNode.unfocus();
            changeFocusFrom(context, _passwordFocusNode);
          }),
      CustomPasswordInput(
        hintText: "Password...",
        focusNode: _passwordFocusNode,
      ),
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: "Login",
        onPressed: () {
          setState(() {
            _needLoading = !_needLoading;
          });
        },
        isLoading: _needLoading,
      ),
    ]);
  }
}
