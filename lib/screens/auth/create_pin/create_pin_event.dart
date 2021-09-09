abstract class CreatePinEvent {}

class CreatePinSubmitted extends CreatePinEvent {
  CreatePinSubmitted({
    required this.pin,
  });

  final String pin;
}
