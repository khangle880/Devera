abstract class ConfirmationResendCodeEvent {}

class ConfirmationCodeChanged extends ConfirmationResendCodeEvent {
  ConfirmationCodeChanged({
    required this.code,
  });

  final String code;
}

class ConfirmationSubmitted extends ConfirmationResendCodeEvent {}
