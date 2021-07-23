import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/bottom_bar.dart';
import 'package:laptop/screens/home/components/list_laptop.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#F9F9F9"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: hexToColor("#545D68")),
            onPressed: () {}),
        title: Text("Pickup",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20,
                color: hexToColor("#545D68"))),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.notifications_none, color: hexToColor("#545D68")))
        ],
      ),
      body: ListView(padding: EdgeInsets.only(left: 20.0), children: <Widget>[
        SizedBox(height: 15.0),
        Text('Categories',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 15.0),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: hexToColor("#C88D67"),
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 25.0, right: 25.0),
          unselectedLabelColor: hexToColor("#CDCDCD"),
          tabs: [
            Tab(
              child: Text(
                'Apple',
                style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
              ),
            ),
            Tab(
              child: Text(
                'ThinkPad',
                style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
              ),
            ),
            Tab(
              child: Text(
                'Dell',
                style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: double.infinity,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListLaptop(),
              ListLaptop(),
              ListLaptop(),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        backgroundColor: hexToColor("#F17532"),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBars(),
    );
  }
}
