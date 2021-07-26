import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//? Shortcut Class

class Constants {
  //? Text's Styles
  static const regularHeader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularHintText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black38);

  static const boldHeading = TextStyle(
      fontFamily: 'Varela',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.black);

  static buttonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: textColor);
  }
  //?----------------------------
}

//?------------------------------------------------------------------------------

//? Shortcut functions

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

void changeFocusFrom(BuildContext context, FocusNode focusNodeNew) {
  FocusScope.of(context).requestFocus(focusNodeNew);
}

Future<void> alertDialogBuilder(
    BuildContext context, String errorType, String errorMessage) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            title: Text(errorType),
            content: Container(child: Text(errorMessage)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close Dialog"))
            ]);
      });
}

//?------------------------------------------------------------------------------

//? Extension functions

extension customString on String? {
  bool isNull() {
    if (this != null) return false;
    return true;
  }
}

//?------------------------------------------------------------------------------
