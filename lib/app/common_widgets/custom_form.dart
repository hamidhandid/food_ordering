import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomForm {
  const CustomForm() : super();

  static void show(
    BuildContext context, {
    required String formTitle,
    required List<Widget> textFields,
    required VoidCallback buttonOnPressed,
    String? buttonText,
    bool showSubmitButton = true,
    VoidCallback? deleteCallback,
    bool showTextFields = true,
    bool hasBackgroundColor = false,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Wrap(
          children: [
            SafeArea(
              child: Container(
                color: hasBackgroundColor ? Theme.of(context).backgroundColor : null,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (deleteCallback == null)
                        Text(
                          formTitle,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formTitle,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: deleteCallback,
                              icon: Icon(Icons.delete_outline, size: 35),
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      if (showTextFields)
                        for (int i = 0; i < textFields.length; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textFields[i],
                              SizedBox(height: 20),
                            ],
                          )
                      else
                        textFields[0],
                      SizedBox(height: 10),
                      if (showSubmitButton)
                        CustomButton(
                          buttonOnPressed: buttonOnPressed,
                          buttonText: buttonText,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
