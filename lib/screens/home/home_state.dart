import 'package:icon/models/ModelProvider.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class GetTransferSuccess extends HomeState {
  GetTransferSuccess({
    required this.transfer,
  });

  final List<Transfer> transfer;
}

class GetTransferfailed {
  GetTransferfailed({
    required this.exception,
  });

  final Exception exception;
}

class GetWalletSuccess extends HomeState {}

class GetWalletFailed extends HomeState {}
