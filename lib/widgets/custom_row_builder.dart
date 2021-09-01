import 'package:flutter/material.dart';

class CustomRowBuilder extends StatelessWidget {
  const CustomRowBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: this.crossAxisAlignment,
      mainAxisSize: this.mainAxisSize,
      mainAxisAlignment: this.mainAxisAlignment,
      verticalDirection: this.verticalDirection,
      children: List.generate(
          this.itemCount, (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}
