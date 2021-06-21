import 'package:flutter/material.dart';

abstract class CustomTheme {
  ThemeData get themeData;
}

extension Colorizer on String {
  Color get color => Color(int.parse("0xFF$this"));
}
