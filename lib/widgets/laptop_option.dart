import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LaptopOption extends StatelessWidget {
  const LaptopOption({
    Key? key,
    required this.laptopDocument,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> laptopDocument;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          const SizedBox(
            width: 100,
            child: Text('CPU: ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.blue)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(laptopDocument['cpu'].toString(),
                style: const TextStyle(fontSize: 20.0)),
          )
        ],
      ),
      const SizedBox(height: 10.0),
      Row(
        children: <Widget>[
          const SizedBox(
            width: 100,
            child: Text('GPU0: ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.blue)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(laptopDocument['gpu0'].toString(),
                style: const TextStyle(fontSize: 20.0)),
          )
        ],
      ),
      const SizedBox(height: 10.0),
      Row(
        children: <Widget>[
          const SizedBox(
            width: 100,
            child: Text('GPU1: ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.blue)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(laptopDocument['gpu1'].toString(),
                style: const TextStyle(fontSize: 20.0)),
          )
        ],
      ),
      const SizedBox(height: 10.0),
      Row(
        children: <Widget>[
          const SizedBox(
            width: 100,
            child: Text('RAM: ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.blue)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(laptopDocument['ram'].toString(),
                style: const TextStyle(fontSize: 20.0)),
          )
        ],
      ),
    ]);
  }
}
