import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/home/home_page.dart';
import 'package:laptop/screens/login/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                body: Center(child: Text("Error ${snapshot.error}")));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Scaffold(
                        body: Center(
                            child: Text("Error ${snapshot.error}",
                                style: Constants.regularHeader)));
                  }

                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    User? _user = streamSnapshot.data;

                    if (_user == null) {
                      return LoginPage();
                    }

                    return HomePage();
                  }

                  return Scaffold(
                      body: Center(
                          child: Text("Checking Authentication...",
                              style: Constants.regularHeader)));
                });
          }

          return Scaffold(body: Center(child: Text("Fuck you")));
        });
  }
}
