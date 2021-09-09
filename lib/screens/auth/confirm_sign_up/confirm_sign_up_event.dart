abstract class ConfirmationEvent {}

class ConfirmationSubmitted extends ConfirmationEvent {
  ConfirmationSubmitted({
    required this.code,
  });

  final String code;
}

class ResendSecurityCode extends ConfirmationEvent {}
