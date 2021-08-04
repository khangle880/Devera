import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/constants/constants_color.dart';
import 'package:laptop/screens/home/components/laptop_details_page.dart';

class ListLaptop extends StatelessWidget {
  const ListLaptop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference<Object> _productRef = FirebaseFirestore.instance
        .collection('ProductBranch')
        .doc('Apple')
        .collection('Products');

    return Scaffold(
        backgroundColor: hexToColor('#FCFAF8'),
        body: FutureBuilder<QuerySnapshot<Object?>>(
            future: _productRef.get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(0),
                child: ListView(children: <Widget>[
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
                          children: snapshot.data!.docs
                              .map((QueryDocumentSnapshot<Object?> document) {
                            final String productId = document.id.toString();
                            final String productName =
                                document['name'].toString();
                            final String productPrice =
                                "\$ ${document['minPrice']} - ${document['maxPrice']}";
                            final String productDescription =
                                document['description'].toString();
                            final List<dynamic> productImageUrls =
                                document['images'] as List<dynamic>;

                            return _buildCard(
                                productId,
                                productName,
                                productPrice,
                                productDescription,
                                productImageUrls,
                                false,
                                false,
                                context);
                          }).toList())),
                  const SizedBox(height: 15.0)
                ]),
              );
            }));
  }

  Widget _buildCard(
      String productId,
      String productName,
      String productPrice,
      String productDescription,
      List<dynamic> productImageUrls,
      bool added,
      bool isFavorite,
      BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<ListLaptop>(
                  builder: (BuildContext context) => LaptopDetailsPage(
                        productId: productId,
                        productName: productName,
                        productImageUrls: productImageUrls,
                        prouductDescription: productDescription,
                      )));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: <BoxShadow>[
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
                        tag: productImageUrls[0].toString(),
                        child: Container(
                            height: 120.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        productImageUrls[0].toString()),
                                    fit: BoxFit.cover)))),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 15.0, left: 5.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (isFavorite)
                              Icon(Icons.favorite, color: hexToColor('#EF7532'))
                            else
                              const Icon(Icons.favorite_border,
                                  color: kHightlightTextColor)
                          ],
                        )),
                  ]),
                  const SizedBox(height: 15.0),
                  Text(productPrice,
                      style: const TextStyle(
                          color: kHightlightTextColor,
                          fontFamily: 'Varela',
                          fontSize: 16.0)),
                  Text(productName,
                      style: TextStyle(
                          color: hexToColor('#575E67'),
                          fontFamily: 'Varela',
                          fontSize: 16.0)),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Container(color: hexToColor('#EBEBEB'), height: 1.0)),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            if (!added) ...<Widget>[
                              const Icon(
                                Icons.shopping_basket,
                                color: kHightlightTextColor,
                                size: 20,
                              ),
                              const Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: kHightlightTextColor,
                                      fontSize: 18.0))
                            ],
                            if (added) ...<Widget>[
                              Icon(
                                Icons.remove_circle_outline,
                                color: hexToColor('#D17E50'),
                                size: 20,
                              ),
                              Text('3',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: hexToColor('#D17E50'),
                                      fontSize: 18.0)),
                              Icon(
                                Icons.add_circle_outline,
                                color: hexToColor('#D17E50'),
                                size: 20,
                              ),
                            ]
                          ]))
                ],
              ),
            )));
  }
}
