abstract class SignUpEvent {}

class SignUpFirstNameChanged extends SignUpEvent {
  SignUpFirstNameChanged({
    required this.firstName,
  });

  final String firstName;
}

class SignUpLastNameChanged extends SignUpEvent {
  SignUpLastNameChanged({
    required this.lastName,
  });

  final String lastName;
}

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

class SignUpSubmitted extends SignUpEvent {}
