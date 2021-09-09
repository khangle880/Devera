import 'package:icon/constants/form_submission_status.dart';

class SignUpState {
  const SignUpState(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  final String firstName;
  final String lastName;

  final String email;
  final String password;

  final FormSubmissionStatus formStatus;

  SignUpState copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? password,
      FormSubmissionStatus? formStatus}) {
    return SignUpState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
