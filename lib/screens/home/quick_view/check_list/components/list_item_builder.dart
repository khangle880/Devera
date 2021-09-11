import 'package:flutter/material.dart';

import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/home/quick_view/check_list/components/item_builder.dart';
import 'package:asking/widgets/custom_column_builder.dart';

class ListItemBuilder extends StatelessWidget {
  const ListItemBuilder({
    Key? key,
    required this.listItems,
    required this.wantToEdit,
  }) : super(key: key);

  final List<ListItem> listItems;
  final bool wantToEdit;

  @override
  Widget build(BuildContext context) {
    final _listItems = listItems;

    return CustomColumnBuilder(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          final listItem = _listItems[index];
          return _itemBuilder(listItem);
        });
  }

  Widget _itemBuilder(ListItem listItem) {
    return ItemBuilder(
      listItem: listItem,
      wantToEdit: wantToEdit,
    );
  }
}
