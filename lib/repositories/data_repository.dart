import 'package:amplify_flutter/amplify.dart';
import 'package:icon/models/ModelProvider.dart';

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
      {String? userId,
      required String firstName,
      required String lastName,
      String? pin,
      String? email,
      required Wallet wallet}) async {
    final newUser = User(
        id: userId,
        firstName: firstName,
        lastName: lastName,
        pin: pin ?? '',
        email: email,
        wallet: wallet);
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      throw e;
    }
  }

  Future<Wallet> createWallet({
    required String address,
    required String privateKey,
  }) async {
    final wallet = Wallet(address: address, privateKey: privateKey);
    try {
      await Amplify.DataStore.save(wallet);
      return wallet;
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<Transfer> createTransfer({
    required String txHash,
    required String amount,
    required String senderWalletID,
    required String receiverWalletID,
  }) async {
    final Transfer senderTransfer =
        Transfer(amount: amount, walletID: senderWalletID, txHash: txHash);
    final Transfer receiverTransfer =
        Transfer(amount: amount, walletID: receiverWalletID, txHash: txHash);
    try {
      await Amplify.DataStore.save(senderTransfer);
      await Amplify.DataStore.save(receiverTransfer);
      return senderTransfer;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Transfer>> getTransfers({required String walletID}) async {
    try {
      List<Transfer> transfers = await Amplify.DataStore.query(
          Transfer.classType,
          where: Transfer.WALLETID.eq(walletID),
          sortBy: [Transfer.CREATEDAT.descending()]);
      return transfers;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Stream observeTransfer() {
    return Amplify.DataStore.observe(Transfer.classType);
  }
}
