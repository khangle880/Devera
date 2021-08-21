import 'package:flutter/material.dart';

class QuickView extends StatefulWidget {
  const QuickView({Key? key}) : super(key: key);

  @override
  _QuickViewState createState() => _QuickViewState();
}

class _QuickViewState extends State<QuickView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Quick Here')));
  }
}
