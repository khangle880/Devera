import 'package:icon/constants/form_submission_status.dart';
import 'package:icon/models/ModelProvider.dart';

class TransferModalState {
  TransferModalState(
      {this.destination = '',
      this.receiverAddress = '',
      this.receiverWalletID,
      this.amount,
      this.users,
      this.searchUsers = const [],
      this.formStatus = const InitialFormStatus()});

  final String destination;
  final String receiverAddress;
  final String? receiverWalletID;
  final String? amount;
  final List<User>? users;
  final List<User>? searchUsers;

  FormSubmissionStatus formStatus;

  TransferModalState copyWith({
    String? destination,
    String? receiverAddress,
    String? receiverWalletID,
    String? amount,
    List<User>? users,
    List<User>? searchUsers,
    FormSubmissionStatus? formStatus,
  }) {
    return TransferModalState(
      destination: destination ?? this.destination,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiverWalletID: receiverWalletID ?? this.receiverWalletID,
      amount: amount ?? this.amount,
      users: users ?? this.users,
      searchUsers: searchUsers ?? this.searchUsers,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
