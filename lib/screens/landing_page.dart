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
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder:
                (BuildContext context, AsyncSnapshot<User?> streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${streamSnapshot.error}'),
                  ),
                );
              }

              if (streamSnapshot.connectionState == ConnectionState.active) {
                // Get the user
                final User? _user = streamSnapshot.data;

                if (_user == null) {
                  return const LoginPage();
                } else {
                  return const HomePage();
                }
              }

              return const Scaffold(
                body: Center(
                  child: Text(
                    'Checking Authentication...',
                    style: Constants.regularHeader,
                  ),
                ),
              );
            },
          );
        }

        return const Scaffold(
          body: Center(
            child: Text(
              'Initialization App...',
              style: Constants.regularHeader,
            ),
          ),
        );
      },
    );
  }
}
