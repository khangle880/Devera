import 'package:asking/auth/auth_cubit.dart';
import 'package:asking/auth/auth_repository.dart';
import 'package:asking/auth/form_submission_status.dart';
import 'package:asking/auth/sign_up/sign_up_bloc.dart';
import 'package:asking/auth/sign_up/sign_up_event.dart';
import 'package:asking/auth/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => SignUpBloc(
                authRepository: context.read<AuthRepository>(),
                authCubit: context.read<AuthCubit>()),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [_signUpForm(), _showSignUpButton(context)],
            )));
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _userNameField(),
                  _emailField(),
                  _passwordField(),
                  _signUpButton()
                ])),
      ),
    );
  }

  Widget _userNameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'User Name'),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpUserNameChange(username: value)),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Email'),
        validator: (value) => state.isValidEmail ? null : 'Email is not valid',
        onChanged: (value) =>
            context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too weak',
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChange(password: value)),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: Text('SignUp'));
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
            onPressed: () => context.read<AuthCubit>().showLogin(),
            child: Text("Have an Account?, Sign in")));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
