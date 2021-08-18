abstract class ConfirmForgotPasswordEvent {}

class PasswordChanged extends ConfirmForgotPasswordEvent {
  PasswordChanged({
    required this.password,
  });

  final String password;
}

class ConfirmPasswordChanged extends ConfirmForgotPasswordEvent {
  ConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;
}

class ConfirmationCodeChanged extends ConfirmForgotPasswordEvent {
  ConfirmationCodeChanged({
    required this.code,
  });

  final String code;
}

class ConfirmationSubmitted extends ConfirmForgotPasswordEvent {}
