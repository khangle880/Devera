part of 'add_check_list_bloc.dart';

class AddCheckListEvent {}

class CheckListDescriptionOnChanged extends AddCheckListEvent {
  CheckListDescriptionOnChanged({
    required this.description,
  });

  final String description;
}

class CheckListColorOnChanged extends AddCheckListEvent {
  CheckListColorOnChanged({
    required this.color,
  });

  final String color;
}

class CheckListItemsOnChanged extends AddCheckListEvent {
  CheckListItemsOnChanged({
    required this.listItems,
  });

  final List<ListItem> listItems;
}

class CreateCheckList extends AddCheckListEvent {}
