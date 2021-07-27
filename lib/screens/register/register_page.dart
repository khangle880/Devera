import 'package:flutter/material.dart';
import 'package:laptop/animations/bouncing_page_route.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/login/login_page.dart';
import 'package:laptop/screens/register/components/register_form.dart';
import 'package:laptop/widgets/custom_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: const Text("Welcome user\n Create your new account",
                    textAlign: TextAlign.center, style: Constants.boldHeading),
              ),
              const RegisterForm(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  color: Colors.black,
                  textColor: Colors.black,
                  text: "Have an Account? Login",
                  outLineButton: true,
                  onPressed: () {
                    Navigator.push(
                        context, BouncingPageRoute(widget: const LoginPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
