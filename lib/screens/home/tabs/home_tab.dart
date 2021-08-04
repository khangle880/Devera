import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/constants/constants_color.dart';
import 'package:laptop/screens/home/components/list_laptop.dart';
import 'package:laptop/widgets/custom_action_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final CollectionReference _productRef =
  //     FirebaseFirestore.instance.collection("Products");

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20.0),
          children: <Widget>[
            const SizedBox(height: 15.0),
            Container(
              color: hexToColor('#F9F9F9'),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: kHightlightLabelTextColor,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(left: 35.0, right: 35.0),
                unselectedLabelColor: hexToColor('#CDCDCD'),
                tabs: const <Widget>[
                  Tab(
                    child: Text(
                      'Apple',
                      style: TextStyle(fontFamily: 'Varela', fontSize: 21.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'ThinkPad',
                      style: TextStyle(fontFamily: 'Varela', fontSize: 21.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Dell',
                      style: TextStyle(fontFamily: 'Varela', fontSize: 21.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  ListLaptop(),
                  ListLaptop(),
                  ListLaptop(),
                ],
              ),
            )
          ]),
      // const CustomActionBar(
      //   title: 'Laptop Categories',
      //   hasBackArrow: false,
      // )
    ]);
  }
}
