import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/constants/style_constants.dart';
import 'package:icon/screens/popup_modal/transfer_modal_bloc.dart';
import 'package:icon/screens/popup_modal/transfer_modal_event.dart';
import 'package:icon/screens/popup_modal/transfer_modal_state.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class TransferModalView extends StatefulWidget {
  const TransferModalView({Key? key}) : super(key: key);

  @override
  _TransferModalViewState createState() => _TransferModalViewState();
}

class _TransferModalViewState extends State<TransferModalView> {
  TextEditingController _destinationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferModalBloc()..add(GetUsers()),
      child: BlocListener<TransferModalBloc, TransferModalState>(
        listener: (context, state) {},
        child: BlocBuilder<TransferModalBloc, TransferModalState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 50,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(Icons.deck)),
                  SizedBox(height: 20.h),
                  Text('Destination'),
                  TextField(
                      controller: _destinationTextController,
                      decoration:
                          InputDecoration(hintText: state.receiverAddress),
                      onChanged: (value) {
                        SheetController.of(context)!.expand();
                        context.read<TransferModalBloc>().add(
                            DestinationTransferOnChanged(destination: value));
                      }),
                  if (state.destination.isNotEmpty &&
                      state.searchUsers!.length != 0) ...[
                    Container(
                      height: 120.h,
                      child: ListView.builder(
                          itemCount: state.searchUsers!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<TransferModalBloc>()
                                  ..add(DestinationTransferOnChanged(
                                      destination: ''))
                                  ..add(DestinationAddressOnChanged(
                                      receiverAddress: state.searchUsers![index]
                                              .wallet!.address ??
                                          ''))
                                  ..add(DestinationReceiverWalletIDOnChanged(
                                      receiverWalletID: state
                                          .searchUsers![index].wallet!.id));

                                _destinationTextController.text = '';
                              },
                              child: Container(
                                  width: 40.h,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey.withOpacity(0.3),
                                  child:
                                      Text(state.users![index].email ?? 'N/A')),
                            );
                          }),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  Text('Amount'),
                  TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        SheetController.of(context)!.expand();
                        context
                            .read<TransferModalBloc>()
                            .add(DestinationAmountOnChanged(amount: value));
                      }),
                  SizedBox(height: 50.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<TransferModalBloc>()..add(TransferICX());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      // margin: widget.margin,
                      child: Text(
                        'Transfer',
                        style: StyleConstants.buttonTextStyle(Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
