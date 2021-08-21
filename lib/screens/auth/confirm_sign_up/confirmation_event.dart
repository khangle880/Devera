abstract class ConfirmationEvent {}

class ConfirmationCodeChanged extends ConfirmationEvent {
  ConfirmationCodeChanged({
    required this.code,
  });

  final String code;
}

class ConfirmationSubmitted extends ConfirmationEvent {}
