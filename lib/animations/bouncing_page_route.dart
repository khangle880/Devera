import 'package:flutter/material.dart';

class BouncingPageRoute extends PageRouteBuilder<BouncingPageRoute> {
  BouncingPageRoute({required this.widget})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.easeInOutQuint);

              return ScaleTransition(scale: animation, child: child);
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });

  final Widget widget;
}
