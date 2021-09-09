import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/models/ModelProvider.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/screens/home/home_cubit.dart';
import 'package:icon/screens/home/home_state.dart';
import 'package:icon/screens/popup_modal/transfer_modal_view.dart';
import 'package:icon/session/session_cubit.dart';
import 'package:icon/widgets/custom_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => HomeCubit(
          dataRepo: context.read<DataRepository>(),
          user: sessionCubit.selectedUser ??
              sessionCubit.currentUser ??
              User(pin: ''))
        ..getTransfers()
        ..observeTransfer(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          print(state);
          if (state is GetTransferfailed) {
          } else if (state is GetTransferSuccess) {
            return Scaffold(
              backgroundColor: Color(0xFF347AF0),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await showSheet();
                },
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Icon(Icons.add),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF3783F5)),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xFF347AF0),
                title: Text('Hello Minh Hieu',
                    style: GoogleFonts.titilliumWeb(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold)),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: GestureDetector(
                        onTap: () {
                          context.read<SessionCubit>().signOut();
                        },
                        child: Icon(Icons.logout)),
                  )
                ],
              ),
              body: Column(children: [
                Container(
                    height: 150,
                    child: Column(children: [
                      SizedBox(height: 20.h),
                      Text(
                          context
                                  .read<HomeCubit>()
                                  .balance
                                  ?.icxBalance
                                  .toString() ??
                              'N/A',
                          style: GoogleFonts.titilliumWeb(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                      Text('Wallet Balance',
                          style: GoogleFonts.titilliumWeb(
                              color: Colors.white70,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold))
                    ])),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0.r),
                        topLeft: Radius.circular(30.0.r)),
                  ),
                  child: ListView.builder(
                    itemCount: state.transfer.length,
                    itemBuilder: (context, index) {
                      final createdDate =
                          state.transfer[index].createdAt!.getDateTimeInUtc();

                      final DateFormat format = DateFormat('MMMM dd, yyyy');
                      final String formatted = format.format(createdDate);
                      return ListTile(
                        contentPadding: EdgeInsets.all(6),
                        leading: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                              width: 25.w,
                              height: double.infinity,
                              child: SvgPicture.asset(
                                IconConstants.bitCoinIcon,
                              )),
                        ),
                        title: Text(
                          '\$${state.transfer[index].amount}',
                        ),
                        subtitle: Text('I love my Mom',
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.7))),
                        trailing: Column(children: [
                          SizedBox(height: 5.h),
                          Text('Transfer',
                              style: TextStyle(
                                  color: Color(0xFFDF5060),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.h),
                          Text(formatted,
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.7)))
                        ]),
                      );
                    },
                  ),
                ))
              ]),
              bottomNavigationBar: CustomBottomBar(
                selectedTab: 0,
                tabPressed: (int pageIndex) {},
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future showSheet() => showSlidingBottomSheet(context,
      builder: (context) => SlidingSheetDialog(
          cornerRadius: 30.r,
          color: Colors.white,
          snapSpec: SnapSpec(snappings: [0.5, 1]),
          builder: buildSheet));

  Widget buildSheet(context, state) {
    return TransferModalView();
  }
}
