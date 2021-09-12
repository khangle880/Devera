import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/models/User.dart';

class DataRepository {
  ///? For User MODEL
  Future<User?> getUserById({String? userId}) async {
    try {
      final users = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(userId));
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw e;
    }
  }

  Future<List<User>?> getUsers() async {
    try {
      List<User> users = await Amplify.DataStore.query(User.classType);
      return users;
    } catch (e) {
      print("Could not query DataStore: " + e.toString());
      throw (e);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value;

      List<User> user = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(userId));
      return user.first;
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

  ///? For QuickNote MODEL
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

  Future<QuickNote> updateQuickNote(QuickNote updatedQuickNote) async {
    try {
      await Amplify.DataStore.save(updatedQuickNote);
      return updatedQuickNote;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<QuickNote> deleteQuickNote(QuickNote deletedQuickNote) async {
    try {
      await Amplify.DataStore.delete(deletedQuickNote);
      return deletedQuickNote;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Stream observeQuickNotes() {
    return Amplify.DataStore.observe(QuickNote.classType);
  }

  ///? For Task MODEL
  Future<Task> createTask({
    required String description,
    required String assignee,
    required String project,
    required TemporalDate dueDate,
    required List<String>? members,
  }) async {
    try {
      final task = Task(
          description: description,
          userID: assignee,
          isComplete: false,
          dueDate: dueDate,
          members: members);
      await Amplify.DataStore.save(task);
      return task;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<Task> updateMyTask(Task updatedMyTask) async {
    try {
      await Amplify.DataStore.save(updatedMyTask);
      return updatedMyTask;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<Task> deleteMyTask(Task deletedMyTask) async {
    try {
      await Amplify.DataStore.delete(deletedMyTask);
      return deletedMyTask;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<Task>> getMyTasks({required String userID}) async {
    try {
      List<Task> myTasks = await Amplify.DataStore.query(Task.classType,
          where: Task.USERID.eq(userID), sortBy: [Task.DUEDATE.descending()]);

      return myTasks;
    } catch (e) {
      print("Could not query DataStore: " + e.toString());
      throw (e);
    }
  }

  Stream observeMyTask() {
    return Amplify.DataStore.observe(Task.classType);
  }

  //? For Check List Model
  Future<CheckList> createCheckList(
      {required String description,
      required String color,
      required String userID}) async {
    try {
      final checkList =
          CheckList(description: description, color: color, userID: userID);
      await Amplify.DataStore.save(checkList);
      return checkList;
    } on Exception catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<CheckList> updateCheckList(CheckList updatedCheckList) async {
    try {
      await Amplify.DataStore.save(updatedCheckList);
      return updatedCheckList;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<CheckList>> getCheckLists({required String userID}) async {
    try {
      List<CheckList> checkLists = await Amplify.DataStore.query(
          CheckList.classType,
          where: Task.USERID.eq(userID),
          sortBy: [CheckList.CREATEDAT.descending()]);

      return checkLists;
    } on Exception catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<CheckList> deleteCheckList(CheckList deletedCheckList) async {
    print('Hello World');
    print(deletedCheckList);
    try {
      final listItems = await Amplify.DataStore.query(ListItem.classType,
          where: ListItem.CHECKLISTID.eq(deletedCheckList.id));

      if (listItems.length != 0) {
        listItems.forEach((listItem) async {
          await Amplify.DataStore.delete(listItem);
        });
      }

      await Amplify.DataStore.delete(deletedCheckList);
      return deletedCheckList;
    } on Exception catch (e) {
      print(e);
      throw (e);
    }
  }

  Stream observeCheckList() {
    return Amplify.DataStore.observe(CheckList.classType);
  }

  //? For List Item Model
  Future<List<ListItem>> createListItem({
    required List<ListItem> listItems,
    required String checkListID,
  }) async {
    if (listItems.length != 0) {
      listItems.forEach((item) {
        if (item.description.isNotEmpty) {
          item = item.copyWith(checklistID: checkListID);
          Amplify.DataStore.save(item);
        }
      });
    }

    return [];
  }

  Future<ListItem> updateListItem(ListItem updatedListItem) async {
    try {
      await Amplify.DataStore.save(updatedListItem);
      return updatedListItem;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<ListItem> deleteListItem(ListItem deletedListItem) async {
    try {
      await Amplify.DataStore.delete(deletedListItem);
      return deletedListItem;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<ListItem>> getListItem({
    required String checkListID,
  }) async {
    try {
      final List<ListItem> listItem = await Amplify.DataStore.query(
          ListItem.classType,
          where: ListItem.CHECKLISTID.eq(checkListID));
      return listItem;
    } on Exception catch (e) {
      print("Could not query DataStore: " + e.toString());
      throw (e);
    }
  }

  Future<Comment> createComment({
    required String avatarKey,
    required String commentStr,
    required String username,
    required String taskID,
  }) async {
    try {
      final comment = Comment(
          avatarKey: avatarKey,
          comment: commentStr,
          username: username,
          taskID: taskID);
      await Amplify.DataStore.save(comment);
      return comment;
    } on Exception catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<Comment>> getComments({required String taskID}) async {
    try {
      final List<Comment> comments = await Amplify.DataStore.query(
          Comment.classType,
          where: Comment.TASKID.eq(taskID));
      return comments;
    } on Exception catch (e) {
      print("Could not query DataStore: " + e.toString());
      throw (e);
    }
  }

  Stream observeComment() {
    return Amplify.DataStore.observe(Comment.classType);
  }
}
