import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/icon_constants.dart';
import 'package:asking/screens/menu/menu_view.dart';
import 'package:asking/screens/my_task/my_task_view.dart';
import 'package:asking/screens/profile/profile_view.dart';
import 'package:asking/screens/quick/quick_view.dart';
import 'package:asking/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
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
  String _title = 'Latop Categories';
  bool _hasBackArrow = false;
  bool _hasTitle = true;

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

  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (contect) {
          return AlertDialog(
            title: Text('Your Name?'),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0, child: Text('Hello World'), onPressed: () {})
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorConstants.kPrimaryLightColor,
        title: Text('Work List'),
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
                  _title = 'Latop Categories';
                  _hasBackArrow = false;
                  _hasTitle = true;
                  break;
                case 1:
                  _title = 'Search Categories';
                  _hasBackArrow = false;
                  _hasTitle = true;
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
        child: FloatingActionButton(
          onPressed: () {
            createAlertDialog(context);
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
        ),
      ),
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
