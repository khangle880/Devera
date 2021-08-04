import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference<Object> productRef = FirebaseFirestore.instance
      .collection('ProductBranch')
      .doc('Apple')
      .collection('Products');

  final CollectionReference<Object> usersRef =
      FirebaseFirestore.instance.collection('Users');
}
