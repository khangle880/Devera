import 'package:flutter/material.dart';
import 'package:laptop/animations/bouncing_page_route.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/login/components/login_form.dart';
import 'package:laptop/screens/register/register_page.dart';
import 'package:laptop/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  color: Colors.black,
                  textColor: Colors.black,
                  text: "Create New Account",
                  outLineButton: true,
                  onPressed: () {
                    Navigator.push(
                        context, BouncingPageRoute(widget: RegisterPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
