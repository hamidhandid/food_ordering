import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void show(String title, String message, {Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 5),
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: backgroundColor ?? Colors.green[700],
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
