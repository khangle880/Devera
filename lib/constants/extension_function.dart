import 'package:flutter/material.dart';

class ExtensionFunction {
  static void changeFocusFrom(BuildContext context, FocusNode focusNodeNew) {
    FocusScope.of(context).requestFocus(focusNodeNew);
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
