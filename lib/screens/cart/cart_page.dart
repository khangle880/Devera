import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/screens/home/components/laptop_details_page.dart';
import 'package:laptop/services/firebase_services.dart';
import 'package:laptop/widgets/custom_action_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomActionBar(
          title: 'Cart',
        ),
        body: FutureBuilder<QuerySnapshot<Object?>>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserID())
                .collection('Cart')
                .get(),
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
                child: ListView(
                  children: snapshot.data!.docs
                      .map((QueryDocumentSnapshot<Object?> document) {
                    final String productId = document.id.toString();
                    final String productName = document['name'].toString();
                    final String productPrice = document['price'].toString();
                    final String productImageUrl = document['image'] as String;
                    final int productAmount = document['amount'] as int;

                    return _buildCard(productId, productName, productPrice,
                        productImageUrl, productAmount, false, false, context);
                  }).toList(),
                ),
              );
            }));
  }

  Widget _buildCard(
      String productId,
      String productName,
      String productPrice,
      String productImageUrl,
      int productAmount,
      bool added,
      bool isFavorite,
      BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  productImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productName,
                    style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      productPrice,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'Amount: $productAmount',
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
