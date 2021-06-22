import 'package:flutter/material.dart';

class CustomRaduisContainer extends StatelessWidget {
  const CustomRaduisContainer({
    Key? key,
    required this.child,
    required this.radius,
  }) : super(key: key);

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
