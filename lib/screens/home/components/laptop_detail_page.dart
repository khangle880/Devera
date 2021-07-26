import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/bottom_bar.dart';

class LapTopDetailPage extends StatelessWidget {
  const LapTopDetailPage({
    Key? key,
    required this.imgUrl,
    required this.laptopName,
    required this.laptopPrice,
  }) : super(key: key);

  final String imgUrl;
  final String laptopName;
  final String laptopPrice;

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
            onPressed: () {
              Navigator.of(context).pop();
            }),
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
      body: ListView(padding: EdgeInsets.only(left: 0.0), children: <Widget>[
        SizedBox(height: 15.0),
        Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Laptop",
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 42.0,
                    color: hexToColor("#F17532")))),
        SizedBox(height: 15.0),
        Hero(
            tag: imgUrl,
            child: Image.network(imgUrl,
                height: 150.0, width: 100.0, fit: BoxFit.cover)),
        SizedBox(height: 20.0),
        Center(
          child: Text(laptopPrice,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(laptopName,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 30.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                'Macbook Air Cookie, when you bite you know this is a freaking good shiet and bad to the bottom as well',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 20.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFFF17532)),
                child: Center(
                    child: Text(
                  'Add to cart',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        backgroundColor: hexToColor("#F17532"),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    ;
  }
}
