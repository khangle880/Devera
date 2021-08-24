import 'package:asking/models/ModelProvider.dart';

abstract class QuickState {}

class QuickNoteLoading extends QuickState {}

class GetQuickNoteSuccess extends QuickState {
  GetQuickNoteSuccess({
    required this.quickNotes,
  });

  final List<QuickNote> quickNotes;
}

class GetQuickNoteFailed extends QuickState {
  GetQuickNoteFailed({
    required this.exception,
  });

  final Exception exception;
}
