import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/bottom_bar.dart';
import 'package:laptop/screens/home/tabs/home_tab.dart';
import 'package:laptop/screens/home/tabs/save_tab.dart';
import 'package:laptop/widgets/custom_action_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexToColor('#F9F9F9'),
        appBar: CustomActionBar(
          title: _title,
          hasBackArrow: _hasBackArrow,
          hasTitle: _hasTitle,
        ),
        body: PageView(
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
                    _hasBackArrow = true;
                    _hasTitle = true;
                    break;
                  default:
                }
              });
            },
            children: const <Widget>[
              HomeTab(),
              HomeTab(),
              SaveTab(),
              HomeTab()
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          backgroundColor: hexToColor('#F17532'),
          child: const Icon(Icons.fastfood),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBars(
          selectedTab: _selectedTab,
          tabPressed: (int pageIndex) {
            setState(() {
              _tabsPageController.animateToPage(pageIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            });
          },
        ));
  }
}
