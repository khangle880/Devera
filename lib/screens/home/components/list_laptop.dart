import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/laptop_detail_page.dart';

class ListLaptop extends StatelessWidget {
  const ListLaptop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _productRef = FirebaseFirestore.instance
        .collection("ProductBranch")
        .doc("Apple")
        .collection("Products");

    return Scaffold(
        backgroundColor: hexToColor("#FCFAF8"),
        body: FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(children: <Widget>[
                const SizedBox(height: 15.0),
                Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    width: MediaQuery.of(context).size.width - 30.0,
                    height: MediaQuery.of(context).size.height - 50.0,
                    child: GridView.count(
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.8,
                        children: snapshot.data!.docs.map((document) {
                          return _buildCard(
                              document['name'].toString(),
                              "\$ ${document['minPrice']} - ${document['maxPrice']}",
                              document['images'][0].toString(),
                              false,
                              false,
                              context);
                        }).toList())),
                const SizedBox(height: 15.0)
              ]);
            }));
  }

  Widget _buildCard(String name, String price, String imgUrl, bool added,
      bool isFavorite, BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LapTopDetailPage(
                      imgUrl: imgUrl, laptopName: name, laptopPrice: price)));
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
                  Stack(children: <Widget>[
                    Hero(
                        tag: imgUrl,
                        child: Container(
                            height: 120.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                                image: DecorationImage(
                                    image: NetworkImage(imgUrl),
                                    fit: BoxFit.cover)))),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 15.0, left: 5.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (isFavorite)
                              Icon(Icons.favorite, color: hexToColor("#EF7532"))
                            else
                              Icon(Icons.favorite_border,
                                  color: hexToColor("#EF7532"))
                          ],
                        )),
                  ]),
                  const SizedBox(height: 15.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Container(color: hexToColor("#EBEBEB"), height: 1.0)),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0),
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
