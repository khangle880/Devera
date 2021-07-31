import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:laptop/constants.dart';

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
    return Container(
        decoration: BoxDecoration(gradient: null),
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
            Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: const Text('0',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)))
          ],
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}
