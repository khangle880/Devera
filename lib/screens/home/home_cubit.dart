import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';

import 'package:icon/models/ModelProvider.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/screens/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.dataRepo,
    required this.user,
  }) : super(HomeLoading());

  final DataRepository dataRepo;
  final User user;
  Balance? balance;

  Future<void> getWalletBalance() async {
    try {
      balance = await FlutterIconNetwork.instance!
          .getIcxBalance(privateKey: user.wallet!.privateKey);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> getTransfers() async {
    if (state is GetTransferSuccess == false) {
      emit(HomeLoading());
    }

    try {
      final getTransfers =
          await dataRepo.getTransfers(walletID: user.wallet!.id);

      await getWalletBalance();
      emit(GetTransferSuccess(transfer: getTransfers));
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  void observeTransfer() {
    final transferStream = dataRepo.observeTransfer();
    transferStream.listen((_) {
      getTransfers();
    });
  }

  Future<void> getTestData() async {
    print(user.wallet);
  }
}
