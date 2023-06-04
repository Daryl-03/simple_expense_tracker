import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    required this.fill,
  }) : super(key: key);

  final double fill;

  set fill(double value) {
    if (value < 0 || value > 1) {
      throw Exception("Fill must be between 0 and 1");
    }
    fill = value;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: fill,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(boxConstraints.maxWidth * 0.2),
              topRight: Radius.circular(boxConstraints.maxWidth * 0.2),
            ),
          ),
        ),
      );
    });
  }
}
