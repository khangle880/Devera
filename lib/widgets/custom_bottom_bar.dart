import 'package:flutter/material.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/widgets/custom_icon_button.dart';

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

    return Container(
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Color(0xFFEDF1F9),
            elevation: 0.0,
            notchMargin: 0.0,
            clipBehavior: Clip.antiAlias,
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
                            buttonText: 'Transaction',
                            iconPath: IconConstants.transactionIcon),
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
                            buttonText: 'Portfolio',
                            iconPath: IconConstants.portfolioIcon),
                      ],
                    ),
                  ),
                ])),
      ),
    );
  }
}
