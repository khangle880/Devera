import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laptop/constants/constants_color.dart';

//? Shortcut Class

class Constants {
  //? Text's Styles
  static const TextStyle regularHeader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle regularDarkText = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle regularHintText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black38);

  static const TextStyle boldHeading = TextStyle(
      fontFamily: 'Varela',
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: kHeadingTextColor);

  static TextStyle buttonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: textColor);
  }
  //?----------------------------
}

//?------------------------------------------------------------------------------

//? Shortcut functions

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

void changeFocusFrom(BuildContext context, FocusNode focusNodeNew) {
  FocusScope.of(context).requestFocus(focusNodeNew);
}

Future<void> alertDialogBuilder(
    BuildContext context, String errorType, String errorMessage) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(errorType),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close Dialog'))
            ]);
      });
}

//?------------------------------------------------------------------------------

//? Extension functions

extension CustomString on String? {
  bool isNull() {
    if (this != null) return false;
    return true;
  }
}

//?------------------------------------------------------------------------------
