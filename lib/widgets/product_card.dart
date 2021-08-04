import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/components/laptop_details_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.laptopDetail,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> laptopDetail;

  @override
  Widget build(BuildContext context) {
    final String _productId = laptopDetail.id;
    final String _productName = laptopDetail['name'] as String;
    final String _prouductDescription = laptopDetail['description'] as String;
    final int _productPrice = laptopDetail['minPrice'] as int;
    final List<dynamic> _productImageUrls =
        laptopDetail['images'] as List<dynamic>;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LaptopDetailsPage(
                    productId: _productId,
                    productName: _productName,
                    prouductDescription: _prouductDescription,
                    productImageUrls: _productImageUrls)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  _productImageUrls[0] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _productName,
                      style: Constants.regularHeader,
                    ),
                    Text(
                      '$_productPrice',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
