import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.varelaTextTheme(Theme.of(context).textTheme),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          accentColor: hexToColor("#FF1E00")),
      home: LandingPage(),
    );
  }
}
