import 'package:flutter/material.dart';
import 'package:laptop/widgets/custom_icon_button.dart';

class BottomBars extends StatefulWidget {
  const BottomBars({
    Key? key,
    required this.selectedTab,
    required this.tabPressed,
  }) : super(key: key);

  final int selectedTab;
  final Function(int) tabPressed;

  @override
  _BottomBars createState() => _BottomBars();
}

class _BottomBars extends State<BottomBars> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    _currentTab = widget.selectedTab;

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.transparent,
        elevation: 100.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 60.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            color: Colors.white,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomIconButton(
                          isSelected: _currentTab == 0 || false,
                          onPressed: () {
                            widget.tabPressed(0);
                          },
                          iconPath: 'assets/icons/home.svg'),
                      CustomIconButton(
                          isSelected: _currentTab == 1 || false,
                          onPressed: () {
                            widget.tabPressed(1);
                          },
                          iconPath: 'assets/icons/find.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomIconButton(
                          isSelected: _currentTab == 2 || false,
                          onPressed: () {
                            widget.tabPressed(2);
                          },
                          iconPath: 'assets/icons/bookmark.svg'),
                      CustomIconButton(
                          isSelected: _currentTab == 3 || false,
                          onPressed: () {
                            widget.tabPressed(3);
                          },
                          iconPath: 'assets/icons/profile.svg'),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
