abstract class PinSecurityEvent {}

class PinSecuritySubmitted extends PinSecurityEvent {
  PinSecuritySubmitted({
    required this.pin,
  });

  final String pin;
}
