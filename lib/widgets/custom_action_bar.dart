import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:laptop/constants.dart';

class CustomActionBar extends StatelessWidget {
  const CustomActionBar({
    Key? key,
    required this.title,
    this.hasBackArrow = true,
    this.hasTitle = true,
  }) : super(key: key);

  final String title;
  final bool hasBackArrow;
  final bool hasTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange,
                Colors.white.withOpacity(0.5),
              ],
            )),
            padding: const EdgeInsets.only(
                top: 80.0, bottom: 24.0, left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hasBackArrow)
                  Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0)),
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/icons/arrow_back.svg",
                          color: Colors.white)),
                if (hasTitle)
                  Text(
                    title,
                    style: Constants.boldHeading,
                  ),
                Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    alignment: Alignment.center,
                    child: const Text("0",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)))
              ],
            )));
  }
}
