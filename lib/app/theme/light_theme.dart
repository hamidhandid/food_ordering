import 'package:alo_self/app/constants/fonts.dart';
import 'package:alo_self/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:get/get.dart';

class LightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: '4CAF50'.color,
        accentColor: '66BB6A'.color,
        backgroundColor: 'E8F5E9'.color,
        scaffoldBackgroundColor: 'F1F8E9'.color,
        fontFamily: Get.locale == Locale('en', 'US') ? Fonts.englishFont : Fonts.persianFont,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: '2E7D32'.color,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
