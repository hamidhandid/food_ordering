import 'package:alo_self/app/constants/fonts.dart';
import 'package:alo_self/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        fontFamily: Get.locale == Locale('en', 'US') ? Fonts.englishFont : Fonts.persianFont,
      );
}
