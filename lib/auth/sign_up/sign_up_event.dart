abstract class SignUpEvent {}

class SignUpUserNameChange extends SignUpEvent {
  SignUpUserNameChange({
    required this.username,
  });

  final String username;
}

class SignUpEmailChanged extends SignUpEvent {
  SignUpEmailChanged({
    required this.email,
  });

  final String email;
}

class SignUpPasswordChange extends SignUpEvent {
  SignUpPasswordChange({
    required this.password,
  });

  final String password;
}

class SignUpSubmitted extends SignUpEvent {}
