abstract class ForgotPasswordEvent {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  ForgotPasswordEmailChanged({
    required this.email,
  });

  final String email;
}

class FogotPasswordSubmitted extends ForgotPasswordEvent {}
