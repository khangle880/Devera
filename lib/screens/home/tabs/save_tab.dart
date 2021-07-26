import 'package:flutter/material.dart';
import 'package:laptop/widgets/custom_action_bar.dart';

class SaveTab extends StatefulWidget {
  const SaveTab({Key? key}) : super(key: key);

  @override
  _SaveTabState createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Center(
        child: Text("Save Tab"),
      ),
      CustomActionBar(
        title: "Saved",
        hasBackArrow: false,
      )
    ]));
  }
}
