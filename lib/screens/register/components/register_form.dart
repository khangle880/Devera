import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/error_codes.dart';
import 'package:laptop/widgets/custom_button.dart';
import 'package:laptop/widgets/custom_input.dart';
import 'package:laptop/widgets/custom_password_input.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  Future<ErrorCode?> _createAccount() async {
    if (_registerPassword.trim() != _registerReEnterPassword.trim()) {
      return const ErrorCode(
          errorType: 'Passwords are not match!',
          errorDescription: 'Your Passwords are not match');
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail.trim(), password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return signUpErrorCodes(e.code);
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

    final ErrorCode? _createAccountFeedBack = await _createAccount();
    if (_createAccountFeedBack != null) {
      alertDialogBuilder(context, _createAccountFeedBack.getErrorType(),
          _createAccountFeedBack.getErrorDescription());
      setState(() {
        _needLoading = false;
      });
    }

    Navigator.pop(context);
  }

  bool _needLoading = false;

  //? Form Input Fields
  String _registerEmail = '';
  String _registerPassword = '';
  String _registerReEnterPassword = '';

  //? Focus node
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _reEnterPasswordFocusNode;

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _reEnterPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _reEnterPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CustomInput(
        hintText: 'Email...',
        onChanged: (String value) {
          _registerEmail = value;
        },
        keyboardType: TextInputType.emailAddress,
        focusNode: _emailFocusNode,
        onSubmitted: (String value) {
          _emailFocusNode.unfocus();
          changeFocusFrom(context, _passwordFocusNode);
        },
      ),
      CustomPasswordInput(
        hintText: 'Password...',
        onChanged: (String value) {
          _registerPassword = value;
        },
        focusNode: _passwordFocusNode,
        onSubmitted: (String value) {
          _passwordFocusNode.unfocus();
          changeFocusFrom(context, _reEnterPasswordFocusNode);
        },
      ),
      CustomPasswordInput(
        hintText: 'Re-enter...',
        onChanged: (String value) {
          _registerReEnterPassword = value;
        },
        focusNode: _reEnterPasswordFocusNode,
      ),
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: 'Register',
        onPressed: () {
          _submitForm();
        },
        isLoading: _needLoading,
      ),
    ]);
  }
}
