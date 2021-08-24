import 'package:amplify_flutter/amplify.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/asset_constants.dart';
import 'package:asking/models/QuickNote.dart';
import 'package:asking/models/User.dart';
import 'package:asking/screens/home/home_cubit.dart';
import 'package:asking/screens/home/menu/menu_view.dart';
import 'package:asking/screens/home/my_task/my_task_view.dart';
import 'package:asking/screens/home/profile/profile_view.dart';
import 'package:asking/screens/home/quick_note/quick_view.dart';
import 'package:asking/screens/popup_modal/choices_modal.dart';
import 'package:asking/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _tabsPageController;
  int _selectedTab = 0;
  String _title = 'Work List';
  Color _appBarBackgroundColor = ColorConstants.kPrimaryDarkColor;
  Color _appBarTextColor = Colors.white;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _appBarBackgroundColor,
        title: Text(_title, style: TextStyle(color: _appBarTextColor)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Icon(Icons.ac_unit),
          )
        ],
      ),
      body: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _tabsPageController,
          onPageChanged: (int pageIndex) {
            setState(() {
              _selectedTab = pageIndex;

              switch (pageIndex) {
                case 0:
                  setState(() {
                    _title = 'Work List';
                    _appBarBackgroundColor = ColorConstants.kPrimaryDarkColor;
                    _appBarTextColor = Colors.white;
                  });
                  break;
                case 1:
                  setState(() {
                    _title = 'Menu';
                    _appBarBackgroundColor = ColorConstants.kSecondaryColor;
                    _appBarTextColor = Colors.black;
                  });
                  break;
                case 2:
                  setState(() {
                    _title = 'Quick Note';
                    _appBarBackgroundColor = ColorConstants.kSecondaryColor;
                    _appBarTextColor = Colors.black;
                  });
                  break;
                case 3:
                  setState(() {
                    _title = 'Profile';
                    _appBarBackgroundColor = ColorConstants.kSecondaryColor;
                    _appBarTextColor = Colors.black;
                  });
                  break;
                default:
              }
            });
          },
          children: const <Widget>[
            MyTaskView(),
            MenuView(),
            QuickView(),
            ProfileView()
          ]),
      floatingActionButton: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () async {
                    ChoicesModal.createAlertDialog(context);
                  },
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: SvgPicture.asset(IconConstants.addIcon,
                        width: 50.w, height: 50.h, fit: BoxFit.none),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: ColorConstants.kPrimaryGradientColor),
                  ),
                );
              },
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(
        selectedTab: _selectedTab,
        tabPressed: (int pageIndex) {
          setState(() {
            _tabsPageController.jumpToPage(pageIndex);
          });
        },
      ),
    );
  }
}
