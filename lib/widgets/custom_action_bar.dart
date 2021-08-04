import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:laptop/constants.dart';
import 'package:laptop/screens/cart/cart_page.dart';
import 'package:laptop/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomActionBar({
    Key? key,
    this.title = '',
    this.hasBackArrow = true,
    this.hasTitle = true,
    this.hasBackground = true,
  }) : super(key: key);

  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    final FirebaseServices _firebaseService = FirebaseServices();

    final CollectionReference<Object> _usersRef =
        FirebaseFirestore.instance.collection('Users');

    return Container(
        decoration: BoxDecoration(
            gradient: hasBackground
                ? LinearGradient(
                    colors: <Color>[
                      hexToColor('#262A53'),
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null),
        padding: const EdgeInsets.only(
            top: 80.0, bottom: 24.0, left: 24.0, right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (hasBackArrow)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/icons/arrow_back.svg',
                        color: Colors.white)),
              ),
            if (hasTitle)
              Text(
                title,
                style: Constants.boldHeading,
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartPage()));
              },
              child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                      stream: _usersRef
                          .doc(_firebaseService.getUserID())
                          .collection('Cart')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                        late int _totalItems = 0;

                        if (snapshot.hasError) {
                          return const Text('N/A');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('N/A');
                        }

                        _totalItems = snapshot.data!.docs.length;

                        return Text(_totalItems.toString(),
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white));
                      })),
            )
          ],
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}
