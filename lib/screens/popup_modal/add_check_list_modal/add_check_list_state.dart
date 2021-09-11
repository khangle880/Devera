part of 'add_check_list_bloc.dart';

class AddCheckListState {
  AddCheckListState({
    this.listItems = const [],
    this.description,
    this.color = '#6074F9',
    this.formStatus = const InitialFormStatus(),
  });

  final String? description;
  final String color;
  final List<ListItem> listItems;

  FormSubmissionStatus formStatus;

  AddCheckListState copyWith({
    String? description,
    String? color,
    List<ListItem>? listItems,
    FormSubmissionStatus? formStatus,
  }) {
    return AddCheckListState(
      listItems: listItems ?? this.listItems,
      description: description ?? this.description,
      color: color ?? this.color,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
