import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/login/components/login_form.dart';
import 'package:laptop/screens/register/register_page.dart';
import 'package:laptop/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 24),
                child: Text("Welcome user\n Login to your account",
                    textAlign: TextAlign.center, style: Constants.boldHeading),
              ),
              LoginForm(),
              CustomButton(
                color: Colors.black,
                textColor: Colors.black,
                text: "Create New Account",
                outLineButton: true,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
