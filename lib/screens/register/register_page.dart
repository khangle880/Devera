import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/login/login_page.dart';
import 'package:laptop/screens/register/components/register_form.dart';
import 'package:laptop/widgets/custom_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                child: Text("Welcome user\n Create your new account",
                    textAlign: TextAlign.center, style: Constants.boldHeading),
              ),
              RegisterForm(),
              CustomButton(
                color: Colors.black,
                textColor: Colors.black,
                text: "Have an Account? Login",
                outLineButton: true,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
