import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/error_codes.dart';
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
  Future<ErrorCode?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail.trim(), password: _loginPassword.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return signInErrorCodes(e.code);
    } catch (e) {
      return const ErrorCode(
          errorType: 'Unexpected Error!',
          errorDescription: 'Unexpected error has occurred.');
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _needLoading = true;
    });

    final ErrorCode? _loginAccoutFeedBack = await _loginAccount();
    if (_loginAccoutFeedBack != null) {
      alertDialogBuilder(context, _loginAccoutFeedBack.getErrorType(),
          _loginAccoutFeedBack.getErrorDescription());
      setState(() {
        _needLoading = false;
      });
    }
  }

  bool _needLoading = false;

  //? Form Input Fields
  String _loginEmail = '';
  String _loginPassword = '';

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
          hintText: 'Email...',
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            _loginEmail = value;
          },
          focusNode: _emailFocusNode,
          onSubmitted: (String value) {
            _emailFocusNode.unfocus();
            changeFocusFrom(context, _passwordFocusNode);
          }),
      CustomPasswordInput(
          hintText: 'Password...',
          onChanged: (String value) {
            _loginPassword = value;
          },
          focusNode: _passwordFocusNode,
          onSubmitted: (String value) {
            _passwordFocusNode.unfocus();
          }),
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: 'Login',
        onPressed: () {
          _submitForm();
        },
        isLoading: _needLoading,
      ),
    ]);
  }
}
