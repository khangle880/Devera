abstract class TransferModalEvent {}

class DestinationTransferOnChanged extends TransferModalEvent {
  DestinationTransferOnChanged({
    required this.destination,
  });

  final String destination;
}

class DestinationAddressOnChanged extends TransferModalEvent {
  DestinationAddressOnChanged({
    required this.receiverAddress,
  });

  final String receiverAddress;
}

class DestinationReceiverWalletIDOnChanged extends TransferModalEvent {
  DestinationReceiverWalletIDOnChanged({
    required this.receiverWalletID,
  });

  final String receiverWalletID;
}

class DestinationAmountOnChanged extends TransferModalEvent {
  DestinationAmountOnChanged({
    required this.amount,
  });

  final String amount;
}

class GetUsers extends TransferModalEvent {}

class TransferICX extends TransferModalEvent {}
