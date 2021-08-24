abstract class AddQuickNoteEvent {}

class NoteDescriptionOnChanged extends AddQuickNoteEvent {
  NoteDescriptionOnChanged({
    required this.description,
  });

  final String description;
}

class NoteColorOnChanged extends AddQuickNoteEvent {
  NoteColorOnChanged({
    required this.color,
  });

  final String color;
}

class CreateNote extends AddQuickNoteEvent {}
