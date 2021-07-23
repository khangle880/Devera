import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/laptop_detail_page.dart';

class ListLaptop extends StatelessWidget {
  const ListLaptop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexToColor("#FCFAF8"),
        body: ListView(children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard("Macbook Air", "\$999",
                      'assets/images/cookiechoco.jpeg', false, false, context),
                  _buildCard("Macbook Pro", "\$9299",
                      'assets/images/cookieclassic.jpeg', true, false, context),
                  _buildCard("Imac", "\$1899", 'assets/images/cookiecream.jpeg',
                      false, true, context),
                  _buildCard("Imac Pro", "\$3999",
                      'assets/images/cookiemint.jpeg', false, false, context),
                ],
              )),
          SizedBox(height: 15.0)
        ]));
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LapTopDetailPage(
                      assetPath: imgPath,
                      laptopName: name,
                      laptopPrice: price)));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 15.0, left: 5.0, right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          isFavorite
                              ? Icon(Icons.favorite,
                                  color: hexToColor("#EF7532"))
                              : Icon(Icons.favorite_border,
                                  color: hexToColor("#EF7532"))
                        ],
                      )),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 15.0),
                  Text(price,
                      style: TextStyle(
                          color: hexToColor("#CC8053"),
                          fontFamily: 'Varela',
                          fontSize: 16.0)),
                  Text(name,
                      style: TextStyle(
                          color: hexToColor("#575E67"),
                          fontFamily: 'Varela',
                          fontSize: 16.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Container(color: hexToColor("#EBEBEB"), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!added) ...[
                              Icon(
                                Icons.shopping_basket,
                                color: hexToColor("#D17E50"),
                                size: 20,
                              ),
                              Text("Add to cart",
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: hexToColor("#D17E50"),
                                      fontSize: 18.0))
                            ],
                            if (added) ...[
                              Icon(
                                Icons.remove_circle_outline,
                                color: hexToColor("#D17E50"),
                                size: 20,
                              ),
                              Text("3",
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: hexToColor("#D17E50"),
                                      fontSize: 18.0)),
                              Icon(
                                Icons.add_circle_outline,
                                color: hexToColor("#D17E50"),
                                size: 20,
                              ),
                            ]
                          ]))
                ],
              ),
            )));
  }
}
