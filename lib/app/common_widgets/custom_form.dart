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
      builder: (context) => Wrap(
        children: [
          SafeArea(
            child: Container(
              // color: Theme.of(context).backgroundColor.withOpacity(0.5),
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
                          fontSize: 20,
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
                    for (int i = 0; i < textFields.length; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textFields[i],
                          SizedBox(height: 20),
                        ],
                      ),
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
    );
  }
}
