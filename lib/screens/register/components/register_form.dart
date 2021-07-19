import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
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
  Future<void> _alertDialogBuilder(String errorMessage) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: Text("Error"),
              content: Container(child: Text(errorMessage)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close Dialog"))
              ]);
        });
  }

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail.trim(), password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      print(e.code);
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _needLoading = true;
    });

    String? _createAccountFeedBack = await _createAccount();
    if (_createAccountFeedBack.isNull()) {
      Navigator.pop(context);
    } else {
      _alertDialogBuilder(
          _createAccountFeedBack ?? "PLease check your internet!");
      setState(() {
        _needLoading = false;
      });
    }
  }

  bool _needLoading = false;

  //? Form Input Fields
  String _registerEmail = "";
  String _registerPassword = "";
  String _registerReEnterPassword = "";

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
        hintText: "Email...",
        onChanged: (value) {
          _registerEmail = value;
        },
        keyboardType: TextInputType.emailAddress,
        focusNode: _emailFocusNode,
        onSubmitted: (value) {
          _emailFocusNode.unfocus();
          changeFocusFrom(context, _passwordFocusNode);
        },
      ),
      CustomPasswordInput(
        hintText: "Password...",
        onChanged: (value) {
          _registerPassword = value;
        },
        focusNode: _passwordFocusNode,
        onSubmitted: (value) {
          _passwordFocusNode.unfocus();
          changeFocusFrom(context, _reEnterPasswordFocusNode);
        },
      ),
      CustomPasswordInput(
        hintText: "Re-enter...",
        onChanged: (value) {
          _registerReEnterPassword = value;
        },
        focusNode: _reEnterPasswordFocusNode,
      ),
      CustomButton(
        color: Colors.black,
        textColor: Colors.white,
        text: "Register",
        onPressed: () {
          _submitForm();
        },
        isLoading: _needLoading,
      ),
    ]);
  }
}
