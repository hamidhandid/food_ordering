import 'package:flutter/material.dart';

class CustomForm {
  const CustomForm() : super();

  static void show(
    BuildContext context, {
    required String formTitle,
    required List<Widget> textFields,
    required VoidCallback buttonOnPressed,
    String? buttonText,
    bool showSubmitButton = true,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (int i = 0; i < textFields.length; i++)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textFields[i],
                        SizedBox(height: 15),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (showSubmitButton)
                    MaterialButton(
                      onPressed: buttonOnPressed,
                      color: Colors.greenAccent,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          buttonText ?? 'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
