import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/services/firebase_services.dart';
import 'package:laptop/widgets/custom_input.dart';
import 'package:laptop/widgets/product_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  late String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (_searchString.isEmpty)
          const Center(
            child: Text(
              'Search Results',
              style: Constants.regularDarkText,
            ),
          )
        else
          FutureBuilder<QuerySnapshot<Object?>>(
            future: _firebaseServices.productRef
                .orderBy('search_string')
                .startAt([_searchString]).endAt(['$_searchString\uf8ff']).get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: const EdgeInsets.only(
                    top: 128.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs
                      .map((QueryDocumentSnapshot<Object?> document) {
                    return ProductCard(laptopDetail: document);
                  }).toList(),
                );
              }

              // Loading State
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
          ),
          child: CustomInput(
            hintText: 'Search here...',
            onSubmitted: (String value) {
              setState(() {
                _searchString = value.toLowerCase();
              });
            },
          ),
        ),
      ],
    );
  }
}
