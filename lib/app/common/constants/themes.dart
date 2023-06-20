import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData mainTheme = ThemeData(
  primaryColor: ConstColors.white,
  fontFamily: openSansRegular,
  // canvasColor: Colors.transparent,
  canvasColor: Colors.white,
  textTheme: const TextTheme(
    titleMedium: textStyleTextDefault,
    bodyMedium: textStyleTextDefault,
    bodyLarge: textStyleTextDefault,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(elevation: 0),
  ),
);
