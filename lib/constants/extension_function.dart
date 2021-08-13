import 'package:flutter/material.dart';

class ExtensionFunction {
  static void changeFocusFrom(BuildContext context, FocusNode focusNodeNew) {
    FocusScope.of(context).requestFocus(focusNodeNew);
  }
}
