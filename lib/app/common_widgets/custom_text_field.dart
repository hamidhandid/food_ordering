import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.controller, this.labelText, this.isMoney = false}) : super(key: key);

  final TextEditingController controller;
  final String? labelText;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[800],
        ),
        fillColor: Color.alphaBlend(
          Theme.of(context).primaryColor.withOpacity(.07),
          Colors.grey.withOpacity(.04),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        filled: true,
      ),
      keyboardType: isMoney ? TextInputType.number : null,
    );
  }
}
