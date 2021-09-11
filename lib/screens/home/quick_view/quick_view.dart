import 'package:asking/constants/color_constants.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/quick_view/check_list/check_list_view.dart';
import 'package:asking/screens/home/quick_view/quick_cubit.dart';
import 'package:asking/screens/home/quick_view/quick_note/quick_note_view.dart';
import 'package:asking/screens/home/quick_view/quick_state.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickView extends StatefulWidget {
  const QuickView({Key? key}) : super(key: key);

  @override
  _QuickViewState createState() => _QuickViewState();
}

class _QuickViewState extends State<QuickView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
        create: (context) => QuickCubit(
            dataRepo: context.read<DataRepository>(),
            user: sessionCubit.selectedUser ??
                sessionCubit.currentUser ??
                User(username: 'N/A'))
          ..getQuickViewData()
          ..observeQuickNotes()
          ..observeCheckLists(),
        child: Scaffold(
            backgroundColor: Color(0xFFFDFDFD),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: Colors.black,
                      trailing: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      title: Text('Quick View',
                          style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.h),
                          color: ColorConstants.kGreyBackground,
                          child: TabBar(
                            indicatorWeight: 0.1,
                            controller: _tabController,
                            indicatorColor: Colors.transparent,
                            labelColor: Color(0xFF4B6587),
                            isScrollable: false,
                            unselectedLabelColor:
                                Color(0xFF3B185F).withOpacity(0.5),
                            tabs: <Widget>[
                              Tab(
                                child: Container(
                                  width: 140,
                                  padding: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: _selectedIndex == 0
                                        ? Color(0xFF4B6587)
                                        : Colors.transparent,
                                    width: 2.0,
                                  ))),
                                  child: Text(
                                    'Quick Notes',
                                    style: TextStyle(fontSize: 21.0),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 140,
                                  padding: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: _selectedIndex == 1
                                        ? Color(0xFF4B6587)
                                        : Colors.transparent,
                                    width: 2.0,
                                  ))),
                                  child: Text(
                                    'Check List',
                                    style: TextStyle(fontSize: 21.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Expanded(
                    child: BlocBuilder<QuickCubit, QuickState>(
                      builder: (context, state) {
                        // print(context.read<QuickCubit>().mapCheckLists.values);
                        if (state is GetQuickViewDataFailed) {
                        } else if (state is GetQuickViewDataSuccess) {
                          return TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: <Widget>[
                              QuickNoteView(),
                              CheckListView()
                            ],
                          );
                        }
                        return LoadingView();
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
