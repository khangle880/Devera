import 'package:amplify_flutter/amplify.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/models/User.dart';

class DataRepository {
  Future<User?> getUserById({String? userId}) async {
    try {
      final users = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(userId));
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw e;
    }
  }

  Future<User> createUser(
      {String? userId, required String username, String? email}) async {
    final newUser = User(
        id: userId, username: username, email: email, avatarKey: 'Logo.png');
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      throw e;
    }
  }

  Future<User> updateUser(User updatedUser) async {
    try {
      await Amplify.DataStore.save(updatedUser);
      return updatedUser;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<QuickNote> createQuickNote(
      {required String description,
      required String color,
      required String userID}) async {
    try {
      final quickNote =
          QuickNote(description: description, color: color, userID: userID);
      await Amplify.DataStore.save(quickNote);
      return quickNote;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<QuickNote>> getQuickNote({required String userID}) async {
    try {
      List<QuickNote> quickNotes = await Amplify.DataStore.query(
          QuickNote.classType,
          where: QuickNote.USERID.eq(userID),
          sortBy: [QuickNote.CREATEDAT.descending()]);
      return quickNotes;
    } on Exception catch (e) {
      print("Could not query DataStore: " + e.toString());
      throw (e);
    }
  }

  Stream observeQuickNotes() {
    return Amplify.DataStore.observe(QuickNote.classType);
  }
}
