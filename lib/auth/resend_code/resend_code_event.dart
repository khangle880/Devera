abstract class ResendCodeEvent {}

class ResendCodeUserNameChanged extends ResendCodeEvent {
  ResendCodeUserNameChanged({required this.username});

  final String username;
}

class ResendSubmitted extends ResendCodeEvent {}
