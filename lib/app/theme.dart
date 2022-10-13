import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(

      appBarTheme: AppBarTheme(color: _themeColor),
      primaryColor: _themeColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: _themeColor,
        secondary: _themeColor, // Your accent color
      ),
      accentColor: _themeColor,
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.black,
              side: BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)))),
    );
  }

  static ThemeData dark() {
    return ThemeData(
        primaryColor: Colors.black,
        disabledColor: Colors.grey,
        brightness: Brightness.dark,
        accentColor: _themeColor,
        cardColor: Color(0xff373737),
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                primary: Colors.black,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),
        fontFamily: 'OpenSans');
  }

  static const Color _themeColor = Color(0xfff79f1f);

  static const Color _accentColor = Color(0xfff6e58d);
  static const Color _textBlack = Colors.black;

  static Color get textBlack => _textBlack;

  static Color get themeColor => _themeColor;
  static Color get accentColor => _accentColor;
}
