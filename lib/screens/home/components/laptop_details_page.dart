import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/widgets/custom_action_bar.dart';
import 'package:laptop/widgets/image_swiper.dart';
import 'package:laptop/widgets/select_laptop_option.dart';

class LaptopDetailsPage extends StatefulWidget {
  const LaptopDetailsPage({
    Key? key,
    required this.productId,
    required this.productName,
    required this.prouductDescription,
    required this.productImageUrls,
  }) : super(key: key);

  final String productId;
  final String productName;
  final String prouductDescription;
  final List<dynamic> productImageUrls;

  @override
  _LaptopDetailsPageState createState() => _LaptopDetailsPageState();
}

class _LaptopDetailsPageState extends State<LaptopDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference<Object> _productRef = FirebaseFirestore.instance
        .collection('ProductBranch')
        .doc('Apple')
        .collection('Products')
        .doc(widget.productId)
        .collection('Product_Detail');

    return Scaffold(
        backgroundColor: hexToColor('#F4F9F9'),
        body: Stack(children: <Widget>[
          ListView(padding: const EdgeInsets.all(0), children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                  height: 350,
                  child: ImageSwiper(listImage: widget.productImageUrls)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Text(widget.productName, style: Constants.boldHeading),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Text(widget.prouductDescription,
                  style: const TextStyle(fontSize: 18)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Text('Select Option', style: Constants.regularDarkText),
            ),
            SizedBox(
              child: FutureBuilder<QuerySnapshot<Object?>>(
                  future: _productRef.orderBy('price').get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SelectLaptopOption(snapshotData: snapshot));
                  }),
            )
          ]),
          Positioned(
            bottom: 40,
            child: SizedBox(
              width: 400,
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        color: hexToColor('#F4F9F9'),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.favorite_outline,
                          color: hexToColor('#EF7532'), size: 40)),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      height: 65.0,
                      margin: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Add to cart',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                )
              ]),
            ),
          ),
          const CustomActionBar(
            hasTitle: false,
            hasBackground: false,
          ),
        ]));
  }
}
