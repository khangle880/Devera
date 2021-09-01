import 'package:amplify_flutter/amplify.dart';
import 'package:asking/image_url_cache.dart';
import 'package:asking/models/ModelProvider.dart';
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

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Future<List<String>>? getUsersAvatarUrl(List<User>? users) async {
    List<String>? usersAvatarUrl = [];

    if (users != null || users!.length > 0) {
      for (var user in users) {
        final userAvatarUrl = await ImageUrlCache.instance
            .getUrl(user.avatarKey ?? '')
            .then((url) => url);
        usersAvatarUrl.add(userAvatarUrl ?? '');
      }
    }

    return usersAvatarUrl;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
