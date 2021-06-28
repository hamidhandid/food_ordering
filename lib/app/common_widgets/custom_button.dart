import 'package:alo_self/app/common_widgets/custom_radius_container.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonOnPressed,
    this.buttonText,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback buttonOnPressed;
  final String? buttonText;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      onPressed: buttonOnPressed,
      color: backgroundColor ?? Colors.green[800],
      child: Container(
        margin: EdgeInsets.all(15),
        child: Text(
          buttonText ?? 'Submit',
          style: TextStyle(
            fontSize: fontSize ?? 21,
            color: Colors.white,
            fontWeight: fontWeight ?? FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
