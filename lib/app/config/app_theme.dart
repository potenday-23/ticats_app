import 'package:flutter/material.dart';
import 'package:ticats_app/gen/fonts.gen.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
    ),
    fontFamily: FontFamily.suit,
    scaffoldBackgroundColor: Colors.white,
  );
}
