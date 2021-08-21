abstract class SignUpEvent {}

class SignUpEmailChanged extends SignUpEvent {
  SignUpEmailChanged({
    required this.email,
  });

  final String email;
}

class SignUpPasswordChanged extends SignUpEvent {
  SignUpPasswordChanged({
    required this.password,
  });

  final String password;
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  SignUpConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;
}

class SignUpSubmitted extends SignUpEvent {}
