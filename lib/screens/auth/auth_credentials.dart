class AuthCredentials {
  final String email;
  final String firstName;
  final String lastName;
  String? password;
  String? pin;
  String? userId;

  AuthCredentials({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
    this.pin,
    this.userId,
  });
}
