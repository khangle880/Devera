import 'package:asking/models/ModelProvider.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  Authenticated({
    this.user,
  });

  final User? user;
  User? selectedUser;
}
