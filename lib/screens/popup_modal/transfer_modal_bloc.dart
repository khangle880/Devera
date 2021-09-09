import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/models/User.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/screens/popup_modal/transfer_modal_event.dart';
import 'package:icon/screens/popup_modal/transfer_modal_state.dart';

class TransferModalBloc extends Bloc<TransferModalEvent, TransferModalState> {
  TransferModalBloc() : super(TransferModalState());

  final AuthRepository authRepo = AuthRepository();
  final DataRepository dataRepo = DataRepository();

  User? currentUser;
  @override
  Stream<TransferModalState> mapEventToState(TransferModalEvent event) async* {
    if (event is GetUsers) {
      final users = await dataRepo.getUsers();
      currentUser = await dataRepo.getCurrentUser();
      yield state.copyWith(users: users);
    } else if (event is DestinationTransferOnChanged) {
      yield state.copyWith(
          searchUsers: state.users!
              .where((element) => element.email!
                  .toLowerCase()
                  .contains(state.destination.toLowerCase()))
              .toList());
      yield state.copyWith(destination: event.destination);
    } else if (event is DestinationAmountOnChanged) {
      yield state.copyWith(amount: event.amount);
    } else if (event is DestinationReceiverWalletIDOnChanged) {
      yield state.copyWith(receiverWalletID: event.receiverWalletID);
    } else if (event is DestinationAddressOnChanged) {
      yield state.copyWith(receiverAddress: event.receiverAddress);
    } else if (event is TransferICX) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        if (state.amount != null) {
          final txHash = await FlutterIconNetwork.instance!.sendIcx(
              yourPrivateKey: currentUser!.wallet!.privateKey,
              destinationAddress: state.receiverAddress,
              value: state.amount ?? '0');
          print('Send Success');
          print(txHash.txHash);

          final transfer = await dataRepo.createTransfer(
              txHash: txHash.txHash ?? '',
              amount: state.amount ?? '0',
              senderWalletID: currentUser!.wallet!.id,
              receiverWalletID: state.receiverWalletID ?? '');
          yield state.copyWith(formStatus: SubmissionSuccess());
          print(transfer);
        } else {
          throw Exception('Please write input amount');
        }
      } on Exception catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
