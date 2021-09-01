import 'package:flutter/material.dart';

class UserPickerModal extends StatefulWidget {
  const UserPickerModal({Key? key}) : super(key: key);

  @override
  _UserPickerModalState createState() => _UserPickerModalState();
}

class _UserPickerModalState extends State<UserPickerModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(child: Text('Hello Users')));
  }
}
