import 'package:asking/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asking/widgets/custom_icon_button.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
    required this.selectedTab,
    required this.tabPressed,
  }) : super(key: key);

  final int selectedTab;
  final Function(int) tabPressed;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    _currentTab = widget.selectedTab;

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: ColorConstants.kBottomAppBarColor,
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80.0.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            color: Colors.transparent,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 80.0.h,
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomIconButton(
                          isSelected: _currentTab == 0 || false,
                          onPressed: () {
                            widget.tabPressed(0);
                          },
                          buttonText: 'My Task',
                          iconPath: 'assets/icons/home.svg'),
                      CustomIconButton(
                          isSelected: _currentTab == 1 || false,
                          onPressed: () {
                            widget.tabPressed(1);
                          },
                          buttonText: 'Menu',
                          iconPath: 'assets/icons/find.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.0.h,
                  width: 150.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomIconButton(
                          isSelected: _currentTab == 2 || false,
                          onPressed: () {
                            widget.tabPressed(2);
                          },
                          buttonText: 'Quick',
                          iconPath: 'assets/icons/bookmark.svg'),
                      CustomIconButton(
                          isSelected: _currentTab == 3 || false,
                          onPressed: () {
                            widget.tabPressed(3);
                          },
                          buttonText: 'Profile',
                          iconPath: 'assets/icons/profile.svg'),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
